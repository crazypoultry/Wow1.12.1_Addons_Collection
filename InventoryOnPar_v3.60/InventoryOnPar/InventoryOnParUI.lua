IOP_UI_TABLE_ROWS = 25;
IOP_UI_TABLE_ROW_PIXEL_HEIGHT = 16;

IOP_UI_TEXT_COLOUR = {};
IOP_UI_TEXT_COLOUR.LAST_SEEN = {};
IOP_UI_TEXT_COLOUR.LAST_SEEN.WITHIN_24HRS = {r = 0.25, g = 1.00, b = 0.25};
IOP_UI_TEXT_COLOUR.LAST_SEEN.OVER_24HRS = {r = 1.00, g = 0.82, b = 0};
IOP_UI_TEXT_COLOUR.PLAYER_NAME = {};
IOP_UI_TEXT_COLOUR.PLAYER_NAME.CURRENT = {r = 0.25, g = 1.00, b = 0.25};
IOP_UI_TEXT_COLOUR.PLAYER_NAME.OTHER = {r = 1.00, g = 0.82, b = 0};
IOP_UI_TEXT_COLOUR.SCORE = {};
IOP_UI_TEXT_COLOUR.SCORE.BELOW_PAR = {r = 0.61, g = 0.61, b = 0.61}; -- grey
IOP_UI_TEXT_COLOUR.SCORE.ON_PAR = {r = 0.12, g = 1.00, b = 0}; -- green
IOP_UI_TEXT_COLOUR.SCORE.ABOVE_PAR = {r = 1, g = 1, b = 0}; -- yellow
IOP_UI_TEXT_COLOUR.SCORE.WELL_ABOVE_PAR = {r = 1, g = 0.5, b = 0.0}; -- orange
IOP_UI_TEXT_COLOUR.SCORE.SIGNIFICANTLY_ABOVE_PAR = {r = 1.00, g = 0, b = 0}; -- red
IOP_UI_TEXT_COLOUR.SCORE.WOW = {r = 0.64, g = 0.21, b = 0.93}; -- purple

function IOP_UI_OnLoad()
	IOP_UI_SetInitialized(false);
end

function IOP_UI_RowOnLoad()
	this:RegisterForClicks("RightButtonUp");
	this:RegisterForClicks("LeftButtonUp");
end

function IOP_UI_OnShow()
	PlaySound("igMainMenuOption");
	IOP_UI_Initialize();
	InventoryOnParOption.Close();
end

function IOP_UI_OpenOptionMenu()
	ShowUIPanel(InventoryOnParOptionFrame);
end

function IOP_UI_CleanUpData()
	-- this routine will delete any data older than the retention date.
	DEFAULT_CHAT_FRAME:AddMessage("\nInventory On Par : The clean up button does nothing at present");
end

function IOP_UI_Close()
	HideUIPanel(this:GetParent());
	InventoryOnParFrame:Hide();
end

function IOP_UI_RowClicked(button)
	rowID = this:GetID();
	local lineOffset = FauxScrollFrame_GetOffset(InventoryOnParUIFrameTableScrollFrame);
	local playerName = IOP_UI_tableIndex[lineOffset + rowID];
	if (button == "RightButton") then
		-- IOP_DeletePlayerRecord(playerName);
		DEFAULT_CHAT_FRAME:AddMessage("\nInventory On Par : The delete option is not implemented yet");
	else
		IOP_UI_ShowTooltip(playerName);
	end
end

function IOP_UI_ShowTooltip(playerName)
	local playerInfo = IOP_GetPlayerRecord(playerName);
	if (playerInfo) then
		InventoryOnParText:SetJustifyH("LEFT");
		InventoryOnParText:SetJustifyV("MIDDLE");
		InventoryOnParText:SetText(playerName.."\n"..playerInfo.tooltipText);
		InventoryOnParFrame:Show();
	else
		InventoryOnParFrame:Hide();
	end
