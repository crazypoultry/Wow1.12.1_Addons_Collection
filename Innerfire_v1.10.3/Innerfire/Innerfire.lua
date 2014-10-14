------------------------------------------------------------------------------
-- Innerfire
-- 
-- This addon attempts to display how many charges remain on a priests Inner
-- Fire buff by watching the combat log for melee events on the priest.  The
-- count remaining is displayed on the buff by updating the Count text object
-- in the buff buttons of the BuffFrame.
--
-- Innerfire's display of the charges on the Inner Fire buff should also work
-- with CTMod's Buffbar, Satrina Buff Frame, and those versions of GypsyMod
-- that actually show the stackable counter.
--
-- In addition, the addon provides a macro-callable function HasInnerFire,
-- which can be used to provide a true/nil check for whether Inner Fire is
-- currently present, has a minimum number of charges, and a minimum time.
--
-- Written by Cirk of Doomhammer, March 2006
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- AddOn name and version
------------------------------------------------------------------------------
INNERFIRE_NAME = "Cirk's Innerfire"
INNERFIRE_VERSION = "1.10.3"


------------------------------------------------------------------------------
-- Globals
------------------------------------------------------------------------------
InnerfireState = {};					-- Will be overridden when loaded


------------------------------------------------------------------------------
-- Local constants
------------------------------------------------------------------------------
local INNERFIRE_ACTION_SLOT_FIRST = 1;
local INNERFIRE_ACTION_SLOT_LAST = 120;
local INNERFIRE_SPELL_CHARGES = 20;
local INNERFIRE_BUFF_MIN_ID = 0;
local INNERFIRE_BUFF_MAX_ID = 19;


------------------------------------------------------------------------------
-- Local variables
------------------------------------------------------------------------------
local _thisFrame = nil;					-- The frame pointer
local _serverName = nil;				-- set to current realm when loaded
local _playerName = nil;				-- set to current playername when known
local _classEnabled = nil;				-- set to 1 if the player is of a valid class
local _enabled = 0;						-- whether the AddOn is enabled or not
local _debugFrame = nil;				-- debug output chat frame
local _innerFireSpellCasting = nil;		-- true if casting Inner Fire
local _innerFireCastPending = nil;		-- true if trying to cast Inner Fire

local _buffButtonName = "BuffButton";	-- Name prefix for the buff frame buttons
local _buffButtonOffset = 0;			-- Offset to convert from IDs to button names
local _buffButtonFilter = "HELPFUL";	-- Filter to use when converting IDs to indices
local _innerFireData = {};				-- will contain information on the Inner Fire spell (nil if not present)
										--   .id = id of the buff button for Inner Fire
										--   .count = count of charges left
										--   .spellIDs = table of the form (id = 1) for spell in spellbook
										--   .actionIDs = table of the form (id = 1) for action IDs where Inner Fire is found
local _patternData = {};				-- pattern data table used for searching for combat events

local _original_UseAction = nil;					-- original UseAction function
local _original_CastSpellByName = nil;				-- original CastSpellByName function
local _original_CastSpell = nil;					-- original CastSpell function
local _original_GetPlayerBuffApplications = nil;	-- original GetPlayerBuffApplications function


------------------------------------------------------------------------------
-- Data tables
------------------------------------------------------------------------------
local _eventData = {
	"SPELLS_CHANGED",
	"ACTIONBAR_SLOT_CHANGED",
	"PLAYER_AURAS_CHANGED",
	"SPELLCAST_STOP",
	"SPELLCAST_FAILED",
	"UI_ERROR_MESSAGE",
	"CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS",
	"CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS",
	"CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE",
	"CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE",
};
local _textureData = {
	TEXTURE_INNERFIRE = "Interface\\Icons\\Spell_Holy_InnerFire",
};


------------------------------------------------------------------------------
-- Local functions
------------------------------------------------------------------------------
local function Innerfire_GetNextParam(text)
	-- Extracts the next parameter out of the passed text, and returns it and
	-- the rest of the string
	if (text) then
		for param, remain in string.gfind(text, "(%w+) +(.*)") do
			return param, remain;
		end
	end
	return text;
