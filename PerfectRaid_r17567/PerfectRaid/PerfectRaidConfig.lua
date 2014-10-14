local L = AceLibrary("AceLocale-2.0"):new("PerfectRaid")

PerfectRaid.textures = {
                    otravi			= "Interface\\AddOns\\PerfectRaid\\Textures\\otravi",
                    perl			= "Interface\\AddOns\\PerfectRaid\\Textures\\perl",
                    smooth			= "Interface\\AddOns\\PerfectRaid\\Textures\\smooth",
                    default			= "Interface\\TargetingFrame\\UI-StatusBar",
                    striped			= "Interface\\AddOns\\PerfectRaid\\Textures\\striped",
                    halcyone        = "Interface\\AddOns\\PerfectRaid\\Textures\\halcyone",
                    banto           = "Interface\\AddOns\\PerfectRaid\\Textures\\BantoBar",
                    charcoal        = "Interface\\AddOns\\PerfectRaid\\Textures\\charcoal",
                }
    
PerfectRaid.BCOLORS = {}        
PerfectRaid.BCOLORS["Curse"] 		= {	1, 	0.5, 	0.5, 	1}
PerfectRaid.BCOLORS["Magic"] 		= {	0.5, 	0.5, 	1, 	1}
PerfectRaid.BCOLORS["Poison"] 	    = {	0.5, 	1, 	0.5, 	1}
PerfectRaid.BCOLORS["Disease"] 	    = {	0.75, 0.5, 	0.2, 	1}

PerfectRaid.CLASSES = {}
PerfectRaid.CLASSES["PALADIN"] 	    = "|cFFF48CBA"
PerfectRaid.CLASSES["WARRIOR"] 	    = "|cFFC69B6D"
PerfectRaid.CLASSES["WARLOCK"] 	    = "|cFF9382C9"
PerfectRaid.CLASSES["PRIEST"] 	    = "|cFFFFFFFF"
PerfectRaid.CLASSES["DRUID"] 	    = "|cFFFF7C0A"
PerfectRaid.CLASSES["MAGE"]		    = "|cFF68CCEF"
PerfectRaid.CLASSES["ROGUE"]	    = "|cFFFFF468"
PerfectRaid.CLASSES["SHAMAN"]	    = "|cFFF48CBA"
PerfectRaid.CLASSES["HUNTER"]	    = "|cFFAAD372"

PerfectRaid.STATTEXT = {}
PerfectRaid.STATTEXT["Curse"] 		        = "|cFF9900FF"..L["STATTEXT_Curse"].." |r"
PerfectRaid.STATTEXT["Magic"] 		        = "|cFF3399FF"..L["STATTEXT_Magic"].." |r"
PerfectRaid.STATTEXT["Poison"] 		        = "|cFF009900"..L["STATTEXT_Poison"].." |r"
PerfectRaid.STATTEXT["Disease"] 		    = "|cFF996600"..L["STATTEXT_Disease"].." |r"
PerfectRaid.STATTEXT["LowMana"] 		    = "|cFFFFFF00"..L["STATTEXT_LowMana"].." |r"
PerfectRaid.STATTEXT["FeignDeath"]	        = "|cFF00E6C6"..L["STATTEXT_FeignDeath"].." |r"
PerfectRaid.STATTEXT["Soulstone"]		    = "|cFFCA21FF"..L["STATTEXT_Soulstone"].." |r"
PerfectRaid.STATTEXT["Innervate"]		    = "|cFF00FF33"..L["STATTEXT_Innervate"].." |r"
PerfectRaid.STATTEXT["PowerInfusion"]	    = "|cFF00FF33"..L["STATTEXT_PowerInfusion"].." |r"
PerfectRaid.STATTEXT["Fortitude"]		    = "|cFFFFFFFF"..L["STATTEXT_Fortitude"].." |r"
PerfectRaid.STATTEXT["ShadowProtection"]		    = "|cFF9900FF"..L["STATTEXT_ShadowProtection"].." |r"
PerfectRaid.STATTEXT["Spirit"]              = "|cFF3399CC"..L["STATTEXT_Spirit"].." |r"
PerfectRaid.STATTEXT["Renew"]		        = "|cFF00FF10"..L["STATTEXT_Renew"].." |r"
PerfectRaid.STATTEXT["Shield"]		        = "|cFFFFD800"..L["STATTEXT_Shield"].." |r"
PerfectRaid.STATTEXT["WeakenedSoul"]	    = "|cFFFF5500"..L["STATTEXT_WeakenedSoul"].." |r"
PerfectRaid.STATTEXT["MarkOfWild"]	        = "|cFFbc64aa"..L["STATTEXT_MarkOfWild"].." |r"
PerfectRaid.STATTEXT["Intellect"] 		    = "|cFF3399FF"..L["STATTEXT_Intellect"].." |r"

PerfectRaid.STATTEXT["Regrowth"]	        = "|cFFbc64aa"..L["STATTEXT_Regrowth"].." |r"
PerfectRaid.STATTEXT["Rejuvenation"]	    = "|cFFbc64aa"..L["STATTEXT_Rejuvenation"].." |r"

PerfectRaid.STATTEXT["BoMight"] 		    = "|cFFF48CBA"..L["STATTEXT_BoMight"].." |r"
PerfectRaid.STATTEXT["BoWisdom"] 		    = "|cFFF48CBA"..L["STATTEXT_BoWisdom"].." |r"
PerfectRaid.STATTEXT["BoSalvation"] 		= "|cFFF48CBA"..L["STATTEXT_BoSalvation"].." |r"
PerfectRaid.STATTEXT["BoLight"] 		    = "|cFFF48CBA"..L["STATTEXT_BoLight"].." |r"
PerfectRaid.STATTEXT["BoSanctuary"] 		= "|cFFF48CBA"..L["STATTEXT_BoSanctuary"].." |r"
PerfectRaid.STATTEXT["BoKings"] 		    = "|cFFF48CBA"..L["STATTEXT_BoKings"].." |r"

--[[
<Kirov> DebuffTypeColor = { };
<Kirov> DebuffTypeColor["none"]     = { r = 0.80, g = 0, b = 0 };
<Kirov> DebuffTypeColor["Magic"]     = { r = 0.20, g = 0.60, b = 1.00 };
<Kirov> DebuffTypeColor["Curse"]     = { r = 0.60, g = 0.00, b = 1.00 };
<Kirov> DebuffTypeColor["Disease"]     = { r = 0.60, g = 0.40, b = 0 };
<Kirov> DebuffTypeColor["Poison"]     = { r = 0.00, g = 0.60, b = 0 };
--]]