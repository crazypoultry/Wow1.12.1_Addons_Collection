OneRaid.GroupOptions 			= {
	players 					= {},
};

function OneRaid.GroupOptions:OnLoad()

	getglobal(this:GetName() .. "_Header_Background"):SetVertexColor(.4, 0, 0, 1);
	this:SetBackdropColor(0, 0, 0, .75);
	this:SetBackdropBorderColor(0, 0, 0, 0);

end

function OneRaid.GroupOptions:OnMouseDown()

	this:StartMoving();
	
end

function OneRaid.GroupOptions:OnMouseUp()

	this:StopMovingOrSizing();
	
end

-------------

function OneRaid.GroupOptions:EditGroup(name)

	local options = OneRaid_Options.Groups[name];
	
	if (not options) then return; end
	
	OneRaid_GroupOptions_Frame_Header_Text:SetText(ONERAID_GROUP_OPTIONS .. " - " .. name);
	
	OneRaid_GroupOptions_Frame_Group_DropDownText:SetText(name);
	
	self.edit = name;	
	
	self:LoadData(name);

	OneRaid_GroupOptions_Frame:Show();
	
end

function OneRaid.GroupOptions:NewGroup()

	local i = 1;
	
	while (getglobal("OneRaid_Group_Custom" .. i)) do
		i = i + 1;
	end
	
	local name = "Custom" .. i;

	OneRaid_Options.Groups[name] = {
		name = name,
		style = "Default",
		filters = { groups = {}, classes = {}, players = {}, dead = {}, offline = {}, health = {} },
		sorting = {},
		scale = 1,
	};
	OneRaid.Group:CreateFrame(name, OneRaid_Options.Groups[name].style);
	
	self:EditGroup(name);
	
	OneRaid_GroupOptions_Frame:Show();

end

function OneRaid.GroupOptions:DeleteGroup()

	if (OneRaid_Options.Groups[self.edit].tankMonitor) then
		OneRaid.Group:DeactivateTankMonitorFrame(self.edit);
	else
		OneRaid.Group:DeactivateFrame(self.edit);
	end
	OneRaid_Options.Groups[self.edit] = nil;
	
	for k, v in OneRaid_Options.Groups do
		self:EditGroup(k);
		break;
	end
		
end

function OneRaid.GroupOptions:SetTitleOption(option)

	if (not OneRaid_Options) then return; end
	
	if (this:GetObjectType() == "CheckButton") then
	
		OneRaid_Options.Groups[self.edit][option] = this:GetChecked();
		
		OneRaid.Group:UpdateFrame(getglobal("OneRaid_Group_" .. self.edit));
	
	elseif (this:GetObjectType() == "EditBox") then
		
		if (option == "name") then
			
			if (OneRaid_Options.Groups[this:GetText()]) then
				OneRaid:Print(ONERAID_GROUP_EXISTS);
				this:SetText(self.edit);				
				return;
			end
			
			OneRaid_Options.Groups[this:GetText()] = OneRaid_Options.Groups[self.edit];
			OneRaid_Options.Groups[this:GetText()].name = this:GetText();
			
			OneRaid.Group:DeactivateFrame(self.edit);
			OneRaid_Options.Groups[self.edit] = nil;
			
			OneRaid.Group:CreateFrame(this:GetText(), OneRaid_Options.Groups[this:GetText()].style);
			
			self:EditGroup(this:GetText());
		end
		
		this:ClearFocus();
	
	end
	
end

