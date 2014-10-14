--[[
	okay, all localization is in one file.  I guess this will be a pain in the ass to get
	different people to work on it at first, but later on it'll be eaisier for me to add
	single values.

--]]

-- ERR_BAGATTACKPOS is a blizzard defined string.  we can compare the value of this string to guess
-- your game's language
ERR_BADATTACKPOS_LOCAL_EN = "You are too far away!";
ERR_BADATTACKPOS_LOCAL_DE = "Ihr seid zu weit entfernt!";
ERR_BADATTACKPOS_LOCAL_FR = "You are too far away! -- But in french";

EBLocal = {
	["_loaded"] = 0
};

EngBank_HELP = {
	["EN"] = {
		"EngBank Commands:",
		" /eb show  -- open window",
		" /eb hide  -- hide window",
		" /eb scale #.##  -- set the window scale.  use a number between 0.64 and 1.00",
		" /eb update",
		" /eb debug  -- turn debug info on/off",
		" /eb display  -- display item cache",
		" /eb checkhooks  -- see if everything is registered properly",
		" /eb resetdefaults  -- sets everything back to default values"
		},
["DE"] = {                                             -- for the slash commands i've seen no use in translating it. Just translated the comments for better understanding
		"EngBank Commands:",
		" /eb show",
		" /eb hide  -- hide window",
		" /eb scale #.##  -- set the window scale.  use a number between 0.64 and 1.00",
		" /eb update",
		" /eb debug  -- Debug Info an/aus",
		" /eb display  -- Item Cache anzeigen",
		" /eb checkhooks  -- Sehen, ob alles korrekt registriert wurde",
		" /eb resetdefaults  -- Auf Defaultwerte zurücksetzen"
		},
	["FR"] = {
		"EngBank Commands:",
		" /eb show",
		" /eb hide  -- hide window",
		" /eb scale #.##  -- set the window scale.  use a number between 0.64 and 1.00",
		" /eb update",
		" /eb debug  -- turn debug info on/off",
		" /eb display  -- display item cache",
		" /eb checkhooks  -- see if everything is registered properly",
		" /eb resetdefaults  -- sets everything back to default values"
		}
	};

