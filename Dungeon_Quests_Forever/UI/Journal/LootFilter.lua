local _, ns = ...
local L = ns.L
local W = ns.Widgets
local J = ns.Journal
local LF = {}
ns.LootFilter = LF

-- Loot filter: recipes shown or not, only what my class can use, minimum
-- required level, stats. Boss pages dim the items ruled out; "Show" lists
-- every boss, in every dungeon, that drops a matching item.

local function S() return DQF_DB.lootFilter end

local CI = C_Item or {}
local GetInfoInstant = CI.GetItemInfoInstant or GetItemInfoInstant
local GetStats = CI.GetItemStats or GetItemStats

----------------------------------------------------------------------
-- Rules
----------------------------------------------------------------------
local WEAPON, ARMOR, RECIPE = 2, 4, 9
-- weapon sub classes: 0 axe, 1 axe 2H, 2 bow, 3 gun, 4 mace, 5 mace 2H, 6 polearm,
-- 7 sword, 8 sword 2H, 10 staff, 13 fist, 14 misc, 15 dagger, 16 thrown, 18 crossbow, 19 wand, 20 fishing pole
-- armor sub classes: 0 misc, 1 cloth, 2 leather, 3 mail, 4 plate, 6 shield, 7 libram, 8 idol, 9 totem
local CAN_USE = {
    WARRIOR = { w = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 10, 13, 14, 15, 16, 18, 20 }, a = { 1, 2, 3, 4, 6 } },
    PALADIN = { w = { 0, 1, 4, 5, 6, 7, 8, 14, 20 }, a = { 1, 2, 3, 4, 6, 7 } },
    HUNTER  = { w = { 0, 1, 2, 3, 6, 7, 8, 10, 13, 14, 15, 16, 18, 20 }, a = { 1, 2, 3 } },
    ROGUE   = { w = { 2, 3, 4, 7, 13, 14, 15, 16, 18, 20 }, a = { 1, 2 } },
    PRIEST  = { w = { 4, 10, 14, 15, 19, 20 }, a = { 1 } },
    SHAMAN  = { w = { 0, 1, 4, 5, 10, 13, 14, 15, 20 }, a = { 1, 2, 3, 6, 9 } },
    MAGE    = { w = { 7, 10, 14, 15, 19, 20 }, a = { 1 } },
    WARLOCK = { w = { 7, 10, 14, 15, 19, 20 }, a = { 1 } },
    DRUID   = { w = { 4, 5, 10, 13, 14, 15, 20 }, a = { 1, 2, 8 } },
}
local HEAVY_LEVEL = 40 -- mail (hunter, shaman) and plate (warrior, paladin)

local sets
local function Sets()
    if sets then return sets end
    sets = {}
    for cls, t in pairs(CAN_USE) do
        sets[cls] = { w = {}, a = {} }
        for _, v in ipairs(t.w) do sets[cls].w[v] = true end
        for _, v in ipairs(t.a) do sets[cls].a[v] = true end
    end
    return sets
end

function LF.IsRecipe(id)
    local _, _, _, _, _, classID = GetInfoInstant(id)
    return classID == RECIPE
end

function LF.ClassCanUse(id)
    local _, _, _, equipLoc, _, classID, subClassID = GetInfoInstant(id)
    local _, cls = UnitClass("player")
    local s = Sets()[cls]
    if not s or not classID then return true end
    if classID == WEAPON then return s.w[subClassID] or false end
    if classID == ARMOR then
        if subClassID == 0 or equipLoc == "INVTYPE_CLOAK" then return true end
        if not s.a[subClassID] then return false end
        local heavy = (subClassID == 4) or (subClassID == 3 and (cls == "HUNTER" or cls == "SHAMAN"))
        if heavy and UnitLevel("player") < HEAVY_LEVEL then return false end
        return true
    end
    return true -- not equipment
end

