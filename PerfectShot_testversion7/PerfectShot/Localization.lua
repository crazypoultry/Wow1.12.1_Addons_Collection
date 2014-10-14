
PERFECTSHOT_NAME = "PerfectShot";
PERFECTSHOT_VERSION = "testversion7";
PERFECTSHOT_CHATMESSAGE = NORMAL_FONT_COLOR_CODE .. PERFECTSHOT_NAME .. ": " .. LIGHTYELLOW_FONT_COLOR_CODE .. "%s";

BINDING_HEADER_PERFECTSHOT = PERFECTSHOT_NAME;

if GetLocale() == "deDE" then

  --
  -- German
  --

  PERFECTSHOT_LOADED = " geladen";

  PERFECTSHOT_MYADDONS_DESCRIPTION = "Blendet Userinterface aus und erstellt einen Screenshot.";
  PERFECTSHOT_MYADDONS_RELEASEDATE = "23. August 2006";

  PERFECTSHOT_STATUS1a = "Erstelle %d Screenshots. Verz\195\182gerung jeweils %.2fs. Namen werden angezeigt.";
  PERFECTSHOT_STATUS1b = "Erstelle %d Screenshots. Verz\195\182gerung jeweils %.2fs. Namen werden ausgeblendet.";
  PERFECTSHOT_STATUS2 = "%d Screenshots erstellt.";
  PERFECTSHOT_STATUS3 = "Screenshot-Serie wurde abgebrochen.";
  PERFECTSHOT_STATUS4 = "Keine Screenshot-Serie aktiv.";
  PERFECTSHOT_STATUS5 = "%d von %d Screenshots erstellt. Verz\195\182gerung: %.2fs.";

  PERFECTSHOT_CHATHELP1 = HIGHLIGHT_FONT_COLOR_CODE .. "/ps <Anzahl Screenshots> <Verz\195\182gerung in Sekunden> [<Namen einblenden: 1>]" .. LIGHTYELLOW_FONT_COLOR_CODE .. "- Nimmt X Screenshots. Nach jedem Screenshot pausiert das Script Y Sekunden. Beispielsweise drei Bilder in kurzer Folge: \"/pss 3 1\". Sollen Namen eingeblendet werden, noch eine \"1\" anh\195\164ngen, ansonsten weglassen.";
  PERFECTSHOT_CHATHELP2 = HIGHLIGHT_FONT_COLOR_CODE .. "/ps cancel" .. LIGHTYELLOW_FONT_COLOR_CODE .. "- Beendet vorzeitig Screenshot-Serie.";

  BINDING_NAME_PERFECTSHOT_WITH_NAMES = "Screenshot mit Namen";
  BINDING_NAME_PERFECTSHOT_WITHOUT_NAMES = "Screenshot ohne Namen";
  BINDING_NAME_PERFECTSHOT_WITHOUT_NAMES_AND_DESELECT_TARGET = "Screenshot ohne Namen / Zielname";
else

  --
  -- English
  --

  PERFECTSHOT_LOADED = " loaded.";

  PERFECTSHOT_MYADDONS_DESCRIPTION = "Hides UI and takes a screenshot.";
  PERFECTSHOT_MYADDONS_RELEASEDATE = "August 23, 2006";

  PERFECTSHOT_STATUS1a = "Taking %d screenshots. Delay is %.2fs. Names are shown.";
  PERFECTSHOT_STATUS1b = "Taking %d screenshots. Delay is %.2fs. Names are NOT shown.";
  PERFECTSHOT_STATUS2 = "%d screenshots taken.";
  PERFECTSHOT_STATUS3 = "Screenshot series canceled.";
  PERFECTSHOT_STATUS4 = "No Screenshot series active.";
  PERFECTSHOT_STATUS5 = "%d of %d screenshots taken. Delay: %.2fs.";

  PERFECTSHOT_CHATHELP1 = HIGHLIGHT_FONT_COLOR_CODE .. "/ps <number screenshots> <delay in seconds> [<show names: 1>]" .. LIGHTYELLOW_FONT_COLOR_CODE .. "- Takes X screenshots. After each screenshot the addon waits Y seconds. Eg three screens in short burst: \"/ps 3 1\".  To show names labels append a \"1\" otherwise the name labels are not shown (default).";
  PERFECTSHOT_CHATHELP2 = HIGHLIGHT_FONT_COLOR_CODE .. "/ps cancel" .. LIGHTYELLOW_FONT_COLOR_CODE .. "- Cancel active screenshot series.";

  BINDING_NAME_PERFECTSHOT_WITH_NAMES = "Screenshot with names";
  BINDING_NAME_PERFECTSHOT_WITHOUT_NAMES = "Screenshot without names";
  BINDING_NAME_PERFECTSHOT_WITHOUT_NAMES_AND_DESELECT_TARGET = "Screenshot without names / target name";

end