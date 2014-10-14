--[[

    GR_TT - Grim Riders - Target Tools
    Author: Michail 'Razh' G
]]--

-----===============-----
--    [Global Vars]    --
-----===============-----

GR_TT_Enabled = false               -- disable on startup
GR_TT_LockedStatus = false          -- dragable on startup
GR_TT_mode = false                  -- [false] = leader mode, [true] = raid member mode
GR_TT_soundEnabled = true           -- enable sound on startup
GR_TT_combatEnabled = false         -- enable reset targets on end combat
GR_TT_targetByName = false          -- enable ability to use TargetByName
GR_TT_lockInCombat = false          -- do not lock icon placement in combat
GR_TT_targetPaintMode = false       -- true = do not expand icons
GR_TT_fadeMenu = true               -- fade the menu when inactive
GR_TT_showOnParty = true             -- display on joining party, hide when leaving
GR_TT_highlightRaidTarget = true    -- highlight the target which is selected by most raid members.
GR_TT_displayIconHP = true          -- displays marked target's hp and total pull hp.

-- Spacing Settings -------
GR_TT_panelSize_mini_x = 28
GR_TT_panelSize_mini_y = 28

GR_TT_panelSize_maxi_x = 70
GR_TT_panelSize_maxi_y = 51

GR_TT_panelToMain_x = 5
GR_TT_panelToMain_y = 0

GR_TT_panelSpacing = -3
GR_TT_buttonToMain_x = -5
GR_TT_buttonToMain_y = -5
---------------------------

-- In Combat var -----
GR_TT_inCombat = false
GR_TT_iconHP = {0,0,0,0,0,0,0,0}
----------------------

-- Icon List -----------------------------------------------------------------------------
GR_TT_iconList = {"star", "circle", "diamond", "triangle", "moon", "square", "x", "skull"}
------------------------------------------------------------------------------------------
-- Startup iconSatus [false: Minimized] [true: Maximized] ----------
GR_TT_iconStatus = {false,false,false,false,false,false,false,false}
--------------------------------------------------------------------

-- Startup assignments ----------------------------------------------------------------
GR_TT_assignmentName = {"none", "none", "none", "none", "none", "none", "none", "none"}
---------------------------------------------------------------------------------------
-- Startup targets -----------------------------------------------------------------
GR_TT_targetName = {"none", "none", "none", "none", "none", "none", "none", "none"}
-----------------------------------------------------------------------------------
-- Startup target count -----------------------------------------------------------------
GR_TT_targetCount = {0,0,0,0,0,0,0,0}
GR_TT_targetWho = {{"none"},{"none"},{"none"},{"none"},{"none"},{"none"},{"none"},{"none"}}
-----------------------------------------------------------------------------------

--[[ Panel Component List-------------------------
Announce    - button to announce target assignment
Model       - A model to dispay related target
ModelPanel  - A panel to house the model
Panel       - A panel to contain all of the above
ModelPicture- A picture to display on top of model
]]------------------------------------------------

-- Icon list -------------------------------------------------------
GR_TT_leaderIcon = "interface\\pvprankbadges\\pvprank13"
GR_TT_raidMemberIcon = "interface\\pvprankbadges\\pvprank07"
GR_TT_outOfRangeModel = "Creature\\Sporecreature\\sporecreature.m2"
GR_TT_lockInCombatIconDisabled = "interface\\cursor\\unablepicklock"
GR_TT_lockInCombatIconEnabled = "interface\\cursor\\picklock"
GR_TT_targetPaintModeIconDisabled = "interface\\gossipframe\\trainergossipicon"
GR_TT_targetPaintModeIconEnabled = "interface\\gossipframe\\unlearngossipicon"
--------------------------------------------------------------------

-- Sound list -----------------------------------------------------------------------------------------
GR_TT_dpsInSound = "Interface\\AddOns\\Grim Riders - Target Tools\\sounds\\dpsin.wav"
GR_TT_holdDPSSound = "Interface\\AddOns\\Grim Riders - Target Tools\\sounds\\holddps.wav"
GR_TT_assignedTargetSound = "Interface\\AddOns\\Grim Riders - Target Tools\\sounds\\targetassigned.wav"
GR_TT_newTargetSound = "Interface\\AddOns\\Grim Riders - Target Tools\\sounds\\newtarget.wav"
-------------------------------------------------------------------------------------------------------

-- Picture List -------------------------------------------------------------------------------------------------------
-- [1] = Attack (dps in), [2] = Red Circle (hold DPS), [3] = Highlight (your target), [4] = No target but assigned icon
GR_TT_pictureList = {
                    "interface\\cursor\\attack",
                    "interface\\spellshadow\\spell-shadow-unacceptable",
                    "interface\\buttons\\buttonhilight-square",
                    "interface\\characterframe\\disconnect-icon"
}
GR_TT_raidTargetBackground = "interface\\cooldown\\starburst"
-----------------------------------------------------------------------------------------------------------------------

-- Animation Queues -----------------------------------------
-- Layouts: [1] - Default [2] All Row [3] All Column [4] Free
GR_TT_layout = 1 -- Default Layout

GR_TT_updateInteval = 0.01 -- 0.1 seconds between updates
GR_TT_timeSinceLastUpdate = 0

GR_TT_HideQue = {}
GR_TT_ShowQue = {}
GR_TT_HeightQue = {}
GR_TT_WidthQue = {}

GR_TT_fadeRate = 0.3
GR_TT_sizeRate = 8

-- Fade Vars ----------------------------
GR_TT_toggleCheck = true
GR_TT_menuFadeStatus = not GR_TT_fadeMenu
GR_TT_UnassignedAlpha = 0.33
-----------------------------------------

-- Raid Target Background Status -
GR_TT_RaidTargetIcon = 0
----------------------------------

-- Attachment location of menu and status bars -------------------------
GR_TT_attachLocation = false --false = expand left, true  = expand right
------------------------------------------------------------------------

-- HP Bars ------------
GR_TT_Healthbar100Height = 27
GR_TT_HealthbarYoffset = 5
GR_TT_Layout4PullHeight = 60

GR_TT_totalPullHP = 0
GR_TT_hpUpdateMultiplier = 0
GR_TT_hpUpdateDelay = 50
-----------------------
--------------------------------------------------------------

-----===========-----
--    [On Load]    --
-----===========-----

function GR_TT_OnLoad()
	
	-- Register slash command handler ----------
	SLASH_GR_TT1 = "/grtt"
	SlashCmdList["GR_TT"] = function(text)
		GR_TT_SlashCommand(text)
	end
	--------------------------------------------
    
    -- Data Load/Save hooks --------------------
	this:RegisterEvent("VARIABLES_LOADED")
    this:RegisterEvent("PARTY_MEMBERS_CHANGED")
	--------------------------------------------   
    
end

function GR_TT_SlashCommand(text)
	if (text) then
		local command = string.lower(gsub(text, "%s*([^%s]+).*", "%1"));
		local params = string.lower(gsub(text, "%s*([^%s]+)%s*(.*)", "%2"));

		if ((command == "help") or (command == "cmd") or (command == "menu")) then
            -- show help
			GR_TT_ShowHelp()
		elseif (command == "on") then
            -- turn on GR_JD
            GR_TT_Enable()
		elseif (command == "off") then
            -- turn off GR_JD
			GR_TT_Disable(true)
        elseif (command == "lock") then
            GR_TT_Lock()
        elseif (command == "unlock") then
            GR_TT_Unlock()
        elseif (command == "toggle") then
            GR_TT_toggleLock()
        elseif (command == "debug") then
            GR_TT_mode = false
	    elseif (command == "dir") then
	        GR_TT_toggleAttachLocation()
        elseif (command == "pull") then
	        GR_TT_setPullBarHeight(params)
        elseif (command == "reset") then
            getglobal("GRTT_Main"):ClearAllPoints()
	        getglobal("GRTT_Main"):SetPoint("CENTER", "UIParent", "CENTER", 0, 0)
        end
	end
end

function GR_TT_OnEvent()
    if event == "UPDATE_MOUSEOVER_UNIT" then
        GR_TT_parsePlayerTargetChanged("mouseover")
    elseif event == "PLAYER_TARGET_CHANGED" then
        GR_TT_parsePlayerTargetChanged("target")
    elseif event == "RAID_TARGET_UPDATE" then
        GR_TT_parseRaidTargetUpdate()
    elseif event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" then
        if string.sub(arg1,-5) == "dies." then
            GR_TT_parseDeath(arg1)
        end
    elseif event == "PLAYER_REGEN_DISABLED" then
        GR_TT_inCombat = true
    elseif event == "PLAYER_REGEN_ENABLED" then
        if GR_TT_combatEnabled and not UnitIsDead('player') then
            GR_TT_MinimizeAll(true)
        end
        GR_TT_inCombat = false
        GR_TT_totalPullHP = 0
        UIFrameFlashRemoveFrame(getglobal("GRTT_pullHPPanel"))
        GR_TT_HideComponent(getglobal("GRTT_pullHPPanel"))
    elseif event == "CHAT_MSG_ADDON" then
        if arg4 ~= UnitName('player') then
            GR_TT_Parse(arg1, arg2, arg3, arg4)
        end
    elseif event == "PARTY_MEMBERS_CHANGED" and GR_TT_showOnParty then
        if UnitExists('party1') or UnitExists('raid1') then
            if GR_TT_Enabled == false then
                GR_TT_Enable()
            end
        else
            if GR_TT_Enabled == true then
                GR_TT_Disable()
            end
        end
    elseif event == "VARIABLES_LOADED" then
        GR_TT_ReportError("Version"..GetAddOnMetadata("Grim Riders - Target Tools", "Version").." loaded and in |cFFc0c0FFstandby mode|r. Type |cFFc0c0FF/grtt on|r to |cFF00FF00enable|r.")
        GR_TT_HideComponent(getglobal("GRTT_pullHPPanel"))
        if UnitExists('party1') or UnitExists('raid1') then
            if GR_TT_Enabled == false then
                GR_TT_Enable()
            end
        end
        if GR_TT_layout == 4 then
            GR_TT_setPullBarHeight(GR_TT_Layout4PullHeight)
        end
        if GR_TT_targetPaintMode then
            for index = 1,8 do
                getglobal("GRTT_"..GR_TT_iconList[index].."Background"):SetHeight(22)
                getglobal("GRTT_"..GR_TT_iconList[index].."Background"):SetWidth(22)
            end
        end
        
        for index = 1,8 do
            getglobal("GRTT_"..GR_TT_iconList[index].."Panel"):SetAlpha(GR_TT_UnassignedAlpha)
        end
    end
