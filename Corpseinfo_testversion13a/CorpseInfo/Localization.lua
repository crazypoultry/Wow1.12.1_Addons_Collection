
CORPSEINFO_NAME = "CorpseInfo";
CORPSEINFO_VERSION = "testversion13a";
CORPSEINFO_CHATMESSAGE = NORMAL_FONT_COLOR_CODE .. CORPSEINFO_NAME .. ": " .. LIGHTYELLOW_FONT_COLOR_CODE .. "%s";

BINDING_HEADER_CORPSEINFO = CORPSEINFO_NAME;

CORPSEINFO_CHATPATTERN1 = "(.-)%s-: (.- .-) ([^<%-]*) ";

if GetLocale() == "deDE" then

  --
  -- German
  --

  CORPSEINFO_LOADED = " geladen";

  CORPSEINFO_MYADDONS_DESCRIPTION = "Zeigt zus\195\164tzlich Klasse, Stufe, Onlinestatus bei einem Kadaver an.";
  CORPSEINFO_MYADDONS_RELEASEDATE = "23. August 2006";

  CORPSEINFO_ONLINE = GREEN_FONT_COLOR_CODE .. "Online";

  CORPSEINFO_CORPSEPATTERN = "Leichnam von (.*)";
  CORPSEINFO_CHATPATTERN2 = "%d+ Spieler gesamt";

  CORPSEINFO_OFFLINE = {
    ["Alliance"] = RED_FONT_COLOR_CODE .. "Offline oder Horde",
    ["Horde"] = RED_FONT_COLOR_CODE .. "Offline oder Allianz" };

  CORPSEINFO_FACTION = {
    ["Alliance"] = RED_FONT_COLOR_CODE .. "Horde",
    ["Horde"] = RED_FONT_COLOR_CODE .. "Allianz" };

  CORPSEINFO_GUILD = "<%s>";
  CORPSEINFO_RACECLASS = HIGHLIGHT_FONT_COLOR_CODE .. "%s %s";

  CORPSEINFO_OFFLINE2 = RED_FONT_COLOR_CODE .. "Offline";
  CORPSEINFO_KOS_LASTSEEN = HIGHLIGHT_FONT_COLOR_CODE .. "Gesehen vor: %s";
  CORPSEINFO_KOS_NOTE = "\"%s\"";
  CORPSEINFO_CTPLAYER_NOTE = "%s\"%s\"";
  CORSEINFO_IGNORED = "|cffff6060Spieler ist auf deiner Ignorieren-Liste.";

  CORPSEINFO_STATUS1 = {
    [true] = "Status: " .. HIGHLIGHT_FONT_COLOR_CODE .. "Kadaver untersuchen erfolgt automatisch, sobald Mauszeiger \195\188ber Kadaver f\195\164hrt.",
    [false] = "Status: " .. HIGHLIGHT_FONT_COLOR_CODE .. "Kadaver untersuchen erfolgt per Tastendruck / Mausklick." };

  CORPSEINFO_STATUS2 = {
    [true] = "Status: " .. HIGHLIGHT_FONT_COLOR_CODE .. "Ergebnis der /who Abfrage im Chat anzeigen.",
    [false] = "Status: " .. HIGHLIGHT_FONT_COLOR_CODE .. "Ergebnis der /who Abfrage nicht im Chat anzeigen." };

  CORPSEINFO_CHATHELP1 = HIGHLIGHT_FONT_COLOR_CODE .. "/corpseinfo mode " .. LIGHTYELLOW_FONT_COLOR_CODE .. "- Schalter, (de)aktiviert 'Kadaver automatisch untersuchen'."
  CORPSEINFO_CHATHELP2 = HIGHLIGHT_FONT_COLOR_CODE .. "/corpseinfo chat " .. LIGHTYELLOW_FONT_COLOR_CODE .. "- Schalter, legt fest ob das Ergebnis der /who-Abfrage im Chat angezeigt wird."

  BINDING_NAME_CHECK_CORPSE = "Kadaver untersuchen";

