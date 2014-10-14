OneRaid.Unit 		= { 
	frames 			= {},
	data 			= {},
	icons 			= {
		["None"]	= 0,
		["Star"]	= 1,
		["Circle"]	= 2,
		["Diamond"]	= 3,
		["Triangle"]= 4,
		["Moon"]	= 5,
		["Square"]	= 6,
		["Cross"]	= 7,
		["Skull"]	= 8,
	},
};

function OneRaid.Unit:OnLoad()

	this:RegisterForClicks("LeftButtonDown", "RightButtonDown");

end

function OneRaid.Unit:OnShow()

	if (not this.tankMonitor) then
		self:RegisterEvents(this);
		
		if (this.unit) then
			self:UpdateName(this);
			self:UpdateHealth(this);
			self:UpdateMana(this);
			self:UpdateBuffs(this);
			self:UpdatePvp(this);
			self:UpdateTarget(this);
			self:UpdateVoice(this);
			self:UpdateTargetIcon(this);
		end
	end
	
end

function OneRaid.Unit:OnHide()

	if (not this.tankMonitor) then
		self:UnregisterEvents(this);
	end

end	

function OneRaid.Unit:OnEvent()

	if (type(self[event] == "function") and self[event]) then
        self[event](self);
    else
        self:Print("Unhandled event: " .. event, 1, 0, 0);
    end
	
end

function OneRaid.Unit:OnUpdate(elapsed)

	local style = OneRaid_Options.UnitStyles[this.style];
	
	this.elapsed = (this.elapsed) or 0;
	
	if (this.elapsed > .5) then
		this.elapsed = 0;

		self:UpdateRange(this);
		
		if (style.flashOnLowHealth and (UnitHealth(this.unit) / UnitHealthMax(this.unit) * 100) <= style.flashOnLowHealth and
			not UnitIsDeadOrGhost(this.unit)) then
			UIFrameFlash(this, .15, .15, .3, 1);
		end

	else
		this.elapsed = this.elapsed + elapsed;
	end
	
	if (self.data[this.name]) then
		if (self.data[this.name].rezzed and self.data[this.name].rezzed <= GetTime()) then
			self.data[this.name].rezzed = nil;
			for k, v in OneRaid.Unit.frames do
				if (v.name == this.name) then
					self:UpdateStatus(v);
				end
			end
		end
		if (self.data[this.name].summoned and self.data[this.name].summoned <= GetTime()) then
		    self.data[this.name].summoned = nil;
		    for k, v in OneRaid.Unit.frames do
		    	if (v.name == this.name) then
		    		self:UpdateStatus(v);
		    	end
		    end
		end
	end
	
	if (this == OneRaid.mouseoverUnit) then
		self:OnEnter();
	end
	
end

function OneRaid.Unit:Buff_OnUpdate(elapsed) 

	if (this == OneRaid.mouseoverBuff) then
		self:Buff_OnEnter();
	end
	
end

function OneRaid.Unit:OnClick()
	
	local alt, shift, ctrl = IsAltKeyDown(), IsShiftKeyDown(), IsControlKeyDown();

	if (arg1 == "LeftButton") then
		if (OneRaid.movePlayer and OneRaid.moveKeys and
		 	OneRaid.moveKeys.alt == alt and OneRaid.moveKeys.shift == shift and OneRaid.moveKeys.ctrl == ctrl) then
			
			OneRaid:AddonMessage("SWAP", OneRaid.movePlayer, UnitName(this.unit));
			OneRaid.movePlayer = nil;
			OneRaid.moveKeys = nil;
		else
			local clickType;
					
			if (alt and shift and ctrl) then
				clickType = 8;
			elseif (shift and ctrl) then
				clickType = 7;
			elseif (alt and ctrl) then
				clickType = 6;
			elseif (alt and shift) then
				clickType = 5;
			elseif (ctrl) then
				clickType = 4;
			elseif (shift) then
				clickType = 3;
			elseif (alt) then
				clickType = 2;
			else
				clickType = 1;
			end
			
			local type = OneRaid_Options.UnitStyles[this.style].keybindings[clickType].type;
	
			if (type == 1) then
				return;
			elseif (type == 2) then
				TargetUnit(this.unit);
				return;
			elseif (type == 3) then
				AssistUnit(this.unit);
				if (OneRaid_Options.UnitStyles[this.style].keybindings[clickType].attack) then
					OneRaid:Timer(.3, nil, AttackTarget);
				end
				return;
			elseif (type == 4) then
				OneRaid.movePlayer = UnitName(this.unit);
				OneRaid.moveKeys = { alt = alt, shift = shift, ctrl = ctrl };
				return;
			elseif (type == 5) then
				local tank = nil;
				for k, v in OneRaid.tanks or {} do
					if (v == UnitName(this.unit)) then
						tank = 1;
						break;
					end
				end
				if (tank) then
					OneRaid:AddonMessage("TANK", "rem", UnitName(this.unit));
				else
					OneRaid:AddonMessage("TANK", "add", UnitName(this.unit));
				end
				return;
			elseif (type == 6) then
				if (OneRaid.mainAssist == UnitName(this.unit)) then
					OneRaid:AddonMessage("MA", "clear");
				else
					OneRaid:AddonMessage("MA", UnitName(this.unit));
				end
				return;
			elseif (type == 7) then
				OneRaid:CureDebuffs(this.unit);
				return;
			elseif (type == 8) then
				TargetUnit(this.unit);
				CastSpellByName(OneRaid_Options.UnitStyles[this.style].keybindings[clickType].spell);
				TargetLastTarget();
				return;
			elseif (type == 9) then
				RunScript(OneRaid_Options.UnitStyles[this.style].keybindings[clickType].script);
				return;
			end
		end
		
	elseif (arg1 == "RightButton") then
	
		if (IsRaidLeader() or IsRaidOfficer()) then

			CloseMenus();
			UIDropDownMenu_SetSelectedValue(OneRaid_Unit_DropDown, this.unit, 1);
			ToggleDropDownMenu(1, nil, OneRaid_Unit_DropDown, this:GetParent(), 0, 0);
		
		end
	
	end

end

function OneRaid.Unit:OnEnter()
	
	local style = OneRaid_Options.UnitStyles[this.style];
	local options = OneRaid_Options.Groups[getglobal(this:GetParent():GetName()).name];
	
	if (style.backgroundType == 5) then
		if (UnitIsUnit("target", this.unit)) then
			this:SetBackdropColor(style.targetColor.r, style.targetColor.g, style.targetColor.b, style.targetColor.a);
		else
			this:SetBackdropColor(style.hoverColor.r, style.hoverColor.g, style.hoverColor.b, style.hoverColor.a);
		end		
	end
	if (style.borderType == 5) then
		if (UnitIsUnit("target", this.unit)) then
			this:SetBackdropBorderColor(style.targetColor.r, style.targetColor.g, style.targetColor.b, 1);
		else
			this:SetBackdropBorderColor(style.hoverColor.r, style.hoverColor.g, style.hoverColor.b, 1);
		end		
	end
	
	if (OneRaid_Options.disableUnitTooltip) then return; end
		
	if (options and options.buffMonitor) then
		local buffs = getglobal(this:GetParent():GetName()).unitBuffs[UnitName(this.unit)];
		GameTooltip:SetOwner(this);
		GameTooltip:ClearLines();
		GameTooltip:AddLine(ONERAID_MISSING_BUFFS);
		local skip = {};
		for k, v in buffs do
			if (not skip[v.name]) then
				local buff = v.name;
				
				local group = buffs[v.name].groupName;
				local single = buffs[v.name].name;
							
				if (group) then
					buff = single .. ", " .. group;
					skip[group] = 1;
					skip[single] = 1;
				else
					buff = single;
					skip[single] = 1;
				end				
				
				GameTooltip:AddLine("|cFFFF0000" .. buff);
			end
		end
	else			
		GameTooltip_SetDefaultAnchor(GameTooltip, this);
		GameTooltip:SetUnit(this.unit);
		
		if (self.data[this.name]) then
			for cooldown, timeLeft in self.data[this.name].cooldowns or {} do
		   		GameTooltip:AddLine("|cFFFF7F00" .. cooldown .. ": " .. OneRaid:FormatTime(timeLeft));
			end
			
			if (self.data[this.name].afk) then
				GameTooltip:AddLine("|cFFFF7F00 " .. ONERAID_AFK .. ": " .. OneRaid:FormatTime(GetTime() - self.data[this.name].afk));
			end
			if (self.data[this.name].afkTotal and self.data[this.name].afkTotal > 0) then
				GameTooltip:AddLine("|cFFFF7F00 " .. ONERAID_AFK_TOTAL .. ": " .. OneRaid:FormatTime(self.data[this.name].afkTotal));
			end
			
			if (self.data[this.name].version) then
				GameTooltip:AddLine("|cFFFFFF80" .. "ØneRaid " .. self.data[this.name].version);
				for k, v in self.data[this.name].plugins do
					GameTooltip:AddLine("|cFFFFFF80" .. "+ " .. k);
				end
		    end
		end
	    
	end
	
	GameTooltip:Show();
	
	OneRaid.mouseoverUnit = this;
	
