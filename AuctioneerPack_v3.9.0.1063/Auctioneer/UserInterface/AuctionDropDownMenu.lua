--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: <%version%> (<%codename%>)
	Revision: $Id: AuctionDropDownMenu.lua 1047 2006-10-06 07:47:26Z vindicator $

	Auctioneer auction item drop down menu

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
local show;
local initialize;

-------------------------------------------------------------------------------
-- Shows the auction dropdown menu for the specified auction.
-------------------------------------------------------------------------------
function show(auctionId)
	AuctionDropDownMenu.auctionId = auctionId;
	UIDropDownMenu_Initialize(AuctionDropDownMenu, initialize, "MENU");
	HideDropDownMenu(1);
	ToggleDropDownMenu(1, nil, AuctionDropDownMenu, "cursor");
end

-------------------------------------------------------------------------------
-- Callback to initialize the contents of the menu. Here is where we call
-- UIDropDownMenu_AddButton to add the menu items.
-------------------------------------------------------------------------------
function initialize()
	local auction = Auctioneer.SnapshotDB.GetAuctionById(nil, AuctionDropDownMenu.auctionId);
	if (auction) then
		---------------------------------------------------
		-- Add the "Bid" menu item.
		---------------------------------------------------
		local bidMenuItem = {};
		bidMenuItem.text = "Bid"; -- %todo: localize
		bidMenuItem.disabled = (auction.highBidder or auction.owner == UnitName("player"));
		bidMenuItem.func = 
			function()
				Auctioneer.BidScanner.BidByAuctionId(auction.auctionId);
			end
		UIDropDownMenu_AddButton(bidMenuItem);

		---------------------------------------------------
		-- Add the "Buyout" menu item.
		---------------------------------------------------
		local buyoutMenuItem = {};
		buyoutMenuItem.text = "Buyout"; -- %todo: localize
		buyoutMenuItem.disabled = (auction.buyoutPrice == 0 or auction.owner == UnitName("player"));
		buyoutMenuItem.func =
			function()
				Auctioneer.BidScanner.BuyoutByAuctionId(auction.auctionId);
			end
		UIDropDownMenu_AddButton(buyoutMenuItem);

		local itemKey = Auctioneer.ItemDB.CreateItemKeyFromAuction(auction);
		local itemName = Auctioneer.ItemDB.GetItemName(itemKey);
		local itemLink = Auctioneer.ItemDB.GetItemLink(itemKey);
		if (itemName and itemLink) then
			-----------------------------------------------
			-- Add the "Browse for" menu item.
			-----------------------------------------------
			local browseMenuItem = {};
			browseMenuItem.text = "Browse auctions for "..itemName; -- %todo: localize
			browseMenuItem.disabled = (not CanSendAuctionQuery());
			browseMenuItem.func =
				function()
					-- Search for the item and switch to the Browse tab.
					Auctioneer.UI.BrowseTab.QueryForItemByName(itemName);
					AuctionFrameTab_OnClick(1);
				end
			UIDropDownMenu_AddButton(browseMenuItem);

			-----------------------------------------------
			-- Add the "Refresh snapshot for" menu item.
			-----------------------------------------------
			local refreshMenuItem = {};
			refreshMenuItem.text = "Refresh snapshot for "..itemName; -- %todo: localize
			refreshMenuItem.disabled = (not CanSendAuctionQuery());
			refreshMenuItem.func =
				function()
					Auctioneer.ScanManager.ScanQuery(itemName);
				end
			UIDropDownMenu_AddButton(refreshMenuItem);

			-----------------------------------------------
			-- Add the "Clear history" menu item.
			-----------------------------------------------
			local clearMenuItem = {};
			clearMenuItem.text = "Clear history for "..itemName; -- %todo: localize
			clearMenuItem.func =
				function()
					Auctioneer.Statistic.ClearCache(itemKey);
					Auctioneer.SnapshotDB.Clear(itemKey);
					Auctioneer.HistoryDB.Clear(itemKey);
					Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtActClearOk'), itemLink));
				end
			UIDropDownMenu_AddButton(clearMenuItem);
			
			-- Check for the presence of the BeanCounter Transactions tab.
			if (AuctionFrameTransactions and AuctionFrameTransactions.SearchTransactions) then
				-- Locate the AuctionFrameTransactions tab
				local tabIndex = 1;
				while (getglobal("AuctionFrameTab"..(tabIndex)) ~= nil and
					   getglobal("AuctionFrameTab"..(tabIndex)):GetName() ~= "AuctionFrameTabTransactions") do
					tabIndex = tabIndex + 1;
				end
				if (getglobal("AuctionFrameTab"..(tabIndex)):GetName() ~= "AuctionFrameTabTransactions") then
					tabIndex = nil;
				end

				-------------------------------------------
				-- Add the "View transactions" menu item.
				-------------------------------------------
				local transactionsMenuItem = {};
				transactionsMenuItem.text = "View transactions for "..itemName; -- %todo: localize
				transactionsMenuItem.disabled = (not tabIndex);
				transactionsMenuItem.func =
					function()
						AuctionFrameTransactions:SearchTransactions(itemName, true, nil);
						AuctionFrameTab_OnClick(tabIndex);
					end
				UIDropDownMenu_AddButton(transactionsMenuItem);
			end
		end
	end
end

--=============================================================================
-- Initialization
--=============================================================================
if (Auctioneer.UI.AuctionDropDownMenu ~= nil) then return end;
debugPrint("AuctionDropDownMenu.lua loaded");

-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
Auctioneer.UI.AuctionDropDownMenu = 
{
	Show = show;
};
