local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Attunement: Onyxia's Lair (Drakefire Amulet)
-- Alliance: The True Masters chain -> Drakefire Amulet
-- Horde: Warlord's Command -> Blood of the Black Dragon Champion
-- Quest IDs / NPCs verified against the Questie classic DB.
-- ===================================================================
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end
local function HO(extra) local t = extra or {}; t.faction = "Horde"; return t end

-- Alliance NPCs
N.att_helendis  = { id = 9562,  name = "Helendis Riverhorn",        map = 1428, x = 85.8, y = 69.0 }
N.att_solomon   = { id = 344,   name = "Magistrate Solomon",        map = 1433, x = 30.0, y = 44.5 }
N.att_bolvar    = { id = 1748,  name = "Highlord Bolvar Fordragon", map = 1453, x = 78.2, y = 18.0 }
N.att_prestor   = { id = 1749,  name = "Lady Katrana Prestor",      map = 1453, x = 78.1, y = 17.8 }
N.att_maxwell   = { id = 9560,  name = "Marshal Maxwell",           map = 1428, x = 84.7, y = 69.0 }
N.att_ragged    = { id = 9563,  name = "Ragged John",               map = 1428, x = 65.0, y = 23.8 }
N.att_windsor   = { id = 9023,  name = "Marshal Windsor" }          -- prison of Blackrock Depths
N.att_rowe      = { id = 17804, name = "Squire Rowe",               map = 1453, x = 70.4, y = 85.2 }
N.att_haleh     = { id = 10929, name = "Haleh",                     map = 1452, x = 54.6, y = 51.2 } -- top of Mazthoril
-- Horde NPCs
N.att_goretooth = { id = 9077,  name = "Warlord Goretooth",         map = 1418, x = 5.8,  y = 47.5 }
N.att_eitrigg   = { id = 3144,  name = "Eitrigg",                   map = 1454, x = 34.3, y = 39.4 }
N.att_thrall    = { id = 4949,  name = "Thrall",                    map = 1454, x = 31.7, y = 37.8 }
N.att_rexxar    = { id = 10182, name = "Rexxar",                    map = 1444, x = 46.4, y = 18.2 } -- walks between Desolace and Feralas
N.att_myranda   = { id = 11872, name = "Myranda the Hag",           map = 1422, x = 50.8, y = 77.9 }
N.att_emberstrife = N.att_emberstrife or { id = 10321, name = "Emberstrife", map = 1445, x = 56.7, y = 87.7 }
-- Mobs
N.att_broodling = { id = 7047,  name = "Black Broodling",    enemy = true }
N.att_spawn     = { id = 7040,  name = "Black Dragonspawn",  enemy = true }
N.att_wyrmkin   = { id = 7041,  name = "Black Wyrmkin",      enemy = true }
N.att_drake     = { id = 7044,  name = "Black Drake",        enemy = true }
N.att_overseer  = { id = 8889,  name = "Anvilrage Overseer", enemy = true }
N.att_warden    = { id = 8890,  name = "Anvilrage Warden",   enemy = true }
N.att_angerforge = { id = 9033, name = "General Angerforge", enemy = true, boss = true }
N.att_argelmach = { id = 8983,  name = "Golem Lord Argelmach", enemy = true, boss = true }
N.att_drakkisath = { id = 10363, name = "General Drakkisath", enemy = true, boss = true }
N.att_rend      = { id = 10429, name = "Warchief Rend Blackhand", enemy = true, boss = true }
N.att_omokk      = N.att_omokk or { id = 9196, name = "Highlord Omokk", enemy = true, boss = true }
N.att_voone      = N.att_voone or { id = 9237, name = "War Master Voone", enemy = true, boss = true }
N.att_wyrmthalak = N.att_wyrmthalak or { id = 9568, name = "Overlord Wyrmthalak", enemy = true, boss = true }
N.att_scryer    = { id = 10664, name = "Scryer",    enemy = true, boss = true, map = 1452, x = 52.7, y = 55.9 }
N.att_somnus    = { id = 12900, name = "Somnus",    enemy = true, boss = true, map = 1435, x = 74.1, y = 68.4 }
N.att_chronalis = { id = 8197,  name = "Chronalis", enemy = true, boss = true, map = 1446, x = 64.2, y = 48.5 }
N.att_axtroz    = { id = 12899, name = "Axtroz",    enemy = true, boss = true, map = 1437, x = 81.8, y = 48.2 }

