--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.9.0.1063 (Kangaroo)
	Revision: $Id: AucBidManager.lua 1025 2006-10-02 06:12:36Z mentalpower $

	BidManager - manages bid requests in the AH

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
local chatPrint = Auctioneer.Util.ChatPrint;

-------------------------------------------------------------------------------
-- Function Prototypes
-------------------------------------------------------------------------------
local load;
local onEventHook;
local prePlaceAuctionBidHook;
local placeAuctionBid;
local isBidAllowed;
local isBidInProgress;
local addPendingBid;
local removePendingBid;
local isPendingBidForAuction;
local debugPrint;

-------------------------------------------------------------------------------
-- Data Members
-------------------------------------------------------------------------------

-- Queue of bids submitted to the server, but not yet accepted or rejected
local PendingBids = {};

-- True if PlaceAuctionBid calls should be hooked. This is always the case
-- unless Auctioneer wants to call it. Setting this to false effectively
-- unhooks the method.
local hookPlaceAuctionBid = true;

-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------
BidResultCodes =
{
	BidAccepted = "BidAccepted";
	ItemNotFound = "ItemNotFound";
	NotEnoughMoney = "NotEnoughMoney";
	OwnAuction = "OwnAuction";
	AlreadyHigherBid = "AlreadyHigherBid";
	AlreadyHighBidder = "AlreadyHighBidder";
	MaxItemCount = "MaxItemCount";
}

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function load()
	Stubby.RegisterFunctionHook("PlaceAuctionBid", -200, prePlaceAuctionBidHook)
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function onEventHook(_, event)
	if (event == "CHAT_MSG_SYSTEM" and arg1) then
		--debugPrint(event);
		--if (arg1) then debugPrint("    "..arg1) end;
		if (arg1 == ERR_AUCTION_BID_PLACED) then
		 	removePendingBid(BidResultCodes.BidAccepted);
		end
	elseif (event == "UI_ERROR_MESSAGE" and arg1) then
		--debugPrint(event);
		--if (arg1) then debugPrint("    "..arg1) end;
		if (arg1 == ERR_ITEM_NOT_FOUND) then
			removePendingBid(BidResultCodes.ItemNotFound);
		elseif (arg1 == ERR_NOT_ENOUGH_MONEY) then
			removePendingBid(BidResultCodes.NotEnoughMoney);
		elseif (arg1 == ERR_AUCTION_BID_OWN) then
			removePendingBid(BidResultCodes.OwnAuction);
		elseif (arg1 == ERR_AUCTION_HIGHER_BID) then
			removePendingBid(BidResultCodes.AlreadyHigherBid);
		elseif (arg1 == ERR_ITEM_MAX_COUNT) then
			removePendingBid(BidResultCodes.MaxItemCount);
		end
	end
end

-------------------------------------------------------------------------------
-- Called before Blizzard's PlaceAuctionBid()
-------------------------------------------------------------------------------
function prePlaceAuctionBidHook(_, _, listType, index, bid)
	if (hookPlaceAuctionBid) then
		if (isBidAllowed(listType, index)) then
			-- Add the pending bid to the list.
			addPendingBid(listType, index, bid, nil);
		else
			debugPrint("prePlaceAuctionBidHook() - Bid not allowed");
			return "abort";
		end
	end
end

-------------------------------------------------------------------------------
-- Auctioneer's version of PlaceAuctionBid. Similar to the Blizzard version
-- except that it accepts a callback function.
-------------------------------------------------------------------------------
function placeAuctionBid(listType, index, bid, callbackFunc)
	if (isBidAllowed(listType, index)) then
		-- Add the pending bid to the list and fire off the bid request.
		addPendingBid(listType, index, bid, callbackFunc);
		hookPlaceAuctionBid = false;
		PlaceAuctionBid(listType, index, bid);
		hookPlaceAuctionBid = true;
	else
		debugPrint("placeAuctionBid() - Bid not allowed");
	end
end

-------------------------------------------------------------------------------
-- Checks if a bid is allowed on the specified auction.
-------------------------------------------------------------------------------
function isBidAllowed(listType, index)
	-- Must be a valid auction.
	local auction = Auctioneer.QueryManager.GetAuctionByIndex(listType, index)
	if (not Auctioneer.QueryManager.IsAuctionValid(auction)) then
		return false;
	end
	
	-- Must not have a query in progress.
	if (Auctioneer.QueryManager.IsQueryInProgress()) then
		return false;
	end

	-- Must not be a pending bid on the same auction.
	local auctionId = Auctioneer.QueryManager.GetAuctionId(listType, index);
	if (auctionId ~= nil and isPendingBidForAuction(auctionId)) then
		return false;
	end

	return true;
