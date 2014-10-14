------------------------------------------------------
-- ShoppingList.lua
------------------------------------------------------
FSL_VERSION = "11200.1";
------------------------------------------------------

-- Saved configuration & info
FSL_Config = { };
FSL_Config.Enabled = true;

FSL_ShoppingList = { };
-- Has the following internal structure:
--		REALM = {
--			ITEM_LINK,
--		}

-- Constants

function FSL_FinishedAuctionScan()
	FSL_Original_FinishedAuctionScan();
	if (FSL_Config.Enabled) then
		PlaySound("AuctionWindowClose");
		FSL_Report();
	end
end

function FSL_ScanDone(instance)
	FSL_Original_ScanDone(instance);
	if (FSL_Config.Enabled) then
		PlaySound("AuctionWindowClose");
		FSL_Report();
	end
end

function FSL_OnLoad()

	-- Register Slash Commands
	SLASH_FSL1 = "/shoppinglist";
	SLASH_FSL2 = "/sl";
	SlashCmdList["FSL"] = function(msg)
		FSL_ChatCommandHandler(msg);
	end
	
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("ADDON_LOADED");
	
	GFWUtils.Print("Fizzwidget ShoppingList "..FSL_VERSION.." initialized!");
	
end

function FSL_OnEvent(event)
	if (event == "VARIABLES_LOADED" or event == "ADDON_LOADED") then
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo("Auctioneer");
		if (loadable or IsAddOnLoaded("Auctioneer") and FSL_DataSource == nil) then
			FSL_DataSource = "Auctioneer";
		end
		local auctioneerVersion = AUCTIONEER_VERSION;
		if (Auctioneer and Auctioneer.Version) then
			auctioneerVersion = Auctioneer.Version;
		end
		if (auctioneerVersion ~= nil) then
			local _, _, major, minor = string.find(auctioneerVersion, "^(%d+)%.(%d+)");
			major, minor = tonumber(major), tonumber(minor);
			if (major ~= nil and major >= 3 and minor ~= nil and minor >= 1) then
				if (FSL_Original_FinishedAuctionScan == nil and Auctioneer and Auctioneer.Event and Auctioneer.Event.FinishedAuctionScan) then
					FSL_Original_FinishedAuctionScan = Auctioneer.Event.FinishedAuctionScan;
					Auctioneer.Event.FinishedAuctionScan = FSL_FinishedAuctionScan;
				elseif (FSL_Original_FinishedAuctionScan == nil and Auctioneer_Event_FinishedAuctionScan) then
					FSL_Original_FinishedAuctionScan = Auctioneer_Event_FinishedAuctionScan;
					Auctioneer_Event_FinishedAuctionScan = FSL_FinishedAuctionScan;
				end
				
				FSL_DataSource = "Auctioneer";
			end
		elseif (KC_ItemsAuction ~= nil and KC_ItemsAuction.EnablePersistance ~= nil and FSL_Original_ScanDone == nil) then
			KC_ItemsAuction:EnablePersistance();
			FSL_Original_ScanDone = KC_ItemsAuction.ScanDone;
			KC_ItemsAuction.ScanDone = FSL_ScanDone;
			
			FSL_DataSource = "KC_Items";
		end
	end
end

