--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.9.0.1063 (Kangaroo)
	Revision: $Id: AucFilter.lua 1003 2006-09-25 07:46:12Z vindicator $

	Auctioneer filtering functions.
	Functions to filter auctions based upon various parameters.

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
local isAuctionExpired;
local getSecondsLeftForAuction;
local getMyHighestBuyouts;

local profitFilter;
local auctionOwnerFilter;
local competitionFilter;
local itemFilter;

local doBroker;
local doBidBroker;
local doCompeting;
local doPercentLess;

local debugPrint;

-------------------------------------------------------------------------------
-- Determines if this auction in the snapshot has expired.
-------------------------------------------------------------------------------
function isAuctionExpired(auction)
	local elapsedTime = time() - auction.lastSeen;
	local secondsLeft = Auctioneer.Core.Constants.TimeLeft.Seconds[auction.timeLeft] - elapsedTime;
	return (secondsLeft <= 0);
end

-------------------------------------------------------------------------------
-- Gets the maximum number of seconds left for the auction.
-------------------------------------------------------------------------------
function getSecondsLeftForAuction(auction)
	local elapsedTime = time() - auction.lastSeen;
	return Auctioneer.Core.Constants.TimeLeft.Seconds[auction.timeLeft] - elapsedTime;
end

-------------------------------------------------------------------------------
-- Returns a map of itemKeys -> highest buyout for the player's own auctions.
-------------------------------------------------------------------------------
function getMyHighestBuyouts(ahKey)
	if (not auctKey) then auctKey = Auctioneer.Util.GetAuctionKey() end

	-- Get the list of our own auctions.
	local myAuctions = Auctioneer.SnapshotDB.Query(
		ahKey,
		nil,
		function (auction)
			return (auction.buyoutPrice and auction.buyoutPrice > 0 and auction.owner == UnitName("player"));
		end);

	-- Construct the map of itemKey -> highest buyout.			
	local myHighestBuyouts = {};
	for _, myAuction in pairs(myAuctions) do
		local myBuyout = myAuction.buyoutPrice / myAuction.count;
		local myItemKey = Auctioneer.ItemDB.CreateItemKeyFromAuction(myAuction);
		local myHighestBuyout = myHighestBuyouts[myItemKey];
		if (myHighestBuyout == nil or myBuyout > myHighestBuyout) then
			myHighestBuyouts[myItemKey] = myBuyout;
		end
	end

	return myHighestBuyouts;
end

