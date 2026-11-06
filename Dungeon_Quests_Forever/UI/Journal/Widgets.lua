local _, ns = ...
local W = {}
ns.Widgets = W

-- Small building blocks of the journal window, in the addon's flat style.

function W.Font(parent, template, wrap)
    local fs = parent:CreateFontString(nil, "OVERLAY", template or "GameFontHighlight")
    fs:SetJustifyH("LEFT")
    fs:SetJustifyV("TOP")
    fs:SetWordWrap(wrap and true or false)
    return fs
end

function W.Accent() return unpack(ns.Theme().accent) end
function W.AccentHex()
    local r, g, b = W.Accent()
    return ("%02x%02x%02x"):format(r * 255, g * 255, b * 255)
end

-- Flat button: themed panel + label, highlight, optional icon and tooltip
function W.Button(parent, text, width, height, onClick, tip)
    if ns.BLIZZ then return ns.Skin.Button(parent, text, width, height, onClick, tip) end
    local b = ns.Panel(parent, "bar", "Button", true)
    b:SetSize(width or 120, height or 22)
    b.text = b:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    b.text:SetPoint("CENTER")
    b.text:SetText(text or "")
    b:SetHighlightTexture("Interface\\Buttons\\WHITE8X8")
    b:GetHighlightTexture():SetVertexColor(1, 1, 1, 0.1)
    b:SetScript("OnClick", function(s, btn) PlaySound(856); if onClick then onClick(s, btn) end end)
    if tip then
        b:SetScript("OnEnter", function(s)
            GameTooltip:SetOwner(s, "ANCHOR_TOP")
            GameTooltip:AddLine(type(tip) == "function" and tip() or tip, 1, 1, 1, true)
            GameTooltip:Show()
        end)
        b:SetScript("OnLeave", GameTooltip_Hide)
    end
    function b:SetLabel(t) self.text:SetText(t) end
    -- width that fits the label
    function b:FitText(pad)
        self:SetWidth(math.max(40, self.text:GetStringWidth() + (pad or 20)))
    end
    return b
end

-- Small icon button (texture) with tooltip
function W.IconButton(parent, texture, size, onClick, tip)
    local b = CreateFrame("Button", nil, parent)
    b:SetSize(size or 18, size or 18)
    b:SetNormalTexture(texture)
    b:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
    b:SetScript("OnClick", function(s, btn) if onClick then onClick(s, btn) end end)
    if tip then
        b:SetScript("OnEnter", function(s)
            GameTooltip:SetOwner(s, "ANCHOR_TOP")
            GameTooltip:AddLine(type(tip) == "function" and tip() or tip, 1, 1, 1, true)
            GameTooltip:Show()
        end)
        b:SetScript("OnLeave", GameTooltip_Hide)
    end
    return b
end

-- Tab: text with an accent underline when selected
function W.Tab(parent, text, onClick)
    local t = CreateFrame("Button", nil, parent)
    t:SetHeight(24)
    t.text = t:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    t.text:SetPoint("CENTER", 0, 1)
    t.text:SetText(text)
    t:SetWidth(t.text:GetStringWidth() + 26)
    t.line = t:CreateTexture(nil, "ARTWORK")
    t.line:SetPoint("BOTTOMLEFT", 4, 0); t.line:SetPoint("BOTTOMRIGHT", -4, 0); t.line:SetHeight(2)
    t:SetHighlightTexture("Interface\\Buttons\\WHITE8X8")
    t:GetHighlightTexture():SetVertexColor(1, 1, 1, 0.05)
    t:SetScript("OnClick", function(s) PlaySound(841); onClick(s) end)
    function t:SetSelected(sel)
        if ns.BLIZZ then
            -- written on the parchment: ink, brown underline
            self.line:SetColorTexture(0.45, 0.25, 0.05, 1)
            ns.Skin.Ink(self.text, not sel)
        else
            local r, g, b = W.Accent()
            self.line:SetColorTexture(r, g, b, 1)
            if sel then self.text:SetTextColor(1, 1, 1) else self.text:SetTextColor(0.65, 0.65, 0.65) end
        end
        self.line:SetShown(sel)
    end
    function t:SetLabel(s) self.text:SetText(s); self:SetWidth(self.text:GetStringWidth() + 26) end
    return t
