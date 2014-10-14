--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: <%version%> (<%codename%>)
	Revision: $Id: AuctionFramePost.lua 1047 2006-10-06 07:47:26Z vindicator $

	Auctioneer Post Auctions tab

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
local postAuctionFrameTab_OnClickHook;
local onAuctionAdded;
local onAuctionUpdated;
local onAuctionRemoved;
local onSnapshotUpdate;
local debugPrint;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function load()
	debugPrint("Loading");
	local frame = AuctionFramePost;

	-- Methods
	frame.CalculateAuctionDeposit = AuctionFramePost_CalculateAuctionDeposit;
	frame.UpdateDeposit = AuctionFramePost_UpdateDeposit;
	frame.GetItemID = AuctionFramePost_GetItemID;
	frame.GetItemKey = AuctionFramePost_GetItemKey;
	frame.GetItemName = AuctionFramePost_GetItemName;
	frame.SetNoteText = AuctionFramePost_SetNoteText;
	frame.GetSavePrice = AuctionFramePost_GetSavePrice;
	frame.GetStartPrice = AuctionFramePost_GetStartPrice;
	frame.SetStartPrice = AuctionFramePost_SetStartPrice;
	frame.GetBuyoutPrice = AuctionFramePost_GetBuyoutPrice;
	frame.SetBuyoutPrice = AuctionFramePost_SetBuyoutPrice;
	frame.GetStackSize = AuctionFramePost_GetStackSize;
	frame.SetStackSize = AuctionFramePost_SetStackSize;
	frame.GetStackCount = AuctionFramePost_GetStackCount;
	frame.SetStackCount = AuctionFramePost_SetStackCount;
	frame.GetDuration = AuctionFramePost_GetDuration;
	frame.SetDuration = AuctionFramePost_SetDuration;
	frame.GetDeposit = AuctionFramePost_GetDeposit;
	frame.SetAuctionItem = AuctionFramePost_SetAuctionItem;
	frame.ValidateAuction = AuctionFramePost_ValidateAuction;
	frame.UpdateAuctionList = AuctionFramePost_UpdateAuctionList;
	frame.AuctionFromSnapshotAuction = AuctionFramePost_AuctionFromSnapshotAuction;
	frame.AddAuction = AuctionFramePost_AddAuction;
	frame.UpdateAuction = AuctionFramePost_UpdateAuction;
	frame.RemoveAuction = AuctionFramePost_RemoveAuction;
	frame.UpdateStatusText = AuctionFramePost_UpdateStatusText;
	frame.UpdatePriceModels = AuctionFramePost_UpdatePriceModels;

	-- Data Members
	frame.itemId = nil;
	frame.itemKey = nil;
	frame.itemName = nil;
	frame.updating = false;
	frame.registeredForSnapshotUpdates = false;
	frame.prices = {};

	-- Controls
	frame.auctionList = getglobal(frame:GetName().."List");
	frame.bidMoneyInputFrame = getglobal(frame:GetName().."StartPrice");
	frame.buyoutMoneyInputFrame = getglobal(frame:GetName().."BuyoutPrice");
	frame.stackSizeEdit = getglobal(frame:GetName().."StackSize");
	frame.stackSizeCount = getglobal(frame:GetName().."StackCount");
	frame.depositMoneyFrame = getglobal(frame:GetName().."DepositMoneyFrame");
	frame.depositErrorLabel = getglobal(frame:GetName().."UnknownDepositText");
	frame.statusText = getglobal(frame:GetName().."StatusText");

	-- Setup the tab order for the money input frames.
	MoneyInputFrame_SetPreviousFocus(frame.bidMoneyInputFrame, frame.stackSizeCount);
	MoneyInputFrame_SetNextFocus(frame.bidMoneyInputFrame, getglobal(frame.buyoutMoneyInputFrame:GetName().."Gold"));
	MoneyInputFrame_SetPreviousFocus(frame.buyoutMoneyInputFrame, getglobal(frame.bidMoneyInputFrame:GetName().."Copper"));
	MoneyInputFrame_SetNextFocus(frame.buyoutMoneyInputFrame, frame.stackSizeEdit);

	-- Configure the logical columns
	frame.logicalColumns =
	{
		Quantity =
		{
			title = _AUCT("UiQuantityHeader");
			dataType = "Number";
			valueFunc = (function(record) return record.count end);
			alphaFunc = AuctionFramePost_GetItemAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.count < record2.count end);
			compareDescendingFunc = (function(record1, record2) return record1.count > record2.count end);
		},
		Name =
		{
			title = _AUCT("UiNameHeader");
			dataType = "String";
			valueFunc = (function(record) return record.name end);
			colorFunc = AuctionFramePost_GetItemColor;
			alphaFunc = AuctionFramePost_GetItemAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.name < record2.name end);
			compareDescendingFunc = (function(record1, record2) return record1.name > record2.name end);
		},
		TimeLeft =
		{
			title = _AUCT("UiTimeLeftHeader");
			dataType = "String";
			valueFunc = (function(record) return Auctioneer.Util.GetTimeLeftString(record.timeLeft) end);
			alphaFunc = AuctionFramePost_GetItemAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.timeLeft < record2.timeLeft end);
			compareDescendingFunc = (function(record1, record2) return record1.timeLeft > record2.timeLeft end);
		},
		Bid =
		{
			title = _AUCT("UiBidHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.bid end);
			alphaFunc = AuctionFramePost_GetItemAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.bid < record2.bid end);
			compareDescendingFunc = (function(record1, record2) return record1.bid > record2.bid end);
		},
		BidPer =
		{
			title = _AUCT("UiBidPerHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.bidPer end);
			alphaFunc = AuctionFramePost_GetItemAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.bidPer < record2.bidPer end);
			compareDescendingFunc = (function(record1, record2) return record1.bidPer > record2.bidPer end);
		},
		Buyout =
		{
			title = _AUCT("UiBuyoutHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.buyout end);
			alphaFunc = AuctionFramePost_GetItemAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.buyout < record2.buyout end);
			compareDescendingFunc = (function(record1, record2) return record1.buyout > record2.buyout end);
		},
		BuyoutPer =
		{
			title = _AUCT("UiBuyoutPerHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.buyoutPer end);
			alphaFunc = AuctionFramePost_GetItemAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.buyoutPer < record2.buyoutPer end);
			compareDescendingFunc = (function(record1, record2) return record1.buyoutPer > record2.buyoutPer end);
		},
	};

	-- Configure the physical columns
	frame.physicalColumns =
	{
		{
			width = 50;
			logicalColumn = frame.logicalColumns.Quantity;
			logicalColumns = { frame.logicalColumns.Quantity };
			sortAscending = true;
		},
		{
			width = 210;
			logicalColumn = frame.logicalColumns.Name;
			logicalColumns = { frame.logicalColumns.Name };
			sortAscending = true;
		},
		{
			width = 90;
			logicalColumn = frame.logicalColumns.TimeLeft;
			logicalColumns = { frame.logicalColumns.TimeLeft };
			sortAscending = true;
		},
		{
			width = 130;
			logicalColumn = frame.logicalColumns.Bid;
			logicalColumns =
			{
				frame.logicalColumns.Bid,
				frame.logicalColumns.BidPer
			};
			sortAscending = true;
		},
		{
			width = 130;
			logicalColumn = frame.logicalColumns.Buyout;
			logicalColumns =
			{
				frame.logicalColumns.Buyout,
				frame.logicalColumns.BuyoutPer
			};
			sortAscending = true;
		},
	};

	frame.auctions = {};
	ListTemplate_Initialize(frame.auctionList, frame.physicalColumns, frame.logicalColumns);
	ListTemplate_SetContent(frame.auctionList, frame.auctions);

	frame:ValidateAuction();

	-- Insert the tab
	Auctioneer.UI.InsertAHTab(AuctionFrameTabPost, AuctionFramePost);
	Stubby.RegisterFunctionHook("AuctionFrameTab_OnClick", 200, postAuctionFrameTab_OnClickHook);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function postAuctionFrameTab_OnClickHook(_, _, index)
	if (not index) then
		index = this:GetID();
	end

	local tab = getglobal("AuctionFrameTab"..index);
	if (tab and tab:GetName() == "AuctionFrameTabPost") then
		AuctionFrameTopLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-TopLeft");
		AuctionFrameTop:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-Top");
		AuctionFrameTopRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-TopRight");
		AuctionFrameBotLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-BotLeft");
		AuctionFrameBot:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-Bot");
		AuctionFrameBotRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-BotRight");
		AuctionFramePost:Show();
	else
		AuctionFramePost:Hide();
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
AuctionFramePost_AdditionalPricingModels = {
}

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_UpdatePriceModels(frame)
	if (not frame.updating) then
		frame.prices = {};

		local name = frame:GetItemName();
		local count = frame:GetStackSize();
		if (name and count) then
			local bag, slot, id, rprop, enchant, uniq = EnhTooltip.FindItemInBags(name);
			if (id and rprop and enchant) then
				local ahKey = Auctioneer.Util.GetAuctionKey();
				local itemKey = Auctioneer.ItemDB.CreateItemKey(id, rprop, enchant);

				-- Get player's current lowest starting bid and buyout in the snapshot.
				local myAuctions = Auctioneer.SnapshotDB.QueryWithItemKey(
					itemKey,
					ahKey,
					function (auction)
						return (auction.buyoutPrice and auction.buyoutPrice > 0 and auction.owner == UnitName("player"));
					end);
				if (table.getn(myAuctions) > 0) then
					-- Calculate the lowest bid and buyout for one.
					local lowestStartBidForOne = 0;
					local lowestBuyoutForOne = 0;
					for _, auction in pairs(myAuctions) do
						local startBidForOne = auction.minBid / auction.count;
						if (lowestStartBidForOne == 0 or startBidForOne < lowestStartBidForOne) then
							lowestStartBidForOne = startBidForOne;
						end
						local buyoutForOne = auction.buyoutPrice / auction.count;
						if (buyoutForOne > 0 and (lowestBuyoutForOne == 0 or  buyoutForOne < lowestBuyoutForOne)) then
							lowestBuyoutForOne = buyoutForOne;
						end
					end

					-- Add a current price to the list.
					local currentPrice = {};
					currentPrice.text = 'My Current Price'; -- %todo: localization
					currentPrice.note = "";
					currentPrice.bid = lowestStartBidForOne * count;
					currentPrice.buyout = lowestBuyoutForOne * count;
					table.insert(frame.prices, currentPrice);
				end

				-- Get the fixed price
				local fixed = Auctioneer.FixedPriceDB.GetFixedPrice(itemKey);
				if (fixed) then
					local fixedPrice = {};
					fixedPrice.text = _AUCT('UiPriceModelFixed');
					fixedPrice.note = "";
					fixedPrice.bid = (fixed.bid / fixed.count) * count;
					fixedPrice.buyout = (fixed.buyout / fixed.count) * count;
					table.insert(frame.prices, fixedPrice);
				end

				-- Add any pricing models from external addons
				for pos, priceFunc in AuctionFramePost_AdditionalPricingModels do
					local priceModel = priceFunc(id, rprop, enchant, name, count)
					if (type(priceModel) == "table") then
						table.insert(frame.prices, priceModel)
					end
				end

				-- Get the last sale price if BeanCounter is loaded.
				if (IsAddOnLoaded("BeanCounter") and BeanCounter and BeanCounter.Sales and BeanCounter.Sales.GetLastSaleForItem) then
					-- TODO: Support should be added to BeanCounter for looking
					-- up itemKey (itemId:suffixId:enchantID) instead of by name.
					local lastSale = BeanCounter.Sales.GetLastSaleForItem(name);
					if (lastSale and lastSale.bid and lastSale.buyout) then
						local lastPrice = {};
						lastPrice.text = _AUCT('UiPriceModelLastSold');
						lastPrice.note = string.format(_AUCT('FrmtLastSoldOn'), date("%x", lastSale.time));
						lastPrice.bid = (lastSale.bid / lastSale.quantity) * count;
						lastPrice.buyout = (lastSale.buyout / lastSale.quantity) * count;
						table.insert(frame.prices, lastPrice);
					end
				end

				-- Calculate auctioneer's suggested resale price.
				local bidPrice, buyPrice, marketPrice, warn = Auctioneer.Statistic.GetSuggestedResale(itemKey, ahKey, count);
				local auctioneerPrice = {};
				auctioneerPrice.text = _AUCT('UiPriceModelAuctioneer');
				auctioneerPrice.note = warn;
				auctioneerPrice.buyout = buyPrice;
				auctioneerPrice.bid = bidPrice;
				table.insert(frame.prices, auctioneerPrice);
			end

			-- Add the fallback custom price
			local customPrice = {}
			customPrice.text = _AUCT('UiPriceModelCustom');
			customPrice.note = "";
			customPrice.bid = nil;
			customPrice.buyout = nil;
			table.insert(frame.prices, customPrice);

			-- Update the price model combo.
			local dropdown = getglobal(frame:GetName().."PriceModelDropDown");
			local index = UIDropDownMenu_GetSelectedID(dropdown);
			if (index == nil) then
				index = 1;
			end
			AuctionFramePost_PriceModelDropDownItem_SetSelectedID(dropdown, index);
		else
			-- Update the price model combo.
			local dropdown = getglobal(frame:GetName().."PriceModelDropDown");
			AuctionFramePost_PriceModelDropDownItem_SetSelectedID(dropdown, nil);
		end
	end
