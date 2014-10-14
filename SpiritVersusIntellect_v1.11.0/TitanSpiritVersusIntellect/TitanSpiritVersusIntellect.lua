--[[

	Titan Spirit Versus Intellect (SVI Plugin) v1.11.0

	Displays SVI data on the Titan Bar
	
	By: Ted Vessenes

	Jun 19, 2006

]]--


--------------------------------------------------
--
-- Variable Declarations
--
--------------------------------------------------

-- Mod ID
TSVI_ID = "TitanSpiritVersusIntellect";


--------------------------------------------------
--
-- Output Functions
--
--------------------------------------------------

-- Gets the text that displays on the Titan bar
function TSVI_GetButtonText(id)

	local regen, mpi, mps, _, mpc, _, _ = SVI_GetRegenText();
	return	"", regen,
		SVI_ColorTextInt(SVI_GetOutput("LetterInt")) .. ": ", SVI_ColorTextWhite(mpi),
		SVI_ColorTextSpirit(SVI_GetOutput("LetterSpirit")) .. ": ", SVI_ColorTextWhite(mps),
		SVI_ColorTextMana(SVI_GetOutput("LetterMana")) .. ": ", SVI_ColorTextWhite(mpc);
end

-- Gets the text that displays when mousing over the SVI entry
function TSVI_GetTooltipText()

	-- Look up the mana equivalences for each stat
	local _, mpi, mps, ips, mpc, ipc, spc = SVI_GetRegenText();

	-- Translate the catagory titles
	local text_int = SVI_GetOutput("Int");
	local text_spirit = SVI_GetOutput("Spirit");
	local text_mana = SVI_GetOutput("Mana");

	-- Generate the tooltip
	return	"\n" ..
		SVI_ColorTextInt(text_int) .. ":\n" ..
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

-- Publish an update to the titan bar
function TSVI_PublishUpdate()
	TitanPanelButton_UpdateButton(TSVI_ID);
end


--------------------------------------------------
--
-- Initialization Functions
--
--------------------------------------------------

-- Processed when the game loads
function TSVI_OnLoad()

	-- Get the title description for this titan plugin
	local title = SVI_GetOutput("Title");

	-- Setup the registry for Titan
	this.registry = { 
		id = TSVI_ID,
		menuText = title, 
		buttonTextFunction = "TSVI_GetButtonText",
		tooltipTitle = title, 
		tooltipTextFunction = "TSVI_GetTooltipText",
		icon = "Interface\\Icons\\Spell_Nature_WispHeal",
		iconWidth = 16,
		savedVariables = {
			ShowLabelText = 1,
			ShowIcon = 1,
		},

	};

	-- Register with SVI as a display
	SVI_RegisterDisplay(TSVI_ID, { UpdateHandler = TSVI_PublishUpdate });

end

-- Generates the SVI drop down configuration menu
function TitanPanelRightClickMenu_PrepareTitanSpiritVersusIntellectMenu()

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TSVI_ID].menuText);
	
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
