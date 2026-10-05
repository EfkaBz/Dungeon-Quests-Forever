local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Uldaman (Badlands) - Horde & Alliance
-- Classic version: quest IDs / NPCs / drops verified against the
-- Questie classic DB. Forever changes will be added as they are known.
-- Not listed: "Replacement Phial" (only if the Phial of Scrying is lost).
-- NPCs defined in other guides: talvash (29-38_Gnomeregan),
-- truthseeker (30-46_ScarletMonasteryShared).
-- ===================================================================
local function H(extra) local t = extra or {}; t.faction = "Horde"; return t end
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end

-- NPCs (map = uiMapID: 1418 Badlands, 1432 Loch Modan, 1455 Ironforge,
-- 1454 Orgrimmar, 1458 Undercity)
N.stormpike  = { id = 1356, name = "Prospector Stormpike",   map = 1455, x = 74.6, y = 11.7 }
N.ironband   = { id = 1344, name = "Prospector Ironband",    map = 1432, x = 65.9, y = 65.6 }
N.ryedol     = { id = 2910, name = "Prospector Ryedol",      map = 1418, x = 53.4, y = 43.4 }
N.hammertoe  = { id = 2909, name = "Hammertoe Grez",         map = 1432, x = 37.3, y = 85.8 }
N.karnik     = { id = 2916, name = "Historian Karnik",       map = 1455, x = 77.5, y = 11.8 }
N.belgrum    = { id = 2918, name = "Advisor Belgrum",        map = 1455, x = 77.3, y = 9.7 }
N.krom       = { id = 6294, name = "Krom Stoutarm",          map = 1455, x = 74.2, y = 9.4 }
N.magellas   = { id = 5387, name = "High Explorer Magellas", map = 1455, x = 69.9, y = 18.6 }
N.ghak       = { id = 1470, name = "Ghak Healtouch",         map = 1432, x = 37.1, y = 49.4 }
N.theldurin  = { id = 2785, name = "Theldurin the Lost",     map = 1418, x = 51.4, y = 76.9 }
N.rigglefuzz = { id = 2817, name = "Rigglefuzz",             map = 1418, x = 42.4, y = 52.9 }
N.jarkal     = { id = 6868, name = "Jarkal Mossmeld",        map = 1418, x = 2.4,  y = 46.1 }
N.dran       = { id = 6986, name = "Dran Droffers",          map = 1454, x = 59.5, y = 36.6 }
N.garrett    = { id = 5651, name = "Patrick Garrett",        map = 1458, x = 62.3, y = 48.6 }
N.baelog     = { id = 6906, name = "Baelog" }               -- inside
N.paladin    = { id = 6912, name = "Remains of a Paladin" } -- inside

N.murdaloc   = { id = 2945, name = "Murdaloc",               enemy = true, boss = true }
N.bonesnapper = { id = 2893, name = "Stonevault Bonesnapper", enemy = true }
N.magregan   = { id = 2932, name = "Magregan Deepshadow",    enemy = true, boss = true }
N.infernus   = { id = 2745, name = "Ambassador Infernus",    enemy = true, boss = true }
N.grimlok    = { id = 4854, name = "Grimlok",                enemy = true, boss = true }
N.archaedas  = { id = 2748, name = "Archaedas",              enemy = true, boss = true }
N.sfsurveyor = { id = 4844, name = "Shadowforge Surveyor",   enemy = true }
N.sfruffian  = { id = 4845, name = "Shadowforge Ruffian",    enemy = true }
N.sfdigger   = { id = 4846, name = "Shadowforge Digger",     enemy = true }
N.sfrelic    = { id = 4847, name = "Shadowforge Relic Hunter", enemy = true }
N.rockchewer = { id = 4851, name = "Stonevault Rockchewer",  enemy = true }
N.buzzard    = { id = 2830, name = "Buzzard",                enemy = true }
N.gbuzzard   = { id = 2831, name = "Giant Buzzard",          enemy = true }
N.cragcoyote = { id = 2727, name = "Crag Coyote",            enemy = true }
N.ecoyote    = { id = 2729, name = "Elder Crag Coyote",      enemy = true }
N.rockelem   = { id = 92,   name = "Rock Elemental",         enemy = true }
N.grockelem  = { id = 2736, name = "Greater Rock Elemental", enemy = true }

