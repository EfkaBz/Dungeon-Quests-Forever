local ADDON, ns = ...
ns.VERSION = "0.3.27"
ns.dungeons, ns.dungeonOrder, ns.NPCS = {}, {}, {}
-- Language functions (ns.L, ns.Lang, ns.IsFR...) live in Core\Locale.lua.
-- Saved variables are only available after ADDON_LOADED, so every text
-- built at load time is created in ns.BuildLocalized() (see below).
local L = ns.L

local DEFAULTS = {
    lang = "auto",
    autoQuest = true, autoRewards = false, autoFlight = false, skipGossip = true,
    shown = true, arrowShown = true, minimapShown = true, minimapAngle = 200,
    targetsShown = true, mapPins = true, minimapPins = true,
    hideDone = false, autoFollow = true, locked = false,
    scale = 1, alpha = 1, theme = "blizzard", -- new installs start with the game look
    manual = {},
    -- journal window, map and group features
    journal = {}, hiddenDungeons = {}, lootFilter = {},
    entrancePins = false, dungeonWorldMap = true, autoRoute = true, versionCheck = true,
}

-- Account-wide data learned while playing (shared by all characters):
-- quest rewards seen in the quest log / quest window, boss positions and
-- portraits, dungeon map IDs.
local CACHE_DEFAULTS = { rewards = {}, bossPos = {}, maps = {}, instances = {} }

----------------------------------------------------------------------
-- Event bus
----------------------------------------------------------------------
local handlers, bus = {}, CreateFrame("Frame")
function ns:On(event, fn)
    if not handlers[event] then
        handlers[event] = {}
        bus:RegisterEvent(event)
    end
    table.insert(handlers[event], fn)
end
bus:SetScript("OnEvent", function(_, event, ...)
    for _, fn in ipairs(handlers[event]) do fn(...) end
end)

----------------------------------------------------------------------
-- Step constructors used by Data files (short commands)
----------------------------------------------------------------------
local function Make(kind, quest, npcKey, text, opts)
    local s = opts or {}
    -- keep a `text` given in opts (steps without NPC, e.g. quests started by an item)
    s.type, s.quest, s.npcKey, s.text = kind, quest, npcKey, text or s.text
    return s
end
function ns.Accept(q, npcKey, opts) return Make("accept", q, npcKey, nil, opts) end
function ns.TurnIn(q, npcKey, opts) return Make("turnin", q, npcKey, nil, opts) end
function ns.Talk(q, npcKey, text, opts) return Make("talk", q, npcKey, text, opts) end
function ns.Do(q, text, opts) return Make("do", q, nil, text, opts) end
-- Item APIs: globals on older clients, C_Item on Forever
local CI = C_Item or {}
ns.GetItemCount = CI.GetItemCount or GetItemCount
ns.GetItemInfo = CI.GetItemInfo or GetItemInfo

-- Quality color (r, g, b): C_Item on Forever, global on older clients,
-- the ITEM_QUALITY_COLORS table as a last resort
function ns.QualityColor(quality)
    quality = quality or 1
    local fn = CI.GetItemQualityColor or GetItemQualityColor
    if fn then
        local ok, r, g, b = pcall(fn, quality)
        if ok and r then return r, g, b end
    end
    local c = ITEM_QUALITY_COLORS and ITEM_QUALITY_COLORS[quality]
    if c then return c.r, c.g, c.b end
    return 1, 1, 1
end

-- data can be a table or a function returning it (built after the
-- language is known)
local builders = {}
function ns:RegisterDungeon(key, data)
    table.insert(builders, { key, data })
end

-- Placeholder for a dungeon not open on Forever yet: listed in the menu as
-- "coming soon", its guide file is ready to be filled in.
function ns:ComingSoon(key, fr, en, levels, opts)
    self:RegisterDungeon(key, function()
        local d = { name = ns.L(fr, en), levels = levels, comingSoon = true, steps = {},
            icon = "Interface\\Icons\\INV_Misc_QuestionMark" }
        for k, v in pairs(opts or {}) do d[k] = v end
        return d
    end)
end

