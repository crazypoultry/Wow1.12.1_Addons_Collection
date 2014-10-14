TITAN_TITANPA_ID = "TitanPA";
TITAN_TITANPA_FREQUENCY = 1;
TITAN_TITANPA_VERSION = "1.1";

TITAN_TITANPA_ClassColor = {
     ["HUNTER"] 	= "|c00AAD372",
     ["WARLOCK"] 	= "|c009382c9",
     ["PRIEST"] 	= "|c00FFFFFF",
     ["PALADIN"] 	= "|c00F48CBA",
     ["MAGE"] 		= "|c0068CCEF",
     ["ROGUE"] 		= "|c00FFF468",
     ["DRUID"] 		= "|c00FF7C0A",
     ["WARRIOR"] 	= "|c00C69B6D"
};


function TitanPanelTitanPAButton_OnLoad()
	TITANPA_BLESSTIME1 = 0;
	TITANPA_BLESSTIME2 = 0;
	TITANPA_BLESSCOUNT = 0;
	this.registry = {
		id = TITAN_TITANPA_ID,
		version = TITAN_TITANPA_VERSION,
		menuText = PANZA_TITLE,
		buttonTextFunction = "TitanPanelTitanPAButton_GetButtonText",
		tooltipTitle = PANZA_TITLE .. " " .. PANZA_VERSION,
		tooltipTextFunction = "TitanPanelTitanPAButton_GetTooltipText",
		frequency = TITAN_TITANPA_FREQUENCY,
		icon = "Interface\\Addons\\Panza\\Images\\PanzaButton-Down",
		iconWidth = 16,
		iconButtonWidth = 24,
		category = "Combat",
		savedVariables = {
			ShowIcon = 1,
			ShowLabelText = 1,
			ShowSymbols = 1,
			ShowSymbolK = 1,			-- Kings
			ShowSymbolD = 1,			-- Divinity
			ShowSymbolHC = 1,			-- Holy Candle
			ShowSymbolSC = 1,			-- Sacred Candle
			ShowSymbolLF = 1,			-- Light Feather
			ShowSymbolKText = 1,
			ShowSymbolDText = 1,
			ShowSymbolHCText = 1,
			ShowSymbolSCText = 1,
			ShowSymbolLFText = 1,
			ShowSymbolsAsInitials = 1,
			ShowSymbolColorText = 1,
			ShowFailures = 1,
			ShowFailuresCount = 1,
			ShowFailuresCountPercent = 1,
			ShowFailuresColorText = 1,
			ShowBlessings = 1,
			ShowBlessingsCount = 1,
			ShowBlessingsCountPercent = 1,
			ShowBlessingsTime = 1,
			ShowBlessingsColorText = 1,
			ShowTTA = 1,
			ShowTTB = 0,
			ShowTTC = 0,
			ShowTTD = 0,
		}
	};
end

function TitanPanelTitanPAButton_GetButtonText(id)

	local retvalue = " ";

	if (TitanGetVar(TITAN_TITANPA_ID, "ShowLabelText")) then
		retvalue = "PA: ";
	end

	if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbols")) then
		retvalue = retvalue .. TitanPAFormatSymbols();
	end

	if (TitanGetVar(TITAN_TITANPA_ID, "ShowFailures")) then
		retvalue = retvalue .. TitanPAFormatFailures();
	end

	if (TitanGetVar(TITAN_TITANPA_ID, "ShowBlessings")) then
		retvalue = retvalue .. TitanPAFormatBlessings();
	end

	return retvalue;
end

--Sets the Tooltip to whatever is configured
function TitanPanelTitanPAButton_GetTooltipText()
	if (TitanGetVar(TITAN_TITANPA_ID, "ShowTTA")) then
		return TitanPASetTT_Status();
	elseif (TitanGetVar(TITAN_TITANPA_ID, "ShowTTB")) then
		return TitanPASetTT_Ex();
	elseif (TitanGetVar(TITAN_TITANPA_ID, "ShowTTC")) then
		return TitanPASetTT_Bless();
	elseif (TitanGetVar(TITAN_TITANPA_ID, "ShowTTD")) then
		return TitanPASetTT_Fails();
	else
		return "Whoops";
	end
end

