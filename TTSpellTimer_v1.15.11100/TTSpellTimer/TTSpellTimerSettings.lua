-- ============================================================================
-- TTSpellTimerSettings.lua
--
-- Copyright (c) Matthew Johnson.  All rights reserved.
--
-- This work may be freely adapted and distributed as long as this notice remains intact.
-- This work may NOT be (re)sold or included in any compilations that are (re)sold.
--
-- ============================================================================

-- ============================================================================
-- Global defines.
-- ============================================================================

-- ============================================================================
-- Global variables.
-- ============================================================================
TTST_Settings_SpellList =
	{
	[TTST_GENERAL]		= { Expanded = false, Spells = { TTST_SETTINGS_SETTINGS, TTST_SETTINGS_HELP } },
	[TTST_DRUID]		= { Expanded = false, Spells = {} },
	[TTST_HUNTER]		= { Expanded = false, Spells = {} },
	[TTST_HUNTER_PET]	= { Expanded = false, Spells = {} },
	[TTST_MAGE]			= { Expanded = false, Spells = {} },
	[TTST_PALADIN]		= { Expanded = false, Spells = {} },
	[TTST_PRIEST]		= { Expanded = false, Spells = {} },
	[TTST_ROGUE]		= { Expanded = false, Spells = {} },
	[TTST_SHAMAN]		= { Expanded = false, Spells = {} },
	[TTST_WARLOCK]		= { Expanded = false, Spells = {} },
	[TTST_WARLOCK_PET]	= { Expanded = false, Spells = {} },
	[TTST_WARRIOR]		= { Expanded = false, Spells = {} },
	};

TTST_Settings_TempSpellData =
	{
	Settings = {},
	Spells = {},
	};

TTST_Settings_InMove = false;

TTST_Settings_DetailFrameList =
	{
	"GeneralColors",
	"GeneralHelp",
	"GeneralSettings",
	"SpellDetails",
	};

-- ============================================================================
-- Settings_OnLoad
-- ============================================================================
function TTST_Settings_OnLoad()

	-- Register a slash command.
	SLASH_TTST1 = "/ttst";
	SlashCmdList["TTST"] = TTST_Settings_OnSlashCommand;

	-- Add the settings frame to the list of frames that can be closed by ESC.
	tinsert(UISpecialFrames, "TTST_SettingsFrame");

	-- Initialize our spell list.
	for key, value in TTST_SpellDataDefault.Spells do

		local spellName = key;
		local className = value.Class;

		tinsert(TTST_Settings_SpellList[className].Spells, spellName);

	end

	-- Alphabetize our spell list.
	for key, value in TTST_Settings_SpellList do
		if (key ~= TTST_GENERAL) then
			sort(value.Spells);
		end
	end

	-- Initialize the spell list as it will appear in the settings frame.
	TTST_SettingsFrame.SpellList = {};
	TTST_SettingsFrame.SelectedIndex = -1;

	-- Since this is the first time the list is being viewed, expand the list
	-- for the user's current class.
	local className = UnitClass("player");

	if (GetLocale() ~= "zhCN") then
		className = string.sub(className, 1, 1) .. string.lower(string.sub(className, 2));
	end

	TTST_Settings_SpellList[className].Expanded = true;

end

-- ============================================================================
-- Settings_OnShow
-- ============================================================================
function TTST_Settings_OnShow()

	TTST_Settings_UpdateSpellList();
	TTST_Settings_OnUpdate();

end

-- ============================================================================
-- Settings_OnSlashCommand
-- ============================================================================
function TTST_Settings_OnSlashCommand(cmd)

	-- Chop up the params into a command and its parameters.
	if (cmd ~= nil and cmd ~= "") then

		local action, param;

		for first, second in string.gfind(cmd, "(%w+) (.*)") do

			action = string.lower(first);
			param = second;

		end

		if (action == "reset" and param ~= nil) then

			if (param == "all") then

				-- Reset all of the spell settings to their default values.
				for spellName in TTST_SpellDataDefault.Spells do

					TTST_RemoveSpellUserProperties(spellName);

				end

			elseif (param == "window") then

				-- Reset the location of the spell timer window.
				TTST_SpellDataUser.Settings.TimerFramePosition = {};
				TTST_TimerFrame:ClearAllPoints();
				TTST_TimerFrame:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", 0, 0);
				TTST_TimerFrame:SetMovable(true);
				TTST_TimerFrame:SetUserPlaced(false);

			else

				for spellName in TTST_SpellDataDefault.Spells do

					-- Reset just the specified spell.
					if (string.lower(spellName) == param) then
						TTST_RemoveSpellUserProperties(spellName);
					end

				end

			end

		end
		
	else

		-- No command, so the user must just want to toggle the settings frame.
		if (TTST_SettingsFrame:IsVisible()) then

			HideUIPanel(TTST_SettingsFrame);

		else

			ShowUIPanel(TTST_SettingsFrame);

		end

	end

