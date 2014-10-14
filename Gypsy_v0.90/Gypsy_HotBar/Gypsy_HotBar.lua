--[[
	Gypsy_HotBar.lua
	GypsyVersion++2004.11.14++
	
	This is our main action bar mod file.
	We've created an encapsulating frame
	to anchor the default action bar, bag
	buttons, and our own action buttons to.
	We can then allow for all of these to
	be dragged along with the capsule.
	
]]

-- ** DEFAULT SETTINGS ** --

-- Master HotBar enable
Gypsy_DefaultEnableHotBar = 1;

-- ** GENERAL VARIABLES ** --
local oGetNumAvailableQuests = GetNumAvailableQuests;
function GetNumAvailableQuests  ()			
	ShowPetActionBar();
	return oGetNumAvailableQuests();
end 	

local oQuestWatch_Update = QuestWatch_Update;
function QuestWatch_Update ()
	oQuestWatch_Update();
	ShowPetActionBar();
end

local oToggleWorldMap = ToggleWorldMap;
function ToggleWorldMap ()
	oToggleWorldMap();
	ShowPetActionBar();	
end


local oPetActionBar_Update = PetActionBar_Update;
function PetActionBar_Update ()
	oPetActionBar_Update();
	ShowPetActionBar();
end



-- ** HOTBAR FUNCTIONS ** --

-- Event registration
function Gypsy_HotBarOnLoad ()
  this:RegisterEvent("UPDATE_BATTLEFIELD_SCORE");
  this:RegisterEvent("UPDATE_WORLD_STATES");
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE");
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE");
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL");
	this:RegisterEvent("CHAT_MSG_ADDON");
	this:RegisterEvent("VARIABLES_LOADED");
end

-- Configuration registrations
function Gypsy_HotBarOnEvent (event)
	if (event == "VARIABLES_LOADED") then
		-- GypsyMod registrations
		if (GYPSY_SHELL == 1) then
			if (Gypsy_RetrieveSaved("EnableHotBar") == nil) then
				Gypsy_EnableHotBar = Gypsy_DefaultEnableHotBar;
			else
				Gypsy_EnableHotBar = Gypsy_RetrieveSaved("EnableHotBar");
			end
			Gypsy_RegisterOption(100, "category", nil, nil, nil, GYPSY_TEXT_HOTBAR_TABLABEL, GYPSY_TEXT_HOTBAR_TABTOOLTIP);
			Gypsy_RegisterOption(101, "check", Gypsy_EnableHotBar, "EnableHotBar", Gypsy_UpdateHotBar, GYPSY_TEXT_HOTBAR_ENABLELABEL, GYPSY_TEXT_HOTBAR_ENABLETOOLTIP);
		else
			if (Gypsy_EnableHotBar == nil) then
				Gypsy_EnableHotBar = Gypsy_DefaultEnableHotBar;
			end
			--RegisterForSave("Gypsy_EnableHotBar");
			SlashCmdList["GYPSY_ENABLEHOTBAR"] = Gypsy_EnableHotBarSlashHandler;
			SLASH_GYPSY_ENABLEHOTBAR1 = "/hotbarenable";
			SLASH_GYPSY_ENABLEHOTBAR2 = "/hbenable";
			-- Special slash command to list other slash commands for this add-on
			SlashCmdList["GYPSY_HOTBAR"] = Gypsy_HotBarSlashHandler;
			SLASH_GYPSY_HOTBAR1 = "/hotbar";
			SLASH_GYPSY_HOTBAR2 = "/hb";
		end
		ShowPetActionBar()
		return;
	end

	if (event == "UPDATE_BATTLEFIELD_SCORE") then
		ShowPetActionBar();
		return;
	end
	if (event == "CHAT_MSG_BG_SYSTEM_ALLIANCE") then
		ShowPetActionBar();
		return;
	end

	if (event == "CHAT_MSG_BG_SYSTEM_HORDE") then
		ShowPetActionBar();
		return;
	end

	if (event == "CHAT_MSG_BG_SYSTEM_NEUTRAL") then
		ShowPetActionBar();
		return;
	end

	if (event == "UPDATE_WORLD_STATES") then
		ShowPetActionBar();
		return;
	end
	
