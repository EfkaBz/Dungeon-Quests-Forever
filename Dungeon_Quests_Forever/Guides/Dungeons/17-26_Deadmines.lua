local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- The Deadmines (Westfall) - Alliance quests only
-- Quest IDs / NPCs / drops verified against the Questie classic DB.
-- Toxic Soil chain (Forever): ForeverDungeonJournal 1.6.3, RXPGuides Forever,
-- warcraft.wiki.gg, expcarry.com, kami-labs.fr. Stormwind positions: Forever map.
-- ===================================================================
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end

-- NPCs (map = uiMapID: 1436 Westfall, 1433 Redridge, 1453 Stormwind)
N.gryan      = { id = 234,  name = "Gryan Stoutmantle",   map = 1436, x = 56.3, y = 47.5 }
N.wiley      = { id = 266,  name = "Wiley the Black",     map = 1433, x = 26.5, y = 45.4 }
N.shaw       = { id = 332,  name = "Master Mathias Shaw", map = 1453, x = 75.8, y = 59.8 }
N.traitor    = { id = 467,  name = "The Defias Traitor",  map = 1436, x = 55.7, y = 47.5 }
N.riell      = { id = 820,  name = "Scout Riell",         map = 1436, x = 56.7, y = 47.4 }
N.wilder     = { id = 656,  name = "Wilder Thistlenettle", map = 1453, x = 66.8, y = 43.8, forever = true }
N.shoni      = { id = 6579, name = "Shoni the Shilent",   map = 1453, x = 63.0, y = 34.0, forever = true }
N.baros      = { id = 1646, name = "Baros Alexston",      map = 1453, x = 57.7, y = 47.9, forever = true }
N.thelwater  = { id = 1719, name = "Warden Thelwater",    map = 1453, x = 51.8, y = 69.3, forever = true }
-- Toxic Soil chain (new in Forever, not in Questie). Alba: DungeonJournal
-- 1.6.3 / RXPGuides Forever. Sprite: Classic spawn converted to the Forever
-- Stormwind map, and Stormwind Intelligence (SI:7, Old Town): approximate,
-- to check in game.
N.alba       = { id = 253092, name = "Alba Fairmoon",       map = 1436, x = 53.0, y = 53.3, forever = true } -- Sentinel Hill inn
N.sprite     = { id = 11026, name = "Sprite Jumpsprocket", map = 1453, x = 62.3, y = 30.4, forever = true } -- Dwarven District
N.swintel    = { id = 0,     name = "Stormwind Intelligence", map = 1453, x = 78.9, y = 70.6 } -- SI:7, Old Town (approximate)

N.messenger  = { id = 550, name = "Defias Messenger",      enemy = true }
N.vancleef   = { id = 639, name = "Edwin VanCleef",        enemy = true, boss = true }
N.foreman    = { id = 626, name = "Foreman Thistlenettle", enemy = true, boss = true }
N.shredder   = { id = 642, name = "Sneed's Shredder",      enemy = true, boss = true }
N.skminer    = { id = 623, name = "Skeletal Miner",        enemy = true }
N.excavator  = { id = 624, name = "Undead Excavator",      enemy = true }
N.dynamiter  = { id = 625, name = "Undead Dynamiter",      enemy = true }
N.henchman   = { id = 594, name = "Defias Henchman",       enemy = true }
N.dminer     = { id = 598, name = "Defias Miner",          enemy = true }
N.conjurer   = { id = 619, name = "Defias Conjurer",       enemy = true }
N.overseer   = { id = 634, name = "Defias Overseer",       enemy = true }
N.gilnid     = { id = 1763, name = "Gilnid",                enemy = true, boss = true }

-- Toxic Soil spots (Westfall)
local WELLS  = { { map = 1436, x = 56.6, y = 18.6 }, { map = 1436, x = 46.1, y = 38.2 } } -- Jansen Stead, Molsen Farm
local SHORE  = { { map = 1436, x = 52.1, y = 10.4 }, { map = 1436, x = 56.4, y = 9.4 } }  -- Longshore, north coast
local MINES  = { { map = 1436, x = 44.0, y = 25.0 }, { map = 1436, x = 31.0, y = 46.0 } } -- Jangolode Mine, Gold Coast Quarry

