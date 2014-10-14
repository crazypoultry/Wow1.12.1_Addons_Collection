--[[
	- VERSION: 1.5.2
	
	- WonderRep: Adds all sorts of functionality for reputation changes!

]]

------------
-- Global Vars, and strings
------------
	SECONDSABBR = "s";
	MINUTESABBR = "m";
	HOURSABBR = "h";
	DAYSABBR = "d";
	
WRep = {
	defaultframe = "ChatFrame1",
	Units = {
	[1] = "Hated",
	[2] = "Hostile",
	[3] = "Unfriendly",
	[4] = "Neutral",
	[5] = "Friendly",
	[6] = "Honored",
	[7] = "Revered",
	[8] = "Exalted",
	[9] = "Max Exalted",
	};
	Color = {
	a = 1,
	b = 1,
	c = 0,
	HEX = "ffff00";
	id = 4;
	};
	AmountGainedLevel = 10,
	AmountGainedHold = 0,
	SessionTime = 0,
	TimeSave = 0,
};

------------
-- Load Function
------------
function WonderRep_OnLoad()
	-- Register the game events neccesary for the addon
	this:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("WORLD_MAP_UPDATE");

	-- Register our slash command
	SLASH_WONDERREP1 = "/wonderrep";
	SLASH_WONDERREP2 = "/wrep";
	SlashCmdList["WONDERREP"] = function(msg)
		WonderRep(msg);
	end
	
	-- Printing Message in Chat Frame
	if( DEFAULT_CHAT_FRAME ) then
		ChatFrame1:AddMessage("WonderRep Loaded! Version: 1.5.2", 1 , 1, 0);
	end
end

------------
-- Event Functions
------------
function WonderRep_OnEvent()
--	local PatternText = "(%a+) reputation with (%a+) (%a+) (%a+)";
	local RepCheck = "empty";
	local RepKilledMessage = "empty";
	local RepIndex = 0;
	local GainLoss = "empty";
	local HasIndexStart = 0;
	local HasIndexStop = 0;
	local Repnamename = "ahh";
	local name = "empty";
		
	if( event == "VARIABLES_LOADED" ) then
		Wrl = {};
		if ( not Wr_version ) then
			Wr_version = 150;
		end
		
		if ( not Wr_save ) then
			Wr_save = {
				AnnounceLeft = true,
				RepChange = true,
				ChangeBar = true,
				frame = true,
				ATimeLeft = true,
				colora = 1,
				colorb = 1,
				colorc = 0,
				colorid = 4;
				HEX = "ffff00",
				AmountGainedLevel = 1,
				ChatFrame1:AddMessage("NEW LOAD, default values set!", 1 , 1, 0);
			};
		end
		
		if (Wr_version ~= 150) then
			Wr_save.ATimeLeft = true;	
			Wr_version = 150;
		end
				
		if (Wr_save.frame) then 
			WRep.frame = getglobal("ChatFrame1");
		else
			WRep.frame = getglobal("ChatFrame2");
		end
		if (not WRep.frame) then 
			WRep.frame = getglobal(WRep.defaultframe);
			Wr_save.frame = true;
		end
		WRep.Color.a = Wr_save.colora;
		WRep.Color.b = Wr_save.colorb;
		WRep.Color.c = Wr_save.colorc;
		WRep.Color.HEX = Wr_save.HEX;
		WRep.AmountGainedLevel = Wr_save.AmountGainedLevel;
		WRep.ChangeBar = Wr_save.ChangeBar;
		
		Wr_Status();
	end
	
	-- Event fired when the player gets, or loses, rep in the chat frame
	if( event == "CHAT_MSG_COMBAT_FACTION_CHANGE") then
		local RepError = 214;
		local RepError2 = 214;
		-- This is set to hopefully stop an error when Reputation LEVEL changes, havn't tested
		RepError, RepError2 = string.find(arg1, "Your");
		local z = 0;
		
		while (z < 50) do
			local RepStand = 0;
			local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, isWatched = GetFactionInfo(z)
			if (name and not isHeader) then
				if (not Wrl[name] ) then
					Wrl[name] = {
						gained = 0,
						};
				end
			end
			z = z+1;
		end
		
		if (RepError ~= nil) then	
			-- Check to see if the reputation is gained or lost, if lost quits
			for GainLoss in string.gfind(arg1, "decreased") do
				return;
			end
			-- This code first finds where 'has' is in the string then,
			-- Gets the Substring (rep name) between With ... Has
			HasIndexStart, HasIndexStop = string.find(arg1, 'reputation');
			RepKilledMessage = string.sub(arg1, 6, HasIndexStart - 2);	
		-- Using the string we just made, sending to Match function
			RepIndex = WonderRep_GetRepMatch(RepKilledMessage);
		
		-- Changes Rep bar to the rep we matched above
			if (RepIndex ~= nil) then
				name, index, minD, maxD, current = GetWatchedFactionInfo();
				name1, description1, standingId1, bottomValue1, topValue1, earnedValue1, atWarWith1, canToggleAtWar1, isHeader1, isCollapsed1, isWatched1 = GetFactionInfo(RepIndex);
