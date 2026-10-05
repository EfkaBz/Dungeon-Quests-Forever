local ADDON, ns = ...
ns.VERSION = "0.2.4"
ns.dungeons, ns.dungeonOrder, ns.NPCS = {}, {}, {}
-- Language: "auto" follows the game client, "fr" / "en" force it (option).
-- Saved variables are only available after ADDON_LOADED, so every text
-- built at load time is created in ns.BuildLocalized() (see below).
function ns.ClientIsFR() return GetLocale() == "frFR" end
function ns.IsFR()
    local lang = DQF_DB and DQF_DB.lang
    if lang == "fr" then return true end
    if lang == "en" then return false end
    return ns.ClientIsFR()
end
-- true when the addon language matches the client language (client texts usable)
function ns.ClientLangMatches() return ns.IsFR() == ns.ClientIsFR() end
function ns.L(fr, en) return ns.IsFR() and fr or en end
local L = ns.L

local DEFAULTS = {
    lang = "auto",
    autoQuest = true, autoRewards = false, autoFlight = true, skipGossip = true,
    shown = true, arrowShown = true, minimapShown = true, minimapAngle = 200,
    targetsShown = true, mapPins = true, minimapPins = true,
    hideDone = false, autoFollow = true, locked = false,
    scale = 1, alpha = 1, theme = "default",
    manual = {},
}

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

local function BuildDungeon(key, data)
    if type(data) == "function" then data = data() end
    data.key = key
    for i, s in ipairs(data.steps) do s.uid = i end
    ns.dungeons[key] = data
    table.insert(ns.dungeonOrder, key)
end

function ns.CurrentDungeon()
    return ns.dungeons[DQF_DB.dungeon] or ns.dungeons[ns.dungeonOrder[1]]
end

----------------------------------------------------------------------
-- Names (localized at runtime) and locations
----------------------------------------------------------------------
local nameCache = {}
local scan = CreateFrame("GameTooltip", "DQF_ScanTip", nil, "GameTooltipTemplate")

function ns.LearnName(npcID, name)
    if npcID and name then nameCache[npcID] = name end
end

function ns.NPCName(npc)
    if not npc then return "?" end
    if nameCache[npc.id] then return nameCache[npc.id] end
    local clientEN = GetLocale() == "enUS" or GetLocale() == "enGB"
    if not clientEN and ns.ClientLangMatches() then
        scan:SetOwner(UIParent, "ANCHOR_NONE")
        local ok = pcall(scan.SetHyperlink, scan, ("unit:Creature-0-0-0-0-%d-0000000000"):format(npc.id))
        local line = ok and DQF_ScanTipTextLeft1 and DQF_ScanTipTextLeft1:GetText()
        scan:Hide()
        if line and line ~= "" then
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
        if m.OnUpdate then m:OnUpdate(state, jump) end
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
    for _, b in ipairs(builders) do BuildDungeon(b[1], b[2]) end
    ns.BuildLocalized()
    if not ns.dungeons[DQF_DB.dungeon] then DQF_DB.dungeon = ns.dungeonOrder[1] end
end)

ns:On("PLAYER_LOGIN", function()
    for _, m in ipairs(ns.modules) do
        if m.Init then m:Init() end
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
    else ns.UI:Toggle() end
end
