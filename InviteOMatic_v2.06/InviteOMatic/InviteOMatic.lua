------------------------------------------------------------------------
-- InviteOMatic
--
-- InviteOMatic is an invite mod, both for BG's and
-- for everyday party inviting for friends.
-- @author Gof (Tait of Aszune)
------------------------------------------------------------------------

------------------------------------------------------------------------
-- Variables
------------------------------------------------------------------------

InviteOMaticOptions = {}; -- SavedVariable used to capture state between sessions

local version = "v2.01"; -- Version number of InviteOMatic
local ready = false; -- The ready status of the addon
local bgActive = false; -- Are we currently in a BG?
local activeBGIndex = -1; -- Index of the active BG
local updateInviteTimer = false;
local firstInvite = true;
local inviteTimer = 0;
local showingOptions = false;

-- Lists for already in group, decline and ignore
local aigList = {};
local aigErrorList = {};
local ignoreList = {};
local declineList = {};

-- Variables for Who lookups
local doWhois = false;
local whoName = "---";
local whoInviter = "---";

-- Default strings
local defaultFirstInviteSpam = "["..IOM_STRING_TITLE.."] "..IOM_STRING_INVITESPAM;
local defaultAIGSpam = "["..IOM_STRING_TITLE.."] "..IOM_STRING_AIGSPAM;
-- Regular expression for magic word
local defaultInviteRegExp = "[iI][nN][vV][iI][tT][eE]";

------------------------------------------------------------------------
-- OnLoad() is called when the addon is first loaded
------------------------------------------------------------------------
function InviteOMatic_OnLoad()
    --Register necessary events
    this:RegisterEvent("VARIABLES_LOADED");

    -- This event is always needed to check status of battlefields
    this:RegisterEvent("UPDATE_BATTLEFIELD_STATUS");
end

------------------------------------------------------------------------
-- OnUpdate() Is called on every frame update
--
-- @param dt is the delta time since last OnUpdate() call
------------------------------------------------------------------------
function InviteOMatic_OnUpdate(dt)
    if( InviteOMatic_IsDisabled() ) then
        return;
    end
    
    if( dt == nil ) then
        return;
    end
    
    if( updateInviteTimer ) then
        inviteTimer = inviteTimer - dt;
        if( inviteTimer <= 0 ) then
            InviteOMatic.debug("Invite Timer fired...");
            inviteTimer = InviteOMaticOptions["inviteDelay"];
            if( InviteOMaticOptions["autoInvite"] ) then
                InviteOMatic_SendInvites();
            end
        end
    end
end

------------------------------------------------------------------------
-- OnEvent() is called each time an event is triggered
--
-- @param event is the event that triggered
------------------------------------------------------------------------
function InviteOMatic_OnEvent()
    
    -- VARIABLES_LOADED event triggered (Our addon is now ready to be started)
    if( event == "VARIABLES_LOADED" ) then
        InviteOMatic_VariablesLoaded();

    -- CHAT_MSG_WHISPER event arrived
    elseif( event == "CHAT_MSG_WHISPER" ) then
        InviteOMatic_WhisperEvent(arg1, arg2);
    
    -- UPDATE_BATTLEFIELD_STATUS triggered, check if we entered/left a BG
    elseif( event == "UPDATE_BATTLEFIELD_STATUS" ) then
        InviteOMatic_BGEvent();
    
    -- WHO_LIST_UPDATE event triggered
    elseif( event == "WHO_LIST_UPDATE" ) then
        InviteOMatic_WhoEvent();

    -- CHAT_MSG_SYSTEM event triggered
    elseif( event == "CHAT_MSG_SYSTEM" ) then
        InviteOMatic_ChannelSystem(arg1);

    end
end

