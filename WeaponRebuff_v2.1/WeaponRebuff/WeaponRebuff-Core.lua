--[[ Core Functions -------------------------------------------------------------- ]]
local T = AceLibrary("AceLocale-2.0"):new("WeaponRebuff")

function WeaponRebuff:Rebuff(slot)
    if ( RememberBuff[slot].BuffName and RememberBuff[slot].BuffName ~= "-none-" ) then
		self:Apply(RememberBuff[slot].BuffName,RememberBuff[slot].BuffType,slot);
	else
		UIErrorsFrame:AddMessage(ERROR_NO_BUFFS_REMEMBERED, 0.66, 0.66, 0.86, 1.0, UIERRORS_HOLD_TIME);
	end
end

function WeaponRebuff:Apply(buff,bufftype,invslot)

  RememberBuff[invslot].BuffName = buff;
  RememberBuff[invslot].BuffType = bufftype;

	if ( bufftype == 1 ) then -- charge
		local bag,slot,count = WeaponRebuff:GetBagInfo(buff);
		
		if self.db.profile.wrChargeAlarms == 1 and count < self.db.profile.wrWarnThreshold_BuffItems then
			self:AnnounceMsg(buff.." has only "..count.." charges remaining", 1, 0, 0)
		end
		
		if ( count > 0 ) then
			UseContainerItem(bag,slot);
			if ( SpellIsTargeting() ) then
				PickupInventoryItem(invslot);				
				self:ToggleOff_SuppressAlarm(nil, invslot) -- turn state off, don't suppress 
				if ( self.db.profile.wrSkipReplacePopup == 1 ) then
					ReplaceEnchant();
				end
			end
		end
	elseif ( bufftype == 2 ) then -- spell
		local spellId = WeaponRebuff:GetSpellId(buff)
		if ( spellId > 0 ) then
			CastSpell(spellId,"spell");
			self:ToggleOff_SuppressAlarm(nil, invslot) -- turn state off, don't suppress 
		end
	end
	newDropdown:Hide();
	
	-- ------------------------------------------------------------------
	-- Damned if I can reproduce a mis-named save from one iterative
	-- poison to another but if it'll make Sharky happy...
	WeaponRebuff:SaveVariables()
	-- ------------------------------------------------------------------
	
end

function WeaponRebuff:GetBagInfo(item)
	if ( item == nil or item == "") then
		return -1,-1,-1;
	end
	local itemBag = 0;
  local itemSlot = 0;
  local itemCount = 0;

    for checkbag=4, 0, -1 do
		local size = GetContainerNumSlots(checkbag);
		if (size > 0) then
			for checkslot=1, size, 1 do
				local _, count = GetContainerItemInfo(checkbag, checkslot);
				if (count) then
					local itemName = nil;
					local bagitemname = WeaponRebuff:GetItemName(checkbag, checkslot);
					if (bagitemname ~= nil) then
					if ( bagitemname == item ) then
							itemCount = itemCount + count;
							itemBag = checkbag;
							itemSlot = checkslot;
						end
					end
				end
			end
		end
	end
	return itemBag, itemSlot, itemCount;
end

function WeaponRebuff:GetSpellId(spellName)
	if ( spellName == nil or spellName == "") then
		return;
	end
	local i = 1;
	local spellId = 0;
	local searchName;
	searchName,rankName = GetSpellName(i,"spell");
	while (searchName) do
		if ( searchName == spellName ) then
			spellId = i;
		end
		i = i + 1;
		searchName,rankName = GetSpellName(i,"spell");
	end
	return spellId;
end


--[[ Core Extended  -------------------------------------------------------------- ]]

function WeaponRebuff:GetNameandTime(text)
		local bNmSplit, bChg = 0;
		local bStub = "";
		bNmSplit = string.find(text, " (", 1, 1);

	if( string.find(text, "%(%d+ "..T"WR_CHARGES".."%)") ) then	
		bChg = string.find(text, T"WR_CHARGES"..")", 1, 1);
		bStub = string.sub(text, bChg-5, -1);			
				
		return string.sub(text, 1, bNmSplit), string.sub(text, bNmSplit+2, -1), self:GetFirstNumber(bStub);
	else
		return string.sub(text, 1, bNmSplit), string.sub(text, bNmSplit+2, -1), -1;
	end
	
