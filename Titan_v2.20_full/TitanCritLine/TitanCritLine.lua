--[[
Titan [CritLine]

CritLine Concept by Sordit
Titan Conversion until version 0.3.7 by Uggh
Continued Development from 0.3.7 by FALLI
Small update at 0.4.0f/g by Snowblind

VERSION HISTORY:
Titan [CritLine] v0.4.0e
-fix some database issues

Titan [CritLine] v0.4.0a
-fix an issue that sometimes the database creation was not complete

Titan [CritLine] v0.4.0
-add an option to use the Titan Button with SHIFT key
-add a special mob filter (thanks to gogusrl) that filter out these mobs in existing records and future
 can turned on or off in the options dialog, if you do this, the old values were saved into the database
-add a new saved value (missed attacks), for future use

Titan [CritLine] v0.3.9b
-fix the bug that the critical splash message not showed correctly
-fix the issue the heals with the addon selfcast (or similar) not be counted 

Titan [CritLine] v0.3.9a
-add the help text for the options
-add some french translation, thanks to Feu
-fix a bug with the button, that highest filtered attacks shown on the button
-add a new message for criticals for the splash screen

Titan [CritLine] v0.3.9
-add an option to show all hits in the tooltip (only absolute hits, no misses)
-add a post records to channel function
-add to options panel when you click on the CL button should it be open the settings or post the data in the channel
-change the level adjustment setting to a slider, the default trivial setting in pvp by blizz is 10 level difference
-add a function for help text for each option, but I need translators for french (important)
-resize dynamically the filter options window

Titan [CritLine] v0.3.8
-add a filter option for the tooltip
-fix a few minor bugs

Titan [CritLine] v0.3.7d
-fix a bug with french translation
-made it compatible to game version 1.8.0

Titan [CritLine] v0.3.7c
-changed the combat log messages and add the new ones, for game version 1.7.0, add the new msgs to the code
-add crit percentage to tooltip, add checkbox for this to options frame
-override the original germann translation mistake for normal magic hits
-override the french translation with brackets '()' thanks to Franael

Titan [CritLine] v0.3.7
-Fixed an bug with DE and FR clients.

Titan [CritLine] v0.3.6
-Fixed an bug with DE client.

Titan [CritLine] v0.3.5
-Fixed an bug with DE clients crits not working.
-Fixed a bug with french text on the settings menu.

Titan [CritLine] v0.3.4
-Fixed an error with the French clients recording one hit as a Crit and Normal hit.
-Settings menu translated to French and German.
-Changed default for Level Adjustment to be off.

Titan [CritLine] v0.3.3
-Attempts to repair saved data information.
-Fixed an issue with French clients not recording hits.

Titan [CritLine] v0.3.2
-Fixed an issue with German clients not recording hits.
-Added Right-Click menu to toggle Icon/Text.
-Added better error handling and error recovery.

Titan [CritLine] v0.3.1
-Added command to rebuild data structure.
-Change archive format to .zip.

Titan [CritLine] v0.3
-Added level range filter.
-Added attack type to splash screen message (e.g. 'New Ambush Record!')
-Cleaned up summary tooltip.
-Added healing spells.

Titan [CritLine] v0.2
-Added settings menu
-Added Detailed summary for high damage attacks (ToolTip)
-Toggle for ScreenShot on new damage records.
-Toggle for counting PvP damage only.
-Toggle for sound
-Toggle Splash Screen

Titan [CritLine] v0.1
-Initial Release
]]

DEBUG = false; -- for internal testing only, left it to false !

--[[ global addon variables ]]
TITAN_CRITLINE_ID =  "CritLine";
TITAN_CRITLINE_VERSION = " v0.4.0g";
TITAN_CRITLINE_BUTTON_LABEL = "CL: ";
TITAN_CRITLINE_BUTTON_ICON = "Interface\\AddOns\\TitanCritLine\\TitanCritLine";
TITAN_CRITLINE_BUTTON_TEXT = "%s/%s";

HEADER_TEXT_COLOR  = "|cffffffff";
SUBHEADER_TEXT_COLOR  = "|cffCEA208";
BODY_TEXT_COLOR  = "|cffffffff";
HINT_TEXT_COLOR  = "|cff00ff00";

TCL_REALM = "";
TitanCritLine_PlayerRealmName = ""; -- only stored for compability reasons

TCL_MOBFILTER = {};

DAMAGE_TYPE_NONHEAL = "0";
DAMAGE_TYPE_HEAL =  "1";

--[[ functions for the setup dialog ]]
function tcl_DisplaySettings()
	TitanCritLine_SettingsFrame_HeaderText:SetText(TITAN_CRITLINE_ID.." "..TITAN_CRITLINE_MENU_SETTINGS);
	TitanCritLine_SettingsFrame_Option1Text:SetText(COLOR(SUBHEADER_TEXT_COLOR, TITAN_CRITLINE_OPTION_SPLASH_TEXT));
	TitanCritLine_SettingsFrame_Option1.HelpText = TITAN_CRITLINE_OPTION_SPLASH_HELPTEXT;
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SPLASH"] == "1" ) then
		TitanCritLine_SettingsFrame_Option1:SetChecked(true);
	end
	TitanCritLine_SettingsFrame_Option2Text:SetText(COLOR(SUBHEADER_TEXT_COLOR, TITAN_CRITLINE_OPTION_PLAYSOUNDS_TEXT));
	TitanCritLine_SettingsFrame_Option2.HelpText = TITAN_CRITLINE_OPTION_PLAYSOUNDS_HELPTEXT;
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["PLAYSOUND"] == "1" ) then
		TitanCritLine_SettingsFrame_Option2:SetChecked(true);
	end
	TitanCritLine_SettingsFrame_Option3Text:SetText(COLOR(SUBHEADER_TEXT_COLOR, TITAN_CRITLINE_OPTION_PVPONLY_TEXT));
	TitanCritLine_SettingsFrame_Option3.HelpText = TITAN_CRITLINE_OPTION_PVPONLY_HELPTEXT;
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["PVPONLY"] == "1" ) then
		TitanCritLine_SettingsFrame_Option3:SetChecked(true);
	end
	TitanCritLine_SettingsFrame_Option4Text:SetText(COLOR(SUBHEADER_TEXT_COLOR, TITAN_CRITLINE_OPTION_SCREENCAP_TEXT));
	TitanCritLine_SettingsFrame_Option4.HelpText = TITAN_CRITLINE_OPTION_SCREENCAP_HELPTEXT;
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SNAPSHOT"] == "1" ) then
		TitanCritLine_SettingsFrame_Option4:SetChecked(true);
	end
	TitanCritLine_SettingsFrame_Option7Text:SetText(COLOR(SUBHEADER_TEXT_COLOR, TITAN_CRITLINE_OPTION_SHOW_CRIT_TEXT));
	TitanCritLine_SettingsFrame_Option7.HelpText = TITAN_CRITLINE_OPTION_SHOW_CRIT_HELPTEXT;
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHOWCRIT"] == "1" ) then
		TitanCritLine_SettingsFrame_Option7:SetChecked(true);
	end
	TitanCritLine_SettingsFrame_Option8Text:SetText(COLOR(SUBHEADER_TEXT_COLOR, TITAN_CRITLINE_OPTION_SHOWHITS_TEXT));
	TitanCritLine_SettingsFrame_Option8.HelpText = TITAN_CRITLINE_OPTION_SHOWHITS_HELPTEXT;
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHOWHITS"] == "1" ) then
		TitanCritLine_SettingsFrame_Option8:SetChecked(true);
	end
	TitanCritLine_SettingsFrame_Option5Text:SetText(COLOR(SUBHEADER_TEXT_COLOR, TITAN_CRITLINE_OPTION_ONCLICK_TEXT));
	TitanCritLine_SettingsFrame_Option5.HelpText = TITAN_CRITLINE_OPTION_ONCLICK_HELPTEXT;
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["ONCLICK"] == "1" ) then
		TitanCritLine_SettingsFrame_Option5:SetChecked(true);
	end
	TitanCritLine_SettingsFrame_Option9Text:SetText(COLOR(SUBHEADER_TEXT_COLOR, TITAN_CRITLINE_OPTION_SHIFT_ONCLICK_TEXT));
	TitanCritLine_SettingsFrame_Option9.HelpText = TITAN_CRITLINE_OPTION_SHIFT_ONCLICK_HELPTEXT;
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHIFTONCLICK"] == "1" ) then
		TitanCritLine_SettingsFrame_Option9:SetChecked(true);
	end
	TitanCritLine_SettingsFrame_Option6Text:SetText(COLOR(SUBHEADER_TEXT_COLOR, TITAN_CRITLINE_OPTION_FILTER_HEALING_TEXT));
	TitanCritLine_SettingsFrame_Option6.HelpText = TITAN_CRITLINE_OPTION_FILTER_HEALING_HELPTEXT;
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["FILTER_HEALING"] == "1" ) then
		TitanCritLine_SettingsFrame_Option6:SetChecked(true);
	end
	TitanCritLine_SettingsFrame_Slider1:SetValue(tonumber(TCL_SETTINGS[TCL_REALM]["SETTINGS"]["LVLADJ"]));
	TitanCritLine_SettingsFrame_Slider1Text1:SetText(TITAN_CRITLINE_OPTION_LVLADJ_TEXT);
	TitanCritLine_SettingsFrame_Slider1.HelpText = TITAN_CRITLINE_OPTION_LVLADJ_HELPTEXT;
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["LVLADJ"] == "0" ) then
		TitanCritLine_SettingsFrame_Slider1Text2:SetText("Off");
	else
		TitanCritLine_SettingsFrame_Slider1Text2:SetText(TCL_SETTINGS[TCL_REALM]["SETTINGS"]["LVLADJ"]);
	end
	TitanCritLine_SettingsFrame_Option10Text:SetText(COLOR(SUBHEADER_TEXT_COLOR, TITAN_CRITLINE_OPTION_MOBFILTER_TEXT));
	TitanCritLine_SettingsFrame_Option10.HelpText = TITAN_CRITLINE_OPTION_MOBFILTER_HELPTEXT;
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["FILTER_MOBS"] == "1" ) then
		TitanCritLine_SettingsFrame_Option10:SetChecked(true);
	end
	TitanCritLine_SettingsFrame_Slider1:Show();
	TitanCritLine_SettingsFrame:Show();
