local _, ns = ...
local L = ns.L
local M = {}
ns.Minimap = M
ns:RegisterModule(M)

local OFFSET = 10 -- from the edge of the map (the default map is 140 wide)

-- On the edge of the map, whatever its size and shape (other addons change them)
local function Place(b)
    local a = math.rad(DQF_DB.minimapAngle)
    local x, y = math.cos(a), math.sin(a)
    local w, h = Minimap:GetWidth() / 2 + OFFSET, Minimap:GetHeight() / 2 + OFFSET
    if GetMinimapShape and GetMinimapShape() == "SQUARE" then
        x = math.max(-w, math.min(x * (math.sqrt(2 * w ^ 2) - OFFSET), w))
        y = math.max(-h, math.min(y * (math.sqrt(2 * h ^ 2) - OFFSET), h))
    else
        x, y = x * w, y * h
    end
    b:ClearAllPoints()
    b:SetPoint("CENTER", Minimap, "CENTER", x, y)
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
        if IsControlKeyDown() then ns.Options:Toggle()
        elseif btn == "RightButton" then ns.Journal:Toggle()
        else
            -- the small window and the guide arrow are shown/hidden together
            -- (the window holds secure buttons: not possible in combat)
            if InCombatLockdown() then ns.UI:Toggle() return end
            local show = not ns.UI.frame:IsShown()
            ns.UI:Toggle(show)
            ns.Arrow:Toggle(show)
            if ns.Options.Refresh then ns.Options.Refresh() end
        end
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
        GameTooltip:AddLine(L("Clic gauche : afficher/cacher la fenêtre et la flèche", "Left-click: show/hide the window and the arrow"), 1, 1, 1)
        GameTooltip:AddLine(L("Clic droit : Dungeon Home", "Right-click: Dungeon Home"), 1, 1, 1)
        GameTooltip:AddLine(L("Ctrl + clic : options", "Ctrl-click: options"), 1, 1, 1)
        GameTooltip:AddLine(L("Glisser : déplacer", "Drag: move"), 0.6, 0.6, 0.6)
        GameTooltip:Show()
    end)
    b:SetScript("OnLeave", GameTooltip_Hide)
    Place(b)
    Minimap:HookScript("OnSizeChanged", function() Place(b) end)
    C_Timer.After(2, function() Place(b) end) -- addons may set the map shape after login
    self.button = b
    self:ApplySettings()
end

function M:ApplySettings()
    self.button:SetShown(DQF_DB.minimapShown)
end
