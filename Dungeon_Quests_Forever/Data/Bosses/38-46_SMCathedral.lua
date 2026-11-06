local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("SMCATH", {
    instance = 189,
    area = 796,
    bosses = {
        { name = "High Inquisitor Fairbanks", npc = 4542, level = "40", display = 2605,
          loot = { 19507, 19508, 19509 } },
        { name = "Scarlet Commander Mograine", npc = 3976, level = "42", display = 2042,
          loot = { 7724, 10330, 7726, 7723 } },
        { name = "High Inquisitor Whitemane", npc = 3977, level = "42", display = 2043,
          loot = { 7720, 7722, 7721 } },
    },
    trash = { 5819, 7755, 7727, 7728, 7759, 7760, 7754, 10332, 1992, 2262, 7787, 7729, 7761, 7752, 8226, 7786, 5756, 7736, 8225, 7753, 7730, 7758, 7757, 10328, 10331, 10329 },
})
