BINDING_HEADER_DMIN = "Discord Mini Inventory v1.0";
BINDING_NAME_DMIN_TOGGLE = "Toggle Mini Inventory";

DMIN_TEXT = {
	Rarity = {
		[0] = "Poor",
		[1] = "Common",
		[2] = "Uncommon",
		[3] = "Rare",
		[4] = "Epic",
		[5] = "Legendary"
	},
	Used = "Used",
	Bag = "Bag",
	Slot = "Slot",
	ScaleSet = "Discord Mini Inventory scale set to $n.",
	Reset = "Discord Mini Inventory location reset.",
	ReplaceOn = "Discord Mini Inventory is set to replace the default inventory.",
	ReplaceOff = "Discord Mini Inventory is no longer set to replace the default inventory.",
	SelfCastOn = "Discord Mini Inventory is set to self-cast items by default.",
	SelfCastOff = "Discord Mini Inventory is no longer set to self-cast items by default.",
	CombineOn = "Discord Mini Inventory will now combine stacks.",
	CombineOff = "Discord Mini Inventory will no longer combine stacks.",
	ShowEmptyOn = "Discord Mini Inventory will now show empty buttons when viewing the ALL and bag tabs.",
	ShowEmptyOff = "Discord Mini Inventory will no longer show empty buttons when viewing the ALL and bag tabs.",
	DragLocked = "Discord Mini Inventory dragging locked.",
	DragUnlocked = "Discord Mini Inventory dragging unlocked.",
	NoCloseOn = "Discord Mini Inventory set to not close when leaving the mailbox, merchant windows, etc.",
	NoCloseOff = "Discord Mini Inventory set to close when leaving the mailbox, merchant windows, etc.",
	BagFull = "That bag is full.",
	NoTabsLeft = "You've used up all 5 custom tabs already one.  You'll have to delete with /dmin cleartab tabName.",
	All = "ALL",
	Backpack = "Backpack",
	Compact = "Compact",
	Details = "Details",
	SortBy = "Sort By: ",
	bag = "Bag",
	name = "Name",
	quality = "Quality",
	itemType = "Type",
	level = "Level",
	Free = "Free",
	Unusable = "Unusable",
	Empty = "< EMPTY >",
	EmptyTab = "Empty Slots",
	StackedItems = "Stacks",
	Soulbound = "Soulbound"
};

DMIN_HELPTEXT = {
	"DISCORD MINI INVENTORY v1.0",
	"--------------------------------------------------",
	"/dmin - toggle the inventory",
	"/dmin scale # - set the inventory's scale, 1-200",
	"/dmin reset - reset the inventory to the middle of the screen",
	"/dmin replace - replace the default bags",
	"/dmin selfcast - set items to self-cast by default from the inventory",
	"/dmin combine - set multiple stacks to combine into 1 button",
	"/dmin tabs - toggles the side tabs",
	"/dmin bags - toggles the bag tabs",
	"/dmin compact - toggles between compact and details mode",
	"/dmin drag - toggles the ability to drag the frame",
	"/dmin bag name - sets the name of a bag in the tab; bag can be backpack, bag1, bag2, bag3, bag4",
	"/dmin noclose - turning this on will keep the frame from closing when you leave the mailbox, merchant, etc.",
	"/dmin showempty - turning this on will show empty bag buttons when viewing the ALL and bag tabs",
	'/dmin ctab "tab name" "item name" - creates a custom tab with the name you specify and adds the item to it',
	"               The quotes are necessary around the names.",
	"               You can have up to 5 custom tabs.",
	'/dmin cleartab tabName - deletes the specified custom tab'
};

function DMIN_OnEvent(event)
	if (event == "PLAYER_ENTERING_WORLD") then
		DMIN_ENTERING_WORLD = true;
		if (DMIN_VARIABLES_LOADED) then
			DMIN_Initialize();
		end
	elseif (event == "VARIABLES_LOADED") then
		DMIN_VARIABLES_LOADED = true;
		if (DMIN_ENTERING_WORLD) then
			DMIN_Initialize();
		end
	elseif (event == "BAG_UPDATE" or event == "PLAYER_LEVEL_UP" or event == "SKILL_LINES_CHANGED" or event == "CHARACTER_POINTS_CHANGED") then
		this.updateItems = true;
		if (this:IsVisible()) then
			DMIN_OnShow();
		end
	elseif (event == "BAG_UPDATE_COOLDOWN" or event == "UPDATE_INVENTORY_ALERTS") then
		if (this:IsVisible()) then
			DMIN_ScrollFrame_Update();
		end
	elseif (event == "ITEM_LOCK_CHANGED") then
		if (DMIN_COMPRESSING_STACKS) then
			DMIN_Compress_NextItem();
		end
		if (this:IsVisible()) then
			DMIN_ScrollFrame_Update();
		end
	elseif (event == "PLAYER_MONEY") then
		DMIN_Update_Money();
	end
end

function DMIN_Hook_ToggleBags()
	if (DMIN_Old_OpenBag) then return; end
	DMIN_Old_OpenBag = OpenBag;
	OpenBag = DMIN_OpenBag;
	DMIN_Old_CloseBag = CloseBag;
	CloseBag = DMIN_CloseBag;
	DMIN_Old_OpenBackpack = OpenBackpack;
	OpenBackpack = DMIN_OpenBackpack;
	DMIN_Old_CloseBackpack = CloseBackpack;
	CloseBackpack = DMIN_CloseBackpack;
	DMIN_Old_OpenAllBags = OpenAllBags;
	OpenAllBags = DMIN_Toggle_Inventory;
	DMIN_Old_ToggleBag = ToggleBag;
	ToggleBag = DMIN_ToggleBag;
end

function DMIN_OpenBackpack()
	DiscordMiniInventoryFrame:Show();
end

function DMIN_CloseBackpack()
	if (not DMIN_Settings.noClose) then
		DiscordMiniInventoryFrame:Hide();
	end
end

function DMIN_OpenBag(id)
	if (id < 5) then
		DiscordMiniInventoryFrame:Show();
	else
		DMIN_Old_OpenBag(id);
	end
end

function DMIN_CloseBag(id)
	if (id < 5) then
		DiscordMiniInventoryFrame:Hide();
	else
		DMIN_Old_CloseBag(id);
	end
end