end

-------------------------------------------------------------------------------
-- Updates the content of the auction list based on the current auction item.
-------------------------------------------------------------------------------
function AuctionFramePost_UpdateAuctionList(frame)
	frame.auctions = {};
	local itemKey = frame:GetItemKey();
	if (itemKey) then
		local snapshotAuctions = Auctioneer.SnapshotDB.QueryWithItemKey(itemKey);
		if (snapshotAuctions) then
			for _, snapshotAuction in pairs(snapshotAuctions) do
				local auction = frame:AuctionFromSnapshotAuction(snapshotAuction);
				table.insert(frame.auctions, auction);
			end
		end
	end
	ListTemplate_SetContent(frame.auctionList, frame.auctions);
	ListTemplate_Sort(frame.auctionList, 5);

	-- Register or unregister for snapshot updates.
	if (frame.itemKey ~= nil and not frame.registeredForSnapshotUpdates) then
		debugPrint("Registering for snapshot updates");
		Auctioneer.EventManager.RegisterEvent("AUCTIONEER_AUCTION_ADDED", onAuctionAdded);
		Auctioneer.EventManager.RegisterEvent("AUCTIONEER_AUCTION_UPDATED", onAuctionUpdated);
		Auctioneer.EventManager.RegisterEvent("AUCTIONEER_AUCTION_REMOVED", onAuctionRemoved);
		Auctioneer.EventManager.RegisterEvent("AUCTIONEER_SNAPSHOT_UPDATE", onSnapshotUpdate);
		frame.registeredForSnapshotUpdates = true;
	elseif (frame.itemKey == nil and frame.registeredForSnapshotUpdates) then
		debugPrint("Unregistering for snapshot updates");
		Auctioneer.EventManager.UnregisterEvent("AUCTIONEER_AUCTION_ADDED", onAuctionAdded);
		Auctioneer.EventManager.UnregisterEvent("AUCTIONEER_AUCTION_UPDATED", onAuctionUpdated);
		Auctioneer.EventManager.UnregisterEvent("AUCTIONEER_AUCTION_REMOVED", onAuctionRemoved);
		Auctioneer.EventManager.UnregisterEvent("AUCTIONEER_SNAPSHOT_UPDATE", onSnapshotUpdate);
		frame.registeredForSnapshotUpdates = false;
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_AuctionFromSnapshotAuction(frame, snapshotAuction)
	local auction = {};
	auction.auctionId = snapshotAuction.auctionId;
	auction.itemKey = Auctioneer.ItemDB.CreateItemKeyFromAuction(snapshotAuction);
	auction.count = snapshotAuction.count;
	auction.name = Auctioneer.ItemDB.GetItemName(auction.itemKey);
	auction.owner = snapshotAuction.owner;
	auction.timeLeft = snapshotAuction.timeLeft;
	auction.bid = Auctioneer.SnapshotDB.GetCurrentBid(snapshotAuction);
	auction.bidPer = math.floor(auction.bid / auction.count);
	auction.buyout = snapshotAuction.buyoutPrice;
	auction.buyoutPer = math.floor(auction.buyout / auction.count);
	return auction;
