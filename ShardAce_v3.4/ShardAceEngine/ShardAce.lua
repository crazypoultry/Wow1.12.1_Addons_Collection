ShardAceEngine = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "Metrognome-2.0")

function ShardAceEngine:OnInitialize()
	self:RegisterDB("ShardAceEngineDB")
	self:RegisterChatCommand({"/shardaceengine","/saengine","/sae"})
	self.Class = AceLibrary("Babble-Class-2.0")
	self.Spell = AceLibrary("Babble-Spell-2.0")
	self.Deformat = AceLibrary("Deformat-2.0")
	self.Locale = AceLibrary("AceLocale-2.0"):new("ShardAceEngine")
	self.Flags = {}
	self.Local = {
		HealthstoneID = {
			[5512] = 1,
			[19004] = 1,
			[19005] = 1,
			[5511] = 1,
			[19006] = 1,
			[19007] = 1,
			[5509] = 1,
			[19008] = 1,
			[19009] = 1,
			[5510] = 1,
			[19010] = 1,
			[19011] = 1,
			[9421] = 1,
			[19012] = 1,
			[19013] = 1,
		},		
		SoulstoneID = {
			[5232] = 1,
			[16892] = 1,
			[16893] = 1,
			[16895] = 1,
			[16896] = 1,
		},
		SpellstoneID = {
			[5522] = 1,
			[13602] = 1,
			[13603] = 1,
		},
		FirestoneID = {
			[1254] = 1,
			[13699] = 1,
			[13700] = 1,
			[13701] = 1,
		},
		SoulshardID = 6265,
		AQBugMountID = {
			[21323] = 1,
			[21176] = 1,
			[21321] = 1,
			[21324] = 1,
			[21218] = 1,
		},
		InfernalStoneID = 5565,
		DemonicFigurineID = 16583,
	}
end

function ShardAceEngine:OnEnable()
	if(UnitClass("player") == self.Class["Warlock"])then
		self:RegisterEvent("LEARNED_SPELL_IN_TAB", "ScanBook")
		self:RegisterEvent("SPELLS_CHANGED", "ScanBook")
		self:RegisterEvent("SPELLCAST_FAILED", "SPELLCAST_INTERRUPTED")
		self:RegisterEvent("SPELLCAST_START")
		self:RegisterEvent("SPELLCAST_INTERRUPTED")
		self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS", "resWatch")
		self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS", "resWatch")
		self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS", "resWatch")
		--self:RegisterEvent("TRADE_SHOW")
		
		self:ScanBook()
		self:ScanInv()
	end	
	self:RegisterEvent("BAG_UPDATE", "DelayBag")
	self:RegisterEvent("BANKFRAME_OPENED")
	self:RegisterEvent("BANKFRAME_CLOSED")
	self:RegisterEvent("SPELLCAST_STOP")

	self:RegisterMetro("ShardAceEngineBagUpdate", ShardAceEngine.ScanInv, 0.5, ShardAceEngine)
end

function ShardAceEngine:OnDisable()

end