end

function OneRaid.Unit:OnLeave()

	local style = OneRaid_Options.UnitStyles[this.style];
	
	if (style.backgroundType == 5) then
		if (UnitIsUnit("target", this.unit)) then
			this:SetBackdropColor(style.targetColor.r, style.targetColor.g, style.targetColor.b, style.targetColor.a);
		else
			this:SetBackdropColor(0, 0, 0, 0);
		end
	end
	if (style.borderType == 5) then
		if (UnitIsUnit("target", this.unit)) then
			this:SetBackdropBorderColor(style.targetColor.r, style.targetColor.g, style.targetColor.b, 1);
		else			
			this:SetBackdropBorderColor(0, 0, 0, 0);
		end
	end
	
	GameTooltip:Hide();
	
	OneRaid.mouseoverUnit = nil;
	
end

function OneRaid.Unit:Buff_OnEnter()
	
	GameTooltip:SetOwner(this);
	
	local unit = this:GetParent().unit;
	
	if (this.type == "buff") then
		
		GameTooltip:SetUnitBuff(unit, this.index);
		
		--[[local timeLeft = OneRaid.Unit.data[UnitName(unit)].buffs[this.index];
		if (timeLeft) then
			GameTooltip:AddDoubleLine(ONERAID_TIME_LEFT, OneRaid:FormatTime(timeLeft));
		else
			GameTooltip:AddDoubleLine(ONERAID_TIME_LEFT, ONERAID_UNKNOWN);
		end]]
		
	elseif (this.type == "debuff") then
		GameTooltip:SetUnitDebuff(this:GetParent().unit, this.index);
	end	
		
	GameTooltip:Show();
	
	this:SetScript("OnUpdate", function() self:Buff_OnUpdate(arg1); end);
	OneRaid.mouseoverBuff = this;
	
end

function OneRaid.Unit:Buff_OnLeave()

	GameTooltip:Hide();
	OneRaid.mouseoverBuff = nil;
	this:SetScript("OnUpdate", nil);

end


------------------

function OneRaid.Unit:RegisterEvents(frame)

	frame:RegisterEvent("UNIT_HEALTH");
    frame:RegisterEvent("UNIT_HEALTHMAX");
	frame:RegisterEvent("UNIT_MANA");
	frame:RegisterEvent("UNIT_MANAMAX");
	frame:RegisterEvent("UNIT_RAGE");
	frame:RegisterEvent("UNIT_RAGEMAX");
	frame:RegisterEvent("UNIT_ENERGY");
	frame:RegisterEvent("UNIT_ENERGYMAX");
	frame:RegisterEvent("UNIT_AURA");
	frame:RegisterEvent("UNIT_DISPLAYPOWER");
	frame:RegisterEvent("UNIT_FACTION");	
	frame:RegisterEvent("PLAYER_TARGET_CHANGED");
	frame:RegisterEvent("RAID_ROSTER_UPDATE");
	frame:RegisterEvent("RAID_TARGET_UPDATE");
	frame:RegisterEvent("CHAT_MSG_ADDON");
	
end

function OneRaid.Unit:UnregisterEvents(frame)

	frame:UnregisterEvent("UNIT_HEALTH");
    frame:UnregisterEvent("UNIT_HEALTHMAX");
	frame:UnregisterEvent("UNIT_MANA");
	frame:UnregisterEvent("UNIT_MANAMAX");
	frame:UnregisterEvent("UNIT_RAGE");
	frame:UnregisterEvent("UNIT_RAGEMAX");
	frame:UnregisterEvent("UNIT_ENERGY");
	frame:UnregisterEvent("UNIT_ENERGYMAX");
	frame:UnregisterEvent("UNIT_AURA");
	frame:UnregisterEvent("UNIT_DISPLAYPOWER");
	frame:UnregisterEvent("UNIT_FACTION");	
	frame:UnregisterEvent("PLAYER_TARGET_CHANGED");
	frame:UnregisterEvent("RAID_ROSTER_UPDATE");
	frame:UnregisterEvent("RAID_TARGET_UPDATE");
	frame:UnregisterEvent("CHAT_MSG_ADDON");
	
end

function OneRaid.Unit:UpdateTankTarget(f, tankUnit, tankMonitor)

	local style = OneRaid_Options.UnitStyles[f.style];
	local sameTarget = nil;

	if (UnitExists(f.unit) and not UnitIsUnit(f.unit, tankUnit)) then
	
		self:UpdateName(f);
		self:UpdateHealth(f);
		self:UpdateMana(f);
		self:UpdatePvp(f);
		self:UpdateVoice(f);
		self:UpdateTarget(f);
		self:UpdateRange(f);
		--self:UpdateBuffs(f);
		self:UpdateTargetIcon(f);
	
		--Tank has a mob selected that is targetted by another tank.
		if (style.warnSameTarget) then
			if (not UnitIsFriend(f.unit, tankUnit)) then
				for i = 1, getn(OneRaid.tanks) do
					if (OneRaid.tanks[i] == UnitName(tankUnit)) then break; end
					
					if (UnitIsUnit(f.unit, tankMonitor.frames[OneRaid.tanks[i]][2].unit)) then
						sameTarget = 1;
						break;
					end
				end
			end
				
			if (sameTarget) then
				if (not f.warned) then
					if (style.backgroundType == 7) then
						f:SetBackdropColor(style.warningColor.r, style.warningColor.g, style.warningColor.b, style.warningColor.a);
					end
					if (style.borderType == 7) then
						f:SetBackdropBorderColor(style.warningColor.r, style.warningColor.g, style.warningColor.b, 1);
					end
					f.warned = 1;
				end
			else
				if (f.warned) then
					if (style.backgroundType == 7) then
						f:SetBackdropColor(0, 0, 0, 0);
					end
					if (style.borderType == 7) then
						f:SetBackdropBorderColor(0, 0, 0, 0);
					end
					f.warned = nil;
				end
			end
		else
			if (f.warned) then
				if (style.backgroundType == 7) then
					f:SetBackdropColor(0, 0, 0, 0);
				end
				if (style.borderType == 7) then
					f:SetBackdropBorderColor(0, 0, 0, 0);
				end
				f.warned = nil;
			end	
		end	
		
		if (not f:IsVisible()) then
			f:Show();
		end
	else
		if (f:IsVisible()) then
			f:Hide();
		end
	end
		
end

function OneRaid.Unit:UpdateTankTargetTarget(f, tankUnit, tankMonitor)

	local style = OneRaid_Options.UnitStyles[f.style];
	local target = tankUnit .. "target";
	
	if (UnitExists(f.unit) and not UnitIsUnit(f.unit, target)) then

		if (style.showTargetsTarget) then
			
			self:UpdateName(f);
			self:UpdateHealth(f);
			self:UpdateMana(f);
			self:UpdatePvp(f);
			self:UpdateVoice(f);
			self:UpdateTarget(f);
			self:UpdateRange(f);
			--self:UpdateBuffs(f);
			self:UpdateTargetIcon(f);
			
			if (not f:IsVisible()) then
				f:Show();
			end
		else
			if (f:IsVisible()) then
				f:Hide();
			end
		end
		
		--Unit is not a player character
		if (not UnitIsPlayer(target)) then
		
			--Unit is tanked	
			if (UnitIsUnit(f.unit, tankUnit)) then
				if (not f.tanked) then
					if (style.backgroundType == 7) then
						f:SetBackdropColor(style.tankedColor.r, style.tankedColor.g, style.tankedColor.b, style.tankedColor.a);
					end
					if (style.borderType == 7) then
						f:SetBackdropBorderColor(style.tankedColor.r, style.tankedColor.g, style.tankedColor.b, 1);
					end
					f.tanked = 1;
					f.warned = nil;
				end	
				if (UnitIsUnit("player", tankUnit)) then
					self.hadAggro = 1;
				end
			--Unit isnt tanked, someone has aggro
			elseif (not tankMonitor.frames[UnitName(f.unit)]) then
				if (not f.warned) then					
					if (style.backgroundType == 7) then
						f:SetBackdropColor(style.warningColor.r, style.warningColor.g, style.warningColor.b, style.warningColor.a);
					end
					if (style.borderType == 7) then
						f:SetBackdropBorderColor(style.warningColor.r, style.warningColor.g, style.warningColor.b, 1);
					end
					f.warned = 1;
					f.tanked = nil;
				end
			end
			
			--Aggro warning
			if (tankMonitor.targets[UnitName(tankUnit)] == nil or tankMonitor.targets[UnitName(tankUnit)] ~= UnitName(f.unit)) then
				if (UnitIsUnit("player", f.unit) and not tankMonitor.frames[UnitName("player")]) then
					if (style.showAggroGain) then
						OneRaid_Message_Frame:AddMessage(ONERAID_AGGRO_GAIN_MESSAGE, 1, 0, 0);
					end
					if (style.playAggroGain) then
						PlaySoundFile("Sound\\Spells\\PVPFlagTakenHorde.wav");
					end
				end
			end
			
			--Aggro lost
			if (UnitIsUnit(tankUnit, "player") and not UnitIsUnit(f.unit, "player") and self.hadAggro) then
				if (style.showAggroLost) then
					OneRaid_Message_Frame:AddMessage(ONERAID_AGGRO_LOST_MESSAGE, 1, 0, 0);
				end
				if (style.playAggroLost) then
					PlaySoundFile("Sound\\Spells\\PVPFlagTakenHorde.wav");
				end
				self.hadAggro = nil;
			end

			
		else
			if (f.warned or f.tanked) then
				if (style.backgroundType == 7) then
					f:SetBackdropColor(0, 0, 0, 0);
				end
				if (style.borderType == 7) then
					f:SetBackdropBorderColor(0, 0, 0, 0);
				end
				f.warned = nil;
				f.tanked = nil;
			end
		end


	else
		if (f:IsVisible()) then
			f:Hide();
		end
	end
	
	if (UnitName(tankUnit)) then
		if (UnitExists(f.unit)) then
			tankMonitor.targets[UnitName(tankUnit)] = UnitName(f.unit);
		else
			tankMonitor.targets[UnitName(tankUnit)] = nil;
		end
	end

