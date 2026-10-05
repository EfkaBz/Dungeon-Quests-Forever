local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Stratholme (58-60) - AUTO-GENERATED from the Questie classic DB
-- Classic version: every quest of the dungeon + all its pre-quests.
-- Class, profession and repeatable quests are not listed.
-- Forever changes will be added as they are known. Verify in game.
-- ===================================================================

N.n11038 = { id = 11038, name = "Caretaker Alen", map = 1423, x = 79.5, y = 63.9 }
N.n11140 = { id = 11140, name = "Egan", map = 1423, x = 14.4, y = 33.7 }
N.n11216 = { id = 11216, name = "Eva Sarkhoff", map = 1422, x = 70.2, y = 73.7 }
N.n11261 = { id = 11261, name = "Doctor Theolen Krastinov" }
N.n10503 = { id = 10503, name = "Jandice Barov" }
N.n10506 = { id = 10506, name = "Kirtonos the Herald" }
N.n11286 = { id = 11286, name = "Magistrate Marduke", map = 1422, x = 70.6, y = 74.1 }
N.n11036 = { id = 11036, name = "Leonid Barthalomew the Revered", map = 1423, x = 81.7, y = 57.8 }
N.n1855 = { id = 1855, name = "Tirion Fordring", map = 1423, x = 7.6, y = 43.7 }
N.n8596 = { id = 8596, name = "Plaguehound Runt", map = 1423, x = 45.1, y = 86.6 }
N.n8597 = { id = 8597, name = "Plaguehound", map = 1423, x = 65.9, y = 58.8 }
N.n8598 = { id = 8598, name = "Frenzied Plaguehound", map = 1423, x = 65.3, y = 33.0 }
N.n8600 = { id = 8600, name = "Plaguebat", map = 1423, x = 15.0, y = 75.5 }
N.n8603 = { id = 8603, name = "Carrion Grub", map = 1423, x = 66.8, y = 61.4 }
N.n8605 = { id = 8605, name = "Carrion Devourer", map = 1423, x = 65.4, y = 27.8 }
N.n11886 = { id = 11886, name = "Mercutio Filthgorger" }
N.n11936 = { id = 11936, name = "Artist Renfray", map = 1422, x = 65.8, y = 75.4 }
N.n11878 = { id = 11878, name = "Nathanos Blightcaller", map = 1423, x = 26.5, y = 74.7 }
N.n8565 = { id = 8565, name = "Pathstrider", map = 1423, x = 53.7, y = 18.8 }
N.n8564 = { id = 8564, name = "Ranger", map = 1423, x = 51.5, y = 18.1 }
N.n8563 = { id = 8563, name = "Woodsman", map = 1423, x = 54.0, y = 18.8 }
N.n11897 = { id = 11897, name = "Duskwing", map = 1423, x = 30.8, y = 69.8 }
N.n16013 = { id = 16013, name = "Deliana", map = 1455, x = 43.5, y = 52.6 }
N.n16016 = { id = 16016, name = "Anthion Harmon", map = 1423, x = 30.9, y = 16.8 }
N.n16012 = { id = 16012, name = "Mokvar", map = 1454, x = 35.0, y = 38.3 }
N.n16033 = { id = 16033, name = "Bodley" }
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
N.n16080 = { id = 16080, name = "Mor Grayhoof" }
N.n16097 = { id = 16097, name = "Isalien" }
N.n16101 = { id = 16101, name = "Jarien" }
N.n16102 = { id = 16102, name = "Sothos" }
N.n16118 = { id = 16118, name = "Kormok" }
N.n4364 = { id = 4364, name = "Strashaz Warrior", map = 1445, x = 74.8, y = 15.1 }
N.n4366 = { id = 4366, name = "Strashaz Serpent Guard", map = 1445, x = 75.6, y = 22.0 }
N.n4370 = { id = 4370, name = "Strashaz Sorceress", map = 1445, x = 76.5, y = 22.2 }
N.n4371 = { id = 4371, name = "Strashaz Siren", map = 1445, x = 74.3, y = 18.4 }
N.n11035 = { id = 11035, name = "Betina Bigglezink", map = 1423, x = 81.5, y = 59.7 }
N.n11033 = { id = 11033, name = "Smokey LaRue", map = 1423, x = 80.6, y = 58.0 }
N.n11039 = { id = 11039, name = "Duke Nicholas Zverenhoff", map = 1423, x = 81.4, y = 59.8 }
N.n10381 = { id = 10381, name = "Ravaged Cadaver" }
N.n10382 = { id = 10382, name = "Mangled Cadaver" }
N.n10405 = { id = 10405, name = "Plague Ghoul" }
N.n10406 = { id = 10406, name = "Ghoul Ravener" }
N.n11058 = { id = 11058, name = "Fras Siabi" }
N.n10811 = { id = 10811, name = "Archivist Galford" }
N.n11122 = { id = 11122, name = "Restless Soul" }
N.n10439 = { id = 10439, name = "Ramstein the Gorger" }
N.n16031 = { id = 16031, name = "Ysida Harmon" }
N.n10917 = { id = 10917, name = "Aurius" }
N.n10813 = { id = 10813, name = "Balnazzar" }
N.n10440 = { id = 10440, name = "Baron Rivendare" }

