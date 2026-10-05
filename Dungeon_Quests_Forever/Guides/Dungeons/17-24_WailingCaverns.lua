local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Wailing Caverns (The Barrens) - Horde & Alliance
-- Quest IDs / NPCs / drops verified against the Questie classic DB.
-- Steps with `faction` are only shown to that faction.
-- ===================================================================
local H, AL = { faction = "Horde" }, { faction = "Alliance" }
local function F(base, extra)
    local t = {}
    for k, v in pairs(base) do t[k] = v end
    for k, v in pairs(extra or {}) do t[k] = v end
    return t
end

-- NPCs (map = uiMapID: 1413 Barrens, 1456 Thunder Bluff, 1457 Darnassus)
N.tonga      = { id = 3448, name = "Tonga Runetotem",             map = 1413, x = 52.3, y = 31.9 }
N.hamuul     = { id = 5769, name = "Arch Druid Hamuul Runetotem", map = 1456, x = 78.6, y = 28.6 }
N.nara       = { id = 5770, name = "Nara Wildmane",               map = 1456, x = 75.7, y = 31.6 }
N.zamah      = { id = 3419, name = "Apothecary Zamah",            map = 1456, x = 22.8, y = 20.9 }
N.mebok      = { id = 3446, name = "Mebok Mizzyrix",              map = 1413, x = 62.4, y = 37.6 }
N.bigglefuzz = { id = 3665, name = "Crane Operator Bigglefuzz",   map = 1413, x = 63.1, y = 37.6 }
N.nalpak     = { id = 5767, name = "Nalpak",                      map = 1413, x = 46.0, y = 35.7 }
N.ebru       = { id = 5768, name = "Ebru",                        map = 1413, x = 46.0, y = 35.7 }
N.falla      = { id = 8418, name = "Falla Sagewind",              map = 1413, x = 48.2, y = 32.8 }
N.mathrengyl = { id = 4217, name = "Mathrengyl Bearwalker",       map = 1457, x = 35.4, y = 8.4 }

N.snapjaw     = { id = 3461, name = "Oasis Snapjaw",       enemy = true }
N.scytheclaw  = { id = 3256, name = "Sunscale Scytheclaw", enemy = true }
N.magglish    = { id = 3655, name = "Mad Magglish",        enemy = true }
N.cobrahn     = { id = 3669, name = "Lord Cobrahn",        enemy = true, boss = true }
N.anacondra   = { id = 3671, name = "Lady Anacondra",      enemy = true, boss = true }
N.pythas      = { id = 3670, name = "Lord Pythas",         enemy = true, boss = true }
N.serpentis   = { id = 3673, name = "Lord Serpentis",      enemy = true, boss = true }
N.mutanus     = { id = 3654, name = "Mutanus the Devourer", enemy = true, boss = true }
N.dravager    = { id = 3636, name = "Deviate Ravager",     enemy = true }
N.dviper      = { id = 5755, name = "Deviate Viper",       enemy = true }
N.dshambler   = { id = 5761, name = "Deviate Shambler",    enemy = true }
N.ddreadfang  = { id = 5056, name = "Deviate Dreadfang",   enemy = true }
N.dcoiler     = { id = 3630, name = "Deviate Coiler",      enemy = true }
N.dstinglash  = { id = 3631, name = "Deviate Stinglash",   enemy = true }
N.dcreeper    = { id = 3632, name = "Deviate Creeper",     enemy = true }
N.dslayer     = { id = 3633, name = "Deviate Slayer",      enemy = true }
N.devouring   = { id = 3638, name = "Devouring Ectoplasm", enemy = true }
N.evolving    = { id = 3640, name = "Evolving Ectoplasm",  enemy = true }

