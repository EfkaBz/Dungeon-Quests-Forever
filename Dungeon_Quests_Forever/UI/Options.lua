local _, ns = ...
local L = ns.L
local O = {}
ns.Options = O
ns:RegisterModule(O)

local W, H = 580, 520
local COL_W = (W - 16 * 3) / 2   -- two columns
local LINE = 24

local function Apply()
    ns.UI:ApplySettings()
    ns.Minimap:ApplySettings()
    ns.Arrow.frame:SetShown(DQF_DB.arrowShown)
    ns.ApplyTheme()
    O:ApplyAccent()
    ns.Update()
end

local function Accent() return unpack(ns.Theme().accent) end

----------------------------------------------------------------------
-- Widgets
----------------------------------------------------------------------
local function Tooltip(frame, title, text)
    if not text then return end
    frame:HookScript("OnEnter", function(s)
        GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
        GameTooltip:AddLine(title, 1, 1, 1)
        GameTooltip:AddLine(text, 1, 0.82, 0, true)
        GameTooltip:Show()
    end)
    frame:HookScript("OnLeave", GameTooltip_Hide)
end

-- Section card with a title and an underline in the accent color
local function Section(parent, title, x, y, h)
    local card = ns.Panel(parent)
    card:SetPoint("TOPLEFT", x, y)
    card:SetSize(COL_W, h)
    card:SetBackdropColor(0, 0, 0, 0.35)
    card.title = card:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    card.title:SetPoint("TOPLEFT", 12, -10)
    card.title:SetText(title)
    card.line = card:CreateTexture(nil, "ARTWORK")
    card.line:SetPoint("TOPLEFT", card.title, "BOTTOMLEFT", 0, -4)
    card.line:SetPoint("RIGHT", -12, 0)
    card.line:SetHeight(1)
    card.nextY = -34
    O.cards[#O.cards + 1] = card
    return card
end

-- Themed square checkbox with a clickable label
local function Check(card, label, get, set, tip, x, w)
    local c = ns.Panel(card, "bg", "CheckButton", true)
    c:SetSize(16, 16)
    c:SetPoint("TOPLEFT", x or 14, card.nextY)
    c:SetBackdropColor(0, 0, 0, 0.6)
    c:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
    c:SetHighlightTexture("Interface\\Buttons\\WHITE8X8")
    c:GetHighlightTexture():SetVertexColor(1, 1, 1, 0.15)
    c.label = c:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    c.label:SetPoint("LEFT", c, "RIGHT", 8, 0)
    c.label:SetWidth((w or COL_W) - 50); c.label:SetJustifyH("LEFT"); c.label:SetWordWrap(false)
    c.label:SetText(label)
    c:SetHitRectInsets(0, -((w or COL_W) - 50), -3, -3) -- label is clickable too
    c.get, c.set = get, set
    c:SetScript("OnShow", function(s) s:SetChecked(s.get()) end)
    c:SetScript("OnClick", function(s)
        PlaySound(s:GetChecked() and 856 or 857)
        s.set(s:GetChecked() and true or false)
        Apply()
    end)
    c:SetChecked(get())
    Tooltip(c, label, tip)
    if not x then card.nextY = card.nextY - LINE end
    return c
end

local function DBCheck(card, label, key, tip, x, w)
    return Check(card, label, function() return DQF_DB[key] end, function(v) DQF_DB[key] = v end, tip, x, w)
end

-- Thin slider: label on the left, value on the right
local function Slider(card, label, key, min, max, step)
    local t = card:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    t:SetPoint("TOPLEFT", 14, card.nextY)
    t:SetText(label)
    local v = card:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    v:SetPoint("TOPRIGHT", -14, card.nextY)

    local s = CreateFrame("Slider", nil, card, "BackdropTemplate")
    s:SetOrientation("HORIZONTAL")
    s:SetHeight(14)
    s:SetPoint("TOPLEFT", 14, card.nextY - 18)
    s:SetPoint("RIGHT", -14, 0)
    s:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8", insets = { left = 0, right = 0, top = 5, bottom = 5 } })
    s:SetBackdropColor(1, 1, 1, 0.15)
    s:SetThumbTexture("Interface\\Buttons\\WHITE8X8")
    s:GetThumbTexture():SetSize(10, 14)
    s:SetMinMaxValues(min, max)
    s:SetValueStep(step)
    s:SetObeyStepOnDrag(true)
    s:EnableMouseWheel(true)
    s:SetScript("OnMouseWheel", function(self, d) self:SetValue(self:GetValue() + d * step) end)
    local function Show(val) v:SetText(("%d%%"):format(val * 100 + 0.5)) end
    s:SetScript("OnShow", function(self) self:SetValue(DQF_DB[key]); Show(DQF_DB[key]) end)
    s:SetScript("OnValueChanged", function(_, val)
        DQF_DB[key] = val
        Show(val)
        ns.UI:ApplySettings()
    end)
    s:SetValue(DQF_DB[key]); Show(DQF_DB[key])
    O.sliders[#O.sliders + 1] = s
    card.nextY = card.nextY - 44
    return s
end

-- "Label   < value >" selector cycling through a list
local function Selector(card, label, values, get, set, tip)
    local t = card:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    t:SetPoint("TOPLEFT", 14, card.nextY - 3)
    t:SetText(label)
    local box = ns.Panel(card, "bar", nil, true)
    box:SetSize(150, 20)
    box:SetPoint("TOPRIGHT", -14, card.nextY)
    box.text = box:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    box.text:SetPoint("CENTER")
    local function Refresh()
        local cur = get()
        for _, e in ipairs(values) do if e[1] == cur then box.text:SetText(e[2]()) end end
    end
    local function Step(dir)
        local cur, i = get(), 1
        for n, e in ipairs(values) do if e[1] == cur then i = n end end
        i = (i - 1 + dir) % #values + 1
        PlaySound(856)
        set(values[i][1])
        Refresh()
    end
    for _, dir in ipairs({ -1, 1 }) do
        local b = CreateFrame("Button", nil, box)
        b:SetSize(18, 18)
        b:SetPoint(dir < 0 and "LEFT" or "RIGHT", dir < 0 and 1 or -1, 0)
        local tex = dir < 0 and "Interface\\Buttons\\UI-SpellbookIcon-PrevPage" or "Interface\\Buttons\\UI-SpellbookIcon-NextPage"
        b:SetNormalTexture(tex .. "-Up"); b:SetPushedTexture(tex .. "-Down")
        b:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
        b:SetScript("OnClick", function() Step(dir) end)
    end
    box:EnableMouse(true)
    box:SetScript("OnMouseUp", function(_, btn) Step(btn == "RightButton" and -1 or 1) end)
    box:SetScript("OnShow", Refresh)
    Tooltip(box, label, tip)
    Refresh()
    card.nextY = card.nextY - 30
    return box
end

local function Button(parent, text, w)
    local b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    b:SetSize(w or 150, 24)
    b:SetText(text)
    return b
end

----------------------------------------------------------------------
-- Window
----------------------------------------------------------------------
function O:Build()
    self.cards, self.sliders = {}, {}
    local f = ns.Panel(UIParent)
    f:SetSize(W, H)
    f:SetPoint("CENTER")
    f:SetFrameStrata("DIALOG")
    f:SetMovable(true); f:EnableMouse(true); f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    tinsert(UISpecialFrames, "DQF_OptionsFrame")
    _G.DQF_OptionsFrame = f

    -- Title bar
    local top = ns.Panel(f, "bar")
    top:SetPoint("TOPLEFT", 4, -4); top:SetPoint("TOPRIGHT", -4, -4); top:SetHeight(40)
    top.icon = top:CreateTexture(nil, "ARTWORK")
    top.icon:SetSize(26, 26); top.icon:SetPoint("LEFT", 10, 0)
    top.icon:SetTexture("Interface\\AddOns\\Dungeon_Quests_Forever\\Media\\icon")
    local title = top:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("LEFT", top.icon, "RIGHT", 10, 6)
    title:SetText("Dungeon Quests |cff33ff99Forever|r")
    local sub = top:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    sub:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -2)
    sub:SetText(L("Options", "Options") .. "  -  v" .. ns.VERSION)
    local close = CreateFrame("Button", nil, top, "UIPanelCloseButton")
    close:SetPoint("RIGHT", -4, 0)
    -- the default script hides the parent (the title bar), not the window
    close:SetScript("OnClick", function() f:Hide() end)

    -- Left column
    local x1, x2, y0 = 16, 16 * 2 + COL_W, -58
    local disp = Section(f, L("Affichage", "Display"), x1, y0, 34 + LINE * 6 + 8)
    DBCheck(disp, L("Verrouiller les fenêtres", "Lock frames"), "locked",
        L("Empêche de déplacer et redimensionner les fenêtres.", "Prevents moving and resizing the frames."))
    DBCheck(disp, L("Flèche de guidage", "Guide arrow"), "arrowShown",
        L("Flèche qui pointe vers le prochain objectif.", "Arrow pointing to the next objective."))
    DBCheck(disp, L("Bouton de la minimap", "Minimap button"), "minimapShown")
    DBCheck(disp, L("Cadre des cibles", "Targets frame"), "targetsShown",
        L("Boutons pour cibler les PNJ et monstres de l'étape.", "Buttons to target the NPCs and mobs of the step."))
    DBCheck(disp, L("Masquer les étapes terminées", "Hide completed steps"), "hideDone")
    DBCheck(disp, L("Suivre l'étape en cours", "Follow current step"), "autoFollow",
        L("La liste défile toute seule jusqu'à l'étape en cours.", "The list scrolls to the current step automatically."))

    local map = Section(f, L("Carte", "Map"), x1, y0 - (34 + LINE * 6 + 8) - 10, 34 + LINE * 3 + 8)
    DBCheck(map, L("Points sur la carte du monde", "World map pins"), "mapPins",
        L("Affiche l'étape en cours sur la carte.", "Shows the current step on the map."))
    DBCheck(map, L("Points sur la minimap", "Minimap pins"), "minimapPins")

    -- Right column
    local look = Section(f, L("Apparence", "Appearance"), x2, y0, 34 + 44 * 2 + 30 * 2 + 4)
    Slider(look, L("Taille", "Scale"), "scale", 0.6, 1.6, 0.05)
    Slider(look, L("Opacité", "Opacity"), "alpha", 0.3, 1, 0.05)
    local themes = {}
    for _, k in ipairs(ns.THEME_ORDER) do
        themes[#themes + 1] = { k, function() return ns.ThemeName(ns.THEMES[k]) end }
    end
    Selector(look, L("Thème", "Theme"), themes,
        function() return DQF_DB.theme end, function(v) DQF_DB.theme = v; Apply() end)
    Selector(look, L("Langue", "Language"), {
            { "auto", function() return L("Auto (jeu)", "Auto (game)") end },
            { "fr", function() return "Français" end },
            { "en", function() return "English" end },
        },
        function() return DQF_DB.lang or "auto" end,
        function(v) DQF_DB.lang = v; StaticPopup_Show("DQF_RELOAD") end,
        L("Changer la langue recharge l'interface.", "Changing the language reloads the UI."))

    -- Automation: full width, 2 columns x 2 rows
    local auto = Section(f, L("Automatisation", "Automation"), x1, -378, 34 + LINE * 2 + 8)
    auto:SetWidth(W - 32)
    local cw = (W - 32 - 28) / 2
    local entries = {
        { L("Accepter/rendre les quêtes", "Quest auto accept/turn in"), "autoQuest",
          L("Accepte et rend automatiquement les quêtes des guides de donjon.", "Automatically accepts and turns in dungeon guide quests.") },
        { L("Choix de récompense auto", "Quest auto rewards"), "autoRewards",
          L("Choisit la récompense qui se revend le plus cher.", "Picks the reward with the highest vendor price.") },
        { L("Vol automatique", "Flight path automation"), "autoFlight",
          L("Prend le vol vers le point le plus proche du prochain objectif.", "Flies to the flight point closest to the next objective.") },
        { L("Passer les dialogues", "Skip gossip"), "skipGossip",
          L("Choisit l'option quand un PNJ n'en propose qu'une.", "Selects the option when an NPC offers only one.") },
    }
    for i, e in ipairs(entries) do
        local col, row = (i - 1) % 2, math.floor((i - 1) / 2)
        auto.nextY = -34 - row * LINE
        DBCheck(auto, e[1], e[2], e[3] .. "\n" .. L("(Maj enfoncée : désactivé)", "(hold Shift to disable)"), 14 + col * cw, cw)
    end

    StaticPopupDialogs.DQF_RELOAD = {
        text = L("Dungeon Quests Forever : recharger l'interface pour appliquer la langue ?",
                 "Dungeon Quests Forever: reload the UI to apply the language?"),
        button1 = ACCEPT, button2 = CANCEL,
        OnAccept = ReloadUI,
        timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
    }

    -- Bottom bar
    local bottom = ns.Panel(f, "bar")
    bottom:SetPoint("BOTTOMLEFT", 4, 4); bottom:SetPoint("BOTTOMRIGHT", -4, 4); bottom:SetHeight(38)
    local reset = Button(bottom, L("Réinitialiser la progression", "Reset progress"), 210)
    reset:SetPoint("LEFT", 10, 0)
    reset:SetScript("OnClick", function() StaticPopup_Show("DQF_RESET") end)
    local pos = Button(bottom, L("Replacer les fenêtres", "Reset positions"), 170)
    pos:SetPoint("RIGHT", -10, 0)
    pos:SetScript("OnClick", function() SlashCmdList.DQF("reset") end)

    f:SetScript("OnShow", function() O:ApplyAccent() end)
    f:Hide()
    self.frame = f
    self:ApplyAccent()
end

function O:ApplyAccent()
    if not self.frame then return end
    local r, g, b = Accent()
    for _, c in ipairs(self.cards) do c.line:SetColorTexture(r, g, b, 0.6) end
    for _, s in ipairs(self.sliders) do s:GetThumbTexture():SetVertexColor(r, g, b, 1) end
end

-- Re-sync the widgets when a setting changed elsewhere (menu, bindings)
function O.Refresh()
    local f = O.frame
    if f and f:IsShown() then f:Hide(); f:Show() end
end

function O:Toggle(show)
    if not self.frame then self:Build() end
    if show == nil then show = not self.frame:IsShown() end
    self.frame:SetShown(show)
end

function O:Init()
    StaticPopupDialogs.DQF_RESET = {
        text = L("Réinitialiser la progression manuelle de ce donjon ?", "Reset the manual progress of this dungeon?"),
        button1 = YES, button2 = NO,
        OnAccept = function()
            DQF_DB.manual[ns.CurrentDungeon().key] = {}
            ns.Update(true)
        end,
        timeout = 0, whileDead = true, hideOnEscape = true, preferredIndex = 3,
    }
    -- Entry in the game's AddOns options, opening our window
    local panel = CreateFrame("Frame")
    panel.name = "Dungeon Quests Forever"
    local b = Button(panel, L("Ouvrir les options", "Open options"), 180)
    b:SetPoint("TOPLEFT", 16, -16)
    b:SetScript("OnClick", function()
        if SettingsPanel and SettingsPanel:IsShown() then HideUIPanel(SettingsPanel) end
        if InterfaceOptionsFrame and InterfaceOptionsFrame:IsShown() then HideUIPanel(InterfaceOptionsFrame) end
        O:Toggle(true)
    end)
    if Settings and Settings.RegisterCanvasLayoutCategory then
        local cat = Settings.RegisterCanvasLayoutCategory(panel, panel.name)
        Settings.RegisterAddOnCategory(cat)
    elseif InterfaceOptions_AddCategory then
        InterfaceOptions_AddCategory(panel)
    end
end
