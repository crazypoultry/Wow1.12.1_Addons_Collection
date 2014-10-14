ShardAce = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "Metrognome-2.0")

function ShardAce:OnInitialize()
	self.Spell = AceLibrary("Babble-Spell-2.0")
	self.Class = AceLibrary("Babble-Class-2.0")
	self.Zone = AceLibrary("Babble-Zone-2.0")
	self.Locals = ShardAceLocals
	ShardAceLocals = nil
	self.Timers = {}
	self:RegisterDB("ShardAceDB")
	self:RegisterDefaults('profile', {
		shardBag = 0,
		SummonMsg1 = self.Locals.SummonMsg1,
		SummonMsg2 = self.Locals.SummonMsg2,
		SoulstoneMsg = self.Locals.SoulMsg,
		ShowMsgSum1 = true,
		ShowMsgSum2 = nil,
		ShowMsgSS = true,
		Threshold = 5,
		AutoSort = true,
		ReverseSort = nil,
		playSound = true,
		hsTrade = true,
		ButtonPosition = "farleft",
		ButtonFormation = "leftcurve",
		SummonerPosition = "left",
		SummonMsg1Chan = "default",
		SummonMsg2Chan = "default",
		SoulstoneMsgChan = "default",
	})
	self:RegisterChatCommand(self.Locals.Commands, self.Locals.Options)

end

function ShardAce:OnEnable()
	if(UnitClass("player") == self.Class["Warlock"])then
		self:RegisterEvent("ShardAceEngine_SpellBookScanned")
		self:RegisterEvent("ShardAceEngine_SummonStart")
		self:RegisterEvent("ShardAceEngine_SummonPortal")
		self:RegisterEvent("ShardAceEngine_Soulstoned")
		self:RegisterEvent("ShardAceEngine_Nightfall")
		self:RegisterEvent("TRADE_SHOW")
	
		self:RegisterMetro("ShardAceTrade", ShardAce.AcceptTrade, 3, ShardAce)
		self:RegisterMetro("ShardAceSS", ShardAce.UpdateSS, 1, ShardAce)
		
		ShardAceCount:Show()
		ShardAceSoul:Show()
		ShardAceStone:Show()
		ShardAceHealth:Show()
		ShardAceSoul_Text:Hide()
		ShardAceStone_Text:Hide()
		
		self:ShardAceEngine_SpellBookScanned()
		
		self.Timers.SoulTimer = self.db.profile.SoulTime
		if self.Timers.SoulTimer then
			if self.Timers.SoulTimer < time() then
				self.Timers.SoulTimer = nil
				self.db.profile.SoulTime = nil
			end
		end
	end
	ShardAceHealth_Text:Hide()	
	ShardAce_Summoner:Hide()


	self:RegisterEvent("ShardAceEngine_HSEaten")
	self:RegisterEvent("ShardAceEngine_InventoryScanned")
	
	self:RegisterMetro("ShardAceHS", ShardAce.UpdateHS, 1, ShardAce)
	
	if self.Timers.SoulTimer then
		self:StartMetro("ShardAceSS")
		self:UpdateSSButton()
	end
	local HStimer = self.db.profile.HealthTime
	if HStimer then
		if HStimer > time() then
			self.Timers.HealthTimer = HStimer
			self:StartMetro("ShardAceHS")
			self:UpdateHSButton()
		else
			self.Timers.HealthTimer = nil
			self.db.profile.HealthTime = nil
		end
	end
	self:MoveButtons()
end

function ShardAce:OnDisable()

end

function ShardAce:OnProfileEnable()
	self:MoveButtons()
	self:UpdateButtons()
end

function ShardAce:CountClick(button)
	if button == "LeftButton" then
		ShardAceEngine:SortShards(self:getShardBag(), self:getReverseSortState())
	elseif button == "RightButton" then
		ShardAceEngine:CastSpell("DemonBuff")
	end
end

