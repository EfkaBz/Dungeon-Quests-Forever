local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("SMGY", {
    instance = 189,
    area = 796,
    bosses = {
        { name = "Interrogator Vishas", npc = 3983, level = "32", display = 2044,
          loot = { 7682, 7683 } },
        { name = "Azshir the Sleepless", npc = 6490, level = "33", display = 5534, rare = true,
          loot = { 7709, 7708, 7731 } },
        { name = "Fallen Champion", npc = 6488, level = "33", display = 5230, rare = true,
          loot = { 7691, 7690, 7689 } },
        { name = "Ironspine", npc = 6489, level = "33", display = 5231, rare = true,
          loot = { 7688, 7687, 7686 } },
        { name = "Bloodmage Thalnos", npc = 4543, level = "33", display = 11396,
          loot = { 7685, 7684 } },
        { name = "Scorn", npc = 14693, display = 16197, extra = true,
          loot = { 23169, 23170, 23168 } },
        { name = "Headless Horseman", npc = 23682, level = "83", display = 22351, extra = true,
          loot = { 211817, 211844, 211847, 211850, 211851, 33292, 34068, 33277, 37012, 33182, 33176, 33184, 37011, 33154 } },
    },
    trash = { 5819, 7727, 7728, 7754, 10332, 2262, 7787, 7729, 7761, 7752, 8226, 7786, 7753, 7730 },
})
