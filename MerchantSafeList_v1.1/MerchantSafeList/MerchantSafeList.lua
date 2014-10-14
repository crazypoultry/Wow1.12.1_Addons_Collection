--[[
-------------------
MerchantSafeList addon

- based on ... Auto-Bag adopted by VincentGdG on November 12, 2005
- based on ... Madorin's Auto-Bag v0.81b
- based on ... MerchantSafe by Larry
- based on ... SmartDisenchant by SkaDemon
- based on ... AutoProfit by Jason Allen
- based on ... Colorcode taken from DisenchantPredictor by Gazmik Fizzwidget
-------------------

]]

MerchantSafeList_Loaded = nil;
MerchantSafeList_Click = 0;
MerchantSafeList_Cursor = nil;
MerchantSafeList_FullBags = nil;
MerchantSafeList_NumSaves = 0;
MerchantSafeList_Arrange_Selected = 0;
MerchantSafeList_Arrange_SelName = "";
MerchantSafeList_Events = { -- RegisterEvents(MerchantSafeList_Events);
	"ADDON_LOADED",
	"PLAYER_ENTERING_WORLD",
	"ITEM_LOCK_CHANGED",
	"UNIT_MODEL_CHANGED",
	"MERCHANT_SHOW",
	"MERCHANT_CLOSED",
	"MERCHANT_UPDATE",
}

MerchantSafeList_ContainerFrameItemButtonOnClick = { };

MerchantSafeList_ArrangeSortTemp = { };

MerchantSafeList_isMerchant = nil;
local MerchantSafeList_OriginalContainerFrameItemButton_OnClick;
local MerchantSafeList_ContainerFrameItemButton_OnClick;
local MerchantSafeList_PopupConfirmSell_BagBackup;
local MerchantSafeList_PopupConfirmSell_SlotBackup;

-- Create static popup
StaticPopupDialogs["MERCHANTSAFELIST"] = {
		text = TEXT(MerchantSafeList_SELL_ITEM),
		button1 = TEXT(ACCEPT),
		button2 = TEXT(CANCEL),
		OnAccept = function()
			MerchantSafeList_SellItem();
		end,
		showAlert = 1,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		interruptCinematic = 1
};

function MerchantSafeList_Msg(msg)
	DEFAULT_CHAT_FRAME:AddMessage("MerchantSafeList: " .. msg);
end

function MerchantSafeList_Error(msg)
	DEFAULT_CHAT_FRAME:AddMessage("MerchantSafeList: " .. msg);
	UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 0, 1, 2)
end

function MerchantSafeList_IsMatch(itemName, pattern, itemType, itemValue)
	-- !quest etc.
	if string.sub(pattern,1,1) == "!" then
		pattern = string.sub(pattern,2);
		if itemType == MerchantSafeList_SEARCHTYPES[pattern] then
			return true
		elseif pattern == itemValue then
			return true
		end
	-- *erz etc.
	elseif string.find(pattern,"%*") then
		rawpattern = "^" .. string.gsub(pattern,"%*",".*") .. "$";
		--MerchantSafeList_Msg("Pattern: " .. pattern);
		--MerchantSafeList_Msg("raw Pattern: " .. rawpattern);
		return string.find(strupper(itemName), strupper(rawpattern))
	else
		return (strupper(itemName) == strupper(pattern))
	end
end

function MerchantSafeList_AddArrange(name, bag)
	MerchantSafeList_Save.Arrange[name] = bag;
end

function MerchantSafeList_DelArrange(name)
	MerchantSafeList_Save.Arrange[name] = nil;
end

function MerchantSafeList_Command(msg)
	MerchantSafeList_Options:Show();
end

function MerchantSafeList_OnLoad()
	RegisterEvents(MerchantSafeList_Events);
	SlashCmdList["MERCHANTSAFELISTCMD"] = MerchantSafeList_Command;
	SLASH_MERCHANTSAFELISTCMD1 = "/msl";
	if not MerchantSafeList_Save then
		-- Initialize all
		MerchantSafeList_Save = { };
		MerchantSafeList_Save.Enable = nil;
		MerchantSafeList_Save.ArrangeQuality = "-1";
		MerchantSafeList_Save.Arrange = { };
	end
end

