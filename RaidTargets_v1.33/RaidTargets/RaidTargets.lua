-- RaidTargets Mod for WoW by Varuul
--0 = no icon 
--1 = Yellow 4-point Star 
--2 = Orange Circle 
--3 = Purple Diamond 
--4 = Green Triangle 
--5 = White Crescent Moon 
--6 = Blue Square 
--7 = Red "X" Cross 
--8 = White Skull 


-----------------------------------------------------------------------------------------------------------------------

function RT_Init()
	BINDING_HEADER_RAIDTARGETS = "RaidTargets";
	BINDING_NAME_RAIDTARGETSTOGGLE = "Toggle RT GUI";
	BINDING_NAME_RAIDTARGETSSET = "Assign TargetIcons";
	BINDING_NAME_RAIDTARGETSFIND = "Find Your Target";
	
	RT_HelpStrings = { };
	table.insert (RT_HelpStrings, "Welcome to RaidTargets! ..these are your SlashCommands");
	table.insert (RT_HelpStrings, "To show/hide RT:: /rta");
	table.insert (RT_HelpStrings, "To view this help:: /rta help");
	table.insert (RT_HelpStrings, "List all RaidMembers using RTa:: /rta who");
	table.insert (RT_HelpStrings, "Set your TargetMaster (auto-assist him):: /rta tm <nameofplayer>");
	table.insert (RT_HelpStrings, "To set the scale of RT:: /rta scale <number between 0.3 and 2.0>");
	

	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
	this:RegisterEvent("CHAT_MSG_ADDON");
	this:RegisterEvent("RAID_TARGET_UPDATE");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");

	RT_BackGroundFile = "Interface\\AddOns\\RaidTargets\\bg_001.tga"; 	
	getglobal("RTFrame"):SetBackdrop({bgFile = RT_BackGroundFile, edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = DSP_TileSize, edgeSize = 16, insets = { left = 4, right = 4, top = 4, bottom = 4 }});
	
	SlashCmdList["RAIDTARGETS"] = RT_Slash_Handler;
	SLASH_RAIDTARGETS1 = "/rta";
	SLASH_RAIDTARGETS2 = "/raidtargets";
	
	if (not RT_ShowToolTips) then RT_ShowToolTips = 1; end
	if (not RT_Minimized) then RT_Minimized = 0; end
	if (not RT_MarkFriends) then RT_MarkFriends = 0; end
	if (not RT_MarkNeutrals) then RT_MarkNeutrals = 0; end
	if (not RT_MarkFoes) then RT_MarkFoes = 1; end
	if (not RT_Scale) then RT_Scale = 1; end
	if (not RT_MyTargetIcon) then RT_MyTargetIcon = 1; end
	if (not RT_Visible) then RT_Visible = 1; end
	
	RT_GotMarkedTarget = 0;

	RTaRunners = {};
	
	RT_TargetMaster = "no one at all";
	
	RT_lang = GetDefaultLanguage("player");
	
	RT_YDimension = 230;
end

-----------------------------------------------------------------------------------------------------------------------

