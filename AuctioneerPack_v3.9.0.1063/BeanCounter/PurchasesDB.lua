--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.9.0.1056 (Kangaroo)
	Revision: $Id: PurchasesDB.lua 1054 2006-10-09 03:49:05Z vindicator $

	PurchasesDB - manages the database of AH purchases

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
local addPendingBid;
local deletePendingBidBySignature;
local deletePendingBidByIndex;
local packPendingBid;
local unpackPendingBid;
local getPendingBidsTableForItem;
local getPendingBidItems;
local getPendingBidsForItem;
local isPendingBid;
local printPendingBids;
local printPendingBid;

local addSuccessfulBid;
local addFailedBid;
local addCompletedBid;
local deleteCompletedBidByIndex;
local packCompletedBid;
local unpackCompletedBid;
local getCompletedBidsTableForItem;
local getCompletedBidsForItem;
local printCompletedBids;
local printCompletedBid;

local addPurchase;
local packPurchase;
local unpackPurchase;
local getPurchasesTableForItem;
local getPurchasedItems;
local getPurchasesForItem;
local printPurchases;
local printPurchase;

local reconcileBids;
local reconcileBidsByTime;
local reconcileBidsByQuantityOrBids;
local reconcileBidsByQuantity;
local reconcileBidsByBid;
local reconcileBidList;
local reconcileMatchingBids;
local doesPendingBidListMatch;
local doesPendingBidMatchCompletedBid;
local compareMatchCount;
local compareTime;

local getBidNonNilFieldCount;
local compareBidsByNonNilFieldCount;
local debugPrint;

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------
local NIL_VALUE = "<nil>";
local AUCTION_OVERRUN_LIMIT = (2 * 60 * 60); -- 2 hours
local AUCTION_DURATION_LIMIT = (24 * 60 * 60) + AUCTION_OVERRUN_LIMIT;
local MAXIMUM_TIME_LEFT =
{
	[1] = 60 * 30,		-- Short
	[2] = 60 * 60 * 2,	-- Medium
	[3] = 60 * 60 * 8,	-- Long
	[4] = 60 * 60 * 24,	-- Very Long
};
local MINIMUM_TIME_LEFT =
{
	[1] = 0,			-- Short
	[2] = 60 * 30,		-- Medium
	[3] = 60 * 60 * 2,	-- Long
	[4] = 60 * 60 * 8,	-- Very Long
};

--=============================================================================
-- Pending Bids functions
--=============================================================================

-------------------------------------------------------------------------------
-- Adds a pending bid to the database
-------------------------------------------------------------------------------
function addPendingBid(timestamp, item, quantity, bid, seller, isBuyout, timeLeft)
	if (item and quantity and bid and seller and timeLeft) then
		-- Create a packed record.
		local pendingBid = {};
		pendingBid.time = timestamp;
		pendingBid.quantity = quantity;
		pendingBid.bid = bid;
		pendingBid.seller = seller;
		pendingBid.isBuyout = isBuyout;
		pendingBid.timeLeft = timeLeft;
		pendingBid.buyerId = getCurrentPlayerId();
		local packedPendingBid = packPendingBid(pendingBid);

		-- Add the pending bid to the table.
		local pendingBidsTable = getPendingBidsTableForItem(item, true);
		table.insert(pendingBidsTable, packedPendingBid);

		-- Debugging noise.
		printPendingBid(debugPrint, "Added pending bid: ", item, pendingBid);
	else
		debugPrint("Invalid call to addPendingBid()");
	end
end

-------------------------------------------------------------------------------
-- Deletes a pending bid from the database
-------------------------------------------------------------------------------
function deletePendingBidBySignature(item, quantity, bid, seller, isBuyout, timeLeft)
	if (item and quantity and bid and seller) then
		local pendingBidsTable = getPendingBidsTableForItem(item, true);
		for index = 1, table.getn(pendingBidsTable) do
			local pendingBid = unpackPendingBid(pendingBidsTable[index]);
			if (pendingBid.quantity == quantity and
				pendingBid.bid == bid and
				pendingBid.seller == seller and
				pendingBid.isBuyout == isBuyout) then
				-- Found it! Delete the pending bid
				table.remove(pendingBidsTable, index);
				printPendingBid(debugPrint, "Deleted pending bid (request): ", item, pendingBid);
				-- Remove the item's table if empty. This happens automatically
				-- when getting it via the built-in method.
				getPendingBidsTableForItem(item);
				return true;
			end
		end
	end
	debugPrint("No pending bid found to delete: "..item..", "..quantity..", "..bid..", "..nilSafeStringFromString(seller)..", "..stringFromBoolean(isBuyout));
	return false;
end