end

local old_ShapeshiftBar_UpdatePosition = ShapeshiftBar_UpdatePosition;
function ShapeshiftBar_UpdatePosition ()
end

local old_ReputationWatchBar_Update = ReputationWatchBar_Update;
function ReputationWatchBar_Update ()
	old_ReputationWatchBar_Update();
	
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(101) ~= nil) then
			Gypsy_EnableHotBar = Gypsy_RetrieveOption(101)[GYPSY_VALUE];
		end
	end
	
	if (Gypsy_EnableHotBar == 1) then
		ReputationWatchBar:Hide();
		MainMenuBarMaxLevelBar:Hide();
	end
end

local old_ShowPetActionBar = ShowPetActionBar;
function ShowPetActionBar ()
	old_ShowPetActionBar();
	
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(101) ~= nil) then
			Gypsy_EnableHotBar = Gypsy_RetrieveOption(101)[GYPSY_VALUE];
			--Gypsy_ActionButtonGap = Gypsy_RetrieveOption(104)[GYPSY_VALUE];
		end
	end
	
	if (Gypsy_EnableHotBar == 1) then
		local yOffset;

		if (SHOW_MULTI_ACTIONBAR_1 and SHOW_MULTI_ACTIONBAR_2) then
			PETACTIONBAR_YPOS = 130 + 72 + (Gypsy_ActionButtonGap * 3);
		elseif (SHOW_MULTI_ACTIONBAR_1 or SHOW_MULTI_ACTIONBAR_2) then
			PETACTIONBAR_YPOS = 130 + 36 + (Gypsy_ActionButtonGap * 2);
		else
			PETACTIONBAR_YPOS = 130;
		end

		SlidingActionBarTexture0:Hide();
		SlidingActionBarTexture1:Hide();

		PetActionBarFrame:SetPoint("TOPLEFT", "MainMenuBar", "BOTTOMLEFT", PETACTIONBAR_XPOS, PETACTIONBAR_YPOS);
		--PetActionBarFrame.yTarget = yOffset;
	end
end

local old_PetActionBar_UpdatePosition = PetActionBar_UpdatePosition;
function PetActionBar_UpdatePosition ()
	--old_PetActionBar_UpdatePosition();
	
	if (Gypsy_EnableHotBar == 1) then
		local yOffset;

		if (SHOW_MULTI_ACTIONBAR_1 and SHOW_MULTI_ACTIONBAR_2) then
			PETACTIONBAR_YPOS = 130 + 72 + (Gypsy_ActionButtonGap * 3);
		elseif (SHOW_MULTI_ACTIONBAR_1 or SHOW_MULTI_ACTIONBAR_2) then
			PETACTIONBAR_YPOS = 130 + 36 + (Gypsy_ActionButtonGap * 2);
		else
			PETACTIONBAR_YPOS = 130;
		end

		SlidingActionBarTexture0:Hide();
		SlidingActionBarTexture1:Hide();

		PetActionBarFrame:SetPoint("TOPLEFT", "MainMenuBar", "BOTTOMLEFT", PETACTIONBAR_XPOS, PETACTIONBAR_YPOS);
		--PetActionBarFrame.yTarget = yOffset;
	end
end


local old_PetActionBarFrame_OnEvent = PetActionBarFrame:GetScript("OnEvent");