end

function GR_TT_ShowHelp()
    GR_TT_Report("\n-- Command List --\n[|cFF00FF00on|r/|cFFFF0000off|r] Enables/Disable this mod and shows/hides the GUI\n[|cFF00FF00help|r] Displays this text\n[|cFF00FF00unlock|r/|cFFFF0000lock|r] Lock/Unlock the UI for dragging.\n[|cFF00FF00dir|r] Change the direction of menu expansion in Layout 3\n[|cFF00FF00pull #>0|r] Change the height of Pull Progress Bar in Layout 4\n[|cFF00FF00reset|r] Reset the UI position to center of screen\nClick and hold on menu panel to drag")
end

function GR_TT_Enable()
    local main_frame = getglobal("GRTT_Main")
    GR_TT_ShowComponent(main_frame)
    GR_TT_Enabled = true
    
    -- Communication Events --
    main_frame:RegisterEvent("CHAT_MSG_ADDON")
    main_frame:RegisterEvent("PLAYER_REGEN_ENABLED")
    main_frame:RegisterEvent("RAID_TARGET_UPDATE")
    main_frame:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
    main_frame:RegisterEvent("PLAYER_TARGET_CHANGED")
    main_frame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
    main_frame:RegisterEvent("PLAYER_REGEN_DISABLED")
    main_frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
    --------------------------
    
    GR_TT_Report("Enabled and events |cFF00FF00registered")
    
    GR_TT_mode = false
    GR_TT_ToggleMode()
    GR_TT_MinimizeAll(true)
end
function GR_TT_Disable(hardDisable)
    local main_frame = getglobal("GRTT_Main")
    GR_TT_HideComponent(main_frame)
    GR_TT_HideComponent(getglobal("GRTT_optionsFrame"))
    GR_TT_HideComponent(getglobal("GRTT_helpFrame"))
    GR_TT_HideComponent(getglobal("GRTT_iconsFrame"))
    GR_TT_Enabled = false
    
    -- Communication Events --
    main_frame:UnregisterEvent("CHAT_MSG_ADDON")
    main_frame:UnregisterEvent("PLAYER_REGEN_ENABLED")
    main_frame:UnregisterEvent("RAID_TARGET_UPDATE")
    main_frame:UnregisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
    main_frame:UnregisterEvent("PLAYER_TARGET_CHANGED")
    main_frame:UnregisterEvent("UPDATE_MOUSEOVER_UNIT")
    main_frame:UnregisterEvent("PLAYER_REGEN_DISABLED")
    --------------------------
    
    if hardDisable then
        main_frame:UnregisterEvent("PARTY_MEMBERS_CHANGED")
    end
    
    GR_TT_Report("Disabled and events |cFFFF0000unregistered")
    GR_TT_Report("has entered standby mode...")
end

function GR_TT_Unlock()
    GR_TT_LockedStatus = false
    GR_TT_Report("UI is |cFF00FF00unlocked|r.")
end

function GR_TT_Lock()
    GR_TT_LockedStatus = true
    GR_TT_Report("UI is |cFFFF0000locked|r.")
end

function GR_TT_isLocked()
    return GR_TT_LockedStatus
end

function GR_TT_toggleLock()
    if GR_TT_LockedStatus then
        GR_TT_LockedStatus = false
        GR_TT_Report("UI is |cFF00FF00unlocked|r.")
    else
        GR_TT_LockedStatus = true
        GR_TT_Report("UI is |cFFFF0000locked|r.")
    end
end

function GR_TT_toggleSound()
    if GR_TT_soundEnabled then
        GR_TT_soundEnabled = false
        GR_TT_Report("Sound is now |cFFFF0000off|r.")
    else
        GR_TT_soundEnabled = true
        GR_TT_Report("Sound is now |cFF00FF00on|r.")
    end
end

function GR_TT_toggleCombat()
    if GR_TT_combatEnabled then
        GR_TT_combatEnabled = false
        GR_TT_Report("Clear Icons on exit combat is |cFFFF0000disabled|r.")
    else
        GR_TT_combatEnabled = true
        GR_TT_Report("Clear Icons on exit combat is |cFF00FF00enabled|r.")
    end
end

function GR_TT_toggleTargetByName()
    if GR_TT_targetByName then
        GR_TT_targetByName = false
        GR_TT_Report("Using TargetByName as last resort |cFFFF0000disabled|r.")
    else
        GR_TT_targetByName = true
        GR_TT_Report("Using TargetByName as last resort |cFF00FF00enabled|r.")
    end
end

function GR_TT_setPullBarHeight(new_height)
    if new_height then
        new_height = new_height + 0
    else
        new_height = 40
    end
    
    if new_height > 0 then
        GR_TT_Report("Pull Progress Bar height changed from |cFFFF0000 "..GR_TT_Layout4PullHeight.." to |cFF00FF00 "..new_height)
        GR_TT_Layout4PullHeight = new_height
    else
        GR_TT_ReportError("You did not specify a new Pull Progress Bar height greater then 0.")
    end
end

function GR_TT_toggleFadeMenu()
    if GR_TT_fadeMenu then
        GR_TT_fadeMenu = false
        GR_TT_Report("Menu fading |cFFFF0000disabled|r.")
        GR_TT_ShowComponent(getglobal("GRTT_menuPanel"))
        GR_TT_ShowComponent(getglobal("GRTT_statusPanel"))
    else
        GR_TT_fadeMenu = true
        GR_TT_Report("Menu fading |cFF00FF00enabled|r.")
    end
    GR_TT_toggleCheck = true
    GR_TT_menuFadeStatus = not GR_TT_fadeMenu
end

function GR_TT_toggleLockInCombat()
    local button_pointer = getglobal("GRTT_lockInCombatButton")
    if GR_TT_lockInCombat then
        GR_TT_lockInCombat = false
        GR_TT_Report("Icons in combat |cFF00FF00unlocked|r.")
        
        button_pointer:SetNormalTexture(GR_TT_lockInCombatIconDisabled)
        button_pointer:SetPushedTexture(GR_TT_lockInCombatIconDisabled)
    else
        GR_TT_lockInCombat = true
        GR_TT_Report("Icons in combat |cFFFF0000locked|r.")
        
        button_pointer:SetNormalTexture(GR_TT_lockInCombatIconEnabled)
        button_pointer:SetPushedTexture(GR_TT_lockInCombatIconEnabled)
    end
end

function GR_TT_toggleAttachLocation()
    if GR_TT_attachLocation then
        GR_TT_attachLocation = false
        GR_TT_Report("Menu and Status panel in Layout 3 will now expand |cFF00FF00left|r.")
    else
        GR_TT_attachLocation = true
        GR_TT_Report("Menu and Status panel in Layout 3 will now expand |cFF00FF00right|r.")
    end
end

function GR_TT_toggleHighlightRaidTarget()
    if GR_TT_highlightRaidTarget then
        GR_TT_highlightRaidTarget = false
        GR_TT_Report("Highlighting of raid target |cFFFF0000disabled|r.")
    else
        GR_TT_highlightRaidTarget = true
        GR_TT_Report("Highlighting of raid target |cFF00FF00enabled|r.")
    end
    
end

function GR_TT_toggleShowOnParty()
    if GR_TT_showOnParty then
        GR_TT_showOnParty = false
        GR_TT_Report("GRTT visibility based on party status |cFFFF0000disabled|r.")
    else
        GR_TT_showOnParty = true
        GR_TT_Report("GRTT visibility based on party status |cFF00FF00enabled|r.")
    end
    
end

function GR_TT_toggleDisplayIconHP()
    if GR_TT_displayIconHP then
        GR_TT_displayIconHP = false
        GR_TT_Report("Display of marked target's HP and pull progression |cFFFF0000disabled|r.")
        for index = 1,8 do
            GR_TT_HideComponent(getglobal("GRTT_"..GR_TT_iconList[index].."HPPanel"))
        end
    else
        GR_TT_displayIconHP = true
        GR_TT_Report("Display of marked target's HP and pull progression |cFF00FF00enabled|r.")
        for index = 1,8 do
            GR_TT_ShowComponent(getglobal("GRTT_"..GR_TT_iconList[index].."HPPanel"))
        end
    end
    
end

function GR_TT_toggleTargetPaintMode()
    button_pointer = getglobal("GRTT_targetPaintModeButton")
    if GR_TT_targetPaintMode then
        GR_TT_targetPaintMode = false
        GR_TT_Report("Simple Mode |cFFFF0000disabled|r.")
        
        button_pointer:SetNormalTexture(GR_TT_targetPaintModeIconDisabled)
        button_pointer:SetPushedTexture(GR_TT_targetPaintModeIconDisabled)
        
        for index = 1,8 do
            getglobal("GRTT_"..GR_TT_iconList[index].."Background"):SetHeight(45)
            getglobal("GRTT_"..GR_TT_iconList[index].."Background"):SetWidth(64)
        end
        
    else
        GR_TT_targetPaintMode = true
        GR_TT_Report("Simple Mode |cFF00FF00enabled|r.")
        
        button_pointer:SetNormalTexture(GR_TT_targetPaintModeIconEnabled)
        button_pointer:SetPushedTexture(GR_TT_targetPaintModeIconEnabled)
        
        for index = 1,8 do
            getglobal("GRTT_"..GR_TT_iconList[index].."Background"):SetHeight(22)
            getglobal("GRTT_"..GR_TT_iconList[index].."Background"):SetWidth(22)
        end
    end
