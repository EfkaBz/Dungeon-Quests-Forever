local _, ns = ...
local L = ns.L
local A = {}
ns.Arrow = A
ns:RegisterModule(A)

local ARRIVED_YARDS = 6

-- Forever redrew some zones (Hillsbrad Foothills with Alterac...): new
-- uiMapID, same coordinates, but the Classic map ID still converts to the
-- old world placement. A point given on a map is therefore read on the
-- zone map of the same name (the one the player is in / is looking at).
local zoneInfo = {}
local function Info(id)
    if not id then return end
    if zoneInfo[id] == nil then zoneInfo[id] = C_Map.GetMapInfo(id) or false end
    return zoneInfo[id] or nil
end
function ns.SameZone(a, b)
    if not a or not b then return false end
    if a == b then return true end
    local ia, ib = Info(a), Info(b)
    return ia and ib and ia.name == ib.name and ia.mapType == ib.mapType or false
end

-- map to use for a point of mapID: the player's current zone map when it is
-- the same zone under another ID
local function LiveMap(mapID)
    local m = C_Map.GetBestMapForUnit("player")
    if m and m ~= mapID and ns.SameZone(mapID, m) then return m end
    return mapID
end

-- World position (continent, x, y) of a map point; x = north, y = west
function ns.WorldPos(mapID, x, y)
    mapID = LiveMap(mapID)
    local cont, pos = C_Map.GetWorldPosFromMapPos(mapID, CreateVector2D(x, y))
    if cont and pos then return cont, pos.x, pos.y end
end

function ns.PlayerWorldPos()
    local m = C_Map.GetBestMapForUnit("player")
    local p = m and C_Map.GetPlayerMapPosition(m, "player")
    if p then return ns.WorldPos(m, p.x, p.y) end
end

function A:Init()
    local f = CreateFrame("Frame", "DQF_Arrow", UIParent)
    f:SetSize(56, 70)
    f:SetMovable(true); f:EnableMouse(true); f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(s) if not DQF_DB.locked then s:StartMoving() end end)
    f:SetScript("OnDragStop", function(s)
        s:StopMovingOrSizing()
        local p, _, rp, x, y = s:GetPoint()
        DQF_DB.arrowPos = { p, rp, x, y }
    end)
    f:SetScript("OnMouseUp", function(_, btn) if btn == "RightButton" then A:Toggle(false) end end)

    f.tex = f:CreateTexture(nil, "ARTWORK")
    f.tex:SetSize(48, 48)
    f.tex:SetPoint("TOP")
    f.tex:SetTexture("Interface\\Minimap\\MinimapArrow")

    f.title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    f.title:SetPoint("TOP", f.tex, "BOTTOM", 0, 2)
    f.title:SetWidth(200); f.title:SetWordWrap(false)
    f.dist = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    f.dist:SetPoint("TOP", f.title, "BOTTOM", 0, -1)

    f.elapsed = 0
    f:SetScript("OnUpdate", function(s, e)
        s.elapsed = s.elapsed + e
        if s.elapsed < 0.05 then return end
        s.elapsed = 0
        A:Tick()
    end)
    self.frame = f
    self:RestorePosition()
    f:SetShown(DQF_DB.arrowShown)
end

function A:RestorePosition()
    local f = self.frame; f:ClearAllPoints()
    local p = DQF_DB.arrowPos
    if p then f:SetPoint(p[1], UIParent, p[2], p[3], p[4]) else f:SetPoint("TOP", UIParent, "TOP", 0, -140) end
end

function A:Toggle(show)
    if show == nil then show = not self.frame:IsShown() end
    DQF_DB.arrowShown = show
    self.frame:SetShown(show)
end

function A:OnUpdate(st)
    local s = st.step
    self.mapID, self.x, self.y, self.label = nil, nil, nil, nil
    if not s then return end
    local spots = ns.StepSpots(s, st.dungeon)
    self.spots = spots
    if #spots == 0 then return end
    local first = spots[1]
    self.mapID, self.x, self.y = first.map, first.x / 100, first.y / 100
    if first.entrance then
        self.label = L("Entrée : ", "Entrance: ") .. st.dungeon.name
    elseif s.npcKey then
        self.label = ns.NPCName(ns.StepNPC(s))
    else
        self.label = s.text
    end
end

function A:Tick()
    local f = self.frame
    local inInstance = IsInInstance()
    -- an active route to a dungeon wins over the current step
    local rMap, rx, ry, rLabel
    if ns.Route then rMap, rx, ry, rLabel = ns.Route:ArrowTarget() end
    if not (self.mapID or rMap) or inInstance then
        f.tex:SetAlpha(0)
        f.title:SetText(inInstance and L("Dans le donjon", "In dungeon") or "")
        f.dist:SetText("")
        return
    end
    f.title:SetText((rMap and rLabel) or self.label or "")

    local pc, px, py = ns.PlayerWorldPos()
    if rMap then
        self:Point(pc, px, py, rMap, rx, ry)
        return
    end
    -- several places for the step: point to the closest one
    if pc and self.spots and #self.spots > 1 then
        local best
        for _, sp in ipairs(self.spots) do
            local c, wx, wy = ns.WorldPos(sp.map, sp.x / 100, sp.y / 100)
            if c == pc then
                local d = (wx - px) ^ 2 + (wy - py) ^ 2
                if not best or d < best then best, self.mapID, self.x, self.y = d, sp.map, sp.x / 100, sp.y / 100 end
            end
        end
    end
    self:Point(pc, px, py, self.mapID, self.x, self.y)
end

-- Turns the arrow from the player (world position) toward a map point (0-1)
function A:Point(pc, px, py, mapID, x, y)
    local f = self.frame
    local tc, tx, ty = ns.WorldPos(mapID, x, y)
    local facing = GetPlayerFacing()
    if not (tc and pc and facing) or tc ~= pc then
        -- other continent / unknown position: no direction
        f.tex:SetAlpha(0.3); f.tex:SetRotation(0); f.tex:SetVertexColor(1, 1, 1)
        f.dist:SetText(ns.ZoneName(mapID))
        return
    end

    local dx, dy = tx - px, ty - py
    local dist = math.sqrt(dx * dx + dy * dy)
    f.tex:SetAlpha(1)
    if dist < ARRIVED_YARDS then
        f.tex:SetRotation(0); f.tex:SetVertexColor(0.3, 1, 0.3)
        f.dist:SetText(L("Arrivé !", "Arrived!"))
        return
    end
    f.tex:SetRotation(math.atan2(dy, dx) - facing)
    -- yellow far away, greener when close
    local g = math.max(0, math.min(1, 1 - dist / 300))
    f.tex:SetVertexColor(1 - g * 0.7, 0.82 + g * 0.18, g * 0.3)
    f.dist:SetText(string.format(L("%d mètres", "%d yards"), dist))
end
