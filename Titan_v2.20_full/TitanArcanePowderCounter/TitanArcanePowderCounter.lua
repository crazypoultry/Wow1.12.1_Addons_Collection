-- **************************************************************************
-- * TitanArcanePowderCounter.lua
-- * by evil.oz
-- *
-- *Credits:
-- *modified by Pieter Walsweer <pieter@2sekunden.net>
-- *Original Author of ShardCounter: Kefka D'Arden
-- *************************************************************************

-- ************************************* Const / defines *************************************
TITAN_ARCANEPOWDERCOUNTER_ID = "ArcanePowderCounter";
TITAN_ARCANEPOWDERCOUNTER_COUNT_FORMAT = "%d";
TITAN_ARCANEPOWDERCOUNTER_TOOLTIP = "ArcanePowderCounter Tooltip";
TITAN_ARCANEPOWDERCOUNTER_ICON = "Interface\\Addons\\TitanArcanePowderCounter\\Artwork\\TitanArcanePowder";

-- ************************************* Variables *******************************************
numArcanePowder = 0;
looping=500

-- ************************************* Functions *******************************************
-- *******************************************************************************************
-- Name: TitanPanelArcanePowderCounterButton_OnLoad
-- Desc: This function registers ArcanePowderCounter Addon.
-- *******************************************************************************************
function TitanPanelArcanePowderCounterButton_OnLoad()
	this.registry = {
		id = TITAN_ARCANEPOWDERCOUNTER_ID,
		menuText = TITAN_ARCANEPOWDERCOUNTER_MENU_TEXT,
		category = "Information",
		buttonTextFunction = "TitanPanelArcanePowderCounterButton_GetButtonText",
		tooltipTitle = TITAN_ARCANEPOWDERCOUTER_TOOLTIP,
		tooltipTextFunction = "TitanPanelArcanePowderCounterButton_GetTooltipText",
		icon = TITAN_ARCANEPOWDERCOUNTER_ICON,
		iconWidth = 16,
		savedVariables = {
			ShowLabelText = 1,  -- Default to 1
			ShowIcon = 1
		}
	};
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");
end


-- *******************************************************************************************
-- Name: TitanPanelArcanePowderCounterButton_OnUpdate
-- Desc: Retrieves ArcanePowder count anytime an update occurs with bag/unit/player events and updates
--	 Titan button accordingly.
-- *******************************************************************************************
function TitanPanelArcanePowderCounterButton_OnUpdate(arg1)
	numArcanePowder = ArcanePowderCounter_CountArcanePowder();
	TitanPanelButton_UpdateButton(TITAN_ARCANEPOWDERCOUNTER_ID);

	if ((numArcanePowder<TITAN_ARCANEPOWDERCOUNTER_ALERT) and (inCapitalCity()) and looping>800) then
		TitanPanelArcanePowderCounter_WarningFrame:AddMessage("low: "..TITAN_ARCANEPOWDERCOUNTER_ITEMNAME, 1.0, 0, 0, 1.0, 1);		
		PlaySoundFile("Sound\\interface\\mapping.wav")
		looping=0
	end
	looping=looping+1

end


function inCapitalCity()
	
		a=false

		if (GetZoneText()=="City of Ironforge") then a=true end
		if (GetZoneText()=="Stormwind City") then a=true end
		if (GetZoneText()=="Darnassus") then a=true end
		if (GetZoneText()=="Orgrimmar") then a=true end
		if (GetZoneText()=="Thunder Bluff") then a=true end
		if (GetZoneText()=="The Undercity") then a=true end

		return a;

end

-- *******************************************************************************************
-- Name: TitanPanelArcanePowderCounterButton_GetButtonText
-- Desc: Gets our button text, the text that appears on the actual bar, all the time.
-- *******************************************************************************************
function TitanPanelArcanePowderCounterButton_GetButtonText(id)
	-- If id not nil, return corresponding plugin button
	-- Otherwise return this button and derive the real id
	local button, id = TitanUtils_GetButton(id, true);

	-- Business logic goes here
	numArcanePowder = ArcanePowderCounter_CountArcanePowder();

	local countText = format(TITAN_ARCANEPOWDERCOUNTER_COUNT_FORMAT, numArcanePowder);
	return TITAN_ARCANEPOWDERCOUNTER_BUTTON_LABEL, TitanUtils_GetHighlightText(countText);
end

-- *******************************************************************************************
-- Name: TitanPanelArcanePowderCounterButton_GetTooltipText
-- Desc: Gets our tool-tip text, what appears when we hover over our item on the Titan bar.
-- *******************************************************************************************
function TitanPanelArcanePowderCounterButton_GetTooltipText()
	return TITAN_ARCANEPOWDERCOUNTER_TOOLTIPTEXT;
end

-- *******************************************************************************************
-- Name: ArcanePowderCounter_CountArcanePowder
-- Desc: Counts number of ArcanePowder currently in player's bag.
-- *******************************************************************************************
function ArcanePowderCounter_CountArcanePowder()
	local ArcanePowder = 0;
	local bag, slot = 0;
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
		local itemName = GetContainerItemLink(bag, slot);
			if itemName then
				if string.find(itemName, "%["..TITAN_ARCANEPOWDERCOUNTER_ITEMNAME.."%]") then
					local texture, count = GetContainerItemInfo(bag, slot);
					ArcanePowder = ArcanePowder + count;
				end
			end
		end
	end
	return ArcanePowder;
end


function TitanPanelRightClickMenu_PrepareArcanePowderCounterMenu()
	-- Menu title
	TitanPanelRightClickMenu_AddTitle("Arcane Powder");	
	
	-- TitanPanelRightClickMenu_AddCommand() adds an entry in the menu which triggers a function when clicked
	-- 1st parameter is the menu text
	-- 2st parameter can be retrieved by "this.value" in the triggered function. It's like passing parameters to the function.
	-- 3st parameter is the triggered function name
	-- TitanPanelRightClickMenu_AddCommand("Options", 1, "TitanPanelArcanePowderCounterConfig");

	-- A blank line in the menu
	TitanPanelRightClickMenu_AddSpacer();	
	
	-- Generic function to toggle label text
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_ARCANEPOWDERCOUNTER_ID);

	-- Generic function to hide the plugin
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_ARCANEPOWDERCOUNTER_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end



function TitanPanelArcanePowderCounterConfig()

	PlaySoundFile("Sound\\interface\\mapping.wav")

end