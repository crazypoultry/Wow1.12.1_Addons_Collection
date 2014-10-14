--  ReactionBar 1.2.3 - 17th October 2006
--  Author:  Bastle <vF> Blackrock(US)
--  Website: http://www.vfclan.com

REACTIONBAR_VERSION = "1.2.3"
REACTIONBAR_NAME = "ReactionBar"
REACTIONBAR_NAME_PRINT = "|cff20ff20"..REACTIONBAR_NAME.." "..REACTIONBAR_VERSION.."|r"

REACTIONBAR_ENABLED = true

REACTIONBAR_TEXT_DUEL_STARTING = string.format(DUEL_COUNTDOWN, 3)

REACTIONBAR_MIN_BAR_ID = 1
REACTIONBAR_MAX_BAR_ID = 6
REACTIONBAR_SHAPESHIFT_BAR = 1
REACTIONBAR_DEFAULT_FRIENDLY_BAR = 2
REACTIONBAR_DEFAULT_ENEMY_BAR = 1
REACTIONBAR_DEFAULT_EXTRA_BAR = 3
REACTIONBAR_DEFAULT_RANGE_BAR = 4
REACTIONBAR_DEFAULT_CTRL_BAR = 3
REACTIONBAR_DEFAULT_SHIFT_BAR = 4
REACTIONBAR_DEFAULT_ALT_BAR = 2
REACTIONBAR_DEFAULT_MONITOR_DUEL = true

RB_FRIENDLY_INDEX = 0
RB_ENEMY_INDEX = 1
RB_NOTARGET_INDEX = 2
RB_EXTRA_INDEX = 3
RB_RANGE_INDEX = 4
RB_CTRL_INDEX = 5
RB_SHIFT_INDEX = 6
RB_ALT_INDEX = 7

local playerName
local realmName
local playerClass
local englishClass
local druidDisable
local extraDisable
local notTempDisabled
local duelTarget
local duelStarted
local barID
local initialised
local updateInterval = TOOLTIP_UPDATE_TIME
local MupdateInterval = TOOLTIP_UPDATE_TIME
local RBmonitorDuel

local RBisHunter
local RBisDruid
local RBreaction
local RBPages = {0,0,0,0,0,0,0,0}
local checkCTRL = false
local checkSHIFT = false
local checkALT = false
local temp_page
local metakeyDown

ReactionBarDetails = {
	name = REACTIONBAR_NAME,
	version = REACTIONBAR_VERSION,
	author = "Bastle",
	releaseDate = "October 17, 2006",
	email = "vfbastle@gmail.com",
	website = "http://www.vfclan.com",
	category = MYADDONS_CATEGORY_BARS
}

function ReactionBar_OnLoad()
	SLASH_REACTIONBAR1 = "/reactionbar"
	SLASH_REACTIONBAR2 = "/rb"
	SlashCmdList["REACTIONBAR"] = function( msg )
		ReactionBar_SlashCommandHandler( msg )
	end
		
	ReactionBarHelp = {}
	local help = ""
	for _,line in REACTIONBAR_HELP_PAGE do
		help = help.."\n"..line
	end
	ReactionBarHelp[1] = help
	this:RegisterEvent("ADDON_LOADED")
	this:RegisterEvent("VARIABLES_LOADED")
	
	this:RegisterEvent("UNIT_MODEL_CHANGED")
	this:RegisterEvent("UNIT_FACTION")
	this:RegisterEvent("UNIT_DYNAMIC_FLAGS")
	this:RegisterEvent("PLAYER_TARGET_CHANGED")
	
	this:RegisterEvent("CHAT_MSG_SYSTEM")
	this:RegisterEvent("DUEL_REQUESTED")
	this:RegisterEvent("DUEL_FINISHED")
end