--				if ( standingId1 == 8 ) then
--					return;
--				end
				
				if (not isHeader1) then
					if ( RepKilledMessage ~= name) then
						WRep.AmountGainedHold = 0;
						if ( Wr_save.ChangeBar == true) then
							SetWatchedFactionIndex(RepIndex);
							if (Wr_save.RepChange == true) then
								WRep.frame:AddMessage("WonderRep: Reputation Bar changed to: "..RepKilledMessage..".", WRep.Color.a, WRep.Color.b, WRep.Color.c);
							end
						end
					end
					for AmountGainHold in string.gfind(arg1, "%d+")	do
						AmountGainHold2 = AmountGainHold;
					end
					local RepLeftToLevel = topValue1 - earnedValue1;
					local KillsToNext = RepLeftToLevel / AmountGainHold2;
					Wrl[name1].gained = Wrl[name1].gained + AmountGainHold2;
					WRep.AmountGainedHold = WRep.AmountGainedHold + AmountGainHold2;
					if ( WRep.AmountGainedHold >= WRep.AmountGainedLevel ) then
						if (Wr_save.AnnounceLeft == true and Wr_save.ATimeLeft == true) then
							local RepLeftToLevel = topValue1 - earnedValue1;
							local hold = standingId1 + 1;
							HoldRepGained = Wrl[name1].gained;
							EstimatedTimeTolevel = RepLeftToLevel / (HoldRepGained / WRep.SessionTime);
							KillsToNext = floor(KillsToNext + .5);
							if ( hold <= 8 ) then
								RepNextLevelName = WRep.Units[hold];
							else
								RepNextLevelName = "";
							end
							WRep.frame:AddMessage("WonderRep: "..RepLeftToLevel.." reputation with "..RepKilledMessage.." needed for "..RepNextLevelName..". ("..KillsToNext.." reputation gains left) A total of "..HoldRepGained.." reputation gained this session. "..WonderRep_TimeText(EstimatedTimeTolevel).." estimated time to "..RepNextLevelName..".", WRep.Color.a , WRep.Color.b, WRep.Color.c);
						elseif (Wr_save.AnnounceLeft == true) then
							local RepLeftToLevel = topValue1 - earnedValue1;
							local hold = standingId1 + 1;
							if ( hold <= 8 ) then
								RepNextLevelName = WRep.Units[hold];
							else
								RepNextLevelName = "";
							end
							WRep.frame:AddMessage("WonderRep: "..RepLeftToLevel.." reputation with "..RepKilledMessage.." needed for "..RepNextLevelName..". ("..KillsToNext.." reputation gains left)", WRep.Color.a , WRep.Color.b, WRep.Color.c);
						elseif (Wr_save.ATimeLeft == true) then
							local RepLeftToLevel = topValue1 - earnedValue1;
							local hold = standingId1 + 1;
							if ( hold <= 8 ) then
								RepNextLevelName = WRep.Units[hold];
							else
								RepNextLevelName = "";
							end
							HoldRepGained = Wrl[name1].gained;
							EstimatedTimeTolevel = RepLeftToLevel / (HoldRepGained / WRep.SessionTime);
							WRep.frame:AddMessage("WonderRep: "..HoldRepGained.." reputation with "..RepKilledMessage.." gained this session. "..WonderRep_TimeText(EstimatedTimeTolevel).." estimated time to "..RepNextLevelName..".", WRep.Color.a , WRep.Color.b, WRep.Color.c);
						end
					end
					if ( WRep.AmountGainedHold >= WRep.AmountGainedLevel ) then
						WRep.AmountGainedHold = 0;
					end
				end
			else
				WRep.frame:AddMessage("Brand new faction detected!", WRep.Color.a, WRep.Color.b, WRep.Color.c);
			end
		end
	end

	-- Event fired when player finish loading the game (zone, login, reloadui)
	-- We use this event to check where the player is using GetCurrentMapContinent(),
	-- we can tell if the player if in a BG, if they are we find out which
	if ( event == "PLAYER_ENTERING_WORLD") then
		local BattleGroundName = "empty";
		local x = 0;
		local RepIndex = 0;
		local name = "empty";
		local InstanceName = "empty";
		-- Variable to hold if player is Horde or Alliance
		local HordeOrAlliance = UnitFactionGroup("player");
		SetMapToCurrentZone()
		x = GetCurrentMapContinent();
