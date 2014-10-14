--[[

	MonkeySpeed:
	A simple speedometer.
	
	Author: Trentin
	
	Resurected by: Quel

--]]


-- OnLoad Function
function MonkeySpeed_OnLoad()
	
	-- register events
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_NAME_UPDATE");			-- this is the event I use to get per character config settings
	this:RegisterEvent("PLAYER_ENTERING_WORLD");	-- this event gives me a good character name in situations where "UNIT_NAME_UPDATE" doesn't even trigger
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");

	-- register chat slash commands
	-- this command toggles the percent display
	SlashCmdList["MONKEYSPEED_PERCENT"] = MonkeySpeed_TogglePercent;
	SLASH_MONKEYSPEED_PERCENT1 = "/monkeyspeedpercent";
	SLASH_MONKEYSPEED_PERCENT2 = "/mspercent";
	
	-- this command toggles the coloured speed bar display
	SlashCmdList["MONKEYSPEED_BAR"] = MonkeySpeed_ToggleBar;
	SLASH_MONKEYSPEED_BAR1 = "/monkeyspeedbar";
	SLASH_MONKEYSPEED_BAR2 = "/msbar";

	-- this command toggles the whole speed bar display
	SlashCmdList["MONKEYSPEED_DISPLAY"] = MonkeySpeed_ToggleDisplay;
	SLASH_MONKEYSPEED_DISPLAY1 = "/monkeyspeed";
	SLASH_MONKEYSPEED_DISPLAY2 = "/mspeed";
	
	-- this command toggles the debug mode
	SlashCmdList["MONKEYSPEED_DEBUG"] = MonkeySpeed_ToggleDebug;
	SLASH_MONKEYSPEED_DEBUG1 = "/monkeyspeeddebug";
	SLASH_MONKEYSPEED_DEBUG2 = "/msdebug";
	
	-- this command toggles the lock
	SlashCmdList["MONKEYSPEED_LOCK"] = MonkeySpeed_ToggleLock;
	SLASH_MONKEYSPEED_LOCK1 = "/monkeyspeedlock";
	SLASH_MONKEYSPEED_LOCK2 = "/mslock";

	-- this command recalibrates the speed calculations for this zone
	SlashCmdList["MONKEYSPEED_CALIBRATE"] = MonkeySpeedSlash_CmdCalibrate;
	SLASH_MONKEYSPEED_CALIBRATE1 = "/monkeyspeedcalibrate";
	SLASH_MONKEYSPEED_CALIBRATE2 = "/mscalibrate";
	
	-- MonkeySpeedFrame:SetBackdropBorderColor(0.75, 0.75, 0.75, 1.0);
	MonkeySpeedFrame:SetBackdropBorderColor(1.0, 0.6901960784313725, 0.0, 1.0);
end

-- OnEvent Function
function MonkeySpeed_OnEvent(event)
	
	if (event == "VARIABLES_LOADED") then
		-- this event gets called when the player enters the world
		--  Note: on initial login this event will not give a good player name
		
		MonkeySpeed.m_bVariablesLoaded = true;
		
		-- double check that the mod isn't already loaded
		if (not MonkeySpeed.m_bLoaded) then
			
			MonkeySpeed.m_strPlayer = UnitName("player");
			
			-- if MonkeySpeed.m_strPlayer is "Unknown Entity" get out, need a real name
			if (MonkeySpeed.m_strPlayer ~= nil and MonkeySpeed.m_strPlayer ~= UNKNOWNOBJECT) then
				-- should have a valid player name here
				MonkeySpeed_Init();
			end
		end
		
		-- exit this event
		return;
		
	end -- PLAYER_ENTERING_WORLD
	
	if (event == "UNIT_NAME_UPDATE") then
		-- this event gets called whenever a unit's name changes (supposedly)
		--  Note: Sometimes it gets called when unit's name gets set to
		--  "Unknown Entity"
				
		-- double check that we are getting the player's name update
		if (arg1 == "player" and not MonkeySpeed.m_bLoaded) then
			-- this is the first place I know that reliably gets the player name
			MonkeySpeed.m_strPlayer = UnitName("player");
			
			-- if MonkeySpeed.m_strPlayer is "Unknown Entity" get out, need a real name
			if (MonkeySpeed.m_strPlayer ~= nil and MonkeySpeed.m_strPlayer ~= UNKNOWNOBJECT) then
				-- should have a valid player name here
				MonkeySpeed_Init();
			end
		end
		
		-- exit this event
		return;
		
	end -- UNIT_NAME_UPDATE
	if (event == "PLAYER_ENTERING_WORLD") then
		-- this event gets called when the player enters the world
		--  Note: on initial login this event will not give a good player name
		
		-- double check that the mod isn't already loaded
		if (not MonkeySpeed.m_bLoaded) then
			
			MonkeySpeed.m_strPlayer = UnitName("player");
			
			-- if MonkeySpeed.m_strPlayer is "Unknown Entity" get out, need a real name
			if (MonkeySpeed.m_strPlayer ~= nil and MonkeySpeed.m_strPlayer ~= UNKNOWNOBJECT) then
				-- should have a valid player name here
				MonkeySpeed_Init();
			end
		end
		
		-- exit this event
		return;
		
	end -- PLAYER_ENTERING_WORLD
	
	if (event == "ZONE_CHANGED_NEW_AREA") then
		-- this fixes the speed displaying wrong sometimes when you switch areas (thanks Bhaldie)
		SetMapToCurrentZone();

	end -- ZONE_CHANGED_NEW_AREA
