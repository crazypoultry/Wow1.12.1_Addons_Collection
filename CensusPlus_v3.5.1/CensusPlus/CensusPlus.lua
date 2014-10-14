--[[
	CensusPlus for World of Warcraft(tm).
	
	Copyright 2005 - 2006 Cooper Sellers and WarcraftRealms.com

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GLP.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
]]


------------------------------------------------------------------------------------
--
-- CensusPlus
-- A WoW UI customization by Cooper Sellers
--
--
------------------------------------------------------------------------------------

----------------------------------------------------------------------------------
--
-- EURO vs US localization problem workaround for common server names
--
---------------------------------------------------------------------------------
local g_InterfaceVersion = 11200;
g_CensusPlusLocale = "N/A";							--  Must read either US or EU
g_CensusPlusTZOffset = -999;
local g_LocaleSet = false;
local g_TZWarningSent = false;


----------------------------------------------------------------------------------
--
-- Constants
--
---------------------------------------------------------------------------------
local CensusPlus_VERSION = "3.5.1"; 				-- version
local CensusPlus_MAXBARHEIGHT = 128;			-- Length of blue bars
local CensusPlus_NUMGUILDBUTTONS = 10;			-- How many guild buttons are on the UI?
local MAX_CHARACTER_LEVEL = 60;					-- Maximum level a PC can attain
local MAX_WHO_RESULTS = 49;						-- Maximum number of who results the server will return
CensusPlus_GUILDBUTTONSIZEY = 16;
local CensusPlus_UPDATEDELAY = 5;				-- Delay time between /who messages
local CP_MAX_TIMES = 50;

local g_ServerPrefix = "";						--  US VERSION!!
--local g_ServerPrefix = "EU-";					--  EU VERSION!!


----------------------------------------------------------------------------------
--
-- Print a string to the chat frame
--	msg - message to print
--
---------------------------------------------------------------------------------
function CensusPlus_Msg(msg)
	ChatFrame1:AddMessage("Census+: "..msg, 1.0, 1.0, 0.5);
end

function CensusPlus_WhoMsg(msg)
	ChatFrame1:AddMessage("Census+ Who: "..msg, 0.8, 0.8, 0.1);
end

local function CensusPlus_Msg2( msg )
	ChatFrame2:AddMessage("Census+: "..msg, 0.5, 1.0, 1.0);
end

----------------------------------------------------------------------------------
--
-- Global scope variables
--
---------------------------------------------------------------------------------
CensusPlus_Database = {};							-- Database of all CensusPlus results
CensusPlus_BGInfo   = {};							--  Battleground info
CensusPlus_PerCharInfo = {};						--  Per character settings

----------------------------------------------------------------------------------
--
-- File scope variables
--
---------------------------------------------------------------------------------
local g_CensusPlusInitialized;						-- Is CensusPlus initialized?
local g_JobQueue = {};							-- The queue of pending jobs
local g_CurrentJob = {};						-- Current job being executed
g_IsCensusPlusInProgress = false;			-- Is a CensusPlus in progress?
g_CensusPlusPaused = false;               -- Is CensusPlus in progress paused?
g_CensusPlusManuallyPaused = false;       -- Is CensusPlus in progress manually paused?
local g_WhoAutoClose = 0;                       -- AutoClose who window?

local g_NumNewCharacters = 0;					-- How many new characters found this CensusPlus
local g_NumUpdatedCharacters = 0;				-- How many characters were updated during this CensusPlus

local g_MobXPByLevel = {};						-- XP earned for killing
local g_CharacterXPByLevel = {};				-- XP required to advance through the given level
local g_TotalCharacterXPPerLevel = {};			-- Total XP required to attain the given level

CensusPlus_Guilds = {};							-- All known guild

local g_TotalCharacterXP = 0;					-- Total character XP for currently selected search
local g_TotalCount = 0;							-- Total number of characters which meet search criteria
local g_RaceCount = {};							-- Totals for each race given search criteria
local g_ClassCount = {};						-- Totals for each class given search criteria
local g_LevelCount = {};						-- Totals for each level given search criteria
local g_TempCount  = {};
local g_TempZoneCount = {};

g_GuildSelected = 0;						-- Search criteria: Currently selected guild, 0 indicates none
g_RaceSelected = 0;						-- Search criteria: Currently selected race, 0 indicates none
g_ClassSelected = 0;						-- Search criteria: Currently selected class, 0 indicates none
g_LevelSelected = 0;

local g_LastOnUpdateTime = 0;					-- Last time OnUpdate was called
local g_WaitingForWhoUpdate = false;			-- Are we waiting for a who update event?

local g_WhoAttempts = 0;                        -- Counter for detecting stuck who results
local g_MiniOnStart = 1;                        -- Flag to have the mini-censusP displayed on startup

local g_CompleteCensusStarted = false;          -- Flag for counter
local g_TakeHour = 0;                           -- Our timing hour
local g_TimeDatabase = {};                      -- Time database
local g_ResetHour = true;                       -- Rest hour
local g_VariablesLoaded = false;                -- flag to tell us if vars are loaded
local g_FirstRun = true;
local g_LastCensusRun = time() - 1500;			--  timer used if auto census is turned on

local g_Pre_FriendsFrameOnHideOverride = nil;		--  override for friend's frame to stop the close window sound
local g_Pre_FriendsFrameOnShowOverride = nil;		--  override for friend's frame to stop the close window sound
local g_Pre_WhoList_UpdateOverride = nil;		--  override for friend's frame to stop the close window sound
local g_Pre_WhoHandler = nil;						--  override for submiting a who
local g_Pre_FriendsFrame_Update = nil;
local CP_updatingGuild  = nil;
g_CensusPlusLastTarget = nil;
g_CensusPlusLastTargetName = nil;
local g_CurrentlyInBG = false;
local g_InternalSearchName = nil;
local g_InternalSearchLevel = nil;
local g_InternalSearchCount = 0;
CensusPlus_EnableProfiling = false;
local g_CensusPlus_StartTime = 0;
local g_CensusWhoOverrideMsg = nil;
local g_WaitingForOverrideUpdate = false;

--  Battleground info
CENSUSPLUS_CURRENT_BATTLEFIELD_QUEUES = {};

local g_AccumulatedPruneData = {};

g_RaceClassList = { };						-- Used to pick the right icon
g_RaceClassList[CENSUSPlus_DRUID]		= 10;
g_RaceClassList[CENSUSPlus_HUNTER]		= 11;
g_RaceClassList[CENSUSPlus_MAGE]		= 12;
g_RaceClassList[CENSUSPlus_PRIEST]		= 13;
g_RaceClassList[CENSUSPlus_ROGUE]		= 14;
g_RaceClassList[CENSUSPlus_WARLOCK]	    = 15;
g_RaceClassList[CENSUSPlus_WARRIOR]	    = 16;
g_RaceClassList[CENSUSPlus_SHAMAN]		= 17;
g_RaceClassList[CENSUSPlus_PALADIN]	    = 18;

g_RaceClassList[CENSUSPlus_DWARF]		= 20;
g_RaceClassList[CENSUSPlus_GNOME]		= 21;
g_RaceClassList[CENSUSPlus_HUMAN]		= 22;
g_RaceClassList[CENSUSPlus_NIGHTELF]	= 23;
g_RaceClassList[CENSUSPlus_ORC]		    = 24;
g_RaceClassList[CENSUSPlus_TAUREN]		= 25;
g_RaceClassList[CENSUSPlus_TROLL]		= 26;
g_RaceClassList[CENSUSPlus_UNDEAD]		= 27;

g_TimeDatabase[CENSUSPlus_DRUID]		= 0;
g_TimeDatabase[CENSUSPlus_HUNTER]		= 0;
g_TimeDatabase[CENSUSPlus_MAGE]			= 0;
g_TimeDatabase[CENSUSPlus_PRIEST]		= 0;
g_TimeDatabase[CENSUSPlus_ROGUE]		= 0;
g_TimeDatabase[CENSUSPlus_WARLOCK]	    = 0;
g_TimeDatabase[CENSUSPlus_WARRIOR]	    = 0;
g_TimeDatabase[CENSUSPlus_SHAMAN]		= 0;
g_TimeDatabase[CENSUSPlus_PALADIN]	    = 0;
g_TimeDatabase[CENSUSPlus_WarsongGulch]			= 0;
g_TimeDatabase[CENSUSPlus_AlteracValley]		= 0;
g_TimeDatabase[CENSUSPlus_ArathiBasin]			= 0;

--  These two DO NOT need to be localized
local CENSUSPlus_HORDE            = "Horde";
local CENSUSPlus_ALLIANCE         = "Alliance";


local g_FactionCheck = {};
g_FactionCheck[CENSUSPlus_ORC]		= CENSUSPlus_HORDE;
g_FactionCheck[CENSUSPlus_TAUREN]	= CENSUSPlus_HORDE;
g_FactionCheck[CENSUSPlus_TROLL]	= CENSUSPlus_HORDE;
g_FactionCheck[CENSUSPlus_UNDEAD]	= CENSUSPlus_HORDE;

g_FactionCheck[CENSUSPlus_DWARF]	= CENSUSPlus_ALLIANCE;
g_FactionCheck[CENSUSPlus_GNOME]	= CENSUSPlus_ALLIANCE;
g_FactionCheck[CENSUSPlus_HUMAN]	= CENSUSPlus_ALLIANCE;
g_FactionCheck[CENSUSPlus_NIGHTELF]	= CENSUSPlus_ALLIANCE;

----------------------------------------------------------------------------------
--
-- Set up confirmation boxes
-- 
---------------------------------------------------------------------------------
StaticPopupDialogs["CP_PURGE_CONFIRM"] = {
  text = CENSUSPlus_PURGE_LOCAL_CONFIRM,
  button1 = CENSUSPlus_YES,
  button2 = CENSUSPlus_NO,
  OnAccept = function()
      CensusPlus_DoPurge();
  end,
  sound = "levelup2",
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1,
  showAlert = 1
};

----------------------------------------------------------------------------------
--
-- Set up Continue after override box
-- 
---------------------------------------------------------------------------------
StaticPopupDialogs["CP_CONTINUE_CENSUS"] = {
  text = CENSUSPlus_OVERRIDE_COMPLET_PAUSED,
  button1 = CENSUSPlus_CONTINUE,
  OnAccept = function()
				g_CensusPlusManuallyPaused = false;
				CensusPlusTakeButton:SetText( CENSUSPlus_PAUSE );			
			end,
  sound = "levelup2",
  timeout = 0,
  whileDead = 1,
  hideOnEscape = 1,
  showAlert = 1
};

----------------------------------------------------------------------------------
--
-- Chat msg hook
--
---------------------------------------------------------------------------------
local function CP_HookAddMessage(frame)
	local AddMessage = frame.AddMessage;
	-- Create a closure to cleanly hook the AddMessage routine.
	frame.AddMessage = function (this, msg, r, g, b, id)
		if( g_IsCensusPlusInProgress ) then
			local s, e;
			local results = { };
			local whoMsg = false;
			s, e, results[0], results[1], results[2], results[3], results[4] = string.find(msg, CENSUS_LEVEL_NO_GUILD);
			if( results[0] ~= nil ) then
				whoMsg = true;
    		end
			local s, e;
			local results = { };
			s, e, results[0], results[1], results[2], results[3], results[4] = string.find(msg, CENSUS_LEVEL_W_GUILD);
			if( results[0] ~= nil ) then
				whoMsg = true;
    		end
			local s, e;
			local results = { };
			s, e, results[0], results[1], results[2], results[3], results[4] = string.find(msg, CENSUS_MULT_PLAYERS);
			if( results[0] ~= nil ) then
				whoMsg = true;
    		end

			local s, e;
			local results = { };
			s, e, results[0], results[1], results[2], results[3], results[4] = string.find(msg, CENSUS_SING_PLAYER);
			if( results[0] ~= nil ) then
				whoMsg = true;
    		end
		    	
    		if( whoMsg ) then
    			--
    			--  Also bail out of an override if in place
    			--
				if( g_CensusWhoOverrideMsg ~= nil and g_WaitingForOverrideUpdate == true ) then
					--
					--  Allow the who to act normally
					--
					g_CensusWhoOverrideMsg = nil;
					g_WaitingForOverrideUpdate = false;
					CensusPlus_Msg( CENSUSPlus_OVERRIDE_COMPLETE );
					return AddMessage(this, msg, r, g, b, id)						
				elseif( CensusPlus_PerCharInfo["Verbose"] ~= true and 
						not g_CensusPlusPaused and 
						not g_CensusPlusManuallyPaused ) then
					return;
									
				end
    		end
    			
			return AddMessage(this, msg, r, g, b, id)						
		else
			return AddMessage(this, msg, r, g, b, id)
		end
	end
end



-----------------------------------------------------------------------------------
--
-- Insert a job at the end of the job queue
--
-----------------------------------------------------------------------------------
local function InsertJobIntoQueue(job)
	table.insert(g_JobQueue, job);
end

-----------------------------------------------------------------------------------
--
-- Initialize the tables of constants for XP calculations
--
-----------------------------------------------------------------------------------
local function InitConstantTables()
	--
	-- XP earned for killing
	--
	for i = 1, MAX_CHARACTER_LEVEL, 1 do
		g_MobXPByLevel[i] = (i * 5) + 45;
	end

	--
	-- XP required to advance through the given level
	--
	for i = 1, MAX_CHARACTER_LEVEL, 1 do
		g_CharacterXPByLevel[i] = ((8 * i * g_MobXPByLevel[i]) / 100) * 100;
	end

	--
	-- Total XP required to attain the given level
	--
	local totalCharacterXP = 0;
	for i = 1, MAX_CHARACTER_LEVEL, 1 do
		g_TotalCharacterXPPerLevel[i] = totalCharacterXP;
		totalCharacterXP = totalCharacterXP + g_CharacterXPByLevel[i];
	end
end

-----------------------------------------------------------------------------------
--
-- Return a table of races for the input faction
--
-----------------------------------------------------------------------------------
function CensusPlus_GetFactionRaces(faction)
	local ret = {};
	if (faction == CENSUSPlus_HORDE) then
		ret = {CENSUSPlus_ORC, CENSUSPlus_TAUREN, CENSUSPlus_TROLL, CENSUSPlus_UNDEAD};
	elseif (faction == CENSUSPlus_ALLIANCE) then
		ret = {CENSUSPlus_DWARF, CENSUSPlus_GNOME, CENSUSPlus_HUMAN, CENSUSPlus_NIGHTELF};
	end
	return ret;
