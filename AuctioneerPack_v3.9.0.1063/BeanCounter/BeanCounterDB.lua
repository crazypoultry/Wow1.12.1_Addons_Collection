--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.9.0.1056 (Kangaroo)
	Revision: $Id: BeanCounterDB.lua 843 2006-04-24 02:09:14Z vindicator $

	BeanCounterDB - BeanCounter database functions

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
-- Global Data Members
-------------------------------------------------------------------------------
BeanCounterAccountDB = {};	-- Database on disk
BeanCounterRealmDB = nil; 	-- Currently loaded database (reference to BeanCounterAccountDB[realm])

-------------------------------------------------------------------------------
-- Local Data Members
-------------------------------------------------------------------------------
local currentPlayerId = nil;

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------
local NIL_VALUE = "<nil>";
local CURRENT_DATABASE_VERSION = 30002;

-------------------------------------------------------------------------------
-- Function Prototypes
-------------------------------------------------------------------------------
local loadDatabase;
local upgradeDatabase;
local upgradePurchases30000To30001;
local upgradePurchases30001To30002;
local upgradeSales30000To30002;
local clearDatabase;
local getPlayerName;
local getPlayerId;
local getCurrentPlayerId;
local copyItemRecords;
local stringFromBoolean;
local booleanFromString;
local stringFromNumber;
local numberFromString;
local nilSafeStringFromString;
local stringFromNilSafeString;
local debugPrint;

-------------------------------------------------------------------------------
-- Loads the BeanCounter database
-------------------------------------------------------------------------------
function loadDatabase(realm)
	-- Load or create the database.
	BeanCounterRealmDB = BeanCounterAccountDB[realm];
	if (BeanCounterRealmDB == nil) then
		-- Create a new database.
		BeanCounterRealmDB = {};
		BeanCounterAccountDB[realm] = BeanCounterRealmDB;
		clearDatabase();

		-- Import the old AHPurchases and AHSales tables if we are loading
		-- this realm's database.
		if (realm == GetRealmName() and (AHPurchases or AHSales)) then
			-- Import AHPurchases.
			if (AHPurchases) then
				upgradePurchases30000To30001(AHPurchases);
				upgradePurchases30001To30002(AHPurchases, BeanCounterRealmDB.players);
				copyItemRecords(AHPurchases.PendingBids, BeanCounterRealmDB.pendingBids);
				copyItemRecords(AHPurchases.CompletedBids, BeanCounterRealmDB.completedBids);
				copyItemRecords(AHPurchases.Purchases, BeanCounterRealmDB.purchases);
				AHPurchases = nil;
			end

			-- Import AHSales.
			if (AHSales) then
				upgradeSales30000To30002(AHSales, BeanCounterRealmDB.players);
				copyItemRecords(AHSales.PendingAuctions, BeanCounterRealmDB.pendingAuctions);
				copyItemRecords(AHSales.CompletedAuctions, BeanCounterRealmDB.completedAuctions);
				copyItemRecords(AHSales.Sales, BeanCounterRealmDB.sales);
				AHSales = nil;
			end
		end
	end
	
	-- Upgrade the database before returning.
	upgradeDatabase(BeanCounterRealmDB);

	-- Cache the current player id.
	currentPlayerId = getPlayerId(UnitName("player"), true);
end

-------------------------------------------------------------------------------
-- Upgrades the BeanCounter database.
-------------------------------------------------------------------------------
function upgradeDatabase(database)
end

-------------------------------------------------------------------------------
-- Upgrades the AHPurchases table from version 30000 to 30001. This upgrade
-- added a timeLeft field to the pending bids.
-------------------------------------------------------------------------------
function upgradePurchases30000To30001(purchases)
	if (purchases.version == 30000) then
		if (purchases.PendingBids) then
			for item in purchases.PendingBids do
				local pendingBidsTable = purchases.PendingBids[item];
				for index in pendingBidsTable do
					pendingBidsTable[index] = pendingBidsTable[index]..";1"
					debugPrint("Upgraded AHPurchases.PendingBids["..item.."]["..index.."] = "..pendingBidsTable[index]);
				end
			end
		end
		purchases.version = 30001;
		debugPrint("AHPurchases upgraded to 30001");
	end