end

function WeaponRebuff:ItemBuff_UpdateText(slot)

	local bCharges, wrTimeRemaining = 0;	
	local index, field;
	local text, msgText, textToUpdate, slotAlarmState = "";
	local bName, bTime = ""; 
		
--	local slotAlarmState    = getglobal("WeaponRebuff_AlarmState"..slot);
--	local slotSuppressAlarm = getglobal("wr_WepChg_SuppressAlarm"..slot);

	if ( slot == 16 ) then
		textToUpdate = "wrMainhandButtonText";
		msgText = T"WEAPONREBUFF_TRAILINGTEXT_MAINHAND"
		slotAlarmState = wr.alarm.AlarmState16
	elseif ( slot == 17 ) then
		textToUpdate = "wrOffhandButtonText";
		msgText = T"WEAPONREBUFF_TRAILINGTEXT_OFFHAND"
		slotAlarmState = wr.alarm.AlarmState17
	else
		return
	end
	
	local button = getglobal(textToUpdate);	
	
	wrItemTempTooltip:SetInventoryItem("player", slot);

	for index = 16, 6, -1 do -- we find buffs faster on higher-end weapons this way
		field = getglobal("wrItemTempTooltipTextLeft"..index);
	
		if( field ) then
			text = field:GetText();
			if( text ) then				
				if( string.find(text, "%(%d+ "..T"WR_MINUTE".."%)") ) then	
				  -- Bifurcate the incoming data b/c we don't know 
					bName, bTime, bCharges = self:GetNameandTime(text);
					bCharges = tonumber(bCharges);

					if (self.db.profile.wrSoundAlarms_ChargeRemaining == 1 or self.db.profile.wrTextAlarms_ChargeRemaining == 1) then
						if bCharges > 0 then
							if ( bCharges < self.db.profile.wrWarnThreshold_Charges ) then -- below threshold
								if ( self:GetChargeAlarmState_fmSlot(slot) == 0 ) then
									if self.db.profile.wrSoundAlarms_ChargeRemaining == 1 then
										self:PlaySound(self.db.profile.wrSoundIndex_ChargeWarning)
									end
							
									if self.db.profile.wrTextAlarms_ChargeRemaining == 1 then
										self:AnnounceMsg(bName..T"WEAPONREBUFF_MSG_LOWONGHARGES"..msgText, 1, 1, 0)
									end
																	
									self:SetChargeAlarmState_fmSlot(1, slot)
								end
							else
								-- charges > threshold
								self:SetChargeAlarmState_fmSlot(0, slot)
							end
						end  
					end
					-- only set this forward if we have a good buff						
					if slotAlarmState ~= "TickingDown" then
						self:SetAlarmState_fmSlot("TickingDown", slot)
					end

					self:ToggleOff_SuppressAlarm(nil, slot) -- disable suppression
					
					-- grab the number if it's there... --------------------------------------------
					wrTimeRemaining = self:GetFirstNumber(bTime)
					self:SetPluginData_fmSlot(slot, wrTimeRemaining, "m", wrColor.green, text);
					-- -----------------------------------------------------------------------------
					
					if self.db.profile.wrEnableShowText == 1 then										
						button:SetTextColor(0.5, 0.5, 0.9);
						button:SetText(text);
					else
						button:SetText("");
					end
								
					return;
				elseif( string.find(text, "%(%d+ "..T"WR_SECOND".."%)") ) then			
				  -- Bifrucate the incoming data b/c we don't know 
					bName, bTime, _ = self:GetNameandTime(text)
										
					-- grab the number if it's there... --------------------------------------------
					wrTimeRemaining = self:GetFirstNumber(bTime)
					self:SetPluginData_fmSlot(slot, wrTimeRemaining, "s", wrColor.yellow, text);
					-- -----------------------------------------------------------------------------

					-- Alarms
					if slotAlarmState ~= "WarningSounded" then
						if tonumber(wrTimeRemaining) < tonumber(self.db.profile.wrWarnThreshold_inSeconds) then
							if slotSuppressAlarm then
								self:ToggleOff_SuppressAlarm(nil, slot) -- turn state off
							else
								if self.db.profile.wrSoundAlarms == 1 then
									if self.db.profile.wrUseCustomSounds == 1 then
										self:PlaySound(9) -- static warning.wav
									else
										self:PlaySound(self.db.profile.wrSoundIndex_BuffWarning)
									end
								end
								
								if self.db.profile.wrTextAlarms == 1 then
									self:AnnounceMsg(bName..T"WEAPONREBUFF_MSG_BUFFABOUTTOEXPIRE"..msgText, 1, 1, 0);				
								end
							end
							
							self:SetAlarmState_fmSlot("WarningSounded", slot);
						
						end	
					end	
					
					if self.db.profile.wrEnableShowText == 1 then
						button:SetTextColor(1, 0, 0);
						button:SetText(text);
					else
						button:SetText("");
					end

					return
				end
			end	
		end
	end
	
	-- If we're still here, we've no buffs		
	self:SetPluginData_fmSlot(slot, "-", "", wrColor.red, "<<"..RememberBuff[slot].BuffName..">>")
	
	if slotAlarmState ~= "Sleeping" then
		if slotSuppressAlarm then
			self:ToggleOff_SuppressAlarm(nil, slot) -- turn state off
		else
			-- Alarms
			if self.db.profile.wrSoundAlarms == 1 then
				if self.db.profile.wrUseCustomSounds == 1 then
					self:PlaySound(10) -- static lost.wav
				else
					self:PlaySound(self.db.profile.wrSoundIndex_BuffLost)
				end
			end
			
			if self.db.profile.wrTextAlarms == 1 then						
				self:AnnounceMsg("***"..T"WEAPONREBUFF_MSG_BUFFEXPIRED"..msgText.."***", 1, 0, 0)
			end
		end
		
		self:SetAlarmState_fmSlot("Sleeping", slot)
	end	
	
	if self.db.profile.wrEnableShowText == 1 then
		button:SetTextColor(1, 0, 0);
		if ( RememberBuff[slot].BuffName and self.db.profile.wrDisableRememberBuffText == 0 ) then		
			button:SetText("<<"..RememberBuff[slot].BuffName..">>");
		else
			button:SetText("");
		end
	else
		button:SetText("");
	end

