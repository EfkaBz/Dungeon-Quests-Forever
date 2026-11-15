local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, D = ns.Accept, ns.TurnIn, ns.Do

-- ===================================================================
-- Quests and quest chains added at the launch of WoW Forever (source:
-- DungeonJournal 2.0.4, Nov 2026): class quests (Paladin Old Fire-Eye,
-- Rogue jobs for C, Shaman and Warrior armor quests), the Shen'dralas
-- chain, and the new quests of the classic dungeons. Merged by
-- ns:AddGuideSteps (Core.lua), so the saved checks of older steps stay valid.
-- ===================================================================

-- NPCs (map = uiMapID; forever = coordinates from DungeonJournal, kept as they are)
N.ql_alaana_stormwalker = { id = 0, name = "Alaana Stormwalker", map = 1412, x = 33.4, y = 22.5, forever = true }
N.ql_archmage_lan_dalock = { id = 0, name = "Archmage Lan'dalock", map = 1416, x = 15.4, y = 73.8, forever = true }
N.ql_charred_remains = { id = 0, name = "Charred Remains", map = 1421, x = 65.0, y = 34.2, forever = true }
N.ql_danitha_morr = { id = 0, name = "Danitha Morr", map = 1420, x = 22.0, y = 44.6, forever = true }
N.ql_dead_drop = { id = 0, name = "Dead Drop", map = 1421, x = 47.1, y = 71.1, forever = true }
N.ql_deathguard_baldren = { id = 0, name = "Deathguard Baldren", map = 1421, x = 45.6, y = 41.8, forever = true }
N.ql_dinita_stonemantle = { id = 0, name = "Dinita Stonemantle", map = 1455, x = 33.8, y = 60.2, forever = true }
N.ql_furen_longbeard = { id = 0, name = "Furen Longbeard", map = 1453, x = 58.0, y = 16.8, forever = true }
N.ql_garion_wendell = { id = 0, name = "Garion Wendell", map = 1453, x = 48.8, y = 86.6, forever = true }
N.ql_kog_thug_the_brave = { id = 0, name = "Kog'thug the Brave", map = 2652, x = 72.6, y = 31.4, forever = true }
N.ql_lorax = { id = 0, name = "Lorax", map = 1452, x = 63.8, y = 73.8, forever = true }
N.ql_lumina_windsinger = { id = 0, name = "Lumina Windsinger", map = 1421, x = 65.7, y = 27.4, forever = true }
N.ql_magister_kirandis = { id = 0, name = "Magister Kirandis", map = 2652, x = 47.2, y = 75.8, forever = true }
N.ql_magus_tirth = { id = 0, name = "Magus Tirth", map = 1441, x = 78.2, y = 75.8, forever = true }
N.ql_mazu_kon = { id = 0, name = "Mazu'kon", map = 1412, x = 32.5, y = 20.6, forever = true }
N.ql_mithera = { id = 0, name = "Mithera", map = 2652, x = 52.8, y = 76.0, forever = true }
N.ql_mordent_evenshade = { id = 0, name = "Mordent Evenshade", map = 2652, x = 35.0, y = 46.4, forever = true }
N.ql_olana_brighthoof = { id = 0, name = "Olana Brighthoof", map = 1412, x = 33.8, y = 23.7, forever = true }
N.ql_ott = { id = 0, name = "Ott", map = 1424, x = 60.4, y = 26.2, forever = true }
N.ql_prate_cloudseer = { id = 0, name = "Prate Cloudseer", map = 1441, x = 53.0, y = 42.0, forever = true }
N.ql_rau_cliffrunner = { id = 0, name = "Rau Cliffrunner", map = 1441, x = 46.0, y = 51.6, forever = true }
N.ql_ruga_ragetotem = { id = 0, name = "Ruga Ragetotem", map = 1413, x = 45.0, y = 59.0, forever = true }
N.ql_shen_dralar_pylon = { id = 0, name = "Shen'dralar Pylon", map = 2652, x = 43.6, y = 34.2, forever = true }
N.ql_sutara_plainstalker = { id = 0, name = "Sutara Plainstalker", map = 1412, x = 34.4, y = 22.8, forever = true }
N.ql_thun_grim_firegaze = { id = 0, name = "Thun'grim Firegaze", map = 1413, x = 57.0, y = 30.0, forever = true }
N.ql_trevan_rol = { id = 0, name = "Trevan Rol", map = 1421, x = 43.4, y = 41.0, forever = true }
N.ql_veyric_thunderhame = { id = 0, name = "Veyric Thunderhame", map = 1417, x = 59.6, y = 27.6, forever = true }
N.ql_woodwyrd = { id = 0, name = "Woodwyrd", map = 2652, x = 53.5, y = 76.0, forever = true }
N.ql_yorus_barleybrew = { id = 0, name = "Yorus Barleybrew" }

