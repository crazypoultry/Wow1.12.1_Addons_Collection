-- BuffAssignment code

function RaidHealer_AnnounceBuffAssignment_OnClick()
	RaidHealer_AnnounceAssignment(RaidHealer_GetCC("ASSIGNMENT_CHANNEL_BUFF"), "BUFF", nil);
end

function RaidHealer_AnnounceClassBuffAssignment_OnClick()
	RaidHealer_AnnounceAssignment(RaidHealer_GetCC("ASSIGNMENT_CHANNEL_BUFF"), "BUFF", RaidHealer_CharacterConfig["CURRENT_BUFF_TYPE"]);
end

function RaidHealer_AddBufferToGroup(buff, bufferName, groupID)
	if ( not RaidHealer_Assignments["BUFF"][buff]) then
		RaidHealer_Assignments["BUFF"][buff] = {};
	end
	
	if ( RaidHealer_Assignments["BUFF"][buff][bufferName] == nil ) then
		RaidHealer_Assignments["BUFF"][buff][bufferName] = {};
	end
	-- check if tank exists
	for i=1, table.getn(RaidHealer_Assignments["BUFF"][buff][bufferName]), 1 do
		if ( RaidHealer_Assignments["BUFF"][buff][bufferName][i] == groupID ) then
			return;
		end
	end
	-- insert if not assigned yet
	table.insert(RaidHealer_Assignments["BUFF"][buff][bufferName], groupID);
	table.sort(RaidHealer_Assignments["BUFF"][buff][bufferName]);
end

function RaidHealer_RemoveBufferFromGroup(buff, bufferName, groupID)
	if ( RaidHealer_Assignments["BUFF"][buff] ) then
		if ( RaidHealer_Assignments["BUFF"][buff][bufferName] ~= nil ) then
			for i=1, table.getn(RaidHealer_Assignments["BUFF"][buff][bufferName]), 1 do
				if ( RaidHealer_Assignments["BUFF"][buff][bufferName][i] == groupID ) then
					table.remove(RaidHealer_Assignments["BUFF"][buff][bufferName], i);
					break;
				end
			end
		end
	end
end

function RaidHealer_SetBuffType(buffID)
	RaidHealer_CharacterConfig["CURRENT_BUFF_TYPE"] = buffID;
	RaidHealer_DrawBuffAssignmentFrame();
end

function RaidHealer_AutomaticBuffAssignment()
	local buffId = RaidHealer_GetCC("CURRENT_BUFF_TYPE");
	local buff = RAIDHEALER_BUFFS[buffId]["BUFF"]
	local class = RAIDHEALER_BUFFS[buffId]["CLASS"];
	local num = table.getn(RaidHealer_RaidMember[class]);
	-- reset assignments
	RaidHealer_Assignments["BUFF"][buff] = {};
	
	local matrix = {
		{ 1, 1, 1, 1, 1, 1, 1, 1 },
		{ 1, 1, 1, 1, 2, 2, 2, 2 },
		{ 1, 1, 1, 2, 2, 2, 3, 3 },
		{ 1, 1, 2, 2, 3, 3, 4, 4 },
		{ 1, 1, 2, 2, 3, 3, 4, 5 },
		{ 1, 1, 2, 2, 3, 4, 5, 6 },
		{ 1, 1, 2, 3, 4, 5, 6, 7 },
		{ 1, 2, 3, 4, 5, 6, 7, 8 }
	};
	
	local classMember = RaidHealer_RaidMember[class];
	local buffer = RaidHealer_ShuffleTable(classMember);
	
	for i=1, table.getn(matrix[num]), 1 do
		RaidHealer_AddBufferToGroup(buff, buffer[matrix[num][i]]["NAME"], i);
	end
	
	RaidHealer_RefreshRaidMember();
	RaidHealer_DrawBuffAssignmentFrame();
end

-- UI

