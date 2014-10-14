--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.9.0.1056 (Kangaroo)
	Revision: $Id: SalesDB.lua 1002 2006-09-25 07:26:04Z vindicator $

	SalesDB - manages the database of AH sales

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--]]

-------------------------------------------------------------------------------
-- Function Imports
-------------------------------------------------------------------------------
local chatPrint = BeanCounter.ChatPrint;
local getPlayerName = BeanCounter.Database.GetPlayerName;
local getCurrentPlayerId = BeanCounter.Database.GetCurrentPlayerId;
local stringFromBoolean = BeanCounter.Database.StringFromBoolean;
local booleanFromString = BeanCounter.Database.BooleanFromString;
local stringFromNumber = BeanCounter.Database.StringFromNumber;
local numberFromString = BeanCounter.Database.NumberFromString;
local nilSafeStringFromString = BeanCounter.Database.NilSafeStringFromString;
local stringFromNilSafeString = BeanCounter.Database.StringFromNilSafeString;

-------------------------------------------------------------------------------
-- Function Prototypes
-------------------------------------------------------------------------------
local addPendingAuction;
local deletePendingAuction;
local packPendingAuction;
local unpackPendingAuction;
local getPendingAuctionsTableForItem;
local getPendingAuctionItems;
local getPendingAuctionsForItem;
local printPendingAuctions;
local printPendingAuction;

local addSuccessfulAuction;
local addExpiredAuction;
local addCanceledAuction;
local addCompletedAuction;
local deleteCompletedAuction;
local packCompletedAuction;
local unpackCompletedAuction;
local getCompletedAuctionsTableForItem;
local getCompletedAuctionsForItem
local printCompletedAuctions;
local printCompletedAuction;

local addSale;
local packSale;
local unpackSale;
local getSalesTableForItem;
local getSoldItems;
local getSalesForItem;
local getLastSaleForItem;
local printSales;
local printSale;

local reconcileAuctions;
local reconcileAuctionsByTime;
local reconcileAuctionsByQuantityOrProceeds;
local reconcileAuctionsByQuantity;
local reconcileAuctionsByProceeds;
local reconcileAuctionList;
local reconcileMatchingAuctions;
local compareMatchCount;
local compareTime;
local doesPendingAuctionMatchCompletedAuction;
local doesPendingAuctionListMatch;
local getPendingAuctionMatchCount;

local debugPrint;

-------------------------------------------------------------------------------
-- Data Members
-------------------------------------------------------------------------------

-- Auction result constants
local AUCTION_SOLD = 0;
local AUCTION_EXPIRED = 1;
local AUCTION_CANCELED = 2;

-- Constants
local AUCTION_OVERRUN_LIMIT = (2 * 60 * 60); -- 2 hours
local AUCTION_DURATION_LIMIT = (24 * 60 * 60) + AUCTION_OVERRUN_LIMIT;

--=============================================================================
-- Pending Auctions functions
--=============================================================================

-------------------------------------------------------------------------------
-- Adds a pending auction to the database
-------------------------------------------------------------------------------
function addPendingAuction(timestamp, item, quantity, bid, buyout, runTime, deposit, consignmentPercent)
	if (item and quantity and bid and buyout) then
		-- Create a packed record.
		local pendingAuction = {};
		pendingAuction.time = timestamp;
		pendingAuction.quantity = quantity;
		pendingAuction.bid = bid;
		pendingAuction.buyout = buyout;
		pendingAuction.runTime = runTime;
		pendingAuction.deposit = deposit;
		pendingAuction.consignmentPercent = consignmentPercent;
		pendingAuction.sellerId = getCurrentPlayerId();
		local packedPendingAuction = packPendingAuction(pendingAuction);

		-- Add to the pending auctions table.
		local pendingAuctionsTable = getPendingAuctionsTableForItem(item, true);
		table.insert(pendingAuctionsTable, packedPendingAuction);

		-- Debugging noise.
		printPendingAuction(debugPrint, "Added pending auction: ", item, pendingAuction);
	else
		debugPrint("Invalid call to addPendingAuction()");
	end
end

-------------------------------------------------------------------------------
-- Deletes a pending auction from the database.
--
-- If pendingAuctions is provided, the pending auction will be removed from it.
-------------------------------------------------------------------------------
function deletePendingAuction(item, index, reason, pendingAuctions)
	-- Update the unpacked pending auction list, if provided
	local pendingAuction = nil;
	if (pendingAuctions) then
		-- Iterate in reverse since we will be removing the pending auction
		-- from the list when we find it.
		for pendingIndex = table.getn(pendingAuctions), 1, -1 do
			local auction = pendingAuctions[pendingIndex];
			if (index == auction.index) then
				pendingAuction = auction;
				table.remove(pendingAuctions, pendingIndex);
			elseif (index < auction.index) then
				auction.index = auction.index - 1;
			end
		end
	end

	-- Grab the pending auctions table for the item.
	local pendingAuctionsTable = getPendingAuctionsTableForItem(item);
	if (pendingAuctionsTable) then
		-- Get the pending auction if we don't already have it.
		if (pendingAuction == nil) then
			pendingAuction = unpackPendingAuction(pendingAuctionsTable[index]);
		end
		
		-- Remove the pending auction from the table.
		table.remove(pendingAuctionsTable, index);
		if (table.getn(pendingAuctionsTable)) then
			getPendingAuctionsTableForItem(item); -- Deletes the table
		end
		
		-- Debug noise.
		printPendingAuction(
			debugPrint,
			"Deleted pending auction ("..nilSafeStringFromString(reason).."): ",
			item,
			pendingAuction);
	end
end

-------------------------------------------------------------------------------
-- Converts a pending auction into a ';' delimited string.
-------------------------------------------------------------------------------
function packPendingAuction(pendingAuction)
	return
		stringFromNumber(pendingAuction.time)..";"..
		stringFromNumber(pendingAuction.quantity)..";"..
		stringFromNumber(pendingAuction.bid)..";"..
		stringFromNumber(pendingAuction.buyout)..";"..
		stringFromNumber(pendingAuction.runTime)..";"..
		stringFromNumber(pendingAuction.deposit)..";"..
		stringFromNumber(pendingAuction.consignmentPercent)..";"..
		stringFromNumber(pendingAuction.sellerId);
