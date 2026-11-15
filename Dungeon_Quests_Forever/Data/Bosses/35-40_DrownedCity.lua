local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: DungeonJournal 2.0.4 (Wowhead Forever and drops seen by players).
ns:RegisterBosses("SUNKEN", {
    bosses = {
        { name = "Zul'Alai", npc = 258905, level = "37",
          loot = { 274599, 274598, 274600 } },
        { name = "Var'Taka", npc = 258924, level = "38",
          loot = { 274602, 274601, 274613 } },
        { name = "Captain Dreadrise", npc = 260042, level = "38",
          loot = { 274604, 274605, 274603 } },
        { name = "Deathless Marrow", level = "39",
          loot = { 274606, 274614, 274607 } },
        { name = "Primeval Elemental", level = "38",
          loot = { 274612, 274611, 274615 } },
        { name = "Gill", npc = 264177, level = "38", rare = true,
          loot = { 286646, 286649 } },
        { name = "Umbra", npc = 264172, level = "38", rare = true,
          loot = { 286662, 286658 } },
        { name = "\"Pyromancer\" Braxton", npc = 260468, level = "38", rare = true,
          loot = { 286650, 286651 } },
        { name = "Min'loth the Serpent", npc = 260274, level = "40",
          loot = { 274610, 274608, 274609 } },
    },
    trash = { 287002, 286997, 287005 },
})
