-- Localization-dependant stuff

MM_GATHERER_RES = {
	['herbs']		= MM_GATHERER_HERBS,
	['mining']		= MM_GATHERER_MINING,
	['treasure']	= MM_GATHERER_TREASURE,
};

MM_GATHERER_FILTER_LOC = {
	['auto']	= MM_GATHERER_AUTO,
	['on']		= MM_GATHERER_ON,
	['off']		= MM_GATHERER_OFF,
};

MM_VALUE_TPL = "%s: |cff2040ff%s|r";

-- Debugging stuff

MM_DEBUG = false;
local function dbg(msg)
	if(MM_DEBUG) then
		DEFAULT_CHAT_FRAME:AddMessage( msg, 1.0, 0.0, 0.0 );
	end
end


-- Minimap OnClick Hook
local Old_Minimap_OnClick;

function MM_Minimap_OnClick()
	if(arg1 == "RightButton") then
		ToggleDropDownMenu(1, nil, MinimapMenuDropDown, "cursor");
	elseif(Old_Minimap_OnClick ~= nil) then
		Old_Minimap_OnClick();
	end
end

-- Initialization
local MM_Advanced_Menu = false;

function MM_OnLoad()

	-- Hook minimap OnClick
	Old_Minimap_OnClick, Minimap_OnClick = Minimap_OnClick, MM_Minimap_OnClick;

	-- Overrding ToggleDropDownMenu for better placement
	ToggleDropDownMenu = MM_ToggleDropDownMenu;

	-- Checks other add-ons
	MM_Advanced_Menu = (Gatherer_OnLoad ~= nil) or (Atlas_OnLoad ~= nil) or (FastQuest_OnLoad ~= nil);


end

-- Dropdown initialization
function MM_DropDown_Initialize(level)

	-- Gatherer submenu
	if(UIDROPDOWNMENU_MENU_VALUE == "gatherer") then
		MM_DropDown_Initialize_Gatherer(level);

	-- Gatherer themes
	elseif(UIDROPDOWNMENU_MENU_VALUE == "gatherer_theme") then
		MM_DropDown_Initialize_Gatherer_Theme(level);

	-- Gatherer ressource displaying
	elseif((UIDROPDOWNMENU_MENU_VALUE == "gatherer_herbs") or
		(UIDROPDOWNMENU_MENU_VALUE == "gatherer_mining") or
		(UIDROPDOWNMENU_MENU_VALUE == "gatherer_treasure")) then

		local _,_,which = string.find(UIDROPDOWNMENU_MENU_VALUE, "^gatherer_(.+)$");
		MM_DropDown_Initialize_Gatherer_Ressource(level, which);

	-- Advanced (main) menu if available and Shift is down
	elseif((UIDROPDOWNMENU_MENU_VALUE ~= "trackers") and MM_Advanced_Menu and IsShiftKeyDown()) then
		MM_DropDown_Initialize_Advanced(level);

	-- Tracker menu
	else
		MM_DropDown_Initialize_Trackers(level);
	end

end

function MM_DropDown_Initialize_Advanced(level)

	UIDropDownMenu_AddButton({ text = MM_MINIMAP_TITLE, isTitle = true}, level);

	-- Atlas option
	if(Atlas_OnLoad ~= nil) then
		UIDropDownMenu_AddButton(
			{
				text 	= MM_ATLAS_SHOW_BUTTON,
				checked	= Options.AtlasButtonShown,
				func	= AtlasButton_Toggle
			},
			level
		);
	end

	-- FastQuest option
	if(FastQuest_OnLoad ~= nil) then
		UIDropDownMenu_AddButton(
			{
				text	= MM_FASTQUEST_SHOW_BUTTON,
				checked	= FastQuestData[UnitName("player")].Button, -- This can fail
				func	= function() FastQuest_SlashCmd("button"); end
			},
			level
		);
	end

	-- Tracker sub-menu
	UIDropDownMenu_AddButton(
		{
			text 			= MM_TRACKER_TITLE,
			hasArrow		= true,
			value 			= "trackers",
		},
		level
	);

	-- Gatherer sub-menu
	if(Gatherer_OnLoad ~= nil) then
		UIDropDownMenu_AddButton(
			{
				text 			= MM_GATHERER_TITLE,
				hasArrow		= true,
				value 			= "gatherer",
			},
			level
		);
	end

