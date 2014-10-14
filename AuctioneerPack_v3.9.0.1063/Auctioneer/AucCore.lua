--[[
	Auctioneer Addon for World of Warcraft(tm).
	Version: 3.9.0.1063 (Kangaroo)
	Revision: $Id: AucCore.lua 1034 2006-10-04 05:18:29Z mentalpower $

	Auctioneer core functions and variables.
	Functions central to the major operation of Auctioneer.

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
local addonLoaded;
local lockAndLoad;

-------------------------------------------------------------------------------
-- Data Members
-------------------------------------------------------------------------------

--Local constants
local maxAllowedFormatInt = 2000000000; -- numbers much greater than this overflow when using format("%d") --MAX_ALLOWED_FORMAT_INT

-- Auction time constants
--Auctioneer.Core.Constants.TimeLeft.
local timeLeft = {
	Short = 1;		--TIME_LEFT_SHORT
	Medium = 2;		--TIME_LEFT_MEDIUM
	Long = 3;		--TIME_LEFT_LONG
	VeryLong = 4;	--TIME_LEFT_VERY_LONG

	Seconds = {		--TIME_LEFT_SECONDS
		[0] = 0,		-- Could expire any second... the current bid is relatively accurate.
		[1] = 1800,		-- If it disappears within 30 mins of last seing it, it was BO'd
		[2] = 7200,		-- Ditto but for 2 hours.
		[3] = 28800,	-- 8 hours.
		[4] = 86400,	-- 24 hours.
	}
}

-- Item quality constants
--Auctioneer.Core.Constants.Quality
local quality = {
	Legendary	=	5;	--QUALITY_LEGENDARY
	Epic		=	4;	--QUALITY_EPIC
	Rare		=	3;	--QUALITY_RARE
	Uncommon	=	2;	--QUALITY_UNCOMMON
	Common		=	1;	--QUALITY_COMMON
	Poor		=	0;	--QUALITY_POOR
}


-- The maximum number of elements we store in our buyout prices history table
local maxBuyoutHistorySize = 35;

-- Min median buyout price for an item to show up in the list of items below median
local minProfitMargin = 5000; --MIN_PROFIT_MARGIN

-- Min median buyout price for an item to show up in the list of items below median
local defaultCompeteLess = 5; --DEFAULT_COMPETE_LESS

-- Min times an item must be seen before it can show up in the list of items below median
local minBuyoutSeenCount = 5; --MIN_BUYOUT_SEEN_COUNT

-- Max buyout price for an auction to display as a good deal item
local maxBuyoutPrice = 800000; --MAX_BUYOUT_PRICE

-- The default percent less, only find auctions that are at a minimum this percent less than the median
local minPercentLessThanHSP = 60; -- 60% default --MIN_PERCENT_LESS_THAN_HSP

-- The minimum profit/price percent that an auction needs to be displayed as a resellable auction
local minProfitPricePercent = 30; -- 30% default --MIN_PROFIT_PRICE_PERCENT

-- The minimum percent of bids placed on an item to be considered an "in-demand" enough item to be traded, this is only applied to Weapons and Armor and Recipies
local minBidPercent = 10; --MIN_BID_PERCENT

-- categories that the brokers and HSP look at the bid data for
--  1 = weapon
--  2 = armor
--  3 = container
--  4 = dissipatable
--  5 = tradeskillitems
--  6 = projectile
--  7 = quiver
--  8 = recipe
--  9 = reagence
-- 10 = miscellaneous
local function pack(...)
	return arg;
end
local classes = pack(GetAuctionItemClasses());
local bidBasedCategories = {[classes[1]]=true, [classes[2]]=true, [classes[8]]=true, [classes[10]]=true} --BID_BASED_CATEGORIES

-- Default filter configuration
local filterDefaults = { --Auctioneer_FilterDefaults
	["all"]						=	"on",
	["autofill"]				=	"on",
	["embed"]					=	"off",
	["also"]					=	"off",
	["auction-click"]			=	"on",
	["show-link"]				=	"off",
	["show-embed-blankline"]	=	"off",
	["show-verbose"]			=	"on",
	["show-stats"]				=	"on",
	["show-average"]			=	"on",
	["show-median"]				=	"on",
	["show-suggest"]			=	"on",
	["show-warning"]			=	"on",
	["scan-class1"]				=	"on",
	["scan-class2"]				=	"on",
	["scan-class3"]				=	"on",
	["scan-class4"]				=	"on",
	["scan-class5"]				=	"on",
	["scan-class6"]				=	"on",
	["scan-class7"]				=	"on",
	["scan-class8"]				=	"on",
	["scan-class9"]				=	"on",
	["scan-class10"]			=	"on",
	["warn-color"]				=	"on",
	["finish-sound"]			=	"on",
	["printframe"]				=	1,
	["last-auction-duration"]	=	1440,
	["auction-duration"]		=	3,
	["protect-window"]			=	1,
	["finish"]					=	0,
	["pct-bidmarkdown"]			=	20,
	["pct-markup"]				=	300,
	["pct-maxless"]				=	30,
	["pct-nocomp"]				=	2,
	["pct-underlow"]			=	5,
	["pct-undermkt"]			=	20,
	["locale"]					=	"default",

	--AskPrice related commands
	["askprice"]				=	"on",
	["askprice-vendor"]			=	"off",
	["askprice-guild"]			=	"off",
	["askprice-party"]			=	"off",
	["askprice-smart"]			=	"off",
	["askprice-trigger"]		=	"?",
	["askprice-ad"]				=	"on",
	["askprice-whispers"]		=	"on",
	["askprice-word1"]			=	_AUCT('CmdAskPriceSmartWord1', "enUS"), --Initially set these two filters to match the stock english custom words
	["askprice-word2"]			=	_AUCT('CmdAskPriceSmartWord2', "enUS"),

	-- Auction House tab UI
	["bid-limit"]				=	1,
	["update-price"]			=	"off",
}

-------------------------------------------------------------------------------
-- Called when we receive the ADDON_LOADED event for Auctioneer.
-------------------------------------------------------------------------------
function addonLoaded()
	-- Initialize the database.
	Auctioneer.Database.Load();

	-- Initialize modules.
	Auctioneer.QueryManager.Load();
	Auctioneer.ScanManager.Load();
	Auctioneer.Statistic.Load();
	Auctioneer.PostManager.Load();
	Auctioneer.BidManager.Load();
	Auctioneer.BidScanner.Load();
	Auctioneer.AskPrice.Init();

	-- Intialize the command handler.
	SLASH_AUCTIONEER1 = "/auctioneer";
	SLASH_AUCTIONEER2 = "/auction";
	SLASH_AUCTIONEER3 = "/auc";
	SlashCmdList["AUCTIONEER"] = Auctioneer.Command.MainHandler;
	Auctioneer.Command.Register();

	-- Initialize the UI.
	Auctioneer.UI.Load();

	--Init AskPrice
	Auctioneer.AskPrice.Init();

	--Register for the PLAYER_LOGIN event so that we can get the player's faction
	Auctioneer.Util.StorePlayerFaction();
	Stubby.RegisterEventHook("PLAYER_LOGIN", "Auctioneer", Auctioneer.Util.StorePlayerFaction);

	-- Ready to rock and roll!
	Auctioneer.Util.ChatPrint(string.format(_AUCT('FrmtWelcome'), Auctioneer.Version), 0.8, 0.8, 0.2);

 	-- Cleanup after that massive mem spike.
	collectgarbage();
end

Auctioneer.Core = {
	Constants = {},
	AddonLoaded = addonLoaded,
}

Auctioneer.Core.Constants = {
	MaxAllowedFormatInt = maxAllowedFormatInt,
	TimeLeft = timeLeft,
	Quality = quality,
	MaxBuyoutHistorySize = maxBuyoutHistorySize,
	MinProfitMargin = minProfitMargin,
	DefaultCompeteLess = defaultCompeteLess,
	MinBuyoutSeenCount = minBuyoutSeenCount,
	MaxBuyoutPrice = maxBuyoutPrice,
	MinPercentLessThanHSP = minPercentLessThanHSP,
	MinProfitPricePercent = minProfitPricePercent,
	MinBidPercent = minBidPercent,
	BidBasedCategories = bidBasedCategories,
	FilterDefaults = filterDefaults,
}