function ShardAceEngine:ScanBook()
	if not self.Spells then
		self.Spells = {}
	end
	for i = 1, 180 do
		local spellName, subSpellName = GetSpellName(i, "spell")
		local tex = GetSpellTexture(i, "spell")
		if spellName then
			if tex == self.Spell:GetSpellIcon("Create Healthstone") then
				if not self.Spells.Healthstone then
					self.Spells.Healthstone = {}
				end
				if string.find(spellName, self.Locale["Minor"]) then
					self.Spells.Healthstone[1] = i
				elseif string.find(spellName, self.Locale["Lesser"]) then
					self.Spells.Healthstone[2] = i
				elseif string.find(spellName, self.Locale["Greater"]) then
					self.Spells.Healthstone[4] = i
				elseif string.find(spellName, self.Locale["Major"]) then
					self.Spells.Healthstone[5] = i
				else
					self.Spells.Healthstone[3] = i
				end
			elseif tex == self.Spell:GetSpellIcon("Create Soulstone") then
				if not self.Spells.Soulstone then
					self.Spells.Soulstone = {}
				end
				if string.find(spellName, self.Locale["Minor"]) then
					self.Spells.Soulstone[1] = i
				elseif string.find(spellName, self.Locale["Lesser"]) then
					self.Spells.Soulstone[2] = i
				elseif string.find(spellName, self.Locale["Greater"]) then
					self.Spells.Soulstone[4] = i
				elseif string.find(spellName, self.Locale["Major"]) then
					self.Spells.Soulstone[5] = i
				else
					self.Spells.Soulstone[3] = i
				end
			elseif tex == self.Spell:GetSpellIcon("Create Spellstone") then
				if not self.Spells.Spellstone then
					self.Spells.Spellstone = {}
				end
				if string.find(spellName, self.Locale["Greater"]) then
					self.Spells.Spellstone[2] = i
				elseif string.find(spellName, self.Locale["Major"]) then
					self.Spells.Spellstone[3] = i
				else
					self.Spells.Spellstone[1] = i
				end
			elseif tex == self.Spell:GetSpellIcon("Create Firestone") then
				if not self.Spells.Firestone then
					self.Spells.Firestone = {}
				end
				if string.find(spellName, self.Locale["Lesser"]) then
					self.Spells.Firestone[1] = i
				elseif string.find(spellName, self.Locale["Greater"]) then
					self.Spells.Firestone[3] = i
				elseif string.find(spellName, self.Locale["Major"]) then
					self.Spells.Firestone[4] = i
				else
					self.Spells.Firestone[2] = i
				end
			elseif tex == self.Spell:GetSpellIcon("Detect Lesser Invisibility") then
				if not self.Spells.DetectInvis then
					self.Spells.DetectInvis = {}
				end
				if spellName == self.Spell["Detect Lesser Invisibility"] then
					self.Spells.DetectInvis[1] = i
				end
			elseif tex == self.Spell:GetSpellIcon("Detect Invisibility") then
				if not self.Spells.DetectInvis then
					self.Spells.DetectInvis = {}
				end
				if spellName == self.Spell["Detect Greater Invisibility"] then
					self.Spells.DetectInvis[3] = i
				elseif spellName == self.Spell["Detect Invisibility"] then
					self.Spells.DetectInvis[2] = i
				end
			elseif tex == self.Spell:GetSpellIcon("Summon Felsteed") then
				if not self.Spells.Mount then
					self.Spells.Mount = {}
				end
				self.Spells.Mount[1] = i
			elseif tex == self.Spell:GetSpellIcon("Summon Dreadsteed") then
				if not self.Spells.Mount then
					self.Spells.Mount = {}
				end
				self.Spells.Mount[2] = i
			elseif tex == self.Spell:GetSpellIcon("Demon Armor") then
				if not self.Spells.DemonBuff then
					self.Spells.DemonBuff = {}
				end
				if string.find(spellName, self.Spell["Demon Skin"]) then
					if string.find(subSpellName, "1") then
						self.Spells.DemonBuff[1] = i
					elseif string.find(subSpellName, "2") then
						self.Spells.DemonBuff[2] = i
					end
				elseif string.find(spellName, self.Spell["Demon Armor"]) then
					if string.find(subSpellName, "1") then
						self.Spells.DemonBuff[3] = i
					elseif string.find(subSpellName, "2") then
						self.Spells.DemonBuff[4] = i
					elseif string.find(subSpellName, "3") then
						self.Spells.DemonBuff[5] = i
					elseif string.find(subSpellName, "4") then
						self.Spells.DemonBuff[6] = i
					elseif string.find(subSpellName, "5") then
						self.Spells.DemonBuff[7] = i
					end
				end
			elseif tex == self.Spell:GetSpellIcon("Ritual of Summoning") then
				self.Spells.Port = i
			elseif tex == self.Spell:GetSpellIcon("Inferno") then
				self.Spells.Infernal = i
			elseif tex == self.Spell:GetSpellIcon("Curse of Doom") then
				self.Spells.CurseofDoom = i
			elseif tex == self.Spell:GetSpellIcon("Ritual of Doom") then
				self.Spells.Doomguard = i
			elseif tex == self.Spell:GetSpellIcon("Enslave Demon") then
				if not self.Spells.Enslave then
					self.Spells.Enslave = {}
				end
				if string.find(subSpellName, "1") then
					self.Spells.Enslave[1] = i
				elseif string.find(subSpellName, "2") then
					self.Spells.Enslave[2] = i
				elseif string.find(subSpellName, "3") then
					self.Spells.Enslave[3] = i
				end
			elseif tex == self.Spell:GetSpellIcon("Fel Domination") then
				self.Spells.FelDomination = i
			elseif tex == self.Spell:GetSpellIcon("Eye of Kilrogg") then
				self.Spells.Eye = i
			elseif tex == self.Spell:GetSpellIcon("Banish") then
				if not self.Spells.Banish then
					self.Spells.Banish = {}
				end
				if string.find(subSpellName, "1") then
					self.Spells.Banish[1] = i
				elseif string.find(subSpellName, "2") then
					self.Spells.Banish[2] = i
				end
			elseif tex == self.Spell:GetSpellIcon("Demonic Sacrifice") then
				self.Spells.Sacrifice = i
			elseif tex == self.Spell:GetSpellIcon("Sense Demons") then
				self.Spells.Tracking = i
			elseif tex == self.Spell:GetSpellIcon("Unending Breath") then
				if spellName == self.Spell["Unending Breath"] then
					self.Spells.Breath = i
				end
			elseif tex == self.Spell:GetSpellIcon("Summon Imp") then
				self.Spells.Imp = i
			elseif tex == self.Spell:GetSpellIcon("Summon Voidwalker") then
				self.Spells.Voidwalker = i
			elseif tex == self.Spell:GetSpellIcon("Summon Succubus") then
				self.Spells.Succubus = i
			elseif tex == self.Spell:GetSpellIcon("Summon Felhunter") then
				self.Spells.Felhunter = i
			end
		end
	end
	self:TriggerEvent("ShardAceEngine_SpellBookScanned")
