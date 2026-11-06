local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("SMARM", {
    instance = 189,
    area = 796,
    bosses = {
        { name = "Herod", npc = 3975, level = "40", display = 2041,
          loot = { 7719, 7718, 10330, 7717 } },
    },
    trash = { 5819, 7755, 7727, 7728, 7759, 7754, 10332, 1992, 2262, 7787, 7729, 7761, 7752, 8226, 7786, 5756, 7736, 8225, 7753, 7730, 7757, 10333, 10329, 23192 },
})
