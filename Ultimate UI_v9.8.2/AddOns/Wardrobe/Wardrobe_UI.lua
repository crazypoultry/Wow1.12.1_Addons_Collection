--============================================================================================--
--============================================================================================--
--                                                                                            --
--                              INTERFACE FUNCTIONS                                             --
--                                                                                            --
--============================================================================================--
--============================================================================================--


--===============================================================================
--
-- UI Menu and Button
--
--===============================================================================

---------------------------------------------------------------------------------
-- Start dragging the wardrobe button
---------------------------------------------------------------------------------
function Wardrobe_OnDragStart()
    if (not Wardrobe_DragLock) then
        Wardrobe_IconFrame:StartMoving()
        Wardrobe_BeingDragged = true;
    end
end


---------------------------------------------------------------------------------
-- Stop dragging the wardrobe button
---------------------------------------------------------------------------------
function Wardrobe_OnDragStop()
    if (Wardrobe_BeingDragged) then
        Wardrobe_IconFrame:StopMovingOrSizing()
        Wardrobe_BeingDragged = false;
        local x,y = this:GetCenter();
        local px,py = this:GetParent():GetCenter();
        local ox = x-px;
        local oy = y-py;
        Wardrobe_Config.xOffset = ox;
        Wardrobe_Config.yOffset = oy;
    end
end


---------------------------------------------------------------------------------
-- Toggle whether the wardrobe button can be moved or not
---------------------------------------------------------------------------------
function Wardrobe_ToggleLockButton(toggle)
    Wardrobe_DragLock = toggle;
    if (Wardrobe_DragLock) then
        WardrobePrint(WARDROBE_TXT_BUTTONLOCKED);
    else
        WardrobePrint(WARDROBE_TXT_BUTTONUNLOCKED);
    end
end


---------------------------------------------------------------------------------
-- Register the wardrobe button 
---------------------------------------------------------------------------------
function Wardrobe_ButtonOnLoad()
    this:RegisterForDrag("LeftButton");
    --this:RegisterForClicks("LeftButton");
end


---------------------------------------------------------------------------------
-- Update function for showing/hiding the UI menu
---------------------------------------------------------------------------------
function Wardrobe_OnUpdateUIMenu()
    if (not MouseIsOver(Wardrobe_Popup) and not MouseIsOver(Wardrobe_IconFrame)) then
        Wardrobe_Popup:Hide();
    end
end


---------------------------------------------------------------------------------
-- When the user mouses over the UI button
---------------------------------------------------------------------------------
function Wardrobe_HandleUIMenuTriggerEnter()
    -- turn on color cycling for Wardrobe_PopupTitle
    Wardrobe_ColorCycle_UIPopupMenu(true);
    Wardrobe_ShowUIMenu();
end


---------------------------------------------------------------------------------
-- When the user mouses off the UI button
---------------------------------------------------------------------------------
function Wardrobe_HandleUIMenuTriggerLeave()
    -- turn off color cycling for Wardrobe_PopupTitle
    Wardrobe_ColorCycle_UIPopupMenu(false);
    GameTooltip:Hide();
end


---------------------------------------------------------------------------------
-- Begin the process of displaying the UI menu
---------------------------------------------------------------------------------
function Wardrobe_ShowUIMenu()

    -- if we haven't already looked up our character's number
    Wardrobe_CheckForOurWardrobeID();
    
    -- update the availability of our outfits
    Wardrobe_UpdateOutfitAvailability();

    -- find out if we're wearing one of our outfits
    Wardrobe_ActiveOutfitList = Wardrobe_DetermineActiveOutfit();

    Wardrobe_CompleteShowingUIMenu();
end


