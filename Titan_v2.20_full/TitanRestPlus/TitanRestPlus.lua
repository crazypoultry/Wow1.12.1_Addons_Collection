--[[
		ADDON  INFORMATION
		Name: TitanRestPlus
		Purpose: Keeps track of the RestXP amounts and status for all of your characters.
		Command-line: /restplus help
		Author: Dsanai of The Crimson Knights on Whisperwind

TitanRestPlus keeps track of the RestXP amounts and status for all of your characters.

TitanRestPlus is a RestXP-displaying Titan plugin that features a compact and customizable display. It has been coded especially to assist players who have characters on more than one server -- for this reason, the display is very compact (allowing more characters to be shown than similar mods can), and it groups and sorts characters by server (with the current server displayed at the top of the list). The list is colorized based on the state of each character's Rest level.

TitanRestPlus saves information about your characters' experience (XP) and rest XP at logout. It uses this information to calculate the amount of rest experience accumulated for any of your characters at any time. This is accomplished using simple arithmetic: Every X hours you get 5% of the experience required to reach your next level, until you hit the cap of 150%. X is 8 hours if you are logged out in a resting state, and 32 if you are not.

The addon alerts you when one of your characters has enough rest XP to last until the end of their current level, and also when one of the characters has reached the rest XP cap.

This mod is based off of Wraith's RestXP. Since that mod has not been updated in a very long time (March/June 05), I have created this offshoot mod which I plan to continue maintaining. Thanks for the base code, and Rest calculation mathematics, goes to the author of Wraith RestXP, Shadow Wraith. Thanks also go to Kipple for the updated and Titan-enhanced version that I worked from.

THINGS I'VE CHANGED (From Wraith's version)
-- Better multi-server support.
-- More compact display.
-- Level 60 bar label.
-- Sorting and grouping by servers.
-- Merged Titan and base code; no longer resides in two separate addons.
-- Miscellaneous display changes, for clarity and general asthetics.

FEATURES
-- Displays a list of all your characters and their RestXP information.
-- Sorts current server's characters to the top of the list.
-- Groups characters by server (with or without server labels enabled).
-- Colorizes character names so you know which ones are maxed, which can reach the next level, and which cannot.
-- Very compact display allows for more characters than similar addons can show.
-- Can display raw or percentage formats for XP, Rest, and/or the Titan button.
-- Can hide or display Server names, character classes, and/or levels.
-- Level 60 characters are supported by showing a "Maxed Experience" label in the tooltip display.
-- Can toggle the Titan bar display to show the icon, label text, both, or neither.

VERSION HISTORY

v11100-1
-- Updated for Patch 1.11.

v10900-1
-- Initial release

]]

RESTPLUS_VERSION = "11100-1";

RESTPLUS_SOUND_LEVEL = "LEVELUPSOUND"; -- Sound to play when CurrentXP + RestPlus >= NextXP
RESTPLUS_SOUND_CAPPED = "QUESTADDED"; -- Sound to play when RestPlus >= 1.5*NextXp

RESTPLUS_DELAY = 1800; -- check every 30 min
RESTPLUS_COLOR = "magenta";
RESTPLUS_COLOR_SIXTY = "cyan";
RESTPLUS_COLOR_NORMAL = "green";
RESTPLUS_COLOR_LEVEL = "yellow";
RESTPLUS_COLOR_CAPPED = "red";
RESTPLUS_COLOR_ACTIVESERVER = "offwhite";
RESTPLUS_COLOR_OTHERSERVER = "grey";


RESTPLUS_ALERTSTATUS_NORMAL = 0;
RESTPLUS_ALERTSTATUS_LEVEL = 1;
RESTPLUS_ALERTSTATUS_CAPPED = 2;

-- This will be used to store the final result of information processing and sorting.
RestPlus_ToPrint = {};
RestPlus_ToPrintIndex = 0;
RestPlus_ToPrintColor = {};
RestPlus_ActiveCharXP = "";
RestPlus_ActiveCharXPRaw = "";
RestPlus_ActiveCharColor = "";
RestPlus_ActiveCharIndex = "";
RestPlus_RealmList = {};

TITAN_RESTPLUS_ID =  "RestPlus";
TITAN_RESTPLUS_ACTIVE_FORMAT = "%s";
TITAN_RESTPLUS_FREQUENCY = 5;
TITAN_RESTPLUS_ICON = "Interface\\Icons\\Spell_Holy_BlessingOfStamina";

local u = {};
local RestTimer = 0;
local ShowActiveChar = true;

function RestPlus_OnLoad()
	u = Utility_Class:New();
	
	this:RegisterEvent("PLAYER_UPDATE_RESTING");
	this:RegisterEvent("PLAYER_XP_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");

	SlashCmdList["RestPlus"] = function(msg)
		RestPlus_Command(msg);
	end
	SLASH_RestPlus1 = "/restplus";
	
	SlashCmdList["RestLog"] = RestPlus_Logout;
	SLASH_RestLog1 = "/log";

	RestPlus_LoadData();
	
	u:Print(RESTPLUS_LOADED, RESTPLUS_COLOR);
