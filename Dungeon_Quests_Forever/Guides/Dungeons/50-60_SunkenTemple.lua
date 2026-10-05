local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Sunken Temple (50-60) - AUTO-GENERATED from the Questie classic DB
-- Classic version: every quest of the dungeon + all its pre-quests.
-- Class, profession and repeatable quests are not listed.
-- Forever changes will be added as they are known. Verify in game.
-- ===================================================================

N.n1443 = { id = 1443, name = "Fel'zerul", map = 1435, x = 47.9, y = 54.8 }
N.n5598 = { id = 5598, name = "Atal'ai Exile", map = 1425, x = 33.8, y = 75.2 }
N.n5384 = { id = 5384, name = "Brohann Caskbelly", map = 1453, x = 64.3, y = 20.6 }
N.n5635 = { id = 5635, name = "Falstad Wildhammer", map = 1425, x = 11.8, y = 46.8 }
N.n5636 = { id = 5636, name = "Gryphon Master Talonaxe", map = 1425, x = 9.8, y = 44.5 }
N.n5634 = { id = 5634, name = "Rhapsody Shindigger", map = 1425, x = 26.9, y = 48.6 }
N.n5428 = { id = 5428, name = "Roc", map = 1446, x = 40.9, y = 24.9 }
N.n5429 = { id = 5429, name = "Fire Roc", map = 1446, x = 55.2, y = 47.1 }
N.n5430 = { id = 5430, name = "Searing Roc", map = 1446, x = 36.7, y = 69.1 }
N.n5268 = { id = 5268, name = "Ironfur Bear", map = 1444, x = 89.6, y = 39.3 }
N.n5272 = { id = 5272, name = "Grizzled Ironfur Bear", map = 1444, x = 55.0, y = 49.8 }
N.n5274 = { id = 5274, name = "Ironfur Patriarch", map = 1444, x = 43.1, y = 23.9 }
N.n7900 = { id = 7900, name = "Angelas Moonbreeze", map = 1444, x = 31.8, y = 45.6 }
N.n7771 = { id = 7771, name = "Marvon Rivetseeker", map = 1446, x = 52.7, y = 45.9 }
N.n8579 = { id = 8579, name = "Yeh'kinya", map = 1446, x = 67.0, y = 22.4 }
N.n8612 = { id = 8612, name = "Screecher Spirit" }
N.n7272 = { id = 7272, name = "Theka the Martyr" }
N.n7791 = { id = 7791, name = "Theka the Martyr Shapeshift" }
N.n7795 = { id = 7795, name = "Hydromancer Velratha" }
N.n9118 = { id = 9118, name = "Larion", map = 1449, x = 45.5, y = 8.7 }
N.n6509 = { id = 6509, name = "Bloodpetal Lasher", map = 1449, x = 75.0, y = 44.7 }
N.n6512 = { id = 6512, name = "Bloodpetal Trapper", map = 1449, x = 29.4, y = 57.0 }
N.n6510 = { id = 6510, name = "Bloodpetal Flayer", map = 1449, x = 59.9, y = 45.3 }
N.n6511 = { id = 6511, name = "Bloodpetal Thresher", map = 1449, x = 74.2, y = 50.8 }
N.n8496 = { id = 8496, name = "Liv Rizzlefix", map = 1413, x = 62.5, y = 38.7 }
N.n5709 = { id = 5709, name = "Shade of Eranikus" }
N.n8115 = { id = 8115, name = "Witch Doctor Uzer'i", map = 1444, x = 74.4, y = 43.4 }
N.n15362 = { id = 15362, name = "Malfurion Stormrage" }
N.n5243 = { id = 5243, name = "Cursed Atal'ai" }
N.n5256 = { id = 5256, name = "Atal'ai Warrior" }
N.n5259 = { id = 5259, name = "Atal'ai Witch Doctor" }
N.n5261 = { id = 5261, name = "Enthralled Atal'ai", map = 1435, x = 80.6, y = 47.5 }
N.n5710 = { id = 5710, name = "Jammal'an the Prophet" }
N.n5226 = { id = 5226, name = "Murk Worm" }
N.n5228 = { id = 5228, name = "Saturated Ooze" }
N.n8384 = { id = 8384, name = "Deep Lurker" }
N.n15624 = { id = 15624, name = "Forest Wisp", map = 1438, x = 37.5, y = 47.9 }

