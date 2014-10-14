-- Pollymorph Helper

-- Localized global variables (in English)

POLYHELPER_NAME = "Polymorph Helper";
POLYHELPER_NAME_FULL = string.format("%s v%s", POLYHELPER_NAME, POLYHELPER_VERSION);

POLYHELPER_WELCOME = POLYHELPER_NAME_FULL.." loaded";
BINDING_HEADER_POLYHELPER = POLYHELPER_NAME;
BINDING_NAME_POLYHELPER_WARN = "Send A Warning";
BINDING_NAME_POLYHELPER_CAST = "Cast Polymorph";
BINDING_NAME_POLYHELPER_RESUME = "Resume Counter";
BINDING_NAME_POLYHELPER_RETARGET = "Retarget Morphed";

POLYHELPER_WARN_MSG = "Target Aquired for Sheeping";
POLYHELPER_CAST_MSG = "Sheeping Target";
POLYHELPER_FAIL_MSG = "Sheeping Failed";
POLYHELPER_EMOTEPREPEND = {warn="is ",cast="is ",fail="advises "};

POLYHELPER_TEXT = "Polyhelper";
POLYHELPER_DESC_TEXT = POLYHELPER_NAME..' is a WoW addon for Mages. It replaces polymorph macros out there.';
POLYHELPER_LEVEL_TEXT = "Level";
POLYHELPER_METHOD_TEXT = "Method";
POLYHELPER_CHANNEL_TEXT = "Channel";
POLYHELPER_DISABLED_TEXT = "Disabled";
POLYHELPER_CURRENT_TEXT = "Current";
POLYHELPER_STRING_TEXT = "String";

POLYHELPER_SPELLNAME_POLYMORPH = "Polymorph";
POLYHELPER_SPELLNAME_DETECTMAGIC = "Detect Magic";

POLYHELPER_CLASS_MAGE = "Mage";
POLYHELPER_CREATURE_TYPE_BEAST = "Beast";
POLYHELPER_CREATURE_TYPE_CRITTER = "Critter";
POLYHELPER_CREATURE_TYPE_HUMANOID = "Humanoid";
POLYHELPER_GENDER_MALE = "Male";
POLYHELPER_GENDER_FEMALE = "Female";

POLYHELPER_ERRORS_NOTMAGE = "Player is not a Mage.";
POLYHELPER_ERRORS_NOPOLY = "Polymorph Spell Not Found.";
POLYHELPER_ERRORS_TARGET_DEAD = "Target is Dead.";
POLYHELPER_ERRORS_TARGET_FRIEND = "Target is Friendly.";
POLYHELPER_ERRORS_TARGET_INVALIDCREATURE = "Target is not a Player,Beast,Humanoid,Critter. But a ";

POLYHELPER_WARNINGS_FADES = "PolyMorph on <<%s>> Fades in %ssec.";
POLYHELPER_WARNINGS_FADED = "PolyMorph on <<%s>> Has Faded.";
POLYHELPER_WARNINGS_BROKEN = "PolyMorph on <<%s>> Has been Broken.";
POLYHELPER_WARNINGS_FADE_TIMEOUT = "PolyMorph on <<%s>> Fade Timeout.";
POLYHELPER_WARNINGS_CAST_TIMEOUT = "PolyMorph on <<%s>> Cast Timeout.";

POLYHELPER_NOTICES_RESUME = "Resumed CountDown Timer.";