-- stat filters: key, global label, extra words searched in the tooltip
LF.STATS = {
    { "STR", "ITEM_MOD_STRENGTH_SHORT", "Strength" },
    { "AGI", "ITEM_MOD_AGILITY_SHORT", "Agility" },
    { "STA", "ITEM_MOD_STAMINA_SHORT", "Stamina" },
    { "INT", "ITEM_MOD_INTELLECT_SHORT", "Intellect" },
    { "SPI", "ITEM_MOD_SPIRIT_SHORT", "Spirit" },
    { "AP", "ITEM_MOD_ATTACK_POWER_SHORT", "Attack Power", { "attack power", "puissance d'attaque" } },
    { "SP", "ITEM_MOD_SPELL_POWER_SHORT", "Spell Power", { "magical spells", "produits par les sorts", "spell power" } },
    { "HEAL", "ITEM_MOD_SPELL_HEALING_DONE_SHORT", "Healing", { "healing done", "soins prodigu" } },
    { "CRIT", "ITEM_MOD_CRIT_RATING_SHORT", "Critical Strike", { "critical strike", "coup critique" } },
    { "HIT", "ITEM_MOD_HIT_RATING_SHORT", "Hit", { "chance to hit", "chances de toucher" } },
    { "DEF", "ITEM_MOD_DEFENSE_SKILL_RATING_SHORT", "Defense", { "defense", "defense" } },
    { "MP5", "ITEM_MOD_POWER_REGEN0_SHORT", "Mana per 5 sec.", { "mana per 5", "mana toutes les 5", "mana every 5" } },
    { "ARMOR", "RESISTANCE0_NAME", "Armor" },
}
function LF.StatLabel(st) return _G[st[2]] or st[3] end