end

function OneRaid.Unit:UpdateName(frame)

	local style = OneRaid_Options.UnitStyles[frame.style];
	
	if (not UnitClass(frame.unit)) then
		OneRaid:Timer(1, self, "UpdateName", frame, 1);
		return;
	end

	local name = getglobal(frame:GetName() .. "_Name_FontString");
	local cc = RAID_CLASS_COLORS[string.upper(UnitClass(frame.unit))];
	
	if (style.nameColorType == 8) then
		name:SetTextColor(style.nameColor.r, style.nameColor.g, style.nameColor.b);
	elseif (style.nameColorType == 7) then
		name:SetTextColor(cc.r, cc.g, cc.b);
	end
	name:SetText(UnitName(frame.unit));
		
	if (style.name.hide) then
		getglobal(frame:GetName() .. "_Name"):Hide();
	else
		getglobal(frame:GetName() .. "_Name"):Show();
	end
	
end

function OneRaid.Unit:UpdateHealth(frame)

	local health, healthMax, percent, r, b, g;
	local style = OneRaid_Options.UnitStyles[frame.style];
	
	if (not UnitClass(frame.unit)) then
		OneRaid:Timer(1, self, "UpdateHealth", frame, 1);
		return;
	end
	
	health, healthMax = UnitHealth(frame.unit), UnitHealthMax(frame.unit);
	
	if (healthMax == 0) then healthMax = 1; end
	if (healthMax == 1) then healthMax = health; end
	
	percent = health / healthMax;
	
	local bar = getglobal(frame:GetName() .. "_HealthBar");
	
	bar:SetValue(percent);
	
	if(style.healthType == 1) then
		getglobal(frame:GetName() .. "_Health_FontString"):SetText(ceil(percent * 100) .. "%");
	elseif (style.healthType == 2) then
		getglobal(frame:GetName() .. "_Health_FontString"):SetText(health);
	elseif (style.healthType == 3) then
		getglobal(frame:GetName() .. "_Health_FontString"):SetText("-" .. healthMax - health);
	elseif (style.healthType == 4) then
		getglobal(frame:GetName() .. "_Health_FontString"):SetText(health .. "/" .. healthMax);
	end
	
	if (style.health.hide) then
		getglobal(frame:GetName() .. "_Health"):Hide();
	else
		getglobal(frame:GetName() .. "_Health"):Show();
	end
	
	local cc = RAID_CLASS_COLORS[string.upper(UnitClass(frame.unit))];
			
	if (style.healthColorType == 1) then
		--Ranges Color
		if (percent > .75) then
			if (style.range1ColorUseClassColor) then
				r, g, b = cc.r, cc.g, cc.b;
			else
				r, g, b = style.range1Color.r, style.range1Color.g, style.range1Color.b;
			end
		elseif (percent <= .75 and percent > .5) then
			if (style.range2ColorUseClassColor) then
				r, g, b = cc.r, cc.g, cc.b;
			else
				r, g, b = style.range2Color.r, style.range2Color.g, style.range2Color.b;
			end
		elseif (percent <= .5 and percent > .25) then
			if (style.range3ColorUseClassColor) then
				r, g, b = cc.r, cc.g, cc.b;
			else
				r, g, b = style.range3Color.r, style.range3Color.g, style.range3Color.b;
			end
		elseif (percent <= .25) then
			if (style.range4ColorUseClassColor) then
				r, g, b = cc.r, cc.g, cc.b;
			else
				r, g, b = style.range4Color.r, style.range4Color.g, style.range4Color.b;
			end
		end
	elseif (style.healthColorType == 2) then
		--Smooth Color
		if(percent > 0.5) then
			r = (1.0 - percent) * 2;
			g = 1.0;
		else
			r = 1.0;
			g = percent * 2;
		end
		b = 0;
	elseif (style.healthColorType == 3) then
		--Class Color
		r, g, b = cc.r, cc.g, cc.b;
	else
		--Health Color
		r, g, b = style.healthColor.r, style.healthColor.g, style.healthColor.b;		
	end
	
	bar:SetStatusBarColor(r, g, b);
	getglobal(bar:GetName() .. "_Background"):SetVertexColor(r, g, b, style.healthBar.statusBarAlpha);
	
	if (style.nameColorType == 6) then
		getglobal(frame:GetName() .. "_Name_FontString"):SetTextColor(r, g, b);
	end
	
	if (style.healthBar.hide) then
		bar:SetHeight(-1);
	else
		bar:SetHeight(style.healthBar.height);
	end
	
	self:UpdateStatus(frame);

end

function OneRaid.Unit:UpdateMana(frame)

	local mana, manaMax, percent, r, b, g;
	local style = OneRaid_Options.UnitStyles[frame.style];
	
	mana, manaMax = UnitMana(frame.unit), UnitManaMax(frame.unit);
	
	if (manaMax == 0) then manaMax = 1; end
	
	percent = mana / manaMax;
	
	local bar = getglobal(frame:GetName() .. "_ManaBar");
	local background = getglobal(bar:GetName() .. "_Background");
	
	bar:SetValue(percent);
	
	if (style.manaType == 1) then
		getglobal(frame:GetName() .. "_Mana_FontString"):SetText(ceil(percent * 100) .. "%");
	elseif (style.manaType == 2) then
		getglobal(frame:GetName() .. "_Mana_FontString"):SetText(mana);
	elseif (style.manaType == 3) then
		getglobal(frame:GetName() .. "_Mana_FontString"):SetText("-" .. manaMax - mana);
	elseif (style.manaType == 4) then
		getglobal(frame:GetName() .. "_Mana_FontString"):SetText(mana .. "/" .. manaMax);
	end
	
	if (style.mana.hide) then
		getglobal(frame:GetName() .. "_Mana"):Hide();
	else
		getglobal(frame:GetName() .. "_Mana"):Show();
	end
	
	local hide = nil;
	
	if (UnitPowerType(frame.unit) == 0) then
		r, g, b = style.manaColor.r, style.manaColor.g, style.manaColor.b;
		if (style.hideMana) then
			hide = 1;
		end
	elseif (UnitPowerType(frame.unit) == 1) then
		r, g, b = style.rageColor.r, style.rageColor.g, style.rageColor.b;
		if (style.hideRage) then
			hide = 1;
		end
	elseif (UnitPowerType(frame.unit) == 2) then
		r, g, b = style.focusColor.r, style.focusColor.g, style.focusColor.b;
		if (style.hideFocus) then
			hide = 1;
		end
    elseif (UnitPowerType(frame.unit) == 3) then
		r, g, b = style.energyColor.r, style.energyColor.g, style.energyColor.b;
		if (style.hideEnergy) then
			hide = 1;
		end
	end

	bar:SetStatusBarColor(r, g, b);
	background:SetVertexColor(r, g, b, style.manaBar.statusBarAlpha);
	
	if (hide or style.manaBar.hide) then
		bar:SetHeight(-1);
		if (not style.healthBar.hide) then
			getglobal(frame:GetName() .. "_HealthBar"):SetHeight(style.healthBar.soloHeight);
		end
	else
		bar:SetHeight(style.manaBar.height);
		if (not style.healthBar.hide) then
			getglobal(frame:GetName() .. "_HealthBar"):SetHeight(style.healthBar.height);
		end
	end

	self:UpdateStatus(frame);

