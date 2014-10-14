OneRaid.Options = {};

function OneRaid.Options:OnLoad()

	getglobal(this:GetName() .. "_Header_Text"):SetText(ONERAID_OPTIONS);
	
	getglobal(this:GetName() .. "_Header_Background"):SetVertexColor(.4, 0, 0, 1);
	this:SetBackdropColor(0, 0, 0, .75);
	this:SetBackdropBorderColor(0, 0, 0, 0);

end

function OneRaid.Options:OnMouseDown()

	this:StartMoving();
	
end

function OneRaid.Options:OnMouseUp()

	this:StopMovingOrSizing();
	
end

function OneRaid.Options:OnShow()

	self:OptionGroupClick("General");
	
end

----

function OneRaid.Options:OptionGroupClick(group)

	OneRaid_Options_Frame_General:Hide();
	OneRaid_Options_Frame_Buffs:Hide();
	OneRaid_Options_Frame_Debuffs:Hide();
	--OneRaid_Options_Frame_CureDebuff:Hide();
	OneRaid_Options_Frame_CureOptions:Hide();
	
	getglobal("OneRaid_Options_Frame_" .. group):Show();
	
	if (group == "CureOptions") then
		self:CureDebuffs_OnUpdate();
		self:CurePriority_OnUpdate();		
		OneRaid_Options_Frame_CureOptions_CureMagic:SetChecked(OneRaid_Options.cureMagic);
		OneRaid_Options_Frame_CureOptions_CureDisease:SetChecked(OneRaid_Options.cureDisease);
		OneRaid_Options_Frame_CureOptions_CurePoison:SetChecked(OneRaid_Options.curePoison);
		OneRaid_Options_Frame_CureOptions_CureCurse:SetChecked(OneRaid_Options.cureCurse);
		OneRaid_Options_Frame_CureOptions_CurePets:SetChecked(OneRaid_Options.curePets);
	end
	
	if (group == "General") then
		self:DebuffPriority_OnUpdate();
		self:ClassPriority_OnUpdate();
		OneRaid_Options_Frame_General_HideGuildTitles:SetChecked(OneRaid_Options.hideGuildTitles);
		OneRaid_Options_Frame_General_DisableSound:SetChecked(OneRaid_Options.disableSound);
		OneRaid_Options_Frame_General_DisableUnitTooltip:SetChecked(OneRaid_Options.disableUnitTooltip);
		OneRaid_Options_Frame_General_UnlockMessageFrame:SetChecked(OneRaid_Options.unlockMessageFrame);
		OneRaid_Options_Frame_General_DisableStickyOfficer:SetChecked(OneRaid_Options.disableStickyOfficer);
		OneRaid_Options_Frame_General_DisableStickyChannel:SetChecked(OneRaid_Options.disableStickyChannel);
		OneRaid_Options_Frame_General_ShowAllGroupWindows:SetChecked(OneRaid_Options.showAllGroupWindows);
		OneRaid_Options_Frame_General_LeaderColorNormalTexture:SetVertexColor(OneRaid_Options.leaderColor.r, OneRaid_Options.leaderColor.g, OneRaid_Options.leaderColor.b);
		OneRaid_Options_Frame_General_AssistantColorNormalTexture:SetVertexColor(OneRaid_Options.assistantColor.r, OneRaid_Options.assistantColor.g, OneRaid_Options.assistantColor.b);
		OneRaid_Options_Frame_General_RaidInfoColorNormalTexture:SetVertexColor(OneRaid_Options.raidInfoColor.r, OneRaid_Options.raidInfoColor.g, OneRaid_Options.raidInfoColor.b);
		OneRaid_Options_Frame_General_IconSlider:SetValue(OneRaid_Options.iconAngle or 0);
		
	end
	
	if (type(self[group .. "_OnUpdate"] == "function") and self[group .. "_OnUpdate"]) then
        self[group .. "_OnUpdate"](self);
    end
	
end

-------Buffs

function OneRaid.Options:BuffCheck_OnEnter(check)
	
	if (check == "standard") then
		GameTooltip:SetOwner(this);
		GameTooltip:ClearLines();
		GameTooltip:AddLine(ONERAID_BUFF_IN_GROUP_WINDOWS);
	elseif (check == "buffMonitor") then
		GameTooltip:SetOwner(this);
		GameTooltip:ClearLines();
		GameTooltip:AddLine(ONERAID_BUFF_IN_BUFF_MONITOR);
	elseif (check == "tankMonitor") then
		GameTooltip:SetOwner(this);
		GameTooltip:ClearLines();
		GameTooltip:AddLine(ONERAID_BUFF_IN_TANK_MONITOR);
	else
		GameTooltip:SetOwner(this);
		GameTooltip:ClearLines();
		GameTooltip:AddLine(string.format(ONERAID_INGORE_BUFF_MONITOR, check));
	end
	
	GameTooltip:Show();
	
