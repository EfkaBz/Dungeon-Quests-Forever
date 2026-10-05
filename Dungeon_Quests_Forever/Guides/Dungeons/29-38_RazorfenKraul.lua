local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Razorfen Kraul (southern Barrens) - Horde & Alliance
-- Classic version: quest IDs / NPCs / drops verified against the
-- Questie classic DB. Forever changes will be added as they are known.
-- NPCs "mebok" (17-24_WailingCaverns) and "faranell" (15-20_RuinsOfLordaeron)
-- are defined in other guides.
-- ===================================================================
local function H(extra) local t = extra or {}; t.faction = "Horde"; return t end
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end

-- NPCs (map = uiMapID: 1456 Thunder Bluff, 1444 Feralas, 1441 Thousand Needles, 1457 Darnassus)
N.auld       = { id = 4451, name = "Auld Stonespire",      map = 1456, x = 36.0, y = 59.9 }
N.falfindel  = { id = 4048, name = "Falfindel Waywarder",  map = 1444, x = 89.6, y = 46.6 }
N.treshala   = { id = 4521, name = "Treshala Fallowbrook", map = 1457, x = 69.5, y = 67.8 }
N.heralath   = { id = 4510, name = "Heralath Fallowbrook" } -- inside the Kraul
N.willix     = { id = 4508, name = "Willix the Importer" }  -- inside the Kraul

N.charlga    = { id = 4421, name = "Charlga Razorflank", enemy = true, boss = true }
N.ramtusk    = { id = 4420, name = "Overlord Ramtusk",   enemy = true, boss = true }
N.aggem      = { id = 4424, name = "Aggem Thorncurse",   enemy = true, boss = true }
N.wardguard  = { id = 4427, name = "Ward Guardian",      enemy = true, boss = true }
N.kraulbat   = { id = 4538, name = "Kraul Bat",          enemy = true }
N.gkraulbat  = { id = 4539, name = "Greater Kraul Bat",  enemy = true }

ns:RegisterDungeon("RFK", function() return {
    name = L("Kraal de Tranchebauge", "Razorfen Kraul"),
    levels = "29-38",
    icon = "Interface\\Icons\\INV_Misc_Root_02",
    entrance = { map = 1413, x = 42.9, y = 90.2 },
    titles = {
        [1100] = L("Journal de Lonebrow", "Lonebrow's Journal"),
        [1101] = L("La mégère du Kraal", "The Crone of the Kraul"),
        [1102] = L("Un destin funeste", "A Vengeful Fate"),
        [1109] = L("Corvée de guano", "Going, Going, Guano!"),
        [1142] = L("Le déclin et la mort", "Mortality Wanes"),
        [1144] = L("Willix l’Importateur", "Willix the Importer"),
        [1221] = L("Racines de Feuillebleue", "Blueleaf Tubers"),
    },
    steps = {
        -- Horde pre-quests
        A(1102, "auld", H()),
        A(1109, "faranell", H()),
        -- Alliance pre-quest (Thousand Needles -> Feralas)
        A(1100, nil, AL({ text = L("Lire le journal d'Henrig Lonebrow (Mille pointes)", "Read Henrig Lonebrow's Journal (Thousand Needles)"),
            map = 1441, x = 30.7, y = 24.4 })),
        T(1100, "falfindel", AL()),
        A(1101, "falfindel", AL()),
        -- Ratchet (both factions)
        A(1221, "mebok"),
        -- Inside the Kraul
        D(1221, L("6 tubercules : prendre la caisse, puis utiliser le fouineur", "6 Blueleaf Tubers: take the crate, then use the Snufflenose Gopher")),
        D(1109, L("Guano du Kraal (chauves-souris)", "Kraul Guano (bats)"), H({ targets = { "kraulbat", "gkraulbat" } })),
        A(1142, "heralath", AL()),
        D(1142, L("Pendentif de Treshala (sur un boss du Kraal)", "Treshala's Pendant (from a Kraul boss)"),
            AL({ targets = { "ramtusk", "charlga", "aggem", "wardguard" } })),
        A(1144, "willix"),
        D(1144, L("Escorter Willix l'Importateur hors du Kraal", "Escort Willix the Importer out of the Kraul"), { targets = { "willix" } }),
        T(1144, "willix"),
        D(1102, L("Cœur de Charlga Razorflank", "Razorflank's Heart"), H({ targets = { "charlga" } })),
        D(1101, L("Médaillon de Charlga Razorflank", "Razorflank's Medallion"), AL({ targets = { "charlga" } })),
        -- Turn-ins
        T(1221, "mebok"),
        T(1102, "auld", H()),
        T(1109, "faranell", H()),
        T(1101, "falfindel", AL()),
        T(1142, "treshala", AL()),
    },
} end)