POLYHELPER_CMD_USAGE = "Polymorph Helper Usage:";
POLYHELPER_CMD_COMMANDS = "All comands can start with either /polymorphhelper, /polyhelper or /ph";
POLYHELPER_CMD_SOLO = "solo";
POLYHELPER_CMD_SOLO_INFO = "Sets the channel to use when playing solo.";
POLYHELPER_CMD_SOLO_MENU = "Channel: Solo";
POLYHELPER_CMD_SOLO_NOTICE = "Solo channel";
POLYHELPER_CMD_PARTY = "party";
POLYHELPER_CMD_PARTY_INFO = "Sets the channel to use when playing in a party.";
POLYHELPER_CMD_PARTY_MENU = "Channel: Party";
POLYHELPER_CMD_PARTY_NOTICE = "Party channel";
POLYHELPER_CMD_RAID = "raid";
POLYHELPER_CMD_RAID_INFO = "Sets the channel to use when playing in a raid.";
POLYHELPER_CMD_RAID_MENU = "Channel: Raid";
POLYHELPER_CMD_RAID_NOTICE = "Raid channel";
POLYHELPER_CMD_NOTIFYCOMBAT = "notifycombat";
POLYHELPER_CMD_NOTIFYCOMBAT_INFO = "Sets wether to notify when in combat.";
POLYHELPER_CMD_NOTIFYCOMBAT_MENU = "Notify: In Combat";
POLYHELPER_CMD_NOTIFYCOMBAT_NOTICE = "Notify when in Combat State";
POLYHELPER_CMD_NOTIFYPVP = "notifypvp";
POLYHELPER_CMD_NOTIFYPVP_INFO = "Sets wether to notify when target is a player.";
POLYHELPER_CMD_NOTIFYPVP_MENU = "Notify: In PVP";
POLYHELPER_CMD_NOTIFYPVP_NOTICE = "Notify when in PVP State";
POLYHELPER_CMD_NOTIFYRECAST = "notifyrecast";
POLYHELPER_CMD_NOTIFYRECAST_INFO = "Sets wether to notify when is recast (must be within 5 sec of it fading/being broken).";
POLYHELPER_CMD_NOTIFYRECAST_MENU = "Notify: Recast";
POLYHELPER_CMD_NOTIFYRECAST_NOTICE = "Notify on Recast State";
POLYHELPER_CMD_CDWARN = "countdownwarning";
POLYHELPER_CMD_CDWARN_DISP = "value";
POLYHELPER_CMD_CDWARN_INFO = "Sets the amount of time in seconds to start the countdown timer at.";
POLYHELPER_CMD_CDWARN_NOTICE = "Countdown Warning value";
POLYHELPER_CMD_PVPCDWARN = "pvpcountdownwarning";
POLYHELPER_CMD_PVPCDWARN_DISP = "value";
POLYHELPER_CMD_PVPCDWARN_INFO = "Sets the amount of time in seconds to start the countdown timer at when target is a player.";
POLYHELPER_CMD_PVPCDWARN_NOTICE = "Countdown Warning value";
POLYHELPER_CMD_PVPCDWARN_NOTICEXTRA = " for when target is a player";
POLYHELPER_CMD_CDDISPLAY = "countdowndisplay";
POLYHELPER_CMD_CDDISPLAY_INFO = "Displays a visual countdown timer.";
POLYHELPER_CMD_CDDISPLAY_NOTICE = "Countdown Display state";
POLYHELPER_CMD_DINGWARN = "dingonwarn";
POLYHELPER_CMD_DINGWARN_INFO = "Ding on the %ssec Fade Warning.";
POLYHELPER_CMD_DINGWARN_MENU = "Ding On Warning";
POLYHELPER_CMD_DINGWARN_NOTICE = "Ding on Warning state";
POLYHELPER_CMD_PVPDINGWARN = "pvpdingonwarn";
POLYHELPER_CMD_PVPDINGWARN_INFO = "Ding on the %ssec Fade Warning when target is a player.";
POLYHELPER_CMD_PVPDINGWARN_MENU = "Ding On Warning: PVP";
POLYHELPER_CMD_PVPDINGWARN_NOTICE = "Ding on Warning state";
POLYHELPER_CMD_PVPDINGWARN_NOTICEXTRA = " for when target is a player";
POLYHELPER_CMD_DINGFADE = "dingonfade";
POLYHELPER_CMD_DINGFADE_INFO = "Ding when it has Faded or is Broken.";
POLYHELPER_CMD_DINGFADE_MENU = "Ding On Faded";
POLYHELPER_CMD_DINGFADE_NOTICE = "Ding on Fade state";
POLYHELPER_CMD_DINGSCHEME = "dingscheme";
POLYHELPER_CMD_DINGSCHEME_DISP = "schemeid";
POLYHELPER_CMD_DINGSCHEME_INFO = "Set the ding sound scheme (1-%s).";
POLYHELPER_CMD_DINGSCHEME_MENU = "Ding Scheme ID";
POLYHELPER_CMD_DINGSCHEME_NOTICE = "Ding SchemeID";
POLYHELPER_CMD_MENUDISPLAY = "quickmenudisplay";
POLYHELPER_CMD_MENUDISPLAY_INFO = "Set wether to display the quick menu when you mouse over the timer box.";
POLYHELPER_CMD_MENUDISPLAY_NOTICE = "Quickmenu display state";
POLYHELPER_CMD_MENUPOS = "quickmenupos";
POLYHELPER_CMD_MENUPOS_INFO = "Set where to anchor the quick menu to the timer box.";
POLYHELPER_CMD_MENUPOS_NOTICE = "Quickmenu anchor position";
POLYHELPER_CMD_OHN = "overheadnotice";
POLYHELPER_CMD_OHN_INFO = "Set wether to display notices overhead.";
POLYHELPER_CMD_OHN_MENU = "Over Head Notice";
POLYHELPER_CMD_OHN_NOTICE = "Display Notices Overhead state";
POLYHELPER_CMD_OHW = "overheadwarning";
POLYHELPER_CMD_OHW_INFO = "Set wether to display warnings overhead.";
POLYHELPER_CMD_OHW_MENU = "Over Head Warning";
POLYHELPER_CMD_OHW_NOTICE = "Display Warnings Overhead state";
POLYHELPER_CMD_MSGLENGTH = "messagelength";
POLYHELPER_CMD_MSGLENGTH_INFO = "Set the Length of the message sent to your party.";
POLYHELPER_CMD_MSGLENGTH_MENU = "Message Length";
POLYHELPER_CMD_MSGLENGTH_NOTICE = "Message Length";
POLYHELPER_CMD_WARNSHOW = "warnshow";
POLYHELPER_CMD_WARNSHOW_INFO = "Cast Detect Magic on Warning.";
POLYHELPER_CMD_WARNSHOW_MENU = "Warning Show";
POLYHELPER_CMD_WARNSHOW_NOTICE = "Warning Show state";
POLYHELPER_CMD_STOPCAST = "stopcast";
POLYHELPER_CMD_STOPCAST_INFO = "Stop casting when casting polymorph.";
POLYHELPER_CMD_STOPCAST_MENU = "Stop Casting";
POLYHELPER_CMD_STOPCAST_NOTICE = "Stop Cast state";
POLYHELPER_CMD_MODE = "mode";
POLYHELPER_CMD_MODE_INFO = "Set the Mode to run Polymorph Helper in.";
POLYHELPER_CMD_MODE_NOTICE = "Mode";
POLYHELPER_CMD_HELP = "help";
POLYHELPER_CMD_HELP_INFO = "This message.";

