local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Gnomeregan (Dun Morogh) - Horde & Alliance
-- Classic version: quest IDs / NPCs / drops verified against the
-- Questie classic DB. Forever changes will be added as they are known.
-- Repeatable Sparklematic duplicates (4601-4606, 2953) are not listed.
-- ===================================================================
local function H(extra) local t = extra or {}; t.faction = "Horde"; return t end
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end

-- NPCs (map = uiMapID: 1454 Orgrimmar, 1434 Stranglethorn, 1455 Ironforge,
-- 1453 Stormwind, 1457 Darnassus, 1426 Dun Morogh, 1442 Stonetalon)
N.nogg       = { id = 3412, name = "Nogg",                        map = 1454, x = 76.0, y = 25.4 }
N.sovik      = { id = 3413, name = "Sovik",                       map = 1454, x = 75.5, y = 25.4 }
N.scooty     = { id = 7853, name = "Scooty",                      map = 1434, x = 27.6, y = 77.5 }
N.overspark  = { id = 7944, name = "Tinkmaster Overspark",        map = 1455, x = 69.6, y = 50.3 }
N.sarno      = { id = 7917, name = "Brother Sarno",               map = 1453, x = 40.6, y = 31.0 }
N.klockmort  = { id = 6169, name = "Klockmort Spannerspan",       map = 1455, x = 67.9, y = 46.1 }
N.mathiel    = { id = 6142, name = "Mathiel",                     map = 1457, x = 59.5, y = 45.4 }
N.ozzie      = { id = 1268, name = "Ozzie Togglevolt",            map = 1426, x = 45.9, y = 49.4 }
N.gnoarn     = { id = 6569, name = "Gnoarn",                      map = 1455, x = 69.2, y = 50.6 }
N.mekkatorque = { id = 7937, name = "High Tinker Mekkatorque",    map = 1455, x = 68.8, y = 49.0 }
N.castpipe   = { id = 7950, name = "Master Mechanic Castpipe",    map = 1455, x = 69.8, y = 48.1 }
N.gaxim      = { id = 4077, name = "Gaxim Rustfizzle",            map = 1442, x = 59.5, y = 67.2 }
N.talvash    = { id = 6826, name = "Talvash del Kissel",          map = 1455, x = 36.4, y = 3.6 }
N.kernobee   = { id = 7850, name = "Kernobee" }                   -- inside, Clockwerk Run

N.techbot     = { id = 6231, name = "Techbot",               enemy = true, boss = true }
N.thermaplugg = { id = 7800, name = "Mekgineer Thermaplugg", enemy = true, boss = true }
N.cburrower   = { id = 6206, name = "Caverndeep Burrower",   enemy = true }
N.cambusher   = { id = 6207, name = "Caverndeep Ambusher",   enemy = true }
N.cinvader    = { id = 6208, name = "Caverndeep Invader",    enemy = true }
N.clooter     = { id = 6209, name = "Caverndeep Looter",     enemy = true }
N.creaver     = { id = 6211, name = "Caverndeep Reaver",     enemy = true }
N.iinvader    = { id = 6213, name = "Irradiated Invader",    enemy = true }
N.ipillager   = { id = 6329, name = "Irradiated Pillager",   enemy = true }
N.ihorror     = { id = 6220, name = "Irradiated Horror",     enemy = true }

