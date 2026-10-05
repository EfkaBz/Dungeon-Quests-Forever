local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Lower Blackrock Spire (55-60) - AUTO-GENERATED from the Questie classic DB
-- Classic version: every quest of the dungeon + all its pre-quests.
-- Class, profession and repeatable quests are not listed.
-- Forever changes will be added as they are known. Verify in game.
-- Wing assignment: Omokk, Voone, Smolderweb, Urok, Halycon, Wyrmthalak, Bijou.
-- ===================================================================

N.n8579 = { id = 8579, name = "Yeh'kinya", map = 1446, x = 67.0, y = 22.4 }
N.n8612 = { id = 8612, name = "Screecher Spirit" }
N.n7272 = { id = 7272, name = "Theka the Martyr" }
N.n7791 = { id = 7791, name = "Theka the Martyr Shapeshift" }
N.n7795 = { id = 7795, name = "Hydromancer Velratha" }
N.n10460 = { id = 10460, name = "Prospector Ironboot", map = 1446, x = 66.9, y = 24.0 }
N.n9562 = { id = 9562, name = "Helendis Riverhorn", map = 1428, x = 85.8, y = 69.0 }
N.n9081 = { id = 9081, name = "Galamav the Marksman", map = 1418, x = 6.0, y = 47.7 }
N.n10260 = { id = 10260, name = "Kibler", map = 1428, x = 65.9, y = 21.9 }
N.n10296 = { id = 10296, name = "Vaelan" }
N.n2285 = { id = 2285, name = "Count Remington Ridgewell", map = 1453, x = 74.0, y = 30.2 }
N.n5204 = { id = 5204, name = "Apothecary Zinge", map = 1458, x = 50.1, y = 68.0 }
N.n9563 = { id = 9563, name = "Ragged John", map = 1428, x = 65.0, y = 23.8 }
N.n10799 = { id = 10799, name = "Warosh" }
N.n9077 = { id = 9077, name = "Warlord Goretooth", map = 1418, x = 5.8, y = 47.5 }
N.n9080 = { id = 9080, name = "Lexlort", map = 1418, x = 5.9, y = 47.6 }
N.n10257 = { id = 10257, name = "Bijou" }
N.n9568 = { id = 9568, name = "Overlord Wyrmthalak" }
N.n9046 = { id = 9046, name = "Scarshield Quartermaster" }
N.n10220 = { id = 10220, name = "Halycon" }
N.n9196 = { id = 9196, name = "Highlord Omokk" }
N.n9237 = { id = 9237, name = "War Master Voone" }
N.n9043 = { id = 9043, name = "Scarshield Grunt" }
N.n9044 = { id = 9044, name = "Scarshield Sentry" }
N.n9045 = { id = 9045, name = "Scarshield Acolyte" }
N.n10584 = { id = 10584, name = "Urok Doomhowl" }
N.n335 = { id = 335, name = "Singe", map = 1433, x = 69.8, y = 56.1 }
N.n9197 = { id = 9197, name = "Spirestone Battle Mage" }
N.n9198 = { id = 9198, name = "Spirestone Mystic" }
N.n9565 = { id = 9565, name = "Mayara Brightwing", map = 1428, x = 84.8, y = 69.1 }
N.n9078 = { id = 9078, name = "Shadowmage Vivian Lagrave", map = 1418, x = 2.9, y = 47.8 }
N.n9560 = { id = 9560, name = "Marshal Maxwell", map = 1428, x = 84.7, y = 69.0 }