end

-----------------------------------------------------------------------------------
--
-- Return a table of classes for the input faction
--
-----------------------------------------------------------------------------------
function CensusPlus_GetFactionClasses(faction)
	local ret = {};
	if (faction == CENSUSPlus_HORDE) then
		ret = {CENSUSPlus_DRUID, CENSUSPlus_HUNTER, CENSUSPlus_MAGE, CENSUSPlus_PRIEST, CENSUSPlus_ROGUE, CENSUSPlus_WARLOCK, CENSUSPlus_WARRIOR, CENSUSPlus_SHAMAN};
	elseif (faction == CENSUSPlus_ALLIANCE) then
		ret = {CENSUSPlus_DRUID, CENSUSPlus_HUNTER, CENSUSPlus_MAGE, CENSUSPlus_PRIEST, CENSUSPlus_ROGUE, CENSUSPlus_WARLOCK, CENSUSPlus_WARRIOR, CENSUSPlus_PALADIN};
	end
	return ret;
end

-----------------------------------------------------------------------------------
--
-- Return a table of classes for the input race
--
-----------------------------------------------------------------------------------
local function GetRaceClasses(race)
	local ret = {};
	if (race == CENSUSPlus_ORC) then
		ret = {CENSUSPlus_WARRIOR, CENSUSPlus_HUNTER, CENSUSPlus_ROGUE, CENSUSPlus_SHAMAN, CENSUSPlus_WARLOCK};
	elseif (race == CENSUSPlus_TAUREN) then
		ret = {CENSUSPlus_WARRIOR, CENSUSPlus_HUNTER, CENSUSPlus_SHAMAN, CENSUSPlus_DRUID};
	elseif (race == CENSUSPlus_TROLL) then
		ret = {CENSUSPlus_WARRIOR, CENSUSPlus_HUNTER, CENSUSPlus_ROGUE, CENSUSPlus_PRIEST, CENSUSPlus_SHAMAN, CENSUSPlus_MAGE};
	elseif (race == CENSUSPlus_UNDEAD) then
		ret = {CENSUSPlus_WARRIOR, CENSUSPlus_ROGUE, CENSUSPlus_PRIEST, CENSUSPlus_MAGE, CENSUSPlus_WARLOCK};
	elseif (race == CENSUSPlus_DWARF) then
		ret = {CENSUSPlus_WARRIOR, CENSUSPlus_PALADIN, CENSUSPlus_HUNTER, CENSUSPlus_ROGUE, CENSUSPlus_PRIEST};
	elseif (race == CENSUSPlus_GNOME) then
		ret = {CENSUSPlus_WARRIOR, CENSUSPlus_ROGUE, CENSUSPlus_MAGE, CENSUSPlus_WARLOCK};
	elseif (race == CENSUSPlus_HUMAN) then
		ret = {CENSUSPlus_WARRIOR, CENSUSPlus_PALADIN, CENSUSPlus_ROGUE, CENSUSPlus_PRIEST, CENSUSPlus_MAGE, CENSUSPlus_WARLOCK};
	elseif (race == CENSUSPlus_NIGHTELF) then
		ret = {CENSUSPlus_WARRIOR, CENSUSPlus_HUNTER, CENSUSPlus_ROGUE, CENSUSPlus_PRIEST, CENSUSPlus_DRUID};
	end
	return ret;
end

-----------------------------------------------------------------------------------
--
-- Return common letters found in zone names
--
-----------------------------------------------------------------------------------
local function GetZoneLetters()
	return {"t", "d", "g", "f", "h", "b", "x", "gulch", "valley", "basin" };
end

-----------------------------------------------------------------------------------
--
-- Return common letters found in names, may override this for other languages
--   Worst case scenario is to do it for every letter in the alphabet
--
-----------------------------------------------------------------------------------
local function GetNameLetters()
	return { "a", "b", "c", "d", "e", "f", "g", "i", "o", "p", "r", "s", "t", "u", "y" };
end

---------------------------------------------------------------------------------
--
-- Register with Cosmos UI
--
---------------------------------------------------------------------------------
local function CensusPlus_RegisterCosmos()
	--
	-- If Cosmos is installed, add a button to the Cosmos page to activate CensusPlus
	--
	if ( EarthFeature_AddButton ) then
		EarthFeature_AddButton(
			{
				id = "CensusPlus";
				name = CENSUSPlus_BUTTON_TEXT;
				subtext = CENSUSPlus_BUTTON_SUBTEXT;
				tooltip = CENSUSPlus_BUTTON_TIP;
				icon = "Interface\\AddOns\\CensusPlus\\Skin\\CensusPlus_Icon";
				callback = CensusPlus_Toggle;
			}
		);
	elseif ( Cosmos_RegisterButton ) then
			Cosmos_RegisterButton(CENSUSPlus_BUTTON_TEXT, CENSUSPlus_BUTTON_SUBTEXT, CENSUSPlus_BUTTON_TIP, "Interface\\AddOns\\CensusPlus\\Skin\\CensusPlus_Icon", CensusPlus_Toggle);
	end
end


----------------------------------------------------------------------------------
--
-- Called when the main window is shown
--
---------------------------------------------------------------------------------
function CensusPlus_OnShow()
	-- Initialize if this is the first OnShow event
	if (g_CensusPlusInitialized == false) then
		g_CensusPlusInitialized = true;
	end
	CensusPlus_UpdateView();
end

----------------------------------------------------------------------------------
--
-- Toggle hidden status
--
---------------------------------------------------------------------------------
function CensusPlus_Toggle()
	if ( CensusPlus:IsVisible() ) then
		CensusPlus:Hide();
	else
		CensusPlus:Show();
	end
end

----------------------------------------------------------------------------------
--
-- Toggle options pane
--
---------------------------------------------------------------------------------
function CensusPlus_ToggleOptions()
	if ( CP_OptionsWindow:IsVisible() ) then
		CP_OptionsWindow:Hide();
	else
		CP_OptionsWindow:Show();
	end
end

-----------------------------------------------------------------------------------
--
-- Called once on load
--
-----------------------------------------------------------------------------------
function CensusPlus_OnLoad()
	--
	-- Update the version number
	--
	CensusPlusText:SetText("Census+ v"..CensusPlus_VERSION .. " " .. g_CensusPlusLocale );
    CensusPlusText2:SetText( CENSUSPlus_UPLOAD );

	--
	-- Init constant tables
	--
	InitConstantTables();

	--
	-- Register with Cosmos, if it is installed
	--
	CensusPlus_RegisterCosmos();

	--
	-- Register for events
	--
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("WHO_LIST_UPDATE");
--	this:RegisterEvent("GUILD_ROSTER_SHOW");
	this:RegisterEvent("GUILD_ROSTER_UPDATE");
--	this:RegisterEvent("TRAINER_SHOW");
--	this:RegisterEvent("TRAINER_CLOSED");
--	this:RegisterEvent("MERCHANT_SHOW");
--	this:RegisterEvent("MERCHANT_CLOSED");
--	this:RegisterEvent("GUILD_REGISTRAR_SHOW");
--	this:RegisterEvent("GUILD_REGISTRAR_CLOSED");
--	this:RegisterEvent("TRADE_SHOW");
--	this:RegisterEvent("TRADE_CLOSED");
--	this:RegisterEvent("AUCTION_HOUSE_SHOW");
--	this:RegisterEvent("AUCTION_HOUSE_CLOSED");
--	this:RegisterEvent("BANKFRAME_OPENED");
--	this:RegisterEvent("BANKFRAME_CLOSED");

--	this:RegisterEvent("QUEST_GREETING");
--	this:RegisterEvent("QUEST_DETAIL");
--	this:RegisterEvent("QUEST_PROGRESS");
--	this:RegisterEvent("QUEST_COMPLETE");
--	this:RegisterEvent("QUEST_FINISHED");
--	this:RegisterEvent("QUEST_ITEM_UPDATE");

--	this:RegisterEvent("QUEST_ACCEPT_CONFIRM");
--	this:RegisterEvent("QUEST_LOG_UPDATE");

	this:RegisterEvent("UNIT_FOCUS");
	this:RegisterEvent("PLAYER_TARGET_CHANGED" );
	this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");

	this:RegisterEvent("PLAYER_PVP_KILLS_CHANGED");
	this:RegisterEvent("INSPECT_HONOR_UPDATE");

	this:RegisterEvent("CHAT_MSG_SYSTEM");
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS");

	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");

	this:RegisterEvent("UPDATE_BATTLEFIELD_STATUS");

	--
	-- Register a slash command
	--
	SLASH_CensusPlusCMD1 = "/CensusPlus";
	SLASH_CensusPlusCMD2 = "/Census+";
	SLASH_CensusPlusCMD3 = "/Census";
	SlashCmdList["CensusPlusCMD"] = CensusPlus_Command;

    SLASH_CensusPlusVerbose1 = "/censusverbose";
	SlashCmdList["CensusPlusVerbose"] = CensusPlus_Verbose;

	--
	--  Set the auto close to true
	--
	CensusPlus_AutoCloseWho( 1 );
	--AutoClose:SetChecked( 1 );

	g_Pre_FriendsFrameOnHideOverride = FriendsFrame_OnHide;
	FriendsFrame_OnHide = CensusPlus_FriendsFrame_OnHide;

	g_Pre_FriendsFrameOnShowOverride = FriendsFrame_OnShow;
	FriendsFrame_OnShow = CensusPlus_FriendsFrame_OnShow;

	g_Pre_WhoList_UpdateOverride = WhoList_Update;
	WhoList_Update = CensusPlus_WhoList_Update;

	g_Pre_FriendsFrame_Update  = FriendsFrame_Update;
	FriendsFrame_Update = CensusPlus_FriendsFrame_Update;

	g_Pre_WhoHandler = SlashCmdList["WHO"];
	SlashCmdList["WHO"] = CensusPlus_WhoHandler;

	CensusPlus_CheckForBattleground();

	-- Hook the default chat frame's AddMessage method.
	CP_HookAddMessage(ChatFrame1);

end

-----------------------------------------------------------------------------------
--
-- Load Handler for options box
--
-----------------------------------------------------------------------------------
function CP_OptionsOnShow()
	CP_OptionAutoClose:SetChecked(g_WhoAutoClose);
	CP_OptionAutoStartButton:SetChecked(g_MiniOnStart);
	CP_OptionVerboseButton:SetChecked(CensusPlus_PerCharInfo["Verbose"]);
	CP_OptionAutoCensusButton:SetChecked( CensusPlus_Database["Info"]["AutoCensus"] );
	CP_OptionProcessCharProfileButton:SetChecked( CensusPlus_DoThisCharacter );
end

-----------------------------------------------------------------------------------
--
-- CensusPlus Friends Frame override to stop the window close sound
--
-----------------------------------------------------------------------------------
function CensusPlus_FriendsFrame_OnHide()
	g_Pre_FriendsFrameOnHideOverride();
end

-----------------------------------------------------------------------------------
--
-- CensusPlus Friends Frame override to stop the window close sound
--
-----------------------------------------------------------------------------------
function CensusPlus_FriendsFrame_OnShow()
	g_Pre_FriendsFrameOnShowOverride();
end

function CensusPlus_WhoList_Update()
	if( g_IsCensusPlusInProgress == true and g_WhoAutoClose ) then
		local numWhos, totalCount = GetNumWhoResults();
		local name, guild, level, race, class, zone, group;
		local button;
		local columnTable;
		local whoOffset = FauxScrollFrame_GetOffset(WhoListScrollFrame);
		local whoIndex;
		local showScrollBar = nil;
		if ( numWhos > WHOS_TO_DISPLAY ) then
			showScrollBar = 1;
		end
		local displayedText = "";
		if ( totalCount > MAX_WHOS_FROM_SERVER ) then
			displayedText = format(WHO_FRAME_SHOWN_TEMPLATE, MAX_WHOS_FROM_SERVER);
		end
		WhoFrameTotals:SetText(format(GetText("WHO_FRAME_TOTAL_TEMPLATE", nil, totalCount), totalCount).."  "..displayedText);
		for i=1, WHOS_TO_DISPLAY, 1 do
			whoIndex = whoOffset + i;
			button = getglobal("WhoFrameButton"..i);
			button.whoIndex = whoIndex;
			name, guild, level, race, class, zone, group = GetWhoInfo(whoIndex);
			columnTable = { zone, guild, race };
			getglobal("WhoFrameButton"..i.."Name"):SetText(name);
			getglobal("WhoFrameButton"..i.."Level"):SetText(level);
			getglobal("WhoFrameButton"..i.."Class"):SetText(class);
			local variableText = getglobal("WhoFrameButton"..i.."Variable");
			variableText:SetText(columnTable[UIDropDownMenu_GetSelectedID(WhoFrameDropDown)]);
			if ( not group  ) then
				group = "";
			end
			--getglobal("WhoFrameButton"..i.."Group"):SetText(getglobal(strupper(group)));

			-- If need scrollbar resize columns
			if ( showScrollBar ) then
				variableText:SetWidth(95);
			else
				variableText:SetWidth(110);
			end

			-- Highlight the correct who
			if ( WhoFrame.selectedWho == whoIndex ) then
				button:LockHighlight();
			else
				button:UnlockHighlight();
			end

			if ( whoIndex > numWhos ) then
				button:Hide();
			else
				button:Show();
			end
		end

		if ( not WhoFrame.selectedWho ) then
			WhoFrameGroupInviteButton:Disable();
			WhoFrameAddFriendButton:Disable();
		else
			WhoFrameGroupInviteButton:Enable();
			WhoFrameAddFriendButton:Enable();
			WhoFrame.selectedName = GetWhoInfo(WhoFrame.selectedWho);
		end

		-- If need scrollbar resize columns
		if ( showScrollBar ) then
			WhoFrameColumn_SetWidth(105, WhoFrameColumnHeader2);
			UIDropDownMenu_SetWidth(80, WhoFrameDropDown);
		else
			WhoFrameColumn_SetWidth(120, WhoFrameColumnHeader2);
			UIDropDownMenu_SetWidth(95, WhoFrameDropDown);
		end

		-- ScrollFrame update
		FauxScrollFrame_Update(WhoListScrollFrame, numWhos, WHOS_TO_DISPLAY, FRIENDS_FRAME_WHO_HEIGHT );
	else
		g_Pre_WhoList_UpdateOverride();
	end