end

function tcl_SettingsOptionButton_OnClick(arg1)
	if ( arg1 == 1 ) then
		tcl_ToggleSplash();
	elseif ( arg1 == 2 ) then
		tcl_ToggleSound();
	elseif ( arg1 == 3 ) then
		tcl_TogglePvP();
	elseif ( arg1 == 4 ) then
		tcl_ToggleScreenShots();
	elseif ( arg1 == 5 ) then
		tcl_ToggleOnClick();
	elseif ( arg1 == 6 ) then
		tcl_ToggleHealing();
	elseif ( arg1 == 7 ) then
		tcl_ToggleShowCrit();
	elseif ( arg1 == 8 ) then
		tcl_ToggleShowHits();
	elseif ( arg1 == 9 ) then
		tcl_ToggleShiftOnClick();
	elseif ( arg1 == 10 ) then
		tcl_ToggleMobFilter();
	end
	TitanPanelButton_UpdateButton(TITAN_CRITLINE_ID);
end

function tcl_SettingsOptionButton_OnEnter(button)
	GameTooltip:SetOwner(button, "ANCHOR_NONE");
	GameTooltip:SetPoint("TOPLEFT", button:GetName(), "BOTTOMLEFT", -10, -4);
	GameTooltip:SetText(button.HelpText);
	GameTooltip:Show();
end

function tcl_SettingsOptionButton_OnLeave()
	GameTooltip:Hide();
end

function tcl_SettingsSlider_OnValueChanged()
	local lvladj = TitanCritLine_SettingsFrame_Slider1:GetValue();
	if ( lvladj == 0 ) then
		TitanCritLine_SettingsFrame_Slider1Text2:SetText("Off");
	else
		TitanCritLine_SettingsFrame_Slider1Text2:SetText(tostring(lvladj));
	end
	TCL_SETTINGS[TCL_REALM]["SETTINGS"]["LVLADJ"] = tostring(lvladj);
	tcl_DEBUG(TITAN_CRITLINE_ID.." level adjustment set to "..tostring(lvladj));
end

function tcl_ToggleShowHits()
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHOWHITS"] == "0" ) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHOWHITS"] = "1";
		tcl_DEBUG(TITAN_CRITLINE_ID.." show all hits is on");
	else
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHOWHITS"] = "0";
		tcl_DEBUG(TITAN_CRITLINE_ID.." show all hits is off");
	end
end

function tcl_ToggleOnClick()
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["ONCLICK"] == "0" ) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["ONCLICK"] = "1";
		TitanCritLine_SettingsFrame_Option9:Enable();
		tcl_DEBUG(TITAN_CRITLINE_ID.." post to chat on click is on");
	else
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["ONCLICK"] = "0";
		TitanCritLine_SettingsFrame_Option9:Disable();
		tcl_DEBUG(TITAN_CRITLINE_ID.." post to chat on click is off");
	end
end

function tcl_ToggleShiftOnClick()
	if ( TitanCritLine_SettingsFrame_Option9:IsEnabled() ) then
		if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHIFTONCLICK"] == "0" ) then
			TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHIFTONCLICK"] = "1";
			tcl_DEBUG(TITAN_CRITLINE_ID.." post to chat on SHIFT click is on");
		else
			TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHIFTONCLICK"] = "0";
			tcl_DEBUG(TITAN_CRITLINE_ID.." post to chat on SHIFT click is off");
		end
	end
end

function tcl_ToggleScreenShots()
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SNAPSHOT"] == "0" ) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SNAPSHOT"] = "1";
		tcl_DEBUG(TITAN_CRITLINE_ID.." screen shots on");
	else
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SNAPSHOT"] = "0";
		tcl_DEBUG(TITAN_CRITLINE_ID.." screen shots off");
	end
end

function tcl_ToggleSound()
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["PLAYSOUND"] == "0" ) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["PLAYSOUND"] = "1";
		tcl_DEBUG(TITAN_CRITLINE_ID.." sound on");
	else
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["PLAYSOUND"] = "0";
		tcl_DEBUG(TITAN_CRITLINE_ID.." sound off");
	end
end

function tcl_TogglePvP()
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["PVPONLY"] == "0" ) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["PVPONLY"] = "1";
		tcl_DEBUG(TITAN_CRITLINE_ID.." pvponly on");
	else
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["PVPONLY"] = "0";
		tcl_DEBUG(TITAN_CRITLINE_ID.." pvponly off");
	end
end

function tcl_ToggleSplash()
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SPLASH"] == "0" ) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SPLASH"] = "1";
		tcl_DEBUG(TITAN_CRITLINE_ID.." splash on");
	else
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SPLASH"] = "0";
		info.checked = 0;
		tcl_DEBUG(TITAN_CRITLINE_ID.." splash off");
	end
end

function tcl_ToggleHealing()
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["FILTER_HEALING"] == "0" ) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["FILTER_HEALING"] = "1";
		tcl_DEBUG(TITAN_CRITLINE_ID.." filter healing on");
	else
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["FILTER_HEALING"] = "0";
		tcl_DEBUG(TITAN_CRITLINE_ID.." filter healing off");
	end
end

function tcl_ToggleShowCrit()
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHOWCRIT"] == "0" ) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHOWCRIT"] = "1";
		tcl_DEBUG(TITAN_CRITLINE_ID.." show crit percentage on");
	else
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHOWCRIT"] = "0";
		tcl_DEBUG(TITAN_CRITLINE_ID.." show crit percentage off");
	end
end

