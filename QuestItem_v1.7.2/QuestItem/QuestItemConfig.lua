UIPanelWindows["QuestItemConfigFrame"] = { area = "left", pushable = 3, whileDead = 1 };
local NUM_ITEMS_DISPLAY = 8;
ITEM_HEIGHT = 40;
QuestItemsIdx = {};
local qiIndex = 1;
local ListAllItems = true;


QuestItem_Config_Frames = 
{
	{ frame = "ConfigFrame", 		tab = 1},
	{ frame = "ItemFrame", 			tab = 2},
};

QuestItem_Config_CheckButtons = { 
	{ frame = "QuestItem_Config_Checkbox1", text = QUESTITEM_CFG_CHK_ENABLED,  		tooltipText = QUESTITEM_CFG_CHK_ENABLED_TT, setting="Enabled" },
	{ frame = "QuestItem_Config_Checkbox2", text = QUESTITEM_CFG_CHK_ALERT,			tooltipText = QUESTITEM_CFG_CHK_ALERT_TT, setting="Alert"},
	{ frame = "QuestItem_Config_Checkbox3", text = QUESTITEM_CFG_CHK_DISPLAYTT, 	tooltipText = QUESTITEM_CFG_CHK_DISPLAYTT_TT, setting="Display tooltip" },
	{ frame = "QuestItem_Config_Checkbox4", text = QUESTITEM_CFG_CHK_ALTOPN, 		tooltipText = QUESTITEM_CFG_CHK_ALTOPN_TT, setting="AltOpen" },
	{ frame = "QuestItem_Config_Checkbox5", text = QUESTITEM_CFG_CHK_ONLYFORPLAYER,	tooltipText = QUESTITEM_CFG_CHK_ONLYFORPLAYER_TT, setting="DisplayForCharacterOnly"},
	{ frame = "QuestItem_Config_Checkbox6", text = QUESTITEM_CFG_CHK_DISPLAYCOUNT,  tooltipText = QUESTITEM_CFG_CHK_DISPLAYCOUNT_TT, setting="DisplayItemCount"},

	{ frame = "ItemFrameButton15", 			text = QUESTITEM_ITM_SHOWALL, 		tooltipText = QUESTITEM_ITM_SHOWALL, setting=nil },
};

function QuestItem_Config_OnCommand(command)
	if(command == "test") then
		QuestItem_Sky_SendTestData();
	else
		ShowUIPanel(QuestItemConfigFrame);--:Show();
	end
end

function QuestItem_Config_Close()
	HideUIPanel(QuestItemConfigFrame);
end

function QuestItem_Config_UpdateCheckboxes()
	for index, value in QuestItem_Config_CheckButtons do
		local button = getglobal( value.frame );
		local string = getglobal( value.frame.."Text");

		if (not button) then
			break;
		end
		
		string:SetText( TEXT(value.text) );
		button.tooltipRequirement = value.tooltipRequirement;
		button:SetChecked(QuestItem_Settings[value.setting]);

		button.tooltipText = value.tooltipText;

		if ( button.disabled ) then
			button:Disable();
			string:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		else
			button:Enable();
			string:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		end
	end
end

----------------
-- Save settings
----------------
----------------
function QuestItem_Config_Save()
	for index, value in QuestItem_Config_CheckButtons do
		local button = getglobal( value.frame );
		if(value.setting) then
			if(button and button:GetChecked()) then
				QuestItem_Settings[value.setting] = true;
			else
				QuestItem_Settings[value.setting] = false;
			end
		end
	end
	if(QuestItem_Settings["Enabled"]) then
		this:RegisterEvent("UI_INFO_MESSAGE");
	else
		this:UnregisterEvent("UI_INFO_MESSAGE");
	end
	QuestItem_Config_Close();
end


function QuestItem_Config_OnLoad()
	tinsert(UISpecialFrames, "QuestItemConfigFrame");
	PanelTemplates_SetNumTabs(QuestItemConfigFrame, 2);
	QuestItem_Config_Tab_OnClick(QuestItemConfigFrameTab1:GetID());
	QuestItemConfigFrameHeaderTitle:SetText(QUESTITEM_TITLE);
	FooterVersion:SetText(QUESTITEM_VERSION);
	ItemFrameButton15:SetChecked(ListAllItems);
	QuestItemConfigFrameTab1:SetText(QUESTITEM_SETTINGS);
	QuestItemConfigFrameTab2:SetText(QUESTITEM_ITEMS);
