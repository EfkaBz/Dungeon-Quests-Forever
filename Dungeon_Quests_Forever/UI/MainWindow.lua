local _, ns = ...
local L = ns.L
local UI = {}
ns.UI = UI
ns:RegisterModule(UI)

local ICONS = {
    accept = "Interface\\GossipFrame\\AvailableQuestIcon",
    turnin = "Interface\\GossipFrame\\ActiveQuestIcon",
    talk   = "Interface\\GossipFrame\\GossipGossipIcon",
    ["do"] = "Interface\\TargetingFrame\\UI-TargetingFrame-Skull",
}
ns.STEP_ICONS = ICONS
local VERB = {}
ns.OnLocalize(function()
    VERB.accept, VERB.turnin = L("Accepter", "Accept"), L("Rendre", "Turn in")
    VERB.talk, VERB.go = L("Parler à", "Talk to"), L("Aller voir", "Go to")
end)

-- Objectives of a "do" step as a short string ("5/8 Trogg, 2/8 Shaman")
local function ObjectiveText(step)
    local obj = ns.Progress.Objectives(step.quest)
    if not obj or #obj == 0 then return end
    local parts = {}
    for _, o in ipairs(obj) do
        parts[#parts + 1] = (o.done and "|cff55ff55" or "|cffffffff") .. o.text .. "|r"
    end
    return table.concat(parts, ", ")
end

-- The two text lines shown for a step (main line, sub line)
function ns.StepLines(step)
    local title = ns.StepTitle(step)
    if step.type == "do" then
        return step.text, (not step.done and ObjectiveText(step)) or title
    end
    if not step.npcKey then return step.text, VERB[step.type] .. " " .. title end -- e.g. quest started by an item
    local npc = "|cff33ff33" .. ns.NPCName(ns.StepNPC(step)) .. "|r"
    if step.type == "talk" then return VERB.talk .. " " .. npc, step.text end
    return VERB.go .. " " .. npc, VERB[step.type] .. " " .. title
end

local function Font(parent, template)
    local fs = parent:CreateFontString(nil, "OVERLAY", template)
    fs:SetJustifyH("LEFT"); fs:SetWordWrap(false)
    return fs
end

----------------------------------------------------------------------
-- Tooltip: quest info, objectives, rewards, group status
----------------------------------------------------------------------
-- Reward APIs differ between client versions (some need the questID):
-- try with the questID first, then without, and never let an error escape.
local function Try(fn, ...)
    if not fn then return end
    local r = { pcall(fn, ...) }
    if r[1] then return select(2, unpack(r)) end
end
local function TryQ(fn, q, ...)
    if not fn then return end
    local r = { pcall(fn, q, ...) }
    if r[1] then return select(2, unpack(r)) end
    return Try(fn, ...)
end

-- Coin string with icons; the global helper does not exist on every client
function ns.MoneyString(copper)
    local fn = (C_CurrencyInfo and C_CurrencyInfo.GetCoinTextureString) or GetCoinTextureString or GetMoneyString
    local s = fn and Try(fn, copper)
    if s then return s end
    local g, sv, c = floor(copper / 10000), floor(copper / 100) % 100, copper % 100
    local icon = "|TInterface\\MoneyFrame\\UI-%sIcon:0:0:2:0|t"
    local out = {}
    if g > 0 then out[#out + 1] = g .. icon:format("Gold") end
    if sv > 0 then out[#out + 1] = sv .. icon:format("Silver") end
    if c > 0 or #out == 0 then out[#out + 1] = c .. icon:format("Copper") end
    return table.concat(out, " ")
end

local function CollectRewards(q)
    local xp = TryQ(GetQuestLogRewardXP, q)
    local money = TryQ(GetQuestLogRewardMoney, q) or 0
    local items = {}
    for j = 1, TryQ(GetNumQuestLogRewards, q) or 0 do
        local name, tex, count = Try(GetQuestLogRewardInfo, j)
        if name then items[#items + 1] = ("|T%s:14|t %s%s"):format(tex or "", name, (count or 1) > 1 and (" x" .. count) or "") end
    end
    for j = 1, TryQ(GetNumQuestLogChoices, q) or 0 do
        local name, tex = Try(GetQuestLogChoiceInfo, j)
        if name then items[#items + 1] = ("|T%s:14|t %s |cff999999(%s)|r"):format(tex or "", name, L("au choix", "choice")) end
    end
    return xp, money, items
end

local function AddRewards(q)
    local i = ns.Progress.LogIndex(q)
    if not i then return end
    local prev = GetQuestLogSelection()
    SelectQuestLogEntry(i)
    local ok, xp, money, items = pcall(CollectRewards, q)
    SelectQuestLogEntry(prev or 0)
    if not ok then return end
    if (xp and xp > 0) or money > 0 or #items > 0 then
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(L("Récompenses :", "Rewards:"), 1, 0.82, 0)
        if xp and xp > 0 then GameTooltip:AddLine(xp .. " XP", 0.6, 0.6, 1) end
        if money > 0 then GameTooltip:AddLine(ns.MoneyString(money), 1, 1, 1) end
        for _, t in ipairs(items) do GameTooltip:AddLine(t, 1, 1, 1) end
    end
end

function ns.StepTooltip(owner, step, anchor)
    GameTooltip:SetOwner(owner, anchor or "ANCHOR_RIGHT")
    GameTooltip:AddLine(ns.StepTitle(step), 1, 0.82, 0)
    local m, x, y = ns.StepLocation(step)
    if m then GameTooltip:AddLine(("%s (%.1f, %.1f)"):format(ns.ZoneName(m), x, y), 1, 1, 1)
    else GameTooltip:AddLine(ns.CurrentDungeon().name, 1, 1, 1) end
    local lvl = ns.Questie and ns.Questie.QuestLevels(step.quest)
    if lvl then GameTooltip:AddLine(lvl, 0.8, 0.8, 0.8) end
    local obj = ns.Progress.Objectives(step.quest)
    if obj and #obj > 0 then
        GameTooltip:AddLine(" ")
        for _, o in ipairs(obj) do
            if o.done then GameTooltip:AddLine("- " .. o.text, 0.3, 1, 0.3)
            else GameTooltip:AddLine("- " .. o.text, 1, 1, 1) end
        end
    end
    AddRewards(step.quest)
    if ns.Group then ns.Group.AddTooltipLines(step.quest) end
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine("Quest ID: " .. step.quest, 0.5, 0.5, 0.5)
    GameTooltip:AddLine(L("Clic droit : menu", "Right-click: menu"), 0.4, 0.8, 1)
    GameTooltip:Show()
end

----------------------------------------------------------------------
-- Look: "quest journal" - one flat window, a header with the dungeon,
-- a "current objective" card and a timeline of steps (dots + line).
----------------------------------------------------------------------
local HEADER_H, CARD_MIN, GAP, FOOT_H = 46, 56, 6, 16
local ROW_MIN = 30
local MIN_W, MAX_W, MAX_H = 230, 600, 900
local DOT = 12

-- type tag shown above each step
local TYPE_COLOR = {
    accept = { 1, 0.82, 0.1 }, turnin = { 0.35, 1, 0.35 },
    ["do"] = { 1, 0.45, 0.35 }, talk = { 0.45, 0.75, 1 },
}
local TAG = {}
ns.OnLocalize(function()
    TAG.accept, TAG.turnin = L("ACCEPTER", "ACCEPT"), L("RENDRE", "TURN IN")
    TAG["do"], TAG.talk = L("OBJECTIF", "OBJECTIVE"), L("PARLER", "TALK")
end)
local function TagText(step, pos)
    local c = TYPE_COLOR[step.type] or { 1, 1, 1 }
    local num = pos and ("|cff777777%02d|r  "):format(pos) or ""
    return num .. ("|cff%02x%02x%02x%s|r"):format(c[1] * 255, c[2] * 255, c[3] * 255, TAG[step.type] or "")
end

-- Small square checkbox (used on the objective card)
local function CheckBox(parent, size)
    local c = ns.Panel(parent, "bg", "CheckButton", true)
    c:SetSize(size, size)
    c:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
    c:SetHighlightTexture("Interface\\Buttons\\WHITE8X8")
    c:GetHighlightTexture():SetVertexColor(1, 1, 1, 0.15)
    c:SetScript("OnClick", function(self) UI:ToggleStep(self.step, self:GetChecked()) end)
    c:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        if self.step and self.step.auto then
            GameTooltip:AddLine(L("Validée automatiquement (quête détectée)", "Auto-completed (quest detected)"), 0.4, 1, 0.4)
        end
        GameTooltip:AddLine(L("Cliquer pour valider/annuler l'étape", "Click to check/uncheck this step"), 1, 1, 1)
        GameTooltip:Show()
    end)
    c:SetScript("OnLeave", GameTooltip_Hide)
    return c
end

-- Timeline dot = the step's checkbox (click to validate / un-validate)
local function Dot(parent)
    local d = CreateFrame("Button", nil, parent)
    d:SetSize(DOT, DOT)
    d.tex = d:CreateTexture(nil, "ARTWORK")
    d.tex:SetAllPoints()
    d:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    d:SetScript("OnClick", function(self) if self.step then UI:ToggleStep(self.step, not self.step.done) end end)
    d:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        if self.step and self.step.auto then
            GameTooltip:AddLine(L("Validée automatiquement (quête détectée)", "Auto-completed (quest detected)"), 0.4, 1, 0.4)
        end
        GameTooltip:AddLine(L("Cliquer pour valider/annuler l'étape", "Click to check/uncheck this step"), 1, 1, 1)
        GameTooltip:Show()
    end)
    d:SetScript("OnLeave", GameTooltip_Hide)
    return d
end

local function CreateRow(parent)
    local r = CreateFrame("Button", nil, parent)
    r:SetHeight(ROW_MIN)
    r.current = r:CreateTexture(nil, "BACKGROUND")
    r.current:SetAllPoints()
    -- timeline: line above and below the dot
    r.lineTop = r:CreateTexture(nil, "BORDER")
    r.lineTop:SetWidth(2); r.lineTop:SetPoint("TOP", r, "TOPLEFT", 12, 0)
    r.lineBot = r:CreateTexture(nil, "BORDER")
    r.lineBot:SetWidth(2); r.lineBot:SetPoint("BOTTOM", r, "BOTTOMLEFT", 12, 0)
    r.dot = Dot(r)
    r.dot:SetPoint("TOPLEFT", 6, -6)
    r.lineTop:SetPoint("BOTTOM", r.dot, "TOP", 0, 1)
    r.lineBot:SetPoint("TOP", r.dot, "BOTTOM", 0, -1)

    r.tag = Font(r, "GameFontNormalSmall")
    r.tag:SetPoint("TOPLEFT", 26, -5)
    r.main = Font(r, "GameFontHighlightSmall")
    r.main:SetPoint("TOPLEFT", r.tag, "BOTTOMLEFT", 0, -2)
    r.main:SetWordWrap(true)
    r.sub = Font(r, "GameFontDisableSmall")
    r.sub:SetPoint("TOPLEFT", r.main, "BOTTOMLEFT", 0, -2)
    r.sub:SetWordWrap(true)

    r:SetHighlightTexture("Interface\\Buttons\\WHITE8X8")
    r:GetHighlightTexture():SetVertexColor(1, 1, 1, 0.05)
    r:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    r:SetScript("OnClick", function(self, btn)
        if btn == "RightButton" then UI:StepMenu(self, self.step) else UI:SetWaypoint(self.step) end
    end)
    r:SetScript("OnEnter", function(self) if self.step then ns.StepTooltip(self, self.step) end end)
    r:SetScript("OnLeave", GameTooltip_Hide)
    return r
end

local function IconButton(parent, tex, tip, onClick)
    local b = CreateFrame("Button", nil, parent)
    b:SetSize(16, 16)
    b:SetNormalTexture(tex)
    b:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    b:SetScript("OnClick", onClick)
    b:SetScript("OnEnter", function(s)
        GameTooltip:SetOwner(s, "ANCHOR_TOP"); GameTooltip:AddLine(tip()); GameTooltip:Show()
    end)
    b:SetScript("OnLeave", GameTooltip_Hide)
    return b
end

----------------------------------------------------------------------
-- Main window
----------------------------------------------------------------------
function UI:Init()
    local f = ns.Panel(UIParent)
    _G.DQF_Frame = f
    local size = DQF_DB.size
    f:SetSize(size and size[1] or 280, size and size[2] or 360)
    f:SetClampedToScreen(true); f:EnableMouse(true); f:SetMovable(true); f:SetResizable(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(s)
        if DQF_DB.locked or InCombatLockdown() then return end
        s:StartMoving()
        UI.moving = true
    end)
    f:SetScript("OnDragStop", function() UI:StopDrag() end)
    self.frame, self.offset, self.rows, self.visible = f, 0, {}, 0
    local function Drag(region)
        region:EnableMouse(true); region:RegisterForDrag("LeftButton")
        region:SetScript("OnDragStart", function() f:GetScript("OnDragStart")(f) end)
        region:SetScript("OnDragStop", function() f:GetScript("OnDragStop")(f) end)
    end

    -- Header: accent stripe, dungeon icon, name, levels, buttons, progress line
    local head = CreateFrame("Frame", nil, f)
    head:SetPoint("TOPLEFT", 1, -1); head:SetPoint("TOPRIGHT", -1, -1); head:SetHeight(HEADER_H)
    Drag(head)
    head:SetScript("OnMouseUp", function(s, btn) if btn == "RightButton" then UI:MainMenu(s) end end)
    head:SetScript("OnEnter", function(s)
        GameTooltip:SetOwner(s, "ANCHOR_TOP")
        GameTooltip:AddLine(L("Clic droit : menu (guides, options...)", "Right-click: menu (guides, options...)"), 1, 1, 1)
        GameTooltip:Show()
    end)
    head:SetScript("OnLeave", GameTooltip_Hide)
    head.bg = head:CreateTexture(nil, "BACKGROUND")
    head.bg:SetAllPoints()
    head.stripe = head:CreateTexture(nil, "ARTWORK")
    head.stripe:SetPoint("TOPLEFT"); head.stripe:SetPoint("BOTTOMLEFT"); head.stripe:SetWidth(3)
    head.iconFrame = ns.Panel(head, "bg", nil, true)
    head.iconFrame:SetSize(30, 30); head.iconFrame:SetPoint("LEFT", 10, 0)
    head.icon = head.iconFrame:CreateTexture(nil, "ARTWORK")
    head.icon:SetPoint("TOPLEFT", 1, -1); head.icon:SetPoint("BOTTOMRIGHT", -1, 1)
    head.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    head.name = Font(head, "GameFontHighlight")
    head.name:SetPoint("TOPLEFT", head.iconFrame, "TOPRIGHT", 8, -2)
    head.name:SetPoint("RIGHT", -50, 0)
    head.info = Font(head, "GameFontDisableSmall")
    head.info:SetPoint("TOPLEFT", head.name, "BOTTOMLEFT", 0, -3)
    head.info:SetPoint("RIGHT", -50, 0)
    head.menu = IconButton(head, "Interface\\Buttons\\UI-OptionsButton",
        function() return L("Guides et options", "Guides and options") end, function(b) UI:MainMenu(b) end)
    head.menu:SetPoint("TOPRIGHT", -8, -8)
    head.collapse = IconButton(head, "Interface\\Buttons\\UI-MinusButton-Up",
        function() return DQF_DB.collapsed and L("Déplier", "Expand") or L("Replier", "Collapse") end,
        function() UI:SetCollapsed(not DQF_DB.collapsed) end)
    head.collapse:SetPoint("RIGHT", head.menu, "LEFT", -4, 0)
    -- progress line along the bottom of the header
    head.prog = CreateFrame("StatusBar", nil, head)
    head.prog:SetPoint("BOTTOMLEFT", 3, 0); head.prog:SetPoint("BOTTOMRIGHT"); head.prog:SetHeight(3)
    head.prog:SetStatusBarTexture("Interface\\Buttons\\WHITE8X8")
    head.prog.bg = head.prog:CreateTexture(nil, "BACKGROUND")
    head.prog.bg:SetAllPoints(); head.prog.bg:SetColorTexture(0, 0, 0, 0.5)
    self.head = head

    -- Current objective card
    local card = CreateFrame("Frame", nil, f)
    card:SetPoint("TOPLEFT", head, "BOTTOMLEFT", 6, -GAP); card:SetPoint("TOPRIGHT", head, "BOTTOMRIGHT", -6, -GAP)
    card:SetHeight(CARD_MIN)
    Drag(card)
    card:SetScript("OnMouseUp", function(s, btn)
        if btn == "RightButton" and ns.state and ns.state.step then UI:StepMenu(s, ns.state.step) end
    end)
    card:SetScript("OnEnter", function(s) if ns.state and ns.state.step then ns.StepTooltip(s, ns.state.step) end end)
    card:SetScript("OnLeave", GameTooltip_Hide)
    card.bg = card:CreateTexture(nil, "BACKGROUND")
    card.bg:SetAllPoints()
    card.edge = card:CreateTexture(nil, "BORDER")
    card.edge:SetPoint("TOPLEFT"); card.edge:SetPoint("BOTTOMLEFT"); card.edge:SetWidth(2)
    card.label = Font(card, "GameFontNormalSmall")
    card.label:SetPoint("TOPLEFT", 10, -7)
    card.check = CheckBox(card, 14)
    card.check:SetPoint("TOPRIGHT", -8, -6)
    card.main = Font(card, "GameFontHighlight")
    card.main:SetPoint("TOPLEFT", card.label, "BOTTOMLEFT", 0, -5)
    card.main:SetWordWrap(true)
    card.sub = Font(card, "GameFontNormal")
    card.sub:SetPoint("TOPLEFT", card.main, "BOTTOMLEFT", 0, -4)
    card.sub:SetWordWrap(true)
    self.card = card

    -- Footer: version + resize grip
    local foot = CreateFrame("Frame", nil, f)
    foot:SetPoint("BOTTOMLEFT", 1, 1); foot:SetPoint("BOTTOMRIGHT", -1, 1); foot:SetHeight(FOOT_H)
    Drag(foot)
    foot.text = Font(foot, "GameFontDisableSmall")
    foot.text:SetPoint("LEFT", 8, 0)
    local grip = CreateFrame("Button", nil, foot)
    grip:SetSize(14, 14); grip:SetPoint("BOTTOMRIGHT", -2, 2)
    grip:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    grip:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
    grip:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    grip:SetScript("OnMouseDown", function()
        if DQF_DB.locked or DQF_DB.collapsed or InCombatLockdown() then return end
        UI:AnchorTopLeft() -- keep the top-left corner fixed while resizing
        f:StartSizing("BOTTOMRIGHT")
        UI.sizing = true
    end)
    grip:SetScript("OnMouseUp", function() UI:StopDrag() end)
    grip:SetScript("OnEnter", function(b)
        GameTooltip:SetOwner(b, "ANCHOR_TOP"); GameTooltip:AddLine(L("Glisser pour redimensionner", "Drag to resize")); GameTooltip:Show()
    end)
    grip:SetScript("OnLeave", GameTooltip_Hide)
    self.foot = foot

    -- Timeline list (fills the space between the card and the footer)
    local list = CreateFrame("Frame", nil, f)
    list:SetPoint("TOPLEFT", card, "BOTTOMLEFT", -6, -GAP); list:SetPoint("TOPRIGHT", card, "BOTTOMRIGHT", 6, -GAP)
    list:SetPoint("BOTTOM", foot, "TOP", 0, 2)
    list:EnableMouseWheel(true)
    list:SetScript("OnMouseWheel", function(_, d) UI:Scroll(-d) end)
    list.sep = list:CreateTexture(nil, "BORDER")
    list.sep:SetPoint("TOPLEFT", 8, GAP / 2); list.sep:SetPoint("TOPRIGHT", -8, GAP / 2); list.sep:SetHeight(1)
    list.sep:SetColorTexture(1, 1, 1, 0.08)
    self.list = list

    -- thin scroll bar on the right edge (drag the thumb, or use the wheel)
    local bar = CreateFrame("Slider", nil, list, "BackdropTemplate")
    bar:SetOrientation("VERTICAL")
    bar:SetWidth(4)
    bar:SetPoint("TOPRIGHT", -4, -2); bar:SetPoint("BOTTOMRIGHT", -4, 2)
    bar:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" })
    bar:SetBackdropColor(1, 1, 1, 0.06)
    bar:SetThumbTexture("Interface\\Buttons\\WHITE8X8")
    bar:GetThumbTexture():SetSize(4, 30)
    bar:SetValueStep(1)
    bar:SetObeyStepOnDrag(true)
    bar:SetMinMaxValues(0, 0)
    bar:EnableMouseWheel(true)
    bar:SetScript("OnMouseWheel", function(_, d) UI:Scroll(-d) end)
    bar:SetScript("OnValueChanged", function(_, v, userInput)
        if not userInput or UI.updatingBar then return end
        v = math.floor(v + 0.5)
        if v ~= UI.offset then UI.offset = v; UI:OnUpdate(ns.state) end
    end)
    self.bar = bar

    list:SetScript("OnSizeChanged", function() UI:Layout() end)
    self:RestorePosition()
    self:ApplySettings()
    self:ApplyAccent()
    self:SetCollapsed(DQF_DB.collapsed, true)
    f:SetShown(DQF_DB.shown)
end

-- Collapsed = header + current objective card (the step list is hidden)
function UI:SetCollapsed(collapsed, init)
    if InCombatLockdown() and not init then return end
    DQF_DB.collapsed = collapsed and true or false
    local f = self.frame
    local minH = DQF_DB.collapsed and (HEADER_H + 2) or (HEADER_H + GAP + CARD_MIN + GAP + 2 * ROW_MIN + FOOT_H + 6)
    if f.SetResizeBounds then f:SetResizeBounds(MIN_W, minH, MAX_W, MAX_H)
    else f:SetMinResize(MIN_W, minH); f:SetMaxResize(MAX_W, MAX_H) end
    self.list:SetShown(not DQF_DB.collapsed)
    self.foot:SetShown(not DQF_DB.collapsed)
    self.head.collapse:SetNormalTexture(DQF_DB.collapsed and "Interface\\Buttons\\UI-PlusButton-Up" or "Interface\\Buttons\\UI-MinusButton-Up")
    if DQF_DB.collapsed then
        f:SetHeight(HEADER_H + GAP + CARD_MIN + GAP) -- adjusted to the card in OnUpdate
    else
        f:SetHeight(math.max(minH, DQF_DB.size and DQF_DB.size[2] or 360))
    end
    if ns.state then self:OnUpdate(ns.state) end
end

-- Re-render when the window size changes (texts re-wrap, rows are re-placed)
function UI:Layout()
    if ns.state then self:OnUpdate(ns.state) end
end

function UI:ApplyAccent()
    local t = ns.Theme()
    local a = t.accent
    self.head.bg:SetColorTexture(t.bar[1], t.bar[2], t.bar[3], 0.9)
    self.head.stripe:SetColorTexture(a[1], a[2], a[3], 1)
    self.head.prog:SetStatusBarColor(a[1], a[2], a[3])
    self.card.bg:SetColorTexture(1, 1, 1, 0.05)
    self.card.edge:SetColorTexture(a[1], a[2], a[3], 0.9)
    self.bar:GetThumbTexture():SetVertexColor(a[1], a[2], a[3], 0.9)
    if ns.state then self:OnUpdate(ns.state) end
end

function UI:ApplySettings()
    self.frame:SetScale(DQF_DB.scale)
    self.frame:SetAlpha(DQF_DB.alpha)
end

-- Always keep the window anchored by its top-left corner (stable moving/resizing)
-- The window holds secure buttons (targets / quest item), so the game forbids
-- stopping a move or resize during combat: finish it when combat ends.
function UI:StopDrag()
    if not (self.moving or self.sizing) then return end
    if InCombatLockdown() then
        self.pendingStop = true
        return
    end
    local f = self.frame
    f:StopMovingOrSizing()
    if self.sizing then DQF_DB.size = { f:GetWidth(), f:GetHeight() } end
    self.moving, self.sizing, self.pendingStop = false, false, false
    self:AnchorTopLeft(true)
end

ns:On("PLAYER_REGEN_ENABLED", function()
    if UI.pendingStop then UI:StopDrag() end
    ns.RequestUpdate() -- apply size changes that were skipped during combat
end)
ns:On("PLAYER_REGEN_DISABLED", function()
    -- combat starts while dragging: stop right now, it is still allowed
    if UI.moving or UI.sizing then UI:StopDrag() end
end)

function UI:AnchorTopLeft(save)
    if InCombatLockdown() then return end
    local f = self.frame
    local l, t = f:GetLeft(), f:GetTop()
    if not (l and t) then return end
    f:ClearAllPoints()
    f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", l, t)
    if save then DQF_DB.pos = { "TOPLEFT", "BOTTOMLEFT", l, t } end
end

function UI:RestorePosition()
    local f = self.frame; f:ClearAllPoints()
    local p = DQF_DB.pos
    if p then f:SetPoint(p[1], UIParent, p[2], p[3], p[4]) else f:SetPoint("RIGHT", UIParent, "RIGHT", -80, 60) end
    self:AnchorTopLeft()
end

function UI:Toggle(show)
    -- the docked target/item buttons are secure: the game forbids hiding them in combat
    if InCombatLockdown() then
        UIErrorsFrame:AddMessage(L("Impossible pendant un combat.", "Not possible in combat."), 1, 0.1, 0.1)
        return
    end
    if show == nil then show = not self.frame:IsShown() end
    DQF_DB.shown = show
    self.frame:SetShown(show)
    if show then ns.Update(true) end
end

-- Steps displayed in the list (optionally without the done ones)
function UI:DisplayList(d)
    if not DQF_DB.hideDone then return d.list end
    local t = {}
    for _, s in ipairs(d.list) do if not s.done then t[#t + 1] = s end end
    return t
end

function UI:Scroll(delta)
    local st = ns.state
    if not st then return end
    self.offset = math.min(self.maxOffset or 0, math.max(0, self.offset + delta))
    self:OnUpdate(st)
end

function UI:SetWaypoint(step)
    if not (step and TomTom and TomTom.AddWaypoint) then return end
    local m, x, y = ns.StepTarget(step, ns.CurrentDungeon())
    if m then TomTom:AddWaypoint(m, x / 100, y / 100, { title = ns.StepTitle(step) }) end
end

function UI:ToggleStep(step, checked)
    if not step then return end
    ns.Progress.SetManual(ns.CurrentDungeon(), step.uid, checked and true or false)
    ns.Update()
end

function UI:GoToStep(step)
    ns.Progress.GoToStep(ns.CurrentDungeon(), step.pos)
    ns.Update(true)
end

function UI:SelectDungeon(key)
    DQF_DB.dungeon, self.offset = key, 0
    ns.Update(true)
end

----------------------------------------------------------------------
-- Menus (MenuUtil when available, UIDropDownMenu otherwise)
-- items: { {text, func, checked = fn?, isTitle = bool?}, ... }
----------------------------------------------------------------------
-- items: { {text, func, checked = fn?, check = bool?, isTitle = bool?, children = items?}, ... }
-- An item with `children` opens a submenu on mouse-over.
local function FillMenu(root, items)
    for _, it in ipairs(items) do
        if it.isTitle then root:CreateTitle(it[1])
        elseif it.children then FillMenu(root:CreateButton(it[1]), it.children)
        elseif it.check then root:CreateCheckbox(it[1], it.checked, it[2])
        elseif it.checked then root:CreateRadio(it[1], it.checked, it[2])
        else root:CreateButton(it[1], it[2]) end
    end
end

function ns.ShowMenu(anchor, items)
    if MenuUtil and MenuUtil.CreateContextMenu then
        MenuUtil.CreateContextMenu(anchor, function(_, root) FillMenu(root, items) end)
        return
    end
    UI.dropdown = UI.dropdown or CreateFrame("Frame", "DQF_Menu", UIParent, "UIDropDownMenuTemplate")
    UIDropDownMenu_Initialize(UI.dropdown, function(_, level, menuList)
        for _, it in ipairs(menuList or items) do
            local info = UIDropDownMenu_CreateInfo()
            info.text, info.func, info.isTitle = it[1], it[2], it.isTitle
            info.notCheckable = not it.checked
            if it.checked then info.checked = it.checked(); info.isNotRadio = it.check end
            if it.children then
                info.hasArrow, info.menuList, info.func = true, it.children, nil
                info.keepShownOnClick = true
            end
            UIDropDownMenu_AddButton(info, level)
        end
    end, "MENU")
    ToggleDropDownMenu(1, nil, UI.dropdown, "cursor", 0, 0)
end

function UI:StepMenu(anchor, step)
    if not step then return end
    local items = {
        { ("%02d - %s"):format(step.pos, ns.StepTitle(step)), isTitle = true },
        { L("Revenir à cette étape", "Go back to this step"), function() UI:GoToStep(step) end },
        { step.done and L("Marquer comme non faite", "Mark as not done") or L("Marquer comme faite", "Mark as done"),
          function() UI:ToggleStep(step, not step.done) end },
    }
    if ns.Group.CanShare(step.quest) then
        items[#items + 1] = { L("Partager la quête au groupe", "Share quest with group"), function() ns.Group.Share(step.quest) end }
    end
    if TomTom and ns.StepTarget(step, ns.CurrentDungeon()) then
        items[#items + 1] = { L("Waypoint TomTom", "TomTom waypoint"), function() UI:SetWaypoint(step) end }
    end
    ns.ShowMenu(anchor, items)
end

-- Guides grouped as "Dungeon guides (faction)" > level bracket > dungeon
function UI:GuideTree()
    local faction = UnitFactionGroup("player")
    local brackets, order = {}, {}
    local keys, overworld = {}, {}
    for _, key in ipairs(ns.dungeonOrder) do
        local d = ns.dungeons[key]
        if d.overworld then overworld[#overworld + 1] = key
        elseif not d.faction or d.faction == faction then keys[#keys + 1] = key end
    end
    table.sort(keys, function(a, b)
        return (tonumber(ns.dungeons[a].levels:match("^(%d+)")) or 0) < (tonumber(ns.dungeons[b].levels:match("^(%d+)")) or 0)
    end)
    for _, key in ipairs(keys) do
        local d = ns.dungeons[key]
        local lo = math.floor((tonumber(d.levels:match("^(%d+)")) or 0) / 10) * 10
        local name = ("%d-%d"):format(lo, lo + 10)
        if not brackets[name] then
            brackets[name] = {}
            order[#order + 1] = name
        end
        local label = d.levels .. "  " .. d.name
        if d.new then label = label .. "  |cff33ff99" .. L("(Forever)", "(Forever)") .. "|r" end
        if d.comingSoon then label = "|cff888888" .. label .. "  " .. L("(bientôt)", "(coming soon)") .. "|r" end
        table.insert(brackets[name], { label, function() UI:SelectDungeon(key) end,
            checked = function() return DQF_DB.dungeon == key end })
    end
    local byLevel = {}
    for _, name in ipairs(order) do
        byLevel[#byLevel + 1] = { L("Niveaux ", "Levels ") .. name, children = brackets[name] }
    end
    local label = L("Guides de donjon", "Dungeon guides") .. " (" .. (faction == "Horde" and "H" or "A") .. ")"
    if #byLevel == 0 then byLevel[1] = { L("Aucun guide", "No guide"), isTitle = true } end
    local function Flat(list)
        local t = {}
        for _, key in ipairs(list) do
            local d = ns.dungeons[key]
            t[#t + 1] = { d.levels .. "  " .. d.name, function() UI:SelectDungeon(key) end,
                checked = function() return DQF_DB.dungeon == key end }
        end
        if #t == 0 then t[1] = { L("Aucun guide", "No guide"), isTitle = true } end
        return t
    end
    return { { label, children = byLevel }, { L("Monde (Over World)", "Over World"), children = Flat(overworld) } }
end

function UI:MainMenu(anchor)
    local items = { { L("Guides disponibles", "Available guides"), isTitle = true } }
    for _, g in ipairs(UI:GuideTree()) do items[#items + 1] = g end
    local function Toggle(key) return function() DQF_DB[key] = not DQF_DB[key]; ns.Options.Refresh(); ns.Update(true) end end
    local function Is(key) return function() return DQF_DB[key] end end
    items[#items + 1] = { L("Affichage", "Display"), isTitle = true }
    items[#items + 1] = { L("Flèche de guidage", "Guide arrow"), function() ns.Arrow:Toggle(); ns.Options.Refresh() end,
        checked = Is("arrowShown"), check = true }
    items[#items + 1] = { L("Masquer les étapes terminées", "Hide completed steps"), Toggle("hideDone"), checked = Is("hideDone"), check = true }
    items[#items + 1] = { L("Verrouiller les fenêtres", "Lock frames"), Toggle("locked"), checked = Is("locked"), check = true }
    items[#items + 1] = { L("Progression", "Progress"), isTitle = true }
    items[#items + 1] = { L("Scanner mes quêtes", "Scan my quests"), function() ns.Progress.Scan(true) end }
    items[#items + 1] = { L("Étape suivante", "Next step"), ns.NextStep }
    items[#items + 1] = { L("Étape précédente", "Previous step"), ns.PrevStep }
    items[#items + 1] = { L("Réinitialiser la progression...", "Reset progress..."), function() StaticPopup_Show("DQF_RESET") end }
    items[#items + 1] = { " ", isTitle = true }
    items[#items + 1] = { L("Options...", "Options..."), function() ns.Options:Toggle(true) end }
    items[#items + 1] = { L("Cacher la fenêtre", "Hide window"), function() UI:Toggle(false) end }
    ns.ShowMenu(anchor, items)
end

----------------------------------------------------------------------
-- Refresh
----------------------------------------------------------------------
local ROW_LEFT, ROW_RIGHT, TEXT_LEFT, TEXT_RIGHT = 4, 12, 26, 6
local DONE_COLOR = { 0.35, 0.8, 0.35 }

-- Fills a row (or the hidden measuring row) and returns the height it needs
function UI:FillRow(r, s, cur, acc, isFirst, isLast)
    local textW = self.list:GetWidth() - ROW_LEFT - ROW_RIGHT - TEXT_LEFT - TEXT_RIGHT
    local main, sub = ns.StepLines(s)
    r.main:SetWidth(textW); r.sub:SetWidth(textW)
    r.tag:SetText(TagText(s, s.pos))
    r.main:SetText(main); r.sub:SetText(sub or "")
    if acc then
        local isCur = s.pos == cur
        r.current:SetColorTexture(acc[1], acc[2], acc[3], isCur and 0.09 or 0)
        -- dot: done = green check, current = accent, upcoming = grey
        if s.done then
            r.dot.tex:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready"); r.dot.tex:SetVertexColor(1, 1, 1)
        elseif isCur then
            r.dot.tex:SetTexture("Interface\\COMMON\\Indicator-Yellow"); r.dot.tex:SetVertexColor(acc[1], acc[2], acc[3])
        else
            r.dot.tex:SetTexture("Interface\\COMMON\\Indicator-Gray"); r.dot.tex:SetVertexColor(1, 1, 1)
        end
        local lc = s.done and DONE_COLOR or { 0.4, 0.4, 0.4 }
        r.lineTop:SetColorTexture(lc[1], lc[2], lc[3], 0.6)
        r.lineBot:SetColorTexture(lc[1], lc[2], lc[3], 0.6)
        r.lineTop:SetShown(not isFirst)
        r.lineBot:SetShown(not isLast)
        local a = s.done and 0.45 or 1
        r.main:SetAlpha(a); r.sub:SetAlpha(a); r.tag:SetAlpha(a)
        r.dot.step = s
    end
    local h = 5 + r.tag:GetStringHeight() + 2 + r.main:GetStringHeight()
        + (r.sub:GetText() ~= "" and (2 + r.sub:GetStringHeight()) or 0) + 7
    return math.max(ROW_MIN, math.ceil(h))
end

function UI:RenderCard(st)
    local c, d, cur = self.card, st.dungeon, st.cur
    local textW = c:GetWidth() - 10 - 30
    c.main:SetWidth(textW); c.sub:SetWidth(textW)
    if d.comingSoon then
        c.check:Hide()
        c.label:SetText("|cff888888" .. L("BIENTÔT DISPONIBLE", "COMING SOON") .. "|r")
        c.main:SetText(L("Guide en préparation", "Guide in preparation"))
        c.sub:SetText(L("Ce donjon n'est pas encore ouvert sur Forever.", "This dungeon is not open on Forever yet."))
    elseif d.faction and d.faction ~= UnitFactionGroup("player") then
        c.check:Hide()
        c.label:SetText("|cffff5555" .. L("DONJON RÉSERVÉ", "FACTION ONLY") .. "|r")
        c.main:SetText(L("Donjon réservé à la faction : ", "Dungeon for faction: ") .. d.faction)
        c.sub:SetText("")
    elseif st.step then
        local s = st.step
        local main, sub = ns.StepLines(s)
        c.label:SetText(("|cff%02x%02x%02x%s|r   %s"):format(
            ns.Theme().accent[1] * 255, ns.Theme().accent[2] * 255, ns.Theme().accent[3] * 255,
            L("OBJECTIF ACTUEL", "CURRENT OBJECTIVE"), TagText(s, cur)))
        c.main:SetText(main); c.sub:SetText(sub or "")
        local req = ns.Questie.RequiredLevel(s.quest)
        if req and UnitLevel("player") < req then
            c.sub:SetText(("|cffff4444" .. L("Niveau %d requis", "Level %d required") .. "|r - %s"):format(req, sub or ""))
        end
        c.check.step = s
        c.check:SetChecked(false); c.check:Show()
    elseif st.total == 0 then
        -- e.g. The Deadmines for the Horde: the dungeon has no quest for this faction
        c.check:Hide()
        c.label:SetText("|cff888888" .. L("AUCUNE QUÊTE", "NO QUEST") .. "|r")
        c.main:SetText(L("Pas de quête pour ta faction dans ce donjon.", "No quest for your faction in this dungeon."))
        c.sub:SetText("")
    else
        c.check:Hide()
        c.label:SetText("|cff55ff55" .. L("TERMINÉ", "DONE") .. "|r")
        c.main:SetText(L("Toutes les quêtes sont faites !", "All quests completed!"))
        c.sub:SetText("")
    end
    local subH = c.sub:GetText() ~= "" and (4 + c.sub:GetStringHeight()) or 0
    c:SetHeight(math.max(CARD_MIN, math.ceil(7 + c.label:GetStringHeight() + 5 + c.main:GetStringHeight() + subH + 9)))
end

function UI:OnUpdate(st, jump)
    if not self.frame or not self.frame:IsShown() then return end
    local d, cur = st.dungeon, st.cur

    -- header
    local h = self.head
    h.icon:SetTexture(d.icon)
    h.name:SetText(d.name)
    h.info:SetText(("%s %s   |cffffffff%d / %d|r"):format(L("Niveaux", "Levels"), d.levels, st.done, st.total))
    h.prog:SetMinMaxValues(0, math.max(1, st.total))
    h.prog:SetValue(st.done)
    self.foot.text:SetText("DQF v" .. ns.VERSION)
    self:RenderCard(st)
    if DQF_DB.collapsed then
        -- only the header and the current objective: fit the window to the card
        local h = math.ceil(HEADER_H + GAP + self.card:GetHeight() + GAP)
        if math.abs(self.frame:GetHeight() - h) > 0.5 and not InCombatLockdown() then self.frame:SetHeight(h) end
        return
    end

    local listW = self.list:GetWidth()
    if not listW or listW <= 0 then return end

    -- rows have variable heights: find how many fit from the end (max offset)
    local display = self:DisplayList(d)
    local avail = self.list:GetHeight() - 4
    self.measure = self.measure or CreateRow(self.list)
    self.measure:Hide()
    local used, fitEnd = 0, 0
    for i = #display, 1, -1 do
        used = used + self:FillRow(self.measure, display[i])
        if used > avail and fitEnd > 0 then break end
        fitEnd = fitEnd + 1
    end
    local maxOffset = math.max(0, #display - fitEnd)
    if jump and DQF_DB.autoFollow and st.step then
        for i, s in ipairs(display) do
            if s == st.step then self.offset = math.min(i - 1, maxOffset) break end
        end
    end
    self.offset = math.min(self.offset, maxOffset)
    self.maxOffset = maxOffset

    -- place the rows one under the other while they fit
    local acc = ns.Theme().accent
    local y, n = -2, 0
    for idx = self.offset + 1, #display do
        local r = self.rows[n + 1]
        if not r then r = CreateRow(self.list); self.rows[n + 1] = r end
        local rh = self:FillRow(r, display[idx], cur, acc, idx == 1, idx == #display)
        if n > 0 and -y + rh > avail + 2 then break end
        n = n + 1
        r.step = display[idx]
        r:ClearAllPoints()
        r:SetPoint("TOPLEFT", ROW_LEFT, y)
        r:SetPoint("RIGHT", -ROW_RIGHT, 0)
        r:SetHeight(rh)
        r:Show()
        y = y - rh
    end
    for i = n + 1, #self.rows do self.rows[i]:Hide(); self.rows[i].step = nil end
    self.visible = n

    self.updatingBar = true
    self.bar:SetMinMaxValues(0, maxOffset)
    self.bar:SetValue(self.offset)
    self.bar:SetShown(maxOffset > 0)
    self.updatingBar = false
end
