local function gg(text)
	local ret = getglobal(text)
	if(not ret) then
		DEFAULT_CHAT_FRAME:AddMessage("|c00FF8800".."OzRaid: Failed to find: "..text);
	end
	return ret
end

OZ_BarTextures = {
					{"<none>",nil},
					{"Normal","Interface\\Addons\\OzRaid\\bar1"},
					{"Toplight","Interface\\Addons\\OzRaid\\bar2"},
					{"Glass","Interface\\Addons\\OzRaid\\bar3"},
					{"Textured Glass","Interface\\Addons\\OzRaid\\bar4"},
					{"Bubble Glass","Interface\\Addons\\OzRaid\\bar5"},
					{"Electro","Interface\\Addons\\OzRaid\\bar6"},
					{"Cross Texture","Interface\\Addons\\OzRaid\\bar7"},
					{"Ribbed","Interface\\Addons\\OzRaid\\bar8"},
					{"Narrow","Interface\\Addons\\OzRaid\\bar9"},
					{"Edged Fade","Interface\\Addons\\OzRaid\\bar10"},
					{"Edged Fade2","Interface\\Addons\\OzRaid\\bar11"},
				}

OZ_OptionsCurrentWindow = 1

OZ_OptionsCheckboxes={
						{ widget="OzRaidOptionsPresetsIsActive", text="Show Window", get=function()return OZ_Config[OZ_OptionsCurrentWindow].active;end, set=function(i) OZ_Config[OZ_OptionsCurrentWindow].active=i;end },
						{ widget="OzRaidOptionsPresetsToolTips", text="Show ToolTips", get=function()return OZ_Config[OZ_OptionsCurrentWindow].tooltips;end, set=function(i) OZ_Config[OZ_OptionsCurrentWindow].tooltips=i;end },
						{ widget="OzRaidOptionsPresetsLock",	 text="Lock Window", get=function()return OZ_Config[OZ_OptionsCurrentWindow].locked;end, set=function(i) OZ_Config[OZ_OptionsCurrentWindow].locked=i;end },
						{ widget="OzRaidOptionsPresetsHideParty",text="Hide Party Frames", get=function()return OZ_Config[1].hideparty;end, set=function(i) OZ_Config[1].hideparty=i;end },
						{ widget="OzRaidOptionsPresetsMiniIcon", text="Minimap Icon", get=function()return OZ_Config.minimapShow;end, set=function(i) OZ_Config.minimapShow=i;end },

						{ widget="OzRaidOptionsFiltersCheck1", text="Group 1", get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.group[1];end, set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.group[1]=i;end },
						{ widget="OzRaidOptionsFiltersCheck2", text="Group 2", get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.group[2];end, set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.group[2]=i;end },
						{ widget="OzRaidOptionsFiltersCheck3", text="Group 3", get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.group[3];end, set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.group[3]=i;end },
						{ widget="OzRaidOptionsFiltersCheck4", text="Group 4", get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.group[4];end, set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.group[4]=i;end },
						{ widget="OzRaidOptionsFiltersCheck5", text="Group 5", get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.group[5];end, set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.group[5]=i;end },
						{ widget="OzRaidOptionsFiltersCheck6", text="Group 6", get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.group[6];end, set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.group[6]=i;end },
						{ widget="OzRaidOptionsFiltersCheck7", text="Group 7", get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.group[7];end, set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.group[7]=i;end },
						{ widget="OzRaidOptionsFiltersCheck8", text="Group 8", get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.group[8];end, set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.group[8]=i;end },

						{ widget="OzRaidOptionsFiltersCheck9",	text="Druid",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.class.DRUID;	end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.class.DRUID=i;end },
						{ widget="OzRaidOptionsFiltersCheck10", text="Hunter",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.class.HUNTER;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.class.HUNTER=i;end },
						{ widget="OzRaidOptionsFiltersCheck11", text="Mage",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.class.MAGE;	end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.class.MAGE=i;end },
						{ widget="OzRaidOptionsFiltersCheck12", text="Priest",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.class.PRIEST;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.class.PRIEST=i;end },
						{ widget="OzRaidOptionsFiltersCheck13", text="Paladin",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.class.PALADIN;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.class.PALADIN=i;end },
						{ widget="OzRaidOptionsFiltersCheck14", text="Rogue",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.class.ROGUE;	end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.class.ROGUE=i;end },
						{ widget="OzRaidOptionsFiltersCheck15", text="Shaman",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.class.SHAMAN;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.class.SHAMAN=i;end },
						{ widget="OzRaidOptionsFiltersCheck16", text="Warlock", get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.class.WARLOCK;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.class.WARLOCK=i;end },
						{ widget="OzRaidOptionsFiltersCheck17", text="Warrior", get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.class.WARRIOR;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.class.WARRIOR=i;end },

						{ widget="OzRaidOptionsFiltersCheck18", text="Healthy",		get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.status.healthy;	end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.status.healthy=i;end },
						{ widget="OzRaidOptionsFiltersCheck19", text="Injured",		get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.status.injured;	end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.status.injured=i;end },
						{ widget="OzRaidOptionsFiltersCheck20", text="Buffed",		get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.status.buffed;	end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.status.buffed=i;end },
						{ widget="OzRaidOptionsFiltersCheck21", text="Not Buffed",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.status.notbuffed;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.status.notbuffed=i;end },
						{ widget="OzRaidOptionsFiltersCheck22", text="Curable",		get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.status.curable;	end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.status.curable=i;end },
						{ widget="OzRaidOptionsFiltersCheck23", text="Not Curable",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.status.notcurable;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.status.notcurable=i;end },
						{ widget="OzRaidOptionsFiltersCheck24", text="<11 yards",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.status.close;end,		set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.status.close=i;end },
						{ widget="OzRaidOptionsFiltersCheck25", text="11-30 yards",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.status.inrange;end,		set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.status.inrange=i;end },
						{ widget="OzRaidOptionsFiltersCheck26", text=">30 yards",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.status.outofrange;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.status.outofrange=i;end },

						{ widget="OzRaidOptionsFiltersCheck27", text="Dead",		get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.status.dead;end,			set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.status.dead=i;end },
						{ widget="OzRaidOptionsFiltersCheck28", text="Offline",		get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.status.offline;	end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.status.offline=i;end },
						{ widget="OzRaidOptionsFiltersCheck29", text="Online",		get=function()return OZ_Config[OZ_OptionsCurrentWindow].filter.status.online;	end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].filter.status.online=i;end },

						{ widget="OzRaidOptionsSortsCheck1", text="Show Headings",},
						{ widget="OzRaidOptionsSortsCheck2", text="Show Headings",},
						{ widget="OzRaidOptionsSortsCheck3", text="Hide Aggro Glow",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].hideGlow;	end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].hideGlow=i;end },

						{ widget="OzRaidOptionsDisplayCheck1", text="Left",},
						{ widget="OzRaidOptionsDisplayCheck2", text="On Bar",},
						{ widget="OzRaidOptionsDisplayCheck3", text="Right",},
						{ widget="OzRaidOptionsDisplayCheck4", text="Left",},
						{ widget="OzRaidOptionsDisplayCheck5", text="On Bar",},
						{ widget="OzRaidOptionsDisplayCheck6", text="Right",},
						{ widget="OzRaidOptionsDisplayCheck7", text="Big Icons",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].buffSize;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].buffSize=i;end },
						{ widget="OzRaidOptionsDisplayCheck8", text="Colour Name",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].classNames;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].classNames=i;end },
						{ widget="OzRaidOptionsDisplayCheck9", text="Outline",		get=function()return OZ_Config[OZ_OptionsCurrentWindow].outlineNames;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].outlineNames=i;end },
						{ widget="OzRaidOptionsDisplayCheck10", text="Fade on Range", get=function()return OZ_Config[OZ_OptionsCurrentWindow].rangeFade;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].rangeFade=i;end },
						{ widget="OzRaidOptionsDisplayCheck11", text="Off",},
						{ widget="OzRaidOptionsDisplayCheck12", text="Left",},
						{ widget="OzRaidOptionsDisplayCheck13", text="Centre",},
						{ widget="OzRaidOptionsDisplayCheck14", text="Right1",},
						{ widget="OzRaidOptionsDisplayCheck15", text="Right2",},
						{ widget="OzRaidOptionsDisplayCheck16", text="Value",},
						{ widget="OzRaidOptionsDisplayCheck17", text="Percent",},
						{ widget="OzRaidOptionsDisplayCheck18", text="Deficit",},
						{ widget="OzRaidOptionsDisplayCheck19", text="Red on Dead",			get=function()return OZ_Config[OZ_OptionsCurrentWindow].nameOnStatus;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].nameOnStatus=i;end },
						{ widget="OzRaidOptionsDisplayCheck20", text="Debuff Colour",		get=function()return OZ_Config[OZ_OptionsCurrentWindow].barDebuffCol;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].barDebuffCol=i;end },
						{ widget="OzRaidOptionsDisplayCheck21", text="Show Debuff Icon",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].showDebuffIcon;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].showDebuffIcon=i;end },
						{ widget="OzRaidOptionsDisplayCheck22", text="Centre",},
						{ widget="OzRaidOptionsDisplayCheck23", text="Hide Icon",			get=function()return OZ_Config[OZ_OptionsCurrentWindow].hideIcon;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].hideIcon=i;end },
						{ widget="OzRaidOptionsGeneralHideTitle", text="Hide title bar",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].hideTitle;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].hideTitle=i;end },
						{ widget="OzRaidOptionsGeneralHideBG", text="Hide Background",		get=function()return OZ_Config[OZ_OptionsCurrentWindow].hideBG;end,		set=function(i) OZ_Config[OZ_OptionsCurrentWindow].hideBG=i;end },
						{ widget="OzRaidOptionsGeneralHideEmpty", text="Hide when empty",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].hideEmpty;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].hideEmpty=i;end },
						{ widget="OzRaidOptionsGeneralHideSolo", text="Hide when solo",		get=function()return OZ_Config[OZ_OptionsCurrentWindow].hideSolo;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].hideSolo=i;end },
						{ widget="OzRaidOptionsGeneralHideParty", text="Hide in party",		get=function()return OZ_Config[OZ_OptionsCurrentWindow].hideParty;end,	set=function(i) OZ_Config[OZ_OptionsCurrentWindow].hideParty=i;end },
						{ widget="OzRaidOptionsGeneralHideButtons", text="Hide buttons",	get=function()return OZ_Config[OZ_OptionsCurrentWindow].hideButtons;end,set=function(i) OZ_Config[OZ_OptionsCurrentWindow].hideButtons=i;end },
					};

