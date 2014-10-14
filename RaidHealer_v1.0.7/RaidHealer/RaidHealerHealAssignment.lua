-- HealAssignment code

function RaidHealer_AnnounceHealAssignment_OnClick()
	RaidHealer_AnnounceAssignment(RaidHealer_GetCC("ASSIGNMENT_CHANNEL_HEAL"), "HEAL", nil);
end

function RaidHealer_AnnounceClassHealAssignment_OnClick()
	RaidHealer_AnnounceAssignment(RaidHealer_GetCC("ASSIGNMENT_CHANNEL_HEAL"), "HEAL", RaidHealer_CharacterConfig["CURRENT_TANK_CLASS"]);
end

function RaidHealer_AddHealerToTank(healerName, tankID, tankClass)
	local tankName = RaidHealer_GetTankName(tankID, tankClass);
	
	if ( RaidHealer_Assignments["HEAL"][healerName] == nil ) then
		RaidHealer_Assignments["HEAL"][healerName] = {};
	end
	-- check if tank exists
	for i=1, table.getn(RaidHealer_Assignments["HEAL"][healerName]), 1 do
		if ( RaidHealer_Assignments["HEAL"][healerName][i] == tankName ) then
			return;
		end
	end
	-- insert if not assigned yet
	table.insert(RaidHealer_Assignments["HEAL"][healerName], tankName);
end

function RaidHealer_RemoveHealerFromTank(healerName, tankID, tankClass)
	local tankName = RaidHealer_GetTankName(tankID, tankClass);
	
	if ( RaidHealer_Assignments["HEAL"][healerName] ~= nil ) then
		for i=1, table.getn(RaidHealer_Assignments["HEAL"][healerName]), 1 do
			if ( RaidHealer_Assignments["HEAL"][healerName][i] == tankName ) then
				table.remove(RaidHealer_Assignments["HEAL"][healerName], i);
				break;
			end
		end
	end
end

function RaidHealer_SetTankClass(tankID)
	RaidHealer_CharacterConfig["CURRENT_TANK_CLASS"] = RAIDHEALER_TANKCLASSES[tankID];
	RaidHealer_DrawHealAssignmentFrame();
end

-- UI

function RaidHealer_InitInterfaceHealAssignmentFrame()
	RaidHealer_HealAssignmentFrame_Unassigned_Title:SetText(RAIDHEALER_UNASSIGNED);
	RaidHealer_HealAssignmentFrame_HealAnnounceButton:SetText(RAIDHEALER_ANNOUNCE);
	RaidHealer_HealAssignmentFrame_HealAnnounceClassButton:SetText(RAIDHEALER_ONLY_CLASS);
	RaidHealer_HealAssignmentFrame_ClearHealAssignmentsButton:SetText(RAIDHEALER_RESET);
	RaidHealer_HealAssignmentFrame_HealClasses_Title:SetText(RAIDHEALER_HEALCLASSES_TXT);
	RaidHealer_TankClassSelectDropDown.tooltipText = RAIDHEALER_TANK_DD_TOOLTIP;
end

function RaidHealer_DrawHealAssignmentFrame()
	RaidHealer_FillForm(RaidHealer_CharacterConfig["CURRENT_TANK_CLASS"]);
	RaidHealer_DrawHealerAssignments();
	RaidHealer_DrawUnassignedList();
end

function RaidHealer_FillForm(tankClass)
	RaidHealer_FillTanks(tankClass);
	RaidHealer_FillHealer(tankClass);
end

function RaidHealer_FillTanks(tankClass)
	local i = 1;
	
	if (RaidHealer_RaidMember[tankClass] == nil) then
		RaidHealer_RaidMember[tankClass] = {}
	end
	
	for k, v in pairs(RaidHealer_RaidMember[tankClass]) do
		if (i <= RAIDHEALER_MAX_TANKS) then
			local pName = RaidHealer_GetShortName(v["NAME"]);
			if (v["CTRA_MT"] and v["CTRA_MT"] > 0) then
				pName = "MT"..v["CTRA_MT"].."\n"..pName;
			end
			getglobal("RaidHealer_TankName"..i):SetText(pName);
		end
		i=i+1;
	end
	-- clear not used tanks
	for e=i, RAIDHEALER_MAX_TANKS, 1 do
		getglobal("RaidHealer_TankName"..e):SetText("");
	end
end

