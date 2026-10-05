local _, ns = ...
local L = ns.L
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Scarlet Monastery - Cathedral - Horde & Alliance (last wing)
-- Classic version, verified against the Questie classic DB.
-- Shared Scarlet data (NPCs, cross-wing quests) is in 30-46_ScarletMonasteryShared.lua.
-- The cross-wing quests are turned in here.
-- ===================================================================
local function H(extra) local t = extra or {}; t.faction = "Horde"; return t end
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end

ns:RegisterDungeon("SMCATH", function() return {
    name = L("Monastère écarlate - Cathédrale", "Scarlet Monastery - Cathedral"),
    levels = "38-46",
    icon = "Interface\\Icons\\Spell_Holy_SealOfWrath",
    entrance = { map = 1420, x = 82.6, y = 33.8 },
    titles = ns.SM.Titles(),
    steps = ns.SM.Join(
        ns.SM.PreSteps(),
        { ns.SM.Hearts() },
        ns.SM.WingSteps({
            { index = 2, key = "mograine", text = L("Tuer le commandant écarlate Mograine", "Kill Scarlet Commander Mograine") },
            { index = 1, key = "whitemane", text = L("Tuer la grande inquisitrice Whitemane", "Kill High Inquisitor Whitemane") },
        }),
        {
            -- Turn-ins (Undercity / Southshore)
            T(1048, "varimathras", H()),
            T(1113, "faranell", H()),
            T(1053, "raleigh", AL()),
        }
    ),
} end)
