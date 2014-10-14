--[[
-- Author: Kosta (wowczech@gmail.com)
-- See 'readme.txt' for detailed informations
--]]

TITAN_ROGUE_ID          = "RoguePowder";
TITAN_ROGUE_VERSION     = "2.4.5";
TITAN_ROGUE_ICON        = "Interface\\Icons\\Ability_Vanish";

function TitanPanelRoguePowderButton_OnLoad()
    this.registry = {
        id = TITAN_ROGUE_ID,
        category = "Information",
        version = TITAN_ROGUE_VERSION,
        menuText = TITAN_ROGUE_MENU_TEXT,
        buttonTextFunction = "TitanPanelRoguePowderButton_GetButtonText",
        tooltipTitle = TITAN_ROGUE_TOOLTIP,
        tooltipTextFunction = "TitanPanelRoguePowderButton_GetTooltipText",
        icon = TITAN_ROGUE_ICON,
        iconWidth = 16,
        savedVariables = {
            ShowAvailableOnly = 1,
            ColoredText = 1,
            CountBandages = 0,
            ShowIcon = 1,
            ShowLabelText = 1,
        }
    };

	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	TitanPanelRoguePowder_Msg(TITAN_ROGUE_MENU_TEXT.." "..TITAN_ROGUE_VERSION.." loaded");
end;

function TitanPanelRoguePowderButton_OnEvent()
	if (event == "PLAYER_LEAVING_WORLD") then
        this:UnregisterEvent("BAG_UPDATE");
        this:UnregisterEvent("MERCHANT_SHOW");
    end;
    if (event == "PLAYER_ENTERING_WORLD") then
        this:RegisterEvent("BAG_UPDATE");
        this:RegisterEvent("MERCHANT_SHOW");
    end;

    TitanPanelButton_UpdateButton(TITAN_ROGUE_ID);
end;

function TitanPanelRoguePowderButton_OnClick(button)
    if (button == "LeftButton") then
        if (IsShiftKeyDown()) then
            OpenAllBags();
        else
            TitanPanelRoguePowder_ShowSettings();
        end;
    end;
end;

function TitanPanelRoguePowderButton_GetButtonText(id)
    local button, id = TitanUtils_GetButton(id, true);

	local fc = TitanPanelRoguePowder_GetItemCount(TITAN_ROGUE_POWDER_NAMES[0]); -- flash
	local bc = TitanPanelRoguePowder_GetItemCount(TITAN_ROGUE_POWDER_NAMES[1]); -- blind
	local tc = TitanPanelRoguePowder_GetItemCount(TITAN_ROGUE_POWDER_NAMES[2]); -- tea

	if TitanGetVar(TITAN_ROGUE_ID, "ColoredText") == 1 then
	   fc = TitanPanelRoguePowder_setCountColor(fc);
	end;
	if TitanGetVar(TITAN_ROGUE_ID, "ColoredText") == 1 then
	   bc = TitanPanelRoguePowder_setCountColor(bc);
	end;
	if TitanGetVar(TITAN_ROGUE_ID, "ColoredText") == 1 then
	   tc = TitanPanelRoguePowder_setCountColor(tc);
	end;

	local countText = format("%s/%s/%s", fc, bc, tc);

    return TITAN_ROGUE_BUTTON_LABEL, TitanUtils_GetHighlightText(countText);
end;