function OneRaid.GroupOptions:SetDisplayOption(option)

	if (not OneRaid_Options) then return; end
	
	if (this:GetObjectType() == "CheckButton") then
	
		OneRaid_Options.Groups[self.edit][option] = this:GetChecked();
		
		if (option == "hide") then
			if (OneRaid_Options.Groups[self.edit].buffMonitor or OneRaid_Options.Groups[self.edit].debuffMonitor) then
				for k, v in getglobal("OneRaid_Group_" .. self.edit).frames do
					OneRaid.Group:UpdateBuffs(getglobal("OneRaid_Group_" .. self.edit), v.unit);
				end
			end
			OneRaid.Group:Filter(getglobal("OneRaid_Group_" .. self.edit));
		end
		
		OneRaid.Group:UpdateFrame(getglobal("OneRaid_Group_" .. self.edit));
		
	elseif (this:GetObjectType() == "Slider") then
		
		OneRaid_Options.Groups[self.edit][option] = this:GetValue();
		
		local val = string.format("%.2f", this:GetValue());
		getglobal(this:GetName() .. "Text"):SetText("|cFFFFFFFF" .. ONERAID_SCALE .. ": " .. val);
				
		OneRaid.Group:LoadFrame(getglobal("OneRaid_Group_" .. self.edit));
		
	end
	
end

function OneRaid.GroupOptions:SetGroupsOption(option)

	if (not OneRaid_Options) then return; end
	
	OneRaid_Options.Groups[self.edit].filters.groups[option] = this:GetChecked();
		
	OneRaid.Group:Filter(getglobal("OneRaid_Group_" .. self.edit));

end

function OneRaid.GroupOptions:SetClassesOption(option)

	if (not OneRaid_Options) then return; end
	
	OneRaid_Options.Groups[self.edit].filters.classes[option] = this:GetChecked();
		
	OneRaid.Group:Filter(getglobal("OneRaid_Group_" .. self.edit));

end

function OneRaid.GroupOptions:SetDeadOption()

	if (this:GetChecked()) then
		OneRaid_GroupOptions_Frame_Dead_Hide:SetChecked(nil);
		OneRaid_GroupOptions_Frame_Dead_Only:SetChecked(nil);
		this:SetChecked(1);
	end
			
	OneRaid_Options.Groups[self.edit].filters.dead.hide = OneRaid_GroupOptions_Frame_Dead_Hide:GetChecked();
	OneRaid_Options.Groups[self.edit].filters.dead.only = OneRaid_GroupOptions_Frame_Dead_Only:GetChecked();
	
	OneRaid.Group:SortFrame(getglobal("OneRaid_Group_" .. self.edit));

end

function OneRaid.GroupOptions:SetOfflineOption()

	if (this:GetChecked()) then
		OneRaid_GroupOptions_Frame_Offline_Hide:SetChecked(nil);
		OneRaid_GroupOptions_Frame_Offline_Only:SetChecked(nil);
		this:SetChecked(1);
	end
	
	OneRaid_Options.Groups[self.edit].filters.offline.hide = OneRaid_GroupOptions_Frame_Offline_Hide:GetChecked();
	OneRaid_Options.Groups[self.edit].filters.offline.only = OneRaid_GroupOptions_Frame_Offline_Only:GetChecked();
	
	OneRaid.Group:SortFrame(getglobal("OneRaid_Group_" .. self.edit));

end

function OneRaid.GroupOptions:SetHealthOption(option)

	if (not OneRaid_Options) then return; end
	
	if (this:GetObjectType() == "CheckButton") then
	
		if (this:GetChecked()) then
			OneRaid_Options.Groups[self.edit].filters.health[option] = tonumber(getglobal(this:GetName() .. "Num"):GetText());
			
		else
			OneRaid_Options.Groups[self.edit].filters.health[option] = nil;
		end
		
	elseif (this:GetObjectType() == "EditBox") then
	
		if (this:GetText() == "" or not tonumber(this:GetText()) or tonumber(this:GetText()) < 0 or tonumber(this:GetText()) > 100) then
			if (option == "max") then
				this:SetText(OneRaid_Options.Groups[self.edit].filters.health[option] or "100");
			elseif (option == "min") then
				this:SetText(OneRaid_Options.Groups[self.edit].filters.health[option] or "0");
			end
		else
			if (OneRaid_Options.Groups[self.edit].filters.health[option]) then
				OneRaid_Options.Groups[self.edit].filters.health[option] = tonumber(this:GetText());
			end
		end
		
		this:ClearFocus();
	
	end
		
	OneRaid.Group:Filter(getglobal("OneRaid_Group_" .. self.edit));

