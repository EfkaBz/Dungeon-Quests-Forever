local _, ns = ...
local L = ns.L
local W = ns.Widgets
local J = {}
ns.Journal = J
ns:RegisterModule(J)

-- Big "dungeon journal" window, next to the small step tracker:
--   home    : dungeon cards
--   dungeon : Quests / Bosses / Map tabs
--   results : search and loot filter results
-- Pages live in the other files of UI\Journal and register with J:AddPage.

local TOP_H, HEAD_H, TABS_H = 40, 66, 26
local MIN_W, MIN_H, MAX_W, MAX_H = 720, 480, 1400, 1000
J.pages = {}
J.TITLE = "Dungeon Quests" -- window title: the addon name (same in every language)

function J:AddPage(name, page) self.pages[name] = page end

local function State() return DQF_DB.journal end

----------------------------------------------------------------------
-- Window
----------------------------------------------------------------------
function J:Build()
    local S = ns.Skin
    -- Blizzard theme: the game's portrait window on spellbook pages
    local f = ns.BLIZZ and S.Window("DQF_Journal", self.TITLE) or ns.Panel(UIParent)
    _G.DQF_Journal = f
    if ns.BLIZZ then S.Parchment(f, 62) end
    tinsert(UISpecialFrames, "DQF_Journal")
    local st = State()
    f:SetSize(st.size and st.size[1] or 860, st.size and st.size[2] or 580)
    f:SetFrameStrata("MEDIUM")
    f:SetToplevel(true)
    f:SetClampedToScreen(true); f:EnableMouse(true); f:SetMovable(true); f:SetResizable(true)
    if f.SetResizeBounds then f:SetResizeBounds(MIN_W, MIN_H, MAX_W, MAX_H)
    else f:SetMinResize(MIN_W, MIN_H); f:SetMaxResize(MAX_W, MAX_H) end
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(s) if not DQF_DB.locked then s:StartMoving() end end)
    f:SetScript("OnDragStop", function(s) s:StopMovingOrSizing(); J:SavePosition() end)
    -- right-click on an empty area: back
    f:SetScript("OnMouseUp", function(_, btn) if btn == "RightButton" then J:Back() end end)
    f:SetScript("OnShow", function() PlaySound(SOUNDKIT and SOUNDKIT.IG_SPELLBOOK_OPEN or 829); J:OnShow() end)
    f:SetScript("OnHide", function() PlaySound(SOUNDKIT and SOUNDKIT.IG_SPELLBOOK_CLOSE or 830) end)
    self.frame = f
    ns.Anim.Window(f, true)
    f:Hide()

    -- Title bar: icon, title, navigation, search, close
    -- (Blizzard theme: the window's own title and close button, the controls
    -- sit on a row under the title, right of the portrait)
    local top
    if ns.BLIZZ then
        top = CreateFrame("Frame", nil, f)
        top:SetPoint("TOPLEFT", 62, -26); top:SetPoint("TOPRIGHT", -10, -26); top:SetHeight(32)
        top.title = { SetText = function(_, text) S.SetTitle(f, text .. "  |cff9d9d9dv" .. ns.VERSION .. "|r") end }
    else
        top = ns.Panel(f, "bar")
        top:SetPoint("TOPLEFT", 4, -4); top:SetPoint("TOPRIGHT", -4, -4); top:SetHeight(TOP_H)
        top.icon = top:CreateTexture(nil, "ARTWORK")
        top.icon:SetSize(26, 26); top.icon:SetPoint("LEFT", 10, 0)
        top.icon:SetTexture("Interface\\AddOns\\Dungeon_Quests_Forever\\Media\\icon")
        top.title = top:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        top.title:SetPoint("LEFT", top.icon, "RIGHT", 10, 0)
        top.close = CreateFrame("Button", nil, top, "UIPanelCloseButton")
        top.close:SetPoint("RIGHT", -4, 0)
        top.close:SetScript("OnClick", function() ns.Anim.Hide(f) end)
    end
    top:EnableMouse(true); top:RegisterForDrag("LeftButton")
    top:SetScript("OnDragStart", function() f:GetScript("OnDragStart")(f) end)
    top:SetScript("OnDragStop", function() f:GetScript("OnDragStop")(f) end)
    top:SetScript("OnMouseUp", function(_, btn) if btn == "RightButton" then J:Back() end end)
    local navSize = ns.BLIZZ and 28 or 20
    top.home = W.IconButton(top, "Interface\\Icons\\INV_Misc_Book_09", navSize, function() J:ShowHome() end,
        function() return L("Accueil : tous les donjons", "Home: all dungeons") end)
    top.home:GetNormalTexture():SetTexCoord(0.08, 0.92, 0.08, 0.92)
    top.back = W.IconButton(top, "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up", navSize + 2, function() J:Back() end,
        function() return L("Retour (ou clic droit dans le vide)", "Back (or right-click an empty area)") end)
    if ns.BLIZZ then
        top.home:SetPoint("LEFT", 8, 0)
        -- icon border like the spellbook tabs
        local border = top.home:CreateTexture(nil, "OVERLAY")
        border:SetPoint("TOPLEFT", -3, 3); border:SetPoint("BOTTOMRIGHT", 3, -3)
        border:SetTexture("Interface\\Buttons\\UI-Quickslot2")
        border:SetTexCoord(0.2, 0.8, 0.2, 0.8)
    else
        top.home:SetPoint("LEFT", top.title, "RIGHT", 14, 0)
    end
    top.back:SetPoint("LEFT", top.home, "RIGHT", 6, 0)

    -- search box
    local box
    if ns.BLIZZ then
        box = S.EditBox(top, 220, 20, true)
        box:SetPoint("RIGHT", -4, 0)
        box.hint = box.Instructions or box:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        if not box.Instructions then box.hint:SetPoint("LEFT", 6, 0) end
    else
        box = ns.Panel(top, "bg", "EditBox", true)
        box:SetSize(220, 22)
        box:SetPoint("RIGHT", top.close, "LEFT", -8, 0)
        box:SetFontObject("GameFontHighlightSmall")
        box:SetTextInsets(22, 8, 0, 0)
        box:SetAutoFocus(false)
        box.icon = box:CreateTexture(nil, "OVERLAY")
        box.icon:SetSize(14, 14); box.icon:SetPoint("LEFT", 5, 0)
        box.icon:SetTexture("Interface\\Common\\UI-Searchbox-Icon")
        box.hint = box:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        box.hint:SetPoint("LEFT", 22, 0)
    end
    box:SetMaxLetters(60)
    -- the game's search box has its own scripts (clear button, hint): hook them
    local Script = ns.BLIZZ and box.HookScript or box.SetScript
    box:SetScript("OnEscapePressed", function(s) s:SetText(""); s:ClearFocus() end)
    box:SetScript("OnEnterPressed", function(s) s:ClearFocus(); J:Search(s:GetText()) end)
    Script(box, "OnTextChanged", function(s, user)
        if not ns.BLIZZ then s.hint:SetShown(s:GetText() == "") end
        if not user then return end
        s.pending = (s.pending or 0) + 1
        local n = s.pending
        C_Timer.After(0.35, function()
            if n == s.pending and s:GetText() ~= "" then J:Search(s:GetText()) end
        end)
    end)
    if not ns.BLIZZ then
        box:SetScript("OnEditFocusGained", function(s) s.hint:Hide() end)
        box:SetScript("OnEditFocusLost", function(s) s.hint:SetShown(s:GetText() == "") end)
    end
    box.hint:SetWordWrap(false)
    box:HookScript("OnEnter", function(s)
        GameTooltip:SetOwner(s, "ANCHOR_BOTTOM")
        GameTooltip:AddLine(L("Rechercher (donjon, boss, objet, quête)", "Search (dungeon, boss, item, quest)"), 1, 1, 1)
        GameTooltip:Show()
    end)
    box:HookScript("OnLeave", GameTooltip_Hide)
    top.search = box

    -- language (the change needs a UI reload)
    top.lang = W.Button(top, "", 44, 22, function(b)
        local items = { { L("Langue", "Language"), isTitle = true } }
        local function Add(code, name)
            items[#items + 1] = { name, function()
                if (DQF_DB.lang or "auto") == code then return end
                DQF_DB.lang = code
                StaticPopup_Show("DQF_RELOAD")
            end, checked = function() return (DQF_DB.lang or "auto") == code end }
        end
        Add("auto", L("Auto (jeu)", "Auto (game)"))
        for _, l in ipairs(ns.LANGS) do Add(l[1], l[3]) end
        ns.ShowMenu(b, items)
    end, function() return L("Langue de l'addon (recharge l'interface)", "Addon language (reloads the UI)") end)
    top.lang:SetPoint("RIGHT", box, "LEFT", ns.BLIZZ and -12 or -6, 0)
    self.top = top

    -- Dungeon header: art, name, levels, actions, tabs
    local head = CreateFrame("Frame", nil, f)
    if ns.BLIZZ then
        head:SetPoint("TOPLEFT", f, "TOPLEFT", 14, -68); head:SetPoint("TOPRIGHT", f, "TOPRIGHT", -14, -68)
    else
        head:SetPoint("TOPLEFT", top, "BOTTOMLEFT", 0, -4); head:SetPoint("TOPRIGHT", top, "BOTTOMRIGHT", 0, -4)
    end
    head:SetHeight(HEAD_H + TABS_H)
    head.art = head:CreateTexture(nil, "BACKGROUND")
    head.art:SetPoint("TOPLEFT"); head.art:SetPoint("TOPRIGHT"); head.art:SetHeight(HEAD_H)
    head.art:SetAlpha(0.35)
    head.shade = head:CreateTexture(nil, "BORDER")
    head.shade:SetAllPoints(head.art)
    head.shade:SetColorTexture(0, 0, 0, 0.35)
    head.iconFrame = ns.Panel(head, "bg", nil, true)
    head.iconFrame:SetSize(44, 44); head.iconFrame:SetPoint("TOPLEFT", 12, -11)
    head.icon = head.iconFrame:CreateTexture(nil, "ARTWORK")
    head.icon:SetPoint("TOPLEFT", 1, -1); head.icon:SetPoint("BOTTOMRIGHT", -1, 1)
    head.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    head.name = W.Font(head, "GameFontNormalHuge")
    head.name:SetPoint("TOPLEFT", head.iconFrame, "TOPRIGHT", 12, -2)
    head.info = W.Font(head, "GameFontHighlightSmall")
    head.info:SetPoint("TOPLEFT", head.name, "BOTTOMLEFT", 0, -6)

    head.track = W.Button(head, "", 150, 22, function() J:TrackCurrent() end,
        function() return L("Afficher ce guide dans la petite fenêtre de suivi des étapes.",
            "Show this guide in the small step tracker window.") end)
    head.track:SetPoint("TOPRIGHT", -10, -10)
    head.entrance = W.Button(head, "", 150, 22, function() ns.EntrancePins:ShowEntrance(J.dungeon) end,
        function() return L("Place un marqueur sur l'entrée du donjon et ouvre la carte.",
            "Marks the dungeon entrance and opens the map.") end)
    head.entrance:SetPoint("TOPRIGHT", head.track, "BOTTOMRIGHT", 0, -4)
    head.route = W.Button(head, "", 150, 22, function() ns.Route:Toggle(J.dungeon); J:RefreshHeader() end,
        function() return L("Itinéraire jusqu'à l'entrée : tracé sur la carte et suivi par la flèche.",
            "Route to the entrance: drawn on the map and followed by the arrow.") end)
    head.route:SetPoint("RIGHT", head.track, "LEFT", -6, 0)

    head.tabs = {}
    local prev
    for _, name in ipairs({ "quests", "bosses", "map" }) do
        local t = W.Tab(head, "", function() J:ShowTab(name) end)
        if prev then t:SetPoint("LEFT", prev, "RIGHT", 2, 0) else t:SetPoint("BOTTOMLEFT", 8, 0) end
        head.tabs[name] = t
        prev = t
    end
    head.tabLine = head:CreateTexture(nil, "ARTWORK")
    head.tabLine:SetPoint("BOTTOMLEFT", 4, 0); head.tabLine:SetPoint("BOTTOMRIGHT", -4, 0); head.tabLine:SetHeight(1)
    head.tabLine:SetColorTexture(1, 1, 1, 0.1)
    self.head = head

    -- Body: where pages are drawn
    local body = CreateFrame("Frame", nil, f)
    body:SetPoint("BOTTOMRIGHT", -6, 18)
    self.body = body

    -- resize grip
    local grip = CreateFrame("Button", nil, f)
    grip:SetSize(14, 14); grip:SetPoint("BOTTOMRIGHT", -3, 3)
    grip:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    grip:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
    grip:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
    grip:SetScript("OnMouseDown", function() if not DQF_DB.locked then f:StartSizing("BOTTOMRIGHT") end end)
    grip:SetScript("OnMouseUp", function()
        f:StopMovingOrSizing()
        State().size = { f:GetWidth(), f:GetHeight() }
        J:SavePosition()
    end)
    f.version = f:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    f.version:SetPoint("BOTTOMLEFT", ns.BLIZZ and 16 or 10, ns.BLIZZ and 10 or 5)
    f.version:SetText("Dungeon Quests Forever v" .. ns.VERSION)
    if ns.BLIZZ then ns.Skin.Ink(f.version, true) end
    W.OnResize(f, function() J:Layout() end)

    for _, page in pairs(self.pages) do
        page.frame = CreateFrame("Frame", nil, body)
        page.frame:SetAllPoints()
        page.frame:Hide()
        page:Build(page.frame)
    end
    self:BuildSideTabs()
    self:RestorePosition()
    self:ApplyTexts()
