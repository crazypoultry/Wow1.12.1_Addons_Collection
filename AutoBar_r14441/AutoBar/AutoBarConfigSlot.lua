--
-- AutoBarConfigSlot
--
-- Slot Config functions
--
-- Maintained by Azethoth / Toadkiller of Proudmoore.
-- http://www.curse-gaming.com/en/wow/addons-4430-1-autobar-toadkiller.html
--

--
-- Config Checkbox Handling
--

AutoBarConfigSlot = {};

local L = AceLibrary("AceLocale-2.1"):GetInstance("AutoBar", true);
local Compost = AceLibrary("Compost-2.0");


function AutoBarConfigSlot:View(slotsIndex, playerInfo)
	AutoBarConfigSlotFrameTitleText:SetText(L["VIEWSLOT"]);
	AutoBarConfigSlotFrameViewText:Show();
	AutoBarConfigSlot.editable = false;
	AutoBarConfigSlot:Initialize(slotsIndex, playerInfo);
	AutoBarConfigSlotFrameClearSlotButton:Hide();
	AutoBarConfigSlotFrameEmptySlotButton:Hide();
	AutoBarConfigSlotFrameNoPopup:Disable();
	AutoBarConfigSlotFrameArrangeOnUse:Disable();
	AutoBarConfigSlotFrameRightClickTargetsPet:Disable();
	AutoBarConfigSlotFrameNoPopupText:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	AutoBarConfigSlotFrameArrangeOnUseText:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	AutoBarConfigSlotFrameRightClickTargetsPetText:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	AutoBarConfigSlotFrame:SetBackdropColor(0.30,0.15,0.15);
end


function AutoBarConfigSlot:Edit(slotsIndex, playerInfo)
	AutoBarConfigSlotFrameTitleText:SetText(L["EDITSLOT"].." #" .. slotsIndex);
	AutoBarConfigSlotFrameViewText:Hide();
	AutoBarConfigSlot.editable = true;
	AutoBarConfigSlot:Initialize(slotsIndex, playerInfo);
	AutoBarConfigSlotFrameClearSlotButton:Show();
	AutoBarConfigSlotFrameEmptySlotButton:Show();
	AutoBarConfigSlotFrameNoPopup:Enable();
	AutoBarConfigSlotFrameArrangeOnUse:Enable();
	AutoBarConfigSlotFrameRightClickTargetsPet:Enable();
	AutoBarConfigSlotFrameNoPopupText:SetVertexColor(NORMAL_FONT_COLOR.r , NORMAL_FONT_COLOR.g , NORMAL_FONT_COLOR.b);
	AutoBarConfigSlotFrameArrangeOnUseText:SetVertexColor(NORMAL_FONT_COLOR.r , NORMAL_FONT_COLOR.g , NORMAL_FONT_COLOR.b);
	AutoBarConfigSlotFrameRightClickTargetsPetText:SetVertexColor(NORMAL_FONT_COLOR.r , NORMAL_FONT_COLOR.g , NORMAL_FONT_COLOR.b);
	AutoBarConfigSlotFrame:SetBackdropColor(0.15,0.20,0.15);
end


function AutoBarConfigSlot:Initialize(slotsIndex, playerInfo)
	AutoBarConfigSlot.slots = playerInfo.buttons;
	AutoBarConfigSlot.slotsIndex = slotsIndex;
	getglobal("AutoBarConfigSlotFrameNoPopupText"):SetText(L["AUTOBAR_CONFIG_NOPOPUP"]);
	getglobal("AutoBarConfigSlotFrameArrangeOnUseText"):SetText(L["AUTOBAR_CONFIG_ARRANGEONUSE"]);
	getglobal("AutoBarConfigSlotFrameRightClickTargetsPetText"):SetText(L["AUTOBAR_CONFIG_RIGHTCLICKTARGETSPET"]);
	AutoBarConfigSlot:Update();
	AutoBarConfigSlotFrame:Show();
end