ns:AddGuideSteps("DM", function() return {
    titles = {
        [91858] = L("Diplomatic Incident", "Diplomatic Incident"),
        [91859] = L("A Curious Pair", "A Curious Pair"),
        [91860] = L("A Grim Fate", "A Grim Fate"),
        [91861] = L("Into Fenris Keep", "Into Fenris Keep"),
        [91862] = L("Lumina Windsinger", "Lumina Windsinger"),
        [96204] = L("The Windshaper's Wrath", "The Windshaper's Wrath"),
        [95034] = L("La dette", "The Debt"),
        [95036] = L("Une lame caressée par la lune", "A Moon-Kissed Blade"),
        [95111] = L("Un talent sous-coté", "An Underrated Talent"),
        [95125] = L("Le chef-d'œuvre d'Ott", "Ott's Masterwork"),
        [95126] = L("La lame de sélénargent", "The Moonsilver Blade"),
        [95140] = L("Le vieil Œil-de-feu", "Old Fire-Eye"),
    },
    groups = {
        { before = nil, steps = {
            A(91858, "ql_danitha_morr", { faction = "Horde", ["class"] = "PALADIN" }),
            T(91858, "ql_trevan_rol", { faction = "Horde", ["class"] = "PALADIN" }),
            A(91859, "ql_trevan_rol", { faction = "Horde", ["class"] = "PALADIN" }),
            T(91859, "ql_deathguard_baldren", { faction = "Horde", ["class"] = "PALADIN" }),
            A(91860, "ql_deathguard_baldren", { faction = "Horde", ["class"] = "PALADIN" }),
            D(91860, L("Investigate Fenris Isle to the east and learn the fate of the Earthen Ring traveling party.", "Investigate Fenris Isle to the east and learn the fate of the Earthen Ring traveling party."), { faction = "Horde", ["class"] = "PALADIN", map = 1421, x = 45.6, y = 41.8 }),
            T(91860, "ql_charred_remains", { faction = "Horde", ["class"] = "PALADIN" }),
            A(91861, "ql_charred_remains", { faction = "Horde", ["class"] = "PALADIN" }),
            D(91861, L("Investigate Fenris Keep to the north and attempt to locate the missing member of the Earthen Ring party.", "Investigate Fenris Keep to the north and attempt to locate the missing member of the Earthen Ring party."), { faction = "Horde", ["class"] = "PALADIN", map = 1421, x = 65.0, y = 34.2 }),
            T(91861, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            A(91862, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            D(91862, L("Retrieve the Fenris Isle Key from the Rot Hide Gnolls and use it to free Lumina Windsinger.", "Retrieve the Fenris Isle Key from the Rot Hide Gnolls and use it to free Lumina Windsinger."), { faction = "Horde", ["class"] = "PALADIN", map = 1421, x = 65.7, y = 27.4 }),
            T(91862, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            A(96204, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            D(96204, L("Accompany Lumina Windsinger and help her escape Fenris Keep.", "Accompany Lumina Windsinger and help her escape Fenris Keep."), { faction = "Horde", ["class"] = "PALADIN", map = 1421, x = 65.7, y = 27.4 }),
            T(96204, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            A(95034, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            T(95034, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            A(95036, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            T(95036, "ql_trevan_rol", { faction = "Horde", ["class"] = "PALADIN" }),
            A(95111, "ql_trevan_rol", { faction = "Horde", ["class"] = "PALADIN" }),
            T(95111, "ql_ott", { faction = "Horde", ["class"] = "PALADIN" }),
            A(95125, "ql_ott", { faction = "Horde", ["class"] = "PALADIN" }),
            D(95125, L("Regardez Ott forger votre lame.", "Watch as Ott forges your blade."), { faction = "Horde", ["class"] = "PALADIN", map = 1424, x = 60.4, y = 26.2 }),
            T(95125, "ql_ott", { faction = "Horde", ["class"] = "PALADIN" }),
            A(95126, "ql_ott", { faction = "Horde", ["class"] = "PALADIN" }),
            D(95126, L("Apportez le chef-d'œuvre d'Ott à Trevan Rol, dans la forêt des Pins-Argentés.", "Bring Ott's Masterwork to Trevan Rol in Silverpine Forest."), { faction = "Horde", ["class"] = "PALADIN", map = 1424, x = 60.4, y = 26.2 }),
            T(95126, "ql_trevan_rol", { faction = "Horde", ["class"] = "PALADIN" }),
            A(95140, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            D(95140, L("Utilisez la lame de sélénargent pour tuer le vieil Œil-de-feu, dans la forêt des Pins-Argentés.", "Use the Moonsilver Blade to destroy Old-Fire Eye in Silverpine Forest."), { faction = "Horde", ["class"] = "PALADIN" }),
            T(95140, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
        } },
    },
} end)

ns:AddGuideSteps("SFK", function() return {
    titles = {
        [91858] = L("Diplomatic Incident", "Diplomatic Incident"),
        [91859] = L("A Curious Pair", "A Curious Pair"),
        [91860] = L("A Grim Fate", "A Grim Fate"),
        [91861] = L("Into Fenris Keep", "Into Fenris Keep"),
        [91862] = L("Lumina Windsinger", "Lumina Windsinger"),
        [96204] = L("The Windshaper's Wrath", "The Windshaper's Wrath"),
        [95034] = L("La dette", "The Debt"),
        [95036] = L("Une lame caressée par la lune", "A Moon-Kissed Blade"),
        [95111] = L("Un talent sous-coté", "An Underrated Talent"),
        [95125] = L("Le chef-d'œuvre d'Ott", "Ott's Masterwork"),
        [95126] = L("La lame de sélénargent", "The Moonsilver Blade"),
        [95140] = L("Le vieil Œil-de-feu", "Old Fire-Eye"),
        [78261] = L("La Corne de Xelthos", "The Horn of Xelthos"),
        [78307] = L("La Corne de Xelthos", "The Horn of Xelthos"),
    },
    groups = {
        { before = nil, steps = {
            A(91858, "ql_danitha_morr", { faction = "Horde", ["class"] = "PALADIN" }),
            T(91858, "ql_trevan_rol", { faction = "Horde", ["class"] = "PALADIN" }),
            A(91859, "ql_trevan_rol", { faction = "Horde", ["class"] = "PALADIN" }),
            T(91859, "ql_deathguard_baldren", { faction = "Horde", ["class"] = "PALADIN" }),
            A(91860, "ql_deathguard_baldren", { faction = "Horde", ["class"] = "PALADIN" }),
            D(91860, L("Investigate Fenris Isle to the east and learn the fate of the Earthen Ring traveling party.", "Investigate Fenris Isle to the east and learn the fate of the Earthen Ring traveling party."), { faction = "Horde", ["class"] = "PALADIN", map = 1421, x = 45.6, y = 41.8 }),
            T(91860, "ql_charred_remains", { faction = "Horde", ["class"] = "PALADIN" }),
            A(91861, "ql_charred_remains", { faction = "Horde", ["class"] = "PALADIN" }),
            D(91861, L("Investigate Fenris Keep to the north and attempt to locate the missing member of the Earthen Ring party.", "Investigate Fenris Keep to the north and attempt to locate the missing member of the Earthen Ring party."), { faction = "Horde", ["class"] = "PALADIN", map = 1421, x = 65.0, y = 34.2 }),
            T(91861, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            A(91862, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            D(91862, L("Retrieve the Fenris Isle Key from the Rot Hide Gnolls and use it to free Lumina Windsinger.", "Retrieve the Fenris Isle Key from the Rot Hide Gnolls and use it to free Lumina Windsinger."), { faction = "Horde", ["class"] = "PALADIN", map = 1421, x = 65.7, y = 27.4 }),
            T(91862, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            A(96204, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            D(96204, L("Accompany Lumina Windsinger and help her escape Fenris Keep.", "Accompany Lumina Windsinger and help her escape Fenris Keep."), { faction = "Horde", ["class"] = "PALADIN", map = 1421, x = 65.7, y = 27.4 }),
            T(96204, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            A(95034, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            T(95034, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            A(95036, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            T(95036, "ql_trevan_rol", { faction = "Horde", ["class"] = "PALADIN" }),
            A(95111, "ql_trevan_rol", { faction = "Horde", ["class"] = "PALADIN" }),
            T(95111, "ql_ott", { faction = "Horde", ["class"] = "PALADIN" }),
            A(95125, "ql_ott", { faction = "Horde", ["class"] = "PALADIN" }),
            D(95125, L("Regardez Ott forger votre lame.", "Watch as Ott forges your blade."), { faction = "Horde", ["class"] = "PALADIN", map = 1424, x = 60.4, y = 26.2 }),
            T(95125, "ql_ott", { faction = "Horde", ["class"] = "PALADIN" }),
            A(95126, "ql_ott", { faction = "Horde", ["class"] = "PALADIN" }),
            D(95126, L("Apportez le chef-d'œuvre d'Ott à Trevan Rol, dans la forêt des Pins-Argentés.", "Bring Ott's Masterwork to Trevan Rol in Silverpine Forest."), { faction = "Horde", ["class"] = "PALADIN", map = 1424, x = 60.4, y = 26.2 }),
            T(95126, "ql_trevan_rol", { faction = "Horde", ["class"] = "PALADIN" }),
            A(95140, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            D(95140, L("Utilisez la lame de sélénargent pour tuer le vieil Œil-de-feu, dans la forêt des Pins-Argentés.", "Use the Moonsilver Blade to destroy Old-Fire Eye in Silverpine Forest."), { faction = "Horde", ["class"] = "PALADIN" }),
            T(95140, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
        } },
        { before = nil, steps = {
            A(78261, "ql_dead_drop", { ["class"] = "ROGUE", text = L("Dead Drop, Pyrewood Village, Silverpine Forest", "Dead Drop, Pyrewood Village, Silverpine Forest") }),
            D(78261, L("Trouvez la Corne de Xelthos dans le donjon d'Ombrecroc. Puis rapportez-la au point de livraison de C, près du village de Bois-du-Bûcher. Vous devez accomplir cette tâche sans l'aide de personne.", "Find The Horn of Xelthos inside of Shadowfang Keep. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."), { ["class"] = "ROGUE", map = 1421, x = 47.1, y = 71.1 }),
            T(78261, "ql_dead_drop", { ["class"] = "ROGUE" }),
            A(78307, "ql_dead_drop", { ["class"] = "ROGUE", text = L("Dead Drop, Pyrewood Village, Silverpine Forest", "Dead Drop, Pyrewood Village, Silverpine Forest") }),
            D(78307, L("Collect C's payment from the Dead Drop near Pyrewood Village.", "Collect C's payment from the Dead Drop near Pyrewood Village."), { ["class"] = "ROGUE" }),
            T(78307, "ql_dead_drop", { ["class"] = "ROGUE" }),
        } },
    },
} end)

ns:AddGuideSteps("BFD", function() return {
    titles = {
        [91858] = L("Diplomatic Incident", "Diplomatic Incident"),
        [91859] = L("A Curious Pair", "A Curious Pair"),
        [91860] = L("A Grim Fate", "A Grim Fate"),
        [91861] = L("Into Fenris Keep", "Into Fenris Keep"),
        [91862] = L("Lumina Windsinger", "Lumina Windsinger"),
        [96204] = L("The Windshaper's Wrath", "The Windshaper's Wrath"),
        [95034] = L("La dette", "The Debt"),
        [95036] = L("Une lame caressée par la lune", "A Moon-Kissed Blade"),
        [95111] = L("Un talent sous-coté", "An Underrated Talent"),
        [95125] = L("Le chef-d'œuvre d'Ott", "Ott's Masterwork"),
        [95126] = L("La lame de sélénargent", "The Moonsilver Blade"),
        [95140] = L("Le vieil Œil-de-feu", "Old Fire-Eye"),
    },
    groups = {
        { before = nil, steps = {
            A(91858, "ql_danitha_morr", { faction = "Horde", ["class"] = "PALADIN" }),
            T(91858, "ql_trevan_rol", { faction = "Horde", ["class"] = "PALADIN" }),
            A(91859, "ql_trevan_rol", { faction = "Horde", ["class"] = "PALADIN" }),
            T(91859, "ql_deathguard_baldren", { faction = "Horde", ["class"] = "PALADIN" }),
            A(91860, "ql_deathguard_baldren", { faction = "Horde", ["class"] = "PALADIN" }),
            D(91860, L("Investigate Fenris Isle to the east and learn the fate of the Earthen Ring traveling party.", "Investigate Fenris Isle to the east and learn the fate of the Earthen Ring traveling party."), { faction = "Horde", ["class"] = "PALADIN", map = 1421, x = 45.6, y = 41.8 }),
            T(91860, "ql_charred_remains", { faction = "Horde", ["class"] = "PALADIN" }),
            A(91861, "ql_charred_remains", { faction = "Horde", ["class"] = "PALADIN" }),
            D(91861, L("Investigate Fenris Keep to the north and attempt to locate the missing member of the Earthen Ring party.", "Investigate Fenris Keep to the north and attempt to locate the missing member of the Earthen Ring party."), { faction = "Horde", ["class"] = "PALADIN", map = 1421, x = 65.0, y = 34.2 }),
            T(91861, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            A(91862, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            D(91862, L("Retrieve the Fenris Isle Key from the Rot Hide Gnolls and use it to free Lumina Windsinger.", "Retrieve the Fenris Isle Key from the Rot Hide Gnolls and use it to free Lumina Windsinger."), { faction = "Horde", ["class"] = "PALADIN", map = 1421, x = 65.7, y = 27.4 }),
            T(91862, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            A(96204, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            D(96204, L("Accompany Lumina Windsinger and help her escape Fenris Keep.", "Accompany Lumina Windsinger and help her escape Fenris Keep."), { faction = "Horde", ["class"] = "PALADIN", map = 1421, x = 65.7, y = 27.4 }),
            T(96204, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            A(95034, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            T(95034, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            A(95036, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            T(95036, "ql_trevan_rol", { faction = "Horde", ["class"] = "PALADIN" }),
            A(95111, "ql_trevan_rol", { faction = "Horde", ["class"] = "PALADIN" }),
            T(95111, "ql_ott", { faction = "Horde", ["class"] = "PALADIN" }),
            A(95125, "ql_ott", { faction = "Horde", ["class"] = "PALADIN" }),
            D(95125, L("Regardez Ott forger votre lame.", "Watch as Ott forges your blade."), { faction = "Horde", ["class"] = "PALADIN", map = 1424, x = 60.4, y = 26.2 }),
            T(95125, "ql_ott", { faction = "Horde", ["class"] = "PALADIN" }),
            A(95126, "ql_ott", { faction = "Horde", ["class"] = "PALADIN" }),
            D(95126, L("Apportez le chef-d'œuvre d'Ott à Trevan Rol, dans la forêt des Pins-Argentés.", "Bring Ott's Masterwork to Trevan Rol in Silverpine Forest."), { faction = "Horde", ["class"] = "PALADIN", map = 1424, x = 60.4, y = 26.2 }),
            T(95126, "ql_trevan_rol", { faction = "Horde", ["class"] = "PALADIN" }),
            A(95140, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
            D(95140, L("Utilisez la lame de sélénargent pour tuer le vieil Œil-de-feu, dans la forêt des Pins-Argentés.", "Use the Moonsilver Blade to destroy Old-Fire Eye in Silverpine Forest."), { faction = "Horde", ["class"] = "PALADIN" }),
            T(95140, "ql_lumina_windsinger", { faction = "Horde", ["class"] = "PALADIN" }),
        } },
    },
} end)

ns:AddGuideSteps("RFK", function() return {
    titles = {
        [96264] = L("Soutien élémentaire", "Elemental Aid"),
        [79358] = L("Tempête, terre et feu", "Storm, Earth, and Fire"),
        [96135] = L("Entendez mon appel", "Heed My Call"),
        [96016] = L("Les armes de la tempête", "The Tempest's Weapons"),
        [79360] = L("Soutien élémentaire", "Elemental Aid"),
        [79364] = L("Surveiller les cieux", "Eyes on the Sky"),
        [79361] = L("Tempête, terre et feu", "Storm, Earth, and Fire"),
        [79366] = L("Entendez mon appel", "Heed My Call"),
        [79442] = L("Les armes de la tempête", "The Tempest's Weapons"),
        [1699] = L("Le défi de Rethban", "The Rethban Gauntlet"),
        [1702] = L("Fabricant de bouclier", "The Shieldsmith"),
        [1701] = L("Une cotte de mailles en acier trempé", "Fire Hardened Mail"),
        [1782] = L("L'armure de Furen", "Furen's Armor"),
        [1824] = L("L'épreuve du Champ des géants", "Trial at the Field of Giants"),
        [1825] = L("Parler à Thun'grim", "Speak with Thun'grim"),
        [1838] = L("Armure de brutalité", "Brutal Armor"),
        [1848] = L("Le haubert de brutalité", "Brutal Hauberk"),
    },
    groups = {
        { before = nil, steps = {
            A(96264, "ql_veyric_thunderhame", { faction = "Alliance", ["class"] = "SHAMAN" }),
            D(96264, L("Éliminez Charlga Trancheflanc au kraal de Tranchebauge et recueillez des renseignements sur les plans des Hurans.", "Defeat Charlga Razorflank in Razorfen Kraul and collect information on the quilboar's plans."), { faction = "Alliance", ["class"] = "SHAMAN", map = 1417, x = 59.6, y = 27.6 }),
            T(96264, "ql_veyric_thunderhame", { faction = "Alliance", ["class"] = "SHAMAN" }),
            A(79358, "ql_veyric_thunderhame", { faction = "Alliance", ["class"] = "SHAMAN" }),
            D(79358, L("Récupérez 5 totems de feu tordus, 5 totems de terre tordus, 5 totems d'air tordus et 5 totems d'eau tordus pour Veyric Hametonne dans les hautes-terres Arathies.", "Collect 5 Twisted Fire Totems, 5 Twisted Earth Totems, 5 Twisted Air Totems and 5 Twisted Water Totems for Veyric Thunderhame in Arathi Highlands."), { faction = "Alliance", ["class"] = "SHAMAN", map = 1417, x = 59.6, y = 27.6 }),
            T(79358, "ql_veyric_thunderhame", { faction = "Alliance", ["class"] = "SHAMAN" }),
            A(96135, "ql_veyric_thunderhame", { faction = "Alliance", ["class"] = "SHAMAN" }),
            D(96135, L("Utilisez les totems tordus pour mettre un terme au rituel des Hurans.", "Use the Twisted Totems to put an end to the quilboar ritual."), { faction = "Alliance", ["class"] = "SHAMAN", map = 1417, x = 59.6, y = 27.6 }),
            T(96135, "ql_veyric_thunderhame", { faction = "Alliance", ["class"] = "SHAMAN" }),
            A(96016, "ql_veyric_thunderhame", { faction = "Alliance", ["class"] = "SHAMAN" }),
            T(96016, "qu_bath_rah_the_windwatcher", { faction = "Alliance", ["class"] = "SHAMAN", text = L("Bath'rah the Windwatcher, Alterac Mountains (80.4, 66.8)", "Bath'rah the Windwatcher, Alterac Mountains (80.4, 66.8)") }),
        } },
        { before = nil, steps = {
            A(79360, "ql_rau_cliffrunner", { faction = "Horde", ["class"] = "SHAMAN" }),
            D(79360, L("Éliminez Charlga Trancheflanc au kraal de Tranchebauge et recueillez des renseignements sur les plans des Hurans.", "Defeat Charlga Razorflank in Razorfen Kraul and collect information on the quilboar's plans."), { faction = "Horde", ["class"] = "SHAMAN", map = 1441, x = 46.0, y = 51.6 }),
            T(79360, "ql_rau_cliffrunner", { faction = "Horde", ["class"] = "SHAMAN" }),
            A(79364, "ql_rau_cliffrunner", { faction = "Horde", ["class"] = "SHAMAN" }),
            T(79364, "ql_prate_cloudseer", { faction = "Horde", ["class"] = "SHAMAN" }),
            A(79361, "ql_prate_cloudseer", { faction = "Horde", ["class"] = "SHAMAN" }),
            D(79361, L("Récupérez 5 totems de feu tordus, 5 totems de terre tordus, 5 totems d'air tordus et 5 totems d'eau tordus pour Prate Œil-des-Nuages dans les Mille pointes.", "Collect 5 Twisted Fire Totems, 5 Twisted Earth Totems, 5 Twisted Air Totems and 5 Twisted Water Totems and turn them in to Prate Cloudseer in Thousand Needles."), { faction = "Horde", ["class"] = "SHAMAN", map = 1441, x = 53.0, y = 42.0 }),
            T(79361, "ql_prate_cloudseer", { faction = "Horde", ["class"] = "SHAMAN" }),
            A(79366, "ql_prate_cloudseer", { faction = "Horde", ["class"] = "SHAMAN" }),
            D(79366, L("Utilisez les totems tordus pour mettre un terme au rituel des Hurans.", "Use the Twisted Totems to put an end to the quilboar ritual."), { faction = "Horde", ["class"] = "SHAMAN", map = 1441, x = 53.0, y = 42.0 }),
            T(79366, "ql_prate_cloudseer", { faction = "Horde", ["class"] = "SHAMAN" }),
            A(79442, "ql_prate_cloudseer", { faction = "Horde", ["class"] = "SHAMAN" }),
            T(79442, "qu_bath_rah_the_windwatcher", { faction = "Horde", ["class"] = "SHAMAN", text = L("Bath'rah the Windwatcher, Alterac Mountains (80.4, 66.8)", "Bath'rah the Windwatcher, Alterac Mountains (80.4, 66.8)") }),
        } },
        { before = nil, steps = {
            A(1699, "ql_yorus_barleybrew", { faction = "Alliance", ["class"] = "WARRIOR", text = L("Yorus Barleybrew, Lakeshire, Redridge Mountains", "Yorus Barleybrew, Lakeshire, Redridge Mountains") }),
            D(1699, L("Entrer dans les Cavernes de Rethban jusqu'à la première fourche, et revenir voir Barleybrew dans le temps imparti. Vous ne devez pas mourir.", "Enter the Rethban Caverns, reach the first fork and return to Yorus Barleybrew in time. You must not die and release your spirit."), { faction = "Alliance", ["class"] = "WARRIOR" }),
            T(1699, "ql_yorus_barleybrew", { faction = "Alliance", ["class"] = "WARRIOR", text = L("Yorus Barleybrew, Lakeshire, Redridge Mountains", "Yorus Barleybrew, Lakeshire, Redridge Mountains") }),
            A(1702, "ql_yorus_barleybrew", { faction = "Alliance", ["class"] = "WARRIOR", text = L("Yorus Barleybrew, Lakeshire, Redridge Mountains", "Yorus Barleybrew, Lakeshire, Redridge Mountains") }),
            T(1702, "ql_furen_longbeard", { faction = "Alliance", ["class"] = "WARRIOR" }),
            A(1701, "ql_furen_longbeard", { faction = "Alliance", ["class"] = "WARRIOR" }),
            D(1701, L("Réunir les matériaux dont Furen Longbeard a besoin et lui apporter à Hurlevent.", "Gather the materials Furen Longbeard requires, and bring them to him in Stormwind."), { faction = "Alliance", ["class"] = "WARRIOR", map = 1453, x = 58.0, y = 16.8 }),
            T(1701, "ql_furen_longbeard", { faction = "Alliance", ["class"] = "WARRIOR" }),
            A(1782, "ql_furen_longbeard", { faction = "Alliance", ["class"] = "WARRIOR" }),
            T(1782, "ql_furen_longbeard", { faction = "Alliance", ["class"] = "WARRIOR" }),
        } },
        { before = nil, steps = {
            A(1824, "ql_ruga_ragetotem", { faction = "Horde", ["class"] = "WARRIOR" }),
            T(1824, "ql_ruga_ragetotem", { faction = "Horde", ["class"] = "WARRIOR" }),
            A(1825, "ql_ruga_ragetotem", { faction = "Horde", ["class"] = "WARRIOR" }),
            T(1825, "ql_thun_grim_firegaze", { faction = "Horde", ["class"] = "WARRIOR" }),
            A(1838, "ql_thun_grim_firegaze", { faction = "Horde", ["class"] = "WARRIOR" }),
            D(1838, L("Apporter à Thun'grim Firegaze 15 Lingots de Fer cendré, 10 Azurites en poudre, 10 Barres de Fer et une Fiole de Phlogiston.", "Bring Thun'grim Firegaze 15 Smoky Iron Ingots, 10 Powdered Azurite, 10 Iron Bars and a Vial of Phlogiston."), { faction = "Horde", ["class"] = "WARRIOR", map = 1413, x = 57.0, y = 30.0 }),
            T(1838, "ql_thun_grim_firegaze", { faction = "Horde", ["class"] = "WARRIOR" }),
            A(1848, "ql_thun_grim_firegaze", { faction = "Horde", ["class"] = "WARRIOR" }),
            T(1848, "ql_thun_grim_firegaze", { faction = "Horde", ["class"] = "WARRIOR" }),
        } },
    },
} end)

ns:AddGuideSteps("SMGY", function() return {
    titles = {
        [78261] = L("La Corne de Xelthos", "The Horn of Xelthos"),
        [78307] = L("La Corne de Xelthos", "The Horn of Xelthos"),
        [78676] = L("L'Œil de Bhossca", "The Eye of Bhossca"),
        [78699] = L("L'Œil de Bhossca", "The Eye of Bhossca"),
    },
    groups = {
        { before = nil, steps = {
            A(78261, "ql_dead_drop", { ["class"] = "ROGUE", text = L("Dead Drop, Pyrewood Village, Silverpine Forest", "Dead Drop, Pyrewood Village, Silverpine Forest") }),
            D(78261, L("Trouvez la Corne de Xelthos dans le donjon d'Ombrecroc. Puis rapportez-la au point de livraison de C, près du village de Bois-du-Bûcher. Vous devez accomplir cette tâche sans l'aide de personne.", "Find The Horn of Xelthos inside of Shadowfang Keep. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."), { ["class"] = "ROGUE", map = 1421, x = 47.1, y = 71.1 }),
            T(78261, "ql_dead_drop", { ["class"] = "ROGUE" }),
            A(78307, "ql_dead_drop", { ["class"] = "ROGUE", text = L("Dead Drop, Pyrewood Village, Silverpine Forest", "Dead Drop, Pyrewood Village, Silverpine Forest") }),
            D(78307, L("Collect C's payment from the Dead Drop near Pyrewood Village.", "Collect C's payment from the Dead Drop near Pyrewood Village."), { ["class"] = "ROGUE", map = 1421, x = 47.1, y = 71.1 }),
            T(78307, "ql_dead_drop", { ["class"] = "ROGUE" }),
            A(78676, "ql_dead_drop", { ["class"] = "ROGUE", text = L("Dead Drop, Pyrewood Village, Silverpine Forest", "Dead Drop, Pyrewood Village, Silverpine Forest") }),
            D(78676, L("Trouvez l'Œil de Bhossca dans le monastère Écarlate. Puis rapportez-la au point de livraison de C, près du village de Bois-du-Bûcher. Vous devez accomplir cette tâche sans l'aide de personne.", "Find The Eye of Bhossca inside of the Scarlet Monastery. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."), { ["class"] = "ROGUE", map = 1421, x = 47.1, y = 71.1 }),
            T(78676, "ql_dead_drop", { ["class"] = "ROGUE" }),
            A(78699, "ql_dead_drop", { ["class"] = "ROGUE", text = L("Dead Drop, Pyrewood Village, Silverpine Forest", "Dead Drop, Pyrewood Village, Silverpine Forest") }),
            D(78699, L("Collect C's payment from the Dead Drop near Pyrewood Village.", "Collect C's payment from the Dead Drop near Pyrewood Village."), { ["class"] = "ROGUE" }),
            T(78699, "ql_dead_drop", { ["class"] = "ROGUE" }),
        } },
    },
} end)

ns:AddGuideSteps("SMLIB", function() return {
    titles = {
        [78261] = L("La Corne de Xelthos", "The Horn of Xelthos"),
        [78307] = L("La Corne de Xelthos", "The Horn of Xelthos"),
        [78676] = L("L'Œil de Bhossca", "The Eye of Bhossca"),
        [78699] = L("L'Œil de Bhossca", "The Eye of Bhossca"),
        [1949] = L("Hidden Secrets", "Hidden Secrets"),
        [1950] = L("Get the Scoop", "Get the Scoop"),
        [1951] = L("Rituals of Power", "Rituals of Power"),
    },
    groups = {
        { before = nil, steps = {
            A(78261, "ql_dead_drop", { ["class"] = "ROGUE", text = L("Dead Drop, Pyrewood Village, Silverpine Forest", "Dead Drop, Pyrewood Village, Silverpine Forest") }),
            D(78261, L("Trouvez la Corne de Xelthos dans le donjon d'Ombrecroc. Puis rapportez-la au point de livraison de C, près du village de Bois-du-Bûcher. Vous devez accomplir cette tâche sans l'aide de personne.", "Find The Horn of Xelthos inside of Shadowfang Keep. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."), { ["class"] = "ROGUE", map = 1421, x = 47.1, y = 71.1 }),
            T(78261, "ql_dead_drop", { ["class"] = "ROGUE" }),
            A(78307, "ql_dead_drop", { ["class"] = "ROGUE", text = L("Dead Drop, Pyrewood Village, Silverpine Forest", "Dead Drop, Pyrewood Village, Silverpine Forest") }),
            D(78307, L("Collect C's payment from the Dead Drop near Pyrewood Village.", "Collect C's payment from the Dead Drop near Pyrewood Village."), { ["class"] = "ROGUE", map = 1421, x = 47.1, y = 71.1 }),
            T(78307, "ql_dead_drop", { ["class"] = "ROGUE" }),
            A(78676, "ql_dead_drop", { ["class"] = "ROGUE", text = L("Dead Drop, Pyrewood Village, Silverpine Forest", "Dead Drop, Pyrewood Village, Silverpine Forest") }),
            D(78676, L("Trouvez l'Œil de Bhossca dans le monastère Écarlate. Puis rapportez-la au point de livraison de C, près du village de Bois-du-Bûcher. Vous devez accomplir cette tâche sans l'aide de personne.", "Find The Eye of Bhossca inside of the Scarlet Monastery. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."), { ["class"] = "ROGUE", map = 1421, x = 47.1, y = 71.1 }),
            T(78676, "ql_dead_drop", { ["class"] = "ROGUE" }),
            A(78699, "ql_dead_drop", { ["class"] = "ROGUE", text = L("Dead Drop, Pyrewood Village, Silverpine Forest", "Dead Drop, Pyrewood Village, Silverpine Forest") }),
            D(78699, L("Collect C's payment from the Dead Drop near Pyrewood Village.", "Collect C's payment from the Dead Drop near Pyrewood Village."), { ["class"] = "ROGUE" }),
            T(78699, "ql_dead_drop", { ["class"] = "ROGUE" }),
        } },
        { before = nil, steps = {
            A(1949, "tabetha", { ["class"] = "MAGE" }),
            T(1949, "ql_magus_tirth", { ["class"] = "MAGE" }),
            A(1950, "ql_magus_tirth", { ["class"] = "MAGE" }),
            D(1950, L("Find the phrase to Tirth's strongbox, then return to Tirth.", "Find the phrase to Tirth's strongbox, then return to Tirth."), { ["class"] = "MAGE", map = 1441, x = 78.2, y = 75.8 }),
            T(1950, "ql_magus_tirth", { ["class"] = "MAGE" }),
            A(1951, "ql_magus_tirth", { ["class"] = "MAGE" }),
            T(1951, "tabetha", { ["class"] = "MAGE" }),
        } },
    },
} end)

ns:AddGuideSteps("RFD", function() return {
    titles = {
        [96773] = L("L'œil du Porte-froid", "The Coldbringer's Eye"),
        [97196] = L("L'Œil du Porte-froid", "The Coldbringer's Eye"),
        [92914] = L("D'étranges pylônes", "Strange Pylons"),
        [96010] = L("Fragments of the Pylons", "Fragments of the Pylons"),
        [96018] = L("Powering the Pylons", "Powering the Pylons"),
        [93016] = L("A Brief History Lesson", "A Brief History Lesson"),
        [93394] = L("Meeting the Magister", "Meeting the Magister"),
        [93341] = L("Forlorn Gardens", "Forlorn Gardens"),
        [93594] = L("Word of the Woods", "Word of the Woods"),
        [93404] = L("Rot and Regret", "Rot and Regret"),
        [93601] = L("Passing the Blame", "Passing the Blame"),
        [93604] = L("Agamaggan's Blood", "Agamaggan's Blood"),
    },
    groups = {
        { before = nil, steps = {
            A(96773, "ql_archmage_lan_dalock", { faction = "Alliance" }),
            D(96773, L("Récupérez l'Œil du Porte-froid dans les souilles de Tranchebauge.", "Recover The Coldbringer's Eye from Razorfen Downs."), { faction = "Alliance" }),
            T(96773, "ql_archmage_lan_dalock", { faction = "Alliance" }),
        } },
        { before = nil, steps = {
            A(97196, "ql_sutara_plainstalker", { faction = "Horde" }),
            D(97196, L("Récupérez l'œil du Porte-froid dans les souilles de Tranchebauge.", "Recover The Coldbringer's Eye from Razorfen Downs."), { faction = "Horde" }),
            T(97196, "ql_sutara_plainstalker", { faction = "Horde" }),
        } },
        { before = nil, steps = {
            A(92914, "ql_shen_dralar_pylon", { text = L("Shen'dralar Pylon, Shen'dralas (43.6, 34.2)", "Shen'dralar Pylon, Shen'dralas (43.6, 34.2)") }),
            D(92914, L("Explorez Shen'dralas pour trouver d'autres pylônes semblables à celui que vous avez découvert.", "Explore Shen'dralas in an effort to find other pylons like the one you found."), { map = 2652, x = 43.6, y = 34.2 }),
            T(92914, "ql_mordent_evenshade"),
            A(96010, "ql_mordent_evenshade"),
            D(96010, L("Recover shards and fragments of the pylons, found guarded at the Magram and Gelkis villages. Return them to Mordent Evenshade.", "Recover shards and fragments of the pylons, found guarded at the Magram and Gelkis villages. Return them to Mordent Evenshade."), { map = 2652, x = 35.0, y = 46.4 }),
            T(96010, "ql_mordent_evenshade"),
            A(96018, "ql_mordent_evenshade"),
            D(96018, L("Acquire the Mana Sieve from within the temple in Shen'dralas and use it to collect Ancient Mana Crystals, then empower the pylons and return to Mordent Evenshade.", "Acquire the Mana Sieve from within the temple in Shen'dralas and use it to collect Ancient Mana Crystals, then empower the pylons and return to Mordent Evenshade."), { map = 2652, x = 35.0, y = 46.4 }),
            T(96018, "ql_mordent_evenshade"),
            A(93016, "ql_mordent_evenshade"),
            T(93016, "ql_mordent_evenshade"),
            A(93394, "ql_mordent_evenshade"),
            D(93394, L("Locate Magister Kirandis inside the temple of Shen'dralas.", "Locate Magister Kirandis inside the temple of Shen'dralas."), { map = 2652, x = 35.0, y = 46.4 }),
            T(93394, "ql_magister_kirandis"),
            A(93341, "ql_mithera"),
            D(93341, L("Investigate the Forlorn Gardens near Shen'dralas and then return to Mithera at the nearby temple.", "Investigate the Forlorn Gardens near Shen'dralas and then return to Mithera at the nearby temple."), { map = 2652, x = 52.8, y = 76.0 }),
            T(93341, "ql_mithera"),
            A(93594, "ql_mithera"),
            D(93594, L("Find Woodwyrd in the Forlorn Gardens at Shen'dralas.", "Find Woodwyrd in the Forlorn Gardens at Shen'dralas."), { map = 2652, x = 52.8, y = 76.0 }),
            T(93594, "ql_woodwyrd"),
            A(93404, "ql_woodwyrd"),
            D(93404, L("Venture to Maraudon and recover a Vial of Earth Song Water, then use it to put out Woodwyrd's flame at the Forlorn Gardens.", "Venture to Maraudon and recover a Vial of Earth Song Water, then use it to put out Woodwyrd's flame at the Forlorn Gardens."), { map = 2652, x = 53.5, y = 76.0 }),
            T(93404, "ql_woodwyrd"),
            A(93601, "ql_woodwyrd"),
            T(93601, "ql_kog_thug_the_brave"),
            A(93604, "ql_kog_thug_the_brave"),
            D(93604, L("Venture to Razorfen Downs and acquire Virulent Blood of Agamaggan, then return it to Kog'thug the Brave at Bristleback Retreat.", "Venture to Razorfen Downs and acquire Virulent Blood of Agamaggan, then return it to Kog'thug the Brave at Bristleback Retreat.")),
            T(93604, "ql_kog_thug_the_brave"),
        } },
    },
} end)

ns:AddGuideSteps("ULDA", function() return {
    titles = {
        [2439] = L("Les Disques de platine", "The Platinum Discs"),
    },
    groups = {
        { before = nil, steps = {
            A(2439, "magellas", { faction = "Alliance" }),
            T(2439, "ql_dinita_stonemantle", { faction = "Alliance" }),
        } },
    },
} end)

ns:AddGuideSteps("ZF", function() return {
    titles = {
        [82084] = L("A Lesson in Literacy", "A Lesson in Literacy"),
        [96770] = L("The Witch Doctor's Head", "The Witch Doctor's Head"),
        [96775] = L("Zum'rah's Head", "Zum'rah's Head"),
    },
    groups = {
        { before = nil, steps = {
            A(82084, "ql_garion_wendell", { ["class"] = "MAGE" }),
            D(82084, L("Track down and collect the spellbook materials requested by the librarian.", "Track down and collect the spellbook materials requested by the librarian."), { ["class"] = "MAGE" }),
            T(82084, "ql_garion_wendell", { ["class"] = "MAGE" }),
        } },
        { before = nil, steps = {
            A(96770, "ql_archmage_lan_dalock", { faction = "Alliance" }),
            D(96770, L("Slay Witch Doctor Zum'rah and bring Zum'rah's Head to Archmage Lan'dalock in Dalaran.", "Slay Witch Doctor Zum'rah and bring Zum'rah's Head to Archmage Lan'dalock in Dalaran."), { faction = "Alliance" }),
            T(96770, "ql_archmage_lan_dalock", { faction = "Alliance" }),
        } },
        { before = nil, steps = {
            A(96775, "ql_mazu_kon", { faction = "Horde" }),
            D(96775, L("Slay Witch Doctor Zum'rah and bring Zum'rah's Head to Mazu'kon in Mulgore.", "Slay Witch Doctor Zum'rah and bring Zum'rah's Head to Mazu'kon in Mulgore."), { faction = "Horde" }),
            T(96775, "ql_mazu_kon", { faction = "Horde" }),
        } },
    },
} end)

ns:AddGuideSteps("MARA", function() return {
    titles = {
        [92914] = L("D'étranges pylônes", "Strange Pylons"),
        [96010] = L("Fragments of the Pylons", "Fragments of the Pylons"),
        [96018] = L("Powering the Pylons", "Powering the Pylons"),
        [93016] = L("A Brief History Lesson", "A Brief History Lesson"),
        [93394] = L("Meeting the Magister", "Meeting the Magister"),
        [93341] = L("Forlorn Gardens", "Forlorn Gardens"),
        [93594] = L("Word of the Woods", "Word of the Woods"),
        [93404] = L("Rot and Regret", "Rot and Regret"),
        [96776] = L("An'she's Radiance", "An'she's Radiance"),
    },
    groups = {
        { before = nil, steps = {
            A(92914, "ql_shen_dralar_pylon", { text = L("Shen'dralar Pylon, Shen'dralas (43.6, 34.2)", "Shen'dralar Pylon, Shen'dralas (43.6, 34.2)") }),
            D(92914, L("Explorez Shen'dralas pour trouver d'autres pylônes semblables à celui que vous avez découvert.", "Explore Shen'dralas in an effort to find other pylons like the one you found."), { map = 2652, x = 43.6, y = 34.2 }),
            T(92914, "ql_mordent_evenshade"),
            A(96010, "ql_mordent_evenshade"),
            D(96010, L("Recover shards and fragments of the pylons, found guarded at the Magram and Gelkis villages. Return them to Mordent Evenshade.", "Recover shards and fragments of the pylons, found guarded at the Magram and Gelkis villages. Return them to Mordent Evenshade."), { map = 2652, x = 35.0, y = 46.4 }),
            T(96010, "ql_mordent_evenshade"),
            A(96018, "ql_mordent_evenshade"),
            D(96018, L("Acquire the Mana Sieve from within the temple in Shen'dralas and use it to collect Ancient Mana Crystals, then empower the pylons and return to Mordent Evenshade.", "Acquire the Mana Sieve from within the temple in Shen'dralas and use it to collect Ancient Mana Crystals, then empower the pylons and return to Mordent Evenshade."), { map = 2652, x = 35.0, y = 46.4 }),
            T(96018, "ql_mordent_evenshade"),
            A(93016, "ql_mordent_evenshade"),
            T(93016, "ql_mordent_evenshade"),
            A(93394, "ql_mordent_evenshade"),
            D(93394, L("Locate Magister Kirandis inside the temple of Shen'dralas.", "Locate Magister Kirandis inside the temple of Shen'dralas."), { map = 2652, x = 35.0, y = 46.4 }),
            T(93394, "ql_magister_kirandis"),
            A(93341, "ql_mithera"),
            D(93341, L("Investigate the Forlorn Gardens near Shen'dralas and then return to Mithera at the nearby temple.", "Investigate the Forlorn Gardens near Shen'dralas and then return to Mithera at the nearby temple."), { map = 2652, x = 52.8, y = 76.0 }),
            T(93341, "ql_mithera"),
            A(93594, "ql_mithera"),
            D(93594, L("Find Woodwyrd in the Forlorn Gardens at Shen'dralas.", "Find Woodwyrd in the Forlorn Gardens at Shen'dralas."), { map = 2652, x = 52.8, y = 76.0 }),
            T(93594, "ql_woodwyrd"),
            A(93404, "ql_woodwyrd"),
            D(93404, L("Venture to Maraudon and recover a Vial of Earth Song Water, then use it to put out Woodwyrd's flame at the Forlorn Gardens.", "Venture to Maraudon and recover a Vial of Earth Song Water, then use it to put out Woodwyrd's flame at the Forlorn Gardens.")),
            T(93404, "ql_woodwyrd"),
        } },
        { before = nil, steps = {
            A(96776, "ql_olana_brighthoof", { faction = "Horde" }),
            D(96776, L("Recover the crystal known as An'she's Radiance from Maraudon and return it to Olana Brighthoof in Mulgore.", "Recover the crystal known as An'she's Radiance from Maraudon and return it to Olana Brighthoof in Mulgore."), { faction = "Horde" }),
            T(96776, "ql_olana_brighthoof", { faction = "Horde" }),
        } },
    },
} end)

ns:AddGuideSteps("BRD", function() return {
    titles = {
        [97197] = L("Fragment of the Firelands", "Fragment of the Firelands"),
    },
    groups = {
        { before = nil, steps = {
            A(97197, "ql_alaana_stormwalker", { faction = "Horde" }),
            D(97197, L("Recover a Fragment of the Firelands from Blackrock Depths for Alaana Stormwalker in Mulgore.", "Recover a Fragment of the Firelands from Blackrock Depths for Alaana Stormwalker in Mulgore."), { faction = "Horde" }),
            T(97197, "ql_alaana_stormwalker", { faction = "Horde" }),
        } },
    },
} end)

ns:AddGuideSteps("LBRS", function() return {
    titles = {
        [98325] = L("Blood and Thunder", "Blood and Thunder"),
    },
    groups = {
        { before = 4903, steps = {
            A(98325, "att_goretooth", { faction = "Horde" }),
            T(98325, "att_goretooth", { faction = "Horde" }),
        } },
    },
} end)

ns:AddGuideSteps("UBRS", function() return {
    titles = {
        [98325] = L("Blood and Thunder", "Blood and Thunder"),
        [5127] = L("La forge démoniaque", "The Demon Forge"),
    },
    groups = {
        { before = 4974, steps = {
            A(98325, "att_goretooth", { faction = "Horde" }),
            T(98325, "att_goretooth", { faction = "Horde" }),
        } },
        { before = nil, steps = {
            A(5127, "ql_lorax"),
            T(5127, "ql_lorax"),
        } },
    },
} end)

ns:AddGuideSteps("DMN", function() return {
    titles = {
        [7483] = L("Libram de Rapidité", "Libram of Rapidity"),
        [7484] = L("Libram de focalisation", "Libram of Focus"),
        [7485] = L("Libram de Protection", "Libram of Protection"),
    },
    groups = {
        { before = nil, steps = {
            A(7483, "n14368", { text = L("Lorekeeper Lydros, Athenaeum, Dire Maul", "Lorekeeper Lydros, Athenaeum, Dire Maul") }),
            T(7483, "n14368", { text = L("Lorekeeper Lydros, Athenaeum, Dire Maul", "Lorekeeper Lydros, Athenaeum, Dire Maul") }),
        } },
        { before = nil, steps = {
            A(7484, "n14368", { text = L("Lorekeeper Lydros, Athenaeum, Dire Maul", "Lorekeeper Lydros, Athenaeum, Dire Maul") }),
            T(7484, "n14368", { text = L("Lorekeeper Lydros, Athenaeum, Dire Maul", "Lorekeeper Lydros, Athenaeum, Dire Maul") }),
        } },
        { before = nil, steps = {
            A(7485, "n14368", { text = L("Lorekeeper Lydros, Athenaeum, Dire Maul", "Lorekeeper Lydros, Athenaeum, Dire Maul") }),
            T(7485, "n14368", { text = L("Lorekeeper Lydros, Athenaeum, Dire Maul", "Lorekeeper Lydros, Athenaeum, Dire Maul") }),
        } },
    },
} end)

ns:AddGuideSteps("ATT_ONY", function() return {
    titles = {
        [98325] = L("Blood and Thunder", "Blood and Thunder"),
    },
    groups = {
        { before = 6602, steps = {
            A(98325, "att_goretooth", { faction = "Horde" }),
            T(98325, "att_goretooth", { faction = "Horde" }),
        } },
    },
} end)

-- Translations of the new texts (the English text is the key, see Core\Locale.lua)
do local C = ns.CONTENT.de
    C["A Moon-Kissed Blade"] = "Eine mondgeküsste Klinge"
    C["A Small Favor"] = "Ein kleiner Gefallen"
    C["A Token of Vengeance"] = "Ein Symbol der Rache"
    C["An Acquaintance in Southshore"] = "Eine Bekanntschaft in Southshore"
    C["An Underrated Talent"] = "Ein unterschätztes Talent"
    C["Ancient Gurubashi Idol"] = "Uralter Götze der Gurubashi"
    C["Ancient Gurubashi Secrets"] = "Uralte Geheimnisse der Gurubashi"
    C["Bad Medicine"] = "Schlechte Medizin"
    C["Bring 4 Skullsplitter Fetishes to Brother Nimetz."] = "Bringt Bruder Nimetz 4 Fetische der Skullsplitter ins Rebellenlager."
    C["Bring 7 Jungle Remedies and 1 Venom Fern Extract to Sergeant Yohwa."] = "Bringt Sergeant Yohwa im Rebellenlager 7 Dschungelarzneien und 1 Giftfarnextrakt."
    C["Bring Ott's Masterwork to Trevan Rol in Silverpine Forest."] = "Bringt Otts Meisterwerk zu Trevan Rol im Silberwald."
    C["Bring Thun'grim Firegaze 15 Smoky Iron Ingots, 10 Powdered Azurite, 10 Iron Bars and a Vial of Phlogiston."] = "Bringt Thun'grim Firegaze 15 rauchige Eisenblöcke, 10 pulverisierte Azurite, 10 Eisenbarren und 1 Phiole Phlogiston."
    C["Brutal Armor"] = "Brutale Rüstung"
    C["Brutal Hauberk"] = "Brutale Halsberge"
    C["Collect 10 Voodoo-Infused Artifacts from the Saltseer pirates in the Drowned City."] = "Sammelt 10 voodooerfüllte Artefakte von den Salzseherpiraten in der Versunkenen Stadt."
    C["Collect 15 Cultist Ears from the Twilight's Hammer in Krol'dok Stronghold."] = "Sammelt 15 Kultistenohren der Twilight-Hammer in der Feste Krol'dok."
    C["Collect 5 I'lalai Fetishes from the trolls in the Drowned City."] = "Sammelt 5 Fetische von I'lalai von Trollen in der Versunkenen Stadt."
    C["Collect 5 Twisted Fire Totems, 5 Twisted Earth Totems, 5 Twisted Air Totems and 5 Twisted Water Totems and turn them in to Prate Cloudseer in Thousand Needles."] = "Sammelt 5 verdrehte Feuertotems, 5 verdrehte Erdtotems, 5 verdrehte Lufttotems und 5 verdrehte Wassertotems für Prate Cloudseer in Tausend Nadeln."
    C["Collect 5 Twisted Fire Totems, 5 Twisted Earth Totems, 5 Twisted Air Totems and 5 Twisted Water Totems for Veyric Thunderhame in Arathi Highlands."] = "Sammelt 5 verdrehte Feuertotems, 5 verdrehte Erdtotems, 5 verdrehte Lufttotems und 5 verdrehte Wassertotems für Veyric Thunderhame im Arathihochland."
    C["Collect 8 Twilight Bangles from the Twilight's Hammer in Krol'dok Stronghold."] = "Sammelt 8 Kultistenarmreife der Twilight-Hammer in der Feste Krol'dok."
    C["Collect C's payment from the Dead Drop near Pyrewood Village."] = "Holt Eure Bezahlung von C am Toten Briefkasten bei Lohenscheit ab."
    C["Defeat 8 Twilight Raiders, 8 Twilight Shadowmancers and 8 Twilight Neophytes within Sunnyglade for Demar Brant."] = "Besiegt für Demar Brant 8 Twilight-Räuber, 8 Twilight-Schattenbeschwörer und 8 Twilight-Neophyten in Sonnengrund."
    C["Defeat Charlga Razorflank in Razorfen Kraul and collect information on the quilboar's plans."] = "Besiegt Charlga Razorflank im Kral von Razorfen und sammelt Informationen über die Pläne der Stacheleber."
    C["Elemental Aid"] = "Elementare Hilfe"
    C["Enemies in the Water"] = "Feinde im Wasser"
    C["Enter the Rethban Caverns, reach the first fork and return to Yorus Barleybrew in time. You must not die and release your spirit."] = "Betretet die Rethbanhöhlen, geht bis zur ersten Gabelung und kehrt innerhalb der zulässigen Zeit zu Yorus Gerstenbräu zurück.\n\nIhr dürft nicht sterben und Euren Geist befreien."
    C["Explore Shen'dralas in an effort to find other pylons like the one you found."] = "Erkundet Shen'dralas, um andere Pylonen wie den zu finden, den ihr bereits gefunden habt."
    C["Explore just west of the Vile Reef and find the cavern entrance, then report back to Kin'weelay."] = "Erkundet das finstere Riff und findet den Höhleneingang."
    C["Eye of Mugg"] = "Auge von Mugg"
    C["Eyes on the Sky"] = "Blick zum Himmel"
    C["Find Sergeant Riftan near the Twilight's Shroud to the west."] = "Findet Sergeant Riftan in der Nähe des Twilight-Schleiers im Westen."
    C["Find The Eye of Bhossca inside of the Scarlet Monastery. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."] = "Findet das Auge von Bhossca im Scharlachroten Kloster. Kehrt dann zum toten Briefkasten von C bei Pyrewood zurück. Diesen Auftrag müsst Ihr alleine erledigen."
    C["Find The Horn of Xelthos inside of Shadowfang Keep. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."] = "Findet das Horn von Xelthos in der Burg Schattenfang. Kehrt dann zum toten Briefkasten von C bei Pyrewood zurück. Diesen Auftrag müsst Ihr alleine erledigen."
    C["Find the four troll tablets on the coast and in the Vile Reef, and bring back the First, Second, Third and Fourth Troll Legends."] = "Findet die 4 Schrifttafeln und bringt ihre Legenden zu Bruder Nimetz zurück."
    C["Findings for the Explorer's League"] = "Bericht für die Forscherliga"
    C["Fire Hardened Mail"] = "Feuergehärteter Panzer"
    C["Fragments of the Pylons"] = "Die Fragmente der Pylonen"
    C["Furen's Armor"] = "Furens Rüstung"
    C["Gather 10 Brinescale Tridents from Brinescale Skirmishers."] = "Sammelt 10 Laugenschuppendreizacke von Scharmützlern der Laugenschuppen."
    C["Gather the materials Furen Longbeard requires, and bring them to him in Stormwind."] = "Sammelt die Materialien, die Furen Longbeard benötigt, und bringt sie zu ihm nach Stormwind."
    C["Heed My Call"] = "Hört meinen Ruf"
    C["Infiltrate Krol'dok Stronghold and return to Commander Brant with proof of their leader's demise."] = "Dringt in die Feste Krol'dok ein und bringt Hauptmann Brant einen Beweis vom Ableben ihres Anführers."
    C["Infiltrate Krol'dok Stronghold and return to Krom'rosh with proof of their leader's demise."] = "Dringt in die Feste Krol'dok ein und bringt Krom'rosh einen Beweis vom Ableben ihres Anführers."
    C["Kill 15 Kurzen Jungle Fighters."] = "Tötet 15 von Kurzens Dschungelkämpfern.\n\nKehrt ins Rebellenlager zu Sergeant Yohwa zurück."
    C["Kill Nar'gurk in Krol'dok Stronghold and recover any valuable information."] = "Tötet Nar'gurk in der Feste Krol'dok und erbeutet jegliche nützlichen Informationen."
    C["Kill Var'Taka in the Drowned City."] = "Tötet Var'Taka in der Versunkenen Stadt."
    C["Krol'dok Moulding"] = "Abguss von Krol'Dok"
    C["Kurzen's Mystery"] = "Das Geheimnis um Kurzen"
    C["Libram of Focus"] = "Buchband des Fokus"
    C["Libram of Protection"] = "Buchband des Schutzes"
    C["Libram of Rapidity"] = "Buchband der Schnelligkeit"
    C["Locating the Lost City"] = "Die Suche nach der verlorenen Stadt"
    C["Magics of the Drowned City"] = "Die Magie der Versunkenen Stadt"
    C["Make rubbings of the four Tablets of I'lalai in the Drowned City."] = "Verwendet die Haut und die Holzkohle, um Abpausbilder der Schrifttafeln in der Versunkenen Stadt anzufertigen."
    C["Old Fire-Eye"] = "Feuerauge der Alte"
    C["Ott's Masterwork"] = "Otts Meisterwerk"
    C["Recover The Coldbringer's Eye from Razorfen Downs."] = "Bergt das Auge des Kältebringers in den Hügeln von Razorfen."
    C["Recover an Ancient Gurubashi Idol from the Drowned City."] = "Bergt einen uralten Götzen der Gurubashi aus der Versunkenen Stadt."
    C["Recover shards and fragments of the pylons, found guarded at the Magram and Gelkis villages. Return them to Mordent Evenshade."] = "Bergt Scherben und Fragmente der Pylonen, die in den Dörfern der Magram und der Gelkis bewacht werden, und bringt sie zurück zu Mordent Evenshade."
    C["Recover the Tome of Twilight from Krol'dok Stronghold."] = "Bergt den Twilightfolianten in der Feste Krol'dok."
    C["Saving Sunnyglade"] = "Die Rettung von Sonnengrund"
    C["Shady Saltseers"] = "Zwielichtige Salzseher"
    C["Slay Captain Dreadrise and 3 Saltseer Coroners in the Drowned City."] = "Tötet 3 Leichensammler der Salzseher und Captain Dreadrise in der Versunkenen Stadt."
    C["Slay Witch Doctor Zum'rah and bring Zum'rah's Head to Archmage Lan'dalock in Dalaran."] = "Tötet den Hexendoktor Zum'rah und bringt Zum'rahs Kopf zu Erzmagier Lan'dalock in Dalaran."
    C["Speak with Thun'grim"] = "Gespräch mit Thun'grim"
    C["Storm, Earth, and Fire"] = "Sturm, Erde und Feuer"
    C["Strange Pylons"] = "Seltsame Pylonen"
    C["Summon a Twilight's Thrall from a conduit within the Twilight's Shroud and capture it with Amberhall's Soulstone."] = "Beschwört einen Twilight-Knecht aus einer Leitung im Twilight-Schleier und fangt ihn in Amberhalls Seelenstein ein."
    C["Take Two With Water"] = "Zwei mit Wasser einnehmen"
    C["The Coldbringer's Eye"] = "Das Auge des Kältebringers"
    C["The Debt"] = "Die Schuld"
    C["The Demon Forge"] = "Die Dämonenschmiede"
    C["The Drowned City"] = "Die Versunkene Stadt"
    C["The Eye of Bhossca"] = "Das Auge von Bhossca"
    C["The Gurubashi Legends of Old"] = "Die alten Legenden der Gurubashi"
    C["The Horn of Xelthos"] = "Das Horn von Xelthos"
    C["The Moonsilver Blade"] = "Die Mondsilberklinge"
    C["The Only Good Brinescale..."] = "...ist eine gute Laugenschuppe"
    C["The Platinum Discs"] = "Die Platinscheiben"
    C["The Rethban Gauntlet"] = "Der Rethban-Spießrutenlauf"
    C["The Saltseer Captain"] = "Der Kapitän der Salzseher"
    C["The Second Rebellion"] = "Die zweite Rebellion"
    C["The Shieldsmith"] = "Der Schildschmied"
    C["The Tempest's Weapons"] = "Die Waffen des Sturmgewitters"
    C["The Vile Reef"] = "Das finstere Riff"
    C["The Western Front"] = "Die westliche Front"
    C["The Witch Doctor's Head"] = "Der Kopf des Hexendoktors"
    C["Tome of Twilight"] = "Twilightfoliant"
    C["Trial at the Field of Giants"] = "Prüfung auf dem Feld der Riesen"
    C["Troll Witchery"] = "Troll-Hexerei"
    C["Twilight Mementos"] = "Twilight-Andenken"
    C["Use the Moonsilver Blade to destroy Old-Fire Eye in Silverpine Forest."] = "Verwendet die Mondsilberklinge, um Feuerauge den Alten im Silberwald zu vernichten."
    C["Use the Twisted Totems to put an end to the quilboar ritual."] = "Verwendet die verdrehten Totems, um das Stacheleberritual ein für alle mal zu beenden."
    C["Use the hide and charcoal to make a rubbing of the Third Troll Legend tablet."] = "Verwendet die Haut und die Holzkohle, um ein Abpausbild der dritten Trolllegende anzufertigen."
    C["Use the hide and charcoal to make rubbings of the four Tablets of I'lalai in the Drowned City."] = "Verwendet die Haut und die Holzkohle, um Abpausbilder der Schrifttafeln in der Versunkenen Stadt anzufertigen."
    C["Vengeance of the Highborne"] = "Rache der Hochgeborenen"
    C["Watch as Ott forges your blade."] = "Seht zu, während Ott Eure Klinge schmiedet."
end
do local C = ns.CONTENT.es
    C["A Moon-Kissed Blade"] = "Una hoja tocada por la luna"
    C["A Small Favor"] = "Un pequeño favor"
    C["A Token of Vengeance"] = "Una prueba de venganza"
    C["An Underrated Talent"] = "Un talento infravalorado"
    C["Ancient Gurubashi Idol"] = "Un antiguo ídolo Gurubashi"
    C["Ancient Gurubashi Secrets"] = "Antiguos secretos Gurubashi"
    C["Bad Medicine"] = "Mala medicina"
    C["Bring 4 Skullsplitter Fetishes to Brother Nimetz."] = "Lleva 4 fetiches Machacacráneos al hermano Nimetz en el Asentamiento Rebelde."
    C["Bring 7 Jungle Remedies and 1 Venom Fern Extract to Sergeant Yohwa."] = "Lleva 7 remedios de la jungla y 1 extracto de veneno de helecho al sargento Yohwa en el Asentamiento Rebelde."
    C["Bring Ott's Masterwork to Trevan Rol in Silverpine Forest."] = "Llévale la obra maestra de Ott a Trevan Rol en el Bosque de Argénteos."
    C["Bring Thun'grim Firegaze 15 Smoky Iron Ingots, 10 Powdered Azurite, 10 Iron Bars and a Vial of Phlogiston."] = "Lleva 15 lingotes de hierro humeantes, 10 azuritas en polvo, 10 lingotes de hierro y un vial de flogisto a Thun'grim Vistafuego."
    C["Brutal Armor"] = "Armadura brutal"
    C["Brutal Hauberk"] = "Camisote brutal"
    C["Collect 10 Voodoo-Infused Artifacts from the Saltseer pirates in the Drowned City."] = "Recoge 10 artefactos imbuidos de vudú de los piratas Videntesal en la Ciudad Sumergida."
    C["Collect 15 Cultist Ears from the Twilight's Hammer in Krol'dok Stronghold."] = "Consigue 15 orejas de cultores del Martillo Crepuscular en el Bastión Krol'dok."
    C["Collect 5 I'lalai Fetishes from the trolls in the Drowned City."] = "Recoge 5 fetiches I'lalai de los trols en la Ciudad Sumergida."
    C["Collect 8 Twilight Bangles from the Twilight's Hammer in Krol'dok Stronghold."] = "Consigue 8 broches de cultor del Martillo Crepuscular en el Bastión Krol'dok."
    C["Collect C's payment from the Dead Drop near Pyrewood Village."] = "Recoge el pago de C en el Escondite secreto cerca de Aldea Piroleña."
    C["Enter the Rethban Caverns, reach the first fork and return to Yorus Barleybrew in time. You must not die and release your spirit."] = "Entra en las Cavernas de Rethban, llega hasta la primera bifurcación y regresa junto a Yorus Cebadiz en el tiempo estipulado.\n\nNo debes morir y liberar tu espíritu."
    C["Eye of Mugg"] = "El ojo de Mugg"
    C["Find The Eye of Bhossca inside of the Scarlet Monastery. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."] = "Encuentra el Ojo de Bhossca dentro del Monasterio Escarlata. Después llévalo al escondite secreto de C cerca de la Aldea Piroleña. Debes hacerlo en solitario."
    C["Find The Horn of Xelthos inside of Shadowfang Keep. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."] = "Encuentra el Cuerno de Xelthos dentro del Castillo de Colmillo Oscuro. Después llévalo al escondite secreto de C cerca de la Aldea Piroleña. Debes hacerlo en solitario."
    C["Find the four troll tablets on the coast and in the Vile Reef, and bring back the First, Second, Third and Fourth Troll Legends."] = "Encuentra las 4 tablillas y lleva las leyendas al hermano Nimetz."
    C["Fire Hardened Mail"] = "Armadura de mallas endurecida con fuego"
    C["Furen's Armor"] = "La armadura de Furen"
    C["Gather the materials Furen Longbeard requires, and bring them to him in Stormwind."] = "Reúne los materiales que necesita Furen Barbalarga y llévaselos a Ventormenta."
    C["Heed My Call"] = "Acudid a mi llamada"
    C["Infiltrate Krol'dok Stronghold and return to Krom'rosh with proof of their leader's demise."] = "Infíltrate en el Bastión Krol'dok y lleva a Krom'rosh una prueba de la muerte de su líder."
    C["Kill 15 Kurzen Jungle Fighters."] = "Mata 15 combatientes de la jungla Kurzen.\n\nVuelve a ver al sargento Yohwa en al Asentamiento Rebelde."
    C["Kill Nar'gurk in Krol'dok Stronghold and recover any valuable information."] = "Mata a Nar'gurk en la Bastión Krol'dok y consigue cualquier información que pueda ser valiosa."
    C["Kill Var'Taka in the Drowned City."] = "Mata a Var'Taka en la Ciudad Sumergida."
    C["Kurzen's Mystery"] = "El misterio de Kurzen"
    C["Libram of Focus"] = "El Tratado de Concentración"
    C["Libram of Protection"] = "El Tratado de Protección"
    C["Libram of Rapidity"] = "El Tratado de Prontitud"
    C["Magics of the Drowned City"] = "La magia de la Ciudad Sumergida"
    C["Make rubbings of the four Tablets of I'lalai in the Drowned City."] = "Usa el pellejo y el carbón para crear calcos de las tablillas de la Ciudad Sumergida."
    C["Old Fire-Eye"] = "Viejo Ojofuego"
    C["Ott's Masterwork"] = "Obra maestra de Ott"
    C["Recover an Ancient Gurubashi Idol from the Drowned City."] = "Recupera un antiguo ídolo Gurubashi en la Ciudad Sumergida."
    C["Recover the Tome of Twilight from Krol'dok Stronghold."] = "Recupera el Escrito del Crepúsculo en el Bastión Krol'dok."
    C["Shady Saltseers"] = "Videntesal sospechosos"
    C["Slay Captain Dreadrise and 3 Saltseer Coroners in the Drowned City."] = "Asesina a 3 pesquisadores Videntesal y al capitán Alzapavor en la Ciudad Sumergida."
    C["Speak with Thun'grim"] = "Habla con Thun'grim"
    C["Summon a Twilight's Thrall from a conduit within the Twilight's Shroud and capture it with Amberhall's Soulstone."] = "Invoca un Siervo Crepuscular de un conducto en el Sudario Crepuscular y atrápalo con la piedra de alma de Salámbar."
    C["Take Two With Water"] = "Segunda prueba con el agua"
    C["The Debt"] = "La deuda"
    C["The Demon Forge"] = "La forja demoníaca"
    C["The Drowned City"] = "La Ciudad Sumergida"
    C["The Eye of Bhossca"] = "El ojo de Bhossca"
    C["The Horn of Xelthos"] = "El Cuerno de Xelthos"
    C["The Moonsilver Blade"] = "La hoja de plata lunar"
    C["The Only Good Brinescale..."] = "El único Escamasalada bueno..."
    C["The Platinum Discs"] = "Los discos de platino"
    C["The Rethban Gauntlet"] = "El guantelete de Rethban"
    C["The Saltseer Captain"] = "El capitán Videntesal"
    C["The Second Rebellion"] = "La segunda rebelión"
    C["The Shieldsmith"] = "El forjador de escudos"
    C["The Vile Reef"] = "El Arrecife Mortal"
    C["Tome of Twilight"] = "El escrito del Crepúsculo"
    C["Trial at the Field of Giants"] = "Prueba en Tierra de Gigantes"
    C["Troll Witchery"] = "Brujería trol"
    C["Twilight Mementos"] = "Recuerdos Crepusculares"
    C["Use the Moonsilver Blade to destroy Old-Fire Eye in Silverpine Forest."] = "Usa la hoja de plata lunar para destruir al Viejo Ojofuego en el Bosque de Argénteos."
    C["Use the Twisted Totems to put an end to the quilboar ritual."] = "Utiliza los tótems retorcidos para poner fin al ritual de los jabaespines."
    C["Use the hide and charcoal to make rubbings of the four Tablets of I'lalai in the Drowned City."] = "Usa el pellejo y el carbón para crear calcos de las tablillas de la Ciudad Sumergida."
    C["Vengeance of the Highborne"] = "La venganza del Altonato"
    C["Watch as Ott forges your blade."] = "Observa cómo Ott forja tu hoja."
end
do local C = ns.CONTENT.it
    C["Collect C's payment from the Dead Drop near Pyrewood Village."] = "Ritira il pagamento di C al Punto di consegna segreto vicino a Boscovespro."
    C["Find The Eye of Bhossca inside of the Scarlet Monastery. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."] = "Trova l'Occhio di Bhossca nel Monastero Scarlatto. Poi portalo al punto di consegna segreto di C vicino a Boscovespro. Devi portare a termine il lavoro da solo."
    C["Find The Horn of Xelthos inside of Shadowfang Keep. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."] = "Trova il Corno di Xelthos nel Forte di Zannascura. Poi portalo al punto di consegna segreto di C vicino a Boscovespro. Devi portare a termine il lavoro da solo."
    C["The Eye of Bhossca"] = "L'Occhio di Bhossca"
    C["The Horn of Xelthos"] = "Il Corno di Xelthos"
end
do local C = ns.CONTENT.pt
    C["A Moon-Kissed Blade"] = "Uma lâmina beijada pela lua"
    C["A Small Favor"] = "Um favorzinho"
    C["A Token of Vengeance"] = "Um símbolo de vingança"
    C["Ancient Gurubashi Idol"] = "Ídolo Gurubashi ancestral"
    C["Ancient Gurubashi Secrets"] = "Segredos Gurubashi ancestrais"
    C["Bad Medicine"] = "Remédio do mal"
    C["Bring 4 Skullsplitter Fetishes to Brother Nimetz."] = "Leve 4 Fetiches Rachacrânio para o Irmão Nimetz no Acampamento dos Rebeldes."
    C["Bring 7 Jungle Remedies and 1 Venom Fern Extract to Sergeant Yohwa."] = "Traga 7 Remédios da Mata e 1 Extrato de Samambaia Peçonhenta para o Sargento Yohwa no Acampamento dos Rebeldes."
    C["Bring Thun'grim Firegaze 15 Smoky Iron Ingots, 10 Powdered Azurite, 10 Iron Bars and a Vial of Phlogiston."] = "Leve para Thun'grim Olhafogo 15 Lingotes Fumegantes de Ferro, 10 Azuritas Pulverizadas, 10 Barras de Ferro e a Ampola de Flogisto."
    C["Brutal Armor"] = "Armadura brutal"
    C["Brutal Hauberk"] = "Cota brutal"
    C["Collect 10 Voodoo-Infused Artifacts from the Saltseer pirates in the Drowned City."] = "Colete 10 Artefatos Infusos em Vodu de piratas Divinassais na Cidade Afogada."
    C["Collect 15 Cultist Ears from the Twilight's Hammer in Krol'dok Stronghold."] = "Colete 15 Orelhas de Sectário do Martelo do Crepúsculo na Fortaleza de Krol'Dok."
    C["Collect 5 I'lalai Fetishes from the trolls in the Drowned City."] = "Colete 5 Fetiches de I'lalai de trolls da Cidade Afogada."
    C["Collect 8 Twilight Bangles from the Twilight's Hammer in Krol'dok Stronghold."] = "Colete 8 Braceletes de Sectário do Martelo do Crepúsculo na Fortaleza de Krol'Dok."
    C["Collect C's payment from the Dead Drop near Pyrewood Village."] = "Receba o pagamento de C na Encomenda Escondida perto de Aldeia Piro."
    C["Defeat Charlga Razorflank in Razorfen Kraul and collect information on the quilboar's plans."] = "Derrote Charlga Talhaflanco no Urzal dos Tuscos e colete informações sobre os planos dos javatuscos."
    C["Elemental Aid"] = "Auxílio elemental"
    C["Enter the Rethban Caverns, reach the first fork and return to Yorus Barleybrew in time. You must not die and release your spirit."] = "Entre nas Cavernas Retibanas, chegue à primeira bifurcação e volte até Yorus Cervevada no tempo estipulado.\n\nMorrer e libertar o espírito não é permitido."
    C["Eye of Mugg"] = "Olho de Mugg"
    C["Find The Eye of Bhossca inside of the Scarlet Monastery. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."] = "Encontre o Olho de Bhossca no Monastério Escarlate. Depois, leve-o ao esconderijo de C perto de Aldeia Piro. Você deve fazer o serviço sozinho."
    C["Find The Horn of Xelthos inside of Shadowfang Keep. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."] = "Encontre a Trompa de Xelthos dentro da Bastilha da Presa Negra. Depois, leve-a até o esconderijo de C perto do Vilarejo Lenhardente. Você precisa fazer isso sem ajuda."
    C["Find the four troll tablets on the coast and in the Vile Reef, and bring back the First, Second, Third and Fourth Troll Legends."] = "Encontre as 4 tabuletas e leve as lendas para o Irmão Nimetz."
    C["Fire Hardened Mail"] = "Malha endurecida a fogo"
    C["Furen's Armor"] = "A armadura do Furen"
    C["Gather the materials Furen Longbeard requires, and bring them to him in Stormwind."] = "Colete as matérias-primas pedidas por Furen Barbalonga e leve-as para ele em Ventobravo."
    C["Heed My Call"] = "Ouça meu chamado"
    C["Infiltrate Krol'dok Stronghold and return to Krom'rosh with proof of their leader's demise."] = "Infiltre-se na Fortaleza de Krol'dok e volte a Krom'rosh com a prova da morte do líder deles."
    C["Kill 15 Kurzen Jungle Fighters."] = "Mate 15 Guerrilheiros da Selva de Kurzen.\n\nFale novamente com o Sargento Yohwa no Acampamento dos Rebeldes."
    C["Kill Nar'gurk in Krol'dok Stronghold and recover any valuable information."] = "Mate Nar'gurk na Fortaleza de Krol'Dok e recupera qualquer informação valiosa."
    C["Kill Var'Taka in the Drowned City."] = "Mate Var'taka na Cidade Afogada."
    C["Kurzen's Mystery"] = "O mistério de Kurzen"
    C["Libram of Focus"] = "Incunábulo de Concentração"
    C["Libram of Protection"] = "Incunábulo de Proteção"
    C["Libram of Rapidity"] = "Incunábulo de Rapidez"
    C["Magics of the Drowned City"] = "Magias da Cidade Afogada"
    C["Make rubbings of the four Tablets of I'lalai in the Drowned City."] = "Use pelego e carvão para criar decalques das tabuletas encontradas na Cidade Afogada."
    C["Old Fire-Eye"] = "Velho Olho-de-fogo"
    C["Recover an Ancient Gurubashi Idol from the Drowned City."] = "Recupere um Ídolo Gurubashi Ancestral na Cidade Afogada."
    C["Recover the Tome of Twilight from Krol'dok Stronghold."] = "Recupere o Tomo do Crepúsculo da Fortaleza de Krol'Dok."
    C["Shady Saltseers"] = "Divinassais escusos"
    C["Slay Captain Dreadrise and 3 Saltseer Coroners in the Drowned City."] = "Mate 3 Legistas Divinassais e o Capitão Pavoral na Cidade Afogada."
    C["Speak with Thun'grim"] = "Fale com Thun'grim"
    C["Summon a Twilight's Thrall from a conduit within the Twilight's Shroud and capture it with Amberhall's Soulstone."] = "Evoque um Servo do Crepúsculo com um conduíte dentro da Mortalha do Crepúsculo e capture-o com a Pedra da Alma de Larambar."
    C["Take Two With Water"] = "Tabuletas afogadas"
    C["The Demon Forge"] = "A forja demoníaca"
    C["The Drowned City"] = "A Cidade Afogada"
    C["The Eye of Bhossca"] = "O Olho de Bhossca"
    C["The Gurubashi Legends of Old"] = "As lendas antigas dos Gurubashi"
    C["The Horn of Xelthos"] = "A Trompa de Xelthos"
    C["The Only Good Brinescale..."] = "Escamoura boa é Escamoura..."
    C["The Platinum Discs"] = "Os discos de platina"
    C["The Rethban Gauntlet"] = "Desafio da Retibana"
    C["The Saltseer Captain"] = "O capitão dos Divinassais"
    C["The Second Rebellion"] = "A segunda rebelião"
    C["The Shieldsmith"] = "O fabricante de escudos"
    C["The Vile Reef"] = "O Arrecife Torpe"
    C["Tome of Twilight"] = "Tomo do Crepúsculo"
    C["Trial at the Field of Giants"] = "Provação no Campo dos Gigantes"
    C["Troll Witchery"] = "Bruxaria trólica"
    C["Twilight Mementos"] = "Lembranças do Crepúsculo"
    C["Use the Moonsilver Blade to destroy Old-Fire Eye in Silverpine Forest."] = "Use a Lâmina de Prataluna para eliminar o Velho Olho-de-fogo na Floresta de Pinhaprata."
    C["Use the Twisted Totems to put an end to the quilboar ritual."] = "Use os Totens Deturpados para pôr um fim ao ritual javatusco."
    C["Use the hide and charcoal to make a rubbing of the Third Troll Legend tablet."] = "Use pelego e carvão para criar um decalque da tabuleta da Terceira Lenda Troll."
    C["Use the hide and charcoal to make rubbings of the four Tablets of I'lalai in the Drowned City."] = "Use pelego e carvão para criar decalques das tabuletas encontradas na Cidade Afogada."
    C["Vengeance of the Highborne"] = "A vingança dos altaneiros"
end
do local C = ns.CONTENT.ru
    C["A Moon-Kissed Blade"] = "Клинок лунного поцелуя"
    C["A Small Favor"] = "Небольшая услуга"
    C["A Tale Spun Around the Fire"] = "История у огня"
    C["A Token of Vengeance"] = "Символ возмездия"
    C["An Underrated Talent"] = "Недооцененный талант"
    C["Ancient Gurubashi Idol"] = "Идол древней империи Гурубаши"
    C["Ancient Gurubashi Secrets"] = "Тайны древней империи Гурубаши"
    C["Bad Medicine"] = "Дурное лекарство"
    C["Bring 4 Skullsplitter Fetishes to Brother Nimetz."] = "Принесите 4 фетиша троллей из племени Дробителей Черепов брату Нимезу в лагерь Повстанцев."
    C["Bring 7 Jungle Remedies and 1 Venom Fern Extract to Sergeant Yohwa."] = "Принесите сержанту Йохве из Лагеря повстанцев 7 порций зелья из джунглей и 1 порцию экстракта ядовитого папоротника."
    C["Bring Me His Head"] = "Принеси мне его голову"
    C["Bring Ott's Masterwork to Trevan Rol in Silverpine Forest."] = "Принесите шедевр Отта Тревану Ролу в Серебряный бор."
    C["Bring Thun'grim Firegaze 15 Smoky Iron Ingots, 10 Powdered Azurite, 10 Iron Bars and a Vial of Phlogiston."] = "Принесите Тун'гриму Огневзору 15 закопченных железных слитков, 10 мер толченого азурита, 10 железных слитков и сосуд флогистона."
    C["Brutal Armor"] = "Доспехи Жестокости"
    C["Brutal Hauberk"] = "Хауберк Жестокости"
    C["Collect 10 Voodoo-Infused Artifacts from the Saltseer pirates in the Drowned City."] = "Добудьте 10 |4заряженный вуду артефакт:заряженных вуду артефакта:заряженных вуду артефактов; у пиратов из шайки Солевидцев в затонувшем городе."
    C["Collect 15 Cultist Ears from the Twilight's Hammer in Krol'dok Stronghold."] = "Добудьте 15 |4ухо:уха:ушей; сектантов Сумеречного Молота в крепости Крол'док."
    C["Collect 5 I'lalai Fetishes from the trolls in the Drowned City."] = "Соберите 5 |4и'лалайский фетиш:и'лалайских фетиша:и'лалайских фетишей; у троллей в затонувшем городе."
    C["Collect 5 Twisted Fire Totems, 5 Twisted Earth Totems, 5 Twisted Air Totems and 5 Twisted Water Totems and turn them in to Prate Cloudseer in Thousand Needles."] = "Соберите 5 |4изуродованный тотем:изуродованных тотема:изуродованных тотемов; огня, 5 |4изуродованный тотем:изуродованных тотема:изуродованных тотемов; земли, 5 |4изуродованный тотем:изуродованных тотема:изуродованных тотемов; воздуха и 5 |4изуродованный тотем:изуродованных тотема:изуродованных тотемов; воды для Пратты Заклинательницы Туч в Тысяче Игл."
    C["Collect 5 Twisted Fire Totems, 5 Twisted Earth Totems, 5 Twisted Air Totems and 5 Twisted Water Totems for Veyric Thunderhame in Arathi Highlands."] = "Соберите 5 |4изуродованный тотем:изуродованных тотема:изуродованных тотемов; огня, 5 |4изуродованный тотем:изуродованных тотема:изуродованных тотемов; земли, 5 |4изуродованный тотем:изуродованных тотема:изуродованных тотемов; воздуха и 5 |4изуродованный тотем:изуродованных тотема:изуродованных тотемов; воды для Вейрика Громоцепа на нагорье Арати."
    C["Collect 8 Twilight Bangles from the Twilight's Hammer in Krol'dok Stronghold."] = "Добудьте 8 |4браслет:браслета:браслетов; сектантов Сумеречного Молота в крепости Крол'док."
    C["Collect C's payment from the Dead Drop near Pyrewood Village."] = "Журнал"
    C["Defeat Charlga Razorflank in Razorfen Kraul and collect information on the quilboar's plans."] = "Победите Чарглу Остробок в лабиринтах Иглошкурых и выясните, что замышляют свинобразы."
    C["Defeat Overlord Kilgar within the Twilight's Shroud and bring his head to Da'grosh."] = "Победите властителя Килгара в Сумеречном покрове и принесите его голову Да'грошу."
    C["Elemental Aid"] = "Стихийная помощь"
    C["Enemies in the Water"] = "Враг в воде"
    C["Enter the Rethban Caverns, reach the first fork and return to Yorus Barleybrew in time. You must not die and release your spirit."] = "Войдите в пещеры Ретбана, доберитесь до первой развилки и вернитесь к Йорусу Ячменовару за отведенное время.\n\nВы не должны умирать и освобождать свой дух."
    C["Explore just west of the Vile Reef and find the cavern entrance, then report back to Kin'weelay."] = "Исследуйте Коварный риф и найдите вход в пещеру."
    C["Eye of Mugg"] = "Глаз Магга"
    C["Eyes on the Sky"] = "Все глаза на небо"
    C["Find The Eye of Bhossca inside of the Scarlet Monastery. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."] = "Найдите глаз Бхосски в монастыре Алого ордена и доставьте его в тайник С у деревни Погребальных Костров. Идите на задание только в одиночку."
    C["Find The Horn of Xelthos inside of Shadowfang Keep. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."] = "Найдите рог Кселтоса в крепости Темного Клыка и верните его в тайник С у деревни Погребальных Костров. Идите на задание только в одиночку."
    C["Find the four troll tablets on the coast and in the Vile Reef, and bring back the First, Second, Third and Fourth Troll Legends."] = "Найдите 4 таблички, перерисуйте их и принесите их брату Нимезу."
    C["Fire Hardened Mail"] = "Закаленный доспех"
    C["Furen's Armor"] = "Доспехи Фьюрена"
    C["Gather 10 Brinescale Tridents from Brinescale Skirmishers."] = "Соберите 10 |4солоноводный трезубец:солоноводных трезубца:солоноводных трезубцев; у застрельщиков из клана Соленой Чешуи."
    C["Gather the materials Furen Longbeard requires, and bring them to him in Stormwind."] = "Соберите все необходимые материалы для Фьюрена Длинноборода и отнесите их в Штормград."
    C["Heed My Call"] = "Услышь мой зов"
    C["Infiltrate Krol'dok Stronghold and return to Commander Brant with proof of their leader's demise."] = "Проникните в крепость Крол'док, а затем вернитесь к командиру Бранту с доказательствами смерти вражеского лидера."
    C["Infiltrate Krol'dok Stronghold and return to Krom'rosh with proof of their leader's demise."] = "Проникните в крепость Крол'док, а затем вернитесь к Кром'рошу с доказательствами смерти вражеского лидера."
    C["Kill 15 Kurzen Jungle Fighters."] = "Убейте 15 партизан Курцена.\n\nВернитесь к сержанту Йохве в Лагерь повстанцев."
    C["Kill Nar'gurk in Krol'dok Stronghold and recover any valuable information."] = "Убейте Нар'гурка в крепости Крол'док и соберите всю ценную информацию."
    C["Kill Var'Taka in the Drowned City."] = "Убейте Вар'таку в затонувшем городе."
    C["Krol'dok Moulding"] = "Крол'докская форма"
    C["Kurzen's Mystery"] = "Тайна Курцена"
    C["Libram of Focus"] = "\"Манускрипт Средоточия\""
    C["Libram of Protection"] = "\"Манускрипт Защиты"
    C["Libram of Rapidity"] = "\"Манускрипт Скорости\""
    C["Locating the Lost City"] = "В поисках затерянного города"
    C["Magics of the Drowned City"] = "Магия затонувшего города"
    C["Make rubbings of the four Tablets of I'lalai in the Drowned City."] = "С помощью шкуры и угля сделайте оттиски табличек, найденных в затонувшем городе."
    C["Old Fire-Eye"] = "Старый Огнеглаз"
    C["Ott's Masterwork"] = "Искусная работа Отта"
    C["Recover an Ancient Gurubashi Idol from the Drowned City."] = "Достаньте идола древней империи Гурубаши из затонувшего города."
    C["Recover the Tome of Twilight from Krol'dok Stronghold."] = "Добудьте фолиант Сумерек в крепости Крол'док."
    C["Shady Saltseers"] = "Негодные Солевидцы"
    C["Slay Captain Dreadrise and 3 Saltseer Coroners in the Drowned City."] = "Убейте 3 коронеров из шайки Солевидцев и капитана Морожада в затонувшем городе."
    C["Speak with Thun'grim"] = "Разговор с Тун'гримом"
    C["Storm, Earth, and Fire"] = "Буря, земля и огонь"
    C["Summon a Twilight's Thrall from a conduit within the Twilight's Shroud and capture it with Amberhall's Soulstone."] = "Призовите сумеречного раба с помощью проводника в Сумеречном покрове и плените его при содействии камня души Амберхолл."
    C["Take Two With Water"] = "Принимать по две за раз"
    C["The Debt"] = "Долг"
    C["The Demon Forge"] = "Демонова кузня"
    C["The Drowned City"] = "Затонувший город"
    C["The Eye of Bhossca"] = "Глаз Бхосски"
    C["The Gurubashi Legends of Old"] = "Древние легенды Гурубаши"
    C["The Horn of Xelthos"] = "Рог Кселтоса"
    C["The Moonsilver Blade"] = "Клинок лунного света"
    C["The Only Good Brinescale..."] = "Единственная хорошая Соленая Чешуя"
    C["The Platinum Discs"] = "Платиновые диски"
    C["The Rethban Gauntlet"] = "Ретбанский вызов"
    C["The Saltseer Captain"] = "Капитан Солевидцев"
    C["The Second Rebellion"] = "Второе восстание"
    C["The Shieldsmith"] = "Щитник"
    C["The Tempest's Weapons"] = "Оружие урагана"
    C["The Vile Reef"] = "Коварный риф"
    C["Tome of Twilight"] = "Фолиант Сумерек"
    C["Trial at the Field of Giants"] = "Испытание на Полях Великанов"
    C["Troll Witchery"] = "Тролльское колдовство"
    C["Twilight Mementos"] = "Сумеречные реликвии"
    C["Use the Moonsilver Blade to destroy Old-Fire Eye in Silverpine Forest."] = "Уничтожьте Старого Огнеглаза клинком лунного света в Серебряном бору."
    C["Use the Twisted Totems to put an end to the quilboar ritual."] = "Положите конец ритуалу иглогривов с помощью изуродованных тотемов."
    C["Use the hide and charcoal to make a rubbing of the Third Troll Legend tablet."] = "С помощью шкуры и угля сделайте оттиск таблички с третьим преданием троллей."
    C["Use the hide and charcoal to make rubbings of the four Tablets of I'lalai in the Drowned City."] = "С помощью шкуры и угля сделайте оттиски табличек, найденных в затонувшем городе."
    C["Vengeance of the Highborne"] = "Отмщение высокорожденного"
    C["Watch as Ott forges your blade."] = "Понаблюдайте. как Отт кует ваш клинок."
end
do local C = ns.CONTENT.ko
    C["A Moon-Kissed Blade"] = "달빛이 입 맞춘 칼날"
    C["An Underrated Talent"] = "저평가된 재능"
    C["Bad Medicine"] = "나쁜 약"
    C["Bring 4 Skullsplitter Fetishes to Brother Nimetz."] = "반란군 야영지에 있는 수사 니메츠에게 백골가루부족 우상 4개를 가져가야 합니다."
    C["Bring 7 Jungle Remedies and 1 Venom Fern Extract to Sergeant Yohwa."] = "반란군 야영지에 있는 하사관 요화에게 밀림 치료제 7개와 독고사리 즙 1개를 가져가야 합니다."
    C["Bring Ott's Masterwork to Trevan Rol in Silverpine Forest."] = "오트의 걸작을 은빛소나무 숲에 있는 트레반 롤에게 가져가야 합니다."
    C["Bring Thun'grim Firegaze 15 Smoky Iron Ingots, 10 Powdered Azurite, 10 Iron Bars and a Vial of Phlogiston."] = "툰그림 파이어게이즈에게 연기나는 철제 주괴 15개, 아주라이트 가루 10개, 철 주괴 10개, 연소 약병 1개를 가져가야 합니다."
    C["Brutal Armor"] = "투사의 방어구"
    C["Brutal Hauberk"] = "투사 갑옷"
    C["Collect 10 Voodoo-Infused Artifacts from the Saltseer pirates in the Drowned City."] = "가라앉은 도시의 소금선견자 해적에게서 부두가 깃든 유물 10개를 수집해야 합니다."
    C["Collect 5 Twisted Fire Totems, 5 Twisted Earth Totems, 5 Twisted Air Totems and 5 Twisted Water Totems and turn them in to Prate Cloudseer in Thousand Needles."] = "뒤틀린 불의 토템 5개, 뒤틀린 대지 토템 5개, 뒤틀린 바람 토템 5개, 뒤틀린 물 토템 5개를 모아 버섯구름 봉우리에 있는 프레이트 클라우드시어에게 전달해야 합니다."
    C["Collect 5 Twisted Fire Totems, 5 Twisted Earth Totems, 5 Twisted Air Totems and 5 Twisted Water Totems for Veyric Thunderhame in Arathi Highlands."] = "뒤틀린 불의 토템 5개, 뒤틀린 대지 토템 5개, 뒤틀린 바람 토템 5개, 뒤틀린 물 토템 5개를 모아 아라시 고원에 있는 베이릭 썬더헤임에게 전달해야 합니다."
    C["Collect C's payment from the Dead Drop near Pyrewood Village."] = "장작나무 마을 근처의 비밀 접선 지점에서 C의 보수를 받으십시오."
    C["Defeat Charlga Razorflank in Razorfen Kraul and collect information on the quilboar's plans."] = "가시덩굴 우리에서 서슬깃 차를가를 처치하고 가시멧돼지의 계획에 관한 정보를 수집해야 합니다."
    C["Elemental Aid"] = "정기의 도움"
    C["Enter the Rethban Caverns, reach the first fork and return to Yorus Barleybrew in time. You must not die and release your spirit."] = "주어진 시간 내에 레스밴 동굴의 첫번째 분기점까지 들어갔다가 요루스 발리브루에게로 되돌아와야 합니다.\n\n죽어서 영혼이 빠져나가서는 안 됩니다."
    C["Find The Eye of Bhossca inside of the Scarlet Monastery. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."] = "붉은십자군 수도원에서 보스카의 눈을 찾으십시오. 그런 다음 장작나무 마을 근처에 있는 C의 비밀 접선 지점으로 가져가야 합니다. 이 일은 혼자서 해내야 합니다."
    C["Find The Horn of Xelthos inside of Shadowfang Keep. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."] = "그림자송곳니 성채에서 젤토스의 뿔을 찾아야 합니다. 그런 다음 장작나무 마을 주변에 있는 C의 비밀 점선 지점에 반환해야 합니다. 이 일은 혼자서 완료해야 합니다."
    C["Find the four troll tablets on the coast and in the Vile Reef, and bring back the First, Second, Third and Fourth Troll Legends."] = "4개의 서판을 찾아 거기에 기록된 전설을 수사 니메츠에게 가져가야 합니다."
    C["Fire Hardened Mail"] = "불에 달궈 만든 갑옷"
    C["Furen's Armor"] = "푸렌의 갑옷"
    C["Gather the materials Furen Longbeard requires, and bring them to him in Stormwind."] = "스톰윈드에 있는 푸렌 롱비어드에게 그가 필요로 하는 재료들을 모아서 가져가야 합니다."
    C["Heed My Call"] = "내 부름에 응하라"
    C["Kill 15 Kurzen Jungle Fighters."] = "쿠르젠 밀림전사 15명을 처치해야 합니다.\n\n반란군 야영지에 있는 하사관 요화에게 돌아가십시오."
    C["Kurzen's Mystery"] = "쿠르젠의 비밀"
    C["Libram of Focus"] = "집중의 성서"
    C["Libram of Protection"] = "보호의 성서"
    C["Libram of Rapidity"] = "신속의 성서"
    C["Old Fire-Eye"] = "늙은 불꽃눈"
    C["Ott's Masterwork"] = "오트의 걸작"
    C["Shady Saltseers"] = "수상쩍은 소금선견자"
    C["Slay Captain Dreadrise and 3 Saltseer Coroners in the Drowned City."] = "가라앉은 도시에서 소금선견자 검시관 3명과 대장 드레드라이즈를 처치해야 합니다."
    C["Speak with Thun'grim"] = "툰그림과의 대화"
    C["Storm, Earth, and Fire"] = "폭풍과 대지와 불"
    C["The Debt"] = "빚"
    C["The Demon Forge"] = "악마의 룬"
    C["The Eye of Bhossca"] = "보스카의 눈"
    C["The Horn of Xelthos"] = "젤토스의 뿔"
    C["The Moonsilver Blade"] = "달빛은 칼날"
    C["The Platinum Discs"] = "백금 원반"
    C["The Rethban Gauntlet"] = "레스밴 도전"
    C["The Saltseer Captain"] = "소금선견자 대장"
    C["The Second Rebellion"] = "제 2의 반란"
    C["The Shieldsmith"] = "방패 상인"
    C["The Vile Reef"] = "썩은내 산호초"
    C["Trial at the Field of Giants"] = "거인의 들판에서의 시험"
    C["Troll Witchery"] = "트롤의 마법"
    C["Use the Moonsilver Blade to destroy Old-Fire Eye in Silverpine Forest."] = "은빛소나무 숲에서 달빛은 칼날을 사용해 늙은 불꽃눈을 처단해야 합니다."
    C["Use the Twisted Totems to put an end to the quilboar ritual."] = "뒤틀린 토템을 사용해 가시멧돼지 의식을 막아야 합니다."
    C["Watch as Ott forges your blade."] = "오트가 당신의 검을 벼리는 모습을 지켜봐야 합니다."
end
do local C = ns.CONTENT.zh
    C["A Moon-Kissed Blade"] = "月吻之刃"
    C["Ancient Gurubashi Idol"] = "上古古拉巴什神像"
    C["Bad Medicine"] = "库尔森的药物"
    C["Bring 4 Skullsplitter Fetishes to Brother Nimetz."] = "给叛军营地的尼麦兹修士带回4只劈颅巨魔的神像。"
    C["Bring 7 Jungle Remedies and 1 Venom Fern Extract to Sergeant Yohwa."] = "给反抗军营地里的尤瓦中士带回7份密林药剂和1份毒草汁液。"
    C["Bring Thun'grim Firegaze 15 Smoky Iron Ingots, 10 Powdered Azurite, 10 Iron Bars and a Vial of Phlogiston."] = "为索恩格瑞姆收集15根烟雾铁锭、10份蓝铜粉、10块铁锭和1瓶燃素。"
    C["Brutal Armor"] = "野蛮护甲"
    C["Brutal Hauberk"] = "野蛮锁甲"
    C["Collect 5 Twisted Fire Totems, 5 Twisted Earth Totems, 5 Twisted Air Totems and 5 Twisted Water Totems and turn them in to Prate Cloudseer in Thousand Needles."] = "为千针石林的普拉特·白云收集5个扭曲的火焰图腾、5个扭曲的大地图腾、5个扭曲的空气图腾和5个扭曲的水之图腾。"
    C["Collect 5 Twisted Fire Totems, 5 Twisted Earth Totems, 5 Twisted Air Totems and 5 Twisted Water Totems for Veyric Thunderhame in Arathi Highlands."] = "为阿拉希高地的维里克·雷锤收集5个扭曲的火焰图腾、5个扭曲的大地图腾、5个扭曲的空气图腾和5个扭曲的水之图腾。"
    C["Collect C's payment from the Dead Drop near Pyrewood Village."] = "到焚木村附近的秘密投放点领取C的报酬。"
    C["Enter the Rethban Caverns, reach the first fork and return to Yorus Barleybrew in time. You must not die and release your spirit."] = "进入瑞斯班洞穴，然后在规定的时间内回到犹鲁斯·麦酒那里。\n\n在整个过程中你都不能死掉或者释放灵魂，否则任务就宣告失败。"
    C["Find The Eye of Bhossca inside of the Scarlet Monastery. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."] = "在血色修道院中找到波斯卡之眼，然后把它送到焚木村附近C的秘密投放点。你必须独自完成这项工作。"
    C["Find The Horn of Xelthos inside of Shadowfang Keep. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."] = "找到影牙城堡内的谢尔索斯号角。然后，将它送回至焚木村附近C的秘密投放点。你必须独自完成这项任务。"
    C["Find the four troll tablets on the coast and in the Vile Reef, and bring back the First, Second, Third and Fourth Troll Legends."] = "找到4块石板并将上面的内容带回去交给尼麦兹修士。"
    C["Fire Hardened Mail"] = "弗伦的铠甲"
    C["Furen's Armor"] = "弗伦的铠甲"
    C["Gather the materials Furen Longbeard requires, and bring them to him in Stormwind."] = "收集必需的材料，将它们交给暴风城的弗伦·长须。"
    C["Kill 15 Kurzen Jungle Fighters."] = "杀死15名库尔森丛林战士，然后向反抗军营地的尤瓦中士复命。"
    C["Kurzen's Mystery"] = "库尔森的秘密"
    C["Libram of Focus"] = "专注圣典"
    C["Libram of Protection"] = "防护圣典"
    C["Libram of Rapidity"] = "急速圣典"
    C["Old Fire-Eye"] = "老火眼"
    C["Recover an Ancient Gurubashi Idol from the Drowned City."] = "从沉没之城找回一个远古古拉巴什神像。"
    C["Speak with Thun'grim"] = "和索恩格瑞姆交谈"
    C["Storm, Earth, and Fire"] = "风暴、大地与火焰"
    C["The Demon Forge"] = "恶魔熔炉"
    C["The Eye of Bhossca"] = "波斯卡之眼"
    C["The Horn of Xelthos"] = "谢尔索斯号角"
    C["The Platinum Discs"] = "白金圆盘"
    C["The Rethban Gauntlet"] = "往返瑞斯班洞穴"
    C["The Second Rebellion"] = "以彼之道还施彼身"
    C["The Shieldsmith"] = "铸盾师"
    C["The Vile Reef"] = "暗礁海"
    C["Trial at the Field of Giants"] = "巨人旷野的试炼"
    C["Troll Witchery"] = "巨魔巫术"
    C["Use the Moonsilver Blade to destroy Old-Fire Eye in Silverpine Forest."] = "使用月银之刃在银松森林消灭老火眼。"
end
do local C = ns.CONTENT.tw
    C["A Moon-Kissed Blade"] = "月吻之刃"
    C["An Underrated Talent"] = "被低估的奇才"
    C["Ancient Gurubashi Idol"] = "遠古古拉巴什塑像"
    C["Bad Medicine"] = "庫爾森的藥物"
    C["Brutal Armor"] = "野蠻護甲"
    C["Brutal Hauberk"] = "野蠻鎖甲"
    C["Collect C's payment from the Dead Drop near Pyrewood Village."] = "到焚木村附近的密件領取C的報酬。"
    C["Find The Eye of Bhossca inside of the Scarlet Monastery. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."] = "在血色修道院中找到伯絲卡之眼，然後把它送到焚木村附近C的密件。你必須獨自完成這項工作。"
    C["Find The Horn of Xelthos inside of Shadowfang Keep. Then, return it to C's dead drop near Pyrewood Village. You must complete the job alone."] = "在影牙城堡中找到澤索司號角，然後把它送到焚木村附近C的密件。你必須獨自完成這項工作。"
    C["Fire Hardened Mail"] = "弗倫的鎧甲"
    C["Furen's Armor"] = "弗倫的鎧甲"
    C["Kurzen's Mystery"] = "庫爾森的秘密"
    C["Libram of Focus"] = "專注聖典"
    C["Libram of Protection"] = "防護聖典"
    C["Libram of Rapidity"] = "疾速聖契"
    C["Old Fire-Eye"] = "老火眼"
    C["Ott's Masterwork"] = "奧特的傑作"
    C["Speak with Thun'grim"] = "和索恩格瑞姆交談"
    C["Storm, Earth, and Fire"] = "風暴、大地和火焰"
    C["The Debt"] = "有債有還"
    C["The Demon Forge"] = "惡魔熔爐"
    C["The Eye of Bhossca"] = "伯絲卡之眼"
    C["The Horn of Xelthos"] = "澤索司號角"
    C["The Moonsilver Blade"] = "月銀刃"
    C["The Platinum Discs"] = "白金圓盤"
    C["The Rethban Gauntlet"] = "往返瑞斯班洞穴"
    C["The Second Rebellion"] = "以彼之道還施彼身"
    C["The Shieldsmith"] = "鑄盾師"
    C["The Vile Reef"] = "暗礁海"
    C["Trial at the Field of Giants"] = "巨人曠野的試煉"
    C["Troll Witchery"] = "食人妖巫術"
end
