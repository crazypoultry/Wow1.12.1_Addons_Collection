--[[
OutgoingMail v3.1

Part of the GuildToolS package.
Dependancy: GTS_Core

	- Keeps track of all the outgoing mail including receiver, item sent and date when 
	he message was sent.

Author: Roman Tarakanov (RTE/Arthas)
Date: Aug 24 '06

]]--
---------------------------------------------------------------
----------------------Standart mesages-------------------------
---------------------------------------------------------------



---------------------------------------------------------------
---------------Global OutgoingMail functions-------------------
---------------------------------------------------------------

--OnEvent function
function GTS_OM_OnEvent(event)	 

	return nil;
end
GTS_functions_OnEvent["GTS_OutgoingMail"] = GTS_OM_OnEvent;

--OnLoad function
function GTS_OM_OnLoad()	
	if (not GTS_Data) then GTS_Data = {}; end
	if (not GTS_Data.OM) then GTS_Data.OM = {}; end
	
	if (not GTS_Data.OM.SentItems) then GTS_Data.OM.SentItems = {}; end
	if (not GTS_Data.OM.GlobalID) then GTS_Data.OM.GlobalID = {}; end
	if (not GTS_Data.OM.GlobalID[UnitName("player")]) then GTS_Data.OM.GlobalID[UnitName("player")] = 1; end
	if (not GTS_Data.OM.SentItems[UnitName("player")]) then GTS_Data.OM.SentItems[UnitName("player")] = {}; end
	
	if (GTS_Options[GTS_Position].OMON) then GTS_Menu_OM_loadOM:SetChecked(true); else GTS_Menu_OM_loadOM:SetChecked(false); end
	
	GTS_Menu_OM_NL:Hide();
	GTS_Menu_OM_Ver:SetText("v"..GTS_OM_VER);
	if (GTS_OM_VER ~= GTS_Core_VER) then
		GTS_Menu_OM_Ver:SetTextColor(1,0,0);
	else
		GTS_Menu_OM_Ver:SetTextColor(0,1,0);
	end
	GTS_Echo(GTS_MSG["OM_GREETING"]);
	GTS_OM_MenuUpdate();
	return nil;
end

--Slash command handler
function GTS_OM_SlashCommand(msg)
	if (msg == "omclear") then
		GTS_Data.OM.SentItems[UnitName("player")] = {};
		GTS_Echo(GTS_MSG["OM_CLEARED"]);
		GTS_OM_MenuUpdate();
		return 1;
		
	elseif (msg == "omclearall") then
		GTS_Data.OM.SentItems = {};
		GTS_Data.OM.SentItems[UnitName("player")] = {};
		GTS_Echo(GTS_MSG["OM_CLEARED"]);
		GTS_OM_MenuUpdate();
		return 1;
		
	elseif (msg == "omreset") then
		GTS_Data.OM.SentItems = {}; 
		GTS_Data.OM.GlobalID = {};
		GTS_Data.OM.GlobalID[UnitName("player")] = 1; 
		GTS_Data.OM.SentItems[UnitName("player")] = {}; 
		GTS_Echo(GTS_MSG["OM_RESET"]);
		GTS_OM_MenuUpdate();
		return 1;
		
	elseif (msg == "omreeval") then
		local index, element;
		if (not IsAddOnLoaded("LootLink")) then GTS_Echo(GTS_MSG["OM_NOLL"]); return 1; end
		for index, element in GTS_Data.OM.SentItems[UnitName("player")] do
			local name = string.sub(element.name,2,string.len(element.name)-1);
			if (IsAddOnLoaded("LootLink") and ItemLinks and ItemLinks[name] and ItemLinks[name].p and (not element.price or element.price == " 0 ")) then
				GTS_Data.OM.SentItems[UnitName("player")][index].price = " "..ItemLinks[name].p.." ";
				GTS_Debug(element.name..":Price is updated.");
			end
		end
		GTS_Echo(GTS_MSG["OM_REEVAL"]);
		GTS_OM_MenuUpdate();
		return 1;
	
	elseif (msg == "ominfo") then
		for i=1,table.getn(GTS_MSG["OM_INFO"]) do
			GTS_Echo(GTS_MSG["OM_INFO"][i]);
		end
		return 1;
		
	else
		return nil;
	end

end
GTS_functions_SlashCommand["GTS_OutgoingMail"] = GTS_OM_SlashCommand;