end

function ShardAceEngine:DelayBag()
	self:StartMetro("ShardAceEngineBagUpdate")
end

function ShardAceEngine:ScanInv()
	self:StopMetro("ShardAceEngineBagUpdate")
	if not self.Items then
		self.Items = {}
	end
	self.Items.ShardCount = 0
	self.Items.Healthstone = nil
	self.Items.Soulstone = nil
	self.Items.Spellstone = nil
	self.Items.Firestone = nil
	self.Items.Offhand = nil
	self.Items.AQBugMount = nil
	self.Items.InfernalStoneCount = 0
	self.Items.DemonicFigurineCount = 0

	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag)
		if (size > 0) then

			for slot=1, size, 1 do
				local _,_,itemID = string.find(GetContainerItemLink(bag,slot) or "", "item:(%d+):%d+:%d+:%d+")
				itemID = tonumber(itemID)
				if (itemID) then
					--ace:print(type(itemID))
					if itemID == self.Local.SoulshardID then
						self.Items.ShardCount = self.Items.ShardCount + 1
					elseif self.Local.HealthstoneID[itemID] then
						self.Items.Healthstone = {bag, slot}
					elseif self.Local.SoulstoneID[itemID] then
						self.Items.Soulstone = {bag, slot}
					elseif self.Local.FirestoneID[itemID] then
						self.Items.Firestone = {bag, slot}
					elseif self.Local.SpellstoneID[itemID] then
						self.Items.Spellstone = {bag, slot}
					elseif itemID == self.Local.OffhandID then
						self.Items.Offhand = {bag, slot}
					elseif self.Local.AQBugMountID[itemID] then
						self.Items.AQBugMount = {bag, slot}
					elseif itemID == self.Local.InfernalStoneID then
						local _, itemCount, _, _, _ = GetContainerItemInfo(bag,slot)
						self.Items.InfernalStoneCount = self.Items.InfernalStoneCount + itemCount
					elseif itemID == self.Local.DemonicFigurineID then
						local _, itemCount, _, _, _ = GetContainerItemInfo(bag,slot)
						self.Items.DemonicFigurineCount = self.Items.DemonicFigurineCount + itemCount
					end
				end
			end
		end
	end
	self:TriggerEvent("ShardAceEngine_InventoryScanned")