end


local function Innerfire_ResetButton(id)
	-- Restores the counter on the button with the provided id to display what
	-- it should have for a counter.
	if (id) then
		local buffCount = getglobal(_buffButtonName..(id + _buffButtonOffset).."Count");
		if (buffCount) then
			local index = GetPlayerBuff(id, _buffButtonFilter);
			local count = _original_GetPlayerBuffApplications(index);
			if (count and (count > 1)) then
				buffCount:SetText(count);
				buffCount:Show();
			else
				buffCount:SetText();
				buffCount:Hide();
			end
		end
	end
end


local function Innerfire_ResetIndex(buffIndex)
	-- Restores the counter on the button that is using the provided buffIndex
	-- (if any) to display what it should have for a counter.
	for id = INNERFIRE_BUFF_MIN_ID, INNERFIRE_BUFF_MAX_ID do
		local index = GetPlayerBuff(id, _buffButtonFilter);
		if (index == buffIndex) then
			local buffCount = getglobal(_buffButtonName..(id + _buffButtonOffset).."Count");
			if (buffCount) then
				local count = _original_GetPlayerBuffApplications(index);
				if (count and (count > 1)) then
					buffCount:SetText(count);
					buffCount:Show();
				else
					buffCount:SetText();
					buffCount:Hide();
				end
			end
			break;
		end
	end
end


local function Innerfire_FindInnerFireBuff()
	-- Checks the player's list of buffs and find the id of the Inner Fire
	-- buff if it is present, calling Innerfire_ResetButton or
	-- Innerfire_ResetIndex if either of these parameters have changed.
	if (_debugFrame) then
		_debugFrame:AddMessage(INNERFIRE_TEXT.DEBUG.."Innerfire_FindInnerFireBuff()");
	end
	local oldId = _innerFireData.id;
	local oldIndex = _innerFireData.index;
	_innerFireData.id = nil;
	_innerFireData.index = nil;
	if (_enabled == 1) then
		for id = INNERFIRE_BUFF_MIN_ID, INNERFIRE_BUFF_MAX_ID do
			local index = GetPlayerBuff(id, _buffButtonFilter);
			if ((index >= 0) and (GetPlayerBuffTexture(index) == _textureData.TEXTURE_INNERFIRE)) then
				_innerFireData.id = id;
				_innerFireData.index = index;
				break;
			end
		end
	end
	if (oldId and (_innerFireData.id ~= oldId)) then
		Innerfire_ResetButton(oldId);
	end
	if (oldIndex and (_innerFireData.index ~= oldIndex)) then
		Innerfire_ResetIndex(oldIndex);
	end
	if (_debugFrame and _innerFireData.id and _innerFireData.index) then
		_debugFrame:AddMessage(INNERFIRE_TEXT.DEBUG.."--> found "..INNERFIRE_TEXT.SPELLNAME_INNER_FIRE.." at id ".._innerFireData.id.." and index ".._innerFireData.index);
	end
end


local function Innerfire_UpdateButton()
	-- Updates the BuffFrame button showing the Inner Fire buff to show the
	-- count of charges remaining, or to hide the count if it is less than 1.
	if (_debugFrame) then
		_debugFrame:AddMessage(INNERFIRE_TEXT.DEBUG.."Innerfire_UpdateButton()");
	end
	if (_innerFireData.id) then
		local buffCount = getglobal(_buffButtonName..(_innerFireData.id + _buffButtonOffset).."Count");
		if (buffCount) then
			if (_innerFireData.count and (_innerFireData.count > 0)) then
				buffCount:SetText(_innerFireData.count);
				buffCount:Show();
			else
				buffCount:SetText();
				buffCount:Hide();
			end
		elseif (_debugFrame) then
			_debugFrame:AddMessage(INNERFIRE_TEXT.DEBUG.."--> could not find button for id ".._innerFireData.id.." (".._buffButtonName..(_innerFireData.id + _buffButtonOffset).."Count"..")");
		end
	end
