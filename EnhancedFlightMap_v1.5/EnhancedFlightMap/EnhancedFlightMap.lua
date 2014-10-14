--[[

Main program function for Enhanced Flight Map.

Localisation of text should be done in localization.lua.

All other code in here should not be modified unless you know what you are doing,
and if you do modify something, please let me know.

]]

---------------------------------------------------------------------------
-- Functions to deal with the various methods the program can be called
---------------------------------------------------------------------------

-- Events to register for.
function EnhancedFlightMap_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
end

-- What to do when events are seen.
function EnhancedFlightMap_OnEvent()
	if ((event == "ADDON_LOADED") and (arg1 == "EnhancedFlightMap")) then
		-- Register our slash commands
		SLASH_EFM1 = EFM_SLASH1;
		SLASH_EFM2 = EFM_SLASH2;
		SlashCmdList["EFM"] = function(msg)
			EFM_SlashCommandHandler(msg);
		end

		-- Define program Hooks
		-- Hook DrawOneHopLines function.
		-- We do this to find the direct flight paths from each node.
		if (DrawOneHopLines ~= EFM_FM_DrawOneHopLines) then
			EFM_Orig_DrawOneHopLines	= DrawOneHopLines;
			DrawOneHopLines			= EFM_FM_DrawOneHopLines;
		end

		-- Hook TaxiNodeOnButtonEnter function.
		-- We do this to be able to display the additional data for the blizzard-defined nodes as well as our nodes.
		if (TaxiNodeOnButtonEnter ~= EFM_FM_TaxiNodeOnButtonEnter) then
			EFM_OriginalTaxiNodeOnButtonEnter	= TaxiNodeOnButtonEnter;
			TaxiNodeOnButtonEnter				= EFM_FM_TaxiNodeOnButtonEnter;
		end

		-- Hook the TakeTaxiNode function.
		-- This is done as there is no way (currently) to determine what node we are flying to while in flight.
		if (TakeTaxiNode ~= EFM_Timer_TakeTaxiNode) then
			Original_TakeTaxiNode	= TakeTaxiNode;
			TakeTaxiNode		= EFM_Timer_TakeTaxiNode;
		end

		-- Hook the GossipTitleButton_OnClick function.
		-- This is done due to 1.11 changes to druid flightpaths at nighthaven, might be needed elsewhere in the future also.
		if (GossipTitleButton_OnClick ~= EFM_GossipTitleButton_OnClick) then
			Original_GossipTitleButton_OnClick	= GossipTitleButton_OnClick;
			GossipTitleButton_OnClick		= EFM_GossipTitleButton_OnClick;
		end

		-- Display login message
		if (EFM_SF_VERS_NUM) then
			EFM_SF_ProgramLoadedText(EFM_Version_String);
		end

		-- Call various init routines.
		EFM_DefineData();
		EFM_ValidateVersions();
		EFM_GUI_Init();

		-- Register the events we want to listen for
		this:RegisterEvent("PLAYER_ENTERING_WORLD");
		this:RegisterEvent("PLAYER_LEAVING_WORLD");

		return;

	elseif (event == "PLAYER_ENTERING_WORLD") then
		-- Fix moved flight paths.
		if (UnitFactionGroup("player") == FACTION_ALLIANCE) then
			local myNode = EFM_FN_GetNodeByName("Moonglade", "enUS");
			if (myNode ~= nil) then
				local myZone = EFM_FN_GetNodeZone(myNode[GetLocale()]);
				local routeData = myZone.."~"..myNode.fmLoc;
				if (routeData == "10~0.552:0.793") then
					EFM_Data_FlightMove(myNode, 0.552, 0.794, FACTION_ALLIANCE);
				end
			end
		end

		this:RegisterEvent("WORLD_MAP_UPDATE");
		this:RegisterEvent("TAXIMAP_OPENED");
		return;

	elseif (event == "PLAYER_LEAVING_WORLD") then
		EFM_Timer_StartRecording	= false;
		EFM_Timer_Recording		= false;
		this:UnregisterEvent("WORLD_MAP_UPDATE");
		this:UnregisterEvent("TAXIMAP_OPENED");
		EFM_Timer_HideTimers();
		return;

	elseif (event == "WORLD_MAP_UPDATE") then
		EFM_Map_WorldMapEvent();
		return;

	elseif (event == "TAXIMAP_OPENED") then
		EFM_FM_TaxiMapOpenEvent();
		return;

	end
end