end

-------------------------------------------------------------------------------
-- Converts a ';' delimited string into a pending auction.
-------------------------------------------------------------------------------
function unpackPendingAuction(packedPendingAuction)
	local pendingAuction = {};
	_, _, pendingAuction.time, pendingAuction.quantity, pendingAuction.bid, pendingAuction.buyout, pendingAuction.runTime, pendingAuction.deposit, pendingAuction.consignmentPercent, pendingAuction.sellerId = string.find(packedPendingAuction, "(.+);(.+);(.+);(.+);(.+);(.+);(.+);(.+)");
	pendingAuction.time = numberFromString(pendingAuction.time);
	pendingAuction.quantity = numberFromString(pendingAuction.quantity);
	pendingAuction.bid = numberFromString(pendingAuction.bid);
	pendingAuction.buyout = numberFromString(pendingAuction.buyout);
	pendingAuction.runTime = numberFromString(pendingAuction.runTime);
	pendingAuction.deposit = numberFromString(pendingAuction.deposit);
	pendingAuction.consignmentPercent = numberFromString(pendingAuction.consignmentPercent);
	pendingAuction.sellerId = numberFromString(pendingAuction.sellerId);
	return pendingAuction;
end

-------------------------------------------------------------------------------
-- Gets the pending auctions table for the specified item. The table contains
-- packed records.
-------------------------------------------------------------------------------
function getPendingAuctionsTableForItem(item, create)
	local pendingAuctionsTable = BeanCounterRealmDB.pendingAuctions;
	if (pendingAuctionsTable == nil) then
		pendingAuctionsTable = {};
		BeanCounterRealmDB.pendingAuctions = pendingAuctionsTable;
	end

	-- Get the table for the item. Create or delete if appropriate.
	local pendingAuctionsForItemTable = pendingAuctionsTable[item];
	if (pendingAuctionsForItemTable == nil and create) then
		pendingAuctionsForItemTable = {};
		pendingAuctionsTable[item] = pendingAuctionsForItemTable;
	elseif (pendingAuctionsForItemTable and table.getn(pendingAuctionsForItemTable) == 0 and not create) then
		pendingAuctionsTable[item] = nil;
	end

	return pendingAuctionsForItemTable;
end

-------------------------------------------------------------------------------
-- Gets the list of pending auction items.
-------------------------------------------------------------------------------
function getPendingAuctionItems()
	local items = {};
	if (BeanCounterRealmDB.pendingAuctions) then
		for item in BeanCounterRealmDB.pendingAuctions do
			local pendingAuctionsTable = getPendingAuctionsTableForItem(item);
			if (pendingAuctionsTable and table.getn(pendingAuctionsTable) > 0) then
				table.insert(items, item);
			end
		end
	end
	return items;
end

-------------------------------------------------------------------------------
-- Gets the pending auctions (unpacked) for the specified item
-------------------------------------------------------------------------------
function getPendingAuctionsForItem(item, filterFunc)
	local pendingAuctions = {};
	local pendingAuctionsTable = getPendingAuctionsTableForItem(item);
	if (pendingAuctionsTable) then
		for index in pendingAuctionsTable do
			local pendingAuction = unpackPendingAuction(pendingAuctionsTable[index]);
			pendingAuction.index = index;
			if (filterFunc == nil or filterFunc(pendingAuction)) then
				table.insert(pendingAuctions, pendingAuction);
			end
		end
	end
	return pendingAuctions;
end

-------------------------------------------------------------------------------
-- Prints the pending auctions.
-------------------------------------------------------------------------------
function printPendingAuctions()
	chatPrint("Pending Auctions:");
	if (BeanCounterRealmDB.pendingAuctions) then
		for item in BeanCounterRealmDB.pendingAuctions do
			local pendingAuctionsTable = BeanCounterRealmDB.pendingAuctions[item];
			for index = 1, table.getn(pendingAuctionsTable) do
				local pendingAuction = unpackPendingAuction(pendingAuctionsTable[index]);
				printPendingAuction(chatPrint, nil, pendingAuction);
			end
		end
	end
end

-------------------------------------------------------------------------------
-- Calls the specified print function for the pending auction.
-------------------------------------------------------------------------------
function printPendingAuction(printFunc, prefix, item, pendingAuction)
	if (prefix == nil) then
		prefix = "";
	end
	printFunc(
		prefix..
		date("%c", pendingAuction.time)..", "..
		item..", "..
		stringFromNumber(pendingAuction.quantity)..", "..
		stringFromNumber(pendingAuction.bid)..", "..
		stringFromNumber(pendingAuction.buyout)..", "..
		stringFromNumber(pendingAuction.runTime)..", "..
		stringFromNumber(pendingAuction.deposit)..", "..
		stringFromNumber(pendingAuction.consignmentPercent)..", "..
		nilSafeStringFromString(getPlayerName(pendingAuction.sellerId)));
end

--=============================================================================
-- Completed Auctions functions
--=============================================================================

-------------------------------------------------------------------------------
-- Adds a successful auction result to the database.
-------------------------------------------------------------------------------
function addSuccessfulAuction(timestamp, item, proceeds, price, isBuyout, deposit, consignment, buyer)
	addCompletedAuction(timestamp, item, AUCTION_SOLD, nil, proceeds, price, isBuyout, deposit, consignment, buyer);
end

-------------------------------------------------------------------------------
-- Adds an expired auction result to the database.
-------------------------------------------------------------------------------
function addExpiredAuction(timestamp, item, quantity)
	addCompletedAuction(timestamp, item, AUCTION_EXPIRED, quantity);
end

-------------------------------------------------------------------------------
-- Adds a canceled auction result to the database.
-------------------------------------------------------------------------------
function addCanceledAuction(timestamp, item, quantity)
	addCompletedAuction(timestamp, item, AUCTION_CANCELED, quantity);
