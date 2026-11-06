local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("DMW", {
    area = 2557,
    bosses = {
        { name = "Tendris Warpwood", npc = 11489, level = "60", display = 14383,
          loot = { 18393, 18390, 18352, 18353 } },
        { name = "Illyanna Ravenoak", npc = 11488, level = "60", display = 11270,
          loot = { 18383, 18386, 18349, 18347 } },
        { name = "Magister Kalendris", npc = 11487, level = "60", display = 14384,
          loot = { 18374, 18397, 18371, 18350, 18351, 22309 } },
        { name = "Tsu'zee", npc = 11467, level = "60", display = 11250, rare = true,
          loot = { 18387, 18346, 18345 } },
        { name = "Immol'thar", npc = 11496, level = "61", display = 14173,
          loot = { 18381, 18384, 18389, 18385, 18394, 18377, 18391, 18379, 18370, 18372 } },
        { name = "Prince Tortheldrin", npc = 11486, level = "61", display = 11256,
          loot = { 18382, 18373, 18375, 18378, 18380, 18395, 18388, 18396, 18376, 18392 } },
        { name = "Revanchion", npc = 14690, display = 14695, extra = true,
          loot = { 23127, 23129, 23128 } },
        { name = "Shen'dralar Provisioner", npc = 14371, display = 14412, extra = true,
          loot = { 18487 } },
        { name = "Lord Hel'nurath", npc = 14506, display = 14556, extra = true,
          loot = { 18757, 18754, 18755, 18756 } },
    },
    trash = { 18340, 18344, 18338, 18333, 18334, 18332 },
})
