--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: <%version%> (<%codename%>)
	Revision: $Id: AucDatabase.lua 1036 2006-10-04 06:06:37Z vindicator $

	AucDatabase - Auctioneer database methods

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
-- Function Prototypes
-------------------------------------------------------------------------------
local load;
local loadDatabases;
local addPlayerToAccount;
local isPlayerOnAccount;
local stringFromBoolean;
local booleanFromString;
local stringFromNumber;
local nilSafeStringFromString;
local stringFromNilSafeString;
local packRecord;
local unpackRecord;
local packNumericList;
local unpackNumericList;
local doesNameMatch;
local debugPrint;

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------
local NIL_VALUE = "<nil>";
local DATABASE_VERSION_40 = 40000;
local CURRENT_DATABASE_VERSION = 40000;

-------------------------------------------------------------------------------
-- Data members
-------------------------------------------------------------------------------
AuctionConfig = {}; --Table that stores config settings
AuctionConfig.version = CURRENT_DATABASE_VERSION;

-------------------------------------------------------------------------------
-- Called when the Auctioneer addon loads. This method should check the
-- version of the database and upgrade if needed.
-------------------------------------------------------------------------------
function load()
	-- Load/Upgrade AuctionConfig.
	if (not AuctionConfig) then
		AuctionConfig = {};
	end
	if (not AuctionConfig.version) then
		AuctionConfig.version = 30000;
	end
	Auctioneer.Util.SetFilterDefaults();

	-- Load/Upgrade the various databases.
	if (AuctionConfig.version < CURRENT_DATABASE_VERSION) then
		-- The database is from an older verison of Auctioneer. Prompt to
		-- upgrade.
		StaticPopupDialogs["CONVERT_AUCTIONEER"] = {
			text = _AUCT('MesgConvert'),
			button1 = _AUCT('MesgConvertYes'),
			button2 = _AUCT('MesgConvertNo'),
			OnAccept = function()
				-- Load and upgrade the database.
				loadDatabases(true);
			end,
			OnCancel = function()
				-- Use a temporary database so we don't trample the user's
				-- data.
				loadDatabases(false);
				Auctioneer.Util.ChatPrint(_AUCT('MesgNotconverting'));
			end,
			timeout = 0,
			whileDead = 1,
			exclusive = 1
		};
		StaticPopup_Show("CONVERT_AUCTIONEER", "","");
	elseif (AuctionConfig.version > CURRENT_DATABASE_VERSION) then
		-- Hmmm... the database is newer than this version of Auctioneer!
		-- We'll use a temporary database so we don't trample the user's
		-- data.
		loadDatabases(false);
	else
		-- The database is from this version of Auctioneer.
		loadDatabases(true);
	end
end

-------------------------------------------------------------------------------
-- Loads the appropriate databases.
-------------------------------------------------------------------------------
function loadDatabases(upgrade)
	-- Load the databases. Each database will take care of upgrading itself.
	Auctioneer.ItemDB.Load(upgrade);
	Auctioneer.SnapshotDB.Load(upgrade);
	Auctioneer.HistoryDB.Load(upgrade);
	Auctioneer.FixedPriceDB.Load(upgrade);

	-- If we are upgrading from pre-4.0, toss the pre-4.0 tables.
	if (upgrade and AuctionConfig.version < DATABASE_VERSION_40) then
		AuctionPrices = nil;
		AuctionBids = nil;
		AHSnapshot = nil;
		AHSnapshotItemPrices = nil;
		AuctionConfig.bids = nil;
		AuctionConfig.classes = nil;
		AuctionConfig.data = nil;
		AuctionConfig.fixedprice = nil;
		AuctionConfig.info = nil;
		AuctionConfig.sbuy = nil;
		AuctionConfig.snap = nil;
		AuctionConfig.stats = nil;
		AuctionConfig.success = nil;
	end

	-- We are up-to-date!
	if (upgrade) then
		AuctionConfig.version = CURRENT_DATABASE_VERSION;
	end
end

-------------------------------------------------------------------------------
-- Adds a player to the list of players on the current account.
-------------------------------------------------------------------------------
function addPlayerToAccount(player)
	-- List of players on the same account as the current player (including the
	-- current player). Auctions owned by these players cannot be bid on.
	if (not AuctionConfig.players) then AuctionConfig.players = {}; end
	if (not isPlayerOnAccount(player)) then
		table.insert(AuctionConfig.players, player);
	end
end

-------------------------------------------------------------------------------
-- Checks if a player is on the same account as the current player.
-------------------------------------------------------------------------------
function isPlayerOnAccount(player)
	if (not AuctionConfig.players) then AuctionConfig.players = {}; end
	for _, storedPlayer in pairs(AuctionConfig.players) do
		if (storedPlayer == player) then
			return true;
		end
	end
	return false;
end

