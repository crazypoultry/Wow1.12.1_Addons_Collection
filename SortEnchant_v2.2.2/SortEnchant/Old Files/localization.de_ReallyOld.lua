-- Version: German (by C[k)
-- Last Update: 03/13/05

if ( GetLocale() == "deDE" ) then
	SortEnchant_EncTitle = "Verzauberkunst";
	
	--Tables for searching
	SortEnchant_DefaultShow = {
		[SortEnchant_Armor_C] = {
			[1] = "Stiefel";
			[2] = "Armschiene";
			[3] = "Brust";
			[4] = "Umhang";
			[5] = "Handschuhe";
			[6] = "Schild";
			[7] = "2H Waffe";
			[8] = "Waffe";
			[9] = "Zauberstab";
			[10] = "Gemischt";
			Total = 10;
		};
		[SortEnchant_Type_C] = {
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
			[12] = "Gemischt";
			Total = 12;
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
			[1] = "Stiefel";
			[2] = "Armschiene";
			[3] = "Brust";
			[4] = "Umhang";
			[5] = "Handschuhe";
			[6] = "Schild";
			[7] = "2H Waffe";
			[8] = "Waffe";
			[9] = "Zauberstab";
			[10] = "";
		};

		[SortEnchant_Type_C] = {
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
			[12] = "";
		};
		
		[SortEnchant_Available_C] = SortEnchant_SortingAmount;
	};
end