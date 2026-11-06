local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("GNOMER", {
    instance = 90,
    area = 721,
    bosses = {
        { name = "Techbot", npc = 6231, level = "26", display = 7288,
          loot = { 9444 } },
        { name = "Grubbis", npc = 7361, level = "32", display = 6533,
          loot = { 9445 } },
        { name = "Viscous Fallout", npc = 7079, level = "30", display = 5497,
          loot = { 9454, 9453, 9452 } },
        { name = "Electrocutioner 6000", npc = 6235, level = "32", display = 6915,
          loot = { 9447, 9446, 9448, 6893 } },
        { name = "Crowd Pummeler 9-60", npc = 6229, level = "32", display = 6774,
          loot = { 9449, 9450 } },
        { name = "Dark Iron Ambassador", npc = 6228, level = "33", display = 6669, rare = true,
          loot = { 9455, 9456, 9457 } },
        { name = "Mekgineer Thermaplugg", npc = 7800, level = "34", display = 6980,
          loot = { 9492, 9461, 9458, 9459, 4415, 4413, 4411, 7742, 11828 } },
    },
    trash = { 9508, 9491, 9509, 9510, 9487, 9485, 9488, 9486, 9490, 9489, 11827, 9327, 7191, 9308, 9326, 9279, 9280, 9282, 9281, 9316 },
})
