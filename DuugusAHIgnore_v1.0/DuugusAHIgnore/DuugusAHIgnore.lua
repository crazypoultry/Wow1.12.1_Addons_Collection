---------------------------------------------------------------------------------
-- 1.0
---------------------------------------------------------------------------------
-- Fixed the error when clicking on the item in the ah browse list 
-- No further errors where reported. Due to this I consider this addon as "final"
---------------------------------------------------------------------------------
-- 0.9.2
---------------------------------------------------------------------------------
-- Fixed "Error:[string "DuuguAuctionFrame:OnEvent"]:12: attempt to index global `Auctioneer' (a nil value) 
---------------------------------------------------------------------------------
-- 0.9.1
---------------------------------------------------------------------------------
-- New slash commands:
-- /dahi del
--   to clear the complete ignore list
-- /dahi auctioneer
--   turns Actioneer scanning for auctions started by ignored  players on/off 
--   (default=On - Actioneer scans auctions from ignored player
--   "new" auctions are auctions that where created since the last auctioneer scan
--
-- UI:
-- the auction house browse list now now displays ignored players in red
---------------------------------------------------------------------------------
-- 0.9.0
-- Initial release
---------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- globals
------------------------------------------------------------------------------------------------------------------------
DAHIDebug = false;
DAHIScaninprogress = false;
DAHIAuctioneerOnOffFlag = true;
DAHITBlau = "|cffffff00";
DAHIHBlau = "|caaaaaa00";
DAHIDBlau = "|cffffffaa";
DAHIIgnorelist = {};

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- TRANSLATIONS

--------------------------------------------------------------------------------------------------------------------
-- english translation
--------------------------------------------------------------------------------------------------------------------
	DAHIHeader = DAHIDBlau.."-------- DAHI --------";
	DAHILoad = "Duugus action house ignore list loaded (0.9.1)";
	DAHIAddList = " added to auction house ignore list";
	DAHIRemoveList = " removed from auction house ignore list";
	DAHIOnList = " is ignored";
	DAHIHelp = {DAHITBlau.."DAHI slash commands:", 
			DAHIHBlau.."/dahi help - shows this help", 
			DAHIHBlau.."/dahi list - show your auctions house ignore list", 
			DAHIHBlau.."/dahi PlayerName - adds player \"playername\" to your auction house ignore list. ", 
			DAHIHBlau.."  Another /dahi PlayerName removes the player from the list.", 
			DAHIHBlau.."/dahi del - clears the complet auction house ignore list",
			DAHIHBlau.."/dahi auctioneer - turns Actioneer scanning for auctions from ignored players",
			DAHIHBlau.."  on/off (default=on - Actioneer scans auctions from ignored players",
			DAHIHBlau.."To add/remove players via the auction house ui just right click a auction"}; 

	DAHIDel = "Auction house ignore list cleared";
	DAHIAuctionneerOn = "Auctioneer flag is ON - Auctioneer don't scans auctions started by ignored playerss";
	DAHIAuctionneerOff = "Auctioneer falg is OFF - Auctioneer scans auctions started by ignored players";
	DAHIIgnoPlayer = DAHITBlau.."Ignored players:";

	DAHINoAuctionneer = "No Auctioneer installed";
--------------------------------------------------------------------------------------------------------------------
-- german translation
--------------------------------------------------------------------------------------------------------------------
if GetLocale() == "deDE" then
	DAHIHeader = DAHIDBlau.."-------- DAHI --------";
	DAHILoad = "Duugus AH-Ignoreliste geladen (0.9.0)";
	DAHIAddList = " in AH-Ignoreliste eingetragen.";
	DAHIRemoveList = " aus AH-Ignoreliste entfernt.";
	DAHIOnList = " steht auf der AH-Ignoreliste.";
	DAHIHelp = {DAHITBlau.."Slashbefehle:", 
			DAHIHBlau.."/dahi hilfe - Zeigt diese Hilfe an.", 
			DAHIHBlau.."/dahi list - zeigt die AH-Ignoreliste an", 
			DAHIHBlau.."/dahi spielername - traegt den Spieler in die Liste ein.", 
			DAHIHBlau.."  mit einem weiteren /dahi Spielername wird der Spieler", 
			DAHIHBlau.."  wieder aus der Liste entfernt.", 
			DAHIHBlau.."/dahi del - loescht alle Eintrag auf der AH-Ignoreliste",
			DAHIHBlau.."/dahi auctioneer - schaltet das Scannen von Auktionen ignorierter Spieler",
			DAHIHBlau.."  durch Actioneer an/aus (Standard=an - Actioneer scannt Auktionen von",
			DAHIHBlau.."  ignorierten Spielern",
			DAHIHBlau.."Alternativ kann ein Spieler mit einem Rechtsklick auf ein", 
			DAHIHBlau.."  Angebot im Auktionshaus in die Liste ein- und ausgetragen", 
			DAHIHBlau.."  werden"};
	DAHIDel = "AH-Ignoreliste geleert";
	DAHIAuctionneerOn = "Auctioneer-Option ist AN - Auctioneer scannt keine Auktionen von ignorierten Spielern";
	DAHIAuctionneerOff = "Auctioneer-Option ist AUS - Auctioneer scannt auch Auktionen von ignorierten Spielern";
	DAHIIgnoPlayer = DAHITBlau.."Ignorierte Spieler:";
	DAHINoAuctionneer = "Auctioneer ist nicht installiert";
end

--------------------------------------------------------------------------------------------------------------------
-- french translation ... TO DO!!!!
--------------------------------------------------------------------------------------------------------------------
if GetLocale() == "frFR" then
	DAHIHeader = DAHIDBlau.."-------- DAHI --------";
	DAHILoad = "Duugus action house ignore list loaded (0.9.0)";
	DAHIAddList = " added to auction house ignore list";
	DAHIRemoveList = " removed from auction house ignore list";
	DAHIOnList = " is ignored";
	DAHIHelp = {DAHITBlau.."DAHI slash commands:", 
			DAHIHBlau.."/dahi help - shows this help", 
			DAHIHBlau.."/dahi list - show your auctions house ignore list", 
			DAHIHBlau.."/dahi PlayerName - adds player \"playername\" to your auction house ignore list. ", 
			DAHIHBlau.."  Another /dahi PlayerName removes the player from the list.", 
			DAHIHBlau.."/dahi del - clears the complet auction house ignore list",
			DAHIHBlau.."/dahi auctioneer - turns Actioneer scanning for auctions from ignored players",
			DAHIHBlau.."  on/off (default=on - Actioneer scans auctions from ignored players",
			DAHIHBlau.."To add/remove players via the auction house ui just right click a auction"}; 

	DAHIDel = "Auction house ignore list cleared";
	DAHIAuctionneerOn = "Auctioneer flag is ON - Auctioneer don't scans auctions from ignored players";
	DAHIAuctionneerOff = "Auctioneer falg is OFF - Auctioneer scans auctions started by ignored players";
	DAHIIgnoPlayer = DAHITBlau.."Ignored players:";

	DAHINoAuctionneer = "No Auctioneer installed";
end
--------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------
-- guess what :)
------------------------------------------------------------------------------------------------------------------------
function DuuguAuctionFrame_OnLoad()
	DEFAULT_CHAT_FRAME:AddMessage(DAHILoad);
	SLASH_DAHI1 = "/ahi";
	SLASH_DAHI2 = "/dahi";
	SlashCmdList["DAHI"] = DAHISlash;
