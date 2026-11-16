local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, D = ns.Accept, ns.TurnIn, ns.Do

-- ===================================================================
-- Krol'dok Stronghold (40-45) - WoW Forever, Riverglades
-- New Forever dungeon. Quests, chains, bosses and loot from
-- DungeonJournal 2.0.4 (Wowhead Forever and players, Nov 2026).
-- NPC IDs are unknown (id = 0): the coordinates come from the journal.
-- ===================================================================

-- NPCs (map = uiMapID; forever = coordinates from DungeonJournal, kept as they are)
N.ql_alphonse_dumas = { id = 0, name = "Alphonse Dumas", map = 2548, x = 64.4, y = 82.0, forever = true }
N.ql_ashe_amberhall = { id = 0, name = "Ashe Amberhall", map = 2548, x = 66.6, y = 81.0, forever = true }
N.ql_clugfist = { id = 0, name = "Clugfist", map = 2548, x = 64.4, y = 14.8, forever = true }
N.ql_crag_rog = { id = 0, name = "Crag'rog", map = 2548, x = 27.4, y = 37.0, forever = true }
N.ql_da_grosh = { id = 0, name = "Da'grosh", map = 2548, x = 33.4, y = 38.0, forever = true }
N.ql_demar_brant = { id = 0, name = "Demar Brant", map = 2548, x = 66.6, y = 81.0, forever = true }
N.ql_kreza_darkthorn = { id = 0, name = "Kreza Darkthorn", map = 2548, x = 59.8, y = 46.0, forever = true }
N.ql_krom_rosh = { id = 0, name = "Krom'rosh", map = 2548, x = 59.4, y = 45.6, forever = true }
N.ql_melanie_sable = { id = 0, name = "Melanie Sable", map = 2548, x = 66.2, y = 83.2, forever = true }
N.ql_ranath_nightstride = { id = 0, name = "Ranath Nightstride", map = 1416, x = 17.8, y = 66.0, forever = true }
N.ql_sergeant_riftan = { id = 0, name = "Sergeant Riftan", map = 2548, x = 30.6, y = 49.0, forever = true }
N.ql_tran_gul = { id = 0, name = "Tran'gul", map = 2548, x = 59.4, y = 44.0, forever = true }