function RaidHealer_InitInterfaceBuffAssignmentFrame()
	RaidHealer_BuffAssignmentFrame_BuffAnnounceButton:SetText(RAIDHEALER_ANNOUNCE);
	RaidHealer_BuffAssignmentFrame_BuffAnnounceClassButton:SetText(RAIDHEALER_ONLY_BUFF);
	RaidHealer_BuffAssignmentFrame_ClearBuffAssignmentsButton:SetText(RAIDHEALER_RESET);
	RaidHealer_BuffAssignmentFrame_AutomaticBuffAssignmentsButton:SetText(RAIDHEALER_AUTOMATIC);
	-- groups
	for i=1, RAIDHEALER_MAX_GROUPS, 1 do
		getglobal("RaidHealer_BuffAssignmentFrame_GroupNames_GroupName"..i):SetText(RAIDHEALER_GROUP..i);
	end
end

function RaidHealer_DrawBuffAssignmentFrame()
	RaidHealer_FillBuffer();
	RaidHealer_DrawBufferAssignments();
end

function RaidHealer_DrawBufferAssignments()
	local buffID = RaidHealer_CharacterConfig["CURRENT_BUFF_TYPE"];
	local buff = RAIDHEALER_BUFFS[buffID]["BUFF"]
	local class = RAIDHEALER_BUFFS[buffID]["CLASS"];
	
	local buffers = RaidHealer_RaidMember[class];
		
	if (buffers ~= nil) then
		for b=1, table.getn(buffers), 1 do
			local buffer = buffers[b]["NAME"];
			if (buffer ~= nil) then
				if (RaidHealer_Assignments["BUFF"][buff] ~= nil) then
					if (RaidHealer_Assignments["BUFF"][buff][buffer] ~= nil) then
						for g=1, table.getn(RaidHealer_Assignments["BUFF"][buff][buffer]), 1 do
							getglobal("RaidHealer_Buffer"..b.."_Group"..RaidHealer_Assignments["BUFF"][buff][buffer][g]):SetChecked(1);
						end
					end
				end
			end
		end
	end

end

function RaidHealer_FillBuffer()
	RaidHealer_ClearBuffer();

	local hIndex = 1;
	local buffID = 1
	if (RaidHealer_CharacterConfig["CURRENT_BUFF_TYPE"]) then
		buffID = RaidHealer_CharacterConfig["CURRENT_BUFF_TYPE"];
	end
	
	local bufferClass = RAIDHEALER_BUFFS[buffID]["CLASS"];
	if (RaidHealer_RaidMember[bufferClass] ~= nil) then
		for k, v in pairs(RaidHealer_RaidMember[bufferClass]) do
			if (getglobal("RaidHealer_Buffer"..hIndex) ~= nil) then
				getglobal("RaidHealer_Buffer"..hIndex):Show();
				getglobal("RaidHealer_Buffer"..hIndex.."PlayerName"):SetText(v["NAME"]);
				RaidHealer_SetClassIcon(getglobal("RaidHealer_Buffer"..hIndex.."ClassTexture"), bufferClass);
				
				-- disable/enable Tanks
				for t=1, RAIDHEALER_MAX_GROUPS, 1 do
					getglobal("RaidHealer_Buffer"..hIndex.."_Group"..t):SetChecked(nil);
					getglobal("RaidHealer_Buffer"..hIndex.."_Group"..t):Show();
				end
				hIndex = hIndex+1;
			end
		end
	end
end

function RaidHealer_ClearBuffer()
	for i=1, RAIDHEALER_MAX_BUFFER, 1 do
		if (getglobal("RaidHealer_Buffer"..i) ~= nil) then
			getglobal("RaidHealer_Buffer"..i):Hide();
			getglobal("RaidHealer_Buffer"..i.."PlayerName"):SetText("PlayerName");
			getglobal("RaidHealer_Buffer"..i.."ClassTexture"):SetTexture("");
			
			for t=1, RAIDHEALER_MAX_GROUPS, 1 do
				getglobal("RaidHealer_Buffer"..i.."_Group"..t):SetChecked(nil);
				getglobal("RaidHealer_Buffer"..i.."_Group"..t):Hide();
			end
		end
	end