function DMIN_ToggleBag(id)
	if (id < 5) then
		DMIN_Toggle_Inventory();
	else
		DMIN_Old_ToggleBag(id);
	end
end

function DMIN_Unhook_ToggleBags()
	if (not DMIN_Old_OpenBag) then return; end
	OpenBag = DMIN_Old_OpenBag;
	CloseBag = DMIN_Old_CloseBag;
	OpenBackpack = DMIN_Old_OpenBackpack;
	CloseBackpack = DMIN_Old_CloseBackpack;
	OpenAllBags = DMIN_Old_OpenAllBags;
	ToggleBag = DMIN_Old_ToggleBag;
	DMIN_Old_OpenBag = nil;
	DMIN_Old_CloseBag = nil;
	DMIN_Old_OpenBackpack = nil;
	DMIN_Old_OpenAllBags = nil;
	DMIN_Old_ToggleBag = nil;
	DMIN_Old_CloseBackpack = nil;
end

function DMIN_Initialize()
	if (DMIN_INITIALIZED) then return; end
	if (not DMIN_Settings) then
		DMIN_Settings = {
			scale = 1,
			colors = {
				[0] = {r=.5, g=.5, b=.5},
				[1] = {r=1, g=1, b=1},
				[2] = {r=0, g=1, b=0},
				[3] = {r=.3, g=.3, b=1},
				[4] = {r=1, g=0, b=1},
				[5] = {r=1, g=1, b=0}
			},
			combine = nil
		};
	end
	DiscordMiniInventoryFrame:SetScale(DMIN_Settings.scale);
	 tinsert(UISpecialFrames,"DiscordMiniInventoryFrame");
	if (DMIN_Settings.replace) then
		DMIN_Hook_ToggleBags();
	end
	if (DMIN_Settings.hideTabs) then
		DMIN_TabButtonBackdrop:Hide();
		DMIN_ToggleTabsButton:SetText(">");
	else
		DMIN_ToggleTabsButton:SetText("<");
	end
	if (DMIN_Settings.compact) then
		DMIN_ToggleCompactButton:SetText(DMIN_TEXT.Details);
	else
		DMIN_ToggleCompactButton:SetText(DMIN_TEXT.Compact);
	end
	DiscordMiniInventoryFrame.lastclicked = "DMIN_TabButton_1";
	DiscordMiniInventoryFrame_Header:SetText(DMIN_TEXT.All);
	for b=1,10 do
		for i=2,8 do
			local button = getglobal("DMIN_ScrollButton_"..b.."_ItemButton_"..i);
			button:ClearAllPoints();
			button:SetPoint("LEFT", "DMIN_ScrollButton_"..b.."_ItemButton_"..(i - 1), "RIGHT", 3.5, 0);
			if (not DMIN_Settings.compact) then
				button:Hide();
			end
		end
		if (DMIN_Settings.compact) then
			getglobal("DMIN_ScrollButton_"..b.."_Border"):Hide();
			getglobal("DMIN_ScrollButton_"..b.."_Name"):Hide();
			getglobal("DMIN_ScrollButton_"..b.."_Type"):Hide();
			getglobal("DMIN_ScrollButton_"..b.."_Rarity"):Hide();
			getglobal("DMIN_ScrollButton_"..b.."_Location"):Hide();
		end
	end
	if (DMIN_Settings.hideBags) then
		DMIN_ToggleBagsButton:SetText("v");
		for i=0, 4 do
			getglobal("DMIN_BagTab_"..i):Hide();
		end
	end
	if (not DMIN_Settings.sortBy) then
		DMIN_Settings.sortBy = "bag";
	end
	if (not DMIN_Settings.bagNames) then
		DMIN_Settings.bagNames = {};
		DMIN_Settings.bagNames[0] = DMIN_TEXT.Backpack;
		for i=1, 4 do
			DMIN_Settings.bagNames[i] = DMIN_TEXT.Bag.." "..i;
		end
	end
	DMIN_SortByButton:SetText(DMIN_TEXT.SortBy..DMIN_TEXT[DMIN_Settings.sortBy]);
	DMIN_DropMenu_Option1.value = "bag";
	DMIN_DropMenu_Option2.value = "name";
	DMIN_DropMenu_Option3.value = "itemType";
	DMIN_DropMenu_Option4.value = "quality";
	DMIN_DropMenu_Option5.value = "level";
	for i=1,5 do
		local button = getglobal("DMIN_DropMenu_Option"..i);
		getglobal("DMIN_DropMenu_Option"..i.."_Text"):SetText(DMIN_TEXT[button.value]);
		if (i > 1) then
			button:SetPoint("TOP", "DMIN_DropMenu_Option"..(i-1), "BOTTOM", 0, 0);
		end
	end
	if (not DMIN_Settings.CustomTabs) then
		DMIN_Settings.CustomTabs = {};
	end
	DMIN_INITIALIZED = true;
	DMIN_Update_Money();
end

function DMIN_OnLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("BAG_UPDATE_COOLDOWN");
	this:RegisterEvent("ITEM_LOCK_CHANGED");
	this:RegisterEvent("UPDATE_INVENTORY_ALERTS");
	this:RegisterEvent("PLAYER_MONEY");
	this:RegisterEvent("PLAYER_LEVEL_UP");
	this:RegisterEvent("SKILL_LINES_CHANGED");
	this:RegisterEvent("CHARACTER_POINTS_CHANGED");
	this:SetBackdropColor(0, 0, 0, 1);
	this:SetBackdropBorderColor(1, 0, 0, 1);
	this:RegisterForDrag("LeftButton");
	this.updateItems = true;

	SlashCmdList["DMIN"] = DMIN_Slash_Handler;
	SLASH_DMIN1 = "/dmin";
	SLASH_DMIN2 = "/discordminiinventory";
end

function DMIN_OnClick()
	local start = 0;
	local finish = 4;
	if (DiscordMiniInventoryFrame.showingBag) then
		start = DiscordMiniInventoryFrame.showingBag;
		finish = DiscordMiniInventoryFrame.showingBag;
	end
	if (CursorHasItem()) then
		for bag=start,finish do
			local bagslots = GetContainerNumSlots(bag);
			if (bagslots) then
				for slot = 1, bagslots do
					if (not  GetContainerItemInfo(bag, slot)) then
						PickupContainerItem(bag, slot);
						return;
					end
				end
			end
		end
		UIErrorsFrame:AddMessage(DMIN_TEXT.BagFull, 1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME);
	end
