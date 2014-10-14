--[[
	Gypsy_ActionBar.lua
	GypsyVersion++2004.11.14++

	GypsyMod action bar, holds extra row of	action buttons.
]]

-- ** DEFAULT SETTINGS ** --

-- Default action bar specific lock setting
Gypsy_DefaultLockActionBar = 0;
-- Action button placeholder display default
Gypsy_DefaultPlaceHoldersToggle = 1;
-- Hotkey binding label display default
Gypsy_DefaultHotKeyLabelsToggle = 1;
-- Action bar paging default
Gypsy_DefaultGroupActionBarPages = 1;
-- Allow page turning default
Gypsy_DefaultAllowPageTurning = 1;
-- Turn-page-on-press default
Gypsy_DefaultTurnPageOnPress = 0;
-- Default number of pixels between action buttons
Gypsy_DefaultActionButtonGap = 6;
-- Default maximum number of pixels between action buttons
Gypsy_DefaultActionButtonGapMax = 8;
-- Default minimum number of pixels between action buttons
Gypsy_DefaultActionButtonGapMin = 2;
-- Default stepping between each gap setting
Gypsy_DefaultActionButtonGapStep = 2;
-- Show shortened mod keys by default
Gypsy_DefaultShortenModKey = 1;
-- Do not strip mod keys by default
Gypsy_DefaultStripModKey = 0;

-- ** GENERAL VARIABLES ** --

-- Initial setup of action button gap slider settings
Gypsy_ActionButtonGapMax = Gypsy_DefaultActionButtonGapMax;
Gypsy_ActionButtonGapMin = Gypsy_DefaultActionButtonGapMin;
Gypsy_ActionButtonGapStep = Gypsy_DefaultActionButtonGapStep;
				
-- Initialize a variable to track turn-page-on-press button presses
Gypsy_OverridePageTurn = 0;

-- Original function names
Gypsy_OriginalActionButton_StartFlash = ActionButton_StartFlash;
Gypsy_OriginalActionButton_UpdateState = ActionButton_UpdateState;

-- ** ACTION BAR FUNCTIONS ** --

-- Event registers
function Gypsy_ActionBarOnLoad ()
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("ACTIONBAR_PAGE_CHANGED");
end

-- Configuration registrations and paging controls
function Gypsy_ActionBarOnEvent (event)
	if (event == "VARIABLES_LOADED") then
		-- Check to see if the action bar is a standalone addon or if the GypsyMod shell is available
		if (GYPSY_SHELL == 1) then
			-- Set defaults if there is no saved value
			if (Gypsy_RetrieveSaved("PlaceHoldersToggle") == nil) then
				Gypsy_PlaceHoldersToggle = Gypsy_DefaultPlaceHoldersToggle;	
			else
				Gypsy_PlaceHoldersToggle = Gypsy_RetrieveSaved("PlaceHoldersToggle");
			end
			if (Gypsy_RetrieveSaved("HotKeyLabelsToggle") == nil) then
				Gypsy_HotKeyLabelsToggle = Gypsy_DefaultHotKeyLabelsToggle;	
			else
				Gypsy_HotKeyLabelsToggle = Gypsy_RetrieveSaved("HotKeyLabelsToggle");
			end
			if (Gypsy_RetrieveSaved("ActionButtonGap") == nil) then
				Gypsy_ActionButtonGap = Gypsy_DefaultActionButtonGap;	
			else
				Gypsy_ActionButtonGap = Gypsy_RetrieveSaved("ActionButtonGap");
			end
			if (Gypsy_RetrieveSaved("GroupActionBarPages") == nil) then
				Gypsy_GroupActionBarPages = Gypsy_DefaultGroupActionBarPages;
			else
				Gypsy_GroupActionBarPages = Gypsy_RetrieveSaved("GroupActionBarPages");
			end
			if (Gypsy_RetrieveSaved("AllowPageTurning") == nil) then
				Gypsy_AllowPageTurning = Gypsy_DefaultAllowPageTurning;
			else
				Gypsy_AllowPageTurning = Gypsy_RetrieveSaved("AllowPageTurning");
			end
			if (Gypsy_RetrieveSaved("TurnPageOnPress") == nil) then
				Gypsy_TurnPageOnPress = Gypsy_DefaultTurnPageOnPress;
			else
				Gypsy_TurnPageOnPress = Gypsy_RetrieveSaved("TurnPageOnPress");
			end
			if (Gypsy_RetrieveSaved("ShortenModKey") == nil) then
				Gypsy_ShortenModKey = Gypsy_DefaultShortenModKey;
			else
				Gypsy_ShortenModKey = Gypsy_RetrieveSaved("ShortenModKey");
			end
			if (Gypsy_RetrieveSaved("StripModKey") == nil) then
				Gypsy_StripModKey = Gypsy_DefaultStripModKey;
			else
				Gypsy_StripModKey = Gypsy_RetrieveSaved("StripModKey");
			end
			--Register with GypsyMod saving
			Gypsy_RegisterOption(102, "check", Gypsy_PlaceHoldersToggle, "PlaceHoldersToggle", Gypsy_ActionButtonDisplayUpdate, GYPSY_TEXT_HOTBAR_PLACEHOLDERLABEL, GYPSY_TEXT_HOTBAR_PLACEHOLDERTOOLTIP);
			Gypsy_RegisterOption(103, "check", Gypsy_HotKeyLabelsToggle, "HotKeyLabelsToggle", Gypsy_ActionButtonDisplayUpdate, GYPSY_TEXT_HOTBAR_BINDLABELLABEL, GYPSY_TEXT_HOTBAR_BINDLABELTOOLTIP);
			Gypsy_RegisterOption(104, "slider", Gypsy_ActionButtonGap, "ActionButtonGap", Gypsy_ActionButtonDisplayUpdate, GYPSY_TEXT_HOTBAR_GAPLABEL, GYPSY_TEXT_HOTBAR_GAPTOOLTIP, Gypsy_ActionButtonGapMin, Gypsy_ActionButtonGapMax, Gypsy_ActionButtonGapStep, " px");	
			Gypsy_RegisterOption(105, "button", nil, nil, Gypsy_ActionBarReset, GYPSY_TEXT_HOTBAR_RESETLABEL, GYPSY_TEXT_HOTBAR_RESETTOOLTIP);
			Gypsy_RegisterOption(106, "check", Gypsy_GroupActionBarPages, "GroupActionBarPages", nil, GYPSY_TEXT_HOTBAR_GROUPPAGELABEL, GYPSY_TEXT_HOTBAR_GROUPPAGETOOLTIP);
			Gypsy_RegisterOption(107, "check", Gypsy_AllowPageTurning, "AllowPageTurning", Gypsy_PagingOptionsUpdate, GYPSY_TEXT_HOTBAR_PAGETURNLABEL, GYPSY_TEXT_HOTBAR_PAGETURNTOOLTIP);
			Gypsy_RegisterOption(108, "check", Gypsy_TurnPageOnPress, "TurnPageOnPress", nil, GYPSY_TEXT_HOTBAR_TPOPLABEL, GYPSY_TEXT_HOTBAR_TPOPTOOLTIP);
			Gypsy_RegisterOption(109, "check", Gypsy_ShortenModKey, "ShortenModKey", Gypsy_ShortenKeys, GYPSY_TEXT_HOTBAR_SHORTENLABEL, GYPSY_TEXT_HOTBAR_SHORTENTOOLTIP);
			Gypsy_RegisterOption(110, "check", Gypsy_StripModKey, "StripModKey", Gypsy_StripKeys, GYPSY_TEXT_HOTBAR_STRIPLABEL, GYPSY_TEXT_HOTBAR_STRIPTOOLTIP);
		else
			-- If our toggles aren't saved, set to default
			if (Gypsy_PlaceHoldersToggle == nil) then
				Gypsy_PlaceHoldersToggle = Gypsy_DefaultPlaceHoldersToggle;
			end
			if (Gypsy_HotKeyLabelsToggle == nil) then
				Gypsy_HotKeyLabelsToggle = Gypsy_DefaultHotKeyLabelsToggle;
			end
			if (Gypsy_ActionButtonGap == nil) then
				Gypsy_ActionButtonGap = Gypsy_DefaultActionButtonGap;
			end
			if (Gypsy_GroupActionBarPages == nil) then
				Gypsy_GroupActionBarPages = Gyspy_DefaultGroupActionBarPages;
			end
			if (Gypsy_AllowPageTurning == nil) then
				Gypsy_AllowPageTurning = Gypsy_DefaultAllowPageTurning;
			end
			if (Gypsy_TurnPageOnPress == nil) then
				Gypsy_TurnPageOnPress = Gypsy_DefaultTurnPageOnPress;
			end
			if (Gypsy_ShortenModKey == nil) then
				Gypsy_ShortenModKey = Gypsy_DefaultShortenModKey;
			end
			if (Gypsy_StripModKey == nil) then
				Gypsy_StripModKey = Gypsy_DefaultStripModKey;
			end
			-- Special action bar specific lock setting
			if (Gypsy_LockActionBar == nil) then
				Gypsy_LockActionBar = Gypsy_DefaultLockActionBar;
			end
			-- Save manually for standalone options
			--RegisterForSave("Gypsy_PlaceHoldersToggle");
			--RegisterForSave("Gypsy_HotKeyLabelsToggle");
			--RegisterForSave("Gypsy_ActionButtonGap");
			--RegisterForSave("Gypsy_GroupActionBarPages");
			--RegisterForSave("Gypsy_AllowPageTurning");
			--RegisterForSave("Gypsy_TurnPageOnPress");
			--RegisterForSave("Gypsy_ShortenModKey");
			--RegisterForSave("Gypsy_StripModKey");
			--RegisterForSave("Gypsy_LockActionBar");
			-- Register slash commands
			SlashCmdList["GYPSY_PLACEHOLDERSTOGGLE"] = Gypsy_PlaceHoldersToggleSlashHandler;			
			SLASH_GYPSY_PLACEHOLDERSTOGGLE1 = "/hotbarplaceholders";
			SLASH_GYPSY_PLACEHOLDERSTOGGLE2 = "/hbplaceholders";		
			SlashCmdList["GYPSY_HOTKEYLABELSTOGGLE"] = Gypsy_HotKeyLabelsToggleSlashHandler;			
			SLASH_GYPSY_HOTKEYLABELSTOGGLE1 = "/hotbarhotkeylabels";
			SLASH_GYPSY_HOTKEYLABELSTOGGLE2 = "/hbhotkeylabels";
			SlashCmdList["GYPSY_ACTIONBUTTONGAP"] = Gypsy_ActionButtonGapSlashHandler;			
			SLASH_GYPSY_ACTIONBUTTONGAP1 = "/hotbarbuttongap";
			SLASH_GYPSY_ACTIONBUTTONGAP2 = "/hbbuttongap";
			SlashCmdList["GYPSY_GROUPACTIONBARPAGES"] = Gypsy_GroupActionBarPagesSlashHandler;
			SLASH_GYPSY_GROUPACTIONBARPAGES1 = "/hotbargroupactionpages";
			SLASH_GYPSY_GROUPACTIONBARPAGES2 = "/hbgroupactionpages";
			SlashCmdList["GYPSY_ALLOWPAGETURNING"] = Gypsy_AllowPageTurningSlashHandler;
			SLASH_GYPSY_ALLOWPAGETURNING1 = "/hotbarpageturning";
			SLASH_GYPSY_ALLOWPAGETURNING2 = "/hbpageturning";
			SlashCmdList["GYPSY_TURNPAGEONPRESS"] = Gypsy_TurnPageOnPressSlashHandler;
			SLASH_GYPSY_TURNPAGEONPRESS1 = "/hotbarpageonpress";
			SLASH_GYPSY_TURNPAGEONPRESS2 = "/hbpageonpress";
			SlashCmdList["GYPSY_SHORTENMODKEY"] = Gypsy_ShortenModKeySlashHandler;
			SLASH_GYPSY_SHORTENMODKEY1 = "/hotbarshortenmodkey";
			SLASH_GYPSY_SHORTENMODKEY2 = "/hbshortenmodkey";
			SlashCmdList["GYPSY_STRIPMODKEY"] = Gypsy_StripModKeySlashHandler;
			SLASH_GYPSY_STRIPMODKEY1 = "/hotbarstripmodkey";
			SLASH_GYPSY_STRIPMODKEY2 = "/hbstripmodkey";
			SlashCmdList["GYPSY_LOCKHOTBAR"] = Gypsy_LockHotBarSlashHandler;
			SLASH_GYPSY_LOCKHOTBAR1 = "/hotbarlock";
			SLASH_GYPSY_LOCKHOTBAR2 = "/hblock";
			SlashCmdList["GYPSY_HOTBARRESET"] = Gypsy_HotBarResetSlashHandler;
			SLASH_GYPSY_HOTBARRESET1 = "/hotbarreset";
			SLASH_GYPSY_HOTBARRESET2 = "/hbreset";
		end
		-- Initial application of settings for the HotBar
		Gypsy_UpdateHotBar();
		-- Initial application of settings for mod keys
		Gypsy_UpdateModKeys();
		return;
	end
	-- Lots of controls and checks for our paging options
	if (event == "ACTIONBAR_PAGE_CHANGED") then
		-- Check registrations and update
		if (Gypsy_RetrieveOption ~= nil) then
			if (Gypsy_RetrieveOption(101) ~= nil) then
				Gypsy_EnableHotBar = Gypsy_RetrieveOption(101)[GYPSY_VALUE];
			end
			if (Gypsy_RetrieveOption(106) ~= nil) then
				Gypsy_GroupActionBarPages = Gypsy_RetrieveOption(106)[GYPSY_VALUE];
			end
			if (Gypsy_RetrieveOption(107) ~= nil) then
				Gypsy_AllowPageTurning = Gypsy_RetrieveOption(107)[GYPSY_VALUE];
			end
			if (Gypsy_RetrieveOption(108) ~= nil) then
				Gypsy_TurnPageOnPress = Gypsy_RetrieveOption(108)[GYPSY_VALUE];
			end
		end
		-- We make no paging changes if the HotBar is disabled
		if (Gypsy_EnableHotBar == 1) then
			-- Setup page forms for grouping or default style
			if (Gypsy_GroupActionBarPages == 1) then
				-- Change grouping accordingly
				NUM_ACTIONBAR_PAGES = 3;
				NUM_ACTIONBAR_BUTTONS = 24;
			else
				-- Else set the grouping to default
				NUM_ACTIONBAR_PAGES = 6;
				NUM_ACTIONBAR_BUTTONS = 12;
			end		
			-- If page turning is allowed...
			if (Gypsy_AllowPageTurning == 1) then
				-- And action bar pages are grouped
				if (Gypsy_GroupActionBarPages == 1) then				
					-- Redirect pages 4-6
					if (CURRENT_ACTIONBAR_PAGE == 4) then
						CURRENT_ACTIONBAR_PAGE = 1;
						ChangeActionBarPage();
					elseif (CURRENT_ACTIONBAR_PAGE == 5) then
						CURRENT_ACTIONBAR_PAGE = 2;
						ChangeActionBarPage();
					elseif (CURRENT_ACTIONBAR_PAGE == 6) then
						CURRENT_ACTIONBAR_PAGE = 3;
						ChangeActionBarPage();
					end
				end
			else
				-- If turn-on-press is enabled...
				if (Gypsy_TurnPageOnPress == 1) then
					-- And the assigned button has been pressed...
					if (Gypsy_OverridePageTurn == 1) then
						-- The page needs to be 2
						if (CURRENT_ACTIONBAR_PAGE ~= 2) then
							CURRENT_ACTIONBAR_PAGE = 2;
							ChangeActionBarPage();
						end
					else
						-- Else the page needs to be 1
						if (CURRENT_ACTIONBAR_PAGE ~= 1) then
							CURRENT_ACTIONBAR_PAGE = 1;
							ChangeActionBarPage();
						end
					end
				else
					-- Turn-on-press is disabled, and regular page turning is disabled, so keep page 1 showing
					if (CURRENT_ACTIONBAR_PAGE ~= 1) then
						CURRENT_ACTIONBAR_PAGE = 1;
						ChangeActionBarPage();
					end
				end
			end
		end
		return;
	end
