-- do nothing if FuBar2 isn't present
if not FuBar2DB then return end

local L = AceLibrary("AceLocale-2.2"):new("FuBar_WardrobeFu")

L:RegisterTranslations("enUS", function() return {

    ["Wardrobe: "] = true,

    -- menu items
    ["Show Minimap Icon"] = true,
    ["Show or Hide the standard Wardrobe minimap icon"] = true,
    
    ["Show Text Prefix"] = true,
    ["Show or Hide the Wardrobe: prefix"] = true,
    
    -- tooltip
    ["Select your outfit or configure Wardrobe"] = true,
} end)