end


------------------------------------------------------------------------------
-- Spellbook and action bar parsing functions
------------------------------------------------------------------------------
local function Innerfire_CheckSpellbook()
	-- Parses the player's spellbook, looking for the Inner Fire spell.
	if (_debugFrame) then
		_debugFrame:AddMessage(INNERFIRE_TEXT.DEBUG.."Innerfire_CheckSpellbook()");
	end
	_innerFireData.spellIDs = {};
	for tab = 1, GetNumSpellTabs(), 1 do
		local name, texture, offset, numSpells = GetSpellTabInfo(tab);
		local found;
		for index = 1, numSpells do
			local spellName, spellRank = GetSpellName(offset + index, BOOKTYPE_SPELL);
			if (spellName == INNERFIRE_TEXT.SPELLNAME_INNER_FIRE) then
				if (_debugFrame) then
					_debugFrame:AddMessage(INNERFIRE_TEXT.DEBUG.."--> found "..spellName.." at index "..(offset + index));
				end
				_innerFireData.spellIDs[offset + index] = 1;
				found = true;
			end
		end
		if (found) then
			break;
		end
	end
end


local function Innerfire_ProcessActionID(id)
	-- Uses the hidden tooltip to check for the Inner Fire spell at the
	-- indicated action bar id, and if found, updates the actionIDs table
	_innerFireData.actionIDs[id] = nil;
	if (HasAction(id) and not GetActionText(id)) then
		InnerfireTooltip:SetOwner(_thisFrame, "ANCHOR_NONE");
		InnerfireTooltip:ClearLines();
		InnerfireTooltip:SetAction(id);
		local actionName = InnerfireTooltipTextLeft1:GetText();
		local actionRank = InnerfireTooltipTextRight1:GetText();
		InnerfireTooltip:Hide();
		if ((actionName == INNERFIRE_TEXT.SPELLNAME_INNER_FIRE) and (actionRank ~= "")) then
			_innerFireData.actionIDs[id] = 1;
			if (_debugFrame) then
				_debugFrame:AddMessage(INNERFIRE_TEXT.DEBUG.."--> found "..actionName.." "..actionRank.." at action id "..id);
			end
		end
	end
end


local function Innerfire_ScanActionBar(id)
	-- Scans the action id using Innerfire_ProcessActionID for the
	-- indicated id, or for all ids if no specific id is given.
	if (_debugFrame) then
		_debugFrame:AddMessage(INNERFIRE_TEXT.DEBUG.."Innerfire_ScanActionBar("..(id or "")..")");
	end
	if (id) then
		Innerfire_ProcessActionID(id);
	else
		_innerFireData.actionIDs = {};
		for id = INNERFIRE_ACTION_SLOT_FIRST, INNERFIRE_ACTION_SLOT_LAST do
			Innerfire_ProcessActionID(id);
		end
	end
end

------------------------------------------------------------------------------
-- Initialization and registration functions
------------------------------------------------------------------------------
local function Innerfire_ConvertStringToFind(text)
	-- Given a text string containing %s and %d parameters, this function
	-- converts these to a string that can be passed to string.find to extract
	-- the parameters from text formatted using this string.
	local newText = string.gsub(text, "%.", "%%.")
	newText = string.gsub(newText, "%%%d%$", "%%");	-- Handle EU client translation order parameters
	newText = string.gsub(newText, "%%s", "(.+)");
	newText = string.gsub(newText, "%%d", "(%%d+)");
	return newText;
end


local function Innerfire_ConfigurePatternData()
	-- Process some of the global strings into patterns we will use to check
	-- for combat events.
	_patternData = {};
	_patternData.COMBATHITOTHERSELF = Innerfire_ConvertStringToFind(COMBATHITOTHERSELF);
	_patternData.COMBATHITCRITOTHERSELF = Innerfire_ConvertStringToFind(COMBATHITCRITOTHERSELF);
	_patternData.SPELLLOGOTHERSELF = Innerfire_ConvertStringToFind(SPELLLOGOTHERSELF);
	_patternData.SPELLLOGCRITOTHERSELF = Innerfire_ConvertStringToFind(SPELLLOGCRITOTHERSELF);
