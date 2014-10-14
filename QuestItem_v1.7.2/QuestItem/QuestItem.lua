--[[ 
Description
If you have ever had a quest item you have no idea which quest it belongs to, and if it safe to destroy, this AddOn is for you. QuestItem stores an in-game database over quest items and tell you which quest they belong to.

QuestItem now has a configuration screen you can access by typing /questitem or /qi at the chat prompt. Here you can configure some of the functionallity as well as do manual mapping of unidentified items.
If you've made a mistake with a manual mapping, you can change it by holding down the Shift key while clicking.

If you like this addon, please vote.
QuestHistory is reccomended

Feature summary:
- Identify quest items when picked up.
- Show quest name and status in tooltip for quest items.
- Will try to identify items picked up before the AddOn was installed.
- Identified items are available for all your characters, and status is unique for your character.
- Displays how many items are needed to complete quest, and how many you currently have.
- Manual mapping for unidentified items (right click) in item list.
- Edit of manual mapping for items (shift + right click).
- Change quest status for items in the item list (alt + left click).
- Configuration

Known issues:
- Problems with identifying quests containing the special german letters ??.
- Haven't figured a way to open questlog for items in bank bags

	
History:
	New in version 1.7.2:
	- Fixed a nil error when completing/abandoning quest (special conditions).
	- Fixed an error in the item list where unidentified quests were displayed with invalid name and status.
	- Updated german language file (thanks to Morrowind).
	
	New in version 1.7.1:
	- Minor changes in language files
	- Fixed a spelling error that prevented the edit box for items to display.
	
	New in version 1.7.0:
	- Integration with QuestHistory
	- Improved quest status reporting (abandoned, complete)
	- Added icon for items in the list (Old items won't get an icon as I don't know how to find it).
	- Option to only display items for current character.
	- Option to show/hide count/totalcount for items in tooltip and in list.
	- Proper docking of main window so that you can open multiple windows.
	- Quest item information was not displayed for items opened from a link in chat. Fixed.
	- It is now possible to change the quest status for a quest item from the item list by left clicking the item while holding down the Alt key.
	- Fixed a nil-error introduced by GroupButtons when AllInOneInventory was not installed.
	
	New in version 1.6.0:
	- Added configurable tooltip for item list.
	- Added Alt + right click to open QuestLog for an item.
	
	New in version 1.5.3:
	- Updated french language

	See older history in Changelog.txt

]]--

-- /script arg1="Duskbat Wing"; QuestItem_OnEvent("DELETE"); arg1="Roon's Kodo Horn: 1/1"; QuestItem_OnEvent("UI_INFO_MESSAGE");
-- /script arg1="Ragefire Shaman slain: 5/8"; QuestItem_OnEvent("UI_INFO_MESSAGE"); QuestItem_OnEvent("DELETE");
-- /script arg1="Sent mail"; QuestItem_OnEvent("DELETE"); QuestItem_OnEvent("DELETE");

DEBUG = false;
QI_CHANNEL_NAME = "QuestItem";

-- QuestItem array
QuestItems = {};
-- Settings
QuestItem_Settings = {};

-- Function hooks
local base_AbandonQuest;
local base_CompleteQuest;


QUESTSTATUS_ACTIVE 				= 0;
QUESTSTATUS_COMPLETEABANDONED 	= 1;
QUESTSTATUS_ABANDONED			= 2;
QUESTSTATUS_COMPLETE 			= 3;

-- Color and text for quest status
QuestStatusData = {};
QuestStatusData[QUESTSTATUS_ACTIVE] 			= { Red = 0, 	Green = 1,	 	Blue = 0, 	StatusText = QUESTITEM_QUESTACTIVE};
QuestStatusData[QUESTSTATUS_COMPLETEABANDONED] 	= { Red = 0.7, 	Green = 0.2, 	Blue = 0.5, StatusText = QUESTITEM_COMPLETEABANDONED };
QuestStatusData[QUESTSTATUS_ABANDONED] 			= { Red = 0.7, 	Green = 0, 		Blue = 0, 	StatusText = QUESTITEM_ABANDONED };
QuestStatusData[QUESTSTATUS_COMPLETE] 			= { Red = 0.7, 	Green = 0.7, 	Blue = 0.7, StatusText = QUESTITEM_QUESTCOMPLETE };

