local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Shadowfang Keep (Silverpine Forest) - Horde quests
-- Quest IDs / NPCs / drops verified against the Questie classic DB.
-- ===================================================================
local function H(extra) local t = extra or {}; t.faction = "Horde"; return t end

-- NPCs (map = uiMapID: 1421 Silverpine, 1458 Undercity)
N.hadrec    = { id = 1952, name = "High Executor Hadrec", map = 1421, x = 43.4, y = 40.9 }
N.dalar     = { id = 1938, name = "Dalar Dawnweaver",     map = 1421, x = 44.2, y = 39.8 }
N.beldugur  = { id = 2934, name = "Keeper Bel'dugur",     map = 1458, x = 53.7, y = 54.5 }
N.vincent   = { id = 4444, name = "Deathstalker Vincent" } -- inside the keep
N.adamant   = { id = 3849, name = "Deathstalker Adamant" } -- prisoner inside
N.arugal    = { id = 4275, name = "Archmage Arugal", enemy = true, boss = true }

ns:RegisterDungeon("SFK", function() return {
    name = L("Donjon d'Ombrecroc", "Shadowfang Keep"),
    levels = "22-30",
    icon = "Interface\\Icons\\Spell_Shadow_Charm",
    entrance = { map = 1421, x = 44.8, y = 67.8 },
    titles = {
        [1098] = L("Des Traqueurs noirs à Ombrecroc", "Deathstalkers in Shadowfang"),
        [1014] = L("Arugal doit mourir", "Arugal Must Die"),
        [1013] = L("Le Livre d'Ur", "The Book of Ur"),
    },
    steps = {
        -- The Sepulcher / Undercity
        A(1098, "hadrec", H()),
        A(1014, "dalar", H()),
        A(1013, "beldugur", H()),
        -- In the dungeon
        T(1098, "vincent", H({ text = L("Trouver les Nécrorateurs Adamant et Vincent", "Find Deathstalkers Adamant and Vincent") })),
        D(1013, L("Le livre d'Ur (dans la bibliothèque)", "The Book of Ur (in the library)"), H()),
        D(1014, L("Tuer l'archimage Arugal : sa tête", "Kill Archmage Arugal: his head"), H({ targets = { "arugal" } })),
        -- Turn-ins
        T(1014, "dalar", H()),
        T(1013, "beldugur", H()),
    },
} end)
