local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Blackrock Depths (52-60) - AUTO-GENERATED from the Questie classic DB
-- Classic version: every quest of the dungeon + all its pre-quests.
-- Class, profession and repeatable quests are not listed.
-- Forever changes will be added as they are known. Verify in game.
-- ===================================================================

N.n8479 = { id = 8479, name = "Kalaran Windblade", map = 1427, x = 39.1, y = 39.0 }
N.n5850 = { id = 5850, name = "Blazing Elemental", map = 1427, x = 58.3, y = 77.0 }
N.n5852 = { id = 5852, name = "Inferno Elemental", map = 1427, x = 39.7, y = 58.6 }
N.n5855 = { id = 5855, name = "Magma Elemental", map = 1427, x = 30.1, y = 59.7 }
N.n5853 = { id = 5853, name = "Tempered War Golem", map = 1427, x = 68.1, y = 33.5 }
N.n5854 = { id = 5854, name = "Heavy War Golem", map = 1427, x = 46.5, y = 38.0 }
N.n5839 = { id = 5839, name = "Dark Iron Geologist", map = 1427, x = 69.3, y = 32.7 }
N.n5840 = { id = 5840, name = "Dark Iron Steamsmith", map = 1427, x = 38.1, y = 51.4 }
N.n5843 = { id = 5843, name = "Slave Worker", map = 1427, x = 39.9, y = 27.8 }
N.n5844 = { id = 5844, name = "Dark Iron Slaver", map = 1427, x = 44.4, y = 31.1 }
N.n5860 = { id = 5860, name = "Twilight Dark Shaman", map = 1427, x = 24.1, y = 34.2 }
N.n5861 = { id = 5861, name = "Twilight Fire Guard", map = 1427, x = 19.6, y = 38.6 }
N.n5862 = { id = 5862, name = "Twilight Geomancer", map = 1427, x = 17.9, y = 38.1 }
N.n8419 = { id = 8419, name = "Twilight Idolater", map = 1427, x = 29.1, y = 26.7 }
N.n8509 = { id = 8509, name = "Squire Maltrake", map = 1427, x = 39.2, y = 39.0 }
N.n8879 = { id = 8879, name = "Royal Historian Archesonus", map = 1455, x = 38.4, y = 55.3 }
N.n9084 = { id = 9084, name = "Thunderheart", map = 1418, x = 3.3, y = 48.3 }
N.n9026 = { id = 9026, name = "Overmaster Pyron" }
N.n9459 = { id = 9459, name = "Cyrus Therepentous", map = 1428, x = 95.1, y = 31.6 }
N.n5846 = { id = 5846, name = "Dark Iron Taskmaster", map = 1427, x = 38.0, y = 31.9 }
N.n9461 = { id = 9461, name = "Frenzied Black Drake" }
N.n9079 = { id = 9079, name = "Hierophant Theodora Mulvadania", map = 1418, x = 3.0, y = 47.8 }
N.n7032 = { id = 7032, name = "Greater Obsidian Elemental", map = 1428, x = 29.1, y = 62.3 }
N.n7039 = { id = 7039, name = "War Reaver", map = 1428, x = 61.1, y = 35.4 }
N.n8981 = { id = 8981, name = "Malfunctioning Reaver", map = 1428, x = 79.2, y = 29.7 }
N.n2921 = { id = 2921, name = "Lotwil Veriatus", map = 1418, x = 25.9, y = 44.9 }
N.n9562 = { id = 9562, name = "Helendis Riverhorn", map = 1428, x = 85.8, y = 69.0 }
N.n7047 = { id = 7047, name = "Black Broodling", map = 1428, x = 86.9, y = 30.6 }
N.n7040 = { id = 7040, name = "Black Dragonspawn", map = 1428, x = 85.4, y = 27.2 }
N.n7044 = { id = 7044, name = "Black Drake", map = 1428, x = 89.9, y = 43.9 }
N.n7041 = { id = 7041, name = "Black Wyrmkin", map = 1428, x = 88.4, y = 40.0 }
N.n344 = { id = 344, name = "Magistrate Solomon", map = 1433, x = 30.0, y = 44.5 }
N.n1748 = { id = 1748, name = "Highlord Bolvar Fordragon", map = 1453, x = 78.2, y = 18.0 }
N.n9560 = { id = 9560, name = "Marshal Maxwell", map = 1428, x = 84.7, y = 69.0 }
N.n9561 = { id = 9561, name = "Jalinda Sprig", map = 1428, x = 85.4, y = 70.1 }
N.n16013 = { id = 16013, name = "Deliana", map = 1455, x = 43.5, y = 52.6 }
N.n16016 = { id = 16016, name = "Anthion Harmon", map = 1423, x = 30.9, y = 16.8 }
N.n16012 = { id = 16012, name = "Mokvar", map = 1454, x = 35.0, y = 38.3 }
N.n16031 = { id = 16031, name = "Ysida Harmon" }
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
N.n8888 = { id = 8888, name = "Franclorn Forgewright" }
N.n9081 = { id = 9081, name = "Galamav the Marksman", map = 1418, x = 6.0, y = 47.7 }
N.n9080 = { id = 9080, name = "Lexlort", map = 1418, x = 5.9, y = 47.6 }
N.n9536 = { id = 9536, name = "Maxwort Uberglint", map = 1428, x = 65.2, y = 23.9 }
N.n9540 = { id = 9540, name = "Enohar Thunderbrew", map = 1419, x = 63.6, y = 20.6 }
N.n5204 = { id = 5204, name = "Apothecary Zinge", map = 1458, x = 50.1, y = 68.0 }
N.n9706 = { id = 9706, name = "Yorba Screwspigot", map = 1446, x = 67.0, y = 24.0 }
N.n9500 = { id = 9500, name = "Mistress Nagmara" }
N.n9177 = { id = 9177, name = "Oralius", map = 1428, x = 84.6, y = 68.7 }
N.n2784 = { id = 2784, name = "King Magni Bronzebeard", map = 1455, x = 39.1, y = 56.2 }
N.n9021 = { id = 9021, name = "Kharan Mighthammer" }
N.n9078 = { id = 9078, name = "Shadowmage Vivian Lagrave", map = 1418, x = 2.9, y = 47.8 }
N.n9017 = { id = 9017, name = "Lord Incendius" }
N.n8983 = { id = 8983, name = "Golem Lord Argelmach" }
N.n8905 = { id = 8905, name = "Warbringer Construct" }
N.n8906 = { id = 8906, name = "Ragereaver Golem" }
N.n8907 = { id = 8907, name = "Wrath Hammer Construct" }
N.n8908 = { id = 8908, name = "Molten War Golem" }
N.n8891 = { id = 8891, name = "Anvilrage Guardsman" }
N.n8890 = { id = 8890, name = "Anvilrage Warden" }
N.n8892 = { id = 8892, name = "Anvilrage Footman" }
N.n92 = { id = 92, name = "Rock Elemental", map = 1418, x = 45.5, y = 81.4 }
N.n193 = { id = 193, name = "Blue Dragonspawn", map = 1447, x = 39.5, y = 76.4 }
N.n595 = { id = 595, name = "Bloodscalp Hunter", map = 1434, x = 22.7, y = 12.0 }
N.n669 = { id = 669, name = "Skullsplitter Hunter", map = 1434, x = 46.2, y = 43.0 }
N.n659 = { id = 659, name = "El Pollo Grande" }
N.n741 = { id = 741, name = "Dreaming Whelp", map = 1435, x = 14.5, y = 64.2 }
N.n1012 = { id = 1012, name = "Mosshide Brute", map = 1437, x = 35.4, y = 27.6 }
N.n1211 = { id = 1211, name = "Leper Gnome", map = 1426, x = 27.6, y = 36.4 }
N.n6146 = { id = 6146, name = "Cliff Breaker", map = 1447, x = 56.7, y = 79.8 }
N.n6147 = { id = 6147, name = "Cliff Thunderer", map = 1447, x = 62.4, y = 86.8 }
N.n8889 = { id = 8889, name = "Anvilrage Overseer" }
N.n8281 = { id = 8281, name = "Scald", map = 1427, x = 51.1, y = 46.8 }
N.n16059 = { id = 16059, name = "Theldren" }
N.n9020 = { id = 9020, name = "Commander Gor'shak" }
N.n9077 = { id = 9077, name = "Warlord Goretooth", map = 1418, x = 5.8, y = 47.5 }
N.n9520 = { id = 9520, name = "Grark Lorkrub", map = 1428, x = 40.2, y = 34.2 }
N.n1267 = { id = 1267, name = "Ragnar Thunderbrew", map = 1426, x = 46.8, y = 52.4 }
N.n9544 = { id = 9544, name = "Yuka Screwspigot", map = 1428, x = 66.1, y = 21.9 }
N.n9023 = { id = 9023, name = "Marshal Windsor" }
N.n9056 = { id = 9056, name = "Fineous Darkvire" }
N.n4949 = { id = 4949, name = "Thrall", map = 1454, x = 31.7, y = 37.8 }
N.n9019 = { id = 9019, name = "Emperor Dagran Thaurissan" }
N.n8929 = { id = 8929, name = "Princess Moira Bronzebeard" }
N.n8894 = { id = 8894, name = "Anvilrage Medic" }
N.n8893 = { id = 8893, name = "Anvilrage Soldier" }
N.n8895 = { id = 8895, name = "Anvilrage Officer" }
N.n9537 = { id = 9537, name = "Hurley Blackbreath" }
N.n9541 = { id = 9541, name = "Blackbreath Crony" }
N.n9033 = { id = 9033, name = "General Angerforge" }
N.n9543 = { id = 9543, name = "Ribbly Screwspigot" }