end

function OneRaid.Unit:UpdateBuffs(frame)

	local style = OneRaid_Options.UnitStyles[frame.style];
	local options = nil;
	
	--ChatFrame1:AddMessage(frame);
	--ChatFrame1:AddMessage(frame:GetName());
	--local hasParent = frame:GetParent();
	--if (hasParent) then
	local options = OneRaid_Options.Groups[getglobal(frame:GetParent():GetName()).name];
	--end
	
	if (not options) then return; end
	
	local currentBuff = 1;
	local currentDebuff = 1;
	local icon = nil;
	local debuffTypes = {};
	
	frame.buffCount = 0;
	frame.statusBuffs = {};
	frame.statusDebuffs = {};
	
	while (UnitDebuff(frame.unit, currentDebuff)) do
		
		OneRaid_UnitBuff_TooltipTextLeft1:SetText(nil);
		OneRaid_UnitBuff_Tooltip:SetUnitDebuff(frame.unit, currentDebuff);
		
		local debuff = OneRaid_UnitBuff_TooltipTextLeft1:GetText();
		local texture, stack, debuffType = UnitDebuff(frame.unit, currentDebuff);
		
		debuffType = (debuffType) or "Uncurable";
		
		if (OneRaid.statusDebuffs[debuff]) then
			tinsert(frame.statusDebuffs, OneRaid.statusDebuffs[debuff]);
		end
			
		if (OneRaid.debuffs[debuff] or OneRaid.debuffs[debuffType]) then
		
			debuff = OneRaid.debuffs[debuff] or OneRaid.debuffs[debuffType];
			
			if ((debuff.standard and not options.tankMonitor and not options.debuffMonitor) or
				(options.tankMonitor and debuff.tankMonitor) or (options.debuffMonitor and debuff.debuffMonitor)) then
				
				debuffTypes[debuffType] = 1;
				
				if (not style.buffs.hide and style.showDebuffs and frame.buffCount < style.numberBuffs) then
				
					if (debuffType == "Uncurable") then
						debuffType = "none";
					end
					
					local button = getglobal(frame:GetName() .. "_Buff" .. frame.buffCount + 1);
					local icon = getglobal(button:GetName() .. "_Icon");
					local count = getglobal(button:GetName() .. "_Count_FontString");
					local border = getglobal(button:GetName() .. "_Border");
					local borderColor = DebuffTypeColor[debuffType];

					button.index = currentDebuff;
					button.type = "debuff";

					if (stack > 1) then
						count:SetText(stack);
					else
						count:SetText("");
					end					
					icon:SetTexture(texture);
					border:SetVertexColor(borderColor.r, borderColor.g, borderColor.b);
					border:Show();
					button:Show();
					
					frame.buffCount = frame.buffCount + 1;

				end
				
			end
			
			if (UnitIsPlayer(frame.unit) and debuff.icon and (IsRaidLeader() or IsRaidOfficer())) then
				if (frame.icon ~= debuff.name .. debuff.icon) then
					icon = 1;
					frame.icon = debuff.name .. debuff.icon;
					SetRaidTargetIcon(frame.unit, self.icons[debuff.icon]);
				else
					icon = 1;
				end
				icon = 1;						
			end
			
		end
			
		currentDebuff = currentDebuff + 1;
		
	end
	
	while (UnitBuff(frame.unit, currentBuff)) do
		
		OneRaid_UnitBuff_TooltipTextLeft1:SetText(nil);
		OneRaid_UnitBuff_Tooltip:SetUnitBuff(frame.unit, currentBuff);
		
		local buff = OneRaid_UnitBuff_TooltipTextLeft1:GetText();
		local texture, stack = UnitBuff(frame.unit, currentBuff);
		
		if (OneRaid.statusBuffs[buff]) then
			tinsert(frame.statusBuffs, OneRaid.statusBuffs[buff]);
		end

		if (OneRaid.buffs[buff]) then			
		
			buff = OneRaid.buffs[buff];

			if ((buff.standard and not options.tankMonitor and not options.buffMonitor) or
				(options.tankMonitor and buff.tankMonitor) or (options.buffMonitor and buff.buffMonitor)) then
			
				if (not style.buffs.hide and style.showBuffs and frame.buffCount < style.numberBuffs) then
									
					local button = getglobal(frame:GetName() .. "_Buff" .. frame.buffCount + 1);
					local icon = getglobal(button:GetName() .. "_Icon");
					local count = getglobal(button:GetName() .. "_Count_FontString");
					local border = getglobal(button:GetName() .. "_Border");
					
					button.index = currentBuff;
					button.type = "buff";

					if (stack > 1) then
						count:SetText(stack);
					else
						count:SetText("");
					end					
					icon:SetTexture(texture);
					border:Hide();
					button:Show();
					
					frame.buffCount = frame.buffCount + 1;
						
				end
			
			end
			
			if (UnitIsPlayer(frame.unit) and buff.icon and (IsRaidLeader() or IsRaidOfficer())) then
				if (frame.icon ~= buff.name .. buff.icon) then
					icon = 1;
					frame.icon = buff.name .. buff.icon;
					SetRaidTargetIcon(frame.unit, self.icons[buff.icon]);
				else
					icon = 1;
				end
				icon = 1;						
			end
		
		end

		currentBuff = currentBuff + 1;
		
	end
	
	if (UnitIsPlayer(frame.unit) and frame.icon and not icon) then
        SetRaidTargetIcon(frame.unit, 0);
        frame.icon = nil;
   	end

	for i = frame.buffCount + 1, style.numberBuffs do
    	local button = getglobal(frame:GetName() .. "_Buff" .. i);
    	getglobal(button:GetName() .. "_Icon"):SetTexture(nil);
    	getglobal(button:GetName() .. "_Count_FontString"):SetText("");
    	getglobal(button:GetName() .. "_Border"):Hide();
    	button:Hide();
    	button.index = nil;
		button.type = nil;
    end
	
	self:UpdateStatus(frame);
	
	--Set Colors
	local debuffColor = nil;
	for k, v in OneRaid_Options.debuffPriority do
		if (debuffTypes[v]) then
			debuffColor = DebuffTypeColor[v];
			break;
		end
	end
	
	if (style.nameColorType == 1) then
		if (debuffColor) then
			getglobal(frame:GetName() .. "_Name_FontString"):SetTextColor(debuffColor.r, debuffColor.g, debuffColor.b);
		else
			getglobal(frame:GetName() .. "_Name_FontString"):SetTextColor(style.nameColor.r, style.nameColor.g, style.nameColor.b);
		end
	end
	
	if (style.backgroundType == 2) then
		if (debuffColor) then
			frame:SetBackdropColor(debuffColor.r, debuffColor.g, debuffColor.b, style.debuffColorAlpha);
		else
			frame:SetBackdropColor(0, 0, 0, 0);
		end
	end
	
	if (style.borderType == 2) then
		if (debuffColor) then
			frame:SetBackdropBorderColor(debuffColor.r, debuffColor.g, debuffColor.b, 1);
		else
			frame:SetBackdropBorderColor(0, 0, 0, 0);
		end
	end
		
end

function OneRaid.Unit:UpdateStatus(frame)
	
	frame.statusBuffs = frame.statusBuffs or {};
	frame.statusDebuffs = frame.statusDebuffs or {};
	
	if (not self.data[frame.name]) then return; end
	
	if (not UnitIsDeadOrGhost(frame.unit)) then
		self.data[frame.name].rez = nil;
		self.data[frame.name].rezzed = nil;
		self.data[frame.name].soulstone = nil;
		self.data[frame.name].ankh = nil;
		--frame.statusBuffs = {};
		--frame.statusDebuffs = {};
	end
	
	if (UnitIsGhost(frame.unit)) then
		self.data[frame.name].soulstone = nil;
		self.data[frame.name].ankh = nil;
		--frame.statusBuffs = {};
		--frame.statusDebuffs = {};
	end
	
	if (not UnitIsConnected(frame.unit)) then
		self.data[frame.name].rez = nil;
		self.data[frame.name].rezzed = nil;
		self.data[frame.name].soulstone = nil;
		self.data[frame.name].ankh = nil;
		self.data[frame.name].afk = nil;
		--frame.statusBuffs = {};
		--frame.statusDebuffs = {};
	end
	
	local status = nil;
	
	if (self.data[frame.name].rezzed) then
		status = ONERAID_STATUS_REZZED;
	elseif (self.data[frame.name].rez) then
		if (self.data[UnitName(frame.unit)].rez[1] == UnitName("player")) then
			status = ONERAID_STATUS_REZZING;
		else
			status = ONERAID_STATUS_REZINC;
		end
	elseif (self.data[frame.name].ankh) then
		status = ONERAID_STATUS_ANKH;
	elseif (self.data[frame.name].soulstone) then
		status = ONERAID_STATUS_SOULSTONE;
	elseif (self.data[frame.name].afk) then
		status = ONERAID_STATUS_AFK;
	elseif (getn(frame.statusDebuffs) > 0) then
		for k, v in frame.statusDebuffs do
			status = v.status;
			break;
		end		
	elseif (getn(frame.statusBuffs) > 0) then
		for k, v in frame.statusBuffs do
			status = v.status;
			break;
		end
	elseif (not UnitIsConnected(frame.unit)) then
		status = ONERAID_STATUS_OFFLINE;
	elseif (UnitIsGhost(frame.unit)) then
		status = ONERAID_STATUS_GHOST;
	elseif (UnitIsDead(frame.unit)) then
		status = ONERAID_STATUS_DEAD;
	else

	end
	
	self:SetStatus(frame, status);

