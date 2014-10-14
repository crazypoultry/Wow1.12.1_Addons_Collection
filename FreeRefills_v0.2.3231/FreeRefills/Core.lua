local vmajor,vminor = "0.2", tonumber(string.sub("$Revision: 3231 $", 12, -3))

--[[--------------------------------------------------------------------------------
  Class Setup
-----------------------------------------------------------------------------------]]

FreeRefills	= AceAddon:new({
    name          = FreeRefillsLocals.NAME,
    description   = FreeRefillsLocals.DESCRIPTION,
    version       = vmajor..'.'..vminor,
    releaseDate   = string.sub("$Date: 2006-06-24 02:11:42 -0500 (Sat, 24 Jun 2006) $", 8, 17),
    aceCompatible = "103", -- Check ACE_COMP_VERSION in Ace.lua for current.
    author        = "Kyahx",
    email         = "Kyahx.Pots@gmail.com",
    website       = "http://www.wowace.com",
    category      = "inventory",
    db            = AceDbClass:new("FreeRefillsDB"),
    cmd           = AceChatCmdClass:new(FreeRefillsLocals.COMMANDS, FreeRefillsLocals.CMD_OPTIONS)
})

function FreeRefills:Initialize()
    -- Be sure to save data per charecter, per realm
	local realm,char = GetRealmName(), UnitName("player")
	if FreeRefillsDB[realm..':'..char] == nil then FreeRefillsDB[realm..':'..char] = {} end
	RefillsList = FreeRefillsDB[realm..':'..char]
    self.set = function(var,val) RefillsList[var] = val	end
	if RefillsList["mood"] == nil then self.set("mood","Optimist") end
end


--[[--------------------------------------------------------------------------------
  Addon Enabling/Disabling
-----------------------------------------------------------------------------------]]

function FreeRefills:Enable()
    self:RegisterEvent("MERCHANT_SHOW")
	self:RegisterEvent("BANKFRAME_OPENED")
end

function FreeRefills:Disable()
end


--[[--------------------------------------------------------------------------------
  Merchant Processing
-----------------------------------------------------------------------------------]]

function FreeRefills:MERCHANT_SHOW()
	self:debug("Merchant Opened")
	for itemID,amount in pairs(RefillsList) do
		if itemID ~= "mood" then
			local merchSlot = self:ItemInStock(itemID)
			if merchSlot then
				self:debug("Item Found in Merchant Slot #"..merchSlot)
				local amountInBags = self:CountItemInBags(itemID)
				if amountInBags >= amount then
					self:debug("Already have enough in bags.")
				else
					local stackCycle, stackRem = self:CalculateNeeded(amount, amountInBags, merchSlot)
					if stackCycle then self:debug("Need to buy "..stackCycle.." more full stacks.") end
					if stackRem then self:debug("Need to buy "..stackRem.." item(s) (Remainder stack)") end
					if stackCycle then
						for i = 1, stackCycle do
							BuyMerchantItem(merchSlot, GetMerchantItemMaxStack(merchSlot))
						end
					end
					if stackRem then
						BuyMerchantItem(merchSlot, stackRem)
					end
				end
			end
		end
	end
end

function FreeRefills:ItemInStock(itemID)
	self:debug("Searching for Item: "..itemID)
	local NumItems = GetMerchantNumItems()
	for i = 1, NumItems do
		local slotLinkString = GetMerchantItemLink(i)
		local slotID = self:ExtractItemID(slotLinkString)
		if slotID == itemID then
			return i
		end
	end
end

function FreeRefills:CalculateNeeded(amount, amountInBags, merchSlot)
	-- more detailed logic regauding stacks should be taken care of here
	local amountNeeded
	local _, _, _, stackSize = GetMerchantItemInfo(merchSlot)
	local stackedAmount
	local stackedNeeded
	local maxBuy = GetMerchantItemMaxStack(merchSlot)
	local stackCycle
	local stackRem
	
	self:debug("Stacksize: "..stackSize)
	
	if stackSize ~= 1 then
		stackedAmount = amount / stackSize
		stackedNeeded = amountInBags / stackSize
		amountNeeded = stackedAmount - stackedNeeded
		self:debug("Unrounded Needed: "..amountNeeded)
		if RefillsList["mood"] == "Pessimest" then
			stackCycle = self:RoundNumberUp(amountNeeded)
		else
			stackCycle = self:RoundNumberDown(amountNeeded)
		end
	else
		local finalNeeded = amount - amountInBags
		self:debug("Need to buy "..finalNeeded.." more.  Merchant sells in max stacks of "..maxBuy..".")
		if finalNeeded > maxBuy then
			local stacks = finalNeeded / maxBuy
			stackCycle = self:RoundNumberDown(stacks)
			stackRem = finalNeeded - (stackCycle * maxBuy)
		else
			stackRem = finalNeeded
		end
	end

	if stackCycle and stackCycle <= 0 then stackCycle = nil end
	if stackRem and stackRem <= 0 then stackRem = nil end
	
	return stackCycle, stackRem
