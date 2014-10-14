
-- hold all logs
SL_LOG = {};
SL_LOG_LIST = {};
-- default key
SL_LOG_CURRENT = "Current session";
-- current log
SL_LOG_VIEW = SL_LOG_CURRENT;

StaticPopupDialogs["SL_CLEAR_LOG"] = {
	text = TEXT("Are you sure you want to clear log?"),
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		SL_ClearLog();
	end,
	OnCancel = function()
	end,
	timeout = 0,
	whileDead = 1,
};

------------------------------------------------------------------------------
-- non-UI code
------------------------------------------------------------------------------

function SL_AddToLog(logged, skipbroadcast)
	-- set date to logged item
	logged["date"] = date("%d.%m.%Y");
	-- add to log & deduct points
	if (not SL_LOG[SL_LOG_CURRENT]) then
		SL_LOG[SL_LOG_CURRENT] = {};
		table.insert(SL_LOG_LIST, SL_LOG_CURRENT);
	end
	table.insert(SL_LOG[SL_LOG_CURRENT], logged);
	SL_ModifyUsedDKP(logged.player, logged.bid);
	-- broadcast added loot
	if (GetNumRaidMembers()>0 and not skipbroadcast) then
		SL_SendLogEntry(logged);
	end
end

function SL_GetLogName(logdata)
	if (not logdata[1]) then return nil; end;
	local first = logdata[1].date;
	local last = logdata[table.getn(logdata)].date;
	if (first ~= last) then
		return first.." - "..last;
	else
		return first;
	end
end

------------------------------------------------------------------------------
-- UI code
------------------------------------------------------------------------------

SL_LOG_ITEMS_SHOWN = 25;

function SL_UI_LogDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, SL_UI_LogDropDown_Init, "MENU");
	UIDropDownMenu_Initialize(SL_Log_HistoryDropDown, SL_Log_HistoryDropDownInit);
	UIDropDownMenu_SetText(SL_LOG_CURRENT, SL_Log_HistoryDropDown); -- hoax
end

function SL_Log_HistoryDropDownInit()
	local i = 0;
	for _,name in SL_LOG_LIST do
		i=i+1;
		item = {};
		item.text = name;
		item.index = i;
		if (name == SL_LOG_VIEW) then
			item.checked = 1;
		end
		item.func = SL_SelectedLog;
		item.value = name;
		UIDropDownMenu_AddButton(item);
	end
end

function SL_SelectedLog()
	SL_LOG_VIEW = this.value;
	local text = this.value;
	local sp = string.find(text, "-");
	if (sp) then
		text = string.sub(text,1,sp-1).."...";
	end
	UIDropDownMenu_SetText(text, SL_Log_HistoryDropDown); -- hoax
	if (SL_LOG_VIEW~=SL_LOG_CURRENT) then
		SL_LogFrame_Clear:Hide();
	else
		SL_LogFrame_Clear:Show();
	end
	-- clear list
	for i=1, SL_LOG_ITEMS_SHOWN do
		local listFrame = "SL_LogItem"..i;
		getglobal(listFrame):Hide();
	end
	SL_UpdateLog();
end

-- when selecting entry from log
function SL_UI_LogDropDown_Init()
	item = {};
	item.text = "Remove selected";
	item.notCheckable = 1;
	item.func = SL_MenuRemoveFromLog;
	item.value = this.index;
	UIDropDownMenu_AddButton(item);
end

function SL_MenuRemoveFromLog()
	local player = SL_LOG[SL_LOG_VIEW][this.value].player;
	local points = SL_LOG[SL_LOG_VIEW][this.value].bid;
	local pool = SL_LOG[SL_LOG_VIEW][this.value].pool;
	-- refund points (only on current log, not on history!)
	if (SL_LOG_VIEW==SL_LOG_CURRENT) then
		if (SL_ModifyUsedDKP(player, -points, pool)) then
			SL_Print("Refunded "..points.." ("..pool..") points to "..player);
		end
	end
	SL_SendLogDel(SL_LOG[SL_LOG_VIEW][this.value]);
	table.remove(SL_LOG[SL_LOG_VIEW], this.value);
	SL_UpdateLog();