function FSL_ChatCommandHandler(msg)

	-- Print Help
	if ( msg == "help" ) or ( msg == "" ) then
		GFWUtils.Print("Fizzwidget ShoppingList "..FSL_VERSION..":");
		GFWUtils.Print("/shoppinglist /sl <command>");
		GFWUtils.Print("- "..GFWUtils.Hilite("help").." - Print this helplist.");
		GFWUtils.Print("- "..GFWUtils.Hilite("list").." - Show current list");
		GFWUtils.Print("- "..GFWUtils.Hilite("add <item link>").." - add an item to the list");
		GFWUtils.Print("- "..GFWUtils.Hilite("remove <item link>").." - remove an item from the list");
		GFWUtils.Print("- "..GFWUtils.Hilite("clear").." - Empty the list for this realm.");
		if (FSL_DataSource ~= nil) then
			GFWUtils.Print("- "..GFWUtils.Hilite("autoreport on").." | "..GFWUtils.Hilite("off").." - Enable or disable printing a report when your AH scans finish.");
			GFWUtils.Print("- "..GFWUtils.Hilite("status").." - Check current settings.");
			GFWUtils.Print("- "..GFWUtils.Hilite("report").." - List \"best deals\" for items on your shopping list in the last auction scan.");
		end
		return;
	end
	
	if (msg == "version") then
		GFWUtils.Print("Fizzwidget ShoppingList "..FSL_VERSION);
		return;
	end
	
	if (msg == "autoreport on") then
		FSL_Config.Enabled = true;
		if (FSL_DataSource ~= nil) then
			GFWUtils.Print("ShoppingList autoreporting is enabled; info will be printed when an AH scan finishes.");
		else
			GFWUtils.Print("ShoppingList autoreporting is enabled but non-functional; Auctioneer or KC_Items is not installed.");
		end
		return;
	end
	if (msg == "autoreport off") then
		FSL_Config.Enabled = false;
		GFWUtils.Print("ShoppingList autoreporting is disabled; no extra info will be printed when an AH scan finishes");
		return;
	end

	-- Check Status
	if ( msg == "status" ) then
		if ( FSL_Config.Enabled ) then
			if (FSL_DataSource ~= nil) then
				GFWUtils.Print("ShoppingList autoreporting is enabled; info will be printed when an AH scan finishes.");
			else
				GFWUtils.Print("ShoppingList autoreporting is enabled but non-functional; Auctioneer or KC_Items is not installed.");
			end
		else
			GFWUtils.Print("ShoppingList autoreporting is disabled; no extra info will be printed when an AH scan finishes");
		end
		return;
	end
	
	local realm = GetCVar("realmName");
	local realmList = FSL_ShoppingList[realm];
	
	if ( msg == "list" ) then
		if (realmList == nil or table.getn(realmList) == 0) then
			GFWUtils.Print("Shopping list is empty.");
		else
			GFWUtils.Print("Shopping list:");
			for _, itemLink in realmList do
				GFWUtils.Print(itemLink);
			end
		end
		return;
	end
	
	if ( msg == "clear" ) then
		FSL_ShoppingList[realm] = {};
		GFWUtils.Print("Shopping list is now empty.");
		return;
	end
	
	if ( msg == "report") then
		if (FSL_DataSource ~= nil) then
			if (realmList == nil or table.getn(realmList) == 0) then
				GFWUtils.Print("Shopping list is empty.");
			else
				FSL_Report();
			end
		else
			GFWUtils.Print("ShoppingList can't generate a report; Auctioneer or KC_Items is not installed.");
		end
		return;
	end
	
	local _, _, cmd, args = string.find(msg, "(%w+) (.+)");
	for itemLink in string.gfind(args, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[.-%]|h|r") do
		if (cmd == "add") then
			if (realmList ~= nil and GFWTable.IndexOf(realmList, itemLink) ~= 0) then
				GFWUtils.Print(itemLink.." already in shopping list.");
			else
				if (realmList == nil) then
					FSL_ShoppingList[realm] = {};
					realmList = FSL_ShoppingList[realm];
				end
				table.insert(realmList, itemLink);
				table.sort(realmList);
				GFWUtils.Print("Added "..itemLink.." to shopping list.");
			end
		elseif (cmd == "remove") then
			if (realmList == nil or table.getn(realmList) == 0) then
				GFWUtils.Print("Shopping list is empty.");
			else
				local index = GFWTable.IndexOf(realmList, itemLink);
				if (index > 0) then
					table.remove(realmList, index);
					GFWUtils.Print("Removed "..itemLink.." from shopping list.");
				else
					GFWUtils.Print("Could not find "..itemLink.." in shopping list.");
				end
			end
		end
	end	
	
end

function FSL_IsItemWithBuyoutFilter(itemLink, signature)
	local getItemSignature = Auctioneer_GetItemSignature or Auctioneer.Core.GetItemSignature;
	if (not getItemSignature) then
		GFWUtils.PrintOnce(GFWUtils.Red("ShoppingList error:").." missing expected Auctioneer API; can't calculate item prices.", 5);
		return nil, nil;
	end
	local id, rprop, enchant, name, count, min, buyout, uniq = getItemSignature(signature);
	if (buyout > 0 and string.find(itemLink, id) and string.find(itemLink, name)) then
		return false;
	else
		return true;
	end
end

function FSL_Report()
	if (FSL_DataSource == "Auctioneer") then
		if (not IsAddOnLoaded("Auctioneer")) then
			local loaded, reason = LoadAddOn("Auctioneer");
			if (not loaded) then
				GFWUtils.Print("Can't load Auctioneer: "..reason);
				return;
			end
		end
		FSL_AuctioneerReport();
	elseif (FSL_DataSource == "KC_Items") then
		FSL_KCI_Report();
	end
end

function FSL_AuctioneerReport()
	local getItemSignature = Auctioneer_GetItemSignature or Auctioneer.Core.GetItemSignature;
	local querySnapshot = Auctioneer_QuerySnapshot or Auctioneer.Filter.QuerySnapshot;
	if (not (querySnapshot and getItemSignature)) then
		GFWUtils.PrintOnce(GFWUtils.Red("ShoppingList error:").." missing expected Auctioneer API; can't calculate item prices.", 5);
		return nil, nil;
	end

	local realm = GetCVar("realmName");
	local realmList = FSL_ShoppingList[realm];
	
	if realmList == nil then return; end
	table.sort(realmList);
	
	local printedSomething = false;
	for _, itemLink in realmList do
		
		-- get all the auctions for this item
		local itemAuctions = querySnapshot(FSL_IsItemWithBuyoutFilter, itemLink);
		
		if (table.getn(itemAuctions) > 0) then
		
			-- sort based on amount below median price
			table.sort(itemAuctions, FSL_GoodDealSort);

			-- show the top auction for each item
			local id, rprop, enchant, name, count, min, buyout, uniq = getItemSignature(itemAuctions[1].signature);
			local countString = "";
			if (count > 1) then
				countString = GFWUtils.Hilite(count.."x");
			end
			local percent = FSL_PercentBuyoutBelowMedian(itemAuctions[1].signature);
			local percentSummary;
			if (percent > 0) then
				percentSummary = GFWUtils.Hilite("("..percent.."% below median buyout)");
			elseif (percent < 0) then
				percentSummary = "(".. math.abs(percent).."% "..GFWUtils.Red("above").." median buyout)";
			else
				percentSummary = GFWUtils.Gray("(matches median buyout)");
			end
			GFWUtils.Print(countString..itemLink.." available for "..GFWUtils.TextGSC(buyout)..percentSummary..".");
			printedSomething = true;
		end
	end
	if (not printedSomething) then
		GFWUtils.Print("No items from your list are currently available at auction.");
	end
end

function FSL_PercentBuyoutBelowMedian(itemSignature)
	local getUsableMedian = Auctioneer_GetUsableMedian or Auctioneer.Statistic.GetUsableMedian;
	local getHistoricalMedian = Auctioneer_GetItemHistoricalMedianBuyout or Auctioneer.Statistic.GetItemHistoricalMedianBuyout;
	local getItemSignature = Auctioneer_GetItemSignature or Auctioneer.Core.GetItemSignature;
	if (not (getUsableMedian and getHistoricalMedian and getItemSignature)) then
		GFWUtils.PrintOnce(GFWUtils.Red("ShoppingList error:").." missing expected Auctioneer API; can't calculate item prices.", 5);
		return nil, nil;
	end

	local id, rprop, enchant, name, count, min, buyout, uniq = getItemSignature(itemSignature);
	local itemKey = id .. ":" .. rprop..":"..enchant;
	local medBuyout = getUsableMedian(itemKey);
	if (medBuyout == nil) then
		medBuyout = getHistoricalMedian(itemKey);
	end
	return FSL_PercentLessThan(medBuyout * count, buyout);
end

-- method to pass to table.sort() that sorts auctions by amount less than median price
function FSL_GoodDealSort(a, b)	
	return (FSL_PercentBuyoutBelowMedian(a.signature) > FSL_PercentBuyoutBelowMedian(b.signature)) 
end

function FSL_KCI_Report()
	local realm = GetCVar("realmName");
	local realmList = FSL_ShoppingList[realm];
	
	if (realmList == nil) then return; end
	if (KC_ItemsAuction.snapshot == nil) then 
		GFWUtils.Print("You don't have any current auction data; run an AH scan before seeking a report");
		return; 
	end
	
	local itemCodes = {};
	for _, itemLink in realmList do
		itemCodes[KC_Items:GetCode(itemLink)] = itemLink;
	end
	
	local items = KC_ItemsAuction.snapshot:get();
	local printedSomething = false;
	for code in items do
		if (itemCodes[code]) then
			local item = items[code];
			local buys = item.buys;
			local stacks = item.stacks;
			
			if ( buys ~= nil and type(buys) == "table" and table.getn(buys) > 0) then
			
				local minBuy = math.min(unpack(buys));
				local seen, avgstack, min, bidseen, bid, buyseen, buy = KC_ItemsAuction:getItemData(code);
				local percent = FSL_PercentLessThan(minBuy, buy);
				local percentSummary;
				if (percent > 0) then
					percentSummary = GFWUtils.Hilite("("..percent.."% below avg buyout)");
				elseif (percent < 0) then
					percentSummary = "("..math.abs(percent).."% "..GFWUtils.Red("above").." avg buyout)";
				else
					percentSummary = GFWUtils.Gray("(matches avg buyout)");
				end
				GFWUtils.Print(itemCodes[code].." available for "..GFWUtils.TextGSC(minBuy).." each "..percentSummary..".");
				printedSomething = true;
			end
		end
	end
	if (not printedSomething) then
		GFWUtils.Print("No items from your list are currently available at auction.");
	end

end

function FSL_PercentLessThan(value1, value2)
	value1 = value1 or 0;
	value2 = value2 or 0;
	return 100 - math.floor((100 * value2)/value1);
end