ns:RegisterDungeon("LBRS", function() return {
    name = L("Bas du pic Rochenoire", "Lower Blackrock Spire"),
    levels = "55-60",
    icon = "Interface\\Icons\\INV_Misc_Head_Dragon_Black",
    entrance = { map = 1427, x = 34.8, y = 85.3 },
    titles = {
        [3520] = L("Esprits de Hurleurs", "Screecher Spirits"),
        [3527] = L("La prophétie de Mosh'aru", "The Prophecy of Mosh'aru"),
        [4787] = L("L'oeuf antique", "The Ancient Egg"),
        [3528] = L("Le dieu Hakkar", "The God Hakkar"),
        [4701] = L("Abattez-la", "Put Her Down"),
        [4724] = L("La maîtresse de meute", "The Pack Mistress"),
        [4729] = L("Les animaux exotiques de Kibler", "Kibler's Exotic Pets"),
        [4742] = L("Le sceau de l'ascension", "Seal of Ascension"),
        [4743] = L("Le sceau de l'ascension", "Seal of Ascension"),
        [4766] = L("Mayara Brightwing", "Mayara Brightwing"),
        [4764] = L("Le fermoir de Doomrigger", "Doomrigger's Clasp"),
        [4765] = L("La livraison à Ridgewell", "Delivery to Ridgewell"),
        [4769] = L("Vivian Lagrave et la tablette de Darkstone", "Vivian Lagrave and the Darkstone Tablet"),
        [4768] = L("La tablette de Darkstone", "The Darkstone Tablet"),
        [5065] = L("Les tablettes perdues de Mosh'aru", "The Lost Tablets of Mosh'aru"),
        [4788] = L("Les dernières tablettes", "The Final Tablets"),
        [4862] = L("Mauvais", "En-Ay-Es-Tee-Why"),
        [4866] = L("Le lait matriarcal", "Mother's Milk"),
        [4867] = L("Urok Hurleruine", "Urok Doomhowl"),
        [4903] = L("Ordre du chef de guerre", "Warlord's Command"),
        [4981] = L("Agent Bijou", "Operative Bijou"),
        [4982] = L("Les effets de Bijou", "Bijou's Belongings"),
        [4983] = L("Rapport de reconnaissance de Bijou", "Bijou's Reconnaissance Report"),
        [5001] = L("Les effets de Bijou", "Bijou's Belongings"),
        [5002] = L("Message à Maxwell", "Message to Maxwell"),
        [5081] = L("Mission de Maxwell", "Maxwell's Mission"),
        [5089] = L("Ordres du général Drakkisath", "General Drakkisath's Command"),
        [7761] = L("Les ordres de Blackhand", "Blackhand's Command"),
    },
    steps = {
        -- Pre-quests
        A(3520, "n8579"),
        D(3520, L("Capturer l’Esprit de 3 Hurleurs en Feralas, puis retourner voir Yeh'kinya à Port Gentepression.", "Capture the spirits of 3 screechers in Feralas, then return to Yeh'kinya in Steamwheedle Port."), { targets = { "n8612" } }),
        T(3520, "n8579"),
        A(3527, "n8579"),
        D(3527, L("Apporter les Première et Deuxième tablettes Mosh'Aru à Yeh'kinya, à Tanaris.", "Bring the First and Second Mosh'aru Tablets to Yeh'kinya in Tanaris."), { targets = { "n7272", "n7791", "n7795" } }),
        T(3527, "n8579"),
        A(4787, "n8579"),
        D(4787, L("Apporter l'Oeuf antique à Yeh'kinya à Tanaris.", "Bring the Ancient Egg to Yeh'kinya in Tanaris.")),
        T(4787, "n8579"),
        A(3528, "n8579"),
        D(3528, L("Apporter l'Oeuf Rempli d'Hakkar à Yeh'kinya dans Tanaris.", "Bring the Filled Egg of Hakkar to Yeh'kinya in Tanaris.")),
        T(3528, "n8579"),
        A(5065, "n10460"),
        D(5065, L("Apporter la troisième et la quatrième tablette Mosh'aru au Prospecteur Ironboot à Tanaris.", "Bring the Third and Fourth Mosh'aru Tablets to Prospector Ironboot in Tanaris.")),
        T(5065, "n10460"),
        -- Accept the dungeon quests
        A(4701, "n9562", { faction = "Alliance" }),
        A(4724, "n9081", { faction = "Horde" }),
        A(4729, "n10260"),
        A(4742, "n10296"),
        A(4766, "n2285", { faction = "Alliance" }),
        A(4769, "n5204", { faction = "Horde" }),
        A(4788, "n10460"),
        A(4862, "n10260"),
        A(4866, "n9563"),
        A(4867, "n10799"),
        A(4903, "n9077", { faction = "Horde" }),
        A(4981, "n9080", { faction = "Horde" }),
        A(5001, "n10257", { faction = "Alliance" }),
        A(5089, nil, { text = L("Objet de quête : Ordres du général Drakkisath", "Quest item: General Drakkisath's Command"), targets = { "n9568" }, faction = "Alliance" }),
        A(7761, nil, { text = L("Objet de quête : Instructions de Blackhand", "Quest item: Blackhand's Command"), targets = { "n9046" } }),
        -- Inside the dungeon
        D(4701, L("Allez au Pic Blackrock et anéantir la menace worg à sa source. Tandis que vous quittiez Helendis, il a crié...", "Travel to Blackrock Spire and destroy the source of the worg menace. As you left Helendis, he shouted a nam..."), { faction = "Alliance", targets = { "n10220" } }),
        D(4724, L("Tuer Halycon, la maîtresse de la meute des worgs Bloodaxe.", "Slay Halycon, pack mistress of the Bloodaxe worg."), { faction = "Horde", targets = { "n10220" } }),
        D(4729, L("Aller au Pic Blackrock et trouver de Jeunes worgs Bloodaxe. Utiliser la cage pour transporter ces petites b...", "Travel to Blackrock Spire and find Bloodaxe Worg Pups. Use the cage to carry the ferocious little beasts. B...")),
        D(4742, L("Trouver les trois gemmes de commandement : la Gemme de Smolderthorn, la Gemme de Pierre-du-pic et la Gemme ...", "Find the three gemstones of command: The Gemstone of Smolderthorn, Gemstone of Spirestone, and Gemstone of ..."), { targets = { "n9196", "n9237", "n9568", "n9043", "n9044", "n9045" } }),
        D(4788, L("Apporter la cinquième et la sixième Tablette Mosh'aru au Prospecteur Ironboot à Tanaris.", "Bring the Fifth and Sixth Mosh'aru Tablets to Prospector Ironboot in Tanaris.")),
        D(4862, L("Aller au Pic Blackrock et ramasser 15 Oeuf d'araignée du pic pour Kibler.", "Travel to Blackrock Spire and collect 15 Spire Spider Eggs for Kibler.")),
        D(4867, L("Lire le Parchemin de Warosh. Apporter le Mojo de Warosh à Warosh.", "Read Warosh's Scroll. Bring Warosh's Mojo to Warosh."), { targets = { "n10584" } }),
        D(4903, L("Tuer le généralissime Omokk, le maître de guerre Voone et le seigneur Wyrmthalak. Récupérer les Importants ...", "Slay Highlord Omokk, War Master Voone, and Overlord Wyrmthalak. Recover Important Blackrock Documents. Retu..."), { faction = "Horde", targets = { "n9568", "n9196", "n9237", "n335", "n9197", "n9198" } }),
        D(5001, L("Retrouver les Affaires de Bijou et les lui rapporter. Bonne chance !", "Find Bijou's Belongings and return them to her. Good luck!"), { faction = "Alliance" }),
        -- Turn-ins
        T(4701, "n9562", { faction = "Alliance" }),
        T(4724, "n9081", { faction = "Horde" }),
        T(4729, "n10260"),
        T(4742, "n10296"),
        T(4766, "n9565", { faction = "Alliance" }),
        T(4769, "n9078", { faction = "Horde" }),
        T(4788, "n10460"),
        T(4862, "n10260"),
        T(4866, "n9563"),
        T(4867, "n10799"),
        T(4903, "n9077", { faction = "Horde" }),
        T(4981, "n10257", { faction = "Horde" }),
        T(5001, "n10257", { faction = "Alliance" }),
        T(5089, "n9560", { faction = "Alliance" }),
        T(7761, nil, { text = L("Objet : Marque de Drakkisath", "Object: Drakkisath's Brand") }),
        -- Follow-ups started in the dungeon
        A(4743, "n10296"),
        D(4743, L("Allez à la tourbière du Ver dans le marécage d'Âprefange. Trouvez l'ancien drake, Brandeguerre, et frappez-...", "Travel to the Wyrmbog in Dustwallow Marsh. Find the ancient drake, Emberstrife and beat him without mercy u...")),
        T(4743, "n10296"),
        A(4764, "n9565", { faction = "Alliance" }),
        D(4764, L("Apporter le Fermoir de Doomrigger à Mayara Brightwing, dans les Steppes ardentes.", "Bring Doomrigger's Clasp to Mayara Brightwing in the Burning Steppes."), { faction = "Alliance" }),
        T(4764, "n9565", { faction = "Alliance" }),
        A(4765, "n9565", { faction = "Alliance" }),
        T(4765, "n2285", { faction = "Alliance" }),
        A(4768, "n9078", { faction = "Horde" }),
        D(4768, L("Apporter la Tablette de Darkstone à l'ombremage Vivian Lagrave à Kargath.", "Bring the Darkstone Tablet to Shadow Mage Vivian Lagrave in Kargath."), { faction = "Horde" }),
        T(4768, "n9078", { faction = "Horde" }),
        A(4982, "n10257", { faction = "Horde" }),
        D(4982, L("Trouver les Affaires de Bijou et les lui rapporter. Elle vous a dit les avoir cachées dans le niveau inféri...", "Find Bijou's Belongings and return them to her. You recall her mentioning that she stashed them on the bott..."), { faction = "Horde" }),
        T(4982, "n10257", { faction = "Horde" }),
        A(4983, "n10257", { faction = "Horde" }),
        T(4983, "n9080", { faction = "Horde" }),
        A(5002, "n10257", { faction = "Alliance" }),
        T(5002, "n9560", { faction = "Alliance" }),
        A(5081, "n9560", { faction = "Alliance" }),
        D(5081, L("Se rendre au Pic Blackrock et tuer le maître de guerre Voone, le généralissime Omokk, et le seigneur Wyrmth...", "Travel to Blackrock Spire and destroy War Master Voone, Highlord Omokk, and Overlord Wyrmthalak. Return to ..."), { faction = "Alliance", targets = { "n9237", "n9196", "n9568" } }),
        T(5081, "n9560", { faction = "Alliance" }),
    },
} end)
