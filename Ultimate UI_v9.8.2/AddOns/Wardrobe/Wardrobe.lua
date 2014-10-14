WARDROBE_VERSION                    = "1.40-10900";
WARDROBE_DEBUG                      = false;
WARDROBE_NUM_OUTFITS                = 20;
WARDROBE_NUM_POPUP_FUNCTION_BUTTONS = 1;
WARDROBE_MAX_SCROLL_ENTRIES         = 10;
WARDROBE_TEMP_OUTFIT_NAME           = "#temp#";

WARDROBE_NOISY                      = false;
WARDROBE_NOWEAPONSUPPORT            = true;

WARDROBE_TEXTCOLORS = { {1.00, 0.00, 0.00},    -- red
                        {1.00, 0.50, 0.50},    -- light red
                        {1.00, 0.50, 0.00},    -- orange
                        {1.00, 0.75, 0.50},    -- light orange
                        {1.00, 0.75, 0.00},    -- gold
                        {1.00, 0.87, 0.50},    -- light gold

                        {1.00, 1.00, 0.00},    -- yellow
                        {1.00, 1.00, 0.50},    -- light yellow
                        {0.50, 1.00, 0.00},    -- yellow-green
                        {0.75, 1.00, 0.50},    -- light yellow-green
                        {0.00, 1.00, 0.00},    -- green
                        {0.50, 1.00, 0.50},    -- light green

                        {0.00, 1.00, 0.50},    -- blue-green
                        {0.50, 1.00, 0.75},    -- light blue-green
                        {0.00, 1.00, 1.00},    -- cyan
                        {0.50, 1.00, 1.00},    -- light cyan
                        {0.00, 0.00, 1.00},    -- blue
                        {0.50, 0.50, 1.00},    -- light blue

                        {0.50, 0.00, 1.00},    -- blue-purple
                        {0.75, 0.50, 1.00},    -- light blue-purple
                        {1.00, 0.00, 1.00},    -- purple
                        {1.00, 0.50, 1.00},    -- light purple
                        {1.00, 0.00, 0.50},    -- pink-red
                        {1.00, 0.50, 0.75}     -- light pink-red
                      };
                      
WARDROBE_DRABCOLORS = { {0.50, 0.00, 0.00},    -- red
                        {0.50, 0.25, 0.25},    -- light red
                        {0.50, 0.25, 0.00},    -- orange
                        {0.50, 0.38, 0.25},    -- light orange
                        {0.50, 0.38, 0.00},    -- gold
                        {0.50, 0.43, 0.25},    -- light gold

                        {0.50, 0.50, 0.00},    -- yellow
                        {0.50, 0.50, 0.25},    -- light yellow
                        {0.25, 0.50, 0.00},    -- yellow-green
                        {0.38, 0.50, 0.25},    -- light yellow-green
                        {0.00, 0.50, 0.00},    -- green
                        {0.25, 0.50, 0.25},    -- light green

                        {0.00, 0.50, 0.25},    -- blue-green
                        {0.25, 0.50, 0.38},    -- light blue-green
                        {0.00, 0.50, 0.50},    -- cyan
                        {0.25, 0.50, 0.50},    -- light cyan
                        {0.00, 0.00, 0.50},    -- blue
                        {0.25, 0.25, 0.50},    -- light blue

                        {0.25, 0.00, 0.50},    -- blue-purple
                        {0.38, 0.25, 0.50},    -- light blue-purple
                        {0.50, 0.00, 0.50},    -- purple
                        {0.50, 0.25, 0.50},    -- light purple
                        {0.50, 0.00, 0.25},    -- pink-red
                        {0.50, 0.25, 0.38},    -- light pink-red
                      };
                      