end

function TitanPanelRestPlusButton_OnLoad()
	this.registry = { 
		id = TITAN_RESTPLUS_ID,
		menuText = TITAN_RESTPLUS_MENU_TEXT,
		buttonTextFunction = "TitanPanelRestPlusButton_GetButtonText", 
		tooltipTitle = TITAN_RESTPLUS_TOOLTIP,
		tooltipTextFunction = "TitanPanelRestPlusButton_GetTooltipText",
		icon = TITAN_RESTPLUS_ICON,
		iconWidth = 16,
		savedVariables = {
			ShowLabelText = 1,
			ShowIcon = 1,
		}
	};
	
	this:RegisterEvent("PLAYER_UPDATE_RESTING");
	this:RegisterEvent("PLAYER_XP_UPDATE");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	
	u = Utility_Class:New();
end

function TitanPanelRestPlusButton_OnEvent()
	TitanPanelButton_UpdateButton(TITAN_RESTPLUS_ID);
end

function TitanPanelRestPlusButton_GetButtonText(id)
	local button, id = TitanUtils_GetButton(id, true);
	local playerLevel = UnitLevel("player");
	RestPlus_SaveCharacter();
	RestPlus_Sort();
		
	local activeText = "";
	if(RestPlus_Settings.PctActive) then
		activeText = format(TITAN_RESTPLUS_ACTIVE_FORMAT, RestPlus_ActiveCharXP);
	else
		activeText = format(TITAN_RESTPLUS_ACTIVE_FORMAT, RestPlus_ActiveCharXPRaw);
	end
	if (playerLevel and playerLevel < 60) then -- EMERALD
		return TITAN_RESTPLUS_BUTTON_LABEL, TitanUtils_GetColoredText(activeText, u.ColorList[string.lower(RestPlus_ActiveCharColor)]);
	else
		return TITAN_RESTPLUS_BUTTON_LABEL, TitanUtils_GetColoredText("Rest+", u.ColorList["yellow"]);
	end
end

function TitanPanelRestPlusButton_GetTooltipText()

	local i;
	local value = "";
	local thisRealm = "";
	local thisColor = {};
	
	RestPlus_SaveCharacter();
	RestPlus_Sort();
	
	for i = 0, RestPlus_ToPrintIndex - 1 do
		if (strfind(RestPlus_ToPrint[i],"\t")) then -- CHARACTER
			local first = strsub(RestPlus_ToPrint[i], 1, strfind(RestPlus_ToPrint[i], "\t", 1) - 1);
			local last = strsub(RestPlus_ToPrint[i], strfind(RestPlus_ToPrint[i], "\t", 1) + 1);
			--value = value..TitanUtils_GetColoredText(first, u.ColorList[string.lower(RestPlus_ToPrintColor[i])]).."\t"..TitanUtils_GetColoredText(last, u.ColorList[string.lower(RestPlus_ToPrintColor[i])]).."\n";
			if (RestPlus_Settings.ShowRealms) then
				value = value..thisRealm..TitanUtils_GetColoredText(first, u.ColorList[string.lower(RestPlus_ToPrintColor[i])]).."\t"..TitanUtils_GetColoredText(last, u.ColorList[string.lower(RestPlus_ToPrintColor[i])]).."\n";
			else
				value = value..TitanUtils_GetColoredText(first, u.ColorList[string.lower(RestPlus_ToPrintColor[i])]).."\t"..TitanUtils_GetColoredText(last, u.ColorList[string.lower(RestPlus_ToPrintColor[i])]).."\n";
			end
		else -- REALM
			--value = value..TitanUtils_GetColoredText("Realm: ", u.ColorList[string.lower("white")]).."\t"..TitanUtils_GetColoredText(RestPlus_ToPrint[i], u.ColorList[string.lower(RestPlus_ToPrintColor[i])]).."\n";
			thisRealm = RestPlus_ToPrint[i]..": "; -- Only store this, to use inline with the characters.
			if (string.lower(RestPlus_ToPrintColor[i])=="grey") then
				thisColor = { r = 0.6, g = 0.6, b = 0.6 };
			elseif (string.lower(RestPlus_ToPrintColor[i])=="offwhite") then
				thisColor = { r = 0.85, g = 0.85, b = 0.85 };
			else
				thisColor = u.ColorList[string.lower(RestPlus_ToPrintColor[i])];
			end
			thisRealm = TitanUtils_GetColoredText(thisRealm, thisColor);
		end
	end
	
	return value;	
end