end

-- ============================================================================
-- Settings_OnUpdate
-- ============================================================================
function TTST_Settings_OnUpdate()

	-- Get the total number of items in the spell list.
	local cSpells = getn(TTST_SettingsFrame.SpellList);

	-- Find the scroll offset for the faux scroll frame.
	local iListItemOffset = FauxScrollFrame_GetOffset(TTST_SettingsFrame_SpellList_ScrollFrame);

	-- Update the scroll frame.
	FauxScrollFrame_Update(TTST_SettingsFrame_SpellList_ScrollFrame, cSpells, 18, TTST_SETTINGS_SPELLLIST_HEIGHT, nil, nil, nil, TTST_SettingsFrame_SpellList_HighlightFrame, 220, 220);

	-- Make sure the scroll frame is always visible.  The update above may hide it.
	TTST_SettingsFrame_SpellList_ScrollFrame:Show();

	-- Hide the highlight frame until we know where it is appearing.
	TTST_SettingsFrame_SpellList_HighlightFrame:Hide();

	-- Loop through our visible items and update each one.
	for i=1, 18, 1 do

		local spellIndex = i + iListItemOffset;

		local listItem = getglobal("TTST_SettingsFrame_SpellList_Item" .. i);

		if (spellIndex <= cSpells) then

			local listItemTexture = getglobal("TTST_SettingsFrame_SpellList_Item" .. i .. "_Texture");
			local listItemNormalTexture = getglobal("TTST_SettingsFrame_SpellList_Item" .. i .. "_NormalTexture");
			local listItemHighlightTexture = getglobal("TTST_SettingsFrame_SpellList_Item" .. i .. "_HighlightTexture");
			local listItemNormalText = getglobal("TTST_SettingsFrame_SpellList_Item" .. i .. "_NormalText");

			local spellItem = TTST_SettingsFrame.SpellList[spellIndex]; 

			-- If this is the general settings item, then do some special stuff.
			local fGeneralSettingsItem = (spellItem.Text == TTST_SETTINGS_SETTINGS) or (spellItem.Text == TTST_SETTINGS_COLORS) or (spellItem.Text == TTST_SETTINGS_HELP);

			-- Set the item text.
			listItem:SetText(spellItem.Text);

			-- Adjust some item properties if it is a header.
			if (spellItem.Header) then

				-- Adjust the expand/collapse button.
				if (TTST_Settings_SpellList[spellItem.Text].Expanded) then
					listItem:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
				else
					listItem:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
				end

				-- Make sure the expand/collapse button is visible.
				listItemNormalTexture:Show();
				listItemHighlightTexture:Show();

				-- Hide the spell texture.
				listItemTexture:Hide();

				-- Shift the text to the left.
				listItemNormalText:SetPoint("LEFT", listItemNormalTexture:GetName(), "RIGHT", 3, 0);

				-- Make sure the text is the proper color.
				listItem:SetTextColor(.75, .60, 0);

			-- The item is not a header.
			else

				-- Hide the expanded/collapsed button.
				listItem:SetNormalTexture("");
				listItemNormalTexture:Hide();
				listItemHighlightTexture:Hide();

				-- Set the spell texture.
				if (not fGeneralSettingsItem) then
					listItemTexture:SetTexture(TTST_GetSpellProperties(spellItem.Text).Texture);
					listItemTexture:Show();
				end

				-- Shift the text to the right.
				listItemNormalText:SetPoint("LEFT", listItemTexture:GetName(), "RIGHT", 3, 0);

				-- Set the text color based on the timer's current enabled/disabled state.
				if (fGeneralSettingsItem or TTST_GetSpellUserProperties(spellItem.Text).Enabled or TTST_GetSpellUserProperties(spellItem.Text).EnabledAutoMessage) then
					listItem:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
				else
					listItem:SetTextColor(.7, .7, .7);
				end

				-- Update the highlight frame.
				if (TTST_SettingsFrame.SelectedIndex == spellIndex) then

					-- Set the location of the highlight frame.
					TTST_SettingsFrame_SpellList_HighlightFrame:SetPoint("TOPLEFT", "TTST_SettingsFrame_SpellList_Item" .. i, "TOPLEFT", -2, 1);
					TTST_SettingsFrame_SpellList_HighlightFrame:Show();

				end

			end

			-- Make sure the list item frame is visible.
			listItem:Show();

		else

			-- Make sure any unused frames are hidden.
			listItem:Hide();

		end

	end

	-- Now make sure that the selected item's data is reflected in the spell details.
	if (TTST_SettingsFrame.SelectedIndex ~= -1) then

		local selectedItemText = TTST_SettingsFrame.SpellList[TTST_SettingsFrame.SelectedIndex].Text;

		if (selectedItemText == TTST_SETTINGS_COLORS) then

			-- Make sure the color settings are visible.
			TTST_Settings_ShowDetails("GeneralColors");

		elseif (selectedItemText == TTST_SETTINGS_HELP) then

			-- Make sure the help settings are visible.
			TTST_Settings_ShowDetails("GeneralHelp");

		elseif (selectedItemText == TTST_SETTINGS_SETTINGS) then

			-- Get the general settings.
			local generalSettings = TTST_GetGeneralSettings();

			-- Set the addon's enabled/disabled state.
			local disabled = false;
			if (generalSettings.Disabled == "yes") then
				disabled = true;
			end
			TTST_SettingsFrame_GeneralSettings_Enabled:SetChecked(not disabled);

			-- Set the auto chat message enabled/disabled state.
			local disableAutoMessages = false;
			if (generalSettings.DisableAutoMessages == "yes") then
				disableAutoMessages = true;
			end
			TTST_SettingsFrame_GeneralSettings_DisableAutoMessages:SetChecked(disableAutoMessages);

			-- Set the background show/hide state.
			local hideBackground = false;
			if (generalSettings.HideBackground == "yes") then
				hideBackground = true;
			end
			TTST_SettingsFrame_GeneralSettings_HideBackground:SetChecked(hideBackground);

			-- Set the addon's scaling.
			TTST_SettingsFrame_GeneralSettings_Scaling:SetValue(generalSettings.TimerScaling);

			-- Make sure the general settings are visible.
			TTST_Settings_ShowDetails("GeneralSettings");

		else

			-- Get the user properties for the selected item.
			local properties = TTST_GetSpellUserProperties(selectedItemText);

			-- Set the timer's enabled/disabled state.
			TTST_SettingsFrame_SpellDetails_Enabled:SetChecked(properties.Enabled);
			TTST_SettingsFrame_SpellDetails_EnabledAutoMessage:SetChecked(properties.EnabledAutoMessage);

			-- Modify the text message title if messages were disabled for all spells.
			local chatHeader = TTST_SETTINGS_OPTIONS_CHAT_HEADER;
			if (TTST_SpellDataUser.Settings.DisableAutoMessages and TTST_SpellDataUser.Settings.DisableAutoMessages == "yes") then
				chatHeader = chatHeader .. "  " .. TTST_SETTINGS_OPTIONS_CHAT_DISABLED;
			end
			TTST_SettingsFrame_SpellDetails_ChatTitle:SetText(chatHeader);

			-- Set the precast message text.
			if (properties.AutoChat.MessagePreCast ~= nil) then
				TTST_SettingsFrame_SpellDetails_Chat_MessagePreCast:SetText(properties.AutoChat.MessagePreCast);
			else
				TTST_SettingsFrame_SpellDetails_Chat_MessagePreCast:SetText("");
			end

			-- Set the message text.
			if (properties.AutoChat.Message ~= nil) then
				TTST_SettingsFrame_SpellDetails_Chat_Message:SetText(properties.AutoChat.Message);
			else
				TTST_SettingsFrame_SpellDetails_Chat_Message:SetText("");
			end

			-- Set the state of the checkboxes.
			TTST_SettingsFrame_SpellDetails_Chat_Emote:SetChecked(properties.AutoChat.Enabled.Emote);
			TTST_SettingsFrame_SpellDetails_Chat_Raid:SetChecked(properties.AutoChat.Enabled.Raid);
			TTST_SettingsFrame_SpellDetails_Chat_Party:SetChecked(properties.AutoChat.Enabled.Party);
			TTST_SettingsFrame_SpellDetails_Chat_Yell:SetChecked(properties.AutoChat.Enabled.Yell);
			TTST_SettingsFrame_SpellDetails_Chat_Say:SetChecked(properties.AutoChat.Enabled.Say);

			-- Set the state of the display checkboxes.
			TTST_SettingsFrame_SpellDetails_Display_AutoRemove:SetChecked(properties.AutoRemove);
			TTST_SettingsFrame_SpellDetails_Display_SpellName:SetChecked(properties.ShowSpellName);
			TTST_SettingsFrame_SpellDetails_Display_TargetName:SetChecked(properties.ShowTargetName);

			-- Fill out the description.
			TTST_SettingsFrame_SpellDetails_Description_Text:SetText(TTST_GetSpellProperties(TTST_SettingsFrame.SpellList[TTST_SettingsFrame.SelectedIndex].Text).Description);

			-- Make sure the spell details are visible.
			TTST_Settings_ShowDetails("SpellDetails");

		end

	end

