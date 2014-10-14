--[[
        HZ_AutoRepBar
            Automatically changes your rep bar to the chosen faction for the current zone

        By: Ben "HunterZ" Shadwick (Hevanus of Eldre'Thalas)
        Special Thanks: Dawnwater (Diplomat addon, main inspiration for this addon)
                        Minitr of Eldre'Thalas (testing)
                        Denizens of the WoW UI forum (ideas and suggestions)
                        ui.worldofwar.net users (feedback)
                        wowwiki.com contributors (lots of ideas)
                        MetaHawk/Urshurak (MetaMap addon, used as reference for UIDropDownMenu stuff)

        Long Description:
        This addon records which zones the user has visited and allows the player to choose which faction to display a reputation
        bar for each known zone. In the case that the player has not assigned a faction to a known zone, the addon will assign the
        first faction with which the player gains reputation while in that zone. This should allow the addon to configure itself
        without any input from the player, although the Reputation tab on the Character menu can be used to override settings for
        the current zone.

        Notes:
        Note that settings are currently saved globally, which means that this addon will try to use the same settings for all
        characters on all realms. I may eventually implement saving a separate set of data per character if people report issues
        with the current behavior.

        License:
        Feel free to use the code from this addon for your own ends. Just be sure to give me credit, and contact me so I know what
        people are doing with it :)

        Version History:
            1.10-1 - Internal version (not released)
            1.10-2 - (21 May 2006) Testing release
            1.10-3 - (21 May 2006) Testing release
                     - replaced UPDATE_FACTION logic with a SetWatchedFactionIndex() hook
                     - commented out some debugging messages (now that things are more stable)
                     - commented out Chronos-dependent code, as it doesn't seem to be needed after all
                     - fixed a bug with the handling of the user changing the selected faction (put logic inside a loop that
                       should have come after - whoops!)
                     - now turns off rep bar when current zone's faction is set to "Auto". This is needed to prevent the addon
                       from thinking that the user manually selected a faction when the next zone change occurs (if too many
                       people complain, I may be able to add additional logic to preserve the same behavior while leaving the
                       rep bar always enabled)
                     - refactored a lot of code
            1.10-4 - (22 May 2006) Public testing release
                     - new rep change handling logic: if gained/lost rep with a faction other than the one assigned to the current
                       zone, and if the currently assigned faction was automatically assigned (as opposed to being assigned by the
                       user), make the new faction the assigned faction for the current zone. This should result in more useful
                       behavior for zones in which rep can change for more than one faction
                     - more refactoring of code
            1.10-5 - (30 May 2006) Public testing release
                     - Made rep change only trigger update message if the zone's faction actually changes as a result
                     - Initial post-variables-loaded processing now triggers from PLAYER_ENTERING_WORLD instead of
                       VARIABLES_LOADED, which...didn't help as much as I thought (oh well - leaving it as is for now)
                     - Added recording of last zone to prevent duplicate messages
                     - Used UPDATE_FACTION to trigger an initial message if needed, as it seems to get fired a lot on both login 
                       and UI reload
                     - More checking for nil/blank zone names to prevent confusion and/or savedVariables clutter
            1.10-6 - (03 Jun 2006) First public release
                     - Releasing to ui.worldofwar.net
                     - I don't think anything significant has changed except for the version number
            1.11-1 - (22 Jun 2006) Alpha 3 release
                     - Updated TOC for 1.11 patch compatibility
                     - Fixed unfriendly message when player manually overrides settings via reputation tab of character menu
                     - Added GUI config/options frame (currently non-functional) and slash commands
                     - Fixed error reported by tieum, in which a status message was trying to display nonsense data when a
                       faction was assigned to the current zone that is not known by the current character
                     - Defaulted zone change status messages to disabled (change HZARB_Vars.showZoneMessage to true to turn 
                       them back on for now; eventually this will be toggled via the config GUI)
                     - Show status message by default on bar changed to different faction (requested by Thortok2000)
                       
        TO DO:
            - Try moving data to a sub-list for each zone, using GetMinimapZoneText() on MINIMAP_ZONE_CHANGED (test with instances and maybe BGs)
            - Implement a way to toggle status messages (either slash command or menu frame)
               - Checkboxes in place; create variables and have the checkboxes toggle them
            - Consider leaving rep bar always enabled (possibly create a slash command to make this user-selectable behavior)
               - Checkbox in place; need to add variable and logic
            - Consider making a GUI window frame that lets the user change settings for every known zone, instead of just the 
              current one
]]--