WARDROBE_DEFAULT_BUTTON_COLOR = 11;  -- corresponds to the entry in WARDROBE_TEXTCOLORS (in this case, #11 is green)
                  
Wardrobe_InventorySlots = {"HeadSlot","NeckSlot","ShoulderSlot","BackSlot","ChestSlot","ShirtSlot",
                           "TabardSlot","WristSlot","HandsSlot","WaistSlot","LegsSlot","FeetSlot",
                           "Finger0Slot","Finger1Slot","Trinket0Slot","Trinket1Slot","MainHandSlot",
                           "SecondaryHandSlot","RangedSlot"};

Wardrobe_InventorySlotsSize = table.getn( Wardrobe_InventorySlots )

-- the variable that stores all the wardrobe info
-- and gets saved when you quit the game
Wardrobe_Config                         = {};
Wardrobe_Config.Enabled                 = true;
Wardrobe_Config.xOffset                 = 10;
Wardrobe_Config.yOffset                 = 39;
Wardrobe_Config.DefaultCheckboxState    = 1;       -- default state for the checkboxes when specifying what equipment slots make up an outfit on the character paperdoll screen
Wardrobe_Config.version                 = WARDROBE_VERSION;

Wardrobe_Current_Outfit                 = 0;
Wardrobe_InventorySearchForward         = 1;
Wardrobe_AlreadySetCharactersWardrobeID = false;    -- set this to true once we've looked up this character's wardrobe info
Wardrobe_PopupFunction                  = "";       -- tells the popup confirmation box what it's confirming (deleting an outfit, adding one, etc)
WARDROBE_POPUP_TITLE                    = "";       -- the title of the popup confirmation box
Wardrobe_Rename_OldName                 = "";       -- remembers original outfit name in case we cancel a rename
Wardrobe_BeingDragged                   = false;    -- flag for dragging the wardrobe UI button
Wardrobe_DragLock                       = false;    -- true if we're not allowed to drag the wardrobe UI button
Wardrobe_ShowingCharacterPanel          = false;    -- true if the character paperdoll frame is visible
Wardrobe_PressedAcceptButton            = false;    -- remembers if we pressed the accept button in case the character paperdoll frame closes via other means

--============================================================================================--
--============================================================================================--
--                                                                                            --
--                              INITIALIZATION FUNCTIONS                                      --
--                                                                                            --
--============================================================================================--
--============================================================================================--


---------------------------------------------------------------------------------
-- Stuff done when the plugin first loads
---------------------------------------------------------------------------------
function Wardrobe_OnLoad()  

    -- watch our bags and update our wardrobe availability
    this:RegisterEvent("VARIABLES_LOADED");

    Wardrobe_RegisterCosmos();
    Wardrobe_RegisterKhaos(); 
end


---------------------------------------------------------------------------------
-- Register with Khaos UI
---------------------------------------------------------------------------------
function Wardrobe_RegisterKhaos()
end

---------------------------------------------------------------------------------
-- Register with Cosmos UI
---------------------------------------------------------------------------------
function Wardrobe_RegisterCosmos()

    if (Cosmos_RegisterConfiguration) then 

        Cosmos_RegisterConfiguration(
            "COS_WARDROBE",
            "SECTION",
            WARDROBE_CONFIG_HEADER,
            WARDROBE_CONFIG_HEADER_INFO
        );
        Cosmos_RegisterConfiguration(
            "COS_WARDROBE_HEADER",
            "SEPARATOR",
            WARDROBE_CONFIG_HEADER,
            WARDROBE_CONFIG_HEADER_INFO
        );
        Cosmos_RegisterConfiguration(
            "COS_WARDROBE_ENABLED",
            "CHECKBOX",
            WARDROBE_CONFIG_ENABLED,
            WARDROBE_CONFIG_ENABLED_INFO,
            Wardrobe_Toggle,
            Wardrobe_Config.Enabled
        );

        local WardrobeCommands = {"/wardrobe","/wd"};
        Cosmos_RegisterChatCommand (
            "WARDROBE_COMMANDS", -- Some Unique Group ID
            WardrobeCommands, -- The Commands
            Wardrobe_ChatCommandHandler,
            WARDROBE_CHAT_COMMAND_INFO -- Description String
        );
        
    -- if cosmos isn't installed, create the slash commands
    else
        SlashCmdList["WARDROBESLASH"] = Wardrobe_ChatCommandHandler;
        SLASH_WARDROBESLASH1 = "/wardrobe";
        SLASH_WARDROBESLASH2 = "/wd";  
    end
    
    -- makes sure we have a Print() command, just in
    -- case cosmos isn't installed
    if(not Print) then
        function Print(msg, r, g, b, frame) 
            if (not r) then r = 1.0; end
            if (not g) then g = 1.0; end
            if (not b) then b = 1.0; end
            if ( frame ) then 
                frame:AddMessage(msg,r,g,b);
            else
                if ( DEFAULT_CHAT_FRAME ) then 
                    DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
                end
            end
        end
    end
end


---------------------------------------------------------------------------------
-- Event handler
---------------------------------------------------------------------------------
function Wardrobe_OnEvent(event)

    if (Wardrobe_Config.Enabled) then       
        if (event == "VARIABLES_LOADED") then
            Wardrobe_UpdateOldConfigVersions();
        end
    end
end


---------------------------------------------------------------------------------
-- Update outdated config information
---------------------------------------------------------------------------------
function Wardrobe_UpdateOldConfigVersions()
    
    -- check for realm support - 1.01, 1.02, 1.1, 1.2, 1.21 are no good
    if ( Wardrobe_Config.version == "1.01" or Wardrobe_Config.version == "1.02" or Wardrobe_Config.version == "1.1" or Wardrobe_Config.version == "1.2" or Wardrobe_Config.version == "1.21") then
        Wardrobe_Config                      = nil;
        Wardrobe_Config                      = { };
        Wardrobe_Config.Enabled              = true;
        Wardrobe_Config.xOffset              = 10;
        Wardrobe_Config.yOffset              = 39;
    	Wardrobe_Config.DefaultCheckboxState = 1;       -- default state for the checkboxes when specifying what equipment slots make up an outfit on the character paperdoll screen
        Wardrobe_Config.version              = WARDROBE_VERSION;
        WardrobePrint("Erasing old Wardrobe_Config because it don't support realms i.e. earlier than version 1.21-lix");
    end
    
    -- set the current version number
    if ( Wardrobe_Config.version ~= WARDROBE_VERSION ) then
        Wardrobe_Config.version = WARDROBE_VERSION;
    end
    
    -- add the DefaultCheckboxState variable, if it's not present
    if (Wardrobe_Config.DefaultCheckboxState == nil) then
        WardrobeDebug("Adding DefaultCheckboxState to Wardrobe_Config.");
        Wardrobe_Config.DefaultCheckboxState = 1;
    else
        WardrobeDebug("Wardrobe_Config.DefaultCheckboxState = "..tostring(Wardrobe_Config.DefaultCheckboxState));        
    end
    
end



--============================================================================================--
--============================================================================================--
--                                                                                            --
--                              CHAT COMMAND FUNCTIONS                                        --
--                                                                                            --
--============================================================================================--
--============================================================================================--


---------------------------------------------------------------------------------
-- Break a chat command into its command and variable parts (i.e. "debug on" 
-- will break into command = "debug" and variable = "on", or "add my spiffy wardrobe"
-- breaks into command = "add" and variable = "my spiffy wardrobe"
---------------------------------------------------------------------------------
function Wardrobe_ParseCommand(msg)
    firstSpace = string.find(msg, " ", 1, true);
    if (firstSpace) then
        local command = string.sub(msg, 1, firstSpace - 1);
        local var  = string.sub(msg, firstSpace + 1);
        return command, var
    else
        return msg, nil;
    end
end


---------------------------------------------------------------------------------
-- A simple chat command handler.  takes commands in the form "/wardrobe command var"
---------------------------------------------------------------------------------
function Wardrobe_ChatCommandHandler(msg)
    local command, var = Wardrobe_ParseCommand(msg);
    if ((not command) and msg) then
        command = msg;
    end
    if (command) then
        command = string.lower(command);
        if (command == WARDROBE_CMD_RESET) then
            Wardrobe_EraseAllOutfits();
        elseif (command == WARDROBE_CMD_LIST) then
            Wardrobe_ListOutfits(var);
        elseif (command == WARDROBE_CMD_WEAR or command == WARDROBE_CMD_WEAR2 or command == WARDROBE_CMD_WEAR3) then
            Wardrobe_WearOutfit(var);
        elseif (command == WARDROBE_CMD_ON) then
            Wardrobe_Toggle(1);
        elseif (command == WARDROBE_CMD_OFF) then
            Wardrobe_Toggle(0);
        elseif (command == WARDROBE_CMD_LOCK) then
            Wardrobe_ToggleLockButton(true);
        elseif (command == WARDROBE_CMD_UNLOCK) then
            Wardrobe_ToggleLockButton(false);
        elseif (command == WARDROBE_CMD_VERSION) then
            WardrobePrint(WARDROBE_TXT_WARDROBEVERSION.." "..WARDROBE_VERSION);
        elseif (command == "testcheck") then
            Wardrobe_ShowWardrobeConfigurationScreen();
        elseif (command == "testsort") then
            Wardrobe_ShowMainMenu();
        elseif (command == "debug") then
            Wardrobe_ToggleDebug();
        elseif (command == "report") then
            Wardrobe_DumpDebugReport();
        elseif (command == "itemlist") then
            Wardrobe_BuildItemList();
        elseif (command == "struct") then
            Wardrobe_DumpDebugStruct();
        else
            Wardrobe_ShowHelp();
        end
    end
end



--============================================================================================--
--============================================================================================--
--                                                                                            --
--                              WARDROBE MAIN FUNCTIONS                                       --
--                                                                                            --
--============================================================================================--
--============================================================================================--

---------------------------------------------------------------------------------
-- Each character on an account has an ID assigned to it that specifies its wardrobes
-- This function returns the ID associated with this character
---------------------------------------------------------------------------------
function Wardrobe_GetThisCharactersWardrobeID()

    WardrobeDebug("Looking up this character's wardrobe number...");
    
    -- Look for this realm in the wardrobe table
    WD_RealmName = GetCVar( "realmName" );
    WD_realmID = nil;
    
    for i = 1, table.getn(Wardrobe_Config) do
        if ( Wardrobe_Config[i].RealmName == WD_RealmName ) then
            WD_realmID = i;
            break;
        end;
    end;
    
    -- if we didn't find this realm, add us to the wardrobe table
    if (not WD_realmID) then
        Wardrobe_AddThisRealmToWardrobeTable();
        WD_realmID = table.getn(Wardrobe_Config);
    end
    
    
    -- look for this character in the wardrobe table
    WD_charID = nil;
    WD_PlayerName = UnitName("player")
    
    for i = 1, table.getn(Wardrobe_Config[WD_realmID]) do
        if (Wardrobe_Config[WD_realmID][i].PlayerName == WD_PlayerName) then
            WD_charID = i;
            break;
        end
    end
    
    -- if we didn't find this character, add us to the wardrobe table
    if (not WD_charID) then
        Wardrobe_AddThisCharacterToWardrobeTable();
        WD_charID = table.getn(Wardrobe_Config[WD_realmID]);
    end
    
    WardrobeDebug("This character's wardrobe number is: "..WD_charID);
    
    -- flag that we've already found / created this character's wardrobe entry
    Wardrobe_AlreadySetCharactersWardrobeID = true;
end


---------------------------------------------------------------------------------
-- Checks to see if we've already looked up the number associated with this character
-- If not, grab the number
---------------------------------------------------------------------------------
function Wardrobe_CheckForOurWardrobeID()
    if (not Wardrobe_AlreadySetCharactersWardrobeID) then
        Wardrobe_GetThisCharactersWardrobeID();
    end
end


-- NOTES ABOUT DATASTRUCTURES:
--
-- For each character, the wardrobes are stored in a datastructure that looks like this
-- 
-- x = total number of outfits
-- y = total slots on a character (head, feet, hands, etc)
--
-- Outfit[x]          -- the datastructure for a single outfit
--
--     SortNumber       -- specifies the position this outfit will appear in the list of outfits when the list is sorted
--     OutfitName       -- the name of this outfit
--     Available        -- true if all of the items in this outfit are in our bags or equiped
--     Virtual          -- true if this outfit is virtual (not a real outfit, but only used as temporary storage)
--     Selected         -- true if this outfit is the currently selected outfit on the menu screen (highlighted white)
--     Item[1]          -- the data structure for all the items in this outfit
--          Name        -- the name of the item
--          IsSlotUsed  -- 1 if this outfit uses this slot, 0 if not (i.e. an outfit might not involve your trinkets, or might only consist of your rings)
--        .
--        .
--        .
--     Item[y]      
--
-- So, let's say you have two outfits in your wardrobe.  Wardrobe[1] represents outfit 1, and Wardrobe[2] 
-- represents outfit 2.  for outfit 1, Wardrobe[1].OutfitName would be the name of this outfit (say, "In town outfit").  
-- the item on your character slot 5 would be Wardrobe[1].Item[5].Name.  Since all these are stored per character, the
-- actual datastructure would look like:
--
-- Wardrobe_Config[WD_realmID][3].Wardrobe[1].Item[5].Name --> for character 3, outfit 1, item 5


---------------------------------------------------------------------------------
-- Add an entry for this realm to the main table of wardrobes
---------------------------------------------------------------------------------
function Wardrobe_AddThisRealmToWardrobeTable()
    
    WardrobeDebug("Didn't find a wardrobe ID for this realm.  Adding this realm to the table...");
    
    -- build the structure for this realm's wardrobe
    tempTable = { };
    tempTable.RealmName = WD_RealmName;
    
    -- stick this structure into the main table of wardrobes
    table.insert(Wardrobe_Config, tempTable);
end


---------------------------------------------------------------------------------
-- Add an entry for this character to the main table of wardrobes
---------------------------------------------------------------------------------
function Wardrobe_AddThisCharacterToWardrobeTable()
    
    WardrobeDebug("Didn't find a wardrobe ID for this character.  Adding this character to the table...");
    
    -- build the structure for this char's wardrobe
    tempTable = { };
    tempTable.PlayerName = WD_PlayerName
    tempTable.Outfit = { };
    
    -- stick this structure into the main table of wardrobes
    table.insert(Wardrobe_Config[WD_realmID], tempTable);
end


---------------------------------------------------------------------------------
-- Create and return a blank outfit structure
---------------------------------------------------------------------------------
function Wardrobe_CreateBlankOutfit()
    local tempTable2 = { };
    tempTable2.SortNumber = nil;
    tempTable2.OutfitName = "";
    tempTable2.Available = false;
    tempTable2.Virtual = false;
    tempTable2.Selected = false;
    tempTable2.ButtonColor = WARDROBE_DEFAULT_BUTTON_COLOR;
    tempTable2.Item = { };
    for i = 1, Wardrobe_InventorySlotsSize do
        tempTable3 = { };
        tempTable3.Name = "";
        tempTable3.IsSlotUsed = Wardrobe_Config.DefaultCheckboxState;
        table.insert(tempTable2.Item, tempTable3);
    end
    
    return tempTable2;
end


---------------------------------------------------------------------------------
-- Add the named outfit to our wardrobe
---------------------------------------------------------------------------------
function Wardrobe_AddNewOutfit(outfitName, buttonColor)   

     if (Wardrobe_Config.Enabled) then
    
        -- if we haven't already looked up our character's number
        Wardrobe_CheckForOurWardrobeID();

        if (not outfitName) then
            return;
        end
        
        -- make sure we don't already have an outfit with the same name
        if (Wardrobe_FoundOutfitName(outfitName)) then
            WardrobePrint(WARDROBE_TXT_OUTFITNAMEEXISTS);   
            return;
        end

        WardrobeDebug("Trying to set this wardrobe as \""..outfitName.."\"");

        -- if we found a free outfit slot
        local outfitNum = Wardrobe_GetNextFreeOutfitSlot();
        if (outfitNum ~= 0) then
        
            -- store our current equipment in this outfit
            Wardrobe_StoreItemsInOutfit(outfitName, outfitNum, "added");
            Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].ButtonColor = buttonColor;
        -- otherwise we've used the maximum number of outfits
        else
            WardrobePrint(WARDROBE_TXT_USEDUPALL.." "..WARDROBE_NUM_OUTFITS.." "..WARDROBE_TXT_OFYOUROUTFITS, 1.0, 0.0, 0.0);
        end
    end
end


---------------------------------------------------------------------------------
-- Create and return the index of the next free outfit slot
---------------------------------------------------------------------------------
function Wardrobe_GetNextFreeOutfitSlot(addingVirtualOutfit)

    -- find next unused outfit slot
    local outfitNum = 0;
    
    local outfitCount = 0;
    for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
        if (not Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Virtual) then outfitCount = outfitCount + 1; end
    end
    
    -- if we aren't already using our max number of outfits
    if (outfitCount < WARDROBE_NUM_OUTFITS or addingVirtualOutfit) then
    
        -- add another outfit to the list and return its index
        table.insert(Wardrobe_Config[WD_realmID][WD_charID].Outfit, Wardrobe_CreateBlankOutfit());
        outfitNum = table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit);
        Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].SortNumber = outfitNum;
    end
        
    return outfitNum;    
