
TITAN_WHISPERCAST_ID = "WhisperCast";
TITAN_WHISPERCAST_BUTTON_ARTWORK_PATH = "Interface\\AddOns\\WhisperCast\\Titan\\";

local TitanPanelWhisperCast_flashButton = false
local TitanPanelWhisperCast_flashColor = { r=1, g=1, b=1 }
local TitanPanelWhisperCast_flashTime = 1

function TitanPanelWhisperCast_OnLoad()
    WhisperCast_registerGUI( {
        initialize = "TitanPanelWhisperCast_initialize",
        sync = "TitanPanelWhisperCast_sync",
        onupdate = "TitanPanelWhisperCast_onupdate",
    } )

	this.registry = { 
		id = TITAN_WHISPERCAST_ID,
		menuText = WCLocale.UI.text.whisperCast, 
		buttonTextFunction = "TitanPanelWhisperCast_GetButtonText", 
		tooltipTitle = format(WCLocale.UI.text.whisperCastVersion, WhisperCast_Version),
		tooltipTextFunction = "TitanPanelWhisperCast_GetTooltipText",
		icon = "Interface\\Icons\\Spell_Frost_WindWalkOn.blp",
		iconWidth = 16,
		savedVariables = {
			ShowLabelText = 1,
			ShowIcon = 1,
            FlashQueue = 1,
		}
	};
end

function TitanPanelWhisperCast_initialize()
    -- nothing to do
end

function TitanPanelWhisperCast_sync( attrib )
    if ( attrib == "queue" ) then
        TitanPanelButton_UpdateButton(TITAN_WHISPERCAST_ID)
        --TitanPanelButton_UpdateTooltip() -- doesn't work when spell is triggered from hot-key
    end
end

function TitanPanelWhisperCast_onupdate( arg1 )

    if ( TitanPanelWhisperCast_flashButton and
         TitanGetVar(TITAN_WHISPERCAST_ID, "FlashQueue") ) then

        local cyclePercent = WhisperCastUtil_GetCyclePercent(
            "WCTitanPlugin",
            arg1,
            TitanPanelWhisperCast_flashTime )

        -- cycle from 0.7 to 1.0 alpha
        local alpha = cyclePercent * 0.3 + 0.7

        TitanPanelWhisperCastButtonText:SetTextColor(
            TitanPanelWhisperCast_flashColor.r,
            TitanPanelWhisperCast_flashColor.g,
            TitanPanelWhisperCast_flashColor.b ,
            alpha )
    end
end

function TitanPanelWhisperCast_GetButtonText(id)
    local richText = ""
    local color = { r=1, g=1, b=1 }

    TitanPanelWhisperCast_flashButton = false

    if ( not WhisperCast_Spells ) then
        richText = WCLocale.UI.text.queueBriefUnavailable;
        color = { r=0.7, g=0.7, b=0.7 }
    else
   	    richText = WhisperCast_Runtime.queueBrief
        color = WhisperCast_Runtime.queueBriefColor

        TitanPanelWhisperCast_flashButton = ( WhisperCast_Runtime.queueLength > 0 )
        TitanPanelWhisperCast_flashColor = color
    end

	-- adding some space if the user elects to not show label text	
	if ( not TitanGetVar(TITAN_WHISPERCAST_ID, "ShowLabelText") ) then
		richText = " "..richText;	
	end

    -- set the text color
    TitanPanelWhisperCastButtonText:SetTextColor( color.r, color.g, color.b )

	return WCLocale.UI.text.whisperCast..": ", richText;
end

function TitanPanelWhisperCast_OnClick(arg1)
	if ( arg1 == "LeftButton" ) then
        if ( IsShiftKeyDown() ) then
		    WhisperCast_Clear();
        else
		    WhisperCast_Cast();
        end
	end
end

function TitanPanelRightClickMenu_PrepareWhisperCastMenu()
    if ( WhisperCast_Spells ) then
        if ( UIDROPDOWNMENU_MENU_LEVEL == 1 ) then
            local info = { };
            info.text = WCLocale.UI.text.dropdownCast;
            info.notCheckable = 1;
            info.func = WhisperCast_Cast;
            UIDropDownMenu_AddButton(info);

            info.text = WCLocale.UI.text.dropdownClear;
            info.notCheckable = 1;
            info.func = WhisperCast_Clear;
            UIDropDownMenu_AddButton(info);

            TitanPanelRightClickMenu_AddSpacer();
        end

        WhisperCast_DropDownInitialize();
    end
    if ( UIDROPDOWNMENU_MENU_LEVEL == 1 ) then
        if ( WhisperCast_Spells ) then
            TitanPanelRightClickMenu_AddSpacer();

            TitanPanelRightClickMenu_AddToggleVar(WCLocale.UI.text.dropdownFlashQueue, TITAN_WHISPERCAST_ID, "FlashQueue");
        end
        TitanPanelRightClickMenu_AddToggleIcon(TITAN_WHISPERCAST_ID);	
        TitanPanelRightClickMenu_AddToggleLabelText(TITAN_WHISPERCAST_ID);	
        TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_WHISPERCAST_ID, TITAN_PANEL_MENU_FUNC_HIDE);
    end
end

function TitanPanelWhisperCast_GetTooltipText()
    
    local richText = WCLocale.UI.text.mouseoverTitanHint.."\n\n";
    
    if ( WhisperCast_Runtime.queueLength == 0 ) then
        richText = richText..WCLocale.UI.text.queueBriefEmpty;
    else
        richText = richText..WhisperCast_Runtime.queueDetail;
    end
    return richText;
end
