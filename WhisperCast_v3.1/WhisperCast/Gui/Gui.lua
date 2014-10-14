
local WhisperCastGui_flashButton = false
local WhisperCastGui_flashColor = { r=1, g=1, b=1 }
local WhisperCastGui_flashTime = 1

function WhisperCastGui_sync( attrib )

    if ( attrib == "enable" ) then
        -- nothing to do

    elseif ( attrib == "hidden" ) then
        if ( WhisperCast_Profile.gui.hidden == 1 ) then
            WhisperCastGuiFrame:Hide()
        else
            WhisperCastGuiFrame:Show();
        end

    elseif ( attrib == "alpha" ) then
        WhisperCastGuiFrame:SetAlpha(WhisperCast_Profile.mainalpha);
        WhisperCastGuiFrame:SetBackdropBorderColor(0, 0, 0, WhisperCast_Profile.backalpha);
        WhisperCastGuiFrame:SetBackdropColor(0, 0, 0, WhisperCast_Profile.backalpha);

    elseif ( attrib == "minimize" ) then
        if ( WhisperCast_Profile.gui.minimize == 1 ) then
            WhisperCastScrollFrame:Hide()
            WhisperCastGuiFrame:SetHeight(25);
        else
            WhisperCastScrollFrame:Show()
            WhisperCastGuiFrame:SetHeight(126);
        end

    elseif ( attrib == "queue" ) then
        WhisperCastStatusText:SetText( WhisperCast_Runtime.queueBrief )
        WhisperCastStatusText:SetTextColor(
            WhisperCast_Runtime.queueBriefColor.r,
            WhisperCast_Runtime.queueBriefColor.g,
            WhisperCast_Runtime.queueBriefColor.b )

        WhisperCastQueueText:SetText( WhisperCast_Runtime.queueDetail );
        WhisperCastScrollFrame:UpdateScrollChildRect();
        WhisperCastScrollFrameScrollBar:SetValue(0);

        WhisperCastGui_flashButton = ( WhisperCast_Runtime.queueLength > 0 )
        WhisperCastGui_flashColor = WhisperCast_Runtime.queueBriefColor
    end
end

function WhisperCastGui_onupdate( arg1 )

    if ( WhisperCast_Spells and
         WhisperCastGui_flashButton and
         WhisperCast_Profile.gui.flashqueue == 1 ) then

        local cyclePercent = WhisperCastUtil_GetCyclePercent(
            "WCGui", arg1, WhisperCastGui_flashTime )

        -- cycle from 0.7 to 1.0 alpha
        local alpha = cyclePercent * 0.3 + 0.7

        WhisperCastStatusText:SetTextColor(
            WhisperCastGui_flashColor.r,
            WhisperCastGui_flashColor.g,
            WhisperCastGui_flashColor.b ,
            alpha )
    end
end

------------------------------------------------------------------------------
-- Externally access functions
------------------------------------------------------------------------------

function WhisperCastGui_OnLoad()
    WhisperCast_registerGUI( {
        initialize = "WhisperCastGui_initialize",
        sync = "WhisperCastGui_sync",
        onupdate = "WhisperCastGui_onupdate",
        slash = "WhisperCastGui_SlashCommandHandler",
        reset = "WhisperCastGui_reset",
    } )

    WhisperCastCastButton:SetText(WCLocale.UI.text.buttonTextCast)
    WhisperCastClearButton:SetText(WCLocale.UI.text.buttonTextClear)
end

function WhisperCastGui_OnEvent(event)

end

function WhisperCastGui_initialize()

    if ( WhisperCast_Spells ) then
        WhisperCastGui_sync("minimize")
        WhisperCastGui_sync("hidden")
        WhisperCastGui_sync("alpha")
    else
        WhisperCastGuiFrame:Hide()
    end
end

