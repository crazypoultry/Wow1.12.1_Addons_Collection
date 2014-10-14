
local version = "02.02.2006";
local lib = Nurfed_DKP:New();
NURFED_SAVED_DKP = {};
NURFED_SAVED_DKPLOOT = {};

local oldhooks = {
	AuctionFrameItem_OnEnter = nil;
	ContainerFrameItemButton_OnEnter = nil;
	ContainerFrameItemButton_OnUpdate = nil;
	GameTooltip_OnHide = nil;
	GameTooltip_SetInventoryItem = nil;
	GameTooltip_SetMerchantItem = nil;
	GameTooltip_SetUnit = nil;
	SetItemRef = nil;
};

local NDKP = {
---------------------------------------------------------------------------
--			Nurfed DKP Hook Functions
---------------------------------------------------------------------------
	-- auction frame
	AuctionFrameItem_OnEnter = function (type, index)
		oldhooks.AuctionFrameItem_OnEnter (type, index);
		lib:AddDKP();
	end;

	-- standard bags
	ContainerFrameItemButton_OnEnter = function ()
		oldhooks.ContainerFrameItemButton_OnEnter();
		lib:AddDKP();
	end;

	-- standard bags update
	ContainerFrameItemButton_OnUpdate = function (elapsed)
		oldhooks.ContainerFrameItemButton_OnUpdate (elapsed);
	end;

	-- reset state on hide
	GameTooltip_OnHide = function ()
		oldhooks.GameTooltip_OnHide();
	end;

	-- bag slots
	GameTooltip_SetInventoryItem = function (unit, slotID, name)
		local hasItem, hasCooldown, repairCost =
			oldhooks.GameTooltip_SetInventoryItem (unit, slotID, name);
		lib:AddDKP();
		return hasItem, hasCooldown, repairCost;
	end;

	GameTooltip_SetMerchantItem = function (unit, slotID)
		oldhooks.GameTooltip_SetMerchantItem (unit, slotID);
		lib:AddDKP();
	end;

	-- player tooltip
	GameTooltip_SetUnit = function (this, unit)
		oldhooks.GameTooltip_SetUnit (this, unit);
		looking_at_unit = unit;
		lib:AddDKP();
	end;

	-- links pasted into chat
	SetItemRef = function (link, text, button)
		oldhooks.SetItemRef (link, text, button);
		lib:AddDKP("ItemRefTooltip");
	end;

	-- loot items
	LootFrame = function()
		local slot = ((LOOTFRAME_NUMBUTTONS - 1) * (LootFrame.page - 1)) + this:GetID();
		if ( LootSlotIsItem(slot) ) then
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
			GameTooltip:SetLootItem(slot);
			CursorUpdate();
		end
		lib:AddDKP();
	end;
};

