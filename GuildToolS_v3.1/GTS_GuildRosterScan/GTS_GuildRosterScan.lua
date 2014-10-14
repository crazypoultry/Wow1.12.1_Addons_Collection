--[[
GuildRosterScaner v3.1

Part of the GuildToolS package.
Dependancy: GTS_Core

	- Scans the entire guild roster including name, level, class, rank, professions*,
	main-alt relations*. 
	* - only if the guild note was properly entered (see manual).

Author: Roman Tarakanov (RTE/Arthas)
Date: Aug 24 '06

]]--

---------------------------------------------------------------
-------------Global GuildRosterScan functions------------------
---------------------------------------------------------------

--OnLoad function
function GTS_GRS_OnLoad()
	
	if (not GTS_Data) then GTS_Data = {}; end
	if (not GTS_Data.GRS) then GTS_Data.GRS = {}; end
	
	if (not GTS_Data.GRS.GuildRoster) then GTS_Data.GRS.GuildRoster = {}; end
	if (not GTS_Data.GRS.Date) then GTS_Data.GRS.Date = {}; end
	if (GetGuildInfo("player") and not GTS_Data.GRS.GuildRoster[GetGuildInfo("player")]) then GTS_Data.GRS.GuildRoster[GetGuildInfo("player")] = {}; end
	
	if (not GTS_Options[GTS_Position].GRSAUTO) then GTS_Options[GTS_Position].GRSAUTO = false; end
	
	if (GTS_Options[GTS_Position].GRSON) then GTS_Menu_GRS_loadGRS:SetChecked(true); else GTS_Menu_GRS_loadGRS:SetChecked(false); end
	if (GTS_Options[GTS_Position].GRSAUTO) then GTS_Menu_GRS_scanOnOpen:SetChecked(true); else GTS_Menu_GRS_scanOnOpen:SetChecked(false); end
	
	GTS_Menu_GRS_NL:Hide();
	GTS_Menu_GRS_Ver:SetText("v"..GTS_GRS_VER);
	if (GTS_GRS_VER ~= GTS_Core_VER) then
		GTS_Menu_GRS_Ver:SetTextColor(1,0,0);
	else
		GTS_Menu_GRS_Ver:SetTextColor(0,1,0);
	end
	GTS_Echo(GTS_MSG["GRS_GREETING"]);
	GTS_GRS_MenuUpdate();
end

--OnEvent function
function GTS_GRS_OnEvent(event)	 
	--GTS_Debug("OnEvent is called");
	
	if (event == "GUILD_ROSTER_UPDATE") then
		GTS_Debug("Roster updated.");
		if (GTS_Options[GTS_Position].GRSAUTO) then
			GTS_GRS_DoScan();
			GTS_Echo(GTS_MSG["GRS_DONE"]);
			GTS_GRS_MenuUpdate();
		end
		return 1;
		
	else
		return nil;
	end
end
GTS_functions_OnEvent["GTS_GuildRosterScan"] = GTS_GRS_OnEvent;

--Slash command handler
function GTS_GRS_SlashCommand(msg)
	if (msg == "grscan") then
		if (GetGuildInfo("player")) then
			GTS_Debug("GTS_GRS_DoScan is called.");
			GTS_GRS_DoScan();
			GTS_Echo(GTS_MSG["GRS_DONE"]);
			GTS_GRS_MenuUpdate();
		else
			GTS_Echo(GTS_MSG["GRS_NOGUILD"]);
		end
		return 1;
		
	elseif (msg == "grsclear") then
		GTS_Data.GRS.GuildRoster[GetGuildInfo("player")] = {};
		GTS_Data.GRS.Date[GetGuildInfo("player")] = nil;
		GTS_Echo(GTS_MSG["GRS_CLEARED"]);
		GTS_GRS_MenuUpdate();
		return 1;
		
	elseif (msg == "grsclearall") then
		GTS_Data.GRS.GuildRoster = {};
		GTS_GRS_MenuUpdate();
		return 1;
		
	elseif (msg == "grsinfo") then
		for i=1,table.getn(GTS_MSG["GRS_INFO"]) do
			GTS_Echo(GTS_MSG["GRS_INFO"][i]);
		end
		return 1;
		
	else
		return nil;
	end

end
GTS_functions_SlashCommand["GTS_GuildRosterScan"] = GTS_GRS_SlashCommand;


