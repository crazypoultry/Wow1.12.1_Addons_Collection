function MerchantSafeList_UpdateListBox()
	MerchantSafeList_NumSaves = 0;
	for key, value in MerchantSafeList_Save.Arrange do
		MerchantSafeList_NumSaves = MerchantSafeList_NumSaves + 1;
	end

	local scrollbar = getglobal("MerchantSafeList_Arrange_ListBoxScrollFrameScrollBar");
	if MerchantSafeList_NumSaves < 5 then
		scrollbar:SetMinMaxValues(0, 0);
		scrollbar:SetValue(0);
	else
		scrollbar:SetMinMaxValues(0, MerchantSafeList_NumSaves-5);
		scrollbar:SetValue(0);
	end

	MerchantSafeList_OnScroll(getglobal("MerchantSafeList_Arrange_ListBoxScrollFrame"));
end

function MerchantSafeList_Arrange_OnClick(button)
	MerchantSafeList_Arrange_Selected = tonumber( string.sub(button:GetName(), string.len(button:GetName())) );
	MerchantSafeList_Arrange_Selected = MerchantSafeList_Arrange_Selected + getglobal(button:GetParent():GetName().."ScrollFrameScrollBar"):GetValue();

	MerchantSafeList_Arrange_SelName = getglobal(button:GetName().."Text");
	MerchantSafeList_Arrange_SelName = MerchantSafeList_Arrange_SelName:GetText();
	--UIDropDownMenu_Initialize(MerchantSafeList_Quality_Dropdown, MerchantSafeList_Quality_Dropdown.initialize, nil); -- always visible
	UIDropDownMenu_SetSelectedValue(MerchantSafeList_Quality_Dropdown, MerchantSafeList_Save.ArrangeQuality);

	getglobal("MerchantSafeList_Quality_DropdownButton"):Enable();
	getglobal("MerchantSafeList_Arrange_Delete"):Enable();
end

function MerchantSafeList_ListButton_OnClick(button)
	local highlight = getglobal(button:GetParent():GetName().."Highlight");
	
	if not getglobal(button:GetName().."Text"):GetText() then return end

	highlight:Show();
	highlight:ClearAllPoints();
	highlight:SetPoint("TOPLEFT", button:GetName(), "TOPLEFT", 0, 0);
	
	if string.find( button:GetName(), "MerchantSafeList_Arrange_ListBox" ) then
		MerchantSafeList_Arrange_OnClick(button);
	end
end

function MerchantSafeList_Arrange_OnScroll(scroll)
	local n = getglobal(scroll:GetName().."ScrollBar"):GetValue();
	local buttonNo = 1;
	
	for i = 1, 5, 1 do
		getglobal("MerchantSafeList_Arrange_ListBoxButton"..i.."Text"):SetText("");
	end

	local temp = MerchantSafeList_Arrange_Selected - n;
	if temp <= 0 or temp >= 6 then
		getglobal(scroll:GetParent():GetName().."Highlight"):Hide();
	else
		local highlight = getglobal(scroll:GetParent():GetName().."Highlight");
		highlight:Show();
		highlight:ClearAllPoints();
		highlight:SetPoint("TOPLEFT", scroll:GetParent():GetName().."Button"..temp, "TOPLEFT", 0, 0);
	end

	-- Sort by item name in window
	--table.sort(MerchantSafeList_Save.Arrange); -- not applicable because index has no numeric elements and does not sort for some reason
	--for key, value in MerchantSafeList_sortedpairs(MerchantSafeList_Save.Arrange) do -- not applicable because iteration is sorted but can not create new array with the info

	-- Converting array to elements instead of by name
	isDebugSort = nil;
	--isDebugSort = true; -- comment out to stop testing
	if isDebugSort then MerchantSafeList_Msg("------- scan"); end
	MerchantSafeList_ArrangeSortTemp = { }; -- erase temporary list
	mIndex = 0;
	for key, value in MerchantSafeList_Save.Arrange do
		mIndex = mIndex + 1;
		table.insert(MerchantSafeList_ArrangeSortTemp, { name = key });
		if isDebugSort then MerchantSafeList_Msg(mIndex .." - ".. key .." - ".. MerchantSafeList_Save.Arrange[key]); end
	end

	table.sort(MerchantSafeList_ArrangeSortTemp, function(a,b) return strlower(a.name) < strlower(b.name) end);
	--table.sort(MerchantSafeList_ArrangeSortTemp, getglobal("ABfunction1")); -- alternative
	--function ABfunction1(a,b) return strlower(a.name) < strlower(b.name); end

	-- Verify sorted list, optional
	if isDebugSort then
		MerchantSafeList_Msg("------- sorted");
		mIndex = 0;
		for k,v in MerchantSafeList_ArrangeSortTemp do
			mIndex = mIndex + 1;
			MerchantSafeList_Msg(mIndex .." - ".. k .." - ".. MerchantSafeList_ArrangeSortTemp[k].name);
		end
	end

	-- Display sorted list in window
	for key, value in MerchantSafeList_ArrangeSortTemp do
		if n == 0 then
			if buttonNo == 6 then
				getglobal("MerchantSafeList_Arrange_ListBoxScrollFrameScrollBarScrollDownButton"):Enable();
				return;
			end
			getglobal("MerchantSafeList_Arrange_ListBoxButton"..buttonNo.."Text"):SetText(MerchantSafeList_ArrangeSortTemp[key].name);
			buttonNo = buttonNo + 1;
		else
			n = n - 1;
		end
	end