end

function ShardAceEngine:BANKFRAME_OPENED()
	self.Flags.Bank = true
end

function ShardAceEngine:BANKFRAME_CLOSED()
	self.Flags.Bank = nil
end

function ShardAceEngine:SortShards(sbag, Revsort) -- sbag = 0-4, bag to sort into. Revsort: true = sort into sbag from bottom up
	if self.Flags.Bank then
		return
	end
	self.Flags.lastSort = self.Flags.lastSort or 0
	local delay = GetTime() - self.Flags.lastSort
	if delay < 1 then
		return
	end
	
	local sTable = {}
	local eTable = {}
	self:FindShard(sTable, sbag)
	self:FindSpace(eTable, sbag, Revsort)

	local sLength = table.getn(sTable)
	local eLength = table.getn(eTable)
	local temp = sLength
	if(eLength < temp)then
		temp = eLength
	end
	for i = 1, temp, 1 do
		if(not CursorHasItem())then
			PickupContainerItem(sTable[i][1],sTable[i][2])
			PickupContainerItem(eTable[i][1],eTable[i][2])
		end
	end
	self.Flags.lastSort = GetTime()
end

function ShardAceEngine:FindShard(sTable, sbag)
	local shardbag = sbag
	for bag = 0, 4, 1 do
		local bagname = GetBagName(bag) or ""
		if(bag ~= shardbag and not string.find(bagname, self.Locale["ShardPouch1"]) and not string.find(bagname, self.Locale["ShardPouch2"]) and not string.find(bagname, self.Locale["ShardPouch3"]))then
			local size = GetContainerNumSlots(bag)
			if (size > 0)then
				for slot = 1, size, 1 do
					local _,_,itemID = string.find(GetContainerItemLink(bag,slot) or "", "item:(%d+):%d+:%d+:%d+")
					itemID = tonumber(itemID)
					if (itemID) then
						if itemID == self.Local.SoulshardID then
							tinsert(sTable, {bag, slot})
						end
					end
				end
			end
		end
	end
end

function ShardAceEngine:FindSpace(eTable, sbag, Revsort)
	local shardbag = sbag
	local size = GetContainerNumSlots(shardbag)
	local a, b, c = 1, 1, 1
	
	if(size > 0)then
		if Revsort then
			a = size
			c = -1
		else
			b = size
		end
		for slot = a, b, c do
			local _,_,itemID = string.find(GetContainerItemLink(shardbag,slot) or "", "item:(%d+):%d+:%d+:%d+")
			itemID = tonumber(itemID)
			if (not itemID) then
				tinsert(eTable, {shardbag, slot})
			elseif(itemID ~= self.Local.SoulshardID)then
				tinsert(eTable, {shardbag, slot})
			end
		end
	end
end

function ShardAceEngine:SPELLCAST_START(spell)
	if(spell == self.Spell["Soulstone Resurrection"])then
		self.Flags.resCasting = true
	elseif(spell == self.Spell["Ritual of Summoning"])then
		self.Flags.summonCasting = UnitName("target")
		self:TriggerEvent("ShardAceEngine_SummonStart", self.Flags.summonCasting)
	else
		self.Flags.resCasting = nil
		self.Flags.summonCasting = nil
	end
end

function ShardAceEngine:SPELLCAST_STOP()
	if(self.Flags.UsedHS)then
		self:TriggerEvent("ShardAceEngine_HSEaten")
	elseif(self.Flags.summonCasting)then
		self:TriggerEvent("ShardAceEngine_SummonPortal", self.Flags.summonCasting)
		self.Flags.summonCasting = nil
	end