function tcl_ToggleMobFilter()
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["FILTER_MOBS"] == "0" ) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["FILTER_MOBS"] = "1";
		tcl_DEBUG(TITAN_CRITLINE_ID.." filter mobs on");
		tcl_DeleteAllRecordsWithMobsInFilter();
	else
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["FILTER_MOBS"] = "0";
		tcl_DEBUG(TITAN_CRITLINE_ID.." filter mobs off");
		tcl_RestoreAllRecordsWithMobsInFilter();
	end
end

function tcl_Reset()
	TCL_SETTINGS[TCL_REALM]["DATA"] = {};
	TitanPanelCritLineButtonText:SetText(TitanPanelCritLine_GetButtonText(0));
end

function tcl_ResetAll()
	TCL_SETTINGS = {};
	tcl_Initialize();
	TitanPanelCritLineButtonText:SetText(TitanPanelCritLine_GetButtonText(0));
end

function tcl_SettingsClose()
	if ( TitanCritLine_FilterFrame:IsVisible() ) then
		tcl_FilterClose();
	end
	TitanCritLine_SettingsFrame:Hide();
	TitanPanelButton_UpdateButton(TITAN_CRITLINE_ID);
end

function tcl_Filter()
	if ( TitanCritLine_FilterFrame:IsVisible() ) then
		tcl_FilterClose();
	else
		local i = 1;
		for k,v in pairs(TCL_SETTINGS[TCL_REALM]["DATA"]) do
			tcl_DEBUG("create button no."..tostring(i).." for "..k);
			local button = getglobal("TitanCritLine_FilterFrame_Option"..tostring(i));
			local text = getglobal("TitanCritLine_FilterFrame_Option"..tostring(i).."Text");
			text:Show();
			text:SetText(k);
			button:Show();
			if (TCL_SETTINGS[TCL_REALM]["DATA"][k]["Filter"] == "1") then
				button:SetChecked(true);
			end
			i = i + 1;
			if ( i > 20 ) then
				do break end
			end
		end
		local height = i * 24 + 20;
		TitanCritLine_FilterFrame:SetHeight(height);
		TitanCritLine_FilterFrame:SetPoint("LEFT", "TitanCritLine_SettingsFrame", "RIGHT", 5, 0);
		TitanCritLine_FilterFrame:Show();
	end
end

function tcl_FilterOptionButton_OnClick(id)
	local button = getglobal("TitanCritLine_FilterFrame_Option"..tostring(id));
	local attacktype = getglobal("TitanCritLine_FilterFrame_Option"..tostring(id).."Text"):GetText();
	if ( button:GetChecked() ) then
		tcl_DEBUG(attacktype.." filter is on");
		TCL_SETTINGS[TCL_REALM]["DATA"][attacktype]["Filter"] = "1";
	else
		tcl_DEBUG(attacktype.." filter is off");
		TCL_SETTINGS[TCL_REALM]["DATA"][attacktype]["Filter"] = "0";
	end
	TitanPanelButton_UpdateButton(TITAN_CRITLINE_ID);
end

function tcl_FilterClose()
	TitanCritLine_FilterFrame:Hide();
	for i = 1, 20, 1 do
		local button = getglobal("TitanCritLine_FilterFrame_Option"..tostring(i));
		local text = getglobal("TitanCritLine_FilterFrame_Option"..tostring(i).."Text");
		button:SetChecked(false);
		button:Hide();
		text:SetText(nil);
		text:Hide();
	end
	TitanPanelButton_UpdateButton(TITAN_CRITLINE_ID);
end

function tcl_ManualUpdate()
	tcl_Update(TCL_SETTINGS["VERSION"]);
end

--[[ titan panel functions ]]
function TitanPanelRightClickMenu_PrepareCritLineMenu()
	local id = TITAN_CRITLINE_ID;
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[id].menuText..TITAN_CRITLINE_VERSION);
	local info = {};
	info.text = TITAN_CRITLINE_MENU_SETTINGS;
	info.func = tcl_DisplaySettings;
	UIDropDownMenu_AddButton(info);
	TitanPanelRightClickMenu_AddSpacer();
	local info2 = {};
	info2.text = TITAN_CRITLINE_MENU_POSTGUILD;
	info2.func = tcl_PostToGuild;
	local info3 = {};
	info3.text = TITAN_CRITLINE_MENU_POSTPARTY;
	info3.func = tcl_PostToParty;
	local info4 = {};
	info4.text = TITAN_CRITLINE_MENU_POSTRAID;
	info4.func = tcl_PostToRaid;
	UIDropDownMenu_AddButton(info2);
	UIDropDownMenu_AddButton(info3);
	UIDropDownMenu_AddButton(info4);
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddToggleIcon(id);
	TitanPanelRightClickMenu_AddToggleLabelText(id);
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelCritLine_GetButtonText(id)
	local buttonRichText = format(TITAN_CRITLINE_BUTTON_TEXT, COLOR(BODY_TEXT_COLOR, tcl_GetHighestDamage()), COLOR(BODY_TEXT_COLOR, tcl_GetHighestCrit()));
	if (TCL_SETTINGS[TCL_REALM]["SETTINGS"]["FILTER_HEALING"] == "0") then
		buttonRichText = buttonRichText.." - "..format(TITAN_CRITLINE_BUTTON_TEXT, COLOR(BODY_TEXT_COLOR, tcl_GetHighestHeal()), COLOR(BODY_TEXT_COLOR, tcl_GetHighestHealCrit()));
	end
	tcl_DEBUG("TitanPanelCritLine_GetButtonText: "..TITAN_CRITLINE_BUTTON_LABEL..buttonRichText);
	return TITAN_CRITLINE_BUTTON_LABEL, buttonRichText;
end

--[[ addon functions ]]
function tcl_OnLoad()
	this.registry = { 
		id = TITAN_CRITLINE_ID,
		menuText = TITAN_CRITLINE_ID, 
		buttonTextFunction = "TitanPanelCritLine_GetButtonText", 
		tooltipTitle = TITAN_CRITLINE_ID.." "..TITAN_CRITLINE_TOOLTIP_HEADER.." "..TITAN_CRITLINE_VERSION,
		tooltipTextFunction = "tcl_GetSummaryRichText", 
		icon = TITAN_CRITLINE_BUTTON_ICON,
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
		}
	};
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES");
	tcl_Msg(TITAN_CRITLINE_ID.." "..TITAN_CRITLINE_VERSION.." loaded.");
end

function tcl_OnUpdate(elapsed)
	
end

function tcl_OnEvent()
	tcl_DEBUG("Received Event: "..event);
	if (event == "PLAYER_ENTERING_WORLD") then
		if (TCL_SETTINGS == nil) then
			TCL_SETTINGS = {};
		end
		if (TCL_SETTINGS["VERSION"] == nil) then
			tcl_Update("UNKNOWN");
		elseif (TCL_SETTINGS["VERSION"] ~= TITAN_CRITLINE_VERSION) then
			tcl_Update(TCL_SETTINGS["VERSION"]);
		else
			tcl_Initialize();
		end
		tcl_CreateMobFilter();
		TitanPanelButton_UpdateButton(TITAN_CRITLINE_ID);
		TitanPanelButton_UpdateTooltip();
	elseif (event == "CHAT_MSG_SPELL_SELF_BUFF") then
		if (TCL_SETTINGS[TCL_REALM]["SETTINGS"]["FILTER_HEALING"] == "0") then
			for attacktype, damage in string.gfind(arg1, HEAL_SPELL_SELF_CRIT_MSG)  do
--				tcl_DEBUG(arg1);
--                                tcl_DEBUG("Heal crit: "..attacktype.." you for "..damage);
				tcl_RecordHit(attacktype, "CRIT", tonumber(damage),UnitName("player"), DAMAGE_TYPE_HEAL);
				return;
			end
			for attacktype, creaturename, damage in string.gfind(arg1, HEAL_SPELL_CRIT_MSG) do