function Nurfed_DKP_OnLoad()
	this:RegisterEvent("PLAYER_LOGIN");
	this:RegisterEvent("CHAT_MSG_WHISPER");
	this:RegisterEvent("CHAT_MSG_SYSTEM");
	this:RegisterEvent("LOOT_OPENED");
	this:RegisterEvent("CHAT_MSG_LOOT");

	-- auction frame
	oldhooks.AuctionFrameItem_OnEnter = AuctionFrameItem_OnEnter;
	AuctionFrameItem_OnEnter = NDKP.AuctionFrameItem_OnEnter;

	-- standard bags
	oldhooks.ContainerFrameItemButton_OnEnter = ContainerFrameItemButton_OnEnter;
	ContainerFrameItemButton_OnEnter = NDKP.ContainerFrameItemButton_OnEnter;

	-- standard bags update
	oldhooks.ContainerFrameItemButton_OnUpdate = ContainerFrameItemButton_OnUpdate;
	ContainerFrameItemButton_OnUpdate = NDKP.ContainerFrameItemButton_OnUpdate;

	-- reset state on hide
	oldhooks.GameTooltip_OnHide = GameTooltip_OnHide;
	GameTooltip_OnHide = NDKP.GameTooltip_OnHide;

	-- bag slots
	oldhooks.GameTooltip_SetInventoryItem = GameTooltip.SetInventoryItem;
	GameTooltip.SetInventoryItem = NDKP.GameTooltip_SetInventoryItem;
	oldhooks.GameTooltip_SetMerchantItem = GameTooltip.SetMerchantItem;
	GameTooltip.SetMerchantItem = NDKP.GameTooltip_SetMerchantItem;
	oldhooks.GameTooltip_SetUnit = GameTooltip.SetUnit;
	GameTooltip.SetUnit = NDKP.GameTooltip_SetUnit;

	-- links pasted into chat
	oldhooks.SetItemRef = SetItemRef;
	SetItemRef = NDKP.SetItemRef;

	--loot items
	LootButton1:SetScript("OnEnter", NDKP.LootFrame);
	LootButton2:SetScript("OnEnter", NDKP.LootFrame);
	LootButton3:SetScript("OnEnter", NDKP.LootFrame);
	LootButton4:SetScript("OnEnter", NDKP.LootFrame);

	SLASH_NURFEDDKP1 = "/ndkp";
	SlashCmdList["NURFEDDKP"] = function(msg)
		NurfedDKP_SlashCommandHandler(msg);
	end
	if(DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("Nathen's Nurfed DKP Loaded",.9,0,0);
	end
end

function Nurfed_DKP_OnEvent(event)
	if (event == "PLAYER_LOGIN") then
		Nurfed_DKPInit();
		return;
	end

	if (event == "CHAT_MSG_LOOT") then
		local name, itemlink;
		local _, _, player, link = string.find(arg1, "([^%s]+) receives loot: (.+)%.");
		if (player) then
			name = player;
			itemlink = link;
		else
			local _, _, link = string.find(arg1, "You receive loot: (.+)%.");
			if (link) then
				name = UnitName("player");
				itemlink = link;
			end
		end

		if (name and itemlink) then
			local info = lib:ItemInfo(itemlink);
			if (info) then
				if (not NURFED_SAVED_DKPLOOT[name]) then
					NURFED_SAVED_DKPLOOT[name] = {};
				end

				if (not NURFED_SAVED_DKPLOOT[name][info.name]) then
					NURFED_SAVED_DKPLOOT[name][info.name] = {
						["count"] = 1,
						["id"] = info.id,
						["link"] = info.link,
						["rarity"] = info.rarity,
						["icon"] = info.icon,
						["dkp"] = tonumber(info.dkp),
						["secdkp"] = tonumber(info.secdkp),
					};
				else
					NURFED_SAVED_DKPLOOT[name][info.name]["count"] = NURFED_SAVED_DKPLOOT[name][info.name]["count"] + 1;
				end
			end
		end
	end

	if (event == "CHAT_MSG_WHISPER") then
		local msg = string.lower(arg1);
		if (string.find(msg, "!bid"))then
			lib:DisplayPlayer("chat", arg2);
		end
		if (string.find(msg, "!down"))then
			lib:DisplayPlayer("chat", arg2, true);
		end
		if (string.find(msg, "!list"))then
			local i = 1;
			for k, v in lib.display do
				SendChatMessage(i..") "..v.name, "WHISPER", this.language, arg2);
				i = i + 1;
			end
		end
		if (string.find(msg, "!remove"))then
			local index = lib:CheckName(arg2, lib.display);
			if (index) then
				table.remove(lib.display, index);
				Nurfed_DKPPlayerFrame.highlight = nil;
				Nurfed_DKPPlayerScrollUpdate();
			end
		end
		if (string.find(msg, "!dkp"))then
			if (NurfedDKPPlayers[arg2]) then
				SendChatMessage("DKP: "..NurfedDKPPlayers[arg2].dkp, "WHISPER", this.language, arg2);
			else
				SendChatMessage("You are not in the DKP system", "WHISPER", this.language, arg2);
			end
		end
		return;
	end

	if (event == "CHAT_MSG_SYSTEM") then
		local name, roll;
		for name, roll in string.gfind(arg1, "(%a+) rolls (%d+) %(1%-100%)") do
			lib:DisplayRoll(name, roll);
		end
		return;
	end
end

function Nurfed_DKPInit()
	Nurfed_DKPRollFrame:SetBackdropColor(0, 0, 0, 0.75);
	Nurfed_DKPLootFrame:SetBackdropColor(0, 0, 0, 0.75);
	Nurfed_DKPPlayerFrame:SetBackdropColor(0, 0, 0, 0.75);
	Nurfed_DKPPlayerFrameTitle:SetText("Nurfed DKP Vers. "..version);
end

function Nurfed_DKPSetItemTooltip()
	if (not this:IsVisible()) then return; end
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
	local link = this:GetParent().link;
	if (link) then
		GameTooltip:SetHyperlink(link);
		lib:AddDKP();
	end
end

function NurfedDKPRollOnClick(button)
	if (button == "LeftButton") then
		if (Nurfed_DKPRollFrame:IsVisible()) then
			Nurfed_DKPRollFrame:Hide();
		else
			Nurfed_DKPRollFrame:Show();
		end
	else
		ToggleDropDownMenu(1, nil, Nurfed_DKPPlayerFrameRollButtonDropDown, this:GetName(), 0, 0);
		GameTooltip:Hide();
	end
end

function NurfedDKP_RollDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, NurfedDKPRollDropDown_Initialize, "MENU");
end