--		DEFAULT_CHAT_FRAME:AddMessage(x.." Zone number");
		if (x ~= -1) then
--			this:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
		end
		local z = 0;
				
		if (x == -1) then
--			this:UnregisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
			for i=1, MAX_BATTLEFIELD_QUEUES do
				status, mapName, instanceID = GetBattlefieldStatus(i);	
				if ( instanceID ~= 0 ) then
--					DEFAULT_CHAT_FRAME:AddMessage(mapName.." mapName");
					if ( mapName == "Arathi Basin") then
						if ( HordeOrAlliance == "Horde") then
							RepKilledMessage = "The Defilers";
							RepIndex = WonderRep_GetRepMatch(RepKilledMessage);
							name1, description1, standingId1, bottomValue1, topValue1, earnedValue1, atWarWith1, canToggleAtWar1, isHeader1, isCollapsed1, isWatched1 = GetFactionInfo(RepIndex);
							if ( standingId1 == 8 ) then
								return;
							end
							name, index, minD, maxD, current = GetWatchedFactionInfo();
							if ( RepKilledMessage ~= name) then
								SetWatchedFactionIndex(RepIndex);
								WRep.frame:AddMessage("WonderRep: Reputation Bar changed to: "..RepKilledMessage..".", WRep.Color.a, WRep.Color.b, WRep.Color.c);
							end
						else
							RepKilledMessage = "The League of Arathor";
							RepIndex = WonderRep_GetRepMatch(RepKilledMessage);
							name1, description1, standingId1, bottomValue1, topValue1, earnedValue1, atWarWith1, canToggleAtWar1, isHeader1, isCollapsed1, isWatched1 = GetFactionInfo(RepIndex);
							if ( standingId1 == 8 ) then
								return;
							end
							name, index, minD, maxD, current = GetWatchedFactionInfo();
							if ( RepKilledMessage ~= name) then
								SetWatchedFactionIndex(RepIndex);
								WRep.frame:AddMessage("WonderRep: Reputation Bar changed to: "..RepKilledMessage..".", WRep.Color.a, WRep.Color.b, WRep.Color.c);
							end						
						end
					elseif ( mapName == "Warsong Gulch") then
						if ( HordeOrAlliance == "Horde") then
							RepKilledMessage = "Warsong Outriders";
							RepIndex = WonderRep_GetRepMatch(RepKilledMessage);
							name1, description1, standingId1, bottomValue1, topValue1, earnedValue1, atWarWith1, canToggleAtWar1, isHeader1, isCollapsed1, isWatched1 = GetFactionInfo(RepIndex);
							if ( standingId1 == 8 ) then
								return;
							end
							name, index, minD, maxD, current = GetWatchedFactionInfo();
							if ( RepKilledMessage ~= name) then
								SetWatchedFactionIndex(RepIndex);
								WRep.frame:AddMessage("WonderRep: Reputation Bar changed to: "..RepKilledMessage..".", WRep.Color.a, WRep.Color.b, WRep.Color.c);
							end
						else
							RepKilledMessage = "Silverwing Sentinels";
							RepIndex = WonderRep_GetRepMatch(RepKilledMessage);
							name1, description1, standingId1, bottomValue1, topValue1, earnedValue1, atWarWith1, canToggleAtWar1, isHeader1, isCollapsed1, isWatched1 = GetFactionInfo(RepIndex);
							if ( standingId1 == 8 ) then
								return;
							end
							name, index, minD, maxD, current = GetWatchedFactionInfo();
							if ( RepKilledMessage ~= name) then
								SetWatchedFactionIndex(RepIndex);
								WRep.frame:AddMessage("WonderRep: Reputation Bar changed to: "..RepKilledMessage..".", WRep.Color.a, WRep.Color.b, WRep.Color.c);
							end						
						end
					elseif ( mapName == "Alterac Valley") then
						if ( HordeOrAlliance == "Horde") then
							RepKilledMessage = "Frostwolf Clan";
							RepIndex, RepStand = WonderRep_GetRepMatch(RepKilledMessage);
							if ( RepStand == 8 ) then
								WRep.frame:AddMessage("WonderRep: "..RepKilledMessage.." faction is Exalted! Switching to Orgrimmar faction.", WRep.Color.a, WRep.Color.b, WRep.Color.c);
								RepKilledMessage = "Orgrimmar";
								RepIndex = WonderRep_GetRepMatch(RepKilledMessage);
							end
							name, index, minD, maxD, current = GetWatchedFactionInfo();
							if ( RepKilledMessage ~= name) then
									SetWatchedFactionIndex(RepIndex);
									WRep.frame:AddMessage("WonderRep: Reputation Bar changed to: "..RepKilledMessage..".", WRep.Color.a, WRep.Color.b, WRep.Color.c);
							end
						else
							RepKilledMessage = "Stormpike Guard";
							RepIndex, RepStand = WonderRep_GetRepMatch(RepKilledMessage);
							if ( RepStand == 8 ) then
								WRep.frame:AddMessage("WonderRep "..RepKilledMessage.." faction is Exalted! Switching to Ironforge faction.", WRep.Color.a, WRep.Color.b, WRep.Color.c);
								RepKilledMessage = "Ironforge";
								RepIndex = WonderRep_GetRepMatch(RepKilledMessage);
							end
							name, index, minD, maxD, current = GetWatchedFactionInfo();
							if ( RepKilledMessage ~= name) then
									SetWatchedFactionIndex(RepIndex);
									WRep.frame:AddMessage("WonderRep: Reputation Bar changed to: "..RepKilledMessage..".", WRep.Color.a, WRep.Color.b, WRep.Color.c);
							end
						end
					else
						WRep.frame:AddMessage("We have a problem - 1");
					end
				end
			end			
		end
	end
	if( event == "WORLD_MAP_UPDATE" ) then
		x,y = GetPlayerMapPosition("player");
		if ( x and y == 0 ) then
			InstanceName = GetRealZoneText();
			if (InstanceName == "Zul'Gurub") then
				RepKilledMessage = "Zandalar Tribe";
				RepIndex = WonderRep_GetRepMatch(RepKilledMessage);
				name1, description1, standingId1, bottomValue1, topValue1, earnedValue1, atWarWith1, canToggleAtWar1, isHeader1, isCollapsed1, isWatched1 = GetFactionInfo(RepIndex);
				if ( standingId1 == 8 ) then
					return;
				end
				name, index, minD, maxD, current = GetWatchedFactionInfo();
				if ( RepKilledMessage ~= name) then
					SetWatchedFactionIndex(RepIndex);
					WRep.frame:AddMessage("WonderRep: Reputation Bar changed to: "..RepKilledMessage..".", WRep.Color.a, WRep.Color.b, WRep.Color.c);
				end	
			end
			if (InstanceName == "Stratholme") then
				RepKilledMessage = "Argent Dawn";
				RepIndex = WonderRep_GetRepMatch(RepKilledMessage);
				name1, description1, standingId1, bottomValue1, topValue1, earnedValue1, atWarWith1, canToggleAtWar1, isHeader1, isCollapsed1, isWatched1 = GetFactionInfo(RepIndex);
				if ( standingId1 == 8 ) then
					return;
				end
				name, index, minD, maxD, current = GetWatchedFactionInfo();
				if ( RepKilledMessage ~= name) then
					SetWatchedFactionIndex(RepIndex);
					WRep.frame:AddMessage("WonderRep: Reputation Bar changed to: "..RepKilledMessage..".", WRep.Color.a, WRep.Color.b, WRep.Color.c);
				end	
			end
			if (InstanceName == "Naxxramas") then
				RepKilledMessage = "Argent Dawn";
				RepIndex = WonderRep_GetRepMatch(RepKilledMessage);
				name1, description1, standingId1, bottomValue1, topValue1, earnedValue1, atWarWith1, canToggleAtWar1, isHeader1, isCollapsed1, isWatched1 = GetFactionInfo(RepIndex);
				if ( standingId1 == 8 ) then
					return;
				end
				name, index, minD, maxD, current = GetWatchedFactionInfo();
				if ( RepKilledMessage ~= name) then
					SetWatchedFactionIndex(RepIndex);
					WRep.frame:AddMessage("WonderRep: Reputation Bar changed to: "..RepKilledMessage..".", WRep.Color.a, WRep.Color.b, WRep.Color.c);
				end	
			end
		end
	end
