local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: DungeonJournal 2.0.4 (Wowhead Forever and drops seen by players).
ns:RegisterBosses("NOIREG", {
    bosses = {
        { name = "Impaan the Imprisoner", npc = 247206, level = "57",
          loot = {  } },
        { name = "Bonesnout the Unbroken", npc = 247198, level = "58",
          loot = { 280061 } },
        { name = "Moontouched Wanderer", npc = 269104, level = "55", rare = true,
          loot = {  } },
        { name = "Gortek the Apprentice", npc = 269111, level = "55", rare = true,
          loot = { 280077 } },
        { name = "Tunnelweb Matriarch", npc = 250034, level = "55", rare = true,
          loot = { 280086 } },
        { name = "Withermaw", npc = 247195, level = "58",
          loot = {  } },
        { name = "Elder Shaman Bloodmane", npc = 247209, level = "59",
          loot = { 280068 } },
        { name = "Blackmaw Behemoth", npc = 247207, level = "59",
          loot = {  } },
        { name = "Unbound Spirit", npc = 247231, level = "59",
          loot = { 280071 } },
        { name = "Varrox Bleakhoof", npc = 247234, level = "60",
          loot = {  } },
    },
})