end

function OneRaid.Options:BuffCheck_OnCheck(check)

	local offset = FauxScrollFrame_GetOffset(OneRaid_Options_Frame_Buffs_List);
	
	OneRaid_Options.buffs[this:GetParent():GetID() + offset][check] = this:GetChecked();
	
	self:Buffs_OnUpdate();
	self:UpdateAllBuffs();

end

function OneRaid.Options:BuffIcon(icon, parent)

	local offset = FauxScrollFrame_GetOffset(OneRaid_Options_Frame_Buffs_List);
	
	OneRaid_Options.buffs[parent:GetParent():GetID() + offset].icon = icon;
	
	self:Buffs_OnUpdate();
	self:UpdateAllBuffs();
	
end

function OneRaid.Options:AddBuff()

	local buff = {};
	
	local name = OneRaid_Options_Frame_Buffs_NewBuff_Name;
	local groupName = OneRaid_Options_Frame_Buffs_NewBuff_GroupName;
	
	buff.standard = 1;
	buff.name = name:GetText();
	buff.groupName = groupName:GetText();
	
	if (buff.groupName == "") then
		buff.groupName = nil;
	end
	
	if (buff.name ~= "") then	
	
		local exists = nil;
		for k, v in OneRaid_Options.buffs do
			if (v.name == buff.name) then
				exists = k;
				break;
			end
		end
	
		if (exists) then
			OneRaid_Options.buffs[exists] = buff;
		else
			tinsert(OneRaid_Options.buffs, buff);
		end
		
		self:Buffs_OnUpdate();
		
	end
	
	name:SetText("");
	groupName:SetText("");
	name:ClearFocus();
	groupName:ClearFocus();
	
	self:UpdateAllBuffs();
	
	
end

function OneRaid.Options:DeleteBuff()

	local offset = FauxScrollFrame_GetOffset(OneRaid_Options_Frame_Buffs_List);
	
	tremove(OneRaid_Options.buffs, this:GetParent():GetID() + offset);
	
	self:Buffs_OnUpdate();
	self:UpdateAllBuffs();
	
end

function OneRaid.Options:UpdateAllBuffs()

	OneRaid:LoadBuffs();
	
	for k, v in OneRaid.Unit.frames do
		if (not v.inactive) then
			OneRaid.Unit:UpdateBuffs(v);
		end
	end
	
	for k, v in OneRaid.Group.frames do
		if (not v.inactive and OneRaid_Options.Groups[v.name].buffMonitor) then
			for i, j in v.frames do
				OneRaid.Group:UpdateBuffs(v, j.unit);
			end
			OneRaid.Group:SortFrame(v);
		end
	end

end

----Debuffs

function OneRaid.Options:DebuffCheck_OnEnter(check)
	
	if (check == "standard") then
		GameTooltip:SetOwner(this);
		GameTooltip:ClearLines();
		GameTooltip:AddLine(ONERAID_DEBUFF_IN_GROUP_WINDOWS);
	elseif (check == "debuffMonitor") then
		GameTooltip:SetOwner(this);
		GameTooltip:ClearLines();
		GameTooltip:AddLine(ONERAID_DEBUFF_IN_BUFF_MONITOR);
	elseif (check == "tankMonitor") then
		GameTooltip:SetOwner(this);
		GameTooltip:ClearLines();
		GameTooltip:AddLine(ONERAID_DEBUFF_IN_TANK_MONITOR);
	else
		GameTooltip:SetOwner(this);
		GameTooltip:ClearLines();
		GameTooltip:AddLine(string.format(ONERAID_INGORE_DEBUFF_MONITOR, check));
	end
	
	GameTooltip:Show();
	
end

function OneRaid.Options:DebuffCheck_OnCheck(check)

	local offset = FauxScrollFrame_GetOffset(OneRaid_Options_Frame_Debuffs_List);
	
	OneRaid_Options.debuffs[this:GetParent():GetID() + offset][check] = this:GetChecked();
	
	self:Debuffs_OnUpdate();
	self:UpdateAllDebuffs();


end

