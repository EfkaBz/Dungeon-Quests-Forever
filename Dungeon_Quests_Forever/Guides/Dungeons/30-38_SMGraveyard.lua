local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Scarlet Monastery - Graveyard - Horde quest
-- Classic version, verified against the Questie classic DB.
-- Shared Scarlet data (NPCs, cross-wing quests) is in 30-46_ScarletMonasteryShared.lua.
-- ===================================================================
local function H(extra) local t = extra or {}; t.faction = "Horde"; return t end

ns:RegisterDungeon("SMGY", function() return {
    name = L("Monastère écarlate - Cimetière", "Scarlet Monastery - Graveyard"),
    levels = "30-38",
    icon = "Interface\\Icons\\Spell_Holy_HolyBolt",
    entrance = { map = 1420, x = 82.6, y = 33.8 },
    titles = ns.SM.Titles({
        [1051] = L("La vengeance de Vorrel", "Vorrel's Revenge"),
    }),
    steps = ns.SM.Join(
        ns.SM.PreSteps(),
        {
            -- Inside the Graveyard
            A(1051, "vorrel", H()),
            ns.SM.Hearts(),
            -- Alterac Mountains, then Tarren Mill
            D(1051, L("Alliance de Vorrel : tuer Nancy Vishas (montagnes d'Alterac)", "Vorrel's Wedding Ring: kill Nancy Vishas (Alterac Mountains)"),
                H({ map = 1416, x = 32.3, y = 32.8, targets = { "nancy" } })),
            T(1051, "monika", H()),
            T(1113, "faranell", H()),
        }
    ),
} end)