ns:RegisterDungeon("WC", function() return {
    name = L("Cavernes des lamentations", "Wailing Caverns"),
    levels = "17-24",
    icon = "Interface\\Icons\\Ability_Hunter_Pet_WindSerpent",
    entrance = { map = 1413, x = 46.0, y = 36.5 }, -- Lushwater Oasis
    titles = {
        [865] = L("Les cornes de raptors", "Raptor Horns"),
        [870] = L("Les Bassins oubliés", "The Forgotten Pools"),
        [877] = L("L'oasis stagnante", "The Stagnant Oasis"),
        [880] = L("Source de vie", "Altered Beings"),
        [914] = L("Les druides du Croc", "Leaders of the Fang"),
        [959] = L("Fuite de porto aux docks", "Trouble at the Docks"),
        [962] = L("Fleur de serpent", "Serpentbloom"),
        [1486] = L("Les peaux communes", "Deviate Hides"),
        [1487] = L("L'éradication des Déviants", "Deviate Eradication"),
        [1489] = L("Hamuul Runetotem", "Hamuul Runetotem"),
        [1490] = L("Nara Wildmane", "Nara Wildmane"),
        [1491] = L("Les potions d'intelligence", "Smart Drinks"),
        [6981] = L("L'Eclat luminescent", "The Glowing Shard"),
        [3369] = L("Au coeur des cauchemars", "In Nightmares"),
        [3370] = L("Au coeur des cauchemars", "In Nightmares"),
    },
    steps = {
        -- Horde pre-quests: Tonga Runetotem at the Crossroads
        A(870, "tonga", F(H)),
        D(870, L("Explorer les Bassins oubliés", "Explore the Forgotten Pools"), F(H, { map = 1413, x = 45.1, y = 22.5 })),
        T(870, "tonga", F(H)),
        A(877, "tonga", F(H)),
        D(877, L("Examiner la fissure bouillonnante de l'oasis stagnante", "Examine the Bubbling Fissure in the Stagnant Oasis"),
            F(H, { map = 1413, x = 55.6, y = 42.8 })),
        T(877, "tonga", F(H)),
        A(880, "tonga", F(H)),
        D(880, L("8 carapaces altérées (Happe-mâchoires de l'oasis)", "8 Altered Snapjaw Shells (Oasis Snapjaws)"),
            F(H, { map = 1413, x = 55.6, y = 42.8, targets = { "snapjaw" } })),
        T(880, "tonga", F(H)),
        A(1489, "tonga", F(H)),
        -- Horde: Thunder Bluff
        T(1489, "hamuul", F(H)),
        A(1490, "hamuul", F(H)),
        T(1490, "nara", F(H)),
        A(914, "nara", F(H)),
        A(962, "zamah", F(H)),
        -- Ratchet (both factions)
        A(865, "mebok"),
        D(865, L("5 cornes de raptor intactes (Griffes-faux solécailles)", "5 Intact Raptor Horns (Sunscale Scytheclaws)"),
            { map = 1413, x = 57.0, y = 53.0, targets = { "scytheclaw" } }),
        T(865, "mebok"),
        A(1491, "mebok"),
        A(959, "bigglefuzz"),
        -- Cave above the instance entrance
        A(1486, "nalpak"),
        A(1487, "ebru"),
        D(962, L("10 Serpentfleurs (plantes dans les grottes)", "10 Serpentbloom (plants in the caves)"),
            F(H, { map = 1413, x = 49.1, y = 33.5 })),
        D(959, L("Porto de 99 ans : tuer Magglish le Fou", "99-Year-Old Port: kill Mad Magglish"),
            { map = 1413, x = 45.7, y = 33.6, targets = { "magglish" } }),
        -- Inside the dungeon
        D(1486, L("20 peaux de déviant", "20 Deviate Hides"), { targets = { "dcoiler", "dstinglash", "dcreeper", "dslayer" } }),
        D(1491, L("6 essences gémissantes (ectoplasmes)", "6 Wailing Essences (ectoplasms)"), { targets = { "devouring", "evolving" } }),
        D(1487, L("Tuer 7 ravageurs, vipères, titubants et crocs-d'effroi déviants", "Kill 7 Deviate Ravagers, Vipers, Shamblers and Dreadfangs"),
            { targets = { "dravager", "dviper", "dshambler", "ddreadfang" } }),
        D(914, L("Gemmes des 4 Crocs : Cobrahn, Anacondra, Pythas, Serpentis", "Gems of the 4 Fang leaders: Cobrahn, Anacondra, Pythas, Serpentis"),
            F(H, { targets = { "cobrahn", "anacondra", "pythas", "serpentis" } })),
        A(6981, nil, { text = L("Escorter le disciple de Naralex, tuer Mutanus : Éclat luisant", "Escort the Disciple of Naralex, kill Mutanus: Glowing Shard"),
            targets = { "mutanus" } }),
        -- Turn-ins near the entrance
        T(1486, "nalpak"),
        T(1487, "ebru"),
        T(6981, "falla"),
        A(3369, "falla", F(H)),
        A(3370, "falla", F(AL)),
        -- Ratchet
        T(959, "bigglefuzz"),
        T(1491, "mebok"),
        -- Horde: Thunder Bluff
        T(962, "zamah", F(H)),
        T(914, "nara", F(H)),
        T(3369, "hamuul", F(H)),
        -- Alliance: Darnassus
        T(3370, "mathrengyl", F(AL)),
    },
} end)
