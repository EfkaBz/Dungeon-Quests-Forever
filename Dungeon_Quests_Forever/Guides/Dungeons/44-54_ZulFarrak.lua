local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Zul'Farrak (Tanaris) - Horde & Alliance
-- Classic version: quest IDs / NPCs / drops verified against the
-- Questie classic DB. Forever changes will be added as they are known.
-- Not listed: "Tabetha's Task" (mage class quest), and the chains that
-- continue after the dungeon (Summoning Shadra, The Divination, The Ancient Egg).
-- ===================================================================
local function H(extra) local t = extra or {}; t.faction = "Horde"; return t end
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end

-- NPCs (map = uiMapID: 1446 Tanaris, 1441 Thousand Needles, 1445 Dustwallow,
-- 1434 Stranglethorn, 1425 Hinterlands, 1424 Hillsbrad, 1411 Durotar, 1419 Blasted Lands)
N.bilgewhizzle = { id = 7407, name = "Chief Engineer Bilgewhizzle", map = 1446, x = 52.5, y = 28.5 }
N.wizzle     = { id = 4453, name = "Wizzle Brassbolts",     map = 1441, x = 78.1, y = 77.1 }
N.tabetha    = { id = 6546, name = "Tabetha",               map = 1445, x = 46.1, y = 57.1 }
N.krazek     = { id = 773,  name = "Krazek",                map = 1434, x = 26.9, y = 77.2 }
N.tranrek    = { id = 7876, name = "Tran'rek",              map = 1446, x = 51.6, y = 26.8 }
N.lighthammer = { id = 7804, name = "Trenton Lighthammer",  map = 1446, x = 51.4, y = 28.8 }
N.yehkinya   = { id = 8579, name = "Yeh'kinya",             map = 1446, x = 67.0, y = 22.4 }
N.lydon      = { id = 2216, name = "Apothecary Lydon",      map = 1424, x = 61.4, y = 19.1 }
N.gadrin     = { id = 3188, name = "Master Gadrin",         map = 1411, x = 55.9, y = 74.7 }
N.talonaxe   = { id = 5636, name = "Gryphon Master Talonaxe", map = 1425, x = 9.8, y = 44.5 }
N.thadius    = { id = 8022, name = "Thadius Grimshade",     map = 1419, x = 66.9, y = 19.5 }

N.bly        = { id = 7604, name = "Sergeant Bly",          enemy = true, boss = true }
N.gahzrilla  = { id = 7273, name = "Gahz'rilla",            enemy = true, boss = true }
N.velratha   = { id = 7795, name = "Hydromancer Velratha",  enemy = true, boss = true }
N.theka      = { id = 7272, name = "Theka the Martyr",      enemy = true, boss = true }
N.nekrum     = { id = 7796, name = "Nekrum Gutchewer",      enemy = true, boss = true }
N.scarab     = { id = 7269, name = "Scarab",                enemy = true }
N.broodguard = { id = 2686, name = "Witherbark Broodguard", enemy = true }
N.sharpbeak  = { id = 8023, name = "Sharpbeak",             enemy = true }
N.sfshadowcaster = { id = 5648, name = "Sandfury Shadowcaster", enemy = true }
N.sfblooddrinker = { id = 5649, name = "Sandfury Blood Drinker", enemy = true }
N.sfwitchdoctor  = { id = 5650, name = "Sandfury Witch Doctor",  enemy = true }
N.sfshadowhunter = { id = 7246, name = "Sandfury Shadowhunter",  enemy = true }