local tipCache = {}
local function TooltipText(id)
    if tipCache[id] then return tipCache[id] end
    local tip = DQF_ScanTip
    tip:SetOwner(UIParent, "ANCHOR_NONE")
    local ok = pcall(tip.SetHyperlink, tip, "item:" .. id)
    local parts = {}
    if ok then
        for i = 2, tip:NumLines() do
            local fs = _G["DQF_ScanTipTextLeft" .. i]
            local t = fs and fs:GetText()
            if t and not ns.IsSecret(t) then parts[#parts + 1] = t end
        end
    end
    tip:Hide()
    local text = W.Simplify(table.concat(parts, "\n"))
    if #parts > 0 then tipCache[id] = text end
    return text
end

local function HasStat(id, st)
    local _, link = ns.GetItemInfo(id)
    if not link then return nil end -- not loaded yet
    local stats = GetStats and GetStats(link)
    if stats and stats[st[2]] and stats[st[2]] ~= 0 then return true end
    local text = TooltipText(id)
    local label = W.Simplify(LF.StatLabel(st))
    if label ~= "" and text:find(label, 1, true) then return true end
    for _, word in ipairs(st[4] or {}) do
        if text:find(W.Simplify(word), 1, true) then return true end
    end
    return false
end

function LF:IsActive()
    local s = S()
    return s.enabled and (s.classOnly or s.minLevel or next(s.stats or {}) ~= nil) and true or false
end

-- Does the item pass the class / level / stat rules? (recipes handled apart)
function LF:Matches(id)
    local s = S()
    if not s.enabled then return true end
    if s.classOnly and not LF.ClassCanUse(id) then return false end
    if s.minLevel then
        local lvl = select(5, ns.GetItemInfo(id))
        if lvl and lvl < s.minLevel then return false end
    end
    local wanted = {}
    for _, st in ipairs(LF.STATS) do if s.stats and s.stats[st[1]] then wanted[#wanted + 1] = st end end
    if #wanted == 0 then return true end
    local any = false
    for _, st in ipairs(wanted) do
        local has = HasStat(id, st)
        if has == nil then return true end -- unknown for now: keep it
        if has then any = true elseif s.matchAll then return false end
    end
    return any
end

-- Loot shown on a boss page: everything except recipes (unless wanted)
function LF:PageLoot(list)
    if S().recipes then return list end
    local out = {}
    for _, id in ipairs(list or {}) do if not LF.IsRecipe(id) then out[#out + 1] = id end end
    return out
end

-- Every boss that drops a matching item: { {d, entry, items}, ... }
function LF:Results()
    local out = {}
    for _, key in ipairs(ns.dungeonOrder) do
        local d = ns.dungeons[key]
        if d.bossInfo then
            for _, e in ipairs(ns.JournalBosses.Entries(d)) do
                local items = {}
                for _, id in ipairs(self:PageLoot(e.trash and d.bossInfo.trash or e.boss.loot)) do
                    if self:Matches(id) then items[#items + 1] = id end
                end
                if #items > 0 then out[#out + 1] = { d = d, entry = e, items = items } end
            end
        end
    end
    return out
end

----------------------------------------------------------------------
-- Window
----------------------------------------------------------------------
local function Check(parent, x, y, label, get, set, width)
    local c
    if ns.BLIZZ then
        c = ns.Skin.Check(parent, 16)
        c:SetPoint("TOPLEFT", x - 4, y + 4)
    else
        c = ns.Panel(parent, "bg", "CheckButton", true)
        c:SetSize(16, 16)
        c:SetPoint("TOPLEFT", x, y)
        c:SetBackdropColor(0, 0, 0, 0.6)
        c:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
        c:SetHighlightTexture("Interface\\Buttons\\WHITE8X8")
        c:GetHighlightTexture():SetVertexColor(1, 1, 1, 0.15)
    end
    c.label = c:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    c.label:SetPoint("LEFT", c, "RIGHT", 6, 0)
    c.label:SetWidth(width or 260); c.label:SetJustifyH("LEFT"); c.label:SetWordWrap(false)
    c:SetHitRectInsets(0, -(width or 260), -2, -2)
    c.get, c.set, c.labelFn = get, set, label
    c:SetScript("OnClick", function(s)
        PlaySound(s:GetChecked() and 856 or 857)
        s.set(s:GetChecked() and true or false)
        LF:Changed()
    end)
    function c:Sync() self:SetChecked(self.get()); self.label:SetText(self.labelFn()) end
    return c
end

function LF:Build()
    local f = ns.Panel(UIParent)
    _G.DQF_LootFilter = f
    tinsert(UISpecialFrames, "DQF_LootFilter")
    f:SetSize(360, 450)
    f:SetFrameStrata("DIALOG")
    f:SetMovable(true); f:EnableMouse(true); f:SetClampedToScreen(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    local top
    if ns.BLIZZ then
        top = ns.Skin.Dialog(f) -- the game's dialog box
    else
        top = ns.Panel(f, "bar")
        top:SetPoint("TOPLEFT", 4, -4); top:SetPoint("TOPRIGHT", -4, -4); top:SetHeight(30)
        top.title = top:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        top.title:SetPoint("LEFT", 10, 0)
        local close = CreateFrame("Button", nil, top, "UIPanelCloseButton")
        close:SetPoint("RIGHT", -2, 0)
        close:SetScript("OnClick", function() f:Hide() end)
    end
    self.top = top

    local s = S
    self.checks = {}
    local y = -46
    local function Add(c) self.checks[#self.checks + 1] = c; return c end
    Add(Check(f, 14, y, function() return "|cffffd100" .. L("Activer le filtre", "Enable the filter") .. "|r" end,
        function() return s().enabled end, function(v) s().enabled = v end))
    y = y - 26
    Add(Check(f, 14, y, function() return L("Afficher les recettes / patrons", "Show recipes / patterns") end,
        function() return s().recipes end, function(v) s().recipes = v end))
    y = y - 22
    Add(Check(f, 14, y, function() return L("Seulement ce que ma classe peut utiliser", "Only loot my class can use") end,
        function() return s().classOnly end, function(v) s().classOnly = v end))
    y = y - 28

    local lvl = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    lvl:SetPoint("TOPLEFT", 16, y - 3)
    self.levelLabel = lvl
    local box
    if ns.BLIZZ then
        box = ns.Skin.EditBox(f, 36, 20)
        box:SetPoint("LEFT", lvl, "RIGHT", 12, 0)
    else
        box = ns.Panel(f, "bg", "EditBox", true)
        box:SetSize(44, 20)
        box:SetPoint("LEFT", lvl, "RIGHT", 8, 0)
        box:SetFontObject("GameFontHighlightSmall")
        box:SetTextInsets(6, 6, 0, 0)
    end
    box:SetAutoFocus(false); box:SetNumeric(true); box:SetMaxLetters(2)
    box:SetScript("OnEnterPressed", function(b) b:ClearFocus() end)
    box:SetScript("OnEscapePressed", function(b) b:ClearFocus() end)
    box:SetScript("OnTextChanged", function(b, user)
        if not user then return end
        local v = tonumber(b:GetText())
        s().minLevel = (v and v > 0) and v or nil
        LF:Changed()
    end)
    self.levelBox = box
    y = y - 32

    self.statsTitle = W.Heading(f, "")
    self.statsTitle:SetPoint("TOPLEFT", 14, y)
    self.statsTitle.line:SetWidth(330)
    y = y - 22
    for i, st in ipairs(LF.STATS) do
        local col, row = (i - 1) % 2, math.floor((i - 1) / 2)
        Add(Check(f, 14 + col * 170, y - row * 22, function() return LF.StatLabel(st) end,
            function() return s().stats and s().stats[st[1]] end,
            function(v) s().stats = s().stats or {}; s().stats[st[1]] = v or nil end, 140))
    end
    y = y - math.ceil(#LF.STATS / 2) * 22 - 4
    Add(Check(f, 14, y, function() return L("Toutes les stats cochées (sinon : au moins une)", "All ticked stats (otherwise: at least one)") end,
        function() return s().matchAll end, function(v) s().matchAll = v end))

    local clear = W.Button(f, "", 100, 24, function()
        local t = s()
        t.classOnly, t.minLevel, t.stats, t.matchAll = false, nil, {}, false
        LF:Sync(); LF:Changed()
    end)
    clear:SetPoint("BOTTOMLEFT", 12, 12)
    local show = W.Button(f, "", 150, 24, function()
        s().enabled = true
        LF:Sync(); LF:Changed()
        J:ShowResults("loot")
    end)
    show:SetPoint("BOTTOMRIGHT", -12, 12)
    self.clearBtn, self.showBtn = clear, show
    f:SetScript("OnShow", function() LF:Sync() end)
    f:Hide()
    self.frame = f
end

function LF:Sync()
    local f = self.frame
    if not f then return end
    self.top.title:SetText(L("Filtre de butin", "Loot filter"))
    for _, c in ipairs(self.checks) do c:Sync() end
    self.levelLabel:SetText(L("Niveau requis minimum :", "Minimum required level:"))
    self.levelBox:SetText(S().minLevel and tostring(S().minLevel) or "")
    self.statsTitle:SetText(L("Statistiques", "Stats"))
    self.clearBtn:SetLabel(L("Effacer", "Clear"))
    self.showBtn:SetLabel(L("Afficher les boss", "Show the bosses"))
end

-- A setting changed: refresh the journal pages that use the filter
function LF:Changed()
    if J.frame and J.frame:IsShown() then
        local page = J.current and J.pages[J.current]
        if page and page.Refresh then page:Refresh() end
        if J.current == "home" then J.pages.home:Refresh() end
    end
end

function LF:Toggle()
    if not self.frame then self:Build() end
    local f = self.frame
    if f:IsShown() then f:Hide() return end
    f:ClearAllPoints()
    if J.frame and J.frame:IsShown() then
        f:SetPoint("TOPLEFT", J.frame, "TOPRIGHT", 6, 0)
    else
        f:SetPoint("CENTER")
    end
    f:Show()
end