end

function J:ApplyTexts()
    if not self.frame then return end
    local h = self.head
    h.tabs.quests:SetLabel(L("Quêtes", "Quests"))
    h.tabs.bosses:SetLabel(L("Boss & butin", "Bosses & loot"))
    h.tabs.map:SetLabel(L("Carte", "Map"))
    h.track:SetLabel(L("Suivre dans le tracker", "Follow in the tracker"))
    h.entrance:SetLabel(L("Montrer l'entrée", "Show entrance"))
    -- short hint on one line (full description in the tooltip of the box)
    self.top.search.hint:SetText(L("Recherche", "Search") .. "...")
    self.top.lang:SetLabel(ns.Lang():upper())
end

function J:SavePosition()
    local f = self.frame
    local l, t = f:GetLeft(), f:GetTop()
    if l and t then
        State().pos = { l, t }
        f:ClearAllPoints()
        f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", l, t)
    end
end

function J:RestorePosition()
    local f, p = self.frame, State().pos
    f:ClearAllPoints()
    if p then f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", p[1], p[2]) else f:SetPoint("CENTER") end
end

-- Body below the title bar (home/results) or below the dungeon header
function J:Layout()
    if not self.frame then return end
    local dungeonView = self.view == "dungeon"
    self.head:SetShown(dungeonView)
    self.body:ClearAllPoints()
    if ns.BLIZZ then
        -- inside the parchment, a little away from its edges
        if dungeonView then self.body:SetPoint("TOPLEFT", self.head, "BOTTOMLEFT", 4, -8)
        else self.body:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 18, -72) end
        self.body:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -18, 28)
    else
        self.body:SetPoint("TOPLEFT", dungeonView and self.head or self.top, "BOTTOMLEFT", 2, -6)
        self.body:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", -6, 20)
    end
    local page = self.current and self.pages[self.current]
    if page and page.Layout then page:Layout() end
