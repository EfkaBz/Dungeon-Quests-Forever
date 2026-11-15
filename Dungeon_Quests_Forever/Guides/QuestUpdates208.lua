local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, D = ns.Accept, ns.TurnIn, ns.Do

-- ===================================================================
-- Quests added by DungeonJournal 2.0.8 (Nov 2026), merged into the guides
-- by ns:AddGuideSteps (Core.lua): appended after the existing steps, so the
-- saved checks stay on the right steps.
-- ===================================================================

N.q8_katherine = { id = 0, name = "Katherine the Pure", map = 1453, x = 48.5, y = 49.1, forever = true } -- Cathedral of Light
N.q8_aeonas    = { id = 0, name = "Aeonas" } -- rear chamber of the Cathedral, then the Cathedral of Light

-- Scarlet Monastery: Cathedral - Alliance paladin chain "A Brother In Need"
-- (players' reports: it follows the Strange Orb chain from Darkshore and
-- Katherine's quests from level 35).
local PAL = { faction = "Alliance", class = "PALADIN" }
local function P(extra)
    local t = { faction = PAL.faction, class = PAL.class }
    for k, v in pairs(extra or {}) do t[k] = v end
    return t
end

ns:AddGuideSteps("SMCATH", function() return {
    titles = {
        [79946] = L("Un frère dans le besoin", "A Brother In Need"),
        [79963] = L("Par la grâce de la Lumière", "By The Light's Grace"),
        [79970] = L("Aeonas le Justifié", "Aeonas the Vindicated"),
    },
    groups = {
        { before = nil, steps = {
            A(79946, "q8_katherine", P()),
            T(79946, "q8_aeonas", P({ text = L("Aeonas, salle du fond de la Cathédrale (dans le donjon). Finissez la discussion de Katherine avant de partir",
                "Aeonas, rear chamber of the Cathedral (inside the dungeon). Finish Katherine's talk before you leave") })),
            A(79963, "q8_aeonas", P()),
            D(79963, L("Soigner Aeonas (jusqu'à sa vie pleine)", "Heal Aeonas (to full health)"), P()),
            T(79963, "q8_aeonas", P()),
            A(79970, "q8_aeonas", P()),
            T(79970, "q8_aeonas", P({ text = L("Aeonas, Cathédrale de la Lumière (Hurlevent)", "Aeonas, Cathedral of Light (Stormwind)"),
                map = 1453, x = 48.5, y = 49.1 })),
        } },
    },
} end)
