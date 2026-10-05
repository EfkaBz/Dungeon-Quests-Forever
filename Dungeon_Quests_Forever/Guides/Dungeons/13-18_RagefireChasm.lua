local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Ragefire Chasm (Orgrimmar) - Horde
-- ===================================================================

-- NPCs: id = creature ID (names are localized at runtime), map = uiMapID.
-- Coordinates from the Questie classic DB; refreshed from Questie when installed.
N.thrall      = { id = 4949,  name = "Thrall",          map = 1454, x = 31.7, y = 37.8 }
N.neeru       = { id = 3216,  name = "Neeru Fireblade", map = 1454, x = 49.5, y = 50.6 }
N.rahauro     = { id = 11833, name = "Rahauro",         map = 1456, x = 70.1, y = 29.5 }
N.varimathras = { id = 2425,  name = "Varimathras",     map = 1458, x = 56.3, y = 92.2 }

-- Ragefire Chasm
N.maur        = { id = 11834, name = "Maur Grimtotem" }
N.taragaman   = { id = 11520, name = "Taragaman the Hungerer", enemy = true, boss = true }
N.jergosh     = { id = 11518, name = "Jergosh the Invoker",    enemy = true, boss = true }
N.bazzalan    = { id = 11519, name = "Bazzalan",               enemy = true, boss = true }
N.trogg       = { id = 11318, name = "Ragefire Trogg",         enemy = true }
N.rfshaman    = { id = 11319, name = "Ragefire Shaman",        enemy = true }
N.sbcultist   = { id = 11322, name = "Searing Blade Cultist",  enemy = true }
N.sbwarlock   = { id = 11324, name = "Searing Blade Warlock",  enemy = true }

-- Durotar (Skull Rock)
N.bbfanatic    = { id = 3197, name = "Burning Blade Fanatic",    enemy = true }
N.bbapprentice = { id = 3198, name = "Burning Blade Apprentice", enemy = true }

-- Quest IDs / NPCs / drops verified against the Questie classic DB.
-- Built after ADDON_LOADED so the chosen language is known.
ns:RegisterDungeon("RFC", function() return {
    name = L("Gouffre de Ragefeu", "Ragefire Chasm"),
    levels = "13-18",
    faction = "Horde",
    icon = "Interface\\Icons\\Spell_Fire_Incinerate",
    entrance = { map = 1454, x = 52.6, y = 49.0 }, -- Cleft of Shadow
    -- fallback titles (the client's own localized title is used when cached)
    titles = {
        [5722] = L("À la recherche de la sacoche perdue", "Searching for the Lost Satchel"),
        [5723] = L("Tester la force de l'ennemi", "Testing an Enemy's Strength"),
        [5724] = L("Rapporter la sacoche perdue", "Returning the Lost Satchel"),
        [5725] = L("Le pouvoir de détruire...", "The Power to Destroy..."),
        [5726] = L("Ennemis cachés", "Hidden Enemies"),
        [5727] = L("Ennemis cachés", "Hidden Enemies"),
        [5728] = L("Ennemis cachés", "Hidden Enemies"),
        [5729] = L("Ennemis cachés", "Hidden Enemies"),
        [5730] = L("Ennemis cachés", "Hidden Enemies"),
        [5761] = L("Tuer la bête", "Slaying the Beast"),
    },
    steps = {
        -- Orgrimmar pre-quests (Thrall)
        A(5726, "thrall"),
        D(5726, L("Loot : Insigne de lieutenant (Lame ardente, Rocher du Crâne)", "Loot Lieutenant's Insignia (Burning Blade, Skull Rock)"),
            { map = 1411, x = 53.0, y = 9.5, targets = { "bbfanatic", "bbapprentice" } }),
        T(5726, "thrall"),
        A(5727, "thrall"),
        K(5727, "neeru", L("Parler à Neeru (Faille de l'ombre)", "Speak to Neeru (Cleft of Shadow)")),
        T(5727, "thrall"),
        A(5728, "thrall"),
        A(5761, "neeru"),
        -- Other cities
        A(5723, "rahauro"),
        A(5722, "rahauro"),
        A(5725, "varimathras"),
        -- Inside the dungeon
        D(5723, L("Tuer 8 Troggs et 8 Chamans de Ragefeu", "Kill 8 Ragefire Troggs and 8 Ragefire Shamans"),
            { targets = { "trogg", "rfshaman" } }),
        D(5722, L("Fouiller le cadavre de Maur Grisetotem", "Search Maur Grimtotem's corpse"), { targets = { "maur" } }),
        T(5722, "maur"),
        A(5724, "maur"),
        D(5725, L("Livres : Cultistes et Démonistes de la Lame brûlante", "Books: Searing Blade Cultists and Warlocks"),
            { targets = { "sbcultist", "sbwarlock" } }),
        D(5761, L("Tuer Taragaman l'Affameur", "Kill Taragaman the Hungerer"), { targets = { "taragaman" } }),
        D(5728, L("Tuer Jergosh l'Invocateur et Bazzalan", "Kill Jergosh the Invoker and Bazzalan"), { targets = { "jergosh", "bazzalan" } }),
        -- Turn-ins
        T(5728, "thrall"),
        A(5729, "thrall"),
        T(5729, "neeru"),
        T(5761, "neeru"),
        A(5730, "neeru"),
        T(5730, "thrall"),
        T(5723, "rahauro"),
        T(5724, "rahauro"),
        T(5725, "varimathras"),
    },
} end)