function TitanPanelRightClickMenu_PrepareRestPlusMenu()
	local info;

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_RESTPLUS_ID].menuText);	
	
	info = {};
	info.text = TITAN_RESTPLUS_TOGGLE_REALM;
	info.func = TitanPanelRestPlusButton_ToggleRealm;
	info.checked = RestPlus_Settings.ShowRealms;
	UIDropDownMenu_AddButton(info); 
	
	info = {};
	info.text = TITAN_RESTPLUS_TOGGLE_CLASS;
	info.func = TitanPanelRestPlusButton_ToggleClass;
	info.checked = RestPlus_Settings.ShowClass;
	UIDropDownMenu_AddButton(info); 	
	
	info = {};
	info.text = TITAN_RESTPLUS_TOGGLE_STATE;
	info.func = TitanPanelRestPlusButton_ToggleState;
	info.checked = RestPlus_Settings.ShowState;
	UIDropDownMenu_AddButton(info); 

	TitanPanelRightClickMenu_AddSpacer();	
	
	info = {};
	info.text = TITAN_RESTPLUS_TOGGLE_RESTXP;
	info.func = TitanPanelRestPlusButton_ToggleRestXP;
	info.checked = RestPlus_Settings.PctRestXP;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = TITAN_RESTPLUS_TOGGLE_XP;
	info.func = TitanPanelRestPlusButton_ToggleXP;
	info.checked = RestPlus_Settings.PctExp;
	UIDropDownMenu_AddButton(info);	
	
	info = {};
	info.text = TITAN_RESTPLUS_TOGGLE_ACTIVE;
	info.func = TitanPanelRestPlusButton_ToggleActive;
	info.checked = RestPlus_Settings.PctActive;
	UIDropDownMenu_AddButton(info);	

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_RESTPLUS_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_RESTPLUS_ID);

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_RESTPLUS_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelRestPlusButton_ToggleRealm()
	RestPlus_Settings.ShowRealms = not RestPlus_Settings.ShowRealms;
end

function TitanPanelRestPlusButton_ToggleClass()
	RestPlus_Settings.ShowClass = not RestPlus_Settings.ShowClass;
end

function TitanPanelRestPlusButton_ToggleState()
	RestPlus_Settings.ShowState = not RestPlus_Settings.ShowState;
end

function TitanPanelRestPlusButton_ToggleRestXP()
	RestPlus_Settings.PctRestXP = not RestPlus_Settings.PctRestXP;
end

function TitanPanelRestPlusButton_ToggleXP()
	RestPlus_Settings.PctExp = not RestPlus_Settings.PctExp;
end

function TitanPanelRestPlusButton_ToggleActive()
	RestPlus_Settings.PctActive = not RestPlus_Settings.PctActive;
	TitanPanelButton_UpdateButton(TITAN_RESTPLUS_ID);
end

function RestPlus_OnUpdate()
	if RestPlus_Settings.EnableTimer then
		if (not RestTimer) then
			RestTimer = RestPlus_Settings.TimerDelay;		
		end
		if (RestTimer > 0) then 
			RestTimer = RestTimer - arg1;
		else
			RestPlus_AlertCheck();
			RestTimer = RestPlus_Settings.TimerDelay;
		end
	end
end

function RestPlus_OnEvent(event)
	if ( event == "PLAYER_UPDATE_RESTING" ) or ( event == "PLAYER_XP_UPDATE" ) 
		or ( event == "PLAYER_ENTERING_WORLD" ) then
		if ( UnitName("player") ~= UNKNOWNOBJECT ) then
			RestPlus_SaveCharacter();
		end
	end
end