end

function Gypsy_ActionBarOnUpdate()
	-- Check whether the mouse is over our capsule to show or hide it
	Gypsy_ToggleHotBarCapsule();
end
	
-- Function to control the paging for our turn page on press key binding
function Gypsy_TurnOnPress(state)
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(101) ~= nil) then
			Gypsy_EnableHotBar = Gypsy_RetrieveOption(101)[GYPSY_VALUE];
		end
	end
	if (Gypsy_EnableHotBar == 1) then
		-- When the button is pressed down...
		if (state == "down") then
			-- Check registrations and update
			if (Gypsy_RetrieveOption ~= nil) then
				if (Gypsy_RetrieveOption(107) ~= nil) then
					Gypsy_AllowPageTurning = Gypsy_RetrieveOption(107)[GYPSY_VALUE];
				end
				if (Gypsy_RetrieveOption(108) ~= nil) then
					Gypsy_TurnPageOnPress = Gypsy_RetrieveOption(108)[GYPSY_VALUE];
				end
			end
			-- Make sure page turning is disabled, and if our page turn option is enabled, then change to page 2
			if (Gypsy_TurnPageOnPress == 1 and Gypsy_AllowPageTurning == 0) then
				CURRENT_ACTIONBAR_PAGE = 2;
				-- Default action bar page change function
				ChangeActionBarPage();
			end
		end
		-- When the button is let up...
		if (state == "up") then
			-- Check registrations and update
			if (Gypsy_RetrieveOption ~= nil) then
				if (Gypsy_RetrieveOption(107) ~= nil) then
					Gypsy_AllowPageTurning = Gypsy_RetrieveOption(107)[GYPSY_VALUE];
				end
				if (Gypsy_RetrieveOption(108) ~= nil) then
					Gypsy_TurnPageOnPress = Gypsy_RetrieveOption(108)[GYPSY_VALUE];
				end
			end
			-- Make sure page turning is disabled, and if our page turn option is enabled, then change back to page 1
			if (Gypsy_TurnPageOnPress == 1 and Gypsy_AllowPageTurning == 0) then
				CURRENT_ACTIONBAR_PAGE = 1;
				-- Default action bar page change function
				ChangeActionBarPage();
			end
		end
	end
end

-- ** ACTION BUTTON FUNCTIONS ** --

