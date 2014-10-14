--[[

WearMe
	Library for equipping, bagging and moving equipment using a dynamic cache.

By Karl Isenberg (AnduinLothar)
Edits for 1.12 live by Guillotine
Change Log:

v1.6
- Changed Backpack (0) and Bank (-1) to be of type "Bag"
- Keyring (-2) is now of type "Key"
v1.5
- Updated for SeaHooks v0.9
v1.4
- Increased number of bank bags to match 2.0
v1.3
- Updated for Lua 5.1
- Updated SeaHooks calls
v1.2
- Unequip now correctly clears the cursor when failing
- Added GetBagItemQuantity and GetBankItemQuantity
- Bagging functions now recognize the backpack who's subtype is "Miscellaneous"
- Added a SplitContainerItem hook for more thurough caching
v1.1
- Added BankCursorItem
- Added FindItem (inv/container/bank)
- Added ItemCanGoInBag (using stored itemIDs from Tekkub's PeriodicTable)
- Added GetItemIDFromItemString
- Added GetBagSubType (cached)
- Bank cache now updates on PLAYERBANKSLOTS_CHANGED
- Cursor Item cache now stores the correct bag slot
- FindXXXItem functions now fall back on name. FindXXXItemByID functions now do what the old versions did.
- BagCursorItem, BankCursorItem and ReBagContainerItem now take into account special bag types
- Recoded the Outfit code to only require a single pass for finding the items, storing the bag/slot information for use in WearOutfit.  This fixes a bug with equipping duplicate items in the same outfit.
v1.0
- Initial Release

	$Id: WearMe.lua 3705 2006-06-26 08:15:29Z karlkfi $
	$Rev: 3705 $
	$LastChangedBy: karlkfi $
	$Date: 2006-06-26 03:15:29 -0500 (Mon, 26 Jun 2006) $
	
--]]

local WEARME_NAME 			= "WearMe"
local WEARME_VERSION 		= 1.6
local WEARME_LAST_UPDATED	= "October 6, 2006"
local WEARME_AUTHOR 		= "AnduinLothar"
local WEARME_EMAIL			= "karlkfi@cosmosui.org"
local WEARME_WEBSITE		= "http://www.wowwiki.com/WearMe"

------------------------------------------------------------------------------
--[[ Embedded Sub-Library Load Algorithm ]]--
------------------------------------------------------------------------------

if (not WearMe) then
	WearMe = {};
end
local isBetterInstanceLoaded = ( WearMe.version and WearMe.version >= WEARME_VERSION );

if (not isBetterInstanceLoaded) then
	
	WearMe.version = WEARME_VERSION;
	
	------------------------------------------------------------------------------
	--[[ Globals ]]--
	------------------------------------------------------------------------------
	
	WearMe.DEBUG = false;
	
	--GetContainerItemLink item name strfind syntax
	WearMe.ITEM_NAME_FROM_LINK = "|h%[(.-)%]|h";
	WearMe.ITEM_UNIQUE_IDS_FROM_LINK = "|H(item:(%d-):(%d-).-(%d-):(%d-))|h%[(.-)%]|h";
	WearMe.ITEM_ID_FROM_STRING = "item:(%d-)";
	
	WearMe.DuelInventorySlots = {
		[11] = 12;
		[12] = 11;
		[13] = 14;
		[14] = 13;
		[16] = 17;
		[17] = 16;
	};
	
	WearMe.DuelInventoryLocations = {
		["INVTYPE_FINGER"] = 11;
		["INVTYPE_TRINKET"] = 13;
		["INVTYPE_WEAPON"] = 16;
	};
	
	WearMe.BankBags = { -1, 5, 6, 7, 8, 9, 10, 11 };
	
	WearMe.Containers = {
		[-2] = {};
		[-1] = {};
		[0] = {};
		[1] = {};
		[2] = {};
		[3] = {};
		[4] = {};
		[5] = {};
		[6] = {};
		[7] = {};
		[8] = {};
		[9] = {};
		[10] = {};
		[11] = {};
	};
	
	WearMe.Inventory = {};
	
	WearMe.CursorItem = {};
	
	WearMe.InventoryContainers = {};
	for i=1, 20 do
		WearMe.InventoryContainers[ContainerIDToInventoryID(i)] = i;
	end
	
	WearMe.MoveQueue = {};
	
	--[[ Inventory Slot Key:
	0 = ammo 
	1 = head 
	2 = neck 
	3 = shoulder 
	4 = shirt 
	5 = chest 
	6 = belt 
	7 = legs 
	8 = feet 
	9 = wrist 
	10 = gloves 
	11 = finger 1 
	12 = finger 2 
	13 = trinket 1 
	14 = trinket 2 
	15 = back 
	16 = main hand 
	17 = off hand 
	18 = ranged 
	19 = tabard
	]]--
	
	-- Tables taken from PeriodicTable by Tekkub
	-- Keys are from the GetItemInfo itemSubType return value as seen: http://www.wowwiki.com/ItemType
	-- For normal bags the sub type is simply "Bag"
	WearMe.SpecialBags = {
		["Enchanting Bag"] = "20725 11083 16204 11137 11176 10940 11174 10938 11135 11175 16202 11134 16203 10998 11082 10939 11084 14343 11139 10978 11177 14344 11138 11178";
		["Herb Bag"] = "3358 8839 13466 4625 13467 3821 785 13465 13468 2450 2452 3818 3355 3357 8838 3369 3820 8153 8836 13463 8845 8846 13464 2447 2449 765 2453 3819 3356 8831";
		["Soul Bag"] = "6265";
		["Ammo Pouch"] = "2516 2519 3033 3465 4960 5568 8067 8068 8069 10512 10513 11284 11630 13377 15997 19317";
		["Quiver"] = "2512 2515 3030 3464 9399 11285 12654 18042 19316";
	};
	
	WearMe.BagSubTypes = {};
	
	
	------------------------------------------------------------------------------
	--[[ Inventory Bag Item ID to Container ID Conversion ]]--
	------------------------------------------------------------------------------
	
	function WearMe.InventoryIDToContainerID(invSlot)
		-- Only works for bags (20-23, 64-70)
		if (invSlot) then
			return WearMe.InventoryContainers[invSlot];
		end
	end
		
	------------------------------------------------------------------------------
	--[[ Get Funcs ]]--
	------------------------------------------------------------------------------
	
	-- local itemString, itemID, enchant, suffix, bonus, name, bag, slot = WearMe.GetCursorItemInfo();
	function WearMe.GetCursorItemInfo()
		local item = WearMe.CursorItem;
		if (not item) then
			return;
		end
		return item.itemString, item.itemID, item.enchant, item.suffix, item.bonus, item.name, item.bag, (item.bagSlot or item.invSlot);
	end
	
	function WearMe.GetInventoryItemName(invSlot, forceCache)
		local item = WearMe.Inventory[invSlot];
		if (not forceCache and item and item.cached and item.name) then
			return item.name;
		else
			local linktext = GetInventoryItemLink("player", invSlot);
			if (linktext) then
				local _, _, itemName = strfind(linktext, WearMe.ITEM_NAME_FROM_LINK);
				WearMe.CacheInventoryItemName(invSlot, itemName);
				return itemName;
			end
		end
	end
	
	function WearMe.GetInventoryItemInfo(invSlot, forceCache)
		local item = WearMe.Inventory[invSlot];
		if (not forceCache and item and item.cached and item.itemID) then
			return item.itemString, item.itemID, item.enchant, item.suffix, item.bonus, item.name;
		else
			local linktext = GetInventoryItemLink("player", invSlot);
			if (linktext) then
				local _, _, itemString, itemID, permEnchant, suffix, extraItemInfo, itemName = strfind(linktext, WearMe.ITEM_UNIQUE_IDS_FROM_LINK);
				itemID = tonumber(itemID);
				permEnchant = tonumber(permEnchant);
				suffix = tonumber(suffix);
				extraItemInfo = tonumber(extraItemInfo);
				WearMe.CacheInventoryItem(invSlot, itemString, itemID, permEnchant, suffix, extraItemInfo, itemName);
				return itemString, itemID, permEnchant, suffix, extraItemInfo, itemName;
			end
		end
	end
	
	function WearMe.GetContainerItemName(bag, slot, forceCache)
		local item = WearMe.Containers[bag]
		if (item) then
			item = item[slot];
		end
		if (not forceCache and item and item.cached and item.name) then
			return item.name;
		else
			local linktext = GetContainerItemLink(bag, slot);
			if (linktext) then
				local _, _, itemName = strfind(linktext, WearMe.ITEM_NAME_FROM_LINK);
				WearMe.CacheContainerItemName(bag, slot, itemName);
				return itemName;
			end
		end
	end
	
	function WearMe.GetContainerItemInfo(bag, slot, forceCache)
		local item = WearMe.Containers[bag]
		if (item) then
			item = item[slot];
		end
		if (not forceCache and item and item.cached and item.itemID) then
			return item.itemString, item.itemID, item.enchant, item.suffix, item.bonus, item.name;
		else
			local linktext = GetContainerItemLink(bag, slot);
			if (linktext) then
				local _, _, itemString, itemID, permEnchant, suffix, extraItemInfo, itemName = strfind(linktext, WearMe.ITEM_UNIQUE_IDS_FROM_LINK);
				itemID = tonumber(itemID);
				permEnchant = tonumber(permEnchant);
				suffix = tonumber(suffix);
				extraItemInfo = tonumber(extraItemInfo);
				WearMe.CacheInventoryItem(bag, slot, itemString, itemID, permEnchant, suffix, extraItemInfo, itemName);
				return itemString, itemID, permEnchant, suffix, extraItemInfo, itemName;
			end
		end
	end
	
	function WearMe.GetBagSubType(bag)
		if (not WearMe.BagSubTypes or not WearMe.BagSubTypes.cached) then
			WearMe.CacheBagSubTypes();
		end
		return WearMe.BagSubTypes[bag];
	end
	
	function WearMe.GetItemIDFromItemString(itemString)
		local _, _, itemID = strfind(itemString, WearMe.ITEM_ID_FROM_STRING);
		if (itemID) then
			return itemID;
		end
	end
	
	------------------------------------------------------------------------------
	--[[ Special Bag ]]--
	------------------------------------------------------------------------------
	
	-- Doesn't take into acount space, only bag type
	function WearMe.ItemCanGoInBag(itemID, bag)
		local bagType = WearMe.GetBagSubType(bag);
		if (not bagType) then
			return false;
		end
		if (bagType == "Bag") then
			return true;
		end
		local bagItems = WearMe.SpecialBags[bagType];
		if (type(bagItems) == "string") then
			local tabledBagItems = {};
			-- Using string.find instead of string.gfind/gmatch to avoid garbage generation
			local mstart, mend, value = strfind(bagItems, " ");
		   	while (value) do
				tabledBagItems[value] = true;
				mstart = mend + 1;
				mstart, mend, value = strfind(bagItems, " ", mstart);
		   	end
		   	WearMe.SpecialBags[bagType] = tabledBagItems;
			bagItems = WearMe.SpecialBags[bagType];
		elseif (type(bagItems) ~= "table") then
			return false;
		end
		
		if (type(itemID) == "string") then
			itemID = WearMe.GetItemIDFromItemString(itemID)
		end
		return (bagItems[itemID] or false);
	end

	
	------------------------------------------------------------------------------
	--[[ Find By Name ]]--
	------------------------------------------------------------------------------
	
	function WearMe.FindInventoryItemByName(targetItemName, startSlot)
		-- Find the named item on the character's inventory (head slot, hand slot, etc -- not bags)
		if (not startSlot) then
			startSlot = 0;
		end
		
		for i = startSlot, 19 do
			if (targetItemName == WearMe.GetInventoryItemName(i)) then
				return i;
			end
		end
	end
	
	function WearMe.FindBagByName(targetBagName)
		-- For finding the bag item name, not the slot name
		-- Returns an Inventory ID, use InventoryIDToContainerID if you need the Container ID
		for i = 20, 23 do
			if (targetBagName == WearMe.GetInventoryItemName(i)) then
				return i;
			end
		end
	end
	
	function WearMe.FindBankBagByName(targetBagName)
		-- For finding the bag item name, not the slot name
		-- Only usable at the bank
		-- Returns an Inventory ID, use InventoryIDToContainerID if you need the Container ID
		for i = 64, 70 do
			if (targetBagName == WearMe.GetInventoryItemName(i)) then
				return i;
			end
		end
	end
	
	function WearMe.FindContainerItemByName(targetItemName, startBag, startSlot)
		if (not startBag) then
			startBag = 0;
		end
		
		if (not startSlot) then
			startSlot = 1;
		end
		
		for bag = startBag, 4 do
			for slot = startSlot, GetContainerNumSlots(bag) do
				if (targetItemName == WearMe.GetContainerItemName(bag, slot)) then
					return bag, slot;
				end
			end
			startSlot = 1;
		end
	end
	
	function WearMe.FindKeyByName(targetItemName)
		local bag = -2;
		for slot = 1, GetContainerNumSlots(bag) do
			if (targetItemName == WearMe.GetContainerItemName(bag, slot)) then
				return bag, slot;
			end
		end
	end
	
	function WearMe.FindBankItemByName(targetItemName, startBag, startSlot)
		-- Only usable at the bank
		if (startBag or startSlot) then
			for i, bag in ipairs(WearMe.BankBags) do
				if (startBag and startBag == bag) then
					startBag = nil;
				end
				if (not startBag) then
					for slot = startSlot, GetContainerNumSlots(bag) do
						if (targetItemName == WearMe.GetContainerItemName(bag, slot)) then
							return bag, slot;
						end
					end
					startSlot = 1;
				end
			end
		else
			for i, bag in ipairs(WearMe.BankBags) do
				for slot = 1, GetContainerNumSlots(bag) do
					if (targetItemName == WearMe.GetContainerItemName(bag, slot)) then
						return bag, slot;
					end
				end
			end
		end
	end
	
	
	------------------------------------------------------------------------------
	--[[ Find By ID ]]--
	-- itemID can be an itemID or "itemString" (ex: 12345 or "item:12345:0:0:0")
	------------------------------------------------------------------------------
	
	-- Find the named item on the character's inventory (head slot, hand slot, etc -- not bags)
	function WearMe.FindInventoryItemByID(targetItemID, startSlot)
		local itemString, itemID, permEnchant, suffix, extraItemInfo;
		if (not startSlot) then
			startSlot = 0;
		end
		
		for i = startSlot, 19 do
			itemString, itemID = WearMe.GetInventoryItemInfo(i);
			if (targetItemID == itemString or targetItemID == itemID) then
				return i;
			end
		end
	end
	
	function WearMe.FindBagByID(targetItemID)
		-- For finding the bag item name, not the slot name
		-- Returns an Inventory ID, use InventoryIDToContainerID if you need the Container ID
		local itemString, itemID, permEnchant, suffix, extraItemInfo;
		for i = 20, 23 do
			itemString, itemID = WearMe.GetInventoryItemInfo(i);
			if (targetItemID == itemString or targetItemID == itemID) then
				return i;
			end
		end
	end
	
	function WearMe.FindBankBagByID(targetItemID)
		-- For finding the bag item name, not the slot name
		-- Only usable at the bank
		-- Returns an Inventory ID, use InventoryIDToContainerID if you need the Container ID
		local itemString, itemID, permEnchant, suffix, extraItemInfo;
		for i = 64, 69 do
			itemString, itemID, permEnchant, suffix, extraItemInfo = WearMe.GetInventoryItemInfo(i);
			if (targetItemID == itemString or targetItemID == itemID) then
				return i;
			end
		end
	end
	
	function WearMe.FindContainerItemByID(targetItemID, startBag, startSlot)
		local itemString, itemID, permEnchant, suffix, extraItemInfo;
		if (not startBag) then
			startBag = 0;
		end
		
		if (not startSlot) then
			startSlot = 1;
		end
		
		for bag = startBag, 4 do
			for slot = startSlot, GetContainerNumSlots(bag) do
				itemString, itemID, permEnchant, suffix, extraItemInfo = WearMe.GetContainerItemInfo(bag, slot);
				if (targetItemID == itemString or targetItemID == itemID) then
					return bag, slot;
				end
			end
			startSlot = 1;
		end
	end
	
	function WearMe.FindKeyByID(targetItemID)
		local itemString, itemID, permEnchant, suffix, extraItemInfo;
		local bag = -2;
		for slot = 1, GetContainerNumSlots(bag) do
			itemString, itemID, permEnchant, suffix, extraItemInfo = WearMe.GetContainerItemInfo(bag, slot);
			if (targetItemID == itemString or targetItemID == itemID) then
				return bag, slot;
			end
		end
	end
	
	function WearMe.FindBankItemByID(targetItemID, startBag, startSlot)
		-- Only usable at the bank
		local itemString, itemID, permEnchant, suffix, extraItemInfo;
		if (startBag or startSlot) then
			for i, bag in ipairs(WearMe.BankBags) do
				if (startBag and startBag == bag) then
					startBag = nil;
				end
				if (not startBag) then
					for slot = startSlot, GetContainerNumSlots(bag) do
						itemString, itemID, permEnchant, suffix, extraItemInfo = WearMe.GetContainerItemInfo(bag, slot);
						if (targetItemID == itemString or targetItemID == itemID) then
							return bag, slot;
						end
					end
					startSlot = 1;
				end
			end
		else
			for i, bag in ipairs(WearMe.BankBags) do
				for slot = 1, GetContainerNumSlots(bag) do
					itemString, itemID, permEnchant, suffix, extraItemInfo = WearMe.GetContainerItemInfo(bag, slot);
					if (targetItemID == itemString or targetItemID == itemID) then
						return bag, slot;
					end
				end
			end
		end
	end
	
	
	------------------------------------------------------------------------------
	--[[ Find By ID or Name Anywhere ]]--
	------------------------------------------------------------------------------
	
	-- itemName is optional
	-- if (bag) then (Is  Bag/Bank Item) elseif (slot) (Is Inventroy Item) end
	function WearMe.FindItem(itemID, itemName)
		local bag, slot;
		slot = WearMe.FindInventoryItemByID(itemID);
		if (not slot) then
			bag, slot = WearMe.FindContainerItemByID(itemID);
			if (not bag) then
				bag, slot = WearMe.FindBankItemByID(itemID);
				if (not bag and itemName) then
					slot = WearMe.FindInventoryItemByName(itemName);
					if (not slot) then
						bag, slot = WearMe.FindContainerItemByName(itemName);
						if (not bag) then
							bag, slot = WearMe.FindBankItemByName(itemName)
							if (not bag) then
								return;
							end
						end
					end
				end
			end
		end
		return bag, slot;
	end
	
	function WearMe.FindContainerItem(itemID, itemName, startBag, startSlot)
		local bag, slot;
		bag, slot = WearMe.FindContainerItemByID(itemID, startBag, startSlot);
		if (itemName and not bag) then
			bag, slot = WearMe.FindContainerItemByName(itemName, startBag, startSlot);
		end
		return bag, slot;
	end
	
	function WearMe.FindBankItem(itemID, itemName, startBag, startSlot)
		local bag, slot;
		bag, slot = WearMe.FindBankItemByID(itemID, startBag, startSlot);
		if (itemName and not bag) then
			bag, slot = WearMe.FindBankItemByName(itemName, startBag, startSlot);
		end
		return bag, slot;
	end
	
	function WearMe.FindInventoryItem(itemID, itemName, startSlot)
		local slot;
		slot = WearMe.FindInventoryItemByID(itemID, startSlot);
		if (itemName and not slot) then
			slot = WearMe.FindInventoryItemByName(itemName, startSlot);
		end
		return slot;
	end

	
	------------------------------------------------------------------------------
	--[[ Find By ID or Name ]]--
	------------------------------------------------------------------------------
	
	-- Find the item on the character's inventory or bags
	function WearMe.PlayerHasItem(itemID, itemName)
		local invSlot, bag;
		if (itemID) then
			-- Check inventory
			invSlot = WearMe.FindInventoryItemByID(itemID);
			if (invSlot) then
				-- Item equipped
				return true;
			else
				-- Check bags
				bag = WearMe.FindContainerItemByID(itemID);
				if (bag) then
					-- Item in bag
					return true;
				end
			end
		end
		if (itemName) then
			-- Check inventory
			invSlot = WearMe.FindInventoryItemByName(itemName);
			if (invSlot) then
				-- Item equipped
				return true;
			else
				-- Check bag slots
				bag = WearMe.FindContainerItemByName(itemName);
				if (bag) then
					-- Item in bag
					return true;
				end
			end
		end
		return false;
	end
	
	
	function WearMe.PlayerHasInventoryItem(itemID, itemName)
		local invSlot;
		if (itemID) then
			-- Check inventory
			invSlot = WearMe.FindInventoryItemByID(itemID);
			if (invSlot) then
				-- Item equipped
				return true;
			end
		end
		if (itemName) then
			-- Check inventory
			invSlot = WearMe.FindInventoryItemByName(itemName);
			if (invSlot) then
				-- Item equipped
				return true;
			end
		end
		return false;
	end
	
	
	function WearMe.PlayerHasContainerItem(itemID, itemName)
		local bag;
		if (itemID) then
			-- Check inventory
			bag = WearMe.FindContainerItemByID(itemID);
			if (bag) then
				-- Item equipped
				return true;
			end
		end
		if (itemName) then
			-- Check inventory
			bag = WearMe.FindContainerItemByName(itemName);
			if (bag) then
				-- Item equipped
				return true;
			end
		end
		return false;
	end
	
	---------------------------------------------------------------------------------
	-- Put the item on the cursor into a free bag slot
	---------------------------------------------------------------------------------
	
	--Ignores Special Bags
	function WearMe.BagCursorItem(backwards, specialBagType)
		if (CursorHasItem()) then
			local bagSubType;
			local bags = {};
			
			if (backwards) then
				if (specialBagType) then
					for bag = NUM_BAG_FRAMES, 1, -1 do
						if (specialBagType == WearMe.GetBagSubType(bag)) then
							tinsert(bags, bag);
						end
					end
				end
				for bag = NUM_BAG_FRAMES, 0, -1 do
					bagSubType = WearMe.GetBagSubType(bag);
					if (bagSubType and bagSubType == "Bag") then
						tinsert(bags, bag);
					end
				end
			else
				if (specialBagType) then
					for bag = 1, NUM_BAG_FRAMES do
						if (specialBagType == WearMe.GetBagSubType(bag)) then
							tinsert(bags, bag);
						end
					end
				end
				for bag = 0, NUM_BAG_FRAMES do
					bagSubType = WearMe.GetBagSubType(bag);
					if (bagSubType and bagSubType == "Bag") then
						tinsert(bags, bag);
					end
				end
			end
			
			for i, bag in ipairs(bags) do
				for slot = (backwards and GetContainerNumSlots(bag) or 1), (backwards and 1 or GetContainerNumSlots(bag)), (backwards and -1 or 1) do
					if (not WearMe.ContainerSlotInUse(bag, slot)) then
						PickupContainerItem(bag, slot);
						return bag, slot;
					end
				end
			end
		end
	end
	
	---------------------------------------------------------------------------------
	-- Put the item on the cursor into a free bank slot
	---------------------------------------------------------------------------------
	
	--Ignores Special Bags
	function WearMe.BankCursorItem(backwards, specialBagType)
		if (CursorHasItem()) then
			local bag, bagSubType;
			local bags = {};
			local numBags = getn(WearMe.BankBags);
			
			if (backwards) then
				if (specialBagType) then
					for bagIndex = numBags, 2, -1 do
						bag = WearMe.BankBags[bagIndex];
						if (specialBagType == WearMe.GetBagSubType(bag)) then
							tinsert(bags, bag);
						end
					end
				end
				for bagIndex = numBags, 1, -1 do
					bag = WearMe.BankBags[bagIndex];
					bagSubType = WearMe.GetBagSubType(bag);
					if (bagSubType and bagSubType == "Bag") then
						tinsert(bags, bag);
					end
				end
			else
				if (specialBagType) then
					for bagIndex = 2, numBags do
						bag = WearMe.BankBags[bagIndex];
						if (specialBagType == WearMe.GetBagSubType(bag)) then
							tinsert(bags, bag);
						end
					end
				end
				for bagIndex = 1, numBags do
					bag = WearMe.BankBags[bagIndex];
					bagSubType = WearMe.GetBagSubType(bag);
					if (bagSubType and bagSubType == "Bag") then
						tinsert(bags, bag);
					end
				end
			end
			
			for i, bag in ipairs(bags) do
				for slot = (backwards and GetContainerNumSlots(bag) or 1), (backwards and 1 or GetContainerNumSlots(bag)), (backwards and -1 or 1) do
					if (not WearMe.ContainerSlotInUse(bag, slot)) then
						PickupContainerItem(bag, slot);
						return bag, slot;
					end
				end
			end
		end
	end
	
	
	---------------------------------------------------------------------------------
	-- Move an item to the front most availible bag (or furthest back)
	---------------------------------------------------------------------------------
	
	function WearMe.ReBagContainerItem(itemBag, itemSlot, backwards, specialBagType)
		local bagSubType;
		local bags = {};
		
		if (backwards) then
			if (specialBagType) then
				for bag = NUM_BAG_FRAMES, itemBag+1, -1 do
					if (specialBagType == WearMe.GetBagSubType(bag)) then
						tinsert(bags, bag);
					end
				end
			end
			for bag = NUM_BAG_FRAMES, itemBag+1, -1 do
				bagSubType = WearMe.GetBagSubType(bag);
				if (bagSubType and bagSubType == "Bag") then
					tinsert(bags, bag);
				end
			end
		else
			if (specialBagType) then
				for bag = (itemBag >= 1 and itemBag or 1), NUM_BAG_FRAMES do
					if (specialBagType == WearMe.GetBagSubType(bag)) then
						tinsert(bags, bag);
					end
				end
			end
			for bag = itemBag-1, NUM_BAG_FRAMES do
				bagSubType = WearMe.GetBagSubType(bag);
				if (bagSubType and bagSubType == "Bag") then
					tinsert(bags, bag);
				end
			end
		end
		
		for i, bag in ipairs(bags) do
			for slot = (backwards and GetContainerNumSlots(bag) or 1), (backwards and 1 or GetContainerNumSlots(bag)), (backwards and -1 or 1) do
				if (not WearMe.ContainerSlotInUse(bag, slot)) then
					PickupContainerItem(itemBag, itemSlot);
					if (not CursorHasItem()) then
						return;
					end
					PickupContainerItem(bag, slot);
					return bag, slot;
				end
			end
		end
	end
	
	
	function WearMe.ReBagContainerItemByName(itemName, backwards)
		local bag, slot = WearMe.FindContainerItemByName(itemName);
		if (bag) then
			return WearMe.ReBagContainerItem(bag, slot, backwards);
		end
	end
	
	function WearMe.ReBagContainerItemByID(itemID, backwards)
		local bag, slot = WearMe.FindContainerItemByID(itemID);
		if (bag) then
			return WearMe.ReBagContainerItem(bag, slot, backwards);
		end
	end
	
	
	---------------------------------------------------------------------------------
	-- Equiping
	---------------------------------------------------------------------------------
	-- Event error if there's enough bag slots when equipping a 2h from 2 1h
	-- secondarySlot is ignored if it's not a 2 slotted item type
	-- Event error if you try to equip a main hand weapon to the secondarySlot
	
	--WearMe.CursorItem.itemString
	
	-- itemID can be an itemID or "itemString" (ex: 12345 or "item:12345:0:0:0")
	function WearMe.Equip(targetItemID, secondarySlot)
		-- if we're already holding something, bail
		if (CursorHasItem()) then
			return false;
		end
		
		local _, _, _, _, _, _, _, itemEquipLoc = GetItemInfo(targetItemID);
		
		local invSlot = WearMe.DuelInventoryLocations[itemEquipLoc];
		if (invSlot) then
			local altSlot = invSlot + 1;
			-- Check if it's already equipped and possibly in an alternate spot
			local itemString, itemID = WearMe.GetInventoryItemInfo(invSlot);
			if (itemString) and (itemString == targetItemID or itemID == targetItemID) then
				if (not secondarySlot) then
					return true;
				else
					PickupInventoryItem(invSlot);
					EquipCursorItem(altSlot);
					return true;
				end
			end
			itemString, itemID = WearMe.GetInventoryItemInfo(altSlot);
			if (itemString) and (itemString == targetItemID or itemID == targetItemID) then
				if (secondarySlot) then
					return true;
				else
					PickupInventoryItem(altSlot);
					EquipCursorItem(invSlot);
					return true;
				end
			end
		end
		
		-- Check non-duplicate inventory slots (duplicate slots will never return possitive)
		invSlot = WearMe.FindInventoryItemByID(targetItemID);
		if (invSlot) then
			-- Item already equipped
			return true;
		else
			-- Check bag slots
			local bag, bagSlot = WearMe.FindContainerItemByID(targetItemID);
			if (not bag) then
				-- Item Name not found in inventory or bag
				return false;
			end
			local itemString = WearMe.GetContainerItemInfo(bag, bagSlot);
			PickupContainerItem(bag, bagSlot);
		end
		
		if (not CursorHasItem()) then
			return false;
		end
		
		if (secondarySlot) then
			if (itemEquipLoc == "INVTYPE_FINGER") then
				EquipCursorItem(12);
				return true;
			elseif (itemEquipLoc == "INVTYPE_TRINKET") then
				EquipCursorItem(14);
				return true;
			elseif (itemEquipLoc == "INVTYPE_WEAPON" or itemEquipLoc == "INVTYPE_SHIELD" or itemEquipLoc == "INVTYPE_WEAPONOFFHAND" or itemEquipLoc == "INVTYPE_HOLDABLE") then
				EquipCursorItem(17);
				return true;
			end
		end
		
		AutoEquipCursorItem();
		return true;
	end
	
	function WearMe.EquipByName(targetItemName, secondarySlot)
		-- if we're already holding something, bail
		if (CursorHasItem()) then
			return false;
		end
		
		-- Check if it's already equipped and possibly in an alternate spot
		local _, itemName;
		for invSlot, altSlot in pairs(WearMe.DuelInventorySlots) do
			itemName = WearMe.GetInventoryItemName(invSlot);
			if (itemName and itemName == targetItemName) then
				if (secondarySlot and altSlot < invSlot) or (not secondarySlot and altSlot > invSlot) then
					return true;
				else
					PickupInventoryItem(invSlot);
					EquipCursorItem(altSlot);
					return true;
				end
			end
		end
		
		-- Check non-duplicate inventory slots (duplicate slots have already been handled)
		local invSlot = WearMe.FindInventoryItemByName(targetItemName);
		if (invSlot) then
			-- Item already equipped
			return true;
		else
			-- Check bag slots
			local bag, bagSlot = WearMe.FindContainerItemByName(targetItemName);
			if (not bag) then
				-- Item Name not found in inventory or bag
				return false;
			end
			local _, _, locked = GetContainerItemInfo(bag, bagSlot);
			if (locked) then
				bag, bagSlot = WearMe.FindContainerItemByName(targetItemName);
				if (not bag) then
					-- Item Name was only found once in the bags, but it was locked (in transit)
					return false;
				end
			end
			PickupContainerItem(bag, bagSlot);
		end
		
		if (not CursorHasItem()) then
			return false;
		end
		
		if (secondarySlot) then
			local _, _, _, _, _, _, _, itemEquipLoc = GetItemInfo(WearMe.CursorItem.itemString);
			if (itemEquipLoc == "INVTYPE_FINGER") then
				EquipCursorItem(12);
				return true;
			elseif (itemEquipLoc == "INVTYPE_TRINKET") then
				EquipCursorItem(14);
				return true;
			elseif (itemEquipLoc == "INVTYPE_WEAPON" or itemEquipLoc == "INVTYPE_SHIELD" or itemEquipLoc == "INVTYPE_WEAPONOFFHAND" or itemEquipLoc == "INVTYPE_HOLDABLE") then
				EquipCursorItem(17);
				return true;
			end
		end
		
		AutoEquipCursorItem();
		return true;
	end
	
	function WearMe.EquipContainerItem(fromBag, fromSlot, toSlot)
		-- if we're already holding something, bail
		if (CursorHasItem()) then
			return false;
		end
		
		PickupContainerItem(fromBag, fromSlot);
		if (not CursorHasItem()) then
			return false;
		end
		
		EquipCursorItem(toSlot);
		return true;
	end
	
	function WearMe.EquipInventoryItem(fromSlot, toSlot)
		-- if we're already holding something, bail
		if (CursorHasItem()) then
			return false;
		end
		
		-- Check if it's already equipped in the right place
		if (fromSlot == toSlot) then
			return true;
		end
		
		-- Equip it in the alternate slot
		local altSlot = WearMe.DuelInventorySlots[fromSlot];
		if (altSlot and altSlot == toSlot) then
			PickupInventoryItem(fromSlot);
			if (not CursorHasItem()) then
				return false;
			end
			EquipCursorItem(toSlot);
			return true;
		end
		
		return false;
	end
	
	
	---------------------------------------------------------------------------------
	-- Unequiping
	---------------------------------------------------------------------------------
	
	function WearMe.Unequip(invSlot, backwards)
		local texture = GetInventoryItemTexture("player", invSlot);
		if (texture) then
			PickupInventoryItem(invSlot);
			if (not WearMe.BagCursorItem(backwards)) then
				ClearCursor();
				return false;
			end
		end
		return true;
	end
	
	
	---------------------------------------------------------------------------------
	-- Slot Use
	---------------------------------------------------------------------------------
	
	function WearMe.InventorySlotInUse(invSlot, forceCache)
		local item = WearMe.Inventory[invSlot];
		if (not forceCache and item and item.cached) then
			if (item.name) then
				return true;
			end
		else
			if (WearMe.GetInventoryItemInfo(invSlot, true)) then
				return true;
			end
		end
	end
	
	function WearMe.ContainerSlotInUse(bag, slot, forceCache)
		if (not WearMe.Containers[bag]) then
			WearMe.Containers[bag] = {};
		end
		local item = WearMe.Containers[bag][slot];
		if (not forceCache and item and item.cached) then
			if (item.name) then
				return true;
			end
		else
			if (WearMe.GetContainerItemInfo(bag, slot, true)) then
				return true;
			end
		end
	end
	
	---------------------------------------------------------------------------------
	-- Empty Slots
	---------------------------------------------------------------------------------
	
	function WearMe.GetNumEmptyContainerSlots(bag, forceCache)
		local bag, item;
		local numSlots = 0;
		for bagNum=0, NUM_BAG_FRAMES do
			bag = WearMe.Containers[bagNum];
			if (not bag) then
				WearMe.Containers[bagNum] = {};
				bag = WearMe.Containers[bagNum];
			end
			for bagSlot = 1, GetContainerNumSlots(bagNum) do
				item = bag[bagSlot];
				if (not forceCache and item and item.cached) then
					if (not item.name) then
						numSlots = numSlots + 1;
					end
				else
					if (not WearMe.GetContainerItemInfo(bagNum, bagSlot, true)) then
						numSlots = numSlots + 1;
					end
				end
			end
		end
		return numSlots;
	end
	
	---------------------------------------------------------------------------------
	-- Container Item Quantity
	---------------------------------------------------------------------------------
	
	function WearMe.GetBagItemQuantity(itemID, itemName)
		return WearMe.GetContainerItemQuantity(WearMe.FindContainerItem, itemID, itemName);
	end
	
	function WearMe.GetBankItemQuantity(itemID, itemName)
		return WearMe.GetContainerItemQuantity(WearMe.FindBankItem, itemID, itemName);
	end
	
	function WearMe.GetContainerItemQuantity(findFunc, itemID, itemName)
		if (not itemID and not itemName) then
			return;
		end
		local _, count
		local total = 0;
		local bag, slot = findFunc(itemID, itemName);
		while (bag) do
			_, count = GetContainerItemInfo(bag, slot);
			if (count) then
				total = total + count;
			end
			bag, slot = findFunc(itemID, itemName, bag, slot+1);
		end
		return total;
	end
	
	
	---------------------------------------------------------------------------------
	--[[ Optimized Outfit Swapping ]]--
	-- Only swaps what needs to be swapped.
	-- Swaps, even if it's in another slot.
	-- Moves unequipped offhands, trinkets and rings to the back most bag (if swapping in a two hand or moving an equipped item to its alternate slot).
	-- Checks for id first. If that id is not found it will check for the name. This lets you prefer items with enchants or suffixes.
	-- Allows you to specify in any order.
	-- Multiple registers for the same slot will use the most recent.
	-- Outfit is preserved until the next init, so you can WearOutfit later without reregistering.
	-- If there is not enough space in your bags or the item is not found, RegisterToEquip returns false.
	--[[
	EX:
	WearMe.InitOutfit();
	WearMe.RegisterToEquip(16, "item:18822:2646:0:0", "Obsidian Edged Blade");	-- Equip OEB w/ +25 agil (by itemString) or OEB (by name)
	WearMe.RegisterToEquip(11, 19325);		-- Equip Ring 1 by id
	WearMe.RegisterToEquip(12, 19898);		-- Equip Ring 2 by id
	WearMe.RegisterToEquip(19);				-- Unequip Tabard
	WearMe.WearOutfit();
	]]--
	---------------------------------------------------------------------------------
	
	WearMe.OutfitItems = {};
	for i=0, 19 do
		WearMe.OutfitItems[i] = {};
	end
	WearMe.OutfitItems.reqBagSlots = 0;
	
	
	function WearMe.InitOutfit()
		local item;
		for i=0, 19 do
			item = WearMe.OutfitItems[i];
			if (not item) then
				WearMe.OutfitItems[i] = {};
				item = WearMe.OutfitItems[i];
			end
			item.bag = nil;
			item.slot = nil;
			item.twohand = nil;
			item.specified = nil;
		end
		WearMe.OutfitItems.reqBagSlots = 0;
	end
	
	-- startInvSlot, startBag, startBagSlot are optional, mainly used for recursion
	-- You can provide targetItemID or targetItemName or both. Providing neither will unequip whatever's in the targetInvSlot.
	function WearMe.RegisterToEquip(targetInvSlot, targetItemID, targetItemName, startInvSlot, startBag, startBagSlot)
        local item = WearMe.OutfitItems[targetInvSlot];
		local bag, slot
		
		if (not targetItemID and not targetItemName) then
			-- Make sure there's enough room to unequip
			if (WearMe.InventorySlotInUse(targetInvSlot)) then
				if (WearMe.GetNumEmptyContainerSlots() <= WearMe.OutfitItems.reqBagSlots) then
					return false;
				end
			end
			WearMe.OutfitItems.reqBagSlots = WearMe.OutfitItems.reqBagSlots + 1;
			item.specified = true;
			return true;
		end
		
		if (targetItemID) then
			slot = WearMe.FindInventoryItemByID(targetItemID, startInvSlot);
			if (slot) then
				if (slot == targetInvSlot) then
					return true;
				end
				item.slot = slot
				item.specified = true;
			else
				bag, slot = WearMe.FindContainerItemByID(targetItemID, startBag, startBagSlot);
				if (bag) then
					item.bag = bag
					item.slot = slot
					item.specified = true;
				end
			end
		end
		
		-- If both id and name were suplied, but the item was not found by that id, try by name
		if (targetItemName and not item.specified) then
			slot = WearMe.FindInventoryItemByName(targetItemName, startInvSlot)
			if (slot) then
				if (slot == targetInvSlot) then
					return true;
				end
				item.slot = slot
				item.specified = true;
			else
				bag, slot = WearMe.FindContainerItemByName(targetItemName, startBag, startBagSlot);
				if (bag) then
					item.bag = bag
					item.slot = slot
					item.specified = true;
				end
			end
		end
		
		if (not item.specified) then
			return false;
		end
		
		-- If you're trying to equip two of the same item make sure you actually have two
		local altSlot = WearMe.DuelInventorySlots[targetInvSlot];
		if (altSlot) then
			local altItem = WearMe.OutfitItems[altSlot];
			if (altItem and altItem.specified) then
				if (bag and altItem.bag == bag and slot and altItem.slot == slot) then
					item.bag = nil;
					item.slot = nil;
					item.specified = nil;
					return WearMe.RegisterToEquip(targetInvSlot, targetItemID, targetItemName, nil, bag, slot+1);
				elseif (not bag and not altItem.bag and slot and altItem.slot == slot) then
					item.bag = nil;
					item.slot = nil;
					item.specified = nil;
					return WearMe.RegisterToEquip(targetInvSlot, targetItemID, targetItemName, slot+1);
				end
			end
		end
		
		if (targetInvSlot == 16) then	-- Main Hand
			if (not bag and slot) then
				local itemString = WearMe.GetInventoryItemInfo(slot);
				local _, _, _, _, _, _, _, equipLoc = GetItemInfo(itemString);
				if (equipLoc == "INVTYPE_2HWEAPON") then
					item.twohand = true;
				end
			elseif (bag and slot) then
				local itemString = WearMe.GetContainerItemInfo(bag, slot);
				local _, _, _, _, _, _, _, equipLoc = GetItemInfo(itemString);
				if (equipLoc == "INVTYPE_2HWEAPON") then
					item.twohand = true;
				end
			end
		end
		
		return true;
	end
	
	
	function WearMe.WearOutfit()
		local outfit = WearMe.OutfitItems;
		
		-- Rings: 11, 12
		-- Trinkets: 13, 14
		-- Weapons: 16, 17
		local _, itemString, itemID, itemName, altItemString, altItemID, altItemName;
		for invSlot, altSlot in pairs(WearMe.DuelInventorySlots) do
			
			-- Ignore secondary slots (handle them together on the primary slot)
			if (invSlot < altSlot) then
			
				if (invSlot == 16 and outfit[invSlot].twohand) then
					WearMe.WearItem(outfit[invSlot], invSlot);
					altItemString, altItemID, _, _, _, altItemName = WearMe.GetInventoryItemInfo(altSlot);
					if (altItemString) then
						WearMe.QueueItemForMoving(altItemString);
					end
						
				elseif (outfit[invSlot].specified and outfit[altSlot].specified and WearMe.InventorySlotInUse(invSlot) and WearMe.InventorySlotInUse(altSlot)) then
					
					itemString, itemID, _, _, _, itemName = WearMe.GetInventoryItemInfo(invSlot);
					altItemString, altItemID, _, _, _, altItemName = WearMe.GetInventoryItemInfo(altSlot);
					
					if (not itemString or not altItemString) then
						WearMe.WearItem(outfit[invSlot], invSlot);
						WearMe.WearItem(outfit[altSlot], altSlot);
						
					elseif (not outfit[altSlot].bag and not outfit[invSlot].bag and outfit[altSlot].slot == invSlot and outfit[invSlot].slot == altSlot) then
						-- Both equipped, just in the wrong slots
						PickupInventoryItem(invSlot);
						EquipCursorItem(altSlot);
						
					elseif (not outfit[altSlot].bag and outfit[altSlot].slot == invSlot) then
						-- Primary slot item needs to go into the secondary slot
						-- Put secondary slot item in bag
						WearMe.Unequip(altSlot, true);
						WearMe.QueueItemForMoving(altItemString);
						-- Equip primary slot item to secondary slot
						PickupInventoryItem(invSlot);
						EquipCursorItem(altSlot);
						-- Equip the desired item to the primary slot
						if (outfit[invSlot].bag or outfit[invSlot].slot) then
							WearMe.WearItem(outfit[invSlot], invSlot);
						end
						
					else
						WearMe.WearItem(outfit[invSlot], invSlot);
						WearMe.WearItem(outfit[altSlot], altSlot);
						
					end
					
				else
					-- Either one slot is empty or only one slot is specified for the outfit
					if (outfit[invSlot].specified) then
						WearMe.WearItem(outfit[invSlot], invSlot);
					end
					if (outfit[altSlot].specified) then
						WearMe.WearItem(outfit[altSlot], altSlot);
					end
					
				end
				
			end
			
		end
		
		-- All Slots except the duplicates (previously handled as exceptions)
		for i=0, 19 do
			if (not WearMe.DuelInventorySlots[i]) then
				WearMe.WearItem(outfit[i], i);
			end
		end
			
	end
	
	
	function WearMe.WearItem(item, invSlot)
		if (item.specified) then
			if (item.bag and item.slot) then
				WearMe.EquipContainerItem(item.bag, item.slot, invSlot);
			elseif (item.slot) then
				WearMe.EquipInventoryItem(item.slot, invSlot);
			else
				WearMe.Unequip(invSlot, true);
			end
		end
	end
	
	
	---------------------------------------------------------------------------------
	--[[ Optimized Set Moving (Bags to Bank or Bank to Bags) ]]--
	--	
	--	
	--[[
	EX:
	WearMe.InitSet();
	WearMe.RegisterBagItemToMove("item:18822:2646:0:0", "Obsidian Edged Blade");
	WearMe.MoveSetToBank();
	
	or
	
	WearMe.InitSet();
	WearMe.RegisterBankItemToMove("item:18822:2646:0:0", "Obsidian Edged Blade");
	WearMe.MoveSetToBags();
	]]--
	---------------------------------------------------------------------------------
	
	WearMe.SetItems = {};
	WearMe.SetItems.reqBagSlots = 0;
	
	
	function WearMe.InitSet()
		WearMe.SetItems = {};
		WearMe.SetItems.reqBagSlots = 0;
	end
	
	function WearMe.RegisterBagItemToMove(itemID, itemName, itemCount)
		return WearMe.RegisterToMove(itemID, itemName, itemCount, WearMe.FindContainerItem);
	end
	
	function WearMe.RegisterBankItemToMove(itemID, itemName, itemCount)
		return WearMe.RegisterToMove(itemID, itemName, itemCount, WearMe.FindBankItem);
	end
	
	-- index, startBag, and startSlot are not for normal use. They are only used for recursion when finding more than one (stack) of an item.
	-- findFunc is used to designate finding in bags or bank
	function WearMe.RegisterToMove(itemID, itemName, itemCount, findFunc, index, startBag, startSlot)
		
		if (not itemCount) then
			itemCount = 1;
		end
		
		local item = {};
		
		local bag, slot = findFunc(itemID, itemName, startBag, startSlot);
		if (not bag) then
			return false;
		end

		local _, count, locked = GetContainerItemInfo(bag, slot);
		if (locked) then
			return WearMe.RegisterToMove(itemID, itemName, itemCount, findFunc, index, bag, slot+1);
		end
		--local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag, slot);
		local itemString = WearMe.GetContainerItemInfo(bag, slot);
		local _, _, _, _, _, _, stackSize = GetItemInfo(itemString);
		--local name, itemString, quality, itemLevel, minLevel, itemType, itemSubType, stackSize, equipLoc, texture = GetItemInfo(itemString);
		
		local item;
		if (index and WearMe.SetItems[index]) then
			item = WearMe.SetItems[index];
		else
			tinsert(WearMe.SetItems, {});
			index = getn(WearMe.SetItems);
			item = WearMe.SetItems[index];
			item.itemString = itemString;
			item.stackSize = stackSize;
			item.count = 0;
			item.where = {};
		end
		
		if (count > itemCount) then
			--  split stack
			item.count = item.count + itemCount;
			--Sea.io.print("Split stack: ", itemCount, " Total: ", item.count);
			tinsert( item.where, { bag = bag, slot = slot, count = itemCount } );
		elseif (count == itemCount) then
			-- pickup whole stack
			item.count = item.count + count;
			--Sea.io.print("Pickup whole stack: ", count, " Total: ", item.count);
			tinsert( item.where, { bag = bag, slot = slot } );
		else
			-- pickup whole stack
			item.count = item.count + count;
			--Sea.io.print("Pickup whole stack: ", count, " Total: ", item.count);
			tinsert( item.where, { bag = bag, slot = slot } );
			-- look for more
			return WearMe.RegisterToMove(itemID, itemName, itemCount-count, findFunc, index, bag, slot+1);
		end
		
		return true;
	end

	function WearMe.MoveSetToBags(backwards)
		return WearMe.MoveSet(backwards, WearMe.FindContainerItem, WearMe.BagCursorItem);
	end
	
	function WearMe.MoveSetToBank(backwards)
		return WearMe.MoveSet(backwards, WearMe.FindBankItem, WearMe.BankCursorItem);
	end
	
	function WearMe.MoveSet(backwards, findFunc, placeFunc)
		local increment = (backwards and -1 or 1);
		
		local bag, slot, finished, count, locked, _;
		for i, item in ipairs(WearMe.SetItems) do
			if (item.where) then
                item.stackSize = tonumber(item.stackSize)
				if (item.stackSize and item.stackSize > 1) then
					
					finished = false;
					bag, slot = findFunc(item.itemString);
					while (bag and not finished) do
						-- Stack found in Bank
						_, count, locked = GetContainerItemInfo(bag, slot);
						if (locked or count == item.stackSize) then
							-- Full or locked stack, ignore it, look for another
							bag, slot = findFunc(item.itemString, bag, slot+increment);
						elseif (count + item.count <= item.stackSize) then
							-- Partial stack with enough space
							for i, currStack in ipairs(item.where) do
								if (currStack.count) then
									SplitContainerItem(currStack.bag, currStack.slot, currStack.count);
								else
									PickupContainerItem(currStack.bag, currStack.slot);
								end
								PickupContainerItem(bag, slot);
							end
							finished = true;
						else
							-- More than this stack can hold, check for more
							bag, slot = findFunc(item.itemString, bag, slot+increment);
						end
					end
					
					if (not finished) then
						-- More to transfer, no partial stacks availible
						for i, currStack in ipairs(item.where) do
							if (currStack.count) then
								--Sea.io.printComma("SplitContainerItem", currStack.bag, currStack.slot, currStack.count);
								SplitContainerItem(currStack.bag, currStack.slot, currStack.count);
							else
								--Sea.io.printComma("PickupContainerItem", currStack.bag, currStack.slot);
								PickupContainerItem(currStack.bag, currStack.slot);
							end
							--Sea.io.printComma("placeFunc");
							if (not placeFunc(backwards)) then
								ClearCursor();
								return false;
							end
						end
					end
					
				elseif (item.where[1]) then
					-- Move a single item
					PickupContainerItem(item.where[1].bag, item.where[1].slot);
					if (not placeFunc(backwards)) then
						ClearCursor();
						return false;
					end
				else
					return false;
				end
			end
		end
		
		return true;
	end
	
	
	------------------------------------------------------------------------------
	--[[ Move to back of bags queue ]]--
	------------------------------------------------------------------------------
	
	function WearMe.QueueItemForMoving(itemID)
		if (not WearMe.MoveQueue) then
			WearMe.MoveQueue = {};
		end
		tinsert(WearMe.MoveQueue, itemID);
	end
	
	
	function WearMe.CallMoveQueue()
		if (WearMe.MoveQueue and getn(WearMe.MoveQueue) > 0) then
			for i=getn(WearMe.MoveQueue), 1, -1 do
				if (WearMe.ReBagContainerItemByID(WearMe.MoveQueue[i], true)) then
					table.remove(WearMe.MoveQueue, i);
				end
			end
		end
	end
	
	
	------------------------------------------------------------------------------
	--[[ Item Cache ]]--
	------------------------------------------------------------------------------
	
	function WearMe.ClearInventoryCache()
		local item;
		for invSlot = 0, 19 do
			item = WearMe.Inventory[invSlot];
			if (not item) then
				WearMe.Inventory[invSlot] = {};
			else
				item.itemString = nil;
				item.itemID = nil;
				item.enchant = nil;
				item.suffix = nil;
				item.bonus = nil;
				item.name = nil;
				item.cached = nil;
			end
		end
	end
	
	function WearMe.ClearContainerCache(bag)
		local to, from;
		if (bag) then
			to = bag;
			from = bag;
		else
			to = 11;
			from = -1;
		end
		local item;
		for bag = from, to do
			for slot = 1, GetContainerNumSlots(bag) do
				item = WearMe.Containers[bag][slot];
				if (not item) then
					WearMe.Containers[bag][slot] = {};
				else
					item.itemString = nil;
					item.itemID = nil;
					item.enchant = nil;
					item.suffix = nil;
					item.bonus = nil;
					item.name = nil;
					item.cached = nil;
				end
			end
		end
	end
	
	function WearMe.CacheInventoryItemName(invSlot, name)
		local item = WearMe.Inventory[invSlot];
		if (not item) then
			WearMe.Inventory[invSlot] = {};
			item = WearMe.Inventory[invSlot];
		end
		if (type(name) ~= "number") then
			if (name ~= item.name) then
				item.itemString = nil;
				item.itemID = nil;
				item.enchant = nil;
				item.suffix = nil;
				item.bonus = nil;
			end
			item.name = name;
			item.cached = true;
		end
	end
	
	function WearMe.CacheInventoryItem(invSlot, itemString, itemID, permEnchant, suffix, extraItemInfo, itemName)
		local item = WearMe.Inventory[invSlot];
		if (not item) then
			WearMe.Inventory[invSlot] = {};
			item = WearMe.Inventory[invSlot];
		end
		if (type(itemString) ~= "number") then
			item.itemString = itemString;
			item.itemID = itemID;
			item.enchant = permEnchant;
			item.suffix = suffix;
			item.bonus = extraItemInfo;
			item.name = itemName;
			item.cached = true;
		else
			--Sea.io.printComma("Wrong itemString: ", invSlot, itemString, itemID, permEnchant, suffix, extraItemInfo, itemName)
		end
	end
	
	function WearMe.CacheContainerItemName(bag, slot, name)
		if (not WearMe.Containers[bag]) then
			WearMe.Containers[bag] = {};
		end
		local item = WearMe.Containers[bag][slot];
		if (not item) then
			WearMe.Containers[bag][slot] = {};
			item = WearMe.Containers[bag][slot];
		end
		if (type(name) ~= "number") then
			if (name ~= item.name) then
				item.itemString = nil;
				item.itemID = nil;
				item.enchant = nil;
				item.suffix = nil;
				item.bonus = nil;
			end
			item.name = name;
			item.cached = true;
		end
	end
	
	function WearMe.CacheContainerItem(bag, slot, itemString, itemID, permEnchant, suffix, extraItemInfo, itemName)
		if (not WearMe.Containers[bag]) then
			WearMe.Containers[bag] = {};
		end
		local item = WearMe.Containers[bag][slot];
		if (not item) then
			WearMe.Containers[bag][slot] = {};
			item = WearMe.Containers[bag][slot];
		end
		if (type(itemString) ~= "number") then
			--Sea.io.printComma("CacheContainerItem: setting ", bag, slot, itemName);
			item.itemString = itemString;
			item.itemID = itemID;
			item.enchant = permEnchant;
			item.suffix = suffix;
			item.bonus = extraItemInfo;
			item.name = itemName;
			item.cached = true;
		end
	end
	
	function WearMe.CacheCursorItem(itemString, itemID, permEnchant, suffix, extraItemInfo, itemName)
		local item = WearMe.CursorItem;
		if (not item) then
			WearMe.CursorItem = {};
			item = WearMe.CursorItem;
		end
		item = WearMe.CursorItem.nextItem;
		if (not item) then
			WearMe.CursorItem.nextItem = {};
			item = WearMe.CursorItem.nextItem;
		end
		--Sea.io.print("CacheCursorItem: setting nextItem: ", itemName);
		item.itemString = itemString;
		item.itemID = itemID;
		item.enchant = permEnchant;
		item.suffix = suffix;
		item.bonus = extraItemInfo;
		item.name = itemName;
		
		item.bag = nil;
		item.bagSlot = nil;
		item.invSlot = nil;
	end
	
	function WearMe.UpdateCursorCache()
		local item = WearMe.CursorItem;
		if (not item) then
			WearMe.CursorItem = {};
			item = WearMe.CursorItem;
		end
		
		if (item.nextItem and item.nextItem.name) then
			--Sea.io.print("UpdateCursorCache: copy from nextItem");
			item.itemString = item.nextItem.itemString;
			item.itemID = item.nextItem.itemID;
			item.enchant = item.nextItem.enchant;
			item.suffix = item.nextItem.suffix;
			item.bonus = item.nextItem.bonus;
			item.name = item.nextItem.name;
			
			item.bag = item.nextItem.bag;
			item.bagSlot = item.nextItem.bagSlot;
			item.invSlot = item.nextItem.invSlot;
			
			item.split = item.nextItem.split;
			
			WearMe.ClearNextItemCursorCache();
		
		elseif (item.split) then
			item.split = nil;
		
		elseif (not CursorHasItem()) then
			--Sea.io.print("UpdateCursorCache: clearing cursor");
			item.itemString = nil;
			item.itemID = nil;
			item.enchant = nil;
			item.suffix = nil;
			item.bonus = nil;
			item.name = nil;
			
			item.bag = nil;
			item.bagSlot = nil;
			item.invSlot = nil;
			
			item.split = nil;
			
			WearMe.ClearNextItemCursorCache();
			
		end
	end
	
	function WearMe.ClearNextItemCursorCache()
		--Sea.io.print("ClearNextItemCursorCache");
		if (WearMe.CursorItem and WearMe.CursorItem.nextItem) then
			local item = WearMe.CursorItem.nextItem;
			item.itemString = nil;
			item.itemID = nil;
			item.enchant = nil;
			item.suffix = nil;
			item.bonus = nil;
			item.name = nil;
			
			item.bag = nil;
			item.bagSlot = nil;
			item.invSlot = nil;
			
			item.split = nil;
		end
	end
	
	function WearMe.CacheBagSubTypes()
		if (not WearMe.BagSubTypes) then
			WearMe.BagSubTypes = {};
		end
		WearMe.BagSubTypes[0] = "Bag";
		WearMe.BagSubTypes[-1] = "Bag";
		WearMe.BagSubTypes[-2] = "Key";
		for bag = 1, 10 do
			invSlotID = ContainerIDToInventoryID(bag);
			if (invSlotID > 0) then
				itemString = WearMe.GetInventoryItemInfo(invSlotID);
				if (itemString) then
					_, _, _, _, _, itemSubType = GetItemInfo(itemString);
					if (itemSubType) then
						WearMe.BagSubTypes[bag] = itemSubType;
					else
						WearMe.BagSubTypes[bag] = nil;
					end
				else
					WearMe.BagSubTypes[bag] = nil;
				end
			else
				WearMe.BagSubTypes[bag] = "Bag";
			end
		end
		WearMe.BagSubTypes.cached = true;
	end
	
	------------------------------------------------------------------------------
	--[[ Cache Hooks ]]--
	------------------------------------------------------------------------------
	
	function WearMe.PickupContainerItem_Hook(bag, slot)
		if (CursorHasItem()) then
			local cursorItem = WearMe.CursorItem;
			if (cursorItem and cursorItem.itemID) then
				local itemString, itemID, permEnchant, suffix, extraItemInfo, itemName = WearMe.GetContainerItemInfo(bag, slot);
				--Sea.io.print("PickupContainerItem: Current Item: ", itemName, " Cursor Item: ", cursorItem.name)
				WearMe.CacheContainerItem(bag, slot, cursorItem.itemString, cursorItem.itemID, cursorItem.enchant, cursorItem.suffix, cursorItem.bonus, cursorItem.name);
				
				if (cursorItem.invSlot) then
					WearMe.CacheInventoryItem(cursorItem.invSlot, itemString, itemID, permEnchant, suffix, extraItemInfo, itemName);
				elseif (cursorItem.bag and cursorItem.bagSlot) then
					WearMe.CacheContainerItem(cursorItem.bag, cursorItem.bagSlot, itemString, itemID, permEnchant, suffix, extraItemInfo, itemName);
				end
			end
		else
			local itemString, itemID, permEnchant, suffix, extraItemInfo, itemName = WearMe.GetContainerItemInfo(bag, slot);
			WearMe.CacheCursorItem(itemString, itemID, permEnchant, suffix, extraItemInfo, itemName);
			WearMe.CursorItem.nextItem.bag = bag;
			WearMe.CursorItem.nextItem.bagSlot = slot;
		end
	end
	
	Sea.util.unhook("PickupContainerItem", "WearMe.PickupContainerItem_Hook", "before");
	Sea.util.hook("PickupContainerItem", "WearMe.PickupContainerItem_Hook", "before");
	
	
	function WearMe.SplitContainerItem_Hook(bag, slot, count)
		if (CursorHasItem()) then
			local cursorItem = WearMe.CursorItem;
			if (cursorItem and cursorItem.itemID) then
				local itemString, itemID, permEnchant, suffix, extraItemInfo, itemName = WearMe.GetContainerItemInfo(bag, slot);
				--Sea.io.print("PickupContainerItem: Current Item: ", itemName, " Cursor Item: ", cursorItem.name)
				WearMe.CacheContainerItem(bag, slot, cursorItem.itemString, cursorItem.itemID, cursorItem.enchant, cursorItem.suffix, cursorItem.bonus, cursorItem.name);
				
				if (cursorItem.invSlot) then
					WearMe.CacheInventoryItem(cursorItem.invSlot, itemString, itemID, permEnchant, suffix, extraItemInfo, itemName);
				elseif (cursorItem.bag and cursorItem.bagSlot) then
					WearMe.CacheContainerItem(cursorItem.bag, cursorItem.bagSlot, itemString, itemID, permEnchant, suffix, extraItemInfo, itemName);
				end
			end
		else
			local itemString, itemID, permEnchant, suffix, extraItemInfo, itemName = WearMe.GetContainerItemInfo(bag, slot);
			WearMe.CacheCursorItem(itemString, itemID, permEnchant, suffix, extraItemInfo, itemName);
			WearMe.CursorItem.nextItem.bag = bag;
			WearMe.CursorItem.nextItem.bagSlot = slot;
			WearMe.CursorItem.nextItem.split = true;
		end
	end
	
	Sea.util.unhook("SplitContainerItem", "WearMe.SplitContainerItem_Hook", "before");
	Sea.util.hook("SplitContainerItem", "WearMe.SplitContainerItem_Hook", "before");
	
	
	function WearMe.PickupInventoryItem_Hook(invSlot)
		if (CursorHasItem()) then
			local cursorItem = WearMe.CursorItem;
			if (cursorItem and cursorItem.itemID) then
				local itemString, itemID, permEnchant, suffix, extraItemInfo, itemName = WearMe.GetInventoryItemInfo(invSlot);
				WearMe.CacheInventoryItem(invSlot, cursorItem.itemString, cursorItem.itemID, cursorItem.enchant, cursorItem.suffix, cursorItem.bonus, cursorItem.name);
				
				if (cursorItem.invSlot) then
					WearMe.CacheInventoryItem(cursorItem.invSlot, itemString, itemID, permEnchant, suffix, extraItemInfo, itemName);
				elseif (cursorItem.bag and cursorItem.bagSlot) then
					WearMe.CacheContainerItem(cursorItem.bag, cursorItem.bagSlot, itemString, itemID, permEnchant, suffix, extraItemInfo, itemName);
				end
			end
		else
			local itemString, itemID, permEnchant, suffix, extraItemInfo, itemName = WearMe.GetInventoryItemInfo(invSlot);
			WearMe.CacheCursorItem(itemString, itemID, permEnchant, suffix, extraItemInfo, itemName);
			WearMe.CursorItem.nextItem.invSlot = invSlot;
		end
		if (WearMe.BagSubTypes.cached and WearMe.InventoryIDToContainerID(invSlot)) then
			WearMe.BagSubTypes.cached = false;
		end
	end
	
	Sea.util.unhook("PickupInventoryItem", "WearMe.PickupInventoryItem_Hook", "before");
	Sea.util.hook("PickupInventoryItem", "WearMe.PickupInventoryItem_Hook", "before");
	
	function WearMe.EquipCursorItem_Hook(invSlot)
		if (CursorHasItem()) then
			local cursorItem = WearMe.CursorItem;
			if (cursorItem and cursorItem.itemID) then
				local itemString, itemID, permEnchant, suffix, extraItemInfo, itemName = WearMe.GetInventoryItemInfo(invSlot);
				WearMe.CacheInventoryItem(invSlot, cursorItem.itemString, cursorItem.itemID, cursorItem.enchant, cursorItem.suffix, cursorItem.bonus, cursorItem.name);
				
				if (cursorItem.invSlot) then
					WearMe.CacheInventoryItem(cursorItem.invSlot, itemString, itemID, permEnchant, suffix, extraItemInfo, itemName);
				elseif (cursorItem.bag and cursorItem.bagSlot) then
					WearMe.CacheContainerItem(cursorItem.bag, cursorItem.bagSlot, itemString, itemID, permEnchant, suffix, extraItemInfo, itemName);
				end
			end
		end
	end
	
	Sea.util.unhook("EquipCursorItem", "WearMe.EquipCursorItem_Hook", "before");
	Sea.util.hook("EquipCursorItem", "WearMe.EquipCursorItem_Hook", "before");

	------------------------------------------------------------------------------
	--[[ Event Handler ]]--
	------------------------------------------------------------------------------
	
	function WearMe.OnEvent()
		if (event == "PLAYERBANKSLOTS_CHANGED") then
			WearMe.ClearContainerCache(-1);
			--Sea.io.print("PLAYERBANKSLOTS_CHANGED");
			
		elseif (event == "BAG_UPDATE") then
			-- arg1 = Container ID
			WearMe.ClearContainerCache(arg1);
			--Sea.io.print("BAG_UPDATE: ", arg1);
			
			
		elseif (event == "UNIT_INVENTORY_CHANGED") then
			if (arg1 == "player") then
				--Sea.io.print("UNIT_INVENTORY_CHANGED: ", arg1);
				WearMe.ClearInventoryCache();
				WearMe.CallMoveQueue();
			end
		
		elseif (event == "CURSOR_UPDATE") then
			--Sea.io.print("CURSOR_UPDATE: ", CursorHasItem());
			WearMe.UpdateCursorCache();
		
		end
	end
	
	------------------------------------------------------------------------------
	--[[ Event Driver ]]--
	------------------------------------------------------------------------------

	if (not WearMeFrame) then
		CreateFrame("Frame", "WearMeFrame");
	end
	WearMeFrame:Hide();
	--Frame Scripts
	WearMeFrame:SetScript("OnEvent", WearMe.OnEvent);
	WearMeFrame:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
	WearMeFrame:RegisterEvent("BAG_UPDATE");
	WearMeFrame:RegisterEvent("UNIT_INVENTORY_CHANGED");
	WearMeFrame:RegisterEvent("CURSOR_UPDATE");
	
end
