

GroupHealConfig = {}
local Config = GroupHealConfig;

_G = getfenv(0);
local metatable = { __index = _G };
GroupHealConfig.global = _G;
GroupHealConfig._G = _G;
setmetatable( GroupHealConfig, metatable );
setfenv(1, GroupHealConfig);


ShowHideButtonsFrames = { 
	[1] = { text = "SHOWHIDEBUTTONS_PLAYER", option = "player" },
	[2] = { text = "SHOWHIDEBUTTONS_PARTY", option = "party" },
	[3] = { text = "SHOWHIDEBUTTONS_TARGET", option = "target" },
};

CheckBoxOptions = { 
	["REPORTING_PARTY_TO_PARTY"] = { index = 1, option = "partyToParty" },
	["REPORTING_WHILE_IN_RAID"] = { index = 2, option = "partyToParty_whileInRaid", dependency = "REPORTING_PARTY_TO_PARTY" },
	["HEALBUTTON_TOOLTIPS"] = { index = 3, option = "showTooltips" },
	["MANACONSERVE_ENABLED"] = { index = 4, option = "manaConvservation_Enabled", font = "GameFontNormal" },
	["DISPLAY_OVERHEAL_WARNING"] = { index = 5, option = "overhealWarning", dependency = "MANACONSERVE_ENABLED" },
};

SliderOptions = { 
	[1] = { text = "MANACONSERVE", option = "UseRequiredCutOff", spellId = 1, minValue = 0, maxValue = 100, valueStep = 1.0, dependency = "MANACONSERVE_ENABLED", },
	[2] = { text = "MANACONSERVE", option = "UseRequiredCutOff", spellId = 2, minValue = 0, maxValue = 100, valueStep = 1.0, dependency = "MANACONSERVE_ENABLED", },
	[3] = { text = "PARTYCANCELTIME", option = "partyCancelTime", minValue = 0, maxValue = 10, valueStep = 0.5, dependency = "MANACONSERVE_ENABLED", },
	[4] = { text = "RAIDCANCELTIME", option = "raidCancelTime", minValue = 0, maxValue = 10, valueStep = 0.5, dependency = "MANACONSERVE_ENABLED", },
};

ColourOptions = {
	[1] = { id = "CANCELWARNINGCOLOUR", option = "cancelWarningColour", dependency = "DISPLAY_OVERHEAL_WARNING", },
	[2] = { id = "CANCELNOWCOLOUR", option = "cancelNowColour", dependency = "DISPLAY_OVERHEAL_WARNING", },
};

NumTabs = 2;

local class = UnitClass("player");


function Frame_OnLoad()
	-- Register this panel with the UIParent
	UIPanelWindows[this:GetName()] = { area = "left", pushable = 1, whileDead = 1 };
	tinsert(UISpecialFrames,this:GetName());
	
	for index, value in CheckBoxOptions do
		local button = getglobal("GroupHealConfigFrame_OptionsCheckbox"..value.index);
		local string = getglobal("GroupHealConfigFrame_OptionsCheckbox"..value.index.."Text");
		
		if ( button ) then
			string:SetText(GROUPHEAL_STRINGS["CONFIG_"..index.."_TEXT"]);
			button.tooltipText = GROUPHEAL_STRINGS["CONFIG_"..index.."_TOOLTIP"];
			button.option = value.option;
			if ( value.font ) then
				string:SetFontObject(value.font);
			end
			button:Show();
		end
	end
	
	for i = 1, NumTabs do
		getglobal("GroupHealConfigFrameTab"..i):SetText(GROUPHEAL_STRINGS["CONFIG_TABTITLE_"..i]);
	end
	GroupHealConfigFrameTitleText:SetText(GROUPHEAL_STRINGS.CONFIG_FRAMETITLE);
	
	PanelTemplates_SetNumTabs(this, NumTabs);
	this.selectedTab = 1;
	PanelTemplates_UpdateTabs(this);
end

function Frame_OnShow()
	PlaySound("igMainMenuOpen");
	CheckBox_UpdateDependencys();
end

function Frame_OnHide()
	PlaySound("igMainMenuClose");
end

--------------------------------------
-- Tabs
--------------------------------------

function Tab_OnClick()
	for i = 1, NumTabs do
		local tabFrame = getglobal("GroupHealConfigFrame_TabFrame"..i);
		if ( this:GetID() == i ) then
			tabFrame:Show();
		else
			tabFrame:Hide();
		end
	end
end

------------------------------------------------------------------------------
-- Generic Tooltip Function
------------------------------------------------------------------------------

function ShowTooltip()
	if ( this.tooltipText ) then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetText(this.tooltipText, nil, nil, nil, nil, 1);
	end
end


------------------------------------------------------------------------------
-- Show/Hide Buttons Frames
------------------------------------------------------------------------------