end

function GR_TT_getSoundStatus()
    return GR_TT_soundEnabled
end

function GR_TT_getCombatStatus()
    return GR_TT_combatEnabled
end

function GR_TT_getTargetByNameStatus()
    return GR_TT_targetByName
end

function GR_TT_getLockInCombat()
    return GR_TT_lockInCombat
end

function GR_TT_getTargetPaintMode()
    return GR_TT_targetPaintMode
end

function GR_TT_getFadeMenu()
    return GR_TT_fadeMenu
end

function GR_TT_getShowOnParty()
    return GR_TT_showOnParty
end

function GR_TT_getHighlightRaidTarget()
    return GR_TT_highlightRaidTarget
end

function GR_TT_getDisplayIconHP()
    return GR_TT_displayIconHP
end

function GR_TT_Maximize(iconID, netCall)
    
    if not GR_TT_targetPaintMode then
        local icon = GR_TT_iconList[iconID]   
        GR_TT_iconStatus[iconID] = true
   
        -- Grab the items we are currently working on
        local working_Panel = getglobal("GRTT_"..icon.."Panel")
        local working_Model = getglobal("GRTT_"..icon.."Model")
        local working_ModelPanel = getglobal("GRTT_"..icon.."ModelPanel")
        local working_Announce = getglobal("GRTT_"..icon.."Announce")
        local working_hpPanel = getglobal("GRTT_"..icon.."HPPanel")
        
        -- Show components that are required for maximized view
        GR_TT_ShowComponent(working_Announce)
        GR_TT_ShowComponent(working_Model)
        GR_TT_ShowComponent(working_ModelPanel)
        GR_TT_ShowComponent(working_hpPanel)
        
        -- Resize the Panel to minimized size
        GR_TT_ResizeComponentHeight(working_Panel, GR_TT_panelSize_maxi_y)
        GR_TT_ResizeComponentWidth(working_Panel, GR_TT_panelSize_maxi_x)
        
        if not netCall then
            GR_TT_Transmit("mxm", iconID)
        end
    end
end

function GR_TT_Minimize(iconID, netCall, forceTargetByName)
    local icon = GR_TT_iconList[iconID]
    GR_TT_iconStatus[iconID] = false
    -- Grab the items we are currently working on
    local working_Panel = getglobal("GRTT_"..icon.."Panel")
    local working_Model = getglobal("GRTT_"..icon.."Model")
    local working_ModelPanel = getglobal("GRTT_"..icon.."ModelPanel")
    local working_Announce = getglobal("GRTT_"..icon.."Announce")
    local working_hpPanel = getglobal("GRTT_"..icon.."HPPanel")
    local working_background = getglobal("GRTT_"..icon.."Background")
    
    -- Hide components that are not required for minimized view
    GR_TT_HideComponent(working_Announce)
    GR_TT_HideComponent(working_Model)
    GR_TT_HideComponent(working_ModelPanel)
    GR_TT_HideComponent(working_hpPanel)
    GR_TT_HideComponent(working_background)
    
    -- Resize the Panel to minimized size
    GR_TT_ResizeComponentHeight(working_Panel, GR_TT_panelSize_mini_y)
    GR_TT_ResizeComponentWidth(working_Panel, GR_TT_panelSize_mini_x)
    
    if not netCall then
        GR_TT_Transmit("mnm", iconID)
    end
    
    GR_TT_iconHP[iconID] = 0
    GR_TT_targetWho[iconID] = {"none"}
     -- Clear it's attributes
    GR_TT_ClearIconModel(iconID, netCall)
    GR_TT_ClearOverlayPicture(iconID, netCall)
    
    if GR_TT_targetName[iconID] ~= "none" and not netCall then
        GR_TT_ClearRaidIcon(iconID, netCall, forceTargetByName)
    end
    
    GR_TT_targetName[iconID] = "none"
    getglobal("GRTT_"..icon.."CountLabel"):SetText("")
    getglobal("GRTT_"..icon.."Panel"):SetAlpha(GR_TT_UnassignedAlpha)
end

function GR_TT_MinimizeAll(netCall, forceTargetByName)
        for icon_index = 1,8 do
            GR_TT_Minimize(icon_index, netCall, forceTargetByName)
        end
end

function GR_TT_UpdateModel(iconID, unitModel)
    local icon = GR_TT_iconList[iconID]
    -- Grab the items we are currently working on
    local working_Model = getglobal("GRTT_"..icon.."Model")
    
    -- Set the new information
    working_Model:ClearModel()
    if unitModel then
        -- If we were given a model, set the model
        if UnitIsVisible(unitModel) then
            working_Model:SetUnit(unitModel)
        else
            working_Model:SetModel(GR_TT_outOfRangeModel)
        end
    elseif UnitExists('target') then
        -- If not, set the default model
        if UnitIsVisible(unitModel) then
            working_Model:SetUnit('target')
        else
            working_Model:SetModel(GR_TT_outOfRangeModel)
        end
    end
    working_Model:SetCamera(0)
    
end

function GR_TT_UpdateName(iconID, unitName,netCall)
    local icon = GR_TT_iconList[iconID]
    -- Grab the items we are currently working on
    local working_ModelPanel = getglobal("GRTT_"..icon.."ModelPanel")
    
    -- Set the new information
   
    if not unitName then
        if UnitExists('target') then
            if UnitIsVisible('target') then
                unitName = UnitName('target')
            else
                unitName = "|cFFFF0000Out of Range"
            end
        else
            unitName = "|cFFFF0000Unknown Unit"
        end
    end
    
    GR_TT_targetName[iconID] = unitName
    
    if not netCall then
        GR_TT_Transmit("txt", icon, "#"..unitName)
    end
end

function GR_TT_ClearIconModel(iconID,netCall)
    local icon = GR_TT_iconList[iconID]
    -- Grab the items we are currently working on
    local working_Model = getglobal("GRTT_"..icon.."Model")
    local working_ModelPanel = getglobal("GRTT_"..icon.."ModelPanel")
    
    -- Clear the items
    working_Model:ClearModel()
    
    if not netCall then
        GR_TT_Transmit("clr", iconID)
    end
end

function GR_TT_HideComponent(component_Pointer)
    GR_TT_AnimateHide(component_Pointer, 0)
end

function GR_TT_ShowComponent(component_Pointer)
    GR_TT_AnimateShow(component_Pointer, 1)
end

function GR_TT_ResizeComponentHeight(component_Pointer, newSize)
    GR_TT_AnimateHeight(component_Pointer, newSize)
end

function GR_TT_ResizeComponentWidth(component_Pointer, newSize)
    GR_TT_AnimateWidth(component_Pointer, newSize)
end