end

function FreeRefills:RoundNumberDown(num)
	local roundNum = tonumber(string.format("%.".."f", num ))
	return roundNum
end

function FreeRefills:RoundNumberUp(num)
	local roundNum = tonumber(string.format("%.".."f", num ))
	if roundNum ~= num then roundNum = roundNum + 1 end
	return roundNum
end

--[[--------------------------------------------------------------------------------
  Bank Processing
-----------------------------------------------------------------------------------]]

function FreeRefills:BANKFRAME_OPENED()
	self:debug("Bank Opened")
	for itemID,amount in pairs(RefillsList) do
		if itemID ~= "mood" then
			local amountInBank = self:CountItemInBank(itemID)
			if amountInBank > 0 then
				local amountInBags = self:CountItemInBags(itemID)
				local amountNeeded = amount - amountInBags
				if amountInBags >= amount then
					self:debug("Already have enough in bags.")
				else
					if amountNeeded > amountInBank then
						amountNeeded = amountInBank end
					self:debug(amountNeeded.." item(s) to be looted.")
					self:LootBank(itemID, amountNeeded)
				end
			end
		end
	end
end

function FreeRefills:CountItemInBank(itemID)
	self:debug("Searching for Item: "..itemID)
	local itemCount = 0
	-- Scan the main bank first
	for slot = 1, 24 do
		local slotID = self:ExtractItemID(GetContainerItemLink(-1,slot))
		if slotID == itemID then
			local _,slotCount = GetContainerItemInfo(-1, slot)
			itemCount = itemCount + slotCount
		end
	end
	--Now Scan bank bags
	for bag = 5, 10, 1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot = 1, size, 1 do
				local slotID = self:ExtractItemID(GetContainerItemLink(bag,slot));
				if slotID == itemID then
					local _,slotCount = GetContainerItemInfo(bag, slot);
					itemCount = itemCount + slotCount;
				end            
			end
		end
	end
	self:debug(itemCount.." item(s) found in player's bank")
	return itemCount
end

function FreeRefills:LootBank(itemID, amountNeeded)
	self:debug("Bank Looting Logic: #"..itemID.." - "..amountNeeded)
	--Scan the main bank first
	for slot = 1, 24 do
		local slotID = self:ExtractItemID(GetContainerItemLink(-1,slot))
		if slotID == itemID then
			local _,slotCount = GetContainerItemInfo(-1, slot)
			self:debug(slotCount.." Item(s) Found in Bank:Slot "..slot)
			if slotCount <= amountNeeded then --We don't have to split this stack, we can cheat and use UseContainerItem
				self:debug("Looting Entire Stack")
				UseContainerItem(-1, slot)
				amountNeeded = amountNeeded - slotCount
				self:debug(slotCount.." Looted - Need "..amountNeeded.." more item(s)")
			else
				SplitContainerItem(-1, slot, amountNeeded)
				for bag = 4, 0, -1 do
					local size = GetContainerNumSlots(bag);
					if (size > 0) then
						for slot = 1, size, 1 do
							local slotID = self:ExtractItemID(GetContainerItemLink(bag,slot));
							if not slotID then
								if bag == 0 then
									PutItemInBackpack()
								else
									local bagID
									local bag = tonumber(bag)
									bagID = bag + 19
									PutItemInBag(bagID)
								end
							end
						end
					end
				end
				local amountLooted = amountNeeded
				amountNeeded = amountNeeded - amountLooted -- This should always result in 0
				self:debug(amountLooted.." Looted - Need "..amountNeeded.." more item(s)")
			end
		end
		if amountNeeded == 0 then self:debug(amountNeeded.." item(s) # "..itemID.." needed.  Next item.") return end
	end
	self:debug("Main Bank didn't cover it, scanning additional Bags")
	--Now Scan bank bags
	for bag = 5, 10, 1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot = 1, size do
				local slotID = self:ExtractItemID(GetContainerItemLink(bag,slot))
				if slotID == itemID then
					local _,slotCount = GetContainerItemInfo(bag, slot)
					self:debug(slotCount.." Item(s) Found in Bag "..bag..":Slot "..slot..". Need to loot "..amountNeeded)
					if slotCount <= amountNeeded then --We don't have to split this stack, we can cheat and use UseContainerItem
						self:debug("Looting Entire Stack")
						UseContainerItem(bag, slot)
						amountNeeded = amountNeeded - slotCount
						self:debug(slotCount.." Looted - Need "..amountNeeded.." more item(s)")
					else
						SplitContainerItem(bag, slot, amountNeeded)
						for bag = 4, 0, -1 do
							local size = GetContainerNumSlots(bag);
							if (size > 0) then
								for slot = 1, size, 1 do
									local slotID = self:ExtractItemID(GetContainerItemLink(bag,slot));
									if (not slotID) then
										if bag == 0 then
											PutItemInBackpack()
										else
											local bagID
											local bag = tonumber(bag)
											bagID = bag + 19
											PutItemInBag(bagID)
										end
									end
								end
							end
						end
						local amountLooted = amountNeeded
						amountNeeded = amountNeeded - amountLooted -- This should always result in 0
						self:debug(amountLooted.." Looted - Need "..amountNeeded.." more item(s)")
					end
				end
			if amountNeeded == 0 then self:debug(amountNeeded.." item(s) # "..itemID.." needed.  Next item.") return end
			end
		end
	end
