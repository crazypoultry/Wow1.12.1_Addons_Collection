--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.9.0.1063 (Kangaroo)
	Revision: $Id: AucQueryManager.lua 1063 2006-10-11 06:19:36Z vindicator $

	QueryManager - manages AH queries

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
local onBidSent;
local onBidComplete;
local postCanSendAuctionQuery;
local canSendAuctionQuery;
local preSortAuctionItemsHook;
local postSortAuctionItemsHook;
local preQueryAuctionItemsHook;
local postQueryAuctionItemsHook;
local queryAuctionItems;
local addRequestToQueue;
local removeRequestFromQueue;
local clearRequestQueue;
local sendQuery;
local onAuctionItemListUpdate;
local isQueryInProgress;
local isBidInProgress;
local getAuctionByIndex;
local getAuctionsOnCurrentPage;
local doQueriesMatch;
local doAuctionsMatchQuery;
local reconcileAuctionLists;
local addPageToCache;
local getAuctionsInCache;
local checkForDups;
local clearPageCache;
local getAuctionId;
local isAuctionValid;
local nilSafeString;
local nilSafeNumber;
local normalizeNumericQueryParam;
local debugPrint;

-------------------------------------------------------------------------------
-- Private Data
-------------------------------------------------------------------------------
-- Queue of query requests.
--
-- QueryRequestQueue[Index] =
-- {
--     parameters;				-- query parameters
--     maxSilence;				
--     maxRetries;
--     callbackFunc;			-- callback function called when the query is complete.
--     querySent;				-- true if the query has been sent to the server.
--     receivedQueryResponse;	-- true if the initial response has been received.
--     lastQueryResponseTime	-- time of the last query response.
-- }
local QueryRequestQueue = {};

-- Flag that is true when inside Blizzard's SortAuctionItems().
local PerformingSortAuctionItems = false;

-- The query parameters for the current page cache.
local PageCacheQuery = {};

-- Table containing all the pages seen for the PageCacheQuery. The table has the
-- following structure:
--
-- PageCache[PageNum]
-- {
--     query					-- query parameters
--     pageNum;					-- page number
--     isLastPage;				-- true if this is the last page for the search
--     lastSeen					-- time the page was seen
--     auctions[IndexOnPage]	-- list of auctions on the page.
--     {
--         auctionId;			-- nil unless the snapshot has been updated
--         itemId;
--         suffixId;
--         enchantId;
--         uniqueId;
--         name;
--         texture;
--         count;
--         quality;
--         canUse;
--         level;
--         minBid;
--         minIncrement;
--         buyoutPrice;
--         bidAmount;
--         highBidder;
--         owner;
--     }
-- }
local PageCache = {};

-- Table of pending bids listed by auction id.
--
-- PendingBidInfo[AuctionId]
-- {
--    bid;								-- the bid sent to the server
--    receivedBidComplete;				-- true if onBidComplete() has been called
--    receivedAuctionItemListUpdate;	-- true if onAuctionItemListUpdate() has been called
-- }
local PendingBidInfo = {};

local CurrentPage = nil;

-- True if CanSendAuctionQuery calls should be hooked. This is always the case
-- unless Auctioneer wants to call it. Setting this to false effectively
-- unhooks the method.
local hookCanSendAuctionQuery = true;

-- True if QueryAuctionItems calls should be hooked. This is always the case
-- unless Auctioneer wants to call it. Setting this to false effectively
-- unhooks the method.
local hookQueryAuctionItems = true;

-------------------------------------------------------------------------------
-- Public Data
-------------------------------------------------------------------------------
QueryAuctionItemsResultCodes =
{
	Complete = "Complete";
	PartialComplete = "PartialComplete";
	Canceled = "Canceled";
};

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function load()
	Stubby.RegisterEventHook("AUCTION_ITEM_LIST_UPDATE", "Auctioneer_QueryManager", onEventHook);
	Stubby.RegisterEventHook("AUCTION_HOUSE_CLOSED", "Auctioneer_QueryManager", onEventHook);
	Stubby.RegisterFunctionHook("CanSendAuctionQuery", 50, postCanSendAuctionQuery);
	Stubby.RegisterFunctionHook("QueryAuctionItems", -50, preQueryAuctionItemsHook);
	Stubby.RegisterFunctionHook("QueryAuctionItems", 50, postQueryAuctionItemsHook);
	Stubby.RegisterFunctionHook("SortAuctionItems", -50, preSortAuctionItemsHook);
	Stubby.RegisterFunctionHook("SortAuctionItems", 50, postSortAuctionItemsHook);
	Auctioneer.EventManager.RegisterEvent("AUCTIONEER_BID_SENT", onBidSent);
	Auctioneer.EventManager.RegisterEvent("AUCTIONEER_BID_COMPLETE", onBidComplete);
