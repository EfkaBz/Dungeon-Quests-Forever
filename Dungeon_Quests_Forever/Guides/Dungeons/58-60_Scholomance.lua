local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Scholomance (58-60) - AUTO-GENERATED from the Questie classic DB
-- Classic version: every quest of the dungeon + all its pre-quests.
-- Class, profession and repeatable quests are not listed.
-- Forever changes will be added as they are known. Verify in game.
-- ===================================================================

N.n10267 = { id = 10267, name = "Tinkee Steamboil", map = 1428, x = 65.2, y = 24.0 }
N.n10468 = { id = 10468, name = "Felnok Steelspring", map = 1452, x = 61.6, y = 38.6 }
N.n7447 = { id = 7447, name = "Fledgling Chillwind", map = 1452, x = 29.6, y = 48.5 }
N.n7448 = { id = 7448, name = "Chillwind Chimaera", map = 1452, x = 68.5, y = 52.8 }
N.n7449 = { id = 7449, name = "Chillwind Ravager", map = 1452, x = 60.4, y = 21.8 }
N.n11036 = { id = 11036, name = "Leonid Barthalomew the Revered", map = 1423, x = 81.7, y = 57.8 }
N.n11286 = { id = 11286, name = "Magistrate Marduke", map = 1422, x = 70.6, y = 74.1 }
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
N.n16080 = { id = 16080, name = "Mor Grayhoof" }
N.n16097 = { id = 16097, name = "Isalien" }
N.n16101 = { id = 16101, name = "Jarien" }
N.n16102 = { id = 16102, name = "Sothos" }
N.n4364 = { id = 4364, name = "Strashaz Warrior", map = 1445, x = 74.8, y = 15.1 }
N.n4366 = { id = 4366, name = "Strashaz Serpent Guard", map = 1445, x = 75.6, y = 22.0 }
N.n4370 = { id = 4370, name = "Strashaz Sorceress", map = 1445, x = 76.5, y = 22.2 }
N.n4371 = { id = 4371, name = "Strashaz Siren", map = 1445, x = 74.3, y = 18.4 }
N.n11022 = { id = 11022, name = "Alexi Barov", map = 1420, x = 83.1, y = 71.6 }
N.n11023 = { id = 11023, name = "Weldon Barov", map = 1422, x = 43.5, y = 83.7 }
N.n11216 = { id = 11216, name = "Eva Sarkhoff", map = 1422, x = 70.2, y = 73.7 }
N.n11035 = { id = 11035, name = "Betina Bigglezink", map = 1423, x = 81.5, y = 59.7 }
N.n11261 = { id = 11261, name = "Doctor Theolen Krastinov" }
N.n10508 = { id = 10508, name = "Ras Frostwhisper" }
N.n10678 = { id = 10678, name = "Plagued Hatchling" }
N.n16118 = { id = 16118, name = "Kormok" }
N.n10432 = { id = 10432, name = "Vectus" }
N.n10503 = { id = 10503, name = "Jandice Barov" }
N.n10506 = { id = 10506, name = "Kirtonos the Herald" }

