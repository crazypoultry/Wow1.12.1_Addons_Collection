--[[
	Oedi's BG Usefull TOols
	
	by oedi057@yahoo.com
]]

local OD_BGCONFIRM = 0;							-- time for the drop
local OD_TOGGLE = 0;							-- the minimap is showing
local OD_hordecnt = 0; 							-- running count of horder
local OD_alliancecnt = 0;						-- running count of alliance
local od_StaticPopup_OnHide;					-- Detects when you click 'hide' on BG invite request.
local od_inbg = false; 							-- this stores if they are in a bg
local od_inconfirm = false; 					-- this stores if they are in a que for count
local od_version = "2.6 Beta"
local od_hordeflag = ""							-- this stores who is carrying the horde flag in WSG
local od_allianceflag = ""						-- this stores who is carrying the alliance flag in WSG

local od_ab, od_av, od_wsg, od_badge, od_avinfo	-- arrays for the battle grounds

od_ab = {};
od_av = {};
od_wsg = {};
-- 1 = current
-- 2 = index
-- 3 = name
-- 4 = mode
-- 5 = timestart
-- 6 = honor
-- 7 = last
-- 8 = timmeroffset

od_avinfo = {};
-- 1 = Alterac Ram Hide/Frostwolf Hide
-- 2 = Armor Scraps 
-- 3 = Stormpike Blood/Storm Crystals
-- 4 = Stormpike Soldier's Flesh
-- 5 = Stormpike Lieutenant's Flesh
-- 6 = Stormpike Commander's Flesh
-- 7 = Wolf

od_badge = {};
-- 1 = AB
-- 2 = AV
-- 3 = WSG

od_ab[7] = '?';
od_av[7] = '?';
od_wsg[7] = '?';

OD_INFO = {};
od_saved = {};

local showallevents = 0;

function ODBGTools_OnLoad()
	-- Register our Events we want to watch
	---------------------------------------------------
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_DEAD"); 
	this:RegisterEvent("UPDATE_BATTLEFIELD_STATUS");
	this:RegisterEvent("CHAT_MSG_SYSTEM"); 
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL"); 
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE"); 
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE"); 
	this:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN"); 
	this:RegisterEvent("PLAYER_UNGHOST");
	this:RegisterEvent("UPDATE_WORLD_STATES");
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("BATTLEFIELDS_SHOW");

	this:RegisterEvent("GOSSIP_SHOW");

	this:RegisterEvent("QUEST_PROGRESS");
	this:RegisterEvent("QUEST_COMPLETE");

	this:RegisterEvent("QUEST_GREETING");
	this:RegisterEvent("QUEST_DETAIL");

	-- Register our slash command
	---------------------------------------------------
	SLASH_DURABILITYSTATUS1 = "/odbg";
	SlashCmdList["DURABILITYSTATUS"] = odbg_editconf;	
	
	-- Replace the onhide with ours
	---------------------------------------------------
	od_StaticPopup_OnHide = StaticPopup_OnHide;
	StaticPopup_OnHide = ODBGTools_StaticPopup_OnHide;

	DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..OD_SAY_V1.." "..od_version.." "..OD_SAY_V2, 1, 1, 0);

--	this:RegisterAllEvents();
	
end

function ODBGTools_OnEvent(event)

---------------------------------------
	if (event == "VARIABLES_LOADED") then
		player = UnitName("player").." - "..GetRealmName();
		if (not OD_INFO[player]) then
			OD_INFO[player] = {
				["showmini"] 	= 1;
				["autodrop"]	= 1;
				["bgtobg"]		= 0;
				["autorez"]		= 1;
				["autoleave"]	= 1;
				["time2drop"]	= 10;
				["side"]		= nil;
				["quickjoin"]	= 1;
				["quickquest"]	= 1;
				["WindowLock"]	= 0;
			}
		end;
		od_saved = OD_INFO[player];
		if (od_saved.showmini == nil) then od_saved.showmini = 1; end
		if (od_saved.autodrop == nil) then od_saved.autodrop = 1; end
		if (od_saved.bgtobg == nil) then od_saved.bgtobg = 0; end
		if (od_saved.autorez == nil) then od_saved.autorez = 1; end
		if (od_saved.autoleave == nil) then od_saved.autoleave = 1; end
		if (od_saved.time2drop == nil) then od_saved.time2drop = 15; end
		if (od_saved.side == nil) then od_saved.side = UnitFactionGroup("player"); end
		if (od_saved.quickjoin == nil) then od_saved.quickjoin = 1; end
		if (od_saved.quickquest == nil) then od_saved.quickquest = 1; end
		if (od_saved.WindowLock == nil) then od_saved.WindowLock = 0; end
		DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..OD_SAY_P.." ".. player, 1, 1, 0);
---------------------------------------
    elseif (event == "ADDON_LOADED") then
		odbg_badgecheck('all');
---------------------------------------
    elseif (event == "PLAYER_DEAD") then
		if (od_saved.autorez == 1) then
			local status;
			for i=1,MAX_BATTLEFIELD_QUEUES do
				status,_,_ = GetBattlefieldStatus(i);
				if(status == "active") then 
					break;
				end;
			end;
			if (status == "active") and (not HasSoulstone()) then
				RepopMe();
			end;
		end;
---------------------------------------
	elseif (event == "UPDATE_BATTLEFIELD_STATUS") then
		odbg_update();
		odbg_winupdate(0);
---------------------------------------
	elseif (event == "CHAT_MSG_SYSTEM") then
		if (string.find(arg1, OD_READ_BG1)) then
			odbg_winupdate(1);
		end;
		if (string.find(arg1, OD_READ_BG2)) then
			odbg_winupdate(-1);
		end;
----------------------------------------		
	elseif (event == "CHAT_MSG_BG_SYSTEM_NEUTRAL") then
		if (string.find(arg1, OD_READ_BG3)) then
			odbg_winupdate(0);
		end;