------------------------------------------------------------------------
-- Loads the values from the saved variable, and creates new ones
-- where none are found or where errors occur
------------------------------------------------------------------------
function InviteOMatic_VariablesLoaded()
    -- Unregister VARIABLES_LOADED event, as its not needed anymore
    this:UnregisterEvent("VARIABLES_LOADED");
    
    -- Recreate missing values of the saved variable
    
    if( InviteOMaticOptions == nil ) then
        InviteOMaticOptions = {};
    end

    if( type(InviteOMaticOptions) ~= "table" ) then
        InviteOMaticOptions = {};
    end

    if( InviteOMaticOptions["disabled"] == nil ) then
        InviteOMaticOptions["disabled"] = false;
    end
    
    if( InviteOMaticOptions["autoInvite"] == nil ) then
        InviteOMaticOptions["autoInvite"] = true;
    end

    if( InviteOMaticOptions["whisperInvite"] == nil ) then
        InviteOMaticOptions["whisperInvite"] = true;
    end

    if( InviteOMaticOptions["debug"] == nil ) then
        InviteOMaticOptions["debug"] = false;
    end

    if( InviteOMaticOptions["inviteMsg"] == nil ) then
        InviteOMaticOptions["inviteMsg"] = defaultFirstInviteSpam;
    end

    if( InviteOMaticOptions["aigMsg"] == nil ) then
        InviteOMaticOptions["aigMsg"] = defaultAIGSpam;
    end

    if( InviteOMaticOptions["magicWord"] == nil ) then
        InviteOMaticOptions["magicWord"] = defaultInviteRegExp;
    end

    if( InviteOMaticOptions["guiShown"] == nil ) then
        InviteOMaticOptions["guiShown"] = true;
    end

    if( InviteOMaticOptions["minimized"] == nil ) then
        InviteOMaticOptions["minimized"] = false;
    end

    if( InviteOMaticOptions["ignoreList"] == nil ) then
        InviteOMaticOptions["ignoreList"] = {};
    end
    
    if( InviteOMaticOptions["aigttl"] == nil ) then
        InviteOMaticOptions["aigttl"] = 10;
    end

    if( InviteOMaticOptions["declinettl"] == nil ) then
        InviteOMaticOptions["declinettl"] = 1;
    end

    if( InviteOMaticOptions["ignorettl"] == nil ) then
        InviteOMaticOptions["ignorettl"] = 1;
    end

    if( InviteOMaticOptions["sendInviteSpam"] == nil ) then
        InviteOMaticOptions["sendInviteSpam"] = true;
    end

    if( InviteOMaticOptions["sendAIGSpam"] == nil ) then
        InviteOMaticOptions["sendAIGSpam"] = true;
    end

    if( InviteOMaticOptions["inviteDelay"] == nil ) then
        InviteOMaticOptions["inviteDelay"] = 10;
    end

    if( InviteOMaticOptions["guiShown"] ) then
        InviteOMatic_ShowGUI();
    end

    if( InviteOMaticOptions["autoInvite"] ) then
        local button = getglobal("InviteOMaticForm".."ButtonPanel".."InviteButton".."Text");
        button:SetText("Disable Autoinvite");
    else
        local button = getglobal("InviteOMaticForm".."ButtonPanel".."InviteButton".."Text");
        button:SetText("Enable Autoinvite");
    end
    
    if( InviteOMaticOptions["whisperInvite"] ) then
        local button = getglobal("InviteOMaticForm".."ButtonPanel".."WhisperButton".."Text");
        button:SetText("Disable Whisperinvite");
    else
        local button = getglobal("InviteOMaticForm".."ButtonPanel".."WhisperButton".."Text");
        button:SetText("Enable Whisperinvite");
    end

    if( InviteOMaticOptions["minimized"] ) then
        local panel = getglobal("InviteOMaticForm".."ButtonPanel");
        panel:Hide();
    else
        local panel = getglobal("InviteOMaticForm".."ButtonPanel");
        panel:Show();
    end

    -- Register event that fires when player receives a whisper
    this:RegisterEvent("CHAT_MSG_WHISPER");

    -- Enable /iom slashcommand
    SlashCmdList["IOM"] = InviteOMatic_SlashHandler;
    SLASH_IOM1 = "/iom";

    -- Addon now fully loaded, set ready flag
    ready = true;
    
    InviteOMatic.log(version.." "..IOM_STRING_LOADED);
end

------------------------------------------------------------------------
-- Handles slashcommand events for InviteOMatic
--
-- @param msg The slash command message
------------------------------------------------------------------------
function InviteOMatic_SlashHandler(msg)

    local oldmsg = msg; -- Save original message
    msg = string.lower(msg); -- Make all characters lowercase
    
    -- Extract the option and value of the slash command
    _, _, option, value = string.find(msg, "(%w*)%s*(%w*)");
    
    if( InviteOMatic_IsDisabled() ) then
        if( option ~= "enable" ) then
            InviteOMatic.log(IOM_STRING_ADDON_DISABLED);
            return;
        end
    end

    -- Find which option and handle accoringly
    if( option == "" ) then
        -- /iom
        if( InviteOMaticOptions["guiShown"] ) then
            InviteOMaticOptions["guiShown"] = false;
            InviteOMatic_HideGUI();
        else
            InviteOMaticOptions["guiShown"] = true;
            InviteOMatic_ShowGUI();
        end
    
    elseif( option == "enable" ) then
        InviteOMaticOptions["disabled"] = false;
        InviteOMatic.log(IOM_STRING_ENABLED);
    
    elseif( option == "disable" ) then
        InviteOMaticOptions["disabled"] = true;
        InviteOMatic.log(IOM_STRING_DISABLED);

    elseif( option == "debug" ) then
        InviteOMaticOptions["debug"] = not InviteOMaticOptions["debug"];
        InviteOMatic.log("Toggling debug: "..tostring(InviteOMaticOptions["debug"]));

    elseif( option == "resetaiglist" ) then
        InviteOMatic_ResetAIG();

    elseif( option == "resetdeclinelist" ) then
        InviteOMatic_ResetDecline();
        
    elseif( option == "resetignorelist" ) then
        InviteOMatic_ResetIgnore();
        
    else
        -- /iom unknownoption
        InviteOMatic.log(IOM_STRING_UNKNOWN_OPTION.." "..option);
    end
    
end

------------------------------------------------------------------------
-- Convert the group to a raid
------------------------------------------------------------------------
function InviteOMatic_MakeRaid()
    if( InviteOMatic_IsDisabled() ) then
        return;
    end

    if( (GetNumRaidMembers() == 0) and IsPartyLeader() ) then
        ConvertToRaid();
    end
end

