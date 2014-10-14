--
--	AnkhCooldownTimer
--	v1.7.0
--
--	Originally by Starforce of Shattered Hands (EU)
--	starforce@playmate.se
--
--	Updated by Phanx of Blackrock / Emerald Dream (US)
--	phanx1337@gmail.com
--		
--	Gives shamans a timer for their Reincarnation ability
--	
--------------------------------------------------------------------------------------------------
-- GLOBALS
--------------------------------------------------------------------------------------------------

AnkhCT_Userdata = nil			-- persisted config data
AnkhCT_Config = nil				-- persisted character data
AnkhCT_TalentCooldown = 0
AnkhCT_PlayerName = nil
AnkhCT_CurrentServer = nil
AnkhCT_AddonEnabled = 1
AnkhCT_DebugLevel = 1
AnkhCT_TitanFound = 0
AnkhCT_TimerUpdate = nil
AnkhCT_ReincarnationTime = nil

AnkhCT_TESTINTERVAL = 5
AnkhCT_TIMERINTERVAL = 0.50
AnkhCT_VERSION = "1.7.0"
AnkhCT_TITANID = "AnkhCT"
AnkhCT_LOADED = 0

local AnkhCT_BagTooltip_Hook = nil
local AnkhCT_AllInOneLoot_Hook = nil

--------------------------------------------------------------------------------------------------
-- LOAD and INIT functions
--------------------------------------------------------------------------------------------------
function AnkhCT_OnLoad()
		
	if (AnkhCT_LOADED == 1) then
		return
	end
		
	AnkhCT_RegEvents()
	
	SlashCmdList["AnkhCTCOMMAND"] = AnkhCT_ChatCommandHandler
	SLASH_AnkhCTCOMMAND1 = "/act"
	SLASH_AnkhCTCOMMAND2 = "/AnkhCT"

	-- make sure we have the Print() function in case cosmos isn't installed
	if (not Print) then
		setglobal("Print", function(msg, r, g, b, frame, id)
			if (not r) then r = 1.0 end
			if (not g) then g = 1.0 end
			if (not b) then b = 1.0 end
			if (not frame) then frame = DEFAULT_CHAT_FRAME end
			if (frame) then
				if (not id) then
					frame:AddMessage(msg,r,g,b)
				else
					frame:AddMessage(msg,r,g,b,id)
				end
			end
		end)
	end

	AnkhCT_LOADED = 1
end

--------------------------------------------------------------------------------------------------
-- FUNCTION HOOK FOR ALL IN ONE INVENTORY, ADDS COOLDOWN TO THE TOOLTIP
--------------------------------------------------------------------------------------------------

function AnkhCT_AllInOne_Tooltip()
	
	-- Call the original function first
	AnkhCT_AllInOneLoot_Hook()


	local bag, slot = AllInOneInventory_GetIdAsBagSlot(this:GetID())

	local name = AnkhCT_NameFromLink(GetContainerItemLink(bag, slot))

	if( name ) then

		if ( name == ANKHCT_LOCAL_ANKH ) then
			
			this.updateTooltip = 1
			local toolCool = "Cooldown: " .. date("%M:%S ", AnkhCT_GetAnkhCooldown())

			if( AnkhCT_GetAnkhCooldown() > 0 ) then
				GameTooltip:AddLine(toolCool, 1, 0, 0)
			else
				GameTooltip:AddLine(toolCool, 0, 1, 0)
			end 

			GameTooltip:Show()
		end 
	end
end 

--------------------------------------------------------------------------------------------------
-- FUNCTION HOOK FOR BAGS, ADDS COOLDOWN TO THE TOOLTIP
--------------------------------------------------------------------------------------------------

function AnkhCT_Tooltip()
	
	AnkhCT_BagTooltip_Hook()

	local frameID = this:GetParent():GetID()
	local buttonID = this:GetID()
	local link = GetContainerItemLink(frameID, buttonID)
	local name = AnkhCT_NameFromLink(link)
	
	if( name ) then

		if ( name == ANKHCT_LOCAL_ANKH ) then
			local toolCool = "Cooldown: " .. date("%M:%S ", AnkhCT_GetAnkhCooldown())

			if( AnkhCT_GetAnkhCooldown() > 0 ) then
				GameTooltip:AddLine(toolCool, 1, 0, 0)
			else
				GameTooltip:AddLine(toolCool, 0, 1, 0)
			end 

			GameTooltip:Show()
		end 
	end