end

-- ============================================================================
-- Settings_ShowDetails
--
-- Shows the appropriate details frame and hides all the other frames.
-- ============================================================================
function TTST_Settings_ShowDetails(frame)

	for i=1, getn(TTST_Settings_DetailFrameList), 1 do

		local frameName = TTST_Settings_DetailFrameList[i];
		local frameObj = getglobal("TTST_SettingsFrame_" .. frameName);

		if (frame == frameName) then
			frameObj:Show();
		else
			frameObj:Hide();
		end

	end

end

-- ============================================================================
-- SettingsItem_OnClick
--
-- Handles the click event for the spells in the spell list.
-- ============================================================================
function TTST_SettingsItem_OnClick(arg1)

	-- Determine the clicked item's index in the spell list.
	local spellIndex = this:GetID() + FauxScrollFrame_GetOffset(TTST_SettingsFrame_SpellList_ScrollFrame);

	-- If this item is a header, toggle the expand/collapse state.
	if (TTST_SettingsFrame.SpellList[spellIndex].Header) then

		-- Toggle the expand/collapse state.
		TTST_Settings_SpellList[TTST_SettingsFrame.SpellList[spellIndex].Text].Expanded = not TTST_Settings_SpellList[TTST_SettingsFrame.SpellList[spellIndex].Text].Expanded;

		-- Get the size of the current spell list.
		local cSpellsOld = getn(TTST_SettingsFrame.SpellList);

		-- Rebuild the spell list.
		TTST_Settings_UpdateSpellList();

		-- Get the size of the new spell list.
		local cSpellsNew = getn(TTST_SettingsFrame.SpellList);

		-- If the collapsed/expanded node is above the currently selected item,
		-- then we need to adjust the currently selected item's index.
		if (TTST_SettingsFrame.SelectedIndex > spellIndex) then

			if (TTST_Settings_SpellList[TTST_SettingsFrame.SpellList[spellIndex].Text].Expanded) then

				TTST_SettingsFrame.SelectedIndex = TTST_SettingsFrame.SelectedIndex + (cSpellsNew - cSpellsOld);

			else

				TTST_SettingsFrame.SelectedIndex = TTST_SettingsFrame.SelectedIndex - (cSpellsOld - cSpellsNew);

				-- We need to update the scroll frame now or else things will look funny.
				local offset = FauxScrollFrame_GetOffset(TTST_SettingsFrame_SpellList_ScrollFrame) - (cSpellsOld - cSpellsNew);
				if (offset < 0) then
					offset = 0;
				end

				FauxScrollFrame_SetOffset(TTST_SettingsFrame_SpellList_ScrollFrame, offset);
				FauxScrollFrame_Update(TTST_SettingsFrame_SpellList_ScrollFrame, cSpellsNew, 18, TTST_SETTINGS_SPELLLIST_HEIGHT, nil, nil, nil, TTST_SettingsFrame_SpellList_HighlightFrame, 220, 220);

			end

		end

		-- Adjust the selected index in case it falls out of range or on a header.
		if (TTST_SettingsFrame.SelectedIndex < 1 or TTST_SettingsFrame.SelectedIndex > cSpellsNew or TTST_SettingsFrame.SpellList[TTST_SettingsFrame.SelectedIndex].Header) then
			TTST_SettingsFrame.SelectedIndex = -1;
		end

	-- If this item is a spell, make it the selected item.
	else

		TTST_SettingsFrame.SelectedIndex = spellIndex;

	end

	-- Update the frame.
	TTST_Settings_OnUpdate();

