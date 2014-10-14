
function BGSoundAlerts_Comm_ChooseBGComm()

	if (GetRealZoneText() == "Warsong Gulch") then
		return "WSG_COMM";
	elseif (GetRealZoneText() == "Arathi Basin") then
		return "AB_COMM";
	elseif (GetRealZoneText() == "Alterac Valley") then
		if (UnitFactionGroup("player") == "Horde") then
			return "HORDE_AV_COMM";
		else
			return "ALLIANCE_AV_COMM";
		end
	end

end

-- This is the comm-list handlers file

BGSoundAlerts_SelectedCommButton = 1;			-- The button currently selected
BGSoundAlerts_MaxNumCommButtonsShown = 0;		-- The number of buttons shown

-- These are the comm-list values
-- Key is the key that needs to be pressed to run the comm
-- Text is the text to display on the buttons
-- Action is the type of action that the comm-list will run
-- Value is the value of the action; Not all actions take values
BGSoundAlertsCommList = { };

-- This commlist is just used as a test. :)
BGSoundAlertsCommList["FLAG_CAP"] = { };
BGSoundAlertsCommList["FLAG_CAP"][1] = { key = "A", text = "Good Job", action = "MSG_GROUP", value = "Good Job", condition = "GROUP"};
BGSoundAlertsCommList["FLAG_CAP"][2] = { key = "B", text = "Well done", action = "MSG_GROUP", value = "Well done", condition = "GROUP"};
BGSoundAlertsCommList["FLAG_CAP"][3] = { key = "ESCAPE", text = "[Hide]", action = "COMM_HIDE"};

BGSoundAlertsCommList["GROUP_COMM"] = { };
BGSoundAlertsCommList["GROUP_COMM"][1] = { key = "1", text = "Aid me", action = "MSG", value = "Aid Me", condition = "GROUP"};
BGSoundAlertsCommList["GROUP_COMM"][2] = { key = "2", text = "Help with target", action = "MSG_TARGET", value = "Help me attack", condition = "TARGET_ENEMY"};
BGSoundAlertsCommList["GROUP_COMM"][3] = { key = "3", text = "Gather at me", action = "MSG_ZONE", value = "Gather", condition = "GROUP"};
BGSoundAlertsCommList["GROUP_COMM"][4] = { key = "4", text = "Heal me", action = "MSG", value = "I require healing!", condition = "GROUP"};
BGSoundAlertsCommList["GROUP_COMM"][5] = { key = "5", text = "Target running away", action = "MSG", value = "%T is running away!", condition = "TARGET_ENEMY"};
BGSoundAlertsCommList["GROUP_COMM"][6] = { key = "6", text = "Incoming!", action = "MSG_ZONE", value = "Incoming to", condition = "GROUP"};
BGSoundAlertsCommList["GROUP_COMM"][7] = { key = "7", text = "Under Attack", action = "MSG_ZONE", value = "We are under attack at", condition = "GROUP"};
BGSoundAlertsCommList["GROUP_COMM"][8] = { key = "8", text = "Man down", action = "MSG", value = "Man down!", condition = "GROUP"};
BGSoundAlertsCommList["GROUP_COMM"][9] = { key = "9", text = "Charge!", action = "MSG", value = "CHARGE!", condition = "GROUP"};
BGSoundAlertsCommList["GROUP_COMM"][10] = { key = "0", text = "Zone OK", action = "MSG_ZONE", value = "All is calm at", condition = "GROUP"};
BGSoundAlertsCommList["GROUP_COMM"][11] = { key = "-", text = "AoE the flag", action = "MSG", value = "Send AoEs raining down on that flag!", condition = "GROUP"};
BGSoundAlertsCommList["GROUP_COMM"][12] = { key = "ESCAPE", text = "[Hide]", action = "COMM_HIDE"};