ns:RegisterDungeon("ATT_ONY", function() return {
    name = L("Repaire d'Onyxia", "Onyxia's Lair"),
    levels = "50-60",
    attunement = true, order = 3,
    final = { Alliance = 6502, Horde = 6602 },
    icon = "Interface\\Icons\\INV_Misc_Head_Dragon_01",
    art = 131863, artCoord = { 0.02, 0.98, 0.24, 0.82 }, -- Onyxia loading screen (file ID, checked in game)
    entrance = { map = 1445, x = 52.6, y = 76.8 }, -- Wyrmbog, Dustwallow Marsh
    titles = {
        [4182] = "Dragonkin Menace", [4183] = "The True Masters", [4184] = "The True Masters",
        [4185] = "The True Masters", [4186] = "The True Masters", [4223] = "The True Masters",
        [4224] = "The True Masters", [4241] = "Marshal Windsor", [4242] = "Abandoned Hope",
        [4264] = "A Crumpled Up Note", [4282] = "A Shred of Hope", [4322] = "Jail Break!",
        [6402] = "Stormwind Rendezvous", [6403] = "The Great Masquerade", [6501] = "The Dragon's Eye",
        [6502] = "Drakefire Amulet",
        [4903] = "Warlord's Command", [4941] = "Eitrigg's Wisdom", [4974] = "For The Horde!",
        [6566] = "What the Wind Carries", [6567] = "The Champion of the Horde", [6568] = "The Testament of Rexxar",
        [6569] = "Oculus Illusions", [6570] = "Emberstrife", [6582] = "The Test of Skulls, Scryer",
        [6583] = "The Test of Skulls, Somnus", [6584] = "The Test of Skulls, Chronalis",
        [6585] = "The Test of Skulls, Axtroz", [6601] = "Ascension...", [6602] = "Blood of the Black Dragon Champion",
    },
    steps = {
        -- ===== Alliance =====
        A(4182, "att_helendis", AL()),
        D(4182, L("Steppes ardentes : 15 jeunes dragonnets noirs, 10 dragonnides noirs, 4 wyrmides noirs, 1 drake noir",
                  "Burning Steppes: 15 Black Broodlings, 10 Black Dragonspawn, 4 Black Wyrmkin, 1 Black Drake"),
            AL({ targets = { "att_broodling", "att_spawn", "att_wyrmkin", "att_drake" } })),
        T(4182, "att_helendis", AL()),
        A(4183, "att_helendis", AL()),
        T(4183, "att_solomon", AL()),
        A(4184, "att_solomon", AL()),
        T(4184, "att_bolvar", AL()),
        A(4185, "att_bolvar", AL()),
        K(4185, "att_prestor", L("Parler à Lady Katrana Prestor, à côté de Bolvar", "Talk to Lady Katrana Prestor, next to Bolvar"), AL()),
        T(4185, "att_bolvar", AL()),
        A(4186, "att_bolvar", AL()),
        T(4186, "att_solomon", AL()),
        A(4223, "att_solomon", AL()),
        T(4223, "att_maxwell", AL()),
        A(4224, "att_maxwell", AL()),
        K(4224, "att_ragged", L("Écouter toute l'histoire de Ragged John (Steppes ardentes)", "Listen to Ragged John's whole story (Burning Steppes)"), AL()),
        T(4224, "att_maxwell", AL()),
        A(4241, "att_maxwell", AL()),
        T(4241, "att_windsor", AL({ text = L("Profondeurs de Rochenoire : Marshal Windsor, dans la prison", "Blackrock Depths: Marshal Windsor, in the prison") })),
        A(4242, "att_windsor", AL({ text = L("Profondeurs de Rochenoire : Marshal Windsor, dans la prison", "Blackrock Depths: Marshal Windsor, in the prison") })),
        T(4242, "att_maxwell", AL()),
        A(4264, nil, AL({ text = L("Note froissée : sur les Anvilrage Overseer / Warden (profondeurs de Rochenoire)", "A Crumpled Up Note: from Anvilrage Overseers / Wardens (Blackrock Depths)"),
            targets = { "att_overseer", "att_warden" } })),
        T(4264, "att_windsor", AL({ text = L("Rendre la note à Marshal Windsor (prison)", "Bring the note to Marshal Windsor (prison)") })),
        A(4282, "att_windsor", AL({ text = L("Marshal Windsor (prison)", "Marshal Windsor (prison)") })),
        D(4282, L("Informations perdues de Windsor : General Angerforge et Golem Lord Argelmach (profondeurs de Rochenoire)",
                  "Windsor's Lost Information: General Angerforge and Golem Lord Argelmach (Blackrock Depths)"),
            AL({ targets = { "att_angerforge", "att_argelmach" } })),
        T(4282, "att_windsor", AL({ text = L("Marshal Windsor (prison)", "Marshal Windsor (prison)") })),
        A(4322, "att_windsor", AL({ text = L("Marshal Windsor (prison)", "Marshal Windsor (prison)") })),
        D(4322, L("Escorter Marshal Windsor dans la prison (récupérer son équipement, libérer ses amis)",
                  "Escort Marshal Windsor through the prison (get his gear back, free his friends)"), AL()),
        T(4322, "att_maxwell", AL()),
        A(6402, "att_maxwell", AL()),
        T(6402, "att_rowe", AL({ text = L("Portes de Hurlevent : Squire Rowe, puis Reginald Windsor", "Stormwind gates: Squire Rowe, then Reginald Windsor") })),
        A(6403, "att_rowe", AL({ text = L("Reginald Windsor (portes de Hurlevent)", "Reginald Windsor (Stormwind gates)") })),
        D(6403, L("Suivre et protéger Reginald Windsor jusqu'au château", "Follow and protect Reginald Windsor to the keep"), AL()),
        T(6403, "att_bolvar", AL()),
        A(6501, "att_bolvar", AL()),
        T(6501, "att_haleh", AL()),
        A(6502, "att_haleh", AL()),
        D(6502, L("Sang du champion des dragons noirs : General Drakkisath (pic Rochenoire supérieur, clé nécessaire)",
                  "Blood of the Black Dragon Champion: General Drakkisath (Upper Blackrock Spire, key needed)"),
            AL({ targets = { "att_drakkisath" } })),
        T(6502, "att_haleh", AL()),

        -- ===== Horde =====
        A(4903, "att_goretooth", HO()),
        D(4903, L("Pic Rochenoire inférieur : Highlord Omokk, War Master Voone, Overlord Wyrmthalak + documents importants",
                  "Lower Blackrock Spire: Highlord Omokk, War Master Voone, Overlord Wyrmthalak + Important Blackrock Documents"),
            HO({ targets = { "att_omokk", "att_voone", "att_wyrmthalak" } })),
        T(4903, "att_goretooth", HO()),
        A(4941, "att_goretooth", HO()),
        K(4941, "att_eitrigg", L("Parler à Eitrigg (Orgrimmar)", "Talk to Eitrigg (Orgrimmar)"), HO()),
        T(4941, "att_thrall", HO()),
        A(4974, "att_thrall", HO()),
        D(4974, L("Tête du chef de guerre Rend Blackhand (pic Rochenoire supérieur)", "Head of Warchief Rend Blackhand (Upper Blackrock Spire)"),
            HO({ targets = { "att_rend" } })),
        T(4974, "att_thrall", HO()),
        A(6566, "att_thrall", HO()),
        T(6566, "att_thrall", HO()),
        A(6567, "att_thrall", HO()),
        T(6567, "att_rexxar", HO()),
        A(6568, "att_rexxar", HO()),
        T(6568, "att_myranda", HO()),
        A(6569, "att_myranda", HO()),
        D(6569, L("20 yeux de dragonnide noir (pic Rochenoire)", "20 Black Dragonspawn Eyes (Blackrock Spire)"), HO()),
        T(6569, "att_myranda", HO()),
        A(6570, "att_myranda", HO()),
        T(6570, "att_emberstrife", HO({ text = L("Emberstrife (Wyrmbog) : porter l'amulette de subversion draconique et lui parler",
                                                 "Emberstrife (Wyrmbog): wear the Amulet of Draconic Subversion and talk to him") })),
        A(6582, "att_emberstrife", HO()),
        A(6583, "att_emberstrife", HO()),
        A(6584, "att_emberstrife", HO()),
        D(6582, L("Crâne de Scryer (Berceau-de-l'Hiver)", "Skull of Scryer (Winterspring)"),
            HO({ map = 1452, x = 52.7, y = 55.9, targets = { "att_scryer" } })),
        D(6583, L("Crâne de Somnus (marais des Chagrins)", "Skull of Somnus (Swamp of Sorrows)"),
            HO({ map = 1435, x = 74.1, y = 68.4, targets = { "att_somnus" } })),
        D(6584, L("Crâne de Chronalis (Tanaris, grottes du Temps)", "Skull of Chronalis (Tanaris, Caverns of Time)"),
            HO({ map = 1446, x = 64.2, y = 48.5, targets = { "att_chronalis" } })),
        T(6582, "att_emberstrife", HO()),
        T(6583, "att_emberstrife", HO()),
        T(6584, "att_emberstrife", HO()),
        A(6585, "att_emberstrife", HO()),
        D(6585, L("Crâne d'Axtroz (Paluns, Grim Batol)", "Skull of Axtroz (Wetlands, Grim Batol)"),
            HO({ map = 1437, x = 81.8, y = 48.2, targets = { "att_axtroz" } })),
        T(6585, "att_emberstrife", HO()),
        A(6601, "att_emberstrife", HO()),
        T(6601, "att_rexxar", HO()),
        A(6602, "att_rexxar", HO()),
        D(6602, L("Sang du champion des dragons noirs : General Drakkisath (pic Rochenoire supérieur, clé nécessaire)",
                  "Blood of the Black Dragon Champion: General Drakkisath (Upper Blackrock Spire, key needed)"),
            HO({ targets = { "att_drakkisath" } })),
        T(6602, "att_rexxar", HO()),
    },
} end)
