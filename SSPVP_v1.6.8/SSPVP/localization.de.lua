--[[
************
** GERMAN **
************
]]

if( GetLocale() == "deDE" ) then
-- Battleground names
SS_WARSONGGULCH = "Warsongschlucht";
SS_ALTERACVALLEY = "Alteractal";
SS_ARATHIBASIN = "Arathibecken";

-- BINDINGS
BINDING_HEADER_SSPVP = "SSPVP";
BINDING_NAME_TEFC = "Feindliche Flagge anvisieren";
BINDING_NAME_TFFC = "Eigene Flagge anvisieren"
BINDING_NAME_SSGROUP = "Automatische Gruppenwarteschlange";
BINDING_NAME_SSSOLO = "Automatische Solowarteschlange";

-- Auto queue stuff
SS_AUTOQ_SOLO = "Automatische Solowarteschlange aktiviert!";
SS_AUTOQ_DISSOLO = "Automatische Solowarteschlange deaktiviert!";

SS_AUTOQ_GROUP = "Automatische Gruppenwarteschlange aktiviert!";
SS_AUTOQ_DISGROUP = "Automatische Gruppenwarteschlange deaktiviert!";

-- Alert that the timer is between 1-10 seconds and that it's been disabled.
SS_UI_HIGHERABINT = "Das Arathibecken-Alarmintervall wurde auf einen Wert unter 10 Sekunden gesetzt und wurde auf 30 Sekunden ge\195\164ndert.";
SS_UI_HIGHERAVINT = "Das Alteractal-Alarmintervall wurde auf einen Wert unter 10 Sekunden gesetzt und wurde auf 30 Sekunden ge\195\164ndert.";

-- Mark turnin text
SSPVP_NOTENOUGHMARKS = "Ihr habt derzeit nicht genug Marken, sprecht wieder mit mir, wenn Ihr gen\195\188gend habt!";
SS_ALLIANCE_TURNIN = "Brigadegeneral der Allianz";
SS_HORDE_TURNIN = "Kriegshetzer der Horde";

-- 3/3/3 Turn in
SS_MARKS_HALL = "Gro\195\159e Ehre";
SS_MARKS_AALL = "Gemeinsames Bestreben";

-- Warsong Gulch Turn in
SS_MARKS_HWSG = "Schlacht der Warsongschlucht";
SS_MARKS_AWSG = "Kampf um die Warsongschlucht";

-- Arathi Basin Turn in
SS_MARKS_HAB = "Eroberung des Arathibeckens";
SS_MARKS_AAB = "Inbesitznahme des Arathibeckens";

-- Alterac Valley Turn in
SS_MARKS_HAV = "Die Invasoren des Alteractals";
SS_MARKS_AAV = "Vergesst das Alteractal nicht!";

-- Mark item name from battlegrounds
SS_MARKITEM_WSG = "Ehrenabzeichen der Warsongschlucht";
SS_MARKITEM_AV = "Ehrenabzeichen des Alteractals";
SS_MARKITEM_AB = "Ehrenabzeichen des Arathibeckens";

SS_MARKROW = "%s (%s/20)"; -- Warsong Gulch (12/20)

-- Misc stuff
SS_ON = "Ein";
SS_OFF = "AUS";

SS_SECONDS = "Sekunde";
SS_MINUTES = "Minute";

SS_LOADED = "geladen";
SS_DISABLED = "deaktiviert";

SS_SHOWING_MINIMAP = "Zeige Schlachtfeld-Minimap.";
SS_HIDING_MINIMAP = "Verberge Schlachtfeld-Minimap.";

SS_NO_RANK = "Kein Rang";

SS_MINING = "Erz Abbauen";
SS_HERBING = "Kr\195\164utersammeln";

SS_CURRENTLY_MINING = "Ihr baut gerade Erz ab und werdet in 10 Sekunden automatisch beitreten.";
SS_CURRENTLY_HERBING = "Ihr sammelt gerade Kr\195\164uter und werdet in 10 Sekunden automatisch beitreten."; -- Yes i know herbing isn't a word
SS_NOT_ENOUGH_TIME = "Eure Warteschlange wird in weniger als 10 Sekunden ablaufen, trete nun bei.";

