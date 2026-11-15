local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: DungeonJournal 2.0.4 (Wowhead Forever and drops seen by players).
ns:RegisterBosses("ALCAZ", {
    bosses = {
        { name = "Overseer Wrex", npc = 255391, level = "50",
          loot = { 276734, 276732 } },
        { name = "The Questioner", npc = 256236, level = "51",
          loot = { 276742, 276743, 276741, 274029 } },
        { name = "Tidemistress Ca'zass", npc = 255997, level = "50",
          loot = { 276736, 276737, 273883 } },
        { name = "Katerina the Cleaner", npc = 257016, level = "52",
          loot = { 276738, 276740 } },
        { name = "Blazeroar", npc = 255702, level = "53",
          loot = { 276744, 276745, 276746, 276890 } },
    },
    trash = { 287021, 287019, 287018 },
})
