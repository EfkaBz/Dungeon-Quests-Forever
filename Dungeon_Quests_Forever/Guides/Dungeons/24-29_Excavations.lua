local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Excavation Site: Wetlands (24-29) - WoW Forever
-- New Forever dungeon (opened on the beta 2026-10-01, not in Questie).
-- Data from foreverchanges.pro, warcrafttavern.com, wowforever.be,
-- zockify.com, accountshark.net and mmonster.co (beta data, may change).
-- To verify in game: entrance position, NPC IDs and positions.
-- ===================================================================
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end
local function HO(extra) local t = extra or {}; t.faction = "Horde"; return t end

-- NPCs (map = uiMapID: 1437 Wetlands, 1433 Redridge, 1455 Ironforge,
-- 1454 Orgrimmar, 1456 Thunder Bluff, 1417 Arathi Highlands, 1440 Ashenvale)
N.rethiel   = { id = 0,    name = L("Rethiel la Gardeverte", "Rethiel the Greenwarden"), map = 1437, x = 56.2, y = 40.6 }
N.dorin     = { id = 0,    name = "Dorin Songblade",          map = 1433, x = 25.6, y = 46.6 }
N.daewyn    = { id = 0,    name = "Daewyn Songblade" }        -- body inside the dungeon
N.whelgar   = { id = 1077, name = "Prospector Whelgar",       map = 1437, x = 38.8, y = 52.2 }
N.magellas  = { id = 5387, name = "High Explorer Magellas",   map = 1455, x = 69.9, y = 18.4 }
N.borstan   = { id = 0,    name = "Borstan",                  map = 1454, x = 57.3, y = 53.3 } -- The Drag, upstairs with the cooking trainer
N.zaruk     = { id = 0,    name = "Zaruk",                    map = 1417, x = 74.4, y = 35.6 } -- Hammerfall
N.dsagent   = { id = 0,    name = "Deathstalker Agent",       map = 1437, x = 51.4, y = 59.2 } -- hills above the Dragonmaw camp
N.llana     = { id = 0,    name = "Llana",                    map = 1440, x = 35.0, y = 48.5 } -- Astranaar
N.caitlin   = { id = 0,    name = "Caitlin Grassman",         map = 1437, x = 11.9, y = 58.8 } -- Menethil Harbor
N.halloran  = { id = 0,    name = "James Halloran",           map = 1437, x = 8.6,  y = 55.7 } -- Menethil Harbor
N.ardin     = { id = 0,    name = "Ardin Grassman" }          -- inside the dungeon, near the Site of the Guardian
N.bashana   = { id = 9087, name = "Bashana Runetotem",        map = 1456, x = 70.8, y = 33.8 }
N.muln      = { id = 259118, name = "Muln Earthfury",          map = 1412, x = 33.4, y = 22.5, forever = true } -- Skywatcher Plateau, Mulgore

N.saltspine = { id = 0, name = "Saltspine",       enemy = true, boss = true }
N.shadetooth = { id = 0, name = "Shadetooth",     enemy = true, boss = true }
N.thicket   = { id = 0, name = "Thicket Hunter",  enemy = true }
N.hhorror   = { id = 0, name = "Highland Horror", enemy = true, boss = true }
N.rguardian = { id = 0, name = "Relic Guardian",  enemy = true, boss = true }

