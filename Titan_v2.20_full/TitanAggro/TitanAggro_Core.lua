function TitanAggro_OnUpdate(elapsed)
	if (not AggroVars.TitanPanel and TITAN_AGGRO_FREQUENCY) then
		local timeLeft = AggroVars.Timer - elapsed;
		if (timeLeft <= 0) then
			AggroVars.Timer = TITAN_AGGRO_FREQUENCY;
			TitanAggro_UpdateStatus();
		else
			AggroVars.Timer = timeLeft;
		end
	end
end

function TitanAggroGetVar(VAR)
	if (AggroVars.TitanPanel) then
		return TitanGetVar(TITAN_AGGRO_ID, VAR);
	else
		if (TitanAggroSettings) then
			return TitanAggroSettings[VAR];
		else
			return nil;
		end
	end
end

function TitanAggroSetVar(VAR, VAL)
	if (not TitanAggroSettings) then
		TitanAggroSettings = {};
	end
	AggroVars.SessionSettings[VAR] = VAL;
	TitanAggroSettings[VAR] = VAL;
	if (AggroVars.TitanPanel) then
		TitanSetVar(TITAN_AGGRO_ID, VAR, VAL);
	end
end

function TitanAggroToggleVar()
	if (not TitanAggroGetVar(this.value) or TitanAggroGetVar(this.value) ~= 1) then
		TitanAggroSetVar(this.value, 1);
	else
		TitanAggroSetVar(this.value, 0);
	end
	TitanAggro_RightClickMenu_Close();
end


function TitanAggro_LoadConfig()
	if (not TitanAggroGetVar("DoReports")) then TitanAggroSetVar("DoReports", 0); end
	if (not TitanAggroGetVar("ReportChans")) then local tmp = {}; TitanAggroSetVar("ReportChans", tmp); end
	if (not AggroVars.ReportTypes[TitanAggroGetVar("ReportType")]) then TitanAggroSetVar("ReportType", 1); end
	if (not AggroVars.ReportTypes[TitanAggroGetVar("ReportTypeCustom")]) then TitanAggroSetVar("ReportTypeCustom", 0); end
	if (TitanAggroGetVar("ReportTypeCustom") == 1) then TitanAggroSetVar("ReportType", 0); end
	if (not TitanAggroGetVar("ReportTypeCustomClasses")) then local tmp = {}; TitanAggroSetVar("ReportTypeCustomClasses", tmp); end
	if (not AggroVars.ReportTimes[TitanAggroGetVar("ReportTime")]) then TitanAggroSetVar("ReportTime", 0); end
	if (not AggroVars.ReportFormats[TitanAggroGetVar("ReportFormat")]) then TitanAggroSetVar("ReportFormat", 0); end
	if (not TitanAggroGetVar("TankMode")) then TitanAggroSetVar("TankMode", 0); end
	if (not AggroVars.SoundOptions[TitanAggroGetVar("Sounds")]) then TitanAggroSetVar("Sounds", 0); end
	if (not TitanAggroGetVar("ShowTT_HP")) then TitanAggroSetVar("ShowTT_HP", 0); end
	if (not TitanAggroGetVar("RelocateTT_HP")) then TitanAggroSetVar("RelocateTT_HP", 0); end
	if (not TitanAggroGetVar("MoveableTT_HP")) then TitanAggroSetVar("MoveableTT_HP", 0); end
	if (not TitanAggroGetVar("HideFlashTT_HP")) then TitanAggroSetVar("HideFlashTT_HP", 0); end
	if (not TitanAggroGetVar("AggroDetect") or not AggroVars.AggroDetectGroups[TitanAggroGetVar("AggroDetect")]) then TitanAggroSetVar("AggroDetect", 0); end
	if (not TitanAggroGetVar("AggroDetectPets")) then TitanAggroSetVar("AggroDetectPets", 0); end
	TitanAggroSetVar("ReportTimeSec", tonumber(AggroVars.ReportTimes[TitanAggroGetVar("ReportTime")] or 0));
	AggroVars.ConfigLoaded = 1;
	TitanAggro_OptionsMenu();
	DEFAULT_CHAT_FRAME:AddMessage(TITAN_AGGRO_MENU_TEXT..": Config Loaded");
end


function TitanAggro_OptionsMenu()
	UnitPopupButtons["TITANAGGRO_OPTIONS"] = { text = TEXT(TITAN_AGGRO_NAME), dist = 0 };
	original_UnitPopup_OnClick = UnitPopup_OnClick;
	UnitPopup_OnClick = TitanAggro_UnitPopup_OnClick;

	uiMenu = nil;

	for index, value in UnitPopupMenus["SELF"] do
		if (value == "ADDON_MENU") then
			uiMenu = index;
			break;
		end
	end
	if (not uiMenu) then
		UnitPopupButtons["ADDON_MENU"] = { text = TEXT(ADDON_MENU), dist = 0, nested = 1 };
		table.insert(UnitPopupMenus["SELF"], table.getn(UnitPopupMenus["SELF"]), "ADDON_MENU");

		for index, value in UnitPopupMenus["SELF"] do
			if (value == "ADDON_MENU") then
				uiMenu = index;
				break;
			end
		end
	end

	if (uiMenu) then
		if (not UnitPopupMenus["ADDON_MENU"]) then
			UnitPopupMenus["ADDON_MENU"] = { "CANCEL" };
		end
		table.insert(UnitPopupMenus["ADDON_MENU"], table.getn(UnitPopupMenus["ADDON_MENU"]), "TITANAGGRO_OPTIONS");
		return;
	end
end