end

-------------------------------------------------------------------------------
-- Adds a auction completed (success/expired/canceled) to the database.
-------------------------------------------------------------------------------
function addCompletedAuction(timestamp, item, result, quantity, proceeds, price, isBuyout, deposit, consignment, buyer)
	if (item and (quantity or proceeds)) then
		-- Create a packed record.
		local completedAuction = {};
		completedAuction.time = timestamp;
		completedAuction.result = result;
		completedAuction.quantity = quantity;
		completedAuction.proceeds = proceeds;
		completedAuction.price = price;
		completedAuction.isBuyout = isBuyout;
		completedAuction.deposit = deposit;
		completedAuction.consignment = consignment;
		completedAuction.buyer = buyer;
		completedAuction.sellerId = getCurrentPlayerId();
		local packedCompletedAuction = packCompletedAuction(completedAuction);
		
		-- Only add the completed auction to the database if there is a
		-- matching pending auction.
		if (getPendingAuctionMatchCount(item, completedAuction) > 0) then
			-- Add to the completed auctions table.
			local completedAuctionsTable = getCompletedAuctionsTableForItem(item, true);
			table.insert(completedAuctionsTable, packedCompletedAuction);

			-- Debugging noise.
			printCompletedAuction(debugPrint, "Added completed auction: ", item, completedAuction);

			-- Attmept to immediately reconcile this item.
			reconcileAuctionsByQuantityOrProceeds(item, completedAuction.quantity, completedAuction.proceeds);
		else
			printCompletedAuction(debugPrint, "Ignoring completed auction (no match): ", item, completedAuction);
		end
	else
		debugPrint("Invalid call to addCompletedAuction()");
	end
end

-------------------------------------------------------------------------------
-- Deletes a completed auction from the database.
--
-- If completedAuctions is provided, the completed auction will be removed
-- from it.
-------------------------------------------------------------------------------
function deleteCompletedAuction(item, index, reason, completedAuctions)
	-- Update the unpacked completed auction list, if provided
	local completedAuction = nil;
	if (completedAuctions) then
		-- Iterate in reverse since we will be removing the completed auction
		-- from the list when we find it.
		for completedIndex = table.getn(completedAuctions), 1, -1 do
			local auction = completedAuctions[completedIndex];
			if (index == auction.index) then
				completedAuction = auction;
				table.remove(completedAuctions, completedIndex);
			elseif (index < auction.index) then
				auction.index = auction.index - 1;
			end
		end
	end

	-- Grab the completed auctions table for the item.
	local completedAuctionsTable = getCompletedAuctionsTableForItem(item);
	if (completedAuctionsTable) then
		-- Get the completed auction if we don't already have it.
		if (completedAuction == nil) then
			completedAuction = unpackCompletedAuction(completedAuctionsTable[index]);
		end
		
		-- Remove the completed auction from the table.
		table.remove(completedAuctionsTable, index);
		if (table.getn(completedAuctionsTable)) then
			getCompletedAuctionsTableForItem(item); -- Deletes the table
		end

		-- Debug noise.
		printCompletedAuction(
			debugPrint, 
			"Deleted completed auction ("..nilSafeStringFromString(reason).."): ",
			item,
			completedAuction);
	end
end

-------------------------------------------------------------------------------
-- Converts a completed auction into a ';' delimited string.
-------------------------------------------------------------------------------
function packCompletedAuction(completedAuction)
	return
		stringFromNumber(completedAuction.time)..";"..
		stringFromNumber(completedAuction.result)..";"..
		stringFromNumber(completedAuction.quantity)..";"..
		stringFromNumber(completedAuction.proceeds)..";"..
		stringFromNumber(completedAuction.price)..";"..
		stringFromBoolean(completedAuction.isBuyout)..";"..
		stringFromNumber(completedAuction.deposit)..";"..
		stringFromNumber(completedAuction.consignment)..";"..
		nilSafeStringFromString(completedAuction.buyer)..";"..
		stringFromNumber(completedAuction.sellerId);
end

-------------------------------------------------------------------------------
-- Converts a ';' delimited string into a completed auction.
-------------------------------------------------------------------------------
function unpackCompletedAuction(packedCompletedAuction)
	local completedAuction = {};
	_, _, completedAuction.time, completedAuction.result, completedAuction.quantity, completedAuction.proceeds, completedAuction.price, completedAuction.isBuyout, completedAuction.deposit, completedAuction.consignment, completedAuction.buyer, completedAuction.sellerId = string.find(packedCompletedAuction, "(.+);(.+);(.+);(.+);(.+);(.+);(.+);(.+);(.+);(.+)");
	completedAuction.time = numberFromString(completedAuction.time);
	completedAuction.result = numberFromString(completedAuction.result);
	completedAuction.quantity = numberFromString(completedAuction.quantity);
	completedAuction.proceeds = numberFromString(completedAuction.proceeds);
	completedAuction.price = numberFromString(completedAuction.price);
	completedAuction.isBuyout = numberFromString(completedAuction.isBuyout);
	completedAuction.deposit = numberFromString(completedAuction.deposit);
	completedAuction.consignment = numberFromString(completedAuction.consignment);
	completedAuction.buyer = stringFromNilSafeString(completedAuction.buyer);
	completedAuction.sellerId = numberFromString(completedAuction.sellerId);
	return completedAuction;
end

-------------------------------------------------------------------------------
-- Gets the completed auctions table for the specified item. The table contains
-- packed records.
-------------------------------------------------------------------------------
function getCompletedAuctionsTableForItem(item, create)
	local completedAuctionsTable = BeanCounterRealmDB.completedAuctions;
	if (completedAuctionsTable == nil) then
		completedAuctionsTable = {};
		BeanCounterRealmDB.completedAuctions = completedAuctionsTable;
	end

	-- Get the table for the item. Create or delete if appropriate.
	local completedAuctionsForItemTable = completedAuctionsTable[item];
	if (completedAuctionsForItemTable == nil and create) then
		completedAuctionsForItemTable = {};
		completedAuctionsTable[item] = completedAuctionsForItemTable;
	elseif (completedAuctionsForItemTable and table.getn(completedAuctionsForItemTable) == 0 and not create) then
		completedAuctionsTable[item] = nil;
	end

	return completedAuctionsForItemTable;
