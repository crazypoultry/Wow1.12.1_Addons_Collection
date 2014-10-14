--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: <%version%> (<%codename%>)
	Revision: $Id: AucSnapshotDB.lua 1055 2006-10-09 08:34:26Z vindicator $

	SnapshotDB - the AH snapshot database

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
local tonumber = tonumber;

local chatPrint = Auctioneer.Util.ChatPrint;
local nilSafe = Auctioneer.Database.NilSafeStringFromString;
local stringFromBoolean = Auctioneer.Database.StringFromBoolean;
local booleanFromString = Auctioneer.Database.BooleanFromString;
local stringFromNumber = Auctioneer.Database.StringFromNumber;
local nilSafeStringFromString = Auctioneer.Database.NilSafeStringFromString;
local stringFromNilSafeString = Auctioneer.Database.StringFromNilSafeString;

-------------------------------------------------------------------------------
-- Function Prototypes
-------------------------------------------------------------------------------
local load;

local loadDatabase;
local createDatabase;
local createAHDatabase;
local upgradeAHDatabase;
local getAHDatabase;
local clear;

local updateForQuery;
local updateForSignature;
local updateAuction;
local addAuction;
local removeAuction;
local query;
local queryWithItemKey;
local getAuctionsForItem;
local getAuctionById;
local getCurrentBid;
local doesItemKeyMatchQuery;
local reconcileAuctionsForSignature;
local reconcileAuction;
local getTimeLeft;
local getMaxBids;
local getNextAuctionId;
local getAuctionIdsForItemKey;
local addAuctionToSnapshot;
local updateAuctionInSnapshot;
local removeAuctionFromSnapshot;
local packAuction;
local unpackAuction;
local isValidAuction;

local createAuctionSignatureFromAuction;
local breakAuctionSignature;
local createItemKeyFromAuctionSignature;

local addUpdate;
local removeSubsetUpdates;
local getLastUpdate;
local isUpdateSubsetOfUpdate;
local createUpdateFromQuery;
local packUpdate;
local unpackUpdate;

local debugPrint;

-------------------------------------------------------------------------------
-- Data Members
-------------------------------------------------------------------------------
-- The Auctioneer snapshot database saved on disk. Nobody should access this
-- variable outside of the loadDatabase() method. Instead the LoadedSnapshotDB
-- variable should be used.
AuctioneerSnapshotDB = nil;

-- The current Auctioneer history database as determined in the load() method.
-- This is either the database on disk or a temporary database if the user
-- chose not to upgrade their database.
local LoadedSnapshotDB;

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

-- The current version of the snapshot database. This number must be incremented
-- anytime a change is made to the database schema.
local CURRENT_SNAPSHOTDB_VERSION = 1; -- Auctioneer 4.0

-- Map of time left index to time left seconds.
local TimeLeftInSeconds = {
	[0] = 0,
	[1] = 1800,		-- 30 minutes
	[2] = 7200,		-- 2 hours
	[3] = 28800,	-- 8 hours
	[4] = 86400,	-- 24 hours
}

