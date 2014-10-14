function RaidHealer_ConfigCheckButton_OnClick(checkBt)

	if (string.find(checkBt:GetName(), "HealClasses")) then
		RaidHealer_CharacterConfig["HEAL_CLASSES"] = {};
		
		local hc = RaidHealer_GetValidFactionsClasses(RAIDHEALER_HEALCLASSES);
		local bt = string.sub(checkBt:GetName(), 1, string.len(checkBt:GetName()) - 1);

		for i=1, table.getn(hc), 1 do
			if (getglobal(bt..i):GetChecked()) then
				table.insert(RaidHealer_CharacterConfig["HEAL_CLASSES"], hc[i]);
			end
		end
		-- refresh HealAssignmentPage page
		RaidHealer_DrawHealAssignmentFrame();
	elseif (string.find(checkBt:GetName(), "Whisper")) then
		local val = false;
		if (checkBt:GetChecked() == 1) then
			val = true;
		end
		
		if (string.find(checkBt:GetName(), "Assignment")) then
			RaidHealer_GlobalConfig["WHISPER_ASSIGNMENT"] = val;
		elseif (string.find(checkBt:GetName(), "HideOutgoing")) then
			RaidHealer_GlobalConfig["HIDE_OUTGOING_WHISPER"] = val;
		elseif (string.find(checkBt:GetName(), "HideIncomming")) then
			RaidHealer_GlobalConfig["HIDE_INCOMMING_WHISPER"] = val;
		end
	elseif (string.find(checkBt:GetName(), "Minimap")) then
		local val = false;
		if (checkBt:GetChecked() == 1) then
			val = true;
		end
		
		if (string.find(checkBt:GetName(), "ShowMinimapButton")) then
			RaidHealer_GlobalConfig["MINIMAP_SHOW"] = val;
			RaidHealer_MinimapButtonToggle(val);
		end
	elseif (string.find(checkBt:GetName(), "Announcements")) then
		local val = false;
		if (checkBt:GetChecked() == 1) then
			val = true;
		end
		
		if (string.find(checkBt:GetName(), "Alternate")) then
			RaidHealer_SetGC("ANNOUNCE_ALTERNATE", val);
		elseif (string.find(checkBt:GetName(), "HideHeal")) then
			RaidHealer_SetGC("HIDE_ANNOUNCE_HEAL", val);
		elseif (string.find(checkBt:GetName(), "HideBuff")) then
			RaidHealer_SetGC("HIDE_ANNOUNCE_BUFF", val);
		end
	elseif (string.find(checkBt:GetName(), "Innervate")) then
		local val = false;
		if (checkBt:GetChecked() == 1) then
			val = true;
		end
		
		if (string.find(checkBt:GetName(), "ShowInnervateBar")) then
			RaidHealer_SetGC("INNERVATE_ALERT", val);
		elseif (string.find(checkBt:GetName(), "InnervateRaid")) then
			RaidHealer_SetGC("INNERVATE_ANNOUNCE_RAID", val);
		elseif (string.find(checkBt:GetName(), "InnervateSay")) then
			RaidHealer_SetGC("INNERVATE_ANNOUNCE_SAY", val);
		end
		
	end
end

-- UI

function RaidHealer_InitInterfaceConfiguartionFrame()
	-- Option names
	RaidHealer_ConfigurationFrame_Whisper_Title:SetText(RAIDHEALER_WHISPER_SETUP);
	RaidHealer_ConfigurationFrame_Announcements_Title:SetText(RAIDHEALER_ANNOUNCEMENTS_SETUP);
	RaidHealer_ConfigurationFrame_Minimap_Title:SetText(RAIDHEALER_MINIMAP_SETUP);
	RaidHealer_ConfigurationFrame_Innervate_Title:SetText(RAIDHEALER_INNERVATE_SETUP);
	-- whisper
	getglobal(RaidHealer_ConfigurationFrame_Whisper:GetName().."_Assignments_Label"):SetText(RAIDHEALER_WHISPER_ASSIGNMENT);
	getglobal(RaidHealer_ConfigurationFrame_Whisper:GetName().."_HideOutgoing_Label"):SetText(RAIDHEALER_WHISPER_HIDE_OUTGOING);
	getglobal(RaidHealer_ConfigurationFrame_Whisper:GetName().."_HideIncomming_Label"):SetText(RAIDHEALER_WHISPER_HIDE_INCOMMING);
	getglobal(RaidHealer_ConfigurationFrame_Minimap:GetName().."_ShowMinimapButton_Label"):SetText(RAIDHEALER_SHOW_MINIMAP_BUTTON);
	getglobal(RaidHealer_ConfigurationFrame_Announcements:GetName().."_Alternate_Label"):SetText(RAIDHEALER_ANNOUNCEMENTS_ALT);
	getglobal(RaidHealer_ConfigurationFrame_Announcements:GetName().."_Alternate").tooltipText = RAIDHEALER_ANNOUNCEMENTS_ALT_TT;
	getglobal(RaidHealer_ConfigurationFrame_Announcements:GetName().."_HideHeal_Label"):SetText(RAIDHEALER_ANNOUNCEMENTS_HEAL);
	getglobal(RaidHealer_ConfigurationFrame_Announcements:GetName().."_HideHeal").tooltipText = RAIDHEALER_ANNOUNCEMENTS_HIDE_TT;
	getglobal(RaidHealer_ConfigurationFrame_Announcements:GetName().."_HideBuff_Label"):SetText(RAIDHEALER_ANNOUNCEMENTS_BUFF);
	getglobal(RaidHealer_ConfigurationFrame_Announcements:GetName().."_HideBuff").tooltipText = RAIDHEALER_ANNOUNCEMENTS_HIDE_TT;
	getglobal(RaidHealer_ConfigurationFrame_Innervate:GetName().."_ShowInnervateBar_Label"):SetText(RAIDHEALER_INNERVATE_ALERT);
	getglobal(RaidHealer_ConfigurationFrame_Innervate:GetName().."_ShowInnervateBar").tooltipText = RAIDHEALER_INNERVATE_ALERT_TT;
	getglobal(RaidHealer_ConfigurationFrame_Innervate:GetName().."_InnervateRaid_Label"):SetText(RAIDHEALER_INNERVATE_RAID);
	getglobal(RaidHealer_ConfigurationFrame_Innervate:GetName().."_InnervateSay_Label"):SetText(RAIDHEALER_INNERVATE_SAY);
