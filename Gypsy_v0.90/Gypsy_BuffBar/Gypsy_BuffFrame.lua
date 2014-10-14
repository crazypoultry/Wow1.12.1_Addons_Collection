--[[
	Gypsy_BuffFrame.lua
	GypsyVersion++2004.11.14++

	Replaces the default buff display with
	a vertical display below the minimap.
	Displays the buff icons in a vertical row
	aligned to the bottom left corner
	of the minimap with the buff name and
	duration if applicable displayed to
	the right of the icon.
]]

-- ** DEFAULT SETTINGS ** --

-- Default buff bar lock setting
Gypsy_DefaultLockBuffBar = 0;
-- Buff bar enable default
Gypsy_DefaultShowBuffFrame = 1;
-- Show duration default
Gypsy_DefaultShowDuration = 1;

-- ** GENERAL VARIABLES ** --

-- Base heights for both the capsule and the art frame to show on top of the calculated height
Gypsy_BuffFrameCapsuleArtHeader = 10;
Gypsy_BuffFrameCapsuleHeader = 28;
-- Amount to increment and decrement the height for each buff
Gypsy_BuffFrameCapsuleInterval = 39;
-- Save the original quest timer frame OnHide function
Gypsy_OriginalQuestTimerFrame_OnHide = QuestTimerFrame_OnHide;
-- Initialize array for effect data
Gypsy_Effects = { };

-- ** CAPSULE FUNCTIONS ** --

function Gypsy_BuffFrameCapsuleOnLoad ()
	-- Setup the colors for our capsule
	Gypsy_BuffFrameCapsuleArt:SetBackdropBorderColor(0, 0, 0);
	Gypsy_BuffFrameCapsuleArt:SetBackdropColor(0, 0, 0);
	-- Register for variable loading to run our configuration registrations from
	this:RegisterEvent("VARIABLES_LOADED");
end

function Gypsy_BuffFrameCapsuleOnEvent (event)
	if (event == "VARIABLES_LOADED") then
		-- Register with GypsyMod if the Shell is present, otherwise make stand-alone registrations
		if (GYPSY_SHELL == 1) then
			if (Gypsy_RetrieveSaved("ShowBuffFrame") == nil) then
				Gypsy_ShowBuffFrame = Gypsy_DefaultShowBuffFrame;
			else
				Gypsy_ShowBuffFrame = Gypsy_RetrieveSaved("ShowBuffFrame");
			end
			if (Gypsy_RetrieveSaved("ShowDuration") == nil) then
				Gypsy_ShowDuration = Gypsy_DefaultShowDuration;
			else
				Gypsy_ShowDuration = Gypsy_RetrieveSaved("ShowDuration");
			end
			-- Register with GypsyMod
			Gypsy_RegisterOption(150, "category", nil, nil, nil, "BuffBar", "Settings for the player effects display.");
			Gypsy_RegisterOption(151, "check", Gypsy_ShowBuffFrame, "ShowBuffFrame", Gypsy_BuffFrameUpdateAll, "Enable BuffBar", "Click to toggle between the default\nbuff frame and the GypsyMod frame.");
			Gypsy_RegisterOption(152, "check", Gypsy_ShowDuration, "ShowDuration", Gypsy_BuffFrameUpdateAll, "Show Durations", "Display durations for effects in\ntext below their name.");
			Gypsy_RegisterOption(153, "button", nil, nil, Gypsy_BuffFrameReset, "Reset", "Reset buff frame options and position.");
		else
			-- Get default values if configurations aren't set
			if (Gypsy_ShowBuffFrame == nil) then
				Gypsy_ShowBuffFrame = Gypsy_DefaultShowBuffFrame;
			end
			if (Gypsy_ShowDuration == nil) then
				Gypsy_ShowDuration = Gypsy_DefaultShowDuration;
			end
			-- Special setting for local locking
			if (Gypsy_LockBuffBar == nil) then
				Gypsy_LockBuffBar = Gypsy_DefaultLockBuffBar;
			end
			-- Register configuration values for save
			--RegisterForSave("Gypsy_ShowBuffFrame");
			--RegisterForSave("Gypsy_ShowDuration");
			--RegisterForSave("Gypsy_LockBuffBar");
			-- Register slash commands
			SlashCmdList["GYPSY_SHOWBUFFBAR"] = Gypsy_ShowBuffBarSlashHandler;
			SLASH_GYPSY_SHOWBUFFBAR1 = "/buffbarenable";
			SLASH_GYPSY_SHOWBUFFBAR2 = "/bbenable";
			SlashCmdList["GYPSY_SHOWDURATION"] = Gypsy_ShowDurationSlashHandler;			
			SLASH_GYPSY_SHOWDURATION1 = "/buffbarshowduration";
			SLASH_GYPSY_SHOWDURATION2 = "/bbshowduration";			
			SlashCmdList["GYPSY_RESETBUFFBAR"] = Gypsy_ResetBuffBarSlashHandler;			
			SLASH_GYPSY_RESETBUFFBAR1 = "/buffbarreset";
			SLASH_GYPSY_RESETBUFFBAR2 = "/bbreset";	
			SlashCmdList["GYPSY_LOCKBUFFBAR"] = Gypsy_LockBuffBarSlashHandler;
			SLASH_GYPSY_LOCKBUFFBAR1 = "/buffbarlock";
			SLASH_GYPSY_LOCKBUFFBAR2 = "/bblock";
			-- Special slash command to display listing of all other slash commands
			SlashCmdList["GYPSY_BUFFBAR"] = Gypsy_BuffBarSlashHandler;
			SLASH_GYPSY_BUFFBAR1 = "/buffbar";
			SLASH_GYPSY_BUFFBAR2 = "/bb";
		end
		-- Initial buff frame setting update
		Gypsy_BuffFrameUpdateAll();
		return;
	end