ns:RegisterDungeon("GNOMER", function() return {
    name = L("Gnomeregan", "Gnomeregan"),
    levels = "29-38",
    icon = "Interface\\Icons\\INV_Gizmo_02",
    entrance = { map = 1426, x = 24.3, y = 39.8 },
    titles = {
        [2841] = L("Guerre des plates-formes", "Rig Wars"),
        [2842] = L("L'ingénieur en chef Scooty", "Chief Engineer Scooty"),
        [2843] = L("Gnomer-paaarti !", "Gnomer-gooooone!"),
        [2904] = L("Une jolie pagaille", "A Fine Mess"),
        [2922] = L("Sauver le cerveau de Techbot !", "Save Techbot's Brain!"),
        [2923] = L("Maître-artisan Overspark", "Tinkmaster Overspark"),
        [2924] = L("Les cerveaux mécaniques", "Essential Artificials"),
        [2925] = L("Les cerveaux mécaniques de Klockmort", "Klockmort's Essentials"),
        [2926] = L("Gnogaine", "Gnogaine"),
        [2927] = L("Le jour d'après", "The Day After"),
        [2928] = L("Excavateurs gyrodrilmatiques", "Gyrodrillmatic Excavationators"),
        [2929] = L("La grande trahison", "The Grand Betrayal"),
        [2930] = L("Sauvetage de données", "Data Rescue"),
        [2931] = L("Du travail pour Castpipe", "Castpipe's Task"),
        [2945] = L("Anneau sali", "Grime-Encrusted Ring"),
        [2947] = L("Le retour de l'anneau", "Return of the Ring"),
        [2948] = L("Amélioration gnomique", "Gnome Improvement"),
        [2949] = L("Le retour de l'anneau", "Return of the Ring"),
        [2950] = L("Nogg améliore l'anneau", "Nogg's Ring Redo"),
        [2951] = L("Le Décapeur 5200 !", "The Sparklematic 5200!"),
        [2952] = L("Le Décapeur 5200 !", "The Sparklematic 5200!"),
        [2962] = L("Encore plus de Lueur verte !", "The Only Cure is More Green Glow"),
    },
    steps = {
        -- Horde pre-quests (Orgrimmar)
        A(2841, "nogg", H()),
        A(2842, "sovik", H()),
        T(2842, "scooty", H()),
        A(2843, "scooty", H()),
        K(2843, "scooty", L("Attendre que Scooty calibre le transpondeur gobelin", "Wait for Scooty to calibrate the Goblin Transponder"), H()),
        T(2843, "scooty", H()),
        -- Alliance pre-quests
        A(2923, "sarno", AL()),
        T(2923, "overspark", AL()),
        A(2922, "overspark", AL()),
        A(2925, "mathiel", AL()),
        T(2925, "klockmort", AL()),
        A(2924, "klockmort", AL()),
        A(2931, "gaxim", AL()),
        T(2931, "castpipe", AL()),
        A(2930, "castpipe", AL()),
        A(2929, "mekkatorque", AL()),
        A(2928, "shoni", AL()),
        A(2927, "gnoarn", AL()),
        T(2927, "ozzie", AL()),
        A(2926, "ozzie", AL()),
        -- Around the entrance (outside the instance)
        D(2926, L("Fiole de plomb : sur les envahisseurs ou pillards irradiés", "Leaden Phial: on Irradiated Invaders or Pillagers"),
            AL({ targets = { "iinvader", "ipillager" } })),
        T(2926, "ozzie", AL()),
        A(2962, "ozzie", AL()),
        D(2922, L("Tuer Techbot (dehors, devant l'entrée) : noyau de mémoire", "Kill Techbot (outside, before the entrance): Memory Core"),
            AL({ targets = { "techbot" } })),
        -- Inside Gnomeregan
        D(2928, L("24 tripes robo-mécaniques (Caverneux)", "24 Robo-mechanical Guts (Caverndeep mobs)"),
            AL({ targets = { "cburrower", "cambusher", "cinvader", "creaver" } })),
        D(2962, L("Retombée radioactive très puissante (horreurs irradiées, elle se dégrade vite)", "High Potency Radioactive Fallout (Irradiated Horrors, it decays fast)"),
            AL({ targets = { "ihorror" } })),
        D(2924, L("12 artificiels essentiels (extrapolateurs artificiels)", "12 Essential Artificials (Artificial Extrapolators)"), AL()),
        D(2930, L("Carte perforée prismatique (terminaux blanc, jaune, bleu, rouge)", "Prismatic Punch Card (white, yellow, blue, red terminals)"), AL()),
        A(2904, "kernobee"),
        D(2904, L("Escorter Kernobee jusqu'à la sortie de la Course de Clockwerk", "Escort Kernobee to the Clockwerk Run exit"), { targets = { "kernobee" } }),
        A(2951, nil, { text = L("Brillomatic 5200 : un objet encrassé + 3 pièces d'argent", "Sparklematic 5200: a Grime-Encrusted Item + 3 silver"),
            targets = { "cburrower", "cambusher", "cinvader", "clooter" } }),
        T(2951, nil, { text = L("Insérer l'objet dans le Brillomatic 5200", "Insert the item in the Sparklematic 5200") }),
        A(2952, nil, { text = L("Brillomatic 5200 : suite", "Sparklematic 5200: follow-up") }),
        T(2952, nil, { text = L("Récupérer l'objet nettoyé", "Get the cleaned item") }),
        A(2945, nil, { text = L("Anneau encrassé : sur les agents Sombrefer", "Grime-Encrusted Ring: from Dark Iron Agents") }),
        T(2945, nil, { text = L("Nettoyer l'anneau au Brillomatic 5200", "Clean the ring in the Sparklematic 5200") }),
        A(2947, nil, AL({ text = L("Brillomatic 5200 : le retour de l'anneau", "Sparklematic 5200: Return of the Ring") })),
        A(2949, nil, H({ text = L("Brillomatic 5200 : le retour de l'anneau", "Sparklematic 5200: Return of the Ring") })),
        D(2841, L("Plans de l'engin (coffre de Thermaplugg) + combinaison sur Thermaplugg", "Rig Blueprints (Thermaplugg's Safe) + combination from Thermaplugg"),
            H({ targets = { "thermaplugg" } })),
        D(2929, L("Tuer le mekgénieur Thermaplugg", "Kill Mekgineer Thermaplugg"), AL({ targets = { "thermaplugg" } })),
        -- Horde turn-ins
        T(2904, "scooty"),
        T(2841, "nogg", H()),
        T(2949, "nogg", H()),
        A(2950, "nogg", H()),
        D(2950, L("Anneau + barre d'argent + agate mousse + 30 pièces d'argent", "Ring + Silver Bar + Moss Agate + 30 silver"), H()),
        T(2950, "nogg", H()),
        -- Alliance turn-ins
        T(2922, "overspark", AL()),
        T(2924, "klockmort", AL()),
        T(2930, "castpipe", AL()),
        T(2929, "mekkatorque", AL()),
        T(2928, "shoni", AL()),
        T(2962, "ozzie", AL()),
        T(2947, "talvash", AL()),
        A(2948, "talvash", AL()),
        D(2948, L("Anneau + barre d'argent + agate mousse + 30 pièces d'argent", "Ring + Silver Bar + Moss Agate + 30 silver"), AL()),
        T(2948, "talvash", AL()),
    },
} end)