---------------------------------------------------------------------------------
-- Complete the process of displaying the UI menu
---------------------------------------------------------------------------------
function Wardrobe_CompleteShowingUIMenu()

    WardrobeDebug("Wardrobe_CompleteShowingUIMenu called!");
    
    -- set the title of the popup window
    Wardrobe_PopupTitle:SetText(UnitName("player").."'s "..WARDROBE_TEXT_MENU_TITLE);
    
    -- Set the text for the buttons while keeping track of how many
    -- buttons we actually need.
    local count = 0;
    for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
        if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName ~= "" and (not Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Virtual)) then
            count = count + 1;
            local button = getglobal("Wardrobe_PopupButton"..count);
            button:SetText(Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName);
            
            -- determine if we're wearing all the items in this outfit
            local activeOutfit = false;
            for j = 1, table.getn(Wardrobe_ActiveOutfitList) do
                if (Wardrobe_ActiveOutfitList[j] == i) then
                    activeOutfit = true;
                    break;
                end
            end
            
            local fullOutfitSet = true;
            for j = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Item) do
                if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Item[j].IsSlotUsed ~= 1) then
                    fullOutfitSet = false;
                    break;
                end
            end
            
            -- color the buttons based on wardrobe availability
            local buttonColor = Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].ButtonColor;
            if (activeOutfit) then
                button:SetTextColor(WARDROBE_TEXTCOLORS[buttonColor][1], WARDROBE_TEXTCOLORS[buttonColor][2], WARDROBE_TEXTCOLORS[buttonColor][3]);
            elseif (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Available) then
                button:SetTextColor(WARDROBE_DRABCOLORS[buttonColor][1], WARDROBE_DRABCOLORS[buttonColor][2], WARDROBE_DRABCOLORS[buttonColor][3]);
            else
                button:SetTextColor(0.70, 0.76, 0.65);
            end
            button.OutfitName = Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName;
            button:Show();
        end
    end
    
    -- add in the "add" and "delete" and "rename" and "sort" buttons
    count = count + 1;
    local button = getglobal("Wardrobe_PopupButton"..count);
    button:SetText("[Menu]");
    button.OutfitName = "[Menu]";
    button:SetTextColor(1.0, 1.0, 1.0);
    button:Show();
    
    -- Set the width for the menu.
    local width = Wardrobe_PopupTitle:GetWidth();
    for i = 1, count, 1 do
        local button = getglobal("Wardrobe_PopupButton"..i);
        local w = button:GetTextWidth();
        if (w > width) then
            width = w;
        end
    end
    Wardrobe_Popup:SetWidth(width + 2 * UNITPOPUP_BORDER_WIDTH);

    -- By default, the width of the button is set to the width of the text
    -- on the button.  Set the width of each button to the width of the
    -- menu so that you can still click on it without being directly
    -- over the text.
    for i = 1, count, 1 do
        local button = getglobal("Wardrobe_PopupButton"..i);
        button:SetWidth(width);
    end

    -- Hide the buttons we don't need.
    for i = count + 1, WARDROBE_NUM_OUTFITS + WARDROBE_NUM_POPUP_FUNCTION_BUTTONS do
        local button = getglobal("Wardrobe_PopupButton"..i);
        button:Hide();
    end
    
    -- Set the height for the menu.
    Wardrobe_Popup:SetHeight(UNITPOPUP_TITLE_HEIGHT + (count * (UNITPOPUP_BUTTON_HEIGHT - 3)) + (3 * UNITPOPUP_BORDER_HEIGHT));

    -- Show the menu.
    Wardrobe_Popup:Show();
    
end


---------------------------------------------------------------------------------
-- Handle when a user clicks on an outfit button in the UI menu
---------------------------------------------------------------------------------
function Wardrobe_ButtonClick()
    local Wardrobe_PopupWindowHeader = getglobal("WardrobeNamePopupText");

    if (this.OutfitName == "[Menu]") then
        Wardrobe_ShowMainMenu();        
    else
        Wardrobe_WearOutfit(this.OutfitName);
    end
        
    Wardrobe_Popup:Hide();
end


---------------------------------------------------------------------------------
-- Handle keybinding clicks
---------------------------------------------------------------------------------
function Wardrobe_Keybinding(outfitNum)
    if (outfitNum <= table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit)) then
        Wardrobe_WearOutfit(Wardrobe_Config[WD_realmID][WD_charID].Outfit[outfitNum].OutfitName);
    end
end


--===============================================================================
--
-- Confirmation windows
--
--===============================================================================

---------------------------------------------------------------------------------
-- Confirm a popup menu
---------------------------------------------------------------------------------
function Wardrobe_PopupConfirm()

    WardrobeNamePopup:Hide();
    WardrobePopupConfirm:Hide();
    local Wardrobe_PopupWindowHeader = getglobal("WardrobeNamePopupText");

    if (Wardrobe_PopupFunction == "[Add]") then
        Wardrobe_NewWardrobeName = WardrobeNamePopupEditBox:GetText();
        Wardrobe_ShowWardrobeConfigurationScreen();
    elseif (Wardrobe_PopupFunction == "[Delete]" or Wardrobe_PopupFunction == "DeleteFromSort") then
        Wardrobe_EraseOutfit(WardrobeNamePopupEditBox:GetText());
        if (Wardrobe_PopupFunction == "DeleteFromSort") then
            Wardrobe_PopulateMainMenu();
            Wardrobe_ToggleMainMenuFrameVisibility(true);
        end
        Wardrobe_PopupFunction = "";
    elseif (Wardrobe_PopupFunction == "[Edit]") then
        Wardrobe_NewWardrobeName = WardrobeNamePopupEditBox:GetText();
        Wardrobe_RenameOutfit(Wardrobe_Rename_OldName, Wardrobe_NewWardrobeName);
        Wardrobe_StoreVirtualOutfit(WARDROBE_TEMP_OUTFIT_NAME, Wardrobe_NewWardrobeName);
        Wardrobe_WearOutfit(Wardrobe_NewWardrobeName, true);
        Wardrobe_PopupFunction = "[Update]";
        Wardrobe_ShowWardrobeConfigurationScreen();
    elseif (Wardrobe_PopupFunction == "[Update]") then
        Wardrobe_NewWardrobeName = WardrobeNamePopupEditBox:GetText();
        Wardrobe_ShowWardrobeConfigurationScreen();
    end
        
