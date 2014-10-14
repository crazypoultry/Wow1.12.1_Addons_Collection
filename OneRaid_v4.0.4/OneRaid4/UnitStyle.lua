OneRaid.UnitStyle = {};



function OneRaid.UnitStyle:OnLoad()

	getglobal(this:GetName() .. "_Header_Text"):SetText(ONERAID_UNIT_STYLE_OPTIONS);
	
	getglobal(this:GetName() .. "_Header_Background"):SetVertexColor(.4, 0, 0, 1);
	this:SetBackdropColor(0, 0, 0, .75);
	this:SetBackdropBorderColor(0, 0, 0, 0);
	
	local f = CreateFrame("Button", "OneRaid_UnitStyle_Frame_Unit", OneRaid_UnitStyle_Frame, "OneRaid_Unit_Template");		
	f.numberBuffs = 0;
	
	f.name = UnitName("player");
	f.unit = "player";
	f.style = style;
	f.data = {};
	
	f:Hide();
	
	this:SetFrameLevel(0);
	f:SetFrameLevel(1);
	
	f:UnregisterEvent("UNIT_AURA");

end

function OneRaid.UnitStyle:OnMouseDown()

	this:StartMoving();
	
end

function OneRaid.UnitStyle:OnMouseUp()

	this:StopMovingOrSizing();
	
end

------

function OneRaid.UnitStyle:CopyStyle(style, newStyle, element, deep)

	local tbl;
	
	if (deep) then
		tbl = OneRaid_Options.UnitStyles[style][element][deep];
		OneRaid_Options.UnitStyles[newStyle][element][deep] = {};
	elseif (element) then
		tbl = OneRaid_Options.UnitStyles[style][element];
		OneRaid_Options.UnitStyles[newStyle][element] = {};
	else
		tbl = OneRaid_Options.UnitStyles[style];
		OneRaid_Options.UnitStyles[newStyle] = {};
	end
	
	for k, v in tbl do

		if (type(v) == "table") then
			if (not element) then
				self:CopyStyle(style, newStyle, k);
			elseif (not deep) then
				self:CopyStyle(style, newStyle, element, k);
			end
		else
			if (deep) then
				OneRaid_Options.UnitStyles[newStyle][element][deep][k] = v;
			elseif (element) then
				OneRaid_Options.UnitStyles[newStyle][element][k] = v;
			else
				OneRaid_Options.UnitStyles[newStyle][k] = v;
			end
		end
	end
		
end

function OneRaid.UnitStyle:DeleteStyle()

	if (self.style == "Default") then return; end
	
	OneRaid_Options.UnitStyles[self.style] = nil;
	
	self:EditStyle("Default");

end

function OneRaid.UnitStyle:NewStyle()

	local i = 1;
	
	while (OneRaid_Options.UnitStyles["Custom" .. i]) do
		i = i + 1;
	end
	
	local style = self.style or "Default";
	self:CopyStyle(style, "Custom" .. i);
	
	self:EditStyle("Custom" .. i);
	
end

function OneRaid.UnitStyle:SaveAs()

	if (OneRaid_Options.UnitStyles[this:GetText()]) then 
		OneRaid:Print(ONERAID_UNIT_STYLE_EXISTS);
		return;
	elseif (this:GetText() == "") then
		return;
	end
	
	self:CopyStyle(self.style, this:GetText());
	
	if (self.style ~= "Default") then
		OneRaid_Options.UnitStyles[self.style] = nil;
	end
	
	self:EditStyle(this:GetText());	
	
	this:ClearFocus();

end

function OneRaid.UnitStyle:EditStyle(style)
	
	local options = OneRaid_Options.UnitStyles[style];
	
	OneRaid_UnitStyle_Frame_Header_Text:SetText(ONERAID_UNIT_STYLE_OPTIONS .. " - " .. style);
	OneRaid_UnitStyle_Frame_Unit.style = style;	
	
	OneRaid_UnitStyle_Frame_UnitStyles_DropDownText:SetText(style);
	OneRaid_UnitStyle_Frame_UnitStyles_SaveAs:SetText(style);
	
	self.style = style;
		
	self:UpdateOptions(1);
	
	self:LoadData(style);

	OneRaid_UnitStyle_Frame:Show();	
	
	self:RefreshPreview();
	
end

function OneRaid.UnitStyle:LoadDefaultStyles()

	for k, v in OneRaid_DefaultOptions.UnitStyles do
		OneRaid_Options.UnitStyles[k] = v;
	end

end
	
function OneRaid.UnitStyle:RefreshPreview(all)
	
	local f = OneRaid_UnitStyle_Frame_Unit;
	
	for i = f.numberBuffs + 1, OneRaid_Options.UnitStyles[self.style].numberBuffs do
		local b = CreateFrame("Button", f:GetName() .. "_Buff" .. i, f, "OneRaid_Buff_Template");
		b:SetScript("OnEnter", nil);
		b:SetScript("OnClick", nil);
		b:SetID(i);
	end
	f.numberBuffs = OneRaid_Options.UnitStyles[self.style].numberBuffs;
	
	OneRaid.Unit:LoadFrame(f, f.style);
	
	OneRaid.Unit:UpdateName(f);
	OneRaid.Unit:UpdateHealth(f);
	OneRaid.Unit:UpdateMana(f);
	--OneRaid.Unit:UpdateBuffs(f);
	OneRaid.Unit:UpdatePvp(f);
	OneRaid.Unit:UpdateVoice(f);
	OneRaid.Unit:UpdateTarget(f);
	
	OneRaid_UnitStyle_Frame:SetFrameLevel(0);
	OneRaid_UnitStyle_Frame_Preview:SetFrameLevel(0);
	f:SetFrameLevel(1);
	f:ClearAllPoints();
	f:SetPoint("CENTER", OneRaid_UnitStyle_Frame, "TOPRIGHT", -110, -80);
	f:Show();
	
	for i = 1, OneRaid_Options.UnitStyles[self.style].numberBuffs do
		getglobal("OneRaid_UnitStyle_Frame_Unit_Buff" .. i .. "_Border"):Show();
		getglobal("OneRaid_UnitStyle_Frame_Unit_Buff" .. i .. "_Count_FontString"):SetText(i);
	end
	
	local i = OneRaid_Options.UnitStyles[self.style].numberBuffs + 1
	while (getglobal("OneRaid_UnitStyle_Frame_Unit_Buff" .. i)) do
		getglobal("OneRaid_UnitStyle_Frame_Unit_Buff" .. i):Hide();
		i = i + 1;
	end
			
	OneRaid_UnitStyle_Frame_Unit:SetBackdropColor(0, 0, 0, .75);
	OneRaid_UnitStyle_Frame_Unit:SetBackdropBorderColor(0, 0, 0, 0);
	
	for k, v in OneRaid.Group.frames do
		if (not v.inactive and (v.style == self.style or all)) then
			if (OneRaid_Options.Groups[v.name].tankMonitor) then
				OneRaid.Group:DeactivateTankMonitorFrame(v.name);
			else
				OneRaid.Group:DeactivateFrame(v.name);
			end
			OneRaid.Group:CreateFrame(v.name, v.style);
		end
	end
	