end

function OneRaid.GroupOptions:SetSortOption(option)

	if (option == "alpha" or option == "class" or option == "health" or option == "group") then
	
		if (this:GetChecked()) then
			OneRaid_GroupOptions_Frame_Sort_Alpha:SetChecked(nil);
			OneRaid_GroupOptions_Frame_Sort_Class:SetChecked(nil);
			OneRaid_GroupOptions_Frame_Sort_Health:SetChecked(nil);
			OneRaid_GroupOptions_Frame_Sort_Group:SetChecked(nil);
			this:SetChecked(1);
		end
		
		OneRaid_Options.Groups[self.edit].sorting.alpha = OneRaid_GroupOptions_Frame_Sort_Alpha:GetChecked();
		OneRaid_Options.Groups[self.edit].sorting.class = OneRaid_GroupOptions_Frame_Sort_Class:GetChecked();
		OneRaid_Options.Groups[self.edit].sorting.health = OneRaid_GroupOptions_Frame_Sort_Health:GetChecked();
		OneRaid_Options.Groups[self.edit].sorting.group = OneRaid_GroupOptions_Frame_Sort_Group:GetChecked();
	
	else
	
		OneRaid_Options.Groups[self.edit].sorting[option] = this:GetChecked();
	
	end
	
	OneRaid.Group:SortFrame(getglobal("OneRaid_Group_" .. self.edit));

end

function OneRaid.GroupOptions:SetLayoutOption(option)

	if (not OneRaid_Options) then return; end
	
	if (this:GetObjectType() == "CheckButton") then
	
		if (option == "grid" or option == "limit") then
			if (this:GetChecked()) then
				OneRaid_Options.Groups[self.edit][option] = tonumber(getglobal(this:GetName() .. "Num"):GetText());
				
			else
				OneRaid_Options.Groups[self.edit][option] = nil;
			end
		else
			OneRaid_Options.Groups[self.edit][option] = this:GetChecked();
		end
		
		if (option == "limit") then
			OneRaid.Group:SortFrame(getglobal("OneRaid_Group_" .. self.edit));
		else
			OneRaid.Group:UpdatePosition(getglobal("OneRaid_Group_" .. self.edit));
			OneRaid.Group:LoadFrame(getglobal("OneRaid_Group_" .. self.edit));
			OneRaid.Group:Filter(getglobal("OneRaid_Group_" .. self.edit));
			if (OneRaid_Options.Groups[self.edit].buffMonitor or OneRaid_Options.Groups[self.edit].debuffMonitor) then
				for i, j in pairs(getglobal("OneRaid_Group_" .. self.edit).frames) do
					OneRaid.Group:UpdateBuffs(getglobal("OneRaid_Group_" .. self.edit), j.unit);
				end
			end
			OneRaid.Group:SortFrame(getglobal("OneRaid_Group_" .. self.edit));
			OneRaid.Group:UpdateFrame(getglobal("OneRaid_Group_" .. self.edit));
		end
		
	elseif (this:GetObjectType() == "EditBox") then
	
		if (this:GetText() == "" or not tonumber(this:GetText()) or tonumber(this:GetText()) <= 0) then
			this:SetText(OneRaid_Options.Groups[self.edit][option] or 1);
		else
			if (OneRaid_Options.Groups[self.edit][option]) then
				OneRaid_Options.Groups[self.edit][option] = tonumber(this:GetText());
			end
		end
		
		OneRaid.Group:LoadFrame(getglobal("OneRaid_Group_" .. self.edit));
		OneRaid.Group:UpdateFrame(getglobal("OneRaid_Group_" .. self.edit));
		
		this:ClearFocus();
	
	end	

end