end


---------------------------------------------------------------------------------
-- Cancel a popup menu
---------------------------------------------------------------------------------
function Wardrobe_PopupCancel()
    WardrobeNamePopup:Hide();
    WardrobePopupConfirm:Hide();
    if (Wardrobe_PopupFunction == "DeleteFromSort") then
        Wardrobe_ToggleMainMenuFrameVisibility(true);
    end
end



--===============================================================================
--
-- Paperdoll configuration windows
--
--===============================================================================

---------------------------------------------------------------------------------
-- Show the screen that lets the user confirm his/her wardrobe selection (check off items, etc)
---------------------------------------------------------------------------------
function Wardrobe_ShowWardrobeConfigurationScreen()
    
    local numInventorySlots = table.getn(Wardrobe_InventorySlots);
    Wardrobe_CheckboxToggleState = Wardrobe_Config.DefaultCheckboxState;
    Wardrobe_CurrentOutfitButtonColor = WARDROBE_DEFAULT_BUTTON_COLOR;
    
    for i = 1, numInventorySlots do
        getglobal("Character"..Wardrobe_InventorySlots[i].."WardrobeCheckBox"):SetCheckedTexture("Interface\\AddOns\\Wardrobe\\Images\\Check");
        --getglobal("Character"..Wardrobe_InventorySlots[i].."WardrobeCheckBox"):SetDisabledCheckedTexture("Interface\\AddOns\\Wardrobe\\Images\\X");
    end

    if (Wardrobe_PopupFunction == "[Add]") then
        if (Wardrobe_Config.DefaultCheckboxState == 1 or Wardrobe_Config.DefaultCheckboxState == 0) then
            for i = 1, numInventorySlots do
                getglobal("Character"..Wardrobe_InventorySlots[i].."WardrobeCheckBox"):SetChecked(Wardrobe_Config.DefaultCheckboxState);
            end
        else
            WardrobePrint(WARDROBE_TXT_WARDROBENAME..tostring(Wardrobe_Config.DefaultCheckboxState));
        end
        
    elseif (Wardrobe_PopupFunction == "[Update]") then
    
        -- for each outfit
        for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do

            -- if it's the wardrobe we're updating
            if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].OutfitName == Wardrobe_NewWardrobeName) then

                Wardrobe_CurrentOutfitButtonColor = Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].ButtonColor;
                
                -- for each item in the outfit, set the checkbox
                for j = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Item) do
                    if (not Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Item[j].IsSlotUsed) then
                        Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Item[j].IsSlotUsed = Wardrobe_Config.DefaultCheckboxState;
                    end
                    local IsSlotUsed = Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Item[j].IsSlotUsed;
                    local checkBoxName = "Character"..Wardrobe_InventorySlots[j].."WardrobeCheckBox";
                    getglobal(checkBoxName):SetChecked(IsSlotUsed);
                end
                break;
            end
        end
    end
    
    -- show the character paperdoll frame
    Wardrobe_ToggleCharacterPanel();
    
end


---------------------------------------------------------------------------------
-- Toggle the visibility of the character panel
---------------------------------------------------------------------------------
function Wardrobe_ToggleCharacterPanel(dontToggleChar)
    if (not Wardrobe_InToggleCharacterPanel) then
        Wardrobe_InToggleCharacterPanel = true;
        if (Wardrobe_ShowingCharacterPanel == false) then
            if (not dontToggleChar and (not PaperDollFrame:IsVisible())) then
                ToggleCharacter("PaperDollFrame");
            end
            WardrobeCheckboxesFrame:Show();
            Wardrobe_Orig_HideUIPanel = HideUIPanel;
            HideUIPanel = Wardrobe_HideUIPanel;
            Wardrobe_RefreshCharacterPanel();
            Wardrobe_ColorCycle_CharacterFrame(true);
            Wardrobe_ShowingCharacterPanel = true;
        else
            WardrobeCheckboxesFrame:Hide();
            CharacterNameText:SetText(UnitPVPName("player"));
            Wardrobe_ColorCycle_CharacterFrame(false);
            CharacterNameText:SetTextColor(1,1,1);
            Wardrobe_ShowingCharacterPanel = false;
            if (not dontToggleChar) then
                ToggleCharacter("PaperDollFrame");
            end
        end

        Wardrobe_InToggleCharacterPanel = false;
    end
end


---------------------------------------------------------------------------------
-- Refresh the character panel
---------------------------------------------------------------------------------
function Wardrobe_RefreshCharacterPanel()
    CharacterNameText:SetText(Wardrobe_NewWardrobeName);
    CharacterNameText:SetTextColor(WARDROBE_TEXTCOLORS[Wardrobe_CurrentOutfitButtonColor][1],WARDROBE_TEXTCOLORS[Wardrobe_CurrentOutfitButtonColor][2],WARDROBE_TEXTCOLORS[Wardrobe_CurrentOutfitButtonColor][3]);