function ReactionBar_SlashCommandHandler( msg )
	if (string.lower(msg) == REACTIONBAR_SLASH_ENABLE) then
		ReactionBar_Enable(true, 0)
	elseif (string.lower(msg) == REACTIONBAR_SLASH_DISABLE) then
		ReactionBar_Enable(false, 0)
	elseif (string.lower(msg) == REACTIONBAR_SLASH_STATUS) then
		ReactionBar_Status()
	elseif (string.lower(msg) == REACTIONBAR_SLASH_RESET) then
		ReactionBar_Reset()
	elseif (string.lower(msg) == REACTIONBAR_SLASH_MONITOR_DUEL) then
		ReactionBar_MonitorDuel()
		
	elseif (string.lower(msg) == REACTIONBAR_SLASH_FRIENDLY) then
		ReactionBar_SetBar(RB_FRIENDLY_INDEX, CURRENT_ACTIONBAR_PAGE, 1)
	elseif (string.lower(msg) == REACTIONBAR_SLASH_ENEMY) then
		ReactionBar_SetBar(RB_ENEMY_INDEX, CURRENT_ACTIONBAR_PAGE, 1)
	elseif (string.lower(msg) == REACTIONBAR_SLASH_EXTRA) then
		ReactionBar_SetBar(RB_EXTRA_INDEX, CURRENT_ACTIONBAR_PAGE, 1)
	elseif (string.lower(msg) == REACTIONBAR_SLASH_NOTARGET) then
		ReactionBar_SetBar(RB_NOTARGET_INDEX, CURRENT_ACTIONBAR_PAGE, 1)
	elseif (string.lower(msg) == REACTIONBAR_SLASH_RANGE) then
		ReactionBar_SetBar(RB_RANGE_INDEX, CURRENT_ACTIONBAR_PAGE, 1)
	elseif (string.lower(msg) == REACTIONBAR_SLASH_CTRLBAR) then
		ReactionBar_SetBar(RB_CTRL_INDEX, CURRENT_ACTIONBAR_PAGE, 1)
	elseif (string.lower(msg) == REACTIONBAR_SLASH_SHIFTBAR) then
		ReactionBar_SetBar(RB_SHIFT_INDEX, CURRENT_ACTIONBAR_PAGE, 1)
	elseif (string.lower(msg) == REACTIONBAR_SLASH_ALTBAR) then
		ReactionBar_SetBar(RB_ALT_INDEX, CURRENT_ACTIONBAR_PAGE, 1)
		
	elseif (string.lower(msg) == REACTIONBAR_SLASH_CTRLENABLE) then
		ReactionBar_CheckCTRL(nil, 1)
	elseif (string.lower(msg) == REACTIONBAR_SLASH_SHIFTENABLE) then
		ReactionBar_CheckSHIFT(nil, 1)
	elseif (string.lower(msg) == REACTIONBAR_SLASH_ALTENABLE) then
		ReactionBar_CheckALT(nil, 1)

	elseif (string.find(msg, REACTIONBAR_SLASH_FRIENDLY)) then
		ReactionBar_SetBar(RB_FRIENDLY_INDEX, string.sub(msg, string.len(REACTIONBAR_SLASH_FRIENDLY)+2), 1)
	elseif (string.find(msg, REACTIONBAR_SLASH_ENEMY)) then
		ReactionBar_SetBar(RB_ENEMY_INDEX, string.sub(msg, string.len(REACTIONBAR_SLASH_ENEMY)+2), 1)
	elseif (string.find(msg, REACTIONBAR_SLASH_NOTARGET)) then
		ReactionBar_SetBar(RB_NOTARGET_INDEX, string.sub(msg, string.len(REACTIONBAR_SLASH_NOTARGET)+2), 1)
	elseif (string.find(msg, REACTIONBAR_SLASH_EXTRA)) then
		ReactionBar_SetBar(RB_EXTRA_INDEX, string.sub(msg, string.len(REACTIONBAR_SLASH_EXTRA)+2), 1)
	elseif (string.find(msg, REACTIONBAR_SLASH_RANGE)) then
		ReactionBar_SetBar(RB_RANGE_INDEX, string.sub(msg, string.len(REACTIONBAR_SLASH_RANGE)+2), 1)
	elseif (string.find(msg, REACTIONBAR_SLASH_CTRLBAR)) then
		ReactionBar_SetBar(RB_CTRL_INDEX, string.sub(msg, string.len(REACTIONBAR_SLASH_CTRLBAR)+2), 1)
	elseif (string.find(msg, REACTIONBAR_SLASH_SHIFTBAR)) then
		ReactionBar_SetBar(RB_SHIFT_INDEX, string.sub(msg, string.len(REACTIONBAR_SLASH_SHIFTBAR)+2), 1)
	elseif (string.find(msg, REACTIONBAR_SLASH_ALTBAR)) then
		ReactionBar_SetBar(RB_ALT_INDEX, string.sub(msg, string.len(REACTIONBAR_SLASH_ALTBAR)+2), 1)
		
	elseif (string.lower(msg) == nil or string.lower(msg) == "" or string.lower(msg) == REACTIONBAR_SLASH_HELP) then
		table.foreach(REACTIONBAR_HELP_PAGE, function(k,v) DEFAULT_CHAT_FRAME:AddMessage(v) end)
	else
		DEFAULT_CHAT_FRAME:AddMessage(REACTIONBAR_NAME_PRINT.." "..REACTIONBAR_INVALID_SLASH)
	end