end


--------------------------------------------------------------------------------------------------
-- CHECK COOLDOWN TIME FOR REINCARNATE TALENT
--------------------------------------------------------------------------------------------------

function AnkhCT_UpdateTalentCooldown()

	-- scan for talent points in Improved Reincarnation
	local talentPoints = 0
	for talent = 1, GetNumTalentTabs(), 1 do
		for talentIdx  = 1, GetNumTalents(talent), 1 do
			nameTalent, icon, iconx, icony, currRank, maxRank = GetTalentInfo(talent, talentIdx)
			if ( (nameTalent) and (nameTalent == "Improved Reincarnation") ) then
				talentPoints = currRank
				break
			end
		end
	end

	-- scan for Totem of Rebirth relic
	local inRanged = GetInventoryItemLink("player", GetInventorySlotInfo("RangedSlot"))
	if ( inRanged ) then
		local _, _, iID = strfind(inRanged, "(%d+):")
		local iName, iLink, iQuality, iLevel, iType, iSubType, iCount = GetItemInfo(iID)
		if (iName == ANKHCT_LOCAL_TOTEM_OF_REBIRTH) then
			hasRelic = 1
		else
			hasRelic = 0
		end
	else
		hasRelic = 0
	end

	-- calculate cooldown
	AnkhCT_TalentCooldown = 3600 - (600 * talentPoints) - (600 * hasRelic)

end


--------------------------------------------------------------------------------------------------
-- REGISTER/UNREGISTER EVENTS
--------------------------------------------------------------------------------------------------

function AnkhCT_RegEvents()
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("ON_UPDATE")
	this:RegisterEvent("ON_EVENT")
    
    -- events for PLAYERNAME
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("UNIT_NAME_UPDATE")
	
    -- hook events for ANKH change/detection    
	this:RegisterEvent("BAG_UPDATE")
	this:RegisterEvent("UNIT_INVENTORY_CHANGED")

    -- ADD EVENTS FOR TALENT CHANGE 
	this:RegisterEvent("SPELLS_CHANGED")
	this:RegisterEvent("LEARNED_SPELL_IN_TAB")
    
    -- EVENTS FOR DEAD/ALIVE.
    this:RegisterEvent("PLAYER_ALIVE")
	this:RegisterEvent("PLAYER_DEAD")
end

function AnkhCT_UnRegEvents()
	this:UnregisterEvent("VARIABLES_LOADED")
	this:UnregisterEvent("ON_UPDATE")
	this:UnregisterEvent("ON_EVENT")
    
    -- events for NAME
	this:UnregisterEvent("PLAYER_ENTERING_WORLD")
	this:UnregisterEvent("UNIT_NAME_UPDATE")
				
    -- hook events for ANKH change/detection    
	this:UnregisterEvent("BAG_UPDATE")
	this:UnregisterEvent("UNIT_INVENTORY_CHANGED")

    -- ADD EVENTS FOR TALENT CHANGE 
	this:UnregisterEvent("SPELLS_CHANGED")
	this:UnregisterEvent("LEARNED_SPELL_IN_TAB")
    
    -- EVENTS FOR DEAD/ALIVE. Is this all of em?
	this:UnregisterEvent("PLAYER_ALIVE")
	this:UnregisterEvent("PLAYER_DEAD")
end


--------------------------------------------------------------------------------------------------
-- INITIALIZE VARIABLES
--------------------------------------------------------------------------------------------------