-------------------------------------------------------------------------------
-- Snapshot query filter function that matches auctions based on resale
-- profit for bids.
-- 
-- filterArgs can contain:
--     itemNames
--     categoryName
--     minQuality
--     maxSecondsLeft
--     minBidProfit
--     minBidProfitPercent
--     minBidPercentLess
--     minBuyoutProfit
--     minBuyoutProfitPercent
--     minBuyoutPercentLess
-------------------------------------------------------------------------------
function profitFilter(auction, filterArgs)
	--local debug = true;
	if (debug) then debugPrint("profitFilter - checking auction: "..auction.auctionId) end;
	local itemKey = Auctioneer.ItemDB.CreateItemKeyFromAuction(auction);
	local itemInfo = Auctioneer.ItemDB.GetItemInfo(itemKey);

	-- Check the item category
	local categoryName = filterArgs.categoryName;
	if (categoryName and itemInfo.categoryName ~= categoryName) then
		return false;
	end

	-- Check the item quality
	local minQuality = filterArgs.minQuality;
	if (minQuality and itemInfo.quality < minQuality) then
		if (debug) then debugPrint("No match due to quality") end;
		return false;
	end

	-- Check the names
	local itemNames = filterArgs.itemNames;
	if (itemNames) then
		local match = false;
		for _, itemName in pairs(itemNames) do
			match = Auctioneer.Database.DoesNameMatch(itemInfo.name, itemName, false);
			if (match) then break end;
		end
		if (not match) then
			if (debug) then debugPrint("No match due to name") end;
			return false;
		end
	end

	-- Check for auction expiration.
	if (isAuctionExpired(auction)) then
		if (debug) then debugPrint("No match due to expired auction (lastSeen="..date("%x", auction.lastSeen)..")") end;
		return false;
	end

	-- Check the time left.
	local maxSecondsLeft = filterArgs.maxSecondsLeft;
	if (maxSecondsLeft and getSecondsLeftForAuction(auction) > maxSecondsLeft) then
		if (debug) then debugPrint("No match due to time left") end;
		return false;
	end

	-- Check for resale profit.
	local minBidProfit = filterArgs.minBidProfit;
	local minBidProfitPercent = filterArgs.minBidProfitPercent;
	local minBidPercentLess = filterArgs.minBidPercentLess;
	local minBuyoutProfit = filterArgs.minBuyoutProfit;
	local minBuyoutProfitPercent = filterArgs.minBuyoutProfitPercent;
	local minBuyoutPercentLess = filterArgs.minBuyoutPercentLess
	if (minBidProfit or minBidProfitPercent or minBidPercentLess or minBuyoutProfit or minBuyoutProfitPercent or minBuyoutPercentLess) then
		-- Check for a usable median
		if (Auctioneer.Statistic.GetUsableMedian(itemKey, auction.ahKey) == nil) then
			if (debug) then debugPrint("No match due to no usable mean") end;
			return false;
		end

		-- Check the seen count.
		local hsp, seenCount = Auctioneer.Statistic.GetHSP(itemKey, auction.ahKey);
		if (seenCount < Auctioneer.Core.Constants.MinBuyoutSeenCount) then
			if (debug) then debugPrint("No match due to seen count") end;
			return false;
		end

		-- Check the profit from bidding.
		if (minBidProfit or minBidProfitPercent or minBidPercentLess) then
			-- Calculate the bid profit.
			local bidProfit, bidProfitPercent, bidPercentLess = Auctioneer.Statistic.GetBidProfit(auction, hsp);

			-- Check the minimum bid profit.
			if (minBidProfit and bidProfit < minBidProfit) then
				if (debug) then debugPrint("No match due bid profit") end;
				return false;
			end
		
			-- Check the minimum bid profit percent.
			if (minBidProfitPercent and bidProfitPercent < minBidProfitPercent) then
				if (debug) then debugPrint("No match due bid profit percentage") end;
				return false;
			end

			-- Check the minimum bid percent less then HSP.
			if (minBidPercentLess and bidPercentLess < minBidPercentLess) then
				if (debug) then debugPrint("No match due bid profit percent less") end;
				return false;
			end
		end
		
		-- Check the profit from buying out.
		if (minBuyoutProfit or minBuyoutProfitPercent or minBuyoutPercentLess) then
			-- Calculate the buyout profit (no buyout means no match).
			if (auction.buyoutPrice == nil or auction.buyoutPrice == 0) then
				if (debug) then debugPrint("No match due to no buyout") end;
				return false;
			end
			local buyoutProfit, buyoutProfitPercent, buyoutPercentLess = Auctioneer.Statistic.GetBuyoutProfit(auction, hsp);
		
			-- Check the minimum buyout profit.
			if (minBuyoutProfit and buyoutProfit < minBuyoutProfit) then
				if (debug) then debugPrint("No match due buyout price (profit was "..buyoutProfit..")") end;
				return false;
			end
		
			-- Check the minimum buyout profit percent.
			if (minBuyoutProfitPercent and buyoutProfitPercent < minBuyoutProfitPercent) then
				if (debug) then debugPrint("No match due buyout price percent") end;
				return false;
			end

			-- Check the minimum buyout percent less then HSP
			if (minBuyoutPercentLess and buyoutPercentLess < minBuyoutPercentLess) then
				if (debug) then debugPrint("No match due buyout price percent less") end;
				return false;
			end
		end

		-- Check if its a bad resale choice.
		if (Auctioneer.Statistic.IsBadResaleChoice(auction)) then
			if (debug) then debugPrint("No match due bad resale choice") end;
			return false;
		end
	end

	-- If we make it this far, its a match!
	if (debug) then debugPrint("MATCH!") end;
	return true;
end

-------------------------------------------------------------------------------
-- Snapshot query filter function that matches auctions based on owner.
-- 
-- filterArgs should contain:
--     owner
-------------------------------------------------------------------------------
function auctionOwnerFilter(auction, filterArgs)
	-- Normalize the filter arguments.
	local owner = filterArgs.owner;

	-- Check the owner.
	if (owner and auction.owner ~= owner) then
		return false;
	end
	
	-- If we make it this far, its a match!
	return true;
end