end
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- Hook for BrowseButton_OnClick() - prevents selection of actions from ignored sellers an handles right click to
-- add/remove sellers to the ignore list
------------------------------------------------------------------------------------------------------------------------
function DuuguBrowseButton_OnClick(button)
	button = this;
	if button then
		if string.find(button:GetName(), "Item") then
			button = getglobal(string.sub(button:GetName(), 1, 13));
		end
	end

	-- right button ... add/remove seller 
	if arg1 == "RightButton" then
		if button then
			if string.find(button:GetName(), "Item") then
				button = getglobal(string.sub(button:GetName(), 1, 13));
			end
		end

		obj = getglobal("BrowseButton"..button:GetID().."HighBidder");
		cmd = obj:GetText();
		if DAHIIgnorelist[cmd] == Nil then
			table.insert(DAHIIgnorelist, cmd);
			DAHIIgnorelist[cmd] = cmd;
			DEFAULT_CHAT_FRAME:AddMessage(DAHIHBlau..DAHIIgnorelist[cmd]..DAHIAddList);
			if BrowseBidButton then
				BrowseBidButton:Disable();
				BrowseBuyoutButton:Disable();
			end
		else
			if DAHIIgnorelist[cmd] == cmd then
				local deltmp = Nil;
				for x = 1, getn(DAHIIgnorelist), 1 do
					if DAHIIgnorelist[DAHIIgnorelist[x]] == cmd then
						deltmp = x;	
					end
				end
				if deltmp ~= Nil then
					DEFAULT_CHAT_FRAME:AddMessage(DAHIHBlau..DAHIIgnorelist[DAHIIgnorelist[deltmp]]..DAHIRemoveList);
					DAHIIgnorelist[DAHIIgnorelist[deltmp]] = Nil;
					table.remove(DAHIIgnorelist, deltmp );
				end
			end
		end
	end

	-- get seller name and test if seller is ignored
	if button then
		if string.find(button:GetName(), "Item") then
			button = getglobal(string.sub(button:GetName(), 1, 13));
		end
	end

	obj = getglobal("BrowseButton"..button:GetID().."HighBidder");
	local ign = false;
	for x = 1, getn(DAHIIgnorelist), 1 do
		if string.upper(obj:GetText()) == string.upper(DAHIIgnorelist[x]) then
			ign = true;
		end
	end

	if ign == false then
		-- original BrowseButton_OnClic code ... just select the auction
		SetSelectedAuctionItem("list", button:GetID() + FauxScrollFrame_GetOffset(BrowseScrollFrame));
		AuctionFrameBrowse_Update();
	else
		-- seller is ignored ... don't select and disable bid/buy buttons
		AuctionFrameBrowse_Update();
		BrowseBidButton:Disable();
		BrowseBuyoutButton:Disable();
		DEFAULT_CHAT_FRAME:AddMessage(obj:GetText()..DAHIOnList);
	end
