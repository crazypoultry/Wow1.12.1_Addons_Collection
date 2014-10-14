--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: <%version%> (<%codename%>)
	Revision: $Id: AuctionFrameSearch.lua 1047 2006-10-06 07:47:26Z vindicator $

	Auctioneer Search Auctions tab

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

local TIME_LEFT_NAMES =
{
	AUCTION_TIME_LEFT1, -- Short
	AUCTION_TIME_LEFT2, -- Medium
	AUCTION_TIME_LEFT3, -- Long
	AUCTION_TIME_LEFT4  -- Very Long
};

local AUCTION_STATUS_NORMAL = 1;
local AUCTION_STATUS_HIGH_BIDDER = 2;
local AUCTION_STATUS_NOT_FOUND = 3;
local AUCTION_STATUS_BIDDING = 4;

-------------------------------------------------------------------------------
-- Function Prototypes
-------------------------------------------------------------------------------
local load;
local postAuctionFrameTab_OnClickHook;
local onAuctionUpdated;
local onAuctionRemoved;
local onBidScanQueued;
local onBidScanComplete;
local debugPrint;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function load()
	debugPrint("Loading");
	local frame = AuctionFrameSearch;

	-- Methods
	frame.SearchBids = AuctionFrameSearch_SearchBids;
	frame.SearchBuyouts = AuctionFrameSearch_SearchBuyouts;
	frame.SearchCompetition = AuctionFrameSearch_SearchCompetition;
	frame.SearchPlain = AuctionFrameSearch_SearchPlain;
	frame.SelectResultByIndex = AuctionFrameSearch_SelectResultByIndex;
	frame.UpdateAuction = AuctionFrameSearch_UpdateAuction;
	frame.RemoveAuction = AuctionFrameSearch_RemoveAuction;
	frame.UpdateStatusWithPendingBids = AuctionFrameSearch_UpdateStatusWithPendingBids;
	frame.UpdateStatusWithQueryAge = AuctionFrameSearch_UpdateStatusWithQueryAge;
	frame.GetSelectedItemKey = AuctionFrameSearch_GetSelectedItemKey;

	-- Controls
	frame.savedSearchDropDown = getglobal(frame:GetName().."SavedSearchDropDown");
	frame.searchDropDown = getglobal(frame:GetName().."SearchDropDown");
	frame.bidFrame = getglobal(frame:GetName().."Bid");
	frame.buyoutFrame = getglobal(frame:GetName().."Buyout");
	frame.competeFrame = getglobal(frame:GetName().."Compete");
	frame.plainFrame = getglobal(frame:GetName().."Plain");
	frame.resultsList = getglobal(frame:GetName().."List");
	frame.bidButton = getglobal(frame:GetName().."BidButton");
	frame.buyoutButton = getglobal(frame:GetName().."BuyoutButton");
	frame.pendingBidStatusText = getglobal(frame:GetName().."PendingBidStatusText");

	-- Data members
	frame.results = {};
	frame.resultsByAuctionId = {};
	frame.resultsType = nil;
	frame.selectedResult = nil;

	-- Initialize the Search drop down
	Auctioneer.UI.DropDownMenu.Initialize(frame.searchDropDown, AuctionFrameSearch_SearchDropDown_Initialize);
	AuctionFrameSearch_SearchDropDownItem_SetSelectedID(frame.searchDropDown, 1);

	-- Configure the logical columns
	frame.logicalColumns =
	{
		Quantity =
		{
			title = _AUCT("UiQuantityHeader");
			dataType = "Number";
			valueFunc = (function(record) return record.count end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.count < record2.count end);
			compareDescendingFunc = (function(record1, record2) return record1.count > record2.count end);
		},
		Name =
		{
			title = _AUCT("UiNameHeader");
			dataType = "String";
			valueFunc = (function(record) return record.name end);
			colorFunc = AuctionFrameSearch_GetItemColor;
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.name < record2.name end);
			compareDescendingFunc = (function(record1, record2) return record1.name > record2.name end);
		},
		TimeLeft =
		{
			title = _AUCT("UiTimeLeftHeader");
			dataType = "String";
			valueFunc = (function(record) return Auctioneer.Util.GetTimeLeftString(record.timeLeft) end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.timeLeft < record2.timeLeft end);
			compareDescendingFunc = (function(record1, record2) return record1.timeLeft > record2.timeLeft end);
		},
		Bid =
		{
			title = _AUCT("UiBidHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.bid end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.bid < record2.bid end);
			compareDescendingFunc = (function(record1, record2) return record1.bid > record2.bid end);
		},
		BidPer =
		{
			title = _AUCT("UiBidPerHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.bidPer end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.bidPer < record2.bidPer end);
			compareDescendingFunc = (function(record1, record2) return record1.bidPer > record2.bidPer end);
		},
		BidProfit =
		{
			title = _AUCT("UiProfitHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.bidProfit end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.bidProfit < record2.bidProfit end);
			compareDescendingFunc = (function(record1, record2) return record1.bidProfit > record2.bidProfit end);
		},
		BidProfitPer =
		{
			title = _AUCT("UiProfitPerHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.bidProfitPer end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.bidProfitPer < record2.bidProfitPer end);
			compareDescendingFunc = (function(record1, record2) return record1.bidProfitPer > record2.bidProfitPer end);
		},
		BidPercentLess =
		{
			title = _AUCT("UiPercentLessHeader");
			dataType = "Number";
			valueFunc = (function(record) return record.bidPercentLess end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.bidPercentLess < record2.bidPercentLess end);
			compareDescendingFunc = (function(record1, record2) return record1.bidPercentLess > record2.bidPercentLess end);
		},
		Buyout =
		{
			title = _AUCT("UiBuyoutHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.buyout end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.buyout < record2.buyout end);
			compareDescendingFunc = (function(record1, record2) return record1.buyout > record2.buyout end);
		},
		BuyoutPer =
		{
			title = _AUCT("UiBuyoutPerHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.buyoutPer end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.buyoutPer < record2.buyoutPer end);
			compareDescendingFunc = (function(record1, record2) return record1.buyoutPer > record2.buyoutPer end);
		},
		BuyoutProfit =
		{
			title = _AUCT("UiProfitHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.buyoutProfit end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.buyoutProfit < record2.buyoutProfit end);
			compareDescendingFunc = (function(record1, record2) return record1.buyoutProfit > record2.buyoutProfit end);
		},
		BuyoutProfitPer =
		{
			title = _AUCT("UiProfitPerHeader");
			dataType = "Money";
			valueFunc = (function(record) return record.buyoutProfitPer end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.buyoutProfitPer < record2.buyoutProfitPer end);
			compareDescendingFunc = (function(record1, record2) return record1.buyoutProfitPer > record2.buyoutProfitPer end);
		},
		BuyoutPercentLess =
		{
			title = _AUCT("UiPercentLessHeader");
			dataType = "Number";
			valueFunc = (function(record) return record.buyoutPercentLess end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.buyoutPercentLess < record2.buyoutPercentLess end);
			compareDescendingFunc = (function(record1, record2) return record1.buyoutPercentLess > record2.buyoutPercentLess end);
		},
		ItemLevel =
		{
			title = _AUCT("UiItemLevelHeader");
			dataType = "Number";
			valueFunc = (function(record) return record.level end);
			alphaFunc = AuctionFrameSearch_GetAuctionAlpha;
			compareAscendingFunc = (function(record1, record2) return record1.level < record2.level end);
			compareDescendingFunc = (function(record1, record2) return record1.level > record2.level end);
		},
	};

	-- Configure the bid search physical columns
	frame.bidSearchPhysicalColumns =
	{
		{
			width = 50;
			logicalColumn = frame.logicalColumns.Quantity;
			logicalColumns = { frame.logicalColumns.Quantity };
			sortAscending = true;
		},
		{
			width = 160;
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
			logicalColumn = frame.logicalColumns.BidProfit;
			logicalColumns =
			{
				frame.logicalColumns.BidProfit,
				frame.logicalColumns.BidProfitPer,
				frame.logicalColumns.Buyout,
				frame.logicalColumns.BuyoutPer
			};
			sortAscending = true;
		},
		{
			width = 50;
			logicalColumn = frame.logicalColumns.BidPercentLess;
			logicalColumns =
			{
				frame.logicalColumns.BidPercentLess
			};
			sortAscending = true;
		},
	};

	-- Configure the buyout search physical columns
	frame.buyoutSearchPhysicalColumns =
	{
		{
			width = 50;
			logicalColumn = frame.logicalColumns.Quantity;
			logicalColumns = { frame.logicalColumns.Quantity };
			sortAscending = true;
		},
		{
			width = 250;
			logicalColumn = frame.logicalColumns.Name;
			logicalColumns = { frame.logicalColumns.Name };
			sortAscending = true;
		},
		{
			width = 130;
			logicalColumn = frame.logicalColumns.Buyout;
			logicalColumns =
			{
				frame.logicalColumns.Bid,
				frame.logicalColumns.BidPer,
				frame.logicalColumns.Buyout,
				frame.logicalColumns.BuyoutPer
			};
			sortAscending = true;
		},
		{
			width = 130;
			logicalColumn = frame.logicalColumns.BuyoutProfit;
			logicalColumns =
			{
				frame.logicalColumns.Bid,
				frame.logicalColumns.BidPer,
				frame.logicalColumns.BuyoutProfit,
				frame.logicalColumns.BuyoutProfitPer
			};
			sortAscending = true;
		},
		{
			width = 50;
			logicalColumn = frame.logicalColumns.BuyoutPercentLess;
			logicalColumns =
			{
				frame.logicalColumns.BuyoutPercentLess
			};
			sortAscending = true;
		},
	};

	-- Configure the compete search physical columns
	frame.competeSearchPhysicalColumns =
	{
		{
			width = 50;
			logicalColumn = frame.logicalColumns.Quantity;
			logicalColumns = { frame.logicalColumns.Quantity };
			sortAscending = true;
		},
		{
			width = 250;
			logicalColumn = frame.logicalColumns.Name;
			logicalColumns = { frame.logicalColumns.Name };
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
		{
			width = 50;
			logicalColumn = frame.logicalColumns.PercentLess;
			logicalColumns =
			{
				frame.logicalColumns.PercentLess
			};
			sortAscending = true;
		},
	};

	-- Configure the plain search physical columns
	frame.plainSearchPhysicalColumns =
	{
		{
			width = 50;
			logicalColumn = frame.logicalColumns.Quantity;
			logicalColumns = { frame.logicalColumns.Quantity };
			sortAscending = true;
		},
		{
			width = 160;
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
				frame.logicalColumns.BidPer,
				frame.logicalColumns.Buyout,
				frame.logicalColumns.BuyoutPer
			};
			sortAscending = true;
		},
		{
			width = 130;
			logicalColumn = frame.logicalColumns.Buyout;
			logicalColumns =
			{
				frame.logicalColumns.BuyoutProfit,
				frame.logicalColumns.BuyoutProfitPer,
				frame.logicalColumns.Buyout,
				frame.logicalColumns.BuyoutPer
			};
			sortAscending = true;
		},
		{
			width = 50;
			logicalColumn = frame.logicalColumns.BuyoutPercentLess;
			logicalColumns =
			{
				frame.logicalColumns.BuyoutPercentLess,
				frame.logicalColumns.ItemLevel
			};
			sortAscending = true;
		},
	};


	-- Initialize the list to show nothing at first.
	ListTemplate_Initialize(frame.resultsList, frame.results, frame.results);
	frame:SelectResultByIndex(nil);

	-- Register for auction update notifications.	
	Auctioneer.EventManager.RegisterEvent("AUCTIONEER_AUCTION_UPDATED", onAuctionUpdated);
	Auctioneer.EventManager.RegisterEvent("AUCTIONEER_AUCTION_REMOVED", onAuctionRemoved);
	Auctioneer.EventManager.RegisterEvent("AUCTIONEER_BID_SCAN_QUEUED", onBidScanQueued);
	Auctioneer.EventManager.RegisterEvent("AUCTIONEER_BID_SCAN_COMPLETE", onBidScanComplete);
	
	-- Insert the tab
	Auctioneer.UI.InsertAHTab(AuctionFrameTabSearch, AuctionFrameSearch);
	Stubby.RegisterFunctionHook("AuctionFrameTab_OnClick", 200, postAuctionFrameTab_OnClickHook)
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function postAuctionFrameTab_OnClickHook(_, _, index)
	if (not index) then
		index = this:GetID();
	end

	local tab = getglobal("AuctionFrameTab"..index);
	if (tab and tab:GetName() == "AuctionFrameTabSearch") then
		AuctionFrameTopLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-TopLeft");
		AuctionFrameTop:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-Top");
		AuctionFrameTopRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-TopRight");
		AuctionFrameBotLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-BotLeft");
		AuctionFrameBot:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-Bot");
		AuctionFrameBotRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Browse-BotRight");
		AuctionFrameSearch:Show();
	else
		AuctionFrameSearch:Hide();
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_OnShow()
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
AUCTIONEER_SEARCH_TYPES = {}
function AuctionFrameSearch_SearchDropDown_Initialize()
	local dropdown = this:GetParent();
	local frame = dropdown:GetParent();

	AUCTIONEER_SEARCH_TYPES[1] = _AUCT("UiSearchTypeBids");
	AUCTIONEER_SEARCH_TYPES[2] = _AUCT("UiSearchTypeBuyouts");
	AUCTIONEER_SEARCH_TYPES[3] = _AUCT("UiSearchTypeCompetition");
	AUCTIONEER_SEARCH_TYPES[4] = _AUCT("UiSearchTypePlain");

	for i=1, 4 do
		UIDropDownMenu_AddButton({
			text = AUCTIONEER_SEARCH_TYPES[i],
			func = AuctionFrameSearch_SearchDropDownItem_OnClick,
			owner = dropdown
		})
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_MinQualityDropDown_Initialize()
	local dropdown = this:GetParent();
	local frame = dropdown:GetParent();

	for i=0, 6 do
		UIDropDownMenu_AddButton({
			text = getglobal("ITEM_QUALITY"..i.."_DESC"),
			func = AuctionFrameSearch_MinQualityDropDownItem_OnClick,
			value = i,
			owner = dropdown
		});
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_SavedSearchDropDownItem_OnClick()
	local index = this:GetID();
	local dropdown = this.owner;
	local frame = dropdown:GetParent();
	local frameName = frame:GetName();
	local text = "";

	if (index > 1) then
		text = this.value
		local searchData = AuctionConfig.SavedSearches[text];
		local searchParams = Auctioneer.Util.Split(searchData, "\t");

		local searchType = tonumber(searchParams[1])
		getglobal(frameName.."SearchDropDown").selectedID = searchType;
		getglobal(frameName.."SearchDropDownText"):SetText(AUCTIONEER_SEARCH_TYPES[searchType]);

		frame.bidFrame:Hide();
		frame.buyoutFrame:Hide();
		frame.competeFrame:Hide();
		frame.plainFrame:Hide();
		if (searchType == 1) then
			-- Bid search
			MoneyInputFrame_SetCopper(getglobal(frameName.."BidMinProfit"), tonumber(searchParams[2]))

			getglobal(frameName.."BidMinPercentLessEdit"):SetText(searchParams[3])

			local timeLeft = tonumber(searchParams[4]) or 2
			Auctioneer.UI.DropDownMenu.Initialize(getglobal(frameName.."BidTimeLeftDropDown"), AuctionFrameSearch_TimeLeftDropDown_Initialize);
			Auctioneer.UI.DropDownMenu.SetSelectedID(getglobal(frameName.."BidTimeLeftDropDown"), timeLeft);

			local catid = tonumber(searchParams[5]) or 1
			Auctioneer.UI.DropDownMenu.Initialize(getglobal(frameName.."BidCategoryDropDown"), AuctionFrameSearch_CategoryDropDown_Initialize);
			Auctioneer.UI.DropDownMenu.SetSelectedID(getglobal(frameName.."BidCategoryDropDown"), catid);

			local quality = tonumber(searchParams[6]) or 1
			Auctioneer.UI.DropDownMenu.Initialize(getglobal(frameName.."BidMinQualityDropDown"), AuctionFrameSearch_MinQualityDropDown_Initialize);
			Auctioneer.UI.DropDownMenu.SetSelectedID(getglobal(frameName.."BidMinQualityDropDown"), quality);

			getglobal(frameName.."BidSearchEdit"):SetText(searchParams[7])

			frame.bidFrame:Show();
		elseif (searchType == 2) then
			-- Buyout search
			MoneyInputFrame_SetCopper(getglobal(frameName.."BuyoutMinProfit"), tonumber(searchParams[2]))

			getglobal(frameName.."BuyoutMinPercentLessEdit"):SetText(searchParams[3])

			local catid = tonumber(searchParams[4]) or 1
			Auctioneer.UI.DropDownMenu.Initialize(getglobal(frameName.."BuyoutCategoryDropDown"), AuctionFrameSearch_CategoryDropDown_Initialize);
			Auctioneer.UI.DropDownMenu.SetSelectedID(getglobal(frameName.."BuyoutCategoryDropDown"), catid);

			local quality = tonumber(searchParams[5]) or 1
			Auctioneer.UI.DropDownMenu.Initialize(getglobal(frameName.."BuyoutMinQualityDropDown"), AuctionFrameSearch_MinQualityDropDown_Initialize);
			Auctioneer.UI.DropDownMenu.SetSelectedID(getglobal(frameName.."BuyoutMinQualityDropDown"), quality);

			getglobal(frameName.."BuyoutSearchEdit"):SetText(searchParams[6])

			frame.buyoutFrame:Show();
		elseif (searchType == 3) then
			-- Compete search
			MoneyInputFrame_SetCopper(getglobal(frameName.."CompeteUndercut"), tonumber(searchParams[2]))

			frame.competeFrame:Show();
		elseif (searchType == 4) then
			-- Plain search
			MoneyInputFrame_SetCopper(getglobal(frameName.."PlainMaxPrice"), tonumber(searchParams[2]))

			local catid = tonumber(searchParams[3]) or 1
			Auctioneer.UI.DropDownMenu.Initialize(getglobal(frameName.."PlainCategoryDropDown"), AuctionFrameSearch_CategoryDropDown_Initialize);
			Auctioneer.UI.DropDownMenu.SetSelectedID(getglobal(frameName.."PlainCategoryDropDown"), catid);

			local quality = tonumber(searchParams[4]) or 1
			Auctioneer.UI.DropDownMenu.Initialize(getglobal(frameName.."PlainMinQualityDropDown"), AuctionFrameSearch_MinQualityDropDown_Initialize);
			Auctioneer.UI.DropDownMenu.SetSelectedID(getglobal(frameName.."PlainMinQualityDropDown"), quality);

			getglobal(frameName.."PlainSearchEdit"):SetText(searchParams[5])

			frame.plainFrame:Show();
		end
	end
	getglobal(frameName.."SaveSearchEdit"):SetText(text);
	Auctioneer.UI.DropDownMenu.SetSelectedID(dropdown, index);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_SavedSearchDropDown_Initialize()
	local dropdown = AuctionFrameSearchSavedSearchDropDown
	local frame = dropdown:GetParent()

	if (not AuctionConfig.SavedSearches) then
		UIDropDownMenu_AddButton({
			text = "",
			func = AuctionFrameSearch_SavedSearchDropDownItem_OnClick,
			owner = dropdown
		});
		return
	end

	local savedSearchDropDownElements = {}
	for name, search in pairs(AuctionConfig.SavedSearches) do
		table.insert(savedSearchDropDownElements, name);
	end
	table.sort(savedSearchDropDownElements);

	UIDropDownMenu_AddButton({
		text = "",
		func = AuctionFrameSearch_SavedSearchDropDownItem_OnClick,
		owner = dropdown
	});
	for pos, name in pairs(savedSearchDropDownElements) do
		UIDropDownMenu_AddButton({
			text = name,
			func = AuctionFrameSearch_SavedSearchDropDownItem_OnClick,
			owner = dropdown
		});
	end
end


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_MinQualityDropDownItem_OnClick()
	local index = this:GetID();
	local dropdown = this.owner;
	Auctioneer.UI.DropDownMenu.SetSelectedID(dropdown, index);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_SearchDropDownItem_OnClick()
	local index = this:GetID();
	local dropdown = this.owner;
	AuctionFrameSearch_SearchDropDownItem_SetSelectedID(dropdown, index);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_SearchDropDownItem_SetSelectedID(dropdown, index)
	local frame = dropdown:GetParent();
	frame.bidFrame:Hide();
	frame.buyoutFrame:Hide();
	frame.competeFrame:Hide();
	frame.plainFrame:Hide();
	if (index == 1) then
		frame.bidFrame:Show();
	elseif (index == 2) then
		frame.buyoutFrame:Show();
	elseif (index == 3) then
		frame.competeFrame:Show();
	elseif (index == 4) then
		frame.plainFrame:Show();
	end
	Auctioneer.UI.DropDownMenu.SetSelectedID(dropdown, index);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_RemoveSearchButton_OnClick(button)
	local frame = button:GetParent();
	local frameName = frame:GetName();

	local searchName = getglobal(frameName.."SaveSearchEdit"):GetText()
	if (AuctionConfig.SavedSearches) then
		AuctionConfig.SavedSearches[searchName] = nil
	end
	getglobal(frameName.."SaveSearchEdit"):SetText("")
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_SaveSearchButton_OnClick(button)
	local frame = button:GetParent();
	local frameName = frame:GetName();
	local searchDropdown = getglobal(frameName.."SearchDropDown")

	local searchType = UIDropDownMenu_GetSelectedID(searchDropdown);
	local searchData = nil
	if (searchType == 1) then
		-- Bid-based search
		searchData = string.format("%d\t%d\t%s\t%d\t%d\t%d\t%s",
			searchType,
			MoneyInputFrame_GetCopper(getglobal(frameName.."BidMinProfit")),
			getglobal(frameName.."BidMinPercentLessEdit"):GetText(),
			UIDropDownMenu_GetSelectedID(getglobal(frameName.."BidTimeLeftDropDown")),
			UIDropDownMenu_GetSelectedID(getglobal(frameName.."BidCategoryDropDown")),
			UIDropDownMenu_GetSelectedID(getglobal(frameName.."BidMinQualityDropDown")),
			getglobal(frameName.."BidSearchEdit"):GetText()
		);
	elseif (searchType == 2) then
		-- Buyout-based search
		searchData = string.format("%d\t%d\t%s\t%d\t%d\t%s",
			searchType,
			MoneyInputFrame_GetCopper(getglobal(frameName.."BuyoutMinProfit")),
			getglobal(frameName.."BuyoutMinPercentLessEdit"):GetText(),
			UIDropDownMenu_GetSelectedID(getglobal(frameName.."BuyoutCategoryDropDown")),
			UIDropDownMenu_GetSelectedID(getglobal(frameName.."BuyoutMinQualityDropDown")),
			getglobal(frameName.."BuyoutSearchEdit"):GetText()
		);
	elseif (searchType == 3) then
		-- Compete-based search
		searchData = string.format("%d\t%d",
			searchType,
			MoneyInputFrame_GetCopper(getglobal(frameName.."CompeteUndercut"))
		);
	elseif (searchType == 4) then
		-- Plain-based search
		searchData = string.format("%d\t%d\t%d\t%d\t%s",
			searchType,
			MoneyInputFrame_GetCopper(getglobal(frameName.."PlainMaxPrice")),
			UIDropDownMenu_GetSelectedID(getglobal(frameName.."PlainCategoryDropDown")),
			UIDropDownMenu_GetSelectedID(getglobal(frameName.."PlainMinQualityDropDown")),
			getglobal(frameName.."PlainSearchEdit"):GetText()
		);
	end

	if (searchData) then
		local searchName = getglobal(frameName.."SaveSearchEdit"):GetText()
		if (not AuctionConfig.SavedSearches) then
			AuctionConfig.SavedSearches = {}
		end

		AuctionConfig.SavedSearches[searchName] = searchData
	end
end

-------------------------------------------------------------------------------
-- The Bid button has been clicked
-------------------------------------------------------------------------------
function AuctionFrameSearch_BidButton_OnClick(button)
	local frame = button:GetParent();
	local result = frame.selectedResult;
	if (result and result.auctionId and result.bid) then
		result.status = AUCTION_STATUS_BIDDING;
		Auctioneer.BidScanner.BidByAuctionId(result.auctionId);
		AuctionFrameSearch_UpdateButtons(frame);
		AuctionFrameSearch_UpdateStatusWithPendingBids(frame);
		ListTemplateScrollFrame_Update(getglobal(frame.resultsList:GetName().."ScrollFrame"));
	end
end

-------------------------------------------------------------------------------
-- The Buyout button has been clicked.
-------------------------------------------------------------------------------
function AuctionFrameSearch_BuyoutButton_OnClick(button)
	local frame = button:GetParent();
	local result = frame.selectedResult;
	if (result and result.name and result.count and result.buyout) then
		result.status = AUCTION_STATUS_BIDDING;
		Auctioneer.BidScanner.BuyoutByAuctionId(result.auctionId);
		AuctionFrameSearch_UpdateButtons(frame);
		AuctionFrameSearch_UpdateStatusWithPendingBids(frame);
		ListTemplateScrollFrame_Update(getglobal(frame.resultsList:GetName().."ScrollFrame"));
	end
end

-------------------------------------------------------------------------------
-- Updates the pending bid status text
-------------------------------------------------------------------------------
function AuctionFrameSearch_UpdateStatusWithPendingBids(frame)
	local count = Auctioneer.BidScanner.GetBidRequestCount();
	if (count == 1) then
		frame.pendingBidStatusText:SetText(_AUCT('UiPendingBidInProgress'));
	elseif (count > 1) then
		local output = string.format(_AUCT('UiPendingBidsInProgress'), count);
		frame.pendingBidStatusText:SetText(output);
	elseif (frame.pendingBidStatusText:GetText() ~= "") then
		frame.pendingBidStatusText:SetText(_AUCT('UiNoPendingBids'));
	end
end

-------------------------------------------------------------------------------
-- Sets the status text to the age of the snapshot.
-------------------------------------------------------------------------------
function AuctionFrameSearch_UpdateStatusWithQueryAge(frame, itemNames, categoryIndex, minQuality)
	-- Construct the query that matches the search results.
	local query = {};
	query.classIndex = categoryIndex;
	query.qualityIndex = minQuality;

	-- Get the last update time from the snapshot.
	local lastUpdate = 0;
	if (itemNames) then
		for _, itemName in pairs(itemNames) do
			query.name = itemName;
			local lastUpdateForItem = Auctioneer.SnapshotDB.GetLastUpdate(nil, query);
			if (lastUpdate == 0 or lastUpdateForItem < lastUpdate) then
				lastUpdate = lastUpdateForItem;
			end
		end
	else
		lastUpdate = Auctioneer.SnapshotDB.GetLastUpdate(nil, query);
	end

	-- Update the status text with the last update.	
	local now = time();
	local age = time() - lastUpdate;
	if (age >= 0 and age < (24 * 60 * 60)) then
		local output = string.format("Results are %d minute(s) old", math.floor(age / 60)); -- %todo: localize
		frame.pendingBidStatusText:SetText(output);
	else
		frame.pendingBidStatusText:SetText("Results are more than 24 hours out of date!"); -- %todo: localize
	end
end

-------------------------------------------------------------------------------
-- Returns the item color for the specified result
-------------------------------------------------------------------------------
function AuctionFrameSearch_GetItemColor(result)
	local quality = Auctioneer.ItemDB.GetItemQuality(result.itemKey);
	if (quality) then
		return ITEM_QUALITY_COLORS[quality];
	end
	return { r = 1.0, g = 1.0, b = 1.0 };
end

-------------------------------------------------------------------------------
-- Perform a bid search (aka bidBroker)
-------------------------------------------------------------------------------
function AuctionFrameSearch_SearchBids(frame, minProfit, minPercentLess, maxSecondsLeft, categoryIndex, minQuality, itemName)
	-- Clear the old results.
	frame.results = {};
	frame.resultsByAuctionId = {};

	-- Query the snapshot.	
	local profitFilterArgs = {};
	profitFilterArgs.minBidProfit = minProfit;
	profitFilterArgs.minBidPercentLess = minPercentLess;
	profitFilterArgs.maxSecondsLeft = maxSecondsLeft;
	profitFilterArgs.categoryName = Auctioneer.ItemDB.GetCategoryName(categoryIndex);
	profitFilterArgs.minQuality = minQuality;
	profitFilterArgs.itemNames = Auctioneer.Util.Split(itemName, "|");
	local snapshotAuctions = Auctioneer.SnapshotDB.Query(nil, nil, Auctioneer.Filter.ProfitFilter, profitFilterArgs);

	-- Compile the results of the query.
	local player = UnitName("player");
	for _, snapshotAuction in pairs(snapshotAuctions) do
		if (snapshotAuction.owner ~= player) then
			local itemKey = Auctioneer.ItemDB.CreateItemKeyFromAuction(snapshotAuction);
			local itemInfo = Auctioneer.ItemDB.GetItemInfo(itemKey);
			local profit, profitPercent, percentLess = Auctioneer.Statistic.GetBidProfit(snapshotAuction);
		
			local auction = {};
			auction.auctionId = snapshotAuction.auctionId;
			auction.itemKey = itemKey;
			auction.hsp = Auctioneer.Statistic.GetHSP(itemKey, auction.ahKey);
			
			auction.name = itemInfo.name;
			auction.count = snapshotAuction.count;
			auction.owner = snapshotAuction.owner;
			auction.timeLeft = snapshotAuction.timeLeft;
			
			auction.bid = Auctioneer.SnapshotDB.GetCurrentBid(snapshotAuction);
			auction.bidPer = math.floor(auction.bid / auction.count);
			
			auction.buyout = snapshotAuction.buyoutPrice;
			auction.buyoutPer = math.floor(auction.buyout / auction.count);
			
			auction.bidProfit = profit;
			auction.bidProfitPer = math.floor(auction.bidProfit / auction.count);
			auction.bidPercentLess = percentLess;

			if (snapshotAuction.highBidder) then
				auction.status = AUCTION_STATUS_HIGH_BIDDER;
			else
				auction.status = AUCTION_STATUS_NORMAL;
			end
			auction.pendingBidCount = 0;

			table.insert(frame.results, auction);
			frame.resultsByAuctionId[auction.auctionId] = auction;
		end
	end

	-- Hand the updated results to the list.
	frame.resultsType = "BidSearch";
	frame:SelectResultByIndex(nil);
	ListTemplate_Initialize(frame.resultsList, frame.bidSearchPhysicalColumns, frame.auctioneerListLogicalColumns);
	ListTemplate_SetContent(frame.resultsList, frame.results);
	ListTemplate_Sort(frame.resultsList, 2);
	ListTemplate_Sort(frame.resultsList, 3);

	-- Update the status line with the age of the data.
	frame:UpdateStatusWithQueryAge(profitFilterArgs.itemNames, categoryIndex, minQuality);
end

-------------------------------------------------------------------------------
-- Perform a buyout search (aka percentLess)
-------------------------------------------------------------------------------
function AuctionFrameSearch_SearchBuyouts(frame, minProfit, minPercentLess, categoryIndex, minQuality, itemNames)
	-- Clear the old results.
	frame.results = {};
	frame.resultsByAuctionId = {};

	-- Query the snapshot.	
	local profitFilterArgs = {};
	profitFilterArgs.minBuyoutProfit = minProfit;
	profitFilterArgs.minBuyoutPercentLess = minPercentLess;
	profitFilterArgs.categoryName = Auctioneer.ItemDB.GetCategoryName(categoryIndex);
	profitFilterArgs.minQuality = minQuality;
	profitFilterArgs.itemNames = Auctioneer.Util.Split(itemNames, "|");
	local snapshotAuctions = Auctioneer.SnapshotDB.Query(nil, nil, Auctioneer.Filter.ProfitFilter, profitFilterArgs);

	-- Compile the results of the query.
	local player = UnitName("player");
	for _, snapshotAuction in pairs(snapshotAuctions) do
		if (snapshotAuction.owner ~= player) then
			local itemKey = Auctioneer.ItemDB.CreateItemKeyFromAuction(snapshotAuction);
			local itemInfo = Auctioneer.ItemDB.GetItemInfo(itemKey);
			local profit, profitPercent, percentLess = Auctioneer.Statistic.GetBuyoutProfit(snapshotAuction);
		
			local auction = {};
			auction.auctionId = snapshotAuction.auctionId;
			auction.itemKey = itemKey;
			auction.hsp = Auctioneer.Statistic.GetHSP(itemKey, auction.ahKey);
			
			auction.name = itemInfo.name;
			auction.count = snapshotAuction.count;
			auction.owner = snapshotAuction.owner;
			auction.timeLeft = snapshotAuction.timeLeft;
			
			auction.bid = Auctioneer.SnapshotDB.GetCurrentBid(snapshotAuction);
			auction.bidPer = math.floor(auction.bid / auction.count);
			
			auction.buyout = snapshotAuction.buyoutPrice;
			auction.buyoutPer = math.floor(auction.buyout / auction.count);
			
			auction.buyoutProfit = profit;
			auction.buyoutProfitPer = math.floor(auction.buyoutProfit / auction.count);
			auction.buyoutPercentLess = percentLess;

			if (snapshotAuction.highBidder) then
				auction.status = AUCTION_STATUS_HIGH_BIDDER;
			else
				auction.status = AUCTION_STATUS_NORMAL;
			end
			auction.pendingBidCount = 0;

			table.insert(frame.results, auction);
			frame.resultsByAuctionId[auction.auctionId] = auction;
		end
	end

	-- Hand the updated content to the list.
	frame.resultsType = "BuyoutSearch";
	frame:SelectResultByIndex(nil);
	ListTemplate_Initialize(frame.resultsList, frame.buyoutSearchPhysicalColumns, frame.auctioneerListLogicalColumns);
	ListTemplate_SetContent(frame.resultsList, frame.results);
	ListTemplate_Sort(frame.resultsList, 5);

	-- Update the status line with the age of the data.
	frame:UpdateStatusWithQueryAge(profitFilterArgs.itemNames, categoryIndex, minQuality);
end

-------------------------------------------------------------------------------
-- Perform a competition search (aka compete)
-------------------------------------------------------------------------------
function AuctionFrameSearch_SearchCompetition(frame, minUndercut)
	-- Clear the old results.
	frame.results = {};
	frame.resultsByAuctionId = {};

	-- Query the snapshot.	
	local competitionFilterArgs = {};
	competitionFilterArgs.minLess = minUndercut;
	competitionFilterArgs.myHighestBuyouts = Auctioneer.Filter.GetMyHighestBuyouts();
	local snapshotAuctions = Auctioneer.SnapshotDB.Query(nil, nil, Auctioneer.Filter.CompetitionFilter, competitionFilterArgs);

	-- Compile the results of the query.
	for _, snapshotAuction in pairs(snapshotAuctions) do
		local itemKey = Auctioneer.ItemDB.CreateItemKeyFromAuction(snapshotAuction);
		local itemInfo = Auctioneer.ItemDB.GetItemInfo(itemKey);
		local myBuyoutPer = filterArgs.myHighestBuyouts[itemKey];

		local auction = {};
		auction.auctionId = snapshotAuction.auctionId;
		auction.itemKey = itemKey;
		auction.hsp = Auctioneer.Statistic.GetHSP(itemKey, auction.ahKey);

		auction.name = itemInfo.name;
		auction.count = snapshotAuction.count;
		auction.owner = snapshotAuction.owner;
		auction.timeLeft = snapshotAuction.timeLeft;

		auction.bid = Auctioneer.SnapshotDB.GetCurrentBid(snapshotAuction);
		auction.bidPer = math.floor(auction.bid / auction.count);

		auction.buyout = snapshotAuction.buyoutPrice;
		auction.buyoutPer = math.floor(auction.buyout / auction.count);
		auction.buyoutPercentLess = math.floor(((myBuyoutPer - auction.buyoutPer) / myBuyoutPer) * 100);

		if (snapshotAuction.highBidder) then
			auction.status = AUCTION_STATUS_HIGH_BIDDER;
		else
			auction.status = AUCTION_STATUS_NORMAL;
		end
		auction.pendingBidCount = 0;

		table.insert(frame.results, auction);
		frame.resultsByAuctionId[auction.auctionId] = auction;
	end

	-- Hand the updated content to the list.
	frame.resultsType = "CompeteSearch";
	frame:SelectResultByIndex(nil);
	ListTemplate_Initialize(frame.resultsList, frame.competeSearchPhysicalColumns, frame.auctioneerListLogicalColumns);
	ListTemplate_SetContent(frame.resultsList, frame.results);

	-- Update the status line with the age of the data.
	frame:UpdateStatusWithQueryAge();
end

-------------------------------------------------------------------------------
-- Perform a plain search
-------------------------------------------------------------------------------
function AuctionFrameSearch_SearchPlain(frame, maxPrice, categoryIndex, minQuality, itemNames)
	-- Clear the old results.
	frame.results = {};
	frame.resultsByAuctionId = {};

	-- Query the snapshot.	
	local itemFilterArgs = {};
	itemFilterArgs.maxBuyout = maxPrice;
	itemFilterArgs.categoryName = Auctioneer.ItemDB.GetCategoryName(categoryIndex);
	itemFilterArgs.minQuality = minQuality;
	itemFilterArgs.itemNames = Auctioneer.Util.Split(itemNames, "|");
	local snapshotAuctions = Auctioneer.SnapshotDB.Query(nil, nil, Auctioneer.Filter.ItemFilter, itemFilterArgs);

	-- Compile the results of the query.
	local player = UnitName("player");
	for _, snapshotAuction in pairs(snapshotAuctions) do
		if (snapshotAuction.owner ~= player) then
			local itemKey = Auctioneer.ItemDB.CreateItemKeyFromAuction(snapshotAuction);
			local itemInfo = Auctioneer.ItemDB.GetItemInfo(itemKey);
			local profit, profitPercent, percentLess = Auctioneer.Statistic.GetBuyoutProfit(snapshotAuction);
		
			local auction = {};
			auction.auctionId = snapshotAuction.auctionId;
			auction.itemKey = itemKey;
			auction.hsp = Auctioneer.Statistic.GetHSP(itemKey, auction.ahKey);
			
			auction.name = itemInfo.name;
			auction.count = snapshotAuction.count;
			auction.owner = snapshotAuction.owner;
			auction.timeLeft = snapshotAuction.timeLeft;
			
			auction.bid = Auctioneer.SnapshotDB.GetCurrentBid(snapshotAuction);
			auction.bidPer = math.floor(auction.bid / auction.count);
			
			auction.buyout = snapshotAuction.buyoutPrice;
			auction.buyoutPer = math.floor(auction.buyout / auction.count);
			
			auction.buyoutProfit = profit;
			auction.buyoutProfitPer = math.floor(auction.buyoutProfit / auction.count);
			auction.buyoutPercentLess = percentLess;

			if (snapshotAuction.highBidder) then
				auction.status = AUCTION_STATUS_HIGH_BIDDER;
			else
				auction.status = AUCTION_STATUS_NORMAL;
			end
			auction.pendingBidCount = 0;

			table.insert(frame.results, auction);
			frame.resultsByAuctionId[auction.auctionId] = auction;
		end
	end

	-- Hand the updated results to the list.
	frame.resultsType = "PlainSearch";
	frame:SelectResultByIndex(nil);
	ListTemplate_Initialize(frame.resultsList, frame.plainSearchPhysicalColumns, frame.auctioneerListLogicalColumns);
	ListTemplate_SetContent(frame.resultsList, frame.results);
	ListTemplate_Sort(frame.resultsList, 2);
	ListTemplate_Sort(frame.resultsList, 3);

	-- Update the status line with the age of the data.
	frame:UpdateStatusWithQueryAge(itemFilterArgs.itemNames, categoryIndex, minQuality);
end

-------------------------------------------------------------------------------
-- Called when an auction is updated in the snapshot.
-------------------------------------------------------------------------------
function AuctionFrameSearch_UpdateAuction(frame, snapshotAuction)
	-- Check if this auction is in the search results.
	local auction = frame.resultsByAuctionId[snapshotAuction.auctionId];
	if (auction) then
		debugPrint("Updating auction "..auction.auctionId);
	
		-- Update the time left.
		auction.timeLeft = snapshotAuction.timeLeft;
	
		-- Update the bid numbers.
		if (auction.bid) then
			auction.bid = Auctioneer.SnapshotDB.GetCurrentBid(snapshotAuction);
			auction.bidPer = math.floor(auction.bid / auction.count);
		end

		-- Update the bid profit numbers.
		if (auction.bidProfit) then
			local profit, profitPercent, percentLess = Auctioneer.Statistic.GetBidProfit(snapshotAuction, auction.hsp);
			auction.bidProfit = profit;
			auction.bidProfitPer = math.floor(auction.bidProfit / auction.count);
			auction.bidPercentLess = percentLess;
		end

		-- Update the buyout profit numbers.
		if (auction.buyoutProfit) then
			local profit, profitPercent, percentLess = Auctioneer.Statistic.GetBuyoutProfit(snapshotAuction, auction.hsp);
			auction.buyoutProfit = profit;
			auction.buyoutProfitPer = math.floor(auction.buyoutProfit / auction.count);
			auction.buyoutPercentLess = percentLess;
		end

		-- Update the status.
		if (snapshotAuction.highBidder) then
			auction.status = AUCTION_STATUS_HIGH_BIDDER;
		else
			auction.status = AUCTION_STATUS_NORMAL;
		end

		-- Force a list update.
		ListTemplateScrollFrame_Update(getglobal(frame.resultsList:GetName().."ScrollFrame"));
	end
end

-------------------------------------------------------------------------------
-- Called when an auction is removed from the snapshot.
-------------------------------------------------------------------------------
function AuctionFrameSearch_RemoveAuction(frame, snapshotAuction)
	-- Check if this auction is in the search results.
	local auction = frame.resultsByAuctionId[snapshotAuction.auctionId];
	if (auction) then
		debugPrint("Updating auction "..auction.auctionId);

		-- Update the auction status.
		auction.status = AUCTION_STATUS_NOT_FOUND;

		-- Force a list update.
		ListTemplateScrollFrame_Update(getglobal(frame.resultsList:GetName().."ScrollFrame"));
	end
end

-------------------------------------------------------------------------------
-- Gets the itemKey of the selected result
-------------------------------------------------------------------------------
function AuctionFrameSearch_GetSelectedItemKey(frame)
	local result = frame.selectedResult;
	if (result) then
		return result.itemKey;
	end
end

-------------------------------------------------------------------------------
-- Select a search result by index.
-------------------------------------------------------------------------------
function AuctionFrameSearch_SelectResultByIndex(frame, index)
	if (index and index <= table.getn(frame.results) and frame.resultsType) then
		-- Select the item
		frame.selectedResult = frame.results[index];
		ListTemplate_SelectRow(frame.resultsList, index);
		
		-- If BeanCounter is loaded, do a transaction search.
		-- Update the Transactions tab if BeanCounter is loaded.
		if (AuctionFrameTransactions and AuctionFrameTransactions.SearchTransactions) then
			AuctionFrameTransactions:SearchTransactions(frame.selectedResult.name, true, nil);
		end
	else
		-- Clear the selection
		frame.selectedResult = nil;
		ListTemplate_SelectRow(frame.resultsList, nil);
	end

	AuctionFrameSearch_UpdateButtons(frame);
end

-------------------------------------------------------------------------------
-- Update the enabled/disabled state of the Bid and Buyout buttons
-------------------------------------------------------------------------------
function AuctionFrameSearch_UpdateButtons(frame)
	if (frame.selectedResult) then
		if (frame.selectedResult.status == AUCTION_STATUS_NORMAL) then
			if (frame.resultsType == "BidSearch") then
				frame.bidButton:Enable();
				frame.buyoutButton:Disable();
			elseif (frame.resultsType == "BuyoutSearch") then
				frame.bidButton:Disable();
				frame.buyoutButton:Enable();
			elseif (frame.resultsType == "CompeteSearch") then
				frame.bidButton:Enable();
				frame.buyoutButton:Enable();
			elseif (frame.resultsType == "PlainSearch") then
				frame.bidButton:Enable();
				frame.buyoutButton:Enable();
			else
				frame.bidButton:Disable();
				frame.buyoutButton:Disable();
			end
		else
			frame.bidButton:Disable();
			frame.buyoutButton:Disable();
		end
	else
		frame.bidButton:Disable();
		frame.buyoutButton:Disable();
	end
end

-------------------------------------------------------------------------------
-- An item in the list is moused over.
-------------------------------------------------------------------------------
function AuctionFrameSearch_ListItem_OnEnter(row)
	local frame = this:GetParent():GetParent();
	local results = frame.results;
	if (results and row <= table.getn(results)) then
		local result = results[row];
		if (result) then
			local itemLink = Auctioneer.ItemDB.GetItemLink(result.itemKey);
			if (itemLink) then
				GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
				GameTooltip:SetHyperlink(Auctioneer.ItemDB.GetItemString(result.itemKey));
				GameTooltip:Show();
				EnhTooltip.TooltipCall(
					GameTooltip,
					result.name,
					itemLink,
					Auctioneer.ItemDB.GetItemQuality(result.itemKey),
					result.count);
			end
		end
	end
end

-------------------------------------------------------------------------------
-- An item in the list is clicked.
-------------------------------------------------------------------------------
function AuctionFrameSearch_ListItem_OnClick(row, button)
	local frame = this:GetParent():GetParent();

	-- Select the item clicked.
	frame:SelectResultByIndex(row);

	if (button == "LeftButton") then
		-- Bid or buyout the item if the alt key is down.
		if (frame.resultsType and IsAltKeyDown()) then
			if (IsShiftKeyDown()) then
				-- Bid or buyout the item.
				if (frame.resultsType == "BidSearch") then
					AuctionFrameSearch_BidButton_OnClick(frame.bidButton);

				elseif (frame.resultsType == "BuyoutSearch") then
					AuctionFrameSearch_BuyoutButton_OnClick(frame.buyoutButton);
				end

			elseif (CanSendAuctionQuery()) then
				-- Search for the item and switch to the Browse tab.
				Auctioneer.UI.BrowseTab.QueryForItemByName(frame.results[row].name);
				AuctionFrameTab_OnClick(1);
			end

		--Thanks to Miravlix (from irc://irc.datavertex.com/cosmostesters) for the following codeblocks.
		elseif (IsControlKeyDown()) then
			local itemString = Auctioneer.ItemDB.GetItemString(frame.results[row].itemKey);
			DressUpItemLink(itemString);

		elseif (IsShiftKeyDown() and ChatFrameEditBox:IsVisible()) then
			local itemLink = Auctioneer.ItemDB.GetItemLink(frame.results[row].itemKey);
			ChatFrameEditBox:Insert(itemLink);
		end
	elseif (button == "RightButton") then
		if (frame.selectedResult) then
			Auctioneer.UI.AuctionDropDownMenu.Show(frame.selectedResult.auctionId);
		end
	end
end

-------------------------------------------------------------------------------
-- Initialize the content of a Category dropdown list
-------------------------------------------------------------------------------
function AuctionFrameSearch_CategoryDropDown_Initialize()
	local dropdown = this:GetParent();
	local frame = dropdown:GetParent();
	UIDropDownMenu_AddButton({
		text = "",
		func = AuctionFrameSearch_CategoryDropDownItem_OnClick,
		owner = dropdown
	})

	local classes = {GetAuctionItemClasses()};
	for classId, className in pairs(classes) do
		UIDropDownMenu_AddButton({
			text = className,
			func = AuctionFrameSearch_CategoryDropDownItem_OnClick,
			owner = dropdown
		});
	end
end

-------------------------------------------------------------------------------
-- An item in a CategoryDrownDown has been clicked
-------------------------------------------------------------------------------
function AuctionFrameSearch_CategoryDropDownItem_OnClick()
	local index = this:GetID();
	local dropdown = this.owner;
	Auctioneer.UI.DropDownMenu.SetSelectedID(dropdown, index);
end

-------------------------------------------------------------------------------
-- Initialize the content of a TimeLeft dropdown list
-------------------------------------------------------------------------------
function AuctionFrameSearch_TimeLeftDropDown_Initialize()
	local dropdown = this:GetParent();
	local frame = dropdown:GetParent();
	for index, value in pairs(TIME_LEFT_NAMES) do
		local info = {};
		info.text = value;
		info.func = AuctionFrameSearch_TimeLeftDropDownItem_OnClick;
		info.owner = dropdown;
		UIDropDownMenu_AddButton(info);
	end
end

-------------------------------------------------------------------------------
-- An item a TimeLeftDrownDown has been clicked
-------------------------------------------------------------------------------
function AuctionFrameSearch_TimeLeftDropDownItem_OnClick()
	local index = this:GetID();
	local dropdown = this.owner;
	Auctioneer.UI.DropDownMenu.SetSelectedID(dropdown, index);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearchBid_SearchButton_OnClick(button)
	local frame = button:GetParent();
	local frameName = frame:GetName();
	local profitMoneyFrame = getglobal(frameName.."MinProfit");
	local percentLessEdit = getglobal(frameName.."MinPercentLessEdit");
	local timeLeftDropDown = getglobal(frameName.."TimeLeftDropDown");

	local minProfit = MoneyInputFrame_GetCopper(profitMoneyFrame);
	local minPercentLess = percentLessEdit:GetNumber();
	local catID = (UIDropDownMenu_GetSelectedID(getglobal(frameName.."CategoryDropDown")) or 1) - 1;
	local minQuality = (UIDropDownMenu_GetSelectedID(getglobal(frameName.."MinQualityDropDown")) or 1) - 1;
	local itemName = getglobal(frameName.."SearchEdit"):GetText();
	if (itemName == "") then itemName = nil end

	local timeLeft = Auctioneer.Core.Constants.TimeLeft.Seconds[UIDropDownMenu_GetSelectedID(timeLeftDropDown)];
	frame:GetParent():SearchBids(minProfit, minPercentLess, timeLeft, catID, minQuality, itemName);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearchBuyout_SearchButton_OnClick(button)
	local frame = button:GetParent();
	local frameName = frame:GetName();
	local profitMoneyFrame = getglobal(frame:GetName().."MinProfit");
	local percentLessEdit = getglobal(frame:GetName().."MinPercentLessEdit");

	local minProfit = MoneyInputFrame_GetCopper(profitMoneyFrame);
	local minPercentLess = percentLessEdit:GetNumber();
	local catID = (UIDropDownMenu_GetSelectedID(getglobal(frameName.."CategoryDropDown")) or 1) - 1
	local minQuality = (UIDropDownMenu_GetSelectedID(getglobal(frameName.."MinQualityDropDown")) or 1) - 1;
	local itemName = getglobal(frameName.."SearchEdit"):GetText();
	if (itemName == "") then itemName = nil end

	frame:GetParent():SearchBuyouts(minProfit, minPercentLess, catID, minQuality, itemName);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearchPlain_SearchButton_OnClick(button)
	local frame = button:GetParent();
	local frameName = frame:GetName();

	local maxPrice = MoneyInputFrame_GetCopper(getglobal(frameName.."MaxPrice")) or 0
	local catID = (UIDropDownMenu_GetSelectedID(getglobal(frameName.."CategoryDropDown")) or 1) - 1
	local minQuality = (UIDropDownMenu_GetSelectedID(getglobal(frameName.."MinQualityDropDown")) or 1) - 1;
	local itemName = getglobal(frameName.."SearchEdit"):GetText();
	if (itemName == "") then itemName = nil end

	frame:GetParent():SearchPlain(maxPrice, catID, minQuality, itemName);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearchCompete_SearchButton_OnClick(button)
	local frame = button:GetParent();
	local undercutMoneyFrame = getglobal(frame:GetName().."Undercut");

	local minUndercut = MoneyInputFrame_GetCopper(undercutMoneyFrame);
	frame:GetParent():SearchCompetition(minUndercut);
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function AuctionFrameSearch_GetAuctionAlpha(auction)
	local status = auction.status;
	if (not status or status == AUCTION_STATUS_NORMAL) then
		return 1.0;
	end
	return 0.4;
end

-------------------------------------------------------------------------------
-- Called when an auction is updated in the snapshot.
-------------------------------------------------------------------------------
function onAuctionUpdated(event, newAuction, oldAuction)
	AuctionFrameSearch:UpdateAuction(newAuction);
end

-------------------------------------------------------------------------------
-- Called when an auction is removed in the snapshot.
-------------------------------------------------------------------------------
function onAuctionRemoved(event, auction)
	AuctionFrameSearch:RemoveAuction(auction);
end

-------------------------------------------------------------------------------
-- Called when a bid scan is queued.
-------------------------------------------------------------------------------
function onBidScanQueued()
	AuctionFrameSearch:UpdateStatusWithPendingBids();
end

-------------------------------------------------------------------------------
-- Called when a bid scan is complete.
-------------------------------------------------------------------------------
function onBidScanComplete()
	AuctionFrameSearch:UpdateStatusWithPendingBids();
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function debugPrint(message)
	EnhTooltip.DebugPrint("[Auc.SearchTab] "..message);
end

--=============================================================================
-- Initialization
--=============================================================================
if (Auctioneer.UI.SearchTab ~= nil) then return end;
debugPrint("AuctioneerFrameSearch.lua loaded");

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
Auctioneer.UI.SearchTab = 
{
	Load = load;
};