end

function OneRaid.UnitStyle:LoadKeybinding(keybinding)

	self.keybinding = keybinding;
	self.keybindingType = OneRaid_Options.UnitStyles[self.style].keybindings[keybinding].type;
	
	OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_Keybindings_DropDownText:SetText(ONERAID_KEYBINDINGS_LIST[self.keybinding]);	
	
	self:EditKeybinding(self.keybindingType);

end

function OneRaid.UnitStyle:EditKeybinding(type)

	self.keybindingType = type;
	
	OneRaid_Options.UnitStyles[self.style].keybindings[self.keybinding].type = type;
	OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_KeybindingType_DropDownText:SetText(ONERAID_KEYBINDING_TYPE_LIST[self.keybindingType]);

	OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_AutoAttack:Hide();
	OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_SpellName:Hide();
	OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_SpellName_FontString:Hide();
	OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_Script_FontString:Hide();
	OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_Script:Hide();
	OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_Script_Background:Hide();

	if (type == 3) then
		OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_AutoAttack:SetChecked(OneRaid_Options.UnitStyles[self.style].keybindings[self.keybinding].attack);
		OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_AutoAttack:Show();
	elseif (type == 8) then
		OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_SpellName:SetText(OneRaid_Options.UnitStyles[self.style].keybindings[self.keybinding].spell or "");
		OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_SpellName:Show();
		OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_SpellName_FontString:Show();
		OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_Script_Text:SetFocus();
	elseif (type == 9) then		
		OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_Script_Text:SetText(OneRaid_Options.UnitStyles[self.style].keybindings[self.keybinding].script or "");
		OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_Script_FontString:Show();
		OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_Script:Show();
		OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_Script_Background:Show();
		OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_Script_Text:SetFocus();
	end

end

function OneRaid.UnitStyle:Keybinding_AutoAttack_OnClick()
	
	OneRaid_Options.UnitStyles[self.style].keybindings[self.keybinding].attack = this:GetChecked();
	
end

function OneRaid.UnitStyle:Keybinding_SpellName_OnTextChanged()

	OneRaid_Options.UnitStyles[self.style].keybindings[self.keybinding].spell = this:GetText();

end

function OneRaid.UnitStyle:Keybinding_Script_OnTextChanged()

	local scrollBar = getglobal(this:GetParent():GetName().."ScrollBar");
	
	this:GetParent():UpdateScrollChildRect();
	
	local min; local max; min, max = scrollBar:GetMinMaxValues();
	
	if (max > 0 and (this.max ~= max)) then
		this.max = max; scrollBar:SetValue(max);
	end
	
	OneRaid_Options.UnitStyles[self.style].keybindings[self.keybinding].script = this:GetText();

end