function OneRaid.Options:DebuffIcon(icon, parent)

	local offset = FauxScrollFrame_GetOffset(OneRaid_Options_Frame_Debuffs_List);
	
	OneRaid_Options.debuffs[parent:GetParent():GetID() + offset].icon = icon;
	
	self:Debuffs_OnUpdate();
	self:UpdateAllDebuffs();
	
end

function OneRaid.Options:AddDebuff()

	local debuff = {};
	
	local name = OneRaid_Options_Frame_Debuffs_NewDebuff_Name;
	
	debuff.standard = 1;
	debuff.name = name:GetText();
	
	if (debuff.name ~= "") then	
	
		local exists = nil;
		for k, v in OneRaid_Options.debuffs do
			if (v.name == debuff.name) then
				exists = k;
				break;
			end
		end
	
		if (exists) then
			OneRaid_Options.debuffs[exists] = debuff;
		else
			tinsert(OneRaid_Options.debuffs, debuff);
		end
		
		self:Debuffs_OnUpdate();
		
	end
	
	name:SetText("");
	name:ClearFocus();
	
	self:UpdateAllDebuffs();
	
end

function OneRaid.Options:DeleteDebuff()

	local offset = FauxScrollFrame_GetOffset(OneRaid_Options_Frame_Debuffs_List);
	
	tremove(OneRaid_Options.debuffs, this:GetParent():GetID() + offset);
	
	self:Debuffs_OnUpdate();
	
	self:UpdateAllDebuffs();
	
end

function OneRaid.Options:UpdateAllDebuffs()

	OneRaid:LoadBuffs();
	
	for k, v in OneRaid.Unit.frames do
		if (not v.inactive) then
			OneRaid.Unit:UpdateBuffs(v);
		end
	end
	
	for k, v in OneRaid.Group.frames do
		if (not v.inactive and OneRaid_Options.Groups[v.name].debuffMonitor) then
			for i, j in v.frames do
				OneRaid.Group:UpdateBuffs(v, j.unit);
			end
			OneRaid.Group:SortFrame(v);
		end
	end

end

---Cures

function OneRaid.Options:CureDebuffCheck_OnEnter(check, class)
	
	if (check == "ignore") then
		GameTooltip:SetOwner(this);
		GameTooltip:ClearLines();
		GameTooltip:AddLine(ONERAID_IGNORE_DEBUFF);
	elseif (check == "skip") then
		GameTooltip:SetOwner(this);
		GameTooltip:ClearLines();
		GameTooltip:AddLine(string.format(ONERAID_SKIP_DEBUFF_BY_CLASS, class));
	end
	
	GameTooltip:Show();
	
end

function OneRaid.Options:CureDebuffCheck_OnCheck(check, class)

	local offset = FauxScrollFrame_GetOffset(OneRaid_Options_Frame_CureDebuff_List);
	
	if (check == "ignore") then
		OneRaid_Options.cureDebuffs[this:GetParent():GetID() + offset][check] = this:GetChecked();
	elseif (check == "skip") then
		OneRaid_Options.cureDebuffs[this:GetParent():GetID() + offset][class] = this:GetChecked();
	end
	
	self:CureDebuffs_OnUpdate();
	self:UpdateAllDebuffs();


end

function OneRaid.Options:AddCureDebuff()

	local cure = {};
	
	local name = OneRaid_Options_Frame_CureOptions_NewCureDebuff_Name;
	
	cure.name = name:GetText();
	
	if (cure.name ~= "") then	
	
		local exists = nil;
		for k, v in OneRaid_Options.cureDebuffs do
			if (v.name == cure.name) then
				exists = k;
				break;
			end
		end
	
		if (exists) then
			OneRaid_Options.cureDebuffs[exists] = cure;
		else
			tinsert(OneRaid_Options.cureDebuffs, cure);
		end
		
		self:CureDebuffs_OnUpdate();
		
	end
	
	name:SetText("");
	name:ClearFocus();
	
	self:UpdateAllDebuffs();
	
end

function OneRaid.Options:DeleteCureDebuff()

	local offset = FauxScrollFrame_GetOffset(OneRaid_Options_Frame_CureOptions_CureDebuffs_List);
	
	tremove(OneRaid_Options.cureDebuffs, this:GetParent():GetID() + offset);
	
	self:CureDebuffs_OnUpdate();
	self:UpdateAllDebuffs();
	
end

----Cure Options

