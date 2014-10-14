--[[
	Gypsy_MicroButtons.lua
	GypsyVersion++2004.11.15++

	Capsule to allow movement of micro menu buttons.
	
]]

-- ** DEFAULT SETTINGS **--

-- Default MicroButton capsule show, off
Gypsy_DefaultShowMicroButtons = 0;
-- Default local lock setting
Gypsy_DefaultLockMicroButtonsCapsule = 0;

-- ** GENERAL VARIABLES ** --

-- Save original talent button update function
Gypsy_OriginalUpdateTalentButton = UpdateTalentButton;

-- ** MICRO BUTTON CAPSULE FUNCTIONS ** --

-- Event registers
function Gypsy_MicroButtonCapsuleOnLoad ()
	this:RegisterEvent("VARIABLES_LOADED");
end

-- Registrations
function Gypsy_MicroButtonCapsuleOnEvent (event)
	if (event == "VARIABLES_LOADED") then
		if (GYPSY_SHELL == 1) then
			if (Gypsy_RetrieveSaved("ShowMicroButtons") == nil) then
				Gypsy_ShowMicroButtons = Gypsy_DefaultShowMicroButtons;
			else
				Gypsy_ShowMicroButtons = Gypsy_RetrieveSaved("ShowMicroButtons");
			end
			Gypsy_RegisterOption(120, "check", Gypsy_ShowMicroButtons, "ShowMicroButtons", Gypsy_UpdateMicroButtons, GYPSY_TEXT_HOTBAR_SHOWMENULABEL, GYPSY_TEXT_HOTBAR_SHOWMENUTOOLTIP);
		else
			if (Gypsy_ShowMicroButtons == nil) then
				Gypsy_ShowMicroButtons = Gypsy_DefaultShowMicroButtons;
			end
			--RegisterForSave("Gypsy_ShowMicroButtons");
			SlashCmdList["GYPSY_SHOWMICROBUTTONS"] = Gypsy_ShowMicroButtonsSlashHandler;
			SLASH_GYPSY_SHOWMICROBUTTONS1 = "/hotbarshowmenubuttons";
			SLASH_GYPSY_SHOWMICROBUTTONS2 = "/hbshowmenubuttons";
			SlashCmdList["GYPSY_LOCKMICROBUTTONS"] = Gypsy_LockMicroButtonsSlashHandler;
			SLASH_GYPSY_LOCKMICROBUTTONS1 = "/hotbarlockmenubuttons";
			SLASH_GYPSY_LOCKMICROBUTTONS2 = "/hblockmenubuttons";
		end
		return;
	end
end	

-- Set the capsule backdrop if it shows
function Gypsy_MicroButtonCapsuleArtOnShow ()
	this:SetBackdropBorderColor(0, 0, 0);
	this:SetBackdropColor(0, 0, 0);
end

-- Function to show and hide the menu when the key binding to do so is pressed
function Gypsy_ShowMenuExecuteBinding ()
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(120) ~= nil) then
			Gypsy_ShowMicroButtons = Gypsy_RetrieveOption(120)[GYPSY_VALUE];
		end
	end
	-- Simply toggle
	if (Gypsy_ShowMicroButtons == 1) then
		Gypsy_ShowMicroButtons = 0;
	else
		Gypsy_ShowMicroButtons = 1;
	end
	-- Update setting in Shell
	if (GYPSY_SHELL == 1) then
		Gypsy_UpdateValue(120, Gypsy_ShowMicroButtons);
	end
	-- Update function
	Gypsy_UpdateMicroButtons();
end

-- Capsule watch
function Gypsy_MicroButtonCapsuleOnUpdate ()
	Gypsy_ToggleMicroButtonCapsule();
end

-- Capsule toggle
function Gypsy_ToggleMicroButtonCapsule ()
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(120) ~= nil) then
			Gypsy_ShowMicroButtons = Gypsy_RetrieveOption(120)[GYPSY_VALUE];
		end
	end
	if (Gypsy_ShowMicroButtons == 1) then
		-- If Shell is present, update the local lock setting
		if (GYPSY_SHELL ~= nil) then
			Gypsy_LockMicroButtonsCapsule = GYPSY_LOCKALL;
		end	
		-- Then, if the action bar is not locked, go ahead and show/hide or drag the capsule as needed, or if it is locked, hide the capsule so it can't be dragged
		if (Gypsy_LockMicroButtonsCapsule == 0) then
			-- Make sure the capsule is showing, it might have been previously hidden
			if (not Gypsy_MicroButtonCapsule:IsVisible()) then
				Gypsy_MicroButtonCapsule:Show();
			end
			-- Quick function to check if the mouse is anywhere over our capsule
			if (MouseIsOver(Gypsy_MicroButtonCapsule)) then
				Gypsy_MicroButtonCapsuleArt:Show();
			else
				Gypsy_MicroButtonCapsuleArt:Hide();
			end
		else
			Gypsy_MicroButtonCapsule:Hide();
		end
	else
		Gypsy_MicroButtonCapsule:Hide();
	end
end

