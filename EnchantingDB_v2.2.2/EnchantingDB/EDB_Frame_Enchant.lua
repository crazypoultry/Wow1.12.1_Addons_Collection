
--------------[[ Frame Functions ]]--------------

function EDB_Frame_Enchant_OnLoad()

	-- Set up default values for frame control
	EDB_Frame_Enchant.itemFilter = 1;
	EDB_Frame_Enchant.bonusFilter = 1;
	EDB_Frame_Enchant.knownFilter = 0;
	EDB_Frame_Enchant.selection = 1;

	-- Build the enchant list
	EDB_Frame_Enchant.enchantListOffset = 0;
	EDB_Frame_Enchant_EnchantList_Build();
	EDB_Frame_Enchant.reagentListSize = 0;

end


--------------[[ FilterByKnownCheckbox Functions ]]--------------

function EDB_Frame_Enchant_FilterByKnownCheckbox_OnClick()

	if ( this:GetChecked() ) then
		PlaySound("igMainMenuOptionCheckBoxOn");
		EDB_Frame_Enchant.knownFilter = 1;
		EDB_Frame_Enchant_EnchantList_Build();
		EDB_Frame_Enchant_EnchantList_Update();
	else
		PlaySound("igMainMenuOptionCheckBoxOff");
		EDB_Frame_Enchant.knownFilter = 0;
		EDB_Frame_Enchant_EnchantList_Build();
		EDB_Frame_Enchant_EnchantList_Update();
	end

end


--------------[[ ItemDropDown Functions ]]--------------

function EDB_Frame_Enchant_ItemDropDown_OnLoad()

	UIDropDownMenu_SetWidth(95);
	UIDropDownMenu_SetText("All", EDB_Frame_Enchant_ItemDropDown);
	UIDropDownMenu_Initialize(EDB_Frame_Enchant_ItemDropDown, EDB_Frame_Enchant_ItemDropDown_Update);

end

function EDB_Frame_Enchant_ItemDropDown_OnClick()

	UIDropDownMenu_SetSelectedID(EDB_Frame_Enchant_ItemDropDown, this:GetID());
	EDB_Frame_Enchant.itemFilter = this:GetID() - 1;
	EDB_Frame_Enchant_EnchantList_Build();
	EDB_Frame_Enchant_EnchantList_Update();
	EDB_Frame_Enchant_DetailFrame_Update();

end

function EDB_Frame_Enchant_ItemDropDown_Update()

	local info = {};
	info.text = "Item Type";
	info.isTitle = 1;
	UIDropDownMenu_AddButton(info);

	if ( not EDB_ItemTypeList ) then
		return;
	end

	for i in EDB_ItemTypeList do

		info = {};
		info.text = EDB_ItemTypeList[i];
		info.func = EDB_Frame_Enchant_ItemDropDown_OnClick;

		if ( i == EDB_Frame_Enchant.itemFilter ) then
			info.checked = 1;
			UIDropDownMenu_SetText(EDB_ItemTypeList[i], EDB_Frame_Enchant_ItemDropDown);
		else
			info.checked = nil;
		end

		UIDropDownMenu_AddButton(info);

	end

end

--------------[[ BonusDropDown Functions ]]--------------

function EDB_Frame_Enchant_BonusDropDown_OnLoad()

	UIDropDownMenu_SetWidth(95);
	UIDropDownMenu_SetText("All", EDB_Frame_Enchant_BonusDropDown);
	UIDropDownMenu_Initialize(EDB_Frame_Enchant_BonusDropDown, EDB_Frame_Enchant_BonusDropDown_Update);

end

function EDB_Frame_Enchant_BonusDropDown_OnClick()

	UIDropDownMenu_SetSelectedID(EDB_Frame_Enchant_BonusDropDown, this:GetID());
	EDB_Frame_Enchant.bonusFilter = this:GetID() - 1;
	EDB_Frame_Enchant_EnchantList_Build();
	EDB_Frame_Enchant_EnchantList_Update();
	EDB_Frame_Enchant_DetailFrame_Update();

end