function TitanPanelRightClickMenu_PrepareTitanPAMenu()
	local info = {};

	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
		if (UIDROPDOWNMENU_MENU_VALUE == "titanPAgbmenu") then
			info = {};
			info.text = PANZA_PBM_CBX_GBME;
			info.value = PANZA_PBM_CBX_GBME;
			info.func = TitanPAToggleGBSELF;
			info.checked = PASettings.Switches.GreaterBlessings.SOLO;
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info,UIDROPDOWNMENU_MENU_LEVEL);

			info = {};
			info.text = PANZA_PBM_CBX_GBPARTY;
			info.value = PANZA_PBM_CBX_GBPARTY;
			info.func = TitanPAToggleGBPARTY;
			info.checked = PASettings.Switches.GreaterBlessings.PARTY;
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info,UIDROPDOWNMENU_MENU_LEVEL);

			info = {};
			info.text = PANZA_PBM_CBX_GBRAID;
			info.value = PANZA_PBM_CBX_GBRAID;
			info.func = TitanPAToggleGBRAID;
			info.checked = PASettings.Switches.GreaterBlessings.RAID;
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info,UIDROPDOWNMENU_MENU_LEVEL);

			info = {};
			info.text = PANZA_PBM_CBX_GBBG;
			info.value = PANZA_PBM_CBX_GBBG;
			info.func = TitanPAToggleGBBG;
			info.checked = PASettings.Switches.GreaterBlessings.BG;
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info,UIDROPDOWNMENU_MENU_LEVEL);
		end

	--Menu for Symbol display options
		if (UIDROPDOWNMENU_MENU_VALUE == "TitanPAShowSymbolsMenu") then

		--Show Symbol Text colored
			info = {};
			info.text = TITAN_PANEL_MENU_SHOW_COLORED_TEXT;
			info.value = {TITAN_TITANPA_ID, "ShowSymbolColorText"};
			info.func = TitanPanelRightClickMenu_ToggleVar;
			info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolColorText");
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		--Show Symbol Names as the initial
			info = {};
			info.text = TITANPA_SHOW_INITS;
			info.value = {TITAN_TITANPA_ID, "ShowSymbolsAsInitials"};
			info.func = TitanPanelRightClickMenu_ToggleVar;
			info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolsAsInitials");
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			if (PA.PlayerClass=="PALADIN") then

				--Show Kings at all
				info = {};
				info.text = format(TITANPA_SHOW, PANZA_KINGSCOUNT_SHORTNAME);
				info.value = {TITAN_TITANPA_ID, "ShowSymbolK"};
				info.func = TitanPanelRightClickMenu_ToggleVar;
				info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolK");
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

				--Show the Kings label
				info = {};
				info.text = format(TITANPA_SHOW_LABEL, PANZA_KINGSCOUNT_SHORTNAME);
				info.value = {TITAN_TITANPA_ID, "ShowSymbolKText"};
				info.func = TitanPanelRightClickMenu_ToggleVar;
				info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolKText");
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

				--Show Divinity at all
				info = {};
				info.text = format(TITANPA_SHOW, PANZA_DIVINITYCOUNT_SHORTNAME);
				info.value = {TITAN_TITANPA_ID, "ShowSymbolD"};
				info.func = TitanPanelRightClickMenu_ToggleVar;
				info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolD");
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

				--Show the Divinity label
				info = {};
				info.text = format(TITANPA_SHOW_LABEL, PANZA_DIVINITYCOUNT_SHORTNAME);
				info.value = {TITAN_TITANPA_ID, "ShowSymbolDText"};
				info.func = TitanPanelRightClickMenu_ToggleVar;
				info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolDText");
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			elseif (PA.PlayerClass=="PRIEST") then

				-- Show Light Feathers at all
				info = {};
				info.text = format(TITANPA_SHOW, PANZA_FEATHERCOUNT_ITEMNAME);
				info.value = {TITAN_TITANPA_ID, "ShowSymbolLF"};
				info.func = TitanPanelRightClickMenu_ToggleVar;
				info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolLF");
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

				--Show the Light Feather Text
				info = {};
				info.text = format(TITANPA_SHOW_LABEL, PANZA_FEATHERCOUNT_ITEMNAME);
				info.value = {TITAN_TITANPA_ID, "ShowSymbolLFText"};
				info.func = TitanPanelRightClickMenu_ToggleVar;
				info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolLFText");
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

				--Show Holy Candles at all
				info = {};
				info.text = format(TITANPA_SHOW, PANZA_HOLYCANCOUNT_ITEMNAME);
				info.value = {TITAN_TITANPA_ID, "ShowSymbolHC"};
				info.func = TitanPanelRightClickMenu_ToggleVar;
				info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolHC");
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

				--Show the Holy Candle label
				info = {};
				info.text = format(TITANPA_SHOW_LABEL, PANZA_HOLYCANCOUNT_ITEMNAME);
				info.value = {TITAN_TITANPA_ID, "ShowSymbolHCText"};
				info.func = TitanPanelRightClickMenu_ToggleVar;
				info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolHCText");
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

				--Show Sacred Candles at all
				info = {};
				info.text = format(TITANPA_SHOW, PANZA_SACREDCANCOUNT_ITEMNAME);
				info.value = {TITAN_TITANPA_ID, "ShowSymbolSC"};
				info.func = TitanPanelRightClickMenu_ToggleVar;
				info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolSC");
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

				--Show the Holy Candle label
				info = {};
				info.text = format(TITANPA_SHOW_LABEL, PANZA_SACREDCANCOUNT_ITEMNAME);
				info.value = {TITAN_TITANPA_ID, "ShowSymbolSCText"};
				info.func = TitanPanelRightClickMenu_ToggleVar;
				info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolSCText");
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

			elseif (PA.PlayerClass=="DRUID") then

			elseif (PA.PlayerClass=="SHAMAN") then
			
			elseif (PA.PlayerClass=="MAGE") then
				-- Show Light Feathers at all
				info = {};
				info.text = format(TITANPA_SHOW, PANZA_FEATHERCOUNT_ITEMNAME);
				info.value = {TITAN_TITANPA_ID, "ShowSymbolLF"};
				info.func = TitanPanelRightClickMenu_ToggleVar;
				info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolLF");
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

				--Show the Light Feather Text
				info = {};
				info.text = format(TITANPA_SHOW_LABEL, PANZA_FEATHERCOUNT_ITEMNAME);
				info.value = {TITAN_TITANPA_ID, "ShowSymbolLFText"};
				info.func = TitanPanelRightClickMenu_ToggleVar;
				info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolLFText");
				info.keepShownOnClick = 1;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);			
			end
		end

	--Menu for Spell Failure display options
		if (UIDROPDOWNMENU_MENU_VALUE == "TitanPAShowFailuresMenu") then
		--Show Failures Text colored
			info = {};
			info.text = TITAN_PANEL_MENU_SHOW_COLORED_TEXT
			info.value = {TITAN_TITANPA_ID, "ShowFailuresColorText"};
			info.func = TitanPanelRightClickMenu_ToggleVar;
			info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowFailuresColorText");
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		--Show Failure Counts
			info = {};
			info.text = TITANPA_FAILURE_COUNT;
			info.value = {TITAN_TITANPA_ID, "ShowFailuresCount"};
			info.func = TitanPanelRightClickMenu_ToggleVar;
			info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowFailuresCount");
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		--Show Failure Count Percents
			info = {};
			info.text = TITANPA_FAILURE_PERCENT;
			info.value = {TITAN_TITANPA_ID, "ShowFailuresCountPercent"};
			info.func = TitanPanelRightClickMenu_ToggleVar;
			info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowFailuresCountPercent");
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end

	--Menu for Blessing display options
		if (UIDROPDOWNMENU_MENU_VALUE == "TitanPAShowBlessingsMenu") then
		--Show Blessing Text colored
			info = {};
			info.text = TITAN_PANEL_MENU_SHOW_COLORED_TEXT
			info.value = {TITAN_TITANPA_ID, "ShowBlessingsColorText"};
			info.func = TitanPanelRightClickMenu_ToggleVar;
			info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowBlessingsColorText");
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		--Show Blessing Counts
			info = {};
			info.text = TITANPA_BLESSED_COUNT;
			info.value = {TITAN_TITANPA_ID, "ShowBlessingsCount"};
			info.func = TitanPanelRightClickMenu_ToggleVar;
			info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowBlessingsCount");
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		--Show Blessing Count Percents
			info = {};
			info.text = TITANPA_BLESSED_PERCENT;
			info.value = {TITAN_TITANPA_ID, "ShowBlessingsCountPercent"};
			info.func = TitanPanelRightClickMenu_ToggleVar;
			info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowBlessingsCountPercent");
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		--Show Blessing Time 'til next
			info = {};
			info.text = TITANPA_BLESSED_TIME;
			info.value = {TITAN_TITANPA_ID, "ShowBlessingsTime"};
			info.func = TitanPanelRightClickMenu_ToggleVar;
			info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowBlessingsTime");
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
	--Menu for PAW Options
		if (UIDROPDOWNMENU_MENU_VALUE == "TitanPAPAWMenu") then
			info = {};
			info.text = PANZA_PAW_CBX_ENABLE;
			info.value = PANZA_PAW_CBX_ENABLE;
			info.func = TitanPATogglePAWEnable;
			info.checked = PASettings.Switches.Whisper.enabled;
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info,UIDROPDOWNMENU_MENU_LEVEL);

			info = {};
			info.text = PANZA_PAW_CBX_RESPONSE;
			info.value = PANZA_PAW_CBX_RESPONSE;
			info.func = TitanPATogglePAWFeedback;
			info.checked = PASettings.Switches.Whisper.feedback;
			info.keepShownOnClick = 1;
			UIDropDownMenu_AddButton(info,UIDROPDOWNMENU_MENU_LEVEL);
		end
	else
		TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_TITANPA_ID].menuText);
	-- Toggle for displaying the "Status" as the tooltip
		info = {};
		info.text = format(TITANPA_TOOLTIP_OPTION, TITANPA_STATUS);
		info.func = TitanPATTAToggle;
		info.value = {TITAN_TITANPA_ID, "ShowTTA"};
		info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowTTA");
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	-- Toggle for displaying the "Exclusions" as the tooltip
		info = {};
		info.text = format(TITANPA_TOOLTIP_OPTION, TITANPA_EXCLUSIONS);
		info.func = TitanPATTBToggle;
		info.value = {TITAN_TITANPA_ID, "ShowTTB"};
		info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowTTB");
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	-- Toggle for displaying the "Blessing Status" as the tooltip
		info = {};
		info.text = format(TITANPA_TOOLTIP_OPTION, TITANPA_BLESSINGS);
		info.func = TitanPATTCToggle;
		info.value = {TITAN_TITANPA_ID, "ShowTTC"};
		info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowTTC");
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	-- Toggle for displaying the "Spell Failures" as the tooltip
		info = {};
		info.text = format(TITANPA_TOOLTIP_OPTION, TITANPA_FAILURES);
		info.func = TitanPATTDToggle;
		info.value = {TITAN_TITANPA_ID, "ShowTTD"};
		info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowTTD");
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		TitanPanelRightClickMenu_AddSpacer();

	-- Toggle for displaying the minimap button
		info = {};
		info.text = PANZA_OPTS_CBX_BUTT;
		info.func = PAButtonToggle;
		info.value = PANZA_OPTS_CBX_BUTT;
		info.checked = PASettings.Switches.Button;
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	-- Greater Blessings menu
		info = {};
		info.text = TITANPA_GREATER_BLESSINGS;
		info.value = "titanPAgbmenu";
		info.hasArrow = 1;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);

		TitanPanelRightClickMenu_AddSpacer();

	-- Toggle/Menu for showing the Symbol information
		info = {};
		info.text = TITANPA_SHOW_SYMBOLS;
		info.value = "TitanPAShowSymbolsMenu";
		info.func = TitanPAToggleShowSymbols;
		info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowSymbols");
		info.keepShownOnClick = 1;
		info.hasArrow = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	-- Toggle/Menu for showing the Spell Failures information
		info = {};
		info.text = TITANPA_SHOW_FAILURES;
		info.value = "TitanPAShowFailuresMenu";
		info.func = TitanPAToggleShowFailures;
		info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowFailures");
		info.keepShownOnClick = 1;
		info.hasArrow = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	-- Toggle/Menu for showing the blessing cycle status
		info = {};
		info.text = TITANPA_SHOW_BLESTA;
		info.value = "TitanPAShowBlessingsMenu";
		info.func = TitanPAToggleShowBlessings;
		info.checked = TitanGetVar(TITAN_TITANPA_ID, "ShowBlessings");
		info.keepShownOnClick = 1;
		info.hasArrow = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		TitanPanelRightClickMenu_AddSpacer();

	--PAM
		info = {};
		info.text = PANZA_PAM_TITLE;
		info.func = PAFrameTogglePAM;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	--RGS
		info = {};
		info.text = PANZA_RGS_TITLE;
		info.func = PAFrameToggleRGS;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	--PCS
		info = {};
		info.text = PANZA_PCS_TITLE;
		info.func = PAFrameTogglePCS;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	--POM
		info = {};
		info.text = PANZA_POM_TITLE;
		info.func = PAFrameTogglePOM;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	--PBM
		info = {};
		info.text = PANZA_PBM_TITLE;
		info.func = PAFrameTogglePBM;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	--DCB
		info = {};
		info.text = PANZA_DCB_TITLE;
		info.func = PAFrameToggleDCB;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	--PHM
		info = {};
		info.text = PANZA_PHM_TITLE;
		info.func = PAFrameTogglePHM;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	--Panic setup
		info = {};
		info.text = PANZA_PPM_TITLE;
		info.func = PAFrameTogglePPM;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	--PCM
		info = {};
		info.text = PANZA_PCM_TITLE;
		info.func = PAFrameTogglePCM;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	--PMM
		info = {};
		info.text = PANZA_PMM_TITLE;
		info.func = PAFrameTogglePMM;
		info.notcheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	--PAW with submenu
		info = {};
		info.text = PANZA_PAW_TITLE;
		info.value = "TitanPAPAWMenu";
		info.func = PAFrameTogglePAW;
		info.notCheckable = 1;
		info.hasArrow = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	--PFM
		info = {};
		info.text = PANZA_PFM_TITLE;
		info.func = PAFrameTogglePFM;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		TitanPanelRightClickMenu_AddSpacer();

	--PA ClearAll
		info = {};
		info.text = "Clear all Saved Blessings";
		info.func = PACLearAll;
		info.notcheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		TitanPanelRightClickMenu_AddSpacer();

	--Option for toggling the plugin icon
		TitanPanelRightClickMenu_AddToggleIcon(TITAN_TITANPA_ID);
		TitanPanelRightClickMenu_AddToggleLabelText(TITAN_TITANPA_ID);

		TitanPanelRightClickMenu_AddSpacer();

		TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_TITANPA_ID, TITAN_PANEL_MENU_FUNC_HIDE);
	end