end
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- handle slash commands
------------------------------------------------------------------------------------------------------------------------
function DAHISlash(cmd)
	local Text = "";
	local Pars = {};
	local cmdo = cmd;

	if cmd == "hilfe" or cmd == "?" or cmd == "help" or cmd == Nil or cmd == "" then
		DEFAULT_CHAT_FRAME:AddMessage(DAHIHeader);
		for x = 1, getn(DAHIHelp), 1 do
			DEFAULT_CHAT_FRAME:AddMessage(DAHIHelp[x]);
		end
		return;
	elseif cmd == "list" then
		DEFAULT_CHAT_FRAME:AddMessage(DAHIHeader);
		DEFAULT_CHAT_FRAME:AddMessage(DAHIIgnoPlayer);
		for x = 1, getn(DAHIIgnorelist), 1 do
			DEFAULT_CHAT_FRAME:AddMessage(DAHIHBlau..DAHIIgnorelist[x]);
		end
		if DAHIAuctioneerOnOffFlag == true and Auctioneer then
			DEFAULT_CHAT_FRAME:AddMessage(DAHIHBlau..DAHIAuctionneerOn);
		elseif DAHIAuctioneerOnOffFlag == false and Auctioneer then
			DEFAULT_CHAT_FRAME:AddMessage(DAHIHBlau..DAHIAuctionneerOff);
		end
	elseif cmd == "del" then
		DAHIIgnorelist = {};
		DEFAULT_CHAT_FRAME:AddMessage(DAHIHeader);
		DEFAULT_CHAT_FRAME:AddMessage(DAHIHBlau..DAHIDel);
	elseif cmd == "auctioneer" or cmd == "Auctioneer" then
		if Auctioneer then
			if Auctioneer.Event then
				DEFAULT_CHAT_FRAME:AddMessage(DAHIHeader);
				if DAHIAuctioneerOnOffFlag == true then
					DAHIAuctioneerOnOffFlag = false;
					DEFAULT_CHAT_FRAME:AddMessage(DAHIHBlau..DAHIAuctionneeroff);
				elseif DAHIAuctioneerOnOffFlag == false then
					DAHIAuctioneerOnOffFlag = true;
					DEFAULT_CHAT_FRAME:AddMessage(DAHIHBlau..DAHIAuctionneeron);
				end
			else
				DEFAULT_CHAT_FRAME:AddMessage(DAHIHeader);
				DEFAULT_CHAT_FRAME:AddMessage(DAHIHBlau..DAHINoAuctionneer);
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage(DAHIHeader);
			DEFAULT_CHAT_FRAME:AddMessage(DAHIHBlau..DAHINoAuctionneer);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(DAHIHeader);
		if DAHIIgnorelist[cmd] == Nil then
			table.insert(DAHIIgnorelist, cmd);
			DAHIIgnorelist[cmd] = cmd;
			DEFAULT_CHAT_FRAME:AddMessage(DAHIHBlau..DAHIIgnorelist[cmd]..DAHIAddList);
			if BrowseBidButton then
				BrowseBidButton:Disable();
				BrowseBuyoutButton:Disable();
			end
		else
			for x = 1, getn(DAHIIgnorelist), 1 do
				if DAHIIgnorelist[cmd] == cmd then
					DEFAULT_CHAT_FRAME:AddMessage(DAHIHBlau..DAHIIgnorelist[cmd]..DAHIRemoveList);
					DAHIIgnorelist[cmd] = Nil;
					table.remove(DAHIIgnorelist, x);
				end
			end
		end
	end