BGSoundAlertsCommList["WSG_COMM"] = { };
BGSoundAlertsCommList["WSG_COMM"][1] = { key = "1", text = "Inc Base", action = "MSG" ,value = "Incoming attack to our base!", condition = "GROUP" };
BGSoundAlertsCommList["WSG_COMM"][2] = { key = "2", text = "Inc Tunnel", action = "MSG" ,value = "Incoming attack from our tunnel!", condition = "GROUP" };
BGSoundAlertsCommList["WSG_COMM"][3] = { key = "3", text = "Inc Balcony", action = "MSG" ,value = "Incoming attack from our balcony!", condition = "GROUP" };
BGSoundAlertsCommList["WSG_COMM"][4] = { key = "4", text = "Flag Exiting Tunnel", action = "MSG", value = "Flag exiting from the tunnel!", condition = "GROUP" };
BGSoundAlertsCommList["WSG_COMM"][5] = { key = "5", text = "Flag Exiting Ramp", action = "MSG", value = "Flag exiting from the ramp!", condition = "GROUP" };
BGSoundAlertsCommList["WSG_COMM"][6] = { key = "6", text = "Flag Exiting GY", action = "MSG", value = "Flag exiting from the graveyard!", condition = "GROUP" };
BGSoundAlertsCommList["WSG_COMM"][7] = { key = "7", text = "Flag Safe", action = "MSG", value = "The flag is safe", condition = "GROUP" };
BGSoundAlertsCommList["WSG_COMM"][8] = { key = "8", text = "Flag Under Attack", action = "MSG", value = "The flag is under attack!", condition = "GROUP" };
BGSoundAlertsCommList["WSG_COMM"][9] = { key = "ESCAPE", text = "[Hide]", action = "COMM_HIDE" };

BGSoundAlertsCommList["AB_COMM"] = { };
BGSoundAlertsCommList["AB_COMM"][1] = { key = "1", text = "Inc Farm", action = "MSG", value = "Incoming attack to the farm", condition = "GROUP" };
BGSoundAlertsCommList["AB_COMM"][2] = { key = "2", text = "Inc Blacksmith", action = "MSG", value = "Incoming attack to the blacksmith", condition = "GROUP" };
BGSoundAlertsCommList["AB_COMM"][3] = { key = "3", text = "Inc Lumber Mill", action = "MSG", value = "Incoming attack to the lumber mill", condition = "GROUP" };
BGSoundAlertsCommList["AB_COMM"][4] = { key = "4", text = "Inc Gold Mine", action = "MSG", value = "Incoming attack to the gold mine", condition = "GROUP" };
BGSoundAlertsCommList["AB_COMM"][5] = { key = "5", text = "Inc Stables", action = "MSG", value = "Incoming attack to the stables", condition = "GROUP" };
BGSoundAlertsCommList["AB_COMM"][6] = { key = "6", text = "Farm Under Attack", action = "MSG", value = "The farm is under attack", condition = "GROUP" };
BGSoundAlertsCommList["AB_COMM"][7] = { key = "7", text = "Blacksmith Under Attack", action = "MSG", value = "The blacksmith is under attack", condition = "GROUP" };
BGSoundAlertsCommList["AB_COMM"][8] = { key = "8", text = "Lumber Mill Under Attack", action = "MSG", value = "The blacksmith is under attack", condition = "GROUP" };
BGSoundAlertsCommList["AB_COMM"][9] = { key = "9", text = "Gold Mine Under Attack", action = "MSG", value = "The gold mine is under attack", condition = "GROUP" };
BGSoundAlertsCommList["AB_COMM"][10] = { key = "0", text = "Stables Under Attack", action = "MSG", value = "The stables is under attack", condition = "GROUP" };
BGSoundAlertsCommList["AB_COMM"][11] = { key = "ESCAPE", text = "[Hide]", action ="COMM_HIDE", value = "The stables is under attack", condition = "GROUP" };