end

-- Section title with an accent line under it; returns the bottom offset
function W.Heading(parent, text)
    local h = W.Font(parent, "GameFontNormal")
    h:SetText(text)
    h.line = parent:CreateTexture(nil, "ARTWORK")
    h.line:SetPoint("TOPLEFT", h, "BOTTOMLEFT", 0, -3)
    h.line:SetHeight(1)
    local r, g, b = W.Accent()
    h.line:SetColorTexture(r, g, b, 0.5)
    return h
end

-- Scroll area with a thin themed bar; content goes into area.child.
-- area:SetContentHeight(h) after filling.
function W.ScrollArea(parent)
    local sf = CreateFrame("ScrollFrame", nil, parent)
    local child = CreateFrame("Frame", nil, sf)
    child:SetSize(1, 1)
    sf:SetScrollChild(child)
    sf.child = child
    sf:EnableMouseWheel(true)

    local bar = CreateFrame("Slider", nil, sf, "BackdropTemplate")
    bar:SetOrientation("VERTICAL")
    bar:SetWidth(4)
    bar:SetPoint("TOPRIGHT", sf, "TOPRIGHT", 0, 0)
    bar:SetPoint("BOTTOMRIGHT", sf, "BOTTOMRIGHT", 0, 0)
    bar:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8X8" })
    bar:SetBackdropColor(1, 1, 1, 0.06)
    bar:SetThumbTexture("Interface\\Buttons\\WHITE8X8")
    bar:GetThumbTexture():SetSize(4, 30)
    bar:SetMinMaxValues(0, 0)
    bar:SetValue(0)
    bar:SetScript("OnValueChanged", function(_, v) sf:SetVerticalScroll(v) end)
    sf.bar = bar

    sf:SetScript("OnMouseWheel", function(s, d)
        local _, max = bar:GetMinMaxValues()
        bar:SetValue(math.max(0, math.min(max, bar:GetValue() - d * 40)))
    end)
    sf:SetScript("OnSizeChanged", function(s, w)
        child:SetWidth(math.max(1, (w or s:GetWidth()) - 8))
        s:UpdateBar()
    end)
    function sf:UpdateBar()
        local max = math.max(0, (self.contentHeight or 0) - self:GetHeight())
        bar:SetMinMaxValues(0, max)
        if bar:GetValue() > max then bar:SetValue(max) end
        bar:SetShown(max > 0)
        local r, g, b = W.Accent()
        bar:GetThumbTexture():SetVertexColor(r, g, b, 0.9)
    end
    function sf:SetContentHeight(h)
        self.contentHeight = h
        child:SetHeight(math.max(1, h))
        self:UpdateBar()
    end
    function sf:ScrollToTop() bar:SetValue(0); self:SetVerticalScroll(0) end
    function sf:ScrollTo(y)
        local _, max = bar:GetMinMaxValues()
        bar:SetValue(math.max(0, math.min(max, y)))
    end
    return sf
end

-- Redraw after a size change, on the next frame. Asking a size during a
-- draw can make the game lay the window out and fire OnSizeChanged right
-- away: redrawing then (in the middle of the first draw) mixed both.
function W.OnResize(frame, fn)
    local pending = false
    frame:HookScript("OnSizeChanged", function()
        if pending then return end
        pending = true
        C_Timer.After(0, function() pending = false; fn() end)
    end)
end