end


local function Innerfire_HookFunctions()
	 -- Hook the interface functions if we haven't already
	if (not _original_UseAction) then
		_original_UseAction = UseAction;
		UseAction = Innerfire_UseAction;
	end
	if (not _original_CastSpellByName) then
		_original_CastSpellByName = CastSpellByName;
		CastSpellByName = Innerfire_CastSpellByName;
	end
	if (not _original_CastSpell) then
		_original_CastSpell = CastSpell;
		CastSpell = Innerfire_CastSpell;
	end
	if (not _original_GetPlayerBuffApplications) then
		_original_GetPlayerBuffApplications = GetPlayerBuffApplications;
		GetPlayerBuffApplications = Innerfire_GetPlayerBuffApplications;
	end
end


local function Innerfire_Register()
	-- Register for events and check for any custom buff frames that we need
	-- to accommodate.
	for _, event in _eventData do
		_thisFrame:RegisterEvent(event);
	end

	-- Select buff frame button name and offset (starting with default)
	_buffButtonName = "BuffButton";
	_buffButtonOffset = 0;
	_buffButtonFilter = "HELPFUL";
	if (CT_BuffFrame and CT_BuffFrame:IsVisible()) then				-- CTMod
		_buffButtonName = "CT_BuffButton";
		_buffButtonFilter = "HELPFUL|HARMFUL";
	elseif (SatrinaBuffFrame) then									-- Satrina
		_buffButtonName = "SatrinaBuffButton";
		_buffButtonOffset = 1;
	elseif (Gypsy_BuffFrame and not BuffFrame:IsVisible()) then		-- GypsyMod
		_buffButtonName = "Gypsy_BuffButton";
		_buffButtonFilter = "HELPFUL|HARMFUL";
	end
end


local function Innerfire_Unregister()
	for _, event in _eventData do
		_thisFrame:UnregisterEvent(event);
	end
end


local function Innerfire_VariablesLoaded()
	-- Called for the VARIABLES_LOADED event, this function retrieves the
	-- current settings and sets the realm name.
	_serverName = GetRealmName();
	if (not InnerfireState) then
		InnerfireState = {};
	end
	if (not InnerfireState.Servers) then
		InnerfireState.Servers = {};
	end
	if (not InnerfireState.Servers[_serverName]) then
		InnerfireState.Servers[_serverName] = {};
	end
	if (not InnerfireState.Servers[_serverName].Characters) then
		InnerfireState.Servers[_serverName].Characters = {};
	end
end


local function Innerfire_PlayerLogin()
	-- This function is called for the PLAYER_LOGIN event and checks to see if
	-- the playername is known so the player's per character settings can be
	-- retrieved.
	_playerName = UnitName("player");
	local _, classname = UnitClass("player");
	if (classname == "PRIEST") then
		_classEnabled = 1;
	end
	if (_classEnabled == 1) then
		if (not InnerfireState.Servers[_serverName].Characters[_playerName]) then
			InnerfireState.Servers[_serverName].Characters[_playerName] = {};
		end
		if (not InnerfireState.Servers[_serverName].Characters[_playerName].Enabled) then
			InnerfireState.Servers[_serverName].Characters[_playerName].Enabled = 1;
		end
		_enabled = InnerfireState.Servers[_serverName].Characters[_playerName].Enabled;
		if (_enabled == 1) then
			Innerfire_HookFunctions();
			Innerfire_CheckSpellbook();
			Innerfire_ScanActionBar();
		end
	else
		_enabled = 0;
		if (InnerfireState.Servers[_serverName].Characters) then
			if (InnerfireState.Servers[_serverName].Characters[_playerName]) then
				InnerfireState.Servers[_serverName].Characters[_playerName] = nil;
			end
		end
	end
