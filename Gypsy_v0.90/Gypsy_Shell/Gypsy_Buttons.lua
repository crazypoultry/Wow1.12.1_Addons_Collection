--[[
	Gypsy_Buttons.lua
	GypsyVersion++2004.11.08++
	
	Options menu and lock all button functions.
]]

-- ** GYPSYMOD BUTTON FUNCTIONS ** --

-- Tooltip display OnEnter
function Gypsy_ButtonOnEnter ()
	-- Set options menu tooltip
	GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	GameTooltip:SetText(GYPSY_TEXT_SHELL_BUTTONTOOLTIP, 1.0, 1.0, 1.0);
	-- Get options menu key binding and append it
	local keyBinding = GetBindingKey("GYPSYOPTIONSMENU");
	if (keyBinding) then
		GameTooltip:AppendText(" "..NORMAL_FONT_COLOR_CODE.."("..keyBinding..")"..FONT_COLOR_CODE_CLOSE);
	end
end

-- Function to hide or show our options frame, simply determine which by it's current state
function Gypsy_OptionsFrameToggle ()
	if (Gypsy_OptionsFrame:IsVisible()) then
		HideUIPanel(Gypsy_OptionsFrame);
		PlaySound("igMainMenuOption");
	else
		ShowUIPanel(Gypsy_OptionsFrame);
		PlaySound("igMainMenuQuit");
	end
end

-- ** LOCK BUTTON FUNCTIONS ** --

-- Setup variable loading for our lock button
function Gypsy_LockButtonOnLoad ()
	this:RegisterEvent("VARIABLES_LOADED");
	MiniMapBattlefieldFrame:ClearAllPoints();
	MiniMapBattlefieldFrame:SetPoint("BOTTOM", "Gypsy_LockButton", "TOP", -32, 7);
end

-- Setup our lock variable and register it for saving
function Gypsy_LockButtonOnEvent (event)
	if (event == "VARIABLES_LOADED") then
		if (GYPSY_LOCKALL == nil) then
			GYPSY_LOCKALL = 0;
		end
		if (GYPSY_LOCKALL == 1) then
			this:SetChecked(1);
		else
			this:SetChecked(0);
		end
		--RegisterForSave("GYPSY_LOCKALL");
		return;
	end
end

-- Change our lock variable depending on the state of the check button
function Gypsy_LockButtonOnClick ()
	if (this:GetChecked()) then
		GYPSY_LOCKALL = 1;
		PlaySound("igMainMenuOption");
		GameTooltip:SetText(GYPSY_TEXT_SHELL_UNLOCKTOOLTIP, 1.0, 1.0, 1.0);
	else
		GYPSY_LOCKALL = 0;
		PlaySound("igMainMenuQuit");
		GameTooltip:SetText(GYPSY_TEXT_SHELL_LOCKTOOLTIP, 1.0, 1.0, 1.0);
	end
	-- Get lock button key binding and append it
	local keyBinding = GetBindingKey("GYPSYLOCKALL");
	if (keyBinding) then
		GameTooltip:AppendText(" "..NORMAL_FONT_COLOR_CODE.."("..keyBinding..")"..FONT_COLOR_CODE_CLOSE);
	end
end

-- Tooltip display OnEnter
function Gypsy_LockButtonOnEnter ()
	-- Set lock button tooltip
	GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	if (this:GetChecked()) then
		GameTooltip:SetText(GYPSY_TEXT_SHELL_UNLOCKTOOLTIP, 1.0, 1.0, 1.0);
	else
		GameTooltip:SetText(GYPSY_TEXT_SHELL_LOCKTOOLTIP, 1.0, 1.0, 1.0);
	end
	-- Get lock button key binding and append it
	local keyBinding = GetBindingKey("GYPSYLOCKALL");
	if (keyBinding) then
		GameTooltip:AppendText(" "..NORMAL_FONT_COLOR_CODE.."("..keyBinding..")"..FONT_COLOR_CODE_CLOSE);
	end
end