end

--function to open the PA options dialog
function TitalPanelTitanPAButton_OnClick(button)
	if ( button == "LeftButton" ) then
		PA:OptsToggle();
	end
end

--function to toggle the minimap button
function PAButtonToggle()
	if(PanzaButtonFrame:IsVisible()) then
		PanzaButtonFrame:Hide();
		PASettings.Switches.Button = false;
	else
		PanzaButtonFrame:Show();
		PASettings.Switches.Button = true;
	end
	cbxPanzaButton:SetChecked(PASettings.Switches.Button == true);
end

--function to toggle the plugin's ShowSymbols variable, since we're using it as a menu as well
function TitanPAToggleShowSymbols()
	TitanToggleVar(TITAN_TITANPA_ID, "ShowSymbols");
end

--function to toggle the plugin's ShowFailures variable, since we're using it as a menu as well
function TitanPAToggleShowFailures()
	TitanToggleVar(TITAN_TITANPA_ID, "ShowFailures");
end

--function to toggle the plugin's ShowBlessings variable, since we're using it as a menu as well
function TitanPAToggleShowBlessings()
	TitanToggleVar(TITAN_TITANPA_ID, "ShowBlessings");
end


--function to swap the titan tooltip options around
function TitanPATTAToggle()
	TitanSetVar(TITAN_TITANPA_ID, "ShowTTA", true);
	TitanSetVar(TITAN_TITANPA_ID, "ShowTTB", false);
	TitanSetVar(TITAN_TITANPA_ID, "ShowTTC", false);
	TitanSetVar(TITAN_TITANPA_ID, "ShowTTD", false);