end

-- ============================================================================
-- SettingsItem_OnGeneralSettingsChanged
--
-- Called any time something in the general settings is changed by the user.
-- ============================================================================
function TTST_SettingsItem_OnGeneralSettingsChanged(ignoreDisabled)

	local generalSettings =
		{
		DisableAutoMessages = TTST_SettingsFrame_GeneralSettings_DisableAutoMessages:GetChecked(),
		Disabled			= not TTST_SettingsFrame_GeneralSettings_Enabled:GetChecked(),
		HideBackground		= TTST_SettingsFrame_GeneralSettings_HideBackground:GetChecked(),
		TimerScaling		= TTST_SettingsFrame_GeneralSettings_Scaling:GetValue(),
		};

	if (generalSettings.Disabled) then
		generalSettings.Disabled = "yes";
	else
		generalSettings.Disabled = "no";
	end

	if (generalSettings.DisableAutoMessages) then
		generalSettings.DisableAutoMessages = "yes";
	else
		generalSettings.DisableAutoMessages = "no";
	end

	if (generalSettings.HideBackground) then
		generalSettings.HideBackground = "yes";
	else
		generalSettings.HideBackground = "no";
	end

	-- Save the user's changes.
	if (ignoreDisabled) then
		generalSettings.Disabled = nil;
	end

	TTST_SetGeneralSettings(generalSettings);

	-- Apply the changes.
	TTST_TimerFrame:SetScale(generalSettings.TimerScaling);

