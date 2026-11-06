local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("WC", {
    instance = 43,
    area = 718,
    bosses = {
        { name = "Lord Cobrahn", npc = 3669, level = "20", display = 4213,
          loot = { 6460, 10410, 6465, 273088 } },
        { name = "Lady Anacondra", npc = 3671, level = "20", display = 4313,
          loot = { 10412, 5404, 6446 } },
        { name = "Kresh", npc = 3653, level = "20", display = 5126,
          loot = { 13245, 6447, 273084 } },
        { name = "Lord Pythas", npc = 3670, level = "21", display = 4214,
          loot = { 6472, 6473, 273089 } },
        { name = "Skum", npc = 3674, level = "21", display = 4203,
          loot = { 6449, 6448, 273137 } },
        { name = "Lord Serpentis", npc = 3673, level = "21", display = 4215,
          loot = { 6469, 5970, 10411, 6459 } },
        { name = "Verdan the Everliving", npc = 5775, level = "21", display = 4256,
          loot = { 6630, 6631, 6629 } },
        { name = "Mutanus the Devourer", npc = 3654, level = "22", display = 4088,
          loot = { 6461, 6627, 6463, 10441 } },
        { name = "Deviate Faerie Dragon", npc = 5912, level = "19", display = 1267, rare = true,
          loot = { 5243, 6632 } },
    },
    trash = { 10413 },
})
