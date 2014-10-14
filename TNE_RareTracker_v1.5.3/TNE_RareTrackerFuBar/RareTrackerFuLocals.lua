
TNE_RTFUBAR_MENU_ITEMS = { }

if not ace:LoadTranslation("RareTrackerFu") then

  RareTrackerFuLocals = {
    DESCRIPTION = "A FuBar plugin for RareTracker",
    COMMANDS = {},
    CMD_OPTIONS = {},
  
    DISPLAY_ZONE = "RareTracker: %d",
    DISPLAY_SUBZONE = "RareTracker: %d (%d)",
  
    MENU_SCAN = "Scan for nearby mobs",
    MENU_AUTOTARGET = "Allow autotargeting",
    MENU_TOOLTIP_LOCATION = "Use default tooltip location",
    MENU_SORT_BY_SUBZONE = "Sort tooltip by subzone",

    TOOLTIP_HINT = "Left-click to scan your surroundings.",

    TOOLTIP_NO_KNOWN_MOBS = "No rare mobs known in %s.",
    TOOLTIP_MOBS_KNOWN_IN_ZONE = "%d rare mobs known in %s:",
    TOOLTIP_MOBS_KNOWN_IN_SUB_ZONE = "%d of them near or in %s:",
    TOOLTIP_MOBS_KNOWN_IN_SUB_ZONE_ONLY = "%s:",
    TOOLTIP_MOBS_KNOWN_IN_UNKNOWN = "No subzone/never seen:",
    TOOLTIP_SEEN_AT = "Seen at:",
    TOOLTIP_MOB = " - %s, %s",
    TOOLTIP_COORDS = "%s" --"%s",
  }

end
