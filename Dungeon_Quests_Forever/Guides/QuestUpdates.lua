local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, D = ns.Accept, ns.TurnIn, ns.Do

-- ===================================================================
-- Quests and quest chains added after the guides were written (source:
-- DungeonJournal 1.6.6 and the Questie classic DB). Steps are merged into
-- each dungeon by ns:AddGuideSteps (Core.lua):
--   class         = only shown to that class
--   onlyIfStarted = quest started by a random drop: only shown once started
-- Not listed: profession quests and repeatable turn-ins.
-- ===================================================================

-- NPCs (forever = coordinates taken on the Forever client, kept as they are)
N.qu_ancient_equine_spirit = { id = 14566, name = "Ancient Equine Spirit" }
N.qu_archmage_xylem = { id = 8379, name = "Archmage Xylem", map = 1447, x = 29.2, y = 40.2, forever = true }
N.qu_aurora_skycaller = { id = 10304, name = "Aurora Skycaller", map = 1423, x = 47.5, y = 16.8, forever = true }
N.qu_bath_rah_the_windwatcher = { id = 6176, name = "Bath'rah the Windwatcher", map = 1416, x = 80.4, y = 66.8, forever = true }
N.qu_beram_skychaser = { id = 3032, name = "Beram Skychaser", map = 1456, x = 22.2, y = 19, forever = true }
N.qu_brother_crowley = { id = 12336, name = "Brother Crowley", map = 1453, x = 52.6, y = 43.2, forever = true }
N.qu_commander_ashlam_valorfist = { id = 10838, name = "Commander Ashlam Valorfist", map = 1422, x = 42.8, y = 84, forever = true }
N.qu_daphne_stilwell = { id = 6182, name = "Daphne Stilwell", map = 1436, x = 42.2, y = 88.6, forever = true }
N.qu_darkreaver_s_fallen_charger = { id = 14568, name = "Darkreaver's Fallen Charger" }
N.qu_daryn_lightwind = { id = 7907, name = "Daryn Lightwind", map = 1438, x = 55.4, y = 92.2, forever = true }
N.qu_doan_karhan = { id = 6247, name = "Doan Karhan", map = 1413, x = 49.3, y = 57.2, forever = true }
N.qu_dreadsteed_spirit = { id = 14504, name = "Dreadsteed Spirit" }
N.qu_duthorian_rall = { id = 6171, name = "Duthorian Rall", map = 1453, x = 50.5, y = 47.5, forever = true }
N.qu_fallen_hero_of_the_horde = { id = 7572, name = "Fallen Hero of the Horde", map = 1435, x = 34.2, y = 66, forever = true }
N.qu_first_mate_fitzsimmons = { id = 1239, name = "First Mate Fitzsimmons", map = 1437, x = 10.8, y = 59.6, forever = true }
N.qu_gorzeeki_wildeyes = { id = 14437, name = "Gorzeeki Wildeyes", map = 1428, x = 12.4, y = 31.4, forever = true }
N.qu_gregan_brewspewer = { id = 7775, name = "Gregan Brewspewer", map = 1444, x = 45, y = 25.4, forever = true }
N.qu_greta_mosshoof = { id = 10922, name = "Greta Mosshoof" }
N.qu_grimand_elmore = { id = 1416, name = "Grimand Elmore", map = 1453, x = 51.6, y = 12.2, forever = true }
N.qu_high_priest_rohan = { id = 11406, name = "High Priest Rohan", map = 1455, x = 23.4, y = 6.4, forever = true }
N.qu_high_priest_thel_danis = { id = 1854, name = "High Priest Thel'danis", map = 1422, x = 51.8, y = 82.4, forever = true }
N.qu_impsy = { id = 14470, name = "Impsy", map = 1448, x = 41.4, y = 44.8, forever = true }
N.qu_james_halloran = { id = 2094, name = "James Halloran", map = 1437, x = 8, y = 55, forever = true }
N.qu_jaron_stoneshaper = { id = 10301, name = "Jaron Stoneshaper", map = 1452, x = 52, y = 30.4, forever = true }
N.qu_jordan_stilwell = { id = 6181, name = "Jordan Stilwell", map = 1426, x = 52.6, y = 36.8, forever = true }
N.qu_lady_sylvanas_windrunner = { id = 10181, name = "Lady Sylvanas Windrunner", map = 1458, x = 58, y = 91.6, forever = true }
N.qu_lord_banehollow = { id = 9516, name = "Lord Banehollow", map = 1448, x = 36, y = 44.4, forever = true }
N.qu_lord_grayson_shadowbreaker = { id = 928, name = "Lord Grayson Shadowbreaker", map = 1453, x = 49.4, y = 47.6, forever = true }
N.qu_lord_jorach_ravenholdt = { id = 6768, name = "Lord Jorach Ravenholdt", map = 1416, x = 86, y = 79, forever = true }
N.qu_lorekeeper_javon = { id = 14381, name = "Lorekeeper Javon" }
N.qu_lorekeeper_kildrath = { id = 14383, name = "Lorekeeper Kildrath" }
N.qu_lorekeeper_mykos = { id = 14382, name = "Lorekeeper Mykos" }
N.qu_merideth_carlson = { id = 2357, name = "Merideth Carlson", map = 1424, x = 52, y = 55.6, forever = true }
N.qu_mor_zul_bloodbringer = { id = 14436, name = "Mor'zul Bloodbringer", map = 1428, x = 12.6, y = 31.4, forever = true }
N.qu_muigin = { id = 9119, name = "Muigin", map = 1449, x = 43, y = 9.4, forever = true }
N.qu_ogtinc = { id = 8405, name = "Ogtinc", map = 1447, x = 42.4, y = 42.6, forever = true }
N.qu_private_rocknot = { id = 9503, name = "Private Rocknot" }
N.qu_rabine_saturna = { id = 11801, name = "Rabine Saturna", map = 1450, x = 51.6, y = 44.4, forever = true }
N.qu_rethiel_the_greenwarden = { id = 1244, name = "Rethiel the Greenwarden", map = 1437, x = 56.2, y = 40.4, forever = true }
N.qu_sagorne_creststrider = { id = 13417, name = "Sagorne Creststrider", map = 1454, x = 38.4, y = 36, forever = true }
N.qu_sanath_lim_yo = { id = 8395, name = "Sanath Lim-yo" }
N.qu_torwa_pathfinder = { id = 9619, name = "Torwa Pathfinder", map = 1449, x = 71.6, y = 76, forever = true }
N.qu_wynd_nightchaser = { id = 11079, name = "Wynd Nightchaser", map = 1452, x = 52, y = 30.2, forever = true }

