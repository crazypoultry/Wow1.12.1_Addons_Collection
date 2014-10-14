-- BGAssist
-- Copyright 2005, 2006 original author.
-- Copyright is expressly not transferred to Blizzard.
--
-- Battleground helper functionality
--
--  Author: Marc aka Saien on Hyjal
--  WoWSaien@gmail.com
--  http://64.168.251.69/wow
--  continues by Loki aka Lokimur on Lothar (EU)
--
--  Changes:
--  2006.09.19b
--	fixed dependencies bug
--	disable AB timer should work now
--  2006.09.17
--    fixed 1.12 WS-Flag Status
--    integrated ABTimeLeft by Avalanche
--    shout to raid, if you will win or loose in arathi
--    integrated ace2 functions
--    removed BG Group join/leave
--  2006.07.18
--    automatic reset when changing zone/area
--    fixed key binding bug
--    changed WS flag carrier detect
--    requested auto open minimap in BG
--    changed position reset command to "/bga center"
--  2006.07.13
--    added option "/bga reset" to reset status and position
--    fixed debug function
--  2006.07.09
--    set timer labes to GameFontSmall
--    added visible counter für item icons
--  2006.07.08
--    Updated to 1.11 TOC
--    Added slash command /bga
--    fixed german localization
--  2006.01.03
--    Updated to 1.9 TOC
--    Updated to supported multiple BG Queues.
--    Auto Join will not auto join if you're already in another BG.
--    AFK works like this: When you zone in to a BG, you lose your AFK but
--      are almost immediately reflagged. This zones you out, losing your space
--      in the queue. This is verified as of 1.9. Due to this, Autojoin will
--      once again not join when AFK.
--  2005.10.10
--    Due to Blizzard changes, Autojoin will again join when you're AFK.
--    Autorez in BG option removed as it has been implemented by Blizzard
--  2005.09.13
--    TOC change to 1700 and adjust to 1.7 changes
--    Arathi Basin timers work.
--    Timers have been changed to match the mainmap colors. Timer will show the color
--      of the attacking faction. This is opposite previous versions.
--    To avoid group-bug problems, Autoleave group leaves the group at the win/loss screen.
--      If you /afk out it will still leave the group after you zone.
--    WSG/AB: Config option to not autojoin instances that exist at the time you queue up.
--  2005.09.03
--    Will no longer popup an error when more than 10 targets are to be displayed on target list
--    Target list will show/hide when checking/unchecking the config option immediately,
--      not just when you zone.
--  2005.08.24
--    Alliance sites being captured now are cyan in the timer. Dark blue just too hard to see.
--    Timer countdowns will now only show the first word of the name.
--    Fixed bug causing error popup in AV.
--    Option to autoaccept group invites when in a BG
--    Option to autoleave your group when leaving BG
--    Will not auto enter BG when dead or ghost.
--    Fixed Slidore's quest name -again-. Hey, I'm horde and can't test it
--  2005.08.13
--    Class breakdown on score window.
--    Targetting assistance window. See web.
--    Fixed typo in Sildore's quest name.
--    Warsong Gulch: Flag carrier named onscreen now. Needs translations for
--       filthy foreigners to work.
--    German updates, though quests need more work for autocomplete. Frogs are mostly done now, except for new stuff.
--  2005.07.19
--    Will not autoenter if you're AFK
--    French localization partially in place. Still requires update, German is
--      completly undone. Note that quest turnins will not work unless setup for
--      your language properly. As I speak neither language (and proud of it) this
--      is all on your shoulders, not mine.
--    Rez timer in place. Might not be entirely accurate (based on your network lag)
--      and won't start counting down until you die once after zoning in.
--    Checkmark for not showing the window at zonein was being set backwards.
--  2007.07.15-2
--    Unnecessary zone restriction on autorez removed (aka Should work in Gulch now)
--  2005.07.15
--    Auto release in BG
--    Keybinding to toggle window on or off regardless of in BG or not
--    Config option to not turn window on when entering BG
--    Player per faction counts are unncessary now.
--

BGASSIST_VERSION = "2006.09.19beta";
BINDING_HEADER_BGASSIST_SEP = "BGAssist";

local BGA_debug = false;
local Glory   = AceLibrary("Glory-2.0")

-- Is stolen from Interface/GlueXML/CharacterCreate.lua
local CLASS_ICON_TCOORDS = {
	[string.upper(CLASS_WARRIOR)]	= {0, 0.25, 0, 0.25},
	[string.upper(CLASS_MAGE)]	= {0.25, 0.49609375, 0, 0.25},
	[string.upper(CLASS_ROGUE)]	= {0.49609375, 0.7421875, 0, 0.25},
	[string.upper(CLASS_DRUID)]	= {0.7421875, 0.98828125, 0, 0.25},
	[string.upper(CLASS_HUNTER)]	= {0, 0.25, 0.25, 0.5},
	[string.upper(CLASS_PRIEST)]	= {0.49609375, 0.7421875, 0.25, 0.5},
	[string.upper(CLASS_WARLOCK)]	= {0.7421875, 0.98828125, 0.25, 0.5},
	[string.upper(CLASS_SHAMAN)]	= {0.25, 0.49609375, 0.25, 0.5},
	[string.upper(CLASS_PALADIN)]	= {0, 0.25, 0.5, 0.75}
};

local BATTLEFIELD_INDEXES = {
	[1] = ALTERACVALLEY;
	[2] = WARSONGGULCH;
	[3] = ARATHIBASIN;
};

local MAXTIMERS = 6;
local MAXICONS = 10;
local EVENTSINBATTLEGROUND = {
	-- Bag item tracking
	"BAG_UPDATE",
	-- Track into quest windows for autocomplete
	"QUEST_PROGRESS",
	"QUEST_COMPLETE",
	"QUEST_GREETING",
	"QUEST_DETAIL",
	-- "GOSSIP_SHOW",
	-- Autorez
	"AREA_SPIRIT_HEALER_IN_RANGE",
	-- People counting
	"UPDATE_BATTLEFIELD_SCORE",
	-- Chat messages
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL",
	"CHAT_MSG_BG_SYSTEM_ALLIANCE",
	"CHAT_MSG_BG_SYSTEM_HORDE",
	-- Warsaw flag tracking
	"UPDATE_WORLD_STATES",
	-- PARTAHHHH
	"PARTY_MEMBERS_CHANGED",
	"PARTY_LEADER_CHANGED",
	-- Well duh
	"PLAYER_DEAD",
};

BGAssist_Player = nil; -- global;
local BGAssist_Config_Loaded = nil;
local BGAssist_CountedPlayers = nil;
local BGAssist_Scheduled_MapCheck = nil;
local BGAssist_InBattleGround = nil;
local BGAssist_TimersActive = nil;
local BGAssist_LastTimersProc = 0;
local BGAssist_MapItems = {};
local BGAssist_TrackedItems = {};
local BGAssist_ItemInfo = {};
local BGAssist_RezSyncTime = nil;
local BGAssist_LastUpdate = 0;
local BGAssist_MaintainingGroup = nil;
local BGAssist_PreExistingInstances = nil;
local BGAssist_InAFK = nil;

-- ABtimeleft variables
local insideAB = false;		-- if player is in a game of Arathi Basin
local timeLeft = { -1, -1 };	-- the time left, in seconds, until this team wins
local lastBases = { -1, -1 };	-- the bases that this team had last update
local lastRes = { -1, -1 };	-- the resources that this team had last update
local selfFaction = UnitFactionGroup("player");


function BGAssist_ConfigInit()
	if (not BGAssist_Config) then
		BGAssist_Config = {};
	end
	if (not BGAssist_Config[BGAssist_Player]) then
		BGAssist_Config[BGAssist_Player] = {};
	end
	if (not BGAssist_Config[BGAssist_Player].turnins) then
		BGAssist_Config[BGAssist_Player].turnins = {};
	end

	if (BGAssist_InBattleGround == ALTERACVALLEY or BGAssist_InBattleGround == ARATHIBASIN) then
		BGAssist_CheckMap();
	end
	BGAssist_ToggleAutoEntry("ON")
end

function BGAssist_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	-- Autoenter
	this:RegisterEvent("BATTLEFIELDS_SHOW");
	this:RegisterEvent("UPDATE_BATTLEFIELD_STATUS");
	this:RegisterEvent("CHAT_MSG_SYSTEM");
	this:RegisterEvent("GOSSIP_SHOW");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");


	local playerName = UnitName("player");
	if (playerName ~= UKNOWNBEING and playerName ~= UNKNOWNOBJECT) then
		BGAssist_Player = playerName;
	end

	SlashCmdList["BGASSIST"] = BGAssist_Console;
	SLASH_BGASSIST1 = "/bga";
	SLASH_BGASSIST2 = "/bgassist";

end

