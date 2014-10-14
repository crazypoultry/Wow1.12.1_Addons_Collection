-- **************************************************************************
-- * TitanRunePortalCounter.lua
-- * by evil.oz
-- *
-- *Credits:
-- *modified by Pieter Walsweer <pieter@2sekunden.net>
-- *Original Author of ShardCounter: Kefka D'Arden
-- *************************************************************************


-- ************************************* Const / defines *************************************
TITAN_RUNEPORTALCOUNTER_ID = "RunePortalCounter";
TITAN_RUNEPORTALCOUNTER_COUNT_FORMAT = "%d";
TITAN_RUNEPORTALCOUNTER_TOOLTIP = "RunePortalCounter Tooltip";
TITAN_RUNEPORTALCOUNTER_ICON = "Interface\\Addons\\TitanRunePortalCounter\\Artwork\\TitanRunePortal";

-- ************************************* Variables *******************************************
numRunePortal = 0;
looping=500

-- ************************************* Functions *******************************************
-- *******************************************************************************************
-- Name: TitanPanelRunePortalCounterButton_OnLoad
-- Desc: This function registers RunePortalCounter Addon.
-- *******************************************************************************************
function TitanPanelRunePortalCounterButton_OnLoad()
	this.registry = {
		id = TITAN_RUNEPORTALCOUNTER_ID,
		menuText = TITAN_RUNEPORTALCOUNTER_MENU_TEXT,
		category = "Information",
		buttonTextFunction = "TitanPanelRunePortalCounterButton_GetButtonText",
		tooltipTitle = TITAN_RUNEPORTALCOUTER_TOOLTIP,
		tooltipTextFunction = "TitanPanelRunePortalCounterButton_GetTooltipText",
		icon = TITAN_RUNEPORTALCOUNTER_ICON,
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
-- Name: TitanPanelRunePortalCounterButton_OnUpdate
-- Desc: Retrieves RunePortal count anytime an update occurs with bag/unit/player events and updates
--	 Titan button accordingly.
-- *******************************************************************************************
function TitanPanelRunePortalCounterButton_OnUpdate(arg1)
	numRunePortal = RunePortalCounter_CountRunePortal();
	TitanPanelButton_UpdateButton(TITAN_RUNEPORTALCOUNTER_ID);

	if ((numRunePortal<TITAN_RUNEPORTALCOUNTER_ALERT) and (inCapitalCity()) and looping>800) then
		TitanPanelRunePortalCounter_WarningFrame:AddMessage("low: "..TITAN_RUNEPORTALCOUNTER_ITEMNAME, 1.0, 0, 0, 1.0, 1);		
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
-- Name: TitanPanelRunePortalCounterButton_GetButtonText
-- Desc: Gets our button text, the text that appears on the actual bar, all the time.
-- *******************************************************************************************
function TitanPanelRunePortalCounterButton_GetButtonText(id)
	-- If id not nil, return corresponding plugin button
	-- Otherwise return this button and derive the real id
	local button, id = TitanUtils_GetButton(id, true);

	-- Business logic goes here
	numRunePortal = RunePortalCounter_CountRunePortal();

	local countText = format(TITAN_RUNEPORTALCOUNTER_COUNT_FORMAT, numRunePortal);
	return TITAN_RUNEPORTALCOUNTER_BUTTON_LABEL, TitanUtils_GetHighlightText(countText);
end

-- *******************************************************************************************
-- Name: TitanPanelRunePortalCounterButton_GetTooltipText
-- Desc: Gets our tool-tip text, what appears when we hover over our item on the Titan bar.
-- *******************************************************************************************
function TitanPanelRunePortalCounterButton_GetTooltipText()
	return TITAN_RUNEPORTALCOUNTER_TOOLTIPTEXT;
end

-- *******************************************************************************************
-- Name: RunePortalCounter_CountRunePortal
-- Desc: Counts number of Symbol of RunePortal currently in player's bag.
-- *******************************************************************************************
function RunePortalCounter_CountRunePortal()
	local RunePortal = 0;
	local bag, slot = 0;
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
		local itemName = GetContainerItemLink(bag, slot);
			if itemName then
				if string.find(itemName, "%["..TITAN_RUNEPORTALCOUNTER_ITEMNAME.."%]") then
					local texture, count = GetContainerItemInfo(bag, slot);
					RunePortal = RunePortal + count;
				end
			end
		end
	end
	return RunePortal;
end


function TitanPanelRightClickMenu_PrepareRunePortalCounterMenu()
	-- Menu title
	TitanPanelRightClickMenu_AddTitle("Rune of Portals");	
	
	-- TitanPanelRightClickMenu_AddCommand() adds an entry in the menu which triggers a function when clicked
	-- 1st parameter is the menu text
	-- 2st parameter can be retrieved by "this.value" in the triggered function. It's like passing parameters to the function.
	-- 3st parameter is the triggered function name
	-- TitanPanelRightClickMenu_AddCommand("Options", 1, "TitanPanelRunePortalCounterConfig");

	-- A blank line in the menu
	TitanPanelRightClickMenu_AddSpacer();	
	
	-- Generic function to toggle label text
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_RUNEPORTALCOUNTER_ID);

	-- Generic function to hide the plugin
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_RUNEPORTALCOUNTER_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end



function TitanPanelRunePortalCounterConfig()

	PlaySoundFile("Sound\\interface\\mapping.wav")

end