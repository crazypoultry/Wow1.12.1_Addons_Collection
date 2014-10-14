------------------------------------------------------------------------------
-- Fastcast
-- 
-- Provides functionality for speeding up casting of normal cast-time and
-- channeled spells for players who play on high latency connections.
-- Main features are:
--   * Provide fast casting support via a timing based interrupt of the
--     current spell cast when a new spell can be cast, where the timing of
--     this is based on the nominal casting time of the spell and a changeable
--     time "padding" parameter to accommodate variability in the connection
--     to the server.
--   * Protect channeled spells from being interrupted by repeated key presses
--     for the same spell.  A maxiumum time (from the start of spellcasting)
--     can also be used to allow for protection only at the start of
--     channeling while still allowing interruption/recast if required.
-- 
-- This addon was originally called Channelcast, where its sole function was
-- to protect channeled spells from being interrupted.  When the fast casting
-- support feature was added, it was decided that a new name would better
-- describe what was becoming the primary use of the addon.  An options UI was
-- also added to allow for more intuitive changing of the settings.
--
-- Channelcast and Fastcast should not both be present, since they will both
-- try and do similar things, and may interfere with each other's operation.
-- 
-- The AddOn implements its functionality by wrapping the UseAction function
-- of the WoW core API in such a way as to not call UseAction if the requested
-- action is within the "holding" period for the current spell action (if
-- there is one) and by monitoring the various SPELLCAST related events.
-- 
-- For additional control, the AddOn registers a /fastcast slash command
-- with the following options:
--     /fastcast help (shows the available slash commands and status)
--     /fastcast (toggles the UI settings window for Fastcast)
--     /fastcast status (shows the status of the primary settings)
--     /fastcast fast on (enables fast casting mode)
--     /fastcast fast off (disables fast casting mode)
--     /fastcast fast # (sets the fast casting pad time, default 0.2)
--     /fastcast protect on (enables protection of channeled spells)
--     /fastcast protect off (disables protection of channeled spells)
--     /fastcast protect # (sets the maximum channeled spell protection time)
--     /fastcast debugon (hidden command, turns on debug)
--     /fastcast debugoff (hidden command, turns off debug)
-- 
-- Written by Cirk of Doomhammer, April 2005 and March 2006
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- AddOn version
------------------------------------------------------------------------------
FASTCAST_NAME = "Cirk's Fastcast"
FASTCAST_VERSION = "1.11.2"


------------------------------------------------------------------------------
-- Globals
------------------------------------------------------------------------------
FastcastState = {};						-- Will be overridden when loaded


------------------------------------------------------------------------------
-- Local data
------------------------------------------------------------------------------
local FASTCAST_DEFAULTS = {
	["FastEnabled"] = 1,				-- Fast cast defaults to on
	["FastPadding"] = 0.2,				-- Default padding is 0.2
	["FastCastingBar"] = 1,				-- Adjust CastingBar by default
	["FastAudio"] = 1,					-- Give audio effect feedback by default
	["ChannelingProtected"] = 1,		-- Protect channeled spells by default
	["ChannelingMaximum"] = 10,			-- Default maximum is 10 seconds
};
local FASTCAST_CLASS_DATA = {
	["DRUID"] = 1,						-- 1 means both enable both fast cast and channeling protection
	["HUNTER"] = 1,						-- 1 here to allow for fast casting of channeled spells
	["MAGE"] = 1,
	["PALADIN"] = 0,					-- 0 means only enable fastcast (no channeled spells)
	["PRIEST"] = 1,
	["ROGUE"] = nil,					-- nil means that neither fastcast or channeling protection are available
	["SHAMAN"] = 0,
	["WARLOCK"] = 1,
	["WARRIOR"] = 0,					-- warriors get this for their cast-time shield slam spell
};
local FASTCAST_PADDING_DATA = {
	["min"] = 0.01;						-- Minimum padding value
	["max"] = 0.5;						-- Maximum padding value
	["step"] = 0.01;					-- Step size
	["format"] = "%.2f sec",			-- Format string for tooltip
};
local FASTCAST_PROTECT_DATA = {
	["min"] = 0.5;						-- Minimum channeling protection time
	["max"] = 15;						-- Maximum channeling protection time
	["step"] = 0.5;						-- Step size
	["format"] = "%g sec",				-- Format string for tooltip
};
local FASTCAST_ACTION_SLOT_FIRST = 1;
local FASTCAST_ACTION_SLOT_LAST = 120;
local FASTCAST_SPELL_MAX_RANK = "maxRank";

local _eventData = {
	"SPELLCAST_CHANNEL_START",
	"SPELLCAST_CHANNEL_UPDATE",
	"SPELLCAST_CHANNEL_STOP",
	"SPELLCAST_START",
	"SPELLCAST_STOP",
	"SPELLCAST_FAILED",
	"SPELLCAST_INTERRUPTED",
	"SPELLCAST_DELAYED",
	"UI_ERROR_MESSAGE",
	"CRAFT_SHOW",
	"TRADE_SKILL_SHOW",
};
local _slotNameData = {
	["HEADSLOT"] = 1,
	["NECKSLOT"] = 1,
	["SHOULDERSLOT"] = 1,
	["BACKSLOT"] = 1,
	["CHESTSLOT"] = 1,
	["WRISTSLOT"] = 1,
	["HANDSSLOT"] = 1,
	["WAISTSLOT"] = 1,
	["LEGSSLOT"] = 1,
	["FEETSLOT"] = 1,
	["FINGER0SLOT"] = 1,
	["FINGER1SLOT"] = 1,
	["TRINKET0SLOT"] = 1,
	["TRINKET1SLOT"] = 1,
	["MAINHANDSLOT"] = 1,
	["SECONDARYHANDSLOT"] = 1,
	["RANGEDSLOT"] = 1,
};
local _colorTextEnabled = {["r"] = 1.0, ["g"] = 0.82, ["b"] = 0};		-- GameFontNormal yellow
local _colorTextDisabled = {["r"] = 0.5, ["g"] = 0.5, ["b"] = 0.5};		-- Light grey
local _colorNumberEnabled = {["r"] = 1, ["g"] = 1, ["b"] = 1};			-- White
local _colorNumberDisabled = {["r"] = 0.4, ["g"] = 0.4, ["b"] = 0.4};	-- Grey


------------------------------------------------------------------------------
-- Local variables
------------------------------------------------------------------------------
local _thisFrame;						-- The frame pointer
local _serverName;						-- set to current realm when loaded
local _playerName;						-- set to current playername when known
local _classEnabled;					-- whether the AddOn can be enabled for your class
local _fastEnabled;						-- whether fast casting mode is enabled or not
local _fastPadding;						-- padding value for fast casting
local _fastCastingBar;
local _fastAudio;
local _channelingProtected;				-- if channeled spell casting protection is enabled or not
local _channelingMaximum;				-- maximum protected time for channeled spell
local _channelingInProgress;			-- spellID of the channeling spell if one is in progress
local _channelingStartTime;				-- start time of the channeled spell (used for UPDATE events)
local _channelingEndTime;				-- end time of the channeled spell (used for UPDATE events)
local _castingInProgress;				-- spellID of the casting spell if one is in progress
local _debugFrame;						-- turn on debug about casting
local _thisActionID;					-- last action successfully started by the hooked UseAction
local _nextActionID;					-- next action when casting was already in progress
local _thisSpellID;						-- last spellcast ID (from a macro) started from the hooked UseAction
local _nextSpellID;						-- next spellcast ID (from a macro) when casting was already in progress
local _testActionFlag;					-- used to check for actions that occur synchronously inside UseAction
local _testActionID;					-- holds the ID for the current action we are attempting to perform
local _castPendingID;					-- used in CastSpell and CastSpellByName to tell UseAction that a spell was started
local _actionStartTime;					-- time at which the current action was started
local _actionEndTime;					-- time that spell should finish channeling
local _currentActionID;					-- value of _thisActionID when channeling or casting started
local _uiValuesChanged;					-- indicates when the user has changed a value via the UI
local _spellData = {};					-- table of spell data, sorted by lower case spellname, each entry containing a rank indexed table of:
										--   .spellID - spell ID in spellbook
										--   .actionID - action ID on action bar if this rank is found on the bar
local _spellDataByID = {};				-- table of spell rank data by action ID (used to maintain actionID data in _spellData table)
local _fastMacroIDs = {};				-- table of action IDs corresponding to Fastcast aware macros

local _original_UseAction;				-- original UseAction function
local _original_CastSpell;				-- original CastSpell function
local _original_CastSpellByName;		-- original CastSpellByName function
local _original_SpellStopCasting;		-- original SpellStopCasting function
local _original_SpellTargetUnit;		-- original SpellTargetUnit function
local _original_TargetUnit;				-- original TargetUnit function


