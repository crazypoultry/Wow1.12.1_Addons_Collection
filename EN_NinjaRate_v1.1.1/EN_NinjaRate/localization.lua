-- English translation here
ENR_ITEMDESC_DELIMITER = "##";

-- Translate to exactly the same words of class name displays in game.
ENR_CLASS_MAGE    = "Mage";
ENR_CLASS_ROGUE   = "Rogue";
ENR_CLASS_HUNTER  = "Hunter";
ENR_CLASS_PRIEST  = "Priest";
ENR_CLASS_WARRIOR = "Warrior";
ENR_CLASS_WARLOCK = "Warlock";
ENR_CLASS_PALADIN = "Paladin";
ENR_CLASS_DRUID   = "Druid";
ENR_CLASS_SHAMAN  = "Shaman";

-- Translate to exactly the same words of an item's basic property displays in game tooltips.
ENR_PROPERTY_INDEX = {
	[1] = "+%s*(%d+)%s*Agility",
	[2] = "+%s*(%d+)%s*Intellect",
	[3] = "+%s*(%d+)%s*Stamina",
	[4] = "+%s*(%d+)%s*Spirit",
	[5] = "+%s*(%d+)%s*Strength",
	[6] = "Restores%s*(%d+)%s*mana",
	[7] = "unknown",  -- need translation here, help!
}

-- Translate to exactly the same words of item's extra property desciption in game tooltips.
ENR_EXTRAPROPERTY_INDEX = {
	[1] = "magical spells",
	[2] = "shadow spells",
	[3] = "healing done",
	[4] = "fire spells",
	[5] = "frost spells",
	[6] = "acrane spells",
	[7] = "nature spells",
	[8] = "pet's life",
	[9] = "[^d] attack power",
	[10]= "ranged attack power",
	[11]= "unknown", -- need translation here, help!
}

-- Translate to exactly the same words of item's type displays in game tooltips.
ENR_ITEM_INDEX = {
	[1]  = "Cloth",
	[2]  = "Leather",
	[3]  = "Mail",
	[4]  = "Plate",
	[5]  = "Main Hand" .. ENR_ITEMDESC_DELIMITER .. "Axe",
	[6]  = "One-Hand" .. ENR_ITEMDESC_DELIMITER .. "Axe",
	[7]  = "Two-Hand" .. ENR_ITEMDESC_DELIMITER .. "Axe",
	[8]  = "Bow",
	[9]  = "Dagger",
	[10] = "Main Hand" .. ENR_ITEMDESC_DELIMITER .. "Mace",
	[11] = "One-Hand" .. ENR_ITEMDESC_DELIMITER .. "Mace",
	[12] = "Two-Hand" .. ENR_ITEMDESC_DELIMITER .. "Mace",
	[13] = "Staff",
	[14] = "Main Hand" .. ENR_ITEMDESC_DELIMITER .. "Sword",
	[15] = "One-Hand" .. ENR_ITEMDESC_DELIMITER .. "Sword",
	[16] = "Two-Hand" .. ENR_ITEMDESC_DELIMITER .. "Sword",
	[17] = "Gun",
	[18] = "Wand",
	[19] = "Thrown",
	[20] = "Polearm",
	[21] = "Fist Weapon",
	[22] = "Crossbow",
	[23] = "Shield",
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
	[27] = "Primal Hakkari Armsplint",
}

ENR_PUBLIC_ITEMS = { "Recipe", "Rezept", "Plans", "Book", "Codex", "Recette", "Formula", "Formel", "Schematic", "Bauplan", "Manual", "Pattern", "Muster"}

ENR_CLASS_SUITES = {
	[ENR_CLASS_MAGE]    = ENR_CLASS_MAGE,
	[ENR_CLASS_ROGUE]   = ENR_CLASS_ROGUE,
	[ENR_CLASS_HUNTER]  = ENR_CLASS_HUNTER,
	[ENR_CLASS_PRIEST]  = ENR_CLASS_PRIEST,
	[ENR_CLASS_WARRIOR] = ENR_CLASS_WARRIOR,
	[ENR_CLASS_WARLOCK] = ENR_CLASS_WARLOCK,
	[ENR_CLASS_PALADIN] = ENR_CLASS_PALADIN,
	[ENR_CLASS_DRUID]   = ENR_CLASS_DRUID,
	[ENR_CLASS_SHAMAN]  = ENR_CLASS_SHAMAN,
}

ENR_TOOLTIP_PUBLIC = "Public item";
ENR_TOOLTIP_SUITES = "This item is one of |cffffcc00%s|r class suite.";
ENR_TOOLTIP_WARNING = "Ninja Rate is only for reference.";

ENR_SUGGEST_SAFE   = "Suggestion: Roll it.";
ENR_SUGGEST_NORMAL = "Suggestion: Consider it before you roll.";
ENR_SUGGEST_DANGER = "Suggestion: If you roll, you will probably be considered as a ninja.";

ENR_GROUPTYPE_RAID  = "Raid";
ENR_GROUPTYPE_GROUP = "Party";
ENR_GROUPTYPE_SOLO  = "Solo";

