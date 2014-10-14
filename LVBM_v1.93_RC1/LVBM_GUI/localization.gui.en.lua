---------------------------------------------------
-- La Vendetta BossMods GUI Language File        --
-- GUI by LV|Nitram                              --
--                                               --
-- Translations by:                              --
--   LV|Nitram  -> EN                            --
--   LV|Tandanu -> DE                            --
--   LV|Tandanu -> fixed typos                   --
---------------------------------------------------

----------------------------------
-- Translation by Default -> EN --
----------------------------------

-- LVBM_GUI.lua for Bossmod List Frame (LVBMBossModListFrame)
LVBMGUI_TAB_1_TITLE_TEXT		= "Naxxramas Boss Mods";
LVBMGUI_TAB_2_TITLE_TEXT		= "Temple of Ahn'Qiraj Boss Mods";
LVBMGUI_TAB_3_TITLE_TEXT		= "Blackwing Lair Boss Mods";
LVBMGUI_TAB_4_TITLE_TEXT		= "Molten Core Boss Mods";
LVBMGUI_TAB_5_TITLE_TEXT		= "Zul'Gurub and Ahn'Qiraj Boss Mods";
LVBMGUI_TAB_6_TITLE_TEXT		= "Other Boss Mods";

-- Tooltips
LVBMGUI_FRAMETAB_1_TT			= "Naxxramas Boss Mods";
LVBMGUI_FRAMETAB_1_TD			= "A collection of our boss mods for Naxxramas. Select an encounter to get additional options.";
LVBMGUI_FRAMETAB_2_TT			= "Temple of Ahn'Qiraj Boss Mods";
LVBMGUI_FRAMETAB_2_TD			= "A collection of our boss mods for the Temple of Ahn'Qiraj. Select an encounter to get additional options.";
LVBMGUI_FRAMETAB_3_TT			= "Blackwing Lair Boss Mods";
LVBMGUI_FRAMETAB_3_TD			= "A collection of our boss mods for Blackwing Lair. Select an encounter to get additional options.";
LVBMGUI_FRAMETAB_4_TT			= "Molten Core Boss Mods";
LVBMGUI_FRAMETAB_4_TD			= "A collection of our boss mods for Molten Core. Select an encounter to get additional options.";
LVBMGUI_FRAMETAB_5_TT			= "Zul'Gurub and Ahn'Qiraj Boss Mods";
LVBMGUI_FRAMETAB_5_TD			= "A collection of our boss mods for Zul'Gurub and Ahn'Qiraj 20. Select an encounter to get additional options.";

LVBMGUI_DISABLE_ADDON			= "Disable AddOn";
LVBMGUI_ENABLE_ADDON			= "Enable AddOn";
LVBMGUI_STOP_ADDON				= "Stop AddOn";
LVBMGUI_DISABLE_ANNOUNCE		= "Disable Announce";
LVBMGUI_ENABLE_ANNOUNCE			= "Enable Announce";
LVBMGUI_SHOW_DROPDOWNMENU		= "Additional Options";
LVBMGUI_DROPDOWNMENU_TITLE		= "Boss Mod Menu";

-- LVBMBossModFrame
LVBMGUI_HIDE_OPTIONS				= "<<< Options";
LVBMGUI_SHOW_OPTIONS				= "Options >>>";

-- Options Frame (LVBMOptionsFrame)
if( LVBM.VersionBeta ) then
	LVBMGUI_OPTIONS					= "LVBM v"..LVBM.Version.." - "..LVBM.VersionBeta;
else
	LVBMGUI_OPTIONS					= "Options (GUI v"..LVBMGUI_VERSION.." / Boss Mod v"..LVBM.Version..")";
end
LVBMGUI_SIDEFRAME_TAB1				= "General";
LVBMGUI_SIDEFRAME_TAB2				= "Bars";
LVBMGUI_SIDEFRAME_TAB3				= "Warnings";
LVBMGUI_SIDEFRAME_TAB4				= "Specials";

