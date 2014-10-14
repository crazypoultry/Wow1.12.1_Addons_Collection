--[[

	Spirit Versus Intellect UI (SVI Plugin) v1.11.0

	Displays SVI data
	
	By: Wolfram Koska

	Jul 10, 2006

]]--


--------------------------------------------------
--
-- Variable Declarations
--
--------------------------------------------------

-- Mod ID
SVIUI_ID = "SpiritVersusIntellectUI";

SVIUI_UpdateInterval = 1.0;
SVIUI_UpdateTime = 1.0;

SpiritVersusIntellectUI_Settings = {}


--------------------------------------------------
--
-- Output Functions
--
--------------------------------------------------

-- Gets the text that displays on the Titan bar
function SVIUI_GetButtonText()

	local regen, mpi, mps, _, mpc, _, _ = SVI_GetRegenText();
	return	regen .. "\n" ..
		SVI_ColorTextInt(SVI_GetOutput("LetterInt")) .. ": " .. SVI_ColorTextWhite(mpi) .. "\n" ..
		SVI_ColorTextSpirit(SVI_GetOutput("LetterSpirit")) .. ": " .. SVI_ColorTextWhite(mps) .. "\n" ..
		SVI_ColorTextMana(SVI_GetOutput("LetterMana")) .. ": " .. SVI_ColorTextWhite(mpc);
end


-- Gets the text that displays when mousing over the SVI entry
function SVIUI_GetTooltipText()

	-- Look up the mana equivalences for each stat
	local _, mpi, mps, ips, mpc, ipc, spc = SVI_GetRegenText();

	-- Translate the catagory titles
	local text_int = SVI_GetOutput("Int");
	local text_spirit = SVI_GetOutput("Spirit");
	local text_mana = SVI_GetOutput("Mana");

	-- Generate the tooltip
	return	SVI_ColorTextInt(text_int) .. ":\n" ..
		"  " .. SVI_ColorTextWhite(mpi) .. " " .. text_mana .. "\n" ..
		"\n" ..
		SVI_ColorTextSpirit(text_spirit) .. ":\n" ..
		"  " .. SVI_ColorTextWhite(mps) .. " " .. text_mana .. "\n" ..
		"  " .. SVI_ColorTextWhite(ips) .. " " .. text_int .. "\n" ..
		"\n" ..
		SVI_ColorTextMana(text_mana .. "/" .. SVI_GetConcentrationRate()) .. ":\n" ..
		"  " .. SVI_ColorTextWhite(mpc) .. " " .. text_mana .. "\n" ..
		"  " .. SVI_ColorTextWhite(ipc) .. " " .. text_int .. "\n" ..
		"  " .. SVI_ColorTextWhite(spc) .. " " .. text_spirit .. "\n";

end


-- Publish an update
function SVIUI_OnUpdate(elapsed)
	SVIUI_UpdateTime = SVIUI_UpdateTime + elapsed;

	if( SVIUI_UpdateTime > SVIUI_UpdateInterval ) then
		SVIUIText:SetText(SVIUI_GetButtonText());
		SVIUI_TTText:SetText(SVIUI_GetTooltipText());

		SVIUI_UpdateTime = 0;
	end
end


--------------------------------------------------
--
-- Initialization Functions
--
--------------------------------------------------

-- Processed when the game loads
function SVIUI_OnLoad()
	SVIUI:RegisterForDrag("LeftButton");
	SVIUI:SetMovable(1);
	SVIUI:Hide();
	SVIUI:RegisterEvent("ADDON_LOADED");
	-- Register with SVI as a display
	SVI_RegisterDisplay(SVIUI_ID, { UpdateHandler = TSVI_PublishUpdate });
	-- Register slash commands
	SLASH_SVIUI1 = "/sviui"
	SlashCmdList["SVIUI"] = SVIUI_OnSlash;
end