function OneRaid.UnitStyle:Element_OnClick(element, type)

	local settings = OneRaid_Options.UnitStyles[self.style][element];
	
	self.selectedElement = element;
	
	OneRaid_UnitStyle_Frame_FrameOptions_Header_Text:SetText(getglobal(this:GetName() .. "_Text"):GetText());
	
	if (element == "buffCount" or type == "frame") then
		OneRaid_UnitStyle_Frame_FrameOptions_FrameLevel:Hide();
	else
		OneRaid_UnitStyle_Frame_FrameOptions_FrameLevel_Level:SetText(settings.frameLevel);
		OneRaid_UnitStyle_Frame_FrameOptions_FrameLevel:Show();
	end
	
	if (type == "font" or type == "texture" or type == "buff" or type == "statusBar") then
		OneRaid_UnitStyle_Frame_FrameOptions_Position_XOffset:SetText(settings.x);
		OneRaid_UnitStyle_Frame_FrameOptions_Position_YOffset:SetText(settings.y);
		OneRaid_UnitStyle_Frame_FrameOptions_Position_Point_DropDownText:SetText(settings.point);
		OneRaid_UnitStyle_Frame_FrameOptions_Position_Relative_DropDownText:SetText(settings.relative);
		OneRaid_UnitStyle_Frame_FrameOptions_Position_Attach_DropDownText:SetText(settings.attach);
		OneRaid_UnitStyle_Frame_FrameOptions_Position_Attach_FontString:Show();
		OneRaid_UnitStyle_Frame_FrameOptions_Position_Attach_DropDown:Show();		
		OneRaid_UnitStyle_Frame_FrameOptions_Position:Show();
		OneRaid_UnitStyle_Frame_FrameOptions_Hide:Show();
		OneRaid_UnitStyle_Frame_FrameOptions_Size:ClearAllPoints();
		OneRaid_UnitStyle_Frame_FrameOptions_Size:SetPoint("TOP", OneRaid_UnitStyle_Frame_FrameOptions_Position, "BOTTOM", 0, 0);
		
	else
		OneRaid_UnitStyle_Frame_FrameOptions_Position:Hide();
		OneRaid_UnitStyle_Frame_FrameOptions_Hide:Hide();
		OneRaid_UnitStyle_Frame_FrameOptions_Size:ClearAllPoints();
		OneRaid_UnitStyle_Frame_FrameOptions_Size:SetPoint("TOPLEFT", OneRaid_UnitStyle_Frame_FrameOptions_Hide, "BOTTOMLEFT", 0, 0);
	end
	
	OneRaid_UnitStyle_Frame_FrameOptions_Size_Height:SetText(settings.height);
	OneRaid_UnitStyle_Frame_FrameOptions_Size_Width:SetText(settings.width);
	OneRaid_UnitStyle_Frame_FrameOptions_Size:Show();
	
	if (element == "healthBar") then
		OneRaid_UnitStyle_Frame_FrameOptions_Size_SoloHeight:SetText(settings.soloHeight);
		OneRaid_UnitStyle_Frame_FrameOptions_Size_SoloHeight_FontString:Show();
		OneRaid_UnitStyle_Frame_FrameOptions_Size_SoloHeight:Show();
		OneRaid_UnitStyle_Frame_FrameOptions_Size_DecreaseSoloHeight:Show();
		OneRaid_UnitStyle_Frame_FrameOptions_Size_IncreaseSoloHeight:Show();
		OneRaid_UnitStyle_Frame_FrameOptions_Size:SetHeight(95);
	else
		OneRaid_UnitStyle_Frame_FrameOptions_Size_SoloHeight_FontString:Hide();
		OneRaid_UnitStyle_Frame_FrameOptions_Size_SoloHeight:Hide();
		OneRaid_UnitStyle_Frame_FrameOptions_Size_DecreaseSoloHeight:Hide();
		OneRaid_UnitStyle_Frame_FrameOptions_Size_IncreaseSoloHeight:Hide();
		OneRaid_UnitStyle_Frame_FrameOptions_Size:SetHeight(75);
	end
	
	if (type == "font") then
		OneRaid_UnitStyle_Frame_FrameOptions_Font:SetPoint("TOP", OneRaid_UnitStyle_Frame_FrameOptions_Size, "BOTTOM", 0, 0);
		OneRaid_UnitStyle_Frame_FrameOptions_Font_File:SetText(settings.font);
		OneRaid_UnitStyle_Frame_FrameOptions_Font_File:SetScript("OnUpdate", function() self:ScrollLeft(); end);
		OneRaid_UnitStyle_Frame_FrameOptions_Font_Height:SetText(settings.fontHeight or "");
		OneRaid_UnitStyle_Frame_FrameOptions_Font_Outline:SetChecked(settings.outline);
		OneRaid_UnitStyle_Frame_FrameOptions_Font_ThickOutline:SetChecked(settings.thickOutline);
		OneRaid_UnitStyle_Frame_FrameOptions_Font_Monochrome:SetChecked(settings.monochrome);
		OneRaid_UnitStyle_Frame_FrameOptions_Font_JustifyH_DropDownText:SetText(settings.justifyH);
		OneRaid_UnitStyle_Frame_FrameOptions_Font_JustifyV_DropDownText:SetText(settings.justifyV);
		OneRaid_UnitStyle_Frame_FrameOptions_Font:Show();
		OneRaid_UnitStyle_Frame_FrameOptions_FrameLevel:SetPoint("TOP", OneRaid_UnitStyle_Frame_FrameOptions_Font, "BOTTOM", 0, 0);
	else
		OneRaid_UnitStyle_Frame_FrameOptions_Font:Hide();
	end
	
	if (type == "texture") then
		OneRaid_UnitStyle_Frame_FrameOptions_Texture_StatusBarAlpha:Hide();
		OneRaid_UnitStyle_Frame_FrameOptions_Texture_Opacity_Fontstring:Hide();
		OneRaid_UnitStyle_Frame_FrameOptions_Texture:SetHeight(55);
	elseif (type == "statusBar") then
		OneRaid_UnitStyle_Frame_FrameOptions_Texture_StatusBarAlpha:Show();
		OneRaid_UnitStyle_Frame_FrameOptions_Texture_Opacity_Fontstring:Show();
		OneRaid_UnitStyle_Frame_FrameOptions_Texture:SetHeight(90);
		OneRaid_UnitStyle_Frame_FrameOptions_Texture_StatusBarAlpha:SetValue(settings.statusBarAlpha);
	end
	
	if (type == "texture" or type == "statusBar") then
		OneRaid_UnitStyle_Frame_FrameOptions_Texture:SetPoint("TOP", OneRaid_UnitStyle_Frame_FrameOptions_Size, "BOTTOM", 0, 0);
		OneRaid_UnitStyle_Frame_FrameOptions_Texture_File:SetText(settings.texture);
		OneRaid_UnitStyle_Frame_FrameOptions_Texture_File:SetScript("OnUpdate", function() self:ScrollLeft(); end);
		OneRaid_UnitStyle_Frame_FrameOptions_Texture:Show();
		OneRaid_UnitStyle_Frame_FrameOptions_FrameLevel:SetPoint("TOP", OneRaid_UnitStyle_Frame_FrameOptions_Texture, "BOTTOM", 0, 0);
	else
		OneRaid_UnitStyle_Frame_FrameOptions_Texture:Hide();
	end
	
	if (type == "buff") then
		OneRaid_UnitStyle_Frame_FrameOptions_Buff_Growth_DropDownText:SetText(ONERAID_GROWTH_LIST[settings.growth]);
		OneRaid_UnitStyle_Frame_FrameOptions_Buff:Show();
		OneRaid_UnitStyle_Frame_FrameOptions_FrameLevel:SetPoint("TOP", OneRaid_UnitStyle_Frame_FrameOptions_Buff, "BOTTOM", 0, 0);
	else		
		OneRaid_UnitStyle_Frame_FrameOptions_Buff:Hide();
	end
	
	if (element == "buffCount") then
		OneRaid_UnitStyle_Frame_FrameOptions_Position_Attach_FontString:Hide();
		OneRaid_UnitStyle_Frame_FrameOptions_Position_Attach_DropDown:Hide();
		OneRaid_UnitStyle_Frame_FrameOptions_Position:SetHeight(125);
	else
		OneRaid_UnitStyle_Frame_FrameOptions_Position:SetHeight(150);
	end
	
	OneRaid_UnitStyle_Frame_FrameOptions_Hide:SetChecked(settings.hide);

	OneRaid_UnitStyle_Frame_FrameOptions_Options:Hide()
	OneRaid_UnitStyle_Frame_FrameOptions_Keybindings:Hide()
	OneRaid_UnitStyle_Frame_FrameOptions_TankMonitor:Hide();
	
end

