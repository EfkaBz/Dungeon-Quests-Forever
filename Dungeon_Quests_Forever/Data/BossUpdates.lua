local _, ns = ...

-- Boss data added after Data\Bosses were written (source: DungeonJournal 1.6.6 and
-- AtlasLootClassic). Merged in AttachBosses (Core.lua): loot is added to the
-- boss of that name, a boss that does not exist yet is created.
-- ["Trash Drops"] goes to the trash list of the dungeon.
ns.BOSS_UPDATES = {
    THANES = {
        ["Durgen Dirgehammer"] = { loot = { 274286 } },
    },
    RFC = {
        ["Oggleflint"] = { loot = { 252781, 252782 } },
        ["Taragaman the Hungerer"] = { loot = { 251361, 251362, 251363, 252782 } },
        ["Jergosh the Invoker"] = { loot = { 251360, 253906 } },
        ["Bazzalan"] = { loot = { 252780, 252782, 253908, 253910 } },
    },
    ROL = {
        ["Rath'mael"] = { loot = { 273085, 273103 } },
        ["Trash Drops"] = { loot = { 286981, 286977, 286978, 286979, 286980 } },
    },
    DM = {
        ["Rhahk'Zor"] = { loot = { 251362, 251364, 253906 } },
        ["Sneed's Shredder"] = { loot = { 285292 } },
        ["Sneed"] = { loot = { 273092, 251360, 251364, 253902 } },
        ["Gilnid"] = { loot = { 252777, 252778, 252780, 252782, 253904, 253906, 273086 } },
        ["Mr. Smite"] = { loot = { 251362, 252779, 252780, 252781, 252782 } },
        ["Edwin VanCleef"] = { loot = { 252799, 252800, 252801, 252803, 253938, 253948 } },
        ["Cookie"] = { loot = { 251360, 252778, 252779, 253910, 253912, 273102 } },
        ["Trash Drops"] = { loot = { 10402, 10401, 10400, 1951, 1929, 1934, 1936 } },
    },
    WC = {
        ["Lady Anacondra"] = { loot = { 273088 } },
        ["Deviate Faerie Dragon"] = { loot = { 252781 } },
    },
    SFK = {
        ["Fel Steed / Shadow Charger"] = { loot = { 251341, 251362, 251363, 251364, 252781, 252782, 253902, 253904, 253906, 253908, 253910, 253912, 251381, 251382, 252799, 252801, 252803, 253940, 253946, 253948 } },
        ["Commander Springvale"] = { loot = { 273105, 6341 } },
        ["Fenrus the Devourer"] = { loot = { 251380 } },
    },
    BFD = {
        ["Ghamoo-ra"] = { loot = { 273839, 251382, 252801, 253940, 253942 } },
        ["Lady Sarevess"] = { loot = { 252798, 251382, 251383, 253944 } },
        ["Gelihast"] = { loot = { 251375, 251377, 252820, 252821, 252825, 253978, 253980, 273141 } },
        ["Lorgus Jett"] = { loot = { 253978, 253982, 251377 } },
        ["Old Serra'kis"] = { loot = { 251375, 252825, 253978, 253982 } },
        ["Twilight Lord Kelris"] = { loot = { 252820, 252821, 252822, 252823, 252825, 253982 } },
        ["Aku'mai"] = { loot = { 251376, 251377, 251378, 252821, 252824, 253980, 253984 } },
        ["Trash Drops"] = { loot = { 2034 } },
    },
    EXCAV = {
        ["Shadetooth"] = { loot = { 273106 } },
        ["Relic Guardian"] = { loot = { 270866, 273097 } },
    },
    STOCKS = {
        ["Targorr the Dread"] = { loot = { 251380, 251382, 253942 } },
        ["Kam Deepfury"] = { loot = { 273807, 251379, 252825 } },
        ["Hamhock"] = { loot = { 273811, 251377 } },
        ["Dextren Ward"] = { new = true, npc = 1663, loot = { 273817, 273819, 273820, 251375, 251376, 252820, 252821 } },
        ["Bazil Thredd"] = { loot = { 252824, 253976, 253986 } },
    },
    DALARAN = {
        ["Lyn the Ignored"] = { loot = { 273055, 273054, 273053 } },
        ["Shade of the Archmage"] = { loot = { 273103 } },
        ["Trash Drops"] = { loot = { 286987, 286989, 286988 } },
    },
    GNOMER = {
        ["Grubbis"] = { loot = { 274043, 274042 } },
        ["Crowd Pummeler 9-60"] = { loot = { 274068 } },
    },
    RFK = {
        ["Roogug"] = { loot = { 274155, 274149 } },
        ["Aggem Thorncurse"] = { loot = { 274158, 274159, 252820 } },
        ["Overlord Ramtusk"] = { loot = { 274161, 251379, 252821 } },
        ["Agathelos the Raging"] = { loot = { 274160, 251378 } },
        ["Charlga Razorflank"] = { loot = { 273103 } },
    },
    SMGY = {
        ["Interrogator Vishas"] = { loot = { 274290 } },
        ["Bloodmage Thalnos"] = { loot = { 274291, 252822 } },
        ["Trash Drops"] = { loot = { 10333 } },
    },
    SMLIB = {
        ["Arcanist Doan"] = { loot = { 274293, 7146 } },
    },
    ZF = {
        ["Ruuzlu"] = { new = true, npc = 7797, loot = {  } },
    },
    BRD = {
        ["Warder Stilgiss"] = { loot = { 11755, 22242 } },
        ["Hurley Blackbreath"] = { new = true, npc = 9537, loot = { 18044, 18043, 22275, 11735 } },
        ["Phalanx"] = { loot = { 11746 } },
        ["Ribbly Screwspigot"] = { new = true, npc = 9543, loot = { 11612 } },
        ["Plugger Spazzring"] = { new = true, npc = 9499, loot = { 12793, 12791 } },
    },
    LBRS = {
        ["Urok Doomhowl"] = { loot = { 13053 } },
    },
    DMN = {
        ["Guard Fengus"] = { loot = { 18494, 18493, 18496, 18497, 18498 } },
    },
}