end

function WeaponRebuff:SavePosition()
	local left = WeaponBuffBar:GetLeft();
	local bottom = WeaponBuffBar:GetBottom();
    WeaponBuffBar:ClearAllPoints();
    WeaponBuffBar:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", left, bottom);
end

function WeaponRebuff:UpdateTextures()
	if ( self.db.profile.wrInvisibleAddon == 0 ) then
        wrMainhandButton:Show();
        wrOffhandButton:Show();
        wrMainhandButton:SetNormalTexture(GetInventoryItemTexture("player", 16));
        if ( self.db.profile.wrDisableOffhandButton == 0 and GetInventoryItemTexture("player", 17) ) then
        	wrOffhandButton:SetNormalTexture(GetInventoryItemTexture("player", 17));
        else
          wrOffhandButton:Hide();
        end
    else
	    wrMainhandButton:Hide();
	    wrOffhandButton:Hide();
    end
end

-- function WeaponRebuff:OnUpdate(elapsed)
-- 
-- 	wrLastUpdate = GetTime() + elapsed;
-- 	if WeaponBuffBar:IsVisible() and MouseIsOver(WeaponBuffBar) then
-- 		wrlastFlag = GetTime();
-- 	end
-- 	
-- 	if ( wrLastUpdate - wrlastFlag > 2 ) then
-- 		newDropdown:Hide();
-- 	end
-- end


function WeaponRebuff:GetFirstNumber(text)
	local w = 0;
	for w in string.gfind(text, "%d+") do
		return tonumber(w)
	end
	return w
end			

--[[ End Core Functions -------------------------------------------------------------- ]]