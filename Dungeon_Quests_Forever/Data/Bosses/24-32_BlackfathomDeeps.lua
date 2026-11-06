local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("BFD", {
    instance = 48,
    area = 719,
    bosses = {
        { name = "Ghamoo-ra", npc = 4887, level = "25", display = 5027,
          loot = { 6907, 6908 } },
        { name = "Lady Sarevess", npc = 4831, level = "25", display = 4979,
          loot = { 888, 3078, 11121 } },
        { name = "Gelihast", npc = 6243, level = "26", display = 1773,
          loot = { 6906, 6905, 1470, 273840 } },
        { name = "Baron Aquanis", npc = 12876, level = "28", display = 110,
          loot = { 16782 } },
        { name = "Twilight Lord Kelris", npc = 4832, level = "27", display = 4939,
          loot = { 1155, 6903, 273846 } },
        { name = "Old Serra'kis", npc = 4830, level = "26", display = 1816,
          loot = { 6901, 6904, 6902 } },
        { name = "Aku'mai", npc = 4829, level = "28", display = 2837,
          loot = { 6911, 6910, 6909 } },
        { name = "Lorgus Jett", npc = 12902, level = "26", display = 2837,
          loot = { 273841, 273842, 273843 } },
    },
    trash = { 1486, 3416, 1491, 3414, 1454, 1481, 2567, 3413, 3417, 3415, 2271 },
})