------------------------------------------------------------------------------
-- Local functions
------------------------------------------------------------------------------
local function Fastcast_CheckForChannelcast()
	if (Channelcast and CHANNELCAST_NAME and CHANNELCAST_VERSION and Channelcast_SlashCommand) then
		-- Channelcast is present, so deactivate it and tell the user.  Note
		-- that calling Channelcast_SlashCommand will only work because
		-- Channelcast should get events before Fastcast (being first
		-- alphabetically).
		if (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_COMMANDS.COMMAND_CHANNELCAST_PRESENT_NOTICE);
		end
		Channelcast_SlashCommand("off");
	end
end


------------------------------------------------------------------------------
-- Initialization and registration functions
------------------------------------------------------------------------------
local function Fastcast_HookFunctions()
	-- Hook the functions we are interested in.
	if (_debugFrame) then
		_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."Fastcast_HookFunctions()");
	end
	if (not _original_UseAction) then
		_original_UseAction = UseAction;
		UseAction = Fastcast_UseAction;
	end
	if (not _original_CastSpell) then
		_original_CastSpell = CastSpell;
		CastSpell = Fastcast_CastSpell;
	end
	if (not _original_CastSpellByName) then
		_original_CastSpellByName = CastSpellByName;
		CastSpellByName = Fastcast_CastSpellByName;
	end
	if (not _original_SpellStopCasting) then
		_original_SpellStopCasting = SpellStopCasting;
		SpellStopCasting = Fastcast_SpellStopCasting;
	end
	if (not _original_SpellTargetUnit) then
		_original_SpellTargetUnit = SpellTargetUnit;
		SpellTargetUnit = Fastcast_SpellTargetUnit;
	end
	if (not _original_TargetUnit) then
		_original_TargetUnit = TargetUnit;
		TargetUnit = Fastcast_TargetUnit;
	end
end


local function Fastcast_Register()
	-- Register for events needed for addon features
	if (_debugFrame) then
		_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."Fastcast_Register()");
	end
	for _, event in _eventData do
		_thisFrame:RegisterEvent(event);
	end
end


local function Fastcast_Unregister()
	-- Unregister events for addon features
	if (_debugFrame) then
		_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."Fastcast_Unregister()");
	end
	for _, event in _eventData do
		_thisFrame:UnregisterEvent(event);
	end
end


local function Fastcast_VariablesLoaded()
	-- Called for the VARIABLES_LOADED event, this function retrieves the
	-- current per-realm settings and sets the realm name
	_serverName = GetRealmName();
	if (not FastcastState) then
		FastcastState = {};
	end
	if (not FastcastState.Servers) then
		FastcastState.Servers = {};
	end
	if (not FastcastState.Servers[_serverName]) then
		FastcastState.Servers[_serverName] = {};
	end
	if (not FastcastState.Servers[_serverName].Characters) then
		FastcastState.Servers[_serverName].Characters = {};
	end
end


local function Fastcast_PlayerLogin()
	-- This function is called for the PLAYER_LOGIN event and checks to see if
	-- the playername is known so the player's per character settings can be
	-- retrieved, otherwise default values are used.  Based on the player's
	-- class we determine whether or not to hook the UseAction function (since
	-- rogues don't have any cast-time spells).
	_playerName = UnitName("player");
	local _, class = UnitClass("player");
	_classEnabled = FASTCAST_CLASS_DATA[class];
	if (_classEnabled) then
		local firstTime;
		if (not FastcastState.Servers[_serverName].Characters[_playerName]) then
			FastcastState.Servers[_serverName].Characters[_playerName] = {};
			firstTime = true;
		end
		_fastEnabled = FastcastState.Servers[_serverName].Characters[_playerName].FastEnabled;
		_fastPadding = FastcastState.Servers[_serverName].Characters[_playerName].FastPadding;
		_fastCastingBar = FastcastState.Servers[_serverName].Characters[_playerName].FastCastingBar;
		_fastAudio = FastcastState.Servers[_serverName].Characters[_playerName].FastAudio;
		_channelingProtected = FastcastState.Servers[_serverName].Characters[_playerName].ChannelingProtected;
		_channelingMaximum = FastcastState.Servers[_serverName].Characters[_playerName].ChannelingMaximum;
		if (not _fastEnabled) then
			_fastEnabled = FASTCAST_DEFAULTS.FastEnabled;
		end
		if (not _fastPadding) then
			_fastPadding = FASTCAST_DEFAULTS.FastPadding;
		end
		if (not _fastCastingBar) then
			_fastCastingBar = FASTCAST_DEFAULTS.FastCastingBar;
		end
		if (not _fastAudio) then
			_fastAudio = FASTCAST_DEFAULTS.FastAudio;
		end
		if (not _channelingProtected) then
			_channelingProtected = FASTCAST_DEFAULTS.ChannelingProtected;
		end
		if (not _channelingMaximum) then
			_channelingMaximum = FASTCAST_DEFAULTS.ChannelingMaximum;
		end
		if ((_channelingProtected == 1) and (_classEnabled ~= 1)) then
			_channelingProtected = 0;
		end
		if ((_fastEnabled == 1) or (_channelingProtected == 1)) then
			-- Hook functions only for now, event registration will be done
			-- on entering the world.
			Fastcast_HookFunctions()
			if (_debugFrame) then
				if (_fastEnabled == 1) then
					_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG..FASTCAST_COMMANDS.COMMAND_FAST_ENABLE_CONFIRM);
				end
				if (_channelingProtected == 1) then
					_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG..FASTCAST_COMMANDS.COMMAND_PROTECT_ENABLE_CONFIRM);
				end
			end
		end
		Fastcast_CheckForChannelcast();
		FastcastFrame_Initialize();
		if (firstTime) then
			FastcastFrame:Show();
		end
	else
		_fastEnabled = 0;
		_channelingProtected = 0;
		if (FastcastState.Servers[_serverName].Characters) then
			if (FastcastState.Servers[_serverName].Characters[_playerName]) then
				FastcastState.Servers[_serverName].Characters[_playerName] = nil;
			end
		end
	end
end


local function Fastcast_PlayerLogout()
	if (_classEnabled) then
		FastcastState.Servers[_serverName].Characters[_playerName].FastEnabled = _fastEnabled;
		FastcastState.Servers[_serverName].Characters[_playerName].FastPadding = _fastPadding;
		FastcastState.Servers[_serverName].Characters[_playerName].FastCastingBar = _fastCastingBar;
		FastcastState.Servers[_serverName].Characters[_playerName].FastAudio = _fastAudio;
		FastcastState.Servers[_serverName].Characters[_playerName].ChannelingProtected = _channelingProtected;
		FastcastState.Servers[_serverName].Characters[_playerName].ChannelingMaximum = _channelingMaximum;
	else
		FastcastState.Servers[_serverName].Characters[_playerName] = nil;
	end
end


------------------------------------------------------------------------------
-- Spellbook and action bar parsing functions
------------------------------------------------------------------------------
local function Fastcast_CheckSpellbook()
	-- Parses the player's spellbook, looking for spells.
	if (_debugFrame) then
		_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."Fastcast_CheckSpellbook()");
	end
	_spellData = {};
	_spellDataByID = {};
	_fastMacroIDs = {};
	for tab = 1, GetNumSpellTabs(), 1 do
		local name, texture, offset, numSpells = GetSpellTabInfo(tab);
		for index = 1, numSpells do
			local spellID = offset + index;
			if (not IsSpellPassive(spellID, BOOKTYPE_SPELL)) then
				local spellName, spellRank = GetSpellName(spellID, BOOKTYPE_SPELL);
				spellName = string.lower(spellName);
				spellRank = string.lower(spellRank);
				local sdata = _spellData[spellName];
				if (not sdata) then
					sdata = {};
					_spellData[spellName] = sdata;
				end
				if (not spellRank or (spellRank == "")) then
					sdata[FASTCAST_SPELL_MAX_RANK] = {};
					sdata[FASTCAST_SPELL_MAX_RANK].spellID = spellID;
				else
					sdata[spellRank] = {};
					sdata[spellRank].spellID = spellID;
					sdata[FASTCAST_SPELL_MAX_RANK] = sdata[spellRank];
				end
			end
		end
	end
end


local function Fastcast_ProcessActionID(id)
	-- Uses the hidden tooltip to check for known spells at the indicated
	-- action bar id, and if found, updates the actionIDs table.
	local rdata = _spellDataByID[id];
	if (rdata) then
		rdata.actionID = nil;
		_spellDataByID[id] = nil;
	end
	if (HasAction(id) and not GetActionText(id)) then
		FastcastTooltip:SetOwner(_thisFrame, "ANCHOR_NONE");
		FastcastTooltipTextLeft1:SetText("");
		FastcastTooltipTextRight1:SetText("");
		FastcastTooltip:SetAction(id);
		local actionName = FastcastTooltipTextLeft1:GetText();
		local actionRank = FastcastTooltipTextRight1:GetText();
		FastcastTooltip:Hide();
		if (actionName) then
			local sdata = _spellData[string.lower(actionName)];
			if (sdata) then
				if (not actionRank or (actionRank == "")) then
					rdata = sdata[FASTCAST_SPELL_MAX_RANK];
				else
					rdata = sdata[string.lower(actionRank)];
				end
				if (rdata) then
					rdata.actionID = id;
					_spellDataByID[id] = rdata;
				end
			end
		end
	end
