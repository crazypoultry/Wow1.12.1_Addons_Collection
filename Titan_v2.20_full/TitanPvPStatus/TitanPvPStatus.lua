-- Plug-in for Titan Panel to show PvP Status, PvP Cooldown time remaining and PvP Zone.

BINDING_HEADER_PVPSTATUS = "PvPStatus";

TITAN_PVPSTATUS_ICON = "Interface\\AddOns\\TitanPvPStatus\\TitanPvPStatus";
TITAN_PVPSTATUS_FREQUENCY=1.0;
PVP_STATUS = {};

-- Version information
local TitanPvPStatusName = "TitanPvPStatus";
local TitanPvPStatusVersion = "1.6.1";

local remainingTime = 300;
local elapsedTime = 0;
local isPVPFLAGED = false;
local PvPStatusText="";
local PvPZoneText="";

function TitanPanelPvPStatusButton_OnLoad()
	this.registry={
		id="PvPStatus",
		menuText=TITAN_PVPSTATUS_MENU_TEXT,
		buttonTextFunction="TitanPanelPvPStatusButton_GetButtonText",
		tooltipTitle = TITAN_PVPSTATUS_TOOLTIP,
		tooltipTextFunction = "TitanPanelPvPStatusButton_GetTooltipText",
		frequency=TITAN_PVPSTATUS_FREQUENCY,
		icon = TITAN_PVPSTATUS_ICON,	
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
		}
	}

    -- Register events
	this:RegisterEvent("UNIT_PVP_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");
      this:RegisterEvent("PLAYER_ENTERING_WORLD");
      this:RegisterEvent("PLAYER_FLAGS_CHANGED");

	SLASH_PVPStatus1 = "/pvps";
	SlashCmdList["PvPStatus"] = PvPStatus_SlashHandler;
end

function TitanPanelPvPStatusButton_OnEvent()
	local id="PvPStatus";

	if (event == "UNIT_PVP_UPDATE") then
        	if ( arg1 == "player" ) then
        		PvPStatus_OnPVPUPDATE(arg1,arg2);
        	end
	end
	if (event == "VARIABLES_LOADED") then
		if ( PVP_STATUS.isPVP ~= 1 ) then
			PVP_STATUS.isPVP = 0
		end
	end

        if (event == "PLAYER_ENTERING_WORLD") then
		if ( UnitFactionGroup("player") == FACTION_ALLIANCE ) then
			TITAN_PVPSTATUS_ICON = "Interface\\PvPRankBadges\\PvPRankAlliance";
		else
			TITAN_PVPSTATUS_ICON = "Interface\\PvPRankBadges\\PvPRankHorde";
		end
		TitanPlugins[id].icon = TITAN_PVPSTATUS_ICON;

                if ( UnitIsPVP("player") == 1 ) then
                        PVP_STATUS.isPVP = 1;
                        PvPStatusText="Active";
                else
                        PVP_STATUS.isPVP = 0;
                        PvPStatusText="Unflagged";
                end
        end
        if (event == "PLAYER_FLAGS_CHANGED") then
                if ( UnitIsPVP("player") ~= 1 ) then
                        PVP_STATUS.isPVP = 0;
                        PvPStatusText="Unflagged";
                end
        end

	TitanPanelButton_UpdateButton("PvPStatus");
	TitanPanelButton_UpdateTooltip();

end

function PvPStatus_SlashHandler(msg)
	if ( not msg or msg == "" ) then
		if ( PVP_STATUS.isPVP == 0 ) then
			PVP_STATUS.isPVP = 1;
			PvPStatusText="Active";
			TogglePVP();
		elseif ( PVP_STATUS.isPVP == 1 ) then
			PVP_STATUS.isPVP = 0;
			PvPStatus_OnPVPUPDATE(arg1, arg2);
			TogglePVP();
		end
	end
end

function PvPStatus_OnPVPUPDATE(a1,a2)
	if ( PVP_STATUS.isPVP == 0 ) then
        if (UnitIsPVP("player") == 1) then
			isPVPFLAGED = true;
                	remainingTime = 300;
                	elapsedTime = 0;
             	PvPStatusText="5:00";
	  elseif (UnitIsPVP("player") ~= 1) then
			isPVPFLAGED = false;
                	PvPStatusText="Unflagged";
        end
	end
end