end

-------------------------------------------------------------------------------
-- Check if a query should be sent or resent.
-------------------------------------------------------------------------------
function AucQueryManager_OnUpdate()
	local request = QueryRequestQueue[1];
	if (request) then
		-- If the query has been sent, check if it needs to be aborted or resent.
		if (request.querySent) then
			-- Check if we've recevied any response from the server.
			if (request.receivedQueryResponse) then
				-- Yep, check how long the server has been quite.
				local silence = (GetTime() - request.lastQueryResponseTime);
				if (silence > request.maxSilence) then
					-- Either retry or fail it.
					if (request.maxRetries > 0) then
						request.maxRetries = request.maxRetries - 1;
						sendQuery(request);
					else
						debugPrint("Query response not received in the last "..silence.." seconds (maxSilence="..request.maxSilence..")");
						removeRequestFromQueue(QueryAuctionItemsResultCodes.PartialComplete);
					end
				end
			end
		-- Otherwise check if we can send the query now.
		elseif (canSendAuctionQuery()) then
			sendQuery(request);
		end
	end
end

-------------------------------------------------------------------------------
-- OnEvent handler.
-------------------------------------------------------------------------------
function onEventHook(_, event)
	debugPrint(event);
	if (event == "AUCTION_ITEM_LIST_UPDATE") then
		onAuctionItemListUpdate();
	elseif (event == "AUCTION_HOUSE_CLOSED") then
		clearRequestQueue();
	end
end

-------------------------------------------------------------------------------
-- Called when a bid is sent to the server.
-------------------------------------------------------------------------------
function onBidSent(event, auction, bid)
	-- Only pay attention to bids with auction ids.
	if (auction.auctionId) then
		local bidInfo = {};
		bidInfo.bid = bid;
		bidInfo.receivedBidComplete = false;
		bidInfo.receivedAuctionItemListUpdate = false;
		PendingBidInfo[auction.auctionId] = bidInfo;
		debugPrint("Added pending bid for auction "..auction.auctionId);
	else
		debugPrint("Ignoring bid sent due to no auction id");
	end
end

-------------------------------------------------------------------------------
-- Called when the result of a bid is received.
-------------------------------------------------------------------------------
function onBidComplete(event, auction, bid, result)
	-- Only pay attention to bids with auction ids.
	if (auction.auctionId) then
		-- Remove the pending bid.
		local bidInfo = PendingBidInfo[auction.auctionId];
		if (bidInfo) then
			-- Remove the pending bid info if the bid was unsuccessful or if we've
			-- received the AUCTION_ITEM_LIST_UPDATE event.
			if (result ~= BidResultCodes.BidAccepted or bidInfo.receivedAuctionItemListUpdate) then
				PendingBidInfo[auction.auctionId] = nil;
				debugPrint("Removed pending bid for auction "..auction.auctionId);
			else
				bidInfo.receivedBidComplete = true;
				debugPrint("Deferring removal of pending bid for auction "..auction.auctionId);
			end
		else
			debugPrint("WARNING: No pending bid for auction "..auction.auctionId);
		end
	else
		debugPrint("Ignoring bid complete due to no auction id");
	end
end

-------------------------------------------------------------------------------
-- Hook called after Blizzard's CanSendAuctionQuery(). Overrides the return
-- value if a request is in progress. This method returns true
-- under any of the following conditions:
-- 1. Blizzard's CanSendAuctionQuery() returns true;
-- 2. There is a query in progress.
-- 3. There is a bid in progress.
-- 4. The scan manager is performing a scan.
-- 5. The bid scanner is performing a scan.
-------------------------------------------------------------------------------
function postCanSendAuctionQuery(_, returnValues)
	-- If Blizzard will allow the query, check if should allow it.
	if (returnValues and returnValues[1]) then
		if (isQueryInProgress()) then
			--debugPrint("Overriding CanSendAuctionQuery() due to query being in progress");
			return "setreturn", { false };
		elseif (isBidInProgress()) then
			--debugPrint("Overriding CanSendAuctionQuery() due to bid being in progress");
			return "setreturn", { false };
		elseif (hookCanSendAuctionQuery and Auctioneer.ScanManager.IsScanning()) then
			--debugPrint("Overriding CanSendAuctionQuery() due to scan being in progress");
			return "setreturn", { false };
		elseif (hookCanSendAuctionQuery and Auctioneer.BidScanner.IsScanning()) then
			--debugPrint("Overriding CanSendAuctionQuery() due to bid scan being in progress");
			return "setreturn", { false };
		end
	end
end