-- Schema for records in the auctions table of the snapshot database.
local AuctionMetaData = {
	{
		fieldName = "itemId";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "suffixId";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "enchantId";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "uniqueId";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "count";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "minBid";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "buyoutPrice";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "owner";
		fromStringFunc = stringFromNilSafeString;
		toStringFunc = nilSafeStringFromString;
	},
	{
		fieldName = "bidAmount";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "highBidder";
		fromStringFunc = booleanFromString;
		toStringFunc = stringFromBoolean;
	},
	{
		fieldName = "timeLeft";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "lastSeen";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "expiration";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
};

-- Schema for records in the update history table of the snapshot database.
local UpdateMetaData = {
	{
		fieldName = "date";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "name";
		fromStringFunc = stringFromNilSafeString;
		toStringFunc = nilSafeStringFromString;
	},
	{
		fieldName = "minLevel";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "maxLevel";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "invTypeIndex";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "classIndex";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "subclassIndex";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "qualityIndex";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
};

-------------------------------------------------------------------------------
-- Loads this module.
-------------------------------------------------------------------------------
function load(usePersistentDatabase)
	-- Decide what database to use. If the user has an older database and they
	-- choose not to upgrade, we cannot use it. Insetad we'll use a temporary
	-- empty database that will not be saved.
	if (usePersistentDatabase) then
		loadDatabase();
	else
		debugPrint("Using temporary AuctioneerSnapshotDB");
		LoadedSnapshotDB = createDatabase();
	end

end

--=============================================================================
-- Database management functions
--=============================================================================

-------------------------------------------------------------------------------
-- Upgrades the AuctioneerSnapshotDB database. If the table does not exist
-- it creates a new one.
-------------------------------------------------------------------------------
function loadDatabase()
	-- Create the root AuctioneerSnapshotDB table, if needed.
	if (not AuctioneerSnapshotDB) then
		AuctioneerSnapshotDB = createDatabase();
		debugPrint("Created AuctioneerSnapshotDB database");
	end

	-- Upgrade each realm-faction database, if needed.
	for ahKey in pairs(AuctioneerSnapshotDB) do
		if (not upgradeAHDatabase(AuctioneerSnapshotDB[ahKey])) then
			debugPrint("WARNING: Snapshot database corrupted for "..ahKey.."! Creating new database.");
			AuctioneerSnapshotDB[ahKey] = createAHDatabase(ahKey);
		end
	end

	-- Make AuctioneerSnapshotDB the loaded database!
	LoadedSnapshotDB = AuctioneerSnapshotDB;
end

-------------------------------------------------------------------------------
-- Creates a new database.
-------------------------------------------------------------------------------
function createDatabase()
	return {};
end

-------------------------------------------------------------------------------
-- Create a brand new database for an auction house key (relam-faction).
-------------------------------------------------------------------------------
function createAHDatabase(ahKey)
	return {
		version = CURRENT_SNAPSHOTDB_VERSION;
		ahKey = ahKey;
		nextAuctionId = 1;
		auctions = {};
		auctionIdsByItemKey = {};
		updates = {};
	}
end

-------------------------------------------------------------------------------
-- Upgrades the specified database. Returns true if the database was upgraded
-- successfully.
-------------------------------------------------------------------------------
function upgradeAHDatabase(ah)
	-- Check that we have a valid database.
	if (not (ah.version and ah.ahKey)) then
		return false
	end

	-- Check if we need upgrading.
	if (ah.version == CURRENT_SNAPSHOTDB_VERSION) then
		return true;
	end

	-- Future DB upgrade code goes here...
	debugPrint("Upgrading snapshot database for "..ah.ahKey);

	-- Return the result of the upgrade!
	return (ah.version == CURRENT_SNAPSHOTDB_VERSION);
end

-------------------------------------------------------------------------------
-- Gets the Auctioneer snapshot database for the specified auction house.
-------------------------------------------------------------------------------
function getAHDatabase(ahKey, create)
	-- If no auction house key was provided use the default key for the
	-- current zone.
	ahKey = ahKey or Auctioneer.Util.GetAuctionKey();
	local ah = LoadedSnapshotDB[ahKey];
	if (ah == nil and create) then
		ah = createAHDatabase(ahKey);
		LoadedSnapshotDB[ahKey] = ah;
		debugPrint("Created LoadedSnapshotDB["..ahKey.."]");
	end
	return ah;
end

-------------------------------------------------------------------------------
-- Removes the specified item from the snapshot. Removes all items if itemKey
-- is nil.
-------------------------------------------------------------------------------
function clear(itemKey, ahKey)
	local ah = getAHDatabase(ahKey, false);
	if (ah) then
		if (itemKey) then
			-- Remove the specified item from the database.
			local auctionIdsForItemKey = ah.auctionIdsByItemKey[itemKey];
			if (auctionIdsForItemKey) then
				for _, auctionId in ipairs(auctionIdsForItemKey) do
					ah.auctions[auctionId] = nil;
				end
			end
			ah.auctionIdsByItemKey[itemKey] = nil;
			debugPrint("Removed "..itemKey.." from snapshot database "..ah.ahKey);
		else
			-- Toss the entire database by recreating it.
			LoadedSnapshotDB[ah.ahKey] = createAHDatabase(ah.ahKey);
			ah.updates = {};
			debugPrint("Cleared snapshot database for "..ah.ahKey);
		end
	end
end


--=============================================================================
-- Snapshot functions
--=============================================================================

-------------------------------------------------------------------------------
-- Updates the snapshot with the results from the specified query.
-------------------------------------------------------------------------------
function updateForQuery(ahKey, query, auctions, partial)
	-- Use the default auction house for the zone if none was provided.
	ahKey = ahKey or Auctioneer.Util.GetAuctionKey();
	local ah = getAHDatabase(ahKey, true);

	debugPrint("Updating snapshot "..ahKey.." for query: ");
	debugPrint("    name", query.name);
	debugPrint("    minLevel", query.minLevel);
	debugPrint("    maxLevel", query.maxLevel);
	debugPrint("    invTypeIndex", query.invTypeIndex);
	debugPrint("    classIndex", query.classIndex);
	debugPrint("    subclassIndex", query.subclassIndex);
	debugPrint("    qualityIndex", query.qualityIndex);

	-- Convert the pages into a list of auctions. Auctions get filed first under
	-- itemKey, then under auctionSignature. We do this so all auctions of the same
	-- item are grouped together when doing the reconciling. This allows us to take
	-- advantage of caching in other modules.
	--
	-- auctionsInUpdateByItemKey as follows:
	-- auctionsInUpdateByItemKey[itemKey][auctionSignature] = {
	--     [1] = <auction>
	--     ...
	-- }
	local auctionsInUpdateByItemKey = {};
	for _, auction in ipairs(auctions) do
		if (isValidAuction(auction)) then
			-- Get the list of auctions in the update for this signature and
			-- add this auction to the list.
			local itemKey = Auctioneer.ItemDB.CreateItemKeyFromAuction(auction);
			local auctionSignature = createAuctionSignatureFromAuction(auction);
			local auctionsInUpdateBySignature = auctionsInUpdateByItemKey[itemKey];
			if (not auctionsInUpdateBySignature) then
				auctionsInUpdateBySignature = {};
				auctionsInUpdateByItemKey[itemKey] = auctionsInUpdateBySignature;
			end
			local auctionsInUpdate = auctionsInUpdateBySignature[auctionSignature];
			if (not auctionsInUpdate) then
				auctionsInUpdate = {};
				auctionsInUpdateBySignature[auctionSignature] = auctionsInUpdate;
			end
			table.insert(auctionsInUpdate, auction);
		else
			debugPrint("Ignoring invalid auction");
		end
	end

	-- Get the matching auctions from the snapshot. Auctions get filed first under
	-- itemKey, then under auctionSignature. We do this so all auctions of the same
	-- item are grouped together when doing the reconciling. This allows us to take
	-- advantage of caching in other modules.
	--
	-- auctionsInSnapshotByItemKey[itemKey][auctionSignature] = {
	--     [1] = <auction>
	--     ...
	-- }
	local auctionsInSnapshotByItemKey = {};
	for itemKey, auctionIdsForItemKey in pairs(ah.auctionIdsByItemKey) do
		if ((not query) or doesItemKeyMatchQuery(itemKey, query)) then
			local auctionsInSnapshotBySignature = {};
			auctionsInSnapshotByItemKey[itemKey] = auctionsInSnapshotBySignature;
			for _, auctionId in ipairs(auctionIdsForItemKey) do
				local packedAuction = ah.auctions[auctionId];
				if (packedAuction) then
					local auction = unpackAuction(ahKey, auctionId, packedAuction);
					local auctionSignature = createAuctionSignatureFromAuction(auction);
					local auctionsInSnapshot = auctionsInSnapshotBySignature[auctionSignature];
					if (not auctionsInSnapshot) then
						auctionsInSnapshot = {};
						auctionsInSnapshotBySignature[auctionSignature] = auctionsInSnapshot;
					end
					table.insert(auctionsInSnapshot, auction);
				else
					debugPrint("WARNING: AuctionIdsForItemKey table corrupted!");
				end
			end
		end
	end

	-- Now for each signature in the update list, reconcile it against
	-- the snapshot list for the same signature.
	for itemKey, auctionsInUpdateBySignature in pairs(auctionsInUpdateByItemKey) do
		for auctionSignature, auctionsInUpdate in pairs(auctionsInUpdateBySignature) do
			-- Get the list of corresponding auctions in the snapshot.
			local auctionsInSnapshot;
			local auctionsInSnapshotBySignature = auctionsInSnapshotByItemKey[itemKey];
			if (auctionsInSnapshotBySignature ~= nil) then
				auctionsInSnapshot = auctionsInSnapshotBySignature[auctionSignature];
			end
			if (auctionsInSnapshot) then
				-- Reconcile the auctions in the update against the auctions
				-- in the snapshot.
				reconcileAuctionsForSignature(ah, auctionSignature, auctionsInUpdate, auctionsInSnapshot, partial);
				-- Remove these auctions from the snapshot list so we don't remove
				-- them later.
				auctionsInSnapshotBySignature[auctionSignature] = nil;
			else
				-- No auctions for this item in the snapshot. Just add
				-- all the auctions from the update.
				for index, auction in ipairs(auctionsInUpdate) do
					addAuctionToSnapshot(ah, auction);
				end
			end
		end
	end

	-- If this isn't a partial update, remove any auctions that didn't match.
	if (not partial) then
		for itemKey, auctionsInSnapshotBySignature in pairs(auctionsInSnapshotByItemKey) do
			for auctionSignature, auctionsInSnapshot in pairs(auctionsInSnapshotBySignature) do
				-- Check for  auctionsInUpdateByItemKey[itemKey][auctionSignature].
				-- If it doesn't exist then we need to remove all auctions in the
				-- snapshot for the signature.
				local auctionsInUpdateBySignature = auctionsInUpdateByItemKey[itemKey];
				if (not (auctionsInUpdateBySignature and auctionsInUpdateBySignature[auctionSignature])) then
					for _, auction in ipairs(auctionsInSnapshot) do
						removeAuctionFromSnapshot(ah, auction);
					end
				end
			end
		end

		-- Note the update in the database.
		addUpdate(ah, query);
		Auctioneer.EventManager.FireEvent("AUCTIONEER_SNAPSHOT_UPDATE", query);
	end
end

-------------------------------------------------------------------------------
-- Updates the snapshot with the results from the specified query.
-------------------------------------------------------------------------------
function updateForSignature(ahKey, auctionSignature, auctions, partial)
	-- Use the default auction house for the zone if none was provided.
	ahKey = ahKey or Auctioneer.Util.GetAuctionKey();
	local ah = getAHDatabase(ahKey, true);
	debugPrint("Updating snapshot "..ahKey.." for signature: "..auctionSignature);

	-- Get the matching auctions from the snapshot.
	local auctionsInSnapshot = {};
	local itemKey = createItemKeyFromAuctionSignature(auctionSignature);
	local auctionIdsForItemKey = ah.auctionIdsByItemKey[itemKey];
	if (auctionIdsForItemKey) then
		for _, auctionId in ipairs(auctionIdsForItemKey) do
			local packedAuction = ah.auctions[auctionId];
			if (packedAuction) then
				local auction = unpackAuction(ahKey, auctionId, packedAuction);
				if (auctionSignature == createAuctionSignatureFromAuction(auction)) then
					table.insert(auctionsInSnapshot, auction);
				end
			else
				debugPrint("WARNING: AuctionIdsForItemKey table corrupted!");
			end
		end
	end

	-- Reconcile the auctions in the update against the auctions
	-- in the snapshot.
	reconcileAuctionsForSignature(ah, auctionSignature, auctions, auctionsInSnapshot, partial);
end

-------------------------------------------------------------------------------
-- Updates the auction in the snapshot.
-------------------------------------------------------------------------------
function updateAuction(auction)
	-- Use the default auction house for the zone if none was provided.
	local ah = getAHDatabase(auction.ahKey, true);
	debugPrint("Updating snapshot "..auction.ahKey.." for auction: "..auction.auctionId);

	-- Update the auction in the database if its valid.
	if (Auctioneer.QueryManager.IsAuctionValid(auction)) then
		local auctionInSnapshot = getAuctionById(auction.ahKey, auction.auctionId);
		if (auctionInSnapshot) then
			updateAuctionInSnapshot(ah, auctionInSnapshot, auction);
		else
			debugPrint("WARNING: Auction "..nilSafe(auction.auctionId).." not in snapshot");
		end
	else
		debugPrint("WARNING: Auction "..nilSafe(auction.auctionId).." is not valid");
	end
end

-------------------------------------------------------------------------------
-- Adds the auction to the snapshot.
-------------------------------------------------------------------------------
function addAuction(auction)
	-- Use the default auction house for the zone if none was provided.
	local ah = getAHDatabase(auction.ahKey, true);
	debugPrint("Adding auction to snapshot "..auction.ahKey);

	-- Add the auction to the database if its valid.
	if (Auctioneer.QueryManager.IsAuctionValid(auction)) then
		addAuctionToSnapshot(ah, auction);
	else
		debugPrint("WARNING: Auction to add is not valid");
	end
end


-------------------------------------------------------------------------------
-- Removes the auction from the snapshot.
-------------------------------------------------------------------------------
function removeAuction(auction)
	-- Use the default auction house for the zone if none was provided.
	local ah = getAHDatabase(auction.ahKey, true);
	debugPrint("Updating snapshot "..auction.ahKey.." for auction: "..auction.auctionId);

	-- Update the auction in the database.
	local auctionInSnapshot = getAuctionById(auction.ahKey, auction.auctionId);
	if (auctionInSnapshot) then
		removeAuctionFromSnapshot(ah, auctionInSnapshot);
	else
		debugPrint("WARNING: Auction "..nilSafe(auction.auctionId).." not in snapshot");
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function query(ahKey, query, filterFunc, filterArg)
	-- Use the default auction house for the zone if none was provided.
	ahKey = ahKey or Auctioneer.Util.GetAuctionKey();

	-- Iterate over the list of auctions and find the matching ones.
	local matchingAuctions = {};
	local ah = getAHDatabase(ahKey, true);
	for itemKey, auctionIdsForItemKey in pairs(ah.auctionIdsByItemKey) do
		if ((not query) or doesItemKeyMatchQuery(itemKey, query)) then
			for _, auctionId in ipairs(auctionIdsForItemKey) do
				local packedAuction = ah.auctions[auctionId];
				if (packedAuction) then
					local auction = unpackAuction(ahKey, auctionId, packedAuction);
					if ((not filterFunc) or filterFunc(auction, filterArg)) then
						table.insert(matchingAuctions, auction);
					end
				else
					debugPrint("WARNING: AuctionIdsForItemKey table corrupted!");
				end
			end
		end
	end
	return matchingAuctions;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function queryWithItemKey(itemKey, ahKey, filterFunc, filterArg)
	-- Use the default auction house for the zone if none was provided.
	ahKey = ahKey or Auctioneer.Util.GetAuctionKey();

	-- Iterate over the list of auctions and find the matching ones.
	local matchingAuctions = {};
	local ah = getAHDatabase(ahKey, true);
	local auctionIdsForItemKey = getAuctionIdsForItemKey(ah, itemKey, false);
	if (auctionIdsForItemKey) then
		for _, auctionId in ipairs(auctionIdsForItemKey) do
			local packedAuction = ah.auctions[auctionId];
			if (packedAuction) then
				local auction = unpackAuction(ahKey, auctionId, packedAuction);
				if ((not filterFunc) or filterFunc(auction, filterArg)) then
					table.insert(matchingAuctions, auction);
				end
			else
				debugPrint("WARNING: AuctionIdsForItemKey table corrupted!");
			end
		end
	end
	return matchingAuctions;
end

-------------------------------------------------------------------------------
-- Gets a list of auction ids for auctions of the specified item.
-------------------------------------------------------------------------------
function getAuctionsForItem(itemKey, ahKey)
	return queryWithItemKey(itemKey, ahKey);
end

-------------------------------------------------------------------------------
-- Gets an auction (unpacked) from the snapshot.
-------------------------------------------------------------------------------
function getAuctionById(ahKey, auctionId)
	-- Use the default auction house for the zone if none was provided.
	ahKey = ahKey or Auctioneer.Util.GetAuctionKey();
	local ah = getAHDatabase(ahKey, true);

	-- Lookup the auction for the corresponding id.
	if (auctionId) then
		local packedAuction = ah.auctions[auctionId];
		if (packedAuction) then
			return unpackAuction(ahKey, auctionId, packedAuction);
		end
	end
end

-------------------------------------------------------------------------------
-- Returns the current bid, or if none, the min bid.
-------------------------------------------------------------------------------
function getCurrentBid(auction)
	if (auction.bidAmount and auction.bidAmount > 0) then
		return auction.bidAmount;
	else
		return auction.minBid;
	end
end
-------------------------------------------------------------------------------
-- Checks if the specified item matches the query.
-------------------------------------------------------------------------------
function doesItemKeyMatchQuery(itemKey, query)
	-- Get the information about the item.
	local itemInfo = Auctioneer.ItemDB.GetItemInfo(itemKey);
	if (not itemInfo) then
		debugPrint("WARNING: Unable to get item info for itemKey "..itemKey);
		return false;
	end

	-- Check if the item info matches the query constraints.
	if (query.name and not Auctioneer.Database.DoesNameMatch(itemInfo.name, query.name, false)) then return false end;
	if (query.minLevel and itemInfo.useLevel < query.minLevel) then return false end;
	if (query.maxLevel and itemInfo.useLevel > query.maxLevel) then return false end;
	if (query.qualityIndex and itemInfo.quality < query.qualityIndex) then return false end;

	-- Check the inventory type, sub class and class.
	if (query.classIndex and
		itemInfo.categoryName ~= Auctioneer.ItemDB.GetCategoryName(query.classIndex)) then return false end;
	if (query.subclassIndex and
		itemInfo.subCategoryName ~= Auctioneer.ItemDB.GetSubCategoryName(query.classIndex, query.subclassIndex)) then return false end;
	if (query.invTypeIndex and
		itemInfo.inventoryTypeName ~= Auctioneer.ItemDB.GetInventoryTypeName(query.classIndex, query.subclassIndex, query.invTypeIndex)) then return false end;

	-- %todo: Check if its usable...

	return true;
end

-------------------------------------------------------------------------------
-- Reconciles auctions in an update against auctions in the snapshot.
-------------------------------------------------------------------------------
function reconcileAuctionsForSignature(ah, auctionSignature, auctionsInUpdate, auctionsInSnapshot, partial)
	debugPrint("Reconcling auctions: "..auctionSignature.." ("..table.getn(auctionsInUpdate).." in update; "..table.getn(auctionsInSnapshot).." in snapshot)");

	-- Sort the auctions in the update by time left and bid amount.
	table.sort(
		auctionsInUpdate,
		function(a, b)
			if (a.dup == b.dup) then
				if (a.timeLeft == b.timeLeft) then
					return (a.bidAmount < b.bidAmount);
				end
				return (a.timeLeft < b.timeLeft);
			end
			return (not a.dup)
		end);

	-- Sort the auctions in the snapshot by expiration time and bid amount.
	table.sort(
		auctionsInSnapshot,
		function(a, b)
			if (a.expiration == b.expiration) then
				return (a.bidAmount < b.bidAmount);
			end
			return (a.expiration < b.expiration);
		end);

	-- Reconcile each auction in the update against the auctions in the snapshot.
	for _, auctionInUpdate in ipairs(auctionsInUpdate) do
		-- Ignore invalid auctions so we can keep the database clean.
		if (Auctioneer.QueryManager.IsAuctionValid(auctionInUpdate)) then
			reconcileAuction(ah, auctionInUpdate, auctionsInSnapshot);
		else
			debugPrint("reconcileAuctionsForSignature() - ignoring invalid auction");
		end
	end

	-- Remove any auctions that remain in the snapshot list.
	if (not partial) then
		for _, auctionInSnapshot in ipairs(auctionsInSnapshot) do
			removeAuctionFromSnapshot(ah, auctionInSnapshot);
		end
		auctionInSnapshot = {};
	end
end

-------------------------------------------------------------------------------
-- Reconciles an auction against the snapshot. If the auction is matched with
-- an auction in the snapshot auction list, the snapshot auction is removed
-- from the list.
-------------------------------------------------------------------------------
function reconcileAuction(ah, auctionInUpdate, auctionsInSnapshot)
	local bestSnapshotMatchIndex;
	for auctionInSnapshotIndex, auctionInSnapshot in ipairs(auctionsInSnapshot) do
		-- The bid amount of the updated auction must be greater than or equal to the bid
		-- amount of the snapshot auction in order to match.
		if (auctionInUpdate.bidAmount >= auctionInSnapshot.bidAmount) then
			-- Calculate the maximum number of times the auction could have been bidded.
			local maxBids = getMaxBids(auctionInSnapshot, auctionInUpdate);

			-- Calculate the maximum and minimum time left for the snapshot
			-- auction based on the update auction.
			local timeElapsed = auctionInUpdate.lastSeen - auctionInSnapshot.lastSeen;
			local minTimeLeft = getTimeLeft(TimeLeftInSeconds[auctionInSnapshot.timeLeft - 1] - timeElapsed);
			local timeUntilExpiration = auctionInSnapshot.expiration - auctionInSnapshot.lastSeen;
			local maxTimeLeft = getTimeLeft(timeUntilExpiration - timeElapsed + (300 * maxBids));
			debugPrint("timeUntilExpiration", timeUntilExpiration, "timeElapsed", timeElapsed, "minTimeLeft", minTimeLeft, "timeLeft", auctionInUpdate.timeLeft, "maxTimeLeft", maxTimeLeft);

			-- Check if we have a possible match based on time left.
			if (minTimeLeft <= auctionInUpdate.timeLeft and auctionInUpdate.timeLeft <= maxTimeLeft) then
				-- Yep, check for an exact match. We always prefer exact matches
				-- inexact matches.
				if (auctionInUpdate.auctionId and auctionInUpdate.auctionId == auctionInSnapshot.auctionId) then
					bestSnapshotMatchIndex = auctionInSnapshotIndex;
					debugPrint("Found an exact match (AuctionId)!");
					break;
				elseif ((not auctionInUpdate.auctionId) and auctionInUpdate.bidAmount == auctionInSnapshot.bidAmount) then
					bestSnapshotMatchIndex = auctionInSnapshotIndex;
					debugPrint("Found an exact match (BidAmount)!");
					break;
				end

				-- No exact match, but is it a better match than what we have already?
				if (not bestSnapshotMatchIndex) then
					debugPrint("Found inexact match!");
					bestSnapshotMatchIndex = auctionInSnapshotIndex
				else
					-- If this snapshot auction has a lower bid amount than the one
					-- we already matched, use this one instead.
					bestSnapshotMatch = auctionsInSnapshot[bestSnapshotMatchIndex];
					if (auctionInSnapshot.bidAmount < bestSnapshotMatch.bidAmount) then
						debugPrint("Found better inexact match!");
						bestSnapshotMatchIndex = auctionInSnapshotIndex;
					end
				end
			else
				debugPrint("No match due to time left");
			end
		else
			debugPrint("No match due to bid amount");
		end
	end

	-- If we found a match, update the auction. Otherwise add a new auction to the snapshot.
	if (bestSnapshotMatchIndex) then
		updateAuctionInSnapshot(ah, auctionsInSnapshot[bestSnapshotMatchIndex], auctionInUpdate);
		table.remove(auctionsInSnapshot, bestSnapshotMatchIndex);
	elseif (not auctionInUpdate.dup) then
		addAuctionToSnapshot(ah, auctionInUpdate);
	else
		debugPrint("Omitting auction from snapshot because it might be a dup");
	end
end

-------------------------------------------------------------------------------
-- Converts from seconds to timeLeft (0 to 4)
-------------------------------------------------------------------------------
function getTimeLeft(seconds)
	for timeLeft = 0, 3 do
		if (seconds <= TimeLeftInSeconds[timeLeft]) then
			return timeLeft;
		end
	end
	return 4;
end

-------------------------------------------------------------------------------
-- Calculates the number of times an auction could have been bidded.
-------------------------------------------------------------------------------
function getMaxBids(auctionInSnapshot, auctionInUpdate)
	-- %todo: The speed of this calculation could be improved?
	local maxBids = 0;
	if (auctionInSnapshot.bidAmount ~= auctionInUpdate.bidAmount) then
		local bidAmount = auctionInSnapshot.bidAmount;
		if (bidAmount == 0) then
			bidAmount = auctionInSnapshot.minBid;
			maxBids = 1;
		end
		while (bidAmount < auctionInUpdate.bidAmount) do
			bidAmount = bidAmount * 1.05;
			maxBids = maxBids + 1;
		end
	end
	--debugPrint("Calculated maxBids to be "..maxBids);
	return maxBids;
end

-------------------------------------------------------------------------------
-- Gets the next auction id.
-------------------------------------------------------------------------------
function getNextAuctionId(ah)
	local auctionId = ah.nextAuctionId;
	ah.nextAuctionId = auctionId + 1;
	return auctionId;
end

-------------------------------------------------------------------------------
-- Gets the auctionId table for the specified itemKey from the database.
-------------------------------------------------------------------------------
function getAuctionIdsForItemKey(ah, itemKey, create)
	local auctionIdsForItemKey = ah.auctionIdsByItemKey[itemKey];
	if ((not auctionIdsForItemKey) and create) then
		debugPrint("Creating auctionIdsForItemKey["..itemKey.."]");
		auctionIdsForItemKey = {};
		ah.auctionIdsByItemKey[itemKey] = auctionIdsForItemKey;
	end
	return auctionIdsForItemKey;
end

-------------------------------------------------------------------------------
-- Adds the specified auction to the snapshot.
-------------------------------------------------------------------------------
function addAuctionToSnapshot(ah, auction)
	-- Add the auction.
	auction.auctionId = getNextAuctionId(ah);
	auction.expiration = auction.lastSeen + TimeLeftInSeconds[auction.timeLeft];
	local packedAuction = packAuction(auction);
	ah.auctions[auction.auctionId] = packedAuction;

	-- Add the auction id to the itemKey index table.
	local itemKey = Auctioneer.ItemDB.CreateItemKeyFromAuction(auction);
	local auctionIdsForItemKey = getAuctionIdsForItemKey(ah, itemKey, true);
	table.insert(auctionIdsForItemKey, auction.auctionId);

	-- Fire the auction added event.
	debugPrint("Added auction "..auction.auctionId.. ": "..packedAuction);
	Auctioneer.EventManager.FireEvent("AUCTIONEER_AUCTION_ADDED", auction);
end

-------------------------------------------------------------------------------
-- Updates the specified auction in the snapshot.
-------------------------------------------------------------------------------
function updateAuctionInSnapshot(ah, oldAuction, newAuction)
	-- Update the auction.
	newAuction.auctionId = oldAuction.auctionId;
	if (newAuction.timeLeft == oldAuction.timeLeft and newAuction.bidAmount == oldAuction.bidAmount) then
		-- Add 5 minutes to the expiration for each possible bid.
		local maxAddedTime = getMaxBids(oldAuction, newAuction) * 300;
		newAuction.expiration = oldAuction.expiration + maxAddedTime;
		-- Check that we didn't add too much time.
		if (TimeLeftInSeconds[newAuction.timeLeft] < (newAuction.expiration - newAuction.lastSeen)) then
			newAuction.expiration = newAuction.lastSeen + TimeLeftInSeconds[newAuction.timeLeft];
		end
	else
		-- TimeLeft has changed, so just use the timeLeft to calculate the
		-- estimated expiration.
		newAuction.expiration = newAuction.lastSeen + TimeLeftInSeconds[newAuction.timeLeft];
	end
	local packedAuction = packAuction(newAuction);
	ah.auctions[newAuction.auctionId] = packedAuction;

	-- Fire the auction updated event if the bidAmount or timeLeft changed.
	if (newAuction.bidAmount ~= oldAuction.bidAmount or
		newAuction.highBidder ~= oldAuction.highBidder or
		newAuction.timeLeft ~= oldAuction.timeLeft) then
		debugPrint("Updated auction "..newAuction.auctionId.. ": "..packedAuction);
		Auctioneer.EventManager.FireEvent("AUCTIONEER_AUCTION_UPDATED", newAuction, oldAuction);
	else
		debugPrint("Unchanged auction "..newAuction.auctionId.. ": "..packedAuction);
	end
end

-------------------------------------------------------------------------------
-- Removes the specified auction from the snapshot.
-------------------------------------------------------------------------------
function removeAuctionFromSnapshot(ah, auction)
	-- Remove the auction.
	ah.auctions[auction.auctionId] = nil;

	-- Remove the auction id from the itemKey index table.
	local itemKey = Auctioneer.ItemDB.CreateItemKeyFromAuction(auction);
	local auctionIdsForItemKey = getAuctionIdsForItemKey(ah, itemKey, false);
	if (auctionIdsForItemKey) then
		for index, auctionId in ipairs(auctionIdsForItemKey) do
			if (auctionId == auction.auctionId) then
				table.remove(auctionIdsForItemKey, index);
				break;
			end
		end
	end

	-- Fire the auction removed event.
	debugPrint("Removed auction "..auction.auctionId.. ": "..packAuction(auction));
	Auctioneer.EventManager.FireEvent("AUCTIONEER_AUCTION_REMOVED", auction);
end

-------------------------------------------------------------------------------
-- Converts an auction into a ';' delimited string.
-------------------------------------------------------------------------------
function packAuction(auction)
	return Auctioneer.Database.PackRecord(auction, AuctionMetaData);
end

-------------------------------------------------------------------------------
-- Converts a ';' delimited string into an auction using the AuctionMetaData
-- table.
-------------------------------------------------------------------------------
function unpackAuction(ahKey, auctionId, packedAuction)
	local auction = Auctioneer.Database.UnpackRecord(packedAuction, AuctionMetaData);
	auction.ahKey = ahKey;
	auction.auctionId = auctionId;
	return auction;
end

-------------------------------------------------------------------------------
-- Checks if an auction is valid.
-------------------------------------------------------------------------------
function isValidAuction(auction)
	return (
		auction.itemId and auction.suffixId and	auction.enchantId and
		auction.uniqueId and auction.count and auction.minBid and
		auction.owner and auction.timeLeft
	)
end

-------------------------------------------------------------------------------
-- Creates an auction signature (itemId:suffixId:enchantId:uniqueId:count:minBid:buyoutPrice:owner)
-------------------------------------------------------------------------------
function createAuctionSignatureFromAuction(auction)
	return
		auction.itemId..":"..auction.suffixId..":"..auction.enchantId..":"..
		auction.uniqueId..":"..auction.count..":"..auction.minBid..":"..
		auction.buyoutPrice..":"..auction.owner;
end

-------------------------------------------------------------------------------
-- Breaks an auction signature (itemId:suffixId:enchantId:uniqueId:count:minBid:buyoutPrice:owner)
-------------------------------------------------------------------------------
function breakAuctionSignature(auctionSignature)
	_, _, itemId, suffixId, enchantId, uniqueId, count, minBid, buyoutPrice, owner = string.find(auctionSignature, "(.+):(.+):(.+):(.+):(.+):(.+):(.+):(.+)");
	return tonumber(itemId), tonumber(suffixId), tonumber(enchantId), tonumber(uniqueId), tonumber(count), tonumber(minBid), tonumber(buyoutPrice), owner;
end

-------------------------------------------------------------------------------
-- Creates an item key from an auction signature (itemId:suffixId:enchantId)
-------------------------------------------------------------------------------
function createItemKeyFromAuctionSignature(auctionSignature)
	local itemId, suffixId, enchantId = breakAuctionSignature(auctionSignature);
	return Auctioneer.ItemDB.CreateItemKey(itemId, suffixId, enchantId);
end

--=============================================================================
-- Update history methods.
--=============================================================================

-------------------------------------------------------------------------------
-- Adds an update and removes any updates that are a subset.
-------------------------------------------------------------------------------
function addUpdate(ah, query)
	-- First remove updates that are a subset of this query.
	removeSubsetUpdates(ah, query);

	-- Add the new update to the end of the table.
	local update = createUpdateFromQuery(query);
	update.date = time();
	table.insert(ah.updates, packUpdate(update));
	debugPrint("Added update at index "..table.getn(ah.updates));
end

-------------------------------------------------------------------------------
-- Removes updates that are a subset of the specified query.
-------------------------------------------------------------------------------
function removeSubsetUpdates(ah, query)
	-- Remove the old updates that are a subset of the new update.
	local update = createUpdateFromQuery(query);
	for index = table.getn(ah.updates), 1, -1 do
		local updateAtIndex = unpackUpdate(ah.updates[index]);
		if (updateAtIndex.date + (24 * 60 * 60) < time()) then
			debugPrint("Removed update at index "..index.." (age)");
			table.remove(ah.updates, index);
		elseif (isUpdateSubsetOfUpdate(updateAtIndex, update)) then
			debugPrint("Removed update at index "..index.." (subset)");
			table.remove(ah.updates, index);
		end
	end
end

-------------------------------------------------------------------------------
-- Gets the time of the last update for the specified query.
-------------------------------------------------------------------------------
function getLastUpdate(ahKey, query)
	-- Use the default auction house for the zone if none was provided.
	ahKey = ahKey or Auctioneer.Util.GetAuctionKey();
	local ah = getAHDatabase(ahKey, true);

	-- Look for the last update for which the query is a subset.
	local update = createUpdateFromQuery(query);
	for index = table.getn(ah.updates), 1, -1 do
		local updateAtIndex = unpackUpdate(ah.updates[index]);
		if (isUpdateSubsetOfUpdate(update, updateAtIndex)) then
			return updateAtIndex.date;
		end
	end

	return 0;
end

-------------------------------------------------------------------------------
-- Checks if one update is a subset of another update.
-------------------------------------------------------------------------------
function isUpdateSubsetOfUpdate(subset, set)
	-- Check the name.
	if (set.name ~= "" and not Auctioneer.Database.DoesNameMatch(subset.name, set.name, false)) then
		return false;
	end

	-- Check the min level.
	if (set.minLevel ~= 0 and set.minLevel > subset.minLevel) then
		return false;
	end

	-- Check the max level.
	if (set.maxLevel ~= 0 and set.maxLevel < subset.maxLevel) then
		return false;
	end

	-- Check the classIndex index.
	if (set.classIndex ~= 0 and set.classIndex ~= subset.classIndex) then
		return false;
	end

	-- Check the subclass index.
	if (set.subclassIndex ~= 0 and set.subclassIndex ~= subset.subclassIndex) then
		return false;
	end

	-- Check the invTypeIndex index.
	if (set.invTypeIndex ~= 0 and set.invTypeIndex ~= subset.invTypeIndex) then
		return false;
	end

	-- Check the quality.
	if (set.qualityIndex ~= 0 and set.qualityIndex > subset.qualityIndex) then
		return false;
	end

	-- If we make it this far then it subset really is a subset.
	return true;
end

-------------------------------------------------------------------------------
-- Creates an update record from a query.
-------------------------------------------------------------------------------
function createUpdateFromQuery(query)
	-- Create the new update.
	return {
		name = query.name or "";
		minLevel = query.minLevel or 0;
		maxLevel = query.maxLevel or 0;;
		invTypeIndex = query.invTypeIndex or 0;
		classIndex = query.classIndex or 0;
		subclassIndex = query.subclassIndex or 0;
		qualityIndex = query.qualityIndex or 0;
	};
end

-------------------------------------------------------------------------------
-- Converts an update into a ';' delimited string.
-------------------------------------------------------------------------------
function packUpdate(update)
	return Auctioneer.Database.PackRecord(update, UpdateMetaData);
end

-------------------------------------------------------------------------------
-- Converts a ';' delimited string into an auction using the AuctionMetaData
-- table.
-------------------------------------------------------------------------------
function unpackUpdate(packedUpdate)
	return Auctioneer.Database.UnpackRecord(packedUpdate, UpdateMetaData);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function debugPrint(...)
	EnhTooltip.DebugPrint("[Auc.SnapshotDB]", unpack(arg));
end

--=============================================================================
-- Initialization
--=============================================================================
if (Auctioneer.SnapshotDB) then return end;
debugPrint("AucSnapshotDB.lua loaded");

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
Auctioneer.SnapshotDB = {
	Load = load;
	Clear = clear;
	UpdateForQuery = updateForQuery;
	UpdateForSignature = updateForSignature;
	UpdateAuction = updateAuction;
	AddAuction = addAuction;
	RemoveAuction = removeAuction;
	Query = query;
	QueryWithItemKey = queryWithItemKey;
	DoesItemKeyMatchQuery = doesItemKeyMatchQuery;
	GetAuctionsForItem = getAuctionsForItem;
	GetAuctionById = getAuctionById;
	GetCurrentBid = getCurrentBid;
	CreateAuctionSignatureFromAuction = createAuctionSignatureFromAuction;
	GetLastUpdate = getLastUpdate;
}

-------------------------------------------------------------------------------
-- Create an empty database to use before any upgrading is performed.
-------------------------------------------------------------------------------
AuctioneerSnapshotDB = createDatabase();
LoadedSnapshotDB = AuctioneerSnapshotDB;