function GR_TT_AllignUIPanels()
    -- This function makes the UI display it's current state
    -- obj:SetPoint(point, frame, relativePoint , x, y);
    local working_Frame = nil
    local anchor_target_Frame = nil
    local nudge_down = 0
    
    if GR_TT_layout == 1 then
        -- Frame 1
        working_Frame = getglobal("GRTT_"..GR_TT_iconList[1].."Panel")
        working_Frame:ClearAllPoints()
        working_Frame:SetPoint("TOPLEFT", "GRTT_Main", "TOPLEFT", 0, -GR_TT_panelToMain_y)
        
        -- Frame 2,3,4
        for index = 2,4 do
            anchor_target_Frame = getglobal("GRTT_"..GR_TT_iconList[index-1].."Panel")
            working_Frame = getglobal("GRTT_"..GR_TT_iconList[index].."Panel")
            working_Frame:ClearAllPoints()
            working_Frame:SetPoint("TOPLEFT", anchor_target_Frame, "TOPRIGHT", GR_TT_panelSpacing, 0)
        end
        
        if not GR_TT_iconStatus[1] and (GR_TT_iconStatus[2] or GR_TT_iconStatus[3] or GR_TT_iconStatus[4]) then
            --if any of the top row is expanded, we must nudge down the bottom row
            nudge_down = GR_TT_panelSize_maxi_y - GR_TT_panelSize_mini_y
        end
        
        -- Frame 5
        anchor_target_Frame = getglobal("GRTT_"..GR_TT_iconList[1].."Panel")
        working_Frame = getglobal("GRTT_"..GR_TT_iconList[5].."Panel")
        working_Frame:ClearAllPoints()
        working_Frame:SetPoint("TOPLEFT", anchor_target_Frame, "BOTTOMLEFT", 0, -GR_TT_panelSpacing-nudge_down)
        
        -- Frame 6,7,8
        
        for index = 6,8 do
            anchor_target_Frame = getglobal("GRTT_"..GR_TT_iconList[index-1].."Panel")
            working_Frame = getglobal("GRTT_"..GR_TT_iconList[index].."Panel")
            working_Frame:ClearAllPoints()
            working_Frame:SetPoint("TOPLEFT", anchor_target_Frame, "TOPRIGHT", GR_TT_panelSpacing, 0)
        end
    
        -- Move the menuPanel to the proper position, and resize it
        working_Frame = getglobal("GRTT_menuPanel")
        working_Frame:ClearAllPoints()
        working_Frame:SetPoint("LEFT", "GRTT_starPanel", "LEFT", 0, GR_TT_panelSpacing)
        working_Frame:SetPoint("BOTTOM", "GRTT_starPanel", "TOP", 0, GR_TT_panelSpacing)
        working_Frame:SetPoint("RIGHT", "GRTT_trianglePanel", "RIGHT")
        
        -- Move the statusPanel to the proper position
        working_Frame = getglobal("GRTT_statusPanel")
        working_Frame:ClearAllPoints()
        if GR_TT_iconStatus[8] then
            working_Frame:SetPoint("TOPRIGHT", "GRTT_skullPanel", "BOTTOMRIGHT", 0, -GR_TT_panelSpacing)
        elseif GR_TT_iconStatus[7] then
            working_Frame:SetPoint("TOP", "GRTT_xPanel", "BOTTOM", 0, -GR_TT_panelSpacing)
            working_Frame:SetPoint("RIGHT", "GRTT_skullPanel", "RIGHT")
        else
            working_Frame:SetPoint("TOP", "GRTT_squarePanel", "BOTTOM", 0, -GR_TT_panelSpacing)
            working_Frame:SetPoint("RIGHT", "GRTT_skullPanel", "RIGHT")
        end
        
        if GR_TT_mode then
            --working_Frame:SetWidth(21)
            GR_TT_ResizeComponentWidth(working_Frame, 34)
        else
            --working_Frame:SetWidth(78)
            GR_TT_ResizeComponentWidth(working_Frame, 78)
        end
        
        -- Resize the Main panel to fit the new moved around panels
        working_Frame = getglobal("GRTT_Main")
        
        local width_of_top_row = 
            getglobal("GRTT_"..GR_TT_iconList[1].."Panel"):GetWidth()   +
            GR_TT_panelSpacing                                          +
            getglobal("GRTT_"..GR_TT_iconList[2].."Panel"):GetWidth()   +
            GR_TT_panelSpacing                                          +
            getglobal("GRTT_"..GR_TT_iconList[3].."Panel"):GetWidth()   +
            GR_TT_panelSpacing                                          +
            getglobal("GRTT_"..GR_TT_iconList[4].."Panel"):GetWidth()
            
        local width_of_bottom_row =
            getglobal("GRTT_"..GR_TT_iconList[5].."Panel"):GetWidth()   +
            GR_TT_panelSpacing                                          +
            getglobal("GRTT_"..GR_TT_iconList[6].."Panel"):GetWidth()   +
            GR_TT_panelSpacing                                          +
            getglobal("GRTT_"..GR_TT_iconList[7].."Panel"):GetWidth()   +
            GR_TT_panelSpacing                                          +
            getglobal("GRTT_"..GR_TT_iconList[8].."Panel"):GetWidth()
            
        local new_width = math.max(width_of_top_row, width_of_bottom_row)
        
        -- determine height of top row
        local height_list={}
        for index = 1,4 do
            height_list[index] = 
                GR_TT_panelToMain_y                                             +
                getglobal("GRTT_"..GR_TT_iconList[index].."Panel"):GetHeight()  +
                GR_TT_panelSpacing
        end
        
        local max_height_of_top_row = math.max(height_list[1], height_list[2], height_list[3], height_list[4])
        
        -- determine height of bottom row
        for index = 5,8 do
            height_list[index] =
                getglobal("GRTT_"..GR_TT_iconList[index].."Panel"):GetHeight()  +
                GR_TT_panelToMain_y
        end
        
        local max_height_of_bottom_row = math.max(height_list[5], height_list[6], height_list[7], height_list[8])
        local new_height = max_height_of_top_row + max_height_of_bottom_row
        
        GR_TT_ResizeComponentHeight(working_Frame, new_height)
        GR_TT_ResizeComponentWidth(working_Frame, new_width)
        
        -- place the raid progress bar
        
        getglobal("GRTT_pullHPPanel"):ClearAllPoints()
        getglobal("GRTT_pullHPPanel"):SetPoint("TOPRIGHT", "GRTT_starPanel", "TOPLEFT", 1, 0)
        getglobal("GRTT_pullHPPanel"):SetPoint("BOTTOM", "GRTT_moonPanel", "BOTTOM", 0, 0)

    elseif GR_TT_layout == 2 then
        -- Frame 1
        working_Frame = getglobal("GRTT_"..GR_TT_iconList[1].."Panel")
        working_Frame:ClearAllPoints()
        working_Frame:SetPoint("TOPLEFT", "GRTT_Main", "TOPLEFT", 0, -GR_TT_panelToMain_y)
        
        -- Frame 2,3,4,5,6,7,8
        for index = 2,8 do
            anchor_target_Frame = getglobal("GRTT_"..GR_TT_iconList[index-1].."Panel")
            working_Frame = getglobal("GRTT_"..GR_TT_iconList[index].."Panel")
            working_Frame:ClearAllPoints()
            working_Frame:SetPoint("TOPLEFT", anchor_target_Frame, "TOPRIGHT", GR_TT_panelSpacing, 0)
        end
    
        -- Move the menuPanel to the proper position, and resize it
        working_Frame = getglobal("GRTT_menuPanel")
        working_Frame:ClearAllPoints()
        working_Frame:SetPoint("LEFT", "GRTT_starPanel", "LEFT", 0, GR_TT_panelSpacing)
        working_Frame:SetPoint("BOTTOM", "GRTT_starPanel", "TOP", 0, GR_TT_panelSpacing)
        working_Frame:SetPoint("RIGHT", "GRTT_trianglePanel", "RIGHT")
        
        -- Move the statusPanel to the proper position
        working_Frame = getglobal("GRTT_statusPanel")
        working_Frame:ClearAllPoints()
        if GR_TT_iconStatus[8] then
            working_Frame:SetPoint("TOPRIGHT", "GRTT_skullPanel", "BOTTOMRIGHT", 0, -GR_TT_panelSpacing)
        elseif GR_TT_iconStatus[7] then
            working_Frame:SetPoint("TOP", "GRTT_xPanel", "BOTTOM", 0, -GR_TT_panelSpacing)
            working_Frame:SetPoint("RIGHT", "GRTT_skullPanel", "RIGHT")
        else
            working_Frame:SetPoint("TOP", "GRTT_squarePanel", "BOTTOM", 0, -GR_TT_panelSpacing)
            working_Frame:SetPoint("RIGHT", "GRTT_skullPanel", "RIGHT")
        end
        
        if GR_TT_mode then
            --working_Frame:SetWidth(21)
            GR_TT_ResizeComponentWidth(working_Frame, 34)
        else
            --working_Frame:SetWidth(78)
            GR_TT_ResizeComponentWidth(working_Frame, 78)
        end
        
        -- Resize the Main panel to fit the new moved around panels
        working_Frame = getglobal("GRTT_Main")
        
        local width_of_top_row = 0
            
        for icon_index = 1,8 do
            width_of_top_row = width_of_top_row + getglobal("GRTT_"..GR_TT_iconList[icon_index].."Panel"):GetWidth()
        end
        width_of_top_row = width_of_top_row + GR_TT_panelSpacing*7
        
        -- determine height of top row
        local found_maxi = false
        for max_index = 6,8 do
            if GR_TT_iconStatus[max_index] then
                found_maxi = true
                break
            end
        end
        local height_of_only_row
        if found_maxi then
            height_of_only_row = GR_TT_panelToMain_y*2 + GR_TT_panelSize_maxi_y
        else
            height_of_only_row = GR_TT_panelToMain_y*2 + GR_TT_panelSize_mini_y
        end
        
        GR_TT_ResizeComponentHeight(working_Frame, height_of_only_row)
        GR_TT_ResizeComponentWidth(working_Frame, width_of_top_row)
        
                -- place the raid progress bar
        
        getglobal("GRTT_pullHPPanel"):ClearAllPoints()
        getglobal("GRTT_pullHPPanel"):SetPoint("TOPRIGHT", "GRTT_starPanel", "TOPLEFT", 1, 0)
        getglobal("GRTT_pullHPPanel"):SetPoint("BOTTOM", "GRTT_starPanel", "BOTTOM", 0, 0)

    elseif GR_TT_layout == 3 then
        -- Frame 1
        working_Frame = getglobal("GRTT_"..GR_TT_iconList[1].."Panel")
        working_Frame:ClearAllPoints()
        working_Frame:SetPoint("TOPLEFT", "GRTT_Main", "TOPLEFT", 0, -GR_TT_panelToMain_y)
        
        -- Frame 2,3,4,5,6,7,8
        for index = 2,8 do
            anchor_target_Frame = getglobal("GRTT_"..GR_TT_iconList[index-1].."Panel")
            working_Frame = getglobal("GRTT_"..GR_TT_iconList[index].."Panel")
            working_Frame:ClearAllPoints()
            working_Frame:SetPoint("TOPLEFT", anchor_target_Frame, "BOTTOMLEFT", 0, -GR_TT_panelSpacing)
        end
    
        -- Move the menuPanel to the proper position, and resize it
        working_Frame = getglobal("GRTT_menuPanel")
        working_Frame:ClearAllPoints()
	if GR_TT_attachLocation then
       	working_Frame:SetPoint("BOTTOMRIGHT", "GRTT_starPanel", "TOPRIGHT", 0, GR_TT_panelSpacing)
	else
        working_Frame:SetPoint("BOTTOMLEFT", "GRTT_starPanel", "TOPLEFT", 0, GR_TT_panelSpacing)
	end
        GR_TT_ResizeComponentWidth(working_Frame, 64)
        --working_Frame:SetWidth(64)
        
        -- Move the statusPanel to the proper position
        working_Frame = getglobal("GRTT_statusPanel")
        working_Frame:ClearAllPoints()
	if GR_TT_attachLocation then
        working_Frame:SetPoint("TOPRIGHT", "GRTT_skullPanel", "BOTTOMRIGHT", 2, -GR_TT_panelSpacing)
	else
	    working_Frame:SetPoint("TOPLEFT", "GRTT_skullPanel", "BOTTOMLEFT", 2, -GR_TT_panelSpacing)
	end
        if GR_TT_mode then
            --working_Frame:SetWidth(21)
            GR_TT_ResizeComponentWidth(working_Frame, 34)
        else
            --working_Frame:SetWidth(78)
            GR_TT_ResizeComponentWidth(working_Frame, 78)
        end

        -- Resize the Main panel to fit the new moved around panels
        working_Frame = getglobal("GRTT_Main")
        
        local height = 0
            
        for icon_index = 1,8 do
            height = height + getglobal("GRTT_"..GR_TT_iconList[icon_index].."Panel"):GetHeight()
        end
        height = height + GR_TT_panelSpacing*7
        
        -- determine width
        local found_maxi = false
        for max_index = 1,8 do
            if GR_TT_iconStatus[max_index] then
                found_maxi = true
                break
            end
        end
        
	if GR_TT_mode and GR_TT_menuFadeStatus then
	    width = getglobal("GRTT_menuPanel"):GetWidth()
        elseif GR_TT_mode and not GR_TT_menuFadeStatus then
            if found_maxi then
                width = GR_TT_panelSize_maxi_x
            else
                width = GR_TT_panelSize_mini_x
            end
	elseif not GR_TT_mode and GR_TT_menuFadeStatus then
	    width = getglobal("GRTT_statusPanel"):GetWidth()
	elseif not GR_TT_mode and not GR_TT_menuFadeStatus then
	    if found_maxi then
                width = GR_TT_panelSize_maxi_x
            else
                width = GR_TT_panelSize_mini_x
            end

        end
        
        GR_TT_ResizeComponentHeight(working_Frame, height)
        GR_TT_ResizeComponentWidth(working_Frame, width)
        
        getglobal("GRTT_pullHPPanel"):ClearAllPoints()
        if GR_TT_attachLocation then
            getglobal("GRTT_pullHPPanel"):SetPoint("TOPLEFT", "GRTT_starPanel", "TOPRIGHT", 1, 0)
        else
            getglobal("GRTT_pullHPPanel"):SetPoint("TOPRIGHT", "GRTT_starPanel", "TOPLEFT", 1, 0)       
        end
        getglobal("GRTT_pullHPPanel"):SetPoint("BOTTOM", "GRTT_skullPanel", "BOTTOM", 0, 0)
                    
    elseif GR_TT_layout == 4 then
        working_Frame = getglobal("GRTT_Main")
        GR_TT_ResizeComponentWidth(working_Frame, 1)
        GR_TT_ResizeComponentHeight(working_Frame, 1)
        working_Frame = getglobal("GRTT_statusPanel")
        if GR_TT_mode then
            --working_Frame:SetWidth(21)
            GR_TT_ResizeComponentWidth(working_Frame, 34)
        else
            --working_Frame:SetWidth(78)
            GR_TT_ResizeComponentWidth(working_Frame, 78)
        end
        working_Frame = getglobal("GRTT_menuPanel")
        GR_TT_ResizeComponentWidth(working_Frame, 64)
        GR_TT_ResizeComponentHeight(getglobal("GRTT_pullHPPanel"), GR_TT_Layout4PullHeight)
    end
    
