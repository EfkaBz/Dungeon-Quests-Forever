local _, ns = ...
local L = ns.L
local M = {}
ns.Minimap = M
ns:RegisterModule(M)

local RADIUS = 80

local function Place(b)
    local a = math.rad(DQF_DB.minimapAngle)
    b:ClearAllPoints()
    b:SetPoint("CENTER", Minimap, "CENTER", math.cos(a) * RADIUS, math.sin(a) * RADIUS)
end

function M:Init()
    local b = CreateFrame("Button", "DQF_MinimapButton", Minimap)
    b:SetSize(31, 31)
    b:SetFrameStrata("MEDIUM"); b:SetFrameLevel(8)
    b:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    b:RegisterForDrag("LeftButton")
    b:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    local icon = b:CreateTexture(nil, "BACKGROUND")
    icon:SetSize(20, 20); icon:SetPoint("TOPLEFT", 7, -5)
    icon:SetTexture("Interface\\AddOns\\Dungeon_Quests_Forever\\Media\\icon_small")
    local border = b:CreateTexture(nil, "OVERLAY")
    border:SetSize(53, 53); border:SetPoint("TOPLEFT")
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

    b:SetScript("OnClick", function(_, btn)
        if IsShiftKeyDown() then ns.Options:Toggle()
        elseif btn == "RightButton" then ns.Arrow:Toggle()
        else ns.UI:Toggle() end
    end)
    b:SetScript("OnDragStart", function(s)
        s:SetScript("OnUpdate", function()
            local mx, my = Minimap:GetCenter()
            local cx, cy = GetCursorPosition()
            local scale = Minimap:GetEffectiveScale()
            DQF_DB.minimapAngle = math.deg(math.atan2(cy / scale - my, cx / scale - mx))
            Place(s)
        end)
    end)
    b:SetScript("OnDragStop", function(s) s:SetScript("OnUpdate", nil) end)
    b:SetScript("OnEnter", function(s)
        GameTooltip:SetOwner(s, "ANCHOR_LEFT")
        GameTooltip:AddLine("Dungeon Quests |cff33ff99Forever|r")
        GameTooltip:AddLine(L("Clic gauche : ouvrir/fermer", "Left-click: show/hide"), 1, 1, 1)
        GameTooltip:AddLine(L("Clic droit : flèche on/off", "Right-click: toggle arrow"), 1, 1, 1)
        GameTooltip:AddLine(L("Maj + clic : options", "Shift-click: options"), 1, 1, 1)
        GameTooltip:AddLine(L("Glisser : déplacer", "Drag: move"), 0.6, 0.6, 0.6)
        GameTooltip:Show()
    end)
    b:SetScript("OnLeave", GameTooltip_Hide)
    Place(b)
    self.button = b
    self:ApplySettings()
end

function M:ApplySettings()
    self.button:SetShown(DQF_DB.minimapShown)
end