----------------------------------------------------
-- Updates the database with item and quest mappings
----------------------------------------------------
----------------------------------------------------
function QuestItem_UpdateItem(item, quest, count, total, status)
	-- If item doesn't exist, add quest name and total item count to it
	if(not QuestItems[item]) then
		QuestItems[item] = {};
		QuestItems[item].QuestName = quest;
	end
	
	-- If old quest name was unidentified, save new name
	if(QuestItem_SearchString(QuestItems[item].QuestName, QUESTITEM_UNIDENTIFIED) and not QuestItem_SearchString(quest, QuestItems[item].QuestName) ) then
		QuestItems[item].QuestName = quest;
	end

	if(not QuestItems[item][UnitName("player")]) then
		QuestItems[item][UnitName("player")] = {};
	end

	-- Save total count
	if(total ~= nil and QuestItem_CheckNumeric(total) ) then
		QuestItems[item].Total = QuestItem_MakeIntFromHexString(total);
	else
		QuestItems[item].Total = 0;
	end
	
	-- Save item count
	if(count ~= nil and QuestItem_CheckNumeric(count) ) then
		QuestItems[item][UnitName("player")].Count = QuestItem_MakeIntFromHexString(count);
	else
		QuestItems[item][UnitName("player")].Count = 0;
	end

	QuestItems[item][UnitName("player")].QuestStatus 	= status;
end

----------------------------------------------------------------------
-- Find a quest based on item name.
-- Parameters:
--			item to find quest for
--			true to search QuestHistory, false otherwise
-- Returns:
-- 			QuestName  	- the name of the Quest.
--			Total	   	- Total number of items required to complete it
--			Count	   	- The number of items you have
--			Texture		- Texture of the item
--			QuestStatus - The status of the quest
----------------------------------------------------------------------
----------------------------------------------------------------------
function QuestItem_FindQuest(item, searchQuestHistory)
	local total = 1;
	local count = 0;
	local texture = nil;
	local itemName;
	local QuestName = nil;
	local status = QUESTSTATUS_COMPLETEABANDONED;
	
	-- If quest has status other than active, save the status so that it 
	-- won't be changed if the quest can't be found now
	if(QuestItems[item]) then
		if(QuestItems[item][UnitName("player")]) then
			status = QuestItems[item][UnitName("player")].QuestStatus;
			count = QuestItems[item][UnitName("player")].Count;
		end
		total = QuestItems[item].Total;
		QuestName = QuestItems[item].QuestName;
	end
	-- Iterate the quest log entries
	for y=1, GetNumQuestLogEntries(), 1 do
		local qName, level, questTag, isHeader, isCollapsed, complete = GetQuestLogTitle(y);
		QuestName = qName;
		-- Don't check headers
		if(not isHeader) then
			SelectQuestLogEntry(y);
			local QDescription, QObjectives = GetQuestLogQuestText();
			-- Look for the item in quest leader boards
			if (GetNumQuestLeaderBoards() > 0) then 
				-- Look for the item in leader boards
				for i=1, GetNumQuestLeaderBoards(), 1 do --Objectives
					--local str = getglobal("QuestLogObjective"..i);
					local text, itemType, finished = GetQuestLogLeaderBoard(i);
					-- Check if type is an item, and if the item is what we are looking for
					if(itemType ~= nil and (itemType == "item" or itemType == "object") ) then
						if(QuestItem_SearchString(text, item)) then
							local _, count, total = QuestItem_GetItemInfo(text);
							return QuestName, total, count, texture, QUESTSTATUS_ACTIVE;
						end
					end
				end
			end
			-- Look for the item in the objectives - no count and total will be returned
			if(QuestItem_SearchString(QObjectives, item)) then
				return QuestName, total, count, texture, QUESTSTATUS_ACTIVE;
			end
			
		end
	end

	-- Look for items in QuestHistory
	if(searchQuestHistory ~= nil and searchQuestHistory == true) then
		return QuestItem_FindQuestInQuestHistory(item);
	end
	
	return QuestName, 0, 0, nil, status;