-- Initializations and registrations for each of our action buttons, basically identical to how the default buttons load...
function Gypsy_ActionButtonOnLoad ()
	-- ...Except we take the cheap way to get our button placeholders and key binding labels showing initially
	this.showgrid = 1;
	this.flashing = 0;
	this.flashtime = 0;
	Gypsy_ActionButtonUpdate();
	this:RegisterForDrag("LeftButton", "RightButton");
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	this:RegisterEvent("ACTIONBAR_SHOWGRID");
	this:RegisterEvent("ACTIONBAR_HIDEGRID");
	this:RegisterEvent("ACTIONBAR_PAGE_CHANGED");
	this:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
	this:RegisterEvent("ACTIONBAR_UPDATE_STATE");
	this:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
	this:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("UNIT_AURASTATE");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	this:RegisterEvent("CRAFT_SHOW");
	this:RegisterEvent("CRAFT_CLOSE");
	this:RegisterEvent("TRADE_SKILL_SHOW");
	this:RegisterEvent("TRADE_SKILL_CLOSE");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_MANA");
	this:RegisterEvent("UNIT_RAGE");
	this:RegisterEvent("UNIT_FOCUS");
	this:RegisterEvent("UNIT_ENERGY");
	this:RegisterEvent("UPDATE_BONUS_ACTIONBAR");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("PLAYER_COMBO_POINTS");
	this:RegisterEvent("UPDATE_BINDINGS");
	this:RegisterEvent("START_AUTOREPEAT_SPELL");
	this:RegisterEvent("STOP_AUTOREPEAT_SPELL");
	this:RegisterEvent("VARIABLES_LOADED");
	Gypsy_ActionButtonUpdateHotkeys();
end

-- Update function for our action buttons, no modifications from the default
function Gypsy_ActionButtonUpdate ()
	-- Determine whether or not the button should be flashing or not since the button may have missed the enter combat event
	local pagedID = Gypsy_ActionButtonGetPagedID(this);
	if ( IsAttackAction(pagedID) and IsCurrentAction(pagedID) ) then
		IN_ATTACK_MODE = 1;
	else
		IN_ATTACK_MODE = nil;
	end
	IN_AUTOREPEAT_MODE = IsAutoRepeatAction(pagedID);
	-- Special case code for bonus bar buttons
	-- Prevents the button from updating if the bonusbar is still in an animation transition

	-- Derek, I had to comment this out because it was causing them all to be grayed out after a cinematic...
	if ( this.isBonus and this.inTransition ) then
		Gypsy_ActionButtonUpdateUsable();
		Gypsy_ActionButtonUpdateCooldown();
		return;
	end
	local icon = getglobal(this:GetName().."Icon");
	local buttonCooldown = getglobal(this:GetName().."Cooldown");
	local texture = GetActionTexture(Gypsy_ActionButtonGetPagedID(this));
	if ( texture ) then
		icon:SetTexture(texture);
		icon:Show();
		this.rangeTimer = TOOLTIP_UPDATE_TIME;
		this:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
		-- Save texture if the button is a bonus button, will be needed later
		if ( this.isBonus ) then
			this.texture = texture;
		end
	else
		icon:Hide();
		buttonCooldown:Hide();
		this.rangeTimer = nil;
		this:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
	end
	Gypsy_ActionButtonUpdateCount();
	if ( HasAction(Gypsy_ActionButtonGetPagedID(this)) ) then
		this:Show();
		Gypsy_ActionButtonUpdateUsable();
		Gypsy_ActionButtonUpdateCooldown();
	elseif ( this.showgrid == 0 ) then
		this:Hide();
	else
		getglobal(this:GetName().."Cooldown"):Hide();
	end
	if ( IN_ATTACK_MODE or IN_AUTOREPEAT_MODE ) then
		Gypsy_ActionButtonStartFlash();
	else
		Gypsy_ActionButtonStopFlash();
	end
	
	-- Add a green border if button is an equipped item
	local border = getglobal(this:GetName().."Border");
	if ( IsEquippedAction(ActionButton_GetPagedID(this)) ) then
		border:SetVertexColor(0, 1.0, 0, 0.35);
		border:Show();
	else
		border:Hide();
	end
	
	if ( GameTooltip:IsOwned(this) ) then
		Gypsy_ActionButtonSetTooltip();
	else
		this.updateTooltip = nil;
	end

	-- Update Macro Text
	local macroName = getglobal(this:GetName().."Name");
	macroName:SetText(GetActionText(Gypsy_ActionButtonGetPagedID(this)));
end

-- OnEvent handling for our buttons, again the same as default until a better way than OnUpdate is found to update our button display properties
function Gypsy_ActionButtonOnEvent (event)
	if ( event == "ACTIONBAR_SLOT_CHANGED" ) then
		if ( arg1 == -1 or arg1 == Gypsy_ActionButtonGetPagedID(this) ) then
			Gypsy_ActionButtonUpdate();
		end
		return;
	end
	if (event == "ACTIONBAR_PAGE_CHANGED" or event == "PLAYER_AURAS_CHANGED" or event == "UPDATE_BONUS_ACTIONBAR" ) then
		Gypsy_ActionButtonUpdate();
		Gypsy_ActionButtonUpdateState();
		return;
	end
	if ( event == "ACTIONBAR_SHOWGRID" ) then
		Gypsy_ActionButtonShowGrid();
		return;
	end
	if ( event == "ACTIONBAR_HIDEGRID" ) then
		Gypsy_ActionButtonHideGrid();
		return;
	end
	if ( event == "UPDATE_BINDINGS" ) then
		Gypsy_ActionButtonUpdateHotkeys();
	end

	-- All event handlers below this line MUST only be valid when the button is visible
	if ( not this:IsVisible() ) then
		return;
	end

	if ( event == "PLAYER_TARGET_CHANGED" ) then
		Gypsy_ActionButtonUpdateUsable();
		return;
	end
	if ( event == "UNIT_AURASTATE" ) then
		if ( arg1 == "player" or arg1 == "target" ) then
			Gypsy_ActionButtonUpdateUsable();
		end
		return;
	end
	if ( event == "UNIT_INVENTORY_CHANGED" ) then
		if ( arg1 == "player" ) then
			Gypsy_ActionButtonUpdate();
		end
		return;
	end
	if ( event == "ACTIONBAR_UPDATE_STATE" ) then
		Gypsy_ActionButtonUpdateState();
		return;
	end
	if ( event == "ACTIONBAR_UPDATE_USABLE" ) then
		Gypsy_ActionButtonUpdateUsable();
		return;
	end
	if ( event == "ACTIONBAR_UPDATE_COOLDOWN" ) then
		Gypsy_ActionButtonUpdateCooldown();
		return;
	end
	if ( event == "CRAFT_SHOW" or event == "CRAFT_CLOSE" or event == "TRADE_SKILL_SHOW" or event == "TRADE_SKILL_CLOSE" ) then
		Gypsy_ActionButtonUpdateState();
		return;
	end
	if ( arg1 == "player" and (event == "UNIT_HEALTH" or event == "UNIT_MANA" or event == "UNIT_RAGE" or event == "UNIT_FOCUS" or event == "UNIT_ENERGY") ) then
		Gypsy_ActionButtonUpdateUsable();
		return;
	end
	if ( event == "PLAYER_ENTER_COMBAT" ) then
		IN_ATTACK_MODE = 1;
		if ( IsAttackAction(Gypsy_ActionButtonGetPagedID(this)) ) then
			Gypsy_ActionButtonStartFlash();
		end
		return;
	end
	if ( event == "PLAYER_LEAVE_COMBAT" ) then
		IN_ATTACK_MODE = nil;
		if ( IsAttackAction(Gypsy_ActionButtonGetPagedID(this)) ) then
			Gypsy_ActionButtonStopFlash();
		end
		return;
	end
	if ( event == "PLAYER_COMBO_POINTS" ) then
		Gypsy_ActionButtonUpdateUsable();
		return;
	end
	if ( event == "START_AUTOREPEAT_SPELL" ) then
		IN_AUTOREPEAT_MODE = 1;
		if ( IsAutoRepeatAction(Gypsy_ActionButtonGetPagedID(this)) ) then
			Gypsy_ActionButtonStartFlash();
		end
		return;
	end
	if ( event == "STOP_AUTOREPEAT_SPELL" ) then
		IN_AUTOREPEAT_MODE = nil;
		if ( Gypsy_ActionButtonIsFlashing() and not IsAttackAction(Gypsy_ActionButtonGetPagedID(this)) ) then
			Gypsy_ActionButtonStopFlash();
		end
		return;
	end
end

-- Same as the default function, need to figure out how this operates over time
function Gypsy_ActionButtonOnUpdate(elapsed)
	if ( Gypsy_ActionButtonIsFlashing() ) then
		this.flashtime = this.flashtime - elapsed;
		if ( this.flashtime <= 0 ) then
			local overtime = -this.flashtime;
			if ( overtime >= ATTACK_BUTTON_FLASH_TIME ) then
				overtime = 0;
			end
			this.flashtime = ATTACK_BUTTON_FLASH_TIME - overtime;

			local flashTexture = getglobal(this:GetName().."Flash");
			if ( flashTexture:IsVisible() ) then
				flashTexture:Hide();
			else
				flashTexture:Show();
			end
		end
	end

	-- Handle range indicator
	if ( this.rangeTimer ) then
		if ( this.rangeTimer < 0 ) then
			local count = getglobal(this:GetName().."HotKey");
			if ( IsActionInRange( ActionButton_GetPagedID(this)) == 0 ) then
				count:SetVertexColor(1.0, 0.1, 0.1);
			else
				count:SetVertexColor(0.6, 0.6, 0.6);
			end
			this.rangeTimer = TOOLTIP_UPDATE_TIME;
		else
			this.rangeTimer = this.rangeTimer - elapsed;
		end
	end

	if ( not this.updateTooltip ) then
		return;
	end

	this.updateTooltip = this.updateTooltip - elapsed;
	if ( this.updateTooltip > 0 ) then
		return;
	end

	if ( GameTooltip:IsOwned(this) ) then
		Gypsy_ActionButtonSetTooltip();
	else
		this.updateTooltip = nil;
	end