end

function ReactionBar_OnEvent(event)

	if (REACTIONBAR_ENABLED) then
		if ( event == "PLAYER_TARGET_CHANGED") then	
			if (notTempDisabled) then
				ReactionBar_CheckFaction()
			end
			return
		elseif ( event == "UNIT_FACTION" ) then
			if (notTempDisabled) then
				if ( arg1 == "target" or arg1 == "player" ) then ReactionBar_CheckFaction() end
			end
			return
		elseif ( event == "UNIT_DYNAMIC_FLAGS" and arg1 == "target" ) then 
			if (notTempDisabled) then
				ReactionBar_CheckFaction()
			end
			return
		end
	
		if (RBmonitorDuel) then
			if ( event == "CHAT_MSG_SYSTEM") then
				if (arg1 == ERR_DUEL_REQUESTED) then
					duelTarget = UnitName("target")
					return
				end
				if (arg1 == REACTIONBAR_TEXT_DUEL_STARTING and notTempDisabled) then
					duelStarted = true
					ReactionBar_CheckFaction()
					return
				end
			end
			if ( event == "DUEL_REQUESTED") then
				duelTarget = arg1
				return
			end
			if ( event == "DUEL_FINISHED") then
				duelStarted = false
				duelTarget = nil
				return
			end
		end
		
		if (event == "UNIT_MODEL_CHANGED" and RBisDruid and arg1 == "player") then
			ReactionBar_CheckShapeShift()
			return
		end
	end
	
	if (event == "VARIABLES_LOADED") then
		playerClass, englishClass = UnitClass("player")
		playerName = UnitName("player")
		realmName = GetCVar("realmName")
		ReactionBar_Initialise()
		return
	elseif (event == "ADDON_LOADED") then
		if (arg1 == "ReactionBar" and myAddOnsFrame_Register) then				
			myAddOnsFrame_Register(ReactionBarDetails, ReactionBarHelp)
		end
		return
	end
end

function ReactionBar_Reset()
	for num, class in REACTIONBAR_RESTRICT do	
		if (class == englishClass ) then
			ReactionBarOptions[realmName][playerName].enabled = false
		end
	end
	ReactionBarOptions[realmName][playerName].friendlyBar = REACTIONBAR_DEFAULT_FRIENDLY_BAR
	ReactionBarOptions[realmName][playerName].enemyBar = REACTIONBAR_DEFAULT_ENEMY_BAR
	ReactionBarOptions[realmName][playerName].extraBar = REACTIONBAR_DEFAULT_EXTRA_BAR
	ReactionBarOptions[realmName][playerName].rangeBar = REACTIONBAR_DEFAULT_RANGE_BAR
	ReactionBarOptions[realmName][playerName].noTargetBar = REACTIONBAR_DEFAULT_FRIENDLY_BAR
	ReactionBarOptions[realmName][playerName].CTRLBar = REACTIONBAR_DEFAULT_CTRL_BAR
	ReactionBarOptions[realmName][playerName].SHIFTBar = REACTIONBAR_DEFAULT_SHIFT_BAR
	ReactionBarOptions[realmName][playerName].ALTBar = REACTIONBAR_DEFAULT_ALT_BAR
	ReactionBarOptions[realmName][playerName].monitorDuel = REACTIONBAR_DEFAULT_MONITOR_DUEL
		
	ReactionBarOptions[realmName][playerName].checkCTRL = false
	ReactionBarOptions[realmName][playerName].checkSHIFT = false
	ReactionBarOptions[realmName][playerName].checkALT = false

	ReactionBar_SetOptions()
	DEFAULT_CHAT_FRAME:AddMessage(REACTIONBAR_NAME_PRINT.." "..REACTIONBAR_RESET)
	ReactionBar_Status()	