elseif GetLocale() == "frFR" then

  --
  -- French (Thanks to Miro)
  --

  CORPSEINFO_LOADED = " charg\195\169.";

  CORPSEINFO_MYADDONS_DESCRIPTION = "Ajoute dans la bulle d'information la classe, le niveau, le statut de connexion pour les cadavres.";
  CORPSEINFO_MYADDONS_RELEASEDATE = "23 aout 2006";

  CORPSEINFO_ONLINE = GREEN_FONT_COLOR_CODE .. "Connect\195\169";

  CORPSEINFO_CORPSEPATTERN = "Cadavre.-[de]['%s](.*)";
  CORPSEINFO_CHATPATTERN2 = "%d+ joueur[s]? au total";

  CORPSEINFO_OFFLINE = {
  ["Alliance"] = RED_FONT_COLOR_CODE .. "D\195\169connect\195\169 ou Horde",
  ["Horde"] = RED_FONT_COLOR_CODE .. "D\195\169connect\195\169 ou Alliance" };

  CORPSEINFO_FACTION = {
  ["Alliance"] = RED_FONT_COLOR_CODE .. "Horde",
  ["Horde"] = RED_FONT_COLOR_CODE .. "Alliance" };

  CORPSEINFO_GUILD = "<%s>";
  CORPSEINFO_RACECLASS = HIGHLIGHT_FONT_COLOR_CODE .. "%s %s";

  CORPSEINFO_OFFLINE2 = RED_FONT_COLOR_CODE .. "D\195\169connect\195\169";
  CORPSEINFO_KOS_LASTSEEN = HIGHLIGHT_FONT_COLOR_CODE .. "Vue pour la derni\195\168re fois: %s";
  CORPSEINFO_KOS_NOTE = "\"%s\"";
  CORPSEINFO_CTPLAYER_NOTE = "%s\"%s\"";
  CORSEINFO_IGNORED = "|cffff6060Ce joueur est dans votre liste Ignore.";

  CORPSEINFO_STATUS1 = {
    [true] = "Status: " .. HIGHLIGHT_FONT_COLOR_CODE .. "Inspecte les cadavres automatiquement au passage souris.",
    [false] = "Status: " .. HIGHLIGHT_FONT_COLOR_CODE .. "Inspect corpse via key binding / mouse click." };

  CORPSEINFO_STATUS2 = {
    [true] = "Status: " .. HIGHLIGHT_FONT_COLOR_CODE .. "Affiche le r\195\169sultat du /qui dans le chat.",
    [false] = "Status: " .. HIGHLIGHT_FONT_COLOR_CODE .. "N'affiche pas le r\195\169sultat du /qui dans le chat." };

  CORPSEINFO_CHATHELP1 = HIGHLIGHT_FONT_COLOR_CODE .. "/corpseinfo mode " .. LIGHTYELLOW_FONT_COLOR_CODE .. "- Bascule entre le mode 'Inspecte cadavres automatiquement'."
  CORPSEINFO_CHATHELP2 = HIGHLIGHT_FONT_COLOR_CODE .. "/corpseinfo chat " .. LIGHTYELLOW_FONT_COLOR_CODE .. "- Active/D\195\169sactive la notification des /qui dans le chat."

  BINDING_NAME_CHECK_CORPSE = "Inspecter un cadavre";

elseif GetLocale() == "zhCN" then

  --
  -- Chinese (thx to Felix)
  --

  CORPSEINFO_LOADED = "已加载。";

  CORPSEINFO_MYADDONS_DESCRIPTION = "在tooltip中显示有关尸体的职业、等级、在线状态等信息。";
  CORPSEINFO_MYADDONS_RELEASEDATE = "2006年8月23日";

  CORPSEINFO_ONLINE = GREEN_FONT_COLOR_CODE .. "在线";

  CORPSEINFO_CORPSEPATTERN = "(.*)的尸体";
  CORPSEINFO_CHATPATTERN2 = "共计%d+个玩家";

  CORPSEINFO_OFFLINE = {
    ["Alliance"] = RED_FONT_COLOR_CODE .. "离线或为部落",
    ["Horde"] = RED_FONT_COLOR_CODE .. "离线或为联盟" };

  CORPSEINFO_FACTION = {
    ["Alliance"] = RED_FONT_COLOR_CODE .. "部落",
    ["Horde"] = RED_FONT_COLOR_CODE .. "联盟" };

  CORPSEINFO_GUILD = "<%s>";
  CORPSEINFO_RACECLASS = HIGHLIGHT_FONT_COLOR_CODE .. "%s %s";

  CORPSEINFO_OFFLINE2 = RED_FONT_COLOR_CODE .. "离线";
  CORPSEINFO_KOS_LASTSEEN = HIGHLIGHT_FONT_COLOR_CODE .. "上次于%s前发现";
  CORPSEINFO_KOS_NOTE = "\"%s\"";
  CORPSEINFO_CTPLAYER_NOTE = "%s\"%s\"";
  CORSEINFO_IGNORED = "|cffff6060该玩家已被你屏蔽。";

  CORPSEINFO_STATUS1 = {
    [true] = "状态：" .. HIGHLIGHT_FONT_COLOR_CODE .. "鼠标悬停自动查询尸体信息。",
    [false] = "状态：" .. HIGHLIGHT_FONT_COLOR_CODE .. "鼠标点击或使用热键查询尸体信息。" };

  CORPSEINFO_STATUS2 = {
    [true] = "状态：" .. HIGHLIGHT_FONT_COLOR_CODE .. "在聊天窗口显示/who查询结果。",
    [false] = "状态：" .. HIGHLIGHT_FONT_COLOR_CODE .. "不在聊天窗口显示/who查询结果。" };

  CORPSEINFO_CHATHELP1 = HIGHLIGHT_FONT_COLOR_CODE .. "/corpseinfo mode " .. LIGHTYELLOW_FONT_COLOR_CODE .. "- 切换是否自动查询尸体信息。"
  CORPSEINFO_CHATHELP2 = HIGHLIGHT_FONT_COLOR_CODE .. "/corpseinfo chat " .. LIGHTYELLOW_FONT_COLOR_CODE .. "- 切换是否在聊天窗口显示/who查询结果。"

  BINDING_NAME_CHECK_CORPSE = "查询尸体";