function RestPlus_Command(msg)
	local args={};
	local counter=0;
	local i=0;	

	for w in string.gfind(msg, "[%w']+") do
		counter=counter+1;
		args[counter]=string.lower(w);
	end
	
	if (args[1]=="save") then
		RestPlus_SaveCharacter();
	elseif (args[1]=="reset") then
		RestPlus_Data = { };
		u:Print(RESTPLUS_RESET, RESTPLUS_COLOR);
	elseif (args[1]=="remove") then	
		if(args[2]) and (args[3]) then	
			-- Make sure names are properly capitalized.
			args[2] = gsub(args[2], "%l", string.upper, 1)
			args[3] = gsub(args[3], "%l", string.upper, 1)
			if(args[4]) then
				-- Realm name is made up of two words.
				args[4] = gsub(args[4], "%l", string.upper, 1)
				args[3] = args[3].." "..args[4];
			end
			local index = args[2].."="..args[3];
			if(RestPlus_Data[index]) then
				RestPlus_Data[index] = nil;
				u:Print(RESTPLUS_CHAR_REMOVED..args[2]..", "..args[3]);			
			else
				u:Print(index..": "..RESTPLUS_NOCHAR);
			end
		else
			u:Print(RESTPLUS_INSUFFICIENT_ARGS);
		end
	elseif (args[1]=="help") then
		u:Print(RESTPLUS_HELP1, RESTPLUS_COLOR);
		u:Print(RESTPLUS_HELP2, RESTPLUS_COLOR);
		u:Print(RESTPLUS_HELP3, RESTPLUS_COLOR);
		u:Print(RESTPLUS_HELP4, RESTPLUS_COLOR);
		u:Print(RESTPLUS_HELP5, RESTPLUS_COLOR);
		u:Print(RESTPLUS_HELP6, RESTPLUS_COLOR);
		u:Print(RESTPLUS_HELP7, RESTPLUS_COLOR);
		u:Print(RESTPLUS_HELP8, RESTPLUS_COLOR);
		u:Print(RESTPLUS_HELP9, RESTPLUS_COLOR);
		u:Print(RESTPLUS_HELP10, RESTPLUS_COLOR);
		u:Print(RESTPLUS_HELP11, RESTPLUS_COLOR);
	elseif (args[1]=="sound") then
		if (RestPlus_Settings.EnableSound) then
			RestPlus_Settings.EnableSound = false;
			u:Print(RESTPLUS_SOUND..RESTPLUS_OFF,RESTPLUS_COLOR);
		else
			RestPlus_Settings.EnableSound = true;
			u:Print(RESTPLUS_SOUND..RESTPLUS_ON,RESTPLUS_COLOR);
		end
	elseif (args[1]=="timer") then
		if (RestPlus_Settings.EnableTimer) then
			RestPlus_Settings.EnableTimer = false;
			u:Print(RESTPLUS_TIMER..RESTPLUS_OFF,RESTPLUS_COLOR);
		else
			RestPlus_Settings.EnableTimer = true;
			u:Print(RESTPLUS_TIMER..RESTPLUS_ON,RESTPLUS_COLOR);
		end
	elseif (args[1]=="delay") then
		if (args[2]) and (tonumber(args[2])) and (tonumber(args[2]) > 0) then
			RestPlus_Settings.TimerDelay = tonumber(args[2]);
			u:Print(RESTPLUS_DELAY_MSG..args[2].."초.");
		else
			u:Print(RESTPLUS_INVALID_TIME);
		end
	elseif (args[1]=="recycle") then
		RestPlus_DefaultOptions();
	else
		RestPlus_AlertCheck();
		RestPlus_DisplayChatList();
	end
end

function RestPlus_DefaultOptions()
		RestPlus_Settings = {};
		RestPlus_Settings.EnableSound = true;
		RestPlus_Settings.EnableTimer = true;
		RestPlus_Settings.TimerDelay = RESTPLUS_DELAY;
		RestPlus_Settings.ShowRealms = true;
		RestPlus_Settings.ShowClass = true;
		RestPlus_Settings.ShowState = true;
		RestPlus_Settings.PctExp = true;
		RestPlus_Settings.PctRestXP = true;	
		RestPlus_Settings.PctActive = true;
end

function RestPlus_LoadData()
	if (not RestPlus_Data) then
		RestPlus_Data = { };
	end
	if(not RestPlus_Settings) or (RestPlus_Settings.TimerDelay == nil) then
		RestPlus_DefaultOptions();
	end
	if(RestPlus_Settings.ShowRealms == nil) then
		RestPlus_Settings.ShowRealms = true;	
	end
	if(RestPlus_Settings.ShowClass == nil) then
		RestPlus_Settings.ShowClass= true;	
	end
	if(RestPlus_Settings.ShowState == nil) then
		RestPlus_Settings.ShowState = true;	
	end
	if(RestPlus_Settings.PctExp == nil) then
		RestPlus_Settings.PctExp = true;	
	end	
	if(RestPlus_Settings.PctRestXP == nil) then
		RestPlus_Settings.PctRestXP = true;	
	end	
	if(RestPlus_Settings.PctActive == nil) then
		RestPlus_Settings.PctActive = true;	
	end	
	if(RestPlus_Settings.TimerDelay == nil) then
		RestPlus_Settings.TimerDelay = RESTPLUS_DELAY;	
	end	
end

function RestPlus_Logout()
	RestPlus_SaveCharacter();
	Logout();
end

function RestPlus_ShortClass(class)
--	if (class == "Druid") then return "Dru";				-- techys (from here)
--	elseif (class == "Hunter") then return "Hun";
--	elseif (class == "Mage") then return "Mag";	
--	elseif (class == "Priest") then return "Pri";
--	elseif (class == "Paladin") then return "Pal";
--	elseif (class == "Rogue") then return "Rog";		
--	elseif (class == "Shaman") then return "Sha";		
--	elseif (class == "Warrior") then return "War";		
--	elseif (class == "Warlock") then return "Wck";		
	if (class == "드루이드") then return "드루";
	elseif (class == "사냥꾼") then return "냥꾼";
	elseif (class == "마법사") then return "법사";	
	elseif (class == "사제") then return "사제";
	elseif (class == "성기사") then return "기사";
	elseif (class == "도적") then return "도적";		
	elseif (class == "주술사") then return "술사";
	elseif (class == "전사") then return "전사";
	elseif (class == "흑마법사") then return "흑마";		-- techys (until here)
	end