end


---------------------------------------------------------------------------------
-- Store our currently equipped items in the specified outfit name
---------------------------------------------------------------------------------
function Wardrobe_StoreItemsInOutfit(outfitName, outfitNum, printMessage)

    -- store the name of this outfit
     Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].OutfitName = outfitName;
     Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].Virtual = false;

    -- for each slot on our character's person (hands, feet, etc)
    for i = 1, Wardrobe_InventorySlotsSize do
        Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].Item[i].IsSlotUsed = Wardrobe_ItemCheckState[i];
        if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].Item[i].IsSlotUsed == 1) then
            Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].Item[i].Name = Wardrobe_GetItemNameAtInventorySlotNumber(i);
        else
            Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].Item[i].Name = "";
        end
        if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].Item[i].IsSlotUsed == 1) then
            WardrobeDebug("    Setting USED slot "..Wardrobe_InventorySlots[i].." = ["..Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].Item[i].Name.."]");
        else
            WardrobeDebug("    Setting unused slot "..Wardrobe_InventorySlots[i].." = ["..Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].Item[i].Name.."]");
        end
    end 

    -- all the items in this outfit are currently available in the player's inventory
    Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].Available = true;

    if (printMessage) then
        WardrobePrint(WARDROBE_TXT_OUTFIT.." \""..outfitName.."\" "..printMessage..".");
    end
