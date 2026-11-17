local _, ns = ...
local P = {}
ns.Progress = P

local function Flagged(q)
    if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
        return C_QuestLog.IsQuestFlaggedCompleted(q)
    end
    return IsQuestFlaggedCompleted and IsQuestFlaggedCompleted(q)
end

----------------------------------------------------------------------
-- Finding a guide quest in the quest log
-- 1. by its ID, with every API (the old GetQuestLogIndexByID misses the
--    quests under a collapsed header, so the whole log is read too);
-- 2. else by its title: the quest in the log may have another ID than the
--    guide (Forever IDs, class or faction variants). The real ID is kept
--    (DQF_DB.questAlias) so accept, objectives and turn-in all use it.
--    A log quest that is itself a step of the player's guides is never
--    borrowed (chains whose quests share one title, e.g. Defias Brotherhood).
----------------------------------------------------------------------
local function Try(fn, ...)
    if not fn then return end
    local ok, a = pcall(fn, ...)
    if ok then return a end
end

local function Norm(s)
    if type(s) ~= "string" then return end
    s = s:lower():gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("[%p%s]", "")
    return s ~= "" and s or nil
end

-- every quest of the log: { {index, id, title, norm}, ... } (read once per frame)
local logList, logStamp
local function ScanLog()
    local now = GetTime()
    if logList and logStamp == now then return logList end
    local t = {}
    if C_QuestLog and C_QuestLog.GetNumQuestLogEntries and C_QuestLog.GetInfo then
        for i = 1, Try(C_QuestLog.GetNumQuestLogEntries) or 0 do
            local info = Try(C_QuestLog.GetInfo, i)
            if info and not info.isHeader and info.questID and info.questID > 0 then
                t[#t + 1] = { index = i, id = info.questID, title = info.title, norm = Norm(info.title) }
            end
        end
    end
    if #t == 0 and GetNumQuestLogEntries and GetQuestLogTitle then
        for i = 1, (GetNumQuestLogEntries()) or 0 do
            local title, _, _, isHeader, _, _, _, id = GetQuestLogTitle(i)
            if title and not isHeader and id and id > 0 then
                t[#t + 1] = { index = i, id = id, title = title, norm = Norm(title) }
            end
        end
    end
    logList, logStamp = t, now
    return t
end

local function RawIndex(q)
    local i = Try(GetQuestLogIndexByID, q)
    if i and i > 0 then return i end
    i = Try(C_QuestLog and C_QuestLog.GetLogIndexForQuestID, q)
    if i and i > 0 then return i end
    for _, e in ipairs(ScanLog()) do
        if e.id == q then return e.index end
    end
end

local function Aliases()
    if not DQF_DB then return {} end
    DQF_DB.questAlias = DQF_DB.questAlias or {}
    return DQF_DB.questAlias
end

-- quest IDs that have a step this character can see (rebuilt when needed)
local mine
local function MyGuideQuests()
    if mine then return mine end
    local faction = UnitFactionGroup("player")
    local _, class = UnitClass("player")
    local t, any = {}, false
    for _, d in pairs(ns.dungeons or {}) do
        for _, s in ipairs(d.steps or {}) do
            any = true
            if type(s.quest) == "number" and s.quest > 0 and not s.doneBy
                and (not s.faction or s.faction == faction) and (not s.class or s.class == class) then
                t[s.quest] = true
            end
        end
    end
    if any and faction then mine = t end
    return t
end

local function GuideTitles(q)
    local out = {}
    local t = Try(C_QuestLog and C_QuestLog.GetTitleForQuestID, q)
    if t then out[#out + 1] = Norm(t) end
    for _, d in pairs(ns.dungeons or {}) do
        if d.titles and d.titles[q] then out[#out + 1] = Norm(d.titles[q]) end
    end
    if ns.QUEST_NAMES and ns.QUEST_NAMES[q] then out[#out + 1] = Norm(ns.QUEST_NAMES[q]) end
    return out
end

local resolved, resolvedStamp = {}, nil
-- the quest ID the game really uses for the guide quest q
function P.Resolve(q)
    if type(q) ~= "number" or q <= 0 then return q end
    local now = GetTime()
    if resolvedStamp ~= now then resolved, resolvedStamp = {}, now end
    if resolved[q] then return resolved[q] end
    local r = q
    if not RawIndex(q) then
        local alias = Aliases()[q]
        if alias and RawIndex(alias) then
            r = alias
        else
            local found
            local names = GuideTitles(q)
            if #names > 0 then
                local own = MyGuideQuests()
                for _, e in ipairs(ScanLog()) do
                    if e.norm and not own[e.id] then
                        for _, n in ipairs(names) do
                            if n == e.norm then found = e.id break end
                        end
                    end
                    if found then break end
                end
            end
            if found then
                Aliases()[q] = found
                r = found
            elseif alias then
                r = alias -- turned in since: keep checking the real ID
            end
        end
    end
    resolved[q] = r
    return r
end

function P.LogIndex(q)
    return RawIndex(P.Resolve(q))
end

-- Forever runs on the retail engine: the old quest log functions (GetQuestLogTitle,
-- SelectQuestLogEntry...) only exist when another addon, like Questie, adds them back.
-- Selects a quest of the log; call the returned function to put the old selection back.
function P.SelectInLog(q)
    local i = P.LogIndex(q)
    if i and SelectQuestLogEntry then
        local prev = GetQuestLogSelection and GetQuestLogSelection()
        SelectQuestLogEntry(i)
        return function() SelectQuestLogEntry(prev or 0) end
    end
    if i and C_QuestLog and C_QuestLog.SetSelectedQuest then
        local prev = C_QuestLog.GetSelectedQuest and C_QuestLog.GetSelectedQuest()
        C_QuestLog.SetSelectedQuest(P.Resolve(q))
        return function() C_QuestLog.SetSelectedQuest(prev or 0) end
    end
    return function() end
end

-- Followers: quests that require q (built from Questie's prerequisites for
-- every guide quest). If a follower is done or in the log, q is done too.
local followers
local function Followers()
    if followers then return followers end
    if not (ns.Questie and ns.Questie.Prerequisites) then return {} end
    local t, any = {}, false
    for _, d in pairs(ns.dungeons) do
        for _, s in ipairs(d.steps) do
            for _, pre in ipairs(ns.Questie.Prerequisites(s.quest) or {}) do
                t[pre] = t[pre] or {}
                t[pre][s.quest] = true
                any = true
            end
        end
    end
    followers = t
    -- Questie may not be ready yet: rebuild a little later (not on every
    -- call, the full scan is too slow to repeat)
    if not any then C_Timer.After(5, function() followers = nil end) end
    return t
end

-- Turned in (flagged by the server, or implied by a later quest of the chain)
function P.IsCompleted(q, depth)
    if Flagged(q) then return true end
    local alias = Aliases()[q]
    if alias and Flagged(alias) then return true end
    depth = depth or 0
    if depth > 6 then return false end
    for f in pairs(Followers()[q] or {}) do
        if P.LogIndex(f) or P.IsCompleted(f, depth + 1) then return true end
    end
    return false
end

function P.ObjectivesDone(q)
    local i = P.LogIndex(q)
    if not i then return false end
    if C_QuestLog and C_QuestLog.IsComplete then
        local ok, done = pcall(C_QuestLog.IsComplete, P.Resolve(q))
        if ok and done then return true end
    end
    -- Classic: GetQuestLogTitle -> title, level, tag, isHeader, isCollapsed, isComplete, ...
    if GetQuestLogTitle then
        local isComplete = select(6, GetQuestLogTitle(i))
        if isComplete == 1 or isComplete == true then return true end
    end
    -- fallback: every objective finished
    local objectives = P.Objectives(q)
    if not objectives or #objectives == 0 then return false end
    for _, o in ipairs(objectives) do
        if not o.done then return false end
    end
    return true
end

-- Quest log objectives: { {text=, done=}, ... } or nil when not in log
function P.Objectives(q)
    local i = P.LogIndex(q)
    if not i then return end
    local t = {}
    if GetNumQuestLeaderBoards and GetQuestLogLeaderBoard then
        for j = 1, GetNumQuestLeaderBoards(i) or 0 do
            local text, _, finished = GetQuestLogLeaderBoard(j, i)
            if text then t[#t + 1] = { text = text, done = finished } end
        end
    elseif C_QuestLog and C_QuestLog.GetQuestObjectives then
        for _, o in ipairs(C_QuestLog.GetQuestObjectives(P.Resolve(q)) or {}) do
            if o.text then t[#t + 1] = { text = o.text, done = o.finished } end
        end
    end
    return t
end

-- 0 = nothing, 1 = in log, 2 = objectives done, 3 = turned in
function P.QuestState(q)
    if P.IsCompleted(q) then return 3 end
    if P.LogIndex(q) then return P.ObjectivesDone(q) and 2 or 1 end
    return 0
end

-- Automatic detection. A step is done when:
--  accept : quest in log or already turned in
--  do     : objectives complete or turned in
--  talk / turnin : quest turned in
function P.IsAutoDone(step)
    -- steps without quest (quest = 0): done when one of `haveItems` is in the bags
    if not step.quest or step.quest == 0 then
        local count = (C_Item and C_Item.GetItemCount) or GetItemCount
        -- items seen once stay validated (the tome is used up by the summon)
        DQF_DB.seenItems = DQF_DB.seenItems or {}
        for _, id in ipairs(step.haveItems or {}) do
            if DQF_DB.seenItems[id] then return true end
            local ok, c = pcall(count, id)
            if ok and c and c > 0 then DQF_DB.seenItems[id] = true; return true end
        end
        return false
    end
    -- "pick one of these quests": any of `doneBy` counts as this one
    for _, q in ipairs(step.doneBy or {}) do
        if P.IsAutoDone({ type = step.type, quest = q, objIndex = step.objIndex }) then return true end
    end
    local st = P.QuestState(step.quest)
    if st == 3 then return true end
    if step.type == "accept" then return st >= 1 end
    if step.type == "do" then
        if st == 2 then return true end
        -- only one objective of the quest (e.g. one boss per Scarlet Monastery wing)
        if st == 1 and step.objIndex then
            local objective = (P.Objectives(step.quest) or {})[step.objIndex]
            return objective and objective.done and true or false
        end
    end
    return false
end

local function Manual(key)
    DQF_DB.manual[key] = DQF_DB.manual[key] or {}
    return DQF_DB.manual[key]
end

-- value: true = forced done, false = forced not done (overrides auto), nil = auto
function P.SetManual(d, uid, value)
    Manual(d.key)[uid] = value
end

-- "Go back to this step" (pos = position in the filtered list)
function P.GoToStep(d, pos)
    local manual = Manual(d.key)
    for i, s in ipairs(d.list) do manual[s.uid] = i < pos end
end

-- A quest event releases "forced not done" overrides of that quest,
-- so automatic detection takes over again after going back.
function P.ReleaseQuest(questID)
    if not questID then return end
    for key, manual in pairs(DQF_DB.manual) do
        local d = ns.dungeons[key]
        if d then
            for _, s in ipairs(d.steps) do
                if s.quest == questID and manual[s.uid] == false then manual[s.uid] = nil end
            end
        end
    end
end

-- Full scan: drop every "unchecked by hand" override so all quests already
-- done (turned in, in the log, objectives complete) validate their steps.
function P.Scan(verbose)
    for _, manual in pairs(DQF_DB.manual) do
        for uid, v in pairs(manual) do
            if v == false then manual[uid] = nil end
        end
    end
    ns.Update(true)
    if verbose and ns.state then
        DEFAULT_CHAT_FRAME:AddMessage(("|cff33ff99DQF|r : " .. ns.L("%d/%d étapes déjà faites.", "%d/%d steps already done."))
            :format(ns.state.done, ns.state.total))
    end
end

-- Builds d.list (filtered steps) and returns done, total, current position
function P.Evaluate(d)
    local manual = Manual(d.key)
    local done, cur = 0, nil
    d.list = {}
    local faction = UnitFactionGroup("player")
    local _, class = UnitClass("player")
    for _, s in ipairs(d.steps) do
      -- steps of the other faction or another class are never shown (they cannot
      -- be done); quests started by a random drop only once they are started
      if (not s.faction or s.faction == faction) and (not s.class or s.class == class)
          and (not s.onlyIfStarted or manual[s.uid] ~= nil or P.QuestState(s.quest) > 0) then
        s.auto = P.IsAutoDone(s)
        -- a quest already turned in always validates its steps, even if they
        -- were unchecked by hand earlier
        if manual[s.uid] == false and P.IsCompleted(s.quest) then manual[s.uid] = nil end
        s.done = manual[s.uid] == true or (manual[s.uid] ~= false and s.auto)
        d.list[#d.list + 1] = s
        s.pos = #d.list
        if s.done then done = done + 1
        elseif not cur then cur = s.pos end
      end
    end
    return done, #d.list, cur
end
