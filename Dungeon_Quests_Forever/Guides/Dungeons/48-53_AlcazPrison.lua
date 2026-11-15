local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, D = ns.Accept, ns.TurnIn, ns.Do

-- ===================================================================
-- Alcaz Prison (48-53) - WoW Forever, Alcaz Island, Dustwallow Marsh
-- New Forever dungeon. Quests, chains, bosses and loot from
-- DungeonJournal 2.0.4 (Wowhead Forever and players, Nov 2026).
-- NPC IDs are unknown (id = 0): the coordinates come from the journal.
-- ===================================================================

-- NPCs (map = uiMapID; forever = coordinates from DungeonJournal, kept as they are)
N.ql_archmage_lan_dalock = { id = 0, name = "Archmage Lan'dalock", map = 1416, x = 15.4, y = 73.8, forever = true }
N.ql_commander_folkar = { id = 0, name = "Commander Folkar" }
N.ql_loose_floorboard = { id = 0, name = "Loose Floorboard", map = 1436, x = 43.4, y = 67.8, forever = true }
N.ql_mason_connery = { id = 0, name = "Mason Connery" }
N.ql_mathias_shaw = { id = 0, name = "Mathias Shaw", map = 1453, x = 75.8, y = 59.8, forever = true }
N.ql_nazeer_bloodspike = { id = 0, name = "Nazeer Bloodspike", map = 1445, x = 36.0, y = 31.0, forever = true }
N.ql_perfumed_note = { id = 0, name = "Perfumed Note" }
N.ql_sergeant_ulka = { id = 0, name = "Sergeant Ulka", map = 1445, x = 70.2, y = 18.8, forever = true }
N.ql_sully_mccleary = { id = 0, name = "Sully McCleary", map = 1445, x = 66.2, y = 45.2, forever = true }

