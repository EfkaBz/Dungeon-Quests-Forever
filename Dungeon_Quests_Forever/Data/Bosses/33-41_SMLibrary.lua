local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("SMLIB", {
    instance = 189,
    area = 796,
    bosses = {
        { name = "Houndmaster Loksey", npc = 3974, level = "34", display = 2040,
          loot = { 7710, 7756, 3456 } },
        { name = "Arcanist Doan", npc = 6487, level = "37", display = 5266,
          loot = { 7714, 7713, 7712, 7711 } },
        { name = "Doan's Strongbox", extra = true,
          loot = { 7146 } },
    },
    trash = { 5819, 7755, 7727, 7728, 7759, 7760, 7754, 10332, 1992, 2262, 7787, 7729, 7761, 7752, 8226, 7786, 5756, 7736, 8225, 7753, 7730, 7758, 7757 },
})