ns:RegisterDungeon("SCHOLO", function() return {
    name = L("Scholomance", "Scholomance"),
    levels = "58-60",
    icon = "Interface\\Icons\\INV_Misc_Bone_HumanSkull_01",
    entrance = { map = 1422, x = 69.7, y = 73.2 },
    titles = {
        [4726] = L("L'essence de rejeton", "Broodling Essence"),
        [4808] = L("Felnok Steelspring", "Felnok Steelspring"),
        [4809] = L("Cornes de Noroît", "Chillwind Horns"),
        [4810] = L("Retourner voir Tinkee", "Return to Tinkee"),
        [4734] = L("Un oeuf congelé", "Egg Freezing"),
        [4735] = L("La collecte d'oeufs", "Egg Collection"),
        [5522] = L("Leonid Barthalomew", "Leonid Barthalomew"),
        [5531] = L("Betina Bigglezink", "Betina Bigglezink"),
        [4771] = L("Le gambit de l'aube", "Dawn's Gambit"),
        [5341] = L("Fortune de la famille Barov", "Barov Family Fortune"),
        [5343] = L("Fortune de la famille Barov", "Barov Family Fortune"),
        [5382] = L("Docteur Theolen Krastinov, le boucher", "Doctor Theolen Krastinov, the Butcher"),
        [5515] = L("Sac des horreurs de Krastinov", "Krastinov's Bag of Horrors"),
        [5384] = L("Kirtonos le héraut", "Kirtonos the Herald"),
        [5461] = L("L'humain, Ras Murmegivre", "The Human, Ras Frostwhisper"),
        [5462] = L("Le moribond, Ras Murmegivre", "The Dying, Ras Frostwhisper"),
        [5463] = L("Le cadeau de Menethil", "Menethil's Gift"),
        [5464] = L("Le cadeau de Menethil", "Menethil's Gift"),
        [5465] = L("Souvenir lié", "Soulbound Keepsake"),
        [5466] = L("La Liche, Ras Murmegivre", "The Lich, Ras Frostwhisper"),
        [5529] = L("Portée contaminée", "Plagued Hatchlings"),
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
        [8988] = L("D'autres composants importants", "More Components of Importance"),
        [8992] = L("Le morceau droit de l'amulette du seigneur Valthalak", "The Right Piece of Lord Valthalak's Amulet"),
    },
    steps = {
        -- Pre-quests
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
        A(4734, "n10267"),
        T(4734, "n10267"),
        A(4735, "n10267"),
        D(4735, L("Apporter 8 Oeufs de dragon collectés et le Module collectronique à Tinkee Steamboil à la Corniche des flamm...", "Bring 8 Collected Dragon Eggs and the Collectronic Module to Tinkee Steamboil at Flame Crest in the Burning...")),
        T(4735, "n10267"),
        A(5522, "n10267"),
        T(5522, "n11036"),
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
        A(8968, "n16033"),
        D(8968, L("Utilisez le Brasero de signal pour invoquer Jarien et Sothos et les tuer. Retournez voir Bodley, à l'intéri...", "Use the Brazier of Beckoning to summon forth Jarien and Sothos and slay them. Return to Bodley inside Black..."), { targets = { "n16101", "n16102", "n16080", "n16097" } }),
        T(8968, "n16033"),
        -- Accept the dungeon quests
        A(5531, "n11036"),
        A(5341, "n11022", { faction = "Horde" }),
        A(5343, "n11023", { faction = "Alliance" }),
        A(5382, "n11216"),
        A(5529, "n11035"),
        A(8969, "n16033"),
        -- Inside the dungeon
        D(5341, L("S’aventurer jusqu’à Scholomance et récupérer la fortune de la famille Barov. Cette fortune se compose de qu...", "Venture to the Scholomance and recover the Barov family fortune. Four deeds make up this fortune: The Deed ..."), { faction = "Horde" }),
        D(5343, L("S’aventurer jusqu’à la Scholomance et récupérer la fortune de la famille Barov. Cette fortune se compose de...", "Venture to the Scholomance and recover the Barov family fortune. Four deeds make up this fortune: The Deed ..."), { faction = "Alliance" }),
        D(5382, L("Trouver le docteur Theolen Krastinov à l’intérieur de la Scholomance. Le tuer, puis brûler le Cadavre d’Eva...", "Find Doctor Theolen Krastinov inside the Scholomance. Destroy him, then burn the Remains of Eva Sarkhoff an..."), { targets = { "n11261" } }),
        D(5529, L("Tuer 20 Jeunes pestiférés, puis retourner auprès de Betina Bigglezink à la Chapelle de l’Espoir de Lumière.", "Kill 20 Plagued Hatchlings, then return to Betina Bigglezink at the Light's Hope Chapel."), { targets = { "n10678" } }),
        D(8969, L("Utilisez le Brasero de signal pour invoquer l’esprit de Kormok, puis tuez-le. Retournez voir Bodley, à l'in...", "Use the Brazier of Beckoning to summon forth the spirit of Kormok and slay him. Return to Bodley inside Bla..."), { targets = { "n16118", "n16080", "n16097", "n16101", "n16102" } }),
        -- Turn-ins
        T(5531, "n11035"),
        T(5341, "n11022", { faction = "Horde" }),
        T(5343, "n11023", { faction = "Alliance" }),
        T(5382, "n11216"),
        T(5529, "n11035"),
        T(8969, "n16033"),
        A(8970, "n16033"),
        D(8970, L("Récupérez 20 Varechs de sang sur les nagas Strashaz, puis retournez voir Bodley au mont Rochenoire.", "Gather 20 Bloodkelp from the Strashaz naga and then return to Bodley inside Blackrock Mountain."), { targets = { "n4364", "n4366", "n4370", "n4371" } }),
        T(8970, "n16033"),
        A(8988, "n16033"),
        D(8988, L("Prélevez des Cendres d’âme de banni, puis retournez voir Bodley à l’intérieur du mont Rochenoire.", "Obtain Soul Ashes of the Banished and return them to Bodley inside Blackrock Mountain."), { targets = { "n7071", "n7072", "n7075" } }),
        T(8988, "n16033"),
        A(8992, "n16033"),
        D(8992, L("Utilisez le Brasero de signal pour invoquer l’esprit de Kormok, puis tuez-le. Retournez voir Bodley, à l'in...", "Use the Brazier of Beckoning to summon forth the spirit of Kormok and slay him. Return to Bodley inside Bla..."), { targets = { "n16118" } }),
        T(8992, "n16033"),
        -- Follow-ups started in the dungeon
        A(4771, "n11035"),
        D(4771, L("Placer le Gambit de l'aube dans la Chambre des visions de Scholomance. Vaincre Vectus, puis retourner auprè...", "Place Dawn's Gambit in the Viewing Room of the Scholomance. Defeat Vectus, then return to Betina Bigglezink."), { targets = { "n10432" } }),
        T(4771, "n11035"),
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
        A(5463, "n11036"),
        T(5463, nil, { text = L("Objet : Don de Menethil", "Object: Menethil's Gift") }),
        A(5464, nil, { text = L("Objet : Don de Menethil", "Object: Menethil's Gift") }),
        T(5464, "n11036"),
        A(5465, "n11036"),
        T(5465, "n11286"),
        A(5466, "n11286"),
        D(5466, L("Trouver Ras Murmegivre dans Scholomance. Après l’avoir trouvé, utiliser le Souvenir lié sur son visage mort...", "Find Ras Frostwhisper in the Scholomance. When you have found him, use the Soulbound Keepsake on his undead..."), { targets = { "n10508" } }),
        T(5466, "n11286"),
    },
} end)