function RaidHealer_FillHealer(tankClass)
	RaidHealer_ClearHealer();
	-- get number of tanks
	local tankCount = table.getn(RaidHealer_RaidMember[tankClass])
	local hIndex = 1;
	
	for i=1, table.getn(RaidHealer_CharacterConfig["HEAL_CLASSES"]), 1 do
		local healerClass = RaidHealer_CharacterConfig["HEAL_CLASSES"][i];
		if (RaidHealer_RaidMember[healerClass] ~= nil) then
			for k, v in pairs(RaidHealer_RaidMember[healerClass]) do
				if (getglobal("RaidHealer_Healer"..hIndex) ~= nil) then
					getglobal("RaidHealer_Healer"..hIndex):Show();
					getglobal("RaidHealer_Healer"..hIndex.."PlayerName"):SetText(v["NAME"]);
					RaidHealer_SetClassIcon(getglobal("RaidHealer_Healer"..hIndex.."ClassTexture"), healerClass);
					
					-- disable/enable Tanks
					for t=1, RAIDHEALER_MAX_TANKS, 1 do
						getglobal("RaidHealer_Healer"..hIndex.."_Tank"..t):SetChecked(nil);
						if (t <= tankCount) then
							getglobal("RaidHealer_Healer"..hIndex.."_Tank"..t):Show();
						else
							getglobal("RaidHealer_Healer"..hIndex.."_Tank"..t):Hide();
						end
					end
					hIndex = hIndex+1;
				end
			end
		end
	end
	-- update scroll panel
	RaidHealer_TabRotationScrollFrame:UpdateScrollChildRect();
end

function RaidHealer_DrawHealerAssignments()
	local hIndex = 1;
	-- iterate tru all shown heal classes
	for hc=1, table.getn(RaidHealer_CharacterConfig["HEAL_CLASSES"]), 1 do
		local healers = RaidHealer_RaidMember[RaidHealer_CharacterConfig["HEAL_CLASSES"][hc]];
		-- iterate tru all healers of the class 
		if (healers ~= nil) then
			for h=1, table.getn(healers), 1 do
				-- set color coding
				RaidHealer_SetHealerAssignmentColor(healers[h]["NAME"], hIndex);
				
				local tanks = RaidHealer_RaidMember[RaidHealer_CharacterConfig["CURRENT_TANK_CLASS"]];
				-- iterate to all tanks of the current tank class
				if (tanks ~= nil) then
					for t=1, table.getn(tanks), 1 do
						if (RaidHealer_Assignments["HEAL"][healers[h]["NAME"]] ~= nil) then
							local healerTanks = RaidHealer_Assignments["HEAL"][healers[h]["NAME"]]
							-- iterate assignments
							for ht=1, table.getn(healerTanks), 1 do
								if (healerTanks[ht] == tanks[t]["NAME"]) then
									getglobal("RaidHealer_Healer"..hIndex.."_Tank"..t):SetChecked(1);
									break;
								else
									getglobal("RaidHealer_Healer"..hIndex.."_Tank"..t):SetChecked(nil);
								end
							end
						end
					end
				end
				hIndex = hIndex + 1;
			end
		end
	end
end

function RaidHealer_DrawUnassignedList()
	local unassigned = {};
	-- iterate tru all shown heal classes
	for hc=1, table.getn(RaidHealer_CharacterConfig["HEAL_CLASSES"]), 1 do
		local healers = RaidHealer_RaidMember[RaidHealer_CharacterConfig["HEAL_CLASSES"][hc]];
		-- iterate tru all healers of the class 
		if (healers ~= nil) then
			for h=1, table.getn(healers), 1 do
				-- add to non assigned healer
				if ( not RaidHealer_PlayerHasAssignments(healers[h]["NAME"], "HEAL") ) then
					table.insert(unassigned, healers[h]["NAME"]);
				end
			end
		end
	end
	
	-- now draw the names
	if ( type(unassigned) == "table" and table.getn(unassigned) > 0 ) then
		table.sort(unassigned);
		if ( table.getn(unassigned) > 26 ) then
			table.setn(unassigned, 26);
		end
		RaidHealer_HealAssignmentFrame_Unassigned_Names:SetText(table.concat(unassigned, "\n"));
	else
		RaidHealer_HealAssignmentFrame_Unassigned_Names:SetText("");
	end
end

function RaidHealer_RefreshHealAssignmentFrame()
	-- heal classes
	local hc = RaidHealer_GetValidFactionsClasses(RAIDHEALER_HEALCLASSES);
	for i=1, table.getn(hc), 1 do
		for h=1, table.getn(RaidHealer_CharacterConfig["HEAL_CLASSES"]), 1 do
			if (hc[i] == RaidHealer_CharacterConfig["HEAL_CLASSES"][h]) then
				getglobal(RaidHealer_HealAssignmentFrame_HealClasses:GetName().."_Class"..i):SetChecked(1);
				break;
			else
				getglobal(RaidHealer_HealAssignmentFrame_HealClasses:GetName().."_Class"..i):SetChecked(nil);
			end
		end
	end
end

function RaidHealer_SetHealClassLabels()
	-- heal classes
	local hc = RaidHealer_GetValidFactionsClasses(RAIDHEALER_HEALCLASSES);
	for i=1, table.getn(hc), 1 do
		local texture = getglobal(RaidHealer_HealAssignmentFrame_HealClasses:GetName().."_Class"..i.."_Texture");
		
		if (texture) then
			RaidHealer_SetClassIcon(texture, hc[i]);
		end
		
--		local label = getglobal(RaidHealer_HealAssignmentFrame_HealClasses:GetName().."_Class"..i.."_Label");
--		if (label) then 
--			label:SetText(hc[i]);
--		end
		
	end