end

function QuestItem_Config_Tab_OnClick(id)
	PanelTemplates_SetTab(QuestItemConfigFrame, id);
	for index, value in QuestItem_Config_Frames do
		if(value.tab == id) then
			getglobal(value.frame):Show();
			if(id == 2) then
				QuestItem_Config_ItemFrame_OnShow();
			end
		else
			getglobal(value.frame):Hide();
		end
	end
end

------------------------------------------------------
-- Create a list of items to display in the scrollpane
------------------------------------------------------
------------------------------------------------------
function QuestItem_Config_CreateItemList(listAll)
	QuestItemsIdx = nil;
	QuestItemsIdx = {};
	qiIndex = 1;
	ListAllItems = listAll;
	
	table.foreach(QuestItems, QuestItem_Config_CreateIndexed);
	qiIndex = qiIndex - 1;
	table.sort(QuestItemsIdx, QuestItem_Sort);
end

function QuestItem_Sort(lhs, rhs)
	if(lhs.Item < rhs.Item) then
		return true;
	else
		return false;
	end
end

--------------------------------------------------------------------
-- [[ Filters out which items should be displayed in the list. ]] --
--------------------------------------------------------------------
function QuestItem_Config_CreateIndexed(value)
	local itemData = QuestItems[value];
	if(ListAllItems or itemData.QuestName == QUESTITEM_UNIDENTIFIED) then
		-- If setting says not display for other characters, return
		if( (QuestItem_Settings["DisplayForCharacterOnly"] and QuestItem_Settings["DisplayForCharacterOnly"] == true) and not itemData[UnitName("player")]) then
			return;
		end
		-- Update status when populating the list of quests to display
		local fqQuestName, _, _, _, fqStatus = QuestItem_FindQuest(value, true);
		if(fqQuestName and QuestItems[value][UnitName("player")]) then
			QuestItems[value][UnitName("player")].QuestStatus = fqStatus;
		end
		QuestItemsIdx[qiIndex] = {};
		QuestItemsIdx[qiIndex].Item = value;
		qiIndex = qiIndex + 1;
	end
end

function QuestItem_Config_ItemFrame_ToggleFilter()
	ListAllItems = not ItemFrameButton15:GetChecked();
	FauxScrollFrame_SetOffset(ItemFrameScrollFrame, 0);	
	QuestItem_Config_ItemFrame_OnShow();
end

function QuestItem_Config_ItemFrame_OnShow()
	QuestItem_Config_CreateItemList(ListAllItems);
	QuestItem_Config_Items_Update();
end