end

function DMIN_OnShow(override)
	DMIN_Tooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
	if (this.updateItems or override) then
		DMIN_Update_ItemList();
		DMIN_Update_Tabs();
		DMIN_BagTabs_Update();
		this.updateItems = nil;
	end
	DMIN_ScrollFrame_Update();
end

function DMIN_ScrollFrame_Update()
	if (StackSplitFrame:IsShown()) then return; end
	local numOptions = table.getn(DMIN_ITEM_LIST);
	if (DMIN_Settings.compact) then
		numOptions = math.ceil(numOptions / 8);
	end
	local offset = FauxScrollFrame_GetOffset(DMIN_ScrollFrame);
	
	if (DMIN_Settings.freeSlots) then
		local freeslots = DMIN_SLOTS_COUNT - DMIN_SLOTS_USED;
		DiscordMiniInventoryFrame_Slots:SetText(DMIN_TEXT.Free..": "..freeslots.."/"..DMIN_SLOTS_COUNT);
	else
		DiscordMiniInventoryFrame_Slots:SetText(DMIN_TEXT.Used..": "..DMIN_SLOTS_USED.."/"..DMIN_SLOTS_COUNT);
	end
	
	local index;
	local hiddenCount = 0;
	for i=1, 10 do
		local button = getglobal("DMIN_ScrollButton_"..i);

		if (DMIN_Settings.compact) then
			index = (i + offset - 1) * 8 + 1;
			if ( DMIN_ITEM_LIST[index] ) then
				button:Show();
				DMIN_Init_ItemButton(i, 1, index);
				DMIN_Init_ItemButton(i, 2, index + 1);
				DMIN_Init_ItemButton(i, 3, index + 2);
				DMIN_Init_ItemButton(i, 4, index + 3);
				DMIN_Init_ItemButton(i, 5, index + 4);
				DMIN_Init_ItemButton(i, 6, index + 5);
				DMIN_Init_ItemButton(i, 7, index + 6);
				DMIN_Init_ItemButton(i, 8, index + 7);
			else
				button:Hide();
				hiddenCount = hiddenCount + 1;
			end
		else
			index = offset + i;
			if ( DMIN_ITEM_LIST[index] ) then
				button:Show();
				local quality = DMIN_ITEM_LIST[index].quality;
				local nameText = getglobal("DMIN_ScrollButton_"..i.."_Name");
				local typeText = getglobal("DMIN_ScrollButton_"..i.."_Type");
				local rarityText = getglobal("DMIN_ScrollButton_"..i.."_Rarity");
				local locText = getglobal("DMIN_ScrollButton_"..i.."_Location");

				if (DMIN_ITEM_LIST[index].soulbound) then
					nameText:SetText("*"..DMIN_ITEM_LIST[index].name);
				else
					nameText:SetText(DMIN_ITEM_LIST[index].name);
				end
				if (DMIN_ITEM_LIST[index].unusable) then
					nameText:SetTextColor(1, 0, 0);
				else
					nameText:SetTextColor(DMIN_Settings.colors[quality].r, DMIN_Settings.colors[quality].g, DMIN_Settings.colors[quality].b);
				end

				DMIN_Init_ItemButton(i, 1, index);

				typeText:SetText(DMIN_ITEM_LIST[index].itemType);
				if (DMIN_ITEM_LIST[index].level > 0) then
					rarityText:SetText(DMIN_TEXT.level.." "..DMIN_ITEM_LIST[index].level);
					if (DMIN_ITEM_LIST[index].level > UnitLevel("player")) then
						rarityText:SetTextColor(1, 0, 0);
					else
						rarityText:SetTextColor(1, 1, 1);
					end
				else
					rarityText:SetText("");
				end
				locText:SetText(DMIN_TEXT.Bag.." "..DMIN_ITEM_LIST[index].bag.."  "..DMIN_TEXT.Slot.." "..DMIN_ITEM_LIST[index].slot);
			else
				button:Hide();
			end
		end
	end
	
	DiscordMiniInventoryFrame:SetHeight(405 - 30 * hiddenCount);
	DiscordMiniInventoryFrame_RightBorder:SetHeight(300 - 30 * hiddenCount);

	FauxScrollFrame_Update(DMIN_ScrollFrame, numOptions, 10, 30);
end

function DMIN_Init_ItemButton(parent, button, item)
	local checkbutton = getglobal("DMIN_ScrollButton_"..parent.."_ItemButton_"..button);
	if (DMIN_ITEM_LIST[item]) then
		checkbutton:Show();
	else
		checkbutton:Hide();
		return;
	end
	local texture, count, locked, _, readable = GetContainerItemInfo(DMIN_ITEM_LIST[item].bag, DMIN_ITEM_LIST[item].slot);
	if (texture == "" or (not texture)) then
		_, texture = GetInventorySlotInfo("Bag1Slot");
	end
	local quality = DMIN_ITEM_LIST[item].quality;
	local icon = getglobal("DMIN_ScrollButton_"..parent.."_ItemButton_"..button.."_Icon");
	icon:SetTexture(texture);
	if (locked) then
		icon:SetVertexColor(.4, .4, .4);
	else
		icon:SetVertexColor(1, 1, 1);
	end
	
	local countText = getglobal("DMIN_ScrollButton_"..parent.."_ItemButton_"..button.."_Count");
	if (DMIN_ITEM_LIST[item].count > 1) then
		countText:SetText(DMIN_ITEM_LIST[item].count);
	else
		countText:SetText("");
	end

	local border = getglobal("DMIN_ScrollButton_"..parent.."_ItemButton_"..button.."_Border");
	if (DMIN_ITEM_LIST[item].unusable) then
		border:Show();
		border:SetVertexColor(1, 0, 0);
	elseif (quality == 1) then
		border:Hide();
	else
		border:Show();
		border:SetVertexColor(DMIN_Settings.colors[quality].r, DMIN_Settings.colors[quality].g, DMIN_Settings.colors[quality].b);
	end

	checkbutton.bag = DMIN_ITEM_LIST[item].bag;
	checkbutton.slot = DMIN_ITEM_LIST[item].slot;
	checkbutton.readable = readable;
	checkbutton.hasItem = true;
	checkbutton.count = count;
	checkbutton.itemindex = item;
	DMIN_ItemButton_UpdateCooldown(checkbutton);