function OneRaid.GroupOptions:SetMonitorOption(option)

	local buffMonitor = OneRaid_Options.Groups[self.edit].buffMonitor;
	local debuffMonitor = OneRaid_Options.Groups[self.edit].debuffMonitor;
	local tankMonitor = OneRaid_Options.Groups[self.edit].tankMonitor;
	
	if (this:GetChecked()) then
		OneRaid_GroupOptions_Frame_Monitor_BuffMonitor:SetChecked(nil);
		OneRaid_GroupOptions_Frame_Monitor_DebuffMonitor:SetChecked(nil);
		OneRaid_GroupOptions_Frame_Monitor_TankMonitor:SetChecked(nil);
		this:SetChecked(1);
	end
	
	OneRaid_Options.Groups[self.edit].buffMonitor 	= OneRaid_GroupOptions_Frame_Monitor_BuffMonitor:GetChecked();
	OneRaid_Options.Groups[self.edit].debuffMonitor = OneRaid_GroupOptions_Frame_Monitor_DebuffMonitor:GetChecked();
	OneRaid_Options.Groups[self.edit].tankMonitor 	= OneRaid_GroupOptions_Frame_Monitor_TankMonitor:GetChecked();
	
	if (tankMonitor) then
		OneRaid.Group:DeactivateTankMonitorFrame(self.edit);
	else
		OneRaid.Group:DeactivateFrame(self.edit);
	end
	
	OneRaid.Group:CreateFrame(self.edit, OneRaid_Options.Groups[self.edit].style);

end

function OneRaid.GroupOptions:AddPlayer()

	local name = this:GetText();
	
	if (name ~= "") then
	
		if (not OneRaid_Options.Groups[self.edit].filters.players[name]) then
			OneRaid_Options.Groups[self.edit].filters.players[name] = 1;
		end
		
		self:Players_OnUpdate();
		OneRaid.Group:Filter(getglobal("OneRaid_Group_" .. self.edit));
		
	end
	
	this:SetText("");
	this:ClearFocus();
	
end

function OneRaid.GroupOptions:DeletePlayer()

	local name = getglobal(this:GetParent():GetName() .. "_Text"):GetText();
	
	OneRaid_Options.Groups[self.edit].filters.players[name] = nil;
	
	self:Players_OnUpdate();
	OneRaid.Group:Filter(getglobal("OneRaid_Group_" .. self.edit));

end

function OneRaid.GroupOptions:Players_OnUpdate()

	local list = {};
		
	for k, v in OneRaid_Options.Groups[self.edit].filters.players do
		tinsert(list, k);
	end
	
	local offset = FauxScrollFrame_GetOffset(OneRaid_GroupOptions_Frame_Players_List);
	
	FauxScrollFrame_Update(OneRaid_GroupOptions_Frame_Players_List, getn(list), 5, 20)

	for i = 1, 5 do
		local index = offset + i;

		local item = getglobal("OneRaid_GroupOptions_Frame_Players_Player" .. i);
		local text = getglobal(item:GetName() .. "_Text");

		if (index <= getn(list)) then
			item:Show();
			text:SetText(list[index]);
		else
			item:Hide();
		end
	end

	OneRaid_GroupOptions_Frame_Players_List:Show();

end

function OneRaid.GroupOptions:LoadDefaultGroups()

	for k, v in OneRaid.Group.frames do
		if (not v.inactive) then
			if (OneRaid_Options.Groups[v.name].tankMonitor) then
				OneRaid.Group:DeactivateTankMonitorFrame(v.name);
			else
				OneRaid.Group:DeactivateFrame(v.name);
			end			
		end
	end

	for k, v in OneRaid_DefaultOptions.Groups do
		OneRaid_Options.Groups[k] = v;
		OneRaid.Group:CreateFrame(v.name, v.style);
	end

end

