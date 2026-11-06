local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Attunement: Molten Core (Attunement to the Core)
-- Quest ID / NPC verified against the Questie classic DB.
-- ===================================================================
N.att_lothos = { id = 14387, name = "Lothos Riftwaker", map = 1427, x = 34.8, y = 85.3 } -- in Blackrock Mountain

ns:RegisterDungeon("ATT_MC", function() return {
    name = L("Cœur du Magma", "Molten Core"),
    levels = "55-60",
    attunement = true, order = 2,
    final = 7848,
    icon = "Interface\\Icons\\Spell_Fire_LavaSpawn",
    art = "Interface\\Glues\\LoadingScreens\\LoadScreenMoltenCore", artCoord = { 0.02, 0.98, 0.24, 0.82 },
    entrance = { map = 1427, x = 34.8, y = 85.3 }, -- Blackrock Mountain
    titles = {
        [7848] = L("Harmonisation avec le Cœur", "Attunement to the Core"),
    },
    steps = {
        A(7848, "att_lothos"),
        D(7848, L("Fragment du Cœur : près du portail du Cœur du Magma, au fond des profondeurs de Rochenoire",
                  "Core Fragment: near the Molten Core portal, deep in Blackrock Depths")),
        T(7848, "att_lothos"),
    },
} end)
