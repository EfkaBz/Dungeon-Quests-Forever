local _, ns = ...
local L = ns.L
local D = ns.Do

-- ===================================================================
-- Tome of Dalaran (Shadowfang Keep -> Ambermill) - Forever only
-- ===================================================================
-- The Tome of Dalaran (275989) summons the rare boss Lyn the Ignored in
-- the City of Dalaran. Black Tome (276561): Shadowfang Keep, table behind
-- Arugal's room; turned into the Tome of Dalaran at the Ambermill Leyline
-- Focus. Source: Warcraft Tavern (beta, may change). Same steps as in the
-- City of Dalaran guide (steps without quest: done when the item is seen).
local SFK = { map = 1421, x = 44.8, y = 67.8 }
local FOCUS = { map = 1421, x = 63.4, y = 64.3 }

ns:RegisterDungeon("TOMEDALARAN", function() return {
    name = L("Tome de Dalaran", "Tome of Dalaran"),
    levels = "22-60",
    overworld = true,
    new = true,
    icon = "Interface\\Icons\\INV_Misc_Book_07",
    entrance = SFK,
    titles = {},
    steps = {
        D(0, L("Donjon d'Ombrecroc : tuer Arugal, puis monter l'escalier au fond de sa salle. Le Tome noir est sur la table couverte d'ingrédients d'alchimie",
                "Shadowfang Keep: kill Arugal, then climb the stairs at the back of his room. The Black Tome is on the table covered with alchemy ingredients"),
            { title = L("Le Tome noir", "The Black Tome"),
              haveItems = { 276561, 275989 }, map = SFK.map, x = SFK.x, y = SFK.y }),
        D(0, L("Ambermill (Forêt des Pins-Argentés), mairie au fond du village : utiliser le Tome noir sur le Focus de ligne tellurique (cristal bleu, près de l'archimage Ataeric)",
                "Ambermill (Silverpine Forest), town hall at the back: use the Black Tome on the Ambermill Leyline Focus (blue crystal, next to Archmage Ataeric)"),
            { title = L("Créer le Tome de Dalaran", "Create the Tome of Dalaran"),
              haveItems = { 275989 }, item = 276561, map = FOCUS.map, x = FOCUS.x, y = FOCUS.y }),
        D(0, L("Cité de Dalaran : après Atrexis, avant la rampe à droite vers Arcane Anomaly, continuer tout droit jusqu'à la petite salle. Utiliser le tome sur le cercle d'invocation pour invoquer Lyn the Ignored",
                "City of Dalaran: after Atrexis, before the ramp on the right to Arcane Anomaly, go straight on to the small room. Use the tome on the summoning circle to summon Lyn the Ignored"),
            { title = L("Invoquer Lyn the Ignored", "Summon Lyn the Ignored"), item = 275989,
              map = 1416, x = 8.5, y = 59.3 }), -- City of Dalaran entrance
    },
} end)
