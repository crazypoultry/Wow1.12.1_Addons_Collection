--[[
   à : \195\160    è : \195\168    ì : \195\172    ò : \195\178    ù : \195\185
   á : \195\161    é : \195\169    í : \195\173    ó : \195\179    ú : \195\186
   â : \195\162    ê : \195\170    î : \195\174    ô : \195\180    û : \195\187
   ã : \195\163    ë : \195\171    ï : \195\175    õ : \195\181    ü : \195\188
   ä : \195\164                    ñ : \195\177    ö : \195\182
   æ : \195\166                                    ø : \195\184
   ç : \195\167
   
   Ä : \195\132
   Ö : \195\150
   Ü : \195\156
   ß : \195\159
--]]

--if (GetLocale()) then
if (GetLocale() == "deDE") then

RAIDHEALER_NAME 					= "RaidHealer";
RAIDHEALER_CLOSE 					= "Schlie\195\159en";
RAIDHEALER_LOADED						= "geladen";

RAIDHEALER_TAB1_TEXT				= "Heiler-Zuteilung";
RAIDHEALER_TAB2_TEXT				= "Buff-Zuteilung";
RAIDHEALER_TAB3_TEXT				= "Konfiguration";

RAIDHEALER_ANNOUNCE					= "Ank\195\188ndigen";
RAIDHEALER_ONLY_CLASS				= "Nur Klasse";
RAIDHEALER_ONLY_BUFF				= "Nur Buff";
RAIDHEALER_RESET						= "L\195\182schen";
RAIDHEALER_HEALCLASSES_TXT	= "Heil-Klassen";
RAIDHEALER_UNASSIGNED				= "Ohne Zuteilung";
RAIDHEALER_AUTOMATIC				= "Automatisch";

RAIDHEALER_GROUP					= "Gruppe ";

RAIDHEALER_HA_DESC					= "Ordne Heiler Tanks durch klicken auf CheckBoxen zu. Danach poste die Verteilung im Chat/Whisper.";
RAIDHEALER_YOU_HEAL					= "Du heilst ";
RAIDHEALER_YOU_HEAL_NOTHING			= "Bitte heile Querbeet.";
RAIDHEALER_HEALS					= " heilt ";

RAIDHEALER_BA_DESC					= "Ordne Spieler Gruppen durch klicken auf CheckBoxen zu. Danach poste die Verteilung im Chat/Whisper.";
RAIDHEALER_YOU_BUFF					= "Du buffst bitte ";
RAIDHEALER_YOU_BUFF_NOTHING			= "Du brauchst niemanden buffen. Achte auf fehlende Buffs.";
RAIDHEALER_BUFFS					= " bufft ";

RAIDHEALER_HEAL_ASSIGNMENT			= "Achtung: Heilerzuteilung";
RAIDHEALER_HEAL_ASSIGNMENT_SEP		= "-------------------------------------------------------";
RAIDHEALER_BUFF_ASSIGNMENT			= "Achtung: Buffzuteilung";
RAIDHEALER_BUFF_ASSIGNMENT_SEP		= "-------------------------------------------------------";

RAIDHEALER_ONLYINRAID				= "Alle Funktionen sind nur in einer Raidgruppe verf\195\188gbar.";
RAIDHEALER_ONLYINRAID_INFO	= "Das Info-Fenster ist nur im Raid verf\195\188gbar.";

RAIDHEALER_WHISPER_SETUP				= "Fl\195\188ster-Einstellungen";
RAIDHEALER_WHISPER_ASSIGNMENT		= "Fl\195\188stere Zuteilungen";
RAIDHEALER_WHISPER_HIDE_OUTGOING	= "Verstecke eingeh. Fl\195\188stern";
RAIDHEALER_WHISPER_HIDE_INCOMMING	= "Verstecke ausgeh. Fl\195\188stern";

