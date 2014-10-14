function TitanAggroButton_GetButtonText(id)
	AggroVars.TitanPanel = 1;
	return TitanAggro_UpdateStatus();
end

function TitanAggroButton_GetTooltipText(septype)
	return TitanAggro_GetConfig();
end

function TitanAggro_FrameTT_HP_DragStart()
	TitanAggroSetVar("DragableTT_HP", 1);
	TitanAggroSetVar("MoveableTT_HP", 1);
	TitanAggroSetVar("RelocateTT_HP", 0);
	TitanAggro_ToTText:SetText("Drag me");
	TitanAggro_AggroStatusBG:SetStatusBarColor(1,0,0,1);
	TitanAggro_ToT:Show();
	TitanAggro_RightClickMenu_Close();
end

function TitanAggro_FrameTT_HP_DragStop()
	TitanAggroSetVar("DragableTT_HP", 0);
	TitanAggroSetVar("MoveableTT_HP", 1);
	TitanAggroSetVar("RelocateTT_HP", 0);
	TitanAggro_TitanAggro_AggroStatusBGReset();
	TitanAggro_ToT:Hide();
	TitanAggro_RightClickMenu_Close();
end

function TitanAggro_FrameTT_HP_Reset()
	TitanAggro_HPStatusBar:ClearAllPoints();
	TitanAggro_HPStatusBar:SetPoint("BOTTOM", "TargetFrame", "TOPLEFT", 62, 2);
	TitanAggro_ToT:ClearAllPoints();
	TitanAggro_ToT:SetPoint("TOP", "TitanAggro_HPStatusBar", "TOP", 1, -16);
	TitanAggroSetVar("DragableTT_HP", 0);
	TitanAggroSetVar("MoveableTT_HP", 0);
	TitanAggroSetVar("RelocateTT_HP", 1);
	TitanAggro_TitanAggro_AggroStatusBGReset();
	TitanAggro_ToT:Hide();
	TitanAggro_RightClickMenu_Close();
end

function TitanAggro_Set_ToggleRelocate()
	if (not TitanAggroGetVar("RelocateTT_HP") or TitanAggroGetVar("RelocateTT_HP") ~= 1) then
		TitanAggroSetVar("DragableTT_HP", 0);
		TitanAggroSetVar("MoveableTT_HP", 0);
		TitanAggroSetVar("RelocateTT_HP", 1);
	else
		TitanAggroSetVar("RelocateTT_HP", 0);
	end
end

function TitanAggro_Set_ReportChans()
	local report_chans = TitanAggroGetVar("ReportChans");
	if (report_chans[this.value]) then
		report_chans[this.value] = false;
	else
		report_chans[this.value] = true;
	end
	TitanAggroSetVar("ReportChans", report_chans);
	TitanAggro_RightClickMenu_Close();
end

function TitanAggro_Set_ReportType()
	TitanAggroSetVar("ReportType", this.value);
	TitanAggroSetVar("ReportTypeCustom", 0);
	TitanAggro_RightClickMenu_Close();
end

function TitanAggro_Set_ReportTypeCustomClasses()
	local report_custom_classes = TitanAggroGetVar("ReportTypeCustomClasses");
	if (report_custom_classes[this.value]) then
		report_custom_classes[this.value] = false;
	else
		report_custom_classes[this.value] = true;
	end
	TitanAggroSetVar("ReportTypeCustom", 1);
	TitanAggroSetVar("ReportType", 0);
	TitanAggroSetVar("ReportTypeCustomClasses", report_custom_classes);
--	TitanAggro_RightClickMenu_Close();
end

function TitanAggro_Set_ReportTypeCustom()
	TitanAggroSetVar("ReportTypeCustom", 1);
	TitanAggroSetVar("ReportType", 0);
	TitanAggro_RightClickMenu_Close();
end

function TitanAggro_Set_ReportTime()
	AggroVars.ReportTimesec = tonumber(AggroVars.ReportTimes[this.value] or 0);
	TitanAggroSetVar("ReportTime", this.value);
	TitanAggroSetVar("ReportTimeSec", AggroVars.ReportTimesec);
	TitanAggro_RightClickMenu_Close();
end

function TitanAggro_Set_ReportFormat()
	TitanAggroSetVar("ReportFormat", this.value);
	TitanAggro_RightClickMenu_Close();
end

function TitanAggro_Set_Sounds()
	TitanAggroSetVar("Sounds", this.value);
	TitanAggro_RightClickMenu_Close();
end

function TitanAggro_Set_AggroDetect()
	TitanAggroSetVar("AggroDetect", this.value);
	TitanAggro_RightClickMenu_Close();
end

