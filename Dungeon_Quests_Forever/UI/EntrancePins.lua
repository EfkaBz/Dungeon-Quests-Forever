local _, ns = ...
local L = ns.L
local E = {}
ns.EntrancePins = E
ns:RegisterModule(E)

-- World map markers:
--  - dungeon entrances (all of them with the "always show" option)
--  - one focused point (pulsing): "Show entrance" / "Show on map" buttons
--    of the journal. Right-click removes it.

-- Convert a point of mapID (0-1) into the coordinates of dispMap (or nil)
local function ToMap(mapID, x, y, dispMap)
    if mapID == dispMap or ns.SameZone(mapID, dispMap) then return x, y end
    local cont, world = C_Map.GetWorldPosFromMapPos(mapID, CreateVector2D(x, y))
    if not cont then return end
    local _, pos = C_Map.GetMapPosFromWorldPos(cont, world, dispMap)
    if pos and pos.x >= 0 and pos.x <= 1 and pos.y >= 0 and pos.y <= 1 then return pos.x, pos.y end
end
E.ToMap = ToMap

local pins, used = {}, 0

local function SetDungeonIcon(tex)
    if tex.SetAtlas and pcall(tex.SetAtlas, tex, "Dungeon") then return end
    tex:SetTexture("Interface\\Icons\\Spell_Arcane_TeleportStormwind")
    tex:SetTexCoord(0.08, 0.92, 0.08, 0.92)
end

local function GetPin(canvas)
    used = used + 1
    local p = pins[used]
    if not p then
        p = CreateFrame("Button", nil, canvas)
        p.tex = p:CreateTexture(nil, "ARTWORK")
        p.tex:SetAllPoints()
        p.glow = p:CreateTexture(nil, "BACKGROUND")
        p.glow:SetPoint("CENTER")
        p.glow:SetTexture("Interface\\Cooldown\\star4")
        p.glow:SetBlendMode("ADD")
        p.label = p:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        p.label:SetPoint("TOP", p, "BOTTOM", 0, -1)
        p:RegisterForClicks("LeftButtonUp", "RightButtonUp")
        p:SetScript("OnEnter", function(s)
            GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
            GameTooltip:AddLine(s.title or "", 1, 0.82, 0)
            for _, line in ipairs(s.lines or {}) do GameTooltip:AddLine(line, 1, 1, 1, true) end
            GameTooltip:Show()
        end)
        p:SetScript("OnLeave", GameTooltip_Hide)
        p:SetScript("OnClick", function(s, btn)
            if btn == "RightButton" then
                if s.isFocus then E.focus = nil; E:Refresh() end
                return
            end
            if s.dungeon then ns.Journal:Open(s.dungeon) end
        end)
        pins[used] = p
    end
    p:SetParent(canvas)
    p:SetFrameStrata("HIGH")
    p:Show()
    return p
end

function E:Refresh()
    for i = 1, #pins do pins[i]:Hide(); pins[i]:SetScript("OnUpdate", nil) end
    used = 0
    if not (WorldMapFrame and WorldMapFrame:IsShown()) then return end
    local canvas = WorldMapFrame:GetCanvas()
    local dispMap = WorldMapFrame:GetMapID()
    if not (canvas and dispMap) then return end
    local w, h = canvas:GetSize()
    local size = 18

    local function Place(p, mx, my, s)
        p:SetSize(s, s)
        ns.PlaceOnCanvas(p, canvas, mx * w, my * h)
    end

    -- all entrances
    if DQF_DB.entrancePins then
        local done = {}
        for _, key in ipairs(ns.dungeonOrder) do
            local d = ns.dungeons[key]
            local e = d.entrance
            if e and not d.overworld then
                local x, y = ToMap(e.map, e.x / 100, e.y / 100, dispMap)
                local spot = x and ("%.3f:%.3f"):format(x, y)
                if x then
                    local p = GetPin(canvas)
                    SetDungeonIcon(p.tex)
                    p.glow:Hide()
                    p.isFocus, p.dungeon = false, key
                    p.title = d.name
                    p.lines = { L("Niveaux ", "Levels ") .. d.levels, L("Clic : ouvrir Dungeon Home", "Click: open Dungeon Home") }
                    -- several dungeons at the same entrance: list them in the tooltip of the first one
                    if done[spot] then
                        local first = done[spot]
                        table.insert(first.lines, 1, d.name .. "  (" .. d.levels .. ")")
                        p:Hide()
                    else
                        done[spot] = p
                        p.label:SetText("")
                        Place(p, x, y, size)
                    end
                end
            end
        end
    end

    -- focused point
    local f = self.focus
    if f then
        local x, y = ToMap(f.map, f.x, f.y, dispMap)
        if x then
            local p = GetPin(canvas)
            if f.dungeon then SetDungeonIcon(p.tex) else
                p.tex:SetTexture("Interface\\Minimap\\ObjectIcons")
                p.tex:SetTexCoord(0.125, 0.25, 0.125, 0.25)
                if p.tex.SetAtlas then pcall(p.tex.SetAtlas, p.tex, "QuestNormal") end
            end
            p.isFocus, p.dungeon = true, f.dungeon
            p.title = f.label
            p.lines = { f.detail, L("Clic droit : retirer", "Right-click: remove") }
            p.label:SetText("|cffffff00" .. (f.label or "") .. "|r")
            p:SetFrameLevel(canvas:GetFrameLevel() + 20)
            Place(p, x, y, size * 1.3)
            p.glow:Show()
            local t = 0
            p:SetScript("OnUpdate", function(s, e)
                t = t + e
                local k = 0.5 + 0.5 * math.sin(t * 3)
                s.glow:SetSize(size * (2.2 + k), size * (2.2 + k))
                s.glow:SetAlpha(0.35 + 0.4 * k)
            end)
        end
    end
end

-- Opens the world map on a map ID (retries: the map frame needs a moment)
local function OpenMap(mapID)
    if not WorldMapFrame:IsShown() then
        if OpenWorldMap then pcall(OpenWorldMap, mapID)
        elseif ToggleWorldMap then ToggleWorldMap() end
    end
    for _, delay in ipairs({ 0, 0.1, 0.3 }) do
        C_Timer.After(delay, function()
            if WorldMapFrame:IsShown() and WorldMapFrame:GetMapID() ~= mapID then pcall(WorldMapFrame.SetMapID, WorldMapFrame, mapID) end
            E:Refresh()
        end)
    end
end

-- Focus a point (x/y in 0-100) and open the map there
function E:ShowPoint(map, x, y, label, detail, npc)
    self.focus = { map = map, x = x / 100, y = y / 100, label = label, detail = detail }
    OpenMap(map)
end

function E:ShowEntrance(d)
    local e = d and d.entrance
    if not e then return end
    self.focus = { map = e.map, x = e.x / 100, y = e.y / 100, dungeon = d.key,
        label = L("Entrée : ", "Entrance: ") .. d.name, detail = ns.ZoneName(e.map) .. (" (%.1f, %.1f)"):format(e.x, e.y) }
    OpenMap(e.map)
end

function E:Init()
    if not WorldMapFrame then return end
    WorldMapFrame:HookScript("OnShow", function() E:Refresh() end)
    if WorldMapFrame.OnMapChanged then
        hooksecurefunc(WorldMapFrame, "OnMapChanged", function() E:Refresh() end)
    end
end