end
function TitanPATTBToggle()
	TitanSetVar(TITAN_TITANPA_ID, "ShowTTA", false);
	TitanSetVar(TITAN_TITANPA_ID, "ShowTTB", true);
	TitanSetVar(TITAN_TITANPA_ID, "ShowTTC", false);
	TitanSetVar(TITAN_TITANPA_ID, "ShowTTD", false);

end
function TitanPATTCToggle()
	TitanSetVar(TITAN_TITANPA_ID, "ShowTTA", false);
	TitanSetVar(TITAN_TITANPA_ID, "ShowTTB", false);
	TitanSetVar(TITAN_TITANPA_ID, "ShowTTC", true);
	TitanSetVar(TITAN_TITANPA_ID, "ShowTTD", false);
end
function TitanPATTDToggle()
	TitanSetVar(TITAN_TITANPA_ID, "ShowTTA", false);
	TitanSetVar(TITAN_TITANPA_ID, "ShowTTB", false);
	TitanSetVar(TITAN_TITANPA_ID, "ShowTTC", false);
	TitanSetVar(TITAN_TITANPA_ID, "ShowTTD", true);
end

--function to check the Mouse-Over status
--[[
this is used to set the text in the menu
function TitanPACheckMO()
	local tttext;
	if(TitanGetVar(TITAN_TITANPA_ID, "ShowTTA")) then
		tttext = TITANPA_EXCLUSIONS;
	else
		tttext = TITANPA_STATUS;
	end
	if(TitanGetVar(TITAN_TITANPA_ID, "ShowTTB")) then
		ttttext = TITANPA_BLESSINGS;
	end
	return tttext;
end
--]]

-- format time from seconds to minutes and hours
local function TitanPAformat_time(seconds)

	if seconds<60 then
		return math.floor(seconds+.5).." s";
	else
		if seconds < 3600 then
			return math.ceil((seconds/60)).." m";
		else
			return math.ceil((seconds/3600)).." h";
		end
	end
end

--Series of Functions to open the various PA dialogs

function PAFrameTogglePMM()
	PA:FrameToggle(PanzaPMMFrame);
end

function PAFrameTogglePOM()
	PA:FrameToggle(PanzaPOMFrame);
end

function PAFrameTogglePAM()
	PA:FrameToggle(PanzaPAMFrame);
end

function PAFrameToggleRGS()
	PA:FrameToggle(PanzaRGSFrame);
end

function PAFrameTogglePBM()
	PA:FrameToggle(PanzaPBMFrame);
end

function PAFrameTogglePHM()
	PA:FrameToggle(PanzaPHMFrame);
end

function PAFrameTogglePAW()
	PA:FrameToggle(PanzaPAWFrame);
end

function PAFrameTogglePFM()
	PA:FrameToggle(PanzaPFMFrame);
end

function PAFrameTogglePCS()
	PA:FrameToggle(PanzaPCSFrame);
end

function PAFrameToggleDCB()
	PA:FrameToggle(PanzaDCBFrame);
end

function PAFrameTogglePPM()
	PA:FrameToggle(PanzaPPMFrame);
end

function PAFrameTogglePCM()
	PA:FrameToggle(PanzaPCMFrame);
end

function PACLearAll()
	PA:BlessList("clearall");
end

-- Series of functions to change the PAW Options

function TitanPATogglePAWEnable()
	if (PASettings.Switches.Whisper.enabled) then
		PASettings.Switches.Whisper.enabled = false;
	else
		PASettings.Switches.Whisper.enabled = true;
	end
	PA:PAW_SetValues()
end

function TitanPATogglePAWFeedback()
	if (PASettings.Switches.Whisper.feedback) then
		PASettings.Switches.Whisper.feedback = false;
	else
		PASettings.Switches.Whisper.feedback = true;
	end
	PA:PAW_SetValues()
end


-- Series of Functions to toggle Greater Blessings

function TitanPAToggleGBSELF()
	if (PASettings.Switches.GreaterBlessings.SOLO) then
		PASettings.Switches.GreaterBlessings.SOLO = false;
	else
		PASettings.Switches.GreaterBlessings.SOLO = true;
	end
	PA:PBM_SetValues()
end

function TitanPAToggleGBPARTY()
	if (PASettings.Switches.GreaterBlessings.PARTY) then
		PASettings.Switches.GreaterBlessings.PARTY = false;
	else
		PASettings.Switches.GreaterBlessings.PARTY = true;
	end
	PA:PBM_SetValues()
end

function TitanPAToggleGBRAID()
	if (PASettings.Switches.GreaterBlessings.RAID) then
		PASettings.Switches.GreaterBlessings.RAID = false;
	else
		PASettings.Switches.GreaterBlessings.RAID = true;
	end
	PA:PBM_SetValues()
end

function TitanPAToggleGBBG()
	if (PASettings.Switches.GreaterBlessings.BG) then
		PASettings.Switches.GreaterBlessings.BG = false;
	else
		PASettings.Switches.GreaterBlessings.BG = true;
	end
	PA:PBM_SetValues()
end