function OneRaid.Options:MoveDebuffPriority(direction, shift)

	local id = this:GetParent():GetID();
	
	local temp = OneRaid_Options.debuffPriority[id];
	
	if (shift) then

		if (direction == "up") then 
			for i = id - 1, 1, -1 do
			    OneRaid_Options.debuffPriority[i + 1] = OneRaid_Options.debuffPriority[i];
			end
			OneRaid_Options.debuffPriority[1] = temp;
		elseif (direction == "down") then
			for i = id + 1, 4 do
			    OneRaid_Options.debuffPriority[i - 1] = OneRaid_Options.debuffPriority[i];
			end
			OneRaid_Options.debuffPriority[4] = temp;
		end

	else

		local index;
		
		if (direction == "up") then 
			index = id - 1;
		elseif (direction == "down") then
			index = id + 1;
		end
		
		OneRaid_Options.debuffPriority[id] = OneRaid_Options.debuffPriority[index];
		OneRaid_Options.debuffPriority[index] = temp;
	
	end	
	
	self:DebuffPriority_OnUpdate();
	self:UpdateAllDebuffs();

end

function OneRaid.Options:MoveCurePriority(direction, shift)

	local offset = FauxScrollFrame_GetOffset(OneRaid_Options_Frame_CureOptions_CurePriority_List);
	local id = this:GetParent():GetID() + offset;	
	
	local temp = OneRaid_Options.curePriority[id];
	
	if (shift) then

		if (direction == "up") then 
			for i = id - 1, 1, -1 do
			    OneRaid_Options.curePriority[i + 1] = OneRaid_Options.curePriority[i];
			end
			OneRaid_Options.curePriority[1] = temp;
		elseif (direction == "down") then
			for i = id + 1, getn(OneRaid_Options.curePriority) do
			    OneRaid_Options.curePriority[i - 1] = OneRaid_Options.curePriority[i];
			end
			OneRaid_Options.curePriority[getn(OneRaid_Options.curePriority)] = temp;
		end

	else

		local index;
		
		if (direction == "up") then 
			index = id - 1;
		elseif (direction == "down") then
			index = id + 1;
		end
		
		OneRaid_Options.curePriority[id] = OneRaid_Options.curePriority[index];
		OneRaid_Options.curePriority[index] = temp;
	
	end	
	
	self:CurePriority_OnUpdate();

end

function OneRaid.Options:DeleteCurePriority()

	local offset = FauxScrollFrame_GetOffset(OneRaid_Options_Frame_CureOption_List);
	
	tremove(OneRaid_Options.curePriority, this:GetParent():GetID() + offset);
	
	self:CureOption_OnUpdate();

end

function OneRaid.Options:CurePriorityAddTarget()

	for k, v in OneRaid_Options.curePriority do
		if (UnitName("target") == v) then
			return;
		end
	end
	
	if (UnitName("target") and UnitName("target") ~= "") then
		tinsert(OneRaid_Options.curePriority, getn(OneRaid_Options.curePriority) + 1, UnitName("target"));
		self:CurePriority_OnUpdate();
	end

end

function OneRaid.Options:CureOption_OnCheck(option)

	OneRaid_Options[option] = this:GetChecked();

end

------------General

function OneRaid.Options:MoveClassPriority(direction, shift)

	local id = this:GetParent():GetID();
	
	local temp = OneRaid_Options.classPriority[id];
	
	if (shift) then

		if (direction == "up") then 
			for i = id - 1, 1, -1 do
			    OneRaid_Options.classPriority[i + 1] = OneRaid_Options.classPriority[i];
			end
			OneRaid_Options.classPriority[1] = temp;
		elseif (direction == "down") then
			for i = id + 1, 9 do
			    OneRaid_Options.classPriority[i - 1] = OneRaid_Options.classPriority[i];
			end
			OneRaid_Options.classPriority[9] = temp;
		end

	else

		local index;
		
		if (direction == "up") then 
			index = id - 1;
		elseif (direction == "down") then
			index = id + 1;
		end
		
		OneRaid_Options.classPriority[id] = OneRaid_Options.classPriority[index];
		OneRaid_Options.classPriority[index] = temp;
	
	end	
	
	self:ClassPriority_OnUpdate();
	OneRaid:LoadClassPriority();
	
	for k, v in OneRaid.Group.frames do
		if (not v.inactive and not OneRaid_Options.Groups[v.name].tankMonitor and OneRaid_Options.Groups[v.name].sorting.class) then
			OneRaid.Group:SortFrame(v);
		end
	end

end