end



------------------------------------------------------------------------------
-- Hooked functions (public)
------------------------------------------------------------------------------
function Innerfire_UseAction(id, cursor, onSelf)
	_original_UseAction(id, cursor, onSelf);
	if ((_enabled == 1) and _innerFireData.actionIDs[id] and IsCurrentAction(id)) then
		if (_debugFrame) then
			_debugFrame:AddMessage(INNERFIRE_TEXT.DEBUG.."Innerfire_UseAction called for Inner Fire at ID "..id);
		end
		_innerFireSpellCasting = true;
	end
end


function Innerfire_CastSpellByName(spellName, onSelf)
	if (_enabled == 1) then
		local _, _, spell = string.find(spellName, "^([^%(]+)");
		if (spell == INNERFIRE_TEXT.SPELLNAME_INNER_FIRE) then
			if (_debugFrame) then
				_debugFrame:AddMessage(INNERFIRE_TEXT.DEBUG.."Innerfire_CastSpellByName called for Inner Fire");
			end
			_innerFireCastPending = true;
			_original_CastSpellByName(spellName, onSelf);
			_innerFireSpellCasting = _innerFireCastPending;
			_innerFireCastPending = nil;
		else
			_original_CastSpellByName(spellName, onSelf);
		end
	else
		_original_CastSpellByName(spellName, onSelf);
	end
end


function Innerfire_CastSpell(spellID, bookName)
	if ((_enabled == 1) and _innerFireData.spellIDs[spellID] and (bookName == BOOKTYPE_SPELL)) then
		if (_debugFrame) then
			_debugFrame:AddMessage(INNERFIRE_TEXT.DEBUG.."Innerfire_CastSpell called for Inner Fire at spellID "..spellID);
		end
		_innerFireCastPending = true;
		_original_CastSpell(spellID, bookName);
		_innerFireSpellCasting = _innerFireCastPending;
		_innerFireCastPending = nil;
	else
		_original_CastSpell(spellID, bookName);
	end
end


function Innerfire_GetPlayerBuffApplications(index)
	if ((_enabled == 1) and (index == _innerFireData.index)) then
		if (_innerFireData.count) then
			return _innerFireData.count;
		else
			return 0;
		end
	else
		return _original_GetPlayerBuffApplications(index);
	end
end