end

----------------------------------------------
-- [[ Search for a quest in QuestHistory ]] --
-- Returns:
-- 			QuestName  	- the name of the Quest.
--			Total	   	- Total number of items required to complete it
--			Count	   	- The number of items you have
--			Texture		- Texture of the item
----------------------------------------------
function QuestItem_FindQuestInQuestHistory(questItemName)
	local status = QUESTSTATUS_COMPLETEABANDONED;
	local QuestName = nil;
	
	if(QuestItems[item]) then
		if(QuestItems[item][UnitName("player")] and QuestItems[item][UnitName("player")].QuestStatus ~= QUESTSTATUS_ACTIVE) then
			status = QuestItems[item][UnitName("player")].QuestStatus;
		end
		QuestName = QuestItems[item].QuestName;
	end
	-- Check if QuestHistory is enabled
	if(QuestHistory_List) then
		-- iterate the QuestHistory database
		for realmIndex, realmValue in QuestHistory_List do
			for charIndex, charValue in realmValue do
				for questIndex, questValue in charValue do
					local questNameValue = questValue["t"];
					if(questValue["os"]) then
						for objectiveIndex, objective in questValue["os"] do
							local itemName = objective["t"];
							-- Find out if the objective matches the item
							if(itemName and QuestItem_SearchString(itemName, questItemName) ) then
								-- Get information on the item
								local itemText, count, total = QuestItem_GetItemInfo(itemName);
								if(questValue["a"] and questValue["a"] == true) then
									status = QUESTSTATUS_ABANDONED;
								else
									status = QUESTSTATUS_COMPLETE;
								end
								QuestName = questNameValue;
								return QuestName, total, count, texture, status;
							end
						end
					end
				end
			end
		end
	end
	return nil, 0, 0, nil, status;
end

--------------------------------------------------------------------------------
-- Check if there is a quest for the item. If it exists; update, if not, save it.
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function QuestItem_LocateQuest(itemText, itemCount, itemTotal)
	local QuestName, texture;
	
	-- Only look through the questlog if the item has not already been mapped to a quest
	if(not QuestItems[itemText] or QuestItems[itemText].QuestName == QUESTITEM_UNIDENTIFIED) then
		QuestName, itemTotal, itemCount, texture = QuestItem_FindQuest(itemText);
	else
		QuestName = QuestItems[itemText].QuestName;
	end
	
	-- Update the QuestItems array
	if(QuestName ~= nil) then
		QuestItem_UpdateItem(itemText, QuestName, itemCount, itemTotal, 0);
	elseif(QuestItem_Settings["Alert"]) then
		QuestItem_PrintToScreen(QUESTITEM_CANTIDENTIFY .. itemText);
	end
end

---------------
-- OnLoad event
---------------
---------------
function QuestItem_OnLoad()
	-- RegisterForSave("QuestItems");
	-- RegisterForSave("QuestItem_Settings");
	
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("QUEST_COMPLETE");

	-- Register slash commands
	SLASH_QUESTITEM1 = "/questitem";
	SLASH_QUESTITEM2 = "/qi";
	SlashCmdList["QUESTITEM"] = QuestItem_Config_OnCommand;
	
	QuestItem_PrintToScreen(QUESTITEM_LOADED);
	
	--QuestItem_Sky_OnLoad();
	QuestItem_HookTooltip();
	
	-- Hook AbandonQuest
	base_AbandonQuest = AbandonQuest;
	AbandonQuest = QuestItem_AbandonQuest;
	
	-- Hook CompleteQuest
	base_CompleteQuest = CompleteQuest;
	CompleteQuest = QuestItem_CompleteQuest;
	
end

-- [[ Hook for CompleteQuest ]] --
----------------------------------
function QuestItem_CompleteQuest()
	local questTitle = GetQuestLogTitle(GetQuestLogSelection());
	-- Call Blizzard's CompleteQuest
	base_CompleteQuest();
	-- Change status
	QuestItem_SetQuestStatus(questTitle, QUESTSTATUS_COMPLETE);
end