end

function DMIN_Slash_Handler(msg)
	if (msg == "") then
		DMIN_Toggle_Inventory();
	elseif (msg == "replace") then
		if (DMIN_Settings.replace) then
			DMIN_Settings.replace = nil;
			DMIN_Unhook_ToggleBags();
			DEFAULT_CHAT_FRAME:AddMessage(DMIN_TEXT.ReplaceOff, 1, 1, 0);
		else
			DMIN_Settings.replace = 1;
			DMIN_Hook_ToggleBags();
			DEFAULT_CHAT_FRAME:AddMessage(DMIN_TEXT.ReplaceOn, 1, 1, 0);
		end
	elseif (msg == "showempty") then
		if (DMIN_Settings.showEmpty) then
			DMIN_Settings.showEmpty = nil;
			DEFAULT_CHAT_FRAME:AddMessage(DMIN_TEXT.ShowEmptyOff, 1, 1, 0);
		else
			DMIN_Settings.showEmpty = 1;
			DEFAULT_CHAT_FRAME:AddMessage(DMIN_TEXT.ShowEmptyOn, 1, 1, 0);
		end
		DMIN_OnShow(1);
	elseif (msg == "noclose") then
		if (DMIN_Settings.noClose) then
			DMIN_Settings.noClose = nil;
			DEFAULT_CHAT_FRAME:AddMessage(DMIN_TEXT.NoCloseOff, 1, 1, 0);
		else
			DMIN_Settings.noClose = 1;
			DEFAULT_CHAT_FRAME:AddMessage(DMIN_TEXT.NoCloseOn, 1, 1, 0);
		end
	elseif (msg == "drag") then
		if (DMIN_Settings.locked) then
			DMIN_Settings.locked = nil;
			DEFAULT_CHAT_FRAME:AddMessage(DMIN_TEXT.DragUnlocked, 1, 1, 0);
		else
			DMIN_Settings.locked = 1;
			DEFAULT_CHAT_FRAME:AddMessage(DMIN_TEXT.DragLocked, 1, 1, 0);
		end
	elseif (string.find(msg, "scale ")) then
		local _,_,scale = string.find(msg, ' (%d*)');
		scale = tonumber(scale);
		if (scale and scale >=1 and scale <= 200) then
			DMIN_Settings.scale = scale / 100;
			DiscordMiniInventoryFrame:SetScale(DMIN_Settings.scale);
			local text = string.gsub(DMIN_TEXT.ScaleSet, "$n", scale);
			DEFAULT_CHAT_FRAME:AddMessage(text, 1, 1, 0);
		else
			for _, line in DMIN_HELPTEXT do
				DEFAULT_CHAT_FRAME:AddMessage(line, 1, 1, 0);
			end
		end
	elseif (string.find(msg, "backpack ") or string.find(msg, "bag%d ")) then
		local _, _, bag, name = string.find(msg, "([^%s]*) (.*)");
		if (not name) then
			name = "";
		end
		if (bag == "backpack") then
			DMIN_Settings.bagNames[0] = name;
		elseif (bag == "bag1") then
			DMIN_Settings.bagNames[1] = name;
		elseif (bag == "bag2") then
			DMIN_Settings.bagNames[2] = name;
		elseif (bag == "bag3") then
			DMIN_Settings.bagNames[3] = name;
		elseif (bag == "bag4") then
			DMIN_Settings.bagNames[4] = name;
		end
		DMIN_BagTabs_Update();
	elseif (msg == "reset") then
		DiscordMiniInventoryFrame:ClearAllPoints();
		DiscordMiniInventoryFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
		DEFAULT_CHAT_FRAME:AddMessage(DMIN_TEXT.Reset, 1, 1, 0);
	elseif (msg == "selfcast") then
		if (DMIN_Settings.selfcast) then
			DMIN_Settings.selfcast = nil;
			DEFAULT_CHAT_FRAME:AddMessage(DMIN_TEXT.SelfCastOff, 1, 1, 0);
		else
			DMIN_Settings.selfcast = 1;
			DEFAULT_CHAT_FRAME:AddMessage(DMIN_TEXT.SelfCastOn, 1, 1, 0);
		end
	elseif (msg == "restack") then
		DMIN_Compress_Stacks();
	elseif (msg == "combine") then
		if (DMIN_Settings.combine) then
			DMIN_Settings.combine = nil;
			DEFAULT_CHAT_FRAME:AddMessage(DMIN_TEXT.CombineOff, 1, 1, 0);
		else
			DMIN_Settings.combine = 1;
			DEFAULT_CHAT_FRAME:AddMessage(DMIN_TEXT.CombineOn, 1, 1, 0);
		end
		DMIN_Update_ItemList();
		DMIN_ScrollFrame_Update();
	elseif (msg == "tabs") then
		DMIN_Toggle_Tabs();
	elseif (msg == "bags") then
		DMIN_Toggle_Bags();
	elseif (string.find(msg, "cleartab ")) then
		local _,_,tab = string.find(msg, ' (.*)');
		if (tab) then
			DMIN_Settings.CustomTabs[tab] = nil;
			DMIN_OnShow(1);
		end
	elseif (string.find(msg, "ctab ")) then
		local _, _, tabName, itemName = string.find(msg, 'ctab "([^"]*)" "([^"]*)"');
		if (not DMIN_Settings.CustomTabs[tabName]) then
			DMIN_Settings.CustomTabs[tabName] = {};
		else
			local count = 0;
			for t in DMIN_Settings.CustomTabs do
				count = count + 1;
			end
			if (count >= 10 and (not itemName)) then
				DEFAULT_CHAT_FRAME:AddMessage(DMIN_TEXT.NoTabsLeft, 1, 0, 0);
				return;
			end
		end
		if (DMIN_Settings.CustomTabs[tabName][itemName]) then
			DMIN_Settings.CustomTabs[tabName][itemName] = nil;
		else
			DMIN_Settings.CustomTabs[tabName][itemName] = 1;
		end
		DMIN_OnShow(1);
	else
		for _, line in DMIN_HELPTEXT do
			DEFAULT_CHAT_FRAME:AddMessage(line, 1, 1, 0);
		end
	end
end