end

-------------------------------------------------------------------------------
-- Add the auction to the auction list.
-------------------------------------------------------------------------------
function AuctionFramePost_AddAuction(frame, snapshotAuction)
	local auction = frame:AuctionFromSnapshotAuction(snapshotAuction);
	table.insert(frame.auctions, auction);
	debugPrint("Added auction at index "..table.getn(frame.auctions));
	ListTemplate_SetContent(frame.auctionList, frame.auctions);
end

-------------------------------------------------------------------------------
-- Update the auction to the auction list.
-------------------------------------------------------------------------------
function AuctionFramePost_UpdateAuction(frame, snapshotAuction)
	local auctions = frame.auctions;
	for index = 1, table.getn(auctions) do
		local auction = frame.auctions[index];
		if (auction.auctionId == snapshotAuction.auctionId) then
			debugPrint("Found auction to update at index "..index);
			auctions[index] = frame:AuctionFromSnapshotAuction(snapshotAuction);
			ListTemplate_SetContent(frame.auctionList, frame.auctions);
			break;
		end
	end
end

-------------------------------------------------------------------------------
-- Remove the auction to the auction list.
-------------------------------------------------------------------------------
function AuctionFramePost_RemoveAuction(frame, snapshotAuction)
	local auctions = frame.auctions;
	for index = 1, table.getn(auctions) do
		local auction = frame.auctions[index];
		if (auction.auctionId == snapshotAuction.auctionId) then
			debugPrint("Found auction to remove at index "..index);
			table.remove(auctions, index);
			break;
		end
	end
	ListTemplate_SetContent(frame.auctionList, frame.auctions);