end

-- Same as the default function, shows grid information for when you are holding an eligable action button candidate
function Gypsy_ActionButtonShowGrid()
	this.showgrid = this.showgrid+1;
	getglobal(this:GetName().."NormalTexture"):SetVertexColor(1.0, 1.0, 1.0);
	this:Show();
	Gypsy_ShowGrid = 1;
end

-- Hooking default show grid function to revert to old style 100% opacity
local originalActionButton_ShowGrid = ActionButton_ShowGrid;
function ActionButton_ShowGrid(button)
	originalActionButton_ShowGrid(button);
	if (not button) then
		button = this;
	end
	getglobal(button:GetName().."NormalTexture"):SetVertexColor(1.0, 1.0, 1.0, 1.0);
end

-- Same as the default function, hides the grid stuff, surprisingly these don't interfere with our functions
function Gypsy_ActionButtonHideGrid()
	this.showgrid = this.showgrid-1;
	if ( this.showgrid == 0 and not HasAction(Gypsy_ActionButtonGetPagedID(this)) ) then
		this:Hide();
	end
	Gypsy_ShowGrid = 0;
end

-- Modified the default function to work for our buttons specifically
function Gypsy_ActionButtonUpdateHotkeys(id)
	-- Get the local ID
	if (id == nil) then
		id = this:GetID();
	end	
	-- If this button is one of our static 5 end buttons, subtract 97, else...
	if (id > 24) then
		id = id - 97;
	else
		-- Subtract 12 to get the name of the button and name of the binding
		id = id - 12;
	end
	-- Action button type, the main portion of the binding string
	local actionButtonType = "GYPSYACTIONBUTTON";
	-- Cooresponding hotkey font string for this button
	local hotkey = getglobal("Gypsy_ActionButton"..id.."HotKey");
	local action = actionButtonType..id;
	-- Get the binding text and set it
	local name = GetBindingText(GetBindingKey(action), "KEY_");	
	-- Get mod key options from Shell
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(109) ~= nil) then
			Gypsy_ShortenModKey = Gypsy_RetrieveOption(109)[GYPSY_VALUE];
		end
		if (Gypsy_RetrieveOption(110) ~= nil) then
			Gypsy_StripModKey = Gypsy_RetrieveOption(110)[GYPSY_VALUE];
		end
	end
	-- If we're shortening mod key labels, then replace each kind with a shorter version
	if (Gypsy_ShortenModKey == 1) then
		name = gsub(name, GYPSY_TEXT_HOTBAR_ALT, GYPSY_TEXT_HOTBAR_ALT_SHORT);
		name = gsub(name, GYPSY_TEXT_HOTBAR_CTRL, GYPSY_TEXT_HOTBAR_CTRL_SHORT);
		name = gsub(name, GYPSY_TEXT_HOTBAR_SHIFT, GYPSY_TEXT_HOTBAR_SHIFT_SHORT);
		name = gsub(name, GYPSY_TEXT_HOTBAR_NUMPAD, GYPSY_TEXT_HOTBAR_NUMPAD_SHORT);
	end
	-- If we're stripping out mod key labels, then replace each kind with nothing
	if (Gypsy_StripModKey == 1) then
		name = gsub(name, GYPSY_TEXT_HOTBAR_ALT, "");
		name = gsub(name, GYPSY_TEXT_HOTBAR_CTRL, "");
		name = gsub(name, GYPSY_TEXT_HOTBAR_SHIFT, "");
		name = gsub(name, GYPSY_TEXT_HOTBAR_NUMPAD.." ", "");
		-- Special code for bindings involving the dash key itself
		_, count = gsub(name, "-", "-");
		local nameLen = strlen(name);
		local lastChar = strsub(name, nameLen);
		if (lastChar == "-") then
			count = count - 1;
		end
		name = gsub(name, "-", "", count);
	end	
	hotkey:SetText(name);		
end

-- Same as the default function
function Gypsy_ActionButtonUpdateUsable()
	local icon = getglobal(this:GetName().."Icon");
	local normalTexture = getglobal(this:GetName().."NormalTexture");
	local isUsable, notEnoughMana = IsUsableAction(Gypsy_ActionButtonGetPagedID(this));
	if ( isUsable ) then
		icon:SetVertexColor(1.0, 1.0, 1.0);
		normalTexture:SetVertexColor(1.0, 1.0, 1.0);
	elseif ( notEnoughMana ) then
		icon:SetVertexColor(0.5, 0.5, 1.0);
		normalTexture:SetVertexColor(0.5, 0.5, 1.0);
	else
		icon:SetVertexColor(0.4, 0.4, 0.4);
		normalTexture:SetVertexColor(1.0, 1.0, 1.0);
	end
end

-- Same as the default function
function Gypsy_ActionButtonUpdateCooldown()
	local cooldown = getglobal(this:GetName().."Cooldown");
	local start, duration, enable = GetActionCooldown(Gypsy_ActionButtonGetPagedID(this));
	CooldownFrame_SetTimer(cooldown, start, duration, enable);
end

-- Same as the default function
function Gypsy_ActionButtonUpdateCount()
	local text = getglobal(this:GetName().."Count");
	local count = GetActionCount(Gypsy_ActionButtonGetPagedID(this));
	if ( count > 1 ) then
		text:SetText(count);
	else
		text:SetText("");
	end
end

-- Same as the default function
function Gypsy_ActionButtonStartFlash()
	this.flashing = 1;
	this.flashtime = 0;
	Gypsy_ActionButtonUpdateState();
end

-- Same as the default function
function Gypsy_ActionButtonStopFlash()
	this.flashing = 0;
	getglobal(this:GetName().."Flash"):Hide();
	Gypsy_ActionButtonUpdateState();
end

-- Same as the default function
function Gypsy_ActionButtonIsFlashing()
	if ( this.flashing == 1 ) then
		return 1;
	else
		return nil;
	end
end

--[[
	Temporary fix for the problem of Blizzard automatically placing attack buttons on regular action button 1 and bonus button 1.
	The resulting problem occurs when a character with a bonus action bar up has nothing in slot 1 - the action button 1 attack button
	will flash and the flashing effects will show through the bonus action slot 1.
]]
function ActionButton_StartFlash()
	if (BonusActionBarFrame:IsVisible() and not this.isBonus) then
		this.flashing = 0;		
	else
		this.flashing = 1;
		this.flashtime = 0;
	end
	ActionButton_UpdateState();
end

function ActionButton_UpdateState()
	if (IsCurrentAction(Gypsy_ActionButtonGetPagedID(this)) or IsAutoRepeatAction(Gypsy_ActionButtonGetPagedID(this))) then
		if (not BonusActionBarFrame:IsVisible() or this.isBonus) then
			this:SetChecked(1);
		end
	else
		this:SetChecked(0);
	end
end

-- Same as the default function
function Gypsy_ActionButtonUpdateState()
	if (IsCurrentAction(Gypsy_ActionButtonGetPagedID(this)) or IsAutoRepeatAction(Gypsy_ActionButtonGetPagedID(this))) then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
end

-- Same as the default function
function Gypsy_ActionButtonSetTooltip()
	if ( GetCVar("UberTooltips") == "1" ) then
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
	else
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	end

	if ( GameTooltip:SetAction(Gypsy_ActionButtonGetPagedID(this)) ) then
		this.updateTooltip = TOOLTIP_UPDATE_TIME;
	else
		this.updateTooltip = nil;
	end
end

-- Same as the default function except modified to not page our extra 5 buttons
function Gypsy_ActionButtonGetPagedID(button)
	if( button == nil ) then
		message("nil button passed into Gypsy_ActionButtonGetPagedID(), contact Jeff");
		return 0;
	end
	if (button:GetID() > 24) then
		return button:GetID();
	end
	local actualPage = math.mod(CURRENT_ACTIONBAR_PAGE-1,NUM_ACTIONBAR_PAGES) +1; 
		
	--if (button.isBonus and actualPage == 1) then 
	--	return (button:GetID() + ((6 + GetBonusBarOffset() - 1) * 12)); 
	--else 
		return (button:GetID() + ((actualPage - 1) * NUM_ACTIONBAR_BUTTONS));
		
	--end 
	--[[if (button.isBonus and CURRENT_ACTIONBAR_PAGE == 1) then
		return (button:GetID() + ((NUM_ACTIONBAR_PAGES + GetBonusBarOffset() - 1) * NUM_ACTIONBAR_BUTTONS));
	else
		return (button:GetID() + ((CURRENT_ACTIONBAR_PAGE - 1) * NUM_ACTIONBAR_BUTTONS))
	end]]
end



-- Default function modified to handle bonus buttons correctly
function ActionButton_GetPagedID(button) 
	local actualPage = math.mod(CURRENT_ACTIONBAR_PAGE-1,NUM_ACTIONBAR_PAGES) +1; 
	if (button == nil) then 
		message("nil button passed into Gypsy_ActionButtonGetPagedID(), contact Jeff"); 
		return 0; 
	end 
	if (button.isBonus and actualPage == 1) then 
		return (button:GetID() + ((6 + GetBonusBarOffset() - 1) * 12)); 
	elseif ( button:GetParent():GetName() == "MultiBarBottomLeft" ) then
		return (button:GetID() + ((BOTTOMLEFT_ACTIONBAR_PAGE - 1) * 12));
	elseif ( button:GetParent():GetName() == "MultiBarBottomRight" ) then
		return (button:GetID() + ((BOTTOMRIGHT_ACTIONBAR_PAGE - 1) * 12));
	elseif ( button:GetParent():GetName() == "MultiBarLeft" ) then
		return (button:GetID() + ((LEFT_ACTIONBAR_PAGE - 1) * 12));
	elseif ( button:GetParent():GetName() == "MultiBarRight" ) then
		return (button:GetID() + ((RIGHT_ACTIONBAR_PAGE - 1) * 12));
	else 
		return (button:GetID() + ((actualPage - 1) * NUM_ACTIONBAR_BUTTONS)) ;
	end 
