local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, D = ns.Accept, ns.TurnIn, ns.Do

-- ===================================================================
-- Shaper's Terrace (58-60) - WoW Forever, Un'Goro Crater
-- New Forever dungeon. Quests, chains, bosses and loot from
-- DungeonJournal 2.0.4 (Wowhead Forever and players, Nov 2026).
-- NPC IDs are unknown (id = 0): the coordinates come from the journal.
-- ===================================================================

-- NPCs (map = uiMapID; forever = coordinates from DungeonJournal, kept as they are)
N.ql_mayena_earthseeker = { id = 0, name = "Mayena Earthseeker", map = 1412, x = 34.8, y = 22.2, forever = true }

ns:RegisterDungeon("SHAPER", function() return {
    name = L("La terrasse du Façonneur", "Shaper's Terrace"),
    levels = "58-60",
    new = true, -- new in Forever
    icon = "Interface\\Icons\\INV_Misc_Gem_Crystal_02",
    entrance = { map = 1449, x = 48.1, y = 6.1 },
    titles = {
        [95928] = L("Crystalline Elements", "Crystalline Elements"),
        [97049] = L("Essence of Seeping Slimes", "Essence of Seeping Slimes"),
        [95926] = L("The Dark Crystal", "The Dark Crystal"),
        [95924] = L("Panic at the Digsite", "Panic at the Digsite"),
        [95925] = L("Mapping the Way Forward", "Mapping the Way Forward"),
        [95790] = L("Digestible Research", "Digestible Research"),
    },
    steps = {
        -- Quests to pick up before the dungeon (and their pre-quests)
        A(95928, "ql_mayena_earthseeker", { faction = "Horde" }),
        A(97049, nil, { faction = "Horde", text = L("Not known yet", "Not known yet") }),
        A(95926, nil, { faction = "Horde", text = L("Not known yet", "Not known yet") }),
        A(95924, nil, { faction = "Alliance", text = L("Not known yet", "Not known yet") }),
        A(95925, nil, { faction = "Alliance", text = L("Not known yet", "Not known yet") }),
        A(95790, nil, { faction = "Alliance", text = L("Not known yet", "Not known yet") }),
        -- Inside the dungeon
        D(95928, L("Bring Mayena Earthseeker a Moist Crystal, a Charged Crystal, a Noxious Crystal and a Fiery Crystal from Shaper's Terrace.", "Bring Mayena Earthseeker a Moist Crystal, a Charged Crystal, a Noxious Crystal and a Fiery Crystal from Shaper's Terrace."), { faction = "Horde" }),
        D(97049, L("Gather 8 Seeping Slime Essence in the Shaper's Terrace.", "Gather 8 Seeping Slime Essence in the Shaper's Terrace."), { faction = "Horde" }),
        D(95926, L("Gather a colorless Drained Crystal Fragment near the Achromatic Crystal in the Shaper's Terrace.", "Gather a colorless Drained Crystal Fragment near the Achromatic Crystal in the Shaper's Terrace."), { faction = "Horde" }),
        D(95924, L("Slay Venomridge, 6 Ravasaur Matriarchs and 8 Ironhide Ravasaurs in Shaper's Terrace.", "Slay Venomridge, 6 Ravasaur Matriarchs and 8 Ironhide Ravasaurs in Shaper's Terrace."), { faction = "Alliance" }),
        D(95925, L("Find Interesting Landmarks in Shaper's Terrace and fill out the explorer's map at each: the Pillar of Assimilation, the Achromatic Crystal, the Western Gates, the Regrowth Vestibule and the Unearthed Stone Watcher.", "Find Interesting Landmarks in Shaper's Terrace and fill out the explorer's map at each: the Pillar of Assimilation, the Achromatic Crystal, the Western Gates, the Regrowth Vestibule and the Unearthed Stone Watcher."), { faction = "Alliance" }),
        D(95790, L("Collect 15 Partially Digested Journal Pages in Shaper's Terrace.", "Collect 15 Partially Digested Journal Pages in Shaper's Terrace."), { faction = "Alliance" }),
        -- Turn-ins
        T(95928, "ql_mayena_earthseeker", { faction = "Horde" }),
        T(97049, nil, { faction = "Horde", text = L("Not known yet", "Not known yet") }),
        T(95926, nil, { faction = "Horde", text = L("Not known yet", "Not known yet") }),
        T(95924, nil, { faction = "Alliance", text = L("Not known yet", "Not known yet") }),
        T(95925, nil, { faction = "Alliance", text = L("Not known yet", "Not known yet") }),
        T(95790, nil, { faction = "Alliance", text = L("Not known yet", "Not known yet") }),
    },
} end)