function GTS_GRS_MenuUpdate()
	
	local num,numup=0,0;
	
	if (GTS_Data.GRS.GuildRoster[GetGuildInfo("player")])then
		for index, element in GTS_Data.GRS.GuildRoster[GetGuildInfo("player")] do
			num = num +1;
			if (element.useGTS) then numup = numup + 1; end
		end
	end
	
	GTS_Menu_GRS_numMem1:SetText(numup);
	if (numup<num) then 
		GTS_Menu_GRS_numMem1:SetTextColor(1,0,0);
	else
		GTS_Menu_GRS_numMem1:SetTextColor(0,1,0);
	end
	GTS_Menu_GRS_numMem2:SetText(num);
		
	if (GTS_Data.GRS.Date[GetGuildInfo("player")]) then 
		if (string.gsub(GTS_Data.GRS.Date[GetGuildInfo("player")]," ","") == date("%y-%m-%d")) then
			GTS_Menu_GRS_LastScanStatus:SetText(GTS_MSG["TODAY"]);
			GTS_Menu_GRS_LastScanStatus:SetTextColor(0,1,0);
		else
			GTS_Menu_GRS_LastScanStatus:SetText("20"..string.gsub(GTS_Data.GRS.Date[GetGuildInfo("player")]," ","")..".");
			GTS_Menu_GRS_LastScanStatus:SetTextColor(0,1,0);
		end
	else
		GTS_Menu_GRS_LastScanStatus:SetText(GTS_MSG["NEVER"]);
		GTS_Menu_GRS_LastScanStatus:SetTextColor(1,0,0);
	end
	
end

---------------------------------------------------------------
-----------------GuildRosterScan functions---------------------
---------------------------------------------------------------

--This function actually scans all the guild members
function GTS_GRS_DoScan()
	GTS_Data.GRS.GuildRoster[GetGuildInfo("player")] = {};
	for i=1,GetNumGuildMembers(true),1 do
		--Get available guild member information
		local name, rank, rankIndex, level, class, _, note = GetGuildRosterInfo(i);
		--Get guild note and see if it matches the template
		local main, prof1, prof2, prof1lvl, prof2lvl, sorter, useGTS = 1, "n/a", "n/a", 0, 0, name, false;
		--If it does - parse it
		if (strfind(note, "GTS%-")) then
			GTS_Debug("note="..note);
			local _,_, ma,m,p1,p1lvl,p2,p2lvl = strfind(note, "GTS%-(%a-):(%a-);(%a-):(%d-);(%a-):(%d-);");
			GTS_Debug("name="..name);
			GTS_Debug("ma="..ma);
			--GTS_Debug("m="..m);
			--local m = "Rte";
			GTS_Debug("p1="..p1);
			GTS_Debug("pp1="..p1lvl);
			GTS_Debug("p2="..p2);
			GTS_Debug("pp2="..p2lvl);
			if (ma == "Main") then  main=1; else main = m; end
			if (p1 ~= "N") then prof1=GTS_PROF[p1]; else prof1 = GTS_MSG["NONE"]; end
			if (p2 ~= "N") then prof2=GTS_PROF[p2]; else prof2 = GTS_MSG["NONE"]; end
			prof1lvl = p1lvl;
			prof2lvl = p2lvl;
			if (ma == "A") then sorter = m..sorter; end
			useGTS=true;
		end
		
		local element = {	name = " "..name.." ",
							main = " "..main.." ",
							rank = " "..rank.." ",
							rankNum = " "..rankIndex.." ",
							level = " "..level.." ",
							class = " "..GTS_CLASS[class].." ",
							prof1 = " "..prof1.." ",
							prof1lvl = " "..prof1lvl.." ",
							prof2 = " "..prof2.." ",
							prof2lvl = " "..prof2lvl.." ",
							sorter = sorter,
							useGTS = useGTS};
		
		table.insert(GTS_Data.GRS.GuildRoster[GetGuildInfo("player")], element);
	end
	table.sort(GTS_Data.GRS.GuildRoster[GetGuildInfo("player")], function(i,j) return (i.sorter<j.sorter) end);
	GTS_Data.GRS.Date[GetGuildInfo("player")] = " "..date("%y-%m-%d").." ";
	GTS_Echo(GetNumGuildMembers(true)..GTS_MSG["PLAYERSSCANNED"]);
end
