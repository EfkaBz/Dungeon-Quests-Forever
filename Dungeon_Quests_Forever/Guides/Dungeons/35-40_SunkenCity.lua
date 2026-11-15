local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, D = ns.Accept, ns.TurnIn, ns.Do

-- ===================================================================
-- The Drowned City (35-40) - WoW Forever, Stranglethorn Vale
-- New Forever dungeon. Quests, chains, bosses and loot from
-- DungeonJournal 2.0.4 (Wowhead Forever and players, Nov 2026).
-- NPC IDs are unknown (id = 0): the coordinates come from the journal.
-- ===================================================================

-- NPCs (map = uiMapID; forever = coordinates from DungeonJournal, kept as they are)
N.ql_abra_cadabra = { id = 0, name = "Abra Cadabra", map = 1416, x = 13.2, y = 69.6, forever = true }
N.ql_archmage_timear = { id = 0, name = "Archmage Timear", map = 1416, x = 15.4, y = 74.0, forever = true }
N.ql_brother_nimetz = { id = 0, name = "Brother Nimetz", map = 1434, x = 37.8, y = 3.6, forever = true }
N.ql_commander_aggro_gosh = { id = 0, name = "Commander Aggro'gosh", map = 1434, x = 32.2, y = 28.8, forever = true }
N.ql_kin_weelay = { id = 0, name = "Kin'weelay", map = 1434, x = 32.3, y = 27.7, forever = true }
N.ql_loremaster_dibbs = { id = 0, name = "Loremaster Dibbs", map = 1424, x = 50.6, y = 57.1, forever = true }
N.ql_mazu_kon = { id = 0, name = "Mazu'kon", map = 1412, x = 32.5, y = 20.6, forever = true }
N.ql_sergeant_yohwa = { id = 0, name = "Sergeant Yohwa", map = 1434, x = 38.0, y = 3.4, forever = true }

