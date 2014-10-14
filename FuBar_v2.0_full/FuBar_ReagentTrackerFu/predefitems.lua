local L = AceLibrary("AceLocale-2.2"):new("ReagentTracker");

opt_predefitems = {
	type = 'group',
	name = L["OPT_PREDEF_NAME"],
	desc = L["OPT_PREDEF_DESC"],
	order = 11,
	args = {
		druid = {
			type = 'execute',
			name = L["PREDEF_DRUID_NAME"],
			desc = L["PREDEF_DRUID_DESC"],
			func = function()
				ReagentTracker.db.char.item1.item = "Ironwood Seed"
				ReagentTracker.db.char.item1.iwv = 2
				ReagentTracker.db.char.item2.item = "Wild Thornroot"
				ReagentTracker.db.char.item2.iwv = 8
				ReagentTracker.db.char.item3.item = "-"
				ReagentTracker.db.char.item3.iwv = -1
				ReagentTracker.db.char.item4.item = "-"
				ReagentTracker.db.char.item4.iwv = -1
				ReagentTracker.db.char.item5.item = "-"
				ReagentTracker.db.char.item5.iwv = -1
				ReagentTracker.db.char.text.textrt = true
				ReagentTracker.db.char.text.textfa = false
				ReagentTracker.db.char.itemnumber = 2
				ReagentTracker:UpdateItems();
				ReagentTracker:UpdateText();
			end,
		},
		mage = {
			type = 'execute',
			name = L["PREDEF_MAGE_NAME"],
			desc = L["PREDEF_MAGE_DESC"],
			func = function()
				ReagentTracker.db.char.item1.item = "Arcane Powder"
				ReagentTracker.db.char.item1.iwv = 8
				ReagentTracker.db.char.item2.item = "Rune of Teleportation"
				ReagentTracker.db.char.item2.iwv = 3
				ReagentTracker.db.char.item3.item = "Rune of Portals"
				ReagentTracker.db.char.item3.iwv = 3
				ReagentTracker.db.char.item4.item = "Light Feather"
				ReagentTracker.db.char.item4.iwv = 2
				ReagentTracker.db.char.item5.item = "-"
				ReagentTracker.db.char.item5.iwv = -1
				ReagentTracker.db.char.text.textrt = true
				ReagentTracker.db.char.text.textfa = false
				ReagentTracker.db.char.itemnumber = 3
				ReagentTracker:UpdateItems();
				ReagentTracker:UpdateText();
			end,
		},
		hunter_arr = {
			type = 'execute',
			name = L["PREDEF_HUNTER_ARR_NAME"],
			desc = L["PREDEF_HUNTER_ARR_DESC"],
			func = function()
				ReagentTracker.db.char.item1.item = "Jagged Arrow"
				ReagentTracker.db.char.item1.iwv = 1000
				ReagentTracker.db.char.item2.item = "Thorium Headed Arrow"
				ReagentTracker.db.char.item2.iwv = 500
				ReagentTracker.db.char.item3.item = "Doomshot"
				ReagentTracker.db.char.item3.iwv = 250
				ReagentTracker.db.char.item4.item = "-"
				ReagentTracker.db.char.item4.iwv = -1
				ReagentTracker.db.char.item5.item = "-"
				ReagentTracker.db.char.item5.iwv = -1
				ReagentTracker.db.char.text.textrt = true
				ReagentTracker.db.char.text.textfa = false
				ReagentTracker.db.char.itemnumber = 3
				ReagentTracker:UpdateItems();
				ReagentTracker:UpdateText();
			end,
		},
		hunter_pro = {
			type = 'execute',
			name = L["PREDEF_HUNTER_PRO_NAME"],
			desc = L["PREDEF_HUNTER_PRO_DESC"],
			func = function()
				ReagentTracker.db.char.item1.item = "Accurate Slugs"
				ReagentTracker.db.char.item1.iwv = 1000
				ReagentTracker.db.char.item2.item = "Thorium Shells"
				ReagentTracker.db.char.item2.iwv = 500
				ReagentTracker.db.char.item3.item = "Miniature Cannon Balls"
				ReagentTracker.db.char.item3.iwv = 250
				ReagentTracker.db.char.item4.item = "-"
				ReagentTracker.db.char.item4.iwv = -1
				ReagentTracker.db.char.item5.item = "-"
				ReagentTracker.db.char.item5.iwv = -1
				ReagentTracker.db.char.text.textrt = true
				ReagentTracker.db.char.text.textfa = false
				ReagentTracker.db.char.itemnumber = 3
				ReagentTracker:UpdateItems();
				ReagentTracker:UpdateText();
			end,
		},
		priest = {
			type = 'execute',
			name = L["PREDEF_PRIEST_NAME"],
			desc = L["PREDEF_PRIEST_DESC"],
			func = function()
				ReagentTracker.db.char.item1.item = "Sacred Candel"
				ReagentTracker.db.char.item1.iwv = 8
				ReagentTracker.db.char.item2.item = "-"
				ReagentTracker.db.char.item2.iwv = -1
				ReagentTracker.db.char.item3.item = "-"
				ReagentTracker.db.char.item3.iwv = -1
				ReagentTracker.db.char.item4.item = "-"
				ReagentTracker.db.char.item4.iwv = -1
				ReagentTracker.db.char.item5.item = "-"
				ReagentTracker.db.char.item5.iwv = -1
				ReagentTracker.db.char.text.textrt = true
				ReagentTracker.db.char.text.textfa = false
				ReagentTracker.db.char.itemnumber = 1
				ReagentTracker:UpdateItems();
				ReagentTracker:UpdateText();
			end,
		},
		twilight = {
			type = 'execute',
			name = L["PREDEF_TWILIGHT_NAME"],
			desc = L["PREDEF_TWILIGHT_DESC"],
			func = function()
				ReagentTracker.db.char.item1.item = "Encrypted Twilight Text"
				ReagentTracker.db.char.item1.iwv = -1
				ReagentTracker.db.char.item2.item = "Abyssal Crest"
				ReagentTracker.db.char.item2.iwv = -1
				ReagentTracker.db.char.item3.item = "Abyssal Signet"
				ReagentTracker.db.char.item3.iwv = -1
				ReagentTracker.db.char.item4.item = "Abyssal ?"
				ReagentTracker.db.char.item4.iwv = -1
				ReagentTracker.db.char.item5.item = "-"
				ReagentTracker.db.char.item5.iwv = -1
				ReagentTracker.db.char.text.textrt = true
				ReagentTracker.db.char.text.textfa = false
				ReagentTracker.db.char.itemnumber = 4
				ReagentTracker:UpdateItems();
				ReagentTracker:UpdateText();
			end,
		},
	},
}