function TitanPanelRoguePowderButton_GetTooltipText()
	local out = "\n";
	local cnt = {};
	local bnd = {};

    for i = 0, table.getn(TITAN_ROGUE_POWDER_NAMES) do
	   cnt[i] = TitanPanelRoguePowder_GetItemCount(TITAN_ROGUE_POWDER_NAMES[i]);
	end;

	for i = 0, table.getn(cnt) do
       out = out..TitanPanelRoguePowder_makeTooltipLine(cnt[i], TITAN_ROGUE_POWDER_NAMES[i]);
	end;
	
	if TitanGetVar(TITAN_ROGUE_ID, "CountBandages") == 1 then
        out = out.."\n";
        out = out..TitanUtils_GetHighlightText(TITAN_ROGUE_TOOLTIP_HEALPWD).."\n\n";
        
        for i = 0, table.getn(TITAN_ROGUE_POWDER_HEALING) do
            bnd[i] = TitanPanelRoguePowder_GetItemCount(TITAN_ROGUE_POWDER_HEALING[i]);
        end;
        
        for i = 0, table.getn(bnd) do
            out = out..TitanPanelRoguePowder_makeTooltipLine(bnd[i], TITAN_ROGUE_POWDER_HEALING[i]);
        end;
	end;

    out = out.."\n"..
    TitanUtils_GetGreenText(TITAN_ROGUE_HINT_TEXT).."\n"..
    TitanUtils_GetGreenText(TITAN_ROGUE_HINT_SET_TEXT).."\n"..
    TitanUtils_GetGreenText(TITAN_ROGUE_HINT_BAGS_TEXT).."\n"..
    TitanUtils_GetGreenText(TITAN_ROGUE_HINT_MENU_TEXT);

    return out;
end;

function TitanPanelRoguePowder_makeTooltipLine(id, str)
    local out = "";
    local tmp = "";

    tmp = id;

    if TitanGetVar(TITAN_ROGUE_ID, "ColoredText") == 1 then
        id = TitanPanelRoguePowder_setCountColor(id);
    else
        id = TitanUtils_GetHighlightText(id);
    end;

    if TitanGetVar(TITAN_ROGUE_ID, "ShowAvailableOnly") == 1 then
        if (tmp > 0) then
            out = str..":\t"..id.."\n";
        else
            out = "";
        end;
    else
        out = str..":\t"..id.."\n";
    end;

    return out;
end;

function TitanPanelRoguePowder_setCountColor(str)
    local color;

    if (str < 6) then
        color = TitanUtils_GetColoredText(str, RED_FONT_COLOR);
    elseif (str < 11) then
        color = TitanUtils_GetColoredText(str, NORMAL_FONT_COLOR);
    else
        color = TitanUtils_GetColoredText(str, GREEN_FONT_COLOR);
    end;

    return color;
end;

function TitanPanelRightClickMenu_PrepareRoguePowderMenu()

    TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_ROGUE_ID].menuText);

    TitanPanelRightClickMenu_AddSpacer();

    local info = {};
	info.text = TITAN_ROGUE_MENU_SHOWAVAILABLE;
	info.func = TitanPanelRoguePowder_ShowAvailableOnly;
	info.checked = TitanGetVar(TITAN_ROGUE_ID, "ShowAvailableOnly");
	UIDropDownMenu_AddButton(info);

    local info = {};
	info.text = TITAN_ROGUE_MENU_CNTBANDAGES;
	info.func = TitanPanelRoguePowder_CountBandages;
	info.checked = TitanGetVar(TITAN_ROGUE_ID, "CountBandages");
	UIDropDownMenu_AddButton(info);
	
    local info = {};
	info.text = TITAN_ROGUE_MENU_SHOWCOLORED;
	info.func = TitanPanelRoguePowder_ColoredText;
	info.checked = TitanGetVar(TITAN_ROGUE_ID, "ColoredText");
	UIDropDownMenu_AddButton(info);

    TitanPanelRightClickMenu_AddSpacer();
    
    local info = {};
	info.text = TITAN_ROGUE_MENU_SETTINGS;
	info.func = TitanPanelRoguePowder_ShowSettings;
	UIDropDownMenu_AddButton(info);
	
	TitanPanelRightClickMenu_AddSpacer();
    TitanPanelRightClickMenu_AddToggleIcon(TITAN_ROGUE_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_ROGUE_ID);
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_ROGUE_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end;

function TitanPanelRoguePowder_GetItemCount(name)
	local count = 0;

    for i = NUM_BAG_FRAMES, 0, -1 do
        for j = GetContainerNumSlots(i), 1, -1 do
            local l_name = TitanPanelRoguePowder_GetItemName(i, j);
            if (l_name == name) then
                local texture, itemCount = GetContainerItemInfo(i, j);
                count = count + itemCount;
            end;
        end;
    end;

	return count;
end;