end

function OneRaid.Unit:SetStatus(frame, status)

	local style = OneRaid_Options.UnitStyles[frame.style];
	
	local override = nil;
	
	if (OneRaid_UnitStyle_Frame:IsVisible() and OneRaid.UnitStyle.style == frame.style) then
		status = "status";
		override = 1;
	end
	
	local r, g, b;

    if (status == ONERAID_STATUS_DEAD or status == ONERAID_STATUS_AFK) then
        r = 1;
        g = .5;
        b = 0;
    elseif (status == ONERAID_STATUS_OFFLINE) then
        r = .6;
        g = .6;
        b = .6;
    else
        r = 1;
        g = 1;
        b = 1;
    end
    
    

     if (style.status.hide) then
		--getglobal(frame:GetName() .. "_Status"):Hide();
		status = nil;
	end
	
    getglobal(frame:GetName() .. "_Status_FontString"):SetTextColor(r, g, b);
    getglobal(frame:GetName() .. "_Status_FontString"):SetText(status);
    
	if (override) then		
		getglobal(frame:GetName() .. "_HealthBar"):Show();
		getglobal(frame:GetName() .. "_HealthBar_Background"):Show();		
        getglobal(frame:GetName() .. "_ManaBar"):Show();
        getglobal(frame:GetName() .. "_ManaBar_Background"):Show();
		getglobal(frame:GetName() .. "_Status"):Show();
	else
	    if (status == nil) then
	    	if (style.health.hide) then
	        	getglobal(frame:GetName() .. "_Health"):Hide();
	        else
	        	getglobal(frame:GetName() .. "_Health"):Show();
	        end
	        if (style.mana.hide) then
	        	getglobal(frame:GetName() .. "_Mana"):Hide();
	        else
	        	getglobal(frame:GetName() .. "_Mana"):Show();
	        end
			getglobal(frame:GetName() .. "_HealthBar"):Show();
	        getglobal(frame:GetName() .. "_HealthBar_Background"):Show();		
			getglobal(frame:GetName() .. "_ManaBar"):Show();
			getglobal(frame:GetName() .. "_ManaBar_Background"):Show();
			getglobal(frame:GetName() .. "_Status"):Hide();
	    else
	        getglobal(frame:GetName() .. "_Health"):Hide();
	        getglobal(frame:GetName() .. "_Mana"):Hide();
			getglobal(frame:GetName() .. "_HealthBar"):Hide();
			getglobal(frame:GetName() .. "_HealthBar_Background"):Hide();		
	        getglobal(frame:GetName() .. "_ManaBar"):Hide();
	        getglobal(frame:GetName() .. "_ManaBar_Background"):Hide();
			getglobal(frame:GetName() .. "_Status"):Show();
	    end
	end
	
end

function OneRaid.Unit:UpdatePvp(frame)
	
	local style = OneRaid_Options.UnitStyles[frame.style];
	
	local factionGroup, factionName = UnitFactionGroup(frame.unit);
	
	local ffa = UnitIsPVPFreeForAll(frame.unit);
	local pvp = UnitIsPVP(frame.unit)
	
	if (OneRaid_UnitStyle_Frame:IsVisible() and OneRaid.UnitStyle.style == frame.style) then
		pvp = 1;
	end
	
	if (ffa) then
		getglobal(frame:GetName() .. "_Pvp_Texture"):SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA");
		getglobal(frame:GetName() .. "_Pvp"):Show();
	elseif (pvp) then
		if (not UnitFactionGroup(frame.unit)) then
			getglobal(frame:GetName() .. "_Pvp_Texture"):SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA");
		else
			getglobal(frame:GetName() .. "_Pvp_Texture"):SetTexture("Interface\\TargetingFrame\\UI-PVP-" .. UnitFactionGroup(frame.unit));
		end
		getglobal(frame:GetName() .. "_Pvp"):Show();
	else
		getglobal(frame:GetName() .. "_Pvp"):Hide();
	end
	
	if (style.nameColorType == 3) then
		if (UnitIsPVP(frame.unit) or UnitIsPVPFreeForAll(frame.unit)) then
			getglobal(frame:GetName() .. "_Name_FontString"):SetTextColor(style.pvpColor.r, style.pvpColor.g, style.pvpColor.b);
		else
			getglobal(frame:GetName() .. "_Name_FontString"):SetTextColor(style.nameColor.r, style.nameColor.g, style.nameColor.b);
		end
	end
	
	if (style.backgroundType == 4) then
		if (UnitIsPVP(frame.unit)) then
			frame:SetBackdropColor(style.pvpColor.r, style.pvpColor.g, style.pvpColor.b, style.pvpColor.a);
		else
			frame:SetBackdropColor(0, 0, 0, 0);
		end
	end
	
	if (style.borderType == 4) then
		if (UnitIsPVP(frame.unit)) then
			frame:SetBackdropBorderColor(style.pvpColor.r, style.pvpColor.g, style.pvpColor.b, 1);
		else
			frame:SetBackdropBorderColor(0, 0, 0, 0);
		end
	end
	
	if (style.pvp.hide) then
		getglobal(frame:GetName() .. "_Pvp"):Hide();
	end
	
end

function OneRaid.Unit:UpdateRange(frame)

	local style = OneRaid_Options.UnitStyles[frame.style];
	local rangeColor = nil;
		
	if (not UnitIsVisible(frame.unit)) then
		rangeColor = style.oorColor;
	elseif (CheckInteractDistance(frame.unit, 3)) then
		rangeColor = style.closeColor;
	elseif (CheckInteractDistance(frame.unit, 4)) then
		rangeColor = style.mediumColor;
	else
		rangeColor = style.farColor;
	end
	
	getglobal(frame:GetName() .. "_Range_Texture"):SetVertexColor(rangeColor.r, rangeColor.g, rangeColor.b, 1);
	
	if (style.nameColorType == 2) then
		getglobal(frame:GetName() .. "_Name_FontString"):SetTextColor(rangeColor.r, rangeColor.g, rangeColor.b);
	end

	if (style.backgroundType == 3) then
		frame:SetBackdropColor(rangeColor.r, rangeColor.g, rangeColor.b, rangeColor.a);
	end
			
	if (style.borderType == 3) then
		frame:SetBackdropBorderColor(rangeColor.r, rangeColor.g, rangeColor.b, 1);
	end
	
	if (style.range.hide) then
		getglobal(frame:GetName() .. "_Range"):Hide();
	else
		getglobal(frame:GetName() .. "_Range"):Show();
	end
	
end

function OneRaid.Unit:UpdateVoice(frame)

	local style = OneRaid_Options.UnitStyles[frame.style];
	
	local voice = OneRaid.voice[UnitName(frame.unit)];
	
	if (OneRaid_UnitStyle_Frame:IsVisible() and OneRaid.UnitStyle.style == frame.style) then
		voice = 1;
	end
	
	if (voice) then
		getglobal(frame:GetName() .. "_Voice"):Show();
	else
		getglobal(frame:GetName() .. "_Voice"):Hide();
	end
	
	if (style.nameColorType == 5) then
		if (voice) then
			getglobal(frame:GetName() .. "_Name_FontString"):SetTextColor(style.voiceColor.r, style.voiceColor.g, style.voiceColor.b);
		else
			getglobal(frame:GetName() .. "_Name_FontString"):SetTextColor(style.nameColor.r, style.nameColor.g, style.nameColor.b);
		end
	end
	
	if (style.backgroundType == 6) then
		if (voice) then
			frame:SetBackdropColor(style.voiceColor.r, style.voiceColor.g, style.voiceColor.b, style.voiceColor.a);
		else
			frame:SetBackdropColor(0, 0, 0, 0);
		end
	end
	
	if (style.borderType == 4) then
		if (voice) then
			frame:SetBackdropBorderColor(style.voiceColor.r, style.voiceColor.g, style.voiceColor.b, 1);
		else
			frame:SetBackdropBorderColor(0, 0, 0, 0);
		end
	end
	
	if (style.voice.hide) then
		getglobal(frame:GetName() .. "_Voice"):Hide();
	end
	
end