----------------------------------------		
	elseif (event == "CHAT_MSG_BG_SYSTEM_ALLIANCE") or (event == "CHAT_MSG_BG_SYSTEM_HORDE") then
		if (string.find(arg1, OD_READ_WSG1)) then
			od_hordeflag = string.sub(arg1,36);
			od_hordeflag = string.sub(od_hordeflag,1,string.len(od_hordeflag)-1);
		elseif (string.find(arg1, OD_READ_WSG2)) then
			od_hordeflag = '';
		elseif (string.find(arg1, OD_READ_WSG3)) then
			od_allianceflag = string.sub(arg1,33);
			od_allianceflag = string.sub(od_allianceflag,1,string.len(od_allianceflag)-1);
		elseif (string.find(arg1, OD_READ_WSG4)) then
			od_allianceflag = '';
		elseif (string.find(arg1, OD_READ_WSG5)) then
			od_hordeflag = '';
			od_allianceflag = '';
		end;
----------------------------------------		
	elseif (event == "BATTLEFIELDS_SHOW") then
		odbg_quickjoin();
----------------------------------------		
	elseif (event == "GOSSIP_SHOW") then
		odbg_GOSSIPWork();
----------------------------------------		
	elseif (event == "QUEST_PROGRESS") then
		odbg_QuestWork("PROGRESS");
----------------------------------------		
	elseif (event == "QUEST_COMPLETE") then
		odbg_QuestWork("COMPLETE");
----------------------------------------		
	elseif (event == "CHAT_MSG_COMBAT_HONOR_GAIN") then
		ODBGTools_honorupdate();
		if not (od_inbg) then
			odbg_badgecheck('all');
		end
----------------------------------------		
	elseif (event == "QUEST_GREETING") then
		odbg_QuestWork();
	elseif (event == "QUEST_DETAIL") then
		odbg_QuestWork();
---------------------------------------		
	elseif (event == "UPDATE_WORLD_STATES") or (event == "PLAYER_UNGHOST") then
		odbg_winupdate(0);
---------------------------------------		
	elseif (showallevents == 1) then
		if (arg1) then
			DEFAULT_CHAT_FRAME:AddMessage("DEBUG event: "..event.." ARG1 "..arg1);
		else
			DEFAULT_CHAT_FRAME:AddMessage("DEBUG event: "..event);
		end
	end
end;

function ODBGTools_cntpayers(cpadd)
	if not(od_inbg) or WorldStateScoreFrame:IsShown() then
		return
	end;
	local od_update;
	od_update = 0;
	SetBattlefieldScoreFaction(0);
	if (OD_hordecnt ~= GetNumBattlefieldScores()) then
		OD_hordecnt = GetNumBattlefieldScores();
		od_update = 1;
	end
	SetBattlefieldScoreFaction(1);
	if (od_alliancecnt ~= GetNumBattlefieldScores()) then
		od_alliancecnt = GetNumBattlefieldScores();
		od_update = 1;
	end
	if (cpadd ~= 0) then
		if (od_saved.side == OD_FACTION_2) then 
			od_alliancecnt = od_alliancecnt + cpadd;
		elseif (od_saved.side == OD_FACTION_1) then
			OD_hordecnt = OD_hordecnt + cpadd;
		end
		od_update = 1;
	end
	if (od_update == 1) then
		local green = GREEN_FONT_COLOR;
		local yellow = NORMAL_FONT_COLOR;
		local red = RED_FONT_COLOR;
		local colour1 = {};
		local colour2 = {};
		if (OD_hordecnt < od_alliancecnt and od_saved.side == OD_FACTION_1) or (OD_hordecnt > od_alliancecnt and od_saved.side == OD_FACTION_2) then
			colour1 = red;
			colour2 = green;
		elseif (OD_hordecnt > od_alliancecnt and od_saved.side == OD_FACTION_1) or (OD_hordecnt > od_alliancecnt and od_saved.side == OD_FACTION_2) then
			colour1 = green;
			colour2 = red;
		else
			colour1 = yellow;
			colour2 = yellow;
		end;
		if od_saved.side == OD_FACTION_1 then
			ODBGTools_Window_p1title:SetText("H");	
			ODBGTools_Window_p1info:SetText(OD_hordecnt);
			ODBGTools_Window_p1info:SetTextColor(colour1.r, colour1.g, colour1.b);
			ODBGTools_Window_p2title:SetText("A");
			ODBGTools_Window_p2info:SetText(od_alliancecnt);
			ODBGTools_Window_p2info:SetTextColor(colour2.r, colour2.g, colour2.b);
		else
			ODBGTools_Window_p1title:SetText("A");
			ODBGTools_Window_p1info:SetText(od_alliancecnt);
			ODBGTools_Window_p1info:SetTextColor(colour1.r, colour1.g, colour1.b);
			ODBGTools_Window_p2title:SetText("H");
			ODBGTools_Window_p2info:SetText(OD_hordecnt);
			ODBGTools_Window_p2info:SetTextColor(colour2.r, colour2.g, colour2.b);
		end		
	end
	SetBattlefieldScoreFaction(nil);
end

function ODBGTools_honorupdate()
	local htotal, junk
	junk,htotal = GetPVPThisWeekStats();
	if (hfsaved ~= nil) then
		junk = hfsaved.honor + hfsaved.honor_bonus;
		htotal = htotal + junk;
		ODBGTools_Window_honorday:SetText(junk);
		ODBGTools_Window_honorweek:SetText(htotal);
	else
		ODBGTools_Window_honorday:SetText("Honor");
		ODBGTools_Window_honorweek:SetText(htotal);
	end
end

function odbg_update()
	local status, map, honorhold;

	od_ab[1] = 'N';
	od_av[1] = 'N';
	od_wsg[1] = 'N';
	
	for i=1,MAX_BATTLEFIELD_QUEUES do
		status,map,_ = GetBattlefieldStatus(i);
		if string.find(map,OD_BG_1) then
			od_ab[1] = status;
			od_ab[2] = i;
			od_ab[3] = map;
		elseif string.find(map,OD_BG_2) then
			od_av[1] = status;
			od_av[2] = i;
			od_av[3] = map;
		elseif string.find(map,OD_BG_3) then
			od_wsg[1] = status;
			od_wsg[2] = i;
			od_wsg[3] = map;
		end;
	end;