end


---------------------------------------------------------------------------------
-- Update an outfit
---------------------------------------------------------------------------------
function Wardrobe_UpdateOutfit(outfitName, buttonColor)

    if (Wardrobe_Config.Enabled) then
    
        -- if we haven't already looked up our character's number
        Wardrobe_CheckForOurWardrobeID();
             
        -- check to see if the wardrobe doesn't exist
        if (outfitName == nil or outfitName == "") then
            WardrobePrint(WARDROBE_TXT_PLEASEENTERNAME);
        elseif (not Wardrobe_FoundOutfitName(outfitName)) then
            WardrobePrint(WARDROBE_TXT_OUTFITNOTEXIST);
            UIErrorsFrame:AddMessage(WARDROBE_TXT_NOTEXISTERROR, 1.0, 0.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
        else

            -- find the outfit to update
            for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do

                -- if we found the outfit, store our equipment
                if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName == outfitName) then
                    Wardrobe_StoreItemsInOutfit(outfitName, i, WARDROBE_TXT_UPDATED);
                    Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].ButtonColor = buttonColor;
                end
            end
        end
    end
end


---------------------------------------------------------------------------------
-- Erase the named outfit
---------------------------------------------------------------------------------
function Wardrobe_EraseOutfit(outfitName, silent)  

    if (Wardrobe_Config.Enabled) then
    
        -- if we haven't already looked up our character's number
        Wardrobe_CheckForOurWardrobeID();
        
        WardrobeDebug("Trying to delete outfit \""..outfitName.."\"");

        -- find the outfit to erase
        for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do

            -- if we found the outfit
            if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName == outfitName) then

                -- remove the outfit
                table.remove(Wardrobe_Config[WD_realmID][WD_charID].Outfit, i);
                Wardrobe_RenumberSortNumbers();
                
                --Wardrobe_RemoveAPopupButton(outfitName);

                if (not DoEraseAll and not silent) then
                    WardrobePrint(WARDROBE_TXT_OUTFIT.." \""..outfitName.."\" "..WARDROBE_TXT_DELETED);
                    Wardrobe_ListOutfits();
                    UIErrorsFrame:AddMessage(WARDROBE_TXT_OUTFIT.." \""..outfitName.."\" "..WARDROBE_TXT_DELETED, 0.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
                end
                return true;
            end
        end

        WardrobePrint(WARDROBE_TXT_UNABLETOFIND.." \""..outfitName.."!\"");
        UIErrorsFrame:AddMessage(WARDROBE_TXT_UNABLEFINDERROR, 1.0, 0.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
        return false;
    end
end


---------------------------------------------------------------------------------
-- Erase all our outfits
---------------------------------------------------------------------------------
function Wardrobe_EraseAllOutfits()

    if (Wardrobe_Config.Enabled) then
    
        -- if we haven't already looked up our character's number
        Wardrobe_CheckForOurWardrobeID();

        -- delete all the outfits
        Wardrobe_Config[WD_realmID][WD_charID].Outfit = { };
        
        -- hide the main menu
        Wardrobe_ToggleMainMenuFrameVisibility(false);
        
        WardrobePrint(WARDROBE_TXT_ALLOUTFITSDELETED);
        UIErrorsFrame:AddMessage(WARDROBE_TXT_ALLOUTFITSDELETED, 0.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
    end
end


---------------------------------------------------------------------------------
-- Print a list of our outfits
---------------------------------------------------------------------------------
function Wardrobe_ListOutfits(var)

    if (Wardrobe_Config.Enabled) then
    
        -- if we haven't already looked up our character's number
        Wardrobe_CheckForOurWardrobeID();

        local foundOutfits = false;
        WardrobePrint(WARDROBE_TXT_YOURCURRENTARE);

        -- for each outfit
        for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do

            -- if it has a name and isn't virtual
            if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName ~= "" and (not Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Virtual)) then
                WardrobePrint("    o "..Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName);
                foundOutfits = true;

                -- if we asked for a detailed printout, show all the items
                if (var == "items") then
                    for j = 1, Wardrobe_InventorySlotsSize do    
                        if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Item[j].Name ~= "") then
                           WardrobePrint("        ["..Wardrobe_InventorySlots[j].." -> "..Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Item[j].Name.."]");
                        end
                    end           
                end
            end
        end

        if (not foundOutfits) then
            WardrobePrint("  "..WARDROBE_TXT_NOOUTFITSFOUND);
        end
    end
end


---------------------------------------------------------------------------------
-- Wear an outfit
---------------------------------------------------------------------------------
function Wardrobe_WearOutfit(wardrobeName, silent)

    if (Wardrobe_Config.Enabled) then
    
         -- if we haven't already looked up our character's number
         Wardrobe_CheckForOurWardrobeID();

        -- if the user didn't specify a wardrobe to wear
        if (not wardrobeName) then

            WardrobePrint(WARDROBE_TXT_SPECIFYOUTFITTOWEAR);
            return;

        -- else use the specified wardrobe
        else
            OutfitNumber = 0;
            for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
                WardrobeDebug("In WearOutfit, Looking at outfit #"..i.."  name = ["..Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName.."]");
                if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName == wardrobeName) then
                    OutfitNumber = i;
                    WardrobeDebug("Wardrobe_WearOutfit: Found outfit at #"..OutfitNumber);
                    break;
                end
            end

            if (OutfitNumber == 0) then
                WardrobePrint(WARDROBE_TXT_UNABLEFIND.." \""..wardrobeName.."\" "..WARDROBE_TXT_INYOURLISTOFOUTFITS);
                return;       
            end
        end

        WardrobeDebug(WARDROBE_TXT_SWITCHINGTOOUTFIT.." \""..wardrobeName.."\"");

        -- this variable "freeBagSpacesUsed" lets us track which empty pack spaces we've
        -- already assigned an item to be put into.  we need to do this because when we remove
        -- items from our character and put them into our bags, the server takes time to actually
        -- move the item into the bag.  during this delay, we may be still removing items, and we
        -- may see a slot that LOOKS empty but really the server just hasn't gotten around to moving
        -- a previous item into the slot.  this variable lets us mark each empty slot once we've assigned
        -- an item to it so that we don't try to use the same empty slot for another item.
        local freeBagSpacesUsed = { };

        -- tracks how our switching is going.  if at any point we can't remove an item (bags are full, etc),
        -- this will get set to false
        local switchResult = true;

        -- for each slot on our character (hands, neck, head, feet, etc)
        for i = 1, Wardrobe_InventorySlotsSize do
            theSlotID = GetInventorySlotInfo(Wardrobe_InventorySlots[i]);
            theItemName = Wardrobe_Config[WD_realmID][WD_charID].Outfit[OutfitNumber].Item[i].Name;

            -- if this slot is used in this outfit
            if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[OutfitNumber].Item[i].IsSlotUsed == 1) then
            
                WardrobeDebug("Working on slot -> "..Wardrobe_InventorySlots[i]);
            
                -- if we've set an item for this slot
                if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[OutfitNumber].Item[i].Name ~= "") then

                    -- if this item is different from what we're already wearing
                    WardrobeDebug("   Comparing ["..theItemName.."] with ["..Wardrobe_GetItemNameAtInventorySlotNumber(i).."]");
                    if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[OutfitNumber].Item[i].Name ~=  Wardrobe_GetItemNameAtInventorySlotNumber(i)) then

                        WardrobeDebug("      Didn't match!  Switching out "..Wardrobe_InventorySlots[i].." for ["..theItemName.."]");

                        -- equip the item
                        if (not Wardrobe_Equip(theItemName, theSlotID)) then
                            WardrobePrint(WARDROBE_TXT_WARNINGUNABLETOFIND.." \""..theItemName.."\" "..WARDROBE_TXT_INYOURBAGS);
                        end

                    -- else we're already wearing it so no need to do anything
                    else
                        WardrobeDebug("      Matched!  No need to switch out "..Wardrobe_InventorySlots[i].." ["..theItemName.."]");
                    end

                -- else this wardrobe doesn't use an item for this inventory slot (i.e. no gloves in this wardrobe)
                else

                    -- if the inventory slot has an item equipped
                    if (Wardrobe_GetItemNameAtInventorySlotNumber(i) ~= "") then

                        -- grab the inventory item and bag it
                        PickupInventoryItem(theSlotID);
                        result, freeBagSpacesUsed = BagItem(freeBagSpacesUsed);
                        WardrobeDebug("   Trying to remove "..Wardrobe_InventorySlots[i].." ( slot ID #"..theSlotID..")");

                        -- if we failed to switch, this will let us know
                        switchResult = switchResult and result;
                    end
                end
            end    
        end 

        -- only errorcheck when dealing with non-virtual outfits
        if (not Wardrobe_Config[WD_realmID][WD_charID].Outfit[OutfitNumber].Virtual and not silent) then
        
            -- if everything went OK
            if (switchResult) then
        if ( WARDROBE_NOISY ) then
                    WardrobePrint(WARDROBE_TXT_SWITCHEDTOOUTFIT.." \""..wardrobeName..".\"");
        end
                Wardrobe_Current_Outfit = OutfitNumber;
            else
                WardrobePrint(WARDROBE_TXT_PROBLEMSCHANGING);
            end
        end    
    end
