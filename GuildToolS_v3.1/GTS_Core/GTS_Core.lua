--[[
GTS_Core v3.1

Addon that allows you to store in game info into SV.lua for further parsing.
Contains: 
BankScan     		- Scans all posessions of the character, including bank, bags and bags in bank.
IncomingMail 		- Keeps track of all the incoming mail including sender, item sent and date when 
					the message was received.
OutgoingMail 		- Keeps track of all the outgoing mail including receiver, item sent and date when 
					he message was sent.
GuildRosterScaner 	- Scans the entire guild roster including name, level, class, rank, professions*,
					main-alt relations*. 
					* - only if the guild note was properly entered (see manual).

Author: Roman Tarakanov (RTE/Arthas)
Date: Aug 25 '06

]]--

---------------------------------------------------------------
----------------Exported GuildToolS functions------------------
---------------------------------------------------------------
GTS_functions_OnEvent		= {};
GTS_functions_SlashCommand	= {};

---------------------------------------------------------------
----------------Global GuildToolS variables--------------------
---------------------------------------------------------------

--GTS_Position in the array GTS_Options of the current character 
-- -1 - not in array
GTS_Position = -1;
--Debug mode indicator 
-- 1 - debug mode on
-- 0 - debug mode off (default)
GTS_DebugMode = 0;

---------------------------------------------------------------
----------------Global GuildToolS functions--------------------
---------------------------------------------------------------

--OnEvent function
function GTS_OnEvent()	 
	--GTS_Debug("OnEvent is called");

	if (event == "VARIABLES_LOADED") then
		GTS_Debug("Variables are loaded.");
		SlashCmdList["GTS_CORE"] = GTS_SlashCommand;
		SLASH_GTS_CORE1 = "/guildtools";
		SLASH_GTS_CORE2 = "/gts";
		
		GTS_OnLoad();
		
	else
		-- Call other addon's OnEvent functions
		local addon, addon_OnEvent;
		for addon, addon_OnEvent in GTS_functions_OnEvent do
			--GTS_Debug("Running OnEvent for "..addon);
			if (IsAddOnLoaded(addon)) then addon_OnEvent(event); end
		end
		
	end
end

--OnLoad function
function GTS_OnLoad()
	--Saved variables of the AddOn
	--Initialize if blank		
	if (not GTS_Options) then
		GTS_Options = {};
	end
	
	-- varibles in GTS_Options if exist
	local i;
	GTS_Debug("GTS_Options size: "..table.getn(GTS_Options));
	if (GTS_Options) then
		for  i = 1, table.getn(GTS_Options), 1 do
			if (string.find(GTS_Options[i].name, UnitName("player")) and string.find(GTS_Options[i].server, GetCVar("realmName"))) then
				if (not GTS_Options[i].BSON) then GTS_Options[i].BSON=false; end
				if (not GTS_Options[i].IMON) then GTS_Options[i].IMON=false; end
				if (not GTS_Options[i].OMON) then GTS_Options[i].OMON=false; end
				if (not GTS_Options[i].GRSON) then GTS_Options[i].GRSON=false; end
				GTS_Position = i;
			end
		end
	end
	
	--If new character is observed - initialize the data.
	--On new character AddOn and mail grabber part (future functionality) are off by default
	if (GTS_Position == -1) then
		if (GTS_Options) then
			i = table.getn(GTS_Options)+1;
		else
			i = 1;
		end		
		GTS_Options[i] = { name=UnitName("player"), server=GetCVar("realmName"), 
			BSON=false, IMON=false, OMON=false, GRSON=false};
		GTS_Position = i;
	end
	
	GTS_Debug("GTS_Position: "..GTS_Position);
	
	if (not GTS_Data) then GTS_Data = {}; end
	
	--Manu set up for future GUI
	local tabwindow = getglobal("GTS_Menu");
	PanelTemplates_SetNumTabs(tabwindow, 3);
	tabwindow.selectedTab = 1;
	PanelTemplates_UpdateTabs(tabwindow);
	
	GTS_Echo(GTS_MSG["GREETING"]);
	
	if (GTS_Options[GTS_Position].BSON) then GTS_LoadAddon("GTS_BankScan"); end;
	if (GTS_Options[GTS_Position].IMON) then GTS_LoadAddon("GTS_IncomingMail"); end;
	if (GTS_Options[GTS_Position].OMON) then GTS_LoadAddon("GTS_OutgoingMail"); end;
	if (GTS_Options[GTS_Position].GRSON) then GTS_LoadAddon("GTS_GuildRosterScan"); end;
	
end

