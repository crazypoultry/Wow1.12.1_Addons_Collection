--Grab our Locale Library to define our translation
local AceLocale = AceLibrary("AceLocale-2.1")

AceLocale:RegisterTranslation("SortEnchant", "enUS", function() return {
	--Options
	LowestShown = "Lowest Shown",
	LowestShownDesc = "Sets the lowest difficulty item that is shown in the enchanting window",
	GroupBy = "Group By",
	GroupByDesc = "Sets the type of groupings displayed in the enchanting window",

	--Difficulty colors
	Grey = true,
	Green = true,
	Yellow = true,
	Orange = true,

	--Grouping types
	Armor = true,
	Bonus = true,
	Quantity = true,
	Difficulty = true,
	None = true,

	--Header values
	Unknown = true,
	ArmorBoots = "Boots",
	ArmorBracer = "Bracer",
	ArmorChest = "Chest",
	ArmorCloak = "Cloak",
	ArmorGloves = "Gloves",
	ArmorShield = "Shield",
	ArmorWeapon = "Weapon",
	ArmorCrafted = "Crafted Items",
	
	BonusAgility = "Agility",
	BonusIntellect = "Intellect",
	BonusSpirit = "Spirit",
	BonusStamina = "Stamina",
	BonusStrength = "Strength",
	BonusHealth = "Health",
	BonusMana = "Mana",
	BonusStats = "Stats",
	BonusDefense = "Defense",
	BonusResistance = "Resistance",
	BonusDamage = "Damage",
	BonusSpecialty = "Specialty",
	BonusProc = "Proc",
	BonusSkil = "Skill",
	BonusSpellPower = "Spell Power",
	BonusOils = "Oils",
	BonusMisc = "Misc",
	BonusWands = "Wands",
	BonusRods = "Rods",

	QuantityOver10 = "Lots",
	Quantity5to10 = "Few",
	Quantity1to4 = "Couple",
	QuantityNone = "None",

	Difficulty1 = "Optimal",
	Difficulty2 = "Medium",
	Difficulty3 = "Easy",
	Difficulty4 = "Trivial"
}
end)