end


---------------------------------------------------------------------------------
-- Turn on or off color cycling on the character panel
---------------------------------------------------------------------------------
function Wardrobe_ColorCycle_CharacterFrame(toggle)
    if (ColorCycle_AddTableEntry) then
        if (toggle) then
            for i = 1, table.getn(Wardrobe_InventorySlots) do
                ColorCycle_PulseWhite(
                    {
                        ID = "Character"..Wardrobe_InventorySlots[i].."WardrobeCheckBoxGlow";
                        globalName = "Character"..Wardrobe_InventorySlots[i].."WardrobeCheckBoxGlow";
                        cycleType  = "Texture";
                        color      = {0.0, 0.0, 0.0};
                        speed      = 0.05;
                        pause      = 0.25;
                    }
                );    
            end             
        else
            for i = 1, table.getn(Wardrobe_InventorySlots) do
                ColorCycle_PulseWhite(
                    {
                        ID      = "Character"..Wardrobe_InventorySlots[i].."WardrobeCheckBoxGlow";
                        remove  = true;
                    }
                );    
            end
        end
    end
end


---------------------------------------------------------------------------------
-- Turn on or off color cycling on the character panel
---------------------------------------------------------------------------------
function Wardrobe_ColorCycle_UIPopupMenu(toggle)
    if (ColorCycle_AddTableEntry) then
        if (toggle) then
            ColorCycle_AddTableEntry( 
                {
                    ID = "Wardrobe_PopupTitle";
                    cycleType = "FontText";
                    globalName = "Wardrobe_PopupTitle";
                    startValues = WARDROBE_TEXTCOLORS[math.random(table.getn(WARDROBE_TEXTCOLORS))];
                    cycleSpeed = 0.003;
                    varySpeedFactor = 2, 
                    okToWait = {true, true, true},
                }
            );
        else
            ColorCycle_PulseWhite(
                {
                    ID      = "Wardrobe_PopupTitle";
                    remove  = true;
                }
            );    
        end
    end
end



---------------------------------------------------------------------------------
-- Hook the HideUIPanel function so that we can trap when the user closes the character panel
---------------------------------------------------------------------------------
function Wardrobe_HideUIPanel(theFrame)

    Wardrobe_Orig_HideUIPanel(theFrame);
    
    if (theFrame == getglobal("CharacterFrame")) then
        WardrobeCheckboxesFrame:Hide();        
        Wardrobe_ToggleCharacterPanel(true);
        HideUIPanel = Wardrobe_Orig_HideUIPanel;
        if (not Wardrobe_PressedAcceptButton) then
            UIErrorsFrame:AddMessage(WARDROBE_TXT_CHANGECANCELED, 1.0, 0.0, 0.0, 1.0, UIERRORS_HOLD_TIME); 
        end
        
        -- check to see if we should re-equip our previous outfit
        Wardrobe_CheckForEquipVirtualOutfit(WARDROBE_TEMP_OUTFIT_NAME);
    end
    
    Wardrobe_PressedAcceptButton = false;
end


---------------------------------------------------------------------------------
-- Handle when the user clicks the button to toggle all the checkboxes
---------------------------------------------------------------------------------
function Wardrobe_ToggleCheckboxes()
    if (Wardrobe_CheckboxToggleState == 1) then
        Wardrobe_CheckboxToggleState = 0;
    else
        Wardrobe_CheckboxToggleState = 1;
    end
    for i = 1, table.getn(Wardrobe_InventorySlots) do
        getglobal("Character"..Wardrobe_InventorySlots[i].."WardrobeCheckBox"):SetChecked(Wardrobe_CheckboxToggleState);
    end    
end


---------------------------------------------------------------------------------
-- When the user accepts the wardrobe confirmation screen
---------------------------------------------------------------------------------
function Wardrobe_ConfirmWardrobeConfigurationScreen()

    -- remember which items were checked and unchecked for this outfit
    Wardrobe_ItemCheckState = { };
    for i = 1, table.getn(Wardrobe_InventorySlots) do
        local val = getglobal("Character"..Wardrobe_InventorySlots[i].."WardrobeCheckBox"):GetChecked();
        if (val ~= 1) then val = 0; end
        table.insert(Wardrobe_ItemCheckState, val);
    end    
    
    if (Wardrobe_PopupFunction == "[Add]") then
        Wardrobe_AddNewOutfit(Wardrobe_NewWardrobeName, Wardrobe_CurrentOutfitButtonColor);
        Wardrobe_PopupFunction = "";
    elseif (Wardrobe_PopupFunction == "[Update]") then
        Wardrobe_UpdateOutfit(Wardrobe_NewWardrobeName, Wardrobe_CurrentOutfitButtonColor);
        Wardrobe_PopupFunction = "";
        
        -- check to see if we should re-equip our previous outfit
        Wardrobe_CheckForEquipVirtualOutfit(WARDROBE_TEMP_OUTFIT_NAME);
    end
    
    Wardrobe_PressedAcceptButton = true;
    Wardrobe_ToggleCharacterPanel();