end

function RaidHealer_RefreshConfigurationFrame()
	-- whisper
	getglobal(RaidHealer_ConfigurationFrame_Whisper:GetName().."_Assignments"):SetChecked(RaidHealer_GetGC("WHISPER_ASSIGNMENT"));
	getglobal(RaidHealer_ConfigurationFrame_Whisper:GetName().."_HideOutgoing"):SetChecked(RaidHealer_GetGC("HIDE_OUTGOING_WHISPER"));
	getglobal(RaidHealer_ConfigurationFrame_Whisper:GetName().."_HideIncomming"):SetChecked(RaidHealer_GetGC("HIDE_INCOMMING_WHISPER"));
	getglobal(RaidHealer_ConfigurationFrame_Minimap:GetName().."_ShowMinimapButton"):SetChecked(RaidHealer_GetGC("MINIMAP_SHOW"));
	getglobal(RaidHealer_ConfigurationFrame_Announcements:GetName().."_Alternate"):SetChecked(RaidHealer_GetGC("ANNOUNCE_ALTERNATE"));
	getglobal(RaidHealer_ConfigurationFrame_Announcements:GetName().."_HideHeal"):SetChecked(RaidHealer_GetGC("HIDE_ANNOUNCE_HEAL"));
	getglobal(RaidHealer_ConfigurationFrame_Announcements:GetName().."_HideBuff"):SetChecked(RaidHealer_GetGC("HIDE_ANNOUNCE_BUFF"));
	getglobal(RaidHealer_ConfigurationFrame_Innervate:GetName().."_ShowInnervateBar"):SetChecked(RaidHealer_GetGC("INNERVATE_ALERT"));
	getglobal(RaidHealer_ConfigurationFrame_Innervate:GetName().."_InnervateRaid"):SetChecked(RaidHealer_GetGC("INNERVATE_ANNOUNCE_RAID"));
	getglobal(RaidHealer_ConfigurationFrame_Innervate:GetName().."_InnervateSay"):SetChecked(RaidHealer_GetGC("INNERVATE_ANNOUNCE_SAY"));
	
	-- show Innervate Frame only for Druids
	if ( RaidHealer_User.class ~= RAIDHEALER_CLASS_DRUID and RaidHealer_ConfigurationFrame_Innervate:IsShown() ) then
		RaidHealer_ConfigurationFrame_Innervate:Hide();
	elseif ( RaidHealer_User.class == RAIDHEALER_CLASS_DRUID and not RaidHealer_ConfigurationFrame_Innervate:IsShown() ) then
		RaidHealer_ConfigurationFrame_Innervate:Show();
	end
end

-- Innervate Slider
function RaidHealer_InnervateSlider_OnLoad()
	RaidHealer_InnervateSlider_SetText(this);
	getglobal(this:GetName().."High"):SetText();
	getglobal(this:GetName().."Low"):SetText();
	this:SetMinMaxValues(0, 1);
	this:SetValueStep(0.05);
end

function RaidHealer_InnervateSlider_OnShow()
	local alert = RaidHealer_GetGC("INNERVATE_ALERT_VALUE");
	if ( alert ) then
		this:SetValue(alert);
	end
end

function RaidHealer_InnervateSlider_OnValueChanged()
	RaidHealer_SetGC("INNERVATE_ALERT_VALUE", this:GetValue());
	RaidHealer_InnervateSlider_SetText(this);
end

function RaidHealer_InnervateSlider_SetText(slider)
	getglobal(slider:GetName().."Text"):SetText(string.format(RAIDHEALER_INNERVATE_ALERT_VALUE, math.floor(this:GetValue()*100)));
end