function AnkhCT_InitializeVariables()

	AnkhCT_CurrentServer = GetCVar("realmName")
	AnkhCT_PlayerName = UnitName("player")

	if (not AnkhCT_CurrentServer) then
		return
	elseif (not AnkhCT_PlayerName) then
		return
	elseif (AnkhCT_PlayerName == "Unknown Entity") then
		AnkhCT_PlayerName = nil
		return
	end
	
	-- Config vars (persistent)
	if (not AnkhCT_Config) then
		AnkhCT_Config = {}
	end
	if (not AnkhCT_Config.Enabled) then
		AnkhCT_Config.Enabled = 1
	end
	if (not AnkhCT_Config.Debug) then
		AnkhCT_Config.Debug = 1
	end
	
	-- Userdata vars (persistent)		
	if (not AnkhCT_Userdata) then
		AnkhCT_Userdata = {}
	end
	
	-- PER SERVER DATA
	if (not AnkhCT_Userdata[AnkhCT_CurrentServer]) then
		AnkhCT_Userdata[AnkhCT_CurrentServer] = {}
	end
	
	-- PER CHAR DATA
	if (not AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName]) then
		AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName] = {}
	end
	
	-- check and init the values
	if (not AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].LastUsed) then
		AnkhCT_SetLastUsed(0)
	end
	if (not AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Enabled) then
		AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Enabled = 1
	end
	if (not AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Gui) then
		AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Gui = 1
	end	
	if (not AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Ankhs) then
		AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Ankhs = 0
	end
	if (not AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Alive) then
		AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Alive = 1
	end
	if (not AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Tooltip) then
		AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Tooltip = 0
	end
	
	-- get alive/dead status
	AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Alive = AnkhCT_IsAlive()

	-- Make sure this is a shaman playing, otherwise disable the addon
	if (UnitClass("player") ~= ANKHCT_LOCAL_SHAMAN) then
		AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Enabled = 0
		AnkhCT_Frame:Hide()
		AnkhCT_UnRegEvents()
		return
	end

	-- get num ankhs
	AnkhCT_UpdateAnkhs()

	-- update max cooldown time		
	AnkhCT_UpdateTalentCooldown()

	-- Hook the tooltip functions
	if(AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Tooltip == 1) then
		
		AnkhCT_Hook_Bag(1)
		AnkhCT_Hook_AllInOneInv(1)
	end

end


--------------------------------------------------------------------------------------------------
-- HOOKS THE FUNCTION 'ContainerFrameItemButton_OnEnter' 
--------------------------------------------------------------------------------------------------

function AnkhCT_Hook_Bag(bool)

	if (bool == 1 and AnkhCT_BagTooltip_Hook == nil) then
		AnkhCT_BagTooltip_Hook = ContainerFrameItemButton_OnEnter
		ContainerFrameItemButton_OnEnter = AnkhCT_Tooltip	
	end
	
	if ( bool == 0 and AnkhCT_BagTooltip_Hook ~= nil ) then
		ContainerFrameItemButton_OnEnter = AnkhCT_BagTooltip_Hook 
		AnkhCT_BagTooltip_Hook = nil
	end
end 



--------------------------------------------------------------------------------------------------
-- HOOKS THE FUNCTION 'AllInOneInventoryFrameItemButton_OnEnter' 
--------------------------------------------------------------------------------------------------

function AnkhCT_Hook_AllInOneInv(bool)

	if (bool == 1 and AnkhCT_AllInOneLoot_Hook == nil) then
		
		AnkhCT_AllInOneLoot_Hook = AllInOneInventoryFrameItemButton_OnEnter
		AllInOneInventoryFrameItemButton_OnEnter = AnkhCT_AllInOne_Tooltip		
	end
	
	if ( bool == 0 and AnkhCT_AllInOneLoot_Hook ~= nil ) then
		
		AllInOneInventoryFrameItemButton_OnEnter = AnkhCT_AllInOneLoot_Hook
		AnkhCT_AllInOneLoot_Hook = nil
	end
end 


--------------------------------------------------------------------------------------------------
-- COUNT THE NUMBER OF ANHKS IN THE PLAYER'S BAGS
--------------------------------------------------------------------------------------------------


function AnkhCT_GetAnkhs()

	local ankhs = 0
	for bag = 4, 0, -1 do
		
		local size = GetContainerNumSlots(bag)
		
		if (size > 0) then
			for slot=1, size, 1 do
				local texture, itemCount = GetContainerItemInfo(bag, slot)
				
				if (itemCount) then
					local itemName = AnkhCT_NameFromLink(GetContainerItemLink(bag, slot))
                    			
                    			-- if the item has a name
					if  ((itemName) and (itemName ~= "")) then
						
						-- if the item is an ankh, increase the count
						if (itemName == ANKHCT_LOCAL_ANKH) then
							ankhs  = ankhs + itemCount
						end
					end
				end
			end            
		end
	end	
	
	return ankhs
end

function AnkhCT_UpdateAnkhs()
	AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Ankhs = AnkhCT_GetAnkhs()
end