function EDB_Frame_Enchant_BonusDropDown_Update()

	local info = {};
	info.text = "Bonus Type";
	info.isTitle = 1;
	UIDropDownMenu_AddButton(info);

	if ( not EDB_BonusTypeList ) then
		return;
	end

	for i in EDB_BonusTypeList do

		info = {};
		info.text = EDB_BonusTypeList[i];
		info.func = EDB_Frame_Enchant_BonusDropDown_OnClick;

		if ( i == EDB_Frame_Enchant.bonusFilter ) then
			info.checked = 1;
			UIDropDownMenu_SetText(EDB_BonusTypeList[i], EDB_Frame_Enchant_BonusDropDown);
		else
			info.checked = nil;
		end

		UIDropDownMenu_AddButton(info);

	end

end

--------------[[ EnchantListColumn______ Functions ]]--------------

function EDB_Frame_Enchant_EnchantListColumnName_OnClick()

	EDB_Frame_Enchant.sortBy = 1;
	EDB_Frame_Enchant_EnchantList_Sort();
	EDB_Frame_Enchant_EnchantList_Update();
	EDB_Frame_Enchant_DetailFrame_Update();
	EDB_Frame_Enchant_ReagentList_Update();

end

function EDB_Frame_Enchant_EnchantListColumnItem_OnClick()

	EDB_Frame_Enchant.sortBy = 2;
	EDB_Frame_Enchant_EnchantList_Sort();
	EDB_Frame_Enchant_EnchantList_Update();
	EDB_Frame_Enchant_DetailFrame_Update();
	EDB_Frame_Enchant_ReagentList_Update();

end

function EDB_Frame_Enchant_EnchantListColumnBonus_OnClick()

	EDB_Frame_Enchant.sortBy = 3;
	EDB_Frame_Enchant_EnchantList_Sort();
	EDB_Frame_Enchant_EnchantList_Update();
	EDB_Frame_Enchant_DetailFrame_Update();
	EDB_Frame_Enchant_ReagentList_Update();

end

function EDB_Frame_Enchant_EnchantListColumnPrice_OnClick()

	EDB_Frame_Enchant.sortBy = 4;
	EDB_Frame_Enchant_EnchantList_Sort();
	EDB_Frame_Enchant_EnchantList_Update();
	EDB_Frame_Enchant_DetailFrame_Update();
	EDB_Frame_Enchant_ReagentList_Update();

end

--------------[[ EnchantListEntry Functions ]]--------------

function EDB_Frame_Enchant_EnchantListEntry_OnClick()

	EDB_Frame_Enchant_EnchantList_SetSelection(this:GetID());
	
	local link;

	-- do nothing if edit box isn't open
	if ( not ChatFrameEditBox:IsVisible() ) then
		return;
	end

	-- Shift key links enchant
	if ( IsShiftKeyDown() ) then
		link = EDB_Formula_GetEnchantLink(EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection].formula);
	end

	-- Control key links reagents
	if ( IsControlKeyDown() ) then
		link = "";
		for r in EDB_Frame_Enchant.reagentList do
			link = link..EDB_Frame_Enchant.reagentList[r].qReq.."x"..EDB_Reagent[EDB_Frame_Enchant.reagentList[r].id].." ";
		end
	end

	-- Alt key links item result, if any
	if ( IsAltKeyDown() ) then
		link = EDB_Formula[EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection].formula].itemLink;
	end

	if ( link ) then
		ChatFrameEditBox:Insert(link);
	end

end

function EDB_Frame_Enchant_EnchantListEntry_SetColor(button, color)

	if ( not button ) then
		return;
	end

	if ( not color ) then
		color = EDB_Colors.Normal;
	end

	getglobal(button:GetName().."_Name"):SetTextColor( color[1], color[2], color[3]);
	getglobal(button:GetName().."_Item"):SetTextColor( color[1], color[2], color[3]);
	getglobal(button:GetName().."_Bonus"):SetTextColor(color[1], color[2], color[3]);

end

function EDB_Frame_Enchant_EnchantListEntry_OnEnter()

	-- Set the text color to "highlighted"
	EDB_Frame_Enchant_EnchantListEntry_SetColor(this, EDB_Colors.Highlight);

end

function EDB_Frame_Enchant_EnchantListEntry_OnLeave()

	if ( not EDB_Frame_Enchant.selection ) then
		EDB_Frame_Enchant_EnchantListEntry_SetColor(this, EDB_Colors.Normal);
		return;
	end

	local line = EDB_Frame_Enchant.selection - EDB_Frame_Enchant.enchantListOffset;

	if ( this:GetID() == line ) then
		EDB_Frame_Enchant_EnchantListEntry_SetColor(this, EDB_Colors.Highlight);
	else
		EDB_Frame_Enchant_EnchantListEntry_SetColor(this, EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.enchantListOffset + this:GetID()].color);
	end

