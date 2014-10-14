--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: <%version%> (<%codename%>)
	Revision: $Id: AucFixedPriceDB.lua 1031 2006-10-04 04:15:38Z mentalpower $

	FixedPriceDB - database of player prices

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

local stringFromNumber = Auctioneer.Database.StringFromNumber;

-------------------------------------------------------------------------------
-- Function Prototypes
-------------------------------------------------------------------------------
local load;

local loadDatabase;
local createDatabase;
local createDatabaseFrom3x;
local createAHDatabase;
local upgradeAHDatabase;
local getAHDatabase;

local getFixedPrice;
local setFixedPrice;
local removeFixedPrice;

local debugPrint;

-------------------------------------------------------------------------------
-- Data Members
-------------------------------------------------------------------------------

-- The Auctioneer price database saved on disk. Nobody should access this
-- variable outside of the loadDatabase() method. Instead the LoadedFixedPriceDB
-- variable should be used.
AuctioneerFixedPriceDB = nil;

-- The current Auctioneer price database as determined in the load() method.
-- This is either the database on disk or a temporary database if the user
-- chose not to upgrade their database.
local LoadedFixedPriceDB;

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

-- The version of the price database first released in Auctioneer 4.0. This
-- number should NEVER change. Upgrades from Auctioneer 3.x are first upgraded
-- to this version of the database.
local BASE_FIXEDPRICEDB_VERSION = 1;

-- The current version of the price database. This number must be incremented
-- anytime a change is made to the database schema.
local CURRENT_FIXEDPRICEDB_VERSION = 1;