function ShardAce:SoulClick(button)
	if (button == "LeftButton" and ShardAceEngine.Spells.Soulstone) then
		if ShardAceEngine.Items.Soulstone then
			ShardAceEngine:UseItem("Soulstone")
		else
			ShardAceEngine:CastSpell("Soulstone")
		end
	elseif (button == "RightButton" and ShardAceEngine.Spells.Mount) then
		if (GetRealZoneText()==self.Zone["Ahn'Qiraj"] and ShardAceEngine.Items.AQBugMount) then
			ShardAceEngine:UseItem("AQBugMount")
		else
			ShardAceEngine:CastSpell("Mount")
		end
	end
end

function ShardAce:StoneClick(button)
	if (button == "LeftButton" and ShardAceEngine.Spells.Spellstone) then
		if ShardAceEngine.Items.Spellstone then
			ShardAceEngine:UseItem("Spellstone")
			self.SpSEquip = true
		elseif self.SpSEquip then
			if GetInventoryItemCooldown("player", GetInventorySlotInfo("SecondaryHandSlot")) == 0 then
				UseInventoryItem(GetInventorySlotInfo("SecondaryHandSlot"))
				self.SpSEquip = nil
			elseif ShardAceEngine.Items.Offhand then
				ShardAceEngine:UseItem("Offhand")
				self.SpSEquip = nil
			end
		elseif ShardAceEngine.Items.Offhand then
			ShardAceEngine:UseItem("Offhand")
		else
			ShardAceEngine:CastSpell("Spellstone")
		end
	elseif (button == "RightButton" and ShardAceEngine.Spells.Firestone) then
		if ShardAceEngine.Items.Firestone then
			ShardAceEngine:UseItem("Firestone")
		elseif ShardAceEngine.Items.Offhand then
			ShardAceEngine:UseItem("Offhand")
		else
			ShardAceEngine:CastSpell("Firestone")
		end
	end
end

function ShardAce:HealthClick(button)
	if(UnitClass("player") == self.Class["Warlock"])then
		if (button == "LeftButton" and ShardAceEngine.Spells.Healthstone) then
			-- Sari added: copied ShardTrackerNCS code to initiate healthstone trade with added TradeDistanceCheck (and TimexTimer)
			if not ShardAceEngine.Items.Healthstone then
				ShardAceEngine:CastSpell("Healthstone")
			elseif (UnitIsPlayer("target") and (UnitIsFriend("player","target"))) then
				if (not UnitCanCooperate("player", "target")) then
					-- add message "can't cooperate"
					DEFAULT_CHAT_FRAME:AddMessage(UnitName("target")..' cannot cooperate.', 1.0, 1.0, 0.5);
				elseif (not CheckInteractDistance("target",2)) then
					-- add message "unit too far away"
					DEFAULT_CHAT_FRAME:AddMessage(UnitName("target")..' is too far away.', 1.0, 1.0, 0.5);
				elseif (ShardAceEngine.Items.Healthstone and self:getHSTradeState()) then
					-- pickup the healthstone and drop it on the target
					PickupContainerItem(ShardAceEngine.Items.Healthstone[1],ShardAceEngine.Items.Healthstone[2])
					if ( CursorHasItem() ) then
						DropItemOnUnit("target")
						self:StartMetro("ShardAceTrade")
					end
				end
			elseif ((UnitHealth("player") < UnitHealthMax("player")) and GetContainerItemCooldown(ShardAceEngine.Items.Healthstone[1],ShardAceEngine.Items.Healthstone[2]) == 0) then
				-- use healthstone self
				ShardAceEngine:UseItem("Healthstone")
			end
		elseif button == "RightButton" then
			self:ShowSummons()
		end
	else
		if (button == "LeftButton") then
			if ((UnitHealth("player") < UnitHealthMax("player")) and GetContainerItemCooldown(ShardAceEngine.Items.Healthstone[1], ShardAceEngine.Items.Healthstone[2]) == 0) then
				-- use healthstone self
				ShardAceEngine:UseItem("Healthstone")
			end
		end
	end