-------------------------------------------------------------------------------
-- Converts boolean into a numeric string.
-------------------------------------------------------------------------------
function stringFromBoolean(boolean)
	if (boolean == nil) then
		return NIL_VALUE;
	elseif (boolean) then
		return "1";
	else
		return "0";
	end
end

-------------------------------------------------------------------------------
-- Converts a numeric string into a boolean.
-------------------------------------------------------------------------------
function booleanFromString(string)
	if (string == NIL_VALUE) then
		return nil;
	elseif (string == "0") then
		return false;
	else
		return true;
	end
end

-------------------------------------------------------------------------------
-- Converts number into a numeric string.
-------------------------------------------------------------------------------
function stringFromNumber(number)
	if (not number) then
		return NIL_VALUE;
	else
		return tostring(number);
	end
end

-------------------------------------------------------------------------------
-- Converts a string into a nil safe string (nil -> "<nil>")
-------------------------------------------------------------------------------
function nilSafeStringFromString(string)
	return string or NIL_VALUE;
end

-------------------------------------------------------------------------------
-- Converts a nil safe string into a string ("<nil>" -> nil)
-------------------------------------------------------------------------------
function stringFromNilSafeString(nilSafeString)
	if (nilSafeString == NIL_VALUE) then
		return nil;
	else
		return nilSafeString;
	end
end

-------------------------------------------------------------------------------
-- Converts a record into a ';' delimited string.
-------------------------------------------------------------------------------
function packRecord(record, recordMetaData)
	local packedRecord;
	for index, metadata in ipairs(recordMetaData) do
		local value = metadata.toStringFunc(record[metadata.fieldName]);
		if (not packedRecord) then
			packedRecord = value;
		else
			packedRecord = packedRecord..";"..value;
		end
	end
	return packedRecord;
end

-------------------------------------------------------------------------------
-- Converts a ';' delimited string into a record.
-------------------------------------------------------------------------------
function unpackRecord(packedRecord, recordMetaData)
	local record = {};
	local startOffset = 1;
	for index, metadata in ipairs(recordMetaData) do
		local value;
		local endOffset = string.find(packedRecord, ";", startOffset, true);
		if (not endOffset) then
			value = string.sub(packedRecord, startOffset);
		else
			value = string.sub(packedRecord, startOffset, endOffset - 1);
			startOffset = endOffset + 1;
		end
		record[metadata.fieldName] = metadata.fromStringFunc(value);
	end
	return record;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function packNumericList(list)
	local hist = "";
	local function GrowList(last, n)
		if (n == 1) then
			if (hist == "") then hist = tostring(last);
			else hist = string.format("%s:%d", hist, last); end
		elseif (n ~= 0) then
			if (hist == "") then hist = string.format("%dx%d", last, n);
			else hist = string.format("%s:%dx%d", hist, last, n); end
		end
	end
	local n = 0;
	local last = 0;
	for pos, hPrice in pairs(list) do
		if (pos == 1) then
			last = hPrice;
		elseif (hPrice ~= last) then
			GrowList(last, n)
			last = hPrice;
			n = 0;
		end
		n = n + 1
	end
	GrowList(last, n)
	return hist;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function unpackNumericList(str)
	local splut = {};
	if (str) then
		for x,c in string.gfind(str, '([^%:]*)(%:?)') do
			local _,_,y,n = string.find(x, '(%d*)x(%d*)')
			if (y == nil) then
				table.insert(splut, tonumber(x));
			else
				for i = 1,n do
					table.insert(splut, tonumber(y));
				end
			end
			if (c == '') then break end
		end
	end
	return splut;
end

-------------------------------------------------------------------------------
-- Checks if the item names match. If exact is false, it checks if name2
-- appears within name1.
-------------------------------------------------------------------------------
function doesNameMatch(name1, name2, exact)
	local match = true;
	if (name1 and name2) then
		if (exact) then
			match = (string.lower(name1) == string.lower(name2));
		else
			match = (string.find(string.lower(name1), string.lower(name2), 1, true) ~= nil);
		end
	end
	return match;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function debugPrint(...)
	EnhTooltip.DebugPrint("[Auc.Database]", unpack(arg));
end

--=============================================================================
-- Initialization
--=============================================================================
if (Auctioneer.Database) then return end;
debugPrint("AucDatabase.lua loaded");

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
Auctioneer.Database = {
	Load = load;
	AddPlayerToAccount = addPlayerToAccount;
	IsPlayerOnAccount = isPlayerOnAccount;
	StringFromBoolean = stringFromBoolean;
	BooleanFromString = booleanFromString;
	StringFromNumber = stringFromNumber;
	NilSafeStringFromString = nilSafeStringFromString;
	StringFromNilSafeString = stringFromNilSafeString;
	PackRecord = packRecord;
	UnpackRecord = unpackRecord;
	PackNumericList = packNumericList;
	UnpackNumericList = unpackNumericList;
	DoesNameMatch = doesNameMatch;
};