function RT_StartUp()
	RT_Title = "RTa1.3";
	RT_MsgOut(RT_Title.."  by Varuul active");
  RT_NextIcon = 1;
  RT_Version = "v1.33";
  RT_getTarget = 0;
  RT_CurrentActionEdit = 0;
  RT_TargetName = { "unassigned", "unassigned", "unassigned", "unassigned", "unassigned", "unassigned", "unassigned", "unassigned" };
  if (not RT_TargetAction) then
  	RT_TargetAction = { "do something!", "do something!", "do something!", "do something!", "do something!", "do something!", "do something!", "do something!" };
  end
  RTFrame:SetScale(RT_Scale);
  getglobal("RTFrameTitle"):SetText(RT_Title);
  
  RT_AssignIcon ("init", RT_MyTargetIcon);

	if (RT_MarkFoes == 0) then
		getglobal("RT_MarkFoeButton"):SetNormalTexture("Interface\\Addons\\RaidTargets\\no_foe.tga");
	else
		getglobal("RT_MarkFoeButton"):SetNormalTexture("Interface\\Addons\\RaidTargets\\foe.tga");
	end

	if (RT_MarkNeutrals == 0) then
		getglobal("RT_MarkNeutralButton"):SetNormalTexture("Interface\\Addons\\RaidTargets\\no_neutral.tga");
	else
		getglobal("RT_MarkNeutralButton"):SetNormalTexture("Interface\\Addons\\RaidTargets\\neutral");
	end

	if (RT_MarkFriends == 0) then
		getglobal("RT_MarkFriendButton"):SetNormalTexture("Interface\\Addons\\RaidTargets\\no_friend.tga");
	else
		getglobal("RT_MarkFriendButton"):SetNormalTexture("Interface\\Addons\\RaidTargets\\friend");
	end
	
	if (RT_ShowToolTips == 0) then
		getglobal("RT_ToolTipsButton"):SetNormalTexture("Interface\\Addons\\RaidTargets\\no_tooltips");
	else
		getglobal("RT_ToolTipsButton"):SetNormalTexture("Interface\\Addons\\RaidTargets\\tooltips");
	end	
		
	if (RT_Minimized == 0) then
		RT_Minimized = 1;
		RT_MinOrExpandButtonClick();
	else
		RT_Minimized = 0;
		RT_MinOrExpandButtonClick();	
	end

	
	
	if (RT_Visible == 1) then
		getglobal("RTFrame"):Show();
	end
	RT_SendAddonMsg("active "..RT_Version);
	
	RT_UpdateTargetNames();
	
end

-----------------------------------------------------------------------------------------------------------------------

function RT_Slash_Handler(msg)
	if (strlower(msg) == "") then																										-- VISIBILITY TOGGLE
		RT_FrameToggle();
	elseif (strlower(msg) == "help") then
		for i = 1, table.getn(RT_HelpStrings) do
			RT_MsgOut(RT_HelpStrings[i]);
		end
	elseif (strlower(msg) == "who") then																						-- check raiders for RTA
		local listofrtarunners = "Raiders having RTa: ";
		for i = 1, table.getn(RTaRunners) do
			if (RTaRunners[i].Name) then
				RT_addplayerinfo = RTaRunners[i].Name .. "[" .. RTaRunners[i].Version .. "], ";
				if (strlen(listofrtarunners) + strlen(RT_addplayerinfo) < 250) then
					listofrtarunners = listofrtarunners .. RT_addplayerinfo;
				else
					RT_MsgOut(listofrtarunners);
					listofrtarunners = RT_addplayerinfo;
				end
			end
			listofrtarunners = string.sub(listofrtarunners,1, strlen(listofrtarunners) -2) .. ".";
		end
		
		RT_MsgOut(listofrtarunners);
	elseif (strlower(string.sub(msg,1,5)) == "scale") then													-- frame scale
		RT_Scale = tonumber(string.sub(msg, 7));
		if (RT_Scale) then
			if (RT_Scale > 0.29 and RT_Scale < 2.1) then
				RTFrame:SetScale(RT_Scale);
				RT_MsgOut("your RTa Scale now is "..RT_Scale);
			else
				RT_MsgOut("Your input was wrong. use format: /rta scale 1.0");
			end
		end
	elseif (strlower(string.sub(msg,1,2)) == "tm" or strlower(string.sub(msg,1,2)) == "targetmaster") then		-- targetmaster setting
		local TM = string.sub(msg,3);
		if (RT_IsInRaid(TM) == 1) then
			if (RT_RunsRTa(TM)) then
				RT_TargetMaster = TM;
				RT_MsgOut("your TargetMaster now is "..RT_TargetMaster);
				getglobal("RT_TargetMasterEdit"):SetText(RT_TargetMaster);
				getglobal("TargetMasterCheck"):SetChecked(1);
			else
				RT_MsgOut("your TargetMaster can not be someone not running RTa!");
			end
		else
			RT_MsgOut("your TargetMaster needs to be in the raid!");
		end
	end
	
end

-----------------------------------------------------------------------------------------------------------------------

function RT_FrameToggle()
	if (getglobal("RTFrame"):IsShown() == 1) then
		getglobal("RTFrame"):Hide();
		RT_Visible = 0;
	else
		getglobal("RTFrame"):Show();
		RT_Visible = 1;
	end
end



-----------------------------------------------------------------------------------------------------------------------