-- Process event
function SVIUI_OnEvent()
	if( (event == "ADDON_LOADED") and (arg1 == "SpiritVersusIntellectUI") ) then
		if( SpiritVersusIntellectUI_Settings.show == nil ) then SpiritVersusIntellectUI_Settings.show = true; end
		if( SpiritVersusIntellectUI_Settings.x == nil ) then SpiritVersusIntellectUI_Settings.x = 200; end
		if( SpiritVersusIntellectUI_Settings.y == nil ) then SpiritVersusIntellectUI_Settings.y = -200; end
		if( SpiritVersusIntellectUI_Settings.alpha == nil ) then SpiritVersusIntellectUI_Settings.alpha = 1.0; end
		if( SpiritVersusIntellectUI_Settings.anchor == nil ) then SpiritVersusIntellectUI_Settings.anchor = "TOPLEFT"; end
		SVIUI:ClearAllPoints();
		SVIUI:SetPoint("TOPLEFT", UIParent, "TOPLEFT", SpiritVersusIntellectUI_Settings.x, SpiritVersusIntellectUI_Settings.y);
		SVIUI_TT:ClearAllPoints();
		SVIUI_TT:SetPoint(SpiritVersusIntellectUI_Settings.anchor, SVIUI, "TOPLEFT", 30, -30);
		if( SpiritVersusIntellectUI_Settings.show == true ) then
			SVIUI:Show();
		end
	end
end


-- Process slash command
function SVIUI_OnSlash(argument)
	local s = {};
	local w;
	local i = 0;
	for w in string.gfind(argument, "[^%s]+") do
		s[i] = w;
		i = i + 1;
	end

	if( s[0] == "show" ) then
		SVIUI:Show();
		SVIUI_UpdateTime = SVIUI_UpdateInterval;
		SpiritVersusIntellectUI_Settings.show = true;
	elseif( s[0] == "hide" ) then
		SVIUI:Hide();
		SpiritVersusIntellectUI_Settings.show = false;
	elseif( s[0] == "alpha" ) then
		local a = tonumber(s[1]);
		DEFAULT_CHAT_FRAME:AddMessage(s[1]);
		if( not (a == nil) and (a >= 0.0) and (a <= 1.0) ) then
			SVIUI:SetAlpha(a);
			SpiritVersusIntellectUI_Settings.alpha = a;
		end
	elseif( s[0] == "anchor" ) then
		s[1] = string.upper(s[1]);
		if( (s[1] == "TOPLEFT") or (s[1] == "TOPRIGHT") or (s[1] == "BOTTOMLEFT") or (s[1] == "BOTTOMRIGHT") ) then
			SpiritVersusIntellectUI_Settings.anchor = s[1];
			SVIUI_TT:ClearAllPoints();
			SVIUI_TT:SetPoint(SpiritVersusIntellectUI_Settings.anchor, SVIUI, "TOPLEFT", 30, -30);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("SVIUI -- Usage");
		DEFAULT_CHAT_FRAME:AddMessage("  /sviui show - Show information window");
		DEFAULT_CHAT_FRAME:AddMessage("  /sviui hide - Hide information window");
		DEFAULT_CHAT_FRAME:AddMessage("  /sviui alpha [0.0 - 1.0] - Set alpha for small window");
		DEFAULT_CHAT_FRAME:AddMessage("  /sviui anchor [topleft | topright | bottomleft | bottomright] - Set anchor point of second window");
	end
end


-- Starting to drag
function SVIUI_OnDragStart()
	SVIUI:StartMoving();
	SVIUI.isMoving = true;
end


-- Starting to drag
function SVIUI_OnDragStop()
	SVIUI:StopMovingOrSizing();
	SVIUI.isMoving = false;
	if( SVIUI:GetNumPoints() > 0 ) then
		local a, b, c;
		a, b, c, SpiritVersusIntellectUI_Settings.x, SpiritVersusIntellectUI_Settings.y = this:GetPoint(0);
	end
end



-- Generates the SVI drop down configuration menu
function XXX__PrepareTitanSpiritVersusIntellectMenu()

	--TitanPanelRightClickMenu_AddTitle(TitanPlugins[TSVI_ID].menuText);
	
	-- Manually start and stop recording
	local record = {
		text = SVI_GetOutput("Recording"),
		func = SVI_ToggleRecording,
		checked = SVI_Stat.recording,
	};
	UIDropDownMenu_AddButton(record);

	-- Toggle sound effects option
	local sound = {
		text = SVI_GetOutput("SoundEffects"),
		func = SVI_ToggleSound,
		checked = SVI_Saved.sound,
	};
	UIDropDownMenu_AddButton(sound);

	-- Add the "hide" option
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TSVI_ID, TITAN_PANEL_MENU_FUNC_HIDE);	

end