end

-------------------------------------------------------------------------------
-- Updates the snapshot.
-------------------------------------------------------------------------------
function AuctionFramePost_UpdateStatusText(frame)
	local itemKey = frame:GetItemKey();
	if (itemKey) then
		-- Get the last query for the auction item.
		local query = {};
		query.name = Auctioneer.ItemDB.GetItemName(itemKey);
		local lastUpdate = Auctioneer.SnapshotDB.GetLastUpdate(nil, query);

		-- Update the status text with the last update.	
		local now = time();
		local age = time() - lastUpdate;
		if (age >= 0 and age < (24 * 60 * 60)) then
			local output = string.format("Results are %d minute(s) old", math.floor(age / 60)); -- %todo: localize
			frame.statusText:SetText(output);
		else
			frame.statusText:SetText("Results are more than 24 hours out of date!"); -- %todo: localize
		end
	else
		frame.statusText:SetText("");
	end
end

-------------------------------------------------------------------------------
-- Updates the deposit value.
-------------------------------------------------------------------------------
function AuctionFramePost_UpdateDeposit(frame)
	if (not frame.updating) then
		local itemId = frame:GetItemID();
		local duration = frame:GetDuration();
		local stackSize = frame:GetStackSize();
		local stackCount = frame:GetStackCount();
		if (itemId) then
			local deposit = AuctionFramePost_CalculateAuctionDeposit(itemId, stackSize, duration);
			if (deposit) then
				MoneyFrame_Update(frame.depositMoneyFrame:GetName(), deposit * stackCount);
				frame.depositMoneyFrame:Show();
				frame.depositErrorLabel:Hide();
			else
				MoneyFrame_Update(frame.depositMoneyFrame:GetName(), 0);
				frame.depositMoneyFrame:Hide();
				frame.depositErrorLabel:Show();
			end
		else
			MoneyFrame_Update(frame.depositMoneyFrame:GetName(), 0);
			frame.depositMoneyFrame:Hide();
			frame.depositErrorLabel:Hide();
		end
	end
end

-------------------------------------------------------------------------------
-- Gets the item ID.
-------------------------------------------------------------------------------
function AuctionFramePost_GetItemID(frame)
	return frame.itemId;
end

-------------------------------------------------------------------------------
-- Gets the item key.
-------------------------------------------------------------------------------
function AuctionFramePost_GetItemKey(frame)
	return frame.itemKey;
end

-------------------------------------------------------------------------------
-- Gets the item name.
-------------------------------------------------------------------------------
function AuctionFramePost_GetItemName(frame)
	return frame.itemName;
end

-------------------------------------------------------------------------------
-- Sets the price model note (i.e. "Undercutting 5%")
-------------------------------------------------------------------------------
function AuctionFramePost_SetNoteText(frame, text, colorize)
	getglobal(frame:GetName().."PriceModelNoteText"):SetText(text);
	if (colorize) then
		local cHex, cRed, cGreen, cBlue = Auctioneer.Util.GetWarnColor(text);
		getglobal(frame:GetName().."PriceModelNoteText"):SetTextColor(cRed, cGreen, cBlue);
	else
		getglobal(frame:GetName().."PriceModelNoteText"):SetTextColor(1.0, 1.0, 1.0);
	end
end