OZ_SLIDERS = {
	{
		widget = "OzRaidOptionsPresetsMiniAngle",
		get = function()return OZ_Config.minimapAngle;end,
		set = function(i)OZ_Config.minimapAngle = i;end,
		text = "Minimap Ang. (%d):",
	},
	{
		widget = "OzRaidOptionsPresetsMiniDist",
		get = function()return OZ_Config.minimapDist;end,
		set = function(i)OZ_Config.minimapDist = i;end,
		text = "Minimap Dist. (%d):",
	},
	{
		widget = "OzRaidOptionsInputsSlider",
		get = function()return OZ_Config[OZ_OptionsCurrentWindow].filter.injuredVal;end,
		set = function(i)OZ_Config[OZ_OptionsCurrentWindow].filter.injuredVal = i;end,
		text = "Healthy/Injured Cutoff (%d%%):",
		textScale = 100,
	},
	{
		widget = "OzRaidOptionsGeneralButtonSize",
		get = function()return OZ_Config[OZ_OptionsCurrentWindow].buttonSize;end,
		set = function(i)OZ_Config[OZ_OptionsCurrentWindow].buttonSize = i;end,
		text = "Icon Size (%d px):",
	},
	{
		widget = "OzRaidOptionsGeneralTitleSize",
		get = function()return OZ_Config[OZ_OptionsCurrentWindow].titleHeight;end,
		set = function(i)OZ_Config[OZ_OptionsCurrentWindow].titleHeight = i;end,
		text = "Title Height (%d px):",
	},
	{
		widget = "OzRaidOptionsGeneralBarWidth",
		get = function()return OZ_Config[OZ_OptionsCurrentWindow].width;end,
		set = function(i)OZ_Config[OZ_OptionsCurrentWindow].width = i;end,
		text = "Bar Width (%d px):",
	},
	{
		widget = "OzRaidOptionsGeneralBarHeight",
		get = function()return OZ_Config[OZ_OptionsCurrentWindow].barHeight;end,
		set = function(i)OZ_Config[OZ_OptionsCurrentWindow].barHeight = i;end,
		text = "Bar Height (%d px):",
	},
	{
		widget = "OzRaidOptionsGeneralTextSize",
		get = function()return OZ_Config[OZ_OptionsCurrentWindow].textSize;end,
		set = function(i)OZ_Config[OZ_OptionsCurrentWindow].textSize = i;end,
		text = "Text Size (%d px):",
	},
	{
		widget = "OzRaidOptionsGeneralMinBars",
		get = function()return OZ_Config[OZ_OptionsCurrentWindow].minBars;end,
		set = function(i)OZ_Config[OZ_OptionsCurrentWindow].minBars = i;end,
		text = "Min. Bars (%d):",
	},
	{
		widget = "OzRaidOptionsGeneralMaxBars",
		get = function()return OZ_Config[OZ_OptionsCurrentWindow].maxBars;end,
		set = function(i)OZ_Config[OZ_OptionsCurrentWindow].maxBars = i;end,
		text = "Max. Bars (%d):",
	},
	{
		widget = "OzRaidOptionsGeneralRefresh",
		get = function()return OZ_Config[OZ_OptionsCurrentWindow].refresh;end,
		set = function(i)OZ_Config[OZ_OptionsCurrentWindow].refresh = i;end,
		text = "Refresh (%1.1fs):",
	},
};


