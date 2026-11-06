local _, ns = ...
local L = ns.L
local W = ns.Widgets
local J = ns.Journal
local QI = ns.QuestInfo
local Q = {}

-- Quests tab: list of the dungeon quests (faction filter, level, class,
-- "starts inside", chain that can be unfolded) and the quest sheet.

local LIST_W, ROW_H, SUB_H = 300, 38, 22
local STATE_ICON = {
    [0] = "Interface\\GossipFrame\\AvailableQuestIcon",
    [1] = "Interface\\GossipFrame\\IncompleteQuestIcon",
    [2] = "Interface\\GossipFrame\\ActiveQuestIcon",
    [3] = "Interface\\RaidFrame\\ReadyCheck-Ready",
}
local INSIDE_ICON = "|A:Dungeon:14:14|a"
local function StateText(s)
    if s == 3 then return "|cff55ff55" .. L("Terminée", "Completed") .. "|r" end
    if s == 2 then return "|cff55ff55" .. L("À rendre", "Ready to turn in") .. "|r" end
    if s == 1 then return "|cffffff00" .. L("Dans le journal de quêtes", "In quest log") .. "|r" end
    return "|cffaaaaaa" .. L("Pas encore prise", "Not taken yet") .. "|r"
end

local function LevelLine(q)
    if QI.IsItemStep(q) then return L("Objet à ramasser", "Item to pick up") end
    local lvl = ns.Questie.QuestLevel(q)
    local req = ns.Questie.RequiredLevel(q)
    local parts = {}
    if lvl then parts[#parts + 1] = L("Niv. ", "Lv ") .. lvl end
    if req then
        local c = UnitLevel("player") < req and "|cffff4040" or "|cffaaaaaa"
        parts[#parts + 1] = c .. L("requis ", "req. ") .. req .. "|r"
    end
    return table.concat(parts, "  ")
end

local function ClassIcons(q, size)
    if QI.IsItemStep(q) then return "", nil end
    local classes = QI.Classes(ns.Questie.RequiredClasses(q))
    if not classes then return "", nil end
    local icons, names = {}, {}
    for _, c in ipairs(classes) do
        icons[#icons + 1] = QI.ClassIcon(c.file, size)
        names[#names + 1] = c.name
    end
    return table.concat(icons, ""), table.concat(names, ", ")
end

-- Location text of a step: "NPC - Zone (x, y)" or the step text
local function WhereText(step)
    if not step then return end
    local npc = ns.StepNPC(step)
    if npc then
        local s = "|cff33ff33" .. ns.NPCName(npc) .. "|r"
        local m, x, y = ns.StepLocation(step)
        if m then s = s .. "  -  " .. ns.ZoneName(m) .. (" |cffaaaaaa(%.1f, %.1f)|r"):format(x, y) end
        return s
    end
    return step.text
end

----------------------------------------------------------------------
-- List
----------------------------------------------------------------------
local function OnRowClick(r, btn)
    if btn == "RightButton" then J:Back() return end
    if IsShiftKeyDown() and not QI.IsItemStep(r.quest) and ns.InsertLink(ns.QuestLink(r.quest, QI.Title(r.quest, J.dungeon))) then return end
    Q:Select(r.quest)
end

local function CreateRow(parent)
    local r = W.Row(parent, ROW_H)
    r.icon:SetSize(18, 18)
    r.main:SetPoint("RIGHT", -28, 0)
    r.chain = CreateFrame("Button", nil, r)
    r.chain:SetSize(16, 16); r.chain:SetPoint("RIGHT", -6, 0)
    r.chain:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight", "ADD")
    r.chain:SetScript("OnClick", function(b)
        Q.expanded[b.quest] = not Q.expanded[b.quest] or nil
        Q:RefreshList()
    end)
    r.chain:SetScript("OnEnter", function(b)
        GameTooltip:SetOwner(b, "ANCHOR_RIGHT")
        GameTooltip:AddLine(L("Chaîne de quêtes : afficher les étapes", "Quest chain: show the steps"), 1, 1, 1)
        GameTooltip:Show()
    end)
    r.chain:SetScript("OnLeave", GameTooltip_Hide)
    r:SetScript("OnClick", OnRowClick)
    r:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:AddLine(QI.Title(self.quest, J.dungeon), 1, 0.82, 0)
        GameTooltip:AddLine(StateText(QI.State(self.quest)))
        GameTooltip:AddLine(L("Maj+clic : lien dans le chat", "Shift-click: link in chat"), 0.5, 0.5, 0.5)
        GameTooltip:Show()
    end)
    r:SetScript("OnLeave", GameTooltip_Hide)
    return r
end

local function CreateSubRow(parent)
    local r = W.Row(parent, SUB_H)
    r.icon:SetSize(12, 12)
    r.icon:SetPoint("LEFT", 26, 0)
    r.main:SetFontObject("GameFontHighlightSmall")
    r.main:ClearAllPoints()
    r.main:SetPoint("LEFT", r.icon, "RIGHT", 6, 0)
    r.main:SetPoint("RIGHT", -6, 0)
    r.sub:Hide()
    r.line = r:CreateTexture(nil, "BORDER")
    r.line:SetPoint("TOPLEFT", 17, 0); r.line:SetPoint("BOTTOMLEFT", 17, 0); r.line:SetWidth(1)
    r.line:SetColorTexture(1, 1, 1, 0.2)
    r:SetScript("OnClick", OnRowClick)
    return r
end

function Q:Build(f)
    self.expanded = {}
    local left = ns.Panel(f, "bg", nil, true)
    left:SetPoint("TOPLEFT"); left:SetPoint("BOTTOMLEFT"); left:SetWidth(LIST_W)
    left:SetBackdropColor(0, 0, 0, 0.3)
    if ns.BLIZZ then ns.Skin.MakeListBox(left) end
    self.left = left

    -- faction filter
    self.filters = {}
    local prev
    for _, fac in ipairs({ "Alliance", "Horde", "all" }) do
        local b = W.Button(left, "", 90, 20, function() Q:SetFaction(fac) end)
        if prev then b:SetPoint("LEFT", prev, "RIGHT", 4, 0) else b:SetPoint("TOPLEFT", 6, -6) end
        b.fac = fac
        self.filters[#self.filters + 1] = b
        prev = b
    end

    local list = W.ScrollArea(left)
    list:SetPoint("TOPLEFT", 4, -32); list:SetPoint("BOTTOMRIGHT", -4, 4)
    W.OnResize(list, function() if f:IsShown() then Q:RefreshList() end end)
    self.list = list
    self.rows = W.Pool(function() return CreateRow(list.child) end)
    self.subRows = W.Pool(function() return CreateSubRow(list.child) end)
    self.empty = W.Font(list.child, "GameFontDisable", true)
    self.empty:SetPoint("TOPLEFT", 10, -20)

    -- quest sheet
    local right = CreateFrame("Frame", nil, f)
    right:SetPoint("TOPLEFT", left, "TOPRIGHT", 8, 0); right:SetPoint("BOTTOMRIGHT")
    if ns.BLIZZ then ns.Skin.ListBox(right, 2) end
    self.right = right
    local bar = CreateFrame("Frame", nil, right)
    bar:SetPoint("TOPLEFT"); bar:SetPoint("TOPRIGHT"); bar:SetHeight(26)
    self.share = W.Button(bar, "", 90, 22, function() if Q.quest then ns.Group.Share(Q.quest) end end,
        function() return L("Partager la quête avec le groupe (elle doit être dans ton journal de quêtes).",
            "Share the quest with your group (it must be in your quest log).") end)
    self.share:SetPoint("RIGHT", -6, 0)
    self.mapBtn = W.Button(bar, "", 120, 22, function() Q:ShowStartOnMap() end,
        function() return L("Montre où prendre la quête sur la carte.", "Shows where to get the quest on the map.") end)
    self.mapBtn:SetPoint("RIGHT", self.share, "LEFT", -6, 0)
    self.linkBtn = W.Button(bar, "", 70, 22, function()
        if Q.quest then ns.InsertLink(ns.QuestLink(Q.quest, QI.Title(Q.quest, J.dungeon))) end
    end, function() return L("Mettre le lien de la quête dans le chat.", "Put the quest link in the chat.") end)
    self.linkBtn:SetPoint("RIGHT", self.mapBtn, "LEFT", -6, 0)
    self.bar = bar

    local detail = W.ScrollArea(right)
    detail:SetPoint("TOPLEFT", bar, "BOTTOMLEFT", 0, -4); detail:SetPoint("BOTTOMRIGHT")
    W.OnResize(detail, function() if f:IsShown() and Q.quest then Q:RefreshDetail(true) end end)
    self.detail = detail
    self.flow = W.Flow(detail, 12)
    -- clickable chain steps in the sheet
    self.chainRows = W.Pool(function()
        local r = CreateSubRow(detail.child)
        r.line:Hide()
        r.icon:SetPoint("LEFT", 4, 0)
        return r
    end)
end

function Q:SetFaction(fac)
    DQF_DB.journal.questFaction = fac
    self:RefreshList()
end

function Q:Faction()
    local f = DQF_DB.journal.questFaction or UnitFactionGroup("player")
    return f ~= "all" and f or nil
end

function Q:Show(d, arg)
    self.d = d
    if self.lastDungeon ~= d then
        -- entering a dungeon: back to the player's faction, first quest
        DQF_DB.journal.questFaction = UnitFactionGroup("player")
        self.lastDungeon, self.quest = d, nil
        self.list:ScrollToTop()
    end
    if arg then self.quest = arg end
    self:RefreshList()
    if not self.quest and self.visible[1] then self.quest = self.visible[1].quest end
    self:RefreshDetail()
end

function Q:Refresh() self:RefreshList(); self:RefreshDetail(true) end
function Q:Layout() end

function Q:RefreshList()
    local d = self.d
    if not d then return end
    local fac = self:Faction()
    for _, b in ipairs(self.filters) do
        local label = b.fac == "Alliance" and FACTION_ALLIANCE or b.fac == "Horde" and FACTION_HORDE or L("Les deux", "Both")
        local sel = (b.fac == "all" and not fac) or b.fac == fac
        b:SetLabel(sel and ("|cff" .. W.AccentHex() .. label .. "|r") or label)
    end
    self.visible = QI.VisibleQuests(d, fac)
    self.rows:ReleaseAll(); self.subRows:ReleaseAll()
    local w = self.list.child:GetWidth()
    local y = 0
    for _, e in ipairs(self.visible) do
        local q = e.quest
        local r = self.rows:Get()
        r.quest = q
        r:ClearAllPoints()
        r:SetPoint("TOPLEFT", 0, y); r:SetWidth(w)
        local state = QI.State(q)
        r.icon:SetTexture(STATE_ICON[state])
        local title = QI.Title(q, d)
        r.main:SetText(state == 3 and ("|cff88cc88" .. title .. "|r") or title)
        local icons = ""
        if e.faction then
            icons = icons .. (e.faction == "Horde" and "|TInterface\\TargetingFrame\\UI-PVP-Horde:14:14:0:0:64:64:0:40:0:40|t"
                or "|TInterface\\TargetingFrame\\UI-PVP-Alliance:14:14:0:0:64:64:0:40:0:40|t")
        end
        icons = icons .. ClassIcons(q, 12)
        if e.inside then icons = icons .. INSIDE_ICON end
        r.sub:SetText(LevelLine(q) .. "  " .. icons)
        r:SetSelected(q == self.quest)
        local chain = QI.Chain(q)
        r.chain.quest = q
        r.chain:SetShown(#chain > 1)
        r.chain:SetNormalTexture(self.expanded[q] and "Interface\\Buttons\\UI-MinusButton-Up" or "Interface\\Buttons\\UI-PlusButton-Up")
        y = y - ROW_H
        if self.expanded[q] and #chain > 1 then
            for i, cq in ipairs(chain) do
                local s = self.subRows:Get()
                s.quest = cq
                s:ClearAllPoints()
                s:SetPoint("TOPLEFT", 0, y); s:SetWidth(w)
                local cs = QI.State(cq)
                s.icon:SetTexture(STATE_ICON[cs])
                local t = ("%d. %s"):format(i, QI.Title(cq, d))
                if cq == q then t = "|cffffffff" .. t .. "|r" elseif cs == 3 then t = "|cff88cc88" .. t .. "|r" else t = "|cffbbbbbb" .. t .. "|r" end
                s.main:SetText(t)
                s:SetSelected(cq == self.quest)
                y = y - SUB_H
            end
        end
    end
    self.empty:SetWidth(w - 20)
    self.empty:SetText(#self.visible == 0 and (d.comingSoon and L("Guide en préparation : ce donjon n'est pas encore ouvert sur Forever.",
        "Guide in preparation: this dungeon is not open on Forever yet.")
        or L("Aucune quête pour ce filtre.", "No quest for this filter.")) or "")
    self.list:SetContentHeight(-y)
end

function Q:Select(q)
    self.quest = q
    DQF_DB.journal.quest = q
    self:RefreshList()
    self:RefreshDetail()
end

----------------------------------------------------------------------
-- Quest sheet
----------------------------------------------------------------------
-- quest entry in this dungeon, or in any guide
local function Entry(q, d)
    if d then
        QI.DungeonQuests(d)
        if d.questByID[q] then return d.questByID[q], d end
    end
    for _, key in ipairs(ns.dungeonOrder) do
        local dd = ns.dungeons[key]
        QI.DungeonQuests(dd)
        if dd.questByID[q] then return dd.questByID[q], dd end
    end
end

function Q:ShowStartOnMap()
    local e = self.quest and Entry(self.quest, self.d)
    local s = e and e.accept
    if not s then return end
    local m, x, y = ns.StepLocation(s)
    if not m then return end
    local npc = ns.StepNPC(s)
    ns.EntrancePins:ShowPoint(m, x, y, npc and ns.NPCName(npc) or QI.Title(self.quest), QI.Title(self.quest), npc)
end

function Q:RefreshDetail(keepScroll)
    local flow, q = self.flow, self.quest
    flow:Clear()
    self.chainRows:ReleaseAll()
    if not keepScroll then self.detail:ScrollToTop() end
    local showButtons = q ~= nil
    self.share:SetShown(showButtons); self.mapBtn:SetShown(showButtons); self.linkBtn:SetShown(showButtons and not QI.IsItemStep(q))
    if not q then flow:Finish() return end
    local e, d = Entry(q, self.d)
    local title = QI.Title(q, d or self.d)
    local state = QI.State(q)

    self.share:SetLabel(L("Partager", "Share")); self.share:FitText(24)
    self.share:SetEnabled(ns.Group.CanShare(q))
    self.share:SetAlpha(ns.Group.CanShare(q) and 1 or 0.45)
    self.mapBtn:SetLabel(L("Montrer sur la carte", "Show on map")); self.mapBtn:FitText(24)
    local start = e and e.accept and ns.StepLocation(e.accept)
    self.mapBtn:SetShown(start ~= nil)
    self.linkBtn:SetLabel(L("Lien", "Link")); self.linkBtn:FitText(24)

    -- title, state, level, classes
    flow:Text(title, { font = "GameFontNormalHuge", color = { 1, 0.82, 0 }, gap = 6 })
    local info = { StateText(state) }
    if QI.IsItemStep(q) then
        info[1] = state == 3 and ("|cff55ff55" .. L("Obtenu", "Obtained") .. "|r") or ("|cffaaaaaa" .. L("Pas encore obtenu", "Not obtained yet") .. "|r")
    end
    local lv = LevelLine(q)
    if lv ~= "" then info[#info + 1] = lv end
    local icons, names = ClassIcons(q, 14)
    if names then info[#info + 1] = icons .. " " .. names end
    if e and e.faction then info[#info + 1] = e.faction == "Horde" and FACTION_HORDE or FACTION_ALLIANCE end
    flow:Text(table.concat(info, "   "), { font = "GameFontHighlightSmall", color = { 0.85, 0.85, 0.85 }, gap = 2 })
    if d and d ~= self.d then
        flow:Text(L("Guide : ", "Guide: ") .. d.name, { font = "GameFontDisableSmall", color = { 0.6, 0.6, 0.6 } })
    end

    -- step without quest (a book to pick up...): what to do and where
    local ist = QI.ItemStep(q)
    if ist then
        flow:Heading(L("Objectif", "Objective"))
        if ist.text then flow:Text(ist.text, { color = { 0.9, 0.9, 0.9 } }) end
        local m, x, y = ns.StepLocation(ist)
        if m then
            flow:Heading(L("Lieu", "Location"))
            flow:Text(ns.ZoneName(m) .. (" |cffaaaaaa(%.1f, %.1f)|r"):format(x, y))
        end
        e = nil -- no start / end NPC
    end

    -- objective (Questie text, live objectives when in the log)
    local text = not ist and ns.Questie.ObjectivesText(q)
    local live = not ist and ns.Progress.Objectives(q)
    if text or (live and #live > 0) then
        flow:Heading(L("Objectif", "Objective"))
        if text then flow:Text(text, { color = { 0.9, 0.9, 0.9 } }) end
        if live and #live > 0 then
            for _, o in ipairs(live) do
                flow:Text("- " .. o.text, { color = o.done and { 0.3, 1, 0.3 } or { 1, 1, 1 }, indent = 6, gap = 2 })
            end
        end
    end

    -- where it starts / ends
    if e then
        flow:Heading(L("Début et fin", "Start and end"))
        local startText = WhereText(e.accept)
        if startText then
            flow:Text("|cffffd100" .. L("Début : ", "Starts: ") .. "|r" .. startText
                .. (e.inside and ("  " .. INSIDE_ICON .. " |cffaaaaaa" .. L("dans le donjon", "inside the dungeon") .. "|r") or ""))
        end
        local endText = WhereText(e.turnin)
        if endText then flow:Text("|cffffd100" .. L("Fin : ", "Ends: ") .. "|r" .. endText) end
        -- what the guide says to do
        local todo = {}
        for _, s in ipairs(e.steps) do
            if s.type == "do" and s.text then todo[#todo + 1] = s.text end
        end
        if #todo > 0 then
            flow:Space(2)
            for _, t in ipairs(todo) do flow:Text("|cff" .. W.AccentHex() .. "> |r" .. t, { indent = 4, gap = 2 }) end
        end
    end

    -- chain
    local chain = QI.Chain(q)
    if #chain > 1 then
        local pos, doneN = 1, 0
        for i, cq in ipairs(chain) do
            if cq == q then pos = i end
            if QI.State(cq) == 3 then doneN = doneN + 1 end
        end
        flow:Heading(("%s  |cffaaaaaa(%s %d/%d)|r"):format(L("Chaîne de quêtes", "Quest chain"), L("étape", "step"), pos, #chain))
        -- first earlier step not done yet
        for i = 1, pos - 1 do
            if QI.State(chain[i]) ~= 3 then
                flow:Text("|cffff5050" .. L("Nécessite d'abord : ", "Requires first: ") .. QI.Title(chain[i], d) .. "|r",
                    { font = "GameFontHighlightSmall", gap = 4 })
                break
            end
        end
        local w = flow:Width()
        for i, cq in ipairs(chain) do
            local r = self.chainRows:Get()
            r.quest = cq
            r:SetWidth(w)
            local cs = QI.State(cq)
            r.icon:SetTexture(STATE_ICON[cs])
            local t = ("%d. %s"):format(i, QI.Title(cq, d))
            r.main:SetText(cq == q and ("|cffffffff" .. t .. "|r") or (cs == 3 and ("|cff88cc88" .. t .. "|r") or ("|cffbbbbbb" .. t .. "|r")))
            r:SetSelected(cq == q)
            flow:Place(r, SUB_H)
        end
    end

    -- rewards
    local rw = QI.Rewards(q)
    if (rw.xp and rw.xp > 0) or (rw.money and rw.money > 0) or #rw.items > 0 or #rw.choice > 0 then
        flow:Heading(L("Récompenses", "Rewards"))
        local badges = {}
        if rw.xp and rw.xp > 0 then badges[#badges + 1] = ("|cff9999ff%s XP|r"):format(BreakUpLargeNumbers and BreakUpLargeNumbers(rw.xp) or rw.xp) end
        if rw.money and rw.money > 0 then badges[#badges + 1] = ns.MoneyString(rw.money) end
        if #badges > 0 then flow:Text(table.concat(badges, "     "), { gap = 6 }) end
        local src = L("Récompense de : ", "Reward from: ") .. title
        if #rw.choice > 0 then
            flow:Text(L("Au choix :", "Choose one:"), { font = "GameFontNormalSmall", color = { 0.8, 0.8, 0.8 } })
            local list = {}
            for _, id in ipairs(rw.choice) do list[#list + 1] = { id, { source = src } } end
            flow:Items(list)
        end
        if #rw.items > 0 then
            flow:Text(rw.possible and L("Objets possibles (au choix ou donnés) :", "Possible items (choice or given):")
                or L("Tu recevras :", "You will receive:"), { font = "GameFontNormalSmall", color = { 0.8, 0.8, 0.8 } })
            local list = {}
            for _, id in ipairs(rw.items) do list[#list + 1] = { id, { source = src } } end
            flow:Items(list)
        end
    end

    flow:Space(6)
    flow:Text("Quest ID: " .. q, { font = "GameFontDisableSmall", color = { 0.5, 0.5, 0.5 } })
    flow:Finish()
end

J:AddPage("quests", Q)