end

-------------------------------------------------------------------------------
-- Gets the completed auctions (unpacked) for the specified item
-------------------------------------------------------------------------------
function getCompletedAuctionsForItem(item, filterFunc)
	local completedAuctions = {};
	local completedAuctionsTable = getCompletedAuctionsTableForItem(item);
	if (completedAuctionsTable) then
		for index in completedAuctionsTable do
			local completedAuction = unpackCompletedAuction(completedAuctionsTable[index]);
			completedAuction.index = index;
			if (filterFunc == nil or filterFunc(completedAuction)) then
				table.insert(completedAuctions, completedAuction);
			end
		end
	end
	return completedAuctions;
end

-------------------------------------------------------------------------------
-- Prints the completed auctions.
-------------------------------------------------------------------------------
function printCompletedAuctions()
	chatPrint("Completed Auctions:");
	if (BeanCounterRealmDB.completedAuctions) then
		for item in BeanCounterRealmDB.completedAuctions do
			local completedAuctionsTable = BeanCounterRealmDB.completedAuctions[item];
			for index = 1, table.getn(completedAuctionsTable) do
				local completedAuction = unpackCompletedAuction(completedAuctionsTable[index]);
				printCompletedAuction(chatPrint, nil, item, completedAuction);
			end
		end
	end
end

-------------------------------------------------------------------------------
-- Calls the specified print function for the completed auction.
-------------------------------------------------------------------------------
function printCompletedAuction(printFunc, prefix, item, completedAuction)
	if (prefix == nil) then
		prefix = "";
	end
	printFunc(
		prefix..
		date("%c", completedAuction.time)..", "..
		item..", "..
		stringFromNumber(completedAuction.quantity)..", "..
		stringFromNumber(completedAuction.proceeds)..", "..
		stringFromNumber(completedAuction.price)..", "..
		stringFromBoolean(completedAuction.isBuyout)..", "..
		stringFromNumber(completedAuction.deposit)..", "..
		stringFromNumber(completedAuction.consignment)..", "..
		nilSafeStringFromString(completedAuction.buyer)..", "..
		nilSafeStringFromString(getPlayerName(completedAuction.sellerId)));
end

--=============================================================================
-- Sales functions
--=============================================================================

-------------------------------------------------------------------------------
-- Adds a sale to the database.
-------------------------------------------------------------------------------
function addSale(timestamp, result, item, quantity, bid, buyout, net, price, isBuyout, buyer)
	if (item and quantity and net) then
		-- Create a packed record.
		local sale = {};
		sale.time = timestamp;
		sale.result = result;
		sale.quantity = quantity;
		sale.bid = bid;
		sale.buyout = buyout;
		sale.net = net;
		sale.price = price;
		sale.isBuyout = isBuyout;
		sale.buyer = buyer;
		sale.sellerId = getCurrentPlayerId();
		local packedSale = packSale(sale);

		-- Add the sale to the table.
		local salesTable = getSalesTableForItem(item, true);
		table.insert(salesTable, packedSale);

		-- Debugging noise.
		printSale(debugPrint, "Added sale: ", item, sale);
	else
		debugPrint("Invalid call to addSale()");
	end
end

-------------------------------------------------------------------------------
-- Converts a sale into a ';' delimited string.
-------------------------------------------------------------------------------
function packSale(sale)
	return
		sale.time..";"..
		stringFromNumber(sale.result)..";"..
		stringFromNumber(sale.quantity)..";"..
		stringFromNumber(sale.bid)..";"..
		stringFromNumber(sale.buyout)..";"..
		stringFromNumber(sale.net)..";"..
		stringFromNumber(sale.price)..";"..
		stringFromBoolean(sale.isBuyout)..";"..
		nilSafeStringFromString(sale.buyer)..";"..
		stringFromNumber(sale.sellerId);
end

-------------------------------------------------------------------------------
-- Converts a ';' delimited string into a sale.
-------------------------------------------------------------------------------
function unpackSale(packedSale)
	local sale = {};
	_, _, sale.time, sale.result, sale.quantity, sale.bid, sale.buyout, sale.net, sale.price, sale.isBuyout, sale.buyer, sale.sellerId = string.find(packedSale, "(.+);(.+);(.+);(.+);(.+);(.+);(.+);(.+);(.+);(.+)");
	sale.time = numberFromString(sale.time);
	sale.result = numberFromString(sale.result);
	sale.quantity = numberFromString(sale.quantity);
	sale.bid = numberFromString(sale.bid);
	sale.buyout = numberFromString(sale.buyout);
	sale.net = numberFromString(sale.net);
	sale.price = numberFromString(sale.price);
	sale.isBuyout = booleanFromString(sale.isBuyout);
	sale.buyer = stringFromNilSafeString(sale.buyer);
	sale.sellerId = numberFromString(sale.sellerId);
	return sale;
end

-------------------------------------------------------------------------------
-- Gets the sales table for the specified item. The table contains packed
-- records.
-------------------------------------------------------------------------------
function getSalesTableForItem(item, create)
	local salesTable = BeanCounterRealmDB.sales;
	if (salesTable == nil) then
		salesTable = {};
		BeanCounterRealmDB.sales = salesTable;
	end
	
	-- Get the table for the item. Create or delete if appropriate.
	local salesForItemTable = salesTable[item];
	if (salesForItemTable == nil and create) then
		salesForItemTable = {};
		salesTable[item] = salesForItemTable;
	elseif (salesForItemTable and table.getn(salesForItemTable) == 0 and not create) then
		salesTable[item] = nil;
	end

	return salesForItemTable;
end