function TitanPASetTT_Status()
	local line3 = "";
	local line4 = "";
	local line5 = "";
	local line6 = "";
	local line7 = "";
	local line8 = "";
	local line9 = "";
	local line10 = "";
	local line11 = "";
	local line12 = "";
	local line13 = "";
	local line14 = "";
	local line15 = "";
	local line16 = "";
	local line17 = "";
	local line18 = "";
	local line19 = "";

	if (PASettings.Switches.EnableWarn == true) then
		line3 = PANZA_WARNINGS;
	else
		line3 = PANZA_NOWARNINGS;
	end

	if (PASettings.Switches.EnableSelf == true) then
		line4 = PANZA_SELFBLESSING_ENABLED;
	else
		line4 = PANZA_SELFBLESSING_DISABLED;
	end

	if (PASettings.Switches.EnableSave == true) then
		line5 = PANZA_SAVEBLESSING_ENABLED;
	else
		line5 = PANZA_SAVEBLESSING_DISABLED;
	end

	line6 = format(PANZA_PET_THRESHOLD,(PASettings.Heal.PetTH * 100).."%");

	line7 = format(PANZA_MINHEALTH_THRESHOLD,(PASettings.Heal.MinTH * 100).."%");

	line8 = format(PANZA_FOL_HEALTH_THRESHOLD,(PASettings.Heal.Flash * 100).."%");

	line9 = format(PANZA_LOW_FOL_THRESHOLD,(PASettings.Heal.LowFlash * 100).."%");

	line10 = format(PANZA_FOL_MANA_THRESHOLD,(PASettings.Heal.FolTH * 100).."%");



	if (PASettings.Switches.AutoList == true) then
		line11 = PANZA_AUTOLIST_ENABLED;
	else
		line11 = PANZA_AUTOLIST_DISABLED;
	end

	--line12 = format(PANZA_SAVELIST,getn(PASettings.BlessIndex));

	line12 = "\n";
	
	line13 = PA:MapLibrary("STATUS");

	___,line14 = PA:HealingBonus("STATUS");

	if (PASettings.Switches.UseActionRange.Heal==true
	 or PASettings.Switches.UseActionRange.Bless==true
	 or PASettings.Switches.UseActionRange.Cure==true
	 or PASettings.Switches.UseActionRange.Free==true) then
		if (PA:ActionInRange(20)~=nil) then
			line15 = format(SPELL_RANGE, "20").." ("..ACTIONBAR_LABEL..") "..OKAY;
		else
			line15 = format(SPELL_RANGE, "20").." ("..ACTIONBAR_LABEL..") "..ADDON_MISSING;
		end
		if (PA:ActionInRange(30)~=nil) then
			line16 = format(SPELL_RANGE, "30").." ("..ACTIONBAR_LABEL..") "..OKAY;
		else
			line16 = format(SPELL_RANGE, "30").." ("..ACTIONBAR_LABEL..") "..ADDON_MISSING;
		end
		if (PA:ActionInRange(40)~=nil) then
			line17 = format(SPELL_RANGE, "40").." ("..ACTIONBAR_LABEL..") "..OKAY;
		else
			line17 = format(SPELL_RANGE, "40").." ("..ACTIONBAR_LABEL..") "..ADDON_MISSING;
		end
	else
		line15 = format(SPELL_RANGE, "20").." ("..ACTIONBAR_LABEL..") "..ADDON_DISABLED;
		line16 = format(SPELL_RANGE, "30").." ("..ACTIONBAR_LABEL..") "..ADDON_DISABLED;
		line17 = format(SPELL_RANGE, "40").." ("..ACTIONBAR_LABEL..") "..ADDON_DISABLED;
	end

	PA:UpdateComponents();
	if (PA.PlayerClass=="PALADIN") then
			-- Show the Symbol Counters
		line18 = format(PANZA_KINGSCOUNT, PA:Components("kings"), PANZA_KINGSCOUNT_ITEMNAME);
		if (PA:SpellInSpellBook("di")) then
			line19 = format(PANZA_DIVINITYCOUNT, PA:Components("divinity"), PANZA_DIVINITYCOUNT_ITEMNAME, PA.SpellBook.di.Name);
		end
	elseif (PA.PlayerClass=="PRIEST") then
		line18 = format(PANZA_FEATHERCOUNT, PA:Components("feathers"), PANZA_FEATHERCOUNT_ITEMNAME);
		line19 = format(PANZA_CANDLECOUNT, PA:Components("holycandles"), PANZA_HOLYCANCOUNT_SHORTNAME, PA:Components("sacredcandles"), PANZA_SACREDCANCOUNT_SHORTNAME);
	elseif (PA.PlayerClass=="MAGE") then
		line18 = format(PANZA_MAGE_FEATHERCOUNT, PA:Components("feathers"), PANZA_FEATHERCOUNT_ITEMNAME);
	end

	return 	TITANPA_STATUS.."\n\n"..
		line3 .. "\n"..
		line4 .. "\n"..
		line5 .. "\n"..
		line6 .. "\n"..
		line7 .. "\n"..
		line8 .. "\n"..
		line9 .. "\n"..
		line10 .. "\n"..
		line11 .. "\n"..
		line12 .. "\n"..
		line13 .. "\n"..
		line14 .. "\n"..
		line15 .. "\n"..
		line16 .. "\n"..
		line17 .. "\n"..
		line18 .. "\n"..
		line19;
end

-------------------------------------
-- Display Exclusions in Main Tooltip
-------------------------------------
function TitanPASetTT_Ex()
	return	TITANPA_EXCLUSIONS.."\n"..
		"This option will display\n"..
		"the exclusion list once this\n"..
		"feature has been implemented";
end

-----------------------------------
-- Display Failures in Main Tooltip
-- What is stored :
-- PA.Cycles.Group.Fail[UName] = {unit=PA.Cycles.Spell.Active.target, count=1, Time = GetTime(), LastSpell = PA.Cycles.Spell.Active.spell, LastReason = WhyFailed};
-----------------------------------
function TitanPASetTT_Fails()
	local retvalue, Name, Set = "", nil, nil;
	local empty = true;
	local toggle = true;
	retvalue = retvalue..PA_GREN.."Panza had failed spell attempts against "..PA_RED.." "..PA:TableSize(PA.Cycles.Group.Fail).." "..PA_GREN.." players.\n";
	retvalue = retvalue..PA_GREN.."Name "..PA_WHITE.." - "..PA_YEL.."Count "..PA_BLUE.."Spell "..PA_WHITE.."Failed ago "..PA_YEL.."Reason \n\n";
	for Name, Value in PA.Cycles.Group.Fail do
		if (Value.unit~=nil and UnitClass(Value.unit)~=nil) then
			retvalue = retvalue..TITAN_TITANPA_ClassColor[string.upper(UnitClass(Value.unit))]..""..Name.." "..PA_WHITE.." - "..PA_YEL..""..Value.count.." "..PA_BLUE..""..Value.LastSpell.." "..PA_WHITE..""..format("%s",TitanPAformat_time(GetTime() - Value.Time)).." "..PA_YEL..""..Value.LastReason;
		elseif (Value.unit~=nil) then -- cyclenear may store "target" as unit which will not return a class here.
			retvalue = retvalue..PA_GREN..""..Name.." "..PA_WHITE.." - "..PA_YEL..""..Value.count.." "..PA_BLUE..""..Value.LastSpell.." "..PA_WHITE..""..format("%s",TitanPAformat_time(GetTime() - Value.Time)).." "..PA_YEL..""..Value.LastReason;
		end
		if (toggle and PA:TableSize(PA.Cycles.Group.Fail) > 26) then
			retvalue = retvalue .. "\t";
			toggle = false;
		else
			retvalue = retvalue .. "\n";
			toggle = true;
		end
		empty = false;
	end
	if (empty == true) then
		retvalue = retvalue..PA_GREN.."No Failures";
	end
	return retvalue;