end

-------------------------------------------------------------------------------
-- Upgrades the AHPurchases table from version 30001 to 30002. This upgrade
-- added a buyer id field to the tables.
-------------------------------------------------------------------------------
function upgradePurchases30001To30002(database, players)
	if (database.version == 30001) then
		-- Get or create a player id
		local playerId = nil;
		local playerName = UnitName("player");
		for id in players do
			if (players[id] == playerName) then
				playerId = id;
				break;
			end
		end
		if (playerId == nil) then
			table.insert(players, playerName);
			playerId = table.getn(players);
		end
		
		-- Add the player id to each pending bid.
		if (database.PendingBids) then
			for item in database.PendingBids do
				local pendingBidsTable = database.PendingBids[item];
				for index in pendingBidsTable do
					pendingBidsTable[index] = pendingBidsTable[index]..";"..stringFromNumber(playerId);
					debugPrint("Upgraded pendingBids["..item.."]["..index.."] = "..pendingBidsTable[index]);
				end
			end
		end

		-- Add the player id to each completed bid.
		if (database.CompletedBids) then
			for item in database.CompletedBids do
				local completedBidsTable = database.CompletedBids[item];
				for index in completedBidsTable do
					completedBidsTable[index] = completedBidsTable[index]..";"..stringFromNumber(playerId);
					debugPrint("Upgraded completedBids["..item.."]["..index.."] = "..completedBidsTable[index]);
				end
			end
		end

		-- Add the player id to each purchase.
		if (database.Purchases) then
			for item in database.Purchases do
				local purchasesTable = database.Purchases[item];
				for index in purchasesTable do
					purchasesTable[index] = purchasesTable[index]..";"..stringFromNumber(playerId);
					debugPrint("Upgraded purchases["..item.."]["..index.."] = "..purchasesTable[index]);
				end
			end
		end

		database.version = 30002;
		debugPrint("AHPurchases upgraded to 30002");
	end
end

-------------------------------------------------------------------------------
-- Upgrades the AHSales table from version 30000 to 30002. This upgrade added
-- a seller id field to the tables.
-------------------------------------------------------------------------------
function upgradeSales30000To30002(database, players)
	if (database.version == 30000) then
		-- Get or create a player id
		local playerId = nil;
		local playerName = UnitName("player");
		for id in players do
			if (players[id] == playerName) then
				playerId = id;
				break;
			end
		end
		if (playerId == nil) then
			table.insert(players, playerName);
			playerId = table.getn(players);
		end
		
		-- Add the player id to each pending auction.
		if (database.PendingAuctions) then
			for item in database.PendingAuctions do
				local pendingAuctionsTable = database.PendingAuctions[item];
				for index in pendingAuctionsTable do
					pendingAuctionsTable[index] = pendingAuctionsTable[index]..";"..stringFromNumber(playerId);
					debugPrint("Upgraded pendingAuctions["..item.."]["..index.."] = "..pendingAuctionsTable[index]);
				end
			end
		end

		-- Add the player id to each completed auction.
		if (database.CompletedAuctions) then
			for item in database.CompletedAuctions do
				local completedAuctionsTable = database.CompletedAuctions[item];
				for index in completedAuctionsTable do
					completedAuctionsTable[index] = completedAuctionsTable[index]..";"..stringFromNumber(playerId);
					debugPrint("Upgraded completedAuctions["..item.."]["..index.."] = "..completedAuctionsTable[index]);
				end
			end
		end

		-- Add the player id to each sale.
		if (database.Sales) then
			for item in database.Sales do
				local salesTable = database.Sales[item];
				for index in salesTable do
					salesTable[index] = salesTable[index]..";"..stringFromNumber(playerId);
					debugPrint("Upgraded sales["..item.."]["..index.."] = "..salesTable[index]);
				end
			end
		end
		
		database.version = 30002;
		debugPrint("AHSales upgraded to 30002");
	end
end