end


function MM_DropDown_Initialize_Trackers(level)

	-- Scan spellbook for tracking spells
	local id = 1;
	local trackers = {};
	local current_tracker = GetTrackingTexture();

	while true do
		local name = GetSpellName(id, BOOKTYPE_SPELL);
		if(not name) then break; end

		for _,pattern in pairs(MM_TRACKER_PATTERNS) do
			--dbg("Matching "..name.." against "..pattern);
			local _,_,button_title = string.find(name, pattern);
			if(button_title) then
				-- This spell is a tracker
				button_title = string.gsub(button_title, "^(%l)", string.upper);
				--dbg(name.." is tracker for "..button_title);

				-- Get its texture, to compare with current tracker one
				local spellid = id;
				local texture = GetSpellTexture(id, BOOKTYPE_SPELL);
				local checked = (texture and current_tracker and (texture == current_tracker));

				-- Add a button
				table.insert(trackers,
					{
						text 		= button_title,
						checked		= checked,
						func		= function()
							dbg("Switching to "..name.." (#"..spellid..")");
							if(GetTrackingTexture() ~= GetSpellTexture(spellid, BOOKTYPE_SPELL)) then
								CastSpell(spellid, BOOKTYPE_SPELL);
							end
							CloseDropDownMenus();
						end,
					}
				);

			end
		end

		id = id + 1;
	end

	-- Now set up the menu

	-- Menu title
	UIDropDownMenu_AddButton({ text = MM_TRACKER_TITLE, isTitle = true }, level);

	-- Default
	local none_checked = (current_tracker == nil);
	UIDropDownMenu_AddButton(
		{
			text	= MM_NO_TRACKER,
			value	= 0,
			checked	= none_checked,
			func	= function()
				if(not none_checked) then
					CancelTrackingBuff();
				end
				CloseDropDownMenus();
			end
		},
		level
	);

	-- Trackers, alphabetically ordered
	table.sort(trackers, function(a,b) return (a.text < b.text); end);
	for _,button in pairs(trackers) do
		UIDropDownMenu_AddButton(button, level);
	end

end

function MM_DropDown_Initialize_Gatherer(level)

	-- Menu title
	UIDropDownMenu_AddButton({ text = MM_GATHERER_TITLE, isTitle = true }, level);

	-- Enable/disable gatherer
	UIDropDownMenu_AddButton(
		{
			text 	= MM_GATHERER_ENABLED,
			checked = GatherConfig.useMinimap,
			func	= function()
				if GatherConfig.useMinimap then
					Gatherer_Command("off");
				else
					Gatherer_Command("on");
				end
			end
		},
		level
	);

	-- Numerical settings
	for cmd, varname in pairs(MM_GATHERER_SETTINGS) do
		local dialog = "GATHERER_SETTING_"..string.upper(cmd);
		local value = GatherConfig[varname];
		if(not value) then value = 0; end
		UIDropDownMenu_AddButton(
			{
				text 		= format(MM_VALUE_TPL, getglobal("MM_GATHERER_"..string.upper(cmd)), value),
				disabled	= not GatherConfig.useMinimap,
				func		= function()
					StaticPopup_Show(dialog);
					CloseDropDownMenus();
				end
			},
			level
		);
	end

	-- Theme
	UIDropDownMenu_AddButton(
		{
			text 		= format(MM_VALUE_TPL, MM_GATHERER_THEME, GatherConfig.iconSet),
			disabled	= not GatherConfig.useMinimap,
			value		= "gatherer_theme",
			hasArrow	= true,
		},
		level
	);

	-- Displaying ressources
	for res, label in pairs(MM_GATHERER_RES) do
		UIDropDownMenu_AddButton(
			{
				text 		= format(MM_VALUE_TPL, label, MM_GATHERER_FILTER_LOC[Gatherer_GetFilterVal(res)]),
				disabled	= not GatherConfig.useMinimap,
				value		= "gatherer_"..res,
				hasArrow	= true,
			},
			level
		);
	end