ns:AddGuideSteps("DM", function() return {
    titles = {
        [1651] = L("Le Tome de la bravoure", "The Tome of Valor"),
        [1652] = L("Le Tome de la bravoure", "The Tome of Valor"),
        [1653] = L("Le test de droiture", "The Test of Righteousness"),
        [1654] = L("Le test de droiture", "The Test of Righteousness"),
        [1806] = L("Le test de droiture", "The Test of Righteousness"),
    },
    groups = {
        { before = nil, steps = {
            A(1651, "qu_daphne_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(1651, L("Défendez Daphne Stilwell contre les attaques des Défias. Aucun de vous deux ne doit mourir, si vous voulez réussir la quête. Quand vous aurez réussi, reparlez à Daphne Stilwell.", "Defend Daphne Stilwell from the Defias attack."), { faction = "Alliance", ["class"] = "PALADIN", map = 1436, x = 42.2, y = 88.6 }),
            T(1651, "qu_daphne_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(1652, "qu_daphne_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            T(1652, "qu_duthorian_rall", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(1653, "qu_duthorian_rall", { faction = "Alliance", ["class"] = "PALADIN" }),
            T(1653, "qu_jordan_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(1654, "qu_jordan_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(1654, L("Utiliser les Notes sur les armes de Jordan, trouver du Bois de chêne de blanchepierre, la Cargaison de Minerai raffiné de Bailor, le Marteau de forge de Jordan et une Gemme de Kor, puis revenir voir Jordan Stilwell à Ironforge.", "Using Jordan's Weapon Notes, find some Whitestone Oak Lumber, Bailor's Refined Ore Shipment, Jordan's Smithing Hammer, and a Kor Gem, and return them to Jordan Stilwell in Ironforge."), { faction = "Alliance", ["class"] = "PALADIN", map = 1426, x = 52.6, y = 36.8 }),
            T(1654, "qu_jordan_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(1806, "qu_jordan_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(1806, L("Attendre que Jordan Stilwell finisse de forger votre arme.", "Wait for Jordan Stilwell to finish forging a weapon for you."), { faction = "Alliance", ["class"] = "PALADIN", map = 1426, x = 52.6, y = 36.8 }),
            T(1806, "qu_jordan_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
        } },
    },
} end)

ns:AddGuideSteps("SFK", function() return {
    titles = {
        [1651] = L("Le Tome de la bravoure", "The Tome of Valor"),
        [1652] = L("Le Tome de la bravoure", "The Tome of Valor"),
        [1653] = L("Le test de droiture", "The Test of Righteousness"),
        [1654] = L("Le test de droiture", "The Test of Righteousness"),
        [1740] = L("L’Orbe de Soran’ruk", "The Orb of Soran'ruk"),
        [1806] = L("Le test de droiture", "The Test of Righteousness"),
    },
    groups = {
        { before = nil, steps = {
            A(1740, "qu_doan_karhan", { ["class"] = "WARLOCK" }),
            T(1740, "qu_doan_karhan", { ["class"] = "WARLOCK" }),
        } },
        { before = nil, steps = {
            A(1651, "qu_daphne_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(1651, L("Défendez Daphne Stilwell contre les attaques des Défias. Aucun de vous deux ne doit mourir, si vous voulez réussir la quête. Quand vous aurez réussi, reparlez à Daphne Stilwell.", "Defend Daphne Stilwell from the Defias attack."), { faction = "Alliance", ["class"] = "PALADIN", map = 1436, x = 42.2, y = 88.6 }),
            T(1651, "qu_daphne_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(1652, "qu_daphne_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            T(1652, "qu_duthorian_rall", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(1653, "qu_duthorian_rall", { faction = "Alliance", ["class"] = "PALADIN" }),
            T(1653, "qu_jordan_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(1654, "qu_jordan_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(1654, L("Utiliser les Notes sur les armes de Jordan, trouver du Bois de chêne de blanchepierre, la Cargaison de Minerai raffiné de Bailor, le Marteau de forge de Jordan et une Gemme de Kor, puis revenir voir Jordan Stilwell à Ironforge.", "Using Jordan's Weapon Notes, find some Whitestone Oak Lumber, Bailor's Refined Ore Shipment, Jordan's Smithing Hammer, and a Kor Gem, and return them to Jordan Stilwell in Ironforge."), { faction = "Alliance", ["class"] = "PALADIN", map = 1426, x = 52.6, y = 36.8 }),
            T(1654, "qu_jordan_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(1806, "qu_jordan_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(1806, L("Attendre que Jordan Stilwell finisse de forger votre arme.", "Wait for Jordan Stilwell to finish forging a weapon for you."), { faction = "Alliance", ["class"] = "PALADIN", map = 1426, x = 52.6, y = 36.8 }),
            T(1806, "qu_jordan_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
        } },
    },
} end)

ns:AddGuideSteps("BFD", function() return {
    titles = {
        [1651] = L("Le Tome de la bravoure", "The Tome of Valor"),
        [1652] = L("Le Tome de la bravoure", "The Tome of Valor"),
        [1653] = L("Le test de droiture", "The Test of Righteousness"),
        [1654] = L("Le test de droiture", "The Test of Righteousness"),
        [1740] = L("L’Orbe de Soran’ruk", "The Orb of Soran'ruk"),
        [1806] = L("Le test de droiture", "The Test of Righteousness"),
        [6922] = L("Baron Aquanis", "Baron Aquanis"),
    },
    groups = {
        { before = nil, steps = {
            A(6922, nil, { onlyIfStarted = true, text = L("Globe d'eau étrange, obtenu sur le Baron Aquanis dans les Profondeurs de Brassenoire", "Strange Water Globe: Drops from Baron Aquanis inside Blackfathom Deeps."), faction = "Horde" }),
            D(6922, L("Apportez le Globe d'eau étrange à Je'neu Sancrea à l'avant-poste de Zoram'gar, en Orneval.", "Bring the Strange Water Globe to Je'neu Sancrea at Zoram'gar Outpost, Ashenvale."), { onlyIfStarted = true, faction = "Horde" }),
            T(6922, "jeneu", { onlyIfStarted = true, faction = "Horde" }),
        } },
        { before = nil, steps = {
            A(1651, "qu_daphne_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(1651, L("Défendez Daphne Stilwell contre les attaques des Défias. Aucun de vous deux ne doit mourir, si vous voulez réussir la quête. Quand vous aurez réussi, reparlez à Daphne Stilwell.", "Defend Daphne Stilwell from the Defias attack."), { faction = "Alliance", ["class"] = "PALADIN", map = 1436, x = 42.2, y = 88.6 }),
            T(1651, "qu_daphne_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(1652, "qu_daphne_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            T(1652, "qu_duthorian_rall", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(1653, "qu_duthorian_rall", { faction = "Alliance", ["class"] = "PALADIN" }),
            T(1653, "qu_jordan_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(1654, "qu_jordan_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(1654, L("Utiliser les Notes sur les armes de Jordan, trouver du Bois de chêne de blanchepierre, la Cargaison de Minerai raffiné de Bailor, le Marteau de forge de Jordan et une Gemme de Kor, puis revenir voir Jordan Stilwell à Ironforge.", "Using Jordan's Weapon Notes, find some Whitestone Oak Lumber, Bailor's Refined Ore Shipment, Jordan's Smithing Hammer, and a Kor Gem, and return them to Jordan Stilwell in Ironforge."), { faction = "Alliance", ["class"] = "PALADIN", map = 1426, x = 52.6, y = 36.8 }),
            T(1654, "qu_jordan_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(1806, "qu_jordan_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(1806, L("Attendre que Jordan Stilwell finisse de forger votre arme.", "Wait for Jordan Stilwell to finish forging a weapon for you."), { faction = "Alliance", ["class"] = "PALADIN", map = 1426, x = 52.6, y = 36.8 }),
            T(1806, "qu_jordan_stilwell", { faction = "Alliance", ["class"] = "PALADIN" }),
        } },
        { before = nil, steps = {
            A(1740, "qu_doan_karhan", { ["class"] = "WARLOCK" }),
            T(1740, "qu_doan_karhan", { ["class"] = "WARLOCK" }),
        } },
    },
} end)

ns:AddGuideSteps("EXCAV", function() return {
    titles = {
        [275] = L("Des pustules sur la terre", "Blisters on The Land"),
        [276] = L("Pattes écrasantes", "Tramping Paws"),
        [277] = L("Tabou du feu", "Fire Taboo"),
        [463] = L("Le Gardien vert", "The Greenwarden"),
        [484] = L("Peaux de jeunes crocilisques", "Young Crocolisk Skins"),
    },
    groups = {
        { before = 98815, steps = {
            A(484, "qu_james_halloran", { faction = "Alliance" }),
            D(484, L("Rapportez 4 peaux de jeunes crocilisques à James Halloran, à Menethil.", "Obtain 4 Young Crocolisk Skins for James Halloran in Menethil Harbor."), { faction = "Alliance", map = 1437, x = 8, y = 55 }),
            T(484, "qu_james_halloran", { faction = "Alliance" }),
        } },
        { before = 95646, steps = {
            A(463, "qu_first_mate_fitzsimmons", { faction = "Alliance" }),
            T(463, "qu_rethiel_the_greenwarden", { faction = "Alliance" }),
            A(276, "qu_rethiel_the_greenwarden", { faction = "Alliance" }),
            D(276, L("Tuez 15 gnolls Mosshide et 10 bâtards Mosshide, puis retournez voir Rethiel le Gardien vert.", "Kill 15 Mosshide Gnolls and 10 Mosshide Mongrels, then return to Rethiel the Greenwarden."), { faction = "Alliance", map = 1437, x = 56.2, y = 40.6 }),
            T(276, "qu_rethiel_the_greenwarden", { faction = "Alliance" }),
            A(277, "qu_rethiel_the_greenwarden", { faction = "Alliance" }),
            D(277, L("Apportez 9 silex grossiers à Rethiel le Gardien vert.", "Bring Rethiel the Greenwarden 9 Crude Flints."), { faction = "Alliance", map = 1437, x = 56.2, y = 40.6 }),
            T(277, "qu_rethiel_the_greenwarden", { faction = "Alliance" }),
            A(275, "qu_rethiel_the_greenwarden", { faction = "Alliance" }),
            D(275, L("Tuez 12 rampants des marais, puis retournez voir Rethiel le Gardien vert.", "Kill 12 Fen Creepers, then return to Rethiel the Greenwarden."), { faction = "Alliance", map = 1437, x = 56.2, y = 40.6 }),
            T(275, "qu_rethiel_the_greenwarden", { faction = "Alliance" }),
        } },
    },
} end)

ns:AddGuideSteps("SMARM", function() return {
    titles = {
        [6141] = L("Frère Anton", "Brother Anton"),
    },
    groups = {
        { before = nil, steps = {
            A(6141, "qu_brother_crowley", { faction = "Alliance" }),
            T(6141, "anton", { faction = "Alliance" }),
        } },
    },
} end)

ns:AddGuideSteps("SMCATH", function() return {
    titles = {
        [6141] = L("Frère Anton", "Brother Anton"),
    },
    groups = {
        { before = nil, steps = {
            A(6141, "qu_brother_crowley", { faction = "Alliance" }),
            T(6141, "anton", { faction = "Alliance" }),
        } },
    },
} end)

ns:AddGuideSteps("ULDA", function() return {
    titles = {
        [1954] = L("L'orbe infernal", "The Infernal Orb"),
        [1955] = L("L'Exorcisme", "The Exorcism"),
        [1956] = L("L'Energie d'Uldaman", "Power in Uldaman"),
    },
    groups = {
        { before = nil, steps = {
            A(1954, "tabetha", { ["class"] = "MAGE" }),
            D(1954, L("Apporter un Orbe infernal à Tabetha dans le marécage d'Âprefange.", "Bring an Infernal Orb to Tabetha in Dustwallow Marsh."), { ["class"] = "MAGE", map = 1445, x = 46, y = 57 }),
            T(1954, "tabetha", { ["class"] = "MAGE" }),
            A(1955, "tabetha", { ["class"] = "MAGE" }),
            D(1955, L("Tuer le démon de l'Orbe puis parler à Tabetha.", "Kill the Demon of the Orb, then speak with Tabetha."), { ["class"] = "MAGE", map = 1445, x = 46, y = 57 }),
            T(1955, "tabetha", { ["class"] = "MAGE" }),
            A(1956, "tabetha", { ["class"] = "MAGE" }),
            D(1956, L("Récupérer une Source d'énergie en obsidienne et la rapporter à Tabetha dans le marécage d'Âprefange.", "Retrieve an Obsidian Power Source and bring it to Tabetha in Dustwallow Marsh."), { ["class"] = "MAGE", map = 1445, x = 46, y = 57 }),
            T(1956, "tabetha", { ["class"] = "MAGE" }),
        } },
    },
} end)

ns:AddGuideSteps("ZF", function() return {
    titles = {
        [2769] = L("Les frères Brassbolts", "The Brassbolts Brothers"),
        [2861] = L("La mission de Tabetha", "Tabetha's Task"),
    },
    groups = {
        { before = nil, steps = {
            A(2769, "klockmort", { faction = "Alliance" }),
            T(2769, "wizzle", { faction = "Alliance" }),
        } },
        { before = nil, steps = {
            A(2861, nil, { text = L("Maîtres des mages", "Mage trainers (mages only)"), ["class"] = "MAGE" }),
            T(2861, "tabetha", { ["class"] = "MAGE" }),
        } },
    },
} end)

ns:AddGuideSteps("ST", function() return {
    titles = {
        [4141] = L("Muigin et Larion", "Muigin and Larion"),
        [4142] = L("Visite à Gregan", "A Visit to Gregan"),
        [4143] = L("Brouillard maléfique", "Haze of Evil"),
        [8151] = L("Le charme du chasseur", "The Hunter's Charm"),
        [8153] = L("La ramure de coursier", "Courser Antlers"),
        [8231] = L("Vandales des flots", "Wavethrashing"),
        [8232] = L("Le drake vert", "The Green Drake"),
        [8233] = L("Une requête toute simple", "A Simple Request"),
        [8234] = L("Sac azur scellé", "Sealed Azure Bag"),
        [8235] = L("Les fragments codés", "Encoded Fragments"),
        [8236] = L("La clé d’azur", "The Azure Key"),
        [8250] = L("L'art du mage", "Magecraft"),
        [8251] = L("La poussière magique", "Magic Dust"),
        [8252] = L("Le corail des sirènes", "The Siren's Coral"),
        [8253] = L("Détruire Morphaz", "Destroy Morphaz"),
        [8254] = L("Aider le Cercle", "Cenarion Aid"),
        [8255] = L("Courser les coursiers", "Of Coursers We Know"),
        [8256] = L("L'ichor de non-mort", "The Ichor of Undeath"),
        [8257] = L("Le sang de Morphaz", "Blood of Morphaz"),
        [8410] = L("La maîtrise des éléments", "Elemental Mastery"),
        [8412] = L("Le totem des esprits", "Spirit Totem"),
        [8413] = L("Vaudou !", "Da Voodoo"),
        [8414] = L("La dissipation du mal", "Dispelling Evil"),
        [8415] = L("La pointe du Noroît", "Chillwind Point"),
        [8416] = L("Pierres du Fléau inertes", "Inert Scourgestones"),
        [8417] = L("Un esprit troublé", "A Troubled Spirit"),
        [8418] = L("Forger la pierre de pouvoir", "Forging the Mightstone"),
        [8419] = L("La demande d'un diablotin", "An Imp's Request"),
        [8420] = L("Chaud et piquant", "Hot and Itchy"),
        [8421] = L("L'anti-étoffe des héros", "The Wrong Stuff"),
        [8422] = L("Les trolls d'un même plumage…", "Trolls of a Feather"),
        [8423] = L("Fraternité entre guerriers", "Warrior Kinship"),
        [8424] = L("La guerre contre les liges d'ombre", "War on the Shadowsworn"),
        [8425] = L("Plumes vaudou", "Voodoo Feathers"),
        [9051] = L("Test de toxicité", "Toxic Test"),
        [9052] = L("Le poison de Pétale-de-sang", "Bloodpetal Poison"),
        [9053] = L("Un meilleur ingrédient", "A Better Ingredient"),
        [9063] = L("Torwa Pathfinder", "Torwa Pathfinder"),
    },
    groups = {
        { before = nil, steps = {
            A(4141, "qu_muigin", { faction = "Alliance" }),
            D(4141, L("Récolter 15 Pétales-de-sang et retourner voir Muigin.", "Collect 15 Bloodpetals and return to Muigin."), { faction = "Alliance", map = 1449, x = 43, y = 9.4 }),
            T(4141, "qu_muigin", { faction = "Alliance" }),
            A(4142, "qu_muigin", { faction = "Alliance" }),
            T(4142, "qu_gregan_brewspewer", { faction = "Alliance" }),
            A(4143, "qu_gregan_brewspewer", { faction = "Alliance" }),
            D(4143, L("Récupérer 5 Echantillons de brume atal'ai puis retourner voir Muigin dans le cratère d'Un'Goro.", "Collect 5 samples of Atal'ai Haze, then return to Muigin in Un'Goro Crater."), { faction = "Alliance", map = 1444, x = 45, y = 25.4 }),
            T(4143, "qu_muigin", { faction = "Alliance" }),
        } },
        { before = nil, steps = {
            A(9063, nil, { text = L("Maîtres des druides", "Druid trainers"), ["class"] = "DRUID" }),
            T(9063, "qu_torwa_pathfinder", { ["class"] = "DRUID" }),
        } },
        { before = nil, steps = {
            A(9052, "qu_torwa_pathfinder", { ["class"] = "DRUID" }),
            D(9052, L("Récupérez 8 Chapeaux de sang et 8 Dards de Gorishi, puis retournez voir Torwa Pathfinder au cratère d'Un'goro.", "Collect 8 Bloodcap and 8 Gorishi Stings, and return to Torwa Pathfinder in Un'Goro Crater."), { ["class"] = "DRUID", map = 1449, x = 71.6, y = 76 }),
            T(9052, "qu_torwa_pathfinder", { ["class"] = "DRUID" }),
            A(9051, "qu_torwa_pathfinder", { ["class"] = "DRUID" }),
            D(9051, L("Piquez un Diablosaure avec l'Aiguillon de diablosaure. Retournez voir Torwa Pathfinder au Cratère d'Un'goro lorsque vous aurez accompli cette tâche.", "Stab a Devilsaur with the Devilsaur Barb. Return to Torwa Pathfinder in Un'Goro Crater when you have completed this task."), { ["class"] = "DRUID", map = 1449, x = 71.6, y = 76 }),
            T(9051, "qu_torwa_pathfinder", { ["class"] = "DRUID" }),
            A(9053, "qu_torwa_pathfinder", { ["class"] = "DRUID" }),
            D(9053, L("Récupérez une Liane putride sur le Gardien au fond du Temple englouti et revenez voir Torwa Pathfinder.", "Retrieve a Putrid Vine from the guardian at the bottom of the Sunken Temple and return to Torwa Pathfinder."), { ["class"] = "DRUID" }),
            T(9053, "qu_torwa_pathfinder", { ["class"] = "DRUID" }),
        } },
        { before = nil, steps = {
            A(8151, nil, { text = L("Maîtres des chasseurs", "Hunter trainers"), ["class"] = "HUNTER" }),
            T(8151, "qu_ogtinc", { ["class"] = "HUNTER" }),
        } },
        { before = nil, steps = {
            A(8153, "qu_ogtinc", { ["class"] = "HUNTER" }),
            D(8153, L("Rapporter deux Ramures de coursier parfaites à Ogtinc en Azshara. Ogtinc vit au sommet des collines au nord-est des ruines d’Eldarath.", "Bring a pair of Perfect Courser Antlers to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast of the Ruins of Eldarath."), { ["class"] = "HUNTER", map = 1447, x = 42.4, y = 42.6 }),
            T(8153, "qu_ogtinc", { ["class"] = "HUNTER" }),
            A(8231, "qu_ogtinc", { ["class"] = "HUNTER" }),
            D(8231, L("Apporter 6 Ecailles de vandale des flots à Ogtinc en Azshara. Ogtinc demeure au sommet des falaises au nord-est des ruines d'Eldarath.", "Bring 6 Wavethrasher Scales to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."), { ["class"] = "HUNTER", map = 1447, x = 42.4, y = 42.6 }),
            T(8231, "qu_ogtinc", { ["class"] = "HUNTER" }),
            A(8232, "qu_ogtinc", { ["class"] = "HUNTER" }),
            D(8232, L("Apporter la Dent de Morphaz à Ogtinc en Azshara. Ogtinc demeure au sommet des falaises au nord-est des ruines d'Eldarath.", "Bring the Tooth of Morphaz to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."), { ["class"] = "HUNTER" }),
            T(8232, "qu_ogtinc", { ["class"] = "HUNTER" }),
        } },
        { before = nil, steps = {
            A(8250, nil, { text = L("Maîtres des mages", "Mage trainers"), ["class"] = "MAGE" }),
            T(8250, "qu_sanath_lim_yo", { ["class"] = "MAGE" }),
        } },
        { before = nil, steps = {
            A(8251, "qu_archmage_xylem", { ["class"] = "MAGE" }),
            D(8251, L("Procurer 10 doses de Poussière lumineuse à l’archimage Xylem.", "Bring 10 Glittering Dust to Archmage Xylem."), { ["class"] = "MAGE", map = 1447, x = 29.2, y = 40.2 }),
            T(8251, "qu_archmage_xylem", { ["class"] = "MAGE" }),
            A(8252, "qu_archmage_xylem", { ["class"] = "MAGE" }),
            D(8252, L("Récupérer 6 Coraux enchantés et les apporter à l’archimage Xylem.", "Collect 6 Enchanted Coral and return them to Archmage Xylem."), { ["class"] = "MAGE", map = 1447, x = 29.2, y = 40.2 }),
            T(8252, "qu_archmage_xylem", { ["class"] = "MAGE" }),
            A(8253, "qu_archmage_xylem", { ["class"] = "MAGE" }),
            D(8253, L("Récupérer le Fragment d’arcane sur Morphaz et le rendre à l’archimage Xylem.", "Retrieve the Arcane Shard from Morphaz and return to Archmage Xylem."), { ["class"] = "MAGE" }),
            T(8253, "qu_archmage_xylem", { ["class"] = "MAGE" }),
        } },
        { before = nil, steps = {
            A(8415, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            T(8415, "qu_commander_ashlam_valorfist", { faction = "Alliance", ["class"] = "PALADIN" }),
        } },
        { before = nil, steps = {
            A(8414, "qu_commander_ashlam_valorfist", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(8414, L("Récupérez 20 Pierres du Fléau des serviteurs et apportez-les au grand prêtre Thel'danis dans les Maleterres de l'ouest.", "Collect 20 Minion's Scourgestones and bring them to High Priest Thel'danis in the Western Plaguelands."), { faction = "Alliance", ["class"] = "PALADIN", map = 1422, x = 42.8, y = 84 }),
            T(8414, "qu_high_priest_thel_danis", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(8416, "qu_high_priest_thel_danis", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(8416, L("Apporter la Pierre du Fléau inerte au commandant Ashlam Valorfist à la pointe du Noroît.", "Bring the Inert Scourgestone to Commander Ashlan Valorfist in Chillwind Point."), { faction = "Alliance", ["class"] = "PALADIN", map = 1422, x = 51.8, y = 82.4 }),
            T(8416, "qu_commander_ashlam_valorfist", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(8418, "qu_commander_ashlam_valorfist", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(8418, L("Apporter les plumes vaudou à Ashlam Valorfist.", "Bring the voodoo feathers to Ashlam Valorfist."), { faction = "Alliance", ["class"] = "PALADIN", map = 1422, x = 42.8, y = 84 }),
            T(8418, "qu_commander_ashlam_valorfist", { faction = "Alliance", ["class"] = "PALADIN" }),
        } },
        { before = nil, steps = {
            A(8254, nil, { text = L("Maîtres des prêtres", "Priest trainers"), ["class"] = "PRIEST" }),
            T(8254, "qu_ogtinc", { ["class"] = "PRIEST" }),
        } },
        { before = nil, steps = {
            A(8255, "qu_ogtinc", { ["class"] = "PRIEST" }),
            D(8255, L("Récupérer 4 Glandes de coursier en bonne santé et les apporter à Ogtinc en Azshara. Ogtinc réside au sommet des falaises, au nord-est des ruines d’Eldarath.", "Acquire 4 Healthy Courser Glands and bring them to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."), { ["class"] = "PRIEST", map = 1447, x = 42.4, y = 42.6 }),
            T(8255, "qu_ogtinc", { ["class"] = "PRIEST" }),
            A(8256, "qu_ogtinc", { ["class"] = "PRIEST" }),
            D(8256, L("Récupérer une dose d’Ichor de non-mort pour le compte d’Ogtinc en Azshara. Ogtinc réside au sommet des falaises, au nord-est des ruines d’Eldarath.", "Acquire an Ichor of Undeath for Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."), { ["class"] = "PRIEST", map = 1447, x = 42.4, y = 42.6 }),
            T(8256, "qu_ogtinc", { ["class"] = "PRIEST" }),
            A(8257, "qu_ogtinc", { ["class"] = "PRIEST" }),
            D(8257, L("Tuez Morphaz dans le temple englouti d’Atal'Hakkar, et ramenez son sang à Greta Mosshoof à Gangrebois. L’entrée du temple englouti se trouve dans le marais des Chagrins.", "Kill Morphaz in the sunken temple of Atal'Hakkar, and return his blood to Greta Mosshoof in Felwood. The entrance to the sunken temple can be found in the Swamp of Sorrows."), { ["class"] = "PRIEST" }),
            T(8257, "qu_greta_mosshoof", { ["class"] = "PRIEST" }),
        } },
        { before = nil, steps = {
            A(8233, nil, { text = L("Maîtres des voleurs", "Rogue trainers"), ["class"] = "ROGUE" }),
            T(8233, "qu_lord_jorach_ravenholdt", { ["class"] = "ROGUE" }),
        } },
        { before = nil, steps = {
            A(8234, "qu_lord_jorach_ravenholdt", { ["class"] = "ROGUE" }),
            D(8234, L("Récupérer le Sac azur scellé auprès du chaman Grumegueule en Azshara. Puis apportez le sac à l'archimage Xylem, également en Azshara.", "Retrieve the Sealed Azure Bag from the Timbermaw Shaman in Azshara. Then take the bag to Archmage Xylem, also found in Azshara."), { ["class"] = "ROGUE", map = 1416, x = 86, y = 79 }),
            T(8234, "qu_archmage_xylem", { ["class"] = "ROGUE" }),
            A(8235, "qu_archmage_xylem", { ["class"] = "ROGUE" }),
            D(8235, L("Apporter 10 Fragments codés à l'archimage Xylem à Azshara.", "Bring 10 Encoded Fragments to Archmage Xylem in Azshara."), { ["class"] = "ROGUE", map = 1447, x = 29.2, y = 40.2 }),
            T(8235, "qu_archmage_xylem", { ["class"] = "ROGUE" }),
            A(8236, "qu_archmage_xylem", { ["class"] = "ROGUE" }),
            D(8236, L("Rendre la Clé d'azur au seigneur Jorach Ravenholdt.", "Return the Azure Key to Lord Jorach Ravenholdt."), { ["class"] = "ROGUE", map = 1447, x = 29.2, y = 40.2 }),
            T(8236, "qu_lord_jorach_ravenholdt", { ["class"] = "ROGUE" }),
        } },
        { before = nil, steps = {
            A(8410, "qu_beram_skychaser", { faction = "Horde", ["class"] = "SHAMAN" }),
            D(8410, L("Rassembler un échantillon d'air, de feu, de terre et d'eau pour Bath'rah la Vigie des Vents.", "Collect a sample of air, fire, earth and water for Bath'rah the Windwatcher."), { faction = "Horde", ["class"] = "SHAMAN", map = 1456, x = 22.2, y = 19 }),
            T(8410, "qu_bath_rah_the_windwatcher", { faction = "Horde", ["class"] = "SHAMAN" }),
            A(8412, "qu_bath_rah_the_windwatcher", { faction = "Horde", ["class"] = "SHAMAN" }),
            D(8412, L("Apportez les différents morceaux du Totem des esprits à Bath’rah la Vigie des Vents.", "Bring the pieces for the spirit totem to Bath'rah the Windwatcher."), { faction = "Horde", ["class"] = "SHAMAN", map = 1416, x = 80.4, y = 66.8 }),
            T(8412, "qu_bath_rah_the_windwatcher", { faction = "Horde", ["class"] = "SHAMAN" }),
            A(8413, "qu_bath_rah_the_windwatcher", { faction = "Horde", ["class"] = "SHAMAN" }),
            D(8413, L("Apporter les Plumes vaudou à Bath'rah la Vigie des vents.", "Bring the voodoo feathers to Bath'rah the Windwatcher."), { faction = "Horde", ["class"] = "SHAMAN", map = 1416, x = 80.4, y = 66.8 }),
            T(8413, "qu_bath_rah_the_windwatcher", { faction = "Horde", ["class"] = "SHAMAN" }),
        } },
        { before = nil, steps = {
            A(8419, nil, { text = L("Votre maître de classe", "Your class trainer"), ["class"] = "WARLOCK" }),
            D(8419, L("Apportez un morceau de Gangrétoffe à Démonet à Gangrebois.", "Bring a piece of felcloth to Impsy in Felwood."), { ["class"] = "WARLOCK" }),
            T(8419, "qu_impsy", { ["class"] = "WARLOCK" }),
            A(8420, "qu_impsy", { ["class"] = "WARLOCK" }),
            D(8420, L("Apportez un morceau de gangrétoffe à Démonet à Gangrebois.", "Bring a piece of felcloth to Impsy in Felwood."), { ["class"] = "WARLOCK", map = 1448, x = 41.4, y = 44.8 }),
            T(8420, "qu_impsy", { ["class"] = "WARLOCK" }),
            A(8421, "qu_impsy", { ["class"] = "WARLOCK" }),
            D(8421, L("Apporter 10 morceaux de Bois pourri et 4 Essences de Vénéneuse à Démonet, en Gangrebois.", "Bring 10 Rotting Wood and 4 Bloodvenom Essence to Impsy in Felwood."), { ["class"] = "WARLOCK", map = 1448, x = 41.4, y = 44.8 }),
            T(8421, "qu_impsy", { ["class"] = "WARLOCK" }),
            A(8422, "qu_impsy", { ["class"] = "WARLOCK" }),
            D(8422, L("Apporter 6 Plumes vaudou des trolls du Temple englouti.", "Bring a total of 6 Voodoo Feathers from the trolls in sunken temple."), { ["class"] = "WARLOCK" }),
            T(8422, "qu_impsy", { ["class"] = "WARLOCK" }),
        } },
        { before = nil, steps = {
            A(8417, nil, { text = L("Maîtres des guerriers", "Warrior trainers"), ["class"] = "WARRIOR" }),
            T(8417, "qu_fallen_hero_of_the_horde", { ["class"] = "WARRIOR" }),
        } },
        { before = nil, steps = {
            A(8423, "qu_fallen_hero_of_the_horde", { ["class"] = "WARRIOR" }),
            D(8423, L("Tuer 7 Sangliers infernaux dans les Terres foudroyées et revenir voir le Héros déchu de la Horde.", "Kill 7 Helboar in the Blasted Lands and return to the Fallen Hero of the Horde."), { ["class"] = "WARRIOR", map = 1435, x = 34.2, y = 66 }),
            T(8423, "qu_fallen_hero_of_the_horde", { ["class"] = "WARRIOR" }),
            A(8424, "qu_fallen_hero_of_the_horde", { ["class"] = "WARRIOR" }),
            D(8424, L("Tuez les Liges d'ombre dans les Terres foudroyées et revenez voir le Héros déchu de la Horde.", "Slaughter the Shadowsworn in the Blasted Lands and return to the Fallen Hero of the Horde."), { ["class"] = "WARRIOR", map = 1435, x = 34.2, y = 66 }),
            T(8424, "qu_fallen_hero_of_the_horde", { ["class"] = "WARRIOR" }),
            A(8425, "qu_fallen_hero_of_the_horde", { ["class"] = "WARRIOR" }),
            D(8425, L("Apportez les Plumes vaudou des trolls du Temple englouti au Héros déchu de la Horde.", "Bring the Voodoo Feathers from the trolls in the Sunken Temple to the Fallen Hero of the Horde."), { ["class"] = "WARRIOR" }),
            T(8425, "qu_fallen_hero_of_the_horde", { ["class"] = "WARRIOR" }),
        } },
    },
} end)

ns:AddGuideSteps("BRD", function() return {
    titles = {
        [3982] = L("Que se passe-t-il ?", "What Is Going On?"),
        [4295] = L("La bière de Rocknot", "Rocknot's Ale"),
    },
    groups = {
        { before = 4001, steps = {
            A(3982, "n9020", { faction = "Horde" }),
            D(3982, L("Défendre Gor'shak.", "Defend Gor'shak."), { faction = "Horde" }),
            T(3982, "n9020", { faction = "Horde" }),
        } },
        { before = nil, steps = {
            A(4295, "qu_private_rocknot"),
            D(4295, L("Apportez deux chopes de bière Sombrefer au soldat Rocknot.", "Bring Private Rocknot two Dark Iron Ale Mugs.")),
            T(4295, "qu_private_rocknot"),
        } },
    },
} end)

ns:AddGuideSteps("DME", function() return {
    titles = {
        [5526] = L("Fragment de la Gangrevigne", "Shards of the Felvine"),
        [5527] = L("Un reliquaire de pureté", "A Reliquary of Purity"),
        [7463] = L("Rafraîchissement arcanique", "Arcane Refreshment"),
    },
    groups = {
        { before = nil, steps = {
            A(5527, "qu_rabine_saturna"),
            D(5527, L("Rendez-vous en Silithus et cherchez un Reliquaire de pureté dans les ruines du village de Sudevent. Si vous parvenez à le trouver, ramenez-le à Rabine Saturna à Havrenuit, Reflet-de-Lune.", "Travel to Silithus and search for a Reliquary of Purity within the ruins of Southwind Village. If you are able to find it, return with it to Rabine Saturna in Nighthaven, Moonglade."), { map = 1450, x = 51.6, y = 44.4 }),
            T(5527, "qu_rabine_saturna"),
            A(5526, "qu_rabine_saturna"),
            T(5526, "qu_rabine_saturna"),
        } },
        { before = nil, steps = {
            A(7463, "n14368", { ["class"] = "MAGE" }),
            D(7463, L("Rendez-vous dans le quartier de Crochebois de Hache-tripes et tuez Hydrogénos, l’élémentaire de l’eau. Retournez voir le Gardien du savoir Lydros à l’Athenaeum avec l’Essence d’Hydrogénos.", "Travel to the Warpwood Quarter of Dire Maul and slay the water elemental, Hydrospawn. Return to Lorekeeper Lydros in the Athenaeum with the Hydrospawn Essence."), { ["class"] = "MAGE" }),
            T(7463, "n14368", { ["class"] = "MAGE" }),
        } },
    },
} end)

ns:AddGuideSteps("DMW", function() return {
    titles = {
        [5244] = L("Les ruines de Kel'Theril", "The Ruins of Kel'Theril"),
        [5245] = L("Les Esprits troublés de Kel'Theril", "Troubled Spirits of Kel'Theril"),
        [5246] = L("Fragments du passé", "Fragments of the Past"),
        [5247] = L("Fragments du passé", "Fragments of the Past"),
        [5250] = L("Pluie-d'Etoiles", "Starfall"),
        [7563] = L("Rage de sang", "Rage of Blood"),
        [7564] = L("Gorzeeki Wildeyes", "Wildeyes"),
        [7623] = L("Le seigneur Banehollow", "Lord Banehollow"),
        [7624] = L("Ulathek le traître", "Ulathek the Traitor"),
        [7625] = L("Poussière d'étoile xorothienne", "Xorothian Stardust"),
        [7626] = L("La Cloche de Dethmoora", "Bell of Dethmoora"),
        [7627] = L("La Roue de la Marche noire", "Wheel of the Black March"),
        [7628] = L("La Chandelle de l'apocalypse", "Doomsday Candle"),
        [7629] = L("Livraison de diablotin", "Imp Delivery"),
        [7630] = L("L'arcanite", "Arcanite"),
        [7631] = L("Le destrier de l'effroi de Xoroth", "Dreadsteed of Xoroth"),
        [7637] = L("L'accent sur le sacrifice", "Emphasis on Sacrifice"),
        [7639] = L("Des preuves de jugement", "To Show Due Judgment"),
        [7640] = L("Exorciser Val-Terreur", "Exorcising Terrordale"),
        [7641] = L("L'œuvre de Grimand Elmore", "The Work of Grimand Elmore"),
        [7642] = L("Une ribambelle d'objets", "Collection of Goods"),
        [7643] = L("L'ancien esprit équin", "Ancient Equine Spirit"),
        [7645] = L("Fourrage enrichi en manne", "Manna-Enriched Horse Feed"),
        [7648] = L("Le chef d'œuvre de Grimand", "Grimand's Finest Work"),
    },
    groups = {
        { before = nil, steps = {
            A(5250, "qu_daryn_lightwind", { faction = "Alliance" }),
            T(5250, "qu_wynd_nightchaser", { faction = "Alliance" }),
        } },
        { before = nil, steps = {
            A(5244, "qu_wynd_nightchaser", { faction = "Alliance" }),
            T(5244, "qu_jaron_stoneshaper", { faction = "Alliance" }),
            A(5245, "qu_jaron_stoneshaper", { faction = "Alliance" }),
            D(5245, L("Utiliser la Pique de Jaron pour trouver les quatre Fragments de relique des Bien-nés. Les apporter à Aurora Skycaller dans les Maleterres de l’est.", "Use Jaron's Pick to find the four Highborne Relic Fragments. Bring them to Aurora Skycaller in Eastern Plaguelands."), { faction = "Alliance", map = 1452, x = 52, y = 30.4 }),
            T(5245, "qu_aurora_skycaller", { faction = "Alliance" }),
            A(5246, "qu_aurora_skycaller", { faction = "Alliance" }),
            T(5246, "qu_aurora_skycaller", { faction = "Alliance" }),
            A(5247, "qu_aurora_skycaller", { faction = "Alliance" }),
            D(5247, L("Apporter une Barre de thorium enchanté, 5 Cristaux de restauration et une Fiole d'eau redoutable à Aurora Skycaller à la tour du Col du nord, dans les Maleterres de l’est.", "Bring an Enchanted Thorium Bar, 5 Crystal Restore, and a Vial of Dire Water to Aurora Skycaller near the Northpass Tower in Eastern Plaguelands."), { faction = "Alliance", map = 1423, x = 47.5, y = 16.8 }),
            T(5247, "qu_aurora_skycaller", { faction = "Alliance" }),
        } },
        { before = nil, steps = {
            A(7637, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(7637, L("Rendez-vous à Ironforge et procurez-vous l’Encensoir d’exorcisme du grand prêtre Rohan. Pour vous le procurer, il vous faudra verser une donation de 150 pièces d’or.", "Travel to Ironforge and get High Priest Rohan's Exorcism Censer. You will need to make a donation of 150 gold in order to secure it."), { faction = "Alliance", ["class"] = "PALADIN", map = 1453, x = 49.4, y = 47.6 }),
            T(7637, "qu_high_priest_rohan", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(7639, "qu_high_priest_rohan", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(7639, L("Ramener l’Encensoir d’exorcisme au seigneur Grayson Shadowbreaker, dans le Quartier de cathédrale de Stormwind.", "Return the Exorcism Censer to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."), { faction = "Alliance", ["class"] = "PALADIN", map = 1455, x = 23.4, y = 6.4 }),
            T(7639, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(7640, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(7640, L("Servez-vous de l’Encensoir d’exorcisme pour chasser les esprits qui tourmentent Val-Terreur. Lorsque vous aurez tué 25 Esprits de Val-Terreur, retournez voir le seigneur Grayson Shadowbreaker dans le Quartier de la cathédrale de Stormwind.", "Use the Exorcism Censer to drive out the spirits that torment Terrordale. When you have slain 25 Terrordale Spirits, return to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."), { faction = "Alliance", ["class"] = "PALADIN", map = 1453, x = 49.4, y = 47.6 }),
            T(7640, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(7641, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            T(7641, "qu_grimand_elmore", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(7642, "qu_grimand_elmore", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(7642, L("Apporter 40 Etoffes runiques, 6 Barres d’arcanite, 10 Larmes d’Arthas, 5 Fioles d’eau sacrée de Stratholme, et 150 pièces d’or à Grimand Elmore, au Quartier des nains de Stormwind.", "Bring 40 Runecloth, 6 Arcanite Bars, 10 Arthas' Tears, 5 Stratholme Holy Water vials, and 150 gold to Grimand Elmore in the Dwarven District of Stormwind."), { faction = "Alliance", ["class"] = "PALADIN" }),
            T(7642, "qu_grimand_elmore", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(7648, "qu_grimand_elmore", { faction = "Alliance", ["class"] = "PALADIN" }),
            T(7648, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(7645, "qu_merideth_carlson", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(7645, L("Récupérer 20 Biscuits enrichis en manne, l’ingrédient vital qui permet de préparer du Fourrage enrichi en manne, pour le compte de Merideth Carlson de Southore dans les contreforts d’Hillsbrad. L’Aube d’argent est la seule à fabriquer ces biscuits. Vous devrez également lui donner 50 pièces d’or pour apaiser sa susceptibilité.", "Retrieve 20 Enriched Manna Biscuits - the key ingredient in making Manna-Enriched Horse Feed - for Merideth Carlson at Southshore in the Hillsbrad Foothills. The Argent Dawn is known as the sole purveyor of the biscuits. You also need to give her 50 gold to soothe her ruffled sensibilities."), { faction = "Alliance", ["class"] = "PALADIN", map = 1424, x = 52, y = 55.6 }),
            T(7645, "qu_merideth_carlson", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(7643, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(7643, L("Procurez-vous un aliment pour chevaux capable de nourrir un esprit équin. Il semble que Merideth Carlson, à Southshore, sache en fabriquer. Ensuite, rendez-vous au donjon de Hache-tripes en Feralas, et tuez Tendris Crochebois. Sa mort libérera l’Ancien esprit équin. Nourrissez-le avec l’aliment spécial afin de l’apaiser. Enfin, donnez-lui le Caparaçon d’arcanite pour qu’il le bénisse.", "Acquire special horse feed used for feeding a spirit horse. Merideth Carlson in Southshore apparently is the source for such food. Travel to the Dire Maul dungeon in Feralas and slay Tendris Warpwood. Doing so will free the Ancient Equine Spirit. Feed it the special horse feed, thereby soothing the spirit. Finally, give it the Arcanite Barding so it may bless it."), { faction = "Alliance", ["class"] = "PALADIN" }),
            T(7643, "qu_ancient_equine_spirit", { faction = "Alliance", ["class"] = "PALADIN" }),
        } },
        { before = nil, steps = {
            A(7563, "qu_mor_zul_bloodbringer", { ["class"] = "WARLOCK" }),
            D(7563, L("Apporter 30 bouteilles de Sang de bêtes enragées à Mor'zul Bloodbringer dans les Steppes ardentes.", "Bring 30 bottles of Raging Beast's Blood to Mor'zul Bloodbringer in the Burning Steppes."), { ["class"] = "WARLOCK", map = 1428, x = 12.6, y = 31.4 }),
            T(7563, "qu_mor_zul_bloodbringer", { ["class"] = "WARLOCK" }),
            A(7564, "qu_mor_zul_bloodbringer", { ["class"] = "WARLOCK" }),
            D(7564, L("Apporter la Caisse de sang à Gorzeeki Wildeyes dans les Steppes ardentes.", "Bring the Case of Blood to Gorzeeki Wildeyes in the Burning Steppes."), { ["class"] = "WARLOCK", map = 1428, x = 12.6, y = 31.4 }),
            T(7564, "qu_gorzeeki_wildeyes", { ["class"] = "WARLOCK" }),
            A(7623, "qu_gorzeeki_wildeyes", { ["class"] = "WARLOCK" }),
            D(7623, L("Achetez des Potions des ténèbres à Gorzeeki dans les Steppes ardentes. Servez-vous en pour vous rendre à Jaedenar, et parlez au seigneur Banehollow.", "Purchase Shadowy Potions from Gorzeeki in the Burning Steppes. Use the potions to travel through Jaedenar, and speak with Lord Banehollow."), { ["class"] = "WARLOCK", map = 1428, x = 12.4, y = 31.4 }),
            T(7623, "qu_lord_banehollow", { ["class"] = "WARLOCK" }),
            A(7624, "qu_lord_banehollow", { ["class"] = "WARLOCK" }),
            D(7624, L("Affrontez Ulathek, puis apportez le Coeur du traître au seigneur Banehollow à Jaedenar.", "Confront Ulathek, then bring The Traitor's Heart to Lord Banehollow in Jaedenar."), { ["class"] = "WARLOCK", map = 1448, x = 36, y = 44.4 }),
            T(7624, "qu_lord_banehollow", { ["class"] = "WARLOCK" }),
            A(7625, "qu_lord_banehollow", { ["class"] = "WARLOCK" }),
            D(7625, L("Acheter de la Poussière d’étoiles xorothienne à Ur’dan. L’apporter à Gorzeeki dans les Steppes ardentes.", "Purchase Xorothian Stardust from Ur'dan. Bring it to Gorzeeki Wildeyes in the Burning Steppes."), { ["class"] = "WARLOCK", map = 1448, x = 36, y = 44.4 }),
            T(7625, "qu_gorzeeki_wildeyes", { ["class"] = "WARLOCK" }),
            A(7626, "qu_mor_zul_bloodbringer", { ["class"] = "WARLOCK" }),
            D(7626, L("Apportez 10 Elixirs de Puissance de l'ombre à Gorzeeki Wildeyes dans les Steppes ardentes.", "Bring 10 Elixirs of Shadow Power to Gorzeeki Wildeyes in the Burning Steppes."), { ["class"] = "WARLOCK", map = 1428, x = 12.6, y = 31.4 }),
            T(7626, "qu_gorzeeki_wildeyes", { ["class"] = "WARLOCK" }),
            A(7627, "qu_mor_zul_bloodbringer", { ["class"] = "WARLOCK" }),
            D(7627, L("Apportez 6 Grands éclats brilliants et 25 charges de Minerai de sombre fer à Gorzeeki dans les Steppes ardentes.", "Bring 6 Large Brilliant Shards and 25 Dark Iron Ore to Gorzeeki in the Burning Steppes."), { ["class"] = "WARLOCK", map = 1428, x = 12.6, y = 31.4 }),
            T(7627, "qu_gorzeeki_wildeyes", { ["class"] = "WARLOCK" }),
            A(7628, "qu_mor_zul_bloodbringer", { ["class"] = "WARLOCK" }),
            D(7628, L("Apportez 35 Ecailles de dragon noir à Gozeeki WIldeyes dans les Steppes ardentes.", "Bring 35 Black Dragonscales to Gorzeeki Wildeyes in the Burning Steppes."), { ["class"] = "WARLOCK", map = 1428, x = 12.6, y = 31.4 }),
            T(7628, "qu_gorzeeki_wildeyes", { ["class"] = "WARLOCK" }),
            A(7629, "qu_gorzeeki_wildeyes", { ["class"] = "WARLOCK" }),
            D(7629, L("Apporter le Diablotin en bouteille au laboratoire d'alchimie de la Scholomance. Une fois le parchemin créé, retournez voir Gorzeeki Wildeyes.", "Bring the Imp in a Jar to the alchemy lab in the Scholomance. After the parchment is created, return the jar to Gorzeeki Wildeyes."), { ["class"] = "WARLOCK" }),
            T(7629, "qu_gorzeeki_wildeyes", { ["class"] = "WARLOCK" }),
            A(7630, "qu_gorzeeki_wildeyes", { ["class"] = "WARLOCK" }),
            D(7630, L("Apporter 3 Barres d’arcanite à Gorzeeki dans les Steppes ardentes.", "Bring 3 Arcanite Bars to Gorzeeki in the Burning Steppes."), { ["class"] = "WARLOCK", map = 1428, x = 12.4, y = 31.4 }),
            T(7630, "qu_gorzeeki_wildeyes", { ["class"] = "WARLOCK" }),
            A(7631, "qu_mor_zul_bloodbringer", { ["class"] = "WARLOCK" }),
            D(7631, L("Lisez les Instructions de Mor’zul. Invoquez un Destrier de l’effroi xorothien, vainquez-le, et liez son esprit.", "Read Mor'zul's Instructions. Summon a Xorothian Dreadsteed, defeat it, then bind its spirit to you."), { ["class"] = "WARLOCK", map = 1428, x = 12.6, y = 31.4 }),
            T(7631, "qu_dreadsteed_spirit", { ["class"] = "WARLOCK" }),
        } },
    },
} end)

ns:AddGuideSteps("DMN", function() return {
    titles = {
        [7498] = L("Garona : une étude en discrétion et en trahison", "Garona: A Study on Stealth and Treachery"),
        [7499] = L("Le codex de défense", "Codex of Defense"),
        [7500] = L("Les recettes de l’arcaniste", "The Arcanist's Cookbook"),
        [7501] = L("La lumière et comment l'altérer", "The Light and How To Swing It"),
        [7502] = L("Contrôler les ombres", "Harnessing Shadows"),
        [7503] = L("La plus grande race de chasseurs", "The Greatest Race of Hunters"),
        [7504] = L("Sainte Bolognaise : Ce que la lumière ne vous dit pas", "Holy Bologna: What the Light Won't Tell You"),
        [7505] = L("Le Horion de givre et vous", "Frost Shock and You"),
        [7506] = L("Le Rêve d'Emeraude…", "The Emerald Dream..."),
    },
    groups = {
        { before = nil, steps = {
            A(7506, nil, { onlyIfStarted = true, text = L("The Emerald Dream: Drops in Dire Maul; also tradeable", "The Emerald Dream: Drops in Dire Maul; also tradeable"), ["class"] = "DRUID" }),
            D(7506, L("Rendez ce livre à ses légitimes propriétaires.", "Return the book to its rightful owners."), { onlyIfStarted = true, ["class"] = "DRUID" }),
            T(7506, "qu_lorekeeper_javon", { onlyIfStarted = true, ["class"] = "DRUID" }),
        } },
        { before = nil, steps = {
            A(7503, nil, { onlyIfStarted = true, text = L("The Greatest Race of Hunters: Drops in Dire Maul; also tradeable", "The Greatest Race of Hunters: Drops in Dire Maul; also tradeable"), ["class"] = "HUNTER" }),
            D(7503, L("Rendez ce livre à ses légitimes propriétaires.", "Return the book to its rightful owners."), { onlyIfStarted = true, ["class"] = "HUNTER" }),
            T(7503, "qu_lorekeeper_mykos", { onlyIfStarted = true, ["class"] = "HUNTER" }),
        } },
        { before = nil, steps = {
            A(7500, nil, { onlyIfStarted = true, text = L("The Arcanist's Cookbook: Drops in Dire Maul; also tradeable", "The Arcanist's Cookbook: Drops in Dire Maul; also tradeable"), ["class"] = "MAGE" }),
            D(7500, L("Rendez ce livre à ses légitimes propriétaires.", "Return the book to its rightful owners."), { onlyIfStarted = true, ["class"] = "MAGE" }),
            T(7500, "qu_lorekeeper_kildrath", { onlyIfStarted = true, ["class"] = "MAGE" }),
        } },
        { before = nil, steps = {
            A(7501, nil, { onlyIfStarted = true, text = L("The Light and How to Swing It: Drops in Dire Maul; also tradeable", "The Light and How to Swing It: Drops in Dire Maul; also tradeable"), faction = "Alliance", ["class"] = "PALADIN" }),
            D(7501, L("Rendez ce livre à ses légitimes propriétaires.", "Return the book to its rightful owners."), { onlyIfStarted = true, faction = "Alliance", ["class"] = "PALADIN" }),
            T(7501, "qu_lorekeeper_mykos", { onlyIfStarted = true, faction = "Alliance", ["class"] = "PALADIN" }),
        } },
        { before = nil, steps = {
            A(7504, nil, { onlyIfStarted = true, text = L("Holy Bologna: What the Light Won't Tell You: Drops in Dire Maul; also tradeable", "Holy Bologna: What the Light Won't Tell You: Drops in Dire Maul; also tradeable"), ["class"] = "PRIEST" }),
            D(7504, L("Rendez ce livre à ses légitimes propriétaires.", "Return the book to its rightful owners."), { onlyIfStarted = true, ["class"] = "PRIEST" }),
            T(7504, "qu_lorekeeper_javon", { onlyIfStarted = true, ["class"] = "PRIEST" }),
        } },
        { before = nil, steps = {
            A(7498, nil, { onlyIfStarted = true, text = L("Garona: A Study on Stealth and Treachery: Drops in Dire Maul; also tradeable", "Garona: A Study on Stealth and Treachery: Drops in Dire Maul; also tradeable"), ["class"] = "ROGUE" }),
            D(7498, L("Rendez ce livre à ses légitimes propriétaires.", "Return the book to its rightful owners."), { onlyIfStarted = true, ["class"] = "ROGUE" }),
            T(7498, "qu_lorekeeper_kildrath", { onlyIfStarted = true, ["class"] = "ROGUE" }),
        } },
        { before = nil, steps = {
            A(7505, nil, { onlyIfStarted = true, text = L("Frost Shock and You: Drops in Dire Maul; also tradeable", "Frost Shock and You: Drops in Dire Maul; also tradeable"), faction = "Horde", ["class"] = "SHAMAN" }),
            D(7505, L("Rendez ce livre à ses légitimes propriétaires.", "Return the book to its rightful owners."), { onlyIfStarted = true, faction = "Horde", ["class"] = "SHAMAN" }),
            T(7505, "qu_lorekeeper_javon", { onlyIfStarted = true, faction = "Horde", ["class"] = "SHAMAN" }),
        } },
        { before = nil, steps = {
            A(7502, nil, { onlyIfStarted = true, text = L("Harnessing Shadows: Drops in Dire Maul; also tradeable", "Harnessing Shadows: Drops in Dire Maul; also tradeable"), ["class"] = "WARLOCK" }),
            D(7502, L("Rendez ce livre à ses légitimes propriétaires.", "Return the book to its rightful owners."), { onlyIfStarted = true, ["class"] = "WARLOCK" }),
            T(7502, "qu_lorekeeper_mykos", { onlyIfStarted = true, ["class"] = "WARLOCK" }),
        } },
        { before = nil, steps = {
            A(7499, nil, { onlyIfStarted = true, text = L("Codex of Defense: Drops in Dire Maul; also tradeable", "Codex of Defense: Drops in Dire Maul; also tradeable"), ["class"] = "WARRIOR" }),
            D(7499, L("Rendez ce livre à ses légitimes propriétaires.", "Return the book to its rightful owners."), { onlyIfStarted = true, ["class"] = "WARRIOR" }),
            T(7499, "qu_lorekeeper_kildrath", { onlyIfStarted = true, ["class"] = "WARRIOR" }),
        } },
    },
} end)

ns:AddGuideSteps("STRAT", function() return {
    titles = {
        [5122] = L("Le médaillon de la Foi", "The Medallion of Faith"),
        [5961] = L("Le champion de la reine banshee", "The Champion of the Banshee Queen"),
        [6022] = L("Tuer utile", "To Kill With Purpose"),
        [6042] = L("Les petits soucis de la non-vie", "Un-Life's Little Annoyances"),
        [6136] = L("Le corpulent", "The Corpulent One"),
    },
    groups = {
        { before = 5125, steps = {
            A(5122, "n10917"),
            D(5122, L("Récupérez le médaillon de la Foi sur Malor le Zélote, dans le Bastion écarlate, et rapportez-le à Aurius.", "Retrieve the Medallion of Faith from Malor the Zealous in the Scarlet Bastion and bring it back to Aurius.")),
            T(5122, "n10917"),
        } },
        { before = 6135, steps = {
            A(6042, "n11878", { faction = "Horde" }),
            D(6042, L("Tuer 20 Chauves-souris pestiférées nuisibles et 10 Chauves-souris pestiférées monstrueuses. Retourner voir Nathanos le Flétrisseur quand ce sera fait.", "Slay 20 Noxious Plaguebats and 10 Monstrous Plaguebats. Return to Nathanos Blightcaller when you are finished."), { faction = "Horde", map = 1423, x = 22.2, y = 64.3 }),
            T(6042, "n11878", { faction = "Horde" }),
            A(6022, "n11878", { faction = "Horde" }),
            D(6022, L("Allez à l'est à la Croisée de Corin et détruisez les membres du Fléau qui habitent la ville. Rassemblez sept morceaux de Pourriture vivante en moins de dix minutes. Utilisez le Mortier et le pilon pour réduire la Pourriture vivante en Pourriture coagulée.", "Travel to Corin's Crossing to the east and slaughter the Scourge that inhabit the town. Collect 7 pieces of Living Rot in under 10 minutes. Use the Mortar and Pestle to grind the Living Rot into Coagulated Rot."), { faction = "Horde", map = 1423, x = 22.2, y = 64.3 }),
            T(6022, "n11878", { faction = "Horde" }),
        } },
        { before = 6163, steps = {
            A(6136, "n11878", { faction = "Horde" }),
            T(6136, "n11878", { faction = "Horde" }),
        } },
        { before = 6133, steps = {
            A(5961, "qu_lady_sylvanas_windrunner", { faction = "Horde" }),
            T(5961, "n11878", { faction = "Horde" }),
        } },
    },
} end)

ns:AddGuideSteps("SCHOLO", function() return {
    titles = {
        [4907] = L("Tinkee Steamboil", "Tinkee Steamboil"),
        [7563] = L("Rage de sang", "Rage of Blood"),
        [7564] = L("Gorzeeki Wildeyes", "Wildeyes"),
        [7623] = L("Le seigneur Banehollow", "Lord Banehollow"),
        [7624] = L("Ulathek le traître", "Ulathek the Traitor"),
        [7625] = L("Poussière d'étoile xorothienne", "Xorothian Stardust"),
        [7629] = L("Livraison de diablotin", "Imp Delivery"),
        [7637] = L("L'accent sur le sacrifice", "Emphasis on Sacrifice"),
        [7639] = L("Des preuves de jugement", "To Show Due Judgment"),
        [7640] = L("Exorciser Val-Terreur", "Exorcising Terrordale"),
        [7641] = L("L'œuvre de Grimand Elmore", "The Work of Grimand Elmore"),
        [7642] = L("Une ribambelle d'objets", "Collection of Goods"),
        [7643] = L("L'ancien esprit équin", "Ancient Equine Spirit"),
        [7644] = L("Le caparaçon en arcanite béni", "Blessed Arcanite Barding"),
        [7645] = L("Fourrage enrichi en manne", "Manna-Enriched Horse Feed"),
        [7646] = L("Le Clairvoyant", "The Divination Scryer"),
        [7647] = L("Jugement et rédemption", "Judgment and Redemption"),
        [7648] = L("Le chef d'œuvre de Grimand", "Grimand's Finest Work"),
        [7667] = L("Assistance matérielle", "Material Assistance"),
        [7668] = L("La menace de Ravassombre", "The Darkreaver Menace"),
    },
    groups = {
        { before = 4734, steps = {
            A(4907, "n10468"),
            T(4907, "n10267"),
        } },
        { before = nil, steps = {
            A(7563, "qu_mor_zul_bloodbringer", { ["class"] = "WARLOCK" }),
            D(7563, L("Apporter 30 bouteilles de Sang de bêtes enragées à Mor'zul Bloodbringer dans les Steppes ardentes.", "Bring 30 bottles of Raging Beast's Blood to Mor'zul Bloodbringer in the Burning Steppes."), { ["class"] = "WARLOCK", map = 1428, x = 12.6, y = 31.4 }),
            T(7563, "qu_mor_zul_bloodbringer", { ["class"] = "WARLOCK" }),
            A(7564, "qu_mor_zul_bloodbringer", { ["class"] = "WARLOCK" }),
            D(7564, L("Apporter la Caisse de sang à Gorzeeki Wildeyes dans les Steppes ardentes.", "Bring the Case of Blood to Gorzeeki Wildeyes in the Burning Steppes."), { ["class"] = "WARLOCK", map = 1428, x = 12.6, y = 31.4 }),
            T(7564, "qu_gorzeeki_wildeyes", { ["class"] = "WARLOCK" }),
            A(7623, "qu_gorzeeki_wildeyes", { ["class"] = "WARLOCK" }),
            D(7623, L("Achetez des Potions des ténèbres à Gorzeeki dans les Steppes ardentes. Servez-vous en pour vous rendre à Jaedenar, et parlez au seigneur Banehollow.", "Purchase Shadowy Potions from Gorzeeki in the Burning Steppes. Use the potions to travel through Jaedenar, and speak with Lord Banehollow."), { ["class"] = "WARLOCK", map = 1428, x = 12.4, y = 31.4 }),
            T(7623, "qu_lord_banehollow", { ["class"] = "WARLOCK" }),
            A(7624, "qu_lord_banehollow", { ["class"] = "WARLOCK" }),
            D(7624, L("Affrontez Ulathek, puis apportez le Coeur du traître au seigneur Banehollow à Jaedenar.", "Confront Ulathek, then bring The Traitor's Heart to Lord Banehollow in Jaedenar."), { ["class"] = "WARLOCK", map = 1448, x = 36, y = 44.4 }),
            T(7624, "qu_lord_banehollow", { ["class"] = "WARLOCK" }),
            A(7625, "qu_lord_banehollow", { ["class"] = "WARLOCK" }),
            D(7625, L("Acheter de la Poussière d’étoiles xorothienne à Ur’dan. L’apporter à Gorzeeki dans les Steppes ardentes.", "Purchase Xorothian Stardust from Ur'dan. Bring it to Gorzeeki Wildeyes in the Burning Steppes."), { ["class"] = "WARLOCK", map = 1448, x = 36, y = 44.4 }),
            T(7625, "qu_gorzeeki_wildeyes", { ["class"] = "WARLOCK" }),
            A(7629, "qu_gorzeeki_wildeyes", { ["class"] = "WARLOCK" }),
            D(7629, L("Apporter le Diablotin en bouteille au laboratoire d'alchimie de la Scholomance. Une fois le parchemin créé, retournez voir Gorzeeki Wildeyes.", "Bring the Imp in a Jar to the alchemy lab in the Scholomance. After the parchment is created, return the jar to Gorzeeki Wildeyes."), { ["class"] = "WARLOCK" }),
            T(7629, "qu_gorzeeki_wildeyes", { ["class"] = "WARLOCK" }),
        } },
        { before = nil, steps = {
            A(7637, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(7637, L("Rendez-vous à Ironforge et procurez-vous l’Encensoir d’exorcisme du grand prêtre Rohan. Pour vous le procurer, il vous faudra verser une donation de 150 pièces d’or.", "Travel to Ironforge and get High Priest Rohan's Exorcism Censer. You will need to make a donation of 150 gold in order to secure it."), { faction = "Alliance", ["class"] = "PALADIN", map = 1453, x = 49.4, y = 47.6 }),
            T(7637, "qu_high_priest_rohan", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(7639, "qu_high_priest_rohan", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(7639, L("Ramener l’Encensoir d’exorcisme au seigneur Grayson Shadowbreaker, dans le Quartier de cathédrale de Stormwind.", "Return the Exorcism Censer to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."), { faction = "Alliance", ["class"] = "PALADIN", map = 1455, x = 23.4, y = 6.4 }),
            T(7639, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(7640, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(7640, L("Servez-vous de l’Encensoir d’exorcisme pour chasser les esprits qui tourmentent Val-Terreur. Lorsque vous aurez tué 25 Esprits de Val-Terreur, retournez voir le seigneur Grayson Shadowbreaker dans le Quartier de la cathédrale de Stormwind.", "Use the Exorcism Censer to drive out the spirits that torment Terrordale. When you have slain 25 Terrordale Spirits, return to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."), { faction = "Alliance", ["class"] = "PALADIN", map = 1453, x = 49.4, y = 47.6 }),
            T(7640, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(7641, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            T(7641, "qu_grimand_elmore", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(7642, "qu_grimand_elmore", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(7642, L("Apporter 40 Etoffes runiques, 6 Barres d’arcanite, 10 Larmes d’Arthas, 5 Fioles d’eau sacrée de Stratholme, et 150 pièces d’or à Grimand Elmore, au Quartier des nains de Stormwind.", "Bring 40 Runecloth, 6 Arcanite Bars, 10 Arthas' Tears, 5 Stratholme Holy Water vials, and 150 gold to Grimand Elmore in the Dwarven District of Stormwind."), { faction = "Alliance", ["class"] = "PALADIN" }),
            T(7642, "qu_grimand_elmore", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(7648, "qu_grimand_elmore", { faction = "Alliance", ["class"] = "PALADIN" }),
            T(7648, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(7645, "qu_merideth_carlson", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(7645, L("Récupérer 20 Biscuits enrichis en manne, l’ingrédient vital qui permet de préparer du Fourrage enrichi en manne, pour le compte de Merideth Carlson de Southore dans les contreforts d’Hillsbrad. L’Aube d’argent est la seule à fabriquer ces biscuits. Vous devrez également lui donner 50 pièces d’or pour apaiser sa susceptibilité.", "Retrieve 20 Enriched Manna Biscuits - the key ingredient in making Manna-Enriched Horse Feed - for Merideth Carlson at Southshore in the Hillsbrad Foothills. The Argent Dawn is known as the sole purveyor of the biscuits. You also need to give her 50 gold to soothe her ruffled sensibilities."), { faction = "Alliance", ["class"] = "PALADIN", map = 1424, x = 52, y = 55.6 }),
            T(7645, "qu_merideth_carlson", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(7643, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(7643, L("Procurez-vous un aliment pour chevaux capable de nourrir un esprit équin. Il semble que Merideth Carlson, à Southshore, sache en fabriquer. Ensuite, rendez-vous au donjon de Hache-tripes en Feralas, et tuez Tendris Crochebois. Sa mort libérera l’Ancien esprit équin. Nourrissez-le avec l’aliment spécial afin de l’apaiser. Enfin, donnez-lui le Caparaçon d’arcanite pour qu’il le bénisse.", "Acquire special horse feed used for feeding a spirit horse. Merideth Carlson in Southshore apparently is the source for such food. Travel to the Dire Maul dungeon in Feralas and slay Tendris Warpwood. Doing so will free the Ancient Equine Spirit. Feed it the special horse feed, thereby soothing the spirit. Finally, give it the Arcanite Barding so it may bless it."), { faction = "Alliance", ["class"] = "PALADIN" }),
            T(7643, "qu_ancient_equine_spirit", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(7644, "qu_ancient_equine_spirit", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(7644, L("Retourner dans le quartier de la cathédrale de Stormwind avec le Caparaçon d’arcanite béni pour voir le seigneur Grayson Shadowbreaker.", "Return with the Blessed Arcanite Barding to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."), { faction = "Alliance", ["class"] = "PALADIN" }),
            T(7644, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(7646, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(7646, L("Apportez un Diamant d’Azeroth et un Diamant noir en parfait état au seigneur Grayson Shadowbreaker dans le Quartier de la cathédrale de Stormwind.", "Bring an Azerothian Diamond and a Pristine Black Diamond to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."), { faction = "Alliance", ["class"] = "PALADIN", map = 1453, x = 49.4, y = 47.6 }),
            T(7646, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            A(7647, "qu_lord_grayson_shadowbreaker", { faction = "Alliance", ["class"] = "PALADIN" }),
            D(7647, L("Utilisez le Clairvoyant au coeur du sous-sol du Grand ossuaire, dans la Scholomance. Cela attirera des esprits que vous devrez juger. Lorsqu’ils seront vaincus, le Chevalier de la mort Ravassombre apparaîtra. Vainquez-le et purifiez l’âme du destrier déchu. Ensuite, donnez l’Ame rachetée du destrier et le Caparaçon enchanté et béni au Destrier déchu de Ravassombre.", "Use the Divination Scryer in the heart of the Great Ossuary's basement in the Scholomance. Doing so will bring forth the spirits you must judge. Defeating these spirits will summon forth Death Knight Darkreaver. Defeat him and reclaim the lost soul of the fallen charger. Give the Charger's Redeemed Soul and the Blessed Enchanted Barding to Darkreaver's Fallen Charger."), { faction = "Alliance", ["class"] = "PALADIN" }),
            T(7647, "qu_darkreaver_s_fallen_charger", { faction = "Alliance", ["class"] = "PALADIN" }),
        } },
        { before = nil, steps = {
            A(7667, "qu_sagorne_creststrider", { faction = "Horde", ["class"] = "SHAMAN" }),
            D(7667, L("Si vous voulez aider Sagorne Crestrider de la vallée de la Sagesse d'Orgrimmar, apportez-lui un Diamant d’Azeroth et un Diamant noir en parfait état.", "If you are interested in helping Sagorne Crestrider in Orgrimmar's Valley of Wisdom, bring him an Azerothian Diamond and a Pristine Black Diamond."), { faction = "Horde", ["class"] = "SHAMAN", map = 1454, x = 38.4, y = 36 }),
            T(7667, "qu_sagorne_creststrider", { faction = "Horde", ["class"] = "SHAMAN" }),
            A(7668, "qu_sagorne_creststrider", { faction = "Horde" }),
            D(7668, L("Servez-vous du Clairvoyant au centre du sous-sol du Grand ossuaire de la Scholomance. Cela attirera des esprits que vous devrez combattre. Les vaincre fera apparaître le Chevalier de la mort Ravassombre. Tuez-le. Ramenez la Tête de Ravassombre à Sagorne Crestrider de la vallée de la Sagesse, à Orgrimmar.", "Use the Divination Scryer in the heart of the Great Ossuary's basement in the Scholomance. Doing so will bring forth spirits you must fight. Defeating these spirits will summon forth Death Knight Darkreaver; defeat him. Bring Darkreaver's Head to Sagorne Creststrider in the Valley of Wisdom, Orgrimmar."), { faction = "Horde" }),
            T(7668, "qu_sagorne_creststrider", { faction = "Horde" }),
        } },
    },
} end)

-- Translations of the new texts (the English text is the key, see Core\Locale.lua)
do local C = ns.CONTENT.de
    C["Defend Daphne Stilwell from the Defias attack."] = "Verteidigt Daphne Stilwell vor dem Angriff der Defias. Keiner Eurer Geister darf aus seinen irdischen Fesseln befreit werden, wenn Ihr erfolgreich sein wollt. Sprecht erneut mit Daphne Stilwell, wenn Ihr erfolgreich wart."
    C["The Tome of Valor"] = "Der Foliant der Ehre"
    C["The Test of Righteousness"] = "Die Prüfung der Rechtschaffenheit"
    C["Using Jordan's Weapon Notes, find some Whitestone Oak Lumber, Bailor's Refined Ore Shipment, Jordan's Smithing Hammer, and a Kor Gem, and return them to Jordan Stilwell in Ironforge."] = "Sucht mit Jordans Waffennotizen etwas Weißsteineichenholz, Bailors aufbereitete Erzlieferung, Jordans Schmiedehammer und einen Kor-Edelstein und bringt alles zusammen zu Jordan Stilwell in Ironforge."
    C["Wait for Jordan Stilwell to finish forging a weapon for you."] = "Wartet, bis Jordan Stilwell eine Waffe für Euch geschmiedet hat."
    C["The Orb of Soran'ruk"] = "Die Kugel von Soran'ruk"
    C["Strange Water Globe: Drops from Baron Aquanis inside Blackfathom Deeps."] = "Seltsame Wasserkugel, Beute von Baron Aquanis in der Tiefschwarzen Grotte"
    C["Bring the Strange Water Globe to Je'neu Sancrea at Zoram'gar Outpost, Ashenvale."] = "Bringt die seltsame Wasserkugel zu Je'neu Sancrea im Zoram'gar-Außenposten im Eschental."
    C["The Greenwarden"] = "Der grüne Wächter"
    C["Kill 15 Mosshide Gnolls and 10 Mosshide Mongrels, then return to Rethiel the Greenwarden."] = "Tötet 15 Mooshide-Gnolle und 10 Mooshide-Mischlinge und kehrt dann zu Rethiel dem Grünen Wächter zurück."
    C["Tramping Paws"] = "Stampfende Pfoten"
    C["Bring Rethiel the Greenwarden 9 Crude Flints."] = "Bringt Rethiel dem Grünen Wächter 9 grobe Feuersteine."
    C["Fire Taboo"] = "Feuertabu"
    C["Kill 12 Fen Creepers, then return to Rethiel the Greenwarden."] = "Tötet 12 Sumpfkriecher und kehrt dann zu Rethiel dem Grünen Wächter zurück."
    C["Blisters on The Land"] = "Blasen im Land"
    C["Brother Anton"] = "Bruder Anton"
    C["Bring an Infernal Orb to Tabetha in Dustwallow Marsh."] = "Bringt eine Höllenkugel zu Tabetha in den Marschen von Dustwallow."
    C["The Infernal Orb"] = "Die Höllenkugel"
    C["Kill the Demon of the Orb, then speak with Tabetha."] = "Tötet den Dämon der Kugel und sprecht dann mit Tabetha."
    C["The Exorcism"] = "Die Austreibung"
    C["Retrieve an Obsidian Power Source and bring it to Tabetha in Dustwallow Marsh."] = "Beschafft Euch eine Obsidiankraftquelle und bringt sie in die Marschen von Dustwallow zu Tabetha."
    C["Power in Uldaman"] = "Macht in Uldaman"
    C["The Brassbolts Brothers"] = "Die Brüder Brassbolt"
    C["Tabetha's Task"] = "Tabethas Aufgabe"
    C["Collect 15 Bloodpetals and return to Muigin."] = "Sammelt 15 Blutblüten und kehrt zu Muigin zurück."
    C["Muigin and Larion"] = "Muigin und Larion"
    C["A Visit to Gregan"] = "Ein Besuch bei Gregan"
    C["Collect 5 samples of Atal'ai Haze, then return to Muigin in Un'Goro Crater."] = "Sammelt 5 Proben Dunst der Atal'ai und bringt sie Muigin im Un'Goro Krater."
    C["Haze of Evil"] = "Der Dunst des Bösen"
    C["Collect 8 Bloodcap and 8 Gorishi Stings, and return to Torwa Pathfinder in Un'Goro Crater."] = "Sammelt Blutkappenpilze und Gorishistachel und kehrt zu Torwa Pathfinder im Un'Goro Krater zurück."
    C["Bloodpetal Poison"] = "Blutblütengift"
    C["Stab a Devilsaur with the Devilsaur Barb. Return to Torwa Pathfinder in Un'Goro Crater when you have completed this task."] = "Stecht einen Teufelssaurier mit dem Teufelssaurierhaken."
    C["Toxic Test"] = "Giftexperiment"
    C["Retrieve a Putrid Vine from the guardian at the bottom of the Sunken Temple and return to Torwa Pathfinder."] = "Beschafft Euch eine Fäulnisranke von dem Wächter auf dem Grund des versunkenen Tempels und kehrt zu Torwa Pathfinder zurück."
    C["A Better Ingredient"] = "Eine bessere Zutat"
    C["The Hunter's Charm"] = "Der Talisman des Jägers"
    C["Bring a pair of Perfect Courser Antlers to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast of the Ruins of Eldarath."] = "Bringt ein perfektes Rennergeweih zu Ogtinc nach Azshara. Er befindet sich auf den Klippen nordöstlich der Ruinen von Eldarath."
    C["Courser Antlers"] = "Gehörnte Renner"
    C["Bring 6 Wavethrasher Scales to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "Bringt 6 Wellenhauerschuppen zu Ogtinc in Azshara. Ogtinc wohnt oberhalb des Kliffs, nordöstlich der Ruinen von Eldarath."
    C["Wavethrashing"] = "Wellenjagd"
    C["Bring the Tooth of Morphaz to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "Bringt Morphaz' Zahn zu Ogtinc in Azshara. Ogtinc wohnt oberhalb des Kliffs, nordöstlich der Ruinen von Eldarath."
    C["The Green Drake"] = "Der grüne Drache"
    C["Magecraft"] = "Geschick der Magier"
    C["Bring 10 Glittering Dust to Archmage Xylem."] = "Bringt Erzmagier Xylem in Azshara 10 glitzernde Staubproben."
    C["Magic Dust"] = "Magischer Staub"
    C["Collect 6 Enchanted Coral and return them to Archmage Xylem."] = "Sammelt 6 verzauberte Korallen und bringt sie zum Erzmagier Xylem."
    C["The Siren's Coral"] = "Die Koralle der Sirenen"
    C["Retrieve the Arcane Shard from Morphaz and return to Archmage Xylem."] = "Beschafft den arkanen Splitter von Morphaz' Leichnam und kehrt mit ihm zu Erzmagier Xylem zurück."
    C["Destroy Morphaz"] = "Vernichtet Morphaz"
    C["Chillwind Point"] = "Chillwindspitze"
    C["Collect 20 Minion's Scourgestones and bring them to High Priest Thel'danis in the Western Plaguelands."] = "Sammelt 20 Geißelsteine des Dieners und bringt sie zu Hohepriester Thel'danis in den westlichen Pestländern."
    C["Dispelling Evil"] = "Austreibung des Bösen"
    C["Bring the Inert Scourgestone to Commander Ashlan Valorfist in Chillwind Point."] = "Bringt den gereinigten Geißelstein zu Kommandant Ashlan Valorfist an der Chillwindspitze."
    C["Inert Scourgestones"] = "Gereinigte Geißelsteine"
    C["Bring the voodoo feathers to Ashlam Valorfist."] = "Bringt die Voodoofedern zu Ashlam Valorfist."
    C["Forging the Mightstone"] = "Erschaffung des Steins der Macht"
    C["Cenarion Aid"] = "Cenarische Hilfe"
    C["Acquire 4 Healthy Courser Glands and bring them to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "Beschafft 4 gesunde Rennerdrüsen und bringt sie zu Ogtinc in Azshara. Ihr findet ihn auf den Klippen, nordöstlich der Ruinen von Eldarath."
    C["Of Coursers We Know"] = "Renner für einen höheren Zweck"
    C["Acquire an Ichor of Undeath for Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "Beschafft ein Sekret des Untodes für Ogtinc in Azshara. Ihr findet ihn auf den Klippen, nordöstlich der Ruinen von Eldarath."
    C["The Ichor of Undeath"] = "Sekret des Untodes"
    C["Kill Morphaz in the sunken temple of Atal'Hakkar, and return his blood to Greta Mosshoof in Felwood. The entrance to the sunken temple can be found in the Swamp of Sorrows."] = "Tötet Morphaz im versunkenen Tempel von Atal'Hakkar und bringt Greta Mosshoof im Teufelswald sein Blut. Der Eingang zum versunkenen Tempel liegt in den Sümpfen des Elends."
    C["Blood of Morphaz"] = "Morphaz' Blut"
    C["A Simple Request"] = "Ein simples Anliegen"
    C["Retrieve the Sealed Azure Bag from the Timbermaw Shaman in Azshara. Then take the bag to Archmage Xylem, also found in Azshara."] = "Erlangt die versiegelte azurblaue Tasche von dem Schamanen der Holzschlundfeste in Azshara zurück. Bringt sie anschließend zum Erzmagier Xylem, der ebenfalls in Azshara zu finden ist."
    C["Sealed Azure Bag"] = "Die versiegelte azurblaue Tasche"
    C["Bring 10 Encoded Fragments to Archmage Xylem in Azshara."] = "Bringt Erzmagier Xylem in Azshara 10 verschlüsselte Fragmente."
    C["Encoded Fragments"] = "Verschlüsselte Fragmente"
    C["Return the Azure Key to Lord Jorach Ravenholdt."] = "Bringt den azurblauen Schlüssel zu Lord Jorach Ravenholdt."
    C["The Azure Key"] = "Der azurblaue Schlüssel"
    C["Collect a sample of air, fire, earth and water for Bath'rah the Windwatcher."] = "Bath'rah der Windbehüter möchte, dass Ihr jeweils eine Probe Luft, Feuer, Erde und Wasser für ihn sammelt."
    C["Elemental Mastery"] = "Elementarbeherrschung"
    C["Bring the pieces for the spirit totem to Bath'rah the Windwatcher."] = "Bringt Bath'rah dem Windbehüter die Komponenten für das Geistertotem."
    C["Spirit Totem"] = "Geistertotem"
    C["Bring the voodoo feathers to Bath'rah the Windwatcher."] = "Bringt Bath'rah dem Windbehüter die Voodoofedern."
    C["Da Voodoo"] = "Die Macht des Voodoos"
    C["Bring a piece of felcloth to Impsy in Felwood."] = "Bringt ein Stück Teufelsstoff zu Impsy im Teufelswald."
    C["An Imp's Request"] = "Die Bitte eines Wichtels"
    C["Hot and Itchy"] = "Heiß und brennend"
    C["Bring 10 Rotting Wood and 4 Bloodvenom Essence to Impsy in Felwood."] = "Bringt 10 Stück faules Holz und 4 Blutgiftessenzen zu Impsy im Teufelswald."
    C["The Wrong Stuff"] = "Das richtige Zeug"
    C["Bring a total of 6 Voodoo Feathers from the trolls in sunken temple."] = "Bringt 6 Voodoofedern von den Trollen aus dem versunkenen Tempel."
    C["Trolls of a Feather"] = "Federn von Trollen"
    C["A Troubled Spirit"] = "Ein geplagter Geist"
    C["Kill 7 Helboar in the Blasted Lands and return to the Fallen Hero of the Horde."] = "Tötet 7 Hölleneber in den verwüsteten Landen und kehrt zu dem gefallenen Helden der Horde zurück."
    C["Warrior Kinship"] = "Kriegerverwandtschaft"
    C["Slaughter the Shadowsworn in the Blasted Lands and return to the Fallen Hero of the Horde."] = "Merzt die Schattenanbeter in den verwüsteten Landen aus und kehrt zum gefallenen Helden der Horde zurück."
    C["War on the Shadowsworn"] = "Krieg den Schattenanbetern"
    C["Bring the Voodoo Feathers from the trolls in the Sunken Temple to the Fallen Hero of the Horde."] = "Bringt die Voodoofedern der Trolle im versunkenen Tempel zu dem gefallenen Helden der Horde."
    C["Voodoo Feathers"] = "Voodoofedern"
    C["Defend Gor'shak."] = "Verteidigt Gor'shak."
    C["What Is Going On?"] = "Was ist los?"
    C["Rocknot's Ale"] = "Rocknots Bier"
    C["Travel to Silithus and search for a Reliquary of Purity within the ruins of Southwind Village. If you are able to find it, return with it to Rabine Saturna in Nighthaven, Moonglade."] = "Reist nach Silithus und sucht in den Ruinen des Südwindpostens nach einem Reliquiar der Reinheit. Sollte Eure Suche Erfolg haben, kehrt zu Rabine Saturna in Nighthaven, Moonglade zurück."
    C["A Reliquary of Purity"] = "Ein Reliquiar der Reinheit"
    C["Shards of the Felvine"] = "Die Splitter der Teufelsranke"
    C["Travel to the Warpwood Quarter of Dire Maul and slay the water elemental, Hydrospawn. Return to Lorekeeper Lydros in the Athenaeum with the Hydrospawn Essence."] = "Reist nach Düsterbruch in das Wucherborkenviertel und besiegt den Wasserelementar Hydrobrut. Kehrt anschließend mit der Hydrobrutessenz, zum Hüter des Wissens Lydros im Athenaeum zurück."
    C["Arcane Refreshment"] = "Arcane Erfrischung"
    C["The Ruins of Kel'Theril"] = "Die Ruinen von Kel'Theril"
    C["Use Jaron's Pick to find the four Highborne Relic Fragments. Bring them to Aurora Skycaller in Eastern Plaguelands."] = "Benutzt Jarons Hacke, um die vier Fragmente des Hochgeborenenrelikts zu suchen. Bringt sie zu Aurora Skycaller in den Östlichen Pestländern."
    C["Troubled Spirits of Kel'Theril"] = "Die gequälten Seelen von Kel'Theril"
    C["Fragments of the Past"] = "Fragmente der Vergangenheit"
    C["Bring an Enchanted Thorium Bar, 5 Crystal Restore, and a Vial of Dire Water to Aurora Skycaller near the Northpass Tower in Eastern Plaguelands."] = "Bringt einen verzauberten Thoriumbarren, 5 Kristallflicker und eine Phiole mit Düsterwasser zu Aurora Skycaller beim Nordpassturm in den östlichen Pestländern."
    C["Travel to Ironforge and get High Priest Rohan's Exorcism Censer. You will need to make a donation of 150 gold in order to secure it."] = "Reist nach Ironforge und besorgt Euch Hohepriester Rohans Weihrauchschwenker. Eine Spende von 150 Gold wird erforderlich sein, um es zu bekommen."
    C["Emphasis on Sacrifice"] = "Ein Opfer darbieten"
    C["Return the Exorcism Censer to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "Bringt den Weihrauchschwenker zu Lord Grayson Shadowbreaker in Stormwind zurück."
    C["To Show Due Judgment"] = "Lass Gerechtigkeit walten"
    C["Use the Exorcism Censer to drive out the spirits that torment Terrordale. When you have slain 25 Terrordale Spirits, return to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "Vertreibt mit Hilfe des Weihrauchschwenkers die Geister im Schreckenstal. Vernichtet 25 Schreckenstalgeister und kehrt anschließend zu Lord Grayson Shadowbreaker im Kathedralenviertel von Stormwind zurück."
    C["Exorcising Terrordale"] = "Der Exorzismus des Schreckenstals"
    C["The Work of Grimand Elmore"] = "Grimand Elmores Werk"
    C["Bring 40 Runecloth, 6 Arcanite Bars, 10 Arthas' Tears, 5 Stratholme Holy Water vials, and 150 gold to Grimand Elmore in the Dwarven District of Stormwind."] = "Bringt 40 Lagen Runenstoff, 6 Arkanitbarren, 10 Artha's Tränen, 5 Phiolen heiliges Wasser aus Stratholme und 150 Gold zu Grimand Elmore im Zwergendistrikt von Stormwind."
    C["Collection of Goods"] = "Fünf Dinge"
    C["Grimand's Finest Work"] = "Grimands feinste Arbeit"
    C["Retrieve 20 Enriched Manna Biscuits - the key ingredient in making Manna-Enriched Horse Feed - for Merideth Carlson at Southshore in the Hillsbrad Foothills. The Argent Dawn is known as the sole purveyor of the biscuits. You also need to give her 50 gold to soothe her ruffled sensibilities."] = "Treibt 20 angereicherte Manakekse - die ausschlaggebende Zutat für die Herstellung von mit Mana angereichertem Pferdefutter - für Merideth Carlson aus Southshore in dem Vorgebirge von Hillsbrad auf. Die Argentumdämmerung ist als alleiniger Händler dieser Kekse bekannt. Zusätzlich müsst Ihr ihre Gefühle noch mit 50 Goldstücken besänftigen."
    C["Manna-Enriched Horse Feed"] = "Mit Mana angereichertes Pferdefutter"
    C["Acquire special horse feed used for feeding a spirit horse. Merideth Carlson in Southshore apparently is the source for such food. Travel to the Dire Maul dungeon in Feralas and slay Tendris Warpwood. Doing so will free the Ancient Equine Spirit. Feed it the special horse feed, thereby soothing the spirit. Finally, give it the Arcanite Barding so it may bless it."] = "Beschafft spezielles Pferdefutter mit dem man ein Geisterpferd füttern kann. Meredith Carlson in Southshore scheint dafür eine recht gute Quelle zu sein. Reist anschließend nach Düsterbruch in Feralas und tötet Tendris Wucherborke. Dies wird den uralten Pferdegeist befreien. Füttert den Geist zur Beruhigung mit dem speziellen Pferdefutter. Gebt dem Pferdegeist das Arkanitpferdegeschirr, um es segnen zu lassen."
    C["Ancient Equine Spirit"] = "Der uralte Pferdegeist"
    C["Bring 30 bottles of Raging Beast's Blood to Mor'zul Bloodbringer in the Burning Steppes."] = "Mor'zul Bloodbringer in der brennenden Steppe möchte, dass Ihr ihm 30 Flaschen mit dem Blut der tobenden Bestien bringt."
    C["Rage of Blood"] = "Kochendes Blut"
    C["Bring the Case of Blood to Gorzeeki Wildeyes in the Burning Steppes."] = "Bringt den Behälter mit Blut zu Gorzeeki Wildeyes in der brennenden Steppe."
    C["Wildeyes"] = "Garzeeki Wildeyes"
    C["Purchase Shadowy Potions from Gorzeeki in the Burning Steppes. Use the potions to travel through Jaedenar, and speak with Lord Banehollow."] = "Erwerbt schattenhaftige Tränke von Gorzeeki in der brennenden Steppe. Benutzt die Tränke um durch Jaedenar zu reisen und sprecht mit Lord Banehollow."
    C["Confront Ulathek, then bring The Traitor's Heart to Lord Banehollow in Jaedenar."] = "Stellt Euch Ulathek und bringt das Herz des Verräters zu Lord Banehollow in Jaedenar."
    C["Ulathek the Traitor"] = "Ulathek der Verräter"
    C["Purchase Xorothian Stardust from Ur'dan. Bring it to Gorzeeki Wildeyes in the Burning Steppes."] = "Erwerbt xorothianischen Sternenstaub von Ur'dan. Bringt es anschließend Gorzeeki in der brennenden Steppe."
    C["Xorothian Stardust"] = "Xorothianischer Sternenstaub"
    C["Bring 10 Elixirs of Shadow Power to Gorzeeki Wildeyes in the Burning Steppes."] = "Bringt 10 Elixiere der Schattenmacht zu Gorzeeki Wildeyes in die brennende Steppe."
    C["Bell of Dethmoora"] = "Die Glocke von Dethmoora"
    C["Bring 6 Large Brilliant Shards and 25 Dark Iron Ore to Gorzeeki in the Burning Steppes."] = "Bringt 6 große glänzende Splitter und 25 Stücke Dunkeleisenerz zu Gorzeeki Wildeyes in die brennende Steppe."
    C["Wheel of the Black March"] = "Das Rad des Schwarzen Marsches"
    C["Bring 35 Black Dragonscales to Gorzeeki Wildeyes in the Burning Steppes."] = "Bringt 35 Schuppen eines schwarzen Drachen zu Gorzeeki Wildeyes in der brennenden Steppe."
    C["Doomsday Candle"] = "Die Altarkerze des Jüngsten Gerichts"
    C["Bring the Imp in a Jar to the alchemy lab in the Scholomance. After the parchment is created, return the jar to Gorzeeki Wildeyes."] = "Bringt den Wichtel im Gefäß in das Alchimielabor in der Scholomance. Bringt nach der Herstellung des Pergaments, dass Gefäß zurück zu Gorzeeki Wildeyes."
    C["Imp Delivery"] = "Wichtellieferung"
    C["Bring 3 Arcanite Bars to Gorzeeki in the Burning Steppes."] = "Bringt 3 Arkanitbarren zu Gorzeeki in der brennenden Steppe."
    C["Arcanite"] = "Arkanit"
    C["Read Mor'zul's Instructions. Summon a Xorothian Dreadsteed, defeat it, then bind its spirit to you."] = "Lest Morzuls Anweisungen. Beschwört ein xorothianisches Schreckensross, besiegt es und bindet seinen Geist an Euch."
    C["Dreadsteed of Xoroth"] = "Schreckensross von Xoroth"
    C["Return the book to its rightful owners."] = "Bringt das Buch seinen rechtmäßigen Besitzern zurück."
    C["The Emerald Dream..."] = "Der Smaragdgrüne Traum"
    C["The Greatest Race of Hunters"] = "Das größte Volk von Jägern"
    C["The Arcanist's Cookbook"] = "Das Arkanistenkochbuch"
    C["The Light and How To Swing It"] = "Vom Licht und wie man es schwingt"
    C["Holy Bologna: What the Light Won't Tell You"] = "Heiliger Fleischklops: Was das Licht Dir nicht erzählt"
    C["Garona: A Study on Stealth and Treachery"] = "Garona: Eine Studie über Heimlichkeit und Verrat"
    C["Frost Shock and You"] = "Frostschock und Du"
    C["Harnessing Shadows"] = "Schatten einspannen"
    C["Codex of Defense"] = "Kodex der Verteidigung"
    C["The Medallion of Faith"] = "Das Medaillon des Glaubens"
    C["Slay 20 Noxious Plaguebats and 10 Monstrous Plaguebats. Return to Nathanos Blightcaller when you are finished."] = "Erschlagt 20 giftige Seuchenfledermäuse und 10 monströse Seuchenfledermäuse. Kehrt zu Nathanos Blightcaller zurück, wenn Ihr fertig seid."
    C["Un-Life's Little Annoyances"] = "Die kleinen Ärgernisse des Un-Lebens"
    C["Travel to Corin's Crossing to the east and slaughter the Scourge that inhabit the town. Collect 7 pieces of Living Rot in under 10 minutes. Use the Mortar and Pestle to grind the Living Rot into Coagulated Rot."] = "Begebt Euch zu Corins Kreuzung im Osten und besiegt die Mitglieder der Geißel, die in der Stadt leben. Sammelt 7 Stücke lebendige Fäulnis in unter 10 Minuten. Zerstoßt die lebendige Fäulnis mit Mörser und Stößel zu geronnener Fäulnis."
    C["To Kill With Purpose"] = "Töten zu einem bestimmten Zweck"
    C["The Corpulent One"] = "Der Korpulente"
    C["The Champion of the Banshee Queen"] = "Der Champion der Bansheekönigin"
    C["Return with the Blessed Arcanite Barding to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "Kehrt mit dem gesegneten Arkanitpferdegeschirr zu Lord Grayson Shadowbreaker in das Kathedralenviertel von Stormwind zurück."
    C["Blessed Arcanite Barding"] = "Gesegnetes Arkanitpferdegeschirr"
    C["Bring an Azerothian Diamond and a Pristine Black Diamond to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "Bringt Lord Grayson Shadowbreaker im Kathedralenviertel von Stormwind einen Azerothianischen Diamanten und einen makellosen schwarzen Diamanten."
    C["The Divination Scryer"] = "Das Orakel der Anrufung"
    C["Use the Divination Scryer in the heart of the Great Ossuary's basement in the Scholomance. Doing so will bring forth the spirits you must judge. Defeating these spirits will summon forth Death Knight Darkreaver. Defeat him and reclaim the lost soul of the fallen charger. Give the Charger's Redeemed Soul and the Blessed Enchanted Barding to Darkreaver's Fallen Charger."] = "Benutzt das Orakel der Anrufung im Herzen des Kellergewölbes des großen Ossuariums, in Scholomance. Damit ruft Ihr die verfluchten Geister, über deren Schicksal Ihr richten müsst. Durch das besiegen der Geister wird der Todesritter Schattensichel beschworen. Besiegt ihn und holt Euch die verlorene Seele des gefallenen Streitrosses. Gebt die Seele des gefallenen Streitrosses und das gesegnete und verzauberte Pferdegeschirr Schattensichels gefallenem Streitross zurück."
    C["Judgment and Redemption"] = "Gerechtigkeit und Erlösung"
    C["If you are interested in helping Sagorne Crestrider in Orgrimmar's Valley of Wisdom, bring him an Azerothian Diamond and a Pristine Black Diamond."] = "Wenn Ihr Sagorne Crestrider im Tal der Weisheit von Orgrimmar helfen wollt, so bringt ihm einen azerothianischen und einen makellosen schwarzen Diamanten."
    C["Material Assistance"] = "Materielle Unterstützung"
    C["Use the Divination Scryer in the heart of the Great Ossuary's basement in the Scholomance. Doing so will bring forth spirits you must fight. Defeating these spirits will summon forth Death Knight Darkreaver; defeat him. Bring Darkreaver's Head to Sagorne Creststrider in the Valley of Wisdom, Orgrimmar."] = "Wendet das Orakel der Anrufung inmitten des Kellergewölbes des großen Ossuariums in Scholomance an. Ihr werdet damit Geister herbeirufen, die es zu bekämpfen gilt. Nach Vernichtung dieser Geister wird der Todesritter Schattensichel auftauchen; besiegt ihn. Bringt Schattensichels Kopf zu Sagorne Creststrider im Tal der Weisheit in Orgrimmar."
    C["The Darkreaver Menace"] = "Die Bedrohung durch Schattensichel"
end
do local C = ns.CONTENT.es
    C["Defend Daphne Stilwell from the Defias attack."] = "Defiende a Daphne Fontana del ataque de los Defias. Si quieres tener éxito, vuestros espíritus no pueden salir de sus espirales mortales. Cuando lo hayas conseguido, vuelve a hablar con Daphne Fontana."
    C["The Tome of Valor"] = "Libro del valor"
    C["The Test of Righteousness"] = "La prueba de rectitud"
    C["Using Jordan's Weapon Notes, find some Whitestone Oak Lumber, Bailor's Refined Ore Shipment, Jordan's Smithing Hammer, and a Kor Gem, and return them to Jordan Stilwell in Ironforge."] = "Consulta la lista y llévale a Jordan Fontana de Forjaz lo siquiente: madera de roble de Piedrablanca, envío de oro refinado de Bailor, el martillo de herrero de Jordan y una gema Kor."
    C["Wait for Jordan Stilwell to finish forging a weapon for you."] = "Espera mientras Jordan Fontana te forja un arma."
    C["The Orb of Soran'ruk"] = "El orbe de Soran’ruk"
    C["Strange Water Globe: Drops from Baron Aquanis inside Blackfathom Deeps."] = "Globo de agua extraño, botín del Barón Aquanis dentro de Cavernas de Brazanegra"
    C["Bring the Strange Water Globe to Je'neu Sancrea at Zoram'gar Outpost, Ashenvale."] = "Lleva el Globo de agua extraño a Je'neu Sancrea en el Puesto de Zoram'gar, Vallefresno."
    C["Baron Aquanis"] = "Barón Aquanis"
    C["The Greenwarden"] = "El Guardaverde"
    C["Kill 15 Mosshide Gnolls and 10 Mosshide Mongrels, then return to Rethiel the Greenwarden."] = "Mata a 15 gnolls Pellejomusgo y 10 mestizos Pellejomusgo y vuelve con Rethiel el Guardaverde."
    C["Tramping Paws"] = "Patas pisoteadoras"
    C["Bring Rethiel the Greenwarden 9 Crude Flints."] = "Lleva 9 pedernales rudimentarios a Rethiel el Guardaverde."
    C["Fire Taboo"] = "Tabú del fuego"
    C["Kill 12 Fen Creepers, then return to Rethiel the Greenwarden."] = "Mata a 12 reptadores del pantano y vuelve con Rethiel el Guardaverde."
    C["Blisters on The Land"] = "Ampollas en la tierra"
    C["Brother Anton"] = "Hermano Antón"
    C["Bring an Infernal Orb to Tabetha in Dustwallow Marsh."] = "Lleva un orbe infernal a Tabetha en el Marjal Revolcafango."
    C["The Infernal Orb"] = "El orbe infernal"
    C["Kill the Demon of the Orb, then speak with Tabetha."] = "Mata al demonio del orbe y habla con Tabetha."
    C["The Exorcism"] = "El exorcismo"
    C["Retrieve an Obsidian Power Source and bring it to Tabetha in Dustwallow Marsh."] = "Hazte con una fuente de poder obsidiano y llévasela a Tabetha en el Marjal Revolcafango."
    C["Power in Uldaman"] = "Poder en Uldaman"
    C["The Brassbolts Brothers"] = "Los hermanos Pernolatón"
    C["Tabetha's Task"] = "La tarea de Tabetha"
    C["Collect 15 Bloodpetals and return to Muigin."] = "Recoge 15 pétalos de sangre y ve a ver a Muigin."
    C["Muigin and Larion"] = "Muigin y Larion"
    C["A Visit to Gregan"] = "Visita a Gregan"
    C["Collect 5 samples of Atal'ai Haze, then return to Muigin in Un'Goro Crater."] = "Reúne 5 muestras de bruma Atal'ai y después ve a ver de nuevo a Muigin al Cráter de Un'Goro."
    C["Haze of Evil"] = "Bruma del mal"
    C["Torwa Pathfinder"] = "Torwa Abrecaminos"
    C["Collect 8 Bloodcap and 8 Gorishi Stings, and return to Torwa Pathfinder in Un'Goro Crater."] = "Reúne 8 champiñones de sangre y 8 aguijones Gorishi, y ve a ver de nuevo a Torwa Abrecaminos al Cráter de Un'Goro."
    C["Bloodpetal Poison"] = "Veneno de pétalo de sangre"
    C["Stab a Devilsaur with the Devilsaur Barb. Return to Torwa Pathfinder in Un'Goro Crater when you have completed this task."] = "Clávale la púa de devilsaurio a un devilsaurio. Ve a ver de nuevo a Torwa Abrecaminos al Cráter de Un'Goro cuando hayas completado tu tarea."
    C["Toxic Test"] = "Prueba de toxicidad"
    C["Retrieve a Putrid Vine from the guardian at the bottom of the Sunken Temple and return to Torwa Pathfinder."] = "Consigue una vid pútrida de las que custodia el guardián en las profundidades del Templo Sumergido y después ve a ver de nuevo a Torwa Abrecaminos."
    C["A Better Ingredient"] = "Un ingrediente mejor"
    C["The Hunter's Charm"] = "El talismán del cazador"
    C["Bring a pair of Perfect Courser Antlers to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast of the Ruins of Eldarath."] = "Llévale un par de cuernos de corcel perfectos a Ogtinc en Azshara. Ogtinc vive en lo alto del precipicio al noreste de las Ruinas de Eldarath."
    C["Courser Antlers"] = "Cuernos de corcel"
    C["Bring 6 Wavethrasher Scales to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "Llévale 6 escamas de vándalo marino a Ogtinc en Azshara. Ogtinc vive en lo alto del precipicio al noreste de las Ruinas de Eldarath."
    C["Wavethrashing"] = "Los vándalos marinos"
    C["Bring the Tooth of Morphaz to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "Llévale el colmillo de Morphaz a Ogtinc en Azshara. Ogtinc vive en lo alto del precipicio al noreste de las Ruinas de Eldarath."
    C["The Green Drake"] = "El draco verde"
    C["Magecraft"] = "Pura magia"
    C["Bring 10 Glittering Dust to Archmage Xylem."] = "Llévale 10 puñados de polvo purpuríneo al archimago Xylem."
    C["Magic Dust"] = "El polvo mágico"
    C["Collect 6 Enchanted Coral and return them to Archmage Xylem."] = "Reúne 6 corales encantados y llévaselos al archimago Xylem."
    C["The Siren's Coral"] = "El coral de las sirenas"
    C["Retrieve the Arcane Shard from Morphaz and return to Archmage Xylem."] = "Recupera el fragmento arcano de Morphaz y llévaselo al archimago Xylem."
    C["Destroy Morphaz"] = "Destruye a Morphaz"
    C["Chillwind Point"] = "Alto del Orvallo"
    C["Collect 20 Minion's Scourgestones and bring them to High Priest Thel'danis in the Western Plaguelands."] = "Recoge 20 Piedras de la Plaga de esbirros y entrégaselas al Alto Sacerdote Thel'danis en las Tierras de la Peste del Oeste."
    C["Dispelling Evil"] = "Expulsión de los demonios"
    C["Bring the Inert Scourgestone to Commander Ashlan Valorfist in Chillwind Point."] = "Lleva la Piedra inerte de la Plaga al comandante Ashlam Puñovalor en el Alto del Orvallo."
    C["Inert Scourgestones"] = "Piedras inertes de la Plaga"
    C["Bring the voodoo feathers to Ashlam Valorfist."] = "Lleva las plumas vudú a Ashlam Puñovalor."
    C["Forging the Mightstone"] = "La forja de la piedra del poderío"
    C["Cenarion Aid"] = "Ayuda a Cenarion"
    C["Acquire 4 Healthy Courser Glands and bring them to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "Consigue 4 glándulas de corcel sanos y llévaselas a Ogtinc en Azshara. Ogtinc vive en lo alto del precipicio al noreste de las Ruinas de Eldarath."
    C["Of Coursers We Know"] = "Los corceles Pezuñamusgo"
    C["Acquire an Ichor of Undeath for Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "Consigue un icor de los no-muertos para Ogtinc en Azshara. Ogtinc vive en lo alto del precipicio al noreste de las Ruinas de Eldarath."
    C["The Ichor of Undeath"] = "El icor de los no-muertos"
    C["Kill Morphaz in the sunken temple of Atal'Hakkar, and return his blood to Greta Mosshoof in Felwood. The entrance to the sunken temple can be found in the Swamp of Sorrows."] = "Mata a Morphaz en el hundido Templo de Atal'Hakkar y lleva su sangre a Greta Pezuñamusgo en Frondavil. Encontrarás la entrada al templo hundido en el Pantano de las Penas."
    C["Blood of Morphaz"] = "La sangre de Morphaz"
    C["A Simple Request"] = "Un pedido sencillo"
    C["Retrieve the Sealed Azure Bag from the Timbermaw Shaman in Azshara. Then take the bag to Archmage Xylem, also found in Azshara."] = "Recupera la bolsa azur sellada del chamán Fauces de Madera en Azshara. Llévale entonces la bolsa al archimago Xylem, que también se encuentra en Azshara."
    C["Sealed Azure Bag"] = "Bolsa azur sellada"
    C["Bring 10 Encoded Fragments to Archmage Xylem in Azshara."] = "Llévale 10 fragmentos codificados al archimago Xylem en Azshara."
    C["Encoded Fragments"] = "Los fragmentos codificados"
    C["Return the Azure Key to Lord Jorach Ravenholdt."] = "Devuélvele la llave azur a Lord Jorach Ravenholdt."
    C["The Azure Key"] = "La llave azur"
    C["Collect a sample of air, fire, earth and water for Bath'rah the Windwatcher."] = "Recoge una muestra de aire, fuego, tierra y agua para Bath'rah el Cazavientos."
    C["Elemental Mastery"] = "Maestría elemental"
    C["Bring the pieces for the spirit totem to Bath'rah the Windwatcher."] = "Lleva lo necesario para el tótem del espíritu a Bath'rah el Cazavientos."
    C["Spirit Totem"] = "Tótem espiritual"
    C["Bring the voodoo feathers to Bath'rah the Windwatcher."] = "Lleva las plumas vudú a Bath'rah el Cazavientos."
    C["Da Voodoo"] = "Vudú"
    C["Bring a piece of felcloth to Impsy in Felwood."] = "Lleva un retal de tela de inferi a Diblis a Frondavil."
    C["An Imp's Request"] = "Pedido de un diablillo"
    C["Hot and Itchy"] = "Caliente y picante"
    C["Bring 10 Rotting Wood and 4 Bloodvenom Essence to Impsy in Felwood."] = "Lleva 10 maderas putrefactas y 4 esencias de veneno a Diblis a Frondavil."
    C["The Wrong Stuff"] = "La mercancía equivocada"
    C["Bring a total of 6 Voodoo Feathers from the trolls in sunken temple."] = "Reúne un total de 6 plumas vudú en el Templo Sumergido."
    C["Trolls of a Feather"] = "Plumas de trol"
    C["A Troubled Spirit"] = "Un espíritu afligido"
    C["Kill 7 Helboar in the Blasted Lands and return to the Fallen Hero of the Horde."] = "Mata a 7 jabinfernos de Las Tierras Devastadas y vuelve junto al Héroe Caído de la Horda."
    C["Warrior Kinship"] = "Parentesco guerrero"
    C["Slaughter the Shadowsworn in the Blasted Lands and return to the Fallen Hero of the Horde."] = "Acaba con los Sombra Jurada en las Tierras Devastadas y regresa junto al Héroe Caído de la Horda."
    C["War on the Shadowsworn"] = "La guerra contra los Sombra Jurada"
    C["Bring the Voodoo Feathers from the trolls in the Sunken Temple to the Fallen Hero of the Horde."] = "Llévale las plumas vudú de los trols del Templo Sumergido al Héroe Caído de la Horda."
    C["Voodoo Feathers"] = "Plumas Vudú"
    C["Defend Gor'shak."] = "Defiende a Gor'shak."
    C["What Is Going On?"] = "¿Qué pasa?"
    C["Rocknot's Ale"] = "La cerveza de Sinrosca"
    C["Travel to Silithus and search for a Reliquary of Purity within the ruins of Southwind Village. If you are able to find it, return with it to Rabine Saturna in Nighthaven, Moonglade."] = "Ve a Silithus a buscar un relicario de pureza en las ruinas de la Aldea del Viento del Sur. Llévaselo al rabino Saturna a Amparo de la Noche, en Claro de la Luna."
    C["A Reliquary of Purity"] = "Un relicario de pureza"
    C["Shards of the Felvine"] = "Fragmentos de gangrevid"
    C["Travel to the Warpwood Quarter of Dire Maul and slay the water elemental, Hydrospawn. Return to Lorekeeper Lydros in the Athenaeum with the Hydrospawn Essence."] = "Viaja al Barrio Alabeo de La Masacre y mata al elemental de agua, Hidromilecio. Lleva la esencia de Hidromilecio al guardián del Conocimiento Lydros que está en El Athenaeum."
    C["Arcane Refreshment"] = "El refresco arcano"
    C["Starfall"] = "Estrella Fugaz"
    C["The Ruins of Kel'Theril"] = "Las ruinas de Kel'Theril"
    C["Use Jaron's Pick to find the four Highborne Relic Fragments. Bring them to Aurora Skycaller in Eastern Plaguelands."] = "Utiliza el pico de Jaron para encontrar los cuatro fragmentos de reliquia de los altonatos. Llévaselas a Aurora Llamacielo en las Tierras de la Peste del Este."
    C["Troubled Spirits of Kel'Theril"] = "Espíritus condenados de Kel'Theril"
    C["Fragments of the Past"] = "Fragmentos del pasado"
    C["Bring an Enchanted Thorium Bar, 5 Crystal Restore, and a Vial of Dire Water to Aurora Skycaller near the Northpass Tower in Eastern Plaguelands."] = "Consigue una barra encantada de torio, 5 cristales de restauración y un vial de agua funesta para Aurora Llamacielo, en la Torre del Paso Norte, en las Tierras de la Peste del Este."
    C["Travel to Ironforge and get High Priest Rohan's Exorcism Censer. You will need to make a donation of 150 gold in order to secure it."] = "Viaja a Forjaz y consigue el incensario de exorcismos del sumo sacerdote Rohan. Tendrás que hacer una donación de 150 monedas de oro para conseguirlo."
    C["Emphasis on Sacrifice"] = "Énfasis en el sacrificio"
    C["Return the Exorcism Censer to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "Devuelve el incensario de exorcismos a Lord Quiebrasombras en el Distrito de la Catedral de Ventormenta."
    C["To Show Due Judgment"] = "Mostrarse juicioso"
    C["Use the Exorcism Censer to drive out the spirits that torment Terrordale. When you have slain 25 Terrordale Spirits, return to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "Utiliza el incensario de exorcismos para expulsar los espíritus que atormentan el Valle del Terror. Cuando hayas matado 25 espíritus del Valle del Terror, vuelve a ver a Lord Grisillo Quiebrasombras en el Distrito de la Catedral de Ventormenta."
    C["Exorcising Terrordale"] = "Exorcismo en Valle del Terror"
    C["The Work of Grimand Elmore"] = "El trabajo de Grimand Elmore"
    C["Bring 40 Runecloth, 6 Arcanite Bars, 10 Arthas' Tears, 5 Stratholme Holy Water vials, and 150 gold to Grimand Elmore in the Dwarven District of Stormwind."] = "Lleva 40 paños rúnicos, 6 lingotes de arcanita, 10 lágrimas de Arthas, 5 frascos de agua sagrada de Stratholme y 150 monedas de oro a Grimand Elmore en el Distrito de los Enanos de Ventormenta."
    C["Collection of Goods"] = "Recopilación de artículos"
    C["Grimand's Finest Work"] = "Un trabajo bien hecho"
    C["Retrieve 20 Enriched Manna Biscuits - the key ingredient in making Manna-Enriched Horse Feed - for Merideth Carlson at Southshore in the Hillsbrad Foothills. The Argent Dawn is known as the sole purveyor of the biscuits. You also need to give her 50 gold to soothe her ruffled sensibilities."] = "Consigue 20 galletas de maná, ingrediente principal del alimento especial para caballos, y llévaselas a Merideth Carlson a las Laderas de Trabalomas, en Costasur. Solo Alba Argenta fabrica esas galletas. También tienes que darle 50 piezas de oro para aplacar su orgullo herido."
    C["Manna-Enriched Horse Feed"] = "Alimento para caballo enriquecido con maná"
    C["Acquire special horse feed used for feeding a spirit horse. Merideth Carlson in Southshore apparently is the source for such food. Travel to the Dire Maul dungeon in Feralas and slay Tendris Warpwood. Doing so will free the Ancient Equine Spirit. Feed it the special horse feed, thereby soothing the spirit. Finally, give it the Arcanite Barding so it may bless it."] = "Consigue comida para caballos para alimentar a un espíritu equino. Por lo visto, Merideth Carlson, en Costasur, tiene esa comida. Ve a la mazmorra de La Masacre, en Feralas y mata a Tendris Madeguerra. Al hacerlo, liberarás al antiguo espíritu equino. Dale la comida para caballos y lo aplacarás. Por último, dale la gualdrapa de arcanita para que la bendiga."
    C["Ancient Equine Spirit"] = "El antiguo espíritu equino"
    C["Bring 30 bottles of Raging Beast's Blood to Mor'zul Bloodbringer in the Burning Steppes."] = "Llévale 30 botellas de sangre de bestia embravecida a Mor'zul Sangredoble en Las Estepas Ardientes."
    C["Rage of Blood"] = "La ira de sangre"
    C["Bring the Case of Blood to Gorzeeki Wildeyes in the Burning Steppes."] = "Llévale el estuche de sangre a Gorzeeki Ojosalvajes en Las Estepas Ardientes."
    C["Wildeyes"] = "Ojosalvajes"
    C["Purchase Shadowy Potions from Gorzeeki in the Burning Steppes. Use the potions to travel through Jaedenar, and speak with Lord Banehollow."] = "Cómprale oscuras pociones a Gorzeeki en Las Estepas Ardientes. Usa la pociones para viajar por Jaedenar y habla con Lord Pesadilla."
    C["Lord Banehollow"] = "Lord Pesadilla"
    C["Confront Ulathek, then bring The Traitor's Heart to Lord Banehollow in Jaedenar."] = "Enfréntate a Ulathek y llévale el corazón del traidor a Lord Pesadilla en Jaedenar."
    C["Ulathek the Traitor"] = "Ulathek el Traidor"
    C["Purchase Xorothian Stardust from Ur'dan. Bring it to Gorzeeki Wildeyes in the Burning Steppes."] = "Cómprale polvo estelar xorotiano a Ur'dan. Llévaselo a Gorzeeki Ojosalvajes en Las Estepas Ardientes."
    C["Xorothian Stardust"] = "Polvo estelar xorotiano"
    C["Bring 10 Elixirs of Shadow Power to Gorzeeki Wildeyes in the Burning Steppes."] = "Llévale 10 elixires de poder de las sombras a Gorzeeki Ojosalvajes en Las Estepas Ardientes."
    C["Bell of Dethmoora"] = "La Campana de Dethmoora"
    C["Bring 6 Large Brilliant Shards and 25 Dark Iron Ore to Gorzeeki in the Burning Steppes."] = "Llévale 6 grandes fragmentos brillantes y 25 minerales de hierro negro a Gorzeeki Ojosalvajes en Las Estepas Ardientes."
    C["Wheel of the Black March"] = "Rueda de la Marcha Negra"
    C["Bring 35 Black Dragonscales to Gorzeeki Wildeyes in the Burning Steppes."] = "Lleva 35 escamas de dragón negro a Gorzeeki Ojosalvajes a Las Estepas Ardientes."
    C["Doomsday Candle"] = "La Vela del Apocalipsis"
    C["Bring the Imp in a Jar to the alchemy lab in the Scholomance. After the parchment is created, return the jar to Gorzeeki Wildeyes."] = "Llévale el diablillo en un tarro al laboratorio de alquimia de Scholomance. Después de crear el pergamino llévale el tarro a Gorzeeki Ojosalvajes."
    C["Imp Delivery"] = "Entrega de diablillo"
    C["Bring 3 Arcanite Bars to Gorzeeki in the Burning Steppes."] = "Lleva 3 lingotes de arcanita a Gorzeeki Ojosalvajes a Las Estepas Ardientes."
    C["Arcanite"] = "La arcanita"
    C["Read Mor'zul's Instructions. Summon a Xorothian Dreadsteed, defeat it, then bind its spirit to you."] = "Lee las instrucciones de Mor'zul. Invoca al Corcel de la Muerte Xorothiano, derrótalo y después vincula su espíritu al tuyo."
    C["Dreadsteed of Xoroth"] = "Terrorecus de Xoroth"
    C["Return the book to its rightful owners."] = "Devuelve el libro a sus legítimos dueños."
    C["The Emerald Dream..."] = "El Sueño Esmeralda"
    C["The Greatest Race of Hunters"] = "La mayor raza de cazadores"
    C["The Arcanist's Cookbook"] = "El Recetario del Arcanista"
    C["The Light and How To Swing It"] = "La Luz y cómo alterarla"
    C["Holy Bologna: What the Light Won't Tell You"] = "Sagrada Bologna: lo que la Luz nunca te dirá"
    C["Garona: A Study on Stealth and Treachery"] = "Garona: un estudio acerca de la discreción y la traición"
    C["Frost Shock and You"] = "El choque de Escarcha y tú"
    C["Harnessing Shadows"] = "Controlar las Sombras"
    C["Codex of Defense"] = "Códice de Defensa"
    C["The Medallion of Faith"] = "El medallón de Fe"
    C["Slay 20 Noxious Plaguebats and 10 Monstrous Plaguebats. Return to Nathanos Blightcaller when you are finished."] = "Mata a 20 murcipestes tóxicos y 10 murcipestes monstruosos. Vuelve con Nathanos Clamorinfecto cuando hayas acabado."
    C["Un-Life's Little Annoyances"] = "Los pequeños problemas de la no-vida"
    C["Travel to Corin's Crossing to the east and slaughter the Scourge that inhabit the town. Collect 7 pieces of Living Rot in under 10 minutes. Use the Mortar and Pestle to grind the Living Rot into Coagulated Rot."] = "Viaja al Cruce de Corin al este y mata a los miembros de la Plaga que habitan allí. Recoge 7 piezas de putrefacción viva en 10 minutos. Utiliza el mortero y la mano de mortero para convertir la putrefacción viva en putrefacción coagulada."
    C["To Kill With Purpose"] = "Matar con un propósito"
    C["The Corpulent One"] = "El corpulento"
    C["The Champion of the Banshee Queen"] = "Campeón de la reina alma en pena"
    C["Tinkee Steamboil"] = "Tinkee Vaporino"
    C["Return with the Blessed Arcanite Barding to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "Devuelve la Blessed Arcanite Barding a Lord Grisillo Quiebrasombras en el Distrito de la Catedral de Ventormenta."
    C["Blessed Arcanite Barding"] = "La gualdrapa de arcanita bendecida"
    C["Bring an Azerothian Diamond and a Pristine Black Diamond to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "Lleva un diamante de Azeroth y un diamante negro prístino a Lord Grisillo Quiebrasombras en el Distrito de la Catedral de Ventormenta."
    C["The Divination Scryer"] = "Arúspice"
    C["Use the Divination Scryer in the heart of the Great Ossuary's basement in the Scholomance. Doing so will bring forth the spirits you must judge. Defeating these spirits will summon forth Death Knight Darkreaver. Defeat him and reclaim the lost soul of the fallen charger. Give the Charger's Redeemed Soul and the Blessed Enchanted Barding to Darkreaver's Fallen Charger."] = "Utiliza el augurador en el centro del sótano de El Gran Osario en Scholomance. Al hacerlo, aparecerán los espíritus que tienes que juzgar. Si derrotas a esos espíritus, aparecerá el Caballero de la Muerte Atracoscuro. Acaba con él y reclama el alma perdida del cargo caído. Entrega el alma redimida del cargo y la gualdrapa encantada bendecida al cargo caído de Atracoscuro."
    C["Judgment and Redemption"] = "Juzgar y redimir"
    C["If you are interested in helping Sagorne Crestrider in Orgrimmar's Valley of Wisdom, bring him an Azerothian Diamond and a Pristine Black Diamond."] = "Si te interesa ayudar a Sagorne Montacresta, llévale 1 diamante de Azeroth y 1 diamante negro prístino al Valle de la Sabiduría, en Orgrimmar."
    C["Material Assistance"] = "Asistencia material"
    C["Use the Divination Scryer in the heart of the Great Ossuary's basement in the Scholomance. Doing so will bring forth spirits you must fight. Defeating these spirits will summon forth Death Knight Darkreaver; defeat him. Bring Darkreaver's Head to Sagorne Creststrider in the Valley of Wisdom, Orgrimmar."] = "Usa el augurador que se encuentra en el corazón del sótano de El Gran Osario en Scholomance. Al hacerlo se presentarán los espíritus a los que tienes que enfrentarte. La derrota de estos espíritus invoca al Caballero de la Muerte Atracoscuro, derrótalo. Llévale la cabeza de Atracoscuro a Sagorne Montacresta en el Valle de la Sabiduría, en Orgrimmar."
    C["The Darkreaver Menace"] = "La amenaza de Atracoscuro"
end
do local C = ns.CONTENT.it
    C["The Orb of Soran'ruk"] = "Il Globo di Soran’ruk"
    C["Strange Water Globe: Drops from Baron Aquanis inside Blackfathom Deeps."] = "Globo d'Acqua Strano, bottino del Barone Aquanis nelle Profondità di Fondocupo"
    C["Bring the Strange Water Globe to Je'neu Sancrea at Zoram'gar Outpost, Ashenvale."] = "Porta il Globo d'Acqua Strano a Je'neu Sancrea all'Avamposto di Zoram'gar, Valtetra."
    C["Baron Aquanis"] = "Barone Aquanis"
    C["The Greenwarden"] = "Il Guardiano Verde"
    C["Kill 15 Mosshide Gnolls and 10 Mosshide Mongrels, then return to Rethiel the Greenwarden."] = "Uccidi 15 Gnoll Muschiopelle e 10 Meticci Muschiopelle, poi torna da Rethiel il Guardiano Verde."
    C["Tramping Paws"] = "Zampe calpestanti"
    C["Bring Rethiel the Greenwarden 9 Crude Flints."] = "Porta 9 selci grezze a Rethiel il Guardiano Verde."
    C["Fire Taboo"] = "Tabù del fuoco"
    C["Kill 12 Fen Creepers, then return to Rethiel the Greenwarden."] = "Uccidi 12 Striscianti della Palude, poi torna da Rethiel il Guardiano Verde."
    C["Blisters on The Land"] = "Piaghe sulla terra"
end
do local C = ns.CONTENT.pt
    C["Defend Daphne Stilwell from the Defias attack."] = "Proteja Dafne Calmafonte do ataque dos Défias. Para obter êxito, seus espíritos não podem ser despidos do lodo mortal. Quando você conseguir, fale novamente com Dafne Calmafonte."
    C["The Tome of Valor"] = "Tomo da Bravura"
    C["The Test of Righteousness"] = "A prova da retidão"
    C["Using Jordan's Weapon Notes, find some Whitestone Oak Lumber, Bailor's Refined Ore Shipment, Jordan's Smithing Hammer, and a Kor Gem, and return them to Jordan Stilwell in Ironforge."] = "Usando as Anotações do Jardel sobre Armas, encontre Madeira de Carvalho de Pedralva, o Carregamento de Minério Refinado do Bailor, o Martelo de Ferreiro de Jardel e uma Gema Kor. Depois, entregue tudo a Jardel Calmafonte em Altaforja."
    C["Wait for Jordan Stilwell to finish forging a weapon for you."] = "Espere que Jardel Calmafonte termine de forjar uma arma para você."
    C["The Orb of Soran'ruk"] = "O Orbe de Soran’ruk"
    C["Strange Water Globe: Drops from Baron Aquanis inside Blackfathom Deeps."] = "Globo de Água Estranho, saque do Barão Aquanis dentro de Profundezas Negras"
    C["Bring the Strange Water Globe to Je'neu Sancrea at Zoram'gar Outpost, Ashenvale."] = "Leve o Globo de Água Estranho a Je'neu Sancrea no Posto Avançado de Zoram'gar, Vale Gris."
    C["Baron Aquanis"] = "Barão Aquanis"
    C["The Greenwarden"] = "O Guardião Verde"
    C["Kill 15 Mosshide Gnolls and 10 Mosshide Mongrels, then return to Rethiel the Greenwarden."] = "Mate 15 gnolls Couro de Musgo e 10 vira-latas Couro de Musgo e volte a Rethiel, o Guardião Verde."
    C["Tramping Paws"] = "Patas pisoteantes"
    C["Bring Rethiel the Greenwarden 9 Crude Flints."] = "Leve 9 pederneiras brutas a Rethiel, o Guardião Verde."
    C["Fire Taboo"] = "Tabu do fogo"
    C["Kill 12 Fen Creepers, then return to Rethiel the Greenwarden."] = "Mate 12 rastejantes do pântano e volte a Rethiel, o Guardião Verde."
    C["Blisters on The Land"] = "Bolhas na terra"
    C["Brother Anton"] = "Irmão Anton"
    C["Bring an Infernal Orb to Tabetha in Dustwallow Marsh."] = "Leve um Orbe Infernal para Tabetha no Pântano Vadeoso."
    C["The Infernal Orb"] = "O Orbe Infernal"
    C["Kill the Demon of the Orb, then speak with Tabetha."] = "Mate o Demônio do Orbe, depois fale com Tabetha."
    C["The Exorcism"] = "O Exorcismo"
    C["Retrieve an Obsidian Power Source and bring it to Tabetha in Dustwallow Marsh."] = "Recupere uma Fonte de Energia de Obsidiana e leve-a para Tabetha no Pântano Vadeoso."
    C["Power in Uldaman"] = "Poder em Uldaman"
    C["The Brassbolts Brothers"] = "Os irmãos Latafuso"
    C["Tabetha's Task"] = "A tarefa de Tabetha"
    C["Collect 15 Bloodpetals and return to Muigin."] = "Colha 15 Pétalas Sangrentas e fale novamente com Melco."
    C["Muigin and Larion"] = "Melco e Lário"
    C["A Visit to Gregan"] = "Uma visita a Gregan"
    C["Collect 5 samples of Atal'ai Haze, then return to Muigin in Un'Goro Crater."] = "Colha 5 amostras de Bruma de Atal'ai, depois fale novamente com Melco na Cratera Un'Goro."
    C["Haze of Evil"] = "Brumas do mal"
    C["Torwa Pathfinder"] = "Torwa Mateiro"
    C["Collect 8 Bloodcap and 8 Gorishi Stings, and return to Torwa Pathfinder in Un'Goro Crater."] = "Colete 8 Cogumelos Vermelhos e 8 Ferrões de Gorishi e fale novamente com Torwa Mateiro na Cratera Un'Goro."
    C["Bloodpetal Poison"] = "Veneno de Pétala Sangrenta"
    C["Stab a Devilsaur with the Devilsaur Barb. Return to Torwa Pathfinder in Un'Goro Crater when you have completed this task."] = "Espete um Demossauro com uma Farpa para Demossauro. Fale novamente com Torwa Mateiro na Cratera Un'goro depois que tiver terminado a tarefa."
    C["Toxic Test"] = "Exame de intoxicação"
    C["Retrieve a Putrid Vine from the guardian at the bottom of the Sunken Temple and return to Torwa Pathfinder."] = "Consiga uma Trepadeira Pútrida do guardião no fundo do Templo Submerso e fale novamente com Torwa Mateiro."
    C["A Better Ingredient"] = "Um ingrediente melhor"
    C["The Hunter's Charm"] = "O amuleto do caçador"
    C["Bring a pair of Perfect Courser Antlers to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast of the Ruins of Eldarath."] = "Leve um par de Galhadas Perfeitas de Ginete para Ogtinc em Azshara. Ogtinc vive no alto dos penhascos a nordeste das Ruínas de Eldarath."
    C["Courser Antlers"] = "Galhada de ginete"
    C["Bring 6 Wavethrasher Scales to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "Leve 6 Escamas de Fura-ondas para Ogtinc em Azshara. Ogtinc mora no alto dos penhascos a nordeste das Ruínas de Eldarath."
    C["Wavethrashing"] = "Furando onda"
    C["Bring the Tooth of Morphaz to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "Leve o Dente de Morphaz para Ogtinc em Azshara. Ogtinc mora no alto dos penhascos a nordeste das Ruínas de Eldarath."
    C["The Green Drake"] = "O draco verde"
    C["Magecraft"] = "Magiaria"
    C["Bring 10 Glittering Dust to Archmage Xylem."] = "Leve 10 Poeiras Reluzentes para o Arquimago Tauriel."
    C["Magic Dust"] = "Pó Mágico"
    C["Collect 6 Enchanted Coral and return them to Archmage Xylem."] = "Obtenha 6 Corais Encantados e entregue-os ao Arquimago Tauriel."
    C["The Siren's Coral"] = "Coral de sirenas"
    C["Retrieve the Arcane Shard from Morphaz and return to Archmage Xylem."] = "Recupere o Estilhaço Arcano de posse de Morphaz e fale novamente com o Arquimago Tauriel."
    C["Destroy Morphaz"] = "A destruição de Morphaz"
    C["Chillwind Point"] = "Morro do Ventogelante"
    C["Collect 20 Minion's Scourgestones and bring them to High Priest Thel'danis in the Western Plaguelands."] = "Colete 20 Pedras do Flagelo do Lacaio e leve-as ao Sumo Sacerdote Thel'danis nas Terras Pestilentas Ocidentais."
    C["Dispelling Evil"] = "Dissipando o mal"
    C["Bring the Inert Scourgestone to Commander Ashlan Valorfist in Chillwind Point."] = "Leve a Pedra do Flagelo Inerte ao Comandante Ashlam Punhobom no Morro do Ventogelante."
    C["Inert Scourgestones"] = "Pedras do Flagelo inertes"
    C["Bring the voodoo feathers to Ashlam Valorfist."] = "Leve as Penas Vodu para Ashlam Punhobom."
    C["Forging the Mightstone"] = "Forjando o megalito"
    C["Cenarion Aid"] = "Ajuda aos cenarianos"
    C["Acquire 4 Healthy Courser Glands and bring them to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "Obtenha 4 Glândulas de Ginete Saudável leve-as para Ogtinc em Azshara. Ogtinc vive no alto dos penhascos a nordeste das Ruínas de Eldarath."
    C["Of Coursers We Know"] = "Ginetes sagrados"
    C["Acquire an Ichor of Undeath for Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "Obtenha uma Linfa de Morte-viva para Ogtinc em Azshara. Ogtinc mora no alto dos penhascos a nordeste das Ruínas de Eldarath."
    C["The Ichor of Undeath"] = "A linfa de morte-viva"
    C["Kill Morphaz in the sunken temple of Atal'Hakkar, and return his blood to Greta Mosshoof in Felwood. The entrance to the sunken temple can be found in the Swamp of Sorrows."] = "Mate Morphaz no templo submerso de Atal'Hakkar e leve o sangue dele para Greta Musgo no Casco na Selva Maleva. A entrada do templo submerso fica no Pântano das Mágoas."
    C["Blood of Morphaz"] = "Sangue de Morphaz"
    C["A Simple Request"] = "Um pedido simples"
    C["Retrieve the Sealed Azure Bag from the Timbermaw Shaman in Azshara. Then take the bag to Archmage Xylem, also found in Azshara."] = "Recupere o Saco Lazúli Lacrado com o Xamã Presamatos, em Azshara. Então o leve para o Arquimago Tauriel, também em Azshara."
    C["Sealed Azure Bag"] = "Saco lazúli lacrado"
    C["Bring 10 Encoded Fragments to Archmage Xylem in Azshara."] = "Leve 10 Fragmentos Codificados para o Arquimago Tauriel em Azshara."
    C["Encoded Fragments"] = "Fragmentos codificados"
    C["Return the Azure Key to Lord Jorach Ravenholdt."] = "Leve a Chave Lazúli para o Lorde Jorach Corvoforte."
    C["The Azure Key"] = "A chave lazúli"
    C["Collect a sample of air, fire, earth and water for Bath'rah the Windwatcher."] = "Colete uma amostra de ar, fogo, terra e água para Bath'rah, o Vigia dos Ventos."
    C["Elemental Mastery"] = "Mestre dos elementos"
    C["Bring the pieces for the spirit totem to Bath'rah the Windwatcher."] = "Leve as partes para Bath'rah, o Vigia dos Ventos, fazer o totem de espírito."
    C["Spirit Totem"] = "Totem de espírito"
    C["Bring the voodoo feathers to Bath'rah the Windwatcher."] = "Leve as Penas Vodu para Bath'rah, o Vigia dos Ventos."
    C["Da Voodoo"] = "O Vodu"
    C["Bring a piece of felcloth to Impsy in Felwood."] = "Leve um pedaço de Tecido Vil para Diabretim, em Selva Maleva."
    C["An Imp's Request"] = "Pedido de diabrete"
    C["Hot and Itchy"] = "Quente e pinicante"
    C["Bring 10 Rotting Wood and 4 Bloodvenom Essence to Impsy in Felwood."] = "Leve 10 pedaços de Madeira Podre e 4 Essências de Peçonha para Diabretim em Selva Maleva."
    C["The Wrong Stuff"] = "O enchimento errado"
    C["Bring a total of 6 Voodoo Feathers from the trolls in sunken temple."] = "Leve um total de 6 Penas Vodu dos trolls do templo submerso."
    C["Trolls of a Feather"] = "Penas de troll"
    C["A Troubled Spirit"] = "Um espírito atormentado"
    C["Kill 7 Helboar in the Blasted Lands and return to the Fallen Hero of the Horde."] = "Mate 7 Javiltuscos na Barreira do Inferno e fale novamente com o Herói Caído da Horda."
    C["Warrior Kinship"] = "Parentesco guerreiro"
    C["Slaughter the Shadowsworn in the Blasted Lands and return to the Fallen Hero of the Horde."] = "Mate os Devotos da Sombra na Barreira do Inferno e fale novamente com o Herói Caído da Horda."
    C["War on the Shadowsworn"] = "Guerra aos devotos da sombra"
    C["Bring the Voodoo Feathers from the trolls in the Sunken Temple to the Fallen Hero of the Horde."] = "Leve as Penas Vodu dos trolls do Templo Submerso para o Herói Caído da Horda."
    C["Voodoo Feathers"] = "Penas Vodu"
    C["Defend Gor'shak."] = "Defenda Gor'shak."
    C["What Is Going On?"] = "O que está acontecendo?"
    C["Rocknot's Ale"] = "Cerveja Pedrosa"
    C["Travel to Silithus and search for a Reliquary of Purity within the ruins of Southwind Village. If you are able to find it, return with it to Rabine Saturna in Nighthaven, Moonglade."] = "Viaje até Silithus e procure um Relicário da Pureza dentro das ruínas da Vila do Vento Sul. Se conseguir encontrá-lo, regresse com ele até Ravine Saturna, no Refúgio Noturno, que fica na Clareira da Lua."
    C["A Reliquary of Purity"] = "Relicário da Pureza"
    C["Shards of the Felvine"] = "Pedaços de Vinhavil"
    C["Travel to the Warpwood Quarter of Dire Maul and slay the water elemental, Hydrospawn. Return to Lorekeeper Lydros in the Athenaeum with the Hydrospawn Essence."] = "Vá ao Distrito Lenhatorta, no Gládio Cruel, e mate o elemental da água, Rebentágua. Leve a Essência de Rebentágua para o Erudito Lydros, no Ateneu."
    C["Arcane Refreshment"] = "Bebida arcana"
    C["Starfall"] = "Chuva Estelar"
    C["The Ruins of Kel'Theril"] = "Ruínas de Kel'Theril"
    C["Use Jaron's Pick to find the four Highborne Relic Fragments. Bring them to Aurora Skycaller in Eastern Plaguelands."] = "Use a Picareta do Jaron para encontrar os quatro Fragmentos da Relíquia dos Altaneiros. Leve-os para Aurora Clamacéus nas Terras Pestilentas Orientais."
    C["Troubled Spirits of Kel'Theril"] = "Espíritos atormentados de Kel'Theril"
    C["Fragments of the Past"] = "Fragmentos do passado"
    C["Bring an Enchanted Thorium Bar, 5 Crystal Restore, and a Vial of Dire Water to Aurora Skycaller near the Northpass Tower in Eastern Plaguelands."] = "Leve uma Barra de Tório Encantado, 5 Restaurações de Cristal e uma Ampola de Água Hedionda para Aurora Clamacéus perto da Torre do Passo Norte nas Terras Pestilentas Orientais."
    C["Travel to Ironforge and get High Priest Rohan's Exorcism Censer. You will need to make a donation of 150 gold in order to secure it."] = "Viaje para Altaforja e obtenha o Incensório de Exorcismo do Sumo Sacerdote Rohan. Você precisará fazer uma doação de 150 moedas de ouro para obtê-lo."
    C["Emphasis on Sacrifice"] = "Ênfase em sacrifício"
    C["Return the Exorcism Censer to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "Leve o Incensório de Exorcismo para Lorde Grayson Quebrassombra no Distrito da Catedral de Ventobravo."
    C["To Show Due Judgment"] = "O devido julgamento"
    C["Use the Exorcism Censer to drive out the spirits that torment Terrordale. When you have slain 25 Terrordale Spirits, return to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "Use o Incensório de Exorcismo para expulsar os espíritos que atormentam a Várzea do Medo. Quando você tiver eliminado 25 Espíritos da Várzea do Medo, fale novamente com Lorde Grayson Quebrassombra no Distrito da Catedral de Ventobravo."
    C["Exorcising Terrordale"] = "Exorcizando a Várzea do Medo"
    C["The Work of Grimand Elmore"] = "O trabalho de Grimand Elmore"
    C["Bring 40 Runecloth, 6 Arcanite Bars, 10 Arthas' Tears, 5 Stratholme Holy Water vials, and 150 gold to Grimand Elmore in the Dwarven District of Stormwind."] = "Leve 40 Runatramas, 6 Barras de Arcanita, 10 Lágrimas-de-arthas, 5 ampolas de Água Benta de Stratholme e 150 moedas de ouro para Grimand Elmore, no Distrito dos Anões de Ventobravo."
    C["Collection of Goods"] = "Coleta de produtos"
    C["Grimand's Finest Work"] = "O melhor trabalho de Grimand"
    C["Retrieve 20 Enriched Manna Biscuits - the key ingredient in making Manna-Enriched Horse Feed - for Merideth Carlson at Southshore in the Hillsbrad Foothills. The Argent Dawn is known as the sole purveyor of the biscuits. You also need to give her 50 gold to soothe her ruffled sensibilities."] = "Obtenha 20 Biscoitos de Maná Enriquecido — o ingrediente chave para fazer Ração de Cavalo Enriquecida com Mana — para Judite Castanheira da Costa Sul, no Contraforte de Eira dos Montes. A Aurora Argêntea é conhecida como a única fornecedora dos biscoitos. Você também precisa dar a ela 50 moedas de ouro para a apaziguar os ânimos dela."
    C["Manna-Enriched Horse Feed"] = "Ração de Cavalo Enriquecida com Mana"
    C["Acquire special horse feed used for feeding a spirit horse. Merideth Carlson in Southshore apparently is the source for such food. Travel to the Dire Maul dungeon in Feralas and slay Tendris Warpwood. Doing so will free the Ancient Equine Spirit. Feed it the special horse feed, thereby soothing the spirit. Finally, give it the Arcanite Barding so it may bless it."] = "Obtenha uma ração de cavalo especial para alimentar o cavalo espiritual. Aparentemente, Judite Castanheira, que vive na Costa Sul, é a fornecedora da tal ração. Entre na masmorra de Gládio Cruel, em Feralas, e mate Gavíneo Lenhatorta. Isso libertará o Espírito Equino Antigo. Alimente-o com a ração de cavalo especial, o que acalmará o espírito. Finalmente, dê-lhe a Barda de Arcanita para que ele a abençoe."
    C["Ancient Equine Spirit"] = "O Espírito Equino Antigo"
    C["Bring 30 bottles of Raging Beast's Blood to Mor'zul Bloodbringer in the Burning Steppes."] = "Leve 30 garrafas de Sangue de Fera em Fúria para Mor'zul Trazangre nas Estepes Ardentes."
    C["Rage of Blood"] = "Raiva de Sangue"
    C["Bring the Case of Blood to Gorzeeki Wildeyes in the Burning Steppes."] = "Leve o Caixote de Sangue para Gorzeeki Olholouco nas Estepes Ardentes."
    C["Wildeyes"] = "Olholouco"
    C["Purchase Shadowy Potions from Gorzeeki in the Burning Steppes. Use the potions to travel through Jaedenar, and speak with Lord Banehollow."] = "Compre Poções Sombrias de Gorzeeki nas Estepes Ardentes. Use as poções para viajar através de Jaedenar e fale com Lorde Nihilus."
    C["Lord Banehollow"] = "Lorde Nihilus"
    C["Confront Ulathek, then bring The Traitor's Heart to Lord Banehollow in Jaedenar."] = "Confronte Ulathek, depois leve o Coração do Traidor para o Lorde Nihilus em Jaedenar."
    C["Ulathek the Traitor"] = "Ulathek, o traidor"
    C["Purchase Xorothian Stardust from Ur'dan. Bring it to Gorzeeki Wildeyes in the Burning Steppes."] = "Compre Poeira Estelar Zorothiana de Ur'dan. Leve-a para Gorzeeki Olholouco nas Estepes Ardentes."
    C["Xorothian Stardust"] = "Poeira Estelar Zorothiana"
    C["Bring 10 Elixirs of Shadow Power to Gorzeeki Wildeyes in the Burning Steppes."] = "Leve 10 Elixires de Poder Sombrio para Gorzeeki Olholouco nas Estepes Ardentes."
    C["Bell of Dethmoora"] = "Sino de Defimura"
    C["Bring 6 Large Brilliant Shards and 25 Dark Iron Ore to Gorzeeki in the Burning Steppes."] = "Leve 6 Estilhaços Brilhantes Grandes e 25 Minérios de Ferro Negro para Gorzeeki nas Estepes Ardentes."
    C["Wheel of the Black March"] = "Roda da Marcha Negra"
    C["Bring 35 Black Dragonscales to Gorzeeki Wildeyes in the Burning Steppes."] = "Leve 35 Escamas de Dragão Negro para Gorzeeki Olholouco nas Estepes Ardentes."
    C["Doomsday Candle"] = "Vela do Juízo Final"
    C["Bring the Imp in a Jar to the alchemy lab in the Scholomance. After the parchment is created, return the jar to Gorzeeki Wildeyes."] = "Leve o Diabrete numa Jarra para o laboratório de alquimia em Scolomântia. Depois que o pergaminho for criado, devolva a jarra para Gorzeeki Olholouco."
    C["Imp Delivery"] = "Entrega de diabrete"
    C["Bring 3 Arcanite Bars to Gorzeeki in the Burning Steppes."] = "Leve 3 Barras de Arcanita para Gorzeeki nas Estepes Ardentes."
    C["Arcanite"] = "Arcanita"
    C["Read Mor'zul's Instructions. Summon a Xorothian Dreadsteed, defeat it, then bind its spirit to you."] = "Leia as Instruções de Mor'zul. Evoque um Corcel Medonho Zorothiano, derrote-o e então vincule o espírito dele a você."
    C["Dreadsteed of Xoroth"] = "Corcel Medonho de Zoroth"
    C["Return the book to its rightful owners."] = "Devolva o livro aos legítimos donos."
    C["The Emerald Dream..."] = "O Sonho Esmeralda..."
    C["The Greatest Race of Hunters"] = "A Grande Corrida dos Caçadores"
    C["The Arcanist's Cookbook"] = "Livro de Receitas do Arcanista"
    C["The Light and How To Swing It"] = "A Luz e Como Ativá-la"
    C["Holy Bologna: What the Light Won't Tell You"] = "Caçarolas: O Que a Luz Não lhe Contará"
    C["Garona: A Study on Stealth and Treachery"] = "Garona: Um Estudo sobre Furtividade e Traição"
    C["Frost Shock and You"] = "O Choque Gélido e Você"
    C["Harnessing Shadows"] = "Sombras Agrilhoantes"
    C["Codex of Defense"] = "Códice de Defesa"
    C["The Medallion of Faith"] = "O Medalhão da Fé"
    C["Slay 20 Noxious Plaguebats and 10 Monstrous Plaguebats. Return to Nathanos Blightcaller when you are finished."] = "Mate 20 Quirópragos Nóxios e 10 Quirópragos Monstruosos. Fale novamente com Nathanos Arauto da Praga quando você tiver terminado."
    C["Un-Life's Little Annoyances"] = "Pequenos transtornos da Morte-em-Vida"
    C["Travel to Corin's Crossing to the east and slaughter the Scourge that inhabit the town. Collect 7 pieces of Living Rot in under 10 minutes. Use the Mortar and Pestle to grind the Living Rot into Coagulated Rot."] = "Vá ao Cruzamento de Corin, a leste, e mate membros do Flagelo que habitam a cidade. Colete 7 pedaços de Putrefação Viva em menos de 10 minutos. Use o Almofariz e Pilão para moer a Putrefação Viva, de maneira a transformá-la em Putrefação Coagulada."
    C["To Kill With Purpose"] = "Matar com propósito"
    C["The Corpulent One"] = "O corpulento"
    C["The Champion of the Banshee Queen"] = "O campeão da Rainha Banshees"
    C["Tinkee Steamboil"] = "Vera Brequim"
    C["Return with the Blessed Arcanite Barding to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "Leve a Barda de Arcanita Abençoada para Lorde Grayson Quebrassombra no Distrito da Catedral de Ventobravo."
    C["Blessed Arcanite Barding"] = "Barda de Arcanita Abençoada"
    C["Bring an Azerothian Diamond and a Pristine Black Diamond to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "Leve um Diamante Azerotiano e um Diamante Preto Límpido para Lorde Grayson Quebrassombra no Distrito da Catedral de Ventobravo."
    C["The Divination Scryer"] = "O Cristal Divinatório"
    C["Use the Divination Scryer in the heart of the Great Ossuary's basement in the Scholomance. Doing so will bring forth the spirits you must judge. Defeating these spirits will summon forth Death Knight Darkreaver. Defeat him and reclaim the lost soul of the fallen charger. Give the Charger's Redeemed Soul and the Blessed Enchanted Barding to Darkreaver's Fallen Charger."] = "Use o Cristal Divinatório no coração do porão do Grande Ossário, em Scolomântia. Isso invocará espíritos que você precisará julgar. A derrota dos espíritos evocará o Cavaleiro da Morte Noctilatrus. Derrote-o e reclame a alma perdida do corcel caído. Entregue a Alma Redimida do Corcel e a Barda Encantada Abençoada ao Corcel Caído de Noctilatrus."
    C["Judgment and Redemption"] = "Julgamento e redenção"
    C["If you are interested in helping Sagorne Crestrider in Orgrimmar's Valley of Wisdom, bring him an Azerothian Diamond and a Pristine Black Diamond."] = "Se você tiver interesse em ajudar Sagorne Monta Crista, no Vale da Sabedoria de Orgrimmar, leve para ele um Diamante Azerotiano e um Diamante Preto Límpido."
    C["Material Assistance"] = "Ajuda material"
    C["Use the Divination Scryer in the heart of the Great Ossuary's basement in the Scholomance. Doing so will bring forth spirits you must fight. Defeating these spirits will summon forth Death Knight Darkreaver; defeat him. Bring Darkreaver's Head to Sagorne Creststrider in the Valley of Wisdom, Orgrimmar."] = "Use o Cristal Divinatório no coração do porão do Grande Ossário, em Scolomântia. Isso invocará espíritos que você precisará enfrentar. A derrota dos espíritos evocará o Cavaleiro da Morte Noctilatrus. Derrote-o. Leve a Cabeça de Noctilatrus para Sagorne Monta Crista, no Vale da Sabedoria, em Orgrimmar."
    C["The Darkreaver Menace"] = "A ameaça de Noctilatrus"
end
do local C = ns.CONTENT.ru
    C["Defend Daphne Stilwell from the Defias attack."] = "Защитите Дафну Стилвелл от нападения Братства Справедливости. Проследите, чтобы ни ее, ни ваша душа в случае смерти не покинули свои тела, иначе испытание не будет засчитано. После победы поговорите с Дафной Стилвелл."
    C["The Tome of Valor"] = "Фолиант Отваги"
    C["The Test of Righteousness"] = "Испытание доблести"
    C["Using Jordan's Weapon Notes, find some Whitestone Oak Lumber, Bailor's Refined Ore Shipment, Jordan's Smithing Hammer, and a Kor Gem, and return them to Jordan Stilwell in Ironforge."] = "Возьмите список Джордана, добудьте немного древесины белокаменного дуба, партию очищенной руды Бэйлора, кузнечный молот Джордана и самоцвет Кора и отдайте их Джордану Стилвеллу в Стальгорне."
    C["Wait for Jordan Stilwell to finish forging a weapon for you."] = "Подождите, пока Джордан Стилвелл не закончит изготовление оружия."
    C["The Orb of Soran'ruk"] = "Сфера Соран’рука"
    C["Strange Water Globe: Drops from Baron Aquanis inside Blackfathom Deeps."] = "Странная водяная сфера, добывается с барона Акваниса в Непроглядной Пучине"
    C["Bring the Strange Water Globe to Je'neu Sancrea at Zoram'gar Outpost, Ashenvale."] = "Отнесите странную водяную сферу Джен'ю Санкри в заставу Зорам'гар, Ясеневый лес."
    C["Baron Aquanis"] = "Барон Акванис"
    C["The Greenwarden"] = "Страж Природы"
    C["Kill 15 Mosshide Gnolls and 10 Mosshide Mongrels, then return to Rethiel the Greenwarden."] = "Убейте 15 гноллов Мохошкуров и 10 дворняг Мохошкуров, затем вернитесь к Ретилю Стражу Природы."
    C["Tramping Paws"] = "Топотунья"
    C["Bring Rethiel the Greenwarden 9 Crude Flints."] = "Принесите Ретилю Стражу Природы 9 грубых кремней."
    C["Fire Taboo"] = "Табу огня"
    C["Kill 12 Fen Creepers, then return to Rethiel the Greenwarden."] = "Убейте 12 болотных ползунов, затем вернитесь к Ретилю Стражу Природы."
    C["Blisters on The Land"] = "Нарывы на земле"
    C["Brother Anton"] = "Брат Антон"
    C["Bring an Infernal Orb to Tabetha in Dustwallow Marsh."] = "Принесите сферу Подземного огня Табете из Пылевых топей."
    C["The Infernal Orb"] = "Сфера Подземного огня"
    C["Kill the Demon of the Orb, then speak with Tabetha."] = "Убейте демона сферы, а потом поговорите с Табетой."
    C["The Exorcism"] = "Поединок с демоном"
    C["Retrieve an Obsidian Power Source and bring it to Tabetha in Dustwallow Marsh."] = "Добудьте обсидиановый источник силы и принесите его Табете в Пыльную трясину."
    C["Power in Uldaman"] = "Сила Ульдамана"
    C["The Brassbolts Brothers"] = "Братья Латунный Болт"
    C["Tabetha's Task"] = "Миссия Табеты"
    C["Collect 15 Bloodpetals and return to Muigin."] = "Соберите 15 кровоцветов и принесите их Майджину."
    C["Muigin and Larion"] = "Майджин и Ларион"
    C["A Visit to Gregan"] = "Визит к Грегану"
    C["Collect 5 samples of Atal'ai Haze, then return to Muigin in Un'Goro Crater."] = "Соберите 5 образцов тумана Аталаи и принесите их Майджину в Кратер Ун'Горо."
    C["Haze of Evil"] = "Туман зла"
    C["Torwa Pathfinder"] = "Землепроходец Торва"
    C["Collect 8 Bloodcap and 8 Gorishi Stings, and return to Torwa Pathfinder in Un'Goro Crater."] = "Соберите 8 кровошляпочников и 8 жал Гориши и вернитесь к Землепроходцу Торве в Кратер Ун'Горо."
    C["Bloodpetal Poison"] = "Яд кровоцвета"
    C["Stab a Devilsaur with the Devilsaur Barb. Return to Torwa Pathfinder in Un'Goro Crater when you have completed this task."] = "Уколите девизавра колючкой девизавра. По выполнении задания вернитесь к Землепроходцу Торве."
    C["Toxic Test"] = "Испытание яда"
    C["Retrieve a Putrid Vine from the guardian at the bottom of the Sunken Temple and return to Torwa Pathfinder."] = "Возьмите гнилую лозу у стража на дне затонувшего храма и вернитесь к Землепроходцу Торве."
    C["A Better Ingredient"] = "Лучший ингредиент"
    C["The Hunter's Charm"] = "Талисман охотника"
    C["Bring a pair of Perfect Courser Antlers to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast of the Ruins of Eldarath."] = "Принесите пару великолепных рогов мохоногого оленя Огтинку в Азшару. Огтинк обитает среди скал в северо-востоку от руин Эльдарата."
    C["Courser Antlers"] = "Рога и копыта"
    C["Bring 6 Wavethrasher Scales to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "Принесите 6 чешуй волношлепа Огтинку в Азшару. Огтинк обитает среди скал в северо-востоку от руин Эльдарата."
    C["Wavethrashing"] = "Охота на волномета"
    C["Bring the Tooth of Morphaz to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "Принесите зуб Морфаза Огтинку в Азшару. Огтинк обитает среди скал в северо-востоку от руин Эльдарата."
    C["The Green Drake"] = "Зеленый дракон"
    C["Magecraft"] = "Магическое искусство"
    C["Bring 10 Glittering Dust to Archmage Xylem."] = "Принесите 10 горстей сияющей пыли верховному магу Ксилему."
    C["Magic Dust"] = "Волшебная пыль"
    C["Collect 6 Enchanted Coral and return them to Archmage Xylem."] = "Соберите 6 заколдованных кораллов и принесите их верховному магу Ксилему."
    C["The Siren's Coral"] = "Кораллы сирен"
    C["Retrieve the Arcane Shard from Morphaz and return to Archmage Xylem."] = "Добудьте кристалл тайной магии из брюха Морфаза и принесите его верховному магу Ксилему."
    C["Destroy Morphaz"] = "Уничтожить Морфаза"
    C["Chillwind Point"] = "Берег Промозглого Ветра"
    C["Collect 20 Minion's Scourgestones and bring them to High Priest Thel'danis in the Western Plaguelands."] = "Принесите 20 камней Плети приспешников верховному жрецу Тель'данису в Западные Чумные земли."
    C["Dispelling Evil"] = "Борьба со злом"
    C["Bring the Inert Scourgestone to Commander Ashlan Valorfist in Chillwind Point."] = "Отнесите бездействующий камень командиру Асламу Отважному Кулаку на Берег Промозглого Ветра."
    C["Inert Scourgestones"] = "Бездействующие камни Плети"
    C["Bring the voodoo feathers to Ashlam Valorfist."] = "Принесите вудуистские перья Ашламу Отважному Кулаку."
    C["Forging the Mightstone"] = "Создание камня силы"
    C["Cenarion Aid"] = "Помощь Кенарию"
    C["Acquire 4 Healthy Courser Glands and bring them to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "Добудьте 4 железы здорового мохоногого оленя и принесите их Огтинку в Азшару. Огтинк обитает среди скал в северо-востоку от руин Эльдарата."
    C["Of Coursers We Know"] = "Охота на беговых оленей"
    C["Acquire an Ichor of Undeath for Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "Принесите лимфу нежити Огтинку в Азшару. Огтинк обитает среди скал в северо-востоку от руин Эльдарата."
    C["The Ichor of Undeath"] = "Лимфа нежити"
    C["Kill Morphaz in the sunken temple of Atal'Hakkar, and return his blood to Greta Mosshoof in Felwood. The entrance to the sunken temple can be found in the Swamp of Sorrows."] = "Убейте Морфаза в затонувшем храме Атал'Хаккара и принесите его кровь Грете Замшелому Копыту в Оскверненный лес. Вход в храм сокрыт на болоте Печали."
    C["Blood of Morphaz"] = "Кровь Морфаза"
    C["A Simple Request"] = "Приглашение"
    C["Retrieve the Sealed Azure Bag from the Timbermaw Shaman in Azshara. Then take the bag to Archmage Xylem, also found in Azshara."] = "Добудьте запечатанную лазурную сумку у шамана из племени Древобрюхов в Азшаре. Затем отнесите сумку верховному магу Ксилему в Азшаре."
    C["Sealed Azure Bag"] = "Запечатанная лазурная сумка"
    C["Bring 10 Encoded Fragments to Archmage Xylem in Azshara."] = "Принесите 10 зашифрованных фрагментов верховному магу Ксилему в Азшару."
    C["Encoded Fragments"] = "Зашифрованные фрагменты"
    C["Return the Azure Key to Lord Jorach Ravenholdt."] = "Принесите лазурный ключ лорду Черному Ворону."
    C["The Azure Key"] = "Лазурный ключ"
    C["Collect a sample of air, fire, earth and water for Bath'rah the Windwatcher."] = "Соберите образцы воздуха, огня, земли и воды по поручению Бат'ры Ветростража."
    C["Elemental Mastery"] = "Покорение стихий"
    C["Bring the pieces for the spirit totem to Bath'rah the Windwatcher."] = "Принесите части тотема Духа Бат'ре Ветростражу."
    C["Spirit Totem"] = "Тотем духов"
    C["Bring the voodoo feathers to Bath'rah the Windwatcher."] = "Принесите вудуистские перья Бат'ре Ветростражу."
    C["Da Voodoo"] = "Вуду"
    C["Bring a piece of felcloth to Impsy in Felwood."] = "Принесите отрез ткани Скверны Бесенку в Оскверненный лес."
    C["An Imp's Request"] = "Просьба беса"
    C["Hot and Itchy"] = "Пробирает!"
    C["Bring 10 Rotting Wood and 4 Bloodvenom Essence to Impsy in Felwood."] = "Принесите 10 кусков гнилой древесины и 4 порции экстракта ядовитой крови Бесенку в Оскверненный лес."
    C["The Wrong Stuff"] = "Бросовый материал"
    C["Bring a total of 6 Voodoo Feathers from the trolls in sunken temple."] = "Принесите 6 вудуистских перьев троллей из затонувшего храма."
    C["Trolls of a Feather"] = "Тролли Пера"
    C["A Troubled Spirit"] = "Неупокоенный дух"
    C["Kill 7 Helboar in the Blasted Lands and return to the Fallen Hero of the Horde."] = "Убейте 7 Зловепрей в Выжженных землях и вернитесь к павшему герою Орды."
    C["Warrior Kinship"] = "Воинское испытание"
    C["Slaughter the Shadowsworn in the Blasted Lands and return to the Fallen Hero of the Horde."] = "Убейте Приверженцев Тени в Выжженных землях и вернитесь к павшему герою Орды."
    C["War on the Shadowsworn"] = "Война против Приверженцев Тени"
    C["Bring the Voodoo Feathers from the trolls in the Sunken Temple to the Fallen Hero of the Horde."] = "Принесите вудуистские перья павшему герою Орды, забрав их у троллей в Затонувшем Храме."
    C["Voodoo Feathers"] = "Вудуистские перья"
    C["Defend Gor'shak."] = "Защитите Горшака."
    C["What Is Going On?"] = "Что происходит?"
    C["Rocknot's Ale"] = "Эль для Каменного Узла"
    C["Travel to Silithus and search for a Reliquary of Purity within the ruins of Southwind Village. If you are able to find it, return with it to Rabine Saturna in Nighthaven, Moonglade."] = "Отправляйтесь в Силитус и найдите реликварий Чистоты в руинах деревни Южного Ветра. Если вам удастся его найти, возвращайтесь к Рабину Сатурне в Ночную Гавань в Лунной поляне."
    C["A Reliquary of Purity"] = "Реликварий Чистоты"
    C["Shards of the Felvine"] = "Осколки сквернита"
    C["Travel to the Warpwood Quarter of Dire Maul and slay the water elemental, Hydrospawn. Return to Lorekeeper Lydros in the Athenaeum with the Hydrospawn Essence."] = "Ступайте в Квартал Криводревов Забытого Города и убейте элементаля воды Гидротварь. Вернитесь в Читальню к сказителю Лидросу и принесите ему сущность Гидротвари."
    C["Arcane Refreshment"] = "Магический напиток"
    C["Starfall"] = "Звездопад"
    C["The Ruins of Kel'Theril"] = "Руины Кел'Терила"
    C["Use Jaron's Pick to find the four Highborne Relic Fragments. Bring them to Aurora Skycaller in Eastern Plaguelands."] = "Используйте кирку Джерона, чтобы добыть фрагменты реликвии высокорожденных, Принесите их Авроре Зову Небес в Восточные Чумные земли."
    C["Troubled Spirits of Kel'Theril"] = "Беспокойные духи Кел'Терила"
    C["Fragments of the Past"] = "Фрагменты прошлого"
    C["Bring an Enchanted Thorium Bar, 5 Crystal Restore, and a Vial of Dire Water to Aurora Skycaller near the Northpass Tower in Eastern Plaguelands."] = "Принесите зачарованный слиток тория, 5 кристаллов Восстановления и фиал пугающей воды Авроре Зову Небес к башне Северного Перевала, в Восточных Чумных землях."
    C["Travel to Ironforge and get High Priest Rohan's Exorcism Censer. You will need to make a donation of 150 gold in order to secure it."] = "Доберитесь до Стальгорна и получите курильницу экзорцизма у Верховного жреца Рохана. За курильницу нужно будет внести плату в размере 150 золотых монет."
    C["Emphasis on Sacrifice"] = "Жертва необходима"
    C["Return the Exorcism Censer to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "Принесите курильницу экзорцизма лорду Грейсону Тенелому в Храмовый квартал Штормграда."
    C["To Show Due Judgment"] = "Демонстрация истинного правосудия"
    C["Use the Exorcism Censer to drive out the spirits that torment Terrordale. When you have slain 25 Terrordale Spirits, return to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "Используйте курильницу экзорцизма для вызова из-под земли призраков, мучающих Долину Ужаса. Когда убьете 25 духов долины Ужаса, вернитесь к лорду Грейсону Тенелому в Храмовый квартал Штормграда."
    C["Exorcising Terrordale"] = "Изгнание призраков из Долины Ужаса"
    C["The Work of Grimand Elmore"] = "Работа Гриманда Элмора"
    C["Bring 40 Runecloth, 6 Arcanite Bars, 10 Arthas' Tears, 5 Stratholme Holy Water vials, and 150 gold to Grimand Elmore in the Dwarven District of Stormwind."] = "Принесите Гриманду Элмору в Квартал Дворфов Штормграда 40 отрезов рунной ткани, 6 арканитовых слитков, 10 цветков слезы Артаса, 5 сосудов со святой водой Стратхольма и 150 золотых монет."
    C["Collection of Goods"] = "Сбор необходимого"
    C["Grimand's Finest Work"] = "Шедевр Гриманда"
    C["Retrieve 20 Enriched Manna Biscuits - the key ingredient in making Manna-Enriched Horse Feed - for Merideth Carlson at Southshore in the Hillsbrad Foothills. The Argent Dawn is known as the sole purveyor of the biscuits. You also need to give her 50 gold to soothe her ruffled sensibilities."] = "Принесите 20 витаминизированных печений из манны – ключевых составляющих обогащенного манной лошадиного корма – Меридет Карлсон в Южнобережье в предгорьях Хилсбрада. Продаются они только в Серебряном Рассвете. Кроме того, понадобится дать ей 50 золотых, чтобы успокоить ее ущемленное самолюбие."
    C["Manna-Enriched Horse Feed"] = "Обогащенный манной лошадиный корм"
    C["Acquire special horse feed used for feeding a spirit horse. Merideth Carlson in Southshore apparently is the source for such food. Travel to the Dire Maul dungeon in Feralas and slay Tendris Warpwood. Doing so will free the Ancient Equine Spirit. Feed it the special horse feed, thereby soothing the spirit. Finally, give it the Arcanite Barding so it may bless it."] = "Купите лошадиный корм для Духа древнего коня у Меридет Карлсон в Южнобережье. Убейте Тендриса Криводрева в башне Забытого Города в Фераласе и освободите духа. Накормите духа кормом и получите благословление для арканитового чепрака."
    C["Ancient Equine Spirit"] = "Дух древнего коня"
    C["Bring 30 bottles of Raging Beast's Blood to Mor'zul Bloodbringer in the Burning Steppes."] = "Принесите 30 бутылок крови яростных зверей Мор'зулу Кровопуску в Пылающие степи."
    C["Rage of Blood"] = "Ярость крови"
    C["Bring the Case of Blood to Gorzeeki Wildeyes in the Burning Steppes."] = "Принесите ларец Крови Горзиеки Дикоглазу в Пылающие степи."
    C["Wildeyes"] = "Дикоглаз"
    C["Purchase Shadowy Potions from Gorzeeki in the Burning Steppes. Use the potions to travel through Jaedenar, and speak with Lord Banehollow."] = "Купите зелья Теней у Горзиеки в Пылающих степях. Приняв зелья, пройдите в Джеденар и поговорите с лордом Гиблопустом."
    C["Lord Banehollow"] = "Лорд Гиблопуст"
    C["Confront Ulathek, then bring The Traitor's Heart to Lord Banehollow in Jaedenar."] = "Сразитесь с Улатеком и принесите сердце предателя лорду Гиблопусту в Джеденар."
    C["Ulathek the Traitor"] = "Улатек Предатель"
    C["Purchase Xorothian Stardust from Ur'dan. Bring it to Gorzeeki Wildeyes in the Burning Steppes."] = "Купите зоротианскую звездную пыль у Ур'Дана. Отнесите ее Горзиеки Дикоглазу в Пылающие степи."
    C["Xorothian Stardust"] = "Зоротианская звездная пыль"
    C["Bring 10 Elixirs of Shadow Power to Gorzeeki Wildeyes in the Burning Steppes."] = "Отнесите 10 эликсиров Силы Теней Горзиеки Дикоглазу в Пылающие степи."
    C["Bell of Dethmoora"] = "Колокол Детмуры"
    C["Bring 6 Large Brilliant Shards and 25 Dark Iron Ore to Gorzeeki in the Burning Steppes."] = "Отнесите 6 больших блестящих осколка и 25 кусков руды черного железа Дикоглазу в Пылающие степи."
    C["Wheel of the Black March"] = "Колесо Черного Похода"
    C["Bring 35 Black Dragonscales to Gorzeeki Wildeyes in the Burning Steppes."] = "Принесите 35 шкур черного дракона Горзиеки Дикоглазу в Пылающие степи."
    C["Doomsday Candle"] = "Свеча Судного Дня"
    C["Bring the Imp in a Jar to the alchemy lab in the Scholomance. After the parchment is created, return the jar to Gorzeeki Wildeyes."] = "Отнесите беса в бутылке в алхимическую лабораторию Некроситета. После создания пергамента верните бутылку Горзиеки Дикоглазу."
    C["Imp Delivery"] = "Доставка беса"
    C["Bring 3 Arcanite Bars to Gorzeeki in the Burning Steppes."] = "Принесите 3 арканитовых слитка Горзиеки в Пылающие степи."
    C["Arcanite"] = "Арканит"
    C["Read Mor'zul's Instructions. Summon a Xorothian Dreadsteed, defeat it, then bind its spirit to you."] = "Прочтите инструкции Мор'зула. Призовите ксоротианского коня погибели, одолейте его и подчините его дух."
    C["Dreadsteed of Xoroth"] = "Ксоротианский конь погибели"
    C["Return the book to its rightful owners."] = "Верните книгу законным владельцам."
    C["The Emerald Dream..."] = "Изумрудный сон"
    C["The Greatest Race of Hunters"] = "Величайшая гонка охотников"
    C["The Arcanist's Cookbook"] = "Поваренная книга чародея"
    C["The Light and How To Swing It"] = "Свет и как его раскачать"
    C["Holy Bologna: What the Light Won't Tell You"] = "Святая Болонья: О чем не говорит Свет"
    C["Garona: A Study on Stealth and Treachery"] = "Гарона: Исследование уловок и предательства"
    C["Frost Shock and You"] = "Ледяной шок и вы"
    C["Harnessing Shadows"] = "Укрощая тени"
    C["Codex of Defense"] = "Кодекс Обороны"
    C["The Medallion of Faith"] = "Медальон Веры"
    C["Slay 20 Noxious Plaguebats and 10 Monstrous Plaguebats. Return to Nathanos Blightcaller when you are finished."] = "Истребите 20 пагубных нетопырей и 10 чудовищных чумных нетопырей. После возвращайтесь к Натаносу Гнилостеню."
    C["Un-Life's Little Annoyances"] = "Мелочи нежизни"
    C["Travel to Corin's Crossing to the east and slaughter the Scourge that inhabit the town. Collect 7 pieces of Living Rot in under 10 minutes. Use the Mortar and Pestle to grind the Living Rot into Coagulated Rot."] = "Отправляйтесь на восток в Перекресток Корина и убейте несколько населяющих его созданий Плети. Соберите 7 кусков живой гнили менее, чем за 10 минут. С помощью ступки и пестика превратите живую гниль в сгущенную гниль."
    C["To Kill With Purpose"] = "Преднамеренное убийство"
    C["The Corpulent One"] = "Огромный червь"
    C["The Champion of the Banshee Queen"] = "Защитник королевы банши"
    C["Tinkee Steamboil"] = "Тинки Кипеллер"
    C["Return with the Blessed Arcanite Barding to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "Вернитесь вместе с благословенным арканитовым чепраком к лорду Грейсону Тенелому в Храмовый квартал Штормграда."
    C["Blessed Arcanite Barding"] = "Благословенный арканитовый чепрак"
    C["Bring an Azerothian Diamond and a Pristine Black Diamond to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "Принесите азеротский алмаз и безупречный черный алмаз лорду Грейсону Тенелому в Храмовый квартал Штормграда."
    C["The Divination Scryer"] = "Магический кристалл"
    C["Use the Divination Scryer in the heart of the Great Ossuary's basement in the Scholomance. Doing so will bring forth the spirits you must judge. Defeating these spirits will summon forth Death Knight Darkreaver. Defeat him and reclaim the lost soul of the fallen charger. Give the Charger's Redeemed Soul and the Blessed Enchanted Barding to Darkreaver's Fallen Charger."] = "Используйте магический кристалл в центре подвала Главного склепа в Некроситете. Победите вызванных духов, а затем – рыцаря смерти Темного Терзателя, который появится после поражения духов. Верните падшему скакуну Темного Терзателя его спасенную душу и покройте его благословенным зачарованным чепраком."
    C["Judgment and Redemption"] = "Суд и расплата"
    C["If you are interested in helping Sagorne Crestrider in Orgrimmar's Valley of Wisdom, bring him an Azerothian Diamond and a Pristine Black Diamond."] = "Принесите Сагорну Гребнестраннику в Аллею Мудрости в Оргриммаре азеротский алмаз и безупречный черный алмаз."
    C["Material Assistance"] = "Существенная помощь"
    C["Use the Divination Scryer in the heart of the Great Ossuary's basement in the Scholomance. Doing so will bring forth spirits you must fight. Defeating these spirits will summon forth Death Knight Darkreaver; defeat him. Bring Darkreaver's Head to Sagorne Creststrider in the Valley of Wisdom, Orgrimmar."] = "Используйте кристальный предсказатель в Главном склепе в Некроситете. Сразитесь с духами. Когда появится Темный Терзатель, убейте его. Принесите голову Темного Терзателя Сагорну Гривастому Страннику в Аллею Мудрости Оргриммара."
    C["The Darkreaver Menace"] = "Угроза Темного Губителя"
end
do local C = ns.CONTENT.ko
    C["Defend Daphne Stilwell from the Defias attack."] = "데피아즈단의 공격으로부터 대프니 스틸웰을 보호하십시오. 둘 중 하나라도 죽으면 실패하게 됩니다. 성공한 후에 대프니 스틸웰과 다시 대화해야 합니다."
    C["The Tome of Valor"] = "용맹의 고서"
    C["The Test of Righteousness"] = "정의의 시험"
    C["Using Jordan's Weapon Notes, find some Whitestone Oak Lumber, Bailor's Refined Ore Shipment, Jordan's Smithing Hammer, and a Kor Gem, and return them to Jordan Stilwell in Ironforge."] = "조던의 쪽지를 참고해 흰돌참나무 재목, 조던의 제련된 광석 상자, 조던의 대장장이 망치, 그리고 코르석을 찾아 아이언포지에 있는 조던 스틸웰에게 가져가야 합니다."
    C["Wait for Jordan Stilwell to finish forging a weapon for you."] = "조던 스틸웰이 무기를 다 만들 때까지 기다려야 합니다."
    C["Strange Water Globe: Drops from Baron Aquanis inside Blackfathom Deeps."] = "이상한 물구슬, 검은심연 나락의 군주 아쿠아니스에게서 획득"
    C["Bring the Strange Water Globe to Je'neu Sancrea at Zoram'gar Outpost, Ashenvale."] = "잿빛 골짜기 조람가르 전초기지의 제뉴 산크리에게 이상한 물구슬을 가져가십시오."
    C["Baron Aquanis"] = "군주 아쿠아니스"
    C["The Greenwarden"] = "녹색감시자"
    C["Kill 15 Mosshide Gnolls and 10 Mosshide Mongrels, then return to Rethiel the Greenwarden."] = "이끼가죽 놀 15마리와 이끼가죽 싸움꾼 10마리를 처치한 뒤 녹색감시자 레시엘에게 돌아가십시오."
    C["Tramping Paws"] = "짓밟는 발"
    C["Bring Rethiel the Greenwarden 9 Crude Flints."] = "녹색감시자 레시엘에게 조잡한 부싯돌 9개를 가져가십시오."
    C["Fire Taboo"] = "불의 금기"
    C["Kill 12 Fen Creepers, then return to Rethiel the Greenwarden."] = "늪지대 덩굴손 12마리를 처치한 뒤 녹색감시자 레시엘에게 돌아가십시오."
    C["Blisters on The Land"] = "대지의 물집"
    C["Brother Anton"] = "수사 안톤"
    C["Bring an Infernal Orb to Tabetha in Dustwallow Marsh."] = "먼지진흙 습지대에 있는 타베사에게 지옥의 보주를 가져가야 합니다."
    C["The Infernal Orb"] = "지옥의 보주"
    C["Kill the Demon of the Orb, then speak with Tabetha."] = "보주의 악마를 물리치고 타베사와 대화하십시오."
    C["The Exorcism"] = "악마 퇴치"
    C["Retrieve an Obsidian Power Source and bring it to Tabetha in Dustwallow Marsh."] = "흑요석 마력원천을 구해서 먼지진흙 습지대에 있는 타베사에게 가져가야 합니다."
    C["Power in Uldaman"] = "울다만의 마력원천"
    C["The Brassbolts Brothers"] = "브라스볼츠 형제"
    C["Tabetha's Task"] = "타베사의 임무"
    C["Collect 15 Bloodpetals and return to Muigin."] = "붉은꽃잎 15개를 모아 무이긴에게 돌아가야 합니다."
    C["Muigin and Larion"] = "무이긴과 라리온"
    C["A Visit to Gregan"] = "그레간 방문"
    C["Collect 5 samples of Atal'ai Haze, then return to Muigin in Un'Goro Crater."] = "아탈라이 아지랑이 5개를 모은 후 운고로 분화구에 있는 무이긴에게 돌아가야 합니다."
    C["Haze of Evil"] = "악의 아지랑이"
    C["Torwa Pathfinder"] = "토르와 패스파인더"
    C["Collect 8 Bloodcap and 8 Gorishi Stings, and return to Torwa Pathfinder in Un'Goro Crater."] = "붉은갓버섯 8개와 고리쉬 독침 8개를 모아서 운고로 분화구에 있는 토르와 패스파인더에게 돌아가십시오."
    C["Bloodpetal Poison"] = "붉은꽃잎 독"
    C["Stab a Devilsaur with the Devilsaur Barb. Return to Torwa Pathfinder in Un'Goro Crater when you have completed this task."] = "데빌사우루스 가시로 데빌사우루스를 찔러야 합니다. 임무를 완수하면 운고로 분화구에 있는 토르와 패스파인더에게 돌아가야 합니다."
    C["Toxic Test"] = "독성 테스트"
    C["Retrieve a Putrid Vine from the guardian at the bottom of the Sunken Temple and return to Torwa Pathfinder."] = "가라앉은 사원 하층부의 수호병으로부터 썩은 덩굴을 찾은 후 토르와 패스파인더에게 돌아가십시오."
    C["A Better Ingredient"] = "더욱 강력한 재료"
    C["The Hunter's Charm"] = "사냥꾼의 부적"
    C["Bring a pair of Perfect Courser Antlers to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast of the Ruins of Eldarath."] = "아즈샤라에 있는 엘다라스 폐허의 북동쪽 절벽 꼭대기에 있는 오그틴크에게 완전한 순록 뿔 한 쌍을 가져가야 합니다."
    C["Courser Antlers"] = "순록 뿔"
    C["Bring 6 Wavethrasher Scales to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "아즈샤라에 엘다라스 폐허의 북동쪽 절벽 꼭대기에 있는 오그틴크에게 폭풍히드라 비늘 6개를 가져가야 합니다."
    C["Wavethrashing"] = "폭풍히드라 사냥"
    C["Bring the Tooth of Morphaz to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "아즈샤라에 엘다라스 폐허의 북동쪽 절벽 꼭대기에 있는 오그틴크에게 몰파즈의 이빨을 가져가야 합니다."
    C["The Green Drake"] = "녹색 비룡 몰파즈"
    C["Magecraft"] = "마법 공예"
    C["Bring 10 Glittering Dust to Archmage Xylem."] = "대마법사 실렘에게 반짝이는 가루 10개를 가져가야 합니다."
    C["Magic Dust"] = "마법의 티끌"
    C["Collect 6 Enchanted Coral and return them to Archmage Xylem."] = "대마법사 실렘에게 마력 깃든 산호 6개를 가져가야 합니다."
    C["The Siren's Coral"] = "세이렌의 산호"
    C["Retrieve the Arcane Shard from Morphaz and return to Archmage Xylem."] = "몰파즈에게서 신비의 결정을 되찾아 대마법사 실렘에게 가져가야 합니다."
    C["Destroy Morphaz"] = "몰파즈 처치"
    C["Chillwind Point"] = "서리바람 거점으로"
    C["Collect 20 Minion's Scourgestones and bring them to High Priest Thel'danis in the Western Plaguelands."] = "서부 역병지대에 있는 대사제 텔다니스에게 앞잡이의 스컬지석 20개를 모아 가져가야 합니다."
    C["Dispelling Evil"] = "악마 퇴치"
    C["Bring the Inert Scourgestone to Commander Ashlan Valorfist in Chillwind Point."] = "서리바람 거점에 있는 사령관 아쉬람 발러피스트에게 마력을 잃은 스컬지석을 가져가야 합니다."
    C["Inert Scourgestones"] = "마력을 잃은 스컬지석"
    C["Bring the voodoo feathers to Ashlam Valorfist."] = "아쉬람 발러피스트에게 황색 부두 깃털, 청색 부두 깃털, 녹색 부두 깃털을 각 2개씩 가져가야 합니다."
    C["Forging the Mightstone"] = "퇴마석 만들기"
    C["Cenarion Aid"] = "세나리온 의회 지원"
    C["Acquire 4 Healthy Courser Glands and bring them to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "건강한 순록의 분비샘 4개를 찾아 아즈샤라의 오그틴크에게 가져가야 합니다. 오그틴크는 엘다라스 폐허의 북동쪽 절벽 꼭대기에 있습니다."
    C["Of Coursers We Know"] = "순록을 찾아서"
    C["Acquire an Ichor of Undeath for Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "아즈샤라의 오그틴크에게 불사의 영액을 가져다주어야 합니다. 오그틴크는 엘다라스 폐허 북동쪽 절벽 꼭대기에 있습니다."
    C["The Ichor of Undeath"] = "불사의 영액"
    C["Kill Morphaz in the sunken temple of Atal'Hakkar, and return his blood to Greta Mosshoof in Felwood. The entrance to the sunken temple can be found in the Swamp of Sorrows."] = "아탈학카르 신전에서 몰파즈를 처치하고 그의 피를 악령의 숲에 있는 그레타 모스후프에게 가져다주어야 합니다. 가라앉은 신전의 입구는 슬픔의 늪에 있습니다."
    C["Blood of Morphaz"] = "몰파즈의 피"
    C["A Simple Request"] = "간단한 부탁"
    C["Retrieve the Sealed Azure Bag from the Timbermaw Shaman in Azshara. Then take the bag to Archmage Xylem, also found in Azshara."] = "아즈샤라에 있는 나무구렁일족 주술사에게서 봉인된 하늘색 자루를 되찾은 후, 그 가방을 아즈샤라에 있는 대마법사 실렘에게 가져가야 합니다."
    C["Sealed Azure Bag"] = "봉인된 하늘색 자루"
    C["Bring 10 Encoded Fragments to Archmage Xylem in Azshara."] = "아즈샤라에 있는 대마법사 실렘에게 암호화 된 페이지 10개를 가져가야 합니다."
    C["Encoded Fragments"] = "암호화된 페이지"
    C["Return the Azure Key to Lord Jorach Ravenholdt."] = "조라크 라벤홀트 경에게 하늘색 열쇠를 가져가야 합니다."
    C["The Azure Key"] = "하늘색 열쇠"
    C["Collect a sample of air, fire, earth and water for Bath'rah the Windwatcher."] = "물, 불, 대지, 바람의 샘플을 수집하여 바람의감시자 바스라에게 가져가야 합니다."
    C["Elemental Mastery"] = "원소에 대한 깨달음"
    C["Bring the pieces for the spirit totem to Bath'rah the Windwatcher."] = "바람의감시자 바스라에게 정기의 토템을 만드는데 필요한 재료들을 가져가야 합니다."
    C["Spirit Totem"] = "정기의 토템"
    C["Bring the voodoo feathers to Bath'rah the Windwatcher."] = "바람의감시자 바스라에게 부두 깃털들을 가져가야 합니다."
    C["Da Voodoo"] = "부두교 마법"
    C["Bring a piece of felcloth to Impsy in Felwood."] = "악령의 숲에 있는 임프시에게 지옥 옷감을 한 장 가져가야 합니다."
    C["An Imp's Request"] = "임프의 부탁"
    C["Hot and Itchy"] = "뜨거운 소유욕"
    C["Bring 10 Rotting Wood and 4 Bloodvenom Essence to Impsy in Felwood."] = "악령의 숲에 있는 임프시에게 썩은 나무 10개와 피멍울 정수 4개를 가져가야 합니다."
    C["The Wrong Stuff"] = "인형 재료"
    C["Bring a total of 6 Voodoo Feathers from the trolls in sunken temple."] = "가라앉은 사원에 있는 트롤의 부두 깃털 6개를 가져가야 합니다."
    C["Trolls of a Feather"] = "트롤의 깃털"
    C["A Troubled Spirit"] = "영혼이 된 영웅의 고통"
    C["Kill 7 Helboar in the Blasted Lands and return to the Fallen Hero of the Horde."] = "저주받은 땅에 있는 지옥멧돼지 7마리를 처치하고 호드 영웅의 넋에게 돌아가야 합니다."
    C["Warrior Kinship"] = "전사의 일족"
    C["Slaughter the Shadowsworn in the Blasted Lands and return to the Fallen Hero of the Horde."] = "저주받은 땅에서 어둠의혈맹 숙련사제, 이교도, 암살단원을 각 20명씩 해치우고 호드 영웅의 넋에게 돌아가야 합니다."
    C["War on the Shadowsworn"] = "어둠의혈맹과의 전쟁"
    C["Bring the Voodoo Feathers from the trolls in the Sunken Temple to the Fallen Hero of the Horde."] = "호드 영웅의 넋에게 가라앉은 사원에 있는 트롤들에게서 황색 부두 깃털, 청색 부두 깃털, 녹색 부두 깃털을 빼앗아 각 2개씩 가져가야 합니다."
    C["Voodoo Feathers"] = "부두 깃털"
    C["Defend Gor'shak."] = "고르샤크를 보호해야 합니다."
    C["What Is Going On?"] = "사태 파악"
    C["Rocknot's Ale"] = "락노트의 에일 맥주"
    C["Travel to Silithus and search for a Reliquary of Purity within the ruins of Southwind Village. If you are able to find it, return with it to Rabine Saturna in Nighthaven, Moonglade."] = "실리더스로 가서 마파람 마을 부근 유적지에 있을 정화의 성물함을 찾아내야 합니다. 찾게 되면 달의 숲의 나이트헤이븐에 있는 라빈 사투르나에게 돌아가야 합니다."
    C["A Reliquary of Purity"] = "정화의 성물함"
    C["Shards of the Felvine"] = "악령덩굴 조각"
    C["Travel to the Warpwood Quarter of Dire Maul and slay the water elemental, Hydrospawn. Return to Lorekeeper Lydros in the Athenaeum with the Hydrospawn Essence."] = "혈투의 전장에 있는 굽이나무 지구로 가서 물의 정령인 히드로스폰을 처치하십시오. 히드로스폰의 정수를 가지고 도서관에 있는 현자 리드로스에게 돌아가야 합니다."
    C["Arcane Refreshment"] = "신비의 원기 회복 주문"
    C["Starfall"] = "별똥별 마을"
    C["The Ruins of Kel'Theril"] = "켈테릴의 폐허"
    C["Use Jaron's Pick to find the four Highborne Relic Fragments. Bring them to Aurora Skycaller in Eastern Plaguelands."] = "야론의 곡괭이를 사용해 귀족 유물 조각 4개를 찾아 동부 역병지대에 있는 아우로라 스카이콜러에 갖다주어야 합니다."
    C["Troubled Spirits of Kel'Theril"] = "켈테릴의 고통받는 영혼"
    C["Fragments of the Past"] = "과거의 조각"
    C["Bring an Enchanted Thorium Bar, 5 Crystal Restore, and a Vial of Dire Water to Aurora Skycaller near the Northpass Tower in Eastern Plaguelands."] = "마력 깃든 토륨 주괴 1개와 회복의 수정 5개, 그리고 혈투의 웅덩이 물병을 동부 역병지대의 북부관문 경비탑 근처에 있는 아우로라 스카이콜러에게 가져가야 합니다."
    C["Travel to Ironforge and get High Priest Rohan's Exorcism Censer. You will need to make a donation of 150 gold in order to secure it."] = "아이언포지에 가서 대사제 로한의 퇴마 향로를 가져와야 합니다. 퇴마 향로를 얻으려면 150골드를 기부해야 합니다."
    C["Emphasis on Sacrifice"] = "희생의 중요성"
    C["Return the Exorcism Censer to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "퇴마 향로를 가지고 스톰윈드 빛의 대성당에 있는 그레이슨 섀도브레이커 경에게 돌아가야 합니다."
    C["To Show Due Judgment"] = "희생과 심판"
    C["Use the Exorcism Censer to drive out the spirits that torment Terrordale. When you have slain 25 Terrordale Spirits, return to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "퇴마 향로를 사용하여 테러데일에 고통을 주는 영혼을 몰아내야 합니다. 25명의 테러데일 영혼을 해치운 다음 스톰윈드 빛의 대성당에 있는 그레이슨 섀도브레이커 경에게 돌아가야 합니다."
    C["Exorcising Terrordale"] = "테러데일 퇴마"
    C["The Work of Grimand Elmore"] = "그리만트 엘모어의 마갑"
    C["Bring 40 Runecloth, 6 Arcanite Bars, 10 Arthas' Tears, 5 Stratholme Holy Water vials, and 150 gold to Grimand Elmore in the Dwarven District of Stormwind."] = "룬무늬 옷감 40개, 아케이나이트 주괴 6개, 아서스의 눈물 10개, 스트라솔름 성수 물병 5개 그리고 150골드를 스톰윈드의 드워프 지구에 있는 그리만트 엘모어에게 가져가야 합니다."
    C["Collection of Goods"] = "마갑 재료 수집"
    C["Grimand's Finest Work"] = "그리만트의 걸작품"
    C["Retrieve 20 Enriched Manna Biscuits - the key ingredient in making Manna-Enriched Horse Feed - for Merideth Carlson at Southshore in the Hillsbrad Foothills. The Argent Dawn is known as the sole purveyor of the biscuits. You also need to give her 50 gold to soothe her ruffled sensibilities."] = "맛좋은 만나빵 20개를 모아서 힐스브래드 구릉지의 사우스쇼어에 있는 메리데스 칼슨에게 가져가야 합니다. 맛좋은 만나빵은 맛좋은 만나 사료에 꼭 필요한 재료입니다. 맛좋은 만나빵은 은빛 여명회에서 독점적으로 파는 것으로 알려져 있습니다. 메리데스 칼슨에게도 50골드를 주어야만 화가 난 마음을 진정시킬 수 있습니다."
    C["Manna-Enriched Horse Feed"] = "맛좋은 만나 사료"
    C["Acquire special horse feed used for feeding a spirit horse. Merideth Carlson in Southshore apparently is the source for such food. Travel to the Dire Maul dungeon in Feralas and slay Tendris Warpwood. Doing so will free the Ancient Equine Spirit. Feed it the special horse feed, thereby soothing the spirit. Finally, give it the Arcanite Barding so it may bless it."] = "사우스쇼어에 있는 메리데스 칼슨에게 말의 영혼에게 먹일 특별한 말 먹이를 얻어야 합니다. 페랄라스에 있는 혈투의 전장 던전으로 가서 굽이나무 텐드리스를 무찔러야 합니다. 굽이나무 텐드리스를 무찌르고 고대 준마의 영혼이 풀려나면 특별한 말 먹이를 먹여 영혼을 진정시키십시오. 마지막으로 아케이나이트 마갑을 주면 영혼이 축복을 내릴 것입니다."
    C["Ancient Equine Spirit"] = "고대 준마의 영혼"
    C["Bring 30 bottles of Raging Beast's Blood to Mor'zul Bloodbringer in the Burning Steppes."] = "불타는 평원에 있는 모르줄 블러드브링어에게 흉포한 올빼미야수의 피 30병을 가져가야 합니다."
    C["Rage of Blood"] = "피의 광란"
    C["Bring the Case of Blood to Gorzeeki Wildeyes in the Burning Steppes."] = "불타는 평원에 있는 고르지키 와일드아이즈에게 피가 담긴 상자를 가져가야 합니다."
    C["Wildeyes"] = "와일드아이즈"
    C["Purchase Shadowy Potions from Gorzeeki in the Burning Steppes. Use the potions to travel through Jaedenar, and speak with Lord Banehollow."] = "불타는 평원에 있는 고르지키에게서 어둠의 물약을 구입해야 합니다. 이 물약을 사용하여 자에데나르로 가서 군주 베인할로우와 대화하십시오."
    C["Lord Banehollow"] = "군주 베인할로우"
    C["Confront Ulathek, then bring The Traitor's Heart to Lord Banehollow in Jaedenar."] = "울라텍과 맞서 싸운 후 자에데나르에 있는 베인할로우 군주에게 배신자의 증거를 가져가야 합니다."
    C["Ulathek the Traitor"] = "배신자 울라텍"
    C["Purchase Xorothian Stardust from Ur'dan. Bring it to Gorzeeki Wildeyes in the Burning Steppes."] = "우르단에게서 소로시안 별가루를 구입한 후, 불타는 평원에 있는 고르지키 와일드아이즈에게 가져가야 합니다."
    C["Xorothian Stardust"] = "소로시안 별가루"
    C["Bring 10 Elixirs of Shadow Power to Gorzeeki Wildeyes in the Burning Steppes."] = "불타는 평원에 있는 고르지키 와일드아이즈에게 암흑 강화의 비약 10개를 가져가야 합니다."
    C["Bell of Dethmoora"] = "데스무라의 종"
    C["Bring 6 Large Brilliant Shards and 25 Dark Iron Ore to Gorzeeki in the Burning Steppes."] = "불타는 평원에 있는 고르지키 와일드아이즈에게 눈부신 큰 결정 6개와 검은무쇠 광석 25개를 가져가야 합니다."
    C["Wheel of the Black March"] = "어둠의 물레"
    C["Bring 35 Black Dragonscales to Gorzeeki Wildeyes in the Burning Steppes."] = "불타는 평원에 있는 고르지키 와일드아이즈에게 검은용 비늘 35개를 가져가야 합니다."
    C["Doomsday Candle"] = "심판의 양초"
    C["Bring the Imp in a Jar to the alchemy lab in the Scholomance. After the parchment is created, return the jar to Gorzeeki Wildeyes."] = "단지 안에 든 임프를 스칼로맨스에 있는 연금술 실험대로 가져가야 합니다. 양피지가 완성되면 단지를 고르지키 와일드아이즈에게 되돌려 주십시오."
    C["Imp Delivery"] = "임프 배달"
    C["Bring 3 Arcanite Bars to Gorzeeki in the Burning Steppes."] = "불타는 평원에 있는 고르지키에게 아케이나이트 주괴 3개를 가져가야 합니다."
    C["Arcanite"] = "아케이나이트"
    C["Read Mor'zul's Instructions. Summon a Xorothian Dreadsteed, defeat it, then bind its spirit to you."] = "모르줄의 지시서를 잘 읽으십시오. 소로시안 공포마를 소환해 물리친 후 그 영혼을 결속시켜야 합니다."
    C["Dreadsteed of Xoroth"] = "소로스의 공포마"
    C["Return the book to its rightful owners."] = "주인에게 책을 되돌려주십시오."
    C["The Emerald Dream..."] = "에메랄드의 꿈..."
    C["The Greatest Race of Hunters"] = "사냥꾼의 위대한 혈통"
    C["The Arcanist's Cookbook"] = "신비술사의 요리책"
    C["The Light and How To Swing It"] = "빛과 정의에 관하여"
    C["Holy Bologna: What the Light Won't Tell You"] = "성스러운 볼로냐: 빛이 알려주지 않는 것들"
    C["Garona: A Study on Stealth and Treachery"] = "가로나: 은신과 기만에 대한 연구"
    C["Frost Shock and You"] = "냉기 충격과 주술"
    C["Harnessing Shadows"] = "지배의 그림자"
    C["Codex of Defense"] = "방어의 고서"
    C["The Medallion of Faith"] = "신념의 메달"
    C["Slay 20 Noxious Plaguebats and 10 Monstrous Plaguebats. Return to Nathanos Blightcaller when you are finished."] = "맹독 역병박쥐 20마리와 기괴한 역병박쥐 10마리를 해치운 후 나타노스 블라이트 콜러에게 돌아가야 합니다."
    C["Un-Life's Little Annoyances"] = "성가신 녀석들"
    C["Travel to Corin's Crossing to the east and slaughter the Scourge that inhabit the town. Collect 7 pieces of Living Rot in under 10 minutes. Use the Mortar and Pestle to grind the Living Rot into Coagulated Rot."] = "동쪽의 코린 삼거리로 가서 마을에 사는 스컬지를 해치워 10분 안에 살아있는 부패물 7개를 모으십시오. 막자 사발을 사용해서 살아있는 부패물을 갈아 응고된 부패물로 만들어야 합니다."
    C["To Kill With Purpose"] = "이유 있는 살육"
    C["The Corpulent One"] = "뚱뚱보 괴물"
    C["The Champion of the Banshee Queen"] = "밴시 여왕의 용사"
    C["Tinkee Steamboil"] = "팅키 스팀보일"
    C["Return with the Blessed Arcanite Barding to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "을 가지고 스톰윈드의 빛의 대성당에 있는 그레이슨 섀도브레이커 경에게 돌아가야 합니다."
    C["Blessed Arcanite Barding"] = "축복받은 아케이나이트 마갑"
    C["Bring an Azerothian Diamond and a Pristine Black Diamond to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "스톰윈드의 빛의 대성당에 있는 그레이슨 섀도브레이커 경에게 아제로스 다이아몬드와 온전한 검은 다이아몬드를 가져가야 합니다."
    C["The Divination Scryer"] = "예언의 탐지기"
    C["Use the Divination Scryer in the heart of the Great Ossuary's basement in the Scholomance. Doing so will bring forth the spirits you must judge. Defeating these spirits will summon forth Death Knight Darkreaver. Defeat him and reclaim the lost soul of the fallen charger. Give the Charger's Redeemed Soul and the Blessed Enchanted Barding to Darkreaver's Fallen Charger."] = "스칼로맨스에 있는 대형 납골당 지하의 중심부로 가서 예언의 탐지기를 사용해야 합니다. 그러면 영혼들이 나타날 것이니 그들을 해치우십시오. 그들을 해치우면 죽음의 기사 다크리버가 나타날 것이니 그를 물리친 다음 군마의 영혼의 잃어버린 영혼을 되찾아야 합니다. 구원된 군마의 영혼과 축복받은 아케이나이트 마갑을 다크리버 군마의 영혼에게 돌려줘야 합니다."
    C["Judgment and Redemption"] = "심판과 구원의 손길"
    C["If you are interested in helping Sagorne Crestrider in Orgrimmar's Valley of Wisdom, bring him an Azerothian Diamond and a Pristine Black Diamond."] = "오그리마, 지혜의 골짜기에 있는 사고른 크레스트스트라이더의 일을 도우려면 그에게 아제로스 다이아몬드와 온전한 검은 다이아몬드를 가져가야 합니다."
    C["Material Assistance"] = "물질적인 부탁"
    C["Use the Divination Scryer in the heart of the Great Ossuary's basement in the Scholomance. Doing so will bring forth spirits you must fight. Defeating these spirits will summon forth Death Knight Darkreaver; defeat him. Bring Darkreaver's Head to Sagorne Creststrider in the Valley of Wisdom, Orgrimmar."] = "스칼로맨스에 있는 대형 납골당 지하의 중앙으로 가서 예언의 탐지기를 사용하십시오. 그러면 유령들이 나타날 것입니다. 그들을 해치우십시오. 그리고 곧이어 나타날 죽음의 기사 다크리버를 해치워야 합니다. 그런 다음 그 증거로 오그리마, 지혜의 골짜기에 있는 사고른 크레스트스트라이더에게 다크리버의 머리카락을 가져가야 합니다."
    C["The Darkreaver Menace"] = "다크리버의 위협"
end
do local C = ns.CONTENT.zh
    C["Defend Daphne Stilwell from the Defias attack."] = "在迪菲亚兄弟会进攻时保护达芙妮·斯迪威尔的安全。如果你想成功的话，你和达芙妮都不能死在他们的剑下。"
    C["The Tome of Valor"] = "勇气之书"
    C["The Test of Righteousness"] = "正义试炼"
    C["Using Jordan's Weapon Notes, find some Whitestone Oak Lumber, Bailor's Refined Ore Shipment, Jordan's Smithing Hammer, and a Kor Gem, and return them to Jordan Stilwell in Ironforge."] = "按照乔丹的武器材料单上的说明去寻找一些白石橡木、精炼矿石、乔丹的铁锤和一块科尔宝石，然后回到铁炉堡去见乔丹·斯迪威尔。"
    C["Wait for Jordan Stilwell to finish forging a weapon for you."] = "等待乔丹·斯迪威尔为你铸造武器。"
    C["Strange Water Globe: Drops from Baron Aquanis inside Blackfathom Deeps."] = "奇怪的水球，由黑暗深渊中的阿奎尼斯男爵掉落"
    C["Bring the Strange Water Globe to Je'neu Sancrea at Zoram'gar Outpost, Ashenvale."] = "把奇怪的水球交给灰谷佐拉姆加前哨站的耶努萨克雷。"
    C["Baron Aquanis"] = "阿奎尼斯男爵"
    C["The Greenwarden"] = "绿色守卫者"
    C["Kill 15 Mosshide Gnolls and 10 Mosshide Mongrels, then return to Rethiel the Greenwarden."] = "消灭15个藓皮豺狼人和10个藓皮混血者，然后返回绿色守卫者雷希耶尔处。"
    C["Tramping Paws"] = "践踏之爪"
    C["Bring Rethiel the Greenwarden 9 Crude Flints."] = "给绿色守卫者雷希耶尔带去9块粗糙燧石。"
    C["Fire Taboo"] = "火焰禁忌"
    C["Kill 12 Fen Creepers, then return to Rethiel the Greenwarden."] = "消灭12只沼泽爬行者，然后返回绿色守卫者雷希耶尔处。"
    C["Blisters on The Land"] = "大地上的脓疱"
    C["Brother Anton"] = "安东修士"
    C["Bring an Infernal Orb to Tabetha in Dustwallow Marsh."] = "将一颗地狱火宝珠交给尘泥沼泽的塔贝萨。"
    C["The Infernal Orb"] = "地狱火宝珠"
    C["Kill the Demon of the Orb, then speak with Tabetha."] = "杀死宝珠之魔，然后与塔贝萨谈一谈。"
    C["The Exorcism"] = "驱除魔鬼"
    C["Retrieve an Obsidian Power Source and bring it to Tabetha in Dustwallow Marsh."] = "找到一个黑曜石能量源，将其交给尘泥沼泽的塔贝萨。"
    C["Power in Uldaman"] = "奥达曼的能量源"
    C["The Brassbolts Brothers"] = "铜栓兄弟"
    C["Tabetha's Task"] = "塔贝萨的任务"
    C["Collect 15 Bloodpetals and return to Muigin."] = "从安戈洛尔环形山的血瓣花猛击者和血瓣花掠夺者身上收集15个血瓣花，然后向穆尔金回复。"
    C["Muigin and Larion"] = "穆尔金和拉瑞安"
    C["A Visit to Gregan"] = "造访格雷甘"
    C["Collect 5 samples of Atal'ai Haze, then return to Muigin in Un'Goro Crater."] = "收集5份阿塔莱之雾的样本，然后向安戈洛环形山的穆尔金复命。"
    C["Haze of Evil"] = "邪恶之雾"
    C["Torwa Pathfinder"] = "托尔瓦·寻路者"
    C["Collect 8 Bloodcap and 8 Gorishi Stings, and return to Torwa Pathfinder in Un'Goro Crater."] = "收集一些血帽和格里什钉刺，然后向托尔瓦·寻路者复命。"
    C["Bloodpetal Poison"] = "血瓣毒药"
    C["Stab a Devilsaur with the Devilsaur Barb. Return to Torwa Pathfinder in Un'Goro Crater when you have completed this task."] = "将魔暴龙之刺扎入一只魔暴龙的体内。"
    C["Toxic Test"] = "毒性测试"
    C["Retrieve a Putrid Vine from the guardian at the bottom of the Sunken Temple and return to Torwa Pathfinder."] = "从沉没的神庙底部的守卫身上得到一些腐烂藤蔓，把它们交给托尔瓦·寻路者。"
    C["A Better Ingredient"] = "更好的材料"
    C["The Hunter's Charm"] = "猎人的护符"
    C["Bring a pair of Perfect Courser Antlers to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast of the Ruins of Eldarath."] = "将一副完好的苔蹄快步者鹿角交给艾萨拉的奥汀克。奥汀克居住在埃达拉斯废墟东北部的悬崖顶。"
    C["Courser Antlers"] = "苔蹄快步者的鹿角"
    C["Bring 6 Wavethrasher Scales to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "将6块碎浪多头怪的鳞片交给艾萨拉的奥汀克。奥汀克居住在埃达拉斯废墟东北部的悬崖顶部。"
    C["Wavethrashing"] = "碎浪多头怪"
    C["Bring the Tooth of Morphaz to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "将摩弗拉斯的牙齿交给艾萨拉的奥汀克。他住在埃达拉斯废墟东北部悬崖的顶端。"
    C["The Green Drake"] = "神庙中的绿龙"
    C["Magecraft"] = "法师的会见"
    C["Bring 10 Glittering Dust to Archmage Xylem."] = "为大法师克希雷姆收集10份闪光尘埃。"
    C["Magic Dust"] = "魔法的尘埃"
    C["Collect 6 Enchanted Coral and return them to Archmage Xylem."] = "收集6块魔化珊瑚，然后把它们交给大法师克希雷姆。"
    C["The Siren's Coral"] = "纳迦的珊瑚"
    C["Retrieve the Arcane Shard from Morphaz and return to Archmage Xylem."] = "从摩弗拉斯身上取回奥术碎片，然后返回大法师克希雷姆那儿。"
    C["Destroy Morphaz"] = "毁灭摩弗拉斯"
    C["Chillwind Point"] = "冰风岗"
    C["Collect 20 Minion's Scourgestones and bring them to High Priest Thel'danis in the Western Plaguelands."] = "收集20个爪牙的天灾石，并将它们交给西瘟疫之地的高阶牧师赛尔丹尼斯。"
    C["Dispelling Evil"] = "驱散邪恶"
    C["Bring the Inert Scourgestone to Commander Ashlan Valorfist in Chillwind Point."] = "将惰性天灾石交给冰风岗的指挥官阿什拉姆·瓦罗菲斯特。"
    C["Inert Scourgestones"] = "惰性天灾石"
    C["Bring the voodoo feathers to Ashlam Valorfist."] = "前往沉没的神庙，从巨魔守护者们身上取得巫毒羽毛，然后把它们交给阿什拉姆·瓦罗菲斯特。"
    C["Forging the Mightstone"] = "铸造力量之石"
    C["Cenarion Aid"] = "塞纳里奥议会的求助"
    C["Acquire 4 Healthy Courser Glands and bring them to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "收集4份健康的野鹿腺体，把它们交给艾萨拉的奥汀克。奥汀克住在埃达拉斯废墟东北部悬崖的顶部。"
    C["Of Coursers We Know"] = "苔蹄快步者"
    C["Acquire an Ichor of Undeath for Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "为艾萨拉的奥汀克带回一份亡灵腐液。奥汀克住在埃达拉斯废墟东北部悬崖的顶端。"
    C["The Ichor of Undeath"] = "亡灵的腐液"
    C["Kill Morphaz in the sunken temple of Atal'Hakkar, and return his blood to Greta Mosshoof in Felwood. The entrance to the sunken temple can be found in the Swamp of Sorrows."] = "前往沉没的阿塔哈卡神庙，杀死绿龙摩弗拉斯，将他的血液交给费伍德森林中的格雷塔·苔蹄。沉没的神庙的入口就在悲伤沼泽中。"
    C["Blood of Morphaz"] = "摩弗拉斯之血"
    C["A Simple Request"] = "简单的要求"
    C["Retrieve the Sealed Azure Bag from the Timbermaw Shaman in Azshara. Then take the bag to Archmage Xylem, also found in Azshara."] = "从艾萨拉的木喉萨满祭司那儿取回密封的蓝袋子，将它交给艾萨拉的大法师克希雷姆。"
    C["Sealed Azure Bag"] = "密封的蓝袋子"
    C["Bring 10 Encoded Fragments to Archmage Xylem in Azshara."] = "将10块密文碎片交给艾萨拉的大法师克希雷姆。"
    C["Encoded Fragments"] = "密文碎片"
    C["Return the Azure Key to Lord Jorach Ravenholdt."] = "将碧蓝钥匙交给乔拉齐·拉文霍德公爵。"
    C["The Azure Key"] = "碧蓝钥匙"
    C["Collect a sample of air, fire, earth and water for Bath'rah the Windwatcher."] = "为捕风者巴斯拉收集一份空气样本、一份火元素样本、一份土元素样本和一份水元素样本。"
    C["Elemental Mastery"] = "元素掌握"
    C["Bring the pieces for the spirit totem to Bath'rah the Windwatcher."] = "将灵魂图腾所需的材料交给捕风者巴斯拉。"
    C["Spirit Totem"] = "灵魂图腾"
    C["Bring the voodoo feathers to Bath'rah the Windwatcher."] = "将巫毒羽毛交给捕风者巴斯拉。"
    C["Da Voodoo"] = "巫毒羽毛"
    C["Bring a piece of felcloth to Impsy in Felwood."] = "将一块恶魔布交给费伍德森林的伊普斯。"
    C["An Imp's Request"] = "小鬼的要求"
    C["Hot and Itchy"] = "灼热的疼痛"
    C["Bring 10 Rotting Wood and 4 Bloodvenom Essence to Impsy in Felwood."] = "将10块腐烂的木头和4个血毒精华交给费伍德森林的伊普斯。"
    C["The Wrong Stuff"] = "奇怪的材料"
    C["Bring a total of 6 Voodoo Feathers from the trolls in sunken temple."] = "到沉没的神庙去，从巨魔们身上获得6支巫毒羽毛。"
    C["Trolls of a Feather"] = "巨魔的羽毛"
    C["A Troubled Spirit"] = "困扰的灵魂"
    C["Kill 7 Helboar in the Blasted Lands and return to the Fallen Hero of the Horde."] = "杀死7头地狱野猪，然后回到部落英雄的灵魂那儿。"
    C["Warrior Kinship"] = "战士的血脉"
    C["Slaughter the Shadowsworn in the Blasted Lands and return to the Fallen Hero of the Horde."] = "杀死诅咒之地的魔誓者，然后回到部落英雄的灵魂那儿。"
    C["War on the Shadowsworn"] = "魔誓者之战"
    C["Bring the Voodoo Feathers from the trolls in the Sunken Temple to the Fallen Hero of the Horde."] = "将你从沉没的神庙的巨魔身上得到的巫毒羽毛交给部落英雄的灵魂。"
    C["Voodoo Feathers"] = "巫毒羽毛"
    C["Defend Gor'shak."] = "保护哥沙克。"
    C["What Is Going On?"] = "出了什么事？"
    C["Rocknot's Ale"] = "罗克诺特的麦酒"
    C["Travel to Silithus and search for a Reliquary of Purity within the ruins of Southwind Village. If you are able to find it, return with it to Rabine Saturna in Nighthaven, Moonglade."] = "到希利苏斯的南风村去寻找净化之匣。然后将其交给月光林地永夜港的拉比恩·萨图纳。"
    C["A Reliquary of Purity"] = "净化之匣"
    C["Shards of the Felvine"] = "魔藤碎片"
    C["Travel to the Warpwood Quarter of Dire Maul and slay the water elemental, Hydrospawn. Return to Lorekeeper Lydros in the Athenaeum with the Hydrospawn Essence."] = "到厄运之槌的扭木广场去杀掉水元素海多斯博恩。把海多斯博恩精华交给图书馆的博学者莱德罗斯。"
    C["Arcane Refreshment"] = "久违的法师"
    C["Starfall"] = "坠星村"
    C["The Ruins of Kel'Theril"] = "凯斯利尔废墟"
    C["Use Jaron's Pick to find the four Highborne Relic Fragments. Bring them to Aurora Skycaller in Eastern Plaguelands."] = "使用加隆的镐来寻找四块上层精灵遗物的碎片，把它们交给东瘟疫之地的奥萝拉。"
    C["Troubled Spirits of Kel'Theril"] = "凯斯利尔的怨灵"
    C["Fragments of the Past"] = "历史的残片"
    C["Bring an Enchanted Thorium Bar, 5 Crystal Restore, and a Vial of Dire Water to Aurora Skycaller near the Northpass Tower in Eastern Plaguelands."] = "给东瘟疫之地的奥萝拉带去一块魔化瑟银锭、5块恢复水晶，以及一小瓶恐怖之水。"
    C["Travel to Ironforge and get High Priest Rohan's Exorcism Censer. You will need to make a donation of 150 gold in order to secure it."] = "到铁炉堡去找高阶牧师洛汉，从他那里拿到驱魔香炉。你需要捐赠150金币来获得它。"
    C["Emphasis on Sacrifice"] = "牺牲精神"
    C["Return the Exorcism Censer to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "把驱魔香炉交给暴风城教堂区的格雷森·沙东布瑞克公爵。"
    C["To Show Due Judgment"] = "圣骑士的审判"
    C["Use the Exorcism Censer to drive out the spirits that torment Terrordale. When you have slain 25 Terrordale Spirits, return to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "使用驱魔香炉召唤恐惧谷中的灵魂。当你杀掉25个恐惧谷的灵魂之后，回到暴风城教堂区的格雷森·沙东布瑞克公爵那里复命。"
    C["Exorcising Terrordale"] = "恐惧谷的灵魂"
    C["The Work of Grimand Elmore"] = "格瑞曼德·艾尔默"
    C["Bring 40 Runecloth, 6 Arcanite Bars, 10 Arthas' Tears, 5 Stratholme Holy Water vials, and 150 gold to Grimand Elmore in the Dwarven District of Stormwind."] = "把40块符文布、6块奥金锭、10棵阿尔萨斯之泪、5瓶斯坦索姆圣水和150枚金币交给暴风城矮人区的格瑞曼德·艾尔默。"
    C["Collection of Goods"] = "收集材料"
    C["Grimand's Finest Work"] = "艾尔默的手艺"
    C["Retrieve 20 Enriched Manna Biscuits - the key ingredient in making Manna-Enriched Horse Feed - for Merideth Carlson at Southshore in the Hillsbrad Foothills. The Argent Dawn is known as the sole purveyor of the biscuits. You also need to give her 50 gold to soothe her ruffled sensibilities."] = "把制作魔法粮草所需要的重要材料：20块可口的魔法点心带给希尔斯布莱德丘陵的梅丽德丝·卡尔森。据说银色黎明会出售这种饼干。 你还需要给她50金币来对她进行安抚。"
    C["Manna-Enriched Horse Feed"] = "魔法粮草"
    C["Acquire special horse feed used for feeding a spirit horse. Merideth Carlson in Southshore apparently is the source for such food. Travel to the Dire Maul dungeon in Feralas and slay Tendris Warpwood. Doing so will free the Ancient Equine Spirit. Feed it the special horse feed, thereby soothing the spirit. Finally, give it the Arcanite Barding so it may bless it."] = "你需要特殊的饲料来喂养灵魂马。南海镇的梅丽德丝·卡尔森可以为你提供这样的粮草。 到菲拉斯的厄运之槌去，杀掉特迪斯·扭木，释放上古圣马之魂。用特殊的粮草喂养它，这样可以安抚它的灵魂。最后，把奥金马铠交给它就可以完成祝福。"
    C["Ancient Equine Spirit"] = "上古圣马之魂"
    C["Bring 30 bottles of Raging Beast's Blood to Mor'zul Bloodbringer in the Burning Steppes."] = "把30瓶狂暴野兽的血交给燃烧平原的莫苏尔·召血者。"
    C["Rage of Blood"] = "血之狂暴"
    C["Bring the Case of Blood to Gorzeeki Wildeyes in the Burning Steppes."] = "把血箱交给燃烧平原的戈瑟奇·邪眼。"
    C["Wildeyes"] = "戈瑟奇·邪眼"
    C["Purchase Shadowy Potions from Gorzeeki in the Burning Steppes. Use the potions to travel through Jaedenar, and speak with Lord Banehollow."] = "从燃烧平原的戈瑟奇那里购买暗影药水。 使用这种药剂进入加德纳尔，然后与魔王贝恩霍勒谈一谈。"
    C["Lord Banehollow"] = "魔王贝恩霍勒"
    C["Confront Ulathek, then bring The Traitor's Heart to Lord Banehollow in Jaedenar."] = "找到并杀死乌拉泰克，然后把叛徒之心交给加德纳尔的魔王贝恩霍勒。"
    C["Ulathek the Traitor"] = "背叛者乌拉泰克"
    C["Purchase Xorothian Stardust from Ur'dan. Bring it to Gorzeeki Wildeyes in the Burning Steppes."] = "从乌尔丹那里购买克索诺斯星尘，把它交给燃烧平原的戈瑟奇·邪眼。"
    C["Xorothian Stardust"] = "克索诺斯星尘"
    C["Bring 10 Elixirs of Shadow Power to Gorzeeki Wildeyes in the Burning Steppes."] = "把10瓶暗影之力药剂交给燃烧平原的戈瑟奇·邪眼。"
    C["Bell of Dethmoora"] = "达斯莫拉之铃"
    C["Bring 6 Large Brilliant Shards and 25 Dark Iron Ore to Gorzeeki in the Burning Steppes."] = "把6份大块魔光碎片和25块黑铁矿石交给燃烧平原的戈瑟奇·邪眼。"
    C["Wheel of the Black March"] = "黑暗战车之轮"
    C["Bring 35 Black Dragonscales to Gorzeeki Wildeyes in the Burning Steppes."] = "把35块黑龙鳞片交给燃烧平原的戈瑟奇·邪眼。"
    C["Doomsday Candle"] = "末日蜡烛"
    C["Bring the Imp in a Jar to the alchemy lab in the Scholomance. After the parchment is created, return the jar to Gorzeeki Wildeyes."] = "把瓶中的小鬼带到通灵学院的炼金实验室中。在小鬼制造出羊皮纸之后，把瓶子还给戈瑟奇·邪眼。"
    C["Imp Delivery"] = "瓶中的小鬼"
    C["Bring 3 Arcanite Bars to Gorzeeki in the Burning Steppes."] = "把3块奥金锭交给燃烧平原的戈瑟奇·邪眼。"
    C["Arcanite"] = "奥金锭"
    C["Read Mor'zul's Instructions. Summon a Xorothian Dreadsteed, defeat it, then bind its spirit to you."] = "阅读莫苏尔的指南，并召唤出一匹克索诺斯恐惧战马，击败它，然后控制它的灵魂。"
    C["Dreadsteed of Xoroth"] = "克索诺斯恐惧战马"
    C["Return the book to its rightful owners."] = "将这本典籍交给它的主人。"
    C["The Emerald Dream..."] = "翡翠梦境……"
    C["The Greatest Race of Hunters"] = "最伟大的猎手"
    C["The Arcanist's Cookbook"] = "奥法师的食谱"
    C["The Light and How To Swing It"] = "圣光之力"
    C["Holy Bologna: What the Light Won't Tell You"] = "光明不会告诉你的事情"
    C["Garona: A Study on Stealth and Treachery"] = "迦罗娜：潜行与诡计研究"
    C["Frost Shock and You"] = "你与冰霜震击"
    C["Harnessing Shadows"] = "束缚之影"
    C["Codex of Defense"] = "防御宝典"
    C["The Medallion of Faith"] = "信仰奖章"
    C["Slay 20 Noxious Plaguebats and 10 Monstrous Plaguebats. Return to Nathanos Blightcaller when you are finished."] = "杀掉20只毒性瘟疫蝙蝠和10只巨型瘟疫蝙蝠，然后回到纳萨诺斯·凋零者那里。"
    C["Un-Life's Little Annoyances"] = "讨厌的蝙蝠"
    C["Travel to Corin's Crossing to the east and slaughter the Scourge that inhabit the town. Collect 7 pieces of Living Rot in under 10 minutes. Use the Mortar and Pestle to grind the Living Rot into Coagulated Rot."] = "到东边的考林路口去屠杀镇里的亡灵天灾。在10分钟内收集7块生命腐质，使用研钵和捣杵将其研磨成凝固腐质。"
    C["To Kill With Purpose"] = "杀戮的理由"
    C["The Corpulent One"] = "肥大的食腐虫"
    C["The Champion of the Banshee Queen"] = "女妖之王的勇士"
    C["Tinkee Steamboil"] = "丁奇·斯迪波尔"
    C["Return with the Blessed Arcanite Barding to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "将被祝福的奥金马铠交给暴风城教堂区的格雷森·沙东布瑞克公爵。"
    C["Blessed Arcanite Barding"] = "被祝福的奥金马铠"
    C["Bring an Azerothian Diamond and a Pristine Black Diamond to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "把一块艾泽拉斯钻石和一块原始黑钻石交给暴风城教堂区的格雷森·沙东布瑞克公爵。"
    C["The Divination Scryer"] = "预言水晶球"
    C["Use the Divination Scryer in the heart of the Great Ossuary's basement in the Scholomance. Doing so will bring forth the spirits you must judge. Defeating these spirits will summon forth Death Knight Darkreaver. Defeat him and reclaim the lost soul of the fallen charger. Give the Charger's Redeemed Soul and the Blessed Enchanted Barding to Darkreaver's Fallen Charger."] = "在通灵学院尸骨储藏所地下室的中心使用预言水晶球。将你要审判的灵魂引领出来。将这些灵魂击败然后死亡骑士达克雷尔就将被召唤出来。将其击败然后获得堕落战马的灵魂。 把赎罪的战马之魂和被祝福的奥金马铠一起附在达克雷尔的堕落战马身上。"
    C["Judgment and Redemption"] = "审判和救赎"
    C["If you are interested in helping Sagorne Crestrider in Orgrimmar's Valley of Wisdom, bring him an Azerothian Diamond and a Pristine Black Diamond."] = "如果你愿意帮助奥格瑞玛智慧谷的萨格尼，就将一块艾泽拉斯钻石和一块原始黑钻石交给他。"
    C["Material Assistance"] = "收集材料"
    C["Use the Divination Scryer in the heart of the Great Ossuary's basement in the Scholomance. Doing so will bring forth spirits you must fight. Defeating these spirits will summon forth Death Knight Darkreaver; defeat him. Bring Darkreaver's Head to Sagorne Creststrider in the Valley of Wisdom, Orgrimmar."] = "在通灵学院的尸骨储藏所地下室中心使用预言水晶球，这样将会召来一些灵魂，你必须与它们交战。将这些灵魂击败，死亡骑士达克雷尔就会出现。 击败达克雷尔，将他的头颅交给奥格瑞玛智慧谷的萨格尼。"
    C["The Darkreaver Menace"] = "达克雷尔的威胁"
end
do local C = ns.CONTENT.tw
    C["Defend Daphne Stilwell from the Defias attack."] = "在迪菲亞兄弟會進攻時保護達芙妮·斯迪威爾的安全。如果你想成功的話，你和達芙妮都不能死在他們的劍下。"
    C["The Tome of Valor"] = "勇氣之書"
    C["The Test of Righteousness"] = "正義試煉"
    C["Using Jordan's Weapon Notes, find some Whitestone Oak Lumber, Bailor's Refined Ore Shipment, Jordan's Smithing Hammer, and a Kor Gem, and return them to Jordan Stilwell in Ironforge."] = "按照喬丹的武器材料單上的說明去尋找一些白石橡木、精煉礦石、喬丹的鐵錘和一塊科爾寶石，然後回到鐵爐堡去見喬丹·斯迪威爾。"
    C["Wait for Jordan Stilwell to finish forging a weapon for you."] = "等待喬丹·斯迪威爾為你鑄造武器。"
    C["Strange Water Globe: Drops from Baron Aquanis inside Blackfathom Deeps."] = "奇怪的水球，由黑暗深淵中的阿奎尼斯男爵掉落"
    C["Bring the Strange Water Globe to Je'neu Sancrea at Zoram'gar Outpost, Ashenvale."] = "把奇怪的水球交給梣谷佐拉姆加前哨站的耶努薩克雷。"
    C["Baron Aquanis"] = "阿奎尼斯男爵"
    C["The Greenwarden"] = "綠色守衛者"
    C["Kill 15 Mosshide Gnolls and 10 Mosshide Mongrels, then return to Rethiel the Greenwarden."] = "消滅15個苔蘚皮豺狼人和10個苔蘚皮混血者，然後返回綠色守衛者雷希耶爾處。"
    C["Tramping Paws"] = "踐踏之爪"
    C["Bring Rethiel the Greenwarden 9 Crude Flints."] = "給綠色守衛者雷希耶爾帶去9塊粗糙燧石。"
    C["Fire Taboo"] = "火焰禁忌"
    C["Kill 12 Fen Creepers, then return to Rethiel the Greenwarden."] = "消滅12隻沼澤爬行者，然後返回綠色守衛者雷希耶爾處。"
    C["Blisters on The Land"] = "大地上的膿疱"
    C["Brother Anton"] = "安東修士"
    C["Bring an Infernal Orb to Tabetha in Dustwallow Marsh."] = "將一顆地獄火寶珠交給塵泥沼澤的塔貝薩。"
    C["The Infernal Orb"] = "地獄火寶珠"
    C["Kill the Demon of the Orb, then speak with Tabetha."] = "殺死寶珠之魔，然後與塔貝薩談一談。"
    C["The Exorcism"] = "驅除魔鬼"
    C["Retrieve an Obsidian Power Source and bring it to Tabetha in Dustwallow Marsh."] = "找到一個黑曜石能量源，將其交給塵泥沼澤的塔貝薩。"
    C["Power in Uldaman"] = "奧達曼的能量源"
    C["The Brassbolts Brothers"] = "銅栓兄弟"
    C["Tabetha's Task"] = "塔貝薩的任務"
    C["Collect 15 Bloodpetals and return to Muigin."] = "從安戈洛爾環形山的血瓣花猛擊者和血瓣花掠奪者身上收集15個血瓣花，然後向穆爾金回覆。"
    C["Muigin and Larion"] = "穆爾金和拉瑞安"
    C["A Visit to Gregan"] = "造訪格雷甘"
    C["Collect 5 samples of Atal'ai Haze, then return to Muigin in Un'Goro Crater."] = "收集5份阿塔萊之霧的樣本，然後向安戈洛環形山的穆爾金覆命。"
    C["Haze of Evil"] = "邪惡之霧"
    C["Torwa Pathfinder"] = "托爾瓦·尋路者"
    C["Collect 8 Bloodcap and 8 Gorishi Stings, and return to Torwa Pathfinder in Un'Goro Crater."] = "收集一些血帽和格里什釘刺，然後向托爾瓦·尋路者覆命。"
    C["Bloodpetal Poison"] = "血瓣毒藥"
    C["Stab a Devilsaur with the Devilsaur Barb. Return to Torwa Pathfinder in Un'Goro Crater when you have completed this task."] = "將魔暴龍之刺扎入一隻魔暴龍的體內。"
    C["Toxic Test"] = "毒性測試"
    C["Retrieve a Putrid Vine from the guardian at the bottom of the Sunken Temple and return to Torwa Pathfinder."] = "從沉沒的神廟底部的守衛身上得到一些腐爛藤蔓，把它們交給托爾瓦·尋路者。"
    C["A Better Ingredient"] = "更好的材料"
    C["The Hunter's Charm"] = "獵人的護符"
    C["Bring a pair of Perfect Courser Antlers to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast of the Ruins of Eldarath."] = "將一副完好的苔蹄快步者鹿角交給艾薩拉的奧汀克。奧汀克居住在埃達拉斯廢墟東北部的懸崖頂。"
    C["Courser Antlers"] = "苔蹄快步者的鹿角"
    C["Bring 6 Wavethrasher Scales to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "將6塊碎浪多頭怪的鱗片交給艾薩拉的奧汀克。奧汀克居住在埃達拉斯廢墟東北部的懸崖頂部。"
    C["Wavethrashing"] = "碎浪多頭怪"
    C["Bring the Tooth of Morphaz to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "將摩弗拉斯的牙齒交給艾薩拉的奧汀克。他住在埃達拉斯廢墟東北部懸崖的頂端。"
    C["The Green Drake"] = "神廟中的綠龍"
    C["Magecraft"] = "法師的會見"
    C["Bring 10 Glittering Dust to Archmage Xylem."] = "為大法師克希雷姆收集10份閃光塵埃。"
    C["Magic Dust"] = "魔法的塵埃"
    C["Collect 6 Enchanted Coral and return them to Archmage Xylem."] = "收集6塊魔化珊瑚，然後把它們交給大法師克希雷姆。"
    C["The Siren's Coral"] = "納迦的珊瑚"
    C["Retrieve the Arcane Shard from Morphaz and return to Archmage Xylem."] = "從摩弗拉斯身上取回奧術碎片，然後返回大法師克希雷姆那兒。"
    C["Destroy Morphaz"] = "毀滅摩弗拉斯"
    C["Chillwind Point"] = "冰風崗"
    C["Collect 20 Minion's Scourgestones and bring them to High Priest Thel'danis in the Western Plaguelands."] = "收集20個爪牙的天災石，並將它們交給西瘟疫之地的高階牧師賽爾丹尼斯。"
    C["Dispelling Evil"] = "驅散邪惡"
    C["Bring the Inert Scourgestone to Commander Ashlan Valorfist in Chillwind Point."] = "將惰性天災石交給冰風崗的指揮官阿什拉姆·瓦羅菲斯特。"
    C["Inert Scourgestones"] = "惰性天災石"
    C["Bring the voodoo feathers to Ashlam Valorfist."] = "前往沉沒的神廟，從巨魔守護者們身上取得巫毒羽毛，然後把它們交給阿什拉姆·瓦羅菲斯特。"
    C["Forging the Mightstone"] = "鑄造力量之石"
    C["Cenarion Aid"] = "塞納里奧議會的求助"
    C["Acquire 4 Healthy Courser Glands and bring them to Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "收集4份健康的野鹿腺體，把它們交給艾薩拉的奧汀克。奧汀克住在埃達拉斯廢墟東北部懸崖的頂部。"
    C["Of Coursers We Know"] = "苔蹄快步者"
    C["Acquire an Ichor of Undeath for Ogtinc in Azshara. Ogtinc resides atop the cliffs northeast the Ruins of Eldarath."] = "為艾薩拉的奧汀克帶回一份亡靈腐液。奧汀克住在埃達拉斯廢墟東北部懸崖的頂端。"
    C["The Ichor of Undeath"] = "亡靈的腐液"
    C["Kill Morphaz in the sunken temple of Atal'Hakkar, and return his blood to Greta Mosshoof in Felwood. The entrance to the sunken temple can be found in the Swamp of Sorrows."] = "前往沉沒的阿塔哈卡神廟，殺死綠龍摩弗拉斯，將他的血液交給費伍德森林中的格雷塔·苔蹄。沉沒的神廟的入口就在悲傷沼澤中。"
    C["Blood of Morphaz"] = "摩弗拉斯之血"
    C["A Simple Request"] = "簡單的要求"
    C["Retrieve the Sealed Azure Bag from the Timbermaw Shaman in Azshara. Then take the bag to Archmage Xylem, also found in Azshara."] = "從艾薩拉的木喉薩滿祭司那兒取回密封的藍袋子，將它交給艾薩拉的大法師克希雷姆。"
    C["Sealed Azure Bag"] = "密封的藍袋子"
    C["Bring 10 Encoded Fragments to Archmage Xylem in Azshara."] = "將10塊密文碎片交給艾薩拉的大法師克希雷姆。"
    C["Encoded Fragments"] = "密文碎片"
    C["Return the Azure Key to Lord Jorach Ravenholdt."] = "將碧藍鑰匙交給喬拉齊·拉文霍德公爵。"
    C["The Azure Key"] = "碧藍鑰匙"
    C["Collect a sample of air, fire, earth and water for Bath'rah the Windwatcher."] = "為捕風者巴斯拉收集一份空氣樣本、一份火元素樣本、一份土元素樣本和一份水元素樣本。"
    C["Elemental Mastery"] = "元素掌握"
    C["Bring the pieces for the spirit totem to Bath'rah the Windwatcher."] = "將靈魂圖騰所需的材料交給捕風者巴斯拉。"
    C["Spirit Totem"] = "靈魂圖騰"
    C["Bring the voodoo feathers to Bath'rah the Windwatcher."] = "將巫毒羽毛交給捕風者巴斯拉。"
    C["Da Voodoo"] = "巫毒羽毛"
    C["Bring a piece of felcloth to Impsy in Felwood."] = "將一塊惡魔布交給費伍德森林的伊普斯。"
    C["An Imp's Request"] = "小鬼的要求"
    C["Hot and Itchy"] = "灼熱的疼痛"
    C["Bring 10 Rotting Wood and 4 Bloodvenom Essence to Impsy in Felwood."] = "將10塊腐爛的木頭和4個血毒精華交給費伍德森林的伊普斯。"
    C["The Wrong Stuff"] = "奇怪的材料"
    C["Bring a total of 6 Voodoo Feathers from the trolls in sunken temple."] = "到沉沒的神廟去，從巨魔們身上獲得6支巫毒羽毛。"
    C["Trolls of a Feather"] = "巨魔的羽毛"
    C["A Troubled Spirit"] = "困擾的靈魂"
    C["Kill 7 Helboar in the Blasted Lands and return to the Fallen Hero of the Horde."] = "殺死7頭地獄野豬，然後回到部落英雄的靈魂那兒。"
    C["Warrior Kinship"] = "戰士的血脈"
    C["Slaughter the Shadowsworn in the Blasted Lands and return to the Fallen Hero of the Horde."] = "殺死詛咒之地的魔誓者，然後回到部落英雄的靈魂那兒。"
    C["War on the Shadowsworn"] = "魔誓者之戰"
    C["Bring the Voodoo Feathers from the trolls in the Sunken Temple to the Fallen Hero of the Horde."] = "將你從沉沒的神廟的巨魔身上得到的巫毒羽毛交給部落英雄的靈魂。"
    C["Voodoo Feathers"] = "巫毒羽毛"
    C["Defend Gor'shak."] = "保護哥沙克。"
    C["What Is Going On?"] = "出了什麼事？"
    C["Rocknot's Ale"] = "羅克諾特的麥酒"
    C["Travel to Silithus and search for a Reliquary of Purity within the ruins of Southwind Village. If you are able to find it, return with it to Rabine Saturna in Nighthaven, Moonglade."] = "到希利蘇斯的南風村去尋找淨化之匣。然後將其交給月光林地永夜港的拉比恩·薩圖納。"
    C["A Reliquary of Purity"] = "淨化之匣"
    C["Shards of the Felvine"] = "魔藤碎片"
    C["Travel to the Warpwood Quarter of Dire Maul and slay the water elemental, Hydrospawn. Return to Lorekeeper Lydros in the Athenaeum with the Hydrospawn Essence."] = "到厄運之槌的扭木廣場去殺掉水元素海多斯博恩。把海多斯博恩精華交給圖書館的博學者萊德羅斯。"
    C["Arcane Refreshment"] = "久違的法師"
    C["Starfall"] = "墜星村"
    C["The Ruins of Kel'Theril"] = "凱斯利爾廢墟"
    C["Use Jaron's Pick to find the four Highborne Relic Fragments. Bring them to Aurora Skycaller in Eastern Plaguelands."] = "使用加隆的鎬來尋找四塊上層精靈遺物的碎片，把它們交給東瘟疫之地的奧蘿拉。"
    C["Troubled Spirits of Kel'Theril"] = "凱斯利爾的怨靈"
    C["Fragments of the Past"] = "歷史的殘片"
    C["Bring an Enchanted Thorium Bar, 5 Crystal Restore, and a Vial of Dire Water to Aurora Skycaller near the Northpass Tower in Eastern Plaguelands."] = "給東瘟疫之地的奧蘿拉帶去一塊魔化瑟銀錠、5塊恢復水晶，以及一小瓶恐怖之水。"
    C["Travel to Ironforge and get High Priest Rohan's Exorcism Censer. You will need to make a donation of 150 gold in order to secure it."] = "到鐵爐堡去找高階牧師洛漢，從他那裡拿到驅魔香爐。你需要捐贈150金幣來獲得它。"
    C["Emphasis on Sacrifice"] = "犧牲精神"
    C["Return the Exorcism Censer to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "把驅魔香爐交給暴風城教堂區的格雷森·沙東布瑞克公爵。"
    C["To Show Due Judgment"] = "聖騎士的審判"
    C["Use the Exorcism Censer to drive out the spirits that torment Terrordale. When you have slain 25 Terrordale Spirits, return to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "使用驅魔香爐召喚恐懼谷中的靈魂。當你殺掉25個恐懼谷的靈魂之後，回到暴風城教堂區的格雷森·沙東布瑞克公爵那裡覆命。"
    C["Exorcising Terrordale"] = "恐懼谷的靈魂"
    C["The Work of Grimand Elmore"] = "格瑞曼德·艾爾默"
    C["Bring 40 Runecloth, 6 Arcanite Bars, 10 Arthas' Tears, 5 Stratholme Holy Water vials, and 150 gold to Grimand Elmore in the Dwarven District of Stormwind."] = "把40塊符文布、6塊奧金錠、10棵阿爾薩斯之淚、5瓶斯坦索姆聖水和150枚金幣交給暴風城矮人區的格瑞曼德·艾爾默。"
    C["Collection of Goods"] = "收集材料"
    C["Grimand's Finest Work"] = "艾爾默的手藝"
    C["Retrieve 20 Enriched Manna Biscuits - the key ingredient in making Manna-Enriched Horse Feed - for Merideth Carlson at Southshore in the Hillsbrad Foothills. The Argent Dawn is known as the sole purveyor of the biscuits. You also need to give her 50 gold to soothe her ruffled sensibilities."] = "把製作魔法糧草所需要的重要材料：20塊可口的魔法點心帶給希爾斯布萊德丘陵的梅麗德絲·卡爾森。據說銀色黎明會出售這種餅乾。 你還需要給她50金幣來對她進行安撫。"
    C["Manna-Enriched Horse Feed"] = "魔法糧草"
    C["Acquire special horse feed used for feeding a spirit horse. Merideth Carlson in Southshore apparently is the source for such food. Travel to the Dire Maul dungeon in Feralas and slay Tendris Warpwood. Doing so will free the Ancient Equine Spirit. Feed it the special horse feed, thereby soothing the spirit. Finally, give it the Arcanite Barding so it may bless it."] = "你需要特殊的飼料來餵養靈魂馬。南海鎮的梅麗德絲·卡爾森可以為你提供這樣的糧草。 到菲拉斯的厄運之槌去，殺掉特迪斯·扭木，釋放上古聖馬之魂。用特殊的糧草餵養它，這樣可以安撫它的靈魂。最後，把奧金馬鎧交給它就可以完成祝福。"
    C["Ancient Equine Spirit"] = "上古聖馬之魂"
    C["Bring 30 bottles of Raging Beast's Blood to Mor'zul Bloodbringer in the Burning Steppes."] = "把30瓶狂暴野獸的血交給燃燒平原的莫蘇爾·召血者。"
    C["Rage of Blood"] = "血之狂暴"
    C["Bring the Case of Blood to Gorzeeki Wildeyes in the Burning Steppes."] = "把血箱交給燃燒平原的戈瑟奇·邪眼。"
    C["Wildeyes"] = "戈瑟奇·邪眼"
    C["Purchase Shadowy Potions from Gorzeeki in the Burning Steppes. Use the potions to travel through Jaedenar, and speak with Lord Banehollow."] = "從燃燒平原的戈瑟奇那裡購買暗影藥水。 使用這種藥劑進入加德納爾，然後與魔王貝恩霍勒談一談。"
    C["Lord Banehollow"] = "魔王貝恩霍勒"
    C["Confront Ulathek, then bring The Traitor's Heart to Lord Banehollow in Jaedenar."] = "找到並殺死烏拉泰克，然後把叛徒之心交給加德納爾的魔王貝恩霍勒。"
    C["Ulathek the Traitor"] = "背叛者烏拉泰克"
    C["Purchase Xorothian Stardust from Ur'dan. Bring it to Gorzeeki Wildeyes in the Burning Steppes."] = "從烏爾丹那裡購買克索諾斯星塵，把它交給燃燒平原的戈瑟奇·邪眼。"
    C["Xorothian Stardust"] = "克索諾斯星塵"
    C["Bring 10 Elixirs of Shadow Power to Gorzeeki Wildeyes in the Burning Steppes."] = "把10瓶暗影之力藥劑交給燃燒平原的戈瑟奇·邪眼。"
    C["Bell of Dethmoora"] = "達斯莫拉之鈴"
    C["Bring 6 Large Brilliant Shards and 25 Dark Iron Ore to Gorzeeki in the Burning Steppes."] = "把6份大塊魔光碎片和25塊黑鐵礦石交給燃燒平原的戈瑟奇·邪眼。"
    C["Wheel of the Black March"] = "黑暗戰車之輪"
    C["Bring 35 Black Dragonscales to Gorzeeki Wildeyes in the Burning Steppes."] = "把35塊黑龍鱗片交給燃燒平原的戈瑟奇·邪眼。"
    C["Doomsday Candle"] = "末日蠟燭"
    C["Bring the Imp in a Jar to the alchemy lab in the Scholomance. After the parchment is created, return the jar to Gorzeeki Wildeyes."] = "把瓶中的小鬼帶到通靈學院的鍊金實驗室中。在小鬼製造出羊皮紙之後，把瓶子還給戈瑟奇·邪眼。"
    C["Imp Delivery"] = "瓶中的小鬼"
    C["Bring 3 Arcanite Bars to Gorzeeki in the Burning Steppes."] = "把3塊奧金錠交給燃燒平原的戈瑟奇·邪眼。"
    C["Arcanite"] = "奧金錠"
    C["Read Mor'zul's Instructions. Summon a Xorothian Dreadsteed, defeat it, then bind its spirit to you."] = "閱讀莫蘇爾的指南，並召喚出一匹克索諾斯恐懼戰馬，擊敗它，然後控制它的靈魂。"
    C["Dreadsteed of Xoroth"] = "克索諾斯恐懼戰馬"
    C["Return the book to its rightful owners."] = "將這本典籍交給它的主人。"
    C["The Emerald Dream..."] = "翡翠夢境……"
    C["The Greatest Race of Hunters"] = "最偉大的獵手"
    C["The Arcanist's Cookbook"] = "奧法師的食譜"
    C["The Light and How To Swing It"] = "聖光之力"
    C["Holy Bologna: What the Light Won't Tell You"] = "光明不會告訴你的事情"
    C["Garona: A Study on Stealth and Treachery"] = "迦羅娜：潛行與詭計研究"
    C["Frost Shock and You"] = "你與冰霜震擊"
    C["Harnessing Shadows"] = "束縛之影"
    C["Codex of Defense"] = "防禦寶典"
    C["The Medallion of Faith"] = "信仰獎章"
    C["Slay 20 Noxious Plaguebats and 10 Monstrous Plaguebats. Return to Nathanos Blightcaller when you are finished."] = "殺掉20只毒性瘟疫蝙蝠和10只巨型瘟疫蝙蝠，然後回到納薩諾斯·凋零者那裡。"
    C["Un-Life's Little Annoyances"] = "討厭的蝙蝠"
    C["Travel to Corin's Crossing to the east and slaughter the Scourge that inhabit the town. Collect 7 pieces of Living Rot in under 10 minutes. Use the Mortar and Pestle to grind the Living Rot into Coagulated Rot."] = "到東邊的考林路口去屠殺鎮裡的亡靈天災。在10分鐘內收集7塊生命腐質，使用研缽和搗杵將其研磨成凝固腐質。"
    C["To Kill With Purpose"] = "殺戮的理由"
    C["The Corpulent One"] = "肥大的食腐蟲"
    C["The Champion of the Banshee Queen"] = "女妖之王的勇士"
    C["Tinkee Steamboil"] = "丁奇·斯迪波爾"
    C["Return with the Blessed Arcanite Barding to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "將被祝福的奧金馬鎧交給暴風城教堂區的格雷森·沙東布瑞克公爵。"
    C["Blessed Arcanite Barding"] = "被祝福的奧金馬鎧"
    C["Bring an Azerothian Diamond and a Pristine Black Diamond to Lord Grayson Shadowbreaker in the Cathedral District of Stormwind."] = "把一塊艾澤拉斯鑽石和一塊原始黑鑽石交給暴風城教堂區的格雷森·沙東布瑞克公爵。"
    C["The Divination Scryer"] = "預言水晶球"
    C["Use the Divination Scryer in the heart of the Great Ossuary's basement in the Scholomance. Doing so will bring forth the spirits you must judge. Defeating these spirits will summon forth Death Knight Darkreaver. Defeat him and reclaim the lost soul of the fallen charger. Give the Charger's Redeemed Soul and the Blessed Enchanted Barding to Darkreaver's Fallen Charger."] = "在通靈學院屍骨儲藏所地下室的中心使用預言水晶球。將你要審判的靈魂引領出來。將這些靈魂擊敗然後死亡騎士達克雷爾就將被召喚出來。將其擊敗然後獲得墮落戰馬的靈魂。 把贖罪的戰馬之魂和被祝福的奧金馬鎧一起附在達克雷爾的墮落戰馬身上。"
    C["Judgment and Redemption"] = "審判和救贖"
    C["If you are interested in helping Sagorne Crestrider in Orgrimmar's Valley of Wisdom, bring him an Azerothian Diamond and a Pristine Black Diamond."] = "如果你願意幫助奧格瑞瑪智慧谷的薩格尼，就將一塊艾澤拉斯鑽石和一塊原始黑鑽石交給他。"
    C["Material Assistance"] = "收集材料"
    C["Use the Divination Scryer in the heart of the Great Ossuary's basement in the Scholomance. Doing so will bring forth spirits you must fight. Defeating these spirits will summon forth Death Knight Darkreaver; defeat him. Bring Darkreaver's Head to Sagorne Creststrider in the Valley of Wisdom, Orgrimmar."] = "在通靈學院的屍骨儲藏所地下室中心使用預言水晶球，這樣將會召來一些靈魂，你必須與它們交戰。將這些靈魂擊敗，死亡騎士達克雷爾就會出現。 擊敗達克雷爾，將他的頭顱交給奧格瑞瑪智慧谷的薩格尼。"
    C["The Darkreaver Menace"] = "達克雷爾的威脅"
end