-------------------------------------------------------------------------------
-- Deletes a pending bid from the database.
--
-- If pendingBids is provided, the pending bid will be removed from it.
-------------------------------------------------------------------------------
function deletePendingBidByIndex(item, index, reason, pendingBids)
	-- Update the unpacked pending bid list, if provided
	local pendingBid = nil;
	if (pendingBids) then
		-- Iterate in reverse since we will be removing the pending bid
		-- from the list when we find it.
		for pendingIndex = table.getn(pendingBids), 1, -1 do
			local bid = pendingBids[pendingIndex];
			if (index == bid.index) then
				pendingBid = bid;
				table.remove(pendingBids, pendingIndex);
			elseif (index < bid.index) then
				bid.index = bid.index - 1;
			end
		end
	end

	-- Grab the pending bids table for the item.
	local pendingBidsTable = getPendingBidsTableForItem(item);
	if (pendingBidsTable) then
		-- Get the pending bid if we don't already have it.
		if (pendingBid == nil) then
			pendingBid = unpackPendingBid(pendingBidsTable[index]);
		end
		
		-- Remove the pending bid from the table.
		table.remove(pendingBidsTable, index);
		if (table.getn(pendingBidsTable)) then
			getPendingBidsTableForItem(item); -- Deletes the table
		end
		
		-- Debug noise.
		printPendingBid(
			debugPrint,
			"Deleted pending bid ("..nilSafeStringFromString(reason).."): ",
			item,
			pendingBid);
	end
end

-------------------------------------------------------------------------------
-- Converts a pending bid into a ';' delimited string.
-------------------------------------------------------------------------------
function packPendingBid(pendingBid)
	return
		pendingBid.time..";"..
		stringFromNumber(pendingBid.quantity)..";"..
		stringFromNumber(pendingBid.bid)..";"..
		nilSafeStringFromString(pendingBid.seller)..";"..
		stringFromBoolean(pendingBid.isBuyout)..";"..
		stringFromNumber(pendingBid.timeLeft)..";"..
		stringFromNumber(pendingBid.buyerId);
end

-------------------------------------------------------------------------------
-- Converts a ';' delimited string into a pending bid.
-------------------------------------------------------------------------------
function unpackPendingBid(packedPendingBid)
	local pendingBid = {};
	_, _, pendingBid.time, pendingBid.quantity, pendingBid.bid, pendingBid.seller, pendingBid.isBuyout, pendingBid.timeLeft, pendingBid.buyerId = string.find(packedPendingBid, "(.+);(.+);(.+);(.+);(.+);(.+);(.+)");
	pendingBid.time = numberFromString(pendingBid.time);
	pendingBid.quantity = numberFromString(pendingBid.quantity);
	pendingBid.bid = numberFromString(pendingBid.bid);
	pendingBid.seller = stringFromNilSafeString(pendingBid.seller);
	pendingBid.isBuyout = booleanFromString(pendingBid.isBuyout);
	pendingBid.timeLeft = numberFromString(pendingBid.timeLeft);
	pendingBid.buyerId = numberFromString(pendingBid.buyerId);
	return pendingBid;
end

-------------------------------------------------------------------------------
-- Gets the pending bids table for the specified item. The table contains
-- packed records.
-------------------------------------------------------------------------------
function getPendingBidsTableForItem(item, create)
	local pendingBidsTable = BeanCounterRealmDB.pendingBids;
	if (pendingBidsTable == nil) then
		pendingBidsTable = {};
		BeanCounterRealmDB.pendingBids = pendingBidsTable;
	end

	-- Get the table for the item. Create or delete if appropriate.
	local pendingBidsForItemTable = pendingBidsTable[item];
	if (pendingBidsForItemTable == nil and create) then
		pendingBidsForItemTable = {};
		pendingBidsTable[item] = pendingBidsForItemTable;
	elseif (pendingBidsForItemTable and table.getn(pendingBidsForItemTable) == 0 and not create) then
		pendingBidsTable[item] = nil;
	end

	return pendingBidsForItemTable;
end

-------------------------------------------------------------------------------
-- Gets the list of pending bid items.
-------------------------------------------------------------------------------
function getPendingBidItems(item)
	local items = {};
	if (BeanCounterRealmDB.pendingBids) then
		for item in BeanCounterRealmDB.pendingBids do
			local pendingBidsTable = getPendingBidsTableForItem(item);
			if (pendingBidsTable and table.getn(pendingBidsTable) > 0) then
				table.insert(items, item);
			end
		end
	end
	return items;
end

-------------------------------------------------------------------------------
-- Gets the pending bids (unpacked) for the specified item
-------------------------------------------------------------------------------
function getPendingBidsForItem(item, filterFunc)
	local pendingBids = {};
	local pendingBidsTable = getPendingBidsTableForItem(item);
	if (pendingBidsTable) then
		for index in pendingBidsTable do
			local pendingBid = unpackPendingBid(pendingBidsTable[index]);
			pendingBid.index = index;
			if (filterFunc == nil or filterFunc(pendingBid)) then
				table.insert(pendingBids, pendingBid);
			end
		end
	end
	return pendingBids;
end

-------------------------------------------------------------------------------
-- Prints the pending bids.
-------------------------------------------------------------------------------
function printPendingBids()
	chatPrint("Pending Bids:");
	if (BeanCounterRealmDB.pendingBids) then
		for item in BeanCounterRealmDB.pendingBids do
			local pendingBidsTable = BeanCounterRealmDB.pendingBids[item];
			for index = 1, table.getn(pendingBidsTable) do
				local pendingBid = unpackPendingBid(pendingBidsTable[index]);
				printPendingBid(chatPrint, nil, item, pendingBid);
			end
		end
	end
end