end


---------------------------------------------------------------------------------
-- When the user rejects the wardrobe confirmation screen
---------------------------------------------------------------------------------
function Wardrobe_CancelWardrobeConfigurationScreen()

        -- check to see if we should re-equip our previous outfit
        Wardrobe_CheckForEquipVirtualOutfit(WARDROBE_TEMP_OUTFIT_NAME);
end


--===============================================================================
--
-- Main menu
--
--===============================================================================

---------------------------------------------------------------------------------
-- Show the main menu
---------------------------------------------------------------------------------
function Wardrobe_ShowMainMenu()

    Wardrobe_CheckForOurWardrobeID();
    
    -- clear any selected outfits
    for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
        Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Selected = false;
    end
    
    Wardrobe_ToggleMainMenuFrameVisibility(true);
    Wardrobe_PopulateMainMenu();
end


---------------------------------------------------------------------------------
-- Toggle the main menu visibility and color cycling
---------------------------------------------------------------------------------
function Wardrobe_ToggleMainMenuFrameVisibility(toggle)
    if (toggle) then
        WardrobeMainMenuFrame:Show();
    else
        WardrobeMainMenuFrame:Hide();
    end
    
    -- toggle color cycling
    Wardrobe_ColorCycle_MainMenuFrame(toggle);
end


---------------------------------------------------------------------------------
-- Start or stop color cycling on the modification frame
---------------------------------------------------------------------------------
function Wardrobe_ColorCycle_MainMenuFrame(toggle)
    if (ColorCycle_AddTableEntry) then
        if (toggle) then
            ColorCycle_AddTableEntry(
                {
                    ID          = "WardrobeMainMenuFrameTitle";
                    cycleType   = "FontText";
                    globalName  = "WardrobeMainMenuFrameTitle";
                    cycleSpeed  = 0.01;
                    okToWait    = {true, true, true};
                }
            );
        else
        
            -- turn off color cycling on the selected outfit
            for i = 1, WARDROBE_MAX_SCROLL_ENTRIES do
                local fs = getglobal("WardrobeMainMenuFrameEntry"..i.."Outfit");
                if (frameName ~= "WardrobeMainMenuFrameEntry"..i) then
                    if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[fs.OutfitNum]) then
                        Wardrobe_SetSelectionColor(false, "WardrobeMainMenuFrameEntry"..i.."Outfit", fs)
                    end
                end
            end
            ColorCycle_RemoveEntry("WardrobeMainMenuFrameTitle");
        end
    end
end


---------------------------------------------------------------------------------
-- Populate the main menu
---------------------------------------------------------------------------------
function Wardrobe_PopulateMainMenu(maintainSelected)
    WardrobeDebug("PopulateMainMenu");

    Wardrobe_CheckForOurWardrobeID();
        
    Wardrobe_SortOutfits();
    
    -- clear any selected item
    for rowCount = 1, WARDROBE_MAX_SCROLL_ENTRIES do
        Wardrobe_SetSelectionColor(false, "WardrobeMainMenuFrameEntry"..rowCount.."Outfit", getglobal("WardrobeMainMenuFrameEntry"..rowCount.."Outfit"));
    end
    
    local fs;
    local offset = FauxScrollFrame_GetOffset(WardrobeSortScrollFrame);
    local rowCount, entryCount, totalExistingEntries, totalEntriesShown;  
    WardrobeDebug("offset = "..offset);
    
    rowCount = 1;
    entryCount = 1;
    
    while rowCount <= WARDROBE_MAX_SCROLL_ENTRIES do

        WardrobeDebug("rowCount = "..rowCount);
        WardrobeDebug("entryCount = "..entryCount);
        fs = getglobal("WardrobeMainMenuFrameEntry"..rowCount.."Outfit");
        if (not Wardrobe_Config[WD_realmID][WD_charID].Outfit[entryCount + offset]) then
            fs:SetText("");
            fs.r = 0;
            fs.g = 0;
            fs.b = 0;
            rowCount = rowCount + 1;
            
        -- if this isn't a virtual outfit
        elseif (not Wardrobe_Config[WD_realmID][WD_charID].Outfit[entryCount + offset].Virtual) then
            WardrobeDebug("Wasn't Virtual.  Setting text to: "..Wardrobe_Config[WD_realmID][WD_charID].Outfit[entryCount + offset].OutfitName);
            fs:SetText(Wardrobe_Config[WD_realmID][WD_charID].Outfit[entryCount + offset].OutfitName);
            local buttonColor = Wardrobe_Config[WD_realmID][WD_charID].Outfit[entryCount + offset].ButtonColor;
            fs.r = WARDROBE_TEXTCOLORS[buttonColor][1];
            fs.g = WARDROBE_TEXTCOLORS[buttonColor][2];
            fs.b = WARDROBE_TEXTCOLORS[buttonColor][3];
            if (not maintainSelected) then
                --Wardrobe_Config[WD_realmID][WD_charID].Outfit[entryCount + offset].Selected = false;
            end;
            
            -- if this outfit is selected, highlight it
            if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[entryCount + offset].Selected) then
                Wardrobe_SetSelectionColor(true, "WardrobeMainMenuFrameEntry"..rowCount.."Outfit", fs);
            else
                fs:SetTextColor(fs.r, fs.g, fs.b);
            end

            rowCount = rowCount + 1; 
        else
            WardrobeDebug("Was Virtual");
        end
        fs.OutfitNum = entryCount + offset;
        entryCount = entryCount + 1;
    end

    FauxScrollFrame_Update(WardrobeSortScrollFrame, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit), WARDROBE_MAX_SCROLL_ENTRIES, WARDROBE_MAX_SCROLL_ENTRIES);

    return entryCount, rowCount;    