function OneRaid.Unit:UpdateTargetIcon(frame)

	local style = OneRaid_Options.UnitStyles[frame.style];
	
	local icon = GetRaidTargetIndex(frame.unit);
	
	if (OneRaid_UnitStyle_Frame:IsVisible() and OneRaid.UnitStyle.style == frame.style) then
		icon = 1;
	end
	
	if (icon) then
		local texture = getglobal(frame:GetName() .. "_TargetIcon_Texture")
		SetRaidTargetIconTexture(texture, icon);
		getglobal(frame:GetName() .. "_TargetIcon"):Show();
	else
		getglobal(frame:GetName() .. "_TargetIcon"):Hide();
	end

	
	if (style.targetIcon.hide) then
		getglobal(frame:GetName() .. "_TargetIcon"):Hide();
	end
	
end

function OneRaid.Unit:UpdateTarget(frame)

	local style = OneRaid_Options.UnitStyles[frame.style];
	
	if (style.nameColorType == 4) then
		if (UnitIsUnit("target", frame.unit)) then
			getglobal(frame:GetName() .. "_Name_FontString"):SetTextColor(style.targetColor.r, style.targetColor.g, style.targetColor.b);
		else
			getglobal(frame:GetName() .. "_Name_FontString"):SetTextColor(style.nameColor.r, style.nameColor.g, style.nameColor.b);
		end
	end
	
	if (style.backgroundType == 5) then
		if (UnitIsUnit("target", frame.unit)) then
			frame:SetBackdropColor(style.targetColor.r, style.targetColor.g, style.targetColor.b, style.targetColor.a);
		else
			frame:SetBackdropColor(0, 0, 0, 0);
		end
	end
	if (style.borderType == 5) then
		if (UnitIsUnit("target", frame.unit)) then
			frame:SetBackdropBorderColor(style.targetColor.r, style.targetColor.g, style.targetColor.b, 1);
		else
			frame:SetBackdropBorderColor(0, 0, 0, 0);
		end
	end
	
end

function OneRaid.Unit:DeactivateFrame(frame)

	frame.inactive = 1;
	frame:ClearAllPoints();
	frame:Hide();
	frame.name = nil;
	frame.unit = nil;
	frame.style = nil;

end

function OneRaid.Unit:GetInactiveFrame()

	for index, frame in self.frames do
		if (frame.inactive) then
			frame.inactive = nil;	
			return frame;
		end
	end
	
	return nil;
	
end

function OneRaid.Unit:CreateFrame(unit, parent, style, tankMonitor)

	if (not OneRaid_Options.UnitStyles[style]) then
		style = "Default";
	end
	
	--Try to use an inactive frame
	local f = self:GetInactiveFrame();
	
	if (not f) then
		--Could not find any inactive frames, creating a new one.
		f = CreateFrame("Button", "OneRaid_Unit_" .. getn(self.frames) + 1, parent, "OneRaid_Unit_Template");		
		f.numberBuffs = 0;
		tinsert(self.frames, f);
	else
		--Inactive frame was found, setting its new parent
		f:SetParent(parent);
	end
	
	--Create the correct amount of buffs only if needed
	for i = f.numberBuffs + 1, OneRaid_Options.UnitStyles[style].numberBuffs do
		local b = CreateFrame("Button", f:GetName() .. "_Buff" .. i, f, "OneRaid_Buff_Template");
		b:SetID(i);
	end
	f.numberBuffs = OneRaid_Options.UnitStyles[style].numberBuffs;
	
	if (tankMonitor) then
		f.tankMonitor = tankMonitor;
	end
	
	f.name = UnitName(unit);
	f.unit = unit;
	f.style = style;
	
	self.data[f.name] = self.data[f.name] or { cooldowns = {}, buffs = {}, debuffs = {} };		
	
	self:LoadFrame(f, style, tankMonitor);
	
	self:UpdateName(f);
	self:UpdateHealth(f);
	self:UpdateMana(f);
	self:UpdatePvp(f);
	self:UpdateVoice(f);
	self:UpdateTarget(f);
	self:UpdateRange(f);
	self:UpdateTargetIcon(f);

	f:SetFrameLevel(1);
	
	if (not tankMonitor) then
		self:UpdateBuffs(f);
		f:Show();
	end
	
	return f;
	
end

function OneRaid.Unit:LoadFrame(frame, style, tankMonitor)

	local f = frame;
	
	local hb	= getglobal(f:GetName() .. "_HealthBar");
	local mb	= getglobal(f:GetName() .. "_ManaBar");
	local n		= getglobal(f:GetName() .. "_Name");
	local s		= getglobal(f:GetName() .. "_Status");
	local b		= getglobal(f:GetName() .. "_Buff1");
	local h		= getglobal(f:GetName() .. "_Health");
	local m		= getglobal(f:GetName() .. "_Mana");
	local p		= getglobal(f:GetName() .. "_Pvp");
	local r		= getglobal(f:GetName() .. "_Range");
	local v 	= getglobal(f:GetName() .. "_Voice");
	local t		= getglobal(f:GetName() .. "_TargetIcon");
	
	self:SetFontString(f, n, OneRaid_Options.UnitStyles[style].name);
	self:SetFontString(f, s, OneRaid_Options.UnitStyles[style].status);
	self:SetFontString(f, h, OneRaid_Options.UnitStyles[style].health);
	self:SetFontString(f, m, OneRaid_Options.UnitStyles[style].mana);
	
	self:SetStatusBar(f, hb, OneRaid_Options.UnitStyles[style].healthBar);
	self:SetStatusBar(f, mb, OneRaid_Options.UnitStyles[style].manaBar);
	
	self:SetTexture(f, p, OneRaid_Options.UnitStyles[style].pvp);
	self:SetTexture(f, r, OneRaid_Options.UnitStyles[style].range);
	self:SetTexture(f, v, OneRaid_Options.UnitStyles[style].voice);
	self:SetTexture(f, t, OneRaid_Options.UnitStyles[style].targetIcon);
	
	if (not tankMonitor) then
		self:SetBuffs(f, b, OneRaid_Options.UnitStyles[style].buffs, OneRaid_Options.UnitStyles[style].buffCount);
	end
	
	self:SetFrame(f, OneRaid_Options.UnitStyles[style].frame);
	
	f:SetBackdropColor(0, 0, 0, 0);
	f:SetBackdropBorderColor(0, 0, 0, 0);
	f:SetFrameLevel(1);
	
	f:SetPoint("CENTER", 0, 0);
	
end

function OneRaid.Unit:SetFrame(frame, style)

	local f = frame;
	
	f:SetHeight(style.height);
	f:SetWidth(style.width);

end

function OneRaid.Unit:SetFontString(frame, fontString, style, buff)

	local f = frame;
	local fs = fontString;
	local s = style;
	local flags = nil;
	
	if (not buff) then
		fs = getglobal(fontString:GetName() .. "_FontString");
	end
	
	if (s.outline) then flags = "OUTLINE"; end
	if (s.thickOutline) then
		if (flags) then flags = flags .. ", THICKOUTLINE"; else flags = "THICKOUTLINE"; end
	end
	if (s.monochrome) then
		if (flags) then flags = flags .. ", MONOCHROME"; else flags = "MONOCHROME"; end
	end
		
	fs:SetHeight(s.height);
	fs:SetWidth(s.width);
	fs:SetJustifyV(s.justifyV);
	fs:SetJustifyH(s.justifyH);
	fs:SetShadowColor(s.shadowColor.r, s.shadowColor.g, s.shadowColor.b);
	fs:SetShadowOffset(s.shadowX, s.shadowY);
	
	fs:SetFont(s.font, s.fontHeight, flags);
	
	fontString:SetHeight(s.height);
	fontString:SetWidth(s.width);
	fontString:ClearAllPoints();
	if (s.attach == "Frame") then
		fontString:SetPoint(s.point, f, s.relative, s.x, s.y);
	else
		fontString:SetPoint(s.point, getglobal(f:GetName() .. "_" .. s.attach), s.relative, s.x, s.y);
	end
	
	if (not buff) then
		fontString:SetFrameLevel(s.frameLevel);
	end
	
	if (s.hide) then
		fontString:Hide();
	else
		fontString:Show();
	end
	
end

function OneRaid.Unit:SetStatusBar(frame, statusBar, style)

	local f = frame;
	local sb = statusBar;	
	local s = style;
	local bg = getglobal(sb:GetName() .. "_Background");
	
	sb:ClearAllPoints();		
	sb:SetHeight(s.height);
	sb:SetWidth(s.width);
	sb:SetStatusBarTexture(s.texture);
	sb:SetMinMaxValues(0, 1);
	sb:SetFrameLevel(s.frameLevel);
	bg:SetTexture(s.texture);
	
	if (s.attach == "Frame") then
		sb:SetPoint(s.point, f, s.relative, s.x, s.y);
	else
		sb:SetPoint(s.point, getglobal(f:GetName() .. "_" .. s.attach), s.relative, s.x, s.y);
	end
	
	sb.soloHeight = s.soloHeight;
	
	if (s.hide) then
		sb:Hide();
	else
		sb:Show();
	end
	
