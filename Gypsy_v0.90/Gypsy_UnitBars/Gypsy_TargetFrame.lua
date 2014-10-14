--[[
	Gypsy_TargetFrame.lua
	GypsyVersion++2004.11.15++
	
	Click catching for the taret frame.
]]

-- ** DEFAULT SETTINGS ** --

-- Color target health bar by default
Gypsy_DefaultColorTargetHealthBar = 1;

-- ** GENERAL VARIABLES ** --

-- Save original health bar OnValueChanged function
Gypsy_OriginalHealthBar_OnValueChanged = HealthBar_OnValueChanged;

-- ** TARGET FRAME FUNCTIONS ** --

-- Event Registers
function Gypsy_TargetFrameOnLoad ()
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_HEALTHMAX");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
end

-- Register options and watch health/target changes
function Gypsy_TargetFrameOnEvent (event)
	if (event == "UNIT_HEALTH" or event == "UNIT_HEALTHMAX" or event == "PLAYER_TARGET_CHANGED") then
		-- Run our health update function whenever a health or max health event is sent, worry bout validating within the function
		Gypsy_UpdateTargetHealth();
		return;
	end
	if (event == "VARIABLES_LOADED") then
		if (GYPSY_SHELL == 1) then
			if (Gypsy_RetrieveSaved("ColorTargetHealthBar") == nil) then
				Gypsy_ColorTargetHealthBar = Gypsy_DefaultColorTargetHealthBar;
			else
				Gypsy_ColorTargetHealthBar = Gypsy_RetrieveSaved("ColorTargetHealthBar");
			end
			Gypsy_RegisterOption(230, "header", nil, nil, nil, GYPSY_TEXT_UNITBARS_TARGETHEADERLABEL, GYPSY_TEXT_UNITBARS_TARGETHEADERTOOLTIP);
			Gypsy_RegisterOption(231, "check", Gypsy_ColorTargetHealthBar, "ColorTargetHealthBar", Gypsy_UpdateTargetHealth, GYPSY_TEXT_UNITBARS_COLORTARGETTEXTLABEL, GYPSY_TEXT_UNITBARS_COLORTARGETTEXTTOOLTIP);
		else
			if (Gypsy_ColorTargetHealthBar == nil) then
				Gypsy_ColorTargetHealthBar = Gypsy_DefaultColorTargetHealthBar;
			end
			--RegisterForSave("Gypsy_ColorTargetHealthBar");
			SlashCmdList["GYPSY_COLORTARGETHEALTHBAR"] = Gypsy_ColorTargetHealthBarSlashHandler;
			SLASH_GYPSY_COLORTARGETHEALTHBAR1 = "/unitbarcolortargethealthbar";
			SLASH_GYPSY_COLORTARGETHEALTHBAR2 = "/ubcolortargethealthbar";
		end
		return;
	end
end

-- Main update function for coloring target health bar
function Gypsy_UpdateTargetHealth ()
	-- Only if there is a target
	if (TargetFrame:IsVisible()) then
		if (Gypsy_RetrieveOption ~= nil) then
			if (Gypsy_RetrieveOption(231) ~= nil) then
				Gypsy_ColorTargetHealthBar = Gypsy_RetrieveOption(231)[GYPSY_VALUE];
			end
		end
		if (Gypsy_ColorTargetHealthBar == 1) then
			-- Kill this function which does nothing but set the health bar color
			HealthBar_OnValueChanged = function()
				return;
			end
			local health = UnitHealth("target");
			local healthMax = UnitHealthMax("target");
			local decimal = health / healthMax;
			local percent = decimal * 100;
			if ((percent <= 100) and (percent > 75)) then
				TargetFrameHealthBar:SetStatusBarColor(0, 1, 0);
			elseif ((percent <= 75) and (percent > 50)) then
				TargetFrameHealthBar:SetStatusBarColor(1, 1, 0);
			elseif ((percent <= 50) and (percent > 25)) then
				TargetFrameHealthBar:SetStatusBarColor(1, 0.5, 0);
			else
				TargetFrameHealthBar:SetStatusBarColor(1, 0, 0);
			end
		else
			-- Restore function
			HealthBar_OnValueChanged = Gypsy_OriginalHealthBar_OnValueChanged
			TargetFrameHealthBar:SetStatusBarColor(0, 1, 0);
		end
	end
end
	
-- ** TARGET CLICK CATCH FUNCTIONS ** --

