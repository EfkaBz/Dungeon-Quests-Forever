local _, ns = ...
local L = ns.L
local G = {}
ns.Group = G
ns:RegisterModule(G)

-- Party members running DQF broadcast the state of the dungeon quests.
-- Message: "S:<dungeon>:<questID>=<state>,..."  (state: see Progress.QuestState)
local PREFIX = "DQF"
local status = {} -- [player] = { [questID] = state }
local STATE_TEXT = {}
ns.OnLocalize(function()
    STATE_TEXT[0] = L("|cff888888pas la quête|r", "|cff888888not on quest|r")
    STATE_TEXT[1] = L("|cffffff00en cours|r", "|cffffff00in progress|r")
    STATE_TEXT[2] = L("|cff55ff55à rendre|r", "|cff55ff55ready to turn in|r")
    STATE_TEXT[3] = L("|cff55ff55terminée|r", "|cff55ff55completed|r")
end)

local function Channel()
    if IsInRaid() then return "RAID" end
    if IsInGroup() then return "PARTY" end
end

function G.CanShare(q)
    local i = ns.Progress.LogIndex(q)
    return i and IsInGroup() and GetQuestLogPushable and true or false
end

function G.Share(q)
    local i = ns.Progress.LogIndex(q)
    if not i then return end
    local prev = GetQuestLogSelection()
    SelectQuestLogEntry(i)
    local ok, pushable = pcall(GetQuestLogPushable)
    if not ok then ok, pushable = pcall(GetQuestLogPushable, q) end
    if ok and pushable then
        QuestLogPushQuest()
    else
        UIErrorsFrame:AddMessage(L("Cette quête ne peut pas être partagée.", "This quest cannot be shared."), 1, 0.1, 0.1)
    end
    SelectQuestLogEntry(prev or 0)
end

local lastSent
function G.Broadcast()
    local ch = Channel()
    local st = ns.state
    if not (ch and st) then return end
    local seen, parts = {}, {}
    for _, s in ipairs(st.dungeon.steps) do
        if s.quest ~= 0 and not seen[s.quest] then
            seen[s.quest] = true
            parts[#parts + 1] = s.quest .. "=" .. ns.Progress.QuestState(s.quest)
        end
    end
    local msg = "S:" .. st.dungeon.key .. ":" .. table.concat(parts, ",")
    if msg == lastSent then return end
    lastSent = msg
    C_ChatInfo.SendAddonMessage(PREFIX, msg, ch)
end

function G.AddTooltipLines(q)
    local lines = {}
    for player, quests in pairs(status) do
        if quests[q] and (UnitInParty(player) or UnitInRaid(player)) then
            lines[#lines + 1] = { player, STATE_TEXT[quests[q]] or "?" }
        end
    end
    if #lines == 0 then return end
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(L("Groupe :", "Group:"), 1, 0.82, 0)
    for _, l in ipairs(lines) do GameTooltip:AddDoubleLine(l[1], l[2], 1, 1, 1) end
end

function G:Init()
    C_ChatInfo.RegisterAddonMessagePrefix(PREFIX)
    ns:On("CHAT_MSG_ADDON", function(prefix, msg, _, sender)
        if prefix ~= PREFIX then return end
        local name = Ambiguate(sender, "short")
        if name == UnitName("player") then return end
        if msg == "REQ" then lastSent = nil; G.Broadcast() return end
        local _, data = msg:match("^S:([^:]+):(.*)$")
        if not data then return end
        status[name] = status[name] or {}
        for q, s in data:gmatch("(%d+)=(%d)") do status[name][tonumber(q)] = tonumber(s) end
        ns.RequestUpdate(0.1)
    end)
    ns:On("GROUP_ROSTER_UPDATE", function()
        local ch = Channel()
        if ch then
            lastSent = nil
            C_Timer.After(2, function()
                if Channel() then C_ChatInfo.SendAddonMessage(PREFIX, "REQ", Channel()) end
                G.Broadcast()
            end)
        end
    end)
end

function G:OnUpdate()
    G.Broadcast()
end
