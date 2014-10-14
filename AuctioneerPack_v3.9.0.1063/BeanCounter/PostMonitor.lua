--[[
	BeanCounter Addon for World of Warcraft(tm).
	Version: 3.9.0.1056 (Kangaroo)
	Revision: $Id: PostMonitor.lua 819 2006-04-14 06:32:43Z vindicator $

	PostMonitor - Monitors auction posts

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
local preStartAuctionHook;
local addPendingPost;
local removePendingPost;
local onEventHook;
local onAuctionCreated;
local onBidFailed;
local debugPrint;

-------------------------------------------------------------------------------
-- Data Members
-------------------------------------------------------------------------------
local PendingPosts = {};

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function PostMonitor_OnLoad()
	Stubby.RegisterFunctionHook("StartAuction", -50, preStartAuctionHook)
end

-------------------------------------------------------------------------------
-- Called before StartAuction()
-------------------------------------------------------------------------------
function preStartAuctionHook(_, _, minBid, buyoutPrice, runTime)
	local name, texture, count, quality, canUse, price = GetAuctionSellItemInfo();
	if (name and count and price) then
		local deposit = CalculateAuctionDeposit(runTime);
		addPendingPost(name, count, minBid, buyoutPrice, runTime, deposit);
	end
end

-------------------------------------------------------------------------------
-- Adds a pending post to the queue.
-------------------------------------------------------------------------------
function addPendingPost(name, count, minBid, buyoutPrice, runTime, deposit)
	-- Add a pending post to the queue.
	local pendingPost = {};
	pendingPost.name = name;
	pendingPost.count = count;
	pendingPost.minBid = minBid;
	pendingPost.buyoutPrice = buyoutPrice;
	pendingPost.runTime = runTime;
	pendingPost.deposit = deposit;
	table.insert(PendingPosts, pendingPost);
	debugPrint("addPendingPost() - Added pending post");
	
	-- Register for the response events if this is the first pending post.
	if (table.getn(PendingPosts) == 1) then
		debugPrint("addPendingPost() - Registering for CHAT_MSG_SYSTEM and UI_ERROR_MESSAGE");
		Stubby.RegisterEventHook("CHAT_MSG_SYSTEM", "BeanCounter_PostMonitor", onEventHook);
		Stubby.RegisterEventHook("UI_ERROR_MESSAGE", "BeanCounter_PostMonitor", onEventHook);
	end
end

-------------------------------------------------------------------------------
-- Removes the pending post from the queue.
-------------------------------------------------------------------------------
function removePendingPost()
	if (table.getn(PendingPosts) > 0) then
		-- Remove the first pending post.
		local post = PendingPosts[1];
		table.remove(PendingPosts, 1);
		debugPrint("removePendingPost() - Removed pending post");

		-- Unregister for the response events if this is the last pending post.
		if (table.getn(PendingPosts) == 0) then
			debugPrint("removePendingPost() - Unregistering for CHAT_MSG_SYSTEM and UI_ERROR_MESSAGE");
			Stubby.UnregisterEventHook("CHAT_MSG_SYSTEM", "BeanCounter_PostMonitor", onEventHook);
			Stubby.UnregisterEventHook("UI_ERROR_MESSAGE", "BeanCounter_PostMonitor", onEventHook);
		end

		return post;
	end
	
	-- No pending post to remove!
	return nil;
end

-------------------------------------------------------------------------------
-- OnEvent handler.
-------------------------------------------------------------------------------
function onEventHook(_, event, arg1)
	if (event == "CHAT_MSG_SYSTEM" and arg1) then
		debugPrint(event);
		if (arg1) then debugPrint("    "..arg1) end;
		if (arg1 == ERR_AUCTION_STARTED) then
		 	onAuctionCreated();
		end
	elseif (event == "UI_ERROR_MESSAGE" and arg1) then
		debugPrint(event);
		if (arg1) then debugPrint("    "..arg1) end;
		if (arg1 == ERR_NOT_ENOUGH_MONEY) then
			onPostFailed();
		end
	end
end

-------------------------------------------------------------------------------
-- Called when a post is accepted by the server.
-------------------------------------------------------------------------------
function onAuctionCreated()
	local post = removePendingPost();
	if (post) then
		-- Add to sales database
		BeanCounter.Sales.AddPendingAuction(time(), post.name, post.count, post.minBid, post.buyoutPrice, post.runTime, post.deposit, (GetAuctionHouseDepositRate() / 100));
	end
end

-------------------------------------------------------------------------------
-- Called when a post is rejected by the server.
-------------------------------------------------------------------------------
function onPostFailed()
	removePendingPost();
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function debugPrint(message)
	BeanCounter.DebugPrint("[BeanCounter.PostMonitor] "..message);
end