-- Steps added later to a guide (Guides\QuestUpdates.lua). They get their own
-- uid, so the checks saved for the original steps stay on the right steps.
--   fn() returns { titles = {...}, groups = { { before = questID or nil, steps = {...} }, ... } }
local guidePatches = {}
function ns:AddGuideSteps(key, fn)
    guidePatches[key] = guidePatches[key] or {}
    table.insert(guidePatches[key], fn)
end

local function ApplyPatches(key, data)
    for _, fn in ipairs(guidePatches[key] or {}) do
        local p = fn()
        data.titles = data.titles or {}
        for q, t in pairs(p.titles or {}) do
            if data.titles[q] == nil then data.titles[q] = t end
        end
        local used = {}
        for _, g in ipairs(p.groups or {}) do
            -- steps of these quests move before g.before and keep their uid
            local moved = {}
            if g.move then
                local want = {}
                for _, q in ipairs(g.move) do want[q] = true end
                for i = #data.steps, 1, -1 do
                    if want[data.steps[i].quest] then
                        table.insert(moved, 1, table.remove(data.steps, i))
                    end
                end
            end
            local pos = #data.steps + 1
            if g.before then
                for i, s in ipairs(data.steps) do
                    if s.quest == g.before then pos = i break end
                end
            end
            for _, s in ipairs(moved) do
                table.insert(data.steps, pos, s)
                pos = pos + 1
            end
            for _, s in ipairs(g.steps or {}) do
                local id = s.type .. ":" .. s.quest
                used[id] = (used[id] or 0) + 1
                s.uid = id .. ":" .. used[id]
                table.insert(data.steps, pos, s)
                pos = pos + 1
            end
        end
    end
end

local function BuildDungeon(key, data)
    if type(data) == "function" then data = data() end
    data.key = key
    for i, s in ipairs(data.steps) do s.uid = i end
    ApplyPatches(key, data)
    ns.dungeons[key] = data
    table.insert(ns.dungeonOrder, key)
end

-- Bosses and loot (Data\Bosses\*.lua): attached to the dungeon as d.bossInfo
-- = { instance, area, bosses = { {name, npc, level, display, rare, extra, loot} }, trash }
local bossData = {}
function ns:RegisterBosses(key, data) bossData[key] = data end

