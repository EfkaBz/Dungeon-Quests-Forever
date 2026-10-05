local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Maraudon (Desolace) - Horde & Alliance
-- Classic version: quest IDs / NPCs / drops verified against the
-- Questie classic DB. Forever changes will be added as they are known.
-- ===================================================================
local function H(extra) local t = extra or {}; t.faction = "Horde"; return t end
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end

-- NPCs (map = uiMapID: 1443 Desolace, 1454 Orgrimmar, 1445 Dustwallow, 1450 Moonglade)
N.willow     = { id = 13656, name = "Willow",              map = 1443, x = 62.2, y = 39.6 }
N.vark       = { id = 11823, name = "Vark Battlescar",     map = 1443, x = 23.2, y = 70.3 }
N.talendria  = { id = 11715, name = "Talendria",           map = 1443, x = 68.5, y = 8.9 }
N.cavindra   = { id = 13697, name = "Cavindra",            map = 1443, x = 32.1, y = 64.0 }
N.selendra   = { id = 13699, name = "Selendra",            map = 1443, x = 26.9, y = 77.7 }
N.marandis   = { id = 13698, name = "Keeper Marandis",     map = 1443, x = 63.8, y = 10.7 }
N.pariah     = { id = 13717, name = "Centaur Pariah",      map = 1443, x = 50.4, y = 86.7 }
N.uthelnay   = { id = 7311,  name = "Uthel'nay",           map = 1454, x = 39.2, y = 86.3 }
N.tervosh    = { id = 4967,  name = "Archmage Tervosh",    map = 1445, x = 66.4, y = 49.3 }
N.remulos    = { id = 11832, name = "Keeper Remulos",      map = 1450, x = 36.2, y = 41.8 }
N.celebras   = { id = 13716, name = "Celebras the Redeemed" } -- inside
N.zaetar     = { id = 12238, name = "Zaetar's Spirit" }       -- appears after Theradras

N.theradras  = { id = 12201, name = "Princess Theradras",    enemy = true, boss = true }
N.vyletongue = { id = 12236, name = "Lord Vyletongue",       enemy = true, boss = true }
N.noxxion    = { id = 13282, name = "Noxxion",               enemy = true, boss = true }
N.noxscion   = { id = 13696, name = "Noxxious Scion",        enemy = true }
N.cursedcentaur = { id = 11688, name = "Cursed Centaur",     enemy = true }
N.psatyr     = { id = 11790, name = "Putridus Satyr",        enemy = true }
N.ptrickster = { id = 11791, name = "Putridus Trickster",    enemy = true }
N.pstalker   = { id = 11792, name = "Putridus Shadowstalker", enemy = true }
N.ssrumbler  = { id = 11777, name = "Shadowshard Rumbler",   enemy = true }
N.sssmasher  = { id = 11778, name = "Shadowshard Smasher",   enemy = true }
N.kolk       = { id = 13742, name = "Kolk",     enemy = true, boss = true }
N.gelk       = { id = 13741, name = "Gelk",     enemy = true, boss = true }
N.magra      = { id = 13740, name = "Magra",    enemy = true, boss = true }
N.maraudos   = { id = 13739, name = "Maraudos", enemy = true, boss = true }
N.veng       = { id = 13738, name = "Veng",     enemy = true, boss = true }

ns:RegisterDungeon("MARA", function() return {
    name = L("Maraudon", "Maraudon"),
    levels = "46-55",
    icon = "Interface\\Icons\\INV_Staff_16",
    entrance = { map = 1443, x = 29.1, y = 62.5 },
    titles = {
        [7028] = L("Forces maléfiques retorses", "Twisted Evils"),
        [7029] = L("La corruption de Vylelangue", "Vyletongue Corruption"),
        [7041] = L("La corruption de Vylelangue", "Vyletongue Corruption"),
        [7044] = L("Légendes de Maraudon", "Legends of Maraudon"),
        [7046] = L("Le sceptre de Celebras", "The Scepter of Celebras"),
        [7064] = L("Corruption de la terre et de la graine", "Corruption of Earth and Seed"),
        [7065] = L("Corruption de la terre et de la Graine", "Corruption of Earth and Seed"),
        [7066] = L("Graine de vie", "Seed of Life"),
        [7067] = L("Les instructions du paria", "The Pariah's Instructions"),
        [7068] = L("Fragments d'Ombréclat", "Shadowshard Fragments"),
        [7070] = L("Fragments d'Ombréclat", "Shadowshard Fragments"),
    },
    steps = {
        -- Horde pre-quests
        A(7068, "uthelnay", H()),
        A(7029, "vark", H()),
        A(7064, "selendra", H()),
        -- Alliance pre-quests
        A(7070, "tervosh", AL()),
        A(7041, "talendria", AL()),
        A(7065, "marandis", AL()),
        -- Both factions (Desolace)
        A(7028, "willow"),
        A(7067, "pariah"),
        A(7044, "cavindra"),
        -- Around the entrance (outside) and inside
        D(7068, L("10 fragments d'ombréclat (grondeurs et fracasseurs)", "10 Shadowshard Fragments (Rumblers and Smashers)"), H({ targets = { "ssrumbler", "sssmasher" } })),
        D(7070, L("10 fragments d'ombréclat (grondeurs et fracasseurs)", "10 Shadowshard Fragments (Rumblers and Smashers)"), AL({ targets = { "ssrumbler", "sssmasher" } })),
        D(7028, L("15 sculptures de cristal théradrien (centaures et satyres)", "15 Theradric Crystal Carvings (centaurs and satyrs)"),
            { targets = { "cursedcentaur", "psatyr", "ptrickster", "pstalker" } }),
        D(7029, L("Remplir la fiole au bassin de cristal orange (rejetons nocifs)", "Fill the vial at the orange crystal pool (Noxxious Scions)"), H({ targets = { "noxscion" } })),
        D(7041, L("Remplir la fiole au bassin de cristal orange (rejetons nocifs)", "Fill the vial at the orange crystal pool (Noxxious Scions)"), AL({ targets = { "noxscion" } })),
        D(7067, L("Amulette de l'union : tuer les 5 khans centaures", "Amulet of Union: kill the 5 centaur Khans"),
            { targets = { "kolk", "gelk", "magra", "maraudos", "veng" } }),
        D(7044, L("Bâton célébrien (Noxxion) et diamant célébrien (seigneur Langue-vile)", "Celebrian Rod (Noxxion) and Celebrian Diamond (Lord Vyletongue)"),
            { targets = { "noxxion", "vyletongue" } }),
        T(7044, "celebras"),
        A(7046, "celebras"),
        K(7046, "celebras", L("Aider Celebras à créer le sceptre", "Assist Celebras while he creates the Scepter")),
        T(7046, "celebras"),
        D(7064, L("Tuer la princesse Theradras", "Kill Princess Theradras"), H({ targets = { "theradras" } })),
        D(7065, L("Tuer la princesse Theradras", "Kill Princess Theradras"), AL({ targets = { "theradras" } })),
        A(7066, "zaetar"),
        -- Turn-ins
        T(7028, "willow"),
        T(7067, "pariah"),
        T(7029, "vark", H()),
        T(7064, "selendra", H()),
        T(7068, "uthelnay", H()),
        T(7041, "talendria", AL()),
        T(7065, "marandis", AL()),
        T(7070, "tervosh", AL()),
        T(7066, "remulos"),
    },
} end)
