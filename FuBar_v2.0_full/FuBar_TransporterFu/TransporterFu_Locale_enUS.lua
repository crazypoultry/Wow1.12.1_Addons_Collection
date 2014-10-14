local L = AceLibrary("AceLocale-2.2"):new("TransporterFu")

L:RegisterTranslations("enUS", function() return {
	["Desc"] = "Easy access to transportation methods.",
	
	["METHOD1"] = "Method: ",
	["INN"] = "Inn: ",
	
	["SHOW_COOLDOWN"] = "Show Cooldown",
	["SHOW_TAG"] = "Show Description",
   
   --Transport methods
   ["ASTRAL"] = "Astral Recall",
   ["PORT_MG"] = "Teleport: Moonglade",
   ["TELEPORT_UC"] = "Teleport: Undercity",
   ["TELEPORT_SW"] = "Teleport: Stormwind",
   ["TELEPORT_OG"] = "Teleport: Orgrimmar",
   ["TELEPORT_IF"] = "Teleport: Ironforge",
   ["TELEPORT_TB"] = "Teleport: Thunder Bluff",
   ["TELEPORT_DN"] = "Teleport: Darnassus",
   ["PORTAL_UC"] = "Portal: Undercity",
   ["PORTAL_SW"] = "Portal: Stormwind",
   ["PORTAL_OG"] = "Portal: Orgrimmar",
   ["PORTAL_IF"] = "Portal: Ironforge",
   ["PORTAL_TB"] = "Portal: Thunder Bluff",
   ["PORTAL_DN"] = "Portal: Darnassus",
   ["WARHORSE"] = "Summon Warhorse",
   ["CHARGER"] = "Summon Charger",
   ["FELSTEED"] = "Summon Felsteed",
   ["DREADSTEED"] = "Summon Dreadsteed",
      
   ["MENU_SET"] = "Set Method",
   ["MANUAL"] = "Manual Update",
      
   ["NA"] = "N/A",
   ["READY"] = "Ready",
   
   ["HINT"] = "Left-click to use selected transport",
   
   ["PT_FOUND"] = "PeriodicTable found, items will be supported.",
   ["PT_SET_EXISTS"] = "The set %s already exists in PeriodicTable!",
   ["PT_NOT_FOUND"] = "PeriodicTable not found, Item support not enabled.",
   ["SE_FOUND"] = "SpecialEvents found",
   ["SE_NOT_FOUND"] = "SpecialEvents not found, this probably isn't going to work!",
} end)