function TitanAggro_PrepareMenu()
	UIDROPDOWNMENU_OPEN_MENU = "TitanAggro_DropDown";

	if ( UIDROPDOWNMENU_MENU_LEVEL == 3 ) then
		-- 3rd Level of ReportTypeCustom menu
		if ( UIDROPDOWNMENU_MENU_VALUE == "ReportTypeCustom" ) then
			for i=0, 10 do
				if (AggroVars.Classes[i]) then
					info = {};
					info.text = string.lower(AggroVars.Classes[i]);
					info.value = AggroVars.Classes[i];
					info.func = TitanAggro_Set_ReportTypeCustomClasses;
					local report_custom_classes = TitanAggroGetVar("ReportTypeCustomClasses");
					if (report_custom_classes[AggroVars.Classes[i]]) then info.checked = 1; end
					UIDropDownMenu_AddButton(info, 3);
				end
			end
		end
		return;
	end
	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
		-- 2nd Level of ReportChan menu
		if ( UIDROPDOWNMENU_MENU_VALUE == "ReportChans" ) then
			for i=0, 10 do
				if (AggroVars.ReportChans[i]) then
					info = {};
					info.text = AggroVars.ReportChans[i];
					info.value = i;
					info.func = TitanAggro_Set_ReportChans;
					local report_chans = TitanAggroGetVar("ReportChans");
					if (report_chans[i]) then info.checked = 1; end
					UIDropDownMenu_AddButton(info, 2);
				end
			end
		end
		-- 2nd Level of ReportType menu
		if ( UIDROPDOWNMENU_MENU_VALUE == "ReportType" ) then
			for i=0, 20 do
				if (AggroVars.ReportTypes[i]) then
					info = {};
					info.text = AggroVars.ReportTypes[i];
					info.value = i;
					info.func = TitanAggro_Set_ReportType;
					if (i == TitanAggroGetVar("ReportType")) then info.checked = 1; end
					UIDropDownMenu_AddButton(info, 2);
				end
			end
			info = {};
			info.text = AggroVars.ReportTypesCustom_Text;
			info.value = "ReportTypeCustom";
			info.func = TitanAggro_Set_ReportTypeCustom;
			info.hasArrow = 1;
			if (TitanAggroGetVar("ReportTypeCustom") == 1) then info.checked = 1; end
			UIDropDownMenu_AddButton(info, 2);
		end
		-- 2nd Level of ReportTimes menu
		if ( UIDROPDOWNMENU_MENU_VALUE == "ReportTime" ) then
			for i=0, 10 do
				if (AggroVars.ReportTimes[i]) then
					info = {};
					info.text = AggroVars.ReportTimes[i];
					info.value = i;
					info.func = TitanAggro_Set_ReportTime;
					if (i == TitanAggroGetVar("ReportTime")) then info.checked = 1; end
					UIDropDownMenu_AddButton(info, 2);
				end
			end
		end
		-- 2nd Level of ReportFormat menu
		if ( UIDROPDOWNMENU_MENU_VALUE == "ReportFormat" ) then
			for i=0, 10 do
				if (AggroVars.ReportFormats[i]) then
					info = {};
					info.text = format(AggroVars.ReportFormats[i], "'mob'", "'player'");
					info.value = i;
					info.func = TitanAggro_Set_ReportFormat;
					if (i == TitanAggroGetVar("ReportFormat")) then info.checked = 1; end
					UIDropDownMenu_AddButton(info, 2);
				end
			end
		end

		-- 2nd Level of Sounds menu
		if ( UIDROPDOWNMENU_MENU_VALUE == "Sounds" ) then
			for i=0, 10 do
				if (AggroVars.SoundOptions[i]) then
					info = {};
					info.text = AggroVars.SoundOptions[i];
					info.value = i;
					info.func = TitanAggro_Set_Sounds;
					if (i == TitanAggroGetVar("Sounds")) then info.checked = 1; end
					UIDropDownMenu_AddButton(info, 2);
				end
			end
		end

		-- 2nd Level of AggroDetectGroups menu
		if ( UIDROPDOWNMENU_MENU_VALUE == "MoveableTT_HP" ) then
			info = {};
			info.text = AggroVars.MoveTT_HP_Text;
			info.value = "FrameTT_HP_DragStart";
			info.func = TitanAggro_FrameTT_HP_DragStart;
			UIDropDownMenu_AddButton(info, 2);

			info = {};
			info.text = AggroVars.FixTT_HP_Text;
			info.value = "FrameTT_HP_DragStop";
			info.func = TitanAggro_FrameTT_HP_DragStop;
			UIDropDownMenu_AddButton(info, 2);

			info = {};
			info.text = AggroVars.ResetTT_HPPosition_Text;
			info.value = "ResetFrameTT_HP";
			info.func = TitanAggro_FrameTT_HP_Reset;
			UIDropDownMenu_AddButton(info, 2);
		end

		-- 2nd Level of AggroDetectGroups menu
		if ( UIDROPDOWNMENU_MENU_VALUE == "AggroDetect" ) then
			for i=0, 10 do
				if (AggroVars.AggroDetectGroups[i]) then
					info = {};
					info.text = AggroVars.AggroDetectGroups[i];
					info.value = i;
					info.func = TitanAggro_Set_AggroDetect;
					if (i == TitanAggroGetVar("AggroDetect")) then info.checked = 1; end
					UIDropDownMenu_AddButton(info, 2);
				end
			end
		end
	return;
	end

	-- Menu title
	local info = {};
	info.text = TITAN_AGGRO_MENU_TEXT;
	info.notClickable = 1;
	info.isTitle = 1;
	UIDropDownMenu_AddButton(info);

	-- 1st Level of ReportType menu
	info = {};
	info.text = AggroVars.ReportTypes_Text;
	info.value = "ReportType";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	-- 1st Level of ReportChan menu
	info = {};
	info.text = AggroVars.ReportChans_Text;
	info.value = "ReportChans";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	-- 1st Level of TimeBetweenReports menu
	info = {};
	info.text = AggroVars.ReportTimes_Text;
	info.value = "ReportTime";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	-- 1st Level of ReportFormat menu
	info = {};
	info.text = AggroVars.ReportFormats_Text;
	info.value = "ReportFormat";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	-- Do Reports
	info = {};
	info.text = AggroVars.DoReports_Text;
	info.value = "DoReports";
	info.func = TitanAggroToggleVar;
	if (TitanAggroGetVar("DoReports") and TitanAggroGetVar("DoReports") == 1) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);

	-- Sounds
	info = {};
	info.text = AggroVars.Sounds_Text;
	info.value = "Sounds";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	-- A blank line in the menu
	TitanAggro_AddSpacer();

	-- Tank Mode
	info = {};
	info.text = AggroVars.TankMode_Text;
	info.value = "TankMode";
	info.func = TitanAggroToggleVar;
	if (TitanAggroGetVar("TankMode") and TitanAggroGetVar("TankMode") == 1) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);


	-- A blank line in the menu
	TitanAggro_AddSpacer();

	-- ShowTT_HP
	info = {};
	info.text = AggroVars.ShowTTStatus_Text;
	info.value = "ShowTT_HP";
	info.func = TitanAggroToggleVar;
	if (TitanAggroGetVar("ShowTT_HP") and TitanAggroGetVar("ShowTT_HP") == 1) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);

	-- HideFlash
	info = {};
	info.text = AggroVars.HideFlashingBackground_Text;
	info.value = "HideFlashTT_HP";
	info.func = TitanAggroToggleVar;
	if (TitanAggroGetVar("HideFlashTT_HP") and TitanAggroGetVar("HideFlashTT_HP") == 1) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);

	-- RelocateTT_HP
	info = {};
	info.text = AggroVars.RelocateTTStatus_Text;
	info.value = "RelocateTT_HP";
	info.func = TitanAggro_Set_ToggleRelocate;
	if (TitanAggroGetVar("RelocateTT_HP") and TitanAggroGetVar("RelocateTT_HP") == 1) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);

	-- 1st Level of MoveableTT_HP menu
	info = {};
	info.text = AggroVars.MoveableTT_HP_Text;
	info.value = "MoveableTT_HP";
	info.hasArrow = 1;
	if (TitanAggroGetVar("MoveableTT_HP") and TitanAggroGetVar("MoveableTT_HP") == 1) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);

	-- A blank line in the menu
	TitanAggro_AddSpacer();

	-- Aggro Detect
	info = {};
	info.text = AggroVars.AggroDetect_Text;
	info.value = "AggroDetect";
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	-- Aggro Detect Pets
	info = {};
	info.text = AggroVars.AggroDetectPets_Text;
	info.value = "AggroDetectPets";
	info.func = TitanAggroToggleVar;
	if (TitanAggroGetVar("AggroDetectPets") and TitanAggroGetVar("AggroDetectPets") == 1) then
		info.checked = 1;
	end
	UIDropDownMenu_AddButton(info);

	-- A blank line in the menu
	TitanAggro_AddSpacer();

	if (AggroVars.TitanPanel) then
		-- Generic function to toggle label text
		TitanPanelRightClickMenu_AddToggleLabelText(TITAN_AGGRO_ID);

		-- Generic function to hide the plugin
		TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_AGGRO_ID, TITAN_PANEL_MENU_FUNC_HIDE);
	end
end


function TitanAggro_AddSpacer(level)
	local info = {};
	info.disabled = 1;
	UIDropDownMenu_AddButton(info, level);
end

function TitanPanelRightClickMenu_PrepareAggroMenu()
	TitanAggro_PrepareMenu();
end