BGSoundAlertsCommList["ALLIANCE_AV_COMM"] = { };
BGSoundAlertsCommList["ALLIANCE_AV_COMM"][1] = { key = "1", text = "Inc Stonehearth", action = "MSG", value = "Incoming attack to the Stonehearth bunker", condition = "GROUP" };
BGSoundAlertsCommList["ALLIANCE_AV_COMM"][2] = { key = "2", text = "Inc Stonehearth GY", action = "MSG", value = "Incoming attack to the Stonehearth graveyard", condition = "GROUP" };
BGSoundAlertsCommList["ALLIANCE_AV_COMM"][3] = { key = "3", text = "Inc Icewing", action = "MSG", value = "Incoming attack to the Icewing bunker", condition = "GROUP" };
BGSoundAlertsCommList["ALLIANCE_AV_COMM"][4] = { key = "4", text = "Inc North Bunker", action = "MSG", value = "Incoming attack to the Dun Baldar North bunker", condition = "GROUP" };
BGSoundAlertsCommList["ALLIANCE_AV_COMM"][5] = { key = "5", text = "Inc South Bunker", action = "MSG", value = "Incoming attack to the Dun Baldar South bunker", condition = "GROUP" };
BGSoundAlertsCommList["ALLIANCE_AV_COMM"][6] = { key = "6", text = "Inc Stormpike GY", action = "MSG", value = "Incoming attack to the Stormpike graveyard", condition = "GROUP" };
BGSoundAlertsCommList["ALLIANCE_AV_COMM"][7] = { key = "7", text = "Inc Aid Station", action = "MSG", value = "Incoming attack to the Stormpike Aid Station", condition = "GROUP" };
BGSoundAlertsCommList["ALLIANCE_AV_COMM"][8] = { key = "8", text = "Inc Iceblood GY", action = "MSG", value = "Incoming attack to the Iceblood graveyard", condition = "GROUP" };
BGSoundAlertsCommList["ALLIANCE_AV_COMM"][9] = { key = "9", text = "Inc Frostwolf GY", action = "MSG", value = "Incoming attack to the Frostwolf graveyard", condition = "GROUP" };
BGSoundAlertsCommList["ALLIANCE_AV_COMM"][10] = { key = "0", text = "Inc Relief Hut", action = "MSG", value = "Incoming attack to the Frostwolf Relief Hut", condition = "GROUP" };
BGSoundAlertsCommList["ALLIANCE_AV_COMM"][11] = { key = "-", text = "Inc Snowfall GY", action = "MSG", value = "Incoming attack to the Snowfall graveyard", condition = "GROUP" };
BGSoundAlertsCommList["ALLIANCE_AV_COMM"][12] = { key = "ESCAPE", text = "[Hide]", action = "COMM_HIDE" };

BGSoundAlertsCommList["HORDE_AV_COMM"] = { };
BGSoundAlertsCommList["HORDE_AV_COMM"][1] = { key = "1", text = "Inc Iceblood", action = "MSG", value = "Incoming attack to the Iceblood Tower", condition = "GROUP" };
BGSoundAlertsCommList["HORDE_AV_COMM"][2] = { key = "2", text = "Inc Iceblood GY", action = "MSG", value = "Incoming attack to the Iceblood graveyard", condition = "GROUP" };
BGSoundAlertsCommList["HORDE_AV_COMM"][3] = { key = "3", text = "Inc Tower Point", action = "MSG", value = "Incoming attack to Tower Point", condition = "GROUP" };
BGSoundAlertsCommList["HORDE_AV_COMM"][4] = { key = "4", text = "Inc West Tower", action = "MSG", value = "Incoming attack to the West Frostwolf Tower", condition = "GROUP" };
BGSoundAlertsCommList["HORDE_AV_COMM"][5] = { key = "5", text = "Inc East Tower", action = "MSG", value = "Incoming attack to the East Frostwolf Tower", condition = "GROUP" };
BGSoundAlertsCommList["HORDE_AV_COMM"][6] = { key = "6", text = "Inc Frostwolf GY", action = "MSG", value = "Incoming attack to the Frostwolf graveyard", condition = "GROUP" };
BGSoundAlertsCommList["HORDE_AV_COMM"][7] = { key = "7", text = "Inc Relief Hut", action = "MSG", value = "Incoming attack to the Frostwolf Relief Hut", condition = "GROUP" };
BGSoundAlertsCommList["HORDE_AV_COMM"][8] = { key = "8", text = "Inc Stonehearth GY", action = "MSG", value = "Incoming attack to the Stonehearth graveyard", condition = "GROUP" };
BGSoundAlertsCommList["HORDE_AV_COMM"][9] = { key = "9", text = "Inc Stormpike GY", action = "MSG", value = "Incoming attack to the Stormpike graveyard", condition = "GROUP" };
BGSoundAlertsCommList["HORDE_AV_COMM"][10] = { key = "0", text = "Inc Aid Station", action = "MSG", value = "Incoming attack to the Stormpike Aid Station", condition = "GROUP" };
BGSoundAlertsCommList["HORDE_AV_COMM"][11] = { key = "-", text = "Inc Snowfall GY", action = "MSG", value = "Incoming attack to the Snowfall graveyard", condition = "GROUP" };
BGSoundAlertsCommList["HORDE_AV_COMM"][12] = { key = "ESCAPE", text = "[Hide]", action = "COMM_HIDE" };