--[[
        HZARB_Settings savedVariable contents:
        HZARB_Settings["ZoneList"][<zoneName>][<minimapZoneName>]["FactionName"]  - name of faction assigned to zone <zoneName>
                                                                 ["Locked"] - 1 if faction setting should never be changed for this zone
        };
]]--

-- variables unique to this addon
-- may want to add local tag at some point, but it shouldn't hurt to make these visible to other addons
HZARB_Vars = {
    currentFaction = nil;
    currentZone = nil;
    factionName = nil;
    factionWatched = nil;
    foundMatch = false;
    lastFaction = "Auto";
    lastZone = "None";
    numFactions = 0;
    registered = false;
    showFactionMessage = false;
    showMessage = false;
    showZoneMessage = false;
    zoneFaction = nil;
};

-- local pointer to original SetWatchedFactionIndex(), since we hook it
local SavedSetWatchedFactionIndex;

--[[
        OnLoad() handler:
            - Hook OnEvent() to zone change event
            - Hook savedVariables loaded event
            - Hook faction/reputation changed chat message event
]]--
function HZARB_OnLoad()
--    DEFAULT_CHAT_FRAME:AddMessage("HZ_AutoRepBar: Player faction is " .. UnitFactionGroup("player"), 0.2, 0.8, 0.2, 1.0)

    -- Save original SetWatchedFactionIndex() so that we can hook it
    SavedSetWatchedFactionIndex = SetWatchedFactionIndex;

    -- Note that nothing more can be done until savedVariables have been loaded (see OnEvent() hander for VARIABLES_LOADED)
    this:RegisterEvent("PLAYER_ENTERING_WORLD")

    this:RegisterEvent("ZONE_CHANGED")
    this:RegisterEvent("MINIMAP_ZONE_CHANGED")
    this:RegisterEvent("ZONE_CHANGED_INDOORS")

    -- Register slash command(s) and handler
    SLASH_HZ_AutoRepBar1 = "/hzarb"
    SlashCmdList["HZ_AutoRepBar"] = HZARB_Command;

    DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar |cFF11FF11v1.11-1|cFF119911 loaded. Type |cFF11FF11/hzarb|cFF119911 for options.|r")
end

--[[
        Handle registered events
]]--
function HZARB_OnEvent()
    HZARB_Vars.showMessage = false
    HZARB_Vars.currentZone = GetRealZoneText()