-------------------------------------------------------------------------------
-- Gets the list of sold items.
-------------------------------------------------------------------------------
function getSoldItems(item)
	local items = {};
	if (BeanCounterRealmDB.sales) then
		for item in BeanCounterRealmDB.sales do
			local salesTable = getSalesTableForItem(item);
			if (salesTable and table.getn(salesTable) > 0) then
				table.insert(items, item);
			end
		end
	end
	return items;
end

-------------------------------------------------------------------------------
-- Gets the sales (unpacked) for the specified item
-------------------------------------------------------------------------------
function getSalesForItem(item)
	local sales = {};
	local salesTable = getSalesTableForItem(item);
	if (salesTable) then
		for index in salesTable do
			local sale = unpackSale(salesTable[index]);
			table.insert(sales, sale);
		end
	end
	return sales;
end

-------------------------------------------------------------------------------
-- Gets the most recent salle (unpacked) for the specified item. Returns nil
-- if none.
-------------------------------------------------------------------------------
function getLastSaleForItem(item)
	local lastSale = nil;
	local salesTable = getSalesTableForItem(item);
	if (salesTable) then
		for index in salesTable do
			local sale = unpackSale(salesTable[index]);
			if (sale.result == AUCTION_SOLD and (lastSale == nil or lastSale.time < sale.time)) then
				lastSale = sale;
			end
		end
	end
	return lastSale;
end

-------------------------------------------------------------------------------
-- Prints the sales.
-------------------------------------------------------------------------------
function printSales()
	chatPrint("Sales:");
	if (BeanCounterRealmDB.sales) then
		for item in BeanCounterRealmDB.sales do
			local salesTable = BeanCounterRealmDB.sales[item];
			for index = 1, table.getn(salesTable) do
				local sale = unpackSale(salesTable[index]);
				printSale(chatPrint, nil, item, sale);
			end
		end
	end
end

-------------------------------------------------------------------------------
-- Calls the specified print function for the sale.
-------------------------------------------------------------------------------
function printSale(printFunc, prefix, item, sale)
	if (prefix == nil) then
		prefix = "";
	end
	printFunc(
		prefix..
		date("%c", sale.time)..", "..
		stringFromNumber(sale.result)..", "..
		item..", "..
		stringFromNumber(sale.quantity)..", "..
		stringFromNumber(sale.bid)..", "..
		stringFromNumber(sale.buyout)..", "..
		stringFromNumber(sale.net)..", "..
		stringFromNumber(sale.price)..", "..
		stringFromBoolean(sale.isBuyout)..", "..
		nilSafeStringFromString(sale.buyer)..", "..
		nilSafeStringFromString(getPlayerName(sale.sellerId)));
end

--=============================================================================
-- Auction reconcilation functions
--=============================================================================

-------------------------------------------------------------------------------
-- Reconcile all auctions that should be completed by the specified time.
-------------------------------------------------------------------------------
function reconcileAuctions(reconcileTime, excludeItems)
	local totalReconciled = 0;
	local totalDiscarded = 0;
	local items = getPendingAuctionItems();
	for index in items do
		local item = items[index];
		if (excludeItems == nil or excludeItems[item] == nil) then
			local reconciled, discarded = reconcileAuctionsByTime(item, reconcileTime);
			totalReconciled = totalReconciled + reconciled;
			totalDiscarded = totalDiscarded + discarded;
		end
	end
	return totalReconciled, totalDiscarded;
end

-------------------------------------------------------------------------------
-- Reconcile auctions for the item that should be completed by the specified
-- time.
-------------------------------------------------------------------------------
function reconcileAuctionsByTime(item, reconcileTime)
	debugPrint("reconcileBidsByTime("..item..", "..date("%c", reconcileTime)..")");

	-- Get the list of pending auctions that should have completed before the
	-- specified time.
	local pendingAuctions = getPendingAuctionsForItem(
		item, 
		function(pendingAuction)
			return (pendingAuction.sellerId == getCurrentPlayerId() and
					pendingAuction.time + (pendingAuction.runTime * 60) + AUCTION_OVERRUN_LIMIT < reconcileTime);
		end);
	debugPrint(table.getn(pendingAuctions).." matching pending auctions");

	-- Get the list of completed auctions that completed before the specified
	-- time.
	local completedAuctions = getCompletedAuctionsForItem(
		item,
		function(completedAuction)
			return (completedAuction.sellerId == getCurrentPlayerId() and
					completedAuction.time < reconcileTime);
		end);
	debugPrint(table.getn(completedAuctions).." matching completed auctions");

	-- Reconcile the lists.
	local reconciledAuctions = reconcileAuctionList(item, pendingAuctions, completedAuctions, true);

	-- Cleanup the unmatch pending auctions that are too old to match any
	-- completed auctions.
	local discardedPendingAuctions = 0;
	for index = table.getn(pendingAuctions), 1, -1 do
		local pendingAuction = pendingAuctions[index];
		deletePendingAuction(item, pendingAuction.index, "no match", pendingAuctions);
		discardedPendingAuctions = discardedPendingAuctions + 1;
	end

	-- Cleanup the unmatched completed auctions that are too old to match any
	-- pending auctions.
	local discardedCompletedAuctions = 0;
	for index = table.getn(completedAuctions), 1, -1 do
		local completedAuction = completedAuctions[index];
		if (completedAuction.time + AUCTION_DURATION_LIMIT < reconcileTime) then
			deleteCompletedAuction(item, completedAuction.index, "no match", completedAuctions);
			discardedCompletedAuctions = discardedCompletedAuctions + 1;
		end
	end
			
	return reconciledAuctions, discardedPendingAuctions, discardedCompletedAuctions;
end