end

------------
-- Reputation pharsing and math function
------------
function WonderRep_GetRepMatch(RepKilledMessage)
	local x = 0;
	local RepCheck = "empty";
	
	while (x < 50) do
		local RepStand = 0;
		name, RepDisc, RepStand = GetFactionInfo(x);
		if (name == RepKilledMessage) then
			return x, RepStand
		end
		x = x+1;
	end
end

function WonderRep_OnUpdate(elapsed)
	WRep.TimeSave = WRep.TimeSave + elapsed;
	if (WRep.TimeSave > 0.5) then
		WRep.SessionTime = WRep.SessionTime + WRep.TimeSave;
		WRep.TimeSave = 0;
	end
end

------------
-- Printing Functions
------------
function Wr_Status()
	WRep.frame:AddMessage("WonderRep Status:", WRep.Color.a, WRep.Color.b, WRep.Color.c);

	if ( Wr_save.RepChange == true ) then
		WRep.frame:AddMessage("WonderRep |cff"..WRep.Color.HEX.."will|r announce when reputation bar is changed.");
	else
		WRep.frame:AddMessage("WonderRep |cff"..WRep.Color.HEX.."will not|r announce when reputation bar is changed.");
	end
	if ( Wr_save.ChangeBar == true ) then
		WRep.frame:AddMessage("WonderRep |cff"..WRep.Color.HEX.."will|r automatically change the reputation bar.");
	else
		WRep.frame:AddMessage("WonderRep |cff"..WRep.Color.HEX.."will not|r automatically change the reputation bar.");
	end		
	if ( Wr_save.AnnounceLeft == true ) then
		WRep.frame:AddMessage("WonderRep |cff"..WRep.Color.HEX.."will|r announce reputation left to next level every |cff"..WRep.Color.HEX..""..WRep.AmountGainedLevel.."|r reputation");
	else
		WRep.frame:AddMessage("WonderRep |cff"..WRep.Color.HEX.."will not|r announce reputation left to next level");
	end
	if ( Wr_save.ATimeLeft == true ) then
		WRep.frame:AddMessage("WonderRep |cff"..WRep.Color.HEX.."will|r announce estimated time left to next level every |cff"..WRep.Color.HEX..""..WRep.AmountGainedLevel.."|r reputation");
	else
		WRep.frame:AddMessage("WonderRep |cff"..WRep.Color.HEX.."will not|r announce estimated time left to next level");
	end
	if ( Wr_save.frame == true ) then
		WRep.frame:AddMessage("WonderRep will show all messages in the |cff"..WRep.Color.HEX.."Chat Frame|r");
	else
		WRep.frame:AddMessage("WonderRep will show all messages in the |cff"..WRep.Color.HEX.."Combat Log|r");
	end
