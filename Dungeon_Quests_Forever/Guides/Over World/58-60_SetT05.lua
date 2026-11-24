local _, ns = ...
local L = ns.L
local N = ns.NPCS
local Accept, TurnIn, Do = ns.Accept, ns.TurnIn, ns.Do

-- ===================================================================
-- Dungeon Set 2 (T0.5): the whole quest chain that turns the T0 set into
-- the T0.5 set. Level 58+, the T0 pieces are needed (they are taken).
-- 1 bracers, 2 belt & gloves, 3 legs & shoulders & boots, 4 helm & chest.
-- Quest IDs and coordinates: Classic data (RestedXP T0.5 guide, Questie);
-- Eastern Plaguelands points converted to the Forever map. To verify in game.
-- ===================================================================

N.n16013 = N.n16013 or { id = 16013, name = "Deliana", map = 1455, x = 43.5, y = 52.6 }
N.n16012 = N.n16012 or { id = 16012, name = "Mokvar", map = 1454, x = 35.0, y = 38.3 }
N.n16016 = N.n16016 or { id = 16016, name = "Anthion Harmon", map = 1423, x = 26.1, y = 11.3 }
N.n16031 = N.n16031 or { id = 16031, name = "Ysida Harmon" }
N.n16032 = N.n16032 or { id = 16032, name = "Falrin Treeshaper" }
N.n16033 = N.n16033 or { id = 16033, name = "Bodley" }
N.t05_mux    = { id = 16014, name = "Mux Manascrambler", map = 1446, x = 52.5, y = 27.2 }
N.t05_viel   = { id = 16015, name = "Vi'el", map = 1452, x = 58.9, y = 78.4 }
N.t05_spirit = { id = 16073, name = "Spirit of Lord Valthalak" }

-- items used from the step's button
local REVEALER, DISTILLER, BRAZIER, AMULET = 22115, 21946, 22056, 22048

-- places
local BRM     = { map = 1427, x = 34.8, y = 85.3 } -- Blackrock Mountain (Searing Gorge entrance); Bodley is inside, north of the main entrance
local STRAT   = { map = 1423, x = 26.6, y = 10.5 }
local DM_WEST = { map = 1444, x = 60.3, y = 30.2 }