------------------------------------------------------------------------
-- Function to handle whisper events
--
-- @param text the whispered text
-- @param name the name of the person whispering
------------------------------------------------------------------------
function InviteOMatic_WhisperEvent(text, name)
    if( InviteOMatic_IsDisabled() ) then
        return;
    end
    
    --If whisper invites isnt enabled, just return
    if( not InviteOMaticOptions["whisperInvite"] ) then
        return;
    end

    InviteOMatic.debug("Whisper event received.");
    
    --Check if tell contains the magic word invite
    
    local oldS = 1;
    local count = 0;
    local first = true;
    
    local matches = {};
    
    while true do
        
        sStart, sEnd = string.find(InviteOMaticOptions["magicWord"], "%s", oldS);
        
        if( sStart == nil ) then
            if( first ) then
                table.insert(matches, InviteOMaticOptions["magicWord"]);
            else
                table.insert(matches, string.sub(InviteOMaticOptions["magicWord"], oldS));
            end
            break;
        end
        
        table.insert(matches, string.sub(InviteOMaticOptions["magicWord"], oldS, sStart-1));
       
        oldS = sEnd+1;
        count = count + 1;
        first = false;
    end

    for match in matches do
        InviteOMatic.debug("Checking magic word: "..matches[match]);
        sStart, sEnd = string.find(text, matches[match]);
        if( sStart ~= nil ) then

            local nextChar = string.sub(text, sEnd+1, sEnd+1);
            InviteOMatic.debug("Next char: ("..nextChar..")");
            if( nextChar ~= " " ) then
                InviteOMatic.debug("Magic word was part of a bigger word!!");
                
                -- Must find something smart to do here....
                
                -- continue;
            end

            --Check if the word just after invite is a player
            sStart2, sEnd2 = string.find(text, "%s[^%s%?%.!]+", sEnd);

            if( sStart2 ~= nil ) then
                local foundName = string.lower( string.sub(text, sStart2+1, sEnd2) );

                if( foundName == "me" or foundName == "please" or foundName == "plz" or foundName == "plez" or foundName == "pleaz") then
                    InviteOMatic_ClearNameFromList(name);
                    InviteOMatic_Invite(name);
                    return;
                else
                    doWhois = true;

                    this:RegisterEvent("WHO_LIST_UPDATE");
                    FriendsFrame:UnregisterEvent("WHO_LIST_UPDATE");
                    SetWhoToUI(1);

                    -- Do lookup via Who command.
                    whoName = string.lower(foundName);
                    whoInviter = name;

                    SendWho("n-\""..foundName.."\"");
                    return;
                end
            else
                InviteOMatic_ClearNameFromList(name);
                InviteOMatic_Invite(name);
                return;
            end
        end
    end
end

------------------------------------------------------------------------
-- Function to handle who events
------------------------------------------------------------------------
function InviteOMatic_WhoEvent()
    if( doWhois ) then 
    
        InviteOMatic.debug("Who event!");

        local invited = false;

        -- We saw our who, so reset everything back

        SetWhoToUI(0);
        FriendsFrame:RegisterEvent("WHO_LIST_UPDATE");          
        this:UnregisterEvent("WHO_LIST_UPDATE");
        doWhois = false;
        
        -- Now process the who list
        local length = GetNumWhoResults();
        
        for i=1,length do
            charname, guildname, level, race, class, zone, unknown = GetWhoInfo(i);
            
            charname = string.lower(charname);
            
            if( charname == whoName ) then
                InviteOMatic_ClearNameFromList(whoName);
                InviteOMatic_Invite(whoName);
                invited = true;
            end
        end
        
        if( not invited ) then
            InviteOMatic_ClearNameFromList(whoInviter);
            InviteOMatic_Invite(whoInviter);
        end
        
        -- Done processing, reset variables
        whoName = "---";
        whoInviter = "---";
    end
end

------------------------------------------------------------------------
-- Invite a person, (If checks out)
--
-- @param name person to invite
------------------------------------------------------------------------
function InviteOMatic_Invite(name)
    if( InviteOMatic_IsDisabled() ) then
        return;
    end
    
    if( name == nil ) then
        return;
    end
    
    local lowerName = string.lower(name);
    
    -- If player is on our ignore list, dont invite him
    if( InviteOMaticOptions["ignoreList"][lowerName] == true ) then
        return;
    end
    
    InviteOMatic.debug("Checking invite: ("..name..")");
    
    local ok = InviteOMatic_ShouldInvite(name);
    
    if( ok ) then
        InviteOMatic.debug("("..name..") checked ok, inviting");
        InviteByName(name);
    else    
        InviteOMatic.debug("("..name..") failed check!");
    end
end

------------------------------------------------------------------------
-- A BG event occured, check if we entered/left a BG
------------------------------------------------------------------------
function InviteOMatic_BGEvent()

    local NUMBER_OF_BATTLEFIELDS = 3;

    -- Check if we are already in a BG
    if( not bgActive ) then
        for i=1,NUMBER_OF_BATTLEFIELDS do
        status, mapName, instanceID = GetBattlefieldStatus(i);
            
            -- We have entered a BG
            if( status == "active" ) then
                InviteOMatic_EnteredBG(i);
            end
        end
    else
        status, mapName, instanceID = GetBattlefieldStatus(activeBGIndex);
        if( status ~= "active" ) then
            -- You have left BG
                InviteOMatic_LeftBG(activeBGIndex);
        end
    end