end

function ShardAce:AcceptTrade()
	AcceptTrade()
	self:StopMetro("ShardAceTrade")
end

function ShardAce:TRADE_SHOW()
	TargetUnit("NPC")
end

function ShardAce:ShowSummons()
	if(ShardAce_Summoner:IsVisible())then
		ShardAce_Summoner:Hide()
	else
		ShardAce_Summoner:Show()
	end
end

function ShardAce:Cast(button, spellName)
	local fc = nil
	if button == "RightButton" then
		fc = true
	end
	if spellName then
		ShardAceEngine:CastSpell(spellName, fc)
	end
	if spellName ~= "FelDomination" then
		ShardAce_Summoner:Hide()
	end
end

function ShardAce:ShowTooltip(spellName)
	if spellName then
		GameTooltip:SetOwner(ShardAce_Summoner, "ANCHOR_TOPRIGHT")
		GameTooltip:SetText(spellName, 1, 1, 1)
		GameTooltip:Show()
	end
end

function ShardAce:ShardAceEngine_SummonStart(target)
	if self:getPreSummonMessageState() then
		ShardAceEngine:SendMsg(format(self:getPreSummonMessage(), target), self:getPreSummonMessageChannel())
	end
end

function ShardAce:ShardAceEngine_SummonPortal(target)
	if self:getSummonMessageState() then
		ShardAceEngine:SendMsg(format(self:getSummonMessage(), target), self:getSummonMessageChannel())
	end
end

function ShardAce:ShardAceEngine_Soulstoned(target)
	if self:getSoulstoneMessageState() then
		ShardAceEngine:SendMsg(format(self:getSoulstoneMessage(), target), self:getSoulstoneMessageChannel())
	end
	self.Timers.SoulTimer = time() + 1800
	self.db.profile.SoulTime = self.Timers.SoulTimer
	self:UpdateSSButton()
	self:StartMetro("ShardAceSS")
end

function ShardAce:UpdateSSButton()
	ShardAceSoul:SetNormalTexture("Interface\\AddOns\\ShardAce\\Images\\ShardAceBlank")
	ShardAceSoul_Text:Show()
	ShardAceSoul_Text:SetText(floor((self.Timers.SoulTimer - time())/60))
end

function ShardAce:UpdateSS()
	local timeleft = self.Timers.SoulTimer - time()
	if(timeleft > 60)then
		ShardAceSoul_Text:SetText((floor(timeleft / 60)) +1)
	else
		ShardAceSoul_Text:SetText(timeleft)
	end
	
	if(timeleft < 1)then
		self.Timers.SoulTimer = nil
		ShardAceSoul_Text:Hide()
		self:UpdateButtons()
		if self:getSoundState() then
			PlaySoundFile("Interface\\AddOns\\ShardAce\\Sounds\\Soulstone.mp3")
		end
		self.db.profile.SoulTime = nil
		self:StopMetro("ShardAceSS")
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00** Soulstone Cooldown over, ready to use **|r")
		UIErrorsFrame:AddMessage("** Soulstone Cooldown over, ready to use **", 0.92, 0.75, 0.05, 1.0, 12)
	end
end

function ShardAce:ShardAceEngine_Nightfall()
	if self:getSoundState() then
		PlaySoundFile("Interface\\AddOns\\ShardAce\\Sounds\\ShadowTrance.mp3")
	end
end

function ShardAce:ShardAceEngine_HSEaten()
	self.Timers.HealthTimer = time() + 120
	self.db.profile.HealthTime = self.Timers.HealthTimer
	self:StartMetro("ShardAceHS")
	self:UpdateHSButton()
end

function ShardAce:UpdateHSButton()
	ShardAceHealth:SetNormalTexture("Interface\\AddOns\\ShardAce\\Images\\ShardAceBlank")
	ShardAceHealth_Text:Show()
	ShardAceHealth_Text:SetText(floor((self.Timers.HealthTimer - time())/60))
end