end


---------------------------------------------------------------------------------
-- Rename an outfit
---------------------------------------------------------------------------------
function Wardrobe_RenameOutfit(oldName, newName)

    if (Wardrobe_Config.Enabled) then    

        -- check to see if the new name is already being used
        if (not Wardrobe_FoundOutfitName(newName) and newName ~= "") then
            for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
                if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName == oldName) then
                    Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName = newName;
                    break;
                end
            end   
            UIErrorsFrame:AddMessage(WARDROBE_TXT_OUTFITRENAMEDERROR, 0.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
            WardrobePrint(WARDROBE_TXT_OUTFITRENAMEDTO.." \""..oldName.."\" "..WARDROBE_TXT_TOWORDONLY.." \""..newName.."\"");
        end
    end
end



---------------------------------------------------------------------------------
-- Comparison function for sorting outfits
---------------------------------------------------------------------------------
function Wardrobe_SortOutfitCompare(outfit1, outfit2)
    if (outfit1.SortNumber < outfit2.SortNumber) then
        return true;
    else
        return false;
    end
end


---------------------------------------------------------------------------------
-- Sort the outfits based on the .SortNumber property
---------------------------------------------------------------------------------
function Wardrobe_SortOutfits()
    table.sort(Wardrobe_Config[WD_realmID][WD_charID].Outfit, Wardrobe_SortOutfitCompare);
    
    Wardrobe_RenumberSortNumbers();
end


---------------------------------------------------------------------------------
-- Re-number the .SortNumbers so they start at 1 and go up by 1
---------------------------------------------------------------------------------
function Wardrobe_RenumberSortNumbers()
    for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
        Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].SortNumber = i;
    end