-- LVBMOptionsFramePage1
LVBMGUI_TITLE_SYNCSETTINGS			= "Synchronization Setup";
LVBMGUI_TITLE_MINIMAPBUTTON			= "Minimap Button Setup";
LVBMGUI_TITLE_AGGROALERT			= "Aggro Alert Settings";
LVBMGUI_CHECKBOX_SYNC_ENABLE			= "Enable synchronization";
LVBMGUI_BUTTON_VERSION_CHECK			= "Version check";
LVBMGUI_BUTTON_VERSION_CHECK_FAILD		= "No other Vendetta Boss Mod AddOns found";
LVBMGUI_BUTTON_STATUSBAR_SYNCINFO		= "Status bar sync info";
LVBMGUI_BUTTON_STATUSBAR_SYNCINFO_FAILD 	= "There are no bars.";
LVBMGUI_SLIDER_MINIMAP_1			= "Position";
LVBMGUI_SLIDER_MINIMAP_2			= "Radius";
LVBMGUI_CHECKBOX_MINIMAP			= "Show minimap button";
LVBMGUI_CHECKBOX_AGGROALERT_ENABLE		= "Enable aggro alert";
LVBMGUI_BUTTON_AGGROALERT_TEST			= "Test aggro alert";
LVBMGUI_BUTTON_AGGROALERT_RESET			= "Reset settings";
LVBMGUI_BUTTON_AGGROALERT_RESET_DONE		= "Aggro alert has been resetted";
LVBMGUI_CHECKBOX_AGGROALERT_PLAYSOUND		= "Play sound on aggro gain";
LVBMGUI_CHECKBOX_AGGROALERT_FLASH		= "Flash on aggro gain";
LVBMGUI_CHECKBOX_AGGROALERT_SHAKE		= "Shake on aggro gain";
LVBMGUI_CHECKBOX_AGGROALERT_SPECIALTEXT		= "Show special warning";
LVBMGUI_CHECKBOX_AGGROALERT_LOCALWARNING	= "Show warning as local warning";
LVBMGUI_BUTTON_MOVEABLEBAR			= "Movable bar";
LVBMGUI_BUTTON_DEFAULTS				= "Defaults";

-- LVBMOptionsFramePage2
LVBMGUI_TITLE_STATUSBARS 			= "Status Bar Timer Setup";
LVBMGUI_TITLE_PIZZATIMER			= "Create \"Pizza Timer\"";
LVBMGUI_CHECKBOX_STATUSBAR_ENABLE		= "Enable status bars";
LVBMGUI_CHECKBOX_STATUSBAR_FILLUP		= "Fill up status bars";
LVBMGUI_CHECKBOX_STATUSBAR_FLIPOVER		= "Expand status bars upwards";
LVBMGUI_EDITBOX_PIZZATIMER_TEXT			= "Name";
LVBMGUI_EDITBOX_PIZZATIMER_MIN			= "Minutes";
LVBMGUI_EDITBOX_PIZZATIMER_SEC			= "Seconds";
LVBMGUI_CHECKBOX_PIZZATIMER_BROADCAST		= "Broadcast timer to raid";
LVBMGUI_BUTTON_PIZZATIMER_START			= "Start timer";

-- LVBMOptionsFramePage3
LVBMGUI_TITLE_RAIDWARNING			= "Raid Warnings";
LVBMGUI_TITLE_SELFWARNING			= "Local Warnings"; 
LVBMGUI_DROPDOWN_RAIDWARNING_OPTION_1		= "RaidWarning (default Sound)";
LVBMGUI_DROPDOWN_RAIDWARNING_OPTION_2		= "BellTollNightElf (CT_Raid Sound)";
LVBMGUI_DROPDOWN_RAIDWARNING_OPTION_3		= "Disable sound warning";
LVBMGUI_DROPDOWN_RAIDWARNING_INFO_DISABLED	= "Raid Warning sound disabled";
LVBMGUI_RAIDWARNING_EXAMPLE			= "*** Example Raid Warning ***";
LVBMGUI_BUTTON_SOUND_TEST			= "Test sound";
LVBMGUI_BUTTON_SHOW_EXAMPLE			= "Show example";
LVBMGUI_BUTTON_RAIDWARNING_RESET		= "Reset frame";
LVBMGUI_BUTTON_RAIDWARNING_RESET_DONE		= "Settings successfully resetted to defaults";

