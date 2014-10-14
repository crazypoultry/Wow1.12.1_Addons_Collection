--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.9.0.1063 (Kangaroo)
	Revision: $Id: AucTooltip.lua 1037 2006-10-04 06:41:04Z vindicator $

	Auctioneer tooltip functions.
	Functions to present and draw the tooltips.

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

--Local function prototypes
local hookTooltip


function hookTooltip(funcVars, retVal, frame, name, link, quality, count)
	EnhTooltip.DebugPrint("Displaying "..name)
	if (not link) then EnhTooltip.DebugPrint("No link was passed to the client");  return; end

	-- nothing to do, if auctioneer is disabled
	if (not Auctioneer.Command.GetFilter("all")) then
		return;
	end;

	if EnhTooltip.LinkType(link) ~= "item" then return end

	-- initialize local variables
	local itemID, randomProp, enchant, uniqID, lame = EnhTooltip.BreakLink(link);
	local embedded = Auctioneer.Command.GetFilter('embed');

	-- OUTPUT: seperator line
	if (embedded) then
		if (Auctioneer.Command.GetFilter('show-embed-blankline')) then
			EnhTooltip.AddLine(" ", nil, embedded);
		end
	else
		EnhTooltip.AddLine(name, nil, embedded);
		EnhTooltip.LineQuality(quality);
	end

	if (Auctioneer.Command.GetFilter('show-link')) then
		-- OUTPUT: show item link
		EnhTooltip.AddLine("Link: " .. itemID .. ":" .. enchant .. ":" .. randomProp .. ":" .. uniqID, nil, embedded);
		EnhTooltip.LineQuality(quality);
	end

	local itemInfo = nil;

	-- show item info
	if (itemID > 0) then
		frame.eDone = 1;
		local ahKey = Auctioneer.Util.GetAuctionKey();
		local itemKey = Auctioneer.ItemDB.CreateItemKeyFromLink(link);
		local itemTotals = Auctioneer.HistoryDB.GetItemTotals(itemKey, ahKey);

		-- show auction info
		if (itemTotals == nil or itemTotals.seenCount == 0) then
			-- OUTPUT: "Never seen at auction"
			EnhTooltip.AddLine(string.format(_AUCT('FrmtInfoNever'), _AUCT('TextAuction')), nil, embedded);
			EnhTooltip.LineColor(0.5, 0.8, 0.5);
		else -- (itemTotals.seenCount > 0)
			-- calculate auction values
			local avgMin = math.floor(itemTotals.minPrice / itemTotals.minCount);

			local bidPct = math.floor(itemTotals.bidCount / itemTotals.minCount * 100);
			local avgBid = 0;
			if (itemTotals.bidCount > 0) then
				avgBid = math.floor(itemTotals.bidPrice / itemTotals.bidCount);
			end

			local buyPct = math.floor(itemTotals.buyoutCount / itemTotals.minCount * 100);
			local avgBuy = 0;
			if (itemTotals.buyoutCount > 0) then
				avgBuy = math.floor(itemTotals.buyoutPrice / itemTotals.buyoutCount);
			end

			local median, medCount = Auctioneer.Statistic.GetUsableMedian(itemKey, ahKey);

			if (Auctioneer.Command.GetFilter('show-average')) then -- show item's average auction price
				-- OUTPUT: "Seen [itemTotals.seenCount] times at auction total"
				EnhTooltip.AddLine(string.format(_AUCT('FrmtInfoSeen'), itemTotals.seenCount), nil, embedded);
				EnhTooltip.LineColor(0.5,0.8,0.1);
				if (not Auctioneer.Command.GetFilter('show-verbose')) then -- default mode
					-- OUTPUT: "[avgMin] min/[avgBuy] BO ([avgBid] bid)"
					EnhTooltip.AddLine(string.format(_AUCT('FrmtInfoAverage'), EnhTooltip.GetTextGSC(avgMin), EnhTooltip.GetTextGSC(avgBuy), EnhTooltip.GetTextGSC(avgBid)), nil, embedded);
					EnhTooltip.LineColor(0.1,0.8,0.5);
				else -- verbose mode
					if (count > 1) then
						-- OUTPUT: "Averages for [count] items:"
						EnhTooltip.AddLine(string.format(_AUCT('FrmtInfoHeadMulti'), count), nil, embedded);
						EnhTooltip.LineColor(0.4,0.5,1.0);
						-- OUTPUT: "  Minimum ([avgMin] ea)"
						EnhTooltip.AddLine(string.format(_AUCT('FrmtInfoMinMulti'), EnhTooltip.GetTextGSC(avgMin)), avgMin*count, embedded);
						EnhTooltip.LineColor(0.4,0.5,0.8);
						if (Auctioneer.Command.GetFilter('show-stats')) then -- show buyout/bidded percentages
							-- OUTPUT: "  Bidded ([bidPct]%, [avgBid] ea)"
							EnhTooltip.AddLine(string.format(_AUCT('FrmtInfoBidMulti'), bidPct.."%, ", EnhTooltip.GetTextGSC(avgBid)), avgBid*count, embedded);
							EnhTooltip.LineColor(0.4,0.5,0.85);
							-- OUTPUT: "  Buyout ([buyPct]%, [avgBuy] ea)"
							EnhTooltip.AddLine(string.format(_AUCT('FrmtInfoBuyMulti'), buyPct.."%, ", EnhTooltip.GetTextGSC(avgBuy)), avgBuy*count, embedded);
							EnhTooltip.LineColor(0.4,0.5,0.9);
						else -- don't show buyout/bidded percentages
							-- OUTPUT: "  Bidded ([avgBid] ea)"
							EnhTooltip.AddLine(string.format(_AUCT('FrmtInfoBidMulti'), "", EnhTooltip.GetTextGSC(avgBid)), avgBid*count, embedded);
							EnhTooltip.LineColor(0.4,0.5,0.85);
							-- OUTPUT: "  Buyout ([avgBuy] ea)"
							EnhTooltip.AddLine(string.format(_AUCT('FrmtInfoBuyMulti'), "", EnhTooltip.GetTextGSC(avgBuy)), avgBuy*count, embedded);
							EnhTooltip.LineColor(0.4,0.5,0.9);
						end
						if (median) then
							-- OUTPUT: "  Buyout median"
							EnhTooltip.AddLine(_AUCT('FrmtInfoBuymedian'), median * count, embedded);
							EnhTooltip.LineColor(0.4,0.5,0.95);
						end
					else -- (count = 0 | 1)
					   -- OUTPUT: "Averages for this item:"
						EnhTooltip.AddLine(_AUCT('FrmtInfoHeadOne'), nil, embedded);
						EnhTooltip.LineColor(0.4,0.5,1.0);
						-- OUTPUT: "  Minimum bid"
						EnhTooltip.AddLine(_AUCT('FrmtInfoMinOne'), avgMin, embedded);
						EnhTooltip.LineColor(0.4,0.5,0.8);
						if (Auctioneer.Command.GetFilter('show-stats')) then -- show buyout/bidded percentages
							-- OUTPUT: "  Bidded [bidPct]%"
							EnhTooltip.AddLine(string.format(_AUCT('FrmtInfoBidOne'), " "..bidPct.."%"), avgBid, embedded);
							EnhTooltip.LineColor(0.4,0.5,0.85);
							-- OUTPUT: "  Buyout [buyPct]%"
							EnhTooltip.AddLine(string.format(_AUCT('FrmtInfoBuyOne'), " "..buyPct.."%"), avgBuy, embedded);
							EnhTooltip.LineColor(0.4,0.5,0.9);
						else -- don't show buyout/bidded percentages
						   -- OUTPUT: "  Bidded [bidPct]%"
							EnhTooltip.AddLine(string.format(_AUCT('FrmtInfoBidOne'), ""), avgBid, embedded);
							EnhTooltip.LineColor(0.4,0.5,0.85);
							-- OUTPUT: "  Buyout [buyPct]%"
							EnhTooltip.AddLine(string.format(_AUCT('FrmtInfoBuyOne'), ""), avgBuy, embedded);
							EnhTooltip.LineColor(0.4,0.5,0.9);
						end
						if (median) then
							-- OUTPUT: "  Buyout median"
							EnhTooltip.AddLine(_AUCT('FrmtInfoBuymedian'), median, embedded);
							EnhTooltip.LineColor(0.4,0.5,0.95);
						end
					end
				end
			end -- if(Auctioneer.Command.GetFilter('show-average')) - show item's average auction price

			if median and Auctioneer.Command.GetFilter('show-median') then -- show item's median buyout price
				local historicalMedian, historicalMedCount = Auctioneer.Statistic.GetItemHistoricalMedianBuyout(itemKey, ahKey);
				local snapshotMedian, snapshotMedCount = Auctioneer.Statistic.GetItemSnapshotMedianBuyout(itemKey, ahKey);
				if historicalMedian and historicalMedCount > Auctioneer.Util.NullSafe(snapshotMedCount)  then
					-- OUTPUT: "Last [historicalMedCount], median BO (ea)"
					EnhTooltip.AddLine(string.format(_AUCT('FrmtInfoHistmed'), historicalMedCount), historicalMedian, embedded)
					EnhTooltip.LineColor(0.1,0.8,0.5);
				end
				if snapshotMedian then
					-- OUTPUT: "Scanned [snapshotMedCount], median BO (ea)"
					EnhTooltip.AddLine(string.format(_AUCT('FrmtInfoSnapmed'), snapshotMedCount), snapshotMedian, embedded)
					EnhTooltip.LineColor(0.1,0.8,0.5);
				end
			end

			-- seperate line for suggested auction price (for clarification, even if the values have already been shown somewhere else
			if (Auctioneer.Command.GetFilter('show-suggest')) then -- show item's suggested auction price
				local bidPrice, buyPrice, marketPrice, warn = Auctioneer.Statistic.GetSuggestedResale(itemKey, ahKey, count);
				if (count > 1) then
					-- OUTPUT: "Suggested price for your [count] stack: [bidPrice] min/[buyPrice] BO"
					EnhTooltip.AddLine(string.format(_AUCT('FrmtInfoSgststx'), count, EnhTooltip.GetTextGSC(bidPrice, true), EnhTooltip.GetTextGSC(buyPrice, true)), nil, embedded);
					EnhTooltip.LineColor(0.5,0.5,0.8);
				else -- count = 0 | 1
					-- OUTPUT: "Suggested price: [bidPrice] min/[buyPrice] BO"
					EnhTooltip.AddLine(string.format(_AUCT('FrmtInfoSgst'), EnhTooltip.GetTextGSC(bidPrice, true), EnhTooltip.GetTextGSC(buyPrice, true)), nil, embedded);
					EnhTooltip.LineColor(0.5,0.5,0.8);
				end
				EnhTooltip.AddLine(warn, nil, embedded);
				local cHex, cRed, cGreen, cBlue = Auctioneer.Util.GetWarnColor(warn);
				EnhTooltip.LineColor(cRed, cGreen, cBlue);
			end
			if (not Auctioneer.Command.GetFilter('show-verbose')) then
				if (Auctioneer.Command.GetFilter('show-stats')) then -- show buyout/bidded percentages
					-- OUTPUT: "[bidPct]% have bid, [buyPct]% have BO"
					EnhTooltip.AddLine(string.format(_AUCT('FrmtInfoBidrate'), bidPct, buyPct), nil, embedded);
					EnhTooltip.LineColor(0.1,0.5,0.8);
				end
			end
		end -- (itemTotals.seenCount > 0)

		local also = Auctioneer.Command.GetFilterVal("also");
		if (Auctioneer.Util.IsValidAlso(also)) and (also ~= "off") then

			if (also == "opposite") then
				also = Auctioneer.Util.GetOppositeKey();

			elseif (also == "neutral") then
				also = Auctioneer.Util.GetNeutralKey();

			elseif (also == "home") then
				also = Auctioneer.Util.GetHomeKey();
			end

			if (also == ahKey) then return end;

			local itemTotals = Auctioneer.HistoryDB.GetItemTotals(itemKey, ahKey);

			if (itemTotals == nil or itemTotals.seenCount == 0) then
				EnhTooltip.AddLine(string.format(">> ".._AUCT('FrmtInfoNever'), also), nil, embedded);
				EnhTooltip.LineColor(0.5,0.8,0.1);
			else
				-- calculate auction values
				local avgMin = math.floor(itemTotals.minPrice / itemTotals.minCount);

				local bidPct = math.floor(itemTotals.bidCount / itemTotals.minCount * 100);
				local avgBid = 0;
				if (itemTotals.bidCount > 0) then
					avgBid = math.floor(itemTotals.bidPrice / itemTotals.bidCount);
				end

				local buyPct = math.floor(itemTotals.buyoutCount / itemTotals.minCount * 100);
				local avgBuy = 0;
				if (itemTotals.buyoutCount > 0) then
					avgBuy = math.floor(itemTotals.buyoutPrice / itemTotals.buyoutCount);
				end

				if (Auctioneer.Command.GetFilter('show-average')) then
					EnhTooltip.AddLine(string.format(">> ".._AUCT('FrmtInfoAlsoseen'), itemTotals.seenCount, also), nil, embedded);
					EnhTooltip.LineColor(0.5,0.8,0.1);
					EnhTooltip.AddLine(string.format(">> ".._AUCT('FrmtInfoAverage'), EnhTooltip.GetTextGSC(avgMin), EnhTooltip.GetTextGSC(avgBuy), EnhTooltip.GetTextGSC(avgBid)), nil, embedded);
					EnhTooltip.LineColor(0.1,0.8,0.5);
				end

				if (Auctioneer.Command.GetFilter('show-stats')) then
					EnhTooltip.AddLine(string.format(">> ".._AUCT('FrmtInfoBidrate'), bidPct, buyPct), nil, embedded);
					EnhTooltip.LineColor(0.1,0.5,0.8);
				end

				-- seperate line for suggested auction price (for clarification, even if the values have already been shown somewhere else
				if (Auctioneer.Command.GetFilter('show-suggest')) then -- show item's suggested auction price
					local bidPrice, buyPrice, marketPrice, warn = Auctioneer.Statistic.GetSuggestedResale(itemKey, also, count);
					if (count > 1) then
						-- OUTPUT: "Suggested price for your [count] stack: [bidPrice] min/[buyPrice] BO"
						EnhTooltip.AddLine(string.format(">> ".._AUCT('FrmtInfoSgststx'), count, EnhTooltip.GetTextGSC(bidPrice, true), EnhTooltip.GetTextGSC(buyPrice, true)), nil, embedded);
						EnhTooltip.LineColor(0.5,0.5,0.8);
					else -- count = 0 | 1
						-- OUTPUT: "Suggested price: [bidPrice] min/[buyPrice] BO"
						EnhTooltip.AddLine(string.format(">> ".._AUCT('FrmtInfoSgst'), EnhTooltip.GetTextGSC(bidPrice, true), EnhTooltip.GetTextGSC(buyPrice, true)), nil, embedded);
						EnhTooltip.LineColor(0.5,0.5,0.8);
					end
					EnhTooltip.AddLine(">> "..warn, nil, embedded);
					local cHex, cRed, cGreen, cBlue = Auctioneer.Util.GetWarnColor(warn);
					EnhTooltip.LineColor(cRed, cGreen, cBlue);
				end
			end
		end
	end
end

Auctioneer.Tooltip = {
	HookTooltip = hookTooltip,
}
