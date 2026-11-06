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
    if LE_PARTY_CATEGORY_INSTANCE and IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then return "INSTANCE_CHAT" end
    if IsInRaid() then return "RAID" end
    if IsInGroup() then return "PARTY" end
end

-- C_QuestLog when the client has it, else GetQuestLogPushable (selected quest)
local function IsPushable(q)
    if C_QuestLog and C_QuestLog.IsPushableQuest then
        local ok, v = pcall(C_QuestLog.IsPushableQuest, q)
        if ok then return v end
    end
    if GetQuestLogPushable then
        local ok, v = pcall(GetQuestLogPushable)
        if ok then return v end
    end
end

function G.CanShare(q)
    local i = ns.Progress.LogIndex(q)
    return i and IsInGroup() and (GetQuestLogPushable or (C_QuestLog and C_QuestLog.IsPushableQuest)) and true or false
end

function G.Share(q)
    local i = ns.Progress.LogIndex(q)
    if not i then return end
    local restore = ns.Progress.SelectInLog(q)
    if IsPushable(q) then
        QuestLogPushQuest()
    else
        UIErrorsFrame:AddMessage(L("Cette quête ne peut pas être partagée.", "This quest cannot be shared."), 1, 0.1, 0.1)
    end
    restore()
end

----------------------------------------------------------------------
-- Posts the quests of the current guide in the group chat, as quest links:
-- instance chat (/bg, /i) when there is one, else /raid, else /p
----------------------------------------------------------------------
local CHAT_MAX, CHAT_DELAY = 250, 0.7 -- a chat message holds 255 characters at most
local shareBusyUntil = 0

