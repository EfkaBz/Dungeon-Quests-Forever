local _, ns = ...
local L = ns.L
local W = ns.Widgets
local J = ns.Journal
local Home = {}

-- Home page: one card per dungeon (picture, name, levels, quests for the
-- player's faction), sorted by level. "Hide dungeons" mode: click a card to
-- hide/show it.

local CARD_MIN_W, CARD_H, GAP = 200, 128, 10

local function FirstLevel(d) return tonumber(d.levels and d.levels:match("^(%d+)")) or 0 end

-- Soft drop shadow behind a card: a frame under it (lower level), made of
-- stacked rectangles that fade toward the outside; it follows the card
local SHADOW = 7
local function Shadow(parent, card)
    local sh = CreateFrame("Frame", nil, parent)
    sh:SetPoint("TOPLEFT", card, "TOPLEFT", -SHADOW + 1, SHADOW - 3)
    sh:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", SHADOW + 1, -SHADOW - 1) -- a bit lower: light from above
    for i = 0, SHADOW - 1 do
        local t = sh:CreateTexture(nil, "BACKGROUND")
        t:SetPoint("TOPLEFT", i, -i); t:SetPoint("BOTTOMRIGHT", -i, i)
        t:SetColorTexture(0, 0, 0, 0.07 + i * 0.02)
    end
    card:SetFrameLevel(sh:GetFrameLevel() + 1)
    card:HookScript("OnShow", function() sh:Show() end)
    card:HookScript("OnHide", function() sh:Hide() end)
    return sh
end

local function CreateCard(parent)
    local c = ns.Panel(parent, "bg", "Button", true)
    c.shadow = Shadow(parent, c)
    c:SetHeight(CARD_H)
    c:SetBackdropColor(0, 0, 0, 0.45)
    -- softer frame: dark edge (set in Refresh) with a thin warm light line inside
    for _, e in ipairs({ { "TOPLEFT", "TOPRIGHT", 1, -1, -1, -1, true }, { "BOTTOMLEFT", "BOTTOMRIGHT", 1, 1, -1, 1, true },
                         { "TOPLEFT", "BOTTOMLEFT", 1, -1, 1, 1 }, { "TOPRIGHT", "BOTTOMRIGHT", -1, -1, -1, 1 } }) do
        local l = c:CreateTexture(nil, "OVERLAY", nil, 1)
        l:SetPoint(e[1], e[3], e[4]); l:SetPoint(e[2], e[5], e[6])
        if e[7] then l:SetHeight(1) else l:SetWidth(1) end
        l:SetColorTexture(1, 0.85, 0.55, 0.16)
    end
    c.iconBack = c:CreateTexture(nil, "BACKGROUND", nil, 1)
    c.iconBack:SetPoint("TOPLEFT", 1, -1); c.iconBack:SetPoint("TOPRIGHT", -1, -1); c.iconBack:SetHeight(76)
    c.iconBack:SetTexCoord(0.2, 0.8, 0.35, 0.65)
    c.iconBack:SetAlpha(0.5)
    c.art = c:CreateTexture(nil, "BACKGROUND", nil, 2)
    c.art:SetAllPoints(c.iconBack)
    c.fade = c:CreateTexture(nil, "BORDER")
    c.fade:SetPoint("BOTTOMLEFT", c.art, "BOTTOMLEFT"); c.fade:SetPoint("BOTTOMRIGHT", c.art, "BOTTOMRIGHT"); c.fade:SetHeight(30)
    c.fade:SetTexture("Interface\\Buttons\\WHITE8X8")
    if CreateColor and c.fade.SetGradient then
        pcall(c.fade.SetGradient, c.fade, "VERTICAL", CreateColor(0, 0, 0, 0.85), CreateColor(0, 0, 0, 0))
    else
        c.fade:SetColorTexture(0, 0, 0, 0.4)
    end
    c.iconFrame = ns.Panel(c, "bg", nil, true)
    c.iconFrame:SetSize(30, 30); c.iconFrame:SetPoint("BOTTOMLEFT", c.art, "BOTTOMLEFT", 6, -12)
    c.iconFrame:SetFrameLevel(c:GetFrameLevel() + 2)
    c.icon = c.iconFrame:CreateTexture(nil, "ARTWORK")
    c.icon:SetPoint("TOPLEFT", 1, -1); c.icon:SetPoint("BOTTOMRIGHT", -1, 1)
    c.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    c.levels = c:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    c.levels:SetPoint("TOPRIGHT", -6, -5)
    c.tag = c:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    c.tag:SetPoint("TOPLEFT", 6, -5)
    c.name = W.Font(c, "GameFontNormal")
    c.name:SetPoint("TOPLEFT", c.art, "BOTTOMLEFT", 42, -4)
    c.name:SetPoint("RIGHT", -6, 0)
    c.quests = W.Font(c, "GameFontHighlightSmall")
    c.quests:SetPoint("BOTTOMLEFT", 8, 8)
    c.quests:SetPoint("RIGHT", -24, 0)
    c.done = c:CreateTexture(nil, "OVERLAY")
    c.done:SetSize(16, 16); c.done:SetPoint("BOTTOMRIGHT", -6, 6)
    c.done:SetTexture("Interface\\RaidFrame\\ReadyCheck-Ready")
    -- attunement progress (attunement cards only)
    c.prog = CreateFrame("StatusBar", nil, c)
    c.prog:SetPoint("BOTTOMLEFT", 8, 24); c.prog:SetPoint("BOTTOMRIGHT", -8, 24); c.prog:SetHeight(4)
    c.prog:SetStatusBarTexture("Interface\\Buttons\\WHITE8X8")
    c.prog.bg = c.prog:CreateTexture(nil, "BACKGROUND")
    c.prog.bg:SetAllPoints(); c.prog.bg:SetColorTexture(0, 0, 0, 0.6)
    c.prog:Hide()
    c.hiddenShade = c:CreateTexture(nil, "OVERLAY", nil, 7)
    c.hiddenShade:SetPoint("TOPLEFT", 1, -1); c.hiddenShade:SetPoint("BOTTOMRIGHT", -1, 1)
    c.hiddenShade:SetColorTexture(0, 0, 0, 0.7)
    c.hiddenText = c:CreateFontString(nil, "OVERLAY", "GameFontRedLarge")
    c.hiddenText:SetPoint("CENTER")
    c:SetHighlightTexture("Interface\\Buttons\\WHITE8X8")
    c:GetHighlightTexture():SetVertexColor(1, 1, 1, 0.07)
    c:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    c:SetScript("OnClick", function(self, btn)
        if btn == "RightButton" then J:Back() return end
        if Home.editing then
            DQF_DB.hiddenDungeons[self.key] = not DQF_DB.hiddenDungeons[self.key] or nil
            PlaySound(856)
            Home:Refresh()
        else
            J:ShowDungeon(self.key)
        end
    end)
    c:SetScript("OnEnter", function(self)
        local d = ns.dungeons[self.key]
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:AddLine(d.name, 1, 0.82, 0)
        GameTooltip:AddLine(L("Niveaux ", "Levels ") .. d.levels, 1, 1, 1)
        if d.entrance then GameTooltip:AddLine(ns.ZoneName(d.entrance.map), 0.8, 0.8, 0.8) end
        if d.bossInfo then GameTooltip:AddLine(("%d %s"):format(#d.bossInfo.bosses, L("boss", "bosses")), 0.8, 0.8, 0.8) end
        if d.attunement then
            GameTooltip:AddLine(ns.Attune.StatusText(ns.Attune.Status(d)))
            ns.Attune.AddAltLines(GameTooltip, d)
            GameTooltip:AddLine(" ")
        end
        GameTooltip:AddLine(Home.editing and L("Clic : masquer / afficher", "Click: hide / show")
            or L("Clic : ouvrir", "Click: open"), 0.4, 0.8, 1)
        GameTooltip:Show()
    end)
    c:SetScript("OnLeave", GameTooltip_Hide)
    return c
end

function Home:Build(f)
    local bar = CreateFrame("Frame", nil, f)
    bar:SetPoint("TOPLEFT"); bar:SetPoint("TOPRIGHT"); bar:SetHeight(26)
    -- page title (the category is chosen with the side tabs of the window)
    local cat = CreateFrame("Frame", nil, bar)
    cat:SetHeight(24)
    cat:SetPoint("LEFT", 2, 0)
    bar.title = W.Font(cat, "GameFontNormalLarge")
    if ns.BLIZZ then ns.Skin.Ink(bar.title) end
    bar.title:SetPoint("LEFT", 4, 0)
    bar.cat = cat
    self.editBtn = W.Button(bar, "", 150, 22, function()
        Home.editing = not Home.editing
        Home:Refresh()
    end, function() return L("Choisir les donjons affichés sur cette page.", "Choose the dungeons shown on this page.") end)
    self.editBtn:SetPoint("RIGHT", -6, 0)
    self.filterBtn = W.Button(bar, "", 120, 22, function() ns.LootFilter:Toggle() end,
        function() return L("Filtrer le butin des boss : recettes, classe, statistiques.",
            "Filter boss loot: recipes, class, stats.") end)
    self.filterBtn:SetPoint("RIGHT", self.editBtn, "LEFT", -6, 0)
    self.bar = bar

    local area = W.ScrollArea(f)
    area:SetPoint("TOPLEFT", bar, "BOTTOMLEFT", 0, -8)
    area:SetPoint("BOTTOMRIGHT")
    W.OnResize(area, function() if f:IsShown() then Home:Refresh() end end)
    self.area = area
    self.pool = W.Pool(function() return CreateCard(area.child) end)
    self.empty = W.Font(area.child, "GameFontDisable", true)
    if ns.BLIZZ then ns.Skin.Ink(self.empty, true) end
    self.empty:SetPoint("TOP", 0, -40)
end

function Home:Category() return DQF_DB.journal.homeCategory or "dungeons" end
function Home:SetCategory(cat)
    DQF_DB.journal.homeCategory = cat
    self.area:ScrollToTop()
    self:Refresh()
    J:RefreshSideTabs()
end

function Home:Show() self.area:ScrollToTop(); self:Refresh() end
function Home:Layout() if self.frame:IsShown() then self:Refresh() end end

function Home:Refresh()
    local cat = self:Category()
    self.bar.title:SetText(cat == "overworld" and L("Monde (Over World)", "Over World")
        or cat == "attunement" and L("Quêtes d'accès", "Attunements") or L("Tous les donjons", "All dungeons"))
    self.bar.cat:SetWidth(self.bar.title:GetStringWidth() + 30)
    self.editBtn:SetLabel(self.editing and L("Terminé", "Done") or L("Masquer des donjons", "Hide dungeons"))
    self.editBtn:FitText(24)
    self.filterBtn:SetLabel(L("Filtre de butin", "Loot filter") .. (ns.LootFilter:IsActive() and " |cff33ff33*|r" or ""))
    self.filterBtn:FitText(24)

    local keys = {}
    for _, key in ipairs(ns.dungeonOrder) do
        local d = ns.dungeons[key]
        local dcat = d.attunement and "attunement" or (d.overworld and "overworld" or "dungeons")
        if dcat == cat and (self.editing or not DQF_DB.hiddenDungeons[key]) then
            keys[#keys + 1] = key
        end
    end
    table.sort(keys, function(a, b)
        local da, db = ns.dungeons[a], ns.dungeons[b]
        if da.order and db.order then return da.order < db.order end
        local la, lb = FirstLevel(da), FirstLevel(db)
        if la ~= lb then return la < lb end
        return da.name < db.name
    end)

    self.pool:ReleaseAll()
    -- margins so the card shadows are not cut by the scroll area
    local w = self.area:GetWidth() - 8 - 2 * SHADOW
    if w <= 0 then return end
    local cols = math.max(1, math.floor((w + GAP) / (CARD_MIN_W + GAP)))
    local cw = (w - (cols - 1) * GAP) / cols
    local faction = UnitFactionGroup("player")
    for i, key in ipairs(keys) do
        local d = ns.dungeons[key]
        local c = self.pool:Get()
        c.key = key
        local col, row = (i - 1) % cols, math.floor((i - 1) / cols)
        c:ClearAllPoints()
        c:SetPoint("TOPLEFT", SHADOW + col * (cw + GAP), -4 - row * (CARD_H + GAP))
        c:SetBackdropBorderColor(0, 0, 0, 0.75)
        c:SetWidth(cw)
        c.iconBack:SetTexture(d.icon)
        if d.art then
            c.art:SetTexture(d.art)
            local co = d.artCoord or { 0, 1, 0, 1 }
            c.art:SetTexCoord(co[1], co[2], co[3], co[4])
            c.art:Show()
        else
            c.art:Hide()
        end
        c.icon:SetTexture(d.icon)
        c.name:SetText(d.name)
        c.levels:SetText(L("NIV. ", "LV ") .. d.levels)
        local tag = d.comingSoon and ("|cff888888" .. L("Bientôt", "Soon") .. "|r")
            or (d.new and "|cff33ff99Forever|r") or (d.overworld and ("|cff99ccff" .. L("Monde", "World") .. "|r"))
            or (d.attunement and ("|cffff8040" .. L("Raid", "Raid") .. "|r")) or ""
        c.tag:SetText(tag)
        local quests = ns.QuestInfo.VisibleQuests(d, faction)
        local done = 0
        for _, e in ipairs(quests) do if ns.QuestInfo.State(e.quest) == 3 then done = done + 1 end end
        local fIcon = faction == "Horde" and "|TInterface\\TargetingFrame\\UI-PVP-Horde:16:16:0:0:64:64:0:40:0:40|t"
            or "|TInterface\\TargetingFrame\\UI-PVP-Alliance:16:16:0:0:64:64:0:40:0:40|t"
        if d.faction and d.faction ~= faction then
            c.quests:SetText("|cffff6060" .. L("Réservé à l'autre faction", "Other faction only") .. "|r")
        elseif #quests == 0 then
            c.quests:SetText("|cff888888" .. L("Aucune quête", "No quest") .. "|r")
        else
            c.quests:SetText(("%s %d/%d %s"):format(fIcon, done, #quests, L("quêtes", "quests")))
        end
        c.done:SetShown(#quests > 0 and done == #quests)
        c.prog:Hide()
        if d.attunement then
            -- attunement: status and progress bar (like the Attune addon)
            local state, sd, st = ns.Attune.Status(d)
            c.quests:SetText(ns.Attune.StatusText(state, sd, st))
            c.done:SetShown(state == "done")
            c.prog:SetMinMaxValues(0, math.max(1, st))
            c.prog:SetValue(sd)
            if state == "done" then c.prog:SetStatusBarColor(0.3, 0.9, 0.3) else c.prog:SetStatusBarColor(W.Accent()) end
            c.prog:Show()
        end
        local hidden = DQF_DB.hiddenDungeons[key]
        c.hiddenShade:SetShown(self.editing and hidden or false)
        c.hiddenText:SetText(self.editing and hidden and L("MASQUÉ", "HIDDEN") or "")
        c:SetAlpha(d.comingSoon and 0.7 or 1)
    end
    local rows = math.ceil(#keys / cols)
    self.empty:SetText(#keys == 0 and L("Tous les donjons sont masqués. Cliquer sur « Masquer des donjons » pour les réafficher.",
        "All dungeons are hidden. Click \"Hide dungeons\" to show them again.") or "")
    self.empty:SetWidth(w - 40)
    self.area:SetContentHeight(rows * (CARD_H + GAP) + SHADOW)
end

J:AddPage("home", Home)