SS_AUTOQUEUE_GROUP = "Automatische Gruppenanmeldung";
SS_AUTOQUEUE_SOLO = "Automatische Soloanmeldung";
SS_AUTOQUEUE_NOTLEADER = "Ihr seid nicht der Gruppenleiter und k\195\182nnt keine Gruppe anmelden.";

SS_RELEASING = "Auto Releasing...";
SS_SOULSTONE = "Seelenstein aktiv";

SS_HERALD = "Herold";

SS_CMD_MOD = "SSPVP ist nun %s";

SS_NO_TIMERS = "Keine Timer gelistet derzeit!";

SS_UNKNOWN_UNIT = "Unbekannte Einheit.";

SS_YOU_SLAIN = "Ihr habt (.+) get\195\182tet!";
SS_KILLING_BLOW = "Killing Blow!";

SS_PRINTAV_HELP = "/printav <raid/party/say/guild/channel name> - Gibt die verbleibende Zeit aus beim Erobern oder Zerst\195\182ren von Alteractal-Ressourcen.";

-- Zone names that shouldn't be considered an instance
SS_NOT_ANINSTANCE = {};
SS_NOT_ANINSTANCE[1] = "Die Tiefenbahn";
SS_NOT_ANINSTANCE[2] = "Halle der Champions";
SS_NOT_ANINSTANCE[3] = "Halle der Legenden";

-- Main stuff besides configuration
SS_PVP = "SSPVP";
SS_MAIN_STATUS = "SSPVP %s %s!";

SS_ACCEPTING_INVITE = "Akzeptiere Einladungen von %s!";

SS_NOW_AFK = "Ihr werdet den Schlachtfeldern nicht beitreten, bis Ihr nicht mehr AFK seid.";
SS_NOLONGER_AFK = "Schlachtfeld-Beitreten wiederhergestellt.";
SS_CURRENTLY_AFK = "Ihr seid gerade AFK, Ihr werdet nicht automatisch Beitreten.";

SS_WINDOW_HIDDEN = "Schlachtfeld-Eintritt-Fenster ist verborgen, Ihr werdet nicht automatisch beitreten.";
SS_INSIDE_BG = "Ihr seid gerade in einem Schlachtfeld, Ihr werdet nicht automatisch beitreten.";
SS_INSIDE_INSTANCE = "Ihr seid gerade in einer Instanz, Ihr werdet nicht automatisch beitreten.";
SS_CONFIRM_BGLEAVE = "Seid Ihr sicher, dass ihr die Warteschlange f\195\188r %s verlassen wollt?";

SS_DISABLED_QUEUED = "SSPVP was either disabled or Auto join was turned off, will not auto join.";

SS_PLAYING_SOUND = "Spiele Sounddatei %s";
SS_PLAY_INFO = "Die Sounddatei muss in Interface\\AddOns\\SSPVP\\ vor dem Spielstart gewesen sein. Ihr k\195\182nnt eine neue Musikdatei nicht mit /console reloadui laden, sondern m\195\188sst das Spiel neu starten.";
SS_STOPPED_PLAYING = "Sound angehalten.";
SS_MP3_ERROR = "Es scheint, dass Eure Musikeinstellungen auf AUS stehen. Das bedeutet, Ihr werdet die Sounddatei nicht h\195\182ren, die Ihr versucht abzuspielen.";
SS_WAV_ERROR = "Es scheint, dass Eure Musikeinstellungen auf AUS stehen. Das bedeutet, Ihr werdet die Sounddatei nicht h\195\182ren, die Ihr versucht abzuspielen.";

-- WSG Pick/Drop/Captured messages
SS_WSG_PICKEDUP = "Die %s -Flagge wurde aufgenommen von (.+)!";
SS_WSG_DROPPED = "Die %s -Flagge wurde fallengelassen von (.+)!";
SS_WSG_CAPTURED = "(.+) hat die %s -Flagge errungen!";

-- For flag targetting
SS_NO_FFC = "<kein eigener Flaggentr\195\164ger>";
SS_NO_EFC = "<kein feindlicher Flaggentr\195\164ger>";