end

function RaidHealer_ClearHealer()
	for i=1, RAIDHEALER_MAX_HEALER, 1 do
		if (getglobal("RaidHealer_Healer"..i) ~= nil) then
			getglobal("RaidHealer_Healer"..i):Hide();
			getglobal("RaidHealer_Healer"..i.."PlayerName"):SetText("PlayerName");
			getglobal("RaidHealer_Healer"..i.."ClassTexture"):SetTexture("");
			
			for t=1, RAIDHEALER_MAX_TANKS, 1 do
				getglobal("RaidHealer_Healer"..i.."_Tank"..t):SetChecked(nil);
				getglobal("RaidHealer_Healer"..i.."_Tank"..t):Hide();
			end
		end
	end
end

function RaidHealer_SetHealerAssignmentColor(playerName, hIndex)
	if ( RaidHealer_PlayerHasAssignments(playerName, "HEAL") ) then
		getglobal("RaidHealer_Healer"..hIndex):SetBackdropColor(0, 1, 0, 0.5);
	else
		getglobal("RaidHealer_Healer"..hIndex):SetBackdropColor(0.5, 0.5, 0.5);
	end
end

-- TankClass Dropdown
function RaidHealer_TankClassSelectDropDown_OnLoad()
	UIDropDownMenu_SetSelectedID(this, RaidHealer_GetCurrentTankClass());
	UIDropDownMenu_Initialize(this, RaidHealer_TankClassSelectDropDown_Initialize);
	UIDropDownMenu_SetWidth(100, RaidHealer_TankClassSelectDropDown);
end

function RaidHealer_TankClassSelectDropDown_OnShow()
	UIDropDownMenu_SetSelectedID(this, RaidHealer_GetCurrentTankClass());
	UIDropDownMenu_SetText(RaidHealer_CharacterConfig["CURRENT_TANK_CLASS"], RaidHealer_TankClassSelectDropDown);
end

function RaidHealer_TankClassSelectDropDown_Initialize()
	for i=1, table.getn(RAIDHEALER_TANKCLASSES), 1 do
		info = {};
		info.text = RAIDHEALER_TANKCLASSES[i];
		info.func = RaidHealer_TankClassSelectDropDown_OnClick;
		
		if ( UIDropDownMenu_GetSelectedID(RaidHealer_TankClassSelectDropDown) == i ) then
			checked = 1;
			UIDropDownMenu_SetText(info.text, RaidHealer_TankClassSelectDropDown);
		else
			checked = nil;
		end
		info.checked = checked;
		UIDropDownMenu_AddButton(info);
	end
end

function RaidHealer_TankClassSelectDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(RaidHealer_TankClassSelectDropDown, this:GetID());
	RaidHealer_SetTankClass(this:GetID());
end

-- Channel Heal DropDown
function RaidHealer_ChannelHealSelectDropDown_OnLoad()
	UIDropDownMenu_SetSelectedValue(this, RaidHealer_GetCC("ASSIGNMENT_CHANNEL_HEAL"), RaidHealer_GetCC("ASSIGNMENT_CHANNEL"));
	UIDropDownMenu_Initialize(this, RaidHealer_ChannelHealSelectDropDown_Initialize);
	UIDropDownMenu_SetWidth(75, RaidHealer_ChannelHealSelectDropDown);
	-- getglobal(this:GetName().."Label"):SetText(RAIDHEALER_TAB1_TEXT);
end

function RaidHealer_ChannelHealSelectDropDown_OnShow()
	UIDropDownMenu_SetSelectedValue(this, RaidHealer_GetCC("ASSIGNMENT_CHANNEL_HEAL"), RaidHealer_GetCC("ASSIGNMENT_CHANNEL_HEAL"));
	UIDropDownMenu_SetText(RaidHealer_GetCC("ASSIGNMENT_CHANNEL_HEAL"), RaidHealer_ChannelHealSelectDropDown);
end

function RaidHealer_ChannelHealSelectDropDown_OnClick()
	local chans = RaidHealer_GetCommChannels();
	UIDropDownMenu_SetSelectedID(RaidHealer_ChannelHealSelectDropDown, this:GetID());
	RaidHealer_SetCC("ASSIGNMENT_CHANNEL_HEAL", chans[this:GetID()]);
end

function RaidHealer_ChannelHealSelectDropDown_Initialize()
	local ind = 1;
	local channels = RaidHealer_GetCommChannels();

	for i=1, table.getn(channels), 1 do
		info = {};
		info.text = channels[i];
		info.func = RaidHealer_ChannelHealSelectDropDown_OnClick;
		
		if ( RaidHealer_GetCC("ASSIGNMENT_CHANNEL_HEAL") == info.text ) then
			checked = 1;
			UIDropDownMenu_SetText(info.text, RaidHealer_ChannelHealSelectDropDown);
		else
			checked = nil;
		end
		info.checked = checked;
		UIDropDownMenu_AddButton(info);
		
		ind = ind + 1;
	end
end