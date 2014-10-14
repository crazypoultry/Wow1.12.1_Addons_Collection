--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.9.0.1063 (Kangaroo)
	Revision: $Id: AucScanManager.lua 1046 2006-10-06 05:25:28Z vindicator $

	ScanManager - manages AH scanning

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
local isScanning;
local scan;
local scanAll;
local scanCategories;
local scanQuery;
local cancelScan;
local addRequestToQueue;
local removeRequestFromQueue;
local sendQuery;
local queryCompleteCallback;
local scanStarted;
local scanEnded;
local updateScanProgressUI;
local onAuctionAdded;
local onAuctionUpdated;
local onAuctionRemoved;
local debugPrint;

-------------------------------------------------------------------------------
-- Public Data
-------------------------------------------------------------------------------
local RequestState = 
{
	WaitingToQuery = "WaitingToQuery";
	WaitingForQueryResult = "WaitingForQueryResult";
	Done = "Done";
	Canceled = "Canceled";
	Failed = "Failed";
}

-------------------------------------------------------------------------------
-- Private Data
-------------------------------------------------------------------------------

-- Queue of scan requests.
local RequestQueue = {};

-- Counters that keep track of the number of auctions added, updated or removed
-- during the course of a scan.
local AuctionsScanned = 0;
local AuctionsAdded = 0;
local AuctionsUpdated = 0;
local AuctionsRemoved = 0;
local LastRequestResult = RequestState.Done;

-- The original OnEvent and Update methods for AuctionFrameBrowse. These are
-- overridden when a scan is in progress so that the UI doesn't update.
local Original_AuctionFrameBrowse_OnEvent = nil;
local Original_AuctionFrameBrowse_Update = nil;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function load()
	Stubby.RegisterEventHook("AUCTION_HOUSE_CLOSED", "Auctioneer_ScanManager", onEventHook);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AucScanManager_OnUpdate()
	local request = RequestQueue[1];
	if (request) then
		if (request.state == RequestState.WaitingToQuery and Auctioneer.QueryManager.CanSendAuctionQuery()) then
			if (not Scanning) then
				scanStarted();
			end
			sendQuery(request);
		end
	elseif (Scanning) then
		scanEnded();
	end
end

-------------------------------------------------------------------------------
-- OnEvent handler.
-------------------------------------------------------------------------------
function onEventHook(_, event)
	if (event == "AUCTION_HOUSE_CLOSED") then
		cancelScan();
	end
end

-------------------------------------------------------------------------------
-- Checks if a scan is in progress.
-------------------------------------------------------------------------------
function isScanning()
	return Scanning;
end

-------------------------------------------------------------------------------
-- Starts an AH scan of the categories selected in the UI.
-------------------------------------------------------------------------------
function scan()
	-- Get the list of categories checked (by index).
	categories = {};
	local allCategories = {GetAuctionItemClasses()};
	for category, name in pairs(allCategories) do
		if (tostring(Auctioneer.Command.GetFilterVal("scan-class"..category)) == "on") then
			table.insert(categories, category);
		end
	end
	
	-- Scan everything or only selected categories?
	if (table.getn(allCategories) == table.getn(categories)) then
		debugPrint("Scanning all categories");
		return scanAll();
	else
		debugPrint("Scanning "..table.getn(categories).." categories");
		return scanCategories(categories);
	end
end

-------------------------------------------------------------------------------
-- Starts an AH scan of all auctions.
-------------------------------------------------------------------------------
function scanAll()
	if (table.getn(RequestQueue) == 0) then
		-- Construct a scan all request.
		local request = {};
		request.description = _AUCT('TextAuction');
		addRequestToQueue(request);
		return true;
	else
		debugPrint("Cannot start scan because a scan is already in progress!");
		return false;
	end
end

-------------------------------------------------------------------------------
-- Starts an AH scan of the specified categories.
-------------------------------------------------------------------------------
function scanCategories(categories)
	if (table.getn(RequestQueue) == 0) then
		-- Construct a scan request for each category requested.
		for index, category in pairs(categories) do
			local request = {};
			request.description = Auctioneer.ItemDB.GetCategoryName(category);
			request.classIndex = category;
			addRequestToQueue(request);
		end
		return true;
	else
		debugPrint("Cannot start scan because a scan is already in progress!");
		return false;
	end
end