end


function CensusPlus_FriendsFrame_Update()
	if ( FriendsFrame.selectedTab == 3 and g_IsCensusPlusInProgress == true and g_WhoAutoClose ) then
		FriendsFrameTopLeft:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopLeft");
		FriendsFrameTopRight:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-TopRight");
		FriendsFrameBottomLeft:SetTexture("Interface\\FriendsFrame\\GuildFrame-BotLeft");
		FriendsFrameBottomRight:SetTexture("Interface\\FriendsFrame\\GuildFrame-BotRight");
		local guildName;
		guildName = GetGuildInfo("player");
		FriendsFrameTitleText:SetText(guildName);
		FriendsFrame_ShowSubFrame("GuildFrame");
	else
		g_Pre_FriendsFrame_Update();
	end
end

-----------------------------------------------------------------------------------
--
-- CensusPlus Who Handler
--
-----------------------------------------------------------------------------------
function CensusPlus_WhoHandler( msg )
	if( g_IsCensusPlusInProgress == true ) then
		if ( msg == "" ) then
			msg = WhoFrame_GetDefaultWhoCommand();
			ShowWhoPanel();
		elseif ( msg == "cheat" ) then
			-- Remove the "cheat" part later!
			ShowWhoPanel();
		end
		
		--
		--  Queue up the command to run next
		--
		g_CensusWhoOverrideMsg = msg;
		CensusPlus_Msg( CENSUSPlus_OVERRIDE );
--		SendWho(msg);
	else
		g_Pre_WhoHandler(msg);
	end
end

-----------------------------------------------------------------------------------
--
-- CensusPlus command
--
-----------------------------------------------------------------------------------
function CensusPlus_Command( param )

	local i,j, command, value = string.find(param, "^([^ ]+) (.+)$");

--    local  firsti, lasti, command, value = string.find (param, "(%w+) (%w+) (%w+)") ;

--	if( string.lower(param) == "locale" ) then
--		CP_EU_US_Version:Show();
--	else
	if( string.lower(param) == "options" ) then
		CP_OptionsWindow:Show();
--	elseif( string.lower(param) == "tz" ) then
--		CensusPlus_DetermineServerDate();
	elseif( command ~= nil and string.lower(command) == "prune" ) then
		if( value ~= nil ) then
			CensusPlus_PruneData( value, nil );
		else
			CensusPlus_PruneData( 30, nil );
		end
	elseif( command ~= nil and string.lower(command) == "timer" ) then
		if( value ~= nil ) then
			CensusPlus_Database["Info"]["AutoCensusTimer"] = value * 60;
			CensusPlus_Msg( "Set autocensus timer to " .. value .. " minutes" );
		else
			CensusPlus_Database["Info"]["AutoCensusTimer"] = 1800;
			CensusPlus_Msg( "Set autocensus timer to 30 minutes" );
		end
	elseif( string.lower(param) == "serverprune" ) then
		CensusPlus_PruneData( 0, 1 );
	elseif( string.lower(param) == "bufftest" ) then
		showAllUnitBuffs("player");
	elseif( string.lower(param) == "verbose" ) then
		CensusPlus_Verbose();
	elseif( string.lower(param) == "take" ) then
		CensusPlus_Take_OnClick();
	elseif( string.lower(param) == "stop" ) then
		CensusPlus_StopCensus();
	elseif( command ~= nil and string.lower(command) == "who" ) then
		local m,n, check, level = string.find(value, "(%w+) (%w+)");
		if( check ~= nil ) then
			CensusPlus_InternalWho( string.lower(check), level );
		else
			CensusPlus_InternalWho( string.lower(value), nil );
		end
	elseif( command ~= nil and string.lower(command) == "test" ) then
		if( value ~= nil ) then
			CensusPlus_Test( value );
		else
			CensusPlus_Test( 1 );
		end
	else
		CensusPlus_DisplayUsage();
	end
end

-----------------------------------------------------------------------------------
--
-- CensusPlus Display Usage
--
-----------------------------------------------------------------------------------
function CensusPlus_DisplayUsage()
    local text;

	CensusPlus:Show();

    CensusPlus_Msg("Usage:\n  /CensusPlus \n");
    CensusPlus_Msg("  /censusPlus verbose Toggle verbose mode off/on\n");
--    CensusPlus_Msg("  /CensusPlus locale  Bring up the locale selection dialog - (WARNING -- CHANGING YOUR LOCALE WILL PURGE YOUR DATABASE)\n");
    CensusPlus_Msg("  /CensusPlus options Bring up the Option window\n");
    CensusPlus_Msg("  /CensusPlus take Start a Census snapshot\n");
    CensusPlus_Msg("  /CensusPlus stop Stop a Census snapshot\n");
    CensusPlus_Msg("  /CensusPlus prune X Prune the database by removing characters not seen in X days\n");
    CensusPlus_Msg("  /CensusPlus serverprune Prune the database by removing all data from servers other than the one you are currently on.\n");
    CensusPlus_Msg("  /CensusPlus who XXX Will display info that matches names or guilds.\n");
    CensusPlus_Msg("  /CensusPlus who unguilded ## Will list unguilded characters of that level.\n");
    CensusPlus_Msg("  /CensusPlus timer X ## Will set the autocensus timer (in minutes).\n");
end

-----------------------------------------------------------------------------------
--
-- CensusPlus_InternalWho -  will go through our local database and see if we have
--		any info on this person
--
-----------------------------------------------------------------------------------
function CensusPlus_InternalWho( search, level )

	if( g_CensusPlusLocale == "N/A" ) then
		return;
	end

	g_InternalSearchName = search;
	g_InternalSearchLevel = level;
	g_InternalSearchCount = 0;
	local realmName = g_CensusPlusLocale .. GetCVar("realmName");
	CensusPlus_ForAllCharacters( realmName, UnitFactionGroup("player"), nil, nil, nil, nil, CensusPlus_InternalWhoResult)

	CensusPlus_WhoMsg( "Found " .. g_InternalSearchCount .. " players." );
end

function CensusPlus_InternalWhoResult(name, level, guild, race, class, lastSeen )
	lowerName = string.lower( name );
	level = string.lower( level );
	lowerGuild = string.lower( CensusPlus_SafeCheck( guild ) );

	if( g_InternalSearchName == "unguilded" ) then
		if( guild == "" ) then
			local doit = 1;
			if( g_InternalSearchLevel ~= nil ) then
				if( g_InternalSearchLevel ~= level ) then
					doit = 0;
				end
			end
			if( doit == 1 ) then
				local out = name .. " : Level " .. level .. " " .. race .. " " .. " " .. class;
				out = out .. " Last Seen: " .. lastSeen;
				CensusPlus_WhoMsg( out );
				g_InternalSearchCount = g_InternalSearchCount + 1;
			end
		end
	elseif( string.find( lowerName, g_InternalSearchName ) or string.find( lowerGuild, g_InternalSearchName ) ) then
		-- found someone!
		local out = name .. " : Level " .. level .. " " .. race .. " " .. " " .. class;
		if( guild ~= "" ) then
			out = out .. " <" .. guild .. ">";
		end
		out = out .. " Last Seen: " .. lastSeen;
	    CensusPlus_WhoMsg( out );
		g_InternalSearchCount = g_InternalSearchCount + 1;
	end
end

-----------------------------------------------------------------------------------
--
-- CensusPlus Verbose option
--
-----------------------------------------------------------------------------------
function CensusPlus_Verbose()
    if( CensusPlus_PerCharInfo["Verbose"] == true ) then
        CensusPlus_Msg( "Verbose Mode : OFF" );
        CensusPlus_PerCharInfo["Verbose"] = false;
	else
        CensusPlus_Msg( "Verbose Mode : ON" );
        CensusPlus_PerCharInfo["Verbose"] = true;
    end
end

-----------------------------------------------------------------------------------
--
-- CensusPlus Auto Census set flag
--
-----------------------------------------------------------------------------------
function CensusPlus_SetAutoCensus( flag )
	if( flag == 1 ) then
		CensusPlus_Database["Info"]["AutoCensus"] = true;
	else
		CensusPlus_Database["Info"]["AutoCensus"] = false;
	end
end

-----------------------------------------------------------------------------------
--
-- Minimize the window
--
-----------------------------------------------------------------------------------
function CensusPlus_OnClickMinimize()
    if( CensusPlus:IsVisible() ) then
--        MiniCensusPlus:Show();
        CensusPlus:Hide();
    end
end

-----------------------------------------------------------------------------------
--
-- Minimize the window
--
-----------------------------------------------------------------------------------
function CensusPlus_OnClickMaximize()
    if( MiniCensusPlus:IsVisible() ) then
        MiniCensusPlus:Hide();
        CensusPlus:Show();
    end
end

-----------------------------------------------------------------------------------
--
-- Take or pause a census depending on current status
--
-----------------------------------------------------------------------------------
function CensusPlus_Take_OnClick()
	if (g_IsCensusPlusInProgress) then
	    CensusPlus_TogglePause();
	else
		CensusPlus_StartCensus();
	end
end

-----------------------------------------------------------------------------------
--
-- Display a tooltip for the take button
--
-----------------------------------------------------------------------------------
function CensusPlus_Take_OnEnter()
	if (g_IsCensusPlusInProgress) then
		if (g_CensusPlusManuallyPaused) then
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
			GameTooltip:SetText(CENSUSPlus_UNPAUSECENSUS, 1.0, 1.0, 1.0);
			GameTooltip:Show();
		else
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
			GameTooltip:SetText(CENSUSPlus_PAUSECENSUS, 1.0, 1.0, 1.0);
			GameTooltip:Show();
		end
	else
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetText(CENSUSPlus_TAKECENSUS, 1.0, 1.0, 1.0);
		GameTooltip:Show();
	end
end

-----------------------------------------------------------------------------------
--
-- Pause the current census
--
-----------------------------------------------------------------------------------
function CensusPlus_TogglePause()
	if (g_IsCensusPlusInProgress == true) then
	    if( g_CensusPlusManuallyPaused == true ) then
	        CensusPlusTakeButton:SetText( CENSUSPlus_PAUSE );
            g_CensusPlusManuallyPaused = false;
	    else
	        CensusPlusTakeButton:SetText( CENSUSPlus_UNPAUSE );
            g_CensusPlusManuallyPaused = true;
        end
    end
end

-----------------------------------------------------------------------------------
--
-- Purge the database for this realm and faction
--
-----------------------------------------------------------------------------------
function CensusPlus_Purge()
	StaticPopup_Show ("CP_PURGE_CONFIRM");
end

function CensusPlus_DoPurge()
	if( CensusPlus_Database["Servers"] ~= nil ) then
		CensusPlus_Database["Servers"] = nil;
	end
	CensusPlus_Database["Servers"] = {};
	CensusPlus_UpdateView();
	CensusPlus_Msg(CENSUSPlus_PURGEMSG);

	if( CensusPlus_Database["Guilds"] ~= nil ) then
		CensusPlus_Database["Guilds"] = nil;
	end
	CensusPlus_Database["Guilds"] = {};

	if( CensusPlus_Database["TimesPlus"] ~= nil ) then
		CensusPlus_Database["TimesPlus"] = nil;
	end
	CensusPlus_Database["TimesPlus"] = {};

	if( CensusPlus_Profile ~= nil ) then
		CensusPlus_Profile = nil;
	end
	CensusPlus_Profile = {};

	if( CensusPlus_BGInfo ~= nil ) then
		CensusPlus_BGInfo = nil;
	end
	CensusPlus_BGInfo = {};

	CensusPlus_Msg( "Data Purged" );
end

-----------------------------------------------------------------------------------
--
-- Handler for auto close checkbox
--
-----------------------------------------------------------------------------------
function CensusPlus_AutoCloseWho(close)
    g_WhoAutoClose = close;
end

-----------------------------------------------------------------------------------
--
-- Take a CensusPlus
--
-----------------------------------------------------------------------------------
function CensusPlus_StartCensus()

	if (g_IsCensusPlusInProgress) then
	    if( g_CensusPlusManuallyPaused == true ) then
	        g_CensusPlusManuallyPaused = false;
	        CensusPlusPauseButton:SetText( CENSUSPlus_PAUSE );
	    else
		    -- Do not initiate a new CensusPlus while one is in progress
		    CensusPlus_Msg(CENSUSPlus_ISINPROGRESS);
		end
--	elseif( g_CurrentlyInBG ) then
--		g_LastCensusRun = time()-600;
--		CensusPlus_Msg(CENSUSPlus_ISINBG);
	else
		--
		--  Set a timer
		--
		g_CensusPlus_StartTime = time();
	
		--
		-- Initialize the job queue and counters
		--
		CensusPlus_Msg(CENSUSPlus_TAKINGONLINE);
		g_NumNewCharacters = 0;
		g_NumUpdatedCharacters = 0;
		g_JobQueue = {};

		g_TempCount = nil;
		g_TempCount = {};

		g_TempZoneCount = nil;
		g_TempZoneCount = {};
		--
		-- First job covers all characters by searching all levels
		--
--		local job = {m_MinLevel = 1, m_MaxLevel = MAX_CHARACTER_LEVEL};
--		InsertJobIntoQueue(job);
        --
        --  Modified job listing, let's go in 5 level increments
        --
        local counter = 0;
        for outer = 0, 10, 1 do
            local job = {m_MinLevel=outer*5+1, m_MaxLevel=outer*5+5};
            InsertJobIntoQueue(job);
        end
        local job = {m_MinLevel=56, m_MaxLevel=59};
        InsertJobIntoQueue(job);
        job = {m_MinLevel=60, m_MaxLevel=60};
        InsertJobIntoQueue(job);

		g_IsCensusPlusInProgress = true;
		g_WaitingForWhoUpdate = false;
		g_CensusPlusManuallyPaused = false;

		local hour, minute = GetGameTime();
		g_TakeHour = hour;
		g_ResetHour = true;


	end

    CensusPlusTakeButton:SetText( CENSUSPlus_PAUSE );

