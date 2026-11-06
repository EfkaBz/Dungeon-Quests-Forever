local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("RFD", {
    instance = 129,
    area = 722,
    bosses = {
        { name = "Tuten'kash", npc = 7355, level = "40", display = 7845,
          loot = { 10776, 10775, 10777 } },
        { name = "Mordresh Fire Eye", npc = 7357, level = "39", display = 8055,
          loot = { 10769, 10771, 10770 } },
        { name = "Glutton", npc = 8567, level = "40", display = 7864,
          loot = { 10774, 10772 } },
        { name = "Ragglesnout", npc = 7354, level = "40", display = 11382, rare = true,
          loot = { 10768, 10767, 10758 } },
        { name = "Amnennar the Coldbringer", npc = 7358, level = "41", display = 7971,
          loot = { 10763, 10762, 10764, 10761, 10765 } },
        { name = "Plaguemaw the Rotting", npc = 7356, level = "40", display = 6124,
          loot = { 10766, 10760 } },
        { name = "Lady Falther'ess", npc = 14686, display = 10698, extra = true,
          loot = { 23178, 23177 } },
        { name = "Henry Stern", npc = 8696, display = 8029, extra = true,
          loot = { 3826, 10841 } },
    },
    trash = { 10574, 10581, 10583, 10584, 10578, 10582, 10572, 10567, 10571, 10570, 10573 },
})
