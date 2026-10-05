local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Razorfen Downs (southern Barrens) - Horde & Alliance
-- Classic version: quest IDs / NPCs / drops verified against the
-- Questie classic DB. Forever changes will be added as they are known.
-- NPCs "varimathras" (13-18_RagefireChasm) and "charlga"
-- (29-38_RazorfenKraul) are defined in other guides.
-- ===================================================================
local function H(extra) local t = extra or {}; t.faction = "Horde"; return t end
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end

-- NPCs (map = uiMapID: 1458 Undercity, 1453 Stormwind, 1413 Barrens)
N.brownell   = { id = 2308,  name = "Andrew Brownell",      map = 1458, x = 74.1, y = 33.3 }
N.benedictus = { id = 1284,  name = "Archbishop Benedictus", map = 1453, x = 39.6, y = 27.2 }
N.myriam     = { id = 12866, name = "Myriam Moonsinger",    map = 1413, x = 49.0, y = 94.9 }
N.belnistrasz = { id = 8516, name = "Belnistrasz" }         -- inside the Downs

N.amnennar   = { id = 7358,  name = "Amnennar the Coldbringer", enemy = true, boss = true }
N.malcin     = { id = 12865, name = "Ambassador Malcin",     enemy = true, boss = true }
N.battleguard = { id = 7873, name = "Razorfen Battleguard",  enemy = true }
N.thornweaver = { id = 7874, name = "Razorfen Thornweaver",  enemy = true }
N.dhcultist  = { id = 7872,  name = "Death's Head Cultist",  enemy = true }

ns:RegisterDungeon("RFD", function() return {
    name = L("Souilles de Tranchebauge", "Razorfen Downs"),
    levels = "37-46",
    icon = "Interface\\Icons\\Spell_Shadow_AnimateDead",
    entrance = { map = 1413, x = 49.0, y = 93.9 },
    titles = {
        [3341] = L("L'anéantissement", "Bring the End"),
        [3523] = L("Le Fléau des Souilles", "Scourge of the Downs"),
        [3525] = L("L'extinction de l'idole", "Extinguishing the Idol"),
        [3636] = L("Apportez la Lumière", "Bring the Light"),
        [6521] = L("Une alliance impie", "An Unholy Alliance"),
        [6522] = L("Une alliance impie", "An Unholy Alliance"),
        [6626] = L("L'hôte du mal", "A Host of Evil"),
    },
    steps = {
        -- Horde: the Small Scroll drops from Charlga Razorflank (Razorfen Kraul)
        A(6522, nil, H({ text = L("Petit parchemin sur Charlga Razorflank (Kraal de Tranchebauge)", "Small Scroll from Charlga Razorflank (Razorfen Kraul)"),
            map = 1413, x = 42.9, y = 90.2, targets = { "charlga" } })),
        T(6522, "varimathras", H()),
        A(6521, "varimathras", H()),
        A(3341, "brownell", H()),
        -- Alliance
        A(3636, "benedictus", AL()),
        -- Entrance (both factions)
        A(6626, "myriam"),
        D(6626, L("Tuer 8 gardes de guerre, 8 tisse-épines et 8 cultistes de la Tête de Mort", "Kill 8 Battleguards, 8 Thornweavers and 8 Death's Head Cultists"),
            { targets = { "battleguard", "thornweaver", "dhcultist" } }),
        T(6626, "myriam"),
        D(6521, L("Tête de l'ambassadeur Malcin (devant l'entrée)", "Ambassador Malcin's Head (outside the entrance)"),
            H({ targets = { "malcin" } })),
        -- Inside the Downs
        A(3523, "belnistrasz"),
        K(3523, "belnistrasz", L("Rendre la pierre de serment à Belnistrasz", "Hand the Oathstone back to Belnistrasz")),
        T(3523, "belnistrasz"),
        A(3525, "belnistrasz"),
        D(3525, L("Escorter Belnistrasz jusqu'à l'idole et la défendre", "Escort Belnistrasz to the idol and defend it"), { targets = { "belnistrasz" } }),
        T(3525, "belnistrasz"),
        D(3341, L("Crâne d'Amnennar le Porte-froid", "Skull of Amnennar the Coldbringer"), H({ targets = { "amnennar" } })),
        D(3636, L("Tuer Amnennar le Porte-froid", "Kill Amnennar the Coldbringer"), AL({ targets = { "amnennar" } })),
        -- Turn-ins
        T(6521, "varimathras", H()),
        T(3341, "brownell", H()),
        T(3636, "benedictus", AL()),
    },
} end)