function OneRaid.UnitStyle:LoadData(style)

	local options = OneRaid_Options.UnitStyles[style];
	
	OneRaid_UnitStyle_Frame_FrameOptions_Options_HideMana:SetChecked(options.hideMana);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_HideEnergy:SetChecked(options.hideEnergy);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_HideRage:SetChecked(options.hideRage);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_HideFocus:SetChecked(options.hideFocus);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_ShowBuffs:SetChecked(options.showBuffs);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_ShowDebuffs:SetChecked(options.showDebuffs);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_BuffNum:SetText(options.numberBuffs or 6);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_FlashOnLowHealth:SetChecked(options.flashOnLowHealth);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_FlashOnLowHealthNum:SetText(options.flashOnLowHealth or 20);
	
	OneRaid_UnitStyle_Frame_FrameOptions_Options_NameColorType_DropDownText:SetText(ONERAID_NAME_COLOR_TYPE_LIST[options.nameColorType]);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_HealthColorType_DropDownText:SetText(ONERAID_HEALTH_COLOR_TYPE_LIST[options.healthColorType]);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_HealthType_DropDownText:SetText(ONERAID_DISPLAY_TYPE_LIST[options.healthType]);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_ManaType_DropDownText:SetText(ONERAID_DISPLAY_TYPE_LIST[options.manaType]);	
	OneRaid_UnitStyle_Frame_FrameOptions_Options_BackgroundType_DropDownText:SetText(ONERAID_BACKGROUND_TYPE_LIST[options.backgroundType]);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_BorderType_DropDownText:SetText(ONERAID_BACKGROUND_TYPE_LIST[options.borderType]);

	--OneRaid_UnitStyle_Frame_FrameOptions_Options_StatusBarAlpha:SetValue(options.statusBarAlpha);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_DebuffAlpha:SetValue(options.debuffColorAlpha);
	
	OneRaid_UnitStyle_Frame_FrameOptions_Options_TargetColorNormalTexture:SetVertexColor(options.targetColor.r, options.targetColor.g, options.targetColor.b);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_HoverColorNormalTexture:SetVertexColor(options.hoverColor.r, options.hoverColor.g, options.hoverColor.b);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_PvpColorNormalTexture:SetVertexColor(options.pvpColor.r, options.pvpColor.g, options.pvpColor.b);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_HealthColorNormalTexture:SetVertexColor(options.healthColor.r, options.healthColor.g, options.healthColor.b);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_ManaColorNormalTexture:SetVertexColor(options.manaColor.r, options.manaColor.g, options.manaColor.b);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_EnergyColorNormalTexture:SetVertexColor(options.energyColor.r, options.energyColor.g, options.energyColor.b);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_RageColorNormalTexture:SetVertexColor(options.rageColor.r, options.rageColor.g, options.rageColor.b);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_FocusColorNormalTexture:SetVertexColor(options.focusColor.r, options.focusColor.g, options.focusColor.b);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_Range1ColorNormalTexture:SetVertexColor(options.range1Color.r, options.range1Color.g, options.range1Color.b);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_Range2ColorNormalTexture:SetVertexColor(options.range2Color.r, options.range2Color.g, options.range2Color.b);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_Range3ColorNormalTexture:SetVertexColor(options.range3Color.r, options.range3Color.g, options.range3Color.b);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_Range4ColorNormalTexture:SetVertexColor(options.range4Color.r, options.range4Color.g, options.range4Color.b);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_CloseColorNormalTexture:SetVertexColor(options.closeColor.r, options.closeColor.g, options.closeColor.b);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_MediumColorNormalTexture:SetVertexColor(options.mediumColor.r, options.mediumColor.g, options.mediumColor.b);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_FarColorNormalTexture:SetVertexColor(options.farColor.r, options.farColor.g, options.farColor.b);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_OORColorNormalTexture:SetVertexColor(options.oorColor.r, options.oorColor.g, options.oorColor.b);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_NameColorNormalTexture:SetVertexColor(options.nameColor.r, options.nameColor.g, options.nameColor.b);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_VoiceColorNormalTexture:SetVertexColor(options.voiceColor.r, options.voiceColor.g, options.voiceColor.b);
	
	OneRaid_UnitStyle_Frame_FrameOptions_Options_Range1ColorUseClassColor:SetChecked(options.range1ColorUseClassColor);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_Range2ColorUseClassColor:SetChecked(options.range2ColorUseClassColor);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_Range3ColorUseClassColor:SetChecked(options.range3ColorUseClassColor);
	OneRaid_UnitStyle_Frame_FrameOptions_Options_Range4ColorUseClassColor:SetChecked(options.range4ColorUseClassColor);
	
	OneRaid_UnitStyle_Frame_FrameOptions_TankMonitor_WarnSameTarget:SetChecked(options.warnSameTarget);
	OneRaid_UnitStyle_Frame_FrameOptions_TankMonitor_ShowTargetsTarget:SetChecked(options.showTargetsTarget);
	OneRaid_UnitStyle_Frame_FrameOptions_TankMonitor_ShowAggroGain:SetChecked(options.showAggroGain);
	OneRaid_UnitStyle_Frame_FrameOptions_TankMonitor_PlayAggroGain:SetChecked(options.playAggroGain);
	OneRaid_UnitStyle_Frame_FrameOptions_TankMonitor_ShowAggroLost:SetChecked(options.showAggroLost);
	OneRaid_UnitStyle_Frame_FrameOptions_TankMonitor_PlayAggroLost:SetChecked(options.playAggroLost);
	OneRaid_UnitStyle_Frame_FrameOptions_TankMonitor_WarningColorNormalTexture:SetVertexColor(options.warningColor.r, options.warningColor.g, options.warningColor.b);
	OneRaid_UnitStyle_Frame_FrameOptions_TankMonitor_TankedColorNormalTexture:SetVertexColor(options.tankedColor.r, options.tankedColor.g, options.tankedColor.b);
	OneRaid_UnitStyle_Frame_FrameOptions_TankMonitor_MAColorNormalTexture:SetVertexColor(options.maColor.r, options.maColor.g, options.maColor.b);
	
	OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_EnableBuffToggle:SetChecked(options.enableBuffToggle);
	--OneRaid_UnitStyle_Frame_FrameOptions_Keybindings_EnableLayoutToggle:SetChecked(options.enableLayoutToggle);
	
	self:LoadKeybinding(1);

end

function OneRaid.UnitStyle:UpdateOptions(fake, panel)

	OneRaid_UnitStyle_Frame_FrameOptions_Hide:Hide();
	OneRaid_UnitStyle_Frame_FrameOptions_Position:Hide();
	OneRaid_UnitStyle_Frame_FrameOptions_Size:Hide();
	OneRaid_UnitStyle_Frame_FrameOptions_Font:Hide();
	OneRaid_UnitStyle_Frame_FrameOptions_Texture:Hide();
	OneRaid_UnitStyle_Frame_FrameOptions_Buff:Hide();
	OneRaid_UnitStyle_Frame_FrameOptions_FrameLevel:Hide();
	OneRaid_UnitStyle_Frame_FrameOptions_Options:Hide()
	OneRaid_UnitStyle_Frame_FrameOptions_Keybindings:Hide()
	OneRaid_UnitStyle_Frame_FrameOptions_TankMonitor:Hide()
	
	if (panel == "options" or fake) then
		OneRaid_UnitStyle_Frame_FrameOptions_Header_Text:SetText(ONERAID_OPTIONS);
		OneRaid_UnitStyle_Frame_FrameOptions_Options:Show()
	elseif (panel == "keybindings") then
		OneRaid_UnitStyle_Frame_FrameOptions_Header_Text:SetText(ONERAID_KEYBINDINGS);
		OneRaid_UnitStyle_Frame_FrameOptions_Keybindings:Show()
	elseif (panel == "tankmonitor") then
		OneRaid_UnitStyle_Frame_FrameOptions_Header_Text:SetText(ONERAID_TANK_MONITOR);
		OneRaid_UnitStyle_Frame_FrameOptions_TankMonitor:Show()
	end
	
end

function OneRaid.UnitStyle:HideElement_OnClick()
	
	OneRaid_Options.UnitStyles[self.style][self.selectedElement].hide = this:GetChecked();
	self:RefreshPreview();
	
end

function OneRaid.UnitStyle:ScrollLeft()

  this:HighlightText(0,1);
  this:Insert(" " .. strsub(this:GetText(), 1, 1));
  this:HighlightText(0,1);
  this:Insert("");
  this:SetScript("OnUpdate", nil);

end

function OneRaid.UnitStyle:Keybinding_EnableBuffToggle_OnClick()

	OneRaid_Options.UnitStyles[self.style].enableBuffToggle = this:GetChecked();
	
end

function OneRaid.UnitStyle:CheckButton_OnClick(checkButton)

	if (checkButton ~= "flashOnLowHealth") then
		OneRaid_Options.UnitStyles[self.style][checkButton] = this:GetChecked();
	else
		if (this:GetChecked()) then
			OneRaid_Options.UnitStyles[self.style][checkButton] = tonumber(getglobal(this:GetName() .. "Num"):GetText() or 20);
		else
			OneRaid_Options.UnitStyles[self.style][checkButton] = nil;
		end
	end
	
	self:RefreshPreview();

end