function RT_MarkTargets()
	RT_icon=GetRaidTargetIndex("mouseover");
	if (not RT_icon) then
		RT_icon = 0;
	end
	if (RT_icon == 0) then
		if  ((RT_MarkFoes == 1 and UnitIsEnemy("mouseover", "player") == 1)
		or (RT_MarkFriends == 1 and UnitIsFriend("mouseover", "player") == 1)
		or (RT_MarkNeutrals == 1 and UnitIsFriend("mouseover", "player") == nil and UnitIsEnemy("mouseover", "player") == nil)) then
			if (RT_active == 1) then
				while (getglobal("RT_Icon"..RT_NextIcon.."Check"):GetChecked() == NIL and RT_NextIcon < 9) do
					RT_NextIcon = RT_NextIcon + 1;
				end

				RT_icon=GetRaidTargetIndex("mouseover");
				if (not RT_icon) then
					RT_icon = 0;
				end

				if (RT_icon == 0 and getglobal("RT_Icon"..RT_NextIcon.."Check"):GetChecked() == 1) then
					SetRaidTarget("mouseover", RT_NextIcon);
					RT_TargetName[RT_NextIcon] = UnitName("mouseover");
					local msg = "TLIST"..RT_NextIcon..UnitName("mouseover");
					RT_SendAddonMsg(msg);
					RT_ChangedTargets = 1;
					RT_NextIcon = RT_NextIcon + 1;
				end
				
				if (RT_NextIcon > 8) then
					RT_NextIcon = 1;
					RT_active = 0;
					RT_SendAllTargets();
					RT_MsgOut("finished target assignments.");
				end
			end
			RT_UpdateTargetNames();
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------

function RT_OnEvent(event)
  if (event == "VARIABLES_LOADED") then																						-- we are conceived by wow! halle and luja
  	RT_StartUp();
  elseif (event == "UPDATE_MOUSEOVER_UNIT") then																	-- i just moused over a unit! 
  	RT_MarkTargets();
  	if (RT_getTarget == 1) then 
  		RT_GetMyTarget(); 
  	end
  elseif (event == "RAID_ROSTER_UPDATE") then																			-- New person in my raid? lets tell them i run rta!
  	GetNumRaidMembers();
  	RT_SendAddonMsg("active "..RT_Version);
  elseif (event == "RAID_TARGET_UPDATE") then																			-- I just changed my targets icon? my target?
  	if (IsRaidLeader() == 1 or IsRaidOfficer() == 1) then
	  	RT_newIcon = GetRaidTargetIndex("target");
	  	if (RT_newIcon ~= nil) then
  			RT_TargetName[RT_newIcon] = UnitName("target");
  			if (RT_targetIconNow and RT_targetIconNow ~= RT_newIcon) then
  				RT_TargetName[RT_targetIconNow] = "removed";
  			end
				if (RT_active == 0 and RT_newIcon > 0 and RT_newIcon < 9) then
					local sndmsg = "TList"..RT_newIcon..RT_TargetName[RT_newIcon];
					RT_SendAddonMsg(sndmsg);  				
				end
				RT_UpdateTargetNames();
			end
		end
  elseif (event == "PLAYER_TARGET_CHANGED") then																	-- I changed my target .. lets inform the others!
  	RT_targetIconNow = GetRaidTargetIndex("target");
  	if (RT_targetIconNow ~= nil) then
  		RT_SendAddonMsg("NIT"..RT_targetIconNow);   -- NIT = NewIconedTarget
  	else 
  		RT_SendAddonMsg("NUT");		-- NUT = NewUnmarkedTarget
  	end
  	if (RT_MyTargetIcon ~= GetRaidTargetIndex("target") and RT_followTarget == 1) then		-- I changed my target, but wanted another target anyways... lets reget mine if possible
 			RT_getTarget = 1;
 			RT_GetMyTarget();
  	end
  elseif (event == "CHAT_MSG_ADDON") then
  	if (arg1 == "RTA") then
  		-- RT_MsgOut("got from: "..arg4.." this: "..arg2);
  		if (string.sub(arg2, 1, 6) == "active") then																-- Hello world - RTa user sends his hellos
  			local RTaVer = string.sub(arg2, 8);
  			for i=1, table.getn(RTaRunners) do
  				if (RTaRunners[i] ~= nil) then
  					if (strlower(RTaRunners[i].Name) == strlower(arg4)) then
  						table.remove(RTaRunners, i);
  					end
  				end
  			end
  			table.insert(RTaRunners, { Name = arg4, Version = RTaVer });
  		end
  		
 			if (string.sub(arg2,1,3) == "NUT" or string.sub(arg2,1,3) == "NIT") then
 				if (strlower(arg4) == strlower(RT_TargetMaster)) then										-- TargetMaster sends new target and I follow him
					AssistByName(arg4);
					RT_getTarget = 0;																											-- targetMaster overrides looking for target
				else																																		-- somebody has just targeted my targeticon. i assist
					if (RT_MyTargetIcon ~= GetRaidTargetIndex("target") and RT_getTarget == 1 and tonumber(string.sub(arg2,4)) == RT_MyTargetIcon) then
						AssistByName(arg4);
						RT_getTarget = 0;	
					end
				end
  		end
  		if (string.sub(arg2,1,5) == "TList") then																		-- leader or officer is sending targets
  			RT_Tid = tonumber(string.sub(arg2,6,6));
  			RT_Tname = string.sub(arg2,7);
  			RT_TargetName[RT_Tid] = RT_Tname;
  			-- RT_MsgOut("name set : "..RT_Tid.." = "..RT_TargetName[RT_Tid]);
  			RT_UpdateTargetNames();
  		end
  		if (string.sub(arg2,1,7) == "TAction") then
  			-- RT_MsgOut("got new TAction:"..arg2);
  			RT_Tid = tonumber(string.sub(arg2,8,8));
  			RT_TargetAction[RT_Tid] = string.sub(arg2,9);
  			-- RT_MsgOut("action set : "..RT_TargetAction[RT_Tid]);
  			RT_UpdateTargetNames();
  		end
  	end
  end
