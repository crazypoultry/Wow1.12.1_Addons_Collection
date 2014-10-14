--[[
	BeanCounter Addon for World of Warcraft(tm).
	Version: 3.9.0.1056 (Kangaroo)
	Revision: $Id: BidMonitor.lua 1004 2006-09-27 04:09:39Z vindicator $

	BidMonitor - Monitors auction bids

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
local nilSafe = BeanCounter.NilSafe;

-------------------------------------------------------------------------------
-- Function Prototypes
-------------------------------------------------------------------------------
local postPlaceAuctionBidHook;
local addPendingBid;
local removePendingBid;
local onEventHook;
local onBidAccepted;
local onBidFailed;
local debugPrint;

-------------------------------------------------------------------------------
-- Data Members
-------------------------------------------------------------------------------
local PendingBids = {};

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function BidMonitor_OnLoad()
	Stubby.RegisterFunctionHook("PlaceAuctionBid", 50, postPlaceAuctionBidHook)
end

-------------------------------------------------------------------------------
-- Called after PlaceAuctionBid()
-------------------------------------------------------------------------------
function postPlaceAuctionBidHook(_, _, listType, index, bid)
	local name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner = GetAuctionItemInfo(listType, index);
	local timeLeft = GetAuctionItemTimeLeft(listType, index);
	if (name and count and bid) then
		addPendingBid(name, count, bid, owner, (bid == buyoutPrice), highBidder, timeLeft);
	end
end

-------------------------------------------------------------------------------
-- Adds a pending bid to the queue.
-------------------------------------------------------------------------------
function addPendingBid(name, count, bid, owner, isBuyout, isHighBidder, timeLeft)
	-- Add a pending bid to the queue.
	local pendingBid = {};
	pendingBid.name = name;
	pendingBid.count = count;
	pendingBid.bid = bid;
	pendingBid.owner = owner;
	pendingBid.isBuyout = isBuyout;
	pendingBid.isHighBidder = isHighBidder;
	pendingBid.timeLeft = timeLeft;
	table.insert(PendingBids, pendingBid);
	debugPrint("addPendingBid() - Added pending bid");
	
	-- Register for the response events if this is the first pending bid.
	if (table.getn(PendingBids) == 1) then
		debugPrint("addPendingBid() - Registering for CHAT_MSG_SYSTEM and UI_ERROR_MESSAGE");
		Stubby.RegisterEventHook("CHAT_MSG_SYSTEM", "BeanCounter_BidMonitor", onEventHook);
		Stubby.RegisterEventHook("UI_ERROR_MESSAGE", "BeanCounter_BidMonitor", onEventHook);
	end
end

-------------------------------------------------------------------------------
-- Removes the pending bid from the queue.
-------------------------------------------------------------------------------
function removePendingBid()
	if (table.getn(PendingBids) > 0) then
		-- Remove the first pending bid.
		local bid = PendingBids[1];
		table.remove(PendingBids, 1);
		debugPrint("removePendingBid() - Removed pending bid");

		-- Unregister for the response events if this is the last pending bid.
		if (table.getn(PendingBids) == 0) then
			debugPrint("removePendingBid() - Unregistering for CHAT_MSG_SYSTEM and UI_ERROR_MESSAGE");
			Stubby.UnregisterEventHook("CHAT_MSG_SYSTEM", "BeanCounter_BidMonitor", onEventHook);
			Stubby.UnregisterEventHook("UI_ERROR_MESSAGE", "BeanCounter_BidMonitor", onEventHook);
		end

		return bid;
	end
	
	-- No pending bid to remove!
	return nil;
end

-------------------------------------------------------------------------------
-- OnEvent handler.
-------------------------------------------------------------------------------
function onEventHook(_, event, arg1)
	if (event == "CHAT_MSG_SYSTEM" and arg1) then
		debugPrint(event);
		if (arg1) then debugPrint("    "..arg1) end;
		if (arg1 == ERR_AUCTION_BID_PLACED) then
		 	onBidAccepted();
		end
	elseif (event == "UI_ERROR_MESSAGE" and arg1) then
		debugPrint(event);
		if (arg1) then debugPrint("    "..arg1) end;
		if (arg1 == ERR_ITEM_NOT_FOUND or
			arg1 == ERR_NOT_ENOUGH_MONEY or
			arg1 == ERR_AUCTION_BID_OWN or
			arg1 == ERR_AUCTION_HIGHER_BID or 
			arg1 == ERR_ITEM_MAX_COUNT) then
			onBidFailed();
		end
	end
end

-------------------------------------------------------------------------------
-- Called when a bid is accepted by the server.
-------------------------------------------------------------------------------
function onBidAccepted()
	local bid = removePendingBid();
	if (bid) then
		-- If the player is buying out an auction they already bid on, we
		-- need to remove the pending bid since an outbid e-mail is not sent.
		if (bid.isBuyout and bid.isHighBidder) then
			BeanCounter.Purchases.DeletePendingBid(bid.name, bid.count, bid.bid, bid.owner, bid.isBuyout, bid.timeLeft);
		end
		BeanCounter.Purchases.AddPendingBid(time(), bid.name, bid.count, bid.bid, bid.owner, bid.isBuyout, bid.timeLeft);
	end
end

-------------------------------------------------------------------------------
-- Called when a bid is rejected by the server.
-------------------------------------------------------------------------------
function onBidFailed()
	removePendingBid();
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function debugPrint(message)
	BeanCounter.DebugPrint("[BeanCounter.BidMonitor] "..message);
end