-------------------------------------------------------------------------------
-- Attempts to reconcile auctions by either time or proceeds.
-------------------------------------------------------------------------------
function reconcileAuctionsByQuantityOrProceeds(item, quantityHint, proceedsHint)
	-- If a hint is supplied, try them first. If no hints are supplied or the
	-- hints cause auctions to be reconciled, then widen the reconcilation
	-- hunt.
	if ((proceedsHint == nil and quantityHint == nil) or
		(proceedsHint ~= nil and reconcileAuctionsByProceeds(item, proceedsHint) > 0) or
		(quantityHint ~= nil and reconcileAuctionsByQuantity(item, quantityHint) > 0)) then
		local index = 1;
		local quantitiesAttempted = {};
		local proceedsAttempted = {};
		local completedAuctions = getCompletedAuctionsTableForItem(item);
		if (completedAuctions) then
			while (index <= table.getn(completedAuctions)) do
				local completedAuction = unpackCompletedAuction(completedAuctions[index]);
				if (completedAuction.quantity and not quantitiesAttempted[completedAuction.quantity]) then
					quantitiesAttempted[completedAuction.quantity] = true;
					if (reconcileAuctionsByQuantity(item, completedAuction.quantity) > 0) then
						index = 1;
						proceedsAttempted = {};
					else
						index = index + 1;
					end
				elseif (completedAuction.proceeds and not proceedsAttempted[completedAuction.proceeds]) then
					proceedsAttempted[completedAuction.proceeds] = true;
					if (reconcileAuctionsByProceeds(item, completedAuction.proceeds) > 0) then
						index = 1;
						quantitiesAttempted = {};
						proceedsAttempted = {};
					else
						index = index + 1;
					end
				else
					index = index + 1;
				end
			end
		end
	end
end

-------------------------------------------------------------------------------
-- Attempts to reconcile auctions by quantity
-------------------------------------------------------------------------------
function reconcileAuctionsByQuantity(item, quantity)
	debugPrint("reconcileAuctionsByQuantity("..item..", "..quantity..")");

	-- Get all the pending auctions match the quantity.
	local pendingAuctions = getPendingAuctionsForItem(
		item, 
		function(pendingAuction)
			return (pendingAuction.sellerId == getCurrentPlayerId() and
					pendingAuction.quantity == quantity);
		end);
	debugPrint(table.getn(pendingAuctions).." matching pending auctions");

	-- Get all the completed auctions matching the quantity.
	local completedAuctions = getCompletedAuctionsForItem(
		item,
		function(completedAuction)
			return (completedAuction.sellerId == getCurrentPlayerId() and
					completedAuction.quantity == quantity);
		end);
	debugPrint(table.getn(completedAuctions).." matching completed auctions");

	-- Attempt to reconcile the lists.
	if (table.getn(pendingAuctions) == table.getn(completedAuctions)) then
		return reconcileAuctionList(item, pendingAuctions, completedAuctions, false);
	elseif (doesPendingAuctionListMatch(pendingAuctions)) then
		return reconcileAuctionList(item, pendingAuctions, completedAuctions, false);
	else
		debugPrint("Cannot reconcile by quantity");
	end

	return 0;
end

-------------------------------------------------------------------------------
-- Attempts to reconcile auctions by proceeds
-------------------------------------------------------------------------------
function reconcileAuctionsByProceeds(item, proceeds)
	debugPrint("reconcileAuctionsByProceeds("..item..", "..proceeds..")");

	-- Get all the pending auctions match the proceeds.
	local pendingAuctions = getPendingAuctionsForItem(
		item, 
		function(pendingAuction)
			local minProceeds = math.floor(pendingAuction.bid * (1 - pendingAuction.consignmentPercent)) + pendingAuction.deposit;
			local maxProceeds = math.floor(pendingAuction.buyout * (1 - pendingAuction.consignmentPercent)) + pendingAuction.deposit;
			return (pendingAuction.sellerId == getCurrentPlayerId() and
					minProceeds <= proceeds and proceeds <= maxProceeds);
		end);
	debugPrint(table.getn(pendingAuctions).." matching pending auctions");

	-- Get all the completed auctions matching the quantity.
	local completedAuctions = getCompletedAuctionsForItem(
		item,
		function(completedAuction)
			return (completedAuction.sellerId == getCurrentPlayerId() and
					completedAuction.proceeds == proceeds);
		end);
	debugPrint(table.getn(completedAuctions).." matching completed auctions");

	-- Attempt to reconcile the lists.
	if (table.getn(pendingAuctions) == table.getn(completedAuctions)) then
		return reconcileAuctionList(item, pendingAuctions, completedAuctions, false);
	elseif (doesPendingAuctionListMatch(pendingAuctions)) then
		return reconcileAuctionList(item, pendingAuctions, completedAuctions, false);
	else
		debugPrint("Cannot reconcile by proceeds");
	end

	return 0;
end