function ShardAce:UpdateHS()	
	local timeleft = self.Timers.HealthTimer - time()
	if(timeleft > 60)then
		ShardAceHealth_Text:SetText((floor(timeleft / 60)) +1)
	else
		ShardAceHealth_Text:SetText(timeleft)
	end
	
	if(timeleft < 1)then
		self.Timers.HealthTimer = nil
		ShardAceHealth_Text:Hide()
		self:UpdateButtons()
		self.db.profile.HealthTime = nil
		self:StopMetro("ShardAceHS")
	end
end

function ShardAce:ShardAceEngine_InventoryScanned()
	self:UpdateButtons()
	if self:getAutoSortState() then
		ShardAceEngine:SortShards(self:getShardBag(), self:getReverseSortState())
	end
end

function ShardAce:ShardAceEngine_SpellBookScanned()
	ShardAce_Summoner_Button1:Hide()
	ShardAce_Summoner_Button2:Hide()
	ShardAce_Summoner_Button3:Hide()
	ShardAce_Summoner_Button4:Hide()
	ShardAce_Summoner_Button5:Hide()
	ShardAce_Summoner_Button6:Hide()
	ShardAce_Summoner_Button7:Hide()
	ShardAce_Summoner_Button8:Hide()
	ShardAce_Summoner_Button9:Hide()
	ShardAce_Summoner_Button10:Hide()
	ShardAce_Summoner_Button11:Hide()
	ShardAce_Summoner_Button12:Hide()
	ShardAce_Summoner_Button13:Hide()
	ShardAce_Summoner_Button14:Hide()
	ShardAce_Summoner_Button15:Hide()

	if(ShardAceEngine.Spells.FelDomination)then
		ShardAce_Summoner_Button1:Show()
	end

	if(ShardAceEngine.Spells.Imp)then
		ShardAce_Summoner_Button2:Show()
	end

	if(ShardAceEngine.Spells.Voidwalker)then
		ShardAce_Summoner_Button3:Show()
	end

	if(ShardAceEngine.Spells.Succubus)then
		ShardAce_Summoner_Button4:Show()
	end

	if(ShardAceEngine.Spells.Felhunter)then
		ShardAce_Summoner_Button5:Show()
	end

	if(ShardAceEngine.Spells.Infernal)then
		ShardAce_Summoner_Button6:Show()
	end

	if(ShardAceEngine.Spells.CurseofDoom)then
		ShardAce_Summoner_Button7:Show()
	end

	if(ShardAceEngine.Spells.Doomguard)then
		ShardAce_Summoner_Button8:Show()
	end
	
	if(ShardAceEngine.Spells.Enslave)then
		ShardAce_Summoner_Button9:Show()
	end
	
	if(ShardAceEngine.Spells.Eye)then
		ShardAce_Summoner_Button10:Show()
	end

	if(ShardAceEngine.Spells.Port)then
		ShardAce_Summoner_Button11:Show()
	end
	
	if(ShardAceEngine.Spells.Sacrifice)then
		ShardAce_Summoner_Button12:Show()
	end
	
	if(ShardAceEngine.Spells.Tracking)then
		ShardAce_Summoner_Button13:Show()
	end
	
	if(ShardAceEngine.Spells.Breath)then
		ShardAce_Summoner_Button14:Show()
	end
	
	if ShardAceEngine.Spells.DetectInvis then
		if(ShardAceEngine.Spells.DetectInvis[1])then
			ShardAce_Summoner_Button15:Show()
		end
	end
end