function OneRaid.UnitStyle:TankMonitorOption_OnClick(option)

	OneRaid_Options.UnitStyles[self.style][option] = this:GetChecked();
	
	for k, v in OneRaid.Group.frames do
		if (not v.inactive) then
			if (OneRaid_Options.Groups[v.name].tankMonitor) then
				OneRaid.Group:DeactivateTankMonitorFrame(v.name);
				OneRaid.Group:CreateFrame(v.name, v.style);
			end
		end
	end

end

function OneRaid.UnitStyle:EditBox_OnAccept(edit)

	if (edit == "flashOnLowHealth") then
		if (this:GetText() == "" or not tonumber(this:GetText()) or tonumber(this:GetText()) < 0 or tonumber(this:GetText()) > 100) then
			this:SetText(OneRaid_Options.UnitStyles[self.style][edit] or 20);
		else
			if (OneRaid_Options.UnitStyles[self.style][edit]) then
				OneRaid_Options.UnitStyles[self.style][edit] = tonumber(this:GetText());
			end
		end
	elseif (edit == "numberBuffs") then
		if (this:GetText() == "" or not tonumber(this:GetText()) or tonumber(this:GetText()) < 0 or tonumber(this:GetText()) > 32) then
			this:SetText(OneRaid_Options.UnitStyles[self.style][edit] or 6);
		else
			if (OneRaid_Options.UnitStyles[self.style][edit]) then
				OneRaid_Options.UnitStyles[self.style][edit] = tonumber(this:GetText());
			end
		end
	end
	
	this:ClearFocus();
	
	self:RefreshPreview();

end

function OneRaid.UnitStyle:Slider_OnValueChange(slider)
	
	if (not OneRaid_Options) then return; end
	
	OneRaid_Options.UnitStyles[self.style][slider] = this:GetValue();
	
	local text;
	
	if (slider == "debuffColorAlpha") then
		text = ONERAID_DEBUFF_ALPHA
	end
	
	local val = string.format("%.2f", this:GetValue());
	getglobal(this:GetName() .. "Text"):SetText(text .. ": " .. val);
	
	OneRaid:Timer(.1, OneRaid.UnitStyle, "RefreshPreview");
	
end

function OneRaid.UnitStyle:StatusBarAlpha_OnValueChange()

	if (not self.style or not self.selectedElement) then return; end
	
	OneRaid_Options.UnitStyles[self.style][self.selectedElement].statusBarAlpha = this:GetValue();
	
	local val = string.format("%.2f", this:GetValue());
	getglobal(this:GetName() .. "Text"):SetText(val);
	
	OneRaid:Timer(.1, self, "RefreshPreview");
	
end

function OneRaid.UnitStyle:Position_ChangeXOffset(xChange)

	local edit = OneRaid_UnitStyle_Frame_FrameOptions_Position_XOffset;
	local x = OneRaid_Options.UnitStyles[self.style][self.selectedElement].x;
	
	if (xChange == "Increase") then
	
		if (IsShiftKeyDown()) then
			x = x + 10;
		else
			x = x + 1;
		end
	
	elseif (xChange == "Decrease") then
		
		if (IsShiftKeyDown()) then
			x = x - 10;
		else
			x = x - 1;
		end
		
	elseif (tonumber(xChange)) then
		
		x = tonumber(xChange);

	end	
		
	OneRaid_Options.UnitStyles[self.style][self.selectedElement].x = x;		
	self:RefreshPreview();
	
	edit:SetText(x);
	edit:ClearFocus();

end

function OneRaid.UnitStyle:Position_ChangeYOffset(yChange)

	local edit = OneRaid_UnitStyle_Frame_FrameOptions_Position_YOffset;
	local y = OneRaid_Options.UnitStyles[self.style][self.selectedElement].y;
	
	if (yChange == "Increase") then
	
		if (IsShiftKeyDown()) then
			y = y + 10;
		else
			y = y + 1;
		end
	
	elseif (yChange == "Decrease") then
		
		if (IsShiftKeyDown()) then
			y = y - 10;
		else
			y = y - 1;
		end
		
	elseif (tonumber(yChange)) then
		
		y = tonumber(yChange);

	end	
		
	OneRaid_Options.UnitStyles[self.style][self.selectedElement].y = y;		
	self:RefreshPreview();
	
	edit:SetText(y);
	edit:ClearFocus();

end

function OneRaid.UnitStyle:Size_ChangeHeight(heightChange)

	local edit = OneRaid_UnitStyle_Frame_FrameOptions_Size_Height;
	local height = OneRaid_Options.UnitStyles[self.style][self.selectedElement].height;
	
	if (heightChange == "Increase") then
	
		if (IsShiftKeyDown()) then
			height = height + 10;
		else
			height = height + 1;
		end
	
	elseif (heightChange == "Decrease") then
		
		if (IsShiftKeyDown()) then
			height = height - 10;
		else
			height = height - 1;
		end
		
	elseif (tonumber(heightChange)) then
		
		height = tonumber(heightChange);

	end
		
	OneRaid_Options.UnitStyles[self.style][self.selectedElement].height = height;
	self:RefreshPreview();

	edit:SetText(height);
	edit:ClearFocus();	

end

function OneRaid.UnitStyle:Level_Change(levelChange)

	local edit = OneRaid_UnitStyle_Frame_FrameOptions_FrameLevel_Level;
	local frameLevel = OneRaid_Options.UnitStyles[self.style][self.selectedElement].frameLevel;
	
	if (levelChange == "Increase") then
	
		if (IsShiftKeyDown()) then
			frameLevel = frameLevel + 10;
		else
			frameLevel = frameLevel + 1;
		end
	
	elseif (levelChange == "Decrease") then
		
		if (IsShiftKeyDown()) then
			frameLevel = frameLevel - 10;
		else
			frameLevel = frameLevel - 1;
		end
		
	elseif (tonumber(levelChange)) then
		
		frameLevel = tonumber(levelChange);

	end
		
	OneRaid_Options.UnitStyles[self.style][self.selectedElement].frameLevel = frameLevel;
	self:RefreshPreview();

	edit:SetText(frameLevel);
	edit:ClearFocus();	

end

function OneRaid.UnitStyle:Size_ChangeSoloHeight(heightChange)
	
	local edit = OneRaid_UnitStyle_Frame_FrameOptions_Size_SoloHeight;
	local soloHeight = OneRaid_Options.UnitStyles[self.style][self.selectedElement].soloHeight;
	
	if (heightChange == "Increase") then
	
		if (IsShiftKeyDown()) then
			soloHeight = soloHeight + 10;
		else
			soloHeight = soloHeight + 1;
		end
	
	elseif (heightChange == "Decrease") then
		
		if (IsShiftKeyDown()) then
			soloHeight = soloHeight - 10;
		else
			soloHeight = soloHeight - 1;
		end
		
	elseif (tonumber(heightChange)) then
		
		soloHeight = tonumber(heightChange);

	end
		
	OneRaid_Options.UnitStyles[self.style][self.selectedElement].soloHeight = soloHeight;
	self:RefreshPreview();

	edit:SetText(soloHeight);
	edit:ClearFocus();	

