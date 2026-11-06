local _, ns = ...
local L = ns.L
local Q = {}
ns.Questie = Q
ns:RegisterModule(Q)

-- Quest and NPC data. The addon carries its own (Data\QuestData.lua, Data\NpcData.lua,
-- Data\QuestLevels.lua) and works without Questie. When Questie is loaded it only fills
-- what is missing here. Everything is wrapped in pcall so a Questie update can never
-- break this addon.
local DB, ZoneDB

local function Ready()
    if DB then return true end
    if not QuestieLoader then return false end
    local ok, qdb = pcall(QuestieLoader.ImportModule, QuestieLoader, "QuestieDB")
    local ok2, zdb = pcall(QuestieLoader.ImportModule, QuestieLoader, "ZoneDB")
    if ok and qdb and qdb.QueryQuestSingle and qdb.QueryNPCSingle and ok2 and zdb then
        DB, ZoneDB = qdb, zdb
        return true
    end
    return false
end

local function Query(fn, id, key)
    if not Ready() then return end
    local ok, v = pcall(fn, id, key)
    if ok then return v end
end

-- Prerequisite quest IDs of q (preQuestSingle + preQuestGroup)
function Q.Prerequisites(q)
    if ns.QUEST_PREREQS and ns.QUEST_PREREQS[q] then return ns.QUEST_PREREQS[q] end
    local out = {}
    for _, key in ipairs({ "preQuestSingle", "preQuestGroup" }) do
        local v = Query(DB and DB.QueryQuestSingle, q, key)
        if type(v) == "table" then
            for _, id in pairs(v) do if type(id) == "number" and id > 0 then out[#out + 1] = id end end
        end
    end
    return out
end

-- Offline list first (Data/QuestLevels.lua): it has the Forever quests
function Q.RequiredLevel(q)
    local t = ns.QUEST_LEVELS and ns.QUEST_LEVELS[q]
    if t and t[2] then return t[2] end
    return Query(DB and DB.QueryQuestSingle, q, "requiredLevel")
end

function Q.QuestLevel(q)
    local t = ns.QUEST_LEVELS and ns.QUEST_LEVELS[q]
    if t and t[1] then return t[1] end
    return Query(DB and DB.QueryQuestSingle, q, "questLevel")
end

-- English quest name (fallback when the client does not know the quest)
function Q.QuestName(q)
    return Query(DB and DB.QueryQuestSingle, q, "name")
end

-- True when Questie is loaded and has this quest (it then makes its chat text clickable)
function Q.QuestieKnows(q)
    return Q.QuestName(q) ~= nil
end

-- Quest description lines ("Bring 10 Red Silk Bandanas to...")
function Q.ObjectivesText(q)
    local t = Query(DB and DB.QueryQuestSingle, q, "objectivesText")
    if type(t) == "table" then return table.concat(t, "\n") end
    return ns.QUEST_OBJECTIVES and ns.QUEST_OBJECTIVES[q]
end

-- Classes allowed to take the quest (bitmask, nil = every class)
function Q.RequiredClasses(q)
    if ns.QUEST_CLASSES and ns.QUEST_CLASSES[q] then return ns.QUEST_CLASSES[q] end
    local v = Query(DB and DB.QueryQuestSingle, q, "requiredClasses")
    if type(v) == "number" and v > 0 then return v end
end

-- XP and money given by the quest (Questie's quest XP database)
local XP
local function XPModule()
    if XP ~= nil then return XP or nil end
    XP = false
    if QuestieLoader then
        local ok, m = pcall(QuestieLoader.ImportModule, QuestieLoader, "QuestXP")
        if ok and m and m.GetQuestLogRewardXP then XP = m end
    end
    return XP or nil
end
-- XP at the player's level, from the XP at the level of the quest (Classic formula)
local function AdjustedXP(q)
    local t = ns.QUEST_XP and ns.QUEST_XP[q]
    if not t then return end
    local level = UnitLevel("player")
    if GetMaxPlayerLevel and level >= GetMaxPlayerLevel() then return end
    local xp = t[2] * math.max(1, math.min(10, 2 * (t[1] - level) + 20)) / 10
    if xp <= 100 then return 5 * math.floor((xp + 2) / 5) end
    if xp <= 500 then return 10 * math.floor((xp + 5) / 10) end
    if xp <= 1000 then return 25 * math.floor((xp + 12) / 25) end
    return 50 * math.floor((xp + 25) / 50)
end
function Q.RewardXP(q)
    local m = XPModule()
    if m then
        local ok, v = pcall(m.GetQuestLogRewardXP, m, q)
        if ok and type(v) == "number" and v > 0 then return v end
    end
    local xp = AdjustedXP(q)
    if xp and xp > 0 then return xp end
end
function Q.RewardMoney(q)
    if not GetQuestLogRewardMoney then return end
    local ok, v = pcall(GetQuestLogRewardMoney, q)
    if ok and type(v) == "number" and v > 0 then return v end
end

function Q.QuestLevels(q)
    local lvl = Q.QuestLevel(q)
    local req = Q.RequiredLevel(q)
    if lvl and req then return (L("Niveau %d (requis : %d)", "Level %d (required: %d)")):format(lvl, req) end
end

-- Spawn areas of a group of mobs: their spawn points are grouped into
-- clusters, each cluster gives one spot (its center). Cached per mob list.
local CLUSTER_RADIUS, MAX_AREAS = 6, 4
local areaCache = {}

function Q.SpawnAreas(npcIDs)
    local key = table.concat(npcIDs, ",")
    if areaCache[key] then return areaCache[key] end
    if ns.SPAWN_AREAS and ns.SPAWN_AREAS[key] then return ns.SPAWN_AREAS[key] end
    if not Ready() then return end
    local clusters, total = {}, 0
    for _, id in ipairs(npcIDs) do
        local spawns = Query(DB.QueryNPCSingle, id, "spawns")
        if type(spawns) == "table" then
            for areaId, coords in pairs(spawns) do
                local ok, map = pcall(ZoneDB.GetUiMapIdByAreaId, ZoneDB, areaId)
                if ok and map then
                    for _, c in ipairs(coords) do
                        local x, y = c[1], c[2]
                        if x and x > 0 then
                            total = total + 1
                            local hit
                            for _, cl in ipairs(clusters) do
                                if cl.map == map and (cl.x - x) ^ 2 + (cl.y - y) ^ 2 < CLUSTER_RADIUS ^ 2 then hit = cl break end
                            end
                            if hit then
                                hit.n = hit.n + 1
                                hit.sx, hit.sy = hit.sx + x, hit.sy + y
                                hit.x, hit.y = hit.sx / hit.n, hit.sy / hit.n
                            else
                                clusters[#clusters + 1] = { map = map, x = x, y = y, sx = x, sy = y, n = 1 }
                            end
                        end
                    end
                end
            end
        end
    end
    table.sort(clusters, function(a, b) return a.n > b.n end)
    local out = {}
    for _, cl in ipairs(clusters) do
        -- ignore isolated spawns when there are real camps
        if #out < MAX_AREAS and (cl.n >= 2 or #clusters == 1) then
            out[#out + 1] = { map = cl.map, x = cl.x, y = cl.y }
        end
    end
    areaCache[key] = out
    return out
end

-- Replace NPC coordinates with Questie's first spawn (more reliable).
-- NPCs flagged forever = true keep their coordinates: they were taken in
-- WoW Forever, where some maps (Stormwind, Redridge) differ from Questie's.
local function RefreshNPCs()
    local changed = false
    for _, npc in pairs(ns.NPCS) do
        local spawns = not npc.forever and Query(DB.QueryNPCSingle, npc.id, "spawns")
        if type(spawns) == "table" then
            for areaId, coords in pairs(spawns) do
                local c = coords[1]
                local ok, mapID = pcall(ZoneDB.GetUiMapIdByAreaId, ZoneDB, areaId)
                if ok and mapID and c and c[1] and c[1] > 0 then
                    npc.map, npc.x, npc.y = mapID, c[1], c[2]
                    changed = true
                    break
                end
            end
        end
    end
    return changed
end

function Q:Init()
    -- positions carried by the addon (NPCs flagged forever keep theirs)
    for _, npc in pairs(ns.NPCS) do
        local p = not npc.forever and ns.NPC_SPAWNS and ns.NPC_SPAWNS[npc.id]
        if p then npc.map, npc.x, npc.y = p[1], p[2], p[3] end
    end
    -- Questie builds its DB a few seconds after login
    local tries = 0
    local function attempt()
        tries = tries + 1
        if Ready() then
            RefreshNPCs()
            ns.Update(true) -- quest chains are known now: re-scan
        elseif tries < 12 and QuestieLoader then
            C_Timer.After(5, attempt)
        end
    end
    C_Timer.After(5, attempt)
end
