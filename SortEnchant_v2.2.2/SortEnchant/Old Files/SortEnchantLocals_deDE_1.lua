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
	SORTENCHANT.STATUS.LATESTSHOWN = "Niedrigst angezeigter Schwierigkeitsgrad"
	SORTENCHANT.STATUS.GROUPBY     = "Sortierung"

	--Holds the various mapping for status and report messages
	SORTENCHANT.MAP = {}

	--The mapping of stored values for LowestShown to readable values
	SORTENCHANT.MAP.LOWESTSHOWN = {
									[1] = "|cFF7F7F7FGrau|r",
									[2] = "|cFF3FBF3FGr\195\188n|r",
									[3] = "|cFFFFFF00Gelb|r",
									[4] = "|cFFFF7F3FOrange|r"
								  }

	--The mapping of stored values for GroupBy to readable values
	SORTENCHANT.MAP.GROUPBY		= {
									armor      = "R\195\188stung",
									bonus      = "Verzauberung",
									quantity   = "Verf\195\188gbarkeit",
									difficulty = "Schwierigkeitsgrad",
									none       = "Keine"
								  }

	SORTENCHANT.ARMORDROPDOWN_TITLE = "Alle R\195\188stungsteile";
	SORTENCHANT.BONUSDROPDOWN_TITLE = "Alle Verzauberungen";

	-- Chat handler locals
	SORTENCHANT.COMMANDS	= {"/sortenchant"}
	SORTENCHANT.CMD_OPTIONS	= {
		{
			option = "schwierigkeitsgrad",
			desc   = "Stellt ein, ab welchem Schwierigkeitsgrad die Verzauberungen im Verzauberkunstfenster angezeigt werden sollen. (|cFFFF7F3FOrange|r/|cFFFFFF00Gelb|r/|cFF3FBF3FGr\195\188n|r/|cFF7F7F7FGrau|r)",
			args = {
				{
					option = "grau",
					desc   = "Zeigt alle Verzauberungen ab |cFF7F7F7Fgrauem|r Schwierigkeitsgrad.",
					method = "LowestShown_Grey"
				},
				{
					option = "gr\195\188n",
					desc   = "Zeigt alle Verzauberungen ab |cFF3FBF3Fgr\195\188nem|r Schwierigkeitsgrad.",
					method = "LowestShown_Green"
				},
				{
					option = "gelb",
					desc   = "Zeigt alle Verzauberungen ab |cFFFFFF00gelbem|r Schwierigkeitsgrad.",
					method = "LowestShown_Yellow"
				},
				{
					option = "orange",
					desc   = "Zeigt alle Verzauberungen ab |cFFFF7F3Forangem|r Schwierigkeitsgrad.",
					method = "LowestShown_Orange"
				},
				{
					option = SORTENCHANT.DEFAULT,
					desc   = "Setzt die Anzeige der Verzauberungen auf den Standard (|cFF7F7F7Fgrau|r) zur\195\188ck.",
					method = "LowestShown_Grey"
				}
			}
		},
		{
			option = "sortierung",
			desc   = "Legt die Sortierung, welche im Verzauberkunstfenster angezeigt werden soll, fest.",
			args = {
				{
					option = "r\195\188stung",
					desc   = "Sortiert die Verzauberungen nach R\195\188stung.",
					method = "GroupBy_Armor"
				},
				{
					option = "attribut",
					desc   = "Sortiert die Verzauberungen nach Attributen.",
					method = "GroupBy_Bonus"
				},
				{
					option = "verf\195\188gbarkeit",
					desc   = "Sortiert die Verzauberungen nach Verf\195\188gbarkeit.",
					method = "GroupBy_Quantity"
				},
				{
					option = "schwierigkeitsgrad",
					desc   = "Sortiert die Verzauberungen nach Schwierigkeitsgrad.",
					method = "GroupBy_Difficulty"
				},
				{
					option = "keine",
					desc   = "Keine Sortierung wird angewandt.",
					method = "GroupBy_None"
				},
				{
					option = SORTENCHANT.DEFAULT,
					desc   = "Setzt die Sortierung auf den Standard (R\195\188stung) zur\195\188ck.",
					method = "GroupBy_Armor"
				}
			}
		},
		{
			option = "an",
			desc   = "Aktiviert SortEnchant, beendet den Ruhezustand.",
			method = "Enable"
		},
		{
			option = "aus",
			desc   = "Deaktiviert SortEnchant, versetzt es zudem in den Ruhezustand.",
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
			[9] = "Mana- und Zauber\195\150l";
			[10] = "Runenverzierte Ruten";
			[11] = "Sonstiges";

			n = 11
		},

		bonus = {
			[1] = "Beweglichkeit";
			[2] = "Intelligenz";
			[3] = "Willenskraft";
			[4] = "Ausdauer";
			[5] = "St\195\164rke";
			[6] = "Gesundheit";
			[7] = "Mana";
			[8] = "Werte";
			[9] = "Verteidigung";
			[10] = "Widerstand";
			[11] = "Waffen - Schaden";
			[12] = "Waffen - Verzauberungen",
			[13] = "Skillsteigernde Verzauberungen",
			[14] = "Heil- und Zauberkraft",
			[15] = "Sonstiges";

			n = 15
		},

		quantity = {
			[1] = "11-100",
			[2] = "5-10",
			[3] = "1-4",
			[4] = "Keine",

			n = 4
		},

		difficulty = {
			[1] = "Orange",
			[2] = "Gelb",
			[3] = "Gr\195\188n",
			[4] = "Grau",

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
			["Zweihandwaffe"] = 7,
			["Zweihandwaffen"] = 7,
			["Gro\195\159er Mystikerzauberstab"] = 8,
			["Geringer Mystikerzauberstab"] = 8,
			["Gro\195\159er Magiezauberstab"] = 8,
			["Geringer Magiezauberstab"] = 8,
			["Geringes Zauber\195\182l"] = 9,
			["Schwaches Zauber\195\182l"] = 9,
			["Hervorragendes Zauber\195\182l"] = 9,
			["Geringes Mana\195\182l"] = 9,
			["Schwaches Mana\195\182l"] = 9,
			["Hervorragendes Mana\195\182l"] = 9,
			["Zauber\195\182l"] = 9,
			["Runenverzierte Kupferrute"] =10,
			["Runenverzierte Silberrute"] =10,
			["Runenverzierte Goldrute"] =10,
			["Runenverzierte Echtsilberrute"] =10,
			["Runenverzierte Arkanitrute"] =10,
			[""] = 11
		},

		bonus = {
			["Beweglichkeit"] = 1,
			["Intelligenz"] = 2,
			["Willen"] = 3,
			["Willenskraft"] = 3,			
			["Ausdauer"] = 4,
			["St\195\164rke"] = 5,
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
			["Schlagen"] = 11, 
			["Einschlag"] = 11,
			["Wildtiert\195\182ter"] = 12,
			["Elementart\195\182ter"] = 12,
			["D\195\164monent\195\182ten"] = 12,
			["Kreuzfahrer"] = 12,
			["Unheilige"] = 12,
			["Feurige"] = 12,
			["Eisiger"] = 12,
			["Lebensdiebstahl"] = 12,
			["Wintermacht"] = 14,
			["Kr\195\164uterkunde"] = 13,
			["Bergbau"] = 13,
			["K\195\188rschnerei"] = 13,
			["Angeln"] = 13,
			["Reitfertigkeit"] = 13,
			["Tempo"] = 13,
			["Hast"] = 13,
			["Verstohlenheit"] = 13,
			["Ausweichen"] = 13,
			["Feingef\195\188hl"] = 13,
			["Bedrohung"] = 13,
			["Zauberkraft"] = 14,
			["Heilkraft"] = 14,
			["Schattenmacht"] = 14,
			["Feuermacht"] = 14,
			["Frostmacht"] = 14,
			[""] = 15,
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