-- Pool of frames created on demand: pool:Get() / pool:ReleaseAll()
function W.Pool(create)
    local p = { used = 0, frames = {} }
    function p:Get()
        self.used = self.used + 1
        local f = self.frames[self.used]
        if not f then f = create(); self.frames[self.used] = f end
        f:Show()
        return f
    end
    function p:ReleaseAll()
        for i = 1, #self.frames do self.frames[i]:Hide() end
        self.used = 0
    end
    return p
end

-- List row: highlight, selected state, icon + two lines
function W.Row(parent, height)
    local r = CreateFrame("Button", nil, parent)
    r:SetHeight(height or 34)
    r.sel = r:CreateTexture(nil, "BACKGROUND")
    r.sel:SetAllPoints()
    r.sel:SetColorTexture(1, 1, 1, 0)
    r.edge = r:CreateTexture(nil, "BORDER")
    r.edge:SetPoint("TOPLEFT"); r.edge:SetPoint("BOTTOMLEFT"); r.edge:SetWidth(2)
    r.edge:Hide()
    r:SetHighlightTexture("Interface\\Buttons\\WHITE8X8")
    r:GetHighlightTexture():SetVertexColor(1, 1, 1, 0.05)
    r.icon = r:CreateTexture(nil, "ARTWORK")
    r.icon:SetSize((height or 34) - 8, (height or 34) - 8)
    r.icon:SetPoint("LEFT", 6, 0)
    r.main = W.Font(r, "GameFontHighlight")
    r.main:SetPoint("TOPLEFT", r.icon, "TOPRIGHT", 8, -1)
    r.main:SetPoint("RIGHT", -24, 0)
    r.sub = W.Font(r, "GameFontDisableSmall")
    r.sub:SetPoint("TOPLEFT", r.main, "BOTTOMLEFT", 0, -3)
    r.sub:SetPoint("RIGHT", -24, 0)
    r.mark = r:CreateTexture(nil, "OVERLAY")
    r.mark:SetSize(14, 14)
    r.mark:SetPoint("RIGHT", -6, 0)
    r.mark:Hide()
    r:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    function r:SetSelected(sel)
        local cr, cg, cb = W.Accent()
        self.sel:SetColorTexture(cr, cg, cb, sel and 0.12 or 0)
        self.edge:SetColorTexture(cr, cg, cb, 1)
        self.edge:SetShown(sel)
    end
    return r
end

