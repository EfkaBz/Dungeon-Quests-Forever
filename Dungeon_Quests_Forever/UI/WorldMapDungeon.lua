local _, ns = ...
local L = ns.L
local WMD = {}
ns.WorldMapDungeon = WMD
ns:RegisterModule(WMD)

-- When the world map (M key) shows the map of a journal dungeon: boss
-- portraits at their learned positions (click: boss loot in the journal),
-- the entrance, and a button to open the dungeon journal.

local pins = {}

local function GetPin(canvas, i)
    local p = pins[i]
    if not p then
        p = CreateFrame("Button", nil, canvas)
        p.tex = p:CreateTexture(nil, "ARTWORK")
        p.tex:SetAllPoints()
        if p.CreateMaskTexture then
            p.mask = p:CreateMaskTexture()
            p.mask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
            p.mask:SetAllPoints()
        end
        p.ring = p:CreateTexture(nil, "OVERLAY")
        p.ring:SetPoint("TOPLEFT", -3, 3); p.ring:SetPoint("BOTTOMRIGHT", 3, -3)
        p.ring:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
        p.ring:SetTexCoord(0, 0.6, 0, 0.6)
        p:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
        p:SetScript("OnEnter", function(s)
            GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
            GameTooltip:AddLine(s.title or "", 1, 0.82, 0)
            if s.note then GameTooltip:AddLine(s.note, 1, 1, 1) end
            GameTooltip:Show()
        end)
        p:SetScript("OnLeave", GameTooltip_Hide)
        p:SetScript("OnClick", function(s) if s.onClick then s.onClick() end end)
        pins[i] = p
    end
    p:SetParent(canvas)
    p:SetFrameStrata("HIGH")
    p:Show()
    return p
end

function WMD:Refresh()
    for _, p in ipairs(pins) do p:Hide() end
    if self.button then self.button:Hide() end
    if not (DQF_DB.dungeonWorldMap and WorldMapFrame and WorldMapFrame:IsShown()) then return end
    local canvas = WorldMapFrame:GetCanvas()
    local map = WorldMapFrame:GetMapID()
    if not (canvas and map) then return end
    local d = ns.JournalMap.DungeonOfMap(map)
    if not d then return end
    local w, h = canvas:GetSize()
    local size = 25
    local n = 0
    for _, e in ipairs(ns.JournalBosses.Entries(d)) do
        local b = e.boss
        local pos = b and ns.JournalMap.BossPosition(d, b)
        if pos and pos.map == map then
            n = n + 1
            local p = GetPin(canvas, n)
            if p.mask and not p.masked then p.tex:AddMaskTexture(p.mask); p.masked = true end
            p.ring:Show()
            ns.JournalBosses.SetPortrait(p.tex, b, d.icon)
            p.title = ns.BossName(b)
            p.note = (b.level and (L("Niveau ", "Level ") .. b.level .. "  -  ") or "") .. L("Clic : butin", "Click: loot")
            p.onClick = function() ns.Journal:Open(d.key, "bosses", e.index) end
            p:SetSize(size, size)
            ns.PlaceOnCanvas(p, canvas, pos.x * w, pos.y * h)
        end
    end
    local entry = DQF_Cache.entries and DQF_Cache.entries[d.key]
    if entry and entry.map == map then
        n = n + 1
        local p = GetPin(canvas, n)
        if p.masked then p.tex:RemoveMaskTexture(p.mask); p.masked = false end
        p.ring:Hide()
        if not (p.tex.SetAtlas and pcall(p.tex.SetAtlas, p.tex, "Dungeon")) then
            p.tex:SetTexture("Interface\\Icons\\Spell_Arcane_TeleportStormwind")
        end
        p.title, p.note, p.onClick = L("Entrée", "Entrance"), nil, nil
        p:SetSize(size * 0.7, size * 0.7)
        ns.PlaceOnCanvas(p, canvas, entry.x * w, entry.y * h)
    end
    -- button: open the journal on this dungeon
    if not self.button then
        local b = ns.Widgets.Button(WorldMapFrame, "", 150, 22, function()
            local dd = self.dungeon
            if dd then ns.Journal:Open(dd.key, "bosses") end
        end)
        b:SetFrameStrata("HIGH")
        self.button = b
    end
    self.dungeon = d
    local container = WorldMapFrame.ScrollContainer or canvas
    self.button:ClearAllPoints()
    self.button:SetPoint("TOPRIGHT", container, "TOPRIGHT", -8, -8)
    self.button:SetLabel(L("Dungeon Home : ", "Dungeon Home: ") .. d.name)
    self.button:FitText(24)
    self.button:Show()
end

function WMD:Init()
    if not WorldMapFrame then return end
    WorldMapFrame:HookScript("OnShow", function() WMD:Refresh() end)
    WorldMapFrame:HookScript("OnHide", function() if WMD.button then WMD.button:Hide() end end)
    if WorldMapFrame.OnMapChanged then
        hooksecurefunc(WorldMapFrame, "OnMapChanged", function() WMD:Refresh() end)
    end
end