-------------------------------------------------------------------------------
-- Takes lists of pending and completed items and attempts to reconcile them.
-- A sale is added for each pending and completed auction match. If
-- discrepencies are not allowed and there are discrepencies, then no auctions
-- are reconciled.
-------------------------------------------------------------------------------
function reconcileAuctionList(item, pendingAuctions, completedAuctions, discrepenciesAllowed)
	-- If we have some auctions, reconcile them!
	local auctionsReconciled = 0;
	if (table.getn(pendingAuctions) > 0 or table.getn(completedAuctions) > 0) then
		-- For each pending auction, get the list of potential completed auctions.
		-- Afterwards, sort the pending auction list by match count.
		for pendingIndex = 1, table.getn(pendingAuctions) do
			local pendingAuction = pendingAuctions[pendingIndex];
			pendingAuction.matches = {};
			for completedIndex = 1, table.getn(completedAuctions) do
				local completedAuction = completedAuctions[completedIndex];
				if (doesPendingAuctionMatchCompletedAuction(pendingAuction, completedAuction)) then
					table.insert(pendingAuction.matches, completedAuction);
				end
			end
			table.sort(pendingAuction.matches, compareTime);
		end
		table.sort(pendingAuctions, compareMatchCount);

		-- For each pending auction, pick a suitable completed auction match.
		-- This algorithm could be much better, but it works for most sane
		-- cases.
		for pendingIndex = 1, table.getn(pendingAuctions) do
			local pendingAuction = pendingAuctions[pendingIndex];

			-- First check if this auction likely expired. We consider it likely
			-- if a matching auction expired within 1 minute of the run length.
			for completedIndex = 1, table.getn(pendingAuction.matches) do
				local completedAuction = pendingAuction.matches[completedIndex];
				if (completedAuction.match == nil and completedAuction.result == AUCTION_EXPIRED) then
					local expectedExpiredTime = pendingAuction.time + (pendingAuction.runTime * 60);
					if (expectedExpiredTime < completedAuction.time and completedAuction.time < expectedExpiredTime + 60) then
						completedAuction.match = pendingAuction;
						pendingAuction.match = completedAuction;
						break;
					end
				end
			end

			-- If we didn't find a likely expired auction, then choose the
			-- oldest unmatched auction.
			if (pendingAuction.match == nil) then
				for completedIndex = 1, table.getn(pendingAuction.matches) do
					local completedAuction = pendingAuction.matches[completedIndex];
					if (completedAuction.match == nil) then
						completedAuction.match = pendingAuction;
						pendingAuction.match = completedAuction;
						break;
					end
				end
			end
		end

		-- Check for unmatched pending auctions.
		local unmatchedPendingAuctionCount = 0;
		for pendingIndex = 1, table.getn(pendingAuctions) do
			local pendingAuction = pendingAuctions[pendingIndex];
			if (pendingAuction.match == nil) then
				unmatchedPendingAuctionCount = unmatchedPendingAuctionCount + 1;
			end
		end

		-- Check for unmatched completed auctions.
		local unmatchedCompletedAuctionCount = 0;
		for completedIndex = 1, table.getn(completedAuctions) do
			local completedAuction = completedAuctions[completedIndex];
			if (completedAuction.match == nil) then
				unmatchedCompletedAuctionCount = unmatchedCompletedAuctionCount + 1;
			end
		end

		-- Reconcile the lists if all auctions match or discrepencies are
		-- allowed!
		if (discrepencesAllowed or unmatchedPendingAuctionCount == 0 or unmatchedCompletedAuctionCount == 0) then
			-- Time to log some sales! We iterate through the pending
			-- list in reverse since we will be deleting items from
			-- it.
			debugPrint("Begin reconciling auction list for "..item);
			for pendingIndex = table.getn(pendingAuctions), 1, -1 do
				local pendingAuction = pendingAuctions[pendingIndex];
				if (pendingAuction.match ~= nil) then
					-- Reconcile the matching auctions.
					reconcileMatchingAuctions(item, pendingAuctions, pendingAuction, completedAuctions, pendingAuction.match);
					auctionsReconciled = auctionsReconciled + 1;
				end
			end
			debugPrint("End reconciling auction list for "..item.." ("..auctionsReconciled.." reconciled)");
		else
			debugPrint("Not reconciling auctions for "..item.." due to discrepencies");
		end
	else
		debugPrint("No reconcilable auctions for "..item);
	end

	return auctionsReconciled;
end

-------------------------------------------------------------------------------
-- Performs auction reconcilation by removing the pending and complete auctions
-- and adding a sale.
--
-- WARNING: The pendingAuction and completedAuction will be removed from
-- their lists.
-------------------------------------------------------------------------------
function reconcileMatchingAuctions(item, pendingAuctions, pendingAuction, completedAuctions, completedAuction)
	-- Remove the pending and completed auctions
	deletePendingAuction(item, pendingAuction.index, "reconciled", pendingAuctions);
	deleteCompletedAuction(item, completedAuction.index, "reconciled", completedAuctions);

	-- Add a sale (success or failure).
	local net;
	local price;
	if (completedAuction.price) then
		net = math.floor(completedAuction.price * (1 - pendingAuction.consignmentPercent));
	else
		net = -pendingAuction.deposit;
	end
	addSale(completedAuction.time, completedAuction.result, item, pendingAuction.quantity, pendingAuction.bid, pendingAuction.buyout, net, completedAuction.price, completedAuction.isBuyout, completedAuction.buyer);
end

-------------------------------------------------------------------------------
-- Compare two auctions based on match count.
-------------------------------------------------------------------------------
function compareMatchCount(auction1, auction2)
	local count1 = table.getn(auction1.matches);
	local count2 = table.getn(auction2.matches);
	if (count1 == count2) then
		return (auction1.time > auction2.time);
	end
	return (count1 > count2);
end

-------------------------------------------------------------------------------
-- Compares two auctions based on time.
-------------------------------------------------------------------------------
function compareTime(auction1, auction2)
	return (auction1.time > auction2.time);
end

-------------------------------------------------------------------------------
-- Checks if the completed auction could be the pending auction.
-------------------------------------------------------------------------------
function doesPendingAuctionMatchCompletedAuction(pendingAuction, completedAuction)
	-- Fudge time that we add to the duration of auctions. This accounts for
	-- mail delivery lag and additional auction duration due to bidding.
	local AUCTION_DURATION_CUSHION = (12 * 60 * 60); -- 12 hours

	-- Check if seller ids match.
	if (pendingAuction.sellerId ~= nil and 
		completedAuction.sellerId ~= nil and
		completedAuction.sellerId ~= pendingAuction.sellerId) then
		return false;
	end

	-- Check if auction completed in a time frame that makes sense for the
	-- the post time.
	if (pendingAuction.time > completedAuction.time or 
		pendingAuction.time + (pendingAuction.runTime * 60) + AUCTION_DURATION_CUSHION < completedAuction.time) then
		return false;
	end
	