-------------------------------------------------------------------------------
-- Calls the specified print function for the pending bid.
-------------------------------------------------------------------------------
function printPendingBid(printFunc, prefix, item, pendingBid)
	if (prefix == nil) then
		prefix = "";
	end
	printFunc(
		prefix..
		date("%c", pendingBid.time)..", "..
		item..", "..
		pendingBid.quantity..", "..
		pendingBid.bid..", "..
		nilSafeStringFromString(pendingBid.seller)..", "..
		stringFromNumber(pendingBid.timeLeft)..", "..
		stringFromBoolean(pendingBid.isBuyout)..", "..
		nilSafeStringFromString(getPlayerName(pendingBid.buyerId)));
end

-------------------------------------------------------------------------------
-- Checks if there is a potential pending bid.
-------------------------------------------------------------------------------
function isPendingBid(item, quantity, bid, seller, isBuyout, isSuccessful)
	local pendingBids = getPendingBidsTableForItem(item);
	if (pendingBids) then
		for index = 1, table.getn(pendingBids) do
			local pendingBid = unpackPendingBid(pendingBids[index]);
			if ((quantity == nil or pendingBid.quantity == nil or quantity == pendingBid.quantity) and
				(bid == nil or pendingBid.bid == nil or bid == pendingBid.bid) and
				(seller == nil or pendingBid.seller == nil or seller == pendingBid.seller) and
				(isBuyout == nil or pendingBid.isBuyout == nil or isBuyout == pendingBid.isBuyout) and
				(isSuccessful == nil or pendingBid.isSuccessful == nil or isSuccessful == pendingBid.isSuccessful)) then
				return true;
			end
		end
	end
	return false;
end

--=============================================================================
-- Completed Bids functions
--=============================================================================

-------------------------------------------------------------------------------
-- Adds a successful bid to the database
-------------------------------------------------------------------------------
function addSuccessfulBid(timestamp, item, quantity, bid, seller, isBuyout)
	addCompletedBid(timestamp, item, quantity, bid, seller, isBuyout, true);
end

-------------------------------------------------------------------------------
-- Adds a successful bid to the database
-------------------------------------------------------------------------------
function addFailedBid(timestamp, item, bid)
	addCompletedBid(timestamp, item, nil, bid, nil, nil, false);
end

-------------------------------------------------------------------------------
-- Adds a completed bid to the database
-------------------------------------------------------------------------------
function addCompletedBid(timestamp, item, quantity, bid, seller, isBuyout, isSuccessful)
	if (item and (quantity or bid)) then
		-- Check if we have enough information to add the purchase now.
		local isPurchaseRecorded = false;
		if (quantity and bid and seller and isBuyout ~= nil and isSuccessful) then
			addPurchase(timestamp, item, quantity, bid, seller, isBuyout, true);
			isPurchaseRecorded = true;
		end

		-- Add the completed bid.
		if (isPendingBid(item, quantity, bid, seller, isBuyout, isSuccessful)) then
			-- Create a packed record.
			local completedBid = {};
			completedBid.time = timestamp;
			completedBid.quantity = quantity;
			completedBid.bid = bid;
			completedBid.seller = seller;
			completedBid.isBuyout = isBuyout;
			completedBid.isSuccessful = isSuccessful;
			completedBid.isPurchaseRecorded = isPurchaseRecorded;
			completedBid.buyerId = getCurrentPlayerId();
			local packedCompletedBid = packCompletedBid(completedBid);

			-- Add the completed bid to the table.
			local completedBids = getCompletedBidsTableForItem(item, true);
			table.insert(completedBids, packedCompletedBid);
			printCompletedBid(debugPrint, "Added completed bid: ", item, completedBid);

			-- Attmept to reconcile bids for this item.
			reconcileBidsByQuantityOrBids(item, quantity, bid);
		end
	else
		debugPrint("Invalid call to addCompletedBid()");
	end
end

-------------------------------------------------------------------------------
-- Deletes a completed bid from the database.
--
-- If completedBids is provided, the completed bid will be removed from it.
-------------------------------------------------------------------------------
function deleteCompletedBidByIndex(item, index, reason, completedBids)
	-- Update the unpacked completed bid list, if provided
	local completedBid = nil;
	if (completedBids) then
		-- Iterate in reverse since we will be removing the completed bid
		-- from the list when we find it.
		for completedIndex = table.getn(completedBids), 1, -1 do
			local bid = completedBids[completedIndex];
			if (index == bid.index) then
				completedBid = bid;
				table.remove(completedBids, completedIndex);
			elseif (index < bid.index) then
				bid.index = bid.index - 1;
			end
		end
	end

	-- Grab the completed bids table for the item.
	local completedBidsTable = getCompletedBidsTableForItem(item);
	if (completedBidsTable) then
		-- Get the completed bid if we don't already have it.
		if (completedBid == nil) then
			completedBid = unpackCompletedBid(completedBidsTable[index]);
		end
		
		-- Remove the completed bid from the table.
		table.remove(completedBidsTable, index);
		if (table.getn(completedBidsTable)) then
			getCompletedBidsTableForItem(item); -- Deletes the table
		end
		
		-- Debug noise.
		printCompletedBid(
			debugPrint,
			"Deleted completed bid ("..nilSafeStringFromString(reason).."): ",
			item,
			completedBid);
	end
end

