local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- City of Dalaran (28-33) - WoW Forever
-- New Forever dungeon (opened on the beta 2026-10-09, not in Questie).
-- Data from ForeverDungeonJournal 1.6.3 (coordinates, NPC IDs), wowforeverguides.com, zockify.com, foreverchanges.pro and
-- wowclassicforever.info (beta / datamine data, may change).
-- NPC IDs checked against the Questie classic DB (Questie replaces the
-- coordinates with its spawns: a wrong ID moves the NPC). Shylamiir and
-- Andromath keep id 0: Forever redrew Stormwind, Questie's spawns are old.
-- ===================================================================
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end
-- Dalaran Summoners / Elemental Slaves (Dalaran Patrols, Bracers of Binding):
-- two camps outside the city, Alterac Mountains
local SUMMONERS = { { map = 1416, x = 20.8, y = 57.6 }, { map = 1416, x = 16.0, y = 76.4 } }
local function HO(extra) local t = extra or {}; t.faction = "Horde"; return t end

-- NPCs (map = uiMapID: 1424 Hillsbrad, 1416 Alterac, 1453 Stormwind,
-- 1458 Undercity)
N.wordeen   = { id = 2410, name = "Magus Wordeen Voidglare", map = 1424, x = 61.5, y = 20.7 } -- Tarren Mill, south-east building
N.belvaril  = { id = 2437, name = "Keeper Bel'varil",        map = 1424, x = 61.5, y = 20.7 } -- next to Wordeen
N.melisara  = { id = 2278,    name = "Melisara",                map = 1424, x = 62.6, y = 20.6 } -- Tarren Mill
N.felben    = { id = 11044,    name = "Doctor Martin Felben",    map = 1458, x = 46.6, y = 74.1 }
N.rexxie    = { id = 0,    name = "Rexxie Copperclutch" }    -- inside the dungeon, near the sewer entrance
N.jacques   = { id = 0,    name = "Emissary Jacques",        map = 1424, x = 48.4, y = 60.2 } -- Southshore (approximate)
N.shylamiir = { id = 0,    name = "Shylamiir",               map = 1453, x = 31.4, y = 62.8 } -- The Park
N.andromath = { id = 0,    name = "High Sorcerer Andromath", map = 1453, x = 48.8, y = 87.6 } -- Wizard's Sanctum
N.imodera   = { id = 269127, name = "Image of Archmage Modera", map = 1416, x = 9.2, y = 60.0 } -- Lordamere Lake shore
N.footlocker = { id = 0,   name = "Warden's Footlocker" }

N.ricter    = { id = 0, name = "Ricter",          enemy = true }
N.alina     = { id = 0, name = "Alina",           enemy = true }
N.dermot    = { id = 0, name = "Dermot",          enemy = true }
N.kegan     = { id = 0, name = "Kegan Darkmar",   enemy = true }
N.dsummoner = { id = 0, name = "Dalaran Summoner", enemy = true }
N.eslave    = { id = 0, name = "Elemental Slave", enemy = true }
N.atrexis   = { id = 247126, name = "Atrexis the Grave Knight", enemy = true, boss = true }
N.enigma    = { id = 246016, name = "Arcanic Enigma",  enemy = true, boss = true }
N.lyn       = { id = 247032, name = "Lyn the Ignored", enemy = true, boss = true }
N.shade     = { id = 246020, name = "Shade of the Archmage", enemy = true, boss = true }
N.sentinel  = { id = 246017, name = "Unstable Sentinel", enemy = true, boss = true }
N.seeking   = { id = 0, name = "Seeking Remnant",  enemy = true }
N.saturated = { id = 0, name = "Saturated Remnant", enemy = true }
N.echo      = { id = 0, name = "Mana Echo",        enemy = true }