-------------------------------------------------------------------------------
-- Snapshot query filter function that matches auctions based on competing
-- auctions undercutting.
--
-- filterArgs could contain:
--     minLess
-------------------------------------------------------------------------------
function competitionFilter(auction, filterArgs)
	--local debug = true;
	if (debug) then debugPrint("competitionFilter - checking auction: "..auction.auctionId) end;
	local itemKey = Auctioneer.ItemDB.CreateItemKeyFromAuction(auction);

	-- Normalize the filter arguments.
	local minLess = filterArgs.minLess;
	if (minLess == nil) then minLess = 0 end;
	local myHighestBuyouts = filterArgs.myHighestBuyouts;
	if (myHighestBuyouts == nil) then return false end;
	
	-- Check that the auction has a buyout
	if (auction.buyoutPrice == nil or auction.buyoutPrice == 0) then
		if (debug) then debugPrint("No match due to no buyout") end;
		return false;
	end

	-- Check the owner (must not match the current player)
	if (auction.owner == UnitName("player")) then
		if (debug) then debugPrint("No match due to own auction") end;
		return false;
	end
	
	-- Check for auction expiration.
	if (isAuctionExpired(auction)) then
		if (debug) then debugPrint("No match due to expired auction") end;
		return false;
	end

	-- Check the buyout price against our price.
	local myHighestBuyout = myHighestBuyouts[itemKey];
	local buyout = auction.buyoutPrice / auction.count;
	if (myHighestBuyout == nil) then
		if (debug) then debugPrint("No match due to no auctions") end;
		return false;
	end
	if (buyout + minLess > myHighestBuyout) then
		if (debug) then debugPrint("No match due to high buyout price") end;
		return false;
	end
	
	-- If we make it this far, its a match!
	if (debug) then debugPrint("MATCH!") end;
	return true;
end

-------------------------------------------------------------------------------
-- Snapshot query filter function that matches auctions based item properties.
--
-- filterArgs can contain:
--     itemNames
--     categoryName
--     minQuality
--     maxBuyout
-------------------------------------------------------------------------------
function itemFilter(auction, filterArgs)
	--local debug = true;
	if (debug) then debugPrint("itemFilter - checking auction: "..auction.auctionId) end;

	-- Check for a maximum buyout price.
	local maxBuyout = filterArgs.maxBuyout;
	if (maxBuyout and maxBuyout > 0) then
		if (auction.buyoutPrice == nil or auction.buyoutPrice == 0) then
			if (debug) then debugPrint("No match due to no buyout") end;
			return false;
		elseif (auction.buyoutPrice > maxBuyout) then
			if (debug) then debugPrint("No match due to maximum buyout") end;
			return false;
		end
	end

	-- Check for auction expiration.
	if (isAuctionExpired(auction)) then
		if (debug) then debugPrint("No match due to expired auction") end;
		return false;
	end

	-- Get the item info so we can check item properties such as name
	-- and quality.
	local itemKey = Auctioneer.ItemDB.CreateItemKeyFromAuction(auction);
	local itemInfo = Auctioneer.ItemDB.GetItemInfo(itemKey);

	-- Check the item category
	local categoryName = filterArgs.categoryName;
	if (categoryName and itemInfo.categoryName ~= categoryName) then
		return false;
	end

	-- Check the item quality
	local minQuality = filterArgs.minQuality;
	if (minQuality and itemInfo.quality < minQuality) then
		if (debug) then debugPrint("No match due to quality") end;
		return false;
	end

	-- Check the names
	local itemNames = filterArgs.itemNames;
	if (itemNames) then
		local match = false;
		for _, itemName in pairs(itemNames) do
			match = Auctioneer.Database.DoesNameMatch(itemInfo.name, itemName, false);
			if (match) then break end;
		end
		if (not match) then
			if (debug) then debugPrint("No match due to name") end;
			return false;
		end
	end

	-- If we make it this far, its a match!
	if (debug) then debugPrint("MATCH!") end;
	return true;
end

