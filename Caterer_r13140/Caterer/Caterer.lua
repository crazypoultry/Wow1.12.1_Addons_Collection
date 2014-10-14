--[[---------------------------------------------------------------------------------
 Caterer
 written by Pik/Silvermoon (YES, I KNOW WHAT IT MEANS IN DUTCH), 
 code based on FreeRefills code by Kyahx with a shout out to Maia.
 inspired by Arcanum, Trade Dispenser, Vending Machine.
 
 To Do:
 + Add command line configuration for add|del|list.
 + Add multi-trade sets (if trade group exceeds 6 items).
 + Add filter to trade with friends.
 + Add filter to trade with defined individuals.
 + Add blacklist feature.
 + Modify myGuild data to update if guild changes.
 + Add sub-profiles.
 + Add restacking.
 + Add partial stack trades.
 + Bugfix trade frame exceeding 6 usable slots.
 + Bugfix possible sitting issue.
 + Add whisper based request system.
 + Add UI/FuBar
 ------------------------------------------------------------------------------------]]

--[[---------------------------------------------------------------------------------
 Localization
------------------------------------------------------------------------------------]]

local L = AceLibrary("AceLocale-2.0"):new("Caterer", true)

--[[---------------------------------------------------------------------------------
 defaults and AceOptions table
------------------------------------------------------------------------------------]]

local defaults = {
	tradeWithAnyone = false,
	tradeWithRaid = true,
	tradeWithGuild = true,
	tradeWithFriend = true,
	blacklistTime = 5,
	tradewhat = {
		[L["WARLOCK"]] = { 8079 , 22895 },
		[L["WARRIOR"]] = { 22895 },
		[L["PRIEST"]] = { 8079 },
		[L["ROGUE"]] = { 22895 },
		[L["HUNTER"]] = { 8079, 22895 },		
		[L["PALADIN"]] = { 8079 },				
		[L["DRUID"]] = { 8079 },
	},
	tradecount = {
		[L["WARLOCK"]] = { 60, 40 },
		[L["WARRIOR"]] = { 60 },
		[L["PRIEST"]] = { 60 },
		[L["ROGUE"]] = { 60 },		
		[L["HUNTER"]] = { 60, 20 },
		[L["PALADIN"]] = { 60 },		
		[L["DRUID"]] = { 60 },	
	},
	tradetest = {
		[L["WARLOCK"]] = { [2000] = 20, [3000] = 30 },
	},
}

local tradeOn = false
local myGuild, _, _ = GetGuildInfo("player")

local options = { 
    type='group',
    args = {
      add = {
          type = 'text',
          name = L["add"],
          desc = L["Add an entry to the caterer list. (Usage /caterer add <name> [Item Link] #)"],
          usage = L["<name/class> [Item Link] <number of items>"],
          get = false,
          set = "AddTradeItem",
      },    
      options = {
          type = 'text',
          name = L["options"],
          desc = L["Change or view the options. (Usage /caterer option |cffff9966show|r|group||raid|guild|anyone)"],
          usage = L["|cffff9966show|r|group||raid|guild|anyone"],
          get = false,
          set = "SetOptions",
      },
      debug = {
          type = 'text',
          name = 'debug',
          desc = 'Debug only. Ignore this.',
          usage = "<!!!>",
          get = false,
          set = "Debug",
      },      
    }
}


--[[---------------------------------------------------------------------------------
 Initialization
------------------------------------------------------------------------------------]]

Caterer = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0", "AceDB-2.0")

function Caterer:OnInitialize()
  -- Called when the addon is loaded
  self:RegisterChatCommand({L["/caterer"],L["/cater"]}, options )
	self:RegisterDB("CatererDB")
	self:RegisterDefaults('profile', defaults )    
end

function Caterer:OnEnable()
  -- Called when the addon is enabled
  self:RegisterEvent("TRADE_SHOW")
	self:RegisterEvent("TRADE_ACCEPT_UPDATE")
	self:RegisterEvent("TRADE_CLOSED")
end

function Caterer:OnDisable()
    -- Called when the addon is disabled
