TITAN_VOLUME2_ID = "Volume2";
TITAN_VOLUME2_FRAME_SHOW_TIME = 0.5;

function TitanPanelVolume2Button_OnLoad()
	this.registry = { 
		id = TITAN_VOLUME2_ID,
		category = "General",
		menuText = TITAN_VOLUME2_MENU_TEXT, 
		tooltipTitle = TITAN_VOLUME2_TOOLTIP, 
		tooltipTextFunction = "TitanPanelVolume2Button_GetTooltipText",
		iconWidth = 32,
		iconButtonWidth = 18,
	};
end

function TitanPanelVolume2Button_OnShow()
	TitanPanelVolume2_SetVolumeIcon();
end

function TitanPanelVolume2Button_OnEnter()
	-- Confirm master volume value
	TitanPanelMasterVolume2ControlSlider:SetValue(1 - GetCVar("MasterVolume"));
	TitanPanelAmbienceVolume2ControlSlider:SetValue(1 - GetCVar("AmbienceVolume"));
	TitanPanelSoundVolume2ControlSlider:SetValue(1 - GetCVar("SoundVolume"));
	TitanPanelMusicVolume2ControlSlider:SetValue(1 - GetCVar("MusicVolume"));
	TitanPanelVolume2_SetVolumeIcon();
	reset_Master = GetCVar("MasterVolume");
	reset_Ambience = GetCVar("AmbienceVolume");
	reset_Sound = GetCVar("SoundVolume");
	reset_Music = GetCVar("MusicVolume");
	SetCVar("MasterVolume", 50);
	SetCVar("AmbienceVolume", 50);
	SetCVar("SoundVolume", 50);
	SetCVar("MusicVolume", 50);
	SetCVar("MasterVolume", 0);
	SetCVar("AmbienceVolume", 0);
	SetCVar("SoundVolume", 0);
	SetCVar("MusicVolume", 0);
	SetCVar("MasterVolume", reset_Master);
	SetCVar("AmbienceVolume", reset_Ambience);
	SetCVar("SoundVolume", reset_Sound);
	SetCVar("MusicVolume", reset_Music);
end

