-- global variables for list
SL_ITEMS_SHOWN = 10;
SL_ITEM_HEIGHT = 14;

-- global variables for UI
SL_DISPLAYING_ITEM = nil;

-- selected item in list (name of player)
SL_SELECTED_PLAYER = nil;

function SL_UpdateUI()
	if (not SL_GetEntry(SL_DISPLAYING_ITEM)) then
		SL_DISPLAYING_ITEM = nil;
	end
	if (not SL_DISPLAYING_ITEM and not SL_IsEmpty(SL_ENTRIES)) then
		SL_UpdateItem(1);
	end
	SL_UpdateItem(0);
	SL_UpdateList();
end

function SL_GetCurrentItem()
	local entry = SL_GetEntry(SL_DISPLAYING_ITEM);
	if (not entry) then return; end;
	return entry.item;
end

SL_TIME_UPDATED = 1;
function SL_UI_OnUpdate(elapsed)
	SL_TIME_UPDATED = SL_TIME_UPDATED - elapsed;
	if (SL_TIME_UPDATED > 0) then
		return;
	end
	SL_TIME_UPDATED = 1;
	
	local entry = SL_GetEntry(SL_DISPLAYING_ITEM);
	if (entry) then
		local uptime = time() - entry.started;
		local idle = time() - entry.lastaction;
		SL_UI_TimeInfo:SetText(string.format("Uptime %ss", uptime));
		if (idle > SL_OPTIONS.FaderLength) then idle = SL_OPTIONS.FaderLength; end;
		local half = SL_OPTIONS.FaderLength/2;
		local r = 1;
		local g = (1/half * idle);
		if (idle>half) then
			r = 1 - (1/half * (idle-half));
			g = 1;
		end
		SL_UI_TimeInfo:SetTextColor(r,g,0);
	else
		SL_UI_TimeInfo:SetText("");
	end
	
end
	
function SL_DisableButtons()
	SL_UI_Cancel:Disable();
	SL_UI_CancelAll:Disable();
	SL_UI_Close:Disable();
	SL_UI_CloseAll:Disable();
	SL_NextItem:Disable();
	SL_PrevItem:Disable();
end

function SL_EnableButtons()
	SL_UI_Cancel:Enable();
	SL_UI_CancelAll:Enable();
	SL_UI_Close:Enable();
	SL_UI_CloseAll:Enable();
end

function SL_UpdateItem(move)
	local items = {};
	local current = 0;
	local count = 0;
	for _,entry in SL_ENTRIES do
		count = count + 1;
		table.insert(items, entry.item.name);
		if (entry.item.name == SL_DISPLAYING_ITEM) then
			current = count;
		end
	end
	local new = current + move;
	-- if no open items
	if (SL_IsEmpty(items)) then
		SL_UI_PageInfo:SetText("Item (0/0)");
		SL_UI_ItemInfo:SetText("");
		SL_ListHeaderAmount:SetText("n/a");
		SL_DisableButtons();
		SL_ClearList();
		SL_UpdateList();
		return;
	end
	SL_EnableButtons();
	if (move~=0) then
		-- reset scrollable elements
		SL_ListHilight:Hide();
		FauxScrollFrame_SetOffset(SL_ListScrollFrame, 0);
		SL_ListScrollFrameScrollBar:SetValue(0);
	end
	-- watch for boundaries
	if (new < 1 or new > count) then
		return;
	end
	-- enable / disable prev & next buttons
	if (new-1 < 1) then
		SL_PrevItem:Disable();
	else
		SL_PrevItem:Enable();
	end
	if (new+1 > count) then
		SL_NextItem:Disable();
	else
		SL_NextItem:Enable();
	end
	
	SL_DISPLAYING_ITEM = items[new];

	SL_UI_PageInfo:SetText("Item ("..tostring(new).."/"..tostring(count)..")");
	SL_UI_ItemInfo:SetText(SL_DISPLAYING_ITEM);
	
	local roll = false;
	local re = SL_GetRollEntry();
	if (re) then
		if (re.item.name == SL_DISPLAYING_ITEM) then
			roll = true;
		end
	end
	
	if (roll) then
		SL_ListHeaderAmount:SetText("Roll");
	else
		SL_ListHeaderAmount:SetText("Bid");
	end
	-- update timer texts
	SL_TIME_UPDATED = 0;
		
	SL_UpdateList();
end

function SL_SetListWidth(width)
	local item = getglobal("SL_ListHeader");
	local amount = getglobal("SL_ListHeaderAmount");
	item:SetWidth(width);
	amount:SetWidth(width-140+50);
	for i=1, 10 do
		item = getglobal("SL_ListItem"..i);
		amount = getglobal("SL_ListItem"..i.."Amount");
		item:SetWidth(width);
		amount:SetWidth(width-140+50);
	end
end

function SL_ClearList()
	for i=1, SL_ITEMS_SHOWN do
		local listFrame = "SL_ListItem"..i;
		getglobal(listFrame):Hide();
	end;