ns:RegisterDungeon("ZF", function() return {
    name = L("Zul'Farrak", "Zul'Farrak"),
    levels = "44-54",
    icon = "Interface\\Icons\\INV_Misc_Head_Troll_01",
    entrance = { map = 1446, x = 38.7, y = 20.1 },
    titles = {
        [2768] = L("Le bâtonnet divino-matic", "Divino-matic Rod"),
        [2770] = L("Gahz'rilla", "Gahz'rilla"),
        [2846] = L("La tiare des abysses", "Tiara of the Deep"),
        [2864] = L("Tran'rek", "Tran'rek"),
        [2865] = L("Les carapaces de Scarabées", "Scarab Shells"),
        [2933] = L("Bouteilles de venin", "Venom Bottles"),
        [2934] = L("Glande à venin intacte", "Undamaged Venom Sac"),
        [2935] = L("Consulter Maître Gadrin", "Consult Master Gadrin"),
        [2936] = L("Le dieu-araignée", "The Spider God"),
        [2988] = L("Les cages Witherbark", "Witherbark Cages"),
        [2989] = L("L'autel de Zul", "The Altar of Zul"),
        [2990] = L("Thadius Grimshade", "Thadius Grimshade"),
        [2991] = L("Médaillon de Nekrum", "Nekrum's Medallion"),
        [3042] = L("Agent durcissant troll", "Troll Temper"),
        [3520] = L("Esprits de Hurleurs", "Screecher Spirits"),
        [3527] = L("La prophétie de Mosh'aru", "The Prophecy of Mosh'aru"),
    },
    steps = {
        -- Horde pre-quests (Hinterlands -> Tarren Mill -> Sen'jin)
        A(2933, nil, H({ text = L("Fiole de venin (Hinterlands, village Fânebois)", "Venom Bottle (Hinterlands, Witherbark village)"), map = 1425, x = 23.5, y = 58.8 })),
        T(2933, "lydon", H()),
        A(2934, "lydon", H()),
        D(2934, L("Poche de venin intacte (gardes de couvée Fânebois)", "Undamaged Venom Sac (Witherbark Broodguards)"), H({ targets = { "broodguard" } })),
        T(2934, "lydon", H()),
        A(2935, "lydon", H()),
        T(2935, "gadrin", H()),
        A(2936, "gadrin", H()),
        -- Alliance pre-quests (Hinterlands -> Blasted Lands)
        A(2988, "talonaxe", AL()),
        D(2988, L("Inspecter les 3 cages des villages Fânebois", "Check the 3 cages of the Witherbark villages"), AL({ map = 1425, x = 23.3, y = 58.8 })),
        T(2988, "talonaxe", AL()),
        A(2989, "talonaxe", AL()),
        D(2989, L("Inspecter le sommet de l'autel de Zul", "Check the top of the Altar of Zul"), AL({ map = 1425, x = 53.4, y = 67.1, targets = { "sharpbeak" } })),
        T(2989, "talonaxe", AL()),
        A(2990, "talonaxe", AL()),
        T(2990, "thadius", AL()),
        A(2991, "thadius", AL()),
        -- Both factions: Tanaris, Thousand Needles, Dustwallow, Booty Bay
        A(3520, "yehkinya"),
        D(3520, L("Capturer 3 esprits de hurleurs (Feralas)", "Capture 3 Screecher spirits (Feralas)")),
        T(3520, "yehkinya"),
        A(3527, "yehkinya"),
        A(2864, "krazek"),
        T(2864, "tranrek"),
        A(2865, "tranrek"),
        A(2768, "bilgewhizzle"),
        A(3042, "lighthammer"),
        A(2770, "wizzle"),
        A(2846, "tabetha"),
        -- Inside Zul'Farrak
        D(2865, L("5 carapaces de scarabée intactes", "5 Uncracked Scarab Shells"), { targets = { "scarab" } }),
        D(3042, L("20 fioles de trempe troll (Furie-des-sables)", "20 Vials of Troll Temper (Sandfury)"),
            { targets = { "sfshadowcaster", "sfblooddrinker", "sfwitchdoctor", "sfshadowhunter" } }),
        D(2936, L("Lire la tablette de Theka", "Read the Tablet of Theka"), H({ targets = { "theka" } })),
        D(3527, L("1re tablette (Theka le Martyr), 2e tablette (hydromancienne Velratha)", "1st tablet (Theka the Martyr), 2nd tablet (Hydromancer Velratha)"),
            { targets = { "theka", "velratha" } }),
        D(2846, L("Tiare des profondeurs (hydromancienne Velratha)", "Tiara of the Deep (Hydromancer Velratha)"), { targets = { "velratha" } }),
        D(2770, L("Écaille électrifiée : tuer Gahz'rilla (maillet de Zul'Farrak)", "Electrified Scale: kill Gahz'rilla (Mallet of Zul'Farrak)"), { targets = { "gahzrilla" } }),
        D(2991, L("Médaillon de Nekrum Mâchetripes", "Nekrum's Medallion"), AL({ targets = { "nekrum" } })),
        D(2768, L("Baguette divino-matique : sergent Bly", "Divino-matic Rod: Sergeant Bly"), { targets = { "bly" } }),
        -- Turn-ins
        T(2768, "bilgewhizzle"),
        T(3042, "lighthammer"),
        T(2865, "tranrek"),
        T(3527, "yehkinya"),
        T(2770, "wizzle"),
        T(2846, "tabetha"),
        T(2936, "gadrin", H()),
        T(2991, "thadius", AL()),
    },
} end)