end

-----------------------------------------------------------------------------------------------------------------------

function RT_GetMyTarget()
	if (RT_getTarget == 1) then
		if (GetRaidTargetIndex("mouseover") == RT_MyTargetIcon) then
			TargetUnit("mouseover");
			RT_getTarget = 0;
			TargetUnit("target");
		else
			local RT_RaidMemberNumber = GetNumRaidMembers();
			for i = 1, RT_RaidMemberNumber do
				if (GetRaidTargetIndex("raid"..i.."target") == RT_MyTargetIcon) then
					TargetUnit("raid"..i.."target");
					RT_getTarget = 0;
				end
			end
		end
		if (RT_getTarget == 0) then
			-- RT_MsgOut("got your target!");
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------

function RT_MsgOut(msg)
	DEFAULT_CHAT_FRAME:AddMessage("RT:: "..msg, 1, 1, 1);
end

-----------------------------------------------------------------------------------------------------------------------

function RT_SetTargets()
	if (GetNumRaidMembers() > 0 or GetNumPartyMembers() > 0 ) then
		if (IsRaidLeader() == 1 or IsRaidOfficer() == 1 or IsPartyLeader() == 1) then
			if (RT_active == 1) then
				RT_active = 0;
				RT_MsgOut("stopped target assignments.");
				RT_SendAllTargets();
			else
				RT_ClearIcons();
				RT_active = 1;
				RT_NextIcon = 1;
				RT_MsgOut("started target assignments.");
				for i=1, 8 do
					RT_TargetName[i] = "unassigned";
				end
			end
			RT_UpdateTargetNames();
		else
			RT_MsgOut("sorry, but you have to be IN A RAID/PARTY and Leader/Officer to use the RaidIcons distribution feature of WoW!");
		end
	else
		RT_MsgOut("sorry, but you have to be IN A RAID/PARTY and Leader/Officer to use the RaidIcons distribution feature of WoW!");
	end	
end

-----------------------------------------------------------------------------------------------------------------------

function RT_ClearIcons()
	for i=8, 1, -1 do
		if (getglobal("RT_Icon"..i.."Check"):GetChecked() == 1) then
			SetRaidTarget("player", i);
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------