-------------------------------------------------------------------------------
-- Auctioneer's version of CanSendAuctionQuery(). This method returns true
-- under any of the following conditions:
-- 1. Blizzard's CanSendAuctionQuery() returns true;
-- 2. There is a query in progress.
-- 3. There is a bid in progress.
-------------------------------------------------------------------------------
function canSendAuctionQuery()
	hookCanSendAuctionQuery = false;
	local result = CanSendAuctionQuery();
	hookCanSendAuctionQuery = true;
	return result;
end

-------------------------------------------------------------------------------
-- Hook called before Blizzard's SortAuctionItems().
-------------------------------------------------------------------------------
function preSortAuctionItemsHook(_, _, sortType, sortColumn)
	if (sortType == "list") then
		if (isQueryInProgress()) then
			debugPrint("Overriding SortAuctionItems() - Request in progress");
			return "abort"
		elseif (isBidInProgress()) then
			debugPrint("Overriding SortAuctionItems() - Bid in progress");
			return "abort"
		end
		PerformingSortAuctionItems = true;
	end
end

-------------------------------------------------------------------------------
-- Hook called after Blizzard's SortAuctionItems().
-------------------------------------------------------------------------------
function postSortAuctionItemsHook(_, _, sortType, sortColumn)
	if (sortType == "list") then
		PerformingSortAuctionItems = false;
	end
end

-------------------------------------------------------------------------------
-- Hook called before Blizzard's QueryAuctionItems(). Aborts the method if
-- it cannot be called at this time.
-------------------------------------------------------------------------------
function preQueryAuctionItemsHook(_, _, name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, page, isUsable, qualityIndex)
	if (hookQueryAuctionItems) then
		if (not CanSendAuctionQuery()) then
			debugPrint("Aborting QueryAuctionItems() - CanSendAuctionQuery() returned false");
			return "abort";
		elseif (page == nil) then
			debugPrint("Aborting QueryAuctionItems() - Invalid page number");
			return "abort";
		end
	end
end

-------------------------------------------------------------------------------
-- Hook called after Blizzard's QueryAuctionItems(). If we make it this far
-- its assumed that the query went through and we start the waiting game.
-------------------------------------------------------------------------------
function postQueryAuctionItemsHook(_, _, name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, page, isUsable, qualityIndex)
	if (hookQueryAuctionItems) then
		debugPrint("Blizzard's QueryAuctionItems() called");

		-- Construct a table for the QueryAuctionItem parameters.
		local parameters = {};
		parameters.name = name;
		parameters.minLevel = normalizeNumericQueryParam(minLevel);
		parameters.maxLevel = normalizeNumericQueryParam(maxLevel);
		parameters.invTypeIndex = normalizeNumericQueryParam(invTypeIndex);
		parameters.classIndex = normalizeNumericQueryParam(classIndex);
		parameters.subclassIndex = normalizeNumericQueryParam(subclassIndex);
		parameters.page = page;
		parameters.isUsable = isUsable;
		parameters.qualityIndex = normalizeNumericQueryParam(qualityIndex);

		-- Construct the request and add it to the front of the queue.
		local request = {};
		request.parameters = parameters;
		request.maxSilence = 5; -- 5 seconds
		request.maxRetries = 0;
		request.callbackFunc = nil;
		request.querySent = true;
		request.receivedQueryResponse = false;
		request.lastQueryResponseTime = GetTime();

		-- Add the request to the queue. We are guaranteed to be the only ones
		-- in the queue.
		addRequestToQueue(request, true);
		Auctioneer.EventManager.FireEvent("AUCTIONEER_QUERY_SENT", request.parameters);
	end
end

-------------------------------------------------------------------------------
-- Auctioneer's version of QueryAuctionItems. Similar to the Blizzard version
-- except that it accepts a callback function.
-------------------------------------------------------------------------------
function queryAuctionItems(name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, page, isUsable, qualityIndex, maxSilence, maxRetries, callbackFunc)
	debugPrint("Auctioneer's QueryAuctionItems() called");

	-- Validate the parameters.
	if (maxSilence == nil) then maxSilence = 5 end;
	if (maxRetries == nil) then maxRetries = 3 end;

	-- Construct a table for the QueryAuctionItem parameters.
	local parameters = {};
	parameters.name = name;
	parameters.minLevel = normalizeNumericQueryParam(minLevel);
	parameters.maxLevel = normalizeNumericQueryParam(maxLevel);
	parameters.invTypeIndex = normalizeNumericQueryParam(invTypeIndex);
	parameters.classIndex = normalizeNumericQueryParam(classIndex);
	parameters.subclassIndex = normalizeNumericQueryParam(subclassIndex);
	parameters.page = page;
	parameters.isUsable = isUsable;
	parameters.qualityIndex = normalizeNumericQueryParam(qualityIndex);

	-- Construct the request and add it to the queue.
	local request = {};
	request.parameters = parameters;
	request.maxSilence = maxSilence;
	request.maxRetries = maxRetries;
	request.callbackFunc = callbackFunc;
	request.querySent = false;
	request.receivedQueryResponse =  false;
	request.lastQueryResponseTime = nil;

	-- Add the request to the queue.
	addRequestToQueue(request);