function Gypsy_TargetFrameClickCatchOnLoad ()
	this:RegisterForClicks("LeftButtonUp", "RightButtonUp");
end

-- Duplicate function to the default, allows us to move the unit menus
function Gypsy_TargetFrameClickCatch(button)
	if (TargetFrame:IsVisible()) then
		if ( SpellIsTargeting() and button == "RightButton" ) then
			SpellStopTargeting();
			return;
		end
		if ( button == "LeftButton" ) then
			if ( SpellIsTargeting() ) then
				SpellTargetUnit("target");
			elseif ( CursorHasItem() ) then
				DropItemOnUnit("target");
			end
		else
			local menu = nil;
			if ( UnitIsEnemy("target", "player") ) then
				return;
			end
			if ( UnitIsUnit("target", "player") ) then
				menu = "SELF";
			elseif ( UnitIsUnit("target", "pet") ) then
				if(PetCanBeAbandoned()) then
					if(PetCanBeRenamed()) then
						menu = "PET_RENAME";
					else
						menu = "PET";
					end
				else
					menu = "PET_NOABANDON";
				end
			elseif ( UnitIsPlayer("target") ) then
				if ( UnitInParty("target") ) then
					menu = "PARTY";
				else
					menu = "PLAYER";
				end
			end
			if ( menu ) then
ToggleDropDownMenu(1, nil, TargetFrameDropDown, "TargetFrame", 106, 27);
--				UnitPopup_ShowMenu(this, menu, "target");
--				UnitPopup:ClearAllPoints();
DropDownList1:ClearAllPoints();
				-- Check for inverted status and show the menu where appropriate
				if (Gypsy_RetrieveOption ~= nil) then
					if (Gypsy_RetrieveOption(202) ~= nil) then
						Gypsy_InvertUnitFrames = Gypsy_RetrieveOption(202)[GYPSY_VALUE];
					end
				end
				if (Gypsy_InvertUnitFrames == 1) then
					DropDownList1:SetPoint("BOTTOMLEFT", "TargetFrame", "BOTTOMRIGHT", 0, 0);
				else
					DropDownList1:SetPoint("TOPLEFT", "TargetFrame", "TOPRIGHT", 0, 0);
				end
			end
		end
	end
end

-- ** SLASH HANDLER FUNCTIONS ** --

function Gypsy_ColorTargetHealthBarSlashHandler (msg)
	msg = string.lower(msg);
	if (msg == "yes" or msg == "1" or msg == "true") then
		Gypsy_ColorTargetHealthBar = 1;
		DEFAULT_CHAT_FRAME:AddMessage("Coloring target health bar depending on health percentage.", 1, 1, 1);
	elseif (msg == "no" or msg == "0" or msg == "false") then
		Gypsy_ColorTargetHealthBar = 0;
		DEFAULT_CHAT_FRAME:AddMessage("Coloring target health bar as normal.", 1, 1, 1);
	elseif (msg == "default" or msg == "reset" or msg == "revert") then
		Gypsy_ColorTargetHealthBar = Gypsy_DefaultColorTargetHealthBar;
		DEFAULT_CHAT_FRAME:AddMessage("Reverting target health bar color display option state to default.", 1, 1, 1);
	elseif (msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarcolortargethealthbar /unbcolortargethealthbar", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Color target health bar depending on health percentage.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not color target health bar.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	elseif (msg == "") then
		if (Gypsy_ColorTargetHealthBar == 1) then 
			Gypsy_ColorTargetHealthBar = 0;
			DEFAULT_CHAT_FRAME:AddMessage("Coloring target health bar as normal", 1, 1, 1);
		else 
			Gypsy_ColorTargetHealthBar = 1; 
			DEFAULT_CHAT_FRAME:AddMessage("Coloring target health bar depending on health percentage.", 1, 1, 1);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Valid parameters for: /unitbarcolortargethealthbar /unbcolortargethealthbar", 1, 0.89, 0.01);
		DEFAULT_CHAT_FRAME:AddMessage("   help - This listing.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   yes, true, or 1 - Color target health bar depending on health percentage.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   no, false, or 0 - Do not color target health bar.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   default, reset, or revert - Revert to default state.", 1, 1, 1);
		DEFAULT_CHAT_FRAME:AddMessage("   blank - Toggle based on current state.", 1, 1, 1);
	end
	Gypsy_UpdateTargetHealth();
end