-- LVBMOptionsFramePage4
LVBMGUI_TITLE_SPECIALWARNING			= "Setup Special Warnings";
LVBMGUI_TITLE_SHAKESCREEN			= "Setup Screen Shake Effects";
LVBMGUI_TITLE_FLASHEFFECT			= "Setup Flash Effects";
LVBMGUI_CHECKBOX_SPECWARNING_ENABLE		= "Enable special warnings";
LVBMGUI_BUTTON_SPECWARNING_TEST			= "Test warning";
LVBMGUI_BUTTON_SPECWARNING_EXAMPLE		= "Test message :)";
LVBMGUI_SLIDER_SPECWARNING_DURATION		= "Duration";
LVBMGUI_SLIDER_SPECWARNING_FADETIME		= "Fade time";
LVBMGUI_SLIDER_SPECWARNING_TEXTSIZE		= "Text size";
LVBMGUI_CHECKBOX_SHAKESCREEN_ENABLE		= "Enable screen shake effects";
LVBMGUI_BUTTON_SHAKESCREEN_TEST			= "Test shake";
LVBMGUI_SLIDER_SHAKESCREEN_DURATION		= "Duration";
LVBMGUI_SLIDER_SHAKESCREEN_INTENSITY		= "Intensity";
LVBMGUI_CHECKBOX_FLASHEFFECT_ENABLE		= "Enable flash effects";
LVBMGUI_BUTTON_FLASHEFFECT_TEST			= "Test flash";
LVBMGUI_SLIDER_FLASHEFFECT_DURATION		= "Duration";
LVBMGUI_SLIDER_FLASHEFFECT_FLASHES		= "Flashes";

-- LVBMOptionsFramePage5
LVBMGUI_ABOUTTITLE	= "About";
LVBMGUI_ABOUTTEXT	= {
	"LV Bossmods API (c) by DeadlyMinds Tandanu",
	"LV Bossmods GUI (c) by La Vendetta Nitram",
	" ",
	"Thanks for using our AddOn.",
	" ",
	"                                  Visit",
	" ",
	"                   www.deadlyminds.net",
	" ",
	"                                   and",
	" ",
	"                 www.curse-gaming.com",
	" ",
	"If you have a suggestion or a bug report, leave a comment at www.curse-gaming.com or post in our forums at www.deadlyminds.net",

};

-- Translations added v1.05
LVBMGUI_DISTANCE_FRAME_TITLE		= "Distance";
LVBMGUI_DISTANCE_FRAME_TEXT		= "Too near:";

LVBMGUI_INFOFRAME_TOOLTIP_TITLE		= "Info Frame";
LVBMGUI_INFOFRAME_TOOLTIP_TEXT		= "Right-click to move\nShift + right-click to hide";

LVBMGUI_STATUSBAR_WIDTH_SLIDER		= "Bar width";
LVBMGUI_STATUSBAR_SCALE_SLIDER		= "Bar scale";

LVBMGUI_BUTTON_RANGECHECK		= "Range check";
LVBMGUI_TOOLTIP_RANGECHECK_TITLE	= "Range check";
LVBMGUI_TOOLTIP_RANGECHECK_TEXT		= "Starts a range check which shows you all players who stand more than 30 yards away from you.";

LVBMGUI_BUTTON_DISTANCEFRAME		= "Distance frame";
LVBMGUI_TOOLTIP_DISTANCEFRAME_TITLE	= "Distance frame";
LVBMGUI_TOOLTIP_DISTANCEFRAME_TEXT	= "Shows or hides a distance check frame. It shows all players who stand too close to you (10 yards). This frame is useful for encounters like C'Thun or Huhuran.";

-- Translations added v1.10
LVBMGUI_SIDEFRAME_TAB5				= "Misc";
LVBMGUI_SIDEFRAME_TAB6				= "About";