function GTS_LoadAddon(addon, object)
	loaded, reason = LoadAddOn(addon);
	if (not loaded) then
		GTS_Echo(addon.." was not loaded, reason: "..reason);
	end
end

--Tab handler for future GUI
function GTS_TabHandler(button)
	local tabwindow = getglobal("GTS_Menu");
	local currenttab = getglobal("GTS_Menu_Tab"..tabwindow.selectedTab);
	local nexttab = getglobal("GTS_Menu_Tab"..button);
	
	currenttab:Hide();
	nexttab:Show();
end

--Slash command handler
function GTS_SlashCommand(msg)
	msg = string.lower(msg);
	GTS_Debug("/command: "..msg);
	
	if (msg == nil or msg == "") then 
		GTS_Menu_Header:SetText("GuildToolS v"..GTS_Core_VER);
		GTS_Menu_Header2:SetText("Profile: "..UnitName("player"));
		GTS_Menu:Show();
		return;
	
	elseif (msg == "clear") then 
		GTS_Data = {}; 
		GTS_Echo(GTS_MSG["CLEARED"]);
		return; 
	
	elseif (msg == "debug") then
		
		if (GTS_DebugMode == 1) then
			GTS_Echo(GTS_MSG["DEBUG_OFF"]);
			GTS_DebugMode = 0;
		else
			GTS_Echo(GTS_MSG["DEBUG_ON"]);
			GTS_DebugMode = 1;
		end
		
		
	elseif (msg == "bson") then
		if (not IsAddOnLoaded("GTS_BankScan")) then GTS_LoadAddon("GTS_BankScan"); end
	
	elseif (msg == "imon") then
		if (not IsAddOnLoaded("GTS_IncomingMail")) then GTS_LoadAddon("GTS_IncomingMail"); end
	
	elseif (msg == "omon") then
		if (not IsAddOnLoaded("GTS_OutgoingMail")) then GTS_LoadAddon("GTS_OutgoingMail"); end
	
	elseif (msg == "grson") then
		if (not IsAddOnLoaded("GTS_GuildRosterScan")) then GTS_LoadAddon("GTS_GuildRosterScan"); end
	
	elseif (msg == "info") then
	
		for i=1,table.getn(GTS_MSG["INFO"]) do
			GTS_Echo(GTS_MSG["INFO"][i]);
		end
	
	--Call other mod's SlashCommand handlers
	
	else
		--GTS_Debug("no slash");
		local addon, addon_SlashCommand;
		for addon, addon_SlashCommand in GTS_functions_SlashCommand do
			--GTS_Debug("Running SlashCommand for "..addon);
			if (IsAddOnLoaded(addon)) then if (addon_SlashCommand(msg))then return; end end
		end
		GTS_Echo(GTS_MSG["INVALID"]);
		
	end
end

--Returns full info of the item on bag_id, slot_id, nil if item is not there
function GTS_GetContainerItemInfo(bag_id, slot_id)
	local count, texture, itemLink, itemName, itemQuality, itemDesc, itemType, itemSubType, itemId, price;
	
	if (not GetContainerItemInfo(bag_id, slot_id)) then 
		GTS_Debug("No item in the slot "..bag_id..", "..slot_id);
		return nil;
	end
	
	--Get texture and count of the item in the current slot
	_, count = GetContainerItemInfo(bag_id, slot_id);
	
	--Get link and the name of the item in the current slot
	itemLink = GetContainerItemLink(bag_id, slot_id);
	--GTS_Debug("itemLink: "..itemLink);
	
	itemName, itemQuality, itemDesc, texture, itemType, itemSubType, itemId, price, itemLink = GTS_GetItemInfo(itemLink);
	--GTS_Debug("Price: "..price);
	
	return itemName, itemQuality, itemDesc, count, texture, itemType, itemSubType, itemId, price, itemLink;
end