-- You can change these to change the shortcut used in chat for friendly flag carrier and enemy flag carrier
SS_FFC_TAG = "$ffc";
SS_EFC_TAG = "$efc";

SS_TARGET_FLAGOOR = "%s ist au\195\159er Reichweite!";
SS_FLAG_SETTO = "%s Flaggentr\195\164ger gesetzt auf %s";
SS_ENEMY = "Feindlich";
SS_FRIENDLY = "Freundlich";

SS_NOBODY_HASFLAG = "Niemand hat Eure Flagge.";

SS_ALLIANCE = "Allianz";
SS_HORDE = "Horde";

-- Alterac valley
SS_AV_TAKEN = "(.+) wurde von der";
SS_AV_DESTROYED = "(.+) wurde zerst\195\182rt von der ";
SS_AV_CLAIMS = "hat ([^!]+) besetzt!";

SS_DESTROYED = "zerst\195\182rt";
SS_DESTROY = "zerst\195\182ren";
SS_CAPTURED = "erobert";
SS_CAPTURE = "erobern";

SS_AV_STATUS = "%s wird %s von der %s in %s"; -- Tower point will be destroyed by the Alliance in 5 minutes.
SS_AV_CHATTIMERS = "%s %s: %s"; -- Tower Point destroyed: 4:23

SS_AV_UNDERATTACK = "(.+) wird angegriffen!";

-- AB Messages
-- Shadowd claims the blacksmith!  If left unchallenged, the Horde will control it in 1 minute!
SS_AB_TAKEN = "hat ([^!]+) eingenommen!";
SS_AB_ASSAULTED = "hat ([^!]+) angegriffen!";
SS_AB_CLAIMS = "hat ([^!]+) besetzt!";

SS_AB_STATUS = "%s wird eingenommen von der %s in %s";
SS_AB_ALLTIMERS = "%s: %s";

-- PVP Who
SS_SEARCH_NOBG = "Ihr m\195\188sst in einem Schlachtfeld sein, um diese Funktion zu nutzen.";

SS_SEARCH_HELP = "PVP Who help";
SS_SEARCH_HELP_CLASSLIST = "classes - Class break down of the battleground";
SS_SEARCH_HELP_NAME = "n-\"<name>\" - Name Search";
SS_SEARCH_HELP_RANK = "ra-\"<1-14>\" - Rank Search";
SS_SEARCH_HELP_CLASS = "c-\"<class>\" - Class Search";
SS_SEARCH_HELP_RACE = "r-\"<race>\" - Race Search";

SS_SEARCH_CLASSROW = "%s: %s total"; -- Mage: 3 total
SS_SEARCH_ROW = "%s: %s / %s / %s"; -- Shadowd: Commander / Night Elf / Warrior
SS_SEARCH_RESULTS = "%s players total";

SS_SEARCH_CLASSES = "Klassen"; -- Used for class breakdown

-- Text to search on if were looking at battlemaster gossip
SS_BG_GOSSIP = "Ich m\195\182chte das Schlachtfeld betreten.";
SS_BG_GOSSIP2 = "Ich m\195\182chte mich dem Kampf anschlie\195\159en!";

-- UI Tabs
SS_UI_TAB_GENERAL = "Allgemein";
SS_UI_TAB_AUTOJOIN = "Auto-Beitreten";
SS_UI_TAB_AUTOLEAVE = "Auto-Verlassen";
SS_UI_TAB_ACCEPTINVITE = "Einladungen";
SS_UI_TAB_MINIMAP = "Minimap";
SS_UI_TAB_AV = SS_ALTERACVALLEY;
SS_UI_TAB_AB = SS_ARATHIBASIN;
SS_UI_TAB_OVERLAY = "SSOverlay";
SS_UI_TAB_INVITE = "SSInvite";

-- UI Text
-- BFMinimap
SS_UI_MAP_TEAM = "Teammitglieder anzeigen";
SS_UI_MAP_LOCK = "Minimap fixieren";
SS_UI_MAP_RESET = "Map-Position zur\195\188cksetzen";
SS_UI_MAP_TOGGLE = "Minimap-Anzeige";