-------------------------------------------------------------------------------
-- Starts an AH scan base on a query.
-------------------------------------------------------------------------------
function scanQuery(name, minLevel, maxLevel, invTypeIndex, classIndex, subclassIndex, page, isUsable, qualityIndex)
	if (table.getn(RequestQueue) == 0) then
		-- Construct the scan request.
		local request = {};
		request.description = _AUCT('TextAuction');
		request.name = name;
		request.minLevel = minLevel;
		request.maxLevel = maxLevel;
		request.invTypeIndex = invTypeIndex;
		request.classIndex = classIndex;
		request.subclassIndex = subclassIndex;
		request.page = page;
		request.isUsable = isUsable;
		request.qualityIndex = qualityIndex;
		addRequestToQueue(request);
		return true;
	else
		debugPrint("Cannot start scan because a scan is already in progress!");
		return false;
	end
end

-------------------------------------------------------------------------------
-- Cancels any in progress scan.
-------------------------------------------------------------------------------
function cancelScan()
	-- %todo: We should probaby wait for the result of any query that is in
	-- progress.
	while (table.getn(RequestQueue) > 0) do
		local request = RequestQueue[1];
		request.state = RequestState.Canceled;
		removeRequestFromQueue();
	end
end

-------------------------------------------------------------------------------
-- Adds a request to the back of the queue.
-------------------------------------------------------------------------------
function addRequestToQueue(request)
	request.pages = 0;
	request.totalAuctions = 0;
	request.nextPage = 0;
	request.auctionsScanned = 0;
	request.state = RequestState.WaitingToQuery;
	table.insert(RequestQueue, request);
	debugPrint("Added request to back of queue");
end

-------------------------------------------------------------------------------
-- Removes the request at the head of the queue.
-------------------------------------------------------------------------------
function removeRequestFromQueue()
	if (table.getn(RequestQueue) > 0) then
		-- Remove the request from the queue.
		local request = RequestQueue[1];
		table.remove(RequestQueue, 1);
		debugPrint("Removed request from queue with result: "..request.state);

		-- If the request succeeded, add the auctions scanned to the total.
		LastRequestResult = request.state;
		if (LastRequestResult == RequestState.Done) then
			AuctionsScanned = request.auctionsScanned;
		end
	end
end

-------------------------------------------------------------------------------
-- Sends the next query
-------------------------------------------------------------------------------
function sendQuery(request)
	-- If this is the first query of the request, update the UI to say so.
	if (request.totalAuctions == 0) then
		BrowseNoResultsText:SetText(string.format(_AUCT('AuctionScanStart'), request.description));
	end

	-- Send the query!
	debugPrint("Requesting page "..request.nextPage);
	request.state = RequestState.WaitingForQueryResult;
	Auctioneer.QueryManager.QueryAuctionItems(
		request.name,
		request.minLevel,
		request.maxLevel,
		request.invTypeIndex,
		request.classIndex,
		request.subclassIndex,
		request.nextPage,
		request.isUsable,
		request.qualityIndex,
		10,
		3,
		queryCompleteCallback);
end

-------------------------------------------------------------------------------
-- Called when our query request completes.
-------------------------------------------------------------------------------
function queryCompleteCallback(query, result)
	local request = RequestQueue[1];
	if (request and request.state == RequestState.WaitingForQueryResult) then
		-- Update the current request with query results.
		local request = RequestQueue[1];
		if (result == QueryAuctionItemsResultCodes.Complete or result == QueryAuctionItemsResultCodes.PartialComplete) then
			-- Query succeeded so update the request.
			debugPrint("Scanned page "..request.nextPage);
			local lastIndexOnPage, totalAuctions = GetNumAuctionItems("list");
			
			-- Is this the first query?
			if (request.totalAuctions == 0) then
				-- This was the first query to get the total number of auctions.
				request.totalAuctions = totalAuctions;
				request.pages = math.floor((totalAuctions - 1) / NUM_AUCTION_ITEMS_PER_PAGE) + 1;
				if (request.pages == 1) then
					-- There's one and only one page. Tally the auctions
					-- scanned and we are done!
					request.nextPage = -1;
					request.auctionsScanned = request.auctionsScanned + lastIndexOnPage;
				else
					-- More then one page so we'll scan in reverse so as to
					-- not miss any auctions.
					request.startTime = GetTime();
					request.nextPage = request.pages - 1;
					Auctioneer.QueryManager.ClearPageCache();
				end
				debugPrint("Found "..request.totalAuctions.." auctions ("..request.pages.." pages)");
			else
				-- Tweak the start time if it happened in less than 5 seconds.
				local currentTime = GetTime();
				local timeElapsed = currentTime - request.startTime;
				local pagesScanned = request.pages - request.nextPage;
				local minTimeElapsed = 5.0 * (pagesScanned);
				debugPrint(pagesScanned.." pages scanned thus far in "..timeElapsed);
				if (timeElapsed < minTimeElapsed) then
					debugPrint("Adjusted request.startTime to keep the time remaining accurate.");
					request.startTime = currentTime - minTimeElapsed;
				end
				updateScanProgressUI();

				-- This was a subsequent query.
				request.nextPage = request.nextPage - 1;
				request.auctionsScanned = request.auctionsScanned + lastIndexOnPage;
			end
			
			-- Check if the scan is complete.
			if (request.nextPage < 0) then
				-- Request is complete!
				debugPrint("Reached the first page");
				request.state = RequestState.Done;
				removeRequestFromQueue();
			else
				-- More pages to go...
				request.state = RequestState.WaitingToQuery;
			end
		else
			-- Query failed!
			debugPrint("Aborting request due to failed query!");
			request.state = RequestState.Failed
			removeRequestFromQueue();
		end
	else
		debugPrint("WARNING: Received query complete callback in unexpected state");
	end