end

--------------[[ EnchantList Functions ]]--------------

-- Set the current enchantList selection
function EDB_Frame_Enchant_EnchantList_SetSelection(index)

	-- Set the new selection
	EDB_Frame_Enchant.selection = index + EDB_Frame_Enchant.enchantListOffset;

	EDB_Frame_Enchant_EnchantList_Update();
	EDB_Frame_Enchant_DetailFrame_Update();
	EDB_Frame_Enchant_EnchantButton_Update();

end

-- Build enchantList by filtering out selections from the master list
function EDB_Frame_Enchant_EnchantList_Build()

	-- Clear the list.
	EDB_Frame_Enchant.enchantList = { };

	local entry = 0;

	-- For each formula in database
	for id, formula in EDB_Formula do

		if  ( ( EDB_Frame_Enchant.itemFilter  == 1 ) or ( EDB_Frame_Enchant.itemFilter == EDB_Formula[id].item ) ) and
			( ( EDB_Frame_Enchant.bonusFilter == 1 ) or ( EDB_Frame_Enchant.bonusFilter == EDB_Formula[id].bonusType ) ) and
			( ( EDB_Frame_Enchant.knownFilter == 0 ) or ( ( EDB_CSI ) and ( EDB_CSI.formula ) and ( EDB_CSI.formula[id] ) ) ) then

			entry = entry + 1;
			EDB_Frame_Enchant.enchantList[entry] = { };
			EDB_Frame_Enchant.enchantList[entry].name  = EDB_Formula[id].name;
			EDB_Frame_Enchant.enchantList[entry].item  = EDB_Formula[id].item;
			EDB_Frame_Enchant.enchantList[entry].bonus = EDB_Formula[id].bonusText;
			EDB_Frame_Enchant.enchantList[entry].formula = id;

			EDB_Frame_Enchant.enchantList[entry].price = 0;
			EDB_Frame_Enchant.enchantList[entry].count = 0;

			if ( not EDB_CSI ) or ( not EDB_CSI.formula ) or ( not EDB_CSI.formula[id] ) then
				EDB_Frame_Enchant.enchantList[entry].color = EDB_Colors.Red;
			else
				EDB_Frame_Enchant.enchantList[entry].color = EDB_Colors.difficulty[EDB_CSI.formula[id].difficulty or -1];
			end

		end

	end

	EDB_Frame_Enchant.enchantListSize = entry;
	
	EDB_Frame_Enchant_EnchantList_CostUpdate();
	
	EDB_Frame_Enchant_EnchantList_CountUpdate();

	EDB_Frame_Enchant_EnchantList_Sort();
	
	EDB_Frame_Enchant.selection = 1;

end

-- Update how much enchants cost
function EDB_Frame_Enchant_EnchantList_CostUpdate()

	for i, entry in EDB_Frame_Enchant.enchantList do

		entry.price = 0;

		if ( EDB_CSI ) and ( EDB_CSI.reagentValue ) then
			for reagent, count in EDB_Formula[entry.formula].content do
				if ( EDB_CSI.reagentValue[reagent] ) then
					entry.price = entry.price + count*EDB_CSI.reagentValue[reagent];
				end
			end
		end

	end

end

-- Update how many enchants we can do
function EDB_Frame_Enchant_EnchantList_CountUpdate()

	for i, entry in EDB_Frame_Enchant.enchantList do

		local min = 99;

		if ( EDB_CSI ) and ( EDB_CSI.reagent ) then

			for reagent, count in EDB_Formula[entry.formula].content do
				if ( EDB_CSI.reagent[reagent] ) then
					local owned = EDB_CSI.reagent[reagent].bag;

					-- Count reagents in bank if option is set
					if ( EDB_Config.countBank == true ) and ( EDB_CSI.reagent[reagent].bank ) then
						owned = owned + EDB_CSI.reagent[reagent].bank;
					end

					if ( min > math.floor(owned/count) ) then
						min = math.floor(owned/count);
					end

				else

					min = 0;

				end
			end

			entry.count = min;

		else

			entry.count = 0;

		end

	end

end