-------------------------------------------------------------------------------
-- Converts a completed bid into a ';' delimited string.
-------------------------------------------------------------------------------
function packCompletedBid(completedBid)
	return 
		completedBid.time..";"..
		stringFromNumber(completedBid.quantity)..";"..
		stringFromNumber(completedBid.bid)..";"..
		nilSafeStringFromString(completedBid.seller)..";"..
		stringFromBoolean(completedBid.isBuyout)..";"..
		stringFromBoolean(completedBid.isSuccessful)..";"..
		stringFromBoolean(completedBid.isPurchaseRecorded)..";"..
		stringFromNumber(completedBid.buyerId);
end

-------------------------------------------------------------------------------
-- Converts a ';' delimited string into a completed bid.
-------------------------------------------------------------------------------
function unpackCompletedBid(packedCompletedBid)
	local completedBid = {};
	_, _, completedBid.time, completedBid.quantity, completedBid.bid, completedBid.seller, completedBid.isBuyout, completedBid.isSuccessful, completedBid.isPurchaseRecorded, completedBid.buyerId = string.find(packedCompletedBid, "(.+);(.+);(.+);(.+);(.+);(.+);(.+);(.+)");
	completedBid.time = numberFromString(completedBid.time);
	completedBid.quantity = numberFromString(completedBid.quantity);
	completedBid.bid = numberFromString(completedBid.bid);
	completedBid.seller = stringFromNilSafeString(completedBid.seller);
	completedBid.isBuyout = booleanFromString(completedBid.isBuyout);
	completedBid.isSuccessful = booleanFromString(completedBid.isSuccessful);
	completedBid.isPurchaseRecorded = booleanFromString(completedBid.isPurchaseRecorded);
	completedBid.buyerId = numberFromString(completedBid.buyerId);
	return completedBid;
end

-------------------------------------------------------------------------------
-- Gets the completed bids table for the specified item. The table contains
-- packed records.
-------------------------------------------------------------------------------
function getCompletedBidsTableForItem(item, create)
	local completedBidsTable = BeanCounterRealmDB.completedBids;
	if (completedBidsTable == nil) then
		completedBidsTable = {};
		BeanCounterRealmDB.completedBids = completedBidsTable;
	end

	-- Get the table for the item. Create or delete if appropriate.
	local completedBidsForItemTable = completedBidsTable[item];
	if (completedBidsForItemTable == nil and create) then
		completedBidsForItemTable = {};
		completedBidsTable[item] = completedBidsForItemTable;
	elseif (completedBidsForItemTable and table.getn(completedBidsForItemTable) == 0 and not create) then
		completedBidsTable[item] = nil;
	end

	return completedBidsForItemTable;
end

-------------------------------------------------------------------------------
-- Gets the completed bids (unpacked) for the specified item
-------------------------------------------------------------------------------
function getCompletedBidsForItem(item, filterFunc)
	local completedBids = {};
	local completedBidsTable = getCompletedBidsTableForItem(item);
	if (completedBidsTable) then
		for index in completedBidsTable do
			local completedBid = unpackCompletedBid(completedBidsTable[index]);
			completedBid.index = index;
			if (filterFunc == nil or filterFunc(completedBid)) then
				table.insert(completedBids, completedBid);
			end
		end
	end
	return completedBids;
end

-------------------------------------------------------------------------------
-- Prints the completed bids.
-------------------------------------------------------------------------------
function printCompletedBids()
	chatPrint("Completed Bids:");
	if (BeanCounterRealmDB.completedBids) then
		for item in BeanCounterRealmDB.completedBids do
			local completedBidsTable = BeanCounterRealmDB.completedBids[item];
			for index = 1, table.getn(completedBidsTable) do
				local completedBid = unpackCompletedBid(completedBidsTable[index]);
				printCompletedBid(chatPrint, nil, item, completedBid);
			end
		end
	end
end

-------------------------------------------------------------------------------
-- Calls the specified print function for the completed bid.
-------------------------------------------------------------------------------
function printCompletedBid(printFunc, prefix, item, completedBid)
	if (prefix == nil) then
		prefix = "";
	end
	printFunc(
		prefix..
		date("%c", completedBid.time)..", "..
		item..", "..
		stringFromNumber(completedBid.quantity)..", "..
		stringFromNumber(completedBid.bid)..", "..
		nilSafeStringFromString(completedBid.seller)..", "..
		stringFromBoolean(completedBid.isBuyout)..", "..
		stringFromBoolean(completedBid.isSuccessful)..", "..
		stringFromBoolean(completedBid.isPurchaseRecorded)..", "..
		nilSafeStringFromString(getPlayerName(completedBid.buyerId)));
end

--=============================================================================
-- Purchases functions
--=============================================================================

-------------------------------------------------------------------------------
-- Adds a purchase to the database.
-------------------------------------------------------------------------------
function addPurchase(timestamp, item, quantity, cost, seller, isBuyout)
	if (item and quantity and cost) then
		-- Create a packed record.
		local purchase = {};
		purchase.time = timestamp;
		purchase.quantity = quantity;
		purchase.cost = cost;
		purchase.seller = seller;
		purchase.isBuyout = isBuyout;
		purchase.buyerId = getCurrentPlayerId();
		local packedPurchase = packPurchase(purchase);

		-- Add the purchase to the table.
		local purchasesTable = getPurchasesTableForItem(item, true);
		table.insert(purchasesTable, packedPurchase);

		-- Debugging noise.
		printPurchase(debugPrint, "Added purchase: ", item, purchase);
	else
		debugPrint("Invalid call to addPurchase()");
	end
