local _, ns = ...
local L = ns.L
local Q = {}
ns.Questie = Q
ns:RegisterModule(Q)

-- Optional integration: when Questie is loaded, use its database for
-- NPC coordinates and quest levels. Everything is wrapped in pcall so a
-- Questie update can never break this addon.
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
    local out = {}
    for _, key in ipairs({ "preQuestSingle", "preQuestGroup" }) do
        local v = Query(DB and DB.QueryQuestSingle, q, key)
        if type(v) == "table" then
            for _, id in pairs(v) do if type(id) == "number" and id > 0 then out[#out + 1] = id end end
        end
    end
    return out
end

function Q.RequiredLevel(q)
    return Query(DB and DB.QueryQuestSingle, q, "requiredLevel")
end

function Q.QuestLevels(q)
    local lvl = Query(DB and DB.QueryQuestSingle, q, "questLevel")
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

-- Replace NPC coordinates with Questie's first spawn (more reliable)
local function RefreshNPCs()
    local changed = false
    for _, npc in pairs(ns.NPCS) do
        local spawns = Query(DB.QueryNPCSingle, npc.id, "spawns")
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
