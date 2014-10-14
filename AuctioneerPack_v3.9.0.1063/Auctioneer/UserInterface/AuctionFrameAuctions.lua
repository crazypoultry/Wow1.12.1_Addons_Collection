--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: <%version%> (<%codename%>)
	Revision: $Id: AuctionFrameAuctions.lua 1037 2006-10-04 06:41:04Z vindicator $

	Auctioneer Auctions tab

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
local onNewAuctionUpdate;
local postAuctionFrameShow;
local auctionsSetLine;
local auctionsSetWarn;
local setAuctionDuration;
local getCurrentAuctionItemKeyAndCount;
local debugPrint;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
local ignoreAuctionDurationChange = false;

-- The item key and count of the current item up for auction.
local currentAuctionItemKey;
local currentAuctionCount;

-------------------------------------------------------------------------------
-- Called once Blizzard's Blizzard_AuctionUI is loaded.
-------------------------------------------------------------------------------
function load()
	debugPrint("Loading");

	AuctionsPriceText:ClearAllPoints();
	AuctionsPriceText:SetPoint("TOPLEFT", "AuctionsItemText", "TOPLEFT", 0, -53);
	AuctionsBuyoutText:ClearAllPoints();
	AuctionsBuyoutText:SetPoint("TOPLEFT", "AuctionsPriceText", "TOPLEFT", 0, -33);
	AuctionsBuyoutErrorText:ClearAllPoints();
	AuctionsBuyoutErrorText:SetPoint("TOPLEFT", "AuctionsBuyoutText", "TOPLEFT", 0, -29);
	AuctionsDurationText:ClearAllPoints();
	AuctionsDurationText:SetPoint("TOPLEFT", "AuctionsBuyoutErrorText", "TOPLEFT", 0, -7);
	AuctionsDepositText:ClearAllPoints();
	AuctionsDepositText:SetPoint("TOPLEFT", "AuctionsDurationText", "TOPLEFT", 0, -31);
	if (AuctionInfo ~= nil) then
		AuctionInfo:ClearAllPoints();
		AuctionInfo:SetPoint("TOPLEFT", "AuctionsDepositText", "TOPLEFT", -4, -33);
	end

	AuctionsShortAuctionButtonText:SetText("2");
	AuctionsMediumAuctionButton:SetPoint("TOPLEFT", "AuctionsDurationText", "BOTTOMLEFT", 3, 1);
	AuctionsMediumAuctionButtonText:SetText("8");
	AuctionsMediumAuctionButton:ClearAllPoints();
	AuctionsMediumAuctionButton:SetPoint("BOTTOMLEFT", "AuctionsShortAuctionButton", "BOTTOMRIGHT", 20,0);
	AuctionsLongAuctionButtonText:SetText("24 "..HOURS);
	AuctionsLongAuctionButton:ClearAllPoints();
	AuctionsLongAuctionButton:SetPoint("BOTTOMLEFT", "AuctionsMediumAuctionButton", "BOTTOMRIGHT", 20,0);

	if (AuctionInfo) then
		AuctionInfo:SetParent("AuctionFrameAuctions")
		AuctionInfo:SetPoint("TOPLEFT", "AuctionsDepositText", "TOPLEFT", -4, -51)
		AuctionInfo:Show()

		AuctPriceRemember:SetParent("AuctionFrameAuctions")
		AuctPriceRemember:SetPoint("TOPLEFT", "AuctionsDepositText", "BOTTOMLEFT", 0, -6)
		AuctPriceRemember:Show()
		AuctPriceRememberText:SetText(_AUCT('GuiRememberText'))
		AuctPriceRememberCheck:SetParent("AuctionFrameAuctions")
		AuctPriceRememberCheck:SetPoint("TOPLEFT", "AuctionsDepositText", "BOTTOMLEFT", 0, -2)
		AuctPriceRememberCheck:Show()
	end

	-- Register for events and hook methods.
	Stubby.RegisterEventHook("NEW_AUCTION_UPDATE", "Auctioneer_AuctionFrameAuctions", onNewAuctionUpdate);
	Stubby.RegisterFunctionHook("AuctionFrame_Show", 200, postAuctionFrameShow);
	Stubby.RegisterFunctionHook("AuctionsRadioButton_OnClick", 200, postAuctionsRadioButtonOnClick);
end

