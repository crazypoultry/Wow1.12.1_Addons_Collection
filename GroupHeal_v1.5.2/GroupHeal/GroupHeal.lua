
-----------------------------------------------
-- non-user-configurable options
-----------------------------------------------

-- sets the alpha level of the out of range red overlay when target may or may not be in range (0 to 1, inclusive)
local maybeInRangeAlphaLevel = 0.6;

-- sets how often range information is updated
local rangeUpdateInterval = 0.2; --in seconds

-- sets how often mana is checked (only matters for Cat/Bear form)
local manaUpdateInterval = 1; --in seconds

-- the duration of the "Weakened Soul" debuff
local WeakenedSoulDuration = 15; -- in seconds

-- enable/disable debugging output
local debugMode = true;

--the time to wait after a PARTY_MEMBERS_CHANGED event to check the
--target unit of the target buttons
local targetCheckWaitTime = 0.1;


-----------------------------------------------------------------------------------
-- global data tables and variables
-----------------------------------------------------------------------------------

GROUPHEAL_MAX_SPELLS = 4;

GroupHeal = {};

GroupHeal.SpellInfo = {};
GroupHeal.RankByTarget = {};
GroupHeal.TargetButtons = {};
GroupHeal.HealButtons = {};
GroupHeal.SelfHealButtons = {};

for x = 1, GROUPHEAL_MAX_SPELLS do
	GroupHeal.SpellInfo[x] = {};
	GroupHeal.RankByTarget[x] = {};
	GroupHeal.HealButtons[x] = {};
end 
GroupHeal.InRange = {};
GroupHeal.ButtonEvents = {};
GroupHeal.SpellUpdateFunctions = {};
GroupHeal.UnitsToMonitor = {};


-----------------------------------------------------------------------------------
-- local variable table pointers for global tables
-----------------------------------------------------------------------------------

local STRINGS = GROUPHEAL_STRINGS;
local buttonEvents = GroupHeal.ButtonEvents;
local inRange = GroupHeal.InRange;
local spellInfo = GroupHeal.SpellInfo;
local rankByTarget = GroupHeal.RankByTarget;
local targetButtons = GroupHeal.TargetButtons;
local healButtons = GroupHeal.HealButtons;
local selfHealButtons = GroupHeal.SelfHealButtons;
local spellUpdateFunctions = GroupHeal.SpellUpdateFunctions;
local unitsToMonitor = GroupHeal.UnitsToMonitor;

local classSpells; --shortcut to the spells of the current class

-----------------------------------------------------------------------------------
-- local only variables
-----------------------------------------------------------------------------------

local _class = UnitClass("player");
local _name = UnitName("player");

local GroupHeal_START_SLOT = 1
local GroupHeal_END_SLOT = 120

local lastRangeUpdate = 0;

local rangeSlot = 0;

local plusHealing = 0; --healing bonus from +Healing Gear


-----------------------------------------------------------------------------------
-- variables used by the auto-cancel system
-----------------------------------------------------------------------------------

local spellCasting = false;
local lastSpellTarget = nil;
local lastSpell = nil;
local canCancelAfter = 0;
--local lastSpellRank = nil;
local lastSpellMinHeal = 0;
local castingShouldBeCancelled = false;

-----------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------

local lastCastFailed = false;

