local _, ns = ...

-- Bosses and loot of this dungeon. Only IDs are stored: names, quality,
-- slots and icons are read from the game client at runtime.
-- Source: public Classic / Forever loot tables. To verify in game at launch.
ns:RegisterBosses("ROL", {
    bosses = {
        { name = "The Baron",
          loot = { 271204, 271205, 271206 } },
        { name = "Witherfang",
          loot = { 271201, 271202, 271203 } },
        { name = "The Abandoned",
          loot = { 271207, 271208, 271216 } },
        { name = "Bjork",
          loot = { 271209, 271210, 271217 } },
        { name = "Rath'mael",
          loot = { 271213, 271214, 271215 } },
        { name = "Lordaeron Captain",
          loot = { 6642, 6641 } },
        { name = "Viktor the Vile",
          loot = { 271211, 271212, 271218 } },
    },
})