end

--[[	
	The default ActionButtonDown and up functions do not properly handle button IDs > 12,
	so if we want to add extra buttons, we have to make our own handler code.
	This function is called from the bindings.
]]--
function Gypsy_ActionButtonDown(id)
	if (BonusActionBarFrame:IsVisible()) then
		local button = getglobal("BonusActionButton"..id);
		if (button) then
			if (button:GetButtonState() == "NORMAL") then
				button:SetButtonState("PUSHED");
			end
		end
		return;
	end
	local button = getglobal("ActionButton"..id);
	if (button) then
		if (button:GetButtonState() == "NORMAL") then
			button:SetButtonState("PUSHED");
		end
	end
end

function Gypsy_ActionButtonUp(id, onSelf)
	if (BonusActionBarFrame:IsVisible()) then
		if (id <= 12) then
			local button = getglobal("BonusActionButton"..id);
			if (button:GetButtonState() == "PUSHED") then
				button:SetButtonState("NORMAL");
				-- Used to save a macro
				if ( MacroFrame_SaveMacro ) then
					MacroFrame_SaveMacro();
				end
				UseAction(ActionButton_GetPagedID(button), 0);
				if (IsCurrentAction(ActionButton_GetPagedID(button))) then
					button:SetChecked(1);
				else
					button:SetChecked(0);
				end
				if (INSTANT_ACTIONBAR_RETURN ~= -1) then
					CURRENT_ACTIONBAR_PAGE = INSTANT_ACTIONBAR_RETURN;
					INSTANT_ACTIONBAR_RETURN = -1;
					ChangeActionBarPage();
				end
			end
		else
			if (CURRENT_ACTIONBAR_PAGE < NUM_ACTIONBAR_PAGES) then
				UseAction(id + ((CURRENT_ACTIONBAR_PAGE - 1) * NUM_ACTIONBAR_BUTTONS), 0);
			end
		end
		return;
	end
    if (id <= 12) then
		local button = getglobal("ActionButton"..id);
		if (button:GetButtonState() == "PUSHED") then
			button:SetButtonState("NORMAL");
			-- Used to save a macro
			if ( MacroFrame_SaveMacro ) then
				MacroFrame_SaveMacro();
			end
			UseAction(ActionButton_GetPagedID(button), 0, onSelf);
			if (IsCurrentAction(ActionButton_GetPagedID(button))) then
				button:SetChecked(1);
			else
				button:SetChecked(0);
			end
			if (INSTANT_ACTIONBAR_RETURN ~= -1) then
				CURRENT_ACTIONBAR_PAGE = INSTANT_ACTIONBAR_RETURN;
				INSTANT_ACTIONBAR_RETURN = -1;
				ChangeActionBarPage();
			end
		end
	elseif (id > 24) then
		UseAction(id);
	else
		if (CURRENT_ACTIONBAR_PAGE < NUM_ACTIONBAR_PAGES) then
			UseAction(id + ((CURRENT_ACTIONBAR_PAGE - 1) * NUM_ACTIONBAR_BUTTONS), 0);
		end
	end
end

-- ** CONFIGURATION FUNCTIONS ** --

-- Update our display of button placeholders and hotkey labels
function Gypsy_ActionButtonDisplayUpdate ()
	if (Gypsy_RetrieveOption ~= nil) then
		-- Update our local variables with updated settings from GypsyMod if applicable	
		if (Gypsy_RetrieveOption(101) ~= nil) then
			Gypsy_EnableHotBar = Gypsy_RetrieveOption(101)[GYPSY_VALUE];
		end
		if (Gypsy_RetrieveOption(102) ~= nil) then
			Gypsy_PlaceHoldersToggle = Gypsy_RetrieveOption(102)[GYPSY_VALUE];
		end
		if (Gypsy_RetrieveOption(103) ~= nil) then
			Gypsy_HotKeyLabelsToggle = Gypsy_RetrieveOption(103)[GYPSY_VALUE];
		end	
		if (Gypsy_RetrieveOption(104) ~= nil) then
			Gypsy_ActionButtonGap = Gypsy_RetrieveOption(104)[GYPSY_VALUE];
		end
	end
	-- If the HotBar is disabled, hide placeholders and show labels as is done by default
	if (Gypsy_EnableHotBar == 1) then
		-- If the hotbar is not being moused over, determine what to show, and if it is show both
		if (not Gypsy_HotBarArt:IsVisible()) then
			if (Gypsy_PlaceHoldersToggle == 1) then
				Gypsy_ShowPlaceHolders();
			else
				Gypsy_HidePlaceHolders();
			end
			if (Gypsy_HotKeyLabelsToggle == 1) then
				Gypsy_ShowHotKeyLabels();
			else
				Gypsy_HideHotKeyLabels();
			end
		else
			Gypsy_ShowPlaceHolders();
			Gypsy_ShowHotKeyLabels();
		end
	else
		Gypsy_HidePlaceHolders();
		Gypsy_ShowHotKeyLabels();
	end
	-- Update the button gapping as well
	Gypsy_UpdateActionButtonGap();
end

-- Reset all action bar options to default
function Gypsy_ActionBarReset()
	-- Change settings in our arrays if the shell is present, else update the local variables
	if (GYPSY_SHELL == 1) then
		Gypsy_UpdateValue(101, Gypsy_DefaultEnableHotBar);
		Gypsy_UpdateValue(102, Gypsy_DefaultPlaceHoldersToggle);
		Gypsy_UpdateValue(103, Gypsy_DefaultHotKeyLabelsToggle);
		Gypsy_UpdateValue(104, Gypsy_DefaultActionButtonGap);
		Gypsy_UpdateValue(106, Gypsy_DefaultGroupActionBarPages);
		Gypsy_UpdateValue(107, Gypsy_DefaultAllowPageTurning);
		Gypsy_UpdateValue(108, Gypsy_DefaultTurnPageOnPress);
		Gypsy_UpdateValue(120, Gypsy_DefaultShowMicroButtons);
		Gypsy_UpdateValue(109, Gypsy_DefaultShortenModKey);
		Gypsy_UpdateValue(110, Gypsy_DefaultStripModKey);
	else
		Gypsy_EnableHotBar = Gypsy_DefaultEnableHotBar;
		Gypsy_PlaceHoldersToggle = Gypsy_DefaultPlaceHoldersToggle;
		Gypsy_HotKeyLabelsToggle = Gypsy_DefaultHotKeyLabelsToggle;
		Gypsy_ActionButtonGap = Gypsy_DefaultActionButtonGap;
		Gypsy_GroupActionBarPages = Gypsy_DefaultGroupActionBarPages;
		Gypsy_AllowPageTurning = Gypsy_DefaultAllowPageTurning;
		Gypsy_TurnPageOnPress = Gypsy_DefaultTurnPageOnPress;
		Gypsy_ShowMicroButtons = Gypsy_DefaultShowMicroButtons;
		Gypsy_ShortenModKey = Gypsy_DefaultShortenModKey;
		Gypsy_StripModKey = Gypsy_DefaultStripModKey;
	end
	-- Master hotbar update function
	Gypsy_UpdateHotBar();
	-- Call the action button update function
	Gypsy_ActionButtonDisplayUpdate();
	-- Update paging
	Gypsy_PagingOptionsUpdate();
	Gypsy_UpdateModKeys();
	-- Update the state of our check buttons if the shell is present
	if (GYPSY_SHELL == 1) then
		Gypsy_Option101:SetChecked(Gypsy_DefaultEnableHotBar);
		Gypsy_Option102:SetChecked(Gypsy_DefaultPlaceHoldersToggle);
		Gypsy_Option103:SetChecked(Gypsy_DefaultHotKeyLabelsToggle);
		Gypsy_Option106:SetChecked(Gypsy_DefaultGroupActionBarPages);
		Gypsy_Option107:SetChecked(Gypsy_DefaultAllowPageTurning);
		Gypsy_Option108:SetChecked(Gypsy_DefaultTurnPageOnPress);
		-- Set the action button gap slider to reflect changes
		Gypsy_Option104:SetValue(Gypsy_DefaultActionButtonGap);
		Gypsy_Option120:SetChecked(Gypsy_DefaultShowMicroButtons);
		Gypsy_Option109:SetChecked(Gypsy_DefaultShortenModKey);
		Gypsy_Option110:SetChecked(Gypsy_DefaultStripModKey);
	end
	-- Reset the hotbar position
	Gypsy_HotBarCapsule:ClearAllPoints();
	Gypsy_HotBarCapsule:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, 0);
	Gypsy_MicroButtonCapsule:ClearAllPoints();
	Gypsy_MicroButtonCapsule:SetPoint("BOTTOM", "Gypsy_HotBarCapsule", "TOP", 170, -30);
end