ns:RegisterDungeon("EXCAV", function() return {
    name = L("Site de fouilles : les Paluns", "Excavation Site: Wetlands"),
    levels = "26-33",
    new = true, -- new in Forever
    icon = "Interface\\Icons\\INV_Misc_Shovel_01",
    entrance = { map = 1437, x = 47.8, y = 56.3 }, -- hilltop above Whelgar's Excavation (to verify)
    titles = {
        [95646] = L("Horreurs des hautes terres", "Horrors in the Highland"),
        [95772] = L("À la recherche de Songblade", "Songblade Search"),
        [95737] = L("À la recherche de Caitlin", "Seeking Caitlin"),
        [95647] = L("Perdu dans les fourrés", "Lost in the Thicket Things"),
        [95809] = L("Cœur tissé", "Heartwoven"),
        [98815] = L("Peaux des hautes terres", "Highland Hides"),
        [95663] = L("Rumeurs sur les Gueule-de-dragon", "Dragonmaw Rumors"),
        [95795] = L("Tombé dans la tourbière", "Fallen in the Fen"),
        [95810] = L("Une relique perdue", "Lost Relic Carry"),
        [98824] = L("Le prisme préhistorique", "Prehistoric Prism"),
        [95697] = L("Les goûts changent", "Changing Tastes"),
        [95682] = L("Ouvrir la gueule", "Open the Maw"),
        [95664] = L("Le savoir des anciens", "Elder Knowledge"),
        [98823] = L("L'écho de la terre", "Earthen Echo"),
    },
    steps = {
        -- Before the dungeon (Alliance)
        A(95772, "dorin", AL()),
        A(95737, "llana", AL({ text = L("Facultatif : Llana à Astranaar envoie voir Caitlin", "Optional: Llana in Astranaar sends you to Caitlin") })),
        T(95737, "caitlin", AL()),
        A(95647, "caitlin", AL()),
        A(98815, "halloran", AL({ text = L("James Halloran (nécessite « Peaux de jeunes crocilisques »)", "James Halloran (needs Young Crocolisk Skins done)") })),
        A(95646, "rethiel", AL()),
        -- Before the dungeon (Horde): Orgrimmar, then Hammerfall -> Wetlands
        A(95697, "borstan", HO()),
        A(95663, "zaruk", HO()),
        T(95663, "dsagent", HO()),
        A(95682, "dsagent", HO()),
        -- Inside the dungeon
        D(95697, L("4 viandes de raptor des fourrés (Shadetooth et raptors)", "4 Thicket Raptor Meat (Shadetooth and raptors)"),
            HO({ targets = { "shadetooth", "thicket" } })),
        D(95682, L("Tuer 2 saboteurs et 4 gardiens Gueule-de-dragon. Dépêche : sur un thaumaturge Gueule-de-dragon", "Kill 2 Dragonmaw Saboteurs and 4 Dragonmaw Warders. Dispatch: from a Dragonmaw Thaumaturgist"), HO()),
        D(98815, L("4 peaux de raptor des fourrés (raptors près de Shadetooth)", "4 Thicket Raptor Hides (raptors near Shadetooth)"),
            AL({ targets = { "shadetooth", "thicket" } })),
        T(95772, nil, AL({ text = L("Corps de Daewyn Songblade : tente du camp Gueule-de-dragon, juste après Shadetooth", "Daewyn Songblade's body: tent in the Dragonmaw camp, just after Shadetooth") })),
        A(95795, "daewyn", AL({ text = L("Corps de Daewyn Songblade : tente du camp Gueule-de-dragon, juste après Shadetooth", "Daewyn Songblade's body: tent in the Dragonmaw camp, just after Shadetooth") })),
        T(95647, nil, AL({ text = L("Ardin Grassman, sur la structure en bois près du Site du Gardien", "Ardin Grassman, on the wooden structure near the Site of the Guardian") })),
        A(95809, nil, AL({ text = L("Ardin Grassman, sur la structure en bois près du Site du Gardien", "Ardin Grassman, on the wooden structure near the Site of the Guardian") })),
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
        T(95809, "caitlin", AL()),
        T(98815, "halloran", AL()),
        T(95697, "borstan", HO()),
        T(95664, "bashana", HO()),
        A(98823, "bashana", HO()),
        T(98823, "muln", HO({ text = L("Plus grande tente du plateau Skywatcher (Mulgore) : chemin de montagne au nord des Pitons (40.3, 17.6)", "Largest tent on the Skywatcher Plateau (Mulgore): mountain path north of Thunder Bluff (40.3, 17.6)") })),
    },
} end)