--[[
	for key, value in MerchantSafeList_Save.Arrange do
		if n == 0 then
			if buttonNo == 6 then
				getglobal("MerchantSafeList_Arrange_ListBoxScrollFrameScrollBarScrollDownButton"):Enable();
				return;
			end
			getglobal("MerchantSafeList_Arrange_ListBoxButton"..buttonNo.."Text"):SetText(key);
			buttonNo = buttonNo + 1;
		else
			n = n - 1;
		end
	end
]]	

	getglobal(scroll:GetName().."ScrollBarScrollDownButton"):Disable();
end

function MerchantSafeList_sortedpairs(t,comparator)
	local sortedKeys = {};
	table.foreach(t, function(k,v) table.insert(sortedKeys,k) end);
	table.sort(sortedKeys,comparator);
	local i = 0;
	local function _f(_s,_v)
		i = i + 1;
		local k = sortedKeys[i];
		if (k) then
			return k,t[k];
		end
	end
	return _f,nil,nil;
end

function MerchantSafeList_OnScroll(scroll)
	if string.find( scroll:GetName(), "MerchantSafeList_Arrange_ListBox" ) then
		MerchantSafeList_Arrange_OnScroll(scroll);
	end
end

function MerchantSafeList_ListBox_OnLoad(ListBox)
	if ListBox:GetName() == "MerchantSafeList_Arrange_ListBox" then
		getglobal(ListBox:GetName().."Label"):SetText(MerchantSafeList_OPTIONS_ARRANGELIST);
	end
end

function MerchantSafeList_ListBox_OnShow(ListBox)
	getglobal("MerchantSafeList_Arrange_ListBoxHighlight"):Hide();
	MerchantSafeList_Arrange_Selected = 0;
	MerchantSafeList_Arrange_SelName = nil;
	MerchantSafeList_OnScroll(getglobal(this:GetName().."ScrollFrame"));
end

function MerchantSafeList_Quality_Dropdown_OnClick()
	UIDropDownMenu_SetSelectedValue(MerchantSafeList_Quality_Dropdown, this.value);
	MerchantSafeList_Save.ArrangeQuality = this.value;
end

function MerchantSafeList_Quality_Dropdown_Initialize()

	-- Block the following quality items:
	--(-1) -- none
	--0 -- gray, Poor / Junk
	--1 -- invisible, Common
	--2 -- green, Uncommon
	--3 -- blueish, Rare
	--4 -- purple, Epic
	--5 -- orange, Legendary
	--6 -- white, Artifact

	local info;

	info = {};
	info.text = "None";
	info.func = MerchantSafeList_Quality_Dropdown_OnClick;
	info.value = "-1";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "0 - Junk (gray)";
	info.func = MerchantSafeList_Quality_Dropdown_OnClick;
	info.value = "0";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "1 - Common";
	info.func = MerchantSafeList_Quality_Dropdown_OnClick;
	info.value = "1";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "2 - Uncommon (green)";
	info.func = MerchantSafeList_Quality_Dropdown_OnClick;
	info.value = "2";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "3 - Rare (blue)";
	info.func = MerchantSafeList_Quality_Dropdown_OnClick;
	info.value = "3";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "4 - Epic (purple)";
	info.func = MerchantSafeList_Quality_Dropdown_OnClick;
	info.value = "4";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "5 - Legendary (orange)";
	info.func = MerchantSafeList_Quality_Dropdown_OnClick;
	info.value = "5";
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = "6 - Artifact (white)";
	info.func = MerchantSafeList_Quality_Dropdown_OnClick;
	info.value = "6";
	UIDropDownMenu_AddButton(info);
