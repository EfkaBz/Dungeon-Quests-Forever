local _, ns = ...
local L = ns.L
local A, T = ns.Accept, ns.TurnIn

-- ===================================================================
-- Night Watchman's Torch (Duskwood, Raven Hill) - Forever only
-- ===================================================================
-- "An Unfortunate End" (98372): slain Night Watch Guard behind the
-- biggest house of Raven Hill, next to the outhouse. The corpse is not
-- always there: wait for it to respawn. Reward: Night Watchman's Torch
-- (toy, item 280612). Coordinates approximate, to verify in game.
local SPOT = { map = 1431, x = 18.0, y = 58.5 }

ns:RegisterDungeon("TORCH", function() return {
    name = L("Torche du veilleur de nuit", "Night Watchman's Torch"),
    levels = "10-60",
    overworld = true,
    new = true,
    icon = "Interface\Icons\INV_Torch_Lit",
    entrance = SPOT,
    titles = {
        [98372] = L("Une fin malheureuse", "An Unfortunate End"),
    },
    steps = {
        A(98372, nil, { text = L("Colline des Corbeaux : cadavre du garde de la Garde de nuit, derrière la grande maison près des latrines",
            "Raven Hill: slain Night Watch Guard corpse, behind the biggest house next to the outhouse"),
            map = SPOT.map, x = SPOT.x, y = SPOT.y }),
        T(98372, nil, { text = L("Rendre la quête : récompense Torche du veilleur de nuit (jouet)",
            "Turn in: reward Night Watchman's Torch (toy)"),
            map = SPOT.map, x = SPOT.x, y = SPOT.y }),
    },
} end)