function DMIN_ItemButton_OnClick(button, ignoreModifiers)
	this:SetChecked(0);
	local bag, slot = this.bag, this.slot;
	if (DMIN_Settings.combine and this.count and this.count < DMIN_ITEM_LIST[this.itemindex].stack) then
		local lowdiff = DMIN_ITEM_LIST[this.itemindex].stack - this.count;
		for b=0,4 do
			local bagslots = GetContainerNumSlots(b);
			if (bagslots) then
				for s = 1, bagslots do
					local link = GetContainerItemLink(b,s);
					if (link) then
						local _, _, itemLink, itemName = string.find(link, "|H(item:%d+:%d+:%d+:%d+)|h%[([^]]+)%]|h|r$");
						if (itemName == DMIN_ITEM_LIST[this.itemindex].name) then
							local _, itemCount = GetContainerItemInfo(b, s);
							local diff = DMIN_ITEM_LIST[this.itemindex].stack - itemCount;
							if (diff < lowdiff) then
								lowdiff = diff;
								bag = b;
								slot = s;
							end
							if (diff == 0) then break; end
						end
					end
				end
			end
		end
	end
	this:GetParent():SetID(bag);
	this:SetID(slot);
	ContainerFrameItemButton_OnClick(button, ignoreModifiers);
	if (DMIN_Settings.selfcast and SpellIsTargeting()) then
		SpellTargetUnit("player");
	end
	if (StackSplitFrame:IsShown()) then
		StackSplitFrame:ClearAllPoints();
		StackSplitFrame:SetPoint("RIGHT", DiscordMiniInventoryFrame, "LEFT", 0, 0);
		DMIN_SPLIT_BAG = bag;
		DMIN_SPLIT_SLOT = slot;
	else
		DMIN_ScrollFrame_Update();
	end
end

DMIN_Old_StackSplitFrameOkay_Click = StackSplitFrameOkay_Click;
function StackSplitFrameOkay_Click()
	if ( StackSplitFrame.owner and DMIN_SPLIT_BAG and DMIN_SPLIT_SLOT ) then
		StackSplitFrame.owner:SetID(DMIN_SPLIT_SLOT);
		StackSplitFrame.owner:GetParent():SetID(DMIN_SPLIT_BAG);
	end
	DMIN_Old_StackSplitFrameOkay_Click();
	DMIN_ScrollFrame_Update();
end

DMIN_Old_StackSplitFrameCancel_Click = StackSplitFrameCancel_Click;
function StackSplitFrameCancel_Click()
	DMIN_Old_StackSplitFrameCancel_Click();
	DMIN_ScrollFrame_Update();
end

function DMIN_ItemButton_OnEnter(button)
	button:GetParent():SetID(button.bag);
	button:SetID(button.slot);
	ContainerFrameItemButton_OnEnter(button);
end

function DMIN_ItemButton_OnEvent(event)
	if (not DMIN_INITIALIZED) then return; end

end

function DMIN_ItemButton_OnUpdate(elapsed)
	if (not DMIN_INITIALIZED) then return; end
	if (this.cooldowncount) then
		this.cooldowncount = this.cooldowncount - elapsed;
		if (this.cooldowncount > 0) then
			local sec = math.ceil(this.cooldowncount);
			if (sec > 60) then
				sec = math.ceil(this.cooldowncount / 60).."m";
			end
			getglobal(this:GetName().."_CooldownCount"):SetText(sec);
		else
			this.cooldowncount = nil;
			getglobal(this:GetName().."_CooldownCount"):SetText("");
		end
	end
	if ( GameTooltip:IsOwned(this) ) then
		DMIN_ItemButton_OnEnter(this);
	end
end

function DMIN_ItemButton_UpdateCooldown(button)
	local start, duration, enable = GetContainerItemCooldown(button.bag, button.slot);
	CooldownFrame_SetTimer(getglobal(button:GetName().."_Cooldown"), start, duration, enable);
	if (start and start > 0) then
		button.cooldowncount = duration - (GetTime() - start);
	else
		button.cooldowncount = 0;
	end
	if (enable == 0 and duration > 0) then
		button.cooldowncount = 0;
		getglobal(button:GetName().."_Icon"):SetVertexColor(.4, .4, .4);
	end
end

function DMIN_Toggle_Inventory()
	if (DiscordMiniInventoryFrame:IsVisible()) then
		DiscordMiniInventoryFrame:Hide();
	else
		DiscordMiniInventoryFrame:Show();
	end
end