end

-------------------------------------------------------------------------------
-- Called when a scan starts.
-------------------------------------------------------------------------------
function scanStarted()
	-- Don't allow AuctionFramBrowse updates during a scan.
	Original_AuctionFrameBrowse_OnEvent = AuctionFrameBrowse_OnEvent;
	AuctionFrameBrowse_OnEvent = function() end;
	Original_AuctionFrameBrowse_Update = AuctionFrameBrowse_Update;
	AuctionFrameBrowse_Update = function() end;

	-- Hide the results UI
	BrowseNoResultsText:SetText("");
	BrowseNoResultsText:Show();
	for iButton = 1, NUM_BROWSE_TO_DISPLAY do
		button = getglobal("BrowseButton"..iButton);
		button:Hide();
	end
	BrowsePrevPageButton:Hide();
	BrowseNextPageButton:Hide();
	BrowseSearchCountText:Hide();
	BrowseBidButton:Disable();
	BrowseBuyoutButton:Disable();

	-- Initialize the counters for this scan.
	AuctionsScanned = 0;
	AuctionsAdded = 0;
	AuctionsUpdated = 0;
	AuctionsRemoved = 0;

	-- Register for snapshot update events so we can track how many auctions
	-- are added, updated and removed.
	Auctioneer.EventManager.RegisterEvent("AUCTIONEER_AUCTION_ADDED", onAuctionAdded);
	Auctioneer.EventManager.RegisterEvent("AUCTIONEER_AUCTION_UPDATED", onAuctionUpdated);
	Auctioneer.EventManager.RegisterEvent("AUCTIONEER_AUCTION_REMOVED", onAuctionRemoved);

	-- Scanning has begun!
	Scanning = true;
	Auctioneer.Scanning.IsScanningRequested = true;
	Auctioneer.QueryManager.ClearPageCache();
	debugPrint("Scan started");
end