function OneRaid.GroupOptions:LoadData(group)

	local options = OneRaid_Options.Groups[group];
	local filters = options.filters;
	local sorting = options.sorting;
	
	OneRaid_GroupOptions_Frame_TitlePanel_Name:SetText(options.name);
	OneRaid_GroupOptions_Frame_TitlePanel_TitleTextColorNormalTexture:SetVertexColor(options.titleTextColor.r, options.titleTextColor.g, options.titleTextColor.b);
	OneRaid_GroupOptions_Frame_TitlePanel_TitleBgColorNormalTexture:SetVertexColor(options.titleBgColor.r, options.titleBgColor.g, options.titleBgColor.b);		
	OneRaid_GroupOptions_Frame_TitlePanel_TitleTextUseClassColor:SetChecked(options.titleTextUseClassColor);
	OneRaid_GroupOptions_Frame_TitlePanel_TitleBgUseClassColor:SetChecked(options.titleBgUseClassColor);
	OneRaid_GroupOptions_Frame_TitlePanel_TitleSize:SetChecked(options.titleSize);
	
	OneRaid_GroupOptions_Frame_UnitStyle_DropDownText:SetText(options.style);
	
	OneRaid_GroupOptions_Frame_Display_Locked:SetChecked(options.locked);
	OneRaid_GroupOptions_Frame_Display_EnableGroupToggle:SetChecked(options.enableGroupToggle);
	OneRaid_GroupOptions_Frame_Display_Hide:SetChecked(options.hide);
	OneRaid_GroupOptions_Frame_Display_HideWhenEmpty:SetChecked(options.hideWhenEmpty);
	OneRaid_GroupOptions_Frame_Display_HideWhenNotInRaid:SetChecked(options.hideWhenNotInRaid);
	OneRaid_GroupOptions_Frame_Display_HideWhenInRaid:SetChecked(options.hideWhenInRaid);
	OneRaid_GroupOptions_Frame_Display_BgUseClassColor:SetChecked(options.bgUseClassColor);
	OneRaid_GroupOptions_Frame_Display_Scale:SetValue(options.scale);
	OneRaid_GroupOptions_Frame_Display_BgColorNormalTexture:SetVertexColor(options.bgColor.r, options.bgColor.g, options.bgColor.b);
	
	OneRaid_GroupOptions_Frame_Classes_Warrior:SetChecked(filters.classes.Warrior);
	OneRaid_GroupOptions_Frame_Classes_Paladin:SetChecked(filters.classes.Paladin);
	OneRaid_GroupOptions_Frame_Classes_Shaman:SetChecked(filters.classes.Shaman);
	OneRaid_GroupOptions_Frame_Classes_Priest:SetChecked(filters.classes.Priest);
	OneRaid_GroupOptions_Frame_Classes_Druid:SetChecked(filters.classes.Druid);
	OneRaid_GroupOptions_Frame_Classes_Mage:SetChecked(filters.classes.Mage);
	OneRaid_GroupOptions_Frame_Classes_Warlock:SetChecked(filters.classes.Warlock);
	OneRaid_GroupOptions_Frame_Classes_Hunter:SetChecked(filters.classes.Hunter);
	OneRaid_GroupOptions_Frame_Classes_Rogue:SetChecked(filters.classes.Rogue);
	
	OneRaid_GroupOptions_Frame_Groups_Party:SetChecked(filters.groups.party);
	OneRaid_GroupOptions_Frame_Groups_Guild:SetChecked(filters.groups.guild);
	OneRaid_GroupOptions_Frame_Groups_Group1:SetChecked(filters.groups[1]);
	OneRaid_GroupOptions_Frame_Groups_Group2:SetChecked(filters.groups[2]);
	OneRaid_GroupOptions_Frame_Groups_Group3:SetChecked(filters.groups[3]);
	OneRaid_GroupOptions_Frame_Groups_Group4:SetChecked(filters.groups[4]);
	OneRaid_GroupOptions_Frame_Groups_Group5:SetChecked(filters.groups[5]);
	OneRaid_GroupOptions_Frame_Groups_Group6:SetChecked(filters.groups[6]);
	OneRaid_GroupOptions_Frame_Groups_Group7:SetChecked(filters.groups[7]);
	OneRaid_GroupOptions_Frame_Groups_Group8:SetChecked(filters.groups[8]);
	
	OneRaid_GroupOptions_Frame_Dead_Hide:SetChecked(filters.dead.hide);
	OneRaid_GroupOptions_Frame_Dead_Only:SetChecked(filters.dead.only);
	
	OneRaid_GroupOptions_Frame_Offline_Hide:SetChecked(filters.offline.hide);
	OneRaid_GroupOptions_Frame_Offline_Only:SetChecked(filters.offline.only);
	
	OneRaid_GroupOptions_Frame_Health_Min:SetChecked(filters.health.min);
	OneRaid_GroupOptions_Frame_Health_Max:SetChecked(filters.health.max);
	OneRaid_GroupOptions_Frame_Health_MinNum:SetText(filters.health.min or "0");
	OneRaid_GroupOptions_Frame_Health_MaxNum:SetText(filters.health.max or "100");
	
	OneRaid_GroupOptions_Frame_Sort_Alpha:SetChecked(sorting.alpha);
	OneRaid_GroupOptions_Frame_Sort_Class:SetChecked(sorting.class);
	OneRaid_GroupOptions_Frame_Sort_Health:SetChecked(sorting.health);
	OneRaid_GroupOptions_Frame_Sort_Group:SetChecked(sorting.group);
	OneRaid_GroupOptions_Frame_Sort_Reverse:SetChecked(sorting.reverse);
	OneRaid_GroupOptions_Frame_Sort_Offline:SetChecked(sorting.offline);
	OneRaid_GroupOptions_Frame_Sort_Dead:SetChecked(sorting.dead);
	
	OneRaid_GroupOptions_Frame_Layout_Horizontal:SetChecked(options.horizontal);
	OneRaid_GroupOptions_Frame_Layout_Backwards:SetChecked(options.backwards);
	OneRaid_GroupOptions_Frame_Layout_Grid:SetChecked(options.grid);
	OneRaid_GroupOptions_Frame_Layout_GridNum:SetText(options.grid or "1");
	OneRaid_GroupOptions_Frame_Layout_Limit:SetChecked(options.limit);
	OneRaid_GroupOptions_Frame_Layout_LimitNum:SetText(options.limit or "1");
	
	OneRaid_GroupOptions_Frame_Monitor_BuffMonitor:SetChecked(options.buffMonitor);
	OneRaid_GroupOptions_Frame_Monitor_DebuffMonitor:SetChecked(options.debuffMonitor);
	OneRaid_GroupOptions_Frame_Monitor_TankMonitor:SetChecked(options.tankMonitor);
	
	self:Players_OnUpdate();
	