PetActionBarFrame:SetScript("OnEvent", function ()
	old_PetActionBarFrame_OnEvent();

	if (event == "UNIT_PET" and arg1 == "player") then
		if (Gypsy_RetrieveOption ~= nil) then
			if (Gypsy_RetrieveOption(101) ~= nil) then
				Gypsy_EnableHotBar = Gypsy_RetrieveOption(101)[GYPSY_VALUE];
			end
		end
		
		if (Gypsy_EnableHotBar == 1) then
			ShowPetActionBar();
			--PetActionBar_UpdatePosition();
		end
	end
end);

	
function Gypsy_UpdateHotBar ()
	-- Get GypsyMod array value if available
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(101) ~= nil) then
			Gypsy_EnableHotBar = Gypsy_RetrieveOption(101)[GYPSY_VALUE];
		end
	end
	-- Many changes to go between the HotBar and default main menu bar
	if (Gypsy_EnableHotBar == 1) then
		-- Need to get the bonus action bar out of the way
		BonusActionBarFrame:SetWidth(1);
		-- Losing unwanted graphical items, starting with the action bar page up/down buttons
		ActionBarUpButton:Hide();
		ActionBarDownButton:Hide();
		-- Four textures for the main menu bar background and 1 each for the endcaps
		MainMenuBarTexture0:Hide();
		MainMenuBarTexture1:Hide();
		MainMenuBarTexture2:Hide();
		MainMenuBarTexture3:Hide();
		MainMenuBarLeftEndCap:Hide();
		MainMenuBarRightEndCap:Hide();
		-- Not certain what this overlay is, didn't bother checking
		MainMenuBarOverlayFrame:Hide();
		-- Lag meter
		MainMenuBarPerformanceBarFrame:Hide();
		-- The experience status bar resisted hiding, so simply move it off the screen
		MainMenuExpBar:ClearAllPoints();
		MainMenuExpBar:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, -250);
		ReputationWatchBar_Update();
		-- Rested tick
		ExhaustionTick:Hide();
		-- Main menu micro buttons
		Gypsy_UpdateMicroButtons();
		--[[ I don't quite understand it, but the bonus action bar and others use unnamed
			seemingly duplicate textures anchored to the named textures that they're duplicating,
			so... move the named one off the screen since we can't hide the other by name ]]
		BonusActionBarTexture0:ClearAllPoints();
		BonusActionBarTexture0:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, -50);
		-- Shapeshift/Stance/Aura background textures
		ShapeshiftBarLeft:Hide();
		ShapeshiftBarMiddle:Hide();
		ShapeshiftBarRight:Hide();	
		--ShapeshiftBar_UpdatePosition = blankFunction;
		-- Anchor the main menu bar to our capsule for movement
		MainMenuBar:ClearAllPoints();
		MainMenuBar:SetPoint("BOTTOMLEFT", "Gypsy_HotBarCapsule", "BOTTOMLEFT", 1, 6);
		MainMenuBar:SetWidth(1);

		SlidingActionBarTexture0:Hide();
		SlidingActionBarTexture1:Hide();

		-- Set the color of our capsule backdrop and border to black
		Gypsy_HotBarArt:SetBackdropBorderColor(0, 0, 0);
		Gypsy_HotBarArt:SetBackdropColor(0, 0, 0);
		-- Show the action bar and hotbar capsule
		Gypsy_ActionBar:Show();
		Gypsy_HotBarCapsule:Show();
		-- Enable all of our options frame stuff
		if (GYPSY_SHELL == 1) then
			Gypsy_Option102:Enable();
			Gypsy_Option102Text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);	
			Gypsy_Option103:Enable();
			Gypsy_Option103Text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);	
			Gypsy_Option104Thumb:Show();
			Gypsy_Option104Text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);	
			Gypsy_Option104Low:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
			Gypsy_Option104High:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
			Gypsy_Option106:Enable();
			Gypsy_Option106Text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);	
			Gypsy_Option107:Enable();
			Gypsy_Option107Text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);	
			Gypsy_Option108:Enable();
			Gypsy_Option108Text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
			Gypsy_Option120:Enable();
			Gypsy_Option120Text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
			Gypsy_Option109:Enable();
			Gypsy_Option109Text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
			Gypsy_Option110:Enable();
			Gypsy_Option110Text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		end
		-- Update action button display properties
		Gypsy_ActionButtonDisplayUpdate();
		ShowPetActionBar();
		
		KeyRingButton:ClearAllPoints();
		KeyRingButton:SetPoint("LEFT", "MainMenuBarBackpackButton", "RIGHT", 5, 0);
		KeyRingButton:Show();
	else
		-- Restore bonus action bar size
		BonusActionBarFrame:SetWidth(505);
		-- Set the main menu bar to it's default position
		MainMenuBar:SetWidth(1024);
		MainMenuBar:ClearAllPoints();
		MainMenuBar:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, 0);
		-- Show action bar arrows
		ActionBarUpButton:Show();
		ActionBarDownButton:Show();
		-- Show main menu bar textures, and end cap textures
		MainMenuBarTexture0:Show();
		MainMenuBarTexture1:Show();
		MainMenuBarTexture2:Show();
		MainMenuBarTexture3:Show();
		MainMenuBarLeftEndCap:Show();
		MainMenuBarRightEndCap:Show();
		-- Show overlay frame
		MainMenuBarOverlayFrame:Show();
		-- Show default lag meter
		MainMenuBarPerformanceBarFrame:Show();
		-- Move the experience bar to it's default position
		MainMenuExpBar:ClearAllPoints();
		MainMenuExpBar:SetPoint("TOP", "MainMenuBar", "TOP", 0, 0);
		ReputationWatchBar_Update();
		-- Update the exhaustion tick to get it to display correctly
		ExhaustionTick_Update();
		-- Show micro buttons
		Gypsy_UpdateMicroButtons();
		-- Move the bonus action bar texture to it's default positiong
		BonusActionBarTexture0:ClearAllPoints();
		BonusActionBarTexture0:SetPoint("TOPLEFT", "BonusActionBarFrame", "TOPLEFT", 0, 0);
		-- Show special action button art
		ShapeshiftBarLeft:Show();
		ShapeshiftBarMiddle:Show();
		ShapeshiftBarRight:Show();	
		--ShapeshiftBar_UpdatePosition = old_ShapeshiftBar_UpdatePosition;
		ShapeshiftBar_UpdatePosition();
		
		SlidingActionBarTexture0:Show();
		SlidingActionBarTexture1:Show();
		if (PetHasActionBar()) then	
			-- Run the update
			PetActionBar_Update();
			-- Unlock, hide, show, and relock to display changes
			UnlockPetActionBar();
			HidePetActionBar();			
			ShowPetActionBar();
			LockPetActionBar();
		end
		-- Hide the capsule and action bar
		Gypsy_HotBarCapsule:Hide();
		Gypsy_ActionBar:Hide();		
		-- Disable GypsyMod menu items
		if (GYPSY_SHELL == 1) then
			Gypsy_Option102:Disable();
			Gypsy_Option102Text:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);	
			Gypsy_Option103:Disable();
			Gypsy_Option103Text:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);	
			Gypsy_Option104Thumb:Hide();
			Gypsy_Option104Text:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);	
			Gypsy_Option104Low:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
			Gypsy_Option104High:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
			Gypsy_Option106:Disable();
			Gypsy_Option106Text:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);	
			Gypsy_Option107:Disable();
			Gypsy_Option107Text:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);	
			Gypsy_Option108:Disable();
			Gypsy_Option108Text:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);	
			Gypsy_Option120:Disable();
			Gypsy_Option120Text:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);	
			Gypsy_Option109:Disable();
			Gypsy_Option109Text:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
			Gypsy_Option110:Disable();
			Gypsy_Option110Text:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		end
		-- Update our action buttons display
		Gypsy_ActionButtonDisplayUpdate();	
		KeyRingButton:ClearAllPoints();
		KeyRingButton:SetPoint("RIGHT", "CharacterBag3Slot", "LEFT", -5, 0);
		KeyRingButton:Show();
	end