end

------------------------------------------------------------------------
-- We entered a BG
--
-- @param i the index of the entered BG
------------------------------------------------------------------------
function InviteOMatic_EnteredBG(i)
    -- Save the index of the active BG
    activeBGIndex = i;
    bgActive = true;

    status, mapName, instanceID = GetBattlefieldStatus(activeBGIndex);
    
    local runtime = GetBattlefieldInstanceRunTime();
    
    InviteOMatic.debug("You entered "..mapName.." Runtime: "..runtime);
    
    if( InviteOMaticOptions["autoInvite"] ) then
        updateInviteTimer = true;
    end
    
    this:RegisterEvent("CHAT_MSG_SYSTEM");
end

------------------------------------------------------------------------
-- We left a BG
--
-- @param i the index of the left BG
------------------------------------------------------------------------
function InviteOMatic_LeftBG(i)
    -- Clear the index of the active BG
    activeBGIndex = -1;
    bgActive = false;
    firstInvite = true;

    InviteOMatic_ClearLists();

    groupBugList = {};
    
    InviteOMatic.debug("You left the BattleGround");
    
    updateInvitePurger = false;

    this:UnregisterEvent("CHAT_MSG_SYSTEM");
end

------------------------------------------------------------------------
-- Checks the ready status of the addon
--
-- @return true/false depending on the ready status of the addon
------------------------------------------------------------------------
function InviteOMatic_IsReady()
    return ready;
end

------------------------------------------------------------------------
-- Checks if the addon is disables
--
-- @return true/false depending on enables state of the addon
------------------------------------------------------------------------
function InviteOMatic_IsDisabled()
    if( not InviteOMatic_IsReady() ) then
        return true;
    end
    
    return InviteOMaticOptions["disabled"]; 
end

----------------------------------------------------------------------
-- UI Functions
----------------------------------------------------------------------
function InviteOMatic_ToggleButtons()
    if( InviteOMaticOptions["minimized"] ) then
        InviteOMaticOptions["minimized"] = false;
        local panel = getglobal("InviteOMaticForm".."ButtonPanel");
        panel:Show();
    else
        InviteOMaticOptions["minimized"] = true;
        local panel = getglobal("InviteOMaticForm".."ButtonPanel");
        panel:Hide();
    end
end

function InviteOMatic_CloseGUI()
    InviteOMaticOptions["guiShown"] = false;
    InviteOMatic_HideGUI();
end

function InviteOMatic_ShowGUI()
    InviteOMaticForm:Show();
end

function InviteOMatic_HideGUI()
    InviteOMaticForm:Hide();
end

function InviteOMatic_DragStart()
    InviteOMaticForm:StartMoving();
    InviteOMaticForm.isMoving = true;
end

function InviteOMatic_DragStop()
    InviteOMaticForm:StopMovingOrSizing();
    InviteOMaticForm.isMoving = false;
end

function InviteOMatic_ToggleAutoInvite()
    if( InviteOMaticOptions["autoInvite"] ) then
        InviteOMaticOptions["autoInvite"] = false;
        
        -- Disable autoinviting update and stuff
        updateInviteTimer = false;
        local button = getglobal("InviteOMaticForm".."ButtonPanel".."InviteButton".."Text");
        button:SetText("Enable Autoinvite");
        
    else
        InviteOMaticOptions["autoInvite"] = true;

        -- Enable autoinviting update and stuff
        updateInviteTimer = true;
        local button = getglobal("InviteOMaticForm".."ButtonPanel".."InviteButton".."Text");
        button:SetText("Disable Autoinvite");
        
    end
    
    InviteOMatic.log("Autoinvite: "..tostring(InviteOMaticOptions["autoInvite"]));
end

function InviteOMatic_ToggleWhisperInvite()
    if( InviteOMaticOptions["whisperInvite"] ) then
        InviteOMaticOptions["whisperInvite"] = false;
        
        -- Disable whisperinviting
        local button = getglobal("InviteOMaticForm".."ButtonPanel".."WhisperButton".."Text");
        button:SetText("Enable Whisperinvite");
        
    else
        InviteOMaticOptions["whisperInvite"] = true;

        -- Enable whisperinviting
        local button = getglobal("InviteOMaticForm".."ButtonPanel".."WhisperButton".."Text");
        button:SetText("Disable Whisperinvite");
        
    end
    
    InviteOMatic.log("Whisperinvite: "..tostring(InviteOMaticOptions["whisperInvite"]));
end