function ShowHideButtonsFrame_OnLoad()
	local config = ShowHideButtonsFrames[this:GetID()];
	
	this.option = config.option;
	getglobal(this:GetName().."TitleText"):SetText(GROUPHEAL_STRINGS["CONFIG_"..config.text.."_TITLE"]);
	
	local spellOne = getglobal(this:GetName().."BigHeal");
	local spellTwo = getglobal(this:GetName().."FastHeal");
	local spellThree = getglobal(this:GetName().."OverTimeHeal");
	
	if ( GroupHeal_ClassSpells[class] and GroupHeal_ClassSpells[class][1] ) then
		spellOne:Show();
	end
	if ( GroupHeal_ClassSpells[class] and GroupHeal_ClassSpells[class][2] ) then
		spellTwo:Show();
	end
	if ( GroupHeal_ClassSpells[class] and GroupHeal_ClassSpells[class][3] ) then
		spellThree:Show();
	end
end


------------------------------------------------------------------------------
--check boxes
------------------------------------------------------------------------------

function CheckBox_OnClick()
	if ( this:GetChecked() ) then
		PlaySound("igMainMenuOptionCheckBoxOn");
	else
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
	
	if ( this.option ) then 
		if  ( this:GetChecked() ) then
			GroupHeal_Settings[this.option] = true;
		else
			GroupHeal_Settings[this.option] = false;
		end
	
	else
		local option = this:GetParent().option;
		if  ( this:GetChecked() ) then
			GroupHeal_Settings[option][this:GetID()] = true;
		else
			GroupHeal_Settings[option][this:GetID()] = false;
		end
	end
	GroupHeal_PositionButtons();
	CheckBox_UpdateDependencys();
end

local function checkDependency( definition )
	local enabled = true;
	if ( definition.dependency ) then
		if ( GroupHeal_Settings[CheckBoxOptions[definition.dependency].option] ) then
			enabled = true;
		else
			enabled = false;
		end
		enabled = enabled and checkDependency(CheckBoxOptions[definition.dependency]);
	end
	return enabled;
end

function CheckBox_UpdateDependencys()
	for index, definition in CheckBoxOptions do
		if ( definition.dependency ) then
			local button = getglobal("GroupHealConfigFrame_OptionsCheckbox"..definition.index);
			if ( checkDependency(definition) ) then
				OptionsFrame_EnableCheckBox( button, button:GetChecked() );
			else
				OptionsFrame_DisableCheckBox( button );
			end
		end
	end
	for index, definition in SliderOptions do
		if ( checkDependency(definition) ) then
			EnableSlider( getglobal("GroupHealConfigFrame_OptionsSlider"..index) );
		else
			DisableSlider( getglobal("GroupHealConfigFrame_OptionsSlider"..index) );
		end
	end
	for index, definition in ColourOptions do
		if ( checkDependency(definition) ) then
			EnableColourSwatch( getglobal("GroupHealConfigFrame_ColourSwatch"..index) );
		else
			DisableColourSwatch( getglobal("GroupHealConfigFrame_ColourSwatch"..index) );
		end
	end
	SubTitles_UpdateDependencys()
end

function SubTitles_UpdateDependencys()
	if ( GroupHeal_Settings["manaConvservation_Enabled"] ) then
		GroupHealConfig_ManaConserveOptionsSubTitle1:SetVertexColor(NORMAL_FONT_COLOR.r , NORMAL_FONT_COLOR.g , NORMAL_FONT_COLOR.b);
		GroupHealConfig_ManaConserveOptionsSubTitle2:SetVertexColor(NORMAL_FONT_COLOR.r , NORMAL_FONT_COLOR.g , NORMAL_FONT_COLOR.b);
	else
		GroupHealConfig_ManaConserveOptionsSubTitle1:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		GroupHealConfig_ManaConserveOptionsSubTitle2:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	end
end

function CheckBox_OnShow()
	if ( this.option ) then 
		if ( GroupHeal_Settings[this.option] ) then
			this:SetChecked(1);
		else
			this:SetChecked(0);
		end
	
	else
		if ( GroupHeal_Settings[this:GetParent().option][this:GetID()] ) then
			this:SetChecked(1);
		else
			this:SetChecked(0);
		end
	end
end

function CheckBox_OnLoad()
	local id = this:GetID();
	local text = getglobal(this:GetName().."Text");
	if ( id <= GROUPHEAL_MAX_SPELLS ) then
		if ( GroupHeal_ClassSpells[class] and GroupHeal_ClassSpells[class][id] ) then
			text:SetText( GroupHeal_ClassSpells[class][id]['name'] );
			this.tooltipText = format(GROUPHEAL_STRINGS.CONFIG_SHOWHIDEBUTTON_TOOLTIP, GroupHeal_ClassSpells[class][id]['name']);
			this:Show();
		else
			this:Hide();
		end
	end
end

------------------------------------------------------------------------------
--sliders
------------------------------------------------------------------------------

function Slider_OnLoad()
	local label = getglobal(this:GetName().."Label");
	local options = SliderOptions[this:GetID()];
	this.option = options.option;
	this:SetMinMaxValues(options.minValue, options.maxValue);
	this:SetValueStep(options.valueStep);
	
	if ( options.spellId ) then
		if ( GroupHeal_ClassSpells[class] and GroupHeal_ClassSpells[class][options.spellId] ) then
			this.spellId = options.spellId;
			label:SetText( GroupHeal_ClassSpells[class][options.spellId]['name'] );
			this.tooltipText = format( GROUPHEAL_STRINGS["CONFIG_"..options.text.."_TOOLTIP"], GroupHeal_ClassSpells[class][options.spellId]['name'] );
			this:Show();
		else
			this:Hide();
		end
	else
		label:SetText( GROUPHEAL_STRINGS["CONFIG_"..options.text.."_TEXT"] );
		this.tooltipText = GROUPHEAL_STRINGS["CONFIG_"..options.text.."_TOOLTIP"];
		this:Show();
	end
