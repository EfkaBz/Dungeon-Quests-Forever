local _, ns = ...
local Pins = {}
ns.Pins = Pins
ns:RegisterModule(Pins)

-- Minimap diameter in yards per zoom level
local MINIMAP_SIZE = {
    outdoor = { 466.6667, 400, 333.3333, 266.6667, 200, 133.3333 },
    indoor  = { 300, 240, 180, 120, 80, 50 },
}

-- Only the current step is pinned (world map and minimap), with one pin
-- per place where it can be done (e.g. two mob camps)
local function BuildTargets(st)
    local s = st.step
    if not s then return {} end
    local out = {}
    for _, p in ipairs(ns.StepSpots(s, st.dungeon)) do
        out[#out + 1] = { map = p.map, x = p.x / 100, y = p.y / 100, step = s, label = tostring(s.pos), current = true }
    end
    return out
end

local function CreatePin(parent)
    local p = CreateFrame("Button", nil, parent)
    p.bg = p:CreateTexture(nil, "ARTWORK")
    p.bg:SetAllPoints()
    p.bg:SetTexture("Interface\\COMMON\\Indicator-Yellow")
    p.text = p:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    p.text:SetPoint("BOTTOM", p, "TOP", 0, -2)
    p:SetScript("OnEnter", function(self) if self.step then ns.StepTooltip(self, self.step) end end)
    p:SetScript("OnLeave", GameTooltip_Hide)
    return p
end

local function StylePin(p, t)
    p.step = t.step
    p.text:SetText(t.label)
    p.bg:SetTexture(t.current and "Interface\\COMMON\\Indicator-Yellow" or "Interface\\COMMON\\Indicator-Gray")
end

----------------------------------------------------------------------
-- World map
----------------------------------------------------------------------
local worldPins, worldLines = {}, {}

-- Convert a point of mapID into the coordinates of dispMap (or nil)
local function ToMap(mapID, x, y, dispMap)
    if mapID == dispMap then return x, y end
    local cont, world = C_Map.GetWorldPosFromMapPos(mapID, CreateVector2D(x, y))
    if not cont then return end
    local _, pos = C_Map.GetMapPosFromWorldPos(cont, world, dispMap)
    if pos and pos.x >= 0 and pos.x <= 1 and pos.y >= 0 and pos.y <= 1 then return pos.x, pos.y end
end

function Pins:UpdateWorld()
    for _, p in ipairs(worldPins) do p:Hide() end
    for _, l in ipairs(worldLines) do l:Hide() end
    if not (WorldMapFrame and WorldMapFrame:IsShown() and DQF_DB.mapPins and ns.state) then return end
    local canvas = WorldMapFrame:GetCanvas()
    local dispMap = WorldMapFrame:GetMapID()
    if not (canvas and dispMap) then return end
    local w, h = canvas:GetSize()
    local size = math.max(12, w / 70)

    for i, t in ipairs(BuildTargets(ns.state)) do
        local x, y = ToMap(t.map, t.x, t.y, dispMap)
        if x then
            local p = worldPins[i] or CreatePin(canvas)
            worldPins[i] = p
            p:SetSize(size, size)
            p:SetFrameStrata("HIGH")
            p:ClearAllPoints()
            p:SetPoint("CENTER", canvas, "TOPLEFT", x * w, -y * h)
            StylePin(p, t)
            p:Show()
        end
    end
end

----------------------------------------------------------------------
-- Minimap
----------------------------------------------------------------------
local miniPins, miniTargets = {}, {}

function Pins:UpdateMinimap()
    for _, p in ipairs(miniPins) do p:Hide() end
    if not DQF_DB.minimapPins or IsInInstance() then return end
    local pc, px, py = ns.PlayerWorldPos()
    if not pc then return end
    local sizes = IsIndoors() and MINIMAP_SIZE.indoor or MINIMAP_SIZE.outdoor
    local radius = (sizes[(Minimap:GetZoom() or 0) + 1] or 466) / 2
    local scale = (Minimap:GetWidth() / 2) / radius
    local facing = GetCVar("rotateMinimap") == "1" and GetPlayerFacing() or 0
    local cosf, sinf = math.cos(facing or 0), math.sin(facing or 0)

    for i, t in ipairs(miniTargets) do
        local tc, tx, ty = ns.WorldPos(t.map, t.x, t.y)
        if tc == pc then
            -- screen vector (east, north) in yards, rotated with the minimap
            local ex, ny = -(ty - py), tx - px
            local rx, ry = ex * cosf + ny * sinf, -ex * sinf + ny * cosf
            local dist = math.sqrt(rx * rx + ry * ry)
            local edge = dist > radius * 0.92
            if edge then rx, ry = rx / dist * radius * 0.92, ry / dist * radius * 0.92 end
            local p = miniPins[i] or CreatePin(Minimap)
            miniPins[i] = p
            p:SetSize(12, 12)
            p:SetFrameLevel(Minimap:GetFrameLevel() + 5)
            p:ClearAllPoints()
            p:SetPoint("CENTER", Minimap, "CENTER", rx * scale, ry * scale)
            StylePin(p, t)
            p:SetAlpha(edge and 0.6 or 1)
            p:Show()
        end
    end
end

function Pins:Init()
    if WorldMapFrame then
        WorldMapFrame:HookScript("OnShow", function() Pins:UpdateWorld() end)
        if WorldMapFrame.OnMapChanged then
            hooksecurefunc(WorldMapFrame, "OnMapChanged", function() Pins:UpdateWorld() end)
        end
    end
    local ticker = CreateFrame("Frame")
    ticker.elapsed = 0
    ticker:SetScript("OnUpdate", function(s, e)
        s.elapsed = s.elapsed + e
        if s.elapsed < 0.1 then return end
        s.elapsed = 0
        Pins:UpdateMinimap()
    end)
end

function Pins:OnUpdate(st)
    miniTargets = BuildTargets(st)
    self:UpdateWorld()
end
