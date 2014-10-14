--[[

	File containing localized strings
	for Simplified Chinese and English versions, defaults to English

]]

function SC_BuffLocalization_enUS()
	-- English localized variables (default)
	-- general

	STATCOMPARE_BUFF_PATTERNS = {
		-- Mark of the Wild buff
		{ pattern = "Increases armor by (%d+)%.", effect = "ARMOR"},
		{ pattern = "Increases armor by 65 and all attributes by 2%.",
			effect = {"ARMOR", "STR", "AGI", "STA", "INT", "SPI"},
			value = {65, 2, 2, 2, 2, 2}},
		{ pattern = "Increases armor by 105 and all attributes by 4%.", 
			effect = {"ARMOR", "STR", "AGI", "STA", "INT", "SPI"},
			value = {105, 4, 4, 4, 4, 4}},
		{ pattern = "Increases armor by 150, all attributes by 6 and all resistances by 5%.",
			effect = {"ARMOR", "STR", "AGI", "STA", "INT", "SPI", "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"},
			value = {150, 6, 6, 6, 6, 6, 5, 5, 5, 5, 5}},
		{ pattern = "Increases armor by 195, all attributes by 8 and all resistances by 10%.",
			effect = {"ARMOR", "STR", "AGI", "STA", "INT", "SPI", "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"},
			value = {195, 8, 8, 8, 8, 8, 10, 10, 10, 10, 10}},
		{ pattern = "Increases armor by 240, all attributes by 10 and all resistances by 15%.",
			effect = {"ARMOR", "STR", "AGI", "STA", "INT", "SPI", "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"},
			value = {240, 10, 10, 10, 10, 10, 15, 15, 15, 15, 15}},
		{ pattern = "Increases armor by 285, all attributes by 12 and all resistances by 20%.",
			effect = {"ARMOR", "STR", "AGI", "STA", "INT", "SPI", "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"},
			value = {285, 12, 12, 12, 12, 12, 20, 20, 20, 20, 20}},	
	};
end