end

--[[---------------------------------------------------------------------------------
 Events
------------------------------------------------------------------------------------]]

function Caterer:TRADE_SHOW()
	local performTrade, tradeTarget = self:CheckTheTrade()
	if performTrade then	
		local itemcount = table.getn(self.db.profile.tradewhat[tradeTarget])
		if itemcount == table.getn(self.db.profile.tradecount[tradeTarget]) then
			if itemcount > 0 then
				for i = 1, itemcount do
					self:DoTheTrade(self.db.profile.tradewhat[tradeTarget][i],self.db.profile.tradecount[tradeTarget][i])
				end
			end
			tradeOn = true
		else
			self:Print(L["|cffff9966Data mismatch between item and count for |r"]..uClass)				
		end
	end
end

function Caterer:TRADE_ACCEPT_UPDATE(arg1, arg2)
	if tradeOn then
		AcceptTrade()
	end
end

function Caterer:TRADE_CLOSED()
	tradeOn = false
end

--[[--------------------------------------------------------------------------------
  Shared Functions
-----------------------------------------------------------------------------------]]
function Caterer:CheckTheTrade()
	--Check to see whether or not we should execute the trade.
	local doTrade = false
	
	if self.db.profile.tradeWithAnyone then
		doTrade = true
	end
	if self.db.profile.tradeWithRaid then
		if UnitInParty("NPC") then
			doTrade = true
		end
		if UnitInRaid("NPC") then
			doTrade = true
		end
	end
	if self.db.profile.tradeWithGuild then
		local targetGuild, _, _ = GetGuildInfo("NPC")
		if targetGuild == myGuild then
			doTrade = true
		end
	end

	--If we're doing a trade (so far) check to see if we have data on this unit.
	local targetText = ""

	if doTrade then
		local tradeClass = string.upper(UnitClass("NPC"))
		local tradeName, _ = string.upper(UnitName("NPC"))
		if self.db.profile.tradewhat[tradeName] ~= nil then
			targetText = tradeName
		end
		if targetText == "" then
			if self.db.profile.tradewhat[tradeClass] ~= nil then
				targetText = tradeClass
			end
		end
		
		-- Trap whether or not we really have both data sets for this target.			
		if self.db.profile.tradewhat[targetText] == nil then
			self:Print(L["|cffff9966Unable to load item data for |r"]..uClass)
			doTrade = false
		end
		if self.db.profile.tradecount[targetText] == nil then
			self:Print(L["|cffff9966Unable to load count data for |r"]..uClass)				
			doTrade = false
		end
	end
	
	return doTrade, targetText
end


function Caterer:DoTheTrade(itemID,count)
	local itemCount, slotArray = self:CountItemInBags(itemID)
	local _, _, _, _, _, _, stackSize = GetItemInfo(itemID)
	stackSize = tonumber(stackSize)
	if itemCount >= count then
		--We know there's enough stuff to trade. Let's park whatever is on the cursor.
		local parkBag, parkSlot = self:FindEmptyBagSlot()
		if CursorHasItem then
		  PickupContainerItem(parkBag, parkSlot)
		end
		if table.getn(slotArray) > 1 then
			local tradeDone = false
			local currentSlot = 1
			stackCount = math.ceil(count/stackSize)
			local fullStacks = math.floor(count/stackSize)
			local partialStack = math.mod(count, stackSize)
			for i = 1, table.getn(slotArray) do
				if tradeDone == false then
					local _, _, bag, slot, num = string.find(slotArray[i], "b(%d+)s(%d+)c(%d+)")
					num = tonumber(num)
					if num == stackSize then
						while GetTradePlayerItemLink(currentSlot) ~= nil do
							currentSlot = currentSlot + 1
							if currentSlot > 6 then
								self:Print(L["|cffff9966Ran out of space in trade window!|r"])
								return
							end
						end
						PickupContainerItem(bag, slot)
						if CursorHasItem then
							ClickTradeButton(currentSlot)
							currentSlot = currentSlot + 1
							fullStacks = fullStacks - 1
						else
							self:Print(L["|cffff9966Had a problem picking things up!|r"])						
						end
					end  
					if fullStacks == 0 then tradeDone = true end
				end
			end
			
			
			if partialStack > 0 then
				--self:Print("Need to trade "..fullStacks.." stacks and a partial stack of "..partialStack)
			else
				--self:Print("Need to xx trade "..stackCount.." full stacks")							
			end			
		end

	else
		--self:SendCommMessage("WHISPER", UnitName("NPC"), L["I can't complete the trade right now. I'm out of "]..self:GetItemLink(itemID))
		self:Print(L["|cffff9966Unable to trade: Not enough |r"]..self:GetItemLink(itemID))
	end
