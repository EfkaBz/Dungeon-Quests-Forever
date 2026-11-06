local _, ns = ...
local L = ns.L

-- bg/bar: base colors, accent: highlights (current step, progress, thumb)
-- A theme may also give `game`: the game's own window look (textured
-- background + gold border) used by the big panels instead of the flat one.
ns.THEMES = {
    default  = { name = { "Bleu nuit", "Midnight" }, bg = {0.04, 0.06, 0.14, 0.92}, border = {0.45, 0.52, 0.75, 0.9}, bar = {0.09, 0.24, 0.36, 0.96}, accent = {1, 0.82, 0.2} },
    dark     = { name = { "Sombre", "Dark" }, bg = {0.03, 0.03, 0.03, 0.94}, border = {0.35, 0.35, 0.35, 0.9}, bar = {0.14, 0.14, 0.14, 0.96}, accent = {0.9, 0.9, 0.9} },
    horde    = { name = { "Horde", "Horde" }, bg = {0.10, 0.03, 0.03, 0.92}, border = {0.75, 0.20, 0.12, 0.9}, bar = {0.38, 0.07, 0.05, 0.96}, accent = {1, 0.6, 0.2} },
    alliance = { name = { "Alliance", "Alliance" }, bg = {0.03, 0.05, 0.13, 0.92}, border = {0.35, 0.55, 0.95, 0.9}, bar = {0.07, 0.18, 0.45, 0.96}, accent = {0.5, 0.8, 1} },
    -- gold and black: dark dialog background, gold border, gold titles
    -- (small widgets keep a thin frame in the same colors)
    goldblack = { name = { "Or/Noir", "Gold/Black" }, bg = {0.06, 0.05, 0.04, 0.92}, border = {0.72, 0.6, 0.3, 1}, bar = {0.16, 0.12, 0.07, 0.96}, accent = {1, 0.82, 0},
        game = {
            backdrop = {
                bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
                edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
                tile = true, tileSize = 32, edgeSize = 16,
                insets = { left = 4, right = 4, top = 4, bottom = 4 },
            },
            bg = {1, 1, 1, 1}, bar = {0.75, 0.68, 0.55, 1}, border = {1, 1, 1, 1},
        } },
    -- the game's own interface: portrait windows, spellbook parchment, panel
    -- buttons, check boxes, input boxes (see UI\Skin.lua); small floating
    -- panels (tracker, targets) take the tooltip look. Needs a UI reload.
    blizzard = { name = { "Blizzard (jeu)", "Blizzard (game)" }, bg = {0.04, 0.03, 0.02, 0.9}, border = {0.6, 0.5, 0.2, 0.9}, bar = {0.12, 0.09, 0.05, 0.95}, accent = {1, 0.82, 0},
        reload = true,
        game = {
            backdrop = {
                bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
                edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
                tile = true, tileSize = 16, edgeSize = 16,
                insets = { left = 4, right = 4, top = 4, bottom = 4 },
            },
            bg = {0.02, 0.02, 0.02, 0.92}, bar = {0.12, 0.09, 0.05, 0.95}, border = {0.85, 0.7, 0.3, 1},
        } },
}
ns.THEME_ORDER = { "default", "dark", "horde", "alliance", "goldblack", "blizzard" }

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

local function Apply(p, role, flat)
    if p.skinned then return end -- turned into a game component (UI\Skin.lua)
    local t = ns.Theme()
    local game = not flat and t.game
    local backdrop = game and game.backdrop or (flat and FLAT or ROUNDED)
    if p.backdropUsed ~= backdrop then
        p:SetBackdrop(backdrop)
        p.backdropUsed = backdrop
    end
    local colors = game or t
    local c = role == "bar" and colors.bar or colors.bg
    p:SetBackdropColor(c[1], c[2], c[3], c[4])
    p:SetBackdropBorderColor(unpack(colors.border))
    if p.shine then
        -- soft light on top, darker at the bottom (not on the game look)
        p.shine:SetShown(not game)
        Gradient(p.shine, { 1, 1, 1, role == "bar" and 0.08 or 0.04 }, { 0, 0, 0, 0.12 })
    end
end

-- Themed backdrop frame.
-- role: "bg" (default) or "bar"; flat = thin square border (small widgets)
function ns.Panel(parent, role, frameType, flat)
    local p = CreateFrame(frameType or "Frame", nil, parent, "BackdropTemplate")
    if not flat then
        p.shine = p:CreateTexture(nil, "BORDER")
        p.shine:SetTexture("Interface\\Buttons\\WHITE8X8")
        p.shine:SetPoint("TOPLEFT", 1, -1)
        p.shine:SetPoint("BOTTOMRIGHT", -1, 1)
    end
    panels[#panels + 1] = { p, role, flat }
    Apply(p, role, flat)
    return p
end

function ns.ApplyTheme()
    for _, e in ipairs(panels) do Apply(e[1], e[2], e[3]) end
    if ns.UI and ns.UI.ApplyAccent then ns.UI:ApplyAccent() end
    for _, m in ipairs({ ns.Targets, ns.ItemButton }) do
        if m and m.frame and m.frame.ApplyTheme then m.frame.ApplyTheme() end
    end
    -- journal: accent colors of tabs, lists and the current page
    local J = ns.Journal
    if J and J.frame and J.frame:IsShown() then
        if J.view == "dungeon" then J:RefreshHeader() end
        local page = J.current and J.pages[J.current]
        if page and page.Refresh then page:Refresh() end
    end
end