end

-------------------------------------------------------------------------------
-- Adds a request to the back of the queue.
-------------------------------------------------------------------------------
function addRequestToQueue(request, front)
	if (front) then
		table.insert(QueryRequestQueue, 1, request);
		debugPrint("Added request to front of queue");
	else
		table.insert(QueryRequestQueue, request);
		debugPrint("Added request to back of queue");
	end
end

-------------------------------------------------------------------------------
-- Removes the request at the head of the queue.
-------------------------------------------------------------------------------
function removeRequestFromQueue(result)
	if (table.getn(QueryRequestQueue) > 0) then
		-- Remove the request from the queue.
		local request = QueryRequestQueue[1];
		table.remove(QueryRequestQueue, 1);
		debugPrint("Removed request from queue with result: "..result);

		-- If the query was successful, add the page to the cache. Otherwise
		-- toss the cache since we have only partial results.
		if (result == QueryAuctionItemsResultCodes.Complete) then
			addPageToCache(CurrentPage, true);
		else
			clearPageCache();
		end

		-- If the query was sent we must fire the AUCTIONEER_QUERY_COMPLETE event.
		if (request.querySent) then
			Auctioneer.EventManager.FireEvent("AUCTIONEER_QUERY_COMPLETE", request.parameters, result);
		end

		-- If a callback function was provided, call it.
		if (request.callbackFunc) then
			request.callbackFunc(request.parameters, result);
		end
	end
end

-------------------------------------------------------------------------------
-- Cancels the current query, if any. Doesn't really cancel the query, it
-- just cancels the waiting.
-------------------------------------------------------------------------------
function clearRequestQueue()
	-- %todo
end

-------------------------------------------------------------------------------
-- Send (or resend) the query for the current request.
-------------------------------------------------------------------------------
function sendQuery(request)
	if (request.querySent) then
		debugPrint("Resending query...");
		Auctioneer.EventManager.FireEvent("AUCTIONEER_QUERY_RESENT", request.parameters);
	else
		debugPrint("Sending query...");
		Auctioneer.EventManager.FireEvent("AUCTIONEER_QUERY_SENT", request.parameters);
	end

	-- Update the query status.
	request.querySent = true;
	request.receivedQueryResponse = false;
	request.lastQueryResponseTime = GetTime();

	-- Send the query.
	local parameters = request.parameters;
	hookQueryAuctionItems = false;
	QueryAuctionItems(
		parameters.name,
		parameters.minLevel,
		parameters.maxLevel,
		parameters.invTypeIndex,
		parameters.classIndex,
		parameters.subclassIndex,
		parameters.page,
		parameters.isUsable,
		parameters.qualityIndex);
	hookQueryAuctionItems = true;
end

