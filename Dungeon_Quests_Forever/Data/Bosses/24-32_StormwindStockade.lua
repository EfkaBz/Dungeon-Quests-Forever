local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("STOCKS", {
    instance = 34,
    area = 717,
    bosses = {
        { name = "Kam Deepfury", npc = 1666, level = "27", display = 825,
          loot = { 2280, 273808 } },
        { name = "Bruegal Ironknuckle", npc = 1720, level = "26", display = 2142, rare = true,
          loot = { 3228, 2941, 2942 } },
        { name = "Targorr the Dread", npc = 1696, level = "26", display = 2142, rare = true,
          loot = { 273804, 273805, 273806 } },
        { name = "Hamhock", npc = 1717, level = "26", display = 2142, rare = true,
          loot = { 273809, 273810 } },
        { name = "Bazil Thredd", npc = 1716, level = "26", display = 2142, rare = true,
          loot = { 273824, 273825, 273827, 273829 } },
    },
    trash = { 1076, 274092 },
})
