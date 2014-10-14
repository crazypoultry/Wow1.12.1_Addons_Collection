--This function will be ran if we are under the German Locale
--Note that it is completly untranslated
function SortEnchant_Locals_deDE()
	--The name of the AddOn
	SORTENCHANT.NAME = "SortEnchant"

	--The command to give to the option setting code to reset that option to the default
	SORTENCHANT.DEFAULT = "default"

	--Used to figure out what kind of enchantment it is
	SORTENCHANT.SEARCHSTRING = "([^%-]*) %- ([^%s]*) ?(.*)";

	--Holds the various text sources for the status and report messages
	SORTENCHANT.STATUS = {}

	--The text to display for the various settings
	SORTENCHANT.STATUS.LATESTSHOWN = "Lowest shown difficulty item"
	SORTENCHANT.STATUS.GROUPBY     = "Groupings"
	SORTENCHANT.STATUS.EXPANDALL   = "Expand all button"

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
		},
		{
			option = "enable",
			desc   = "Enables SortEnchant, releasing it from a standby state",
			method = "Enable"
		},
		{
			option = "disable",
			desc   = "Disables SortEnchant, putting it into a standby state",
			method = "Disable"
		}
	}

	SORTENCHANT.DISPLAY = {
		--Tese are all explicitly numbered to make modifing the lists simpler

		armor = {
			[1] = "Stiefel";
			[2] = "Armschiene";
			[3] = "Brust";
			[4] = "Umhang";
			[5] = "Handschuhe";
			[6] = "Schild";
			[7] = "Waffe";
			[8] = "Zauberstab";
			[9] = "Gemischt";

			n = 9
		},

		bonus = {
			[1] = "Beweglichkeit";
			[2] = "Intellekt";
			[3] = "Willen";
			[4] = "Ausdauer";
			[5] = "Kraft";
			[6] = "Gesundheit";
			[7] = "Mana";
			[8] = "Werte";
			[9] = "Verteidigung";
			[10] = "Widerstand";
			[11] = "Schaden";
			[12] = "Specialty",
			[13] = "Proc",
			[14] = "Skill",
			[15] = "Spell Power",
			[16] = "Gemischt";

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
			["Stiefel"] = 1,
			["Armschiene"] = 2,
			["Brust"] = 3,
			["Umhang"] = 4,
			["Handschuhe"] = 5,
			["Schild"] = 6,
			["Waffe"] = 7,
			["2H Waffe"] = 7,
			["Zauberstab"] = 8,
			[""] = 9
		},

		bonus = {
			["Beweglichkeit"] = 1,
			["Intellekt"] = 2,
			["Willen"] = 3,
			["Ausdauer"] = 4,
			["Kraft"] = 5,
			["Gesundheit"] = 6,
			["Mana"] = 7,
			["Manaregeneration"] = 7,
			["Werte"] = 8,
			["Verteidigung"] = 9,
			["Abwehr"] = 9,
			["Blocken"] = 9,
			["Schutz"] = 9,
			["Absorption"] = 9,
			["Widerstand"] = 10,
			["Schattenwiderstand"] = 10,
			["Frostwiderstand"] = 10,
			["Feuerwiderstand"] = 10,
			["Naturwiderstand"] = 10,
			["Schaden"] = 11,
			["Einschlag"] = 11,
			["Wildtiert\195\182ter"] = 12,
			["Elementart\195\182ter"] = 12,
			["D\195\164monent\195\182ten"] = 12,
			["Kreuzfahrer"] = 13,
			["Unheilig"] = 13,
			["Feurige"] = 13,
			["Eisiger"] = 13,
			["Lebensdiebstahl"] = 13,
			["Kr\195\164uterkunde"] = 14,
			["Bergbau"] = 14,
			["K\195\188rschnerei"] = 14,
			["Angeln"] = 14,
			["Reitfertigkeit"] = 14,
			["Speed"] = 14, --Could not find
			["Haste"] = 14, --Could not find
			["Verstohlenheit"] = 14,
			["Ausweichen"] = 14,
			["Feingef\195\188hl"] = 14,
			["Bedrohung"] = 14,
			["Zauberkraft"] = 15,
			["Heilkraft"] = 15,
			["Schattenmacht"] = 15,
			["Feuermacht"] = 15,
			["Frostmacht"] = 15,
			["Wintermacht"] = 15,
			[""] = 16,
		},

		quantity = function(self, id)
			local _, _, _, numAvailible = self.Hooks.GetCraftInfo.orig(id);
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

		difficulty = function(self, id)
			local _, _, craftType = self.Hooks.GetCraftInfo.orig(id);
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