-------------------------------------------------------------------------------
-- Builds the list of auctions that can be bought and resold for profit based
-- on buyout and a minimum profit.
-------------------------------------------------------------------------------
function doBroker(minProfit)
	-- Normalize the arguments.
	if not minProfit or minProfit == "" then
		minProfit = Auctioneer.Core.Constants.MinProfitMargin
	elseif (tonumber(minProfit)) then
		minProfit = tonumber(minProfit) * 100
	else
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActUnknown'), minProfit))
		return
	end

	-- Query the snapshot and sort the results by descending profit.
	local filterArgs = {};
	filterArgs.minBuyoutProfit = minProfit;
	local auctions = Auctioneer.SnapshotDB.Query(nil, nil, profitFilter, filterArgs);
	table.sort(auctions, function(a, b) return (Auctioneer.Statistic.GetBuyoutProfit(a) > Auctioneer.Statistic.GetBuyoutProfit(b)) end);

	-- Output the list of auctions
	local output = string.format(_AUCT('FrmtBrokerHeader'), EnhTooltip.GetTextGSC(minProfit));
	Auctioneer.Util.ChatPrint(output);
	for _,auction in pairs(auctions) do
		local itemKey = Auctioneer.ItemDB.CreateItemKeyFromAuction(auction);
		local itemInfo = Auctioneer.ItemDB.GetItemInfo(itemKey);
		local itemLink = Auctioneer.ItemDB.GetItemLink(itemKey);
		local hsp, seenCount = Auctioneer.Statistic.GetHSP(itemKey, auction.ahKey);
		local profit = Auctioneer.Statistic.GetBuyoutProfit(auction, hsp);
		local buyout = auction.buyoutPrice;
		local count = auction.count;
		local output = string.format(_AUCT('FrmtBrokerLine'), Auctioneer.Util.ColorTextWhite(auction.count.."x")..itemLink, seenCount, EnhTooltip.GetTextGSC(hsp * count), EnhTooltip.GetTextGSC(buyout), EnhTooltip.GetTextGSC(profit));
		Auctioneer.Util.ChatPrint(output);
	end
	Auctioneer.Util.ChatPrint(_AUCT('FrmtBrokerDone'));
end

-------------------------------------------------------------------------------
-- Builds the list of auctions that can be bought and resold for profit based
-- on bid and a minimum profit.
-------------------------------------------------------------------------------
function doBidBroker(minProfit)
	-- Normalize the arguments.
	if not minProfit or minProfit == "" then
		minProfit = Auctioneer.Core.Constants.MinProfitMargin;
	elseif (tonumber(minProfit)) then
		minProfit = tonumber(minProfit) * 100
	else
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActUnknown'), minProfit))
		return;
	end

	-- Query the snapshot and sort the results by increasing time left.
	local filterArgs = {};
	filterArgs.minBidProfit = minProfit;
	filterArgs.maxSecondsLeft = Auctioneer.Core.Constants.TimeLeft.Seconds[Auctioneer.Core.Constants.TimeLeft.Medium];
	local auctions = Auctioneer.SnapshotDB.Query(nil, nil, profitFilter, filterArgs);
	table.sort(auctions, function(a, b) return (a.timeLeft < b.timeLeft) end);

	-- Output the list of auctions
	local output = string.format(_AUCT('FrmtBidbrokerHeader'), EnhTooltip.GetTextGSC(minProfit));
	Auctioneer.Util.ChatPrint(output);
	for _,auction in pairs(auctions) do
		local bidText = _AUCT('FrmtBidbrokerCurbid');
		if (auction.bidAmount == nil or auction.bidAmount == 0) then
			bidText = _AUCT('FrmtBidbrokerMinbid');
		end
		local itemKey = Auctioneer.ItemDB.CreateItemKeyFromAuction(auction);
		local itemInfo = Auctioneer.ItemDB.GetItemInfo(itemKey);
		local itemLink = Auctioneer.ItemDB.GetItemLink(itemKey);
		local hsp, seenCount = Auctioneer.Statistic.GetHSP(itemKey, auction.ahKey);
		local count = auction.count;
		local currentBid = Auctioneer.SnapshotDB.GetCurrentBid(auction);
		local profit = Auctioneer.Statistic.GetBidProfit(auction, hsp);
		local timeLeft = auction.timeLeft;
		local output = string.format(_AUCT('FrmtBidbrokerLine'), Auctioneer.Util.ColorTextWhite(count.."x")..itemLink, seenCount, EnhTooltip.GetTextGSC(hsp * count), bidText, EnhTooltip.GetTextGSC(currentBid), EnhTooltip.GetTextGSC(profit), Auctioneer.Util.ColorTextWhite(Auctioneer.Util.GetTimeLeftString(timeLeft)));
		Auctioneer.Util.ChatPrint(output);
	end
	Auctioneer.Util.ChatPrint(_AUCT('FrmtBidbrokerDone'));
end