-- Schema for records in the fixedPrices table of the price database.
local FixedPriceMetaData = {
	{
		fieldName = "bid";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "buyout";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "count";
		fromStringFunc = tonumber;
		toStringFunc = stringFromNumber;
	},
	{
		fieldName = "duration";
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
		debugPrint("Using temporary AuctioneerFixedPriceDB");
		LoadedFixedPriceDB = createDatabase();
	end
end

--=============================================================================
-- Database management functions
--=============================================================================

-------------------------------------------------------------------------------
-- Loads and upgrades the AuctioneerFixedPriceDB database. If the table does not
-- exist it creates a new one.
-------------------------------------------------------------------------------
function loadDatabase()
	-- If the Auctioneer database is older than 4.0, upgrade to 4.0 first.
	if (AuctionConfig.version < 40000) then
		debugPrint("Creating AuctioneerFixedPriceDB database from 3.x AuctionConfig");
		AuctioneerFixedPriceDB = createDatabaseFrom3x();
	end

	-- Ensure that AuctioneerFixedPriceDB exists.
	if (not AuctioneerFixedPriceDB) then
		debugPrint("Creating new AuctioneerFixedPriceDB database");
		AuctioneerFixedPriceDB = createDatabase();
	end

	-- Upgrade each realm-faction database (if needed).
	for ahKey in pairs(AuctioneerFixedPriceDB) do
		if (not upgradeAHDatabase(AuctioneerFixedPriceDB[ahKey], CURRENT_FIXEDPRICEDB_VERSION)) then
			debugPrint("WARNING: Price database corrupted for "..ahKey.."! Creating new database.");
			AuctioneerFixedPriceDB[ahKey] = createAHDatabase(ahKey);
		end
	end

	-- Make AuctioneerFixedPriceDB the loaded database!
	LoadedFixedPriceDB = AuctioneerFixedPriceDB;
end

-------------------------------------------------------------------------------
-- Creates a new database.
-------------------------------------------------------------------------------
function createDatabase()
	return {};
end

-------------------------------------------------------------------------------
-- Creates a new database from a Auctioneer 3.x AuctionConfig table.
-------------------------------------------------------------------------------
function createDatabaseFrom3x()
	local db = {};
	if (AuctionConfig.fixedprice) then
		for ahKey, ahData in pairs(AuctionConfig.fixedprice) do
			local newAhKey = string.lower(ahKey);
			local ah = createAHDatabase(newAhKey, BASE_FIXEDPRICEDB_VERSION);
			db[newAhKey] = ah;
			for itemKey, itemData in pairs(ahData) do
				ah.fixedPrices[itemKey] = string.gsub (itemData, ":", ";");
			end
		end
	end
	return db;
end

-------------------------------------------------------------------------------
-- Create a new table for the specified auction house key (realm-faction).
-------------------------------------------------------------------------------
function createAHDatabase(ahKey, version)
	-- If no version was specified, assume the current version.
	version = version or CURRENT_FIXEDPRICEDB_VERSION;

	-- Create the original version of the database.
	local ah = {};
	ah.version = BASE_FIXEDPRICEDB_VERSION;
	ah.ahKey = ahKey;
	ah.fixedPrices = {};

	-- Upgrade the table to the requested version of auctioneer.
	if (ah.version ~= version) then
		upgradeAHDatabase(ah, version);
	end

	return ah;
end

-------------------------------------------------------------------------------
-- Upgrades the specified AH database. Returns true if the database was
-- upgraded successfully.
-------------------------------------------------------------------------------
function upgradeAHDatabase(ah, version)
	-- Check that we have a valid database.
	if (not (ah.version and ah.ahKey)) then
		return false
	end

	-- Check if we need upgrading.
	if (ah.version == version) then
		return true;
	end

	-- Future DB upgrade code goes here...
	debugPrint("Upgrading price database for "..ah.ahKey.. " to version "..version);

	-- Return the result of the upgrade!
	return (ah.version == version);
end

-------------------------------------------------------------------------------
-- Gets the Auctioneer price database for the specified auction house.
-------------------------------------------------------------------------------
function getAHDatabase(ahKey, create)
	-- If no auction house key was provided use the default key for the
	-- current zone.
	ahKey = ahKey or Auctioneer.Util.GetAuctionKey();
	local ah = LoadedFixedPriceDB[ahKey];
	if ((not ah) and (create)) then
		ah = createAHDatabase(ahKey);
		LoadedFixedPriceDB[ahKey] = ah;
		debugPrint("Created AuctioneerFixedPriceDB["..ahKey.."]");
	end
	return ah;
end

--=============================================================================
-- Fixed price functions
--=============================================================================

-------------------------------------------------------------------------------
-- Gets the fixed price for an item.
-------------------------------------------------------------------------------
function getFixedPrice(itemKey, ahKey, create)
	local fixedPrice;
	local ah = getAHDatabase(ahKey, create);
	if (ah) then
		local packedFixedPrice = ah.fixedPrices[itemKey];
		if (packedFixedPrice) then
			fixedPrice = Auctioneer.Database.UnpackRecord(packedFixedPrice, FixedPriceMetaData);
		elseif (create) then
			fixedPrice = {};
			fixedPrice.bid = 0;
			fixedPrice.buyout = 0;
			fixedPrice.count = 0;
			fixedPrice.duration = 0;
		end
	end
	return fixedPrice;
end

-------------------------------------------------------------------------------
-- Sets the fixed price for an item.
-------------------------------------------------------------------------------
function setFixedPrice(itemKey, ahKey, fixedPrice)
	local ah = getAHDatabase(ahKey, true);
	ah.fixedPrices[itemKey] = Auctioneer.Database.PackRecord(fixedPrice, FixedPriceMetaData);
	debugPrint("Set fixed price for "..itemKey.." to "..fixedPrice.buyout);
end

-------------------------------------------------------------------------------
-- Removes the fixed price.
-------------------------------------------------------------------------------
function removeFixedPrice(itemKey, ahKey)
	local ah = getAHDatabase(ahKey, true);
	ah.fixedPrices[itemKey] = nil;
	debugPrint("Removed fixed price for "..itemKey);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function debugPrint(...)
	EnhTooltip.DebugPrint("[Auc.FixedPriceDB]", unpack(arg));
end

--=============================================================================
-- Initialization
--=============================================================================
if (Auctioneer.FixedPriceDB) then return end;
debugPrint("AucFixedPriceDB.lua loaded");

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
Auctioneer.FixedPriceDB = {
	Load = load;
	GetFixedPrice = getFixedPrice;
	SetFixedPrice = setFixedPrice;
	RemoveFixedPrice = removeFixedPrice;
};

-------------------------------------------------------------------------------
-- Create an empty database to use before any upgrading is performed.
-------------------------------------------------------------------------------
AuctioneerFixedPriceDB = createDatabase();
LoadedFixedPriceDB = AuctioneerFixedPriceDB;