end
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- Hook for AuctionFrameBrowse_Update() to display ignored sellers in red
------------------------------------------------------------------------------------------------------------------------
function DAHIAuctionFrameBrowse_Update()

	if DAHIDebug == true then
		DEFAULT_CHAT_FRAME:AddMessage("dahi update");
	end

	-- call original AuctionFrameBrowse_Update() just in case ...
	DAHIOldAuctionFrameBrowse_Update();

----------------------------------------------------------------
-- start of original code from blizz ui
----------------------------------------------------------------
	local numBatchAuctions, totalAuctions = GetNumAuctionItems("list");
	local button, buttonName, iconTexture, itemName, color, itemCount, moneyFrame, buyoutMoneyFrame, buyoutText, buttonHighlight;
	local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame);
	local index;
	local isLastSlotEmpty;
	local name, texture, count, quality, canUse, minBid, minIncrement, buyoutPrice, duration, bidAmount, highBidder, owner;
	BrowseBidButton:Disable();
	BrowseBuyoutButton:Disable();
	-- Update sort arrows
	SortButton_UpdateArrow(BrowseQualitySort, "list", "quality");
	SortButton_UpdateArrow(BrowseLevelSort, "list", "level");
	SortButton_UpdateArrow(BrowseDurationSort, "list", "duration");
	SortButton_UpdateArrow(BrowseHighBidderSort, "list", "status");
	SortButton_UpdateArrow(BrowseCurrentBidSort, "list", "bid");

	-- Show the no results text if no items found
	if ( numBatchAuctions == 0 ) then
		BrowseNoResultsText:Show();
	else
		BrowseNoResultsText:Hide();
	end

	for i=1, NUM_BROWSE_TO_DISPLAY do
		index = offset + i + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse.page);
		button = getglobal("BrowseButton"..i);
		-- Show or hide auction buttons
		if ( index > (numBatchAuctions + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse.page)) ) then
			button:Hide();
			-- If the last button is empty then set isLastSlotEmpty var
			if ( i == NUM_BROWSE_TO_DISPLAY ) then
				isLastSlotEmpty = 1;
			end
		else
			button:Show();

			buttonName = "BrowseButton"..i;
			name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner =  GetAuctionItemInfo("list", offset + i);


			duration = GetAuctionItemTimeLeft("list", offset + i);
			-- Resize button if there isn't a scrollbar
			buttonHighlight = getglobal("BrowseButton"..i.."Highlight");
			if ( numBatchAuctions < NUM_BROWSE_TO_DISPLAY ) then
				button:SetWidth(557);
				buttonHighlight:SetWidth(523);
				BrowseCurrentBidSort:SetWidth(173);
			else
				button:SetWidth(532);
				buttonHighlight:SetWidth(502);
				BrowseCurrentBidSort:SetWidth(157);
			end
			-- Set name and quality color
			color = ITEM_QUALITY_COLORS[quality];
			itemName = getglobal(buttonName.."Name");
			itemName:SetText(name);
			itemName:SetVertexColor(color.r, color.g, color.b);
			-- Set level
			if ( level > UnitLevel("player") ) then
				getglobal(buttonName.."Level"):SetText(RED_FONT_COLOR_CODE..level..FONT_COLOR_CODE_CLOSE);
			else
				getglobal(buttonName.."Level"):SetText(level);
			end
			-- Set closing time
			getglobal(buttonName.."ClosingTimeText"):SetText(AuctionFrame_GetTimeLeftText(duration));
			getglobal(buttonName.."ClosingTime").tooltip = AuctionFrame_GetTimeLeftTooltipText(duration);
			-- Set item texture, count, and usability
			iconTexture = getglobal(buttonName.."ItemIconTexture");
			iconTexture:SetTexture(texture);
			if ( not canUse ) then
				iconTexture:SetVertexColor(1.0, 0.1, 0.1);
			else
				iconTexture:SetVertexColor(1.0, 1.0, 1.0);
			end
			itemCount = getglobal(buttonName.."ItemCount");
			if ( count > 1 ) then
				itemCount:SetText(count);
				itemCount:Show();
			else
				itemCount:Hide();
			end
			-- Set high bid
			moneyFrame = getglobal(buttonName.."MoneyFrame");
			yourBidText = getglobal(buttonName.."YourBidText");
			buyoutMoneyFrame = getglobal(buttonName.."BuyoutMoneyFrame");
			buyoutText = getglobal(buttonName.."BuyoutText");
			-- If not bidAmount set the bid amount to the min bid
			if ( bidAmount == 0 ) then
				MoneyFrame_Update(moneyFrame:GetName(), minBid);
			else
				MoneyFrame_Update(moneyFrame:GetName(), bidAmount);
			end

			if ( highBidder ) then
				yourBidText:Show();
			else
				yourBidText:Hide();
			end

			if ( buyoutPrice > 0 ) then
				moneyFrame:SetPoint("RIGHT", buttonName, "RIGHT", 60, 10);
				MoneyFrame_Update(buyoutMoneyFrame:GetName(), buyoutPrice);
				buyoutMoneyFrame:Show();
				buyoutText:Show();
			else
				moneyFrame:SetPoint("RIGHT", buttonName, "RIGHT", 60, 3);
				buyoutMoneyFrame:Hide();
				buyoutText:Hide();
			end
			-- Set high bidder
			--if ( not highBidder ) then
			--	highBidder = RED_FONT_COLOR_CODE..NO_BIDS..FONT_COLOR_CODE_CLOSE;
			--end


			getglobal(buttonName.."HighBidder"):SetText(owner);




			------------------------------------------------------------------------------
			-- added this part to set text color for seller name to red if seller is ignored
			local ign = false;
			for x = 1, getn(DAHIIgnorelist), 1 do
				if owner then
					if string.upper(owner) == string.upper(DAHIIgnorelist[x]) then
						ign = true;
					end
				end
			end
			if ign == false then
				getglobal(buttonName.."HighBidder"):SetTextColor(255, 255, 255);
			else
				getglobal(buttonName.."HighBidder"):SetTextColor(255, 0, 0);
			end
			------------------------------------------------------------------------------




			-- Set highlight
			if ( GetSelectedAuctionItem("list") and (offset + i) == GetSelectedAuctionItem("list") ) then
				button:LockHighlight();
				
				if ( buyoutPrice > 0 and buyoutPrice >= minBid and GetMoney() >= buyoutPrice ) then
					BrowseBuyoutButton:Enable();
					AuctionFrame.buyoutPrice = buyoutPrice;
				else
					AuctionFrame.buyoutPrice = nil;
				end
				-- Set bid
				if ( bidAmount > 0 ) then
					bidAmount = bidAmount + minIncrement ;
					MoneyInputFrame_SetCopper(BrowseBidPrice, bidAmount);
				else
					MoneyInputFrame_SetCopper(BrowseBidPrice, minBid);
				end

				if ( not highBidder and GetMoney() >= MoneyInputFrame_GetCopper(BrowseBidPrice) ) then
					BrowseBidButton:Enable();
				end
			else
				button:UnlockHighlight();
			end
		end
	end

	-- Update scrollFrame
	-- If more than one page of auctions show the next and prev arrows when the scrollframe is scrolled all the way down
	if ( totalAuctions > NUM_AUCTION_ITEMS_PER_PAGE ) then
		if ( isLastSlotEmpty ) then
			BrowsePrevPageButton:Show();
			BrowseNextPageButton:Show();
			BrowseSearchCountText:Show();
			local itemsMin = AuctionFrameBrowse.page * NUM_AUCTION_ITEMS_PER_PAGE + 1;
			local itemsMax = itemsMin + numBatchAuctions - 1;
			BrowseSearchCountText:SetText(format(NUMBER_OF_RESULTS_TEMPLATE, itemsMin, itemsMax, totalAuctions ));
			if ( AuctionFrameBrowse.page == 0 ) then
				BrowsePrevPageButton.isEnabled = nil;
			else
				BrowsePrevPageButton.isEnabled = 1;
			end
			if ( AuctionFrameBrowse.page == (ceil(totalAuctions/NUM_AUCTION_ITEMS_PER_PAGE) - 1) ) then
				BrowseNextPageButton.isEnabled = nil;
			else
				BrowseNextPageButton.isEnabled = 1;
			end
		else
			BrowsePrevPageButton:Hide();
			BrowseNextPageButton:Hide();
			BrowseSearchCountText:Hide();
		end
		
		-- Artifically inflate the number of results so the scrollbar scrolls one extra row
		numBatchAuctions = numBatchAuctions + 1;
	else
		BrowsePrevPageButton:Hide();
		BrowseNextPageButton:Hide();
		BrowseSearchCountText:Hide();
	end
	FauxScrollFrame_Update(BrowseScrollFrame, numBatchAuctions, NUM_BROWSE_TO_DISPLAY, AUCTIONS_BUTTON_HEIGHT);
