local _, ns = ...

----------------------------------------------------------------------
-- Languages
-- "auto" follows the game client; any other code forces that language.
-- Texts are written as L(french, english). For the other languages the
-- English text is the key of a translation table filled by Locales\*.lua:
--   ns.CONTENT.de["Show/hide window"] = "Fenster ein-/ausblenden"
-- A text without translation falls back to English.
----------------------------------------------------------------------
ns.CONTENT = {}

-- code, game locale, native name (order used by the options selector)
ns.LANGS = {
    { "en", "enUS", "English" },
    { "fr", "frFR", "Français" },
    { "de", "deDE", "Deutsch" },
    { "es", "esES", "Español" },
    { "it", "itIT", "Italiano" },
    { "pt", "ptBR", "Português" },
    { "ru", "ruRU", "Русский" },
    { "ko", "koKR", "한국어" },
    { "zh", "zhCN", "简体中文" },
    { "tw", "zhTW", "繁體中文" },
}
local KNOWN = {}
for _, l in ipairs(ns.LANGS) do KNOWN[l[1]] = true; ns.CONTENT[l[1]] = ns.CONTENT[l[1]] or {} end

local CLIENT = {
    enUS = "en", enGB = "en", frFR = "fr", deDE = "de", esES = "es", esMX = "es",
    itIT = "it", ptBR = "pt", ptPT = "pt", ruRU = "ru", koKR = "ko", zhCN = "zh", zhTW = "tw",
}

function ns.ClientLang() return CLIENT[GetLocale()] or "en" end
function ns.ClientIsFR() return ns.ClientLang() == "fr" end

-- Saved variables are only available after ADDON_LOADED: before that the
-- client language is used.
function ns.Lang()
    local lang = DQF_DB and DQF_DB.lang
    if lang and lang ~= "auto" and KNOWN[lang] then return lang end
    return ns.ClientLang()
end
function ns.IsFR() return ns.Lang() == "fr" end

-- true when the addon language matches the client language: texts given by
-- the game (quest titles, NPC, item and zone names) can then be used as is
function ns.ClientLangMatches() return ns.Lang() == ns.ClientLang() end

function ns.L(fr, en)
    local lang = ns.Lang()
    if lang == "fr" then return fr end
    if lang ~= "en" then
        local t = ns.CONTENT[lang]
        local v = t and t[en]
        if v then return v end
    end
    return en
end

-- Text written in English only (shared with the translation tables)
function ns.T(en)
    local t = ns.CONTENT[ns.Lang()]
    return t and t[en] or en
end

-- Helper for the Locales files: ns.Translate("de", { [en] = text, ... })
function ns.Translate(code, entries)
    local t = ns.CONTENT[code]
    if not t then return end
    for k, v in pairs(entries) do t[k] = v end
end
