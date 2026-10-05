local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Blackfathom Deeps (Ashenvale) - Horde & Alliance
-- Quest IDs / NPCs / drops verified against the Questie classic DB.
-- ===================================================================
local function H(extra) local t = extra or {}; t.faction = "Horde"; return t end
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end

-- NPCs (map = uiMapID: 1440 Ashenvale, 1442 Stonetalon, 1456 Thunder Bluff,
-- 1455 Ironforge, 1457 Darnassus, 1453 Stormwind, 1439 Darkshore)
N.gerrig    = { id = 2786,  name = "Gerrig Bonegrip",        map = 1455, x = 50.8, y = 5.6 }
N.shaedlass = { id = 4786,  name = "Dawnwatcher Shaedlass",  map = 1457, x = 55.4, y = 25.0 }
N.manados   = { id = 4784,  name = "Argent Guard Manados",   map = 1457, x = 55.2, y = 24.0 }
N.selgorm   = { id = 4783,  name = "Dawnwatcher Selgorm",    map = 1457, x = 56.2, y = 24.4 }
N.argos     = { id = 4984,  name = "Argos Nightwhisper",     map = 1453, x = 21.4, y = 55.8 }
N.gershala  = { id = 8997,  name = "Gershala Nightwhisper",  map = 1439, x = 38.3, y = 43.0 }
N.tsunaman  = { id = 11862, name = "Tsunaman",               map = 1442, x = 47.4, y = 64.3 }
N.jeneu     = { id = 12736, name = "Je'neu Sancrea",         map = 1440, x = 11.6, y = 34.3 }
N.bashana   = { id = 9087,  name = "Bashana Runetotem",      map = 1456, x = 71.1, y = 34.2 }
N.thaelrid  = { id = 4787,  name = "Argent Guard Thaelrid" } -- inside the instance

N.kelris     = { id = 4832,  name = "Twilight Lord Kelris",    enemy = true, boss = true }
N.lorgus     = { id = 12902, name = "Lorgus Jett",             enemy = true, boss = true }
N.aquanis    = { id = 12876, name = "Baron Aquanis",           enemy = true, boss = true }
N.tidepriestess = { id = 4802, name = "Blackfathom Tide Priestess", enemy = true }
N.tacolyte   = { id = 4809,  name = "Twilight Acolyte",        enemy = true }
N.treaver    = { id = 4810,  name = "Twilight Reaver",         enemy = true }
N.taquamancer = { id = 4811, name = "Twilight Aquamancer",     enemy = true }
N.tloreseeker = { id = 4812, name = "Twilight Loreseeker",     enemy = true }
N.fsatyr     = { id = 4788,  name = "Fallenroot Satyr",        enemy = true }
N.frogue     = { id = 4789,  name = "Fallenroot Rogue",        enemy = true }
N.fstalker   = { id = 4798,  name = "Fallenroot Shadowstalker", enemy = true }
N.fhellcaller = { id = 4799, name = "Fallenroot Hellcaller",   enemy = true }

ns:RegisterDungeon("BFD", function() return {
    name = L("Profondeurs de Brassenoire", "Blackfathom Deeps"),
    levels = "24-32",
    icon = "Interface\\Icons\\Spell_Shadow_SummonVoidWalker",
    entrance = { map = 1440, x = 14.5, y = 14.2 }, -- Zoram Strand
    titles = {
        [971] = L("La connaissance des profondeurs", "Knowledge in the Deeps"),
        [1198] = L("À la recherche de Thaelrid", "In Search of Thaelrid"),
        [1199] = L("Le crépuscule descend", "Twilight Falls"),
        [1200] = L("L'infamie de Brassenoire", "Blackfathom Villainy"),
        [6561] = L("L'infamie de Brassenoire", "Blackfathom Villainy"),
        [3765] = L("La dépravation au loin", "The Corruption Abroad"),
        [1275] = L("Recherches sur la corruption", "Researching the Corruption"),
        [6562] = L("Problèmes dans les profondeurs", "Trouble in the Deeps"),
        [6563] = L("L'Essence d'Aku'Mai", "The Essence of Aku'Mai"),
        [6564] = L("Allégeance aux Dieux très anciens", "Allegiance to the Old Gods"),
        [6565] = L("Allégeance aux Dieux très anciens", "Allegiance to the Old Gods"),
        [6921] = L("Parmi les ruines", "Amongst the Ruins"),
        [6922] = L("Baron Aquanis", "Baron Aquanis"),
    },
    steps = {
        -- Alliance pre-quests
        A(971, "gerrig", AL()),
        A(1198, "shaedlass", AL()),
        A(1199, "manados", AL()),
        A(3765, "argos", AL()),
        T(3765, "gershala", AL()),
        A(1275, "gershala", AL()),
        -- Horde pre-quests
        A(6562, "tsunaman", H()),
        T(6562, "jeneu", H()),
        A(6563, "jeneu", H()),
        A(6921, "jeneu", H()),
        -- Entrance (outside) and inside
        D(6563, L("20 saphirs d'Aku'Mai (cristaux sur les murs, avant et dans le donjon)", "20 Sapphires of Aku'Mai (crystals on the walls, before and inside the dungeon)"),
            H({ map = 1440, x = 13.7, y = 10.6 })),
        D(1275, L("8 tiges cérébrales corrompues (satyres Rhizome-déchu)", "8 Corrupted Brain Stems (Fallenroot satyrs)"),
            AL({ targets = { "fsatyr", "frogue", "fstalker", "fhellcaller" } })),
        D(971, L("Manuscrit de Lorgalis (coffre)", "Lorgalis Manuscript (chest)"), AL()),
        D(1199, L("10 pendentifs du Crépuscule", "10 Twilight Pendants"),
            AL({ targets = { "tacolyte", "treaver", "taquamancer", "tloreseeker" } })),
        T(1198, "thaelrid", AL()),
        A(1200, "thaelrid", AL()),
        A(6561, "thaelrid", H()),
        A(6564, nil, H({ text = L("Note humide sur les prêtresses des marées (lance « Allégeance aux Dieux très anciens »)", "Damp Note from Blackfathom Tide Priestesses (starts Allegiance to the Old Gods)"),
            targets = { "tidepriestess" } })),
        A(6922, nil, H({ text = L("Baron Aquanis (fontaine) : ramasser le globe d'eau étrange", "Baron Aquanis (fountain): loot the Strange Water Globe"),
            targets = { "aquanis" } })),
        D(6921, L("Noyau des profondeurs (pierre des profondeurs)", "Fathom Core (Fathom Stone)"), H()),
        D(1200, L("Tuer le seigneur du Crépuscule Kelris : sa tête", "Kill Twilight Lord Kelris: his head"), AL({ targets = { "kelris" } })),
        D(6561, L("Tuer le seigneur du Crépuscule Kelris : sa tête", "Kill Twilight Lord Kelris: his head"), H({ targets = { "kelris" } })),
        -- Horde turn-ins (Zoram'gar), then back inside for Lorgus Jett
        T(6563, "jeneu", H()),
        T(6921, "jeneu", H()),
        T(6922, "jeneu", H()),
        T(6564, "jeneu", H()),
        A(6565, "jeneu", H()),
        D(6565, L("Tuer Lorgus Jett (dans le donjon)", "Kill Lorgus Jett (in the dungeon)"), H({ targets = { "lorgus" } })),
        T(6565, "jeneu", H()),
        T(6561, "bashana", H()),
        -- Alliance turn-ins
        T(1275, "gershala", AL()),
        T(1199, "manados", AL()),
        T(1200, "selgorm", AL()),
        T(971, "gerrig", AL()),
    },
} end)