end

function MerchantSafeList_Quality_Dropdown_OnShow()
	UIDropDownMenu_Initialize(this, MerchantSafeList_Quality_Dropdown_Initialize);
	--UIDropDownMenu_Initialize(MerchantSafeList_Quality_Dropdown, MerchantSafeList_Quality_Dropdown.initialize, nil); -- alternative

	UIDropDownMenu_SetWidth(90, this);
	UIDropDownMenu_ClearAll(MerchantSafeList_Quality_Dropdown);
	UIDropDownMenu_SetSelectedValue(this, MerchantSafeList_Save.ArrangeQuality);
	--UIDropDownMenu_SetSelectedValue(MerchantSafeList_Quality_Dropdown, MerchantSafeList_Save.ArrangeQuality); -- alternative

	getglobal("MerchantSafeList_Arrange_Delete"):Disable();
end

function MerchantSafeList_ResetButton()
	--[[for i = table.getn(MerchantSafeList_Save.Marked), 1, -1 do
		table.remove(MerchantSafeList_Save.Marked, i);
	end]]
	for key, value in MerchantSafeList_Save.Arrange do
		MerchantSafeList_Save.Arrange[key] = nil;
	end

	getglobal("MerchantSafeList_Arrange_ListBoxHighlight"):Hide();
	MerchantSafeList_Arrange_Selected = 0;
	MerchantSafeList_Arrange_SelName = nil;
	MerchantSafeList_UpdateListBox();

	UIDropDownMenu_ClearAll(MerchantSafeList_Quality_Dropdown);
	MerchantSafeList_Save.ArrangeQuality = "-1";
	UIDropDownMenu_SetSelectedValue(MerchantSafeList_Quality_Dropdown, MerchantSafeList_Save.ArrangeQuality);

	getglobal("MerchantSafeList_Arrange_Delete"):Disable();
end

function MerchantSafeList_DeleteArrangeButton()
	if MerchantSafeList_Arrange_SelName then
		MerchantSafeList_DelArrange(MerchantSafeList_Arrange_SelName);
		MerchantSafeList_Msg("Removed from list, " .. MerchantSafeList_Arrange_SelName);

		getglobal("MerchantSafeList_Arrange_ListBoxHighlight"):Hide();
		MerchantSafeList_Arrange_Selected = 0;
		MerchantSafeList_Arrange_SelName = nil;
		MerchantSafeList_UpdateListBox();
		getglobal("MerchantSafeList_Arrange_Delete"):Disable();
	end
end

function MerchantSafeList_AddArrangeButton()
	local msg = getglobal("MerchantSafeList_Arrange_AddTextInput"):GetText();
	getglobal("MerchantSafeList_Arrange_AddTextInput"):SetText("");

	if msg and string.len( msg ) > 1 then
		MerchantSafeList_AddArrange(msg, 0, 0);
		MerchantSafeList_Msg("Added to list, " .. msg);

		getglobal("MerchantSafeList_Arrange_ListBoxHighlight"):Hide();
		MerchantSafeList_Arrange_Selected = 0;
		MerchantSafeList_Arrange_SelName = nil;
		MerchantSafeList_UpdateListBox();
		getglobal("MerchantSafeList_Arrange_Delete"):Disable();
	end
end

function MerchantSafeList_DeleteBCArrangeButton()
	if MerchantSafeList_Click == 2 then
		MerchantSafeList_Click = 0;
		SetCursor("POINT_CURSOR");
		MerchantSafeList_Cursor = nil;
		return;
	end

	MerchantSafeList_Click = 2;
	MerchantSafeList_Cursor = "CAST_CURSOR";
end

function MerchantSafeList_AddBCArrangeButton()
	if MerchantSafeList_Click == 1 then
		MerchantSafeList_Click = 0;
		SetCursor("POINT_CURSOR");
		MerchantSafeList_Cursor = nil;
		return;
	end

	MerchantSafeList_Quality = 0;
	MerchantSafeList_Click = 1;
	MerchantSafeList_Cursor = "CAST_CURSOR";
end

function MerchantSafeList_DividerOnShow(h)
	local name = h:GetName();

	if name == "MerchantSafeList_Divider_Items" then
		getglobal(name.."HeaderText"):SetText(MerchantSafeList_DIVIDER_ITEMS);
		getglobal(name.."Header"):SetWidth(225);
	end
end

function MerchantSafeList_OnHide()
	if (MerchantSafeList_Click == 1) then MerchantSafeList_AddBCArrangeButton(); end
end
