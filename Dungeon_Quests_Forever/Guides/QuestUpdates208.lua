local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, D = ns.Accept, ns.TurnIn, ns.Do

-- ===================================================================
-- Quests added by DungeonJournal 2.0.8 (Nov 2026), merged into the guides
-- by ns:AddGuideSteps (Core.lua). Patch steps get uids from their quest
-- (type:quest:n), so they can go anywhere without moving saved checks.
-- ===================================================================

N.q8_katherine = { id = 0, name = "Katherine the Pure", map = 1453, x = 48.5, y = 49.1, forever = true } -- Cathedral of Light
N.q8_aeonas    = { id = 0, name = "Aeonas" } -- rear chamber of the Cathedral, then the Cathedral of Light
N.q8_delgren   = { id = 0, name = "Delgren the Purifier", map = 1440, x = 26.2, y = 38.7, forever = true } -- Astranaar
N.q8_ursula    = { id = 0, name = "Ursula Deline", map = 1453, x = 38.4, y = 84.5, forever = true } -- Mage Quarter (converted from Classic)
N.q8_orb       = { id = 0, name = "Strange Orb", map = 1439, x = 56.2, y = 26.4, forever = true }
N.q8_spear     = { id = 0, name = "Spear of Mannoroth", map = 1440, x = 89.0, y = 77.0, forever = true }
N.q8_hammer    = { id = 0, name = "Broken Warhammer", map = 1443, x = 52.7, y = 84.8, forever = true }

-- Krol'dok (Horde): Clubtoe and the Twilight Brute in the Sunnyglade cave
N.q8_clubtoe = { id = 0, name = "Clubtoe", map = 2548, x = 50.0, y = 47.0, forever = true }
N.q8_brute   = { id = 0, name = "Twilight Brute", map = 2548, x = 49.2, y = 46.7, forever = true }

-- Blackmaw Hold: Korsa, Graal, Gorn One Eye; Rageroar's spot (Ursolan)
N.q8_korsa = { id = 0, name = "Korsa", map = 1447, x = 63.0, y = 23.3, forever = true }
N.q8_graal = { id = 0, name = "Graal", map = 1447, x = 65.9, y = 14.4, forever = true }
N.q8_gorn  = { id = 0, name = "Gorn One Eye", map = 1448, x = 65.2, y = 2.6, forever = true }
if N.ql_gatekeeper_rageroar and not N.ql_gatekeeper_rageroar.map then
    N.ql_gatekeeper_rageroar.map, N.ql_gatekeeper_rageroar.x, N.ql_gatekeeper_rageroar.y = 1447, 42.4, 20.2
    N.ql_gatekeeper_rageroar.forever = true
end

-- -------------------------------------------------------------------
-- Scarlet Monastery: Cathedral - Alliance paladin chain "A Brother In Need"
-- -------------------------------------------------------------------
local function P(extra)
    local t = { faction = "Alliance", class = "PALADIN" }
    for k, v in pairs(extra or {}) do t[k] = v end
    return t
end

