local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: DungeonJournal 2.0.4 (Wowhead Forever and drops seen by players).
ns:RegisterBosses("SHAPER", {
    bosses = {
        { name = "Titanosaur", npc = 253201, level = "61",
          loot = { 280009, 280011 } },
        { name = "Venomridge", npc = 261813, level = "61",
          loot = { 280015 } },
        { name = "Thunderhoof", npc = 261812, level = "61",
          loot = {  } },
        { name = "Direhorn Matriarch", npc = 262127, level = "61",
          loot = {  } },
        { name = "Cinder", npc = 261974, level = "61",
          loot = {  } },
        { name = "Bolt", npc = 262081, level = "62",
          loot = {  } },
        { name = "Snowtalon", npc = 262297, level = "62",
          loot = { 280026 } },
        { name = "Vitrix", npc = 272561, level = "62",
          loot = {  } },
        { name = "Izha'Rel and Tor'Rel", npc = 253218, level = "61",
          loot = { 280014, 280013, 280012 } },
        { name = "Nanaya", npc = 261809, level = "62",
          loot = { 280023, 280025, 273128, 280024 } },
    },
})