----------------------------------------------------------------------
-- Function to handle system messages
----------------------------------------------------------------------
function InviteOMatic_ChannelSystem(arg1)
    if( InviteOMatic_IsDisabled() ) then
        return;
    end

    local name = "";
    
    InviteOMatic.debug("System Msg: "..arg1);

    if( string.find(arg1, "has joined the battle") ) then
        sS, sE = string.find(arg1, "%[");
        sS2, sE2 = string.find(arg1, "%]");
        name = string.sub(arg1,sS+1,sS2-1);
        InviteOMatic_PlayerJoinedBattle(name);

    elseif( string.find(arg1, "has left the battle") ) then
        sS, sE = string.find(arg1, "[^%s%!%?]+");
        name = string.sub(arg1,sS,sE);
        InviteOMatic_PlayerLeftBattle(name);

    elseif( string.find(arg1, "declines your group invitation") ) then
        sS, sE = string.find(arg1, "[^%s%!%?]+");
        name = string.sub(arg1,sS,sE);
        InviteOMatic_PlayerDeclined(name);

    elseif( string.find(arg1, "is ignoring you") ) then
        sS, sE = string.find(arg1, "[^%s%!%?]+");
        name = string.sub(arg1,sS,sE);
        InviteOMatic_PlayerIgnores(name);

    elseif( string.find(arg1, "is already in a group") ) then
        sS, sE = string.find(arg1, "[^%s%!%?]+");
        name = string.sub(arg1,sS,sE);
        InviteOMatic_PlayerAlreadyGrouped(name);

    elseif( string.find(arg1, "joins the party") ) then
        sS, sE = string.find(arg1, "[^%s%!%?]+");
        name = string.sub(arg1,sS,sE);
        InviteOMatic_PlayerJoinedGroup(name);

    elseif( string.find(arg1, "has joined the raid group") ) then
        sS, sE = string.find(arg1, "[^%s%!%?]+");
        name = string.sub(arg1,sS,sE);
        InviteOMatic_PlayerJoinedGroup(name);

    else
        InviteOMatic.debug("Unhandled sysmsg: "..arg1);
    end
end

----------------------------------------------------------------------
-- Player Joined Group
----------------------------------------------------------------------
function InviteOMatic_PlayerJoinedGroup(name)
    if( bgActive ) then
        if( InviteOMaticOptions["autoInvite"] ) then
            InviteOMatic_MakeRaid();
        end
        InviteOMatic_ClearNameFromList(name);
    end
end

----------------------------------------------------------------------
-- Player Joined Battle
----------------------------------------------------------------------
function InviteOMatic_PlayerJoinedBattle(name)
    if( InviteOMaticOptions["autoInvite"] ) then
        InviteOMatic_Invite(name);
    end
end

----------------------------------------------------------------------
-- Player Left Battle
----------------------------------------------------------------------
function InviteOMatic_PlayerLeftBattle(name)
    -- If purge is enabled, then uninvite this player

    if( InviteOMaticOptions["autoPurge"] ) then
        if( IsRaidLeader() or IsRaidOfficer() or IsPartyLeader() ) then
            if( GetNumRaidMembers() == 0 ) then
                for i=1,GetNumPartyMembers() do
                    local partyName = UnitName("party"..tostring(i));
                    if( partyName == name ) then
                        UninviteByName(name);
                        return;
                    end
                end
            else
                for i=1,GetNumRaidMembers() do
                    --Remove player from raid
                    local name2 = GetRaidRosterInfo(i);
                    if( name == name2 ) then
                        UninviteByName(name);
                        return;
                    end
                end
            end
        end
    end
end

----------------------------------------------------------------------
-- Player Declined
----------------------------------------------------------------------
function InviteOMatic_PlayerDeclined(name)
    -- Player declined our group invite
    if( declineList[name] == nil ) then
        declineList[name] = 1;
    else
        declineList[name] = declineList[name] + 1;
        
        if( declineList[name] > InviteOMaticOptions["declinettl"] ) then
            declineList[name] = InviteOMaticOptions["declinettl"];
        end
    end

    InviteOMatic.debug(name.." declined invitation "..(InviteOMaticOptions["declinettl"] - declineList[name]).." retries left");

end

----------------------------------------------------------------------
-- Player Ignores
----------------------------------------------------------------------
function InviteOMatic_PlayerIgnores(name)
    -- Player ignored you
    if( ignoreList[name] == nil ) then
        ignoreList[name] = 1;
    else
        ignoreList[name] = ignoreList[name] + 1;
        
        if( ignoreList[name] > InviteOMaticOptions["ignorettl"] ) then
            ignoreList[name] = InviteOMaticOptions["ignorettl"];
        end
    end

    InviteOMatic.debug(name.." ingored you "..(InviteOMaticOptions["ignorettl"] - ignoreList[name]).." retries left");

end

----------------------------------------------------------------------
-- Player Already in group
----------------------------------------------------------------------
function InviteOMatic_PlayerAlreadyGrouped(name)
    -- Player is already grouped
    if( aigList[name] == nil ) then
        aigList[name] = 1;
    else
        aigList[name] = aigList[name] + 1;
        
        if( aigList[name] > InviteOMaticOptions["aigttl"] ) then
            aigList[name] = InviteOMaticOptions["aigttl"];
        end
    end

    InviteOMatic.debug(name.." was already in group "..(InviteOMaticOptions["aigttl"] - aigList[name]).." retries left");

end

----------------------------------------------------------------------
-- Promotes all memebers of a raid group
----------------------------------------------------------------------
function InviteOMatic_PromoteAll()
    if( InviteOMatic_IsDisabled() ) then
        return;
    end

    if( IsRaidLeader() ) then
        for i=1,GetNumRaidMembers() do
            local name = GetRaidRosterInfo(i);
            PromoteToAssistant(name);
        end
    end
end

