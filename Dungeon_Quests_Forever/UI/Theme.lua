local _, ns = ...
local L = ns.L

-- bg/bar: base colors, accent: highlights (current step, progress, thumb)
ns.THEMES = {
    default  = { name = { "Bleu nuit", "Midnight" }, bg = {0.04, 0.06, 0.14, 0.92}, border = {0.45, 0.52, 0.75, 0.9}, bar = {0.09, 0.24, 0.36, 0.96}, accent = {1, 0.82, 0.2} },
    dark     = { name = { "Sombre", "Dark" }, bg = {0.03, 0.03, 0.03, 0.94}, border = {0.35, 0.35, 0.35, 0.9}, bar = {0.14, 0.14, 0.14, 0.96}, accent = {0.9, 0.9, 0.9} },
    horde    = { name = { "Horde", "Horde" }, bg = {0.10, 0.03, 0.03, 0.92}, border = {0.75, 0.20, 0.12, 0.9}, bar = {0.38, 0.07, 0.05, 0.96}, accent = {1, 0.6, 0.2} },
    alliance = { name = { "Alliance", "Alliance" }, bg = {0.03, 0.05, 0.13, 0.92}, border = {0.35, 0.55, 0.95, 0.9}, bar = {0.07, 0.18, 0.45, 0.96}, accent = {0.5, 0.8, 1} },
}
ns.THEME_ORDER = { "default", "dark", "horde", "alliance" }

local panels = {}

function ns.ThemeName(t) return L(t.name[1], t.name[2]) end

function ns.Theme()
    return ns.THEMES[DQF_DB.theme] or ns.THEMES.default
end

-- crisp 1px frame (the rounded tooltip border looked too much like other guides)
local ROUNDED = { bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Buttons\\WHITE8X8", edgeSize = 1 }
local FLAT = { bgFile = "Interface\\Buttons\\WHITE8X8", edgeFile = "Interface\\Buttons\\WHITE8X8", edgeSize = 1 }

local function Gradient(tex, top, bottom)
    -- new API (ColorMixin), then the old one
    if CreateColor and pcall(tex.SetGradient, tex, "VERTICAL", CreateColor(unpack(bottom)), CreateColor(unpack(top))) then return end
    if tex.SetGradientAlpha then tex:SetGradientAlpha("VERTICAL", unpack(bottom)); return end
    tex:SetColorTexture(unpack(top))
end

local function Apply(p, role)
    local t = ns.Theme()
    local c = role == "bar" and t.bar or t.bg
    p:SetBackdropColor(c[1], c[2], c[3], c[4])
    p:SetBackdropBorderColor(unpack(t.border))
    if p.shine then
        -- soft light on top, darker at the bottom
        Gradient(p.shine, { 1, 1, 1, role == "bar" and 0.08 or 0.04 }, { 0, 0, 0, 0.12 })
    end
end

-- Themed backdrop frame.
-- role: "bg" (default) or "bar"; flat = thin square border (small widgets)
function ns.Panel(parent, role, frameType, flat)
    local p = CreateFrame(frameType or "Frame", nil, parent, "BackdropTemplate")
    p:SetBackdrop(flat and FLAT or ROUNDED)
    if not flat then
        p.shine = p:CreateTexture(nil, "BORDER")
        p.shine:SetTexture("Interface\\Buttons\\WHITE8X8")
        p.shine:SetPoint("TOPLEFT", 1, -1)
        p.shine:SetPoint("BOTTOMRIGHT", -1, 1)
    end
    panels[#panels + 1] = { p, role }
    Apply(p, role)
    return p
end

function ns.ApplyTheme()
    for _, e in ipairs(panels) do Apply(e[1], e[2]) end
    if ns.UI and ns.UI.ApplyAccent then ns.UI:ApplyAccent() end
    for _, m in ipairs({ ns.Targets, ns.ItemButton }) do
        if m and m.frame and m.frame.ApplyTheme then m.frame.ApplyTheme() end
    end
end
