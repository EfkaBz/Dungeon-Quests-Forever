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

-- Objective marker: gold ring on a dark disc (colors of the addon icon)
-- with the step number inside, a soft glow that breathes and a ring that
-- pulses outwards. Textures: Media\Pins (generated).
local MEDIA = "Interface\\AddOns\\Dungeon_Quests_Forever\\Media\\Pins\\"
local GOLD = { 1, 0.78, 0.2 }

local function Loop(region, build)
    local g = region:CreateAnimationGroup()
    g:SetLooping("REPEAT")
    build(g)
    g:Play()
    return g
end

local function CreatePin(parent)
    local p = CreateFrame("Button", nil, parent)
    p.glow = p:CreateTexture(nil, "BACKGROUND")
    p.glow:SetPoint("CENTER"); p.glow:SetTexture(MEDIA .. "glow")
    p.glow:SetBlendMode("ADD")
    p.ring = p:CreateTexture(nil, "BORDER")
    p.ring:SetPoint("CENTER"); p.ring:SetTexture(MEDIA .. "ring")
    p.ring:SetBlendMode("ADD")
    p.bg = p:CreateTexture(nil, "ARTWORK")
    p.bg:SetAllPoints(); p.bg:SetTexture(MEDIA .. "pin")
    p.text = p:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    p.text:SetPoint("CENTER", 0, 0)
    p.text:SetShadowOffset(1, -1)
    -- glow: slow breathing
    Loop(p.glow, function(g)
        local a = g:CreateAnimation("Alpha"); a:SetFromAlpha(0.35); a:SetToAlpha(0.8)
        a:SetDuration(1.1); a:SetSmoothing("IN_OUT"); a:SetOrder(1)
        local b = g:CreateAnimation("Alpha"); b:SetFromAlpha(0.8); b:SetToAlpha(0.35)
        b:SetDuration(1.1); b:SetSmoothing("IN_OUT"); b:SetOrder(2)
    end)
    -- ring: grows and fades out
    Loop(p.ring, function(g)
        local sc = g:CreateAnimation("Scale")
        if sc.SetScaleFrom then sc:SetScaleFrom(0.6, 0.6); sc:SetScaleTo(1.6, 1.6)
        else sc:SetScale(2.6, 2.6) end
        sc:SetDuration(1.6); sc:SetSmoothing("OUT")
        local a = g:CreateAnimation("Alpha"); a:SetFromAlpha(0.9); a:SetToAlpha(0)
        a:SetDuration(1.6); a:SetSmoothing("IN")
    end)
    -- hover: slightly bigger
    p:SetScript("OnEnter", function(self)
        self.bg:SetPoint("TOPLEFT", -2, 2); self.bg:SetPoint("BOTTOMRIGHT", 2, -2)
        if self.step then ns.StepTooltip(self, self.step) end
    end)
    p:SetScript("OnLeave", function(self)
        self.bg:SetAllPoints()
        GameTooltip_Hide()
    end)
    return p
end

local function StylePin(p, t, size)
    p.step = t.step
    p:SetSize(size, size)
    p.glow:SetSize(size * 2.4, size * 2.4)
    p.ring:SetSize(size * 1.5, size * 1.5)
    p.text:SetText(t.label)
    local font, _, flags = p.text:GetFont()
    if font then p.text:SetFont(font, math.max(8, math.floor(size * 0.42)), flags) end
    if t.current then
        p.glow:SetVertexColor(unpack(GOLD)); p.ring:SetVertexColor(unpack(GOLD))
        p.bg:SetDesaturated(false); p.text:SetTextColor(1, 0.86, 0.35)
        p.glow:Show(); p.ring:Show()
    else
        p.bg:SetDesaturated(true); p.text:SetTextColor(0.75, 0.75, 0.75)
        p.glow:Hide(); p.ring:Hide()
    end
end

----------------------------------------------------------------------
-- Size of the world map pins: follows the zoom of the map
----------------------------------------------------------------------
-- A frame on the canvas is drawn at (its size x canvas scale), and the canvas
-- size depends on the map addon (OpenMap's is far larger than Blizzard's):
-- sizes are fixed, and the pin scale cancels most of the canvas scale. The pin
-- grows a little when zooming in and stays within these limits on screen.
local ZOOM_POWER, ZOOM_MIN, ZOOM_MAX = 0.35, 0.8, 1.5

-- size on screen for a pin of size 1 at this zoom
function ns.MapZoomFactor()
    local s = WorldMapFrame and WorldMapFrame.GetCanvasScale and WorldMapFrame:GetCanvasScale() or 1
    if not s or s <= 0 then return 1, 1 end
    return math.min(ZOOM_MAX, math.max(ZOOM_MIN, s ^ ZOOM_POWER)), s
end

local placed = setmetatable({}, { __mode = "k" }) -- pins on the canvas, redone at each zoom step
local zoomListeners = {}

local function ApplyPlace(p)
    local apparent, canvasScale = ns.MapZoomFactor()
    local k = apparent / canvasScale
    p:SetScale(k)
    p:ClearAllPoints()
    -- anchor offsets are in the pin's own scale
    p:SetPoint("CENTER", p.mapCanvas, "TOPLEFT", p.mapX / k, -p.mapY / k)
end

-- Puts a pin on the canvas: x, y in canvas units from its top left corner
function ns.PlaceOnCanvas(p, canvas, x, y)
    p.mapCanvas, p.mapX, p.mapY = canvas, x, y
    placed[p] = true
    ApplyPlace(p)
end

-- fn() is called at each zoom step of the world map
function ns.OnMapZoom(fn) zoomListeners[#zoomListeners + 1] = fn end

local function OnZoom()
    for p in pairs(placed) do
        if p:IsShown() then ApplyPlace(p) end
    end
    for _, fn in ipairs(zoomListeners) do fn() end
end

----------------------------------------------------------------------
-- World map
----------------------------------------------------------------------
local worldPins, worldLines = {}, {}
local WORLD_PIN_SIZE = 24

-- Convert a point of mapID into the coordinates of dispMap (or nil)
local function ToMap(mapID, x, y, dispMap)
    if mapID == dispMap or ns.SameZone(mapID, dispMap) then return x, y end
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

    for i, t in ipairs(BuildTargets(ns.state)) do
        local x, y = ToMap(t.map, t.x, t.y, dispMap)
        if x then
            local p = worldPins[i] or CreatePin(canvas)
            worldPins[i] = p
            p:SetFrameStrata("HIGH")
            ns.PlaceOnCanvas(p, canvas, x * w, y * h)
            StylePin(p, t, WORLD_PIN_SIZE)
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
            p:SetFrameLevel(Minimap:GetFrameLevel() + 5)
            p:ClearAllPoints()
            p:SetPoint("CENTER", Minimap, "CENTER", rx * scale, ry * scale)
            StylePin(p, t, 18)
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
        if WorldMapFrame.OnCanvasScaleChanged then
            hooksecurefunc(WorldMapFrame, "OnCanvasScaleChanged", OnZoom)
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