-- 1st element is EN, 2nd DE, 3rd FR
EngBank_LOCALIZATION = {
	-- some default items to place in slots manually
	["RightClick_MenuTitle"] = {
		"EngBank @ EngBags",
		"EngBank @ EngBags",
		"EngBank @ EngBags"
		},
	["RightClick_ShowNewItems"] = {
		"New Items",
		"New Items",
		"New Items"
		},

	["soulbound_search"] = {	-- looking for soulbound keyword is special
		"Soulbound",
		"Seelengebunden",
		"Soulbound"
		},

	["Warlock"] = {
		"Warlock",
		"Warlock",
		"Warlock"
		},
	["Priest"] = {
		"Priest",
		"Priest",
		"Priest"
		},
	["Mage"] = {
		"Mage",
		"Mage",
		"Mage"
		},
	["Rogue"] = {
		"Rogue",
		"Rogue",
		"Rogue"
		},
	["Warrior"] = {
		"Warrior",
		"Warrior",
		"Warrior"
		},
	["Hunter"] = {
		"Hunter",
		"Hunter",
		"Hunter"
		},
	["Shaman"] = {
		"Shaman",
		"Shaman",
		"Shaman"
		},
	["Druid"] = {
		"Druid",
		"Druid",
		"Druid"
		},
	["Paladin"] = {
		"Paladin",
		"Paladin",
		"Paladin"
		},

	["Cooking"] = {
		"Cooking",
		"Cooking",
		"Cooking"
		},
	["First Aid"] = {
		"First Aid",
		"First Aid",
		"First Aid"
		},

	["string_searches"] = {
		{ -- english
			{ "FOOD", "Restores ([0-9.]+) health over ([0-9.]+) sec" },
			{ "DRINK", "Restores ([0-9.]+) mana over ([0-9.]+) sec" },
			{ "HEALINGPOTION", "Restores ([0-9.]+) to ([0-9.]+) health." },
			{ "MANAPOTION", "Restores ([0-9.]+) to ([0-9.]+) mana." },
			{ "PROJECTILE", "Projectile" },
			{ "JUJU", "Juju" },
			{ "BANDAGE", " Bandage" },
			{ "HEALTHSTONE", " Healthstone" },
			{ "RECIPE", "Recipe:" },
			{ "PATTERN", "Pattern:" },
			{ "SCHEMATIC", "Schematic:" },
			{ "FORMULA", "Formula:" },
			{ "MINIPET", "Right Click to summon and dismiss your" },
			{ "ROGUE_POISON", "Crippling Poison [IV]*" },
			{ "ROGUE_POISON", "Deadly Poison [IV]*" },
			{ "ROGUE_POISON", "Instant Poison [IV]*" },
			{ "ROGUE_POISON", "Mind-numbing Poison [IV]*" },
			{ "ROGUE_POISON", "Wound Poison [IV]*" },
			{ "ROGUE_POWDER", "Blinding Powder" },
			{ "ROGUE_POWDER", "Flash Powder" },
			{ "QUESTITEMS", "Use: Bind pages [0-9]" },	-- shredder operating manual & green hills of stranglethorn
			{ "KEYS", " Key" }
		},
		{ -- german
			{ "FOOD", "Stellt im Verlauf von ([0-9.]+) Sek. ([0-9.]+) Punkt(e) Gesundheit wieder her." },
			{ "DRINK", "Stellt im Verlauf von ([0-9.]+) Sek. ([0-9.]+) Punkt(e) Mana wieder her." },
			{ "INSTANT_HP", "Stellt ([0-9.]+) bis ([0-9.]+) Punkt(e) Gesundheit wieder her." },
			{ "INSTANT_MANA", "Stellt ([0-9.]+) bis ([0-9.]+) Punkt(e) Mana wieder her." },
			{ "PROJECTILE", "Projektil" },
			{ "JUJU", "Juju" },
			{ "BANDAGE", "Verband" },
			{ "HEALTHSTONE", "Gesundheitsstein" },
		},
		{ -- french
		}
		},	-- end of string searches


	-- values from GetItemInfo()  (itemType)
	["tradegoods"] = {
		"Trade Goods",
		"Handwerkswaren",
		"Trade Goods"
		},
	["miscellaneous"] = {
		"Miscellaneous",
		"Verschiedenes",
		"Misellaneous"
		},
	["reagent"] = {
		"Reagent",
		"Reagenz",
		"Reagent"
		},
	["quest"] = {
		"Quest",
		"Quest",
		"Quest"
		},
	["consumable"] = {
		"Consumable",
		"Verbrauchbar",
		"consumable"
		},

	-- window elements
	["EngBank_Button_HighlightToggle_on"] = {
		"Hilight New: ON",
		"Hilight New: ON",
		"Hilight New: ON"
		},
	["EngBank_Button_HighlightToggle_on_tooltip"] = {
		"Highlight of new items is on.",
		"Highlight of new items is on.",
		"Highlight of new items is on."
		},
	["EngBank_Button_HighlightToggle_off"] = {
		"Hilight New: OFF",
		"Hilight New: OFF",
		"Hilight New: OFF"
		},
	["EngBank_Button_HighlightToggle_off_tooltip"] = {
		"Highlight of new items is off.",
		"Highlight of new items is off.",
		"Highlight of new items is off."
		},
	["EngBank_Button_MoveLock_locked"] = {
		"L",
		"L",
		"L"
		},
	["EngBank_Button_MoveLock_unlocked"] = {
		"U",
		"U",
		"U"
		},
	["EngBank_Button_ChangeEditMode_MoveClass"] = {
		"Edit Mode",
		"Edit Mode",
		"Edit Mode"
		},
	["EngBank_Button_ChangeEditMode_MoveItem"] = {
		"Move Items",
		"Move Items",
		"Move Items"
		},
	["EngBank_Button_ChangeEditMode_off"] = {
		"Bank Edit",
		"Bank Edit",
		"Bank Edit"
		},
	["EngBank_Button_ChangeEditMode_tooltip_title"] = {
		"Modify Sort Locations",
		"Modify Sort Locations",
		"Modify Sort Locations"
		},
	["EngBank_Button_ChangeEditMode_tooltip"] = {
		"Edit Mode:\n  Select this option to move classes of items into different 'bars' (the red numbers).\n\n",
		"Edit Mode:\n  Select this option to move classes of items into different 'bars' (the red numbers).\n\n",
		"Edit Mode:\n  Select this option to move classes of items into different 'bars' (the red numbers).\n\n"
		},

	["EngBank_Button_ColumnsAdd_buttontitle"] = {
		"<<-- -->>",
		"<<-- -->>",
		"<<-- -->>"
		},
	["EngBank_Button_ColumnsAdd_tooltip_title"] = {
		"Window Size",
		"Window Size",
		"Window Size"
		},
	["EngBank_Button_ColumnsAdd_tooltip"] = {
		"Increase the number of columns displayed",
		"Increase the number of columns displayed",
		"Increase the number of columns displayed"
		},

	["EngBank_Button_ColumnsDel_buttontitle"] = {
		"-->> <<--",
		"-->> <<--",
		"-->> <<--"
		},
	["EngBank_Button_ColumnsDel_tooltip_title"] = {
		"Window Size",
		"Window Size",
		"Window Size"
		},
	["EngBank_Button_ColumnsDel_tooltip"] = {
		"Decrease the number of columns displayed",
		"Decrease the number of columns displayed",
		"Decrease the number of columns displayed"
		},

	["help_text"] = {
		"EN",
		"DE",
		"FR"
		}
}