end

function MM_DropDown_Initialize_Gatherer_Theme(level)

	-- Menu title
	UIDropDownMenu_AddButton({ text = MM_GATHERER_THEME, isTitle = true }, level);

	-- Theme list
	for name,_ in pairs(Gather_IconSet) do
		local theme = name;
		local label = name;
		label = string.gsub(label, "^(%l)", string.upper);
		UIDropDownMenu_AddButton(
			{
				text 	= label,
				checked	= (GatherConfig.iconSet == name),
				func	= function()
					Gatherer_Command("theme "..theme);
					CloseDropDownMenus();
				end
			},
			level
		);
	end

end

function MM_DropDown_Initialize_Gatherer_Ressource(level, which)

	-- Menu title
	UIDropDownMenu_AddButton({ text = MM_GATHERER_RES[which], isTitle = true }, level);

	-- Values
	local current_value = Gatherer_GetFilterVal(which);
	for value,label in pairs(MM_GATHERER_FILTER_LOC) do
		local setting = value;
		label = string.gsub(label, "^(%l)", string.upper);
		UIDropDownMenu_AddButton(
			{
				text 	= label,
				checked	= (current_value == setting),
				func	= function()
					Gatherer_Command(which.." "..setting);
					CloseDropDownMenus();
				end
			},
			level
		);
	end

end

-- Ripped from Blizzard's UIDropDrowMenu.lua
-- Rewrote relocating code to ensure menu are never offscreen

