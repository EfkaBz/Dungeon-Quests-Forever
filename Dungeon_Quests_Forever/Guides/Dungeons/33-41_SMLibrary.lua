local _, ns = ...
local L = ns.L
local N = ns.NPCS
local A, T, K, D = ns.Accept, ns.TurnIn, ns.Talk, ns.Do

-- ===================================================================
-- Scarlet Monastery - Library - Horde & Alliance
-- Classic version, verified against the Questie classic DB.
-- Shared Scarlet data (NPCs, cross-wing quests) is in 30-46_ScarletMonasteryShared.lua.
-- ===================================================================
local function H(extra) local t = extra or {}; t.faction = "Horde"; return t end
local function AL(extra) local t = extra or {}; t.faction = "Alliance"; return t end

ns:RegisterDungeon("SMLIB", function() return {
    name = L("Monastère écarlate - Bibliothèque", "Scarlet Monastery - Library"),
    levels = "33-41",
    icon = "Interface\\Icons\\INV_Misc_Book_07",
    entrance = { map = 1420, x = 82.6, y = 33.8 },
    titles = ns.SM.Titles({
        [1049] = L("Compendium des Déchus", "Compendium of the Fallen"),
        [1050] = L("Mythologie des Titans", "Mythology of the Titans"),
        [1149] = L("L'épreuve de la Foi", "Test of Faith"),
        [1150] = L("L’épreuve de l’Endurance", "Test of Endurance"),
        [1151] = L("L'épreuve de la Force", "Test of Strength"),
        [1152] = L("L'épreuve de la Connaissance", "Test of Lore"),
        [1154] = L("L'épreuve de la Connaissance", "Test of Lore"),
        [6627] = L("L'épreuve de la Connaissance", "Test of Lore"),
        [1159] = L("L'épreuve de la Connaissance", "Test of Lore"),
        [1160] = L("L'épreuve de la Connaissance", "Test of Lore"),
        [6628] = L("L'épreuve de la Connaissance", "Test of Lore"),
    }),
    steps = ns.SM.Join(
        ns.SM.PreSteps(),
        {
            -- Horde: Test of Lore chain (Thousand Needles -> Stonetalon -> Ashenvale -> Undercity)
            A(1149, "dorn", H()),
            D(1149, L("Sauter des planches au-dessus des Mille pointes", "Leap from the planks over Thousand Needles"), H({ map = 1441, x = 53.9, y = 41.5 })),
            T(1149, "dorn", H()),
            A(1150, "dorn", H()),
            D(1150, L("Griffe de Grenka Hurlesang", "Grenka's Claw"), H({ targets = { "grenka" } })),
            T(1150, "dorn", H()),
            A(1151, "dorn", H()),
            D(1151, L("Fragments de Rok'Alim le Marteleur", "Fragments of Rok'Alim"), H({ map = 1441, x = 25.8, y = 42.1, targets = { "rokalim" } })),
            T(1151, "dorn", H()),
            A(1152, "dorn", H()),
            T(1152, "braug", H()),
            A(1154, "braug", H()),
            D(1154, L("L'héritage des Aspects (livre, Orneval)", "The Legacy of the Aspects (book, Ashenvale)"), H({ map = 1440, x = 75.6, y = 74.4 })),
            T(1154, "braug", H()),
            A(6627, "braug", H()),
            K(6627, "braug", L("Répondre correctement à la question de Braug", "Answer Braug's question correctly"), H()),
            T(6627, "braug", H()),
            A(1159, "braug", H()),
            T(1159, "parqual", H()),
            A(1160, "parqual", H()),
            -- Other pre-quests
            A(1049, "truthseeker", H()),
            A(1050, "paledust", AL()),
            -- Inside the Library
            ns.SM.Hearts(),
            D(1160, L("Les débuts de la menace mort-vivante (livre)", "Beginnings of the Undead Threat (book)"), H()),
            D(1049, L("Recueil des déchus (livre)", "Compendium of the Fallen (book)"), H()),
            D(1050, L("Mythologie des Titans (livre)", "Mythology of the Titans (book)"), AL()),
        },
        ns.SM.WingSteps({
            { index = 4, key = "loksey", text = L("Tuer le maître-chien Loksey", "Kill Houndmaster Loksey") },
        }),
        {
            -- Turn-ins
            T(1049, "truthseeker", H()),
            T(1160, "parqual", H()),
            A(6628, "parqual", H()),
            K(6628, "parqual", L("Répondre correctement à la question de Parqual", "Answer Parqual's question correctly"), H()),
            T(6628, "parqual", H()),
            T(1050, "paledust", AL()),
            T(1113, "faranell", H()),
        }
    ),
} end)