function NurfedDKPRollDropDown_Initialize()
	if (UIDROPDOWNMENU_MENU_LEVEL == 1) then
		local checked;
		local info = {};

		info.text = "Roll Menu";
		info.isTitle = 1;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = "Clear Rolls";
		info.func = function() lib:ClearRolls() end;
		UIDropDownMenu_AddButton(info);
	end
end

function NurfedDKPLootOnClick(button)
	if (button == "LeftButton") then
		if (Nurfed_DKPLootFrame:IsVisible()) then
			Nurfed_DKPLootFrame:Hide();
		else
			Nurfed_DKPLootFrame:Show();
		end
	else
		ToggleDropDownMenu(1, nil, Nurfed_DKPPlayerFrameLootButtonDropDown, this:GetName(), 0, 0);
		GameTooltip:Hide();
	end
end

function NurfedDKP_LootDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, NurfedDKPLootDropDown_Initialize, "MENU");
end

function NurfedDKPLootDropDown_Initialize()
	if (UIDROPDOWNMENU_MENU_LEVEL == 1) then
		local checked;
		local info = {};

		info.text = "Loot Menu";
		info.isTitle = 1;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = "Clear Loot";
		info.func = function() lib:ClearLoot() end;
		UIDropDownMenu_AddButton(info);
	end
end

function NurfedDKPPlayerOnClick()
	local id = this:GetID();
	local name = getglobal("Nurfed_DKPPlayerFrameRows"..id.."FieldName"):GetText();
	if (name) then
		for dkpname in string.gfind(name, "|c%x+([A-Z][a-z]+)|r") do
			name = dkpname;
		end
		local index = lib:CheckName(name, lib.display);
		if (IsShiftKeyDown()) then
			if (index) then
				table.remove(lib.display, index);
				Nurfed_DKPPlayerFrame.highlight = nil;
			end
		else
			Nurfed_DKPPlayerFrame.highlight = index;
			lib:DisplayLoot(name);
			Nurfed_DKPItemScrollUpdate();
		end
		Nurfed_DKPPlayerScrollUpdate();
	end
end

function Nurfed_DKPItemOnClick(button)
	local id = this:GetParent():GetID();
	if (button == "RightButton") then
		local dropdown = getglobal("Nurfed_DKPLoot"..id.."DropDown");
		ToggleDropDownMenu(1, nil, dropdown, this:GetParent():GetName(), 0, 0);
		GameTooltip:Hide();
	end