local function UglyScrollLeft()
  this:HighlightText(0,1);
  this:Insert(" "..strsub(this:GetText(),1,1));
  this:HighlightText(0,1);
  this:Insert("");
  this:SetScript("OnUpdate", nil);
end
 
function OZ_OptionsInit()
	OzRaidOptionsTitleString:SetText( string.format("OzRaid v%1.2f",OZ_CURRENT_VERSION) );

	PanelTemplates_SetNumTabs(OzRaidOptions, table.getn(OZ_OptionsPanes) );
	OzRaidOptions.selectedTab=1;
	PanelTemplates_UpdateTabs(OzRaidOptions);

--	DumpHierarchy(OzRaidOptions, 2)
--	DumpHierarchy(OzRaidBuffsScrollEntry1, 6)
	-- Setup Presets
	OzRaidOptionsPresetsTitleHeadingText:SetText("Window title:")
	OzRaidOptionsPresetsApply:Disable()

	OzRaidOptionsInputsHeadingText:SetText("Select Input:")

	for key,value in ipairs(OZ_OptionsCheckboxes) do
		gg( value.widget.."ButtonText" ):SetJustifyH("LEFT")
		gg( value.widget.."ButtonText" ):SetText( value.text )
	end

	OzRaidOptionsSortsHeading1Text:SetText("Select Sorts:")
	OzRaidOptionsSortsHeading2Text:SetText("Bar Display Options:")
	OzRaidOptionsSortsHeading3Text:SetText("Texture")

	OzRaidOptionsDisplayCheck1HeadingText:SetText("Name position:")
	OzRaidOptionsDisplayCheck4HeadingText:SetText("Buff position:")
	OzRaidOptionsDisplayCheck11HeadingText:SetText("Number position:")

	local _, value, widget, n
	for _,value in ipairs(OZ_SLIDERS) do
		local widget = gg(value.widget)
		if(widget)then
			gg(value.widget.."Low"):SetText(nil)
			gg(value.widget.."High"):SetText(nil)
		end
	end	