function PvPStatus_OnUpdate(elapse)
        if (isPVPFLAGED == true and PVP_STATUS.isPVP == 0) then

		if (GetZonePVPInfo("pvpType") == "contested") then
			PvPStatusText="Contested";
			PvPZoneText="Contested";
			remainingTime = 300;

		elseif (GetZonePVPInfo("pvpType") == "hostile") then
			PvPStatusText="Hostile";
			PvPZoneText="Hostile";
			remainingTime = 300;

		else 
                elapsedTime = elapsedTime + elapse;

			if (elapsedTime > 1) then
                        local sTemp = remainingTime;
                        local mTemp = 0;

                        while (sTemp >= 60) do
                                sTemp = sTemp - 60;
                                mTemp = mTemp + 1;
                        end

                        if (sTemp < 10) then
                                sTemp = "0" .. sTemp;
                        end

                        elapsedTime = elapsedTime - 1;
                        remainingTime = remainingTime - 1;

                        PvPStatusText="" .. mTemp .. ":" .. sTemp;

				if (remainingTime < 0) then
					isPVPFLAGED = false;
                			PvPStatusText="Unflagged";
				end
			end

		end

        end

	TitanPanelButton_UpdateButton("PvPStatus");
	TitanPanelButton_UpdateTooltip();
end

function TitanPanelPVPStatusButton_OnClick()

	if (IsShiftKeyDown()) then
		if ( PVP_STATUS.isPVP == 0 ) then
			PVP_STATUS.isPVP = 1;
			PvPStatusText="Active";
			TogglePVP();
		elseif ( PVP_STATUS.isPVP == 1 ) then
			PVP_STATUS.isPVP = 0;
			PvPStatus_OnPVPUPDATE(arg1, arg2);
			TogglePVP();
		end
	end
end

function TitanPanelPvPStatusButton_GetButtonText(id)
	local buttontext = "";

	-- put in different pvp scenarios incase we may need to use different text
      if (isPVPFLAGED == true and PVP_STATUS.isPVP == 0) then
		if (GetZonePVPInfo("pvpType") == "contested") then
			buttontext = format(TITAN_PVPSTATUS_BUTTON_TEXT,TitanUtils_GetHighlightText(PvPStatusText))
		elseif (GetZonePVPInfo("pvpType") == "hostile") then
			buttontext = format(TITAN_PVPSTATUS_BUTTON_TEXT,TitanUtils_GetRedText(PvPStatusText))
		else
			buttontext = format(TITAN_PVPSTATUS_BUTTON_TEXT,TitanUtils_GetGreenText(PvPStatusText))
	      end
	elseif (isPVPFLAGED == true and PVP_STATUS.isPVP == 1) then
		if (GetZonePVPInfo("pvpType") == "contested") then
			buttontext = format(TITAN_PVPSTATUS_BUTTON_TEXT,TitanUtils_GetHighlightText(PvPStatusText))
		elseif (GetZonePVPInfo("pvpType") == "hostile") then
			buttontext = format(TITAN_PVPSTATUS_BUTTON_TEXT,TitanUtils_GetRedText(PvPStatusText))
		else
			buttontext = format(TITAN_PVPSTATUS_BUTTON_TEXT,TitanUtils_GetGreenText(PvPStatusText))
	      end
	else
		if (GetZonePVPInfo("pvpType") == "contested") then
			buttontext = format(TITAN_PVPSTATUS_BUTTON_TEXT,TitanUtils_GetHighlightText(PvPStatusText))
		elseif (GetZonePVPInfo("pvpType") == "hostile") then
			buttontext = format(TITAN_PVPSTATUS_BUTTON_TEXT,TitanUtils_GetRedText(PvPStatusText))
		else
			buttontext = format(TITAN_PVPSTATUS_BUTTON_TEXT,TitanUtils_GetGreenText(PvPStatusText))
	      end
      end

	-- supports turning off labels
	return TITAN_PVPSTATUS_BUTTON_LABEL, buttontext;
end