function AnkhCT_NameFromLink(link)
	local name
	if (link) then
		for name in string.gfind(link, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
			return name
		end
	end
end 



--------------------------------------------------------------------------------------------------
-- Function that handles various events
--------------------------------------------------------------------------------------------------

function AnkhCT_OnEvent(event)	
	local eventTime = GetTime()
	local myEvent = event

	
	if (AnkhCT_AddonEnabled == 1) then
	
		-- If this is the first event (that is when the cooldown is 0) initialize variables
		if (event == "VARIABLES_LOADED") then
			AnkhCT_Frame:SetBackdropColor(0, 0.1, 0.9, 0.25)
			AnkhCT_Frame:SetBackdropBorderColor(1, 1, 1, 0.5)
			
			
			if (AnkhCT_TalentCooldown == 0) then
				AnkhCT_InitializeVariables()
			end
			return
		end

		if (AnkhCT_TalentCooldown ~= 0) then
		
			-- if an event occurs that would affect the number of ankhs
			if (event == "BAG_UPDATE" or event == "PLAYER_ENTERING_WORLD") then			
				
				-- Check for reincarnation
				AnkhCT_ReincTest(eventTime)	

				AnkhCT_UpdateTalentCooldown()
				
				return
			end
			
			if (myEvent == "UNIT_INVENTORY_CHANGED") then
				if (arg1 == "player") then
					-- Check for reincarnation
					AnkhCT_ReincTest(eventTime)
				end
				return
			end
			
			if (myEvent == "PLAYER_ALIVE") then
				ConsoleMsg("PLAYER_ALIVE", 2)
				AnkhCT_IsAlive(eventTime)
				return
			end
			
			if (myEvent == "PLAYER_DEAD") then
				ConsoleMsg("PLAYER_DEAD", 2)
				AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Alive = 0
				return
			end	
			
			-- if we learned new spells (or talents), update the rez capability
			if (myEvent == "LEARNED_SPELL_IN_TAB" or myEvent == "SPELLS_CHANGED") then
				AnkhCT_UpdateTalentCooldown()
				return
			end
		end
    end    
end


--------------------------------------------------------------------------------------------------
-- Function that answers update calls from the game
--------------------------------------------------------------------------------------------------

function AnkhCT_OnUpdate(arg1)

	-- Make sure the script doesn't start counting anything before 
	-- All variables have initialized.. PlayerName is always the last
	-- to initialize...
	if (not AnkhCT_PlayerName) then
		AnkhCT_InitializeVariables()
		
		return
	end
	
	local elapsed = arg1
	if (AnkhCT_AddonEnabled == 1) then	
	
		if (not AnkhCT_TimerUpdate) then
			AnkhCT_TimerUpdate = 0
		else
			if (elapsed) then
				AnkhCT_TimerUpdate = AnkhCT_TimerUpdate - elapsed
			end
		end
		
		if (AnkhCT_TimerUpdate <= 0) then
			
			-- OnUpdate is only called if the the gui is showing. The default for the GUI is
			-- to be visible on startup, so if the user has disabled the gui it will be hidden
			-- on the first update.
			if (AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Gui == 0) then
				AnkhCT_Frame:Hide()
			end
			
			-- Update the Gui box if it's enabled
			if (AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Gui == 1) then
			
				local ankhs = AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Ankhs
			
				-- Change text color depending on the nr of ankhs the player has. Normal is light yellow
				local ankhColor = "|cffffff9a"
			
				if (ankhs == 0) then
					-- Red color
					ankhColor = "|cffff2020"
				elseif ( ankhs == 1) then
					-- Green color
					ankhColor = "|cff20ff20"
				end
				
				-- Update the GUI box with text
				AnkhCT_Ankhs:SetText("Ankhs: " .. ankhColor .. ankhs .. "|r")
				AnkhCT_Cooldown:SetText("Cooldown: |c00FFFFFF" .. date("%M:%S ", AnkhCT_GetAnkhCooldown()) .. "|r")
			end


			-- Restore the timer update timer
			AnkhCT_TimerUpdate = AnkhCT_TIMERINTERVAL
		end
	end
end



--------------------------------------------------------------------------------------------------
-- Checks if the user really used an ankh to reincarnate and calls the reincarnate function
-- if so. Also updates the ankh inventory status
--------------------------------------------------------------------------------------------------
function AnkhCT_ReincTest(eventTime)
	
	local nrOfAnks = AnkhCT_GetAnkhs()
	-- tests for reincarnation go here
	-- first see if ankhs decremented
	if (nrOfAnks == AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Ankhs - 1 ) then

	-- Only reset timer if it's not already counting down! (Phanx)
	if ( AnkhCT_GetAnkhCooldown() == 0 ) then
			ConsoleMsg("Testing for reincarnation because ankhs changed.")
			-- this is for ankh decrement while dead
			if (AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Alive == 0) then			
				AnkhCT_PlayerReincarnated()
				ConsoleMsg("ReincTest in .Alive", 2)
				
			elseif (AnkhCT_ReincarnationTime) and ((eventTime - AnkhCT_ReincarnationTime) < AnkhCT_TESTINTERVAL) then
					AnkhCT_PlayerReincarnated()
					ConsoleMsg("ReincTest in AnkhCT_ReincarnationTime", 2)
			end
		end
	end
	
	AnkhCT_UpdateAnkhs()
end


--------------------------------------------------------------------------------------------------
-- Returns ankh cooldown in seconds [OLD]
--------------------------------------------------------------------------------------------------
function OLD_AnkhCT_GetAnkhCooldown()

	local lastUsed = AnkhCT_GetLastUsed()
	
	if (lastUsed == 0) then
		return 0
	end
	
	AnkhCT_UpdateTalentCooldown()
	
	local cooldown = AnkhCT_GetSystemSinceWOW() - lastUsed
	
	if( cooldown > AnkhCT_TalentCooldown ) then
		return 0
	end
	
	return AnkhCT_TalentCooldown - cooldown
	
end

--------------------------------------------------------------------------
-- NEW 1.12 function for retrieving Reincarnation current cooldown info
-- @TODO: cache cooldown @ time and use cached data to calculate current?
--------------------------------------------------------------------------
function AnkhCT_GetAnkhCooldown()
	local i = 1
	while true do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)

		if not spellName then
			do break end
		end

		if ( spellName == "Reincarnation" ) then
			local start, duration = GetSpellCooldown(i, BOOKTYPE_SPELL)
			if ( start > 0 and duration > 0) then
				CurrentCooldown = duration - ( GetTime() - start )
			else
				CurrentCooldown = 0
			end
			do break end
		end

		i = i + 1
	end
	return CurrentCooldown