end

-------------------------------------------------------------------------------
-- Converts a purchase into a ';' delimited string.
-------------------------------------------------------------------------------
function packPurchase(purchase)
	return
		purchase.time..";"..
		stringFromNumber(purchase.quantity)..";"..
		stringFromNumber(purchase.cost)..";"..
		nilSafeStringFromString(purchase.seller)..";"..
		stringFromBoolean(purchase.isBuyout)..";"..
		stringFromNumber(purchase.buyerId);
end

-------------------------------------------------------------------------------
-- Converts a ';' delimited string into a purchase.
-------------------------------------------------------------------------------
function unpackPurchase(packedPurchase)
	local purchase = {};
	_, _, purchase.time, purchase.quantity, purchase.cost, purchase.seller, purchase.isBuyout, purchase.buyerId = string.find(packedPurchase, "(.+);(.+);(.+);(.+);(.+);(.+)");
	purchase.time = numberFromString(purchase.time);
	purchase.quantity = numberFromString(purchase.quantity);
	purchase.cost = numberFromString(purchase.cost);
	purchase.seller = stringFromNilSafeString(purchase.seller);
	purchase.isBuyout = booleanFromString(purchase.isBuyout);
	purchase.buyerId = numberFromString(purchase.buyerId);
	return purchase;
end

-------------------------------------------------------------------------------
-- Gets the purchases table for the specified item. The table contains packed
-- records.
-------------------------------------------------------------------------------
function getPurchasesTableForItem(item, create)
	local purchasesTable = BeanCounterRealmDB.purchases;
	if (purchasesTable == nil) then
		purchasesTable = {};
		BeanCounterRealmDB.purchases = purchasesTable;
	end
	
	-- Get the table for the item. Create or delete if appropriate.
	local purchasesForItemTable = purchasesTable[item];
	if (purchasesForItemTable == nil and create) then
		purchasesForItemTable = {};
		purchasesTable[item] = purchasesForItemTable;
	elseif (purchasesForItemTable and table.getn(purchasesForItemTable) == 0 and not create) then
		purchasesTable[item] = nil;
	end

	return purchasesForItemTable;
end

-------------------------------------------------------------------------------
-- Gets the list of puchased items.
-------------------------------------------------------------------------------
function getPurchasedItems(item)
	local items = {};
	if (BeanCounterRealmDB.purchases) then
		for item in BeanCounterRealmDB.purchases do
			local purchasesTable = getPurchasesTableForItem(item);
			if (purchasesTable and table.getn(purchasesTable) > 0) then
				table.insert(items, item);
			end
		end
	end
	return items;
end

-------------------------------------------------------------------------------
-- Gets the purchases (unpacked) for the specified item
-------------------------------------------------------------------------------
function getPurchasesForItem(item, filterFunc)
	local purchases = {};
	local purchasesTable = getPurchasesTableForItem(item);
	if (purchasesTable) then
		for index in purchasesTable do
			local purchase = unpackPurchase(purchasesTable[index]);
			purchase.index = index;
			if (filterFunc == nil or filterFunc(purchase)) then
				table.insert(purchases, purchase);
			end
		end
	end
	return purchases;
end

-------------------------------------------------------------------------------
-- Prints the purchases.
-------------------------------------------------------------------------------
function printPurchases()
	chatPrint("Purchases:");
	if (BeanCounterRealmDB.purchases) then
		for item in BeanCounterRealmDB.purchases do
			local purchasesTable = BeanCounterRealmDB.purchases[item];
			for index = 1, table.getn(purchasesTable) do
				local purchase = unpackPurchase(purchasesTable[index]);
				printPurchase(chatPrint, nil, item, purchase);
			end
		end
	end
end

-------------------------------------------------------------------------------
-- Calls the specified print function for the completed bid.
-------------------------------------------------------------------------------
function printPurchase(printFunc, prefix, item, purchase)
	if (prefix == nil) then
		prefix = "";
	end
	printFunc(
		prefix..
		date("%c", purchase.time)..", "..
		item..", "..
		purchase.quantity..", "..
		purchase.cost..", "..
		nilSafeStringFromString(purchase.seller)..", "..
		stringFromBoolean(purchase.isBuyout)..", "..
		nilSafeStringFromString(getPlayerName(purchase.buyerId)));
end

--=============================================================================
-- Bid reconcilation functions
--=============================================================================

-------------------------------------------------------------------------------
-- Reconcile all bids that should be completed by the specified time.
-------------------------------------------------------------------------------
function reconcileBids(reconcileTime, excludeItems)
	local totalReconciled = 0;
	local totalDiscarded = 0;
	local items = getPendingBidItems();
	for index in items do
		local item = items[index];
		if (excludeItems == nil or excludeItems[item] == nil) then
			local reconciled, discarded = reconcileBidsByTime(item, reconcileTime);
			totalReconciled = totalReconciled + reconciled;
			totalDiscarded = totalDiscarded + discarded;
		end
	end
	return totalReconciled, totalDiscarded;
end

