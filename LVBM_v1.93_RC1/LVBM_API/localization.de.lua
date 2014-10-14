-- ------------------------------------------- --
-- La Vendetta Boss Mods - german localization --
--          by Destiny|Tandanu             --
-- ------------------------------------------- --

if (GetLocale() == "deDE") then
	--classes
	LVBM_MAGE		= "Magier";
	LVBM_PRIEST		= "Priester";
	LVBM_PALADIN	= "Paladin";
	LVBM_DRUID		= "Druide";
	LVBM_WARLOCK	= "Hexenmeister";
	LVBM_ROGUE		= "Schurke";
	LVBM_HUNTER		= "Jäger";
	LVBM_WARRIOR	= "Krieger";
	LVBM_SHAMAN		= "Schamane";
	
	--zones
	LVBM_NAXX			= "Naxxramas";
	LVBM_AQ40			= "Ahn'Qiraj";
	LVBM_BWL			= "Pechschwingenhort";
	LVBM_MC				= "Geschmolzener Kern";
	LVBM_AQ20			= "Ruinen von Ahn'Qiraj";
	LVBM_ZG				= "Zul'Gurub";
	LVBM_ONYXIAS_LAIR	= "Onyxias Hort";
	LVBM_DUSKWOOD		= "Dämmerwald";
	LVBM_ASHENVALE		= "Ashenvale";
	LVBM_FERALAS		= "Feralas";
	LVBM_HINTERLANDS	= "Das Hinterland";
	LVBM_BLASTED_LANDS	= "Die verwüsteten Lande";
	LVBM_AZSHARA		= "Azshara";
	LVBM_OTHER			= "Sonstige";

	--spells/buffs
	LVBM_CHARGE			= "Sturmangriff";
	LVBM_FERALCHARGE	= "Wilde Attacke";
	LVBM_BLOODRAGE		= "Blutrausch";
	LVBM_REDEMPTION		= "Geist der Erlösung";
	LVBM_FEIGNDEATH		= "Totstellen";
	LVBM_MINDCONTROL	= "Gedankenkontrolle";
	
	--key bindings
	BINDING_HEADER_LVBM	= "La Vendetta Boss Mods";
	BINDING_NAME_TOGGLE	= "GUI anzeigen";
	
	--OnLoad messages
	LVBM_LOADED			= "La Vendetta Boss Mods v%s von Destiny|Tandanu und La Vendetta|Nitram @ EU-Azshara geladen.";
	LVBM_MODS_LOADED	= "%s %s Boss Mods geladen."
	
	--Slash command messages
	LVBM_MOD_ENABLED		= "Boss Mod aktiviert.";
	LVBM_MOD_DISABLED		= "Boss Mod deaktiviert.";
	LVBM_ANNOUNCE_ENABLED	= "Ansage aktiviert.";
	LVBM_ANNOUNCE_DISABLED	= "Ansage deaktiviert.";
	LVBM_MOD_STOPPED		= "Timer angehalten.";
	LVBM_MOD_INFO			= "Boss Mod v%s von %s";
	LVBM_SLASH_HELP1		= " on/off";
	LVBM_SLASH_HELP2		= " announce on/off";
	LVBM_SLASH_HELP3		= " stop";
	LVBM_SLASH_HELP4		= "Du kannst auch %s anstelle von /%s verwenden.";
	LVBM_RANGE_CHECK		= "Weiter als 30 Meter weg: ";
	LVBM_FOUND_CLIENTS		= "%s Spieler mit Vendetta Boss Mods gefunden";
	
	--Sync options
	LVBM_SOMEONE_SET_SYNC_CHANNEL	= "%s hat den Sync Channel auf %s gesetzt.";
	LVBM_SET_SYNC_CHANNEL			= "Sync Channel wurde auf %s gesetzt.";
	LVBM_CHANNEL_NOT_SET			= "Channel nicht gesetzt. Broadcasten nicht m\195\182glich.";
	LVBM_NEED_LEADER				= "Du musst Gruppenanf\195\188hrer oder bef\195\182rdert sein um den Channel zu broadcasten!";
	LVBM_NEED_LEADER_STOP_ALL		= "Du musst Gruppenanf\195\188hrer oder bef\195\192rdert sein um diese Funktion zu verwenden!";
	LVBM_ALL_STOPPED				= "Alle Timer gestoppt.";
	LVBM_REC_STOP_ALL				= "'Stop all' Befehl von %s empfangen.";

	--Update dialog
	LVBM_UPDATE_DIALOG		= "Deine Version von La Vendetta Boss Mods ist veraltet!\n%s und %s haben Version %s.\nBitte downloade die neuste Version von www.curse-gaming.com."	
	LVBM_YOUR_VERSION_SUCKS	= "Deine Version von La Vendetta Boss Mods ist veraltet! Bitte downloade die neuste Version von www.curse-gaming.com.";
	LVBM_REQ_PATCHNOTES		= "Fordere Patchnotes von %s an...bitte warten.";
	LVBM_SHOW_PATCHNOTES	= "Patchnotes anzeigen";
	LVBM_PATCHNOTES			= "Patchnotes";

	--Status Bar Timers
	LVBM_SBT_TIMELEFT				= "Verbleibende Zeit:";
	LVBM_SBT_TIMEELAPSED			= "Verstrichene Zeit:";
	LVBM_SBT_TOTALTIME				= "Gesamte Zeit:";
	LVBM_SBT_REPETITIONS			= "Wiederholungen:";
	LVBM_SBT_INFINITE				= "unendlich";
	LVBM_SBT_BOSSMOD				= "Boss Mod:";
	LVBM_SBT_STARTEDBY				= "Gestartet von:";
	LVBM_SBT_RIGHTCLICK				= "Rechtsklick um die Bar zu verstecken.";
	LVBM_SBT_LEFTCLICK				= "Shift + Linksklick um die Bar im Chat zu schreiben.";
	LVBM_TIMER_IS_ABOUT_TO_EXPIRE	= "Timer \"%s\" läuft gleich ab!";
	LVBM_BAR_STYLE_DEFAULT			= "Standard";
	LVBM_BAR_STYLE_MODERN			= "Modern";
	LVBM_BAR_STYLE_CLOUDS			= "Wolken";
	LVBM_BAR_STYLE_PERL				= "Perl";
	
	--Combat messages
	LVBM_BOSS_ENGAGED			= "Kampf gegen %s hat begonnen. Viel Glück! :)";
	LVBM_BOSS_SYNCED_BY			= "(Sync Befehl von %s erhalten)";
	LVBM_BOSS_DOWN				= "%s tot nach %s!";
	LVBM_COMBAT_ENDED			= "Kampf hat nach %s aufgehört.";
	LVBM_DEFAULT_BUSY_MSG		= "%P ist gerade damit beschäftigt gegen %B zu kämpfen (%HP, %ALIVE/%RAID am Leben). Du wirst nach dem Kampf informiert.";
	LVBM_RAID_STATUS_WHISPER	= "%B - %HP - %ALIVE/%RAID am Leben.";
	LVBM_SEND_STATUS_INFO		= "Sende \"status\" an mich um den Status abzufragen.";
	LVBM_AUTO_RESPOND_SHORT		= "Automatisch geantwortet.";
	LVBM_AUTO_RESPOND_LONG		= "Automatisch auf ein Whisper von %s geantwortet.";
	LVBM_MISSED_WHISPERS		= "Verpasste Whisper während dem Kampf:";
	LVBM_BALCONY_PHASE			= "Balkon Phase #%s";
	
	--Misc stuff
	LVBM_YOU					= "Ihr";
	LVBM_ARE					= "seid";
	LVBM_IS						= "ist";
	LVBM_OR						= "oder";
	LVBM_AND					= "und";
	LVBM_UNKNOWN				= "unbekannt";
	LVBM_LOCAL					= "lokal";
	LVBM_DEFAULT_DESCRIPTION	= "Beschreibung nicht verfügbar";
	LVBM_SEC					= "Sek";
	LVBM_MIN					= "Min";
	LVBM_SECOND					= "Sekunde";
	LVBM_SECONDS				= "Sekunden";
	LVBM_MINUTES				= "Minuten";
	LVBM_MINUTE					= "Minute";
	LVBM_HIT					= "trifft";
	LVBM_CRIT					= "kritisch";
	LVBM_MISS					= "verfehlt";
	LVBM_DODGE					= "ausgewichen";
	LVBM_PARRY					= "parriert";
	LVBM_FROST					= "Frostschaden";
	LVBM_ARCANE					= "Arkanschaden";
	LVBM_FIRE					= "Feuerschaden";
	LVBM_HOLY					= "Heiligschaden";
	LVBM_NATURE					= "Naturschaden";
	LVBM_SHADOW					= "Schattenschaden";
	LVBM_CLOSE					= "Schließen";
	LVBM_AGGRO_FROM				= "Aggro von ";
	LVBM_SET_ICON				= "Icon setzen";
	LVBM_SEND_WHISPER			= "Whisper verschicken";
	LVBM_DEAD					= "Tot";
	LVBM_OFFLINE				= "Offline";
	LVBM_PHASE					= "Phase %s";
	LVBM_WAVE					= "Welle %s";
end