end

function ReactionBar_Initialise()
	if (ReactionBarOptions == nil) then
		ReactionBarOptions = {}
	end
	if (ReactionBarOptions[realmName] == nil) then
		ReactionBarOptions[realmName] = {}
	end
	if (ReactionBarOptions[realmName][playerName] == nil) then
		ReactionBarOptions[realmName][playerName] = {}
		ReactionBarOptions[realmName][playerName].enabled = true
		for num, class in REACTIONBAR_RESTRICT do	
			if (class == englishClass ) then
				ReactionBarOptions[realmName][playerName].enabled = false
			end
		end
		ReactionBarOptions[realmName][playerName].friendlyBar = REACTIONBAR_DEFAULT_FRIENDLY_BAR
		ReactionBarOptions[realmName][playerName].enemyBar = REACTIONBAR_DEFAULT_ENEMY_BAR
		ReactionBarOptions[realmName][playerName].extraBar = REACTIONBAR_DEFAULT_EXTRA_BAR
		ReactionBarOptions[realmName][playerName].rangeBar = REACTIONBAR_DEFAULT_RANGE_BAR
		ReactionBarOptions[realmName][playerName].noTargetBar = REACTIONBAR_DEFAULT_FRIENDLY_BAR
		ReactionBarOptions[realmName][playerName].monitorDuel = REACTIONBAR_DEFAULT_MONITOR_DUEL
	end
	
	if (ReactionBarOptions[realmName][playerName].extraBar == nil) then
		local set = 0 local id = REACTIONBAR_MIN_BAR_ID
		while (set == 0 and id <= REACTIONBAR_MAX_BAR_ID) do
			if (id == ReactionBarOptions[realmName][playerName].enemyBar or 
			   id == ReactionBarOptions[realmName][playerName].friendlyBar) then
				id = id+1
			else
				ReactionBarOptions[realmName][playerName].extraBar = id
				set = 1
			end
		end
	end
	
	if (ReactionBarOptions[realmName][playerName].rangeBar == nil) then
		local set = 0 local id = REACTIONBAR_MIN_BAR_ID
		while (set == 0 and id <= REACTIONBAR_MAX_BAR_ID) do
			if (id == ReactionBarOptions[realmName][playerName].enemyBar or 
			   id == ReactionBarOptions[realmName][playerName].friendlyBar or 
			   id == ReactionBarOptions[realmName][playerName].extraBar) then
				id = id+1
			else
				ReactionBarOptions[realmName][playerName].rangeBar = id
				set = 1
			end
		end
	end
	
	if (ReactionBarOptions[realmName][playerName].noTargetBar == nil) then
		ReactionBarOptions[realmName][playerName].noTargetBar = ReactionBarOptions[realmName][playerName].friendlyBar
	end
	if (ReactionBarOptions[realmName][playerName].CTRLBar == nil) then
		ReactionBarOptions[realmName][playerName].CTRLBar = REACTIONBAR_DEFAULT_CTRL_BAR
	end
	if (ReactionBarOptions[realmName][playerName].SHIFTBar == nil) then
		ReactionBarOptions[realmName][playerName].SHIFTBar = REACTIONBAR_DEFAULT_SHIFT_BAR
	end
	if (ReactionBarOptions[realmName][playerName].ALTBar == nil) then
		ReactionBarOptions[realmName][playerName].ALTBar = REACTIONBAR_DEFAULT_ALT_BAR
	end
	if (ReactionBarOptions[realmName][playerName].checkCTRL == nil) then
		ReactionBarOptions[realmName][playerName].checkCTRL = false
	end
	if (ReactionBarOptions[realmName][playerName].checkSHIFT == nil) then
		ReactionBarOptions[realmName][playerName].checkSHIFT = false
	end
	if (ReactionBarOptions[realmName][playerName].checkALT == nil) then
		ReactionBarOptions[realmName][playerName].checkALT = false
	end
	
	if (englishClass == "HUNTER") then
		RBisHunter = true
	else
		RBisHunter = false
	end
	if (englishClass == "DRUID") then
		RBisDruid = true
	else
		RBisDruid = false
	end
		
	duelStarted = false
	ReactionBar_SetOptions()
	initialised = true
