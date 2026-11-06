local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("RFK", {
    instance = 47,
    area = 491,
    bosses = {
        { name = "Aggem Thorncurse", npc = 4424, level = "30", display = 6097,
          loot = { 6681 } },
        { name = "Death Speaker Jargba", npc = 4428, level = "30", display = 4644,
          loot = { 2816, 6685, 6682 } },
        { name = "Overlord Ramtusk", npc = 4420, level = "32", display = 4652,
          loot = { 6687, 6686 } },
        { name = "Razorfen Spearhide", npc = 4438, level = "29-30", display = 6078,
          loot = { 6679 } },
        { name = "Agathelos the Raging", npc = 4422, level = "33", display = 2450,
          loot = { 6691, 6690, 274158 } },
        { name = "Blind Hunter", npc = 4425, level = "32", display = 4735, rare = true,
          loot = { 6695, 6697, 6696 } },
        { name = "Charlga Razorflank", npc = 4421, level = "33", display = 4642,
          loot = { 6693, 6694, 6692, 17008 } },
        { name = "Earthcaller Halmgar", npc = 4842, level = "32", display = 6102, rare = true,
          loot = { 6689, 6688 } },
        { name = "Roogug", npc = 6168, level = "32", display = 6102, rare = true,
          loot = { 274152 } },
    },
    trash = { 2264, 1488, 4438, 1978, 2039, 1727, 776, 1976, 1975, 2549 },
})
