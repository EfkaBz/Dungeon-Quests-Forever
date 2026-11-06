local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Ruins of Lordaeron (Tirisfal Glades) - WoW Forever - Horde & Alliance
-- New Forever dungeon (not in Questie). Data from wowhead.com/forever,
-- foreverchanges.pro and warcraftforever.games (beta data, may change).
-- To verify in game: entrance coordinates, Unending Torment chain order,
-- Lady Dena Kennedy position, follow-up of "Remember That I Love You".
-- ===================================================================
local function H(extra) local t = extra or {}; t.faction = "Horde"; return t end
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end

-- NPCs (map = uiMapID: 1420 Tirisfal, 1421 Silverpine, 1458 Undercity, 1453 Stormwind)
N.kristof    = { id = 251001, name = "Deathguard Kristof",         map = 1420, x = 65.2, y = 60.1 }
N.morbin     = { id = 266484, name = "Morbin Lightbane",           map = 1458, x = 58.3, y = 89.7 }
N.tabitha    = { id = 250686, name = "Tabitha Heartweaver",        map = 1421, x = 44.5, y = 43.0 }
N.theodore   = { id = 11835,  name = "Theodore Griffs",            map = 1458, x = 46.3, y = 71.9 }
N.faranell   = { id = 2055,   name = "Master Apothecary Faranell", map = 1458, x = 48.8, y = 69.3 }
N.othmar     = { id = 271613, name = "Unfinished Abomination",     map = 1458, x = 46.0, y = 62.1 }
N.oran       = { id = 7825,   name = "Oran Snakewrithe",           map = 1458, x = 73.1, y = 32.9 }
N.truman     = { id = 0,      name = "Captain Truman" }             -- inside, near the entrance
N.marcus     = { id = 466,    name = "General Marcus Jonathan",    map = 1453, x = 64.0, y = 75.3 }
N.nightingale = { id = 14450, name = "Orphan Matron Nightingale",  map = 1453, x = 47.4, y = 38.2 }
N.dena       = { id = 15991,  name = "Lady Dena Kennedy",          map = 1453, x = 69.2, y = 27.7 } -- Royal Gallery, library wing of Stormwind Keep

N.witherfang = { id = 0, name = L("Croc-Flétri", "Witherfang"),  enemy = true, boss = true }
N.baron      = { id = 0, name = L("Le Baron", "The Baron"),       enemy = true, boss = true }
N.rathmael   = { id = 0, name = "Rath'mael",                      enemy = true, boss = true }