-------------------------------------------------------------------------------
-- Builds a list of competing auctions under cutting the players own auctions.
-------------------------------------------------------------------------------
function doCompeting(minLess)
	-- Normalize the arguments.
	if not minLess or minLess == "" then
		minLess = Auctioneer.Core.Constants.DefaultCompeteLess * 100
	elseif (tonumber(minLess)) then
		minLess = tonumber(minLess) * 100
	else
		Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActUnknown'), minLess))
		return
	end

	-- Query the snapshot for competing auctions
	local filterArgs = {};
	filterArgs.minLess = minLess;
	filterArgs.myHighestBuyouts = getMyHighestBuyouts();
	local auctions = Auctioneer.SnapshotDB.Query(nil, nil, competitionFilter, filterArgs);
	table.sort(auctions, function(a, b) return (Auctioneer.Statistic.GetBuyoutProfit(a) > Auctioneer.Statistic.GetBuyoutProfit(b)) end);

	-- Output the list of auctions undercutting auctions.
	local output = string.format(_AUCT('FrmtCompeteHeader'), EnhTooltip.GetTextGSC(minLess));
	Auctioneer.Util.ChatPrint(output);
	for _,auction in pairs(auctions) do
		local itemKey = Auctioneer.ItemDB.CreateItemKeyFromAuction(auction);
		local itemInfo = Auctioneer.ItemDB.GetItemInfo(itemKey);
		local itemLink = Auctioneer.ItemDB.GetItemLink(itemKey);
		local count = auction.count;

		local bidPrice = "No bids ("..auction.minBid..")";
		if (auction.bidAmount) then
			local bidPrice = EnhTooltip.GetTextGSC(auction.bidAmount / auction.count).."ea";
		end

		local myBuyout = filterArgs.myHighestBuyouts[itemKey];
		local buyPrice = EnhTooltip.GetTextGSC(auction.buyoutPrice / auction.count).."ea";
		local myPrice = EnhTooltip.GetTextGSC(myBuyout).."ea";
		local priceLess = myBuyout - (auction.buyoutPrice / auction.count);
		local lessPrice = EnhTooltip.GetTextGSC(priceLess);
	
		local output = string.format(_AUCT('FrmtCompeteLine'), Auctioneer.Util.ColorTextWhite(count.."x")..itemLink, bidPrice, buyPrice, myPrice, lessPrice);
		Auctioneer.Util.ChatPrint(output);
	end
	Auctioneer.Util.ChatPrint(_AUCT('FrmtCompeteDone'));
end

-------------------------------------------------------------------------------
-- builds the list of auctions that can be bought and resold for profit based
-- on a buyout below HSP by a percentage.
-------------------------------------------------------------------------------
function doPercentLess(percentLess)
	-- Normalize the arguments.
	if not percentLess or percentLess == "" then percentLess = Auctioneer.Core.Constants.MinPercentLessThanHSP end

	-- Query the snapshot and sort the results by increasing time left.
	local filterArgs = {};
	filterArgs.minBuyoutPercentLess = percentLess;
	local auctions = Auctioneer.SnapshotDB.Query(nil, nil, profitFilter, filterArgs);
	table.sort(auctions, function(a, b) return (Auctioneer.Statistic.GetBuyoutProfit(a) > Auctioneer.Statistic.GetBuyoutProfit(b)) end);

	-- Output the list of auctions
	local output = string.format(_AUCT('FrmtPctlessHeader'), percentLess);
	Auctioneer.Util.ChatPrint(output);
	for _,auction in pairs(auctions) do
		local itemKey = Auctioneer.ItemDB.CreateItemKeyFromAuction(auction);
		local itemInfo = Auctioneer.ItemDB.GetItemInfo(itemKey);
		local itemLink = Auctioneer.ItemDB.GetItemLink(itemKey);
		local hsp, seenCount = Auctioneer.Statistic.GetHSP(itemKey, auction.ahKey);
		local count = auction.count;
		local buyout = auction.buyoutPrice;
		local profit = (hsp * count) - buyout;
		local output = string.format(_AUCT('FrmtPctlessLine'), Auctioneer.Util.ColorTextWhite(count.."x")..itemLink, seenCount, EnhTooltip.GetTextGSC(hsp * count), EnhTooltip.GetTextGSC(buyout), EnhTooltip.GetTextGSC(profit), Auctioneer.Util.ColorTextWhite(Auctioneer.Statistic.PercentLessThan(hsp, buyout / count).."%"));
		Auctioneer.Util.ChatPrint(output);
	end
	Auctioneer.Util.ChatPrint(_AUCT('FrmtPctlessDone'));
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function debugPrint(message)
	EnhTooltip.DebugPrint("[Auc.Filter] "..message);
end

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
Auctioneer.Filter =
{
	DoBroker = doBroker,
	DoBidBroker = doBidBroker,
	DoCompeting = doCompeting,
	DoPercentLess = doPercentLess,

	CompetitionFilter = competitionFilter,
	ProfitFilter = profitFilter;
	ItemFilter = itemFilter;

	GetMyHighestBuyouts = getMyHighestBuyouts;
}
