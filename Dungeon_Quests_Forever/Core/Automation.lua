local _, ns = ...
local L = ns.L
local A = {}
ns.Automation = A
ns:RegisterModule(A)

-- Hold Shift while talking to an NPC to disable every automation.
local function Enabled(key) return DQF_DB[key] and not IsShiftKeyDown() end

----------------------------------------------------------------------
-- Guide quests (every quest of every registered dungeon guide)
----------------------------------------------------------------------
local guideQuests, guideTitles

local function BuildQuestSets()
    guideQuests, guideTitles = {}, {}
    for _, d in pairs(ns.dungeons) do
        for _, s in ipairs(d.steps) do
            guideQuests[s.quest] = true
            local t = ns.StepTitle(s, d)
            if t then guideTitles[t] = true end
        end
    end
end

local function IsGuideQuest(questID, title)
    if not guideQuests then BuildQuestSets() end
    if questID and questID > 0 then return guideQuests[questID] end
    return title and guideTitles[title]
end

----------------------------------------------------------------------
-- Quest accept / turn-in / rewards
----------------------------------------------------------------------
local function GossipQuests()
    if not C_GossipInfo then return end
    local ok = Enabled("autoQuest")
    if not ok then return end
    -- turn in finished guide quests first
    for _, q in ipairs(C_GossipInfo.GetActiveQuests() or {}) do
        if q.isComplete and IsGuideQuest(q.questID, q.title) then
            C_GossipInfo.SelectActiveQuest(q.questID)
            return true
        end
    end
    for _, q in ipairs(C_GossipInfo.GetAvailableQuests() or {}) do
        if IsGuideQuest(q.questID, q.title) then
            C_GossipInfo.SelectAvailableQuest(q.questID)
            return true
        end
    end
end

local function GreetingQuests()
    if not Enabled("autoQuest") then return end
    for i = 1, GetNumActiveQuests() do
        local title, complete = GetActiveTitle(i)
        local id = GetActiveQuestID and GetActiveQuestID(i)
        if complete and IsGuideQuest(id, title) then SelectActiveQuest(i) return end
    end
    for i = 1, GetNumAvailableQuests() do
        local title = GetAvailableTitle(i)
        local id = GetAvailableQuestInfo and select(5, GetAvailableQuestInfo(i))
        if IsGuideQuest(id, title) then SelectAvailableQuest(i) return end
    end
end

-- Best choice reward = highest vendor price
local function BestReward(n)
    local best, bestPrice = 1, -1
    for i = 1, n do
        local link = GetQuestItemLink("choice", i)
        local price = link and select(11, GetItemInfo(link)) or 0
        if price > bestPrice then best, bestPrice = i, price end
    end
    return best
end

local function OnQuestComplete()
    if not IsGuideQuest(GetQuestID(), GetTitleText()) then return end
    local n = GetNumQuestChoices()
    if n <= 1 then
        if Enabled("autoQuest") then GetQuestReward(n) end
    elseif Enabled("autoRewards") then
        GetQuestReward(BestReward(n))
    end
end

----------------------------------------------------------------------
-- Skip gossip
----------------------------------------------------------------------
local function GossipOptions()
    if not C_GossipInfo then return {} end
    return C_GossipInfo.GetOptions() or {}
end

local function OnGossipShow()
    if GossipQuests() then return end
    local options = GossipOptions()
    if not Enabled("skipGossip") then return end
    local nQuests = #(C_GossipInfo.GetActiveQuests() or {}) + #(C_GossipInfo.GetAvailableQuests() or {})
    if #options == 1 and nQuests == 0 then
        local o = options[1]
        C_GossipInfo.SelectOption(o.gossipOptionID or o.orderIndex)
    end
end

----------------------------------------------------------------------
-- Flight path: fly to the node closest to the next objective
----------------------------------------------------------------------
local function ToMap(mapID, x, y, dispMap)
    if mapID == dispMap then return x, y end
    local cont, world = C_Map.GetWorldPosFromMapPos(mapID, CreateVector2D(x, y))
    if not cont then return end
    local _, pos = C_Map.GetMapPosFromWorldPos(cont, world, dispMap)
    if pos then return pos.x, pos.y end
end

local function OnTaxiShow()
    if not Enabled("autoFlight") or not C_TaxiMap then return end
    local st = ns.state
    if not (st and st.step) then return end
    local m, x, y = ns.StepTarget(st.step, st.dungeon)
    local taxiMap = GetTaxiMapID and GetTaxiMapID()
    if not (m and taxiMap) then return end
    local tx, ty = ToMap(m, x / 100, y / 100, taxiMap)
    if not tx then return end

    local best, bestDist, current
    for _, node in ipairs(C_TaxiMap.GetAllTaxiNodes(taxiMap) or {}) do
        local dx, dy = node.position.x - tx, node.position.y - ty
        local dist = dx * dx + dy * dy
        if node.state == Enum.FlightPathState.Current then
            current = dist
        elseif node.state == Enum.FlightPathState.Reachable and (not bestDist or dist < bestDist) then
            best, bestDist = node, dist
        end
    end
    -- only fly if the destination is really closer to the objective
    if best and (not current or bestDist < current * 0.5) then
        DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99DQF|r : " .. L("Vol vers ", "Flying to ") .. best.name)
        TakeTaxiNode(best.slotIndex)
    end
end

----------------------------------------------------------------------
function A:Init()
    ns:On("GOSSIP_SHOW", OnGossipShow)
    ns:On("QUEST_GREETING", GreetingQuests)
    ns:On("QUEST_DETAIL", function()
        if Enabled("autoQuest") and IsGuideQuest(GetQuestID(), GetTitleText()) then AcceptQuest() end
    end)
    ns:On("QUEST_PROGRESS", function()
        if Enabled("autoQuest") and IsQuestCompletable() and IsGuideQuest(GetQuestID(), GetTitleText()) then CompleteQuest() end
    end)
    ns:On("QUEST_COMPLETE", OnQuestComplete)
    ns:On("TAXIMAP_OPENED", function() C_Timer.After(0.1, OnTaxiShow) end)
end