end

function IOP_UI_SetInitialized(initFlag)
	IOP_UI_initialized = initFlag;
end

function IOP_UI_SortPlayers(sortType)
	if (IOP_UI_tableSort == sortType) then
		if (IOP_UI_tableSortOrder == "asc") then
			IOP_UI_tableSortOrder = "desc";
		else
			IOP_UI_tableSortOrder = "asc";
		end
	else
		IOP_UI_tableSort = sortType;
		IOP_UI_tableSortOrder = "asc";
	end
	
	IOP_UI_BuildTableIndex();
end

function IOP_UI_Initialize()
	IOP_UI_tableSort = "playerName";
	IOP_UI_tableSortOrder = "asc";

	IOP_UI_SetTableTitle();
	IOP_AddCurrentPlayer();
	IOP_UI_BuildTableIndex();
	IOP_UI_initialized = true;
	InventoryOnParFrame:Hide();
end

function IOP_UI_ResetTable()
	IOP_UI_ClearTable();
	IOP_UI_UpdateTable();
	FauxScrollFrame_Update(InventoryOnParUIFrameTableScrollFrame, table.getn(IOP_UI_tableIndex), IOP_UI_TABLE_ROWS, IOP_UI_TABLE_ROW_PIXEL_HEIGHT);
end

function IOP_UI_BuildTableIndex()
	local playerList = IOP_GetPlayers();
	local numberOfPlayers = 0;
	
	IOP_UI_tableIndex = {};
	
	local currentIndex = nil;
	local nextIndex = nil;
	
	for playerName, playerInfo in playerList do
		numberOfPlayers = numberOfPlayers + 1;
		IOP_UI_InsertPlayerInTableIndex(playerName);
	end
	IOP_UI_ResetTable();
end

function IOP_UI_SortPlayerName(playerName, indexedPlayerName)
	if (type(playerName) == "string" and type(indexedPlayerName) == "string") then
		if ((IOP_UI_tableSortOrder == "desc" and playerName >= indexedPlayerName) or (IOP_UI_tableSortOrder == "asc" and playerName <= indexedPlayerName)) then
			return true
		end
	end
	return false
end

function IOP_UI_ComparePlayers(field, player1, player2)
	local player1Value;
	local player2Value;
	if (field =="class") then
		player1Value = player1.class;
		player2Value = player2.class;
	elseif(field == "level") then
		player1Value = player1.playerLevel;
		player2Value = player2.playerLevel;
	elseif(field == "date") then
		player1Value = player1.recordedTime;
		player2Value = player2.recordedTime;
	end
	if(player1Value < player2Value) then
		return -1;
	elseif(player1Value > player2Value) then
		return 1;
	else
		return player2.IOP_Score - player1.IOP_Score;
	end
end	

function IOP_UI_SortField(field, playerName, indexedPlayerName)
	if (type(playerName) == "string" and type(indexedPlayerName) == "string") then
		local playerInfo = IOP_GetPlayerRecord(playerName);
		local indexedPlayerInfo = IOP_GetPlayerRecord(indexedPlayerName);
		if (playerInfo and indexedPlayerInfo) then
			if (IOP_UI_tableSortOrder == "desc" and IOP_UI_ComparePlayers(field, playerInfo, indexedPlayerInfo) >=0) then
				return true;
			end
			if (IOP_UI_tableSortOrder == "asc" and IOP_UI_ComparePlayers(field, playerInfo, indexedPlayerInfo) <=0) then
				return true
			end
		end
	end

	return false
end