end

-- ============================================================================
-- SettingsItem_OnSpellDetailsChanged
--
-- Called any time something in the spell details is changed by the user.
-- ============================================================================
function TTST_SettingsItem_OnSpellDetailsChanged()

	-- If precast message is empty, convert it to nil.
	local messagePreCast = TTST_SettingsFrame_SpellDetails_Chat_MessagePreCast:GetText();
	if (messagePreCast == "") then
		messagePreCast = nil;
	end

	-- If the message is empty, convert it to nil.
	local message = TTST_SettingsFrame_SpellDetails_Chat_Message:GetText();
	if (message == "") then
		message = nil;
	end
	
	local userProperties =
		{
		AutoChat =
			{
			Message = message,
			MessagePreCast = messagePreCast,
			Enabled =
				{
				Say		= TTST_SettingsFrame_SpellDetails_Chat_Say:GetChecked(),
				Yell	= TTST_SettingsFrame_SpellDetails_Chat_Yell:GetChecked(),
				Party	= TTST_SettingsFrame_SpellDetails_Chat_Party:GetChecked(),
				Raid	= TTST_SettingsFrame_SpellDetails_Chat_Raid:GetChecked(),
				Emote	= TTST_SettingsFrame_SpellDetails_Chat_Emote:GetChecked(),
				},
			},
		AutoRemove			= TTST_SettingsFrame_SpellDetails_Display_AutoRemove:GetChecked(),
		Enabled				= TTST_SettingsFrame_SpellDetails_Enabled:GetChecked(),
		EnabledAutoMessage = TTST_SettingsFrame_SpellDetails_EnabledAutoMessage:GetChecked(),
		ShowSpellName		= TTST_SettingsFrame_SpellDetails_Display_SpellName:GetChecked(),
		ShowTargetName		= TTST_SettingsFrame_SpellDetails_Display_TargetName:GetChecked(),
		};

	-- Save the user's changes.
	if (TTST_SettingsFrame.SelectedIndex > 0) then
		TTST_SetSpellUserProperties(TTST_SettingsFrame.SpellList[TTST_SettingsFrame.SelectedIndex].Text, userProperties);
	end

	-- Force an update to make sure everything is in sync.
	TTST_Settings_OnUpdate();