end

function NurfedDKP_ItemDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, NurfedDKPItemDropDown_Initialize, "MENU");
end

function NurfedDKPItemDropDown_Initialize()
	if (UIDROPDOWNMENU_MENU_LEVEL == 1) then
		local checked;
		local info = {};
		local name = this:GetParent().player;
		local item = this:GetParent().item;

		info.text = name;
		info.isTitle = 1;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = "Remove One";
		info.func = function() lib:ItemRemove(name, item) end;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.text = "Remove All";
		info.func = function() lib:ItemRemove(name, item, true) end;
		UIDropDownMenu_AddButton(info);
	end
end

function Nurfed_DKPPlayerScrollUpdate()
	local max_line = table.getn(lib.display);
	FauxScrollFrame_Update(Nurfed_DKPPlayerFrameScroll, max_line, 8, 9);
	local scroll_offset = FauxScrollFrame_GetOffset(Nurfed_DKPPlayerFrameScroll);
	lib:UpdateList(scroll_offset, max_line);
end

function Nurfed_DKPItemScrollUpdate()
	local max_line = table.getn(lib.displayloot);
	local name = Nurfed_DKPLootFrame.name;
	FauxScrollFrame_Update(Nurfed_DKPLootFrameScroll, max_line, 5, 6);
	local scroll_offset = FauxScrollFrame_GetOffset(Nurfed_DKPLootFrameScroll);
	lib:DisplayLoot(name, scroll_offset, max_line);
end

function Nurfed_DKPSortList(var)
	if (lib.sortvar == var) then
		if (Nurfed_DKP.sortdir == ">") then
			Nurfed_DKP.sortdir = "<";
		else
			Nurfed_DKP.sortdir = ">";
		end
	else
		lib.sortvar = var;
	end
	lib:DisplayPlayer();
end

function Nurfed_DKPSearch()
	local parent = this:GetParent():GetName();
	local input = getglobal(parent.."Input");
	local search = input:GetText();
	lib:DisplayPlayer("input", search);
	input:ClearFocus();
	input:SetText("");
end

function Nurfed_DKPClearList()
	lib.display = nil;
	lib.display = {};
	lib:DisplayPlayer();
end

function NurfedDKP_SlashCommandHandler(msg)
	if(msg) then
		local command = string.lower(msg);
		if (string.find(command, "list")) then
			local player;
			for name in string.gfind(command, "list (.+)") do
				player = string.gsub(name, "^%l", string.upper);
			end
			if (NURFED_SAVED_DKPLOOT[player]) then
				for itemname,v in NURFED_SAVED_DKPLOOT[player] do
					local i = 1;
					ChatFrame2:AddMessage(i..") "..player.." |c"..lib.lootcolor[v.rarity]..itemname.."|r x"..v.count);
					i = i + 1;
				end
			else
				for name, item in NURFED_SAVED_DKPLOOT do
					local i = 1;
					for itemname,v in item do
						ChatFrame2:AddMessage(i..") "..name.." |c"..lib.lootcolor[v.rarity]..itemname.."|r x"..v.count.." "..v.dkp);
						i = i + 1;
					end
				end
			end
		elseif (GetItemInfo(msg)) then
			SetItemRef("item:"..msg..":0:0:0");
		elseif (string.find(command, "loot")) then
			local player;
			for name in string.gfind(command, "loot (.+)") do
				player = string.gsub(name, "^%l", string.upper);
			end
			if (NURFED_SAVED_DKPLOOT[player]) then
				lib:DisplayLoot(player);
				Nurfed_DKPItemScrollUpdate();
			end
		elseif (command == "") then
			if (Nurfed_DKPPlayerFrame:IsVisible()) then
				Nurfed_DKPPlayerFrame:Hide();
			else
				Nurfed_DKPPlayerFrame:Show();
			end
		end
	end
end