local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Attunement: Upper Blackrock Spire key (Seal of Ascension)
-- Quest IDs / NPCs verified against the Questie classic DB.
-- Needed for Blackwing Lair and the Onyxia attunement (General Drakkisath).
-- ===================================================================
-- Blackrock Mountain NPCs: placed at the mountain entrance (Searing Gorge side)
N.att_vaelan     = { id = 10296, name = "Vaelan", map = 1427, x = 34.8, y = 85.3 }
N.att_emberstrife = { id = 10321, name = "Emberstrife", map = 1445, x = 56.7, y = 87.7 }
N.att_grunt      = { id = 9043, name = "Scarshield Grunt",     enemy = true }
N.att_sentry     = { id = 9044, name = "Scarshield Sentry",    enemy = true }
N.att_omokk      = { id = 9196, name = "Highlord Omokk",       enemy = true, boss = true }
N.att_voone      = { id = 9237, name = "War Master Voone",     enemy = true, boss = true }
N.att_wyrmthalak = { id = 9568, name = "Overlord Wyrmthalak",  enemy = true, boss = true }

ns:RegisterDungeon("ATT_UBRS", function() return {
    name = L("Clé du pic Rochenoire supérieur", "Upper Blackrock Spire key"),
    levels = "57-60",
    attunement = true, order = 1,
    final = 4743, -- Seal of Ascension (the key)
    icon = "Interface\\Icons\\INV_Jewelry_Ring_01",
    art = "Interface\\Glues\\LoadingScreens\\LoadScreenBlackrockSpire", artCoord = { 0.02, 0.98, 0.24, 0.82 },
    entrance = { map = 1427, x = 34.8, y = 85.3 }, -- Blackrock Mountain
    titles = {
        [4742] = L("Sceau d'ascension", "Seal of Ascension"),
        [4743] = L("Sceau d'ascension", "Seal of Ascension"),
    },
    steps = {
        A(4742, "att_vaelan"),
        D(4742, L("Sceau d'ascension sans ornement (gardes Scarshield, pic Rochenoire inférieur)",
                  "Unadorned Seal of Ascension (Scarshield guards, Lower Blackrock Spire)"),
            { targets = { "att_grunt", "att_sentry" } }),
        D(4742, L("Les 3 gemmes : Highlord Omokk, War Master Voone, Overlord Wyrmthalak (pic Rochenoire inférieur)",
                  "The 3 gemstones: Highlord Omokk, War Master Voone, Overlord Wyrmthalak (Lower Blackrock Spire)"),
            { targets = { "att_omokk", "att_voone", "att_wyrmthalak" } }),
        T(4742, "att_vaelan"),
        A(4743, "att_vaelan"),
        D(4743, L("Emberstrife (Wyrmbog, marécage d'Âprefange) : l'affaiblir, poser le sceau non forgé, utiliser l'orbe d'énergie draconique",
                  "Emberstrife (Wyrmbog, Dustwallow Marsh): weaken him, place the Unforged Seal, use the Orb of Draconic Energy"),
            { map = 1445, x = 56.7, y = 87.7, targets = { "att_emberstrife" } }),
        T(4743, "att_vaelan"),
    },
} end)
