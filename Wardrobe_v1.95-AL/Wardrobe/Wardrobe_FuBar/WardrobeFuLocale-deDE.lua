-- do nothing if FuBar2 isn't present
if not FuBar2DB then return end

local L = AceLibrary("AceLocale-2.2"):new("FuBar_WardrobeFu")

L:RegisterTranslations("deDE", function() return {

    ["Wardrobe: "] = "Garderobe: ",

    -- menu items
    ["Show Minimap Icon"] = "Zeige Minimap-Icon",
    ["Show or Hide the standard Wardrobe minimap icon"] = "Zeige Minimap-Icon",
    
    ["Show Text Prefix"] = "Text-Pr\195\164fix zeigen",
    ["Show or Hide the Wardrobe: prefix"] = "Text-Pr\195\164fix zeigen",
    
    -- tooltip
    ["Select your outfit or configure Wardrobe"] = "Ausstattung ausw\195\164hlen oder Garderobe konfigurieren",
} end)