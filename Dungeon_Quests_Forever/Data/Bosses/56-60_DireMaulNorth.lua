local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("DMN", {
    area = 2557,
    bosses = {
        { name = "Guard Mol'dar", npc = 14326, level = "59", display = 11561,
          loot = { 18494, 18493, 18496, 18497, 18498, 18450, 18458, 18459, 18451, 18462, 18463, 18464, 18460, 18250, 18268 } },
        { name = "Stomper Kreeg", npc = 14322, level = "59", display = 11545,
          loot = { 18425, 18269, 18284, 18287, 18288, 9260 } },
        { name = "Guard Fengus", npc = 14321, level = "59", display = 11561,
          loot = { 18450, 18458, 18459, 18451, 18462, 18463, 18464, 18460, 18250, 18266 } },
        { name = "Guard Slip'kik", npc = 14323, level = "59", display = 11561,
          loot = { 18494, 18493, 18496, 18497, 18498, 18450, 18458, 18459, 18451, 18462, 18463, 18464, 18460, 18250 } },
        { name = "Knot Thimblejack's Cache", npc = 14338,
          loot = { 18414, 18517, 18518, 18519, 18415, 18416, 18417, 18418, 18514, 18515, 18516, 18258, 18240 } },
        { name = "Captain Kromcrush", npc = 14325, level = "61", display = 11564,
          loot = { 18503, 18505, 18507, 18502 } },
        { name = "Cho'Rush the Observer", npc = 14324, level = "60", display = 11537,
          loot = { 18490, 18483, 18485, 18484 } },
        { name = "King Gordok", npc = 11501, level = "62", display = 11583,
          loot = { 18526, 18525, 18527, 18524, 18521, 18522, 18523, 18520, 19258, 18780 } },
        { name = "Tribute", npc = 14324, extra = true,
          loot = { 18538, 18528, 18495, 18532, 18530, 18533, 18529, 18500, 18537, 18499, 18531, 18534, 18479, 18480, 18478, 18475, 18477, 18476, 18482, 18481, 18655 } },
    },
    trash = { 18250, 18333, 18334, 18332, 18640 },
})
