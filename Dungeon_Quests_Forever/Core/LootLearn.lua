local _, ns = ...
local L = ns.L

-- ===================================================================
-- Boss loot learned in game: reads the "Loot Rolls" history (one entry
-- per boss kill, named after the encounter) and the loot window, and
-- adds the item IDs to the boss of the same name. Saved account-wide in
-- DQF_Cache.loot[boss name] = { itemID, ... } for new Forever dungeons
-- whose loot tables are not public yet.
-- ===================================================================
local LH = C_LootHistory

local function ItemID(link) return link and not ns.IsSecret(link) and tonumber(link:match("item:(%d+)")) end

-- boss entry (dungeon data) for a boss / encounter name
local function FindBoss(name)
    -- names of units / encounters can be secret values (not comparable)
    if not name or ns.IsSecret(name) then return end
    for _, d in pairs(ns.dungeons) do
        for _, b in ipairs(d.bossInfo and d.bossInfo.bosses or {}) do
            if b.name == name or ns.BossName(b) == name or (b.aliases and tContains(b.aliases, name)) then return b end
        end
    end
end

local function AddToBoss(b, id)
    b.loot = b.loot or {}
    for _, v in ipairs(b.loot) do if v == id then return false end end
    table.insert(b.loot, id)
    return true
end

local function Learn(bossName, link)
    local id = ItemID(link)
    local b = FindBoss(bossName)
    if not id or not b then return end
    DQF_Cache.loot = DQF_Cache.loot or {}
    local list = DQF_Cache.loot[b.name] or {}
    DQF_Cache.loot[b.name] = list
    local known = false
    for _, v in ipairs(list) do if v == id then known = true end end
    if not known then table.insert(list, id) end
    if AddToBoss(b, id) then
        print("|cff9d7bffDungeon Quests|r " .. L("butin appris :", "loot learned:") .. " " .. link .. " (" .. b.name .. ", ID " .. id .. ")")
        if ns.JournalBosses and ns.JournalBosses.RefreshSoon then ns.JournalBosses:RefreshSoon() end
    end
end

-- "Loot Rolls" history: every encounter and its drops
local function ScanHistory()
    if not (LH and LH.GetAllEncounterInfos and LH.GetSortedDropsForEncounter) then return end
    for _, enc in ipairs(LH.GetAllEncounterInfos() or {}) do
        for _, drop in ipairs(LH.GetSortedDropsForEncounter(enc.encounterID) or {}) do
            Learn(enc.encounterName, drop.itemHyperlink)
        end
    end
end

-- loot window: items looted from a corpse. The source is found from the
-- loot slot GUID (NPC ID), then from the dead target's name; names and
-- GUIDs can be secret inside instances: the blue+ items are then kept as
-- "unknown source" and printed with their ID (rares are not in the
-- "Loot Rolls" history).
local function BossByNpc(id)
    if not id then return end
    for _, d in pairs(ns.dungeons) do
        for _, b in ipairs(d.bossInfo and d.bossInfo.bosses or {}) do
            if b.npcID == id then return b end
        end
    end
end

local function ScanLootWindow()
    local target = UnitExists("target") and UnitIsDead("target") and UnitName("target")
    for i = 1, GetNumLootItems() do
        local link = GetLootSlotLink(i)
        local b
        if GetLootSourceInfo then
            local guid = GetLootSourceInfo(i)
            b = BossByNpc(ns.NpcIDFromGUID(guid))
        end
        b = b or FindBoss(target)
        if b then
            Learn(b.name, link)
        elseif IsInInstance() and link and not ns.IsSecret(link) then
            local id = ItemID(link)
            local info = (C_Item and C_Item.GetItemInfo) or GetItemInfo
            local quality = info and select(4, pcall(info, link)) -- ok, name, link, quality
            if id and (quality or 0) >= 3 then
                DQF_Cache.lootUnknown = DQF_Cache.lootUnknown or {}
                local key = ns.InstanceDungeon() or "?"
                local list = DQF_Cache.lootUnknown[key] or {}
                DQF_Cache.lootUnknown[key] = list
                if not tContains(list, id) then
                    table.insert(list, id)
                    print("|cff9d7bffDungeon Quests|r " .. L("butin (source inconnue) :", "loot (unknown source):") .. " " .. link .. " (ID " .. id .. ")")
                end
            end
        end
    end
end

local M = {}
function M:Init()
    -- put the saved items back on their bosses
    for bossName, ids in pairs(DQF_Cache.loot or {}) do
        local b = FindBoss(bossName)
        if b then for _, id in ipairs(ids) do AddToBoss(b, id) end end
    end
    ScanHistory()
end
ns:RegisterModule(M)

-- own frame: some of these events may not exist on every client
local f = CreateFrame("Frame")
for _, e in ipairs({ "LOOT_HISTORY_UPDATE_DROP", "LOOT_HISTORY_UPDATE_ENCOUNTER", "LOOT_HISTORY_FULL_UPDATE", "LOOT_OPENED" }) do
    pcall(f.RegisterEvent, f, e)
end
f:SetScript("OnEvent", function(_, e)
    if e == "LOOT_OPENED" then ScanLootWindow() else C_Timer.After(0.5, ScanHistory) end
end)