else

  --
  -- English
  --

  CORPSEINFO_LOADED = " loaded.";

  CORPSEINFO_MYADDONS_DESCRIPTION = "Adds class, level, online status to the tooltip for a corpse.";
  CORPSEINFO_MYADDONS_RELEASEDATE = "August 23, 2006";

  CORPSEINFO_ONLINE = GREEN_FONT_COLOR_CODE .. "Online";

  CORPSEINFO_CORPSEPATTERN = "Corpse of (.*)";
  CORPSEINFO_CHATPATTERN2 = "%d+ player[s]? total";

  CORPSEINFO_OFFLINE = {
    ["Alliance"] = RED_FONT_COLOR_CODE .. "Offline or Horde",
    ["Horde"] = RED_FONT_COLOR_CODE .. "Offline or Alliance" };

  CORPSEINFO_FACTION = {
    ["Alliance"] = RED_FONT_COLOR_CODE .. "Horde",
    ["Horde"] = RED_FONT_COLOR_CODE .. "Alliance" };

  CORPSEINFO_GUILD = "<%s>";
  CORPSEINFO_RACECLASS = HIGHLIGHT_FONT_COLOR_CODE .. "%s %s";

  CORPSEINFO_OFFLINE2 = RED_FONT_COLOR_CODE .. "Offline";
  CORPSEINFO_KOS_LASTSEEN = HIGHLIGHT_FONT_COLOR_CODE .. "Last seen: %s";
  CORPSEINFO_KOS_NOTE = "\"%s\"";
  CORPSEINFO_CTPLAYER_NOTE = "%s\"%s\"";
  CORSEINFO_IGNORED = "|cffff6060Player is on your ignore list.";

  CORPSEINFO_STATUS1 = {
    [true] = "Status: " .. HIGHLIGHT_FONT_COLOR_CODE .. "Inspect corpse automatically on mouse over.",
    [false] = "Status: " .. HIGHLIGHT_FONT_COLOR_CODE .. "Inspect corpse via key binding / mouse click." };

  CORPSEINFO_STATUS2 = {
    [true] = "Status: " .. HIGHLIGHT_FONT_COLOR_CODE .. "Show result of /who query in the chat.",
    [false] = "Status: " .. HIGHLIGHT_FONT_COLOR_CODE .. "Do not show result of /who query in the chat." };

  CORPSEINFO_CHATHELP1 = HIGHLIGHT_FONT_COLOR_CODE .. "/corpseinfo mode " .. LIGHTYELLOW_FONT_COLOR_CODE .. "- Turns 'Inspect corpse automatically' on/off."
  CORPSEINFO_CHATHELP2 = HIGHLIGHT_FONT_COLOR_CODE .. "/corpseinfo chat " .. LIGHTYELLOW_FONT_COLOR_CODE .. "- Toggle whether to show result of the /who command in chat or not."

  BINDING_NAME_CHECK_CORPSE = "Inspect corpse";

end