end

-- Buff Dropdown
function RaidHealer_BuffSelectDropDown_OnLoad()
	UIDropDownMenu_SetSelectedID(this, 1);
	UIDropDownMenu_Initialize(this, RaidHealer_BuffSelectDropDown_Initialize);
	UIDropDownMenu_SetWidth(100, RaidHealer_BuffSelectDropDown);
end

function RaidHealer_BuffSelectDropDown_OnShow()
	UIDropDownMenu_SetSelectedID(this, RaidHealer_CharacterConfig["CURRENT_BUFF_TYPE"]);
	UIDropDownMenu_SetText(RAIDHEALER_BUFFS[RaidHealer_CharacterConfig["CURRENT_BUFF_TYPE"]]["BUFF"], RaidHealer_BuffSelectDropDown);
end

function RaidHealer_BuffSelectDropDown_Initialize()
	for i=1, table.getn(RAIDHEALER_BUFFS), 1 do
		info = {};
		info.text = RAIDHEALER_BUFFS[i]["BUFF"];
		info.func = RaidHealer_BuffSelectDropDown_OnClick;
		
		if ( UIDropDownMenu_GetSelectedID(RaidHealer_BuffSelectDropDown) == i ) then
			checked = 1;
			UIDropDownMenu_SetText(info.text, RaidHealer_BuffSelectDropDown);
		else
			checked = nil;
		end
		info.checked = checked;
		UIDropDownMenu_AddButton(info);
	end
end

function RaidHealer_BuffSelectDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(RaidHealer_BuffSelectDropDown, this:GetID());
	RaidHealer_SetBuffType(this:GetID());
end

-- Channel Buff DropDown
function RaidHealer_ChannelBuffSelectDropDown_OnLoad()
	UIDropDownMenu_SetSelectedValue(this, RaidHealer_GetCC("ASSIGNMENT_CHANNEL_BUFF"), RaidHealer_GetCC("ASSIGNMENT_CHANNEL_BUFF"));
	UIDropDownMenu_Initialize(this, RaidHealer_ChannelBuffSelectDropDown_Initialize);
	UIDropDownMenu_SetWidth(75, RaidHealer_ChannelBuffSelectDropDown);
	--getglobal(this:GetName().."Label"):SetText(RAIDHEALER_TAB2_TEXT);
end

function RaidHealer_ChannelBuffSelectDropDown_OnShow()
	UIDropDownMenu_SetSelectedValue(this, RaidHealer_GetCC("ASSIGNMENT_CHANNEL_BUFF"), RaidHealer_GetCC("ASSIGNMENT_CHANNEL_BUFF"));
	UIDropDownMenu_SetText(RaidHealer_GetCC("ASSIGNMENT_CHANNEL_BUFF"), RaidHealer_ChannelBuffSelectDropDown);
end

function RaidHealer_ChannelBuffSelectDropDown_OnClick()
	local chans = RaidHealer_GetCommChannels();
	UIDropDownMenu_SetSelectedID(RaidHealer_ChannelBuffSelectDropDown, this:GetID());
	RaidHealer_SetCC("ASSIGNMENT_CHANNEL_BUFF", chans[this:GetID()]);
end

function RaidHealer_ChannelBuffSelectDropDown_Initialize()
	local ind = 1;
	local channels = RaidHealer_GetCommChannels();

	for i=1, table.getn(channels), 1 do
		info = {};
		info.text = channels[i];
		info.func = RaidHealer_ChannelBuffSelectDropDown_OnClick;
		
		if ( RaidHealer_GetCC("ASSIGNMENT_CHANNEL_BUFF") == info.text ) then
			checked = 1;
			UIDropDownMenu_SetText(info.text, RaidHealer_ChannelBuffSelectDropDown);
		else
			checked = nil;
		end
		info.checked = checked;
		UIDropDownMenu_AddButton(info);
		
		ind = ind + 1;
	end
end