end


---------------------------------------------------------------------------------
-- when mousing over an entry in the outfit menu, highlight it
---------------------------------------------------------------------------------
function Wardrobe_WardrobeMainMenuFrameEntry_OnEnter()
    local fs = getglobal(this:GetName().."Outfit");
    fs:SetTextColor(1.0, 1.0, 1.0);
end


---------------------------------------------------------------------------------
-- when the mouse leaves an entry in the outfit menu, return it to its normal color (unless it's selected)
---------------------------------------------------------------------------------
function Wardrobe_WardrobeMainMenuFrameEntry_OnLeave()
    local fs = getglobal(this:GetName().."Outfit");
    local thenum = fs.OutfitNum;
    if (thenum) then
        if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[fs.OutfitNum]) then
            if (not Wardrobe_Config[WD_realmID][WD_charID].Outfit[fs.OutfitNum].Selected) then
                fs:SetTextColor(fs.r, fs.g, fs.b);
            end
        end
    end    
end


---------------------------------------------------------------------------------
-- when clicking on an entry in the outfit menu
---------------------------------------------------------------------------------
function Wardrobe_WardrobeMainMenuFrameEntry_OnClick()
    
    local frameName = this:GetName();

    -- unselect all items
    Wardrobe_UnselectAllMainMenuItems();
    
    -- select this item
    fs = getglobal(frameName.."Outfit");
    if (fs) then
        if (fs.OutfitNum) then
            if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[fs.OutfitNum] ~= nil) then
                if (not Wardrobe_Config[WD_realmID][WD_charID].Outfit[fs.OutfitNum].Selected) then
                    Wardrobe_Config[WD_realmID][WD_charID].Outfit[fs.OutfitNum].Selected = true;
                    Wardrobe_SetSelectionColor(true, frameName.."Outfit", fs);
                else
                    Wardrobe_Config[WD_realmID][WD_charID].Outfit[fs.OutfitNum].Selected = false;
                end
            end    
        end    
    end    
end


---------------------------------------------------------------------------------
-- unselect all the outfits in the main menu
---------------------------------------------------------------------------------
function Wardrobe_UnselectAllMainMenuItems()
    local frameName = this:GetName();

    -- unselect all the other buttons
    for i = 1, WARDROBE_MAX_SCROLL_ENTRIES do
        local fs = getglobal("WardrobeMainMenuFrameEntry"..i.."Outfit");
        Wardrobe_SetSelectionColor(false, "WardrobeMainMenuFrameEntry"..i.."Outfit", fs);
    end
    
    for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
        Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Selected = false;
    end
end


---------------------------------------------------------------------------------
-- set or unset the color of the selected outfit text in the main menu
---------------------------------------------------------------------------------
function Wardrobe_SetSelectionColor(toggle, theGlobal, fs)
    if (toggle) then
        if (ColorCycle_AddTableEntry) then
            ColorCycle_FlashWhite(
                {
                    ID = theGlobal;
                    cycleType = "FontText";
                    globalName = theGlobal;
                    color = {fs.r, fs.g, fs.b};
                }
            );
        else
            fs:SetTextColor(1, 1, 1);
        end
    else
        if (ColorCycle_AddTableEntry) then
            ColorCycle_FlashWhite(
                {
                    ID = theGlobal;
                    remove = true;
                }
            );
        end                
        fs:SetTextColor(fs.r, fs.g, fs.b);
    end
end


--===============================================================================
--
-- Main menu buttons
--
--===============================================================================

---------------------------------------------------------------------------------
-- when clicking on the new outfit button
---------------------------------------------------------------------------------
function Wardrobe_NewOutfitButtonClick()
    local Wardrobe_PopupWindowHeader = getglobal("WardrobeNamePopupText");
    Wardrobe_PopupWindowHeader:SetText(WARDROBE_TXT_NEWOUTFITNAME);
    Wardrobe_PopupFunction = "[Add]";
    Wardrobe_UnselectAllMainMenuItems();    
    Wardrobe_ToggleMainMenuFrameVisibility(false);    
    WardrobeNamePopup:Show();