BGSoundAlertsCommList["LEADER_COMM"] = { };
BGSoundAlertsCommList["LEADER_COMM"][1] = { key = "1", text = "Move In", action = "MSG", value = "Move in", condition = "LEADER"};
BGSoundAlertsCommList["LEADER_COMM"][2] = { key = "2", text = "Open Fire", action = "MSG", value = "Open fire!", condition = "LEADER"};
BGSoundAlertsCommList["LEADER_COMM"][3] = { key = "3", text = "Defend Zone", action = "MSG_ZONE", value = "Defend", condition = "LEADER"};
BGSoundAlertsCommList["LEADER_COMM"][4] = { key = "4", text = "Attack Target", action = "MSG_TARGET", value = "Concentrate your attacks on", condition = "TARGET_ENEMY"};
BGSoundAlertsCommList["LEADER_COMM"][5] = { key = "5", text = "Defend Target", action = "MSG_TARGET", value = "Defend", condition = "TARGET_FRIENDLY"};
BGSoundAlertsCommList["LEADER_COMM"][6] = { key = "6", text = "Heal Target", action = "MSG_TARGET", value = "Heal", condition = "TARGET_FRIENDLY"};
BGSoundAlertsCommList["LEADER_COMM"][7] = { key = "7", text = "Stand Your Ground", action = "MSG", value = "Stand your ground", condition = "LEADER"};
BGSoundAlertsCommList["LEADER_COMM"][8] = { key = "8", text = "Cast Buffs", action = "MSG", value = "Recast your buffs on teammates", condition = "LEADER"};
BGSoundAlertsCommList["LEADER_COMM"][9] = { key = "9", text = "Scatter", action = "MSG", value = "Scatter", condition = "LEADER"};
BGSoundAlertsCommList["LEADER_COMM"][10] = { key = "10", text = "Fall Back", action = "MSG", value = "Fall Back", condition = "LEADER"};
BGSoundAlertsCommList["LEADER_COMM"][11] = { key = "-", text = "Slay Them!", action = "MSG", value = "Let them feel our wrath! Slay them all!", condition = "LEADER"};
BGSoundAlertsCommList["LEADER_COMM"][12] = { key = "=", text = "Surrender!", action = "MSG", value = "This is lost. Surrender!", condition = "LEADER"};
BGSoundAlertsCommList["LEADER_COMM"][13] = { key = "ESCAPE", text = "[Hide]", action = "COMM_HIDE"};

BGSoundAlertsCommList["MAIN_COMM"] = { };
BGSoundAlertsCommList["MAIN_COMM"][1] = { key = "1", text = "Group Comm-List", action = "COMM_OPEN", value = "GROUP_COMM", condition = "GROUP"};
BGSoundAlertsCommList["MAIN_COMM"][2] = { key = "2", text = "Battleground Comm-List", action = "COMM_OPEN_DYNAMIC", value = BGSoundAlerts_Comm_ChooseBGComm, condition = "GROUP" };
BGSoundAlertsCommList["MAIN_COMM"][3] = { key = "3", text = "Leader Comm-List", action = "COMM_OPEN", value = "LEADER_COMM", condition = "LEADER"};
BGSoundAlertsCommList["MAIN_COMM"][4] = { key = "ESCAPE", text = "[Hide]", action = "COMM_HIDE"};