ns:RegisterDungeon("STRAT", function() return {
    name = L("Stratholme", "Stratholme"),
    levels = "58-60",
    icon = "Interface\\Icons\\Spell_Holy_SenseUndead",
    entrance = { map = 1423, x = 31.3, y = 15.7 },
    titles = {
        [5125] = L("L'estimation d'Aurius", "Aurius' Reckoning"),
        [5212] = L("La chair ne ment pas", "The Flesh Does Not Lie"),
        [5213] = L("L'agent actif", "The Active Agent"),
        [5214] = L("Le grand Ezra Grimm", "The Great Fras Siabi"),
        [5243] = L("Les demeures du Sacré", "Houses of the Holy"),
        [5251] = L("L'archiviste", "The Archivist"),
        [5262] = L("La vérité vient du ciel", "The Truth Comes Crashing Down"),
        [5263] = L("Au-dessus et au-delà", "Above and Beyond"),
        [5281] = L("Âmes tourmentées", "The Restless Souls"),
        [5282] = L("Âmes tourmentées", "The Restless Souls"),
        [5382] = L("Docteur Theolen Krastinov, le boucher", "Doctor Theolen Krastinov, the Butcher"),
        [5515] = L("Sac des horreurs de Krastinov", "Krastinov's Bag of Horrors"),
        [5384] = L("Kirtonos le héraut", "Kirtonos the Herald"),
        [5461] = L("L'humain, Ras Murmegivre", "The Human, Ras Frostwhisper"),
        [5462] = L("Le moribond, Ras Murmegivre", "The Dying, Ras Frostwhisper"),
        [5463] = L("Le cadeau de Menethil", "Menethil's Gift"),
        [5542] = L("Chiens-démons", "Demon Dogs"),
        [5543] = L("Ciel couleur de sang", "Blood Tinged Skies"),
        [5544] = L("Larve putride", "Carrion Grubbage"),
        [5742] = L("Rédemption", "Redemption"),
        [5781] = L("Aux mémoires perdues", "Of Forgotten Memories"),
        [5845] = L("De l'honneur perdu", "Of Lost Honor"),
        [5846] = L("L'amour et la famille", "Of Love and Family"),
        [5848] = L("De l'amour et de la famille", "Of Love and Family"),
        [6133] = L("L'ordre du seigneur forestier", "The Ranger Lord's Behest"),
        [6135] = L("Crépuscaile, oh comme je te hais !", "Duskwing, Oh How I Hate Thee..."),
        [6163] = L("Ramstein", "Ramstein"),
        [8929] = L("À la recherche d'Anthion", "In Search of Anthion"),
        [8930] = L("À la recherche d'Anthion", "In Search of Anthion"),
        [8945] = L("La supplique du mort", "Dead Man's Plea"),
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
        [8987] = L("D'autres composants importants", "More Components of Importance"),
        [8991] = L("Le morceau droit de l'amulette du seigneur Valthalak", "The Right Piece of Lord Valthalak's Amulet"),
    },
    steps = {
        -- Pre-quests
        A(5281, "n11038"),
        T(5281, "n11140"),
        A(5382, "n11216"),
        D(5382, L("Trouver le docteur Theolen Krastinov à l’intérieur de la Scholomance. Le tuer, puis brûler le Cadavre d’Eva...", "Find Doctor Theolen Krastinov inside the Scholomance. Destroy him, then burn the Remains of Eva Sarkhoff an..."), { targets = { "n11261" } }),
        T(5382, "n11216"),
        A(5515, "n11216"),
        D(5515, L("Trouver Jandice Barov dans Scholomance et la tuer. Sur son cadavre, récupérer le Sac des horreurs de Krasti...", "Locate Jandice Barov in the Scholomance and destroy her. From her corpse recover Krastinov's Bag of Horrors..."), { targets = { "n10503" } }),
        T(5515, "n11216"),
        A(5384, "n11216"),
        D(5384, L("Revenir à Scholomance avec le Sang des innocents. Trouver le porche et placer le Sang des innocents dans le...", "Return to the Scholomance with the Blood of Innocents. Find the porch and place the Blood of Innocents in t..."), { targets = { "n10506" } }),
        T(5384, "n11216"),
        A(5461, "n11286"),
        D(5461, L("Voyager jusqu’aux hautes-terres d'Arathi, et aller aux ruines de Stromgarde. Fouiller Stromgarde pour trouv...", "Travel to the Arathi Highlands, to the ruins of Stromgarde. Search Stromgarde for a Keepsake of Remembrance...")),
        T(5461, "n11286"),
        A(5462, "n11286"),
        T(5462, "n11036"),
        A(5542, "n1855"),
        D(5542, L("Tuer 20 Chiens pestiférés chétifs, 5 Chiens pestiférés et 5 Chiens pestiférés frénétiques. Retourner voir T...", "Slay 20 Plaguehound Runts, 5 Plaguehounds and 5 Frenzied Plaguehounds. Return to Tirion Fordring when the t..."), { targets = { "n8596", "n8597", "n8598" } }),
        T(5542, "n1855"),
        A(5543, "n1855"),
        D(5543, L("Tuer 30 Chauves-souris pestiférées, puis retourner voir Tirion Fordring.", "Slay 30 Plaguebats and return to Tirion Fordring."), { targets = { "n8600" } }),
        T(5543, "n1855"),
        A(5544, "n1855"),
        D(5544, L("Chercher les Larves putrides et les Dévoreurs de la région. Les tuer et récupérer leur viande. Retourner vo...", "Seek out the Carrion Grubs and Devourers of the region. Slay them and harvest their meat. Return to Tirion ..."), { targets = { "n8603", "n8605" } }),
        T(5544, "n1855"),
        A(5742, "n1855"),
        T(5742, "n1855"),
        A(5781, "n1855"),
        D(5781, L("Aller au caveau de Zaeldarr - situé dans la section la plus au sud des Maleterres de l’est - et récupérer l...", "Travel to the Undercroft - at the southernmost section of the Eastern Plaguelands - and recover Taelan's Ha..."), { targets = { "n11886" } }),
        T(5781, "n1855"),
        A(5845, "n1855"),
        D(5845, L("Se rendre à Valnord, dans la région nord-est des Maleterres de l’est, et récupérer le Symbole de l’honneur ...", "Travel to Northdale, in the northeastern region of the Eastern Plaguelands, and recover the Symbol of Lost ...")),
        T(5845, "n1855"),
        A(5846, "n1855"),
        T(5846, "n11936"),
        A(6133, "n11878", { faction = "Horde" }),
        D(6133, L("Aller vers la frontière nord des Maleterres de l’est et récupérer le Registre de Quel'Thalas. L’objet se tr...", "Travel to the northern borders of the Eastern Plaguelands and recover the Quel'Thalas Registry. The item is..."), { faction = "Horde", targets = { "n8565", "n8564", "n8563" } }),
        T(6133, "n11878", { faction = "Horde" }),
        A(6135, "n11878", { faction = "Horde" }),
        D(6135, L("Trouver Crépuscaile et la tuer. Récupérer une Touffe de fourrure de Crépuscaile sur son cadavre, puis l’app...", "Find Duskwing and slay him. From the corpse, recover a Patch of Duskwing's Fur and return it to Nathanos Bl..."), { faction = "Horde", targets = { "n11897" } }),
        T(6135, "n11878", { faction = "Horde" }),
        A(8929, "n16013", { faction = "Alliance" }),
        T(8929, "n16016", { faction = "Alliance" }),
        A(8930, "n16012", { faction = "Horde" }),
        T(8930, "n16016", { faction = "Horde" }),
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
        A(8966, "n16033"),
        D(8966, L("Utilisez le Brasero de signal pour invoquer l’esprit de Mor Sabot-gris, puis tuez-le. Ensuite, retournez vo...", "Use the Brazier of Beckoning to summon forth the spirit of Mor Grayhoof and slay him. Return to Bodley insi..."), { targets = { "n16080", "n16097", "n16101", "n16102" } }),
        T(8966, "n16033"),
        A(8967, "n16033"),
        D(8967, L("Utilisez le Brasero de signal pour invoquer l’esprit d’Isalien, puis tuez-le. Retournez voir Bodley, à l'in...", "Use the Brazier of Beckoning to summon forth the spirit of Isalien and slay her. Return to Bodley inside Bl..."), { targets = { "n16097", "n16080", "n16101", "n16102" } }),
        T(8967, "n16033"),
        A(8969, "n16033"),
        D(8969, L("Utilisez le Brasero de signal pour invoquer l’esprit de Kormok, puis tuez-le. Retournez voir Bodley, à l'in...", "Use the Brazier of Beckoning to summon forth the spirit of Kormok and slay him. Return to Bodley inside Bla..."), { targets = { "n16118", "n16080", "n16097", "n16101", "n16102" } }),
        T(8969, "n16033"),
        A(8970, "n16033"),
        D(8970, L("Récupérez 20 Varechs de sang sur les nagas Strashaz, puis retournez voir Bodley au mont Rochenoire.", "Gather 20 Bloodkelp from the Strashaz naga and then return to Bodley inside Blackrock Mountain."), { targets = { "n4364", "n4366", "n4370", "n4371" } }),
        T(8970, "n16033"),
        A(8987, "n16033"),
        D(8987, L("Procurez-vous une Épée brillante de fanatisme, puis rapportez-la à Bodley, à l’intérieur du mont Rochenoire.", "Retrieve a Brilliant Sword of Zealotry and return it to Bodley inside Blackrock Mountain."), { targets = { "n9448" } }),
        T(8987, "n16033"),
        -- Accept the dungeon quests
        A(5212, "n11035"),
        A(5214, "n11033"),
        A(5243, "n11036"),
        A(5251, "n11039"),
        A(5282, "n11140"),
        A(5463, "n11036"),
        A(5848, "n11936"),
        A(6163, "n11878", { faction = "Horde" }),
        A(8945, "n16016"),
        A(8968, "n16033"),
        A(8991, "n16033"),
        -- Inside the dungeon
        D(5212, L("Récupérer 20 Echantillons de chair pestiférée à Stratholme puis les rapporter à Betina Bigglezink. Vous pen...", "Recover 10 Plagued Flesh Samples from Stratholme and return them to Betina Bigglezink. You suspect that any..."), { targets = { "n10381", "n10382", "n10405", "n10406" } }),
        D(5214, L("Trouver le magasin de tabac d’Ezra Grimm à Stratholme et récupérer une boîte de Tabac d’Ezra. Retourner aup...", "Find Fras Siabi's smoke shop in Stratholme and recover a box of Siabi's Premium Tobacco. Return to Smokey L..."), { targets = { "n11058" } }),
        D(5243, L("Se rendre à Stratholme, au nord. Fouiller les caisses de fournitures qui encombrent la cité et récupérer 5 ...", "Travel to Stratholme, in the north. Search the supply crates that litter the city and recover 5 Stratholme ...")),
        D(5251, L("Voyager jusqu’à Stratholme et trouver l’Archiviste Galford de la Croisade écarlate. L’abattre et brûler les...", "Travel to Stratholme and find Archivist Galford of the Scarlet Crusade. Destroy him and burn down the Scarl..."), { targets = { "n10811" } }),
        D(5282, L("Se servir du Libérateur d'Egan sur les citoyens fantomatiques et spectraux de Stratholme. Quand les esprits...", "Use Egan's Blaster on the ghostly and spectral citizens of Stratholme. When the restless souls break free f..."), { targets = { "n11122" } }),
        D(5848, L("Se rendre à Stratholme, dans la partie nord des Maleterres. C’est dans le Bastion écarlate que se trouve le...", "Travel to Stratholme, in the northern part of the Plaguelands. It is in the Scarlet Bastion that you will f...")),
        D(6163, L("Aller à Stratholme et tuer Ramstein Grandgosier. Prendre sa tête, et l’apporter à Nathanos.", "Travel to Stratholme and slay Ramstein the Gorger. Take his head as a souvenir for Nathanos."), { faction = "Horde", targets = { "n10439" } }),
        D(8945, L("Entrez à Stratholme et sauvez Ysida Harmon du baron Vaillefendre.", "Go into Stratholme and rescue Ysida Harmon from Baron Rivendare."), { targets = { "n16031" } }),
        D(8968, L("Utilisez le Brasero de signal pour invoquer Jarien et Sothos et les tuer. Retournez voir Bodley, à l'intéri...", "Use the Brazier of Beckoning to summon forth Jarien and Sothos and slay them. Return to Bodley inside Black..."), { targets = { "n16101", "n16102", "n16080", "n16097" } }),
        D(8991, L("Utilisez le Brasero de signal pour invoquer Jarien et Sothos, puis tuez-les. Retournez voir Bodley, à l'int...", "Use the Brazier of Beckoning to summon forth Jarien and Sothos and slay them. Return to Bodley inside Black..."), { targets = { "n16101", "n16102" } }),
        -- Turn-ins
        T(5212, "n11035"),
        T(5214, "n11033"),
        T(5243, "n11036"),
        T(5251, "n11039"),
        T(5282, "n11140"),
        T(5463, nil, { text = L("Objet : Don de Menethil", "Object: Menethil's Gift") }),
        T(5848, "n1855"),
        T(6163, "n11878", { faction = "Horde" }),
        T(8945, "n16031"),
        T(8968, "n16033"),
        T(8991, "n16033"),
        -- Follow-ups started in the dungeon
        A(5125, "n10917"),
        T(5125, "n10917"),
        A(5213, "n11035"),
        D(5213, L("Se rendre jusqu’à Stratholme et fouiller les ziggourats. Trouver et ramener de nouvelles informations sur l...", "Travel to Stratholme and search the ziggurats. Find and return new Scourge Data to Betina Bigglezink.")),
        T(5213, "n11035"),
        A(5262, nil, { text = L("Objet de quête : Tête de Balnazzar", "Quest item: Head of Balnazzar"), targets = { "n10813" } }),
        T(5262, "n11039"),
        A(5263, "n11039"),
        D(5263, L("S’aventurer dans Stratholme et tuer le baron Rivendare. Prendre sa tête et retourner auprès du duc Nicholas...", "Venture to Stratholme and destroy Baron Rivendare. Take his head and return to Duke Nicholas Zverenhoff."), { targets = { "n10440" } }),
        T(5263, "n11039"),
    },
} end)
