--
-- Healing estimator getman localization
-- Thanks to coalado
-- Also like to thank bregan and hrym for fixes
--

if(GetLocale()=="deDE") then

	-- Localize key-binding texts
	BINDING_HEADER_HEALINGESTIMATOR_HEADER = "Healing Estimator";
	BINDING_NAME_HEALINGESTIMATOR_CANCEL = "Cancel overhealing";

	-- Localize other texts
	HealingEstimatorLoc =
		{
		Welcome		= "Healing Estimator "..HEALINGESTIMATOR_VERSION.." geladen";
		
		-- This infomation is readed from tooltip
		HealValue	= "(%d+) bis (%d+)";
		RankTxt		= "%((Rang %d+)%)";
		RankTooltip	= "Rang (%d+)";
		TargetName	= "<Target name>";
		
		-- Healing texts in combat log
		CritHeal	= "Besondere Heilung: (.+) heilt (.+) um (%d+)% Punkte.";
		NormHeal	= "(.+) heilt (.+) um (%d+)% Punkte.";
		HotSelf		= "Ihr erhaltet (%d+) Gesundheit durch (.+)%.";
		HotOther	= "(.+) erhält (%d+) Gesundheit durch (.+)%.";
		YouText		= "euch";
		
		-- Healing classes
		HealingClasses={"Priester", "Druide", "Paladin", "Shamane"};
		HealingSpells=
			{
			"Blitzheilung", "Gro\195\159e Heilung", "Geringes Heilen", "Heilen",
			"Heilende Berührung", "Nachwachsen",
			"Heiliges Licht", "Lichtblitz",
			"Welle der Heilung", "Gerine Welle der Heilung"
			};
		
		-- Menu text
		Scale			= "Skalierung der Heilleiste ";
		Limit			= "Overheal Warnung bei ";
		IconPos			= "Position";
		OverhealTitle	= "Healing meter config";
		BarTitle		= "Heilleiste";
		MinimapTitle	= "Minimap button";
		ShowText		= "Zeigen";
		HideText		= "Verstecken";
		ResetPosTooltip	= "Stelle die Position der Heilleiste zurück";
		HideTooltip		= "Verstecke/Zeige den minimap button";
		ClearTooltip	= "Loesche die aktuellen Heil/Overheal Daten";
		
		HideMeter		= "Overhealing meter versteckt, benutze /heal oder /healingestimator um das Menue zu zeigen.";
		ShowMeter		= "Overhealing meter sichtbar.";
		};
end