-- AB Checks	
	if (od_ab[1] == "active") and (od_ab[1] ~= od_ab[7]) then
		od_ab[4] = "up";
		od_ab[5] = GetTime();
		if (hfsaved ~= nil) then
			od_ab[6] = hfsaved.honor + hfsaved.honor_bonus;
		else
			od_ab[6] = 0;
		end;
		od_ab[8] = GetBattlefieldInstanceRunTime()/1000;   
		ODBGTools_Window_abinfo:SetText("0:00");
		ODBGTools_Window_abinfo:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		odbg_newbg();
	elseif (od_ab[1] == "active") and (GetBattlefieldInstanceExpiration() ~= 0) then
		ODBGTools_Window_abinfo:SetText("");
		od_ab[4] = "pass";
		if (hfsaved ~= nil) then
			honorhold = (hfsaved.honor + hfsaved.honor_bonus) - od_ab[6];
		else
			honorhold = odbg_newhonor();
		end;
		odbg_leavebg(honorhold,math.floor(honorhold/((GetTime()-od_ab[5])/60)));
	elseif (od_ab[1] == "queued") and (od_ab[1] ~= od_ab[7]) then
		ODBGTools_Window_abinfo:SetText("que");
		od_ab[4] = "pass";
	elseif (od_ab[1] == "confirm") then
		if (od_ab[1] ~= od_ab[7])  then
			-- new confirm start timmer
			ODBGTools_Window_abinfo:SetText("2:00");
			od_ab[4] = "down";
			od_ab[5] = GetTime();
			od_ab[8] = 0;
			od_inconfirm = true;
			ODBGTools_Window:SetScript("OnUpdate",odbg_updatetimer)
		end;
		if (od_saved.autodrop == 1) then
			if (not(od_inbg) or (od_inbg and od_saved.bgtobg == 1)) then	
				odbg_auto(od_ab[3],od_ab[2]);
			else
				DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..OD_SAY_INFO_1, 1, 1, 0);
			end
		end
	end;
-- AV Checks	
	if (od_av[1] == "active") and (od_av[1] ~= od_av[7]) then
		odbg_inbg = true;
		od_av[4] = "up";
		od_av[5] = GetTime();
		if (hfsaved ~= nil) then
			od_av[6] = hfsaved.honor + hfsaved.honor_bonus;
		else
			od_av[6] = 0;
		end;
		od_av[8] = GetBattlefieldInstanceRunTime()/1000;   
		ODBGTools_Window_avinfo:SetText("0:00");
		ODBGTools_Window_avinfo:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		od_avinfo[7] = 'None';
		odbg_newbg();
	elseif (od_av[1] == "active") and (GetBattlefieldInstanceExpiration() ~= 0) then
		ODBGTools_Window_avinfo:SetText("");
		od_av[4] = "pass";
		if (hfsaved ~= nil) then
			honorhold = (hfsaved.honor + hfsaved.honor_bonus) - od_av[6];
		else
			honorhold = odbg_newhonor();
		end;
		odbg_leavebg(honorhold,math.floor(honorhold/((GetTime()-od_av[5])/60)));
	elseif (od_av[1] == "queued") and (od_av[1] ~= od_av[7]) then
		ODBGTools_Window_avinfo:SetText("que");
		od_av[4] = "pass";
	elseif (od_av[1] == "confirm") then
		if (od_av[1] ~= od_av[7])  then
			-- new confirm start timmer
			ODBGTools_Window_avinfo:SetText("2:00");
			od_av[4] = "down";
			od_av[5] = GetTime();
			od_av[8] = 0;
			od_inconfirm = true;
			ODBGTools_Window:SetScript("OnUpdate",odbg_updatetimer)
		end;
		if (od_saved.autodrop == 1) then
			if (not(od_inbg) or (od_inbg and od_saved.bgtobg == 1)) then	
				odbg_auto(od_av[3],od_av[2]);
			else
				DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..OD_SAY_INFO_1, 1, 1, 0);
			end
		end
	end;
-- WSG Checks	
	if (od_wsg[1] == "active") and (od_wsg[1] ~= od_wsg[7]) then
		odbg_inbg = true;
		od_wsg[4] = "up";
		od_wsg[5] = GetTime();
		if (hfsaved ~= nil) then
			od_wsg[6] = hfsaved.honor + hfsaved.honor_bonus;
		else
			od_wsg[6] = odbg_newhonor();
		end;
		od_wsg[8] = GetBattlefieldInstanceRunTime()/1000;   
		ODBGTools_Window_wsginfo:SetText("0:00");
		ODBGTools_Window_abinfo:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		odbg_newbg();
	elseif (od_wsg[1] == "active") and (GetBattlefieldInstanceExpiration() ~= 0) then
		ODBGTools_Window_wsginfo:SetText("");
		od_wsg[4] = "pass";
		if (hfsaved ~= nil) then
			honorhold = (hfsaved.honor + hfsaved.honor_bonus) - od_wsg[6];
		else
			honorhold = 0;
		end;
		odbg_leavebg(honorhold,math.floor(honorhold/((GetTime()-od_wsg[5])/60)));
	elseif (od_wsg[1] == "queued") and (od_wsg[1] ~= od_wsg[7]) then
		ODBGTools_Window_wsginfo:SetText("que");
		od_wsg[4] = "pass";
	elseif (od_wsg[1] == "confirm") then
		if (od_wsg[1] ~= od_wsg[7])  then
			-- new confirm start timmer
			ODBGTools_Window_wsginfo:SetText("2:00");
			od_wsg[4] = "down";
			od_wsg[5] = GetTime();
			od_wsg[8] = 0;
			od_inconfirm = true;
			ODBGTools_Window:SetScript("OnUpdate",odbg_updatetimer)
		end;
		if (od_saved.autodrop == 1) then
			if (not(od_inbg) or (od_inbg and od_saved.bgtobg == 1)) then	
				odbg_auto(od_wsg[3],od_wsg[2]);
			else
				DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..OD_SAY_INFO_1, 1, 1, 0);
			end
		end
	end;

	if (od_ab[1] ~= "confirm") and  (od_ab[7] == "confirm") then
		od_inconfirm = false;
	end;
	if (od_av[1] ~= "confirm") and  (od_av[7] == "confirm") then
		od_inconfirm = false;
	end;
	if (od_wsg[1] ~= "confirm") and  (od_wsg[7] == "confirm") then
		od_inconfirm = false;
	end;

	if (od_ab[1] == "confirm") or (od_av[1] ~= "confirm") or (od_wsg[7] == "confirm") then
		od_inconfirm = true;
	end;
		
	if (od_ab[1] == 'N') and (od_ab[7] ~= 'N')then 
		odbg_badgecheck('ab');
		od_ab[4] = "pass";
	end;
	if (od_av[1] == 'N') and (od_av[7] ~= 'N')then  
		odbg_badgecheck('av');
		od_av[4] = "pass";
	end;
	if (od_wsg[1] == 'N') and (od_wsg[7] ~= 'N')then 
		odbg_badgecheck('wsg');
		od_wsg[4] = "pass";
	end;

	od_ab[7] = od_ab[1];
	od_av[7] = od_av[1];
	od_wsg[7] = od_wsg[1];
	
