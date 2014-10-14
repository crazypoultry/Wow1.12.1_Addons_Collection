-- do nothing if FuBar2 isn't present
if not FuBar2DB then return end

local L = AceLibrary("AceLocale-2.2"):new("FuBar_WardrobeFu")

L:RegisterTranslations("frFR", function() return {

    ["Wardrobe: "] = "Wardrobe: ",

    -- menu items
    ["Show Minimap Icon"] = "Montre l'ic\195\180ne de la minicarte",
    ["Show or Hide the standard Wardrobe minimap icon"] = "Montre l'ic\195\180ne de la minicarte",
    
    ["Show Text Prefix"] = "Montrer le pr\195\169fixe des textes ",
    ["Show or Hide the Wardrobe: prefix"] = "Montrer le pr\195\169fixe des textes ",
    
    -- tooltip
    ["Select your outfit or configure Wardrobe"] = "S\195\169lectionnez votre tenue ou configurer Wardrobe",
} end)