end

function GR_TT_SetLayout(number)
    if number == 4 then
        getglobal("GRTT_scrollLayoutUpButton"):Disable()
        GR_TT_Report("Layout 4: Free mode, |cFFc0c0FFShift Click|r on component to drag.")
    elseif number == 1 then
        getglobal("GRTT_scrollLayoutDownButton"):Disable()
        GR_TT_Report("Layout 1: Default mode, 4x2")
    else
        getglobal("GRTT_scrollLayoutUpButton"):Enable()
        getglobal("GRTT_scrollLayoutDownButton"):Enable()
        if number == 2 then
            GR_TT_Report("Layout 2: Line mode, 8x1")
        elseif number == 3 then
            GR_TT_Report("Layout 3: Column mode, 1x8")
        end
    end
    getglobal("GRTT_layoutNumberLabel"):SetText(number)
    GR_TT_layout = number
end

function GR_TT_getLayout()
    return GR_TT_layout
end

function GR_TT_SelectTarget(buttonID)
    if GR_TT_iconStatus[buttonID] and GR_TT_targetName[buttonID] ~= "none" then
        local found_target = false
        for raid_index = 1,40 do
            if UnitExists("raid"..raid_index.."target") then
                    if buttonID == GetRaidTargetIndex("raid"..raid_index.."target") then
                        found_target = true
                        TargetUnit("raid"..raid_index.."target")
            break end end end
            
        if not found_target then
            for party_index = 1,4 do
                if UnitExists("party"..party_index.."target") then
                    if buttonID == GetRaidTargetIndex("party"..party_index.."target") then
                        found_target = true
                        TargetUnit("party"..party_index.."target")
            break end end end end
    
        if not found_target then
            if UnitExists("target") then
                if buttonID == GetRaidTargetIndex("target") then
                    found_target = true
                end
            end
        end
        
        if not found_target and GR_TT_targetByName then
            local old_target = UnitName('target')
            TargetByName(GR_TT_targetName[buttonID], true)
            if buttonID == GetRaidTargetIndex('target') then
                found_target = true
            elseif old_target then
                TargetByName(old_target, true)
            else ClearTarget() end end
    
        if not found_target then
            GR_TT_ReportError("Cannot select |cFFc0c0FF"..GR_TT_iconList[buttonID].."|r -> [|cFFc0c0FF"..GR_TT_targetName[buttonID].."|r]")
        end
    end
end
function GR_TT_HandleMouseClick(buttonID, arg1)
--[[
buttonID            Type
   1-8            Icons 1-8
   9-16           Icon's Texture 1-8
   17-24          Announce 1-8
   25             Announce All
]]--
if GR_TT_mode then

    if (buttonID >= 1 and buttonID <= 16) then
        if (buttonID >= 9 and buttonID <= 16) then buttonID = buttonID-8 end
        -- This was an icon or model click (we dont care which one)
        UIFrameFlash(getglobal("GRTT_"..GR_TT_iconList[buttonID]), 0.1, 0.1, 0.3, true, 0, 0)
        GR_TT_SelectTarget(buttonID)
    elseif buttonID == 28 then
        if not GR_TT_targetPaintMode then
            GR_TT_MinimizeAll(true)
        else
            for var_icon = 1,8 do
                GR_TT_targetName[var_icon] = "none"
            end
        end
        GR_TT_toggleTargetPaintMode()
    end
    
else
    
    if buttonID <= 8 then
        UIFrameFlash(getglobal("GRTT_"..GR_TT_iconList[buttonID]), 0.1, 0.1, 0.3, true, 0, 0)
        -- This was an icon click
        if GR_TT_iconStatus[buttonID] then
            -- This icon is maximized
            if "LeftButton" == arg1 then
                -- Left mouse button action on maximized
                if GR_TT_layout == 4 and IsShiftKeyDown() and not GR_TT_LockedStatus then
                    --getglobal("GRTT_"..GR_TT_iconList[buttonID].."Panel"):StartMoving()
                else
                    local valid, unitName, unitInRaid = GR_TT_TargetCheck()
                    if valid then
                        if unitInRaid then
                        GR_TT_SendAssign(buttonID, unitName)
                        else
                            -- this unit is hostile, place icon on him
                            if not (GR_TT_inCombat and GR_TT_lockInCombat) then
                                GR_TT_MarkTarget(buttonID)
                            else
                                GR_TT_SelectTarget(buttonID)
                            end
                        end
                    else
                        -- nothing was selected when LEFTMOUSE BUTTON ON MAXIMIZED
                        GR_TT_SelectTarget(buttonID)
                    end
                end
            elseif "RightButton" == arg1 then
                -- Right mouse button action
                -- Rightclick minimizes the icon
                if not (GR_TT_inCombat and GR_TT_lockInCombat) then
                    GR_TT_Minimize(buttonID)
                else
                    GR_TT_ReportError("Cannot remove - lock Icons in combat |cFF00FF00enabled|r.")
                end
            end
        else
            -- This icon is minimized
            if "LeftButton" == arg1 then
                -- Left mouse button action on minimized
                -- This means we have to mark the specific target with the icon
                local valid, unitName, unitInRaid = GR_TT_TargetCheck()
                if valid then
                    -- target is valid
                    if unitInRaid then
                        -- this unit is in the raid, assign him the icon
                        GR_TT_SendAssign(buttonID, unitName)
                    else
                        -- this unit is hostile, place icon on him
                        if not (GR_TT_inCombat and GR_TT_lockInCombat) then
                            GR_TT_MarkTarget(buttonID) -- icon on the target
                        else
                            GR_TT_ReportError("Cannot assign - lock Icons in combat |cFF00FF00enabled|r.")
                        end
                    end
                else
                    -- nothing was selected when LEFTMOUSE BUTTON ON MINIMIZED
                    GR_TT_ReportError("You must have a |cFFc0c0FFtarget|r selected to assign it an Icon.")
                end
            elseif "RightButton" == arg1 then
                GR_TT_assignmentName[buttonID] = "none"
                if GR_TT_targetName[buttonID] ~= "none" then
                    GR_TT_ClearRaidIcon(buttonID)
		        else
			        if UnitExists('target') then
				        if buttonID == GetRaidTargetIndex('target') then
					        SetRaidTarget('target', 0)
				        end
			        end
		        end
            end
        end
    elseif buttonID >= 9 and buttonID <= 16 then
        buttonID = buttonID-8
        -- This is a model/picture click
        if "LeftButton" == arg1 then
            --Left click
            GR_TT_CallDPS(buttonID)
        elseif "MiddleButton" == arg1 then
            --Middle click
            GR_TT_ClearOverlayPicture(buttonID)
        else
            --Right click
            GR_TT_CallHoldDPS(buttonID)
        end
    
    elseif buttonID >= 17 and buttonID <= 24 then
        buttonID = buttonID-16
        -- This is an announce click
        if "LeftButton" == arg1 then
            GR_TT_SendWhisperAnnounce(buttonID)
        else
            GR_TT_SendRaidAnnounce(buttonID)
        end
    elseif buttonID == 25 then
        if "LeftButton" == arg1 then
            for button_index = 1,8 do
                GR_TT_SendWhisperAnnounce(button_index)
            end
        else
            for button_index = 1,8 do
                GR_TT_SendRaidAnnounce(button_index)
            end
        end
    elseif buttonID == 26 then
        GR_TT_Transmit("lst", 0)
        GR_TT_Report("The following players have Target Tools enabled:")
    elseif buttonID == 27 then
        GR_TT_toggleLockInCombat()
    elseif buttonID == 28 then
        if not GR_TT_targetPaintMode then
            GR_TT_MinimizeAll(true)
        else
            for var_icon = 1,8 do
                GR_TT_targetName[var_icon] = "none"
            end
        end
        GR_TT_toggleTargetPaintMode()
    end