end

function ReactionBar_SetOptions()
	ReactionBar_SetBar(RB_FRIENDLY_INDEX, ReactionBarOptions[realmName][playerName].friendlyBar, 0)
	ReactionBar_SetBar(RB_ENEMY_INDEX, ReactionBarOptions[realmName][playerName].enemyBar, 0)
	ReactionBar_SetBar(RB_EXTRA_INDEX, ReactionBarOptions[realmName][playerName].extraBar, 0)
	ReactionBar_SetBar(RB_RANGE_INDEX, ReactionBarOptions[realmName][playerName].rangeBar, 0)
	ReactionBar_SetBar(RB_NOTARGET_INDEX, ReactionBarOptions[realmName][playerName].noTargetBar, 0)
	ReactionBar_SetBar(RB_SHIFT_INDEX, ReactionBarOptions[realmName][playerName].SHIFTBar, 0)
	ReactionBar_SetBar(RB_CTRL_INDEX, ReactionBarOptions[realmName][playerName].CTRLBar, 0)
	ReactionBar_SetBar(RB_ALT_INDEX, ReactionBarOptions[realmName][playerName].ALTBar, 0)
	ReactionBar_MonitorDuel(ReactionBarOptions[realmName][playerName].monitorDuel, 0)
	ReactionBar_CheckCTRL(ReactionBarOptions[realmName][playerName].checkCTRL, 0)
	ReactionBar_CheckSHIFT(ReactionBarOptions[realmName][playerName].checkSHIFT, 0)
	ReactionBar_CheckALT(ReactionBarOptions[realmName][playerName].checkALT, 0)

	ReactionBar_Enable(ReactionBarOptions[realmName][playerName].enabled, 0)
	if (REACTIONBAR_ENABLED) then
		ReactionBar_CheckShapeShift()
	end
end

function ReactionBar_Status()	
	DEFAULT_CHAT_FRAME:AddMessage(REACTIONBAR_NAME_PRINT.." "..REACTIONBAR_STATUS)
	if (REACTIONBAR_ENABLED) then
		DEFAULT_CHAT_FRAME:AddMessage(" - "..REACTIONBAR_TEXT_ENABLED)
	else
		DEFAULT_CHAT_FRAME:AddMessage(" - "..REACTIONBAR_DISABLED)
	end
	if (RBmonitorDuel) then
		DEFAULT_CHAT_FRAME:AddMessage(" - "..REACTIONBAR_MONITOR_DUEL.." "..REACTIONBAR_TEXT_ENABLED)
	else
		DEFAULT_CHAT_FRAME:AddMessage(" - "..REACTIONBAR_MONITOR_DUEL.." "..REACTIONBAR_DISABLED)
	end
	DEFAULT_CHAT_FRAME:AddMessage(" - "..REACTIONBAR_FRIENDLYBAR.." "..ReactionBarOptions[realmName][playerName].friendlyBar)
	DEFAULT_CHAT_FRAME:AddMessage(" - "..REACTIONBAR_ENEMYBAR.." "..ReactionBarOptions[realmName][playerName].enemyBar)
	DEFAULT_CHAT_FRAME:AddMessage(" - "..REACTIONBAR_EXTRABAR.." "..ReactionBarOptions[realmName][playerName].extraBar)
	DEFAULT_CHAT_FRAME:AddMessage(" - "..REACTIONBAR_NOTARGETBAR.." "..ReactionBarOptions[realmName][playerName].noTargetBar)
	if (RBisHunter) then
		DEFAULT_CHAT_FRAME:AddMessage(" - "..REACTIONBAR_RANGEBAR.." "..ReactionBarOptions[realmName][playerName].rangeBar)
	end
	if (checkCTRL) then
		DEFAULT_CHAT_FRAME:AddMessage(" - CTRL enabled id = "..ReactionBarOptions[realmName][playerName].CTRLBar)
	else
		DEFAULT_CHAT_FRAME:AddMessage(" - CTRL disabled id = "..ReactionBarOptions[realmName][playerName].CTRLBar)
	end
	if (checkSHIFT) then
		DEFAULT_CHAT_FRAME:AddMessage(" - SHIFT enabled id = "..ReactionBarOptions[realmName][playerName].SHIFTBar)
	else
		DEFAULT_CHAT_FRAME:AddMessage(" - SHIFT disabled id = "..ReactionBarOptions[realmName][playerName].SHIFTBar)
	end
	if (checkALT) then
		DEFAULT_CHAT_FRAME:AddMessage(" - ALT enabled id = "..ReactionBarOptions[realmName][playerName].ALTBar)
	else
		DEFAULT_CHAT_FRAME:AddMessage(" - ALT disabled id = "..ReactionBarOptions[realmName][playerName].ALTBar)
	end
