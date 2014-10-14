--[[
IncomingMail v3.1

Part of the GuildToolS package.
Dependancy: GTS_Core

	- Keeps track of all the incoming mail including sender, item sent and date when 
	the message was received.
	
Author: Roman Tarakanov (RTE/Arthas)
Date: Aug 24 '06

]]--

local GTS_IM_NeedScan = 0;

---------------------------------------------------------------
----------------Global IncomingMail functions------------------
---------------------------------------------------------------

--OnEvent function
function GTS_IM_OnEvent(event)	 
	if (event == "MAIL_SHOW") then
		GTS_IM_NeedScan = 1;
		
	elseif (event == "MAIL_INBOX_UPDATE") then
		if (GTS_IM_NeedScan == 1) then
			GTS_Debug("Loading tooltips for "..GetInboxNumItems().." items.");
			local i;
			for i=1,GetInboxNumItems() do
				GTS_ItemTooltip:ClearLines();
				GTS_ItemTooltip:SetInboxItem(i);
			end
			GTS_IM_NeedScan = 0;
		end
		
	end
	GTS_IM_MenuUpdate();
	return nil;
end
GTS_functions_OnEvent["GTS_IncomingMail"] = GTS_IM_OnEvent;

--OnLoad function
function GTS_IM_OnLoad()	
	if (not GTS_Data) then GTS_Data = {}; end
	if (not GTS_Data.IM) then GTS_Data.IM = {}; end
	
	if (not GTS_Data.IM.ReceivedItems) then GTS_Data.IM.ReceivedItems = {}; end
	if (not GTS_Data.IM.GlobalID) then GTS_Data.IM.GlobalID = {}; end
	if (not GTS_Data.IM.GlobalID[UnitName("player")]) then GTS_Data.IM.GlobalID[UnitName("player")] = 1; end
	if (not GTS_Data.IM.ReceivedItems[UnitName("player")]) then GTS_Data.IM.ReceivedItems[UnitName("player")] = {}; end
	
	if (GTS_Options[GTS_Position].IMON) then GTS_Menu_IM_loadIM:SetChecked(true); else GTS_Menu_IM_loadIM:SetChecked(false); end
	
	GTS_Echo(GTS_MSG["IM_GREETING"]);
	GTS_Menu_IM_Ver:SetText("v"..GTS_IM_VER);
	if (GTS_IM_VER ~= GTS_Core_VER) then
		GTS_Menu_IM_Ver:SetTextColor(1,0,0);
	else
		GTS_Menu_IM_Ver:SetTextColor(0,1,0);
	end
	GTS_Menu_IM_NL:Hide();
	GTS_IM_MenuUpdate();
	return nil;
end

--Slash command handler
function GTS_IM_SlashCommand(msg)
	if (msg == "imclear") then
		GTS_Data.IM.ReceivedItems[UnitName("player")] = {};
		GTS_Echo(GTS_MSG["IM_CLEARED"]);
		GTS_IM_MenuUpdate();
		return 1;
		
	elseif (msg == "imclearall") then
		GTS_Data.IM.ReceivedItems = {};
		GTS_Data.IM.ReceivedItems[UnitName("player")] = {};
		GTS_Echo(GTS_MSG["IM_CLEARED"]);
		GTS_IM_MenuUpdate();
		return 1;
		
	elseif (msg == "imreset") then
		GTS_Data.IM.ReceivedItems = {}; 
		GTS_Data.IM.GlobalID = {};
		GTS_Data.IM.GlobalID[UnitName("player")] = 1; 
		GTS_Data.IM.ReceivedItems[UnitName("player")] = {}; 
		GTS_Echo(GTS_MSG["IM_RESET"]);
		GTS_IM_MenuUpdate();
		return 1;
		
	elseif (msg == "imreeval") then
		local index, element;
		if (not IsAddOnLoaded("LootLink")) then GTS_Echo(GTS_MSG["IM_NOLL"]); return 1; end
		for index, element in GTS_Data.IM.ReceivedItems[UnitName("player")] do
			local name = string.sub(element.name,2,string.len(element.name)-1);
			if (IsAddOnLoaded("LootLink") and ItemLinks and ItemLinks[name] and ItemLinks[name].p and (not element.price or element.price == " 0 ")) then
				GTS_Data.IM.ReceivedItems[UnitName("player")][index].price = " "..ItemLinks[name].p.." ";
				GTS_Debug(element.name..":Price is updated.");
			end
		end
		GTS_Echo(GTS_MSG["IM_REEVAL"]);
		GTS_IM_MenuUpdate();
		return 1;
		
	elseif (msg == "iminfo") then
		for i=1,table.getn(GTS_MSG["IM_INFO"]) do
			GTS_Echo(GTS_MSG["IM_INFO"][i]);
		end
		return 1;
		
	else
		return nil;
	end

