local GuildMapOldConfig = {};

function GuildMap_ShowOptions()

	GuildMapOldConfig = GuildMap_CloneTable(GuildMapConfig);

	if (GuildMapConfig.mmArrows) then
		GuildMapOptionsFrameDisplayArrowsCB:SetChecked(1);
		OptionsFrame_EnableSlider(GuildMapOptionsFrameArrowDistanceSL);
	else
		GuildMapOptionsFrameDisplayArrowsCB:SetChecked(nil);
		OptionsFrame_DisableSlider(GuildMapOptionsFrameArrowDistanceSL);
	end
	
	GuildMapOptionsFrameArrowDistanceSL:SetValue(GuildMapConfig.mmDistance);

	UIDropDownMenu_SetSelectedValue(GuildMapOptionsFrameIconLeftMouseDD, GuildMapConfig.mmLMB);
	UIDropDownMenu_SetSelectedValue(GuildMapOptionsFrameIconRightMouseDD, GuildMapConfig.mmRMB);

	-- workaround problem with setting the text (shared drop down instances???)
	GuildMap_SetIconMouseDDText(GuildMapOptionsFrameIconLeftMouseDD, GuildMapConfig.mmLMB);
	GuildMap_SetIconMouseDDText(GuildMapOptionsFrameIconRightMouseDD, GuildMapConfig.mmRMB);

	GuildMapOptionsFrame:Show();


end


function GuildMap_SetIconMouseDDText(frame, value)

	if (value == "TARGET") then
		UIDropDownMenu_SetText(GUILDMAP_TEXT_TARGET_PLAYER, frame);
	elseif (value == "PING") then
		UIDropDownMenu_SetText(GUILDMAP_TEXT_PING_THRU, frame);
	else
		UIDropDownMenu_SetText(GUILDMAP_TEXT_NO_ACTION, frame);
	end

end


function GuildMap_IconLeftMouseDDInitialize()
	local info = {};
	info.text = GUILDMAP_TEXT_NO_ACTION;
	info.value = "NOTHING";
	info.func = GuildMap_IconLeftMouseDDClick;
	info.checked = nil;
	UIDropDownMenu_AddButton(info);
	
	info.text = GUILDMAP_TEXT_PING_THRU;
	info.value = "PING";
	info.func = GuildMap_IconLeftMouseDDClick;
	info.checked = nil;
	UIDropDownMenu_AddButton(info);
	
	info.text = GUILDMAP_TEXT_TARGET_PLAYER;
	info.value = "TARGET";
	info.func = GuildMap_IconLeftMouseDDClick;
	info.checked = nil;
	UIDropDownMenu_AddButton(info);
end


function GuildMap_IconLeftMouseDDClick()
	UIDropDownMenu_SetSelectedValue(GuildMapOptionsFrameIconLeftMouseDD, this.value);
	GuildMapConfig.mmLMB = this.value;
end


function GuildMap_IconRightMouseDDInitialize()
	local info = {};
	info.text = GUILDMAP_TEXT_NO_ACTION;
	info.value = "NOTHING";
	info.func = GuildMap_IconRightMouseDDClick;
	info.checked = nil;
	UIDropDownMenu_AddButton(info);
	
	info.text = GUILDMAP_TEXT_PING_THRU;
	info.value = "PING";
	info.func = GuildMap_IconRightMouseDDClick;
	info.checked = nil;
	UIDropDownMenu_AddButton(info);
	
	info.text = GUILDMAP_TEXT_TARGET_PLAYER;
	info.value = "TARGET";
	info.func = GuildMap_IconRightMouseDDClick;
	info.checked = nil;
	UIDropDownMenu_AddButton(info);
	
end


function GuildMap_IconRightMouseDDClick()
	UIDropDownMenu_SetSelectedValue(GuildMapOptionsFrameIconRightMouseDD, this.value);
	GuildMapConfig.mmRMB = this.value;
end


function GuildMap_DisplayArrowsCB_OnClick()
	if (this:GetChecked()) then
		OptionsFrame_EnableSlider(GuildMapOptionsFrameArrowDistanceSL);
		GuildMapConfig.mmArrows = true;
	else
		OptionsFrame_DisableSlider(GuildMapOptionsFrameArrowDistanceSL);
		GuildMapConfig.mmArrows = false;
	end
end

function GuildMap_ArrowDistanceSL_OnValueChanged()
	GuildMapConfig.mmDistance = this:GetValue();
end

function GuildMap_Cancel_OnClick() 
	-- restore settings backup
	GuildMapConfig = GuildMapOldConfig;

	PlaySound("gsTitleOptionExit");
	GuildMapOptionsFrame:Hide();

end

function GuildMap_OK_OnClick()
	PlaySound("gsTitleOptionOK");
	GuildMapOptionsFrame:Hide();
end