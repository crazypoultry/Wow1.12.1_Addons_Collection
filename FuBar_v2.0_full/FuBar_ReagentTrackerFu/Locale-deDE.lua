local AceLocale = AceLibrary("AceLocale-2.2"):new("ReagentTracker")

AceLocale:RegisterTranslations("deDE", function() return {

        ["SLASHCMD_LONG"] = "/reagenttracker",
        ["SLASHCMD_SHORT"] = "/rt",

	["OPT_ITEM1_NAME"] = "Itemname",
	["OPT_ITEM1_DESC"] = "Erstes zu z\195\164hlendes Item.",
	["OPT_ITEM1_USAGE"] = "<Itemname>",

	["OPT_I1WV_NAME"] = "Item 1 Warnwert",
	["OPT_I1WV_DESC"] = "Warnt dich, wenn du weniger Items hast, als eingestellt (-1 um auszuschalten).",
	["OPT_I1WV_USAGE"] = "<Wert>",
	
	["OPT_ITEM2_NAME"] = "Itemname",
	["OPT_ITEM2_DESC"] = "Zweites zu z\195\164hlendes Item.",
	["OPT_ITEM2_USAGE"] = "<Itemname>",

	["OPT_I2WV_NAME"] = "Item 2 Warnwert",
	["OPT_I2WV_DESC"] = "Warnt dich, wenn du weniger Items hast, als eingestellt (-1 um auszuschalten).",
	["OPT_I2WV_USAGE"] = "<Wert>",
	
	["OPT_ITEM3_NAME"] = "Itemname",
	["OPT_ITEM3_DESC"] = "Drittes zu z\195\164hlendes Item.",
	["OPT_ITEM3_USAGE"] = "<Itemname>",

	["OPT_I3WV_NAME"] = "Item 3 Warnwert",
	["OPT_I3WV_DESC"] = "Warnt dich, wenn du weniger Items hast, als eingestellt (-1 um auszuschalten).",
	["OPT_I3WV_USAGE"] = "<Wert>",

	["OPT_ITEM4_NAME"] = "Itemname",
	["OPT_ITEM4_DESC"] = "Viertes zu z\195\164hlendes Item.",
	["OPT_ITEM4_USAGE"] = "<Itemname>",

	["OPT_I4WV_NAME"] = "Item 4 Warnwert",
	["OPT_I4WV_DESC"] = "Warnt dich, wenn du weniger Items hast, als eingestellt (-1 um auszuschalten).",
	["OPT_I4WV_USAGE"] = "<Wert>",

	["OPT_ITEM5_NAME"] = "Itemname",
	["OPT_ITEM5_DESC"] = "F\195\188nftes zu z\195\164hlendes Item.",
	["OPT_ITEM5_USAGE"] = "<Itemname>",

	["OPT_I5WV_NAME"] = "Item 5 Warnwert",
	["OPT_I5WV_DESC"] = "Warnt dich, wenn du weniger Items hast, als eingestellt (-1 um auszuschalten).",
	["OPT_I5WV_USAGE"] = "<Wert>",

	["WARNINGVALUE1"] = "Du hast nur noch wenig ",

	["OPT_ITEM1G_DESC"] = "Einstellungen f\195\188r Item 1.",
	["OPT_ITEM2G_DESC"] = "Einstellungen f\195\188r Item 2.",
	["OPT_ITEM3G_DESC"] = "Einstellungen f\195\188r Item 3.",
	["OPT_ITEM4G_DESC"] = "Einstellungen f\195\188r Item 4.",
	["OPT_ITEM5G_DESC"] = "Einstellungen f\195\188r Item 5.",

	["OPT_ITEMS_NAME"] = "Items",
	["OPT_ITEMS_DESC"] = "Wieviele Items sollen gez\195\164hlt werden?",

	["OPT_PREDEF_NAME"] = "Vordefinierte Items",
	["OPT_PREDEF_DESC"] = "Eine Sammlung von vordefinierten Itemsets.",

	["PREDEF_DRUID_NAME"] = "Druide",
	["PREDEF_DRUID_DESC"] = "Set für Druiden Items.",
	["PREDEF_MAGE_NAME"] = "Maiere",
	["PREDEF_MAGE_DESC"] = "Set für Magier Items.",
	["PREDEF_HUNTER_ARR_NAME"] = "J\195\164ger (Pfeile)",
	["PREDEF_HUNTER_ARR_DESC"] = "Set für J\195\164ger Items.",
	["PREDEF_HUNTER_PRO_NAME"] = "J\195\164ger (Patronen)",
	["PREDEF_HUNTER_PRO_DESC"] = "Set für J\195\164ger Items.",
	["PREDEF_PRIEST_NAME"] = "Priester",
	["PREDEF_PRIEST_DESC"] = "Set für Priester Items.",
	["PREDEF_TWILIGHT_NAME"] = "Twilight",
	["PREDEF_TWILIGHT_DESC"] = "Set für Zirkel des Cenarius Ruf Items.",

	["OPT_WARNCHAT_NAME"] = "Chatwarnung",
	["OPT_WARNCHAT_DESC"] = "Warnung im Chat anzeigen?",

	["OPT_WARNSCT_NAME"] = "SCT-Warnung",
	["OPT_WARNSCT_DESC"] = "Warnung im SCT anzeigen?",

	["OPT_WARNUIE_NAME"] = "UI-Error-Warnung",
	["OPT_WARNUIE_DESC"] = "Warnung im UI-Errors Frame anzeigen?",

	["FACTION_STANDINGS"] = "Fraktionsanzeige",
	["FACTION_LEFT"] = "verbleibend",
	["FACTION_REPNAME_0"] = "Nicht verf\195\188gbar",
	["FACTION_REPNAME_1"] = "Hasserf\195\188llt",
	["FACTION_REPNAME_2"] = "Feindseelig",
	["FACTION_REPNAME_3"] = "Unfreundlich",
	["FACTION_REPNAME_4"] = "Neutral",
	["FACTION_REPNAME_5"] = "Freundlich",
	["FACTION_REPNAME_6"] = "Wohlwollend",
	["FACTION_REPNAME_7"] = "Respektvoll",
	["FACTION_REPNAME_8"] = "Ehrf\195\188rchtig",

	["FACTION_CENARION"] = "Zirkel des Cenarius",
	["FACTION_CENARION_LEFT_TEXT"] = "Texte verbleibend",
	["FACTION_CENARION_LEFT_CREST"] = "Wappen verbleibend",

	["FACTION_ZANDALAR"] = "Stamm der Zandalar",
	["FACTION_ZANDALAR_BIJOU_DESTROY"] = "verbleibende Schmuckst\195\188ck Zerst rungen ",

	["TEXT_DESC"] = "Was soll in FuBar angezeigt werden??",
	["TEXT_RT_NAME"] = "Itemanzahl",
	["TEXT_RT_DESC"] = "Itemanzahl wird angezeigt.",
	["TEXT_FA_NAME"] = "Fraktionsstatus",
	["TEXT_FA_DESC"] = "Fraktionsstatus wird angezeigt.",
	["IWV_OFF"] = "aus",
	["DEBUG_NAME"] = "Debug",
	["DEBUG_DESC"] = "Debugnachrichten anzeigen? (spam!)",
    }
end)