LVBMGUI_SLIDER_STATUSBAR_COUNT			= "Bar count";
LVBMGUI_DROPDOWN_STATUSBAR_DESIGN_1		= "Classic Design"; --wird überflüssig mit dem Verwenden des Namens aus der Tabelle
LVBMGUI_DROPDOWN_STATUSBAR_DESIGN_2		= "Modern Style"; 
LVBMGUI_DROPDOWN_STATUSBAR_EXAMPLE_BAR		= "Example Bar";

LVBMGUI_TITLE_AUTORESPOND			= "Auto Respond Settings";
LVBMGUI_CHECKBOX_AUTORESPOND_ENABLE		= "Auto respond to whispers during boss fights";
LVBMGUI_CHECKBOX_AUTORESPOND_SHOW_WHISPERS	= "Show whispers during combat";
LVBMGUI_CHECKBOX_AUTORESPOND_INFORM_USER	= "Inform me about auto-responded whispers";
LVBMGUI_CHECKBOX_AUTORESPOND_HIDE_REPLY		= "Hide auto responses";

LVBMGUI_EDITBOX_AUTORESPOND_TITLE		= "Message to send during boss fights";
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_HEADER	= "The following strings will\nbe automatically replaced:";
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT1	= {"%P", "your name"};
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT2	= {"%B", "boss name"};
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT3	= {"%HP", "boss hp"};
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT4	= {"%ALIVE", "raid members alive"};
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT5	= {"%RAID", "raid members"};

-- Translations added v1.15
LVBMGUI_CHECKBOX_ALLOW_STATUS_COMMAND		= "Allow users to request the Fight status (whisper \"status\")";
LVBMGUI_CHECKBOX_SHOWCOMBATINFO			= "Show combat information like fight length";
LVBMGUI_TITLE_COMBATSYSTEM			= "Combat Detection System";
LVBMGUI_BUTTON_STATUSBAR_FLASHONEND		= "Flash bar on timer end";
LVBMGUI_BUTTON_STATUSBAR_AUTOCOLORBARS		= "Dynamic bar color";

-- Translations added v1.20
LVBMGUI_TITLE_RAIDOPTIONS			= "Raid Options";
LVBMGUI_CHECKBOX_HIDEPLAYERNAMESINRAIDS		= "Hide player names when joining a raid group";
LVBMGUI_CHECKBOX_ALLOWSYNCFROMOLDCLIENT		= "Accept sync from old clients";

-- Translation added v1.25
LVBMGUI_CHECKBOX_ENABLE_RAIDWARNINGFRAME	= "Enable RaidWarning Frame";
LVBMGUI_CHECKBOX_ENABLE_SELFWARNINGFRAME	= "Enable SelfWarning Frame";
LVBMGUI_TAB_NAXX_TEXT				= "Naxx";
LVBMGUI_TAB_AQ40_TEXT				= "AQ40";
LVBMGUI_TAB_BWL_TEXT				= "BWL";
LVBMGUI_TAB_MC_TEXT				= "MC";
LVBMGUI_TAB_20PL_TEXT				= "ZG/AQ20";
LVBMGUI_TAB_OTHER_TEXT				= "Other";
LVBMGUI_BUTTON_LOADADDON			= "Load AddOn";
LVBMGUI_FRAME_LOADADDON_DESCRIPTION		= {
	"Please enter the zone to load the AddOns",
	"automatically. If you want to load the AddOns",
	"manually, click on \"Load AddOns\".",
	"After this the AddOns are loaded and working,",
	"but using memory and CPU. This feature is",
	"only a performance tweak because we don't",
	"want to load AddOns for instances we never do.",
};

-- Range stuff
LVBM_GUI_COMBATLOG_MIN_RANGE        = "Combat log set to minimum range";
LVBM_GUI_COMBATLOG_MAX_RANGE        = "Combat log set to maximum range";
LVBM_GUI_COMBATLOG_LONG_RANGE       = "Combat log set to long range";
LVBM_GUI_COMBATLOG_DEFAULT_RANGE    = "Combat log set to default range";