ns:RegisterDungeon("ALCAZ", function() return {
    name = L("Prison d'Alcaz", "Alcaz Prison"),
    levels = "48-53",
    new = true, -- new in Forever
    icon = "Interface\\Icons\\INV_Misc_Key_14",
    entrance = { map = 1445, x = 75.3, y = 14.1 },
    titles = {
        [96772] = L("The Dragon's Journal", "The Dragon's Journal"),
        [95283] = L("The Missing Kor'kron", "The Missing Kor'kron"),
        [95284] = L("The Elite of the Elite", "The Elite of the Elite"),
        [95285] = L("Right Place, Wrong Time", "Right Place, Wrong Time"),
        [95309] = L("No Orc Left Behind", "No Orc Left Behind"),
        [95454] = L("The Honor of the Kor'kron", "The Honor of the Kor'kron"),
        [96369] = L("Bad News for Folkar", "Bad News for Folkar"),
        [95483] = L("Thrall Needs to Know", "Thrall Needs to Know"),
        [96334] = L("Blood Red Bandanas", "Blood Red Bandanas"),
        [96332] = L("A Little Payback", "A Little Payback"),
        [95194] = L("Our Man in Theramore", "Our Man in Theramore"),
        [95196] = L("Watch Yer Back", "Watch Yer Back"),
        [95198] = L("The Return of the King?", "The Return of the King?"),
        [95262] = L("The Secret Prison", "The Secret Prison"),
        [95263] = L("Somber News", "Somber News"),
        [96381] = L("A Bit of Wet Work", "A Bit of Wet Work"),
        [96335] = L("The Man in the Iron Chains", "The Man in the Iron Chains"),
        [96337] = L("More Valuable Than Gold", "More Valuable Than Gold"),
    },
    steps = {
        -- Quests to pick up before the dungeon (and their pre-quests)
        A(96772, "ql_archmage_lan_dalock", { faction = "Alliance" }),
        A(95283, "att_eitrigg", { faction = "Horde" }),
        T(95283, "ql_nazeer_bloodspike", { faction = "Horde" }),
        A(95284, "ql_nazeer_bloodspike", { faction = "Horde" }),
        D(95284, L("Find the missing Kor'kron Elites.", "Find the missing Kor'kron Elites."), { faction = "Horde", map = 1445, x = 36.0, y = 31.0 }),
        T(95284, "ql_sergeant_ulka", { faction = "Horde" }),
        A(95285, "ql_sergeant_ulka", { faction = "Horde" }),
        T(95285, "ql_sergeant_ulka", { faction = "Horde" }),
        A(95309, "ql_sergeant_ulka", { faction = "Horde" }),
        D(95309, L("Find Commander Folkar inside Alcaz Prison.", "Find Commander Folkar inside Alcaz Prison."), { faction = "Horde", map = 1445, x = 70.2, y = 18.8 }),
        T(95309, "ql_commander_folkar", { faction = "Horde", text = L("Commander Folkar, inside Alcaz Prison", "Commander Folkar, inside Alcaz Prison") }),
        A(95454, nil, { faction = "Horde", text = L("Commander Folkar, inside Alcaz Prison", "Commander Folkar, inside Alcaz Prison") }),
        D(95454, L("Look for King Varian Wrynn in Alcaz Prison.", "Look for King Varian Wrynn in Alcaz Prison."), { faction = "Horde" }),
        T(95454, "ql_perfumed_note", { faction = "Horde", text = L("Perfumed Note, after Blazeroar, inside Alcaz Prison", "Perfumed Note, after Blazeroar, inside Alcaz Prison") }),
        A(96369, nil, { faction = "Horde", text = L("Perfumed Note, after Blazeroar, inside Alcaz Prison", "Perfumed Note, after Blazeroar, inside Alcaz Prison") }),
        D(96369, L("Tell Commander Folkar what you found.", "Tell Commander Folkar what you found."), { faction = "Horde" }),
        T(96369, "ql_commander_folkar", { faction = "Horde", text = L("Commander Folkar, inside Alcaz Prison", "Commander Folkar, inside Alcaz Prison") }),
        A(95483, nil, { faction = "Horde", text = L("Commander Folkar, inside Alcaz Prison", "Commander Folkar, inside Alcaz Prison") }),
        A(96334, "ql_sergeant_ulka", { faction = "Horde" }),
        A(96332, "ql_sergeant_ulka", { faction = "Horde" }),
        A(95194, "ql_mathias_shaw", { faction = "Alliance" }),
        T(95194, "ql_sully_mccleary", { faction = "Alliance" }),
        A(95196, "ql_sully_mccleary", { faction = "Alliance" }),
        T(95196, "ql_sully_mccleary", { faction = "Alliance" }),
        A(95198, "ql_sully_mccleary", { faction = "Alliance" }),
        D(95198, L("Use the SI:7 Disguise Kit to eavesdrop on Jaina and her inner circle at the Theramore Mage Tower.", "Use the SI:7 Disguise Kit to eavesdrop on Jaina and her inner circle at the Theramore Mage Tower."), { faction = "Alliance", map = 1445, x = 63.4, y = 42.4 }),
        T(95198, "ql_sully_mccleary", { faction = "Alliance" }),
        A(95262, "ql_sully_mccleary", { faction = "Alliance" }),
        D(95262, L("Enter Alcaz Prison and learn what became of the King of Stormwind.", "Enter Alcaz Prison and learn what became of the King of Stormwind."), { faction = "Alliance", map = 1445, x = 66.2, y = 45.2 }),
        T(95262, nil, { faction = "Alliance", text = L("Inside Alcaz Prison (who takes it is not known yet)", "Inside Alcaz Prison (who takes it is not known yet)") }),
        A(95263, nil, { faction = "Alliance", text = L("Inside Alcaz Prison, once you learn what became of King Varian Wrynn", "Inside Alcaz Prison, once you learn what became of King Varian Wrynn") }),
        A(96381, "ql_sully_mccleary", { faction = "Alliance" }),
        A(96335, nil, { text = L("Mason Connery, the man in iron chains, inside Alcaz Prison", "Mason Connery, the man in iron chains, inside Alcaz Prison") }),
        D(96335, L("Recover the Alcaz Shackle Key from The Questioner in Alcaz Prison.", "Recover the Alcaz Shackle Key from The Questioner in Alcaz Prison.")),
        T(96335, "ql_mason_connery", { text = L("Mason Connery, inside Alcaz Prison", "Mason Connery, inside Alcaz Prison") }),
        A(96337, nil, { text = L("Mason Connery, inside Alcaz Prison, once you free him", "Mason Connery, inside Alcaz Prison, once you free him") }),
        -- Inside the dungeon
        D(96772, L("Recover Zarla's Journal from the depths of Alcaz Prison.", "Recover Zarla's Journal from the depths of Alcaz Prison."), { faction = "Alliance" }),
        D(95483, L("Bring word of Varian Wrynn's fate to Thrall in Orgrimmar.", "Bring word of Varian Wrynn's fate to Thrall in Orgrimmar."), { faction = "Horde" }),
        D(96334, L("Enter Alcaz Prison and collect 8 Blood Red Bandanas from the human guards there.", "Enter Alcaz Prison and collect 8 Blood Red Bandanas from the human guards there."), { faction = "Horde" }),
        D(96332, L("Enter the Alcaz Prison and slay 15 Strashaz Soldiers, 8 Strashaz Enchantresses, and bring the head of Tidemistress Ca'zass to Sergeant Ulka.", "Enter the Alcaz Prison and slay 15 Strashaz Soldiers, 8 Strashaz Enchantresses, and bring the head of Tidemistress Ca'zass to Sergeant Ulka."), { faction = "Horde" }),
        D(96381, L("Enter the Alcaz Prison and slay 15 Strashaz Soldiers, 8 Strashaz Enchantresses, and bring the head of Tidemistress Ca'zass to Sully McCleary.", "Enter the Alcaz Prison and slay 15 Strashaz Soldiers, 8 Strashaz Enchantresses, and bring the head of Tidemistress Ca'zass to Sully McCleary."), { faction = "Alliance" }),
        D(96337, L("Use the note provided by Mason Connery to find his hidden treasure.", "Use the note provided by Mason Connery to find his hidden treasure.")),
        -- Turn-ins
        T(96772, "ql_archmage_lan_dalock", { faction = "Alliance" }),
        T(95483, "n4949", { faction = "Horde" }),
        T(96334, "att_eitrigg", { faction = "Horde" }),
        T(96332, "ql_sergeant_ulka", { faction = "Horde" }),
        T(95263, "ql_sully_mccleary", { faction = "Alliance" }),
        T(96381, "ql_sully_mccleary", { faction = "Alliance" }),
        T(96337, "ql_loose_floorboard"),
    },
} end)