-------------------------------------------------------------------------------
-- Handles auction item list updates. Updates fall under one of three
-- categories:
-- Sort Change - The update was due to a sort (local operation).
-- Query Response - The update was due to query sent to the server.
-- Current Bid Change - The update was due to a current bid change.
-------------------------------------------------------------------------------
function onAuctionItemListUpdate()
	local updatedAuctions = getAuctionsOnCurrentPage();

	-- Check if the update is a result of a sort.
	if (CurrentPage and PerformingSortAuctionItems) then
		-- Update the current page. Note that we lose any auction ids that have
		-- been assigned to auctions on the current page because we cannot tell
		-- which auction is which anymore.
		CurrentPage.auctions = updatedAuctions;
		debugPrint("onAuctionItemListUpdate() - sort complete");
		return;
	end

	-- Check if the update is the result of a query.
	if (isQueryInProgress() and doAuctionsMatchQuery(updatedAuctions, QueryRequestQueue[1].parameters)) then
		local request = QueryRequestQueue[1];
		local lastIndexOnPage, totalAuctions = GetNumAuctionItems("list");

		-- Update the current page.
		CurrentPage = {};
		CurrentPage.query = request.parameters;
		CurrentPage.pageNum = request.parameters.page;
		CurrentPage.lastSeen = time();
		CurrentPage.auctions = updatedAuctions;
		CurrentPage.isLastPage = false;
		if (lastIndexOnPage == 0) then
			CurrentPage.isLastPage = true;
		elseif (CurrentPage.pageNum * NUM_AUCTION_ITEMS_PER_PAGE + lastIndexOnPage == totalAuctions) then
			CurrentPage.isLastPage = true;
		end

		-- Update the receive time of the query request.
		request.lastQueryResponseTime = GetTime();
		local isFirstResponse = (not request.receivedQueryResponse);
		request.receivedQueryResponse = true;
		if (isFirstResponse) then
			Auctioneer.EventManager.FireEvent("AUCTIONEER_QUERY_RESPONSE_RECEIVED", request.parameters);
		end

		-- Check if the query is complete. The query is considered
		-- complete once we have received all the owners. Assume true
		-- until otherwise proven false.
		local complete = true;
		for index, auction in pairs(updatedAuctions) do
			-- Ignore auctions with no item name (Blizzard bug).
			if (auction.name ~= "" and auction.owner == "") then
				-- No dice... there should be more updates coming...
				complete = false;
				break;
			end
		end

		-- If the request is comlete, remove it from the queue.
		if (complete) then
			debugPrint("onAuctionItemListUpdate() - query complete");
			removeRequestFromQueue(QueryAuctionItemsResultCodes.Complete);
		else
			debugPrint("onAuctionItemListUpdate() - query incomplete (missing owner)");
		end

		-- All done with update!		
		return;
	end

	-- Check if this is a refresh of the current page. A refresh would be
	-- caused by a bid or an outbid.
	if (CurrentPage and
		doAuctionsMatchQuery(updatedAuctions, CurrentPage.query) and 
		reconcileAuctionLists(CurrentPage.auctions, updatedAuctions)) then
		debugPrint("onAuctionItemListUpdate() - query refresh");
		return;
	end

	-- Unknown update, so clear the page cache.
	debugPrint("onAuctionItemListUpdate() - unknown update");
	clearPageCache();
	CurrentPage = nil;
end

-------------------------------------------------------------------------------
-- Checks if we are awaiting the results of a query.
-------------------------------------------------------------------------------
function isQueryInProgress()
	return (table.getn(QueryRequestQueue) > 0 and QueryRequestQueue[1].querySent);
end

-------------------------------------------------------------------------------
-- Checks if we are awaiting the results of bid. This method may return a
-- different result than the bid manager because we could still be waiting for
-- the auction list to update as a result of a bid.
-------------------------------------------------------------------------------
function isBidInProgress()
	return (table.getn(PendingBidInfo) > 0);
end

-------------------------------------------------------------------------------
-- Creates a list of auctions on the current page using Blizzard's API.
-------------------------------------------------------------------------------
function getAuctionsOnCurrentPage()
	-- Get the contents of the page.
	local auctions = {};
	local lastIndexOnPage, totalAuctions = GetNumAuctionItems("list");
	for indexOnPage = 1, lastIndexOnPage do
		local auction = getAuctionByIndex("list", indexOnPage);
		table.insert(auctions, auction);
	end
	return auctions;
end

-------------------------------------------------------------------------------
-- Checks if two queries are the same (except for page number).
-------------------------------------------------------------------------------
function doQueriesMatch(query1, query2)
	if (query1.name == query2.name and
		query1.minLevel == query2.minLevel and
		query1.maxLevel == query2.maxLevel and
		query1.invTypeIndex == query2.invTypeIndex and
		query1.classIndex == query2.classIndex and
		query1.subclassIndex == query2.subclassIndex and
		query1.isUsable == query2.isUsable and
		query1.qualityIndex == query2.qualityIndex) then
		return true;
	end
	return false;
end

-------------------------------------------------------------------------------
-- Checks if the auctions all match the specified query.
-------------------------------------------------------------------------------
function doAuctionsMatchQuery(auctions, query)
	for _, auction in pairs(auctions) do
		local itemKey = Auctioneer.ItemDB.CreateItemKeyFromAuction(auction);
		if (not Auctioneer.SnapshotDB.DoesItemKeyMatchQuery(itemKey, query)) then
			return false;
		end
	end
	return true;
end