----------------------------------------------------------------------
-- Demotes all memebers of a raid group
----------------------------------------------------------------------
function InviteOMatic_DemoteAll()
    if( InviteOMatic_IsDisabled() ) then
        return;
    end

    if( IsRaidLeader() ) then
        for i=1,GetNumRaidMembers() do
            local name = GetRaidRosterInfo(i);
            DemoteAssistant(name);
        end
    end
end

----------------------------------------------------------------------
-- List handling
----------------------------------------------------------------------
function InviteOMatic_ClearLists()
    aigList = {};
    aigErrorList = {};
    ignoreList = {};
    declineList = {};
end

function InviteOMatic_ClearNameFromList(name)
    aigList[name] = nil;
    aigErrorList[name] = nil;
    ignoreList[name] = nil;
    declineList[name] = nil;
end


----------------------------------------------------------------------
-- Disbands the raid / group
----------------------------------------------------------------------
function InviteOMatic_DisbandGroup()
    if( InviteOMatic_IsDisabled() ) then
        return;
    end

    if( IsRaidLeader() or IsRaidOfficer() ) then
        for i=1,GetNumRaidMembers() do
            --Remove player from raid
            local name = GetRaidRosterInfo(i);
            UninviteByName(name);
        end
    end

    if( IsPartyLeader() ) then
        for i=1,GetNumPartyMembers() do
            local name = UnitName("party"..tostring(i));
            UninviteByName(name);
        end
    end
end

function InviteOMatic_Panic()
    if( InviteOMatic_IsDisabled() ) then
        return;
    end

    InviteOMatic.log(IOM_STRING_PANIC);

    InviteOMaticOptions["autoInvite"] = false;
    
    -- Disable autoinviting update and stuff
    updateInviteTimer = false;
    local button = getglobal("InviteOMaticForm".."ButtonPanel".."InviteButton".."Text");
    button:SetText("Enable Autoinvite");
    
    InviteOMatic_DisbandGroup();
end

----------------------------------------------------------------------
-- This function tries to invite everyone that is not already in our group
----------------------------------------------------------------------
function InviteOMatic_SendInvites()
    if( InviteOMatic_IsDisabled() ) then
        return;
    end

    if( not InviteOMaticOptions["autoInvite"] ) then
        return;
    end

    local bfCount = GetNumBattlefieldPositions();
    
    if( bfCount == 0 ) then
        return;
    end

    InviteOMatic.debug("Sending invites - InviteOMatic_SendInvites()");
    
    if( not bgActive ) then
        InviteOMatic.debug("Not in a BG");
        return;
    end
    
    if( not InviteOMatic_ShouldInvite(nil) ) then
        -- We got a negative from ShouldInvite, so we stop here
        return;
    end

    if( firstInvite ) then
        firstInvite = false;

        if( InviteOMaticOptions["sendInviteSpam"] ) then
            SendChatMessage(InviteOMaticOptions["inviteMsg"], "SAY");
        end
    end
    
    -- Convert to raid if any members is in party
    InviteOMatic_MakeRaid();
    
    local count = GetNumBattlefieldPositions(); -- Number of players not in our raid
    
    if( (count > 4) and (GetNumRaidMembers() == 0) ) then
        -- Not a raid yet so only invite 4 people
        count = 5 - GetNumPartyMembers();
    end

    for i=1,count do
        posX, posY, name = GetBattlefieldPosition(i);
        
        InviteOMatic_Invite(name);
    end
end

----------------------------------------------------------------------
-- Should this person be invited? (Do checks)
----------------------------------------------------------------------
function InviteOMatic_ShouldInvite(name)
    if( InviteOMatic_IsDisabled() ) then
        return false;
    end

    -- Check for aig, decline or ignore TTL violation

    if( name ~= nil ) then
      local lowerName = string.lower(name);
    
        if( InviteOMaticOptions["ignoreList"][lowerName] == true ) then
            -- This player is ignored, so dont invite
            InviteOMatic.debug("Player "..charname.." is on ignore list, so will not get invited");
            return false;
        end

        -- Do checks on this specefic name (Will only reject, not accept)
        
        if( aigList[name] and aigList[name] >= InviteOMaticOptions["aigttl"] ) then
            
            if( not aigErrorList[name] ) then
                aigErrorList[name] = true;
                if( InviteOMaticOptions["sendAIGSpam"] ) then
                    SendChatMessage(InviteOMaticOptions["aigMsg"], "WHISPER",this.language,name);
                end
            end
            
            return false;

        end
        if( declineList[name] and declineList[name] >= InviteOMaticOptions["declinettl"] ) then
            return false;
        end
        
        if( ignoreList[name] and ignoreList[name] >= InviteOMaticOptions["ignorettl"] ) then
            return false;
        end
    end 
    
    --Do general checks( Accept and reject )
    
    -- If raid officer or leader then ok
    if( IsRaidLeader() or IsRaidOfficer() or IsPartyLeader() ) then
        return true;
    elseif( bgActive and ((GetNumPartyMembers() > 0) or (GetNumRaidMembers() > 0)) ) then
        --We are in a BG, but not able to invite
        return false;
    end

    return true;
end

----------------------------------------------------------------------
-- Resets AIG list
----------------------------------------------------------------------
function InviteOMatic_ResetAIG()
    if( InviteOMatic_IsDisabled() ) then
        return;
    end

    InviteOMatic.debug("Resetting AIG list...");
    aigList = {};
    aigErrorList = {};