end

function SL_LogItem_OnClick(button)
	if (button=="RightButton") then
		ToggleDropDownMenu(1, nil, SL_LogFrame_DropDown, this:GetName(), 0, 0);
	end
	if (button=="LeftButton" and IsShiftKeyDown()) then
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:Insert(SL_LOG[SL_LOG_VIEW][this.id].item.link);
		end
	end
end

function SL_UpdateLog()
	-- clear & abort if nothing to show
	if (SL_IsEmpty(SL_LOG[SL_LOG_VIEW])) then
		for i=1, SL_LOG_ITEMS_SHOWN do
			local listFrame = "SL_LogItem"..i;
			getglobal(listFrame):Hide();
		end
		FauxScrollFrame_SetOffset(SL_LogScrollFrame, 0);
		SL_LogScrollFrameScrollBar:SetValue(0);
		return;
	end

	local offset = FauxScrollFrame_GetOffset(SL_LogScrollFrame);
	local size = table.getn(SL_LOG[SL_LOG_VIEW]);
	
	FauxScrollFrame_Update(SL_LogScrollFrame, size, SL_LOG_ITEMS_SHOWN, SL_ITEM_HEIGHT);
	for i=1, SL_LOG_ITEMS_SHOWN do
		local listFrame = "SL_LogItem"..i;
		if (offset+i > size) then -- quickfix on delete items at bottom ...
			getglobal(listFrame):Hide();
			return;
		end
		if (i > size) then 
			getglobal(listFrame):Hide();
		else
			local entry = SL_LOG[SL_LOG_VIEW][offset + i];
			local player = entry.player;
			local item = entry.item.link;
			local bid = entry.bid;
			local pool = entry.pool;
			
			getglobal(listFrame).index = offset + i;
			
			getglobal(listFrame.."Player"):SetText(player);
			getglobal(listFrame.."Item"):SetText(item);
			getglobal(listFrame.."Bid"):SetText(bid);
			local pooltext = "N/A";
			if (pool) then
				pooltext = pool;
			end
			getglobal(listFrame.."Pool"):SetText(pooltext);
			getglobal(listFrame).id = offset + i;
			
			getglobal(listFrame):Show();
		end
	end
end

function SL_ClearButton()
	StaticPopup_Show("SL_CLEAR_LOG");
end

-- stores current log to archive and starts new log
function SL_ClearLog()
	if (SL_LOG_VIEW~=SL_LOG_CURRENT) then
		SL_Print("ERROR: Cannot clear archived logs");
		return;
	end
	local name = SL_GetLogName(SL_LOG[SL_LOG_CURRENT]);
	if (not name) then 
		SL_Print("ERROR: Log already empty / Unable to clear");
		return; 
	end;
	-- if there exists already entry for this day add counter
	if (SL_LOG[name]) then
		for i=1, 100 do
			if (not SL_LOG[name.." ("..i..")"]) then
				name = name.." ("..i..")";
				break;
			end
		end
	end
	SL_Print("Saved log with name "..name);
	SL_LOG[name] = SL_LOG[SL_LOG_CURRENT];
	SL_LOG[SL_LOG_CURRENT] = {};
	table.insert(SL_LOG_LIST,2,name);
	if (table.getn(SL_LOG_LIST)>=15) then
		-- number 1 is always current, so delete nro 2!
		SL_LOG[SL_LOG_LIST[15]]=nil;
		table.remove(SL_LOG_LIST,15);
	end
	SL_UpdateLog();
end

function SL_LogItem_OnEnter()
	SL_LogHilight:SetPoint("LEFT", this:GetName(), "LEFT", 0, 0);
	SL_LogHilight:SetWidth(this:GetWidth());
	SL_LogHilight:Show();
	return;
	
	-- TODO: xxx BORKED
	--[[
	local player = getglobal(this:GetName().."Player"):GetText();
	local used = SL_GetPointsUsed(player);
	if (used>0) then
		GameTooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		GameTooltip:SetText("Total points used "..used,1,1,1,1,1);
	end
	--]]
end

function SL_LogItem_OnLeave()
	SL_LogHilight:Hide();
	GameTooltip:Hide();
end