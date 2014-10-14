if (GetLocale() ~= "deDE") then
return;
end
TITAN_AGGRO_BUTTON_LABEL = "Ziel: ";
BINDING_HEADER_TITANAGGRO_MENU = "TitanAggro";
BINDING_NAME_TITANAGGRO_REPORT = "[AN/AUS] Meldungen";
AggroVars.Inactive_Text = "Inaktiv";
AggroVars.DoReports_Text = "Meldungen";
AggroVars.TankMode_Text = "Tank-Modus (wenn du Maintank bist)";
AggroVars.ShowTTStatus_Text = "Zeige die HP/MP des Ziels Ziel an";
AggroVars.HideFlashingBackground_Text = "verstecke blinkenden HP/MP Hintergrund";
AggroVars.RelocateTTStatus_Text = "HP/MP Status versetzen";
AggroVars.MoveableTT_HP_Text = "versetzbarer HP/MP Status";
AggroVars.MoveTT_HP_Text = "Rahmen verschieben (start moving)";
AggroVars.FixTT_HP_Text = "Rahmenposition fixieren (stop moving)";
AggroVars.ResetTT_HPPosition_Text = "Rahmenposition zuruecksetzen";
AggroVars.Sounds_Text = "Ton wenn Aggro wechselt";
AggroVars.YouGotTheAggro_Text = "[DU HAST DIE AGGRO]";
AggroVars.ClickHint = "Tip: Linksklick um Ziel zu helfen";
AggroVars.PossibleOptions = "Moegliche Optionen";

AggroVars.SoundOptions = {
	[0] = "AUS",
	[1] = "Immer",
	[2] = "in Gruppe",
	[3] = "in Raid",
	[4] = "in Gruppe/Raid",
}

AggroVars.ReportChans_Text = "Berichte in Channel";
AggroVars.ReportChans = {
	[0] = "Konsole",
	[1] = "Bildschirm",
	[2] = "Sagen",
	[3] = "Schreien",
	[4] = "Gruppe",
	[5] = "Raid",
	[6] = "Gilde",
	[7] = "CT_RaidAssist",
	[8] = "Ziel anfluestern",
}

AggroVars.ReportTypes_Text = "Meldung wenn Aggro wechselt auf";
AggroVars.ReportTypesCustom_Text = "Custom";
AggroVars.ReportTypes = {
	[1] = "Alle",
	[2] = "Alle ausser Krieger",
	[3] = "DMG Dealer",
	[4] = "Schurken/Jaeger",
	[5] = "Alle Caster",
	[6] = "DMG Caster",
	[7] = "Heiler",
	[8] = "Krieger/Paladin",
	[9] = "Nur Krieger",
	[10] = "Mich",
}

AggroVars.ReportTimes_Text = "Zeit zwischen Meldungen";
AggroVars.ReportTimes = {
	[0] = "Keine",
	[1] = "3sek",
	[2] = "6sek",
	[3] = "10sek",
	[4] = "15sek",
	[5] = "20sek",
	[6] = "30sek",
	[7] = "60sek",
}

AggroVars.ReportFormats_Text = "Ausgabe der Meldung";
AggroVars.ReportFormats = {
	[0] = "%s wechselt Ziel auf %s",
	[1] = "%s -> %s",
	[2] = "%s@%s",
}


AggroVars.AggroDetect_Text = "Auto-Detect Aggro Using";
AggroVars.AggroDetectGroups = {
	[0] = "AUS",
	[1] = "Spieler",
	[2] = "Gruppe",
	[3] = "Raid",
}
AggroVars.AggroDetectPets_Text = "Include Pets";

AggroVars.TargetedBy_Text = "Mobs targetting ";
AggroVars.TargetedBy_Extra = "\n\t-> ";