-------------------------------------------------------------------------------
-- Checks if the auctions match by signature.
-------------------------------------------------------------------------------
function reconcileAuctionLists(oldList, newList)
	-- First check if the its a list of the same auctions. Take into account
	-- auctions that are removed because of buyouts.
	local oldIndex = 1;
	local newIndex = 1;
	while (oldIndex < table.getn(oldList) and newIndex < table.getn(newList)) do
		local oldAuction = oldList[oldIndex];
		local oldSignature = Auctioneer.SnapshotDB.CreateAuctionSignatureFromAuction(oldAuction);
		local newAuction = newList[newIndex];
		local newSignature = Auctioneer.SnapshotDB.CreateAuctionSignatureFromAuction(newAuction);

		-- Check if the signatures match. If the signatures don't match it
		-- could be because an auction was bought out and is now missing from
		-- the new list.
		if (oldSignature == newSignature) then
			newIndex = newIndex + 1;
		else
			-- If the auction does not have an auction id then we cannot tell
			-- there was a pending buyout.
			if (oldAuction.auctionId == nil) then
				return false;
			end

			-- Check if there is a pending bid for this auction id.
			local bidInfo = PendingBidInfo[oldAuction.auctionId];
			if (bidInfo == nil or bidInfo.receivedAuctionItemListUpdate) then
				return false;
			end

			-- Check if the pending bid was a buyout. If not, it could not have
			-- been bought out.
			if (oldAuction.buyoutPrice ~= bidInfo.bid) then
				return false;
			end
		end
		oldIndex = oldIndex + 1;
	end
	
	-- Check if we matched up all the auctions in both lists.
	if (oldIndex ~= table.getn(oldList) and newIndex ~= table.getn(newList)) then
		return false;
	end

	-- Now that we know the lists match we need to update the cache and 
	-- snapshot.
	local oldIndex = 1;
	local newIndex = 1;
	while (oldIndex < table.getn(oldList) and newIndex < table.getn(newList)) do
		-- Get the auctions and their signatures.
		local oldAuction = oldList[oldIndex];
		local oldSignature = Auctioneer.SnapshotDB.CreateAuctionSignatureFromAuction(oldAuction);
		local newAuction = newList[newIndex];
		local newSignature = Auctioneer.SnapshotDB.CreateAuctionSignatureFromAuction(newAuction);

		-- Check if the signatures match.
		if (oldSignature == newSignature) then
			-- Check if the auction bid has changed.
			if (oldAuction.bidAmount ~= newAuction.bidAmount or 
				oldAuction.highBidder ~= newAuction.highBidder) then
				-- Update the old auction with the new auction.
				oldAuction.bidAmount = newAuction.bidAmount;
				oldAuction.highBidder = newAuction.highBidder;
				oldAuction.timeLeft = newAuction.timeLeft;
				oldAuction.lastSeen = newAuction.lastSeen;
				debugPrint("reconcileAuctionLists(): Updated auction at index "..oldIndex.." in cache");

				-- If we have an auction id for the old auction, inform the
				-- snapshot of the update.
				if (oldAuction.auctionId) then
					-- Update the snapshot.
					debugPrint("Updating auction "..oldAuction.auctionId.." in snapshot");
					Auctioneer.SnapshotDB.UpdateAuction(oldAuction);

					-- Update the pending bid list.
					local bidInfo = PendingBidInfo[oldAuction.auctionId];
					if (bidInfo) then
						if (bidInfo.receivedBidComplete) then
							PendingBidInfo[oldAuction.auctionId] = nil;
							debugPrint("Removed pending bid for auction "..oldAuction.auctionId);
						else
							bidInfo.receivedAuctionItemListUpdate = true;
							debugPrint("Deferring removal of pending bid for auction "..oldAuction.auctionId);
						end
					end
				end
			end

			-- Increment the lists.
			newIndex = newIndex + 1;
			oldIndex = oldIndex + 1;
		else
			-- The auction was bought out. Remove it from the page cache.
			table.remove(oldList, oldIndex);
			debugPrint("reconcileAuctionLists(): Removed auction "..oldAuction.auctionId.." from the cache");

			-- If we have an auction id for the old auction, inform the
			-- snapshot of the update.
			if (oldAuction.auctionId) then
				-- Update the snapshot.
				debugPrint("Removing auction "..oldAuction.auctionId.." from the snapshot");
				Auctioneer.SnapshotDB.RemoveAuction(oldAuction);

				-- Update the pending bid list.
				local bidInfo = PendingBidInfo[oldAuction.auctionId];
				if (bidInfo) then
					if (bidInfo.receivedBidComplete) then
						PendingBidInfo[oldAuction.auctionId] = nil;
						debugPrint("Removed pending bid for auction "..oldAuction.auctionId);
					else
						bidInfo.receivedAuctionItemListUpdate = true;
						debugPrint("Deferring removal of pending bid for auction "..oldAuction.auctionId);
					end
				end
			end
		end
	end
	
	return true;
end