-- Update the enchantList
function EDB_Frame_Enchant_EnchantList_Update()

	local line, lineplusoffset, entry;

	FauxScrollFrame_Update(EDB_Frame_Enchant_EnchantListScrollBar, EDB_Frame_Enchant.enchantListSize, 8, 20);

	EDB_Frame_Enchant.enchantListOffset = FauxScrollFrame_GetOffset(EDB_Frame_Enchant_EnchantListScrollBar);

	for line = 1, 8 do

		entry = getglobal("EDB_Frame_Enchant_EnchantListEntry"..line);

		entry.index = line + EDB_Frame_Enchant.enchantListOffset;

		if ( entry.index <= EDB_Frame_Enchant.enchantListSize ) then
			if ( EDB_Config ) and ( EDB_Config.countTag == true ) and ( EDB_Frame_Enchant.enchantList[entry.index].count > 0 ) then
				getglobal("EDB_Frame_Enchant_EnchantListEntry"..line.."_Name"):SetText("["..EDB_Frame_Enchant.enchantList[entry.index].count.."] "..EDB_Frame_Enchant.enchantList[entry.index].name);
			else
				getglobal("EDB_Frame_Enchant_EnchantListEntry"..line.."_Name"):SetText(EDB_Frame_Enchant.enchantList[entry.index].name);
			end
			getglobal("EDB_Frame_Enchant_EnchantListEntry"..line.."_Item"):SetText(EDB_ItemTypeList[EDB_Frame_Enchant.enchantList[entry.index].item]);
			getglobal("EDB_Frame_Enchant_EnchantListEntry"..line.."_Bonus"):SetText(EDB_Frame_Enchant.enchantList[entry.index].bonus);
			EDB_Money_SetText("EDB_Frame_Enchant_EnchantListEntry"..line.."_Price", EDB_Frame_Enchant.enchantList[entry.index].price);
			EDB_Frame_Enchant_EnchantListEntry_SetColor(entry, EDB_Frame_Enchant.enchantList[entry.index].color);
			entry:Show();
		else
			entry:Hide();
		end

	end

	EDB_Frame_Enchant_EnchantListHighlight_Update();

end

-- Properly position and show/hide the selection highlight
function EDB_Frame_Enchant_EnchantListHighlight_Update()

	if ( not EDB_Frame_Enchant.selection ) or ( EDB_Frame_Enchant.enchantListSize == 0 ) then

		EDB_Frame_Enchant_EnchantListHighlight.line = nil;
		EDB_Frame_Enchant_EnchantListHighlight:Hide();
		return;

	end

	local line = EDB_Frame_Enchant.selection - EDB_Frame_Enchant.enchantListOffset;

	if ( line < 1 ) or ( line > 8 ) then

		EDB_Frame_Enchant_EnchantListHighlight.line = nil;
		EDB_Frame_Enchant_EnchantListHighlight:Hide();

	else

		local color = EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection].color;

		EDB_Frame_Enchant_EnchantListHighlight.line = line;
		EDB_Frame_Enchant_EnchantListHighlight:SetPoint("TOPLEFT", "EDB_Frame_Enchant_EnchantListEntry"..line, "TOPLEFT");
		EDB_Frame_Enchant_EnchantListHighlight:Show();
		EDB_Frame_Enchant_EnchantListHighlight_EnchantListEntryHighlightTexture:SetVertexColor(color[1], color[2], color[3], 1);
		EDB_Frame_Enchant_EnchantListEntry_SetColor(getglobal("EDB_Frame_Enchant_EnchantListEntry"..line), EDB_Colors.Highlight);

	end

end

-- Use an in-place insert sort to order the elements in enchantList
function EDB_Frame_Enchant_EnchantList_Sort()

	if ( not EDB_Frame_Enchant.enchantList ) then
		return;
	end

	if ( not EDB_Frame_Enchant.sortBy ) then
		EDB_Frame_Enchant.sortBy = 2;
	end

	-- 1 = name, 2 = item, 3 = bonus, 4 = price
	local SortOrder = { };
	SortOrder[1] = { 1, 2, 3, 4 };	-- Sort by name
	SortOrder[2] = { 2, 1, 3, 4 };	-- Sort by item
	SortOrder[3] = { 3, 2, 1, 4 };	-- Sort by bonus
	SortOrder[4] = { 4, 3, 2, 1 };	-- Sort by price

	local i, j, value;

	for i = 1, EDB_Frame_Enchant.enchantListSize do

		value = EDB_Frame_Enchant.enchantList[i];

		j = i-1;
		while ( j > 0 ) and ( EDB_Frame_Enchant_EnchantList_Compare(value, EDB_Frame_Enchant.enchantList[j]) < 0 ) do

			EDB_Frame_Enchant.enchantList[j+1] = EDB_Frame_Enchant.enchantList[j];
			j = j - 1;

		end

		EDB_Frame_Enchant.enchantList[j+1] = value;

	end