ns:RegisterDungeon("ST", function() return {
    name = L("Temple englouti", "Sunken Temple"),
    levels = "50-60",
    icon = "Interface\\Icons\\INV_Misc_Head_Dragon_Green",
    entrance = { map = 1435, x = 69.9, y = 53.5 },
    titles = {
        [1424] = L("Le bassin des larmes", "Pool of Tears"),
        [1429] = L("L'Exilé atal'ai", "The Atal'ai Exile"),
        [1444] = L("De retour vers Fel’Zerul", "Return to Fel'Zerul"),
        [1445] = L("Le temple d'Atal'Hakkar", "The Temple of Atal'Hakkar"),
        [1446] = L("Jammal'an le Prophète", "Jammal'an the Prophet"),
        [1448] = L("À la recherche du temple", "In Search of The Temple"),
        [1449] = L("Vers les Hinterlands", "To The Hinterlands"),
        [1450] = L("Le Maître des gryphons Talonaxe", "Gryphon Master Talonaxe"),
        [1451] = L("Rhapsody Shindigger", "Rhapsody Shindigger"),
        [1452] = L("Le Kocktail Kalimdor de Rhapsody", "Rhapsody's Kalimdor Kocktail"),
        [1469] = L("L'histoire de Rhapsody", "Rhapsody's Tale"),
        [1475] = L("Dans le temple d'Atal'Hakkar", "Into The Temple of Atal'Hakkar"),
        [3373] = L("L'Essence d'Eranikus", "The Essence of Eranikus"),
        [3380] = L("Le Temple englouti", "The Sunken Temple"),
        [3445] = L("Le Temple englouti", "The Sunken Temple"),
        [3444] = L("Le Cercle de pierres", "The Stone Circle"),
        [3446] = L("Dans les profondeurs", "Into the Depths"),
        [3447] = L("Le secret du cercle", "Secret of the Circle"),
        [3520] = L("Esprits de Hurleurs", "Screecher Spirits"),
        [3527] = L("La prophétie de Mosh'aru", "The Prophecy of Mosh'aru"),
        [4787] = L("L'oeuf antique", "The Ancient Egg"),
        [3528] = L("Le dieu Hakkar", "The God Hakkar"),
        [4145] = L("Larion et Muigin", "Larion and Muigin"),
        [4147] = L("Atelier de Marvon", "Marvon's Workshop"),
        [4146] = L("Carburant de baguette", "Zapper Fuel"),
        [8733] = L("Eranikus, le tyran du Rêve", "Eranikus, Tyrant of the Dream"),
    },
    steps = {
        -- Pre-quests
        A(1424, "n1443", { faction = "Horde" }),
        D(1424, L("Fel’zerul à Stonard veut que vous rassembliez 10 Artefacts atal'ai.", "Fel'zerul in Stonard wants you to gather 10 Atal'ai Artifacts."), { faction = "Horde" }),
        T(1424, "n1443", { faction = "Horde" }),
        A(1429, "n1443", { faction = "Horde" }),
        T(1429, "n5598", { faction = "Horde" }),
        A(1444, "n5598", { faction = "Horde" }),
        T(1444, "n1443", { faction = "Horde" }),
        A(1448, "n5384", { faction = "Alliance" }),
        T(1448, "n5384", { faction = "Alliance" }),
        A(1449, "n5384", { faction = "Alliance" }),
        T(1449, "n5635", { faction = "Alliance" }),
        A(1450, "n5635", { faction = "Alliance" }),
        T(1450, "n5636", { faction = "Alliance" }),
        A(1451, "n5636", { faction = "Alliance" }),
        T(1451, "n5634", { faction = "Alliance" }),
        A(1452, "n5634", { faction = "Alliance" }),
        D(1452, L("Rhapsody Shindigger dans les Hinterlands veut que vous lui rameniez 3 Gésiers de roc, 3 Foies de Groddoc et...", "Rhapsody Shindigger in The Hinterlands wants you to bring him 3 Roc Gizzards, 3 Groddoc Livers and 3 Ironfu..."), { faction = "Alliance", targets = { "n5428", "n5429", "n5430", "n5268", "n5272", "n5274" } }),
        T(1452, "n5634", { faction = "Alliance" }),
        A(1469, "n5634", { faction = "Alliance" }),
        T(1469, "n5384", { faction = "Alliance" }),
        A(3445, "n7900", { faction = "Alliance" }),
        T(3445, "n7771", { faction = "Alliance" }),
        A(3520, "n8579"),
        D(3520, L("Capturer l’Esprit de 3 Hurleurs en Feralas, puis retourner voir Yeh'kinya à Port Gentepression.", "Capture the spirits of 3 screechers in Feralas, then return to Yeh'kinya in Steamwheedle Port."), { targets = { "n8612" } }),
        T(3520, "n8579"),
        A(3527, "n8579"),
        D(3527, L("Apporter les Première et Deuxième tablettes Mosh'Aru à Yeh'kinya, à Tanaris.", "Bring the First and Second Mosh'aru Tablets to Yeh'kinya in Tanaris."), { targets = { "n7272", "n7791", "n7795" } }),
        T(3527, "n8579"),
        A(4787, "n8579"),
        D(4787, L("Apporter l'Oeuf antique à Yeh'kinya à Tanaris.", "Bring the Ancient Egg to Yeh'kinya in Tanaris.")),
        T(4787, "n8579"),
        A(4145, "n9118", { faction = "Horde" }),
        D(4145, L("Chasser 5 Flagellants Pétale-de-sang, 5 Batteurs Pétale-de-sang, 5 Ecorcheurs Pétale-de-sang et 5 Trappeurs...", "Hunt 5 Bloodpetal Lashers, 5 Bloodpetal Threshers, 5 Bloodpetal Flayers and 5 Bloodpetal Trappers for Lario..."), { faction = "Horde", targets = { "n6509", "n6512", "n6510", "n6511" } }),
        T(4145, "n9118", { faction = "Horde" }),
        A(4147, "n9118", { faction = "Horde" }),
        T(4147, "n8496", { faction = "Horde" }),
        -- Accept the dungeon quests
        A(1445, "n1443", { faction = "Horde" }),
        A(1446, "n5598"),
        A(1475, "n5384", { faction = "Alliance" }),
        A(3373, nil, { text = L("Objet de quête : Essence d'Eranikus", "Quest item: Essence of Eranikus"), targets = { "n5709" } }),
        A(3380, "n8115", { faction = "Horde" }),
        A(3528, "n8579"),
        A(4146, "n8496", { faction = "Horde" }),
        A(8733, "n15362"),
        -- Inside the dungeon
        D(1445, L("Rassembler 20 Fétiches d'Hakkar et les apporter à Fel’Zerul à Stonard.", "Collect 20 Fetishes of Hakkar and bring them to Fel'Zerul in Stonard."), { faction = "Horde", targets = { "n5243", "n5256", "n5259", "n5261" } }),
        D(1446, L("L'Exilé atal'ai des Hinterlands veut la Tête de Jammal'an.", "The Atal'ai Exile in The Hinterlands wants the Head of Jammal'an."), { targets = { "n5710" } }),
        D(1475, L("Rassembler 10 Tablettes atal'ai pour Brohann Caskbelly à Stormwind.", "Gather 10 Atal'ai Tablets for Brohann Caskbelly in Stormwind."), { faction = "Alliance" }),
        D(3528, L("Apporter l'Oeuf Rempli d'Hakkar à Yeh'kinya dans Tanaris.", "Bring the Filled Egg of Hakkar to Yeh'kinya in Tanaris.")),
        D(4146, L("Remettre la Baguette déchargée et 5 Echantillons de brume atal'ai à Larion au refuge des Marshal.", "Deliver the Unloaded Zapper and 5 samples of Atal'ai Haze to Larion in Marshal's Refuge."), { faction = "Horde", targets = { "n5226", "n5228", "n8384" } }),
        -- Turn-ins
        T(1445, "n1443", { faction = "Horde" }),
        T(1446, "n5598"),
        T(1475, "n5384", { faction = "Alliance" }),
        T(3373, nil, { text = L("Objet : Réceptacle d'essence", "Object: Essence Font") }),
        T(3380, "n7771", { faction = "Horde" }),
        A(3444, "n7771"),
        D(3444, L("Récupérer le Cercle de pierres à l'Atelier de Marvon Rivetseeker à Ratchet.", "Retrieve the Stone Circle from Marvon Rivetseeker's workshop in Ratchet.")),
        T(3444, "n7771"),
        A(3446, "n7771"),
        A(3447, "n7771"),
        T(3446, nil, { text = L("Objet : Autel d'Hakkar", "Object: Altar of Hakkar") }),
        T(3447, nil, { text = L("Objet : Idole d'Hakkar", "Object: Idol of Hakkar") }),
        T(3528, "n8579"),
        T(4146, "n9118", { faction = "Horde" }),
        T(8733, "n15624"),
    },
} end)