end

local originalMultiActionBar_Update = MultiActionBar_Update;
function MultiActionBar_Update ()
	-- Hooking the default multibar update function so it can run our HotBar update function and keep things tidy
	originalMultiActionBar_Update();
	Gypsy_UpdateHotBar();
end

function Gypsy_ToggleHotBarCapsule ()
	-- If Shell is present, update the local lock setting
	if (GYPSY_SHELL ~= nil) then
		Gypsy_LockActionBar = GYPSY_LOCKALL;
	end	
	-- Then, if the action bar is not locked, go ahead and show/hide or drag the capsule as needed, or if it is locked, hide the capsule so it can't be dragged
	if (Gypsy_LockActionBar == 0) then
		-- Make sure the capsule is showing, it might have been previously hidden
		if (not Gypsy_HotBarCapsule:IsVisible()) then
			Gypsy_HotBarCapsule:Show();
		end
		-- Quick function to check if the mouse is anywhere over our capsule
		if (MouseIsOver(Gypsy_HotBarCapsule) or MouseIsOver(PetActionBarFrame)) then
			Gypsy_HotBarArt:Show();
			Gypsy_ActionButtonDisplayUpdate();
		else
			Gypsy_HotBarArt:Hide();
			Gypsy_ActionButtonDisplayUpdate();
		end
	else
		Gypsy_HotBarCapsule:Hide();
		Gypsy_ActionButtonDisplayUpdate();
	end