end

----------------------------------------------------------------------
-- Navigation
----------------------------------------------------------------------
local function Push(entry)
    J.history = J.history or {}
    local last = J.history[#J.history]
    if last and last.view == entry.view and last.dungeon == entry.dungeon and last.tab == entry.tab and last.arg == entry.arg then return end
    table.insert(J.history, entry)
    if #J.history > 30 then table.remove(J.history, 1) end
end

----------------------------------------------------------------------
-- Side tabs on the right edge of the window (like the game's quest log):
-- all dungeons, attunements, Over World
----------------------------------------------------------------------
local SIDE_ATLAS, TAB_WIDEN, TAB_SPACING = "questlog-tab-side", 8, 58
local SIDE_TABS = {
    { cat = "dungeons",   icon = "Interface\\Icons\\INV_Sword_27" },
    { cat = "attunement", icon = "Interface\\Icons\\INV_Misc_Key_03" },
    { cat = "overworld",  icon = "Interface\\Icons\\INV_Misc_Map_01" },
}
local function CategoryLabel(cat)
    if cat == "attunement" then return L("Quêtes d'accès", "Attunements") end
    if cat == "overworld" then return L("Monde (Over World)", "Over World") end
    return L("Tous les donjons", "All dungeons")
end
J.CategoryLabel = CategoryLabel

local function HasAtlas(name)
    return C_Texture and C_Texture.GetAtlasInfo and C_Texture.GetAtlasInfo(name) ~= nil
end
local function SideAtlas(tex, name)
    tex:SetAtlas(name, true)
    tex:SetWidth(tex:GetWidth() + TAB_WIDEN)
    tex:SetPoint("CENTER")
end

local function SideTab(parent, icon)
    local t = CreateFrame("Button", nil, parent)
    t.icon = t:CreateTexture(nil, "ARTWORK")
    t.icon:SetTexture(icon)
    if HasAtlas(SIDE_ATLAS) then
        -- the game's own art
        t:SetSize(43 + TAB_WIDEN, 55)
        local bg = t:CreateTexture(nil, "BACKGROUND")
        SideAtlas(bg, SIDE_ATLAS)
        t.icon:SetSize(36, 42)
        t.icon:SetPoint("CENTER", -2, 1)
        t.icon:SetTexCoord(0.14, 0.86, 0.08, 0.92)
        t.selected = t:CreateTexture(nil, "OVERLAY")
        SideAtlas(t.selected, "QuestLog-Tab-side-Glow-select")
        local hl = t:CreateTexture(nil, "HIGHLIGHT")
        SideAtlas(hl, "QuestLog-Tab-side-Glow-hover")
        hl:SetBlendMode("ADD")
    else
        -- look-alike: icon in a dark square, gold frame, glow when selected
        t:SetSize(42, 42)
        local bg = t:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetColorTexture(0.06, 0.04, 0.02, 1)
        t.icon:SetPoint("TOPLEFT", 4, -4)
        t.icon:SetPoint("BOTTOMRIGHT", -4, 4)
        t.icon:SetTexCoord(0.12, 0.88, 0.12, 0.88)
        t.border = CreateFrame("Frame", nil, t, "BackdropTemplate")
        t.border:SetPoint("TOPLEFT", -3, 3)
        t.border:SetPoint("BOTTOMRIGHT", 3, -3)
        t.border:SetBackdrop({ edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border", edgeSize = 16 })
        t.selected = t.border:CreateTexture(nil, "OVERLAY")
        t.selected:SetTexture("Interface\\Buttons\\CheckButtonHilight")
        t.selected:SetBlendMode("ADD")
        t.selected:SetAllPoints(t.icon)
        local hl = t:CreateTexture(nil, "HIGHLIGHT")
        hl:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
        hl:SetBlendMode("ADD")
        hl:SetAllPoints(t.icon)
    end
    return t
end

function J:BuildSideTabs()
    self.sideTabs = {}
    for i, info in ipairs(SIDE_TABS) do
        local t = SideTab(self.frame, info.icon)
        t.cat = info.cat
        t:SetPoint("TOPLEFT", self.frame, "TOPRIGHT", -2, -60 - (i - 1) * TAB_SPACING)
        t:SetScript("OnClick", function()
            PlaySound(841)
            J.pages.home:SetCategory(info.cat)
            J:ShowHome()
        end)
        t:SetScript("OnEnter", function(b)
            GameTooltip:SetOwner(b, "ANCHOR_RIGHT")
            GameTooltip:AddLine(CategoryLabel(info.cat), 1, 0.82, 0)
            GameTooltip:Show()
        end)
        t:SetScript("OnLeave", GameTooltip_Hide)
        self.sideTabs[i] = t
    end
end

-- the selected tab: the category shown, or the one of the open dungeon
function J:RefreshSideTabs()
    if not self.sideTabs then return end
    local cat = DQF_DB.journal.homeCategory or "dungeons"
    local d = self.view == "dungeon" and self.dungeon
    if d then cat = d.attunement and "attunement" or (d.overworld and "overworld" or "dungeons") end
    for _, t in ipairs(self.sideTabs) do
        local sel = t.cat == cat
        t.selected:SetShown(sel)
        if t.border then
            if sel then t.border:SetBackdropBorderColor(1, 0.85, 0.2) else t.border:SetBackdropBorderColor(0.6, 0.48, 0.3) end
        end
    end
end

function J:ShowPage(name, d, arg)
    for n, page in pairs(self.pages) do
        if n ~= name and page.frame:IsShown() then
            page.frame:Hide()
            if page.OnHide then page:OnHide() end
        end
    end
    self.current = name
    local page = self.pages[name]
    page.frame:Show()
    if not self.opening then ns.Anim.FadeIn(page.frame) end
    self:Layout()
    page:Show(d, arg)
    self:RefreshSideTabs()
end

function J:ShowHome(noHistory)
    if not self.frame then return end
    self.view, self.dungeon = "home", nil
    State().view = "home"
    if not noHistory then Push({ view = "home" }) end
    self.top.title:SetText(J.TITLE)
    self:ShowPage("home")
end

-- Opens a dungeon on a tab ("quests", "bosses", "map"); arg = quest / boss to select
function J:ShowDungeon(key, tab, arg, noHistory)
    local d = ns.dungeons[key]
    if not d then return end
    if not self.frame then self:Build() end
    if not self.frame:IsShown() then self.opening = true; self.frame:Show(); self.opening = false end
    self.view, self.dungeon = "dungeon", d
    tab = tab or State().tab or "quests"
    if tab == "map" and not (ns.JournalMap and ns.JournalMap.HasMap(d)) then tab = "quests" end
    if tab == "bosses" and not d.bossInfo then tab = "quests" end
    self.tab = tab
    local st = State()
    st.view, st.dungeon, st.tab = "dungeon", key, tab
    if not noHistory then Push({ view = "dungeon", dungeon = key, tab = tab, arg = arg }) end
    self.top.title:SetText(J.TITLE)
    self:RefreshHeader()
    self:ShowPage(tab, d, arg)
end

function J:ShowTab(tab, arg) if self.dungeon then self:ShowDungeon(self.dungeon.key, tab, arg) end end

function J:ShowResults(kind, query, noHistory)
    if not self.frame then self:Build() end
    if not self.frame:IsShown() then self.opening = true; self.frame:Show(); self.opening = false end
    self.view = "results"
    if not noHistory then Push({ view = "results", tab = kind, arg = query }) end
    self.top.title:SetText(kind == "loot" and L("Filtre de butin", "Loot filter") or L("Recherche", "Search"))
    self:ShowPage("results", nil, { kind = kind, query = query })
end

function J:Search(text)
    text = strtrim(text or "")
    if text == "" then return end
    self:ShowResults("search", text)
end

function J:Back()
    local h = self.history
    if not h or #h < 2 then return self:ShowHome(true) end
    table.remove(h)
    local e = h[#h]
    if e.view == "dungeon" then self:ShowDungeon(e.dungeon, e.tab, e.arg, true)
    elseif e.view == "results" then self:ShowResults(e.tab, e.arg, true)
    else self:ShowHome(true) end
end

function J:RefreshHeader()
    local d, h = self.dungeon, self.head
    if not d then return end
    h.icon:SetTexture(d.icon)
    h.name:SetText(d.name)
    local quests = ns.QuestInfo.VisibleQuests(d, UnitFactionGroup("player"))
    local done = 0
    for _, e in ipairs(quests) do if ns.QuestInfo.State(e.quest) == 3 then done = done + 1 end end
    local parts = { ("|cffffd100%s|r %s"):format(L("Niveaux", "Levels"), d.levels) }
    if #quests > 0 then parts[#parts + 1] = ("%s |cffffffff%d/%d|r"):format(L("Quêtes :", "Quests:"), done, #quests) end
    if d.bossInfo then parts[#parts + 1] = ("%s |cffffffff%d|r"):format(L("Boss :", "Bosses:"), #d.bossInfo.bosses) end
    if d.faction then parts[#parts + 1] = "|cffff8080" .. (d.faction == "Horde" and FACTION_HORDE or FACTION_ALLIANCE) .. "|r" end
    if d.comingSoon then parts[#parts + 1] = "|cff888888" .. L("Bientôt sur Forever", "Coming soon on Forever") .. "|r" end
    if d.attunement then parts[#parts + 1] = ns.Attune.StatusText(ns.Attune.Status(d)) end
    h.info:SetText(table.concat(parts, "    "))
    if d.art then
        h.art:SetTexture(d.art)
        local c = d.artCoord or { 0, 1, 0, 1 }
        -- show a thin horizontal band of the picture
        local mid = (c[3] + c[4]) / 2
        h.art:SetTexCoord(c[1], c[2], mid - 0.09, mid + 0.09)
        h.art:Show()
    else
        h.art:Hide()
    end
    h.track:SetShown(not d.comingSoon and #d.steps > 0)
    h.entrance:SetShown(d.entrance ~= nil)
    h.route:SetShown(d.entrance ~= nil and ns.Route:CanRoute(d))
    h.route:SetLabel(ns.Route:IsActive(d) and L("Arrêter l'itinéraire", "Stop route") or L("Itinéraire", "Route"))
    h.route:FitText(24)
    h.tabs.bosses:SetShown(d.bossInfo ~= nil)
    h.tabs.map:SetShown(ns.JournalMap and ns.JournalMap.HasMap(d) or false)
    h.tabs.map:ClearAllPoints()
    h.tabs.map:SetPoint("LEFT", d.bossInfo and h.tabs.bosses or h.tabs.quests, "RIGHT", 2, 0)
    for name, t in pairs(h.tabs) do t:SetSelected(name == self.tab) end
end

function J:TrackCurrent()
    local d = self.dungeon
    if not d then return end
    ns.UI:SelectDungeon(d.key)
    if not ns.UI.frame:IsShown() then ns.UI:Toggle(true) end
    UIErrorsFrame:AddMessage(L("Guide suivi : ", "Following guide: ") .. d.name, 0.4, 1, 0.4)
end

----------------------------------------------------------------------
function J:OnShow()
    self:ApplyTexts()
    if self.opening then return end -- opened by ShowDungeon/ShowResults
    local here = ns.InstanceDungeon()
    local st = State()
    if here then
        self:ShowDungeon(here, nil, nil)
    elseif st.view == "dungeon" and st.dungeon and ns.dungeons[st.dungeon] then
        self:ShowDungeon(st.dungeon, st.tab)
    else
        self:ShowHome()
    end
end

function J:Toggle(show)
    if not self.frame then self:Build() end
    if show == nil then show = not self.frame:IsShown() end
    ns.Anim.SetShown(self.frame, show)
end

-- Open on a dungeon (from the tracker, map pins...)
function J:Open(key, tab, arg)
    if not self.frame then self:Build() end
    self:ShowDungeon(key, tab, arg)
end

-- Quest progress changed: refresh what is on screen (throttled)
function J:OnUpdate()
    if not (self.frame and self.frame:IsShown()) or self.pendingRefresh then return end
    self.pendingRefresh = true
    C_Timer.After(0.4, function()
        self.pendingRefresh = false
        if not self.frame:IsShown() then return end
        if self.view == "dungeon" then self:RefreshHeader() end
        local page = self.current and self.pages[self.current]
        if page and page.Refresh then page:Refresh() end
    end)
end

function J:Init()
    ns:On("GET_ITEM_INFO_RECEIVED", function() if J.current == "results" then J:OnUpdate() end end)
    ns:On("PLAYER_LEVEL_UP", function() J:OnUpdate() end)
end