end

----------------------------------------------------
-- Display blessings cast on players in main tooltip
----------------------------------------------------
function TitanPASetTT_Bless()
	local retvalue, Name, Set = "", nil, nil;
	local empty = true;
	local toggle = true;
	retvalue = retvalue..PA_GREN.."Panza buffed"..PA_WHITE.." "..PA:CountBuffedPlayers().." "..PA_GREN.."Players.\n";
	retvalue = retvalue..PA_GREN.."Name "..PA_WHITE.." - "..PA_BLUE.."Spell ("..PA_GREN.."Shortname"..PA_BLUE.."), "..PA_WHITE.."Remaining Duration.\n\n";
	for Name, Set in PACurrentSpells.Indi do
		for Id, value in Set do
			if (value.Reset~=true) then
				local ShortSpell = PA.Spells.Lookup[value.Spell];
				local Duration = PA.SpellBook[ShortSpell].Duration - GetTime() + value.Time;
				if (Duration ~= nil and Duration <= PA.SpellBook[ShortSpell].Duration) then
					if (Duration~=nil and Duration > (0 - PASettings.Switches.NearRestart)) then
						if (Duration > 60 and value.Class~=nil and TITAN_TITANPA_ClassColor[string.upper(value.Class)]~=nil) then
							retvalue = retvalue..TITAN_TITANPA_ClassColor[string.upper(value.Class)]..""..Name..""..PA_WHITE.." - "..PA_BLUE..""..value.Spell.." ("..PA_GREN..""..ShortSpell..""..PA_BLUE.."), "..PA_GREN..""..format("%s",TitanPAformat_time(Duration));
						elseif (Duration > 30 and Duration < 60 and value.Class~=nil and TITAN_TITANPA_ClassColor[string.upper(value.Class)]~=nil) then
							retvalue = retvalue..TITAN_TITANPA_ClassColor[string.upper(value.Class)]..""..Name..""..PA_WHITE.." - "..PA_YEL.."Expiring "..PA_BLUE..""..value.Spell.." ("..PA_GREN..""..ShortSpell..""..PA_BLUE.."), "..PA_YEL..""..format("%s",TitanPAformat_time(Duration));
						elseif (Duration > 0 and Duration < 30 and value.Class~=nil and TITAN_TITANPA_ClassColor[string.upper(value.Class)]~=nil) then
							retvalue = retvalue..TITAN_TITANPA_ClassColor[string.upper(value.Class)]..""..Name..""..PA_WHITE.." - "..PA_RED.."Fading "..PA_BLUE..""..value.Spell.." ("..PA_GREN..""..ShortSpell..""..PA_BLUE.."), "..PA_RED..""..format("%s",TitanPAformat_time(Duration));
						elseif (value.Class~=nil and TITAN_TITANPA_ClassColor[string.upper(value.Class)]~=nil) then
							retvalue = retvalue..TITAN_TITANPA_ClassColor[string.upper(value.Class)]..""..Name..""..PA_WHITE.." - "..PA_BGREY.."Expired "..PA_BLUE..""..value.Spell.." ("..PA_GREN..""..ShortSpell..""..PA_BLUE.."), "..PA_BGREY..""..format("%s",TitanPAformat_time(Duration));
						end
						if (toggle and PA:CountBuffedPlayers() > 26) then
							retvalue = retvalue .. "\t";
							toggle = false;
						else
							retvalue = retvalue .. "\n";
							toggle = true;
						end
					end
					empty = false;
				end
			end
		end
	end
	if (empty) then
		retvalue = retvalue..PA_GREN.."List Empty";
	end
	return retvalue;
end

