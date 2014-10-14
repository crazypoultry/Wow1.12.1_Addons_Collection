  CLEANCHAT_WHO_RESULTS_PATTERN = "%d+ player[s]? total";

  CLEANCHAT_TRANSLATE_CLASS = {
    ["Hunter"]  = 1,
    ["Warlock"] = 2,
    ["Priest"]  = 3,
    ["Paladin"] = 4,
    ["Mage"]    = 5,
    ["Rogue"]   = 6,
    ["Druid"]   = 7,
    ["Shaman"]  = 8,
    ["Warrior"] = 9
  };

  CLEANCHAT_LOADED = " loaded.";
  CLEANCHAT_LOADED_CACHE = CLEANCHAT_VERSION .. " loaded (%d names cached)."

  CLEANCHAT_MYADDONS_DESCRIPTION = "Removes [Party], [Raid], [Officer] and [Guild] prefix from chat messages.";
  CLEANCHAT_MYADDONS_RELEASEDATE = "October 13, 2006";

  CLEANCHAT_CHANNELS = {
    {},
    { ["__PREFIX"] = "\. ",
      ["General"] = "",
      ["Trade"] = "" },
    { ["__PREFIX"] = "\. ",
      ["General"] = "",
      ["Trade"] = "",
      ["LocalDefense"] = "",
      ["WorldDefense"] = "",
      ["LookingForGroup"] = "",
      ["GuildRecruitment"] = "" },
    { ["__PREFIX"] = "\. ",
      ["General"] = "",
      ["Trade"] = "",
      ["LocalDefense"] = "",
      ["WorldDefense"] = "",
      ["LookingForGroup"] = "",
      ["GuildRecruitment"] = "" },
    { ["__PREFIX"] = "%d\. ",
      ["General"] = "G",
      ["Trade"] = "T",
      ["LocalDefense"] = "L",
      ["WorldDefense"] = "W",
      ["LookingForGroup"] = "LFG",
      ["GuildRecruitment"] = "GR" },
    { ["__PREFIX"] = "%d\. ",
      ["General"] = "G",
      ["Trade"] = "T",
      ["LocalDefense"] = "L",
      ["WorldDefense"] = "W",
      ["LookingForGroup"] = "LFG",
      ["GuildRecruitment"] = "GR" } };

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
    [true]  = "[RL] %s:\32" };

  CLEANCHAT_PREFIX_RAIDWARNING = {
    [false] = CHAT_RAID_WARNING_GET,
    [true]  = "[RW] %s:\32" };

  CLEANCHAT_PREFIX_BG = {
    [false] = CHAT_BATTLEGROUND_GET,
    [true]  = "[BG] %s:\32"
  };
  
  CLEANCHAT_PREFIX_BGLEADER = {
    [false] = CHAT_BATTLEGROUND_LEADER_GET,
    [true]  = "[BGL] %s:\32"
  };
  
  CLEANCHAT_HELP = { HIGHLIGHT_FONT_COLOR_CODE .. "/cleanchat" .. LIGHTYELLOW_FONT_COLOR_CODE .. "- Show GUI.",
                     HIGHLIGHT_FONT_COLOR_CODE .. "/cleanchat status" .. LIGHTYELLOW_FONT_COLOR_CODE .. "- Show current setup. " };

  CLEANCHAT_STATUSMSG = "Status%d: " .. HIGHLIGHT_FONT_COLOR_CODE .. "%s";

  CLEANCHAT_STATUS1 = {
    [true] = "Chat prefix is not shown.",
    [false] = "Chat prefix is shown." };

  CLEANCHAT_STATUS2A = {
    [true] = "Colorize nicks is enabled.",
    [false] = "Colorize nicks is disabled." };

  CLEANCHAT_STATUS2B = {
    [true]  = { [true]  = "Class colors are enabled.",
                [false] = "Class colors are disabled." },
    [false] = { [true]  = "",
                [false] = "" } };

  CLEANCHAT_STATUS3 = {
    "Channel names are shown.",
    "Channel names General and Trade are not shown.",
    "Channel names Genereal, Trade, LookingForGroup and Defense are not shown.",
    "Hide all channel names.",
    "Use abbreviation: G - General, T - Trade, LFG - LookingForGroup.",
    "Use abbreviation and hide other channel names." };

  CLEANCHAT_STATUS4 = "Custom color for %s%s %s%s";
  CLEANCHAT_STATUS5 = { "guild members", "friends", "others", "party members", "raid members", "names without class information", "myself" };
  CLEANCHAT_STATUS6 = "Otherwise use random color if a name does not match any criteria above."

  -- GUI
  BINDING_NAME_CLEANCHAT_GUI = "Toggle GUI";
  CLEANCHAT_CHECKBOX_PREFIX = "Hide chat prefix [Party], [Raid], [Guild] und [Officer]\nand abbreviate raid and battleground prefix.";
  CLEANCHAT_CHANNELS_LABEL = "Channel names:";
  CLEANCHAT_COLORIZE_NICKS = "Colorize names in chat messages";
  CLEANCHAT_USE_CLASS_COLORS = "Use class colors";
  CLEANCHAT_USE_CURSORKEYS = "Activate cursor keys while typing a message (without ALT key)";
  CLEANCHAT_HIDE_CHATBUTTONS = "Hide chat buttons.";
  CLEANCHAT_COLLECTDATA = "Allow addon to use /who command."
  CLEANCHAT_SHOWLEVEL = "Show level in chat.";
  CLEANCHAT_MOUSEWHEEL = "Use mouse wheel to scroll.";
  CLEANCHAT_PERSISTENT = "Save collected data.";
  CLEANCHAT_POPUP = "Show chat message on screen if it contains your name.";
  CLEANCHAT_IGNORE_EMOTES = "Do not colorize names in emotes."