-------------------------------------------------------------------------------
-- Gets whether or not to save the current price information as the fixed
-- price.
-------------------------------------------------------------------------------
function AuctionFramePost_GetSavePrice(frame)
	local checkbox = getglobal(frame:GetName().."SavePriceCheckBox");
	return (checkbox and checkbox:IsVisible() and checkbox:GetChecked());
end

-------------------------------------------------------------------------------
-- Gets the starting price.
-------------------------------------------------------------------------------
function AuctionFramePost_GetStartPrice(frame)
	return MoneyInputFrame_GetCopper(getglobal(frame:GetName().."StartPrice"));
end

-------------------------------------------------------------------------------
-- Sets the starting price.
-------------------------------------------------------------------------------
function AuctionFramePost_SetStartPrice(frame, price)
	frame.ignoreStartPriceChange = true;
	MoneyInputFrame_SetCopper(getglobal(frame:GetName().."StartPrice"), price);
	frame:ValidateAuction();
end

-------------------------------------------------------------------------------
-- Gets the buyout price.
-------------------------------------------------------------------------------
function AuctionFramePost_GetBuyoutPrice(frame)
	return MoneyInputFrame_GetCopper(getglobal(frame:GetName().."BuyoutPrice"));
end

-------------------------------------------------------------------------------
-- Sets the buyout price.
-------------------------------------------------------------------------------
function AuctionFramePost_SetBuyoutPrice(frame, price)
	frame.ignoreBuyoutPriceChange = true;
	MoneyInputFrame_SetCopper(getglobal(frame:GetName().."BuyoutPrice"), price);
	frame:ValidateAuction();
end

-------------------------------------------------------------------------------
-- Gets the stack size.
-------------------------------------------------------------------------------
function AuctionFramePost_GetStackSize(frame)
	return getglobal(frame:GetName().."StackSize"):GetNumber();
end

-------------------------------------------------------------------------------
-- Sets the stack size.
-------------------------------------------------------------------------------
function AuctionFramePost_SetStackSize(frame, size)
	-- Update the stack size.
	getglobal(frame:GetName().."StackSize"):SetNumber(size);

	-- Update the deposit cost.
	frame:UpdateDeposit();
	frame:UpdatePriceModels();
	frame:ValidateAuction();
end

-------------------------------------------------------------------------------
-- Gets the stack count.
-------------------------------------------------------------------------------
function AuctionFramePost_GetStackCount(frame)
	return getglobal(frame:GetName().."StackCount"):GetNumber();
end

-------------------------------------------------------------------------------
-- Sets the stack count.
-------------------------------------------------------------------------------
function AuctionFramePost_SetStackCount(frame, count)
	-- Update the stack count.
	getglobal(frame:GetName().."StackCount"):SetNumber(count);

	-- Update the deposit cost.
	frame:UpdateDeposit();
	frame:ValidateAuction();
end

-------------------------------------------------------------------------------
-- Gets the duration.
-------------------------------------------------------------------------------
function AuctionFramePost_GetDuration(frame)
	if (getglobal(frame:GetName().."ShortAuctionRadio"):GetChecked()) then
		return 120;
	elseif(getglobal(frame:GetName().."MediumAuctionRadio"):GetChecked()) then
		return 480;
	else
		return 1440;
	end
end

-------------------------------------------------------------------------------
-- Sets the duration.
-------------------------------------------------------------------------------
function AuctionFramePost_SetDuration(frame, duration)
	local shortRadio = getglobal(frame:GetName().."ShortAuctionRadio");
	local mediumRadio = getglobal(frame:GetName().."MediumAuctionRadio");
	local longRadio = getglobal(frame:GetName().."LongAuctionRadio");

	-- Figure out radio to set as checked.
	if (duration == 120) then
		shortRadio:SetChecked(1);
		mediumRadio:SetChecked(nil);
		longRadio:SetChecked(nil);
	elseif (duration == 480) then
		shortRadio:SetChecked(nil);
		mediumRadio:SetChecked(1);
		longRadio:SetChecked(nil);
	else
		shortRadio:SetChecked(nil);
		mediumRadio:SetChecked(nil);
		longRadio:SetChecked(1);
	end

	-- Update the deposit cost.
	frame:UpdateDeposit();
	frame:ValidateAuction();
end

-------------------------------------------------------------------------------
-- Gets the deposit amount required to post.
-------------------------------------------------------------------------------
function AuctionFramePost_GetDeposit(frame)
	return getglobal(frame:GetName().."DepositMoneyFrame").staticMoney;
end

