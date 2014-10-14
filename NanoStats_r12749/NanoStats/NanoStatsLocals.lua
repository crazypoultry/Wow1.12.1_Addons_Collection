NanoStatsLocals = {
	NAME = "NanoStats",
	DESCRIPTION = "Simple personal healing/damage stats.",
	COMMANDS = {"/nanostats", "/ns", "/nstats"},
	CMD_OPTIONS = {},

    VERSION = "1.5",
    RELEASEDATE = "2006-06-05",

    -- Stuff used in display 
    WORD_DAMAGE = "Damage",
    WORD_HEALING = "Healing",
    WORD_SESSION = "Session ", -- Space is intended, see deDE entry
	WORD_DURATION = "Duration",
    MESSAGE_NODATA = "No data - Go fight something!",

    -- Config stuff
    CONFIG_TOGGLEDAMAGE = "Toggle Damage",
    CONFIG_TOGGLEHEALING = "Toggle Healing",
    CONFIG_TOGGLESESSIONDAMAGE = "Toggle Session Damage",
    CONFIG_TOGGLESESSIONHEALING = "Toggle Session Healing",
	CONFIG_TOGGLEDURATION = "Toggle Duration",
	CONFIG_RESETSESSION = "Reset Session",
}

if ( GetLocale() == "frFR" ) then -- Googled. Get a human to check all these

	NanoStatsLocals.DESCRIPTION = "Stat personnelle simple soins/dommages"
    
    NanoStatsLocals.WORD_DAMAGE = "Dommages"
    NanoStatsLocals.WORD_HEALING = "Soins"
    NanoStatsLocals.WORD_SESSION = "S\195\169ance " -- Space is intended, see deDE entry
	NanoStatsLocals.WORD_DURATION = "Dur\195\169e"
    NanoStatsLocals.MESSAGE_NODATA = "Aucunes donn\195\169es - Disparaissent le combat!"

    NanoStatsLocals.CONFIG_TOGGLEDAMAGE = "Cabillot Dommages"
    NanoStatsLocals.CONFIG_TOGGLEHEALING = "Cabillot Soins"
    NanoStatsLocals.CONFIG_TOGGLESESSIONDAMAGE = "Cabillot S\195\169ance Dommages"
    NanoStatsLocals.CONFIG_TOGGLESESSIONHEALING = "Cabillot S\195\169ance Soins"
	NanoStatsLocals.CONFIG_TOGGLEDURATION = "Cabillot Dur\195\169e"
    NanoStatsLocals.CONFIG_RESETSESSION = "Remise S\195\169ance"
end

if ( GetLocale() == "deDE" ) then -- DE locals by Elkano and Ammo

    NanoStatsLocals.DESCRIPTION = "Einfache pers\195\182nliche Heilungs-/Schadensstatistiken"
    
    NanoStatsLocals.WORD_DAMAGE = "Schaden"
    NanoStatsLocals.WORD_HEALING = "Heilung"
    NanoStatsLocals.WORD_SESSION = "Sitzungs-" -- In German, "Session X" is "Sitzungs-X" so we need to accommodate
	NanoStatsLocals.WORD_DURATION = "Dauer"
    NanoStatsLocals.MESSAGE_NODATA = "Keine Daten - Geh etwas bek\195\164mpfen!"
    
    NanoStatsLocals.CONFIG_TOGGLEDAMAGE = "Zeige Schaden"
    NanoStatsLocals.CONFIG_TOGGLEHEALING = "Zeige Heilung"
    NanoStatsLocals.CONFIG_TOGGLESESSIONDAMAGE = "Zeige Sitzungs-Schaden"
    NanoStatsLocals.CONFIG_TOGGLESESSIONHEALING = "Zeige Sitzungs-Heilung"
	NanoStatsLocals.CONFIG_TOGGLEDURATION = "Zeige Dauer"
    NanoStatsLocals.CONFIG_RESETSESSION = "Sitzung zur\195\188cksetzen"
end