end

function RestPlus_SaveCharacter()

	for index in RestPlus_Data do
		-- This is conversion code to move to the new separator, '='
		if (strfind(index, "|")) then
			local oldindex = index;
			index = gsub(index, "|", "=");
			RestPlus_Data[index] = RestPlus_Data[oldindex];
			RestPlus_Data[oldindex] = nil;
		end
		-- Remove any accidental unknown entities
		if(RestPlus_PlayerName(index) == UNKNOWNOBJECT) then
			RestPlus_Data[index] = nil;
		end
	end
	local index = UnitName("player").."="..GetCVar("realmName");
	RestPlus_Data[index] = { level=0 };
	RestPlus_Data[index] = { currXP=0 };
	RestPlus_Data[index] = { nextXP=0 };
	RestPlus_Data[index] = { restXP=0 };
	RestPlus_Data[index] = { resting=0 };
	RestPlus_Data[index] = { logtime=0 };
	RestPlus_Data[index] = { class=0 };
	RestPlus_Data[index].level = UnitLevel("player");
	RestPlus_Data[index].class = RestPlus_ShortClass(UnitClass("player"));
	RestPlus_Data[index].currXP = UnitXP("player");
	RestPlus_Data[index].nextXP = UnitXPMax("player");
	RestPlus_Data[index].restXP = GetXPExhaustion();
	if (RestPlus_Data[index].restXP == nil) then -- GetXPExhaustion returns nil instead of 0
		RestPlus_Data[index].restXP = 0;
	end
	RestPlus_Data[index].resting = IsResting();
	RestPlus_Data[index].logtime = RestPlus_GetTime();
	--u:Print(RESTPLUS_SAVE_CHAR, RESTPLUS_COLOR);
end

function RestPlus_GetTime()
	local MonthDays = {};
	local currTime = 0;
	MonthDays[1]=0;
	MonthDays[2]=31;
	MonthDays[3]=MonthDays[2]+28;
	MonthDays[4]=MonthDays[3]+31;
	MonthDays[5]=MonthDays[4]+30;
	MonthDays[6]=MonthDays[5]+31;
	MonthDays[7]=MonthDays[6]+30;
	MonthDays[8]=MonthDays[7]+31;
	MonthDays[9]=MonthDays[8]+31;
	MonthDays[10]=MonthDays[9]+30;
	MonthDays[11]=MonthDays[10]+31;
	MonthDays[12]=MonthDays[11]+30;
	local Days = tonumber(date("%d"));
	local Months = tonumber(date("%m"));
	local Years = tonumber(date("%y"));
	local hours = tonumber(date("%H"));
	local minutes = tonumber(date("%M"));
--	u:Print(Days.."/"..Months.."/"..Years.." "..hours..":"..minutes, RESTPLUS_COLOR);
	currTime = ((Years-5)*365 + MonthDays[Months] + Days-1)*24*60 + hours*60 + minutes;
	return currTime;
end

function RestPlus_PlayerName(index)
	local first, last = strfind(index, "=", 1);
	if first then -- found
		return strsub(index, 1, first-1);
	else
		return index;
	end
end

function RestPlus_RealmName(index)
	local first, last = strfind(index, "=", 1);
	if last then -- found
		return strsub(index, last + 1);
	else
		return RESTPLUS_UNKNOWN_REALM;
	end
end

function RestPlus_AlertCheck()
	RestPlus_SaveCharacter()
	local index;
	local currTime = RestPlus_GetTime();
	local EnableSound = RestPlus_Settings.EnableSound;
	for index in RestPlus_Data do
		if ( RestPlus_Data[index].resting ) then
			RestPlus = RestPlus_Data[index].restXP + RestPlus_Data[index].nextXP*(5/100)*((currTime-RestPlus_Data[index].logtime)/(60*8));
		else
			RestPlus = RestPlus_Data[index].restXP + RestPlus_Data[index].nextXP*(5/100)*((currTime-RestPlus_Data[index].logtime)/(60*32));
		end
		if ((RestPlus_Data[index].currXP + RestPlus) < RestPlus_Data[index].nextXP) then
			RestPlus_Data[index].AlertStatus = RESTPLUS_ALERTSTATUS_NORMAL;
		else
			if (RestPlus >= (1.5*RestPlus_Data[index].nextXP)) and (RestPlus_Data[index].AlertStatus ~= RESTPLUS_ALERTSTATUS_CAPPED) and (RestPlus_PlayerName(index) ~= UNKNOWNOBJECT) and (index ~= RestPlus_ActiveCharIndex) then
				u:Print(RestPlus_PlayerName(index)..RESTPLUS_MSG_CAPPED, RESTPLUS_COLOR_CAPPED);
				RestPlus_Data[index].AlertStatus = RESTPLUS_ALERTSTATUS_CAPPED;
				if (EnableSound) then
					PlaySound(RESTPLUS_SOUND_CAPPED);
					EnableSound = false;
				end
			else
				if ((RestPlus_Data[index].currXP + RestPlus) >= RestPlus_Data[index].nextXP) and (RestPlus_Data[index].AlertStatus == RESTPLUS_ALERTSTATUS_NORMAL) and (index ~= RestPlus_ActiveCharIndex) then
					u:Print(RestPlus_PlayerName(index)..RESTPLUS_MSG_LEVEL, RESTPLUS_COLOR_LEVEL);
					RestPlus_Data[index].AlertStatus = RESTPLUS_ALERTSTATUS_LEVEL;
					if (EnableSound) then
						PlaySound(RESTPLUS_SOUND_LEVEL);
						EnableSound = false;
					end
				end
			end
		end
	end