function EngBank_load_Localization(loadlang)
	local loadlang_num = 1;

	EngBags_PrintDEBUG("Loading localization: '"..loadlang.."'");

	if ( loadlang == "EN" ) then
		loadlang_num = 1;
	elseif ( loadlang == "DE" ) then
		loadlang_num = 2;
	elseif ( loadlang == "FR" ) then
		loadlang_num = 3;
	end

	-- the string.gsub is there because the editor I'm using is being stupid and is randomly replaceing spaces with tabs.
	for key,value in EngBank_LOCALIZATION do
		if (type(value[loadlang_num]) == "string") then
			EngBags_PrintDEBUG("localization: "..key.." set to '"..value[loadlang_num].."'");
			EBLocal[key] = string.gsub(value[loadlang_num], "\t", " ");
		else
			EBLocal[key] = value[loadlang_num];
		end
	end

	EBLocal["_loaded"] = 1;
end


EILocal = {
	["_loaded"] = 0
};

ENGINVENTORY_HELP = {
	["EN"] = {
		"EngInventory Commands:",
		" /ei show  -- open window",
		" /ei hide  -- hide window",
		" /ei scale #.##  -- set the window scale.  use a number between 0.64 and 1.00",
		" /ei update",
		" /ei debug  -- turn debug info on/off",
		" /ei display  -- display item cache",
		" /ei checkhooks  -- see if everything is registered properly",
		" /ei resetdefaults  -- sets everything back to default values"
		},
["DE"] = {                                             -- for the slash commands i've seen no use in translating it. Just translated the comments for better understanding
		"EngInventory Commands:",
		" /ei show",
		" /ei hide  -- hide window",
		" /ei scale #.##  -- set the window scale.  use a number between 0.64 and 1.00",
		" /ei update",
		" /ei debug  -- Debug Info an/aus",
		" /ei display  -- Item Cache anzeigen",
		" /ei checkhooks  -- Sehen, ob alles korrekt registriert wurde",
		" /ei resetdefaults  -- Auf Defaultwerte zurücksetzen"
		},
	["FR"] = {
		"EngInventory Commands:",
		" /ei show",
		" /ei hide  -- hide window",
		" /ei scale #.##  -- set the window scale.  use a number between 0.64 and 1.00",
		" /ei update",
		" /ei debug  -- turn debug info on/off",
		" /ei display  -- display item cache",
		" /ei checkhooks  -- see if everything is registered properly",
		" /ei resetdefaults  -- sets everything back to default values"
		}
	};