end


--------------------------------------------------------------------------------------------------
-- Checks if the player is alive or not. If called with eventTime the function will
-- store the time of death.
--------------------------------------------------------------------------------------------------
function AnkhCT_IsAlive(eventTime)

	if (AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Alive == 0) then
		AnkhCT_ReincarnationTime = eventTime
		AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Alive = 1

	end
end

function AnkhCT_IsAlive()
	if (UnitIsDeadOrGhost("player")) then
		return 0
	else
		return 1
	end
end


--------------------------------------------------------------------------------------------------
-- Called when the player reincarnated with an ankh. It turns on the cooldown
--------------------------------------------------------------------------------------------------

function AnkhCT_PlayerReincarnated()
	ConsoleMsg("Ankh reincarnation used! Starting cooldown timer now.")
	AnkhCT_UpdateTalentCooldown()
	AnkhCT_SetLastUsed(AnkhCT_GetSystemSinceWOW())
end

--------------------------------------------------------------------------------------------------
-- Function used to pring messages to the console. Can also be used for debug output
--------------------------------------------------------------------------------------------------
function ConsoleMsg(msg, level)
	
	if (level) and (AnkhCT_Config) and (AnkhCT_Config.Debug) then
		
		if (level <= AnkhCT_Config.Debug) then
			if (msg) then
				Print("AnkhCT: " .. msg)
			end
		end
	else		
		if (msg) then
			Print("AnkhCT: " .. msg)
		end
	end
end

--------------------------------------------------------------------------------------------------
-- Listener function for chat messages from the player
--------------------------------------------------------------------------------------------------