SS_UI_INTERVAL = "Intervalle in Sekunden zwischen Alarm";
SS_UI_100_PERCENT = "100%";
SS_UI_0_PERCENT = "0%";
SS_UI_OPACITY = "Transparenz: %d";
SS_UI_TEXT_OPACITY = "Text-Transparenz: %d";

-- AB
SS_UI_AB_ENABLE = "Aktiviere Arathibecken-Timer";
SS_UI_AB_ALLIANCE = "Aktiviere Allianz-Timer";
SS_UI_AB_HORDE = "Aktiviere Horden-Timer";

-- AV
SS_UI_AV_ENABLE = "Aktiviere Alteractal-Timer";
SS_UI_AV_ALLIANCE = "Allianz-Timer (Friedh\195\182fe/Bunker/T\195\188rme)";
SS_UI_AV_HORDE = "Horden-Timer (Friedh\195\182fe/Bunker/T\195\188rme)";

-- Auto accept invite
SS_UI_INVITE_ACCEPT = "Namen f\195\188r Akzeptieren automatischer Einladungen";
SS_UI_INVITE_FRIENDS = "Akzeptiere Einladungen von Freunden";
SS_UI_INVITE_BATTLEGROUND = "Akzeptiere Einladungen von Teammitgliedern";

-- Auto leave
SS_UI_LEAVE_ENABLE = "Aktiviere Auto-Verlassen";
SS_UI_LEAVE_TIMEOUT = "Sekunden vor Auto-Verlassen.";
SS_UI_LEAVE_GROUP = "Verlasse Gruppe wenn das Schlachtfeld endet";

-- Auto join
SS_UI_JOIN_ENABLE = "Aktiviere Auto-Beitreten";
SS_UI_JOIN_TIMEOUT = "Sekunden vor Auto-Beitreten";
SS_UI_JOIN_BG = "Beitreten in einem Schlachtfeld";
SS_UI_JOIN_AFK = "Beitreten wenn AFK";
SS_UI_JOIN_INSTANCE = "Beitreten in einer Instanz";
SS_UI_JOIN_GATHERING = "Beitreten w\195\164hrend des Sammelns";
SS_UI_JOIN_WINDOW = "Deaktiviere Auto-Beitreten wenn das Fenster verborgen ist";

-- General
SS_UI_GENERAL_ENABLE = "Aktiviere SSPVP";
SS_UI_GENERAL_SOUND = "Abspielen wenn BG bereit ist";
SS_UI_GENERAL_GOSSIP = "Waffenmeister-Text \195\188berspringen";
SS_UI_GENERAL_MINIMAP = "\195\182ffne minimap beim Beitreten";
SS_UI_GENERAL_RELEASE = "Auto-Release bei Tod";
SS_UI_GENERAL_CHANNELS = "Schlachtfeld-Channels";
SS_UI_GENERAL_FLAGUI = "Warsongschlucht Flaggen-UI";
SS_UI_GENERAL_KILLINGBLOW = "SCT Killing Blow Alarm";
SS_UI_GENERAL_KILLINGBLOWCOLOR = "Killing Blow Textfarbe";

-- SSOverlay
SS_UI_OVERLAY_ENABLE = "Aktiviere \195\188bersichtsfenster";
SS_UI_OVERLAY_AV = "Alteractal \195\188bersichtsfenster";
SS_UI_OVERLAY_AB = "Arathibecken \195\188bersichtsfenster";
SS_UI_OVERLAY_QUEUE = "Schlachtfeld-Warteschlange \195\188bersichtsfenster";
SS_UI_OVERLAY_LOCK = "Fixiere \195\188bersichtsfenster, Gr\195\182\195\159e und Position nicht ver\195\164nderbar";
SS_UI_OVERLAY_COLOR = "Hintergrundfarbe";
SS_UI_OVERLAY_BORDERCOLOR = "Rahmenfarbe";
SS_UI_OVERLAY_TEXTCOLOR = "Textfarbe";

-- SSInvite


-- Misc stuff
SS_UI_ADDNAME = "Spielernamen eingeben, von denen Einladungen akzeptiert werden.";
SS_UI_EDITNAME = "Spielernamen bearbeiten, von denen Einladungen akzeptiert werden.";

