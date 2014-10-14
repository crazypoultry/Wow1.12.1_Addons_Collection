--This function will be ran if we are under the French Locale
--Note that it is completly untranslated
function SortEnchant_Locals_frFR()
	--The name of the AddOn
	SORTENCHANT.NAME = "SortEnchant"

	--The command to give to the option setting code to reset that option to the default
	SORTENCHANT.DEFAULT = "default"

	--Used to figure out what kind of enchantment it is
	SORTENCHANT.SEARCHSTRING = "Enchantement de ([^%(]*) %(([^%s]*) ?(.[^%)])%)";

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
			[1] = "Bottes",
			[2] = "Bracelets",
			[3] = "Plastron",
			[4] = "Cape",
			[5] = "Gants",
			[6] = "Bouclier",
			[7] = "Arme",
			[8] = "Baguette",
			[9] = "Misc",

			n = 9
		},

		bonus = {
			[1] = "Agilit\195\169",
			[2] = "Intelligence",
			[3] = "Esprit",
			[4] = "Endurance",
			[5] = "Force",
			[6] = "Vie",
			[7] = "Mana",
			[8] = "Caract\195\169ristiques",
			[9] = "D\195\169fense",
			[10] = "R\195\169sistance",
			[11] = "Frappe",
			[12] = "Tueur",
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
			["bottes"] = 1,
			["bracelets"] = 2,
			["plastron"] = 3,
			["cape"] = 4,
			["gants"] = 5,
			["bouclier"] = 6,
			["d\226\128\153arme"] = 7,
			["d\226\128\153arme 2M"] = 7,
			["baguette"] = 8,
			[""] = 9
		},

		bonus = {
			["Agilit\195\169"] = 1,
			["Intelligence"] = 2,
			["Esprit"] = 3,
			["Endurance"] = 4,
			["Force"] = 5,
			["Sant\195\169"] = 6,
			["Mana"] = 7,
			["R\195\169g\195\169n\195\169ration"] = 7,
			["Caract\195\169ristiques"] = 8,
			["D\195\169fense"] = 9,
			["Protection"] = 9,
			["Blocage"] = 9,
			["D\195\169viation"] = 9,
			["Absorption"] = 9,
			["R\195\169sistance"] = 10,
			["Impact"] = 11,
			["Frappe"] = 11,
			["Tueur"] = 12,
			["Crois\195\169"] = 13,
			["Impie"] = 13,
			["flamboyante"] = 13,
			["Frisson"] = 13,
			["Vol"] = 13,
			["Herboristerie"] = 14,
			["Minage"] = 14,
			["D\195\169pe\195\167age"] = 14,
			["P\195\170che"] = 14,
			["Equitation"] = 14,
			["Speed"] = 14, --Could not find
			["Haste"] = 14, --Could not find
			["Camouflage"] = 14,
			["Esquive"] = 14,
			["Discr\195\169tion"] = 14,
			["Menace"] = 14,
			["Puissance"] = 15,
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

--My cheat sheet of character codes
-- â = \195\162
-- à = \195\160
-- ä = \195\164
-- Ä = \195\132
-- ê = \195\170
-- è = \195\168
-- é = \195\169
-- î = \195\174
-- ö = \195\182
-- Ö = \195\150
-- û = \195\187
-- ü = \195\188
-- Ü = \195\156
-- ß = \195\159
-- ç = \195\167
-- ' = \226\128\153