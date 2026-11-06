local _, ns = ...
local L = ns.L
local Items = {}
ns.Items = Items

-- Item buttons used by the journal (loot, rewards, search):
--  hover          tooltip (+ "source" line)
--  Shift + hover  comparison with the equipped item
--  Shift + click  link in the chat
--  Ctrl + click   dressing room

local CI = C_Item or {}
local GetInfoInstant = CI.GetItemInfoInstant or GetItemInfoInstant
local RequestLoad = CI.RequestLoadItemDataByID

-- name, link, quality, icon, equipLoc, classID, subClassID, minLevel, subType
function Items.Info(id)
    local name, link, quality, _, minLevel, _, subType, _, equipLoc, icon, _, classID, subClassID = ns.GetItemInfo(id)
    if not name then
        if RequestLoad then pcall(RequestLoad, id) end
        local _, _, _, eLoc, ico, cls, sub = GetInfoInstant(id)
        return nil, nil, nil, ico, eLoc, cls, sub
    end
    return name, link, quality, icon, equipLoc, classID, subClassID, minLevel, subType
end

-- "Head, Leather" (localized by the game)
function Items.SlotText(id)
    local _, _, _, _, equipLoc, classID, _, _, subType = Items.Info(id)
    local slot = equipLoc and equipLoc ~= "" and _G[equipLoc]
    local recipe = Enum and Enum.ItemClass and classID == Enum.ItemClass.Recipe
    if recipe then return subType or "" end
    if slot and subType and subType ~= "" and subType ~= MISCELLANEOUS and equipLoc ~= "INVTYPE_FINGER"
        and equipLoc ~= "INVTYPE_NECK" and equipLoc ~= "INVTYPE_TRINKET" and equipLoc ~= "INVTYPE_CLOAK" then
        return slot .. ", " .. subType
    end
    return slot or subType or ""
end

function Items.Link(id)
    local _, link = Items.Info(id)
    return link or ("item:" .. id)
end

-- Buttons waiting for item data from the server
local waiting = {}
ns:On("GET_ITEM_INFO_RECEIVED", function(id)
    local list = id and waiting[id]
    if not list then return end
    waiting[id] = nil
    for b in pairs(list) do if b.itemID == id then b:Refresh() end end
end)

local function ShowTooltip(b)
    if not b.itemID then return end
    GameTooltip:SetOwner(b, "ANCHOR_RIGHT")
    local ok = pcall(GameTooltip.SetHyperlink, GameTooltip, "item:" .. b.itemID)
    if not ok then GameTooltip:SetItemByID(b.itemID) end
    if b.source then GameTooltip:AddLine(b.source, 0.6, 0.8, 1, true) end
    GameTooltip:AddLine(L("Maj+clic : lien  -  Ctrl+clic : essayer", "Shift-click: link  -  Ctrl-click: try on"), 0.5, 0.5, 0.5)
    GameTooltip:Show()
    if IsShiftKeyDown() and GameTooltip_ShowCompareItem then pcall(GameTooltip_ShowCompareItem, GameTooltip) end
end

local function OnClick(b)
    if not b.itemID then return end
    local link = Items.Link(b.itemID)
    if IsControlKeyDown() then
        if DressUpItemLink then DressUpItemLink(link) end
    elseif IsShiftKeyDown() then
        ns.InsertLink(link)
    elseif b.onClick then
        b.onClick(b)
    end
end

-- Hovered button: refresh the tooltip when Shift is pressed/released
local hovered
ns:On("MODIFIER_STATE_CHANGED", function()
    if hovered and hovered:IsMouseOver() then ShowTooltip(hovered) end
end)

local Proto = {}

function Proto:Refresh()
    local id = self.itemID
    if not id then return end
    local name, _, quality, icon = Items.Info(id)
    self.icon:SetTexture(icon or "Interface\\Icons\\INV_Misc_QuestionMark")
    local r, g, b = ns.QualityColor(quality)
    self.iconBg:SetBackdropBorderColor(r, g, b, quality and quality > 1 and 1 or 0.5)
    if self.name then
        self.name:SetText(name or ("item " .. id))
        self.name:SetTextColor(r, g, b)
    end
    if self.sub then self.sub:SetText(self.subText or Items.SlotText(id)) end
    if not name then
        waiting[id] = waiting[id] or {}
        waiting[id][self] = true
    end
end

-- opts: source (tooltip line), count, dim (filtered out), sub (custom 2nd line),
-- onClick (plain click)
function Proto:SetItem(id, opts)
    opts = opts or {}
    self.itemID, self.source, self.subText, self.onClick = id, opts.source, opts.sub, opts.onClick
    self.count:SetText(opts.count and opts.count > 1 and opts.count or "")
    self:SetAlpha(opts.dim and 0.35 or 1)
    self.icon:SetDesaturated(opts.dim and true or false)
    self:Refresh()
    self:Show()
end

-- size: icon size; wide = icon + name + slot text on its right
function Items.Create(parent, size, wide)
    local b = CreateFrame("Button", nil, parent)
    b:SetSize(size, size)
    b.iconBg = ns.Panel(b, "bg", nil, true)
    b.iconBg:SetSize(size, size); b.iconBg:SetPoint("LEFT")
    b.iconBg:SetBackdropColor(0, 0, 0, 0.7)
    b.icon = b.iconBg:CreateTexture(nil, "ARTWORK")
    b.icon:SetPoint("TOPLEFT", 1, -1); b.icon:SetPoint("BOTTOMRIGHT", -1, 1)
    b.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    b.count = b.iconBg:CreateFontString(nil, "OVERLAY", "NumberFontNormalSmall")
    b.count:SetPoint("BOTTOMRIGHT", -1, 1)
    if wide then
        b.name = b:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        b.name:SetPoint("TOPLEFT", b.iconBg, "TOPRIGHT", 6, -1)
        b.name:SetPoint("RIGHT", -2, 0)
        b.name:SetJustifyH("LEFT"); b.name:SetWordWrap(false)
        b.sub = b:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        b.sub:SetPoint("TOPLEFT", b.name, "BOTTOMLEFT", 0, -2)
        b.sub:SetPoint("RIGHT", -2, 0)
        b.sub:SetJustifyH("LEFT"); b.sub:SetWordWrap(false)
        b:SetHighlightTexture("Interface\\Buttons\\WHITE8X8")
        b:GetHighlightTexture():SetVertexColor(1, 1, 1, 0.06)
    else
        b:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    end
    b:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    b:SetScript("OnClick", OnClick)
    b:SetScript("OnEnter", function(s) hovered = s; ShowTooltip(s) end)
    b:SetScript("OnLeave", function() hovered = nil; GameTooltip_Hide() end)
    for k, v in pairs(Proto) do b[k] = v end
    return b
end