POLYHELPER_VALID_CHANNELS = {
	SOLO = {"none", "say", "yell", "emote"},
	PARTY = {"none", "say", "yell", "emote", "party"},
	RAID = {"none", "say", "yell", "emote", "party", "raid"};
};
POLYHELPER_VALID_STATES_ONOFF = {"on", "off"};
POLYHELPER_VALID_STATES_YESNO = {"yes", "no"};
POLYHELPER_VALID_STATES_DISPLAY = {"shown", "auto", "hidden"};
POLYHELPER_VALID_STATES_ANCHOR = {"auto", "tl", "bl", "br", "tr"};
POLYHELPER_VALID_LENGTHS = {"short", "normal", "long"};
POLYHELPER_VALID_MODES = {"normal", "verbose", "debug"};

POLYHELPER_CMD_ERROR_NOTPASSED = "%s not passed%s.";
POLYHELPER_CMD_ERROR_INVALID = "%s passed was not valid%s.";
POLYHELPER_CMD_ERROR_NOTNUMBER = "%s value does not appear to be a number%s.";
POLYHELPER_CMD_ERROR_OUTOFRANGE = "%s is out of range (%s-%s)%s.";
POLYHELPER_CMD_SUCCESS = "%s set to |cffaaaaff%s|r%s.";