--                       		tcl_DEBUG(arg1);
--                                tcl_DEBUG(attacktype.."Heal crit: "..creaturename.." for "..damage);
				tcl_RecordHit(attacktype, "CRIT", tonumber(damage), creaturename, DAMAGE_TYPE_HEAL);
				return;
			end
			for attacktype, damage in string.gfind(arg1, HEAL_SPELL_SELF_HIT_MSG)  do
--				tcl_DEBUG(arg1);
--                                tcl_DEBUG("Heal: "..attacktype.." you  for "..damage);
				tcl_RecordHit(attacktype, "NORMAL", tonumber(damage),UnitName("player"), DAMAGE_TYPE_HEAL);
				return;
			end
			for attacktype, creaturename, damage in string.gfind(arg1, HEAL_SPELL_HIT_MSG) do
--				tcl_DEBUG(arg1);
--                                tcl_DEBUG(attacktype.."Heal: "..creaturename.." for "..damage);
				tcl_RecordHit(attacktype, "NORMAL", tonumber(damage), creaturename, DAMAGE_TYPE_HEAL);
				return;
			end
		end
--	tcl_DEBUG(arg1);
--	tcl_DEBUG(CHAT_MSG_SPELL_SELF_BUFF);
--	tcl_DEBUG(HEAL_SPELL_SELF_CRIT_MSG);
--	tcl_DEBUG(HEAL_SPELL_CRIT_MSG);
--	tcl_DEBUG(HEAL_SPELL_SELF_HIT_MSG);
--	tcl_DEBUG(HEAL_SPELL_HIT_MSG);

	elseif (event == "CHAT_MSG_COMBAT_SELF_HITS") then
		for creaturename, damage in string.gfind(arg1, COMBAT_CRIT_MSG)do
			tcl_DEBUG("Crit Hit: "..creaturename.." for "..damage);
			tcl_RecordHit(NORMAL_HIT_TEXT, "CRIT", tonumber(damage), creaturename, DAMAGE_TYPE_NONHEAL);
			return;
		end
		for creaturename, damage, damagetype in string.gfind(arg1, COMBAT_CRIT_SCHOOL_MSG)do
			tcl_DEBUG("Crit School Hit: "..creaturename.." for "..damagetype.." "..damage);
			tcl_RecordHit(NORMAL_HIT_TEXT, "CRIT", tonumber(damage), creaturename, DAMAGE_TYPE_NONHEAL);
			return;
		end
		for creaturename, damage in string.gfind(arg1, COMBAT_HIT_MSG) do
			tcl_DEBUG("Regular Hit: "..creaturename.." for "..damage);
			tcl_RecordHit(NORMAL_HIT_TEXT, "NORMAL", tonumber(damage), creaturename, DAMAGE_TYPE_NONHEAL);
			return;
		end
		for creaturename, damage, damagetype in string.gfind(arg1, COMBAT_HIT_SCHOOL_MSG) do
			tcl_DEBUG("Regular School Hit: "..creaturename.." for "..damagetype.." "..damage);
			tcl_RecordHit(NORMAL_HIT_TEXT, "NORMAL", tonumber(damage), creaturename, DAMAGE_TYPE_NONHEAL);
			return;
		end
	elseif (event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
		for attacktype, creaturename, damage in string.gfind(arg1, SPELL_CRIT_MSG) do
			tcl_DEBUG(attacktype.." Crit: "..creaturename.." for "..damage);
			tcl_RecordHit(attacktype, "CRIT", tonumber(damage), creaturename, DAMAGE_TYPE_NONHEAL);
			return;
		end
		for attacktype, creaturename, damage, damagetype in string.gfind(arg1, SPELL_CRIT_SCHOOL_MSG) do
			tcl_DEBUG(attacktype.." School Crit: "..creaturename.." for "..damagetype.." "..damage);
			tcl_RecordHit(attacktype, "CRIT", tonumber(damage), creaturename, DAMAGE_TYPE_NONHEAL);
			return;
		end
		for attacktype, creaturename, damage in string.gfind(arg1, SPELL_HIT_MSG) do
			tcl_DEBUG(attacktype.." Hit: "..creaturename.." for "..damage);
			tcl_RecordHit(attacktype, "NORMAL", tonumber(damage), creaturename, DAMAGE_TYPE_NONHEAL);
			return;
		end
		for attacktype, creaturename, damage, damagetype in string.gfind(arg1, SPELL_HIT_SCHOOL_MSG) do
			tcl_DEBUG(attacktype.." School Hit: "..creaturename.." for "..damagetype.." "..damage);
			tcl_RecordHit(attacktype, "NORMAL", tonumber(damage), creaturename, DAMAGE_TYPE_NONHEAL);
			return;
		end
		tcl_RecordMiss(arg1);
	elseif ( event == "CHAT_MSG_COMBAT_SELF_MISSES") then
		tcl_RecordMiss(arg1);
	end
end

function tcl_OnClick(button)
	if (button == "LeftButton") then
		if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHIFTONCLICK"] == "1" ) then
			if ( IsShiftKeyDown() ) then
				if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["ONCLICK"] == "0" ) then
					tcl_DisplaySettings();
				else
					tcl_PostMessage();
				end
			else
				return;
			end
		else
			if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["ONCLICK"] == "0" ) then
				tcl_DisplaySettings();
			else
				tcl_PostMessage();
			end
		end
	end
end

function tcl_Update(version)
	tcl_Msg("Updating "..TITAN_CRITLINE_ID.." from version "..version.." to version "..TITAN_CRITLINE_VERSION.." ...");
	-- set global variables
	TCL_REALM = GetCVar("realmName");
	tcl_Initialize();
	TCL_SETTINGS["VERSION"] = TITAN_CRITLINE_VERSION;
	-- check for old titan critline data
	if (TitanCritLineSettings == nil) then
		tcl_Msg("No old Titan Critline database found, creating new database for "..UnitName("player")..".");
	else
		TitanCritLine_PlayerRealmName = GetCVar("realmName").."."..UnitName("player");
		if (TitanCritLineSettings[TitanCritLine_PlayerRealmName] == nil) then
			tcl_Msg("Old Titan CritLine database found, but not for "..UnitName("player")..", creating new one.");
		else
			if ( table.getn(TCL_SETTINGS[TCL_REALM]["DATA"]) == nil or table.getn(TCL_SETTINGS[TCL_REALM]["DATA"]) == 0 ) then
				tcl_Msg("Updating old Titan CritLine data ...");
				for k,v in pairs(TitanCritLineSettings[TitanCritLine_PlayerRealmName]["SETTINGS"]) do
					TCL_SETTINGS[TCL_REALM]["SETTINGS"][k] = v;
				end
				for k,v in pairs(TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"]) do
					attacktype = k;
					TCL_SETTINGS[TCL_REALM]["DATA"][attacktype] = {};
					TCL_SETTINGS[TCL_REALM]["DATA"][attacktype]["Filter"] = "0";
					for k,v in pairs(TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype]) do
						hittype = k;
						TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][hittype] = {};
						for k,v in pairs(TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][hittype]) do
							TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][hittype][k] = v;
						end
						if (TitanCritLineSettings[TitanCritLine_PlayerRealmName]["DATA"][attacktype][hittype]["Value"] == nil) then
							TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][hittype]["Value"] = 0;
						end
					end
				end
				TitanCritLineSettings[TitanCritLine_PlayerRealmName] = nil;
			else
				tcl_Msg("New data was found, no update needed ...");
			end
		end
	end
	--add changes to database
	tcl_Msg("Updating main database ...");
	for k, v in pairs(TCL_SETTINGS[TCL_REALM]["DATA"]) do
		if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["Misses"] == nil ) then
			TCL_SETTINGS[TCL_REALM]["DATA"][k]["Misses"] = 0;
		end
	end
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["ONCLICK"] == nil ) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["ONCLICK"] = "0";
	end
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHOWHITS"] == nil ) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHOWHITS"] = "1";
	end
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHIFTONCLICK"] == nil ) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHIFTONCLICK"] = "0";
	end
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["FILTER_MOBS"] == nil ) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["FILTER_MOBS"] = "0";
	end
	-- update complete
	tcl_Msg("Update complete, read the UPDATE.TXT file in the addon directory!");