end			

-- Main function to change the buff frame height according to number of effects
function Gypsy_BuffFrameCapsuleOnUpdate ()
	-- Variable to hold number of buffs shown
	local count = 0;
	-- Check each buff button for visibility and add to the count variable if it is
	for i=0, 23 do
		local button = getglobal("Gypsy_BuffButton"..i);
		if (button:IsVisible()) then
			count = count + 1;
		end
	end
	-- Calculate our height adjustment
	local heightAdjustment = Gypsy_BuffFrameCapsuleInterval * count;
	-- Always display one buff's worth of height
	if (heightAdjustment == 0) then
		heightAdjustment = Gypsy_BuffFrameCapsuleInterval;
	end
	-- Calculate the height to make each frame
	local capsuleHeight = Gypsy_BuffFrameCapsuleHeader + heightAdjustment;
	local capsuleArtHeight = Gypsy_BuffFrameCapsuleArtHeader + heightAdjustment;
	-- Set heights
	Gypsy_BuffFrameCapsule:SetHeight(capsuleHeight);
	Gypsy_BuffFrameCapsuleArt:SetHeight(capsuleArtHeight);
end

function Gypsy_ToggleBuffFrameCapsule ()
	-- If the Shell is present, update the local lock setting
	if (GYPSY_SHELL ~= nil) then
		Gypsy_LockBuffBar = GYPSY_LOCKALL;
	end
	-- Then, if the buff bar is not locked, go ahead and show/hide or drag the capsule as needed, or if it is locked, hide the capsule so it can't be dragged
	if (Gypsy_LockBuffBar == 0) then
		-- Make sure the capsule is showing, it might have been previously hidden
		if (not Gypsy_BuffFrameCapsule:IsVisible()) then
			Gypsy_BuffFrameCapsule:Show();
		end
		-- Quick function to check if the mouse is anywhere over our capsule
		if (MouseIsOver(Gypsy_BuffFrameCapsule)) then
			Gypsy_BuffFrameCapsuleArt:Show();
		else
			Gypsy_BuffFrameCapsuleArt:Hide();
		end
	else
		Gypsy_BuffFrameCapsule:Hide();
	end