-- Base function to show action button placeholders for the default action bar, our additional bar, and the pet bar
function Gypsy_ShowPlaceHolders ()
	-- Show default action button holders, always going to be 12
	for i=1, 12 do
		local button = getglobal("ActionButton"..i);
		local buttonIcon = getglobal(button:GetName().."Icon");
		local buttonCount = getglobal(button:GetName().."Count");
		local buttonName = getglobal(button:GetName().."Name");
		-- Case code for those with bonus action bars, note we don't show the placeholders from the bonus bar itself, but from the normal action bar, which underlies it
		if (BonusActionBarFrame:IsVisible()) then
			button:Show();
			button.showgrid = 1;
			-- Don't want to see any assigned action buttons that may have gotten set somehow, test this with a rogue's stealth
			buttonIcon:Hide();
			-- Items with a stack count label need to have that label hidden
			buttonCount:Hide();
			-- Macro hotkeys have a macro name that needs to be hidden
			buttonName:Hide();
			button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
			local normalTexture = getglobal(button:GetName().."NormalTexture");
			-- Get rid of the bluish 'disabled' shading that is applied to the button if the icon we hid was for an ability that was unusable
			normalTexture:SetVertexColor(1.0, 1.0, 1.0);
		else
			if (HasAction(Gypsy_ActionButtonGetPagedID(button))) then
				button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
				buttonIcon:Show();
				buttonCount:Show();
				buttonName:Show();
			else
				button:Show();
				buttonIcon:Hide();
				buttonCount:Hide();
				buttonName:Hide();
				button.showgrid = 1;
				button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
			end
		end
	end
	-- Show GypsyMod action button holders, always 17, a good deal simpler than Blizzard made it for their bar:/
	for i=1, 17 do
		local button = getglobal("Gypsy_ActionButton"..i);
		button.showgrid = 1;
		button:Show();
	end
	-- Show pet bar button holders, always 10 (I think, test this with a hunter. If not there's a global variable)
	for i=1, 10 do
		local button = getglobal("PetActionButton"..i);
		local buttonIcon = getglobal(button:GetName().."Icon");
		if (not buttonIcon:IsVisible()) then
			button:Show();
			button.showgrid = 1;
			button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
		end
	end
end

-- Hide all placeholders
function Gypsy_HidePlaceHolders ()
	-- Hide default action button holders, always going to be 12
	for  i=1, 12 do
		local button = getglobal("ActionButton"..i);
		local buttonIcon = getglobal(button:GetName().."Icon");
		local buttonCount = getglobal(button:GetName().."Count");
		local buttonName = getglobal(button:GetName().."Name");
		if (BonusActionBarFrame:IsVisible()) then
			-- Hide all of the normal first bank of buttons if the character has a bonus bar
			button:Hide();
		else
			if (HasAction(Gypsy_ActionButtonGetPagedID(button))) then
				button:Show();
				buttonIcon:Show();
				buttonCount:Show();
				buttonName:Show();
				button:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
			else
				button:Hide();
				buttonIcon:Hide();
				buttonCount:Hide();
				buttonName:Hide();
			end
		end
	end
	-- Hide GypsyMod action button holders, always 17
	for i=1, 17 do
		local button = getglobal("Gypsy_ActionButton"..i);
		local buttonIcon = getglobal(button:GetName().."Icon");
		if (Gypsy_ShowGrid ~= 1) then
			button.showgrid = 0;
			if (not buttonIcon:IsVisible()) then
				-- Have to rehide the whole deal
				button:Hide();
			end
		end
	end
	-- Hide pet bar button holders, always 10
	for i=1, 10 do
		local button = getglobal("PetActionButton"..i);
		local buttonIcon = getglobal(button:GetName().."Icon");
		if (not buttonIcon:IsVisible()) then
			-- Again, have to rehide everything
			button:Hide();
		end
	end
end

-- Show all hotkey labels, on the default action buttons, GypsyMod buttons, and pet buttons
function Gypsy_ShowHotKeyLabels ()
	-- Show default action button labels
	for i=1, 12 do
		local button = getglobal("ActionButton"..i);
		local buttonKey = getglobal(button:GetName().."HotKey");
		buttonKey:Show();
		-- Case code for characters with a bonus bar
		if (BonusActionBarFrame:IsVisible()) then
			local bonusButton = getglobal("BonusActionButton"..i);
			local bonusButtonIcon = getglobal(bonusButton:GetName().."Icon");
			local bonusButtonKey = getglobal(bonusButton:GetName().."HotKey");
			-- Unlike the placeholders, show the actual bonus button's label
			bonusButtonKey:Show();
		end
	end
	-- Show GypsyMod action button labels
	for i=1, 17 do
		local button = getglobal("Gypsy_ActionButton"..i);
		local buttonKey = getglobal(button:GetName().."HotKey");
		buttonKey:Show();
	end
	-- Show pet bar button labels, note this doesn't actually work, although the pet buttons use the same template as all the action buttons, and it does have a hotkey string
	--[[
	for i=1, 10 do
		local button = getglobal("PetActionButton"..i);
		local buttonKey = getglobal(button:GetName().."HotKey");
		buttonKey:Show();
	end	
	]]
end

-- Hide all hotkey labels
function Gypsy_HideHotKeyLabels ()
	-- Hide default action button labels
	for i=1, 12 do
		local button = getglobal("ActionButton"..i);
		local buttonKey = getglobal(button:GetName().."HotKey");
		buttonKey:Hide();
		-- Have to hide any bonus button labels too
		if (BonusActionBarFrame:IsVisible()) then
			local bonusButton = getglobal("BonusActionButton"..i);
			local bonusButtonKey = getglobal(bonusButton:GetName().."HotKey");
			bonusButtonKey:Hide();
		end
	end
	-- Hide GypsyMod action button labels
	for i=1, 17 do
		local button = getglobal("Gypsy_ActionButton"..i);
		local buttonKey = getglobal(button:GetName().."HotKey");
		buttonKey:Hide();
	end
	-- Hide pet bar button labels
	--[[
	for i=1, 10 do
		local button = getglobal("PetActionButton"..i);
		local buttonKey = getglobal(button:GetName().."HotKey");
		buttonKey:Hide();
	end
	]]
end

-- Update Shell menu state when the shorten keys check button is pressed, and then run update function
function Gypsy_ShortenKeys ()
	if (this:GetChecked()) then
		Gypsy_Option110:SetChecked(0);
		Gypsy_UpdateValue(110, 0);
	end
	Gypsy_UpdateModKeys();
end

-- Update Shell menu state when the strip keys check button is pressed, and then run update function
function Gypsy_StripKeys ()
	if (this:GetChecked()) then
		Gypsy_Option109:SetChecked(0);
		Gypsy_UpdateValue(109, 0);
	end
	Gypsy_UpdateModKeys();
end

-- Run through each GypsyMod action button and call the update hotkey function
function Gypsy_UpdateModKeys ()
	for i=13, 24 do
		Gypsy_ActionButtonUpdateHotkeys(i);
	end
	for i=110, 114 do
		Gypsy_ActionButtonUpdateHotkeys(i);
	end
end

-- Disable the turn on press option if page turning is enabled
function Gypsy_PagingOptionsUpdate ()
	-- Check registrations and update
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(107) ~= nil) then
			Gypsy_AllowPageTurning = Gypsy_RetrieveOption(107)[GYPSY_VALUE];
		end
	end
	-- Only doing anything with this function if the Shell is present
	if (GYPSY_SHELL == 1) then
		-- Get the turn on press option button and related text
		local button = getglobal("Gypsy_Option108");
		local string = getglobal("Gypsy_Option108Text");
		-- If page turning is on...
		if (Gypsy_AllowPageTurning == 1) then
			-- Update value to 0 so the function will not work
			Gypsy_UpdateValue(108, 0);
			button:SetChecked(0);
			-- Disable the turn on press option
			button:Disable();
			-- Grey out the text
			string:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);		
		else
			-- Else enable the option
			button:Enable();
			-- And restore text color
			string:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		end
	end
end