ns:AddGuideSteps("SMCATH", function() return {
    titles = {
        [78088] = L("A Strange Artifact", "A Strange Artifact"),
        [78089] = L("Advice From Stormwind", "Advice From Stormwind"),
        [78090] = L("A Second Opinion", "A Second Opinion"),
        [78091] = L("Earning Your Salt", "Earning Your Salt"),
        [78092] = L("It Must Be Destroyed", "It Must Be Destroyed"),
        [78093] = L("Return to Delgren", "Return to Delgren"),
        [96438] = L("Battle at the Mannoroc Coven", "Battle at the Mannoroc Coven"),
        [79939] = L("The Broken Hammer", "The Broken Hammer"),
        [79940] = L("A Lost Brother", "A Lost Brother"),
        [79945] = L("Orders from the Grand Crusader", "Orders from the Grand Crusader"),
        [79946] = L("Un frère dans le besoin", "A Brother In Need"),
        [79963] = L("Par la grâce de la Lumière", "By The Light's Grace"),
        [79970] = L("Aeonas le Justifié", "Aeonas the Vindicated"),
    },
    groups = {
        { before = nil, steps = {
            A(79946, "q8_katherine", P()),
            T(79946, "q8_aeonas", P({ text = L("Aeonas, salle du fond de la Cathédrale (dans le donjon). Finissez la discussion de Katherine avant de partir",
                "Aeonas, rear chamber of the Cathedral (inside the dungeon). Finish Katherine's talk before you leave") })),
            A(79963, "q8_aeonas", P()),
            D(79963, L("Soigner Aeonas (jusqu'à sa vie pleine)", "Heal Aeonas (to full health)"), P()),
            T(79963, "q8_aeonas", P()),
            A(79970, "q8_aeonas", P()),
            T(79970, "q8_aeonas", P({ text = L("Aeonas, Cathédrale de la Lumière (Hurlevent)", "Aeonas, Cathedral of Light (Stormwind)"),
                map = 1453, x = 48.5, y = 49.1 })),
        } },
        -- the quests that open A Brother In Need (from level 35)
        { before = 79946, steps = {
            A(78088, "q8_orb", P({ text = L("Orbe étrange, Sombrivage", "Strange Orb, Darkshore") })),
            T(78088, "q8_delgren", P()),
            A(78089, "q8_delgren", P()),
            T(78089, "q8_katherine", P()),
            A(78090, "q8_katherine", P()),
            T(78090, "q8_ursula", P({ text = L("Ursula Deline, quartier des Mages (Hurlevent)", "Ursula Deline, Mage Quarter (Stormwind)") })),
            A(78091, "q8_ursula", P()),
            D(78091, L("Récupérer 14 sels d'invocateur sur les orcs Rochenoire des Carmines", "Collect 14 Summoner's Salt from Blackrock orcs in Redridge"),
                P({ map = 1433 })),
            T(78091, "q8_ursula", P()),
            A(78092, "q8_ursula", P()),
            D(78092, L("Récupérer 12 Motes de Mannoroth dans le canyon de la Chute-des-Démons, puis utiliser la Lance de Mannoroth",
                "Collect 12 Motes of Mannoroth in Demon Fall Canyon, then use them at the Spear of Mannoroth"), P({ map = 1440, x = 89.0, y = 77.0 })),
            T(78092, "q8_spear", P()),
            A(78093, "q8_spear", P({ text = L("Orbe brisé, à la Lance de Mannoroth", "Shattered Orb, at the Spear of Mannoroth") })),
            T(78093, "q8_delgren", P()),
            A(96438, "q8_katherine", P()),
            T(96438, "q8_hammer", P({ text = L("Marteau de guerre brisé, Désolace", "Broken Warhammer, Desolace") })),
            A(79939, "q8_hammer", P()),
            D(79939, L("Prendre la lettre déchirée sur un invocateur de la Lame ardente (Désolace)", "Loot the Torn Letter from a Burning Blade Summoner (Desolace)"),
                P({ map = 1443, x = 52.7, y = 84.8 })),
            T(79939, "q8_katherine", P()),
            A(79940, "q8_katherine", P()),
            T(79940, "q8_katherine", P()),
            A(79945, "q8_katherine", P()),
            D(79945, L("Port de Menethil : prendre le bateau du maître pêcheur vers la cabane d'Aeonas au sud, fouiller le croisé écarlate, tuer l'assassin (élite 40), utiliser les ordres",
                "Menethil Harbor: take the fishing trainer's boat south to Aeonas's hut, inspect the fallen Scarlet Crusader, kill the assassin (level 40 elite), use the orders"),
                P({ map = 1437 })),
            T(79945, "q8_katherine", P()),
        } },
    },
} end)