--    DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar: Called by event=" .. event .. "|r")

    --[[
            Handle savedVariables loaded event:
                - Initialize settings data structure if empty

            Note that VARIABLES_LOADED is hooked instead of ADDON_LOADED because the latter seems to get called multiple times in WoW 1.10

            Handle faction/reputation changed chat message event:
                - Abort if current zone already has a faction (other than "Auto") set
                - Parse message to find out which faction
                - Also proceed as if a zone change has taken place so that the proper rep bar will be set if the current zone's faction changed from "Auto"
    ]]--
    if (event == "PLAYER_ENTERING_WORLD") then
        -- no settings exist at all
        if (not HZARB_Settings) then
            HZARB_Settings = {}
        end

        -- no ZoneList data exists
        if (not HZARB_Settings["ZoneList"]) then
            HZARB_Settings["ZoneList"] = {}
        end

        -- Don't want to catch these events until now that variables are loaded
        this:RegisterEvent("ZONE_CHANGED_NEW_AREA")
        this:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
        
        -- The following is a kludge to cause an initial message/bar change on UI reload, as (unlike when logging in) a zone change is not triggered in this case
        this:RegisterEvent("UPDATE_FACTION")
        HZARB_Vars.registered = true
        
        -- Hook SetWatchedFactionIndex() to detect user changes
        SetWatchedFactionIndex = HZARB_SetWatchedFactionIndex

        if (currentZone == nil or currentZone == "") then
            HZARB_Vars.lastZone = "None"
            return
        else
            HZARB_Vars.showMessage = true
        end
    elseif (event == "CHAT_MSG_COMBAT_FACTION_CHANGE" and HZARB_Vars.currentZone ~= nil) then
        -- First, see if there's any data on the current zone, and populate it if there isn't
        if (HZARB_Settings["ZoneList"][HZARB_Vars.currentZone] == nil) then
            HZARB_Settings["ZoneList"][HZARB_Vars.currentZone] = {}
            HZARB_Settings["ZoneList"][HZARB_Vars.currentZone]["FactionName"] = "Auto"
            HZARB_Settings["ZoneList"][HZARB_Vars.currentZone]["AutoAssigned"] = true
        end

        -- If current zone's faction was not assigned by the player, reassign it to the faction whose rep just changed
        if (HZARB_Settings["ZoneList"][HZARB_Vars.currentZone]["AutoAssigned"] == true) then
            -- Look for XXX in "Your reputation with XXX has YYY. (AAA reputation BBB)"
            -- Easiest way is to loop through known factions and see which one is in arg1
            HZARB_Vars.numFactions = GetNumFactions()

            for factionIndex = 1, (HZARB_Vars.numFactions) do
                HZARB_Vars.factionName = GetFactionInfo(factionIndex)
                if (string.find(arg1, HZARB_Vars.factionName) ~= nil) then
                    -- found the faction whose rep changed - set current zone to show that rep, but only if it changed
                    if (HZARB_Vars.factionName ~= HZARB_Settings["ZoneList"][HZARB_Vars.currentZone]["FactionName"]) then
                        HZARB_Settings["ZoneList"][HZARB_Vars.currentZone]["FactionName"] = HZARB_Vars.factionName

                        -- show status message as a result of change
                        HZARB_Vars.showMessage = true
                    end

                    break
                end
            end
        end
    elseif (event == "ZONE_CHANGED" or event == "MINIMAP_ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS") then
        --[[DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar:                event=" ..                event .. "|r")
        DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar:    GetRealZoneText()=" ..    GetRealZoneText() .. "|r")
        DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar:     GetSubZoneText()=" ..     GetSubZoneText() .. "|r")
        DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar: GetMinimapZoneText()=" .. GetMinimapZoneText() .. "|r")
        ]]--
        return
    else
        -- Just a simple zone change or other event
        -- Abort if we can't figure out the current zone at this point or if something other than a zone change triggered this
        if (HZARB_Vars.currentZone == nil or HZARB_Vars.currentZone == "" or HZARB_Vars.currentZone == HZARB_Vars.lastZone) then
            return
        end
        
        HZARB_Vars.showMessage = true
        
        -- If this was triggered by something other than a zone change, unregister whatever we've hooked as additional triggers
        if (HZARB_Vars.registered == true) then
            this:UnregisterEvent("UPDATE_FACTION")
        end
    end

    -- Handle a zone change (or addon load)
    -- First, check the case that the current zone has never been seen
    if (HZARB_Settings["ZoneList"][HZARB_Vars.currentZone] == nil) then
        -- Initialize current zone to "Auto" mode, which will flag it to be reassigned to the first faction from which the player gains rep while in this zone
        HZARB_Settings["ZoneList"][HZARB_Vars.currentZone] = {}
        HZARB_Settings["ZoneList"][HZARB_Vars.currentZone]["FactionName"] = "Auto"
        HZARB_Settings["ZoneList"][HZARB_Vars.currentZone]["AutoAssigned"] = true
        HZARB_Vars.lastFaction = HZARB_Vars.currentFaction
        SavedSetWatchedFactionIndex(0)
        HZARB_Vars.currentFaction = "Auto"
    else
        -- Have seen this zone before; set the rep bar to the appropriate faction (or leave it at current setting if zone's faction is "Auto")
        HZARB_Vars.zoneFaction = HZARB_Settings["ZoneList"][HZARB_Vars.currentZone]["FactionName"]

        -- If faction is not "Auto", find its index and set it as watched
        if (HZARB_Vars.zoneFaction ~= "Auto") then
            HZARB_Vars.numFactions = GetNumFactions()
            HZARB_Vars.foundMatch = false

            for factionIndex = 1, HZARB_Vars.numFactions do
--            DEFAULT_CHAT_FRAME:AddMessage("HZ_AutoRepBar: Faction " .. factionIndex .. " of " .. HZARB_Vars.numFactions .. " is " .. GetFactionInfo(factionIndex), 0.2, 0.8, 0.2, 1.0)
                if (GetFactionInfo(factionIndex) == HZARB_Vars.zoneFaction) then
                    HZARB_Vars.lastFaction = HZARB_Vars.currentFaction
                    SavedSetWatchedFactionIndex(factionIndex)
                    HZARB_Vars.currentFaction = HZARB_Vars.zoneFaction
                    HZARB_Vars.foundMatch = true
                    break
                end
            end

            -- Capture condition where a faction is stored that the player doesn't know (probably due to having an alt of opposing player faction)
            if (HZARB_Vars.foundMatch == false) then
                HZARB_Vars.lastFaction = HZARB_Vars.currentFaction
                SavedSetWatchedFactionIndex(0)
                HZARB_Vars.currentFaction = "Auto"
--                HZARB_Vars.showMessage = false

                if (HZARB_Vars.currentFaction ~= HZARB_Vars.lastFaction) then
                    DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar: Zone changed to |cFF11FF11" .. HZARB_Vars.currentZone .. "|cFF119911, but rep bar disabled because faction |cFF11FF11" .. HZARB_Settings["ZoneList"][HZARB_Vars.currentZone] .. "|cFF119911 is not in this character's known factions list.|r")
                    HZARB_Vars.showMessage = false
                end
            end
        else
            -- Zone's faction is set to "Auto"; hide the rep bar
            HZARB_Vars.lastFaction = HZARB_Vars.currentFaction
            SavedSetWatchedFactionIndex(0)
            HZARB_Vars.currentFaction = "Auto"
        end
    end

    -- only show status message if it was flagged (used to suppress status display on faction gain/loss when current zone's faction already set to other than "Auto"
 --   if (HZARB_Vars.showMessage == true and (HZARB_Vars.currentFaction ~= HZARB_Vars.lastFaction)) then
 --       DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar: Zone changed to |cFF11FF11" .. HZARB_Vars.currentZone .. "|cFF119911, rep bar changed to |cFF11FF11" .. HZARB_Settings["ZoneList"][HZARB_Vars.currentZone]["FactionName"] .. "|r")
  --  end

    -- record current zone for later comparison when needed
    HZARB_Vars.lastZone = HZARB_Vars.currentZone
end

-- Wrapper for hooking SetWatchedFactionIndex() so that calls to it can be captured
function HZARB_SetWatchedFactionIndex(index)
    -- Pass on to original function
    SavedSetWatchedFactionIndex(index)

    -- Record result
    HZARB_Vars.currentZone = GetRealZoneText()

    HZARB_Vars.factionName,_,_,_,_,_,_,_,_,_,HZARB_Vars.factionWatched = GetFactionInfo(index)

    if (index == 0) then
        HZARB_Settings["ZoneList"][HZARB_Vars.currentZone]["FactionName"] = "Auto"
        HZARB_Settings["ZoneList"][HZARB_Vars.currentZone]["AutoAssigned"] = true

        DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar: Turning off rep bar and clearing faction setting for zone |cFF11FF11" .. HZARB_Vars.currentZone .. "|r")
    elseif (HZARB_Settings["ZoneList"][HZARB_Vars.currentZone] ~= HZARB_Vars.factionName) then
        HZARB_Settings["ZoneList"][HZARB_Vars.currentZone]["FactionName"] = HZARB_Vars.factionName
        HZARB_Settings["ZoneList"][HZARB_Vars.currentZone]["AutoAssigned"] = false
        
        DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar: Rep bar manually locked to faction |cFF11FF11" .. HZARB_Vars.factionName .. "|cFF119911 for zone |cFF11FF11" .. HZARB_Vars.currentZone .. "|r")
    end
end

-- Handle slash commands
function HZARB_Command(cmd)
    if(cmd == "config") then
        -- toggle config frame
        if(HZARB_AutoRepBarForm:IsShown()) then
            HZARB_AutoRepBarForm:Hide()
        else
            HZARB_AutoRepBarForm:Show()
        end
    elseif(cmd == "resetpos") then
        -- reset position
        getglobal("HZARB_AutoRepBarForm"):ClearAllPoints()
        getglobal("HZARB_AutoRepBarForm"):SetPoint("CENTER","UIParent","CENTER",0,0)
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar: The following options are available:|r")
        DEFAULT_CHAT_FRAME:AddMessage("|cFF11FF11               /hzarb config|cFF119911 	- toggle options menu|r")
        DEFAULT_CHAT_FRAME:AddMessage("|cFF11FF11               /hzarb resetpos|cFF119911 	- reset options menu position|r")
    end
end

-- Perform initialization for config frame
function HZARB_FormLoad()
    -- add the config frame to the UISpecialFrames table, which allows the frame to be closed via the escape key
    tinsert(UISpecialFrames,"HZARB_AutoRepBarForm")
--    this:RegisterEvent("VARIABLES_LOADED")
end

-- Populate config menu elements with current general and curent zone-specific settings when menu is made visible
function HZARB_FormShow()
    this:SetFrameStrata("DIALOG")
    
    -- Clear the dropdowns
    UIDropDownMenu_Initialize(HZARB_ZoneDropDown, HZARB_ZoneDropDownInit)
end

-- Initialize DropDowns
function HZARB_ZoneDropDownInit()
    DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar: HZARB_ZoneDropDownInit() called|r")
    UIDropDownMenu_ClearAll(HZARB_ZoneDropDown)

    -- copy zone list to local table for sorting (sorting in place doesnt seem to work)
    local zoneList = {}
    local zoneCounter = 1
    for zoneName in HZARB_Settings["ZoneList"] do
        table.insert(zoneList, zoneName)
        DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar: Inserted " .. zoneName .. " (" .. zoneList[zoneCounter] .. ")|r")
        zoneCounter = zoneCounter + 1
    end

    table.sort(zoneList)

    zoneCounter = 1
    for zoneName in zoneList do
        local info = {
            text = zoneList[zoneCounter];
            value = zoneCounter;
            func = HZARB_DropDownClick;
        };
        UIDropDownMenu_AddButton(info)
        DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar: Added " .. zoneList[zoneCounter] .. "|r")
        zoneCounter = zoneCounter + 1
    end

    UIDropDownMenu_Initialize(HZARB_SubZoneDropDown, HZARB_SubZoneDropDownInit)
end

function HZARB_CompareStrings(a,b)
    if (a < b) then
        DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar: " .. a .. " less than " .. b .. "|r")
        return true
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar: " .. a .. " greater than " .. b .. "|r")
        return false
    end
end

function HZARB_SubZoneDropDownInit()
    DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar: HZARB_SubZoneDropDownInit() called|r")
    
    UIDropDownMenu_ClearAll(HZARB_SubZoneDropDown)

    UIDropDownMenu_Initialize(HZARB_FactionDropDown, HZARB_FactionDropDownInit)
end

function HZARB_FactionDropDownInit()
    DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar: HZARB_FactionDropDownInit() called|r")

    UIDropDownMenu_ClearAll(HZARB_FactionDropDown)
end

-- Handle config frame events
function HZARB_FormEvent()
    DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar: HZARB_FormEvent() called by event=" .. event .. "|r")
end

-- Handle check button clicks
--[[ Check button ids:
     1 - show status message on zone change 
     2 - show status message on rep change
     3 - lock selected zone faction setting (i.e., set auto=false)
     4 - hide bar (set faction 0) when no setting exists for current zone (otherwise, keep showing last setting) ]]--
function HZARB_CheckButtonClick()
    local id = this:GetID()
    local checked = this:GetChecked()
    if (checked == nil) then
       checked = "nil"
    end
    DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar: CheckButton id=" .. id .. " checked=" .. checked .. "|r")
end

-- Handle dropdown clicks
--[[ Dropdown ids:
     1 - Zone
     2 - Sub-Zone
     3 - Faction
]]--
function HZARB_DropDownClick()
    local id = this:GetID()
    DEFAULT_CHAT_FRAME:AddMessage("|cFF119911HZ_AutoRepBar: DropDown id=" .. id .. " was clicked|r")
end