end

local OZ_CurrentWindowText = ""


function OZ_ReadSliders()
	local _, value, widget, n
	for _,value in ipairs(OZ_SLIDERS) do
		local widget = gg(value.widget)
		if(widget)then
			n = widget:GetValue()
			value.set(n)
			if(value.textScale)then
				n = n * value.textScale
			end
			gg(value.widget.."Text"):SetText( string.format( value.text, n ) )
		end
	end
end
function OZ_SetSliders()
	local _, value, widget, n
	for _,value in ipairs(OZ_SLIDERS) do
		local widget = gg(value.widget)
		if(widget)then
			widget:SetValue(value.get())
		end
	end
end

function OZ_CheckVisibility(n)
	local window = OZ_GetWindowArray(n)
	local config = OZ_Config[n]
	if( ((config.hideSolo)and(OZ_RaidRoster.solo)) or
		((config.hideParty)and(OZ_RaidRoster.inParty)) )then
		if( window.frame:IsVisible() )then
				window.frame:Hide()
		end
		return
	end

	if( window.frame:IsVisible() )then
		if( (not config.active) or
			( config.hideEmpty and (OZ_Bars[n].nBars == 0)) )then
			window.frame:Hide()
		end
	else
		if( (config.active) and
			((not config.hideEmpty) or (OZ_Bars[n].nBars > 0)) )then
			window.frame:Show()
		end
	end
end

function OZ_OptionsSetConfigFromOptions()
	local a,b,i
	local config = OZ_Config[OZ_OptionsCurrentWindow]
if(not config)then
	DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."Error - no config data for window "..OZ_OptionsCurrentWindow)	
	return
end
	config.text = OzRaidOptionsPresetsTitleName:GetText();
	if(OZ_CurrentWindowText ~= config.text) then
		OZ_OptionsWindow:Hide()
		OZ_OptionsWindow:Show()
		OZ_CurrentWindowText = config.text
	end

	OZ_ReadSliders()

	-- Inputs
	a = UIDropDownMenu_GetSelectedValue(OZ_InputsCombo1)
	config.input = a

	-- Filters
	for key,value in ipairs(OZ_OptionsCheckboxes) do
		if(value.set) then
			value.set(gg(value.widget.."Button"):GetChecked())
		end
	end

	-- Sorts
	config.heading[1] = 0
	config.heading[2] = 0
	config.heading[3] = 0

	b = 1
	a = UIDropDownMenu_GetSelectedValue(OZ_SortCombo1)
	config.sort1 = a
	if( OzRaidOptionsSortsCheck1Button:GetChecked() )then
		config.heading[b] = a
		b = b + 1
	end
	a = UIDropDownMenu_GetSelectedValue(OZ_SortCombo2)
	config.sort2 = a
	if( OzRaidOptionsSortsCheck2Button:GetChecked() )then
		config.heading[b] = a
		b = b + 1
	end

	
	-- Setup headings functions
	if( OzRaidOptionsDisplayCheck1Button:GetChecked() )then
		config.namePos = 2
	elseif( OzRaidOptionsDisplayCheck2Button:GetChecked() )then
		config.namePos = 1
	elseif( OzRaidOptionsDisplayCheck3Button:GetChecked() )then
		config.namePos = 3
	else
		config.namePos = 4
	end

	-- Setup buff functions
	if( OzRaidOptionsDisplayCheck4Button:GetChecked() )then
		config.buffPos = 2
	elseif( OzRaidOptionsDisplayCheck5Button:GetChecked() )then
		config.buffPos = 1
	else
		config.buffPos = 3
	end

	-- Setup number functions
	if( OzRaidOptionsDisplayCheck11Button:GetChecked() )then
		config.valuePos = nil
	elseif( OzRaidOptionsDisplayCheck12Button:GetChecked() )then
		config.valuePos = 1
	elseif( OzRaidOptionsDisplayCheck13Button:GetChecked() )then
		config.valuePos = 2
	elseif( OzRaidOptionsDisplayCheck14Button:GetChecked() )then
		config.valuePos = 3
	else
		config.valuePos = 4
	end
	if( OzRaidOptionsDisplayCheck16Button:GetChecked() )then
		config.valueType = 1
	elseif( OzRaidOptionsDisplayCheck17Button:GetChecked() )then
		config.valueType = 2
	else
		config.valueType = 3
	end

	-- Apply formating
	for i=1,40 do
		OZ_FormatRow(OZ_OptionsCurrentWindow,i)
