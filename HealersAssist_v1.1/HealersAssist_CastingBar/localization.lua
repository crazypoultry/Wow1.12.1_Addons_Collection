--[[
  Healers Assist CastingBar Localization file
]]

if ( GetLocale() == "frFR" ) then
	HA_CS_PATTERN_HELP = "Variables: @spellname, @shortspellname, @rank, @target, @casttime, @estimated, @overhealpercent, @hp, @hpmax, @hpdiff, @healcount, @estimateratio, @totalestimatedheal, @n";
	HA_CS_COLOR_CHANGE_COLOR_ENABLED = "Alt\195\168re la couleur de la barre de lancement de sort";
	HA_CS_COLOR_CHANGE_COLOR_DISABLED = "Alt\195\168re la couleur de la barre de lancement de sort (Requiert Mana Save)";
	HA_CS_COLOR_OVERHEAL = "Overheal";
	HA_CS_COLOR_NORMAL = "Normal";
	HA_CS_OPTIONS = "Options";
	HA_CS_COLOR_SET = "Stocke"; 
	HA_CS_COLOR_CANCEL= "Fermer";
elseif ( GetLocale() == "deDE" ) then
	HA_CS_PATTERN_HELP = "Variablen: @spellname, @shortspellname, @rank, @target, @casttime, @estimated, @overhealpercent, @hp, @hpmax, @hpdiff, @healcount, @estimateratio, @totalestimatedheal, @n";
	HA_CS_OPTIONS = "Optionen";
	HA_CS_COLOR_CHANGE_COLOR_ENABLED = "Farbe der Casting Bar \195\164ndern";
	 HA_CS_COLOR_CHANGE_COLOR_DISABLED = "Farbe der Casting Bar \195\164ndern |c00ff0000(Ben\195\182tigt Mana Save)|r";
	HA_CS_COLOR_OVERHEAL = "\195\156berheilung";
	HA_CS_COLOR_NORMAL = "Keine \195\156berheilung";
	HA_CS_COLOR_SET = "Speichern";
	HA_CS_COLOR_CANCEL = "Abbrechen";
else
	HA_CS_PATTERN_HELP = "Variables: @spellname, @shortspellname, @rank, @target, @casttime, @estimated, @overhealpercent, @hp, @hpmax, @hpdiff, @healcount, @estimateratio, @totalestimatedheal, @n";
	HA_CS_OPTIONS = "Options";
	HA_CS_COLOR_CHANGE_COLOR_ENABLED = "Change color of your casting bar";
	HA_CS_COLOR_CHANGE_COLOR_DISABLED = "Change color of your casting bar |c00ff0000(Requires Mana Save)|r";
	HA_CS_COLOR_OVERHEAL = "Overheal";
	HA_CS_COLOR_NORMAL = "No overheal";
	HA_CS_COLOR_SET = "Set";
	HA_CS_COLOR_CANCEL = "Cancel";
end