end
GTS_functions_SlashCommand["GTS_IncomingMail"] = GTS_IM_SlashCommand;

function GTS_IM_MenuUpdate()
	
	local num,numup=0,0;
	
	for index, element in GTS_Data.IM.ReceivedItems[UnitName("player")] do
		num = num +1;
		if (element.price ~= " 0 ") then numup = numup + 1; end
	end
	
	GTS_Menu_IM_numVendorPrice1:SetText(numup);
	if (numup<num) then 
		GTS_Menu_IM_numVendorPrice1:SetTextColor(1,0,0);
	else
		GTS_Menu_IM_numVendorPrice1:SetTextColor(0,1,0);
	end
	GTS_Menu_IM_numVendorPrice2:SetText(num);
		
	if (IsAddOnLoaded("LootLink")) then 
		GTS_Menu_IM_VendorAddonStatus:SetText("LootLink.");
		GTS_Menu_IM_VendorAddonStatus:SetTextColor(0,1,0);
	end
	
	
	if (GTS_Data.IM.ReceivedItems[UnitName("player")][1]) then 
		local index=1;
		while (GTS_Data.IM.ReceivedItems[UnitName("player")][index]) do
			index = index+1;
		end
		if (string.gsub(GTS_Data.IM.ReceivedItems[UnitName("player")][index-1].date," ","") == date("%y-%m-%d")) then
			GTS_Menu_IM_fromDate:SetText(GTS_MSG["TODAY"]);
			GTS_Menu_IM_fromDate:SetTextColor(0,1,0);
		else
			GTS_Menu_IM_fromDate:SetText("20"..string.gsub(GTS_Data.IM.ReceivedItems[UnitName("player")][index-1].date," ",""));
			GTS_Menu_IM_fromDate:SetTextColor(0,1,0);
		end
		
		if (string.gsub(GTS_Data.IM.ReceivedItems[UnitName("player")][1].date," ","") == date("%y-%m-%d")) then
			GTS_Menu_IM_toDate:SetText(GTS_MSG["TODAY"]);
			GTS_Menu_IM_toDate:SetTextColor(0,1,0);
		else
			GTS_Menu_IM_toDate:SetText("20"..string.gsub(GTS_Data.IM.ReceivedItems[UnitName("player")][1].date," ","")..".");
			GTS_Menu_IM_toDate:SetTextColor(0,1,0);
		end
	else
		GTS_Menu_IM_toDate:SetText(GTS_MSG["NEVER"]);
		GTS_Menu_IM_toDate:SetTextColor(1,0,0);
		GTS_Menu_IM_fromDate:SetText(GTS_MSG["NEVER"]);
		GTS_Menu_IM_fromDate:SetTextColor(1,0,0);
	end
	
end
---------------------------------------------------------------
-------------------IncomingMail functions----------------------
---------------------------------------------------------------

--Replaces standard TakeInboxItem function with local one that also logs all incoming items.
GTS_IM_oldTakeInboxItem = TakeInboxItem;

function GTS_IM_TakeInboxItem(id)
	GTS_Debug("TakeInboxItem is called.");
	local itemName, itemQuality, itemDesc, count, texture, itemType, itemSubType, itemId, price = GTS_GetMailItemInfo(id);
	local _, _, sender = GetInboxHeaderInfo(id);
	
	local GlobalID = GTS_Data.IM.GlobalID[UnitName("player")].."";
	
	GTS_Data.IM.GlobalID[UnitName("player")] = GTS_Data.IM.GlobalID[UnitName("player")] + 1;
	
	local element = {name = " "..itemName.." ", description = " "..itemDesc.." ", 
					number = " "..count.." ", pic = " "..texture.." ", quality = " "..itemQuality.." ",
					type = " "..itemType.." ", subtype = " "..itemSubType.." ", id = " "..itemId.." ",
					globalid = " "..GlobalID.." ", from = " "..sender.." ", date = " "..date("%y-%m-%d").." ",
					price = " "..price.." "};
	table.insert(GTS_Data.IM.ReceivedItems[UnitName("player")], element);
	table.sort(GTS_Data.IM.ReceivedItems[UnitName("player")], function(i,j) 
																local a,b; 
																_, _, a = strfind(i.globalid, " (%d-) "); 
																_, _, b = strfind(j.globalid, " (%d-) "); 
																a=tonumber(a);
																b=tonumber(b);
																return a>b; 
																end);
	GTS_IM_MenuUpdate();
	return GTS_IM_oldTakeInboxItem(id);
	
end
TakeInboxItem = GTS_IM_TakeInboxItem;