function OneRaid.Options:Buffs_OnUpdate()
	
	local offset = FauxScrollFrame_GetOffset(OneRaid_Options_Frame_Buffs_List);
	
	FauxScrollFrame_Update(OneRaid_Options_Frame_Buffs_List, getn(OneRaid_Options.buffs), 8, 41)

	for i = 1, 8 do
		local index = offset + i;

		local item 			= getglobal("OneRaid_Options_Frame_Buffs_Buff" .. i);
		local name 			= getglobal(item:GetName() .. "_Name");
		local singleName 	= getglobal(item:GetName() .. "_SingleName");
		local groupName 	= getglobal(item:GetName() .. "_GroupName");
		local standard 		= getglobal(item:GetName() .. "_Standard");
		local buff 			= getglobal(item:GetName() .. "_BuffMonitor");
		local tank 			= getglobal(item:GetName() .. "_TankMonitor");
		local dropdownText 	= getglobal(item:GetName() .. "_DropDownText");
		local warrior 		= getglobal(item:GetName() .. "_IgnoreWarriors");
		local paladin 		= getglobal(item:GetName() .. "_IgnorePaladins");
		local shaman 		= getglobal(item:GetName() .. "_IgnoreShamans");
		local priest 		= getglobal(item:GetName() .. "_IgnorePriests");
		local druid 		= getglobal(item:GetName() .. "_IgnoreDruids");
		local mage 			= getglobal(item:GetName() .. "_IgnoreMages");
		local warlock 		= getglobal(item:GetName() .. "_IgnoreWarlocks");
		local hunter 		= getglobal(item:GetName() .. "_IgnoreHunters");
		local rogue 		= getglobal(item:GetName() .. "_IgnoreRogues");
		local delete 		= getglobal(item:GetName() .. "_Delete");

		if (index <= getn(OneRaid_Options.buffs)) then
			item:Show();
			
			local option = OneRaid_Options.buffs[index];
			
			if (option.groupName) then
				name:SetText("");
				singleName:SetText(option.name);
				groupName:SetText(option.groupName);
			else
				name:SetText(option.name);
				singleName:SetText("");
				groupName:SetText("");
			end
			
			standard:SetChecked(option.standard);
			buff:SetChecked(option.buffMonitor);
			tank:SetChecked(option.tankMonitor);
			warrior:SetChecked(option[ONERAID_WARRIOR]);
			paladin:SetChecked(option[ONERAID_PALADIN]);
			shaman:SetChecked(option[ONERAID_SHAMAN]);
			priest:SetChecked(option[ONERAID_PRIEST]);
			druid:SetChecked(option[ONERAID_DRUID]);
			mage:SetChecked(option[ONERAID_MAGE]);
			warlock:SetChecked(option[ONERAID_WARLOCK]);
			hunter:SetChecked(option[ONERAID_HUNTER]);
			rogue:SetChecked(option[ONERAID_ROGUE]);
			
			dropdownText:SetText(OneRaid_Options.buffs[index].icon or "None");
			
			if (mod(i, 2) == 0) then
				item:SetBackdropColor(1, 1, 1, .2);
			else
				item:SetBackdropColor(0, 0, 0, 0);
			end
			
			if (OneRaid_Options.buffs[index].readonly) then
				delete:Hide();
			else
				delete:Show();
			end
		else
			item:Hide();
		end
	end

	OneRaid_Options_Frame_Buffs_List:Show();

end