function WhisperCastGui_reset()
    WhisperCastGui_sync("minimize")
    WhisperCastGui_sync("hidden")
    WhisperCastGui_sync("alpha")

    WhisperCastGuiFrame:ClearAllPoints()
    WhisperCastGuiFrame:SetPoint("TOPLEFT","UIParent","LEFT",0,0)
end

function WhisperCastGui_ToggleMinimized(sync)
    if ( not sync ) then
        WhisperCast_ToggleProfileKey( {"gui","minimize"} );
    end
    WhisperCastGui_sync("minimize");
end

function WhisperCastGui_ToggleHidden(sync)
    if ( not sync ) then
        WhisperCast_ToggleProfileKey( {"gui","hidden"} );
    end
    WhisperCastGui_sync("hidden");
end

function WhisperCastGui_ToggleFlashQueue(sync)
    if ( not sync ) then
        WhisperCast_ToggleProfileKey( {"gui","flashqueue"} );
    end
    WhisperCastGui_sync("queue");
end

function WhisperCastGui_ShowTooltip(msg)
    -- put the tool tip in the default position
    GameTooltip:SetOwner(this, "ANCHOR_TOPRIGHT");
    GameTooltip:SetText(msg, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g,
        NORMAL_FONT_COLOR.b, 1);
end

function WhisperCastGui_SlashCommandHandler( msg, command, option )
    if( command == WCLocale.UI.text.chatCmdShow ) then
        WhisperCast_Profile.gui.hidden = 0
        WhisperCastGui_ToggleHidden(true)
    elseif( command == WCLocale.UI.text.chatCmdHide ) then
        WhisperCast_Profile.gui.hidden = 1
        WhisperCastGui_ToggleHidden(true)
    elseif( command == WCLocale.UI.text.chatCmdMin ) then
        WhisperCast_Profile.gui.minimize = 1
        WhisperCastGui_ToggleMinimized(true)
    elseif( command == WCLocale.UI.text.chatCmdMax ) then
        WhisperCast_Profile.gui.minimize = 0
        WhisperCastGui_ToggleMinimized(true)
    else
        return false
    end

    return true
end

function WhisperCastGui_ToggleDropDown()
	WhisperCastGuiDropDown.point = "BOTTOMLEFT";
	WhisperCastGuiDropDown.relativePoint = "TOPLEFT";
	ToggleDropDownMenu(1, nil, WhisperCastGuiDropDown, "WhisperCastCastButton", 0, 0);
end

function WhisperCastGui_DropDownInitialize()

    if ( not WhisperCast_Spells ) then return end

    WhisperCast_DropDownInitialize()

	local info = {};

    if ( UIDROPDOWNMENU_MENU_LEVEL == 1 ) then

		info = {};
    	info.disabled = 1;
        UIDropDownMenu_AddButton(info);

        info = { };
        info.text = WCLocale.UI.text.dropdownFlashQueue;
        info.keepShownOnClick = 1;
        info.checked = WhisperCast_getChecked( WhisperCast_Profile.gui.flashqueue );
        info.func = WhisperCastGui_ToggleFlashQueue;
        UIDropDownMenu_AddButton(info);

        info = { };
        info.text = WCLocale.UI.text.dropdownMinimize;
        info.keepShownOnClick = 1;
        info.checked = WhisperCast_getChecked( WhisperCast_Profile.gui.minimize );
        info.func = WhisperCastGui_ToggleMinimized;
        UIDropDownMenu_AddButton(info);

        info = { };
        info.text = WCLocale.UI.text.dropdownHide;
        info.keepShownOnClick = 1;
        info.checked = WhisperCast_getChecked( WhisperCast_Profile.gui.hidden );
        info.func = WhisperCastGui_ToggleHidden;
        UIDropDownMenu_AddButton(info);
    end
end        

function WhisperCastGuiDropDown_OnLoad()
    UIDropDownMenu_Initialize(this, WhisperCastGui_DropDownInitialize, "MENU");
	UIDropDownMenu_SetButtonWidth(50);
	UIDropDownMenu_SetWidth(50);
end