end

function RestPlus_Sort()
	local restXP = 0;
	local currTime = RestPlus_GetTime();
	local ActiveChar = UnitName("player").."="..GetCVar("realmName");
	local toSort = {};
	local toSortIndex = 0;
	for index in RestPlus_Data do
		local Name = RestPlus_PlayerName(index);
		local Realm = RestPlus_RealmName(index);
		local Level = RestPlus_Data[index].level;
		local strExp = "";
		if(RestPlus_Settings.PctExp) then
			strExp = format("%.2f%%",(tonumber(RestPlus_Data[index].currXP) / tonumber(RestPlus_Data[index].nextXP)) * 100);
		else
			strExp = format("%d", tonumber(RestPlus_Data[index].currXP));
		end
		local restXP = RestPlus_Data[index].restXP;
		local TimeLeft;
		local strResting;
		local strRestPlus;
		local strLeft = "";
		local StatusColor = RESTPLUS_COLOR_NORMAL;
		-- Logout at Inn (Yes/No) for 5%/8h or 5%/32h
		if ( currTime > RestPlus_Data[index].logtime ) then
			if ( RestPlus_Data[index].resting ) then
				restXP = restXP + RestPlus_Data[index].nextXP*(5/100)*((currTime-RestPlus_Data[index].logtime)/(60*8));
			else
				restXP = restXP + RestPlus_Data[index].nextXP*(5/100)*((currTime-RestPlus_Data[index].logtime)/(60*32));
			end
		end

		if ((RestPlus_Data[index].currXP + restXP) >= RestPlus_Data[index].nextXP) then
			StatusColor = RESTPLUS_COLOR_LEVEL;
		end
		if (restXP >= (1.5*RestPlus_Data[index].nextXP)) then
			restXP = 1.5*RestPlus_Data[index].nextXP;
			StatusColor = RESTPLUS_COLOR_CAPPED;
		else
			if ( RestPlus_Data[index].resting ) then
				TimeLeft = format("%.2f", (150 - (tonumber(restXP) / tonumber(RestPlus_Data[index].nextXP)) * 100)* 8 / 5);
			else
				TimeLeft = format("%.2f", (150 - (tonumber(restXP) / tonumber(RestPlus_Data[index].nextXP)) * 100)* 32 / 5);		
			end
			TimeLeft = tonumber(TimeLeft);
			local DaysLeft = "";
			if(TimeLeft > 24) then
				DaysLeft = format("%d", TimeLeft / 24);
				TimeLeft = TimeLeft - DaysLeft * 24;
				DaysLeft = DaysLeft..RESTPLUS_DAYS;
			end
			local whole = floor(TimeLeft);
			strLeft = format("(%s%d:%02d)", DaysLeft, whole, (TimeLeft - whole) * 60);
		end
		
		local Class = "";
		-- The following conditional is needed because the class field is a new addition.
		if(RestPlus_Data[index].class) then
			Class = RestPlus_Data[index].class;
		end
		
		strRestPlus = format("%.2f%%",(tonumber(restXP) / tonumber(RestPlus_Data[index].nextXP)) * 100);
		if(Level == 60) then
			strRestPlus = "000.01%";
		end
		
		if ( index == ActiveChar ) then 
			strResting = RESTPLUS_RESTING_ACTIVE;
			RestPlus_ActiveCharXP = strRestPlus;
			RestPlus_ActiveCharColor = StatusColor;
			RestPlus_ActiveCharXPRaw = format("%d", (tonumber(restXP) / 2));
			RestPlus_ActiveCharIndex = index;
		elseif ( RestPlus_Data[index].resting ) then
			strResting = RESTPLUS_RESTING_TRUE;
		else
			strResting = RESTPLUS_RESTING_FALSE;
		end
		
		local tempxp = strRestPlus;
		while (string.len(tempxp) < 7) do
			tempxp = "0"..tempxp; 
		end
		local tempstr = tempxp.."="..Name.." (";
		--if(RestPlus_Settings.ShowRealms) then
			--tempstr = tempstr..Realm..", ";
		--end
		if(RestPlus_Settings.ShowClass) then
			tempstr = tempstr..Class.." ";
		end		
		tempstr = tempstr.."L"..Level..") ";
		tempstr = tempstr.."\t";
		if(Level == 60) then
			-- The following is to prevent alerts for this character.
			RestPlus_Data[index].logtime = currTime;
			if(RestPlus_Settings.ShowState) then
				tempstr = tempstr..RESTPLUS_LEVEL60;
			end
			tempstr = tempstr.."="..RESTPLUS_COLOR_SIXTY;
		else
			if(RestPlus_Settings.ShowState) then
				tempstr = tempstr..strResting.." ";
			end
			if(not RestPlus_Settings.PctRestXP) then
				strRestPlus = format("%d", (tonumber(restXP) / 2));
			end
			tempstr = tempstr..strLeft.." "..strExp.." (+"..strRestPlus..")";
			tempstr = tempstr.."="..StatusColor;
		end
		RestPlus_RealmList[toSortIndex] = Realm; -- EMERALD
		toSort[toSortIndex] = tempstr;
		toSortIndex = toSortIndex + 1;
		--u:Print(Name.." ("..Realm.." L"..Level..") "..strExp.."(+"..strRestPlus..") "..strLeft.." "..strResting,StatusColor);
	end
	local i, j, min;
	
	for i = 0, toSortIndex - 1 do
		min = i;
		for j = i, toSortIndex - 1 do
			local a = strsub(toSort[j], 1, strfind(toSort[j], "=", 1) - 2);
			local b = strsub(toSort[min], 1, strfind(toSort[min], "=", 1) - 2);
			if(a < b) then
				min = j;
			end
		end
		local buf = toSort[i];
		toSort[i] = toSort[min];
		toSort[min] = buf;
		local buf2 = RestPlus_RealmList[i]; -- EMERALD
		RestPlus_RealmList[i] = RestPlus_RealmList[min];
		RestPlus_RealmList[min] = buf2;
	end
	
	RestPlus_ToPrintIndex = 0;
	-- EMERALD Start
		-- Get unique realms
		--local tempTableEmerald = table.sort(RestPlus_RealmList);
		local tempTableEmerald = RestPlus_RealmList;
		local tempTableRealms = {};
		local found = false;
		for key, tempRealm in tempTableEmerald do
			for key2, tempRealmCheck in tempTableRealms do
				if (tempRealm==tempRealmCheck) then
					found = true;
					break;
				end
			end
			if (not found) then table.insert(tempTableRealms, tempRealm); end
			found = false;
		end
		
		-- Sort current realm to top
		local thisRealm = GetRealmName();
		RestPlus_ToPrint[RestPlus_ToPrintIndex] = thisRealm;
		RestPlus_ToPrintColor[RestPlus_ToPrintIndex] = RESTPLUS_COLOR_ACTIVESERVER;
		RestPlus_ToPrintIndex = RestPlus_ToPrintIndex + 1;
		for i = toSortIndex - 1, 0, -1 do
			if (RestPlus_RealmList[i]==thisRealm) then
				RestPlus_ToPrint[RestPlus_ToPrintIndex] = "  "; -- EMERALD: Indent
				local first = strfind(toSort[i], "=", 1);
				RestPlus_ToPrint[RestPlus_ToPrintIndex] = strsub(toSort[i], first + 1);
				first = strfind (RestPlus_ToPrint[RestPlus_ToPrintIndex] , "=", 1);
				local color = strsub(RestPlus_ToPrint[RestPlus_ToPrintIndex] , first + 1);
				RestPlus_ToPrint[RestPlus_ToPrintIndex] = strsub(RestPlus_ToPrint[RestPlus_ToPrintIndex] , 1, first - 1);
				RestPlus_ToPrintColor[RestPlus_ToPrintIndex] = color;
				RestPlus_ToPrintIndex = RestPlus_ToPrintIndex + 1;
			end
		end
		-- Add other realms afterward
		for key, realmName in tempTableRealms do -- cycle Unique realms
			if (realmName ~= thisRealm) then
				RestPlus_ToPrint[RestPlus_ToPrintIndex] = realmName;
				RestPlus_ToPrintColor[RestPlus_ToPrintIndex] = RESTPLUS_COLOR_OTHERSERVER;
				RestPlus_ToPrintIndex = RestPlus_ToPrintIndex + 1;
				for i = toSortIndex - 1, 0, -1 do
					if (RestPlus_RealmList[i]==realmName) then
						RestPlus_ToPrint[RestPlus_ToPrintIndex] = "  "; -- EMERALD: Indent
						local first = strfind(toSort[i], "=", 1);
						RestPlus_ToPrint[RestPlus_ToPrintIndex] = strsub(toSort[i], first + 1);
						first = strfind (RestPlus_ToPrint[RestPlus_ToPrintIndex] , "=", 1);
						local color = strsub(RestPlus_ToPrint[RestPlus_ToPrintIndex] , first + 1);
						RestPlus_ToPrint[RestPlus_ToPrintIndex] = strsub(RestPlus_ToPrint[RestPlus_ToPrintIndex] , 1, first - 1);
						RestPlus_ToPrintColor[RestPlus_ToPrintIndex] = color;
						RestPlus_ToPrintIndex = RestPlus_ToPrintIndex + 1;
					end
				end
			end
		end
		
	-- EMERALD End
	-- for i = toSortIndex - 1, 0, -1 do
		-- local first = strfind(toSort[i], "=", 1);
		-- RestPlus_ToPrint[RestPlus_ToPrintIndex] = strsub(toSort[i], first + 1);
		-- first = strfind (RestPlus_ToPrint[RestPlus_ToPrintIndex] , "=", 1);
		-- local color = strsub(RestPlus_ToPrint[RestPlus_ToPrintIndex] , first + 1);
		-- RestPlus_ToPrint[RestPlus_ToPrintIndex] = strsub(RestPlus_ToPrint[RestPlus_ToPrintIndex] , 1, first - 1);		
		-- RestPlus_ToPrintColor[RestPlus_ToPrintIndex] = color;
		-- RestPlus_ToPrintIndex = RestPlus_ToPrintIndex + 1;
	-- end
