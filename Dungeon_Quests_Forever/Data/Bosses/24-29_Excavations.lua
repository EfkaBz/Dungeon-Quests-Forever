local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("EXCAV", {
    bosses = {
        { name = "Saltspine",
          loot = { 273022, 273023, 273024 } },
        { name = "Shadetooth",
          loot = { 273025, 273026, 273027 } },
        { name = "Relic Guardian",
          loot = { 273028, 273030, 273029 } },
    },
})
