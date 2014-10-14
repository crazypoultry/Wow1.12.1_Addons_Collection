--[[
  $Id: slashboy @ DreamLand æ≈ﬁº∑Ω÷€ & lasthime @ ∞¨…≠ƒ… ª√ŒÔËÛÃÏ
  $ver: v1.7.001 
  $Date: 2006-09-16 18:00:00
  &Note: Thanks for crowley@headshot.de , the author of Titan Plugin - Item Bonuses.
--]]

StatCompare_classDB = {
	[1] = {
		["DRUID"] = {
			["loc"] = "INVTYPE_HEAD",
			["required"] = {SCS_CLOTH, SCS_LEATHER}
		},
		["ROGUE"] = {
			["loc"] = "INVTYPE_HEAD",
			["required"] = {SCS_CLOTH, SCS_LEATHER}
		},
		["MAGE"] = {
			["loc"] = "INVTYPE_HEAD",
			["required"] = SCS_CLOTH,
		},
		["WARLOCK"] = {
			["loc"] = "INVTYPE_HEAD",
			["required"] = SCS_CLOTH,
		},
		["PRIEST"] = {
			["loc"] = "INVTYPE_HEAD",
			["required"] = SCS_CLOTH,
		},
		["HUNTER"] = {
			["loc"] = "INVTYPE_HEAD",
			["required"] = {SCS_CLOTH, SCS_LEATHER, SCS_MAIL},
		},
		["SHAMAN"] = {
			["loc"] = "INVTYPE_HEAD",
			["required"] = {SCS_CLOTH, SCS_LEATHER, SCS_MAIL},
		},
		["PALADIN"] = {
			["loc"] = "INVTYPE_HEAD",
		},
		["WARRIOR"] = {
			["loc"] = "INVTYPE_HEAD",
		},
	},
	[2] = {
		["DRUID"] = {
			["loc"] = "INVTYPE_NECK",
		},
		["ROGUE"] = {
			["loc"] = "INVTYPE_NECK",
		},
		["MAGE"] = {
			["loc"] = "INVTYPE_NECK",
		},
		["WARLOCK"] = {
			["loc"] = "INVTYPE_NECK",
		},
		["PRIEST"] = {
			["loc"] = "INVTYPE_NECK",
		},
		["HUNTER"] = {
			["loc"] = "INVTYPE_NECK",
		},
		["SHAMAN"] = {
			["loc"] = "INVTYPE_NECK",
		},
		["PALADIN"] = {
			["loc"] = "INVTYPE_NECK",
		},
		["WARRIOR"] = {
			["loc"] = "INVTYPE_NECK",
		},
	},
	[3] = {
		["DRUID"] = {
			["loc"] = "INVTYPE_SHOULDER",
			["required"] = {SCS_CLOTH, SCS_LEATHER}
		},
		["ROGUE"] = {
			["loc"] = "INVTYPE_SHOULDER",
			["required"] = {SCS_CLOTH, SCS_LEATHER}
		},
		["MAGE"] = {
			["loc"] = "INVTYPE_SHOULDER",
			["required"] = SCS_CLOTH,
		},
		["WARLOCK"] = {
			["loc"] = "INVTYPE_SHOULDER",
			["required"] = SCS_CLOTH,
		},
		["PRIEST"] = {
			["loc"] = "INVTYPE_SHOULDER",
			["required"] = SCS_CLOTH,
		},
		["HUNTER"] = {
			["loc"] = "INVTYPE_SHOULDER",
			["required"] = {SCS_CLOTH, SCS_LEATHER, SCS_MAIL}
		},
		["SHAMAN"] = {
			["loc"] = "INVTYPE_SHOULDER",
			["required"] = {SCS_CLOTH, SCS_LEATHER, SCS_MAIL}
		},
		["PALADIN"] = {
			["loc"] = "INVTYPE_SHOULDER",
		},
		["WARRIOR"] = {
			["loc"] = "INVTYPE_SHOULDER",
		},
	},
	[4] = {
		["DRUID"] = {
			["loc"] = "INVTYPE_CLOAK",
		},
		["ROGUE"] = {
			["loc"] = "INVTYPE_CLOAK",
		},
		["MAGE"] = {
			["loc"] = "INVTYPE_CLOAK",
		},
		["WARLOCK"] = {
			["loc"] = "INVTYPE_CLOAK",
		},
		["PRIEST"] = {
			["loc"] = "INVTYPE_CLOAK",
		},
		["HUNTER"] = {
			["loc"] = "INVTYPE_CLOAK",
		},
		["SHAMAN"] = {
			["loc"] = "INVTYPE_CLOAK",
		},
		["PALADIN"] = {
			["loc"] = "INVTYPE_CLOAK",
		},
		["WARRIOR"] = {
			["loc"] = "INVTYPE_CLOAK",
		},
	},
	[5] = {
		["DRUID"] = {
			["loc"] = { "INVTYPE_CHEST", "INVTYPE_ROBE"},
			["required"] = {SCS_CLOTH, SCS_LEATHER}
		},
		["ROGUE"] = {
			["loc"] = { "INVTYPE_CHEST", "INVTYPE_ROBE"},
			["required"] = {SCS_CLOTH, SCS_LEATHER}
		},
		["MAGE"] = {
			["loc"] = { "INVTYPE_CHEST", "INVTYPE_ROBE"},
			["required"] = SCS_CLOTH,
		},
		["WARLOCK"] = {
			["loc"] = { "INVTYPE_CHEST", "INVTYPE_ROBE"},
			["required"] = SCS_CLOTH,
		},
		["PRIEST"] = {
			["loc"] = { "INVTYPE_CHEST", "INVTYPE_ROBE"},
			["required"] = SCS_CLOTH,
		},
		["HUNTER"] = {
			["loc"] = { "INVTYPE_CHEST", "INVTYPE_ROBE"},
			["required"] = {SCS_CLOTH, SCS_LEATHER, SCS_MAIL}
		},
		["SHAMAN"] = {
			["loc"] = { "INVTYPE_CHEST", "INVTYPE_ROBE"},
			["required"] = {SCS_CLOTH, SCS_LEATHER, SCS_MAIL}
		},
		["PALADIN"] = {
			["loc"] = { "INVTYPE_CHEST", "INVTYPE_ROBE"},
		},
		["WARRIOR"] = {
			["loc"] = { "INVTYPE_CHEST", "INVTYPE_ROBE"},
		},
	},
	[8] = {
		["DRUID"] = {
			["loc"] = "INVTYPE_WRIST",
			["required"] = {SCS_CLOTH, SCS_LEATHER}
		},
		["ROGUE"] = {
			["loc"] = "INVTYPE_WRIST",
			["required"] = {SCS_CLOTH, SCS_LEATHER}
		},
		["MAGE"] = {
			["loc"] = "INVTYPE_WRIST",
			["required"] = SCS_CLOTH,
		},
		["WARLOCK"] = {
			["loc"] = "INVTYPE_WRIST",
			["required"] = SCS_CLOTH,
		},
		["PRIEST"] = {
			["loc"] = "INVTYPE_WRIST",
			["required"] = SCS_CLOTH,
		},
		["HUNTER"] = {
			["loc"] = "INVTYPE_WRIST",
			["required"] = {SCS_CLOTH, SCS_LEATHER, SCS_MAIL}
		},
		["SHAMAN"] = {
			["loc"] = "INVTYPE_WRIST",
			["required"] = {SCS_CLOTH, SCS_LEATHER, SCS_MAIL}
		},
		["PALADIN"] = {
			["loc"] = "INVTYPE_WRIST",
		},
		["WARRIOR"] = {
			["loc"] = "INVTYPE_WRIST",
		},
	},
	[9] = {
		["DRUID"] = {
			["loc"] = "INVTYPE_HAND",
			["required"] = {SCS_CLOTH, SCS_LEATHER}
		},
		["ROGUE"] = {
			["loc"] = "INVTYPE_HAND",
			["required"] = {SCS_CLOTH, SCS_LEATHER}
		},
		["MAGE"] = {
			["loc"] = "INVTYPE_HAND",
			["required"] = SCS_CLOTH, 
		},
		["WARLOCK"] = {
			["loc"] = "INVTYPE_HAND",
			["required"] = SCS_CLOTH, 
		},
		["PRIEST"] = {
			["loc"] = "INVTYPE_HAND",
			["required"] = SCS_CLOTH, 
		},
		["HUNTER"] = {
			["loc"] = "INVTYPE_HAND",
			["required"] = {SCS_CLOTH, SCS_LEATHER, SCS_MAIL}
		},
		["SHAMAN"] = {
			["loc"] = "INVTYPE_HAND",
			["required"] = {SCS_CLOTH, SCS_LEATHER, SCS_MAIL}
		},
		["PALADIN"] = {
			["loc"] = "INVTYPE_HAND",
		},
		["WARRIOR"] = {
			["loc"] = "INVTYPE_HAND",
		},
	},
	[10] = {
		["DRUID"] = {
			["loc"] = "INVTYPE_WAIST",
			["required"] = {SCS_CLOTH, SCS_LEATHER}
		},
		["ROGUE"] = {
			["loc"] = "INVTYPE_WAIST",
			["required"] = {SCS_CLOTH, SCS_LEATHER}
		},
		["MAGE"] = {
			["loc"] = "INVTYPE_WAIST",
			["required"] = SCS_CLOTH,
		},
		["WARLOCK"] = {
			["loc"] = "INVTYPE_WAIST",
			["required"] = SCS_CLOTH,
		},
		["PRIEST"] = {
			["loc"] = "INVTYPE_WAIST",
			["required"] = SCS_CLOTH,
		},
		["HUNTER"] = {
			["loc"] = "INVTYPE_WAIST",
			["required"] = {SCS_CLOTH, SCS_LEATHER, SCS_MAIL}
		},
		["SHAMAN"] = {
			["loc"] = "INVTYPE_WAIST",
			["required"] = {SCS_CLOTH, SCS_LEATHER, SCS_MAIL}
		},
		["PALADIN"] = {
			["loc"] = "INVTYPE_WAIST",
		},
		["WARRIOR"] = {
			["loc"] = "INVTYPE_WAIST",
		},
	},
	[11] = {
		["DRUID"] = {
			["loc"] = "INVTYPE_LEGS",
			["required"] = {SCS_CLOTH, SCS_LEATHER}
		},
		["ROGUE"] = {
			["loc"] = "INVTYPE_LEGS",
			["required"] = {SCS_CLOTH, SCS_LEATHER}
		},
		["MAGE"] = {
			["loc"] = "INVTYPE_LEGS",
			["required"] = SCS_CLOTH,
		},
		["WARLOCK"] = {
			["loc"] = "INVTYPE_LEGS",
			["required"] = SCS_CLOTH,
		},
		["PRIEST"] = {
			["loc"] = "INVTYPE_LEGS",
			["required"] = SCS_CLOTH,
		},
		["HUNTER"] = {
			["loc"] = "INVTYPE_LEGS",
			["required"] = {SCS_CLOTH, SCS_LEATHER, SCS_MAIL}
		},
		["SHAMAN"] = {
			["loc"] = "INVTYPE_LEGS",
			["required"] = {SCS_CLOTH, SCS_LEATHER, SCS_MAIL}
		},
		["PALADIN"] = {
			["loc"] = "INVTYPE_LEGS",
		},
		["WARRIOR"] = {
			["loc"] = "INVTYPE_LEGS",
		},
	},
	[12] = {
		["DRUID"] = {
			["loc"] = "INVTYPE_FEET",
			["required"] = {SCS_CLOTH, SCS_LEATHER}
		},
		["ROGUE"] = {
			["loc"] = "INVTYPE_FEET",
			["required"] = {SCS_CLOTH, SCS_LEATHER}
		},
		["MAGE"] = {
			["loc"] = "INVTYPE_FEET",
			["required"] = SCS_CLOTH,
		},
		["WARLOCK"] = {
			["loc"] = "INVTYPE_FEET",
			["required"] = SCS_CLOTH,
		},
		["PRIEST"] = {
			["loc"] = "INVTYPE_FEET",
			["required"] = SCS_CLOTH,
		},
		["HUNTER"] = {
			["loc"] = "INVTYPE_FEET",
			["required"] = {SCS_CLOTH, SCS_LEATHER, SCS_MAIL}
		},
		["SHAMAN"] = {
			["loc"] = "INVTYPE_FEET",
			["required"] = {SCS_CLOTH, SCS_LEATHER, SCS_MAIL}
		},
		["PALADIN"] = {
			["loc"] = "INVTYPE_FEET",
		},
		["WARRIOR"] = {
			["loc"] = "INVTYPE_FEET",
		},
	},
	[13] = {
		["DRUID"] = {
			["loc"] = "INVTYPE_FINGER",
		},
		["ROGUE"] = {
			["loc"] = "INVTYPE_FINGER",
		},
		["MAGE"] = {
			["loc"] = "INVTYPE_FINGER",
		},
		["WARLOCK"] = {
			["loc"] = "INVTYPE_FINGER",
		},
		["PRIEST"] = {
			["loc"] = "INVTYPE_FINGER",
		},
		["HUNTER"] = {
			["loc"] = "INVTYPE_FINGER",
		},
		["PALADIN"] = {
			["loc"] = "INVTYPE_FINGER",
		},
		["SHAMAN"] = {
			["loc"] = "INVTYPE_FINGER",
		},
		["WARRIOR"] = {
			["loc"] = "INVTYPE_FINGER",
		},
	},
	[14] = {
		["DRUID"] = {
			["loc"] = "INVTYPE_FINGER",
		},
		["ROGUE"] = {
			["loc"] = "INVTYPE_FINGER",
		},
		["MAGE"] = {
			["loc"] = "INVTYPE_FINGER",
		},
		["WARLOCK"] = {
			["loc"] = "INVTYPE_FINGER",
		},
		["PRIEST"] = {
			["loc"] = "INVTYPE_FINGER",
		},
		["HUNTER"] = {
			["loc"] = "INVTYPE_FINGER",
		},
		["SHAMAN"] = {
			["loc"] = "INVTYPE_FINGER",
		},
		["PALADIN"] = {
			["loc"] = "INVTYPE_FINGER",
		},
		["WARRIOR"] = {
			["loc"] = "INVTYPE_FINGER",
		},
	},
	[15] = {
		["DRUID"] = {
			["loc"] = "INVTYPE_TRINKET",
		},
		["ROGUE"] = {
			["loc"] = "INVTYPE_TRINKET",
		},
		["MAGE"] = {
			["loc"] = "INVTYPE_TRINKET",
		},
		["WARLOCK"] = {
			["loc"] = "INVTYPE_TRINKET",
		},
		["PRIEST"] = {
			["loc"] = "INVTYPE_TRINKET",
		},
		["HUNTER"] = {
			["loc"] = "INVTYPE_TRINKET",
		},
		["SHAMAN"] = {
			["loc"] = "INVTYPE_TRINKET",
		},
		["PALADIN"] = {
			["loc"] = "INVTYPE_TRINKET",
		},
		["WARRIOR"] = {
			["loc"] = "INVTYPE_TRINKET",
		},
	},
	[16] = {
		["DRUID"] = {
			["loc"] = "INVTYPE_TRINKET",
		},
		["ROGUE"] = {
			["loc"] = "INVTYPE_TRINKET",
		},
		["MAGE"] = {
			["loc"] = "INVTYPE_TRINKET",
		},
		["WARLOCK"] = {
			["loc"] = "INVTYPE_TRINKET",
		},
		["PRIEST"] = {
			["loc"] = "INVTYPE_TRINKET",
		},
		["HUNTER"] = {
			["loc"] = "INVTYPE_TRINKET",
		},
		["SHAMAN"] = {
			["loc"] = "INVTYPE_TRINKET",
		},
		["PALADIN"] = {
			["loc"] = "INVTYPE_TRINKET",
		},
		["WARRIOR"] = {
			["loc"] = "INVTYPE_TRINKET",
		},
	},
	[17] = {
		["DRUID"] = {
			["loc"] = {"INVTYPE_WEAPON", "INVTYPE_2HWEAPON", "INVTYPE_WEAPONMAINHAND"},
			["required"] = {SCS_DAGGERS, SCS_STAVES, SCS_FISTWEAPONS, SCS_OHMACES, SCS_THMACES, SCS_FISHINGPOLE, SCS_MISC},
		},
		["ROGUE"] = {
			["loc"] = {"INVTYPE_WEAPON", "INVTYPE_2HWEAPON", "INVTYPE_WEAPONMAINHAND"},
			["required"] = {SCS_DAGGERS, SCS_OHSWORDS, SCS_OHMACES, SCS_FISTWEAPONS, SCS_FISHINGPOLE, SCS_MISC},
		},
		["MAGE"] = {
			["loc"] = {"INVTYPE_WEAPON", "INVTYPE_2HWEAPON", "INVTYPE_WEAPONMAINHAND"},
			["required"] = {SCS_DAGGERS, SCS_STAVES, SCS_OHSWORDS, SCS_FISHINGPOLE, SCS_MISC},
		},
		["WARLOCK"] = {
			["loc"] = {"INVTYPE_WEAPON", "INVTYPE_2HWEAPON", "INVTYPE_WEAPONMAINHAND"},
			["required"] = {SCS_DAGGERS, SCS_STAVES, SCS_OHSWORDS, SCS_FISHINGPOLE, SCS_MISC},
		},
		["PRIEST"] = {
			["loc"] = {"INVTYPE_WEAPON", "INVTYPE_2HWEAPON", "INVTYPE_WEAPONMAINHAND"},
			["required"] = {SCS_DAGGERS, SCS_STAVES, SCS_OHMACES, SCS_FISHINGPOLE, SCS_MISC},
		},
		["HUNTER"] = {
			["loc"] = {"INVTYPE_WEAPON", "INVTYPE_2HWEAPON", "INVTYPE_WEAPONMAINHAND"},
			["required"] = {SCS_DAGGERS, SCS_OHSWORDS, SCS_THSWORDS, SCS_STAVES, SCS_OHAXES, SCS_THAXES, SCS_FISTWEAPONS, SCS_POLEARMS, SCS_FISHINGPOLE, SCS_MISC},
		},
		["SHAMAN"] = {
			["loc"] = {"INVTYPE_WEAPON", "INVTYPE_2HWEAPON", "INVTYPE_WEAPONMAINHAND"},
			["required"] = {SCS_DAGGERS, SCS_STAVES, SCS_OHAXES, SCS_THAXES, SCS_FISTWEAPONS, SCS_FISHINGPOLE, SCS_MISC},
		},
		["PALADIN"] = {
			["loc"] = {"INVTYPE_WEAPON", "INVTYPE_2HWEAPON", "INVTYPE_WEAPONMAINHAND"},
			["required"] = {SCS_OHMACES, SCS_THMACES, SCS_OHSWORDS, SCS_THSWORDS, SCS_FISHINGPOLE, SCS_OHAXES, SCS_THAXES, SCS_POLEARMS, SCS_MISC},
		},
		["WARRIOR"] = {
			["loc"] = {"INVTYPE_WEAPON", "INVTYPE_2HWEAPON", "INVTYPE_WEAPONMAINHAND"},
			["required"] = {SCS_DAGGERS, SCS_OHSWORDS, SCS_THSWORDS, SCS_OHMACES, SCS_THMACES, SCS_STAVES, SCS_OHAXES, SCS_THAXES, SCS_FISTWEAPONS, SCS_POLEARMS, SCS_FISHINGPOLE, SCS_MISC},
		},
	},
	[18] = {
		["DRUID"] = {
			["loc"] = "INVTYPE_HOLDABLE",
		},
		["ROGUE"] = {
			["loc"] = {"INVTYPE_HOLDABLE", "INVTYPE_WEAPON", "INVTYPE_WEAPONOFFHAND"},
			["required"] = {SCS_DAGGERS,SCS_OHSWORDS, SCS_OHMACES, SCS_FISTWEAPONS, SCS_MISC},
		},
		["MAGE"] = {
			["loc"] = "INVTYPE_HOLDABLE",
		},
		["WARLOCK"] = {
			["loc"] = "INVTYPE_HOLDABLE",
		},
		["PRIEST"] = {
			["loc"] = "INVTYPE_HOLDABLE",
		},
		["HUNTER"] = {
			["loc"] = {"INVTYPE_HOLDABLE", "INVTYPE_WEAPON", "INVTYPE_WEAPONOFFHAND"},
			["required"] = {SCS_DAGGERS,SCS_OHSWORDS, SCS_OHAXES, SCS_FISTWEAPONS, SCS_MISC},
		},
		["SHAMAN"] = {
			["loc"] = {"INVTYPE_HOLDABLE", "INVTYPE_SHIELD"},
			["required"] = {SCS_SHIELD, SCS_MISC},
		},
		["PALADIN"] = {
			["loc"] = {"INVTYPE_HOLDABLE", "INVTYPE_SHIELD"},
			["required"] = {SCS_SHIELD, SCS_MISC},
		},
		["WARRIOR"] = {
			["loc"] = {"INVTYPE_HOLDABLE", "INVTYPE_SHIELD", "INVTYPE_WEAPON", "INVTYPE_WEAPONOFFHAND"},
			["required"] = {SCS_SHIELD, SCS_DAGGERS,SCS_OHSWORDS, SCS_OHMACES, SCS_OHAXES, SCS_FISTWEAPONS, SCS_MISC},
		},
	},
	[19] = {
		["DRUID"] = {
			["loc"] = "INVTYPE_RELIC",
			["required"] = SCS_IDOLS,
		},
		["ROGUE"] = {
			["loc"] = {"INVTYPE_RANGED", "INVTYPE_THROWN"},
		},
		["MAGE"] = {
			["loc"] = "INVTYPE_RANGEDRIGHT",
			["required"] = SCS_WANDS,
		},
		["WARLOCK"] = {
			["loc"] = "INVTYPE_RANGEDRIGHT",
			["required"] = SCS_WANDS,
		},
		["PRIEST"] = {
			["loc"] = "INVTYPE_RANGEDRIGHT",
			["required"] = SCS_WANDS,
		},
		["HUNTER"] = {
			["loc"] = {"INVTYPE_RANGED", "INVTYPE_THROWN"},
		},
		["SHAMAN"] = {
			["loc"] = "INVTYPE_RELIC",
			["required"] = SCS_TOTEMS,
		},
		["PALADIN"] = {
			["loc"] = "INVTYPE_RELIC",
			["required"] = SCS_LIBRAMS,
		},
		["WARRIOR"] = {
			["loc"] = {"INVTYPE_RANGED", "INVTYPE_THROWN"},
		},
	},
};

