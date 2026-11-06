local _, ns = ...
local L = ns.L
local R = {}
ns.Route = R
ns:RegisterModule(R)

-- Route to a dungeon entrance: a list of waypoints drawn on the world map
-- and followed one after the other by the guide arrow.
--   hand-made route: d.route (Data\DungeonInfo.lua), per faction
--   automatic route : flight master closest to the entrance, then the entrance

local REACHED_YARDS = 25

local function ContinentOf(map)
    local info = C_Map.GetMapInfo(map)
    local continentType = Enum and Enum.UIMapType and Enum.UIMapType.Continent or 2
    while info and info.mapType ~= continentType and info.parentMapID and info.parentMapID > 0 do
        info = C_Map.GetMapInfo(info.parentMapID)
    end
    return info and info.mapType == continentType and info.mapID
end

local function FactionOK(node)
    local fac = node.faction
    if not fac or not Enum or not Enum.FlightPathFaction then return true end
    if fac == Enum.FlightPathFaction.Neutral then return true end
    local mine = UnitFactionGroup("player") == "Horde" and Enum.FlightPathFaction.Horde or Enum.FlightPathFaction.Alliance
    return fac == mine
end

-- Flight master closest to a point (map, x/y 0-1): node, distance (yards)
local function NearestFlight(map, x, y)
    local cont = ContinentOf(map)
    if not (cont and C_TaxiMap and C_TaxiMap.GetTaxiNodesForMap) then return end
    local ok, nodes = pcall(C_TaxiMap.GetTaxiNodesForMap, cont)
    if not ok or not nodes then return end
    local tc, tx, ty = ns.WorldPos(map, x, y)
    if not tc then return end
    local best, bestD
    for _, n in ipairs(nodes) do
        if n.position and FactionOK(n) then
            local c, wx, wy = ns.WorldPos(cont, n.position.x, n.position.y)
            if c == tc then
                local dist = math.sqrt((wx - tx) ^ 2 + (wy - ty) ^ 2)
                if not bestD or dist < bestD then best, bestD = { map = cont, x = n.position.x, y = n.position.y, name = n.name }, dist end
            end
        end
    end
    return best, bestD
end