end;

function odbg_newbg()
	od_inbg = true;
	OD_hordecnt = 0;
	OD_alliancecnt = 0;
	OD_BGCONFIRM = 0;
	OD_TOGGLE = 0;
	ODBGTools_Window:SetScript("OnUpdate",nil)
	DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..OD_SAY_INFO_2, 1, 1, 0);
	if (od_saved.showmini == 1) then
		ToggleBattlefieldMinimap();				
	end;
end;

function odbg_leavebg(lg_honor,lg_average)
	od_inbg = false;
	OD_hordecnt = 0;
	OD_alliancecnt = 0;
	ODBGTools_Window_p1title:SetText("");
	ODBGTools_Window_p1info:SetText("");
	ODBGTools_Window_p2title:SetText("");
	ODBGTools_Window_p2info:SetText("");
	DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..OD_SAY_INFO_4a.." "..lg_honor.." "..OD_SAY_INFO_4b.." "..lg_average.." "..OD_SAY_INFO_4c..".", 1, 1, 0);
	ODBGTools_honorupdate();
	if (od_saved.autoleave == 1) then
		DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..OD_SAY_INFO_3, 1, 1, 0);
		LeaveBattlefield();
	end;
end;

function odbg_auto(odbg_auto_name,odbg_auto_index)
	if (StaticPopup_Visible("CONFIRM_BATTLEFIELD_ENTRY")) then
		if (OD_BGCONFIRM == 0) then
			OD_BGCONFIRM = GetTime() + od_saved.time2drop;
			DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..OD_SAY_INFO_5a.." "..odbg_auto_name.." "..OD_SAY_INFO_5b.." "..od_saved.time2drop.." "..OD_SAY_INFO_5c.."...", 1, 1, 0);
		end
	end
end

function ODBGTools_StaticPopup_OnHide()
	od_StaticPopup_OnHide();
	if (this.which == "CONFIRM_BATTLEFIELD_ENTRY") and (OD_BGCONFIRM ~= 0) then
		OD_BGCONFIRM = 0;
		DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..OD_SAY_INFO_6, 1, 1, 0);
	end
end

function odbg_updatetimer()
	if od_inbg or od_inconfirm then
		local od_Now = GetTime();
		local od_Remaining, od_min, od_sec
-- AB	
		if (od_ab[4] == "up") then
			od_Remaining=math.floor((od_Now-od_ab[5])+od_ab[8]);
			od_min=math.floor(od_Remaining/60)
			od_sec=od_Remaining-od_min*60
			ODBGTools_Window_abinfo:SetText(string.format("%.0f:%02.0f",od_min,od_sec))
		elseif (od_ab[4] == "down") then
			od_Remaining=math.floor(120-(od_Now-od_ab[5]))+od_ab[8];
			if (od_Remaining < 0) then
				od_inconfirm = false;
				od_ab[4] = "pass";
				ODBGTools_Window_avinfo:SetText("")
				ODBGTools_Window_avinfo:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
			else
				od_min=math.floor(od_Remaining/60)
				od_sec=od_Remaining-od_min*60
				ODBGTools_Window_abinfo:SetText(string.format("%.0f:%02.0f",od_min,od_sec))
				if (od_Remaining < 30) then
					ODBGTools_Window_abinfo:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
				end;
				if (od_Now > OD_BGCONFIRM) and (OD_BGCONFIRM > 0) then
					ODBGTools_Window:SetScript("OnUpdate",nil)				
					od_inconfirm = false;
					OD_BGCONFIRM = 0;
					od_ab[4] = "pass";
					DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..OD_SAY_INFO_7a.." "..od_ab[3]..". "..OD_SAY_INFO_7b, 1, 1, 0);
					AcceptBattlefieldPort(od_ab[2],1)
					StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY");
				end;
			end;
		end;
-- AV
		if (od_av[4] == "up") then
			od_Remaining=math.floor((od_Now-od_av[5])+od_av[8]);
			od_min=math.floor(od_Remaining/60)
			od_sec=od_Remaining-od_min*60
			ODBGTools_Window_avinfo:SetText(string.format("%.0f:%02.0f",od_min,od_sec))
		elseif (od_av[4] == "down") then
			od_Remaining=math.floor(120-(od_Now-od_av[5]))+od_av[8];
			if (od_Remaining < 0) then
				od_inconfirm = false;
				od_av[4] = "pass";
				ODBGTools_Window_avinfo:SetText("")
				ODBGTools_Window_avinfo:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
			else
				od_min=math.floor(od_Remaining/60)
				od_sec=od_Remaining-od_min*60
				ODBGTools_Window_avinfo:SetText(string.format("%.0f:%02.0f",od_min,od_sec))
				if (od_Remaining < 30) then
					ODBGTools_Window_avinfo:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
				end;
				if (od_Now > OD_BGCONFIRM) and (OD_BGCONFIRM > 0) then
					ODBGTools_Window:SetScript("OnUpdate",nil)				
					od_inconfirm = false;
					OD_BGCONFIRM = 0;
					od_av[4] = "pass";
					DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..OD_SAY_INFO_7a.." "..od_av[3]..". "..OD_SAY_INFO_7b, 1, 1, 0);
					AcceptBattlefieldPort(od_av[2],1)
					StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY");
				end;
			end;
		end;