ns:RegisterDungeon("DM", function() return {
    name = L("Les Mortemines", "The Deadmines"),
    levels = "17-26",
    icon = "Interface\\Icons\\INV_Misc_Bandana_03",
    entrance = { map = 1436, x = 42.5, y = 71.7 }, -- Moonbrook
    titles = {
        [65] = L("La Confrérie défias", "The Defias Brotherhood"), [132] = L("La Confrérie défias", "The Defias Brotherhood"),
        [135] = L("La Confrérie défias", "The Defias Brotherhood"), [141] = L("La Confrérie défias", "The Defias Brotherhood"),
        [142] = L("La Confrérie défias", "The Defias Brotherhood"), [155] = L("La Confrérie défias", "The Defias Brotherhood"),
        [166] = L("La Confrérie défias", "The Defias Brotherhood"),
        [167] = L("Adieu mon frère…", "Oh Brother. . ."),
        [168] = L("À la recherche de Cartes du Syndicat des Mineurs", "Collecting Memories"),
        [214] = L("Les masques rouges en soie", "Red Silk Bandanas"),
        [2040] = L("Assaut souterrain", "Underground Assault"),
        [373] = L("La lettre non envoyée", "The Unsent Letter"),
        [389] = L("Bazil Thredd", "Bazil Thredd"),
        [92742] = L("Analyser les puits", "Testing the Wells"),
        [92744] = L("Branchies de murloc", "Murloc Gills"),
        [92745] = L("L'état des mines", "The State of the Mines"),
        [92747] = L("Espionnage à Ruisselune", "Moonbrook Espionage"),
        [92748] = L("Consultation explosive", "Explosive Consultation"),
        [92749] = L("Un plan à la dynamite", "A Dynamite Plan"),
        [92750] = L("Détonation à distance", "Detonation at a Distance"),
        [92751] = L("Détonation à distance", "Detonation at a Distance"),
        [92752] = L("Consultation explosive", "Explosive Consultation"),
        [92753] = L("Destruction aux Mortemines", "Destruction in Deadmines"),
        [92819] = L("Destruction aux Mortemines", "Destruction in Deadmines"),
    },
    steps = {
        -- The Defias Brotherhood chain (Westfall / Redridge / Stormwind)
        A(65, "gryan", AL()),
        T(65, "wiley", AL()),
        A(132, "wiley", AL()),
        T(132, "gryan", AL()),
        A(135, "gryan", AL()),
        T(135, "shaw", AL()),
        A(141, "shaw", AL()),
        T(141, "gryan", AL()),
        A(142, "gryan", AL()),
        D(142, L("Tuer le messager défias (il patrouille)", "Kill the Defias Messenger (he patrols)"), AL({ targets = { "messenger" } })),
        T(142, "gryan", AL()),
        A(155, "traitor", AL()),
        D(155, L("Escorter le traître défias jusqu'à Ruisselune", "Escort the Defias Traitor to Moonbrook"), AL({ map = 1436, x = 42.5, y = 71.7 })),
        T(155, "gryan", AL()),
        A(166, "gryan", AL()),
        A(214, "riell", AL()),
        -- Toxic Soil (new in Forever): Alba Fairmoon, Sentinel Hill inn
        A(92742, "alba", AL()),
        A(92744, "alba", AL()),
        D(92742, L("Kit d'échantillons : puits de la ferme Jansen et de la ferme Molsen", "Sample kit: Jansen Stead and Molsen Farm wells"), AL({ spots = WELLS })),
        D(92744, L("7 branchies de murloc de Longrivage (côte nord)", "7 Longshore Murloc Gills (north coast)"), AL({ spots = SHORE })),
        T(92742, "alba", AL()),
        T(92744, "alba", AL()),
        A(92745, "alba", AL()),
        D(92745, L("4 kobolds fouisseurs (mine de Jango) et 6 mineurs Rivepatte (carrière de la Côte de l'or)", "4 Kobold Diggers (Jangolode Mine) and 6 Riverpaw Miners (Gold Coast Quarry)"), AL({ spots = MINES })),
        T(92745, "alba", AL()),
        A(92747, "alba", AL()),
        D(92747, L("8 fournitures industrielles suspectes : Ruisselune et la grotte vers les Mortemines", "8 Suspicious Industrial Supplies: Moonbrook and the cave toward the Deadmines"), AL({ map = 1436, x = 42.5, y = 71.7 })),
        T(92747, "alba", AL()),
        A(92748, "alba", AL()),
        T(92748, "sprite", AL({ text = L("Sprite Jumpsprocket, quartier des Nains (Hurlevent)", "Sprite Jumpsprocket, Dwarven District (Stormwind)") })),
        A(92749, "sprite", AL()),
        D(92749, L("10 dynamites grossières (ingénierie, échange ou hôtel des ventes)", "10 Coarse Dynamite (Engineering, trade or Auction House)"), AL()),
        T(92749, "sprite", AL()),
        A(92750, "sprite", AL()),
        T(92750, "swintel", AL({ text = L("Renseignements de Hurlevent (SI:7, vieille ville)", "Stormwind Intelligence (SI:7, Old Town)") })),
        A(92751, "swintel", AL()),
        T(92751, "sprite", AL()),
        A(92752, "sprite", AL()),
        T(92752, "alba", AL()),
        A(92753, nil, AL({ text = L("Utiliser les Explosifs extra-destructeurs (objet) pour lancer la quête. Niveau 18 conseillé", "Use the Extra-Destructive Explosives (item) to start the quest. Level 18 advised") })),
        -- Stormwind
        A(167, "wilder", AL()),
        A(168, "wilder", AL()),
        A(2040, "shoni", AL()),
        -- In the dungeon
        D(168, L("4 cartes du syndicat des mineurs (morts-vivants)", "4 Miners' Union Cards (undead miners)"),
            AL({ targets = { "skminer", "excavator", "dynamiter" } })),
        D(214, L("10 bandanas en soie rouge (Défias)", "10 Red Silk Bandanas (Defias)"),
            AL({ targets = { "henchman", "dminer", "conjurer", "overseer" } })),
        D(167, L("Badge : tuer le contremaître Thistlenettle", "Badge: kill Foreman Thistlenettle"), AL({ targets = { "foreman" } })),
        D(2040, L("Engrenage : tuer le déchiqueteur de Sneed", "Sprocket: kill Sneed's Shredder"), AL({ targets = { "shredder" } })),
        D(92753, L("Forge de Gilnid : poser les explosifs à côté", "Gilnid's forge: plant the explosives next to it"), AL({ targets = { "gilnid" } })),
        D(166, L("Tuer Edwin VanCleef : sa tête", "Kill Edwin VanCleef: his head"), AL({ targets = { "vancleef" } })),
        A(373, nil, AL({ text = L("VanCleef : ramasser la lettre (lance « La lettre jamais envoyée »)", "VanCleef: loot the letter (starts The Unsent Letter)"),
            targets = { "vancleef" } })),
        -- Turn-ins
        T(92753, "alba", AL({ text = L("Alba vous attend à la sortie des Mortemines (sinon à l'auberge de Sentinel Hill)", "Alba waits at the Deadmines exit (otherwise at the Sentinel Hill inn)"),
            map = 1436, x = 42.5, y = 71.7 })),
        A(92819, "alba", AL({ map = 1436, x = 42.5, y = 71.7 })),
        D(92819, L("Utiliser le détonateur", "Use the detonator"), AL({ map = 1436, x = 42.5, y = 71.7 })),
        T(92819, "alba", AL({ map = 1436, x = 42.5, y = 71.7 })),
        T(214, "riell", AL()),
        T(166, "gryan", AL()),
        T(373, "baros", AL()),
        A(389, "baros", AL()),
        T(389, "thelwater", AL()),
        T(167, "wilder", AL()),
        T(168, "wilder", AL()),
        T(2040, "shoni", AL()),
    },
} end)