end

-- ** BUFF FRAME FUNCTIONS ** --

function Gypsy_BuffFrameUpdateAll ()
	-- Get value from the shell table if it's present
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(151) ~= nil) then
			Gypsy_ShowBuffFrame = Gypsy_RetrieveOption(151)[GYPSY_VALUE];
		end
	end
	
	-- Check to see if we're showing our buff frame or the default, and show/hide each as needed, and also move the durability and quest timer frames
	if (Gypsy_ShowBuffFrame == 1) then
		BuffFrame:Hide();
		Gypsy_BuffFrame:Show();
		Gypsy_BuffFrameCapsule:Show();
		-- Place where the default buff frame would be to the right of the minimap
		QuestWatchFrame:ClearAllPoints();
		QuestWatchFrame:SetPoint("TOPRIGHT", "MinimapCluster", "TOPLEFT", 10, -10);
		DurabilityFrame:ClearAllPoints();
		DurabilityFrame:SetPoint("TOPRIGHT", "QuestWatchFrame", "BOTTOMRIGHT", -50, -10);
		QuestTimerFrame:ClearAllPoints();
		QuestTimerFrame:SetPoint("TOPRIGHT", "QuestWatchFrame", "TOPLEFT", 10, 0);
		-- Shorten the warning time for buff flashing if using our frame, it gets annoying if left longer
		BUFF_WARNING_TIME = 21;
		-- Enable child options
		if (GYPSY_SHELL == 1) then
			Gypsy_Option152:Enable();
			Gypsy_Option152Text:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		end
	else
		BuffFrame:Show();
		Gypsy_BuffFrame:Hide();
		Gypsy_BuffFrameCapsule:Hide();
		-- Default spots
		DurabilityFrame:ClearAllPoints();
		DurabilityFrame:SetPoint("TOP", "MinimapCluster", "BOTTOM", 40, 15);
		QuestWatchFrame:ClearAllPoints();
		QuestWatchFrame:SetPoint("TOPRIGHT", "MinimapCluster", "BOTTOMRIGHT", 0, 10);
		QuestTimerFrame:ClearAllPoints();
		QuestTimerFrame:SetPoint("TOP", "MinimapCluster", "BOTTOM", 10, 0);	
		-- Disable child options if shell is present
		if (GYPSY_SHELL == 1) then
			Gypsy_Option152:Disable();
			Gypsy_Option152Text:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
		end
	end
	-- Update each buff frame to account for settings changes
	for i=0, 23 do
		local button = getglobal("Gypsy_BuffButton"..i);
		Gypsy_BuffButtonLoadAny(button);
	end
end

-- Have to hook the right side frame management function, it causes problems
local originalUIParent_ManageRightSideFrames = UIParent_ManageRightSideFrames;
function UIParent_ManageRightSideFrames ()
	originalUIParent_ManageRightSideFrames();
	if (Gypsy_ShowBuffFrame == 1) then
		QuestWatchFrame:ClearAllPoints();
		QuestWatchFrame:SetPoint("TOPRIGHT", "MinimapCluster", "TOPLEFT", 10, -10);
		DurabilityFrame:ClearAllPoints();
		DurabilityFrame:SetPoint("TOPRIGHT", "QuestWatchFrame", "BOTTOMRIGHT", -50, -10);
		QuestTimerFrame:ClearAllPoints();
		QuestTimerFrame:SetPoint("TOPRIGHT", "QuestWatchFrame", "TOPLEFT", 10, 0);
	end
end
	

-- Replacing the original quest timer frame OnHide function, which moves the durability frame
function QuestTimerFrame_OnHide()
	-- Get show buff frame setting
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(151) ~= nil) then
			Gypsy_ShowBuffFrame = Gypsy_RetrieveOption(151)[GYPSY_VALUE];
		end
	end
	DurabilityFrame:ClearAllPoints();
	-- If the buff frame is showing, move the durability frame to our spot, else run the original function to use the default spot
	if (Gypsy_ShowBuffFrame == 1) then		
		DurabilityFrame:SetPoint("TOPRIGHT", "MinimapCluster", "TOPLEFT", -10, -10);
	else
		Gypsy_OriginalQuestTimerFrame_OnHide();
	end