function ShardAce:UpdateButtons()
	if ShardAceEngine.Items.ShardCount <= self:getThreshold() then
		ShardAceCount_Text:SetTextColor(1, 0, 0)
	else
		ShardAceCount_Text:SetTextColor(0, 1, 0)
	end
	ShardAceCount_Text:SetText(ShardAceEngine.Items.ShardCount)
	
	if self.Timers.HealthTimer then
		ShardAceHealth:SetNormalTexture("Interface\\AddOns\\ShardAce\\Images\\ShardAceBlank")
	elseif ShardAceEngine.Items.Healthstone then
		ShardAceHealth:SetNormalTexture("Interface\\AddOns\\ShardAce\\Images\\ShardAceHealth")
		if UnitClass("player") ~= self.Class["Warlock"] then
			ShardAceHealth:Show()
		end
	else
		ShardAceHealth:SetNormalTexture("Interface\\AddOns\\ShardAce\\Images\\ShardAceHealthGrey")
		if UnitClass("player") ~= self.Class["Warlock"] then
			ShardAceHealth:Hide()
		end
	end
	if self.Timers.SoulTimer then
		ShardAceSoul:SetNormalTexture("Interface\\AddOns\\ShardAce\\Images\\ShardAceBlank")
	elseif ShardAceEngine.Items.Soulstone then
		ShardAceSoul:SetNormalTexture("Interface\\AddOns\\ShardAce\\Images\\ShardAceSoul")
	else
		ShardAceSoul:SetNormalTexture("Interface\\AddOns\\ShardAce\\Images\\ShardAceSoulGrey")
	end
	if ShardAceEngine.Items.Firestone or ShardAceEngine.Items.Spellstone then
		if ShardAceEngine.Items.Firestone and ShardAceEngine.Items.Spellstone then
			ShardAceStone:SetNormalTexture("Interface\\AddOns\\ShardAce\\Images\\ShardAceSpell")
		else
			ShardAceStone:SetNormalTexture("Interface\\AddOns\\ShardAce\\Images\\ShardAceSpellHalf")
		end
	else
		ShardAceStone:SetNormalTexture("Interface\\AddOns\\ShardAce\\Images\\ShardAceSpellGrey")
	end
end

function ShardAce:FixMsgString(msg)
	local deNoobString,_ = string.gsub(msg, "%%t", "%%s")
	return deNoobString
end