-- The chat messages for a guide (other faction and class quests are not in d.list)
function G.QuestChatLines(d)
    -- quests of a same chain together, chains in the order of the guide
    local seen, groups, byRoot = {}, {}, {}
    for _, s in ipairs(d.list or {}) do
        if s.quest and s.quest > 0 and not seen[s.quest] then
            seen[s.quest] = true
            local root, depth = ns.QuestInfo.ChainRoot(s.quest)
            local g = byRoot[root]
            if not g then
                g = {}
                byRoot[root] = g
                groups[#groups + 1] = g
            end
            g[#g + 1] = { link = ns.QuestLink(s.quest, ns.StepTitle(s, d)), depth = depth, pos = #g }
        end
    end
    if #groups == 0 then return {} end

    local lines = { L("Quêtes de %s (%s) :", "Quests for %s (%s):"):format(d.name, d.levels) }
    -- one message per group, more when it does not fit (each starts with the label)
    local function AddGroup(label, links, sep)
        local line
        for _, link in ipairs(links) do
            if line and #line + #sep + #link > CHAT_MAX then
                lines[#lines + 1] = line
                line = nil
            end
            line = line and (line .. sep .. link) or (label .. " " .. link)
        end
        lines[#lines + 1] = line
    end
    local count, singles = 0, {}
    for _, g in ipairs(groups) do
        if #g == 1 then
            singles[#singles + 1] = g[1].link
        else
            table.sort(g, function(a, b)
                if a.depth ~= b.depth then return a.depth < b.depth end
                return a.pos < b.pos
            end)
            local links = {}
            for i, e in ipairs(g) do links[i] = e.link end
            count = count + 1
            AddGroup(L("Suite %d :", "Chain %d:"):format(count), links, " > ")
        end
    end
    if #singles > 0 then AddGroup(L("Quêtes seules :", "Single quests:"), singles, " ") end
    return lines
end

function G.ShareAllInChat()
    local function Refuse(fr, en) UIErrorsFrame:AddMessage(L(fr, en), 1, 0.1, 0.1) end
    local ch = Channel()
    if not ch then return Refuse("Tu n'es pas dans un groupe.", "You are not in a group.") end
    local d = ns.state and ns.state.dungeon
    local lines = d and G.QuestChatLines(d) or {}
    if #lines == 0 then return Refuse("Aucune quête à partager.", "No quest to share.") end
    if GetTime() < shareBusyUntil then return end -- a click while sending, or just after
    shareBusyUntil = GetTime() + #lines * CHAT_DELAY + 5
    local send = (C_ChatInfo and C_ChatInfo.SendChatMessage) or SendChatMessage
    local failed = false
    -- sent one at a time so the server does not drop messages
    for i, line in ipairs(lines) do
        C_Timer.After((i - 1) * CHAT_DELAY, function()
            if failed or Channel() ~= ch then return end
            if not pcall(send, line, ch) then
                failed = true
                Refuse("Impossible d'envoyer les quêtes dans le chat de groupe.", "Could not send the quests to the group chat.")
            end
        end)
    end
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
    local head = "S:" .. st.dungeon.key .. ":"
    local msg = head .. table.concat(parts, ",")
    if msg == lastSent then return end
    lastSent = msg
    -- an addon message holds 255 characters at most: long guides are sent in pieces
    -- (the receiver adds each piece to what it already knows)
    local line, len = {}, #head
    local function Flush()
        if #line > 0 then pcall(C_ChatInfo.SendAddonMessage, PREFIX, head .. table.concat(line, ","), ch) end
        line, len = {}, #head
    end
    for _, part in ipairs(parts) do
        if len + #part + 1 > 250 then Flush() end
        line[#line + 1] = part
        len = len + #part + 1
    end
    Flush()
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

----------------------------------------------------------------------
-- Version alert: "V:<version>" is sent to the guild and the group at login
-- and when the group changes. Hearing a newer version prints one line in
-- the chat (and a reminder at each login until the addon is updated).
-- Addons cannot check the internet: this only works when another player
-- with a newer version is in the guild or the group.
----------------------------------------------------------------------
local function VersionNumbers(v)
    local t = {}
    for n in tostring(v or ""):gmatch("%d+") do t[#t + 1] = tonumber(n) end
    return t
end
-- true when version a is newer than b
function G.IsNewer(a, b)
    local x, y = VersionNumbers(a), VersionNumbers(b)
    for i = 1, math.max(#x, #y) do
        local p, q = x[i] or 0, y[i] or 0
        if p ~= q then return p > q end
    end
    return false
end

local lastVersionSent, replied, warned = {}, {}, false
local function SendVersion(channel, target)
    if not DQF_DB.versionCheck then return end
    local now = GetTime()
    local key = channel .. (target or "")
    if lastVersionSent[key] and now - lastVersionSent[key] < 10 then return end
    lastVersionSent[key] = now
    pcall(C_ChatInfo.SendAddonMessage, PREFIX, "V:" .. ns.VERSION, channel, target)
end

function G.BroadcastVersion()
    if IsInGuild() then SendVersion("GUILD") end
    if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then SendVersion("INSTANCE_CHAT")
    elseif IsInRaid() then SendVersion("RAID")
    elseif IsInGroup() then SendVersion("PARTY") end
end

local function Warn(v)
    if warned then return end
    warned = true
    DEFAULT_CHAT_FRAME:AddMessage(("|cff33ff99Dungeon Quests Forever|r : " ..
        L("une nouvelle version est disponible (%s, tu as %s). Pense à mettre l'addon à jour !",
          "a new version is available (%s, you have %s). Remember to update the addon!")):format(v, ns.VERSION))
end

local function OnVersion(v, sender)
    if not DQF_DB.versionCheck then return end
    if G.IsNewer(v, ns.VERSION) then
        if not DQF_DB.newestVersion or G.IsNewer(v, DQF_DB.newestVersion) then DQF_DB.newestVersion = v end
        Warn(v)
    elseif G.IsNewer(ns.VERSION, v) and not replied[sender] then
        -- tell the player with the older version (a little later, once)
        replied[sender] = true
        C_Timer.After(1 + math.random() * 4, function() SendVersion("WHISPER", sender) end)
    end
end

----------------------------------------------------------------------
-- Quest text in the chat: "[Title (id)]" is what ns.QuestLink sends for a quest
-- that is not in the log. Questie makes it clickable for the quests it knows;
-- here the guide quests it does not know (or all of them without Questie) get
-- a link of ours, seen only by players who have this addon.
-- The link type must not contain "quest:": Questie would take it for its own.
----------------------------------------------------------------------
local LINK_TYPE = "dqfq"
local guideQuests

local function IsGuideQuest(q)
    if not guideQuests then
        guideQuests = {}
        for _, d in pairs(ns.dungeons) do
            for _, s in ipairs(d.steps) do
                if s.quest and s.quest > 0 then guideQuests[s.quest] = true end
            end
        end
    end
    return guideQuests[q]
end

local function LinkifyQuest(_, id)
    local q = tonumber(id)
    if not IsGuideQuest(q) or ns.Questie.QuestieKnows(q) then return nil end
    return ("|cffffff00|H%s:%d|h[%s]|h|r"):format(LINK_TYPE, q, ns.QuestInfo.Title(q))
end

function G.LinkifyChat(msg)
    return (msg:gsub("%[([^%[%]]-) %((%d+)%)%]", LinkifyQuest))
end

local function ChatFilter(_, _, msg, ...)
    if ns.IsSecret(msg) or type(msg) ~= "string" then return false, msg, ... end
    return false, G.LinkifyChat(msg), ...
end

-- What a click on our link shows
function G.FillQuestTooltip(tip, q)
    local QI = ns.QuestInfo
    tip:ClearLines()
    tip:AddLine(QI.Title(q), 1, 0.82, 0)
    local levels = ns.Questie.QuestLevels(q)
    if levels then tip:AddLine(levels, 0.8, 0.8, 0.8) end
    tip:AddLine(STATE_TEXT[ns.Progress.QuestState(q)] or "")
    local function AddPlace(label, kind)
        local s, d = QI.FindStep(q, kind)
        if not s then return end
        local who = s.npcKey and ns.NPCName(ns.StepNPC(s)) or s.text or d.name
        local map = ns.StepLocation(s)
        local where = map and ns.ZoneName(map) or d.name
        tip:AddLine("|cffffd100" .. label .. "|r" .. who .. " |cff999999(" .. where .. ")|r", 1, 1, 1, true)
    end
    tip:AddLine(" ")
    AddPlace(L("Début : ", "Starts: "), "accept")
    AddPlace(L("Fin : ", "Ends: "), "turnin")
    tip:AddLine(" ")
    tip:AddLine("Quest ID: " .. q, 0.5, 0.5, 0.5)
    tip:Show()
end

local function InstallChatLinks()
    local add = (ChatFrameUtil and ChatFrameUtil.AddMessageEventFilter) or ChatFrame_AddMessageEventFilter
    if add then
        for _, event in ipairs({ "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "RAID_WARNING",
            "INSTANCE_CHAT", "INSTANCE_CHAT_LEADER", "GUILD", "OFFICER", "WHISPER", "WHISPER_INFORM",
            "CHANNEL", "SAY", "YELL" }) do
            add("CHAT_MSG_" .. event, ChatFilter)
        end
    end

    -- Click: the game passes unknown link types to this tooltip
    local shown
    local setHyperlink = ItemRefTooltip.SetHyperlink
    function ItemRefTooltip:SetHyperlink(link, ...)
        local q = type(link) == "string" and tonumber(link:match("^" .. LINK_TYPE .. ":(%d+)$"))
        if not q then
            shown = nil
            return setHyperlink(self, link, ...)
        end
        if shown == q then -- second click on the same link closes it
            shown = nil
            self:Hide()
            return
        end
        shown = q
        G.FillQuestTooltip(self, q)
    end
    ItemRefTooltip:HookScript("OnHide", function() shown = nil end)

    -- Shift-click: the game puts our link in the edit box, where it could not be
    -- sent. Put back the text that can.
    local function OnClick(link)
        local q = type(link) == "string" and tonumber(link:match("^" .. LINK_TYPE .. ":(%d+)$"))
        local box = q and ChatEdit_GetActiveWindow and ChatEdit_GetActiveWindow()
        if not box or not IsModifiedClick("CHATLINK") then return end
        local text = "[" .. ns.QuestInfo.Title(q) .. " (" .. q .. ")]"
        box:SetText((box:GetText():gsub("|c%x+|H" .. LINK_TYPE .. ":" .. q .. "|h.-|h|r", function() return text end)))
    end
    if ChatFrameMixin and ChatFrameMixin.OnHyperlinkClick then
        for i = 1, NUM_CHAT_WINDOWS or 10 do
            local cf = _G["ChatFrame" .. i]
            if cf then cf:HookScript("OnHyperlinkClick", function(_, link) OnClick(link) end) end
        end
    elseif ChatFrame_OnHyperlinkShow then
        hooksecurefunc("ChatFrame_OnHyperlinkShow", function(_, link) OnClick(link) end)
    end
end

function G:Init()
    C_ChatInfo.RegisterAddonMessagePrefix(PREFIX)
    -- reminder: a newer version was seen before and the addon is still older
    if DQF_DB.newestVersion then
        if G.IsNewer(DQF_DB.newestVersion, ns.VERSION) then
            C_Timer.After(10, function() if DQF_DB.versionCheck then Warn(DQF_DB.newestVersion) end end)
        else
            DQF_DB.newestVersion = nil
        end
    end
    C_Timer.After(8, G.BroadcastVersion)
    ns:On("CHAT_MSG_ADDON", function(prefix, msg, _, sender)
        -- these values can be secret inside instances (not comparable)
        if ns.IsSecret(prefix) or ns.IsSecret(msg) or ns.IsSecret(sender) then return end
        if prefix ~= PREFIX then return end
        local name = Ambiguate(sender, "short")
        if name == UnitName("player") then return end
        local v = msg:match("^V:(.+)$")
        if v then OnVersion(v, sender) return end
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
                if Channel() then pcall(C_ChatInfo.SendAddonMessage, PREFIX, "REQ", Channel()) end
                G.Broadcast()
                G.BroadcastVersion()
            end)
        end
    end)
    InstallChatLinks() -- last: a client change here must not stop the group sync
end

function G:OnUpdate()
    G.Broadcast()
end
