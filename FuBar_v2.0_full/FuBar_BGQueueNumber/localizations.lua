local L = AceLibrary("AceLocale-2.2"):new("FuBar_BGQueueNumber")

L:RegisterTranslations("deDE", function() return {
    ["Schlachtfeld"] = true,
    ["Vor"] = true,
    ["Nach"] = true,
} end)

L:RegisterTranslations("enUS", function() return {
    ["Schlachtfeld"] = "Battleground",
    ["Vor"] = "Before",
    ["Nach"] = "After",
} end)
