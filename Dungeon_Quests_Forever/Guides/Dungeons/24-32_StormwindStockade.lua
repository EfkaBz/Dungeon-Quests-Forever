local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- The Stockade (Stormwind City) - Alliance quests
-- Quest IDs / NPCs / drops verified against the Questie classic DB.
-- Forever: 5-player dungeon (was 10 in Classic).
-- NPCs "baros" and "thelwater" are defined in 17-26_Deadmines.lua.
-- ===================================================================
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end

-- NPCs (map = uiMapID: 1453 Stormwind, 1433 Redridge, 1431 Duskwood, 1437 Wetlands)
N.berton     = { id = 859,  name = "Guard Berton",         map = 1433, x = 26.3, y = 46.6 }
N.millstipe  = { id = 270,  name = "Councilman Millstipe", map = 1431, x = 71.9, y = 47.8 }
N.motley     = { id = 1074, name = "Motley Garmason",      map = 1437, x = 49.7, y = 18.2 }
N.nikova     = { id = 1721, name = "Nikova Raskol",        map = 1453, x = 69.9, y = 39.1 }

N.targorr    = { id = 1696, name = "Targorr the Dread",   enemy = true, boss = true }
N.deepfury   = { id = 1666, name = "Kam Deepfury",        enemy = true, boss = true }
N.dextren    = { id = 1663, name = "Dextren Ward",        enemy = true, boss = true }
N.bazil      = { id = 1716, name = "Bazil Thredd",        enemy = true, boss = true }
N.dprisoner  = { id = 1706, name = "Defias Prisoner",     enemy = true }
N.dconvict   = { id = 1711, name = "Defias Convict",      enemy = true }
N.dinsurgent = { id = 1715, name = "Defias Insurgent",    enemy = true }
N.dcaptive   = { id = 1707, name = "Defias Captive",      enemy = true }
N.dinmate    = { id = 1708, name = "Defias Inmate",       enemy = true }
N.didwarf    = { id = 1051, name = "Dark Iron Dwarf",         enemy = true }
N.disaboteur = { id = 1052, name = "Dark Iron Saboteur",      enemy = true }
N.ditunneler = { id = 1053, name = "Dark Iron Tunneler",      enemy = true }
N.didemo     = { id = 1054, name = "Dark Iron Demolitionist", enemy = true }

ns:RegisterDungeon("STOCKS", function() return {
    name = L("Prison de Hurlevent", "The Stockade"),
    levels = "24-32",
    faction = "Alliance", -- inside Stormwind: Horde cannot reach it
    icon = "Interface\\Icons\\INV_Misc_Key_03",
    entrance = { map = 1453, x = 42.3, y = 58.9 }, -- Mage Quarter canal
    titles = {
        [303] = L("La guerre contre les Sombrefer", "The Dark Iron War"),
        [373] = L("La lettre non envoyée", "The Unsent Letter"),
        [377] = L("Crime et Châtiments", "Crime and Punishment"),
        [378] = L("Fureur dans les Profondeurs", "The Fury Runs Deep"),
        [386] = L("Ce qui se passait ailleurs…", "What Comes Around..."),
        [387] = L("Écraser la rébellion", "Quell The Uprising"),
        [388] = L("La couleur du Sang", "The Color of Blood"),
        [389] = L("Bazil Thredd", "Bazil Thredd"),
        [391] = L("Les Emeutes de la Prison", "The Stockade Riots"),
    },
    steps = {
        -- Pre-quest from the Deadmines (letter on Edwin VanCleef)
        A(373, nil, AL({ text = L("Lettre sur Edwin VanCleef (Mortemines)", "Letter from Edwin VanCleef (Deadmines)"),
            map = 1436, x = 42.5, y = 71.7 })),
        T(373, "baros", AL()),
        A(389, "baros", AL()),
        -- Pre-quest in the Wetlands for The Fury Runs Deep
        A(303, "motley", AL()),
        D(303, L("Tuer 10 nains, 5 tunneliers, 5 saboteurs et 5 démolisseurs Sombrefer", "Kill 10 Dark Iron Dwarves, 5 Tunnelers, 5 Saboteurs and 5 Demolitionists"),
            AL({ targets = { "didwarf", "ditunneler", "disaboteur", "didemo" } })),
        T(303, "motley", AL()),
        A(378, "motley", AL()),
        -- Lakeshire, Darkshire, Stormwind
        A(386, "berton", AL()),
        A(377, "millstipe", AL()),
        A(388, "nikova", AL()),
        T(389, "thelwater", AL()),
        A(391, "thelwater", AL()),
        A(387, "thelwater", AL()),
        -- Inside the Stockade
        D(387, L("Tuer 10 prisonniers, 8 bagnards et 8 insurgés défias", "Kill 10 Defias Prisoners, 8 Convicts and 8 Insurgents"),
            AL({ targets = { "dprisoner", "dconvict", "dinsurgent" } })),
        D(388, L("10 bandanas en laine rouge", "10 Red Wool Bandanas"),
            AL({ targets = { "dprisoner", "dcaptive", "dinmate", "dextren" } })),
        D(386, L("Tête de Targorr l'Effroyable", "Head of Targorr the Dread"), AL({ targets = { "targorr" } })),
        D(378, L("Tête de Kam Furie-Profonde", "Head of Kam Deepfury"), AL({ targets = { "deepfury" } })),
        D(377, L("Main de Dextren Ward", "Hand of Dextren Ward"), AL({ targets = { "dextren" } })),
        D(391, L("Tête de Bazil Thredd", "Head of Bazil Thredd"), AL({ targets = { "bazil" } })),
        -- Turn-ins
        T(387, "thelwater", AL()),
        T(391, "thelwater", AL()),
        T(388, "nikova", AL()),
        T(386, "berton", AL()),
        T(377, "millstipe", AL()),
        T(378, "motley", AL()),
    },
} end)