end
end

function GR_TT_SendWhisperAnnounce(buttonID)
    if GR_TT_targetName[buttonID] ~= nil and GR_TT_targetName[buttonID] ~= "none" and GR_TT_assignmentName[buttonID] ~= nil and GR_TT_assignmentName[buttonID] ~= "none" then
        if GR_TT_assignmentName[buttonID] ~= UnitName("player") then
            SendChatMessage("You have been assigned ["..GR_TT_iconList[buttonID].."], which is on ["..GR_TT_targetName[buttonID].."]", "WHISPER", nil, GR_TT_assignmentName[buttonID])
        else
            GR_TT_Report("You have been assigned ["..GR_TT_iconList[buttonID].."], which is on ["..GR_TT_targetName[buttonID].."]")
        end
    elseif GR_TT_targetName[buttonID] == "none" and GR_TT_assignmentName[buttonID] ~= nil and GR_TT_assignmentName[buttonID] ~= "none" then
        if GR_TT_assignmentName[buttonID] ~= UnitName("player") then
            SendChatMessage("You have been assigned ["..GR_TT_iconList[buttonID].."]", "WHISPER", nil, GR_TT_assignmentName[buttonID])
        else
            GR_TT_Report("You have been assigned ["..GR_TT_iconList[buttonID].."]")
        end
    end    
end

function GR_TT_SendRaidAnnounce(buttonID)
    if UnitExists("raid1") or UnitExists("raid6") then 
        if GR_TT_targetName[buttonID] ~= nil and GR_TT_targetName[buttonID] ~= "none" and GR_TT_assignmentName[buttonID] ~= nil and GR_TT_assignmentName[buttonID] ~= "none" then
            SendChatMessage(GR_TT_assignmentName[buttonID].." has been assigned ["..GR_TT_iconList[buttonID].."], which is on ["..GR_TT_targetName[buttonID].."]", "RAID", nil, nil)
        elseif GR_TT_targetName[buttonID] == "none" and GR_TT_assignmentName[buttonID] ~= nil and GR_TT_assignmentName[buttonID] ~= "none" then
            SendChatMessage(GR_TT_assignmentName[buttonID].." has been assigned ["..GR_TT_iconList[buttonID].."]", "RAID", nil, nil)
        end
    elseif UnitExists("party1") then
        if GR_TT_targetName[buttonID] ~= nil and GR_TT_targetName[buttonID] ~= "none" and GR_TT_assignmentName[buttonID] ~= nil and GR_TT_assignmentName[buttonID] ~= "none" then
            SendChatMessage(GR_TT_assignmentName[buttonID].." has been assigned ["..GR_TT_iconList[buttonID].."], which is on ["..GR_TT_targetName[buttonID].."]", "PARTY", nil, nil)
        elseif GR_TT_targetName[buttonID] == "none" and GR_TT_assignmentName[buttonID] ~= nil and GR_TT_assignmentName[buttonID] ~= "none" then
            SendChatMessage(GR_TT_assignmentName[buttonID].." has been assigned ["..GR_TT_iconList[buttonID].."]", "PARTY", nil, nil)
        end
    else
        GR_TT_Report("There is no one to send the assignment list to.")
    end
end

function GR_TT_MarkTarget(buttonID)
    -- Check to see if the target we are marking already has an icon
    if GetRaidTargetIndex('target') then
        -- it has an icon
        if GetRaidTargetIndex('target') ~= buttonID then
            -- it's icon isnt the one we're setting
            GR_TT_Minimize(GetRaidTargetIndex('target'))
        end
    end
    
    -- set new icon
    SetRaidTarget('target',buttonID)
end

function GR_TT_ClearRaidIcon(buttonID, netCall, forceTargetByName)
    local found_target = false

    if UnitExists('target') then
        if buttonID == GetRaidTargetIndex('target') then
            found_target = true; 
            SetRaidTarget('target', 0)
        end
    end
    
    for raid_index = 1,40 do
        if UnitExists("raid"..raid_index.."target") then
                if buttonID == GetRaidTargetIndex("raid"..raid_index.."target") then
                    found_target = true; 
                    SetRaidTarget("raid"..raid_index.."target", 0)
    break end end end


    if not found_target then
        for party_index = 1,4 do
            if UnitExists("party"..party_index.."target") then
                if buttonID == GetRaidTargetIndex("party"..party_index.."target") then
                    found_target = true
                    SetRaidTarget("party"..party_index.."target", 0)
    break end end end end


    if not found_target and (GR_TT_targetByName or forceTargetByName) then
        local old_target = UnitName('target')
        TargetByName(GR_TT_targetName[buttonID], true)
        if buttonID == GetRaidTargetIndex('target') then
            SetRaidTarget('target', 0)
            found_target = true
        end if old_target then TargetByName(old_target, true)
    else ClearTarget() end end

    if found_target then
        --
    else
        --GR_TT_ReportError("Failed to remove Icon.")
    end
end

function GR_TT_CallHoldDPS(buttonID, netCall)
    GR_TT_SetOverlayPicture(buttonID, 2)
    if GR_TT_soundEnabled then
        PlaySoundFile(GR_TT_holdDPSSound)
    end
    
    if not netCall then
        GR_TT_Transmit("hld", buttonID)
    end
end

function GR_TT_CallDPS(buttonID, netCall)
    GR_TT_SetOverlayPicture(buttonID, 1)
    if GR_TT_soundEnabled then
        PlaySoundFile(GR_TT_dpsInSound)
    end
    
    if not netCall then
        GR_TT_Transmit("dps", buttonID)
    end
end

function GR_TT_SetOverlayPicture(buttonID, pictureID)
    local icon = GR_TT_iconList[buttonID]
    local working_Overlay = getglobal("GRTT_"..icon.."ModelPictureTexture")
    --GR_TT_ShowComponent(working_Overlay)
    --UIFrameFlash(frame, fadeInTime, fadeOutTime, flashDuration, showWhenDone, flashInHoldTime, flashOutHoldTime)
    UIFrameFlashRemoveFrame(working_Overlay)
    UIFrameFlash(working_Overlay, 0.2, 0.2, 20, true, 0, 0)
    if pictureID == 3 then
        working_Overlay:SetBlendMode("ADD")
    else
        working_Overlay:SetBlendMode("BLEND")
    end
    if working_Overlay:GetTexture() ~= GR_TT_pictureList[3] then
        working_Overlay:SetTexture(GR_TT_pictureList[pictureID])
    end
end

function GR_TT_ClearOverlayPicture(buttonID, netCall)
    local icon = GR_TT_iconList[buttonID]
    local working_Overlay = getglobal("GRTT_"..icon.."ModelPictureTexture")
    UIFrameFlashRemoveFrame(working_Overlay)
    working_Overlay:SetTexture("")
    GR_TT_HideComponent(working_Overlay)
    if not netCall then
        GR_TT_Transmit("cop", buttonID)
    end
end

function GR_TT_TargetCheck()
    -- RETURNS: valid target [true/false] 
    --          is unit in raid [true/fase]
    --          unit name [string]
    
    local valid = nil
    local unitName = nil
    local unitInRaid = nil
    
    if UnitExists('target') then
        -- We have a target selected
        unitName = UnitName('target')
        valid = true
        if UnitInRaid('target') or UnitInParty('target') or (unitName == UnitName('player'))then
            -- This target is in the raid, party, or is the player
            unitInRaid = true
        else
            -- This target is hostile
            unitInRaid = false
        end 
    else
        -- No target
        valid = false
    end
    
    return valid, unitName, unitInRaid
end

function GR_TT_ToggleOptions()
    local frame_pointer = getglobal("GRTT_optionsFrame")
    local options_button = getglobal("GRTT_optionsButton")
    
    if frame_pointer:IsVisible() then
        GR_TT_HideComponent(frame_pointer)
        options_button:SetNormalTexture("interface\\buttons\\ui-attributebutton-encourage-up")
    else
        GR_TT_ShowComponent(frame_pointer)
        options_button:SetNormalTexture("interface\\buttons\\ui-attributebutton-encourage-down")
    end
end

function GR_TT_ToggleHelp()
    local frame_pointer = getglobal("GRTT_helpFrame")
    local iconframe_pointer = getglobal("GRTT_iconsFrame")
    local help_button = getglobal("GRTT_helpButton")
    
    if frame_pointer:IsVisible() then
        GR_TT_HideComponent(frame_pointer)
        GR_TT_HideComponent(iconframe_pointer)
        help_button:SetNormalTexture("interface\\buttons\\ui-guildbutton-officernote-up")
    else
        GR_TT_ShowComponent(iconframe_pointer)
        GR_TT_ShowComponent(frame_pointer)
        help_button:SetNormalTexture("interface\\buttons\\ui-guildbutton-officernote-disabled")
    end
end

