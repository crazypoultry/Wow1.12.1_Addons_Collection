--[[
	Titan Panel [Recap]: Titan plugin for Recap stats
	copyright 2006 by Gello (gello_biafra@hotmail.com)
	and chicogrande (jluzier@gmail.com)
	for use with Recap 2.6+
]]

-- globals
TITAN_RECAP_ID = "Recap";
TITAN_RECAP_VERSION = "1.25";
TITAN_RECAP_BUTTON_ARTWORK_PATH = "Interface\\AddOns\\Recap\\";
TITAN_RECAP_BUTTON_TOGGLE_MONITOR = "TitanPanelRecap_TogglePause";

-- colors
TR = {};
TR.Color = {};
TR.Color["red"] = { r = 1.0, g = 0.0, b = 0.0 }
TR.Color["green"] = { r = 0.0, g = 1.0, b = 0.0 }
TR.Color["blue"] = { r = 0.0, g = 0.0, b = 1.0 }
TR.Color["white"] = { r = 1.0, g = 1.0, b = 1.0 }
TR.Color["magenta"] = { r = 1.0, g = 0.0, b = 1.0 }
TR.Color["yellow"] = { r = 1.0, g = 1.0, b = 0.0 }
TR.Color["cyan"] = { r = 0.0, g = 1.0, b = 1.0 }
TR.Color["gray"] = { r = 0.7, g = 0.7, b = 0.7 }
TR.Color["orange"] = { r = 1.0, g = 0.6, b = 0.0 }

local state = "Idle";
local yourdps = 0;
local dpsin = 0;
local dpsout = 0;
local healing = 0;
local overheal = 0;
local maxhit = 0;
local totaldps = 0;
local totaldpsin = 0;
local viewtype = 0;

-- access values in Recap to display in the plugin
function TitanPanelRecap_Update()
	state = recap.Opt.State.value;
	yourdps = RecapMinYourDPS_Text:GetText();
	dpsin = RecapMinDPSIn_Text:GetText();
	dpsout = RecapMinDPSOut_Text:GetText();
	healing = RecapTotals_Heal:GetText() or 0;
	overheal = RecapTotals_Over:GetText() or 0;
	maxhit = RecapTotals_MaxHit:GetText();
	totaldps = RecapTotals_DPS:GetText();
	totaldpsin = RecapTotals_DPSIn:GetText();
	viewtype = recap_temp.Local.LastAll[recap.Opt.View.value]
	TitanPanelButton_UpdateButton(TITAN_RECAP_ID);
end

function TitanPanelRecapButton_OnLoad()
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("Titan Panel [Recap] v"..TITAN_RECAP_VERSION.." loaded");
	end
	this.registry = { 
		id = "Recap",
		menuText = "Recap",
		version = TITAN_RECAP_VERSION, 
		buttonTextFunction = "TitanPanelRecapButton_GetButtonText", 
		tooltipTitle = "Recap v"..tostring(Recap_Version),
		tooltipTextFunction = "TitanPanelRecapButton_GetTooltipText";
		icon = TITAN_RECAP_BUTTON_ARTWORK_PATH.."Recap-Status";
		iconWidth = 16;
		savedVariables = {
			ShowLabelText = 1,  -- Default to 1
			ShowDpsIn = 1;
			ShowDpsOut = 1;
			ShowYourDps = 1;
			ShowHealing = 1;
			ShowOverheal = 1;
			ShowMaxHit = 1;
			ShowIcon = 1;
		}
	};
end

function TitanPanelRecapButton_GetButtonText(id)
	-- If id not nil, return corresponding plugin button
	-- Otherwise return this button and derive the real id
	local button, id = TitanUtils_GetButton(id, true);
	local recapRichText = "";
	-- format the colored status bubble
	if (TitanGetVar(TITAN_RECAP_ID, "ShowIcon")) then
		recapIcon =	getglobal(button:GetName().."Icon");
		if state=="Idle" then
			recapIcon:SetVertexColor(.5,.5,.5)
		elseif state=="Active" then
			recapIcon:SetVertexColor(0,1,0)
		elseif state=="Stopped" then
			recapIcon:SetVertexColor(1,0,0)
		end
	end
		
	-- create the string to return to the display
	-- dps
	if (TitanGetVar(TITAN_RECAP_ID, "ShowYourDps")) then
		recapRichText = TitanUtils_GetHighlightText(yourdps).." "
	end
	-- maxhit
	if (TitanGetVar(TITAN_RECAP_ID, "ShowMaxHit")) then
		recapRichText = recapRichText..TitanUtils_GetColoredText(maxhit, TR.Color["orange"]).." ";
	end
	-- dpsin	
	if (TitanGetVar(TITAN_RECAP_ID, "ShowDpsIn")) then
		recapRichText = recapRichText..TitanUtils_GetRedText(dpsin).." "
	end
	-- dpsout
	if (TitanGetVar(TITAN_RECAP_ID, "ShowDpsOut")) then
		recapRichText = recapRichText..TitanUtils_GetGreenText(dpsout).." ";
	end
	-- healing
	if (TitanGetVar(TITAN_RECAP_ID, "ShowHealing")) then
		recapRichText = recapRichText..TitanUtils_GetColoredText(healing, TR.Color["cyan"]).." ";
	end	
	-- overhealing
	if (TitanGetVar(TITAN_RECAP_ID, "ShowOverheal")) then
		recapRichText = recapRichText..TitanUtils_GetColoredText(overheal, TR.Color["cyan"]).." ";
	end				
	-- adding some space if the user elects to not show label text	
	if (TitanGetVar(TITAN_RECAP_ID, "ShowLabelText")) then
		return TITAN_RECAP_BUTTON_LABEL, recapRichText;
	else
		recapRichText = TITAN_RECAP_BUTTON_NO_LABEL..recapRichText;	
		return TITAN_RECAP_BUTTON_LABEL, recapRichText;
	end