function RT_FindTarget()
	if (GetNumRaidMembers() > 0 or GetNumPartyMembers() > 0 ) then
		if (RT_getTarget == 0) then
			RT_MsgOut("you'll get your assigned target once your mouse passes over it!");
			RT_getTarget = 1;
			RT_GetMyTarget();
		else
			RT_MsgOut("stopped finding target!");
			RT_getTarget = 0;
		end
	else
		RT_MsgOut("sorry, but you have to be IN A RAID/PARTY to use the RaidIcons feature of WoW!");
	end
end

-----------------------------------------------------------------------------------------------------------------------

function RT_UpdateTargetNames()
	for i=1, 8 do
			if (RT_TargetName[i] == nil) then
				RT_TargetName[i] = "unassigned";
			end
			getglobal("RT_Icon"..i.."AssignedUnit"):SetText(RT_TargetName[i]);
			
			if (RT_TargetAction[i] == nil) then
				RT_TargetAction[i] = "do something!";
			end
			getglobal("RT_IconDescription"..i.."Action"):SetText(RT_TargetAction[i]);
	end
end

-----------------------------------------------------------------------------------------------------------------------

function RT_AssignIcon (arg1, RT_id)
	if (arg1 == "RightButton") then
	else
		getglobal("RT_myTarget"):ClearAllPoints();
		getglobal("RT_myTarget"):SetPoint("TOPLEFT", "RT_Icon"..RT_id, "TOPLEFT", 16, 0);
		RT_MyTargetIcon = tonumber(RT_id);
	end
end

-----------------------------------------------------------------------------------------------------------------------

function RT_MarkFoeButtonClick()
	if (RT_MarkFoes == 1) then
		RT_MarkFoes = 0;
		getglobal("RT_MarkFoeButton"):SetNormalTexture("Interface\\Addons\\RaidTargets\\no_foe.tga");
	else
		RT_MarkFoes = 1;
		getglobal("RT_MarkFoeButton"):SetNormalTexture("Interface\\Addons\\RaidTargets\\foe.tga");
	end
end

-----------------------------------------------------------------------------------------------------------------------

function RT_MarkNeutralButtonClick()
	if (RT_MarkNeutrals == 1) then
		RT_MarkNeutrals = 0;
		getglobal("RT_MarkNeutralButton"):SetNormalTexture("Interface\\Addons\\RaidTargets\\no_neutral.tga");
	else
		RT_MarkNeutrals = 1;
		getglobal("RT_MarkNeutralButton"):SetNormalTexture("Interface\\Addons\\RaidTargets\\neutral");
	end
end

-----------------------------------------------------------------------------------------------------------------------

function RT_MarkFriendlyButtonClick()
	if (RT_MarkFriends == 1) then
		RT_MarkFriends = 0;
		getglobal("RT_MarkFriendButton"):SetNormalTexture("Interface\\Addons\\RaidTargets\\no_friend.tga");
	else
		RT_MarkFriends = 1;
		getglobal("RT_MarkFriendButton"):SetNormalTexture("Interface\\Addons\\RaidTargets\\friend");
	end
end

-----------------------------------------------------------------------------------------------------------------------

function RT_ToolTipsToggle()
	if (RT_ShowToolTips == 1) then
		RT_ShowToolTips = 0;
		getglobal("RT_ToolTipsButton"):SetNormalTexture("Interface\\Addons\\RaidTargets\\no_tooltips");
	else
		RT_ShowToolTips = 1;
		getglobal("RT_ToolTipsButton"):SetNormalTexture("Interface\\Addons\\RaidTargets\\tooltips");
	end
end

-----------------------------------------------------------------------------------------------------------------------

function RT_MinOrExpandButtonClick()
	if (RT_Minimized == 1) then
		RT_Minimized = 0;
		getglobal("RT_MinOrExpandButton"):SetNormalTexture("Interface\\Addons\\RaidTargets\\minimize");
		getglobal("RTFrame"):SetHeight(RT_YDimension);
		for i = 1, 8 do
			getglobal("RT_Icon"..i):Show();
			getglobal("RT_IconDescription"..i):Show();
			getglobal("RT_TargetMasterEdit"):Show();
			getglobal("TargetMasterCheck"):Show();
		end		
		getglobal("RT_myTarget"):Show();
	else
		RT_Minimized = 1;
		getglobal("RT_MinOrExpandButton"):SetNormalTexture("Interface\\Addons\\RaidTargets\\extend");
		getglobal("RTFrame"):SetHeight(28);
		for i = 1, 8 do
			getglobal("RT_Icon"..i):Hide();
			getglobal("RT_IconDescription"..i):Hide();
			getglobal("RT_TargetMasterEdit"):Hide();
			getglobal("TargetMasterCheck"):Hide();
		end
		getglobal("RT_myTarget"):Hide();		
	end