function AnkhCT_ChatCommandHandler(msg)
	
	msg = string.lower(msg)
	local firsti, lasti, command, setStr = string.find (msg, "(%w+) ([%w%.]+)")

	if ((not command) and msg) then
		command = msg
	end
	
	if (command) then
		command = string.lower(command)
		if (command == "enable") then
			
			AnkhCT_AddonEnabled = 1
			AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Enabled = 1
		elseif (command == "disable") then
		
			AnkhCT_AddonEnabled = 0
			AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Enabled = 0
		elseif (command == "version") then
			
			ConsoleMsg("Version ".. AnkhCT_version)
		elseif (command == "cooldown") then
			ConsoleMsg("Cooldown: " .. date("%M:%S ", AnkhCT_GetAnkhCooldown()))
		elseif (command == "ankhs") then
			ConsoleMsg("Nr of ankhs in bag: " .. AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Ankhs)
		elseif (command == "debug") then		
			if (setStr) then				
				AnkhCT_DebugLevel = setStr + 0
				AnkhCT_Config.Debug = setStr + 0
				ConsoleMsg("Debug level changed to: " .. AnkhCT_Config.Debug)
			end	
		elseif (command == "dead") then
			if (setStr) then
				local secs = tonumber(setStr)
				if (secs  >= 0) and (secs  <= AnkhCT_TalentCooldown) then
					AnkhCT_SetLastUsed(AnkhCT_GetSystemSinceWOW() - AnkhCT_TalentCooldown + secs)
				end
			else
				AnkhCT_SetLastUsed(AnkhCT_GetSystemSinceWOW())
			end
		elseif (command == "togglegui") then
			AnkhCT_ToggleGui()
		elseif (command == "date") then
			ConsoleMsg("Time is: " .. AnkhCT_GetSystemSinceWOW() .. " and ankh was used: " .. AnkhCT_GetLastUsed())
			-- date("today is %A, in %B")
		elseif (command == "reset") then
			if (AnkhCT_Userdata) and (AnkhCT_Userdata[AnkhCT_CurrentServer]) and (AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName]) then
				AnkhCT_SetLastUsed(0)
				Print("Ankh cooldown set to 0!")
			end
		elseif (command == "ready") then
			if (AnkhCT_Userdata) and (AnkhCT_Userdata[AnkhCT_CurrentServer]) and (AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName]) then
				AnkhCT_SetLastUsed(AnkhCT_TalentCooldown)
				Print("Ankh cooldown set to ready!")
			end
		elseif (command == "reincarnated") then
			if (AnkhCT_GetLastUsed() ~= 0) then
				ConsoleMsg("Reincarnated since: " ..  date("%c", AnkhCT_GetLastUsed() + 1100304000))
			else
				ConsoleMsg("No reincarnation data available")
			end
		elseif (command == "toggletooltip") then
			if ( AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Tooltip == 0 ) then
				AnkhCT_Hook_Bag(1)
				AnkhCT_Hook_AllInOneInv(1)
				AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Tooltip = 1
				Print("AnkhCT: Tooltip enabled")

			elseif ( AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Tooltip == 1 ) then
				AnkhCT_Hook_Bag(0)
				AnkhCT_Hook_AllInOneInv(0)
				AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Tooltip = 0
				Print("AnkhCT: Tooltip disabled")
			end
		
		else
			Print("Ankh Cooldown Timer: [act | AnkhCT ]")
			Print("  /act [enable | disable] - enable/disable Ankh Cooldown Timer")
			Print("  /act version - show addon info")
			Print("  /act reset - set cooldown to 0")
			Print("  /act ready - set cooldown to ready")
			Print("  /act dead (secs) - set timer cooldown to max (or to cooldown - secs)")
			Print("  /act ankhs - Returns number of ankhs in your inventory")
			Print("  /act togglegui - Toggles the GUI box on/off")
			Print("  /act toggletooltip - Toggles the extended tooltip on/off")
			Print("  /act reincarnated - Tells you the date and time of your last reincarnation")
			Print("  /act cooldown - Returns the cooldown of your reincarnation ability")
		end
	end
end


--------------------------------------------------------------------------------------------------
-- Returns time since WOW was released. The need for this strange time is that
-- saving the unix time in a persistent variable truncates the 10 digit variable
-- for some reason, and that fucks things up after logout/login. By removing time
-- since wow was released we end up with a much smaller and working number. *NOTE*
-- That was not the case, the time still got truncated, that's why it's stored as
-- a string now instead.. but the WOW time remains..
--------------------------------------------------------------------------------------------------
function AnkhCT_GetSystemSinceWOW()

	-- Return time since WOW was released on november 13th 2004
	return time() - 1100304000