ns:RegisterDungeon("BRD", function() return {
    name = L("Profondeurs de Rochenoire", "Blackrock Depths"),
    levels = "52-60",
    icon = "Interface\\Icons\\INV_Hammer_19",
    entrance = { map = 1427, x = 34.8, y = 85.3 },
    titles = {
        [3441] = L("Châtiment divin", "Divine Retribution"),
        [3442] = L("La flamme parfaite", "The Flawless Flame"),
        [3443] = L("Forger le manche", "Forging the Shaft"),
        [3452] = L("L'enveloppe de la flamme", "The Flame's Casing"),
        [3453] = L("La Torche de vindicte", "The Torch of Retribution"),
        [3454] = L("La Torche de vindicte", "The Torch of Retribution"),
        [3462] = L("L'écuyer Maltrake", "Squire Maltrake"),
        [3463] = L("Allumer le feu !", "Set Them Ablaze!"),
        [3481] = L("Bibelots...", "Trinkets..."),
        [3702] = L("Les ruines fumantes de Thaurissan", "The Smoldering Ruins of Thaurissan"),
        [3701] = L("Les ruines fumantes de Thaurissan", "The Smoldering Ruins of Thaurissan"),
        [3801] = L("Héritage Sombrefer", "Dark Iron Legacy"),
        [3802] = L("Héritage Sombrefer", "Dark Iron Legacy"),
        [3906] = L("Discordance des flammes", "Disharmony of Flame"),
        [3907] = L("Discordance des flammes", "Disharmony of Fire"),
        [3981] = L("Le commandant Gor'shak", "Commander Gor'shak"),
        [4001] = L("Que se passe-t-il ?", "What Is Going On?"),
        [4002] = L("Les Royaumes de l'est", "The Eastern Kingdom"),
        [4003] = L("Un sauvetage royal", "The Royal Rescue"),
        [4004] = L("La Princesse sauvée ?", "The Princess Saved?"),
        [4022] = L("Un goût de flammes", "A Taste of Flame"),
        [4023] = L("Un goût de flammes", "A Taste of Flame"),
        [4024] = L("Un goût de flammes", "A Taste of Flame"),
        [4061] = L("La révolte des machines", "The Rise of the Machines"),
        [4062] = L("La révolte des machines", "The Rise of the Machines"),
        [4063] = L("La révolte des machines", "The Rise of the Machines"),
        [4081] = L("TUER A VUE : nains Sombrefer", "KILL ON SIGHT: Dark Iron Dwarves"),
        [4082] = L("TUER A VUE : Officiers de haut rang Sombrefer", "KILL ON SIGHT: High Ranking Dark Iron Officials"),
        [4083] = L("Le Calice spectral", "The Spectral Chalice"),
        [4122] = L("Grark Lorkrub", "Grark Lorkrub"),
        [4121] = L("Situation précaire", "Precarious Predicament"),
        [4123] = L("Le Coeur de la montagne", "The Heart of the Mountain"),
        [4128] = L("Ragnar Thunderbrew", "Ragnar Thunderbrew"),
        [4126] = L("Hurley Blackbreath", "Hurley Blackbreath"),
        [4132] = L("Opération : Mort à Forgehargne", "Operation: Death to Angerforge"),
        [4133] = L("Vivian Lagrave", "Vivian Lagrave"),
        [4134] = L("La recette perdue de Thunderbrew", "Lost Thunderbrew Recipe"),
        [4324] = L("Yuka Screwspigot", "Yuka Screwspigot"),
        [4136] = L("Ribbly Screwspigot", "Ribbly Screwspigot"),
        [4182] = L("La menace des draconiens", "Dragonkin Menace"),
        [4183] = L("Les véritables maîtres", "The True Masters"),
        [4184] = L("Les véritables maîtres", "The True Masters"),
        [4185] = L("Les véritables maîtres", "The True Masters"),
        [4186] = L("Les véritables maîtres", "The True Masters"),
        [4201] = L("Le philtre d'amour", "The Love Potion"),
        [4223] = L("Les véritables maîtres", "The True Masters"),
        [4224] = L("Les véritables maîtres", "The True Masters"),
        [4241] = L("Maréchal Windsor", "Marshal Windsor"),
        [4242] = L("Espoir abandonné", "Abandoned Hope"),
        [4262] = L("Grand seigneur Pyron", "Overmaster Pyron"),
        [4263] = L("Incendius !", "Incendius!"),
        [4264] = L("Une Note chiffonnée", "A Crumpled Up Note"),
        [4282] = L("Un espoir en lambeaux", "A Shred of Hope"),
        [4286] = L("Du beau matériel", "The Good Stuff"),
        [4322] = L("Evasion !", "Jail Break!"),
        [4341] = L("Kharan Mighthammer", "Kharan Mighthammer"),
        [4342] = L("Légende de Kharan", "Kharan's Tale"),
        [4361] = L("Le porteur des mauvaises nouvelles", "The Bearer of Bad News"),
        [4362] = L("Le destin du Royaume", "The Fate of the Kingdom"),
        [4363] = L("La surprise de la Princesse", "The Princess's Surprise"),
        [7201] = L("Le dernier élément", "The Last Element"),
        [8929] = L("À la recherche d'Anthion", "In Search of Anthion"),
        [8930] = L("À la recherche d'Anthion", "In Search of Anthion"),
        [8945] = L("La supplique du mort", "Dead Man's Plea"),
        [8946] = L("Une preuve de vie", "Proof of Life"),
        [8947] = L("L'étonnante requête d'Anthion", "Anthion's Strange Request"),
        [8948] = L("Le vieil ami d'Anthion", "Anthion's Old Friend"),
        [8949] = L("La vendetta de Falrin", "Falrin's Vendetta"),
        [8950] = L("L'enchantement du provocateur", "The Instigator's Enchantment"),
        [9015] = L("Le défi", "The Challenge"),
    },
    steps = {
        -- Pre-quests
        A(3441, "n8479"),
        T(3441, "n8479"),
        A(3442, "n8479"),
        D(3442, L("Réunir 4 Cœurs des flammes et 4 globes d'Huile de golem puis rapporter ces objets à Kalaran Windblade.", "Collect 4 Hearts of Flame and 4 globes of Golem Oil and return the items to Kalaran Windblade."), { targets = { "n5850", "n5852", "n5855", "n5853", "n5854" } }),
        T(3442, "n8479"),
        A(3443, "n8479"),
        D(3443, L("Apporter 8 Dagues plaquées en thorium à Kalaran Windblade.", "Bring 8 Thorium Plated Daggers to Kalaran Windblade."), { targets = { "n5839", "n5840", "n5843", "n5844" } }),
        T(3443, "n8479"),
        A(3452, "n8479"),
        D(3452, L("Trouver et apporter un Symbole de Ragnaros à Kalaran Windblade.", "Find and return a Symbol of Ragnaros to Kalaran Windblade."), { targets = { "n5860", "n5861", "n5862", "n8419" } }),
        T(3452, "n8479"),
        A(3453, "n8479"),
        T(3453, "n8479"),
        A(3454, "n8479"),
        T(3454, nil, { text = L("Objet : Torche de vindicte", "Object: Torch of Retribution") }),
        A(3462, "n8479"),
        T(3462, "n8509"),
        A(3463, "n8509"),
        D(3463, L("Mettre le feu aux Tours de garde nord, sud, est, et ouest en utilisant la Torche de vindicte à l'intérieur ...", "Set the North, South, East, and West Sentry Towers on fire by using the Torch of Retribution inside each of...")),
        T(3463, "n8509"),
        A(3481, nil, { text = L("Objet : Trésor du Vol noir", "Object: Hoard of the Black Dragonflight") }),
        T(3481, nil, { text = L("Objet : Trésor du Vol noir", "Object: Hoard of the Black Dragonflight") }),
        A(3702, "n8879", { faction = "Alliance" }),
        T(3702, "n8879", { faction = "Alliance" }),
        A(3701, "n8879", { faction = "Alliance" }),
        D(3701, L("Aller dans les ruines de Thaurissan, dans les Steppes ardentes. Récupérer des informations sur les Reliques...", "Venture to the Ruins of Thaurissan in the Burning Steppes and recover information from the Thaurissan Relic..."), { faction = "Alliance" }),
        T(3701, "n8879", { faction = "Alliance" }),
        A(3906, "n9084", { faction = "Horde" }),
        D(3906, L("Partir pour la carrière dans le mont Blackrock et tuer le Grand maître Pyron. Retourner voir Thunderheart u...", "Travel to the quarry in Blackrock Mountain and slay Overmaster Pyron. Return to Thunderheart when you have ..."), { faction = "Horde", targets = { "n9026" } }),
        T(3906, "n9084", { faction = "Horde" }),
        A(4022, "n9459"),
        D(4022, L("Montrer à Cyrus Therepentous l'Ecaille des dragons noirs que vous avez reçue de Kalaran Windblade.", "Show Cyrus Therepentous the Black Dragonflight Molt you received from Kalaran Windblade."), { targets = { "n5846", "n5854", "n9461" } }),
        T(4022, "n9459"),
        A(4023, "n9459"),
        D(4023, L("Montrer à Cyrus Therepentous une preuve de votre valeur.", "Show Cyrus Therepentous proof of your worth."), { targets = { "n5846", "n5854", "n9461" } }),
        T(4023, "n9459"),
        A(4061, "n9079", { faction = "Horde" }),
        D(4061, L("S'aventurer dans les Steppes ardentes et récupérer 10 Fragments d'élémentaires cassés pour la Hiérophante T...", "Venture to the Burning Steppes and recover 10 Fractured Elemental Shards for Hierophant Theodora Mulvadania."), { faction = "Horde", targets = { "n7032", "n7039", "n8981" } }),
        T(4061, "n9079", { faction = "Horde" }),
        A(4062, "n9079", { faction = "Horde" }),
        T(4062, "n2921", { faction = "Horde" }),
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
        A(4262, "n9561", { faction = "Alliance" }),
        D(4262, L("Tuer le Grand seigneur Pyron et retourner voir Jalinda Sprig.", "Slay Overmaster Pyron and return to Jalinda Sprig."), { faction = "Alliance", targets = { "n9026" } }),
        T(4262, "n9561", { faction = "Alliance" }),
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
        A(8948, "n16016"),
        T(8948, "n16032"),
        A(8949, "n16032"),
        D(8949, L("Collecter 25 Perles de guerre ogres à l’intérieur de Hache-Tripes ou du Pic Rochenoire, puis revenir voir F...", "Collect 25 Ogre Warbeads from Ogres inside Dire Maul or Blackrock Spire and return to Falrin Treeshaper ins..."), { targets = { "n9196", "n9197", "n9198", "n9199" } }),
        T(8949, "n16032"),
        A(8950, "n16032"),
        D(8950, L("Apportez les choses suivantes à Falrin Sculpteflore dans Hache-Tripes : 1 Essence de spectre railleur, 4 Ru...", "Bring the following to Falrin Treeshaper inside Dire Maul: 1 Jeering Spectre's Essence, 4 Dark Runes and 8 ..."), { targets = { "n11470", "n11471", "n11472", "n11473", "n10477", "n10502" } }),
        T(8950, "n16032"),
        -- Accept the dungeon quests
        A(3801, "n8888"),
        A(3907, "n9084", { faction = "Horde" }),
        A(3981, "n9081", { faction = "Horde" }),
        A(4024, "n9459"),
        A(4063, "n2921", { faction = "Horde" }),
        A(4081, nil, { text = L("Objet : RECHERCHE", "Object: WANTED"), faction = "Horde" }),
        A(4083, nil, { text = L("Objet : Calice spectral", "Object: Spectral Chalice") }),
        A(4122, "n9080", { faction = "Horde" }),
        A(4123, "n9536"),
        A(4128, "n9540", { faction = "Alliance" }),
        A(4133, "n5204", { faction = "Horde" }),
        A(4324, "n9706"),
        A(4201, "n9500"),
        A(4241, "n9560", { faction = "Alliance" }),
        A(4263, "n9561", { faction = "Alliance" }),
        A(4286, "n9177", { faction = "Alliance" }),
        A(4341, "n2784", { faction = "Alliance" }),
        A(4342, "n9021", { faction = "Alliance" }),
        A(7201, "n9078", { faction = "Horde" }),
        A(9015, "n16032"),
        -- Inside the dungeon
        D(3907, L("Pénétrer dans les Profondeurs de Blackrock et traquer le Seigneur Incendius. Le tuer puis donner tous les r...", "Enter Blackrock Depths and track down Lord Incendius. Slay him and return any source of information you may..."), { faction = "Horde", targets = { "n9017" } }),
        D(4024, L("Partir pour les Profondeurs de Blackrock et tuer Bael'Gar.", "Travel to Blackrock Depths and slay Bael'Gar.")),
        D(4063, L("Trouver et tuer le seigneur des golems Argelmach. Rapporter sa tête à Lotwil. Collecter également 10 Noyaux...", "Find and slay Golem Lord Argelmach. Return his head to Lotwil. You will also need to collect 10 Intact Elem..."), { faction = "Horde", targets = { "n8983", "n8905", "n8906", "n8907", "n8908" } }),
        D(4081, L("Pénétrer dans les Profondeurs de Blackrock et tuer les vils agresseurs !", "Venture to Blackrock Depths and destroy the vile aggressors!"), { faction = "Horde", targets = { "n8891", "n8890", "n8892" } }),
        D(4083, L("Le Calice spectral", "The Spectral Chalice"), { targets = { "n92", "n193", "n595", "n669" } }),
        D(4123, L("Apporter le Cœur de la montagne à Maxwort Uberglint dans les Steppes ardentes.", "Bring the Heart of the Mountain to Maxwort Uberglint in the Burning Steppes.")),
        D(4201, L("Apporter 4 Gromsang, 10 Veines d'argent de géant et la Fiole de Nagmara remplie à la gouvernante Nagmara da...", "Bring 4 Gromsblood, 10 Giant Silver Veins and Nagmara's Filled Vial to Mistress Nagmara in Blackrock Depths."), { targets = { "n659", "n741", "n1012", "n1211", "n6146", "n6147" } }),
        D(4263, L("Trouver le Seigneur Incendius dans les Profondeurs de Blackrock et le détruire !", "Find Lord Incendius in Blackrock Depths and destroy him!"), { faction = "Alliance", targets = { "n9017" } }),
        D(4286, L("Se rendre dans les Profondeurs de Blackrock et trouver 20 Sacoches Sombrefer. Retourner voir Oralius lorsqu...", "Travel to Blackrock Depths and recover 20 Dark Iron Fanny Packs. Return to Oralius when you have completed ..."), { faction = "Alliance", targets = { "n8889", "n8890", "n8891", "n8892" } }),
        D(7201, L("Partir pour les Profondeurs de Blackrock et trouver 10 Essences des éléments. Commencer vos recherches par ...", "Travel to Blackrock Depths and recover 10 Essence of the Elements. Your first inclination is to search the ..."), { faction = "Horde", targets = { "n8281", "n8905", "n8906", "n8908" } }),
        D(9015, L("Rendez-vous dans le Cercle de la loi, dans les profondeurs de Rochenoire, et placez la Bannière de provocat...", "Travel to the Ring of the Law in Blackrock Depths and place the Banner of Provocation in its center as you ..."), { targets = { "n16059" } }),
        -- Turn-ins
        T(3801, "n8888"),
        T(3907, "n9084", { faction = "Horde" }),
        T(3981, "n9020", { faction = "Horde" }),
        T(4024, "n9459"),
        T(4063, "n2921", { faction = "Horde" }),
        T(4081, "n9077", { faction = "Horde" }),
        T(4083, nil, { text = L("Objet : Calice spectral", "Object: Spectral Chalice") }),
        T(4122, "n9520", { faction = "Horde" }),
        T(4123, "n9536"),
        T(4128, "n1267", { faction = "Alliance" }),
        T(4133, "n9078", { faction = "Horde" }),
        T(4324, "n9544"),
        T(4201, "n9500"),
        T(4241, "n9023", { faction = "Alliance" }),
        T(4263, "n9561", { faction = "Alliance" }),
        T(4286, "n9177", { faction = "Alliance" }),
        T(4341, "n9021", { faction = "Alliance" }),
        T(4342, "n9021", { faction = "Alliance" }),
        T(7201, "n9078", { faction = "Horde" }),
        T(9015, "n16016"),
        -- Follow-ups started in the dungeon
        A(3802, "n8888"),
        D(3802, L("Tuer Fineous Darkvire et récupérer le grand marteau, Souillefer. Apporter Souillefer au sanctuaire de Thaur...", "Slay Fineous Darkvire and recover the great hammer, Ironfel. Take Ironfel to the Shrine of Thaurissan and p..."), { targets = { "n9056" } }),
        T(3802, nil, { text = L("Objet : Monument de Franclorn Forgewright", "Object: Monument of Franclorn Forgewright") }),
        A(4001, "n9020", { faction = "Horde" }),
        T(4001, "n4949", { faction = "Horde" }),
        A(4002, "n4949", { faction = "Horde" }),
        T(4002, "n4949", { faction = "Horde" }),
        A(4003, "n4949", { faction = "Horde" }),
        D(4003, L("Tuer l'Empereur Thaurissan et libérer la princesse Moira Bronzebeard de son sort maléfique.", "Slay Emperor Dagran Thaurissan and free Princess Moira Bronzebeard from his evil spell."), { faction = "Horde", targets = { "n9019" } }),
        T(4003, "n8929", { faction = "Horde" }),
        A(4004, "n8929", { faction = "Horde" }),
        T(4004, "n4949", { faction = "Horde" }),
        A(4082, nil, { text = L("Objet : TUER A VUE", "Object: KILL ON SIGHT"), faction = "Horde" }),
        D(4082, L("Pénétrer dans les Profondeurs de Blackrock et tuer les vils agresseurs !", "Venture to Blackrock Depths and destroy the vile aggressors!"), { faction = "Horde", targets = { "n8894", "n8893", "n8895" } }),
        T(4082, "n9077", { faction = "Horde" }),
        A(4121, "n9520", { faction = "Horde" }),
        D(4121, L("Escortez votre prisonnier, Grark Lorkrub, au-delà des Steppes ardentes et du mont Blackrock, jusqu'à la gor...", "Escort your prisoner, Grark Lorkrub, through Burning Steppes and through Blackrock Mountain to the Searing ..."), { faction = "Horde" }),
        T(4121, "n9080", { faction = "Horde" }),
        A(4126, "n1267", { faction = "Alliance" }),
        D(4126, L("Apporter la Recette perdue de la Thunderbrew à Ragnar Thunderbrew à Kharanos.", "Bring the Lost Thunderbrew Recipe to Ragnar Thunderbrew in Kharanos."), { faction = "Alliance", targets = { "n9537", "n9541" } }),
        T(4126, "n1267", { faction = "Alliance" }),
        A(4132, "n9077", { faction = "Horde" }),
        D(4132, L("Voyagez jusqu'aux Profondeurs de Blackrock et tuez le général Forgehargne ! Une fois votre mission accompli...", "Travel to Blackrock Depths and slay General Angerforge! Return to Warlord Goretooth when the task is complete."), { faction = "Horde", targets = { "n9033" } }),
        T(4132, "n9077", { faction = "Horde" }),
        A(4134, "n9078", { faction = "Horde" }),
        D(4134, L("Apporter la Recette perdue de la Thunderbrew à Vivian Lagrave à Kargath.", "Bring the Lost Thunderbrew Recipe to Vivian Lagrave in Kargath."), { faction = "Horde", targets = { "n9537", "n9541" } }),
        T(4134, "n9078", { faction = "Horde" }),
        A(4136, "n9544"),
        D(4136, L("Apporter la Tête de Ribbly à Yuka Screwspigot dans les Steppes ardentes.", "Bring Ribbly's Head to Yuka Screwspigot in the Burning Steppes."), { targets = { "n9543" } }),
        T(4136, "n9544"),
        A(4242, "n9023", { faction = "Alliance" }),
        T(4242, "n9560", { faction = "Alliance" }),
        A(4264, nil, { text = L("Objet de quête : Une note chiffonnée", "Quest item: A Crumpled Up Note"), targets = { "n8889", "n8890", "n8891" }, faction = "Alliance" }),
        T(4264, "n9023", { faction = "Alliance" }),
        A(4282, "n9023", { faction = "Alliance" }),
        D(4282, L("Rapporter les Renseignements perdus du maréchal Windsor.", "Return Marshal Windsor's Lost Information."), { faction = "Alliance", targets = { "n9033", "n8983" } }),
        T(4282, "n9023", { faction = "Alliance" }),
        A(4322, "n9023", { faction = "Alliance" }),
        T(4322, "n9560", { faction = "Alliance" }),
        A(4361, "n9021", { faction = "Alliance" }),
        T(4361, "n2784", { faction = "Alliance" }),
        A(4362, "n2784", { faction = "Alliance" }),
        D(4362, L("Retourner dans les Profondeurs de Blackrock et secourir la Princesse Moira Bronzebeard, prisonnière de l'Em...", "Return to Blackrock Depths and rescue Princess Moira Bronzebeard from the evil clutches of Emperor Dagran T..."), { faction = "Alliance", targets = { "n9019" } }),
        T(4362, "n8929", { faction = "Alliance" }),
        A(4363, "n8929", { faction = "Alliance" }),
        T(4363, "n2784", { faction = "Alliance" }),
    },
} end)