-------------------------------------------------------------------------------
-- Reconcile bids for the item that should be completed by the specified
-- time.
-------------------------------------------------------------------------------
function reconcileBidsByTime(item, reconcileTime)
	debugPrint("reconcileBidsByTime("..item..", "..date("%c", reconcileTime)..")");

	-- Get the list of pending bids that should have completed before the
	-- specified time.
	local pendingBids = getPendingBidsForItem(
		item, 
		function(pendingBid)
			return (pendingBid.buyerId == getCurrentPlayerId() and
					pendingBid.time + MAXIMUM_TIME_LEFT[pendingBid.timeLeft] + AUCTION_OVERRUN_LIMIT < reconcileTime);
		end);
	debugPrint(table.getn(pendingBids).." matching pending bids");

	-- Get the list of completed bids that completed before the specified
	-- time.
	local completedBids = getCompletedBidsForItem(
		item,
		function(completedBid)
			return (completedBid.buyerId == getCurrentPlayerId() and
					completedBid.time < reconcileTime);
		end);
	debugPrint(table.getn(completedBids).." matching completed bids");

	-- Reconcile the lists.
	local reconciledBids = reconcileBidList(item, pendingBids, completedBids, true);

	-- Cleanup the unmatch pending bids that are too old to match any
	-- completed bids.
	local discardedPendingBids = 0;
	for index = table.getn(pendingBids), 1, -1 do
		local pendingBid = pendingBids[index];
		deletePendingBidByIndex(item, pendingBid.index, "no match", pendingBids);
		discardedPendingBids = discardedPendingBids + 1;
	end

	-- Cleanup the unmatched completed bids that are too old to match any
	-- pending bids.
	local discardedCompletedBids = 0;
	for index = table.getn(completedBids), 1, -1 do
		local completedBid = completedBids[index];
		if (completedBid.time + AUCTION_DURATION_LIMIT < reconcileTime) then
			deleteCompletedBidByIndex(item, completedBid.index, "no match", completedBids);
			discardedCompletedBids = discardedCompletedBids + 1;
		end
	end
			
	return reconciledBids, discardedPendingBids, discardedCompletedBids;
end

-------------------------------------------------------------------------------
-- Attempts to reconcile bids by either quantity or bid amount.
-------------------------------------------------------------------------------
function reconcileBidsByQuantityOrBids(item, quantityHint, bidHint)
	-- If a hint is supplied, try them first. If no hints are supplied or the
	-- hints cause bids to be reconciled, then widen the reconcilation
	-- hunt.
	if ((bidHint == nil and quantityHint == nil) or
		(bidHint ~= nil and reconcileBidsByBid(item, bidHint) > 0) or
		(quantityHint ~= nil and reconcileBidsByQuantity(item, quantityHint) > 0)) then
		local index = 1;
		local quantitiesAttempted = {};
		local bidsAttempted = {};
		local completedBids = getCompletedBidsTableForItem(item);
		if (completedBids) then
			while (index <= table.getn(completedBids)) do
				local completedBid = unpackCompletedBid(completedBids[index]);
				if (completedBid.quantity and not quantitiesAttempted[completedBid.quantity]) then
					quantitiesAttempted[completedBid.quantity] = true;
					if (reconcileBidsByQuantity(item, completedBid.quantity) > 0) then
						index = 1;
						bidsAttempted = {};
					else
						index = index + 1;
					end
				elseif (completedBid.bid and not bidsAttempted[completedBid.bid]) then
					bidsAttempted[completedBid.bid] = true;
					if (reconcileBidsByBid(item, completedBid.bid) > 0) then
						index = 1;
						quantitiesAttempted = {};
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
-- Attempts to reconcile bids by quantity
-------------------------------------------------------------------------------
function reconcileBidsByQuantity(item, quantity)
	debugPrint("reconcileBidsByQuantity("..item..", "..quantity..")");

	-- Get all the pending bids matching the quantity
	local pendingBids = getPendingBidsForItem(
		item, 
		function(pendingBid)
			return (pendingBid.buyerId == getCurrentPlayerId() and
					pendingBid.quantity == quantity);
		end);
	debugPrint(table.getn(pendingBids).." matching pending bids");
	
	-- Get all the completed bids matching the quantity
	local completedBids = getCompletedBidsForItem(
		item, 
		function(completedBid)
			return (completedBid.buyerId == getCurrentPlayerId() and 
					completedBid.quantity == quantity);
		end);
	debugPrint(table.getn(completedBids).." matching completed bids");
	
	-- Attempt to reconcile the lists.
	if (table.getn(pendingBids) == table.getn(completedBids)) then
		return reconcileBidList(item, pendingBids, completedBids, false);
	elseif (doesPendingBidListMatch(pendingBids)) then
		return reconcileBidList(item, pendingBids, completedBids, false);
	else
		debugPrint("Cannot reconcile by quantity");
	end

	return 0;
end