-----------------------------------------
-- Format symbol display on the Titan Bar
-----------------------------------------
function TitanPAFormatSymbols()
	local retvalue = "";

	PA:UpdateComponents();
	if (PA.PlayerClass=="PALADIN") then

		local tKingsCount = PA:Components("kings");
		local tDivinityCount = PA:Components("divinity");
		--Show Kings?
		if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolK")) then

			--Show Kings Label?
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolKText")) then

				-- Show the label as an initial like [K]
				if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolsAsInitials")) then
					retvalue = retvalue.."["..string.sub(PANZA_KINGSCOUNT_SHORTNAME, 1, 1).."] ";
					--retvalue = retvalue .. "[K]";
				else
					retvalue = retvalue .. PANZA_KINGSCOUNT_SHORTNAME ..": ";
				end
			else
				retvalue = retvalue .."";
			end

			--Color the Kings Text?
			-- 0-25 is RED, more than 75 is GREEN, everything else is WHITE
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolColorText")) then
				local kcolor
				if (tKingsCount <= 25) then
					kcolor = PA_RED..tKingsCount..FONT_COLOR_CODE_CLOSE;
				elseif (tKingsCount >= 75) then
					kcolor = PA_GREN..tKingsCount..FONT_COLOR_CODE_CLOSE;
				else
					kcolor = PA_WHITE..tKingsCount..FONT_COLOR_CODE_CLOSE;
				end
				retvalue = retvalue .. kcolor;
			else
				retvalue = retvalue .. tKingsCount;
			end
			retvalue = retvalue;
		end

		-- Show Divinity?
		if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolD")) then

			-- If we're showing anything from Kings, we need a seperator
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolK")) then
				retvalue = retvalue .. " \| ";
			end
			-- Show Divnity Label?
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolDText")) then
			-- Show the label as an initial like [D]
				if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolsAsInitials")) then
					retvalue = retvalue.."["..string.sub(PANZA_DIVINITYCOUNT_SHORTNAME, 1, 1).."] ";
					--retvalue = retvalue .. "[D]";
				else
					retvalue = retvalue .. PANZA_DIVINITYCOUNT_SHORTNAME .. ": ";
				end
			end
			-- Color the Divinity Text?
			-- 0,1 are RED, 2,3,4 are WHITE, 5 or more is GREEN
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolColorText")) then
				local dcolor
				if (tDivinityCount <= 1) then
					dcolor = PA_RED..tDivinityCount..FONT_COLOR_CODE_CLOSE;
				elseif (tDivinityCount >= 5) then
					dcolor = PA_GREN..tDivinityCount..FONT_COLOR_CODE_CLOSE;
				else
					dcolor = PA_WHITE..tDivinityCount..FONT_COLOR_CODE_CLOSE;
				end
				retvalue = retvalue .. dcolor;
			else
				retvalue = retvalue .. tDivinityCount;
			end
		retvalue = retvalue;
		end

	elseif (PA.PlayerClass=="MAGE") then

		local FeatherCount = PA:Components("feathers");

		--Show Feathers?
		if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolLF")) then
			--Show Feathers Label?
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolLFText")) then
				-- Show the label as an initial like [L]
				if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolsAsInitials")) then
					retvalue = retvalue.."["..string.sub(PANZA_FEATHERCOUNT_SHORTNAME, 1, 1).."] ";
				else
					retvalue = retvalue .. PANZA_FEATHERCOUNT_SHORTNAME ..": ";
				end
			else
				retvalue = retvalue .."";
			end

			--Color the Feathers Text?
			-- 0-25 is RED, more than 75 is GREEN, everything else is WHITE
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolColorText")) then
				local feathercolor
				if (FeatherCount <= 5) then
					feathercolor = PA_RED..FeatherCount..FONT_COLOR_CODE_CLOSE;
				elseif (FeatherCount >= 15) then
					feathercolor = PA_GREN..FeatherCount..FONT_COLOR_CODE_CLOSE;
				else
					feathercolor = PA_WHITE..FeatherCount..FONT_COLOR_CODE_CLOSE;
				end
					retvalue = retvalue .. feathercolor;
			else
				retvalue = retvalue .. FeatherCount;
			end
			retvalue = retvalue;
		end
		
	elseif (PA.PlayerClass=="PRIEST") then

		local FeatherCount = PA:Components("feathers");
		local HolyCanCount = PA:Components("holycandles");
		local SacredCanCount = PA:Components("sacredcandles");

		--Show Feathers?
		if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolLF")) then

			--Show Feathers Label?
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolLFText")) then

				-- Show the label as an initial like [L]
				if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolsAsInitials")) then
					retvalue = retvalue.."["..string.sub(PANZA_FEATHERCOUNT_SHORTNAME, 1, 1).."] ";
					--retvalue = retvalue .. "[K]";
					else
						retvalue = retvalue .. PANZA_FEATHERCOUNT_SHORTNAME ..": ";
					end
				else
					retvalue = retvalue .."";
				end

				--Color the Feathers Text?
				-- 0-25 is RED, more than 75 is GREEN, everything else is WHITE
				if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolColorText")) then
					local feathercolor
					if (FeatherCount <= 5) then
						feathercolor = PA_RED..FeatherCount..FONT_COLOR_CODE_CLOSE;
					elseif (FeatherCount >= 15) then
						feathercolor = PA_GREN..FeatherCount..FONT_COLOR_CODE_CLOSE;
					else
						feathercolor = PA_WHITE..FeatherCount..FONT_COLOR_CODE_CLOSE;
					end
					retvalue = retvalue .. feathercolor;
				else
					retvalue = retvalue .. FeatherCount;
				end
				retvalue = retvalue;
			end

		-- Show Holy Candles?
		if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolHC")) then

			-- If we're showing anything from Feathers, we need a seperator
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolLF")) then
				retvalue = retvalue .. " \| ";
			end
			-- Show Holy Candle Label?
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolLFText")) then
			-- Show the label as an initial like [H]
				if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolsAsInitials")) then
					retvalue = retvalue.."["..string.sub(PANZA_HOLYCANCOUNT_SHORTNAME, 1, 1).."] ";
					--retvalue = retvalue .. "[H]";
				else
					retvalue = retvalue .. PANZA_HOLYCANCOUNT_SHORTNAME .. ": ";
				end
			end
			-- Color Holy Candle Text?
			-- 0,1 are RED, 2,3,4 are WHITE, 5 or more is GREEN
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolColorText")) then
				local hcancolor
				if (HolyCanCount <= 8) then
					hcancolor = PA_RED..HolyCanCount..FONT_COLOR_CODE_CLOSE;
				elseif (HolyCanCount >= 20) then
					hcancolor = PA_GREN..HolyCanCount..FONT_COLOR_CODE_CLOSE;
				else
					hcancolor = PA_WHITE..HolyCanCount..FONT_COLOR_CODE_CLOSE;
				end
					retvalue = retvalue .. hcancolor ..FONT_COLOR_CODE_CLOSE;
			else
				retvalue = retvalue .. HolyCanCount ..FONT_COLOR_CODE_CLOSE;
			end
		retvalue = retvalue;
		end

		-- Show Sacred Candles?
		if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolSC")) then

			-- If we're showing anything from Feathers or Holy Candles, we need a seperator
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolLF") or TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolHC")) then
					retvalue = retvalue .. " \| ";
			end

			-- Show Sacred Candle Label?
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolSCText")) then
				-- Show the label as an initial like [S]
				if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolsAsInitials")) then
					retvalue = retvalue.."["..string.sub(PANZA_SACREDCANCOUNT_SHORTNAME, 1, 1).."] ";
				else
					retvalue = retvalue .. PANZA_SACREDCANCOUNT_SHORTNAME .. ": ";
				end
			end

			-- Color Sacred Candle Text?
			-- 0,1 are RED, 2,3,4 are WHITE, 5 or more is GREEN
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbolColorText")) then
				local scancolor
				if (SacredCanCount <= 8) then
					scancolor = PA_RED..SacredCanCount..FONT_COLOR_CODE_CLOSE;
				elseif (HolyCanCount >= 20) then
					scancolor = PA_GREN..SacredCanCount..FONT_COLOR_CODE_CLOSE;
				else
					scancolor = PA_WHITE..SacredCanCount..FONT_COLOR_CODE_CLOSE;
				end
				retvalue = retvalue .. scancolor ..FONT_COLOR_CODE_CLOSE;
			else
				retvalue = retvalue .. SacredCanCount ..FONT_COLOR_CODE_CLOSE;
			end
			retvalue = retvalue;
		end
	end
	return retvalue;
end

