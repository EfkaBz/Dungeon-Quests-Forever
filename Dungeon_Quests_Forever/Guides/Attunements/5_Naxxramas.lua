local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Attunement: Naxxramas (The Dread Citadel)
-- Quest IDs / NPC verified against the Questie classic DB:
--   9121 Honored, 9122 Revered, 9123 Exalted with the Argent Dawn.
-- Any one of them grants the access (hidden flag quest 9378).
-- To verify at launch: Naxxramas on Forever.
-- ===================================================================
N.att_angela = { id = 16116, name = "Archmage Angela Dosantos", map = 1423, x = 81.5, y = 58.3 } -- Light's Hope Chapel

ns:RegisterDungeon("ATT_NAXX", function() return {
    name = "Naxxramas",
    levels = "60",
    attunement = true, order = 5,
    final = { 9378, 9121, 9122, 9123 },
    icon = "Interface\\Icons\\INV_Trinket_Naxxramas06",
    art = "Interface\\Glues\\LoadingScreens\\LoadScreenNaxxramas", artCoord = { 0.02, 0.98, 0.24, 0.82 },
    titles = {
        [9378] = L("La citadelle de l'effroi - Naxxramas", "The Dread Citadel - Naxxramas"),
        [9121] = L("La citadelle de l'effroi - Naxxramas", "The Dread Citadel - Naxxramas"),
    },
    steps = {
        D(9378, L("Réputation Aube d'argent : au moins Honoré (le prix baisse à Révéré, gratuit à Exalté)",
                  "Argent Dawn reputation: at least Honored (cheaper at Revered, free at Exalted)"),
            { map = 1423, x = 81.5, y = 58.3 }),
        D(9378, L("Honoré : 5 cristaux arcaniques, 2 cristaux du Néant, 1 orbe de piété, 60 po - Révéré : 2 cristaux arcaniques, 1 cristal du Néant, 30 po",
                  "Honored: 5 Arcane Crystals, 2 Nexus Crystals, 1 Righteous Orb, 60 gold - Revered: 2 Arcane Crystals, 1 Nexus Crystal, 30 gold"),
            { map = 1423, x = 81.5, y = 58.3 }),
        T(9378, "att_angela", { text = L("Archimage Angela Dosantos (chapelle de l'Espoir de Lumière) : obtenir l'accès",
                                         "Archmage Angela Dosantos (Light's Hope Chapel): get the attunement") }),
    },
} end)