function ShardAce:MoveButtons()
	local formation = self:getMinimapButtonFormation()
	if formation == "leftcurve" then
		ShardAceSoul:ClearAllPoints()
		ShardAceSoul:SetPoint("CENTER", "ShardAceCount", "CENTER", -5, -24)
		ShardAceStone:ClearAllPoints()
		ShardAceStone:SetPoint("CENTER", "ShardAceCount", "CENTER", -2, -49)
		ShardAceHealth:ClearAllPoints()
		ShardAceHealth:SetPoint("CENTER", "ShardAceCount", "CENTER", 9, -72)
	elseif formation == "rightcurve" then
		ShardAceSoul:ClearAllPoints()
		ShardAceSoul:SetPoint("CENTER", "ShardAceCount", "CENTER", 5, -24)
		ShardAceStone:ClearAllPoints()
		ShardAceStone:SetPoint("CENTER", "ShardAceCount", "CENTER", 2, -49)
		ShardAceHealth:ClearAllPoints()
		ShardAceHealth:SetPoint("CENTER", "ShardAceCount", "CENTER", -9, -72)
	elseif formation == "horizontal" then
		ShardAceSoul:ClearAllPoints()
		ShardAceSoul:SetPoint("LEFT", "ShardAceCount", "RIGHT", 0, 0)
		ShardAceStone:ClearAllPoints()
		ShardAceStone:SetPoint("LEFT", "ShardAceSoul", "RIGHT", 0, 0)
		ShardAceHealth:ClearAllPoints()
		ShardAceHealth:SetPoint("LEFT", "ShardAceStone", "RIGHT", 0, 0)
	elseif formation == "vertical" then
		ShardAceSoul:ClearAllPoints()
		ShardAceSoul:SetPoint("TOP", "ShardAceCount", "BOTTOM", 0, 0)
		ShardAceStone:ClearAllPoints()
		ShardAceStone:SetPoint("TOP", "ShardAceSoul", "BOTTOM", 0, 0)
		ShardAceHealth:ClearAllPoints()
		ShardAceHealth:SetPoint("TOP", "ShardAceStone", "BOTTOM", 0, 0)
	elseif formation == "square" then
		ShardAceSoul:ClearAllPoints()
		ShardAceSoul:SetPoint("LEFT", "ShardAceCount", "RIGHT", 0, 0)
		ShardAceStone:ClearAllPoints()
		ShardAceStone:SetPoint("TOP", "ShardAceCount", "BOTTOM", 0, 0)
		ShardAceHealth:ClearAllPoints()
		ShardAceHealth:SetPoint("LEFT", "ShardAceStone", "RIGHT", 0, 0)
	elseif formation == "diamond" then
		ShardAceSoul:ClearAllPoints()
		ShardAceSoul:SetPoint("TOPRIGHT", "ShardAceCount", "BOTTOMLEFT", 0, 0)
		ShardAceStone:ClearAllPoints()
		ShardAceStone:SetPoint("TOPLEFT", "ShardAceCount", "BOTTOMRIGHT", 0, 0)
		ShardAceHealth:ClearAllPoints()
		ShardAceHealth:SetPoint("TOPRIGHT", "ShardAceStone", "BOTTOMLEFT", 0, 0)
	end
	local summonPos = self:getSummonMenuPosition()
	if summonPos == "left" then
		ShardAce_Summoner:ClearAllPoints()
		ShardAce_Summoner:SetPoint("RIGHT", "ShardAceHealth", "LEFT", 0, 0)
	elseif summonPos == "right" then
		ShardAce_Summoner:ClearAllPoints()
		ShardAce_Summoner:SetPoint("LEFT", "ShardAceHealth", "RIGHT", 0, 0)
	elseif summonPos == "top" then
		ShardAce_Summoner:ClearAllPoints()
		ShardAce_Summoner:SetPoint("BOTTOM", "ShardAceHealth", "TOP", 0, 0)
	elseif summonPos == "bottom" then
		ShardAce_Summoner:ClearAllPoints()
		ShardAce_Summoner:SetPoint("TOP", "ShardAceHealth", "BOTTOM", 0, 0)
	end
	local buttonPos = self:getMinimapButtonPosition()
	if buttonPos == "wayoutleft" then
		ShardAceCount:ClearAllPoints()
		ShardAceCount:SetPoint("CENTER", "Minimap", "CENTER", -116, 15)
	elseif buttonPos == "farleft" then
		ShardAceCount:ClearAllPoints()
		ShardAceCount:SetPoint("CENTER", "Minimap", "CENTER", -98, 20)
	elseif buttonPos == "closeleft" then
		ShardAceCount:ClearAllPoints()
		ShardAceCount:SetPoint("CENTER", "Minimap", "CENTER", -80, 25)
	elseif buttonPos == "wayoutright" then
		ShardAceCount:ClearAllPoints()
		ShardAceCount:SetPoint("CENTER", "Minimap", "CENTER", 116, 15)
	elseif buttonPos == "farright" then
		ShardAceCount:ClearAllPoints()
		ShardAceCount:SetPoint("CENTER", "Minimap", "CENTER", 98, 20)
	elseif buttonPos == "closeright" then
		ShardAceCount:ClearAllPoints()
		ShardAceCount:SetPoint("CENTER", "Minimap", "CENTER", 80, 25)
	elseif buttonPos == "custom" then
		ShardAceCount:ClearAllPoints()
		ShardAceCount:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", self.db.profile.CustomX, self.db.profile.CustomY)
	end
end


--------------------------------------------------------------------------------------------------------------------
function ShardAce:getThreshold()
	return self.db.profile.Threshold
end

function ShardAce:setThreshold(v)
	self.db.profile.Threshold = v
end

function ShardAce:getHSTradeState()
	return self.db.profile.hsTrade
end

function ShardAce:setHSTradeState()
	self.db.profile.hsTrade = not self.db.profile.hsTrade
end

function ShardAce:getSoundState()
	return self.db.profile.playSound
end

