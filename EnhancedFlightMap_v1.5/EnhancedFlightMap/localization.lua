--[[
Localization.lua

Mostly this is to allow some kind soul to assist with a future internationalisation effort...
But it won't be me as English is the only language I know :-)

For those who would like to assist with localising this, just remember,
if you are not modifying a variable, please don't include it in your localization,
commenting it out so it can be localised it needed in the future is recommended.

Please see localization-frFR.lua and localization-deDE.lua for example internationalisations.
]]

-- Begin English Localization --
EFM_DESC						= "Enhanced Flight Map";
EFM_Version_String				= format("%s - Version %s", EFM_DESC, EFM_Version);

-- Slash Commands
EFM_CMD_HELP					= "help";
EFM_CMD_CLEAR					= "clear";
EFM_CMD_CLEAR_ALL				= "clear all";
EFM_CMD_GUI					= "config";
EFM_CMD_MAP					= "open";
EFM_CMD_REPORT				= "report";

EFM_SLASH1					= "/enhancedflightmap";
EFM_SLASH2					= "/efm";

-- Help Text
EFM_HELP_TEXT0 				= "---";
EFM_HELP_TEXT1 				= format("%s command help:", 										EFM_Version_String);
EFM_HELP_TEXT2 				= format("Use %s or %s to perform the following commands:-",					format(EFM_HELPCMD_STRING, EFM_SLASH1.." <command>"), format(EFM_HELPCMD_STRING, EFM_SLASH2.." <command>"));
EFM_HELP_TEXT3 				= format("%s: Displays this message.",									format(EFM_HELPCMD_STRING, EFM_CMD_HELP));
EFM_HELP_TEXT4				= format("%s: Displays the options menu.",								format(EFM_HELPCMD_STRING, EFM_CMD_GUI));
EFM_HELP_TEXT5 				= format("%s: Clears the list of known routes and flight points.",					format(EFM_HELPCMD_STRING, EFM_CMD_CLEAR));
EFM_HELP_TEXT6 				= format("%s: Clears the list of known routes and flight points for %s.",				format(EFM_HELPCMD_STRING, EFM_CMD_CLEAR.." <faction>"), format(EFM_HELPCMD_STRING, "<faction>"));
EFM_HELP_TEXT7 				= format("%s: Displays a map similar to the flight master map for the current continent.",	format(EFM_HELPCMD_STRING, EFM_CMD_MAP));
EFM_HELP_TEXT8 				= format("%s: Displays a map similar to the flight master map for the continent <continent>, where <continent> is kalimdor or azeroth.",				format(EFM_HELPCMD_STRING, EFM_CMD_MAP.." <continent>"));
EFM_HELP_TEXT9				= format("%s: Reports your current destination and arrival time to <channel>, <channel> can be guild, party or a number that reflects a real channel.",	format(EFM_HELPCMD_STRING, EFM_CMD_REPORT.." <channel>"));

-- Other messages
EFM_CLEAR_HELP					= format("%s: To truly clear the list, you need to type %s this is a safety feature.",		EFM_DESC, format(EFM_HELPCMD_STRING, EFM_CMD_CLEAR_ALL));
EFM_MSG_CLEAR					= format("%s: Entire flight path data cleared.",									EFM_DESC);
EFM_MSG_CLEARFACTION			= format("%s: Entire flight path data for %%s cleared.",							EFM_DESC);
EFM_MSG_DATALOAD				= format("%s: Entire flight path data for %%s loaded.",							EFM_DESC);
EFM_MSG_DATALOADTIMERS			= format("%s: Flight path data for %%s loaded.  Data only loaded for known flight points.",	EFM_DESC);
EFM_NEW_NODE					= format("%s: %s %%s to %%s.",											EFM_DESC, ERR_NEWTAXIPATH);
EFM_MSG_DELETENODE				= format("%s: Flight Node %%s and all referencing data deleted!",					EFM_DESC);
EFM_MSG_MOVENODE				= format("%s: Moving node %%s to correct map location.",							EFM_DESC);

-- Remote flight path messages
EFM_MSG_REMOTENAME			= "Remote Flight Display";
EFM_MSG_KALIMDOR				= "Kalimdor";
EFM_MSG_AZEROTH				= "Azeroth (Eastern Kindoms)";
EFM_FMCMD_CURRENT				= "current";
EFM_FMCMD_KALIMDOR			= "kalimdor";
EFM_FMCMD_AZEROTH				= "azeroth";

