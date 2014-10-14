EasyAuction_Prices = {};
EasyAuction_PersonalPrices = {};

local Playername = nil;
local EasyAuction_origEventFunc = nil;
local EasyAuction_origStartFunc = nil;

function EasyAuction_eventfunc()
	if (EasyAuction_origEventFunc ~= nil) then
		EasyAuction_origEventFunc();
	end
	if ( event == "NEW_AUCTION_UPDATE") then
		local name, texture, count, quality, canUse, price = GetAuctionSellItemInfo();
		local lastauction = nil;
		if (Playername ~= nil and EasyAuction_PersonalPrices[Playername] ~= nil
				and EasyAuction_PersonalPrices[Playername][name] ~= nil) then
			lastauction = EasyAuction_PersonalPrices[Playername][name];
		else
			if (EasyAuction_Prices[name] ~= nil) then
				lastauction = EasyAuction_Prices[name];
			end
		end
		if (lastauction ~= nil) then
			MoneyInputFrame_SetCopper(StartPrice, lastauction.bid * count);
			MoneyInputFrame_SetCopper(BuyoutPrice, lastauction.buyout * count);
		end
	end
end

function EasyAuction_startfunc(start, buyout, duration)
		local name, texture, count, quality, canUse, price = GetAuctionSellItemInfo();
		EasyAuction_Prices[name] = {};
		EasyAuction_Prices[name].bid = start / count;
		EasyAuction_Prices[name].buyout = buyout / count;
		if (Playername ~= nil) then
			if (EasyAuction_PersonalPrices[Playername] == nil) then
				EasyAuction_PersonalPrices[Playername] = {};
			end
			EasyAuction_PersonalPrices[Playername][name] = {};
			EasyAuction_PersonalPrices[Playername][name].bid = start / count;
			EasyAuction_PersonalPrices[Playername][name].buyout = buyout / count;
		end
		if (EasyAuction_origStartFunc ~= nil) then
			EasyAuction_origStartFunc(start, buyout, duration);
		end
end

-- OnFoo Functions
function EasyAuction_OnLoad()
	Playername = UnitName("player");
	this:RegisterEvent("NEW_AUCTION_UPDATE");
	--UIErrorsFrame:AddMessage("EasyAuction loaded", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
end

function EasyAuction_OnEvent()
	if (event == "NEW_AUCTION_UPDATE") then
		--UIErrorsFrame:AddMessage("EasyAuction NEW_AUCTION_UPDATE", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
		if (EasyAuction_origEventFunc == nil) then
			--UIErrorsFrame:AddMessage("EasyAuction overloading functions", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
			EasyAuction_origEventFunc = AuctionSellItemButton_OnEvent;
			AuctionSellItemButton_OnEvent = EasyAuction_eventfunc;
			EasyAuction_origStartFunc = StartAuction;
			StartAuction = EasyAuction_startfunc;
			EasyAuction_eventfunc();
		end
	end
end