end

function ReactionBar_CheckShapeShift()
	local active = 0 local i = 1 local icon, name
	while (active == 0 and i <= GetNumShapeshiftForms()) do
		icon, name, active = GetShapeshiftFormInfo(i)
		if (active == nil) then active = 0 end
		i = i+1
	end
	if (active == 1) then ReactionBar_Enable(false, 1)
	else ReactionBar_Enable(true, 1) end
end

function ReactionBar_CheckFaction(hunterUpdate)
	temp_page = CURRENT_ACTIONBAR_PAGE
	if (ReactionBar_IsEnemy()) then
		temp_page = RBPages[RB_ENEMY_INDEX]
		if (RBisHunter) then
			if (not CheckInteractDistance("target", 1)) then
				temp_page = RBPages[RB_RANGE_INDEX]
			end
			if (not hunterUpdate) then
				ReactionBarHunterFrame:Show()
			end
		end
	elseif (not hunterUpdate) then
	  if ( UnitExists("target") and not UnitIsDead("target") ) then
			temp_page = RBPages[RB_FRIENDLY_INDEX]
		else			
			temp_page = RBPages[RB_NOTARGET_INDEX]
		end
		ReactionBarHunterFrame:Hide()
	end
	ReactionBar_SetActionPage(temp_page)
end

function ReactionBar_ButtonUp(id)
	if (notTempDisabled and REACTIONBAR_ENABLED) then
		local button, actionPrefix
		if (GBars_State) then actionPrefix = "GActionButton"
		else actionPrefix = "ActionButton" end
		button = getglobal(actionPrefix..id)
		local buttonID = button:GetID() + barID
		if (button:GetButtonState() == "PUSHED") then
			button:SetButtonState("NORMAL")
			if (MacroFrame_SaveMacro) then MacroFrame_SaveMacro() end
			UseAction(buttonID, 0, 1)
			if (IsCurrentAction(buttonID)) then
				button:SetChecked(1)
			else
				button:SetChecked(0)
			end
		end
	else
		ActionButtonUp(id, 1)
	end
end

function ReactionBar_Enable(enable, temp)
	if (enable) then
		druidDisable = false
		extraDisable = false
		notTempDisabled = true
		duelTarget = nil
		metakeyDown = false
		ReactionBarOptions[realmName][playerName].enabled = true
		REACTIONBAR_ENABLED = true
		if (RBisHunter) then
			ReactionBarHunterFrame:Show()
		end
		if (checkCTRL or checkALT or checkSHIFT) then
			ReactionBarMetaFrame:Show()
		end
		if (notTempDisabled) then
			ReactionBar_CheckFaction()
		end
		if (temp == 0) then
			DEFAULT_CHAT_FRAME:AddMessage(REACTIONBAR_NAME_PRINT.." "..REACTIONBAR_TEXT_ENABLED)
		end
	else
		if (temp == 1) then
			druidDisable = true
			notTempDisabled = false
			ReactionBar_SetActionPage(REACTIONBAR_SHAPESHIFT_BAR)
		else
			ReactionBarOptions[realmName][playerName].enabled = false
			REACTIONBAR_ENABLED = false
			ReactionBarHunterFrame:Hide()
			ReactionBarMetaFrame:Hide()
			DEFAULT_CHAT_FRAME:AddMessage(REACTIONBAR_NAME_PRINT.." "..REACTIONBAR_DISABLED)
		end
	end
