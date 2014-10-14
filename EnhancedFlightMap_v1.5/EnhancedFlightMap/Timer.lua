--[[

Timer routines for flight timers.

Code inspired by Kwarz's flightpath.

]]

-- Function: Update
function EFM_Timer_EventFrame_OnUpdate()
	if (EFM_MyConf ~= nil) then
		local ctime;
		EFM_Timer_CheckInFlightStatus();

		if (EFM_MyConf.Timer == true) then
			if (UnitOnTaxi("player")) then
				ctime = time();
				if(ctime ~= EFM_Timer_LastTime) then
					EFM_Timer_ShowInFlightTimer(ctime-EFM_Timer_LastTime);
					EFM_Timer_LastTime = ctime;
				end
			else
				EFM_Timer_HideTimers();
			end
		else
			EFM_Timer_HideTimers();
		end
	end
end

-- Function: Check the in flight status
function EFM_Timer_CheckInFlightStatus()
	if (UnitOnTaxi("player") == 1) then
		if (EFM_Timer_StartRecording == true) then
			EFM_Timer_StartRecording	= false;
			EFM_Timer_Recording		= true;
			EFM_Timer_OrigContinent	= GetCurrentMapContinent();
		end
	else
		-- Hide timers
		EFM_Timer_HideTimers();

		if (EFM_Timer_Recording == true) then
			-- End of the road, stop recording
			EFM_FN_AddFlightTime(EFM_TaxiOrigin, EFM_TaxiDestination, (time() - EFM_Timer_StartTime));
			EFM_Timer_Recording			= false;
			EFM_Timer_StartRecording		= false;
			EFM_CB_Shown				= false;
		end
	end
end

-- Function: Determine remote location from taxi node
function EFM_Timer_TakeTaxiNode(nodeID)
	-- If displaying the remote flight display, end processing.
	if (TaxiMerchant:GetText() == EFM_MSG_REMOTENAME) then
		return;
	end

	EFM_TaxiDestination		= TaxiNodeName(nodeID);
	EFM_Timer_TimeRemaining	= 0;
	EFM_Timer_StartTime		= time();
	EFM_Timer_LastTime		= EFM_Timer_StartTime;

	local flightTime			= EFM_FN_GetFlightDuration(EFM_TaxiOrigin, EFM_TaxiDestination);

	-- If there is a known flight time, calculate the duration estimate
	if (flightTime ~= nil) then
		EFM_Timer_TimeRemaining	= flightTime;
		EFM_Timer_FlightTime		= flightTime;
		EFM_Timer_TimeKnown		= true;
	else
		EFM_Timer_TimeKnown	= false;
		EFM_Timer_FlightTime	= 0;
	end

	EFM_Timer_StartRecording = true;

	Original_TakeTaxiNode(nodeID);
end

-- Function: In flight timer
function EFM_Timer_ShowInFlightTimer(secondsElapsed)

	if (EFM_TaxiDestination) then
		EFM_TimerFrame_Dest:SetText(EFM_FT_DESTINATION..EFM_TaxiDestination);
	else
		EFM_TimerFrame_Dest:SetText(EFM_FT_DESTINATION..UNKNOWN);
	end

	-- Position the destination line of the timer frame as per the configuration.
	EFM_TimerFrame_Dest:ClearAllPoints();
	EFM_TimerFrame_Dest:SetPoint("CENTER", UIParent, "CENTER", 0, EFM_MyConf.TimerPosition);

	EFM_Timer_HideTimers();
	EFM_TimerFrame_Dest:Show();

	if(EFM_Timer_TimeRemaining > 0) then
		EFM_Timer_TimeRemaining = EFM_Timer_TimeRemaining - secondsElapsed;  -- Decrease in flight time remaining
		local displayTime = EFM_SF_FormatTime(EFM_Timer_TimeRemaining);

		-- Display in flight time display thingy...
		if (not EFM_MyConf.ShowTimerBar) then
			EFM_CB_Shown = false;
			-- Show text status
			EFM_TimerFrame_CountDown:SetText(EFM_FT_ARRIVAL_TIME..displayTime);
			EFM_TimerFrame_CountDown:Show();
		else
			EFM_CB_Shown = true;
			-- Position the destination line of the timer frame as per the configuration.
			EFM_TimerFrame_Dest:ClearAllPoints();

			if (EFM_MyConf.ShowLargeBar) then
				CastingBarFrame:SetScale(1.5);
				EFM_TimerFrame_Dest:SetPoint("TOP", CastingBarFrame, "BOTTOM", 0, 45);
			else
				CastingBarFrame:SetScale(1.0);
				EFM_TimerFrame_Dest:SetPoint("TOP", CastingBarFrame, "BOTTOM", 0, 35);
			end

			-- Position the CastingBarFrame
			CastingBarFrame:SetAlpha(1.0);

			-- Display the time remaining text.
			CastingBarText:SetText(EFM_FT_ARRIVAL_TIME..displayTime);

			-- Handle the CastingBarFrameStatusBar
			CastingBarFrameStatusBar:SetStatusBarColor(0.0, 1.0, 0.0, 0.5);
			CastingBarFrameStatusBar:SetMinMaxValues(0, EFM_Timer_FlightTime);
			CastingBarFrameStatusBar:SetValue(EFM_Timer_FlightTime - EFM_Timer_TimeRemaining);

			-- Display the "spark" for the status bar
