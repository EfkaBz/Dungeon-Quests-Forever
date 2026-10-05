local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- The Hall of Thanes (beneath Ironforge) - WoW Forever
-- New Forever dungeon (not in Questie). Data from foreverchanges.pro,
-- warcraftforever.games and warcrafttavern.com (beta data, may change).
-- To verify in game: NPC positions inside Ironforge, entrance position.
-- ===================================================================
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end

-- NPCs (map = uiMapID: 1455 Ironforge, 1426 Dun Morogh)
N.farsen   = { id = 264936, name = "Earthseer Farsen",       map = 1426, x = 64.8, y = 58.5 }
N.magni    = { id = 2784,   name = "King Magni Bronzebeard", map = 1455, x = 39.1, y = 55.8 }
N.afadra   = { id = 0,      name = "Afadra Dunwall",         map = 1455, x = 32.8, y = 48.0 }
N.thom     = { id = 0,      name = "Thom Filch",             map = 1455, x = 32.6, y = 44.6 }
N.attendant = { id = 0,     name = "Ghostly Attendant" }     -- first room of the dungeon

N.darkspy  = { id = 0, name = "Dark Iron Spy",                              enemy = true }
N.faldrim  = { id = 0, name = L("Faldrim Courbenclume", "Faldrim Anvilmar"), enemy = true, boss = true }
N.durgen   = { id = 0, name = L("Durgen Mornemartel", "Durgen Dirgehammer"), enemy = true, boss = true }

ns:RegisterDungeon("THANES", function() return {
    name = L("La salle des Thanes", "The Hall of Thanes"),
    levels = "13-18",
    new = true, -- new in Forever
    icon = "Interface\\Icons\\INV_Hammer_05",
    entrance = { map = 1455, x = 43.5, y = 52.0 }, -- Great Forge, corridor left of Magni's throne
    titles = {
        [96390] = L("Tuer dans l'œuf", "Nip 'Em in the Bud"),
        [96391] = L("Carte souterraine", "Underground Map"),
        [96392] = L("La vigie de Farsen", "Farsen's Watch"),
        [96393] = L("Incursion dans l'ancienne Forgefer", "Old Ironforge Incursion"),
        [96394] = L("Les morts sans repos", "The Restless Dead"),
        [96403] = L("Des héritages importants", "Important Heirlooms"),
        [96395] = L("Une vieille rancune", "An Ancient Grudge"),
        [98423] = L("Le traité d'entente", "The Treaty of Understanding"),
    },
    steps = {
        -- Alliance pre-quest chain (Dun Morogh)
        A(96390, "farsen", AL()),
        D(96390, L("Tuer 10 espions Sombrefer (Domaine des Ironband)", "Kill 10 Dark Iron Spies (Ironband's Compound)"),
            AL({ map = 1426, x = 76.7, y = 60.7, targets = { "darkspy" } })),
        A(96391, nil, AL({ text = L("Carte Sombrefer : sur le capitaine espion, dans la maison du Domaine des Ironband", "Dark Iron Map: from the spy captain, in the house at Ironband's Compound"),
            map = 1426, x = 76.7, y = 60.7 })),
        T(96390, "farsen", AL()),
        T(96391, "farsen", AL()),
        A(96392, "farsen", AL()),
        D(96392, L("Utiliser la Clairvoyance de Farsen", "Use Farsen's Farsight"), AL({ map = 1426, x = 64.8, y = 58.5 })),
        T(96392, "farsen", AL()),
        A(96393, "farsen", AL()),
        -- Ironforge, around the entrance
        A(96394, "afadra", AL()),
        A(96403, "thom"),
        -- Inside the dungeon
        A(96395, "attendant"),
        D(96403, L("8 héritages nains", "8 Dwarven Heirlooms")),
        D(96394, L("Tuer 15 apparitions enragées, 10 âmes tourmentées et Faldrim", "Kill 15 Enraged Apparitions, 10 Tormented Souls and Faldrim"),
            AL({ targets = { "faldrim" } })),
        D(96395, L("Vaincre Faldrim Courbenclume", "Defeat Faldrim Anvilmar"), { targets = { "faldrim" } }),
        T(96395, "attendant"),
        D(96393, L("Tête de Durgen Mornemartel", "Head of Durgen Dirgehammer"), AL({ targets = { "durgen" } })),
        A(98423, nil, AL({ text = L("Tablette de pierre derrière la porte scellée (salle finale)", "Stone tablet behind the sealed door (final room)") })),
        -- Turn-ins (Ironforge)
        T(96394, "afadra", AL()),
        T(96403, "thom"),
        T(96393, "magni", AL()),
        T(98423, "magni", AL()),
    },
} end)
