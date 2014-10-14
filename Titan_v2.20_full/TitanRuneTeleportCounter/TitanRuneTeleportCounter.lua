-- **************************************************************************
-- * TitanRuneTeleportCounter.lua
-- * by evil.oz
-- *
-- *Credits:
-- *modified by Pieter Walsweer <pieter@2sekunden.net>
-- *Original Author of ShardCounter: Kefka D'Arden
-- *************************************************************************

-- ************************************* Const / defines *************************************
TITAN_RUNETELEPORTCOUNTER_ID = "RuneTeleportCounter";
TITAN_RUNETELEPORTCOUNTER_COUNT_FORMAT = "%d";
TITAN_RUNETELEPORTCOUNTER_TOOLTIP = "RuneTeleportCounter Tooltip";
TITAN_RUNETELEPORTCOUNTER_ICON = "Interface\\Addons\\TitanRuneTeleportCounter\\Artwork\\TitanRuneTeleport";

-- ************************************* Variables *******************************************
numRuneTeleport = 0;
looping=500

-- ************************************* Functions *******************************************
-- *******************************************************************************************
-- Name: TitanPanelRuneTeleportCounterButton_OnLoad
-- Desc: This function registers RuneTeleportCounter Addon.
-- *******************************************************************************************
function TitanPanelRuneTeleportCounterButton_OnLoad()
	this.registry = {
		id = TITAN_RUNETELEPORTCOUNTER_ID,
		menuText = TITAN_RUNETELEPORTCOUNTER_MENU_TEXT,
		category = "Information",
		buttonTextFunction = "TitanPanelRuneTeleportCounterButton_GetButtonText",
		tooltipTitle = TITAN_RUNETELEPORTCOUTER_TOOLTIP,
		tooltipTextFunction = "TitanPanelRuneTeleportCounterButton_GetTooltipText",
		icon = TITAN_RUNETELEPORTCOUNTER_ICON,
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
-- Name: TitanPanelRuneTeleportCounterButton_OnUpdate
-- Desc: Retrieves RuneTeleport count anytime an update occurs with bag/unit/player events and updates
--	 Titan button accordingly.
-- *******************************************************************************************
function TitanPanelRuneTeleportCounterButton_OnUpdate(arg1)
	numRuneTeleport = RuneTeleportCounter_CountRuneTeleport();
	TitanPanelButton_UpdateButton(TITAN_RUNETELEPORTCOUNTER_ID);

	if ((numRuneTeleport<TITAN_RUNETELEPORTCOUNTER_ALERT) and (inCapitalCity()) and looping>800) then
		TitanPanelRuneTeleportCounter_WarningFrame:AddMessage("low: "..TITAN_RUNETELEPORTCOUNTER_ITEMNAME, 1.0, 0, 0, 1.0, 1);		
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
-- Name: TitanPanelRuneTeleportCounterButton_GetButtonText
-- Desc: Gets our button text, the text that appears on the actual bar, all the time.
-- *******************************************************************************************
function TitanPanelRuneTeleportCounterButton_GetButtonText(id)
	-- If id not nil, return corresponding plugin button
	-- Otherwise return this button and derive the real id
	local button, id = TitanUtils_GetButton(id, true);

	-- Business logic goes here
	numRuneTeleport = RuneTeleportCounter_CountRuneTeleport();

	local countText = format(TITAN_RUNETELEPORTCOUNTER_COUNT_FORMAT, numRuneTeleport);
	return TITAN_RUNETELEPORTCOUNTER_BUTTON_LABEL, TitanUtils_GetHighlightText(countText);
end

-- *******************************************************************************************
-- Name: TitanPanelRuneTeleportCounterButton_GetTooltipText
-- Desc: Gets our tool-tip text, what appears when we hover over our item on the Titan bar.
-- *******************************************************************************************
function TitanPanelRuneTeleportCounterButton_GetTooltipText()
	return TITAN_RUNETELEPORTCOUNTER_TOOLTIPTEXT;
end

-- *******************************************************************************************
-- Name: RuneTeleportCounter_CountRuneTeleport
-- Desc: Counts number of Symbol of RuneTeleport currently in player's bag.
-- *******************************************************************************************
function RuneTeleportCounter_CountRuneTeleport()
	local RuneTeleport = 0;
	local bag, slot = 0;
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
		local itemName = GetContainerItemLink(bag, slot);
			if itemName then
				if string.find(itemName, "%["..TITAN_RUNETELEPORTCOUNTER_ITEMNAME.."%]") then
					local texture, count = GetContainerItemInfo(bag, slot);
					RuneTeleport = RuneTeleport + count;
				end
			end
		end
	end
	return RuneTeleport 
end


function TitanPanelRightClickMenu_PrepareRuneTeleportCounterMenu()
	-- Menu title
	TitanPanelRightClickMenu_AddTitle("Rune of Teleport");	
	
	-- TitanPanelRightClickMenu_AddCommand() adds an entry in the menu which triggers a function when clicked
	-- 1st parameter is the menu text
	-- 2st parameter can be retrieved by "this.value" in the triggered function. It's like passing parameters to the function.
	-- 3st parameter is the triggered function name
	-- TitanPanelRightClickMenu_AddCommand("Options", 1, "TitanPanelRuneTeleportCounterConfig");

	-- A blank line in the menu
	TitanPanelRightClickMenu_AddSpacer();	
	
	-- Generic function to toggle label text
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_RUNETELEPORTCOUNTER_ID);

	-- Generic function to hide the plugin
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_RUNETELEPORTCOUNTER_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end



function TitanPanelRuneTeleportCounterConfig()

	PlaySoundFile("Sound\\interface\\mapping.wav")

end