end

--[[--------------------------------------------------------------------------------
  Shared Functions
-----------------------------------------------------------------------------------]]

function FreeRefills:CountItemInBags(itemID)
	local itemCount = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot = 1, size, 1 do
				local slotID = self:ExtractItemID(GetContainerItemLink(bag,slot));
				if slotID == itemID then
					local _,slotCount = GetContainerItemInfo(bag, slot);
					itemCount = itemCount + slotCount;
				end            
			end
		end
	end
	self:debug(itemCount.." item(s) found in player's bags")
	return itemCount
end

function FreeRefills:ExtractItemID(linkstring)
	if linkstring ~= nil then
		local _, _, itemID = string.find(linkstring,"-*:(%d+):.*")
		return itemID
	end
end

--[[--------------------------------------------------------------------------------
  Command Handlers
-----------------------------------------------------------------------------------]]

function FreeRefills:AddRefillItem(msg)
	--add an item to the refill list
	local _, _, link, num = string.find(msg, "(.+)%s(%d+)")
	local itemID = self:ExtractItemID(link)
	num = tonumber(num)
	self.set(itemID, num)
	self.cmd:msg("Added Item ID#"..itemID.." - Amount:"..num)
end

function FreeRefills:AddRefillItemStack(msg)
	--add an item to the refill list by stack
	local _, _, link, num = string.find(msg, "(.+)%s(%d+)")
	local itemID = self:ExtractItemID(link)
	local _, _, _, _, _, _, itemStack = GetItemInfo(itemID)
	num = tonumber(num)
	num = num * itemStack
	self.set(itemID, num)
	self.cmd:msg("Added Item ID#"..itemID.." - Amount:"..num)
end

function FreeRefills:RemoveRefillItem(msg)
	--remove an item from the refill list
	local itemID = self:ExtractItemID(msg)
	self.set(itemID, nil)
	self.cmd:msg("Removed Item ID#"..itemID)
end

function FreeRefills:ClearRefills()
	--clear the refill list
	for itemID,amount in pairs(RefillsList) do
		if itemID ~= "mood" then self.set(itemID, nil) end
	end
	self.cmd:msg("Item List Cleared")
end

function FreeRefills:ToggleMood()
	if RefillsList["mood"] ~= "Optimist" then
		self.set("mood", "Optimist")
		self.cmd:msg("New Mood: Optimist")
	else
		self.set("mood", "Pessimest")
		self.cmd:msg("New Mood: Pessimest")
	end
end

function FreeRefills:Report()
	local mood = RefillsList["mood"]
	self.cmd:msg("Current Mood: "..mood)
	--report back which items are currently on the refill list, and their quanitity
	self.cmd:msg("Refill List: ")
	local notempty
	for itemID,amount in pairs(RefillsList) do
		local name = GetItemInfo(itemID)
		if name ~= nil then
			self.cmd:msg("     "..name.." ("..amount..")")
			notempty = 1
		end
	end
	if not notempty then self.cmd:msg("     None") end
end


--[[--------------------------------------------------------------------------------
  Create and Register Addon Object
-----------------------------------------------------------------------------------]]

FreeRefills:RegisterForLoad()
