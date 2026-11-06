local _, ns = ...
local L = ns.L
local W = ns.Widgets
local J = ns.Journal
local B = {}
ns.JournalBosses = B

-- Bosses tab: boss list (portrait, level, rare) and the loot of the selected
-- boss. Items ruled out by the loot filter are dimmed, recipes are hidden
-- unless the filter shows them.

local LIST_W, ROW_H = 280, 50
local TRASH_ICON, EXTRA_ICON = "Interface\\Icons\\INV_Misc_Bag_10", "Interface\\Icons\\INV_Box_01"

----------------------------------------------------------------------
-- Portraits: still images (round). The boss appearance (display ID) is read
-- from the game with its NPC ID on a hidden model, once the model is really
-- loaded; the display ID of the loot data is used meanwhile / as fallback.
-- The game draws the portrait a moment later: it is applied again shortly.
----------------------------------------------------------------------
local resolved = {} -- [npcID] = display ID read from the game (this session)
local queue, busy = {}, false
local probe

local function NextProbe()
    local e = table.remove(queue, 1)
    if not e then busy = false return end
    busy = true
    if not probe then
        probe = CreateFrame("PlayerModel", nil, UIParent)
        probe:SetSize(64, 64)
        probe:SetPoint("TOPLEFT", UIParent, "BOTTOMRIGHT", 100, -100) -- off screen
        probe:SetScript("OnModelLoaded", function(m)
            local cur = m.npc
            if not cur then return end
            local ok, id = pcall(m.GetDisplayInfo, m)
            m.npc = nil
            if ok and id and id > 0 then
                resolved[cur] = id
                if B.frame and B.frame:IsShown() then B:RefreshSoon() end
            else
                resolved[cur] = false
            end
            C_Timer.After(0.05, NextProbe)
        end)
    end
    probe.npc = e
    probe:ClearModel()
    if not pcall(probe.SetCreature, probe, e) then probe.npc = nil; resolved[e] = false; return NextProbe() end
    -- no answer from the game: give up on this one, go on with the next
    C_Timer.After(2, function()
        if probe.npc == e then probe.npc = nil; NextProbe() end
    end)
end