end

function Gypsy_BuffFrameReset ()
	-- Change values for both Shell and stand-alone mode
	if (GYPSY_SHELL == 1) then
		-- Set the GypsyMod values to default
		Gypsy_UpdateValue(151, Gypsy_DefaultShowBuffFrame);
		Gypsy_UpdateValue(152, Gypsy_DefaultShowDuration);
		-- Set the check button(s) to default state
		Gypsy_Option151:SetChecked(Gypsy_DefaultShowBuffFrame);
		Gypsy_Option152:SetChecked(Gypsy_DefaultShowDuration);
	else
		Gypsy_ShowBuffFrame = Gypsy_DefaultShowBuffFrame;
		Gypsy_ShowDuration = Gypsy_DefaultShowDuration;
	end
	-- Move the buff frame to it's default position
	Gypsy_BuffFrameCapsule:ClearAllPoints();
	Gypsy_BuffFrameCapsule:SetPoint("TOPRIGHT", "MinimapCluster", "BOTTOMRIGHT", 0, 0);
	-- Run the update all function to reflect changes
	Gypsy_BuffFrameUpdateAll();
end

function Gypsy_BuffFrameOnUpdate(elapsed)
	if ( BuffFrameUpdateTime > 0 ) then
		BuffFrameUpdateTime = BuffFrameUpdateTime - elapsed;
	else
		BuffFrameUpdateTime = BuffFrameUpdateTime + TOOLTIP_UPDATE_TIME;
	end

	BuffFrameFlashTime = BuffFrameFlashTime - elapsed;

	if ( BuffFrameFlashTime < 0 ) then
		local overtime = -BuffFrameFlashTime;
		if ( BuffFrameFlashState == 1 ) then
			BuffFrameFlashState = 0;
			BuffFrameFlashTime = BUFF_FLASH_TIME_OFF;
		else
			BuffFrameFlashState = 1;
			BuffFrameFlashTime = BUFF_FLASH_TIME_ON;
		end
		if ( overtime < BuffFrameFlashTime ) then
			BuffFrameFlashTime = BuffFrameFlashTime - overtime;
		end
	end
	-- Check whether the mouse is over our capsule to show or hide it	
	Gypsy_ToggleBuffFrameCapsule();	
end

-- ** BUFF BUTTON FUNCTIONS ** --

function Gypsy_BuffButtonUpdate()
	local buffIndex, untilCancelled = GetPlayerBuff(this:GetID(), this.buffFilter);
	this.buffIndex = buffIndex;
	this.untilCancelled = untilCancelled;

	if ( buffIndex < 0 ) then		
		this:Hide();
		return;
	else
		this:SetAlpha(1.0);
		this:Show();
	end

	local icon = getglobal(this:GetName().."Icon");
	icon:SetTexture(GetPlayerBuffTexture(buffIndex, this.buffFilter));

	if (GameTooltip:IsOwned(this)) then
		GameTooltip:SetPlayerBuff(buffIndex, this.buffFilter);
	end
	
	-- Get the buff description and display it
	local buffName = Gypsy_GetBuffName("player", this:GetID(), this.buffFilter);
	if (buffName) then
		getglobal(this:GetName() .. "DescribeText"):SetText(buffName);
	end
	Gypsy_Effects[this:GetID()] = nil;
end