-- Move everything around that needs to be moved when we change action button gapping
function Gypsy_UpdateActionButtonGap()	
	-- If the HotBar is not enabled we have to use the default gap, prevents changing of the gap
	if (Gypsy_EnableHotBar == 0) then
		Gypsy_ActionButtonGap = Gypsy_DefaultActionButtonGap;
		if (GYPSY_SHELL == 1) then
			Gypsy_UpdateValue(104, Gypsy_DefaultActionButtonGap);
		end
	end
	-- Change the HotBar capsule size to adjust for gapping
	if (Gypsy_ActionButtonGap == 8) then
		Gypsy_HotBarCapsule:SetWidth(759);
		Gypsy_HotBarArt:SetWidth(759);
	elseif (Gypsy_ActionButtonGap == 6) then
		Gypsy_HotBarCapsule:SetWidth(727);
		Gypsy_HotBarArt:SetWidth(727);
	elseif (Gypsy_ActionButtonGap == 4) then
		Gypsy_HotBarCapsule:SetWidth(695);
		Gypsy_HotBarArt:SetWidth(695);
	elseif (Gypsy_ActionButtonGap == 2) then
		Gypsy_HotBarCapsule:SetWidth(663);
		Gypsy_HotBarArt:SetWidth(663);
	end	
	-- Change anchoring of each regular action button except for button 1, which we anchor off of to start
	for i=2, 12 do
		-- Get current button
		local button = getglobal("ActionButton"..i);
		-- Decrement the ID
		local lastID = i - 1;
		-- Get the last button
		local lastButton = "ActionButton"..lastID;
		-- Change horizontal offset
		button:ClearAllPoints();
		button:SetPoint("LEFT", lastButton, "RIGHT", Gypsy_ActionButtonGap, 0);
	end
	-- See if we're using a bonus action bar
	if (BonusActionBarFrame:IsVisible()) then
		-- Change anchor of each bonus action button
		for i=2, 12 do
			-- Get current button
			local button = getglobal("BonusActionButton"..i);
			-- Decrement the ID
			local lastID = i - 1;
			-- Get the last button
			local lastButton = "BonusActionButton"..lastID;
			-- Change horizontal offset
			button:ClearAllPoints();
			button:SetPoint("LEFT", lastButton, "RIGHT", Gypsy_ActionButtonGap, 0);			
		end
	end
	-- Change anchor for each GypsyMod action button
	for i=1, 17 do
		-- Get current button
		local button = getglobal("Gypsy_ActionButton"..i);
		-- Decrement the ID
		local lastID = i - 1;
		-- Get the last button
		local lastButton = "Gypsy_ActionButton"..lastID;
		-- If this is the first button...
		if (i == 1) then
			-- Calculate how much to move the GypsyMod buttons down
			local gap = Gypsy_ActionButtonGapMax - Gypsy_ActionButtonGap;
			local negativeGap = gap - (gap * 2);
			local useGap = negativeGap + 2;
			-- Change the vertical offset
			button:ClearAllPoints();
			button:SetPoint("TOPLEFT", "Gypsy_ActionBar", "TOPLEFT", 0, useGap);
		else
			-- Change the horizontal offset
			button:ClearAllPoints();
			button:SetPoint("LEFT", lastButton, "RIGHT", Gypsy_ActionButtonGap, 0);
		end
	end
	-- See if we're using the pet action frame
	--if (PetActionBarFrame:IsVisible()) then
	if (PetHasActionBar()) then
		-- Change anchors on the pet action buttons
		for i=1, 10 do
			-- Get current button
			local button = getglobal("PetActionButton"..i);
			-- Decrement the ID
			local lastID = i - 1;
			-- Get the last button
			local lastButton = "PetActionButton"..lastID;
			-- Need to use completely different gapping for when the HotBar is disabled
			if (Gypsy_EnableHotBar == 1) then
				if (i == 1) then
					local gap = Gypsy_ActionButtonGapMax - Gypsy_ActionButtonGap;
					local negativeGap = gap - (gap * 2)
					local useGap = negativeGap - 10;
					button:ClearAllPoints();
					button:SetPoint("TOPLEFT", "PetActionBarFrame", "TOPLEFT", 36, useGap);
				else
					button:ClearAllPoints();
					button:SetPoint("LEFT", lastButton, "RIGHT", Gypsy_ActionButtonGap, 0);
				end
			else
				if (i == 1) then
					button:ClearAllPoints();
					button:SetPoint("BOTTOMLEFT", "PetActionBarFrame", "BOTTOMLEFT", 36, 1);
				else
					button:ClearAllPoints();
					button:SetPoint("LEFT", lastButton, "RIGHT", 8, 0);
				end
			end
		end
	end
	-- Move the main backpack button depending on the gapping
	local gap = Gypsy_ActionButtonGapMax - Gypsy_ActionButtonGap;
	local negativeGap = gap - (gap * 2);
	local bagGap = gap - 7;
	MainMenuBarBackpackButton:ClearAllPoints();
	-- Different locations depending on if the HotBar is enabled
	if (Gypsy_EnableHotBar == 1) then
		MainMenuBarBackpackButton:SetPoint("TOP", "Gypsy_ActionButton17", "BOTTOM", 0, bagGap);
	else
		MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", "MainMenuBarArtFrame", "BOTTOMRIGHT", -6, 2);
	end	
	-- Move the remaining bag buttons anchored to the backpack button
	for i=0, 3 do
		-- Get current button
		local button = getglobal("CharacterBag"..i.."Slot");
		-- Decrement the ID
		local lastID = i-1;
		-- Get the last button
		local lastButton = "CharacterBag"..lastID.."Slot";
		-- Convert our gap number to negative, since we're going the other way
		local negativeGap = Gypsy_ActionButtonGap - (Gypsy_ActionButtonGap * 2);
		-- Add one because the bag buttons are slightly different than action buttons
		local bagGap = negativeGap + 1;
		button:ClearAllPoints();
		-- If this is the first, anchor it to the backpack button, else anchor it to the last button
		if (i == 0) then
			button:SetPoint("RIGHT", "MainMenuBarBackpackButton", "LEFT", bagGap, 0);
		else
			button:SetPoint("RIGHT", lastButton, "LEFT", bagGap, 0);
		end
	end
	-- Different locations depending on if the HotBar is enabled
	if (Gypsy_EnableHotBar == 1) then
		if (SHOW_MULTI_ACTIONBAR_1 and SHOW_MULTI_ACTIONBAR_2) then
			MultiBarBottomLeft:ClearAllPoints();
			MultiBarBottomLeft:SetPoint("BOTTOMLEFT", "Gypsy_ActionButton1", "TOPLEFT", 0, Gypsy_ActionButtonGap);
			MultiBarBottomRight:ClearAllPoints();
			MultiBarBottomRight:SetPoint("BOTTOMLEFT", "MultiBarBottomLeft", "TOPLEFT", 0, Gypsy_ActionButtonGap);
			ShapeshiftBarFrame:ClearAllPoints();
			ShapeshiftBarFrame:SetPoint("BOTTOMLEFT", "MultiBarBottomRight", "TOPLEFT", 25, Gypsy_ActionButtonGap);
		elseif (SHOW_MULTI_ACTIONBAR_2) then
			MultiBarBottomRight:ClearAllPoints();
			MultiBarBottomRight:SetPoint("BOTTOMLEFT", "Gypsy_ActionButton1", "TOPLEFT", 0, Gypsy_ActionButtonGap);
			ShapeshiftBarFrame:ClearAllPoints();
			ShapeshiftBarFrame:SetPoint("BOTTOMLEFT", "MultiBarBottomRight", "TOPLEFT", 25, Gypsy_ActionButtonGap);
		elseif (SHOW_MULTI_ACTIONBAR_1) then
			MultiBarBottomLeft:ClearAllPoints();
			MultiBarBottomLeft:SetPoint("BOTTOMLEFT", "Gypsy_ActionButton1", "TOPLEFT", 0, Gypsy_ActionButtonGap);
			ShapeshiftBarFrame:ClearAllPoints();
			ShapeshiftBarFrame:SetPoint("BOTTOMLEFT", "MultiBarBottomLeft", "TOPLEFT", 25, Gypsy_ActionButtonGap);
		else
			ShapeshiftBarFrame:ClearAllPoints();
			ShapeshiftBarFrame:SetPoint("BOTTOMLEFT", "Gypsy_ActionButton1", "TOPLEFT", 25, Gypsy_ActionButtonGap);
		end
		-- Left bottom bar
		local button = getglobal("MultiBarBottomLeftButton1");
		button:ClearAllPoints();
		button:SetPoint("BOTTOMLEFT", "MultiBarBottomLeft", "BOTTOMLEFT", 0, 0);
		for i=2, 12 do
			button = getglobal("MultiBarBottomLeftButton"..i);
			button:ClearAllPoints();
			button:SetPoint("LEFT", "MultiBarBottomLeftButton"..i-1, "RIGHT", Gypsy_ActionButtonGap, 0);
		end
		-- Right bottom bar
		button = getglobal("MultiBarBottomRightButton1");
		button:ClearAllPoints();
		button:SetPoint("BOTTOMLEFT", "MultiBarBottomRight", "BOTTOMLEFT", 0, 0);
		for i=2, 12 do
			button = getglobal("MultiBarBottomRightButton"..i);
			button:ClearAllPoints();
			button:SetPoint("LEFT", "MultiBarBottomRightButton"..i-1, "RIGHT", Gypsy_ActionButtonGap, 0);
		end
	else
		MultiBarBottomLeft:ClearAllPoints();
		MultiBarBottomLeft:SetPoint("BOTTOMLEFT", "ActionButton1", "TOPLEFT", 0, 17);
		MultiBarBottomRight:ClearAllPoints();
		MultiBarBottomRight:SetPoint("LEFT", "MultiBarBottomLeft", "RIGHT", 10, 0);
		ShapeshiftBarFrame:ClearAllPoints();
		ShapeshiftBarFrame:SetPoint("BOTTOMLEFT", "MainMenuBar", "TOPLEFT", 30, 0);
		ShapeshiftBar_UpdatePosition();
		-- Left bottom bar
		local button = getglobal("MultiBarBottomLeftButton1");
		button:ClearAllPoints();
		button:SetPoint("BOTTOMLEFT", "MultiBarBottomLeft", "BOTTOMLEFT", 0, 0);
		for i=2, 12 do
			button = getglobal("MultiBarBottomLeftButton"..i);
			button:ClearAllPoints();
			button:SetPoint("LEFT", "MultiBarBottomLeftButton"..i-1, "RIGHT", 6, 0);
		end
		-- Right bottom bar
		button = getglobal("MultiBarBottomRightButton1");
		button:ClearAllPoints();
		button:SetPoint("BOTTOMLEFT", "MultiBarBottomRight", "BOTTOMLEFT", 0, 0);
		for i=2, 12 do
			button = getglobal("MultiBarBottomRightButton"..i);
			button:ClearAllPoints();
			button:SetPoint("LEFT", "MultiBarBottomRightButton"..i-1, "RIGHT", 6, 0);
		end
	end
end

-- ** SLASH COMMAND HANDLER FUNCTIONS ** --

