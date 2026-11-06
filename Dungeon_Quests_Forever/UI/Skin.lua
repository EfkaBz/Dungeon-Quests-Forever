local _, ns = ...
local S = {}
ns.Skin = S

-- "Blizzard (game)" theme: the windows are built with the game's own
-- components (portrait window, spellbook parchment, panel buttons, check
-- boxes, input boxes, tooltip-bordered list boxes). The structure of the
-- windows changes, so switching to/from this theme reloads the interface:
-- ns.BLIZZ is set once at load (Core.lua) and read while building.

local function AtlasExists(name)
    return C_Texture and C_Texture.GetAtlasInfo and C_Texture.GetAtlasInfo(name) ~= nil
end

-- dark brown ink for texts written on the parchment
function S.Ink(fs, soft)
    if soft then fs:SetTextColor(0.32, 0.22, 0.1) else fs:SetTextColor(0.1, 0.05, 0.01) end
    fs:SetShadowOffset(0, 0)
    return fs
end

-- Spellbook pages behind a window (from `top` pixels under its top edge).
-- single = one page only (the left one, over the whole width)
function S.Parchment(f, top, single)
    local left = f:CreateTexture(nil, "BACKGROUND", nil, 2)
    local right = f:CreateTexture(nil, "BACKGROUND", nil, 2)
    left:SetPoint("TOPLEFT", 6, -(top or 62))
    if single then
        left:SetPoint("BOTTOMRIGHT", -6, 6)
        right:Hide()
    else
        left:SetPoint("BOTTOMRIGHT", f, "BOTTOM", 0, 6)
    end
    right:SetPoint("TOPLEFT", f, "TOP", 0, -(top or 62))
    right:SetPoint("BOTTOMRIGHT", -6, 6)
    if AtlasExists("spellbook-background-evergreen-left") then
        left:SetAtlas("spellbook-background-evergreen-left")
        right:SetAtlas("spellbook-background-evergreen-right")
    else
        left:SetTexture("Interface\\Spellbook\\Spellbook-Page-1")
        left:SetTexCoord(0, 0.86, 0, 0.9)
        right:SetTexture("Interface\\Spellbook\\Spellbook-Page-2")
        right:SetTexCoord(0, 0.86, 0, 0.9)
    end
    f.parchment = { left, right }
end

local DIALOG = {
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border",
    tile = true, tileSize = 32, edgeSize = 24,
    insets = { left = 6, right = 6, top = 6, bottom = 6 },
}

-- Window with the game's portrait frame (title, portrait, close button).
-- Falls back to a gold-bordered dialog when the template is missing.
function S.Window(name, title)
    local ok, f = pcall(CreateFrame, "Frame", name, UIParent, "PortraitFrameTemplate")
    if not ok or not f then
        f = CreateFrame("Frame", name, UIParent, "BackdropTemplate")
        f:SetBackdrop(DIALOG)
        f.CloseButton = CreateFrame("Button", nil, f, "UIPanelCloseButton")
        f.CloseButton:SetPoint("TOPRIGHT", -4, -4)
    end
    -- the template's close button goes through HideUIPanel (blocked in combat)
    if f.CloseButton then f.CloseButton:SetScript("OnClick", function() ns.Anim.Hide(f) end) end
    S.SetTitle(f, title)
    local tex = (f.PortraitContainer and f.PortraitContainer.portrait) or f.portrait
    if not tex then
        tex = f:CreateTexture(nil, "OVERLAY")
        tex:SetSize(58, 58)
        tex:SetPoint("TOPLEFT", -5, 7)
    end
    tex:SetTexture("Interface\\AddOns\\Dungeon_Quests_Forever\\Media\\icon")
    if tex.SetMask then pcall(tex.SetMask, tex, "Interface\\CharacterFrame\\TempPortraitAlphaMask") end
    f.portraitTex = tex
    return f
end

-- Small docked frame (targets, quest item) made by ns.Panel: the game's
-- dark dialog background with a thin gold border; its title strip is
-- replaced by a gold line under the title
local SMALL = {
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border",
    tile = true, tileSize = 32, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 },
}
function S.SmallFrame(f)
    local body = f.body
    body:SetBackdrop(SMALL)
    body:SetBackdropColor(1, 1, 1, 1)
    body:SetBackdropBorderColor(1, 1, 1, 1)
    body.skinned = true
    if body.shine then body.shine:Hide() end
    f.head:Hide(); f.stripe:Hide()
    f.title:ClearAllPoints()
    f.title:SetPoint("TOPLEFT", 10, -7)
    local line = body:CreateTexture(nil, "ARTWORK")
    line:SetPoint("TOPLEFT", 8, -20); line:SetPoint("TOPRIGHT", -8, -20); line:SetHeight(1)
    line:SetColorTexture(1, 0.82, 0, 0.45)
    f.ApplyTheme = function() end