-- Duplicate functionality of the normal button update function, usable with a supplied button reference instead of from the button itself
function Gypsy_BuffButtonUpdateAny(button)
	local buffIndex, untilCancelled = GetPlayerBuff(button:GetID(), button.buffFilter);
	button.buffIndex = buffIndex;
	button.untilCancelled = untilCancelled;

	if ( buffIndex < 0 ) then		
		button:Hide();
		return;
	else
		button:SetAlpha(1.0);
		button:Show();
	end

	local icon = getglobal(button:GetName().."Icon");
	icon:SetTexture(GetPlayerBuffTexture(buffIndex, button.buffFilter));

	if (GameTooltip:IsOwned(button)) then
		GameTooltip:SetPlayerBuff(buffIndex, button.buffFilter);
	end
	
	-- Get the buff description and display it
	local buffName = Gypsy_GetBuffName("player", button:GetID(), button.buffFilter);
	if (buffName) then
		getglobal(button:GetName() .. "DescribeText"):SetText(buffName);
	end
	Gypsy_Effects[button:GetID()] = nil;
end

function Gypsy_BuffButtonOnLoad()
	-- Update the duration show setting
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(152) ~= nil) then
			Gypsy_ShowDuration = Gypsy_RetrieveOption(152)[GYPSY_VALUE];
		end
	end
	
	local buffIndex, untilCancelled = GetPlayerBuff(this:GetID(), this.buffFilter);
	
	if (Gypsy_BuffIsDebuff(temp) == 1) then
		getglobal(this:GetName() .. "Debuff"):Show();
	else
		getglobal(this:GetName() .. "Debuff"):Hide();
	end
	if (untilCancelled == 1 or Gypsy_ShowDuration == 0) then
		getglobal(this:GetName() .. "DurationText"):SetText("");
	end

	Gypsy_BuffButtonUpdate();
	this:RegisterForClicks("RightButtonUp");
	this:RegisterEvent("PLAYER_AURAS_CHANGED");
	
	-- Get the buff description and display it
	local description = getglobal(this:GetName() .. "DescribeText");
	if (description) then 
		description:Show();
	end
end

-- Duplicate functionality of the normal button load function, usable with a supplied button reference instead of from the button itself
function Gypsy_BuffButtonLoadAny(button)
	-- Update the duration show setting
	if (Gypsy_RetrieveOption ~= nil) then
		if (Gypsy_RetrieveOption(152) ~= nil) then
			Gypsy_ShowDuration = Gypsy_RetrieveOption(152)[GYPSY_VALUE];
		end
	end
	
	local buffIndex, untilCancelled = GetPlayerBuff(button:GetID(), button.buffFilter);
	
	if (Gypsy_BuffIsDebuff(temp) == 1) then
		getglobal(button:GetName() .. "Debuff"):Show();
	else
		getglobal(button:GetName() .. "Debuff"):Hide();
	end
	if (untilCancelled == 1 or Gypsy_ShowDuration == 0) then
		getglobal(button:GetName() .. "DurationText"):SetText("");
	end

	Gypsy_BuffButtonUpdateAny(button);

	-- Get the buff description and display it
	local description = getglobal(button:GetName() .. "DescribeText");
	if (description) then 
		description:Show(); 
	end
end

function Gypsy_BuffButtonOnEvent(event)
	Gypsy_BuffButtonUpdate();
end