-------------------------------------------------------------------------------
-- Attempts to reconcile bids by bid
-------------------------------------------------------------------------------
function reconcileBidsByBid(item, bid)
	debugPrint("reconcileBidsByBid("..item..", "..bid..")");

	-- Get all the pending bids matching the quantity
	local pendingBids = getPendingBidsForItem(
		item, 
		function(pendingBid)
			return (pendingBid.buyerId == getCurrentPlayerId() and
					pendingBid.bid == bid);
		end);
	debugPrint(table.getn(pendingBids).." matching pending bids");
	
	-- Get all the completed bids matching the quantity
	local completedBids = getCompletedBidsForItem(
		item, 
		function(completedBid)
			return (completedBid.buyerId == getCurrentPlayerId() and 
					completedBid.bid == bid);
		end);
	debugPrint(table.getn(completedBids).." matching completed bids");
	
	-- Attempt to reconcile the lists.
	if (table.getn(pendingBids) == table.getn(completedBids)) then
		return reconcileBidList(item, pendingBids, completedBids, false);
	elseif (doesPendingBidListMatch(pendingBids)) then
		return reconcileBidList(item, pendingBids, completedBids, false);
	else
		debugPrint("Cannot reconcile by bid");
	end

	return 0;
end

-------------------------------------------------------------------------------
-- Takes lists of pending and completed items and attempts to reconcile them.
-- A purchase is added for each pending and completed bid match. If
-- discrepencies are not allowed and there are discrepencies, then no bids
-- are reconciled.
-------------------------------------------------------------------------------
function reconcileBidList(item, pendingBids, completedBids, discrepenciesAllowed)
	-- If we have some bids, reconcile them!
	local bidsReconciled = 0;
	if (table.getn(pendingBids) > 0 or table.getn(completedBids) > 0) then
		-- For each pending bid, get the list of potential completed bids.
		-- Afterwards, sort the pending bid list by match count.
		for pendingIndex = 1, table.getn(pendingBids) do
			local pendingBid = pendingBids[pendingIndex];
			pendingBid.matches = {};
			for completedIndex = 1, table.getn(completedBids) do
				local completedBid = completedBids[completedIndex];
				if (doesPendingBidMatchCompletedBid(pendingBid, completedBid)) then
					table.insert(pendingBid.matches, completedBid);
				end
			end
			table.sort(pendingBid.matches, compareTime);
		end
		table.sort(pendingBids, compareMatchCount);

		-- For each pending bid, pick a suitable completed bid match.
		-- This algorithm could be much better, but it works for most sane
		-- cases.
		for pendingIndex = 1, table.getn(pendingBids) do
			local pendingBid = pendingBids[pendingIndex];
			if (pendingBid.match == nil) then
				for completedIndex = 1, table.getn(pendingBid.matches) do
					local completedBid = pendingBid.matches[completedIndex];
					if (completedBid.match == nil) then
						completedBid.match = pendingBid;
						pendingBid.match = completedBid;
						break;
					end
				end
			end
		end

		-- Check for unmatched pending bids.
		local unmatchedPendingBidCount = 0;
		for pendingIndex = 1, table.getn(pendingBids) do
			local pendingBid = pendingBids[pendingIndex];
			if (pendingBid.match == nil) then
				unmatchedPendingBidCount = unmatchedPendingBidCount + 1;
			end
		end

		-- Check for unmatched completed bids.
		local unmatchedCompletedBidCount = 0;
		for completedIndex = 1, table.getn(completedBids) do
			local completedBid = completedBids[completedIndex];
			if (completedBid.match == nil) then
				unmatchedCompletedBidCount = unmatchedCompletedBidCount + 1;
			end
		end

		-- Reconcile the lists if all bids match or discrepencies are
		-- allowed!
		if (discrepencesAllowed or unmatchedPendingBidCount == 0 or unmatchedCompletedBidCount == 0) then
			-- Time to log some purchases! We iterate through the pending
			-- list in reverse since we will be deleting items from
			-- it.
			debugPrint("Begin reconciling bid list for "..item);
			for pendingIndex = table.getn(pendingBids), 1, -1 do
				local pendingBid = pendingBids[pendingIndex];
				if (pendingBid.match ~= nil) then
					-- Reconcile the matching bids.
					reconcileMatchingBids(item, pendingBids, pendingBid, completedBids, pendingBid.match);
					bidsReconciled = bidsReconciled + 1;
				end
			end
			debugPrint("End reconciling bid list for "..item.." ("..bidsReconciled.." reconciled)");
		else
			debugPrint("Not reconciling bids for "..item.." due to discrepencies");
		end
	else
		debugPrint("No reconcilable bids for "..item);
	end

	return bidsReconciled;
end

-------------------------------------------------------------------------------
-- Performs bid reconcilation by removing the pending and completed bids
-- and adding a purchase.
--
-- WARNING: The pendingBid and completedBid will be removed from their lists.
-------------------------------------------------------------------------------
function reconcileMatchingBids(item, pendingBids, pendingBid, completedBids, completedBid)
	-- Remove the pending and completed bids
	deletePendingBidByIndex(item, pendingBid.index, "reconciled", pendingBids);
	deleteCompletedBidByIndex(item, completedBid.index, "reconciled", completedBids);

	-- Add a sale (success or failure).
	if (not completedBid.isSuccessful) then
		debugPrint("Bid not successful");
	elseif (pendingBid.isBuyout or completedBid.isPurchaseRecorded) then
		debugPrint("Purchase already recorded");
	else
		addPurchase(completedBid.time, item, pendingBid.quantity, pendingBid.bid, pendingBid.seller, pendingBid.isBuyout);
	end
end

