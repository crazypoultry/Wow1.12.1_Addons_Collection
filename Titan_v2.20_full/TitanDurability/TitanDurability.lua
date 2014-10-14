-------------------------------------------------------------------------------
-- Titan Panel [Durability] continued - 1.07a
--
-- Original code from Titan Durability by tekkub: http://www.curse-gaming.com/mod.php?addid=1300
-- and Titan by TitanMod / Adsertor: http://www.curse-gaming.com/mod.php?addid=860
-- Gold formatting code, shamelessly "borrowed" from Auctioneer: http://www.curse-gaming.com/mod.php?addid=146
-- modified by jth: http://www.curse-gaming.com/mod.php?addid=2473
--
-- Additional to the built-in Durability-Addon coming with Titan-Panel (Titan Repair), this addon can also display the 10%/20% discount on honored or/and PvP Rank 3.
--
-- Features:
-- - display repair cost on equipped and inventory
-- - display detailed durability status for equiped items on Titan Panel tooltip
-- - all durability informations can be displayed on Titan Panel
-- - total repair cost (equipped + inventory)
-- - can display the most damaged item on titan panel
-- - all repair costs are with selected discount (normal, 10% or 20%)
-- - durability and repair cost is only calculated if player is out of combat
-- - currently works with english, german and french client
--
-- This is a continued version of Tekkub's Titan Panel [Durability] http://www.curse-gaming.com/mod.php?addid=1300
--
-- Changelog:
--
-- v1.07a
-- - reworked menu
-- - option to show total durability on Titan Panel
-- - option to show all discounts (normal, 10% and 20%) on tooltip like Titan Panel [Durability] 1.06
--
-- v1.07
-- - changed TOC to 11100 for patch 1.11.x
-- - you can now turn on/off repair cost / honored / honored + sergeant discount
-- - durability is now only calculated if player is out of combat to prevent some lag issues during durability loss in fight
-- - changed display of detailed repair costs
-- - add option to show repair cost on Titan Panel (with selected discount)
-- - several code optimization
-- - updated french translation, thx Sasmira!
-- - add option to show most damaged item on Titan Panel (with selected discount)
-- - add total repair cost (character and inventory) to tooltip
-- - durability for damaged items moved from bank will now calculated after the bank frame is closed
-- - add option to only show damaged items on tooltip
-- - add option to show inventory durability/repair cost on Titan Panel
--
-- v1.06b
-- - add check for PLAYER_ENTERING_WORLD and PLAYER_LEAVING_WORLD, maybe there is a little decrease in zoning time
-- - Titan Panel [Durability] continued is now listed in Titan Panels "Information" category
--
-- v1.06a
-- - add inventory repair cost (can be turn off)
--
-- v1.05d
-- - changed TOC to 11000 for patch 1.10.x
-- - several very small code changes
-- - also small translation updates to clarify Honored and Sergeant discount
--
-- v1.05c
-- - changed TOC to 10900 for patch 1.9.x
-- - add frensh translation (by Halrik)
-- - fixed error if no durability available (naked)
--
-- v1.05b
-- - fixed localization error (hopefully)
--
-- v1.05a
-- - changed TOC to 1800 for patch 1.8.0
-- - repair cost only appear in tooltip if repair is necessary
-- - add repair cost line for 10% discount on honored or/and PvP Rank 3
-- - add german translation
--
-- original history: http://www.curse-gaming.com/mod.php?addid=1300
-------------------------------------------------------------------------------
TITAN_DURABILITY_ID = "Durability";
TITAN_DURABILITY_FREQUENCY = 1;

TITAN_DURABILITY_FORMAT = "%d%%";

-- Local variables
durabilitydebugmessages = 0;
playerincombat = 0;

TitanDurability_totalRepairCost = 0;
TitanDurability_duraPercent = 0;
TitanDurability_duraCurr = 0;
TitanDurability_duraTotal = 0;
TitanDurability_itemstats = {};

TitanDurability_inventory_totalRepairCost = 0;
TitanDurability_inventory_duraPercent = 0;
TitanDurability_inventory_duraCurr = 0;
TitanDurability_inventory_duraTotal = 0;