-- Move/Show micro buttons as we need
function Gypsy_UpdateMicroButtons ()
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(101) ~= nil) then
			Gypsy_EnableHotBar = Gypsy_RetrieveOption(101)[GYPSY_VALUE];
		end
		if (Gypsy_RetrieveOption(120) ~= nil) then
			Gypsy_ShowMicroButtons = Gypsy_RetrieveOption(120)[GYPSY_VALUE];
		end
	end
	-- If the HotBar is enabled, determine if we're showing micro buttons or not. Else show them in their default spots, and hide the capsule.
	if (Gypsy_EnableHotBar == 1) then
		-- Show micro buttons, reroute the talent button function, and anchor to the capsule
		if (Gypsy_ShowMicroButtons == 1) then
			Gypsy_MicroButtonCapsule:Show();
			CharacterMicroButton:Show();
			CharacterMicroButton:ClearAllPoints();
			CharacterMicroButton:SetPoint("BOTTOMLEFT", "Gypsy_MicroButtonCapsule", "BOTTOMLEFT", 6, 6);
			SpellbookMicroButton:Show();
			QuestLogMicroButton:Show();
			SocialsMicroButton:Show();
			WorldMapMicroButton:Show();
			MainMenuMicroButton:Show();
			HelpMicroButton:Show();
			UpdateTalentButton = Gypsy_OriginalUpdateTalentButton;
			UpdateTalentButton();
		else
			-- Hide everything, destroy the pesky talent button function
			Gypsy_MicroButtonCapsule:Hide();
			CharacterMicroButton:Hide();
			SpellbookMicroButton:Hide();
			QuestLogMicroButton:Hide();
			SocialsMicroButton:Hide();
			WorldMapMicroButton:Hide();
			MainMenuMicroButton:Hide();
			HelpMicroButton:Hide();	
			TalentMicroButton:Hide();
			UpdateTalentButton = function()
				return;
			end
		end
	else
		-- Hide the capsule, reset buttons to default position, restore talent button function
		Gypsy_MicroButtonCapsule:Hide();
		CharacterMicroButton:Show();
		CharacterMicroButton:ClearAllPoints();
		CharacterMicroButton:SetPoint("BOTTOMLEFT", "MainMenuBarArtFrame", "BOTTOMLEFT", 546, 2);
		SpellbookMicroButton:Show();
		QuestLogMicroButton:Show();
		SocialsMicroButton:Show();
		WorldMapMicroButton:Show();
		MainMenuMicroButton:Show();
		HelpMicroButton:Show();
		UpdateTalentButton = Gypsy_OriginalUpdateTalentButton;
		UpdateTalentButton();
	end
end

-- ** SLASH HANDLERS ** --
	
function Gypsy_ShowMicroButtonsSlashHandler (msg)
	-- Due to the nature of slash commands, 'msg' will never be nil, so we don't require a check
	msg = string.lower(msg);
	if (msg == "show" or msg == "1" or msg == "true") then
		Gypsy_ShowMicroButtons = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Showing menu buttons & capsule.", 1, 1, 1);
	elseif (msg == "hide" or msg == "0" or msg == "false") then
		Gypsy_ShowMicroButtons= 0;
		DEFAULT_CHAT_FRAME:AddMessage("Hiding menu buttons & capsule.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_ShowMicroButtons = Gypsy_DefaultShowMicroButtons;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting menu button display state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarshowmenubuttons /hbshowmenubuttons", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   show, true, or 1 - Show menu buttons & capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   hide, false, or 0 - Hide menu buttons & capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_ShowMicroButtons == 1) then 
			Gypsy_ShowMicroButtons = 0; 
			DEFAULT_CHAT_FRAME:AddMessage("Hiding menu buttons & capsule.", 1, 1, 1);
		else 
			Gypsy_ShowMicroButtons = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Showing menu buttons & capsule.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarshowmenubuttons /hbshowmenubuttons", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   show, true, or 1 - Show menu buttons & capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   hide, false, or 0 - Hide menu buttons & capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
	Gypsy_UpdateMicroButtons();
end

function Gypsy_LockMicroButtonsSlashHandler (msg)
	-- Due to the nature of slash commands, 'msg' will never be nil, so we don't require a check
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_LockMicroButtonsCapsule = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Locking menu buttons capsule.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_LockMicroButtonsCapsule= 0;
		DEFAULT_CHAT_FRAME:AddMessage("Unlocking menu buttons capsule.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_LockMicroButtonsCapsule = Gypsy_DefaultLockMicroButtonsCapsule;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting menu button capsule lock state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarlockmenubuttons /hblockmenubuttons", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Lock menu buttons capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Unlock menu buttons capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_LockMicroButtonsCapsule == 1) then 
			Gypsy_LockMicroButtonsCapsule = 0; 
			DEFAULT_CHAT_FRAME:AddMessage("Unlocking menu buttons capsule.", 1, 1, 1);
		else 
			Gypsy_LockMicroButtonsCapsule = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Locking menu buttons capsule.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarlockmenubuttons /hblockmenubuttons", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Lock menu buttons capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Unlock menu buttons capsule.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
end