-------------------------------------------------------------------------------
-- Clears the database
-------------------------------------------------------------------------------
function clearDatabase()
	BeanCounterRealmDB.version = CURRENT_DATABASE_VERSION;
	BeanCounterRealmDB.players = {};
	BeanCounterRealmDB.pendingBids = {};
	BeanCounterRealmDB.completedBids = {};
	BeanCounterRealmDB.purchases = {};
	BeanCounterRealmDB.pendingAuctions = {};
	BeanCounterRealmDB.completedAuctions = {};
	BeanCounterRealmDB.sales = {};
	debugPrint("Reset Database");
end

-------------------------------------------------------------------------------
-- Gets a player's name
-------------------------------------------------------------------------------
function getPlayerName(id)
	if (id ~= nil and id <= table.getn(BeanCounterRealmDB.players)) then
		return BeanCounterRealmDB.players[id];
	end
	return "Unknown Player";
end

-------------------------------------------------------------------------------
-- Gets a player's id
-------------------------------------------------------------------------------
function getPlayerId(name, create)
	if (name ~= nil) then
		for id in BeanCounterRealmDB.players do
			if (BeanCounterRealmDB.players[id] == name) then
				return id;
			end
		end
		if (create) then
			debugPrint("Adding player "..name.." to the database");
			table.insert(BeanCounterRealmDB.players, name);
			return table.getn(BeanCounterRealmDB.players);
		end
	end
	return nil;
end

-------------------------------------------------------------------------------
-- Gets the current player's id
-------------------------------------------------------------------------------
function getCurrentPlayerId()
	return currentPlayerId;
end

-------------------------------------------------------------------------------
-- Copies the item records from one table to another.
-------------------------------------------------------------------------------
function copyItemRecords(source, destination)
	if (source and destination) then
		for item in source do
			-- Get the source item table.
			sourceItems = source[item];
			if (table.getn(sourceItems) > 0) then
				-- Get or create the destination item table.
				destinationItems = destination[item];
				if (destinationItems == nil) then
					destinationItems = {};
					destination[item] = destinationItems;
				end

				-- Copy from the source to the destination table.			
				for index in sourceItems do
					table.insert(destinationItems, sourceItems[index]);
				end
			end
		end
	end
end

-------------------------------------------------------------------------------
-- Converts boolean into a numeric string.
-------------------------------------------------------------------------------
function stringFromBoolean(boolean)
	if (boolean == nil) then
		return NIL_VALUE;
	elseif (boolean) then
		return "1";
	end
	return "0";
end

-------------------------------------------------------------------------------
-- Converts a numeric string into a boolean.
-------------------------------------------------------------------------------
function booleanFromString(string)
	if (string == NIL_VALUE) then
		return nil;
	elseif (string == "0") then
		return false;
	end
	return true;
end

-------------------------------------------------------------------------------
-- Converts number into a numeric string.
-------------------------------------------------------------------------------
function stringFromNumber(number)
	if (number == nil) then
		return NIL_VALUE;
	end
	return tostring(number);
end

-------------------------------------------------------------------------------
-- Converts numeric string into a number.
-------------------------------------------------------------------------------
function numberFromString(number)
	if (number == NIL_VALUE) then
		return nil;
	end
	return tonumber(number);
end

-------------------------------------------------------------------------------
-- Converts a string into a nil safe string (nil -> "<nil>")
-------------------------------------------------------------------------------
function nilSafeStringFromString(string)
	if (string == nil) then
		return NIL_VALUE;
	end
	return string;
end

-------------------------------------------------------------------------------
-- Converts a nil safe string into a string ("<nil>" -> nil)
-------------------------------------------------------------------------------
function stringFromNilSafeString(nilSafeString)
	if (nilSafeString == NIL_VALUE) then
		return nil;
	end
	return nilSafeString;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function debugPrint(message)
	BeanCounter.DebugPrint("[BeanCounter.Database] "..message);
end

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
BeanCounter.Database = 
{
	Load = loadDatabase;
	Clear = clearDatabase;
	GetPlayerName = getPlayerName;
	GetPlayerId = getPlayerId;
	GetCurrentPlayerId = getCurrentPlayerId;
	StringFromBoolean = stringFromBoolean;
	BooleanFromString = booleanFromString;
	StringFromNumber = stringFromNumber;
	NumberFromString = numberFromString;
	NilSafeStringFromString = nilSafeStringFromString;
	StringFromNilSafeString = stringFromNilSafeString;
};