function GR_TT_ToggleMode()
    --[false] = leader mode, [true] = raidermode
    local button_pointer = getglobal("GRTT_modeButton")
    local button_announce = getglobal("GRTT_announceAllButton")
    local menu_background = getglobal("GRTT_menuPanel")
    local inspect_button = getglobal("GRTT_inspectButton")
    local lockInCombat_button = getglobal("GRTT_lockInCombatButton")
    local targetPaintMode_button = getglobal("GRTT_targetPaintModeButton")
    
    if GR_TT_mode and (IsRaidLeader() or IsRaidOfficer() or IsPartyLeader()) then
        GR_TT_mode = false
        button_pointer:SetNormalTexture(GR_TT_leaderIcon)
        button_pointer:SetPushedTexture(GR_TT_leaderIcon)
        GR_TT_ShowComponent(button_announce)
        GR_TT_ShowComponent(inspect_button)
        GR_TT_ShowComponent(lockInCombat_button)
        --GR_TT_ShowComponent(targetPaintMode_button)
        
        for icon_index = 1,8 do
            local announce_pointer = getglobal("GRTT_"..GR_TT_iconList[icon_index].."Announce")
            GR_TT_ShowComponent(announce_pointer)
        end
        
        menu_background:SetBackdropColor(192/255, 192/255, 255/255)
        
    elseif not GR_TT_mode then
        GR_TT_mode = true
        button_pointer:SetNormalTexture(GR_TT_raidMemberIcon)
        button_pointer:SetPushedTexture(GR_TT_raidMemberIcon)
        GR_TT_HideComponent(button_announce)
        GR_TT_HideComponent(inspect_button)
        GR_TT_HideComponent(lockInCombat_button)
        --GR_TT_HideComponent(targetPaintMode_button)
        
        for icon_index = 1,8 do
            local announce_pointer = getglobal("GRTT_"..GR_TT_iconList[icon_index].."Announce")
            GR_TT_HideComponent(announce_pointer)
        end
        
        menu_background:SetBackdropColor(1,1,1)
    else
	GR_TT_ReportError("You must be a Raid Leader, Assist, or Party Leader to use |cFF00FF00Leader|r Mode")
    end
end

function GR_TT_GetMode()
    return GR_TT_mode
end

function GR_TT_Transmit(msgID, iconID, arg2)
    if not arg2 then arg2 = "" end
    if not iconID then iconID = "" end
    if (not GR_TT_mode) or (msgID == "rpy") then
        -- Prevent Raid Members from sending anything but their replies.
        SendAddonMessage( "GR_TT", msgID..iconID..arg2, "RAID" )
	-- SendAddonMessage( "GR_TT", "lst", "RAID" )
    end
end

function GR_TT_Parse(prefix, message, dist, sender)
    if prefix == "GR_TT" then
        -- this is a msg from GRTT
        local command = string.sub(message, 1,3)
        local param = nil
        local param2 = nil
        if command == "dps" then
            -- Set the icon from param to dps
            param = string.sub(message, 4) + 0
            GR_TT_CallDPS(param, true)
        elseif command == "hld" then
            -- set the icon from param to hold dps
            param = string.sub(message, 4) + 0
            GR_TT_CallHoldDPS(param, true)
        elseif command == "cop" then
            param = string.sub(message, 4) + 0
            GR_TT_ClearOverlayPicture(param,true)
        elseif command == "asg" then
            -- set the icon from param to assign and play sound
            local separator = string.find(message, "#")
            param = string.sub(message, 4,separator-1) + 0
            param2 = string.sub(message,separator+1)
            if param2 == UnitName('player') then
                GR_TT_AssignMeIcon(param, param2)
            end
        elseif command == "clr" then
            param = string.sub(message, 4) + 0
            GR_TT_ClearIconModel(param,true)
        elseif command == "mxm" then
            param = string.sub(message, 4) + 0
            GR_TT_Maximize(param,true)
        elseif command == "mnm" then
            param = string.sub(message, 4) + 0
            GR_TT_Minimize(param,true)
        elseif command == "lst" then
            GR_TT_Transmit("rpy")
        elseif command == "rpy" then
            GR_TT_Report(sender.." has GR_TT Version "..GetAddOnMetadata("Grim Riders - Target Tools", "Version").." enabled")
        end
        
    end
end

function GR_TT_AssignMeIcon(param, param2) 
    GR_TT_SetOverlayPicture(param, 3)
    if GR_TT_soundEnabled then
        PlaySoundFile(GR_TT_assignedTargetSound)
    end
    GR_TT_ReportError("You have been assigned to ["..GR_TT_iconList[param].."].")
end

function GR_TT_SendAssign(buttonID, unitName)
    if not GR_TT_iconStatus[buttonID] then
        GR_TT_Maximize(buttonID)
    end
    
    if GR_TT_soundEnabled then
        PlaySoundFile(GR_TT_assignedTargetSound)
    end
    GR_TT_assignmentName[buttonID] = unitName
    GR_TT_SetOverlayPicture(buttonID, 4)
    
    if unitName == UnitName('player') then
        GR_TT_AssignMeIcon(buttonID, UnitName('player')) 
    else
        GR_TT_Transmit("asg", buttonID,"#"..unitName)
    end
end

function GR_TT_onUpdate(elapsed)
    GR_TT_timeSinceLastUpdate = GR_TT_timeSinceLastUpdate + elapsed
    GR_TT_hpUpdateMultiplier = GR_TT_hpUpdateMultiplier + 1
    
    if (GR_TT_timeSinceLastUpdate > GR_TT_updateInteval) then
        GR_TT_Animate()
        GR_TT_AllignUIPanels()
        GR_TT_timeSinceLastUpdate = 0;
        if GR_TT_fadeMenu then
            if GR_TT_toggleCheck == GR_TT_menuFadeStatus  then
                -- already switched
            elseif GR_TT_toggleCheck == false then
                -- switching to show
                GR_TT_ShowComponent(getglobal("GRTT_menuPanel"))
                GR_TT_ShowComponent(getglobal("GRTT_statusPanel"))
                GR_TT_toggleCheck = true
            elseif GR_TT_toggleCheck == true then
                -- switching to hide
                GR_TT_HideComponent(getglobal("GRTT_menuPanel"))
                GR_TT_HideComponent(getglobal("GRTT_statusPanel"))
                GR_TT_toggleCheck = false
            end
        end
        if GR_TT_highlightRaidTarget and GR_TT_hpUpdateMultiplier > GR_TT_hpUpdateDelay then
            GR_TT_countTargets()
        end
        if GR_TT_displayIconHP and GR_TT_hpUpdateMultiplier > GR_TT_hpUpdateDelay then
            GR_TT_UpdateHealthBars()
        end
        
        if GR_TT_hpUpdateMultiplier > GR_TT_hpUpdateDelay then
            GR_TT_hpUpdateMultiplier = 0
        end
    end

end

function GR_TT_Animate()
    -- Process frame for HEIGHT
    local new_height
    for key, value in GR_TT_HeightQue do
        local current_height = key:GetHeight()
        if value > current_height+GR_TT_sizeRate then
            -- The value is increasing the size
            new_height = current_height+GR_TT_sizeRate
            key:SetHeight(new_height)
        elseif value < current_height-GR_TT_sizeRate then
            -- The value is decreasing the size
            new_height = current_height-GR_TT_sizeRate
            key:SetHeight(new_height)
        else
            -- The value is at the size
            key:SetHeight(value)
            value = nil
        end
    end
    
    -- Process frame for WIDTH
    local new_width
    for key, value in GR_TT_WidthQue do
        local current_width = key:GetWidth()
        if value > current_width+GR_TT_sizeRate then
            -- The value is increasing the size
            new_width = current_width+GR_TT_sizeRate
            key:SetWidth(new_width)
        elseif value < current_width-GR_TT_sizeRate then
            -- The value is decreasing the size
            new_width = current_width-GR_TT_sizeRate
            key:SetWidth(new_width)
        else
            -- The value is at the size
            key:SetWidth(value)
            value = nil
        end
    end
    
end

function GR_TT_HardwareHide(framePointer)
    framePointer:Hide()
end

function GR_TT_AnimateHide(framePointer, targetAlpha, doNotHide)
    if framePointer then
        local fadeInfo = {}
        fadeInfo.mode = "OUT"
        fadeInfo.timeToFade = 0.25
        fadeInfo.startAlpha = framePointer:GetAlpha()
        fadeInfo.endAlpha = targetAlpha
        fadeInfo.fadeHoldTime = fadeInfo.timeToFade
        if not doNotHide then
        fadeInfo.finishedFunc = GR_TT_HardwareHide
        fadeInfo.finishedArg1 = framePointer
        end
        UIFrameFade(framePointer, fadeInfo)
    end
end

function GR_TT_AnimateShow(framePointer, targetAlpha)
    if framePointer then
        local fadeInfo = {}
        fadeInfo.mode = "IN"
        fadeInfo.timeToFade = 0.25
        fadeInfo.startAlpha = 0
        fadeInfo.endAlpha = targetAlpha
        fadeInfo.fadeHoldTime = fadeInfo.timeToFade
        UIFrameFade(framePointer, fadeInfo)
    end
end

function GR_TT_AnimateHeight(framePointer, targetHeight)
    if framePointer then
        GR_TT_HeightQue[framePointer] = targetHeight
    end
end

function GR_TT_AnimateWidth(framePointer, targetWidth)
    GR_TT_WidthQue[framePointer] = targetWidth
end

function GR_TT_Report(msg)
    local tag = "|cFFc0c0FFTarget Tools:|r |cFFFFFFFF"
    DEFAULT_CHAT_FRAME:AddMessage(tag..msg);
end

function GR_TT_ReportError(msg)
    local tag = "|cFFc0c0FFTarget Tools:|r |cFFFFFFFF"
    UIErrorsFrame:AddMessage(tag..msg, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)
end

function GR_TT_parseRaidTargetUpdate()

    if UnitExists('target') and not (UnitInRaid('target') or UnitInParty('target')) then
        local var_icon = GetRaidTargetIndex("target")
        if var_icon then
            if GR_TT_targetName[var_icon] ~= UnitName("target") then
                if GR_TT_targetName[var_icon] == "none" then
                    GR_TT_NotInDatabase(var_icon, "target")
                else
                    GR_TT_UpdateDatabase(var_icon, "target")
    end end end end
    
    for raid_index = 1,40 do
        if UnitExists("raid"..raid_index.."target") and not (UnitInRaid("raid"..raid_index.."target") or UnitInParty("raid"..raid_index.."target")) then
                local var_icon = GetRaidTargetIndex("raid"..raid_index.."target")
                if var_icon then
                    if GR_TT_targetName[var_icon] ~= UnitName("raid"..raid_index.."target") then
                        if GR_TT_targetName[var_icon] == "none" then
                            GR_TT_NotInDatabase(var_icon, "raid"..raid_index.."target")
                        else
                            GR_TT_UpdateDatabase(var_icon, "raid"..raid_index.."target")
                        end
                    end
    break end end end
    
    for raid_index = 1,4 do
        if UnitExists("party"..raid_index.."target") and not (UnitInRaid("party"..raid_index.."target") or UnitInParty("party"..raid_index.."target")) then
                local var_icon = GetRaidTargetIndex("party"..raid_index.."target")
                if var_icon then
                    if GR_TT_targetName[var_icon] ~= UnitName("party"..raid_index.."target") then
                        if GR_TT_targetName[var_icon] == "none" then
                            GR_TT_NotInDatabase(var_icon, "party"..raid_index.."target")
                        else
                            GR_TT_UpdateDatabase(var_icon, "party"..raid_index.."target")
                        end
                    end
    break end end end
    