-- WSG
		if (od_wsg[4] == "up") then
			od_Remaining=math.floor(od_Now-od_wsg[5]+od_wsg[8]);
			od_min=math.floor(od_Remaining/60)
			od_sec=od_Remaining-od_min*60
			ODBGTools_Window_wsginfo:SetText(string.format("%.0f:%02.0f",od_min,od_sec))
		elseif (od_wsg[4] == "down") then
			od_Remaining=math.floor(120-(od_Now-od_wsg[5])+od_wsg[8]);
			if (od_Remaining < 0) then
				od_inconfirm = false;
				od_wsg[4] = "pass";
				ODBGTools_Window_avinfo:SetText("")
				ODBGTools_Window_avinfo:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
			else
				od_min=math.floor(od_Remaining/60)
				od_sec=od_Remaining-od_min*60
				if (od_Remaining < 0) then
					od_Remaining = 0;
				end;
				ODBGTools_Window_wsginfo:SetText(string.format("%.0f:%02.0f",od_min,od_sec))
				if (od_Remaining < 30) then
					ODBGTools_Window_wsginfo:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
				end;
				if (od_Now > OD_BGCONFIRM) and (OD_BGCONFIRM > 0) then
					ODBGTools_Window:SetScript("OnUpdate",nil)				
					od_inconfirm = false;
					OD_BGCONFIRM = 0;
					od_wsg[4] = "pass";
					DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..OD_SAY_INFO_7a.." "..od_wsg[3]..". "..OD_SAY_INFO_7b, 1, 1, 0);
					AcceptBattlefieldPort(od_wsg[2],1)
					StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY");
				end;
			end;
		end;
	else
		ODBGTools_Window:SetScript("OnUpdate",nil)				
	end;
end;
	
function odbg_winupdate(wpadd)
	RequestBattlefieldScoreData();
	odbg_updatetimer();
	ODBGTools_cntpayers(wpadd);
	if (hfsaved ~= nil) then
		ODBGTools_honorupdate();
	end
end

function odbg_newhonor()
	local nh_name, nh_value, i, rnt_value
	rnt_value = 0;
	SetBattlefieldScoreFaction();
	for i=1,GetNumBattlefieldScores() do
		nh_name, _, _, _, nh_value, _, _, _, _= GetBattlefieldScore(i);
		if (nh_name == UnitName("player")) then
			rnt_value = nh_value;
			break;
		end
	end;
	return rnt_value
end;

function odbg_honorclick()
	if (arg1 == "RightButton") and (od_inbg) then
		odbg_honorcheck();
	elseif (arg1 == "LeftButton") then
		if CharacterFrame:IsShown() then
			ToggleCharacter("PaperDollFrame");
			CharacterFrame:Hide();
		else
			CharacterFrame:Show();
			ToggleCharacter("HonorFrame");
		end;
		if (hfsaved ~= nil) then
			ODBGTools_honorupdate();
		end
	elseif (arg1 == "RightButton") then
		odbg_editconf();
	end;
end;

function odbg_abclick()
	if od_ab[1] == "confirm" and (arg1 == "LeftButton") then
		ODBGTools_Window:SetScript("OnUpdate",nil)				
		od_inconfirm = false;
		OD_BGCONFIRM = 0;
		od_wsg[4] = "pass";
		DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..OD_SAY_INFO_7a.." "..od_ab[3]..". "..OD_SAY_INFO_7b, 1, 1, 0);
		AcceptBattlefieldPort(od_ab[2],1)
		StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY");
	elseif od_ab[1] == "active" and (arg1 == "LeftButton") then
		SendChatMessage(string.format("%s %s!",OD_SAY_INFO_9,GetMinimapZoneText()),"BATTLEGROUND")
	elseif (arg1 == "LeftButton") then
		odbg_badgecheck('all');
	elseif (arg1 == "RightButton") then
		odbg_editconf();
	end;
end;

function odbg_avclick()
	if od_av[1] == "confirm" and (arg1 == "LeftButton") then
		ODBGTools_Window:SetScript("OnUpdate",nil)				
		od_inconfirm = false;
		OD_BGCONFIRM = 0;
		od_av[4] = "pass";
		DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..OD_SAY_INFO_7a.." "..od_av[3]..". "..OD_SAY_INFO_7b, 1, 1, 0);
		AcceptBattlefieldPort(od_av[2],1)
		StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY");
	elseif (od_av[1] == "active") and (arg1 == "LeftButton") then
		odbg_avcheck();
	elseif (od_av[1] == "active") and (arg1 == "RightButton") then
		ODBGTools_WindowAV:Hide();
	elseif (arg1 == "LeftButton") then
		odbg_badgecheck('all');
	elseif (arg1 == "RightButton") then
		odbg_avcheck();
--~ 		odbg_editconf();
	end;
end;

function odbg_wsgclick()
	if od_wsg[1] == "confirm" and (arg1 == "LeftButton") then
		ODBGTools_Window:SetScript("OnUpdate",nil)				
		od_inconfirm = false;
		OD_BGCONFIRM = 0;
		od_wsg[4] = "pass";
		DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..OD_SAY_INFO_7a.." "..od_wsg[3]..". "..OD_SAY_INFO_7b, 1, 1, 0);
		AcceptBattlefieldPort(od_wsg[2],1)
		StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY");
	elseif od_wsg[1] == "active" then
		if (od_saved.side == OD_FACTION_1 and od_hordeflag ~= "" and arg1 == "LeftButton") or (od_saved.side == OD_FACTION_2 and od_hordeflag ~= "" and arg1 == "RightButton") then
			TargetByName(od_hordeflag);
		elseif (od_saved.side == OD_FACTION_2 and od_allianceflag ~= "" and arg1 == "LeftButton") or (od_saved.side == OD_FACTION_1 and od_allianceflag ~= "" and arg1 == "RightButton") then
			TargetByName(od_allianceflag);
		end;
	elseif (arg1 == "LeftButton") then
		odbg_badgecheck('all');
	elseif (arg1 == "RightButton") then
		odbg_editconf();
	end;
end;

function odbg_pclick()
	if (arg1 == "LeftButton") and (od_inbg) then
		ODBGTools_cntpayers(0);
	elseif (arg1 == "RightButton") and (od_inbg) then
		ODBGTools_cntpayers(0);
		if od_saved.side == OD_FACTION_1 then
			SendChatMessage(string.format(OD_SAY_INFO_8a,OD_hordecnt,od_alliancecnt),"SAY")
		else
			SendChatMessage(string.format(OD_SAY_INFO_8b,od_alliancecnt,OD_hordecnt),"SAY")
		end		
	elseif (arg1 == "RightButton") then
		odbg_editconf();
	end;
end;

