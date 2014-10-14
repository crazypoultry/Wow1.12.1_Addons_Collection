--------------[[ UTILITY FUNCTIONS ]]--------------

function EDB_Print(msg, showheader)

	if (msg == nil)		   then msg = "nil"; end
	if (showheader == nil) then showheader = 1; end
	if (showheader == 1)   then msg = "[EDB] "..msg; end

	if ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(msg, 0.4, 0.6, 0.8);
	end

end

function EDB_RunInEnchantFrame(func)

	local focus = false;

	local i = 1;

	while true do
	
		local name = GetSpellName(i, "General");

		if ( not name ) then
			return;
		end

		if ( name == "Enchanting" ) then
			if ( not GetCraftSpellFocus(1) ) then
				CastSpell(i, "spell");
			else
				focus = true;
			end
			
			func();

			break;
		end
		i = i + 1;

	end

	if not focus then
		CloseCraft();
	end

end

function EDB_GetValue(link)

	-- Check to make sure we have a link
	if ( not link ) then
		return nil;
	end

	local auctioneerLoaded = IsAddOnLoaded("Auctioneer");

	if ( EDB_Config ) and ( EDB_Config.useAuctionAddons ) then

		if ( auctioneerLoaded ) then

			local itemKey = EDB_ItemKeyFromLink(link);
			local medianPrice, medianCount;

			if (Auctioneer) and (Auctioneer.Statistic) and (Auctioneer.Statistic.GetUsableMedian) then
				medianPrice, medianCount = Auctioneer.Statistic.GetUsableMedian(itemKey);
			elseif (Auctioneer_GetItemHistoricalMedianBuyout(itemKey)) then
				medianPrice, medianCount = Auctioneer_GetItemHistoricalMedianBuyout(itemKey);
			else
				EDB_Print("Error - Incompatible version of Auctioneer found");
			end

			-- couldn't get an accurate auction price
			if ( not medianCount ) or ( medianCount <  5 ) or ( not medianPrice ) or ( medianPrice == 0 ) then
				-- attempt to use the buy from vendor price
				if ( Auctioneer ) and ( Auctioneer.API ) and ( Auctioneer.API.GetVendorBuyPrice ) then
					return Auctioneer.API.GetVendorBuyPrice(EDB_HItemFromLink(link));
				elseif ( Auctioneer_GetVendorBuyPrice(EDB_HItemFromLink(link)) ) then
					return Auctioneer_GetVendorBuyPrice(EDB_HItemFromLink(link));
				else
					return 0;
				end
		   else
				return medianPrice;
		   end

		else

			return nil;

		end

	else

		return nil;

	end

	return nil;

end