function Gypsy_BuffButtonOnUpdate()
	local buffName;
	local buffIndex, untilCancelled = GetPlayerBuff(this:GetID(), this.buffFilter);
	-- Get border and background textures
	local buffBorder = getglobal(this:GetName().."Buff");
	local debuffBorder = getglobal(this:GetName().."Debuff");
	-- Set the correct borders/backgrounds depending on if this is a buff or debuff
	if (Gypsy_BuffIsDebuff(buffIndex) == 1) then
		debuffBorder:Show();
		buffBorder:Hide();
		this:SetBackdropBorderColor(1, 0, 0);
		this:SetBackdropColor(1, 0, 0, 0.5);
	else
		debuffBorder:Hide();
		buffBorder:Show();
		this:SetBackdropBorderColor(0, 0.75, 1);
		this:SetBackdropColor(0, 0.5, 1, 0.5);
	end
	-- Set duration text if applicable
	if (untilCancelled == 1) then
		getglobal(this:GetName().."DurationText"):SetText("");
		return;
	end
	if (not Gypsy_Effects[this:GetID()]) then
		buffName = Gypsy_GetBuffName("player", this:GetID());
		Gypsy_Effects[this:GetID()] = buffName;
	else
		buffName = Gypsy_Effects[this:GetID()];
	end

	local timeLeft = GetPlayerBuffTimeLeft(buffIndex);
	local buffAlphaValue;
	-- Set duration text
	if (timeLeft >= 1 and Gypsy_ShowDuration == 1) then
		getglobal(this:GetName().."DurationText"):SetText(Gypsy_GetStringTime(timeLeft));
	else
		getglobal(this:GetName().."DurationText"):SetText("");
	end

	if (timeLeft < BUFF_WARNING_TIME) then
		if (BuffFrameFlashState == 1) then
			buffAlphaValue = (BUFF_FLASH_TIME_ON - BuffFrameFlashTime) / BUFF_FLASH_TIME_ON;
			buffAlphaValue = buffAlphaValue * (1 - BUFF_MIN_ALPHA) + BUFF_MIN_ALPHA;
		else
			buffAlphaValue = BuffFrameFlashTime / BUFF_FLASH_TIME_ON;
			buffAlphaValue = (buffAlphaValue * (1 - BUFF_MIN_ALPHA)) + BUFF_MIN_ALPHA;
			this:SetAlpha(BuffFrameFlashTime / BUFF_FLASH_TIME_ON);
		end
		this:SetAlpha(buffAlphaValue);
	end

	if (BuffFrameUpdateTime > 0) then
		return;
	end
	if (GameTooltip:IsOwned(this)) then
		GameTooltip:SetPlayerBuff(buffIndex);
	end
end

function Gypsy_BuffButtonOnClick()
	CancelPlayerBuff(this.buffIndex);
end

function Gypsy_BuffIsDebuff(id)
	for z=0, 23, 1 do
		local debuffIndex, debuffTemp = GetPlayerBuff(z, "HARMFUL");
		if (debuffIndex == -1) then 
			return 0; 
		end
		if (debuffIndex == id) then
			return 1;
		end
	end
	return 0;
end

function Gypsy_GetBuffName(unit, i, filter)
	if (filter == nil) then
		filter = "HELPFUL|HARMFUL";
	end
	local buffIndex, untilCancelled = GetPlayerBuff(i, filter);
	local buff;

	if (buffIndex < 24) then
		buff = buffIndex;
		if (buff == -1) then
			buff = nil;
		end
	end

	if (buff and Gypsy_BuffTooltip) then
		Gypsy_BuffTooltip:SetOwner(Gypsy_BuffFrame);
		if (unit == "player") then
			Gypsy_BuffTooltip:SetPlayerBuff(buffIndex);
		end
		local toolTipText = getglobal("Gypsy_BuffTooltipTextLeft1");
		if (toolTipText) then
			local name = toolTipText:GetText();
			Gypsy_BuffTooltip:Hide();
			if ( name ~= nil ) then
				return name;
			end
		end
	end
	return nil;
end

function Gypsy_GetStringTime(seconds)
	local string = "";
	if (seconds >= 60) then
		local minutes = ceil(seconds / 60);
		string = minutes.." minute";
		if ( minutes > 1 ) then
			string = string.."s";
		end
	else
		string = floor(seconds).." second";
		if(seconds >= 2) then
			string = string.."s";
		end
	end
	return string;
end

-- ** SLASH HANDLER FUNCTIONS ** --

