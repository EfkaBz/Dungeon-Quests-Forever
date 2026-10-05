local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Dire Maul - East (54-60) - AUTO-GENERATED from the Questie classic DB
-- Classic version: every quest of the dungeon + all its pre-quests.
-- Class, profession and repeatable quests are not listed.
-- Forever changes will be added as they are known. Verify in game.
-- Wing assignment: Pusillin, Lethtendris, Alzzin, Isalien.
-- ===================================================================

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
N.n16118 = { id = 16118, name = "Kormok" }
N.n4364 = { id = 4364, name = "Strashaz Warrior", map = 1445, x = 74.8, y = 15.1 }
N.n4366 = { id = 4366, name = "Strashaz Serpent Guard", map = 1445, x = 75.6, y = 22.0 }
N.n4370 = { id = 4370, name = "Strashaz Sorceress", map = 1445, x = 76.5, y = 22.2 }
N.n4371 = { id = 4371, name = "Strashaz Siren", map = 1445, x = 74.3, y = 18.4 }
N.n14355 = { id = 14355, name = "Azj'Tordin", map = 1444, x = 76.9, y = 37.4 }
N.n2198 = { id = 2198, name = "Crier Goodman", map = 1453, x = 47.5, y = 64.2 }
N.n10880 = { id = 10880, name = "Warcaller Gorlach", map = 1454, x = 37.6, y = 75.4 }
N.n14354 = { id = 14354, name = "Pusillin" }
N.n7877 = { id = 7877, name = "Latronicus Moonspear", map = 1444, x = 30.4, y = 46.2 }
N.n7776 = { id = 7776, name = "Talo Thornhoof", map = 1444, x = 76.2, y = 43.8 }
N.n14327 = { id = 14327, name = "Lethtendris" }

ns:RegisterDungeon("DME", function() return {
    name = L("Haches-Tripes - Est", "Dire Maul - East"),
    levels = "54-60",
    icon = "Interface\\Icons\\INV_Misc_Book_11",
    entrance = { map = 1444, x = 59.2, y = 45.1 },
    titles = {
        [7441] = L("Pusillin et l'Ancien Azj'Tordin", "Pusillin and the Elder Azj'Tordin"),
        [7494] = L("Le bastion de Feathermoon", "Feathermoon Stronghold"),
        [7488] = L("Le filet de Lethtendris", "Lethtendris's Web"),
        [7492] = L("Camp Mojache", "Camp Mojache"),
        [7489] = L("Le filet de Lethtendris", "Lethtendris's Web"),
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
        [8990] = L("Le morceau droit de l'amulette du seigneur Valthalak", "The Right Piece of Lord Valthalak's Amulet"),
    },
    steps = {
        -- Pre-quests
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
        A(8968, "n16033"),
        D(8968, L("Utilisez le Brasero de signal pour invoquer Jarien et Sothos et les tuer. Retournez voir Bodley, à l'intéri...", "Use the Brazier of Beckoning to summon forth Jarien and Sothos and slay them. Return to Bodley inside Black..."), { targets = { "n16101", "n16102", "n16080", "n16097" } }),
        T(8968, "n16033"),
        A(8969, "n16033"),
        D(8969, L("Utilisez le Brasero de signal pour invoquer l’esprit de Kormok, puis tuez-le. Retournez voir Bodley, à l'in...", "Use the Brazier of Beckoning to summon forth the spirit of Kormok and slay him. Return to Bodley inside Bla..."), { targets = { "n16118", "n16080", "n16097", "n16101", "n16102" } }),
        T(8969, "n16033"),
        A(8970, "n16033"),
        D(8970, L("Récupérez 20 Varechs de sang sur les nagas Strashaz, puis retournez voir Bodley au mont Rochenoire.", "Gather 20 Bloodkelp from the Strashaz naga and then return to Bodley inside Blackrock Mountain."), { targets = { "n4364", "n4366", "n4370", "n4371" } }),
        T(8970, "n16033"),
        A(8985, "n16033"),
        D(8985, L("Procurez-vous une Relique de Brise-Stellaire et rapportez-la à Bodley, à l’intérieur du Mont Rochenoire.", "Acquire a Starbreeze Village Relic and return it to Bodley inside Blackrock Mountain."), { targets = { "n7428", "n7429" } }),
        T(8985, "n16033"),
        -- Accept the dungeon quests
        A(7441, "n14355"),
        A(7494, "n2198", { faction = "Alliance" }),
        A(7492, "n10880", { faction = "Horde" }),
        A(8967, "n16033"),
        A(8990, "n16033"),
        -- Inside the dungeon
        D(7441, L("Rendez-vous à Hache-tripes et trouvez le diablotin Pusillin. Persuadez-le par tous les moyens de vous rendr...", "Travel to Dire Maul and locate the Imp, Pusillin. Convince Pusillin to give you Azj'Tordin's Book of Incant..."), { targets = { "n14354" } }),
        D(8967, L("Utilisez le Brasero de signal pour invoquer l’esprit d’Isalien, puis tuez-le. Retournez voir Bodley, à l'in...", "Use the Brazier of Beckoning to summon forth the spirit of Isalien and slay her. Return to Bodley inside Bl..."), { targets = { "n16097", "n16080", "n16101", "n16102" } }),
        D(8990, L("Utilisez le Brasero de signal pour invoquer l’esprit d’Isalien, puis tuez-le. Retournez voir Bodley, à l'in...", "Use the Brazier of Beckoning to summon forth the spirit of Isalien and slay her. Return to Bodley inside Bl..."), { targets = { "n16097" } }),
        -- Turn-ins
        T(7441, "n14355"),
        T(7494, "n7877", { faction = "Alliance" }),
        T(7492, "n7776", { faction = "Horde" }),
        T(8967, "n16033"),
        T(8990, "n16033"),
        -- Follow-ups started in the dungeon
        A(7488, "n7877", { faction = "Alliance" }),
        D(7488, L("Ramenez le Filet de Lethtendris à Latronicus Moonspear au bastion de Feathermoon en Feralas.", "Bring Lethtendris' Web to Latronicus Moonspear at the Feathermoon Stronghold in Feralas."), { faction = "Alliance", targets = { "n14327" } }),
        T(7488, "n7877", { faction = "Alliance" }),
        A(7489, "n7776", { faction = "Horde" }),
        D(7489, L("Ramenez le Filet de Lethtendris à Talo Thornhoof au Camp Mojache, en Feralas.", "Bring Lethtendris's Web to Talo Thornhoof at Camp Mojache in Feralas."), { faction = "Horde", targets = { "n14327" } }),
        T(7489, "n7776", { faction = "Horde" }),
    },
} end)