function odbg_editconf()
	if (od_saved.showmini == 1) then ODBGTools_WindowConf_showmini:SetChecked(true); end
	if (od_saved.autodrop == 1) then ODBGTools_WindowConf_autodrop:SetChecked(true); end
	if (od_saved.bgtobg == 1) then ODBGTools_WindowConf_bgtobg:SetChecked(true); end
	if (od_saved.autorez == 1) then ODBGTools_WindowConf_autorez:SetChecked(true); end
	if (od_saved.autoleave == 1) then ODBGTools_WindowConf_autoleave:SetChecked(true); end
	if (od_saved.quickjoin == 1) then ODBGTools_WindowConf_QuickJoin:SetChecked(true); end
	if (od_saved.quickquest == 1) then ODBGTools_WindowConf_QuickQuest:SetChecked(true); end
	if (od_saved.WindowLock == 1) then ODBGTools_WindowConf_WindowLock:SetChecked(true); end
	ODBGTools_WindowConf_time2drop:SetText(od_saved.time2drop);
	ODBGTools_WindowConf:Show()
end;

function odbg_saveconf()
	if ODBGTools_WindowConf_showmini:GetChecked() then
		od_saved.showmini = 1;
	else
		od_saved.showmini = 0;
	end
	if ODBGTools_WindowConf_autodrop:GetChecked() then
		od_saved.autodrop = 1;
	else
		od_saved.autodrop = 0;
	end
	if ODBGTools_WindowConf_bgtobg:GetChecked() then
		od_saved.bgtobg = 1;
	else
		od_saved.bgtobg = 0;
	end
	if ODBGTools_WindowConf_autorez:GetChecked() then
		od_saved.autorez = 1;
	else
		od_saved.autorez = 0;
	end
	if ODBGTools_WindowConf_autoleave:GetChecked() then
		od_saved.autoleave = 1;
	else
		od_saved.autoleave = 0;
	end
	if ODBGTools_WindowConf_QuickJoin:GetChecked() then
		od_saved.quickjoin = 1;
	else
		od_saved.quickjoin = 0;
	end
	if ODBGTools_WindowConf_QuickQuest:GetChecked() then
		od_saved.quickquest = 1;
	else
		od_saved.quickquest = 0;
	end
	if ODBGTools_WindowConf_WindowLock:GetChecked() then
		od_saved.WindowLock = 1;
	else
		od_saved.WindowLock = 0;
	end
	od_saved.time2drop = tonumber(ODBGTools_WindowConf_time2drop:GetText());
	ODBGTools_WindowConf:Hide();
end;

