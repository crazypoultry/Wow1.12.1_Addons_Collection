local AuctionSort_OldSetWidth

function AuctionSort_OnLoad()
  local name,title,notes,enabled,loadable,reason,security
  name,title,notes,enabled,loadable,reason,security = GetAddOnInfo("AuctionSort")
  DEFAULT_CHAT_FRAME:AddMessage(title.." loaded")

  this:RegisterEvent("AUCTION_HOUSE_SHOW")
  this:RegisterEvent("ADDON_LOADED")
end

function AuctionSort_OnEvent()
  if event == "AUCTION_HOUSE_SHOW" and IsAddOnLoaded("Blizzard_AuctionUI") then
    if not AuctionSort_OldSetWidth and BrowseCurrentBidSort then
--      if IsAddOnLoaded("AuctionSortLoader") then
--        message("Plese delete the AuctionSortLoader from the addons directory.  After you do and restart WoW, this message will not reappear - Abraha")
--      end

      BrowseBuyoutSort:ClearAllPoints()
      BrowseBuyoutSort:SetParent(AuctionFrameBrowse)
      BrowseBuyoutSort:SetPoint("LEFT","BrowseCurrentBidSort","RIGHT",-2,0)
      BrowseBuyoutSort:Show()

      BrowseNameSort:ClearAllPoints()
      BrowseNameSort:SetParent(AuctionFrameBrowse)
      BrowseNameSort:SetPoint("TOPLEFT", "AuctionFrameBrowse", "TOPLEFT", 186, -82)
      BrowseNameSort:Show()

      BrowseQualitySort:ClearAllPoints()
      BrowseQualitySort:SetPoint("LEFT","BrowseNameSort","RIGHT",-2,0)
      BrowseQualitySort:Show()

      AuctionSort_OldSetWidth = BrowseCurrentBidSort.SetWidth;

      local name,title,notes,enabled,loadable,reason,security
      name,title,notes,enabled,loadable,reason,security = GetAddOnInfo("AuctionSort")

      BrowseCurrentBidSort.SetWidth = AuctionSort_SetWidth
      BrowseCurrentBidSort:SetWidth(207)
      BrowseQualitySort:SetWidth(BrowseQualitySort:GetWidth() - BrowseNameSort:GetWidth())
    end
  end
end

function AuctionSort_SetWidth(obj, width)
  if width >= 184 then
    width = width - BrowseBuyoutSort:GetWidth() + 2
  end

  AuctionSort_OldSetWidth(obj, width)
end

function SortBuyoutButton_UpdateArrow(button, type, sort)
	if ( not IsAuctionSortReversed(type, sort) ) then
		getglobal(button:GetName().."Arrow"):SetTexCoord(0, 0.5625, 1.0, 0);
	else
		getglobal(button:GetName().."Arrow"):SetTexCoord(0, 0.5625, 0, 1.0);
	end
end
