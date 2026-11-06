local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("DME", {
    area = 2557,
    bosses = {
        { name = "Pusillin", npc = 14354, level = "57", display = 7552,
          loot = { 18267, 18249 } },
        { name = "Zevrim Thornhoof", npc = 11490, level = "57", display = 11335,
          loot = { 18319, 18313, 18323, 18308, 18306 } },
        { name = "Hydrospawn", npc = 13280, level = "57", display = 5489,
          loot = { 18317, 18322, 18324, 19268, 18305, 18307 } },
        { name = "Lethtendris", npc = 14327, level = "57", display = 14378,
          loot = { 18325, 18311, 18301, 18302 } },
        { name = "Alzzin the Wildshaper", npc = 11492, level = "58", display = 14416,
          loot = { 18328, 18312, 18309, 18326, 18327, 18318, 18321, 18310, 18314, 18315 } },
        { name = "Isalien (T0.5)", npc = 16097, display = 16000, extra = true,
          loot = { 22304, 22472, 22401, 22345, 22315, 22314 } },
    },
    trash = { 18289, 18296, 18298, 18295, 18333, 18334, 18332, 18255, 18297 },
})