end

-- ============================================================================
-- Settings_UpdateSpellList
--
-- Updates the spell listing as it appears in the settings frame.
-- ============================================================================
function TTST_Settings_UpdateSpellList()

	TTST_SettingsFrame.SpellList = {};

	-- Generate the list of spells based on the current expand/collapse state.
	for iClass=1, getn(TTST_AlphabeticalClassList), 1 do

		local className = TTST_AlphabeticalClassList[iClass];

		-- Insert the class name into the list.
		tinsert(TTST_SettingsFrame.SpellList, { Text = className, Header = true });

		-- If the class is expanded, insert each spell in the class into the list.
		if (TTST_Settings_SpellList[className].Expanded) then

			local spellList = TTST_Settings_SpellList[className].Spells;

			for iSpell=1, getn(spellList), 1 do

				tinsert(TTST_SettingsFrame.SpellList, { Text = spellList[iSpell], Header = false });

			end

		end

	end

end

-- ============================================================================
-- Settings_General_Move_OnClick
--
-- Called when the user clicks the move timer window button.
-- ============================================================================
function TTST_Settings_General_Move_OnClick()

	if (TTST_TimerFrame_Positioning:IsVisible()) then

		TTST_Settings_General_MoveDone_OnClick();
		return;

	end

	-- Set a flag that says we're explicitly showing the timer window to move it.
	TTST_Settings_InMove = true;

	TTST_TimerFrame_Positioning:Show();
	TTST_TimerFrame:Show();

end

-- ============================================================================
-- Settings_General_MoveDone_OnClick
--
-- Called when the user clicks the move done button in the timer window.
-- ============================================================================
function TTST_Settings_General_MoveDone_OnClick()

	if (not TTST_SpellDataUser.Settings.TimerFrameAnchor) then
		TTST_SpellDataUser.Settings.TimerFrameAnchor = "TOPLEFT";
	end

	if (not TTST_SpellDataUser.Settings.TimerFramePosition or not TTST_SpellDataUser.Settings.TimerFramePosition.x or not TTST_SpellDataUser.Settings.TimerFramePosition.y) then

		local x = TTST_TimerFrame:GetLeft();
		local y = TTST_TimerFrame:GetTop();
		TTST_SpellDataUser.Settings.TimerFramePosition = { x = x, y = y };

	end

	TTST_Settings_InMove = false;

	TTST_TimerFrame_Positioning:Hide();

	-- Now, make sure we hide the window as long as no timers are active.
	if (getn(TTST_Timers) == 0 and getn(TTST_TimersEx) == 0) then
		TTST_TimerFrame:Hide();
	end

end

-- ============================================================================
-- Settings_General_AnchorPoint_OnClick
--
-- Called when the user clicks on one of the grow direction buttons.
-- ============================================================================
function TTST_Settings_General_AnchorPoint_OnClick(point)

	TTST_SpellDataUser.Settings.TimerFrameAnchor = point;

	local x, y;

	if (point == "TOPLEFT") then
		x = TTST_TimerFrame:GetLeft();
		y = TTST_TimerFrame:GetTop();
	elseif (point == "TOPRIGHT") then
		x = TTST_TimerFrame:GetRight();
		y = TTST_TimerFrame:GetTop();
	elseif (point == "BOTTOMLEFT") then
		x = TTST_TimerFrame:GetLeft();
		y = TTST_TimerFrame:GetBottom();
	elseif (point == "BOTTOMRIGHT") then
		x = TTST_TimerFrame:GetRight();
		y = TTST_TimerFrame:GetBottom();
	end

	-- Adjust the location.
	TTST_TimerFrame:ClearAllPoints();
	TTST_TimerFrame:SetPoint(TTST_SpellDataUser.Settings.TimerFrameAnchor, "UIParent", "BOTTOMLEFT", x, y);
	TTST_TimerFrame:SetMovable(true);
	TTST_TimerFrame:SetUserPlaced(true);

	TTST_SpellDataUser.Settings.TimerFramePosition = { x = x, y = y };

end