-------------------------------------------------------------------------------
-- Sets the item to display in the create auction frame.
-------------------------------------------------------------------------------
function AuctionFramePost_SetAuctionItem(frame, bag, item, count)
	-- Prevent validation while updating.
	frame.updating = true;

	-- Update the controls with the item.
	local button = getglobal(frame:GetName().."AuctionItem");
	if (bag and item) then
		-- Get the item's information.
		local itemLink = GetContainerItemLink(bag, item);
		local itemId, randomProp, enchant, uniqueId, name = EnhTooltip.BreakLink(itemLink);
		local itemTexture, itemCount = GetContainerItemInfo(bag, item);
		if (count == nil) then
			count = itemCount;
		end

		-- Save the item's information.
		frame.itemId = itemId;
		frame.itemKey = Auctioneer.ItemDB.CreateItemKeyFromLink(itemLink);
		frame.itemName = name;

		-- Show the item
		getglobal(button:GetName().."Name"):SetText(name);
		getglobal(button:GetName().."Name"):Show();
		getglobal(button:GetName().."IconTexture"):SetTexture(itemTexture);
		getglobal(button:GetName().."IconTexture"):Show();

		-- Set the defaults.
		local duration = Auctioneer.Command.GetFilterVal('auction-duration')
		if duration == 1 then
			-- 2h
			frame:SetDuration(120)
		elseif duration == 2 then
			-- 8h
			frame:SetDuration(480)
		elseif duration == 3 then
			-- 24h
			frame:SetDuration(1440)
		else
			-- last
			frame:SetDuration(Auctioneer.Command.GetFilterVal('last-auction-duration'))
		end
		frame:SetStackSize(count);
		frame:SetStackCount(1);

		-- Clear the current pricing model so that the default one gets selected.
		local dropdown = getglobal(frame:GetName().."PriceModelDropDown");
		AuctionFramePost_PriceModelDropDownItem_SetSelectedID(dropdown, nil);
		
		-- Update the Transactions tab if BeanCounter is loaded.
		if (AuctionFrameTransactions and AuctionFrameTransactions.SearchTransactions) then
			AuctionFrameTransactions:SearchTransactions(name, true, nil);
		end
	else
		-- Clear the item's information.
		frame.itemId = nil;
		frame.itemKey = nil;
		frame.itemName = nil;

		-- Hide the item
		getglobal(button:GetName().."Name"):Hide();
		getglobal(button:GetName().."IconTexture"):Hide();

		-- Clear the defaults.
		frame:SetStackSize(1);
		frame:SetStackCount(1);
	end

	-- Update the deposit cost and validate the auction.
	frame.updating = false;
	frame:UpdateDeposit();
	frame:UpdatePriceModels();
	frame:UpdateAuctionList();
	frame:UpdateStatusText();
	frame:ValidateAuction();
end

