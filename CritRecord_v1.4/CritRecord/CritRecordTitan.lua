CritRecord.TitanLoaded = false;

function CritRecord_TitanButton_OnLoad()
	if (IsAddOnLoaded("Titan")) then
		CritRecord.TitanLoaded = true;
		this.registry = {
			id = "CritRecord",
			version = CritRecord.Version,
			menuText = "CritRecord", 
			buttonTextFunction = "CritRecord_Titan_GetButtonText",
			tooltipTitle = "CritRecord", 
			tooltipTextFunction = "CritRecord_Titan_GetToolTipText",
			frequency = .5,
			iconWidth = 16,
			savedVariables = {
				ShowIcon = 1,
				ShowLabelText = 1,
				LiveMode = 0,
			}
		};
		TitanPanelButton_OnLoad();
	end
end
		
function CritRecord_Titan_OnClick()
	if (arg1 == "LeftButton") then
		if (TitanPanelRightClickMenu_IsVisible()) then TitanPanelRightClickMenu_Close(); end
		local LiveMode = TitanGetVar("CritRecord", "LiveMode");
		TitanSetVar("CritRecord", "LiveMode", 1 - LiveMode);
		TitanPanelButton_UpdateButton("CritRecord");
		TitanPanelButton_UpdateTooltip();
	else
		TitanPanelButton_OnClick(arg1);
	end
end

function CritRecord_Titan_ErrorWithStack(msg)
   msg = msg.."\n"..debugstack()
   DEFAULT_CHAT_FRAME:AddMessage(msg);
end

seterrorhandler(CritRecord_Titan_ErrorWithStack);

function CritRecord_TitanButton_OnEvent()
	TitanPanelButton_UpdateButton("CritRecord");
	TitanPanelButton_UpdateTooltip();
end

function TitanPanelRightClickMenu_PrepareCritRecordMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins["CritRecord"].menuText);
	TitanPanelRightClickMenu_AddToggleIcon("CritRecord");
	TitanPanelRightClickMenu_AddToggleLabelText("CritRecord");
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand("Configuration", "CritRecord", "CritRecordConfig_ShowFrame");
	
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, "CritRecord", TITAN_PANEL_MENU_FUNC_HIDE);
end

function CritRecord_Titan_GetSpellID(name)
	local i = 1
	local spellID = false;
	while true do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
		if not spellName then
			do break end
		end
		if (spellName == name) then
			spellID = i;
		end
	   i = i + 1
	end
	return spellID;
end

function CritRecord_Titan_GetButtonText()
	local msgColor = "|cffedc300";
	local attack = "n/a";
	local dmg = 0;
	local title = "Crit Record";
	local index = CritRecord.latestCrit;
	if (TitanGetVar("CritRecord", "LiveMode") == 1) then
		if (CritRecord.lastCrit) then 
			attack = CritRecord.lastCrit.Attack;
			dmg = CritRecord.lastCrit.DMG;
			title = "Crit Monitor";
		end
	elseif (CritRecordDB[index]) then
		attack = CritRecord.latestCrit;
		dmg = CritRecordDB[index]["DMG"];
		title = "Crit Record";
	end
	local spellID = CritRecord_Titan_GetSpellID(ATTACK);
	local text = "Ready";
	if (tonumber(dmg) > 0) then
		spellID = CritRecord_Titan_GetSpellID(attack);
		text = dmg .. " - " .. attack;
	end
	if (not spellID) then spellID = CritRecord_Titan_GetSpellID(ATTACK); end
	TitanPanelCritRecordButtonIcon:SetTexture(GetSpellTexture(spellID, BOOKTYPE_SPELL));
	return msgColor..title..": ".."|cffffffff"..text;
end

function CritRecord_Titan_GetToolTipText()
	local dmgcrits = {};
	local healcrits = {};
	local latestTime = 0;
	local outStr = "";
	for index, value in CritRecordDB do
		if (CritRecordDB[index]["Time"] > latestTime) then
			latestCrit = index;
			latestTime = CritRecordDB[index]["Time"];
		end
	end
	table.sort(dmgcrits);
	table.sort(healcrits);
	
	local attack = "Attack";
	
	if (TitanGetVar("CritRecord", "LiveMode") == 1) then
		outStr = outStr .. "|cffa0a0a0Left-Click to switch to Crit Record Mode|r\n";
		dbRecord = CritRecord.lastCrit;
		if (dbRecord) then attack = CritRecord.lastCrit["Attack"]; end
		local text = TitanUtils_GetHighlightText("Live Crit Monitor");
		outStr = outStr.."\n"..text.."\n";
	else
		outStr = outStr .. "|cffa0a0a0Left-Click to switch to Live Monitor Mode|r\n";
		dbRecord = CritRecordDB[latestCrit];
		attack = latestCrit;
		local text = TitanUtils_GetHighlightText("New Crit Record");
		outStr = outStr.."\n"..text.."\n";
	end
	
	if (dbRecord) then
		outStr = outStr .. "Attack: \t" .. TitanUtils_GetHighlightText(attack) .. "\n";
		outStr = outStr .. "Damage: \t" .. TitanUtils_GetHighlightText(dbRecord["DMG"]) .. "\n";
		local target = dbRecord["Target"];
		if (dbRecord["TargetIsPlayer"]) then target = target .. " (Player)"; end
		if (dbRecord["TargetClassification"]) then target = target .. " " .. CritRecord.Classification[dbRecord["TargetClassification"]]; end
		outStr = outStr .. "Target: \t" .. TitanUtils_GetHighlightText(target) .. "\n";
		if (dbRecord["TargetLevel"]) then
			local level = dbRecord["TargetLevel"];
			if (level == -1) then
				level = "??";
			end
			outStr = outStr .. "Level: \t" .. TitanUtils_GetHighlightText(level) .. "\n";
		end
		if (dbRecord["TargetIsPlayer"]) then
			if (dbRecord["TargetRace"]) then
				outStr = outStr .. "Race: \t" .. TitanUtils_GetHighlightText(dbRecord["TargetRace"]) .. "\n";
			end
			if (dbRecord["TargetClass"]) then
				outStr = outStr .. "Class: \t" .. TitanUtils_GetHighlightText(dbRecord["TargetClass"]) .. "\n";
			end
		else
			if (dbRecord["TargetCreatureFamily"]) then
				outStr = outStr .. "Type: \t" .. TitanUtils_GetHighlightText(dbRecord["TargetCreatureFamily"]) .. "\n";
			elseif (dbRecord["TargetCreatureType"]) then
				outStr = outStr .. "Type: \t" .. TitanUtils_GetHighlightText(dbRecord["TargetCreatureType"]) .. "\n";
			end
		end
		if (dbRecord["Zone"]) then
			outStr = outStr .. "Location: \t";
			outStr = outStr .. TitanUtils_GetHighlightText(dbRecord["Zone"]) .. "\n";
		end
		if (dbRecord["Time"]) then
			outStr = outStr .. "Time: \t" .. TitanUtils_GetHighlightText(date("%H:%M %d/%m/%y", dbRecord["Time"])) .. "\n";
		end
	else	
		outStr = outStr .. "No Information Available\n";
	end
	return outStr;
end