-----------------------------------------------------------------------------------
-- BonusScanner Update function hook (will hook real Library if it is installed
-----------------------------------------------------------------------------------

local oldBonusScanner_Update = BonusScanner_Update;

if BonusScanner_Update then
	function BonusScanner_Update()
		oldBonusScanner_Update();
		plusHealing = BonusScanner:GetBonus("HEAL");
	end
else
	function BonusScanner_Update()
		plusHealing = GroupHeal_BonusScanner:GetBonus("HEAL");
	end
end


-----------------------------------------------------------------------------------
-- Print functions
-----------------------------------------------------------------------------------

local function PrintMsg(msg)
	if msg then
		DEFAULT_CHAT_FRAME:AddMessage("GroupHeal: "..msg);
	end
end 

local function debug(msg)
	if msg and debugMode then
		DEFAULT_CHAT_FRAME:AddMessage("GroupHeal (debug): "..msg);
	end
end

-----------------------------------------------------------------------------------
-- Default Settings
-----------------------------------------------------------------------------------

local PlayerButtonPosition = { ['x'] = 105, 
                               ['y'] = -66, 
                               ['point'] = "TOPLEFT",
                               ['relativeTo'] = PlayerFrame,
                               ['relativePoint'] = "TOPLEFT",
                             };

GroupHeal_Defaults = { 
	['enabled'] = true,

	['UseRequiredCutOff'] = { 50, 50 }, --as a % of the spell's minimum heal value

	--show/hide buttons
	['player'] = { true, true, true, true },
	['party'] = { true, true, true, true },
	['target'] = { true, true, true, true },

	['raidCancelTime'] = 1.0,
	['partyCancelTime'] = 10,

	['buttonSpacing'] = 1,

	['partyToParty'] = true,
	['partyToParty_whileInRaid'] = false,

	['showTooltips'] = true;
	
	["manaConvservation_Enabled"] = true;
	["overhealWarning"] = true;
	["overhealWarningFont"] = "SubZoneTextFont";
	["cancelWarningColour"] = {r=1.0, g=1.0, b=1.0, a=1.0};
	["cancelNowColour"] = {r=1.0, g=0.1, b=0.1, a=1.0};
};
GroupHeal_Settings = GroupHeal_Defaults;
local SETTINGS = GroupHeal_Settings;

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

local function canBeEnabled()
	if not classSpells or ( not spellInfo[1] and not spellInfo[2] ) then
		return false;
	end
	
	if classSpells and ( classSpells[1] or classSpells[2] or classSpells[3] ) then
		if table.getn(spellInfo[1]) > 0 or table.getn(spellInfo[2]) > 0 or table.getn(spellInfo[3]) > 0 then
			return true;
		end
	end
	return false;
end

-----------------------------------------------------------------------------------
-- Spell Data
-----------------------------------------------------------------------------------

-- sets the unset keys between 1 and 20 to value
local function setTableDefault( t, value )
	local n = table.getn(t) + 1;
	for i = n, 20 do
		t[i] = value;
	end
	return t;
end

STRINGS["getfenv"] = getfenv;
STRINGS["setfenv"] = setfenv;

setfenv(1, STRINGS);

getfenv(0)["GroupHeal_ClassSpells"] = {
	[DRUID] = { 
		[1] = { 
			["name"] = HEALING_TOUCH,
			["type"] = "byHP", 
			["healBonus"] = setTableDefault( { 0.123, 0.314, 0.554, 0.857 }, 1 ),
		},
		[2] = { 
			["name"] = REGROWTH,
			["type"] = "byLevel",
			["levels"] = {12-10, 18-10, 24-10, 30-10, 36-10, 42-10, 48-10, 54-10, 60-10},
		},
		[3] = { 
			["name"] = REJUVENATION,
			["type"] = "byLevel",
			["levels"] = {4-10, 10-10, 16-10, 22-10, 28-10, 34-10, 40-10, 46-10, 52-10, 58-10, 60-10},
		},
	},
	[SHAMAN] = { 
		[1] = { 
			["name"] = HEALING_WAVE,
			["type"] = "byHP", 
			["healBonus"] = setTableDefault( { 0.123, 0.271, 0.5, 0.793 }, 0.857 ),
		},
		[2] = { 
			["name"] = LESSER_HEALING_WAVE,
			["type"] = "byHP",
			["healBonus"] = setTableDefault( {}, 0.429 ),
		},
	},
	[PALADIN] = { 
		[1] = { 
			["name"] = HOLY_LIGHT,
			["type"] = "byHP", 
			["healBonus"] = setTableDefault( { 0.205, 0.339, 0.554 }, 0.714 ),
		},
		[2] = { 
			["name"] = FLASH_OF_LIGHT,
			["type"] = "byHP",
			["healBonus"] = setTableDefault( {}, 0.429 ),
		},
	},
	[PRIEST] = { 
		[1] = { 
			["name"] = HEAL,
			["greaterVer"] = HEAL_GREATER,
			["lesserVer"] = HEAL_LESSER,
			["type"] = "byHP", 
			["healBonus"] = setTableDefault( { 0.123, 0.229, 0.446, 0.729 }, 1 ),
		},
		[2] = { 
			["name"] = FLASH_HEAL,
			["type"] = "byHP",
			["healBonus"] = setTableDefault( {}, 0.429 ),
		},
		[3] = { 
			["name"] = RENEW,
			["type"] = "byLevel",
			["levels"] = {8-10, 14-10, 20-10, 26-10, 32-10, 38-10, 44-10, 50-10, 56-10, 60-10},
		},
		[4] = { 
			["name"] = SHIELD,
			["type"] = "Shield",
			["debuff"] = "Interface\\Icons\\Spell_Holy_AshesToAshes",
			["levels"] = {6-10, 12-10, 18-10, 24-10, 30-10, 36-10, 42-10, 48-10, 54-10, 60-10},
		},
	},
};

setfenv(1, getfenv(0));

STRINGS["getfenv"] = nil;
STRINGS["setfenv"] = nil;

-----------------------------------------------------------------------------------
-- Functions
-----------------------------------------------------------------------------------

function GroupHeal_Load_Spell_Ids()
	
	GroupHeal_Tooltip:SetOwner(GroupHealFrame, "ANCHOR_NONE");
	for x= 1, GROUPHEAL_MAX_SPELLS do
		spellInfo[x]['C1'] = 0;
		spellInfo[x]['C2'] = 0;
		table.setn(spellInfo[x], 0);
	end
	
	if not GroupHeal_ClassSpells[_class] then
		return;
	end
	
	local i = 1;
	
	while true do
		
		local spell_name, spell_rank = GetSpellName(i, BOOKTYPE_SPELL);
		if not spell_name then 
			break;
		end
		
		for k, v in classSpells do
			if ( v['name'] == spell_name ) then
				spellInfo[k]['C2'] = spellInfo[k]['C2'] + 1;
				slot = spellInfo[k]['C1'] + spellInfo[k]['C2'];
				tinsert(spellInfo[k], slot, GroupHeal_GetSpellInformation(i));
				--spellInfo[k]['maxRank'] = spellInfo[k]['maxRank'] + 1;
				
			elseif ( v['lesserVer'] ) and ( v['lesserVer'] == spell_name ) then
				spellInfo[k]['C1'] = spellInfo[k]['C1'] + 1;
				slot = spellInfo[k]['C1'];
				tinsert(spellInfo[k], slot, GroupHeal_GetSpellInformation(i));
				--spellInfo[k]['maxRank'] = spellInfo[k]['maxRank'] + 1;
			
			elseif ( v['greaterVer'] ) and ( v['greaterVer'] == spell_name ) then
				tinsert(spellInfo[k], GroupHeal_GetSpellInformation(i));
				--spellInfo[k]['maxRank'] = spellInfo[k]['maxRank'] + 1;
			end
		end
		
		i = i + 1;
		if i > MAX_SPELLS then break; end -- safety
		
	end
end


local spellCache = {}
setmetatable(spellCache, {__mode = "v"} );


function GroupHeal_GetSpellInformation(id) 
	
	GroupHeal_Tooltip:SetSpell(id, BOOKTYPE_SPELL);
	local spellInfo = spellCache[id] or { ["id"] = id };
	spellCache[id] = spellInfo;
	
	spellInfo["texture"] = GetSpellTexture(id, BOOKTYPE_SPELL);
	
	--find spell min and max
	text = GroupHeal_TooltipTextLeft4:GetText();
	s, f = strfind(text, "(%d+)");
	spellInfo['spellLow'] = tonumber(strsub(text, s, f));
	s, f = strfind(text, "(%d+)", f+3);
	spellInfo['spellHigh'] = tonumber(strsub(text, s, f));
	
	--find spell mana
	text = GroupHeal_TooltipTextLeft2:GetText();
	s, f = strfind(text, "(%d+)");
	spellInfo['mana'] = tonumber(strsub(text, s, f));
	
	return spellInfo;
end

function GroupHeal_CastSpell(target, spellNum) 
	local cancelled = GroupHeal_ConditionalCancel();
	
	if ( spellCasting and not cancelled ) then return; end
	if not ( spellNum and spellInfo[spellNum] and spellInfo[spellNum][1] ) then return; end;
	if not GroupHeal_UnitCanBeHealed(target) then return; end;
	
	lastSpellTarget = target;
	lastSpell = spellNum;
	lastSpellRank = rankByTarget[spellNum][target];
	lastSpellMinHeal = spellInfo[spellNum][lastSpellRank]["spellLow"];
	if ( plusHealing and classSpells[spellNum].healBonus ) then
		lastSpellMinHeal = lastSpellMinHeal + (plusHealing*classSpells[spellNum].healBonus[lastSpellRank]);
	end
	local spellBookId = spellInfo[spellNum][lastSpellRank]["id"];
	local lastTarget = UnitName('target');
	
	--don't start casting if auto-cancel system says no
	if ( SETTINGS["manaConvservation_Enabled"] and SETTINGS.UseRequiredCutOff[lastSpell] ) then
		local H = (UnitHealthMax(lastSpellTarget) - UnitHealth(lastSpellTarget));
		if ( H < (lastSpellMinHeal * (SETTINGS.UseRequiredCutOff[lastSpell]/100)) ) then
			lastSpell = nil;
			return;
		end
	end
	
	lastCastFailed = false;
	
	if ( GroupHeal_UnitCanBeHealed("target") ) then
		TargetUnit(target);
		CastSpell(spellBookId, BOOKTYPE_SPELL);
		TargetByName(lastTarget);
	else
		local autoCastingState = GetCVar("autoSelfCast");
		if not ( autoCastingState == "0" ) then
			SetCVar("autoSelfCast", 0);
		end
		CastSpell(spellBookId, BOOKTYPE_SPELL);
		if SpellIsTargeting() then
			SpellTargetUnit(target);
			if SpellIsTargeting() then
				SpellStopTargeting();
				lastCastFailed = true; --probably not needed
			end
		end
		if not ( autoCastingState == "0" ) then
			SetCVar("autoSelfCast", autoCastingState);
		end
	end
	return not lastCastFailed;
end

function GroupHeal_ConditionalCancel()
	--cancel current cast if it should be cancelled
	if ( castingShouldBeCancelled ) then
			SpellStopCasting();
			return true;
	end
end

local function ShowHideFrame(frame, show)
	if show then
		frame:Show();
	else
		frame:Hide();
	end
end

function GroupHeal_PositionPlayerButtons()
	local x = PlayerButtonPosition.x;
	local y = PlayerButtonPosition.y;
	if DruidBarKey and DruidBarKey.XPBar and DruidBarFrame:IsShown() then
		y = y - DruidBarFrame:GetHeight() + 3;
	end
	GroupHeal_HealSelf:ClearAllPoints();
	GroupHeal_HealSelf:SetPoint(PlayerButtonPosition.point, PlayerButtonPosition.relativeTo, PlayerButtonPosition.relativePoint, x, y);
end

function GroupHeal_PositionButtons()
	
	--hide all buttons if no healing spells were found
	if not ( canBeEnabled() ) then 
		for k, v in healButtons do
			for key, value in v do
				value:Hide();
			end
		end
		for k, v in selfHealButtons do
			v:Hide();
		end
		for k, v in targetButtons do
			v:Hide();
		end
		return;
	end
	
	--show/hide buttons
	for x = 1, GROUPHEAL_MAX_SPELLS do
		
		if ( selfHealButtons[x] ) then
			ShowHideFrame( selfHealButtons[x], (spellInfo[x][1] and SETTINGS['player'][x]) );
		end
		
		for k, v in healButtons[x] do
			ShowHideFrame( v, (spellInfo[x][1] and SETTINGS['party'][x]) );
		end
		
		if ( targetButtons[x] ) then
			ShowHideFrame( targetButtons[x], (spellInfo[x][1] and SETTINGS['target'][x]) );
		end
	end
	
	--set button positions
	for x = 2, GROUPHEAL_MAX_SPELLS do
		if ( selfHealButtons[x] ) then
			if ( SETTINGS['player'][x-1] and spellInfo[x-1][1] ) then
				selfHealButtons[x]:SetPoint("LEFT", selfHealButtons[x-1], "RIGHT", SETTINGS['buttonSpacing'], 0);
			else
				selfHealButtons[x]:SetPoint("LEFT", selfHealButtons[x-1], "LEFT", 0, 0);
			end
		end
			
		
		if ( SETTINGS['party'][x-1] and spellInfo[x-1][1] ) then
			for k, v in healButtons[x] do
				v:SetPoint("LEFT", healButtons[x-1][k], "RIGHT", SETTINGS['buttonSpacing'], 0);
			end
		else
			for k, v in healButtons[x] do
				v:SetPoint("LEFT", healButtons[x-1][k], "LEFT", 0, 0);
			end
		end
		
		if ( targetButtons[x] ) then
			if ( SETTINGS['target'][x-1] and spellInfo[x-1][1] ) then
				targetButtons[x]:SetPoint("LEFT", targetButtons[x-1], "RIGHT", SETTINGS['buttonSpacing'], 0);
			else
				targetButtons[x]:SetPoint("LEFT", targetButtons[x-1], "LEFT", 0, 0);
			end
		end
	end
	
	GroupHeal_PositionCustomUnitFrames();
end


function GroupHeal_UnitCanBeHealed(unit)

	if not UnitExists(unit)             then return false; end
	if not UnitIsFriend('player', unit) then return false; end
	if not UnitIsVisible(unit)          then return false; end
	if not unit == 'player' and not UnitCanCooperate('player', unit) then return false; end
	if not UnitIsConnected(unit)        then return false; end
	
	if UnitIsDeadOrGhost(unit)       then return false; end
	if UnitIsEnemy(unit, 'player')   then return false; end
	if UnitCanAttack(unit, 'player') then return false; end
	if UnitCanAttack('player', unit) then return false; end
	if UnitIsCharmed(unit)           then return false; end
	
	return true;
end

function GroupHeal_GetTarget(buttonId) 
	local spellId = math.floor(buttonId/100);
	local targetId = math.mod(buttonId, 100);
	
	if ( targetId == 0 ) then
		return nil, spellId;
	elseif ( targetId == 1 ) then
		return 'player', spellId;
	elseif ( targetId == 2 ) then
		return 'party1', spellId;
	elseif ( targetId == 3 ) then
		return 'party2', spellId;
	elseif ( targetId == 4 ) then
		return 'party3', spellId;
	elseif ( targetId == 5 ) then
		return 'party4', spellId;
	elseif ( targetId > 5 and targetId < 50 ) then
		local id = targetId - 5;
		return 'raid'..id, spellId;
	else
		return -1;
	end
end

function GroupHeal_GetSpellBookID(target, spellId) 
	return spellInfo[spellId][rankByTarget[spellId][target]]['id'];
end

function GroupHeal_OnUpdate(elapsed) 

	lastRangeUpdate = lastRangeUpdate + elapsed;
	if ( lastRangeUpdate > rangeUpdateInterval ) then
		GroupHeal_CheckRanges();
		lastRangeUpdate = 0;
	end

	castingShouldBeCancelled = false;

	if ( SETTINGS["manaConvservation_Enabled"] ) then
		local overhealWarning = false;
		local textColour = SETTINGS["cancelWarningColour"];
		if ( spellCasting ) and ( SETTINGS.UseRequiredCutOff[lastSpell] ) then
			local H = (UnitHealthMax(lastSpellTarget) - UnitHealth(lastSpellTarget));
			if H < ( lastSpellMinHeal * (SETTINGS.UseRequiredCutOff[lastSpell]/100) ) then
				overhealWarning = true;
				if (GetTime() >= canCancelAfter) or (not UnitAffectingCombat(lastSpellTarget)) then
					castingShouldBeCancelled = true;
					textColour = SETTINGS["cancelNowColour"];
				end
			end
		end
		if ( overhealWarning and SETTINGS.overhealWarning ) then
			GroupHeal_CancelHealWarningText:SetTextColor(textColour.r, textColour.g, textColour.b, textColour.a);
			GroupHeal_CancelHealWarning:Show();
		else
			GroupHeal_CancelHealWarning:Hide();
		end
	end
end

function GroupHeal_PlayerLogin() 
	GroupHeal_Load_Spell_Ids();
	
	GroupHeal_PositionPlayerButtons();
	GroupHeal_PositionButtons();
	rangeSlot = GroupHeal_FindHealingActionSlot();
	
	if ( GetNumRaidMembers() > 0 ) then
		GroupHeal_OnEvent("RAID_ROSTER_UPDATE");
	end
end

function GroupHeal_PlayerEnteringWorld() 
	this:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
end

function GroupHeal_PlayerLeavingWorld() 
	this:UnregisterEvent("ACTIONBAR_SLOT_CHANGED");
end

function GroupHeal_AddOnLoaded()
	--setup the local pointer
	SETTINGS = GroupHeal_Settings;

	--remove old system of per user-settings
	SETTINGS[GetRealmName()] = nil;
	
	for k, v in GroupHeal_Defaults do
		if ( SETTINGS[k] == nil ) then
			SETTINGS[k] = v;
		end
	end
	
	--conversions from old settings
	if ( SETTINGS['selfBigHeal'] ~= nil ) then
		SETTINGS['player'][1] = SETTINGS['selfBigHeal'];
		SETTINGS['selfBigHeal'] = nil;
	end
	if ( SETTINGS['selfFastHeal'] ~= nil ) then
		SETTINGS['player'][2] = SETTINGS['selfFastHeal'];
		SETTINGS['selfFastHeal'] = nil;
	end
	if ( SETTINGS['selfOverTimeHeal'] ~= nil ) then
		SETTINGS['player'][3] = SETTINGS['selfOverTimeHeal'];
		SETTINGS['selfOverTimeHeal'] = nil;
	end
	
	if ( SETTINGS['partyBigHeal'] ~= nil ) then
		SETTINGS['party'][1] = SETTINGS['partyBigHeal'];
		SETTINGS['partyBigHeal'] = nil;
	end
	if ( SETTINGS['partyFastHeal'] ~= nil ) then
		SETTINGS['party'][2] = SETTINGS['partyFastHeal'];
		SETTINGS['partyFastHeal'] = nil;
	end
	if ( SETTINGS['partyOverTimeHeal'] ~= nil ) then
		SETTINGS['party'][3] = SETTINGS['partyOverTimeHeal'];
		SETTINGS['partyOverTimeHeal'] = nil;
	end
	
	GroupHeal_SupportCustomUnitFrames();
	
	--spell rank update events
	GroupHeal_ButtonEventsFrame:RegisterEvent("UNIT_LEVEL");
	GroupHeal_ButtonEventsFrame:RegisterEvent("UNIT_HEALTH");
end

local DruidBar_OnShow = nil;
local DruidBar_OnHide = nil;

function GroupHeal_OnLoad() 
	
	classSpells = GroupHeal_ClassSpells[_class];
	
	--setup binding names
	local HealNames = { "Big Heal", "Fast Heal", "Over Time Heal", "Shield" };
	if classSpells then 
		for k, v in classSpells do
			HealNames[k] = "Cast "..v['name']
		end
	end
	BINDING_HEADER_GROUPHEAL_BIGHEAL = BINDING_HEADER_GROUPHEAL_BIGHEAL..HealNames[1];
	BINDING_HEADER_GROUPHEAL_FASTHEAL = BINDING_HEADER_GROUPHEAL_FASTHEAL..HealNames[2];
	BINDING_HEADER_GROUPHEAL_OVERTIMEHEAL = BINDING_HEADER_GROUPHEAL_OVERTIMEHEAL..HealNames[3];
	BINDING_HEADER_GROUPHEAL_SHIELD = BINDING_HEADER_GROUPHEAL_SHIELD..HealNames[4];
	
	
	if not classSpells then --player is not a known healing class
		return;
	end
	
	for i, _ in classSpells do
		spellUpdateFunctions[i] = GroupHeal_GetSpellUpdateFunction(i);
	end
	

	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("PLAYER_LOGIN");
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	
	this:RegisterEvent("SPELLCAST_DELAYED");
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
	this:RegisterEvent("PLAYER_DEAD");
	
	if ( _class == "Druid" and DruidBarKey and DruidBarFrame ) then
		DruidBar_OnShow = DruidBarFrame:GetScript("OnShow");
		DruidBar_OnHide = DruidBarFrame:GetScript("OnHide");
		if ( DruidBar_OnShow ) then
			DruidBarFrame:SetScript("OnShow", (function() GroupHeal_PositionPlayerButtons(); DruidBar_OnShow();end) );
		else
			DruidBarFrame:SetScript("OnShow", GroupHeal_PositionPlayerButtons);
		end
		if ( DruidBar_OnHide ) then
			DruidBarFrame:SetScript("OnHide", (function() GroupHeal_PositionPlayerButtons(); DruidBar_OnHide();end) );
		else
			DruidBarFrame:SetScript("OnHide", GroupHeal_PositionPlayerButtons);
		end
	end
	
	--Slash Command
	SLASH_GROUPHEAL1 = "/groupheal";
	SlashCmdList["GROUPHEAL"] = GroupHeal_SlashCommands;
	
	SLASH_RAIDHEAL1 = "/raidheal";
	SlashCmdList["RAIDHEAL"] = function()
		UIParentLoadAddOn("RaidHeal");
		if ( IsAddOnLoaded("RaidHeal") ) then
			ShowUIPanel(RaidHealConfigFrame);
		end
	end;
end

function GroupHeal_OnEvent(event)
	
	if ( event == "SPELLS_CHANGED" )  then
		GroupHeal_Load_Spell_Ids();
		GroupHeal_PositionButtons();
	
	elseif ( event == "PLAYER_LOGIN" )  then
		GroupHeal_PlayerLogin();
	
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		GroupHeal_PlayerEnteringWorld();
	
	elseif ( event == "PLAYER_LEAVING_WORLD" ) then
		GroupHeal_PlayerLeavingWorld();
	
	elseif ( event == "ADDON_LOADED") then
		if ( arg1 == "GroupHeal" ) then
			GroupHeal_AddOnLoaded();
		end
	
	elseif ( event == "PARTY_MEMBERS_CHANGED" ) then
		GroupHeal_PositionCustomUnitFrames();
	
	elseif ( event == "SPELLCAST_START" ) then
		spellCasting = true;
		if ( lastSpell ) then
			if ( UnitInRaid("player") ) then
				canCancelAfter = GetTime() + ( arg2 / 1000 ) - SETTINGS['raidCancelTime'];
			else
				canCancelAfter = GetTime() + ( arg2 / 1000 ) - SETTINGS['partyCancelTime'];
			end
			GroupHeal_HealNotification( lastSpellTarget, format(STRINGS.castingNotification, arg1, UnitName(lastSpellTarget), (arg2/1000)) );
		end
	
	elseif ( event == "SPELLCAST_STOP" ) then
		if ( lastSpell ) then
			lastSpell = false;
		else
			lastSpell = nil;
		end
		spellCasting = false;
	
	elseif ( event == "SPELLCAST_FAILED" ) then
		lastCastFailed = true;
		spellCasting = false;
		lastSpell = nil;
	
	elseif ( event == "SPELLCAST_INTERRUPTED" or event == "PLAYER_DEAD" ) then
		spellCasting = false;
		if ( lastSpell == false ) then
			GroupHeal_HealNotification( lastSpellTarget, STRINGS.spellCancelled );
			lastSpell = nil;
		end
	
	elseif ( event == "SPELLCAST_DELAYED" and lastSpell ) then
		canCancelAfter = canCancelAfter + ( arg1 / 1000 );
	
	elseif ( event == "ACTIONBAR_SLOT_CHANGED" and arg1 == rangeSlot ) then
		rangeSlot = GroupHeal_FindHealingActionSlot();
	
	elseif ( event == "RAID_ROSTER_UPDATE" ) then
		if ( LoadAddOn("RaidHeal") ) then
			this:UnregisterEvent("RAID_ROSTER_UPDATE");
		end
	
	end
end

function GroupHeal_HealNotification( target, message )
	
	if UnitInRaid(target) and RaidHeal_Settings then
		if RaidHeal_Settings['raidToSay'] then
			SendChatMessage(message, "SAY");
			return;
			
		elseif RaidHeal_Settings['raidToParty'] and UnitExists("party1") then
			SendChatMessage(message, "PARTY");
			return;
			
		end
	end
	if ( UnitInParty(target) and UnitExists("party1") and SETTINGS['partyToParty'] ) then
		if ( not UnitInRaid("player") or SETTINGS['partyToParty_whileInRaid'] ) then 
			SendChatMessage(message, "PARTY");
			return;
		end
	end
	
end


function GroupHeal_SlashCommands(msg)
	local command_index,command_index_end, command, params= strfind(msg,'(%w*) *(.*)')
	local args = {};
	local i = 1;
	while (strlen(params) > 0) do
		command_index,command_index_end, nextParam, params= strfind(params,'(%w*) *(.*)')
		args[i] = nextParam;
		i = i + 1;
		if ( i > 10 ) then return; end; --safety
	end
	
	if command == "" then
		ShowUIPanel(GroupHealConfigFrame);
	end
	
	if strlower(command) == "rangecheck" then
--[[		--command disabled
	
		if args[1] then
			local setting = strlower(args[1]);
			if setting == "on" then
				GroupHeal_CheckRange = true;
			elseif setting == "off" then
				GroupHeal_CheckRange = false;
			end
		else
			GroupHeal_CheckRange = not GroupHeal_CheckRange;
		end
		GroupHeal_SetRangeChecking();
		
		if GroupHeal_CheckRange then
			PrintMsg("GroupHeal: Range checking turned on.");
		else
			PrintMsg("GroupHeal: Range checking turned off.");
		end
--]]
	end
	
end


function GroupHeal_GetSpellUpdateFunction( spellId )	
	
	local spellRanks = spellInfo[spellId];
	local func;

	if ( classSpells[spellId]['type'] == "byHP" ) then
		func = function( unit )
			local maxRank = table.getn(spellInfo[spellId]);
			if ( maxRank > 50 ) then
				debug("Erroneus maxRank for spell "..spellId);
				return; --ABORT!
			end
			local i = 1;
			local H = (UnitHealthMax(unit) - UnitHealth(unit));
			if ( UnitAffectingCombat(unit) ) then
				i = 1;
				while ( i < maxRank and spellRanks[i]['spellLow']+(plusHealing*classSpells[spellId].healBonus[i]) < H ) do 
					i = i + 1;
				end
			else
				i = maxRank;
				while ( i > 1 and spellRanks[i]['spellHigh']+(plusHealing*classSpells[spellId].healBonus[i]) > H ) do
					i = i - 1;
				end
			end
			
			if (i < 1) then
				i = 1;
			elseif (i > maxRank) then
				i = maxRank;
			end
			rankByTarget[spellId][unit] = i;
			return i;
		end
	
	elseif ( classSpells[spellId]['type'] == "byLevel" or classSpells[spellId]['type'] == "Shield" ) then
		func = function( unit )
			local maxRank = table.getn(spellInfo[spellId]);
			if ( maxRank > 50 ) then
				debug("Erroneus maxRank for spell "..spellId);
				return; --ABORT!
			end
			local i = 1;
			local L = UnitLevel(unit);
			for k, v in classSpells[spellId]['levels'] do
				if ( L >= v ) then
					i = k;
				end
			end
			
			if (i < 1) then
				i = 1;
			elseif (i > maxRank) then
				i = maxRank;
			end
			rankByTarget[spellId][unit] = i;
			return i;
		end
	end
	
	return func;
end

-------------------------------------------------------------------------------
-- HealButton Support Functions
-------------------------------------------------------------------------------

function GroupHeal_RegisterEvent( frame, event, unit )
	if ( not event and unit ) then return; end
	
	if not ( buttonEvents[event] ) then
		buttonEvents[event] = {};
	end
	if not ( buttonEvents[event][unit] ) then
		buttonEvents[event][unit] = {};
	end
	
	GroupHeal_ButtonEventsFrame:RegisterEvent(event);
	table.insert(buttonEvents[event][unit], frame);
end

function GroupHeal_UnregisterEvent( frame, event, unit )
	if not ( frame and event and unit ) then return end;
	
	if ( buttonEvents[event] and buttonEvents[event][unit] ) then
		for k, v in buttonEvents[event][unit] do
			if ( v == frame ) then
				table.remove(buttonEvents[event][unit], k);
				return;
			end
		end
	end
end

function GroupHeal_ButtonEvents_OnEvent( event, unit )
	
	if ( unitsToMonitor[unit] ) then 
		if ( event == "UNIT_LEVEL" ) then
			for i, func in spellUpdateFunctions do
				func(unit);
			end
		
		elseif ( event == "UNIT_HEALTH" ) then
			for i, func in spellUpdateFunctions do
				if ( classSpells[i].type == "byHP" ) then
					func(unit);
				end
			end
		
		end
	end
	
	if buttonEvents[event][unit] then
		for _, table in buttonEvents[event][unit] do
			this = table;
			GroupHeal_HealButton_OnEvent(event);
		end
	end
end

function GroupHeal_SetHealButtonTarget( button, unit )
	local oldTarget = button.target;
	if ( unit == oldTarget ) then return end;
	
	if ( oldTarget ) then
		unitsToMonitor[oldTarget] = unitsToMonitor[oldTarget] - 1;
		GroupHeal_UnregisterEvent(button, "UNIT_LEVEL", oldTarget);
		GroupHeal_UnregisterEvent(button, "UNIT_HEALTH", oldTarget);
		GroupHeal_UnregisterEvent(button, "UNIT_AURA", oldTarget);
	end
	if ( unit ) then
		GroupHeal_RegisterEvent(button, "UNIT_LEVEL", unit);
		if ( classSpells[button.spellId]['type'] == "byHP" ) then
			GroupHeal_RegisterEvent(button, "UNIT_HEALTH", unit);
		end
		if ( classSpells[button.spellId].debuff ) then
			GroupHeal_RegisterEvent(button, "UNIT_AURA", unit);
		end
		unitsToMonitor[unit] = (unitsToMonitor[unit] or 0) + 1;
		button.target = unit;
	else
		button.target = nil;
	end
end

function GroupHeal_SetHealButtonSpell( button, spellId )
	button.spellId = spellId;
end

-------------------------------------------------------------------------------
-- HealButton Functions
-------------------------------------------------------------------------------

function GroupHeal_HealButton_OnLoad() 
	this.timeSinceLastUpdate = 0;
	this.updateCycleNumber = 0;
	local cooldown = getglobal(this:GetName().."Cooldown");
	cooldown.start = 0;
	cooldown.duration = 0;
	local target, spellId = GroupHeal_GetTarget(this:GetID());
	GroupHeal_SetHealButtonSpell(this, spellId);
	
	if not ( classSpells and classSpells[this.spellId] ) then
		return;
	end
	
	if not ( target ) then return end;
	
	GroupHeal_SetHealButtonTarget(this, target);
	
	rankByTarget[this.spellId][target] = 1;
	inRange[target] = 1;
	
	if ( target ~= "player" and strsub(target, 1, 4) ~= "raid" ) then
		healButtons[this.spellId][target] = this;
	
	elseif ( target == "player" ) then
		selfHealButtons[this.spellId] = this;
	end
	
	GroupHeal_RegisterEvent(this, "UNIT_MANA", "player");
end

function GroupHeal_HealButton_OnClick()
	local check = GroupHeal_CastSpell( this.target, this.spellId );
	if ( check ) or ( (lastSpell == this.spellId) and (lastSpellTarget == this.target) ) then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
end

function GroupHeal_HealButton_OnEvent(event) 
	
	if ( event=="UNIT_HEALTH" or event=="UNIT_LEVEL" ) and ( this:IsVisible() ) then 
		GroupHeal_HealButton_UpdateTexture();
		GroupHeal_HealButton_UpdateMana();
	
	elseif ( event == "UNIT_MANA" and this:IsVisible() ) then
		GroupHeal_HealButton_UpdateMana();
	
	elseif ( event == "SPELLS_CHANGED" ) then
		GroupHeal_HealButton_UpdateTexture();
		GroupHeal_HealButton_UpdateMana();
	
	elseif ( event == "UNIT_AURA" ) then
		GroupHeal_HealButton_UpdateUsable();
	
	elseif ( event == "SPELL_UPDATE_COOLDOWN" ) then
		GroupHeal_HealButton_UpdateCooldown();
		
	else -- All other SPELLCAST events
		GroupHeal_HealButton_UpdateSelection( event );
	
	end
end

function GroupHeal_HealButton_OnShow()
	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
	
	GroupHeal_HealButton_UpdateButton();
end

function GroupHeal_HealButton_OnHide()
	this:UnregisterEvent("SPELLS_CHANGED");
	this:UnregisterEvent("SPELL_UPDATE_COOLDOWN");
	this:UnregisterEvent("SPELLCAST_FAILED");
	this:UnregisterEvent("SPELLCAST_START");
	this:UnregisterEvent("SPELLCAST_STOP");
	this:UnregisterEvent("SPELLCAST_INTERRUPTED");
end

function GroupHeal_HealButton_OnEnter()
	if ( SETTINGS.showTooltips ) then
		local id = GroupHeal_GetSpellBookID(this.target, this.spellId);
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetSpell(id, BOOKTYPE_SPELL);
		this.updateTooltip = TOOLTIP_UPDATE_TIME;
	end
end

local manaUpdateCycles = math.ceil(manaUpdateInterval/rangeUpdateInterval);
function GroupHeal_HealButton_OnUpdate(elapsed)
	
	this.timeSinceLastUpdate = this.timeSinceLastUpdate + elapsed;
	
	if (this.timeSinceLastUpdate > rangeUpdateInterval) then
		this.updateCycleNumber = this.updateCycleNumber + 1;
		GroupHeal_HealButton_UpdateInRange();
		this.timeSinceLastUpdate = 0;
	end
	
	if ( this.updateCycleNumber >= manaUpdateCycles ) then
		GroupHeal_HealButton_UpdateMana();
		this.updateCycleNumber = 0;
	end

	--tooltip update code
	if ( not this.updateTooltip ) then
		return;
	end
	
	this.updateTooltip = this.updateTooltip - elapsed;
	if ( this.updateTooltip > 0 ) then
		return;
	end

	if ( GameTooltip:IsOwned(this) ) then
		GroupHeal_HealButton_OnEnter();
	else
		this.updateTooltip = nil;
	end
end

function GroupHeal_HealButton_UpdateSelection( event )
	if ( event == "SPELLCAST_FAILED" or event == "SPELLCAST_STOP" ) then 
		this:SetChecked(0);
	elseif  ( spellCasting and lastSpellTarget == this.target and lastSpell == this.spellId ) then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
end

function GroupHeal_HealButton_UpdateButton()
	if not ( spellInfo[this.spellId][1] ) then 
		this:Hide();
		return; 
	end
	
	if ( GameTooltip:IsOwned(this) ) then
		GroupHeal_HealButton_OnEnter();
	end
	
	spellUpdateFunctions[this.spellId](this.target);
	
	GroupHeal_HealButton_UpdateTexture();
	GroupHeal_HealButton_UpdateCooldown();
	GroupHeal_HealButton_UpdateSelection();
	GroupHeal_HealButton_UpdateMana();
	GroupHeal_HealButton_UpdateInRange();
end

local function hasDebuff( texture, unit )
	local i = 1;
	local debuff = UnitDebuff(unit, i);
	while ( debuff ) do
		if ( debuff == texture ) then
			return true;
		end
		i = i + 1;
		debuff = UnitDebuff(unit, i);
	end
	return false;
end

function GroupHeal_HealButton_UpdateUsable()
	if ( classSpells[this.spellId].debuff ) then
		local cooldown = getglobal(this:GetName().."Cooldown");
		if ( hasDebuff(classSpells[this.spellId].debuff, this.target) ) and ( not this.hasDebuff ) then
			this.hasDebuff = GetTime();
			GroupHeal_CooldownFrame_SetTimer(cooldown, this.hasDebuff, WeakenedSoulDuration, 1);
		else
			GroupHeal_CooldownFrame_SetTimer(cooldown, 0, WeakenedSoulDuration, 0);
			this.hasDebuff = nil;
		end
	end
end

function GroupHeal_HealButton_UpdateTexture()
	local id = GroupHeal_GetSpellBookID(this.target, this.spellId);
	getglobal(this:GetName().."IconTexture"):SetTexture(spellCache[id]["texture"]);
end

function GroupHeal_HealButton_UpdateCooldown()
	local id = GroupHeal_GetSpellBookID(this.target, this.spellId);
	local cooldown = getglobal(this:GetName().."Cooldown");
	local start, duration, enable = GetSpellCooldown(id, BOOKTYPE_SPELL);
	GroupHeal_CooldownFrame_SetTimer(cooldown, start, duration, enable);
end

function GroupHeal_HealButton_UpdateMana()
	
	local iconTexture = getglobal(this:GetName().."IconTexture");
	local currentMana = 0;
	
	if ( UnitPowerType("player") == 0 ) then
		currentMana = UnitMana('player');
	elseif ( DruidBarKey ~= nil and DruidBarKey.keepthemana ~= nil ) then
		currentMana = floor(DruidBarKey.keepthemana);
	end

	if ( currentMana >= spellInfo[this.spellId][rankByTarget[this.spellId][this.target]]['mana'] ) then
		iconTexture:SetVertexColor(1.0, 1.0, 1.0);
	else
		iconTexture:SetVertexColor(0.5, 0.5, 1.0);
	end
end

function GroupHeal_HealButton_UpdateInRange()
	local redOverlay = getglobal(this:GetName().."RedOverlay");
	
	if ( inRange[this.target] == 1 ) then
		redOverlay:Hide();
	else 
		redOverlay:Show();
		if ( inRange[this.target] ) then
			redOverlay:SetAlpha(maybeInRangeAlphaLevel);
		else
			redOverlay:SetAlpha(1.0)
		end
	end
end

function GroupHeal_CooldownFrame_SetTimer(this, start, duration, enable)
	local finished = this.start + this.duration;
	if ( finished < start + duration ) then
		if ( start > 0 and duration > 0 and enable > 0) then
			this.start = start;
			this.duration = duration;
			this.stopping = 0;
			this:SetSequence(0);
			this:Show();
		else
			this:Hide();
		end
	end
end

-------------------------------------------------------------------------------
-- target frame functions
-------------------------------------------------------------------------------
local targetCheckFrame = CreateFrame("Frame");
targetCheckFrame:Hide();
targetCheckFrame:SetScript("OnUpdate", function() GroupHeal_TargetButtons_TargetCheckTimer(arg1) end);


function GroupHeal_TargetButtonsFrame_OnLoad()
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	local buttons = { this:GetChildren() };
	for _, button in buttons do
		if ( classSpells and classSpells[button.spellId] ) then
			targetButtons[button.spellId] = button;
		end
	end
	this.target = "";
end

function GroupHeal_TargetButtonsFrame_OnEvent( event )
	if ( event == "PLAYER_TARGET_CHANGED" ) then
		GroupHeal_TargetButtonsFrame_CheckTarget();
	
	elseif ( event == "PARTY_MEMBERS_CHANGED" ) then
		GroupHeal_TargetButtonsFrame_CheckTarget();
		--[[
		targetCheckFrame.elapsed = 0;
		targetCheckFrame:Show();
		--]]
	end
end

function GroupHeal_TargetButtons_TargetCheckTimer( elapsed )
	this.elapsed = this.elapsed + elapsed;
	if ( this.elapsed >= targetCheckWaitTime ) then
		this:Hide();
		GroupHeal_TargetButtonsFrame_CheckTarget();
	end
end


function GroupHeal_TargetButtonsFrame_CheckTarget()
	local targetFrame = GroupHeal_TargetButtonsFrame;
	currentTarget = targetFrame.target;
	if ( UnitIsUnit(currentTarget, "target") ) then
		return;
	
	elseif UnitExists("target") then
		for unit, _ in inRange do
			if ( UnitIsUnit(unit, "target") ) then
				for key, button in targetButtons do
					GroupHeal_SetHealButtonTarget( button, unit );
				end
				targetFrame.target = unit;
				targetFrame:Show();
				return;
			end
		end
	end
	--hide buttons otherwise
	targetFrame.target = "";
	targetFrame:Hide();
	for _, button in targetButtons do
		GroupHeal_SetHealButtonTarget( button, nil );
	end
end


-------------------------------------------------------------------------------
-- range check functions
-------------------------------------------------------------------------------
function GroupHeal_CheckRanges()
	--if we aren't in a party/raid then no range checking is required
	if not ( UnitExists("party1") or UnitInRaid("player") ) then
		return;
	end
	
	for unit, _ in inRange do
		if not ( "player" == key ) then
			inRange[unit] = GroupHeal_UnitInRange(unit);
		end
	end
end

-- true means definately in range
-- false means maybe in range
-- nil means definately not in range
function GroupHeal_UnitInRange( unit )
	-- this means that we are not even frilling close...
	-- don't bother going further
	if (not UnitIsVisible(unit)) then
		return false;
	end
	
	if ( UnitIsUnit(unit, "target") ) then
		local result = IsActionInRange(rangeSlot);
		if ( result == 1 ) then
			return 1;
		else
			return false;
		end
	end
	
	--more accurate code can go here, if I can ever figure out how to do it
	if ( CheckInteractDistance(unit, 4) ) then
		return 1;
	else
		return 0;
	end
	
	-- we don't know... return true just in case
	return true;

end

function GroupHeal_FindHealingActionSlot()
	GroupHeal_Tooltip:SetOwner(GroupHealFrame, "ANCHOR_NONE");
	local i = 0;
	for i = GroupHeal_START_SLOT, GroupHeal_END_SLOT do
		if (HasAction(i)) and (GetActionText(i) == nil) then
			GroupHeal_Tooltip:SetAction(i);
			local slotName = GroupHeal_TooltipTextLeft1:GetText();
			for k, v in classSpells do
				local spellName = v["name"];
				if (spellName == slotName) then
					return i;
				end
			end
		end
	end
	return 0;
end

-------------------------------------------------------------------------------
--Support non-standard Unit Frames
-------------------------------------------------------------------------------

local oldPerl_SetCompact = Perl_Party_Set_Compact;

function GroupHeal_SupportCustomUnitFrames()
	if IsAddOnLoaded("Perl") then
		--player
		PlayerButtonPosition.x = 1;
		PlayerButtonPosition.y = -1;
		PlayerButtonPosition.point = "TOPLEFT";
		PlayerButtonPosition.relativeTo = Perl_Player_Frame;
		PlayerButtonPosition.relativePoint = "BOTTOMLEFT";
		GroupHeal_SetUnitButtonParents("player", Perl_Player_Frame);
		
		--party
		GroupHeal_SetUnitButtonParents( "party1", Perl_party1 )
		GroupHeal_SetUnitButtonParents( "party2", Perl_party2 )
		GroupHeal_SetUnitButtonParents( "party3", Perl_party3 )
		GroupHeal_SetUnitButtonParents( "party4", Perl_party4 )
		for k, v in healButtons[1] do
			v:SetPoint("BOTTOMLEFT", getglobal(v:GetParent():GetName().."_NameFrame"), "BOTTOMRIGHT", 0, -2 );
		end
		
		--need to override this function
		Perl_Party_SetDebuffLoc_Old = Perl_Party_SetDebuffLoc;
		Perl_Party_SetDebuffLoc = function() 
			getglobal(this:GetName().."_BuffFrame_DeBuff1"):ClearAllPoints();
			if (Perl_Config.PartyDebuffsBelow==0) then
				if ((getglobal("Perl_Party_Pet"..this:GetID())):IsVisible()) then
					getglobal(this:GetName().."_BuffFrame_DeBuff1"):SetPoint("BOTTOMLEFT", ("Perl_Party_Pet"..this:GetID()), "BOTTOMRIGHT", 0, 8);
				else
					getglobal(this:GetName().."_BuffFrame_DeBuff1"):SetPoint("LEFT", ("Perl_party"..this:GetID().."_StatsFrame"), "RIGHT", 0, 0);
				end
			else
				getglobal(this:GetName().."_BuffFrame_DeBuff1"):SetPoint("TOPLEFT", ("Perl_party"..this:GetID().."_BuffFrame_Buff1"), "BOTTOMLEFT", 0, -2);
			end
		end;
	
	elseif IsAddOnLoaded("Nurfed_UnitFrames") then
		--player
		PlayerButtonPosition.x = 1;
		PlayerButtonPosition.y = -1;
		PlayerButtonPosition.point = "TOPLEFT";
		PlayerButtonPosition.relativeTo = Nurfed_player;
		PlayerButtonPosition.relativePoint = "BOTTOMLEFT";
		GroupHeal_SetUnitButtonParents("player", Nurfed_player);
		
		--party
		GroupHeal_SetUnitButtonParents( "party1", Nurfed_party1 )
		GroupHeal_SetUnitButtonParents( "party2", Nurfed_party2 )
		GroupHeal_SetUnitButtonParents( "party3", Nurfed_party3 )
		GroupHeal_SetUnitButtonParents( "party4", Nurfed_party4 )
		for k, v in healButtons[1] do
			v:SetPoint("TOPLEFT", getglobal(v:GetParent():GetName().."HealthBar"), "BOTTOMRIGHT", 5, 0 );
		end
		
		--target
		GroupHeal_TargetButtonsFrame:SetParent(Nurfed_target);
		GroupHeal_BigHealTarget:ClearAllPoints();
		GroupHeal_BigHealTarget:SetPoint("BOTTOMLEFT", Nurfed_target, "BOTTOMRIGHT", -2, 3);
	
	elseif ( IsAddOnLoaded("Perl_Player") or IsAddOnLoaded("Perl_Party") or IsAddOnLoaded("Perl_Target") ) then
		--player
		if IsAddOnLoaded("Perl_Player") then
			PlayerButtonPosition.x = 2;
			PlayerButtonPosition.y = 1;
			PlayerButtonPosition.point = "TOPLEFT";
			PlayerButtonPosition.relativeTo = Perl_Player_StatsFrame;
			PlayerButtonPosition.relativePoint = "BOTTOMLEFT";
			GroupHeal_SetUnitButtonParents("player", Perl_Player_Frame);
		end
		
		--party
		if IsAddOnLoaded("Perl_Party") then
			function Perl_Party_Set_Compact(newvalue)
				local returnValue = oldPerl_SetCompact(newvalue);
				
				if (Perl_Party_Config[_name].CompactMode == 0) then
					GroupHeal_SetUnitButtonParents( "party1", Perl_Party_MemberFrame1 )
					GroupHeal_SetUnitButtonParents( "party2", Perl_Party_MemberFrame2 )
					GroupHeal_SetUnitButtonParents( "party3", Perl_Party_MemberFrame3 )
					GroupHeal_SetUnitButtonParents( "party4", Perl_Party_MemberFrame4 )
					for k, v in healButtons[1] do
						v:SetPoint("BOTTOMLEFT", v:GetParent(), "BOTTOMRIGHT", -2, 3 );
					end
				else
					GroupHeal_SetUnitButtonParents( "party1", Perl_Party_MemberFrame1_StatsFrame )
					GroupHeal_SetUnitButtonParents( "party2", Perl_Party_MemberFrame2_StatsFrame )
					GroupHeal_SetUnitButtonParents( "party3", Perl_Party_MemberFrame3_StatsFrame )
					GroupHeal_SetUnitButtonParents( "party4", Perl_Party_MemberFrame4_StatsFrame )
					for k, v in healButtons[1] do
						v:SetPoint("TOPLEFT", v:GetParent(), "TOPRIGHT", -2, 3 );
					end
				end
				return returnValue;
			end
		end
		
		--target
		if IsAddOnLoaded("Perl_Target") then 
			GroupHeal_TargetButtonsFrame:SetParent(Perl_Target_Frame);
			GroupHeal_BigHealTarget:ClearAllPoints();
			GroupHeal_BigHealTarget:SetPoint("BOTTOMLEFT", Perl_Target_ClassNameFrame, "BOTTOMRIGHT", -2, 3);
		end
	
	elseif ( IsAddOnLoaded("Gypsy_UnitBars") ) then
		--player
		PlayerButtonPosition.x = 3;
		PlayerButtonPosition.y = -2;
		PlayerButtonPosition.point = "BOTTOMLEFT";
		PlayerButtonPosition.relativeTo = Gypsy_PlayerFrameExpBar;
		PlayerButtonPosition.relativePoint = "BOTTOMRIGHT";
		
		--party
		GroupHeal_SetUnitButtonParents( "party1", Gypsy_PartyFrame1 )
		GroupHeal_SetUnitButtonParents( "party2", Gypsy_PartyFrame2 )
		GroupHeal_SetUnitButtonParents( "party3", Gypsy_PartyFrame3 )
		GroupHeal_SetUnitButtonParents( "party4", Gypsy_PartyFrame4 )
		for k, v in healButtons[1] do
			v:SetPoint("BOTTOMLEFT", getglobal(v:GetParent():GetName()), "BOTTOMRIGHT", -8, 5 );
		end
		
		--target
	
	end
	
	GroupHeal_PositionPlayerButtons();
	GroupHeal_PositionButtons();
end

--sets the parent of all the buttons that target unit to frame
--also clear the relevent anchor points
function GroupHeal_SetUnitButtonParents( unit, frame )
	if unit == "player" then
		GroupHeal_HealSelf:ClearAllPoints();
		GroupHeal_HealSelf:SetParent(frame);
		GroupHeal_FastHealSelf:SetParent(frame);
		GroupHeal_OverTimeHealSelf:SetParent(frame);
		GroupHeal_ShieldSelf:SetParent(frame);
		
	elseif ( strsub(unit, 1, 5) == "party" ) then
		local n = strsub(unit, 6);
		local bigheal = getglobal("GroupHeal_HealParty"..n);
		local fastheal = getglobal("GroupHeal_FastHealParty"..n);
		local overtimeheal = getglobal("GroupHeal_OverTimeHealParty"..n);
		local shield = getglobal("GroupHeal_ShieldParty"..n);
		bigheal:ClearAllPoints();
		bigheal:SetParent(frame);
		fastheal:SetParent(frame);
		overtimeheal:SetParent(frame);
		shield:SetParent(frame);
	
	end
end

function GroupHeal_PositionCustomUnitFrames() 
	if IsAddOnLoaded("Perl") then
		for i = 1, 4 do
			local rightMostEdge = 0;
			for k, v in healButtons do
				if ( v["party"..i] and v["party"..i]:IsVisible() and v["party"..i]:GetRight() and rightMostEdge < v["party"..i]:GetRight() ) then
					rightMostEdge = v["party"..i]:GetRight();
				end
			end
			rightMostEdge = rightMostEdge - getglobal("Perl_party"..i.."_StatsFrame"):GetRight();
			if ( rightMostEdge < -2 ) then
				rightMostEdge = -2;
			end
			getglobal("Perl_Party_Pet"..i):SetPoint("BOTTOMLEFT", "Perl_party"..i.."_StatsFrame", "BOTTOMRIGHT", rightMostEdge, 0);
		end
	end
end