-- -------------------------------------------------------------------
-- Krol'dok Stronghold - Horde "Eye of Mugg" chain, the missing quests
-- -------------------------------------------------------------------
local function H(extra)
    local t = { faction = "Horde" }
    for k, v in pairs(extra or {}) do t[k] = v end
    return t
end

ns:AddGuideSteps("KROLDOK", function() return {
    titles = {
        [93786] = L("A Message in Blood", "A Message in Blood"),
        [93787] = L("Food for the Taking", "Food for the Taking"),
        [94680] = L("Twilight Missives", "Twilight Missives"),
        [94727] = L("Digging for Answers", "Digging for Answers"),
        [95417] = L("The Purple Ones", "The Purple Ones"),
        [95601] = L("The Purple Ones", "The Purple Ones"),
        [95602] = L("Sickening Lights", "Sickening Lights"),
        [95427] = L("Twilight No More!", "Twilight No More!"),
        [95418] = L("Spread the Word", "Spread the Word"),
        [95420] = L("Land of Giants", "Land of Giants"),
        [95424] = L("Might Makes Right", "Might Makes Right"),
        [95425] = L("Unworthy Champion", "Unworthy Champion"),
        [95431] = L("Rumblings of Discontent", "Rumblings of Discontent"),
    },
    groups = {
        -- Krom'rosh's two first quests, done side by side
        { before = 94483, steps = {
            A(93786, "ql_krom_rosh", H()),
            A(93787, "ql_krom_rosh", H()),
            D(93786, L("Tuer 12 ouvriers agricoles de Prés-du-Ruisseau", "Slay 12 Meadowsbrook Farmhands"), H()),
            D(93787, L("Voler 6 sacoches de fourrage à la ferme de Prés-du-Ruisseau", "Steal 6 Feed Satchels from the Meadowsbrook farm"), H()),
            T(93786, "ql_krom_rosh", H()),
            T(93787, "ql_krom_rosh", H()),
        } },
        -- Tran'gul gives Twilight Missives with Encroaching Twilight
        { before = 94672, steps = {
            A(94680, "ql_tran_gul", H()),
        } },
        { before = 95428, steps = {
            D(94680, L("Prendre 3 missives sur les ombremanciens du Crépuscule à Clairsoleil", "Retrieve 3 Twilight Missives from Twilight Shadowmancers in Sunnyglade"), H()),
            T(94680, "ql_tran_gul", H()),
            A(94727, "ql_tran_gul", H()),
            D(94727, L("Convaincre un mineur du Marteau du crépuscule à Clairsoleil de parler", "Convince a Twilight's Hammer miner in Sunnyglade to talk"), H()),
            T(94727, "q8_clubtoe", H({ text = L("Clubtoe, grotte sous Clairsoleil (entrée vers 50, 46)", "Clubtoe, cave under Sunnyglade (entrance near 50, 46)") })),
            A(95417, "q8_clubtoe", H()),
            A(95602, "q8_clubtoe", H()),
            T(95417, "q8_brute", H()),
            A(95601, "q8_brute", H()),
            D(95601, L("Tuer 5 brutes surpuissantes et 10 ritualistes du Crépuscule", "Kill 5 Empowered Brutes and 10 Twilight Ritualists"), H()),
            D(95602, L("Détruire 5 cercles rituels du Crépuscule dans les grottes", "Destroy 5 Twilight Ritual Circles in the caves"), H()),
            T(95601, "q8_clubtoe", H()),
            T(95602, "q8_clubtoe", H()),
            A(95427, "q8_clubtoe", H()),
            D(95427, L("Tuer Chogg'Zac (élite) et prendre la tête de Chogg et la tête de Zac", "Kill Chogg'Zac (elite), loot Chogg's Head and Zac's Head"), H()),
            T(95427, "q8_clubtoe", H()),
            A(95418, "q8_clubtoe", H()),
            T(95418, "ql_tran_gul", H()),
            A(95420, "ql_tran_gul", H()),
            T(95420, "ql_clugfist", H()),
            A(95424, "ql_clugfist", H()),
            A(95425, "ql_clugfist", H()),
            D(95424, L("Tuer 7 cogneurs et 7 mande-flammes du Crépuscule", "Kill 7 Twilight Maulers and 7 Twilight Firecallers"), H()),
            D(95425, L("Prendre Cogne-crâne sur Klunk", "Collect Skullthumper from Klunk"), H({ map = 2548, x = 75.0, y = 27.0 })),
            T(95424, "ql_clugfist", H()),
            T(95425, "ql_clugfist", H()),
        } },
        -- Da'grosh sends you to Crag'rog, who gives Rise Up!
        { before = 95432, steps = {
            A(95431, "ql_da_grosh", H()),
            T(95431, "ql_crag_rog", H()),
        } },
    },
} end)