end

-----------------------------------------------------------------------------------------------------------------------

function RT_SendAddonMsg(msg)
	SendAddonMessage("RTA", msg, "RAID");
end

-----------------------------------------------------------------------------------------------------------------------
-- This FUNCTION WILL check whether somebody is in your raid and return a bool***********************************************************************
function RT_IsInRaid(name)
	local found = 0;
	local RTmaxRaid = GetNumRaidMembers();
	local NameCompare = name;
	for i=1, RTmaxRaid do
		local RaidmemberName, _, _, _, _, _, _, _, _ = GetRaidRosterInfo(i);
		if (strlower(RaidmemberName) == strlower(NameCompare)) then
			found = 1;
			return 1;
		end
	end
	if (found == true ) then
		return 1;
	else
		return 0;
	end
end

-----------------------------------------------------------------------------------------------------------------------

function RT_RunsRTa(name)
	local RunRTaTableSize = table.getn(RTaRunners);
	local found = false;
	for i=1, RunRTaTableSize do
		if (strlower(name) == strlower(RTaRunners[i].Name)) then
			return 1;
		end
	end
	return 0;
end

-----------------------------------------------------------------------------------------------------------------------
function RT_TargetMaster_OnClick()
	if (getglobal("TargetMasterCheck"):GetChecked() == 1) then
		local TM = getglobal("RT_TargetMasterEdit"):GetText();
		if (RT_IsInRaid(TM) == 1) then
			if (RT_RunsRTa(TM)) then
				RT_TargetMaster = TM;
				RT_MsgOut("your TargetMaster now is "..RT_TargetMaster);
				getglobal("RT_TargetMasterEdit"):SetText(RT_TargetMaster);
			else
				RT_MsgOut("your TargetMaster can not be someone not running RTa!");
				getglobal("TargetMasterCheck"):SetChecked(0);
			end
		else
			RT_MsgOut("your TargetMaster needs to be in the raid!");
			getglobal("TargetMasterCheck"):SetChecked(0);
		end		
	end
end

-----------------------------------------------------------------------------------------------------------------------

function RT_IconActionInfo_OnClick(iconid)
	getglobal("RT_IconActionInfoEdit"):ClearAllPoints();
	RT_CurrentActionEdit = iconid;
	local point,relativeTo,relativePoint,xOfs,yOfs = getglobal("RT_IconDescription"..iconid):GetPoint();
	getglobal("RT_IconActionInfoEdit"):SetPoint(point, relativeTo, relativePoint, xOfs + 4, yOfs + 6);
	getglobal("RT_IconActionInfoEdit"):SetText(RT_TargetAction[iconid]);
	getglobal("RT_IconActionInfoEdit"):Show();
	getglobal("RT_IconActionInfoEdit"):SetFocus();
end

-----------------------------------------------------------------------------------------------------------------------

function RT_IconActionInfo_OnEnter(iconid)
	RT_TargetAction[iconid] = getglobal("RT_IconActionInfoEdit"):GetText();
	if (IsRaidLeader() == 1 or IsRaidOfficer() == 1 or IsPartyLeader() == 1) then
		local sndmsg = "TAction"..iconid..RT_TargetAction[iconid];
		RT_SendAddonMsg(sndmsg);
	end
	RT_UpdateTargetNames();		
end

-----------------------------------------------------------------------------------------------------------------------

function RT_SendAllTargets()
	for i = 1, 8 do
		if (RT_TargetName[i] ~= nil) then
			local msg1 = "TList"..i..RT_TargetName[i];
			RT_SendAddonMsg(msg1);
		end
		if (RT_TargetAction[i] ~= nil) then		
			local msg2 = "TAction"..i..RT_TargetAction[i];
			RT_SendAddonMsg(msg2);
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------