end


---------------------------------------------------------------------------------
-- Re-order an outfit in the list of outfits
---------------------------------------------------------------------------------
function Wardrobe_OrderOutfit(outfitNum, direction)
    if (outfitNum == 1 and direction < 0) then return; end
    if (outfitNum == table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) and direction > 0) then return; end
    
    if (direction > 0) then
        
        swapNum = 0;
        for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
            if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].SortNumber == Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].SortNumber + 1) then
                swapNum = i;
                break;
            end
        end
        Wardrobe_Config[WD_realmID][WD_charID].Outfit[swapNum].SortNumber = Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].SortNumber
        Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].SortNumber = Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].SortNumber + 1;
    else
        swapNum = 0;
        for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
            if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].SortNumber == Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].SortNumber - 1) then
                swapNum = i;
                break;
            end
        end
        Wardrobe_Config[WD_realmID][WD_charID].Outfit[swapNum].SortNumber = Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].SortNumber
        Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].SortNumber = Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].SortNumber - 1;
    end
    
    return swapNum;    
end


---------------------------------------------------------------------------------
-- return the index of the selected outfit, or nil if none
---------------------------------------------------------------------------------
function Wardrobe_FindSelectedOutfit()
    local outfitNum = nil;
    for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
        if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Selected) then
            outfitNum = i;
            break;
        end
    end

    return outfitNum;    