function MerchantSafeList_OnEvent(event, arg1)
	-- game loaded?
	if event == "PLAYER_ENTERING_WORLD" then
		this:UnregisterEvent("PLAYER_ENTERING_WORLD")
		MerchantSafeList_ContainerFrameItemButtonOnClick = ContainerFrameItemButton_OnClick;
		ContainerFrameItemButton_OnClick = MerchantSafeList_CursorCheck;

		MerchantSafeList_UpdateListBox();
		-- MyAddons addon loaded?

	elseif event == "ADDON_LOADED" then
		this:UnregisterEvent("ADDON_LOADED")
		local MyAddonDetails = 
		{
			name = "MerchantSafeList",
			version = MerchantSafeList_VERSION,
			releaseDate = MerchantSafeList_RELEASEDATE,
			category = MYADDONS_CATEGORY_INVENTORY,
			frame = "MerchantSafeList_Main",
			author = "",
			email = "",
			website = "",
			optionsframe = ""
		}

		local MyAddonHelp = {};
		MyAddonHelp[1] = MerchantSafeList_DESC1;
		MyAddonHelp[2] = MerchantSafeList_DESC2;
		if(myAddOnsFrame_Register) then
			myAddOnsFrame_Register(MyAddonDetails,MyAddonHelp);
		end

	elseif event == "UNIT_MODEL_CHANGED" and not MerchantSafeList_Loaded then
		if ( UnitName("player") ~= nil ) then
			if MerchantSafeList_Save.Enable then
				getglobal("MerchantSafeList_Options_Enable"):SetChecked(1);
			else
				getglobal("MerchantSafeList_Options_Enable"):SetChecked(0);
			end
			MerchantSafeList_UpdateListBox();
		end
		MerchantSafeList_Loaded = true;

	elseif event == "MERCHANT_SHOW" then
		-- Hook Blizzard Functions
		MerchantSafeList_isMerchant = true;
		MerchantSafeList_OriginalContainerFrameItemButton_OnClick = ContainerFrameItemButton_OnClick;
		ContainerFrameItemButton_OnClick = MerchantSafeList_PurchaseSlot;

	elseif event == "MERCHANT_CLOSED" then
		MerchantSafeList_isMerchant = nil;
		if (MerchantSafeList_OriginalContainerFrameItemButton_OnClick) then
			ContainerFrameItemButton_OnClick = MerchantSafeList_OriginalContainerFrameItemButton_OnClick;
			MerchantSafeList_OriginalContainerFrameItemButton_OnClick = nil;
		end
		MerchantSafeList_Options:Hide();

	elseif event == "MERCHANT_UPDATE" then
	end
end

function MerchantSafeList_CursorCheck( button, ignoreShift )
	if ( MerchantSafeList_Click ~= 0 ) then
		local bag = this:GetParent():GetID();
		local slot = this:GetID();
		local itemName = GetItemDataByLoc(bag,slot);
		if itemName then
			local bag = this:GetParent():GetID();
			local slot = this:GetID();
			local ItemLink = GetContainerItemLink(bag,slot);
			if MerchantSafeList_Click == 1 then
				MerchantSafeList_AddArrange(itemName, bag);
				MerchantSafeList_Msg("Added to list, " .. ItemLink);
			elseif MerchantSafeList_Click == 2 then
				MerchantSafeList_DelArrange(itemName);
				MerchantSafeList_Msg("Removed from list, " .. ItemLink);
			end
			MerchantSafeList_Arrange_Selected = 0;
			MerchantSafeList_Arrange_SelName = nil;
			MerchantSafeList_UpdateListBox();
			getglobal("MerchantSafeList_Arrange_Delete"):Disable();
			MerchantSafeList_Click = 0;
			SetCursor("POINT_CURSOR");
			MerchantSafeList_Cursor = nil;
		end
	else
		MerchantSafeList_ContainerFrameItemButtonOnClick( button, ignoreShift );
	end
end

