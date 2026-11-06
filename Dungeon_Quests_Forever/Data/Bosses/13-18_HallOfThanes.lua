local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("THANES", {
    bosses = {
        { name = "Faldrim Anvilmar",
          loot = { 270227, 271096, 271097 } },
        { name = "Magmatus",
          loot = { 270230, 270231, 271095 } },
        { name = "Plunder",
          loot = { 270228, 270229, 271098 } },
        { name = "Durgen Dirgehammer",
          loot = { 270256, 270260, 270261 } },
    },
})