end

function OneRaid.UnitStyle:Size_ChangeWidth(widthChange)

	local edit = OneRaid_UnitStyle_Frame_FrameOptions_Size_Width;
	local width = OneRaid_Options.UnitStyles[self.style][self.selectedElement].width;
	
	if (widthChange == "Increase") then
	
		if (IsShiftKeyDown()) then
			width = width + 10;
		else
			width = width + 1;
		end
	
	elseif (widthChange == "Decrease") then
		
		if (IsShiftKeyDown()) then
			width = width - 10;
		else
			width = width - 1;
		end
		
	elseif (tonumber(widthChange)) then
		
		width = tonumber(widthChange);

	end	
		
	OneRaid_Options.UnitStyles[self.style][self.selectedElement].width = width;		
	self:RefreshPreview();
	
	edit:SetText(width);
	edit:ClearFocus();

end

function OneRaid.UnitStyle:Font_ChangeHeight(heightChange)
	
	local edit = OneRaid_UnitStyle_Frame_FrameOptions_Font_Height;
	local fontHeight = OneRaid_Options.UnitStyles[self.style][self.selectedElement].fontHeight or 10;
	
	if (heightChange == "Increase") then
	
		if (IsShiftKeyDown()) then
			fontHeight = fontHeight + 10;
		else
			fontHeight = fontHeight + 1;
		end
	
	elseif (heightChange == "Decrease") then
		
		if (IsShiftKeyDown()) then
			fontHeight = fontHeight - 10;
		else
			fontHeight = fontHeight - 1;
		end
		
	elseif (tonumber(heightChange)) then
		
		fontHeight = tonumber(heightChange);

	end
		
	OneRaid_Options.UnitStyles[self.style][self.selectedElement].fontHeight = fontHeight;
	self:RefreshPreview();

	edit:SetText(fontHeight);
	edit:ClearFocus();	

end

function OneRaid.UnitStyle:Font_Change()

	local font 			= OneRaid_UnitStyle_Frame_FrameOptions_Font_File:GetText();
	local size 			= OneRaid_UnitStyle_Frame_FrameOptions_Font_Height:GetText();
	local outline 		= OneRaid_UnitStyle_Frame_FrameOptions_Font_Outline:GetChecked();
	local thickOutline 	= OneRaid_UnitStyle_Frame_FrameOptions_Font_ThickOutline:GetChecked();
	local monochrome 	= OneRaid_UnitStyle_Frame_FrameOptions_Font_Monochrome:GetChecked();

	OneRaid_Options.UnitStyles[self.style][self.selectedElement].font = font;
	
	OneRaid_Options.UnitStyles[self.style][self.selectedElement].outline = outline;
	OneRaid_Options.UnitStyles[self.style][self.selectedElement].thickOutline = thickOutline;
	OneRaid_Options.UnitStyles[self.style][self.selectedElement].monochrome = monochrome;
	
	self:RefreshPreview();
	
	OneRaid_UnitStyle_Frame_FrameOptions_Font_Height:SetText(OneRaid_Options.UnitStyles[self.style][self.selectedElement].fontHeight or 10);
	
end

function OneRaid.UnitStyle:Texture_ChangeFile()

	local file = this:GetText();
	
	OneRaid_Options.UnitStyles[self.style][self.selectedElement].texture = file;
	
	self:RefreshPreview();
	
end

--------

function OneRaid.UnitStyle:NameColorType_DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:NameColorType_DropDown_Init(); end);
	UIDropDownMenu_SetButtonWidth(100);
	UIDropDownMenu_SetWidth(100);

end

function OneRaid.UnitStyle:NameColorType_DropDown_Init()
	
	if (not OneRaid_Options) then return; end
	
	local info = {};
	
	for index, value in ONERAID_NAME_COLOR_TYPE_LIST do
		info = {};
		info.text = value;
		info.arg1 = value;
		info.arg2 = index;
		if (index == OneRaid_Options.UnitStyles[self.style].nameColorType) then
			info.checked = 1;
		end
		info.func = function(arg1, arg2)
			OneRaid_UnitStyle_Frame_FrameOptions_Options_NameColorType_DropDownText:SetText(arg1);
			OneRaid_Options.UnitStyles[self.style].nameColorType = arg2;
			OneRaid.UnitStyle:RefreshPreview();
		end
		UIDropDownMenu_AddButton(info);
	end
	
end
	
function OneRaid.UnitStyle:HealthColorType_DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:HealthColorType_DropDown_Init(); end);
	UIDropDownMenu_SetButtonWidth(100);
	UIDropDownMenu_SetWidth(100);

end

function OneRaid.UnitStyle:HealthColorType_DropDown_Init()
	
	if (not OneRaid_Options) then return; end
	
	local info = {};
	
	for index, value in ONERAID_HEALTH_COLOR_TYPE_LIST do
		info = {};
		info.text = value;
		info.arg1 = value;
		info.arg2 = index;
		if (index == OneRaid_Options.UnitStyles[self.style].healthColorType) then
			info.checked = 1;
		end
		info.func = function(arg1, arg2)
			OneRaid_UnitStyle_Frame_FrameOptions_Options_HealthColorType_DropDownText:SetText(arg1);
			OneRaid_Options.UnitStyles[self.style].healthColorType = arg2;
			OneRaid.UnitStyle:RefreshPreview();
		end
		UIDropDownMenu_AddButton(info);
	end
	
end

function OneRaid.UnitStyle:HealthType_DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:HealthType_DropDown_Init(); end);
	UIDropDownMenu_SetButtonWidth(100);
	UIDropDownMenu_SetWidth(100);

end

function OneRaid.UnitStyle:HealthType_DropDown_Init()
	
	if (not OneRaid_Options) then return; end
	
	local info = {};
	
	for index, value in ONERAID_DISPLAY_TYPE_LIST do
		info = {};
		info.text = value;
		info.arg1 = value;
		info.arg2 = index;
		if (index == OneRaid_Options.UnitStyles[self.style].healthType) then
			info.checked = 1;
		end
		info.func = function(arg1, arg2)
			OneRaid_UnitStyle_Frame_FrameOptions_Options_HealthType_DropDownText:SetText(arg1);
			OneRaid_Options.UnitStyles[self.style].healthType = arg2;
			OneRaid.UnitStyle:RefreshPreview();
		end
		UIDropDownMenu_AddButton(info);
	end
	
end

function OneRaid.UnitStyle:ManaType_DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:ManaType_DropDown_Init(); end);
	UIDropDownMenu_SetButtonWidth(100);
	UIDropDownMenu_SetWidth(100);

end

function OneRaid.UnitStyle:ManaType_DropDown_Init()
	
	if (not OneRaid_Options) then return; end
	
	local info = {};
	
	for index, value in ONERAID_DISPLAY_TYPE_LIST do
		info = {};
		info.text = value;
		info.arg1 = value;
		info.arg2 = index;
		if (index == OneRaid_Options.UnitStyles[self.style].manaType) then
			info.checked = 1;
		end
		info.func = function(arg1, arg2)
			OneRaid_UnitStyle_Frame_FrameOptions_Options_ManaType_DropDownText:SetText(arg1);
			OneRaid_Options.UnitStyles[self.style].manaType = arg2;
			OneRaid.UnitStyle:RefreshPreview();
		end
		UIDropDownMenu_AddButton(info);
	end
	