function DMIN_Update_ItemList()
	DiscordMiniInventoryFrame.updateItems = nil;
	local tab = DiscordMiniInventoryFrame.selectedTab;
	if (tab == DMIN_TEXT.Backpack) then
		tab = 0;
	elseif (tab == DMIN_TEXT.Bag.." 1") then
		tab = 1;
	elseif (tab == DMIN_TEXT.Bag.." 2") then
		tab = 2;
	elseif (tab == DMIN_TEXT.Bag.." 3") then
		tab = 3;
	elseif (tab == DMIN_TEXT.Bag.." 4") then
		tab = 4;
	end
	DMIN_ITEM_LIST = {};

	local index = 0;
	DMIN_SLOTS_COUNT = 0;
	DMIN_SLOTS_USED = 0;
	DMIN_Tooltip:Show();
	for bag=0,4 do
		local bagslots = GetContainerNumSlots(bag);
		if (bagslots) then
			for slot = 1, bagslots do
				DMIN_SLOTS_COUNT = DMIN_SLOTS_COUNT + 1;
				local link = GetContainerItemLink(bag,slot);
				if (link and link ~= "" and tab ~= "empty") then
					DMIN_SLOTS_USED = DMIN_SLOTS_USED + 1;
					local _, _, itemLink, itemName = string.find(link, "|H(item:%d+:%d+:%d+:%d+)|h%[([^]]+)%]|h|r$");
					if (itemLink) then
						local _, _, itemQuality, itemLevel, itemType, itemSubtype, itemStackSize, equipLocation = GetItemInfo(itemLink);
						equipLocation = getglobal(equipLocation);
						local itemUnusable, itemSoulbound;
						DMIN_Tooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
						DMIN_Tooltip:SetBagItem(bag, slot);
						for i=1,4 do
							local line = getglobal("DMIN_TooltipTextLeft"..i);
							if (line:IsShown()) then
								local r, g, b = line:GetTextColor();
								if (r > .9 and g < .2 and b < .2) then
									itemUnusable = true;
								end
								if (string.find(line:GetText(), DMIN_TEXT.Soulbound)) then
									itemSoulbound = 1;
								end
							end
							local line = getglobal("DMIN_TooltipTextRight"..i);
							if (line:IsShown()) then
								local r, g, b = line:GetTextColor();
								if (r > .9 and g < .2 and b < .2) then
									itemUnusable = true;
								end
								if (string.find(line:GetText(), DMIN_TEXT.Soulbound)) then
									itemSoulbound = 1;
								end
							end
						end
						if (itemLevel > UnitLevel("player")) then
							itemUnusable = true;
						end
						if ((not tab) or tab == bag or tab == itemType or tab == DMIN_TEXT.Rarity[itemQuality] or tab == "unusable" or DMIN_Settings.CustomTabs[tab] or tab == "stacks" or tab == "soulbound") then
							local _, itemCount = GetContainerItemInfo(bag, slot);
							if (not itemCount) then
								itemCount = 1;
							end
							local found;
							for num, val in DMIN_ITEM_LIST do
								if (val.name == itemName) then
									found = num;
									break;
								end
							end
							if (found and DMIN_Settings.combine) then
								DMIN_ITEM_LIST[found].count = DMIN_ITEM_LIST[found].count + itemCount;
							else
								if (itemSubtype ~= itemType) then
									if (equipLocation and equipLocation ~= "") then
										itemType = itemType.." ("..itemSubtype..", "..equipLocation..")";
									else
										itemType = itemType.." ("..itemSubtype..")";
									end
								elseif (equipLocation and equipLocation ~= "") then
									itemType = itemType.." ("..equipLocation..")";
								end
								if (DMIN_Settings.CustomTabs[tab]) then
									for filter in DMIN_Settings.CustomTabs[tab] do
										if (string.find(itemName, filter)) then
											index = index + 1;
											DMIN_ITEM_LIST[index] = {bag=bag, slot=slot, name=itemName, quality=itemQuality, itemType=itemType, count=itemCount, location=equipLocation, level=itemLevel, unusable=itemUnusable, stack = itemStackSize, soulbound = itemSoulbound};
											break;
										end
									end
								elseif (tab == "stacks") then
									if (itemStackSize and itemStackSize > 1) then
										index = index + 1;
										DMIN_ITEM_LIST[index] = {bag=bag, slot=slot, name=itemName, quality=itemQuality, itemType=itemType, count=itemCount, location=equipLocation, level=itemLevel, unusable=itemUnusable, stack = itemStackSize, soulbound = itemSoulbound};
									end
								elseif (tab == "soulbound") then
									if (itemSoulbound) then
										index = index + 1;
										DMIN_ITEM_LIST[index] = {bag=bag, slot=slot, name=itemName, quality=itemQuality, itemType=itemType, count=itemCount, location=equipLocation, level=itemLevel, unusable=itemUnusable, stack = itemStackSize, soulbound = itemSoulbound};
									end
								elseif (tab ~= "unusable" or itemUnusable) then
									index = index + 1;
									DMIN_ITEM_LIST[index] = {bag=bag, slot=slot, name=itemName, quality=itemQuality, itemType=itemType, count=itemCount, location=equipLocation, level=itemLevel, unusable=itemUnusable, stack = itemStackSize, soulbound = itemSoulbound};
								end
							end
						end
					end
				elseif (link and tab == "empty") then
					DMIN_SLOTS_USED = DMIN_SLOTS_USED + 1;
				elseif ((not link or link=="") and (not tab or tab==bag or tab=="empty") and DMIN_Settings.showEmpty) then
					index = index + 1;
					DMIN_ITEM_LIST[index] = {bag=bag, slot=slot, name=DMIN_TEXT.Empty, quality=1, itemType="", count=1, location="", level=0};
				end
			end
		end
	end
	DMIN_Tooltip:Hide();

	if (DMIN_Settings.sortBy ~= "bag" and DMIN_ITEM_LIST[1]) then
		DMIN_ITEM_LIST = DMP_Sort(DMIN_ITEM_LIST, DMIN_Settings.sortBy);
	end
end

