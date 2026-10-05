local _, ns = ...
local L = ns.L
local A, T = ns.Accept, ns.TurnIn

-- ===================================================================
-- Cozy Sleeping Bag (Season of Discovery chain, also on Forever)
-- ===================================================================
-- Level 14+. Every step is an object (no NPC). Horde starts in the
-- Barrens and goes to Westfall, Alliance does the opposite.
-- Coordinates from the SoD guides, to verify in game.
local function H(extra) local t = extra or {}; t.faction = "Horde"; return t end
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end
local function At(map, x, y, fr, en, extra)
    local t = extra or {}
    t.map, t.x, t.y, t.text = map, x, y, L(fr, en)
    return t
end

local WESTFALL, BARRENS, STONETALON, LOCH, HILLSBRAD = 1436, 1413, 1442, 1432, 1424

ns:RegisterDungeon("SLEEPINGBAG", function() return {
    name = L("Sac de couchage douillet", "Cozy Sleeping Bag"),
    levels = "14-60",
    overworld = true,
    icon = "Interface\Icons\INV_Misc_Bag_08",
    titles = {
        [79007] = L("...et cette note que vous avez trouvée", "...and that note you found"),
        [79008] = L("...et cette note que vous avez trouvée", "...and that note you found"),
        [79192] = L("Pierres de gué", "Stepping Stones"),
        [79980] = L("Bousculade", "Scramble"),
        [79974] = L("Travail humide", "Wet Job"),
        [79975] = L("Poing de l'aigle", "Eagle's Fist"),
        [79976] = L("C'est bien ici", "This Must Be The Place"),
    },
    steps = {
        -- Start: burned-out remains (own faction's continent)
        A(79007, nil, H(At(BARRENS, 46.0, 74.0, "Tarides : Restes calcinés (ruines de la tour brûlée)", "Barrens: Burned-Out Remains (Burnt Tower rubble)"))),
        A(79008, nil, AL(At(WESTFALL, 37.0, 50.0, "Marche de l'Ouest : Restes calcinés (ferme des Alexston)", "Westfall: Burned-Out Remains (Alexston Farmstead)"))),
        -- The twin place on the other continent
        T(79007, nil, H(At(WESTFALL, 37.0, 50.0, "Marche de l'Ouest : planche clouée (ferme des Alexston)", "Westfall: Nailed Plank (Alexston Farmstead)"))),
        T(79008, nil, AL(At(BARRENS, 46.0, 74.0, "Tarides : planche clouée (tour brûlée)", "Barrens: Nailed Plank (Burnt Tower)"))),
        A(79192, nil, H(At(WESTFALL, 37.0, 50.0, "Marche de l'Ouest : planche clouée", "Westfall: Nailed Plank"))),
        A(79192, nil, AL(At(BARRENS, 46.0, 74.0, "Tarides : planche clouée", "Barrens: Nailed Plank"))),
        -- Stonetalon Mountains: hidden camp near Sun Rock Retreat
        T(79192, nil, At(STONETALON, 41.0, 53.0, "Serres-Rocheuses : camp caché (suivre le chemin depuis 51,52), Détritus de poche sur une caisse",
            "Stonetalon: hidden camp (follow the path from 51,52), Pocket Litter on a crate")),
        A(79980, nil, At(STONETALON, 41.0, 53.0, "Serres-Rocheuses : Détritus de poche", "Stonetalon: Pocket Litter")),
        T(79980, nil, At(STONETALON, 39.0, 49.0, "Sauter de la falaise au nord-est : Monticule de terre", "Jump off the cliff to the northeast: Mound of Dirt")),
        A(79974, nil, At(STONETALON, 39.0, 49.0, "Serres-Rocheuses : Monticule de terre", "Stonetalon: Mound of Dirt")),
        -- Loch Modan: Stonewrought Dam
        T(79974, nil, At(LOCH, 40.7, 15.3, "Loch Modan : entrer dans le barrage (68,44 par l'intérieur) et sauter côté nord jusqu'au nid de tireur, Figurine sculptée",
            "Loch Modan: enter the Stonewrought Dam and drop on the north side to the sniper nest, Carved Figurine")),
        A(79975, nil, At(LOCH, 40.7, 15.3, "Loch Modan : Figurine sculptée", "Loch Modan: Carved Figurine")),
        -- Hillsbrad: Thoradin's Wall
        T(79975, nil, At(HILLSBRAD, 87.0, 47.0, "Contreforts de Hautebrande (mur de Thoradin) : charrette, rochers, brèche du mur, couloir : Sacoche de messager",
            "Hillsbrad (Thoradin's Wall): cart, rocks, broken wall, hallway: Messenger Bag")),
        A(79976, nil, At(HILLSBRAD, 87.0, 47.0, "Hautebrande : Sacoche de messager", "Hillsbrad: Messenger Bag")),
        T(79976, nil, At(HILLSBRAD, 87.0, 47.0, "Sacoche roulée à la hâte : Sac de couchage douillet !", "Hastily Rolled-Up Satchel: Cozy Sleeping Bag!")),
    },
} end)
