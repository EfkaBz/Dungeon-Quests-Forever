local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("UBRS", {
    instance = 229,
    area = 1583,
    bosses = {
        { name = "Pyroguard Emberseer", npc = 9816, level = "60", display = 2172,
          loot = { 16672, 12929, 12927, 12905, 12926, 23320 } },
        { name = "Solakar Flamewreath", npc = 10264, level = "60", display = 9581,
          loot = { 16695, 12609, 12603, 12589, 12606, 18657 } },
        { name = "Jed Runewatcher", npc = 10509, level = "59", display = 9686, rare = true,
          loot = { 12604, 12930, 12605 } },
        { name = "Goraluk Anvilcrack ", npc = 10899, level = "61", display = 10222,
          loot = { 13502, 13498, 18047, 18048, 12834, 12837, 18779, 12806, 12696 } },
        { name = "Gyth", npc = 10339, level = "62", display = 9806,
          loot = { 12871, 16669, 22225, 12960, 12953, 12952, 13522 } },
        { name = "Warchief Rend Blackhand", npc = 10429, level = "62", display = 9778,
          loot = { 12590, 16733, 12587, 12588, 12936, 18104, 12935, 18102, 22247, 18103, 12940, 12939, 12583 } },
        { name = "The Beast", npc = 10430, level = "62", display = 10193,
          loot = { 12731, 16729, 12967, 12968, 12966, 12965, 12963, 12964, 22311, 12709, 12969, 24101, 19227 } },
        { name = "General Drakkisath", npc = 10363, level = "62", display = 10115,
          loot = { 12592, 22267, 13141, 22269, 13142, 13098, 22268, 22253, 12602, 15730, 13519, 16690, 16688, 16700, 16721, 16706, 16674, 16666, 16726, 16730 } },
        { name = "Darkstone Tablet", extra = true,
          loot = { 12358 } },
        { name = "Lord Valthalak (T0.5)", npc = 16042, display = 14308, extra = true,
          loot = { 22302, 22340, 22337, 22343, 22342, 22339, 22336, 22335 } },
    },
    trash = { 24102, 13260, 16696, 16683, 16703, 16713, 16681, 16680, 16673, 16735, 16247 },
})
