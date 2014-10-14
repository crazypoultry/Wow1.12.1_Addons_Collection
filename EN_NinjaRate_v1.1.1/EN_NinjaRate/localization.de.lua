--[[
Enigma Ninja Rate German localization file
2005.09.15.

Thanks to Asmodis @ curse-gaming.com
]]

if (GetLocale() == "deDE") then
	ENR_CLASS_MAGE = "Magier";
	ENR_CLASS_ROGUE = "Schurke";
	ENR_CLASS_HUNTER = "J\195\164ger";
	ENR_CLASS_PRIEST = "Priester";
	ENR_CLASS_WARRIOR = "Krieger";
	ENR_CLASS_WARLOCK = "Hexenmeister";
	ENR_CLASS_PALADIN = "Paladin";
	ENR_CLASS_DRUID = "Druide";
	ENR_CLASS_SHAMAN = "Schamane";
	
	ENR_PROPERTY_INDEX = {
		[1] = "+%s*(%d+)%s*Beweglichkeit",
		[2] = "+%s*(%d+)%s*Intelligenz",
		[3] = "+%s*(%d+)%s*Ausdauer",
		[4] = "+%s*(%d+)%s*Willenskraft",
		[5] = "+%s*(%d+)%s*St\195\164rke",
		[6] = "Stellt%s*(%d+)%s*Punkt(e) Mana",
		[7] = "unknown",  -- need translation here, help!
	}
	
	ENR_EXTRAPROPERTY_INDEX = {
		[1] = "magische Zauber",
		[2] = "Schattenzauber",
		[3] = "verursachte Heilung",
		[4] = "Feuerzauber",
		[5] = "Frostzauber",
		[6] = "Arkanzauber",
		[7] = "Naturzauber",
		[8] = "Leben des Begleiters",
		[9] = "Angriffskraft",
		[10]= "Distanzangriffsktraft",
		[11]= "unknown", -- need translation here, help!
	}
	
	ENR_ITEM_INDEX = {
		[1] = "Stoff",
		[2] = "Leder",
		[3] = "Schwere R\195\188stung",
		[4] = "Platte",
		[5] = "Waffenhand" .. ENR_ITEMDESC_DELIMITER .. "Axt",
		[6] = "Einh\195\164ndig" .. ENR_ITEMDESC_DELIMITER .. "Axt",
		[7] = "Zweih\195\164ndig" .. ENR_ITEMDESC_DELIMITER .. "Axt",
		[8] = "Bogen",
		[9] = "Dolch",
		[10] = "Waffenhand" .. ENR_ITEMDESC_DELIMITER .. "Streitkolben",
		[11] = "Einh\195\164ndig" .. ENR_ITEMDESC_DELIMITER .. "Streitkolben",
		[12] = "Zweih\195\164ndig" .. ENR_ITEMDESC_DELIMITER .. "Streitkolben",
		[13] = "Stab",
		[14] = "Waffenhand" .. ENR_ITEMDESC_DELIMITER .. "Schwert",
		[15] = "Einh\195\164ndig" .. ENR_ITEMDESC_DELIMITER .. "Schwert",
		[16] = "Zweih\195\164ndig" .. ENR_ITEMDESC_DELIMITER .. "Schwert",
		[17] = "Schusswaffe",
		[18] = "Zauberstab",
		[19] = "Geworfen",
		[20] = "Stangenwaffe",
		[21] = "Faustwaffe",
		[22] = "Armbrust",
		[23] = "Schild",
	}
	
	ENR_SPECIALITEM_INDEX = {
		[1] = "M\195\188nze der Gurubashi",
		[2] = "M\195\188nze der Hakkari",
		[3] = "M\195\188nze der Razzashi",
		[4] = "M\195\188nze der Sandfury",
		[5] = "M\195\188nze der Skullsplitter",
		[6] = "Zulianische M\195\188nze",
		[7] = "M\195\188nze der Vilebranch",
		[8] = "M\195\188nze der Witherbark",
		[9] = "M\195\188nze der Bloodscalp",
		[10] = "Rotes Schmuckst\195\188ck der Hakkari",
		[11] = "Orangefarbenes Schmuckst\195\188ck der Hakkari",
		[12] = "Gelbes Schmuckst\195\188ck der Hakkari",
		[13] = "Gr\195\188nes Schmuckst\195\188ck der Hakkari",
		[14] = "Bronzefarbenes Schmuckst\195\188ck der Hakkari",
		[15] = "Blaues Schmuckst\195\188ck der Hakkari",
		[16] = "Lilanes Schmuckst\195\188ck der Hakkari",
		[17] = "Goldenes Schmuckst\195\188ck der Hakkari",
		[18] = "Silbernes Schmuckst\195\188ck der Hakkari",
		[19] = "Urzeitlicher Aegis der Hakkari",
		[20] = "Urzeitliche Hakkaribindungen",
		[21] = "Urzeitlicher Hakkarischal",
		[22] = "Urzeitliche Hakkarist\195\188tze",
		[23] = "Urzeitlicher Hakkarigurt",
		[24] = "Urzeitlicher Hakkarikosak",
		[25] = "Urzeitlicher Hakkariwappenrock",
		[26] = "Urzeitliche Hakkarisch\195\164rpe",
		[27] = "Urzeitliche Hakkariarmsplinte",
	}
	
	ENR_PUBLIC_ITEMS = { "Rezept", "Plan", "Buch", "Kodex", "Formel", "Bauplan", "Muster"}
	
	ENR_CLASS_SUITES = {
		[ENR_CLASS_MAGE] = ENR_CLASS_MAGE,
		[ENR_CLASS_ROGUE] = ENR_CLASS_ROGUE,
		[ENR_CLASS_HUNTER] = ENR_CLASS_HUNTER,
		[ENR_CLASS_PRIEST] = ENR_CLASS_PRIEST,
		[ENR_CLASS_WARRIOR] = ENR_CLASS_WARRIOR,
		[ENR_CLASS_WARLOCK] = ENR_CLASS_WARLOCK,
		[ENR_CLASS_PALADIN] = ENR_CLASS_PALADIN,
		[ENR_CLASS_DRUID] = ENR_CLASS_DRUID,
		[ENR_CLASS_SHAMAN] = ENR_CLASS_SHAMAN,
	}
	
	ENR_TOOLTIP_PUBLIC = "Public item";
	ENR_TOOLTIP_SUITES = "This item is one of |cffffcc00%s|r class suite.";
	ENR_TOOLTIP_WARNING = "Ninja Rate is only for reference.";
	
	ENR_SUGGEST_SAFE = "Empfehlung: Du kannst w\195\188rfeln.";
	ENR_SUGGEST_NORMAL = "Empfehlung: \195\156berlege gut bevor Du w\195\188rfelst.";
	ENR_SUGGEST_DANGER = "Empfehlung: Nicht w\195\188rfeln.";
	
	ENR_GROUPTYPE_RAID = "Schlachtzug";
	ENR_GROUPTYPE_GROUP = "Gruppe";
	ENR_GROUPTYPE_SOLO = "Solo";
end;
