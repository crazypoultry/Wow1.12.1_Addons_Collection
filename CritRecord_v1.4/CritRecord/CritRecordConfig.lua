function CritRecordConfig_OnLoad()
	SLASH_CRITRECORD1 = "/critrecord";
	SLASH_CRITRECORD2 = "/cr";
	SlashCmdList["CRITRECORD"] = CritRecordConfig_ShowFrame;
end

function CritRecordConfig_ShowFrame()
    if (CritRecordConfigFrame:IsVisible()) then
		CritRecordConfigFrame:Hide();
	else
		CritRecordConfigFrame:Show();
	end
end

function CritRecordConfig_UpdateViewRecords()
	local spellnames = {}
	local i = 0;
	local outStr = "";
	for index, value in CritRecordDB do
		table.insert(spellnames, index)
		i = i + 1;
	end
	table.sort(spellnames);
	for index, spellname in spellnames do
		dbRecord = CritRecordDB[spellname];
		if (dbRecord["Type"] == 2) then
			dmgColor = "|cFF9EFF9E";
		else
			dmgColor = "|cFFFF9E9E";
		end
		outStr = outStr .. "|cFFFFFF9E[" .. spellname .. "] " .. dmgColor .. "[" .. dbRecord["DMG"] .. "]|r\n";
		if (CritRecordOptions["General"]["ShortReview"] ~= 1) then
			outStr = outStr .. "|cFFFFFFFF- " .. dbRecord["Target"];
			if (dbRecord["TargetIsPlayer"]) then outStr = outStr .. " (Player)"; end
			if (dbRecord["TargetLevel"]) then
				local level = dbRecord["TargetLevel"];
				if (level == -1) then
					level = "??";
				end
				outStr = outStr .. "\n- Level " .. level;
				if (dbRecord["TargetIsPlayer"]) then
					if (dbRecord["TargetRace"]) then
						outStr = outStr .. " " .. dbRecord["TargetRace"];
					end
					if (dbRecord["TargetClass"]) then
						outStr = outStr .. " " .. dbRecord["TargetClass"];
					end
				else
					if (dbRecord["TargetCreatureFamily"]) then
						outStr = outStr .. " " .. dbRecord["TargetCreatureFamily"];
					elseif (dbRecord["TargetCreatureType"]) then
						outStr = outStr .. " " .. dbRecord["TargetCreatureType"];
					end
					if (dbRecord["TargetClassification"]) then
						local classification = dbRecord["TargetClassification"];
						outStr = outStr .. " " .. CritRecord.Classification[classification];
					end
				end
			end
			if (dbRecord["Zone"]) then
				outStr = outStr .. "\n- ";
				if (dbRecord["SubZone"] ~= "") then
					outStr = outStr .. dbRecord["SubZone"] .. ", ";
				end
				outStr = outStr .. dbRecord["Zone"];
			end
			if (dbRecord["Time"]) then
				outStr = outStr .. "\n- " .. date("%d/%m/%y %H:%M", dbRecord["Time"]);
			end
			outStr = outStr .. "\n\n";
		end
		i = i + 1;
	end
	local nowStr = CritRecordConfig_ViewRecordsText:GetText();
	if (nowStr ~= outStr) then
		CritRecordConfig_ViewRecordsText:SetText(outStr);
		ScrollingEdit_OnTextChanged(CritRecordConfig_ViewRecordsScrollFrame);
	end
end

function CritRecordConfig_OnClickCheck(name)
	_, _, section, option = string.find(name, "CritRecordConfig_(.+)_Check(.+)");
	if (option == "ReportInChat") then
		CritRecordOptions["General"][option] = true;
		CritRecordOptions["General"]["ReportOnScreen"] = false;
	elseif (option == "ReportOnScreen") then
		CritRecordOptions["General"][option] = true;
		CritRecordOptions["General"]["ReportInChat"] = false;
	else
		CritRecordOptions[section][option] = getglobal(name):GetChecked();
	end
	CritRecordConfig_UpdateCheckAbilities();
end