end

-- OnUpdate Function (heavily based off code in Telo's Clock)
function MonkeySpeed_OnUpdate(arg1)

	-- if the speedometer's not loaded yet, just exit
	if (not MonkeySpeed.m_bLoaded) then
		return;
	end
	
	-- how long since the last update?
	MonkeySpeed.m_iDeltaTime = MonkeySpeed.m_iDeltaTime + arg1;
	
	-- update the speed calculation
	MonkeySpeed.m_vCurrPos.x, MonkeySpeed.m_vCurrPos.y = GetPlayerMapPosition("player");
	MonkeySpeed.m_vCurrPos.x = MonkeySpeed.m_vCurrPos.x + 0.0;
	MonkeySpeed.m_vCurrPos.y = MonkeySpeed.m_vCurrPos.y + 0.0;

	if (MonkeySpeed.m_vCurrPos.x) then
		local dist;
		
		-- travel speed ignores Z-distance (i.e. you run faster up or down hills)	
		-- x and y coords are not square, had to weight the x by 2.25 to make the readings match the y axis.
		dist = math.sqrt(
				((MonkeySpeed.m_vLastPos.x - MonkeySpeed.m_vCurrPos.x) * (MonkeySpeed.m_vLastPos.x - MonkeySpeed.m_vCurrPos.x) * 2.25 ) +
				((MonkeySpeed.m_vLastPos.y - MonkeySpeed.m_vCurrPos.y) * (MonkeySpeed.m_vLastPos.y - MonkeySpeed.m_vCurrPos.y)));
		
		MonkeySpeed.m_fSpeedDist = MonkeySpeed.m_fSpeedDist + dist;
		if (MonkeySpeed.m_iDeltaTime >= .5) then

			-- The map coords seem to be a different scale in different zones. Figure out which zone we're in
			local zonenum;
			local zonename;
			local contnum;
			local baserate;

			zonenum = GetCurrentMapZone();
			zonename = GetZoneText();
			

			if (zonenum ~= 0) then
				contnum = GetCurrentMapContinent();
				--f,h,w = GetMapInfo();


				if (MonkeySpeed.m_bCalibrate == true) then
					-- recalibrate this zone, the user should know this should be done when running at 100%
					if (contnum == 2) then
						MonkeySpeedConfig.m_ZoneBaseline2[zonenum].rate = MonkeySpeed.m_fSpeedDist / MonkeySpeed.m_iDeltaTime;
					else
						MonkeySpeedConfig.m_ZoneBaseline1[zonenum].rate = MonkeySpeed.m_fSpeedDist / MonkeySpeed.m_iDeltaTime;
					end

					-- done calibrating
					MonkeySpeed.m_bCalibrate = false;
				end


				if (contnum == 2) then
					baserate = MonkeySpeedConfig.m_ZoneBaseline2[zonenum].rate;
				else
					baserate = MonkeySpeedConfig.m_ZoneBaseline1[zonenum].rate;
				end

				if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDebugMode == true) then
					-- Debug code for figuring out new zone rates

					if (DEFAULT_CHAT_FRAME) then
						if (dist ~= 0) then
							DEFAULT_CHAT_FRAME:AddMessage(format("ZoneBaseline"..contnum.."  zid="..zonenum.."  rate=%.5f", 
								(MonkeySpeed.m_fSpeedDist / MonkeySpeed.m_iDeltaTime)));
						end
					end
				end
				
			else
				-- special zone

				--f,h,w = GetMapInfo();

				if (MonkeySpeed.m_bCalibrate == true) then
					-- recalibrate this zone, the user should know this should be done when running at 100%
					MonkeySpeedConfig.m_SpecialZoneBaseline[zonename] = MonkeySpeed.m_fSpeedDist / MonkeySpeed.m_iDeltaTime;

					-- done calibrating
					MonkeySpeed.m_bCalibrate = false;
				end

				baserate = MonkeySpeedConfig.m_SpecialZoneBaseline[zonename];

				if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDebugMode == true) then
					-- Debug code for figuring out new zone rates

					if (DEFAULT_CHAT_FRAME) then
						if (dist ~= 0) then
							DEFAULT_CHAT_FRAME:AddMessage(format("SpecialZoneBaseline  name=" .. zonename .. "  rate=%.5f",
								(MonkeySpeed.m_fSpeedDist / MonkeySpeed.m_iDeltaTime)));
						end
					end
				end
			end


			if (baserate ~= nil and baserate ~= 0) then

				MonkeySpeed.m_fSpeed = MonkeySpeed_Round(((MonkeySpeed.m_fSpeedDist / MonkeySpeed.m_iDeltaTime) / baserate) * 100);
	
				MonkeySpeed.m_fSpeedDist = 0.0;
				MonkeySpeed.m_iDeltaTime = 0.0;
	
				if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayPercent) then
					-- Set the text for the speedometer
					MonkeySpeedText:SetText(format("%d%%", MonkeySpeed.m_fSpeed));
				end
	
				if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayBar) then
					-- Set the colour of the bar
					if (MonkeySpeed.m_fSpeed == 0.0) then
						MonkeySpeedBar:SetVertexColor(1, 0, 0);
					elseif (MonkeySpeed.m_fSpeed < 100.0) then
						MonkeySpeedBar:SetVertexColor(1, 0.25, 0);
					elseif (MonkeySpeed.m_fSpeed == 100.0) then
						MonkeySpeedBar:SetVertexColor(1, 0.5, 0);
					elseif ((MonkeySpeed.m_fSpeed > 100.0) and (MonkeySpeed.m_fSpeed < 140.0)) then
						MonkeySpeedBar:SetVertexColor(0, 1, 0);
					elseif ((MonkeySpeed.m_fSpeed >= 140.0) and (MonkeySpeed.m_fSpeed < 200.0)) then
						MonkeySpeedBar:SetVertexColor(1, 0, 1);
					elseif ((MonkeySpeed.m_fSpeed >= 200.0) and (MonkeySpeed.m_fSpeed < 550.0)) then
						MonkeySpeedBar:SetVertexColor(0.5, 0, 1);
					elseif (MonkeySpeed.m_fSpeed >= 550.0) then
						MonkeySpeedBar:SetVertexColor(0, 0, 1);
					end
				end
			else
				if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayPercent) then
					-- Set the text for the speedometer
					MonkeySpeedText:SetText("???%");
				end
	
				if (MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bDisplayBar) then
					-- Set the colour of the bar
					MonkeySpeedBar:SetVertexColor(0, 0, 0);
				end
			end
		end

		MonkeySpeed.m_vLastPos.x = MonkeySpeed.m_vCurrPos.x;
		MonkeySpeed.m_vLastPos.y = MonkeySpeed.m_vCurrPos.y;
		MonkeySpeed.m_vLastPos.z = MonkeySpeed.m_vCurrPos.z;
	end