end

function Slider_OnShow()
	if ( this.spellId ) then
		this:SetValue(GroupHeal_Settings[this.option][this.spellId]);
	else
		this:SetValue(GroupHeal_Settings[this.option]);
	end
end

function Slider_ValueChanged()
	if ( this.spellId ) then
		GroupHeal_Settings[this.option][this.spellId] = this:GetValue();
	else
		GroupHeal_Settings[this.option] = this:GetValue();
	end
end


function DisableSlider(slider)
	local name = slider:GetName();
	slider:EnableMouse(false);
	getglobal(name.."Label"):SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	getglobal(name.."Value"):SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	getglobal(name.."Low"):SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	getglobal(name.."High"):SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
end

function EnableSlider(slider)
	local name = slider:GetName();
	slider:EnableMouse(true);
	getglobal(name.."Label"):SetVertexColor(NORMAL_FONT_COLOR.r , NORMAL_FONT_COLOR.g , NORMAL_FONT_COLOR.b);
	getglobal(name.."Value"):SetVertexColor(NORMAL_FONT_COLOR.r , NORMAL_FONT_COLOR.g , NORMAL_FONT_COLOR.b);
	getglobal(name.."Low"):SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	getglobal(name.."High"):SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
end


------------------------------------------------------------------------------
--Help Mouseovers
------------------------------------------------------------------------------

local helpTips = {
	[1] = "MANACONSERVE_SENSITIVITY";
	[2] = "CANCEL_TIMES";
	[3] = "MANACONSERVE";
};

function MouseOverHelp_OnEnter()
	local info = helpTips[this:GetID()];
	local title, text;
	title = GROUPHEAL_STRINGS["CONFIG_HELPTIP_"..info.."_TITLE"];
	text = GROUPHEAL_STRINGS["CONFIG_HELPTIP_"..info.."_TEXT"];
	
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(title, nil, nil, nil, nil, (not text));
	if ( text ) then
		GameTooltip:AddLine(text, nil, nil, nil, 1)
	end
	GameTooltip:Show();
end


------------------------------------------------------------------------------
--Colour Swatches
------------------------------------------------------------------------------


function ColourSwatch_OnLoad()
	local label = getglobal(this:GetName().."Text");
	local options = ColourOptions[this:GetID()];
	
	this.option = options.option;
	label:SetText(GROUPHEAL_STRINGS["CONFIG_"..options.id.."_TEXT"]);
	this.tooltipText = GROUPHEAL_STRINGS["CONFIG_"..options.id.."_TOOLTIP"];
end

function ColourSwatch_OnShow()
	local colour = GroupHeal_Settings[this.option];
	getglobal(this:GetName().."Colour"):SetVertexColor(colour.r, colour.g, colour.b, colour.a);
end


local colourTable, colourSwatch;

local function swatchFunc()
	local r,g,b = ColorPickerFrame:GetColorRGB();
	colourTable.r = r;
	colourTable.g = g;
	colourTable.b = b;
	colourSwatch:SetVertexColor(r, g, b);
	GroupHeal_CancelHealWarningText:SetTextColor(r, g, b);
	GroupHeal_CancelHealWarning:Show();
end

local function cancelFunc( previousValues )
	colourTable.r = previousValues.r;
	colourTable.g = previousValues.g;
	colourTable.b = previousValues.b;
	colourSwatch:SetVertexColor(colourTable.r, colourTable.g, colourTable.b, colourTable.a);
	GroupHeal_CancelHealWarning:Hide();
end

function ColourSwatch_OnClick()
	colourSwatch = getglobal(this:GetName().."Colour");
	colourTable = GroupHeal_Settings[this.option];
	if ( type(colourTable) ~= "table" ) then
		GroupHeal_Settings[this.option] = {};
		colourTable = GroupHeal_Settings[this.option];
	end
	local frame = ColorPickerFrame;
	frame.func = swatchFunc;
	frame.hasOpacity = nil;
	frame:SetColorRGB(colourTable.r, colourTable.g, colourTable.b);
	if ( type(frame.previousValues) ~= "table" ) then
		frame.previousValues = {};
	end
	frame.previousValues.r = colourTable.r;
	frame.previousValues.g = colourTable.g;
	frame.previousValues.b = colourTable.b;
	frame.cancelFunc = cancelFunc;
	ShowUIPanel(frame);
	GroupHeal_CancelHealWarning:Show();
end

function DisableColourSwatch(swatch)
	swatch:Disable();
	getglobal(swatch:GetName().."Text"):SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
end

function EnableColourSwatch(swatch)
	swatch:Enable();
	getglobal(swatch:GetName().."Text"):SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
end