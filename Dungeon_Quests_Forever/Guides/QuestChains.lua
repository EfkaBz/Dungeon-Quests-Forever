local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, D = ns.Accept, ns.TurnIn, ns.Do

-- ===================================================================
-- Chains checked against the Wowhead "Series" lists, warcraft.wiki.gg and
-- Warcraft Tavern: missing steps, and steps that were in the wrong order.
-- { before = quest, move = { quests } } moves existing steps and keeps their
-- uid, so saved manual checks stay valid (see ns:AddGuideSteps).
-- ===================================================================
N.qc_beldin   = { id = 1376,   name = "Beldin Steelgrill",   map = 1426, x = 50.4, y = 49.0, forever = true }
N.qc_avette   = { id = 228,    name = "Avette Fellwood",     map = 1431, x = 73.1, y = 44.6, forever = true }
N.qc_celindra = { id = 252085, name = "Archmage Celindra",   map = 1416, x = 14.2, y = 60.0, forever = true }
-- Ruins of Lordaeron, Horde pre-quests
N.qc_renferrel = { id = 1937, name = "Apothecary Renferrel", map = 1421, x = 42.8, y = 40.9 }
N.qc_linnea    = { id = 1495, name = "Deathguard Linnea",    map = 1420, x = 65.5, y = 60.3 }
N.qc_riptear   = { id = 276020, name = "Riptear",            map = 1420, x = 83.9, y = 44.0, forever = true }
N.qc_n1529 = { id = 1529, name = "Bleeding Horror" }
N.qc_n1532 = { id = 1532, name = "Wandering Spirit" }
N.qc_n1778 = { id = 1778, name = "Ferocious Grizzled Bear" }
N.qc_n1797 = { id = 1797, name = "Giant Grizzled Bear" }
N.qc_n1780 = { id = 1780, name = "Moss Stalker" }
N.qc_n1781 = { id = 1781, name = "Mist Creeper" }
N.qc_n1953 = { id = 1953, name = "Lake Skulker" }
N.qc_n1954 = { id = 1954, name = "Elder Lake Skulker" }
N.qc_n1955 = { id = 1955, name = "Lake Creeper" }
N.qc_n1956 = { id = 1956, name = "Elder Lake Creeper" }
N.qc_n1957 = { id = 1957, name = "Vile Fin Shorecreeper" }
N.qc_n1958 = { id = 1958, name = "Vile Fin Tidecaller" }

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
        [447] = L("Une recette mortelle", "A Recipe For Death"),
        [450] = L("Une recette mortelle", "A Recipe For Death"),
        [451] = L("Une recette mortelle", "A Recipe For Death"),
        [356] = L("Patrouille d'arrière-garde", "Rear Guard Patrol"),
        [99156] = L("Patrouille d'arrière-garde", "Rear Guard Patrol"),
    },
    groups = {
        -- Unending Torment: the head goes on the body before the serum
        { before = 97291, move = { 97289, 97290 } },
        -- Horde: quest chains leading to The New Plague and The Wrath of Rath'mael
        { before = 95216, steps = {
            A(447, "qc_renferrel", { faction = "Horde", text = L("Pré-quête de La nouvelle peste : apothicaire Renferrel, au Sépulcre", "Pre-quest of The New Plague: Apothecary Renferrel, at the Sepulcher") }),
            D(447, L("6 cœurs de vieil ours (ours) et 6 échantillons de sang du Grouillement (araignées), en Forêt des Pins-Argentés", "6 Grizzled Bear Hearts (bears) and 6 Skittering Blood (spiders), in Silverpine Forest"), { faction = "Horde", targets = { "qc_n1778", "qc_n1797", "qc_n1780", "qc_n1781" } }),
            T(447, "faranell", { faction = "Horde" }),
            A(450, "faranell", { faction = "Horde" }),
            D(450, L("Journal de Berard : sur l'étagère d'une chambre de l'auberge de Bois-du-Bûcher, gardée par Berard", "Berard's Journal: on the bookshelf in a room of the Pyrewood Village inn, guarded by Berard"), { faction = "Horde", map = 1421, x = 43.0, y = 73.2 }),
            T(450, "qc_renferrel", { faction = "Horde" }),
            A(451, "qc_renferrel", { faction = "Horde" }),
            D(451, L("6 mousses de rampant du lac, 6 mousses de furtif du lac et 1 tumeur durcie (murlocs), au lac Lordamere", "6 Lake Creeper Moss, 6 Lake Skulker Moss and 1 Hardened Tumor (Vile Fin murlocs), around Lordamere Lake"), { faction = "Horde", targets = { "qc_n1955", "qc_n1956", "qc_n1953", "qc_n1954", "qc_n1957", "qc_n1958" } }),
            T(451, "faranell", { faction = "Horde" }),
        } },
        { before = 92422, steps = {
            A(356, "qc_linnea", { faction = "Horde", text = L("Pré-quête de La colère de Rath'mael : garde de la mort Linnea, à côté de Kristof", "Pre-quest of The Wrath of Rath'mael: Deathguard Linnea, next to Kristof") }),
            D(356, L("8 horreurs sanguinolentes et 8 esprits vagabonds, à la ferme des Balnir, à l'est du Rempart", "8 Bleeding Horrors and 8 Wandering Spirits, at Balnir Farmstead, east of the Bulwark"), { faction = "Horde", targets = { "qc_n1529", "qc_n1532" } }),
            T(356, "qc_linnea", { faction = "Horde" }),
            A(99156, "qc_linnea", { faction = "Horde" }),
            D(99156, L("Cœur de Riptear : tuer Riptear (élite, niveau 13), qui erre dans le val de Venomweb. Venir en groupe", "Riptear's Heart: kill Riptear (elite, level 13), who wanders Venomweb Vale. Bring a group"), { faction = "Horde", targets = { "qc_riptear" }, map = 1420, x = 83.9, y = 44.0 }),
            T(99156, "qc_linnea", { faction = "Horde" }),
        } },
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
