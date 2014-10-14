function FuBar_Factions_Locals_deDE()

	FuBar_FactionsLocals = {
		NAME = "FuBar - Factions",
		DESCRIPTION = "Show reputation for factions.",
		COMMANDS = {"/fbFac", "/fbFactions", "/fubar_Factions"},
		CMD_OPTIONS = {},
		
		TOOLTIP_TITLE = "|cffffffffFactions",
		
		ARGUMENT_PERCENT = "percent",
		ARGUMENT_BOTH = "both",
		
		MENU_SHOW_AS_PERCENTAGE = "Show as percentage",
		MENU_SHOW_BOTH = "Show raw and percentage",
		MENU_MONITOR = "Monitor",
		
		FactionTextHated = " |cff8b0000"..FACTION_STANDING_LABEL1.."|r",
		FactionTextHostile = " |cffff0000"..FACTION_STANDING_LABEL2.."|r",
		FactionTextUnfriendly = " |cffff8C00"..FACTION_STANDING_LABEL3.."|r",
		FactionTextNeutral = " |cffc0c0c0"..FACTION_STANDING_LABEL4.."|r",
		FactionTextFriendly = " |cffffffff"..FACTION_STANDING_LABEL5.."|r",
		FactionTextHonored = " |cff00ff00"..FACTION_STANDING_LABEL6.."|r",
		FactionTextRevered = " |cff4169e1"..FACTION_STANDING_LABEL7.."|r",
		FactionTextExalted = " |cff9932cc"..FACTION_STANDING_LABEL8.."|r",
	}
	
	FuBar_FactionsLocals.CMD_OPTIONS = {
		{
			option = FuBar_FactionsLocals.ARGUMENT_PERCENT,
			desc = "Show as percentage.",
			method = "ToggleShowingPercent",
		}
	}
	
end