end


local function Fastcast_ScanActionBar(id)
	-- Scans the action id using Fastcast_ProcessActionID for the
	-- indicated id, or for all ids if no specific id is given.
	if (_debugFrame) then
		_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."Fastcast_ScanActionBar("..(id or "")..")");
	end
	if (id and (id > 0)) then
		Fastcast_ProcessActionID(id);
	else
		for id = FASTCAST_ACTION_SLOT_FIRST, FASTCAST_ACTION_SLOT_LAST do
			Fastcast_ProcessActionID(id);
		end
		if (_debugFrame) then
			for sname, sdata in _spellData do
				_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."Found spell "..FASTCAST_EM.ON..sname..FASTCAST_EM.OFF);
				for rank, rdata in sdata do
					_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."  --> "..rank..": spellID = "..(rdata.spellID or 0)..", actionID = "..(rdata.actionID or 0));
				end
			end
		end
	end
end


------------------------------------------------------------------------------
-- Status functions
------------------------------------------------------------------------------
local function Fastcast_IsCasting(spellNameAndRankOrSpellID, notFast)
	-- Returns true if there is a current casting or channeling action in
	-- progress that hasn't yet reached its end time, or nil otherwise.  If a
	-- spellNameAndRankOrSpellID parameter is passed, the function will test
	-- only whether that specific spell is casting or not (or in the case of
	-- attack actions, whether the action is active or not), otherwise it will
	-- check for any spell current action.  For normal actions, this requires
	-- that fast-casting or channeling protection is enabled as appropriate to
	-- ensure reliable results.  If the notFast parameter is set, then the
	-- function only checks whether the specified spell (or any spell if
	-- spellNameAndRankOrSpellID is not provided) is still casting or
	-- channeling, and not whether it has reached its expected end-time or not.
	local time = GetTime();
	if (spellNameAndRankOrSpellID) then
		local spellID = tonumber(spellNameAndRankOrSpellID);
		if (spellID) then
			if (_castingInProgress and (_castingInProgress == spellID)) then
				if ((time < _actionEndTime) or notFast) then
					return true;
				end
			elseif (_channelingInProgress and (_channelingInProgress == spellID)) then
				if ((time < _actionEndTime) or notFast) then
					return true;
				end
			elseif (_thisActionID and _thisSpellID and (_thisSpellID == spellID)) then
				return true;
			elseif (IsCurrentCast(spellID, BOOKTYPE_SPELL)) then
				return true;
			else
				local spellName, spellRank = GetSpellName(spellID, BOOKTYPE_SPELL);
				local sdata = _spellData[string.lower(spellName)];
				if (sdata) then
					local rdata;
					if (not spellRank or (spellRank == "")) then
						rdata = sdata[FASTCAST_SPELL_MAX_RANK];
					else
						rdata = sdata[string.lower(spellRank)];
					end
					if (rdata and rdata.actionID and (IsCurrentAction(rdata.actionID) or IsAutoRepeatAction(rdata.actionID))) then
						return true;
					end
				end
			end
		else
			local _, _, spellName, spellRank = string.find(spellNameAndRankOrSpellID, FASTCAST_SPELLDATA.NAME_AND_RANK_PATTERN);
			local sdata = _spellData[string.lower(spellName)];
			if (sdata) then
				local rdata;
				if (not spellRank or (spellRank == "")) then
					rdata = sdata[FASTCAST_SPELL_MAX_RANK];
				else
					rdata = sdata[string.lower(spellRank)];
				end
				if (rdata) then
					if (_castingInProgress and (_castingInProgress == rdata.spellID)) then
						if ((time < _actionEndTime) or notFast) then
							return true;
						end
					elseif (_channelingInProgress and (_channelingInProgress == rdata.spellID)) then
						if ((time < _actionEndTime) or notFast) then
							return true;
						end
					elseif (_thisActionID and _thisSpellID and (_thisSpellID == rdata.spellID)) then
						return true;
					elseif (rdata.spellID and IsCurrentCast(rdata.spellID, BOOKTYPE_SPELL)) then
						return true;
					elseif (rdata.actionID and (IsCurrentAction(rdata.actionID) or IsAutoRepeatAction(rdata.actionID))) then
						return true;
					end
				end
			end
		end
	else
		if (_castingInProgress) then
			if ((time < _actionEndTime) or notFast) then
				return true;
			end
		elseif (_channelingInProgress) then
			if ((time < _actionEndTime) or notFast) then
				return true;
			end
		elseif (_thisActionID) then
			return true;
		end
	end
end


------------------------------------------------------------------------------
-- OnLoad function
------------------------------------------------------------------------------
function Fastcast_OnLoad()
	-- Record our frame pointer for later
	_thisFrame = this;

	-- Register for player events
	_thisFrame:RegisterEvent("VARIABLES_LOADED");
	_thisFrame:RegisterEvent("PLAYER_LOGIN");
	_thisFrame:RegisterEvent("PLAYER_LOGOUT");
	_thisFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	_thisFrame:RegisterEvent("PLAYER_LEAVING_WORLD");

	-- Register slash command handler
	SLASH_FASTCAST1 = "/fastcast";
	SlashCmdList["FASTCAST"] = function(text)
		Fastcast_SlashCommand(text);
	end

	-- Announce ourselves
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_NAME.." v"..FASTCAST_VERSION.." loaded");
	end
end