-- [class] = quest ID, for each faction
local EARNEST = {
    Alliance = { DRUID = 8905, HUNTER = 8906, MAGE = 8907, PALADIN = 8908, PRIEST = 8909, ROGUE = 8910, WARLOCK = 8911, WARRIOR = 8912 },
    Horde    = { DRUID = 8913, HUNTER = 8914, MAGE = 8915, PRIEST = 8916, ROGUE = 8917, SHAMAN = 8918, WARLOCK = 8919, WARRIOR = 8920 },
}
local JUST = {
    Alliance = { DRUID = 8926, HUNTER = 8931, MAGE = 8932, PALADIN = 8933, PRIEST = 8934, ROGUE = 8935, WARLOCK = 8936, WARRIOR = 8937 },
    Horde    = { DRUID = 8927, HUNTER = 8938, MAGE = 8939, PRIEST = 8940, ROGUE = 8941, SHAMAN = 8942, WARLOCK = 8943, WARRIOR = 8944 },
}
local PARTING = {
    Alliance = { DRUID = 8951, HUNTER = 8952, MAGE = 8953, PALADIN = 8954, PRIEST = 8955, ROGUE = 8956, WARLOCK = 8958, WARRIOR = 8959 },
    Horde    = { DRUID = 9016, HUNTER = 9017, MAGE = 9018, PRIEST = 9019, ROGUE = 9020, SHAMAN = 8957, WARLOCK = 9021, WARRIOR = 9022 },
}
local BEST = {
    Alliance = { DRUID = 8999, HUNTER = 9000, MAGE = 9001, PALADIN = 9002, PRIEST = 9003, ROGUE = 9004, WARLOCK = 9005, WARRIOR = 9006 },
    Horde    = { DRUID = 9007, HUNTER = 9008, MAGE = 9014, PRIEST = 9009, ROGUE = 9010, SHAMAN = 9011, WARLOCK = 9012, WARRIOR = 9013 },
}
local CLASS_ORDER = { "DRUID", "HUNTER", "MAGE", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR" }
local GIVER = { Alliance = "n16013", Horde = "n16012" }

local function Copy(t)
    local c = {}
    for k, v in pairs(t or {}) do c[k] = v end
    return c
end

ns:RegisterDungeon("SETT05", function()
    local steps, titles = {}, {}
    local function Add(s) steps[#steps + 1] = s end
    local function Title(ids, fr, en)
        for _, q in ipairs(ids) do titles[q] = L(fr, en) end
    end
    local function TitleSet(set, fr, en)
        for _, byClass in pairs(set) do
            for _, q in pairs(byClass) do titles[q] = L(fr, en) end
        end
    end
    -- one step per faction and class (class quests); npc = key or { Alliance = key, Horde = key }
    local function PerClass(make, set, npc, opts)
        for _, faction in ipairs({ "Alliance", "Horde" }) do
            for _, class in ipairs(CLASS_ORDER) do
                local q = set[faction][class]
                if q then
                    local o = Copy(opts)
                    o.faction, o.class = faction, class
                    local key = type(npc) == "table" and npc[faction] or npc
                    Add(make(q, key, o))
                end
            end
        end
    end
    local function AT(where, fr, en, extra)
        local t = Copy(extra)
        t.map, t.x, t.y = where.map, where.x, where.y
        if fr then t.text = L(fr, en) end
        return t
    end
    local AL, HO = { faction = "Alliance" }, { faction = "Horde" }

    TitleSet(EARNEST, "Une proposition sérieuse", "An Earnest Proposition")
    TitleSet(JUST, "Une juste compensation", "Just Compensation")
    TitleSet(PARTING, "Les adieux d'Anthion", "Anthion's Parting Words")
    TitleSet(BEST, "Garder le meilleur pour la fin", "Saving the Best for Last")
    Title({ 8922, 8923 }, "Un objet surnaturel", "A Supernatural Device")
    Title({ 8921 }, "L'alambic ectoplasmique", "The Ectoplasmic Distiller")
    Title({ 8924 }, "La chasse aux ectoplasmes", "Hunting for Ectoplasm")
    Title({ 8925 }, "Une source d'énergie portable", "A Portable Power Source")
    Title({ 8928 }, "Un marchand à éclipses", "A Shifty Merchant")
    Title({ 8977 }, "Retourner voir Deliana", "Return to Deliana")
    Title({ 8978 }, "Retourner voir Mokvar", "Return to Mokvar")
    Title({ 8929, 8930 }, "À la recherche d'Anthion", "In Search of Anthion")
    Title({ 8945 }, "La supplique du mort", "Dead Man's Plea")
    Title({ 8946 }, "Une preuve de vie", "Proof of Life")
    Title({ 8947 }, "L'étonnante requête d'Anthion", "Anthion's Strange Request")
    Title({ 8948 }, "Le vieil ami d'Anthion", "Anthion's Old Friend")
    Title({ 8949 }, "La vendetta de Falrin", "Falrin's Vendetta")
    Title({ 8950 }, "L'enchantement du provocateur", "The Instigator's Enchantment")
    Title({ 9015 }, "Le défi", "The Challenge")
    Title({ 8960 }, "Le triste destin de Bodley", "Bodley's Unfortunate Fate")
    Title({ 8961 }, "Les trois rois des flammes", "Three Kings of Flame")
    Title({ 8962, 8963, 8964, 8965 }, "Des composants importants", "Components of Importance")
    Title({ 8966, 8967, 8968, 8969 }, "Le morceau gauche de l'amulette du seigneur Valthalak", "The Left Piece of Lord Valthalak's Amulet")
    Title({ 8970 }, "Votre avenir passe par l'île d'Alcaz", "I See Alcaz Island In Your Future...")
    Title({ 8985, 8986, 8987, 8988 }, "D'autres composants importants", "More Components of Importance")
    Title({ 8989, 8990, 8991, 8992 }, "Le morceau droit de l'amulette du seigneur Valthalak", "The Right Piece of Lord Valthalak's Amulet")
    Title({ 8994 }, "Derniers préparatifs", "Final Preparations")
    Title({ 8995 }, "Mea culpa, seigneur Valthalak", "Mea Culpa, Lord Valthalak")
    Title({ 8996 }, "Retourner voir Bodley", "Return to Bodley")
    Title({ 8997, 8998 }, "Retour au commencement", "Back to the Beginning")

    ------------------------------------------------------------------
    -- Step 1: bracers (solo, 20 gold)
    ------------------------------------------------------------------
    PerClass(Accept, EARNEST, GIVER)
    Add(Do(8905, L("Berceau-de-l'Hiver : 15 échantillons de sang sur les sabres de givre",
        "Winterspring: 15 Winterspring Blood Samples from Frostsabers"),
        { faction = "Alliance", map = 1452, x = 50.5, y = 14.3, doneBy = { 8906, 8907, 8908, 8909, 8910, 8911, 8912 } }))
    Add(Do(8913, L("Silithus : 15 échantillons de venin sur les cinglepierres, glisseuses de sable et traqueuses des rochers",
        "Silithus: 15 Silithus Venom Samples from Stonelash scorpids, Sand Skitterers and Rock Stalkers"),
        { faction = "Horde", map = 1451, x = 45.4, y = 80.2, doneBy = { 8914, 8915, 8916, 8917, 8918, 8919, 8920 } }))
    PerClass(TurnIn, EARNEST, GIVER, { text = L("Remettre aussi les bracelets T0 et 20 po", "Also hand in the T0 bracers and 20 gold") })

    ------------------------------------------------------------------
    -- Step 2: belt & gloves (solo, about 100 gold)
    ------------------------------------------------------------------
    Add(Accept(8922, "n16013", Copy(AL)))
    Add(Accept(8923, "n16012", Copy(HO)))
    Add(TurnIn(8922, "t05_mux", Copy(AL)))
    Add(TurnIn(8923, "t05_mux", Copy(HO)))
    Add(Accept(8921, "t05_mux"))
    Add(Do(8921, L("Ramener 1 convertisseur d'arcanite délicat, 4 essences éternelles supérieures, 10 huiles de pierre-écaille et 25 cendres volcaniques (près des coulées de lave des Steppes ardentes)",
        "Bring 1 Delicate Arcanite Converter, 4 Greater Eternal Essence, 10 Stonescale Oil and 25 Volcanic Ash (next to the lava flows of the Burning Steppes)"),
        { map = 1428, x = 52.1, y = 42.6 }))
    Add(TurnIn(8921, "t05_mux"))
    Add(Accept(8924, "t05_mux", { text = L("Prévoir 4 à 8 carburants de fusée gobelins en plus des 8 donnés", "Bring 4 to 8 Goblin Rocket Fuel on top of the 8 you get") }))
    Add(Do(8924, L("Silithus, Sudevent : 12 ectoplasmes brûlés (utiliser l'alambic juste avant le premier fantôme)",
        "Silithus, Southwind: 12 Scorched Ectoplasm (use the distiller right before the first ghost)"),
        { item = DISTILLER, objIndex = 1, map = 1451, x = 61.6, y = 48.6 }))
    Add(Do(8924, L("Berceau-de-l'Hiver, lac Kel'Theril : 12 ectoplasmes glacés", "Winterspring, Lake Kel'Theril: 12 Frozen Ectoplasm"),
        { item = DISTILLER, objIndex = 2, map = 1452, x = 55.4, y = 43.4 }))
    Add(Do(8924, L("Maleterres de l'Est : 12 ectoplasmes stables sur les fantômes", "Eastern Plaguelands: 12 Stable Ectoplasm from the ghosts"),
        { item = DISTILLER, objIndex = 3, map = 1423, x = 54.2, y = 57.6 }))
    Add(TurnIn(8924, "t05_mux", { text = L("Rendre aussi l'alambic", "Hand the distiller back too") }))
    Add(Accept(8925, "t05_mux"))
    Add(Do(8925, L("Steppes ardentes : tuer le seigneur-magma Bokk (tirer ses gardes d'abord) et prendre son cœur",
        "Burning Steppes: kill Magma Lord Bokk (pull his guards first) and take his heart"), { map = 1428, x = 35.4, y = 57.7 }))
    Add(TurnIn(8925, "t05_mux"))
    Add(Accept(8928, "t05_mux"))
    Add(Do(8928, L("Gorge du Sombre Murmure (sud du Berceau-de-l'Hiver) : acheter le bâtonnet élémentaire de corruption à Vi'el (environ 40-50 po). Élite mais aucun combat nécessaire",
        "Darkwhisper Gorge (south Winterspring): buy the Corrupted Elemental Rod from Vi'el (40-50 gold). Elite, but no fight needed"),
        { map = 1452, x = 58.9, y = 78.4, targets = { "t05_viel" } }))
    Add(TurnIn(8928, "t05_mux"))
    Add(Accept(8977, "t05_mux", Copy(AL)))
    Add(Accept(8978, "t05_mux", Copy(HO)))
    Add(TurnIn(8977, "n16013", Copy(AL)))
    Add(TurnIn(8978, "n16012", Copy(HO)))
    PerClass(Accept, JUST, GIVER)
    PerClass(TurnIn, JUST, GIVER, { text = L("Remettre la ceinture et les gants T0", "Hand in the T0 belt and gloves") })

    ------------------------------------------------------------------
    -- Step 3: legs, shoulders & boots (45 minute Baron run, BRD arena)
    ------------------------------------------------------------------
    Add(Accept(8929, "n16013", Copy(AL)))
    Add(Accept(8930, "n16012", Copy(HO)))
    Add(TurnIn(8929, "n16016", { faction = "Alliance", item = REVEALER, text = L("Entrée de Stratholme : utiliser le révélateur de fantômes pour voir Anthion", "Stratholme entrance: use the Ghost Revealer to see Anthion") }))
    Add(TurnIn(8930, "n16016", { faction = "Horde", item = REVEALER, text = L("Entrée de Stratholme : utiliser le révélateur de fantômes pour voir Anthion", "Stratholme entrance: use the Ghost Revealer to see Anthion") }))
    Add(Accept(8945, "n16016", { item = REVEALER }))
    Add(Do(8945, L("Stratholme : atteindre le baron Vaillefendre en moins de 45 minutes pour sauver Ysida",
        "Stratholme: reach Baron Rivendare within 45 minutes to save Ysida"), AT(STRAT, nil, nil, { targets = { "n16031" } })))
    Add(TurnIn(8945, "n16031", { text = L("Ysida Harmon, salle du baron", "Ysida Harmon, the Baron's room") }))
    Add(Accept(8946, "n16031", { text = L("Ysida Harmon, salle du baron", "Ysida Harmon, the Baron's room") }))
    Add(TurnIn(8946, "n16016", { item = REVEALER }))
    Add(Accept(8947, "n16016", { item = REVEALER }))
    Add(Do(8947, L("Ramener 3 barres de sombrefer, 20 cuirs enchantés, 3 étoffes lunaires et 4 peaux robustes traitées",
        "Bring 3 Dark Iron Bars, 20 Enchanted Leather, 3 Mooncloth and 4 Cured Rugged Hide")))
    Add(TurnIn(8947, "n16016", { item = REVEALER }))
    Add(Accept(8948, "n16016", { item = REVEALER }))
    Add(TurnIn(8948, "n16032", AT(DM_WEST, "Falrin Sculpteflore, Athenaeum de Hache-Tripes Ouest", "Falrin Treeshaper, Athenaeum of Dire Maul West")))
    Add(Accept(8949, "n16032", AT(DM_WEST)))
    Add(Do(8949, L("25 perles de guerre ogres sur les ogres de Hache-Tripes ou du pic Rochenoire", "25 Ogre Warbeads from the ogres of Dire Maul or Blackrock Spire"), AT(DM_WEST)))
    Add(TurnIn(8949, "n16032", AT(DM_WEST)))
    Add(Accept(8950, "n16032", AT(DM_WEST)))
    Add(Do(8950, L("1 essence de spectre railleur (Eldreth, Hache-Tripes), 4 runes ténébreuses (Scholomance) et 8 grands éclats brillants",
        "1 Essence of Eldreth (Eldreth spirits, Dire Maul), 4 Dark Runes (Scholomance) and 8 Large Brilliant Shards"), AT(DM_WEST)))
    Add(TurnIn(8950, "n16032", AT(DM_WEST)))
    Add(Accept(9015, "n16032", AT(DM_WEST)))
    Add(Do(9015, L("Profondeurs de Rochenoire : se faire condamner par le juge Grimstone, planter la bannière de provocation dans l'arène, tuer Theldren et ses gladiateurs (bon groupe requis)",
        "Blackrock Depths: get sentenced by High Justice Grimstone, plant the Banner of Provocation in the arena, kill Theldren and his gladiators (bring a strong group)"), AT(BRM)))
    Add(TurnIn(9015, "n16016", { item = REVEALER }))
    PerClass(Accept, PARTING, "n16016", { item = REVEALER })
    PerClass(TurnIn, PARTING, GIVER, { text = L("Remettre le pantalon, les épaulettes et les bottes T0", "Hand in the T0 legs, shoulders and boots") })

    ------------------------------------------------------------------
    -- Step 4: helm & chest (raid for Lord Valthalak)
    ------------------------------------------------------------------
    Add(Accept(8960, "n16013", Copy(AL)))
    Add(Accept(8960, "n16012", Copy(HO)))
    Add(TurnIn(8960, "n16033", AT(BRM, "Mont Rochenoire, près de l'entrée principale côté nord : utiliser le révélateur de fantômes", "Blackrock Mountain, near the main entrance, north side: use the Ghost Revealer", { item = REVEALER })))
    Add(Accept(8961, "n16033", AT(BRM, nil, nil, { item = REVEALER })))
    Add(Do(8961, L("Incendicite d'Incendius (Profondeurs de Rochenoire), braise du pyrogarde Prophète ardent (Pic Rochenoire supérieur), cendres d'Asharell (Steppes ardentes, 72.3 68.3), et un brasero béni (120 po, intendant de l'Aube d'argent, Honoré)",
        "Incendicite from Lord Incendius (Blackrock Depths), Ember of the Pyroguard Emberseer (Upper Blackrock Spire), Ashes of Asharell (Burning Steppes, 72.3 68.3), and a Blessed Brazier (120 gold, Argent Dawn quartermaster, Honored)"),
        { map = 1428, x = 72.3, y = 68.3 }))
    Add(TurnIn(8961, "n16033", AT(BRM, nil, nil, { item = REVEALER })))

    -- Left piece: Bodley offers four components, take ONE (each leads to its own summon)
    local COMP_HOW = L("UNE au choix : restes druidiques (silithides de la Ruche'Regal, Silithus), relique de Brise-Stellaire (géants Cognegivre, Berceau-de-l'Hiver), épée brillante de fanatisme (prétoriens écarlates, Main de Tyr) ou cendres d'âme de banni (île de la Purification, Hillsbrad)",
        "ONE of them: Druidical Remains (Hive'Regal silithids, Silithus), Starbreeze Village Relic (Frostmaul giants, Winterspring), Brilliant Sword of Zealotry (Scarlet praetorians, Tyr's Hand) or Soul Ashes of the Banished (Purity island, Hillsbrad)")
    local SUMMON_HOW = L("Avec le brasero de signal : Mor Sabot-gris (salle de Voone, Pic Rochenoire inférieur), Isalien (salle d'Alzzin, Hache-Tripes Est), Jarien et Sothos (salle de Balnazzar, Stratholme) ou Kormok (salle de Ras Murmegivre, Scholomance), selon le composant",
        "With the Brazier of Beckoning: Mor Grayhoof (Voone's room, Lower Blackrock Spire), Isalien (Alzzin's room, Dire Maul East), Jarien and Sothos (Balnazzar's room, Stratholme) or Kormok (Ras Frostwhisper's room, Scholomance), depending on the component")
    Add(Accept(8962, "n16033", AT(BRM, "Bodley : prendre UNE des quêtes Des composants importants", "Bodley: take ONE Components of Importance quest", { item = REVEALER, doneBy = { 8963, 8964, 8965 } })))
    Add(Do(8962, COMP_HOW, { doneBy = { 8963, 8964, 8965 } }))
    Add(TurnIn(8962, "n16033", AT(BRM, nil, nil, { item = REVEALER, doneBy = { 8963, 8964, 8965 } })))
    Add(Accept(8966, "n16033", AT(BRM, nil, nil, { item = REVEALER, doneBy = { 8967, 8968, 8969 } })))
    Add(Do(8966, SUMMON_HOW, { item = BRAZIER, doneBy = { 8967, 8968, 8969 } }))
    Add(TurnIn(8966, "n16033", AT(BRM, nil, nil, { item = REVEALER, doneBy = { 8967, 8968, 8969 } })))
    Add(Accept(8970, "n16033", AT(BRM, nil, nil, { item = REVEALER })))
    Add(Do(8970, L("Île d'Alcaz (marécage d'Âprefange) : 20 varechs de sang sur les nagas Strashaz (élites)", "Alcaz Island (Dustwallow Marsh): 20 Bloodkelp from the Strashaz naga (elites)"),
        { map = 1445, x = 72.3, y = 18.3 }))
    Add(TurnIn(8970, "n16033", AT(BRM, nil, nil, { item = REVEALER })))

    -- Right piece: one of the three components not done yet
    Add(Accept(8985, "n16033", AT(BRM, "Bodley : prendre UNE des quêtes D'autres composants importants (pas celle déjà faite)", "Bodley: take ONE More Components of Importance quest (not the one already done)", { item = REVEALER, doneBy = { 8986, 8987, 8988 } })))
    Add(Do(8985, COMP_HOW, { doneBy = { 8986, 8987, 8988 } }))
    Add(TurnIn(8985, "n16033", AT(BRM, nil, nil, { item = REVEALER, doneBy = { 8986, 8987, 8988 } })))
    Add(Accept(8989, "n16033", AT(BRM, nil, nil, { item = REVEALER, doneBy = { 8990, 8991, 8992 } })))
    Add(Do(8989, SUMMON_HOW, { item = BRAZIER, doneBy = { 8990, 8991, 8992 } }))
    Add(TurnIn(8989, "n16033", AT(BRM, nil, nil, { item = REVEALER, doneBy = { 8990, 8991, 8992 } })))

    Add(Accept(8994, "n16033", AT(BRM, nil, nil, { item = REVEALER })))
    Add(Do(8994, L("40 brassards Rochenoire sur les orcs du pic Rochenoire, et un flacon de pouvoir suprême",
        "40 Blackrock Bracers from the Blackrock Spire orcs, and a Flask of Supreme Power"), AT(BRM)))
    Add(TurnIn(8994, "n16033", AT(BRM, nil, nil, { item = REVEALER })))
    Add(Accept(8995, "n16033", AT(BRM, nil, nil, { item = REVEALER })))
    Add(Do(8995, L("Pic Rochenoire supérieur, salle de la Bête : invoquer le seigneur Valthalak avec le brasero, le tuer (raid), utiliser l'amulette sur son corps",
        "Upper Blackrock Spire, the Beast's room: summon Lord Valthalak with the brazier, kill him (raid), use the amulet on his corpse"),
        AT(BRM, nil, nil, { item = BRAZIER })))
    Add(TurnIn(8995, "t05_spirit", AT(BRM, "Esprit du seigneur Valthalak, salle de la Bête", "Spirit of Lord Valthalak, the Beast's room", { item = AMULET })))
    Add(Accept(8996, "t05_spirit", AT(BRM, "Esprit du seigneur Valthalak, salle de la Bête", "Spirit of Lord Valthalak, the Beast's room")))
    Add(TurnIn(8996, "n16033", AT(BRM, nil, nil, { item = REVEALER })))
    Add(Accept(8997, "n16033", AT(BRM, nil, nil, { faction = "Alliance", item = REVEALER })))
    Add(Accept(8998, "n16033", AT(BRM, nil, nil, { faction = "Horde", item = REVEALER })))
    Add(TurnIn(8997, "n16013", Copy(AL)))
    Add(TurnIn(8998, "n16012", Copy(HO)))
    PerClass(Accept, BEST, GIVER)
    PerClass(TurnIn, BEST, GIVER, { text = L("Remettre le heaume et le torse T0", "Hand in the T0 helm and chest") })

    return {
        name = L("Set T0.5", "T0.5 Set"),
        levels = "58-60",
        overworld = true,
        icon = "Interface\\Icons\\INV_Helmet_08",
        entrance = BRM,
        titles = titles,
        steps = steps,
    }
end)