--			local sparkPosition = floor((EFM_Timer_TimeRemaining / EFM_Timer_FlightTime) * 195);  -- This is used to run the spark "backwards"
			local sparkPosition = floor(((EFM_Timer_FlightTime - EFM_Timer_TimeRemaining) / EFM_Timer_FlightTime) * 195);
			if ( sparkPosition < 0 ) then
				sparkPosition = 0;
			end
			CastingBarSpark:SetPoint("CENTER", CastingBarFrame, "LEFT", sparkPosition, 2);
			CastingBarSpark:SetAlpha(0.5);
			CastingBarSpark:Show();

			-- Hide the "flash" around the casting bar.
			CastingBarFlash:Hide();

			-- Show the casting bar.
			CastingBarFrame:Show();
		end
	else
		if (not EFM_Timer_TimeKnown) then
			-- Display the flight timer screen if the time to destination is unknown as that way people will see it is online.
			EFM_TimerFrame_CountDown:SetText(EFM_FT_ARRIVAL_TIME..UNKNOWN);
			EFM_TimerFrame_CountDown:Show();
		else
			-- Display the flight timer as incorrect
			EFM_TimerFrame_CountDown:SetText(EFM_FT_INCORRECT);
			EFM_TimerFrame_CountDown:Show();
		end
	end
end

-- Function: Hide the flight timer(s)
function EFM_Timer_HideTimers()
	-- Hide my timer references.
	EFM_TimerFrame_Dest:Hide();
	EFM_TimerFrame_CountDown:Hide();
	CastingBarFrame:SetScale(1.0);

	-- Hide the Blizzard CastingBar
	if (EFM_CB_Shown) then
		CastingBarFrame:Hide();
	end
end

-- Function: Replacement GossipTitleButton_OnClick to check for flightpath options.
function EFM_GossipTitleButton_OnClick()
	if ( this.type == "Available" ) then
		SelectGossipAvailableQuest(this:GetID());
	elseif ( this.type == "Active" ) then
		SelectGossipActiveQuest(this:GetID());
	else
		local button_text	= this:GetText();
--		DEFAULT_CHAT_FRAME:AddMessage(button_text);
--		DEFAULT_CHAT_FRAME:AddMessage(EFM_TEST_NIGHTHAVEN);

		if (string.find(button_text, EFM_TEST_NIGHTHAVEN) ~= nil) then
--			DEFAULT_CHAT_FRAME:AddMessage("EFM: Nighthaven Flight Path option");
		
			local orig		= EFM_NIGHTHAVEN;
			local destNode	= nil;
			local routeList	= {};

			EFM_FN_AddNode(orig, "0.549", "0.807", "44.34", "45.91");
			EFM_KP_AddLocation(GetCurrentMapContinent(), orig);

			if (UnitFactionGroup("player") == FACTION_HORDE) then
				destNode	= EFM_FN_GetNodeByName("Thunder Bluff, Mulgore", "enUS");
				local _, _, tempRouteData = string.find(EFM_FN_GetRouteDataByName("Thunder Bluff, Mulgore"), ".*~(.*)");
				routeList["Thunder Bluff, Mulgore"] = tempRouteData;
			elseif (UnitFactionGroup("player") == FACTION_ALLIANCE) then
				destNode	= EFM_FN_GetNodeByName("Rut'theran Village, Teldrassil", "enUS");
				local _, _, tempRouteData = string.find(EFM_FN_GetRouteDataByName("Rut'theran Village, Teldrassil"), ".*~(.*)");
				routeList["Rut'theran Village, Teldrassil"] = tempRouteData;				
			end
			EFM_FN_AddRoutes(orig, routeList);

			if (destNode ~= nil) then
--				DEFAULT_CHAT_FRAME:AddMessage("EFM: Destination node known.");
				EFM_TaxiDestination		= destNode[GetLocale()];
				EFM_TaxiOrigin			= orig;

				EFM_Timer_TimeRemaining	= 0;
				EFM_Timer_StartTime		= time();
				EFM_Timer_LastTime		= EFM_Timer_StartTime;

				local flightTime			= EFM_FN_GetFlightDuration(EFM_TaxiOrigin, EFM_TaxiDestination);

				-- If there is a known flight time, calculate the duration estimate
				if (flightTime ~= nil) then
					EFM_Timer_TimeRemaining	= flightTime;
					EFM_Timer_FlightTime		= flightTime;
					EFM_Timer_TimeKnown		= true;
				else
					EFM_Timer_TimeKnown	= false;
					EFM_Timer_FlightTime	= 0;
				end

				EFM_Timer_StartRecording = true;
			end
		end

		SelectGossipOption(this:GetID());
	end
end