-------------------------------------------------------------------------------
-- Adds a page to the cache.
-------------------------------------------------------------------------------
function addPageToCache(page, updateSnapshot)
	-- Check if this query matches the last query. If not, we need to toss the
	-- page cache and start a new one.
	if (not doQueriesMatch(PageCacheQuery, page.query)) then
		debugPrint("Clearing the page cache (query doesn't match last query)");
		PageCache = {};
		PageCacheQuery = page.query;
	end

	-- Add the page to the cache.
	PageCache[page.pageNum] = page;
	for _, auction in pairs(page.auctions) do
		Auctioneer.EventManager.FireEvent("AUCTIONEER_AUCTION_SEEN", auction);
	end
	debugPrint("Added page "..page.pageNum.." to the cache");
	
	-- Check if we have all the pages (numbering starts at 0).
	if (updateSnapshot) then
		local pageNum = 0;
		while (true) do
			local page = PageCache[pageNum];
			if (page == nil) then
				debugPrint("Still missing page "..pageNum);
				break;
			elseif (page.isLastPage) then
				debugPrint("Seen all "..(pageNum + 1).." page(s), updating snapshot");
				local auctions, scannedInReverse = getAuctionsInCache();
				Auctioneer.SnapshotDB.UpdateForQuery(nil, PageCacheQuery, auctions, (not scannedInReverse));
				clearPageCache();
				break;
			end
			pageNum = pageNum + 1;
		end
	end
end

-------------------------------------------------------------------------------
-- Gets the list of auctions in the cache.
-------------------------------------------------------------------------------
function getAuctionsInCache()
	local auctions = {};
	local scannedInReverse = true;
	for pageNum, page in pairs(PageCache) do
		-- Get the auctions on this page.
		local auctionsOnPage = page.auctions;

		-- Get the previous page, if any.
		local prevPage = PageCache[pageNum + 1];
		if (prevPage) then
			-- Check if the previous page was seen before this page.
			if (prevPage.lastSeen < page.lastSeen) then
				-- Yep, check for dups on the previous page.
				local auctionsOnPrevPage = prevPage.auctions;
				checkForDups(auctionsOnPage, auctionsOnPrevPage);
			else
				debugPrint("Scan was not done in reverse!");
				scannedInReverse = false;
			end
		end

		-- Add the auctions on this page the list.		
		for indexOnPage, auctionOnPage in pairs(auctionsOnPage) do
			table.insert(auctions, auctionOnPage);
		end
	end
	return auctions, scannedInReverse;
end

-------------------------------------------------------------------------------
-- Compares the auction against the previous page. If the auction matches an
-- auction on the previous page, the auction on the previous page is flagged
-- as a dup.
-------------------------------------------------------------------------------
function checkForDups(auctions, auctionsOnPrevPage)
	for _, auction in pairs(auctions) do
		local signature = Auctioneer.SnapshotDB.CreateAuctionSignatureFromAuction(auction);
		for _, auctionOnPrevPage in pairs(auctionsOnPrevPage) do
			if (not auctionOnPrevPage.dup and 
				signature == Auctioneer.SnapshotDB.CreateAuctionSignatureFromAuction(auctionOnPrevPage) and
				auction.bidAmount == auctionOnPrevPage.bidAmount and
				auction.timeLeft == auctionOnPrevPage.timeLeft) then
				debugPrint("Marking auction as potential dup");
				auctionOnPrevPage.dup = true;
				return;
			end
		end
	end
end

-------------------------------------------------------------------------------
-- Clears the cached pages for the query.
-------------------------------------------------------------------------------
function clearPageCache()
	PageCache = {};
	PageCacheQuery = {};
end

-------------------------------------------------------------------------------
-- Creates an auction structure from the listType and index. All of the fields
-- in the auction structure and nil safe. The auctionId field will always be
-- nil. The auctionId can be obtained by calling getAuctionId();
-------------------------------------------------------------------------------
function getAuctionByIndex(listType, index)
	local auction;
	local lastIndexOnPage, totalAuctions = GetNumAuctionItems("list");
	if (index >= 0 and index <= lastIndexOnPage) then
		auction = {};
		auction.ahKey = Auctioneer.Util.GetAuctionKey();

		-- Get the item link and decompose it.
		local itemLink = GetAuctionItemLink(listType, index);
		if (itemLink) then
			local itemId, suffixId, enchantId, uniqueId = EnhTooltip.BreakLink(itemLink);
			auction.itemId = nilSafeNumber(itemId);
			auction.suffixId = nilSafeNumber(suffixId);
			auction.enchantId = nilSafeNumber(enchantId);
			auction.uniqueId = nilSafeNumber(uniqueId);
		else
			auction.itemId = 0;
			auction.suffixId = 0;
			auction.enchantId = 0;
			auction.uniqueId = 0;
		end
		
		-- Get the auction information.
		local name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner = GetAuctionItemInfo(listType, index);
		auction.name = nilSafeString(name);
		auction.texture = nilSafeString(texture);
		auction.count = nilSafeNumber(count);
		auction.quality = nilSafeNumber(quality);
		auction.canUse = (canUse ~= nil);
		auction.level = nilSafeNumber(level);
		auction.minBid = nilSafeNumber(minBid);
		auction.minIncrement = nilSafeNumber(minIncrement);
		auction.buyoutPrice = nilSafeNumber(buyoutPrice);
		auction.bidAmount = nilSafeNumber(bidAmount);
		auction.highBidder = (highBidder ~= nil);
		auction.owner = nilSafeString(owner);
	
		-- Get the time left.
		local timeLeft = GetAuctionItemTimeLeft(listType, index);
		auction.timeLeft = timeLeft or 0;

		-- Add the last seen as now.
		auction.lastSeen = time();
	end
	return auction;