------------------------------------------------------------------------------
-- OnEvent function
------------------------------------------------------------------------------
function Fastcast_OnEvent(event)
	-- For normal spells, we will see a SPELLCAST_START event followed by a
	-- SPELLCAST_STOP event, possibly followed by one of the error events if
	-- there was an error.  Insta-cast spells only generate a SPELLCAST_STOP
	-- event.  For channeled spells only the SPELLCAST_CHANNEL_START and
	-- SPELLCAST_CHANNEL_UPDATE, and SPELLCAST_CHANNEL_STOP events are
	-- relevent (although channeled spells also generate a SPELLCAST_STOP
	-- event just after the initial SPELLCAST_CHANNEL_START).  Note also that
	-- for channeled spells, the spell name (arg2 in SPELLCAST_CHANNEL_START)
	-- is always "Channeling", and we check for this to separate it from
	-- "Fishing" or other similar actions that are flagged as channeled
	-- actions.  Lastly we also check for the out of mana error condition, but
	-- which we don't expect to see with channeled spells (since the mana is
	-- taken at the start) but will probably see with normal cast-time spells.
	-- Note that once we get a spell event, with the exception of
	-- SPELLCAST_CHANNEL_UPDATE and SPELLCAST_CHANNEL_STOP, we also clear
	-- _thisActionID to indicate that the current action has been seen
	-- (as a spell anyway).
	if (_debugFrame) then
		local timestamp = string.format("[%06.3f] ", math.mod(GetTime(), 1000.0));
		_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG..timestamp.."Fastcast_OnEvent("..(event or "")..", "..string.sub(arg1 or "", 1, 16)..") with action "..(_thisActionID or "(none)"));
	end

	if (event == "SPELLCAST_CHANNEL_START") then
		if ((_channelingProtected == 1) and (arg2 == CHANNELING) and _thisActionID) then
			if (_spellDataByID[_thisActionID]) then
				_channelingInProgress = _spellDataByID[_thisActionID].spellID;
			elseif _thisSpellID then
				_channelingInProgress = _thisSpellID;
			else
				_channelingInProgress = true;
			end
			_currentActionID = _thisActionID;
			local time = GetTime();
			local duration = arg1/1000;
			if (duration > _channelingMaximum) then
				duration = _channelingMaximum;
			end
			if ((_fastEnabled == 1) and _actionStartTime) then
				_channelingStartTime = _actionStartTime + _fastPadding;
				_actionEndTime = _channelingStartTime + duration;
				if (_fastCastingBar == 1) then
					Fastcast_UpdateCastingBarFrame(_channelingStartTime, arg1/1000, time);
				end
			else
				_channelingStartTime = time;
				_actionEndTime = _channelingStartTime + duration;
			end
			_channelingEndTime = _channelingStartTime + arg1/1000;
			if (_debugFrame) then
				_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> channeling started");
			end
		else
			_channelingInProgress = nil;
		end
		_thisActionID = nil;
		_thisSpellID = nil;
		_nextActionID = nil;
		_nextSpellID = nil;

	elseif (event == "SPELLCAST_CHANNEL_UPDATE") then
		if (_channelingInProgress) then
			local origDuration = _channelingEndTime - _channelingStartTime;
			_channelingEndTime = GetTime() + arg1/1000;
			_channelingStartTime = _channelingEndTime - origDuration;
			if (origDuration > _channelingMaximum) then
				_actionEndTime = _channelingStartTime + _channelingMaximum;
			else
				_actionEndTime = _channelingStartTime + origDuration;
			end
		end

	elseif (event == "SPELLCAST_CHANNEL_STOP") then
		if (_channelingInProgress) then
			_channelingInProgress = nil;
			if (_debugFrame) then
				_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> channeling stopped");
			end
		end

	elseif (event == "SPELLCAST_START") then
		if ((_fastEnabled == 1) and _thisActionID) then
			if (_spellDataByID[_thisActionID]) then
				_castingInProgress = _spellDataByID[_thisActionID].spellID;
			elseif _thisSpellID then
				_castingInProgress = _thisSpellID;
			else
				_castingInProgress = true;
			end
			_currentActionID = _thisActionID;
			local time = GetTime();
			local duration = arg2/1000;
			if (_actionStartTime) then
				_actionEndTime = _actionStartTime + _fastPadding + duration;
				if (_fastCastingBar == 1) then
					Fastcast_UpdateCastingBarFrame(_actionEndTime - duration, duration, time);
				end
			else
				_actionStartTime = time;
				_actionEndTime = _actionStartTime + duration;
			end
			if (_debugFrame) then
				_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> casting started");
			end
		else
			_castingInProgress = nil;
		end
		_thisActionID = nil;
		_thisSpellID = nil;
		_nextActionID = nil;
		_nextSpellID = nil;

	elseif (event == "SPELLCAST_DELAYED") then
		if (_castingInProgress and _actionEndTime) then
			_actionEndTime = _actionEndTime + (arg1/1000);
		end

	elseif (event == "SPELLCAST_STOP") then
		-- This event is the only event seen for insta-cast spells (including
		-- shapeshifting, stealth, and aura changes), occurs once at the end
		-- of a normal cast-time spell, and occurs once at the start for
		-- channeled spells (after the SPELLCAST_CHANNEL_START).
		if (_castingInProgress) then
			_castingInProgress = nil;
		end
		_thisActionID = _nextActionID;
		_thisSpellID = _nextSpellID;
		_nextActionID = nil;
		_nextSpellID = nil;

	elseif (event == "SPELLCAST_FAILED") then
		-- Handle synchronous failure conditions first, then the normal
		-- asynchronous ones
		if (_castPendingID) then
			_castPendingID = nil;
		elseif (_testActionFlag) then
			_testActionFlag = nil;
		else
			_channelingInProgress = nil;
			_castingInProgress = nil;
			_castPendingID = nil;
			_thisActionID = _nextActionID;
			_thisSpellID = _nextSpellID;
			_nextActionID = nil;
			_nextSpellID = nil;
		end

	elseif (event == "SPELLCAST_INTERRUPTED") then
		_channelingInProgress = nil;
		_castingInProgress = nil;
		_thisActionID = _nextActionID;
		_thisSpellID = _nextSpellID;
		_nextActionID = nil;
		_nextSpellID = nil;

	elseif (event == "UI_ERROR_MESSAGE") then
		-- Some errors can occur without a SPELLCAST_FAILED message, such as
		-- the SPELL_FAILED_SPELL_IN_PROGRESS and ERR_NO_ATTACK_TARGET errors.
		if ((arg1 == SPELL_FAILED_SPELL_IN_PROGRESS) or
			(arg1 == ERR_NO_ATTACK_TARGET)) then
			_castPendingID = nil;
		end

	elseif ((event == "CRAFT_SHOW") or (event == "TRADE_SKILL_SHOW")) then
		_testActionFlag = nil;

	elseif (event == "VARIABLES_LOADED") then
		Fastcast_VariablesLoaded();

	elseif (event == "PLAYER_LOGIN") then
		Fastcast_PlayerLogin();
		Fastcast_CheckSpellbook();
		Fastcast_ScanActionBar();

	elseif (event == "PLAYER_LOGOUT") then
		Fastcast_PlayerLogout();

	elseif (event == "PLAYER_ENTERING_WORLD") then
		if ((_fastEnabled == 1) or (_channelingProtected == 1)) then
			Fastcast_Register();
		end
		_thisFrame:RegisterEvent("LEARNED_SPELL_IN_TAB");
		_thisFrame:RegisterEvent("ACTIONBAR_SLOT_CHANGED");

	elseif (event == "PLAYER_LEAVING_WORLD") then
		if ((_fastEnabled == 1) or (_channelingProtected == 1)) then
			Fastcast_Unregister();
		end
		_thisFrame:UnregisterEvent("LEARNED_SPELL_IN_TAB");
		_thisFrame:UnregisterEvent("ACTIONBAR_SLOT_CHANGED");

	elseif (event == "LEARNED_SPELL_IN_TAB") then
		Fastcast_CheckSpellbook();
		Fastcast_ScanActionBar();

	elseif (event == "ACTIONBAR_SLOT_CHANGED") then
		Fastcast_ScanActionBar(arg1);

	end
end


------------------------------------------------------------------------------
-- Function hooks
------------------------------------------------------------------------------
function Fastcast_CastSpell(spellID, bookType)
	if (_debugFrame) then
		_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."CastSpell("..(spellID or "")..", "..(bookType or "")..")");
	end
	if (_testActionFlag and not _castingInProgress and (bookType == BOOKTYPE_SPELL)) then
		_castPendingID = spellID;
	end
	_original_CastSpell(spellID, bookType);
end


function Fastcast_CastSpellByName(spellNameAndRank, onSelf)
	if (_debugFrame) then
		_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."CastSpellByName("..(spellNameAndRank or "")..", "..(onSelf or "nil")..")");
	end
	if (_testActionFlag and not _castingInProgress and spellNameAndRank) then
		local _, _, spellName, spellRank = string.find(spellNameAndRank, FASTCAST_SPELLDATA.NAME_AND_RANK_PATTERN);
		local sdata = _spellData[string.lower(spellName)];
		if (sdata) then
			local rdata;
			if (not spellRank or (spellRank == "")) then
				rdata = sdata[FASTCAST_SPELL_MAX_RANK];
			else
				rdata = sdata[string.lower(spellRank)];
			end
			if (rdata) then
				_castPendingID = rdata.spellID;
			end
		end
	end
	_original_CastSpellByName(spellNameAndRank, onSelf);
end


function Fastcast_SpellStopCasting()
	if (_debugFrame) then
		_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."SpellStopCasting()");
	end
	_channelingInProgress = nil;
	_castingInProgress = nil;
	_castPendingID = nil;
	return _original_SpellStopCasting();
end


function Fastcast_SpellTargetUnit(unit)
	-- Used to set the action start time for spells that are cast and then
	-- targeted on a unit via SpellTargetUnit.
	if (_debugFrame) then
		_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."SpellTargetUnit("..(unit or "")..")");
	end
	local wasTargeting = SpellIsTargeting();
	_original_SpellTargetUnit(unit);
	if (_thisActionID and not _actionStartTime and wasTargeting and not SpellIsTargeting()) then
		_actionStartTime = GetTime();
	end
end


function Fastcast_TargetUnit(unit)
	-- Used to set the action start time for spells that are cast and then
	-- targeted on a unit via TargetUnit.
	if (_debugFrame) then
		_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."TargetUnit("..(unit or "")..")");
	end
	local wasTargeting = SpellIsTargeting();
	_original_TargetUnit(unit);
	if (_thisActionID and not _actionStartTime and wasTargeting and not SpellIsTargeting()) then
		_actionStartTime = GetTime();
	end
end