function OneRaid.Options:Debuffs_OnUpdate()
	
	local offset = FauxScrollFrame_GetOffset(OneRaid_Options_Frame_Debuffs_List);
	
	FauxScrollFrame_Update(OneRaid_Options_Frame_Debuffs_List, getn(OneRaid_Options.debuffs), 8, 41)

	for i = 1, 8 do
		local index = offset + i;

		local item 			= getglobal("OneRaid_Options_Frame_Debuffs_Debuff" .. i);
		local name 			= getglobal(item:GetName() .. "_Name");
		local standard 		= getglobal(item:GetName() .. "_Standard");
		local debuff 		= getglobal(item:GetName() .. "_DebuffMonitor");
		local tank 			= getglobal(item:GetName() .. "_TankMonitor");
		local dropdownText 	= getglobal(item:GetName() .. "_DropDownText");
		local warrior 		= getglobal(item:GetName() .. "_IgnoreWarriors");
		local paladin 		= getglobal(item:GetName() .. "_IgnorePaladins");
		local shaman 		= getglobal(item:GetName() .. "_IgnoreShamans");
		local priest 		= getglobal(item:GetName() .. "_IgnorePriests");
		local druid 		= getglobal(item:GetName() .. "_IgnoreDruids");
		local mage 			= getglobal(item:GetName() .. "_IgnoreMages");
		local warlock 		= getglobal(item:GetName() .. "_IgnoreWarlocks");
		local hunter 		= getglobal(item:GetName() .. "_IgnoreHunters");
		local rogue 		= getglobal(item:GetName() .. "_IgnoreRogues");
		local delete 		= getglobal(item:GetName() .. "_Delete");

		if (index <= getn(OneRaid_Options.debuffs)) then
			
			item:Show();
			
			local option = OneRaid_Options.debuffs[index];
			
			name:SetText(option.name);
			standard:SetChecked(option.standard);
			debuff:SetChecked(option.debuffMonitor);
			tank:SetChecked(option.tankMonitor);
			warrior:SetChecked(option[ONERAID_WARRIOR]);
			paladin:SetChecked(option[ONERAID_PALADIN]);
			shaman:SetChecked(option[ONERAID_SHAMAN]);
			priest:SetChecked(option[ONERAID_PRIEST]);
			druid:SetChecked(option[ONERAID_DRUID]);
			mage:SetChecked(option[ONERAID_MAGE]);
			warlock:SetChecked(option[ONERAID_WARLOCK]);
			hunter:SetChecked(option[ONERAID_HUNTER]);
			rogue:SetChecked(option[ONERAID_ROGUE]);
			
			dropdownText:SetText(option.icon or "None");
			
			if (mod(i, 2) == 0) then
				item:SetBackdropColor(1, 1, 1, .2);
			else
				item:SetBackdropColor(0, 0, 0, 0);
			end
			
			if (OneRaid_Options.debuffs[index].readonly) then
				delete:Hide();
			else
				delete:Show();
			end
		else
			item:Hide();
		end
	end

	OneRaid_Options_Frame_Debuffs_List:Show();

end

function OneRaid.Options:CureDebuffs_OnUpdate()
	
	local offset = FauxScrollFrame_GetOffset(OneRaid_Options_Frame_CureOptions_CureDebuffs_List);
	
	FauxScrollFrame_Update(OneRaid_Options_Frame_CureOptions_CureDebuffs_List, getn(OneRaid_Options.cureDebuffs), 8, 20)

	for i = 1, 8 do
		local index = offset + i;

		local item = getglobal("OneRaid_Options_Frame_CureOptions_CureDebuff" .. i);
		local name = getglobal(item:GetName() .. "_Name");
		local ignore = getglobal(item:GetName() .. "_Ignore");
		local warrior = getglobal(item:GetName() .. "_SkipWarrior");
		local paladin = getglobal(item:GetName() .. "_SkipPaladin");
		local shaman = getglobal(item:GetName() .. "_SkipShaman");
		local priest = getglobal(item:GetName() .. "_SkipPriest");
		local druid = getglobal(item:GetName() .. "_SkipDruid");
		local mage = getglobal(item:GetName() .. "_SkipMage");
		local warlock = getglobal(item:GetName() .. "_SkipWarlock");
		local hunter = getglobal(item:GetName() .. "_SkipHunter");
		local rogue = getglobal(item:GetName() .. "_SkipRogue");
		local delete = getglobal(item:GetName() .. "_Delete");

		if (index <= getn(OneRaid_Options.cureDebuffs)) then
			
			local option = OneRaid_Options.cureDebuffs[index];
			item:Show();
			
			name:SetText(option.name);
			ignore:SetChecked(option.ignore);
			warrior:SetChecked(option[ONERAID_WARRIOR]);
			paladin:SetChecked(option[ONERAID_PALADIN]);
			shaman:SetChecked(option[ONERAID_SHAMAN]);
			priest:SetChecked(option[ONERAID_PRIEST]);
			druid:SetChecked(option[ONERAID_DRUID]);
			mage:SetChecked(option[ONERAID_MAGE]);
			warlock:SetChecked(option[ONERAID_WARLOCK]);
			hunter:SetChecked(option[ONERAID_HUNTER]);
			rogue:SetChecked(option[ONERAID_ROGUE]);
			
			if (mod(i, 2) == 0) then
				item:SetBackdropColor(1, 1, 1, .2);
			else
				item:SetBackdropColor(0, 0, 0, 0);
			end
			
			if (option.readonly) then
				delete:Hide();
			else
				delete:Show();
			end
		else
			item:Hide();
		end
	end

	OneRaid_Options_Frame_CureOptions_CureDebuffs_List:Show();

end

function OneRaid.Options:DebuffPriority_OnUpdate()

	for i = 1, 4 do
		local item = getglobal("OneRaid_Options_Frame_General_DebuffPriority" .. i .."_Text");
		item:SetText(OneRaid_Options.debuffPriority[i]);
	end
	