end

function SL_UpdateList()
	-- abort if nothing to show
	if (SL_IsEmpty(SL_ENTRIES) or not SL_DISPLAYING_ITEM) then
		SL_ClearList();
		-- hide scrollbar (propably not best way to do..)
		FauxScrollFrame_Update(SL_ListScrollFrame, 0, SL_ITEMS_SHOWN, SL_ITEM_HEIGHT);
		SL_SetListWidth(165);
		SL_ListHeader:Hide();
		return;
	end
	SL_ListHeader:Show();

	local offset = FauxScrollFrame_GetOffset(SL_ListScrollFrame);
	local entry = SL_GetEntry(SL_DISPLAYING_ITEM);
	local entries = entry.bids;
	local size = table.getn(entries);
	if (size<=10) then
		SL_SetListWidth(165);
	else
		SL_SetListWidth(140);
	end
	
	FauxScrollFrame_Update(SL_ListScrollFrame, size, SL_ITEMS_SHOWN, SL_ITEM_HEIGHT);
	for i=1, SL_ITEMS_SHOWN do
		local listFrame = "SL_ListItem"..i;
		if (i>size or entries[offset + i]==nil) then 
			getglobal(listFrame):Hide();
		else
			local player = entries[offset + i].player;
			local amount = entries[offset + i].amount;
			local exceeds = entries[offset + i].exceeds;
			
			getglobal(listFrame.."Player"):SetText(player);
			getglobal(listFrame.."Amount"):SetText(amount);
			-- colorize text by class
			local c = RAID_CLASS_COLORS[SL_GetPlayerClass(player)];
			if (c) then
				getglobal(listFrame.."Player"):SetTextColor(c.r, c.g, c.b);
			else
				getglobal(listFrame.."Player"):SetTextColor(1,0,0);
			end
			-- if bid exceeds player reserver, show bid in red
			if (exceeds) then
				getglobal(listFrame.."Amount"):SetTextColor(1, 0, 0);
			else
				getglobal(listFrame.."Amount"):SetTextColor(0, 0.8, 1);
			end
			
			-- hilight
			if (player == SL_SELECTED_PLAYER) then
				SL_HilightItem(listFrame);
			end
			
			getglobal(listFrame):Show();
		end
	end
end

function SL_UI_ListDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, SL_UI_ListDropDown_Init, "MENU");
end

function SL_UI_ListDropDown_Init()
	local item = {};
	item.text = "Disqualify selected";
	item.notCheckable = 1;
	item.func = SL_List_Cancel;
	UIDropDownMenu_AddButton(item);
end

function SL_List_Cancel()
	SL_Disqualify(SL_GetCurrentItem(), SL_SELECTED_PLAYER);
	SL_SELECTED_PLAYER = nil;
	SL_ListHilight:Hide();
	SL_UpdateUI();
end

-- hilighting and selection is pretty much specialized to this particular case and 
-- does NOT suit for lists that have example duplicate elements
function SL_HilightItem(name)
	local item = getglobal(name);
	SL_ListHilight:SetPoint("LEFT", name, "LEFT", 0, 0);
	SL_ListHilight:SetWidth(item:GetWidth());
	SL_ListHilight:Show();
end

function SL_ListItem_OnClick(button)
	local item = getglobal(this:GetName().."Player");
	SL_SELECTED_PLAYER = item:GetText();
	SL_HilightItem(this:GetName());
	if (button=="RightButton") then
		ToggleDropDownMenu(1, nil, SL_UI_ListDropDown, this:GetName(), 0, 0);
	end
end

function SL_ListItem_OnEnter()
	if (this:GetID()==0) then return; end;
	local player = getglobal(this:GetName().."Player"):GetText();
	local used = tonumber(SL_GetPointsUsed(player));
	-- check for exceed in dkp data
	local bid = tonumber(getglobal(this:GetName().."Amount"):GetText());
	local exceed = false;
	local points = 0;
	if (SL_IsDkpIntegrated()) then
		points = SL_GetPlayerPoints(player);
		exceed = points - bid < 0;
	end
	local pending = SL_GetPointsPending(player);
	
	if (used>0 or exceed or pending~=bid) then
		GameTooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
		local text = "Total points used "..used;
		if (exceed) then
			text = text..".\nExceeds points left by "..-(points - bid).."!";
		end
		if (pending~=bid) then
			local amount = pending-bid;
			if (amount<0) then
				amount = -amount;
			end
			text = text.."\nBidded "..amount.." points to other open bids!";
		end
		GameTooltip:SetText(text,1,1,1,1,1);
	end
end

-- return number of points used by player, for TOOLTIPS ONLY
function SL_GetPointsUsed(player, pool)
	if (SL_IsDkpIntegrated()) then
		return SL_GetPointsUsedFromDKP(pool, player);
	else
		return SL_GetPointsUsedFromLog(nil, player);
	end
end

function SL_ListItem_OnLeave()
	GameTooltip:Hide();
end