--[[
	BeanCounter Addon for World of Warcraft(tm).
	Version: 3.9.0.1056 (Kangaroo)
	Revision: $Id: AuctionFrameTransactions.lua 1009 2006-09-27 07:54:54Z vindicator $

	Auctioneer Accoutant tab

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
local doesNameMatch;
local nilSafeCompareAscending;
local nilSafeCompareDescending;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameTransactions_OnLoad()
	-- Methods
	this.SearchTransactions = AuctionFrameTransactions_SearchTransactions;

	-- Controls
	this.searchFrame = getglobal(this:GetName().."Search");
	this.searchFrame.searchEdit = getglobal(this.searchFrame:GetName().."SearchEdit");
	this.searchFrame.exactCheck = getglobal(this.searchFrame:GetName().."ExactSearchCheckBox");
	this.searchFrame.bidCheck = getglobal(this.searchFrame:GetName().."BidCheckBox");
	this.searchFrame.buyCheck = getglobal(this.searchFrame:GetName().."BuyCheckBox");
	this.searchFrame.auctionCheck = getglobal(this.searchFrame:GetName().."AuctionCheckBox");
	this.searchFrame.sellCheck = getglobal(this.searchFrame:GetName().."SellCheckBox");
	this.resultsList = getglobal(this:GetName().."List");

	-- Data members
	this.results = {};

	-- Configure the logical columns
	this.logicalColumns =
	{
		Date =
		{
			title = _BC("UiDateHeader");
			dataType = "String";
			valueFunc = (function(record) return date("%x", record.date) end);
			compareAscendingFunc = (function(record1, record2) return nilSafeCompareAscending(record1.date, record2.date) end);
			compareDescendingFunc = (function(record1, record2) return nilSafeCompareDescending(record1.date, record2.date) end);
		},
		Type =
		{
			title = _BC("UiTransactionTypeHeader");
			dataType = "String";
			valueFunc = (function(record) return record.transaction end);
			compareAscendingFunc = (function(record1, record2) return nilSafeCompareAscending(record1.transaction, record2.transaction) end);
			compareDescendingFunc = (function(record1, record2) return nilSafeCompareDescending(record1.transaction, record2.transaction) end);
		},
		Quantity =
		{
			title = _BC("UiQuantityHeader");
			dataType = "Number";
			valueFunc = (function(record) return record.count end);
			compareAscendingFunc = (function(record1, record2) return nilSafeCompareAscending(record1.count, record2.count) end);
			compareDescendingFunc = (function(record1, record2) return nilSafeCompareDescending(record1.count, record2.count) end);
		},
		Name =
		{
			title = _BC("UiNameHeader");
			dataType = "String";
			valueFunc = (function(record) return record.name end);
			colorFunc = AuctionFrameTransactions_GetItemColor;
			compareAscendingFunc = (function(record1, record2) return nilSafeCompareAscending(record1.name, record2.name) end);
			compareDescendingFunc = (function(record1, record2) return nilSafeCompareDescending(record1.name, record2.name) end);
		},
		Net =
		{
			title = _BC("UiNetHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.net end);
			compareAscendingFunc = (function(record1, record2) return nilSafeCompareAscending(record1.net, record2.net) end);
			compareDescendingFunc = (function(record1, record2) return nilSafeCompareDescending(record1.net, record2.net) end);
		},
		NetPer =
		{
			title = _BC("UiNetPerHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.netPer end);
			compareAscendingFunc = (function(record1, record2) return nilSafeCompareAscending(record1.netPer, record2.netPer) end);
			compareDescendingFunc = (function(record1, record2) return nilSafeCompareDescending(record1.netPer, record2.netPer) end);
		},
		Price =
		{
			title = _BC("UiPriceHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.price end);
			compareAscendingFunc = (function(record1, record2) return nilSafeCompareAscending(record1.price, record2.price) end);
			compareDescendingFunc = (function(record1, record2) return nilSafeCompareDescending(record1.price, record2.price) end);
		},
		PricePer =
		{
			title = _BC("UiPricePerHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.pricePer end);
			compareAscendingFunc = (function(record1, record2) return nilSafeCompareAscending(record1.pricePer, record2.pricePer) end);
			compareDescendingFunc = (function(record1, record2) return nilSafeCompareDescending(record1.pricePer, record2.pricePer) end);
		},
		BuyerSeller =
		{
			title = _BC("UiBuyerSellerHeader");
			dataType = "String";
			valueFunc = (function(record) return record.player end);
			compareAscendingFunc = (function(record1, record2) return nilSafeCompareAscending(record1.player, record2.player) end);
			compareDescendingFunc = (function(record1, record2) return nilSafeCompareDescending(record1.player, record2.player) end);
		},
	};

	-- Configure the transaction search columns
	this.transactionSearchPhysicalColumns =
	{
		{
			width = 90;
			logicalColumn = this.logicalColumns.Date;
			logicalColumns = { this.logicalColumns.Date };
			sortAscending = true;
		},
		{
			width = 80;
			logicalColumn = this.logicalColumns.Type;
			logicalColumns = { this.logicalColumns.Type };
			sortAscending = true;
		},
		{
			width = 50;
			logicalColumn = this.logicalColumns.Quantity;
			logicalColumns = { this.logicalColumns.Quantity };
			sortAscending = true;
		},
		{
			width = 160;
			logicalColumn = this.logicalColumns.Name;
			logicalColumns = { this.logicalColumns.Name };
			sortAscending = true;
		},
		{
			width = 100;
			logicalColumn = this.logicalColumns.Net;
			logicalColumns =
			{
				this.logicalColumns.Net,
				this.logicalColumns.NetPer,
				this.logicalColumns.Price,
				this.logicalColumns.PricePer
			};
			sortAscending = true;
		},
		{
			width = 130;
			logicalColumn = this.logicalColumns.BuyerSeller;
			logicalColumns = { this.logicalColumns.BuyerSeller };
			sortAscending = true;
		},
	};

	-- Initialize the list to show nothing at first.
	ListTemplate_Initialize(this.resultsList, this.results, this.results);
end

-------------------------------------------------------------------------------
-- Perform a transaction search
-------------------------------------------------------------------------------
function AuctionFrameTransactions_SearchTransactions(frame, itemName, itemNameExact, transactions)
	-- Normalize the arguments.
	if (itemName == nil) then itemName = "" end;

	-- Create the content from purhcases database.
	frame.results = {};
	
	-- Update the UI with the item name.
	frame.searchFrame.searchEdit:SetText(itemName);
	frame.searchFrame.exactCheck:SetChecked(itemNameExact);
	
	-- Add the purchases
	frame.searchFrame.buyCheck:SetChecked(transactions == nil or transactions.purchases);
	if (transactions == nil or transactions.purchases) then

		local itemNames = BeanCounter.Purchases.GetPurchasedItems();
		for itemNameIndex in itemNames do
			-- Check if this item matches the search criteria
			if (doesNameMatch(itemNames[itemNameIndex], itemName, itemNameExact)) then
				local purchases = BeanCounter.Purchases.GetPurchasesForItem(itemNames[itemNameIndex]);
				for purchaseIndex in purchases do
					local transaction = {};
					transaction.transaction = "Buy"; --_BC('UiBuyTransaction');
					transaction.date = purchases[purchaseIndex].time;
					transaction.count = purchases[purchaseIndex].quantity;
					transaction.name = itemNames[itemNameIndex];
					transaction.price = purchases[purchaseIndex].cost;
					transaction.pricePer = math.floor(purchases[purchaseIndex].cost / purchases[purchaseIndex].quantity);
					transaction.net = -transaction.price;
					transaction.netPer = -transaction.pricePer;
					transaction.player = purchases[purchaseIndex].seller;
					table.insert(frame.results, transaction);
				end
			end
		end
	end
	
	-- Add the bids
	frame.searchFrame.bidCheck:SetChecked(transactions == nil or transactions.bids);
	if (transactions == nil or transactions.bids) then
		local itemNames = BeanCounter.Purchases.GetPendingBidItems();
		for itemNameIndex in itemNames do
			-- Check if this item matches the search criteria
			if (doesNameMatch(itemNames[itemNameIndex], itemName, itemNameExact)) then
				local pendingBids = BeanCounter.Purchases.GetPendingBidsForItem(itemNames[itemNameIndex]);
				for pendingBidIndex in pendingBids do
					local transaction = {};
					transaction.transaction = "Bid"; --_BC('UiBidTransaction');
					transaction.date = pendingBids[pendingBidIndex].time;
					transaction.count = pendingBids[pendingBidIndex].quantity;
					transaction.name = itemNames[itemNameIndex];
					transaction.price = pendingBids[pendingBidIndex].bid;
					transaction.pricePer = math.floor(pendingBids[pendingBidIndex].bid / pendingBids[pendingBidIndex].quantity);
					transaction.net = -transaction.price;
					transaction.netPer = -transaction.pricePer;
					transaction.player = pendingBids[pendingBidIndex].seller;
					table.insert(frame.results, transaction);
				end
			end
		end
	end

	-- Add the sales
	frame.searchFrame.sellCheck:SetChecked(transactions == nil or transactions.sales);
	if (transactions == nil or transactions.sales) then
		local itemNames = BeanCounter.Sales.GetSoldItems();
		for itemNameIndex in itemNames do
			-- Check if this item matches the search criteria
			if (doesNameMatch(itemNames[itemNameIndex], itemName, itemNameExact)) then
				local sales = BeanCounter.Sales.GetSalesForItem(itemNames[itemNameIndex]);
				for saleIndex in sales do
					local transaction = {};
					transaction.date = sales[saleIndex].time;
					transaction.name = itemNames[itemNameIndex];
					transaction.count = sales[saleIndex].quantity;
					transaction.net = sales[saleIndex].net;
					transaction.netPer = math.floor(transaction.net / transaction.count);
					if (sales[saleIndex].result == 0) then
						transaction.transaction = "Sell"; --_BC('UiSellTransaction');
						transaction.price = sales[saleIndex].price;
						transaction.pricePer = math.floor(transaction.price / transaction.count);
						transaction.player = sales[saleIndex].buyer;
					else
						transaction.transaction = "Deposit"; --_BC('UiDepositTransaction');
						transaction.price = sales[saleIndex].buyout;
						transaction.pricePer = math.floor(transaction.price / transaction.count);
						transaction.player = "";
					end
					table.insert(frame.results, transaction);
				end
			end			
		end
	end

	-- Add the auctions
	frame.searchFrame.auctionCheck:SetChecked(transactions == nil or transactions.auctions);
	if (transactions == nil or transactions.auctions) then
		local itemNames = BeanCounter.Sales.GetPendingAuctionItems();
		for itemNameIndex in itemNames do
			-- Check if this item matches the search criteria
			if (doesNameMatch(itemNames[itemNameIndex], itemName, itemNameExact)) then
				local auctions = BeanCounter.Sales.GetPendingAuctionsForItem(itemNames[itemNameIndex]);
				for auctionIndex in auctions do
					local transaction = {};
					transaction.transaction = "Auction"; --_BC('UiAuctionTransaction');
					transaction.date = auctions[auctionIndex].time;
					transaction.count = auctions[auctionIndex].quantity;
					transaction.name = itemNames[itemNameIndex];
					transaction.price = auctions[auctionIndex].buyout;
					transaction.pricePer = math.floor(transaction.price / transaction.count);
					transaction.net = -auctions[auctionIndex].deposit;
					transaction.netPer = math.floor(transaction.net / transaction.count);
					transaction.player = "";
					table.insert(frame.results, transaction);
				end
			end			
		end
	end

	-- Hand the updated results to the list.
	ListTemplate_Initialize(frame.resultsList, frame.transactionSearchPhysicalColumns, frame.logicalColumns);
	ListTemplate_SetContent(frame.resultsList, frame.results);
	ListTemplate_Sort(frame.resultsList, 1);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearchTransactions_SearchButton_OnClick(button)
	local frame = button:GetParent();

	local itemName = frame.searchEdit:GetText();
	if (itemName == "") then itemName = nil end
	local exactNameSearch = frame.exactCheck:GetChecked();
	local transactions = {};
	transactions.bids = frame.bidCheck:GetChecked();
	transactions.purchases = frame.buyCheck:GetChecked();
	transactions.auctions = frame.auctionCheck:GetChecked();
	transactions.sales = frame.sellCheck:GetChecked();

	frame:GetParent():SearchTransactions(itemName, exactNameSearch, transactions);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function doesNameMatch(name1, name2, exact)
	local match = true;
	if (name1 ~= nil and name2 ~= nil) then
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
function nilSafeCompareAscending(value1, value2)
	if (value1 == nil and value2 == nil) then
		return false;
	elseif (value1 == nil and value2 ~= nil) then
		return true;
	elseif (value1 ~= nil and value2 == nil) then
		return false;
	end
	return (value1 < value2);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function nilSafeCompareDescending(value1, value2)
	if (value1 == nil and value2 == nil) then
		return false;
	elseif (value1 == nil and value2 ~= nil) then
		return false;
	elseif (value1 ~= nil and value2 == nil) then
		return true;
	end
	return (value1 > value2);
end