-------------------------------------------------------------------------------
-- Called on Blizzard's NEW_AUCTION_UPDATE event.
-------------------------------------------------------------------------------
function onNewAuctionUpdate()
	-- Clear any current auctioneer information displayed.
	auctionsClear();

	-- If there's an item, display the new auctioneer information.
	local ahKey = Auctioneer.Util.GetAuctionKey();
	local itemKey, count = getCurrentAuctionItemKeyAndCount();
	if (ahKey and itemKey and count) then
		-- Set the historical median information.
		local historicalMedian, historicalMedCount = Auctioneer.Statistic.GetItemHistoricalMedianBuyout(itemKey);
		auctionsSetLine(1, string.format(_AUCT('FrmtAuctinfoHist'), historicalMedCount), historicalMedian * count);

		-- Set the snapshot median information.
		local snapshotMedian, snapshotMedCount = Auctioneer.Statistic.GetItemSnapshotMedianBuyout(itemKey);
		auctionsSetLine(2, string.format(_AUCT('FrmtAuctinfoSnap'), snapshotMedCount), snapshotMedian * count);

		-- Set the lowest buyout found in the snapshot.
		local currentLowestBuyout;
		local auctionWithLowestBuyout = Auctioneer.Statistic.GetAuctionWithLowestBuyout(itemKey, ahKey);
		if (auctionWithLowestBuyout) then
			currentLowestBuyout = Auctioneer.Util.PriceForOne(auctionWithLowestBuyout.buyoutPrice, auctionWithLowestBuyout.count);
		end
		if (currentLowestBuyout) then
			auctionsSetLine(3, _AUCT('FrmtAuctinfoLow'), currentLowestBuyout * count);
		else
			auctionsSetLine(3, _AUCT('FrmtAuctinfoNolow'));
		end

		-- Set the remaining lines.
		local blizzardPrice = MoneyInputFrame_GetCopper(StartPrice);
		local bidPrice, buyPrice, marketPrice, warn = Auctioneer.Statistic.GetSuggestedResale(itemKey, ahKey, count);
		debugPrint("Got suggested price for "..itemKey..": bidPrice="..bidPrice.."; buyPrice="..buyPrice.."; marketPrice="..marketPrice.."; warn="..warn);

		local fixedPrice = Auctioneer.FixedPriceDB.GetFixedPrice(itemKey, ahKey);
		if (fixedPrice) then
			auctionsSetLine(4, _AUCT('FrmtAuctinfoSugbid'), bidPrice);
			auctionsSetLine(5, _AUCT('FrmtAuctinfoSugbuy'), buyPrice);
			auctionsSetWarn(_AUCT('FrmtWarnUser'));
			MoneyInputFrame_SetCopper(StartPrice, (fixedPrice.bid / fixedPrice.count) * count);
			MoneyInputFrame_SetCopper(BuyoutPrice, (fixedPrice.buyout / fixedPrice.count) * count);
			setAuctionDuration(tonumber(fixedPrice.duration));
		elseif (buyPrice > 0) then
			if (Auctioneer.Command.GetFilter('autofill')) then
				auctionsSetLine(4, _AUCT('FrmtAuctinfoMktprice'), marketPrice);
				auctionsSetLine(5, _AUCT('FrmtAuctinfoOrig'), blizzardPrice);
				auctionsSetWarn(warn);
				MoneyInputFrame_SetCopper(StartPrice, bidPrice);
				MoneyInputFrame_SetCopper(BuyoutPrice, buyPrice);
			else
				auctionsSetLine(4, _AUCT('FrmtAuctinfoSugbid'), bidPrice);
				auctionsSetLine(5, _AUCT('FrmtAuctinfoSugbuy'), buyPrice);
				auctionsSetWarn(warn);
			end
		else
			auctionsSetWarn(warn);
		end

		-- Check the set fixed price check box if we have a fixed price.	
		if (fixedPrice) then
			AuctPriceRememberCheck:SetChecked(true)
		else
			AuctPriceRememberCheck:SetChecked(false)
		end
	end

	-- Cache the current auction item and count.
	currentAuctionItemKey = itemKey;
	currentAuctionCount = count;
end

-------------------------------------------------------------------------------
-- Called after Blizzard's AuctionFrame_Show()
-------------------------------------------------------------------------------
function postAuctionFrameShow()
	-- Set the default auction duration
	if (Auctioneer.Command.GetFilterVal('auction-duration') > 0) then
		setAuctionDuration(Auctioneer.Command.GetFilterVal('auction-duration'))
	else
		setAuctionDuration(Auctioneer.Command.GetFilterVal('last-auction-duration'))
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function auctionsSetLine(line, textStr, moneyAmount)
	local text = getglobal("AuctionInfoText"..line);
	local money = getglobal("AuctionInfoMoney"..line);
	if (text == nil) then debugPrint("Error, no text for AuctionInfo line "..line); end
	if (money == nil) then debugPrint("Error, no money for AuctionInfo line "..line); end
	text:SetText(textStr);
	text:Show();
	if (money ~= nil) then
		MoneyFrame_Update("AuctionInfoMoney"..line, math.ceil(Auctioneer.Util.NullSafe(moneyAmount)));
		getglobal("AuctionInfoMoney"..line.."SilverButtonText"):SetTextColor(1.0,1.0,1.0);
		getglobal("AuctionInfoMoney"..line.."CopperButtonText"):SetTextColor(0.86,0.42,0.19);
		money:Show();
	else
		money:Hide();
	end