end

-----------------------------------------------------------------------------------
--
-- Stop a CensusPlus
--
-----------------------------------------------------------------------------------
function CensusPlus_StopCensus(  )
	if (g_IsCensusPlusInProgress) then
        CensusPlusTakeButton:SetText( CENSUSPlus_TAKE );
        g_CensusPlusManuallyPaused = false;

		g_JobQueue = {};
		g_JobQueue = nil;
		g_JobQueue = {};


		CensusPlus_DisplayResults( );

		--  Clean up the times
		CensusPlus_PruneTimes();
	else
		CensusPlus_Msg(CENSUSPlus_NOCENSUS);
	end
end

-----------------------------------------------------------------------------------
--
-- Display Census results
--
-----------------------------------------------------------------------------------
function CensusPlus_DisplayResults(  )
	--
	-- We are all done, report our results
	--
	g_IsCensusPlusInProgress = false;
	--CensusPlus_UpdateView();

	CensusPlus_ProcessMyHonor();

	--
	--  Finish our timer
	--
	local total_time = time() - g_CensusPlus_StartTime;

	CensusPlus_Msg(format(CENSUSPlus_FINISHED, g_NumNewCharacters, g_NumUpdatedCharacters, SecondsToTime( total_time )));
	ChatFrame1:AddMessage(CENSUSPlus_UPLOAD, 0.5, 1.0, 1.0);

	CensusPlus_UpdateView();
	g_LastCensusRun = time();

    CensusPlusTakeButton:SetText( CENSUSPlus_TAKE );
    
end

-----------------------------------------------------------------------------------
--
-- Create a who command text for the input job
--
-----------------------------------------------------------------------------------
function CensusPlus_CreateWhoText(job)
	local whoText = "";
	local race = job.m_Race;
	if (race ~= nil) then
		whoText = whoText.." r-\""..race.."\"";
	end

	local class = job.m_Class;
	if (class ~= nil) then
		whoText = whoText.." c-\""..class.."\"";
	end

	local minLevel = job.m_MinLevel;
	if (minLevel == nil) then
		minLevel = 1;
	end
	local maxLevel = job.m_MaxLevel;
	if (maxLevel == nil) then
		maxLevel = 60;
	end
	whoText = whoText.." "..minLevel.."-"..maxLevel;

	local zoneLetter = job.m_zoneLetter;
	if ( zoneLetter ~= nil) then
		whoText = whoText.." z-"..zoneLetter;
	end

	local letter = job.m_Letter;
	if( letter ~= nil ) then
		whoText = whoText.." n-"..letter;
	end
	return whoText;
end

-----------------------------------------------------------------------------------
--
-- Called on events
--
-----------------------------------------------------------------------------------
function CensusPlus_OnEvent(event,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9)

	if( arg1 == nil ) then
		arg1 = "nil"
	end
	if( arg2 == nil ) then
		arg2 = "nil"
	end
	if( arg3 == nil ) then
		arg3 = "nil"
	end
	if( arg4 == nil ) then
		arg4 = "nil"
	end

	--
	-- If we have not been initialized, do nothing
	--
	if (g_CensusPlusInitialized == false) then
		return
	end

--	CensusPlus_Msg( "Message =>" .. event );

	--
	-- WHO_LIST_UPDATE
	--
	if( event == "TRAINER_SHOW" or event == "MERCHANT_SHOW" or event == "TRADE_SHOW" or event == "GUILD_REGISTRAR_SHOW"
	            or event == "AUCTION_HOUSE_SHOW" or event == "BANKFRAME_OPENED" or event == "QUEST_DETAIL" ) then
	    if( g_IsCensusPlusInProgress ) then
	        g_CensusPlusPaused = true;
	    end
	elseif( event == "TRAINER_CLOSED" or event == "MERCHANT_CLOSED" or event == "TRADE_CLOSED" or event == "GUILD_REGISTRAR_CLOSED"
	            or event == "AUCTION_HOUSE_CLOSED" or event == "BANKFRAME_CLOSED" or event == "QUEST_FINISHED" ) then
	    if( g_IsCensusPlusInProgress ) then
	        g_CensusPlusPaused = false;
	    end
	elseif(event == "WHO_LIST_UPDATE") then
		--
		--  First check for an override
		--
		if( g_CensusWhoOverrideMsg ~= nil and g_WaitingForOverrideUpdate == true ) then
			--
			--  Allow the who to act normally
			--
			g_CensusWhoOverrideMsg = nil;
			g_WaitingForOverrideUpdate = false;
			CensusPlus_Msg( CENSUSPlus_OVERRIDE_COMPLETE_BUT_PAUSED );
			g_Pre_WhoList_UpdateOverride();
			
			--
			--  If we opened the who window, do a manual pause and open a dialog
			--
			g_CensusPlusManuallyPaused = true;
	        CensusPlusTakeButton:SetText( CENSUSPlus_UNPAUSE );	
	        
			StaticPopup_Show ("CP_CONTINUE_CENSUS");
						
		elseif ( g_IsCensusPlusInProgress ) then
			--
			-- Only process who results if a CensusPlus is in progress
			--
		
			local numWhoResults = GetNumWhoResults();
			CensusPlus_CheckForBattleground();
			CensusPlus_ProcessWhoResults();
			if (numWhoResults > MAX_WHO_RESULTS) then
				--
				-- Who list is overflowed, split the query to make the return smaller
				--
				local minLevel = g_CurrentJob.m_MinLevel;
				local maxLevel = g_CurrentJob.m_MaxLevel;
				local race = g_CurrentJob.m_Race;
				local class = g_CurrentJob.m_Class;
				local zoneLetter = g_CurrentJob.m_zoneLetter;
				local letter = g_CurrentJob.m_Letter;
				if (minLevel ~= maxLevel) then
					--
					-- The level range is greater than a single level, so split it in half and submit the two jobs
					--
					local pivot = floor((minLevel + maxLevel) / 2);
					local jobLower = {m_MinLevel = minLevel, m_MaxLevel = pivot};
					InsertJobIntoQueue(jobLower);
					local jobUpper = {m_MinLevel = pivot + 1, m_MaxLevel = maxLevel};
					InsertJobIntoQueue(jobUpper);
				else
					--
					-- We cannot split the level range any more
					--
					local factionGroup = UnitFactionGroup("player");
					local level = minLevel;
					if (race == nil) then
						--
						-- This job does not specify race, so split it that way, making four new jobs
						--
						local thisFactionRaces = CensusPlus_GetFactionRaces(factionGroup);
						local numRaces = table.getn(thisFactionRaces);
						for i = 1, numRaces, 1 do
							local job = {m_MinLevel = level, m_MaxLevel = level, m_Race = thisFactionRaces[i]};
							InsertJobIntoQueue(job);
						end
					else
						if (class == nil) then
							--
							-- This job does not specify class, so split it that way, making more jobs
							--
							local thisRaceClasses = GetRaceClasses(race);
							local numClasses = table.getn(thisRaceClasses);
							for i = 1, numClasses, 1 do
								local job = {m_MinLevel = level, m_MaxLevel = level, m_Race = race, m_Class = thisRaceClasses[i]};
								InsertJobIntoQueue(job);
							end
						else
							if( letter == nil ) then
								--
								-- There are too many characters with a single level, class and race
								--     The work around we are going to pursue is to check by name for a,e,i,o,r,s,t,u
								--
								local letters = GetNameLetters();
								for i=1, table.getn( letters ), 1 do
									local job = {m_MinLevel = level, m_MaxLevel = level, m_Race = race, m_Class = class, m_Letter = letters[i]};
									InsertJobIntoQueue(job);
								end
--							else
--								if (zoneLetter == nil) then
									--
									-- This job does not specify zone, so split it that way, making more jobs
									--
--									local zoneLetters = GetZoneLetters();
--									for i=1, table.getn(zoneLetters), 1 do
--										local job = {m_MinLevel = level, m_MaxLevel = level, m_Race = race, m_Class = class, m_Letter = letter, m_zoneLetter = zoneLetters[i]};
--										InsertJobIntoQueue(job);
--									end
								else
									--
									-- There are too many characters with a single level, class, race and letter, give up
									--
									local whoText = CensusPlus_CreateWhoText(g_CurrentJob);
									if( CensusPlus_PerCharInfo["Verbose"] == true ) then
										CensusPlus_Msg(format(CENSUSPlus_TOOMANY, whoText));
									end
								end
--							end
						end
					end
				end
			end
		else
		    --
		    --  This is just a random /who done by the player
		    --
			CensusPlus_ProcessWhoResults();
		end
		--
		-- We got the who update
		--
		g_WaitingForWhoUpdate = false;

	elseif (event == "GUILD_ROSTER_SHOW") then
	    --
	    --  Process Guild info
	    --
--CensusPlus_Msg( " SHOW GUILD " );
--	    CensusPlus_ProcessGuildResults();

	elseif (event == "GUILD_ROSTER_UPDATE") then
	    --
	    --  Process Guild info
	    --
--CensusPlus_Msg( " UPDATE GUILD " );
		if(not CP_updatingGuild ) then
			CP_updatingGuild  = 1;
			CensusPlus_ProcessGuildResults();
			CP_updatingGuild  = nil;
		end


	elseif ( event == "VARIABLES_LOADED" ) then
	    --
	    --  Initialize our variables
	    --
	    CensusPlus_InitializeVariables();
--[[
	elseif ((event == "UNIT_FOCUS" or event=="PLAYER_TARGET_CHANGED" )and arg1 ~= "player") then
		if( UnitIsPlayer( "target" ) and not UnitIsUnit("player", "target") ) then
			if( g_CensusPlusLastTarget ~= nil ) then
				ClearInspectPlayer();
				g_CensusPlusLastTargetName = nil;
				g_CensusPlusLastTarget = nil;
				if( CensusPlus_IsInspectLoaded() ) then
					InspectFrame.unit = nil;
				end
			end
			CensusPlus_ProcessTarget("target");
		end
		]]--
	elseif (event == "CHAT_MSG_SYSTEM" ) then
--		CensusPlus_Msg( "Msg = " .. arg1 );
	elseif (event == "CHAT_MSG_COMBAT_SELF_HITS" ) then
