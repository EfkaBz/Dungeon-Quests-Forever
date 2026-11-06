local _, ns = ...
local L = ns.L
local W = ns.Widgets
local J = ns.Journal
local QI = ns.QuestInfo
local R = {}

-- Results page: global search (dungeons, bosses, items, quests) and the
-- loot filter results (every boss dropping a matching item).

local MAX_PER_KIND = 60

local function CreateRow(parent)
    local r = W.Row(parent, 30)
    r.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    r:SetScript("OnClick", function(self, btn)
        if btn == "RightButton" then J:Back() return end
        if self.onClick then self.onClick(self) end
    end)
    return r
end

function R:Build(f)
    local area = W.ScrollArea(f)
    area:SetPoint("TOPLEFT"); area:SetPoint("BOTTOMRIGHT")
    if ns.BLIZZ then ns.Skin.ListBox(area, 4) end
    W.OnResize(area, function() if f:IsShown() then R:Refresh() end end)
    self.area = area
    self.flow = W.Flow(area, 12)
    self.rows = W.Pool(function() return CreateRow(area.child) end)
end

function R:Show(_, arg)
    self.arg = arg or {}
    self.area:ScrollToTop()
    self:Refresh()
end

function R:Layout() end

-- Places a clickable row (icon, text, sub text) in the flow
function R:AddRow(icon, text, sub, onClick, isPortraitBoss)
    local r = self.rows:Get()
    r:SetWidth(self.flow:Width())
    if isPortraitBoss then
        ns.JournalBosses.SetPortrait(r.icon, isPortraitBoss, icon)
    else
        r.icon:SetTexture(icon)
        r.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    end
    r.main:SetText(text)
    r.sub:SetText(sub or "")
    r.onClick = onClick
    r:SetSelected(false)
    self.flow:Place(r, 32)
end

local function Has(text, q) return text and W.Simplify(text):find(q, 1, true) ~= nil end

function R:Refresh()
    local flow = self.flow
    flow:Clear()
    self.rows:ReleaseAll()
    if self.arg.kind == "loot" then self:ShowLoot() else self:ShowSearch(self.arg.query or "") end
    flow:Finish()
end

