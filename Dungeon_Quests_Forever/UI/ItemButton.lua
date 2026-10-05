local _, ns = ...
local L = ns.L
local I = {}
ns.ItemButton = I
ns:RegisterModule(I)

-- Shows a clickable quest item when the current step has `item = itemID`
local pending

function I:Init()
    -- container (movable) + tab, same style as the other windows
    -- docked under the main window (right half); follows its size, scale and alpha
    local f = CreateFrame("Frame", "DQF_ItemFrame", DQF_Frame)
    f:SetHeight(70)

    f.body = ns.Panel(f)
    f.body:SetPoint("TOPLEFT"); f.body:SetPoint("BOTTOMRIGHT")
    -- small caps title strip inside the panel (same look as the main window header)
    f.head = f.body:CreateTexture(nil, "BACKGROUND", nil, 1)
    f.head:SetPoint("TOPLEFT", 1, -1); f.head:SetPoint("TOPRIGHT", -1, -1); f.head:SetHeight(18)
    f.stripe = f.body:CreateTexture(nil, "ARTWORK")
    f.stripe:SetPoint("TOPLEFT", 1, -1); f.stripe:SetSize(3, 18)
    f.title = f.body:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    f.title:SetPoint("LEFT", f.head, "LEFT", 10, 0)
    f.title:SetText(L("OBJET DE QUÊTE", "QUEST ITEM"))
    function f.ApplyTheme()
        local t = ns.Theme()
        f.head:SetColorTexture(t.bar[1], t.bar[2], t.bar[3], 0.9)
        f.stripe:SetColorTexture(t.accent[1], t.accent[2], t.accent[3], 1)
    end
    f.ApplyTheme()

    -- the secure button covers the whole body: click anywhere to use the item
    local b = CreateFrame("Button", "DQF_ItemButton", f.body, "SecureActionButtonTemplate")
    b:SetPoint("TOPLEFT", 4, -21); b:SetPoint("BOTTOMRIGHT", -4, 4)
    -- secure buttons fire on key-down or key-up depending on the
    -- ActionButtonUseKeyDown CVar: register both so the click always works
    b:RegisterForClicks("AnyUp", "AnyDown")
    b:SetAttribute("type", "item")
    b:SetHighlightTexture("Interface\\Buttons\\WHITE8X8")
    b:GetHighlightTexture():SetVertexColor(1, 1, 1, 0.06)

    b.iconBg = ns.Panel(b, "bg", nil, true)
    b.iconBg:SetSize(38, 38); b.iconBg:SetPoint("LEFT", 4, 0)
    b.iconBg:SetBackdropColor(0, 0, 0, 0.7)
    b.icon = b.iconBg:CreateTexture(nil, "ARTWORK")
    b.icon:SetPoint("TOPLEFT", 1, -1); b.icon:SetPoint("BOTTOMRIGHT", -1, 1)
    b.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    b.count = b.iconBg:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
    b.count:SetPoint("BOTTOMRIGHT", -2, 2)
    b.cd = CreateFrame("Cooldown", nil, b.iconBg, "CooldownFrameTemplate")
    b.cd:SetPoint("TOPLEFT", 1, -1); b.cd:SetPoint("BOTTOMRIGHT", -1, 1)

    b.name = b:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    b.name:SetPoint("TOPLEFT", b.iconBg, "TOPRIGHT", 8, -4)
    b.name:SetPoint("RIGHT", -6, 0)
    b.name:SetJustifyH("LEFT"); b.name:SetWordWrap(false)
    b.hint = b:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    b.hint:SetPoint("TOPLEFT", b.name, "BOTTOMLEFT", 0, -4)
    b.hint:SetText(L("Clic pour utiliser", "Click to use"))

    b:SetScript("OnEnter", function(s)
        if not s.itemID then return end
        GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
        GameTooltip:SetItemByID(s.itemID)
        GameTooltip:Show()
    end)
    b:SetScript("OnLeave", GameTooltip_Hide)

    f:Hide()
    self.frame, self.button = f, b
    self:RestorePosition()

    ns:On("PLAYER_REGEN_ENABLED", function() if pending then I:Render() end end)
    ns:On("BAG_UPDATE_DELAYED", function() I:Render() end)
    ns:On("BAG_UPDATE_COOLDOWN", function() I:UpdateCooldown() end)
    ns:On("GET_ITEM_INFO_RECEIVED", function(id) if id == I.itemID then I:Render() end end)
end

function I:RestorePosition()
    if InCombatLockdown() then return end
    local f = self.frame
    f:ClearAllPoints()
    f:SetPoint("TOPLEFT", DQF_Frame, "BOTTOM", 2, -2)
    f:SetPoint("TOPRIGHT", DQF_Frame, "BOTTOMRIGHT", 0, -2)
end

function I:OnUpdate(st)
    self.itemID = st.step and not st.step.done and st.step.item
    self:Render()
end

function I:UpdateCooldown()
    local b = self.button
    if b and b.itemID then
        local start, dur = (C_Container and C_Container.GetItemCooldown or GetItemCooldown)(b.itemID)
        b.cd:SetCooldown(start or 0, dur or 0)
    end
end

function I:Render()
    local b = self.button
    if not b then return end
    local id = self.itemID
    local count = id and ns.GetItemCount and ns.GetItemCount(id) or 0
    if InCombatLockdown() then
        pending = true
        if self.frame:IsShown() then b.count:SetText(count > 1 and count or "") end
        return
    end
    pending = false
    if not id or count == 0 then
        self.frame:Hide()
        b.itemID = nil
        return
    end
    b.itemID = id
    b:SetAttribute("item", "item:" .. id)
    b.icon:SetTexture((C_Item and C_Item.GetItemIconByID or GetItemIcon)(id))
    local name, _, quality; if ns.GetItemInfo then name, _, quality = ns.GetItemInfo(id) end
    b.name:SetText(name or "...")
    local r, g, bl = GetItemQualityColor(quality or 1)
    b.name:SetTextColor(r, g, bl)
    b.count:SetText(count > 1 and count or "")
    self:UpdateCooldown()
    self.frame:Show()
end