ns:RegisterDungeon("DALARAN", function() return {
    name = L("Cité de Dalaran", "City of Dalaran"),
    levels = "28-33",
    new = true, -- new in Forever
    icon = "Interface\\Icons\\Spell_Arcane_PortalDalaran",
    entrance = { map = 1416, x = 8.5, y = 59.3 }, -- city sewers, Underbelly pipe to the portal
    titles = {
        [92456] = L("Un échantillon vert", "A Green Sample"),
        [92489] = L("Puissance écrasante", "Power Overwhelming"),
        [92457] = L("Arcanes affamés", "Starving Arcane"),
        [92432] = L("Une requête alarmante", "An Alarming Request"),
        [92458] = L("Cœur de la perturbation", "Heart of Disruption"),
        [96984] = L("Cœur de la perturbation", "Heart of Disruption"),
        [96986] = L("Le chevalier des tombes", "The Grave Knight"),
        [96988] = L("Source de puissance", "Source of Power"),
        [96987] = L("Éducation opportuniste", "Opportunistic Education"),
        [544]   = L("Évasion à l'envers", "Prison Break In"),
        [93680] = L("La clé de la ville", "Key to the City"),
        [556]   = L("Jetons de pierre", "Stone Tokens"),
        [545]   = L("Patrouilles de Dalaran", "Dalaran Patrols"),
        [557]   = L("Les brassards de lien", "Bracers of Binding"),
        [92434] = L("Du sang dans les rues", "Blood in the Streets"),
    },
    steps = {
        -- Before the dungeon (Alliance)
        A(92456, "shylamiir", AL()),
        A(92489, "andromath", AL()),
        A(92432, "jacques", AL({ text = L("Émissaire Jacques à Austrivage", "Emissary Jacques in Southshore") })),
        T(92432, "imodera", AL({ text = L("Image de l'Archimage Modera, devant la ville", "Image of Archmage Modera, outside the city") })),
        A(92458, "imodera", AL({ text = L("Niveau 30 requis. Donne la clé des égouts de Dalaran", "Requires level 30. Gives the Dalaran Sewer Key") })),
        A(92457, "imodera", AL({ text = L("Facultatif : il n'y a pas toujours assez de monstres pour la finir en une fois", "Optional: there may not be enough mobs to finish it in one run") })),
        -- Before the dungeon (Horde): Tarren Mill sewer key chain
        A(96986, "melisara", HO()),
        A(96988, "felben", HO({ text = L("Docteur Martin Felben, Fossoyeuse", "Doctor Martin Felben, Undercity") })),
        A(544, "wordeen", HO({ text = L("Lier la pierre de foyer à Moulin-de-Tarren d'abord", "Set your hearthstone in Tarren Mill first") })),
        A(93680, "wordeen", HO()),
        A(556, "belvaril", HO({ text = L("Facultatif pour la clé", "Optional for the key") })),
        D(544, L("Camp d'internement de Lordamere : tuer Ricter, Alina, Dermot et Kegan Darkmar (à l'étage)", "Lordamere Internment Camp: kill Ricter, Alina, Dermot and Kegan Darkmar (upstairs)"),
            HO({ map = 1416, x = 19.5, y = 89.9, targets = { "ricter", "alina", "dermot", "kegan" } })),
        D(93680, L("Grimy Key : coffre du gardien, à l'étage près de Kegan", "Grimy Key: Warden's Footlocker, upstairs near Kegan"), HO({ map = 1416, x = 19.5, y = 89.9 })),
        D(556, L("10 jetons de pierre usés (camp d'internement de Lordamere)", "10 Worn Stone Tokens (Lordamere Internment Camp)"), HO({ map = 1416, x = 19.5, y = 89.9 })),
        T(544, "wordeen", HO()),
        T(93680, "wordeen", HO()),
        T(556, "belvaril", HO()),
        A(545, "wordeen", HO()),
        A(557, "belvaril", HO({ text = L("Facultatif pour la clé", "Optional for the key") })),
        D(545, L("Autour de Dalaran : 6 invocateurs et 8 esclaves élémentaires (interrompre les invocateurs)", "Around Dalaran: 6 Dalaran Summoners and 8 Elemental Slaves (interrupt the summoners)"),
            HO({ spots = SUMMONERS, targets = { "dsummoner", "eslave" } })),
        D(557, L("4 brassards de lien terrestre", "4 Bracers of Earth Binding"), HO({ spots = SUMMONERS })),
        T(545, "wordeen", HO()),
        T(557, "belvaril", HO()),
        A(92434, "wordeen", HO()),
        T(92434, "imodera", HO({ text = L("Image de Modera : longer la rive du lac Lordamere", "Image of Modera: follow the Lordamere Lake shore") })),
        A(96984, "imodera", HO({ text = L("Niveau 30 requis. Donne la clé des égouts de Dalaran (une seule par groupe suffit)", "Requires level 30. Gives the Dalaran Sewer Key (one per group is enough)") })),
        -- Optional: Tome of Dalaran, summons the rare boss Lyn the Ignored
        -- (Warcraft Tavern). Black Tome (276561) in Shadowfang Keep, made into
        -- the Tome of Dalaran (275989) at the Ambermill Leyline Focus.
        D(0, L("Donjon d'Ombrecroc : tuer Arugal, puis monter l'escalier au fond de sa salle. Le Tome noir est sur la table couverte d'ingrédients d'alchimie",
                "Shadowfang Keep: kill Arugal, then climb the stairs at the back of his room. The Black Tome is on the table covered with alchemy ingredients"),
            { title = L("Tome de Dalaran (facultatif) : le Tome noir", "Tome of Dalaran (optional): the Black Tome"),
              haveItems = { 276561, 275989 }, map = 1421, x = 44.8, y = 67.8 }),
        D(0, L("Ambermill (Forêt des Pins-Argentés), mairie au fond du village : utiliser le Tome noir sur le Focus de ligne tellurique (cristal bleu, près de l'archimage Ataeric)",
                "Ambermill (Silverpine Forest), town hall at the back: use the Black Tome on the Ambermill Leyline Focus (blue crystal, next to Archmage Ataeric)"),
            { title = L("Tome de Dalaran (facultatif) : créer le tome", "Tome of Dalaran (optional): create the tome"),
              haveItems = { 275989 }, item = 276561, map = 1421, x = 63.4, y = 64.3 }),
        -- Inside the dungeon
        A(96987, "rexxie", HO({ text = L("Rexxie Copperclutch : tourner à droite juste après l'entrée du donjon", "Rexxie Copperclutch: turn right just after entering the dungeon") })),
        D(96986, L("Tuer Atrexis le chevalier des tombes (The Underbelly)", "Kill Atrexis the Grave Knight (The Underbelly)"), HO({ targets = { "atrexis" } })),
        D(92457, L("8 Seeking Remnant, 8 Saturated Remnant et 8 Mana Echo", "8 Seeking Remnants, 8 Saturated Remnants and 8 Mana Echoes"),
            AL({ targets = { "seeking", "saturated", "echo" } })),
        D(92456, L("Fel Infused Blossom : bulbes verts de la place Runeweaver. Magus Fansy Goodbringer, à l'est de la place, abaisse le bouclier", "Fel Infused Blossom: green bulbs in Runeweaver Square. Magus Fansy Goodbringer, on the east side, lowers the shield"), AL()),
        D(96988, L("6 noyaux de sentinelle fêlés : certains golems sont déjà détruits, il suffit de les cliquer. Souvent pas assez en une seule fois", "6 Cracked Sentry Cores: some golems are already destroyed and only need a click. Often not enough in one run"), HO()),
        D(96987, L("Livre « The Founding of Dalaran » : Silver Enclave puis Atrium of Fortune, tuer les Angry Tome. Il dépasse des étagères au fond", "Book: The Founding of Dalaran: Silver Enclave then Atrium of Fortune, kill the Angry Tomes. It sticks out of the shelves at the far end"), HO()),
        D(0, L("Après Atrexis, avant la rampe à droite vers Arcane Anomaly : continuer tout droit et nettoyer la petite salle. Utiliser le Tome de Dalaran sur le cercle d'invocation au sol",
                "After Atrexis, before the ramp on the right to Arcane Anomaly: go straight on and clear the small room. Use the Tome of Dalaran on the summoning circle on the floor"),
            { title = L("Tome de Dalaran (facultatif) : invoquer Lyn the Ignored", "Tome of Dalaran (optional): summon Lyn the Ignored"),
              item = 275989, targets = { "lyn" } }),
        D(92489, L("Tuer Arcanic Enigma (rare, élémentaire de mana) : patrouille au nord-est, près du Path of Renewal", "Kill Arcanic Enigma (rare, Mana Elemental): patrols the north-east, near the Path of Renewal"), AL({ targets = { "enigma" } })),
        D(92458, L("Arcane Mote : sur l'Ombre de l'archimage (dernier boss). Parler à Modera sur les marches de la Citadelle pourpre : elle ouvre un portail vers sa salle", "Arcane Mote: from the Shade of the Archmage (last boss). Talk to Modera on the steps of the Violet Citadel: she opens a portal to its chamber"), AL({ targets = { "shade" } })),
        D(96984, L("Arcane Mote : sur l'Ombre de l'archimage (dernier boss). Parler à Modera sur les marches de la Citadelle pourpre : elle ouvre un portail vers sa salle", "Arcane Mote: from the Shade of the Archmage (last boss). Talk to Modera on the steps of the Violet Citadel: she opens a portal to its chamber"), HO({ targets = { "shade" } })),
        -- Turn-ins
        T(92458, "imodera", AL()),
        T(92457, "imodera", AL()),
        T(92456, "shylamiir", AL()),
        T(92489, "andromath", AL()),
        T(96987, "rexxie", HO()),
        T(96984, "wordeen", HO()),
        T(96986, "melisara", HO()),
        T(96988, "felben", HO()),
    },
} end)