local function Resolve(npc)
    if not npc or resolved[npc] ~= nil then return end
    resolved[npc] = false -- queued
    queue[#queue + 1] = npc
    if not busy then NextProbe() end
end

local function DisplayOf(boss)
    if not boss or boss.extra then return end
    if boss.displayChecked then return boss.display end -- observed on the Forever client
    local id = boss.npcID and resolved[boss.npcID]
    if id then return id end
    Resolve(boss.npcID)
    return boss.display
end

-- tex = texture (round mask); applied again later (portraits are drawn async)
function B.SetPortrait(tex, boss, fallback)
    tex.boss = boss
    local id = DisplayOf(boss)
    if id and SetPortraitTextureFromCreatureDisplayID then
        tex:SetTexCoord(0, 1, 0, 1)
        SetPortraitTextureFromCreatureDisplayID(tex, id)
        for _, delay in ipairs({ 0.5, 2 }) do
            C_Timer.After(delay, function()
                if tex.boss == boss and tex:IsVisible() then
                    local now = DisplayOf(boss)
                    if now then SetPortraitTextureFromCreatureDisplayID(tex, now) end
                end
            end)
        end
        return
    end
    tex:SetTexture(fallback or "Interface\\Icons\\INV_Misc_QuestionMark")
    tex:SetTexCoord(0.08, 0.92, 0.08, 0.92)
end

function B:RefreshSoon()
    if self.refreshPending then return end
    self.refreshPending = true
    C_Timer.After(0.2, function()
        self.refreshPending = false
        if self.frame and self.frame:IsShown() then self:Refresh() end
    end)
end

-- Round portrait with a ring
local function Portrait(parent, size)
    local p = CreateFrame("Frame", nil, parent)
    p:SetSize(size, size)
    p.tex = p:CreateTexture(nil, "ARTWORK")
    p.tex:SetAllPoints()
    if p.CreateMaskTexture then
        local mask = p:CreateMaskTexture()
        mask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
        mask:SetAllPoints()
        p.tex:AddMaskTexture(mask)
    end
    p.ring = p:CreateTexture(nil, "OVERLAY")
    p.ring:SetPoint("TOPLEFT", -4, 4); p.ring:SetPoint("BOTTOMRIGHT", 4, -4)
    p.ring:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    p.ring:SetTexCoord(0, 0.6, 0, 0.6)
    p.level = p:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    p.level:SetPoint("BOTTOM", 0, -4)
    return p
end

-- Entries of the list: bosses, then extra lists, then trash
local function Entries(d)
    local info, out = d.bossInfo, {}
    if not info then return out end
    for i, b in ipairs(info.bosses) do out[#out + 1] = { boss = b, index = i } end
    if info.trash and #info.trash > 0 then out[#out + 1] = { trash = true, index = "trash" } end
    return out
end
B.Entries = Entries

local function EntryName(e)
    if e.trash then return L("Butin des monstres", "Trash drops") end
    return ns.BossName(e.boss)
end
local function EntryLoot(d, e) return e.trash and d.bossInfo.trash or e.boss.loot end

----------------------------------------------------------------------
local function CreateRow(parent)
    local r = W.Row(parent, ROW_H)
    r.icon:Hide()
    r.portrait = Portrait(r, 38)
    r.portrait:SetPoint("LEFT", 8, 0)
    r.main:ClearAllPoints()
    r.main:SetPoint("TOPLEFT", r.portrait, "TOPRIGHT", 12, -4)
    r.main:SetPoint("RIGHT", -8, 0)
    r.sub:SetPoint("RIGHT", -8, 0)
    r:SetScript("OnClick", function(self, btn)
        if btn == "RightButton" then J:Back() return end
        B:Select(self.index)
    end)
    return r
end

function B:Build(f)
    B.frame = f
    local left = ns.Panel(f, "bg", nil, true)
    left:SetPoint("TOPLEFT"); left:SetPoint("BOTTOMLEFT"); left:SetWidth(LIST_W)
    left:SetBackdropColor(0, 0, 0, 0.3)
    if ns.BLIZZ then ns.Skin.MakeListBox(left) end
    local list = W.ScrollArea(left)
    list:SetPoint("TOPLEFT", 4, -4); list:SetPoint("BOTTOMRIGHT", -4, 4)
    W.OnResize(list, function() if f:IsShown() then B:RefreshList() end end)
    self.list = list
    self.rows = W.Pool(function() return CreateRow(list.child) end)

    local right = CreateFrame("Frame", nil, f)
    right:SetPoint("TOPLEFT", left, "TOPRIGHT", 8, 0); right:SetPoint("BOTTOMRIGHT")
    if ns.BLIZZ then ns.Skin.ListBox(right, 2) end
    local head = CreateFrame("Frame", nil, right)
    head:SetPoint("TOPLEFT"); head:SetPoint("TOPRIGHT"); head:SetHeight(70)
    head.portrait = Portrait(head, 58)
    head.portrait:SetPoint("LEFT", 10, 0)
    head.name = W.Font(head, "GameFontNormalHuge")
    head.name:SetPoint("TOPLEFT", head.portrait, "TOPRIGHT", 16, -6)
    head.info = W.Font(head, "GameFontHighlightSmall")
    head.info:SetPoint("TOPLEFT", head.name, "BOTTOMLEFT", 0, -6)
    head.mapBtn = W.Button(head, "", 120, 22, function()
        if B.index then J:ShowTab("map", { boss = B.index }) end
    end, function() return L("Voir l'emplacement du boss sur la carte du donjon.", "See where the boss is on the dungeon map.") end)
    head.mapBtn:SetPoint("TOPRIGHT", -6, -6)
    self.head = head
    local loot = W.ScrollArea(right)
    loot:SetPoint("TOPLEFT", head, "BOTTOMLEFT", 0, -4); loot:SetPoint("BOTTOMRIGHT")
    W.OnResize(loot, function() if f:IsShown() then B:RefreshLoot() end end)
    self.loot = loot
    self.flow = W.Flow(loot, 10)
end

function B:Show(d, arg)
    if self.d ~= d then self.d, self.index = d, nil; self.list:ScrollToTop() end
    self.highlight = nil
    if type(arg) == "table" then
        self.index = arg.boss or self.index
        self.highlight = arg.item
    elseif arg then
        self.index = arg
    end
    local entries = Entries(d)
    if not self.index and entries[1] then self.index = entries[1].index end
    self:Refresh()
end

function B:Refresh() self:RefreshList(); self:RefreshLoot() end
function B:Layout() end

function B:Select(index)
    self.index, self.highlight = index, nil
    self:Refresh()
end

function B:Current()
    for _, e in ipairs(Entries(self.d)) do if e.index == self.index then return e end end
end

function B:RefreshList()
    local d = self.d
    if not d then return end
    self.rows:ReleaseAll()
    local w, y = self.list.child:GetWidth(), 0
    for _, e in ipairs(Entries(d)) do
        local r = self.rows:Get()
        r.index = e.index
        r:ClearAllPoints()
        r:SetPoint("TOPLEFT", 0, y); r:SetWidth(w)
        local name = EntryName(e)
        if e.boss and e.boss.rare then name = name .. "  |cffc0c0c0" .. L("(rare)", "(rare)") .. "|r" end
        r.main:SetText(name)
        local n = #ns.LootFilter:PageLoot(EntryLoot(d, e))
        local sub = ("%d %s"):format(n, n > 1 and L("objets", "items") or L("objet", "item"))
        if e.boss and e.boss.level then sub = L("Niv. ", "Lv ") .. e.boss.level .. "   " .. sub end
        r.sub:SetText(sub)
        B.SetPortrait(r.portrait.tex, e.boss, e.trash and TRASH_ICON or (e.boss.extra and EXTRA_ICON) or d.icon)
        r.portrait.level:SetText("")
        r:SetSelected(e.index == self.index)
        y = y - ROW_H
    end
    self.list:SetContentHeight(-y)
end

function B:RefreshLoot()
    local d, flow = self.d, self.flow
    flow:Clear()
    local e = d and self:Current()
    local head = self.head
    if not e then
        head.name:SetText(""); head.info:SetText(""); head.mapBtn:Hide()
        flow:Text(L("Aucune donnée de butin pour ce donjon.", "No loot data for this dungeon."), { font = "GameFontDisable" })
        flow:Finish()
        return
    end
    head.name:SetText(EntryName(e))
    B.SetPortrait(head.portrait.tex, e.boss, e.trash and TRASH_ICON or (e.boss.extra and EXTRA_ICON) or d.icon)
    local info = {}
    if e.boss and e.boss.level then info[#info + 1] = "|cffffd100" .. L("Niveau ", "Level ") .. e.boss.level .. "|r" end
    if e.boss and e.boss.rare then info[#info + 1] = "|cffc0c0c0" .. L("Monstre rare (n'apparaît pas toujours)", "Rare spawn (not always there)") .. "|r" end
    if e.trash then info[#info + 1] = L("Objets lâchés par les monstres du donjon", "Items dropped by the dungeon's mobs") end
    head.info:SetText(table.concat(info, "    "))
    local hasPos = e.boss and e.boss.npcID and ns.JournalMap and ns.JournalMap.BossPosition(d, e.boss)
    head.mapBtn:SetLabel(L("Sur la carte", "On the map")); head.mapBtn:FitText(24)
    head.mapBtn:SetShown(hasPos and true or false)

    local all = EntryLoot(d, e)
    local shown = ns.LootFilter:PageLoot(all)
    local src = L("Butin : ", "Drop: ") .. EntryName(e) .. " (" .. d.name .. ")"
    local list = {}
    for _, id in ipairs(shown) do
        list[#list + 1] = { id, { source = src, dim = not ns.LootFilter:Matches(id) } }
    end
    if #list == 0 then
        flow:Text(L("Aucun objet (filtre de butin actif ?)", "No item (loot filter on?)"), { font = "GameFontDisable" })
    else
        flow:Items(list)
    end
    local hidden = #all - #shown
    if hidden > 0 then
        flow:Space(4)
        flow:Text(("|cff888888%d %s|r"):format(hidden, L("recette(s) masquée(s) par le filtre de butin", "recipe(s) hidden by the loot filter")),
            { font = "GameFontHighlightSmall" })
    end
    flow:Finish()
    -- item found by the search: make it blink once
    if self.highlight then ns.Widgets.FlashItem(self.loot.child, self.highlight) end
end

J:AddPage("bosses", B)