end

-- Turns a frame made by ns.Panel into the game's dialog box: gold border,
-- header plate with the title, close button. Returns { title = fontstring }.
function S.Dialog(f)
    f:SetBackdrop(DIALOG)
    f:SetBackdropColor(1, 1, 1, 1)
    f:SetBackdropBorderColor(1, 1, 1, 1)
    f.skinned = true
    if f.shine then f.shine:Hide() end
    local header = f:CreateTexture(nil, "ARTWORK")
    header:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
    header:SetSize(300, 64)
    header:SetPoint("TOP", 0, 12)
    local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", header, "TOP", 0, -14)
    local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -4, -4)
    close:SetScript("OnClick", function() ns.Anim.Hide(f) end)
    return { title = title, header = header, close = close }
end

function S.SetTitle(f, text)
    if f.SetTitle then f:SetTitle(text) return end
    local t = f.TitleText or (f.TitleContainer and f.TitleContainer.TitleText)
    if not t then
        t = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        t:SetPoint("TOP", 0, -5)
        f.TitleText = t
    end
    t:SetText(text)
end

-- Dark box with a tooltip border (lists, sheets): the backdrop is set on
-- `frame` itself, so it is drawn under its texts and children and over
-- the parchment of the window
local LISTBOX = {
    bgFile = "Interface\\Buttons\\WHITE8X8",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    edgeSize = 12,
    insets = { left = 3, right = 3, top = 3, bottom = 3 },
}
function S.ListBox(frame)
    if not frame.SetBackdrop and Mixin and BackdropTemplateMixin then
        Mixin(frame, BackdropTemplateMixin)
        frame:HookScript("OnSizeChanged", frame.OnBackdropSizeChanged)
    end
    if not frame.SetBackdrop then return end
    frame:SetBackdrop(LISTBOX)
    frame:SetBackdropColor(0.04, 0.03, 0.02, 0.88)
    frame:SetBackdropBorderColor(0.6, 0.5, 0.2, 0.9)
    return frame
end

-- Turns a frame created by ns.Panel into a list box (same look as above)
function S.MakeListBox(p)
    p:SetBackdrop(LISTBOX)
    p:SetBackdropColor(0.04, 0.03, 0.02, 0.88)
    p:SetBackdropBorderColor(0.6, 0.5, 0.2, 0.9)
    p.skinned = true
    return p
end

-- Panel button of the game, with the same helpers as Widgets.Button
function S.Button(parent, text, width, height, onClick, tip)
    local b = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    b:SetSize(width or 120, height or 22)
    b:SetText(text or "")
    b.text = b:GetFontString()
    b:SetScript("OnClick", function(s, btn) if onClick then onClick(s, btn) end end)
    if tip then
        b:SetScript("OnEnter", function(s)
            GameTooltip:SetOwner(s, "ANCHOR_TOP")
            GameTooltip:AddLine(type(tip) == "function" and tip() or tip, 1, 1, 1, true)
            GameTooltip:Show()
        end)
        b:SetScript("OnLeave", GameTooltip_Hide)
    end
    function b:SetLabel(t) self:SetText(t) end
    function b:FitText(pad)
        local w = (self.GetTextWidth and self:GetTextWidth()) or (self.text and self.text:GetStringWidth()) or 60
        self:SetWidth(math.max(40, w + (pad or 20) + 6))
    end
    return b
end

-- Check box of the game (same OnClick/SetChecked API as the themed one)
function S.Check(parent, size)
    local c = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    c:SetSize((size or 16) + 8, (size or 16) + 8)
    return c
end

-- Input box of the game; search = with the magnifier and clear button
function S.EditBox(parent, width, height, search)
    local e
    if search then
        local ok, box = pcall(CreateFrame, "EditBox", nil, parent, "SearchBoxTemplate")
        if ok then e = box end
    end
    e = e or CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    e:SetSize(width, height or 20)
    e:SetAutoFocus(false)
    return e
end