function AutoBarConfigSlot:Update()
	if (not AutoBarConfigSlot.slots[AutoBarConfigSlot.slotsIndex]) then
		AutoBarConfigSlot.slots[AutoBarConfigSlot.slotsIndex] = Compost:GetTable();
	end

	local buttonInfo = AutoBarConfigSlot.slots[AutoBarConfigSlot.slotsIndex];
	local noPopupCheckbox = getglobal("AutoBarConfigSlotFrameNoPopup");
	local arrangeOnUseCheckbox = getglobal("AutoBarConfigSlotFrameArrangeOnUse");
	local rightClickTargetsPetCheckbox = getglobal("AutoBarConfigSlotFrameRightClickTargetsPet");
	local index,tmp,i;

	noPopupCheckbox:SetChecked(buttonInfo.noPopup);
	arrangeOnUseCheckbox:SetChecked(buttonInfo.arrangeOnUse);
	rightClickTargetsPetCheckbox:SetChecked(buttonInfo.rightClickTargetsPet);

	tmp = 0;
	for index = 1, AUTOBAR_MAXSLOTCATEGORIES, 1 do
		if (buttonInfo[index]) then
			tmp = index;
		end
	end
	index = 1;
	while (index < tmp) do
		if (buttonInfo[index]) then
			index = index + 1;
		else
			buttonInfo[index] =
			buttonInfo[index+1];
			buttonInfo[index+1] = nil;
			tmp = 0;
			for i = 1, AUTOBAR_MAXSLOTCATEGORIES, 1 do
				if (buttonInfo[i]) then
					tmp = i;
				end
			end
		end
	end

	for index = 1, AUTOBAR_MAXSLOTCATEGORIES, 1 do
		local button   = getglobal("AutoBarConfigSlotFrame_Button"..index);
		local hotkey   = getglobal("AutoBarConfigSlotFrame_Button"..index.."HotKey");
		local count    = getglobal("AutoBarConfigSlotFrame_Button"..index.."Count");
		local icon     = getglobal("AutoBarConfigSlotFrame_Button"..index.."Icon");
		local checkbox = getglobal("AutoBarConfigSlotFrame_Option"..index);
		local checkboxText = getglobal("AutoBarConfigSlotFrame_Option"..index.."Text");

		hotkey:Hide();
		if (buttonInfo[index]) then
			count:SetText("");
			if (AutoBar_Category_Info[buttonInfo[index]] and AutoBar_Category_Info[buttonInfo[index]].targetted) then
				checkbox:Show();
				checkboxText:SetText(L["AUTOBAR_CONFIG_SMARTSELFCAST"]);
				if (AutoBar_Config[AutoBarConfig.editPlayer].smartSelfcast and AutoBar_Config[AutoBarConfig.editPlayer].smartSelfcast[buttonInfo[index]]) then
					checkbox:SetChecked(1);
				else
					checkbox:SetChecked(0);
				end
			else
				checkbox:Hide();
			end
		else
			count:SetText("Empty");
			checkbox:Hide();
		end
		icon:SetTexture(AutoBar_GetTexture(buttonInfo[index]));
		button:Show();
	end
end


-- Individual smart self cast checkbox handling
function AutoBarConfigSlot:SelfCastCheckboxOnCheck()
	local buttonInfo = AutoBarConfigSlot.slots[AutoBarConfigSlot.slotsIndex];
	local category;
	if (type(buttonInfo) == "table") then
		category = buttonInfo[this:GetID()];
	else
		category = buttonInfo;
	end
	if (not AutoBar_Config[AutoBarConfig.editPlayer].smartSelfcast) then
		AutoBar_Config[AutoBarConfig.editPlayer].smartSelfcast = {};
	end
	AutoBar_Config[AutoBarConfig.editPlayer].smartSelfcast[category] = this:GetChecked();
	AutoBarConfigSlot:Update();
	AutoBarProfile:ButtonsChanged();
end


function AutoBarConfigSlot:OnCheck()
	local buttonInfo = AutoBarConfigSlot.slots[AutoBarConfigSlot.slotsIndex];
	local buttonName = this:GetName();

	if (type(buttonInfo) == "table") then
		if (buttonName == "AutoBarConfigSlotFrameNoPopup") then
			buttonInfo.noPopup = this:GetChecked();
		elseif (buttonName == "AutoBarConfigSlotFrameArrangeOnUse") then
			buttonInfo.arrangeOnUse = this:GetChecked();
		elseif (buttonName == "AutoBarConfigSlotFrameRightClickTargetsPet") then
			buttonInfo.rightClickTargetsPet = this:GetChecked();
		end
	end
	AutoBarConfigSlot:Update();
	AutoBarProfile:ButtonsChanged();
end