--		OZ_ShowBuffs(OZ_OptionsCurrentWindow,i)
	end

	-- reset all the text sizes
	bw = OzRaidOptionsGeneralTextSize:GetValue()
	local window = OZ_GetWindowArray(OZ_OptionsCurrentWindow)
	window.nameText:SetFont(STANDARD_TEXT_FONT,bw)
	for i=1,40 do
		window.bar[i].headerText:SetFont(STANDARD_TEXT_FONT,bw)
		if( config.outlineNames )then
			window.bar[i].nameText:SetFont(STANDARD_TEXT_FONT,bw,"OUTLINE")
			window.bar[i].valueText:SetFont(STANDARD_TEXT_FONT,bw,"OUTLINE")
		else
			window.bar[i].nameText:SetFont(STANDARD_TEXT_FONT,bw)
			window.bar[i].valueText:SetFont(STANDARD_TEXT_FONT,bw)
		end
	end

	OZ_ConfigTitleBar(OZ_OptionsCurrentWindow)
	OZ_SetMinimapPos()

	OZ_CheckVisibility(OZ_OptionsCurrentWindow)
end


function OZ_OptionsSetOptionsFromConfig(n)
	local a,b
	local config = OZ_Config[n]
	OZ_OptionsCurrentWindow = n
if(not config)then
	DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."Error - no config data for window "..OZ_OptionsCurrentWindow)	
	return
end

	OzRaidOptionsPresetsTitleName:SetText(config.text);
	OzRaidOptionsPresetsTitleName:SetScript("OnUpdate", UglyScrollLeft);

	-- Inputs
	UIDropDownMenu_SetSelectedValue(OZ_InputsCombo1, config.input)

	-- Filters
	for key,value in ipairs(OZ_OptionsCheckboxes) do
		if(value.get)then
			gg(value.widget.."Button"):SetChecked(value.get())
		end
	end
	
	-- Sorts
	UIDropDownMenu_SetSelectedValue(OZ_SortCombo1, config.sort1)
	b = 1
	if( config.heading[b] == config.sort1)then
		b = b + 1
		OzRaidOptionsSortsCheck1Button:SetChecked(1)
	else
		OzRaidOptionsSortsCheck1Button:SetChecked(nil)
	end

	UIDropDownMenu_SetSelectedValue(OZ_SortCombo2, config.sort2)
	if( config.heading[b] == config.sort2)then
		b = b + 1
		OzRaidOptionsSortsCheck2Button:SetChecked(1)
	else
		OzRaidOptionsSortsCheck2Button:SetChecked(nil)
	end
	
	local found
	for key,value in ipairs(OZ_BarTextures) do
		if(value[2] == config.barTexture)then
			UIDropDownMenu_SetSelectedValue(OZ_TextureCombo,key)
			found = 1
			break
		end
	end
	if(not found) then
		UIDropDownMenu_SetSelectedValue(OZ_TextureCombo,1)
	end

	-- Setup headings functions
	if(config.namePos == 2)then
		OzRaidOptionsDisplayCheck1Button:SetChecked(1)
		OzRaidOptionsDisplayCheck2Button:SetChecked(nil)
		OzRaidOptionsDisplayCheck3Button:SetChecked(nil)
		OzRaidOptionsDisplayCheck22Button:SetChecked(nil)
	elseif(config.namePos == 1)then
		OzRaidOptionsDisplayCheck1Button:SetChecked(nil)
		OzRaidOptionsDisplayCheck2Button:SetChecked(1)
		OzRaidOptionsDisplayCheck3Button:SetChecked(nil)
		OzRaidOptionsDisplayCheck22Button:SetChecked(nil)
	elseif(config.namePos == 3)then
		OzRaidOptionsDisplayCheck1Button:SetChecked(nil)
		OzRaidOptionsDisplayCheck2Button:SetChecked(nil)
		OzRaidOptionsDisplayCheck3Button:SetChecked(1)
		OzRaidOptionsDisplayCheck22Button:SetChecked(nil)
	else
		OzRaidOptionsDisplayCheck1Button:SetChecked(nil)
		OzRaidOptionsDisplayCheck2Button:SetChecked(nil)
		OzRaidOptionsDisplayCheck3Button:SetChecked(nil)
		OzRaidOptionsDisplayCheck22Button:SetChecked(1)
	end

	-- Setup buff functions
	if(config.buffPos == 2)then
		OzRaidOptionsDisplayCheck4Button:SetChecked(1)
		OzRaidOptionsDisplayCheck5Button:SetChecked(nil)
		OzRaidOptionsDisplayCheck6Button:SetChecked(nil)
	elseif(config.buffPos == 1)then
		OzRaidOptionsDisplayCheck4Button:SetChecked(nil)
		OzRaidOptionsDisplayCheck5Button:SetChecked(1)
		OzRaidOptionsDisplayCheck6Button:SetChecked(nil)
	else
		OzRaidOptionsDisplayCheck4Button:SetChecked(nil)
		OzRaidOptionsDisplayCheck5Button:SetChecked(nil)
		OzRaidOptionsDisplayCheck6Button:SetChecked(1)
	end
	
	if(config.valuePos)then
		Oz_RaidDisplayCheckClick( 11 + config.valuePos )
	else
		Oz_RaidDisplayCheckClick( 11 )
	end
	Oz_RaidDisplayCheckClick( 15 + config.valueType )

	-- General options
	OZ_SetSliders()

	OZ_SetMinimapPos()
