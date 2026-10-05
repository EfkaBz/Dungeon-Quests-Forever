local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Excavation Site: Wetlands (24-29) - WoW Forever
-- New Forever dungeon (opened on the beta 2026-10-01, not in Questie).
-- Data from foreverchanges.pro, zockify.com, accountshark.net and
-- mmonster.co (beta data, may change).
-- To verify in game: entrance position, NPC IDs/positions, and the IDs
-- of the quests not listed yet: Highland Hides (James Halloran),
-- Songblade Search (pre-quest of Fallen in the Fen), Seeking Caitlin >
-- Lost in the Thicket Things > Heartwoven, Dragonmaw Rumors (Zaruk).
-- ===================================================================
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end
local function HO(extra) local t = extra or {}; t.faction = "Horde"; return t end

-- NPCs (map = uiMapID: 1437 Wetlands, 1433 Redridge, 1455 Ironforge,
-- 1454 Orgrimmar, 1456 Thunder Bluff)
N.rethiel   = { id = 0,    name = L("Rethiel la Gardeverte", "Rethiel the Greenwarden"), map = 1437, x = 56.2, y = 40.6 }
N.dorin     = { id = 0,    name = "Dorin Songblade",          map = 1433, x = 25.6, y = 46.6 }
N.daewyn    = { id = 0,    name = "Daewyn Songblade" }        -- body inside the dungeon
N.whelgar   = { id = 1077, name = "Prospector Whelgar",       map = 1437, x = 38.8, y = 52.2 }
N.magellas  = { id = 2912, name = "High Explorer Magellas",   map = 1455, x = 69.9, y = 18.4 }
N.borstan   = { id = 0,    name = "Borstan" }                 -- Orgrimmar (position to verify)
N.dsagent   = { id = 0,    name = "Deathstalker Agent" }      -- outside, above the Dragonmaw camp
N.bashana   = { id = 2986, name = "Bashana Runetotem",        map = 1456, x = 70.8, y = 33.8 }
N.muln      = { id = 3046, name = "Muln Earthfury",           map = 1456, x = 78.6, y = 28.6 }

N.saltspine = { id = 0, name = "Saltspine",       enemy = true, boss = true }
N.shadetooth = { id = 0, name = "Shadetooth",     enemy = true, boss = true }
N.thicket   = { id = 0, name = "Thicket Hunter",  enemy = true }
N.hhorror   = { id = 0, name = "Highland Horror", enemy = true, boss = true }
N.rguardian = { id = 0, name = "Relic Guardian",  enemy = true, boss = true }

ns:RegisterDungeon("EXCAV", function() return {
    name = L("Site de fouilles : les Paluns", "Excavation Site: Wetlands"),
    levels = "24-29",
    new = true, -- new in Forever
    icon = "Interface\\Icons\\INV_Misc_Shovel_01",
    entrance = { map = 1437, x = 47.8, y = 56.3 }, -- hilltop above Whelgar's Excavation (to verify)
    titles = {
        [95646] = L("Horreurs des hautes terres", "Horrors in the Highland"),
        [95795] = L("Tombé dans la tourbière", "Fallen in the Fen"),
        [95810] = L("Une relique perdue", "Lost Relic Carry"),
        [98824] = L("Le prisme préhistorique", "Prehistoric Prism"),
        [95697] = L("Les goûts changent", "Changing Tastes"),
        [95682] = L("Ouvrir la gueule", "Open the Maw"),
        [95664] = L("Le savoir des anciens", "Elder Knowledge"),
        [98823] = L("L'écho de la terre", "Earthen Echo"),
    },
    steps = {
        -- Before the dungeon
        A(95646, "rethiel", AL()),
        A(95697, "borstan", HO()),
        A(95682, "dsagent", HO()),
        -- Inside the dungeon
        D(95697, L("4 viandes de raptor des fourrés (Shadetooth et raptors)", "4 Thicket Raptor Meat (Shadetooth and raptors)"),
            HO({ targets = { "shadetooth", "thicket" } })),
        D(95682, L("Dépêche Gueule-de-dragon (forces Gueule-de-dragon)", "Dragonmaw Dispatch (Dragonmaw forces)"), HO()),
        A(95795, "daewyn", AL({ text = L("Corps de Daewyn Songblade, dans le donjon", "Daewyn Songblade's body, inside the dungeon") })),
        D(95646, L("Cœur-racine horrible (Highland Horror)", "Horrible Rootcore (Highland Horror)"), AL({ targets = { "hhorror" } })),
        A(95810, nil, AL({ text = L("Relique titanesque : sur le Gardien des reliques (activer le panneau)", "Titan Relic: from the Relic Guardian (click the panel)"),
            targets = { "rguardian" } })),
        A(95664, nil, HO({ text = L("Relique titanesque : sur le Gardien des reliques (activer le panneau)", "Titan Relic: from the Relic Guardian (click the panel)"),
            targets = { "rguardian" } })),
        T(95682, "dsagent", HO()),
        -- Turn-ins
        T(95646, "rethiel", AL()),
        T(95810, "whelgar", AL()),
        A(98824, "whelgar", AL()),
        T(98824, "magellas", AL()),
        T(95795, "dorin", AL()),
        T(95697, "borstan", HO()),
        T(95664, "bashana", HO()),
        A(98823, "bashana", HO()),
        T(98823, "muln", HO()),
    },
} end)