end

function WonderRep_PrintHelp()
	WRep.frame:AddMessage(" ");
	WRep.frame:AddMessage("|cff"..WRep.Color.HEX.."-----------------------------------|r");
	WRep.frame:AddMessage("|cff"..WRep.Color.HEX.."WonderRep commands help:|r");
	WRep.frame:AddMessage("Use |cff"..WRep.Color.HEX.."/wonderrep <command>|r or |cff"..WRep.Color.HEX.."/wrep <command>|r to perform the following commands");
	WRep.frame:AddMessage("|cff"..WRep.Color.HEX.."help|r -- you are viewing it!");
	WRep.frame:AddMessage("|cff"..WRep.Color.HEX.."status|r -- shows your current settings");
	WRep.frame:AddMessage("|cff"..WRep.Color.HEX.."announce|r -- toggles whether to display reputation to next level message");
	WRep.frame:AddMessage("|cff"..WRep.Color.HEX.."autobar|r -- toggles whether to automatically change the reputation bar or not");
	WRep.frame:AddMessage("|cff"..WRep.Color.HEX.."barchange|r -- toggles whether to display a message when the reputation bar is changed");
	WRep.frame:AddMessage("|cff"..WRep.Color.HEX.."chat|r -- Changes where WonderRep messages are displayed to the Chat Frame");
	WRep.frame:AddMessage("|cff"..WRep.Color.HEX.."combatlog|r -- Changes where WonderRep messages are displayed to the Combat Log");
	WRep.frame:AddMessage("|cff"..WRep.Color.HEX.."interval <##>|r -- Changes how often WonderRep will announce how much reputation untill the next level. If announce is turned off there is no affect. Available intervals: 1, 10, 50, 100, 200, 500. (EX: /wrep interval 50)");
	WRep.frame:AddMessage("|cff"..WRep.Color.HEX.."color <color>|r -- change the color used by WonderRep messages. Colors available: red, green, emerald, yellow, orange, blue, purple, cyan. (EX: /wrep color red)");
	WRep.frame:AddMessage("|cff"..WRep.Color.HEX.."-----------------------------------");
	WRep.frame:AddMessage(" ");