end

function Caterer:RestackItems(itemID, slotArray)
		local currentSlot = 1
		local _, _, _, _, _, _, stackSize = GetItemInfo(itemID)
		local slotCount = table.getn(slotArray)
		for stacks = slotCount, 1, -1 do
			local _, _, bag, slot, num = string.find(slotArray[stacks], "b(%d+)s(%d+)c(%d+)")
			local _,slotCount = GetContainerItemInfo(bag, slot);
			local restack = stacks
			while slotCount < stackSize do
				if stacks > 1 then
					restack = restack - 1
					if restack > 1 then
					  local _, _, frombag, fromslot, num = string.find(slotArray[restack], "b(%d+)s(%d+)")
						self:Print("Moving b"..frombag.." s"..fromslot.." to b"..bag.." s"..slot)
						PickupContainerItem(frombag, fromslot)
						if(CursorHasItem()) then
							self:PutItemInBag(bag)	
						end
					else
						slotCount = stackSize
					end
				else
					slotCount = stackSize
				end


			end  	
		end	
end

function Caterer:GetItemLink(itemID)
  if itemID ~= nil then
		local name, link, quality = GetItemInfo(itemID)
		local _,_,_,hex = GetItemQualityColor(quality)
		return format("%s|H%s|h[%s]|h|r", hex, link, name)
  end
end

function Caterer:FindEmptyBagSlot()
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot = size, 1, -1 do
				local slotID = self:ExtractItemID(GetContainerItemLink(bag,slot));
				if slotID == nil then
					return bag, slot
				end            
			end
		end
	end
	return itemCount, slotArray
end

function Caterer:CountItemInBags(itemID)
	local itemCount = 0
	local slotArray = {}
	itemID = tonumber(itemID)
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot = size, 1, -1 do
				local slotID = self:ExtractItemID(GetContainerItemLink(bag,slot));
				slotID = tonumber(slotID)
				if slotID == itemID then
					local _,slotCount = GetContainerItemInfo(bag, slot);
					itemCount = itemCount + slotCount;
					table.insert(slotArray, "b"..bag.."s"..slot.."c"..slotCount)
				end            
			end
		end
	end
	return itemCount, slotArray
end

function Caterer:ExtractItemID(linkstring)
	if linkstring ~= nil then
		local _, _, itemID = string.find(linkstring,"item:(%d+):.*")
		return itemID
	end
end

function Caterer:ToggleBoolean(arg)
	if arg then
		arg = false
	else
		arg = true
	end
	return arg
end

function Caterer:FormatBooleanForOutput(arg)
	if arg then
		return "|cff00ff00"..L["On"].."|r"
	else
		return "|cffff0000"..L["Off"].."|r"
	end
end

--[[--------------------------------------------------------------------------------
  Command Handlers
-----------------------------------------------------------------------------------]]