-------------------------------------
-- Format Failures display on the bar
-------------------------------------
function TitanPAFormatFailures()
	local retvalue, pc, failures = "", 0, 0;

	-- If we're showing anything from Symbols, we need a seperator
	if (TitanGetVar(TITAN_TITANPA_ID, "ShowSymbols")) then
			retvalue = retvalue .. " \|F ";
	else
			retvalue = retvalue .. "F ";
	end

	failures = PA:TableSize(PA.Cycles.Group.Fail);

	if (failures > 1) then
		if (TitanGetVar(TITAN_TITANPA_ID, "ShowFailuresCount")) then
			pc = PA:Percent(failures, PA.Cycles.Group.Count);
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowFailuresColorText")) then
				if (PA.Cycles.Group.Count > 1) then
					if (failures/PA.Cycles.Group.Count >= 5) then
						retvalue = retvalue..PA_RED..failures.. "/" .. PA.Cycles.Group.Count..FONT_COLOR_CODE_CLOSE;
					elseif (failures/PA.Cycles.Group.Count == 1) then
						retvalue = retvalue..PA_GREN..failures.. "/" .. PA.Cycles.Group.Count..FONT_COLOR_CODE_CLOSE;
					else
						retvalue = retvalue..PA_WHITE..failures.. "/" .. PA.Cycles.Group.Count..FONT_COLOR_CODE_CLOSE;
					end
				else
					retvalue = retvalue..PA_WHITE..failures..FONT_COLOR_CODE_CLOSE;
				end
			elseif (PA.Cycles.Group.Count > 1) then
				retvalue = failures.. "/" .. PA.Cycles.Group.Count;
			else
				retvalue = retvalue..PA_WHITE..failures..FONT_COLOR_CODE_CLOSE;
			end
		end

		if (TitanGetVar(TITAN_TITANPA_ID, "ShowFailuresCountPercent")) then
			if (PA.Cycles.Group.Count > 1) then
				if (TitanGetVar(TITAN_TITANPA_ID, "ShowFailuresCount")) then
					retvalue = retvalue.."("..format("%.0f",((failures/PA.Cycles.Group.Count) * 100)).."%)";
				else
					retvalue = retvalue..format("%.0f",((failures/PA.Cycles.Group.Count) * 100)).."%";
				end
			end
		end

	else
		if (TitanGetVar(TITAN_TITANPA_ID, "ShowFailuresCount")) then
			local FailedCount = PA:TableSize(PA.Cycles.Group.Fail);
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowFailuresColorText")) then
				retvalue = retvalue .. PA_WHITE .. FailedCount .. FONT_COLOR_CODE_CLOSE;
			else
				retvalue = retvalue .. FailedCount .. FONT_COLOR_CODE_CLOSE;
			end
		end
	retvalue = retvalue;
	end

return retvalue;
end

-----------------------------------
-- Format Blessing Counters Display
-----------------------------------
function TitanPAFormatBlessings()
	local retvalue = "";
	TITANPA_BLESSTIME2 = PA.Cycles.Group.NextBless;

	if (TitanGetVar(TITAN_TITANPA_ID, "ShowFailures")) then
		retvalue = retvalue .. " \|B ";
	elseif (TitanGetVar(TITAN_TITANPA_ID,"ShowSymbols")) then
		retvalue = retvalue .. " \|B ";
	end

	if (PA.Cycles.Group.Count>1) then
		local buffedplayers=PA:CountBuffedPlayers();
		if (TitanGetVar(TITAN_TITANPA_ID, "ShowBlessingsCount")) then
			local pc = 0;
			pc = PA:Percent(PA.CountBuffedPlayers(), PA.Cycles.Group.Count);
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowBlessingsColorText")) then
				local cColor;
				if (buffedplayers/PA.Cycles.Group.Count <= .5) then
					retvalue = retvalue..PA_RED..buffedplayers.. "/" .. PA.Cycles.Group.Count..FONT_COLOR_CODE_CLOSE;
				elseif (buffedplayers/PA.Cycles.Group.Count == 1) then
					retvalue = retvalue..PA_GREN..buffedplayers.. "/" .. PA.Cycles.Group.Count..FONT_COLOR_CODE_CLOSE;
				else
					retvalue = retvalue..PA_WHITE..buffedplayers.. "/" .. PA.Cycles.Group.Count..FONT_COLOR_CODE_CLOSE;
				end
			else
				retvalue = buffedplayers.. "/" .. PA.Cycles.Group.Count;
			end
		end

		if (TitanGetVar(TITAN_TITANPA_ID, "ShowBlessingsCountPercent")) then
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowBlessingsCount")) then
				retvalue = retvalue.."("..format("%.0f",((buffedplayers/PA.Cycles.Group.Count) * 100)).."%)";
			else
				retvalue = retvalue..format("%.0f",((buffedplayers/PA.Cycles.Group.Count) * 100)).."%";
			end
		end

	else
		if (TitanGetVar(TITAN_TITANPA_ID, "ShowBlessingsCount")) then
			local BlessingCount = PA:CountBuffedPlayers();
			if (TitanGetVar(TITAN_TITANPA_ID, "ShowBlessingsColorText")) then
				retvalue = retvalue .. PA_WHITE..BlessingCount..FONT_COLOR_CODE_CLOSE;
			else
				retvalue = retvalue .. BlessingCount;
			end
		end
		retvalue = retvalue;
	end

	if (TitanGetVar(TITAN_TITANPA_ID, "ShowBlessingsTime")) then
		if (TitanGetVar(TITAN_TITANPA_ID, "ShowBlessingsCount") or (TitanGetVar(TITAN_TITANPA_ID, "ShowBlessingsCountPercent") and PA:CountBuffedPlayers() > 1) ) then
			retvalue = retvalue .. " \| ";
		end
		TITANPA_BLESSTIME1 = TITANPA_BLESSTIME1 - 1
		if (TitanGetVar(TITAN_TITANPA_ID, "ShowBlessingsColorText")) then
			local tColor;
			if (TITANPA_BLESSTIME1 < 0) then
				tColor = PA_BLUE.."N/A"..FONT_COLOR_CODE_CLOSE;
			elseif (TITANPA_BLESSTIME1 < 30) then
				tColor = TitanUtils_GetRedText(format("%s",TitanPAformat_time(TITANPA_BLESSTIME1)));
			elseif (TITANPA_BLESSTIME1 > 180) then
				tColor = TitanUtils_GetGreenText(format("%s",TitanPAformat_time(TITANPA_BLESSTIME1)));
			else
				tColor = TitanUtils_GetHighlightText(format("%s",TitanPAformat_time(TITANPA_BLESSTIME1)));
			end
			retvalue = retvalue .. tColor..FONT_COLOR_CODE_CLOSE;
		else
			if (TITANPA_BLESSTIME1 < 0) then
				retvalue = retvalue .. "N/As";
			else
				retvalue = retvalue .. format("%s",TitanPAformat_time(TITANPA_BLESSTIME1));
			end
		end
		TITANPA_BLESSCOUNT = TITANPA_BLESSCOUNT + 1
	end

	if (TITANPA_BLESSTIME1 + TITANPA_BLESSCOUNT + 2 < TITANPA_BLESSTIME2) then
		TITANPA_BLESSTIME1 = TITANPA_BLESSTIME2;
		TITANPA_BLESSCOUNT = 0;
	elseif (TITANPA_BLESSTIME1 + TITANPA_BLESSCOUNT - 2 > TITANPA_BLESSTIME2) then
		TITANPA_BLESSTIME1 = TITANPA_BLESSTIME2;
		TITANPA_BLESSCOUNT = 0;
	end
	return retvalue;
end