end



function OneRaid.UnitStyle:BackgroundType_DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:BackgroundType_DropDown_Init(); end);
	UIDropDownMenu_SetButtonWidth(100);
	UIDropDownMenu_SetWidth(100);

end

function OneRaid.UnitStyle:BackgroundType_DropDown_Init()
	
	if (not OneRaid_Options) then return; end
	
	local info = {};
	
	for index, value in ONERAID_BACKGROUND_TYPE_LIST do
		info = {};
		info.text = value;
		info.arg1 = value;
		info.arg2 = index;
		if (index == OneRaid_Options.UnitStyles[self.style].backgroundType) then
			info.checked = 1;
		end
		info.func = function(arg1, arg2)
			OneRaid_UnitStyle_Frame_FrameOptions_Options_BackgroundType_DropDownText:SetText(arg1);
			OneRaid_Options.UnitStyles[self.style].backgroundType = arg2;
			OneRaid.UnitStyle:RefreshPreview();
		end
		UIDropDownMenu_AddButton(info);
	end
	
end

function OneRaid.UnitStyle:BorderType_DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:BorderType_DropDown_Init(); end);
	UIDropDownMenu_SetButtonWidth(100);
	UIDropDownMenu_SetWidth(100);

end

function OneRaid.UnitStyle:BorderType_DropDown_Init()
	
	if (not OneRaid_Options) then return; end
	
	local info = {};
	
	for index, value in ONERAID_BACKGROUND_TYPE_LIST do
		info = {};
		info.text = value;
		info.arg1 = value;
		info.arg2 = index;
		if (index == OneRaid_Options.UnitStyles[self.style].borderType) then
			info.checked = 1;
		end
		info.func = function(arg1, arg2)
			OneRaid_UnitStyle_Frame_FrameOptions_Options_BorderType_DropDownText:SetText(arg1);
			OneRaid_Options.UnitStyles[self.style].borderType = arg2;
			OneRaid.UnitStyle:RefreshPreview();
		end
		UIDropDownMenu_AddButton(info);
	end
	
end

function OneRaid.UnitStyle:Attach_DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:Attach_DropDown_Init(); end);
	UIDropDownMenu_SetButtonWidth(100);
	UIDropDownMenu_SetWidth(100);

end

function OneRaid.UnitStyle:Attach_DropDown_Init()
	
	if (not self.selectedElement) then return; end
	
	local list = { "Frame", "Name", "Status", "Health", "Mana", "HealthBar", "ManaBar", "Pvp", "Range", "Voice" };
	
	if (self.selectedElement == "buffCount") then
		list = { "Frame" };
	end
	
	local info = {};
	
	for index, value in list do
		if (strlower(value) ~= strlower(self.selectedElement)) then
			local info = {};
			info.text = value;
			info.arg1 = value;
			if (value == OneRaid_Options.UnitStyles[self.style][self.selectedElement].attach) then
				info.checked = 1;
			end
			info.func = function(arg1)
				OneRaid_Options.UnitStyles[self.style][self.selectedElement].attach = arg1;
				OneRaid_UnitStyle_Frame_FrameOptions_Position_Attach_DropDownText:SetText(arg1);
				self:RefreshPreview();		
			end
			UIDropDownMenu_AddButton(info);
		end
	end

end

function OneRaid.UnitStyle:Point_DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:Point_DropDown_Init(); end);
	UIDropDownMenu_SetButtonWidth(100);
	UIDropDownMenu_SetWidth(100);

end

function OneRaid.UnitStyle:Point_DropDown_Init()
	
	if (not self.selectedElement) then return; end
	
	local list = { "TOP", "TOPLEFT", "TOPRIGHT", "LEFT", "CENTER", "RIGHT", "BOTTOM", "BOTTOMLEFT", "BOTTOMRIGHT" };
	
	local info = {};
	
	for index, value in list do
		info = {};
		info.text = value;
		info.arg1 = value;
		if (value == OneRaid_Options.UnitStyles[self.style][self.selectedElement].point) then
			info.checked = 1;
		end
		info.func = function(arg1)
			OneRaid_Options.UnitStyles[self.style][self.selectedElement].point = arg1;
			OneRaid_UnitStyle_Frame_FrameOptions_Position_Point_DropDownText:SetText(arg1);
			self:RefreshPreview();			
		end
		UIDropDownMenu_AddButton(info);
	end

end

function OneRaid.UnitStyle:Relative_DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:Relative_DropDown_Init(); end);
	UIDropDownMenu_SetButtonWidth(100);
	UIDropDownMenu_SetWidth(100);

end

function OneRaid.UnitStyle:Relative_DropDown_Init()
	
	if (not self.selectedElement) then return; end
	
	local list = { "TOP", "TOPLEFT", "TOPRIGHT", "LEFT", "CENTER", "RIGHT", "BOTTOM", "BOTTOMLEFT", "BOTTOMRIGHT" };
	
	local info = {};
	
	for index, value in list do
		info = {};
		info.text = value;
		info.arg1 = value;
		if (value == OneRaid_Options.UnitStyles[self.style][self.selectedElement].relative) then
			info.checked = 1;
		end
		info.func = function(arg1)
			OneRaid_Options.UnitStyles[self.style][self.selectedElement].relative = arg1;
			OneRaid_UnitStyle_Frame_FrameOptions_Position_Relative_DropDownText:SetText(arg1);
			self:RefreshPreview();				
		end
		UIDropDownMenu_AddButton(info);
	end

end

function OneRaid.UnitStyle:JustifyH_DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:JustifyH_DropDown_Init(); end);
	UIDropDownMenu_SetButtonWidth(100);
	UIDropDownMenu_SetWidth(100);

end

function OneRaid.UnitStyle:JustifyH_DropDown_Init()
	
	if (not self.selectedElement) then return; end
	
	local list = { "LEFT", "CENTER", "RIGHT" };
	
	local info = {};
	
	for index, value in list do
		local info = {};
		info.text = value;
		info.arg1 = value;
		if (value == OneRaid_Options.UnitStyles[self.style][self.selectedElement].justifyH) then
			info.checked = 1;
		end
		info.func = function(arg1)
			OneRaid_Options.UnitStyles[self.style][self.selectedElement].justifyH = arg1;
			OneRaid_UnitStyle_Frame_FrameOptions_Font_JustifyH_DropDownText:SetText(arg1);
			self:RefreshPreview();	
		end
		UIDropDownMenu_AddButton(info);
	end

end

function OneRaid.UnitStyle:JustifyV_DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:JustifyV_DropDown_Init(); end);
	UIDropDownMenu_SetButtonWidth(100);
	UIDropDownMenu_SetWidth(100);

end