function QuestItem_Config_Items_Update()
	local itemButton, itemName, itemQuest, itemIcon, itemQuestStatus;
	local offset;
	if(QuestItemInputFrame:IsVisible()) then
		return;
	end
	
	FauxScrollFrame_Update(ItemFrameScrollFrame, qiIndex, NUM_ITEMS_DISPLAY, ITEM_HEIGHT);
	for index=1, NUM_ITEMS_DISPLAY do
		offset = index + FauxScrollFrame_GetOffset(ItemFrameScrollFrame);
		itemButton = getglobal("ItemButton" .. index);
		itemName 		= getglobal(itemButton:GetName() ..  "ButtonTextName");
		itemQuest 		= getglobal(itemButton:GetName() ..  "ButtonTextQuest");
		itemQuestStatus = getglobal(itemButton:GetName() ..  "ButtonTextQuestStatus");
		itemIcon 		= getglobal(itemButton:GetName() ..  "ItemIcon");
		
		-- Change width of items if there is no scrollbar
		if(qiIndex < NUM_ITEMS_DISPLAY) then
			itemButton:SetWidth(312);
		else
			itemButton:SetWidth(287);
		end
		-- Exit if there are less items in the list than we want to display, or we are displaying all items
		if(offset <= qiIndex and index <= offset) then
			local questItemData = QuestItems[QuestItemsIdx[offset].Item];
			itemName:SetText(QuestItemsIdx[offset].Item);
			QuestItem_Debug(QuestItemsIdx[offset].Item .. " => " .. questItemData.QuestName);
			-- Insert unidentified item
			if(questItemData.QuestName == QUESTITEM_UNIDENTIFIED) then
				itemQuest:SetText(questItemData.QuestName);
				itemQuestStatus:SetText("");
				itemQuest:SetTextColor(1, 0, 0);
				if(QuestItem_Settings["Display tooltip"] == true) then
					itemButton.tooltipText = QUESTITEM_ITEMS_EDIT_M_TT;
				end
			-- Insert identified item
			else
				itemQuest:SetTextColor(0.4, 0.5, 0.8);
				if(QuestItem_Settings["Display tooltip"] == true) then
					itemButton.tooltipText = QUESTITEM_ITEMS_EDIT_SHIFT_M_TT;
				end

				-- Display status if available for the player
				if(questItemData[UnitName("player")]) then
					local statusData = QuestStatusData[questItemData[UnitName("player")].QuestStatus];
					itemQuestStatus:SetText(statusData.StatusText);
					itemQuestStatus:SetTextColor(statusData.Red, statusData.Green, statusData.Blue);
					if(QuestItem_Settings["DisplayItemCount"] and QuestItem_Settings["DisplayItemCount"] == true) then
						itemQuest:SetText(questItemData.QuestName .. " (" .. questItemData[UnitName("player")].Count .. "/".. questItemData.Total .. ")");
					else
						itemQuest:SetText(questItemData.QuestName);
					end
				else
					itemQuestStatus:SetText("");
					if(QuestItem_Settings["DisplayItemCount"] and QuestItem_Settings["DisplayItemCount"] == true) then
						itemQuest:SetText(questItemData.QuestName .. " (-/".. questItemData.Total .. ")");
					else
						itemQuest:SetText(questItemData.QuestName);
					end
				end
			end
			
			
			-- Set item texture
			if(questItemData.Texture) then
				itemIcon:SetNormalTexture(questItemData.Texture);
			else
				itemIcon:SetNormalTexture("Interface\\Icons\\INV_Misc_QuestionMark");
			end

			itemButton:Show();
		else
			itemButton:Hide();
		end
	end
end


function QuestItem_InputFrame_Open(button, itemName)
	local itemLabel = getglobal(itemName):GetText();
	-- Display input frame for unidentified items, and if the shift key is down	
	if(button == "RightButton" and (QuestItems[itemLabel].QuestName == QUESTITEM_UNIDENTIFIED or IsShiftKeyDown())) then
		if(not QuestItemInputFrame:IsVisible()) then
			QuestItemInputEditBox:SetText(QuestItems[itemLabel].QuestName);
			QuestItemInputEditBox:HighlightText();
			QuestItemInputFrame:Show();
			QuestItemInputFrameHeaderTitle:SetText(itemLabel);
		end
	elseif(button == "LeftButton" and IsAltKeyDown() and QuestItems[itemLabel][UnitName("player")]) then
		-- Toggle quest status
		if(QuestItems[itemLabel][UnitName("player")].QuestStatus < QUESTSTATUS_COMPLETE) then
			QuestItems[itemLabel][UnitName("player")].QuestStatus = QuestItems[itemLabel][UnitName("player")].QuestStatus + 1;
		else
			QuestItems[itemLabel][UnitName("player")].QuestStatus = 0;
		end
		QuestItem_Config_Items_Update();
	end
end

function QuestItem_InputFrame_Save()
	local itemName = QuestItemInputFrameHeaderTitle:GetText();
	
	if(QuestItemInputEditBox:GetText() == "") then
		QuestItem_UpdateItem(itemName, QUESTITEM_UNIDENTIFIED, 0, QuestItems[itemName].Total, QUESTSTATUS_ACTIVE);
	else
		QuestItem_UpdateItem(itemName, QuestItemInputEditBox:GetText(), 0, QuestItems[itemName].Total, QUESTSTATUS_ACTIVE);
	end
	QuestItemInputFrame:Hide();
	QuestItem_Config_Items_Update();
end