-- 1st element is EN, 2nd DE, 3rd FR
ENGINVENTORY_LOCALIZATION = {
	-- some default items to place in slots manually
	["RightClick_MenuTitle"] = {
		"EngInventory @ EngBags",
		"EngInventory @ EngBags",
		"EngInventory @ EngBags"
		},
	["RightClick_ShowNewItems"] = {
		"New Items",
		"New Items",
		"New Items"
		},

	["soulbound_search"] = {	-- looking for soulbound keyword is special
		"Soulbound",
		"Seelengebunden",
		"Soulbound"
		},

	["Warlock"] = {
		"Warlock",
		"Warlock",
		"Warlock"
		},
	["Priest"] = {
		"Priest",
		"Priest",
		"Priest"
		},
	["Mage"] = {
		"Mage",
		"Mage",
		"Mage"
		},
	["Rogue"] = {
		"Rogue",
		"Rogue",
		"Rogue"
		},
	["Warrior"] = {
		"Warrior",
		"Warrior",
		"Warrior"
		},
	["Hunter"] = {
		"Hunter",
		"Hunter",
		"Hunter"
		},
	["Shaman"] = {
		"Shaman",
		"Shaman",
		"Shaman"
		},
	["Druid"] = {
		"Druid",
		"Druid",
		"Druid"
		},
	["Paladin"] = {
		"Paladin",
		"Paladin",
		"Paladin"
		},

	["Cooking"] = {
		"Cooking",
		"Cooking",
		"Cooking"
		},
	["First Aid"] = {
		"First Aid",
		"First Aid",
		"First Aid"
		},

	["string_searches"] = {
		{ -- english
			{ "FOOD", "Restores ([0-9.]+) health over ([0-9.]+) sec" },
			{ "DRINK", "Restores ([0-9.]+) mana over ([0-9.]+) sec" },
			{ "HEALINGPOTION", "Restores ([0-9.]+) to ([0-9.]+) health." },
			{ "MANAPOTION", "Restores ([0-9.]+) to ([0-9.]+) mana." },
			{ "PROJECTILE", "Projectile" },
			{ "JUJU", "Juju" },
			{ "BANDAGE", " Bandage" },
			{ "HEALTHSTONE", " Healthstone" },
			{ "RECIPE", "Recipe:" },
			{ "PATTERN", "Pattern:" },
			{ "SCHEMATIC", "Schematic:" },
			{ "FORMULA", "Formula:" },
			{ "MINIPET", "Right Click to summon and dismiss your" },
			{ "ROGUE_POISON", "Crippling Poison [IV]*" },
			{ "ROGUE_POISON", "Deadly Poison [IV]*" },
			{ "ROGUE_POISON", "Instant Poison [IV]*" },
			{ "ROGUE_POISON", "Mind-numbing Poison [IV]*" },
			{ "ROGUE_POISON", "Wound Poison [IV]*" },
			{ "ROGUE_POWDER", "Blinding Powder" },
			{ "ROGUE_POWDER", "Flash Powder" },
			{ "QUESTITEMS", "Use: Bind pages [0-9]" },	-- shredder operating manual & green hills of stranglethorn
			{ "KEYS", " Key" }
		},
		{ -- german
			{ "FOOD", "Stellt im Verlauf von ([0-9.]+) Sek. ([0-9.]+) Punkt(e) Gesundheit wieder her." },
			{ "DRINK", "Stellt im Verlauf von ([0-9.]+) Sek. ([0-9.]+) Punkt(e) Mana wieder her." },
			{ "INSTANT_HP", "Stellt ([0-9.]+) bis ([0-9.]+) Punkt(e) Gesundheit wieder her." },
			{ "INSTANT_MANA", "Stellt ([0-9.]+) bis ([0-9.]+) Punkt(e) Mana wieder her." },
			{ "PROJECTILE", "Projektil" },
			{ "JUJU", "Juju" },
			{ "BANDAGE", "Verband" },
			{ "HEALTHSTONE", "Gesundheitsstein" },
		},
		{ -- french
		}
		},	-- end of string searches


	-- values from GetItemInfo()  (itemType)
	["tradegoods"] = {
		"Trade Goods",
		"Handwerkswaren",
		"Trade Goods"
		},
	["miscellaneous"] = {
		"Miscellaneous",
		"Verschiedenes",
		"Misellaneous"
		},
	["reagent"] = {
		"Reagent",
		"Reagenz",
		"Reagent"
		},
	["quest"] = {
		"Quest",
		"Quest",
		"Quest"
		},
	["consumable"] = {
		"Consumable",
		"Verbrauchbar",
		"consumable"
		},

	-- window elements
	["EngInventory_Button_HighlightToggle_on"] = {
		"Hilight New: ON",
		"Hilight New: ON",
		"Hilight New: ON"
		},
	["EngInventory_Button_HighlightToggle_on_tooltip"] = {
		"Highlight of new items is on.",
		"Highlight of new items is on.",
		"Highlight of new items is on."
		},
	["EngInventory_Button_HighlightToggle_off"] = {
		"Hilight New: OFF",
		"Hilight New: OFF",
		"Hilight New: OFF"
		},
	["EngInventory_Button_HighlightToggle_off_tooltip"] = {
		"Highlight of new items is off.",
		"Highlight of new items is off.",
		"Highlight of new items is off."
		},
	["EngInventory_Button_MoveLock_locked"] = {
		"L",
		"L",
		"L"
		},
	["EngInventory_Button_MoveLock_unlocked"] = {
		"U",
		"U",
		"U"
		},
	["EngInventory_Button_ChangeEditMode_MoveClass"] = {
		"Edit Mode",
		"Edit Mode",
		"Edit Mode"
		},
	["EngInventory_Button_ChangeEditMode_MoveItem"] = {
		"Move Items",
		"Move Items",
		"Move Items"
		},
	["EngInventory_Button_ChangeEditMode_off"] = {
		"Edit",
		"Edit",
		"Edit"
		},
	["EngInventory_Button_ChangeEditMode_tooltip_title"] = {
		"Modify Sort Locations",
		"Modify Sort Locations",
		"Modify Sort Locations"
		},
	["EngInventory_Button_ChangeEditMode_tooltip"] = {
		"Edit Mode:\n  Select this option to move classes of items into different 'bars' (the red numbers).\n\n",
		"Edit Mode:\n  Select this option to move classes of items into different 'bars' (the red numbers).\n\n",
		"Edit Mode:\n  Select this option to move classes of items into different 'bars' (the red numbers).\n\n"
		},

	["EngInventory_Button_ColumnsAdd_buttontitle"] = {
		"<<-- -->>",
		"<<-- -->>",
		"<<-- -->>"
		},
	["EngInventory_Button_ColumnsAdd_tooltip_title"] = {
		"Window Size",
		"Window Size",
		"Window Size"
		},
	["EngInventory_Button_ColumnsAdd_tooltip"] = {
		"Increase the number of columns displayed",
		"Increase the number of columns displayed",
		"Increase the number of columns displayed"
		},

	["EngInventory_Button_ColumnsDel_buttontitle"] = {
		"-->> <<--",
		"-->> <<--",
		"-->> <<--"
		},
	["EngInventory_Button_ColumnsDel_tooltip_title"] = {
		"Window Size",
		"Window Size",
		"Window Size"
		},
	["EngInventory_Button_ColumnsDel_tooltip"] = {
		"Decrease the number of columns displayed",
		"Decrease the number of columns displayed",
		"Decrease the number of columns displayed"
		},

	["help_text"] = {
		"EN",
		"DE",
		"FR"
		}
}


function EngInventory_load_Localization(loadlang)
	local loadlang_num = 1;

	EngBags_PrintDEBUG("Loading localization: '"..loadlang.."'");

	if ( loadlang == "EN" ) then
		loadlang_num = 1;
	elseif ( loadlang == "DE" ) then
		loadlang_num = 2;
	elseif ( loadlang == "FR" ) then
		loadlang_num = 3;
	end

	-- the string.gsub is there because the editor I'm using is being stupid and is randomly replaceing spaces with tabs.
	for key,value in ENGINVENTORY_LOCALIZATION do
		if (type(value[loadlang_num]) == "string") then
			EngBags_PrintDEBUG("localization: "..key.." set to '"..value[loadlang_num].."'");
			EILocal[key] = string.gsub(value[loadlang_num], "\t", " ");
		else
			EILocal[key] = value[loadlang_num];
		end
	end

	EILocal["_loaded"] = 1;
end