-- -------------------------------------------------------------------
-- Blackmaw Hold - what opens Blackmaw Reclamation
-- -------------------------------------------------------------------
ns:AddGuideSteps("NOIREG", function() return {
    titles = {
        [86777] = L("Master Feardred", "Master Feardred"),
        [86797] = L("Return to Rageroar", "Return to Rageroar"),
        [86798] = L("Timbermaw Reinforcements", "Timbermaw Reinforcements"),
        [87346] = L("Chieftain Bloodmaw", "Chieftain Bloodmaw"),
        [86814] = L("Blackmaw Counter-Offensive", "Blackmaw Counter-Offensive"),
    },
    groups = {
        { before = 92065, steps = {
            -- any ONE of Korsa's three quests opens Return to Rageroar
            A(86777, "q8_korsa", { doneBy = { 86792, 86796 },
                text = L("Korsa, devant le bastion Legashi : prenez UNE de ses quêtes (Maître Feardred, Thinning Their Forces, ou Later, Satyr auprès de Graal, en cage à 65.9, 14.4)",
                    "Korsa, outside Legashi Stronghold: take ONE of her quests (Master Feardred, Thinning Their Forces, or Later, Satyr from Graal, caged at 65.9, 14.4)") }),
            D(86777, L("Faire la quête choisie : tuer Maître Feardred (amulette), OU 6 Hellraisers, 4 Soulstealers et 2 Blackguards Legashi, OU libérer Graal",
                "Do the quest you took: kill Master Feardred (amulet), OR 6 Legashi Hellraisers, 4 Soulstealers and 2 Blackguards, OR free Graal"),
                { doneBy = { 86792, 86796 }, map = 1447, x = 63.0, y = 23.3 }),
            T(86777, "q8_korsa", { doneBy = { 86792, 86796 } }),
            A(86797, "q8_korsa"),
            T(86797, "ql_gatekeeper_rageroar", { text = L("Gatekeeper Rageroar, Ursolan", "Gatekeeper Rageroar, Ursolan") }),
            A(86798, "ql_gatekeeper_rageroar"),
            T(86798, "q8_gorn", { text = L("Gorn One Eye, Repaire des Grumegueules (Gangrebois)", "Gorn One Eye, Timbermaw Hold (Felwood)") }),
            A(87346, "q8_gorn"),
            D(87346, L("Tuer le chef Bloodmaw (Gangrebois, au sud du Repaire des Grumegueules) et prendre sa masse",
                "Kill Chieftain Bloodmaw (Felwood, south of Timbermaw Hold) and loot his mace"), { map = 1448 }),
            T(87346, "q8_gorn"),
            A(86814, "q8_gorn"),
            D(86814, L("Planter la bannière de guerre Grumegueule au bastion Legashi et tuer le prince Halanox (élite : venez en groupe)",
                "Plant the Timbermaw War Banner at Legashi Stronghold and kill Prince Halanox (elite: bring a group)"), { map = 1447, x = 63.0, y = 23.3 }),
            T(86814, "ql_gatekeeper_rageroar"),
        } },
    },
} end)