ns:RegisterDungeon("SUNKEN", function() return {
    name = L("La cité Submergée", "The Drowned City"),
    levels = "35-40",
    new = true, -- new in Forever
    icon = "Interface\\Icons\\Spell_Frost_SummonWaterElemental",
    entrance = { map = 1434, x = 21.4, y = 27.9 },
    titles = {
        [629] = L("Le Récif infâme", "The Vile Reef"),
        [95748] = L("Les anciennes légendes des Gurubashi", "The Gurubashi Legends of Old"),
        [95770] = L("À la recherche de la cité perdue", "Locating the Lost City"),
        [95775] = L("La cité Submergée", "The Drowned City"),
        [95773] = L("Des adversaires sous les flots", "Enemies in the Water"),
        [95776] = L("Le seul bon Écaille-de-mer…", "The Only Good Brinescale..."),
        [96774] = L("L'idole des anciens Gurubashi", "Ancient Gurubashi Idol"),
        [95787] = L("Cap sur les eaux troubles", "Take Two With Water"),
        [95788] = L("Les magies de la cité Submergée", "Magics of the Drowned City"),
        [97130] = L("Les secrets des anciens Gurubashi", "Ancient Gurubashi Secrets"),
        [95789] = L("Sel-augures véreux", "Shady Saltseers"),
        [95791] = L("Le capitaine sel-augure", "The Saltseer Captain"),
        [96078] = L("A Tale Spun Around the Fire", "A Tale Spun Around the Fire"),
        [203] = L("La seconde rébellion", "The Second Rebellion"),
        [204] = L("Mauvaise médecine", "Bad Medicine"),
        [207] = L("Le mystère de Kurzen", "Kurzen's Mystery"),
        [205] = L("Sorcellerie troll", "Troll Witchery"),
        [95786] = L("Une connaissance d'Austrivage", "An Acquaintance in Southshore"),
        [95799] = L("Findings for the Explorer's League", "Findings for the Explorer's League"),
        [95798] = L("The Web of Magic", "The Web of Magic"),
    },
    steps = {
        -- Quests to pick up before the dungeon (and their pre-quests)
        A(629, "ql_kin_weelay", { faction = "Horde" }),
        T(629, "ql_kin_weelay", { faction = "Horde" }),
        A(95748, "ql_kin_weelay", { faction = "Horde" }),
        D(95748, L("Utilisez la peau et le charbon pour créer une reproduction de la tablette de la troisième légende trolle.", "Use the hide and charcoal to make a rubbing of the Third Troll Legend tablet."), { faction = "Horde", map = 1434, x = 32.3, y = 27.7 }),
        T(95748, "ql_kin_weelay", { faction = "Horde" }),
        A(95770, "ql_kin_weelay", { faction = "Horde" }),
        D(95770, L("Explorez le récif Infâme et trouvez l'entrée de la grotte.", "Explore just west of the Vile Reef and find the cavern entrance, then report back to Kin'weelay."), { faction = "Horde", map = 1434, x = 32.3, y = 27.7 }),
        T(95770, "ql_kin_weelay", { faction = "Horde" }),
        A(95775, "ql_kin_weelay", { faction = "Horde" }),
        A(95773, "ql_commander_aggro_gosh", { faction = "Horde" }),
        D(95773, L("Récupérez 10 tridents d'écaille-de-mer sur des tirailleurs écaille-de-mer.", "Gather 10 Brinescale Tridents from Brinescale Skirmishers."), { faction = "Horde", map = 1434, x = 32.2, y = 28.8 }),
        T(95773, "ql_commander_aggro_gosh", { faction = "Horde" }),
        A(95776, "ql_commander_aggro_gosh", { faction = "Horde" }),
        A(96774, "ql_mazu_kon", { faction = "Horde" }),
        A(95787, "ql_loremaster_dibbs", { faction = "Alliance" }),
        A(95788, "ql_loremaster_dibbs", { faction = "Alliance" }),
        A(97130, "ql_archmage_timear", { faction = "Alliance" }),
        A(95789, "krazek"),
        A(95791, "krazek"),
        -- Inside the dungeon
        D(95775, L("Utilisez la peau et le charbon pour créer des reproductions des tablettes trouvées dans la cité Submergée.", "Use the hide and charcoal to make rubbings of the four Tablets of I'lalai in the Drowned City."), { faction = "Horde" }),
        D(95776, L("Tuez Var'Taka dans la cité Submergée.", "Kill Var'Taka in the Drowned City."), { faction = "Horde" }),
        D(96774, L("Récupérez une idole antique des Gurubashi dans la cité Submergée.", "Recover an Ancient Gurubashi Idol from the Drowned City."), { faction = "Horde" }),
        D(95787, L("Utilisez la peau et le charbon pour créer des reproductions des tablettes trouvées dans la cité Submergée.", "Make rubbings of the four Tablets of I'lalai in the Drowned City."), { faction = "Alliance" }),
        D(95788, L("Récupérez 5 fétiches d'I'lalai sur des Trolls de la cité Submergée.", "Collect 5 I'lalai Fetishes from the trolls in the Drowned City."), { faction = "Alliance" }),
        D(97130, L("Récupérez une idole antique des Gurubashi dans la cité Submergée.", "Recover an Ancient Gurubashi Idol from the Drowned City."), { faction = "Alliance" }),
        D(95789, L("Récupérez 10 artéfacts imprégnés de vaudou sur les pirates sel-augures de la cité Submergée.", "Collect 10 Voodoo-Infused Artifacts from the Saltseer pirates in the Drowned City.")),
        D(95791, L("Éliminez 3 légistes sel-augures ainsi que le capitaine Lèveffroi dans la cité Submergée.", "Slay Captain Dreadrise and 3 Saltseer Coroners in the Drowned City.")),
        -- Turn-ins
        T(95775, "ql_kin_weelay", { faction = "Horde" }),
        T(95776, "ql_commander_aggro_gosh", { faction = "Horde" }),
        T(96774, "ql_mazu_kon", { faction = "Horde" }),
        T(95787, "ql_loremaster_dibbs", { faction = "Alliance" }),
        T(95788, "ql_loremaster_dibbs", { faction = "Alliance" }),
        T(97130, "ql_archmage_timear", { faction = "Alliance" }),
        T(95789, "krazek"),
        T(95791, "krazek"),
        -- Follow-up quests
        A(96078, "ql_kin_weelay", { faction = "Horde" }),
        T(96078, "gadrin", { faction = "Horde" }),
        A(203, "ql_sergeant_yohwa", { faction = "Alliance" }),
        D(203, L("Tuer 15 Guerriers de la jungle. Retourner voir le sergent Yohwa au camp rebelle.", "Kill 15 Kurzen Jungle Fighters."), { faction = "Alliance", map = 1434, x = 38.0, y = 3.4 }),
        T(203, "ql_sergeant_yohwa", { faction = "Alliance" }),
        A(204, "ql_sergeant_yohwa", { faction = "Alliance" }),
        D(204, L("Apporter 7 Remèdes tropicaux et 1 Extrait de fougère vénéneuse au sergentYohwa au Camp rebelle.", "Bring 7 Jungle Remedies and 1 Venom Fern Extract to Sergeant Yohwa."), { faction = "Alliance", map = 1434, x = 38.0, y = 3.4 }),
        T(204, "ql_sergeant_yohwa", { faction = "Alliance" }),
        A(207, "ql_brother_nimetz", { faction = "Alliance" }),
        D(207, L("Trouver les 4 tablettes et rapporter ces légendes au frère Nimetz.", "Find the four troll tablets on the coast and in the Vile Reef, and bring back the First, Second, Third and Fourth Troll Legends."), { faction = "Alliance", map = 1434, x = 37.8, y = 3.6 }),
        T(207, "ql_brother_nimetz", { faction = "Alliance" }),
        A(205, "ql_brother_nimetz", { faction = "Alliance" }),
        D(205, L("Apporter 4 Fétiches Skullsplitter à frère Nimetz au camp rebelle.", "Bring 4 Skullsplitter Fetishes to Brother Nimetz."), { faction = "Alliance", map = 1434, x = 37.8, y = 3.6 }),
        T(205, "ql_brother_nimetz", { faction = "Alliance" }),
        A(95786, "ql_brother_nimetz", { faction = "Alliance" }),
        T(95786, "ql_loremaster_dibbs", { faction = "Alliance" }),
        A(95799, "ql_loremaster_dibbs", { faction = "Alliance" }),
        T(95799, "karnik", { faction = "Alliance" }),
        A(95798, "ql_loremaster_dibbs", { faction = "Alliance" }),
        T(95798, "ql_abra_cadabra", { faction = "Alliance" }),
    },
} end)
