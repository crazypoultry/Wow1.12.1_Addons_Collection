--Holds all of the translated information
SORTENCHANT = {}

-- The ace:LoadTranslation() method looks for a specific translation function for the locale
if( not ace:LoadTranslation("SortEnchant") ) then
	--The name of the AddOn
	SORTENCHANT.NAME = "SortEnchant"

	--The command to give to the option setting code to reset that option to the default
	SORTENCHANT.DEFAULT = "default"

	--Used to figure out what kind of enchantment it is
	SORTENCHANT.SEARCHSTRING = "Enchant  ?([^%-]*) %- ([^%s]*) ?(.*)";

	--Holds the various text sources for the status and report messages
	SORTENCHANT.STATUS = {}

	--The text to display for the various settings
	SORTENCHANT.STATUS.LATESTSHOWN = "Lowest shown difficulty item"
	SORTENCHANT.STATUS.GROUPBY     = "Groupings"

	--Holds the various mapping for status and report messages
	SORTENCHANT.MAP = {}

	--The mapping of stored values for LowestShown to readable values
	SORTENCHANT.MAP.LOWESTSHOWN = {
									[1] = "|cFF7F7F7FGrey|r",
									[2] = "|cFF3FBF3FGreen|r",
									[3] = "|cFFFFFF00Yellow|r",
									[4] = "|cFFFF7F3FOrange|r"
								  }

	--The mapping of stored values for GroupBy to readable values
	SORTENCHANT.MAP.GROUPBY		= {
									armor      = "Armor",
									bonus      = "Bonus",
									quantity   = "Quantity",
									difficulty = "Difficulty",
									none       = "None"
								  }

	SORTENCHANT.ARMORDROPDOWN_TITLE = "All Armor";
	SORTENCHANT.BONUSDROPDOWN_TITLE = "All Bonuses";

	-- Chat handler locals
	SORTENCHANT.COMMANDS	= {"/sortenchant"}
	SORTENCHANT.CMD_OPTIONS	= {
		{
			option = "lowestshown",
			desc   = "Sets the lowest difficulty item that is shown in the enchanting window",
			args = {
				{
					option = "grey",
					desc   = "All difficulties of items will be displayed in the enchanting window",
					method = "LowestShown_Grey"
				},
				{
					--This is here to allow both spellings of the word grey to work properly
					option = "gray",
					desc   = "All difficulties of items will be displayed in the enchanting window",
					method = "LowestShown_Grey"
				},	
				{
					option = "green",
					desc   = "The lowest difficulty item shown in the enchanting window will be green",
					method = "LowestShown_Green"
				},
				{
					option = "yellow",
					desc   = "The lowest difficulty item shown in the enchanting window will be yellow",
					method = "LowestShown_Yellow"
				},
				{
					option = "orange",
					desc   = "Only orange items will be shown in the enchanting window",
					method = "LowestShown_Orange"
				},
				{
					option = SORTENCHANT.DEFAULT,
					desc   = "Sets the default value for lowest difficulty shown (grey)",
					method = "LowestShown_Grey"
				}
			}
		},
		{
			option = "groupby",
			desc   = "Sets the type of groupings displayed in the enchanting window",
			args = {
				{
					option = "armor",
					desc   = "Groupings will be set based on type of armor enchanted",
					method = "GroupBy_Armor"
				},
				{
					option = "bonus",
					desc   = "Groupings will be set based on type of bonus given",
					method = "GroupBy_Bonus"
				},
				{
					option = "quantity",
					desc   = "Groupings will be set based on quantity producable",
					method = "GroupBy_Quantity"
				},
				{
					option = "difficulty",
					desc   = "Groupings will be set based on difficulty of the enchantment",
					method = "GroupBy_Difficulty"
				},
				{
					option = "none",
					desc   = "Groupings will be turned off",
					method = "GroupBy_None"
				},
				{
					option = SORTENCHANT.DEFAULT,
					desc   = "Sets the default value for groupings used (armor)",
					method = "GroupBy_Armor"
				}
			}
		}
	}

	SORTENCHANT.DISPLAY = {
		--Tese are all explicitly numbered to make modifing the lists simpler

		armor = {
			[1] = "Boots",
			[2] = "Bracer",
			[3] = "Chest",
			[4] = "Cloak",
			[5] = "Gloves",
			[6] = "Shield",
			[7] = "Weapon",
			[8] = "Misc",

			n = 8
		},

		bonus = {
			[1] = "Agility",
			[2] = "Intellect",
			[3] = "Spirit",
			[4] = "Stamina",
			[5] = "Strength",
			[6] = "Health",
			[7] = "Mana",
			[8] = "Stats",
			[9] = "Defense",
			[10] = "Resistance",
			[11] = "Damage",
			[12] = "Specialty",
			[13] = "Proc",
			[14] = "Skill",
			[15] = "Spell Power",
			[16] = "Misc",

			n = 16
		},

		quantity = {
			[1] = "Lots",
			[2] = "5-10",
			[3] = "1-4",
			[4] = "None",

			n = 4
		},

		difficulty = {
			[1] = "Optimal",
			[2] = "Medium",
			[3] = "Easy",
			[4] = "Trivial",

			n = 4
		},

		none = {
			[1] = "",
			n = 1
		}
	}

	SORTENCHANT.SEARCH = {
		--These are all quoted to make them all look the same
		--Since a couple of them are multiple words

		armor = {
			["Boots"] = 1,
			["Bracer"] = 2,
			["Chest"] = 3,
			["Cloak"] = 4,
			["Gloves"] = 5,
			["Shield"] = 6,
			["Weapon"] = 7,
			["2H Weapon"] = 7,
			[""] = 8
		},

		bonus = {
			["Agility"] = 1,
			["Intellect"] = 2,
			["Spirit"] = 3,
			["Stamina"] = 4,
			["Strength"] = 5,
			["Health"] = 6,
			["Mana"] = 7,
			["Stats"] = 8,
			["Deflect"] = 9,
			["Deflection"] = 9,
			["Defense"] = 9,
			["Protection"] = 9,
			["Absorption"] = 9,
			["Block"] = 9,
			["Resistance"] = 10,
			["Shadow Resistance"] = 10,
			["Fire Resistance"] = 10,
			["Nature Resistance"] = 10,
			["Impact"] = 11,
			["Striking"] = 11,
			["Beastslayer"] = 12,
			["Elemental Slayer"] = 12,
			["Demonslaying"] = 12,
			["Crusader"] = 13,
			["Unholy"] = 13, --Weapon
			["Firey"] = 13, --Weapon
			["Icy"] = 13, --Chill
			["Lifestealing"] = 13,
			["Herbalism"] = 14,
			["Mining"] = 14,
			["Skinning"] = 14,
			["Fishing"] = 14,
			["Riding"] = 14, --Skill
			["Speed"] = 14,
			["Haste"] = 14,
			["Stealth"] = 14,
			["Dodge"] = 14,
			["Subtlety"] = 14,
			["Threat"] = 14,
			["Power"] = 15,
			["Winter's"] = 15,
			[""] = 16,
		},

		quantity = function(self, craftData)
			local numAvailible = craftData[4];
			if numAvailible > 10 then
				return 1;
			elseif (numAvailible > 4) and (numAvailible < 11) then
				return 2;
			elseif (numAvailible > 0) and (numAvailible < 5) then
				return 3;
			else
				return 4;
			end
		end,

		difficulty = function(self, craftData)
			local craftType = craftData[3];
			if craftType == "optimal" then
				return 1;
			elseif craftType == "medium" then
				return 2;
			elseif craftType == "easy" then
				return 3;
			else
				return 4;
			end
		end,

		none = {
			[""] = 1
		}
	}
end