------------------------------------------------------------------------------
-- OnEvent handler
------------------------------------------------------------------------------
function Innerfire_OnEvent(event)
	if (_debugFrame) then
		_debugFrame:AddMessage(INNERFIRE_TEXT.DEBUG.."Innerfire_OnEvent("..(event or "")..", "..(arg1 or "")..")");
	end
	if ((event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS") or			-- monsters
		(event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS")) then			-- duels and pvp
		if (string.find(arg1, _patternData.COMBATHITOTHERSELF) or
			string.find(arg1, _patternData.COMBATHITCRITOTHERSELF)) then
			if (_debugFrame) then
				_debugFrame:AddMessage(INNERFIRE_TEXT.DEBUG.."--> (melee) "..INNERFIRE_EM.RED..arg1..INNERFIRE_EM.OFF);
			end
			if (_innerFireData.count) then
				_innerFireData.count = _innerFireData.count - 1;
				if (_innerFireData.count == 0) then
					_innerFireData.count = nil;
				end
				Innerfire_UpdateButton();
			end
		end

	elseif ((event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE") or		-- monsters
		(event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE")) then			-- duels and pvp
		if (string.find(arg1, _patternData.SPELLLOGOTHERSELF) or
			string.find(arg1, _patternData.SPELLLOGCRITOTHERSELF)) then
			if (_debugFrame) then
				_debugFrame:AddMessage(INNERFIRE_TEXT.DEBUG.."--> (spell) "..INNERFIRE_EM.RED..arg1..INNERFIRE_EM.OFF);
			end
			if (_innerFireData.count) then
				_innerFireData.count = _innerFireData.count - 1;
				if (_innerFireData.count == 0) then
					_innerFireData.count = nil;
				end
				Innerfire_UpdateButton();
			end
		end

	elseif (event == "SPELLCAST_STOP") then
		if (_innerFireSpellCasting) then
			if (_debugFrame) then
				_debugFrame:AddMessage(INNERFIRE_TEXT.DEBUG.."--> Inner Fire refreshed");
			end
			_innerFireData.count = INNERFIRE_SPELL_CHARGES;
			Innerfire_UpdateButton();
		end
		_innerFireSpellCasting = nil;

	elseif ((event == "SPELLCAST_FAILED") or
		((event == "UI_ERROR_MESSAGE") and ((arg1 == ERR_OUT_OF_MANA) or (arg1 == SPELL_FAILED_SPELL_IN_PROGRESS)))) then
		if (_debugFrame) then
			if (_innerFireCastPending) then
				_debugFrame:AddMessage(INNERFIRE_TEXT.DEBUG.."--> Inner Fire failed to start casting");
			elseif (_innerFireSpellCasting) then
				_debugFrame:AddMessage(INNERFIRE_TEXT.DEBUG.."--> Inner Fire failed to cast");
			end
		end
		if (_innerFireCastPending) then
			_innerFireCastPending = nil;
		else
			_innerFireSpellCasting = nil;
		end

	elseif (event == "PLAYER_AURAS_CHANGED") then
		Innerfire_FindInnerFireBuff();
		Innerfire_UpdateButton();

	elseif (event == "SPELLS_CHANGED") then
		Innerfire_CheckSpellbook();

	elseif (event == "ACTIONBAR_SLOT_CHANGED") then
		Innerfire_ScanActionBar(arg1);

	elseif (event == "PLAYER_ENTERING_WORLD") then
		if (_enabled == 1) then
			Innerfire_Register();
			Innerfire_FindInnerFireBuff();
			Innerfire_UpdateButton();
		end

	elseif (event == "PLAYER_LEAVING_WORLD") then
		Innerfire_Unregister();

	elseif (event == "VARIABLES_LOADED") then
		Innerfire_VariablesLoaded();

	elseif (event == "PLAYER_LOGIN") then
		Innerfire_PlayerLogin();
	
	end
end


------------------------------------------------------------------------------
-- OnLoad function
------------------------------------------------------------------------------
function Innerfire_OnLoad()
	-- Record our frame pointer for later
	_thisFrame = this;

	-- Register for player events
	_thisFrame:RegisterEvent("VARIABLES_LOADED");
	_thisFrame:RegisterEvent("PLAYER_LOGIN");
	_thisFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	_thisFrame:RegisterEvent("PLAYER_LEAVING_WORLD");

	-- Register slash command handler
	SLASH_INNERFIRE1 = "/innerfire";
	SlashCmdList["INNERFIRE"] = function(text)
		Innerfire_SlashCommand(text);
	end

	-- Configure combat log search patterns
	Innerfire_ConfigurePatternData();

	-- Announce ourselves
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(INNERFIRE_NAME.." v"..INNERFIRE_VERSION.." loaded");
	end
end


------------------------------------------------------------------------------
-- Slash command function
------------------------------------------------------------------------------
function Innerfire_SlashCommand(text)
	if (text) then
		local command, params = Innerfire_GetNextParam(string.lower(text));
		if ((command == INNERFIRE_TEXT.COMMAND_ON) or (command == INNERFIRE_TEXT.COMMAND_ENABLE)) then
			if (_classEnabled == 1) then
				_enabled = 1;
				InnerfireState.Servers[_serverName].Characters[_playerName].Enabled = _enabled;
				Innerfire_HookFunctions();
				Innerfire_CheckSpellbook();
				Innerfire_ScanActionBar();
				Innerfire_Register();
				Innerfire_FindInnerFireBuff();
				Innerfire_UpdateButton();
				if (DEFAULT_CHAT_FRAME) then
					DEFAULT_CHAT_FRAME:AddMessage(INNERFIRE_TEXT.COMMAND_ENABLE_CONFIRM);
				end
			else
				if (DEFAULT_CHAT_FRAME) then
					DEFAULT_CHAT_FRAME:AddMessage(INNERFIRE_TEXT.COMMAND_ENABLE_FAILED);
				end
			end
		elseif ((command == INNERFIRE_TEXT.COMMAND_OFF) or (command == INNERFIRE_TEXT.COMMAND_DISABLE)) then
			if (_classEnabled == 1) then
				_enabled = 0;
				InnerfireState.Servers[_serverName].Characters[_playerName].Enabled = _enabled;
				Innerfire_Unregister();
				Innerfire_FindInnerFireBuff();
				_innerFireData.count = nil;
				if (DEFAULT_CHAT_FRAME) then
					DEFAULT_CHAT_FRAME:AddMessage(INNERFIRE_TEXT.COMMAND_DISABLE_CONFIRM);
				end
			else
				if (DEFAULT_CHAT_FRAME) then
					DEFAULT_CHAT_FRAME:AddMessage(INNERFIRE_TEXT.COMMAND_UNABLE_STATUS);
				end
			end
		elseif (command == INNERFIRE_TEXT.COMMAND_STATUS) then
			if (DEFAULT_CHAT_FRAME) then
				if (_enabled == 1) then
					DEFAULT_CHAT_FRAME:AddMessage(INNERFIRE_TEXT.COMMAND_ENABLED_STATUS);
				else
					if (_classEnabled == 1) then
						DEFAULT_CHAT_FRAME:AddMessage(INNERFIRE_TEXT.COMMAND_DISABLED_STATUS);
					else
						DEFAULT_CHAT_FRAME:AddMessage(INNERFIRE_TEXT.COMMAND_UNABLE_STATUS);
					end
				end
			end
		elseif (command == INNERFIRE_TEXT.COMMAND_DEBUGON) then
			_debugFrame = DEFAULT_CHAT_FRAME;
			if (DEFAULT_CHAT_FRAME) then
				DEFAULT_CHAT_FRAME:AddMessage(INNERFIRE_TEXT.COMMAND_DEBUGON_CONFIRM);
			end
		elseif (command == INNERFIRE_TEXT.COMMAND_DEBUGOFF) then
			_debugFrame = nil;
			if (DEFAULT_CHAT_FRAME) then
				DEFAULT_CHAT_FRAME:AddMessage(INNERFIRE_TEXT.COMMAND_DEBUGOFF_CONFIRM);
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage(INNERFIRE_EM.ON..INNERFIRE_NAME.." v"..INNERFIRE_VERSION..INNERFIRE_EM.OFF);
			if (DEFAULT_CHAT_FRAME) then
				for _, string in INNERFIRE_HELP do
					DEFAULT_CHAT_FRAME:AddMessage(string);
				end
			end
		end
	end
end


------------------------------------------------------------------------------
-- Macro callable function
------------------------------------------------------------------------------
function HasInnerFire(minCharges, minDuration)
	-- Returns true if the player has Inner Fire and has the indicated minimum
	-- number of charges and minimum duration, or nil otherwise.  If the
	-- player has Inner Fire, but the number of charges are unknown, then the
	-- function will assume there are not enough charges (unless minCharges is
	-- nil or less than 1).
	if (_innerFireData.id and _innerFireData.index) then
		if (minCharges and (minCharges > 1)) then
			if (_innerFireData.count and (_innerFireData.count >= minCharges)) then
				-- We know we have the required minmum number of charges.
				if (minDuration) then
					if (GetPlayerBuffTimeLeft(_innerFireData.index) >= minDuration) then
						return true;
					end
				else
					-- Don't care about time remaining
					return true;
				end
			end
		else
			-- Player didn't care about the number of charges
			if (minDuration) then
				if (GetPlayerBuffTimeLeft(_innerFireData.index) >= minDuration) then
					return true;
				end
			else
				-- Didn't care about the duration either.
				return true;
			end
		end
	end
end


