local AceLocale = AceLibrary("AceLocale-2.2"):new("ReagentTracker")

AceLocale:RegisterTranslations("enUS", function() return {
	--**Slash Commands, do not change!
        ["SLASHCMD_LONG"] = "/reagenttracker",
        ["SLASHCMD_SHORT"] = "/rt",

	--**Item texts
	["OPT_ITEM1_NAME"] = "Itemname",
	["OPT_ITEM1_DESC"] = "The 1st Item to track.",
	["OPT_ITEM1_USAGE"] = "<Itemname>",

	["OPT_I1WV_NAME"] = "Item 1 Warn Value",
	["OPT_I1WV_DESC"] = "Warn if your Itemcount gets under this value (Use -1 to disable).",
	["OPT_I1WV_USAGE"] = "<Value>",
	
	["OPT_ITEM2_NAME"] = "Itemname",
	["OPT_ITEM2_DESC"] = "The 2nd Item to track.",
	["OPT_ITEM2_USAGE"] = "<Itemname>",

	["OPT_I2WV_NAME"] = "Item 2 Warn Value",
	["OPT_I2WV_DESC"] = "Warn if your Itemcount gets under this value (Use -1 to disable).",
	["OPT_I2WV_USAGE"] = "<Value>",

	["OPT_ITEM3_NAME"] = "Itemname",
	["OPT_ITEM3_DESC"] = "The 3rd Item to track.",
	["OPT_ITEM3_USAGE"] = "<Itemname>",

	["OPT_I3WV_NAME"] = "Item 3 Warn Value",
	["OPT_I3WV_DESC"] = "Warn if your Itemcount gets under this value (Use -1 to disable).",
	["OPT_I3WV_USAGE"] = "<Value>",

	["OPT_ITEM4_NAME"] = "Itemname",
	["OPT_ITEM4_DESC"] = "The 4th Item to track.",
	["OPT_ITEM4_USAGE"] = "<Itemname>",

	["OPT_I4WV_NAME"] = "Item 4 Warn Value",
	["OPT_I4WV_DESC"] = "Warn if your Itemcount gets under this value (Use -1 to disable).",
	["OPT_I4WV_USAGE"] = "<Value>",

	["OPT_ITEM5_NAME"] = "Itemname",
	["OPT_ITEM5_DESC"] = "The 5th Item to track.",
	["OPT_ITEM5_USAGE"] = "<Itemname>",

	["OPT_I5WV_NAME"] = "Item 5 Warn Value",
	["OPT_I5WV_DESC"] = "Warn if your Itemcount gets under this value (Use -1 to disable).",
	["OPT_I5WV_USAGE"] = "<Value>",

	["OPT_ITEM1G_DESC"] = "Settings for Item 1.",
	["OPT_ITEM2G_DESC"] = "Settings for Item 2.",
	["OPT_ITEM3G_DESC"] = "Settings for Item 3.",
	["OPT_ITEM4G_DESC"] = "Settings for Item 4.",
	["OPT_ITEM5G_DESC"] = "Settings for Item 5.",

	["OPT_ITEMS_NAME"] = "Items",
	["OPT_ITEMS_DESC"] = "How many Items should be tracked?",

	--**PreDefItem texts
	["OPT_PREDEF_NAME"] = "Predefined Items",
	["OPT_PREDEF_DESC"] = "A collection of predefined Itemsets.",

	["PREDEF_DRUID_NAME"] = "Druid",
	["PREDEF_DRUID_DESC"] = "Set for Druid Items.",
	["PREDEF_MAGE_NAME"] = "Mage",
	["PREDEF_MAGE_DESC"] = "Set for Mage Items.",
	["PREDEF_HUNTER_ARR_NAME"] = "Hunter (Arrows)",
	["PREDEF_HUNTER_ARR_DESC"] = "Set for Hunter Items.",
	["PREDEF_HUNTER_PRO_NAME"] = "Hunter (Bullets)",
	["PREDEF_HUNTER_PRO_DESC"] = "Set for Hunter Items.",
	["PREDEF_PRIEST_NAME"] = "Priest",
	["PREDEF_PRIEST_DESC"] = "Set for Priest Items.",
	["PREDEF_TWILIGHT_NAME"] = "Twilight",
	["PREDEF_TWILIGHT_DESC"] = "Set for Cenarion Circle reputation Items.",

	--**Warning texts
	["WARNINGVALUE1"] = "You're running out of ",

	["OPT_WARNCHAT_NAME"] = "Chatwarning",
	["OPT_WARNCHAT_DESC"] = "Display warning in Chat?",

	["OPT_WARNSCT_NAME"] = "SCT-Warning",
	["OPT_WARNSCT_DESC"] = "Display warning in SCT?",

	["OPT_WARNUIE_NAME"] = "UI-Error-Warning",
	["OPT_WARNUIE_DESC"] = "Display warning in UI-Errors-Frame?",

	--**Faction texts
	["FACTION_STANDINGS"] = "Factiontracker",
	["FACTION_LEFT"] = "left",
	["FACTION_REPNAME_0"] = "Not Aviable",
	["FACTION_REPNAME_1"] = "Hated",
	["FACTION_REPNAME_2"] = "Hostile",
	["FACTION_REPNAME_3"] = "Unfriendly",
	["FACTION_REPNAME_4"] = "Neutral",
	["FACTION_REPNAME_5"] = "Friendly",
	["FACTION_REPNAME_6"] = "Honored",
	["FACTION_REPNAME_7"] = "Revered",
	["FACTION_REPNAME_8"] = "Exalted",

	["FACTION_CENARION"] = "Cenarion Circle",
	["FACTION_CENARION_LEFT_TEXT"] = "Texts left",
	["FACTION_CENARION_LEFT_CREST"] = "Crests left",

	["FACTION_ZANDALAR"] = "Zandalar Tribe",
	["FACTION_ZANDALAR_BIJOU_DESTROY"] = "destroyed Bijous left",

	--**Misc. Texts
	["TEXT_DESC"] = "What should be displayed in FuBar?",
	["TEXT_RT_NAME"] = "Itemcount",
	["TEXT_RT_DESC"] = "Itemcount will be displayed.",
	["TEXT_FA_NAME"] = "Factionstatus",
	["TEXT_FA_DESC"] = "Factionstatus will be displayed.",
	["IWV_OFF"] = "off",
	["DEBUG_NAME"] = "Debug",
	["DEBUG_DESC"] = "Toggles debug messages (spam!)",
    }
end)