SS_UI_ADDCHANNEL = "Channelnamen eingeben, dem innerhalb eines Schlachtfelds beigetreten werden soll.";
SS_UI_EDITCHANNEL = "Channelnamen bearbeiten, dem innerhalb eines Schlachtfelds beigetreten werden soll.";

SS_UI_PLAYER_NAMES = "Spielernamen";
SS_UI_CHANNEL_NAMES = "Channelnamen";

SS_UI_ADD = "+";
SS_UI_EDIT = "Edit";
SS_UI_DEL = "-";

SS_UI_PLAY = "Play";
SS_UI_STOP = "Stop";

SS_UI_CLOSE = "Schlie\195\159en";

-- "GENERIC" TOOLTIPS
SS_UI_INTERVALS_TOOLTIP = "Alarme im Chat-Fenster \195\188ber verbleibende Zeiten der %s, Alarmfrequenz h\195\164ngt vom eingestellten Intervall ab.";
SS_UI_ALERTTYPE_TOOLTIP = "Zeigt Alarme, die von der %s ausgel\195\182st werden, wie wenn jemand eine Ressource angreift.";
SS_UI_SECCAPTURED_TOOLTIP = "Zeigt an, wie viele Sekunden noch vergehen, bevor eine Ressource erobert wird.";

-- SSINVITE TOOLTIPS
SS_UI_INVITEALERT_CHAN_TOOLTIP = "Channel to broadcast that invites are coming to.";

-- ARATHI BASIN TOOLTIPS
SS_UI_AB_ENABLE_TOOLTIP = string.format( SS_UI_INTERVALS_TOOLTIP, SS_ARATHIBASIN );
SS_UI_AB_ALLIANCE_TOOLTIP = string.format( SS_UI_ALERTTYPE_TOOLTIP, SS_ALLIANCE );
SS_UI_AB_HORDE_TOOLTIP = string.format( SS_UI_ALERTTYPE_TOOLTIP, SS_HORDE );

-- ALTERAC VALLEY TOOLTIPS
SS_UI_AV_ENABLE_TOOLTIP = string.format( SS_UI_INTERVALS_TOOLTIP, SS_ALTERACVALLEY );
SS_UI_AV_ALLIANCE_TOOLTIP = string.format( SS_UI_ALERTTYPE_TOOLTIP, SS_ALLIANCE );
SS_UI_AV_HORDE_TOOLTIP = string.format( SS_UI_ALERTTYPE_TOOLTIP, SS_HORDE );

-- MINIMAP TOOLTIPS
SS_UI_MAP_TEAM_TOOLTIP = "Zeigt Eure Alliierten auf der Schlachtfeld-Minimap.";
SS_UI_MAP_RESET_TOOLTIP = "Setzt die Position der Minimap zur\195\188ck auf den Bildschirm, n\195\188tzlich wenn ihr sie ausversehen heruntergezogen habt.";
SS_UI_MAP_TOGGLE_TOOLTIP = "L\195\164sst Euch die Schlachtfeld-Minimap anschauen, ohne in einem Schlachtfeld zu sein.";
SS_UI_MAP_LOCK_TOOLTIP = SS_UI_MAP_LOCK;

-- AUTO ACCEPT INVITE TOOLTIPS
SS_UI_INVITE_ACCEPT_TOOLTIP = "Liste der Spieler von denen Einladungen automatisch akzeptiert werden.";
SS_UI_INVITE_FRIENDS_TOOLTIP = "Akzeptiert alle Einladungen von Leuten auf Eurer Freundesliste.";
SS_UI_INVITE_BATTLEGROUND_TOOLTIP = "Akzeptiert alle Einladungen von Leuten die mit Euch im Schlachtfeld sind.";

-- AUTO LEAVE TOOLTIPS
SS_UI_LEAVE_ENABLE_TOOLTIP = SS_UI_LEAVE_ENABLE;
SS_UI_LEAVE_TIMEOUT_TOOLTIP = SS_UI_LEAVE_TIMEOUT;
SS_UI_LEAVE_GROUP_TOOLTIP = SS_UI_LEAVE_GROUP;

