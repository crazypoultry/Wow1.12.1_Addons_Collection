-- We'll just add to NanoStatsLocals instead of creating another global and another table

if ( GetLocale() == "enUS" ) then

	NanoStatsLocals.FuCONFIG_DURATIONINPANEL = "Show Duration in Panel"
	NanoStatsLocals.FuCONFIG_DAMAGEINPANEL = "Show Damage in Panel"
	NanoStatsLocals.FuCONFIG_SESSIONDAMAGEINPANEL = "Show Session Damage in Panel"
	NanoStatsLocals.FuCONFIG_HEALINGINPANEL = "Show Healing in Panel"
	NanoStatsLocals.FuCONFIG_SESSIONHEALINGINPANEL = "Show Session Healing in Panel"
	NanoStatsLocals.FuCONFIG_SHORTERDISPLAYFORMAT = "Shorter display Format"	

elseif ( GetLocale() == "frFR" ) then

-- Googled. Get a human to check all these
	NanoStatsLocals.FuCONFIG_DURATIONINPANEL = "Montrer dans le panneau"
	NanoStatsLocals.FuCONFIG_DAMAGEINPANEL = "Montrer Dommages dans le panneau"
	NanoStatsLocals.FuCONFIG_SESSIONDAMAGEINPANEL = "Montrer S\195\169ance Dommages dans le panneau"
	NanoStatsLocals.FuCONFIG_HEALINGINPANEL = "Montrer Soin dans le panneau"
	NanoStatsLocals.FuCONFIG_SESSIONHEALINGINPANEL = "Montrer S\195\169ance Soins dans le panneau"
	NanoStatsLocals.FuCONFIG_SHORTERDISPLAYFORMAT = "Affichage plus court" -- Is actually a translation of "Shorter display" for brevity

elseif ( GetLocale() == "deDE" ) then -- deDE locals by Elkano

	NanoStatsLocals.FuCONFIG_DURATIONINPANEL = "Zeige Dauer im Fenster"
	NanoStatsLocals.FuCONFIG_DAMAGEINPANEL = "Zeige Schaden im Fenster"
	NanoStatsLocals.FuCONFIG_SESSIONDAMAGEINPANEL = "Zeige Sitzungs-Schaden im Fenster"
	NanoStatsLocals.FuCONFIG_HEALINGINPANEL = "Zeige Heilung im Fenster"
	NanoStatsLocals.FuCONFIG_SESSIONHEALINGINPANEL = "Zeige Sitzungs-Heilung im Fenster"
	NanoStatsLocals.FuCONFIG_SHORTERDISPLAYFORMAT = "K\195\188rzeres Anzeigeformat" -- Googled. Get a human to check

end