function R:ShowSearch(query)
    local flow, q = self.flow, W.Simplify(strtrim(query))
    flow:Text(L("Résultats pour « ", "Results for \"") .. query .. L(" »", "\""), { font = "GameFontNormalLarge", gap = 8 })
    if #q < 2 then
        flow:Text(L("Tape au moins 2 lettres.", "Type at least 2 letters."), { font = "GameFontDisable" })
        return
    end
    local found = 0

    -- dungeons
    local dungeons = {}
    for _, key in ipairs(ns.dungeonOrder) do
        local d = ns.dungeons[key]
        if Has(d.name, q) or Has(key, q) then dungeons[#dungeons + 1] = d end
    end
    if #dungeons > 0 then
        flow:Heading(L("Donjons", "Dungeons"))
        for _, d in ipairs(dungeons) do
            self:AddRow(d.icon, d.name, L("Niveaux ", "Levels ") .. d.levels, function() J:ShowDungeon(d.key) end)
        end
        found = found + #dungeons
    end

    -- bosses and loot
    local bosses, items, seenItem = {}, {}, {}
    for _, key in ipairs(ns.dungeonOrder) do
        local d = ns.dungeons[key]
        if d.bossInfo then
            for _, e in ipairs(ns.JournalBosses.Entries(d)) do
                local b = e.boss
                if b and (Has(ns.BossName(b), q) or Has(b.name, q)) and #bosses < MAX_PER_KIND then
                    bosses[#bosses + 1] = { d = d, e = e }
                end
                for _, id in ipairs(ns.LootFilter:PageLoot(e.trash and d.bossInfo.trash or b.loot)) do
                    if not seenItem[id] and #items < MAX_PER_KIND then
                        local name = ns.Items.Info(id)
                        if name and Has(name, q) then
                            seenItem[id] = true
                            local who = e.trash and L("Monstres", "Trash") or ns.BossName(b)
                            items[#items + 1] = { id, {
                                sub = who .. " - " .. d.name,
                                source = L("Butin : ", "Drop: ") .. who .. " (" .. d.name .. ")",
                                dim = not ns.LootFilter:Matches(id),
                                onClick = function() J:ShowDungeon(d.key, "bosses", { boss = e.index, item = id }) end,
                            } }
                        end
                    end
                end
            end
        end
    end
    if #bosses > 0 then
        flow:Heading(L("Boss", "Bosses"))
        for _, r in ipairs(bosses) do
            local b = r.e.boss
            self:AddRow(r.d.icon, ns.BossName(b), r.d.name .. (b.level and ("  -  " .. L("Niv. ", "Lv ") .. b.level) or ""),
                function() J:ShowDungeon(r.d.key, "bosses", r.e.index) end, b)
        end
        found = found + #bosses
    end

    -- quests and their reward items
    local quests, seenQ = {}, {}
    for _, key in ipairs(ns.dungeonOrder) do
        local d = ns.dungeons[key]
        for _, e in ipairs(QI.DungeonQuests(d)) do
            if not seenQ[e.quest] then
                seenQ[e.quest] = true
                local title = QI.Title(e.quest, d)
                if (Has(title, q) or tostring(e.quest) == q) and #quests < MAX_PER_KIND then
                    quests[#quests + 1] = { d = d, q = e.quest, title = title }
                end
                local rw = DQF_Cache.rewards[e.quest]
                local ids = rw and {} or (ns.QUEST_REWARDS and ns.QUEST_REWARDS[e.quest]) or {}
                if rw then
                    for _, id in ipairs(rw.items or {}) do ids[#ids + 1] = id end
                    for _, id in ipairs(rw.choice or {}) do ids[#ids + 1] = id end
                end
                for _, id in ipairs(ids) do
                    if not seenItem[id] and #items < MAX_PER_KIND then
                        local name = ns.Items.Info(id)
                        if name and Has(name, q) then
                            seenItem[id] = true
                            items[#items + 1] = { id, {
                                sub = L("Récompense : ", "Reward: ") .. title,
                                source = L("Récompense de : ", "Reward from: ") .. title .. " (" .. d.name .. ")",
                                onClick = function() J:ShowDungeon(d.key, "quests", e.quest) end,
                            } }
                        end
                    end
                end
            end
        end
    end
    if #items > 0 then
        flow:Heading(L("Objets", "Items"))
        flow:Items(items)
        found = found + #items
    end
    if #quests > 0 then
        flow:Heading(L("Quêtes", "Quests"))
        for _, r in ipairs(quests) do
            local st = QI.State(r.q)
            self:AddRow(st == 3 and "Interface\\RaidFrame\\ReadyCheck-Ready" or "Interface\\GossipFrame\\AvailableQuestIcon",
                r.title, r.d.name, function() J:ShowDungeon(r.d.key, "quests", r.q) end)
        end
        found = found + #quests
    end
    if found == 0 then
        flow:Text(L("Aucun résultat. (Les noms d'objets se chargent depuis le serveur : réessaie dans un instant.)",
            "No result. (Item names load from the server: try again in a moment.)"), { font = "GameFontDisable" })
    end
end

function R:ShowLoot()
    local flow = self.flow
    flow:Text(L("Boss qui lâchent un objet correspondant au filtre", "Bosses dropping an item that matches the filter"),
        { font = "GameFontNormalLarge", gap = 4 })
    local results = ns.LootFilter:Results()
    local total = 0
    for _, r in ipairs(results) do total = total + #r.items end
    flow:Text(("%d %s, %d %s"):format(#results, L("boss", "bosses"), total, L("objets", "items")),
        { font = "GameFontHighlightSmall", color = { 0.8, 0.8, 0.8 }, gap = 6 })
    for _, r in ipairs(results) do
        local e, d = r.entry, r.d
        local who = e.trash and L("Butin des monstres", "Trash drops") or ns.BossName(e.boss)
        self:AddRow(d.icon, who, d.name .. "  -  " .. L("Niv. ", "Lv ") .. (e.boss and e.boss.level or d.levels),
            function() J:ShowDungeon(d.key, "bosses", e.index) end, e.boss)
        local list = {}
        for _, id in ipairs(r.items) do
            list[#list + 1] = { id, {
                source = L("Butin : ", "Drop: ") .. who .. " (" .. d.name .. ")",
                onClick = function() J:ShowDungeon(d.key, "bosses", { boss = e.index, item = id }) end,
            } }
        end
        flow:Items(list)
        flow:Space(6)
    end
    if #results == 0 then
        flow:Text(L("Aucun objet ne correspond. Modifie le filtre de butin.", "No item matches. Change the loot filter."),
            { font = "GameFontDisable" })
    end
end

J:AddPage("results", R)