-- Flight time messages
EFM_FT_FLIGHT_TIME				= "Recorded flight time: ";
EFM_FT_FLIGHT_TIME_CALC			= "Calculated flight time: ";
EFM_FT_DESTINATION				= "Flying To ";
EFM_FT_ARRIVAL_TIME				= "Estimated arrival in: ";
EFM_FT_INCORRECT				= "Flight time incorrect, timers will be updated upon landing.";

-- Flight time report messages
EFM_MSG_REPORT				= "EFM: Heading to %s, estimated to arrive in %s.";
EFM_MSG_REPORTERROR			= "EFM: Error: Not in flight or destination unknown!";
EFM_MSG_REPORTERRORTIME		= "EFM: Error: Arrival time unknown!";
EFM_MSG_UNKNOWNCONTINENT		= "EFM: Error: Continent unknown, please select a specific continent to display!";

-- Map screen messages
EFM_MAP_PATHLIST				= "Available Flight Paths";

-- GUI Options Screen
EFM_GUITEXT_Header				= format("%s Options", EFM_DESC);
EFM_GUITEXT_Done				= "Done";
EFM_GUITEXT_Defaults				= "Defaults";
EFM_GUITEXT_Timer				= "Show In-Flight timers";
EFM_GUITEXT_ShowTimerBar			= "Show In-Flight timer status bar";
EFM_GUITEXT_ShowLargeBar			= "Show Large In-Flight timer status bar";
EFM_GUITEXT_ZoneMarker			= "Show Flightmaster locations on Zone Map";
EFM_GUITEXT_DruidPaths			= "Show the Druid-only flight paths";
EFM_GUITEXT_DisplaySlider			= "In-Flight Display Position.  Offset: %s.";
EFM_GUITEXT_LoadHeader			= "Data Loading";
EFM_GUITEXT_LoadAlliance			= FACTION_ALLIANCE;				-- Should not need localization as this is the official blizzard locale-string.
EFM_GUITEXT_LoadDruid			= "Druid";
EFM_GUITEXT_LoadHorde			= FACTION_HORDE;				-- Should not need localization as this is the official blizzard locale-string.
EFM_GUITEXT_LoadAll				= "Load all pre-load data";

-- GUI Option Screen Tooltips
EFM_GUITEXT_Tooltip_Timer			= "Show the in-flight timer.";
EFM_GUITEXT_Tooltip_ShowTimerBar	= "Show the in-flight timer as a status bar, status bar is based on the casting bar.";
EFM_GUITEXT_Tooltip_ShowLargeBar	= "Show the in-flight timer status bar in an expanded version (useful for seeing the current time remaining from accross the room).";
EFM_GUITEXT_Tooltip_ZoneMarker		= "Show known flight master locations on the zone map.  The flight master only needs to have been seen by any of your characters.";
EFM_GUITEXT_Tooltip_DruidPaths		= "Show the druid flight paths on the remote flight map.";
EFM_GUITEXT_Tooltip_DisplaySlider		= "Select the in-flight display screen position.\n\nPositive values are above screen centre.\nNegative values below screen centre.";
EFM_GUITEXT_Tooltip_LoadAll		= "If selected, load all the pre-load data (Default).  If deselected, only load flight times for known flight nodes";

-- Key Binding Strings
BINDING_HEADER_EFM				= "Enhanced Flight Map";
BINDING_NAME_OPTIONS			= "Toggle options screen";
BINDING_NAME_MAP1				= "Toggle map - Current Continent";
BINDING_NAME_MAP2				= "Toggle map - Kalimdor";
BINDING_NAME_MAP3				= "Toggle map - Azeroth";

-- Debug Strings
EFM_DEBUG_HEADER_MT			= format("%s: Flight Paths with Missing Times:-", EFM_DESC);
EFM_DEBUG_MT					= format("%s: Flight time missing for %%s to %%s.  %%s Hop(s).", EFM_DESC);

-- Druid flightpath strings
EFM_TEST_NIGHTHAVEN			= "I'd like to fly";				-- This is EXACTLY the text given by the druid flight masters for Nighthaven.
													-- This should match as much of the option text as possible to match both horde and alliance flight master options.
EFM_NIGHTHAVEN				= "Nighthaven, Moonglade";

-- End English Localization --