end

----------------------------------------------------------------------
-- Resets DECLINE list
----------------------------------------------------------------------
function InviteOMatic_ResetDecline()
    if( InviteOMatic_IsDisabled() ) then
        return;
    end

    InviteOMatic.debug("Resetting Decline list...");
    declineList = {};
end

----------------------------------------------------------------------
-- Resets IGNORE list
----------------------------------------------------------------------
function InviteOMatic_ResetIgnore()
    if( InviteOMatic_IsDisabled() ) then
        return;
    end

    InviteOMatic.debug("Resetting Ignore list...");
    ignoreList = {};
end

----------------------------------------------------------------------
-- Print A message to the chat
--
-- @param msg the message to print
----------------------------------------------------------------------
function InviteOMatic_PrintMsg(msg)
    if( InviteOMatic_IsDisabled() ) then
        return;
    end

    if (DEFAULT_CHAT_FRAME) then
        DEFAULT_CHAT_FRAME:AddMessage("["..IOM_STRING_TITLE.."] "..msg);
    end
end

----------------------------------------------------------------------
-- Logs the debug msg to the default chat frame
--
-- @param msg The message to output
----------------------------------------------------------------------
function InviteOMatic_PrintDebugMsg(msg)
    if( InviteOMaticOptions["debug"] ) then
        InviteOMatic.log("("..IOM_STRING_DEBUG..")"..msg);
    end
end

----------------------------------------------------------------------
-- Removes all that isnt promoted
----------------------------------------------------------------------
function InviteOMatic_RemoveNonPromoted()
    if( InviteOMatic_IsDisabled() ) then
        return;
    end

    if( IsRaidLeader() or IsRaidOfficer() ) then
        for i=1,GetNumRaidMembers() do
            --Remove player from raid
            local name, rank = GetRaidRosterInfo(i);
            
            if( rank == 0 ) then
                UninviteByName(name);
            end
        end
    end
end

----------------------------------------------------------------------
-- Options Dialog functions
----------------------------------------------------------------------
function InviteOMatic_ToggleOptions()
    if( showingOptions ) then
        showingOptions = false;
        InviteOMaticOptionForm:Hide();
        --hide options
    else
        showingOptions = true;
        InviteOMaticOptionForm:Show();
        --show options
        
        -- Populate all the settings
        local setting = getglobal("InviteOMaticOptionForm".."InvitePanel".."InviteSlider".."Slider");
        setting:SetValue(InviteOMaticOptions["inviteDelay"]);
        setting = getglobal("InviteOMaticOptionForm".."InvitePanel".."InviteSliderLabel".."Label");
        setting:SetText(tostring(InviteOMaticOptions["inviteDelay"]));

        setting = getglobal("InviteOMaticOptionForm".."WordPanel".."WordEdit");
        setting:SetText(InviteOMaticOptions["magicWord"]);

        setting = getglobal("InviteOMaticOptionForm".."SliderPanel".."AIGSlider".."Slider");
        setting:SetValue(InviteOMaticOptions["aigttl"]);
        setting = getglobal("InviteOMaticOptionForm".."SliderPanel".."AIGSliderLabel".."Label");
        setting:SetText(tostring(InviteOMaticOptions["aigttl"]));
        
        setting = getglobal("InviteOMaticOptionForm".."SliderPanel".."DeclineSlider".."Slider");
        setting:SetValue(InviteOMaticOptions["declinettl"]);
        setting = getglobal("InviteOMaticOptionForm".."SliderPanel".."DeclineSliderLabel".."Label");
        setting:SetText(tostring(InviteOMaticOptions["declinettl"]));

        setting = getglobal("InviteOMaticOptionForm".."SliderPanel".."IgnoreSlider".."Slider");
        setting:SetValue(InviteOMaticOptions["ignorettl"]);
        setting = getglobal("InviteOMaticOptionForm".."SliderPanel".."IgnoreSliderLabel".."Label");
        setting:SetText(tostring(InviteOMaticOptions["ignorettl"]));

        setting = getglobal("InviteOMaticOptionForm".."CheckPanel".."PurgeCheck");
        setting:SetChecked(InviteOMaticOptions["autoPurge"]);

        setting = getglobal("InviteOMaticOptionForm".."CheckPanel".."InviteCheck");
        setting:SetChecked(InviteOMaticOptions["autoInvite"]);

        setting = getglobal("InviteOMaticOptionForm".."CheckPanel".."WhisperCheck");
        setting:SetChecked(InviteOMaticOptions["whisperInvite"]);

        setting = getglobal("InviteOMaticOptionForm".."SpamPanel".."AIGSpamCheck");
        setting:SetChecked(InviteOMaticOptions["sendAIGSpam"]);
        setting = getglobal("InviteOMaticOptionForm".."SpamPanel".."AIGSpamEdit".."Edit");
        setting:SetText(InviteOMaticOptions["aigMsg"]);

        setting = getglobal("InviteOMaticOptionForm".."SpamPanel".."InviteSpamCheck");
        setting:SetChecked(InviteOMaticOptions["sendInviteSpam"]);
        setting = getglobal("InviteOMaticOptionForm".."SpamPanel".."InviteSpamEdit".."Edit");
        setting:SetText(InviteOMaticOptions["inviteMsg"]);
    end