end

function OneRaid.GroupOptions:UnitStyle_DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:UnitStyle_DropDown_Init(); end);
	UIDropDownMenu_SetButtonWidth(100);
	UIDropDownMenu_SetWidth(100);

end

function OneRaid.GroupOptions:UnitStyle_DropDown_Init()
	
	if (not OneRaid_Options) then return; end
	
	local list = {};
	for k, v in OneRaid_Options.UnitStyles do
		tinsert(list, k);
	end
	
	sort(list);
	
	for index, value in list do
		info = {};
		info.text = value;
		info.arg1 = value;
		if (OneRaid_Options.Groups[self.edit].style == value) then
			info.checked = 1;
		end
		info.func = function(arg1) 
			OneRaid_GroupOptions_Frame_UnitStyle_DropDownText:SetText(arg1);
			OneRaid_Options.Groups[self.edit].style = arg1;
			if (OneRaid_Options.Groups[self.edit].tankMonitor) then
				OneRaid.Group:DeactivateTankMonitorFrame(self.edit);
			else
				OneRaid.Group:DeactivateFrame(self.edit);
			end
			OneRaid.Group:CreateFrame(self.edit, arg1);				
		end;
		UIDropDownMenu_AddButton(info);
	end
	
end

function OneRaid.GroupOptions:Groups_DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:Groups_DropDown_Init(); end);
	UIDropDownMenu_SetButtonWidth(100);
	UIDropDownMenu_SetWidth(100);

