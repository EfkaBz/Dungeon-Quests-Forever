local _, ns = ...
local L = ns.L
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Scarlet Monastery - Armory - Horde & Alliance
-- Classic version, verified against the Questie classic DB.
-- Shared Scarlet data (NPCs, cross-wing quests) is in 30-46_ScarletMonasteryShared.lua.
-- ===================================================================
local function H(extra) local t = extra or {}; t.faction = "Horde"; return t end

ns:RegisterDungeon("SMARM", function() return {
    name = L("Monastère écarlate - Armurerie", "Scarlet Monastery - Armory"),
    levels = "36-44",
    icon = "Interface\\Icons\\INV_Axe_12",
    entrance = { map = 1420, x = 82.6, y = 33.8 },
    titles = ns.SM.Titles(),
    steps = ns.SM.Join(
        ns.SM.PreSteps(),
        { ns.SM.Hearts() },
        ns.SM.WingSteps({
            { index = 3, key = "herod", text = L("Tuer Herod, le champion écarlate", "Kill Herod, the Scarlet Champion") },
        }),
        { T(1113, "faranell", H()) }
    ),
} end)