end

-- Compare two enchant list entries to determine sorted order.
function EDB_Frame_Enchant_EnchantList_Compare(entry1, entry2)

	local eval = {};

	-- Compare Name
	if ( entry1.name > entry2.name ) then
		eval[1] =  1;
	elseif ( entry1.name < entry2.name ) then
		eval[1] = -1;
	else
		eval[1] =  0;
	end

	-- Compare Item
	if ( entry1.item > entry2.item ) then
		eval[2] =  1;
	elseif ( entry1.item < entry2.item ) then
		eval[2] = -1;
	else
	    -- if equal, compare by skill
	    if ( EDB_CSI ) and ( EDB_CSI.formula ) and ( not EDB_CSI.formula[entry1.formula] ) and ( EDB_CSI.formula[entry2.formula] ) then
	    	eval[2] =  1;
	    elseif ( EDB_CSI ) and ( EDB_CSI.formula ) and ( EDB_CSI.formula[entry1.formula] ) and ( not EDB_CSI.formula[entry2.formula] ) then
			eval[2] = -1;
		elseif ( EDB_Formula[entry1.formula].skill > EDB_Formula[entry2.formula].skill ) then
			eval[2] =  1;
		elseif ( EDB_Formula[entry1.formula].skill < EDB_Formula[entry2.formula].skill ) then
			eval[2] = -1;
		else
			eval[2] =  0;
		end
	end

	-- Compare Bonus
	if ( not EDB_Formula[entry1.formula].bonusType ) and ( EDB_Formula[entry2.formula].bonusType ) then
		eval[3] = 1;
	elseif ( EDB_Formula[entry1.formula].bonusType ) and ( not EDB_Formula[entry2.formula].bonusType ) then
		eval[3] = -1;
	elseif ( not EDB_Formula[entry1.formula].bonusType ) and ( not EDB_Formula[entry2.formula].bonusType ) then
		if ( EDB_Formula[entry1.formula].bonusValue > EDB_Formula[entry2.formula].bonusValue ) then
			eval[3] =  1;
		elseif ( EDB_Formula[entry1.formula].bonusValue < EDB_Formula[entry2.formula].bonusValue ) then
			eval[3] = -1;
		else
			eval[3] =  0;
		end
	else
		if ( EDB_Formula[entry1.formula].bonusType > EDB_Formula[entry2.formula].bonusType ) then
			eval[3] =  1;
		elseif ( EDB_Formula[entry1.formula].bonusType < EDB_Formula[entry2.formula].bonusType ) then
			eval[3] = -1;
		else
			if ( EDB_Formula[entry1.formula].bonusValue > EDB_Formula[entry2.formula].bonusValue ) then
				eval[3] =  1;
			elseif ( EDB_Formula[entry1.formula].bonusValue < EDB_Formula[entry2.formula].bonusValue ) then
				eval[3] = -1;
			else
				eval[3] =  0;
			end
		end
	end

	-- Compare Price
	if ( entry1.price > entry2.price ) then
		eval[4] =  1;
	elseif ( entry1.price < entry2.price ) then
		eval[4] = -1;
	else
		eval[4] =  0;
	end

	return eval[EDB_Frame_Enchant.sortBy];

end

--------------[[ ReagentListEntry Functions ]]--------------

function EDB_Frame_Enchant_ReagentListEntry_OnClick()

	local link;

	-- do nothing if edit box isn't open
	if ( not ChatFrameEditBox:IsVisible() ) then
		return;
	end

	-- Shift key links reagent
	if ( IsShiftKeyDown() ) then
		link = EDB_Reagent[EDB_Frame_Enchant.reagentList[this.index].id];
	end

	-- Control key links quantity+reagent
	if ( IsControlKeyDown() ) then
		link = ""..EDB_Frame_Enchant.reagentList[this.index].qReq.."x"..EDB_Reagent[EDB_Frame_Enchant.reagentList[this.index].id];
	end

	if ( link ) then
		ChatFrameEditBox:Insert(link);
	end