end

function ReactionBar_ToggleExtraPage(show)
	if (REACTIONBAR_ENABLED) then
		if (show == 1) then
			extraDisable = true			
			notTempDisabled = false
			ReactionBar_SetActionPage(RBPages[RB_EXTRA_INDEX])
		else
			extraDisable = false
			if (druidDisable) then
				if (not metakeyDown) then
					ReactionBar_SetActionPage(REACTIONBAR_SHAPESHIFT_BAR)
				end
			else
				ReactionBar_CheckFaction()
				notTempDisabled = true
			end
		end
	end
end

function ReactionBar_CheckCTRL(enable, verbose)
	if (enable ~= nil) then
		checkCTRL = enable
	else
		if (checkCTRL) then
			checkCTRL = false
		else
			checkCTRL = true
		end
	end
	ReactionBarOptions[realmName][playerName].checkCTRL = enable
	if (checkCTRL) then
		ReactionBarMetaFrame:Show()
	elseif (not checkSHIFT and not checkALT) then
		ReactionBarMetaFrame:Hide()
	end
	if (verbose == 1) then
		if (checkCTRL) then
			DEFAULT_CHAT_FRAME:AddMessage(REACTIONBAR_NAME_PRINT.." CTRL switching enabled")
		else
			DEFAULT_CHAT_FRAME:AddMessage(REACTIONBAR_NAME_PRINT.." CTRL switching disabled")
		end
	end
end

function ReactionBar_CheckSHIFT(enable, verbose)
	if (enable ~= nil) then
		checkSHIFT = enable
	else
		if (checkSHIFT) then
			checkSHIFT = false
		else
			checkSHIFT = true
		end
	end
	ReactionBarOptions[realmName][playerName].checkSHIFT = enable
	if (checkSHIFT) then
		ReactionBarMetaFrame:Show()
	elseif (not checkCTRL and not checkALT) then
		ReactionBarMetaFrame:Hide()
	end
	if (verbose == 1) then
		if (checkSHIFT) then
			DEFAULT_CHAT_FRAME:AddMessage(REACTIONBAR_NAME_PRINT.." SHIFT switching enabled")
		else
			DEFAULT_CHAT_FRAME:AddMessage(REACTIONBAR_NAME_PRINT.." SHIFT switching disabled")
		end
	end
end

function ReactionBar_CheckALT(enable, verbose)
	if (enable ~= nil) then
		checkALT = enable
	else
		if (checkALT) then
			checkALT = false
		else
			checkALT = true
		end
	end
	ReactionBarOptions[realmName][playerName].checkALT = enable
	if (checkALT) then
		ReactionBarMetaFrame:Show()
	elseif (not checkSHIFT and not checkCTRL) then
		ReactionBarMetaFrame:Hide()
	end
	if (verbose == 1) then
		if (checkALT) then
			DEFAULT_CHAT_FRAME:AddMessage(REACTIONBAR_NAME_PRINT.." ALT switching enabled")
		else
			DEFAULT_CHAT_FRAME:AddMessage(REACTIONBAR_NAME_PRINT.." ALT switching disabled")
		end
	end
end

function ReactionBar_MonitorDuel(enable)
	if (enable == nil) then
		if (RBmonitorDuel) then
			enable = false
		else
			enable = true
		end
	end
	if (enable) then
		ReactionBarOptions[realmName][playerName].monitorDuel = true
		RBmonitorDuel = true
		DEFAULT_CHAT_FRAME:AddMessage(REACTIONBAR_NAME_PRINT.." "..REACTIONBAR_MONITOR_DUEL.." "..REACTIONBAR_TEXT_ENABLED)
	else
		ReactionBarOptions[realmName][playerName].monitorDuel = false
		RBmonitorDuel = false
		DEFAULT_CHAT_FRAME:AddMessage(REACTIONBAR_NAME_PRINT.." "..REACTIONBAR_MONITOR_DUEL.." "..REACTIONBAR_DISABLED)
	end
