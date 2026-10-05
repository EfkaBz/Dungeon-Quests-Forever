local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Dire Maul - North (56-60) - AUTO-GENERATED from the Questie classic DB
-- Classic version: every quest of the dungeon + all its pre-quests.
-- Class, profession and repeatable quests are not listed.
-- Forever changes will be added as they are known. Verify in game.
-- Wing assignment: the Gordok ogres (King Gordok, Captain Kromcrush, Knot).
-- ===================================================================

N.n14338 = { id = 14338, name = "Knot Thimblejack" }
N.n14322 = { id = 14322, name = "Stomper Kreeg" }
N.n14325 = { id = 14325, name = "Captain Kromcrush" }
N.n8898 = { id = 8898, name = "Anvilrage Marshal" }
N.n9096 = { id = 9096, name = "Rage Talon Dragonspawn" }
N.n10319 = { id = 10319, name = "Blackhand Iron Guard" }
N.n10398 = { id = 10398, name = "Thuzadin Shadowcaster" }
N.n2640 = { id = 2640, name = "Vilebranch Witch Doctor", map = 1425, x = 47.6, y = 69.5 }
N.n6527 = { id = 6527, name = "Tar Creeper", map = 1449, x = 47.2, y = 31.9 }
N.n14479 = { id = 14479, name = "Twilight Lord Everun", map = 1451, x = 18.3, y = 85.8 }
N.n417 = { id = 417, name = "Felhunter" }
N.n11448 = { id = 11448, name = "Gordok Warlock" }
N.n11450 = { id = 11450, name = "Gordok Reaver" }
N.n13022 = { id = 13022, name = "Whip Lasher" }
N.n11441 = { id = 11441, name = "Gordok Brute" }
N.n11444 = { id = 11444, name = "Gordok Mage-Lord" }
N.n11445 = { id = 11445, name = "Gordok Captain" }

ns:RegisterDungeon("DMN", function() return {
    name = L("Haches-Tripes - Nord", "Dire Maul - North"),
    levels = "56-60",
    icon = "Interface\\Icons\\INV_Misc_Book_11",
    entrance = { map = 1444, x = 62.5, y = 24.9 },
    titles = {
        [1193] = L("Un piège cassé", "A Broken Trap"),
        [1318] = L("Affaires inachevées chez les Gordok", "Unfinished Gordok Business"),
        [5518] = L("La tenue d'ogre gordok", "The Gordok Ogre Suit"),
        [5525] = L("Libérez Knot !", "Free Knot!"),
        [5528] = L("La dégustation gordok", "The Gordok Taste Test"),
        [7703] = L("Affaires inachevées chez les Gordok", "Unfinished Gordok Business"),
    },
    steps = {
        -- Accept the dungeon quests
        A(1193, nil, { text = L("Objet : Piège cassé", "Object: Broken Trap") }),
        A(1318, nil, { text = L("Accepter : Affaires inachevées chez les Gordok", "Accept: Unfinished Gordok Business") }),
        A(5518, "n14338"),
        A(5525, "n14338"),
        A(5528, "n14322"),
        A(7703, "n14325"),
        -- Inside the dungeon
        D(1193, L("Un piège cassé", "A Broken Trap"), { targets = { "n8898", "n9096", "n10319", "n10398", "n2640", "n6527" } }),
        D(1318, L("Trouvez le Gantelet de Puissance Gordok et rendez-le au capitaine Kromcrush à Hache-tripes.", "Find the Gauntlet of Gordok Might and return it to Captain Kromcrush in Dire Maul.")),
        D(5518, L("Apportez 4 Rouleaux d'étoffe runique, 8 Cuirs robustes, 2 Fils runiques et du Tanin ogre à Knot Thimblejack...", "Bring 4 Bolts of Runecloth, 8 Rugged Leather, 2 Rune Threads, and Ogre Tannin to Knot Thimblejack. He is cu..."), { targets = { "n14479", "n417", "n11448", "n11450", "n13022" } }),
        D(5525, L("Libérez Knot !", "Free Knot!"), { targets = { "n11441", "n11444", "n11445", "n11448" } }),
        D(7703, L("Trouvez le Gantelet de Puissance Gordok et rendez-le au capitaine Kromcrush à Hache-tripes.", "Find the Gauntlet of Gordok Might and return it to Captain Kromcrush in Dire Maul.")),
        -- Turn-ins
        T(1193, nil, { text = L("Objet : Piège cassé", "Object: Broken Trap") }),
        T(1318, nil, { text = L("Rendre : Affaires inachevées chez les Gordok", "Turn in: Unfinished Gordok Business") }),
        T(5518, "n14338"),
        T(5525, "n14338"),
        T(5528, "n14322"),
        T(7703, "n14325"),
    },
} end)