-- Locale strings for the deDE locale
if (GetLocale() == "deDE") then

	POLYHELPER_NAME = "Polymorph Helper";
	POLYHELPER_NAME_FULL = string.format("%s v%s", POLYHELPER_NAME, POLYHELPER_VERSION);

	POLYHELPER_WELCOME = POLYHELPER_NAME_FULL.." geladen";
	BINDING_HEADER_POLYHELPER = POLYHELPER_NAME;
	BINDING_NAME_POLYHELPER_WARN = "Warnung senden";
	BINDING_NAME_POLYHELPER_CAST = "Polymorph zaubern";
	BINDING_NAME_POLYHELPER_RESUME = "Zählung wieder aufnehmen";
	BINDING_NAME_POLYHELPER_RETARGET = "Gemorphtes Ziel anwählen";

	POLYHELPER_WARN_MSG = "Ziel für Sheepen angewählt";
	POLYHELPER_CAST_MSG = "Ziel wird gesheept";
	POLYHELPER_FAIL_MSG = "Sheepen fehlgeschlagen";
	POLYHELPER_EMOTEPREPEND = {warn="ist ",cast="ist ",fail="rät "};

	POLYHELPER_TEXT = "Polyhelper";
	POLYHELPER_DESC_TEXT = POLYHELPER_NAME..' ist ein WoW ADdon für Magier. Es ersetzt Polymorph-Macros da draußen.';
	POLYHELPER_LEVEL_TEXT = "Level";
	POLYHELPER_METHOD_TEXT = "Methode";
	POLYHELPER_CHANNEL_TEXT = "Kanal";
	POLYHELPER_DISABLED_TEXT = "Ausgeschaltet";
	POLYHELPER_CURRENT_TEXT = "Augenblicklich";
	POLYHELPER_STRING_TEXT = "String";

	POLYHELPER_SPELLNAME_POLYMORPH = "Verwandlung";
	POLYHELPER_SPELLNAME_DETECTMAGIC = "Magie entdecken";

	POLYHELPER_CLASS_MAGE = "Magier";
	POLYHELPER_CREATURE_TYPE_BEAST = "Wildtier";
	POLYHELPER_CREATURE_TYPE_CRITTER = "Tier";
	POLYHELPER_CREATURE_TYPE_HUMANOID = "Humanoid";
	POLYHELPER_GENDER_MALE = "Male";
	POLYHELPER_GENDER_FEMALE = "Female";

	POLYHELPER_ERRORS_NOTMAGE = "Spieler ist kein Magier.";
	POLYHELPER_ERRORS_NOPOLY = "Polymorph-Zauberspruch nicht gefunden.";
	POLYHELPER_ERRORS_TARGET_DEAD = "Ziel ist tot.";
	POLYHELPER_ERRORS_TARGET_FRIEND = "Befreundetes Ziel.";
	POLYHELPER_ERRORS_TARGET_INVALIDCREATURE = "Ziel ist kein Spieler,Wildtier,Humanoide oder Tier. Es ist ein(e) ";

	POLYHELPER_WARNINGS_FADES = "PolyMorph auf <<%s>> schwindet in %ssek.";
	POLYHELPER_WARNINGS_FADED = "PolyMorph auf <<%s>> ist geschwunden.";
	POLYHELPER_WARNINGS_BROKEN = "PolyMorph auf <<%s>> wurde gebrochen.";
	POLYHELPER_WARNINGS_FADE_TIMEOUT = "PolyMorph auf <<%s>> Schwinden abgelaufen.";
	POLYHELPER_WARNINGS_CAST_TIMEOUT = "PolyMorph auf <<%s>> Zaubern abgelaufen.";

	POLYHELPER_NOTICES_RESUME = "CountDown wieder aufgenommen.";


	POLYHELPER_CMD_USAGE = "Benutzeung des Polymorph Helper:";
	POLYHELPER_CMD_COMMANDS = "Alle Kommandos können mit /polymorphhelper, /polyhelper or /ph anfangen";
	POLYHELPER_CMD_SOLO = "solo";
	POLYHELPER_CMD_SOLO_INFO = "Wählt den Kanal für das Solo-Spiel aus.";
	POLYHELPER_CMD_SOLO_MENU = "Kanal: Solo";
	POLYHELPER_CMD_SOLO_NOTICE = "Solo Kanal";
	POLYHELPER_CMD_PARTY = "party";
	POLYHELPER_CMD_PARTY_INFO = "Wählt den Kanal für das Spiel in einer Gruppe aus";
	POLYHELPER_CMD_PARTY_MENU = "Kanal: Gruppe";
	POLYHELPER_CMD_PARTY_NOTICE = "Gruppenkanal";
	POLYHELPER_CMD_RAID = "raid";
	POLYHELPER_CMD_RAID_INFO = "Wählt den Kanal für das Spiel in einem Raid aus.";
	POLYHELPER_CMD_RAID_MENU = "Kanal: Raid";
	POLYHELPER_CMD_RAID_NOTICE = "Raid Kanal";
	POLYHELPER_CMD_NOTIFYCOMBAT = "notifycombat";
	POLYHELPER_CMD_NOTIFYCOMBAT_INFO = "Wählt aus, ob während eines Kampfes benachrichtgt werden soll.";
	POLYHELPER_CMD_NOTIFYCOMBAT_MENU = "Nachricht: Im Kampf";
	POLYHELPER_CMD_NOTIFYCOMBAT_NOTICE = "Nachricht während eines Kampfes";
	POLYHELPER_CMD_NOTIFYPVP = "notifypvp";
	POLYHELPER_CMD_NOTIFYPVP_INFO = "Wählt aus, ob benachrichtigt werden soll, wenn das Ziel ein anderer Spieler ist.";
	POLYHELPER_CMD_NOTIFYPVP_MENU = "Nachricht: Im PVP";
	POLYHELPER_CMD_NOTIFYPVP_NOTICE = "Nachrticht während eines PVP-Kampfs";
	POLYHELPER_CMD_NOTIFYRECAST = "notifyrecast";
	POLYHELPER_CMD_NOTIFYRECAST_INFO = "Wählt aus, ob ein erneuerter Zauber mnitgeteilt werden soll (innerhalb von 5 Sekunden nach Schwinden oder Brechen).";
	POLYHELPER_CMD_NOTIFYRECAST_MENU = "Nachricht: Erneuerter Zauber";
	POLYHELPER_CMD_NOTIFYRECAST_NOTICE = "Nachricht bei Erneuerung";
	POLYHELPER_CMD_CDWARN = "countdownwarning";
	POLYHELPER_CMD_CDWARN_DISP = "Wert";
	POLYHELPER_CMD_CDWARN_INFO = "Setzt die Zeit in Sekunden, nach der der Countdown gestartet werden soll.";
	POLYHELPER_CMD_CDWARN_NOTICE = "Countdown Warnwert";
	POLYHELPER_CMD_PVPCDWARN = "pvpcountdownwarning";
	POLYHELPER_CMD_PVPCDWARN_DISP = "Wert";
	POLYHELPER_CMD_PVPCDWARN_INFO = ".";
	POLYHELPER_CMD_PVPCDWARN_INFO = "Setzt die Zeit in Sekunden, nach der der Countdown gestartet werden soll wenn das Ziel ein anderer Spieler ist.";
	POLYHELPER_CMD_PVPCDWARN_NOTICE = "Countdown Warnwert";
	POLYHELPER_CMD_PVPCDWARN_NOTICEXTRA = " wenn das Ziel ein Spieler ist";
	POLYHELPER_CMD_CDDISPLAY = "countdowndisplay";
	POLYHELPER_CMD_CDDISPLAY_INFO = "Countdown als Fenster anzeigen.";
	POLYHELPER_CMD_CDDISPLAY_NOTICE = "Countdown Anzeige state";
	POLYHELPER_CMD_DINGWARN = "dingonwarn";
	POLYHELPER_CMD_DINGWARN_INFO = "Pling %s Sekunden vor dem Schwinden.";
	POLYHELPER_CMD_DINGWARN_MENU = "Warnung mit Pling";
	POLYHELPER_CMD_DINGWARN_NOTICE = "Pling-Warnung";
	POLYHELPER_CMD_PVPDINGWARN = "pvpdingonwarn";
	POLYHELPER_CMD_PVPDINGWARN_INFO = "Pling %s Sekunden vor dem Schwinden wenn das Ziel ein anderer Spieler ist.";
	POLYHELPER_CMD_PVPDINGWARN_MENU = "Pling-Warnung: PVP";
	POLYHELPER_CMD_PVPDINGWARN_NOTICE = "Pling-Warnung";
	POLYHELPER_CMD_PVPDINGWARN_NOTICEXTRA = " wenn das Ziel ein anderer Spieler ist";
	POLYHELPER_CMD_DINGFADE = "dingonfade";
	POLYHELPER_CMD_DINGFADE_INFO = "Pling wenn es geschwunden ist oder gebrochen wurde.";
	POLYHELPER_CMD_DINGFADE_MENU = "Pling bei Schwinden";
	POLYHELPER_CMD_DINGFADE_NOTICE = "Pling bei Schwinden";
	POLYHELPER_CMD_DINGSCHEME = "dingscheme";
	POLYHELPER_CMD_DINGSCHEME_DISP = "schemeid";
	POLYHELPER_CMD_DINGSCHEME_INFO = "Setze das PLing SoUnd Schema (1-%s).";
	POLYHELPER_CMD_DINGSCHEME_MENU = "Pling Schema ID";
	POLYHELPER_CMD_DINGSCHEME_NOTICE = "Pling SchemaID";
	POLYHELPER_CMD_MENUDISPLAY = "quickmenudisplay";
	POLYHELPER_CMD_MENUDISPLAY_INFO = "Ein/Ausschalten des Schnellmenus, wenn die Maus über dem Countdown-Fenster ist.";
	POLYHELPER_CMD_MENUDISPLAY_NOTICE = "Schnellmenu-Anzeige";
	POLYHELPER_CMD_MENUPOS = "quickmenupos";
	POLYHELPER_CMD_MENUPOS_INFO = "Verankerung des Schnellmenus am Countdown-Fenster.";
	POLYHELPER_CMD_MENUPOS_NOTICE = "Schnellmenuverankerung";
	POLYHELPER_CMD_OHN = "overheadnotice";
	POLYHELPER_CMD_OHN_INFO = "HUD-Anzeige der Informationen.";
	POLYHELPER_CMD_OHN_MENU = "HUD-Informationen";
	POLYHELPER_CMD_OHN_NOTICE = "HUD-Informationen";
	POLYHELPER_CMD_OHW = "overheadwarning";
	POLYHELPER_CMD_OHW_INFO = "HUD-Anzeige der Warnungen.";
	POLYHELPER_CMD_OHW_MENU = "HUD-Warnungen";
	POLYHELPER_CMD_OHW_NOTICE = "HUD-Warnungen";
	POLYHELPER_CMD_MSGLENGTH = "messagelength";
	POLYHELPER_CMD_MSGLENGTH_INFO = "Setze die Länge der Nachricht, die an die Gruppe gesendet wird..";
	POLYHELPER_CMD_MSGLENGTH_MENU = "Länge der Gruppennachricht";
	POLYHELPER_CMD_MSGLENGTH_NOTICE = "Länge der Gruppennachricht";
	POLYHELPER_CMD_WARNSHOW = "warnshow";
	POLYHELPER_CMD_WARNSHOW_INFO = "\"Magie entdecken\" zaubern bei Warnung.";
	POLYHELPER_CMD_WARNSHOW_MENU = "Warnung->\"Magie entdecken\"";
	POLYHELPER_CMD_WARNSHOW_NOTICE = "Warnung->\"Magie entdecken\"";
	POLYHELPER_CMD_STOPCAST = "stopcast";
	POLYHELPER_CMD_STOPCAST_INFO = "Zaubern abbrechen, wenn Polymorph ausgelöst wird.";
	POLYHELPER_CMD_STOPCAST_MENU = "Zaubern abbrechen";
	POLYHELPER_CMD_STOPCAST_NOTICE = "Zaubern abbrechen";
	POLYHELPER_CMD_MODE = "mode";
	POLYHELPER_CMD_MODE_INFO = "Setzen des Modus, in dem Polymorph Helper läuft.";
	POLYHELPER_CMD_MODE_NOTICE = "Modus";
	POLYHELPER_CMD_HELP = "help";
	POLYHELPER_CMD_HELP_INFO = "Diese Beschreibung.";

	POLYHELPER_VALID_CHANNELS = {
		SOLO = {"none", "say", "yell", "emote"},
		PARTY = {"none", "say", "yell", "emote", "party"},
		RAID = {"none", "say", "yell", "emote", "party", "raid"};
	};
	POLYHELPER_VALID_STATES_ONOFF = {"on", "off"};
	POLYHELPER_VALID_STATES_YESNO = {"yes", "no"};
	POLYHELPER_VALID_STATES_DISPLAY = {"shown", "auto", "hidden"};
	POLYHELPER_VALID_STATES_ANCHOR = {"auto", "tl", "bl", "br", "tr"};
	POLYHELPER_VALID_LENGTHS = {"short", "normal", "long"};
	POLYHELPER_VALID_MODES = {"normal", "verbose", "debug"};

	POLYHELPER_CMD_ERROR_NOTPASSED = "%s nicht mitgegeben%s.";
	POLYHELPER_CMD_ERROR_INVALID = "%s passed was not valid%s.";
	POLYHELPER_CMD_ERROR_INVALID = "Übergebene(r) %s ungültig%s.";
	POLYHELPER_CMD_ERROR_NOTNUMBER = "%s sieht nicht wie eine Zahl aus%s.";
	POLYHELPER_CMD_ERROR_OUTOFRANGE = "%s außerhalb des Bereichs (%s-%s)%s.";
	POLYHELPER_CMD_SUCCESS = "%s gesetzt auf |cffaaaaff%s|r%s.";