function odbg_badgecheck(odbg_mode)
	local bag,slot,name,nameStr,textureName, itemCount;
	od_badge[1] = 0;
	od_badge[2] = 0;
	od_badge[3] = 0;
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			textureName, itemCount, _, _, _= GetContainerItemInfo(bag, slot);
			if ( textureName ) then
				name = GetContainerItemLink(bag, slot);
				for nameStr in string.gfind(name, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
					name = nameStr;
					break;
				end
				if (name == OD_READ_INV_1) then
					od_badge[1] = od_badge[1] + itemCount;
				elseif (name == OD_READ_INV_2) then
					od_badge[2] = od_badge[2] + itemCount;
				elseif (name == OD_READ_INV_3) then
					od_badge[3] = od_badge[3] + itemCount;
				end;
			end;
		end
	end
	if ((odbg_mode == 'all') or (odbg_mode == 'ab')) and (od_ab[1] ~= "queued") then
		ODBGTools_Window_abinfo:SetText('['..od_badge[1]..']')
		ODBGTools_Window_abinfo:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end;
	if ((odbg_mode == 'all') or (odbg_mode == 'av')) and (od_av[1] ~= "queued") then
		ODBGTools_Window_avinfo:SetText('['..od_badge[2]..']')
		ODBGTools_Window_avinfo:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end;
	if ((odbg_mode == 'all') or (odbg_mode == 'wsg')) and (od_wsg[1] ~= "queued") then
		ODBGTools_Window_wsginfo:SetText('['..od_badge[3]..']')
		ODBGTools_Window_wsginfo:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end;
end;

function odbg_avcount()
	local bag,slot,name,nameStr, i, textureName, itemCount;

	for i = 1, 6 do
		od_avinfo[i] = 0;
	end;

	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			textureName, itemCount, _, _, _= GetContainerItemInfo(bag, slot);
			if ( textureName ) then
				name = GetContainerItemLink(bag, slot);
				for nameStr in string.gfind(name, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
					name = nameStr;
					break;
				end
				if (name == OD_READ_INV_4a and od_saved.side == OD_FACTION_1) or (name == OD_READ_INV_4b and od_saved.side ~= OD_FACTION_1) then
					od_avinfo[1] = od_avinfo[1] + itemCount;
				elseif (name == OD_READ_INV_5) then
					od_avinfo[2] = od_avinfo[2] + itemCount;
				elseif (name == OD_READ_INV_6a) or (name == OD_READ_INV_6b) then
					od_avinfo[3] = od_avinfo[3] + itemCount;
				elseif (name == OD_READ_INV_7a) or (name == OD_READ_INV_7b) then
					od_avinfo[4] = od_avinfo[4] + itemCount;
				elseif (name == OD_READ_INV_8a) or (name == OD_READ_INV_8b) then
					od_avinfo[5] = od_avinfo[5] + itemCount;
				elseif (name == OD_READ_INV_9a) or (name == OD_READ_INV_9b) then
					od_avinfo[6] = od_avinfo[6] + itemCount;
				end;
			end;
		end
	end
end;

function odbg_avcheck()
	odbg_avcount();
	if (od_saved.side == OD_FACTION_1) then 
		ODBGTools_WindowAV_Ram_text:SetText(od_avinfo[1]..' '..OD_READ_INV_4a);
		ODBGTools_WindowAV_Armor_text:SetText(od_avinfo[2]..' '..OD_READ_INV_5);
		ODBGTools_WindowAV_Blood_text:SetText(od_avinfo[3]..' '..OD_READ_INV_6a);
		ODBGTools_WindowAV_Blood_Pic:SetTexture("Interface\\Icons\\INV_Potion_50");
		ODBGTools_WindowAV_Flesh1_text:SetText(od_avinfo[4]..' '..OD_READ_INV_7a);
		ODBGTools_WindowAV_Flesh1_Pic:SetTexture("Interface\\Icons\\INV_Misc_Food_52");
		ODBGTools_WindowAV_Flesh2_text:SetText(od_avinfo[5]..' '..OD_READ_INV_8a);
		ODBGTools_WindowAV_Flesh2_Pic:SetTexture("Interface\\Icons\\INV_Misc_Food_72");
		ODBGTools_WindowAV_Flesh3_text:SetText(od_avinfo[6]..' '..OD_READ_INV_9a);
		ODBGTools_WindowAV_Flesh3_Pic:SetTexture("Interface\\Icons\\INV_Misc_Food_69");
	else
		ODBGTools_WindowAV_Ram_text:SetText(od_avinfo[1]..' '..OD_READ_INV_4b);
		ODBGTools_WindowAV_Armor_text:SetText(od_avinfo[2]..' '..OD_READ_INV_5);
		ODBGTools_WindowAV_Blood_text:SetText(od_avinfo[3]..' '..OD_READ_INV_6b);
		ODBGTools_WindowAV_Blood_Pic:SetTexture("Interface\\Icons\\INV_Misc_Gem_Pearl_06");
		ODBGTools_WindowAV_Flesh1_text:SetText(od_avinfo[4]..' '..OD_READ_INV_7b);
		ODBGTools_WindowAV_Flesh1_Pic:SetTexture("Interface\\Icons\\INV_Jewelry_Talisman_06");
		ODBGTools_WindowAV_Flesh2_text:SetText(od_avinfo[5]..' '..OD_READ_INV_8b);
		ODBGTools_WindowAV_Flesh2_Pic:SetTexture("Interface\\Icons\\INV_Jewelry_Talisman_04");
		ODBGTools_WindowAV_Flesh3_text:SetText(od_avinfo[6]..' '..OD_READ_INV_9b);
		ODBGTools_WindowAV_Flesh3_Pic:SetTexture("Interface\\Icons\\INV_Jewelry_Talisman_12");
	end

	if (od_avinfo[1] < 1) then
		ODBGTools_WindowAV_Ram_text:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
	else
		ODBGTools_WindowAV_Ram_text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end;
	if (od_avinfo[2] < 20) then
		ODBGTools_WindowAV_Armor_text:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
	else
		ODBGTools_WindowAV_Armor_text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end;
	if (od_avinfo[3] < 1) then
		ODBGTools_WindowAV_Blood_text:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
	else
		ODBGTools_WindowAV_Blood_text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end;
	if (od_avinfo[4] < 1) then
		ODBGTools_WindowAV_Flesh1_text:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
	else
		ODBGTools_WindowAV_Flesh1_text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end;
	if (od_avinfo[5] < 1) then
		ODBGTools_WindowAV_Flesh2_text:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
	else
		ODBGTools_WindowAV_Flesh2_text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end;
	if (od_avinfo[6] < 1) then
		ODBGTools_WindowAV_Flesh3_text:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
	else
		ODBGTools_WindowAV_Flesh3_text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end;
	ODBGTools_WindowAV:Show();
end;
	
function odbg_quickjoin()
	if (od_saved.quickjoin == 1) then
		local name = GetBattlefieldInfo();
		for i=1, MAX_BATTLEFIELD_QUEUES do
			local _, map = GetBattlefieldStatus( i );
			if( map == name ) then
				return;
			end
		end
		JoinBattlefield(0);
		BattlefieldFrame:Hide();
	end;
end;

function odbg_GOSSIPWork()
	if (od_saved.quickjoin == 1) then
		local gossipText = getglobal( "GossipTitleButton1" );
		if (gossipText) and (gossipText:GetText() == OD_READ_Q_1) then
			gossipText:Click();
			return;
		end
	end;
	if (od_saved.quickquest == 1) then
		if (UnitName("target") == OD_READ_QP_1a) or (UnitName("target") == OD_READ_QP_1b) then
			odbg_badgecheck();
			local gossipText = getglobal( "GossipTitleButton1" );
			if (gossipText) and ((gossipText:GetText() == OD_READ_Q_2a) or (gossipText:GetText() == OD_READ_Q_2b)) then
				if ((od_badge[1] > 2) and (od_badge[2] > 2) and (od_badge[3] > 2)) then
					gossipText:Click();
				else
					gossipText:Hide();
				end
			end
		elseif (UnitName("target") == OD_READ_QP_3a) or (UnitName("target") == OD_READ_QP_3b) then
			odbg_avcount();
			local gossipText = getglobal( "GossipTitleButton3" );
			if (gossipText) and ((gossipText:GetText() == OD_READ_Q_12)) then
				gossipText:Click();
			else
				local gossipText = getglobal( "GossipTitleButton1" );
				if (gossipText) and ((gossipText:GetText() == OD_READ_Q_3a) or (gossipText:GetText() == OD_READ_Q_3b) or (gossipText:GetText() == OD_READ_Q_3c) or (gossipText:GetText() == OD_READ_Q_3d)) then
					if (od_avinfo[2] > 20) then
						gossipText:Click();
					else
						gossipText:Hide();
					end
				end
			end
		elseif (UnitName("target") == OD_READ_QP_2a) or (UnitName("target") == OD_READ_QP_2b) then
			odbg_avcount();
			local gossipText = getglobal( "GossipTitleButton2" );
			if (gossipText) and ((gossipText:GetText() == OD_READ_Q_4a) or (gossipText:GetText() == OD_READ_Q_4b)) then
				if (od_avinfo[3] > 4) then
					gossipText:Click();
				else
					gossipText:Hide();
				end
			end;
			local gossipText = getglobal( "GossipTitleButton1" );
			if (gossipText) and ((gossipText:GetText() == OD_READ_Q_5a) or (gossipText:GetText() == OD_READ_Q_5b)) then
				if (od_avinfo[3] > 0) then
					gossipText:Click();
				else
					gossipText:Hide();
				end
			end
		elseif (UnitName("target") == OD_READ_QP_4a) or (UnitName("target") == OD_READ_QP_4b) then
			odbg_avcount();
			local gossipText = getglobal( "GossipTitleButton1" );
			if (gossipText) and ((gossipText:GetText() == OD_READ_Q_6a) or (gossipText:GetText() == OD_READ_Q_6b)) then
				if (od_avinfo[1] > 0) then
					gossipText:Click();
				else
					gossipText:Hide();
				end
			end
		elseif (UnitName("target") == OD_READ_QP_5a) or (UnitName("target") == OD_READ_QP_5b) then
			if (od_avinfo[7] == 'None') or (od_avinfo[7] == 'Step 2') then 
				local gossipText = getglobal( "GossipTitleButton1" );
				if (gossipText) and ((gossipText:GetText() == OD_READ_Q_7)) then
					gossipText:Click();
				end
			else
				local gossipText = getglobal( "GossipTitleButton3" );
				if (gossipText) and (gossipText:GetText() == OD_READ_Q_8) then
					gossipText:Click();
					od_avinfo[7] = 'Step 2';
				end
			end
		elseif (UnitName("target") == OD_READ_QP_6a) or (UnitName("target") == OD_READ_QP_6b) then
			local gossipText = getglobal( "GossipTitleButton1" );
			if (gossipText) and ((gossipText:GetText() == OD_READ_Q_9a) or (gossipText:GetText() == OD_READ_Q_9b)) then
				gossipText:Click();
			end
		elseif (UnitName("target") == OD_READ_QP_7a) or (UnitName("target") == OD_READ_QP_7b) then
			local gossipText = getglobal( "GossipTitleButton1" );
			if (gossipText) and ((gossipText:GetText() == OD_READ_Q_10a) or (gossipText:GetText() == OD_READ_Q_10b)) then
				gossipText:Click();
			end
		elseif (UnitName("target") == OD_READ_QP_8a) or (UnitName("target") == OD_READ_QP_8b) then
			local gossipText = getglobal( "GossipTitleButton1" );
			if (gossipText) and ((gossipText:GetText() == OD_READ_Q_11a) or (gossipText:GetText() == OD_READ_Q_11b)) then
				gossipText:Click();
			end
		end
	end
end;

function odbg_QuestWork(q_mode)
	if (od_saved.quickquest == 1) then
		if	(UnitName("target") == OD_READ_QP_1a) or (UnitName("target") == OD_READ_QP_1b) or
			(UnitName("target") == OD_READ_QP_2a) or (UnitName("target") == OD_READ_QP_2b) or
			(UnitName("target") == OD_READ_QP_3a) or (UnitName("target") == OD_READ_QP_3b) or
			(UnitName("target") == OD_READ_QP_4a) or (UnitName("target") == OD_READ_QP_4b) then
			if (q_mode == "PROGRESS") then
				CompleteQuest();
			else
				QuestRewardCompleteButton_OnClick();
			end
		elseif ((UnitName("target") == OD_READ_QP_5a) or (UnitName("target") == OD_READ_QP_5b)) then
			if (od_avinfo[7] == 'None') then
				AcceptQuest();
				od_avinfo[7] = 'Step 1';
			else
				QuestRewardCompleteButton_OnClick();
				od_avinfo[7] = 'None';
			end;
		elseif (od_av[1] == "active") then
			if ((UnitName("target") == OD_READ_QP_6a) or (UnitName("target") == OD_READ_QP_6a)) then
				AcceptQuest();
				CompleteQuest();
				QuestRewardCompleteButton_OnClick();
			elseif ((UnitName("target") == OD_READ_QP_7a) or (UnitName("target") == OD_READ_QP_7b)) then
				AcceptQuest();
				CompleteQuest();
				QuestRewardCompleteButton_OnClick();
			elseif ((UnitName("target") == OD_READ_QP_8a) or (UnitName("target") == OD_READ_QP_8b)) then
				AcceptQuest();
				CompleteQuest();
				QuestRewardCompleteButton_OnClick();
			end
		end
	end
end

function odbg_debug()
	if showallevents == 0 then
		showallevents = 1;
	else
		showallevents = 0
	end
end

function odbg_honorcheck(tp_mode)
	local honorhold,junk
	if (hfsaved ~= nil) then
		if (od_ab[1] == "active") then
			honorhold = (hfsaved.honor + hfsaved.honor_bonus) - od_ab[6];
			if (honorhold == 0) then
				junk = 0;
			else
				junk = math.floor(honorhold/((GetTime()-od_ab[5])/60))
			end;
			DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..honorhold.." "..OD_SAY_INFO_4b.." "..junk.." "..OD_SAY_INFO_4c..".", 1, 1, 0);
		elseif (od_av[1] == "active") then
			honorhold = (hfsaved.honor + hfsaved.honor_bonus) - od_av[6];
			if (honorhold == 0) then
				junk = 0;
			else
				junk = math.floor(honorhold/((GetTime()-od_av[5])/60))
			end
			DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..honorhold.." "..OD_SAY_INFO_4b.." "..junk.." "..OD_SAY_INFO_4c..".", 1, 1, 0);
		elseif (od_wsg[1] == "active")  then
			honorhold = (hfsaved.honor + hfsaved.honor_bonus) - od_wsg[6];
			if (honorhold == 0) then
				junk = 0;
			else
				junk = math.floor(honorhold/((GetTime()-od_wsg[5])/60))
			end;
			DEFAULT_CHAT_FRAME:AddMessage("ODBGTOOLS: "..honorhold.." "..OD_SAY_INFO_4b.." "..junk.." "..OD_SAY_INFO_4c..".", 1, 1, 0);
		end;
	end
end

function odbg_qloot()
	local button, index
	for index = 1, LOOTFRAME_NUMBUTTONS, 1 do
		local button = getglobal("LootButton"..index);
		if( button:IsVisible() ) then
			DEFAULT_CHAT_FRAME:AddMessage("DEBUG: "..index,1,1,1)
			lootIcon, lootName, lootQuantity, rarity = GetLootSlotInfo(index);
			DEFAULT_CHAT_FRAME:AddMessage("DEBUG: "..button.rollID,1,1,1)
			DEFAULT_CHAT_FRAME:AddMessage("DEBUG: "..lootName,1,1,1)

			local iteminfo = GetLootSlotLink(index);
			DEFAULT_CHAT_FRAME:AddMessage("DEBUG: "..iteminfo,1,1,1)
			ChatFrameEditBox:Insert(iteminfo);
			LootFrameItem_OnClick(button)
--~ 			button:Click() 
		end
	end;
end;

function odbg_ginfo()
	for index = 1, 10, 1 do
		local gossipText = getglobal( "GossipTitleButton"..index);
		if (gossipText) then
			message(index);
			message(gossipText:GetText());
		end
	end
end