end

function WonderRep_TimeText(s)
	local days = floor(s/24/60/60); s = mod(s, 24*60*60);
	local hours = floor(s/60/60); s = mod(s, 60*60);
	local minutes = floor(s/60); s = mod(s, 60);
	local seconds = s;
	
	local timeText = "";
	if (days ~= 0) then
		timeText = timeText..format("%d"..DAYSABBR.." ", days);
	end
	if (days ~= 0 or hours ~= 0) then
		timeText = timeText..format("%d"..HOURSABBR.." ", hours);
	end
	if (days ~= 0 or hours ~= 0 or minutes ~= 0) then
		timeText = timeText..format("%d"..MINUTESABBR.." ", minutes);
	end	
	timeText = timeText..format("%d"..SECONDSABBR, seconds);
	
	return timeText;
end
------------
-- Slash Function
------------
function WonderRep(msg)
	if( msg ) then
		local command = string.lower(msg);
		if( command == "" ) then
			WonderRepOptions_Toggle();
		elseif( command == "help" ) then
			WonderRep_PrintHelp();
		elseif( command == "combatlog" ) then
			WRep.frame = getglobal("ChatFrame2");
			Wr_save.frame = false;
			Wr_Status();
		elseif( command == "chat" ) then
			WRep.frame = getglobal("ChatFrame1");
			Wr_save.frame = true;
			Wr_Status();
		elseif( command == "status" ) then
			Wr_Status();
		elseif( command == "announce" ) then
			if (Wr_save.AnnounceLeft == true) then
				Wr_save.AnnounceLeft = false;
			else
				Wr_save.AnnounceLeft = true;
			end
			Wr_Status();
		elseif( command == "barchange" ) then
			if (Wr_save.RepChange == true) then
				Wr_save.RepChange = false;
			else
				Wr_save.RepChange = true;
			end
			Wr_Status();
		elseif( command == "autobar" ) then
			if (Wr_save.ChangeBar == true) then
				Wr_save.ChangeBar = false;
			else
				Wr_save.ChangeBar = true;
			end
			Wr_Status();
		elseif( command == "interval 1" ) then
			WRep.AmountGainedLevel = 1;
			Wr_save.AmountGainedLevel = 1;
			Wr_Status();
		elseif( command == "interval 10" ) then
			WRep.AmountGainedLevel = 10;
			Wr_save.AmountGainedLevel = 10;
			Wr_Status();
		elseif( command == "interval 50" ) then
			WRep.AmountGainedLevel = 50;
			Wr_save.AmountGainedLevel = 50;
			Wr_Status();
		elseif( command == "interval 100" ) then
			WRep.AmountGainedLevel = 100;
			Wr_save.AmountGainedLevel = 100;
			Wr_Status();
		elseif( command == "interval 200" ) then
			WRep.AmountGainedLevel = 200;
			Wr_save.AmountGainedLevel = 200;
			Wr_Status();
		elseif( command == "interval 500" ) then
			WRep.AmountGainedLevel = 500;
			Wr_save.AmountGainedLevel = 500;
			Wr_Status();
		elseif( command == "color red") then
			WRep.Color.a = 1;
			WRep.Color.b = 0;
			WRep.Color.c = 0;
			WRep.Color.HEX = "ff0000";
			WRep.Color.id = 1;
			Wr_save.colorid = 1;
			Wr_save.colora = 1;
			Wr_save.colorb = 0;
			Wr_save.colorc = 0;
			Wr_save.HEX = "ff0000";	
			WRep.frame:AddMessage("WonderRep: Color Changed", WRep.Color.a, WRep.Color.b, WRep.Color.c);
		elseif( command == "color blue") then
			WRep.Color.a = 0;
			WRep.Color.b = 0;
			WRep.Color.c = 1;
			WRep.Color.HEX = "0000ff";
			WRep.Color.id = 6;
			Wr_save.colorid = 6;			
			Wr_save.colora = 0;
			Wr_save.colorb = 0;
			Wr_save.colorc = 1;
			Wr_save.HEX = "0000ff";	
			WRep.frame:AddMessage("WonderRep: Color Changed", WRep.Color.a, WRep.Color.b, WRep.Color.c);
		elseif( command == "color green") then
			WRep.Color.a = 0;
			WRep.Color.b = 1;
			WRep.Color.c = 0;
			WRep.Color.HEX = "00ff00";
			WRep.Color.id = 2;
			Wr_save.colorid = 2;
			Wr_save.colora = 0;
			Wr_save.colorb = 1;
			Wr_save.colorc = 0;
			Wr_save.HEX = "00ff00";	
			WRep.frame:AddMessage("WonderRep: Color Changed", WRep.Color.a, WRep.Color.b, WRep.Color.c);
		elseif( command == "color emerald") then
			WRep.Color.a = .3;
			WRep.Color.b = .8;
			WRep.Color.c = .5;
			WRep.Color.HEX = "50C878";
			WRep.Color.id = 3;
			Wr_save.colorid = 3;
			Wr_save.colora = .3;
			Wr_save.colorb = .8;
			Wr_save.colorc = .5;
			Wr_save.HEX = "50C878";
			WRep.frame:AddMessage("WonderRep: Color Changed", WRep.Color.a, WRep.Color.b, WRep.Color.c);
		elseif( command == "color yellow") then
			WRep.Color.a = 1;
			WRep.Color.b = 1;
			WRep.Color.c = 0;
			WRep.Color.HEX = "ffff00";
			WRep.Color.id = 4;
			Wr_save.colorid = 4;
			Wr_save.colora = 1;
			Wr_save.colorb = 1;
			Wr_save.colorc = 0;
			Wr_save.HEX = "ffff00";
			WRep.frame:AddMessage("WonderRep: Color Changed", WRep.Color.a, WRep.Color.b, WRep.Color.c);
		elseif( command == "color orange") then
			WRep.Color.a = 1;
			WRep.Color.b = .61;
			WRep.Color.c = 0;
			WRep.Color.HEX = "FFA500";
			WRep.Color.id = 5;
			Wr_save.colorid = 5;
			Wr_save.colora = 1;
			Wr_save.colorb = .61;
			Wr_save.colorc = 0;
			Wr_save.HEX = "FFA500";
			WRep.frame:AddMessage("WonderRep: Color Changed", WRep.Color.a, WRep.Color.b, WRep.Color.c);
		elseif( command == "color purple") then
			WRep.Color.a = .4;
			WRep.Color.b = 0;
			WRep.Color.c = .6;
			WRep.Color.HEX = "660099";
			WRep.Color.id = 7;
			Wr_save.colorid = 7;
			Wr_save.colora = .4;
			Wr_save.colorb = 0;
			Wr_save.colorc = .6;
			Wr_save.HEX = "660099";
			WRep.frame:AddMessage("WonderRep: Color Changed", WRep.Color.a, WRep.Color.b, WRep.Color.c);
		elseif( command == "color cyan") then
			WRep.Color.a = 0;
			WRep.Color.b = 1;
			WRep.Color.c = 1;
			WRep.Color.HEX = "00ffff";
			WRep.Color.id = 8;
			Wr_save.colorid = 8;
			Wr_save.colora = 0;
			Wr_save.colorb = 1;
			Wr_save.colorc = 1;
			Wr_save.HEX = "00ffff";
			WRep.frame:AddMessage("WonderRep: Color Changed", WRep.Color.a, WRep.Color.b, WRep.Color.c);
		end
	end
end