-- Vertical flow inside a scroll area: texts, headings, item grids, custom
-- frames are added one under the other, then flow:Finish() sets the height.
function W.Flow(area, pad)
    local child = area.child
    local flow = { y = 0, pad = pad or 10 }
    local fonts = W.Pool(function() return W.Font(child, "GameFontHighlight", true) end)
    local lines = W.Pool(function() return child:CreateTexture(nil, "ARTWORK") end)
    local items = W.Pool(function() return ns.Items.Create(child, 30, true) end)

    function flow:Clear()
        self.y = -self.pad
        fonts:ReleaseAll(); lines:ReleaseAll(); items:ReleaseAll()
        for _, f in ipairs(self.custom or {}) do f:Hide() end
        self.custom = {}
    end
    function flow:Width() return child:GetWidth() - 2 * self.pad end
    function flow:Space(h) self.y = self.y - (h or 8) end
    -- text block; opts: font, color {r,g,b}, indent, gap
    function flow:Text(text, opts)
        opts = opts or {}
        local fs = fonts:Get()
        fs:SetFontObject(opts.font or "GameFontHighlight")
        fs:SetTextColor(unpack(opts.color or { 1, 1, 1 }))
        fs:SetWidth(self:Width() - (opts.indent or 0))
        fs:ClearAllPoints()
        fs:SetPoint("TOPLEFT", self.pad + (opts.indent or 0), self.y)
        fs:SetText(text or "")
        self.y = self.y - fs:GetStringHeight() - (opts.gap or 4)
        return fs
    end
    function flow:Heading(text)
        self:Space(6)
        local fs = self:Text(text, { font = "GameFontNormal", color = { W.Accent() }, gap = 3 })
        local ln = lines:Get()
        ln:ClearAllPoints()
        ln:SetPoint("TOPLEFT", self.pad, self.y)
        ln:SetSize(self:Width(), 1)
        local r, g, b = W.Accent()
        ln:SetColorTexture(r, g, b, 0.35)
        self.y = self.y - 6
        return fs
    end
    -- grid of wide item buttons; list = { {id, opts}, ... }
    function flow:Items(list, cols)
        cols = cols or math.max(1, math.floor(self:Width() / 230))
        local cw = self:Width() / cols
        for i, e in ipairs(list) do
            local b = items:Get()
            b:SetSize(cw - 8, 30)
            b:ClearAllPoints()
            b:SetPoint("TOPLEFT", self.pad + ((i - 1) % cols) * cw, self.y - math.floor((i - 1) / cols) * 34)
            b:SetItem(e[1], e[2])
        end
        self.y = self.y - math.ceil(#list / cols) * 34 - 2
    end
    -- custom frame placed at the current position (height h)
    function flow:Place(frame, h, indent)
        frame:SetParent(child)
        frame:ClearAllPoints()
        frame:SetPoint("TOPLEFT", self.pad + (indent or 0), self.y)
        frame:Show()
        self.custom[#self.custom + 1] = frame
        self.y = self.y - h
    end
    function flow:Finish() area:SetContentHeight(-self.y + self.pad) end
    flow:Clear()
    return flow
end

-- Blinks the item button showing itemID inside a container (search result)
function W.FlashItem(container, itemID)
    for _, b in ipairs({ container:GetChildren() }) do
        if b.itemID == itemID and b:IsShown() then
            if not b.flash then
                b.flash = b:CreateTexture(nil, "OVERLAY")
                b.flash:SetAllPoints()
                b.flash:SetTexture("Interface\\Buttons\\WHITE8X8")
                b.flash:SetBlendMode("ADD")
            end
            local r, g, bl = W.Accent()
            b.flash:SetVertexColor(r, g, bl, 1)
            local t = 0
            b.flash:Show()
            b:SetScript("OnUpdate", function(s, e)
                t = t + e
                s.flash:SetAlpha(0.35 * math.abs(math.sin(t * 4)))
                if t > 2.5 then s.flash:Hide(); s:SetScript("OnUpdate", nil) end
            end)
            local area = container:GetParent()
            if area and area.ScrollTo then
                local top = container:GetTop() and b:GetTop() and (container:GetTop() - b:GetTop())
                if top then area:ScrollTo(top - 20) end
            end
            return
        end
    end
end

-- Accent-insensitive lower-case text for searches
local ACCENTS = {
    ["à"] = "a", ["â"] = "a", ["ä"] = "a", ["á"] = "a", ["ã"] = "a", ["ç"] = "c",
    ["é"] = "e", ["è"] = "e", ["ê"] = "e", ["ë"] = "e", ["í"] = "i", ["î"] = "i", ["ï"] = "i",
    ["ñ"] = "n", ["ó"] = "o", ["ô"] = "o", ["ö"] = "o", ["õ"] = "o", ["ú"] = "u", ["ù"] = "u",
    ["û"] = "u", ["ü"] = "u", ["ß"] = "ss", ["œ"] = "oe",
    ["À"] = "a", ["Â"] = "a", ["Ä"] = "a", ["Á"] = "a", ["Ç"] = "c", ["É"] = "e", ["È"] = "e",
    ["Ê"] = "e", ["Î"] = "i", ["Ô"] = "o", ["Ö"] = "o", ["Ü"] = "u", ["Û"] = "u", ["Œ"] = "oe",
}
function W.Simplify(s)
    if not s then return "" end
    s = s:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):lower()
    s = s:gsub("[\195\197][\128-\191]", function(c) return ACCENTS[c] or c end)
    return s
end