-- 'Master' 
function TitanPanelMasterVolume2ControlSlider_OnEnter()
	this.tooltipText = TitanOptionSlider_TooltipText(TITAN_VOLUME2_CONTROL_TOOLTIP, TitanPanelVolume2_GetVolumeText(GetCVar("MasterVolume")));
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(this.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(this:GetParent());
end

function TitanPanelMasterVolume2ControlSlider_OnLeave()
	this.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(this:GetParent(), TITAN_VOLUME2_FRAME_SHOW_TIME);
end

function TitanPanelMasterVolume2ControlSlider_OnShow()
        
	getglobal(this:GetName().."Text"):SetText(TitanPanelVolume2_GetVolumeText(GetCVar("MasterVolume")));
	getglobal(this:GetName().."High"):SetText(TITAN_VOLUME2_CONTROL_LOW);
	getglobal(this:GetName().."Low"):SetText(TITAN_VOLUME2_CONTROL_HIGH);
	this:SetMinMaxValues(0, 1);
	this:SetValueStep(0.01);
	this:SetValue(1 - GetCVar("MasterVolume"));
end

function TitanPanelMasterVolume2ControlSlider_OnValueChanged()
	SetCVar("MasterVolume", 1 - this:GetValue());
	getglobal(this:GetName().."Text"):SetText(TitanPanelVolume2_GetVolumeText(GetCVar("MasterVolume")));
	TitanPanelVolume2_SetVolumeIcon();

	-- Update GameTooltip
	if (this.tooltipText) then
		this.tooltipText = TitanOptionSlider_TooltipText(TITAN_VOLUME2_CONTROL_TOOLTIP, TitanPanelVolume2_GetVolumeText(GetCVar("MasterVolume")));
		GameTooltip:SetText(this.tooltipText, nil, nil, nil, nil, 1);
	end
end
-- 'Music'
function TitanPanelMusicVolume2ControlSlider_OnEnter()
	this.tooltipText = TitanOptionSlider_TooltipText(TITAN_VOLUME2_CONTROL_TOOLTIP, TitanPanelVolume2_GetVolumeText(GetCVar("MusicVolume")));
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(this.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(this:GetParent());
end

function TitanPanelMusicVolume2ControlSlider_OnLeave()
	this.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(this:GetParent(), TITAN_VOLUME2_FRAME_SHOW_TIME);
end

function TitanPanelMusicVolume2ControlSlider_OnShow()
        
	getglobal(this:GetName().."Text"):SetText(TitanPanelVolume2_GetVolumeText(GetCVar("MusicVolume")));
	getglobal(this:GetName().."High"):SetText(TITAN_VOLUME2_CONTROL_LOW);
	getglobal(this:GetName().."Low"):SetText(TITAN_VOLUME2_CONTROL_HIGH);
	this:SetMinMaxValues(0, 1);
	this:SetValueStep(0.01);
	this:SetValue(1 - GetCVar("MusicVolume"));
end

function TitanPanelMusicVolume2ControlSlider_OnValueChanged()
	SetCVar("MusicVolume", 1 - this:GetValue());
	getglobal(this:GetName().."Text"):SetText(TitanPanelVolume2_GetVolumeText(GetCVar("MusicVolume")));
	
	-- Update GameTooltip
	if (this.tooltipText) then
		this.tooltipText = TitanOptionSlider_TooltipText(TITAN_VOLUME2_CONTROL_TOOLTIP, TitanPanelVolume2_GetVolumeText(GetCVar("MusicVolume")));
		GameTooltip:SetText(this.tooltipText, nil, nil, nil, nil, 1);
	end
end
-- 'Sound'
function TitanPanelSoundVolume2ControlSlider_OnEnter()
	this.tooltipText = TitanOptionSlider_TooltipText(TITAN_VOLUME2_CONTROL_TOOLTIP, TitanPanelVolume2_GetVolumeText(GetCVar("SoundVolume")));
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(this.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(this:GetParent());
end

function TitanPanelSoundVolume2ControlSlider_OnLeave()
	this.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(this:GetParent(), TITAN_VOLUME2_FRAME_SHOW_TIME);
end

function TitanPanelSoundVolume2ControlSlider_OnShow()
        
	getglobal(this:GetName().."Text"):SetText(TitanPanelVolume2_GetVolumeText(GetCVar("SoundVolume")));
	getglobal(this:GetName().."High"):SetText(TITAN_VOLUME2_CONTROL_LOW);
	getglobal(this:GetName().."Low"):SetText(TITAN_VOLUME2_CONTROL_HIGH);
	this:SetMinMaxValues(0, 1);
	this:SetValueStep(0.01);
	this:SetValue(1 - GetCVar("SoundVolume"));
end

function TitanPanelSoundVolume2ControlSlider_OnValueChanged()
	SetCVar("SoundVolume", 1 - this:GetValue());
	getglobal(this:GetName().."Text"):SetText(TitanPanelVolume2_GetVolumeText(GetCVar("SoundVolume")));
	
	-- Update GameTooltip
	if (this.tooltipText) then
		this.tooltipText = TitanOptionSlider_TooltipText(TITAN_VOLUME2_CONTROL_TOOLTIP, TitanPanelVolume2_GetVolumeText(GetCVar("SoundVolume")));
		GameTooltip:SetText(this.tooltipText, nil, nil, nil, nil, 1);
	end
end
-- 'Ambience'
function TitanPanelAmbienceVolume2ControlSlider_OnEnter()
	this.tooltipText = TitanOptionSlider_TooltipText(TITAN_VOLUME2_CONTROL_TOOLTIP, TitanPanelVolume2_GetVolumeText(GetCVar("AmbienceVolume")));
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(this.tooltipText, nil, nil, nil, nil, 1);
	TitanUtils_StopFrameCounting(this:GetParent());
end

function TitanPanelAmbienceVolume2ControlSlider_OnLeave()
	this.tooltipText = nil;
	GameTooltip:Hide();
	TitanUtils_StartFrameCounting(this:GetParent(), TITAN_VOLUME2_FRAME_SHOW_TIME);
end

function TitanPanelAmbienceVolume2ControlSlider_OnShow()
        
	getglobal(this:GetName().."Text"):SetText(TitanPanelVolume2_GetVolumeText(GetCVar("AmbienceVolume")));
	getglobal(this:GetName().."High"):SetText(TITAN_VOLUME2_CONTROL_LOW);
	getglobal(this:GetName().."Low"):SetText(TITAN_VOLUME2_CONTROL_HIGH);
	this:SetMinMaxValues(0, 1);
	this:SetValueStep(0.01);
	this:SetValue(1 - GetCVar("AmbienceVolume"));
end

function TitanPanelAmbienceVolume2ControlSlider_OnValueChanged()
	SetCVar("AmbienceVolume", 1 - this:GetValue());
	getglobal(this:GetName().."Text"):SetText(TitanPanelVolume2_GetVolumeText(GetCVar("AmbienceVolume")));
	
	-- Update GameTooltip
	if (this.tooltipText) then
		this.tooltipText = TitanOptionSlider_TooltipText(TITAN_VOLUME2_CONTROL_TOOLTIP, TitanPanelVolume2_GetVolumeText(GetCVar("AmbienceVolume")));
		GameTooltip:SetText(this.tooltipText, nil, nil, nil, nil, 1);
	end
end
function TitanPanelVolume2_GetVolumeText(volume)
	return tostring(floor(100 * volume + 0.5)) .. "%";
end

function TitanPanelVolume2ControlFrame_OnLoad()
	getglobal(this:GetName().."Title"):SetText(TITAN_VOLUME2_CONTROL_TITLE);
	getglobal(this:GetName().."MasterTitle"):SetText(TITAN_VOLUME2_MASTER_CONTROL_TITLE);
	getglobal(this:GetName().."MusicTitle"):SetText(TITAN_VOLUME2_MUSIC_CONTROL_TITLE);
	getglobal(this:GetName().."SoundTitle"):SetText(TITAN_VOLUME2_SOUND_CONTROL_TITLE);
	getglobal(this:GetName().."AmbienceTitle"):SetText(TITAN_VOLUME2_AMBIENCE_CONTROL_TITLE);
	this:SetBackdropBorderColor(1, 1, 1);
	this:SetBackdropColor(0, 0, 0, 1);
end

function TitanPanelVolume2ControlFrame_OnUpdate(elapsed)
	TitanUtils_CheckFrameCounting(this, elapsed);
end

function TitanPanelVolume2_SetVolumeIcon()
	local icon = getglobal("TitanPanelVolume2ButtonIcon");
	local MusicVolume = tonumber(GetCVar("MasterVolume"));
	if (MusicVolume <= 0) then
		icon:SetTexture("Interface\\AddOns\\TitanVolume2\\Artwork\\TitanVolumeMute");
	elseif (MusicVolume < 0.33) then
		icon:SetTexture("Interface\\AddOns\\TitanVolume2\\Artwork\\TitanVolumeLow");
	elseif (MusicVolume < 0.66) then
		icon:SetTexture("Interface\\AddOns\\TitanVolume2\\Artwork\\TitanVolumeMedium");
	else
		icon:SetTexture("Interface\\AddOns\\TitanVolume2\\Artwork\\TitanVolumeHigh");
	end	
end

function TitanPanelVolume2Button_GetTooltipText()
	local volumeMasterText = TitanPanelVolume2_GetVolumeText(GetCVar("MasterVolume"));
	local volumeSoundText = TitanPanelVolume2_GetVolumeText(GetCVar("SoundVolume"));
	local volumeMusicText = TitanPanelVolume2_GetVolumeText(GetCVar("MusicVolume"));
	local volumeAmbienceText = TitanPanelVolume2_GetVolumeText(GetCVar("AmbienceVolume"));
	return ""..
		TITAN_VOLUME2_MASTER_TOOLTIP_VALUE.."\t"..TitanUtils_GetHighlightText(volumeMasterText).."\n"..
		TITAN_VOLUME2_SOUND_TOOLTIP_VALUE.."\t"..TitanUtils_GetHighlightText(volumeSoundText).."\n"..
		TITAN_VOLUME2_MUSIC_TOOLTIP_VALUE.."\t"..TitanUtils_GetHighlightText(volumeMusicText).."\n"..
		TITAN_VOLUME2_AMBIENCE_TOOLTIP_VALUE.."\t"..TitanUtils_GetHighlightText(volumeAmbienceText).."\n"..
		TitanUtils_GetGreenText(TITAN_VOLUME2_TOOLTIP_HINT1).."\n"..
		TitanUtils_GetGreenText(TITAN_VOLUME2_TOOLTIP_HINT2);
end

function TitanPanelRightClickMenu_PrepareVolume2Menu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_VOLUME2_ID].menuText);
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_VOLUME2_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end
