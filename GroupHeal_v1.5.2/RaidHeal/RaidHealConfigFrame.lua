
RaidHealConfig_NumTabs = 2;

function RaidHealConfigFrame_OnLoad()
	-- Register this panel with the UIParent
	UIPanelWindows[this:GetName()] = { area = "left", pushable = 1, whileDead = 1 };
	tinsert(UISpecialFrames,this:GetName());
	
	PanelTemplates_SetNumTabs(this, RaidHealConfig_NumTabs);
	this.selectedTab = 1;
	PanelTemplates_UpdateTabs(this);
end

function RaidHealConfigFrame_OnShow()
	PlaySound("igMainMenuOpen");
end

function RaidHealConfigFrame_OnHide()
	PlaySound("igMainMenuClose");
end

--------------------------------------
-- Tabs
--------------------------------------

function RaidHealConfig_Tab_OnClick()
	for i = 1, RaidHealConfig_NumTabs do
		local tabFrame = getglobal("RaidHealConfigFrame_TabFrame"..i);
		if ( this:GetID() == i ) then
			tabFrame:Show();
		else
			tabFrame:Hide();
		end
	end
end

--------------------
--check boxes
--------------------
function RaidHealConfig_CheckBox_OnClick()
	if ( this:GetChecked() ) then
		RaidHeal_Settings[this.option] = true;
		PlaySound("igMainMenuOptionCheckBoxOn");
	else
		RaidHeal_Settings[this.option] = false;
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
	
	RaidHeal_ShowButtons();
end

function RaidHealConfig_CheckBox_OnShow()
	if ( RaidHeal_Settings[this.option] ) then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
end

function RaidHealConfig_CheckBox_OnLoad()
	local class = UnitClass("player");
	local id = this:GetID();
	local text = getglobal(this:GetName().."Text");
	if ( id <= 3 ) then
		if ( GroupHeal_ClassSpells[class] and GroupHeal_ClassSpells[class][id] ) then
			text:SetText( GroupHeal_ClassSpells[class][id]['name'] );
			this.tooltipText = "Show/Hide the "..GroupHeal_ClassSpells[class][id]['name'].." button.";
			this:Show();
		else
			this:Hide();
		end
		
	elseif ( id == 4 ) then
		text:SetText( "Raid Targets in Say Channel" );
		this.tooltipText = "Enables reporting of heals targeting Raid members to be reported in say.";
		this:Show();
	
	elseif ( id == 5 ) then
		text:SetText( "Raid Targets in Party Channel" );
		this.tooltipText = "Enables reporting of heals targeting Raid members to be reported to your party.";
		this:Show();
		
	end
	--this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
end


----------------------------------
--Button Position DropDown Menus
----------------------------------
function RaidHealConfig_PositionDropDownButton_OnClick()
	RaidHeal_Settings.positions[UIDROPDOWNMENU_MENU_VALUE] = this.value;
	getglobal(UIDROPDOWNMENU_OPEN_MENU.."Text"):SetText(RaidHeal_Strings[this.value]);
	RaidHeal_SetSpellButtonPositions(UIDROPDOWNMENU_MENU_VALUE);
end

local PositionDropDownButtons = { { ['text'] = RaidHeal_Strings.NONE,
                                    ['func'] = RaidHealConfig_PositionDropDownButton_OnClick,
                                    ['keepShownOnClick'] = nil,
                                    ['notCheckable'] = true,
                                    ['tooltipTitle'] = nil,
                                    ['tooltipText'] = nil,
                                    ['value'] = "NONE",
                                  },
                                  { ['text'] = RaidHeal_Strings.LEFTTOP,
                                    ['func'] = RaidHealConfig_PositionDropDownButton_OnClick,
                                    ['keepShownOnClick'] = nil,
                                    ['notCheckable'] = true,
                                    ['tooltipTitle'] = nil,
                                    ['tooltipText'] = nil,
                                    ['value'] = "LEFTTOP",
                                  },
                                  { ['text'] = RaidHeal_Strings.LEFTBOTTOM,
                                    ['func'] = RaidHealConfig_PositionDropDownButton_OnClick,
                                    ['keepShownOnClick'] = nil,
                                    ['notCheckable'] = true,
                                    ['tooltipTitle'] = nil,
                                    ['tooltipText'] = nil,
                                    ['value'] = "LEFTBOTTOM",
                                  },
                                  { ['text'] = RaidHeal_Strings.RIGHTTOP,
                                    ['func'] = RaidHealConfig_PositionDropDownButton_OnClick,
                                    ['keepShownOnClick'] = nil,
                                    ['notCheckable'] = true,
                                    ['tooltipTitle'] = nil,
                                    ['tooltipText'] = nil,
                                    ['value'] = "RIGHTTOP",
                                  },
                                  { ['text'] = RaidHeal_Strings.RIGHTBOTTOM,
                                    ['func'] = RaidHealConfig_PositionDropDownButton_OnClick,
                                    ['keepShownOnClick'] = nil,
                                    ['notCheckable'] = true,
                                    ['tooltipTitle'] = nil,
                                    ['tooltipText'] = nil,
                                    ['value'] = "RIGHTBOTTOM",
                                  },
                                };

function RaidHealConfig_PositionDropDownMenu_OnLoad()
	UIDropDownMenu_Initialize(this, RaidHealConfig_PositionDropDownMenu_Initialize);
	getglobal(this:GetName().."Button"):SetScript("OnClick", RaidHealConfig_ShowPositionDropDownMenu);
	local class = UnitClass("player");
	local id = this:GetID();
	if GroupHeal_ClassSpells[class] then
		if GroupHeal_ClassSpells[class][id] then
			getglobal(this:GetName().."Label"):SetText(GroupHeal_ClassSpells[class][id]['name']);
			this.tooltip = "Set the position of the "..GroupHeal_ClassSpells[class][id]['name'].." button.";
			this:Show()
		end
	end