function TitanAggro_UnitPopup_OnClick()
	if (this.value == "TITANAGGRO_OPTIONS") then
		DropDownList1:Hide();
		UIDropDownMenu_Initialize(TitanAggro_DropDown, TitanAggro_PrepareMenu, "MENU", 1);
		DropDownList1:Show();
	else
		original_UnitPopup_OnClick();
	end
end


function TitanAggro_GetConfig(septype)
	if (not septype) then
		sep = "\t";
	else
		sep = " - ";
	end

	local text = "";
	if (TitanAggroGetVar("DoReports") == 1) then
		text = text..TitanAggro_GetNormalText(AggroVars.DoReports_Text..sep..TitanAggro_GetHighlightText("ON"));
		if (septype) then DEFAULT_CHAT_FRAME:AddMessage(text); text = ""; else text = text.."\n"; end
		if (TitanAggroGetVar("ReportType") > 0) then
			text = text..TitanAggro_GetNormalText(AggroVars.ReportTypes_Text..sep..TitanAggro_GetHighlightText(AggroVars.ReportTypes[TitanAggroGetVar("ReportType")]));
			if (septype) then DEFAULT_CHAT_FRAME:AddMessage(text); text = ""; else text = text.."\n"; end
		end
		if (TitanAggroGetVar("ReportTypeCustom") > 0) then
			text = text..TitanAggro_GetNormalText(AggroVars.ReportTypes_Text..sep..TitanAggro_GetHighlightText(AggroVars.ReportTypesCustom_Text));
			if (septype) then DEFAULT_CHAT_FRAME:AddMessage(text); text = ""; else text = text.."\n"; end
		end
		local report_chans = TitanAggroGetVar("ReportChans");
		if (table.getn(report_chans)) then
			text = text..TitanAggro_GetNormalText(AggroVars.ReportChans_Text..sep);
			for i=0, 10 do
				if (report_chans[i]) then
					text = text..TitanAggro_GetHighlightText(AggroVars.ReportChans[i]);
					if (septype) then text = text..", "; else text = text.."\n "..sep; end
				end
			end
			if (septype) then DEFAULT_CHAT_FRAME:AddMessage(text); text = ""; end
		end
		if (TitanAggroGetVar("ReportTime")) then
			text = text..TitanAggro_GetNormalText(AggroVars.ReportTimes_Text..sep..TitanAggro_GetHighlightText(AggroVars.ReportTimes[TitanAggroGetVar("ReportTime")]));
			if (septype) then DEFAULT_CHAT_FRAME:AddMessage(text); text = ""; else text = text.."\n"; end
		end
	else
		text = text..TitanAggro_GetNormalText(AggroVars.DoReports_Text..sep..TitanAggro_GetHighlightText("OFF"));
		if (septype) then DEFAULT_CHAT_FRAME:AddMessage(text); text = ""; else text = text.."\n"; end
	end
	if (TitanAggroGetVar("Sounds")) then
		text = text..TitanAggro_GetNormalText(AggroVars.Sounds_Text..sep..TitanAggro_GetHighlightText(AggroVars.SoundOptions[TitanAggroGetVar("Sounds")]));
	end
	if (septype) then DEFAULT_CHAT_FRAME:AddMessage(text); text = ""; else text = text.."\n"; end

	if (TitanAggroGetVar("TankMode") > 0) then
		text = text..TitanAggro_GetNormalText(AggroVars.TankMode_Text..sep..TitanAggro_GetHighlightText("ON"));
	else
		text = text..TitanAggro_GetNormalText(AggroVars.TankMode_Text..sep..TitanAggro_GetHighlightText("OFF"));
	end
	if (septype) then DEFAULT_CHAT_FRAME:AddMessage(text); text = ""; else text = text.."\n"; end

	if (TitanAggroGetVar("ShowTT_HP") > 0) then
		text = text..TitanAggro_GetNormalText(AggroVars.ShowTTStatus_Text..sep..TitanAggro_GetHighlightText("ON"));
	else
		text = text..TitanAggro_GetNormalText(AggroVars.ShowTTStatus_Text..sep..TitanAggro_GetHighlightText("OFF"));
	end
	if (septype) then DEFAULT_CHAT_FRAME:AddMessage(text); text = ""; else text = text.."\n"; end

	if (TitanAggroGetVar("AggroDetect")) then
		text = text..TitanAggro_GetNormalText(AggroVars.AggroDetect_Text..sep..TitanAggro_GetHighlightText(AggroVars.AggroDetectGroups[TitanAggroGetVar("AggroDetect")]));
	end
	if (septype) then DEFAULT_CHAT_FRAME:AddMessage(text); text = ""; else text = text.."\n"; end

	if (not septype) then
		text = text.."\n"..TitanAggro_GetGreenText(AggroVars.ClickHint);
	end
	return text;
end

function TitanAggro_GetColoredText(text, color)
	if (text and color) then
		local redColorCode = format("%02x", color.r * 255);
		local greenColorCode = format("%02x", color.g * 255);
		local blueColorCode = format("%02x", color.b * 255);
		local colorCode = "|cff"..redColorCode..greenColorCode..blueColorCode;
		return colorCode..text..FONT_COLOR_CODE_CLOSE;
	end
end

function TitanAggro_GetRedText(text)
	if (text) then
		return RED_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
	end
end

function TitanAggro_GetBlueText(text)
	if (text) then
		return BLUE_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
	end
end

function TitanAggro_GetGreenText(text)
	if (text) then
		return GREEN_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
	end
end

function TitanAggro_GetNormalText(text)
	if (text) then
		return NORMAL_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
	end
end

function TitanAggro_GetHighlightText(text)
	if (text) then
		return HIGHLIGHT_FONT_COLOR_CODE..text..FONT_COLOR_CODE_CLOSE;
	end
end

function TitanAggro_RightClickMenu_Close()
	DropDownList1:Hide();
end