--		CensusPlus_Msg( "Msg = " .. arg1 );
	elseif (event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS" ) then
--		CensusPlus_Msg( "Msg = " .. arg1 );
	elseif (event == "PLAYER_PVP_KILLS_CHANGED" ) then
--		CensusPlus_Msg( "PVP Kills Changed = " .. arg1 .. " 2 - " .. arg2 .. " 3 - " .. arg3);
	elseif( event == "ZONE_CHANGED_NEW_AREA" ) then
		--
		--  We need to check to see if we entered a battleground
		--
		CensusPlus_CheckForBattleground();
	elseif( event == "UPDATE_BATTLEFIELD_STATUS" ) then
		CensusPlus_UpdateBattleGroundInfo();		
	end
end

-----------------------------------------------------------------------------------
--
-- ProcessTarget --  called when UNIT_FOCUS event is fired
--
-----------------------------------------------------------------------------------
function CensusPlus_ProcessTarget( unit )
	--  have to totally disable this due to X-server bg's
	if( true ) then
		return;
	end

	if ( UnitIsPlayer(unit) == nil or (not UnitIsPlayer(unit)) or unit == "player" or unit == nil ) then
		return;
	end

	local sightingData = CensusPlus_CollectSightingData( unit );
	if( sightingData == nil or sightingData.faction == nil ) then
		return
	end

	if (sightingData ~= nil and (sightingData.faction == "Alliance" or sightingData.faction == "Horde")) then

		--
		--  Do a quick check to see if this is an MC'd person
		--
		if( sightingData.faction ~= g_FactionCheck[sightingData.race] ) then
			return;
		end


		if( sightingData.guild == nil ) then
			sightingData.guild = "";
		end
		--
		-- Get the portion of the database for this server
		--
		local realmName = g_CensusPlusLocale .. GetCVar("realmName");
		local realmDatabase = CensusPlus_Database["Servers"][realmName];
		if (realmDatabase == nil) then
			CensusPlus_Database["Servers"][realmName] = {};
			realmDatabase = CensusPlus_Database["Servers"][realmName];
		end

		--
		-- Get the portion of the database for this faction
		--
		local factionDatabase = realmDatabase[sightingData.faction];
		if (factionDatabase == nil) then
			realmDatabase[sightingData.faction] = {};
			factionDatabase = realmDatabase[sightingData.faction];
		end

		--
		-- Get racial database
		--
		local raceDatabase = factionDatabase[sightingData.race];
		if (raceDatabase == nil) then
			factionDatabase[sightingData.race] = {};
			raceDatabase = factionDatabase[sightingData.race];
		end

		--
		-- Get class database
		--
		local classDatabase = raceDatabase[sightingData.class];
		if (classDatabase == nil) then
			raceDatabase[sightingData.class] = {};
			classDatabase = raceDatabase[sightingData.class];
		end

		--
		-- Get this player's entry
		--
		local entry = classDatabase[sightingData.name];
		if (entry == nil) then
			classDatabase[sightingData.name] = {};
			entry = classDatabase[sightingData.name];
		end

		--
		-- Update the information
		--
		entry[1] = sightingData.level;
		entry[2] = sightingData.guild;
		entry[3] = CensusPlus_DetermineServerDate() .. "";

		entry[7] = CensusPlus_DetermineServerDate() .. "";

		--
		--  Update their rank info
		--
		rankNumber = UnitPVPRank(unit);
		if( rankNumber ~= 0 ) then
--			rankName= GetPVPRankInfo( rankNumber )
			entry[8] = rankNumber;  --  slot 8 will be current rank
		else
			entry[8] = 0;  --  slot 8 will be current rank
		end

		--
		--  Trigger an update on the inspect honor frame to get honor information
		--
		if ( UnitIsPlayer( unit ) and sightingData.level >= 30
				and CheckInteractDistance( unit, 1)
				and not UnitIsUnit("player", unit) and unit == "target"
				and g_CensusPlusLastTarget == nil
				and g_CensusPlusLastTargetName == nil
				and CensusPlus_IsInspectLoaded() ) then
			NotifyInspect(unit);
			InspectFrame.unit = unit;
			if ( not HasInspectHonorData() ) then
				g_CensusPlusLastTarget = entry;
			    g_CensusPlusLastTargetName = sightingData.name;
				RequestInspectHonorData();
			else
				InspectHonorFrame_Update();
			end
		end
	end
end


-----------------------------------------------------------------------------------
--
-- Gather targeting data
--
-----------------------------------------------------------------------------------
function CensusPlus_CollectSightingData(unit)
	if ( UnitIsPlayer(unit) and UnitName(unit) ~= "Unknown Entity" ) then
		return {
			name=UnitName(unit),
			level=UnitLevel(unit),
			sex=UnitSex(unit),
			race=UnitRace(unit),
			class=UnitClass(unit),
			guild=GetGuildInfo(unit),
			faction=UnitFactionGroup(unit)
		};
	else
		return nil;
	end
end


-----------------------------------------------------------------------------------
--
-- Initialize our primary save variables --  called when VARIABLES_LOADED event is fired
--
-----------------------------------------------------------------------------------
function CensusPlus_InitializeVariables()

    if( CensusPlus_Database["Servers"] == nil ) then
            CensusPlus_Database["Servers"] = {};
    end

	if( CensusPlus_Database["Times"] ~= nil ) then
		CensusPlus_Database["Times"] = nil;
	end

	if( CensusPlus_Database["TimesPlus"] == nil ) then
	    CensusPlus_Database["TimesPlus"] = {};
	end
	
	if( CensusPlus_BGInfo == nil ) then
		CensusPlus_BGInfo = {};
	end

    --
    --  Make sure info is last so it will be first in the output so we can grab the version number
    --
	if( CensusPlus_Database["Info"] == nil ) then
	    CensusPlus_Database["Info"] = {};
	end
    CensusPlus_Database["Info"]["Version"] = CensusPlus_VERSION;
    CensusPlus_Database["Info"]["ClientLocale"] = GetLocale();
	if( CensusPlus_Database["Info"]["ClientLocale"] == "enUS" and GetCVar("realmList") == "eu.logon.worldofwarcraft.com" ) then
	    CensusPlus_Database["Info"]["ClientLocale"] = "enGB";
	end
	if( CensusPlus_Database["Info"]["LoginServer"] ~= nil ) then
		--  already present, make sure it equals, and if
		--		not, force a purge
		if( CensusPlus_Database["Info"]["LoginServer"] ~= GetCVar("realmList") ) then
			--[[
				We have to nuke the data in the case that someone is playing on both
				US and EU servers
			]]--
			CensusPlus_DoPurge()
		end
	end
    CensusPlus_Database["Info"]["LoginServer"] = GetCVar("realmList");
    
    local firstVersionRun = CensusPlus_Database["Info"][g_InterfaceVersion];
    local localeSetting = CensusPlus_Database["Info"]["Locale"];
    if( localeSetting == "??" ) then
		--  We had problems previously.. we must purge =(
		CensusPlus_DoPurge();
		localeSetting = nil;
    end

	--
	--  Have a new way to detect locale, yay!
	--
	if( CensusPlus_Database["Info"]["ClientLocale"] == "enUS" ) then
		CensusPlus_VerifyLocale( "US" );
		CensusPlus_Database["Info"]["Locale"] = "US";
	elseif( CensusPlus_Database["Info"]["ClientLocale"] == "enGB" or
			CensusPlus_Database["Info"]["ClientLocale"] == "frFR" or
			CensusPlus_Database["Info"]["ClientLocale"] == "deDE" or
			CensusPlus_Database["Info"]["ClientLocale"] == "esES" ) then
		CensusPlus_VerifyLocale( "EU" );
		CensusPlus_Database["Info"]["Locale"] = "EU";
	else
		CensusPlus_VerifyLocale( "??" );
		CensusPlus_Database["Info"]["Locale"] = "??";
	end

    if( firstVersionRun == nil and g_InterfaceVersion == 10900.2 ) then
		--[[
			Unfortunately we have to purge all our PVP data due to data problems
		]]--
		CensusPlus_Database["TimesPlus"] = nil;
		CensusPlus_Database["TimesPlus"] = {};
--		CensusPlus_Msg( "Due to a data discrepancy, all prior data has been purged, sorry!" );
--		CensusPlus_DoPurge();
		CensusPlus_Database["Info"][g_InterfaceVersion] = true;
    end

    local locale = CensusPlus_Database["Info"]["Locale"];
	CensusPlus_SelectLocale( CensusPlus_Database["Info"]["Locale"], true );

	local miniStart = CensusPlus_Database["Info"]["MiniStart"];
	if( miniStart == nil ) then
	    miniStart = 0;
	end

	if( CensusPlus_Database["Info"]["AutoCensus"] == nil ) then
		CensusPlus_Database["Info"]["AutoCensus"] = false;
	end

	if( CensusPlus_Database["Info"]["AutoCensusTimer"] == nil ) then
		CensusPlus_Database["Info"]["AutoCensusTimer"] = 1800;
	end
	
	if( CensusPlus_Database["Info"]["CensusButtonPosition"] == nil ) then
	    CensusPlus_Database["Info"]["CensusButtonPosition"] = 370;
	end

	if( CensusPlus_Database["Info"]["CensusButtonShown"] == nil ) then
	    CensusPlus_Database["Info"]["CensusButtonShown"] = 1;
	end

	if( CensusPlus_Database["Info"]["CensusButtonShown"] == 1 ) then
		CensusButtonFrame:Show();
	else
		CensusButtonFrame:Hide();
	end

    CensusPlus_AutoStart(miniStart);

    if( miniStart ) and (not Khaos) then
		CensusPlus_Msg(" V"..CensusPlus_VERSION..CENSUSPlus_MSG1);
    end

    g_VariablesLoaded = true;

    CensusPlus_CheckTZ();

    InitConstantTables();

    CP_OptionAutoShowMinimapButton:SetChecked(CensusPlus_Database["Info"]["CensusButtonShown"]);
    CP_SliderButtonPos:SetValue(CensusPlus_Database["Info"]["CensusButtonPosition"]);
    
    if( CensusPlus_PerCharInfo["PlayFinishSound"] == nil ) then
		CensusPlus_PerCharInfo["PlayFinishSound"] = true;
	end
	
	CP_OptionPlaySoundOnCompleteButton:SetChecked( CensusPlus_PerCharInfo["PlayFinishSound"]  );	
	
	if( CensusPlus_PerCharInfo["Verbose"] == nil ) then
		CensusPlus_PerCharInfo["Verbose"] = false;
	end
    

    --
    --  If we are in a guild, attempt to gather the guild roster data
    --
    if (IsInGuild()) then
		GuildRoster();
	end
end

-----------------------------------------------------------------------------------
--
-- Call on the update event
--
-----------------------------------------------------------------------------------
function CensusPlus_OnUpdate()
	if( g_VariablesLoaded and g_IsCensusPlusInProgress == false and CensusPlus_Database["Info"]["AutoCensus"] == true and g_LastCensusRun < time() - CensusPlus_Database["Info"]["AutoCensusTimer"] ) then
		CensusPlus_Take_OnClick();
	end

	if (g_IsCensusPlusInProgress == true and g_CensusPlusPaused == false and g_CensusPlusManuallyPaused == false ) then
		local now = GetTime();
		local delta = now - g_LastOnUpdateTime;
		if (delta > CensusPlus_UPDATEDELAY) then
			g_LastOnUpdateTime = now;
			if (g_WaitingForWhoUpdate == true) then
			
				--
				--  First check to see if we are waiting for an override
				--
				if( g_WaitingForOverrideUpdate == true ) then
					SendWho( g_CensusWhoOverrideMsg );
				else
					--
					-- Resend /who command
					--
					g_WhoAttempts = g_WhoAttempts + 1;
					local whoText = CensusPlus_CreateWhoText(g_CurrentJob);
					if( CensusPlus_PerCharInfo["Verbose"] == true ) then
						CensusPlus_Msg(CENSUSPlus_WAITING);
					end
					if( g_WhoAttempts < 3 ) then
						if( g_WhoAttempts == 2 ) then
							g_CurrentJob.m_MinLevel = g_CurrentJob.m_MinLevel - 2;
							whoText = CensusPlus_CreateWhoText(g_CurrentJob);
							SendWho(whoText);
						else
							SendWho(whoText);
						end
					else
						g_WaitingForWhoUpdate = false;
					end
				end
			else
			
				--
				--  Check to see if we have an override waiting
				--
				if( g_CensusWhoOverrideMsg ~= nil ) then
					SendWho( g_CensusWhoOverrideMsg );
					g_WaitingForOverrideUpdate = true;
					g_WaitingForWhoUpdate = true;
				else
					--
					-- Determine if there is any more work to do
					--
					local numJobs = table.getn(g_JobQueue);
					if (numJobs > 0) then
						--
						-- Remove the top job from the queue and send it
						--
						local job = g_JobQueue[numJobs];
						table.remove(g_JobQueue);
						local whoText = CensusPlus_CreateWhoText(job);
						g_CurrentJob = job;
						g_WaitingForWhoUpdate = true;
						if( CensusPlus_PerCharInfo["Verbose"] == true ) then
							CensusPlus_Msg(format(CENSUSPlus_SENDING, whoText));
						end
						SendWho(whoText);
						g_WhoAttempts = 0;
					else
						--
						-- We are all done, hide the friends frame and report our results
						--
						if( CensusPlus_PerCharInfo["PlayFinishSound"] ) then
							PlaySoundFile("Interface\\AddOns\\CensusPlus\\Sounds\\CensusComplete.ogg")
						end
						
						CensusPlus_DoTimeCounts();
						CensusPlus_DisplayResults();
					end
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------
--
-- Take final tally
--
-----------------------------------------------------------------------------------
function CensusPlus_DoTimeCounts()

	if( g_CensusPlusLocale == "N/A" ) then
		return;
	end

	--  Zero out the times
	g_TimeDatabase[CENSUSPlus_DRUID]		= 0;
	g_TimeDatabase[CENSUSPlus_HUNTER]		= 0;
	g_TimeDatabase[CENSUSPlus_MAGE]			= 0;
	g_TimeDatabase[CENSUSPlus_PRIEST]		= 0;
	g_TimeDatabase[CENSUSPlus_ROGUE]		= 0;
	g_TimeDatabase[CENSUSPlus_WARLOCK]	    = 0;
	g_TimeDatabase[CENSUSPlus_WARRIOR]	    = 0;
	g_TimeDatabase[CENSUSPlus_SHAMAN]		= 0;
	g_TimeDatabase[CENSUSPlus_PALADIN]	    = 0;
	g_TimeDatabase[CENSUSPlus_WarsongGulch]	= 0;
	g_TimeDatabase[CENSUSPlus_AlteracValley]= 0;
	g_TimeDatabase[CENSUSPlus_ArathiBasin]	= 0;

	g_NumUpdatedCharacters = 0;

	for charName, charClass in pairs(g_TempCount) do
		g_TimeDatabase[charClass] = g_TimeDatabase[charClass] + 1;
		g_NumUpdatedCharacters = g_NumUpdatedCharacters + 1;
	end

	--  Collect some zone info
	for charName, charZone in pairs(g_TempZoneCount) do
		if( charZone == CENSUSPlus_WarsongGulch or charZone == CENSUSPlus_AlteracValley or charZone == CENSUSPlus_ArathiBasin ) then
			g_TimeDatabase[charZone] = g_TimeDatabase[charZone] + 1;
		end
	end


	local realmName = g_CensusPlusLocale .. GetCVar("realmName");
	if( CensusPlus_Database["TimesPlus"][realmName] == nil ) then
		CensusPlus_Database["TimesPlus"][realmName]= {};
	end

	if( CensusPlus_Database["TimesPlus"][realmName][UnitFactionGroup("player")] == nil ) then
        CensusPlus_Database["TimesPlus"][realmName][UnitFactionGroup("player")] = {};
	end

	local numTimes = table.getn( CensusPlus_Database["TimesPlus"][realmName][UnitFactionGroup("player")] );
	if (numTimes > CP_MAX_TIMES-1 ) then
		--
		-- Remove the top time from the queue
		--
		table.remove( CensusPlus_Database["TimesPlus"][realmName][UnitFactionGroup("player")] );
	end

	local hour, minute = GetGameTime();
--					CensusPlus_Database["TimesPlus"][realmName][UnitFactionGroup("player")]["" .. hour .. ""] = g_TimeDatabase;
	CensusPlus_Database["TimesPlus"][realmName][UnitFactionGroup("player")][CensusPlus_DetermineServerDate() .. "&" .. hour .. ":" .. minute .. ":00"] =
		g_TimeDatabase[CENSUSPlus_DRUID] .. "&" ..
		g_TimeDatabase[CENSUSPlus_HUNTER] .. "&" ..
		g_TimeDatabase[CENSUSPlus_MAGE] .. "&" ..
		g_TimeDatabase[CENSUSPlus_PRIEST] .. "&" ..
		g_TimeDatabase[CENSUSPlus_ROGUE] .. "&" ..
		g_TimeDatabase[CENSUSPlus_WARLOCK] .. "&" ..
		g_TimeDatabase[CENSUSPlus_WARRIOR] .. "&" ..
		g_TimeDatabase[CENSUSPlus_SHAMAN] .. "&" ..
		g_TimeDatabase[CENSUSPlus_PALADIN] .. "&" ..
		g_TimeDatabase[CENSUSPlus_WarsongGulch] .. "&" ..
		g_TimeDatabase[CENSUSPlus_AlteracValley] .. "&" ..
		g_TimeDatabase[CENSUSPlus_ArathiBasin];
end

-----------------------------------------------------------------------------------
--
-- Add the contents of the guild results to the database
--
-----------------------------------------------------------------------------------
function CensusPlus_ProcessGuildResults()

    if( g_VariablesLoaded == false ) then
        return;
    end

    if( CensusPlus_Database["Info"]["Locale"] == nil ) then
		return;
	end
	
	if( g_CensusPlusLocale == "N/A" ) then
		return;
	end
	

    --
    --  Grab temp var
    --
	local showOfflineTemp = GetGuildRosterShowOffline();
	SetGuildRosterShowOffline(1);


	--
	-- Walk through the guild info
	--
    local numGuildMembers = GetNumGuildMembers();
--	CensusPlus_Msg("Processing "..numGuildMembers.." guild members.");

    local realmName = g_CensusPlusLocale .. GetCVar("realmName");
    CensusPlus_Database["Guilds"] = nil;
    if( CensusPlus_Database["Guilds"] == nil ) then
		CensusPlus_Database["Guilds"] = {};
    end

	if (CensusPlus_Database["Guilds"][realmName] == nil) then
		CensusPlus_Database["Guilds"][realmName] = {};
	end

	local guildRealmDatabase = CensusPlus_Database["Guilds"][realmName];
	if (guildRealmDatabase == nil) then
		CensusPlus_Database["Guilds"][realmName] = {};
		guildRealmDatabase = CensusPlus_Database["Guilds"][realmName];
	end

	local factionGroup = UnitFactionGroup("player");
	if( factionGroup == nil ) then
	    CensusPlus_Database["Guilds"] = nil;
		SetGuildRosterShowOffline(showOfflineTemp);
	    return;
	end

	local factionDatabase = guildRealmDatabase[factionGroup];
	if (factionDatabase == nil) then
		guildRealmDatabase[factionGroup] = {};
		factionDatabase = guildRealmDatabase[factionGroup];
	end

	CensusPlus_Database["Guilds"][realmName][factionGroup] = nil;
	CensusPlus_Database["Guilds"][realmName][factionGroup] = {};

	factionDatabase = CensusPlus_Database["Guilds"][realmName][factionGroup];

    local Ginfo = GetGuildInfo("player");
	if( Ginfo == nil ) then
	    CensusPlus_Database["Guilds"] = nil;
		SetGuildRosterShowOffline(showOfflineTemp);
	    return;
	end
	local guildDatabase = factionDatabase[Ginfo];
	if (guildDatabase == nil) then
		factionDatabase[Ginfo] = {};
		guildDatabase = factionDatabase[Ginfo];
	end

	local info = guildDatabase["GuildInfo"];
	if (info == nil) then
		guildDatabase["GuildInfo"] = {};
		info = guildDatabase["GuildInfo"];
	end

	info["Update"] = date( "%m-%d-%Y", time()) .. "";
	info["ShowOnline"] = 1;  --  Variable comes from FriendsFrame

	guildDatabase["Members"] = nil;
	guildDatabase["Members"] = {};

	local members = guildDatabase["Members"];

    for index = 1, numGuildMembers, 1 do
		local name, rank, rankIndex, level, class, zone, note, officernote, online, status = GetGuildRosterInfo(index);

        if( members[name] == nil ) then
            members[name] = {};
        end

--        CensusPlus_Msg( "Name =>" .. name );
--        CensusPlus_Msg( "rank =>" .. rank );
--        CensusPlus_Msg( "rankIndex =>" .. rankIndex );
--        CensusPlus_Msg( "level =>" .. level );
--        CensusPlus_Msg( "class =>" .. class );
        members[name]["Rank"] = rank;
        members[name]["RankIndex"] = rankIndex;
        members[name]["Level"]= level;
        members[name]["Class"]= class;
--        members[name]["Zone"]= zone;
--        members[name]["Note"]= CensusPlus_SafeSet( note );
--        members[name]["OfficerNote"]= CensusPlus_SafeSet( officernote );
--        members[name]["Online"]= online;
--        members[name]["Status"]= CensusPlus_SafeSet( status );
    end

	SetGuildRosterShowOffline(showOfflineTemp);
end

function CensusPlus_SafeCheck( param )
    if( param == nil ) then
        return "nil";
    else
        return param;
    end
end

-----------------------------------------------------------------------------------
--
-- Add the contents of the who results to the database
--
-----------------------------------------------------------------------------------
function CensusPlus_ProcessWhoResults()

	--
	--  If we are in a BG then stop a census
	--
--    if( g_CurrentlyInBG and g_IsCensusPlusInProgress ) then
--		g_LastCensusRun = time()-600;
--		CensusPlus_Msg(CENSUSPlus_ISINBG);
--		CensusPlus_StopCensus( );
--	end

	if( g_CensusPlusLocale == "N/A" ) then
		return;
	end

	--
	-- Get the portion of the database for this server
	--
	local realmName = g_CensusPlusLocale .. GetCVar("realmName");
	local realmDatabase = CensusPlus_Database["Servers"][realmName];
	if (realmDatabase == nil) then
		CensusPlus_Database["Servers"][realmName] = {};
		realmDatabase = CensusPlus_Database["Servers"][realmName];
	end

	--
	-- Get the portion of the database for this faction
	--
	local factionGroup = UnitFactionGroup("player");
	local factionDatabase = realmDatabase[factionGroup];
	if (factionDatabase == nil) then
		realmDatabase[factionGroup] = {};
		factionDatabase = realmDatabase[factionGroup];
	end

	--
	-- Walk through all the who results
	--
	local numWhoResults = GetNumWhoResults();
	if( CensusPlus_PerCharInfo["Verbose"] == true ) then
	    CensusPlus_Msg(format(CENSUSPlus_PROCESSING, numWhoResults));
	end
	for i = 1, numWhoResults, 1 do
		--
		-- Get who result entry
		--
		local name, guild, level, race, class, zone, group = GetWhoInfo(i);

		--
		--  Test the name for possible color coding
		--
		--  for example |cffff0000Rollie|r
        local karma_check = string.find( name, "|cff" );
        if( karma_check ~= nil ) then
			name = string.sub( name, 11, -3 );
        end

		--
		-- Get racial database
		--
		local raceDatabase = factionDatabase[race];
		if (raceDatabase == nil) then
			factionDatabase[race] = {};
			raceDatabase = factionDatabase[race];
		end

		--
		-- Get class database
		--
		local classDatabase = raceDatabase[class];
		if (classDatabase == nil) then
			raceDatabase[class] = {};
			classDatabase = raceDatabase[class];
		end

		--
		-- Get this player's entry
		--
		local entry = classDatabase[name];
		if (entry == nil) then
			classDatabase[name] = {};
			entry = classDatabase[name];
			g_NumNewCharacters = g_NumNewCharacters + 1;
		end

		--
		-- Update the information
		--
		entry[1] = level;
		entry[2] = guild;
--		local hour, minute = GetGameTime();
		entry[3] = CensusPlus_DetermineServerDate() .. "";

		g_TempCount[name] = class;
		g_TempZoneCount[name] = zone;

	end
--	CensusPlus_UpdateView();
end

----------------------------------------------------------------------------------
--
-- Find a guild in the CensusPlus_Guilds array by name
--
---------------------------------------------------------------------------------
local function FindGuildByName(name)
	local i;
	local size = table.getn(CensusPlus_Guilds);
	for i = 1, size, 1 do
		local entry = CensusPlus_Guilds[i];
		if (entry.m_Name == name) then
			return i;
		end
	end
	return nil;
end

----------------------------------------------------------------------------------
--
-- Add up the total character XP and count
--
---------------------------------------------------------------------------------
local g_AccumulateGuildTotals = true;
local function TotalsAccumulator(name, level, guild)
	--
	--  Add character to our player list
	--
	CensusPlus_AddPlayerToList( name, level, guild );

	if( g_TotalCharacterXPPerLevel[level] ) then
		InitConstantTables();
	end

	local totalCharacterXP = g_TotalCharacterXPPerLevel[level];
	if( totalCharacterXP == nil ) then
		totalCharacterXP = 0;
	end
	if( g_TotalCharacterXP == nil ) then
		g_TotalCharacterXP = 0;
	end
	g_TotalCharacterXP = g_TotalCharacterXP + totalCharacterXP;
	g_TotalCount = g_TotalCount + 1;
	if (g_AccumulateGuildTotals and (guild ~= nil)) then
		local index = FindGuildByName(guild);
		if (index == nil) then
			local size = table.getn(CensusPlus_Guilds);
			index = size + 1;
			CensusPlus_Guilds[index] = {m_Name = guild, m_TotalCharacterXP = 0, m_Count = 0};
		end
		local entry = CensusPlus_Guilds[index];
		entry.m_TotalCharacterXP = entry.m_TotalCharacterXP + totalCharacterXP;
		entry.m_Count = entry.m_Count + 1;
	end
end

----------------------------------------------------------------------------------
--
-- Predicate function which can be used to compare two guilds for sorting
--
---------------------------------------------------------------------------------
local function GuildPredicate(lhs, rhs)
	--
	-- nil references are always less than
	--
	if (lhs == nil) then
		if (rhs == nil) then
			return false;
		else
			return true;
		end
	elseif (rhs == nil) then
		return false;
	end
	--
	-- Sort by total XP first
	--
	if (rhs.m_TotalCharacterXP < lhs.m_TotalCharacterXP) then
		return true;
	elseif (lhs.m_TotalCharacterXP < rhs.m_TotalCharacterXP) then
		return false;
	end
	--
	-- Sort by name
	--
	if (lhs.m_Name < rhs.m_Name) then
		return true;
	elseif (rhs.m_Name < lhs.m_Name) then
		return false;
	end

	--
	-- identical
	--
	return false;
end


----------------------------------------------------------------------------------
--
-- Another accumulator for adding up XP and counts
--
---------------------------------------------------------------------------------
local g_AccumulatorCount = 0;
local g_AccumulatorXPTotal = 0;
local function CensusPlus_Accumulator(name, level, guild)
	if( g_TotalCharacterXPPerLevel[level] == nil ) then
		InitConstantTables();
	end
	local totalCharacterXP = g_TotalCharacterXPPerLevel[level];
	if( totalCharacterXP == nil or g_TotalCharacterXPPerLevel[level] == nil ) then
		return;
	end
	g_AccumulatorXPTotal = g_AccumulatorXPTotal + totalCharacterXP;
	g_AccumulatorCount = g_AccumulatorCount + 1;
end

----------------------------------------------------------------------------------
--
-- Reset the above accumulator
--
---------------------------------------------------------------------------------
function CensusPlus_ResetAccumulator()
	g_AccumulatorCount = 0;
	g_AccumulatorXPTotal = 0;
end


----------------------------------------------------------------------------------
--
-- Search the character database using the search criteria and update display
--
---------------------------------------------------------------------------------
function CensusPlus_UpdateView()

	--
	--  No need to do anything if the window is not open
	--
	if( not CensusPlus:IsVisible() ) then
		return;
	end
	
	if( g_CensusPlusLocale == "N/A" ) then
		return;
	end

	--
	-- Get realm and faction
	--
	local realmName = g_CensusPlusLocale .. GetCVar("realmName");
	if( realmName == nil ) then
		return;
	end
	CensusPlusRealmName:SetText(format(CENSUSPlus_REALMNAME, realmName));

	local factionGroup = UnitFactionGroup("player");
	if( factionGroup == nil ) then
		return;
	end

	CensusPlusFactionName:SetText(format(CENSUSPlus_FACTION, factionGroup));

	if( CensusPlus_Database["Info"]["Locale"] ~= nil ) then
		CensusPlusLocaleName:SetText(format(CENSUSPlus_LOCALE, CensusPlus_Database["Info"]["Locale"]));
	end

	local guildKey = nil;
	local raceKey = nil;
	local classKey = nil;
	local levelKey = nil;
	g_TotalCharacterXP = 0;
	g_TotalCount = 0;
	
	--
	-- Has the user selected a guild?
	--
	if (g_GuildSelected > 0) then
		guildKey = CensusPlus_Guilds[g_GuildSelected].m_Name;
	end
	if (g_RaceSelected > 0) then
		local thisFactionRaces = CensusPlus_GetFactionRaces(factionGroup);
		raceKey = thisFactionRaces[g_RaceSelected];
	end
	if (g_ClassSelected > 0) then
		local thisFactionClasses = CensusPlus_GetFactionClasses(factionGroup);
		classKey = thisFactionClasses[g_ClassSelected];
	end
	if (g_LevelSelected > 0 or g_LevelSelected < 0) then
		levelKey = g_LevelSelected;
	end

	debugprofilestart();

	--
	-- Has the user added any search criteria?
	--
	if ((guildKey ~= nil) or (raceKey ~= nil) or (classKey ~= nil) or (levelKey ~= nil)) then
		--
		-- Get totals for this criteria
		--
		g_AccumulateGuildTotals = false;
		CensusPlus_ForAllCharacters(realmName, factionGroup, raceKey, classKey, guildKey, levelKey, TotalsAccumulator);
		
		if( CensusPlus_EnableProfiling ) then
			CensusPlus_Msg( "PROFILE: Time to do calcs 1 " .. debugprofilestop() / 1000000000 );
			debugprofilestart();
		end
		
	else
		--
		-- Get the overall totals and find guild information
		--
		CensusPlus_Guilds = {};
		g_AccumulateGuildTotals = true;
		CensusPlus_ForAllCharacters(realmName, factionGroup, nil, nil, nil, nil, TotalsAccumulator);
		
		if( CensusPlus_EnableProfiling ) then
			CensusPlus_Msg( "PROFILE: Time to do calcs 1 " .. debugprofilestop() / 1000000000 );
			debugprofilestart();
		end
		
		local size = table.getn(CensusPlus_Guilds);
		if (size) then
			table.sort(CensusPlus_Guilds, GuildPredicate);
		end
		
		if( CensusPlus_EnableProfiling ) then
			CensusPlus_Msg( "PROFILE: Time to sort guilds " .. debugprofilestop() / 1000000000 );
			debugprofilestart();
		end			
	end
	
	local levelSearch = nil;
	if (levelKey ~= nil) then
		levelSearch = "  ("..CENSUSPlus_LEVEL..": ";
		local level = levelKey;
		if (levelKey < 0) then
			levelSearch = levelSearch.."!";
			level = 0 - levelKey;
		end
		levelSearch = levelSearch..level..")";
	end

	local totalCharactersText = nil;
	if (levelSearch ~= nil) then
		totalCharactersText = format(CENSUSPlus_TOTALCHAR, g_TotalCount)..levelSearch;
	else
		totalCharactersText = format(CENSUSPlus_TOTALCHAR, g_TotalCount);
	end
	CensusPlusTotalCharacters:SetText(totalCharactersText);
	CensusPlusTotalCharacterXP:SetText(format(CENSUSPlus_TOTALCHARXP, g_TotalCharacterXP));
	CensusPlus_UpdateGuildButtons();
	
	if( CensusPlus_EnableProfiling ) then
		CensusPlus_Msg( "PROFILE: Update Guilds " .. debugprofilestop() / 1000000000 );
		debugprofilestart();
	end
	
	--
	-- Accumulate totals for each race
	--
	local maxCount = 0;
	local thisFactionRaces = CensusPlus_GetFactionRaces(factionGroup);
	local numRaces = table.getn(thisFactionRaces);
	for i = 1, numRaces, 1 do
		local race = thisFactionRaces[i];
		CensusPlus_ResetAccumulator();
		if ((raceKey == nil) or (raceKey == race)) then
			CensusPlus_ForAllCharacters(realmName, factionGroup, race, classKey, guildKey, levelKey, CensusPlus_Accumulator);
		end
		if (g_AccumulatorCount > maxCount) then
			maxCount = g_AccumulatorCount;
		end
		g_RaceCount[i] = g_AccumulatorCount;
	end

	--
	-- Update race bars
	--
	for i = 1, numRaces, 1 do
		local race = thisFactionRaces[i];
		local buttonName = "CensusPlusRaceBar"..i;
		local button = getglobal(buttonName);
		local thisCount = g_RaceCount[i];
		if ((thisCount ~= nil) and (thisCount > 0) and (maxCount > 0)) then
			local height = floor((thisCount / maxCount) * CensusPlus_MAXBARHEIGHT);
			if (height < 1 or height == nil ) then height = 1; end
			button:SetHeight(height);
			button:Show();
		else
			button:Hide();
		end
		local normalTextureName="Interface\\AddOns\\CensusPlus\\Skin\\CensusPlus_"..g_RaceClassList[race];
		local legendName = "CensusPlusRaceLegend"..i;
		local legend = getglobal(legendName);
		legend:SetNormalTexture(normalTextureName);
		if (g_RaceSelected == i) then
			legend:LockHighlight();
		else
			legend:UnlockHighlight();
		end
	end

	if( CensusPlus_EnableProfiling ) then
		CensusPlus_Msg( "PROFILE: Update Races " .. debugprofilestop() / 1000000000 );
		debugprofilestart();
	end

	--
	-- Accumulate totals for each class
	--
	local maxCount = 0;
	local thisFactionClasss = CensusPlus_GetFactionClasses(factionGroup);
	local numClasses = table.getn(thisFactionClasss);
	for i = 1, numClasses, 1 do
		local class = thisFactionClasss[i];
		CensusPlus_ResetAccumulator();
		if ((classKey == nil) or (classKey == class)) then
			CensusPlus_ForAllCharacters(realmName, factionGroup, raceKey, class, guildKey, levelKey, CensusPlus_Accumulator);
		end
		if (g_AccumulatorCount > maxCount) then
			maxCount = g_AccumulatorCount;
		end
		g_ClassCount[i] = g_AccumulatorCount;
	end

	--
	-- Update class bars
	--
	for i = 1, numClasses, 1 do
		local class = thisFactionClasss[i];

		local buttonName = "CensusPlusClassBar"..i;
		local button = getglobal(buttonName);
		local thisCount = g_ClassCount[i];
		if ((thisCount ~= nil) and (thisCount > 0) and (maxCount > 0)) then
			local height = floor((thisCount / maxCount) * CensusPlus_MAXBARHEIGHT);
			if (height < 1 or height == nil ) then height = 1; end
			button:SetHeight(height);
			button:Show();
		else
			button:Hide();
		end

		local normalTextureName="Interface\\AddOns\\CensusPlus\\Skin\\CensusPlus_"..g_RaceClassList[class];
		local legendName = "CensusPlusClassLegend"..i;
		local legend = getglobal(legendName);
		legend:SetNormalTexture(normalTextureName);
		if (g_ClassSelected == i) then
			legend:LockHighlight();
		else
			legend:UnlockHighlight();
		end
	end

	if( CensusPlus_EnableProfiling ) then
		CensusPlus_Msg( "PROFILE: Update Classes " .. debugprofilestop() / 1000000000 );
		debugprofilestart();
	end

	--
	-- Accumulate totals for each level
	--
	local maxCount = 0;
	for i = 1, MAX_CHARACTER_LEVEL, 1 do
	    if ((levelKey == nil) or (levelKey == i) or (levelKey < 0 and levelKey + i ~= 0)) then
			CensusPlus_ResetAccumulator();
			CensusPlus_ForAllCharacters(realmName, factionGroup, raceKey, classKey, guildKey, i, CensusPlus_Accumulator);
			if (g_AccumulatorCount > maxCount) then
				maxCount = g_AccumulatorCount;
			end
			g_LevelCount[i] = g_AccumulatorCount;
		else
			g_LevelCount[i] = 0;
		end
	end

	--
	-- Update level bars
	--
	for i = 1, MAX_CHARACTER_LEVEL, 1 do
		local buttonName = "CensusPlusLevelBar"..i;
		local buttonEmptyName = "CensusPlusLevelBarEmpty"..i;
		local button = getglobal(buttonName);
		local emptyButton = getglobal(buttonEmptyName);
		local thisCount = g_LevelCount[i];
		if ((thisCount ~= nil) and (thisCount > 0) and (maxCount > 0)) then
			local height = floor((thisCount / maxCount) * CensusPlus_MAXBARHEIGHT);
			if (height < 1 or height == nil ) then height = 1; end
			button:SetHeight(height);
			button:Show();
			if (emptyButton ~= nil) then
				emptyButton:Hide();
			end
		else
			button:Hide();
			if (emptyButton ~= nil) then
				emptyButton:SetHeight(CensusPlus_MAXBARHEIGHT);
				emptyButton:Show();
			end
		end
	end
	
	if( CensusPlus_EnableProfiling ) then
		CensusPlus_Msg( "PROFILE: Update Levels " .. debugprofilestop() / 1000000000 );
		debugprofilestart();	
	end
	
	if( CP_PlayerListWindow:IsVisible() ) then
		CensusPlus_PlayerListOnShow();
	end
	

	debugprofilestop();
	
end

----------------------------------------------------------------------------------
--
-- Walk the character database and call the callback function for every entry that matches the search criteria
--
---------------------------------------------------------------------------------
function CensusPlus_ForAllCharacters(realmKey, factionKey, raceKey, classKey, guildKey, levelKey, callback)
	for realmName, realmDatabase in pairs(CensusPlus_Database["Servers"]) do
		if ((realmKey == nil) or (realmKey == realmName)) then
			for factionName, factionDatabase in pairs(realmDatabase) do
				if ((factionKey == nil) or (factionKey == factionName)) then
					for raceName, raceDatabase in pairs(factionDatabase) do
						if ((raceKey == nil) or (raceKey == raceName)) then
							for className, classDatabase in pairs(raceDatabase) do
								if ((classKey == nil) or (classKey == className)) then
									for characterName, character in pairs(classDatabase) do
									local characterGuild = character[2];
										if ((guildKey == nil) or (guildKey == characterGuild)) then
											local characterLevel = character[1];
											if( characterLevel == nil ) then
												characterLevel = 0;
											end
											if ((levelKey == nil) or (levelKey == characterLevel) or (levelKey < 0 and levelKey + characterLevel ~= 0)) then
												callback(characterName, characterLevel, characterGuild, raceName, className, character[3] );
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

----------------------------------------------------------------------------------
--
-- Race legend clicked
--
---------------------------------------------------------------------------------
function CensusPlus_OnClickRace()
	local id = this:GetID();
	if (id == g_RaceSelected) then
		g_RaceSelected = 0;
	else
		g_RaceSelected = id;
	end
	CensusPlus_UpdateView();
end

----------------------------------------------------------------------------------
--
-- Class legend clicked
--
---------------------------------------------------------------------------------
function CensusPlus_OnClickClass()
	local id = this:GetID();
	if (id == g_ClassSelected) then
		g_ClassSelected = 0;
	else
		g_ClassSelected = id;
	end
	CensusPlus_UpdateView();
end


----------------------------------------------------------------------------------
--
-- Level bar loaded
--
---------------------------------------------------------------------------------
function CensusPlus_OnLoadLevel()
	this:RegisterForClicks("LeftButtonUp","RightButtonUp");
end

----------------------------------------------------------------------------------
--
-- Level bar clicked
--
---------------------------------------------------------------------------------
function CensusPlus_OnClickLevel(button)
	local id = this:GetID();
	if (((button == "LeftButton") and (id == g_LevelSelected)) or ((button == "RightButton") and (id + g_LevelSelected == 0))) then
		g_LevelSelected = 0;
	elseif (button == "RightButton") then
		g_LevelSelected = 0 - id;
	else
		g_LevelSelected = id;
	end
	CensusPlus_UpdateView();
end

----------------------------------------------------------------------------------
--
-- Race tooltip
--
---------------------------------------------------------------------------------
function CensusPlus_OnEnterRace()
	local factionGroup = UnitFactionGroup("player");
	local thisFactionRaces = CensusPlus_GetFactionRaces(factionGroup);
	local id = this:GetID();
	local raceName = thisFactionRaces[id];
	local count = g_RaceCount[id];
	if (count ~= nil) then
	    local percent = floor((count / g_TotalCount) * 100);
	    GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	    GameTooltip:SetText(raceName.."\n"..count.."\n"..percent.."%", 1.0, 1.0, 1.0);
	    GameTooltip:Show();
	end
end

----------------------------------------------------------------------------------
--
-- Class tooltip
--
---------------------------------------------------------------------------------
function CensusPlus_OnEnterClass()
	local factionGroup = UnitFactionGroup("player");
	local thisFactionClasses = CensusPlus_GetFactionClasses(factionGroup);
	local id = this:GetID();
	local className = thisFactionClasses[id];
	local count = g_ClassCount[id];
	if (count ~= nil) then
	    local percent = floor((count / g_TotalCount) * 100);
	    GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	    GameTooltip:SetText(className.."\n"..count.."\n"..percent.."%", 1.0, 1.0, 1.0);
	    GameTooltip:Show();
	end
end

----------------------------------------------------------------------------------
--
-- Level tooltip
--
---------------------------------------------------------------------------------
function CensusPlus_OnEnterLevel()
	local id = this:GetID();
	local count = g_LevelCount[id];
	if (count ~= nil) then
		local percent = floor((count / g_TotalCount) * 100);
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetText("Level "..id.."\n"..count.."\n"..percent.."%", 1.0, 1.0, 1.0);
		GameTooltip:Show();
	end
end

----------------------------------------------------------------------------------
--
-- Clicked a guild button
--
---------------------------------------------------------------------------------
function CensusPlus_GuildButton_OnClick()
	local id = this:GetID();
	local offset = FauxScrollFrame_GetOffset(CensusPlusGuildScrollFrame);
	local newSelection = id + offset;
	if (g_GuildSelected ~= newSelection) then
		g_GuildSelected = newSelection;
	else
		g_GuildSelected = 0;
	end
	CensusPlus_UpdateView();
end

----------------------------------------------------------------------------------
--
-- Update the guild button contents
--
---------------------------------------------------------------------------------
function CensusPlus_UpdateGuildButtons()
	--
	-- Determine where the scroll bar is
	--
	local offset = FauxScrollFrame_GetOffset(CensusPlusGuildScrollFrame);
	--
	-- Walk through all the rows in the frame
	--
	local size = table.getn(CensusPlus_Guilds);
	local i = 1;
	while (i <= CensusPlus_NUMGUILDBUTTONS) do
		--
		-- Get the index to the ad displayed in this row
		--
		local iGuild = i + offset;
		--
		-- Get the button on this row
		--
		local button = getglobal("CensusPlusGuildButton"..i);
		--
		-- Is there a valid guild on this row?
		--
		if (iGuild <= size) then
			local guild = CensusPlus_Guilds[iGuild];
			--
			-- Update the button text
			--
			button:Show();
			local textField = "CensusPlusGuildButton"..i.."Text";
			if (guild.m_Name == "") then
				getglobal(textField):SetText(CENSUSPlus_UNGUILDED);
			else
				getglobal(textField):SetText(guild.m_Name);
			end
			--
			-- If this is the guild, highlight it
			--
			if (g_GuildSelected == iGuild) then
				button:LockHighlight();
			else
				button:UnlockHighlight();
			end
		else
			--
			-- Hide the button
			--
			button:Hide();
		end
		--
		-- Next row
		--
		i = i + 1;
	end
	--
	-- Update the scroll bar
	--
	FauxScrollFrame_Update(CensusPlusGuildScrollFrame, size, CensusPlus_NUMGUILDBUTTONS, CensusPlus_GUILDBUTTONSIZEY);
end


----------------------------------------------------------------------------------
--
-- Census_AutoStartOnLoad
--
---------------------------------------------------------------------------------
function Census_AutoStartOnLoad( )
    CP_OptionAutoStartButton:SetChecked(g_MiniOnStart);
    if( g_MiniOnStart == 1 ) then
        MiniCensusPlus:Show();
    else
        MiniCensusPlus:Hide();
    end
        MiniCensusPlus:Hide();
end

----------------------------------------------------------------------------------
--
-- CensusPlus_AutoStart - Set the auto-start option
--
---------------------------------------------------------------------------------
function CensusPlus_AutoStart( check )
    g_MiniOnStart = check;
    CensusPlus_Database["Info"]["MiniStart"] = g_MiniOnStart;
    Census_AutoStartOnLoad();
end


----------------------------------------------------------------------------------
--
-- CensusPlus_VerifyLocale - Set the locale (US or EU)
--
---------------------------------------------------------------------------------
function CensusPlus_VerifyLocale( locale )
	if( CensusPlus_Database["Info"]["Locale"] ~= locale ) then
		--
		--  Purge 
		--
		CensusPlus_DoPurge()
	end
end

----------------------------------------------------------------------------------
--
-- CensusPlus_SelectLocale - Set the locale (US or EU)
--
---------------------------------------------------------------------------------
function CensusPlus_SelectLocale( locale, auto )

	if( not auto ) then
		CensusPlus_Msg( "You have set your locale to " .. locale .. " from " .. g_CensusPlusLocale );
	end

	g_CensusPlusLocale = locale;
    if( g_CensusPlusLocale == "EU" ) then
		g_CensusPlusLocale = g_CensusPlusLocale .. "-";
	else
		g_CensusPlusLocale = "";
    end


	if( CensusPlus_Database["Info"]["Locale"] ~= locale ) then
		if( not ( CensusPlus_Database["Info"]["Locale"] == nil and locale == "US" ) ) then
			CensusPlus_Msg( "Locale differs from previous setting, purging database." );
			CensusPlus_DoPurge();
			CensusPlus_Database["Info"]["Locale"] = locale;
		end
	end
	CensusPlus_Database["Info"]["Locale"] = locale;

	textLine = getglobal("CensusPlusText");
	textLine:SetText("Census+ v"..CensusPlus_VERSION .. " " .. g_CensusPlusLocale );

    if(( CENSUSPlus_DWARF == "Nain" or CENSUSPlus_DWARF == "Zwerg" ) and GetLocale() == "usEN") then
		CensusPlus_Msg( "You appear to have a US Census version, yet your localization is set to French or German." );
		CensusPlus_Msg( "Please do not upload stats to WarcraftRealms until this has been resolved." );
		CensusPlus_Msg( "If this is incorrect, please let Rollie know at www.WarcraftRealms.com about your situation so he can make corrections." );
    end

	CP_EU_US_Version:Hide();

end

----------------------------------------------------------------------------------
--
-- Walk the character database prune all characters entries that are older than 30 days
--
---------------------------------------------------------------------------------
function CensusPlus_PruneData( nDays, sServer )

	if( g_CensusPlusLocale == "N/A" ) then
		return;
	end


	local thisRealmName = g_CensusPlusLocale .. GetCVar("realmName");

	if( sServer == 1 ) then
		nDays = 0;
	end

	local pruneTime = 24 * 60 * 60 * nDays;

	for realmName, realmDatabase in pairs(CensusPlus_Database["Servers"]) do
		if ((realmKey == nil) or (realmKey == realmName)) then
			for factionName, factionDatabase in pairs(realmDatabase) do
				if ((factionKey == nil) or (factionKey == factionName)) then
					for raceName, raceDatabase in pairs(factionDatabase) do
						if ((raceKey == nil) or (raceKey == raceName)) then
							for className, classDatabase in pairs(raceDatabase) do
								if ((classKey == nil) or (classKey == className)) then
									for characterName, character in pairs(classDatabase) do
										if( characterName ~= nil ) then
											if( sServer == 1 ) then
												if( realmName ~= thisRealmName ) then
													CensusPlus_AccumulatePruneData( realmName, factionName, raceName, className, characterName );
												end
											else
												local lastSeen = character[3]; --  2005-05-02

												local tYear, tMonth, tDay;
												tYear = string.sub( lastSeen,  1, 4 );
												tMonth = string.sub( lastSeen, 6, 7 );
												tDay   = string.sub( lastSeen, 9 );

												local lastSeenTime = time( {year=tYear, month=tMonth, day=tDay, hour=0} );

												if( time() - lastSeenTime > pruneTime ) then
													CensusPlus_AccumulatePruneData( realmName, factionName, raceName, className, characterName );
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	CensusPlus_PruneTimes();
	CensusPlus_UpdateView();
	CensusPlus_PruneTheData();
end

-----------------------------------------------------------------------------------
--
-- Prune the accumulation
--
-----------------------------------------------------------------------------------
function CensusPlus_AccumulatePruneData( realm, faction, race, class, name )
	local pruneData = {};
	pruneData.realm = realm;
	pruneData.faction = faction;
	pruneData.race = race;
	pruneData.class = class;
	pruneData.name = name;

	table.insert(g_AccumulatedPruneData, pruneData);
end
-----------------------------------------------------------------------------------
--
-- Prune the accumulation
--
-----------------------------------------------------------------------------------
function CensusPlus_PruneTheData()
	local num = table.getn(g_AccumulatedPruneData);
	while( num > 0 )do
		--
		-- Remove the top job from the queue and send it
		--
		local pruneData = g_AccumulatedPruneData[num];

		CensusPlus_Database["Servers"][pruneData.realm][pruneData.faction][pruneData.race][pruneData.class][pruneData.name] = {};
		CensusPlus_Database["Servers"][pruneData.realm][pruneData.faction][pruneData.race][pruneData.class][pruneData.name] = nil;

		table.remove(g_AccumulatedPruneData);
		num = table.getn(g_AccumulatedPruneData);
	end
end

-----------------------------------------------------------------------------------
--
-- Prune time entries
--
-----------------------------------------------------------------------------------
function CensusPlus_PruneTimes()
	local pruneDays = 60*60*24*21; --  num seconds

    local accumTimesData = {};
	for realmName, realmDatabase in pairs(CensusPlus_Database["TimesPlus"]) do
		if (realmName ~= nil ) then
			for factionName, factionDatabase in pairs(realmDatabase) do
				if ( factionName ~= nil) then
					for moment, count in pairs( factionDatabase ) do
						--  Moment is in format of YYYY-MM-DD&HH:MM
						local test = string.sub( moment, 1, 2 );
						local tYear, tMonth, tDay;
						tYear = string.sub( moment,  1, 4 );
						tMonth = string.sub( moment, 6, 7 );
						tDay   = string.sub( moment, 9, 10 );
						local momentTime = time( {year=tYear, month=tMonth, day=tDay, hour=0} );

						if( time() - momentTime > pruneDays ) then
							--  cull entry
	                        local pruneData = {};
	                        pruneData.realm = realmName;
	                        pruneData.faction = factionName;
	                        pruneData.entry = moment;
	                        table.insert(accumTimesData, pruneData);
						end
					end
				end
			end
		end
	end

	local num = table.getn(accumTimesData);
	while( num > 0 )do
		--
		-- Remove the top job from the queue and send it
		--
		local pruneData = accumTimesData[num];

        CensusPlus_Database["TimesPlus"][pruneData.realm][pruneData.faction][pruneData.entry] = {};
        CensusPlus_Database["TimesPlus"][pruneData.realm][pruneData.faction][pruneData.entry] = nil;

		table.remove(accumTimesData);
		num = table.getn(accumTimesData);
	end
end


function CensusPlus_CheckForBattleground()
		return;
end
--[[
	local battlefieldTime = GetBattlefieldInstanceRunTime();
	if( battlefieldTime > 0 ) then
		--
		--  We are in a battleground so cancel the current take
		--
		g_CurrentlyInBG = true;
	else
		if( GetBattlefieldStatInfo(1) ~= nil ) then
			g_CurrentlyInBG = true;
		else
			g_CurrentlyInBG = false;
		end
	end

end
]]--
function CensusPlus_IsInspectLoaded()
	if (IsAddOnLoaded("Blizzard_InspectUI")) then
		--ChatFrame1:AddMessage("Inspect Loaded");
		return true;
	end

	if (CensusPlus_Database["Info"]["LoadInspect"] ~= nil and CensusPlus_Database["Info"]["LoadInspect"] == true) then
		--ChatFrame1:AddMessage("Loading Inspect Frame");
		LoadAddOn("Blizzard_InspectUI");
	end

	--ChatFrame1:AddMessage("Inspect Not Loaded");
	return false;
end

function CensusPlus_IsTalentLoaded()
	if (IsAddOnLoaded("Blizzard_TalentUI")) then
		--ChatFrame1:AddMessage("Talent Loaded");
		return true;
	end

	if (CensusPlus_Database["Info"]["LoadTalent"] ~= nil and CensusPlus_Database["Info"]["LoadTalent"] == true) then
		--ChatFrame1:AddMessage("Loading Talent Frame");
		LoadAddOn("Blizzard_TalentUI");
	end

	--ChatFrame1:AddMessage("Talent Not Loaded");
	return false;
end



function showAllUnitBuffs(sUnitname)
  local iIterator = 1
  DEFAULT_CHAT_FRAME:AddMessage(format("[%s] Buffs", sUnitname))
  while (UnitBuff(sUnitname, iIterator)) do
    DEFAULT_CHAT_FRAME:AddMessage(UnitBuff(sUnitname, iIterator), 1, 1, 0)
    iIterator = iIterator + 1
  end
  DEFAULT_CHAT_FRAME:AddMessage("---", 1, 1, 0)
end

function CensusPlus_GetUTCDateTimeStr()
	return date( "!%Y-%m-%d %H:%M", time() );
end

-----------------------------------------------------------------------------------
--
-- CensusPlus_DetermineServerDate
--
-----------------------------------------------------------------------------------
function CensusPlus_DetermineServerDate()

	CensusPlus_CheckTZ();

	local strDate;
	local TZOffset = g_CensusPlusTZOffset;

	--
	--  Timezone offsets should fall into distinct numbers for now
	--		And now that we know if they are playing on US or EU servers
	--		we can be even better estimates
	--

	--[[
		For US servers, the offset should be either -9 to -5 or 16/19 depending on DST for NA times
			and for oceana it is +11/-13
		EU servers are either +1 or 0 or -23 depending on DST
	]]--

	if( CensusPlus_Database["Info"]["Locale"] == "US" ) then
		if( TZOffset > 12 ) then
			-- NA server times but wrong day
			TZOffset = TZOffset - 24;
		elseif( TZOffset < -11 ) then
			--  Oceana times but wrong day
			TZOffset = 24 - TZOffset;
		end
	else
		if( TZOffset == -23 ) then
			TZOffset = 1;
		end
	end

	--  Now, take the TZOffset and modify our time to give us server date
	strDate = date( "!%Y-%m-%d", time() + (TZOffset * 3600 ) );

--	local strDate2 = date( "%Y-%m-%d : %H:%M", time() );
--	CensusPlus_Msg("Server date = " .. strDate .. " for TZOffset : " .. TZOffset .. " curr local: " .. strDate2 );

	return strDate;
end

-----------------------------------------------------------------------------------
--
-- Check time zone
--
-----------------------------------------------------------------------------------
function CensusPlus_CheckTZ()

    local UTCTimeHour = date( "!%H", time() );
    local LocTimeHour = date( "%H", time() );
	local hour, minute = GetGameTime();

	local locDiff  = LocTimeHour - UTCTimeHour;
	local servDiff = hour - UTCTimeHour;
--[[
	if(( servDiff == 1) or ( servDiff ==-23) or ( servDiff ==0) or ( servDiff ==-24)) then
--		CensusPlus_Msg("Guessing European (EU) Servers");
		if( g_CensusPlusLocale ~= "EU" and g_TZWarningSent == false) then
			CensusPlus_Msg("I guessed you are playing on EURO servers but your locale is not set to EU, are you sure this is correct?  Type /census locale to change locale setting.");
			g_TZWarningSent = true;
		end
	elseif(( servDiff >= 16 and servDiff <= 20 ) or ( servDiff >= -8 and servDiff <= -4 )) then
--		CensusPlus_Msg("Guessing North American (US) Servers" );
		if( g_CensusPlusLocale == "EU" and g_TZWarningSent == false ) then
			CensusPlus_Msg("I guessed you are playing on US servers but your locale not set to US, are you sure this is correct?  Type /census locale to change locale setting.");
			g_TZWarningSent = true;
		end
	elseif( g_TZWarningSent == false ) then
		CensusPlus_Msg("Unable to determine locale");
		g_TZWarningSent = true;
	end
]]--
	g_CensusPlusTZOffset = servDiff;
end


function CensusPlus_UpdateBattleGroundInfo()
	local status, mapName, instanceID;
	local numberQueues = 0;
	local waitTime, timeInQueue;
	local map = {};
	
	if( g_CensusPlusLocale == "N/A" ) then
		return;
	end
	

	for i=1, MAX_BATTLEFIELD_QUEUES do
		map = {};
		status, mapName, instanceID = GetBattlefieldStatus(i);

		if ( status ~= "none" ) then
			numberQueues = numberQueues+1;
			
			if ( status == "queued" ) then
				-- Update queue info 
				waitTime = GetBattlefieldEstimatedWaitTime(i)/1000;
				timeInQueue = GetBattlefieldTimeWaited(i)/1000;
				
				map[0] = waitTime;
				map[1] = timeInQueue;
				map[2] = mapName;
				map[3] = "Inactive";
				
--				CensusPlus_Msg( "INSERT " .. mapName .. " : " .. map[2] .. " to " .. i );
				CENSUSPLUS_CURRENT_BATTLEFIELD_QUEUES[i] = map;

			elseif ( status == "confirm" ) then
				-- In the battleground
				--  Check to see if we know we've already entered, and if so, add info to 
				--		our database
				map = CENSUSPLUS_CURRENT_BATTLEFIELD_QUEUES[i];
				
--				CensusPlus_Msg( "ACTIVE " .. mapName );
--				CensusPlus_Msg( map[2] );
				if( map ~= nil and map[3] == "Inactive" ) then
					map[3] = "Active";

					CENSUSPLUS_CURRENT_BATTLEFIELD_QUEUES[i] = map;
					
					--  Make an entry in our database	
					
					--
					-- Get the portion of the database for this server
					--
					local realmName = g_CensusPlusLocale .. GetCVar("realmName");
					if (CensusPlus_BGInfo[realmName] == nil) then
						CensusPlus_BGInfo[realmName] = {};
					end
					
										--
					-- Get the portion of the database for this faction
					--
					local factionGroup = UnitFactionGroup("player");
					if( factionGroup ~= nil ) then
						if (CensusPlus_BGInfo[realmName][factionGroup] == nil) then
							CensusPlus_BGInfo[realmName][factionGroup] = {};
						end
						
						local hour, minute = GetGameTime();
						CensusPlus_BGInfo[realmName][factionGroup][CensusPlus_DetermineServerDate() .. "&" .. hour .. ":" .. minute .. ":00"] =
										map[2] .. "&" .. map[0] .. "&" .. map[1];
					end
				end				
			end
		end
	end
end



-----------------------------------------------------------------------------------
--
-- My Test function
--
-----------------------------------------------------------------------------------
function CensusPlus_Test( val )
	local file = "Interface\\AddOns\\CensusPlus\\Sounds\\CensusComplete.ogg";
	CensusPlus_Msg( "Play sound " .. file );
	PlaySoundFile( file );
end
