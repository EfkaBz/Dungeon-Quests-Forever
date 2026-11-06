local _, ns = ...
local L = ns.L
local QI = {}
ns.QuestInfo = QI
ns:RegisterModule(QI)

-- Everything the journal shows about a quest, built from the guide steps
-- (who gives it, where it is turned in), the game (title, objectives,
-- rewards when it is known) and Questie (level, classes, chain, XP).

----------------------------------------------------------------------
-- Rewards: live data first, then what was learned, then the offline table
----------------------------------------------------------------------
-- steps without quest listed under a negative pseudo ID (see QI.DungeonQuests)
local pseudoSteps, lastPseudo = {}, 0

local function Try(fn, ...)
    if not fn then return end
    local r = { pcall(fn, ...) }
    if r[1] then return select(2, unpack(r)) end
end
local function ItemID(link) return link and tonumber(link:match("item:(%d+)")) end

-- Reads the reward lists with the given functions ("reward"/"choice" links)
local function ReadRewards(numRewards, numChoices, linkFn, money, xp)
    local r = { items = {}, choice = {}, money = money, xp = xp }
    for i = 1, numRewards or 0 do
        local id = ItemID(Try(linkFn, "reward", i))
        if id then r.items[#r.items + 1] = id end
    end
    for i = 1, numChoices or 0 do
        local id = ItemID(Try(linkFn, "choice", i))
        if id then r.choice[#r.choice + 1] = id end
    end
    return r
end

local function Learn(q, r)
    if not (q and q > 0 and r) then return end
    if #r.items == 0 and #r.choice == 0 and not r.money and not r.xp then return end
    DQF_Cache.rewards[q] = r
end

-- Quest in the log: read its rewards (and remember them)
local function LogRewards(q)
    local i = ns.Progress.LogIndex(q)
    if not i then return end
    local restore = ns.Progress.SelectInLog(q)
    local ok, r = pcall(function()
        local money = Try(GetQuestLogRewardMoney, q) or Try(GetQuestLogRewardMoney)
        local xp = Try(GetQuestLogRewardXP, q) or Try(GetQuestLogRewardXP)
        return ReadRewards(Try(GetNumQuestLogRewards, q) or Try(GetNumQuestLogRewards),
            Try(GetNumQuestLogChoices, q) or Try(GetNumQuestLogChoices),
            function(kind, n) return GetQuestLogItemLink(kind, n) end,
            (money and money > 0) and money or nil, (xp and xp > 0) and xp or nil)
    end)
    restore()
    if ok then Learn(q, r) return r end
end

-- Quest window (offered / completing): remember what it shows
local function WindowRewards()
    local q = GetQuestID and GetQuestID()
    if not q or q == 0 then return end
    local money, xp = Try(GetRewardMoney), Try(GetRewardXP)
    Learn(q, ReadRewards(Try(GetNumQuestRewards), Try(GetNumQuestChoices),
        function(kind, n) return GetQuestItemLink(kind, n) end,
        (money and money > 0) and money or nil, (xp and xp > 0) and xp or nil))
end

-- { items = {ids}, choice = {ids}, money, xp, possible = bool }
-- possible = true when only the offline list is known (fixed and choice mixed)
function QI.Rewards(q)
    local ps = pseudoSteps[q]
    if ps then -- item step: the item it gives
        return { items = ps.haveItems and { ps.haveItems[1] } or {}, choice = {} }
    end
    local r = LogRewards(q) or DQF_Cache.rewards[q]
    local out = { items = {}, choice = {} }
    if r then
        out.items, out.choice, out.money, out.xp = r.items or {}, r.choice or {}, r.money, r.xp
    elseif ns.QUEST_REWARDS and ns.QUEST_REWARDS[q] then
        out.items, out.possible = ns.QUEST_REWARDS[q], true
    end
    out.xp = out.xp or (ns.Questie and ns.Questie.RewardXP(q))
    out.money = out.money or (ns.Questie and ns.Questie.RewardMoney(q))
    return out
end

----------------------------------------------------------------------
-- Titles, classes
----------------------------------------------------------------------
local requested = {}
function QI.Title(q, d)
    if pseudoSteps[q] then return ns.StepTitle(pseudoSteps[q], d) end
    if ns.ClientLangMatches() then
        local t = C_QuestLog and C_QuestLog.GetQuestInfo and Try(C_QuestLog.GetQuestInfo, q)
        if t and t ~= "" then return t end
        -- unknown to the client yet: ask the server (QUEST_DATA_LOAD_RESULT refreshes)
        if not requested[q] and C_QuestLog and C_QuestLog.RequestLoadQuestByID then
            requested[q] = true
            Try(C_QuestLog.RequestLoadQuestByID, q)
        end
    end
    if d and d.titles and d.titles[q] then return d.titles[q] end
    for _, dd in pairs(ns.dungeons) do
        if dd.titles and dd.titles[q] then return dd.titles[q] end
    end
    return (ns.QUEST_NAMES and ns.QUEST_NAMES[q]) or (ns.Questie and ns.Questie.QuestName(q)) or ("Quest " .. q)
end

-- class bitmask -> { {file = "PALADIN", name = "Paladin"}, ... }
function QI.Classes(mask)
    if not mask then return end
    local out = {}
    for id = 1, 12 do
        if bit.band(mask, bit.lshift(1, id - 1)) ~= 0 then
            local name, file = GetClassInfo(id)
            if file then out[#out + 1] = { file = file, name = name } end
        end
    end
    -- every class allowed = no restriction
    if #out == 0 or #out >= 9 then return end
    return out
end

function QI.ClassIcon(file, size)
    local c = CLASS_ICON_TCOORDS and CLASS_ICON_TCOORDS[file]
    if not c then return "" end
    return ("|TInterface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes:%d:%d:0:0:256:256:%d:%d:%d:%d|t")
        :format(size or 14, size or 14, c[1] * 256, c[2] * 256, c[3] * 256, c[4] * 256)
end

----------------------------------------------------------------------
-- Quests of a dungeon
----------------------------------------------------------------------
local function IsDungeonMap(map)
    local info = map and C_Map.GetMapInfo(map)
    return info and Enum and Enum.UIMapType and info.mapType == Enum.UIMapType.Dungeon
end

-- Builds the quest list of a dungeon once: one entry per quest with its
-- steps. faction = nil (both), "Alliance" or "Horde".
-- Steps without quest (quest = 0, e.g. a book to pick up) are listed too,
-- each under a negative pseudo ID (QI.IsItemStep): title, state and reward
-- come from the step itself.
function QI.IsItemStep(q) return type(q) == "number" and q < 0 end
function QI.ItemStep(q) return pseudoSteps[q] end

function QI.DungeonQuests(d)
    if d.questList then return d.questList end
    local list, byQ = {}, {}
    for _, s in ipairs(d.steps) do
        local q = s.quest
        if q == 0 then
            if not s.pseudo then
                lastPseudo = lastPseudo - 1
                s.pseudo = lastPseudo
                pseudoSteps[s.pseudo] = s
            end
            local e = { quest = s.pseudo, steps = { s }, faction = s.faction or d.faction, dungeon = d,
                accept = s, itemStep = s, inside = false }
            byQ[s.pseudo] = e
            list[#list + 1] = e
        elseif q and q > 0 then
            local e = byQ[q]
            if not e then
                e = { quest = q, steps = {}, faction = s.faction or d.faction, dungeon = d }
                byQ[q] = e
                list[#list + 1] = e
            elseif e.faction and (s.faction or d.faction) ~= e.faction then
                e.faction = nil -- same quest for both factions
            end
            e.steps[#e.steps + 1] = s
            if s.type == "accept" and not e.accept then e.accept = s end
            if s.type == "turnin" then e.turnin = s end
            if s.class then e.class = s.class end
        end
    end
    for _, e in ipairs(list) do
        local s = not e.itemStep and e.accept
        local npc = s and ns.StepNPC(s)
        -- starts inside the dungeon: item dropped there, or quest giver inside
        if e.itemStep then e.inside = false
        else e.inside = s and (s.inside or (not npc and s.targets ~= nil) or (npc and IsDungeonMap(npc.map))) and true or false end
    end
    d.questList, d.questByID = list, byQ
    return list
end

-- Quests visible for a faction filter ("Alliance", "Horde" or nil = all)
function QI.VisibleQuests(d, faction)
    local out = {}
    local _, class = UnitClass("player")
    for _, e in ipairs(QI.DungeonQuests(d)) do
        if (not faction or not e.faction or e.faction == faction) and (not e.class or e.class == class) then
            out[#out + 1] = e
        end
    end
    return out
end

-- 0 none, 1 in log, 2 ready, 3 done
function QI.State(q)
    local s = pseudoSteps[q]
    if s then return s.done and 3 or 0 end
    return ns.Progress.QuestState(q)
end

----------------------------------------------------------------------
-- Chain: earlier quests (Questie prerequisites) and later ones (guide
-- quests that need this one), oldest first
----------------------------------------------------------------------
-- Quest before q: Questie, then the chains of the Forever quests it does not know
local function Previous(q)
    local pre = ns.Questie and ns.Questie.Prerequisites(q)
    return (pre and pre[1]) or (ns.QUEST_PREVIOUS and ns.QUEST_PREVIOUS[q])
end

local followers
local function Followers()
    if followers then return followers end
    local t = {}
    for q, pre in pairs(ns.QUEST_PREVIOUS or {}) do
        t[pre] = t[pre] or {}
        if not tContains(t[pre], q) then table.insert(t[pre], q) end
    end
    local fromQuestie = false
    for _, d in pairs(ns.dungeons) do
        for _, s in ipairs(d.steps) do
            for _, pre in ipairs((ns.Questie and ns.Questie.Prerequisites(s.quest)) or {}) do
                fromQuestie = true
                t[pre] = t[pre] or {}
                if not tContains(t[pre], s.quest) then table.insert(t[pre], s.quest) end
            end
        end
    end
    -- Questie may not be ready yet: keep the list only once it has answered
    if fromQuestie then followers = t end
    return t
end

-- First quest of the chain of q, and how many quests come before q
function QI.ChainRoot(q)
    local seen, depth = { [q] = true }, 0
    for _ = 1, 30 do
        local p = Previous(q)
        if not p or seen[p] then break end
        seen[p] = true
        q, depth = p, depth + 1
    end
    return q, depth
end

function QI.Chain(q)
    if pseudoSteps[q] then return { q } end
    local before, seen = {}, { [q] = true }
    local cur = q
    for _ = 1, 15 do
        local p = Previous(cur)
        if not p or seen[p] then break end
        seen[p] = true
        table.insert(before, 1, p)
        cur = p
    end
    local chain = before
    chain[#chain + 1] = q
    cur = q
    for _ = 1, 15 do
        local f = Followers()[cur]
        local n = f and f[1]
        if not n or seen[n] then break end
        seen[n] = true
        chain[#chain + 1] = n
        cur = n
    end
    return chain
end

-- Where a quest of the guides is given / turned in: guide step, dungeon
function QI.FindStep(q, kind)
    for _, key in ipairs(ns.dungeonOrder) do
        local d = ns.dungeons[key]
        for _, s in ipairs(d.steps) do
            if s.quest == q and s.type == kind then return s, d end
        end
    end
end

----------------------------------------------------------------------
function QI:Init()
    ns:On("QUEST_DETAIL", WindowRewards)
    ns:On("QUEST_COMPLETE", WindowRewards)
    ns:On("QUEST_DATA_LOAD_RESULT", function() if ns.Journal then ns.Journal:OnUpdate() end end)
end
