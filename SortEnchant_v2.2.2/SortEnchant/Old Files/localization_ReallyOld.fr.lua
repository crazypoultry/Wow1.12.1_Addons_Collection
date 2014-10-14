-- Version: French
-- Last Update: 03/10/05


if ( GetLocale() == "frFR" ) then
	SortEnchant_EncTitle = "Enchantement";
	
	--Tables for searching
	SortEnchant_DefaultShow = {
		[SortEnchant_Armor_C] = {
			[1] = "Bottes";
			[2] = "Bracelets";
			[3] = "Plastron";
			[4] = "Cape";
			[5] = "Gants";
			[6] = "Bouclier";
			[7] = "Arme 2M";
			[8] = "Arme";
			[9] = "Baguette";
			[10] = "Misc";
			Total = 10;
		};
		[SortEnchant_Type_C] = {
			[1] = "Agilit\195\169";
			[2] = "Intelligence";
			[3] = "Esprit";
			[4] = "Endurance";
			[5] = "Force";
			[6] = "Vie";
			[7] = "Mana";
			[8] = "Caract\195\169ristiques";
			[9] = "D\195\169fense";
			[10] = "R\195\169sistance";
			[11] = "Frappe";
			[12] = "Tueur";
			[13] = "Misc";
			Total = 13;
		};
		
		[SortEnchant_Available_C] = {
			[1] = "Lots";
			[2] = "5-10";
			[3] = "1-4";
			[4] = "None";
			Total = 4;
		}
	};

	SortEnchant_DefaultSearch = {
		[SortEnchant_Armor_C] = {
			[1] = "bottes";
			[2] = "bracelets";
			[3] = "plastron";
			[4] = "cape";
			[5] = "gants";
			[6] = "bouclier";
			[7] = "arme 2M";
			[8] = "arme";
			[9] = "baguette";
			[10] = "";
		};

		[SortEnchant_Type_C] = {
			[1] = "Agilit\195\169";
			[2] = "Intelligence";
			[3] = "Esprit";
			[4] = "Endurance";
			[5] = "Force";
			[6] = "Sant\195\169";
			[7] = "Mana";
			[8] = "Caract\195\169ristiques";
			[9] = "D\195\169fense;Protection;Absorption;Déviation";
			[10] = "R\195\169sistance";
			[11] = "Impact;Frappe";
			[12] = "Tueur";
			[13] = "";
		};
		
		[SortEnchant_Available_C] = SortEnchant_SortingAmount;
	};
end