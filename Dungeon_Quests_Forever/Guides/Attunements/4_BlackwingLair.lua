local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Attunement: Blackwing Lair (Blackhand's Command)
-- Quest ID / NPCs verified against the Questie classic DB.
-- Needs the Upper Blackrock Spire key (General Drakkisath is in UBRS).
-- ===================================================================
N.att_quartermaster = { id = 9046,  name = "Scarshield Quartermaster", enemy = true } -- Blackrock Mountain, near the LBRS entrance
N.att_drakkisath    = N.att_drakkisath or { id = 10363, name = "General Drakkisath", enemy = true, boss = true }

ns:RegisterDungeon("ATT_BWL", function() return {
    name = L("Repaire de l'Aile noire", "Blackwing Lair"),
    levels = "55-60",
    attunement = true, order = 4,
    final = 7761,
    icon = "Interface\\Icons\\INV_Misc_Head_Dragon_Black",
    art = "Interface\\Glues\\LoadingScreens\\LoadScreenBlackwingLair", artCoord = { 0.02, 0.98, 0.24, 0.82 },
    entrance = { map = 1427, x = 34.8, y = 85.3 }, -- Blackrock Mountain
    titles = {
        [7761] = "Blackhand's Command",
    },
    steps = {
        A(7761, nil, { text = L("Ordre de Main-Noire : sur le Scarshield Quartermaster (mont Rochenoire, près de l'entrée du pic inférieur)",
                                "Blackhand's Command: from the Scarshield Quartermaster (Blackrock Mountain, near the Lower Spire entrance)"),
            map = 1427, x = 34.8, y = 85.3, targets = { "att_quartermaster" } }),
        D(7761, L("Tuer General Drakkisath (pic Rochenoire supérieur, clé nécessaire)", "Kill General Drakkisath (Upper Blackrock Spire, key needed)"),
            { targets = { "att_drakkisath" } }),
        T(7761, nil, { text = L("Toucher la Marque de Drakkisath, derrière lui (marque de Drakkisath obtenue)",
                                "Touch Drakkisath's Brand, behind him (you get the Mark of Drakkisath)") }),
    },
} end)