end


---------------------------------------------------------------------------------
-- when clicking on the close button
---------------------------------------------------------------------------------
function Wardrobe_MainMenuCloseButton()
    Wardrobe_ColorCycle_MainMenuFrame(false);
    this:GetParent():Hide();
end


---------------------------------------------------------------------------------
-- when clicking on the edit outfit button
---------------------------------------------------------------------------------
function Wardrobe_EditOutfitButtonClick()
    local selectedOutfit = Wardrobe_FindSelectedOutfit();    
    
    if (selectedOutfit) then
        Wardrobe_NewWardrobeName = Wardrobe_Config[WD_realmID][WD_charID].Outfit[selectedOutfit].OutfitName;
        Wardrobe_Rename_OldName = Wardrobe_NewWardrobeName;
        local Wardrobe_PopupWindowHeader = getglobal("WardrobeNamePopupText");
        Wardrobe_PopupWindowHeader:SetText("New Name");
        WardrobeNamePopupEditBox:SetText(Wardrobe_NewWardrobeName);
        Wardrobe_PopupFunction = "[Edit]";
        Wardrobe_ToggleMainMenuFrameVisibility(false);    
        WardrobeNamePopup:Show();
    end
end


---------------------------------------------------------------------------------
-- when clicking on the update outfit button
---------------------------------------------------------------------------------
function Wardrobe_UpdateOutfitButtonClick()
    local selectedOutfit = Wardrobe_FindSelectedOutfit();    
    
    if (selectedOutfit) then
        Wardrobe_NewWardrobeName = Wardrobe_Config[WD_realmID][WD_charID].Outfit[selectedOutfit].OutfitName;
        Wardrobe_PopupFunction = "[Update]";
        Wardrobe_ShowWardrobeConfigurationScreen();
    end
end

---------------------------------------------------------------------------------
-- when clicking the move up or move down buttons
---------------------------------------------------------------------------------
function Wardrobe_MoveOutfit_OnClick(direction)
    local outfitNum = Wardrobe_FindSelectedOutfit();
    
    if (outfitNum) then
        local swapNum = Wardrobe_OrderOutfit(outfitNum, direction);
        Wardrobe_SortOutfits();
        Wardrobe_PopulateMainMenu(true);
    end
end