end

function tcl_Initialize()
	tcl_DEBUG("Initializing...");
	TCL_REALM = GetCVar("realmName");
	if (TCL_SETTINGS == nil) then
		TCL_SETTINGS = {};
	end
	if (TCL_SETTINGS["VERSION"] == nil) then
		TCL_SETTINGS["VERSION"] = TITAN_CRITLINE_VERSION;
	end
	if (TCL_SETTINGS[TCL_REALM] == nil) then
		TCL_SETTINGS[TCL_REALM] = {};
	end
	if (TCL_SETTINGS[TCL_REALM]["SETTINGS"] == nil) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"] = {};
	end
	if (TCL_SETTINGS[TCL_REALM]["SETTINGS"]["FILTER_HEALING"] == nil) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["FILTER_HEALING"] = "1";
	end
	if (TCL_SETTINGS[TCL_REALM]["SETTINGS"]["LVLADJ"] == nil) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["LVLADJ"] = "0";
	end
	if (TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SPLASH"] == nil) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SPLASH"] = "1";
	end
	if (TCL_SETTINGS[TCL_REALM]["SETTINGS"]["PVPONLY"] == nil) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["PVPONLY"] = "0";
	end
	if (TCL_SETTINGS[TCL_REALM]["SETTINGS"]["PLAYSOUND"] == nil) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["PLAYSOUND"] = "1";
	end
	if (TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SNAPSHOT"] == nil) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SNAPSHOT"] = "0";
	end
	if (TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHOWCRIT"] == nil) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHOWCRIT"] = "1";
	end
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHOWHITS"] == nil ) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHOWHITS"] = "1";
	end
	if (TCL_SETTINGS[TCL_REALM]["SETTINGS"]["ONCLICK"] == nil) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["ONCLICK"] = "1"
	end
	if (TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHIFTONCLICK"] == nil) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHIFTONCLICK"] = "1";
	end
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["FILTER_MOBS"] == nil ) then
		TCL_SETTINGS[TCL_REALM]["SETTINGS"]["FILTER_MOBS"] = "1";
	end
	if (TCL_SETTINGS[TCL_REALM]["DATA"] == nil) then
		TCL_SETTINGS[TCL_REALM]["DATA"] = {};
	end
	tcl_DEBUG("Initialization Complete.");
end

function tcl_CreateMobFilter()
	tcl_DEBUG("Creating Mob Filter...");
	table.insert(TCL_MOBFILTER, TITAN_CRITLINE_MOBFILTER_01);
	table.insert(TCL_MOBFILTER, TITAN_CRITLINE_MOBFILTER_02);
	table.insert(TCL_MOBFILTER, TITAN_CRITLINE_MOBFILTER_03);
	table.insert(TCL_MOBFILTER, TITAN_CRITLINE_MOBFILTER_04);
	table.insert(TCL_MOBFILTER, TITAN_CRITLINE_MOBFILTER_05);
	tcl_DEBUG("Creation complete.");
end

function tcl_IsMobInFilter(mobname)
	local returnvalue = false;
	for k, v in pairs(TCL_MOBFILTER) do
		if ( v == mobname ) then
			tcl_DEBUG("Name of Mob ("..mobname..") is in Filter ...");
			returnvalue = true;
			do break end;
		end
	end
	tcl_DEBUG("Name of Mob ("..mobname..") is NOT in Filter ...");
	return returnvalue;
end

function tcl_DeleteAllRecordsWithMobsInFilter()
	tcl_DEBUG("Search for filtered mobs and delte them ...");
	for k, v in pairs(TCL_SETTINGS[TCL_REALM]["DATA"]) do
		attacktype = k;
		for k, v in pairs(TCL_SETTINGS[TCL_REALM]["DATA"][attacktype]) do
			if ( k == "CRIT" or k == "NORMAL" ) then
				local hittype = k;
				if ( tcl_IsMobInFilter(TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][hittype]["Target"]) ) then
					tcl_DEBUG("Mob found, backup stats ...");
					local filtered = "FILTER_"..hittype;
					local backup = "OLD_"..hittype;
					TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][filtered] = {};
					TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][filtered] = TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][hittype];
					if ( TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][backup] == nil ) then
						table.remove(TCL_SETTINGS[TCL_REALM]["DATA"][attacktype], hittype);
					else
						TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][hittype] = TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][backup];
					end
				end
			end
		end
	end
	tcl_DEBUG("All filtered mobs deleted if found.");
	TitanPanelButton_UpdateButton(TITAN_CRITLINE_ID);
end

function tcl_RestoreAllRecordsWithMobsInFilter()
	tcl_DEBUG("Restore all records with filtered mobs ...");
	for k, v in pairs(TCL_SETTINGS[TCL_REALM]["DATA"]) do
		attacktype = k;
		for k, v in pairs(TCL_SETTINGS[TCL_REALM]["DATA"][attacktype]) do
			if ( k == "CRIT" or k == "NORMAL" ) then
				local hittype = k;
				if ( tcl_IsMobInFilter(TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][hittype]["Target"]) ) then
					tcl_DEBUG("Mob found, restoring stats ...");
					local filtered = "FILTER_"..hittype;
					local backup = "OLD_"..hittype;
					if ( TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][filtered] ~= nil ) then
						if ( TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][backup] == nil ) then
							TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][backup] = {};
							TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][backup] = TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][hittype];
						end
						TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][hittype] = TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][filtered];
					end
				end
			end
		end
	end
	tcl_DEBUG("All records with filtered mobs are restored.");
	TitanPanelButton_UpdateButton(TITAN_CRITLINE_ID);
end