-- Locale strings for the esES locale
elseif (GetLocale() == "esES") then

-- Locale strings for the frFR locale
elseif (GetLocale() == "frFR") then

	POLYHELPER_NAME = "Polymorph Helper";
	POLYHELPER_NAME_FULL = string.format("%s v%s", POLYHELPER_NAME, POLYHELPER_VERSION);

	POLYHELPER_WELCOME = POLYHELPER_NAME_FULL.." charge";
	BINDING_HEADER_POLYHELPER = POLYHELPER_NAME;
	BINDING_NAME_POLYHELPER_WARN = "Envoyer un avertissement";
	BINDING_NAME_POLYHELPER_CAST = "Lancer un sheep";
	BINDING_NAME_POLYHELPER_RESUME = "Reprendre compteur";
	BINDING_NAME_POLYHELPER_RETARGET = "Reciblez précédent";

	POLYHELPER_WARN_MSG = "Cible acquise pour sheep";
	POLYHELPER_CAST_MSG = "Sheep en cours";
	POLYHELPER_FAIL_MSG = "Sheep raté";
	POLYHELPER_EMOTEPREPEND = {warn="est ",cast="est ",fail="conseil "};

	POLYHELPER_TEXT = "Polyhelper";
	POLYHELPER_DESC_TEXT = POLYHELPER_NAME..' is a WoW addon for Mages. It replaces polymorph macros out there.';
	POLYHELPER_LEVEL_TEXT = "Niveau";
	POLYHELPER_METHOD_TEXT = "Methode";
	POLYHELPER_CHANNEL_TEXT = "Channel";
	POLYHELPER_DISABLED_TEXT = "Désactivé";
	POLYHELPER_CURRENT_TEXT = "Courrant";
	POLYHELPER_STRING_TEXT = "String";

	POLYHELPER_SPELLNAME_POLYMORPH = "Métamorphose";
	POLYHELPER_SPELLNAME_DETECTMAGIC = "Détection de la magie";

	POLYHELPER_CLASS_MAGE = "Mage";
	POLYHELPER_CREATURE_TYPE_BEAST = "Bête";
	POLYHELPER_CREATURE_TYPE_CRITTER = "Bestiole";
	POLYHELPER_CREATURE_TYPE_HUMANOID = "Humanoïde";
	POLYHELPER_GENDER_MALE = "Male";
	POLYHELPER_GENDER_FEMALE = "Femelle";

	POLYHELPER_ERRORS_NOTMAGE = "Le joueur n'est pas un Mage.";
	POLYHELPER_ERRORS_NOPOLY = "Sort Métamorphose non trouvé.";
	POLYHELPER_ERRORS_TARGET_DEAD = "La cible est morte.";
	POLYHELPER_ERRORS_TARGET_FRIEND = "La cible est amie.";
	POLYHELPER_ERRORS_TARGET_INVALIDCREATURE = "La cible n'est pas un joueur,une bête, un humanoïde, un critter, mais un  ";

	POLYHELPER_WARNINGS_FADES = "Métamorphose sur <<%s>> se dissipe dans %ssec.";
	POLYHELPER_WARNINGS_FADED = "Métamorphose sur <<%s>> s'est dissipé.";
	POLYHELPER_WARNINGS_BROKEN = "Métamorphose sur <<%s>> a été cassé.";
	POLYHELPER_WARNINGS_FADE_TIMEOUT = "Métamorphose sur <<%s>> dissipation timeout.";
	POLYHELPER_WARNINGS_CAST_TIMEOUT = "Métamorphose sur <<%s>> lancement timeout.";

	POLYHELPER_NOTICES_RESUME = "CountDown Timer repris.";


	POLYHELPER_CMD_USAGE = "Polymorph Helper Usage:";
	POLYHELPER_CMD_COMMANDS = "All comands can start with either /polymorphhelper, /polyhelper or /ph";
	POLYHELPER_CMD_SOLO = "solo";
	POLYHELPER_CMD_SOLO_INFO = "Sets the channel to use when playing solo.";
	POLYHELPER_CMD_SOLO_MENU = "Channel: Solo";
	POLYHELPER_CMD_SOLO_NOTICE = "Solo channel";
	POLYHELPER_CMD_PARTY = "party";
	POLYHELPER_CMD_PARTY_INFO = "Sets the channel to use when playing in a party.";
	POLYHELPER_CMD_PARTY_MENU = "Channel: Party";
	POLYHELPER_CMD_PARTY_NOTICE = "Party channel";
	POLYHELPER_CMD_RAID = "raid";
	POLYHELPER_CMD_RAID_INFO = "Sets the channel to use when playing in a raid.";
	POLYHELPER_CMD_RAID_MENU = "Channel: Raid";
	POLYHELPER_CMD_RAID_NOTICE = "Raid channel";
	POLYHELPER_CMD_NOTIFYCOMBAT = "notifycombat";
	POLYHELPER_CMD_NOTIFYCOMBAT_INFO = "Sets wether to notify when in combat.";
	POLYHELPER_CMD_NOTIFYCOMBAT_MENU = "Notify: In Combat";
	POLYHELPER_CMD_NOTIFYCOMBAT_NOTICE = "Notify when in Combat State";
	POLYHELPER_CMD_NOTIFYPVP = "notifypvp";
	POLYHELPER_CMD_NOTIFYPVP_INFO = "Sets wether to notify when target is a player.";
	POLYHELPER_CMD_NOTIFYPVP_MENU = "Notify: In PVP";
	POLYHELPER_CMD_NOTIFYPVP_NOTICE = "Notify when in PVP State";
	POLYHELPER_CMD_NOTIFYRECAST = "notifyrecast";
	POLYHELPER_CMD_NOTIFYRECAST_INFO = "Sets wether to notify when is recast (must be within 5 sec of it fading/being broken).";
	POLYHELPER_CMD_NOTIFYRECAST_MENU = "Notify: Recast";
	POLYHELPER_CMD_NOTIFYRECAST_NOTICE = "Notify on Recast State";
	POLYHELPER_CMD_CDWARN = "countdownwarning";
	POLYHELPER_CMD_CDWARN_DISP = "value";
	POLYHELPER_CMD_CDWARN_INFO = "Sets the amount of time in seconds to start the countdown timer at.";
	POLYHELPER_CMD_CDWARN_NOTICE = "Countdown Warning value";
	POLYHELPER_CMD_PVPCDWARN = "pvpcountdownwarning";
	POLYHELPER_CMD_PVPCDWARN_DISP = "value";
	POLYHELPER_CMD_PVPCDWARN_INFO = "Sets the amount of time in seconds to start the countdown timer at when target is a player.";
	POLYHELPER_CMD_PVPCDWARN_NOTICE = "Countdown Warning value";
	POLYHELPER_CMD_PVPCDWARN_NOTICEXTRA = " for when target is a player";
	POLYHELPER_CMD_CDDISPLAY = "countdowndisplay";
	POLYHELPER_CMD_CDDISPLAY_INFO = "Displays a visual countdown timer.";
	POLYHELPER_CMD_CDDISPLAY_NOTICE = "Countdown Display state";
	POLYHELPER_CMD_DINGWARN = "dingonwarn";
	POLYHELPER_CMD_DINGWARN_INFO = "Ding on the %ssec Fade Warning.";
	POLYHELPER_CMD_DINGWARN_MENU = "Ding On Warning";
	POLYHELPER_CMD_DINGWARN_NOTICE = "Ding on Warning state";
	POLYHELPER_CMD_PVPDINGWARN = "pvpdingonwarn";
	POLYHELPER_CMD_PVPDINGWARN_INFO = "Ding on the %ssec Fade Warning when target is a player.";
	POLYHELPER_CMD_PVPDINGWARN_MENU = "Ding On Warning: PVP";
	POLYHELPER_CMD_PVPDINGWARN_NOTICE = "Ding on Warning state";
	POLYHELPER_CMD_PVPDINGWARN_NOTICEXTRA = " for when target is a player";
	POLYHELPER_CMD_DINGFADE = "dingonfade";
	POLYHELPER_CMD_DINGFADE_INFO = "Ding when it has Faded or is Broken.";
	POLYHELPER_CMD_DINGFADE_MENU = "Ding On Faded";
	POLYHELPER_CMD_DINGFADE_NOTICE = "Ding on Fade state";
	POLYHELPER_CMD_DINGSCHEME = "dingscheme";
	POLYHELPER_CMD_DINGSCHEME_DISP = "schemeid";
	POLYHELPER_CMD_DINGSCHEME_INFO = "Set the ding sound scheme (1-%s).";
	POLYHELPER_CMD_DINGSCHEME_MENU = "Ding Scheme ID";
	POLYHELPER_CMD_DINGSCHEME_NOTICE = "Ding SchemeID";
	POLYHELPER_CMD_MENUDISPLAY = "quickmenudisplay";
	POLYHELPER_CMD_MENUDISPLAY_INFO = "Set wether to display the quick menu when you mouse over the timer box.";
	POLYHELPER_CMD_MENUDISPLAY_NOTICE = "Quickmenu display state";
	POLYHELPER_CMD_MENUPOS = "quickmenupos";
	POLYHELPER_CMD_MENUPOS_INFO = "Set where to anchor the quick menu to the timer box.";
	POLYHELPER_CMD_MENUPOS_NOTICE = "Quickmenu anchor position";
	POLYHELPER_CMD_OHN = "overheadnotice";
	POLYHELPER_CMD_OHN_INFO = "Set wether to display notices overhead.";
	POLYHELPER_CMD_OHN_MENU = "Over Head Notice";
	POLYHELPER_CMD_OHN_NOTICE = "Display Notices Overhead state";
	POLYHELPER_CMD_OHW = "overheadwarning";
	POLYHELPER_CMD_OHW_INFO = "Set wether to display warnings overhead.";
	POLYHELPER_CMD_OHW_MENU = "Over Head Warning";
	POLYHELPER_CMD_OHW_NOTICE = "Display Warnings Overhead state";
	POLYHELPER_CMD_MSGLENGTH = "messagelength";
	POLYHELPER_CMD_MSGLENGTH_INFO = "Set the Length of the message sent to your party.";
	POLYHELPER_CMD_MSGLENGTH_MENU = "Message Length";
	POLYHELPER_CMD_MSGLENGTH_NOTICE = "Message Length";
	POLYHELPER_CMD_WARNSHOW = "warnshow";
	POLYHELPER_CMD_WARNSHOW_INFO = "Cast Detect Magic on Warning.";
	POLYHELPER_CMD_WARNSHOW_MENU = "Warning Show";
	POLYHELPER_CMD_WARNSHOW_NOTICE = "Warning Show state";
	POLYHELPER_CMD_STOPCAST = "stopcast";
	POLYHELPER_CMD_STOPCAST_INFO = "Stop casting when casting polymorph.";
	POLYHELPER_CMD_STOPCAST_MENU = "Stop Casting";
	POLYHELPER_CMD_STOPCAST_NOTICE = "Stop Cast state";
	POLYHELPER_CMD_MODE = "mode";
	POLYHELPER_CMD_MODE_INFO = "Set the Mode to run Polymorph Helper in.";
	POLYHELPER_CMD_MODE_NOTICE = "Mode";
	POLYHELPER_CMD_HELP = "help";
	POLYHELPER_CMD_HELP_INFO = "This message.";

	POLYHELPER_VALID_CHANNELS = {
		SOLO = {"none", "say", "yell", "emote"},
		PARTY = {"none", "say", "yell", "emote", "party"},
		RAID = {"none", "say", "yell", "emote", "party", "raid"};
	};
	POLYHELPER_VALID_STATES_ONOFF = {"on", "off"};
	POLYHELPER_VALID_STATES_YESNO = {"yes", "no"};
	POLYHELPER_VALID_STATES_DISPLAY = {"shown", "auto", "hidden"};
	POLYHELPER_VALID_STATES_ANCHOR = {"auto", "tl", "bl", "br", "tr"};
	POLYHELPER_VALID_LENGTHS = {"short", "normal", "long"};
	POLYHELPER_VALID_MODES = {"normal", "verbose", "debug"};

	POLYHELPER_CMD_ERROR_NOTPASSED = "%s not passed%s.";
	POLYHELPER_CMD_ERROR_INVALID = "%s passed was not valid%s.";
	POLYHELPER_CMD_ERROR_NOTNUMBER = "%s value does not appear to be a number%s.";
	POLYHELPER_CMD_ERROR_OUTOFRANGE = "%s is out of range (%s-%s)%s.";
	POLYHELPER_CMD_SUCCESS = "%s set to |cffaaaaff%s|r%s.";

end


POLYHELPER_GLOBAL_VALID_CHANNELS = {
	SOLO = {"none", "say", "yell", "emote"},
	PARTY = {"none", "say", "yell", "emote", "party"},
	RAID = {"none", "say", "yell", "emote", "party", "raid"};
};
POLYHELPER_GLOBAL_VALID_STATES_ONOFF = {"on", "off"};
POLYHELPER_GLOBAL_VALID_STATES_YESNO = {"yes", "no"};
POLYHELPER_GLOBAL_VALID_STATES_DISPLAY = {"shown", "auto", "hidden"};
POLYHELPER_GLOBAL_VALID_STATES_ANCHOR = {"auto", "tl", "bl", "br", "tr"};
POLYHELPER_GLOBAL_VALID_LENGTHS = {"short", "normal", "long"};
POLYHELPER_GLOBAL_VALID_MODES = {"normal", "verbose", "debug"};