-------------------------------------------------------------------------------
-- Validates the current auction.
-------------------------------------------------------------------------------
function AuctionFramePost_ValidateAuction(frame)
	-- Only validate if its not turned off.
	if (not frame.updating) then
		-- Check that we have an item.
		local valid = false;
		if (frame.itemId) then
			valid = (frame.itemId ~= nil);
		end

		-- Check that there is a starting price.
		local startPrice = frame:GetStartPrice();
		local startErrorText = getglobal(frame:GetName().."StartPriceInvalidText");
		if (startPrice == 0) then
			valid = false;
			startErrorText:Show();
		else
			startErrorText:Hide();
		end

		-- Check that the starting price is less than or equal to the buyout.
		local buyoutPrice = frame:GetBuyoutPrice();
		local buyoutErrorText = getglobal(frame:GetName().."BuyoutPriceInvalidText");
		if (buyoutPrice > 0 and buyoutPrice < startPrice) then
			valid = false;
			buyoutErrorText:Show();
		else
			buyoutErrorText:Hide();
		end

		-- Check that the item stacks to the amount specified and that the player
		-- has enough of the item.
		local stackSize = frame:GetStackSize();
		local stackCount = frame:GetStackCount();
		local quantityErrorText = getglobal(frame:GetName().."QuantityInvalidText");
		if (frame.itemId and frame.itemKey) then
			local quantity = Auctioneer.PostManager.GetItemQuantityByItemKey(frame.itemKey);
			local maxStackSize = AuctionFramePost_GetMaxStackSize(frame.itemId);
			if (stackSize == 0) then
				valid = false;
				quantityErrorText:SetText(_AUCT('UiStackTooSmallError'));
				quantityErrorText:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
				quantityErrorText:Show();
			elseif (stackSize > 1 and (maxStackSize == nil or stackSize > maxStackSize)) then
				valid = false;
				quantityErrorText:SetText(_AUCT('UiStackTooBigError'));
				quantityErrorText:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
				quantityErrorText:Show();
			elseif (quantity < (stackSize * stackCount)) then
				valid = false;
				quantityErrorText:SetText(_AUCT('UiNotEnoughError'));
				quantityErrorText:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
				quantityErrorText:Show();
			else
				local msg = string.format(_AUCT('UiMaxError'), quantity);
				quantityErrorText:SetText(msg);
				quantityErrorText:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
				quantityErrorText:Show();
			end
		else
			quantityErrorText:Hide();
		end

		-- TODO: Check that the player can afford the deposit cost.
		local deposit = frame:GetDeposit();

		-- Update the state of the Create Auction button.
		local button = getglobal(frame:GetName().."CreateAuctionButton");
		if (valid) then
			button:Enable();
		else
			button:Disable();
		end

		-- Update the price model to reflect bid and buyout prices.
		local dropdown = getglobal(frame:GetName().."PriceModelDropDown");
		local index = UIDropDownMenu_GetSelectedID(dropdown);
		if (index and frame.prices and index <= table.getn(frame.prices)) then
			-- Check if the current selection matches
			local currentPrice = frame.prices[index];
			if ((currentPrice.bid and currentPrice.bid ~= startPrice) or
				(currentPrice.buyout and currentPrice.buyout ~= buyoutPrice)) then
				-- Nope, find one that does.
				for index,price in pairs(frame.prices) do
					if ((price.bid == nil or price.bid == startPrice) and (price.buyout == nil or price.buyout == buyoutPrice)) then
						if (UIDropDownMenu_GetSelectedID(dropdown) ~= index) then
							AuctionFramePost_PriceModelDropDownItem_SetSelectedID(dropdown, index);
						end
						break;
					end
				end
			end
		end
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_AuctionItem_OnClick(button)
	local frame = button:GetParent();

	-- If the cursor has an item, get it and put it back down in its container.
	local item = Auctioneer.UI.GetCursorContainerItem();
	if (item) then
		PickupContainerItem(item.bag, item.slot);
	end

	-- Update the current item displayed
	if (item) then
		local itemLink = GetContainerItemLink(item.bag, item.slot)
		local _, _, _, _, itemName = EnhTooltip.BreakLink(itemLink);
		local _, count = GetContainerItemInfo(item.bag, item.slot);
		frame:SetAuctionItem(item.bag, item.slot, count);
	else
		frame:SetAuctionItem(nil, nil, nil);
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_DurationRadioButton_OnClick(button, index)
	local frame = button:GetParent();
	if (index == 1) then
		Auctioneer.Command.SetFilter('last-auction-duration', 120)
		frame:SetDuration(120);
	elseif (index == 2) then
		Auctioneer.Command.SetFilter('last-auction-duration', 480)
		frame:SetDuration(480);
	else
		Auctioneer.Command.SetFilter('last-auction-duration', 1440)
		frame:SetDuration(1440);
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_StartPrice_OnChanged()
	local frame = this:GetParent():GetParent();
	if (not frame.ignoreStartPriceChange and not updating) then
		frame:ValidateAuction();
	end
	frame.ignoreStartPriceChange = false;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_BuyoutPrice_OnChanged()
	local frame = this:GetParent():GetParent();
	if (not frame.ignoreBuyoutPriceChange and not frame.updating) then
		local updatePrice = Auctioneer.Command.GetFilter('update-price');
		if (updatePrice) then
			frame.updating = true;
			local discountBidPercent = tonumber(Auctioneer.Command.GetFilterVal('pct-bidmarkdown'));
			local bidPrice = Auctioneer.Statistic.SubtractPercent(frame:GetBuyoutPrice(), discountBidPercent);
			frame:SetStartPrice(bidPrice);
			frame.updating = false;
		end
		frame:ValidateAuction();
	end
	frame.ignoreBuyoutPriceChange = false;
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_StackSize_OnTextChanged()
	local frame = this:GetParent();

	-- Update the stack size displayed on the graphic.
	local itemId = frame:GetItemID();
	local stackSize = frame:GetStackSize();
	if (itemId and stackSize > 1) then
		getglobal(frame:GetName().."AuctionItemCount"):SetText(stackSize);
		getglobal(frame:GetName().."AuctionItemCount"):Show();
	else
		getglobal(frame:GetName().."AuctionItemCount"):Hide();
	end

	-- Update the deposit and validate the auction.
	frame:UpdateDeposit();
	frame:UpdatePriceModels();
	frame:ValidateAuction();
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_StackCount_OnTextChanged()
	local frame = this:GetParent();
	frame:UpdateDeposit();
	frame:ValidateAuction();
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_CreateAuctionButton_OnClick(button)
	local frame = button:GetParent();
	local itemKey = frame:GetItemKey();
	local name = frame:GetItemName();
	local startPrice = frame:GetStartPrice();
	local buyoutPrice = frame:GetBuyoutPrice();
	local stackSize = frame:GetStackSize();
	local stackCount = frame:GetStackCount();
	local duration = frame:GetDuration();
	local deposit = frame:GetDeposit();

	-- Check if we should save the pricing information.
	if (frame:GetSavePrice()) then
		local bag, slot, id, rprop, enchant, uniq = EnhTooltip.FindItemInBags(name);
		local itemKey = id..":"..rprop..":"..enchant;
		local fixedPrice = {};
		fixedPrice.bid = startPrice;
		fixedPrice.buyout = buyoutPrice;
		fixedPrice.count = stackSize;
		fixedPrice.duration = duration;
		Auctioneer.FixedPriceDB.SetFixedPrice(itemKey, nil, fixedPrice);
	end

	-- Post the auction.
	Auctioneer.PostManager.PostAuction(itemKey, stackSize, stackCount, startPrice, buyoutPrice, duration);

	-- Clear the current auction item.
	frame:SetAuctionItem(nil, nil, nil);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_PriceModelDropDown_Initialize()
	local dropdown = this:GetParent();
	local frame = dropdown:GetParent();
	if (frame.prices) then
		for index, value in pairs(frame.prices) do
			local price = value;
			local info = {};
			info.text = price.text;
			info.func = AuctionFramePost_PriceModelDropDownItem_OnClick;
			info.owner = dropdown;
			UIDropDownMenu_AddButton(info);
		end
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_PriceModelDropDownItem_OnClick()
	local index = this:GetID();
	local dropdown = this.owner;
	local frame = dropdown:GetParent();
	if (frame.prices) then
		AuctionFramePost_PriceModelDropDownItem_SetSelectedID(dropdown, index);
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFramePost_PriceModelDropDownItem_SetSelectedID(dropdown, index)
	local frame = dropdown:GetParent();
	frame.updating = true;
	if (index) then
		local price = frame.prices[index]
		if (price.note) then
			frame:SetNoteText(price.note, (price.text == _AUCT('UiPriceModelAuctioneer')));
		end
		if (price.buyout) then
			frame:SetBuyoutPrice(price.buyout);
		end
		if (price.bid) then
			frame:SetStartPrice(price.bid);
		end

		if (price.text == _AUCT('UiPriceModelCustom')) then
			getglobal(frame:GetName().."SavePriceText"):Show();
			getglobal(frame:GetName().."SavePriceCheckBox"):Show();
			getglobal(frame:GetName().."PriceModelNoteText"):Hide();
		elseif (price.text == _AUCT('UiPriceModelAuctioneer')) then
			getglobal(frame:GetName().."SavePriceText"):Hide();
			getglobal(frame:GetName().."SavePriceCheckBox"):Hide();
			getglobal(frame:GetName().."PriceModelNoteText"):Show();
		elseif (price.text == _AUCT('UiPriceModelLastSold')) then
			getglobal(frame:GetName().."SavePriceText"):Hide();
			getglobal(frame:GetName().."SavePriceCheckBox"):Hide();
			getglobal(frame:GetName().."PriceModelNoteText"):Show();
		else
			getglobal(frame:GetName().."SavePriceText"):Hide();
			getglobal(frame:GetName().."SavePriceCheckBox"):Hide();
			getglobal(frame:GetName().."PriceModelNoteText"):Hide();
		end

		Auctioneer.UI.DropDownMenu.Initialize(dropdown, AuctionFramePost_PriceModelDropDown_Initialize);
		Auctioneer.UI.DropDownMenu.SetSelectedID(dropdown, index);
	else
		frame:SetNoteText("");
		frame:SetStartPrice(0);
		frame:SetBuyoutPrice(0);
		getglobal(frame:GetName().."SavePriceText"):Hide();
		getglobal(frame:GetName().."SavePriceCheckBox"):Hide();
		getglobal(frame:GetName().."PriceModelNoteText"):Hide();
		UIDropDownMenu_ClearAll(dropdown);
	end
	frame.updating = false;
	frame:ValidateAuction();