function BGAssist_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		BGAssist_Config_Loaded = 1;
		if (BGAssist_Player) then
			BGAssist_ConfigInit();
		end
	elseif (event == "ZONE_CHANGED_NEW_AREA") then
		BGAssist_Reset();
	elseif (event == "PLAYER_ENTERING_WORLD") then
		BGAssist_InAFK = nil;
	elseif (event == "CHAT_MSG_SYSTEM") then
		if (string.find(arg1,MATCHING_MARKED_AFK)) then
			BGAssist_InAFK = true;
		elseif (string.find(arg1,MATCHING_CLEARED_AFK)) then
			BGAssist_InAFK = nil;
		end
	elseif (event == "BATTLEFIELDS_SHOW") then
		local mapName = GetBattlefieldInfo();
		if (mapName == WARSONGGULCH or mapName == ARATHIBASIN) then
			BGAssist_PreExistingInstances = {};
			local numBattlefields = GetNumBattlefields();
			local i;
			for i = 1, numBattlefields, 1 do
				BGAssist_PreExistingInstances[GetBattlefieldInstanceInfo(i)] = GetTime();
			end
		end
		if (BGAssist_Config.autosignup) then
			if (((GetNumPartyMembers() > 0) or (GetNumRaidMembers() > 0)) and IsPartyLeader()) then
				JoinBattlefield(0,1);
			else
				JoinBattlefield(0);
			end
			HideUIPanel(BattlefieldFrame);
		end
	elseif (event == "UPDATE_BATTLEFIELD_STATUS") then
		local i, status, mapName, instanceID;
		for i = 1, MAX_BATTLEFIELD_QUEUES, 1 do
			local tmpstatus, tmpmapName, tmpinstanceID = GetBattlefieldStatus(i)
			if (tmpstatus == "active" or (tmpstatus == "confirm" and not status)) then
				status = tmpstatus;
				mapName = tmpmapName;
				instanceID = tmpinstanceID;
			end
		end
		if (status=="active") then
		BGAssist_PreExistingInstances = nil;
			if (not BGAssist_InBattleGround) then
				DEFAULT_CHAT_FRAME:AddMessage("BGAssist: "..DISPLAY_TEXT_ENTERINGBATTLEGROUNDS..": "..mapName);
				BGAssist_RezSyncTime = nil;
				BGAssist_InBattleGround = mapName;
				BGAssist_BagCheck();
				local idx,event;
				for idx,event in EVENTSINBATTLEGROUND do
					BGAssist:RegisterEvent(event);
				end
				BGAssist_MaintainingGroup = nil;
				if (not BGAssist_Config.noautoshow) then
					BGAssist_Timers:Show();
				end
				if (not BGAssist_Config.noautominimap) then
					ToggleBattlefieldMinimap();
				end
				if (not BGAssist_Config.notargetwindow) then
					BGAssist_Targets:Show();
				end

				-- reset ABTimeLeft
				lastBases = { -1, -1 };
				lastRes = { -1, -1 };
				BGAssist_ABTimeLeft_Frame1_Text:SetText("");
				BGAssist_ABTimeLeft_Frame2_Text:SetText("");

			end

			if (BGAssist_InBattleGround == ALTERACVALLEY or BGAssist_InBattleGround == ARATHIBASIN) then
				BGAssist_CheckMap();
			end

			if (BGAssist_InBattleGround == WARSONGGULCH) then
				BGAssist_Flags:Show();
			end

			if (BGAssist_InBattleGround == ARATHIBASIN) then
				if (not BGAssist_Config.abtimelefthide) then
					BGAssist_ABTimeLeft_Frame1:Show();
					BGAssist_ABTimeLeft_Frame2:Show();
				end
			end

		elseif (status=="confirm") then
			--[[
			local goodtoenter = true;
			if (((BGAssist_Config.avoidpreexistingwarsong and
				mapName == WARSONGGULCH) or
				(BGAssist_Config.avoidpreexistingarathi and
				mapName == ARATHIBASIN )) and
				BGAssist_PreExistingInstances and
				BGAssist_PreExistingInstances[instanceID]) then
				local timediff = GetTime() - BGAssist_PreExistingInstances[instanceID];
				if (timediff < 300) then
					goodtoenter = false;
					DEFAULT_CHAT_FRAME:AddMessage("BGAssist: "..DISPLAY_TEXT_PREEXISTING);
				end
			end
			if (goodtoenter and not BGAssist_Config.noautoenter) then
				if (BGAssist_InAFK) then
					DEFAULT_CHAT_FRAME:AddMessage("BGAssist: "..DISPLAY_TEXT_NOTENTERINGAFK);
				elseif (not (UnitIsDead("player") or UnitIsGhost("player"))) then
					local status, mapName, instanceID, idx;
					for i = 1, MAX_BATTLEFIELD_QUEUES, 1 do
						local tmpstatus, tmpmapName, tmpinstanceID = GetBattlefieldStatus(i);
						if (tmpstatus == "confirm") then
							status = tmpstatus;
							mapName = tmpmapName;
							instanceID = tmpinstanceID;
							idx = i;
						end
					end
					if (status) then
						StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY", idx);
						AcceptBattlefieldPort(idx, 1);
					end
				end
			end
			]]
		elseif (BGAssist_InBattleGround) then
			BGAssist_Timers:Hide();
			BGAssist_Flags:Hide();
			BGAssist_Targets:Hide();
			BGAssist_MaintainingGroup = nil;
			DEFAULT_CHAT_FRAME:AddMessage("BGAssist: "..DISPLAY_TEXT_LEFTBATTLEGROUNDS..": "..BGAssist_InBattleGround);
			BGAssist_InBattleGround = nil;
			BGAssist_RezSyncTime = nil;
			BGAssist_TimersActive = nil;


			BGAssist_ABTimeLeft_Frame1:Hide();
			BGAssist_ABTimeLeft_Frame2:Hide();

			local idx, event;
			for idx, event in EVENTSINBATTLEGROUND do
				BGAssist:UnregisterEvent(event);
			end
		end
	elseif (event == "CHAT_MSG_MONSTER_YELL" or event == "CHAT_MSG_BG_SYSTEM_NEUTRAL" or event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" or event == "CHAT_MSG_BG_SYSTEM_HORDE") then
		if (BGAssist_InBattleGround == ALTERACVALLEY or BGAssist_InBattleGround == ARATHIBASIN) then
			BGAssist_Scheduled_MapCheck = GetTime()+0.1;
		elseif (BGAssist_InBattleGround == WARSONGGULCH) then
			BGAssist_WSGFlags_OnShow();
		end
	elseif (event == "BAG_UPDATE") then
		if (BGAssist_InBattleGround == ALTERACVALLEY) then
			BGAssist_BagCheck();
		end
	elseif (event == "AREA_SPIRIT_HEALER_IN_RANGE") then
		BGAssist_RezSyncTime = GetTime() + GetAreaSpiritHealerTime();
	-- elseif (event == "QUEST_PROGRESS" or event == "QUEST_COMPLETE" or event == "QUEST_GREETING" or event == "QUEST_DETAIL") then
	elseif (event == "QUEST_PROGRESS" or event == "QUEST_COMPLETE" or event == "QUEST_DETAIL") then
		if (not BGAssist_Config.noautoquest and BGAssist_InBattleGround == ALTERACVALLEY) then
			BGAssist_Alterac_AutoProcess(event);
		end
	elseif (event == "GOSSIP_SHOW") then
		if (not BGAssist_InBattleGround and BGAssist_Config.autosignup and not IsControlKeyDown()) then
			BGAssist_SignUpForBG(GetGossipOptions());
		elseif (not BGAssist_Config.noautoquest and BGAssist_InBattleGround == ALTERACVALLEY  and not IsControlKeyDown()) then
			BGAssist_Alterac_SelectQuest(GetGossipAvailableQuests());
		end
	elseif (event == "PLAYER_DEAD") then
		if (BGAssist_Config.autorelease) then
			StaticPopup_Hide("DEATH");
			RepopMe();
		end
	elseif (event == "UPDATE_BATTLEFIELD_SCORE") then
		BGAssist_CountPlayers();
	elseif (event == "UPDATE_WORLD_STATES") then
		if (BGAssist_InBattleGround == WARSONGGULCH) then
			BGAssist_WSGFlags_OnShow();
		end
	elseif (event == "PARTY_MEMBER_CHANGED" or event == "PARTY_LEADER_CHANGED") then
		if (GetNumRaidMembers() == 0) then
			Debug_msg("BGAssist: Party: ",event," PARTY: ",GetNumPartyMembers(),"  RAID: ",GetNumRaidMembers(), " MAINTAINING: ",BGAssist_MaintainingGroup," LEADER: ",IsPartyLeader());
		end
		if ((GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0) and BGAssist_MaintainingGroup) then
			if (GetNumRaidMembers() > 0) then
			if (IsRaidLeader()) then
				else
					BGAssist_MaintainingGroup = nil;
				end
			elseif (IsPartyLeader()) then
				ConvertToRaid();
			else
				BGAssist_MaintainingGroup = nil;
			end
		else
			BGAssist_MaintainingGroup = nil;
		end
	end
end

function BGAssist_OnUpdate()
	local time = GetTime();
	if (BGAssist_Scheduled_MapCheck and BGAssist_Scheduled_MapCheck <= time) then
		BGAssist_Scheduled_MapCheck = nil;
		BGAssist_CheckMap();
	end

	if (BGAssist_InBattleGround == ARATHIBASIN) then
		-- ARATHIBASIN is over
		if(Glory:GetNumTeamResources(1) == "2000" or Glory:GetNumTeamResources(2) == "2000") then
			return;
		end

		-- update the ABTimeLeft text display
		if (not BGAssist_Config.abtimelefthide) then
			BGAssist_ABTimeLeft_UpdateStatus(0,BGAssist_ABTimeLeft_Frame1_Text,arg1);
			BGAssist_ABTimeLeft_UpdateStatus(1,BGAssist_ABTimeLeft_Frame2_Text,arg1);
		end
	end

end

function BGAssist_Reset()
	Debug_msg("BGAssist: RESET");

	BGAssist_Timers:Hide();
	BGAssist_Flags:Hide();
	BGAssist_Targets:Hide();
	BGAssist_MaintainingGroup = nil;
	BGAssist_InBattleGround = nil;
	BGAssist_RezSyncTime = nil;
	BGAssist_TimersActive = nil;

	--reset ABTimeleft
	lastBases = { -1, -1 };
	lastRes = { -1, -1 };
	BGAssist_ABTimeLeft_Frame1_Text:SetText("");
	BGAssist_ABTimeLeft_Frame2_Text:SetText("");

	BGAssist_ABTimeLeft_Frame1:Hide();
	BGAssist_ABTimeLeft_Frame2:Hide();

	local idx, event;
	for idx, event in EVENTSINBATTLEGROUND do
		BGAssist:UnregisterEvent(event);
	end

	if timer then
		while (timer <= MAXTIMERS) do
			local timerobj = getglobal("BGAssist_Timers"..timer);
			local text = getglobal("BGAssist_Timers"..timer.."Text");
			timerobj.name = nil;
			timerobj.endtime = nil;
			timerobj:Hide();
			text:SetText("");
			text:Hide();
			timer = timer + 1;
		end
	end
	Debug_msg("BGAssist: variables/events/timers deletet");

	local i, status, mapName, instanceID;
	for i = 1, MAX_BATTLEFIELD_QUEUES, 1 do
		local tmpstatus, tmpmapName, tmpinstanceID = GetBattlefieldStatus(i)
		if (tmpstatus == "active") then
			status = tmpstatus;
			mapName = tmpmapName;
			instanceID = tmpinstanceID;

			BGAssist_PreExistingInstances = nil;

			DEFAULT_CHAT_FRAME:AddMessage("BGAssist: "..DISPLAY_TEXT_ENTERINGBATTLEGROUNDS..": "..mapName);
			BGAssist_RezSyncTime = nil;
			BGAssist_InBattleGround = mapName;
			BGAssist_BagCheck();
			local idx,event;
			for idx,event in EVENTSINBATTLEGROUND do
				BGAssist:RegisterEvent(event);
			end
			BGAssist_MaintainingGroup = nil;
			if (not BGAssist_Config.noautoshow) then
				BGAssist_Timers:Show();
			end
			if (not BGAssist_Config.noautominimap) then
				ToggleBattlefieldMinimap();
			end
			if (not BGAssist_Config.notargetwindow) then
				BGAssist_Targets:Show();
			end
			if (BGAssist_InBattleGround == WARSONGGULCH) then
				BGAssist_Flags:Show();
			end
		if (BGAssist_InBattleGround == ALTERACVALLEY or BGAssist_InBattleGround == ARATHIBASIN) then
				BGAssist_CheckMap();
			end

		end
	end
end


--***********************************************************
-- START context menu functions
--***********************************************************

function BGAssist_MenuDropDown_CheckedToggle()
	local mapping = {
		[DISPLAY_MENU_LOCKWINDOW] = "windowlocked",
		[DISPLAY_MENU_AUTOSHOW] = "noautoshow",
		[DISPLAY_MENU_AUTOBGMINIMAP] = "noautominimap",
		[DISPLAY_MENU_AUTORELEASE] = "autorelease",
		[DISPLAY_MENU_AUTOQUEST] = "noautoquest",
		[DISPLAY_MENU_AUTOENTER] = "noautoenter",
		[DISPLAY_MENU_TIMERSHOW] = "timerhide",
		[DISPLAY_MENU_ABTIMELEFTSHOW] = "abtimelefthide",
		[DISPLAY_MENU_ITEMSHOW] = "itemhide",
		[DISPLAY_MENU_GYCOUNTDOWN] = "showgycountdown",
		[DISPLAY_MENU_FLAGTRACKING] = "noflags",
		[DISPLAY_MENU_TARGETTINGASSISTANCE] = "notargetwindow",
		[DISPLAY_MENU_NOPREEXISTING] = "avoidpreexistingwarsong";
		[DISPLAY_MENU_SHOWCAPTUREDFLAGS] = "showcapturedflags";
		[DISPLAY_MENU_AUTOSIGNUP] = "autosignup";
	};
	if (UIDROPDOWNMENU_MENU_VALUE == ALTERACVALLEY) then
	elseif (UIDROPDOWNMENU_MENU_VALUE == ARATHIBASIN) then
		mapping[DISPLAY_MENU_NOPREEXISTING] = "avoidpreexistingarathi";
	end
	local confoption = mapping[this.value];
	if (confoption) then
		if (BGAssist_Config[confoption]) then
			BGAssist_Config[confoption] = nil;
		else
			BGAssist_Config[confoption] = true;
		end
		if (BGAssist_Config.notargetwindow) then
			BGAssist_Targets:Hide();
		elseif (BGAssist_InBattleGround) then
			BGAssist_Targets:Show();
		end
		BGAssist_Timers_OnShow();
	end
end

function BGAssist_MenuDropDown_Initialize()
	local info = {};

	if (UIDROPDOWNMENU_MENU_LEVEL == 2) then
		info.func = BGAssist_MenuDropDown_CheckedToggle;

		if (UIDROPDOWNMENU_MENU_VALUE == ALTERACVALLEY) then
			info.text = DISPLAY_MENU_TIMERSHOW;
			info.checked = nil;
			if (not BGAssist_Config.timerhide) then info.checked = 1; end
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			info.text = DISPLAY_MENU_AUTOQUEST;
			info.checked = nil;
			if (not BGAssist_Config.noautoquest) then info.checked = 1; end
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			info.text = DISPLAY_MENU_ITEMSHOW;
			info.checked = nil;
			if (not BGAssist_Config.itemhide) then info.checked = 1; end
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		elseif (UIDROPDOWNMENU_MENU_VALUE == WARSONGGULCH) then
			info.text = DISPLAY_MENU_FLAGTRACKING;
			info.checked = nil;
			if (not BGAssist_Config.noflags) then info.checked = 1; end
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			info.text = DISPLAY_MENU_NOPREEXISTING;
			info.checked = nil;
			if (BGAssist_Config.avoidpreexistingwarsong) then info.checked = 1; end
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		elseif (UIDROPDOWNMENU_MENU_VALUE == ARATHIBASIN) then
			info.text = DISPLAY_MENU_NOPREEXISTING;
			info.checked = nil;
			if (BGAssist_Config.avoidpreexistingarathi) then info.checked = 1; end
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			info.text = DISPLAY_MENU_SHOWCAPTUREDFLAGS;
			info.checked = nil;
			if (BGAssist_Config.showcapturedflags) then info.checked = 1; end
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			info.text = DISPLAY_MENU_ABTIMELEFTSHOW;
			info.checked = nil;
			if (not BGAssist_Config.abtimelefthide) then info.checked = 1; end
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
	else
		info.isTitle = true;
		info.text = "BGAssist "..BGASSIST_VERSION;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.hasArrow = 1;
		info.notCheckable = 1;

		info.text = ALTERACVALLEY;
		UIDropDownMenu_AddButton(info);

		info.text = WARSONGGULCH;
		UIDropDownMenu_AddButton(info);

		info.text = ARATHIBASIN;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.func = BGAssist_MenuDropDown_CheckedToggle;

		info.text = DISPLAY_MENU_LOCKWINDOW;
		info.checked = nil;
		if (BGAssist_Config.windowlocked) then info.checked = 1; end
		UIDropDownMenu_AddButton(info);

		info.text = DISPLAY_MENU_AUTOSHOW;
		info.checked = nil;
		if (not BGAssist_Config.noautoshow) then info.checked = 1; end
		UIDropDownMenu_AddButton(info);

		info.text = DISPLAY_MENU_AUTOBGMINIMAP;
		info.checked = nil;
		if (not BGAssist_Config.noautominimap) then info.checked = 1; end
		UIDropDownMenu_AddButton(info);


		info.text = DISPLAY_MENU_AUTORELEASE;
		info.checked = nil;
		if (BGAssist_Config.autorelease) then info.checked = 1; end
		UIDropDownMenu_AddButton(info);

		info.text = DISPLAY_MENU_AUTOENTER;
		info.checked = nil;
		if (not BGAssist_Config.noautoenter) then info.checked = 1; end
		UIDropDownMenu_AddButton(info);

		info.text = DISPLAY_MENU_AUTOSIGNUP;
		info.checked = nil;
		if (BGAssist_Config.autosignup) then info.checked = 1; end
		UIDropDownMenu_AddButton(info);

		info.text = DISPLAY_MENU_GYCOUNTDOWN;
		info.checked = nil;
		if (BGAssist_Config.showgycountdown) then info.checked = 1; end
		UIDropDownMenu_AddButton(info);

		info.text = DISPLAY_MENU_TARGETTINGASSISTANCE;
		info.checked = nil;
		if (not BGAssist_Config.notargetwindow) then info.checked = 1; end
		UIDropDownMenu_AddButton(info);

	end
end


--***********************************************************
-- START Alterac timer functions
--***********************************************************


function BGAssist_Timers_OnUpdate(elapsed)
	local time = GetTime();
	local starttimer = 1;
	if (BGAssist_Config.showgycountdown) then
		local timerobj = getglobal("BGAssist_Timers1");
		if (timerobj.name == "Graveyard") then
			if (BGAssist_RezSyncTime) then
				local timeleft = BGAssist_RezSyncTime-GetTime();
				while (timeleft < 0) do
					BGAssist_RezSyncTime = BGAssist_RezSyncTime + 30;
					timeleft = math.floor(BGAssist_RezSyncTime-GetTime());
				end
				timerobj:SetValue(timeleft);
			else
				timerobj:SetValue(30);
			end
			starttimer = 2;
		end
	end

	if (BGAssist_TimersActive) then
		if (BGAssist_TimersActive <= time) then
			BGAssist_UpdateTimers();
		else
			if (BGAssist_LastTimersProc+1 < time) then
				local i;
				for i = starttimer, MAXTIMERS, 1 do
					local timer = getglobal("BGAssist_Timers"..i);
					if (timer.endtime) then
						local timeleft = timer.endtime - time;
						timer:SetValue(timeleft);
					end
				end
				BGAssist_LastTimersProc = time;
			end
		end
		if (this.updateTooltip) then
			this.updateTooltip = this.updateTooltip - elapsed;
			if (this.updateTooltip < 0) then
				BGAssist_Timer_SetTooltip(this.tooltipUpdate);
			end
		end
	end
end

function BGAssist_Timers_OnShow()
	UIDropDownMenu_Initialize(BGAssist_Timers_Menu, BGAssist_MenuDropDown_Initialize, "MENU");

	BGAssist_UpdateTimers();
	BGAssist_UpdateItems();
	if (BGAssist_Timers2:IsVisible() or (BGAssist_Timers1:IsVisible() and BGAssist_Config.showgycountdown)) then
		BGAssist_Timers_TitleText:SetText(DISPLAY_TITLEDISPLAY_CAPTURE);
	else
		if (BGAssist_Timers_Icon1:IsVisible()) then
			BGAssist_Timers_TitleText:SetText(DISPLAY_TITLEDISPLAY_ITEMS);
		else
			BGAssist_Timers_TitleText:SetText("BGAssist");
		end
	end
	BGAssist_DynamicResize();
end

function BGAssist_UpdateTimers()

	local function sort_function (a, b)
		local endtime= BGAssist_MapItems[a].conflictstart + BGAssist_MapItems[a].conflictduration;
		local atime = endtime - GetTime();
		endtime= BGAssist_MapItems[b].conflictstart + BGAssist_MapItems[b].conflictduration;
		local btime = endtime - GetTime();
		if (atime < btime) then return true; else return false; end
	end

	local starttimer = 1;
	local i, status, mapName, instanceID;
	for i = 1, MAX_BATTLEFIELD_QUEUES, 1 do
		local tmpstatus, tmpmapName, tmpinstanceID = GetBattlefieldStatus(i);
		if (tmpstatus == "active") then
			status = tmpstatus;
			mapName = tmpmapName;
			instanceID = tmpinstanceID;
		end
	end
	if (BGAssist_Config.showgycountdown) then
		local timerobj = getglobal("BGAssist_Timers1");
		local text = getglobal("BGAssist_Timers1Text");
		timerobj.name = "Graveyard";
		timerobj:Show();
		timerobj:SetStatusBarColor (0, 1, 0);
		timerobj:SetMinMaxValues(0,30);
		if (BGAssist_RezSyncTime) then
			local timeleft = math.floor(BGAssist_RezSyncTime-GetTime());
			while (timeleft < 0) do
				BGAssist_RezSyncTime = BGAssist_RezSyncTime + 30;
				timeleft = math.floor(BGAssist_RezSyncTime-GetTime());
			end
			timerobj:SetValue(timeleft);
		else
			timerobj:SetValue(30);
		end
		text:Show();
		text:SetText("Graveyard");
		starttimer = 2;
	end
	if (not BGAssist_Config.timerhide and status == "active") then
		if (BGAssist_MapItems == nil or BGAssist_MapItems == {}) then
			BGAssist_CheckMap();
			if (BGAssist_MapItems == nil or BGAssist_MapItems == {}) then
				return;
			end
		end
		local conflicts = {};
		local conflictcount = 0;
		local red, green, blue;
		local name;
		for name in BGAssist_MapItems do
			if BGAssist_MapItems[name].conflictstart ~= nil then
				if (type(BGAssist_MapItems[name].conflictstart) == "number" or (BGAssist_Config.showcapturedflags and BGAssist_InBattleGround == ARATHIBASIN)) then
					local endtime = BGAssist_MapItems[name].conflictstart + BGAssist_MapItems[name].conflictduration;
					local timeleft = endtime - GetTime();
					if (timeleft > 0 or (BGAssist_Config.showcapturedflags and BGAssist_InBattleGround == ARATHIBASIN)) then
						conflictcount = conflictcount + 1;
						conflicts[conflictcount] = name;
					end
				end
			end
		end
		table.sort(conflicts, sort_function);
		local timer = starttimer;
		local idx = 1;
		while (timer <= MAXTIMERS and conflicts[idx]) do
			local timerobj = getglobal("BGAssist_Timers"..timer);
			local text = getglobal("BGAssist_Timers"..timer.."Text");
			red = 0; green = 0; blue = 0;
			if (BGAssist_MapItems[conflicts[idx]].owner == "HORDE") then
				red = 1;
			elseif (BGAssist_MapItems[conflicts[idx]].owner == "ALLIANCE") then
				green = 1; blue = 1;
			end
			local endtime= BGAssist_MapItems[conflicts[idx]].conflictstart +
				BGAssist_MapItems[conflicts[idx]].conflictduration;
			local timeleft = endtime - GetTime();
			if (timeleft < 1) then
				BGAssist_Scheduled_MapCheck = GetTime()+1;
				BGAssist_MapItems[conflicts[idx]].conflictstart = nil;
			end
			if (not BGAssist_TimersActive or endtime < BGAssist_TimersActive) then
				BGAssist_TimersActive = endtime;
			end
			timerobj.name = conflicts[idx];
			timerobj.endtime = endtime;
			timerobj:Show();
			timerobj:SetStatusBarColor (red, green, blue);
			if (BGAssist_InBattleGround == ALTERACVALLEY) then
				timerobj:SetMinMaxValues(0,302);
			elseif (BGAssist_InBattleGround == ARATHIBASIN) then
				timerobj:SetMinMaxValues(0,62);
			else
				Debug_msg("INVALID ZONE: ",BGAssist_InBattleGround);
			end
			timerobj:SetValue(timeleft);
			text:Show();
			-- local sidx = string.find(conflicts[idx]," ");
			-- if (sidx) then
			-- 	text:SetText(string.sub(conflicts[idx],1,sidx-1));
			-- else
				text:SetText(conflicts[idx]);
			-- end
			idx = idx + 1;
			timer = timer + 1;
		end
		while (timer <= MAXTIMERS) do
			local timerobj = getglobal("BGAssist_Timers"..timer);
			local text = getglobal("BGAssist_Timers"..timer.."Text");
			timerobj.name = nil;
			timerobj.endtime = nil;
			timerobj:Hide();
			text:SetText("");
			text:Hide();
			timer = timer + 1;
		end
	else
		for timer = starttimer, MAXTIMERS, 1 do
		local timerobj = getglobal("BGAssist_Timers"..timer);
			local text = getglobal("BGAssist_Timers"..timer.."Text");
			timerobj:Hide();
			text:Hide();
		end
	end
end

function BGAssist_TimersTitle_OnClick(button)
	if (arg1 == "RightButton") then
		ToggleDropDownMenu(1, nil, BGAssist_Timers_Menu, "BGAssist_Timers_Menu", 0, 50);
	else
		if (this:GetButtonState() == "PUSHED") then
			this:GetParent():StopMovingOrSizing();
		elseif (not BGAssist_Config.windowlocked) then
			this:GetParent():StartMoving();
		end
	end
end

function BGAssist_Timer_SetTooltip(override)
	if (not override) then
		override = this;
	end
	local txt;
	local timeleft;
	if (override.name == "Graveyard") then
		txt = DISPLAY_TEXT_TIMEUNTILREZ;
		if (BGAssist_RezSyncTime) then
			timeleft = math.floor(BGAssist_RezSyncTime-GetTime());
		else
			timeleft = 30;
		end
	elseif (override.name and override.endtime) then

		txt = override.name;
		timeleft = math.floor(override.endtime - GetTime());
	end
	if (txt and timeleft) then
		txt = txt.."\n"..DISPLAY_TEXT_TIMELEFT..": "..timeleft.." "..DISPLAY_TEXT_SECONDS..".";
		if (timeleft > 60) then
			txt = txt.."\n("..(math.floor(timeleft/6)/10).." "..DISPLAY_TEXT_MINUTES..")";
		end
		BGAssist_Timers.updateTooltip = TOOLTIP_UPDATE_TIME;
		BGAssist_Timers.tooltipUpdate = override;
		local left = override:GetLeft();
		if (left > 800) then
			GameTooltip:SetOwner(override, "ANCHOR_LEFT");
		else
			GameTooltip:SetOwner(override, "ANCHOR_RIGHT");
		end
		GameTooltip:SetText(txt);
	end
end

--***********************************************************
-- START Alterac item functions
--***********************************************************

function BGAssist_UpdateItems()
	local function findicon (item)
		local idx = 1;
		local found = 0;
		while (found == 0 and idx <= MAXICONS) do
			local icon = getglobal("BGAssist_Timers_Icon"..idx);
			if (icon and icon.item and icon.item == item) then
				found = idx;
			end
			idx = idx + 1;
		end
		return found;
	end
	local function fillicon (item, num)
		local icon = getglobal("BGAssist_Timers_Icon"..num);
		if (icon) then
			icon.item = item;
			icon:Show();
			getglobal("BGAssist_Timers_Icon"..num.."Icon"):SetTexture(BGAssist_ItemInfo[item].texture);

			getglobal("BGAssist_Timers_Icon"..num.."Label"):SetText(BGAssist_TrackedItems[icon.item]);


		end
	end

	local showitems = {};
	local maxicon = 0;
	if (not BGAssist_Config.itemhide and BGAssist_InBattleGround == ALTERACVALLEY and BGAssist_TrackedItems and BGAssist_TrackedItems ~= {}) then
		local item;
		for item in BGAssist_TrackedItems do
			if (BGAssist_TrackedItems[item] > 0) then
				showitems[item] = findicon(item);
			end
		end
		for item in showitems do
			local idx = 1;
			if (showitems[item] == 0) then
				while (showitems[item] == 0 and idx <= MAXICONS) do
					local icon = getglobal("BGAssist_Timers_Icon"..idx);
					if (icon and not icon.item) then
						showitems[item] = idx;
					end
					idx = idx + 1;
				end
			end
			if (showitems[item] > maxicon) then maxicon = showitems[item]; end
			fillicon (item, showitems[item])
		end
		local i;
		for i = 1, MAXICONS, 1 do
			local icon = getglobal("BGAssist_Timers_Icon"..i);
			if (not icon.item or not BGAssist_TrackedItems[icon.item] or BGAssist_TrackedItems[icon.item] < 1) then
				if (i < maxicon) then
					local j = i+1;
					local jicon = getglobal("BGAssist_Timers_Icon"..j);
					while (j <= MAXICONS and not jicon.item) do
						jicon = getglobal("BGAssist_Timers_Icon"..j);
						j = j + 1;
					end
					if (jicon.item) then
						fillicon (jicon.item, j-1);
						jicon.item = nil;
					end
				else
					icon.item = nil;
					icon:Hide();
				end
			end
		end
	else
		local i;
		for i = 1, MAXICONS, 1 do
			local icon = getglobal("BGAssist_Timers_Icon"..i);
			icon:Hide();
			icon.item = nil;
		end
	end
end

function BGAssist_Item_SetTooltip()
	if (this.item and BGAssist_ItemInfo[this.item] and BGAssist_ItemInfo[this.item].name) then
		local txt = BGAssist_ItemInfo[this.item].name.."\nCurrent Count: "..BGAssist_TrackedItems[this.item];
		local left = this:GetLeft();
		if (left > 800) then
			GameTooltip:SetOwner(this, "ANCHOR_LEFT");
		else
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		end
		GameTooltip:SetText(txt);
	end
end

--***********************************************************
-- START alterac info menu functions
--***********************************************************

function BGAssist_DynamicResize()
	local i;
	local maxtimer = 0;
	local maxicon = 0;
	for i = 1, MAXICONS, 1 do
		local icon = getglobal("BGAssist_Timers_Icon"..i);
		if (icon:IsVisible()) then maxicon = i; end
	end
	for i = 1, MAXTIMERS, 1 do
		local timerobj = getglobal("BGAssist_Timers"..i);
		if (timerobj:IsVisible()) then maxtimer = i; end;
	end

	if (BGAssist_Config.timerhide) then maxtimer = 0; end
	if (BGAssist_Config.itemhide or BGAssist_InBattleGround ~= ALTERACVALLEY) then maxicon = 0; end

	-- Move Icons to under last timer
	if (maxicon and maxicon > 0) then
		BGAssist_Timers_Icon1:ClearAllPoints();
		if (maxtimer == 0) then
			BGAssist_Timers_Icon1:SetPoint("TOPLEFT","BGAssist_Timers","TOPLEFT",6,-8);
		else
			BGAssist_Timers_Icon1:SetPoint("TOPLEFT","BGAssist_Timers"..maxtimer,"BOTTOMLEFT",0,-6);
		end
	end
	local iconwidth = 36;
	local iconheight = 36;
	if (maxicon and maxicon > 3) then
		if (maxicon > 4) then
			iconwidth = 24;
		else
			iconwidth = 30;
		end
		if (maxicon > 5) then
			iconheight = 18;
		end
	end
	for i = 1, MAXICONS, 1 do
		local icon = getglobal("BGAssist_Timers_Icon"..i);
		local texture = getglobal("BGAssist_Timers_Icon"..i.."NormalTexture");
		icon:SetWidth(iconwidth);
		icon:SetHeight(iconheight);
		texture:SetWidth(iconwidth*2);
		texture:SetHeight(iconheight*2);
	end
	local backdropheight = 16; -- Buffer at top and bottom and room for border
	backdropheight = backdropheight + (maxtimer*12);
	if (maxicon > 0 and maxtimer > 0) then backdropheight = backdropheight + 3; end
	if (maxicon > 5) then
		backdropheight = backdropheight + (iconheight*2) + 3;
	elseif (maxicon > 0) then
		backdropheight = backdropheight + iconheight;
	end
	BGAssist_Timers:SetHeight(backdropheight);
end

--***********************************************************
-- START other alterac functions
--***********************************************************

function BGAssist_Alterac_SelectQuest(...)
	local i;
	local idx = 0;
	for i = 1, arg.n, 2 do
		idx = idx + 1;
		if (BGAssist_Alterac_Quests[arg[i]]) then
			local item, min, max;
			if (type(BGAssist_Alterac_Quests[arg[i]]) == "table") then
				item = BGAssist_Alterac_Quests[arg[i]].item;
				min = BGAssist_Alterac_Quests[arg[i]].min;
				max = BGAssist_Alterac_Quests[arg[i]].max;
			else
				item = true;
			end
			if (not min or min < 1) then min = 1; end
			if (not max) then max = 1000; end
			local count = BGAssist_TrackedItems[item];
			if (not count) then count = 0; end
			if (item == true or (count >= min and count <= max)) then
				if (not BGAssist_Config[BGAssist_Player].turnins[arg[i]]) then
					BGAssist_Config[BGAssist_Player].turnins[arg[i]] = 0;
				end
				BGAssist_Config[BGAssist_Player].turnins[arg[i]] = BGAssist_Config[BGAssist_Player].turnins[arg[i]] + min;
				SelectGossipAvailableQuest(idx);
			end
		end
	end
end


function BGAssist_Alterac_AutoProcess(method)
	if (BGAssist_Alterac_Quests[GetTitleText()]) then
		if (method == "QUEST_COMPLETE") then
			QuestRewardCompleteButton_OnClick();
		elseif (method == "QUEST_PROGRESS") then
			QuestProgressCompleteButton_OnClick();
		elseif (method == "QUEST_DETAIL") then
			QuestDetailAcceptButton_OnClick();
		else
			Debug_msg("Unknown METHOD: "..method.." for "..GetTitleText());
		end
	end
end



--***********************************************************
-- START WS flag functions
--***********************************************************

function BGAssist_WSGFlags_OnShow()

	local stateidx = { "Alliance", "Horde" };
	local i;
	local FlagVisible;
	if (not BGAssist_Config.noflags) then

		getglobal("BGAssist_Flags"):Show();

		for i = 1, 2, 1 do

			if Glory:GetFlagCarrier(i) then
				Debug_msg(stateidx[i]..": "..Glory:GetFlagCarrier(i));
			else
				Debug_msg(stateidx[i]..": NIL");
			end

--			local state, text, icon, isFlashing = GetWorldStateUIInfo(i);
--			if isFlashing then Debug_msg(stateidx[i].." flag flashing:"..isFlashing);end;

--			local displaybuttonobj = getglobal ("BGAssist_Flags_"..stateidx[i].."Text");
			local displaystringobj = getglobal ("BGFlag_"..stateidx[i]);

			local flagobj = getglobal ("AlwaysUpFrame".. i .."DynamicIconButtonIcon");

			if flagobj:IsVisible() then
				Debug_msg(stateidx[i].." flag visible");
				FlagVisible = 1;
			else
				FlagVisible = nil;
				Debug_msg(stateidx[i].." flag NOT visible");
			end

--			if (not isFlashing) then
			if (not FlagVisible) then
				displaystringobj:SetText("");
			elseif (Glory:GetFlagCarrier(i)) then
				displaystringobj:SetText(Glory:GetFlagCarrier(i));
				Debug_msg("set "..stateidx[i].." flag text to:"..Glory:GetFlagCarrier(i));
			else
				displaystringobj:SetText("(Unknown)");
				Debug_msg("set "..stateidx[i].." flag text to: (Unknown)");
			end

--			local buttonText = displaybuttonobj:GetText();
--			displaybuttonobj:SetText(buttonText.." plus buttontext");

		end
	else
		for i = 1, 2, 1 do
			getglobal("BGFlag_"..stateidx[i]):SetText("")
		end
	end
end

function BGAssist_Flags_OnClick(override)
	if (not override) then override = this; end
	local stateidx = { ["Alliance"] = 1, ["Horde"] = 2 , };

	local flagobj = getglobal ("AlwaysUpFrame".. stateidx[override.faction] .."DynamicIconButtonIcon");

	if (flagobj:IsVisible() and Glory:GetFlagCarrier(override.faction)) then
		TargetByName(Glory:GetFlagCarrier(override.faction));
		if (UnitName("target") ~= Glory:GetFlagCarrier(override.faction)) then
			ClearTarget();
			DEFAULT_CHAT_FRAME:AddMessage("BGAssist: "..DISPLAY_TEXT_FLAGHOLDERNOTCLOSEENOUGH);
		end
	end
end


--***********************************************************
-- START target functions
--***********************************************************

function BGAssist_UpdateTargets()
	local idx;
	local unit;
	local targets = {};
	local targetcounts = {};
	local targetidx = 0;

	local function sort_function (a,b)
		if (targetcounts[a.name] > targetcounts[b.name]) then
			return true;
		elseif (targetcounts[a.name] < targetcounts[b.name]) then
			return false;
		--[[
		elseif (a.distance > b.distance) then
			return true;
		elseif (a.distance < b.distance) then
			return false;
		]]
		elseif (a.name < b.name) then
			return true;
		else
			return false;
		end
	end

	local max = 40;
	if (BGAssist_InBattleGround == WARSONGGULCH) then max = 10; end

	for idx = 1, max, 1 do
		unit = "raid"..idx.."target";
		if (UnitName(unit) and UnitCanAttack("player",unit)) then
			targetidx = targetidx + 1;
			local px,py = GetPlayerMapPosition("player");
			local tx,ty = GetPlayerMapPosition("raid"..idx);
			local xdist = tx-px;
			local ydist = ty-py;
			local dist = sqrt(math.pow(xdist,2)+math.pow(ydist,2));
			targets[targetidx] = {
				["name"] = UnitName(unit);
				["class"] = UnitClass(unit);
				["unit"] = unit;
				["distance"] = dist;
			};
			if (not targetcounts[UnitName(unit)]) then
				targetcounts[UnitName(unit)] = 0;
			end
			targetcounts[UnitName(unit)] = targetcounts[UnitName(unit)] + 1;
		end
	end
	if (UnitName("target") and UnitCanAttack("player","target")) then
		targetidx = targetidx + 1;
		targets[targetidx] = {
			["name"] = UnitName("target");
			["class"] = UnitClass(unit);
			["unit"] = "target";
			["distance"] = 0;
		};
		if (not targetcounts[UnitName("target")]) then
			targetcounts[UnitName("target")] = 0;
		end
		targetcounts[UnitName("target")] = targetcounts[UnitName("target")] + 1;
	end
	table.sort (targets, sort_function);

	local lasttarget = nil;
	local targetidx = 1;
	for idx = 1, table.getn(targets), 1 do
		if (targetidx < 10 and not UnitIsDead(targets[idx].unit) and targets[idx].name ~= lasttarget) then
			local targetobj = getglobal("BGAssist_Targets"..targetidx);
			local targettxt = getglobal("BGAssist_Targets"..targetidx.."_Text");
			local targethealth = getglobal("BGAssist_Targets"..targetidx.."_Bar_Health");
			local iconobj = getglobal("BGAssist_Targets"..targetidx.."_Class");

			lasttarget = targets[idx].name;
			targetobj.name = targets[idx].name;
			targetobj.unit = targets[idx].unit;
			if (targets[idx].class) then
				targetobj.class = string.upper(targets[idx].class);
				local coords = CLASS_ICON_TCOORDS[targetobj.class];
				iconobj:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
				iconobj:Show();
			else
				targetobj.class = nil;
				iconobj:Hide();
			end
			-- targettxt:SetText(targetcounts[targets[idx].name].." ("..targets[idx].distance..") = "..targets[idx].name);
			targettxt:SetText(targets[idx].name);
			local health = UnitHealth(targets[idx].unit);
			local maxhealth = UnitHealthMax(targets[idx].unit);
			if (maxhealth ~= 100) then
				health = math.floor(health/maxhealth*100);
			end
			targethealth:SetValue(health);
			targetobj:Show();
			targetidx = targetidx + 1;
		end
	end
	for idx = targetidx, 10, 1 do
		local targetobj = getglobal("BGAssist_Targets"..idx);
		targetobj:Hide();
		targetobj.name = nil;
		targetobj.unit = nil;
		targetobj.class = nil;
		--[[
		targetobj:Show();
		local targettxt = getglobal("BGAssist_Targets"..idx.."_Text");
		targettxt:SetText("SpankingMonkeyAss");
		local coords = CLASS_ICON_TCOORDS["SHAMAN"];
		local iconobj = getglobal("BGAssist_Targets"..idx.."_Class");
		iconobj:SetTexCoord(coords[1], coords[2], coords[3], coords[4]);
		]]
	end
end

function BGAssist_Targets_OnUpdate(elapsed)
	BGAssist_LastUpdate = BGAssist_LastUpdate+elapsed;
	if (BGAssist_LastUpdate > 0.1) then
		BGAssist_LastUpdate = 0;
		BGAssist_UpdateTargets();
	end
end

function BGAssist_TargetMenuDropDown_Initialize()
	local info = {};

	if (UIDROPDOWNMENU_MENU_LEVEL == 2) then
	else
		info.isTitle = true;
		info.text = "BGAssist "..BGASSIST_VERSION;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.func = BGAssist_MenuDropDown_CheckedToggle;

		info.text = DISPLAY_MENU_LOCKWINDOW;
		info.checked = nil;
		if (BGAssist_Config.windowlocked) then info.checked = 1; end
		UIDropDownMenu_AddButton(info);
	end
end

function BGAssist_Targets_OnShow()
	UIDropDownMenu_Initialize(BGAssist_Targets_Menu, BGAssist_TargetMenuDropDown_Initialize, "MENU");
	getglobal(this:GetName().."_TitleText"):SetText(DISPLAY_TITLEDISPLAY_TARGETS);
	BGAssist_UpdateTargets();
end

function BGAssist_TargetsTitle_OnClick()
	if (arg1 == "RightButton") then
		ToggleDropDownMenu(1, nil, BGAssist_Targets_Menu, "BGAssist_Targets_Menu", 0, 50);
	else
		if (this:GetButtonState() == "PUSHED") then
			this:GetParent():StopMovingOrSizing();
	elseif (not BGAssist_Config.windowlocked) then
			this:GetParent():StartMoving();
		end
	end
end

function BGAssist_Target_OnClick()
	local unit = this:GetParent().unit;
	local name = this:GetParent().name;
	if (unit and name and UnitName(unit) == name) then
		if (SpellIsTargeting()) then
			SpellTargetUnit(unit);
		else
			TargetUnit(unit);
		end
	elseif (name) then
		TargetByName(name);
	end
end

--***********************************************************
-- START some other functions
--***********************************************************

function BGAssist_LinkDecode(link)
	local id, name;
	_, _, id, name = string.find(link,"|Hitem:(%d+):%d+:%d+:%d+|h%[([^]]+)%]|h|r$");
	-- Only first number of itemid is significant in this.
	if (id and name) then
		id = id * 1;
		return name, id;
	end
end

function BGAssist_BagCheck()
	local bag, slot, size;
	BGAssist_TrackedItems = {};
	for bag = 0, 4, 1 do
		if (bag == 0) then
			size = 16;
		else
			size = GetContainerNumSlots(bag);
		end
		if (size and size > 0) then
			for slot = 1, size, 1 do
				local itemLink = GetContainerItemLink(bag,slot);
				if (itemLink) then
					local itemName, itemID = BGAssist_LinkDecode(itemLink);
					local texture, itemCount = GetContainerItemInfo(bag,slot);
					if (itemID and BGAssist_ItemTrack[itemID]) then
						if (not BGAssist_TrackedItems[itemID]) then
							BGAssist_TrackedItems[itemID] = 0;
						end
						BGAssist_ItemInfo[itemID] = {
							["name"] = itemName,
							["texture"] = texture;
						};
						BGAssist_TrackedItems[itemID] = BGAssist_TrackedItems[itemID] + itemCount;
					end
				end
			end
		end
	end
	if (BGAssist_Timers:IsVisible()) then
		BGAssist_Timers_OnShow();
	end
end

function BGAssist_CheckMap()
	local OUTOFZONEDATA = {
		[1] = { "Dead Guys", "", 3 };
		[2] = { "Bar", "Drink Here", 8};
		[3] = { "Elves Head Point", "ELVES DIE", 11 };
		[4] = { "Monkey", "Monkey", 13 };
	};
	local totallandmarks = GetNumMapLandmarks()
	local name, description, typ, x, y;
	local i;
	for i = 1, totallandmarks, 1 do
		name, description, typ, x, y = GetMapLandmarkInfo(i);
		-- typ:
		-- Alterac Valley
		--  0 = Mines, no icon
		--  1 = Horde controlled mine
		--  2 = Alliance controlled mine
		--  3 = Horde graveyard attacked by Alliance
		--  4 = Towns (Booty Bay, Stonard, etc)
		--  5 = Destroyed tower
		--  6 =
		--  7 = Uncontrolled Graveyard (Snowfall at start)
		--  8 = Horde tower attacked by Alliance
		--  9 = Horde controlled tower
		-- 10 = Alliance controlled tower
		-- 11 = Alliance tower attacked by Horde
		-- 12 = Horde controlled graveyard
		-- 13 = Alliance graveyard attacked by Horde
		-- 14 = Alliance controlled graveyard
		-- 15 = Garrisons/Caverns, no icon
		-- Arathi Basin
		-- 16 - Gold Mine - Uncontrolled
		-- 17 - Gold Mine .. in conflict (Alliance capturing)
		-- 18 - Gold Mine - Alliance controlled
		-- 19 = Gold Mine .. in conflict (Horde capturing)
		-- 20 = Gold Mine - Horde Controlled
		-- 21 = Lumber Mill - Uncontrolled
		-- 22 = Lumber Mill .. in conflict (Alliance capturing)
		-- 23 = Lumber Mill - Alliance controlled
		-- 24 = Lumber Mill .. in conflict (Horde capturing)
		-- 25 = Lumber Mill - Horde Controlled
		-- 26 = Blacksmith - Uncontrolled
		-- 27 = Blacksmith .. in conflict (Alliance capturing)
		-- 28 = Blacksmith - Alliance controlled
		-- 29 = Blacksmith .. in conflict (Horde capturing)
		-- 30 = Blacksmith - Horde controlled
		-- 31 = Farm - Uncontrolled
		-- 32 = Farm .. in conflict (Alliance capturing)
		-- 33 = Farm - Alliance controlled
		-- 34 = Farm .. in conflict (Horde capturing)
		-- 35 = Farm - Horde controlled
		-- 36 = Stables - Uncontrolled
		-- 37 = Stables .. in conflict (Alliance capturing)
		-- 38 = Stables - Alliance controlled
		-- 39 = Stables .. in conflict (Horde capturing)
		-- 40 = Stables - Horde controlled
		if (not BGAssist_MapItems[name]) then BGAssist_MapItems[name] = {} end
		if (	   typ == 11 or typ == 13 or typ == 9 or typ == 12 -- AV
			or typ == 20 or typ == 25 or typ == 30 or typ == 35 or typ == 40 -- AB
			or typ == 19 or typ == 24 or typ == 29 or typ == 34 or typ == 39 -- AB captures
		) then
			if (BGAssist_MapItems[name].owner ~= "HORDE") then
				BGAssist_MapItems[name].owner = "HORDE";
				BGAssist_MapItems[name].conflictstart = nil;
			end
		elseif (   typ == 10 or typ == 3 or typ == 8 or typ == 14 -- AV
			or typ == 18 or typ == 23 or typ == 28 or typ == 33 or typ == 38 -- AB
			or typ == 17 or typ == 22 or typ == 27 or typ == 32 or typ == 37 -- AB captures
		) then
			if (BGAssist_MapItems[name].owner ~= "ALLIANCE") then
				BGAssist_MapItems[name].owner = "ALLIANCE";
				BGAssist_MapItems[name].conflictstart = nil;
			end
		elseif (typ == 0 or typ == 5 or typ == 15 -- AV
			) then
			BGAssist_MapItems[name].owner = nil;
		end
		--[[
		if ( typ == 17 or typ == 22 or typ == 27 or typ == 32 or typ == 37 -- AB
		     or typ == 19 or typ == 24 or typ == 29 or typ == 34 or typ == 39 -- AB
		    ) then
			Debug_msg("UNKNOWN: ",name," = ",description," = ",typ,": ",BGAssist_MapItems[name].owner);
		end
		]]

		if (typ == 3 or typ == 13 or typ == 8 or typ == 11) then -- AV
			if (not BGAssist_MapItems[name].conflictstart) then
				BGAssist_MapItems[name].conflictstart = GetTime();
				BGAssist_MapItems[name].conflictduration = 300;
			end
		elseif (   typ == 17 or typ == 22 or typ == 27 or typ == 32 or typ == 37
			or typ == 19 or typ == 24 or typ == 29 or typ == 34 or typ == 39
		) then
			if (not BGAssist_MapItems[name].conflictstart) then
				BGAssist_MapItems[name].conflictstart = GetTime();
				BGAssist_MapItems[name].conflictduration = 60;
			end
		else
			BGAssist_MapItems[name].conflictstart = nil
		end
		if (typ ==  6 or typ > 40) then
			Debug_msg("UNKNOWN: "..name.." = "..description.." = "..typ);
		end
	end
	if (not BGAssist_Config.timerhide) then
		BGAssist_Timers_OnShow();
	end
end

function BGAssist_CountPlayers()
	local players = GetNumBattlefieldScores();
	if (players > 0) then
		local i;
		BGAssist_CountedPlayers = {
			["Horde"] = {
				["count"] = 0,
				[CLASS_DRUID] = 0, [CLASS_HUNTER] = 0, [CLASS_MAGE] = 0,
				[CLASS_PRIEST] = 0, [CLASS_ROGUE] = 0, [CLASS_SHAMAN] = 0,
				[CLASS_WARRIOR] = 0, [CLASS_WARLOCK] = 0,
			},
			["Alliance"] = {
				["count"] = 0,
				[CLASS_DRUID] = 0, [CLASS_HUNTER] = 0, [CLASS_MAGE] = 0,
				[CLASS_PALADIN] = 0, [CLASS_PRIEST] = 0, [CLASS_ROGUE] = 0,
				[CLASS_WARRIOR] = 0, [CLASS_WARLOCK] = 0,
			},
		};

		for i = 1, players, 1 do
			_, _, _, _, _, faction, _, _, class = GetBattlefieldScore(i);
			if (faction == 0) then faction = "Horde"; else faction = "Alliance"; end
			BGAssist_CountedPlayers[faction].count = BGAssist_CountedPlayers[faction].count + 1;
			BGAssist_CountedPlayers[faction][class] = BGAssist_CountedPlayers[faction][class] + 1;
		end

		local faction = { "Alliance", "Horde" };
		local classes = { CLASS_WARRIOR, CLASS_MAGE, CLASS_ROGUE, CLASS_DRUID, CLASS_HUNTER,
			CLASS_PRIEST, CLASS_WARLOCK, CLASS_SHAMAN };
		local i, j
		for i = 1, 2, 1 do
			for j = 1, 8, 1 do
				if (i == 1 and j == 8) then
					getglobal("WorldStateScoreFrame_"..faction[i]..j.."Text"):SetText(CLASS_PALADIN..": "..BGAssist_CountedPlayers[faction[i]][CLASS_PALADIN]);
				else
					getglobal("WorldStateScoreFrame_"..faction[i]..j.."Text"):SetText(classes[j]..": "..BGAssist_CountedPlayers[faction[i]][classes[j]]);
				end
			end
		end
	end
end


function BGAssist_SignUpForBG(...)
	local i;
	local idx = 0;
	for i = 1, arg.n, 2 do
		idx = idx + 1;
		if (arg[i] == BATTLEGROUND_GOSSIP_TEXT) then
			SelectGossipOption(idx);
		end
	end
end

function BGAssist_AutomaticBGEntry(data)
	local i;
	local inbg = nil;
	for i = 1, MAX_BATTLEFIELD_QUEUES, 1 do
		local tmpstatus, tmpmapName, tmpinstanceID = GetBattlefieldStatus(i)
		if (tmpstatus == "active") then
			data = nil;
			inbg = true;
		elseif (not inbg and tmpstatus == "confirm") then
			data = i;
		end
	end
	if (not inbg and data) then
		local status, mapName, instanceID = GetBattlefieldStatus(data)
		local goodtoenter = data;
		if (((BGAssist_Config.avoidpreexistingwarsong and
			mapName == WARSONGGULCH) or
			(BGAssist_Config.avoidpreexistingarathi and
			mapName == ARATHIBASIN )) and
			BGAssist_PreExistingInstances and
			BGAssist_PreExistingInstances[instanceID]) then
			local timediff = GetTime() - BGAssist_PreExistingInstances[instanceID];
			if (timediff < 300) then
				goodtoenter = false;
				DEFAULT_CHAT_FRAME:AddMessage("BGAssist: "..DISPLAY_TEXT_PREEXISTING);
			end
		end
		if (data and goodtoenter and not BGAssist_Config.noautoenter) then
			if (BGAssist_InAFK) then
				DEFAULT_CHAT_FRAME:AddMessage("BGAssist: "..DISPLAY_TEXT_NOTENTERINGAFK);
			elseif (not (UnitIsDead("player") or UnitIsGhost("player"))) then
				StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY");
				AcceptBattlefieldPort(data, 1);
			end
		end
	end
end

function BGAssist_ToggleAutoEntry(force)
	local current;
	if (StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"].OnShow) then
		current = true;
	end
	if (force == "ON" or (not current and force ~= "OFF")) then
		StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"].OnShow = function(data)
		BGAssist_AutomaticBGEntry(data);
		end
	elseif (force == "OFF" or (current and force ~= "ON")) then
		StaticPopupDialogs["CONFIRM_BATTLEFIELD_ENTRY"].OnShow = nil;
	end
end


function BGAssist_ClassBreakdown_OnLoad()
	WorldStateScoreFrame_Alliance1:ClearAllPoints();
	WorldStateScoreFrame_Alliance1:SetPoint("TOPRIGHT","WorldStateScoreFrame_Alliance","TOPRIGHT",-4,-4);
	WorldStateScoreFrame_Alliance8:SetTexCoord(0,0.25,0.5,0.75);

	local i;
	for i = 1, 8, 1 do
		getglobal("WorldStateScoreFrame_Alliance"..i.."Text"):ClearAllPoints();
		getglobal("WorldStateScoreFrame_Alliance"..i.."Text"):SetPoint("RIGHT","WorldStateScoreFrame_Alliance"..i,"LEFT",0,0);
	end



end


function BGAssist_Console( msg )

	-- Options
	if ( msg == "debug" ) then
		if (BGA_debug) then
			BGA_debug = false;
			DEFAULT_CHAT_FRAME:AddMessage("DEBUG: off");
		else
			BGA_debug = true;
			DEFAULT_CHAT_FRAME:AddMessage("DEBUG: on");
		end
	elseif ( msg == "center" ) then
		BGAssist_Timers:SetPoint("TOPLEFT", 300, -300);

	elseif ( msg == "reset" ) then
		BGAssist_Reset();

	else
		if (BGAssist_Timers:IsVisible()) then
			BGAssist_Timers:Hide();
		else
			BGAssist_Timers:Show();
		end
	end
end

function Debug_msg(msg)
	if BGA_debug then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end;
end

--***********************************************************
-- START ABTimeLeft functions
--***********************************************************

-- Update the text display on the top of the screen for a team
function BGAssist_ABTimeLeft_UpdateStatus(team,textFrame,timePassed)
	local bases, res;

	if lastBases[team] == nil then
		Debug_msg("warning, lastBases of team"..team.." was nil");
		lastBases[team] = -1;
	end
	if lastRes[team] == nil then
		Debug_msg("warning, lastRes of team"..team.." was nil");
		lastRes[team] = -1;
	end


	-- extract current bases and resources from it
	bases = Glory:GetNumBases(team+1);
	res   = Glory:GetNumTeamResources(team+1);

	if(bases == nil or bases == -1) then return; end;
	bases = tonumber(bases);
	if(res == nil) then res = -1; end;
	res = tonumber(res);

	-- if something changed, always go with this count instead of our clock estimate
	if(bases ~= lastBases[team]) then
		Debug_msg("something changed for team".. team ..", bases: ".. bases..", lastBases: "..lastBases[team]);

		-- no bases, it will take infinity for you to win
		if(bases == 0) then
			textFrame:SetText( INFINITY );
		-- yes bases, calculate time to win based on known rates
		else
--			Debug_msg("ttv team"..team..": "..  formatTime(Glory:GetTeamTTV(team+1)));
			textFrame:SetText( formatTime(Glory:GetTeamTTV(team+1)) );
		end

		local selfTeam, otherTeam;
		local stateidx = { ["Alliance"] = 0, ["Horde"] = 1 };

		Debug_msg("Alliance: team"..stateidx["Alliance"]);
		Debug_msg("Horde: team"..stateidx["Horde"]);

		--local msgTarget = "BATTLEGROUND";
		local msgTarget = "SAY";

		selfTeam = stateidx[selfFaction];
		if selfTeam == 0 then
			otherTeam = 1;
		else
			otherTeam = 0;
		end

		if selfTeam == nil then
			Debug_msg("OMG! selfTeam ist nil!");
			selfFaction = UnitFactionGroup("player");
			selfTeam = stateidx[selfFaction];
			if selfTeam == 0 then
				otherTeam = 1;
			else
				otherTeam = 0;
			end
		end

		timediff = Glory:GetTeamTTV(selfTeam+1) - Glory:GetTeamTTV(otherTeam+1);
		basediff = bases - lastBases[team];

		if (basediff == 1) then
			-- a base was captured
			if selfTeam == team then
				-- we did it
				if (timediff > 0) then
					-- loosing
					SendChatMessage("<BGAssist> WE captured a base but WE will still LOOSE in "..formatTime(Glory:GetTeamTTV(otherTeam+1)).." !", msgTarget);
				else
					-- winning
					SendChatMessage("<BGAssist> WE captured a base and WE will WIN in "..formatTime(Glory:GetTeamTTV(selfTeam+1)).." !", msgTarget);
				end
			else
				-- enemy did it
				if (timediff > 0) then
					-- loosing
					SendChatMessage("<BGAssist> ENEMY captured a base and WE will LOOSE in "..formatTime(Glory:GetTeamTTV(otherTeam+1)).." !", msgTarget);
				else
					-- winning
					SendChatMessage("<BGAssist> ENEMY captured a base but WE will still WIN in "..formatTime(Glory:GetTeamTTV(selfTeam+1)).." !", msgTarget);
				end
			end
--		elseif (basediff == -1) then
--			-- lost a base
--			if selfTeam == team then
--				-- we lost it
--				if (timediff > 0) then
--					-- loosing
--					SendChatMessage("<BGAssist> WE lost a base and WE will LOOSE in "..formatTime(Glory:GetTeamTTV(otherTeam+1)).." !", msgTarget);
--				else
--					-- winning
--					SendChatMessage("<BGAssist> WE lost a base but WE will still WIN in "..formatTime(Glory:GetTeamTTV(selfTeam+1)).." !", msgTarget);
--				end
--			else
--				-- enemy lost it
--				if (timediff > 0) then
--					-- loosing
--					SendChatMessage("<BGAssist> ENEMY lost a base but WE will still LOOSE in "..formatTime(Glory:GetTeamTTV(otherTeam+1)).." !", msgTarget);
--				else
--					-- winning
--					SendChatMessage("<BGAssist> ENEMY lost a base and WE will WIN in "..formatTime(Glory:GetTeamTTV(selfTeam+1)).." !", msgTarget);
--				end
--			end
		end


		-- reset our clock and keep track of our stuff
		lastBases[team] = bases;
		lastRes[team] = res;

		-- update the tooltip if we are currently viewing it
		if(BGAssist_ABTimeLeft_Frame1_Tooltip:IsVisible()) then
			BGAssist_ABTimeLeft_UpdateTooltip(0,BGAssist_ABTimeLeft_Frame1_Tooltip,BGAssist_ABTimeLeft_Frame1);
		elseif(BGAssist_ABTimeLeft_Frame2_Tooltip:IsVisible()) then
			BGAssist_ABTimeLeft_UpdateTooltip(1,BGAssist_ABTimeLeft_Frame2_Tooltip,BGAssist_ABTimeLeft_Frame2);
		end

	-- don't bother keeping track of our clock if we have no bases
	elseif(bases == 0) then

	-- if there is nothing else interesting to do, keep an estimate with our clock
	else
		textFrame:SetText( formatTime(Glory:GetTeamTTV(team+1)) );
	end
end
-- Alliance tooltip mouseover
function BGAssist_ABTimeLeft_Frame1_OnEnter()
	BGAssist_ABTimeLeft_UpdateTooltip(0,BGAssist_ABTimeLeft_Frame1_Tooltip,BGAssist_ABTimeLeft_Frame1);
end
-- Horde tooltip mouseover
function BGAssist_ABTimeLeft_Frame2_OnEnter()
	BGAssist_ABTimeLeft_UpdateTooltip(1,BGAssist_ABTimeLeft_Frame2_Tooltip,BGAssist_ABTimeLeft_Frame2);
end

-- Update a mouseover tooltip for a team
function BGAssist_ABTimeLeft_UpdateTooltip(team,tooltipFrame,ownerFrame)
	local otherTeam = 0;
	if(team == 0) then otherTeam = 1; end

	-- position tooltip
	tooltipFrame:ClearAllPoints();
	tooltipFrame:SetOwner(ownerFrame,"ANCHOR_NONE");
	tooltipFrame:SetPoint("CENTER",ownerFrame,"BOTTOMLEFT",-74,-12);

	-- add header
	tooltipFrame:AddLine( END_OF_GAME );

	-- this team is not getting any res, so its final res is its current res
	if(lastBases[team] == 0) then

		-- extract current bases and resources from it
		bases = Glory:GetNumBases(team+1);
		res   = Glory:GetNumTeamResources(team+1);

		if(bases == nil) then bases=-1; end;
		bases = tonumber(bases);
		if(res == nil) then res = -1; end;
		res = tonumber(res);

		if(finalRes == nil) then return; end

		local finalRep = math.floor(finalRes / 200) * 10;

		AddDoubleLine_Colored(tooltipFrame,RESOURCES .. ":",finalRes);
		AddDoubleLine_Colored(tooltipFrame,REPUTATION .. ":",finalRep);

	-- this team has less time left or the other team has no bases (exception because their time left will be -1)
	elseif(Glory:GetTeamTTV(team+1) <= Glory:GetTeamTTV(otherTeam+1) or lastBases[otherTeam] == 0) then
		AddDoubleLine_Colored(tooltipFrame,RESOURCES .. ":",2000);
		AddDoubleLine_Colored(tooltipFrame,REPUTATION .. ":",100);

	-- this team is losing and everyone has bases
	else

		-- extract current bases and resources from it
		bases = Glory:GetNumBases(team+1);
		res   = Glory:GetNumTeamResources(team+1);

		if(bases == nil) then return; end
		bases = tonumber(bases);
		if(res == nil) then res = 0; end;
		res = tonumber(res);

		local finalRes = res + math.floor(Glory:GetTeamTTV(otherTeam+1) * resPerSecond(bases));
		finalRes = math.floor(finalRes / 10) * 10;

		local finalRep = math.floor(finalRes / 200) * 10;

		AddDoubleLine_Colored(tooltipFrame,RESOURCES .. ":",finalRes);
		AddDoubleLine_Colored(tooltipFrame,REPUTATION .. ":",finalRep);
	end

	tooltipFrame:Show();
end

-- Add a doubleline to our tooltip with color formatting
function AddDoubleLine_Colored(tooltipFrame,column1,column2)
	tooltipFrame:AddDoubleLine( column1 ,  column2 );
end

-- Return the resources earned per second for different amounts of bases captured
function resPerSecond(bases)
	local value = 0.0;

	if(bases == "1") then
		value = 25.0 / 30.0;	-- 25 res per 30 sec
	elseif(bases == "2") then
		value = (300.0 / 9.0) / 30.0; -- 33.3(repeating) per 30 sec
	elseif(bases == "3") then
		value = 50.0  / 30.0;	-- 50 res per 30 sec
	elseif(bases == "4") then
		value = 100.0 / 30.0;	-- 100 res per 30 sec
	elseif(bases == "5") then
		value = 900.0 / 30.0;	-- 900 res per 30 sec
	end

	return value;
end

-- Formats the time in an hour, minute, second format from pure seconds
function formatTime(session)
	local hours, minutes, seconds;
	seconds = math.floor(session);

	if(seconds >= 60) then
		minutes = math.floor(seconds / 60);
		seconds = seconds - (60 * minutes);
	else
		minutes = 0;
	end

	if(minutes >= 60) then
		hours = math.floor(minutes / 60);
		minutes = minutes - (60 * hours);
	else
		hours = 0;
	end

local string = "";

	if(hours > 0) then
		string = string .. hours .. "h ";
	end
	if(session >= 60) then
		string = string .. minutes .. "m ";
	end

	string = string .. seconds .. "s";
	return string;
end