end

function OneRaid.Options:ClassPriority_OnUpdate()

	for i = 1, 9 do
		local item = getglobal("OneRaid_Options_Frame_General_ClassPriority" .. i .."_Text");
		item:SetText(OneRaid_Options.classPriority[i]);
	end
	
end

function OneRaid.Options:CurePriority_OnUpdate()
	
	local offset = FauxScrollFrame_GetOffset(OneRaid_Options_Frame_CureOptions_CurePriority_List);
	
	FauxScrollFrame_Update(OneRaid_Options_Frame_CureOptions_CurePriority_List, getn(OneRaid_Options.curePriority), 5, 20)

	for i = 1, 5 do
		local index = offset + i;

		local item = getglobal("OneRaid_Options_Frame_CureOptions_CurePriority" .. i);
		local text = getglobal(item:GetName() .. "_Text");
		local up = getglobal(item:GetName() .. "_Up");
		local down = getglobal(item:GetName() .. "_Down");
		local delete = getglobal(item:GetName() .. "_Delete");

		if (index <= getn(OneRaid_Options.curePriority)) then
			
			local option = OneRaid_Options.curePriority[index];
			item:Show();
			
			text:SetText(option);
			
			if (index == 1) then
				up:Hide();
			else
				up:Show();
			end
			
			if (index == getn(OneRaid_Options.curePriority)) then
				down:Hide();
			else
				down:Show();
			end

		else
			item:Hide();
		end
	end

	OneRaid_Options_Frame_CureOptions_CurePriority_List:Show();

end

function OneRaid.Options:BuffIcon_DropDown_OnLoad()
	
	getglobal(this:GetName() .. "Text"):SetText("None");
	UIDropDownMenu_Initialize(this, function() self:BuffIcon_DropDown_Init(); end);
	UIDropDownMenu_SetWidth(75);

end

function OneRaid.Options:BuffIcon_DropDown_Init()

	for i = 1, 8 do
		local buttonInfo = UnitPopupButtons["RAID_TARGET_" .. i];
		
		local info = {};
		info.text = buttonInfo.text;
		info.arg1 = buttonInfo.text;
		info.arg2 = this:GetParent();
		info.textR = buttonInfo.color.r;
		info.textG = buttonInfo.color.g;
		info.textB = buttonInfo.color.b;		
		info.icon = buttonInfo.icon;
		info.tCoordLeft = buttonInfo.tCoordLeft;
		info.tCoordRight = buttonInfo.tCoordRight;
		info.tCoordTop = buttonInfo.tCoordTop;
		info.tCoordBottom = buttonInfo.tCoordBottom;
		info.value = i;
		info.func = function(arg1, arg2)
			OneRaid.Options:BuffIcon(arg1, arg2);
		end
		UIDropDownMenu_AddButton(info);
	end
	
	local info = {};
	info.text = "None";
	info.arg1 = "None";
	info.arg2 = this:GetParent();
	info.func = function(arg1, arg2)
		OneRaid.Options:BuffIcon(arg1, arg2);
	end
	UIDropDownMenu_AddButton(info);
	
end

function OneRaid.Options:DebuffIcon_DropDown_OnLoad()
	
	getglobal(this:GetName() .. "Text"):SetText("None");
	UIDropDownMenu_Initialize(this, function() self:DebuffIcon_DropDown_Init(); end);
	UIDropDownMenu_SetWidth(75);

end

function OneRaid.Options:DebuffIcon_DropDown_Init()
	
	for i = 1, 8 do
		local buttonInfo = UnitPopupButtons["RAID_TARGET_" .. i];
		
		local info = {};
		info.text = buttonInfo.text;
		info.arg1 = buttonInfo.text;
		info.arg2 = this:GetParent();
		info.textR = buttonInfo.color.r;
		info.textG = buttonInfo.color.g;
		info.textB = buttonInfo.color.b;		
		info.icon = buttonInfo.icon;
		info.tCoordLeft = buttonInfo.tCoordLeft;
		info.tCoordRight = buttonInfo.tCoordRight;
		info.tCoordTop = buttonInfo.tCoordTop;
		info.tCoordBottom = buttonInfo.tCoordBottom;
		info.value = i;
		info.func = function(arg1, arg2)
			OneRaid.Options:DebuffIcon(arg1, arg2);
		end
		UIDropDownMenu_AddButton(info);
	end
	
	local info = {};
	info.text = "None";
	info.arg1 = "None";
	info.arg2 = this:GetParent();
	info.func = function(arg1, arg2)
		OneRaid.Options:DebuffIcon(arg1, arg2);
	end
	UIDropDownMenu_AddButton(info);
	
