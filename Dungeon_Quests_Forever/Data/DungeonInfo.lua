local _, ns = ...

-- Presentation data merged into each dungeon at load (see Core.lua):
--   art     = card picture of the journal home page (game loading screen,
--             texture path or file ID); the dungeon icon is shown below it,
--             so a missing picture never leaves an empty card
--   artCoord= texture coordinates of the picture (left, right, top, bottom)
--   wingMap = uiMapID of the wing, when several dungeons share one instance
--   route   = optional hand-made route to the entrance:
--             { { faction = "Alliance"|"Horde"|nil, points = { {map, x, y, text, flight}, ... } }, ... }
--             without it, an automatic route is built (flight master -> entrance)
local LS = "Interface\\Glues\\LoadingScreens\\"
local WIDE = { 0.02, 0.98, 0.24, 0.82 }

ns.DUNGEON_INFO = {
    RFC     = { art = LS .. "LoadScreenRagefireChasm" },
    WC      = { art = LS .. "LoadScreenWailingCaverns" },
    DM      = { art = LS .. "LoadScreenDeadmines" },
    SFK     = { art = LS .. "LoadScreenShadowFangKeep" },
    BFD     = { art = LS .. "LoadScreenBlackFathomDeeps" },
    STOCKS  = { art = 131870 },
    GNOMER  = { art = LS .. "LoadScreenGnomeregan" },
    RFK     = { art = 131865 },
    -- Forever loading screens (file IDs found in the game client)
    THANES  = { art = 7963781, artCoord = { 0, 1, 0.12, 0.88 } },
    ROL     = { art = 7963782, artCoord = { 0, 1, 0.12, 0.88 } },
    EXCAV   = { art = 7963777, artCoord = { 0, 1, 0.12, 0.88 } },
    DALARAN = { art = 7963775, artCoord = { 0, 1, 0.12, 0.88 } },
    SUNKEN  = { art = 7963776, artCoord = { 0, 1, 0.12, 0.88 } },
    -- Scarlet Monastery: one instance, one map per wing (to verify at launch)
    SMGY    = { art = LS .. "LoadScreenScarletMonastery2", wingMap = 302 },
    SMLIB   = { art = LS .. "LoadScreenScarletMonastery2", wingMap = 303 },
    SMARM   = { art = LS .. "LoadScreenScarletMonastery2", wingMap = 304 },
    SMCATH  = { art = LS .. "LoadScreenScarletMonastery2", wingMap = 305 },
    RFD     = { art = LS .. "LoadScreenRazorfenDowns" },
    ULDA    = { art = LS .. "LoadScreenUldaman" },
    ZF      = { art = LS .. "LoadScreenZulFarrak" },
    MARA    = { art = LS .. "LoadScreenMaraudon" },
    ST      = { art = LS .. "LoadScreenSunkenTemple" },
    BRD     = { art = LS .. "LoadScreenBlackrockDepths" },
    LBRS    = { art = LS .. "LoadScreenBlackrockSpire" },
    UBRS    = { art = LS .. "LoadScreenBlackrockSpire" },
    DME     = { art = LS .. "LoadScreenDireMaul" },
    DMN     = { art = LS .. "LoadScreenDireMaul" },
    DMW     = { art = LS .. "LoadScreenDireMaul" },
    SCHOLO  = { art = LS .. "LoadScreenScholomance" },
    -- Stratholme: no classic loading screen in the client, the Culling of Stratholme one is used
    -- (framed lower: the top of this picture has the Wrath of the Lich King logo)
    STRAT   = { art = 131859, artCoord = { 0.02, 0.98, 0.33, 0.91 } },
}
for _, info in pairs(ns.DUNGEON_INFO) do info.artCoord = info.artCoord or WIDE end