-- Retunrs all info about the item specified as item link.
function GTS_GetItemInfo(itemLink)
	local texture, count, itemName, itemQuality, itemDesc, itemType, itemSubType, itemId, price, itemEnchant, itemPerm;
	local i, command;
	
	GTS_Debug("itemLink: "..itemLink);
	_, _, itemLink, itemName = string.find(itemLink,"|H(item:%d+:%d+:%d+:%d+)|h%[([^]]+)%]|h|r$");
	_,_,itemId, itemEnchant, itemPerm = string.find(itemLink,"item:(%d+):(%d+):(%d+):%d+");
	GTS_Debug("itemLink: "..itemId..":"..itemEnchant..":"..itemPerm);
	GTS_Debug("ID: "..itemId);
	
	_, _, itemQuality, _, itemType, itemSubType, _, _, texture = GetItemInfo(itemId);
	_,_,texture = string.find(texture, "%a+\\%a+\\([%w_]+)");
	
	--GTS_Debug("Link: "..itemLink);
	--Set tooltip to the current item
	GTS_ItemTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT");
	GTS_ItemTooltip:ClearLines();
	GTS_ItemTooltip:SetHyperlink(itemLink);
	
	--Copy the description test from the tooltip to the variable
	--<n> - new line symbol
	--<t> - tab symbol
	local color = {};
	color.r=-1;
	color.g=-1;
	color.b=-1;
	for i=1, GTS_ItemTooltip:NumLines(),1 do
	
		local curcolor = {};
		command = getglobal("GTS_ItemTooltipTextLeft" .. i);
		if (command:IsShown()) then
			text_left = command:GetText();
		else
			text_left = nil;
		end
		
		curcolor.r, curcolor.g, curcolor.b = command:GetTextColor();
		curcolor.r = GTS_ToHEX(math.ceil(curcolor.r*255));
		curcolor.g = GTS_ToHEX(math.ceil(curcolor.g*255));
		curcolor.b = GTS_ToHEX(math.ceil(curcolor.b*255));
		
		if (curcolor.r == "FF" and curcolor.g == "20" and curcolor.b == "20") then
			curcolor.g = "FF";
			curcolor.b = "FF";
		end
		
		if (curcolor ~= color and text_left and not string.find(text_left, "\n")) then
			color = curcolor;
			text_left = "<c> "..color.r..color.g..color.b.." "..text_left;
		end
		
		command = getglobal("GTS_ItemTooltipTextRight" .. i);
		if (command:IsShown()) then
			text_right = command:GetText();
		else
			text_right = nil;
		end
		
		curcolor.r, curcolor.g, curcolor.b = command:GetTextColor();
		curcolor.r = GTS_ToHEX(math.ceil(curcolor.r*255));
		curcolor.g = GTS_ToHEX(math.ceil(curcolor.g*255));
		curcolor.b = GTS_ToHEX(math.ceil(curcolor.b*255));
		
		if (curcolor.r == "FF" and curcolor.g == "20" and curcolor.b == "20") then
			curcolor.g = "FF";
			curcolor.b = "FF";
		end
		
		if (curcolor ~= color and text_right and not string.find(text_right, "\n")) then
			color = curcolor;
			text_right = "<c> "..color.r..color.g..color.b.." "..text_right;
		end
		
		if (text_left and string.find(text_left, "\n")) then
			text_left = " ";
		end
		
		if (text_right and string.find(text_right, "\n")) then
			text_right = " ";
		end
		
		if (i == 1) then 
			itemDesc = text_left;
		else
			if (text_left) then 
				itemDesc = itemDesc.." <n> "..text_left;
			end
		end
		if (text_right) then
			itemDesc = itemDesc.." <t> "..text_right;
		end
	end
	
	price = 0;
	if (IsAddOnLoaded("LootLink") and ItemLinks and ItemLinks[itemName] and ItemLinks[itemName].p) then
		price = ItemLinks[itemName].p;
	end
	
	return itemName, itemQuality, itemDesc, texture, itemType, itemSubType, itemId, price, itemId..":"..itemEnchant..":"..itemPerm;
end