end

function RestPlus_DisplayChatList()
	local i;
	RestPlus_Sort();
	for i = 0, RestPlus_ToPrintIndex - 1 do
		u:Print(RestPlus_ToPrint[i], RestPlus_ToPrintColor[i]);
	end
end

-- Class declarations
-- Utility class provides print (to the chat box) and echo (displays over your character's head).
-- Instantiate it and use the colon syntax.
-- Color is an optional argument.  You can either use one of 7 named colors
-- "red", "green", "blue", "yellow", "cyan", "magenta", "white" or
-- a table with the r, g, b values.
-- IE foo:Print("some text", {r = 1.0, g=1.0, b=.5})

-- if there is an existing Utility Class version of equal or greater version, don't declare.
if not Utility_Class or (not Utility_Class.version) or (Utility_Class.version < 1.02) then
	Utility_Class = {};
	Utility_Class.version = 1.02
	function Utility_Class:New ()
		local o = {}   -- create object
		setmetatable(o, self)
		self.__index = self
		return o
	end
	
	function Utility_Class:Print(msg, color)
	local text;
	local r, g, b;
		if msg == nil then return; end
		if color == nil then color = "white"; end
		if (color=="grey") then
			r = 0.6; g = 0.6; b = 0.6;
		elseif (color=="offwhite") then
			r = 0.85; g = 0.85; b = 0.85;
		else
			r, g, b = self.GetColor(color);
		end
		
		if( DEFAULT_CHAT_FRAME ) then
			DEFAULT_CHAT_FRAME:AddMessage(msg,r,g,b);
		end
		
	end
	
	function Utility_Class:Echo(msg, color)
	local text;
	local r, g, b;
		if msg == nil then return; end
		if color == nil then color = "white"; end
		r, g, b = self.GetColor(color);
		
		UIErrorsFrame:AddMessage(msg, r, g, b, 1.0, UIERRORS_HOLD_TIME);
		
	end
	
	function Utility_Class:GetColor(color)
		if color == nil then color = self; end
		if color == nil then return 0, 0, 0 end
	
		if type(color) == "string" then 
			color = Utility_Class.ColorList[string.lower(color)];
		end
		
		if type(color) == "table" then
			if color.r == nil then color.r = 0.0 end
			if color.g == nil then color.g = 0.0 end
			if color.b == nil then color.g = 0.0 end
		else
			return 0, 0, 0 
		end
	
		if color.r < 0 then color.r = 0.0 end
		if color.g < 0 then color.g = 0.0 end
		if color.b < 0 then color.g = 0.0 end
	
		if color.r > 1 then color.r = 1.0 end
		if color.g > 1 then color.g = 1.0 end
		if color.b > 1 then color.g = 1.0 end
		
		return color.r, color.g, color.b
		
	end
	
	Utility_Class.ColorList = {}
	Utility_Class.ColorList["red"] = { r = 1.0, g = 0.0, b = 0.0 }
	Utility_Class.ColorList["green"] = { r = 0.0, g = 1.0, b = 0.0 }
	Utility_Class.ColorList["blue"] = { r = 0.0, g = 0.0, b = 1.0 }
	Utility_Class.ColorList["white"] = { r = 1.0, g = 1.0, b = 1.0 }
	Utility_Class.ColorList["magenta"] = { r = 1.0, g = 0.0, b = 1.0 }
	Utility_Class.ColorList["yellow"] = { r = 1.0, g = 1.0, b = 0.0 }
	Utility_Class.ColorList["cyan"] = { r = 0.0, g = 1.0, b = 1.0 }
	Utility_Class.ColorList["orange"] = { r = 1.0, g = 0.6, b = 0.0 }
end