---------------------------------
-- [[ Hook for AbandonQuest ]] --
---------------------------------
function QuestItem_AbandonQuest()
	local questTitle = GetQuestLogTitle(GetQuestLogSelection());
	-- Call Blizzard's AbandonQuest
	base_AbandonQuest();
	-- Change status
	QuestItem_SetQuestStatus(questTitle, QUESTSTATUS_ABANDONED);
end

----------------------------------------------------------------------------
-- [[ Function to change the status for quest selected in the QuestLog ]] --
----------------------------------------------------------------------------
function QuestItem_SetQuestStatus(questTitle, questStatus)
	if ( questTitle ) then
		QuestItem_Debug("setting status for " .. questTitle);
		questTitle = string.gsub(string.gsub(questTitle, '^[[].*[]]',''),'^ ','');
		for itemName, itemData in QuestItems do 
			if(itemData["QuestName"] and itemData.QuestName == questTitle) then
				QuestItem_UpdateItem(itemName, questTitle, 0, QuestItems[itemName].Total, questStatus);
				-- don't exit the loop as there might be more items for the quest
			end
		end
	end
end

-----------------
-- OnEvent method
-----------------
-----------------
function QuestItem_OnEvent(event)
	if(event == "VARIABLES_LOADED") then
		QuestItem_VariablesLoaded();
		this:UnregisterEvent("VARIABLES_LOADED");
		
		if(QuestItem_Settings["version"] and QuestItem_Enabled() == true) then
			this:RegisterEvent("UI_INFO_MESSAGE");		
		end
		return;
	end
	
	if(not arg1) then
		return;
	end

	if(event == "UI_INFO_MESSAGE") then
		local itemText, itemCount, itemTotal = QuestItem_GetItemInfo(arg1);
		-- Ignore trade and duel events
		if(itemText ~= arg1 and not strfind(itemText, QUESTITEM_SLAIN)) then
			QuestItem_LocateQuest(itemText, itemCount, itemTotal);
		end
	elseif(event == "DELETE") then
		local itemText = QuestItem_GetItemInfo(arg1);
		if(QuestItems[itemText]) then
			QuestItems[itemText] = nil;
			QuestItem_Debug("Deleted");
		end
	elseif(event == "QUEST_COMPLETE") then
		QuestItem_Debug("Completing quest " .. GetQuestLogTitle(GetQuestLogSelection()) );
	end
end

------------------------------------
-- Initialize settings if not found. 
------------------------------------
------------------------------------
function QuestItem_VariablesLoaded()
	if ( QuestItem_Settings and QuestItem_Settings["version"] == QUESTITEM_VERSION ) then
		return;
	end
	
	if (not QuestItem_Settings) then
		QuestItem_Settings = { };	
	end
	
	-- No settings exist
	QuestItem_Settings["version"] = QUESTITEM_VERSION;
	
	QuestItem_Settings["Enabled"] = true;
	QuestItem_Settings["Alert"] = true;
	-- Check if AxuItemMenus is installed
	if(AxuItemMenus_AddTestHook) then
		QuestItem_Settings["DisplayRequest"] = false;
	else
		QuestItem_Settings["DisplayRequest"] = false;
	end
	QuestItem_Settings["ShiftOpen"] = false;
	QuestItem_Settings["AltOpen"] = true;
end


---------------
---------------
---------------
-- FUNCTIONS --
---------------
---------------
---------------
function QuestItem_Enabled()
	if(QuestItem_Settings["Enabled"] == nil or QuestItem_Settings["Enabled"] == false) then
		return false;
	end
	return true;
end

-- Print debug message to the default chatframe.
-- Only works if the DEBUG variable in the 
-- beginning of QuestItem.lua is set to true.
------------------------------------------------
------------------------------------------------
function QuestItem_Debug(message)
	if(DEBUG) then
		if(not message) then
			DEFAULT_CHAT_FRAME:AddMessage("Debug: Message was nil", 0.9, 0.5, 0.3);
		else
			DEFAULT_CHAT_FRAME:AddMessage("Debug: " ..message, 0.9, 0.5, 0.3);
		end
	end
end