function Caterer:AddTradeItem(msg)
	--Add an item to the trade list
	local _, _, what, link, num = string.find(msg, "(%a+)%s(.+)%s(%d+)")
	msg = string.format(L["Unable to parse %s. Please try again."],msg)
	local itemID
	if link ~= nil then
		itemID = self:ExtractItemID(link)
	end
	if itemID ~= nil then 
		if what ~= nil then 
			if num ~= nil then 
				num = tonumber(num)

				local addDone, addWhatDone, addCountDone = false
				
				--Add entries if none exist.
				if self.db.profile.tradewhat[string.upper(what)] == nil then
					table.insert(self.db.profile.tradewhat, string.upper(what))
					self.db.profile.tradewhat[string.upper(what)] = { itemID }
					addWhatDone = true
				end
				if self.db.profile.tradecount[string.upper(what)] == nil then
					table.insert(self.db.profile.tradecount, string.upper(what))
					self.db.profile.tradecount[string.upper(what)] = { num }
					addCountDone = true
				end				
				if addWhatDone then
					if addCountDone then
						addDone = true
					end
				end
				
				--add entries if some exist, but not the one in question.
				if not addDone then
					if self.db.profile.tradewhat[string.upper(what)] ~= nil then
						if self.db.profile.tradewhat[string.upper(what)][itemID] == nil then
							table.insert(self.db.profile.tradewhat[string.upper(what)], itemID)
							addWhatDone = true
							
						end
					end
					if self.db.profile.tradecount[string.upper(what)] ~= nil then
						if self.db.profile.tradecount[string.upper(what)][itemID] == nil then
							table.insert(self.db.profile.tradewhat[string.upper(what)], itemID)
							addWhatDone = true
							
						end
					end					
				end
				
				--add/modify entries if the one specified already exists.
				if not addDone then
				
				end
								
				if addDone then
					self:Print(string.format(L["Adding %s: %s-(%s) x%s"],what,link,tostring(itemID),tostring(num)))
				else
					self:Print(L["Unable to add entry."])
				end
			
			else
				self:Print(msg..L[" (bad number)"])
			end
		else
			self:Print(msg..L[" (bad target)"])
		end
	else
		self:Print(msg..L[" (bad item)"])
	end
end

function Caterer:SetOptions(msg)
	if msg == L["show"] then
		self:Print(L["Trade with anyone: "]..self:FormatBooleanForOutput(self.db.profile.tradeWithAnyone))
		self:Print(L["Trade with group/raid: "]..self:FormatBooleanForOutput(self.db.profile.tradeWithRaid))
		self:Print(L["Trade with guild: "]..self:FormatBooleanForOutput(self.db.profile.tradeWithGuild))
		self:Print(L["Trade with friends: "]..L["In development"])
		self:Print(L["Trade blacklist time: "]..L["In development"])
	end
	if msg == L["group"] then
		self.db.profile.tradeWithRaid = self:ToggleBoolean(self.db.profile.tradeWithRaid)
		self:Print(L["Setting trade with group/raid to: "]..self:FormatBooleanForOutput(self.db.profile.tradeWithRaid))
	end
	if msg == L["raid"] then
		self.db.profile.tradeWithRaid = self:ToggleBoolean(self.db.profile.tradeWithRaid)
		self:Print(L["Setting trade with group/raid to: "]..self:FormatBooleanForOutput(self.db.profile.tradeWithRaid))
	end
	if msg == L["guild"] then
		self.db.profile.tradeWithGuild = self:ToggleBoolean(self.db.profile.tradeWithGuild)
		self:Print(L["Setting trade with guild to: "]..self:FormatBooleanForOutput(self.db.profile.tradeWithGuild))
	end
	if msg == L["anyone"] then
		self.db.profile.tradeWithAnyone = self:ToggleBoolean(self.db.profile.tradeWithAnyone)
		self:Print(L["Setting trade with anyone to: "]..self:FormatBooleanForOutput(self.db.profile.tradeWithAnyone))
	end	
end

function Caterer:Debug(msg)
	local Asize = getn(self.db.profile.tradetest)
	self:Print("A[size]: "..getn(self.db.profile.tradetest))
	self:Print("A[n][size]: "..getn(self.db.profile.tradetest["WARLOCK"]))	
	--self:Print("A[1][1]: "..self.db.profile.tradetest[1][1])
	--self:Print("A[n][1]: "..self.db.profile.tradetest["WARLOCK"][1])
	--self:Print("A[1][2000]: "..self.db.profile.tradetest[1][2000])
	self:Print("A[n][2000]: "..self.db.profile.tradetest["WARLOCK"][2000])
end