end

function OZ_OptionsReset()
	OZ_SetupConfig(OZ_OptionsCurrentWindow)
	OZ_OptionsSetOptionsFromConfig(OZ_OptionsCurrentWindow)
end


		




---------------------------------------------------------
--
--  PRESETS PANEL - DROPDOWN SETUP
--
---------------------------------------------------------
OZ_Presets1_Val = "GENERAL"
OZ_Presets2_Val = "Raid View"

function OZ_PresetsCombo1_OnLoad()
	UIDropDownMenu_Initialize(this, OZ_PresetsCombo1_Initialize); 
	UIDropDownMenu_SetWidth(120,this)
	UIDropDownMenu_SetSelectedValue(this, OZ_Presets1_Val);
end

function OZ_PresetsCombo1_Initialize()
	OZ_Presets1_Val = nil
	for key,val in pairs(OZ_PRESETS) do
		if( not OZ_Presets1_Val )then
			OZ_Presets1_Val = key
		end
		UIDropDownMenu_AddButton{value = key , text = key, func = OZ_PresetsCombo1_Pressed}
	end
end 

function OZ_PresetsCombo1_Pressed() 
	UIDropDownMenu_SetSelectedValue(OZ_PresetsCombo1,this.value)
	OZ_Presets1_Val = this.value
	OZ_PresetsCombo2:Hide()
	OZ_PresetsCombo2:Show()
end 


function OZ_PresetsCombo2_OnLoad() 
	UIDropDownMenu_Initialize(this, OZ_PresetsCombo2_Initialize2); 
	UIDropDownMenu_SetWidth(120,this)
	UIDropDownMenu_SetSelectedValue(this, OZ_Presets2_Val);
end

function OZ_PresetsCombo2_Initialize2() 
	OZ_Presets2_Val = nil
	for key,val in pairs(OZ_PRESETS[OZ_Presets1_Val]) do
		if( not OZ_Presets2_Val )then
			OZ_Presets2_Val = key
		end
		UIDropDownMenu_AddButton{value = key , text = key , func = OZ_PresetsCombo2_Pressed}
	end
end 

function OZ_PresetsCombo2_Pressed() 
	UIDropDownMenu_SetSelectedValue(OZ_PresetsCombo2,this.value)
	OZ_Presets2_Val = this.value
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."OzRaid: Table2="..OZ_Presets2_Val);
end 

function OZ_PresetApply()
	OZ_Config[OZ_OptionsCurrentWindow] = {}
	OZ_Config[OZ_OptionsCurrentWindow] = OZ_PRESETS[OZ_Presets1_Val][OZ_Presets2_Val]
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."Setting preset to: "..OZ_Presets1_Val.."-"..OZ_Presets2_Val);
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."name = "..OZ_Config[OZ_OptionsCurrentWindow].text);
	OZ_OptionsSetOptionsFromConfig(OZ_OptionsCurrentWindow);
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."Options set");
	OZ_OptionsSetConfigFromOptions();
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."Config set set");
end

---------------------------------------------------------
--
--  OPTIONS SCREEN - TABS SET UP
--
---------------------------------------------------------
function OZ_HideOptions()
	OzRaidOptions:Hide()
end

OZ_OptionsPanes =	{
						"OzRaidOptionsPresets",
						"OzRaidOptionsInputs",
						"OzRaidOptionsFilters",
						"OzRaidOptionsSorts",
						"OzRaidOptionsDisplay",
						"OzRaidOptionsBuffs",
						"OzRaidOptionsGeneral",
					};


function OZ_OptionsTabOnClick(tab)
	local n = tab:GetID()
	OzRaidOptions.selectedTab = n;
	PanelTemplates_UpdateTabs(OzRaidOptions);

	-- Now hide/show panes...
	local i
	for i,value in ipairs(OZ_OptionsPanes) do
		if( i == n ) then
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."OzRaid: Showing "..value);
			getglobal(value):Show()
		else
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."OzRaid: Hiding "..value);
			getglobal(value):Hide()
		end
	end
end

---------------------------------------------------------
--
--  SORT PANEL - DROPDOWN SETUP
--
---------------------------------------------------------
function OZ_SortCombo1_OnLoad() 
	UIDropDownMenu_Initialize(this, OZ_SortCombo1_Initialize); 
	UIDropDownMenu_SetWidth(120,this)
	if(OZ_Initialised) then
		UIDropDownMenu_SetSelectedValue(this, OZ_Config[OZ_OptionsCurrentWindow].sort1);
	else
		UIDropDownMenu_SetSelectedValue(this, 1);
	end