function DMIN_Update_Tabs()
	local tabBase = "DMIN_TabButton_";
	local qualities = {};
	local types = {};
	local unusable, showempty, stacks, soulbound;
	for bag=0,4 do
		local bagslots = GetContainerNumSlots(bag);
		if (bagslots) then
			for slot = 1, bagslots do
				local link = GetContainerItemLink(bag,slot);
				if (link) then
					local _, _, itemLink = string.find(link, "|H(item:%d+:%d+:%d+:%d+)|h%[([^]]+)%]|h|r$");
					if (itemLink) then
						local _, _, itemQuality, _, itemType, _, itemStackSize = GetItemInfo(itemLink);
						qualities[itemQuality] = true;
						types[itemType] = true;
						if (itemStackSize and itemStackSize > 0) then
							stacks = true;
						end
						DMIN_Tooltip:SetOwner(WorldFrame, "ANCHOR_NONE");
						DMIN_Tooltip:SetBagItem(bag, slot);
						for i=1,4 do
							local line = getglobal("DMIN_TooltipTextLeft"..i);
							if (line:IsShown()) then
								local a, r, g, b = line:GetTextColor();
								if (r > .9 and g < .2 and b < .2) then
									unusable = true;
								end
								if (string.find(line:GetText(), DMIN_TEXT.Soulbound)) then
									soulbound = 1;
								end
							end
							local line = getglobal("DMIN_TooltipTextRight"..i);
							if (line:IsShown()) then
								local a, r, g, b = line:GetTextColor();
								if (r > .9 and g < .2 and b < .2) then
									unusable = true;
								end
								if (string.find(line:GetText(), DMIN_TEXT.Soulbound)) then
									soulbound = 1;
								end
							end
						end
					elseif (DMIN_Settings.showEmpty) then
						showempty = true;
					end
				end
			end
		end
	end

	local index = 1;
	local button, buttontext;
	local highWidth = 30;
	for q=0,4 do
		if (qualities[q]) then
			index = index + 1;
			local width = DMIN_Init_TabButton(tabBase..index, DMIN_TEXT.Rarity[q], DMIN_TEXT.Rarity[q], DMIN_Settings.colors[q].r, DMIN_Settings.colors[q].g, DMIN_Settings.colors[q].b);
			if (width > highWidth) then highWidth = width; end
		end
	end
	for itemType in types do
		index = index + 1;
		local width = DMIN_Init_TabButton(tabBase..index, itemType, itemType, 1, 1, 1);
		if (width > highWidth) then highWidth = width; end
	end
	if (stacks) then
		index = index + 1;
		local width = DMIN_Init_TabButton(tabBase..index, "stacks", DMIN_TEXT.StackedItems, 0, 1, 1);
		if (width > highWidth) then highWidth = width; end
	end
	if (unusable) then
		index = index + 1;
		local width = DMIN_Init_TabButton(tabBase..index, "unusable", DMIN_TEXT.Unusable, 1, 0, 0);
		if (width > highWidth) then highWidth = width; end
	end
	if (showempty) then
		index = index + 1;
		local width = DMIN_Init_TabButton(tabBase..index, "empty", DMIN_TEXT.EmptyTab, .7, .7, .7);
		if (width > highWidth) then highWidth = width; end
	end
	if (soulbound) then
		index = index + 1;
		local width = DMIN_Init_TabButton(tabBase..index, "soulbound", DMIN_TEXT.Soulbound, 1, .3, 1);
		if (width > highWidth) then highWidth = width; end
	end
	for ctab in DMIN_Settings.CustomTabs do
		index = index + 1;
		local width = DMIN_Init_TabButton(tabBase..index, ctab, ctab, 1, 1, 0);
		if (width > highWidth) then highWidth = width; end
	end
	for i=1, index do
		getglobal(tabBase..i):SetWidth(highWidth + 10);
	end
	DMIN_TabButtonBackdrop:SetWidth(highWidth + 20);
	DMIN_TabButtonBackdrop:SetHeight(index * 15 + 10);
	for i=index + 1, 35 do
		getglobal(tabBase..i):Hide();
	end
	local center = UIParent:GetCenter();
	local loc = DiscordMiniInventoryFrame:GetCenter();
	if (loc / DiscordMiniInventoryFrame:GetScale() * UIParent:GetScale() <= center) then
		DMIN_TabButtonBackdrop:ClearAllPoints();
		DMIN_TabButtonBackdrop:SetPoint("LEFT", DiscordMiniInventoryFrame, "RIGHT", -9, 0);
	else
		DMIN_TabButtonBackdrop:ClearAllPoints();
		DMIN_TabButtonBackdrop:SetPoint("RIGHT", DiscordMiniInventoryFrame, "LEFT", 9, 0);
	end
end

function DMIN_Init_TabButton(buttonName, tabName, tabText, r, g, b)
	local button = getglobal(buttonName);
	button:Show();
	button.tabname = tabName;
	button.color = {r=r, g=g, b=b};
	buttontext = getglobal(buttonName.."_Text");
	buttontext:SetText(tabText);
	if (buttonName ~= DiscordMiniInventoryFrame.selectedTab) then
		buttontext:SetTextColor(r, g, b);
	end
	return buttontext:GetWidth();
end

function DMIN_StopMoving()
	this:StopMovingOrSizing();
	if (this.moving) then
		DMIN_Update_Tabs();
	end
end

function DMIN_TabButton_OnClick(tab, bag)
	if (DiscordMiniInventoryFrame.lastclicked == this:GetName()) then return; end
	local button = getglobal(DiscordMiniInventoryFrame.lastclicked);
	button:SetBackdropColor(0, 0, 0);
	getglobal(DiscordMiniInventoryFrame.lastclicked.."_Text"):SetTextColor(button.color.r, button.color.g, button.color.b);
	DiscordMiniInventoryFrame.selectedTab = tab;
	DiscordMiniInventoryFrame.showingBag = bag;
	DiscordMiniInventoryFrame.lastclicked = this:GetName();
	if (this.tabname == "unusable") then
		DiscordMiniInventoryFrame_Header:SetText(DMIN_TEXT.Unusable);
	elseif (this.tabname == "empty") then
		DiscordMiniInventoryFrame_Header:SetText(DMIN_TEXT.EmptyTab);
	elseif (this.tabname == "stacks") then
		DiscordMiniInventoryFrame_Header:SetText(DMIN_TEXT.StackedItems);
	elseif (this.tabname == "soulbound") then
		DiscordMiniInventoryFrame_Header:SetText(DMIN_TEXT.Soulbound);
	elseif (this.tabname) then
		DiscordMiniInventoryFrame_Header:SetText(this.tabname);
	else
		DiscordMiniInventoryFrame_Header:SetText(DMIN_TEXT.All);
	end
	DMIN_Update_ItemList();
	DMIN_ScrollFrame_Update();
end

function DMIN_Toggle_Tabs()
	if (DMIN_Settings.hideTabs) then
		DMIN_Settings.hideTabs = nil;
		DMIN_TabButtonBackdrop:Show();
		DMIN_ToggleTabsButton:SetText("<");
	else
		DMIN_Settings.hideTabs = 1;
		DMIN_TabButtonBackdrop:Hide();
		DMIN_ToggleTabsButton:SetText(">");
	end
end

function DMIN_Toggle_Bags()
	if (DMIN_Settings.hideBags) then
		DMIN_Settings.hideBags = nil;
		for i=0, 4 do
			getglobal("DMIN_BagTab_"..i):Show();
		end
		DMIN_ToggleBagsButton:SetText("^");
	else
		DMIN_Settings.hideBags = 1;
		for i=0, 4 do
			getglobal("DMIN_BagTab_"..i):Hide();
		end
		DMIN_ToggleBagsButton:SetText("v");
	end
end

function DMIN_Toggle_CompactMode()
	if (DMIN_Settings.compact) then
		DMIN_Settings.compact = nil;
		DMIN_ToggleCompactButton:SetText(DMIN_TEXT.Compact);
		for b=1,10 do
			for i=2,8 do
				button = getglobal("DMIN_ScrollButton_"..b.."_ItemButton_"..i):Hide();
			end
			getglobal("DMIN_ScrollButton_"..b.."_Border"):Show();
			getglobal("DMIN_ScrollButton_"..b.."_Name"):Show();
			getglobal("DMIN_ScrollButton_"..b.."_Type"):Show();
			getglobal("DMIN_ScrollButton_"..b.."_Rarity"):Show();
			getglobal("DMIN_ScrollButton_"..b.."_Location"):Show();
		end
	else
		DMIN_Settings.compact = 1;
		DMIN_ToggleCompactButton:SetText(DMIN_TEXT.Details);
		for b=1,10 do
			getglobal("DMIN_ScrollButton_"..b.."_Border"):Hide();
			getglobal("DMIN_ScrollButton_"..b.."_Name"):Hide();
			getglobal("DMIN_ScrollButton_"..b.."_Type"):Hide();
			getglobal("DMIN_ScrollButton_"..b.."_Rarity"):Hide();
			getglobal("DMIN_ScrollButton_"..b.."_Location"):Hide();
		end
	end
	DMIN_ScrollFrame_Update();
