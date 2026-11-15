local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, D = ns.Accept, ns.TurnIn, ns.Do

-- ===================================================================
-- Blackmaw Hold (55-60) - WoW Forever, Azshara
-- New Forever dungeon. Quests, chains, bosses and loot from
-- DungeonJournal 2.0.4 (Wowhead Forever and players, Nov 2026).
-- NPC IDs are unknown (id = 0): the coordinates come from the journal.
-- ===================================================================

-- NPCs (map = uiMapID; forever = coordinates from DungeonJournal, kept as they are)
N.ql_ekkal = { id = 0, name = "Ekkal", map = 1447, x = 41.8, y = 38.8, forever = true }
N.ql_gatekeeper_rageroar = { id = 0, name = "Gatekeeper Rageroar" }
N.ql_jediga = { id = 0, name = "Jediga", map = 1447, x = 22.5, y = 51.4, forever = true }
N.ql_lorekeeper_nok = { id = 0, name = "Lorekeeper Nok" }

ns:RegisterDungeon("NOIREG", function() return {
    name = L("Repaire des Noiregueules", "Blackmaw Hold"),
    levels = "55-60",
    new = true, -- new in Forever
    icon = "Interface\\Icons\\INV_Misc_MonsterClaw_04",
    entrance = { map = 1447, x = 38.6, y = 33.2 },
    titles = {
        [92346] = L("Beneath Nordrassil", "Beneath Nordrassil"),
        [92343] = L("Get to the Roots of It", "Get to the Roots of It"),
        [92345] = L("Beneath Nordrassil", "Beneath Nordrassil"),
        [92344] = L("Get to the Roots of It", "Get to the Roots of It"),
        [97173] = L("Blackmaw Magic", "Blackmaw Magic"),
        [97198] = L("Blackmaw Magic", "Blackmaw Magic"),
        [92069] = L("Claws That Rend, Tusks that Gore", "Claws That Rend, Tusks that Gore"),
        [92070] = L("A Lost Memento", "A Lost Memento"),
        [97327] = L("Blackmaw Pouches", "Blackmaw Pouches"),
        [92066] = L("The Twin Bears", "The Twin Bears"),
        [92065] = L("Blackmaw Reclamation", "Blackmaw Reclamation"),
        [96246] = L("Blackmaw Pouches", "Blackmaw Pouches"),
        [92067] = L("Feeding Time!", "Feeding Time!"),
    },
    steps = {
        -- Quests to pick up before the dungeon (and their pre-quests)
        A(92346, "ql_jediga", { faction = "Horde" }),
        T(92346, "nara", { faction = "Horde" }),
        A(92343, "nara", { faction = "Horde" }),
        A(92345, nil, { faction = "Alliance", text = L("Southern Azshara (giver not known yet)", "Southern Azshara (giver not known yet)") }),
        T(92345, "mathrengyl", { faction = "Alliance" }),
        A(92344, "mathrengyl", { faction = "Alliance" }),
        A(97173, nil, { faction = "Alliance", text = L("Not known yet (probably a mage in Dalaran)", "Not known yet (probably a mage in Dalaran)") }),
        A(97198, nil, { faction = "Horde", text = L("Not known yet (perhaps Alaana Stormwalker, Mulgore)", "Not known yet (perhaps Alaana Stormwalker, Mulgore)") }),
        A(92069, "qu_ogtinc"),
        A(92070, nil, { onlyIfStarted = true, text = L("Item start: Feathered Charm Necklace, looted in Blackmaw Hold", "Item start: Feathered Charm Necklace, looted in Blackmaw Hold") }),
        A(97327, "ql_ekkal"),
        A(92066, "ql_lorekeeper_nok", { text = L("Lorekeeper Nok, Ursolan (probably; he takes the totems)", "Lorekeeper Nok, Ursolan (probably; he takes the totems)") }),
        A(92065, "ql_gatekeeper_rageroar", { text = L("Gatekeeper Rageroar, Ursolan (probably; he takes the head)", "Gatekeeper Rageroar, Ursolan (probably; he takes the head)") }),
        A(96246, "ql_ekkal"),
        A(92067, nil, { text = L("Not known yet", "Not known yet") }),
        -- Inside the dungeon
        D(92343, L("Collect 10 Nordrassil Root Caps in Blackmaw Hold.", "Collect 10 Nordrassil Root Caps in Blackmaw Hold."), { faction = "Horde" }),
        D(92344, L("Collect 10 Nordrassil Root Caps in Blackmaw Hold.", "Collect 10 Nordrassil Root Caps in Blackmaw Hold."), { faction = "Alliance" }),
        D(97173, L("Obtain a Blackmaw Ritual Totem from Elder Shaman Bloodmane in Blackmaw Hold.", "Obtain a Blackmaw Ritual Totem from Elder Shaman Bloodmane in Blackmaw Hold."), { faction = "Alliance" }),
        D(97198, L("Obtain a Blackmaw Ritual Totem from Elder Shaman Bloodmane in Blackmaw Hold.", "Obtain a Blackmaw Ritual Totem from Elder Shaman Bloodmane in Blackmaw Hold."), { faction = "Horde" }),
        D(92070, L("Find the owner of the Feathered Charm Necklace.", "Find the owner of the Feathered Charm Necklace.")),
        D(97327, L("Enter Blackmaw Hold and recover 5 Blackmaw Pouches for Ekkal at the Ruins of Eldarath in Azshara.", "Enter Blackmaw Hold and recover 5 Blackmaw Pouches for Ekkal at the Ruins of Eldarath in Azshara.")),
        D(92066, L("Find the Totem of Ursoc and the Totem of Ursol inside Blackmaw Hold. Then, return them to Lorekeeper Nok at Ursolan.", "Find the Totem of Ursoc and the Totem of Ursol inside Blackmaw Hold. Then, return them to Lorekeeper Nok at Ursolan.")),
        D(92065, L("Bring Varrox Bleakhoof's Head to Gatekeeper Rageroar at Ursolan.", "Bring Varrox Bleakhoof's Head to Gatekeeper Rageroar at Ursolan.")),
        D(96246, L("Enter Blackmaw Hold and recover 5 Blackmaw Pouches for Ekkal at the Ruins of Eldarath in Azshara.", "Enter Blackmaw Hold and recover 5 Blackmaw Pouches for Ekkal at the Ruins of Eldarath in Azshara.")),
        D(92067, L("Bring Fel-Tainted Flesh.", "Bring Fel-Tainted Flesh.")),
        -- Turn-ins
        T(92343, "nara", { faction = "Horde" }),
        T(92344, "mathrengyl", { faction = "Alliance" }),
        T(97173, nil, { faction = "Alliance", text = L("Not known yet", "Not known yet") }),
        T(97198, nil, { faction = "Horde", text = L("Not known yet", "Not known yet") }),
        T(92069, "qu_ogtinc"),
        T(92070, nil, { text = L("The necklace's original Blackmaw owner (location not yet confirmed)", "The necklace's original Blackmaw owner (location not yet confirmed)") }),
        T(97327, "ql_ekkal"),
        T(92066, "ql_lorekeeper_nok", { text = L("Lorekeeper Nok, Ursolan", "Lorekeeper Nok, Ursolan") }),
        T(92065, "ql_gatekeeper_rageroar", { text = L("Gatekeeper Rageroar, Ursolan", "Gatekeeper Rageroar, Ursolan") }),
        T(96246, "ql_ekkal"),
        T(92067, nil, { text = L("Not known yet", "Not known yet") }),
    },
} end)
