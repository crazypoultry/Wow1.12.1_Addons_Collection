--[[

-- SortEnchant (French)
-- Translation by Sparrows (Comics UI)
-- LionHeart (www.lionsheart.clan.st)
-- Last Update: 05/03/2006

--]]

--This function will be ran if we are under the French Locale
function SortEnchant_Locals_frFR()
	--The name of the AddOn
	SORTENCHANT.NAME = "SortEnchant"

	--The command to give to the option setting code to reset that option to the default
	SORTENCHANT.DEFAULT = "default"

	--Used to figure out what kind of enchantment it is
	--SORTENCHANT.SEARCHSTRING = "Enchantement de ([^%(]*) %(([^%s]*) ?(.[^%)])%)";
	SORTENCHANT.SEARCHSTRING = "([^%(]*) %(([^%)]*)%) ?(.*)";

	--Holds the various text sources for the status and report messages
	SORTENCHANT.STATUS = {}

	--The text to display for the various settings
	SORTENCHANT.STATUS.LATESTSHOWN = "Lowest shown difficulty item"
	SORTENCHANT.STATUS.GROUPBY     = "Groupings"

	--Holds the various mapping for status and report messages
	SORTENCHANT.MAP = {}

	--The mapping of stored values for LowestShown to readable values
	SORTENCHANT.MAP.LOWESTSHOWN = {
									[1] = "|cFF7F7F7FGris|r",
									[2] = "|cFF3FBF3FVert|r",
									[3] = "|cFFFFFF00Jaune|r",
									[4] = "|cFFFF7F3FOrange|r"
								  }

	--The mapping of stored values for GroupBy to readable values
	SORTENCHANT.MAP.GROUPBY		= {
									armor      = "Armure",
									bonus      = "Bonus",
									quantity   = "Quantit\195\169",
									difficulty = "Difficult\195\169",
									none       = "Rien"
								  }

	SORTENCHANT.ARMORDROPDOWN_TITLE = "Toutes les armures";
	SORTENCHANT.BONUSDROPDOWN_TITLE = "Tous les bonus";

	-- Chat handler locals
	SORTENCHANT.COMMANDS	= {"/sortenchant"}
	SORTENCHANT.CMD_OPTIONS	= {
		{
			option = "affiche",
			desc   = "R\195\168gle la difficult\195\169 minimum \195\160 afficher dans la fen\195\170tre des enchantements.",
			args = {
				{
					option = "gris",
					desc   = "Toutes les difficult\195\169s seront affich\195\169es dans la fen\195\170tre des enchantements",
					method = "LowestShown_Grey"
				},
				{
					--This is here to allow both spellings of the word grey to work properly
					option = "gray",
					desc   = "Toutes les difficult\195\169s seront affich\195\169es dans la fen\195\170tre des enchantements",
					method = "LowestShown_Grey"
				},	
				{
					option = "vert",
					desc   = "Seuls les enchantements de difficult\195\169 verte ou sup\195\169rieur seront affich\195\169s dans la fen\195\170tre des enchantements",
					method = "LowestShown_Green"
				},
				{
					option = "jaune",
					desc   = "Seuls les enchantements de difficult\195\169 jaune ou sup\195\169rieur seront affich\195\169s dans la fen\195\170tre des enchantements",
					method = "LowestShown_Yellow"
				},
				{
					option = "orange",
					desc   = "Seuls les enchantements de difficult\195\169 orange seront affich\195\169s dans la fen\195\170tre des enchantements",
					method = "LowestShown_Orange"
				},
				{
					option = SORTENCHANT.DEFAULT,
					desc   = "Met la valeur par d\195\169faut afin de tout afficher (gris)",
					method = "LowestShown_Grey"
				}
			}
		},
		{
			option = "groupepar",
			desc   = "R\195\168gle les groupes \195\160 afficher dans la fen\195\170tre des enchantements.",
			args = {
				{
					option = "armure",
					desc   = "Les enchantements seront tri\195\169s par type d\’armure",
					method = "GroupBy_Armor"
				},
				{
					option = "bonus",
					desc   = "Les enchantements seront tri\195\169s par type de bonus",
					method = "GroupBy_Bonus"
				},
				{
					option = "quantit\195\169",
					desc   = "Les enchantements seront tri\195\169s par quantit\195\169 disponible",
					method = "GroupBy_Quantity"
				},
				{
					option = "difficult\195\169",
					desc   = "Les enchantements seront tri\195\169s par difficult\195\169",
					method = "GroupBy_Difficulty"
				},
				{
					option = "rien",
					desc   = "Les enchantements ne seront pas tri\195\169s",
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
			option = "on",
			desc   = "Activer SortEnchant, quitter le mode stadby",
			method = "Enable"
		},
		{
			option = "off",
			desc   = "Eteindre SortEnchant, mettre en standby",
			method = "Disable"
		}
	}

	SORTENCHANT.DISPLAY = {
		--Tese are all explicitly numbered to make modifing the lists simpler

		armor = {
			[1] = "Arme",
			[2] = "Arme 2M",
			[3] = "Baguette",
			[4] = "B\195\162tonnet",
			[5] = "Bottes",
			[6] = "Bouclier",
			[7] = "Bracelets",
			[8] = "Cape",
			[9] = "Gants",
			[10] = "Huile",
			[11] = "Plastron",
			[12] = "Autres",

			n = 12
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
			[14] = "Skills",
			[15] = "Pouvoir",
			[16] = "Autres",

			n = 16
		},

		quantity = {
			[1] = "10+",
			[2] = "5-10",
			[3] = "1-4",
			[4] = "Aucun",

			n = 4
		},

		difficulty = {
			[1] = "Optimal",
			[2] = "Moyen",
			[3] = "Simple",
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
			["Ench. d\'arme"] = 1,
			["Ench. d\'arme 2M"] = 2,
			["Baguette"] = 3,
				["Baguette magique sup\195\169rieure"] = 3,
				["Baguette magique inf\195\169rieure"] = 3,
				["Baguette mystique sup\195\169rieure"] = 3,
				["Baguette mystique inf\195\169rieure"] = 3,
			["B\195\162tonnet runique en arcanite"] = 4,
				["B\195\162tonnet runique en or"] = 4,
				["B\195\162tonnet runique en vrai-argent"] = 4,
				["B\195\162tonnet runique en argent"] = 4,
				["B\195\162tonnet runique en cuivre"] = 4,
			["Ench. de bottes"] = 5,
			["Ench. de bouclier"] = 6,
			["Ench. de bracelets"] = 7,
			["Ench. de cape"] = 8,
			["Ench. de gants"] = 9,
				["Enchantement de gants"] = 9,
			["Huile"] = 10,
				["Huile de sorcier"] = 10,
				["Huile de sorcier brillante"] = 10,
				["Huile de sorcier inf\195\169rieure"] = 10,
				["Huile de sorcier mineure"] = 10,
				["Huile de mana"] = 10,
				["Huile de mana brillante"] = 10,
				["Huile de mana inf\195\169rieure"] = 10,
				["Huile de mana mineure"] = 10,
			["Ench. de plastron"] = 11,
			[""] = 12
		},

		bonus = {
			["Agilit\195\169"] = 1,
				["Agilit\195\169 excellente"] = 1,
				["Agilit\195\169 sup\195\169rieure"] = 1,
				["Agilit\195\169 inf\195\169rieure"] = 1,
				["Agilit\195\169 mineure"] = 1,
			["Intelligence"] = 2,
				["Intelligence majeure"] = 2,
				["Intelligence renforc\195\169e"] = 2,
				["Intelligence inf\195\169rieure"] = 2,
			["Esprit"] = 3,
				["Esprit majeur"] = 3,
				["Esprit renforc\195\169"] = 3,
				["Esprit excellent"] = 3,
				["Esprit sup\195\169rieur"] = 3,
				["Esprit inf\195\169rieur"] = 3,
				["Esprit mineur"] = 3,
			["Endurance"] = 4,
				["Endurance excellente"] = 4,
				["Endurance sup\195\169rieure"] = 4,
				["Endurance inf\195\169rieure"] = 4,
				["Endurance mineure"] = 4,
			["Force"] = 5,
				["Force sup\195\169rieure"] = 5,
				["Force inf\195\169rieure"] = 5,
				["Force mineure"] = 5,
			["Vie"] = 6,
				["Sant\195\169 excellente"] = 6,
				["Sant\195\169 majeure"] = 6,
				["Vie majeure"] = 6,
				["Vie sup\195\169rieure"] = 6,
				["Vie inf\195\169rieure"] = 6,
				["Vie mineure"] = 6,
			["Mana"] = 7,
				["Mana majeure"] = 7,
				["Mana excellent"] = 7,
				["Mana sup\195\169rieur"] = 7,
				["Mana inf\195\169rieur"] = 7,
				["Mana mineur"] = 7,
			["R\195\169g\195\169n\195\169ration"] = 7,
				["R\195\169g\195\169n\195\169ration de mana"] = 7,
			["Caract\195\169ristiques"] = 8,
				["Caract. sup\195\169rieures"] = 8,
				["Caract. inf\195\169rieures"] = 8,
				["Caract. mineures"] = 8,
			["D\195\169fense"] = 9,
				["D\195\169fense excellente"] = 9,
				["D\195\169fense sup\195\169rieure"] = 9,
			["Protection"] = 9,
				["Protection inf\195\169rieure"] = 9,
				["Protection mineure"] = 9,
			["Parade"] = 9,
				["Parade inf\195\169rieure"] = 9,
			["Blocage"] = 9,
			["D\195\169viation"] = 9,
				["D\195\169viation inf\195\169rieure"] = 3,
				["D\195\169viation mineure"] = 3,
			["Absorption"] = 9,
				["Absorption inf\195\169rieure"] = 9,
				["Absorption mineure"] = 9,
			["R\195\169sistance"] = 10,
				["R\195\169sistance mineure"] = 10,
				["R\195\169sistance au Feu sup\195\169rieure"] = 10,
				["R\195\169sistance au Feu"] = 10,
				["R\195\169sistance au Feu inf."] = 10,
				["R\195\169sistance \195\160 l\'Ombre"] = 10,
				["R\195\169sistance \195\160 l\'Ombre inf."] = 10,
				["R\195\169sistance \195\160 la Nature sup\195\169rieure"] = 10,
			["Impact"] = 11,
				["Impact excellent"] = 11,
				["Impact sup\195\169rieur"] = 11,
				["Impact inf\195\169rieur"] = 11,
				["impact mineur"] = 11,
			["Frappe"] = 11,
				["Frappe excellente"] = 11,
				["Frappe sup\195\169rieure"] = 11,
				["Frappe inf\195\169rieure"] = 11,
				["Frappe mineure"] = 11,
			["Tueur"] = 12,
				["Tueur de d\195\169mons"] = 12,
				["Tueur de b\195\170te inf\195\169rieur"] = 12,
				["Tueur de b\195\170te mineur"] = 12,
				["Tueur d\'\195\169l\195\169mentaire inf\195\169rieur"] = 12,
			["Crois\195\169"] = 13,
			["Impie"] = 13,
			["Arme flamboyante"] = 13,
			["Frisson glacial"] = 13,
			["Vampirique"] = 13,
			["Herboristerie"] = 14,
				["Herboristerie avanc\195\169e"] = 14,
			["Minage"] = 14,
				["Minage avanc\195\169"] = 14,
			["D\195\169pe\195\167age"] = 14,
			["P\195\170che"] = 14,
			["Equitation"] = 14,
			["Vitesse"] = 14,
				["Vitesse mineure"] = 14,
			["H\195\162te"] = 14, 
				["H\195\162te mineure"] = 14, 
			["Furtivit\195\169"] = 14,
			["Esquive"] = 14,
			["Subtilit\195\169"] = 14,
			["Menace"] = 14,
			["Soin"] = 15,
			["Pouvoir"] = 15,
				["Pouvoir de gu\195\169rison"] = 15,
			["Puissance"] = 15,
				["Puissance de sort"] = 15,
				["Puissance du feu"] = 15,
				["Puissance de feu"] = 15,
				["Puissance d'ombre"] = 15,
				["Puissance du givre"] = 15,
				["Puissance de l\'hiver"] = 15,
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