function GTS_OM_MenuUpdate()
	
	local num,numup=0,0;
	
	for index, element in GTS_Data.OM.SentItems[UnitName("player")] do
		num = num +1;
		if (element.price ~= " 0 ") then numup = numup + 1; end
	end
	
	GTS_Menu_OM_numVendorPrice1:SetText(numup);
	if (numup<num) then 
		GTS_Menu_OM_numVendorPrice1:SetTextColor(1,0,0);
	else
		GTS_Menu_OM_numVendorPrice1:SetTextColor(0,1,0);
	end
	GTS_Menu_OM_numVendorPrice2:SetText(num);
		
	if (IsAddOnLoaded("LootLink")) then 
		GTS_Menu_OM_VendorAddonStatus:SetText("LootLink.");
		GTS_Menu_OM_VendorAddonStatus:SetTextColor(0,1,0);
	end
	
	
	if (GTS_Data.OM.SentItems[UnitName("player")][1]) then 
		local index=1;
		while (GTS_Data.OM.SentItems[UnitName("player")][index]) do
			index = index+1;
		end
		if (string.gsub(GTS_Data.OM.SentItems[UnitName("player")][index-1].date," ","") == date("%y-%m-%d")) then
			GTS_Menu_OM_fromDate:SetText("Today");
			GTS_Menu_OM_fromDate:SetTextColor(0,1,0);
		else
			GTS_Menu_OM_fromDate:SetText("20"..string.gsub(GTS_Data.OM.SentItems[UnitName("player")][index-1].date," ",""));
			GTS_Menu_OM_fromDate:SetTextColor(0,1,0);
		end
		
		if (string.gsub(GTS_Data.OM.SentItems[UnitName("player")][1].date," ","") == date("%y-%m-%d")) then
			GTS_Menu_OM_toDate:SetText("Today.");
			GTS_Menu_OM_toDate:SetTextColor(0,1,0);
		else
			GTS_Menu_OM_toDate:SetText("20"..string.gsub(GTS_Data.OM.SentItems[UnitName("player")][1].date," ","")..".");
			GTS_Menu_OM_toDate:SetTextColor(0,1,0);
		end
	else
		GTS_Menu_OM_toDate:SetText("Never.");
		GTS_Menu_OM_toDate:SetTextColor(1,0,0);
		GTS_Menu_OM_fromDate:SetText("Never");
		GTS_Menu_OM_fromDate:SetTextColor(1,0,0);
	end
	
end
---------------------------------------------------------------
-------------------OutgoingMail functions----------------------
---------------------------------------------------------------

--Replaces standard SendMail function with local one that also logs all outgoing items.
GTS_OM_oldSendMail = SendMail;

function GTS_OM_SendMail(to, subj, body)
	GTS_Debug("SendMail is called.");
	local itemName, itemQuality, itemDesc, count, texture, itemType, itemSubType, itemId, price = GTS_GetMailItemInfo(-1);
	local receiver = to;
	
	local GlobalID = GTS_Data.OM.GlobalID[UnitName("player")].."";
	
	GTS_Data.OM.GlobalID[UnitName("player")] = GTS_Data.OM.GlobalID[UnitName("player")] + 1;
	
	if (not itemName) then return GTS_OM_oldSendMail(to, subj, body); end
	
	local element = {name = " "..itemName.." ", description = " "..itemDesc.." ", 
					number = " "..count.." ", pic = " "..texture.." ", quality = " "..itemQuality.." ",
					type = " "..itemType.." ", subtype = " "..itemSubType.." ", id = " "..itemId.." ",
					globalid = " "..GlobalID.." ", to = " "..receiver.." ", date = " "..date("%y-%m-%d").." ",
					price = " "..price.." "};
	table.insert(GTS_Data.OM.SentItems[UnitName("player")], element);
	table.sort(GTS_Data.OM.SentItems[UnitName("player")], function(i,j) 
																local a,b; 
																_, _, a = strfind(i.globalid, " (%d-) "); 
																_, _, b = strfind(j.globalid, " (%d-) "); 
																a=tonumber(a);
																b=tonumber(b);
																return a>b; 
																end);
	GTS_OM_MenuUpdate();
	return GTS_OM_oldSendMail(to, subj, body);
	
end

SendMail = GTS_OM_SendMail;