BGSoundAlertsCommList["NOTHING"] = { };
BGSoundAlertsCommList["NOTHING"] = { key = "ESCAPE" , text = "[NOTHING]", action = "COMM_HIDE" };

BINDING_HEADER_BGSOUNDALERTS = "BGSoundAlerts Comm-Lists";

function BGSoundAlerts_Comm_RepositionSelector(position)
	
	if (not position) or (position <= 0) or (position > BGSoundAlerts_MaxNumCommButtonsShown)  then
		position = BGSoundAlerts_SelectedCommButton;
	end
	
	-- Reposition the green selector at button "position"
	BGSoundAlerts_CommListSelector:SetPoint("TOP",getglobal("CommButton" .. position),"TOP");

end

function BGSoundAlerts_Comm_KeyDown(button)

	if not (button) then
		return;
	end
	
	if (button == "PRINTSCREEN") then
		Screenshot();
		return;
	end
	
	local i;
	local commfound;
	
	for i = 1, table.getn(BGSoundAlertsCommList[BGSoundAlertsCommFrame.currentlist]) do
		if (button == BGSoundAlertsCommList[BGSoundAlertsCommFrame.currentlist][i].key) then
			-- The Comm link was found
			commfound = i;
		end
	end
	
	if (commfound) then
		-- Pass the action and the value to the handling function
		BGSoundAlerts_Comm_ExecuteComm(BGSoundAlertsCommList[BGSoundAlertsCommFrame.currentlist][commfound].action,
										BGSoundAlertsCommList[BGSoundAlertsCommFrame.currentlist][commfound].value,
										BGSoundAlertsCommList[BGSoundAlertsCommFrame.currentlist][commfound].condition);
	end

end

function BGSoundAlerts_Comm_MouseWheel(direction)
	
	-- MouseWheel moved up or down
	
	DEFAULT_CHAT_FRAME:AddMessage("ROTTING MOUSE WHEEL");
	
	if not (direction) then
		return;
	end
	
	if (direction == 1) then
		DEFAULT_CHAT_FRAME:AddMessage("Up");
		-- Direction is up
		if (BGSoundAlerts_SelectedCommButton <= 1) then
			-- We're already at the top
			BGSoundAlerts_SelectedCommButton = BGSoundAlerts_MaxNumCommButtonsShown;
		else
			-- Increment selection
			BGSoundAlerts_SelectedCommButton = BGSoundAlerts_SelectedCommButton - 1;
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Down");
		-- Direction is down
		if (BGSoundAlerts_SelectedCommButton >= BGSoundAlerts_MaxNumCommButtonsShown) then
			-- We're already at the bottom
			BGSoundAlerts_SelectedCommButton = 1;
		else
			-- Decrement selection
			BGSoundAlerts_SelectedCommButton = BGSoundAlerts_SelectedCommButton + 1;
		end
	end
	
	-- Reposition the green selector
	BGSoundAlerts_Comm_RepositionSelector();

end

function BGSoundAlerts_Comm_SelectorClicked(button)

	if not (button == "MiddleButtonUp") then
		-- It's not the middle button so pass it to the frame underneath
		this:EnableMouse(false);
		local frame = WorldFrame;
		if (frame) then
			DEFAULT_CHAT_FRAME:AddMessage("frame: " .. frame:GetName());
			this = frame;
			if (string.find(button,"Up")) then
				frame:GetScript("OnMouseUp");
			elseif (string.find(button,"Down")) then
				frame:GetScript("OnMouseDown");
			end
		end
		BGSoundAlerts_CommListScroller:EnableMouse(true);
		return;
	end

	-- The middle mouse button was clicked
	BGSoundAlerts_Comm_KeyDown(BGSoundAlertsCommList[BGSoundAlertsCommFrame.currentlist][BGSoundAlerts_SelectedCommButton].key);