function CritRecordConfig_UpdateCheckAbilities()
	local optGeneral = CritRecordOptions["General"];
	local optDamage = CritRecordOptions["Damage"];
	local optHealing = CritRecordOptions["Healing"];
	local prefixGeneral = "CritRecordConfig_General_Check";
	local prefixDamage = "CritRecordConfig_Damage_Check";
	local prefixHealing = "CritRecordConfig_Healing_Check";
	
	if (optGeneral["ReportInChat"]) then
		getglobal(prefixGeneral .. "ReportInChat"):SetChecked(true);
		getglobal(prefixGeneral .. "ReportOnScreen"):SetChecked(false);
	else
		getglobal(prefixGeneral .. "ReportInChat"):SetChecked(false);
		getglobal(prefixGeneral .. "ReportOnScreen"):SetChecked(true);
	end
	
	if (optGeneral["EnableAddon"]) then
		getglobal(prefixGeneral .. "EnableTooltips"):Enable();
		getglobal(prefixGeneral .. "ReportNewCrits"):Enable();
		if (optGeneral["ReportNewCrits"]) then
			getglobal(prefixGeneral .. "ReportInChat"):Show();
			getglobal(prefixGeneral .. "ReportOnScreen"):Show();
		else
			getglobal(prefixGeneral .. "ReportInChat"):Hide();
			getglobal(prefixGeneral .. "ReportOnScreen"):Hide();
		end
		getglobal(prefixGeneral .. "EnableBGCrits"):Show();
		getglobal(prefixGeneral .. "TakeScreenshots"):Show();
		getglobal(prefixDamage .. "RecordCrits"):Enable();
		getglobal(prefixDamage .. "CountTrivial"):Enable();
		getglobal(prefixHealing .. "RecordCrits"):Enable();
		getglobal(prefixHealing .. "CountTrivial"):Enable();
		
		if (optGeneral["EnableTooltips"]) then
			getglobal(prefixDamage .. "TooltipTargetInfo"):Enable();
			if (optDamage["TooltipTargetInfo"]) then
				getglobal(prefixDamage .. "TooltipLevelRaceClass"):Show();
				getglobal(prefixDamage .. "TooltipLocation"):Show();
				getglobal(prefixDamage .. "TooltipDateTime"):Show();
			else
				getglobal(prefixDamage .. "TooltipLevelRaceClass"):Hide();
				getglobal(prefixDamage .. "TooltipLocation"):Hide();
				getglobal(prefixDamage .. "TooltipDateTime"):Hide();
			end
			getglobal(prefixHealing .. "TooltipTargetInfo"):Enable();
			if (optHealing["TooltipTargetInfo"]) then
				getglobal(prefixHealing .. "TooltipLevelRaceClass"):Show();
				getglobal(prefixHealing .. "TooltipLocation"):Show();
				getglobal(prefixHealing .. "TooltipDateTime"):Show();
			else
				getglobal(prefixHealing .. "TooltipLevelRaceClass"):Hide();
				getglobal(prefixHealing .. "TooltipLocation"):Hide();
				getglobal(prefixHealing .. "TooltipDateTime"):Hide();
			end
		else
			getglobal(prefixDamage .. "TooltipTargetInfo"):Disable();
			getglobal(prefixDamage .. "TooltipLevelRaceClass"):Hide();
			getglobal(prefixDamage .. "TooltipLocation"):Hide();
			getglobal(prefixDamage .. "TooltipDateTime"):Hide();
			getglobal(prefixHealing .. "TooltipTargetInfo"):Disable();
			getglobal(prefixHealing .. "TooltipLevelRaceClass"):Hide();
			getglobal(prefixHealing .. "TooltipLocation"):Hide();
			getglobal(prefixHealing .. "TooltipDateTime"):Hide();
		end
	else
		getglobal(prefixGeneral .. "EnableTooltips"):Disable();
		getglobal(prefixGeneral .. "ReportNewCrits"):Disable();
		getglobal(prefixGeneral .. "ReportInChat"):Hide();
		getglobal(prefixGeneral .. "ReportOnScreen"):Hide();
		getglobal(prefixGeneral .. "EnableBGCrits"):Hide();
		getglobal(prefixGeneral .. "TakeScreenshots"):Hide();
		getglobal(prefixDamage .. "RecordCrits"):Disable();
		getglobal(prefixDamage .. "CountTrivial"):Disable();
		getglobal(prefixDamage .. "TooltipTargetInfo"):Disable();
		getglobal(prefixDamage .. "TooltipLevelRaceClass"):Hide();
		getglobal(prefixDamage .. "TooltipLocation"):Hide();
		getglobal(prefixDamage .. "TooltipDateTime"):Hide();
		getglobal(prefixHealing .. "RecordCrits"):Disable();
		getglobal(prefixHealing .. "CountTrivial"):Disable();
		getglobal(prefixHealing .. "TooltipTargetInfo"):Disable();
		getglobal(prefixHealing .. "TooltipLevelRaceClass"):Hide();
		getglobal(prefixHealing .. "TooltipLocation"):Hide();
		getglobal(prefixHealing .. "TooltipDateTime"):Hide();
	end
end
