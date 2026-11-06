local _, ns = ...
local L = ns.L
local AT = {}
ns.Attune = AT
ns:RegisterModule(AT)

-- Raid attunements (guides with `attunement = true`, Guides\Attunements):
-- status of the current character, and of every character of the account
-- (saved in DQF_Cache.attune, shown in the tooltips like the Attune addon).

local function Flagged(q)
    if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then return C_QuestLog.IsQuestFlaggedCompleted(q) end
    return IsQuestFlaggedCompleted and IsQuestFlaggedCompleted(q)
end

-- the attunement guides, in their order
function AT.List()
    local out = {}
    for _, key in ipairs(ns.dungeonOrder) do
        local d = ns.dungeons[key]
        if d.attunement then out[#out + 1] = d end
    end
    table.sort(out, function(a, b) return (a.order or 99) < (b.order or 99) end)
    return out
end

-- final quest(s) of an attunement for the player's faction
local function Finals(d)
    local f = d.final
    if type(f) == "number" then return { f } end
    if type(f) == "table" then
        local mine = f[UnitFactionGroup("player")]
        if mine then return type(mine) == "table" and mine or { mine } end
        if #f > 0 then return f end
    end
    return {}
end

function AT.IsAttuned(d)
    for _, q in ipairs(Finals(d)) do if Flagged(q) then return true end end
    return false
end

-- "done" / "progress" / "none", steps done, steps total (player's faction)
function AT.Status(d)
    local done, total = ns.Progress.Evaluate(d)
    if AT.IsAttuned(d) then return "done", total, total end
    if done > 0 then return "progress", done, total end
    return "none", 0, total
end

function AT.StatusText(state, done, total)
    if state == "done" then return "|cff55ff55" .. L("Accès obtenu !", "Attuned!") .. "|r" end
    if state == "progress" then return ("|cffffd100" .. L("En cours : %d/%d étapes", "In progress: %d/%d steps") .. "|r"):format(done, total) end
    return "|cff999999" .. L("Pas commencée", "Not started") .. "|r"
end

----------------------------------------------------------------------
-- Characters of the account
----------------------------------------------------------------------
local function CharKey() return (UnitName("player") or "?") .. "-" .. (GetRealmName and GetRealmName() or "?") end

function AT.Save()
    if not DQF_Cache then return end
    DQF_Cache.attune = DQF_Cache.attune or {}
    local _, class = UnitClass("player")
    local rec = { name = UnitName("player"), realm = GetRealmName and GetRealmName(), class = class,
        faction = UnitFactionGroup("player"), level = UnitLevel("player"), keys = {} }
    for _, d in ipairs(AT.List()) do
        local state, done, total = AT.Status(d)
        rec.keys[d.key] = { state = state, done = done, total = total }
    end
    DQF_Cache.attune[CharKey()] = rec
end

-- Tooltip lines: every character of the account and its status for d
function AT.AddAltLines(tip, d)
    local list = {}
    for key, rec in pairs((DQF_Cache and DQF_Cache.attune) or {}) do
        if rec.keys and rec.keys[d.key] then list[#list + 1] = rec end
    end
    if #list == 0 then return end
    table.sort(list, function(a, b) return (a.level or 0) > (b.level or 0) end)
    tip:AddLine(" ")
    tip:AddLine(L("Tes personnages :", "Your characters:"), 1, 0.82, 0)
    for _, rec in ipairs(list) do
        local c = RAID_CLASS_COLORS and rec.class and RAID_CLASS_COLORS[rec.class]
        local name = c and ("|cff%02x%02x%02x%s|r"):format(c.r * 255, c.g * 255, c.b * 255, rec.name) or rec.name
        local k = rec.keys[d.key]
        tip:AddDoubleLine(("%s |cff888888(%s)|r"):format(name, rec.level or "?"), AT.StatusText(k.state, k.done, k.total))
    end
end

local pending
function AT:OnUpdate()
    -- quest progress changed: save the snapshot a little later (throttled)
    if pending then return end
    pending = true
    C_Timer.After(2, function() pending = false; AT.Save() end)
end
