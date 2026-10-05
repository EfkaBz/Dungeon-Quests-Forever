local _, ns = ...
local L = ns.L
local T = {}
ns.Targets = T
ns:RegisterModule(T)

local ROW_H, MAX = 24, 6

-- Secure buttons can only be changed out of combat
local pendingUpdate

local KINDS = {
    boss  = { icon = "Interface\\TargetingFrame\\UI-TargetingFrame-Skull", color = { 1, 0.35, 0.3 } },
    enemy = { icon = "Interface\\Icons\\Ability_DualWield",                color = { 1, 0.6, 0.3 } },
    npc   = { icon = "Interface\\GossipFrame\\GossipGossipIcon",           color = { 0.3, 1, 0.3 } },
}
local function Kind(n) return n.boss and "boss" or (n.enemy and "enemy" or "npc") end
local function KindLabel(k)
    if k == "boss" then return L("Boss", "Boss") end
    if k == "enemy" then return L("Monstre", "Mob") end
    return L("PNJ", "NPC")
end

-- One row = one secure "/targetexact" button
local function CreateRow(parent, i)
    local b = CreateFrame("Button", nil, parent, "SecureActionButtonTemplate")
    b:SetHeight(ROW_H)
    b:SetPoint("TOPLEFT", 6, -23 - (i - 1) * ROW_H)
    b:SetPoint("RIGHT", -6, 0)
    -- secure buttons fire on key-down or key-up depending on the
    -- ActionButtonUseKeyDown CVar: register both so the click always works
    b:RegisterForClicks("AnyUp", "AnyDown")
    b:SetAttribute("type", "macro")

    b.stripe = b:CreateTexture(nil, "BACKGROUND")
    b.stripe:SetAllPoints()
    b.stripe:SetColorTexture(1, 1, 1, i % 2 == 0 and 0.04 or 0)
    b.iconBg = ns.Panel(b, "bg", nil, true)
    b.iconBg:SetSize(18, 18); b.iconBg:SetPoint("LEFT", 3, 0)
    b.iconBg:SetBackdropColor(0, 0, 0, 0.6)
    b.icon = b.iconBg:CreateTexture(nil, "ARTWORK")
    b.icon:SetPoint("TOPLEFT", 1, -1); b.icon:SetPoint("BOTTOMRIGHT", -1, 1)
    b.name = b:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    b.name:SetPoint("LEFT", b.iconBg, "RIGHT", 6, 0)
    b.name:SetPoint("RIGHT", -44, 0)
    b.name:SetJustifyH("LEFT"); b.name:SetWordWrap(false)
    b.kind = b:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    b.kind:SetPoint("RIGHT", -4, 0)
    b:SetHighlightTexture("Interface\\Buttons\\WHITE8X8")
    b:GetHighlightTexture():SetVertexColor(1, 1, 1, 0.08)

    b:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:AddLine(self.npcName or "?", 1, 1, 1)
        GameTooltip:AddLine(self.isEnemy and L("Clic : cibler + marque crâne", "Click: target + skull mark")
            or L("Clic : cibler + marque étoile", "Click: target + star mark"), 0.4, 0.8, 1)
        GameTooltip:Show()
    end)
    b:SetScript("OnLeave", GameTooltip_Hide)
    return b
end

function T:Init()
    -- docked under the main window (left half); follows its size, scale and alpha
    local f = CreateFrame("Frame", "DQF_Targets", DQF_Frame)
    f:SetHeight(60)

    -- body + tab, same style as the "Step N" box of the main window
    f.body = ns.Panel(f)
    f.body:SetPoint("TOPLEFT"); f.body:SetPoint("BOTTOMRIGHT")
    -- small caps title strip inside the panel (same look as the main window header)
    f.head = f.body:CreateTexture(nil, "BACKGROUND", nil, 1)
    f.head:SetPoint("TOPLEFT", 1, -1); f.head:SetPoint("TOPRIGHT", -1, -1); f.head:SetHeight(18)
    f.stripe = f.body:CreateTexture(nil, "ARTWORK")
    f.stripe:SetPoint("TOPLEFT", 1, -1); f.stripe:SetSize(3, 18)
    f.title = f.body:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    f.title:SetPoint("LEFT", f.head, "LEFT", 10, 0)
    f.title:SetText(L("CIBLES", "TARGETS"))
    function f.ApplyTheme()
        local t = ns.Theme()
        f.head:SetColorTexture(t.bar[1], t.bar[2], t.bar[3], 0.9)
        f.stripe:SetColorTexture(t.accent[1], t.accent[2], t.accent[3], 1)
    end
    f.ApplyTheme()

    self.frame, self.rows = f, {}
    for i = 1, MAX do self.rows[i] = CreateRow(f.body, i) end
    self:RestorePosition()

    ns:On("PLAYER_REGEN_ENABLED", function() if pendingUpdate then T:Render() end end)
    ns:On("NAME_PLATE_UNIT_ADDED", function(unit) T:Check(unit) end)
    ns:On("UPDATE_MOUSEOVER_UNIT", function() T:Check("mouseover") end)
    ns:On("PLAYER_TARGET_CHANGED", function() T:Check("target") end)
end

function T:RestorePosition()
    local f = self.frame
    f:ClearAllPoints()
    f:SetPoint("TOPLEFT", DQF_Frame, "BOTTOMLEFT", 0, -2)
    f:SetPoint("TOPRIGHT", DQF_Frame, "BOTTOM", -2, -2)
end

function T:OnUpdate(st)
    self.list = st.step and ns.StepTargets(st.step) or {}
    self.ids = {}
    for _, n in ipairs(self.list) do self.ids[n.id] = n end
    self:Render()
end

function T:Render()
    if not self.frame then return end
    if InCombatLockdown() then pendingUpdate = true return end
    pendingUpdate = false
    local list = self.list or {}
    local show = DQF_DB.targetsShown and #list > 0
    self.frame:SetShown(show)
    if not show then return end
    for i, b in ipairs(self.rows) do
        local n = list[i]
        if n then
            local k = Kind(n)
            b.npcName, b.isEnemy = ns.NPCName(n), n.enemy
            -- the click is a player action, so the macro may place the skull
            -- marker (the addon cannot do it on its own on this client)
            b:SetAttribute("macrotext", "/cleartarget\n/targetexact " .. b.npcName
                -- skull on mobs, star on quest NPCs
                .. "\n/tm [@target,exists,nodead] " .. (n.enemy and 8 or 1))
            b.icon:SetTexture(KINDS[k].icon)
            if k == "enemy" then b.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92) else b.icon:SetTexCoord(0, 1, 0, 1) end
            b.name:SetText(b.npcName)
            b.kind:SetText(KindLabel(k))
            b.kind:SetTextColor(unpack(KINDS[k].color))
            b:Show()
        else
            b:Hide()
        end
    end
    self.frame:SetHeight(23 + 5 + math.min(#list, MAX) * ROW_H)
end

-- Learn the exact in-game name of the step's NPCs when they are seen
-- (used by the /targetexact buttons)
function T:Check(unit)
    if not (self.ids and UnitExists(unit)) then return end
    local id = ns.NpcIDFromGUID(UnitGUID(unit))
    if not (id and self.ids[id]) then return end
    local name = UnitName(unit)
    if name and not ns.IsSecret(name) then ns.LearnName(id, name) end
end