-- Retunrs all info about the item specified as mail id.
-- if mail id >0 - inbox, 
-- -1 - outbox
function GTS_GetMailItemInfo(id)
	local texture, itemName, count, itemQuality, itemDesc, itemType, itemSubType, itemId, price;
	local i, command;
	
	GTS_Debug("MailID: "..id);
	
	if (id>0) then 
		itemName, texture, count = GetInboxItem(id);
	else 
		itemName, texture, count = GetSendMailItem();
	end
	if (not itemName) then return itemName; end
	_,_,texture = string.find(texture, "%a+\\%a+\\([%w_]+)");
	
	--Set tooltip to the current item
	GTS_ItemTooltip:SetOwner(UIParent, "ANCHOR_BOTTOMRIGHT");
	GTS_ItemTooltip:ClearLines();
	if (id>0) then 
		GTS_ItemTooltip:SetInboxItem(id);
	else
		GTS_ItemTooltip:SetSendMailItem();
	end
	
	--Copy the description test from the tooltip to the variable
	--<n> - new line symbol
	--<t> - tab symbol
	local color = {};
	color.r=-1;
	color.g=-1;
	color.b=-1;
	for i=1, GTS_ItemTooltip:NumLines(),1 do
	
		local curcolor = {};
		command = getglobal("GTS_ItemTooltipTextLeft" .. i);
		if (command:IsShown()) then
			text_left = command:GetText();
		else
			text_left = nil;
		end
		
		curcolor.r, curcolor.g, curcolor.b = command:GetTextColor();
		curcolor.r = GTS_ToHEX(math.ceil(curcolor.r*255));
		curcolor.g = GTS_ToHEX(math.ceil(curcolor.g*255));
		curcolor.b = GTS_ToHEX(math.ceil(curcolor.b*255));
		
		if (curcolor.r == "FF" and curcolor.g == "20" and curcolor.b == "20") then
			curcolor.g = "FF";
			curcolor.b = "FF";
		end
		
		if (curcolor ~= color and text_left and not string.find(text_left, "\n")) then
			color = curcolor;
			text_left = "<c> "..color.r..color.g..color.b.." "..text_left;
		end
		
		command = getglobal("GTS_ItemTooltipTextRight" .. i);
		if (command:IsShown()) then
			text_right = command:GetText();
		else
			text_right = nil;
		end
		
		curcolor.r, curcolor.g, curcolor.b = command:GetTextColor();
		curcolor.r = GTS_ToHEX(math.ceil(curcolor.r*255));
		curcolor.g = GTS_ToHEX(math.ceil(curcolor.g*255));
		curcolor.b = GTS_ToHEX(math.ceil(curcolor.b*255));
		
		if (curcolor.r == "FF" and curcolor.g == "20" and curcolor.b == "20") then
			curcolor.g = "FF";
			curcolor.b = "FF";
		end
		
		if (curcolor ~= color and text_right and not string.find(text_right, "\n")) then
			color = curcolor;
			text_right = "<c> "..color.r..color.g..color.b.." "..text_right;
		end
		
		if (text_left and string.find(text_left, "\n")) then
			text_left = " ";
		end
		
		if (text_right and string.find(text_right, "\n")) then
			text_right = " ";
		end
		
		if (i == 1) then 
			itemDesc = text_left;
		else
			if (text_left) then 
				itemDesc = itemDesc.." <n> "..text_left;
			end
		end
		if (text_right) then
			itemDesc = itemDesc.." <t> "..text_right;
		end
	end

	for i=3, 28000 do
		local name, _, _ = GetItemInfo(i);
		if ( name ) then
			local nameLength = strlen(name);
			if ( name == itemName or string.find(itemName, name) ) then
				-- Doesn't deal with same name, different item since none of these can be mailed
				itemId = i;
				break;
			end
		end
	end
	
	_, _, itemQuality, _, itemType, itemSubType = GetItemInfo(itemId);
	
	price = 0;
	if (IsAddOnLoaded("LootLink") and ItemLinks and ItemLinks[itemName] and ItemLinks[itemName].p) then
		price = ItemLinks[itemName].p;
	end
	
	return itemName, itemQuality, itemDesc, count, texture, itemType, itemSubType, itemId, price;
end

--Translates Dec number into Hex
function GTS_ToHEX(num)
	local top, bottom;
	bottom = math.mod(num,16);
	top = (num - bottom)/16;
	if (top>9) then
		if (top==10) then top = "A"; 
		elseif (top==11) then top = "B"; 
		elseif (top==12) then top = "C"; 
		elseif (top==13) then top = "D"; 
		elseif (top==14) then top = "E"; 
		elseif (top==15) then top = "F"; end
	end
	if (bottom>9) then
		if (bottom==10) then bottom = "A"; 
		elseif (bottom==11) then bottom = "B"; 
		elseif (bottom==12) then bottom = "C"; 
		elseif (bottom==13) then bottom = "D"; 
		elseif (bottom==14) then bottom = "E"; 
		elseif (bottom==15) then bottom = "F"; end
	end
	return top..bottom;
end

--Prints message into the text chat window
function GTS_Echo(message)
	if ( DEFAULT_CHAT_FRAME ) then 
		DEFAULT_CHAT_FRAME:AddMessage("GTS> "..message, 0.5, 0.5, 1.0);
	end
end

--Prints debug message into the chat window iff local variable GTS_DebugMode is set to 1
--otherwise does nothing
function GTS_Debug(message)
	if (GTS_DebugMode == 1) then
		message = "GTS><**Debug**> " .. message;
		if ( DEFAULT_CHAT_FRAME ) then 
			DEFAULT_CHAT_FRAME:AddMessage(message, 1.0, 0.0, 0.0);
		end
	end
end

function GTS_SetGUIName(frameName)
	GTS_Debug("set:"..frameName);
	GTS_Debug(" to '"..GTS_GUITEXT[frameName].."'");
	if (getglobal(frameName) and GTS_GUITEXT[frameName]) then
		getglobal(frameName):SetText(GTS_GUITEXT[frameName]);
	end
end