end

function InviteOMatic_InviteSliderChanged()
    local setting = getglobal("InviteOMaticOptionForm".."InvitePanel".."InviteSlider".."Slider");
    local value = setting:GetValue();
    setting = getglobal("InviteOMaticOptionForm".."InvitePanel".."InviteSliderLabel".."Label");
    setting:SetText(tostring(value));
end

function InviteOMatic_AIGSliderChanged()
    local setting = getglobal("InviteOMaticOptionForm".."SliderPanel".."AIGSlider".."Slider");
    local value = setting:GetValue();
    setting = getglobal("InviteOMaticOptionForm".."SliderPanel".."AIGSliderLabel".."Label");
    setting:SetText(tostring(value));
end

function InviteOMatic_DeclineSliderChanged()
    local setting = getglobal("InviteOMaticOptionForm".."SliderPanel".."DeclineSlider".."Slider");
    local value = setting:GetValue();
    setting = getglobal("InviteOMaticOptionForm".."SliderPanel".."DeclineSliderLabel".."Label");
    setting:SetText(tostring(value));
end

function InviteOMatic_IgnoreSliderChanged()
    local setting = getglobal("InviteOMaticOptionForm".."SliderPanel".."IgnoreSlider".."Slider");
    local value = setting:GetValue();
    setting = getglobal("InviteOMaticOptionForm".."SliderPanel".."IgnoreSliderLabel".."Label");
    setting:SetText(tostring(value));
end

function InviteOMatic_CancelOptions()
    showingOptions = false;
    InviteOMaticOptionForm:Hide();
    
    -- Discard all changes
end

function InviteOMatic_SaveOptions()

    --Save all settings
    local setting = getglobal("InviteOMaticOptionForm".."InvitePanel".."InviteSlider".."Slider");
    local value = setting:GetValue();
    InviteOMaticOptions["inviteDelay"] = value;

    setting = getglobal("InviteOMaticOptionForm".."WordPanel".."WordEdit");
    value = setting:GetText();
    InviteOMaticOptions["magicWord"] = value;

    setting = getglobal("InviteOMaticOptionForm".."SliderPanel".."AIGSlider".."Slider");
    value = setting:GetValue();
    InviteOMaticOptions["aigttl"] = value;
    
    setting = getglobal("InviteOMaticOptionForm".."SliderPanel".."DeclineSlider".."Slider");
    value = setting:GetValue();
    InviteOMaticOptions["declinettl"] = value;

    setting = getglobal("InviteOMaticOptionForm".."SliderPanel".."IgnoreSlider".."Slider");
    value = setting:GetValue(InviteOMaticOptions["ignorettl"]);
    InviteOMaticOptions["ignorettl"] = value;

    setting = getglobal("InviteOMaticOptionForm".."CheckPanel".."PurgeCheck");
    value = setting:GetChecked();
    if( value == nil ) then
        value = false;
    else
        value = true;
    end
    InviteOMaticOptions["autoPurge"] = value;

    setting = getglobal("InviteOMaticOptionForm".."CheckPanel".."InviteCheck");
    value = setting:GetChecked();
    if( value == nil ) then
        value = false;
    else
        value = true;
    end
    InviteOMaticOptions["autoInvite"] = value;
    
    setting = getglobal("InviteOMaticOptionForm".."CheckPanel".."WhisperCheck");
    value = setting:GetChecked();
    if( value == nil ) then
        value = false;
    else
        value = true;
    end
    InviteOMaticOptions["whisperInvite"] = value;

    setting = getglobal("InviteOMaticOptionForm".."SpamPanel".."AIGSpamCheck");
    value = setting:GetChecked();
    if( value == nil ) then
        value = false;
    else
        value = true;
    end
    InviteOMaticOptions["sendAIGSpam"] = value;

    setting = getglobal("InviteOMaticOptionForm".."SpamPanel".."AIGSpamEdit".."Edit");
    value = setting:GetText();
    InviteOMaticOptions["aigMsg"] = value;

    setting = getglobal("InviteOMaticOptionForm".."SpamPanel".."InviteSpamCheck");
    value = setting:GetChecked();
    if( value == nil ) then
        value = false;
    else
        value = true;
    end
    InviteOMaticOptions["sendInviteSpam"] = value;
    
    setting = getglobal("InviteOMaticOptionForm".."SpamPanel".."InviteSpamEdit".."Edit");
    value = setting:GetText();
    InviteOMaticOptions["inviteMsg"] = value;

    showingOptions = false;
    InviteOMaticOptionForm:Hide();
end

function InviteOMatic_OptionDragStart()
    InviteOMaticOptionForm:StartMoving();
    InviteOMaticOptionForm.isMoving = true;
end

function InviteOMatic_OptionDragStop()
    InviteOMaticOptionForm:StopMovingOrSizing();
    InviteOMaticOptionForm.isMoving = false;
end


----------------------------------------------------------------------
-- External interface
----------------------------------------------------------------------
InviteOMatic = {
    log = InviteOMatic_PrintMsg,
    debug = InviteOMatic_PrintDebugMsg,
    invite = InviteOMatic_Invite,
--  sendInvites = InviteOMatic_SendInvites,
    disbandGroup = InviteOMatic_DisbandGroup,
}