end

---------------------------------------------------------------------------------
-- Store what we're currently wearing in a virtual outfit
---------------------------------------------------------------------------------
function Wardrobe_StoreVirtualOutfit(virtualOutfitName, currentOutfitName)

    local currentOutfitNum;
    if (type(currentOutfitName) == "number") then
        currentOutfitNum = currentOutfitName;
    else
        currentOutfitNum = Wardrobe_GetOutfitNum(currentOutfitName);
    end
    
    Wardrobe_ItemCheckState = { };
    for i = 1, Wardrobe_InventorySlotsSize do
        local val = Wardrobe_Config[WD_realmID][WD_charID].Outfit[currentOutfitNum].Item[i].IsSlotUsed;
        if (val ~= 1) then val = 0; end
        table.insert(Wardrobe_ItemCheckState, val);
    end    

    -- get a new outfit struct
    local newOutfitNum = Wardrobe_GetNextFreeOutfitSlot(true);

    -- this new outfit will remember what we're about to remove in order to wear our mounted outfit
    Wardrobe_StoreItemsInOutfit(virtualOutfitName, newOutfitNum);

    -- set this outfit to virtual so it'll be hidden and not show up as a normal outfit
    Wardrobe_Config[WD_realmID][WD_charID].Outfit[newOutfitNum].Virtual = true;
end


---------------------------------------------------------------------------------
-- If we have a virtual outfit, wear it and delete it
---------------------------------------------------------------------------------
function Wardrobe_CheckForEquipVirtualOutfit(virtualOutfitName)

    if (not virtualOutfitName) then virtualOutfitName = WARDROBE_TEMP_OUTFIT_NAME; end
    
    if (Wardrobe_FoundOutfitName(virtualOutfitName)) then
        Wardrobe_WearOutfit(virtualOutfitName, true);
        Wardrobe_EraseOutfit(virtualOutfitName, true);
    end
end


---------------------------------------------------------------------------------
-- Update whether we have all the items for our outfits in our bags
---------------------------------------------------------------------------------
function Wardrobe_UpdateOutfitAvailability()

    if (Wardrobe_Config.Enabled and Wardrobe_RegenEnabled) then
    
        -- if we haven't already looked up our character's number
        Wardrobe_CheckForOurWardrobeID();

        WardrobeDebug("Wardrobe Availability:");
        
        local masterItemList = Wardrobe_BuildItemList();
    
        -- for each outfit
        for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do

            -- if it has a name
            if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName ~= "") then

                local foundAllItems = true;

                -- for each item in the outfit
                for j = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Item) do

                    -- if this slot is used in this outfit
                    if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Item[j].IsSlotUsed == 1) then

                        local theItemName = Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Item[j].Name;
                        if (theItemName ~= "") then

                            local foundTheItem = false;
                            for k = 1, table.getn(masterItemList) do
                                if (theItemName == masterItemList[k]) then
                                    foundTheItem = true;
                                    break;
                                end
                            end
                            if (not foundTheItem) then 
                                foundAllItems = false;
                                break;
                            end
                        end
                    end    
                end

                -- if we found all items in our inventory
                Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Available = foundAllItems;
                WardrobeDebug("   Outfit \""..Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName.."\" -- found all items = "..tostring(foundAllItems));
            end
        end
    end
end


---------------------------------------------------------------------------------
-- Determine which outfit we're currently wearing
---------------------------------------------------------------------------------
function Wardrobe_DetermineActiveOutfit()

    WardrobeDebug("Wardrobe_DetermineActiveOutfit: Updating Active Outfit");
    local Wardrobe_ActiveOutfitList = { };
    local foundOutfit = false;
    
    -- build a reference table of the currently equipped items
    Wardrobe_CurrentlyEquippedItemList = { };
    for j = 1, Wardrobe_InventorySlotsSize do
        table.insert(Wardrobe_CurrentlyEquippedItemList, Wardrobe_GetItemNameAtInventorySlotNumber(j));
    end    

    -- for each outfit
    for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
    
        WardrobeDebug("  Working on outfit "..i..": "..Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName);
        
        foundOutfit = true;
        
        -- for each slot on our character (hands, neck, head, feet, etc)
        for j = 1, Wardrobe_InventorySlotsSize do
        
            -- if this slot is used in this outfit
            if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Item[j].IsSlotUsed == 1) then

                -- if this item is different from what we're already wearing
                WardrobeDebug("    Working on slot -> "..Wardrobe_InventorySlots[j]);
                WardrobeDebug("       Comparing ["..Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Item[j].Name.."] with ["..Wardrobe_CurrentlyEquippedItemList[j].."]");
                if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Item[j].Name ~= Wardrobe_CurrentlyEquippedItemList[j]) then
                    foundOutfit = false;
                    break;
                end
            end
        end
        
        if (foundOutfit) then
            table.insert(Wardrobe_ActiveOutfitList, i);
        end
     end
     
     return Wardrobe_ActiveOutfitList;     
end



--============================================================================================--
--============================================================================================--
--                                                                                            --
--                              UTILITY FUNCTIONS                                             --
--                                                                                            --
--============================================================================================--
--============================================================================================--


