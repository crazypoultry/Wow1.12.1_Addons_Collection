--[[

globals.lua

This file contains all globally defined data strings.

These strings are not to be localised, so they are here, and not in any of the locale files.

]]

-- Global define
EFM_Version						= "1.5";

-- Timer variables (see timer.lua)
EFM_Timer_StartRecording				= false;
EFM_Timer_Recording					= false;
EFM_Timer_TaxiDestination				= "";
EFM_Timer_LastTime					= time();
EFM_Timer_TimeRemaining				= 0;
EFM_Timer_TimeKnown					= false;
EFM_Timer_FlightTime					= 0;

-- For the map updates (see map.lua)
knownPoints						= {};
EFM_MAX_POI						= 50;

-- Flightmaster defines (see flightmaster.lua)
EFM_OriginalTaxiNodeOnButtonEnter		= nil;
EFM_TaxiOrigin						= "";
EFM_FM_MAXPATHS					= 100;
EFM_TaxiDistantButtonData				= {};
EFM_ShowUnknownTimes				= false;		-- Special variable, if set true, show the missing flight times when viewing the flight master display.
											-- It stops after showing a missing route at a particular hop rank.
											-- Turn this on only if you intend to assist with the data collection efforts, as it might not work all the time...

-- CastingBar defines
-- The CastingBar is now being used to create the in-flight timer bar.
EFM_CB							= {};			-- Variable for storing reference data about the CastingBar location.
EFM_CB.DefaultScale					= 0;			-- Variable for default scale value for the CastingBar Frame.
EFM_CB.Shown						= false;		-- Variable to store if we have or have not shown the CastingBarFrame.

-- Special strings.  These strings do not get modified for locale-specificness...
EFM_HELPCMD_STRING					= "|c00FFFFFF%s|r";