local REAGENTS = { "buzzard", "gbuzzard", "cragcoyote", "ecoyote", "rockelem", "grockelem" }
local NECKLACE = { "sfsurveyor", "sfruffian", "sfdigger", "rockchewer" }

ns:RegisterDungeon("ULDA", function() return {
    name = L("Uldaman", "Uldaman"),
    levels = "41-51",
    icon = "Interface\\Icons\\INV_Misc_Platnumdisks",
    entrance = { map = 1418, x = 44.6, y = 12.1 },
    titles = {
        [17] = L("Rechercher les composants à Uldaman", "Uldaman Reagent Run"),
        [704] = L("Le destin d'Agmond", "Agmond's Fate"),
        [707] = L("Ironband a besoin de vous !", "Ironband Wants You!"),
        [709] = L("La solution à la malédiction", "Solution to Doom"),
        [720] = L("Un signe d'espoir", "A Sign of Hope"), [721] = L("Un signe d'espoir", "A Sign of Hope"),
        [722] = L("L'amulette des secrets", "Amulet of Secrets"),
        [723] = L("Espérance en la foi", "Prospect of Faith"), [724] = L("Espérance en la foi", "Prospect of Faith"),
        [725] = L("Avertir de la menace", "Passing Word of a Threat"), [726] = L("Avertir de la menace", "Passing Word of a Threat"),
        [738] = L("Trouver Agmond", "Find Agmond"),
        [739] = L("Murdaloc", "Murdaloc"),
        [762] = L("Un ambassadeur du mal", "An Ambassador of Evil"),
        [1139] = L("La tablette de volonté", "The Lost Tablets of Will"),
        [1360] = L("Des Trésors à recouvrer", "Reclaimed Treasures"),
        [2198] = L("Le Collier brisé", "The Shattered Necklace"),
        [2199] = L("Le Prix de la Connaissance", "Lore for a Price"),
        [2200] = L("Retour à Uldaman", "Back to Uldaman"),
        [2201] = L("Trouver les Gemmes", "Find the Gems"),
        [2202] = L("Rechercher les composants à Uldaman", "Uldaman Reagent Run"),
        [2204] = L("Réparer le Collier", "Restoring the Necklace"),
        [2240] = L("La Chambre secrète", "The Hidden Chamber"),
        [2258] = L("Les réactifs des Terres ingrates", "Badlands Reagent Run"),
        [2278] = L("Les Disques de platine", "The Platinum Discs"),
        [2279] = L("Les Disques de platine", "The Platinum Discs"),
        [2280] = L("Les Disques de platine", "The Platinum Discs"),
        [2283] = L("Réparer le Collier", "Necklace Recovery"),
        [2284] = L("Réparer le Collier, deuxième prise", "Necklace Recovery, Take 2"),
        [2318] = L("La Traduction du Journal", "Translating the Journal"),
        [2338] = L("La Traduction du Journal", "Translating the Journal"),
        [2339] = L("Trouver les Gemmes et la Source d'énergie", "Find the Gems and Power Source"),
        [2340] = L("Livrer les Gemmes", "Deliver the Gems"),
        [2341] = L("Réparer le collier, troisième prise", "Necklace Recovery, Take 3"),
        [2342] = L("Des Trésors à recouvrer", "Reclaimed Treasures"),
        [2361] = L("Réparer le Collier", "Restoring the Necklace"),
        [2398] = L("Les nains perdus", "The Lost Dwarves"),
        [2418] = L("Les pierres de puissance", "Power Stones"),
        [2500] = L("Les réactifs des Terres ingrates", "Badlands Reagent Run"),
    },
    steps = {
        -- ===== Alliance pre-quests =====
        -- Agmond (Ironforge -> Loch Modan -> Badlands)
        A(707, "stormpike", AL()),
        T(707, "ironband", AL()),
        A(738, "ironband", AL()),
        T(738, nil, AL({ text = L("Squelette de nain abîmé (Terres ingrates)", "Battered Dwarven Skeleton (Badlands)"), map = 1418, x = 50.9, y = 62.4 })),
        A(739, nil, AL({ text = L("Squelette de nain abîmé : suite", "Battered Dwarven Skeleton: follow-up"), map = 1418, x = 50.9, y = 62.4 })),
        D(739, L("Tuer Murdaloc et des brise-os de la Voûte de pierre", "Kill Murdaloc and Stonevault Bonesnappers"),
            AL({ map = 1418, x = 49.6, y = 66.3, targets = { "murdaloc", "bonesnapper" } })),
        T(739, "ironband", AL()),
        A(704, "ironband", AL()),
        -- Hammertoe / Karnik / Belgrum chain
        A(720, nil, AL({ text = L("Carte froissée (Terres ingrates)", "Crumpled Map (Badlands)"), map = 1418, x = 53.0, y = 33.9 })),
        T(720, "ryedol", AL()),
        A(721, "ryedol", AL()),
        T(721, "hammertoe", AL()),
        A(722, "hammertoe", AL()),
        D(722, L("Amulette : tuer Magregan Sombrombre", "Amulet: kill Magregan Deepshadow"), AL({ map = 1432, x = 38.4, y = 94.0, targets = { "magregan" } })),
        T(722, "hammertoe", AL()),
        A(723, "hammertoe", AL()),
        T(723, "ryedol", AL()),
        A(724, "ryedol", AL()),
        T(724, "karnik", AL()),
        A(725, "karnik", AL()),
        T(725, "belgrum", AL()),
        A(726, "belgrum", AL()),
        T(726, "karnik", AL()),
        A(762, "karnik", AL()),
        D(762, L("Tuer l'ambassadeur Infernus (forteresse d'Angor)", "Kill Ambassador Infernus (Angor Fortress)"), AL({ map = 1418, x = 42.1, y = 28.9, targets = { "infernus" } })),
        T(762, "belgrum", AL()),
        A(1139, "belgrum", AL()),
        -- Reagents (Loch Modan)
        A(2500, "ghak", AL()),
        D(2500, L("5 gésiers de busard, 10 crocs de coyote, 5 éclats d'élémentaire", "5 Buzzard Gizzards, 10 Coyote Fangs, 5 Rock Elemental Shards"), AL({ targets = REAGENTS })),
        T(2500, "ghak", AL()),
        A(17, "ghak", AL()),
        -- Ironforge
        A(1360, "krom", AL()),
        A(2398, "stormpike", AL()),

        -- ===== Horde pre-quests =====
        A(2258, "jarkal", H()),
        D(2258, L("5 gésiers de busard, 10 crocs de coyote, 5 éclats d'élémentaire", "5 Buzzard Gizzards, 10 Coyote Fangs, 5 Rock Elemental Shards"), H({ targets = REAGENTS })),
        T(2258, "jarkal", H()),
        A(2202, "jarkal", H()),
        A(2283, "dran", H()),
        A(2342, "garrett", H()),

        -- ===== Both factions (Badlands) =====
        A(709, "theldurin"),
        A(2418, "rigglefuzz"),

        -- ===== Inside Uldaman (first run) =====
        D(2418, L("8 pierres de Dentrium et 8 pierres d'An'Alleum (Forge-ombre)", "8 Dentrium and 8 An'Alleum Power Stones (Shadowforge)"),
            { targets = { "sfsurveyor", "sfruffian", "sfdigger", "sfrelic" } }),
        D(704, L("4 urnes en pierre sculptée", "4 Carved Stone Urns"), AL()),
        D(17, L("12 champignons magenta", "12 Magenta Fungus Caps"), AL()),
        D(2202, L("12 champignons magenta", "12 Magenta Fungus Caps"), H()),
        T(2398, "baelog", AL()),
        A(2240, "baelog", AL()),
        A(2198, nil, AL({ text = L("Collier brisé (Forge-ombre et Voûte de pierre)", "Shattered Necklace (Shadowforge and Stonevault)"), targets = NECKLACE })),
        D(2283, L("Collier brisé (Forge-ombre et Voûte de pierre)", "Shattered Necklace (Shadowforge and Stonevault)"), H({ targets = NECKLACE })),
        D(1360, L("Coffre de Krom Stoutarm (salle commune nord)", "Krom Stoutarm's Chest (North Common Hall)"), AL()),
        D(2342, L("Coffre de la famille Garrett (salle commune sud)", "Garrett Family Chest (South Common Hall)"), H()),
        D(1139, L("Tablette de la Volonté", "Tablet of Will"), AL()),
        D(709, L("Tablette de Ryun'eh (coffre ancien)", "Tablet of Ryun'eh (Ancient Chest)")),
        A(2278, nil, { text = L("Disques de Norgannon : parler au gardien de pierre", "Discs of Norgannon: speak with the stone watcher") }),
        T(2278, nil, { text = L("Activer les disques de Norgannon", "Activate the Discs of Norgannon") }),
        A(2279, nil, AL({ text = L("Disques de Norgannon : suite", "Discs of Norgannon: follow-up") })),
        A(2280, nil, H({ text = L("Disques de Norgannon : suite", "Discs of Norgannon: follow-up") })),

        -- ===== Necklace chain (Alliance) =====
        T(2198, "talvash", AL()),
        A(2199, "talvash", AL()),
        D(2199, L("5 barres d'argent", "5 Silver Bars"), AL()),
        T(2199, "talvash", AL()),
        A(2200, "talvash", AL()),
        T(2200, "paladin", AL()),
        A(2201, "paladin", AL()),
        D(2201, L("Rubis (cache Forge-ombre), saphir (Grimlok), topaze (urne)", "Ruby (Shadowforge Cache), Sapphire (Grimlok), Topaz (Conspicuous Urn)"), AL({ targets = { "grimlok" } })),
        T(2201, nil, AL({ text = L("Utiliser la fiole de divination de Talvash", "Use Talvash's Phial of Scrying") })),
        A(2204, nil, AL({ text = L("Bol de divination de Talvash", "Talvash's Scrying Bowl") })),
        D(2204, L("Source d'énergie : tuer Archaedas", "Power Source: kill Archaedas"), AL({ targets = { "archaedas" } })),
        T(2204, "talvash", AL()),
        A(2361, "talvash", AL()),
        T(2361, "talvash", AL()),

        -- ===== Necklace chain (Horde) =====
        T(2283, "dran", H()),
        A(2284, "dran", H()),
        T(2284, "paladin", H()),
        A(2318, "paladin", H()),
        T(2318, "jarkal", H()),
        A(2338, "jarkal", H()),
        T(2338, "jarkal", H()),
        A(2339, "jarkal", H()),
        D(2339, L("Rubis, saphir (Grimlok), topaze et source d'énergie (Archaedas)", "Ruby, Sapphire (Grimlok), Topaz and Power Source (Archaedas)"), H({ targets = { "grimlok", "archaedas" } })),
        T(2339, "jarkal", H()),
        A(2340, "jarkal", H()),
        T(2340, "dran", H()),
        A(2341, "dran", H()),
        T(2341, "jarkal", H()),

        -- ===== Turn-ins =====
        T(2418, "rigglefuzz"),
        T(709, "theldurin"),
        T(704, "ironband", AL()),
        T(17, "ghak", AL()),
        T(1139, "belgrum", AL()),
        T(1360, "krom", AL()),
        T(2240, "stormpike", AL()),
        T(2279, "magellas", AL()),
        T(2202, "jarkal", H()),
        T(2342, "garrett", H()),
        T(2280, "truthseeker", H()),
    },
} end)
