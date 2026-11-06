local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("DM", {
    instance = 36,
    area = 1581,
    bosses = {
        { name = "Rhahk'Zor", npc = 644, level = "19", display = 14403,
          loot = { 872, 5187, 273289 } },
        { name = "Miner Johnson", npc = 3586, level = "19", display = 556, rare = true,
          loot = { 5443, 5444 } },
        { name = "Sneed", npc = 643, level = "20", display = 7125,
          loot = { 5194, 5195, 273293, 285292 } },
        { name = "Sneed's Shredder", npc = 642, level = "20", display = 1269,
          loot = { 1937, 2169 } },
        { name = "Gilnid", npc = 1763, level = "20", display = 7124,
          loot = { 1156, 5199, 273297 } },
        { name = "Mr. Smite", npc = 646, level = "20", display = 2026,
          loot = { 7230, 5192, 5196, 284715 } },
        { name = "Captain Greenskin", npc = 647, level = "20", display = 7113,
          loot = { 5201, 10403, 5200 } },
        { name = "Edwin VanCleef", npc = 639, level = "21", display = 2029,
          loot = { 5193, 5202, 10399, 5191, 2874 } },
        { name = "Cookie", npc = 645, level = "20", display = 1305,
          loot = { 5198, 5197, 8490, 273298 } },
        { name = "Defias Gunpowder", extra = true,
          loot = { 5397 } },
    },
    trash = { 8492 },
})
