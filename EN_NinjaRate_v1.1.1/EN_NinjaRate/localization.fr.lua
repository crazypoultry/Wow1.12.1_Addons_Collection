--[[
Enigma Ninja Rate French localization file
2005.09.15.

Thanks to Asmodis @ curse-gaming.com
]]

if (GetLocale() == "frFR") then
	ENR_CLASS_MAGE = "Mage";
	ENR_CLASS_ROGUE = "Voleur";
	ENR_CLASS_HUNTER = "Chasseur";
	ENR_CLASS_PRIEST = "Pr\195\170tre";
	ENR_CLASS_WARRIOR = "Guerrier";
	ENR_CLASS_WARLOCK = "D\195\169moniste";
	ENR_CLASS_PALADIN = "Paladin";
	ENR_CLASS_DRUID = "Druide";
	ENR_CLASS_SHAMAN = "Chaman";
	ENR_PROPERTY_INDEX = {
		[1] = "Agilit\195\169",
		[2] = "Intelligence",
		[3] = "Endurance",
		[4] = "Esprit",
		[5] = "Force",
		[6] = "unknown",  -- need translation here, help!
		[7] = "unknown",  -- need translation here, help!

	}
	ENR_EXTRAPROPERTY_INDEX = {
		[1] = "sortil\195\168ge",
		[2] = "sorts des t\195\169n\195\168bre",
		[3] = "sorts de soin",
		[4] = "sorts de feu",
		[5] = "sorts de givre",
		[6] = "sorts des arcanes",
		[7] = "sorts de la nature",
		[8] = "vie du familier",
		[9] = "[^d] \195\160 la puissance d'attaque",
		[10]= "attaque \195\160 distance",
		[11]= "unknown", -- need translation here, help!
	}
	
	ENR_ITEM_INDEX = {
		[1] = "Tissu",
		[2] = "Cuir",
		[3] = "Mailles",
		[4] = "Plates",
		[5] = "Main droite" .. ENR_ITEMDESC_DELIMITER .. "Hache",
		[6] = "A une main" .. ENR_ITEMDESC_DELIMITER .. "Hache",
		[7] = "Deux mains" .. ENR_ITEMDESC_DELIMITER .. "Hache",
		[8] = "Arc",
		[9] = "Dague",
		[10] = "Main droite" .. ENR_ITEMDESC_DELIMITER .. "Masse",
		[11] = "A une main" .. ENR_ITEMDESC_DELIMITER .. "Masse",
		[12] = "Deux mains" .. ENR_ITEMDESC_DELIMITER .. "Masse",
		[13] = "B\195\162ton",
		[14] = "Main droite" .. ENR_ITEMDESC_DELIMITER .. "Ep\195\169e",
		[15] = "A une main" .. ENR_ITEMDESC_DELIMITER .. "Ep\195\169e",
		[16] = "Deux mains" .. ENR_ITEMDESC_DELIMITER .. "Ep\195\169e",
		[17] = "Arme \195\160 feu",
		[18] = "Baguette",
		[19] = "Armes de jet",
		[20] = "Armes d'hast",
		[21] = "Arme de pugilat",
		[22] = "Arbal\195\168te",
		[23] = "Bouclier",
	}
	
	ENR_SPECIALITEM_INDEX = {
		[1]  = "Gurubashi Coin",
		[2]  = "Hakkari Coin",
		[3]  = "Razzashi Coin",
		[4]  = "Sandfury Coin",
		[5]  = "Skullsplitter Coin",
		[6]  = "Zulian Coin",
		[7]  = "Vilebranch Coin",
		[8]  = "Witherbark Coin",
		[9]  = "Bloodscalp Coin",
		[10] = "Red Hakkari Bijou ",
		[11] = "Orange Hakkari Bijou",
		[12] = "Yellow Hakkari Bijou",
		[13] = "Green Hakkari Bijou",
		[14] = "Bronze Hakkari Bijou",
		[15] = "Blue Hakkari Bijou",
		[16] = "Purple Hakkari Bijou",
		[17] = "Gold Hakkari Bijou",
		[18] = "Silver Hakkari Bijou",
		[19] = "Primal Hakkari Aegis",
		[20] = "Primal Hakkari Bindings",
		[21] = "Primal Hakkari Shawl",
		[22] = "Primal Hakkari Stanchion",
		[23] = "Primal Hakkari Girdle",
		[24] = "Primal Hakkari Kossack",
		[25] = "Primal Hakkari Tabard",
		[26] = "Primal Hakkari Sash",
		[27] = "Primal Hakkari Armsplint ",
	}
	
	ENR_PUBLIC_ITEMS = { "Recipe", "Rezept", "Plans", "Book", "Livre", "Codex", "Recette", "Formula", "Formule", "Formel", "Schematic", "Sch\195\169mas", "Bauplan", "Manual", "Pattern", "Muster", "Manuel"}
	
	ENR_TOOLTIP_PUBLIC = "Objet g\195\169n\195\169rique";
	ENR_TOOLTIP_SUITES = "Cet objet est plut\195\180t pour |cffffcc00%s|r .";
	ENR_TOOLTIP_WARNING = "Ninja Rate n'est qu'une aide.";
	
	ENR_SUGGEST_SAFE = "Suggestion: A prendre.";
	ENR_SUGGEST_NORMAL = "Suggestion: A consid\195\168rer avant tirage.";
	ENR_SUGGEST_DANGER = "Suggestion: Pas pour vous... attention au m\195\169contentement.";
	
	ENR_GROUPTYPE_RAID = "Raid";
	ENR_GROUPTYPE_GROUP = "Groupe";
	ENR_GROUPTYPE_SOLO = "Solitaire";
end;