end

-- ** SLASH COMMAND HANDLER FUNCTIONS ** --

function Gypsy_EnableHotBarSlashHandler(msg)
	-- Due to the nature of slash commands, 'msg' will never be nil, so we don't require a check
	msg = string.lower(msg);
	if (msg == "enable" or msg == "1" or msg == "true") then
		Gypsy_EnableHotBar = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Enabling HotBar.", 1, 1, 1);
	elseif (msg == "disable" or msg == "0" or msg == "false") then
		Gypsy_EnableHotBar= 0;
		DEFAULT_CHAT_FRAME:AddMessage("Disabling HotBar.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_EnableHotBar = Gypsy_DefaultEnableHotBar;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting hot bar enable option to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarenable /hbenable", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   enable, true, or 1 - Enable HotBar.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   disable, false, or 0 - Disable HotBar, showing the default main bar.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_EnableHotBar == 1) then 
			Gypsy_EnableHotBar = 0; 
			DEFAULT_CHAT_FRAME:AddMessage("Disabling HotBar.", 1, 1, 1);
		else 
			Gypsy_EnableHotBar = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Enabling HotBar.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /hotbarenable /hbenable", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   enable, true, or 1 - Enable HotBar.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   disable, false, or 0 - Disable HotBar, showing the default main bar.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
	Gypsy_UpdateHotBar();
end

function Gypsy_HotBarSlashHandler(msg)
	DEFAULT_CHAT_FRAME:AddMessage("Valid slash commands for the HotBar add-on", 1, 0.89, 0.01);
	DEFAULT_CHAT_FRAME:AddMessage("All commands may begin with either /hotbar or /hb, ex. /hotbarplaceholders", 1, 0.80, 0.01);
	DEFAULT_CHAT_FRAME:AddMessage("Entering help after any command will display a list of valid parameters.", 1, 0.80, 0);
	DEFAULT_CHAT_FRAME:AddMessage("   enable - Enable/Disable GypsyMod HotBar.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   lock - Lock/Unlock HotBar capsule.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   placeholders - Show/Hide unassigned action button placeholders.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   hotkeylabels - Show/Hide hotkey binding labels.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   buttongap - Set gap between action buttons.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   groupactionpages - Group GypsyMod and default action button pages for accurate paging.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   pageturning - Allow action page turning.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   pageonpress - Enable/Disable Turn-Page-On-Press option, requires page turning to be off.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   shortenmodkey - Shorten hot key binding mod key labels.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   stripmodkey - Strip out hot key binding mod key labels.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   showmenubuttons - Show/Hide menu buttons with capsule.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   lockmenubuttons - Lock/Unlock menu button capsule.", 1, 1, 1);
end