function Gypsy_PlaceHoldersToggleSlashHandler(msg)
	-- Due to the nature of slash commands, 'msg' will never be nil, so we don't require a check
	msg = string.lower(msg);
	if (msg == "show" or msg == "1" or msg == "true") then
		Gypsy_PlaceHoldersToggle = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Showing action button placeholders.", 1, 1, 1);
	elseif (msg == "hide" or msg == "0" or msg == "false") then
		Gypsy_PlaceHoldersToggle = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Hiding action button placeholders.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_PlaceHoldersToggle = Gypsy_DefaultPlaceHoldersToggle;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting action button placeholder state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarplaceholders /hbplaceholders", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   show, true, or 1 - Show placeholders for unassigned action buttons.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   hide, false, or 0 - Hide placeholders.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_PlaceHoldersToggle == 1) then 
			Gypsy_PlaceHoldersToggle = 0; 
			DEFAULT_CHAT_FRAME:AddMessage("Hiding action button placeholders.", 1, 1, 1);
		else 
			Gypsy_PlaceHoldersToggle = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Showing action button placeholders.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarplaceholders /hbplaceholders", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   show, true, or 1 - Show placeholders for unassigned action buttons.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   hide, false, or 0 - Hide placeholders.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
	Gypsy_ActionButtonDisplayUpdate();
end

function Gypsy_HotKeyLabelsToggleSlashHandler(msg)
	msg = string.lower(msg);
	if (msg == "show" or msg == "1" or msg == "true") then
		Gypsy_HotKeyLabelsToggle = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Showing action button key binding labels.", 1, 1, 1);
	elseif (msg == "hide" or msg == "0" or msg == "false") then
		Gypsy_HotKeyLabelsToggle = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Hiding action button key binding labels.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_HotKeyLabelsToggle = Gypsy_DefaultHotKeyLabelsToggle;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting action button key binding labels state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarhotkeylabels /hbhotkeylabels", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   show, true, or 1 - Show binding labels on action buttons.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   hide, false, or 0 - Hide labels.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_HotKeyLabelsToggle == 1) then 
			Gypsy_HotKeyLabelsToggle = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Hiding action button key binding labels.", 1, 1, 1);
		else 
			Gypsy_HotKeyLabelsToggle = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Showing action button key binding labels.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarhotkeylabels /hbhotkeylabels", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   show, true, or 1 - Show binding labels on action buttons.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   hide, false, or 0 - Hide labels.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
	Gypsy_ActionButtonDisplayUpdate();
end

function Gypsy_ActionButtonGapSlashHandler(msg)
	msg = string.lower(msg);
	if (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_ActionButtonGap = Gypsy_DefaultActionButtonGap;
		Gypsy_ActionButtonDisplayUpdate();
		DEFAULT_CHAT_FRAME:AddMessage("Reverting action button gap to default amount.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarbuttongap /hbbuttongap", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   8, 6, 4, 2 - Set gap between action buttons to this value.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
	elseif (msg ~= "8" and msg ~= "6" and msg ~= "4" and msg ~= "2") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarbuttongap /hbbuttongap", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   8, 6, 4, 2 - Set gap between action buttons to this value.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
	else
		Gypsy_ActionButtonGap = msg;
		Gypsy_ActionButtonDisplayUpdate();
		DEFAULT_CHAT_FRAME:AddMessage("Setting action button gap to "..msg.." pixels.", 1, 1, 1);
	end
end

function Gypsy_GroupActionBarPagesSlashHandler(msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_GroupActionBarPages = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Grouping GypsyMod and default action bar pages for accurate paging.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_GroupActionBarPages = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Setting paging behavior to default style.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_GroupActionBarPages = Gypsy_DefaultGroupActionBarPages;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting action page grouping to default state.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbargroupactionpages /hbgroupactionpages", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Group GypsyMod and default action bar pages for accurate paging.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not group action bar pages, turn one row of 12 buttons at a time.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_GroupActionBarPages == 1) then
			Gypsy_GroupActionBarPages = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Setting paging behavior to default style.", 1, 1, 1);
		else
			Gypsy_GroupActionBarPages = 1;
			DEFAULT_CHAT_FRAME:AddMessage("Grouping GypsyMod and default action bar pages for accurate paging.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbargroupactionpages /hbgroupactionpages", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Group GypsyMod and default action bar pages for accurate paging.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not group action bar pages, turn one row of 12 buttons at a time.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
end

function Gypsy_AllowPageTurningSlashHandler(msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_AllowPageTurning = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Allowing page turning, disallowing turn-page-on-press function.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_AllowPageTurning = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Disallowing page turning, turn-page-on-press function available.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_AllowPageTurning = Gypsy_DefaultAllowPageTurning;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting page turning option state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarpageturning /hbpageturning", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Allow action bar page turning, disables Turn-Page-On-Press feature.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Disallow page turning.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_AllowPageTurning == 1) then
			Gypsy_AllowPageTurning = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Disallowing page turning, turn-page-on-press function available.", 1, 1, 1);
		else
			Gypsy_AllowPageTurning = 1;
			DEFAULT_CHAT_FRAME:AddMessage("Allowing page turning, disallowing turn-page-on-press function.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarpageturning /hbpageturning", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Allow action bar page turning, disables Turn-Page-On-Press feature.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Disallow page turning.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
end

function Gypsy_TurnPageOnPressSlashHandler(msg)
	msg = string.lower(msg);
	if (msg == "enable" or msg == "1" or msg == "true") then
		Gypsy_TurnPageOnPress = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Enabling turn-page-on-press function.", 1, 1, 1);
	elseif (msg == "disable" or msg == "0" or msg == "false") then
		Gypsy_TurnPageOnPress = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Disabling turn-page-on-press function.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_TurnPageOnPress = Gypsy_DefaultTurnPageOnPress;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting turn-page-on-press option state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarpageonpress /hbpageonpress", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   enable, true, or 1 - Enables Turn-Page-On-Press, which turns to the next action bar page when you press and hold a key that you set in the key bindings page.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   disable, false, or 0 - Disable Turn-Page-On-Press.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_TurnPageOnPress == 1) then
			Gypsy_TurnPageOnPress = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Disabling turn-page-on-press function.", 1, 1, 1);
		else
			Gypsy_TurnPageOnPress = 1;
			DEFAULT_CHAT_FRAME:AddMessage("Enabling turn-page-on-press function.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarpageonpress /hbpageonpress", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   enable, true, or 1 - Enables Turn-Page-On-Press, which turns to the next action bar page when you press and hold a key that you set in the key bindings page.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   disable, false, or 0 - Disable Turn-Page-On-Press.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
end

function Gypsy_ShortenModKeySlashHandler(msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_ShortenModKey = 1;
		Gypsy_StripModKey = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Shortening key binding label mod keys.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_ShortenModKey = 0;
		Gypsy_StripModKey = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Displaying normal key binding label mod keys.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_ShortenModKey = Gypsy_DefaultShortenModKey;
		Gypsy_StripModKey = Gypsy_DefaultStripModKey;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting shorten mod key option state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarshortenmodkey /hbshortenmodkey", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   enable, true, or 1 - Shortens key binding label mod keys", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   disable, false, or 0 - Sets key binding mod key labels to normal.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_ShortenModKey == 1) then
			Gypsy_ShortenModKey = 0;
			Gypsy_StripModKey = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Displaying normal key binding label mod keys.", 1, 1, 1);
		else
			Gypsy_ShortenModKey = 1;
			Gypsy_StripModKey = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Shortening key binding label mod keys.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarshortenmodkey /hbshortenmodkey", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   enable, true, or 1 - Shortens key binding label mod keys", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   disable, false, or 0 - Sets key binding mod key labels to normal.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
	Gypsy_UpdateModKeys();
end

function Gypsy_StripModKeySlashHandler(msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_ShortenModKey = 0;
		Gypsy_StripModKey = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Stripping key binding label mod keys.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_ShortenModKey = 0;
		Gypsy_StripModKey = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Displaying normal key binding label mod keys.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_ShortenModKey = Gypsy_DefaultShortenModKey;
		Gypsy_StripModKey = Gypsy_DefaultStripModKey;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting shorten mod key option state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarstripmodkey /hbstripmodkey", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   enable, true, or 1 - Strips key binding label mod keys", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   disable, false, or 0 - Sets key binding mod key labels to normal.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_StripModKey == 1) then
			Gypsy_ShortenModKey = 0;
			Gypsy_StripModKey = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Displaying normal key binding label mod keys.", 1, 1, 1);
		else
			Gypsy_ShortenModKey = 0;
			Gypsy_StripModKey = 1;
			DEFAULT_CHAT_FRAME:AddMessage("Stripping key binding label mod keys.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarstripmodkey /hbstripmodkey", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   enable, true, or 1 - Strips key binding label mod keys", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   disable, false, or 0 - Sets key binding mod key labels to normal.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
	Gypsy_UpdateModKeys();
end

function Gypsy_LockHotBarSlashHandler(msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_LockActionBar = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Locking HotBar capsule.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_LockActionBar = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Unlocking HotBar capsule.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_LockActionBar = Gypsy_DefaultLockActionBar;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting HotBar lock state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarlock /hblock", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Locks HotBar capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Unlocks HotBar capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_LockActionBar == 1) then
			Gypsy_LockActionBar = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Unlocking HotBar capsule.", 1, 1, 1);
		else
			Gypsy_LockActionBar = 1;
			DEFAULT_CHAT_FRAME:AddMessage("Locking HotBar capsule.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarlock /hblock", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Locks HotBar capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Unlocks HotBar capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
	Gypsy_UpdateModKeys();
end

function Gypsy_HotBarResetSlashHandler(msg)
	Gypsy_ActionBarReset();
	DEFAULT_CHAT_FRAME:AddMessage("Resetting all HotBar parameters.", 1, 1, 1);
end