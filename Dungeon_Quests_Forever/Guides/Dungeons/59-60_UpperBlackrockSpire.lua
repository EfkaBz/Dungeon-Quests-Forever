local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Upper Blackrock Spire (59-60) - AUTO-GENERATED from the Questie classic DB
-- Classic version: every quest of the dungeon + all its pre-quests.
-- Class, profession and repeatable quests are not listed.
-- Forever changes will be added as they are known. Verify in game.
-- Wing assignment: Rookery, Rend, The Beast, Drakkisath, Valthalak.
-- ===================================================================

N.n9562 = { id = 9562, name = "Helendis Riverhorn", map = 1428, x = 85.8, y = 69.0 }
N.n7047 = { id = 7047, name = "Black Broodling", map = 1428, x = 86.9, y = 30.6 }
N.n7040 = { id = 7040, name = "Black Dragonspawn", map = 1428, x = 85.4, y = 27.2 }
N.n7044 = { id = 7044, name = "Black Drake", map = 1428, x = 89.9, y = 43.9 }
N.n7041 = { id = 7041, name = "Black Wyrmkin", map = 1428, x = 88.4, y = 40.0 }
N.n344 = { id = 344, name = "Magistrate Solomon", map = 1433, x = 30.0, y = 44.5 }
N.n1748 = { id = 1748, name = "Highlord Bolvar Fordragon", map = 1453, x = 78.2, y = 18.0 }
N.n9560 = { id = 9560, name = "Marshal Maxwell", map = 1428, x = 84.7, y = 69.0 }
N.n9023 = { id = 9023, name = "Marshal Windsor" }
N.n8889 = { id = 8889, name = "Anvilrage Overseer" }
N.n8890 = { id = 8890, name = "Anvilrage Warden" }
N.n8891 = { id = 8891, name = "Anvilrage Guardsman" }
N.n9033 = { id = 9033, name = "General Angerforge" }
N.n8983 = { id = 8983, name = "Golem Lord Argelmach" }
N.n10267 = { id = 10267, name = "Tinkee Steamboil", map = 1428, x = 65.2, y = 24.0 }
N.n10468 = { id = 10468, name = "Felnok Steelspring", map = 1452, x = 61.6, y = 38.6 }
N.n7447 = { id = 7447, name = "Fledgling Chillwind", map = 1452, x = 29.6, y = 48.5 }
N.n7448 = { id = 7448, name = "Chillwind Chimaera", map = 1452, x = 68.5, y = 52.8 }
N.n7449 = { id = 7449, name = "Chillwind Ravager", map = 1452, x = 60.4, y = 21.8 }
N.n9077 = { id = 9077, name = "Warlord Goretooth", map = 1418, x = 5.8, y = 47.5 }
N.n4949 = { id = 4949, name = "Thrall", map = 1454, x = 31.7, y = 37.8 }
N.n12580 = { id = 12580, name = "Reginald Windsor", map = 1429, x = 32.2, y = 49.6 } -- appears at the Stormwind gates (Elwynn)
N.n10929 = { id = 10929, name = "Haleh", map = 1452, x = 54.5, y = 51.2 }
N.n10182 = { id = 10182, name = "Rexxar", map = 1444, x = 46.4, y = 18.2 }
N.n11872 = { id = 11872, name = "Myranda the Hag", map = 1422, x = 50.8, y = 77.8 }
N.n10321 = { id = 10321, name = "Emberstrife", map = 1445, x = 56.7, y = 87.7 }
N.n10664 = { id = 10664, name = "Scryer", map = 1452, x = 52.7, y = 55.9 }
N.n12900 = { id = 12900, name = "Somnus", map = 1435, x = 74.1, y = 68.3 }
N.n8197 = { id = 8197, name = "Chronalis", map = 1446, x = 64.2, y = 48.5 }
N.n12899 = { id = 12899, name = "Axtroz", map = 1437, x = 81.8, y = 48.2 }
N.n16013 = { id = 16013, name = "Deliana", map = 1455, x = 43.5, y = 52.6 }
N.n16033 = { id = 16033, name = "Bodley" }
N.n16012 = { id = 16012, name = "Mokvar", map = 1454, x = 35.0, y = 38.3 }
N.n9017 = { id = 9017, name = "Lord Incendius" }
N.n9816 = { id = 9816, name = "Pyroguard Emberseer" }
N.n15206 = { id = 15206, name = "The Duke of Cynders" }
N.n11730 = { id = 11730, name = "Hive'Regal Ambusher", map = 1451, x = 49.3, y = 80.1 }
N.n11731 = { id = 11731, name = "Hive'Regal Burrower", map = 1451, x = 64.9, y = 71.3 }
N.n11732 = { id = 11732, name = "Hive'Regal Spitfire", map = 1451, x = 51.6, y = 79.8 }
N.n11733 = { id = 11733, name = "Hive'Regal Slavemaker", map = 1451, x = 50.9, y = 94.0 }
N.n7428 = { id = 7428, name = "Frostmaul Giant", map = 1452, x = 65.7, y = 69.3 }
N.n7429 = { id = 7429, name = "Frostmaul Preserver", map = 1452, x = 64.2, y = 72.2 }
N.n9448 = { id = 9448, name = "Scarlet Praetorian", map = 1423, x = 88.5, y = 84.5 }
N.n7071 = { id = 7071, name = "Cursed Paladin", map = 1424, x = 19.1, y = 80.6 }
N.n7072 = { id = 7072, name = "Cursed Justicar", map = 1424, x = 15.3, y = 81.8 }
N.n7075 = { id = 7075, name = "Writhing Mage", map = 1424, x = 15.5, y = 77.4 }
N.n16097 = { id = 16097, name = "Isalien" }
N.n16080 = { id = 16080, name = "Mor Grayhoof" }
N.n16101 = { id = 16101, name = "Jarien" }
N.n16102 = { id = 16102, name = "Sothos" }
N.n16118 = { id = 16118, name = "Kormok" }
N.n4364 = { id = 4364, name = "Strashaz Warrior", map = 1445, x = 74.8, y = 15.1 }
N.n4366 = { id = 4366, name = "Strashaz Serpent Guard", map = 1445, x = 75.6, y = 22.0 }
N.n4370 = { id = 4370, name = "Strashaz Sorceress", map = 1445, x = 76.5, y = 22.2 }
N.n4371 = { id = 4371, name = "Strashaz Siren", map = 1445, x = 74.3, y = 18.4 }
N.n9044 = { id = 9044, name = "Scarshield Sentry" }
N.n9045 = { id = 9045, name = "Scarshield Acolyte" }
N.n9097 = { id = 9097, name = "Scarshield Legionnaire" }
N.n9098 = { id = 9098, name = "Scarshield Spellbinder" }
N.n10776 = { id = 10776, name = "Finkle Einhorn" }
N.n9568 = { id = 9568, name = "Overlord Wyrmthalak" }
N.n10740 = { id = 10740, name = "Awbee" }
N.n9196 = { id = 9196, name = "Highlord Omokk" }
N.n9237 = { id = 9237, name = "War Master Voone" }
N.n335 = { id = 335, name = "Singe", map = 1433, x = 69.8, y = 56.1 }
N.n9197 = { id = 9197, name = "Spirestone Battle Mage" }
N.n9198 = { id = 9198, name = "Spirestone Mystic" }
N.n10429 = { id = 10429, name = "Warchief Rend Blackhand" }
N.n10363 = { id = 10363, name = "General Drakkisath" }
N.n9096 = { id = 9096, name = "Rage Talon Dragonspawn" }
N.n10083 = { id = 10083, name = "Rage Talon Flamescale" }
N.n10258 = { id = 10258, name = "Rookery Guardian" }
N.n16042 = { id = 16042, name = "Lord Valthalak" }
N.n10637 = { id = 10637, name = "Malyfous Darkhammer", map = 1452, x = 61.0, y = 38.8 }
N.n16073 = { id = 16073, name = "Spirit of Lord Valthalak" }