ns:RegisterDungeon("ROL", function() return {
    name = L("Ruines de Lordaeron", "Ruins of Lordaeron"),
    levels = "15-22",
    new = true, -- new in Forever
    icon = "Interface\\Icons\\Spell_Shadow_RaiseDead",
    entrance = { map = 1420, x = 62.5, y = 67.5 }, -- courtyard of the ruins, next to Undercity (approx.)
    titles = {
        [92422] = L("La colère de Rath'mael", "The Wrath of Rath'mael"),
        [92421] = L("La justice de la Lumière", "Light's Justice"),
        [92401] = L("Une requête effrayée", "A Frightened Request"),
        [95216] = L("La nouvelle peste", "The New Plague"),
        [95204] = L("Blason de Lordaeron", "Crest of Lordaeron"),
        [95189] = L("Blason de Lordaeron", "Crest of Lordaeron"),
        [97288] = L("Tourment sans fin", "Unending Torment"),
        [97291] = L("Tourment sans fin", "Unending Torment"),
        [97292] = L("Tourment sans fin", "Unending Torment"),
        [97289] = L("Tourment sans fin", "Unending Torment"),
        [97290] = L("Tourment sans fin", "Unending Torment"),
        [95250] = L("Créatures abominables", "Abominable Creatures"),
        [95195] = L("Insigne ensanglanté", "Bloodied Insignia"),
        [92415] = L("Souviens-toi que je t'aime", "Remember That I Love You"),
    },
    steps = {
        -- Horde pre-quests
        A(92401, "tabitha", H({ text = L("Facile à manquer : Tabitha Heartweaver, au cimetière de la Sépulture (Forêt des Pins-Argentés)", "Easy to miss: Tabitha Heartweaver, in the Sepulcher graveyard (Silverpine Forest)") })),
        A(95216, "theodore", H()),
        A(92421, "morbin", H()),
        A(92422, "kristof", H()),

        -- Inside the dungeon
        A(95250, "truman", AL({ text = L("Capitaine Truman, à gauche juste après l'entrée", "Captain Truman, on your left just inside the entrance") })),
        D(92421, L("25 membres intacts : les morts-vivants en donnent souvent plusieurs, tout ramasser", "25 Intact Limbs: undead often drop several, loot every mob"), H()),
        D(95216, L("Souche hautement toxique : tuer Croc-Flétri", "Highly Toxic Strain: kill Witherfang"), H({ targets = { "witherfang" } })),
        D(92401, L("Corps d'Edward Heartweaver, à l'ouest du cimetière de Rath'mael, près d'une meute de goules : il suffit de s'en approcher", "Edward Heartweaver's body, west of Rath'mael's graveyard near a pack of ghouls: just walk up to it"), H()),
        A(92415, nil, AL({ text = L("Papier froissé près du corps d'Edward, à l'ouest du cimetière de Rath'mael", "Crumpled Paper by Edward's body, west of Rath'mael's graveyard") })),
        A(97288, nil, H({ text = L("Tuer le Baron : ramasser la tête abominable et l'utiliser depuis le sac", "Kill The Baron: loot the Abominable Head and use it from your bags"), targets = { "baron" } })),
        D(95250, L("Tête du Baron", "Head of the Baron"), AL({ targets = { "baron" } })),
        A(95204, nil, H({ text = L("Blason de Lordaeron, à cliquer puis utiliser depuis le sac. Un des 5 endroits : crypte à droite de la fontaine (une banshee apparaît) ; tour à droite de Bjork, sous l'escalier ; mur derrière la patrouille de Bjork ; haut de la tour à gauche des araignées ; haut de la tour après The Abandoned", "Crest of Lordaeron, click it then use it from your bags. One of 5 spots: crypt right of the fountain (a banshee spawns); tower right of Bjork, below the stairs; wall behind Bjork's patrol; top of the tower left of the spiders; top of the tower after The Abandoned") })),
        A(95189, nil, AL({ text = L("Blason de Lordaeron, à cliquer puis utiliser depuis le sac. Un des 5 endroits : crypte à droite de la fontaine (une banshee apparaît) ; tour à droite de Bjork, sous l'escalier ; mur derrière la patrouille de Bjork ; haut de la tour à gauche des araignées ; haut de la tour après The Abandoned", "Crest of Lordaeron, click it then use it from your bags. One of 5 spots: crypt right of the fountain (a banshee spawns); tower right of Bjork, below the stairs; wall behind Bjork's patrol; top of the tower left of the spiders; top of the tower after The Abandoned") })),
        A(95195, nil, AL({ text = L("Ramasser un insigne ensanglanté sur les morts-vivants", "Loot a Bloodied Insignia from the undead") })),
        D(95195, L("10 insignes ensanglantés", "10 Bloodied Insignias"), AL()),
        D(92422, L("Tuer Rath'mael (boss final)", "Kill Rath'mael (final boss)"), H({ targets = { "rathmael" } })),
        T(95250, "truman", AL()),

        -- Horde turn-ins
        T(92422, "kristof", H()),
        T(92421, "morbin", H()),
        T(95216, "theodore", H()),
        T(95204, "oran", H()),
        -- Unending Torment chain (Apothecarium)
        T(97288, "faranell", H()),
        A(97291, "faranell", H()),
        D(97291, L("Chapeau toxique : Tawny Grisette, qui marche sur l'étage du quartier des Marchands. Herbe-cloque : plante en pot derrière les PNJ de l'herboriste (54.1, 49.4). Essence d'agonie : Ezekiel Graves, quartier des Voleurs (75.7, 51.5)", "Toxic Skullcap: Tawny Grisette, walking the upper tier of the Trade Quarter. Blisterweed: potted plant behind the herbalist NPCs (54.1, 49.4). Essence of Agony: Ezekiel Graves, Rogues' Quarter (75.7, 51.5)"), H()),
        T(97291, "faranell", H()),
        A(97292, "faranell", H()),
        D(97292, L("Utiliser le sérum sur Othmar depuis la rambarde à l'étage, près du tuyau de chair", "Use the serum on Othmar from the railing upstairs, by the fleshy pipe"), H({ map = 1458, x = 45.0, y = 62.9 })),
        T(97292, "faranell", H()),
        A(97289, "faranell", H()),
        T(97289, "othmar", H()),
        A(97290, "othmar", H()),
        T(97290, "faranell", H()),
        T(92401, "tabitha", H()),

        -- Alliance turn-ins (Stormwind)
        T(95195, "marcus", AL()),
        T(92415, "nightingale", AL()),
        T(95189, "dena", AL()),
    },
} end)