function Gypsy_ShowBuffBarSlashHandler(msg)
	-- Due to the nature of slash commands, 'msg' will never be nil, so we don't require a check
	msg = string.lower(msg);
	if (msg == "show" or msg == "1" or msg == "true") then
		Gypsy_ShowBuffFrame = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Showing GypsyMod buff frame.", 1, 1, 1);
	elseif (msg == "hide" or msg == "0" or msg == "false") then
		Gypsy_ShowBuffFrame = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Showing default buff frame.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_ShowBuffFrame = Gypsy_DefaultShowBuffFrame;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting buff frame state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /buffbarenable /bbenable", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   show, true, or 1 - Enable the GypsyMod BuffBar.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   hide, false, or 0 - Enable the default buff display.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default option state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_ShowBuffFrame == 1) then
			Gypsy_ShowBuffFrame = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Showing default buff frame.", 1, 1, 1);
		else
			Gypsy_ShowBuffFrame = 1;
			DEFAULT_CHAT_FRAME:AddMessage("Showing GypsyMod buff frame.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /buffbarenable /bbenable", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   show, true, or 1 - Enable the GypsyMod BuffBar.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   hide, false, or 0 - Enable the default buff display.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default option state.", 1, 1, 1);
	end
	Gypsy_BuffFrameUpdateAll();
end

function Gypsy_LockBuffBarSlashHandler(msg)
	-- Due to the nature of slash commands, 'msg' will never be nil, so we don't require a check
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_LockBuffBar = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Locking buff frame.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_LockBuffBar = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Unlocking buff frame.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_LockBuffBar = Gypsy_DefaultLockBuffBar;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting buff frame lock state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /buffbarlock /bblock", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   show, true, or 1 - Lock the GypsyMod BuffBar.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   hide, false, or 0 - Unlock the GypsyMod BuffBar.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default option state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_LockBuffBar == 1) then
			Gypsy_LockBuffBar = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Unlocking buff frame.", 1, 1, 1);
		else
			Gypsy_LockBuffBar = 1;
			DEFAULT_CHAT_FRAME:AddMessage("Locking buff frame.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /buffbarlock /bblock", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   show, true, or 1 - Lock the GypsyMod BuffBar.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   hide, false, or 0 - Unlock the GypsyMod BuffBar.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default option state.", 1, 1, 1);
	end
end

function Gypsy_ShowDurationSlashHandler(msg)
	-- Due to the nature of slash commands, 'msg' will never be nil, so we don't require a check
	msg = string.lower(msg);
	if (msg == "show" or msg == "1" or msg == "true") then
		Gypsy_ShowDuration = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Showing effect duration text.", 1, 1, 1);
	elseif (msg == "hide" or msg == "0" or msg == "false") then
		Gypsy_ShowDuration = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Hiding effect duration text.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_ShowDuration = Gypsy_DefaultShowDuration;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting effect duration text state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /buffbarshowduration /bbshowduration", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   show, true, or 1 - Show duration text labels on the BuffBar.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   hide, false, or 0 - Hide duration text.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default option state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_ShowDuration == 1) then 
			Gypsy_ShowDuration = 0; 
			DEFAULT_CHAT_FRAME:AddMessage("Hiding effect duration text.", 1, 1, 1);
		else 
			Gypsy_ShowDuration = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Showing effect duration text.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /buffbarshowduration /bbshowduration", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   show, true, or 1 - Show duration text labels on the BuffBar.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   hide, false, or 0 - Hide duration text.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default option state.", 1, 1, 1);
	end
	Gypsy_BuffFrameUpdateAll();
end

function Gypsy_ResetBuffBarSlashHandler(msg)
	Gypsy_BuffFrameReset();
	DEFAULT_CHAT_FRAME:AddMessage("Resetting all BuffBar parameters to default.", 1, 1, 1);
end

function Gypsy_BuffBarSlashHandler(msg)
	DEFAULT_CHAT_FRAME:AddMessage("Valid slash commands for the BuffBar add-on", 1, 0.89, 0.01);
	DEFAULT_CHAT_FRAME:AddMessage("All commands may begin with either /buffbar or /bb, ex. /buffbarenable", 1, 0.80, 0.01);
	DEFAULT_CHAT_FRAME:AddMessage("Entering help after any command will display a list of valid parameters.", 1, 0.80, 0);
	DEFAULT_CHAT_FRAME:AddMessage("   enable - Enable/Disable the BuffBar.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   lock - Lock/Unlock the BuffBar.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   showduration - Show/Hide effect duration text.", 1, 1, 1);
	DEFAULT_CHAT_FRAME:AddMessage("   reset - Reset buff frame state.", 1, 1, 1);
end