end

function AnkhCT_GetLastUsed()
	return tonumber(AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].LastUsed)
end

function AnkhCT_SetLastUsed(time)
	AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].LastUsed = tostring(time)
end

--------------------------------------------------------------------------------------------------
-- Toggles the GUI box 
--------------------------------------------------------------------------------------------------
function AnkhCT_ToggleGui()

	if (AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Gui == 0) then
		AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Gui = 1
		AnkhCT_Frame:Show()
	elseif(AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Gui == 1) then
		AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Gui = 0
		AnkhCT_Frame:Hide()
	end
end




--------------------------------------------------------------------------------------------------
-- Titan panel support
--------------------------------------------------------------------------------------------------

function TitanPanelAnkhCTButton_OnLoad()

	AnkhCT_OnLoad()
	

	AnkhCT_TitanFound = 1

	this.registry = { 
		id = AnkhCT_TITANID,
		menuText = "Ankh Cooldown Timer", 
		buttonTextFunction = "TitanPanelAnkhCTButton_GetButtonText", 
		tooltipTitle = "Ankh Cooldown Timer", 
		tooltipTextFunction = "TitanPanelAnkhCTButton_GetTooltipText", 
		frequency = 1, 
	}
end


function TitanPanelAnkhCTButton_GetButtonText(id)

	if (not AnkhCT_PlayerName) then
		return "AnkhCT"
	end
	
	local ankhs = AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Ankhs
			
	-- Change text color depending on the nr of ankhs the player has. Normal is light yellow
	local ankhColor = "|cffffff9a"
			
	if (ankhs == 0) then
		-- Red color
		ankhColor = "|cffff2020"
	elseif ( ankhs == 1) then
		-- Green color
		ankhColor = "|cff20ff20"
	end
		
	local cooldownColor = "|cffff2020"
	
	if (AnkhCT_GetAnkhCooldown() == 0) then
		cooldownColor = "|cff20ff20"
	end
	
	local btnText = "       " .. cooldownColor .. date("%M:%S ", AnkhCT_GetAnkhCooldown()) .. "|r (" .. ankhColor .. ankhs .. "|r)"
	
	return btnText
	
end

function TitanPanelAnkhCTButton_GetTooltipText()

	if (not AnkhCT_PlayerName) then
		return ""
	end
	
	local since = "N/A"
	
	if (AnkhCT_GetLastUsed() ~= 0) then
		since = date("%c", AnkhCT_GetLastUsed() + 1100304000)
	end
	
	
	local ankhs = AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName].Ankhs
				
	-- Change text color depending on the nr of ankhs the player has. Normal is light yellow
	local ankhColor = "|cffffff9a"
				
	if (ankhs == 0) then
		-- Red color
		ankhColor = "|cffff2020"
	elseif ( ankhs == 1) then
		-- Green color
		ankhColor = "|cff20ff20"
	end
					
	local cooldownColor = "|cffff2020"
	
	if (AnkhCT_GetAnkhCooldown() == 0) then
		cooldownColor = "|cff20ff20"
	end				
	
	return "Reincarnated since: \n" .. since .. "\nAnkhs: " .. ankhColor .. ankhs .. "|r\nCooldown: ".. cooldownColor .. date("%M:%S ", AnkhCT_GetAnkhCooldown()) .. "|r\nAbility cooldown: |c00FFFFFF" .. AnkhCT_TalentCooldown/60 .. "min|r"
	
end

function TitanPanelRightClickMenu_PrepareAnkhCTMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[AnkhCT_TITANID].menuText)
	TitanPanelRightClickMenu_AddCommand("Reset cooldown", AnkhCT_TITANID, "TitanPanelAnkhCTButton_FuncTest")
	TitanPanelRightClickMenu_AddCommand("Toggle GUI box", AnkhCT_TITANID, "AnkhCT_ToggleGui")
	TitanPanelRightClickMenu_AddSpacer()	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, AnkhCT_TITANID, TITAN_PANEL_MENU_FUNC_HIDE)
end

function AnkhCT_ResetCooldown()
	if (AnkhCT_Userdata) and (AnkhCT_Userdata[AnkhCT_CurrentServer]) and (AnkhCT_Userdata[AnkhCT_CurrentServer][AnkhCT_PlayerName]) then
		AnkhCT_SetLastUsed(0)
	end
end