--	-- If the auction did not sell via buyout, check if the completion time
--	-- comes after the run time.
--	if ((completedAuction.result == AUCTION_SOLD) and
--		(completedAuction.isBuyout ~= nil and
--		(not completedAuction.isBuyout) and
--		(pendingAuction.time + (pendingAuction.runTime * 60) > completedAuction.time) then
--		return false;
--	end
	
--	-- If the auction expired, check if the completion time comes after the
--	-- run time.
--	if ((completedAuction.result == AUCTION_EXPIRED) and
--		(pendingAuction.time + (pendingAuction.runTime * 60) > completedAuction.time)) then
--		return false;
--	end
	
	-- Check if the quantities match.
	if (pendingAuction.quantity ~= nil and 
		completedAuction.quantity ~= nil and
		completedAuction.quantity ~= pendingAuction.quantity) then
		return false;
	end
	
	-- Check if the deposits match.
	if (pendingAuction.deposit ~= nil and 
		completedAuction.deposit ~= nil and
		completedAuction.deposit ~= pendingAuction.deposit) then
		return false;
	end
	
	-- Check if the price is outside the bid and buyout range.
	if ((completedAuction.result == AUCTION_SOLD) and
		(completedAuction.price ~= nil) and
		(pendingAuction.bid ~= nil) and
		(pendingAuction.buyout ~= nil) and
		(completedAuction.price < pendingAuction.bid or pendingAuction.buyout < completedAuction.price)) then
		return false;
	end

	-- If its a buyout, check if the sale price does not match the buyout price.	
	if ((completedAuction.result == AUCTION_SOLD) and
		(completedAuction.isBuyout ~= nil) and
		(completedAuction.isBuyout) and
		(completedAuction.price ~= nil) and
		(pendingAuction.buyout ~= nil) and
		(pendingAuction.buyout ~= completedAuction.price)) then
		return false;
	end

	-- If its a not buyout, check if the sale price matches the buyout price.	
	if ((completedAuction.result == AUCTION_SOLD) and
		(completedAuction.isBuyout ~= nil) and
		(not completedAuction.isBuyout) and
		(completedAuction.price ~= nil) and
		(pendingAuction.buyout ~= nil) and
		(pendingAuction.buyout == completedAuction.price)) then
		return false;
	end

	-- If we made it this far, its a possible match!
	return true;
end

-------------------------------------------------------------------------------
-- Checks if all pending auctions in the list match each other. All pending
-- auctions must have been started within a 5 minute period of time to be
-- considered matches.
-------------------------------------------------------------------------------
function doesPendingAuctionListMatch(pendingAuctions)
	local match = (table.getn(pendingAuctions) > 0);
	if (match) then
		local pendingAuction = pendingAuctions[1];
		local firstAuctionTime = pendingAuction.time;
		local lastAuctionTime = pendingAuction.time;
		local quantity = pendingAuction.quantity;
		local bid = pendingAuction.bid;
		local buyout = pendingAuction.buyout;
		local deposit = pendingAuction.deposit;
		local sellerId = pendingAuction.sellerId;
		for index = 2, table.getn(pendingAuctions) do
			local pendingAuction = pendingAuctions[index];
			if (quantity ~= pendingAuction.quantity or
				bid ~= pendingAuction.bid or
				buyout ~= pendingAuction.buyout or
				deposit ~= pendingAuction.deposit or
				sellerId ~= pendingAuction.sellerId) then
				match = false;
				break;
			elseif (pendingAuction.time < firstAuctionTime) then
				firstAuctionTime = pendingAuction.time;
			elseif (pendingAuction.time > lastAuctionTime) then
				lastAuctionTime = pendingAuction.time;
			end
		end
		if (match) then
			local auctionTimeSpread = lastAuctionTime - firstAuctionTime;
			match = (auctionTimeSpread < (5 * 60));
		end
	end
	return match;	
end

-------------------------------------------------------------------------------
-- Gets the number of pending auctions that match the completed auction.
-------------------------------------------------------------------------------
function getPendingAuctionMatchCount(item, completedAuction)
	local pendingAuctions = getPendingAuctionsForItem(
		item, 
		function(pendingAuction)
			return doesPendingAuctionMatchCompletedAuction(pendingAuction, completedAuction);
		end);
	return table.getn(pendingAuctions);
end

--=============================================================================
-- Utility functions
--=============================================================================

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function debugPrint(message)
	BeanCounter.DebugPrint("[BeanCounter.SalesDB] "..message);
end

--[[
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function testme1()
	resetDatabase();
	local MINUTE = 60;
	local HOUR = MINUTE * 60;
	local DAY = HOUR * 24;

	addPendingAuction(2, "Silver Bar", 1, 1500, 2000, 1440, 110, 0.05);
	addPendingAuction(4, "Silver Bar", 1, 2000, 2000, 1440, 110, 0.05);
	addPendingAuction(6, "Silver Bar", 2, 3500, 4000, 1440, 220, 0.05);
	addPendingAuction(8, "Silver Bar", 2, 4000, 4500, 1440, 220, 0.05);
	addPendingAuction(10, "Silver Bar", 1, 3500, 4000, 1440, 110, 0.05);
	printPendingAuctions();
	printCompletedAuctions();
	printSales();

	addExpiredAuction(DAY + 40, "Silver Bar", 1);
	addSuccessfulAuction(HOUR * 4, "Silver Bar", 2010, 2000, true, 110, 100, "Sucker");
	addSuccessfulAuction(HOUR * 3, "Silver Bar", 2010, 2000, true, 110, 100, "Sucker");
	addSuccessfulAuction(HOUR * 4, "Silver Bar", 4020, 4000, true, 220, 200, "Sucker");
	addSuccessfulAuction(HOUR * 5, "Silver Bar", 4495, 4500, true, 220, 225, "Sucker");
	reconcileAuctionsForItem("Silver Bar", DAY * 2);
	printPendingAuctions();
	printCompletedAuctions();
	printSales();
end
--]]

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
BeanCounter.Sales = 
{
	AddPendingAuction = addPendingAuction;
	GetPendingAuctionItems = getPendingAuctionItems;
	GetPendingAuctionsForItem = getPendingAuctionsForItem;
	AddSuccessfulAuction = addSuccessfulAuction;
	AddExpiredAuction = addExpiredAuction;
	AddCanceledAuction = addCanceledAuction;
	GetSoldItems = getSoldItems;
	GetSalesForItem = getSalesForItem;
	GetLastSaleForItem = getLastSaleForItem;
	ReconcileAuctions = reconcileAuctions;
	PrintPendingAuctions = printPendingAuctions;
	PrintCompletedAuctions = printCompletedAuctions;
	PrintSales = printSales;
	ResetDatabase = resetDatabase;
};