function Fastcast_UseAction(id, cursor, onSelf)
	-- This function replaces the default UseAction function to allow us to
	-- check for the current action or a channelling action in progress and
	-- optionally not process the request.  In the code below we check to see
	-- whether the requested action is the same as the current action and if
	-- so we don't pass it to the original UseAction function.  However, since
	-- some actions stay current the whole time they are active (such as
	-- stealth and melee attacks) we also consider whether the action is the
	-- same as the previous or current action and use spell event messages to
	-- reset the current action value.  (Channeled spells stay current until
	-- the first SPELLCAST_STOP is seen for example, normal cast-time spells
	-- stay current usually while they are casting, and actions such as
	-- Stealth stay current as long as they are active, but we can clear the
	-- action on the SPELLCAST_STOP to allow the same UseAction call to exit
	-- those sorts of conditions).
	if (((_fastEnabled == 1) or (_channelingProtected == 1)) and HasAction(id)) then
		local time = GetTime();
		local isMacro = GetActionText(id);
		local fastMacro = isMacro and _fastMacroIDs[id];
		if (_debugFrame) then
			local text;
			local timestamp = string.format("[%07.3f] ", math.mod(time, 1000.0));
			if (onSelf) then
				text = timestamp.."UseAction("..id..", "..cursor..", "..onSelf..")";
			else
				text = timestamp.."UseAction("..id..", "..cursor..")";
			end
			if (not IsUsableAction(id)) then
				text = text..FASTCAST_EM.RED.." (non-usable)"..FASTCAST_EM.OFF;
			end
			if (IsCurrentAction(id)) then
				text = text..FASTCAST_EM.ON.." (current)"..FASTCAST_EM.OFF;
			end
			if (_actionStartTime and ((time - _actionStartTime) < 60)) then
				text = text..FASTCAST_EM.ON..string.format(" +%.3f", time - _actionStartTime)..FASTCAST_EM.OFF;
			end
			_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG..text);
		end
		-- Check the time against any current channeling or casting action and
		-- if it is too soon to perform another action (assuming the other
		-- action is not a macro) then trigger the sound effect (if enabled)
		-- and do nothing more.  For channeled actions we only test the time
		-- when the current action is the same as the action that triggered
		-- the channeling action (i.e., any other action will be allowed to
		-- potentially stop the spell).  For normal casting actions we test
		-- the time for all actions (i.e., not allow any other action to
		-- potentially interrupt the action), the exception being for macros,
		-- where in particular only the macro that triggered the action will
		-- cause a check of the casting time (unless the macro flags itself
		-- as fastcast aware).
		if (_channelingInProgress and (id == _currentActionID) and not fastMacro) then
			if (time < _actionEndTime) then
				if (_debugFrame) then
					_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> ignoring since still channeling");
				end
				if ((_fastEnabled == 1) and (_fastAudio == 1)) then
					PlaySoundFile("Sound\\interface\\uEscapeScreenOpen.wav");
				end
				return;
			end
		end
		if (_castingInProgress and (not isMacro or (id == _currentActionID)) and not fastMacro) then
			if (time < _actionEndTime) then
				if (_debugFrame) then
					_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> ignoring since still casting");
				end
				if (_fastAudio == 1) then
					PlaySoundFile("Sound\\interface\\uEscapeScreenOpen.wav");
				end
				return;
			end
		end
		-- We need to check for the same action being triggered from different
		-- IDs (or via macro and ID) to make sure we don't accidentally try
		-- and start the same action again, which can lead to spell failures.  Note that _thisActionID and _thisSpellID
		-- are only valid until we get a response from the server (start,
		-- stop, failure, etc.) so essentially what we are testing for here is
		-- to ensure we don't keep retriggering the same action while waiting
		-- for the server response.
		local sameAction = (id == _thisActionID) or (_thisActionID and _spellDataByID[_thisActionID] and _spellDataByID[id] and (_spellDataByID[id].spellID == _spellDataByID[_thisActionID].spellID)) or (_thisSpellID and _spellDataByID[id] and (_spellDataByID[id].spellID == _thisSpellID));
		if (not sameAction or IsAttackAction(id)) then
			-- To determine if we are cancelling and then restarting the same
			-- action (which needs special handling due to two SPELLCAST_STOP
			-- events rather than just one).  We need to do more than just
			-- simply check whether the IDs are the same, since the user may
			-- have the same spell action triggered from multiple action IDs
			-- (e.g., via macros as well as normal actions).  Also, since we
			-- can't rely on IsCurrentAction when we are fastcasting, we also
			-- check to see if the current action matches by comparing it to
			-- the spellID of the one we are currently casting.
			local wasCasting = _castingInProgress;
			local wasCurrent = (id == _currentActionID) or (IsCurrentAction(id) and not IsAttackAction(id)) or (_castingInProgress and _spellDataByID[id] and (_castingInProgress == _spellDataByID[id].spellID));
			if (_castingInProgress and not isMacro) then
				if (IsCurrentAction(_currentActionID)) then
					if (_debugFrame) then
						_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> cancelling spell cast");
					end
					_original_SpellStopCasting();
				end
				_castingInProgress = nil;
			end
			if (_debugFrame) then
				_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> requesting new action "..id);
			end
			-- For the _testActionFlag we want to ensure that non-usable
			-- actions are still called, but don't lock us into a "current
			-- action" state if those actions don't signal any spell event
			-- (e.g., exiting stealth or druid forms).  We also want to allow
			-- for the case where the action is not usable because of
			-- insufficient mana only, in which case we do set the flag in
			-- case the user has another addon that will select a lower rank
			-- of spell that the user does have mana for.
			local usableAction, outOfMana = IsUsableAction(id);
			_testActionFlag = usableAction or outOfMana;
			_castPendingID = nil;
			_fastMacroIDs[id] = nil;
			_testActionID = id;
			_original_UseAction(id, cursor, onSelf);
			if (_testActionFlag and ((IsCurrentAction(id) and not isMacro) or _castPendingID)) then
				if (_debugFrame) then
					_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> new action "..id.." is in progress (current is "..tostring(IsCurrentAction(id) or 0)..", pending is "..tostring(_castPendingID or 0)..")");
				end
				_thisActionID = id;
				_thisSpellID = _castPendingID;
				if (wasCasting and ((wasCurrent and not isMacro) or (wasCasting == _castPendingID)) and not _castingInProgress) then
					-- When interrupting and then restarting the same action
					-- or spell, we will still get a SPELLCAST_STOP event even
					-- though the spell has been stopped (because the client
					-- passes on the message from the server, thinking it
					-- applies to the current action).  To keep our status
					-- after this event we set _nextActionID and _nextSpellID
					-- to capture this.
					if (_debugFrame) then
						_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> setting next action for expected spell stop");
					end
					_nextActionID = id;
					_nextSpellID = _castPendingID;
				end
				if (not SpellIsTargeting()) then
					_actionStartTime = time;
				else
					_actionStartTime = nil;
				end
			elseif (_debugFrame) then
				_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> action "..id.." ignored");
			end
			_testActionFlag = nil;
			_testActionID = nil;
			_castPendingID = nil;
		else
			if (_debugFrame) then
				if (id == _thisActionID) then
					_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> ignoring current action");
				else
					_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> ignoring same action");
				end
			end
		end
	else
		_original_UseAction(id, cursor, onSelf);
	end
end


------------------------------------------------------------------------------
-- Macro callable functions
------------------------------------------------------------------------------
function FastcastEnabled()
	-- Returns two boolean values indicating whether fast-casting and
	-- channeling protection are enabled.
	return (_fastEnabled == 1), (_channelingProtected == 1);
end


function FastcastIsCasting(spellNameAndRankOrSpellID, notFast)
	-- Simply returns true if there is a current casting or channeling action
	-- in progress that hasn't yet reached its end time, or nil otherwise.  If
	-- a spellNameAndRankOrSpellID parameter is passed, the function will test
	-- only whether that specific spell is casting or not, otherwise it will
	-- check for any spell action.  If the notFast parameter is passed then
	-- the function will simply check the current casting or channeling action
	-- and ignore the expected end time. If neither fast-casting or channeling
	-- protection is enabled, this function will always return nil, and to
	-- avoid usage problems in macros, if at least fast-casting isn't enabled
	-- a warning message will be shown to the default chat.  Note that calling
	-- this function from a UseAction triggered macro will flag the macro as
	-- Fastcast aware.
	if (_debugFrame) then
		_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."FastcastIsCasting("..(spellNameAndRankOrSpellID or "")..", "..tostring(notFast or "nil")..")");
	end
	if ((_fastEnabled ~= 1) and _classEnabled and DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_TEXT.WARNING_DISABLED_ISCASTING);
	end
	if (_testActionID) then
		_fastMacroIDs[_testActionID] = 1;
	end
	return Fastcast_IsCasting(spellNameAndRankOrSpellID, notFast);
end


function FastcastStopCasting()
	-- This function first checks to see if there is a current casting or
	-- channeling action in progress that hasn't yet reached its end time, and
	-- if so does nothing (returns nil).  Otherwise, if there is no current
	-- spell action in progress, or there is an action in progress but it can
	-- be stopped, then the function calls SpellStopCasting() to reset the
	-- casting state, and returns true.  If neither fast-casting or channeling
	-- protection is enabled, this function will always return nil, and to
	-- avoid usage problems in macros, if at least fast-casting isn't enabled
	-- a warning message will be shown to the default chat.  Note that calling
	-- this function from a UseAction triggered macro will flag the macro as
	-- Fastcast aware.
	if (_debugFrame) then
		_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."FastcastStopCasting()");
	end
	if ((_fastEnabled ~= 1) and DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_TEXT.WARNING_DISABLED_STOPCASTING);
	end
	if (_testActionID) then
		_fastMacroIDs[_testActionID] = 1;
	end
	if (Fastcast_IsCasting()) then
		return;
	end
	SpellStopCasting();
	return true;
end


