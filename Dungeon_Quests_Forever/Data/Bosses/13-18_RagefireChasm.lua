local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("RFC", {
    instance = 389,
    area = 2437,
    bosses = {
        { name = "Taragaman the Hungerer", npc = 11520, level = "16", display = 7970,
          loot = { 14149, 14148, 14145 } },
        { name = "Jergosh the Invoker", npc = 11518, level = "16", display = 11429,
          loot = { 14150, 14147, 14151 } },
        { name = "Oggleflint", npc = 11517, level = "16", display = 11429,
          loot = { 272996, 272998, 272999 } },
        { name = "Bazzalan", npc = 11519, level = "16", display = 11429,
          loot = { 273003, 273005, 273007 } },
    },
})