ns:RegisterDungeon("UBRS", function() return {
    name = L("Sommet du pic Rochenoire", "Upper Blackrock Spire"),
    levels = "59-60",
    icon = "Interface\\Icons\\INV_Misc_Head_Dragon_Black",
    entrance = { map = 1427, x = 34.8, y = 85.3 },
    titles = {
        [4182] = L("La menace des draconiens", "Dragonkin Menace"),
        [4183] = L("Les véritables maîtres", "The True Masters"),
        [4184] = L("Les véritables maîtres", "The True Masters"),
        [4185] = L("Les véritables maîtres", "The True Masters"),
        [4186] = L("Les véritables maîtres", "The True Masters"),
        [4223] = L("Les véritables maîtres", "The True Masters"),
        [4224] = L("Les véritables maîtres", "The True Masters"),
        [4241] = L("Maréchal Windsor", "Marshal Windsor"),
        [4242] = L("Espoir abandonné", "Abandoned Hope"),
        [4264] = L("Une Note chiffonnée", "A Crumpled Up Note"),
        [4282] = L("Un espoir en lambeaux", "A Shred of Hope"),
        [4322] = L("Evasion !", "Jail Break!"),
        [4726] = L("L'essence de rejeton", "Broodling Essence"),
        [4808] = L("Felnok Steelspring", "Felnok Steelspring"),
        [4809] = L("Cornes de Noroît", "Chillwind Horns"),
        [4810] = L("Retourner voir Tinkee", "Return to Tinkee"),
        [4734] = L("Un oeuf congelé", "Egg Freezing"),
        [4735] = L("La collecte d'oeufs", "Egg Collection"),
        [4903] = L("Ordre du chef de guerre", "Warlord's Command"),
        [4907] = L("Tinkee Steamboil", "Tinkee Steamboil"),
        [4941] = L("Sagesse d'Eitrigg", "Eitrigg's Wisdom"),
        [4974] = L("Pour la Horde !", "For The Horde!"),
        [5047] = L("Pépin Preste-Jugeote, à votre service !", "Finkle Einhorn, At Your Service!"),
        [5089] = L("Ordres du général Drakkisath", "General Drakkisath's Command"),
        [5102] = L("La reddition du général Drakkisath", "General Drakkisath's Demise"),
        [5160] = L("Le Protectorat de la matrone", "The Matron Protectorate"),
        [6402] = L("Le rendez-vous à Stormwind", "Stormwind Rendezvous"),
        [6403] = L("La grande mascarade", "The Great Masquerade"),
        [6501] = L("L'Œil de dragon", "The Dragon's Eye"),
        [6502] = L("Amulette drakefeu", "Drakefire Amulet"),
        [6566] = L("Ce que le vent apporte", "What the Wind Carries"),
        [6567] = L("Le Champion de la Horde", "The Champion of the Horde"),
        [6568] = L("Le testament de Rexxar", "The Testament of Rexxar"),
        [6569] = L("Illusions d'Occulus", "Oculus Illusions"),
        [6570] = L("Brandeguerre", "Emberstrife"),
        [6582] = L("L'épreuve des crânes, Clairvoyant", "The Test of Skulls, Scryer"),
        [6583] = L("L'épreuve des crânes, Somnus", "The Test of Skulls, Somnus"),
        [6584] = L("L'épreuve des crânes, Chronalis", "The Test of Skulls, Chronalis"),
        [6585] = L("L'épreuve des crânes, Axtroz", "The Test of Skulls, Axtroz"),
        [6601] = L("Ascension...", "Ascension..."),
        [6602] = L("Le sang du champion des dragons noirs", "Blood of the Black Dragon Champion"),
        [8960] = L("Le triste destin de Bodley", "Bodley's Unfortunate Fate"),
        [9032] = L("Le triste destin de Bodley", "Bodley's Unfortunate Fate"),
        [8961] = L("Les trois rois des flammes", "Three Kings of Flame"),
        [8962] = L("Des composants importants", "Components of Importance"),
        [8963] = L("Des composants importants", "Components of Importance"),
        [8964] = L("Des composants importants", "Components of Importance"),
        [8965] = L("Des composants importants", "Components of Importance"),
        [8966] = L("Le morceau gauche de l'amulette du seigneur Valthalak", "The Left Piece of Lord Valthalak's Amulet"),
        [8967] = L("Le morceau gauche de l'amulette du seigneur Valthalak", "The Left Piece of Lord Valthalak's Amulet"),
        [8968] = L("Le morceau gauche de l'amulette du seigneur Valthalak", "The Left Piece of Lord Valthalak's Amulet"),
        [8969] = L("Le morceau gauche de l'amulette du seigneur Valthalak", "The Left Piece of Lord Valthalak's Amulet"),
        [8970] = L("Votre avenir passe par l'île d'Alcaz", "I See Alcaz Island In Your Future..."),
        [8985] = L("D'autres composants importants", "More Components of Importance"),
        [8986] = L("D'autres composants importants", "More Components of Importance"),
        [8987] = L("D'autres composants importants", "More Components of Importance"),
        [8988] = L("D'autres composants importants", "More Components of Importance"),
        [8989] = L("Le morceau droit de l'amulette du seigneur Valthalak", "The Right Piece of Lord Valthalak's Amulet"),
        [8990] = L("Le morceau droit de l'amulette du seigneur Valthalak", "The Right Piece of Lord Valthalak's Amulet"),
        [8991] = L("Le morceau droit de l'amulette du seigneur Valthalak", "The Right Piece of Lord Valthalak's Amulet"),
        [8992] = L("Le morceau droit de l'amulette du seigneur Valthalak", "The Right Piece of Lord Valthalak's Amulet"),
        [8994] = L("Derniers préparatifs", "Final Preparations"),
        [8995] = L("Mea culpa, seigneur Valthalak", "Mea Culpa, Lord Valthalak"),
    },
    steps = {
        -- Pre-quests
        A(4182, "n9562", { faction = "Alliance" }),
        D(4182, L("Tuer 15 Rejetons noirs, 10 Draconides noirs, 4 Wyrmides noirs et 1 Drake noir. Retrouver Helendis Riverhorn...", "Slay 15 Black Broodlings, 10 Black Dragonspawn, 4 Black Wyrmkin and 1 Black Drake. Return to Helendis River..."), { faction = "Alliance", targets = { "n7047", "n7040", "n7044", "n7041" } }),
        T(4182, "n9562", { faction = "Alliance" }),
        A(4183, "n9562", { faction = "Alliance" }),
        T(4183, "n344", { faction = "Alliance" }),
        A(4184, "n344", { faction = "Alliance" }),
        T(4184, "n1748", { faction = "Alliance" }),
        A(4185, "n1748", { faction = "Alliance" }),
        T(4185, "n1748", { faction = "Alliance" }),
        A(4186, "n1748", { faction = "Alliance" }),
        T(4186, "n344", { faction = "Alliance" }),
        A(4223, "n344", { faction = "Alliance" }),
        T(4223, "n9560", { faction = "Alliance" }),
        A(4224, "n9560", { faction = "Alliance" }),
        T(4224, "n9560", { faction = "Alliance" }),
        A(4241, "n9560", { faction = "Alliance" }),
        T(4241, "n9023", { faction = "Alliance" }),
        A(4242, "n9023", { faction = "Alliance" }),
        T(4242, "n9560", { faction = "Alliance" }),
        A(4264, nil, { text = L("Objet de quête : Une note chiffonnée", "Quest item: A Crumpled Up Note"), targets = { "n8889", "n8890", "n8891" }, faction = "Alliance" }),
        T(4264, "n9023", { faction = "Alliance" }),
        A(4282, "n9023", { faction = "Alliance" }),
        D(4282, L("Rapporter les Renseignements perdus du maréchal Windsor.", "Return Marshal Windsor's Lost Information."), { faction = "Alliance", targets = { "n9033", "n8983" } }),
        T(4282, "n9023", { faction = "Alliance" }),
        A(4322, "n9023", { faction = "Alliance" }),
        T(4322, "n9560", { faction = "Alliance" }),
        A(4726, "n10267"),
        D(4726, L("Apporter 8 Essences de Rejeton et le Draco-Incarcinatrix 900 à Tinkee Steamboil à la Corniche des flammes d...", "Bring 8 Broodling Essence and the Draco-Incarcinatrix 900 to Tinkee Steamboil at the Flame Crest in the Bur...")),
        T(4726, "n10267"),
        A(4808, "n10267"),
        T(4808, "n10468"),
        A(4809, "n10468"),
        D(4809, L("Apporter 8 Cornes intactes de Noroît à Felnok Steelspring.", "Bring 8 Uncracked Chillwind Horns to Felnok Steelspring."), { targets = { "n7447", "n7448", "n7449" } }),
        T(4809, "n10468"),
        A(4810, "n10468"),
        T(4810, "n10267"),
        A(6402, "n9560", { faction = "Alliance" }),
        T(6402, "n12580", { faction = "Alliance" }),
        A(6403, "n12580", { faction = "Alliance" }),
        T(6403, "n1748", { faction = "Alliance" }),
        A(6501, "n1748", { faction = "Alliance" }),
        T(6501, "n10929", { faction = "Alliance" }),
        A(8960, "n16013", { faction = "Alliance" }),
        T(8960, "n16033", { faction = "Alliance" }),
        A(9032, "n16012", { faction = "Horde" }),
        T(9032, "n16033", { faction = "Horde" }),
        A(8961, "n16033"),
        D(8961, L("Récupérez l’Incendicite d’Incendius, la Braise du prophète ardent sur le pyrogarde Prophète ardent et les C...", "Gather the Incendicite of Incendius, the Ember of Emberseer and the Cinder of Cynders, along with a Hallowe..."), { targets = { "n9017", "n9816", "n15206" } }),
        T(8961, "n16033"),
        A(8962, "n16033"),
        D(8962, L("Procurez-vous des Restes druidiques et rapportez-les à Bodley, à l’intérieur du mont Rochenoire.", "Acquire Druidical Remains and return them to Bodley inside Blackrock Mountain."), { targets = { "n11730", "n11731", "n11732", "n11733" } }),
        T(8962, "n16033"),
        A(8963, "n16033"),
        D(8963, L("Procurez-vous une Relique de Brise-Stellaire et rapportez-la à Bodley, à l’intérieur du Mont Rochenoire.", "Acquire a Starbreeze Village Relic and return it to Bodley inside Blackrock Mountain."), { targets = { "n7428", "n7429" } }),
        T(8963, "n16033"),
        A(8964, "n16033"),
        D(8964, L("Procurez-vous une Épée brillante de fanatisme, puis rapportez-la à Bodley, à l’intérieur du mont Rochenoire.", "Retrieve a Brilliant Sword of Zealotry and return it to Bodley inside Blackrock Mountain."), { targets = { "n9448" } }),
        T(8964, "n16033"),
        A(8965, "n16033"),
        D(8965, L("Prélevez des Cendres d’âme de banni, puis retournez voir Bodley à l’intérieur du mont Rochenoire.", "Obtain Soul Ashes of the Banished and return them to Bodley inside Blackrock Mountain."), { targets = { "n7071", "n7072", "n7075" } }),
        T(8965, "n16033"),
        A(8967, "n16033"),
        D(8967, L("Utilisez le Brasero de signal pour invoquer l’esprit d’Isalien, puis tuez-le. Retournez voir Bodley, à l'in...", "Use the Brazier of Beckoning to summon forth the spirit of Isalien and slay her. Return to Bodley inside Bl..."), { targets = { "n16097", "n16080", "n16101", "n16102" } }),
        T(8967, "n16033"),
        A(8968, "n16033"),
        D(8968, L("Utilisez le Brasero de signal pour invoquer Jarien et Sothos et les tuer. Retournez voir Bodley, à l'intéri...", "Use the Brazier of Beckoning to summon forth Jarien and Sothos and slay them. Return to Bodley inside Black..."), { targets = { "n16101", "n16102", "n16080", "n16097" } }),
        T(8968, "n16033"),
        A(8969, "n16033"),
        D(8969, L("Utilisez le Brasero de signal pour invoquer l’esprit de Kormok, puis tuez-le. Retournez voir Bodley, à l'in...", "Use the Brazier of Beckoning to summon forth the spirit of Kormok and slay him. Return to Bodley inside Bla..."), { targets = { "n16118", "n16080", "n16097", "n16101", "n16102" } }),
        T(8969, "n16033"),
        -- Accept the dungeon quests
        A(4734, "n10267"),
        A(4903, "n9077", { faction = "Horde" }),
        A(4907, "n10468"),
        A(5047, "n10776"),
        A(5089, nil, { text = L("Objet de quête : Ordres du général Drakkisath", "Quest item: General Drakkisath's Command"), targets = { "n9568" }, faction = "Alliance" }),
        A(5160, "n10740"),
        A(6502, "n10929", { faction = "Alliance" }),
        A(8966, "n16033"),
        -- Inside the dungeon
        D(4903, L("Tuer le généralissime Omokk, le maître de guerre Voone et le seigneur Wyrmthalak. Récupérer les Importants ...", "Slay Highlord Omokk, War Master Voone, and Overlord Wyrmthalak. Recover Important Blackrock Documents. Retu..."), { faction = "Horde", targets = { "n9568", "n9196", "n9237", "n335", "n9197", "n9198" } }),
        D(6502, L("Récupérer le Sang du Champion des dragons noirs sur le général Drakkisath. Il se trouve dans sa salle du tr...", "You must retrieve the Blood of the Black Dragon Champion from General Drakkisath. Drakkisath can be found i..."), { faction = "Alliance", targets = { "n10363" } }),
        D(8966, L("Utilisez le Brasero de signal pour invoquer l’esprit de Mor Sabot-gris, puis tuez-le. Ensuite, retournez vo...", "Use the Brazier of Beckoning to summon forth the spirit of Mor Grayhoof and slay him. Return to Bodley insi..."), { targets = { "n16080", "n16097", "n16101", "n16102" } }),
        -- Turn-ins
        T(4734, "n10267"),
        T(4903, "n9077", { faction = "Horde" }),
        A(4941, "n9077", { faction = "Horde" }),
        T(4941, "n4949", { faction = "Horde" }),
        A(4974, "n4949", { faction = "Horde" }),
        D(4974, L("Aller au Pic Blackrock et tuer le Chef de guerre, Rend Blackhand. Prendre sa tête et retourner à Orgrimmar.", "Travel to Blackrock Spire and slay Warchief Rend Blackhand. Take his head and return to Orgrimmar."), { faction = "Horde", targets = { "n10429" } }),
        T(4907, "n10267"),
        T(4974, "n4949", { faction = "Horde" }),
        A(6566, "n4949", { faction = "Horde" }),
        T(6566, "n4949", { faction = "Horde" }),
        A(6567, "n4949", { faction = "Horde" }),
        T(6567, "n10182", { faction = "Horde" }),
        A(6568, "n10182", { faction = "Horde" }),
        T(6568, "n11872", { faction = "Horde" }),
        A(6569, "n11872", { faction = "Horde" }),
        D(6569, L("Aller au Pic Blackrock et collecter 20 Yeux de draconide noir. Retourner voir Myranda la Mégère, quand la t...", "Travel to Blackrock Spire and collect 20 Black Dragonspawn Eyes. Return to Myranda the Hag when the task is..."), { faction = "Horde", targets = { "n9096", "n9568", "n10083", "n10258" } }),
        T(5047, "n10637"),
        T(5089, "n9560", { faction = "Alliance" }),
        T(5160, "n10929"),
        T(6502, "n10929", { faction = "Alliance" }),
        T(6569, "n11872", { faction = "Horde" }),
        A(6570, "n11872", { faction = "Horde" }),
        T(6570, "n10321", { faction = "Horde" }),
        A(6582, "n10321", { faction = "Horde" }),
        D(6582, L("Vous devez trouver Clairvoyant, le drake champion du Vol bleu, et le tuer. Arracher son crâne à son cadavre...", "You must find the blue dragonflight drake champion, Scryer, and slay him. Pry his skull from his corpse and..."), { faction = "Horde", targets = { "n10664" } }),
        T(6582, "n10321", { faction = "Horde" }),
        A(6583, "n10321", { faction = "Horde" }),
        D(6583, L("Détruire le Champion drake du Vol vert, Somnus. Arracher son crâne à son cadavre, puis le rapporter à Brand...", "Destroy the drake champion of the Green Flight, Somnus. Take his skull and return it to Emberstrife."), { faction = "Horde", targets = { "n12900" } }),
        T(6583, "n10321", { faction = "Horde" }),
        A(6584, "n10321", { faction = "Horde" }),
        D(6584, L("Chronalis, enfant de Nozdormu, garde les Grottes du temps, dans le Désert de Tanaris. Tuez-le et rapportez ...", "Guarding the Caverns of Time in the Tanaris Desert is Chronalis, child of Nozdormu. Destroy him and return ..."), { faction = "Horde", targets = { "n8197" } }),
        T(6584, "n10321", { faction = "Horde" }),
        A(6585, "n10321", { faction = "Horde" }),
        D(6585, L("Aller à Grim Batol et traquer Axtroz, le Champion drake du Vol rouge. Le tuer et arracher son crâne, puis l...", "Travel to Grim Batol and track down Axtroz, drake champion of the Red Flight. Destroy him and take his skul..."), { faction = "Horde", targets = { "n12899" } }),
        T(6585, "n10321", { faction = "Horde" }),
        A(6601, "n10321", { faction = "Horde" }),
        T(6601, "n10182", { faction = "Horde" }),
        A(6602, "n10182", { faction = "Horde" }),
        D(6602, L("Aller au Pic Blackrock, et tuer le général Drakkisath. Récupérer son sang et retourner voir Rexxar.", "Travel to Blackrock Spire and slay General Drakkisath. Gather his blood and return it to Rexxar."), { faction = "Horde", targets = { "n10363" } }),
        T(6602, "n10182", { faction = "Horde" }),
        T(8966, "n16033"),
        A(8970, "n16033"),
        D(8970, L("Récupérez 20 Varechs de sang sur les nagas Strashaz, puis retournez voir Bodley au mont Rochenoire.", "Gather 20 Bloodkelp from the Strashaz naga and then return to Bodley inside Blackrock Mountain."), { targets = { "n4364", "n4366", "n4370", "n4371" } }),
        T(8970, "n16033"),
        A(8985, "n16033"),
        D(8985, L("Procurez-vous une Relique de Brise-Stellaire et rapportez-la à Bodley, à l’intérieur du Mont Rochenoire.", "Acquire a Starbreeze Village Relic and return it to Bodley inside Blackrock Mountain."), { targets = { "n7428", "n7429" } }),
        T(8985, "n16033"),
        A(8986, "n16033"),
        D(8986, L("Procurez-vous des Restes druidiques et rapportez-les à Bodley, à l’intérieur du mont Rochenoire.", "Acquire Druidical Remains and return them to Bodley inside Blackrock Mountain."), { targets = { "n11730", "n11731", "n11732", "n11733" } }),
        T(8986, "n16033"),
        A(8987, "n16033"),
        D(8987, L("Procurez-vous une Épée brillante de fanatisme, puis rapportez-la à Bodley, à l’intérieur du mont Rochenoire.", "Retrieve a Brilliant Sword of Zealotry and return it to Bodley inside Blackrock Mountain."), { targets = { "n9448" } }),
        T(8987, "n16033"),
        A(8988, "n16033"),
        D(8988, L("Prélevez des Cendres d’âme de banni, puis retournez voir Bodley à l’intérieur du mont Rochenoire.", "Obtain Soul Ashes of the Banished and return them to Bodley inside Blackrock Mountain."), { targets = { "n7071", "n7072", "n7075" } }),
        T(8988, "n16033"),
        A(8990, "n16033"),
        D(8990, L("Utilisez le Brasero de signal pour invoquer l’esprit d’Isalien, puis tuez-le. Retournez voir Bodley, à l'in...", "Use the Brazier of Beckoning to summon forth the spirit of Isalien and slay her. Return to Bodley inside Bl..."), { targets = { "n16097" } }),
        T(8990, "n16033"),
        A(8991, "n16033"),
        D(8991, L("Utilisez le Brasero de signal pour invoquer Jarien et Sothos, puis tuez-les. Retournez voir Bodley, à l'int...", "Use the Brazier of Beckoning to summon forth Jarien and Sothos and slay them. Return to Bodley inside Black..."), { targets = { "n16101", "n16102" } }),
        T(8991, "n16033"),
        A(8992, "n16033"),
        D(8992, L("Utilisez le Brasero de signal pour invoquer l’esprit de Kormok, puis tuez-le. Retournez voir Bodley, à l'in...", "Use the Brazier of Beckoning to summon forth the spirit of Kormok and slay him. Return to Bodley inside Bla..."), { targets = { "n16118" } }),
        T(8992, "n16033"),
        A(8989, "n16033"),
        D(8989, L("Utilisez le Brasero de signal pour invoquer l’esprit de Mor Sabot-gris, puis tuez-le. Ensuite, retournez vo...", "Use the Brazier of Beckoning to summon forth the spirit of Mor Grayhoof and slay him. Return to Bodley insi..."), { targets = { "n16080" } }),
        T(8989, "n16033"),
        A(8994, "n16033"),
        D(8994, L("Collectez 40 Brassards rochenoire et un Flacon de pouvoir suprême. Ensuite, retournez voir Bodley au mont R...", "Gather 40 Blackrock Bracers and acquire a Flask of Supreme Power. Return them to Bodley inside Blackrock Mo..."), { targets = { "n9044", "n9045", "n9097", "n9098" } }),
        T(8994, "n16033"),
        A(8995, "n16033"),
        D(8995, L("Utilisez le Brasero de signal pour invoquer le seigneur Valthalak. Tuez-le, puis utilisez l’Amulette du sei...", "Use the Brazier of Beckoning to summon Lord Valthalak. Dispatch him, and use Lord Valthalak's Amulet on the..."), { targets = { "n16042" } }),
        T(8995, "n16073"),
        -- Follow-ups started in the dungeon
        A(4735, "n10267"),
        D(4735, L("Apporter 8 Oeufs de dragon collectés et le Module collectronique à Tinkee Steamboil à la Corniche des flamm...", "Bring 8 Collected Dragon Eggs and the Collectronic Module to Tinkee Steamboil at Flame Crest in the Burning...")),
        T(4735, "n10267"),
        A(5102, "n9560", { faction = "Alliance" }),
        D(5102, L("Rendez-vous au Pic Blackrock et tuez le général Drakkisath, puis retournez voir le maréchal Maxwell.", "Travel to Blackrock Spire and destroy General Drakkisath. Return to Marshal Maxwell when the job is done."), { faction = "Alliance", targets = { "n10363" } }),
        T(5102, "n9560", { faction = "Alliance" }),
    },
} end)
