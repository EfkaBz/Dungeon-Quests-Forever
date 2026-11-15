local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: DungeonJournal 2.0.4 (Wowhead Forever and drops seen by players).
ns:RegisterBosses("KROLDOK", {
    bosses = {
        { name = "Slavecrusher Grox", npc = 258966, level = "42",
          loot = { 274996, 274997, 274995, 273101 } },
        { name = "Twilight Commander Zarmok", npc = 258972, level = "43",
          loot = { 275000, 274998, 274999 } },
        { name = "War Handler Ashka", npc = 259281, level = "43",
          loot = { 275001, 275002, 275003 } },
        { name = "Nar'gurk", npc = 258964, level = "44",
          loot = { 275004, 275005, 275006 } },
        { name = "Bossman Toof", npc = 264773, level = "42",
          loot = { 286430, 286429, 286428 } },
        { name = "Kroog", npc = 262716, level = "41", rare = true,
          loot = { 279863, 279857 } },
        { name = "Overlord Mugg", npc = 258968, level = "45",
          loot = { 275009, 275007, 275008, 275010 } },
    },
    trash = { 287008, 287014, 287012, 287013, 287010, 287007 },
})