end

function OneRaid.Unit:SetBuffs(frame, buff, buffStyle, countStyle)

	local style = OneRaid_Options.UnitStyles[frame.style];
	
	local f = frame;
	local b = buff;
	local s = buffStyle;
	local cs = countStyle;
	
	b:ClearAllPoints();

	if (s.attach == "Frame") then
		b:SetPoint(s.point, f, s.relative, s.x, s.y);
	else
		b:SetPoint(s.point, getglobal(f:GetName() .. "_" .. s.attach), s.relative, s.x, s.y);
	end
	
	for i = 1, style.numberBuffs do
			
		local bn	= getglobal(f:GetName() .. "_Buff" .. i);
		local a 	= getglobal(f:GetName() .. "_Buff" .. i - 1);
		local bnb	= getglobal(bn:GetName() .. "_Border");
		
		if (i > 1) then		
			bn:ClearAllPoints();
			
			if (s.growth == 1) then
				bn:SetPoint("RIGHT", a, "LEFT", 0, 0);
			elseif (s.growth == 2) then
				bn:SetPoint("LEFT", a, "RIGHT", 0, 0);
			elseif (s.growth == 3) then
				bn:SetPoint("TOP", a, "BOTTOM", 0, 0);
			elseif (s.growth == 4) then
				bn:SetPoint("BOTTOM", a, "TOP", 0, 0);
			end
		end		
		
		local fs = getglobal(bn:GetName() .. "_Count_FontString");
		self:SetFontString(bn, fs, cs, 1);
			
		bn:SetHeight(s.height);
		bn:SetWidth(s.width);
		bn:SetFrameLevel(s.frameLevel);
		
		if (s.hide) then
			bn:Hide();
		else
			bn:Show();
		end

	end

end

function OneRaid.Unit:SetTexture(frame, texture, style)

	local f = frame;
	local t = getglobal(texture:GetName() .. "_Texture");
	local s = style;
	
	t:SetHeight(s.height);
	t:SetWidth(s.width);
	t:SetTexCoord(0, 1, 0, 1);
	t:SetTexture(s.texture);
	texture:SetHeight(s.height);
	texture:SetWidth(s.width);
	texture:ClearAllPoints();
	
	if (s.attach == "Frame") then
		texture:SetPoint(s.point, f, s.relative, s.x, s.y);
	else
		texture:SetPoint(s.point, getglobal(f:GetName() .. "_" .. s.attach), s.relative, s.x, s.y);
	end
	texture:SetFrameLevel(s.frameLevel);
		
	if (s.hide) then
		texture:Hide();
	else
		texture:Show();
	end

end

function OneRaid.Unit:DropDown_OnLoad()
	
	UIDropDownMenu_Initialize(this, function() self:DropDown_Init(); end, "MENU");

end

function OneRaid.Unit:DropDown_Init()
	
	local value = UIDropDownMenu_GetSelectedValue(OneRaid_Unit_DropDown);
	
	if (not value) then
		return;
	end
	
	if (not UnitIsPlayer(value) or not UnitIsFriend(value, "player")) then
		return;
	end

	local info = {};
	
	local assist, tank, index, groups;
	
	groups = {};
	
	for i = 1, GetNumRaidMembers() do
		local name, rank, group = GetRaidRosterInfo(i);
		if (name == UnitName(value)) then
			assist = rank;
			index = i;
		end
		groups[group] = groups[group] or {};
		tinsert(groups[group], name);		
	end
	for k, v in OneRaid.tanks or {} do
		if (v == UnitName(value)) then
			tank = 1;
			break;
		end
	end
	
	if (UIDROPDOWNMENU_MENU_VALUE == "RAID_TARGET_ICON") then
	
		UnitPopup_ShowMenu(OneRaid_Unit_DropDown, "RAID_TARGET_ICON", value, RAID_TARGET_ICON);

		return;
		
	elseif (UIDROPDOWNMENU_MENU_VALUE == "MOVE") then
	
		for i = 1, 8 do
			local group = groups[i] or {};
			if (getn(group) > 0 and getn(group) < 5) then
				info = {};
				info.text = getglobal("ONERAID_GROUP" .. i);
				info.arg1 = i;
				info.value = "ONERAID_GROUP" .. i;
				info.notCheckable = 1;
				info.func = function(arg1) OneRaid:AddonMessage("MOVE", UnitName(value), arg1); end;
				info.hasArrow = 1;
				UIDropDownMenu_AddButton(info, 2);
			end
			if (getn(group) <= 0) then
				info = {};
				info.text = getglobal("ONERAID_GROUP" .. i);
				info.arg1 = i;
				info.value = "ONERAID_GROUP" .. i;
				info.notCheckable = 1;
				info.func = function(arg1) OneRaid:AddonMessage("MOVE", UnitName(value), arg1); end;
				UIDropDownMenu_AddButton(info, 2);
			end
		end

		return;
		
	elseif (UIDROPDOWNMENU_MENU_VALUE and strsub(UIDROPDOWNMENU_MENU_VALUE, 1, 13) == "ONERAID_GROUP") then
	
		local group = tonumber(strsub(UIDROPDOWNMENU_MENU_VALUE, 14));

		for k, v in groups[group] or {} do
			info = {};
			info.text = v;
			info.arg1 = v;
			info.notCheckable = 1;
			info.func = function(arg1) OneRaid:AddonMessage("SWAP", UnitName(value), arg1); end;
			UIDropDownMenu_AddButton(info, 3);
		end

		return;

	end
	
	info.text = UnitName(value);
	info.isTitle = 1;
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);

	if (not UnitIsUnit("player", value)) then
		info = {};
		info.text = NEW_LEADER;
		info.func = function() PromoteByName(UnitName(value));  end
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
		
		if (assist == 1) then
			info = {};
			info.text = DEMOTE;
			info.func = function() DemoteAssistant(UnitName(value)); end
			info.notCheckable = 1;
			UIDropDownMenu_AddButton(info);
		else
			info = {};
			info.text = PROMOTE;
			info.func = function() PromoteToAssistant(UnitName(value)); end
			info.notCheckable = 1;
			UIDropDownMenu_AddButton(info);
		end
		
		info = {};
		info.text = REMOVE;
		info.func = function() UninviteFromRaid(index); end
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
	end
	
	info = {};
	info.text = ONERAID_ASSIST;
	info.func = function() AssistUnit(value); end
	info.notCheckable = 1;
	UIDropDownMenu_AddButton(info);

	if (OneRaid.mainAssist ~= UnitName(value)) then
		info = {};
		info.text = ONERAID_SET_AS_MAIN_ASSIST;
		info.func = function() OneRaid:AddonMessage("MA", UnitName(value)); end
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
	else
		info = {};
		info.text = ONERAID_REMOVE_AS_MAIN_ASSIST;
		info.func = function() OneRaid:AddonMessage("MA", "clear"); end
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
	end
	
	if (tank) then
		info = {};
		info.text = ONERAID_REMOVE_FROM_TANK_MONITOR;
		info.func = function() OneRaid:AddonMessage("TANK", "rem", UnitName(value)); end
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
	else
		info = {};
		info.text = ONERAID_ADD_TO_TANK_MONITOR;
		info.func = function() OneRaid:AddonMessage("TANK", "add", UnitName(value)); end
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info);
	end
	
	info = {};
	info.text = ONERAID_MOVE;
	info.value = "MOVE";
	info.notCheckable = 1;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);
	
	info = {};
	info.text = RAID_TARGET_ICON;
	info.value = "RAID_TARGET_ICON";
	info.notCheckable = 1;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);
	
	if (UnitName(value) ~= UnitName("player")) then
		info = {};
		info.text = ONERAID_AUTO_PROMOTE;
		if (OneRaid_Options.autoPromote[UnitName(value)]) then info.checked = 1; end;
		info.func = function() 
			if (OneRaid_Options.autoPromote[UnitName(value)]) then
				OneRaid_Options.autoPromote[UnitName(value)] = nil;
			else
				OneRaid_Options.autoPromote[UnitName(value)] = 1;
			end
		end;
		UIDropDownMenu_AddButton(info);
	end
	
	info = {};
	info.text = CANCEL;
	info.notCheckable = 1;
	info.func = function() CloseMenus(); end;
	UIDropDownMenu_AddButton(info);
	
end

-----------------

function OneRaid.Unit:UNIT_HEALTH()

	if (arg1 == "target" or arg1 == "mouseover") then return; end
	
	if (this.name == UnitName(arg1)) then
		this.unit = arg1;
		self:UpdateHealth(this);
	end
	
end

