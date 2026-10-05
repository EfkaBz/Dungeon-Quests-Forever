local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- The Deadmines (Westfall) - Alliance quests only
-- Quest IDs / NPCs / drops verified against the Questie classic DB.
-- ===================================================================
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end

-- NPCs (map = uiMapID: 1436 Westfall, 1433 Redridge, 1453 Stormwind)
N.gryan      = { id = 234,  name = "Gryan Stoutmantle",   map = 1436, x = 56.3, y = 47.5 }
N.wiley      = { id = 266,  name = "Wiley the Black",     map = 1433, x = 26.5, y = 45.4 }
N.shaw       = { id = 332,  name = "Master Mathias Shaw", map = 1453, x = 75.8, y = 59.8 }
N.traitor    = { id = 467,  name = "The Defias Traitor",  map = 1436, x = 55.7, y = 47.5 }
N.riell      = { id = 820,  name = "Scout Riell",         map = 1436, x = 56.7, y = 47.4 }
N.wilder     = { id = 656,  name = "Wilder Thistlenettle", map = 1453, x = 65.4, y = 21.2 }
N.shoni      = { id = 6579, name = "Shoni the Shilent",   map = 1453, x = 55.5, y = 12.5 }
N.baros      = { id = 1646, name = "Baros Alexston",      map = 1453, x = 49.2, y = 30.3 }
N.thelwater  = { id = 1719, name = "Warden Thelwater",    map = 1453, x = 41.1, y = 58.1 }

N.messenger  = { id = 550, name = "Defias Messenger",      enemy = true }
N.vancleef   = { id = 639, name = "Edwin VanCleef",        enemy = true, boss = true }
N.foreman    = { id = 626, name = "Foreman Thistlenettle", enemy = true, boss = true }
N.shredder   = { id = 642, name = "Sneed's Shredder",      enemy = true, boss = true }
N.skminer    = { id = 623, name = "Skeletal Miner",        enemy = true }
N.excavator  = { id = 624, name = "Undead Excavator",      enemy = true }
N.dynamiter  = { id = 625, name = "Undead Dynamiter",      enemy = true }
N.henchman   = { id = 594, name = "Defias Henchman",       enemy = true }
N.dminer     = { id = 598, name = "Defias Miner",          enemy = true }
N.conjurer   = { id = 619, name = "Defias Conjurer",       enemy = true }
N.overseer   = { id = 634, name = "Defias Overseer",       enemy = true }

ns:RegisterDungeon("DM", function() return {
    name = L("Les Mortemines", "The Deadmines"),
    levels = "17-26",
    icon = "Interface\\Icons\\INV_Misc_Bandana_03",
    entrance = { map = 1436, x = 42.5, y = 71.7 }, -- Moonbrook
    titles = {
        [65] = L("La Confrérie défias", "The Defias Brotherhood"), [132] = L("La Confrérie défias", "The Defias Brotherhood"),
        [135] = L("La Confrérie défias", "The Defias Brotherhood"), [141] = L("La Confrérie défias", "The Defias Brotherhood"),
        [142] = L("La Confrérie défias", "The Defias Brotherhood"), [155] = L("La Confrérie défias", "The Defias Brotherhood"),
        [166] = L("La Confrérie défias", "The Defias Brotherhood"),
        [167] = L("Adieu mon frère…", "Oh Brother. . ."),
        [168] = L("À la recherche de Cartes du Syndicat des Mineurs", "Collecting Memories"),
        [214] = L("Les masques rouges en soie", "Red Silk Bandanas"),
        [2040] = L("Assaut souterrain", "Underground Assault"),
        [373] = L("La lettre non envoyée", "The Unsent Letter"),
        [389] = L("Bazil Thredd", "Bazil Thredd"),
    },
    steps = {
        -- The Defias Brotherhood chain (Westfall / Redridge / Stormwind)
        A(65, "gryan", AL()),
        T(65, "wiley", AL()),
        A(132, "wiley", AL()),
        T(132, "gryan", AL()),
        A(135, "gryan", AL()),
        T(135, "shaw", AL()),
        A(141, "shaw", AL()),
        T(141, "gryan", AL()),
        A(142, "gryan", AL()),
        D(142, L("Tuer le messager défias (il patrouille)", "Kill the Defias Messenger (he patrols)"), AL({ targets = { "messenger" } })),
        T(142, "gryan", AL()),
        A(155, "traitor", AL()),
        D(155, L("Escorter le traître défias jusqu'à Ruisselune", "Escort the Defias Traitor to Moonbrook"), AL({ map = 1436, x = 42.5, y = 71.7 })),
        T(155, "gryan", AL()),
        A(166, "gryan", AL()),
        A(214, "riell", AL()),
        -- Stormwind
        A(167, "wilder", AL()),
        A(168, "wilder", AL()),
        A(2040, "shoni", AL()),
        -- In the dungeon
        D(168, L("4 cartes du syndicat des mineurs (morts-vivants)", "4 Miners' Union Cards (undead miners)"),
            AL({ targets = { "skminer", "excavator", "dynamiter" } })),
        D(214, L("10 bandanas en soie rouge (Défias)", "10 Red Silk Bandanas (Defias)"),
            AL({ targets = { "henchman", "dminer", "conjurer", "overseer" } })),
        D(167, L("Badge : tuer le contremaître Thistlenettle", "Badge: kill Foreman Thistlenettle"), AL({ targets = { "foreman" } })),
        D(2040, L("Engrenage : tuer le déchiqueteur de Sneed", "Sprocket: kill Sneed's Shredder"), AL({ targets = { "shredder" } })),
        D(166, L("Tuer Edwin VanCleef : sa tête", "Kill Edwin VanCleef: his head"), AL({ targets = { "vancleef" } })),
        A(373, nil, AL({ text = L("VanCleef : ramasser la lettre (lance « La lettre jamais envoyée »)", "VanCleef: loot the letter (starts The Unsent Letter)"),
            targets = { "vancleef" } })),
        -- Turn-ins
        T(214, "riell", AL()),
        T(166, "gryan", AL()),
        T(373, "baros", AL()),
        A(389, "baros", AL()),
        T(389, "thelwater", AL()),
        T(167, "wilder", AL()),
        T(168, "wilder", AL()),
        T(2040, "shoni", AL()),
    },
} end)