function FastcastCast(spellNameAndRank, onSelf)
	-- If the named spell is not in cooldown, and if either the spell is not
	-- on the action bar or is on the action bar and the action is usable,
	-- and if no current or pending spellcast is in progress, then cast the
	-- spell.  If the spell was successfully started then return true,
	-- otherwise return nil.  Note that if neither fast-casting or channeling
	-- protection is enabled then the function will not be able to determine
	-- if the spell was successfully started or not, and will just return true
	-- in this case.  Also note that calling this function from a macro will
	-- NOT flag the macro as being Fastcast aware.
	if (_debugFrame) then
		_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."FastcastCast("..(spellNameAndRank or "nil")..", "..(onSelf or "nil")..")");
	end
	if (_castingInProgress or (_castPendingID and not SpellIsTargeting())) then
		return nil;
	end
	if (spellNameAndRank) then
		local _, _, spellName, spellRank = string.find(spellNameAndRank, FASTCAST_SPELLDATA.NAME_AND_RANK_PATTERN);
		local sdata = _spellData[string.lower(spellName)];
		if (sdata) then
			local rdata;
			if (not spellRank or (spellRank == "")) then
				rdata = sdata[FASTCAST_SPELL_MAX_RANK];
			else
				rdata = sdata[string.lower(spellRank)];
			end
			if (rdata) then
				local start, duration = GetSpellCooldown(rdata.spellID, BOOKTYPE_SPELL);
				if ((start > 0) and (duration > 0)) then
					if (_debugFrame) then
						_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> spell is in cooldown, doing nothing!");
					end
					return;
				end
				if (rdata.actionID and not IsUsableAction(rdata.actionID)) then
					if (_debugFrame) then
						_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> spell action not usable, doing nothing!");
					end
					return;
				end
				if (_debugFrame) then
					_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> casting "..spellNameAndRank);
				end
				if ((_fastEnabled == 1) or (_channelingProtected == 1)) then
					_castPendingID = rdata.spellID;
					CastSpellByName(spellNameAndRank, onSelf);
					if (_castPendingID) then
						return true;
					end
				else
					CastSpellByName(spellNameAndRank, onSelf);
					return true;
				end
			elseif (_debugFrame) then
				_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> cannot find spell rank!");
			end
		elseif (_debugFrame) then
			_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> cannot find spell!");
		end
	end
end


function FastcastUseItem(itemDesc)
	-- Looks for an inventory item using itemDesc as either a slot number
	-- (e.g., 14 for the second trinket slot), a slot name (e.g., "Trinket1Slot")
	-- where the case is ignored, or an item name (e.g., "Talisman of
	-- Ephemeral Power") where the name must be an exact match to that of the
	-- item.  If an item name is given, and is not found in the player's
	-- inventory (i.e., not something they are wearing) then the player's bags
	-- are checked, noting that if the item is found in the player's bags, but
	-- is an equipable item (e.g., a trinket) it is NOT automatically equipped.
	-- If the item is found and is usable and is not in cooldown, then the
	-- item is used and the function returns true, otherwise it does nothing
	-- and returns nil.  Note that calling this function from a macro does not
	-- flag the macro as being Fastcast aware.
	if (_debugFrame) then
		_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."FastcastUseItem("..(itemDesc or "")..")");
	end
	if (tonumber(itemDesc)) then
		local slot = tonumber(itemDesc);
		local start, duration = GetInventoryItemCooldown("player", slot);
		if ((start > 0) and (duration > 0)) then
			if (_debugFrame) then
				_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> item is in cooldown, doing nothing!");
			end
			return;
		end
		if (_debugFrame) then
			_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> using item");
		end
		UseInventoryItem(slot);
		return true;
	elseif (_slotNameData[string.upper(itemDesc or "")]) then
		local slot = GetInventorySlotInfo(itemDesc);
		local start, duration = GetInventoryItemCooldown("player", slot);
		if ((start > 0) and (duration > 0)) then
			if (_debugFrame) then
				_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> item is in cooldown, doing nothing!");
			end
			return;
		end
		if (_debugFrame) then
			_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> using item");
		end
		UseInventoryItem(slot);
		return true;
	else
		for slotName in _slotNameData do
			local slot = GetInventorySlotInfo(slotName);
			local itemLink = GetInventoryItemLink("player", slot);
			if (itemLink) then
				local _, _, itemName = string.find(itemLink, "|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h");
				if (itemName and (itemName == itemDesc)) then
					local start, duration = GetInventoryItemCooldown("player", slot);
					if ((start == 0) or (duration == 0)) then
						if (_debugFrame) then
							_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> using item in "..slotName);
						end
						UseInventoryItem(slot);
						return true;
					elseif (_debugFrame) then
						_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> item in "..slotName.." is in cooldown");
					end
				end
			end
		end
		for bag = 0, 4 do
			local bagSize = GetContainerNumSlots(bag);
			for slot = 1, bagSize do
				local itemLink = GetContainerItemLink(bag, slot);
				if (itemLink) then
					local _, _, itemString, itemName = string.find(itemLink, "|H(item:%d+:%d+:%d+:%d+)|h%[(.-)%]|h");
					if (itemName and (itemName == itemDesc) and itemString) then
						local _, _, _, _, _, _, _, equipLoc = GetItemInfo(itemString);
						if (not equipLoc or (equipLoc == "")) then
							local start, duration = GetContainerItemCooldown(bag, slot);
							if ((start == 0) or (duration == 0)) then
								if (_debugFrame) then
									_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> using item in slot "..slot.." of bag "..bag);
								end
								UseContainerItem(bag, slot);
								return true;
							elseif (_debugFrame) then
								_debugFrame:AddMessage(FASTCAST_TEXT.DEBUG.."--> item in slot "..slot.." of bag "..bag.." is in cooldown");
							end
						end
					end
				end
			end
		end
	end
end


function FastcastAware()
	-- When called from a UseAction triggered macro, this function simply
	-- flags the macro as being Fastcast aware, which means that Fastcast will
	-- not automatically prevent the macro from being executed again if it
	-- starts a spell action.
	if (_testActionID) then
		_fastMacroIDs[_testActionID] = 1;
	end
end


function FastcastIgnore()
	-- Tell Fastcast to ignore any casting actions from the calling macro.
	_testActionFlag = nil;
	_castPendingID = nil;
end


------------------------------------------------------------------------------
-- Casting bar update function (global so it can be hooked)
------------------------------------------------------------------------------
function Fastcast_UpdateCastingBarFrame(startTime, duration, now)
	if (startTime > now) then
		startTime = now;
	end
	local endTime = startTime + duration;
	if (now > endTime) then
		now = endTime;
	end
	if (CastingBarFrame.casting) then
		CastingBarFrame.startTime = startTime;
		CastingBarFrame.maxValue = endTime;
		CastingBarFrameStatusBar:SetMinMaxValues(startTime, endTime);
		CastingBarFrameStatusBar:SetValue(now);
	elseif (CastingBarFrame.channeling) then
		CastingBarFrame.startTime = startTime;
		CastingBarFrame.endTime = endTime;
		CastingBarFrameStatusBar:SetMinMaxValues(startTime, endTime);
		CastingBarFrameStatusBar:SetValue(startTime + endTime - now);
	end
	if (eCastingBar) then
		-- Repent's eCastingBar addon (http://www.wowinterface.com/downloads/fileinfo.php?id=4268)
		if (eCastingBar.casting) then
			eCastingBar.startTime = startTime;
			eCastingBar.maxValue = endTime;
			eCastingBarStatusBar:SetMinMaxValues(startTime, endTime);
			eCastingBarStatusBar:SetValue(now);
		elseif (eCastingBar.channeling) then
			eCastingBar.startTime = startTime;
			eCastingBar.endTime = endTime;
			eCastingBarStatusBar:SetMinMaxValues(startTime, endTime);
			eCastingBarStatusBar:SetValue(startTime + endTime - now);
		end
	end
	if (CastProgress) then
		-- Satrina's CastProgress addon (http://www.wowinterface.com/downloads/fileinfo.php?id=4173)
		if (CastProgress.casting or CastProgress.channeling) then
			CastProgress.elapsedTime = (now - startTime)*1000
			CastProgress.castTime = duration*1000;
			CastProgressBar:SetValue(CastProgress.elapsedTime/CastProgress.castTime);
		end
	end
	if (otravi_CastingBar) then
		-- Haste/Otravi's CastingBar addon (see http://www.wowace.com/forums/index.php/topic,1403.0.html)
		if (otravi_CastingBar.casting) then
			otravi_CastingBar.startTime = startTime;
			otravi_CastingBar.maxValue = endTime;
			otravi_CastingBar.master.Bar:SetMinMaxValues(startTime, endTime);
			otravi_CastingBar.master.Bar:SetValue(now);
		elseif (otravi_CastingBar.channeling) then
			otravi_CastingBar.startTime = startTime;
			otravi_CastingBar.endTime = endTime;
			otravi_CastingBar.maxValue = endTime;
			otravi_CastingBar.master.Bar:SetMinMaxValues(startTime, endTime);
			otravi_CastingBar.master.Bar:SetValue(startTime + endTime - now);
		end
	end
end


------------------------------------------------------------------------------
-- UI functions
------------------------------------------------------------------------------
function FastcastFrame_OnLoad()
	-- Make this frame closable with the ESC key
	tinsert(UISpecialFrames, "FastcastFrame");
end