function tcl_RecordHit(AttackType, HitType, Damage, uname, IsHealing)
	local targetlvl = UnitLevel("target");
	local ulevel = false;
	if (targetlvl == nil) then 
		targetlvl = 0;
	end
	if (Damage == nil) then
		tcl_DEBUG("No Damage! exiting...");
		return;
	end
	if (uname == nil) then 
		uname = "??"; 
	end
	if (not UnitExists("target")) then
		if (IsHealing == DAMAGE_TYPE_HEAL) then
			uname = UnitName("player");
			ulevel = UnitLevel("player");
		else
			tcl_DEBUG("No Target! exiting...");
			return;
		end
	end
	if (IsHealing == nil) then
		tcl_DEBUG("IsHealing==nil! exiting...");
		return;
	end
	if ( (UnitIsPlayer("target") ~= 1) and (TCL_SETTINGS[TCL_REALM]["SETTINGS"]["PVPONLY"] == "1") ) then
		tcl_DEBUG("Target !=player and PvPOnly enabled, exiting...");
		return;
	end
	local leveldiff = 0;
	if (UnitLevel("player") < UnitLevel("target")) then
		leveldiff = (UnitLevel("target") - UnitLevel("player"));
	else
		leveldiff = (UnitLevel("player") - UnitLevel("target"));
	end
	tcl_DEBUG("Level difference: "..leveldiff);
	if ( (tonumber(TCL_SETTINGS[TCL_REALM]["SETTINGS"]["LVLADJ"]) ~= 0) and (tonumber(TCL_SETTINGS[TCL_REALM]["SETTINGS"]["LVLADJ"]) < leveldiff) ) then
		tcl_DEBUG("Target level too low and LvlAdj enabled, exiting...");
		return;
	end
	if (TCL_SETTINGS == nil) then
		return;
	end
	if (TCL_SETTINGS[TCL_REALM] == nil) then
		tcl_DEBUG("TCL_SETTINGS[TCL_REALM] should not be nil at this point!");
		tcl_Initialize();
	end
	if (TCL_SETTINGS[TCL_REALM]["DATA"] == nil) then
		tcl_DEBUG("TCL_SETTINGS[TCL_REALM][DATA] should not be nil at this point!");
		tcl_Initialize();
	end
	if (TCL_SETTINGS[TCL_REALM]["DATA"][AttackType] == nil) then
		tcl_DEBUG("Creating TCL_SETTINGS["..TCL_REALM.."][DATA]["..AttackType.."]...");
		TCL_SETTINGS[TCL_REALM]["DATA"][AttackType] = {};
	end
	if ( TCL_SETTINGS[TCL_REALM]["DATA"][AttackType]["Filter"] == nil ) then
		tcl_DEBUG("Creating TCL_SETTINGS["..TCL_REALM.."][DATA]["..AttackType.."][Filter]...");
		TCL_SETTINGS[TCL_REALM]["DATA"][AttackType]["Filter"] = "0";
	end
	if (TCL_SETTINGS[TCL_REALM]["DATA"][AttackType][HitType] == nil) then
		tcl_DEBUG("Creating TCL_SETTINGS["..TCL_REALM.."][DATA]["..AttackType.."]["..HitType.."]...");
		TCL_SETTINGS[TCL_REALM]["DATA"][AttackType][HitType] = {};
	end
	if ( TCL_SETTINGS[TCL_REALM]["DATA"][AttackType][HitType]["Value"] == nil ) then
		tcl_DEBUG("Creating TCL_SETTINGS["..TCL_REALM.."][DATA]["..AttackType.."]["..HitType.."][Value]...");
		TCL_SETTINGS[TCL_REALM]["DATA"][AttackType][HitType]["Value"] = 0;
	end
	local oldhitvalue = TCL_SETTINGS[TCL_REALM]["DATA"][AttackType][HitType]["Value"];
	TCL_SETTINGS[TCL_REALM]["DATA"][AttackType][HitType]["Value"] = oldhitvalue + 1;
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["FILTER_MOBS"] == "1" ) then
		if ( tcl_IsMobInFilter(uname) ) then
			return;
		end
	end
	if ( TCL_SETTINGS[TCL_REALM]["DATA"][AttackType][HitType]["Damage"] == nil or TCL_SETTINGS[TCL_REALM]["DATA"][AttackType][HitType]["Damage"] < Damage ) then
		TCL_SETTINGS[TCL_REALM]["DATA"][AttackType][HitType]["Damage"] = Damage;
		TCL_SETTINGS[TCL_REALM]["DATA"][AttackType][HitType]["Target"] = uname;
		if ( ulevel ) then
			TCL_SETTINGS[TCL_REALM]["DATA"][AttackType][HitType]["Level"] = ulevel;
		else
			TCL_SETTINGS[TCL_REALM]["DATA"][AttackType][HitType]["Level"] = UnitLevel("target");
		end
		TCL_SETTINGS[TCL_REALM]["DATA"][AttackType][HitType]["Date"] = date();
		TCL_SETTINGS[TCL_REALM]["DATA"][AttackType][HitType]["IsHeal"] = IsHealing;
		tcl_DisplayNewRecord(AttackType, Damage, HitType);
	end
end

function tcl_RecordMiss(text)
	if ( text == nil ) then
		tcl_DEBUG("RecordMiss text value is nil, return.");
		return;
	end
	if ( string.find(text, "(%d+)") ) then
		tcl_DEBUG("RecordMiss found a number in text, return.");
		return;
	else
		for k, v in pairs(TCL_SETTINGS[TCL_REALM]["DATA"]) do
			attacktype = k;
			if ( string.find(text, attacktype) ) then
				tcl_DEBUG("RecordMiss found "..attacktype.." in text, add a miss and return.");
				if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["Misses"] == nil ) then
					TCL_SETTINGS[TCL_REALM]["DATA"][k]["Misses"] = 1;
					do return end;
				else
					local oldvalue = TCL_SETTINGS[TCL_REALM]["DATA"][k]["Misses"];
					TCL_SETTINGS[TCL_REALM]["DATA"][k]["Misses"] = oldvalue + 1;
					do return end;
				end
			end
		end
		tcl_DEBUG("RecordMiss found no attacktype in text.");
		if ( TCL_SETTINGS[TCL_REALM]["DATA"][NORMAL_HIT_TEXT] == nil ) then
			tcl_DEBUG("RecordMiss creating TCL_SETTINGS["..TCL_REALM.."][DATA]["..NORMAL_HIT_TEXT.."].");
			TCL_SETTINGS[TCL_REALM]["DATA"][NORMAL_HIT_TEXT] = {};
		end
		if ( TCL_SETTINGS[TCL_REALM]["DATA"][NORMAL_HIT_TEXT]["Misses"] == nil ) then
			tcl_DEBUG("RecordMiss creating TCL_SETTINGS["..TCL_REALM.."][DATA]["..NORMAL_HIT_TEXT.."][Misses] = 1.");
			TCL_SETTINGS[TCL_REALM]["DATA"][NORMAL_HIT_TEXT]["Misses"] = 1;
			return;
		else
			tcl_DEBUG("RecordMiss add a miss to "..NORMAL_HIT_TEXT..".");
			local oldvalue = TCL_SETTINGS[TCL_REALM]["DATA"][NORMAL_HIT_TEXT]["Misses"];
			TCL_SETTINGS[TCL_REALM]["DATA"][NORMAL_HIT_TEXT]["Misses"] = oldvalue + 1;
			return;
		end
	end
	tcl_DEBUG("RecordMiss found nothing and return.");
end

function tcl_DisplayNewRecord(AttackType, DamageAmount, HitType)
	local splash_msg = TITAN_CRITLINE_NEW_RECORD_MSG;
	if ( HitType == "CRIT" ) then
		splash_msg = TITAN_CRITLINE_NEW_CRIT_RECORD_MSG;
	end
	tcl_DEBUG(format(splash_msg, AttackType));
	if(TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SPLASH"] == "1") then
		TitanCritLineSplashFrame:AddMessage(DamageAmount, 1, 1, 1, 1, 3);
		TitanCritLineSplashFrame:AddMessage(format(splash_msg, AttackType), 1, 1, 0, 1, 3);
	end
	if(TCL_SETTINGS[TCL_REALM]["SETTINGS"]["PLAYSOUND"] == "1") then 
		PlaySound("LEVELUP", 1, 1, 0, 1, 3); 
	end
	if(TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SNAPSHOT"] == "1") then 
		TakeScreenshot(); 
	end
	TitanPanelButton_UpdateButton(TITAN_CRITLINE_ID);
end

function tcl_GetHighestCrit()
	local hidmg = 0;
	local attack = "";
	local enemy = "";
	if (TCL_SETTINGS == nil) then 
		return hidmg;
	end
	if (TCL_SETTINGS[TCL_REALM] == nil) then 
		return hidmg; 
	end
	if (TCL_SETTINGS[TCL_REALM]["DATA"] == nil) then 
		return hidmg; 
	end
	for k,v in pairs (TCL_SETTINGS[TCL_REALM]["DATA"]) do
		if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["Filter"] == "0" ) then
			if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["CRIT"] ~= nil ) then
				if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["CRIT"]["IsHeal"] == "0" ) then
					if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["CRIT"]["Damage"] > hidmg ) then
						hidmg = TCL_SETTINGS[TCL_REALM]["DATA"][k]["CRIT"]["Damage"];
						attack = k;
						enemy = TCL_SETTINGS[TCL_REALM]["DATA"][k]["CRIT"]["Target"].." ("..TCL_SETTINGS[TCL_REALM]["DATA"][k]["CRIT"]["Level"]..")";
					end
				end
			end
		else
			tcl_DEBUG(k.." Filter is on, did not recognized for highest CRIT.");
		end
	end
	return hidmg, attack, enemy;
end