function AutoBarConfigSlot:ButtonOnClick(mousebutton)
	ResetCursor();
	AutoBar.dragging = nil;

	if (not AutoBarConfigSlot.editable) then
		return;
	end

	local dragBag, dragSlot = AutoBarConfig:GetDragBagSlot();
	if (CursorHasItem() and dragBag and dragSlot and AutoBarConfigSlot.editable) then
		AutoBarConfigSlot.ButtonOnReceiveDrag();
	else
		local slotInfo = AutoBarConfigSlot.slots[AutoBarConfigSlot.slotsIndex];
		local category = nil;
		AutoBarChooseCategoryFrame.editting = this:GetID();
		if (AutoBarChooseCategoryFrame.editting > table.getn(slotInfo) + 1) then
			AutoBarChooseCategoryFrame.editting = table.getn(slotInfo) + 1;
		end
		category = slotInfo[AutoBarChooseCategoryFrame.editting];

		if (not AutoBarConfigSlot.editable) then
			AutoBarChooseCategoryFrame.editting = nil;
			if (AutoBar_Category_Info[category]) then
				AutoBarChooseCategoryFrame.categoryexplore = category;
			else
				return;
			end
		end

		AutoBarChooseCategoryFrame:Show();
	end
end


function AutoBarConfigSlot.ButtonOnDragStart()
	local fromIndex = this:GetID();
	AutoBar.SetDraggingIndex("AutoBarConfigSlotFrame", fromIndex);
	SetCursor("BUY_CURSOR");
end


function AutoBarConfigSlot.ButtonOnReceiveDrag()
	local toIndex = this:GetID();
	local fromIndex = AutoBar.GetDraggingIndex("AutoBarConfigSlotFrame");

--	DEFAULT_CHAT_FRAME:AddMessage("AutoBarConfig.ButtonOnReceiveDrag " .. tostring(fromIndex) .. " -> " .. toIndex, 1, 0.5, 0);

	if (fromIndex and fromIndex ~= toIndex) then
		AutoBarConfigSlot:MoveButtonItems(AutoBarConfigSlot.slotsIndex, fromIndex, toIndex);
	elseif (CursorHasItem()) then
		local dragBag, dragSlot = AutoBarConfig:GetDragBagSlot();
		if (dragBag and dragSlot) then
			local slotInfo = AutoBarConfigSlot.slots[AutoBarConfigSlot.slotsIndex];
			local name, id = AutoBar.LinkDecode(GetContainerItemLink(dragBag, dragSlot));
			if (table.getn(slotInfo) < toIndex) then
				toIndex = table.getn(slotInfo) + 1;
			end
			AutoBarConfigSlot.slots[AutoBarConfigSlot.slotsIndex][toIndex] = id;
			dragBag = nil;
			dragSlot = nil;
			ClearCursor();
		end
	end
	AutoBarConfigSlot:Update();
	AutoBarProfile:ButtonsChanged();
	AutoBar.dragging = nil;
	ResetCursor();
end


function AutoBarConfigSlot:MoveButtonItems(button, fromIndex, toIndex)
	if (type(AutoBarConfigSlot.slots[button]) == "table") then
		if (not AutoBarConfigSlot.slots[button][fromIndex] or fromIndex == toIndex) then
			-- Move to self so do nothing
			return;
		end
		if (not AutoBarConfigSlot.slots[button][fromIndex]) then
			-- Dont allow swapping empties into the list
			return;
		end
		local temp = AutoBarConfigSlot.slots[button][fromIndex];
		if (not AutoBarConfigSlot.slots[button][toIndex]) then
			-- Move to the end
			table.remove(AutoBarConfigSlot.slots[button], fromIndex);
			table.insert(AutoBarConfigSlot.slots[button], temp);
		else
			-- Swap the two
			AutoBarConfigSlot.slots[button][fromIndex] = AutoBarConfigSlot.slots[button][toIndex];
			AutoBarConfigSlot.slots[button][toIndex] = temp;
		end
	end
end


-- Delete all items in a slot.
function AutoBarConfigSlot:EmptySlotButtonOnClick()
	Compost:Erase(AutoBarConfigSlot.slots[AutoBarConfigSlot.slotsIndex]);
	AutoBarConfigSlot:Update();
	AutoBarProfile:ButtonsChanged();
end


-- Delete all items in a slot.
function AutoBarConfigSlot:ClearSlotButtonOnClick()
	Compost:Recycle(AutoBarConfigSlot.slots[AutoBarConfigSlot.slotsIndex], "AAACLEAR")
	AutoBarConfigSlot:Update();
	AutoBarProfile:ButtonsChanged();
end


