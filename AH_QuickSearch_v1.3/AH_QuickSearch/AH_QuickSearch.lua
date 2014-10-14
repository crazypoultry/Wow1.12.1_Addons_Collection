--------------------------------------------------------------------------
-- AH_QuickSearch.lua 
--------------------------------------------------------------------------
--[[
AH_QuickSearch

author: AnduinLothar KarlKFI@cosmosui.org

-Shift-clicking an item in chat, AH or bags when at AH puts the name of the item in the search field.

Change Log:
v1.0
-Initial Release
v1.1
-TOC updated to 1800
-Now Compatible with WoW 1.8 and ondemand loading AuctionFrame
v1.2
-Shift-click now clears text before pasting item name and automaticly searches for the item
-Shift-alt-click to simply append the item name to the search text and not auto-search
v1.3
-TOC updated to 10900
-Added EngInventory compatibility
-Added AllInOneInventory compatibility
-Fixed shift-click bug before AH is loaded

]]--

AH_QuickSearch_ButtonsHooked = false;

function AH_QuickSearch_SetItemRef (link, text, button)
	if (strsub(link, 1, 6) ~= "player") and ( IsShiftKeyDown() ) and ( not ChatFrameEditBox:IsVisible() ) and ( BrowseName and BrowseName:IsVisible()) then
		local itemName = gsub(text, ".*%[(.*)%].*", "%1");
		if (IsAltKeyDown()) then
			BrowseName:SetText(BrowseName:GetText()..itemName);
		else
			BrowseName:SetText(itemName);
		end
		if ( StackSplitFrame:IsVisible() ) then
			StackSplitFrame:Hide();
		end
		BrowseName:SetFocus();
		if (not IsAltKeyDown()) then
			AuctionFrameBrowse_Search();
		end
	end
end

function AH_QuickSearch_ItemButton_OnClick(button, ignoreModifiers)
	if ( button == "LeftButton" ) and (not ignoreModifiers) and ( IsShiftKeyDown() ) and ( not ChatFrameEditBox:IsVisible() ) and ( BrowseName and BrowseName:IsVisible() ) and (GameTooltipTextLeft1:GetText()) then
		if (IsAltKeyDown()) then
			BrowseName:SetText(BrowseName:GetText()..GameTooltipTextLeft1:GetText());
		else
			BrowseName:SetText(GameTooltipTextLeft1:GetText());
		end
		if ( StackSplitFrame:IsVisible() ) then
			StackSplitFrame:Hide();
		end
		BrowseName:SetFocus();
		if (not IsAltKeyDown()) then
			AuctionFrameBrowse_Search();
		end
	end
end

function AH_QuickSearch_SetUpHooks()
	--Hook SetItemRef
	AH_QuickSearch_SetItemRef_orig = SetItemRef;
	SetItemRef = function(link, text, button) AH_QuickSearch_SetItemRef_orig(link, text, button); AH_QuickSearch_SetItemRef(link, text, button); end;

	--Hook ContainerFrameItemButton_OnClick
	AH_QuickSearch_ContainerFrameItemButton_OnClick_orig = ContainerFrameItemButton_OnClick;
	ContainerFrameItemButton_OnClick = function(button, ignoreModifiers) AH_QuickSearch_ContainerFrameItemButton_OnClick_orig(button, ignoreModifiers); AH_QuickSearch_ItemButton_OnClick(button, ignoreModifiers); end;
	
	if (AllInOneInventoryFrameItemButton_OnClick) then
		--Hook ContainerFrameItemButton_OnClick
		AH_QuickSearch_AllInOneInventoryFrameItemButton_OnClick_orig = AllInOneInventoryFrameItemButton_OnClick;
		AllInOneInventoryFrameItemButton_OnClick = function(button, ignoreModifiers) AH_QuickSearch_AllInOneInventoryFrameItemButton_OnClick_orig(button, ignoreModifiers); AH_QuickSearch_ItemButton_OnClick(button, ignoreModifiers); end;
	end
	
	if (EngInventory_ItemButton_OnClick) then
		--Hook ContainerFrameItemButton_OnClick
		AH_QuickSearch_EngInventory_ItemButton_OnClick_orig = EngInventory_ItemButton_OnClick;
		EngInventory_ItemButton_OnClick = function(button, ignoreModifiers) AH_QuickSearch_EngInventory_ItemButton_OnClick_orig(button, ignoreModifiers); AH_QuickSearch_ItemButton_OnClick(button, ignoreModifiers); end;
	end
	
	if (BrowseButton) then
		--Hook BrowseButtons
		for i=1, 8 do
			local frame = getglobal("BrowseButton"..i.."Item");
			local oldFunc = frame:GetScript("OnClick");
			frame:SetScript("OnClick", function() oldFunc(); AH_QuickSearch_ItemButton_OnClick(arg1); end);
		end
	end
	
	--Enlarge the Search Edit Box (Disabled)
	--BrowseName:SetPoint("TOPLEFT", "BrowseNameText", "BOTTOMLEFT", -50, -2);
	--BrowseName:SetWidth(200);
	AH_QuickSearch_ButtonsHooked = true;
end

if ( IsAddOnLoaded("Blizzard_AuctionUI") ) then
	--Hook Everything Now!
	AH_QuickSearch_SetUpHooks();
else
	--Hook the AuctionFrame_LoadUI to do the Hooks later
	AH_QuickSearch_AuctionFrame_LoadUI_orig = AuctionFrame_LoadUI;
	AuctionFrame_LoadUI = function()
		AH_QuickSearch_AuctionFrame_LoadUI_orig();
		if ( not AH_QuickSearch_ButtonsHooked ) then
			AH_QuickSearch_SetUpHooks();
		end
	end;
end