function IOP_UI_SortByField(playerName, indexedPlayerName)
	local playerInfo = IOP_GetPlayerRecord(playerName);
	local indexedPlayerInfo = IOP_GetPlayerRecord(indexedPlayerName);
	
	if (playerInfo and indexedPlayerInfo and type(playerInfo[IOP_UI_tableSort]) == "number" and type(indexedPlayerInfo[IOP_UI_tableSort]) == "number") then
		value = playerInfo[IOP_UI_tableSort];
		indexedValue = indexedPlayerInfo[IOP_UI_tableSort];
		if ((IOP_UI_tableSortOrder == "desc" and value >= indexedValue) or (IOP_UI_tableSortOrder == "asc" and value <= indexedValue)) then
			return true
		end
	end

	return false
end

function IOP_UI_InsertPlayerInTableIndex(playerName)
	local rowInserted = false;
	for rowID, indexedPlayerName in IOP_UI_tableIndex do
		local insertRow = false;
		if (IOP_UI_tableSort == "playerName") then
			if (IOP_UI_SortPlayerName(playerName, indexedPlayerName)) then
				insertRow = true;
			end
		elseif (IOP_UI_tableSort == "playerClass") then
			if (IOP_UI_SortField("class", playerName, indexedPlayerName))then
				insertRow = true;
			end
		elseif (IOP_UI_tableSort == "playerLevel") then
			if (IOP_UI_SortField("level", playerName, indexedPlayerName))then
				insertRow = true;
			end
		elseif (IOP_UI_tableSort == "recordedTime") then
			if (IOP_UI_SortField("date", playerName, indexedPlayerName))then
				insertRow = true;
			end
		else
			if (IOP_UI_SortByField(playerName, indexedPlayerName)) then
				insertRow = true;
			end
		end
		if (insertRow) then
			table.insert(IOP_UI_tableIndex, rowID, playerName);
			rowInserted = true;
			break;
		end
	end
	if (not rowInserted) then
		table.insert(IOP_UI_tableIndex, playerName);
	end
end

function IOP_UI_SetTableTitle()
	local tableTitle = getglobal("InventoryOnParUIFrameTableTitle");
	tableTitle:SetText("Inventory On Par Scores for "..GetRealmName());
end

function IOP_UI_SetTableStatus(status)
	local tableStatus = getglobal("InventoryOnParUIFrameTableStatus");
	tableStatus:SetText(status);
	tableStatus:SetWidth(tableStatus:GetStringWidth());
end

function IOP_UI_ClearTable()
	local lineNumber = 0;
	while (lineNumber < IOP_UI_TABLE_ROWS) do
		lineNumber = lineNumber + 1;
		IOP_UI_ClearRow(lineNumber);
	end
	FauxScrollFrame_Update(InventoryOnParUIFrameTableScrollFrame, 0, IOP_UI_TABLE_ROWS, IOP_UI_TABLE_ROW_PIXEL_HEIGHT);
end

function IOP_UI_ClearRow(lineNumber)
	getglobal("InventoryOnParUIFrameTableRowButton"..lineNumber):Hide();
	getglobal("InventoryOnParUIFrameTableRowButton"..lineNumber.."PlayerName"):SetText("");
	getglobal("InventoryOnParUIFrameTableRowButton"..lineNumber.."PlayerLevel"):SetText("");
	getglobal("InventoryOnParUIFrameTableRowButton"..lineNumber.."PlayerClass"):SetText("");
	getglobal("InventoryOnParUIFrameTableRowButton"..lineNumber.."LastSeen"):SetText("");
	getglobal("InventoryOnParUIFrameTableRowButton"..lineNumber.."IOPScore"):SetText("");
end

