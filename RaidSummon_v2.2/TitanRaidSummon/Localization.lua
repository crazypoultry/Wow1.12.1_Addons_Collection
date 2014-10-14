-- german localization
if ( GetLocale() == "deDE" ) then
  -- ä = \195\164
  -- ö = \195\182
  -- ü = \195\188
  -- ß = \195\159

  TITAN_RAIDSUMMON_TOOLTIP_HINT1=       "Klick: N\195\164chsten Beschw\195\182ren";
  TITAN_RAIDSUMMON_TOOLTIP_HINT2=       "Strg-klick: Spieler \195\188berspringen";
  TITAN_RAIDSUMMON_TOOLTIP_HINT3=       "Shift-klick: Modus automatisch w\195\164hlen";

  TITAN_RAIDSUMMON_TOOLTIP_QUEUE_EMPTY= "Warteschlange leer";
  TITAN_RAIDSUMMON_TOOLTIP_QUEUED=      "Spieler in Warteschlange:";
  TITAN_RAIDSUMMON_BUTTON_NONE=         "Niemand";
  TITAN_RAIDSUMMON_DISABLED=            "Deaktiviert";
  TITAN_RAIDSUMMON_PAUSED=              "Pausiert";
  TITAN_RAIDSUMMON_AFK=                 "AFK-Modus";
  TITAN_RAIDSUMMON_BUTTON_LABEL=        "RaidSummon: ";
  TITAN_RAIDSUMMON_MENU_TEXT=           "RaidSummon";
  TITAN_RAIDSUMMON_TOOLTIP=             "RaidSummon";
  TITAN_RAIDSUMMON_MENU_FLASH=          "Plugin bei wartenden Spielern blinken lassen";

-- defaulting to english localization
else
  TITAN_RAIDSUMMON_TOOLTIP_HINT1=       "Click: Summon queued";
  TITAN_RAIDSUMMON_TOOLTIP_HINT2=       "Control-click: Skip player";
  TITAN_RAIDSUMMON_TOOLTIP_HINT3=       "Shift-click: Autoselect";

  TITAN_RAIDSUMMON_TOOLTIP_QUEUE_EMPTY= "Queue Empty";
  TITAN_RAIDSUMMON_TOOLTIP_QUEUED=      "Players in queue:";
  TITAN_RAIDSUMMON_BUTTON_NONE=         "Nobody";
  TITAN_RAIDSUMMON_MENU_FLASH=          "Flash plugin while players in queue";
  TITAN_RAIDSUMMON_DISABLED=            "Disabled";
  TITAN_RAIDSUMMON_PAUSED=              "Paused";
  TITAN_RAIDSUMMON_AFK=                 "AFK-mode";
  TITAN_RAIDSUMMON_BUTTON_LABEL=        "RaidSummon: ";
  TITAN_RAIDSUMMON_MENU_TEXT=           "RaidSummon";
  TITAN_RAIDSUMMON_TOOLTIP=             "RaidSummon";

end;
