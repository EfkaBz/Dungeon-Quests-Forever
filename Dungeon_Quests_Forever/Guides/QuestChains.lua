local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T = ns.Accept, ns.TurnIn

-- ===================================================================
-- Chains checked against the Wowhead "Series" lists, warcraft.wiki.gg and
-- Warcraft Tavern: missing steps, and steps that were in the wrong order.
-- { before = quest, move = { quests } } moves existing steps and keeps their
-- uid, so saved manual checks stay valid (see ns:AddGuideSteps).
-- ===================================================================
N.qc_beldin   = { id = 1376,   name = "Beldin Steelgrill",   map = 1426, x = 50.4, y = 49.0, forever = true }
N.qc_avette   = { id = 228,    name = "Avette Fellwood",     map = 1431, x = 73.1, y = 44.6, forever = true }
N.qc_celindra = { id = 252085, name = "Archmage Celindra",   map = 1416, x = 14.2, y = 60.0, forever = true }

local AL = "Alliance"

ns:AddGuideSteps("THANES", function() return {
    titles = {
        [96408] = L("Un visiteur à Dun Morogh", "A Visitor to Dun Morogh"),
    },
    groups = {
        -- Farsen's Watch comes before Nip 'Em in the Bud
        { before = 96390, move = { 96392 } },
        { before = 96392, steps = {
            A(96408, "qc_beldin", { faction = AL, text = L("Facultatif : Beldin Steelgrill, devant Kharanos", "Optional: Beldin Steelgrill, outside Kharanos") }),
            T(96408, "farsen", { faction = AL, text = L("Campement au-dessus de la carrière de Gol'Bolar", "Campsite overlooking the Gol'Bolar Quarry") }),
        } },
    },
} end)

ns:AddGuideSteps("ROL", function() return {
    titles = {
        [95161] = L("Souviens-toi que je t'aime", "Remember That I Love You"),
    },
    groups = {
        -- Unending Torment: the head goes on the body before the serum
        { before = 97291, move = { 97289, 97290 } },
        { steps = {
            A(95161, "nightingale", { faction = AL }),
            T(95161, "qc_avette", { faction = AL, text = L("Avette Fellwood, la fabricante d'arcs de Sombre-Comté", "Avette Fellwood, the bowyer in Darkshire") }),
        } },
    },
} end)

ns:AddGuideSteps("DALARAN", function() return {
    titles = {
        [92459] = L("Ami du Kirin Tor", "Friend of the Kirin Tor"),
        [97287] = L("Négociations habiles", "Shrewd Negotiations"),
    },
    groups = {
        { steps = {
            A(92459, "imodera", { faction = AL }),
            T(92459, "qc_celindra", { faction = AL, text = L("Archimage Celindra, dans la Citadelle pourpre : apporter la parcelle arcanique", "Archmage Celindra, in the Violet Citadel: bring the Arcane Mote") }),
            A(97287, "wordeen", { faction = "Horde" }),
            T(97287, "imodera", { faction = "Horde", text = L("Image de Modera, devant les égouts. N'ouvre pas la ville à la Horde", "Image of Modera, outside the sewers. Does not open the city to the Horde") }),
        } },
    },
} end)