function IOP_UI_UpdateTable()
	local numberOfPlayers = 0;
	local lineOffset = FauxScrollFrame_GetOffset(InventoryOnParUIFrameTableScrollFrame);
	local lineNumber = 0;

	while ((lineNumber < IOP_UI_TABLE_ROWS) and (lineNumber + lineOffset < table.getn(IOP_UI_tableIndex))) do
		lineNumber = lineNumber + 1;
		
		local playerName = IOP_UI_tableIndex[lineNumber + lineOffset];
		local playerInfo = IOP_GetPlayerRecord(playerName);
		
		if (playerInfo ~= nil) then
			getglobal("InventoryOnParUIFrameTableRowButton"..lineNumber):Show();
			getglobal("InventoryOnParUIFrameTableRowButton"..lineNumber.."PlayerName"):SetText(playerName);
			getglobal("InventoryOnParUIFrameTableRowButton"..lineNumber.."PlayerLevel"):SetText(playerInfo.playerLevel);
			getglobal("InventoryOnParUIFrameTableRowButton"..lineNumber.."PlayerClass"):SetText(playerInfo.class);
			getglobal("InventoryOnParUIFrameTableRowButton"..lineNumber.."LastSeen"):SetText(date(IOP.Options.dateFormat, playerInfo.recordedTime));
			getglobal("InventoryOnParUIFrameTableRowButton"..lineNumber.."IOPScore"):SetText(format("%.2f", playerInfo.IOP_Score));

			local playerTextColour = nil;
			if (playerName == UnitName("player")) then
				playerTextColour = IOP_UI_TEXT_COLOUR.PLAYER_NAME.CURRENT;
			else
				playerTextColour = IOP_UI_TEXT_COLOUR.PLAYER_NAME.OTHER;
			end
			getglobal("InventoryOnParUIFrameTableRowButton"..lineNumber.."PlayerName"):SetTextColor(playerTextColour.r, playerTextColour.g, playerTextColour.b);
			getglobal("InventoryOnParUIFrameTableRowButton"..lineNumber.."PlayerLevel"):SetTextColor(playerTextColour.r, playerTextColour.g, playerTextColour.b);
			getglobal("InventoryOnParUIFrameTableRowButton"..lineNumber.."PlayerClass"):SetTextColor(playerTextColour.r, playerTextColour.g, playerTextColour.b);
			
			if (playerInfo.IOP_Score < 0) then
				scoreTextColour = IOP_UI_TEXT_COLOUR.SCORE.BELOW_PAR; 
			elseif (playerInfo.IOP_Score < 50) then
				scoreTextColour = IOP_UI_TEXT_COLOUR.SCORE.ON_PAR; -- score 0 to 49
			elseif (playerInfo.IOP_Score < 100) then
				scoreTextColour = IOP_UI_TEXT_COLOUR.SCORE.ABOVE_PAR; -- score 50 - 99
			elseif (playerInfo.IOP_Score < 200) then
				scoreTextColour = IOP_UI_TEXT_COLOUR.SCORE.WELL_ABOVE_PAR; -- score 100 - 199
			elseif (playerInfo.IOP_Score < 300) then
				scoreTextColour = IOP_UI_TEXT_COLOUR.SCORE.SIGNIFICANTLY_ABOVE_PAR; -- score 200 - 299
			else
				scoreTextColour = IOP_UI_TEXT_COLOUR.SCORE.WOW; -- score 300+
			end
			getglobal("InventoryOnParUIFrameTableRowButton"..lineNumber.."IOPScore"):SetTextColor(scoreTextColour.r, scoreTextColour.g, scoreTextColour.b);
		end
	end
	
	for lineNumber = lineNumber + 1, IOP_UI_TABLE_ROWS, 1 do
		IOP_UI_ClearRow(lineNumber);
	end
end

function IOP_UI_GetLastSeenTextColor(aTime)
	local textColor = nil;
	local currentTime = time();
	
	textColor = IOP_UI_TEXT_COLOUR.LAST_SEEN.OVER_24HRS;
	if (atime) then 
		if (currentTime-atime <= 60*60*24) then
			textColor = IOP_UI_TEXT_COLOUR.LAST_SEEN.WITHIN_24HRS;
		end
	end
	
	return textColor;
end

function IOP_UI_SetWidth(width, frame)
	if ( not frame ) then
		frame = this;
	end
	frame:SetWidth(width);
	getglobal(frame:GetName().."Middle"):SetWidth(width - 9);
end