function MM_ToggleDropDownMenu(level, value, dropDownFrame, anchorName, xOffset, yOffset)
	if ( not level ) then
		level = 1;
	end
	UIDROPDOWNMENU_MENU_LEVEL = level;
	UIDROPDOWNMENU_MENU_VALUE = value;
	local listFrame = getglobal("DropDownList"..level);
	local listFrameName = "DropDownList"..level;
	local tempFrame;
	if ( not dropDownFrame ) then
		tempFrame = this:GetParent();
	else
		tempFrame = dropDownFrame;
	end
	if ( listFrame:IsVisible() and (UIDROPDOWNMENU_OPEN_MENU == tempFrame:GetName()) ) then
		listFrame:Hide();
	else
		-- Hide the listframe anyways since it is redrawn OnShow()
		listFrame:Hide();

		-- Frame to anchor the dropdown menu to
		local anchorFrame;

		-- Display stuff
		-- Level specific stuff
		if ( level == 1 ) then
			if ( not dropDownFrame ) then
				dropDownFrame = this:GetParent();
			end
			UIDROPDOWNMENU_OPEN_MENU = dropDownFrame:GetName();
			listFrame:ClearAllPoints();
			-- If there's no specified anchorName then use left side of the dropdown menu
			if ( not anchorName ) then
				anchorName = UIDROPDOWNMENU_OPEN_MENU.."Left"
			elseif ( anchorName == "cursor" ) then
				anchorName = "UIParent";
				local cursorX, cursorY = GetCursorPosition();
				if ( not xOffset ) then
					xOffset = 0;
				end
				if ( not yOffset ) then
					yOffset = 0;
				end
				xOffset = cursorX + xOffset;
				yOffset = cursorY + yOffset;
			end
			if ( not xOffset or not yOffset ) then
				xOffset = 8;
				yOffset = 22;
			end
			listFrame:SetPoint("TOPLEFT", anchorName, "BOTTOMLEFT", xOffset, yOffset);
		else
			if ( not dropDownFrame ) then
				dropDownFrame = getglobal(UIDROPDOWNMENU_OPEN_MENU);
			end
			listFrame:ClearAllPoints();
			-- If this is a dropdown button, not the arrow anchor it to itself
			if ( strsub(this:GetParent():GetName(), 0,12) == "DropDownList" and strlen(this:GetParent():GetName()) == 13 ) then
				anchorFrame = this:GetName();
			else
				anchorFrame = this:GetParent():GetName();
			end
			listFrame:SetPoint("TOPLEFT", anchorFrame, "TOPRIGHT", 0, 0);
		end

		-- Change list box appearance depending on display mode
		if ( dropDownFrame and dropDownFrame.displayMode == "MENU" ) then
			getglobal(listFrameName.."Backdrop"):Hide();
			getglobal(listFrameName.."MenuBackdrop"):Show();
		else
			getglobal(listFrameName.."Backdrop"):Show();
			getglobal(listFrameName.."MenuBackdrop"):Hide();
		end

		UIDropDownMenu_Initialize(dropDownFrame, dropDownFrame.initialize, nil, level);
		-- If no items in the drop down don't show it
		if ( listFrame.numButtons == 0 ) then
			return;
		end

		-- Check to see if the dropdownlist is off the screen, if it is anchor it to the top of the dropdown button
		listFrame:Show();
		-- Hack since GetCenter() is returning coords relative to 1024x768
		local x, y = listFrame:GetLeft(), listFrame:GetTop();
		-- Hack will fix this in next revision of dropdowns
		if ( not x or not y ) then
			dbg("Can't check dropdown location.");
			listFrame:Hide();
			return;
		end
		-- Determine whether the menu is off the screen or not
		local offscreenY, offscreenX = 0, 0;
		if ( (y - listFrame:GetHeight()) < 0 ) then
			offscreenY = 1;
		end
		if ( x + listFrame:GetWidth() > UIParent:GetWidth()) then
			offscreenX = 1;
		end
		--[[
		dbg(format(
			"Dropdown X : left=%d, width=%d, right=%d, screenWidth=%d, UIParentWidth=%d, offscreenX=%d",
			x, listFrame:GetWidth(), x+listFrame:GetWidth(), GetScreenWidth(), UIParent:GetWidth(), offscreenX
		));
		dbg(format(
			"Dropdown Y: top=%d, height=%d, bottom=%d, offscreenY=%d",
			y, listFrame:GetHeight(), y-listFrame:GetHeight(), offscreenY
		));
		--]]

		if((offscreenX == 1) or (offscreenY == 1)) then
			-- Need to replace..
			local offsetX, offsetY, anchorPointY, anchorPointX, elativePointY, relativePointX;
			offsetX, offsetY = xOffset, yOffset;
			anchorPointY, anchorPointX = "TOP", "LEFT";
			relativePointY, relativePointX = "TOP", "RIGHT";
			if(not offsetX) then offsetX = 0; end
			if(not offsetY) then offsetY = 0; end
			if(not anchorFrame) then anchorFrame = anchorName; end

			if(anchorName == "UIParent") then
				-- Relative to cursor...
				relativePointY, relativePointX = "BOTTOM", "LEFT"

				if(offscreenX == 1) then
					-- Place dropdown at right of cursor
					anchorPointX = "RIGHT";
				end
				if(offscreenY == 1) then
					-- Place dropdown on top of cursoir
					anchorPointY = "BOTTOM";
				end
			else
				-- Relative to other frame
				if(offscreenX == 1) then
					-- Flip side
					anchorPointX,relativePointX = relativePointX,anchorPointX;
					offsetX = -offsetX;
				end
				if(offscreenY == 1) then
					-- Place dropdown on top
					relativePointY = "BOTTOM";
					anchorPointY = "BOTTOM";
					offsetY = -offsetY;
				end
			end
			listFrame:ClearAllPoints();
			--[[
			dbg(format("Replacing %s's %s %s relative to %s's %s %s with offset (%d,%d)",
				listFrame:GetName(), anchorPointY, anchorPointX, anchorFrame, relativePointY, relativePointX, offsetX, offsetY
			));
			--]]
			listFrame:SetPoint(anchorPointY..anchorPointX, anchorFrame, relativePointY..relativePointX, offsetX, offsetY);
		end

	end
end