function TitanPanelDurabilityButton_OnLoad()
	_, _, TITAN_DURABILITY_TEXT = string.find(DURABILITY_TEMPLATE, "(.+) %%[^%s]+ / %%[^%s]+")
	TITAN_DURABILITY_TOOLTIP_REPAIR = REPAIR_COST.. "\t";
	TITAN_DURABILITY_TOOLTIP_REPAIR_10 = FACTION_STANDING_LABEL6 .. " ".. TITAN_DURABILITY_OR .. " " ..PVP_RANK_7_0;
	TITAN_DURABILITY_TOOLTIP_REPAIR_20 = FACTION_STANDING_LABEL6 .. " ".. TITAN_DURABILITY_AND .. " " .. PVP_RANK_7_0;
	TITAN_DURABILITY_TOOLTIP_DURA = CURRENTLY_EQUIPPED.. ":\t"
	TITAN_DURABILITY_LABEL = TITAN_DURABILITY_TEXT.. ": ";

	this.registry = {
		id = TITAN_DURABILITY_ID,
		menuText = TITAN_DURABILITY_TEXT,
		buttonTextFunction = "TitanPanelDurabilityButton_GetButtonText",
		tooltipTitle = TITAN_DURABILITY_TEXT,
		tooltipTextFunction = "TitanPanelDurabilityButton_GetTooltipText",
		frequency = TITAN_DURABILITY_FREQUENCY,
		icon = "Interface\\Icons\\Trade_BlackSmithing.blp";
		iconWidth = 16,
		category = "Information",
		version = "1.07",
		savedVariables = {
			ShowLabelText = 1,
			ShowColoredText = 1,
			ShowIcon = 1,
			iteminfo = TITAN_NIL,
			iteminfodamaged = TITAN_NIL,
			inventory = TITAN_NIL,
			showinventoryintp = TITAN_NIL,
			hideguy = 1,
			showlowestitemintp = TITAN_NIL,
			showrepaircostintp = TITAN_NIL,
			showduraintp = 1,
			showtotalduraintp = TITAN_NIL,
			showrepaircost = 1,
			showallrepaircosts = TITAN_NIL,
			showrepaircost10 = TITAN_NIL,
			showrepaircost20 = TITAN_NIL,
		}
	};

	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("UPDATE_INVENTORY_ALERTS");
	this:RegisterEvent("BANKFRAME_CLOSED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
end

function TitanPanelDurabilityButton_GetButtonText(id)
	if (not TitanDurability_duraPercent) then
		duraRichText = TITAN_DURABILITY_NUDE;
	elseif (TitanGetVar(TITAN_DURABILITY_ID, "showduraintp")) then
        if ( TitanGetVar(TITAN_DURABILITY_ID, "ShowColoredText") ) then
            duraRichText = TitanPanelDurability_GetColoredText(TitanDurability_duraPercent);
        else
            local duraText = format(TITAN_DURABILITY_FORMAT,TitanDurability_duraPercent);
            duraRichText = TitanUtils_GetHighlightText(duraText);
        end

        if (TitanDurability_duraPercent < 100) and (TitanDurability_totalRepairCost) and (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircostintp")) then
            if (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost10")) and (not TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost20")) then
                TitanDurability_totalRepairCost_temp = TitanDurability_totalRepairCost * 0.90;
            elseif (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost20")) then
                TitanDurability_totalRepairCost_temp = TitanDurability_totalRepairCost * 0.80;
            elseif (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost")) then
                TitanDurability_totalRepairCost_temp = TitanDurability_totalRepairCost;
            end

            if (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost")) or (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost10")) or (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost20")) then
                duraRichText = duraRichText.. " (".. TitanPanelDurability_GetTextGSC(TitanDurability_totalRepairCost_temp).. ")";
            end
        end
	end

	if (TitanGetVar(TITAN_DURABILITY_ID, "inventory")) and (TitanGetVar(TITAN_DURABILITY_ID, "showinventoryintp")) and (TitanDurability_inventory_duraPercent) then
		duraRichText = TitanPanelDurability_GetColoredText(TitanDurability_inventory_duraPercent);
        if (TitanDurability_inventory_totalRepairCost > 0) and (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircostintp")) then
    	    if (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost")) or (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost10")) or (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost20")) then
            	duraRichText = duraRichText.. " (".. TitanPanelDurability_GetTextGSC(TitanDurability_inventory_totalRepairCost).. ")";
	        end
        end
	end

	if (TitanGetVar(TITAN_DURABILITY_ID, "showtotalduraintp")) and (TitanDurability_duraPercent) and (TitanDurability_inventory_duraPercent) and (TitanGetVar(TITAN_DURABILITY_ID, "inventory")) then

		TitanDurability_duraPercent_complete = TitanDurability_duraPercent + TitanDurability_inventory_duraPercent;
		TitanDurability_duraPercent_complete = TitanDurability_duraPercent_complete / 2;

		duraRichText = TitanPanelDurability_GetColoredText(TitanDurability_duraPercent_complete);

		if (TitanDurability_duraPercent_complete < 100) and (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircostintp")) then
            if (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost")) or (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost10")) or (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost20")) then
            	TitanDurability_repaircost_complete = TitanDurability_totalRepairCost + TitanDurability_inventory_totalRepairCost;
                TitanDurability_repaircost_complete = TitanDurability_repaircost_complete;
                if (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost10")) then
                    TitanDurability_repaircost_complete = TitanDurability_repaircost_complete * 0.90;
                end
                if (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost20")) then
                    TitanDurability_repaircost_complete = TitanDurability_repaircost_complete * 0.80;
                end
                duraRichText = duraRichText.. " (".. TitanPanelDurability_GetTextGSC(TitanDurability_repaircost_complete).. ")";
            end
		end
	end

    if (TitanGetVar(TITAN_DURABILITY_ID, "showlowestitemintp")) and (TitanDurability_duraLowestPercent < 100) then
        duraRichText = duraRichText.. "  ".. TitanDurability_duraLowestslotName.. ": ".. TitanPanelDurability_GetColoredText(TitanDurability_duraLowestPercent);
        if (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircostintp")) then
            if (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost")) or (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost10")) or (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost20")) then
                duraRichText = duraRichText.. " (".. TitanPanelDurability_GetTextGSC(TitanDurability_duraLowestRepairCost).. ")";
            end
        end
    end

	return TITAN_DURABILITY_LABEL,duraRichText;
end

function TitanPanelDurabilityButton_GetTooltipText()
	local retstr = "\n";
	if (not TitanDurability_duraPercent) then
		retstr = retstr.. TITAN_DURABILITY_TOOLTIP_DURA.. TITAN_DURABILITY_NUDE;
	else
		retstr = retstr.. TITAN_DURABILITY_TOOLTIP_DURA.. TitanPanelDurability_GetColoredText(TitanDurability_duraPercent);
        if (TitanDurability_duraPercent < 100) then
            if (TitanGetVar(TITAN_DURABILITY_ID, "showallrepaircosts")) then
                TitanDurability_totalRepairCost_temp10 = TitanDurability_totalRepairCost * 0.90;
                TitanDurability_totalRepairCost_temp20 = TitanDurability_totalRepairCost * 0.80;
                retstr = retstr.. "\nNormal ".. REPAIR_COST.. "\t".. TitanPanelDurability_GetTextGSC(TitanDurability_totalRepairCost);
                retstr = retstr.. "\n".. TITAN_DURABILITY_TOOLTIP_REPAIR_10.. ":\t".. TitanPanelDurability_GetTextGSC(TitanDurability_totalRepairCost_temp10);
                retstr = retstr.. "\n".. TITAN_DURABILITY_TOOLTIP_REPAIR_20.. ":\t".. TitanPanelDurability_GetTextGSC(TitanDurability_totalRepairCost_temp20);
            else
                if (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost20")) then
                    TitanDurability_totalRepairCost_20 = TitanDurability_totalRepairCost * 0.80;
                    retstr = retstr.. " (".. TitanPanelDurability_GetTextGSC(TitanDurability_totalRepairCost_20).. ")";
                elseif (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost10")) then
                    TitanDurability_totalRepairCost_10 = TitanDurability_totalRepairCost * 0.90;
                    retstr = retstr.. " (".. TitanPanelDurability_GetTextGSC(TitanDurability_totalRepairCost_10).. ")";
                elseif (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost")) then
                    retstr = retstr.. " (".. TitanPanelDurability_GetTextGSC(TitanDurability_totalRepairCost).. ")";
                end
            end
        end
	end

	if (TitanGetVar(TITAN_DURABILITY_ID, "iteminfo")) and (TitanDurability_duraPercent) then
		if (TitanDurability_duraPercent < 100) or (not TitanGetVar(TITAN_DURABILITY_ID, "iteminfodamaged")) then
            local slots = {
                {"Head", HEADSLOT},
                {"Shoulder", SHOULDERSLOT},
                {"Chest", CHESTSLOT},
                {"Wrist", WRISTSLOT},
                {"Hands", HANDSSLOT},
                {"Waist", WAISTSLOT},
                {"Legs", LEGSSLOT},
                {"Feet", FEETSLOT},
                {"MainHand", MAINHANDSLOT},
                {"SecondaryHand", SECONDARYHANDSLOT},
                {"Ranged", RANGEDSLOT},
            };

            retstr = retstr.. "\n";
            for i,arr in slots do
                local stats = TitanDurability_itemstats[arr[1]];
                if (stats) then
                    if (stats[1] == GSC_NONE) then
                        if (not TitanGetVar(TITAN_DURABILITY_ID, "iteminfodamaged")) then
                            retstr = retstr.. "\n".. arr[2].. ":\t".. stats[1];
                        end
                    else
                        if (not TitanGetVar(TITAN_DURABILITY_ID, "iteminfodamaged")) or (stats[1] < 100) then
                            if ( TitanGetVar(TITAN_DURABILITY_ID, "ShowColoredText") ) then
                                retstr = retstr.. "\n".. arr[2].. ":\t".. TitanPanelDurability_GetColoredText(stats[1]);
                            else
                                local duraText = TitanUtils_GetHighlightText(format(TITAN_DURABILITY_FORMAT,stats[1]));
                                retstr = retstr.. "\n".. arr[2]..":\t".. duraText;
                            end
                            if (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost")) or (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost10")) or (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost20")) then
                                cost = TitanDurability_itemstats[arr[1]][2];
                                if (cost ~= GSC_NONE) then
                                    retstr = retstr.. " (".. cost.. ")";
                                end
                            end
                        end
                    end
                end
            end
        end
	end

	if (TitanGetVar(TITAN_DURABILITY_ID, "inventory")) then
        if (TitanGetVar(TITAN_DURABILITY_ID, "iteminfo")) and (TitanDurability_duraPercent) then
        	if (TitanDurability_duraPercent < 100) or (not TitanGetVar(TITAN_DURABILITY_ID, "iteminfodamaged")) then
           		retstr = retstr.. "\n";
           	end
        end

        if (not TitanDurability_inventory_duraPercent) then
            retstr = retstr.. "\n".. INVENTORY_TOOLTIP.. ":\t".. GSC_NONE.. "\n";
        else
            retstr = retstr.. "\n".. INVENTORY_TOOLTIP.. ":\t".. TitanPanelDurability_GetColoredText(TitanDurability_inventory_duraPercent);

            if (TitanDurability_inventory_duraPercent < 100) then
                if (TitanGetVar(TITAN_DURABILITY_ID, "showallrepaircosts")) then
                    TitanDurability_inventory_totalRepairCost_temp10 = TitanDurability_inventory_totalRepairCost * 0.90;
                    TitanDurability_inventory_totalRepairCost_temp20 = TitanDurability_inventory_totalRepairCost * 0.80;
                    retstr = retstr.. "\nNormal ".. REPAIR_COST.. "\t".. TitanPanelDurability_GetTextGSC(TitanDurability_inventory_totalRepairCost);
                    retstr = retstr.. "\n".. TITAN_DURABILITY_TOOLTIP_REPAIR_10.. ":\t".. TitanPanelDurability_GetTextGSC(TitanDurability_inventory_totalRepairCost_temp10);
                    retstr = retstr.. "\n".. TITAN_DURABILITY_TOOLTIP_REPAIR_20.. ":\t".. TitanPanelDurability_GetTextGSC(TitanDurability_inventory_totalRepairCost_temp20);
                else
                    if (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost20")) then
                        TitanDurability_inventory_totalRepairCost_20 = TitanDurability_inventory_totalRepairCost * 0.80;
                        retstr = retstr.. " (".. TitanPanelDurability_GetTextGSC(TitanDurability_inventory_totalRepairCost_20).. ")";
                    elseif (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost10")) then
                        TitanDurability_inventory_totalRepairCost_10 = TitanDurability_inventory_totalRepairCost * 0.90;
                        retstr = retstr.. " (".. TitanPanelDurability_GetTextGSC(TitanDurability_inventory_totalRepairCost_10).. ")";
                    elseif (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost")) then
                        retstr = retstr.. " (".. TitanPanelDurability_GetTextGSC(TitanDurability_inventory_totalRepairCost).. ")";
                    end
                end
            end
        end
	end


	if (TitanDurability_duraPercent) and (TitanDurability_inventory_duraPercent) and (TitanGetVar(TITAN_DURABILITY_ID, "inventory")) then

		TitanDurability_duraPercent_complete = TitanDurability_duraPercent + TitanDurability_inventory_duraPercent;
		TitanDurability_duraPercent_complete = TitanDurability_duraPercent_complete / 2;

		retstr = retstr.. "\n\n".. COMPLETE.. " ".. REPAIR_COST.. "\t".. TitanPanelDurability_GetColoredText(TitanDurability_duraPercent_complete);

		if (TitanDurability_duraPercent_complete < 100) then
            if (TitanGetVar(TITAN_DURABILITY_ID, "showallrepaircosts")) then
            	TitanDurability_repaircost_complete = TitanDurability_totalRepairCost + TitanDurability_inventory_totalRepairCost;
                TitanDurability_totalRepairCost_complete_temp10 = TitanDurability_repaircost_complete * 0.90;
                TitanDurability_totalRepairCost_complete_temp20 = TitanDurability_repaircost_complete * 0.80;
                retstr = retstr.. "\nNormal ".. REPAIR_COST.. "\t".. TitanPanelDurability_GetTextGSC(TitanDurability_repaircost_complete);
                retstr = retstr.. "\n".. TITAN_DURABILITY_TOOLTIP_REPAIR_10.. ":\t".. TitanPanelDurability_GetTextGSC(TitanDurability_totalRepairCost_complete_temp10);
                retstr = retstr.. "\n".. TITAN_DURABILITY_TOOLTIP_REPAIR_20.. ":\t".. TitanPanelDurability_GetTextGSC(TitanDurability_totalRepairCost_complete_temp20);
            else
                if (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost")) or (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost10")) or (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost20")) then
                    TitanDurability_repaircost_complete = TitanDurability_totalRepairCost + TitanDurability_inventory_totalRepairCost;
                    TitanDurability_repaircost_complete = TitanDurability_repaircost_complete;
                    if (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost10")) then
                        TitanDurability_repaircost_complete = TitanDurability_repaircost_complete * 0.90;
                    end
                    if (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost20")) then
                        TitanDurability_repaircost_complete = TitanDurability_repaircost_complete * 0.80;
                    end
                    retstr = retstr.. " (".. TitanPanelDurability_GetTextGSC(TitanDurability_repaircost_complete).. ")";
                end
            end
		end
	end

	return retstr;
end

function TitanPanelDurabilityButton_OnEvent()
	if (event == "PLAYER_REGEN_ENABLED") then
		playerincombat = 0;
	elseif (event == "PLAYER_REGEN_DISABLED") then
		playerincombat = 1;
	end

	if (event == "PLAYER_ENTERING_WORLD") or (event == "UPDATE_INVENTORY_ALERTS") or (event == "BANKFRAME_CLOSED") or (event == "PLAYER_REGEN_ENABLED") then
		if (playerincombat == 0) then
			TitanPanelDurability_CalcValues();
		end
	end

    if (event == "PLAYER_ENTERING_WORLD") then
        this:RegisterEvent("UPDATE_INVENTORY_ALERTS");
        this:RegisterEvent("BANKFRAME_CLOSED");
        this:RegisterEvent("PLAYER_REGEN_ENABLED");
        this:RegisterEvent("PLAYER_REGEN_DISABLED");
        return;
    end

    if (event == "PLAYER_LEAVING_WORLD") then
		this:UnregisterEvent("UPDATE_INVENTORY_ALERTS");
		this:UnregisterEvent("BANKFRAME_CLOSED");
        this:UnregisterEvent("PLAYER_REGEN_ENABLED");
        this:UnregisterEvent("PLAYER_REGEN_DISABLED");
		return;
    end
end

function TitanPanelRightClickMenu_PrepareDurabilityMenu()
	local id = "Durability";
	local info = {};

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_DURABILITY_ID].menuText);
	TitanPanelRightClickMenu_AddSpacer();

	info = {};
	info.text = TITAN_DURABILITY_MENU_INVENTORY;
	info.value = "inventory";
	info.func = TitanPanelDurability_Toggle;
	info.checked = TitanGetVar(TITAN_DURABILITY_ID, "inventory");
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_DURABILITY_MENU_ITEMS;
	info.value = "iteminfo";
	info.func = TitanPanelDurability_Toggle;
	info.checked = TitanGetVar(TITAN_DURABILITY_ID, "iteminfo");
	UIDropDownMenu_AddButton(info);

	if (TitanGetVar(TITAN_DURABILITY_ID, "iteminfo")) then
        info = {};
        info.text = TITAN_DURABILITY_MENU_ITEMS_DAMAGED;
        info.value = "iteminfodamaged";
        info.func = TitanPanelDurability_Toggle;
        info.checked = TitanGetVar(TITAN_DURABILITY_ID, "iteminfodamaged");
        UIDropDownMenu_AddButton(info);
	end

	info = {};
	info.text = TITAN_DURABILITY_MENU_GUY;
	info.value = "hideguy";
	info.func = TitanPanelDurability_Toggle;
	info.checked = TitanGetVar(TITAN_DURABILITY_ID, "hideguy");
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddTitle("Display on Titan Panel:");
	TitanPanelRightClickMenu_AddSpacer();

    info = {};
    info.text = CURRENTLY_EQUIPPED.. " ".. TITAN_DURABILITY_MENU_DURABILITY;
    info.value = "showduraintp";
    info.func = TitanPanelDurability_Toggle;
    info.checked = TitanGetVar(TITAN_DURABILITY_ID, "showduraintp");
    UIDropDownMenu_AddButton(info);

	if (TitanGetVar(TITAN_DURABILITY_ID, "inventory")) then
        info = {};
        info.text = TITAN_DURABILITY_MENU_INVENTORYINTP;
        info.value = "showinventoryintp";
        info.func = TitanPanelDurability_Toggle;
        info.checked = TitanGetVar(TITAN_DURABILITY_ID, "showinventoryintp");
        UIDropDownMenu_AddButton(info);
	end

    info = {};
    info.text = COMPLETE.. " ".. TITAN_DURABILITY_MENU_DURABILITY;
    info.value = "showtotalduraintp";
    info.func = TitanPanelDurability_Toggle;
    info.checked = TitanGetVar(TITAN_DURABILITY_ID, "showtotalduraintp");
    UIDropDownMenu_AddButton(info);

    info = {};
    info.text = TITAN_DURABILITY_MENU_REPAIRCOSTLOWESTINTP;
    info.value = "showlowestitemintp";
    info.func = TitanPanelDurability_Toggle;
    info.checked = TitanGetVar(TITAN_DURABILITY_ID, "showlowestitemintp");
    UIDropDownMenu_AddButton(info);

	if (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost")) or (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost10")) or (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost20")) then
        info = {};
        info.text = REPAIR_COST;
        info.value = "showrepaircostintp";
        info.func = TitanPanelDurability_Toggle;
        info.checked = TitanGetVar(TITAN_DURABILITY_ID, "showrepaircostintp");
        UIDropDownMenu_AddButton(info);
	end

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddTitle("Display of Repaircost:");
	TitanPanelRightClickMenu_AddSpacer();

	info = {};
	info.text = "Normal ".. REPAIR_COST;
	info.value = "showrepaircost";
	info.func = TitanPanelDurability_Toggle;
	info.checked = TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost");
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_DURABILITY_MENU_REPAIRCOST10.. " (".. TITAN_DURABILITY_TOOLTIP_REPAIR_10.. ")";
	info.value = "showrepaircost10";
	info.func = TitanPanelDurability_Toggle;
	info.checked = TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost10");
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_DURABILITY_MENU_REPAIRCOST20.. " (".. TITAN_DURABILITY_TOOLTIP_REPAIR_20.. ")";
	info.value = "showrepaircost20";
	info.func = TitanPanelDurability_Toggle;
	info.checked = TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost20");
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = TITAN_DURABILITY_MENU_ALLDISCOUNTS;
	info.value = "showallrepaircosts";
	info.func = TitanPanelDurability_Toggle;
	info.checked = TitanGetVar(TITAN_DURABILITY_ID, "showallrepaircosts");
	UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();

	TitanPanelRightClickMenu_AddToggleIcon(TITAN_DURABILITY_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_DURABILITY_ID);
	TitanPanelRightClickMenu_AddToggleColoredText(TITAN_DURABILITY_ID);
	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, id, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelDurability_Toggle()
    if (this.value == "showrepaircost") then
        TitanSetVar(TITAN_DURABILITY_ID, "showrepaircost10", TITAN_NIL);
        TitanSetVar(TITAN_DURABILITY_ID, "showrepaircost20", TITAN_NIL);
    end

    if (this.value == "showrepaircost10") then
        TitanSetVar(TITAN_DURABILITY_ID, "showrepaircost", TITAN_NIL);
        TitanSetVar(TITAN_DURABILITY_ID, "showrepaircost20", TITAN_NIL);
    end

    if (this.value == "showrepaircost20") then
        TitanSetVar(TITAN_DURABILITY_ID, "showrepaircost", TITAN_NIL);
        TitanSetVar(TITAN_DURABILITY_ID, "showrepaircost10", TITAN_NIL);
    end


    if (this.value == "showduraintp") then
        TitanSetVar(TITAN_DURABILITY_ID, "showtotalduraintp", TITAN_NIL);
        TitanSetVar(TITAN_DURABILITY_ID, "showinventoryintp", TITAN_NIL);
    end

    if (this.value == "showtotalduraintp") then
        TitanSetVar(TITAN_DURABILITY_ID, "showduraintp", TITAN_NIL);
        TitanSetVar(TITAN_DURABILITY_ID, "showinventoryintp", TITAN_NIL);
    end

    if (this.value == "showinventoryintp") then
        TitanSetVar(TITAN_DURABILITY_ID, "showduraintp", TITAN_NIL);
        TitanSetVar(TITAN_DURABILITY_ID, "showtotalduraintp", TITAN_NIL);
    end

	TitanToggleVar(TITAN_DURABILITY_ID, this.value);


	if (this.value == "showduraintp") or (this.value == "showtotalduraintp") or (this.value == "showinventoryintp") then
		if (not TitanGetVar(TITAN_DURABILITY_ID, "showduraintp")) and (not TitanGetVar(TITAN_DURABILITY_ID, "showtotalduraintp")) and (not TitanGetVar(TITAN_DURABILITY_ID, "showinventoryintp")) then
			TitanToggleVar(TITAN_DURABILITY_ID, this.value);
		end
	end

	TitanPanelButton_UpdateButton(TITAN_DURABILITY_ID);

	if (this.value == "hideguy") or (this.value == "inventory") or (this.value == "showrepaircost") or (this.value == "showrepaircost10") or (this.value == "showrepaircost20") then
    	TitanPanelDurability_CalcValues();
	end
end

function TitanDurability_GetStatusPercent(val, max)
	if (max > 0) then
		return (val / max);
	end
	return 1.0;
end;

function TitanDurability_GetStatus(index, bag)
	local val = 0;
	local max = 0;
	local cost = 0;
	local hasItem, repairCost;

	TPDurTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");

	if (bag) then
		local _, lRepairCost = TPDurTooltip:SetBagItem(bag, index);
		repairCost = lRepairCost;
		hasItem = 1;
	else
		local slotName = REPAIR_ITEM_STATUS[index].slot .. "Slot";

		local id = GetInventorySlotInfo(slotName);
		local lHasItem, _, lRepairCost = TPDurTooltip:SetInventoryItem("player", id);
		hasItem = lHasItem;
		repairCost = lRepairCost;
	end

	if (hasItem) then
		if (repairCost) then
			cost = repairCost;
		end

		for i = 1, 30 do
			local field = getglobal("TPDurTooltipTextLeft" .. i);
			if (field ~= nil) then
				local text = field:GetText();
				if (text) then
					-- find durability
					local _, _, f_val, f_max = string.find(text, TITAN_DURABILITY_DURABILITYTEXT);
					if (f_val) then
						val = tonumber(f_val);
						max = tonumber(f_max);
					end
				end
			end

		end

	end

	TPDurTooltip:Hide();
	return TitanDurability_GetStatusPercent(val, max), val, max, cost;

end

function TitanPanelDurability_CalcValues()

    if (durabilitydebugmessages == 1) then
        ChatFrame1:AddMessage("Titan Durability: calculated on "..event, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
    end

	-- hide Durability "guy"
	if (TitanGetVar(TITAN_DURABILITY_ID, "hideguy")) then
		if (DurabilityFrame:IsVisible()) then
			DurabilityFrame:Hide();
		end
	end

	local slotnames = {
		"Head",
		"Shoulder",
		"Chest",
		"Wrist",
		"Hands",
		"Waist",
		"Legs",
		"Feet",
		"MainHand",
		"SecondaryHand",
		"Ranged",
	};

	local id, hasItem, repairCost;
	local itemName, durability, tmpText, midpt, lval, rval;

	TitanDurability_totalRepairCost = 0;
	TitanDurability_duraPercent = 0;
	TitanDurability_duraCurr = 0;
	TitanDurability_duraTotal = 0;
	TitanDurability_inventory_totalRepairCost = 0;
	TitanDurability_inventory_duraPercent = 0;
	TitanDurability_inventory_duraCurr = 0;
	TitanDurability_inventory_duraTotal = 0;
	TitanDurability_duraLowestPercent = 100;
	TitanDurability_duraLowestRepairCost = 0;
	TitanDurability_duraLowestslotName = GSC_NONE;

	for i,slotName in slotnames do
		id, _ = GetInventorySlotInfo(slotName.. "Slot");
		TPDurTooltip:Hide()
		TPDurTooltip:SetOwner(this, "ANCHOR_LEFT");
		hasItem, _, Current_Item_RepairCost = TPDurTooltip:SetInventoryItem("player", id);

		Current_Item_RepairCost_temp = Current_Item_RepairCost;

		if (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost10")) and (not TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost20")) then
			Current_Item_RepairCost_temp = Current_Item_RepairCost_temp * 0.90;
		elseif (TitanGetVar(TITAN_DURABILITY_ID, "showrepaircost20")) then
			Current_Item_RepairCost_temp = Current_Item_RepairCost_temp * 0.80;
		end

		if (not hasItem) then
			TPDurTooltip:ClearLines()
		else
			itemName = TPDurTooltipTextLeft1:GetText();

			for i=2, 15, 1 do
				tmpText = getglobal("TPDurTooltipTextLeft"..i);
				lval = nil;
				rval = nil;
				if (tmpText:GetText()) then
					local searchstr = string.gsub(DURABILITY_TEMPLATE, "%%[^%s]+", "(.+)")
					_, _, lval, rval = string.find(tmpText:GetText(), searchstr);
				end
				if (lval and rval) then
					break;
				end
			end
		end

		if (lval and rval) then
			local current_item_percent;
			if (rval == 0) then
				current_item_percent = GSC_NONE;
			else
				current_item_percent = math.floor(lval / rval * 100);
                if (current_item_percent < TitanDurability_duraLowestPercent) then
                    TitanDurability_duraLowestPercent = current_item_percent;
                    TitanDurability_duraLowestRepairCost = Current_Item_RepairCost_temp;
                    TitanDurability_duraLowestslotName = slotName;
                end
			end
			TitanDurability_itemstats[slotName] = {current_item_percent, TitanPanelDurability_GetTextGSC(Current_Item_RepairCost_temp)};
			TitanDurability_duraCurr = TitanDurability_duraCurr + lval;
			TitanDurability_duraTotal = TitanDurability_duraTotal + rval;
			TitanDurability_totalRepairCost = TitanDurability_totalRepairCost + Current_Item_RepairCost;
			lval = 0;
			rval = 0;
		else
			TitanDurability_itemstats[slotName] = {GSC_NONE, GSC_NONE};
		end
	end

	if (TitanGetVar(TITAN_DURABILITY_ID, "inventory")) then
        for bag = 0, 4 do
            for slot = 1, GetContainerNumSlots(bag) do
                local _, lval, rval, repairCost = TitanDurability_GetStatus(slot, bag);
                TitanDurability_inventory_duraCurr = TitanDurability_inventory_duraCurr + lval;
                TitanDurability_inventory_duraTotal = TitanDurability_inventory_duraTotal + rval;
                TitanDurability_inventory_totalRepairCost = TitanDurability_inventory_totalRepairCost + repairCost;
            end
        end
    end

	TPDurTooltip:Hide()

	if (TitanGetVar(TITAN_DURABILITY_ID, "inventory")) then
        if (TitanDurability_inventory_duraTotal == 0) then
            TitanDurability_inventory_duraPercent = nil;
        else
            TitanDurability_inventory_duraPercent = math.floor(TitanDurability_inventory_duraCurr / TitanDurability_inventory_duraTotal * 100);
        end
	end

	if (TitanDurability_duraTotal == 0) then
		TitanDurability_duraPercent = nil;
	else
		TitanDurability_duraPercent = math.floor(TitanDurability_duraCurr / TitanDurability_duraTotal * 100);
	end
end

function TitanPanelDurability_GetGSC(money)
	local neg = false;
	if (money == nil) then money = 0; end
	if (money < 0) then
		neg = true;
		money = money * -1;
	end
	local g = math.floor(money / 10000);
	local s = math.floor((money - (g*10000)) / 100);
	local c = math.floor(money - (g*10000) - (s*100));
	return g,s,c,neg;
end

GSC_GOLD = "ffd100";
GSC_SILVER = "e6e6e6";
GSC_COPPER = "c8602c";
GSC_START = "|cff%s%d|r";
GSC_PART = ".|cff%s%02d|r";
GSC_NONE = "|cffa0a0a0"..NONE.."|r";

function TitanPanelDurability_GetTextGSC(money)
	local g, s, c, neg = TitanPanelDurability_GetGSC(money);
	local gsc = "";
	if (g > 0) then
		gsc = format(GSC_START, GSC_GOLD, g);
		gsc = gsc..format(GSC_PART, GSC_SILVER, s);
		gsc = gsc..format(GSC_PART, GSC_COPPER, c);
	elseif (s > 0) then
		gsc = format(GSC_START, GSC_SILVER, s);
		gsc = gsc..format(GSC_PART, GSC_COPPER, c);
	elseif (c > 0) then
		gsc = gsc..format(GSC_START, GSC_COPPER, c);
	else
		gsc = GSC_NONE;
	end

	if (neg) then gsc = "(".. gsc.. ")"; end

	return gsc;
end

function TitanPanelDurability_GetColoredText(percent)
	local green = GREEN_FONT_COLOR;		-- 0.1, 1.00, 0.1
	local yellow = NORMAL_FONT_COLOR;	-- 1.0, 0.82, 0.0
	local red = RED_FONT_COLOR;			-- 1.0, 0.10, 0.1

	percent = percent / 100;
	local color = {};

	if (percent == 1.0) then
		color = green;
	elseif (percent == 0.5) then
		color = yellow;
	elseif (percent == 0.0) then
		color = red;
	elseif (percent > 0.5) then
		local pct = (1.0 - percent) * 2;
		color.r =(yellow.r - green.r)*pct + green.r;
		color.g = (yellow.g - green.g)*pct + green.g;
		color.b = (yellow.b - green.b)*pct + green.b;
	elseif (percent < 0.5) then
		local pct = (0.5 - percent) * 2;
		color.r = (red.r - yellow.r)*pct + yellow.r;
		color.g = (red.g - yellow.g)*pct + yellow.g;
		color.b = (red.b - yellow.b)*pct + yellow.b;
	end

	local txt = format(TITAN_DURABILITY_FORMAT,percent*100);
	local colortxt = TitanUtils_GetColoredText(txt, color);

	return colortxt;
end