RAIDHEALER_CHANNEL_SETUP					= "Channel-Einstellungen";
RAIDHEALER_SPECIALGLOBALCHANNELS	= { "SucheNachGruppe", "WeltVerteidigung" };

RAIDHEALER_MINIMAP_SETUP					= "Minimap-Einstellungen";
RAIDHEALER_SHOW_MINIMAP_BUTTON		= "Zeige Minimap-Button";
RAIDHEALER_MINIMAP_PLACEMENT			= "Button-Position";

RAIDHEALER_ANNOUNCEMENTS_SETUP		= "Ank\195\188ndigungs-Einstellungen";
RAIDHEALER_ANNOUNCEMENTS_ALT			= "Alternative Ank\195\188ndigungen";
RAIDHEALER_ANNOUNCEMENTS_ALT_TT		= "Ausw\195\164hlen wenn Tanks mit ihren Heilern gezeigt werden sollen. Nicht auswählen";
RAIDHEALER_ANNOUNCEMENTS_HEAL			= "Verstecke Heil-Zuteilungen";
RAIDHEALER_ANNOUNCEMENTS_BUFF			= "Verstecke Heil-Zuteilungen";
RAIDHEALER_ANNOUNCEMENTS_HIDE_TT	= "Ausw\195\164hlen wenn die Zuteilung nicht im chat gepostet werden soll. Es wirt trotzdem gefl\195\188stert wenn es eingestellt ist.";


RAIDHEALER_INNERVATE_SETUP				= "Anregen-Einstellungen (nur Druiden)";
RAIDHEALER_INNERVATE_ALERT				= "Priester Mana-Bar anzeigen";
RAIDHEALER_INNERVATE_ALERT_TT			= "Zeigt die Mana-Leiste des Priesters mit dem geringsten Mana unter dem angegebenen Prozentwert an.\n\nLinks-Click nimmt den Spieler ins Target.\n\nRechts-Click wirkt Anregen wenn es kein Cooldown hat oder der Priester nicht schon Anregen erhalten hat.";
RAIDHEALER_INNERVATE_ALERT_VALUE	= "Anzeigen wenn Priester \nweniger als %d%% Mana hat.";
RAIDHEALER_INNERVATE_RAID					= "Anregen ansagen in /ra";
RAIDHEALER_INNERVATE_SAY					= "Anregen ansagen in /s";

RAIDHEALER_INNERVATE_ANNOUNCES		= {
	"%s ist angeregt worden. Jetzt blo\195\159 nicht gleich sterben!",
	"Mana ist Macht, %s hat nun die Macht - mach was draus.",
	"Manatr\195\164nke sind dir wohl zu schade %s. Naja, hier haste dein Anregen.",
	"%s f\195\188hlt sich angeregt.",
	"\195\156berlebenschance aller gestiegen!. %s hat gleich wieder genug Mana zum heilen."
}


RAIDHEALER_NOT_IN_GROUP						= "Du befindest dich nicht im meiner Raid-Gruppe.";
RAIDHEALER_NOT_A_HEALER						= "Du hast doch gar keinen Heilzauber!";
RAIDHEALER_NOT_A_BUFFER						= "Du hast doch gar keinen richtigen Buff zu vergeben.";

RAIDHEALER_TANK_DD_TOOLTIP				= "Gew\195\188nschte Tank-Klasse w\195\164hlen.";

RAIDHEALER_SHOW_INFOFRAME_NOTE		= "Zum erneuten Anzeigen des Info-Fensters gib /rh info ein.";

RAIDHEALER_CLASS_NAMES				= {
	["WARRIOR"]	= "Krieger",
	["PRIEST"]	= "Priester",
	["PALADIN"]	= "Paladin",
	["DRUID"]	= "Druide",
	["SHAMAN"]	= "Schamane",
	["WARLOCK"]	= "Hexenmeister",
	["MAGE"]	= "Magier",
	["ROGUE"]	= "Schurke",
	["HUNTER"]	= "J\195\164ger"
};

end