--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."OzRaid: Sort1 Initialised");
end

function OZ_SortCombo1_Initialize()
	UIDropDownMenu_AddButton({value = 0 , text = "<None>" , func = OZ_SortCombo1_Pressed})
	local i
	for i = 1,8 do
		if(OZ_SortFunctions[i]) then
			UIDropDownMenu_AddButton{value = i , text = OZ_SortFunctions[i].text , func = OZ_SortCombo1_Pressed}
		end
	end
end 

function OZ_SortCombo1_Pressed() 
	UIDropDownMenu_SetSelectedValue(OZ_SortCombo1,this.value)
	OZ_Config[OZ_OptionsCurrentWindow].sort1 = this.value

	OZ_SortCombo2:Enable()
	OZ_SortCombo2:Hide()
	OZ_SortCombo2:Show()
end 


function OZ_SortCombo2_OnLoad() 
	UIDropDownMenu_Initialize(this, OZ_SortCombo2_Initialize2); 
	UIDropDownMenu_SetWidth(120,this)

	if(OZ_Config[OZ_OptionsCurrentWindow]) then
		UIDropDownMenu_SetSelectedValue(this, OZ_Config[OZ_OptionsCurrentWindow].sort2);
	else
		UIDropDownMenu_SetSelectedValue(this, 0);
	end
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."OzRaid: Sort2 Initialised");
end

function OZ_SortCombo2_Initialize2()
	UIDropDownMenu_AddButton{value = 0 , text = "<None>" , func = OZ_SortCombo2_Pressed}
	local i
	for i = 1,8 do
		if(OZ_SortFunctions[i]) then
			UIDropDownMenu_AddButton{value = i , text = OZ_SortFunctions[i].text , func = OZ_SortCombo2_Pressed}
		end
	end
end 

function OZ_SortCombo2_Pressed() 
	UIDropDownMenu_SetSelectedValue(OZ_SortCombo2,this.value)
	OZ_Config[OZ_OptionsCurrentWindow].sort2 = this.value
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."OzRaid: Table2="..OZ_Sort2_Val);
end 


function OZ_TextureCombo_OnLoad()
	UIDropDownMenu_Initialize(this, OZ_TextureCombo_Initialise);

	local found
	if(OZ_Config[OZ_OptionsCurrentWindow]) then
		for key,value in ipairs(OZ_BarTextures) do
			if(value[2] == OZ_Config[OZ_OptionsCurrentWindow].barTexture)then
				UIDropDownMenu_SetSelectedValue(this,key)
				found = 1
				break
			end
		end
	end

	if(not found) then
		UIDropDownMenu_SetSelectedValue(this, 1);
	end
end

function OZ_TextureCombo_Initialise()
	local key,value
	local w = OZ_OptionsCurrentWindow
	for key,value in ipairs(OZ_BarTextures) do
		UIDropDownMenu_AddButton{value = key , text = value[1], func = OZ_TextureCombo_Pressed}
	end
end
function OZ_TextureCombo_Pressed()
	UIDropDownMenu_SetSelectedValue(OZ_TextureCombo,this.value)
	OZ_Config[OZ_OptionsCurrentWindow].barTexture = OZ_BarTextures[this.value][2]
end
---------------------------------------------------------
--
--  INPUTS PANEL - DROPDOWN SETUP
--
---------------------------------------------------------
function OZ_InputsCombo1_OnLoad() 
	UIDropDownMenu_Initialize(this, OZ_InputsCombo1_Initialize); 
	UIDropDownMenu_SetWidth(120,this)
	if(OZ_Initialised) then
		UIDropDownMenu_SetSelectedValue(this, OZ_Config[OZ_OptionsCurrentWindow].input);
	else
		UIDropDownMenu_SetSelectedValue(this, 1);
	end
end

function OZ_InputsCombo1_Initialize()
	for key,value in ipairs(OZ_InputFunctions) do
		UIDropDownMenu_AddButton{value = key , text = value.text , func = OZ_InputsCombo1_Pressed}
	end
end 

function OZ_InputsCombo1_Pressed() 
	UIDropDownMenu_SetSelectedValue(OZ_InputsCombo1,this.value)
	OZ_Config[OZ_OptionsCurrentWindow].input = this.value
end 

---------------------------------------------------------
--
--  DISPLAY PANEL - DROPDOWN SETUP
--
---------------------------------------------------------
function OZ_DisplayCombo1_OnLoad() 
	UIDropDownMenu_Initialize(this, OZ_DisplayCombo1_Initialize); 
	UIDropDownMenu_SetWidth(120,this)
	if(OZ_Initialised) then
		UIDropDownMenu_SetSelectedValue(this, OZ_Config[OZ_OptionsCurrentWindow].colour);
	else
		UIDropDownMenu_SetSelectedValue(this, 1);
	end
end

function OZ_DisplayCombo1_Initialize()
	for key,value in ipairs(OZ_ColourFunctions) do
		UIDropDownMenu_AddButton{value = key , text = value.text , func = OZ_DisplayCombo1_Pressed}
	end
end 