--Code for getting the ItemData taken from MerchantSafe and SmartDisenchant by SkaDemon
function MerchantSafeList_PurchaseSlot(buttonPress, ignoreShift)

	--StaticPopupDialog
	if ( MerchantSafeList_Save.Enable and buttonPress == "RightButton" ) then
		if ( MerchantSafeList_Main:IsVisible() ) then
			local bag = this:GetParent():GetID();
			local slot = this:GetID();
			local ItemLink = GetContainerItemLink(bag,slot);
			local _,ItemCount,_,ItemQuality = GetContainerItemInfo(bag,slot);

			--name, _, _, _ = GetBuybackItemInfo(); -- not needed
			--BuybackItem(index); -- not needed

			if (ItemLink ~= nil) then
				isProtect = nil;

				-- Block quality level
				--Colorcode taken from DisenchantPredictor by Gazmik Fizzwidget
				local _,_,ItemColor,_ = string.find(ItemLink, ".c(%x+).H(item:%d+:%d+:%d+:%d+).h%[.-%].h.r");

				ItemQuality = -1;
				if (tonumber(MerchantSafeList_Save.ArrangeQuality) == -1) then -- block none
				else
					if (ItemColor == MerchantSafeList_QUALITY0) then
						ItemQuality = 0;
					elseif (ItemColor == MerchantSafeList_QUALITY1) then
						ItemQuality = 1;
					elseif (ItemColor == MerchantSafeList_QUALITY2) then
						ItemQuality = 2;
					elseif (ItemColor == MerchantSafeList_QUALITY3) then
						ItemQuality = 3;
					elseif (ItemColor == MerchantSafeList_QUALITY4) then
						ItemQuality = 4;
					elseif (ItemColor == MerchantSafeList_QUALITY5) then
						ItemQuality = 5;
					elseif (ItemColor == MerchantSafeList_QUALITY6) then
						ItemQuality = 6;
					end
				end
				--MerchantSafeList_Msg("item " .. ItemQuality); -- testing
				--MerchantSafeList_Msg("save " .. MerchantSafeList_Save.ArrangeQuality); -- testing
				if ( ItemQuality == -1 ) then
				elseif ( ItemQuality >= tonumber(MerchantSafeList_Save.ArrangeQuality) ) then
					-- protect all items equal or greater to quality level
					isProtect = true;
				end

				-- Scan database
				for key, value in MerchantSafeList_Save.Arrange do
					if ( string.find(strlower(ItemLink), strlower(key)) ) then -- exact match
						isProtect = true;
						break; -- exit loop

					else -- partial match
						local itemName, _, _, itemRarity, _, itemType, _, _, _, _, itemQuality = GetItemDataByLoc(bag,slot);
						if itemName then
							local itemValue = ItemValue(bag,slot);
							pattern = key;
							--MerchantSafeList_Msg("pattern " .. pattern); -- testing
							--MerchantSafeList_Msg("item " .. itemName); -- testing
							if MerchantSafeList_IsMatch(itemName,pattern,itemType,itemValue) then
								isProtect = true;
								break; -- exit loop
							end
						end
					end
				end

				if (isProtect and IsAltKeyDown()) then -- forced sell, ignore addon
					-- Popup verify
					-- Pass variables
                    MerchantSafeList_PopupConfirmSell_BagBackup = this:GetParent():GetID();
                    MerchantSafeList_PopupConfirmSell_SlotBackup = this:GetID();
                    StaticPopup_Show("MERCHANTSAFELIST");
					--MerchantSafeList_SellItem() will be run if accepted
					--rest of function should be ignored

				elseif ( isProtect ) then
					MerchantSafeList_Msg("Prevented from selling " .. ItemLink);

				else
					--MerchantSafeList_Msg("Sold " .. ItemLink); -- optional
					MerchantSafeList_OriginalContainerFrameItemButton_OnClick(buttonPress,ignoreShift);
					--MerchantSafeList_SellItem(); -- not used here
				end

			else
				MerchantSafeList_OriginalContainerFrameItemButton_OnClick(buttonPress,ignoreShift);
			end
		else
			MerchantSafeList_OriginalContainerFrameItemButton_OnClick(buttonPress,ignoreShift);
		end
	else
		MerchantSafeList_OriginalContainerFrameItemButton_OnClick(buttonPress,ignoreShift);
	end
end

--Code taken from MerchantSafe and AutoProfit by Jason Allen
function MerchantSafeList_SellItem()
	PickupContainerItem(MerchantSafeList_PopupConfirmSell_BagBackup, MerchantSafeList_PopupConfirmSell_SlotBackup);
	MerchantItemButton_OnClick("LeftButton");
end