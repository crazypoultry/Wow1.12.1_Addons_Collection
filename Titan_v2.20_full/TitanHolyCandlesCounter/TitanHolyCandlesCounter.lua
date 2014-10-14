-- **************************************************************************
-- * TitanHolyCandlesCounter.lua
-- * by evil.oz
-- *
-- *Credits:
-- *modified by Pieter Walsweer <pieter@2sekunden.net>
-- *Original Author of ShardCounter: Kefka D'Arden
-- *************************************************************************


-- ************************************* Const / defines *************************************
TITAN_HOLYCANDLESCOUNTER_ID = "HolyCandlesCounter";
TITAN_HOLYCANDLESCOUNTER_COUNT_FORMAT = "%d";
TITAN_HOLYCANDLESCOUNTER_TOOLTIP = "HolyCandlesCounter Tooltip";
TITAN_HOLYCANDLESCOUNTER_ICON = "Interface\\Addons\\TitanHolyCandlesCounter\\Artwork\\TitanHolyCandles";

-- ************************************* Variables *******************************************
numHolyCandles = 0;
looping=500

-- ************************************* Functions *******************************************
-- *******************************************************************************************
-- Name: TitanPanelHolyCandlesCounterButton_OnLoad
-- Desc: This function registers HolyCandlesCounter Addon.
-- *******************************************************************************************
function TitanPanelHolyCandlesCounterButton_OnLoad()
	this.registry = {
		id = TITAN_HOLYCANDLESCOUNTER_ID,
		menuText = TITAN_HOLYCANDLESCOUNTER_MENU_TEXT,
		category = "Information",
		buttonTextFunction = "TitanPanelHolyCandlesCounterButton_GetButtonText",
		tooltipTitle = TITAN_HOLYCANDLESCOUTER_TOOLTIP,
		tooltipTextFunction = "TitanPanelHolyCandleCounterButton_GetTooltipText",
		icon = TITAN_HOLYCANDLESCOUNTER_ICON,
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
-- Name: TitanPanelHolyCandlesCounterButton_OnUpdate
-- Desc: Retrieves HolyCandles count anytime an update occurs with bag/unit/player events and updates
--	 Titan button accordingly.
-- *******************************************************************************************
function TitanPanelHolyCandlesCounterButton_OnUpdate(arg1)
	numHolyCandles = HolyCandlesCounter_CountHolyCandles();
	TitanPanelButton_UpdateButton(TITAN_HOLYCANDLESCOUNTER_ID);


	if ((numHolyCandles<TITAN_HOLYCANDLESCOUNTER_ALERT) and (inCapitalCity()) and looping>800) then
		TitanPanelHolyCandlesCounter_WarningFrame:AddMessage("low: "..TITAN_HOLYCANDLESCOUNTER_ITEMNAME, 1.0, 0, 0, 1.0, 1);		
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
-- Name: TitanPanelHolyCandlesCounterButton_GetButtonText
-- Desc: Gets our button text, the text that appears on the actual bar, all the time.
-- *******************************************************************************************
function TitanPanelHolyCandlesCounterButton_GetButtonText(id)
	-- If id not nil, return corresponding plugin button
	-- Otherwise return this button and derive the real id
	local button, id = TitanUtils_GetButton(id, true);

	-- Business logic goes here
	numHolyCandles = HolyCandlesCounter_CountHolyCandles();

	local countText = format(TITAN_HOLYCANDLESCOUNTER_COUNT_FORMAT, numHolyCandles);
	return TITAN_HOLYCANDLESCOUNTER_BUTTON_LABEL, TitanUtils_GetHighlightText(countText);
end

-- *******************************************************************************************
-- Name: TitanPanelHolyCandlesCounterButton_GetTooltipText
-- Desc: Gets our tool-tip text, what appears when we hover over our item on the Titan bar.
-- *******************************************************************************************
function TitanPanelHolyCandlesCounterButton_GetTooltipText()
	return TITAN_HOLYCANDLESCOUNTER_TOOLTIPTEXT;
end

-- *******************************************************************************************
-- Name: HolyCandlesCounter_CountHolyCandles
-- Desc: Counts number of Holy HolyCandles currently in player's bag.
-- *******************************************************************************************
function HolyCandlesCounter_CountHolyCandles()
	local candles = 0;
	local bag, slot = 0;
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
		local itemName = GetContainerItemLink(bag, slot);
			if itemName then
				if string.find(itemName, "%["..TITAN_HOLYCANDLESCOUNTER_ITEMNAME.."%]") then
					local texture, count = GetContainerItemInfo(bag, slot);
					candles = candles + count;
				end
			end
		end
	end
	return candles;
end


function TitanPanelRightClickMenu_PrepareHolyCandlesCounterMenu()
	-- Menu title
	TitanPanelRightClickMenu_AddTitle("Holy Candles");	
	
	-- TitanPanelRightClickMenu_AddCommand() adds an entry in the menu which triggers a function when clicked
	-- 1st parameter is the menu text
	-- 2st parameter can be retrieved by "this.value" in the triggered function. It's like passing parameters to the function.
	-- 3st parameter is the triggered function name
	-- TitanPanelRightClickMenu_AddCommand("Options", 1, "TitanPanelHolyCandlesCounterConfig");

	-- A blank line in the menu
	TitanPanelRightClickMenu_AddSpacer();	
	
	-- Generic function to toggle label text
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_HOLYCANDLESCOUNTER_ID);

	-- Generic function to hide the plugin
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_HOLYCANDLESCOUNTER_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end



function TitanPanelHolyCandlesCounterConfig()

	PlaySoundFile("Sound\\interface\\mapping.wav")

end