--------------------------------------------------------
-- [[ Get details about an item from a text string ]] --
-- Returns:
--			ItemName - name of the item/objective
--			ItemCount - the current number of items
--			ItemTotal - total count of items you need to gather
--------------------------------------------------------
function QuestItem_GetItemInfo(itemText)
	local itemName = gsub(itemText,"(.*): %d+/%d+","%1",1);
	local itemCount = gsub(itemText,"(.*): (%d+)/(%d+)","%2");
	local itemTotal = gsub(itemText,"(.*): (%d+)/(%d+)","%3");
	
	return itemName, itemCount, itemTotal;
end

function QuestItem_PrintToScreen(message)
	UIErrorsFrame:AddMessage(message, 0.4, 0.5, 0.8, 1.0, 8);
end

---------------------------------------------------
-- Find out if an item is a quest item by searching 
-- the text in the tooltip.
---------------------------------------------------
---------------------------------------------------
function QuestItem_IsQuestItem(tooltip)
	if(tooltip) then
		local tooltip = getglobal(tooltip:GetName() .. "TextLeft"..2);
		if(tooltip and tooltip:GetText()) then
			if(QuestItem_SearchString(tooltip:GetText(), QUESTITEM_QUESTITEM)) then
				return true;
			end
		end
	end
	return false;
end

--------------------------------------------
-- Open the specified quest in the quest log 
--------------------------------------------
--------------------------------------------
function QuestItem_OpenQuestLog(questName)
	for y=1, GetNumQuestLogEntries(), 1 do
		local QuestName, level, questTag, isHeader, isCollapsed, complete = GetQuestLogTitle(y);
		if(questName == QuestName) then
			SelectQuestLogEntry(y);
			local logFrame = getglobal("QuestLogFrame");

			if(logFrame ~= nil) then
				if(logFrame:IsVisible()) then
					ToggleQuestLog();
				end
				if(QuestLog_SetSelection == nil) then
					QuestLog_SetSelection(y);
				end
				ToggleQuestLog();
			end
			return;
		end
	end
	QuestItem_PrintToScreen(QUESTITEM_NO_QUEST);
end

---------------------------------------
-- Look for the item in the text string
---------------------------------------
---------------------------------------
function QuestItem_SearchString(text, item)
	if(string.find(string.lower(text), string.lower(item)) ) then
		return true;
	end
	return false;
end

-- Copied functions - don't want to depend on too many AddOns

-- From LootLink
function QuestItem_MakeIntFromHexString(str)
	if(not str) then
		return 0;
	end
	local remain = str;
	local amount = 0;
	while( remain ~= "" ) do
		amount = amount * 10;
		local byteVal = string.byte(strupper(strsub(remain, 1, 1)));
		if( byteVal >= string.byte("0") and byteVal <= string.byte("9") ) then
			amount = amount + (byteVal - string.byte("0"));
		end
		remain = strsub(remain, 2);
	end
	return amount;
end

function QuestItem_CheckNumeric(string)
	local remain = string;
	local hasNumber;
	local hasPeriod;
	local char;
	
	while( remain ~= "" and remain ~= nil) do
	--while( remain ~= "") do
		char = strsub(remain, 1, 1);
		if( char >= "0" and char <= "9" ) then
			hasNumber = 1;
		elseif( char == "." and not hasPeriod ) then
			hasPeriod = 1;
		else
			return nil;
		end
		remain = strsub(remain, 2);
	end
	
	return hasNumber;
end

-- From Sea
function QuestItem_ScanTooltip(tooltip)
	local tooltipBase
	if(not tooltip) then
		tooltipBase = "GameTooltip";
	else
		tooltipBase = tooltip:GetName();
	end
	
	local strings = {};
	for idx = 1, 10 do
		local textLeft = nil;
		local textRight = nil;
		ttext = getglobal(tooltipBase.."TextLeft"..idx);
		if(ttext and ttext:IsVisible() and ttext:GetText() ~= nil)
		then
			textLeft = ttext:GetText();
		end
		ttext = getglobal(tooltipBase.."TextRight"..idx);
		if(ttext and ttext:IsVisible() and ttext:GetText() ~= nil)
		then
			textRight = ttext:GetText();
		end
		if (textLeft or textRight)
		then
			strings[idx] = {};
			strings[idx].left = textLeft;
			strings[idx].right = textRight;
		end	
	end

	return strings;
end