-----------------------------------------------------------------------------------
-- Our own print function
-----------------------------------------------------------------------------------
function WardrobePrint(theMsg, r, g, b)
    
    -- 0.50, 0.50, 1.00
    if (r == nil) then r = 0.50; end
    if (g == nil) then g = 0.50; end
    if (b == nil) then b = 1.00; end

    if (type(theMsg) == "table") then
        Print(asText(theMsg), r, g, b);
    else
        Print(theMsg, r, g, b);
    end
end

-----------------------------------------------------------------------------------
-- Toggle the plugin on and off
-----------------------------------------------------------------------------------
function Wardrobe_Toggle(toggle)
    if (toggle == 1) then
        WardrobePrint("Wardrobe Enabled.");
        Wardrobe_Config.Enabled = true;
        Wardrobe_IconFrame:Show();
    else
        WardrobePrint("Wardrobe Disabled.");
        Wardrobe_Config.Enabled = false;
        Wardrobe_IconFrame:Hide();
    end
end


-----------------------------------------------------------------------------------
-- Nifty little function to view any lua object as text
-----------------------------------------------------------------------------------
function asText(obj)

    visitRef = {}
    visitRef.n = 0

    asTxRecur = function(obj, asIndex)
        if type(obj) == "table" then
            if visitRef[obj] then
                return "@"..visitRef[obj]
            end
            visitRef.n = visitRef.n +1
            visitRef[obj] = visitRef.n

            local begBrac, endBrac
            if asIndex then
                begBrac, endBrac = "[{", "}]"
            else
                begBrac, endBrac = "{", "}"
            end
            local t = begBrac
            local k, v = nil, nil
            repeat
                k, v = next(obj, k)
                if k ~= nil then
                    if t > begBrac then
                        t = t..", "
                    end
                    t = t..asTxRecur(k, 1).."="..asTxRecur(v)
                end
            until k == nil
            return t..endBrac
        else
            if asIndex then
                -- we're on the left side of an "="
                if type(obj) == "string" then
                    return obj
                else
                    return "["..obj.."]"
                end
            else
                -- we're on the right side of an "="
                if type(obj) == "string" then
                    return '"'..obj..'"'
                else
                    return tostring(obj)
                end
            end
        end
    end -- asTxRecur

    return asTxRecur(obj)
end -- asText


---------------------------------------------------------------------------------
-- Display the help text
---------------------------------------------------------------------------------
function Wardrobe_ShowHelp()
    WardrobePrint("Wardrobe, an AddOn by Cragganmore, Version "..WARDROBE_VERSION);
    WardrobePrint("(Thanks to Saien for ideas from his wonderful EquipManager AddOn.)");
    WardrobePrint("Wardrobe allows you to define and switch among up to 20 different outfits.");
    WardrobePrint("The main interface can be accessed from the Wardrobe icon, which defaults");
    WardrobePrint("to just under your minimap/radar.  You may also use the following commands:");
    WardrobePrint("Usage: /wardrobe <wear/list/reset/lock/unlock>");
    WardrobePrint("   wear [outfit name] - Wear the specified outfit.");
    WardrobePrint("   list - List your outfits.");
    WardrobePrint("   reset - Delete all outfits in your wardrobe.");
    WardrobePrint("   lock/unlock - Lock or unlock moving the wardrobe icon interface.");
    WardrobePrint("In the UI, outfit names are colored as follows:");
    WardrobePrint("   Bright Colored: Your currently equipped outfit.");
    WardrobePrint("   Drab Colored: An outfit where one or more items aren't currently equipped.");
    WardrobePrint("   Grey: An outfit where one or more items aren't in your inventory.");
    WardrobePrint("   Greyed outfits may still be equipped.  The missing items just won't be worn.");
end



--============================================================================================--
--============================================================================================--
--                                                                                            --
--                              DEBUG FUNCTIONS                                               --
--                                                                                            --
--============================================================================================--
--============================================================================================--


-----------------------------------------------------------------------------------
-- Print out a debug statement if the WARDROBE_DEBUG flag is set
-----------------------------------------------------------------------------------
function WardrobeDebug(theMsg)
    if (WARDROBE_DEBUG) then
        ChatFrame1:AddMessage(theMsg, 1.0, 1.0, 0.7);
    end
end


---------------------------------------------------------------------------------
-- Toggle debug output
---------------------------------------------------------------------------------
function Wardrobe_ToggleDebug()
    WARDROBE_DEBUG = not WARDROBE_DEBUG;
    if (WARDROBE_DEBUG) then
        Print("Wardrobe: Debug ON",1.0,1.0,0.5);
    else
        Print("Wardrobe: Debug OFF",1.0,1.0,0.5);
    end    
end


---------------------------------------------------------------------------------
-- Debug routine to print the current state of the plugin
---------------------------------------------------------------------------------
function Wardrobe_DumpDebugReport()
    
    Wardrobe_CheckForOurWardrobeID();
    
    WardrobeDebug("Wardrobe_DumpDebugReport: Character's wardrobe database");
    for outfitNum = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
        WardrobeDebug("Outfit: "..tostring(Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].OutfitName));
        for i = 1, Wardrobe_InventorySlotsSize do
            theWardrobeItem = Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].Item[i].Name;
            WardrobeDebug(Wardrobe_InventorySlots[i].." = "..tostring(theWardrobeItem));
        end
    end
end



---------------------------------------------------------------------------------
-- Print a debug report
---------------------------------------------------------------------------------
function Wardrobe_DumpDebugStruct()
    for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
        Print("Outfit #"..i..":");
        Print(asText(Wardrobe_Config[WD_realmID][WD_charID].Outfit[i]));
        Print("--------------------");
    end
end