-- Boss data added later (Data\BossUpdates.lua): loot added to the boss of that
-- name, unknown bosses created at the end of the list (the saved data of a boss
-- is keyed on its position). Names are sorted: pairs() has no fixed order.
local function MergeBossUpdates(key, info)
    local function Add(list, ids)
        local have = {}
        for _, id in ipairs(list) do have[id] = true end
        for _, id in ipairs(ids) do
            if not have[id] then have[id] = true; list[#list + 1] = id end
        end
    end
    local updates = ns.BOSS_UPDATES and ns.BOSS_UPDATES[key]
    if not updates then return end
    local names = {}
    for name in pairs(updates) do names[#names + 1] = name end
    table.sort(names)
    for _, name in ipairs(names) do
        local u = updates[name]
        if name == "Trash Drops" then
            info.trash = info.trash or {}
            Add(info.trash, u.loot)
        else
            local boss
            for _, b in ipairs(info.bosses) do if b.name == name then boss = b break end end
            if not boss and u.new then
                boss = { name = name, npc = u.npc, loot = {} }
                info.bosses[#info.bosses + 1] = boss
            end
            if boss then
                boss.loot = boss.loot or {}
                Add(boss.loot, u.loot)
            end
        end
    end
end

local function AttachBosses()
    -- boss NPC IDs missing from the loot data: take them from the guide NPCs
    local byName = {}
    for _, n in pairs(ns.NPCS) do if n.name and n.id and n.id > 0 then byName[n.name] = n.id end end
    -- extra presentation data (Data\DungeonInfo.lua): card art, map wing, route
    for key, extra in pairs(ns.DUNGEON_INFO or {}) do
        local d = ns.dungeons[key]
        if d then for k, v in pairs(extra) do if d[k] == nil then d[k] = v end end end
    end
    for key, info in pairs(bossData) do
        local d = ns.dungeons[key]
        if d then
            d.bossInfo = info
            -- some names of the loot data end with a space: facts and NPC IDs were not found
            for _, b in ipairs(info.bosses) do b.name = (b.name:gsub("%s+$", "")) end
            MergeBossUpdates(key, info)
            local learned = DQF_Cache.npcIDs or {}
            local facts = (ns.BOSS_FACTS and ns.BOSS_FACTS[key]) or {}
            for i, b in ipairs(info.bosses) do
                -- facts observed on the Forever client (Data\BossFacts.lua)
                local f = facts[b.name]
                if f and f.npc and not b.npc then b.npc = f.npc end
                if f and f.level then b.level = f.level end
                if not b.npc and not b.extra then b.npc = byName[b.name] end
                b.npcID = type(b.npc) == "table" and b.npc[1] or b.npc
                -- learned in game when the boss was targeted (Map.lua)
                if not b.npcID or b.npcID == 0 then b.npcID = learned[key .. ":" .. i] end
                local disp = (f and f.display) or (b.npcID and ns.BOSS_DISPLAY and ns.BOSS_DISPLAY[b.npcID])
                    or (DQF_Cache.bossDisplay and DQF_Cache.bossDisplay[key .. ":" .. i]) -- learned from the unit (Map.lua)
                if disp then b.display, b.displayChecked = disp, true end
            end
        end
    end
end

function ns.CurrentDungeon()
    return ns.dungeons[DQF_DB.dungeon] or ns.dungeons[ns.dungeonOrder[1]]
end

-- Name of a boss of the loot data (client language when possible)
function ns.BossName(b)
    if b.npcID and not b.extra then return ns.NPCName({ id = b.npcID, name = b.name }) end
    return b.name
end

-- Key of the dungeon the player is in (instance ID, then instance name), or nil
-- comparable name: lower case, no leading article, no spaces/punctuation
local ARTICLES = { "the ", "la ", "le ", "les ", "l'", "der ", "die ", "das ", "el ", "los ", "las ", "il ", "lo ", "o ", "a " }
local function Norm(s)
    if not s then return "" end
    s = s:lower()
    for _, a in ipairs(ARTICLES) do
        if s:sub(1, #a) == a then s = s:sub(#a + 1) break end
    end
    return (s:gsub("[%s%p]", ""))
end
function ns.InstanceDungeon()
    local inInstance, kind = IsInInstance()
    if not inInstance or (kind ~= "party" and kind ~= "raid") then return end
    local name, _, _, _, _, _, _, instanceID = GetInstanceInfo()
    local candidates = {}
    if instanceID and DQF_Cache.instances[instanceID] then candidates[1] = DQF_Cache.instances[instanceID] end
    for _, key in ipairs(ns.dungeonOrder) do
        local d = ns.dungeons[key]
        if d.bossInfo and d.bossInfo.instance == instanceID then candidates[#candidates + 1] = key end
    end
    if #candidates == 0 and name then
        local n = Norm(name)
        for _, key in ipairs(ns.dungeonOrder) do
            if Norm(ns.dungeons[key].name) == n then candidates[1] = key break end
        end
        -- names that differ a little ("Excavation Site: Wetlands" / "Excavation Site")
        if #candidates == 0 and #n >= 6 then
            for _, key in ipairs(ns.dungeonOrder) do
                local dn = Norm(ns.dungeons[key].name)
                if #dn >= 6 and (dn:find(n, 1, true) or n:find(dn, 1, true)) then candidates[#candidates + 1] = key end
            end
        end
    end
    if #candidates <= 1 then return candidates[1] end
    -- several dungeons share the instance (Scarlet Monastery wings, Blackrock
    -- Spire): prefer the wing whose map is the current map, then the guide in use
    local map = C_Map.GetBestMapForUnit("player")
    for _, key in ipairs(candidates) do
        if map and ns.dungeons[key].wingMap == map then return key end
    end
    for _, key in ipairs(candidates) do if key == DQF_DB.dungeon then return key end end
    return candidates[1]
end

-- Chat link of a quest. The game only gives a real link for a quest in the quest
-- log, and a link made by hand arrives as plain text. Otherwise: the text Questie
-- itself sends, which it turns into a clickable link for the players who have it.
function ns.QuestLink(q, title)
    if GetQuestLink then
        local ok, link = pcall(GetQuestLink, q)
        if ok and type(link) == "string" and link ~= "" then return link end
    end
    return ("[%s (%d)]"):format(title or ("Quest " .. q), q)
end

-- Put a link in the chat edit box (returns true when done)
function ns.InsertLink(link)
    if not link then return end
    if ChatEdit_InsertLink and ChatEdit_InsertLink(link) then return true end
    if ChatFrame_OpenChat then ChatFrame_OpenChat(link); return true end
end

----------------------------------------------------------------------
-- Names (localized at runtime) and locations
----------------------------------------------------------------------
local nameCache = {}
local scan = CreateFrame("GameTooltip", "DQF_ScanTip", nil, "GameTooltipTemplate")
local scanAgainAt = 0 -- the game hides tooltip text (secret values) at times: wait, then retry

function ns.LearnName(npcID, name)
    if npcID and name then nameCache[npcID] = name end
end

function ns.NPCName(npc)
    if not npc then return "?" end
    if nameCache[npc.id] then return nameCache[npc.id] end
    if not npc.id or npc.id == 0 then return npc.name end -- no NPC ID: nothing to ask the game
    local clientEN = GetLocale() == "enUS" or GetLocale() == "enGB"
    if not clientEN and ns.ClientLangMatches() and GetTime() >= scanAgainAt then
        scan:SetOwner(UIParent, "ANCHOR_NONE")
        local ok = pcall(scan.SetHyperlink, scan, ("unit:Creature-0-0-0-0-%d-0000000000"):format(npc.id))
        local line = ok and DQF_ScanTipTextLeft1 and DQF_ScanTipTextLeft1:GetText()
        scan:Hide()
        if ns.IsSecret(line) then
            scanAgainAt = GetTime() + 10
        elseif line and line ~= "" then
            nameCache[npc.id] = line
            return line
        end
    end
    return npc.name
end

-- The Forever client can return "secret" values (GUIDs, names) that addons
-- are not allowed to read: they must be skipped, never converted.
function ns.IsSecret(v)
    if issecretvalue then return issecretvalue(v) and true or false end
    return false
end

function ns.NpcIDFromGUID(guid)
    if not guid or ns.IsSecret(guid) then return end
    local ok, kind, _, _, _, _, id = pcall(strsplit, "-", guid)
    if ok and (kind == "Creature" or kind == "Vehicle") then return tonumber(id) end
end

function ns.StepNPC(step) return step.npcKey and ns.NPCS[step.npcKey] end

function ns.StepTitle(step, d)
    if step.title then return step.title end -- steps without quest (quest = 0)
    if ns.ClientLangMatches() then
        local t = C_QuestLog and C_QuestLog.GetQuestInfo and C_QuestLog.GetQuestInfo(step.quest)
        if t and t ~= "" then return t end
    end
    d = d or ns.CurrentDungeon()
    return (d.titles and d.titles[step.quest]) or ("Quest " .. step.quest)
end

-- Exact location of a step (npc or explicit coords)
function ns.StepLocation(step)
    if step.map and step.x then return step.map, step.x, step.y end
    local n = ns.StepNPC(step)
    if n and n.map and n.x then return n.map, n.x, n.y end
end

-- Where to guide the player: step location, or the dungeon entrance
function ns.StepTarget(step, d)
    local m, x, y = ns.StepLocation(step)
    if m then return m, x, y, false end
    local e = d and d.entrance
    if e then return e.map, e.x, e.y, true end
end

-- All the places where a step can be done: { {map=, x=, y=}, ... } (x/y in 0-100)
--  1. explicit `spots` in the data
--  2. spawn areas of the step's mobs (from Questie), e.g. two camps far apart
--  3. the single location of the step (or the dungeon entrance)
function ns.StepSpots(step, d)
    if step.spots then return step.spots end
    if step.type == "do" and step.targets and ns.Questie and ns.Questie.SpawnAreas then
        local ids = {}
        for _, k in ipairs(step.targets) do
            local n = ns.NPCS[k]
            if n then ids[#ids + 1] = n.id end
        end
        local areas = ns.Questie.SpawnAreas(ids)
        if areas and #areas > 0 then return areas end
    end
    local m, x, y, isEntrance = ns.StepTarget(step, d)
    if m then return { { map = m, x = x, y = y, entrance = isEntrance } } end
    return {}
end

function ns.ZoneName(mapID)
    local info = mapID and C_Map.GetMapInfo(mapID)
    return info and info.name or ""
end

-- Names of the units to target for a step
function ns.StepTargets(step)
    local list = {}
    if step.npcKey then list[#list + 1] = ns.NPCS[step.npcKey] end
    for _, k in ipairs(step.targets or {}) do list[#list + 1] = ns.NPCS[k] end
    return list
end

----------------------------------------------------------------------
-- Central update: evaluate progress once, then notify modules
----------------------------------------------------------------------
ns.modules = {}
function ns:RegisterModule(m) table.insert(self.modules, m) end

function ns.Update(jump)
    if not DQF_DB then return end
    local d = ns.CurrentDungeon()
    local done, total, cur = ns.Progress.Evaluate(d)
    local state = { dungeon = d, done = done, total = total, cur = cur, step = cur and d.list[cur] }
    if ns.state and ns.state.step ~= state.step then jump = true end
    ns.state = state
    for _, m in ipairs(ns.modules) do
        if m.OnUpdate then
            xpcall(function() m:OnUpdate(state, jump) end, geterrorhandler())
        end
    end
end

local pending
function ns.RequestUpdate(delay)
    if pending then return end
    pending = true
    C_Timer.After(delay or 0.3, function()
        pending = false
        ns.Update()
    end)
end

----------------------------------------------------------------------
-- Lifecycle
----------------------------------------------------------------------
ns:On("ADDON_LOADED", function(name)
    if name ~= ADDON then return end
    DQF_DB = DQF_DB or {}
    for k, v in pairs(DEFAULTS) do
        if DQF_DB[k] == nil then DQF_DB[k] = type(v) == "table" and {} or v end
    end
    -- Automatic flights are opt-in since 0.3.27. The old default (on) is saved
    -- in existing profiles, so it is turned off once; ticking it again sticks.
    if not DQF_DB.autoFlightOptIn then
        DQF_DB.autoFlight = false
        DQF_DB.autoFlightOptIn = true
    end
    -- "Blizzard (game)" theme: windows are built with the game's components
    -- (fixed for the session, changing it reloads the UI)
    ns.BLIZZ = DQF_DB.theme == "blizzard"
    DQF_Cache = DQF_Cache or {}
    for k in pairs(CACHE_DEFAULTS) do DQF_Cache[k] = DQF_Cache[k] or {} end
    DQF_Cache.display = nil -- old portrait cache (could hold wrong values), replaced by 3D portraits
    for _, b in ipairs(builders) do BuildDungeon(b[1], b[2]) end
    AttachBosses()
    ns.BuildLocalized()
    if not ns.dungeons[DQF_DB.dungeon] then DQF_DB.dungeon = ns.dungeonOrder[1] end
end)

ns:On("PLAYER_LOGIN", function()
    -- an error in one module is still reported, but must not stop the others
    for _, m in ipairs(ns.modules) do
        if m.Init then xpcall(function() m:Init() end, geterrorhandler()) end
    end
    ns.Update(true)
end)

ns:On("QUEST_ACCEPTED", function(a1, a2) ns.Progress.ReleaseQuest(a2 or a1); ns.RequestUpdate() end)
ns:On("QUEST_TURNED_IN", function(q) ns.Progress.ReleaseQuest(q); ns.RequestUpdate(0.5) end)
ns:On("QUEST_LOG_UPDATE", function() ns.RequestUpdate() end)
ns:On("QUEST_REMOVED", function() ns.RequestUpdate() end)
ns:On("ZONE_CHANGED_NEW_AREA", function() ns.RequestUpdate() end)
ns:On("BAG_UPDATE_DELAYED", function() ns.RequestUpdate() end)
ns:On("GET_ITEM_INFO_RECEIVED", function() ns.RequestUpdate(0.5) end)

----------------------------------------------------------------------
-- Navigation helpers (used by bindings, slash, menus)
----------------------------------------------------------------------
function ns.NextStep()
    local s = ns.state and ns.state.step
    if s then ns.Progress.SetManual(ns.state.dungeon, s.uid, true); ns.Update(true) end
end

function ns.PrevStep()
    local st = ns.state
    if not st then return end
    local pos = (st.cur or (st.total + 1)) - 1
    if pos >= 1 then ns.Progress.GoToStep(st.dungeon, pos); ns.Update(true) end
end

DQF_Toggle = function() ns.UI:Toggle() end
DQF_ToggleArrow = function() ns.Arrow:Toggle() end
DQF_Next = ns.NextStep
DQF_Prev = ns.PrevStep
DQF_Options = function() ns.Options:Toggle() end
DQF_Journal = function() ns.Journal:Toggle() end

BINDING_HEADER_DQF = "Dungeon Quests Forever"

-- Texts that other files would otherwise build at load time
ns.localizers = {}
function ns.OnLocalize(fn) table.insert(ns.localizers, fn) end
function ns.BuildLocalized()
    BINDING_NAME_DQF_TOGGLE = L("Afficher/cacher la fenêtre", "Show/hide window")
    BINDING_NAME_DQF_ARROW = L("Afficher/cacher la flèche", "Show/hide arrow")
    BINDING_NAME_DQF_NEXT = L("Étape suivante", "Next step")
    BINDING_NAME_DQF_PREV = L("Étape précédente", "Previous step")
    BINDING_NAME_DQF_OPTIONS = L("Options", "Options")
    BINDING_NAME_DQF_JOURNAL = L("Afficher/cacher Dungeon Home", "Show/hide Dungeon Home")
    for _, fn in ipairs(ns.localizers) do fn() end
end

SLASH_DQF1, SLASH_DQF2 = "/dqf", "/dungeonquests"
SlashCmdList.DQF = function(msg)
    msg = strlower(strtrim(msg or ""))
    if msg == "reset" then
        DQF_DB.pos, DQF_DB.arrowPos = nil, nil
        for _, m in ipairs(ns.modules) do
            if m.RestorePosition then m:RestorePosition() end
        end
    elseif msg == "arrow" or msg == "fleche" then ns.Arrow:Toggle()
    elseif msg == "options" or msg == "config" then ns.Options:Toggle()
    elseif msg == "scan" then ns.Progress.Scan(true)
    elseif msg == "next" then ns.NextStep()
    elseif msg == "prev" then ns.PrevStep()
    elseif msg == "journal" or msg == "j" then ns.Journal:Toggle()
    elseif msg == "route" then ns.Route:Toggle(ns.CurrentDungeon())
    elseif msg == "where" then
        -- debug: where the current step points, and the maps involved
        local function MapText(id)
            local i = id and C_Map.GetMapInfo(id)
            return ("%s (%s, type %s)"):format(tostring(id), i and i.name or "?", i and tostring(i.mapType) or "?")
        end
        local st = ns.state
        local s = st and st.step
        print("|cff9d7bffDQF where|r step:", s and s.pos, s and s.type, s and s.quest, s and s.npcKey)
        for _, p in ipairs(s and ns.StepSpots(s, st.dungeon) or {}) do
            print("  spot:", MapText(p.map), p.x, p.y, p.entrance and "(entrance)" or "")
        end
        local m = C_Map.GetBestMapForUnit("player")
        local pos = m and C_Map.GetPlayerMapPosition(m, "player")
        print("  player map:", MapText(m), pos and ("%.1f %.1f"):format(pos.x * 100, pos.y * 100) or "")
        if WorldMapFrame and WorldMapFrame:GetMapID() then print("  world map:", MapText(WorldMapFrame:GetMapID())) end
    elseif msg == "entrances" or msg == "entrees" then
        DQF_DB.entrancePins = not DQF_DB.entrancePins
        ns.EntrancePins:Refresh()
    else ns.UI:Toggle() end
end