end

-------------------------------------------------------------------------------
-- An item in the list is clicked.
-------------------------------------------------------------------------------
function AuctionFramePost_ListItem_OnClick(row, button)
	local frame = this:GetParent():GetParent();
	debugPrint(frame:GetName());
	if (row and row <= table.getn(frame.auctions)) then
		if (button == "RightButton") then
			Auctioneer.UI.AuctionDropDownMenu.Show(frame.auctions[row].auctionId);
		end
	end
end

-------------------------------------------------------------------------------
-- Calculate the deposit required for the specified item.
-------------------------------------------------------------------------------
function AuctionFramePost_CalculateAuctionDeposit(itemId, count, duration)
	local price = Auctioneer.API.GetVendorSellPrice(itemId);
	if (price) then
		local base = math.floor(count * price * GetAuctionHouseDepositRate() / 100);
		return base * duration / 120;
	end
end

-------------------------------------------------------------------------------
-- Calculate the maximum stack size for an item based on the information returned by GetItemInfo()
-------------------------------------------------------------------------------
function AuctionFramePost_GetMaxStackSize(itemId)
	local _, _, _, _, _, _, itemStackCount = GetItemInfo(itemId);
	return itemStackCount;
end

-------------------------------------------------------------------------------
-- Returns 1.0 for player auctions and 0.4 for competing auctions
-------------------------------------------------------------------------------
function AuctionFramePost_GetItemAlpha(record)
	if (record.owner ~= UnitName("player")) then
		return 0.4;
	end
	return 1.0;
end

-------------------------------------------------------------------------------
-- Returns the item color for the specified result
-------------------------------------------------------------------------------
function AuctionFramePost_GetItemColor(auction)
	local itemInfo = Auctioneer.ItemDB.GetItemInfo(auction.itemKey);
	if (itemInfo) then
		return ITEM_QUALITY_COLORS[itemInfo.quality];
	end
	return { r = 1.0, g = 1.0, b = 1.0 };
end

-------------------------------------------------------------------------------
-- Called when an auction is added to the snapshot.
-------------------------------------------------------------------------------
function onAuctionAdded(event, auction)
	if (AuctionFramePost:GetItemKey() == Auctioneer.ItemDB.CreateItemKeyFromAuction(auction)) then
		AuctionFramePost:AddAuction(auction);
	end
end

-------------------------------------------------------------------------------
-- Called when an auction is updated in the snapshot.
-------------------------------------------------------------------------------
function onAuctionUpdated(event, newAuction, oldAuction)
	if (AuctionFramePost:GetItemKey() == Auctioneer.ItemDB.CreateItemKeyFromAuction(newAuction)) then
		AuctionFramePost:UpdateAuction(newAuction);
	end
end

-------------------------------------------------------------------------------
-- Called when an auction is removed from the snapshot.
-------------------------------------------------------------------------------
function onAuctionRemoved(event, auction)
	if (AuctionFramePost:GetItemKey() == Auctioneer.ItemDB.CreateItemKeyFromAuction(auction)) then
		AuctionFramePost:RemoveAuction(auction);
	end
end

-------------------------------------------------------------------------------
-- Called when query based snapshot update completes.
-------------------------------------------------------------------------------
function onSnapshotUpdate(event, query)
	AuctionFramePost:UpdateStatusText();
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function debugPrint(message)
	EnhTooltip.DebugPrint("[Auc.PostTab] "..message);
end

--=============================================================================
-- Initialization
--=============================================================================
if (Auctioneer.UI.PostTab ~= nil) then return end;
debugPrint("AuctioneerFramePost.lua loaded");

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
Auctioneer.UI.PostTab = 
{
	Load = load;
};