-- AUTO JOIN TOOLTIPS
SS_UI_JOIN_GATHERING_TOOLTIP = "Sinnvoll wenn Ihr nicht automatisch beitreten wollt, w\195\164hrend Ihr gerade Kr\195\164uter sammelt oder Erz abbaut, Auto-Beitreten wird um 10 Sekunden verz\195\182gert w\195\164hrend Ihr sammelt oder abbaut.";
SS_UI_JOIN_WINDOW_TOOLTIP = "Sinnvoll wenn Ihr mit etwas besch\195\164ftigt seid und etwas mehr Zeit braucht, bis Ihr dem Schlachtfeld beitretet. Ihr m\195\188sst manuell beitreten, wenn Ihr das Fenster verbergt, nachdem der Auto-Beitreten-Timeout vorbei ist.";
SS_UI_JOIN_ENABLE_TOOLTIP = SS_UI_JOIN_ENABLE;
SS_UI_JOIN_TIMEOUT_TOOLTIP = SS_UI_JOIN_TIMEOUT;
SS_UI_JOIN_BG_TOOLTIP = SS_UI_JOIN_BG;
SS_UI_JOIN_AFK_TOOLTIP = SS_UI_JOIN_AFK;
SS_UI_JOIN_INSTANCE_TOOLTIP = SS_UI_JOIN_INSTANCE;

-- GENERAL TOOLTIPS
SS_UI_GENERAL_SOUND_TOOLTIP = "Abzuspielende Sounddatei, wenn Ihr ein Schlachtfeld betreten k\195\182nnt.";
SS_UI_GENERAL_MINIMAP_TOOLTIP = "\195\150ffnet die Schlachtfeld-Minimap, wenn Ihr ein Schlachtfeld betretet.";
SS_UI_GENERAL_CHANNELS_TOOLTIP = "Liste der Channels denen Ihr beitreten wollt, w\195\164hrend Ihr in einem Schlachtfeld seid, aber nicht w\195\164hrend Ihr drau\195\159en seid.";
SS_UI_GENERAL_FLAGUI_TOOLTIP = "Zeigt, wer die Hordenflagge und die Allianzflagge tr\195\164gt neben der Warsongschlucht-Punkteanzeige.";
SS_UI_GENERAL_KILLINGBLOW_TOOLTIP = "Zeigt, wenn Ihr den t\195\182dlichen Schlag gegen einen Mob oder Spieler ausf\195\188hrt mittels Scrolling Combat Text. \n\nScrolling Combat Text wird daf\195\188r ben\195\182tigt.";
SS_UI_GENERAL_ENABLE_TOOLTIP = SS_UI_GENERAL_ENABLE;
SS_UI_GENERAL_GOSSIP_TOOLTIP = SS_UI_GENERAL_GOSSIP;
SS_UI_GENERAL_RELEASE_TOOLTIP = SS_UI_GENERAL_RELEASE;
SS_UI_GENERAL_KILLINGBLOWCOLOR_TOOLTIP = SS_UI_GENERAL_KILLINGBLOWCOLOR;

-- SSOVERLAY TOOLTIPS
SS_UI_OVERLAY_QUEUE_TOOLTIP = "Zeigt den Status Eurer Schlachtfeld-Warteschlangen, wenn eine Warteschlage bereit zum Beitreten ist, zeigt es auch die Sekunden bis zum automatischen Beitreten.";
SS_UI_OVERLAY_ENABLE_TOOLTIP = SS_UI_OVERLAY_ENABLE;
SS_UI_OVERLAY_AV_TOOLTIP = SS_UI_SECCAPTURED_TOOLTIP;
SS_UI_OVERLAY_AB_TOOLTIP = SS_UI_SECCAPTURED_TOOLTIP;
SS_UI_OVERLAY_LOCK_TOOLTIP = SS_UI_OVERLAY_LOCK;
SS_UI_OVERLAY_COLOR_TOOLTIP = SS_UI_OVERLAY_COLOR;
SS_UI_OVERLAY_BORDERCOLOR_TOOLTIP = SS_UI_OVERLAY_BORDERCOLOR;
SS_UI_OVERLAY_TEXTCOLOR_TOOLTIP = SS_UI_OVERLAY_TEXTCOLOR;
end