local function Build(d)
    local faction = UnitFactionGroup("player")
    for _, r in ipairs(d.route or {}) do
        if not r.faction or r.faction == faction then
            local pts = {}
            for _, p in ipairs(r.points) do
                pts[#pts + 1] = { map = p[1] or p.map, x = (p[2] or p.x) / 100, y = (p[3] or p.y) / 100,
                    text = p[4] or p.text, flight = p.flight }
            end
            return pts
        end
    end
    local e = d.entrance
    if not e then return end
    local pts = {}
    local ex, ey = e.x / 100, e.y / 100
    local node, dist = NearestFlight(e.map, ex, ey)
    local pc, px, py = ns.PlayerWorldPos()
    local tc, tx, ty = ns.WorldPos(e.map, ex, ey)
    local playerDist = (pc and tc and pc == tc) and math.sqrt((px - tx) ^ 2 + (py - ty) ^ 2) or math.huge
    -- take the flight only if it really saves the trip
    if node and dist and dist < playerDist * 0.6 and dist > 60 then
        pts[#pts + 1] = { map = node.map, x = node.x, y = node.y, flight = true,
            text = L("Vol jusqu'à : ", "Fly to: ") .. (node.name or "?") }
    end
    pts[#pts + 1] = { map = e.map, x = ex, y = ey, entrance = true, text = L("Entrée : ", "Entrance: ") .. d.name }
    return pts
end

function R:CanRoute(d) return d and d.entrance ~= nil and (d.route ~= nil or DQF_DB.autoRoute) end
function R:IsActive(d) return self.active ~= nil and (not d or self.active.d == d) end

function R:Start(d)
    local pts = Build(d)
    if not pts or #pts == 0 then return end
    self.active = { d = d, points = pts, index = 1 }
    DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99DQF|r : " .. L("Itinéraire vers ", "Route to ") .. d.name)
    for i, p in ipairs(pts) do
        DEFAULT_CHAT_FRAME:AddMessage(("   %d. %s  |cffaaaaaa(%s)|r"):format(i, p.text, ns.ZoneName(p.map)))
    end
    if not DQF_DB.arrowShown then ns.Arrow:Toggle(true) end
    self:Draw()
end

function R:Stop()
    self.active = nil
    self:Draw()
    if ns.Journal.frame and ns.Journal.frame:IsShown() and ns.Journal.view == "dungeon" then ns.Journal:RefreshHeader() end
end

function R:Toggle(d)
    if not d then return end
    if self:IsActive(d) then self:Stop() else self:Start(d) end
end

-- Current waypoint for the arrow: map, x, y (0-1), label
function R:ArrowTarget()
    local a = self.active
    local p = a and a.points[a.index]
    if p then return p.map, p.x, p.y, ("%d/%d  %s"):format(a.index, #a.points, p.text) end
end

-- Move to the next waypoint when the current one is reached
function R:Tick()
    local a = self.active
    if not a then return end
    if IsInInstance() then self:Stop() return end
    local p = a.points[a.index]
    local pc, px, py = ns.PlayerWorldPos()
    local tc, tx, ty = ns.WorldPos(p.map, p.x, p.y)
    if pc and tc and pc == tc and math.sqrt((px - tx) ^ 2 + (py - ty) ^ 2) < REACHED_YARDS then
        a.index = a.index + 1
        PlaySound(SOUNDKIT and SOUNDKIT.MAP_PING or 3175)
        if a.index > #a.points then
            UIErrorsFrame:AddMessage(L("Entrée du donjon atteinte !", "Dungeon entrance reached!"), 0.3, 1, 0.3)
            self:Stop()
        else
            UIErrorsFrame:AddMessage(a.points[a.index].text, 1, 0.82, 0)
            self:Draw()
        end
    end
end

----------------------------------------------------------------------
-- World map drawing: lines between the waypoints + numbered dots
----------------------------------------------------------------------
local lines, dots = {}, {}

-- line width on the canvas for a width of 3 on screen at this zoom
local function LineWidth()
    local apparent, canvasScale = ns.MapZoomFactor()
    return 3 * apparent / canvasScale
end

function R:Draw()
    for _, l in ipairs(lines) do l:Hide() end
    for _, d in ipairs(dots) do d:Hide() end
    local a = self.active
    if not (a and WorldMapFrame and WorldMapFrame:IsShown()) then return end
    local canvas = WorldMapFrame:GetCanvas()
    local dispMap = WorldMapFrame:GetMapID()
    if not (canvas and dispMap) then return end
    local w, h = canvas:GetSize()
    local ToMap = ns.EntrancePins.ToMap
    local prev
    -- start from the player when visible on this map
    local pm = C_Map.GetBestMapForUnit("player")
    local pp = pm and C_Map.GetPlayerMapPosition(pm, "player")
    if pp and pp.x and pp.x > 0 then
        local x, y = ToMap(pm, pp.x, pp.y, dispMap)
        if x then prev = { x, y } end
    end
    local r, g, b = unpack(ns.Theme().accent)
    for i = a.index, #a.points do
        local p = a.points[i]
        local x, y = ToMap(p.map, p.x, p.y, dispMap)
        if x then
            if prev and canvas.CreateLine then
                local l = lines[i] or canvas:CreateLine(nil, "OVERLAY")
                lines[i] = l
                l:SetThickness(LineWidth())
                l:SetColorTexture(r, g, b, 0.85)
                l:SetStartPoint("TOPLEFT", canvas, prev[1] * w, -prev[2] * h)
                l:SetEndPoint("TOPLEFT", canvas, x * w, -y * h)
                l:Show()
            end
            local dot = dots[i]
            if not dot then
                dot = CreateFrame("Frame", nil, canvas)
                dot.tex = dot:CreateTexture(nil, "ARTWORK")
                dot.tex:SetAllPoints()
                dot.tex:SetTexture("Interface\\COMMON\\Indicator-Yellow")
                dot.num = dot:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
                dot.num:SetPoint("BOTTOM", dot, "TOP", 0, 0)
                dots[i] = dot
            end
            dot:SetParent(canvas)
            dot:SetFrameStrata("HIGH")
            dot:SetSize(14, 14)
            ns.PlaceOnCanvas(dot, canvas, x * w, y * h)
            dot.num:SetText(("%d. %s"):format(i, p.text))
            dot:Show()
            prev = { x, y }
        end
    end
end

function R:Init()
    ns.OnMapZoom(function()
        local width = LineWidth()
        for _, l in pairs(lines) do l:SetThickness(width) end
    end)
    if WorldMapFrame then
        WorldMapFrame:HookScript("OnShow", function() R:Draw() end)
        if WorldMapFrame.OnMapChanged then hooksecurefunc(WorldMapFrame, "OnMapChanged", function() R:Draw() end) end
    end
    local t = CreateFrame("Frame")
    t.e = 0
    t:SetScript("OnUpdate", function(s, e)
        s.e = s.e + e
        if s.e < 0.5 then return end
        s.e = 0
        R:Tick()
    end)
end