function tcl_GetHighestHealCrit()
	local hidmg = 0;
	local attack = "";
	local enemy = "";
	if (TCL_SETTINGS == nil) then 
		return hidmg; 
	end
	if (TCL_SETTINGS[TCL_REALM] == nil) then 
		return hidmg; 
	end
	if (TCL_SETTINGS[TCL_REALM]["DATA"] == nil) then 
		return hidmg; 
	end
	for k,v in pairs (TCL_SETTINGS[TCL_REALM]["DATA"]) do
		if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["Filter"] == "0" ) then
			if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["CRIT"] ~= nil ) then
				if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["CRIT"]["IsHeal"] == "1" ) then
					if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["CRIT"]["Damage"] > hidmg ) then
						hidmg = TCL_SETTINGS[TCL_REALM]["DATA"][k]["CRIT"]["Damage"];
						attack = k;
						enemy = TCL_SETTINGS[TCL_REALM]["DATA"][k]["CRIT"]["Target"].." ("..TCL_SETTINGS[TCL_REALM]["DATA"][k]["CRIT"]["Level"]..")";
					end
				end
			end
		else
			tcl_DEBUG(k.." Filter is on, did not recognized for highest HEALCRIT");
		end
	end
	return hidmg, attack, enemy;
end

function tcl_GetHighestDamage()
	local hidmg = 0;
	local attack = "";
	local enemy = "";
	if (TCL_SETTINGS == nil) then 
		return hidmg; 
	end
	if (TCL_SETTINGS[TCL_REALM] == nil) then 
		return hidmg; 
	end
	if (TCL_SETTINGS[TCL_REALM]["DATA"] == nil) then 
		return hidmg; 
	end
	for k,v in pairs (TCL_SETTINGS[TCL_REALM]["DATA"]) do
		if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["Filter"] == "0" ) then
			if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["NORMAL"] ~= nil ) then
				if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["NORMAL"]["IsHeal"] == "0" ) then
					if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["NORMAL"]["Damage"] > hidmg ) then
						hidmg = TCL_SETTINGS[TCL_REALM]["DATA"][k]["NORMAL"]["Damage"];
						attack = k;
						enemy = TCL_SETTINGS[TCL_REALM]["DATA"][k]["NORMAL"]["Target"].." ("..TCL_SETTINGS[TCL_REALM]["DATA"][k]["NORMAL"]["Level"]..")";
					end
				end
			end
		else
			tcl_DEBUG(k.." Filter is on, did not recognized for highest HIT.")
		end
	end
	return hidmg, attack, enemy;
end

function tcl_GetHighestHeal()
	local hidmg = 0;
	local attack = "";
	local enemy = "";
	if (TCL_SETTINGS == nil) then 
		return hidmg; 
	end
	if (TCL_SETTINGS[TCL_REALM] == nil) then 
		return hidmg; 
	end
	if (TCL_SETTINGS[TCL_REALM]["DATA"] == nil) then 
		return hidmg; 
	end
	for k,v in pairs (TCL_SETTINGS[TCL_REALM]["DATA"]) do
		if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["Filter"] == "0" ) then
			if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["NORMAL"] ~= nil ) then
				if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["NORMAL"]["IsHeal"] == "1" ) then
					if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["NORMAL"]["Damage"] > hidmg ) then
						hidmg = TCL_SETTINGS[TCL_REALM]["DATA"][k]["NORMAL"]["Damage"];
						attack = k;
						enemy = TCL_SETTINGS[TCL_REALM]["DATA"][k]["NORMAL"]["Target"].." ("..TCL_SETTINGS[TCL_REALM]["DATA"][k]["NORMAL"]["Level"]..")";
					end
				end
			end
		else
			tcl_DEBUG(k.." Filter is on, did not recognized for highest HEAL.");
		end
	end
	return hidmg, attack, enemy;
end

function tcl_GetHighestCritPercentage()
	local critperc, crithits, normhits;
	local hidmg = 0;
	local attack = "";
	if (TCL_SETTINGS == nil) then 
		return hidmg;
	end
	if (TCL_SETTINGS[TCL_REALM] == nil) then 
		return hidmg; 
	end
	if (TCL_SETTINGS[TCL_REALM]["DATA"] == nil) then 
		return hidmg; 
	end
	for k,v in pairs (TCL_SETTINGS[TCL_REALM]["DATA"]) do
		if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["Filter"] == "0" ) then
			if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["CRIT"] ~= nil ) then
				if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["CRIT"]["IsHeal"] == "0") then
					crithits = TCL_SETTINGS[TCL_REALM]["DATA"][k]["CRIT"]["Value"];
				end
			end
			if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["NORMAL"] ~= nil ) then
				if ( TCL_SETTINGS[TCL_REALM]["DATA"][k]["NORMAL"]["IsHeal"] == "0") then
					normhits = TCL_SETTINGS[TCL_REALM]["DATA"][k]["NORMAL"]["Value"];
				end
			end
			if ( crithits == 0 or crithits == nil or normhits == 0 or normhits == nil ) then
				critperc = 0;
			else
				critperc = crithits / ( ( crithits + normhits ) / 100 );
			end
			tcl_DEBUG(k.." critical percentage: "..critperc);
			if ( critperc > hidmg ) then
				hidmg = critperc;
				attack = k;
			end
		else
			tcl_DEBUG(k.." Filter is on, did not recognized for highest CRIT percentage");
		end
	end
	return format("%.2f", hidmg), attack;
end

--[[ tooltip functions ]]
function tcl_DisplayDialog(message)
	GameTooltip:SetText(message);
	GameTooltip:Show();
end

function tcl_DisplaySummary()
	tcl_DisplayDialog(tcl_GetSummaryRichText());
end

function tcl_DisplayAbout()
	tcl_DisplayDialog(tcl_GetAboutRichText());
end

