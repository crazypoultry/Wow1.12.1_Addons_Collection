-- **************************************************************************
-- * TitanSacredCandlesCounter.lua
-- **************************************************************************
-- * TitanRunePortalCounter.lua
-- * by evil.oz
-- *
-- *Credits:
-- *modified by Pieter Walsweer <pieter@2sekunden.net>
-- *Original Author of ShardCounter: Kefka D'Arden
-- *************************************************************************

-- ************************************* Const / defines *************************************
TITAN_SACREDCANDLESCOUNTER_ID = "SacredCandlesCounter";
TITAN_SACREDCANDLESCOUNTER_COUNT_FORMAT = "%d";
TITAN_SACREDCANDLESCOUNTER_TOOLTIP = "SacredCandlesCounter Tooltip";
TITAN_SACREDCANDLESCOUNTER_ICON = "Interface\\Addons\\TitanSacredCandlesCounter\\Artwork\\TitanSacredCandles";

-- ************************************* Variables *******************************************
numSacredCandles = 0;
looping=500

-- ************************************* Functions *******************************************
-- *******************************************************************************************
-- Name: TitanPanelSacredCandlesCounterButton_OnLoad
-- Desc: This function registers SacredCandlesCounter Addon.
-- *******************************************************************************************
function TitanPanelSacredCandlesCounterButton_OnLoad()
	this.registry = {
		id = TITAN_SACREDCANDLESCOUNTER_ID,
		menuText = TITAN_SACREDCANDLESCOUNTER_MENU_TEXT,
		buttonTextFunction = "TitanPanelSacredCandlesCounterButton_GetButtonText",
		tooltipTitle = TITAN_SACREDCANDLESCOUTER_TOOLTIP,
		category = "Information",
		tooltipTextFunction = "TitanPanelSacredCandleCounterButton_GetTooltipText",
		icon = TITAN_SACREDCANDLESCOUNTER_ICON,
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
-- Name: TitanPanelSacredCandlesCounterButton_OnUpdate
-- Desc: Retrieves SacredCandles count anytime an update occurs with bag/unit/player events and updates
--	 Titan button accordingly.
-- *******************************************************************************************
function TitanPanelSacredCandlesCounterButton_OnUpdate(arg1)
	numSacredCandles = SacredCandlesCounter_CountSacredCandles();
	TitanPanelButton_UpdateButton(TITAN_SACREDCANDLESCOUNTER_ID);

	if ((numSacredCandles<TITAN_SACREDCANDLESCOUNTER_ALERT) and (inCapitalCity()) and looping>800) then
		TitanPanelSacredCandlesCounter_WarningFrame:AddMessage("low: "..TITAN_SACREDCANDLESCOUNTER_ITEMNAME, 1.0, 0, 0, 1.0, 1);		
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
-- Name: TitanPanelSacredCandlesCounterButton_GetButtonText
-- Desc: Gets our button text, the text that appears on the actual bar, all the time.
-- *******************************************************************************************
function TitanPanelSacredCandlesCounterButton_GetButtonText(id)
	-- If id not nil, return corresponding plugin button
	-- Otherwise return this button and derive the real id
	local button, id = TitanUtils_GetButton(id, true);

	-- Business logic goes here
	numSacredCandles = SacredCandlesCounter_CountSacredCandles();

	local countText = format(TITAN_SACREDCANDLESCOUNTER_COUNT_FORMAT, numSacredCandles);
	return TITAN_SACREDCANDLESCOUNTER_BUTTON_LABEL, TitanUtils_GetHighlightText(countText);
end

-- *******************************************************************************************
-- Name: TitanPanelSacredCandlesCounterButton_GetTooltipText
-- Desc: Gets our tool-tip text, what appears when we hover over our item on the Titan bar.
-- *******************************************************************************************
function TitanPanelSacredCandlesCounterButton_GetTooltipText()
	return TITAN_SACREDCANDLESCOUNTER_TOOLTIPTEXT;
end

-- *******************************************************************************************
-- Name: SacredCandlesCounter_CountSacredCandles
-- Desc: Counts number of Sacred SacredCandles currently in player's bag.
-- *******************************************************************************************
function SacredCandlesCounter_CountSacredCandles()
	local candles = 0;
	local bag, slot = 0;
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
		local itemName = GetContainerItemLink(bag, slot);
			if itemName then
				if string.find(itemName, "%["..TITAN_SACREDCANDLESCOUNTER_ITEMNAME.."%]") then
					local texture, count = GetContainerItemInfo(bag, slot);
					candles = candles + count;
				end
			end
		end
	end
	return candles;
end


function TitanPanelRightClickMenu_PrepareSacredCandlesCounterMenu()
	-- Menu title
	TitanPanelRightClickMenu_AddTitle("Sacred Candles");	
	
	-- TitanPanelRightClickMenu_AddCommand() adds an entry in the menu which triggers a function when clicked
	-- 1st parameter is the menu text
	-- 2st parameter can be retrieved by "this.value" in the triggered function. It's like passing parameters to the function.
	-- 3st parameter is the triggered function name
	-- TitanPanelRightClickMenu_AddCommand("Options", 1, "TitanPanelSacredCandlesCounterConfig");

	-- A blank line in the menu
	TitanPanelRightClickMenu_AddSpacer();	
	
	-- Generic function to toggle label text
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_SACREDCANDLESCOUNTER_ID);

	-- Generic function to hide the plugin
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_SACREDCANDLESCOUNTER_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end



function TitanPanelSacredCandlesCounterConfig()

	PlaySoundFile("Sound\\interface\\mapping.wav")

end