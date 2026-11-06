local _, ns = ...

-- Bosses of this dungeon (demo order, beta data). Loot from
-- foreverchanges.pro and items seen in game (beta, may change).
ns:RegisterBosses("DALARAN", {
    instance = 2959,
    bosses = {
        { name = "Atrexis the Grave Knight", level = "29", loot = { 273036, 273032, 273033 } },
        { name = "Arcane Anomaly",           level = "30", loot = { 273031, 273034, 273035 } },
        { name = "Unstable Sentinel",        level = "31", loot = { 273046, 273048, 273047, 273099 } },
        { name = "Mana Devourer",                          loot = { 273040, 273041, 273042 } },
        { name = "Mana Wraith",                            loot = {} },
        { name = "Fel Ancient",              level = "32", loot = { 273039, 273037, 273038 } },
        { name = "Arcanic Enigma",  rare = true,           loot = { 273045, 273044, 273043 },
          aliases = { "Mana Elemental" } }, -- encounter name in the "Loot Rolls" window
        { name = "Lyn the Ignored", rare = true,           loot = {} },
        { name = "Shade of the Archmage",    level = "33", loot = { 273052, 273051, 273049 } },
    },
})