----------------------------------------------------------------
-- end of original code
----------------------------------------------------------------
end
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- hook for GetAuctionItemInfo() to return Nil instead itemname if seller is ignored and actioneer is scanning 
-- prevents actioneer from scanning auctions from ignored sellers
------------------------------------------------------------------------------------------------------------------------
function DAHIGetAuctionItemInfo(type, offset)
	name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner =  DAHIOldGetAuctionItemInfo(type, offset);
	local ign = false;
	for x = 1, getn(DAHIIgnorelist), 1 do
		if owner then
			if string.upper(owner) == string.upper(DAHIIgnorelist[x]) then
				ign = true;
			end
		end
	end
	if ign == false then
		return name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner;
	else
		if DAHIScaninprogress == false then
			return name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner;
		else
			if DAHIAuctioneerOnOffFlag == false then
				if DAHIDebug == true then
					DEFAULT_CHAT_FRAME:AddMessage("GetAction Nil");
				end
				return Nil, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner;
			else
				return name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner;
			end
		end
	end
end
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- Hook for auctioneer startAuctionScan event - sets flag for scan in progress
------------------------------------------------------------------------------------------------------------------------
function DAHIstartAuctionScan()
	if DAHIDebug == true then
		DEFAULT_CHAT_FRAME:AddMessage("start sip");
	end
	DAHIScaninprogress = true;
	DAHIOldStartAuctionScan();
end
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- Hook for auctioneer stopAuctionScan event - disables flag for scan in progress
------------------------------------------------------------------------------------------------------------------------
function DAHIstopAuctionScan()
	if DAHIDebug == true then
		DEFAULT_CHAT_FRAME:AddMessage("stop sip");
	end
	DAHIScaninprogress = false;
	stopAuctionScan();
	DAHIOldStopAuctionScan();
end