end

-------------------------------------------------------------------------------
-- Returns true if a bid request is in flight to the server
-------------------------------------------------------------------------------
function isBidInProgress()
	return (table.getn(PendingBids) > 0);
end

-------------------------------------------------------------------------------
-- Adds a pending bid to the queue.
-------------------------------------------------------------------------------
function addPendingBid(listType, index, bid, callbackFunc)
	-- Get the auction being bid on. We first try to get it from the snapshot
	-- database so that we have the auctionId. If we are unable then we just
	-- get it from the query manager.
	local auction;
	local auctionId = Auctioneer.QueryManager.GetAuctionId(listType, index);
	if (auctionId ~= nil) then
		auction = Auctioneer.SnapshotDB.GetAuctionById(nil, auctionId);
	end
	if (auction ~= nil and auction.auctionId ~= nil) then
		debugPrint("Found in snapshot: "..auction.auctionId);
	else
		debugPrint("Did not find auction in snapshot");
		auction = Auctioneer.QueryManager.GetAuctionByIndex(listType, index);
	end
	
	-- We had better have an auction by now...
	if (auction) then
		-- Add a pending bid to the queue.
		local pendingBid = {};
		pendingBid.auction = auction;
		pendingBid.bid = bid;
		pendingBid.callbackFunc = callbackFunc;
		table.insert(PendingBids, pendingBid);
		debugPrint("Added pending bid");

		-- Register for the response events if this is the first pending bid.
		if (table.getn(PendingBids) == 1) then
			debugPrint("addPendingBid() - Registering for CHAT_MSG_SYSTEM and UI_ERROR_MESSAGE");
			Stubby.RegisterEventHook("CHAT_MSG_SYSTEM", "Auctioneer_BidManager", onEventHook);
			Stubby.RegisterEventHook("UI_ERROR_MESSAGE", "Auctioneer_BidManager", onEventHook);
		end

		-- Fire the AUCTIONEER_BID_SENT event.
		Auctioneer.EventManager.FireEvent("AUCTIONEER_BID_SENT", pendingBid.auction, pendingBid.bid);
	end
end

-------------------------------------------------------------------------------
-- Removes the pending bid from the queue.
-------------------------------------------------------------------------------
function removePendingBid(result)
	if (table.getn(PendingBids) > 0) then
		-- Remove the first pending bid.
		local pendingBid = PendingBids[1];
		table.remove(PendingBids, 1);
		debugPrint("Removed pending bid with result "..result);
		
		-- Unregister for the response events if this is the last pending bid.
		if (table.getn(PendingBids) == 0) then
			debugPrint("removePendingBid() - Unregistering for CHAT_MSG_SYSTEM and UI_ERROR_MESSAGE");
			Stubby.UnregisterEventHook("CHAT_MSG_SYSTEM", "Auctioneer_BidManager");
			Stubby.UnregisterEventHook("UI_ERROR_MESSAGE", "Auctioneer_BidManager");
		end

		-- Fire the AUCTIONEER_BID_COMPLETE event.
		Auctioneer.EventManager.FireEvent("AUCTIONEER_BID_COMPLETE", pendingBid.auction, pendingBid.bid, result);
		
		-- If a callback function was provided, call it.
		if (pendingBid.callbackFunc) then
			pendingBid.callbackFunc(pendingBid.auction, pendingBid.bid, result);
		end
	else
		-- We got out of sync somehow... this indicates a bug in how we determine
		-- the results of bid requests.
		chatPrint(_AUCT('FrmtBidQueueOutOfSync'));
	end
end

-------------------------------------------------------------------------------
-- Checks if there is a pending for the specified auction.
-------------------------------------------------------------------------------
function isPendingBidForAuction(auctionId)
	for _, pendingBid in pairs(PendingBids) do
		if (pendingBid.auction.auctionId == auctionId) then
			return true;
		end
	end
	return false;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function debugPrint(message)
	EnhTooltip.DebugPrint("[Auc.BidManager] "..message);
end

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
Auctioneer.BidManager =
{
	Load = load;
	IsBidInProgress = isBidInProgress;
	IsBidAllowed = isBidAllowed;
	PlaceAuctionBid = placeAuctionBid;
}