function TitanPanelRoguePowder_GetItemName(bag, slot)
    local linktext = nil;

    if (bag == -1) then
        linktext = GetInventoryItemLink("player", slot);
    else
        linktext = GetContainerItemLink(bag, slot);
    end;

    if linktext then
        local _,_,name = string.find(linktext, "^.*%[(.*)%].*$");
        return name;
    else
        return "";
    end;
end;

function TitanPanelRoguePowder_ShowSettings()
    TitanPanelRoguePowder_SettingsFrame_HeaderText:SetText(TITAN_ROGUE_MENU_TEXT.." "..TITAN_ROGUE_VERSION);

	TitanPanelRoguePowder_SettingsFrame_Option1Text:SetText(TITAN_ROGUE_MENU_SHOWAVAILABLE);
	TitanPanelRoguePowder_SettingsFrame_Option1.HelpText = TITAN_ROGUE_SETTINGS_HINT1;
	if TitanGetVar(TITAN_ROGUE_ID, "ShowAvailableOnly") == 1 then
		TitanPanelRoguePowder_SettingsFrame_Option1:SetChecked(true);
	else
	   TitanPanelRoguePowder_SettingsFrame_Option1:SetChecked(false);
	end;

	TitanPanelRoguePowder_SettingsFrame_Option2Text:SetText(TITAN_ROGUE_MENU_CNTBANDAGES);
	TitanPanelRoguePowder_SettingsFrame_Option2.HelpText = TITAN_ROGUE_SETTINGS_HINT2;
	if TitanGetVar(TITAN_ROGUE_ID, "CountBandages") == 1 then
		TitanPanelRoguePowder_SettingsFrame_Option2:SetChecked(true);
	else
	   TitanPanelRoguePowder_SettingsFrame_Option2:SetChecked(false);
	end;

	TitanPanelRoguePowder_SettingsFrame_Option3Text:SetText(TITAN_ROGUE_MENU_SHOWCOLORED);
	TitanPanelRoguePowder_SettingsFrame_Option3.HelpText = TITAN_ROGUE_SETTINGS_HINT3;
	if TitanGetVar(TITAN_ROGUE_ID, "ColoredText") == 1 then
		TitanPanelRoguePowder_SettingsFrame_Option3:SetChecked(true);
	else
	   TitanPanelRoguePowder_SettingsFrame_Option3:SetChecked(false);
	end;
	
	--TitanPanelRoguePowder_SettingsFrame_Slider1:Show();
	TitanPanelRoguePowder_SettingsFrame:Show();
end;

function TitanPanelRoguePowder_SettingsOptionButton_OnClick(arg1)
	if ( arg1 == 1 ) then
		TitanPanelRoguePowder_ShowAvailableOnly();
	elseif ( arg1 == 2 ) then
		TitanPanelRoguePowder_CountBandages();
	elseif ( arg1 == 3 ) then
		TitanPanelRoguePowder_ColoredText();
	end;
	
	TitanPanelButton_UpdateButton(TITAN_ROGUE_ID);
end

function TitanPanelRoguePowder_SettingsOptionButton_OnEnter(button)
	GameTooltip:SetOwner(button, "ANCHOR_NONE");
	GameTooltip:SetPoint("TOPLEFT", button:GetName(), "BOTTOMLEFT", -10, -4);
	GameTooltip:SetText(button.HelpText);
	GameTooltip:Show();
end;

function TitanPanelRoguePowder_SettingsOptionButton_OnLeave()
	GameTooltip:Hide();
end;

function TitanPanelRoguePowder_SettingsClose()
	TitanPanelRoguePowder_SettingsFrame:Hide();
	TitanPanelButton_UpdateButton(TITAN_ROGUE_ID);
end;

function TitanPanelRoguePowder_ShowAvailableOnly()
	TitanToggleVar(TITAN_ROGUE_ID, "ShowAvailableOnly");
end;

function TitanPanelRoguePowder_CountBandages()
    TitanToggleVar(TITAN_ROGUE_ID, "CountBandages");
end;

function TitanPanelRoguePowder_ColoredText()
	TitanToggleVar(TITAN_ROGUE_ID, "ColoredText");
	TitanPanelButton_UpdateButton(TITAN_ROGUE_ID);
end;

function TitanPanelRoguePowder_Msg(msg)
	if (msg == nil) then
		msg = "*****TR*****";
	end;
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end;
end;