end

function TitanPanelRecap_OnMouseUp(arg1)
	if arg1=="LeftButton" then
		RecapFrame_Toggle();
	end
end

function TitanPanelRightClickMenu_PrepareRecapMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_RECAP_ID].menuText);

	-- dps
	local info = {};
	info.text = TITAN_RECAP_BUTTON_SHOWDPS;
	info.func = TitanPanelRecap_ToggleYourDPS;
	info.checked = TitanGetVar(TITAN_RECAP_ID, "ShowYourDps");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	
	-- dps in
	info.text = TITAN_RECAP_BUTTON_SHOWDPS_IN;
	info.func = TitanPanelRecap_ToggleDPSIn;
	info.checked = TitanGetVar(TITAN_RECAP_ID, "ShowDpsIn");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	
	-- dps out
	info.text = TITAN_RECAP_BUTTON_SHOWDPS_OUT;
	info.func = TitanPanelRecap_ToggleDPSOut;
	info.checked = TitanGetVar(TITAN_RECAP_ID, "ShowDpsOut");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	
	-- healing
	info.text = TITAN_RECAP_BUTTON_SHOWHEALING_TEXT;
	info.func = TitanPanelRecap_ToggleHealing;
	info.checked = TitanGetVar(TITAN_RECAP_ID, "ShowHealing");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	
	-- overhealing
	info.text = TITAN_RECAP_BUTTON_SHOWOVERHEAL_TEXT;
	info.func = TitanPanelRecap_ToggleOverheal;
	info.checked = TitanGetVar(TITAN_RECAP_ID, "ShowOverheal");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);
	
	-- maxhit
	info.text = TITAN_RECAP_BUTTON_SHOWMAXHIT_TEXT;
	info.func = TitanPanelRecap_ToggleMaxHit;
	info.checked = TitanGetVar(TITAN_RECAP_ID, "ShowMaxHit");
	info.keepShownOnClick = 1;
	UIDropDownMenu_AddButton(info);												

	TitanPanelRightClickMenu_AddSpacer();

	-- toggle monitoring
	if (recap and recap.Opt and recap.Opt.Paused.value == true) then
		TitanPanelRightClickMenu_AddCommand(TITAN_RECAP_BUTTON_START_TEXT, TITAN_RECAP_ID, TITAN_RECAP_BUTTON_TOGGLE_MONITOR);
	else
		TitanPanelRightClickMenu_AddCommand(TITAN_RECAP_BUTTON_PAUSE_TEXT, TITAN_RECAP_ID, TITAN_RECAP_BUTTON_TOGGLE_MONITOR);
	end

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_RECAP_ID);	
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_RECAP_ID);	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_RECAP_ID, TITAN_PANEL_MENU_FUNC_HIDE);

end

function TitanPanelRecapButton_GetTooltipText()
	local richTooltipText = "";
	richTooltipText = state.."\n";
	richTooltipText = richTooltipText..viewtype..":\n";
	richTooltipText = richTooltipText..TITAN_RECAP_TOOLTIP_DPS.."\t"..TitanUtils_GetHighlightText(yourdps).."\n";
	richTooltipText = richTooltipText..TITAN_RECAP_TOOLTIP_MAXHIT.."\t"..TitanUtils_GetColoredText(maxhit, TR.Color["orange"] ).."\n";
	richTooltipText = richTooltipText..TITAN_RECAP_TOOLTIP_TOTALDPS_OUT.."\t"..TitanUtils_GetGreenText(totaldps).."\n";
	richTooltipText = richTooltipText..TITAN_RECAP_TOOLTIP_TOTALDPS_IN.."\t"..TitanUtils_GetRedText(totaldpsin).."\n";
	richTooltipText = richTooltipText..TITAN_RECAP_TOOLTIP_HEALING.."\t"..TitanUtils_GetColoredText(healing, TR.Color["cyan"]).."\n";
	richTooltipText = richTooltipText..TITAN_RECAP_TOOLTIP_OVERHEAL.."\t"..TitanUtils_GetColoredText(overheal, TR.Color["cyan"]).."\n";
	richTooltipText = richTooltipText..TitanUtils_GetGreenText(TITAN_RECAP_BUTTON_HINT_TEXT);
	return richTooltipText;
end

function TitanPanelRecap_ToggleYourDPS()
	TitanToggleVar(TITAN_RECAP_ID, "ShowYourDps");
	TitanPanelButton_UpdateButton(TITAN_RECAP_ID);
end

function TitanPanelRecap_ToggleDPSIn()
	TitanToggleVar(TITAN_RECAP_ID, "ShowDpsIn");
	TitanPanelButton_UpdateButton(TITAN_RECAP_ID);
end

function TitanPanelRecap_ToggleDPSOut()
	TitanToggleVar(TITAN_RECAP_ID, "ShowDpsOut");
	TitanPanelButton_UpdateButton(TITAN_RECAP_ID);
end

function TitanPanelRecap_ToggleHealing()
	TitanToggleVar(TITAN_RECAP_ID, "ShowHealing");
	TitanPanelButton_UpdateButton(TITAN_RECAP_ID);
end

function TitanPanelRecap_ToggleOverheal()
	TitanToggleVar(TITAN_RECAP_ID, "ShowOverheal");
	TitanPanelButton_UpdateButton(TITAN_RECAP_ID);
end

function TitanPanelRecap_ToggleMaxHit()
	TitanToggleVar(TITAN_RECAP_ID, "ShowMaxHit");
	TitanPanelButton_UpdateButton(TITAN_RECAP_ID);
end

function TitanPanelRecap_TogglePause()
	Recap_OnClick("Pause");
end