function OZ_DisplayCombo1_Pressed() 
	UIDropDownMenu_SetSelectedValue(OZ_DisplayCombo1,this.value)
	OZ_Config[OZ_OptionsCurrentWindow].colour = this.value
end 

function Oz_RaidDisplayCheckClick(id)
--DEFAULT_CHAT_FRAME:AddMessage("|c0033CCFF".."OzRaid: PRESSED "..id);
	if(id < 4)then
		if(id == 1)then
			OzRaidOptionsDisplayCheck1Button:SetChecked(1)
			OzRaidOptionsDisplayCheck2Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck3Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck22Button:SetChecked(nil)
		elseif(id == 2)then
			OzRaidOptionsDisplayCheck1Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck2Button:SetChecked(1)
			OzRaidOptionsDisplayCheck3Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck22Button:SetChecked(nil)
		elseif(id == 3)then
			OzRaidOptionsDisplayCheck1Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck2Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck3Button:SetChecked(1)
			OzRaidOptionsDisplayCheck22Button:SetChecked(nil)
		else
			OzRaidOptionsDisplayCheck1Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck2Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck3Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck22Button:SetChecked(1)
		end
	elseif(id < 7)then
		if(id == 4)then
			OzRaidOptionsDisplayCheck4Button:SetChecked(1)
			OzRaidOptionsDisplayCheck5Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck6Button:SetChecked(nil)
		elseif(id == 5)then
			OzRaidOptionsDisplayCheck4Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck5Button:SetChecked(1)
			OzRaidOptionsDisplayCheck6Button:SetChecked(nil)
		elseif(id == 6)then
			OzRaidOptionsDisplayCheck4Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck5Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck6Button:SetChecked(1)
		end
	elseif(id<16)then
		if(id == 11)then
			OzRaidOptionsDisplayCheck11Button:SetChecked(1)
			OzRaidOptionsDisplayCheck12Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck13Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck14Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck15Button:SetChecked(nil)
		elseif(id == 12)then
			OzRaidOptionsDisplayCheck11Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck12Button:SetChecked(1)
			OzRaidOptionsDisplayCheck13Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck14Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck15Button:SetChecked(nil)
		elseif(id == 13)then
			OzRaidOptionsDisplayCheck11Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck12Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck13Button:SetChecked(1)
			OzRaidOptionsDisplayCheck14Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck15Button:SetChecked(nil)
		elseif(id == 14)then
			OzRaidOptionsDisplayCheck11Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck12Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck13Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck14Button:SetChecked(1)
			OzRaidOptionsDisplayCheck15Button:SetChecked(nil)
		elseif(id == 15)then
			OzRaidOptionsDisplayCheck11Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck12Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck13Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck14Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck15Button:SetChecked(1)
		end
	elseif(id<19)then
		if(id == 16)then
			OzRaidOptionsDisplayCheck16Button:SetChecked(1)
			OzRaidOptionsDisplayCheck17Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck18Button:SetChecked(nil)
		elseif(id == 17)then
			OzRaidOptionsDisplayCheck16Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck17Button:SetChecked(1)
			OzRaidOptionsDisplayCheck18Button:SetChecked(nil)
		elseif(id == 18)then
			OzRaidOptionsDisplayCheck16Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck17Button:SetChecked(nil)
			OzRaidOptionsDisplayCheck18Button:SetChecked(1)
		end
	end
end

function OZ_OptionsWindow_OnLoad()
	UIDropDownMenu_Initialize(this, OZ_OptionsWindow_Initialize); 
	UIDropDownMenu_SetWidth(120,this)
	UIDropDownMenu_SetSelectedValue(this, OZ_OptionsCurrentWindow);
end

function OZ_OptionsWindow_Initialize()
	if(OZ_Initialised == 1)then
		local i
		for i=1,OZ_NWINDOWS do
			UIDropDownMenu_AddButton{value = i , text = OZ_Config[i].text , func = OZ_OptionsWindow_Pressed}
		end
	end
end 

function OZ_OptionsWindow_Pressed() 
	UIDropDownMenu_SetSelectedValue(OZ_OptionsWindow,this.value)

	OZ_OptionsSetOptionsFromConfig(this.value)
	OzRaidOptions:Hide()
	OzRaidOptions:Show()
end 

function OZ_OptionsCentre()
	local window = OZ_GetWindowArray(OZ_OptionsCurrentWindow)
	window.frame:ClearAllPoints()
	window.frame:SetPoint("CENTER",nil)
	OZ_OptionsSetConfigFromOptions()
end
----------------------------------------------------
-- Minimap Icon
----------------------------------------------------
function OZ_SetMinimapPos()
	if(OZ_Config.minimapShow)then
		OzRaid_IconFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", 52 - OZ_Config.minimapDist * cos(OZ_Config.minimapAngle), OZ_Config.minimapDist * sin(OZ_Config.minimapAngle) - 52)
		OzRaid_IconFrame:Show()
	else
		OzRaid_IconFrame:Hide()
	end
end

function OzRaid_IconFrameOnEnter()
end

function OzRaid_IconFrameOnClick()
	OZ_OptionsSetOptionsFromConfig(1)
	OzRaidOptions:Show()
end