end

-------------------------------------------------------------------------------
-- Sets the warning text.
-------------------------------------------------------------------------------
function auctionsSetWarn(textStr)
	if (AuctionInfoWarnText == nil) then debugPrint("Error, no text for AuctionInfo line "..line); end
	local cHex, cRed, cGreen, cBlue = Auctioneer.Util.GetWarnColor(textStr)
	AuctionInfoWarnText:SetText(textStr);
	AuctionInfoWarnText:SetTextColor(cRed, cGreen, cBlue);
	AuctionInfoWarnText:Show();
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function setAuctionDuration(duration, persist)
	local durationIndex
	if (duration >= 1 and duration <= 3) then
		durationIndex = duration
	elseif (duration == 120) then
		durationIndex = 1
	elseif (duration == 480) then
		durationIndex = 2
	elseif (duration == 1440) then
		durationIndex = 3
	else
		debugPrint("setAuctionDuration(): invalid duration ", duration)
		return
	end

	if (not persist) then ignoreAuctionDurationChange = true; end
	AuctionsRadioButton_OnClick(durationIndex);
end

-------------------------------------------------------------------------------
-- Called after Blizzard's AuctionsRadioButton_OnClick()
-------------------------------------------------------------------------------
function postAuctionsRadioButtonOnClick()
	if (ignoreAuctionDurationChange) then
		ignoreAuctionDurationChange = false;
		return
	end
	Auctioneer.Command.SetFilter('last-auction-duration', AuctionFrameAuctions.duration)
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctPriceRememberCheck_OnClick()
	if (not currentAuctionItemKey) then
		AuctPriceRememberCheck:SetChecked(false)
		return
	end

	if (not AuctPriceRememberCheck:GetChecked()) then
		Auctioneer.FixedPriceDB.RemoveFixedPrice(currentAuctionItemKey)
	else
		local fixedPrice = {};
		fixedPrice.bid = MoneyInputFrame_GetCopper(StartPrice);
		fixedPrice.buyout = MoneyInputFrame_GetCopper(BuyoutPrice);
		fixedPrice.count = currentAuctionCount;
		fixedPrice.duration = AuctionFrameAuctions.duration;
		Auctioneer.FixedPriceDB.SetFixedPrice(currentAuctionItemKey, nil, fixedPrice);
	end
end

-------------------------------------------------------------------------------
-- Hides the Auctioneer information text.
-------------------------------------------------------------------------------
function auctionsClear()
	for i = 1, 5 do
		getglobal("AuctionInfoText"..i):Hide();
		getglobal("AuctionInfoMoney"..i):Hide();
	end
	AuctionInfoWarnText:Hide();
end

-------------------------------------------------------------------------------
-- Gets the item key for the current auction item. Returns nil if none.
-------------------------------------------------------------------------------
function getCurrentAuctionItemKeyAndCount()
	local itemKey;
	local name, texture, count, quality, canUse, price = GetAuctionSellItemInfo();
	if (name) then
		-- Get the id of the item up for auction.
		local bag, slot, id, rprop, enchant, uniq = EnhTooltip.FindItemInBags(name);

		-- If it wasn't in one of the bags, check if it was a bag.
		if (bag == nil) then
			local i
			for i = 0, 4, 1 do
				if name == GetBagName(i) then
					id, rprop, enchant, uniq = EnhTooltip.BreakLink(GetInventoryItemLink("player", ContainerIDToInventoryID(i)))
					break
				end
			end
		end

		if (id and rprop and enchant) then
			itemKey = id..":"..rprop..":"..enchant;
		end
	end
	return itemKey, count;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function debugPrint(message)
	EnhTooltip.DebugPrint("[Auc.AuctionsTab] "..message);
end

--=============================================================================
-- Initialization
--=============================================================================
if (Auctioneer.UI.AuctionsTab ~= nil) then return end;
debugPrint("AuctioneerFrameAuctions.lua loaded");

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
Auctioneer.UI.AuctionsTab = 
{
	Load = load;
	RememberPrice = rememberPrice;
};
