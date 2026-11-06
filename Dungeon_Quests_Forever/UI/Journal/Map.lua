local _, ns = ...
local L = ns.L
local W = ns.Widgets
local J = ns.Journal
local JM = {}
ns.JournalMap = JM
ns:RegisterModule(JM)

-- Map tab: the dungeon map drawn from the game's own map tiles, one button
-- per floor, mouse-wheel zoom, drag to pan, boss pins (click: boss loot),
-- the entrance and the player when inside.
-- Positions are learned while playing (account-wide cache):
--   boss  : where the player stands when a boss is targeted close by
--   entry : where the player appears when entering the dungeon
--   maps  : the dungeon maps the player has been on

----------------------------------------------------------------------
-- Dungeon maps
----------------------------------------------------------------------
local byName -- [map name] = { uiMapIDs of dungeon maps }
local function ScanMaps()
    if byName then return byName end
    byName = {}
    local dungeonType = Enum and Enum.UIMapType and Enum.UIMapType.Dungeon or 4
    for id = 1, 2500 do
        local info = C_Map.GetMapInfo(id)
        if info and info.mapType == dungeonType and info.name then
            byName[info.name] = byName[info.name] or {}
            table.insert(byName[info.name], id)
        end
    end
    return byName
end

-- floors of a map group, in order
local function GroupFloors(map)
    local group = C_Map.GetMapGroupID and C_Map.GetMapGroupID(map)
    local members = group and C_Map.GetMapGroupMembersInfo(group)
    if not members or #members == 0 then return { map } end
    table.sort(members, function(a, b) return (a.relativeHeightIndex or 0) < (b.relativeHeightIndex or 0) end)
    local out = {}
    for _, m in ipairs(members) do out[#out + 1] = m.mapID end
    return out
end

local function HasArt(map)
    local layers = C_Map.GetMapArtLayers and C_Map.GetMapArtLayers(map)
    return layers and layers[1] and true or false
end

local mapCache = {}
function JM.Maps(d)
    if mapCache[d.key] then return mapCache[d.key] end
    local out, seen = {}, {}
    local function Add(m) if m and not seen[m] and HasArt(m) then seen[m] = true; out[#out + 1] = m end end
    if d.wingMap and C_Map.GetMapInfo(d.wingMap) then
        Add(d.wingMap)
    else
        local names = ScanMaps()
        local area = d.bossInfo and d.bossInfo.area
        local areaName = area and C_Map.GetAreaInfo and C_Map.GetAreaInfo(area)
        for _, name in ipairs({ areaName, d.name }) do
            for _, m in ipairs((name and names[name]) or {}) do
                for _, f in ipairs(GroupFloors(m)) do Add(f) end
            end
        end
        for _, m in ipairs(DQF_Cache.maps[d.key] or {}) do
            for _, f in ipairs(GroupFloors(m)) do Add(f) end
        end
    end
    if #out > 0 then mapCache[d.key] = out end
    return out
end
ns.DungeonMaps = function(key) return ns.dungeons[key] and JM.Maps(ns.dungeons[key]) or {} end

function JM.HasMap(d) return #JM.Maps(d) > 0 end

-- Dungeon of a uiMapID (world map display), or nil
function JM.DungeonOfMap(map)
    for _, key in ipairs(ns.dungeonOrder) do
        local d = ns.dungeons[key]
        if d.bossInfo or #d.steps > 0 then
            for _, m in ipairs(mapCache[key] or {}) do if m == map then return d end end
        end
    end
    local here = ns.InstanceDungeon()
    if here and tContains(JM.Maps(ns.dungeons[here]), map) then return ns.dungeons[here] end
end

-- { map, x, y } (0-1) of a boss, learned or given by the data
function JM.BossPosition(d, b)
    if not b then return end
    local p = b.npcID and DQF_Cache.bossPos[b.npcID]
    if p then return p end
    if b.pin then return { map = b.pin[1], x = b.pin[2], y = b.pin[3] } end
end

----------------------------------------------------------------------
-- Learning (inside dungeons)
----------------------------------------------------------------------
local function PlayerPos()
    local map = C_Map.GetBestMapForUnit("player")
    local pos = map and C_Map.GetPlayerMapPosition(map, "player")
    if pos and pos.x and pos.x > 0 then return map, pos.x, pos.y end
end

local BossDungeon
-- Dungeon whose boss list has this name. Used when the instance name does
-- not match the guide name (new Forever dungeons): the instance is then
-- remembered for the next visits.
BossDungeon = function(name)
    if not name or ns.IsSecret(name) then return end
    for key, d in pairs(ns.dungeons) do
        for _, b in ipairs(d.bossInfo and d.bossInfo.bosses or {}) do
            if b.name == name or ns.BossName(b) == name or (b.aliases and tContains(b.aliases, name)) then
                local _, _, _, _, _, _, _, instanceID = GetInstanceInfo()
                if instanceID and not d.bossInfo.instance then DQF_Cache.instances[instanceID] = key end
                return key
            end
        end
    end
end

-- Boss appearance read from the unit itself (works when its GUID / NPC ID
-- is secret): the unit is put on a hidden model and its display ID is read
-- once loaded. Saved as DQF_Cache.bossDisplay["KEY:index"].
local dprobe
local function LearnDisplay(unit, key, i, b)
    if not b or b.displayChecked or not UnitExists(unit) then return end
    if not dprobe then
        dprobe = CreateFrame("PlayerModel", nil, UIParent)
        dprobe:SetSize(64, 64)
        dprobe:SetPoint("TOPLEFT", UIParent, "BOTTOMRIGHT", 100, -100) -- off screen
        dprobe:SetScript("OnModelLoaded", function(m)
            local t = m.want
            if not t then return end
            m.want = nil
            local ok, id = pcall(m.GetDisplayInfo, m)
            if not ok or not id or ns.IsSecret(id) or id <= 0 then return end
            t.b.display, t.b.displayChecked = id, true
            DQF_Cache.bossDisplay = DQF_Cache.bossDisplay or {}
            DQF_Cache.bossDisplay[t.key .. ":" .. t.i] = id
            print("|cff9d7bffDungeon Quests|r " .. L("portrait appris :", "portrait learned:") .. " " .. t.b.name .. " (display " .. id .. ")")
            if ns.JournalBosses.frame and ns.JournalBosses.frame:IsShown() then ns.JournalBosses:Refresh() end
        end)
    end
    dprobe.want = { key = key, i = i, b = b }
    dprobe:ClearModel()
    pcall(dprobe.SetUnit, dprobe, unit)
end

-- boss index of a dungeon by name (or alias)
local function BossIndex(d, name)
    if not name or ns.IsSecret(name) then return end
    for i, b in ipairs(d.bossInfo and d.bossInfo.bosses or {}) do
        if b.name == name or ns.BossName(b) == name or (b.aliases and tContains(b.aliases, name)) then return i, b end
    end
end

local function LearnBoss(unit)
    if not (IsInInstance() and UnitExists(unit)) then return end
    local key = ns.InstanceDungeon() or BossDungeon(UnitName(unit))
    local d = key and ns.dungeons[key]
    if not (d and d.bossInfo) then return end
    local bi, bb = BossIndex(d, UnitName(unit))
    if bi then LearnDisplay(unit, key, bi, bb) end
    local id = ns.NpcIDFromGUID(UnitGUID(unit))
    if not id then return end
    -- bosses without NPC ID (new Forever dungeons): learn it from the name
    local name = UnitName(unit)
    if name and not ns.IsSecret(name) then
        for i, b in ipairs(d.bossInfo.bosses) do
            if not b.npcID and not b.extra and (name == b.name or name == ns.BossName(b)) then
                b.npcID = id
                DQF_Cache.npcIDs = DQF_Cache.npcIDs or {}
                DQF_Cache.npcIDs[key .. ":" .. i] = id
                if ns.JournalBosses.frame and ns.JournalBosses.frame:IsShown() then ns.JournalBosses:Refresh() end
            end
        end
    end
    for _, b in ipairs(d.bossInfo.bosses) do
        local match = b.npcID == id or (type(b.npc) == "table" and tContains(b.npc, id))
        if match then
            -- precision 1 = within ~10 yards, 2 = within ~28 yards
            local ok1, near = pcall(CheckInteractDistance, unit, 3)
            local ok2, far = pcall(CheckInteractDistance, unit, 4)
            local prec = (ok1 and near) and 1 or ((ok2 and far) and 2 or nil)
            local old = DQF_Cache.bossPos[b.npcID]
            if prec and (not old or (old.prec or 3) > prec) then
                local map, x, y = PlayerPos()
                if map then DQF_Cache.bossPos[b.npcID] = { map = map, x = x, y = y, prec = prec } end
            end
            return
        end
    end
end

local function LearnInstance(entering)
    if not IsInInstance() then return end
    local key = ns.InstanceDungeon()
    if not key then return end
    local map, x, y = PlayerPos()
    if not map then return end
    DQF_Cache.maps[key] = DQF_Cache.maps[key] or {}
    if not tContains(DQF_Cache.maps[key], map) then
        table.insert(DQF_Cache.maps[key], map)
        mapCache[key] = nil
    end
    local d = ns.dungeons[key]
    local _, _, _, _, _, _, _, instanceID = GetInstanceInfo()
    if instanceID and not (d.bossInfo and d.bossInfo.instance) then DQF_Cache.instances[instanceID] = key end
    if entering then
        DQF_Cache.entries = DQF_Cache.entries or {}
        DQF_Cache.entries[key] = DQF_Cache.entries[key] or { map = map, x = x, y = y }
    end
end

function JM:Init()
    ns:On("PLAYER_TARGET_CHANGED", function() LearnBoss("target") end)
    ns:On("UPDATE_MOUSEOVER_UNIT", function() LearnBoss("mouseover") end)
    ns:On("NAME_PLATE_UNIT_ADDED", function(unit) LearnBoss(unit) end)
    -- boss frames during an encounter (the encounter name also identifies the dungeon)
    ns:On("ENCOUNTER_START", function(_, encounterName)
        if IsInInstance() and not ns.InstanceDungeon() then BossDungeon(encounterName) end
        for i = 1, 5 do LearnBoss("boss" .. i) end
        -- the encounter name is readable even when the unit name is secret
        local key = ns.InstanceDungeon()
        local d = key and ns.dungeons[key]
        local bi, bb
        if d then bi, bb = BossIndex(d, encounterName) end
        if bi then C_Timer.After(0.5, function() LearnDisplay("boss1", key, bi, bb) end) end
    end)
    ns:On("PLAYER_ENTERING_WORLD", function() C_Timer.After(2, function() LearnInstance(true) end) end)
    ns:On("ZONE_CHANGED_INDOORS", function() LearnInstance(false) end)
    ns:On("ZONE_CHANGED", function() LearnInstance(false) end)
end

----------------------------------------------------------------------
-- Map widget (also used on the world map, see UI\WorldMapDungeon.lua)
----------------------------------------------------------------------
-- Creates a map view: view:SetDungeon(d, floorIndex), view:Refresh()
function JM.CreateView(parent, onBossClick)
    local v = CreateFrame("Frame", nil, parent)
    v.zoom, v.panX, v.panY = 1, 0, 0
    v.clip = CreateFrame("Frame", nil, v)
    v.clip:SetPoint("TOPLEFT", 0, -28); v.clip:SetPoint("BOTTOMRIGHT")
    v.clip:SetClipsChildren(true)
    v.clip.bg = v.clip:CreateTexture(nil, "BACKGROUND")
    v.clip.bg:SetAllPoints(); v.clip.bg:SetColorTexture(0, 0, 0, 0.6)
    v.canvas = CreateFrame("Frame", nil, v.clip)
    v.tiles, v.pins, v.floorBtns = {}, {}, {}
    v.empty = W.Font(v.clip, "GameFontDisable", true)
    v.empty:SetPoint("CENTER")
    v.empty:SetJustifyH("CENTER")
    v.hint = W.Font(v, "GameFontDisableSmall")
    v.hint:SetPoint("TOPRIGHT", -4, -6)
    v.hint:SetJustifyH("RIGHT")
    if ns.BLIZZ then ns.Skin.Ink(v.hint, true) end

    -- zoom around the cursor, drag to pan
    v.clip:EnableMouseWheel(true)
    v.clip:SetScript("OnMouseWheel", function(_, delta)
        local old = v.zoom
        v.zoom = math.max(1, math.min(4, v.zoom + delta * 0.5))
        if v.zoom == old then return end
        local cx, cy = GetCursorPosition()
        local s = v.clip:GetEffectiveScale()
        local l, t = v.clip:GetLeft(), v.clip:GetTop()
        local mx, my = cx / s - l, t - cy / s
        local k = v.zoom / old
        v.panX = mx - (mx - v.panX) * k
        v.panY = my - (my - v.panY) * k
        v:Place()
    end)
    v.clip:EnableMouse(true)
    v.clip:SetScript("OnMouseDown", function(_, btn)
        if btn ~= "LeftButton" or v.zoom <= 1 then return end
        local cx, cy = GetCursorPosition()
        v.drag = { cx, cy, v.panX, v.panY }
        v.clip:SetScript("OnUpdate", function()
            local nx, ny = GetCursorPosition()
            local s = v.clip:GetEffectiveScale()
            v.panX = v.drag[3] + (nx - v.drag[1]) / s
            v.panY = v.drag[4] - (ny - v.drag[2]) / s
            v:Place()
        end)
    end)
    v.clip:SetScript("OnMouseUp", function(_, btn)
        v.clip:SetScript("OnUpdate", nil)
        v.drag = nil
        if btn == "RightButton" and v.onRightClick then v.onRightClick() end
    end)
    v.clip:SetScript("OnSizeChanged", function() v:Place() end)

    local function Pin(kind)
        local p = CreateFrame("Button", nil, v.canvas)
        p:SetSize(28, 28)
        p:SetFrameLevel(v.canvas:GetFrameLevel() + 5)
        p.tex = p:CreateTexture(nil, "ARTWORK")
        p.tex:SetAllPoints()
        if kind == "boss" and p.CreateMaskTexture then
            local mask = p:CreateMaskTexture()
            mask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
            mask:SetAllPoints()
            p.tex:AddMaskTexture(mask)
            p.ring = p:CreateTexture(nil, "OVERLAY")
            p.ring:SetPoint("TOPLEFT", -3, 3); p.ring:SetPoint("BOTTOMRIGHT", 3, -3)
            p.ring:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
            p.ring:SetTexCoord(0, 0.6, 0, 0.6)
        end
        p.label = p:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        p.label:SetPoint("TOP", p, "BOTTOM", 0, -1)
        p:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
        p:RegisterForClicks("LeftButtonUp", "RightButtonUp")
        p:SetScript("OnEnter", function(s)
            GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
            GameTooltip:AddLine(s.title or "", 1, 0.82, 0)
            if s.note then GameTooltip:AddLine(s.note, 1, 1, 1, true) end
            GameTooltip:Show()
        end)
        p:SetScript("OnLeave", GameTooltip_Hide)
        p:SetScript("OnClick", function(s, btn)
            if btn == "RightButton" then if v.onRightClick then v.onRightClick() end return end
            if s.onClick then s.onClick() end
        end)
        return p
    end
    v.pinPool = W.Pool(function() return Pin("boss") end)
    v.markPool = W.Pool(function() return Pin("mark") end)

    function v:SetDungeon(d, floor)
        if self.d ~= d then self.zoom, self.panX, self.panY = 1, 0, 0 end
        self.d = d
        self.maps = JM.Maps(d)
        self.floor = math.max(1, math.min(floor or self.floor or 1, #self.maps))
        self:Refresh()
    end

    function v:SetFloor(i) self.floor = i; self.zoom, self.panX, self.panY = 1, 0, 0; self:Refresh() end

    -- size of the map art (aspect), tiles of the current floor
    function v:DrawTiles()
        for _, t in ipairs(self.tiles) do t:Hide() end
        local map = self.maps[self.floor]
        local layers = map and C_Map.GetMapArtLayers(map)
        local layer = layers and layers[1]
        if not layer then self.artW, self.artH = nil, nil return end
        local textures = C_Map.GetMapArtLayerTextures(map, 1) or {}
        local cols = math.ceil(layer.layerWidth / layer.tileWidth)
        self.artW, self.artH = layer.layerWidth, layer.layerHeight
        self.tileW, self.tileH, self.cols = layer.tileWidth, layer.tileHeight, cols
        for i, file in ipairs(textures) do
            local t = self.tiles[i] or self.canvas:CreateTexture(nil, "BACKGROUND")
            self.tiles[i] = t
            t:SetTexture(file)
            t.col, t.row = (i - 1) % cols, math.floor((i - 1) / cols)
            t:Show()
        end
        self.numTiles = #textures
    end

    -- positions everything for the current size / zoom / pan
    function v:Place()
        if not self.artW then return end
        local cw, ch = self.clip:GetWidth(), self.clip:GetHeight()
        if cw <= 0 or ch <= 0 then return end
        local fit = math.min(cw / self.artW, ch / self.artH)
        local scale = fit * self.zoom
        local w, h = self.artW * scale, self.artH * scale
        -- keep the map inside the view
        if self.zoom <= 1 then
            self.panX, self.panY = (cw - w) / 2, (ch - h) / 2
        else
            self.panX = math.min(0, math.max(cw - w, self.panX))
            self.panY = math.min(0, math.max(ch - h, self.panY))
        end
        self.canvas:ClearAllPoints()
        self.canvas:SetPoint("TOPLEFT", self.clip, "TOPLEFT", self.panX, -self.panY)
        self.canvas:SetSize(w, h)
        for i = 1, self.numTiles or 0 do
            local t = self.tiles[i]
            t:ClearAllPoints()
            t:SetSize(self.tileW * scale, self.tileH * scale)
            t:SetPoint("TOPLEFT", self.canvas, "TOPLEFT", t.col * self.tileW * scale, -t.row * self.tileH * scale)
        end
        local size = math.max(22, math.min(40, 28 * math.sqrt(self.zoom)))
        for _, p in ipairs(self.placed or {}) do
            p:ClearAllPoints()
            p:SetSize(p.small and size * 0.6 or size, p.small and size * 0.6 or size)
            p:SetPoint("CENTER", self.canvas, "TOPLEFT", p.px * w, -p.py * h)
        end
    end

    function v:Refresh()
        local d = self.d
        self.pinPool:ReleaseAll(); self.markPool:ReleaseAll()
        self.placed = {}
        for _, b in ipairs(self.floorBtns) do b:Hide() end
        if not d or #self.maps == 0 then
            for _, t in ipairs(self.tiles) do t:Hide() end
            self.artW = nil
            self.empty:SetText(L("Pas de carte pour ce donjon dans le jeu.\nElle s'affichera dès que tu y seras entré.",
                "No map for this dungeon in the game.\nIt will show once you have been inside."))
            self.hint:SetText("")
            return
        end
        self.empty:SetText("")
        -- floor buttons
        local prev
        for i, m in ipairs(self.maps) do
            local b = self.floorBtns[i]
            if not b then
                b = W.Button(self, "", 80, 22)
                self.floorBtns[i] = b
            end
            local info = C_Map.GetMapInfo(m)
            local name = (#self.maps > 1 and info and info.name ~= d.name and info.name) or (L("Niveau ", "Level ") .. i)
            b:SetLabel(i == self.floor and ("|cff" .. W.AccentHex() .. name .. "|r") or name)
            b:FitText(20)
            b:SetScript("OnClick", function() PlaySound(856); self:SetFloor(i) end)
            b:ClearAllPoints()
            if prev then b:SetPoint("LEFT", prev, "RIGHT", 4, 0) else b:SetPoint("TOPLEFT", 0, -2) end
            b:SetShown(#self.maps > 1)
            prev = b
        end
        self.hint:SetText(L("Molette : zoom  -  glisser : déplacer", "Wheel: zoom  -  drag: move"))
        self:DrawTiles()
        local map = self.maps[self.floor]

        -- boss pins on this floor
        local unknown = 0
        for i, e in ipairs(ns.JournalBosses.Entries(d)) do
            local b = e.boss
            local pos = b and JM.BossPosition(d, b)
            if pos and pos.map == map then
                local p = self.pinPool:Get()
                ns.JournalBosses.SetPortrait(p.tex, b, d.icon)
                p.title = ns.BossName(b)
                p.note = (b.level and (L("Niveau ", "Level ") .. b.level .. "\n") or "") .. L("Clic : voir le butin", "Click: see the loot")
                p.label:SetText("")
                p.px, p.py, p.small = pos.x, pos.y, false
                p.onClick = function() if onBossClick then onBossClick(e.index) end end
                self.placed[#self.placed + 1] = p
                if self.focus == e.index then p.label:SetText("|cffffff00" .. p.title .. "|r") end
            elseif b and not b.extra then
                unknown = unknown + 1
            end
        end
        -- entrance (where the player appeared when entering)
        local entry = DQF_Cache.entries and DQF_Cache.entries[d.key]
        if entry and entry.map == map then
            local p = self.markPool:Get()
            if not (p.tex.SetAtlas and pcall(p.tex.SetAtlas, p.tex, "Dungeon")) then
                p.tex:SetTexture("Interface\\Icons\\Spell_Arcane_TeleportStormwind")
                p.tex:SetTexCoord(0.08, 0.92, 0.08, 0.92)
            end
            p.title, p.note = L("Entrée", "Entrance"), nil
            p.label:SetText(L("Entrée", "Entrance"))
            p.px, p.py, p.small = entry.x, entry.y, true
            p.onClick = nil
            self.placed[#self.placed + 1] = p
        end
        -- player
        local pm = C_Map.GetBestMapForUnit("player")
        local pp = pm == map and C_Map.GetPlayerMapPosition(map, "player")
        if pp and pp.x and pp.x > 0 then
            local p = self.markPool:Get()
            p.tex:SetTexture("Interface\\WorldMap\\WorldMapArrow")
            p.tex:SetTexCoord(0, 1, 0, 1)
            p.tex:SetRotation(GetPlayerFacing() or 0)
            p.title, p.note = UnitName("player"), nil
            p.label:SetText("")
            p.px, p.py, p.small = pp.x, pp.y, true
            p.onClick = nil
            self.placed[#self.placed + 1] = p
        end
        if unknown > 0 then
            self.hint:SetText(("|cffaaaaaa%d %s|r   %s"):format(unknown,
                L("boss sans position (appris en les ciblant de près)", "boss(es) without position (learned by targeting them up close)"),
                L("Molette : zoom", "Wheel: zoom")))
        end
        self:Place()
    end
    return v
end

----------------------------------------------------------------------
-- Journal tab
----------------------------------------------------------------------
local P = {}
function P:Build(f)
    self.view = JM.CreateView(f, function(index) J:ShowTab("bosses", index) end)
    self.view:SetAllPoints()
    self.view.onRightClick = function() J:Back() end
end
function P:Show(d, arg)
    local view = self.view
    view.focus = nil
    local floor
    if type(arg) == "table" and arg.boss then
        view.focus = arg.boss
        for _, e in ipairs(ns.JournalBosses.Entries(d)) do
            if e.index == arg.boss then
                local pos = JM.BossPosition(d, e.boss)
                if pos then
                    for i, m in ipairs(JM.Maps(d)) do if m == pos.map then floor = i end end
                end
            end
        end
    end
    -- inside: the floor the player is on
    if not floor and ns.InstanceDungeon() == d.key then
        local pm = C_Map.GetBestMapForUnit("player")
        for i, m in ipairs(JM.Maps(d)) do if m == pm then floor = i end end
    end
    view:SetDungeon(d, floor or 1)
end
function P:Refresh() self.view:Refresh() end
function P:Layout() self.view:Place() end

J:AddPage("map", P)