-------------------------------------------------------------------------------
-- Called when a scan ends.
-------------------------------------------------------------------------------
function scanEnded()
	-- Scanning has ended!
	Scanning = false;
	Auctioneer.Scanning.IsScanningRequested = false;
	debugPrint("Scan ended with result: "..LastRequestResult);

	-- Unregister for snapshot events.
	Auctioneer.EventManager.UnregisterEvent("AUCTIONEER_AUCTION_ADDED", onAuctionAdded);
	Auctioneer.EventManager.UnregisterEvent("AUCTIONEER_AUCTION_UPDATED", onAuctionUpdated);
	Auctioneer.EventManager.UnregisterEvent("AUCTIONEER_AUCTION_REMOVED", onAuctionRemoved);

	-- Compile the results.
	local chatResultText;
	local uiResultText;
	if (LastRequestResult == RequestState.Done) then
		chatResultText = "Scan complete"; -- %todo: Localize
		uiResultText = "Auctioneer: auction scanning finished"; -- %todo: Localize
	elseif (LastRequestResult == RequestState.Canceled) then
		chatResultText = "Scan canceled"; -- %todo: Localize
		uiResultText = "Auctioneer: auction scanning canceled"; -- %todo: Localize
	else
		chatResultText = "Scan failed"; -- %todo: Localize
		uiResultText = "Auctioneer: auction scanning failed"; -- %todo: Localize
	end
	local auctionsScannedMessage = AuctionsScanned.." auctions scanned"; -- %todo: Localize
	local auctionsAddedMessage = AuctionsAdded.." auctions added"; -- %todo: Localize
	local auctionsRemovedMessage = AuctionsRemoved.." auctions removed"; -- %todo: Localize
	local auctionsUpdatedMessage = AuctionsUpdated.." auctions updated"; -- %todo: Localize

	-- Report the result to the chat window.
	chatPrint(chatResultText..":");
	chatPrint(auctionsScannedMessage);
	chatPrint(auctionsAddedMessage);
	chatPrint(auctionsRemovedMessage);
	chatPrint(auctionsUpdatedMessage);

	-- Report the result to the UI.
	local text = uiResultText.."\n"..auctionsScannedMessage.."\n"..auctionsAddedMessage.."\n"..auctionsRemovedMessage.."\n"..auctionsUpdatedMessage.."\n";
	BrowseNoResultsText:SetText(text);

	--The followng was added by MentalPower to implement the "/auc finish-sound" command 
	if (Auctioneer.Command.GetFilter("finish-sound")) then 
		PlaySoundFile("Interface\\AddOns\\Auctioneer\\Sounds\\ScanComplete.ogg") 
	end 

	--The followng was added by MentalPower to implement the "/auc finish" command
	local finish = Auctioneer.Command.GetFilterVal('finish');
	if (finish == 1) then
		Logout();
	elseif (finish == 2) then
		Quit();
	elseif (finish == 3) then
		if(ReloadUIHandler) then
			ReloadUIHandler("10");
		else
			ReloadUI();
		end
	end

	-- We can allow AuctionFramBrowse updates once again.
	if( Original_AuctionFrameBrowse_OnEvent ) then
		AuctionFrameBrowse_OnEvent = Original_AuctionFrameBrowse_OnEvent;
		Original_AuctionFrameBrowse_OnEvent = nil;
	end
	if( Original_AuctionFrameBrowse_Update ) then
		AuctionFrameBrowse_Update = Original_AuctionFrameBrowse_Update;
		Original_AuctionFrameBrowse_Update = nil;
	end

	--Cleaning up after oneself is always a good idea.
	collectgarbage();
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function updateScanProgressUI()
	if (table.getn(RequestQueue) > 0) then
		local request = RequestQueue[1];
		
		-- Check if we've completed a page yet...
		local pagesScanned = request.pages - request.nextPage;
		if (pagesScanned > 0) then
			local auctionsScanned = pagesScanned * NUM_AUCTION_ITEMS_PER_PAGE;
			local pagesLeftToScan = request.pages - pagesScanned;
			local auctionsLeftToScan = pagesLeftToScan * NUM_AUCTION_ITEMS_PER_PAGE;
			local secondsElapsed = (GetTime() - request.startTime);
			local auctionsScannedPerSecond = math.floor((auctionsScanned * 100) / secondsElapsed) / 100;
			local secondsLeft = auctionsLeftToScan / auctionsScannedPerSecond;

			-- Update the progress of this request in the UI.
			BrowseNoResultsText:SetText(
				string.format(_AUCT('AuctionPageN'),
					request.description,
					request.pages - request.nextPage,
					request.pages,
					tostring(auctionsScannedPerSecond),
					SecondsToTime((secondsLeft))));
		end
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function onAuctionAdded()
	AuctionsAdded = AuctionsAdded + 1;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function onAuctionUpdated()
	AuctionsUpdated = AuctionsUpdated + 1;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function onAuctionRemoved()
	AuctionsRemoved = AuctionsRemoved + 1;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function debugPrint(message)
	EnhTooltip.DebugPrint("[Auc.ScanManager] "..message);
end

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
Auctioneer.ScanManager =
{
	Load = load;
	Scan = scan;
	ScanAll = scanAll;
	ScanCategories = scanCategories;
	ScanQuery = scanQuery;
	IsScanning = isScanning;
	
}

-- This is the variable Auctioneer use to use to indicate scanning. Keep it for
-- compatbility with addons such as AuctionFilterPlus.
Auctioneer.Scanning =
{
	IsScanningRequested = false;
}