-------------------------------------------------------------------------------
-- Checks if all pending bids in the list match each other. All pending
-- bids must be within a 5 minute period of time to be considered matches.
-------------------------------------------------------------------------------
function doesPendingBidListMatch(pendingBids)
	local match = (table.getn(pendingBids) > 0);
	if (match) then
		local pendingBid = pendingBids[1];
		local firstBidTime = pendingBid.time;
		local lastBidTime = pendingBid.time;
		local quantity = pendingBid.quantity;
		local bid = pendingBid.bid;
		local buyout = pendingBid.buyout;
		local deposit = pendingBid.deposit;
		local buyerId = pendingBid.buyerId;
		for index = 2, table.getn(pendingBids) do
			local pendingBid = pendingBids[index];
			if (quantity ~= pendingBid.quantity or
				bid ~= pendingBid.bid or
				isBuyout ~= pendingBid.isBuyout or
				buyerId ~= pendingBid.buyerId) then
				match = false;
				break;
			elseif (pendingBid.time < firstBidTime) then
				firstBidTime = pendingBid.time;
			elseif (pendingBid.time > lastBidTime) then
				lastBidTime = pendingBid.time;
			end
		end
		if (match) then
			local bidTimeSpread = lastBidTime - firstBidTime;
			match = (bidTimeSpread < (5 * 60));
		end
	end
	return match;	
end

-------------------------------------------------------------------------------
-- Checks if the completed bid could be the pending bid.
-------------------------------------------------------------------------------
function doesPendingBidMatchCompletedBid(pendingBid, completedBid)
	-- Fudge time that we add to the duration of auctions. This accounts for
	-- mail delivery lag and additional auction duration due to bidding.
	local AUCTION_DURATION_CUSHION = (12 * 60 * 60); -- 12 hours

	-- Check if buyer ids match.
	if (pendingBid.buyerId ~= nil and 
		completedBid.buyerId ~= nil and
		completedBid.buyerId ~= pendingBid.buyerId) then
		--debugPrint("doesPendingBidMatchCompletedBid() - false due to buyer id");
		return false;
	end

	-- Check if the quantities match.
	if (pendingBid.quantity ~= nil and 
		completedBid.quantity ~= nil and
		completedBid.quantity ~= pendingBid.quantity) then
		--debugPrint("doesPendingBidMatchCompletedBid() - false due to quantity mismatch");
		return false;
	end

	-- Check if the sellers match.
	if (pendingBid.seller ~= nil and 
		completedBid.seller ~= nil and
		completedBid.seller ~= pendingBid.seller) then
		--debugPrint("doesPendingBidMatchCompletedBid() - false due to seller mismatch");
		return false;
	end

	-- Check if the buyout flags match.
	if (pendingBid.isBuyout ~= nil and 
		completedBid.isBuyout ~= nil and
		completedBid.isBuyout ~= pendingBid.isBuyout) then
		--debugPrint("doesPendingBidMatchCompletedBid() - false due to buyout mismatch");
		return false;
	end

	-- Check if completed bid was received before the auction should have expired.
	if (pendingBid.time + MAXIMUM_TIME_LEFT[pendingBid.timeLeft] + AUCTION_DURATION_CUSHION < completedBid.time) then
		--debugPrint("doesPendingBidMatchCompletedBid() - false due to max time left");
		return false;
	end

	-- If the completed bid was not a buyout, check if the completed bid was
	-- received after the auction should have expired.
	if (pendingBid.isBuyout ~= nil and pendingBid.isBuyout == false) then
		if (pendingBid.time + MINIMUM_TIME_LEFT[pendingBid.timeLeft] > completedBid.time) then
			--debugPrint("doesPendingBidMatchCompletedBid() - false due to min time left");
			return false;
		end
	end
	
	-- If we made it this far, its a possible match!
	return true;
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

--=============================================================================
-- Utility functions
--=============================================================================

-------------------------------------------------------------------------------
-- Gets the number of non-nil fields in a bid.
-------------------------------------------------------------------------------
function getBidNonNilFieldCount(bid)
	local count = 0;
	if (bid.quantity) then count = count + 1 end;
	if (bid.bid) then count = count + 1 end;
	if (bid.seller) then count = count + 1 end;
	if (bid.isBuyout) then count = count + 1 end;
	return count;
end

-------------------------------------------------------------------------------
-- Compares the bids by number of non-nil fields.
-------------------------------------------------------------------------------
function compareBidsByNonNilFieldCount(bid1, bid2)
	local count1 = getBidNonNilFieldCount(bid1);
	local count2 = getBidNonNilFieldCount(bid2);
	if (count1 > count2) then
		return true;
	end
	return false;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function debugPrint(message)
	BeanCounter.DebugPrint("[BeanCounter.PurchasesDB] "..stringFromNilSafeString(message));
end

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
BeanCounter.Purchases = 
{
	AddPendingBid = addPendingBid;
	DeletePendingBid = deletePendingBidBySignature;
	GetPendingBidItems = getPendingBidItems;
	GetPendingBidsForItem = getPendingBidsForItem;
	AddSuccessfulBid = addSuccessfulBid;
	AddFailedBid = addFailedBid;
	GetPurchasedItems = getPurchasedItems;
	GetPurchasesForItem = getPurchasesForItem;
	ReconcileBids = reconcileBids;
	PrintPendingBids = printPendingBids;
	PrintCompletedBids = printCompletedBids;
	PrintPurchases = printPurchases;
};
