----------------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------------

local AH_ShowBid_OldGetAuctionItemInfo;

----------------------------------------------------------------------
-- OnFoo
----------------------------------------------------------------------

function AH_ShowBid_OnLoad()

        -- Register Default Events
        this:RegisterEvent("PLAYER_ENTERING_WORLD");
        this:RegisterEvent("PLAYER_LEAVING_WORLD");

        --Load-message
        if ( DEFAULT_CHAT_FRAME ) then
                DEFAULT_CHAT_FRAME:AddMessage("AH_ShowBid".." ".."11000 R.1".." Loaded");
        end

end

function AH_ShowBid_OnEvent(event, arg1)

        -- Register Ingame Events
        if (event == "PLAYER_ENTERING_WORLD") then
                this:RegisterEvent("AUCTION_HOUSE_SHOW");
                this:RegisterEvent("AUCTION_HOUSE_CLOSED");
        end

        -- Unregister Ingame Events
        if (event == "PLAYER_LEAVING_WORLD") then
                this:UnregisterEvent("AUCTION_HOUSE_SHOW");
                this:UnregisterEvent("AUCTION_HOUSE_CLOSED");
        end

        --Hook into GetAuctionItemInfo
        if (event == "AUCTION_HOUSE_SHOW") then
                AH_ShowBid_OldGetAuctionItemInfo = GetAuctionItemInfo;
                GetAuctionItemInfo = AH_ShowBid_GetAuctionItemInfo;
        end

        --Hook into GetAuctionItemInfo
        if (event == "AUCTION_HOUSE_CLOSED") then
                if (AH_ShowBid_OldGetAuctionItemInfo) then
                        GetAuctionItemInfo = AH_ShowBid_OldGetAuctionItemInfo;
                        AH_ShowBid_OldGetAuctionItemInfo = nil;
                end
        end

end

----------------------------------------------------------------------
-- Other Functions
----------------------------------------------------------------------

-- function based on code from ShowBid by DarkStarX
function AH_ShowBid_GetAuctionItemInfo(list, offset_i)

        local name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner =  AH_ShowBid_OldGetAuctionItemInfo(list, offset_i);

        if ( (list == "list") and (bidAmount > 0) ) then

                -- Shorten long names
                if (string.len(name) > 30) then
                        name = string.sub(name, 0, 28) .. "...";
                end

                name = name .. " |cffffff00(" .. AH_SHOWBID_BID .. ")|r";

        end

        return name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner;

end