if (GetLocale() ~= "frFR") then
	return;
end
TITAN_AGGRO_BUTTON_LABEL = "Cible: ";
BINDING_HEADER_TITANAGGRO_MENU = "TitanAggro";
BINDING_NAME_TITANAGGRO_REPORT = "Activer l'annonce";
AggroVars.Inactive_Text = "Inactif";
AggroVars.DoReports_Text = "Annoncer";
AggroVars.TankMode_Text = "Mode Tank";
AggroVars.ShowTTStatus_Text = "Voir PV/PM de la cible de la cible";
AggroVars.HideFlashingBackground_Text = "Cacher le font clignotant PV/PM";
AggroVars.RelocateTTStatus_Text = "Remplacer PV/PM";
AggroVars.MoveableTT_HP_Text = "Status PV/PM d\195\169pla\195\167ables";
AggroVars.MoveTT_HP_Text = "D\195\169placer le panneau (d\195\169buter le mouvement)";
AggroVars.FixTT_HP_Text = "Fixer la position du panneau (stopper le mouvement)";
AggroVars.ResetTT_HPPosition_Text = "Position par d\195\169faut du panneau";
AggroVars.Sounds_Text = "Son quand l'aggro change";
AggroVars.YouGotTheAggro_Text = "VOUS AVEZ L\'AGGRO !";
AggroVars.ClickHint = "Astuce: clic-gauche pour assister la cible";
AggroVars.PossibleOptions = "Options possible";

AggroVars.SoundOptions = {
	[0] = "D\195\169sactiv\195\169",
	[1] = "Toujours",
	[2] = "En groupe",
	[3] = "En raid",
	[4] = "En groupe/raid",
}

AggroVars.ReportChans_Text = "Annoncer dans ";
AggroVars.ReportChans = {
	[0] = "Console",
	[1] = "Ecran",
	[2] = "Dire",
	[3] = "Crier",
	[4] = "Groupe",
	[5] = "Raid",
	[6] = "Guilde",
	[7] = "CT_RaidAssist",
	[8] = "Chuchotter \195\160 la cible",
}

AggroVars.ReportTypes_Text = "Annoncer les changements de cible sur ";
AggroVars.ReportTypesCustom_Text = "Personnel";
AggroVars.ReportTypes = {
	[1] = "Tous",
	[2] = "Tous sauf guerriers",
	[3] = "DMG Dealers",
	[4] = "Voleurs/Chasseurs",
	[5] = "Lanceurs de sort",
	[6] = "DMG Casters",
	[7] = "Soigneurs",
	[8] = "Guerriers/Paladins",
	[9] = "Guerriers seulement",
	[10] = "Moi",
}

AggroVars.ReportTimes_Text = "Delais entre les annonces (secondes)";
AggroVars.ReportTimes = {
	[0] = "D\195\169sactiv\195\169",
	[1] = "3",
	[2] = "6",
	[3] = "10",
	[4] = "15",
	[5] = "20",
	[6] = "30",
	[7] = "60",
}

AggroVars.ReportFormats_Text = "Format de l'annonce";
AggroVars.ReportFormats = {
	[0] = "%s a chang\195\169 de cible, nouvelle cible: %s",
	[1] = "%s -> %s",
	[2] = "%s@%s",
}


AggroVars.AggroDetect_Text = "Auto-detect de l'aggro par ";
AggroVars.AggroDetectGroups = {
	[0] = "D\195\169sactiv\195\169",
	[1] = "Joueur",
	[2] = "Groupe",
	[3] = "Raid",
}
AggroVars.AggroDetectPets_Text = "Inclure les familiers";

AggroVars.TargetedBy_Text = "Cible des mobs ";
AggroVars.TargetedBy_Extra = "\n\t-> ";