end

function OneRaid.GroupOptions:Groups_DropDown_Init()
	
	if (not OneRaid_Options) then return; end
	
	local list = {};
	for k, v in OneRaid_Options.Groups do
		tinsert(list, k);
	end
	
	sort(list);
	
	for index, value in list do
		info = {};
		info.text = value;
		info.arg1 = value;
		if (value == self.edit) then
			info.checked = 1;
		end
		info.func = function(arg1)
			OneRaid.GroupOptions:EditGroup(arg1);
		end;
		UIDropDownMenu_AddButton(info);
	end
	
end

function OneRaid.GroupOptions:Color_OnClick(color, opacity)

	local lColor = {};
	
	self.selectedColor = color;
	self.normalTexture = getglobal(this:GetName() .. "NormalTexture");
	
	if (not lColor) then
		lColor = { r = 1, g = 1, b = 1 };
	end

	lColor.r = OneRaid_Options.Groups[self.edit][self.selectedColor].r;
	lColor.g = OneRaid_Options.Groups[self.edit][self.selectedColor].g;
	lColor.b = OneRaid_Options.Groups[self.edit][self.selectedColor].b;
	
	lColor.swatchFunc = function() self:Color_SetColor(); end;
	lColor.cancelFunc = function() self:Color_CancelColor(opacity); end;
	lColor.opacityFunc = function() self:Color_SetOpacity(); end;
	
	if (opacity) then
		lColor.hasOpacity = 1;
		lColor.opacity = OneRaid_Options.Groups[self.edit][self.selectedColor].a or 0;
		lColor.opacity = 1 - lColor.opacity;
		lColor.opacityFunc = function() self:Color_SetOpacity(); end;
	end	
	
	CloseMenus();
	UIDropDownMenuButton_OpenColorPicker(lColor);

end

function OneRaid.GroupOptions:Color_SetColor()

	local r, g, b = ColorPickerFrame:GetColorRGB();

	OneRaid_Options.Groups[self.edit][self.selectedColor].r = r;
	OneRaid_Options.Groups[self.edit][self.selectedColor].g = g;
	OneRaid_Options.Groups[self.edit][self.selectedColor].b = b;

	self.normalTexture:SetVertexColor(r, g, b);
	
	OneRaid.Group:LoadFrame(getglobal("OneRaid_Group_" .. self.edit));
	OneRaid.Group:UpdateFrame(getglobal("OneRaid_Group_" .. self.edit));

end

function OneRaid.GroupOptions:Color_SetOpacity()

	local a = 1 - OpacitySliderFrame:GetValue();

	OneRaid_Options.Groups[self.edit][self.selectedColor].a = a;

	OneRaid.Group:LoadFrame(getglobal("OneRaid_Group_" .. self.edit));
	OneRaid.Group:UpdateFrame(getglobal("OneRaid_Group_" .. self.edit));
	
end

function OneRaid.GroupOptions:Color_CancelColor(opacity)

	OneRaid_Options.Groups[self.edit][self.selectedColor].r = ColorPickerFrame.previousValues.r;
	OneRaid_Options.Groups[self.edit][self.selectedColor].g = ColorPickerFrame.previousValues.g;
	OneRaid_Options.Groups[self.edit][self.selectedColor].b = ColorPickerFrame.previousValues.b;
	
	if (opacity) then
		OneRaid_Options.Groups[self.edit][self.selectedColor].a = 1 - ColorPickerFrame.previousValues.opacity;
	end

 	self.normalTexture:SetVertexColor(
 		OneRaid_Options.Groups[self.edit][self.selectedColor].r,
		OneRaid_Options.Groups[self.edit][self.selectedColor].g,
		OneRaid_Options.Groups[self.edit][self.selectedColor].b
 	);
 	
 	OneRaid.Group:LoadFrame(getglobal("OneRaid_Group_" .. self.edit));
	OneRaid.Group:UpdateFrame(getglobal("OneRaid_Group_" .. self.edit));

end