end

function GR_TT_NotInDatabase(var_icon, unitPointer)
    if UnitExists(unitPointer) then
        GR_TT_Maximize(var_icon, true)
        GR_TT_UpdateModel(var_icon, unitPointer)
        if GR_TT_assignmentName[var_icon] == "none" then
            GR_TT_UpdateName(var_icon, UnitName(unitPointer), true)
        end
        GR_TT_targetName[var_icon] = UnitName(unitPointer)
        GR_TT_iconHP[var_icon] = UnitHealth(unitPointer)
        PlaySoundFile(GR_TT_newTargetSound)
        getglobal("GRTT_"..GR_TT_iconList[var_icon].."Panel"):SetAlpha(1)
        GR_TT_ShowComponent(getglobal("GRTT_pullHPPanel"))
    end
end

function GR_TT_UpdateDatabase(var_icon, unitPointer)
    if UnitExists(unitPointer) then
        GR_TT_ClearOverlayPicture(var_icon, true)
        GR_TT_UpdateModel(var_icon, unitPointer)
        if GR_TT_assignmentName[var_icon] == "none" then
            GR_TT_UpdateName(var_icon, UnitName(unitPointer), true)
        end
        GR_TT_targetName[var_icon] = UnitName(unitPointer)
        GR_TT_iconHP[var_icon] = UnitHealth(unitPointer)
    end
end

function GR_TT_parseDeath(msg)
    --"Snowshow Rabbit dies."
    local end_param = string.find(msg, "dies") - 2
    local target_name = string.sub(msg, 1, end_param)
    
    for var_icon, value in GR_TT_targetName do
        if value == target_name then
            local delete = true
            
            local unit_pointer = "target"
            if UnitExists(unit_pointer) and var_icon == GetRaidTargetIndex(unit_pointer) and not UnitIsDead(unit_pointer) then
                delete = false
            end

                
            if delete == true then
                for raid_index = 1,4 do
                    local unit_pointer = "party"..raid_index.."target"
                    if UnitExists(unit_pointer) and var_icon == GetRaidTargetIndex(unit_pointer) and not UnitIsDead(unit_pointer) then
                        delete = false
            end end end
            
            if delete == true then
                for raid_index = 1,40 do
                    local unit_pointer = "raid"..raid_index.."target"
                    if UnitExists(unit_pointer) and var_icon == GetRaidTargetIndex(unit_pointer) and not UnitIsDead(unit_pointer)then
                        delete = false
            end end end

            if delete == true then
                GR_TT_Minimize(var_icon)
    end end end
    
end

function GR_TT_parsePlayerTargetChanged(unit_pointer)
    if UnitExists(unit_pointer) and not UnitIsPlayer(unit_pointer) then
        local var_icon = GetRaidTargetIndex(unit_pointer)
        if var_icon then
            if GR_TT_targetName[var_icon] == "none" then
                GR_TT_NotInDatabase(var_icon, unit_pointer)
            else
                GR_TT_iconHP[var_icon] = UnitHealth(unit_pointer)
            end
        end
    end
end

function GR_TT_countTargets()
    for index = 1,8 do
        GR_TT_targetCount[index] = 0
        GR_TT_targetWho[index] = {"none"}
    end
    
    local group_type
    local group_size
    if UnitExists("raid6") then
        group_type = "raid"
        group_size = "40"
    else
        group_type = "party"
        group_size = 4
        
        if UnitExists('playertarget') and GetRaidTargetIndex('playertarget') ~= nil and GetRaidTargetIndex('playertarget') ~= 0 and not (UnitInParty('playertarget') or UnitInRaid('playertarget')) then
            GR_TT_targetCount[GetRaidTargetIndex('playertarget')] = GR_TT_targetCount[GetRaidTargetIndex('playertarget')] + 1
            if GR_TT_targetWho[GetRaidTargetIndex('playertarget')][1] == "none" then
                GR_TT_targetWho[GetRaidTargetIndex('playertarget')][1] = UnitName('player')
            else
                table.insert(GR_TT_targetWho[GetRaidTargetIndex('playertarget')], table.getn(GR_TT_targetWho[GetRaidTargetIndex('playertarget')]) + 1,UnitName('player'))
            end
            GR_TT_iconHP[GetRaidTargetIndex('playertarget')] = UnitHealth('playertarget')
        end
    end
    
    for raid_index = 1,group_size do
        local unit_pointer = group_type..raid_index.."target"
        if UnitExists(unit_pointer) and GetRaidTargetIndex(unit_pointer) ~= nil and GetRaidTargetIndex(unit_pointer) ~= 0 and UnitIsVisible(unit_pointer) and not (UnitInParty(unit_pointer) or UnitInRaid(unit_pointer)) then
            GR_TT_targetCount[GetRaidTargetIndex(unit_pointer)] = GR_TT_targetCount[GetRaidTargetIndex(unit_pointer)] + 1
            if GR_TT_targetWho[GetRaidTargetIndex(unit_pointer)][1] == "none" then
                GR_TT_targetWho[GetRaidTargetIndex(unit_pointer)][1] = UnitName(group_type..raid_index)
            else
                local temp_table = GR_TT_targetWho[GetRaidTargetIndex(unit_pointer)]
                table.insert(temp_table, table.getn(temp_table) + 1, UnitName(group_type..raid_index))
            end
            GR_TT_iconHP[raid_index] = UnitHealth(unit_pointer)
            if GR_TT_targetName[GetRaidTargetIndex(unit_pointer)] == "none" then
                GR_TT_NotInDatabase(GetRaidTargetIndex(unit_pointer), unit_pointer)
            end
    end end 
    
    local highest = 0
    local highest_key = 0
    for key = 1,8 do
        if GR_TT_targetCount[key] ~= 0 then
            getglobal("GRTT_"..GR_TT_iconList[key].."CountLabel"):SetText(GR_TT_targetCount[key])
        else
            getglobal("GRTT_"..GR_TT_iconList[key].."CountLabel"):SetText("")
        end
        if GR_TT_targetCount[key] > highest then
            highest = GR_TT_targetCount[key]
            highest_key = key
        end
    end
      
    if highest_key ~= 0 and not (not GR_TT_targetPaintMode and not GR_TT_iconStatus[highest_key])then
        if highest_key == GR_TT_RaidTargetIcon then
            -- We already have this flashing
        else
            GR_TT_resetAllBackgroundsExceptOne(highest_key)
            local working_background = getglobal("GRTT_"..GR_TT_iconList[highest_key].."Background")
            UIFrameFlash(working_background, 0.25, 0.25, 60, true, 0, 0.5)
            GR_TT_RaidTargetIcon = highest_key
        end
    else
        GR_TT_resetAllBackgroundsExceptOne(0)
    end

end

function GR_TT_resetAllBackgroundsExceptOne(iconID_to_exclude)
    if iconID_to_exclude == nil then
        iconID_to_exclude = 0
    end
    
    for index = 1,8 do
        if index ~= iconID_to_exclude then
            local working_background = getglobal("GRTT_"..GR_TT_iconList[index].."Background")
            UIFrameFlashRemoveFrame(working_background)
            GR_TT_HideComponent(working_background)
        end
    end
end

function GR_TT_UpdateHealthBars()
    -- GR_TT_Healthbar100Height = 33
    -- GR_TT_HealthbarYoffset = 5
    
    local currentPullHP = 0
    local totalPullHP = 0
    for index = 1,8 do
        local icon = GR_TT_iconList[index]
        local working_hp = getglobal("GRTT_"..icon.."HPPanelTexture1")
        if GR_TT_iconHP[index] > 100 then
            GR_TT_iconHP[index] = 100
        end
        local hp_percent = GR_TT_iconHP[index] / 100
        if GR_TT_targetName[index] ~= "none" then
            currentPullHP = currentPullHP + hp_percent
            totalPullHP = totalPullHP + 1
            if GR_TT_inCombat then
                if GR_TT_totalPullHP < totalPullHP then
                    GR_TT_totalPullHP = totalPullHP
                    UIFrameFlash(getglobal("GRTT_pullHPPanel"), 0.1, 0.1, 0.75, true, 0, 0)
                end
            else
                GR_TT_totalPullHP = totalPullHP
            end
        end
        local new_height = GR_TT_Healthbar100Height * hp_percent
        if new_height == 0 then
            GR_TT_ResizeComponentHeight(working_hp, 0.1)
        else
            GR_TT_ResizeComponentHeight(working_hp, new_height)
        end 
    end
    
    local PullHPPercent = 0
    if totalPullHP ~= 0 then
        PullHPPercent = currentPullHP / GR_TT_totalPullHP
    else
        PullHPPercent = 0.001
    end
    
    local tempTotalBarHeight = getglobal("GRTT_pullHPPanel"):GetTop() - getglobal("GRTT_pullHPPanel"):GetBottom()  - GR_TT_HealthbarYoffset*2
    local newPullHPHeight = (tempTotalBarHeight * PullHPPercent)
    GR_TT_ResizeComponentHeight(getglobal("GRTT_pullHPPanelTexture"), newPullHPHeight)
end