function OneRaid.UnitStyle:JustifyV_DropDown_Init()
	
	if (not self.selectedElement) then return; end
	
	local list = { "TOP", "MIDDLE", "BOTTOM" };
	
	local info = {};
	
	for index, value in list do
		info = {};
		info.text = value;
		info.arg1 = value;
		if (value == OneRaid_Options.UnitStyles[self.style][self.selectedElement].justifyV) then
			info.checked = 1;
		end
		info.func = function(arg1)
			OneRaid_Options.UnitStyles[self.style][self.selectedElement].justifyV = arg1;
			OneRaid_UnitStyle_Frame_FrameOptions_Font_JustifyV_DropDownText:SetText(arg1);
			self:RefreshPreview();			
		end
		UIDropDownMenu_AddButton(info);
	end

end

function OneRaid.UnitStyle:Growth_DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:Growth_DropDown_Init(); end);
	UIDropDownMenu_SetButtonWidth(100);
	UIDropDownMenu_SetWidth(100);

end

function OneRaid.UnitStyle:Growth_DropDown_Init()
	
	if (not self.selectedElement) then return; end
	
	local info = {};
	
	for index, value in ONERAID_GROWTH_LIST do
		info = {};
		info.text = value;
		info.arg1 = value;
		info.arg2 = index;
		if (index == OneRaid_Options.UnitStyles[self.style][self.selectedElement].growth) then
			info.checked = 1;
		end
		info.func = function(arg1, arg2)
			OneRaid_Options.UnitStyles[self.style][self.selectedElement].growth = arg2;
			OneRaid_UnitStyle_Frame_FrameOptions_Buff_Growth_DropDownText:SetText(arg1);
			self:RefreshPreview();
		end
		UIDropDownMenu_AddButton(info);
	end

end

function OneRaid.UnitStyle:UnitStyles_DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:UnitStyles_DropDown_OnLoad_DropDown_Init(); end);
	UIDropDownMenu_SetButtonWidth(100);
	UIDropDownMenu_SetWidth(100);

end

function OneRaid.UnitStyle:UnitStyles_DropDown_OnLoad_DropDown_Init()
	
	if (not OneRaid_Options) then return; end
	
	local list = {};
	for k, v in OneRaid_Options.UnitStyles do
		tinsert(list, k);
	end
	
	sort(list);

	for index, value in list do
		local info = {};
		info.text = value;
		info.arg1 = value;
		info.func = function(arg1)				
			self:EditStyle(arg1);
		end
		UIDropDownMenu_AddButton(info);
	end

end

function OneRaid.UnitStyle:Keybindings_DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:Keybindings_DropDown_Init(); end);
	UIDropDownMenu_SetButtonWidth(240);
	UIDropDownMenu_SetWidth(240);

end

function OneRaid.UnitStyle:Keybindings_DropDown_Init()
	
	if (not OneRaid_Options) then return; end
	
	local info = {};

	for index, value in ONERAID_KEYBINDINGS_LIST do
		info = {};
		info.text = value;
		info.arg1 = index;
		info.arg2 = value;
		info.func = function(arg1, arg2)			
			--self.keybinding = arg1;
			self:LoadKeybinding(arg1);
		end
		UIDropDownMenu_AddButton(info);
	end

end

function OneRaid.UnitStyle:KeybindingType_DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:KeybindingType_DropDown_Init(); end);
	UIDropDownMenu_SetButtonWidth(100);
	UIDropDownMenu_SetWidth(100);

end

function OneRaid.UnitStyle:KeybindingType_DropDown_Init()
	
	if (not OneRaid_Options) then return; end
	
	local info = {};

	for index, value in ONERAID_KEYBINDING_TYPE_LIST do
		info = {};
		info.text = value;
		info.arg1 = index;
		info.arg2 = value;
		info.func = function(arg1, arg2)
			--OneRaid_Options.UnitStyles[self.style].keybindings[self.keybinding].type = arg1;
			--self.keybindingType = arg1;
			--OneRaid_UnitStyle_Frame_Frame_FrameOptions_Keybindings_KeybindingType_DropDownText:SetText(arg2);
			self:EditKeybinding(arg1);
		end
		UIDropDownMenu_AddButton(info);
	end

end

function OneRaid.UnitStyle:Color_OnClick(color, opacity)

	local lColor = {};
	
	self.selectedColor = color;
	self.normalTexture = getglobal(this:GetName() .. "NormalTexture");
	
	if (not lColor) then
		lColor = { r = 1, g = 1, b = 1 };
	end

	lColor.r = OneRaid_Options.UnitStyles[self.style][color].r;
	lColor.g = OneRaid_Options.UnitStyles[self.style][color].g;
	lColor.b = OneRaid_Options.UnitStyles[self.style][color].b;
	
	lColor.swatchFunc = function() self:Color_SetColor(); end;
	lColor.cancelFunc = function() self:Color_CancelColor(opacity); end;
	lColor.opacityFunc = function() self:Color_SetOpacity(); end;
	
	if (opacity) then
		lColor.hasOpacity = 1;
		lColor.opacity = OneRaid_Options.UnitStyles[self.style][color].a or 0;
		lColor.opacity = 1 - lColor.opacity;
		lColor.opacityFunc = function() self:Color_SetOpacity(); end;
	end	
	
	CloseMenus();
	UIDropDownMenuButton_OpenColorPicker(lColor);

end

function OneRaid.UnitStyle:Color_SetColor()

	local r, g, b = ColorPickerFrame:GetColorRGB();

	OneRaid_Options.UnitStyles[self.style][self.selectedColor].r = r;
	OneRaid_Options.UnitStyles[self.style][self.selectedColor].g = g;
	OneRaid_Options.UnitStyles[self.style][self.selectedColor].b = b;

	self.normalTexture:SetVertexColor(r, g, b);
	
	self:RefreshPreview();

end

function OneRaid.UnitStyle:Color_SetOpacity()

	local a = 1 - OpacitySliderFrame:GetValue();

	OneRaid_Options.UnitStyles[self.style][self.selectedColor].a = a;
	
	self:RefreshPreview();

end

function OneRaid.UnitStyle:Color_CancelColor(opacity)

	OneRaid_Options.UnitStyles[self.style][self.selectedColor].r = ColorPickerFrame.previousValues.r;
	OneRaid_Options.UnitStyles[self.style][self.selectedColor].g = ColorPickerFrame.previousValues.g;
	OneRaid_Options.UnitStyles[self.style][self.selectedColor].b = ColorPickerFrame.previousValues.b;

	if (opacity) then
		OneRaid_Options.UnitStyles[self.style][self.selectedColor].a = 1 - ColorPickerFrame.previousValues.opacity;
	end

 	self.normalTexture:SetVertexColor(
 		OneRaid_Options.UnitStyles[self.style][self.selectedColor].r,
		OneRaid_Options.UnitStyles[self.style][self.selectedColor].g,
		OneRaid_Options.UnitStyles[self.style][self.selectedColor].b
 	);
 	
 	self:RefreshPreview();

end