end
				

function BGSoundAlerts_Comm_ButtonClick()

	BGSoundAlerts_Comm_KeyDown(BGSoundAlertsCommList[BGSoundAlertsCommFrame.currentlist][this:GetID()].key);

end

function BGSoundAlerts_Comm_ConditionOK(condition)

	-- Check for the condition
		if (condition) then
			if (condition == "GROUP") then
				-- Player needs to be in a group
				if not (GetNumPartyMembers() > 0) then
					return nil;
				end
			elseif (condition == "RAID") then
				-- Player need to be in a raid group
				if not (GetNumRaidMembers() > 0) then
					return nil;
				end
			elseif (condition == "LEADER") then
				-- Player needs to be the leader
				if not (IsPartyLeader()) or not (IsRaidLeader()) then
					return nil;
				end
			elseif (condition == "TARGET") then
				-- Players needs to have a target
				if not (UnitIsConnected("target")) then
					return nil;
				end
			elseif (condition == "TARGET_FRIENDLY") then
				-- Player needs to have a friendly target
				if not (UnitIsFriendly("player","target")) then
					return nil;
				end
			elseif (condition == "TARGET_ENEMY") then
				-- Player needs to have a enemy target
				if not (UnitIsEnemy("player","target")) then
					return nil;
				end
			end					
		end
		return 1;
end

function BGSoundAlerts_Comm_ExecuteComm(action,value,condition)

	if not (action) then
		return;
	end
	
	if not (BGSoundAlerts_Comm_ConditionOK(condition)) then
		return;
	end
	
	if (action == "COMM_HIDE") then
		-- Hide the comm list
		-- Doesn't need a value
		BGSoundAlerts_Comm_HideCommList();
	end
	
	if (action == "MSG") then
		-- Send the message to raid or party
		-- Need a value
		if not (value) then
			return;
		end
		SendChatMessage(value,"BATTLEGROUND");
		BGSoundAlerts_Comm_HideCommList();
	end
		
	if (action == "MSG_ZONE") then
		-- Send a message to the party appending the Zone Name in the end
		-- Needs a value
		if not (value) then
			return;
		end
		SendChatMessage(value .. " " .. GetMinimapZoneText(),"BATTLEGROUND");
		BGSoundAlerts_Comm_HideCommList();
	end
	
	if (action == "MSG_TARGET") then
		-- Send a message to the group appending the Target's name in the end
		-- Needs a value
		if not (value) then
			return;
		end
		SendChatMessage(value .. " " .. UnitName("target"),"BATTLEGROUND");
		BGSoundAlerts_Comm_HideCommList();
	end
			
	if (action == "COMM_OPEN") then
		-- Switch to a new comm-list
		-- Needs a value
		if not (value) then
			return;
		end
		BGSoundAlerts_Comm_ShowCommList(value);
	end
	
	if (action == "COMM_OPEN_DYNAMIC") then
		-- Value is a function which returns a string that refers to a particular comm-list
		-- Needs a value (must be a function)
		if not (value) then
			return;
		end
		if (type(value) ~= "function") then
			return;
		end
		BGSoundAlerts_Comm_ShowCommList(value());
	end
	
end

function BGSoundAlerts_Comm_HideCommList()
	
	BGSoundAlertsCommFrame.currentlist = "NOTHING";
	HideUIPanel(BGSoundAlertsCommFrame);
	
end

function BGSoundAlerts_Comm_ShowCommList(commlist)

	if not (commlist) then
		return;
	end
	
	if (BGSoundAlertsCommList[commlist]) then
		BGSoundAlertsCommFrame.currentlist = commlist;
		if (BGSoundAlertsCommFrame:IsVisible()) then
			BGSoundAlerts_Comm_Show()
		else
			BGSoundAlertsCommFrame:Show();
		end
		BGSoundAlerts_SelectedCommButton = 1;
		BGSoundAlerts_Comm_RepositionSelector();
	end

end

