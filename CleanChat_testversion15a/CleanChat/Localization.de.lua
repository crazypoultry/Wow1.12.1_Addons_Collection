--
-- German
--
if GetLocale() == "deDE" then

  CLEANCHAT_WHO_RESULTS_PATTERN = "%d+ Spieler gesamt";

  CLEANCHAT_TRANSLATE_CLASS = {
    ["J\195\164ger"] = 1,
    ["Hexenmeister"] = 2,
    ["Priester"]     = 3,
    ["Paladin"]      = 4,
    ["Magier"]       = 5,
    ["Schurke"]      = 6,
    ["Druide"]       = 7,
    ["Schamane"]     = 8,
    ["Krieger"]      = 9
  };

  CLEANCHAT_LOADED = " geladen.";
  CLEANCHAT_LOADED_CACHE = CLEANCHAT_VERSION .. " geladen (%d Namen im Cache)."

  CLEANCHAT_MYADDONS_DESCRIPTION = "Entfernt [Gruppe], [Schlachtzug], [Offizier] und [Gilde] Prefix im Chat.";
  CLEANCHAT_MYADDONS_RELEASEDATE = "13. Oktober 2006";

  CLEANCHAT_CHANNELS = {
    {},
    { ["__PREFIX"] = "\. ",
      ["Allgemein"] = "",
      ["Handel"] = "" },
    { ["__PREFIX"] = "\. ",
      ["Allgemein"] = "",
      ["Handel"] = "",
      ["LokaleVerteidigung"] = "",
      ["WeltVerteidigung"] = "",
      ["SucheNachGruppe"] = "",
      ["Gildenrekrutierung"] = "" },
    { ["__PREFIX"] = "\. ",
      ["Allgemein"] = "",
      ["Handel"] = "",
      ["LokaleVerteidigung"] = "",
      ["WeltVerteidigung"] = "",
      ["SucheNachGruppe"] = "",
      ["Gildenrekrutierung"] = "" },
    { ["__PREFIX"] = "%d\. ",
      ["Allgemein"] = "A",
      ["Handel"] = "H",
      ["LokaleVerteidigung"] = "L",
      ["WeltVerteidigung"] = "W",
      ["SucheNachGruppe"] = "LFG",
      ["Gildenrekrutierung"] = "GR" },
    { ["__PREFIX"] = "%d\. ",
      ["Allgemein"] = "A",
      ["Handel"] = "H",
      ["LokaleVerteidigung"] = "L",
      ["WeltVerteidigung"] = "W",
      ["SucheNachGruppe"] = "LFG",
      ["Gildenrekrutierung"] = "GR" } };

  CLEANCHAT_PREFIX_RAID = {
    [false] = CHAT_RAID_GET,
    [true]  = "%s:\32" };

  CLEANCHAT_PREFIX_PARTY = {
    [false] = CHAT_PARTY_GET,
    [true]  = "%s:\32" };

  CLEANCHAT_PREFIX_OFFICER = {
    [false] = CHAT_OFFICER_GET,
    [true]  = "%s:\32" };

  CLEANCHAT_PREFIX_GUILD = {
    [false] = CHAT_GUILD_GET,
    [true]  = "%s:\32" };

  CLEANCHAT_PREFIX_RAIDLEADER = {
    [false] = CHAT_RAID_LEADER_GET,
    [true]  = "[SL] %s:\32" };

  CLEANCHAT_PREFIX_RAIDWARNING = {
    [false] = CHAT_RAID_WARNING_GET,
    [true]  = "[SW] %s:\32" };

  CLEANCHAT_PREFIX_BG = {
    [false] = CHAT_BATTLEGROUND_GET,
    [true]  = "[BG] %s:\32"
  };
  
  CLEANCHAT_PREFIX_BGLEADER = {
    [false] = CHAT_BATTLEGROUND_LEADER_GET,
    [true]  = "[BGL] %s:\32"
  };
    
  CLEANCHAT_HELP = { HIGHLIGHT_FONT_COLOR_CODE .. "/cleanchat" .. LIGHTYELLOW_FONT_COLOR_CODE .. "- GUI anzeigen.",
                     HIGHLIGHT_FONT_COLOR_CODE .. "/cleanchat status" .. LIGHTYELLOW_FONT_COLOR_CODE .. "- Aktuelle Einstellungen anzeigen." };

  CLEANCHAT_STATUSMSG = "Status%d: " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s";

  CLEANCHAT_STATUS1 = {
    [true] = "Prefix wird nicht angezeigt.",
    [false] = "Prefix wird angezeigt." };

  CLEANCHAT_STATUS2A = {
    [true] = "Farbige Chatnamen sind eingeschaltet.",
    [false] = "Farbige Chatnamen sind ausgeschaltet." };

  CLEANCHAT_STATUS2B = {
    [true]  = { [true]  = "Klassenfarben sind eingeschaltet.",
                [false] = "Klassenfarben sind ausgeschaltet." },
    [false] = { [true]  = "",
                [false] = "" } };

  CLEANCHAT_STATUS3 = {
    "Channelname wird angezeigt.",
    "Channelname Allgemein und Handel wird entfernt.",
    "Channelname Allgemein, Handel, Suche nach Gruppe und Verteidigung wird entfernt.",
    "Alle Channelnamen entfernen.",
    "Verwende Abk\195\188rzungen: A - Allgemein, H - Handel, LFG - Suche nach Gruppe.",
    "Verwende Abk\195\188rzungen und entferne Name von \195\188brigen Channels." };

  CLEANCHAT_STATUS4 = "Eigene Farbe f\195\188r %s%s %s%s";
  CLEANCHAT_STATUS5 = { "Gildenmitglieder", "Freunde", "Unbekannte", "Partymitglieder", "Raidmitglieder", "Namen ohne Klasseninformation", "mich selbst" };
  CLEANCHAT_STATUS6 = "F\195\188r alle \195\188brigen Namen Zufallsfarben verwenden."

  -- GUI
  BINDING_NAME_CLEANCHAT_GUI = "GUI anzeigen / schliessen";
  CLEANCHAT_CHECKBOX_PREFIX = "Chatprefix [Gruppe], [Schlachtzug], [Gilde] und [Offizier] verstecken\nund Schlachtzug- und Schlachtfeldprefix abk\195\188rzen.";
  CLEANCHAT_CHANNELS_LABEL = "Channelnamen:";
  CLEANCHAT_COLORIZE_NICKS = "Farboptionen f\195\188r Chat aktivieren:";
  CLEANCHAT_USE_CLASS_COLORS = "Ausschlie\195\159lich Klassenfarben verwenden";
  CLEANCHAT_USE_CURSORKEYS = "Beim Schreiben von Nachrichten Cursortasten direkt verwenden\n(ohne ALT).";
  CLEANCHAT_HIDE_CHATBUTTONS = "Chatbuttons verstecken.";
  CLEANCHAT_COLLECTDATA = "Addon darf /who Kommando benutzen."
  CLEANCHAT_SHOWLEVEL = "Zeige Level im Chat an.";
  CLEANCHAT_MOUSEWHEEL = "Mausrad zum Scrollen verwenden.";
  CLEANCHAT_PERSISTENT = "Gesammelte Informationen zwischenspeichern.";
  CLEANCHAT_POPUP = "Chatnachricht gro\195\159 anzeigen falls mein Name enthalten ist.";
  CLEANCHAT_IGNORE_EMOTES = "Namen in Emotes nicht hervorheben.";

end