end

function OneRaid.Options:CurePriority_DropDown_OnLoad()
	
	getglobal(this:GetName() .. "Text"):SetText("Quick add");
	UIDropDownMenu_Initialize(this, function() self:CurePriority_DropDown_Init(); end);
	UIDropDownMenu_SetWidth(150);

end

function OneRaid.Options:CurePriority_DropDown_Init()

	local list = {
		ONERAID_GROUP1, ONERAID_GROUP2, ONERAID_GROUP3, ONERAID_GROUP4, ONERAID_GROUP5, ONERAID_GROUP6, ONERAID_GROUP7, ONERAID_GROUP8,
		ONERAID_WARRIOR, ONERAID_PALADIN, ONERAID_SHAMAN, ONERAID_PRIEST, ONERAID_DRUID, ONERAID_MAGE, ONERAID_WARLOCK, ONERAID_HUNTER, ONERAID_ROGUE
	};
	
	for k, v in list do
		local info = {};
		info.text = v;
		info.arg1 = v;
		info.arg2 = k;
		info.func = function(arg1, arg2)
			if (arg2 <= 8) then
				for i = 1, GetNumRaidMembers() do
					local name, rank, subgroup = GetRaidRosterInfo(i);
					if (subgroup == arg2) then
						
						local found = nil;
						
						for m, n in OneRaid_Options.curePriority do
							if (name == n) then
								found = 1;
								break;
							end
						end
						
						if (not found) then
							tinsert(OneRaid_Options.curePriority, name);
						end
					end
				end
			else
				for i = 1, GetNumRaidMembers() do
					local name, rank, subgroup, level, class = GetRaidRosterInfo(i);
					if (class == arg1) then
						
						local found = nil;
						
						for m, n in OneRaid_Options.curePriority do
							if (name == n) then
								found = 1;
								break;
							end
						end
						
						if (not found) then
							tinsert(OneRaid_Options.curePriority, name);
						end
					end
				end
			end
			OneRaid.Options:CurePriority_OnUpdate();
		end
		UIDropDownMenu_AddButton(info);
	end	
	
end

function OneRaid.Options:Color_OnClick(color, opacity)

	local lColor = {};
	
	self.selectedColor = color;
	self.normalTexture = getglobal(this:GetName() .. "NormalTexture");
	
	if (not lColor) then
		lColor = { r = 1, g = 1, b = 1 };
	end

	lColor.r = OneRaid_Options[color].r;
	lColor.g = OneRaid_Options[color].g;
	lColor.b = OneRaid_Options[color].b;
	
	lColor.swatchFunc = function() self:Color_SetColor(); end;
	lColor.cancelFunc = function() self:Color_CancelColor(opacity); end;
	lColor.opacityFunc = function() self:Color_SetOpacity(); end;
	
	if (opacity) then
		lColor.hasOpacity = 1;
		lColor.opacity = OneRaid_Options[color].a or 0;
		lColor.opacity = 1 - lColor.opacity;
		lColor.opacityFunc = function() self:Color_SetOpacity(); end;
	end	
	
	CloseMenus();
	UIDropDownMenuButton_OpenColorPicker(lColor);

end

function OneRaid.Options:Color_SetColor()

	local r, g, b = ColorPickerFrame:GetColorRGB();

	OneRaid_Options[self.selectedColor].r = r;
	OneRaid_Options[self.selectedColor].g = g;
	OneRaid_Options[self.selectedColor].b = b;

	self.normalTexture:SetVertexColor(r, g, b);
	
end

function OneRaid.Options:Color_SetOpacity()

	local a = 1 - OpacitySliderFrame:GetValue();

	OneRaid_Options[self.selectedColor].a = a;
	
end

function OneRaid.Options:Color_CancelColor(opacity)

	OneRaid_Options[self.selectedColor].r = ColorPickerFrame.previousValues.r;
	OneRaid_Options[self.selectedColor].g = ColorPickerFrame.previousValues.g;
	OneRaid_Options[self.selectedColor].b = ColorPickerFrame.previousValues.b;

	if (opacity) then
		OneRaid_Options[self.selectedColor].a = 1 - ColorPickerFrame.previousValues.opacity;
	end

 	self.normalTexture:SetVertexColor(
 		OneRaid_Options[self.selectedColor].r,
		OneRaid_Options[self.selectedColor].g,
		OneRaid_Options[self.selectedColor].b
 	);

end