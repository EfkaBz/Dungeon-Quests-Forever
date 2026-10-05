local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Dire Maul - West (56-60) - AUTO-GENERATED from the Questie classic DB
-- Classic version: every quest of the dungeon + all its pre-quests.
-- Class, profession and repeatable quests are not listed.
-- Forever changes will be added as they are known. Verify in game.
-- Wing assignment: Immol'thar, Prince Tortheldrin, the Shen'dralar library.
-- ===================================================================

N.n16013 = { id = 16013, name = "Deliana", map = 1455, x = 43.5, y = 52.6 }
N.n16016 = { id = 16016, name = "Anthion Harmon", map = 1423, x = 30.9, y = 16.8 }
N.n16012 = { id = 16012, name = "Mokvar", map = 1454, x = 35.0, y = 38.3 }
N.n16031 = { id = 16031, name = "Ysida Harmon" }
N.n14358 = { id = 14358, name = "Shen'dralar Ancient" }
N.n14373 = { id = 14373, name = "Sage Korolusk", map = 1444, x = 75.2, y = 43.8 }
N.n14374 = { id = 14374, name = "Scholar Runethorn", map = 1444, x = 31.6, y = 43.5 }
N.n11496 = { id = 11496, name = "Immol'thar" }
N.n11486 = { id = 11486, name = "Prince Tortheldrin" }
N.n14368 = { id = 14368, name = "Lorekeeper Lydros" }
N.n16032 = { id = 16032, name = "Falrin Treeshaper" }
N.n9196 = { id = 9196, name = "Highlord Omokk" }
N.n9197 = { id = 9197, name = "Spirestone Battle Mage" }
N.n9198 = { id = 9198, name = "Spirestone Mystic" }
N.n9199 = { id = 9199, name = "Spirestone Enforcer" }
N.n11470 = { id = 11470, name = "Eldreth Sorcerer" }
N.n11471 = { id = 11471, name = "Eldreth Apparition" }
N.n11472 = { id = 11472, name = "Eldreth Spirit" }
N.n11473 = { id = 11473, name = "Eldreth Spectre" }
N.n10477 = { id = 10477, name = "Scholomance Necromancer" }
N.n10502 = { id = 10502, name = "Lady Illucia Barov" }

ns:RegisterDungeon("DMW", function() return {
    name = L("Haches-Tripes - Ouest", "Dire Maul - West"),
    levels = "56-60",
    icon = "Interface\\Icons\\INV_Misc_Book_11",
    entrance = { map = 1444, x = 60.3, y = 30.2 },
    titles = {
        [7461] = L("Folie intérieure", "The Madness Within"),
        [7462] = L("Le trésor des Shen'dralar", "The Treasure of the Shen'dralar"),
        [7481] = L("Légendes elfiques", "Elven Legends"),
        [7482] = L("Légendes elfiques", "Elven Legends"),
        [7507] = L("Le guide de Dagharn", "Foror's Compendium"),
        [7508] = L("Forger Quel'Serrar", "The Forging of Quel'Serrar"),
        [7877] = L("Le trésor des Shen'dralar", "The Treasure of the Shen'dralar"),
        [8929] = L("À la recherche d'Anthion", "In Search of Anthion"),
        [8930] = L("À la recherche d'Anthion", "In Search of Anthion"),
        [8945] = L("La supplique du mort", "Dead Man's Plea"),
        [8946] = L("Une preuve de vie", "Proof of Life"),
        [8947] = L("L'étonnante requête d'Anthion", "Anthion's Strange Request"),
        [8948] = L("Le vieil ami d'Anthion", "Anthion's Old Friend"),
        [8949] = L("La vendetta de Falrin", "Falrin's Vendetta"),
        [8950] = L("L'enchantement du provocateur", "The Instigator's Enchantment"),
    },
    steps = {
        -- Pre-quests
        A(8929, "n16013", { faction = "Alliance" }),
        T(8929, "n16016", { faction = "Alliance" }),
        A(8930, "n16012", { faction = "Horde" }),
        T(8930, "n16016", { faction = "Horde" }),
        A(8945, "n16016"),
        D(8945, L("Entrez à Stratholme et sauvez Ysida Harmon du baron Vaillefendre.", "Go into Stratholme and rescue Ysida Harmon from Baron Rivendare."), { targets = { "n16031" } }),
        T(8945, "n16031"),
        A(8946, "n16031"),
        T(8946, "n16016"),
        A(8947, "n16016"),
        D(8947, L("Remettre 3 Barres de sombre fer, 20 Cuirs enchantés, 3 Etoffes lunaires et 4 Peaux robustes traitées à Anth...", "Bring 3 Dark Iron Bars, 20 Enchanted Leather, 3 Mooncloth and 4 Cured Rugged Hides to Anthion Harmon in the...")),
        T(8947, "n16016"),
        -- Accept the dungeon quests
        A(7461, "n14358"),
        A(7481, "n14373", { faction = "Horde" }),
        A(7482, "n14374", { faction = "Alliance" }),
        A(7507, nil, { text = L("Objet de quête : Le guide de Nostro du tueur de dragons", "Quest item: Foror's Compendium of Dragon Slaying") }),
        A(8948, "n16016"),
        -- Inside the dungeon
        D(7461, L("Vous devez détruire les gardiens qui protègent les 5 Pylônes qui alimentent la Prison d’Immol’thar. Une foi...", "You must destroy the guardians surrounding the 5 Pylons that power the Prison of Immol'thar. Once the Pylon..."), { targets = { "n11496", "n11486" } }),
        -- Turn-ins
        T(7461, "n14358"),
        T(7481, "n14373", { faction = "Horde" }),
        T(7482, "n14374", { faction = "Alliance" }),
        T(7507, "n14368"),
        T(8948, "n16032"),
        -- Follow-ups started in the dungeon
        A(7462, "n14358", { faction = "Alliance" }),
        T(7462, nil, { text = L("Objet : Trésor des Shen'dralar", "Object: Treasure of the Shen'dralar"), faction = "Alliance" }),
        A(7508, nil, { text = L("Objet de quête : Une lame elfique inachevée", "Quest item: A Dull and Flat Elven Blade") }),
        T(7508, "n14368"),
        A(7877, "n14358", { faction = "Horde" }),
        T(7877, nil, { text = L("Objet : Trésor des Shen'dralar", "Object: Treasure of the Shen'dralar"), faction = "Horde" }),
        A(8949, "n16032"),
        D(8949, L("Collecter 25 Perles de guerre ogres à l’intérieur de Hache-Tripes ou du Pic Rochenoire, puis revenir voir F...", "Collect 25 Ogre Warbeads from Ogres inside Dire Maul or Blackrock Spire and return to Falrin Treeshaper ins..."), { targets = { "n9196", "n9197", "n9198", "n9199" } }),
        T(8949, "n16032"),
        A(8950, "n16032"),
        D(8950, L("Apportez les choses suivantes à Falrin Sculpteflore dans Hache-Tripes : 1 Essence de spectre railleur, 4 Ru...", "Bring the following to Falrin Treeshaper inside Dire Maul: 1 Jeering Spectre's Essence, 4 Dark Runes and 8 ..."), { targets = { "n11470", "n11471", "n11472", "n11473", "n10477", "n10502" } }),
        T(8950, "n16032"),
    },
} end)