function TitanPanelPvPStatusButton_GetTooltipText()
-- put in different pvp scenarios incase we may need to use different text
      if (isPVPFLAGED == true and PVP_STATUS.isPVP == 0) then
		if (GetZonePVPInfo("pvpType") == "contested") then
			return "".. format(TITAN_PVPSTATUS_TOOLTIP_CLICK).."\n".."\n"..
			format(TITAN_PVPSTATUS_TOOLTIP_STATUS,TitanUtils_GetHighlightText(PvPStatusText)).."\n"..
			format(TITAN_PVPSTATUS_TOOLTIP_ZONE, TitanUtils_GetHighlightText("Contested"));
		elseif (GetZonePVPInfo("pvpType") == "hostile") then
			return format(TITAN_PVPSTATUS_TOOLTIP_CLICK).."\n".."\n"..
			format(TITAN_PVPSTATUS_TOOLTIP_STATUS,TitanUtils_GetRedText(PvPStatusText)).."\n"..
			format(TITAN_PVPSTATUS_TOOLTIP_ZONE, TitanUtils_GetHighlightText("Hostile"));
		else
			return "".. format(TITAN_PVPSTATUS_TOOLTIP_CLICK).."\n".."\n"..
			format(TITAN_PVPSTATUS_TOOLTIP_STATUS,TitanUtils_GetHighlightText("Cooldown")).."\n"..
			format(TITAN_PVPSTATUS_TOOLTIP_ZONE, TitanUtils_GetGreenText("Friendly"));
	      end
	elseif (isPVPFLAGED == true and PVP_STATUS.isPVP == 1) then
		if (GetZonePVPInfo("pvpType") == "contested") then
			return "".. format(TITAN_PVPSTATUS_TOOLTIP_CLICK).."\n".."\n"..
			format(TITAN_PVPSTATUS_TOOLTIP_STATUS,TitanUtils_GetHighlightText(PvPStatusText)).."\n"..
			format(TITAN_PVPSTATUS_TOOLTIP_ZONE, TitanUtils_GetHighlightText("Contested"));
		elseif (GetZonePVPInfo("pvpType") == "hostile") then
			return "".. format(TITAN_PVPSTATUS_TOOLTIP_CLICK).."\n".."\n"..
			format(TITAN_PVPSTATUS_TOOLTIP_STATUS,TitanUtils_GetRedText(PvPStatusText)).."\n"..
			format(TITAN_PVPSTATUS_TOOLTIP_ZONE, TitanUtils_GetHighlightText("Hostile"));
		else
			return "".. format(TITAN_PVPSTATUS_TOOLTIP_CLICK).."\n".."\n"..
			format(TITAN_PVPSTATUS_TOOLTIP_STATUS,TitanUtils_GetHighlightText(PvPStatusText)).."\n"..
			format(TITAN_PVPSTATUS_TOOLTIP_ZONE, TitanUtils_GetGreenText("Friendly"));
	      end
	else
		if (GetZonePVPInfo("pvpType") == "contested") then
	        	return "".. format(TITAN_PVPSTATUS_TOOLTIP_CLICK).."\n".."\n"..
			format(TITAN_PVPSTATUS_TOOLTIP_STATUS,TitanUtils_GetHighlightText(PvPStatusText)).."\n"..
			format(TITAN_PVPSTATUS_TOOLTIP_ZONE, TitanUtils_GetHighlightText("Contested"));
		elseif (GetZonePVPInfo("pvpType") == "hostile") then
			return "".. format(TITAN_PVPSTATUS_TOOLTIP_CLICK).."\n".."\n"..
			format(TITAN_PVPSTATUS_TOOLTIP_STATUS,TitanUtils_GetRedText(PvPStatusText)).."\n"..
			format(TITAN_PVPSTATUS_TOOLTIP_ZONE, TitanUtils_GetHighlightText("Hostile"));
		else
			return "".. format(TITAN_PVPSTATUS_TOOLTIP_CLICK).."\n".."\n"..
			format(TITAN_PVPSTATUS_TOOLTIP_STATUS,TitanUtils_GetHighlightText(PvPStatusText)).."\n"..
			format(TITAN_PVPSTATUS_TOOLTIP_ZONE, TitanUtils_GetGreenText("Friendly"));
	      end
      end
end

function TitanPanelRightClickMenu_PreparePvPStatusMenu()
	local id="PvPStatus"
	local info
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText)

	TitanPanelRightClickMenu_AddSpacer();

	TitanPanelRightClickMenu_AddToggleLabelText("PvPStatus");

	TitanPanelRightClickMenu_AddSpacer();

	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_CUSTOMIZE..TITAN_PANEL_MENU_POPUP_IND,id,TITAN_PANEL_MENU_FUNC_CUSTOMIZE)
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE,id,TITAN_PANEL_MENU_FUNC_HIDE)
end