ns:RegisterDungeon("KROLDOK", function() return {
    name = L("Bastion Krol'dok", "Krol'dok Stronghold"),
    levels = "40-45",
    new = true, -- new in Forever
    icon = "Interface\\Icons\\INV_Misc_Key_13",
    entrance = { map = 2548, x = 37.5, y = 37.3 },
    titles = {
        [94483] = L("Show Them How It's Done", "Show Them How It's Done"),
        [94672] = L("Encroaching Twilight", "Encroaching Twilight"),
        [95428] = L("Clugfist's Decree", "Clugfist's Decree"),
        [94744] = L("The Wayward Warrior", "The Wayward Warrior"),
        [94748] = L("Break Their Chains", "Break Their Chains"),
        [94745] = L("Carving a Path", "Carving a Path"),
        [95432] = L("Rise Up!", "Rise Up!"),
        [94768] = L("Bring Me His Head", "Bring Me His Head"),
        [95278] = L("It Is Time, Brother...", "It Is Time, Brother..."),
        [94968] = L("L'œil de Mugg", "Eye of Mugg"),
        [94972] = L("Tome du Crépuscule", "Tome of Twilight"),
        [94975] = L("Un gage de vengeance", "A Token of Vengeance"),
        [94879] = L("Chutes d'informations", "Scraps of Knowledge"),
        [94886] = L("The Western Front", "The Western Front"),
        [94888] = L("On n'abandonne personne", "No Soldier Left Behind"),
        [94889] = L("Tracer un chemin", "Carving a Path"),
        [94890] = L("Bring Me His Head", "Bring Me His Head"),
        [94891] = L("News to Farholde", "News to Farholde"),
        [94982] = L("Eye of Mugg", "Eye of Mugg"),
        [94983] = L("Souvenirs du Crépuscule", "Twilight Mementos"),
        [94881] = L("De curieux bijoux", "Curious Trinkets"),
        [94907] = L("Un petit service", "A Small Favor"),
        [94984] = L("Tome du Crépuscule", "Tome of Twilight"),
        [96771] = L("La vengeance des Bien-nés", "Vengeance of the Highborne"),
        [94980] = L("Krol'dok Moulding", "Krol'dok Moulding"),
        [94981] = L("Key Ingredients", "Key Ingredients"),
        [94973] = L("Krol'dok Moulding", "Krol'dok Moulding"),
        [94974] = L("Key Ingredients", "Key Ingredients"),
        [94877] = L("Sauver Clairsoleil", "Saving Sunnyglade"),
        [94997] = L("Lingering Essence", "Lingering Essence"),
        [94998] = L("Curios of Curiosity", "Curios of Curiosity"),
    },
    steps = {
        -- Quests to pick up before the dungeon (and their pre-quests)
        A(94483, "ql_krom_rosh", { faction = "Horde" }),
        D(94483, L("Slay 8 Farholde Priests and 12 Farholde Scouts south of the river.", "Slay 8 Farholde Priests and 12 Farholde Scouts south of the river."), { faction = "Horde" }),
        T(94483, "ql_krom_rosh", { faction = "Horde" }),
        A(94672, "ql_tran_gul", { faction = "Horde" }),
        D(94672, L("Defeat 8 Twilight Raiders, 8 Twilight Shadowmancers and 8 Twilight Neophytes within Sunnyglade for Tran'gul in Rog'mar.", "Defeat 8 Twilight Raiders, 8 Twilight Shadowmancers and 8 Twilight Neophytes within Sunnyglade for Tran'gul in Rog'mar."), { faction = "Horde", map = 2548, x = 59.4, y = 44.0 }),
        T(94672, "ql_tran_gul", { faction = "Horde" }),
        A(95428, "ql_clugfist", { faction = "Horde" }),
        T(95428, "ql_krom_rosh", { faction = "Horde" }),
        A(94744, "ql_krom_rosh", { faction = "Horde" }),
        D(94744, L("Find Da'grosh in the hills west of Rog'mar.", "Find Da'grosh in the hills west of Rog'mar."), { faction = "Horde", map = 2548, x = 59.4, y = 45.6 }),
        T(94744, "ql_da_grosh", { faction = "Horde" }),
        A(94748, "ql_da_grosh", { faction = "Horde" }),
        D(94748, L("Rescue 5 Rog'mar Scouts within the Twilight's Shroud for Da'grosh.", "Rescue 5 Rog'mar Scouts within the Twilight's Shroud for Da'grosh."), { faction = "Horde", map = 2548, x = 33.4, y = 38.0 }),
        T(94748, "ql_da_grosh", { faction = "Horde" }),
        A(94745, "ql_da_grosh", { faction = "Horde" }),
        D(94745, L("Defeat 8 Twilight Fanatics, 8 Twilight Corrupters and 8 Twilight Champions within the Twilight's Shroud for Da'grosh.", "Defeat 8 Twilight Fanatics, 8 Twilight Corrupters and 8 Twilight Champions within the Twilight's Shroud for Da'grosh."), { faction = "Horde", map = 2548, x = 33.4, y = 38.0 }),
        T(94745, "ql_da_grosh", { faction = "Horde" }),
        A(95432, "ql_crag_rog", { faction = "Horde" }),
        D(95432, L("Recruit 5 Ogre Miners.", "Recruit 5 Ogre Miners."), { faction = "Horde", map = 2548, x = 27.4, y = 37.0 }),
        T(95432, "ql_crag_rog", { faction = "Horde" }),
        A(94768, "ql_da_grosh", { faction = "Horde" }),
        D(94768, L("Defeat Overlord Kilgar within the Twilight's Shroud and bring his head to Da'grosh.", "Defeat Overlord Kilgar within the Twilight's Shroud and bring his head to Da'grosh."), { faction = "Horde", map = 2548, x = 33.4, y = 38.0 }),
        T(94768, "ql_da_grosh", { faction = "Horde" }),
        A(95278, "ql_da_grosh", { faction = "Horde" }),
        T(95278, "ql_krom_rosh", { faction = "Horde" }),
        A(94968, "ql_krom_rosh", { faction = "Horde" }),
        A(94972, "ql_tran_gul", { faction = "Horde" }),
        A(94975, "ql_da_grosh", { faction = "Horde" }),
        A(94879, "ql_ashe_amberhall", { faction = "Alliance" }),
        D(94879, L("Récupérez 5 pages du Crépuscule à Clairsoleil pour Ashe Ambrehall, au donjon de Fort-Lointain.", "Collect 5 Twilight Pages from within Sunnyglade for Ashe Amberhall in Farholde Keep."), { faction = "Alliance", map = 2548, x = 66.6, y = 81.0 }),
        T(94879, "ql_ashe_amberhall", { faction = "Alliance" }),
        A(94886, "ql_demar_brant", { faction = "Alliance" }),
        D(94886, L("Find Sergeant Riftan near the Twilight's Shroud to the west.", "Find Sergeant Riftan near the Twilight's Shroud to the west."), { faction = "Alliance", map = 2548, x = 66.6, y = 81.0 }),
        T(94886, "ql_sergeant_riftan", { faction = "Alliance" }),
        A(94888, "ql_sergeant_riftan", { faction = "Alliance" }),
        D(94888, L("Secourez 5 éclaireurs de Fort-Lointain au Suaire du Crépuscule pour le sergent Faillan.", "Rescue 5 Farholde Scouts within the Twilight's Shroud for Sergeant Riftan."), { faction = "Alliance", map = 2548, x = 30.6, y = 49.0 }),
        T(94888, "ql_sergeant_riftan", { faction = "Alliance" }),
        A(94889, "ql_sergeant_riftan", { faction = "Alliance" }),
        D(94889, L("Éliminez 8 fanatiques du Crépuscule, 8 corrupteurs du crépuscule et 8 champions du Crépuscule au Suaire du Crépuscule pour le sergent Faillan.", "Defeat 8 Twilight Fanatics, 8 Twilight Corrupters and 8 Twilight Champions within the Twilight's Shroud for Sergeant Riftan."), { faction = "Alliance", map = 2548, x = 30.6, y = 49.0 }),
        T(94889, "ql_sergeant_riftan", { faction = "Alliance" }),
        A(94890, "ql_sergeant_riftan", { faction = "Alliance" }),
        D(94890, L("Defeat Overlord Kilgar within the Twilight's Shroud and bring his head to Sergeant Riftan.", "Defeat Overlord Kilgar within the Twilight's Shroud and bring his head to Sergeant Riftan."), { faction = "Alliance", map = 2548, x = 30.6, y = 49.0 }),
        T(94890, "ql_sergeant_riftan", { faction = "Alliance" }),
        A(94891, nil, { faction = "Alliance", text = L("Given when you hand in Bring Me His Head to Sergeant Riftan", "Given when you hand in Bring Me His Head to Sergeant Riftan") }),
        T(94891, "ql_ashe_amberhall", { faction = "Alliance" }),
        A(94982, "ql_demar_brant", { faction = "Alliance" }),
        A(94983, "ql_sergeant_riftan", { faction = "Alliance" }),
        A(94881, "ql_ashe_amberhall", { faction = "Alliance" }),
        D(94881, L("Récupérez 25 charmes du Crépuscule sur les ténébromanciens du Crépuscule et sur les néophytes du Crépuscule à Clairsoleil pour Ashe Ambrehall, au donjon de Fort-Lointain.", "Retrieve 25 Twilight Charms from Twilight Shadowmancers and Twilight Neophytes in Sunnyglade for Ashe Amberhall in Farholde Keep."), { faction = "Alliance", map = 2548, x = 66.6, y = 81.0 }),
        T(94881, "ql_ashe_amberhall", { faction = "Alliance" }),
        A(94907, "ql_ashe_amberhall", { faction = "Alliance" }),
        D(94907, L("Invoquez un esclave du Crépuscule depuis un conduit du Suaire du Crépuscule et capturez-le à l'aide de la pierre d'âme d'Ambrehall.", "Summon a Twilight's Thrall from a conduit within the Twilight's Shroud and capture it with Amberhall's Soulstone."), { faction = "Alliance", map = 2548, x = 66.6, y = 81.0 }),
        T(94907, "ql_ashe_amberhall", { faction = "Alliance" }),
        A(94984, "ql_ashe_amberhall", { faction = "Alliance" }),
        A(96771, "ql_ranath_nightstride", { faction = "Alliance" }),
        A(94980, nil, { faction = "Alliance", text = L("Krol'dok Moulding, dropped by Tunk in Krol'dok Stronghold", "Krol'dok Moulding, dropped by Tunk in Krol'dok Stronghold") }),
        T(94980, "ql_alphonse_dumas", { faction = "Alliance" }),
        A(94981, "ql_alphonse_dumas", { faction = "Alliance", text = L("The key from this quest unlocks the upper side of the dungeon.", "The key from this quest unlocks the upper side of the dungeon.") }),
        A(94973, nil, { faction = "Horde", text = L("Krol'dok Moulding, dropped by Tunk in Krol'dok Stronghold", "Krol'dok Moulding, dropped by Tunk in Krol'dok Stronghold") }),
        T(94973, "ql_kreza_darkthorn", { faction = "Horde" }),
        A(94974, "ql_kreza_darkthorn", { faction = "Horde", text = L("The key from this quest unlocks the upper side of the dungeon.", "The key from this quest unlocks the upper side of the dungeon.") }),
        -- Inside the dungeon
        D(94968, L("Infiltrez-vous dans le bastion Krol'dok et retournez à Krom'rosh avec la preuve de la mort de son chef.", "Infiltrate Krol'dok Stronghold and return to Krom'rosh with proof of their leader's demise."), { faction = "Horde" }),
        D(94972, L("Récupérez le tome du Crépuscule au bastion Krol'dok.", "Recover the Tome of Twilight from Krol'dok Stronghold."), { faction = "Horde" }),
        D(94975, L("Récupérez 15 oreilles de sectateurs auprès du Marteau du crépuscule dans le bastion Krol'dok.", "Collect 15 Cultist Ears from the Twilight's Hammer in Krol'dok Stronghold."), { faction = "Horde" }),
        D(94982, L("Infiltrate Krol'dok Stronghold and return to Commander Brant with proof of their leader's demise.", "Infiltrate Krol'dok Stronghold and return to Commander Brant with proof of their leader's demise."), { faction = "Alliance" }),
        D(94983, L("Récupérez 8 bracelets de sectateurs auprès du Marteau du crépuscule dans le bastion Krol'dok.", "Collect 8 Twilight Bangles from the Twilight's Hammer in Krol'dok Stronghold."), { faction = "Alliance" }),
        D(94984, L("Tuez Nar'gurk au bastion Krol'dok et récupérez toute information de valeur.", "Kill Nar'gurk in Krol'dok Stronghold and recover any valuable information."), { faction = "Alliance" }),
        D(94981, L("Bring 4 Thick Leather and 12 Iron Bars to Alphonse Dumas.", "Bring 4 Thick Leather and 12 Iron Bars to Alphonse Dumas."), { faction = "Alliance" }),
        D(94974, L("Bring 4 Thick Leather and 12 Iron Bars to Kreza Darkthorn.", "Bring 4 Thick Leather and 12 Iron Bars to Kreza Darkthorn."), { faction = "Horde" }),
        -- Turn-ins
        T(94968, "ql_krom_rosh", { faction = "Horde" }),
        T(94972, "ql_tran_gul", { faction = "Horde" }),
        T(94975, "ql_da_grosh", { faction = "Horde" }),
        T(94982, "ql_demar_brant", { faction = "Alliance" }),
        T(94983, "ql_sergeant_riftan", { faction = "Alliance" }),
        T(94984, "ql_ashe_amberhall", { faction = "Alliance" }),
        T(96771, "ql_ranath_nightstride", { faction = "Alliance" }),
        T(94981, "ql_alphonse_dumas", { faction = "Alliance" }),
        T(94974, "ql_kreza_darkthorn", { faction = "Horde" }),
        -- Follow-up quests
        A(94877, "ql_demar_brant", { faction = "Alliance" }),
        D(94877, L("Terrassez 8 écumeurs du Crépuscule, 8 ténébromanciens du Crépuscule et 8 néophytes du Crépuscule à Clairsoleil, pour Demar Brant.", "Defeat 8 Twilight Raiders, 8 Twilight Shadowmancers and 8 Twilight Neophytes within Sunnyglade for Demar Brant."), { faction = "Alliance", map = 2548, x = 66.6, y = 81.0 }),
        T(94877, "ql_demar_brant", { faction = "Alliance" }),
        A(94997, "ql_sergeant_riftan", { faction = "Alliance" }),
        T(94997, "ql_ashe_amberhall", { faction = "Alliance" }),
        A(94998, "ql_ashe_amberhall", { faction = "Alliance" }),
        T(94998, "ql_melanie_sable", { faction = "Alliance" }),
    },
} end)