function BGSoundAlerts_Comm_Show()

	-- Displays and lays out the selected comm list
	if not (BGSoundAlertsCommFrame.currentlist) then
		BGSoundAlertsCommFrame.currentlist = "NOTHING";
	end
	
	-- Start off by counting the number of entries in the currentlist
	local totalentries = table.getn(BGSoundAlertsCommList[BGSoundAlertsCommFrame.currentlist]);
	
	-- If too much entries
	if (totalentries > 13) then
		message("BGSoundAlerts: CommList Error. Too many entries in " .. BGSoundAlertsCommFrame.currentlist);
		totalentries = 13;
	end
	
	-- Set texts and functions for the buttons, checking for conditions
	local i;
	for i = 1, totalentries do
		if (BGSoundAlerts_Comm_ConditionOK(BGSoundAlertsCommList[BGSoundAlertsCommFrame.currentlist][i].condition)) then
			getglobal("CommButton" .. i):SetText(BGSoundAlertsCommList[BGSoundAlertsCommFrame.currentlist][i].key .. ". " ..
													BGSoundAlertsCommList[BGSoundAlertsCommFrame.currentlist][i].text);
			getglobal("CommButton" .. i).action = BGSoundAlertsCommList[BGSoundAlertsCommFrame.currentlist][i].action;
			getglobal("CommButton" .. i).value = BGSoundAlertsCommList[BGSoundAlertsCommFrame.currentlist][i].value;
			getglobal("CommButton" .. i):Show();
			getglobal("CommButton" .. i):Enable();
		else
			getglobal("CommButton" .. i):SetText(BGSoundAlertsCommList[BGSoundAlertsCommFrame.currentlist][i].key .. ". " ..
													BGSoundAlertsCommList[BGSoundAlertsCommFrame.currentlist][i].text);
			getglobal("CommButton" .. i).action = BGSoundAlertsCommList[BGSoundAlertsCommFrame.currentlist][i].action;
			getglobal("CommButton" .. i).value = BGSoundAlertsCommList[BGSoundAlertsCommFrame.currentlist][i].value;
			getglobal("CommButton" .. i):Show();
			getglobal("CommButton" .. i):Disable();
		end
	end
		
	-- If totalentries is not 13 hide any remaining
	if (totalentries < 13) then
		for i = totalentries + 1, 13 do
			getglobal("CommButton" .. i):Hide();
		end
	end
	
	-- Play a sound
	PlaySoundFile("Interface\\AddOns\\BGSoundAlerts\\CommListOpen.wav");

end

function BGSoundAlerts_Comm_OpenMainCommList()
	
	-- Open the Main-Comm List
	local zone = GetRealZoneText();
	if (zone == "Warsong Gulch" or zone == "Arathi Basin" or zone == "Alterac Valley") then
		BGSoundAlerts_Comm_ShowCommList("MAIN_COMM");
	end

end

function BGSoundAlerts_Comm_OpenPartyCommList()

	local zone = GetRealZoneText();
	if (zone == "Warsong Gulch" or zone == "Arathi Basin" or zone == "Alterac Valley") then
		if (GetNumPartyMembers() > 0) then
			BGSoundAlerts_Comm_ShowCommList("GROUP_COMM");
		end
	end
	
end

function BGSoundAlerts_Comm_OpenBGCommList()

	local zone = GetRealZoneText();
	if (zone == "Warsong Gulch" or zone == "Arathi Basin" or zone == "Alterac Valley") then
		if (GetNumPartyNumbers() > 0) then
			BGSoundAlerts_Comm_ShowCommList(BGSoundAlerts_Comm_ChooseBGComm());
		end
	end
	
end

function BGSoundAlerts_Comm_OpenLeaderCommList()

	local zone = GetRealZoneText();
	if (zone == "Warsong Gulch" or zone == "Arathi Basin" or zone == "Alterac Valley") then
		if (IsPartyLeader() or IsRaidLeader()) then
			BGSoundAlerts_Comm_ShowCommList("LEADER_COMM");
		end
	end
	
end