end

function EDB_Frame_Enchant_ReagentList_Build()

	-- Clear the list.
	EDB_Frame_Enchant.reagentList = { };

	local entry = 0;

	-- For each formula in database
	for reagent, count in EDB_Formula[EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection].formula].content do

		entry = entry + 1;

		EDB_Frame_Enchant.reagentList[entry] = { };

		local rle = EDB_Frame_Enchant.reagentList[entry];

		rle.name	= EDB_NameFromLink(EDB_Reagent[reagent]);
		rle.id		= reagent;
		rle.qReq	= count;

		if ( EDB_CSI ) and ( EDB_CSI.reagent ) and ( EDB_CSI.reagent[reagent] ) then
			rle.qOwned = EDB_CSI.reagent[reagent].bag;
			rle.qBanked = EDB_CSI.reagent[reagent].bank;
		end

		rle.unitPrice  = 0;

		if ( EDB_CSI ) and ( EDB_CSI.reagentValue ) and ( EDB_CSI.reagentValue[rle.id] ) then
			rle.unitPrice = EDB_CSI.reagentValue[rle.id];
		end

		rle.totalPrice = rle.qReq * rle.unitPrice;

	end

	EDB_Frame_Enchant.reagentListSize = entry;

end

function EDB_Frame_Enchant_ReagentList_Update()

	local line, lineplusoffset, entry;

	if ( EDB_Frame_Enchant.reagentListSize == nil ) then
		EDB_Frame_Enchant.reagentListSize = 0;
	end

	-- 8 max entries, 4 lines shown, each line is 16 pixels high.
	FauxScrollFrame_Update(EDB_Frame_Enchant_ReagentListScrollBar, EDB_Frame_Enchant.reagentListSize, 4, 20);

	EDB_Frame_Enchant.reagentListOffset = FauxScrollFrame_GetOffset(EDB_Frame_Enchant_ReagentListScrollBar);

	for line = 1, 4 do

		entry = getglobal("EDB_Frame_Enchant_ReagentListEntry"..line);

		entry.index = line + EDB_Frame_Enchant.reagentListOffset;

		local rle = EDB_Frame_Enchant.reagentList[entry.index];

		local qOwned;

		if ( rle ) and ( rle.qOwned ) then qOwned = rle.qOwned; else qOwned = "?"; end

		if ( entry.index <= EDB_Frame_Enchant.reagentListSize ) then
			getglobal("EDB_Frame_Enchant_ReagentListEntry"..line.."_Icon"):SetNormalTexture(EDB_ReagentIcon[rle.id]);
			getglobal("EDB_Frame_Enchant_ReagentListEntry"..line.."_Name"):SetText(rle.name);
			getglobal("EDB_Frame_Enchant_ReagentListEntry"..line.."_QuantityOwned"):SetText(qOwned.."/");
			getglobal("EDB_Frame_Enchant_ReagentListEntry"..line.."_QuantityReq"):SetText(rle.qReq);
			EDB_Money_SetText("EDB_Frame_Enchant_ReagentListEntry"..line.."_Price", rle.totalPrice);
			entry:Show();
		else
			entry:Hide();
		end

	end

	-- Update enchanting rod
	local rod = EDB_Formula[EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection].formula].rod;

	if ( rod ) and ( ( rod < 1 ) or ( rod > 5 ) ) then

		EDB_Frame_Enchant_Detail_Requirement:SetText("Requires: "..EDB_Rod[rod]);

	else
		if ( EDB_CSI ) and ( EDB_CSI.rod ) and ( EDB_CSI.rod[rod].bag > 0 ) then

			EDB_Frame_Enchant_Detail_Requirement:SetText("Requires: |cffffffff"..EDB_NameFromLink(EDB_Rod[rod]).."|r");

		else

			EDB_Frame_Enchant_Detail_Requirement:SetText("Requires: |cffff0000"..EDB_NameFromLink(EDB_Rod[rod]).."|r");

		end
	end

end


--------------[[ DetailFrame Functions ]]--------------