---------------------------------------------------------------------------------
-- when clicking the delete outfit button
---------------------------------------------------------------------------------
function Wardrobe_DeleteOutfit_OnClick()
    selectedOutfit = nil;
    for i = 1, table.getn(Wardrobe_Config[WD_realmID][WD_charID].Outfit) do
        if (Wardrobe_Config[WD_realmID][WD_charID].Outfit[i].Selected) then
            selectedOutfit = i;
            break;
        end
    end
    
    if (selectedOutfit) then
        Wardrobe_PopupFunction = "DeleteFromSort";
        WardrobeNamePopupEditBox:SetText(Wardrobe_Config[WD_realmID][WD_charID].Outfit[selectedOutfit].OutfitName);
        WardrobePopupConfirm:Show();
        Wardrobe_ToggleMainMenuFrameVisibility(false);
        WardrobePopupConfirmText:SetText(WARDROBE_TXT_REALLYDELETEOUTFIT.."\n\n"..Wardrobe_Config[WD_realmID][WD_charID].Outfit[selectedOutfit].OutfitName);
    else
        UIErrorsFrame:AddMessage(WARDROBE_TXT_PLEASESELECTDELETE, 1.0, 0.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
    end
end


--===============================================================================
--
-- Color picker
--
--===============================================================================

---------------------------------------------------------------------------------
-- when clicking on a color in the color picker
---------------------------------------------------------------------------------
function Wardrobe_ColorPickFrameColor_OnClick()
    local selectedOutfit = Wardrobe_FindSelectedOutfit();
    local buttonName = this:GetName();
    local x, y = string.find(buttonName, "%d+");
    WardrobeColorPickFrame.buttonNum = tonumber(string.sub(buttonName, x, y));
    WardrobeColorPickFrameExampleText:SetTextColor(WARDROBE_TEXTCOLORS[WardrobeColorPickFrame.buttonNum][1], 
                                                   WARDROBE_TEXTCOLORS[WardrobeColorPickFrame.buttonNum][2], 
                                                   WARDROBE_TEXTCOLORS[WardrobeColorPickFrame.buttonNum][3]);    

    if (Wardrobe_EnteredColorPickerFromPaperdollFrame) then
        Wardrobe_CurrentOutfitButtonColor = WardrobeColorPickFrame.buttonNum;
    end    
end


---------------------------------------------------------------------------------
-- Show the color selection menu
---------------------------------------------------------------------------------
function Wardrobe_ShowColorPickFrame()

    -- figure out where we were called from
    if (WardrobeMainMenuFrame:IsVisible()) then
        Wardrobe_EnteredColorPickerFromPaperdollFrame = false;
    else
        Wardrobe_EnteredColorPickerFromPaperdollFrame = true;
    end
    
    local selectedOutfit = Wardrobe_FindSelectedOutfit();

    if (selectedOutfit or Wardrobe_EnteredColorPickerFromPaperdollFrame) then

        WardrobeColorPickFrame:SetAlpha(1.0);
        WardrobeColorPickFrame:Show();
        WardrobeColorPickFrameGrid:SetFrameLevel(WardrobeColorPickFrameGrid:GetFrameLevel() + 1);
        for i = 1, 24 do
            getglobal("WardrobeColorPickFrameBox"..tostring(i).."Texture"):SetVertexColor(WARDROBE_TEXTCOLORS[i][1],WARDROBE_TEXTCOLORS[i][2],WARDROBE_TEXTCOLORS[i][3],1.0);
            getglobal("WardrobeColorPickFrameBox"..tostring(i)):SetFrameLevel(WardrobeColorPickFrameGrid:GetFrameLevel() - 1);
        end

        if (Wardrobe_EnteredColorPickerFromPaperdollFrame) then
            WardrobeColorPickFrameExampleText:SetText(Wardrobe_NewWardrobeName);
            WardrobeColorPickFrameExampleText:SetTextColor(WARDROBE_TEXTCOLORS[Wardrobe_CurrentOutfitButtonColor][1], WARDROBE_TEXTCOLORS[Wardrobe_CurrentOutfitButtonColor][2], WARDROBE_TEXTCOLORS[Wardrobe_CurrentOutfitButtonColor][3]);    
        else
            WardrobeColorPickFrameExampleText:SetText(Wardrobe_Config[WD_realmID][WD_charID].Outfit[selectedOutfit].OutfitName);
            local colorNum = Wardrobe_Config[WD_realmID][WD_charID].Outfit[selectedOutfit].ButtonColor;
            WardrobeColorPickFrameExampleText:SetTextColor(WARDROBE_TEXTCOLORS[colorNum][1], WARDROBE_TEXTCOLORS[colorNum][2], WARDROBE_TEXTCOLORS[colorNum][3]);    
        end
        
        if (not Wardrobe_EnteredColorPickerFromPaperdollFrame) then Wardrobe_ToggleMainMenuFrameVisibility(false); end

    end    
end


---------------------------------------------------------------------------------
-- Accept the color selection menu
---------------------------------------------------------------------------------
function Wardrobe_AcceptColorPickFrame()
    if (Wardrobe_EnteredColorPickerFromPaperdollFrame) then
        Wardrobe_RefreshCharacterPanel();
    end
    if (WardrobeColorPickFrame.buttonNum) then
        Wardrobe_SetSelectedOutfitColor(WardrobeColorPickFrame.buttonNum); 
        Wardrobe_PopulateMainMenu();        
    end
    Wardrobe_HideColorPickFrame();
end


---------------------------------------------------------------------------------
-- set the color of the selected outfit based on which button was clicked in the color selector
---------------------------------------------------------------------------------
function Wardrobe_SetSelectedOutfitColor(num)
    local selectedOutfit = Wardrobe_FindSelectedOutfit();

    if (selectedOutfit) then
        Wardrobe_Config[WD_realmID][WD_charID].Outfit[selectedOutfit].ButtonColor = num;        
        Wardrobe_PopulateMainMenu();
    end
end

---------------------------------------------------------------------------------
-- Hide the color selection menu
---------------------------------------------------------------------------------
function Wardrobe_HideColorPickFrame()
    if (not Wardrobe_EnteredColorPickerFromPaperdollFrame) then
        Wardrobe_ToggleMainMenuFrameVisibility(true);
    end
    WardrobeColorPickFrame.buttonNum = nil;
    WardrobeColorPickFrame:Hide();
end


---------------------------------------------------------------------------------
-- Show the tooltip text
---------------------------------------------------------------------------------
function Wardrobe_ShowButtonTooltip(theText1, theText2, theText3, theText4, theText5)

    GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
    
    GameTooltip:SetText(theText1, 0.39, 0.77, 0.16);
        
    -- add description lines to the tooltip
    if (theText2) then
        GameTooltip:AddLine(theText2, 0.82, 0.24, 0.79);
    end
    if (theText3) then
        GameTooltip:AddLine(theText3, 0.82, 0.24, 0.79);
    end
    if (theText4) then
        GameTooltip:AddLine(theText4, 0.82, 0.24, 0.79);
    end
    if (theText5) then
        GameTooltip:AddLine(theText5, 0.82, 0.24, 0.79);
    end
    
    -- Adjust width and height to account for new lines and show the tooltip
    -- (the Show() command automatically adjusts the width/height)
    GameTooltip:Show();
end
