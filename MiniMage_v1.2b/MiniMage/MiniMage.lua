--
-- Global variable for storage of settings/options
--

MiniMageOptions = { };

--
-- Initialization functions
--

function class_OnLoad()
	MM_class = UnitClass("player");
	if (MM_class ~= "Mage") then
		this:Hide();
	end
end

function MM_Initialize()
	MM_fac = UnitFactionGroup('player');
	M_class = UnitClass("player");
	if (M_class == "Mage") then
		if (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage(MINIMAGE_ANNOUNCE_GREETING..M_class..MINIMAGE_ANNOUNCE_ENABLED);
		end
	else
		if (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage(MINIMAGE_ANNOUNCE_GREETING..M_class..MINIMAGE_ANNOUNCE_DISABLED);
		end
	end
end

function MM_Button_Initialize()
	if(event == "VARIABLES_LOADED") then
		if (MiniMageOptions.MMButtonPosition == nil) then
			MiniMageOptions.MMButtonPosition = 0;
		end
	end
end

function MM_DropDown_Initialize()
	local dropdown;
	if ( UIDROPDOWNMENU_OPEN_MENU ) then
		dropdown = getglobal(UIDROPDOWNMENU_OPEN_MENU);
	else
		dropdown = this;
	end
	MM_DropDown_InitButtons();
end

function MM_DropDown_OnLoad()
	UIDropDownMenu_Initialize(this, MM_DropDown_Initialize, "MENU");
end

--
-- Minimap button drag/drop functions
--

-- Thanks to Atlas for the button dragging code

function MM_Button_BeingDragged()
    local xpos,ypos = GetCursorPosition();
    local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom();
    xpos = xmin-xpos/UIParent:GetScale()+70;
    ypos = ypos/UIParent:GetScale()-ymin-70;
    MM_Button_SetPosition(math.deg(math.atan2(ypos,xpos)));
end

function MM_Button_OnClick()
	MM_ToggleDropDown();
end

function MM_Button_OnEnter()
    GameTooltip:SetOwner(this, "ANCHOR_LEFT");
    GameTooltip:SetText(MINIMAGE_BUTTON_TOOLTIP0);
    GameTooltip:AddLine(MINIMAGE_BUTTON_TOOLTIP1);
    GameTooltip:AddLine(MINIMAGE_BUTTON_TOOLTIP2);
    GameTooltip:Show();
end

function MM_Button_SetPosition(v)
    if(v < 0) then
        v = v + 360;
    end
    MiniMageOptions.MMButtonPosition = v;
    MM_Button_UpdatePosition();
end

function MM_Button_UpdatePosition()
	MM_ButtonFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		54 - (78 * cos(MiniMageOptions.MMButtonPosition)),
		(78 * sin(MiniMageOptions.MMButtonPosition)) - 55
	);
end

--
-- Drop down menu functions
--

function MM_ToggleDropDown()
	MM_DropDownFrame.point = "TOPRIGHT";
	MM_DropDownFrame.relativePoint = "BOTTOMLEFT";
	ToggleDropDownMenu(1, nil, MM_DropDownFrame);
end

function MM_DropDown_InitButtons()
	local info = {};
	info.text = MINIMAGE_LABEL_TITLE;
	info.isTitle = 1;
	info.justifyH = "CENTER";
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);
	
	local fact = UnitFactionGroup('player');
	if (fact == "Horde") then
		MM_DropDown_ForTheHorde();
	else
		MM_DropDown_ForTheAlliance();
	end
end

function MM_DropDown_ForTheHorde()
	local appender = ': ';

	local info = { };
	info.text = MINIMAGE_LABEL_PORTAL;
	info.isTitle = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);

	info = { };
	info.text = MINIMAGE_LABEL_HORDE0;
	info.func = function(msg) CastSpellByName(MINIMAGE_LABEL_PORTAL..appender..MINIMAGE_LABEL_HORDE0); end;
	UIDropDownMenu_AddButton(info);

	info = { };
	info.text = MINIMAGE_LABEL_HORDE1;
	info.func = function(msg) CastSpellByName(MINIMAGE_LABEL_PORTAL..appender..MINIMAGE_LABEL_HORDE1); end;
	UIDropDownMenu_AddButton(info);

	info = { };
	info.text = MINIMAGE_LABEL_HORDE2;
	info.func = function(msg) CastSpellByName(MINIMAGE_LABEL_PORTAL..appender..MINIMAGE_LABEL_HORDE2); end;
	UIDropDownMenu_AddButton(info);

	info = { };
	info.text = MINIMAGE_LABEL_TELEPORT;
	info.isTitle = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);

	info = { };
	info.text = MINIMAGE_LABEL_HORDE0;
	info.func = function(msg) CastSpellByName(MINIMAGE_LABEL_TELEPORT..appender..MINIMAGE_LABEL_HORDE0); end;
	UIDropDownMenu_AddButton(info);

	info = { };
	info.text = MINIMAGE_LABEL_HORDE1;
	info.func = function(msg) CastSpellByName(MINIMAGE_LABEL_TELEPORT..appender..MINIMAGE_LABEL_HORDE1); end;
	UIDropDownMenu_AddButton(info);

	info = { };
	info.text = MINIMAGE_LABEL_HORDE2;
	info.func = function(msg) CastSpellByName(MINIMAGE_LABEL_TELEPORT..appender..MINIMAGE_LABEL_HORDE2); end;
	UIDropDownMenu_AddButton(info);
end

function MM_DropDown_ForTheAlliance()
	local appender = ': ';

	local info = { };
	info.text = MINIMAGE_LABEL_PORTAL;
	info.isTitle = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);

	info = { };
	info.text = MINIMAGE_LABEL_ALLIANCE0;
	info.func = function(msg) CastSpellByName(MINIMAGE_LABEL_PORTAL..appender..MINIMAGE_LABEL_ALLIANCE0); end;
	UIDropDownMenu_AddButton(info);

	info = { };
	info.text = MINIMAGE_LABEL_ALLIANCE1;
	info.func = function(msg) CastSpellByName(MINIMAGE_LABEL_PORTAL..appender..MINIMAGE_LABEL_ALLIANCE1); end;
	UIDropDownMenu_AddButton(info);

	info = { };
	info.text = MINIMAGE_LABEL_ALLIANCE2;
	info.func = function(msg) CastSpellByName(MINIMAGE_LABEL_PORTAL..appender..MINIMAGE_LABEL_ALLIANCE2); end;
	UIDropDownMenu_AddButton(info);

	info = { };
	info.text = MINIMAGE_LABEL_TELEPORT;
	info.isTitle = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);

	info = { };
	info.text = MINIMAGE_LABEL_ALLIANCE0;
	info.func = function(msg) CastSpellByName(MINIMAGE_LABEL_TELEPORT..appender..MINIMAGE_LABEL_ALLIANCE0); end;
	UIDropDownMenu_AddButton(info);

	info = { };
	info.text = MINIMAGE_LABEL_ALLIANCE1;
	info.func = function(msg) CastSpellByName(MINIMAGE_LABEL_TELEPORT..appender..MINIMAGE_LABEL_ALLIANCE1); end;
	UIDropDownMenu_AddButton(info);

	info = { };
	info.text = MINIMAGE_LABEL_ALLIANCE2;
	info.func = function(msg) CastSpellByName(MINIMAGE_LABEL_TELEPORT..appender..MINIMAGE_LABEL_ALLIANCE2); end;
	UIDropDownMenu_AddButton(info);
end