end

function ReactionBar_SetBar(type, id, verbose)
	id = tonumber(id)
	if (id == nil) then
		DEFAULT_CHAT_FRAME:AddMessage(REACTIONBAR_NAME_PRINT.." "..REACTIONBAR_NIL)
		return
	end
	
	if (id >= REACTIONBAR_MIN_BAR_ID and id <= REACTIONBAR_MAX_BAR_ID) then	
		if (type == RB_FRIENDLY_INDEX) then
			ReactionBarOptions[realmName][playerName].friendlyBar = id
			barID = (ReactionBarOptions[realmName][playerName].friendlyBar - 1) * NUM_ACTIONBAR_BUTTONS
		elseif( type == RB_ENEMY_INDEX) then
			ReactionBarOptions[realmName][playerName].enemyBar = id
		elseif (type == RB_NOTARGET_INDEX) then
			ReactionBarOptions[realmName][playerName].noTargetBar = id
		elseif (type == RB_EXTRA_INDEX) then
			ReactionBarOptions[realmName][playerName].extraBar = id
		elseif (type == RB_RANGE_INDEX) then
			ReactionBarOptions[realmName][playerName].rangeBar = id
		elseif (type == RB_CTRL_INDEX) then
			ReactionBarOptions[realmName][playerName].CTRLBar = id
		elseif (type == RB_SHIFT_INDEX) then
			ReactionBarOptions[realmName][playerName].SHIFTBar = id
		elseif (type == RB_ALT_INDEX) then
			ReactionBarOptions[realmName][playerName].ALTBar = id
		end
		RBPages[type] = id
		if (verbose == 1) then
			DEFAULT_CHAT_FRAME:AddMessage(REACTIONBAR_NAME_PRINT.." "..REACTIONBAR_PAGE_TEXT[type+1].." "..id)
		end
	end
	if (REACTIONBAR_ENABLED and notTempDisabled) then
		ReactionBar_CheckFaction()
	end
end

function ReactionBar_SetActionPage(page)
	if (CURRENT_ACTIONBAR_PAGE ~= page) then
		CURRENT_ACTIONBAR_PAGE = page
		ChangeActionBarPage()
	end
end

function ReactionBar_HunterOnUpdate(elapsed)
	if not initialised then
		return
	end

	updateInterval = updateInterval - elapsed
	if (updateInterval > 0) then
		return
	end
	updateInterval = 0.1

	if (notTempDisabled) then
		ReactionBar_CheckFaction(true)
	end
end

function ReactionBar_MetaOnUpdate(elapsed)
	if not initialised then
		return
	end

	MupdateInterval = MupdateInterval - elapsed
	if (MupdateInterval > 0) then
		return
	end
	MupdateInterval = 0.1

  if (checkCTRL and IsControlKeyDown()) then
  	ReactionBar_SetActionPage(RBPages[RB_CTRL_INDEX])
  	metakeyDown = true
  	notTempDisabled = false
  elseif (checkSHIFT and IsShiftKeyDown()) then 
  	ReactionBar_SetActionPage(RBPages[RB_SHIFT_INDEX])
  	metakeyDown = true
  	notTempDisabled = false
  elseif (checkALT and IsAltKeyDown()) then
  	ReactionBar_SetActionPage(RBPages[RB_ALT_INDEX])
  	metakeyDown = true
  	notTempDisabled = false
  elseif (metakeyDown) then
  	metakeyDown = false
  	if (not druidDisable and not extraDisable) then
  		notTempDisabled = true
  		ReactionBar_CheckFaction()
  	end
  	if (druidDisable) then
  		ReactionBar_SetActionPage(REACTIONBAR_SHAPESHIFT_BAR)
  	end
  	if (extraDisable) then
  		ReactionBar_SetActionPage(RBPages[RB_EXTRA_INDEX])
  	end
  end
end

function ReactionBar_IsEnemy()
	if (not UnitIsDead("target")) then
		if (UnitCanAttack("player", "target") or (duelStarted and duelTarget == UnitName("target"))) then
			return true
		end
	end
	return false
end