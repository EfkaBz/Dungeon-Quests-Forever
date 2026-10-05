local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Scarlet Monastery (Tirisfal Glades) - SHARED data for the 4 wings
-- (NPCs + cross-wing quests). Loaded before the 4 wing guides.
-- Classic version: quest IDs / NPCs / drops verified against the
-- Questie classic DB. Forever changes will be added as they are known.
--
-- Some quests need bosses from several wings:
--   Into the Scarlet Monastery (H) / In the Name of the Light (A):
--     Loksey (Library), Herod (Armory), Mograine + Whitemane (Cathedral)
--   Hearts of Zeal (H): 20 hearts from any Scarlet mob, in every wing.
-- Each wing guide validates only its own boss objective (objIndex); the
-- turn-ins are in the Cathedral guide (last wing).
-- ===================================================================
local function H(extra) local t = extra or {}; t.faction = "Horde"; return t end
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end

-- NPCs (map = uiMapID: 1458 Undercity, 1424 Hillsbrad, 1416 Alterac Mountains,
-- 1443 Desolace, 1456 Thunder Bluff, 1455 Ironforge, 1441 Thousand Needles,
-- 1442 Stonetalon, 1440 Ashenvale)
N.vorrel     = { id = 3981, name = "Vorrel Sengutz" }       -- inside the Graveyard
N.monika     = { id = 3982, name = "Monika Sengutz",        map = 1424, x = 62.7, y = 18.9 }
N.anton      = { id = 1182, name = "Brother Anton",         map = 1443, x = 66.5, y = 7.9 }
N.raleigh    = { id = 3980, name = "Raleigh the Devout",    map = 1424, x = 51.5, y = 58.4 }
N.truthseeker = { id = 3978, name = "Sage Truthseeker",     map = 1456, x = 34.4, y = 46.9 }
N.paledust   = { id = 3979, name = "Librarian Mae Paledust", map = 1455, x = 75.0, y = 12.5 }
N.dorn       = { id = 2986, name = "Dorn Plainstalker",     map = 1441, x = 54.0, y = 41.5 }
N.braug      = { id = 4489, name = "Braug Dimspirit",       map = 1442, x = 78.8, y = 45.7 }
N.parqual    = { id = 4488, name = "Parqual Fintallas",     map = 1458, x = 57.8, y = 65.4 }

N.nancy      = { id = 3984, name = "Nancy Vishas",           enemy = true }
N.ravager    = { id = 11561, name = "Undead Ravager",        enemy = true }
N.grenka     = { id = 4490, name = "Grenka Bloodscreech",    enemy = true }
N.rokalim    = { id = 4499, name = "Rok'Alim the Pounder",   enemy = true, boss = true }
N.loksey     = { id = 3974, name = "Houndmaster Loksey",     enemy = true, boss = true }
N.herod      = { id = 3975, name = "Herod",                  enemy = true, boss = true }
N.mograine   = { id = 3976, name = "Scarlet Commander Mograine", enemy = true, boss = true }
N.whitemane  = { id = 3977, name = "High Inquisitor Whitemane",  enemy = true, boss = true }
N.vishas     = { id = 3983, name = "Interrogator Vishas",    enemy = true, boss = true }
N.doan       = { id = 6487, name = "Arcanist Doan",          enemy = true, boss = true }

-- Titles shared by the 4 wings
ns.SM = {}
function ns.SM.Titles(extra)
    local t = {
        [1048] = L("Au monastère écarlate", "Into The Scarlet Monastery"),
        [1053] = L("Au nom de la Lumière", "In the Name of the Light"),
        [261] = L("Sur le chemin écarlate", "Down the Scarlet Path"),
        [1052] = L("Sur le chemin écarlate", "Down the Scarlet Path"),
        [1109] = L("Corvée de guano", "Going, Going, Guano!"),
        [1113] = L("Des cœurs zélés", "Hearts of Zeal"),
    }
    for k, v in pairs(extra or {}) do t[k] = v end
    return t
end

-- Pre-quests of the cross-wing quests (built fresh for each guide)
function ns.SM.PreSteps()
    return {
        -- Horde: Varimathras + Faranell (Hearts of Zeal needs the Kraul guano first)
        A(1048, "varimathras", H()),
        A(1109, "faranell", H()),
        D(1109, L("Guano du Kraal (Kraal de Tranchebauge)", "Kraul Guano (Razorfen Kraul)"), H({ map = 1413, x = 42.9, y = 90.2 })),
        T(1109, "faranell", H()),
        A(1113, "faranell", H()),
        -- Alliance: Brother Anton (Desolace) -> Raleigh (Southshore)
        A(261, "anton", AL()),
        D(261, L("Tuer 30 ravageurs morts-vivants (sud de la Désolace)", "Kill 30 Undead Ravagers (southern Desolace)"),
            AL({ targets = { "ravager" } })),
        T(261, "anton", AL()),
        A(1052, "anton", AL()),
        T(1052, "raleigh", AL()),
        A(1053, "raleigh", AL()),
    }
end

-- Objective steps of this wing for the cross-wing quests.
-- objIndex = position of the boss in the quest log objectives
-- (1 Whitemane, 2 Mograine, 3 Herod, 4 Loksey).
function ns.SM.WingSteps(bosses)
    local out = {}
    for _, b in ipairs(bosses) do
        out[#out + 1] = D(1048, b.text, H({ objIndex = b.index, targets = { b.key } }))
        out[#out + 1] = D(1053, b.text, AL({ objIndex = b.index, targets = { b.key } }))
    end
    return out
end

function ns.SM.Hearts()
    return D(1113, L("20 cœurs de zèle (tous les Écarlates, dans chaque aile)", "20 Hearts of Zeal (any Scarlet mob, in every wing)"), H())
end

-- Concatenate step lists
function ns.SM.Join(...)
    local out = {}
    for _, list in ipairs({ ... }) do
        for _, s in ipairs(list) do out[#out + 1] = s end
    end
    return out
end