end

function DMIN_BagTab_OnLoad()
	this:SetBackdropColor(0, 0, 0);
	this:SetBackdropBorderColor(1, 0, 0);
	this:RegisterForDrag("LeftButton");
	this.color = {r=1, g=1, b=0};
	if (this:GetID() > 0) then
		this:ClearAllPoints();
		this:SetPoint("LEFT", "DMIN_BagTab_"..(this:GetID() - 1), "RIGHT", -15, 0);
	end
end

function DMIN_BagTabs_Update()
	DMIN_BagTab_0_Icon:SetTexture("Interface\\Buttons\\Button-Backpack-Up");
	for bag=0, 4 do
		local tab = "DMIN_BagTab_"..bag;
		local tabname = getglobal(tab).tabname;
		local bagslots = GetContainerNumSlots(bag);
		if (bagslots and bagslots > 0) then
			local used = 0;
			if (bag > 0) then
				getglobal(tab.."_Icon"):Show();
				SetBagPortaitTexture(getglobal(tab.."_Icon"), bag);
			end
			for slot = 1, bagslots do
				local link = GetContainerItemLink(bag,slot);
				if (link) then used = used + 1; end
			end
			getglobal(tab.."_Text"):SetText(DMIN_Settings.bagNames[bag].."\n\n"..used.." / "..bagslots);
		else
			getglobal(tab.."_Icon"):Hide();
			getglobal(tab.."_Text"):SetText("");
		end
	end
end

function DMIN_BagTab_OnClick(bag, tab)
	local hadItem;
	if (bag == 0) then
		hadItem = PutItemInBackpack();
	else
		hadItem = PutItemInBag(bag + 19);
	end
	if (not hadItem) then
		DMIN_TabButton_OnClick(tab, bag);
	end
end

function DMIN_Update_Money()
	local money = GetMoney("player");
	local gold, silver, copper;
	if (money < 10000) then
		gold = 0;
	else
		gold = tonumber(string.sub(money, 1, -5));
	end
	if (money < 100) then
		silver = 0;
	else
		silver = tonumber(string.sub(money, -4, -3));
	end
	copper = tonumber(string.sub(money, -2));
	DiscordMiniInventoryFrame_Gold:SetText(gold);
	DiscordMiniInventoryFrame_Silver:SetText(silver);
	DiscordMiniInventoryFrame_Copper:SetText(copper);
end

function DMIN_Compress_NextItem()
	local finished;
	if (not DMIN_COMPRESS_BAG) then
		DMIN_COMPRESS_BAG, DMIN_COMPRESS_SLOT, DMIN_COMPRESS_NAME = DMIN_Get_UnfinishedStack(0, 1);
	else
		DMIN_COMPRESS_BAG, DMIN_COMPRESS_SLOT, DMIN_COMPRESS_NAME = DMIN_Get_UnfinishedStack(DMIN_COMPRESS_BAG, DMIN_COMPRESS_SLOT);
	end
	if (DMIN_COMPRESS_BAG) then
		local _, _, locked = GetContainerItemInfo(DMIN_COMPRESS_BAG, DMIN_COMPRESS_SLOT);
		if (locked) then return; end
		PickupContainerItem(DMIN_COMPRESS_BAG, DMIN_COMPRESS_SLOT);
		local newBag, newSlot = DMIN_Get_UnfinishedStack(DMIN_COMPRESS_BAG, DMIN_COMPRESS_SLOT, DMIN_COMPRESS_NAME);
		if (newBag) then
			PickupContainerItem(newBag, newSlot);
		else
			PickupContainerItem(DMIN_COMPRESS_BAG, DMIN_COMPRESS_SLOT);
			DMIN_COMPRESS_SLOT = DMIN_COMPRESS_SLOT + 1;
			for b=DMIN_COMPRESS_BAG, 4 do
				local bagslots = GetContainerNumSlots(b);
				if (DMIN_COMPRESS_SLOT > bagslots) then
					DMIN_COMPRESS_BAG = DMIN_COMPRESS_BAG + 1;
					DMIN_COMPRESS_SLOT = 1;
					if (DMIN_COMPRESS_BAG > 4) then
						finished = 1;
					end
				end
			end
		end
	else
		finished = 1;
	end
	if (finished) then
		DMIN_COMPRESSING_STACKS = nil;
		DMIN_COMPRESS_BAG = nil;
		DEFAULT_CHAT_FRAME:AddMessage("Finished compressing stacks.", 1, 1, 0);
	end
end

function DMIN_Get_UnfinishedStack(bagStart, slotStart, itemName)
	local slotTrueStart = slotStart;
	for bag=bagStart, 4 do
		if (bag ~= bagStart) then
			slotTrueStart = 1;
		end
		local bagslots = GetContainerNumSlots(bag);
		if (bagslots) then
			for slot=slotTrueStart, bagslots do
				local link = GetContainerItemLink(bag,slot);
				if (link) then
					local _, _, itemLink, name = string.find(link, "|H(item:%d+:%d+:%d+:%d+)|h%[([^]]+)%]|h|r$");
					local _, _, _, _, _, _, stackSize = GetItemInfo(itemLink);
					local _, count = GetContainerItemInfo(bag, slot);
					if (itemName) then
						if (itemName == name and (bag ~= bagStart or slot ~= slotStart) and count < stackSize) then
							return bag, slot, name;
						end
					elseif (count < stackSize) then
						return bag, slot, name;
					end
				end
			end
		end
	end
end

function DMIN_Compress_Stacks()
	DMIN_COMPRESSING_STACKS = true;
	DEFAULT_CHAT_FRAME:AddMessage("Beginning to compress stacks.", 1, 1, 0);
	DMIN_Compress_NextItem();
end