end

function RaidHealConfig_PositionDropDownMenu_Initialize()
	for k, v in PositionDropDownButtons do
		if ( v.value ~= RaidHeal_Settings.positions[this:GetParent():GetID()] ) then
			UIDropDownMenu_AddButton(v);
		end
	end
end

function RaidHealConfig_PositionDropDownMenu_OnShow()
	getglobal(this:GetName().."Text"):SetText(RaidHeal_Strings[RaidHeal_Settings.positions[this:GetID()]]);
end

function RaidHealConfig_ShowPositionDropDownMenu()
	PlaySound("igMainMenuOptionCheckBoxOn");
	ToggleDropDownMenu(1, this:GetParent():GetID(), this:GetParent());
end


---------------------
--sliders
---------------------

function RaidHealConfig_Slider_OnLoad( id )
	if ( id == 1 ) then
		this.option = "xOffset";
		this:SetMinMaxValues(-25, 25);
		getglobal(this:GetName().."Label"):SetText("Horizontal Offset");
		this.tooltipText = "Adjust the horizontal position of the buttons.  Lower values are closer to the Unit's button.";
	
	elseif ( id == 2 ) then
		this.option = "yOffset";
		this:SetMinMaxValues(-25, 25);
		getglobal(this:GetName().."Label"):SetText("Vertical Offset");
		this.tooltipText = "Adjust the vertical position of the buttons.";
	
	elseif ( id == 3 ) then
		this.option = "spacing";
		this:SetMinMaxValues(0, 10);
		getglobal(this:GetName().."Label"):SetText("Button Spacing");
		this.tooltipText = "Adjust the space between buttons on the same side.";
	
	end
	
	this:SetValueStep(1.0);
end

function RaidHealConfig_Slider_OnShow()
	this:SetValue(RaidHeal_Settings[this.option]);
end

function RaidHealConfig_Slider_ValueChanged()
	RaidHeal_Settings[this.option] = this:GetValue();
	RaidHeal_AdjustSpellButtonPlacement();
end


---------------------------------------------
-- Raid UI Selection
---------------------------------------------

function RaidHealConfig_RaidUISelection_OnClick()
	RaidHeal_Settings.setMode = this.value;
	if ( this.value and this.value ~= 0 ) then
		getglobal(UIDROPDOWNMENU_OPEN_MENU.."Text"):SetText(RaidHeal_Modes[this.value]);
		RaidHeal_ChangeMode( this.value );
	else
		RaidHeal_Settings.setMode = nil;
		getglobal(UIDROPDOWNMENU_OPEN_MENU.."Text"):SetText(RaidHeal_Strings.AUTOMATIC);
	end
end

function RaidHealConfig_RaidUISelection_OnLoad()
	UIDropDownMenu_Initialize(this, RaidHealConfig_RaidUISelection_Initialize);
	getglobal(this:GetName().."Label"):SetText("Raid UI Selection");
	getglobal(this:GetName().."Button"):SetScript("OnClick", RaidHealConfig_ShowRaidUIDropDownMenu);
	this.tooltip = "Choose which supported Raid UI RaidHeal will attach its buttons to.";
end

function RaidHealConfig_RaidUISelection_Initialize()
	local info =  { ['text'] = RaidHeal_Strings.AUTOMATIC,
                    ['func'] = RaidHealConfig_RaidUISelection_OnClick,
                    ['keepShownOnClick'] = nil,
                    ['notCheckable'] = true,
                    ['tooltipTitle'] = nil,
                    ['tooltipText'] = nil,
                    ['value'] = 0,
                  };
	UIDropDownMenu_AddButton(info);
	for k, v in RaidHeal_Modes do
		info = { ['text'] = v,
                 ['func'] = RaidHealConfig_RaidUISelection_OnClick,
                 ['keepShownOnClick'] = nil,
                 ['notCheckable'] = true,
                 ['tooltipTitle'] = nil,
                 ['tooltipText'] = nil,
                 ['value'] = k,
               };
		UIDropDownMenu_AddButton(info);
	end
end

function RaidHealConfig_RaidUISelection_OnShow()
	getglobal(this:GetName().."Text"):SetText(RaidHeal_Settings.setMode and RaidHeal_Modes[RaidHeal_Mode] or RaidHeal_Strings.AUTOMATIC);
end

function RaidHealConfig_ShowRaidUIDropDownMenu()
	PlaySound("igMainMenuOptionCheckBoxOn");
	ToggleDropDownMenu(1, this:GetParent():GetID(), this:GetParent());
end



---------------------
--radio buttons
---------------------[[
local radioButtons = {};
local radioButtonGroups = { {1,2,3,4}, {5,6,7,8}, {9,10,11,12} };


local function getRadioButtonGroup( id )
	for k, v in radioButtonGroups do
 		for key, value in v do
 			if ( value == id ) then
 				return v;
			end
		end
	end
	return nil;
end

function GroupHealConfigRadioButton_OnClick( id )
	local group = getRadioButtonGroup(id);
	for k, v in group do
		if ( v ~= id ) then
			radioButtons[v]:SetChecked(0);
		end
	end
	this:SetChecked(1);
	PlaySound("igMainMenuOptionCheckBoxOn");
	GroupHealConfigRadioButton_DoStuff(index);
end

function GroupHealConfigRadioButton_OnLoad()
	local index = this:GetID();
	radioButtons[index] = this;
end

function GroupHealConfigRadioButton_DoStuff( id )

end
--]]