function OneRaid.Unit:UNIT_HEALTHMAX()

	if (arg1 == "target" or arg1 == "mouseover") then return; end
	
	if (this.name == UnitName(arg1)) then
		this.unit = arg1;
		self:UpdateHealth(this);
	end
	
end

function OneRaid.Unit:UNIT_MANA()

	if (arg1 == "target" or arg1 == "mouseover") then return; end
	
	if (this.name == UnitName(arg1)) then
		this.unit = arg1;
		self:UpdateMana(this);
	end
	
end

function OneRaid.Unit:UNIT_MANAMAX()

	if (arg1 == "target" or arg1 == "mouseover") then return; end
	
	if (this.name == UnitName(arg1)) then
		this.unit = arg1;
		self:UpdateMana(this);
	end
	
end

function OneRaid.Unit:UNIT_ENERGY()

	if (arg1 == "target" or arg1 == "mouseover") then return; end
	
	if (this.name == UnitName(arg1)) then
		this.unit = arg1;
		self:UpdateMana(this);
	end
	
end

function OneRaid.Unit:UNIT_ENERGYMAX()

	if (arg1 == "target" or arg1 == "mouseover") then return; end
	
	if (this.name == UnitName(arg1)) then
		this.unit = arg1;
		self:UpdateMana(this);
	end
	
end

function OneRaid.Unit:UNIT_RAGE()

	if (arg1 == "target" or arg1 == "mouseover") then return; end
	
	if (this.name == UnitName(arg1)) then
		this.unit = arg1;
		self:UpdateMana(this);
	end
	
end

function OneRaid.Unit:UNIT_RAGEMAX()

	if (arg1 == "target" or arg1 == "mouseover") then return; end
	
	if (this.name == UnitName(arg1)) then
		this.unit = arg1;
		self:UpdateMana(this);
	end
	
end

function OneRaid.Unit:UNIT_MANA()

	if (arg1 == "target" or arg1 == "mouseover") then return; end
	
	if (this.name == UnitName(arg1)) then
		this.unit = arg1;
		self:UpdateMana(this);
	end
	
end

function OneRaid.Unit:UNIT_DISPLAYPOWER()

	if (arg1 == "target" or arg1 == "mouseover") then return; end
	
	if (this.name == UnitName(arg1)) then
		this.unit = arg1;
		self:UpdateMana(this);
	end
	
end

function OneRaid.Unit:UNIT_AURA()

	if (arg1 == "target" or arg1 == "mouseover") then return; end
	
	if (this.name == UnitName(arg1)) then
		this.unit = arg1;
		self:UpdateBuffs(this);
	end
	
end

function OneRaid.Unit:UNIT_FACTION()
	
	if (arg1 == "target" or arg1 == "mouseover") then return; end
	
	if (this.name == UnitName(arg1)) then
		this.unit = arg1;
		self:UpdatePvp(this);
	end
	
end

function OneRaid.Unit:PLAYER_TARGET_CHANGED()

	self:UpdateTarget(this);
	
end

function OneRaid.Unit:RAID_TARGET_UPDATE()

	self:UpdateTargetIcon(this);

end

function OneRaid.Unit:RAID_ROSTER_UPDATE()

	if (OneRaid.promoting) then return; end

	if (UnitExists(this.unit)) then
		self:UpdateStatus(this);
	end

end

function OneRaid.Unit:CHAT_MSG_ADDON()

	if (arg1 ~= "ØR") then return; end
	
	if (arg3 == "GUILD") then OneRaid:Print("Convert to RAID AddonMessages"); end
	
	local arg = {};
	local found, found, event, args = string.find(arg2, "^([^¦]+)(.*)$");
	for a in string.gfind(args, "[^¦]+") do
		tinsert(arg, a);
	end
	
	if (type(self["ADDON_" .. event]) == "function") then
		self["ADDON_" .. event](self, arg4, arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9]);
	end

end

function OneRaid.Unit:ADDON_VERSION(sender, version, ct_bm, bw, ktm, loot)
	
	if (sender ~= this.name) then return; end
	
	self.data[sender].version = version;
	self.data[sender].plugins = {};
	
	if (ct_bm == "1") then
		self.data[sender].plugins["CT BossMods"] = 1;
	end
	
	if (bw == "1") then
		self.data[sender].plugins["BigWigs"] = 1;
	end
	
	if (ktm == "1") then
		self.data[sender].plugins["KLH Threat Meter"] = 1;
	end
	
	if (loot == "1") then
		self.data[sender].plugins["OneLoot"] = 1;
	end
	
	local upgrade = nil;
	local ver1 = {};
	local ver2 = {};

	local i = 1;
	for word in string.gfind( OneRaid.version, "%d+") do
		ver1[i] = tonumber(word);
		i = i + 1;
	end

	i = 1;
	for word in string.gfind(version, "%d+") do
		ver2[i] = tonumber(word);
		i = i + 1;
	end

	if (not ver1[3]) then ver1[3] = 0; end
	if (not ver2[3]) then ver2[3] = 0; end

	if (ver1[1] < ver2[1]) then
		upgrade = 1;
	elseif (ver1[1] == ver2[1] and ver1[2] < ver2[2]) then
		upgrade = 1;
	elseif (ver1[1] == ver2[1] and ver1[2] == ver2[2] and ver1[3] < ver2[3]) then
		upgrade = 1;
	end

	if (upgrade and not OneRaid.versionWarn) then
		OneRaid:Print(ONERAID_NEW_VERSION_FOUND);
	    OneRaid.versionWarn = 1;
	end

end

function OneRaid.Unit:ADDON_COOLDOWN(sender, cooldown, timeLeft)

	if (sender ~= this.name) then return; end
	
	self.data[sender].cooldowns[cooldown] = tonumber(timeLeft);

end

function OneRaid.Unit:ADDON_SOULSTONE(sender, ankh)

	if (sender ~= this.name) then return; end
	
	if (ankh) then
		self.data[sender].ankh = 1;
		self.data[sender].soulstone = nil;
	else
		self.data[sender].ankh = nil;
		self.data[sender].soulstone = 1;
	end
	
	self:UpdateStatus(this);

end

function OneRaid.Unit:ADDON_REZZED(sender)

	if (sender ~= this.name) then return; end
	
	self.data[sender].rezzed = GetTime() + 60;
	self.data[sender].rez = nil;
	
	self:UpdateStatus(this);
	
end

function OneRaid.Unit:ADDON_REZ(sender, action, target)

	if (target ~= this.name) then return; end
	
	self.data[target].rez = self.data[sender].rez or {};
	
	if (action == "start") then
		tinsert(self.data[target].rez, sender);
	elseif (action == "stop") then
		for k, v in self.data[target].rez do
			if (v == sender) then
				tremove(self.data[target].rez, k);
				break;
			end
		end
		if (getn(self.data[target].rez) == 0) then
			self.data[target].rez = nil;
		end
	end

	self:UpdateStatus(this);
	
end

function OneRaid.Unit:ADDON_SUMMONED(sender, action, target)

	if (sender ~= this.name) then return; end
	
	self.data[target].summoned = GetTime() + 120;
	self.data[target].summon = nil;
	
	self:UpdateStatus(this);
	
end

function OneRaid.Unit:ADDON_SUMMON(sender, action, target)

	if (target ~= this.name) then return; end
	
	self.data[target].summon = self.data[target].summon or {};
	
	if (action == "start") then
		tinsert(self.data[target].summon, sender);
	elseif (action == "stop") then
		for k, v in self.data[target].summon do
			if (v == sender) then
				tremove(self.data[target].summon, k);
				break;
			end
		end
		if (getn(self.data[target].summon) == 0) then
			self.data[target].summon = nil;
		end
	end

	self:UpdateStatus(this);
	
end

function OneRaid.Unit:ADDON_SUMMONCLICK(sender)

	if (sender ~= this.name) then return; end
	
	self.data[sender].summoned = nil;
	
	self:UpdateStatus(this);
	
end

function OneRaid.Unit:ADDON_AFK(sender, action)

	if (sender ~= this.name) then return; end
	
	self.data[sender].afk = self.data[sender].afk or 0;
	self.data[sender].afkTotal = self.data[sender].afkTotal or 0;
	
	if (action == "on") then
		self.data[sender].afk = GetTime();
	else
		self.data[sender].afkTotal = self.data[sender].afkTotal + (GetTime() - self.data[sender].afk);
		self.data[sender].afk = nil;
	end

	self:UpdateStatus(this);
	
end

function OneRaid.Unit:ADDON_VOICE(sender, action)

	if (sender ~= this.name) then return; end

	if (action == "on") then
		OneRaid.voice[sender] = 1;
	elseif (action == "off") then
		OneRaid.voice[sender] = nil;
	end
	
	self:UpdateVoice(this);

end

function OneRaid.Unit:ADDON_ZONED(sender)

	if (sender ~= this.name) then return; end
	
	if (self.data[sender].afk) then
		self:ADDON_AFK(sender, "off");
	end

end