end

-- when the mouse goes over the main frame, this gets called
function MonkeySpeed_OnEnter()
	-- put the tool tip in the default position
	GameTooltip_SetDefaultAnchor(GameTooltip, this);
	
	-- set the tool tip text
	GameTooltip:SetText(MONKEYSPEED_TITLE_VERSION, MONKEYLIB_TITLE_COLOUR.r, MONKEYLIB_TITLE_COLOUR.g, MONKEYLIB_TITLE_COLOUR.b, 1);
	GameTooltip:AddLine(MONKEYSPEED_DESCRIPTION, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b, 1);
	GameTooltip:Show();
end

function MonkeySpeed_OnMouseDown(arg1)
	-- if not loaded yet then get out
	if (MonkeySpeed.m_bLoaded == false) then
		return;
	end
	
	if (arg1 == "LeftButton" and MonkeySpeedConfig[MonkeySpeed.m_strPlayer].m_bLocked == false) then
		MonkeySpeedFrame:StartMoving();
	end
	
	-- right button on the title or frame opens up the MonkeyBuddy, if it's there
	if (arg1 == "RightButton") then
		if (MonkeyBuddyFrame ~= nil) then
			ShowUIPanel(MonkeyBuddyFrame);
			
			-- make MonkeyBuddy show the MonkeySpeed config
			MonkeyBuddySpeedTab_OnClick();
		end
	end
end

function MonkeySpeed_OnMouseUp(arg1)
	-- if not loaded yet then get out
	if (MonkeySpeed.m_bLoaded == false) then
		return;
	end
	
	if (arg1 == "LeftButton") then
		MonkeySpeedFrame:StopMovingOrSizing();
	end
end

function MonkeySpeed_ParsePosition(position)
	local x, y, z;
	local iStart, iEnd;

	iStart, iEnd, x, y = string.find(position, "^(.-), (.-)$");

	if( x ) then
		return x + 0.0, y + 0.0;
	end
	return nil, nil;
end

function MonkeySpeed_Round(x)
	if(x - floor(x) > 0.5) then
		x = x + 0.5;
	end
	return floor(x);
end