end

-------------------------------------------------------------------------------
-- Gets the auction id for auction at the specified index. This may result in
-- a partial snapshot update if the auction id isn't already known. If the
-- auction id cannot be determined (such as for non "list" auctions), nil is
-- reutrned.
-------------------------------------------------------------------------------
function getAuctionId(listType, index)
	if (listType == "list") then
		if (CurrentPage) then
			-- Get the signature of the auction in question.
			local auction = CurrentPage.auctions[index];
			if (auction.auctionId == nil) then
				-- Get a list of all auctions in our cache that match the
				-- signature of the auciton in question.
				local auctions = {};
				local signature = Auctioneer.SnapshotDB.CreateAuctionSignatureFromAuction(auction);
				for _, thisPage in pairs(PageCache) do
					for _, thisAuction in pairs(thisPage.auctions) do
						local thisSignature = Auctioneer.SnapshotDB.CreateAuctionSignatureFromAuction(thisAuction);
						if (signature == thisSignature) then
							table.insert(auctions, thisAuction);
						end
					end
				end

				-- Do a partial update of the snapshot so we auction ids get assigned.
				debugPrint("Updating snapshot with partial results for "..signature);
				Auctioneer.SnapshotDB.UpdateForSignature(nil, signature, auctions, true);
			end
			
			-- Return the auction id of the auction.
			return auction.auctionId;
		else
			debugPrint("GetAuctionId() - ignoring due to no last query!");
		end
	else
		debugPrint("GetAuctionId() - ignoring due to invalid listType!");
	end
end

-------------------------------------------------------------------------------
-- Checks if an auction has valid values. This method should be used to
-- validate auctions before adding them to the database. That way we can
-- insure the the validity of the database.
-------------------------------------------------------------------------------
function isAuctionValid(auction)
	-- Must have an auction. Duh!
	if (auction == nil) then
		debugPrint("isAuctionValid() - false (no auction)");
		return false;
	end
	
	-- Must have a name.
	if (auction.name == "") then
		debugPrint("isAuctionValid() - false (bad name)");
		return false;
	end

	-- Must have a count.
	if (auction.count < 1) then
		debugPrint("isAuctionValid() - false (bad count)");
		return false;
	end

	-- Must have a valid bid.
	if (auction.minBid < 1 or auction.minBid > Auctioneer.Core.Constants.MaxAllowedFormatInt) then
		debugPrint("isAuctionValid() - false (bad minBid)");
		return false;
	end
	
	-- Must have a valid buyout.
	if (auction.buyoutPrice < 0 or auction.buyoutPrice > Auctioneer.Core.Constants.MaxAllowedFormatInt) then
		debugPrint("isAuctionValid() - false (bad buyoutPrice)");
		return false;
	end

	-- Must have a valid bid amount.
	if (auction.bidAmount < 0 or auction.bidAmount > Auctioneer.Core.Constants.MaxAllowedFormatInt) then
		debugPrint("isAuctionValid() - false (bad bidAmount)");
		return false;
	end

	-- Must have a valid owner.
	if (auction.owner == "") then
		debugPrint("isAuctionValid() - false (bad owner)");
		return false;
	end

	return true;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function nilSafeString(string)
	if (string == nil) then
		return "";
	end
	return string;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function nilSafeNumber(number)
	if (number == nil) then
		return 0;
	end
	return number;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function normalizeNumericQueryParam(param)
	if (param ~= nil) then
		if (type(param) == "string") then
			if (param == "") then
				param = nil;
			else
				param = tonumber(param);
			end
		end
	end
	return param;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function debugPrint(message)
	EnhTooltip.DebugPrint("[Auc.QueryManager] "..date("%X")..": "..message);
end

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
Auctioneer.QueryManager =
{
	Load = load;
	QueryAuctionItems = queryAuctionItems;
	GetAuctionId = getAuctionId;
	GetAuctionByIndex = getAuctionByIndex;
	IsAuctionValid = isAuctionValid;
	IsQueryInProgress = isQueryInProgress;
	CanSendAuctionQuery = canSendAuctionQuery;
	ClearPageCache = clearPageCache;
}
