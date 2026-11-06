local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("ZF", {
    instance = 209,
    area = 1176,
    bosses = {
        { name = "Antu'sul", npc = 8127, level = "48", display = 7353,
          loot = { 9640, 9641, 9639, 9379 } },
        { name = "Theka the Martyr", npc = 7272, level = "45-46", display = 6696,
          loot = { 10660 } },
        { name = "Sandarr Dunereaver", npc = 10080, level = "45", display = 9291, rare = true,
          loot = { 9523 } },
        { name = "Witch Doctor Zum'rah", npc = 7271, level = "46", display = 6434,
          loot = { 18083, 18082 } },
        { name = "Nekrum Gutchewer", npc = 7796, level = "45-46", display = 6690,
          loot = { 9471 } },
        { name = "Shadowpriest Sezz'ziz", npc = 7275, level = "47", display = 6441,
          loot = { 9470, 9473, 9474, 9475 } },
        { name = "Dustwraith", npc = 10081, level = "47", display = 9292, rare = true,
          loot = { 12471 } },
        { name = "Sandfury Executioner", npc = 7274, level = "46", display = 6440,
          loot = { 8444 } },
        { name = "Sergeant Bly", npc = 7604, level = "45", display = 6433,
          loot = { 8548 } },
        { name = "Hydromancer Velratha", npc = 7795, level = "46", display = 6685,
          loot = { 9234, 10661 } },
        { name = "Gahz'rilla", npc = 7273, level = "46", display = 7271,
          loot = { 9469, 9467 } },
        { name = "Chief Ukorz Sandscalp", npc = 7267, level = "48", display = 6439,
          loot = { 9479, 9476, 9478, 9477, 11086 } },
        { name = "Zerillis", npc = 10082, level = "45", display = 9293, rare = true,
          loot = { 12470 } },
    },
    trash = { 9512, 9484, 862, 6440, 9483, 2040, 5616, 9511, 9481, 9480, 9482, 9243 },
})