function EDB_Frame_Enchant_DetailFrame_Update()

	local selection = EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection];

	if ( not selection ) then
		return;
	end

	EDB_Frame_Enchant_Detail_EnchantIcon:SetNormalTexture(EDB_Formula[selection.formula].icon or "Interface\\Icons\\Spell_Holy_GreaterHeal");

	if ( EDB_Formula[selection.formula].item <= 9) then
		EDB_Frame_Enchant_Detail_Name:SetText("Enchant "..EDB_ItemTypeList[EDB_Formula[selection.formula].item].." - "..EDB_Formula[selection.formula].name);
	else
		EDB_Frame_Enchant_Detail_Name:SetText(selection.name);
	end

	EDB_Tooltip:SetHyperlink("enchant:"..selection.formula);
	EDB_Frame_Enchant_Detail_Description:SetText(EDB_TooltipTextLeft5 and EDB_TooltipTextLeft5:GetText() or " ");

	EDB_Frame_Enchant_Detail_Cost:Hide();

	EDB_Frame_Enchant_ReagentList_Build();

	EDB_Frame_Enchant_ReagentList_Update();
	
	EDB_Frame_Enchant_TotalPrice_Update();

end

function EDB_Frame_Enchant_Detail_EnchantIcon_OnClick()

	local link;

	-- do nothing if edit box isn't open
	if ( not ChatFrameEditBox:IsVisible() ) then
		return;
	end

	-- Shift key links enchant
	if ( IsShiftKeyDown() ) then
		link = EDB_Formula_GetEnchantLink(EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection].formula);
	end

	-- Control key links reagents
	if ( IsControlKeyDown() ) then
		link = "";
		for r in EDB_Frame_Enchant.reagentList do
			link = link..EDB_Frame_Enchant.reagentList[r].qReq.."x"..EDB_Reagent[EDB_Frame_Enchant.reagentList[r].id].." ";
		end
	end

	-- Alt key links item result, if any
	if ( IsAltKeyDown() ) then
		link = EDB_Formula[EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection].formula].itemLink;
	end
	
	if ( link ) then
		ChatFrameEditBox:Insert(link);
	end

end


--------------[[ TotalPrice Functions ]]--------------

function EDB_Frame_Enchant_TotalPrice_Update()

	EDB_Frame_Enchant_TotalPrice_Text:SetText("+"..EDB_Config.markup.."% Markup");
	EDB_Money_SetText("EDB_Frame_Enchant_TotalPrice", math.floor((100+EDB_Config.markup)*EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection].price/100));

end

--------------[[ EnchantButton Functions ]]--------------

function EDB_Frame_Enchant_EnchantButton_Update()

	-- Check to make sure we know the enchant
	if (not EDB_CSI) or (not EDB_CSI.formula) or (not EDB_Frame_Enchant) or (not EDB_Frame_Enchant.enchantList) or
	   (not EDB_Frame_Enchant.selection) or (not EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection]) or
	   (not EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection].formula) or
	   (not EDB_CSI.formula[EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection].formula]) or
	   (not EDB_CSI.formula[EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection].formula].craftNum) then

		EDB_Frame_Enchant_EnchantButton:Disable();
		return;

	end

	-- Check that all necessary reagents are present
	for index in EDB_Frame_Enchant.reagentList do

		if ( EDB_Frame_Enchant.reagentList[index].qOwned ) and ( EDB_Frame_Enchant.reagentList[index].qOwned < EDB_Frame_Enchant.reagentList[index].qReq ) then

			EDB_Frame_Enchant_EnchantButton:Disable();
			return;

		end

	end
	
	-- Check that the rod is present
	local rod = EDB_Formula[EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection].formula].rod;
	if ( rod > 0 ) and ( rod < 6 ) and ( EDB_CSI.rod[rod].bag < 1 ) then
		EDB_Frame_Enchant_EnchantButton:Disable();
		return;
	end

	EDB_Frame_Enchant_EnchantButton:Enable();

end

function EDB_Frame_Enchant_EnchantButton_OnClick()

	EDB_RunInEnchantFrame(
	function ()

		local id;

		if (EDB_CSI) and (EDB_CSI.formula) and (EDB_Frame_Enchant) and (EDB_Frame_Enchant.enchantList) and
		   (EDB_Frame_Enchant.selection) and (EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection]) and
		   (EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection].formula) and
		   (EDB_CSI.formula[EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection].formula]) then

			id = EDB_CSI.formula[EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection].formula].craftNum;

		else
		
			EDB_Print_Debug("Blarg, id not found.");

		end

		if ( id ) then

			DoCraft(id);

		end

	end
	);

end