function ShardAce:setSoundState()
	self.db.profile.playSound = not self.db.profile.playSound
end

function ShardAce:getSoulstoneMessage()
	return self.db.profile.SoulstoneMsg
end

function ShardAce:setSoulstoneMessage(s)
	self.db.profile.SoulstoneMsg = self:FixMsgString(s)
end

function ShardAce:getSummonMessage()
	return self.db.profile.SummonMsg1
end

function ShardAce:setSummonMessage(s)
	self.db.profile.SummonMsg1 = self:FixMsgString(s)
end

function ShardAce:getPreSummonMessage()
	return self.db.profile.SummonMsg2
end

function ShardAce:setPreSummonMessage(s)
	self.db.profile.SummonMsg2 = self:FixMsgString(s)
end

function ShardAce:getShardBag()
	return self.db.profile.shardBag
end

function ShardAce:setShardBag(v)
	self.db.profile.shardBag = v
end

function ShardAce:getAutoSortState()
	return self.db.profile.AutoSort
end

function ShardAce:setAutoSortState()
	self.db.profile.AutoSort = not self.db.profile.AutoSort
end

function ShardAce:getReverseSortState()
	return self.db.profile.ReverseSort
end

function ShardAce:setReverseSortState()
	self.db.profile.ReverseSort = not self.db.profile.ReverseSort
end

function ShardAce:getMinimapButtonPosition()
	return self.db.profile.ButtonPosition
end

function ShardAce:setMinimapButtonPosition(s)
	self.db.profile.ButtonPosition = s
	self:MoveButtons()
end

function ShardAce:getSummonMenuPosition()
	return self.db.profile.SummonerPosition
end

function ShardAce:setSummonMenuPosition(s)
	self.db.profile.SummonerPosition = s
	self:MoveButtons()
end

function ShardAce:getMinimapButtonFormation()
	return self.db.profile.ButtonFormation
end

function ShardAce:setMinimapButtonFormation(s)
	self.db.profile.ButtonFormation = s
	self:MoveButtons()
end

function ShardAce:setCursorPosition()
	self.db.profile.ButtonPosition = "custom"
	local x,y = GetCursorPosition(UIParent)
	self.db.profile.CustomX = x/UIParent:GetEffectiveScale()
	self.db.profile.CustomY = y/UIParent:GetEffectiveScale()
	self:MoveButtons()
end

function ShardAce:getSummonMessageState()
	return self.db.profile.ShowMsgSum1
end

function ShardAce:setSummonMessageState()
	self.db.profile.ShowMsgSum1 = not self.db.profile.ShowMsgSum1
end

function ShardAce:getPreSummonMessageState()
	return self.db.profile.ShowMsgSum2
end

function ShardAce:setPreSummonMessageState()
	self.db.profile.ShowMsgSum2 = not self.db.profile.ShowMsgSum2
end

function ShardAce:getSoulstoneMessageState()
	return self.db.profile.ShowMsgSS
end

function ShardAce:setSoulstoneMessageState()
	self.db.profile.ShowMsgSS = not self.db.profile.ShowMsgSS
end

function ShardAce:getSoulstoneMessageChannel()
	return self.db.profile.SoulstoneMsgChan
end

function ShardAce:setSoulstoneMessageChannel(s)
	self.db.profile.SoulstoneMsgChan = s
end

function ShardAce:getSummonMessageChannel()
	return self.db.profile.SummonMsg1Chan
end

function ShardAce:setSummonMessageChannel(s)
	self.db.profile.SummonMsg1Chan = s
end

function ShardAce:getPreSummonMessageChannel()
	return self.db.profile.SummonMsg2Chan
end

function ShardAce:setPreSummonMessageChannel(s)
	self.db.profile.SummonMsg2Chan = s
end

function ShardAce:setGlobalMessageChannel(s)
	self:setSoulstoneMessageChannel(s)
	self:setSummonMessageChannel(s)
	self:setPreSummonMessageChannel(s)
end