function tcl_GetSummaryRichText()
	local hicrit = tcl_GetHighestCrit();
	local hicritperc = tcl_GetHighestCritPercentage();
	local hidmg = tcl_GetHighestDamage();
	local hihealcrit = tcl_GetHighestHealCrit();
	local hihealdmg = tcl_GetHighestHeal();
	local rtfAttack="";
	for k,v in pairs (TCL_SETTINGS[TCL_REALM]["DATA"]) do
		attacktype = k;
		if ( TCL_SETTINGS[TCL_REALM]["DATA"][attacktype]["Filter"] == "0" ) then
			local crithits, normhits, critperc, normperc;
			if ( TCL_SETTINGS[TCL_REALM]["DATA"][attacktype]["CRIT"] == nil) then
				crithits = 0;
			else
				if ( TCL_SETTINGS[TCL_REALM]["DATA"][attacktype]["CRIT"]["Value"] == nil) then
					crithits = 0;
				else
					crithits = TCL_SETTINGS[TCL_REALM]["DATA"][attacktype]["CRIT"]["Value"];
				end
			end
			if ( TCL_SETTINGS[TCL_REALM]["DATA"][attacktype]["NORMAL"] == nil) then
				normhits = 0;
			else
				if ( TCL_SETTINGS[TCL_REALM]["DATA"][attacktype]["NORMAL"]["Value"] == nil) then
					normhits = 0;
				else
					normhits = TCL_SETTINGS[TCL_REALM]["DATA"][attacktype]["NORMAL"]["Value"];
				end
			end
			local allhits = normhits + crithits;
			if ( crithits == 0 ) then
				critperc = 0;
			else
				critperc = format("%.2f", crithits / ( allhits / 100 ) );
			end
			if ( normhits == 0 ) then
				normperc = 0;
			else
				normperc = format("%.2f", normhits / ( allhits / 100 ) );
			end
			local allmisses;
			if ( TCL_SETTINGS[TCL_REALM]["DATA"][attacktype]["Misses"] == nil) then
				allmisses = 0;
			else
				allmisses = TCL_SETTINGS[TCL_REALM]["DATA"][attacktype]["Misses"];
			end
			local allswings = allmisses + allhits;
			local hitperc = format("%.2f", allhits / ( allswings / 100 ) );
			if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHOWHITS"] == "1" ) then
				rtfAttack = rtfAttack..COLOR(HEADER_TEXT_COLOR, attacktype).."\t "..COLOR(HEADER_TEXT_COLOR, allhits).." "..HIT_TEXT.." ("..COLOR(HEADER_TEXT_COLOR, hitperc.." %")..")\n";
			else
				rtfAttack = rtfAttack..COLOR(HEADER_TEXT_COLOR, attacktype).."\n";
			end
			for k,v in pairs (TCL_SETTINGS[TCL_REALM]["DATA"][attacktype]) do
				if (k == "NORMAL") then
					rtfAttack = rtfAttack.."  "..COLOR(SUBHEADER_TEXT_COLOR, NORMAL_TEXT).." [";
				elseif ( k == "CRIT" ) then
					rtfAttack = rtfAttack.."  "..COLOR(SUBHEADER_TEXT_COLOR, CRIT_TEXT).." [";
				end
				if ( k == "CRIT") then
					if (TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["IsHeal"] == "0") then
						if (TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Damage"] == hicrit) then
							rtfAttack = rtfAttack..COLOR(HINT_TEXT_COLOR, TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Damage"]).."]";
						else
							rtfAttack = rtfAttack..COLOR(BODY_TEXT_COLOR, TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Damage"]).."]";
						end
					else
						if (TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Damage"] == hihealcrit) then
							rtfAttack = rtfAttack..COLOR(HINT_TEXT_COLOR, TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Damage"]).."]";
						else
							rtfAttack = rtfAttack..COLOR(BODY_TEXT_COLOR, TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Damage"]).."]";
						end
					end
					if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHOWCRIT"] == "1" ) then
						if ( critperc == hicritperc ) then
							rtfAttack = rtfAttack.." ["..COLOR(HINT_TEXT_COLOR, critperc.."%").."]\t";
						else
							rtfAttack = rtfAttack.." ["..COLOR(BODY_TEXT_COLOR, critperc.."%").."]\t";
						end
					else
						rtfAttack = rtfAttack.."\t";
					end
				elseif ( k == "NORMAL" ) then
					tcl_DEBUG(TCL_REALM..", "..attacktype..", "..k);
					if (TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["IsHeal"] == "0") then
						if (TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Damage"] == hidmg) then
							rtfAttack = rtfAttack..COLOR(HINT_TEXT_COLOR, TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Damage"]).."]";
						else
							rtfAttack = rtfAttack..COLOR(BODY_TEXT_COLOR, TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Damage"]).."]";
						end
					else
						if (TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Damage"] == hihealdmg) then
							rtfAttack = rtfAttack..COLOR(HINT_TEXT_COLOR, TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Damage"]).."]";
						else
							rtfAttack = rtfAttack..COLOR(BODY_TEXT_COLOR, TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Damage"]).."]";
						end
					end
					if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["SHOWCRIT"] == "1" ) then
						rtfAttack = rtfAttack.." ["..COLOR(BODY_TEXT_COLOR, normperc.."%").."]\t";
					else
						rtfAttack = rtfAttack.."\t";
					end
				end
				if ( k == "NORMAL" ) then
					if (TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Level"] == -1) then
						rtfAttack = rtfAttack..COLOR(BODY_TEXT_COLOR, TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Target"]).." ["..COLOR(BODY_TEXT_COLOR, "??").."]\n";
					else
						rtfAttack = rtfAttack..COLOR(BODY_TEXT_COLOR, TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Target"]).." ["..COLOR(BODY_TEXT_COLOR, TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Level"]).."]\n";
					end
				elseif ( k == "CRIT" ) then
					if (TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Level"] == -1) then
						rtfAttack = rtfAttack..COLOR(BODY_TEXT_COLOR, TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Target"]).." ["..COLOR(BODY_TEXT_COLOR, "??").."]\n";
					else
						rtfAttack = rtfAttack..COLOR(BODY_TEXT_COLOR, TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Target"]).." ["..COLOR(BODY_TEXT_COLOR, TCL_SETTINGS[TCL_REALM]["DATA"][attacktype][k]["Level"]).."]\n";
					end
				end
			end
		end
	end
	return rtfAttack
end

function tcl_GetAboutRichText()
	return 
		COLOR(HEADER_TEXT_COLOR, TITAN_CRITLINE_ID.." v"..TITAN_CRITLINE_VERSION).."\n"..
		COLOR(SUBHEADER_TEXT_COLOR, "Developers: ").."\n"..
		COLOR(BODY_TEXT_COLOR, "Sordit: ".."\t".."Concept and Stand-Alone version").."\n"..
		COLOR(BODY_TEXT_COLOR, "Uggh: ".."\t".."Titan Panel version < 0.3.7").."\n\n"..
		COLOR(BODY_TEXT_COLOR, "Falli: ".."\t".."Titan Panel version > 0.3.7");
end

--[[ chat functions ]]
function tcl_PostMessage(message_array,channel)
	if ( message_array == nil or type(message_array) ~= "table") then
		message_array = tcl_GetRecordChatText();
	end
	if ( channel == nil ) then
		channel = "GUILD";
		if ( GetNumPartyMembers() > 0 ) then
			channel = "PARTY";
		end
		if ( GetNumRaidMembers() > 0 ) then
			channel = "RAID";
		end
	end
	table.foreach(message_array, function(k,v) SendChatMessage(v, channel); end);
end

function tcl_PostToRaid()
	if ( GetNumRaidMembers ~= 0 ) then
		tcl_PostMessage(tcl_GetRecordChatText(),"RAID")
	else
		tcl_PostMessage(tcl_GetRecordChatText())
	end
end

function tcl_PostToParty()
	if ( GetNumPartyMembers ~= 0 ) then
		tcl_PostMessage(tcl_GetRecordChatText(),"PARTY")
	else
		tcl_PostMessage(tcl_GetRecordChatText())
	end
end

function tcl_PostToGuild()
	local guildName, guildRankName, guildRankIndex = GetGuildInfo("player");
	if ( guildName ) then
		tcl_PostMessage(tcl_GetRecordChatText(),"GUILD")
	else
		local message_array = tcl_GetRecordChatText();
		table.foreach(message_array, function(k,v) tcl_Msg(v); end);
	end
end

function tcl_GetRecordChatText()
	local hicrit, acrit, ecrit = tcl_GetHighestCrit();
	local hidmg, anormal, enormal = tcl_GetHighestDamage();
	local hihealcrit, hcrit, ehcrit = tcl_GetHighestHealCrit();
	local hihealdmg, hnormal, ehnormal = tcl_GetHighestHeal();
	local text = {};
	table.insert(text, TITAN_CRITLINE_ID.." "..RECORDS_TEXT..":");
	table.insert(text, CRIT_TEXT..": "..acrit.." ("..hicrit..")".." ["..ecrit.."]");
	table.insert(text, NORMAL_TEXT..": "..anormal.." ("..hidmg..")".." ["..enormal.."]");
	if ( TCL_SETTINGS[TCL_REALM]["SETTINGS"]["FILTER_HEALING"] == "0" ) then
		if ( hihealcrit > 0 ) then
			table.insert(text, CRIT_TEXT..": "..hcrit.." ("..hihealcrit..")".." ["..ehcrit.."]");
		end
		if ( hihealdmg > 0 ) then
			table.insert(text, NORMAL_TEXT..": "..hnormal.." ("..hihealdmg..")".." ["..ehnormal.."]");
		end
	end
	return text;
end

--[[ misc help functions ]]
function COLOR(color, msg)
	if ( msg == nil ) then
		return;
	end
	return color..msg..FONT_COLOR_CODE_CLOSE;
end

function tcl_Msg(msg)
	if ( msg == nil ) then
		msg = "------------------------------";
	end
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(msg);
	end
end

function tcl_Rebuild()
	tcl_Msg(TITAN_CRITLINE_ID.." "..TITAN_CRITLINE_VERSION.." rebuilding data.");
	TCL_SETTINGS[TCL_REALM] = nil;
	tcl_Initialize();
	tcl_Msg(TITAN_CRITLINE_ID.." "..TITAN_CRITLINE_VERSION.." rebuilding data complete.");
end

function tcl_DEBUG(message)
	if (DEBUG and DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage("DEBUG: "..message);
	end
end