function FastcastFrame_Initialize()
	-- Should be called only after the player's settings have been loaded

	-- Set frame title and version
	FastcastFrameTitleText:SetText(FASTCAST_TEXT.FRAME_TITLE);
	FastcastFrameVersionText:SetText("v"..FASTCAST_VERSION.." by Cirk");
	FastcastFrameVersionText:SetAlpha(0.6);

	-- Set text for each option
	FastcastFrameFastEnableText:SetText(FASTCAST_TEXT.FAST_ENABLE_OPTION);
	FastcastFrameFastCastBarText:SetText(FASTCAST_TEXT.FAST_CASTBAR_OPTION);
	FastcastFrameFastSoundText:SetText(FASTCAST_TEXT.FAST_PLAY_SOUND_OPTION);
	FastcastFrameChannelProtectText:SetText(FASTCAST_TEXT.CHANNEL_PROTECT);

	-- Set slider text and values
	FastcastFrameFastPaddingSliderText:SetText(FASTCAST_TEXT.FAST_PADDING_TEXT);
	FastcastFrameFastPaddingSliderLow:SetText(tostring(FASTCAST_PADDING_DATA.min));
	FastcastFrameFastPaddingSliderHigh:SetText(tostring(FASTCAST_PADDING_DATA.max));
	FastcastFrameFastPaddingSlider:SetMinMaxValues(FASTCAST_PADDING_DATA.min, FASTCAST_PADDING_DATA.max);
	FastcastFrameFastPaddingSlider:SetValueStep(FASTCAST_PADDING_DATA.step);
	FastcastFrameFastPaddingSlider.formatString = FASTCAST_PADDING_DATA.format;

	FastcastFrameChannelProtectSliderText:SetText(FASTCAST_TEXT.CHANNEL_MAXIMUM_TEXT);
	FastcastFrameChannelProtectSliderLow:SetText(tostring(FASTCAST_PROTECT_DATA.min));
	FastcastFrameChannelProtectSliderHigh:SetText(tostring(FASTCAST_PROTECT_DATA.max));
	FastcastFrameChannelProtectSlider:SetMinMaxValues(FASTCAST_PROTECT_DATA.min, FASTCAST_PROTECT_DATA.max);
	FastcastFrameChannelProtectSlider:SetValueStep(FASTCAST_PROTECT_DATA.step);
	FastcastFrameChannelProtectSlider.formatString = FASTCAST_PROTECT_DATA.format;

	-- Set help button texts
	FastcastFrameFastcastHelpText:SetText(FASTCAST_TEXT.HELP_BUTTON_TEXT);
	FastcastFrameFastcastHelp.tooltipTitle = FASTCAST_TEXT.HELP_FAST_TITLE;
	FastcastFrameFastcastHelp.tooltipText = FASTCAST_TEXT.HELP_FAST_DESC;
	FastcastFrameChannelProtectHelpText:SetText(FASTCAST_TEXT.HELP_BUTTON_TEXT);
	FastcastFrameChannelProtectHelp.tooltipTitle = FASTCAST_TEXT.HELP_CHANNEL_TITLE;
	if (_classEnabled == 1) then
		FastcastFrameChannelProtectHelp.tooltipText = FASTCAST_TEXT.HELP_CHANNEL_DESC;
	else
		FastcastFrameChannelProtectHelp.tooltipText = FASTCAST_TEXT.HELP_NO_CHANNEL_DESC;
	end
end


function FastcastFrame_OnShow()
	if (not FastcastFrame:IsVisible()) then
		return;
	end
	if (_fastEnabled == 1) then
		FastcastFrameFastEnable:SetChecked(1);
		FastcastFrameFastCastBar:SetChecked(_fastCastingBar == 1);
		FastcastFrameFastCastBarText:SetTextColor(_colorTextEnabled.r, _colorTextEnabled.g, _colorTextEnabled.b);
		FastcastFrameFastCastBar:Enable();
		FastcastFrameFastSound:SetChecked(_fastAudio == 1);
		FastcastFrameFastSoundText:SetTextColor(_colorTextEnabled.r, _colorTextEnabled.g, _colorTextEnabled.b);
		FastcastFrameFastSound:Enable();
		FastcastFrameFastPaddingSlider:EnableMouse(1);
		FastcastFrameFastPaddingSliderText:SetTextColor(_colorTextEnabled.r, _colorTextEnabled.g, _colorTextEnabled.b);
		FastcastFrameFastPaddingSliderLow:SetTextColor(_colorNumberEnabled.r, _colorNumberEnabled.g, _colorNumberEnabled.b);
		FastcastFrameFastPaddingSliderHigh:SetTextColor(_colorNumberEnabled.r, _colorNumberEnabled.g, _colorNumberEnabled.b);
	else
		FastcastFrameFastEnable:SetChecked(nil);
		FastcastFrameFastCastBar:SetChecked(_fastCastingBar == 1);
		FastcastFrameFastCastBarText:SetTextColor(_colorTextDisabled.r, _colorTextDisabled.g, _colorTextDisabled.b);
		FastcastFrameFastCastBar:Disable();
		FastcastFrameFastSound:SetChecked(_fastAudio == 1);
		FastcastFrameFastSoundText:SetTextColor(_colorTextDisabled.r, _colorTextDisabled.g, _colorTextDisabled.b);
		FastcastFrameFastSound:Disable();
		FastcastFrameFastPaddingSlider:EnableMouse();
		FastcastFrameFastPaddingSliderText:SetTextColor(_colorTextDisabled.r, _colorTextDisabled.g, _colorTextDisabled.b);
		FastcastFrameFastPaddingSliderLow:SetTextColor(_colorNumberDisabled.r, _colorNumberDisabled.g, _colorNumberDisabled.b);
		FastcastFrameFastPaddingSliderHigh:SetTextColor(_colorNumberDisabled.r, _colorNumberDisabled.g, _colorNumberDisabled.b);
	end
	if (_channelingProtected == 1) then
		FastcastFrameChannelProtect:SetChecked(1);
		FastcastFrameChannelProtectSlider:EnableMouse(1);
		FastcastFrameChannelProtectSliderText:SetTextColor(_colorTextEnabled.r, _colorTextEnabled.g, _colorTextEnabled.b);
		FastcastFrameChannelProtectSliderLow:SetTextColor(_colorNumberEnabled.r, _colorNumberEnabled.g, _colorNumberEnabled.b);
		FastcastFrameChannelProtectSliderHigh:SetTextColor(_colorNumberEnabled.r, _colorNumberEnabled.g, _colorNumberEnabled.b);
	else
		if (_classEnabled == 1) then
			FastcastFrameChannelProtect:Enable();
			FastcastFrameChannelProtectText:SetTextColor(_colorTextEnabled.r, _colorTextEnabled.g, _colorTextEnabled.b);
		else
			FastcastFrameChannelProtect:Disable();
			FastcastFrameChannelProtectText:SetTextColor(_colorTextDisabled.r, _colorTextDisabled.g, _colorTextDisabled.b);
		end
		FastcastFrameChannelProtect:SetChecked(nil);
		FastcastFrameChannelProtectSliderText:SetTextColor(_colorTextDisabled.r, _colorTextDisabled.g, _colorTextDisabled.b);
		FastcastFrameChannelProtectSliderLow:SetTextColor(_colorNumberDisabled.r, _colorNumberDisabled.g, _colorNumberDisabled.b);
		FastcastFrameChannelProtectSliderHigh:SetTextColor(_colorNumberDisabled.r, _colorNumberDisabled.g, _colorNumberDisabled.b);
		FastcastFrameChannelProtectSlider:EnableMouse();
	end
	FastcastFrameFastPaddingSlider:SetValue(_fastPadding);
	FastcastFrameChannelProtectSlider:SetValue(_channelingMaximum);
	_uiValuesChanged = nil;
end


function FastcastFrame_OnHide()
	if (_uiValuesChanged) then
		Fastcast_SlashCommand(FASTCAST_COMMANDS.COMMAND_STATUS);
		_uiValuesChanged = nil;
	end
end


function FastcastFrame_FastEnableOnClick()
	if (this:GetChecked()) then
		_fastEnabled = 1;
		if (_channelingProtected ~= 1) then
			Fastcast_HookFunctions();
			Fastcast_Register();
		end
	else
		_fastEnabled = 0;
		_castingInProgress = nil;
		_thisActionID = nil;
		_nextActionID = nil;
		_thisSpellID = nil;
		_nextSpellID = nil;
		if (_channelingProtected ~= 1) then
			Fastcast_Unregister();
		end
	end
	FastcastFrame_OnShow();
	_uiValuesChanged = 1;
end


function FastcastFrame_FastCastBarOnClick()
	if (this:GetChecked()) then
		_fastCastingBar = 1;
	else
		_fastCastingBar = 0;
	end
	_uiValuesChanged = 1;
end


function FastcastFrame_FastSoundOnClick()
	if (this:GetChecked()) then
		_fastAudio = 1;
	else
		_fastAudio = 0;
	end
	_uiValuesChanged = 1;
end


function FastcastFrame_FastPaddingSliderUpdate()
	if (this:GetValue() ~= _fastPadding) then
		_fastPadding = this:GetValue();
		_uiValuesChanged = 1;
	end
end


function FastcastFrame_ChannelProtectOnClick()
	if (this:GetChecked()) then
		_channelingProtected = 1;
		if (_fastEnabled ~= 1) then
			Fastcast_HookFunctions();
			Fastcast_Register();
		end
	else
		_channelingProtected = 0;
		_channelingInProgress = nil;
		_thisActionID = nil;
		_nextActionID = nil;
		_thisSpellID = nil;
		_nextSpellID = nil;
		if (_fastEnabled ~= 1) then
			Fastcast_Unregister();
		end
	end
	FastcastFrame_OnShow();
	_uiValuesChanged = 1;