end

function ShardAceEngine:SPELLCAST_INTERRUPTED()
	if(self.Flags.resCasting)then
		self.Flags.resCasting = nil
	elseif(self.Flags.UsedHS)then
		self.Flags.UsedHS = nil
	end
end

function ShardAceEngine:resWatch(str)
	if(self.Flags.resCasting)then
		local target, spell = self.Deformat(str, AURAADDEDOTHERHELPFUL)
		if not target then
			spell = self.Deformat(str, AURAADDEDSELFHELPFUL)
			target = UnitName("player")
		end
		if spell == self.Spell["Soulstone Resurrection"] then
			self.Flags.resCasting = nil
			self:TriggerEvent("ShardAceEngine_Soulstoned", target)
		end
	end
	local spell = self.Deformat(str, AURAADDEDSELFHELPFUL)
	if spell == self.Spell["Shadow Trance"] then
		self:TriggerEvent("ShardAceEngine_Nightfall")
	end
end

function ShardAceEngine:CastSpell(sN, fC, r) -- spellName(string), fastCast(bool), rank(int)
	if sN then
		if fC then
			if self.Spells.FelDomination then
				if GetSpellCooldown(self.Spells.FelDomination, "spell") == 0 then
					CastSpell(self.Spells.FelDomination, "spell")
					SpellStopCasting()
				end
			end
		end
		if type(self.Spells[sN]) == "table" then
			if r then
				if self.Spells[sN][r] then
					CastSpell(self.Spells[sN][r], "spell")
				end
			else
				CastSpell(self.Spells[sN][getn(self.Spells[sN])], "spell")
			end
		else
			CastSpell(self.Spells[sN], "spell")
		end
		if ( SpellIsTargeting() ) then
			SpellTargetUnit("player")
		end
	end
end

function ShardAceEngine:UseItem(iN) --itemName(string)
	if iN then
		if iN == "Firestone" or iN == "Spellstone" then
			local _,_,itemID = string.find(GetInventoryItemLink("player",GetInventorySlotInfo("SecondaryHandSlot")) or "", "item:(%d+):%d+:%d+:%d+")
			itemID = tonumber(itemID)
			if itemID then
				if not (self.Local.FirestoneID[itemID] or self.Local.SpellstoneID[itemID]) then
					self.Local.OffhandID = itemID
				end
			end
		end
		if self.Items[iN] then
			UseContainerItem(self.Items[iN][1],self.Items[iN][2])
			if iN == "Healthstone" then
				self.Flags.UsedHS = true
			end
		end
	end
end

function ShardAceEngine:SendMsg(msg, chan) -- message(string, message to send), channel(string, channel to send to. SAY, YELL, PARTY, RAID, or custom channel. Can be nil)
	self.Flags.lastMessage = self.Flags.lastMessage or 0
	local delay = GetTime() - self.Flags.lastMessage
	if delay < 0.5 then
		return
	end
	if(msg)then
		if chan then
			chan = strupper(chan)
		end
		if chan == "SAY" or chan == "YELL" then
			SendChatMessage(msg, chan)
		elseif chan == "PARTY" then
			if(UnitExists("party1"))then
				SendChatMessage(msg, chan)
			end
		elseif chan == "RAID" then
			if(UnitExists("raid1"))then
				SendChatMessage(msg, chan)
			end
		elseif chan == "DEFAULT" then
			if(UnitExists("raid1"))then
				SendChatMessage(msg, "RAID")
			elseif(UnitExists("party1"))then
				SendChatMessage(msg, "PARTY")
			end
		elseif chan then
			local  channum
			channum,_ = GetChannelName(chan)
			if channum then
				SendChatMessage(msg, "CHANNEL", nil, channum)
			end
		else		
			if(UnitExists("raid1"))then
				SendChatMessage(msg, "RAID")
			elseif(UnitExists("party1"))then
				SendChatMessage(msg, "PARTY")
			end
		end
	end
	self.Flags.lastMessage = GetTime()
end