end


function FastcastFrame_ChannelMaximumSliderUpdate()
	if (this:GetValue() ~= _channelingMaximum) then
		_channelingMaximum = this:GetValue();
		_uiValuesChanged = 1;
	end
end


------------------------------------------------------------------------------
-- Slash command function
------------------------------------------------------------------------------
function Fastcast_SlashCommand(text)
	if (text) then
		local command = string.lower(gsub(text, "%s*([^%s]+).*", "%1"));
		local params = string.lower(gsub(text, "%s*([^%s]+)%s*(.*)", "%2"));
		if (command == FASTCAST_COMMANDS.COMMAND_FAST) then
			if (_classEnabled) then
				if ((params == FASTCAST_COMMANDS.COMMAND_ON) or (params == FASTCAST_COMMANDS.COMMAND_ENABLE)) then
					_fastEnabled = 1;
					if (DEFAULT_CHAT_FRAME) then
						DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_COMMANDS.COMMAND_FAST_ENABLE_CONFIRM);
					end
					if (_channelingProtected ~= 1) then
						Fastcast_HookFunctions()
						Fastcast_Register();
					end
					FastcastFrame_OnShow();
				elseif ((params == FASTCAST_COMMANDS.COMMAND_OFF) or (params == FASTCAST_COMMANDS.COMMAND_DISABLE)) then
					_fastEnabled = 0;
					_castingInProgress = nil;
					_thisActionID = nil;
					_nextActionID = nil;
					_thisSpellID = nil;
					_nextSpellID = nil;
					if (DEFAULT_CHAT_FRAME) then
						DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_COMMANDS.COMMAND_FAST_DISABLE_CONFIRM);
					end
					if (_channelingProtected ~= 1) then
						Fastcast_Unregister();
					end
					FastcastFrame_OnShow();
				else
					local padding = tonumber(params);
					if (padding) then
						if (_fastEnabled == 1) then
							padding = math.floor((padding/FASTCAST_PADDING_DATA.step) + 0.01)*FASTCAST_PADDING_DATA.step;
							if (padding < FASTCAST_PADDING_DATA.min) then
								_fastPadding = FASTCAST_PADDING_DATA.min;
							elseif (padding > FASTCAST_PADDING_DATA.max) then
								_fastPadding = FASTCAST_PADDING_DATA.max;
							else
								_fastPadding = padding;
							end
							if (DEFAULT_CHAT_FRAME) then
								DEFAULT_CHAT_FRAME:AddMessage(string.format(FASTCAST_COMMANDS.COMMAND_FAST_PADDING_FORMAT, _fastPadding));
							end
							FastcastFrame_OnShow();
						elseif (DEFAULT_CHAT_FRAME) then
							DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_COMMANDS.COMMAND_FAST_NOT_ENABLED);
						end
					elseif (DEFAULT_CHAT_FRAME) then
						if (_fastEnabled == 1) then
							DEFAULT_CHAT_FRAME:AddMessage(string.format(FASTCAST_COMMANDS.COMMAND_FAST_ENABLED_STATUS_FORMAT, _fastPadding));
						else
							DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_COMMANDS.COMMAND_FAST_DISABLED_STATUS);
						end
					end
				end
			elseif (DEFAULT_CHAT_FRAME) then
				DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_COMMANDS.COMMAND_USAGE_FAILED);
			end
		elseif (command == FASTCAST_COMMANDS.COMMAND_PROTECT) then
			if (_classEnabled == 1) then
				if ((params == FASTCAST_COMMANDS.COMMAND_ON) or (params == FASTCAST_COMMANDS.COMMAND_ENABLE)) then
					_channelingProtected = 1;
					if (DEFAULT_CHAT_FRAME) then
						DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_COMMANDS.COMMAND_PROTECT_ENABLE_CONFIRM);
					end
					if (_fastEnabled ~= 1) then
						Fastcast_HookFunctions()
						Fastcast_Register();
					end
					FastcastFrame_OnShow();
				elseif ((params == FASTCAST_COMMANDS.COMMAND_OFF) or (params == FASTCAST_COMMANDS.COMMAND_DISABLE)) then
					_channelingProtected = 0;
					_channelingInProgress = nil;
					_thisActionID = nil;
					_nextActionID = nil;
					_thisSpellID = nil;
					_nextSpellID = nil;
					if (DEFAULT_CHAT_FRAME) then
						DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_COMMANDS.COMMAND_PROTECT_DISABLE_CONFIRM);
					end
					if (_fastEnabled ~= 1) then
						Fastcast_Unregister();
					end
					FastcastFrame_OnShow();
				else
					local maximum = tonumber(params);
					if (maximum) then
						if (_channelingProtected == 1) then
							maximum = math.floor((maximum/FASTCAST_PROTECT_DATA.step) + 0.01)*FASTCAST_PROTECT_DATA.step;
							if (maximum < FASTCAST_PROTECT_DATA.min) then
								_channelingMaximum = FASTCAST_PROTECT_DATA.min;
							elseif (maximum > FASTCAST_PROTECT_DATA.max) then
								_channelingMaximum = FASTCAST_PROTECT_DATA.max;
							else
								_channelingMaximum = maximum;
							end
							if (DEFAULT_CHAT_FRAME) then
								DEFAULT_CHAT_FRAME:AddMessage(string.format(FASTCAST_COMMANDS.COMMAND_PROTECT_MAXIMUM_FORMAT, _channelingMaximum));
							end
							FastcastFrame_OnShow();
						elseif (DEFAULT_CHAT_FRAME) then
							DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_COMMANDS.COMMAND_PROTECT_NOT_ENABLED);
						end
					elseif (DEFAULT_CHAT_FRAME) then
						if (_channelingProtected == 1) then
							DEFAULT_CHAT_FRAME:AddMessage(string.format(FASTCAST_COMMANDS.COMMAND_PROTECT_ENABLED_STATUS_FORMAT, _channelingMaximum));
						else
							DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_COMMANDS.COMMAND_PROTECT_DISABLED_STATUS);
						end
					end
				end
			elseif (DEFAULT_CHAT_FRAME) then
				DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_COMMANDS.COMMAND_PROTECT_USAGE_FAILED);
			end
		elseif (command == FASTCAST_COMMANDS.COMMAND_STATUS) then
			if (DEFAULT_CHAT_FRAME) then
				if (_classEnabled) then
					if (_fastEnabled == 1) then
						DEFAULT_CHAT_FRAME:AddMessage(string.format(FASTCAST_COMMANDS.COMMAND_FAST_ENABLED_STATUS_FORMAT, _fastPadding));
					else
						DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_COMMANDS.COMMAND_FAST_DISABLED_STATUS);
					end
					if (_channelingProtected == 1) then
						DEFAULT_CHAT_FRAME:AddMessage(string.format(FASTCAST_COMMANDS.COMMAND_PROTECT_ENABLED_STATUS_FORMAT, _channelingMaximum));
					elseif (_classEnabled == 1) then
						DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_COMMANDS.COMMAND_PROTECT_DISABLED_STATUS);
					end
				else
					DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_COMMANDS.COMMAND_USAGE_FAILED);
				end
			end
		elseif (command == FASTCAST_COMMANDS.COMMAND_DEBUGON) then
			_debugFrame = nil;
			local frameNum = tonumber(params or "");
			if (frameNum and (frameNum >= 1) and (frameNum <= 7)) then
				_debugFrame = getglobal("ChatFrame"..frameNum);
			end
			if (not _debugFrame) then
				_debugFrame = DEFAULT_CHAT_FRAME;
			end
			if (DEFAULT_CHAT_FRAME) then
				DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_COMMANDS.COMMAND_DEBUGON_CONFIRM);
			end
		elseif (command == FASTCAST_COMMANDS.COMMAND_DEBUGOFF) then
			_debugFrame = nil;
			if (DEFAULT_CHAT_FRAME) then
				DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_COMMANDS.COMMAND_DEBUGOFF_CONFIRM);
			end
		elseif (command == "") then
			if (_classEnabled) then
				if (FastcastFrame:IsVisible()) then
					FastcastFrame:Hide();
				else
					FastcastFrame:Show();
				end
			elseif (DEFAULT_CHAT_FRAME) then
				DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_COMMANDS.COMMAND_USAGE_FAILED);
			end
		else
			if (DEFAULT_CHAT_FRAME) then
				DEFAULT_CHAT_FRAME:AddMessage(FASTCAST_EM.ON..FASTCAST_NAME.." v"..FASTCAST_VERSION..FASTCAST_EM.OFF);
				for _, string in FASTCAST_HELP do
					DEFAULT_CHAT_FRAME:AddMessage(string);
				end
				Fastcast_SlashCommand(FASTCAST_COMMANDS.COMMAND_STATUS);
			end
		end
	end
end

