local AceOO = AceLibrary("AceOO-2.0")

local PlayerMana = AceOO.Class(IceUnitBar)

PlayerMana.prototype.manaType = nil
PlayerMana.prototype.tickStart = nil
PlayerMana.prototype.previousEnergy = nil

-- Constructor --
function PlayerMana.prototype:init()
	PlayerMana.super.prototype.init(self, "PlayerMana", "player")
	
	self:SetDefaultColor("PlayerMana", 62, 54, 152)
	self:SetDefaultColor("PlayerRage", 171, 59, 59)
	self:SetDefaultColor("PlayerEnergy", 218, 231, 31)
end


-- OVERRIDE
function PlayerMana.prototype:GetDefaultSettings()
	local settings = PlayerMana.super.prototype.GetDefaultSettings(self)
	settings["side"] = IceCore.Side.Right
	settings["offset"] = 1
	settings["tickerEnabled"] = true
	settings["tickerAlpha"] = 0.5
	return settings
end


-- OVERRIDE
function PlayerMana.prototype:GetOptions()
	local opts = PlayerMana.super.prototype.GetOptions(self)
	
	opts["tickerEnabled"] = {
		type = "toggle",
		name = "Show rogue/cat energy ticker",
		desc = "Show rogue/cat energy ticker",
		get = function()
			return self.moduleSettings.tickerEnabled
		end,
		set = function(value)
			self.moduleSettings.tickerEnabled = value
			self:ManaType(self.unit)
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 51
	}
	
	opts["tickerAlpha"] = 
	{
		type = 'range',
		name = 'Energy Ticker Alpha',
		desc = 'Energy Ticker Alpha',
		min = 0.1,
		max = 1,
		step = 0.05,
		get = function()
			return self.moduleSettings.tickerAlpha
		end,
		set = function(value)
			self.moduleSettings.tickerAlpha = value
			self.tickerFrame:SetStatusBarColor(self:GetColor("PlayerEnergy", self.moduleSettings.tickerAlpha))
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 52
	}
	
	return opts
end


function PlayerMana.prototype:Enable(core)
	PlayerMana.super.prototype.Enable(self, core)
	
	self:CreateTickerFrame()

	self:RegisterEvent("UNIT_MANA", "Update")
	self:RegisterEvent("UNIT_MAXMANA", "Update")
	self:RegisterEvent("UNIT_RAGE", "Update")
	self:RegisterEvent("UNIT_MAXRAGE", "Update")
	self:RegisterEvent("UNIT_ENERGY", "UpdateEnergy")
	self:RegisterEvent("UNIT_MAXENERGY", "Update")
	
	self:RegisterEvent("UNIT_DISPLAYPOWER", "ManaType")

	self:ManaType(self.unit)
end


-- OVERRIDE
function PlayerMana.prototype:Redraw()
	PlayerMana.super.prototype.Redraw(self)

	if (self.moduleSettings.enabled) then
		self:CreateTickerFrame()
	end
end


-- OVERRIDE
function PlayerMana.prototype:UseTargetAlpha(scale)
	if (self.manaType == 1) then
		return (scale and (scale > 0))
	else
		return PlayerMana.super.prototype.UseTargetAlpha(self, scale)
	end
end


function PlayerMana.prototype:ManaType(unit)
	if (unit ~= self.unit) then
		return
	end
	
	self.manaType = UnitPowerType(self.unit)
	
	-- register ticker for rogue energy
	if (self.moduleSettings.tickerEnabled and (self.manaType == 3) and self.alive) then
		self.tickerFrame:Show()
		self.tickerFrame:SetScript("OnUpdate", function() self:EnergyTick() end)
	else
		self.tickerFrame:Hide()
		self.tickerFrame:SetScript("OnUpdate", nil)
	end
	
	self:Update(self.unit)
end


function PlayerMana.prototype:Update(unit)
	PlayerMana.super.prototype.Update(self)
	if (unit and (unit ~= "player")) then
		return
	end
	
	if (self.manaType ~= 3) then
		self.tickerFrame:Hide()
	end
	
	local color = "PlayerMana"
	if not (self.alive) then
		color = "Dead"
	else
		if (self.manaType == 1) then
			color = "PlayerRage"
		elseif (self.manaType == 3) then
			color = "PlayerEnergy"
		end
	end
	
	self:UpdateBar(self.mana/self.maxMana, color)
	
	-- hide ticker if rest of the bar is not visible
	if (self.alpha == 0) then
 		self.tickerFrame:SetStatusBarColor(self:GetColor("PlayerEnergy", 0))
 	else
 		self.tickerFrame:SetStatusBarColor(self:GetColor("PlayerEnergy", self.moduleSettings.tickerAlpha))
 	end


	self:SetBottomText1(self.manaPercentage)
	
	local amount = self:GetFormattedText(self.mana, self.maxMana)
	
	-- druids get a little shorted string to make room for druid mana in forms
	if (self.unitClass == "DRUID" and self.manaType ~= 0) then
		amount = self:GetFormattedText(self.mana)
	end
	self:SetBottomText2(amount, color)
end


function PlayerMana.prototype:UpdateEnergy(unit)
	if (unit and (unit ~= "player")) then
		return
	end
	
	
	if (not (self.previousEnergy) or (self.previousEnergy <= UnitMana(self.unit))) then
		self.tickStart = GetTime()
		self.tickerFrame:Show()
	end
	
	self.previousEnergy = UnitMana(self.unit)
	self:Update(unit)
end


function PlayerMana.prototype:EnergyTick()
	if not (self.tickStart) then
		self.tickerFrame:Hide()
		return
	end
	
	local now = GetTime()
	local elapsed = now - self.tickStart
	
	if (elapsed > 2) then
		self.tickStart = now
	end
	
	local pos = elapsed / 2
	local y = pos * (self.settings.barHeight-2)
	
	if (self.moduleSettings.side == IceCore.Side.Left) then
		self.tickerFrame.spark:SetTexCoord(1, 0, 1-pos-0.01, 1-pos)
	else
		self.tickerFrame.spark:SetTexCoord(0, 1, 1-pos-0.01, 1-pos)
	end
	
	self.tickerFrame:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", 0, y)
end


function PlayerMana.prototype:CreateTickerFrame()
	if not (self.tickerFrame) then
		self.tickerFrame = CreateFrame("StatusBar", nil, self.barFrame)
	end
	
	self.tickerFrame:SetFrameStrata("BACKGROUND")
	self.tickerFrame:SetWidth(self.settings.barWidth)
	self.tickerFrame:SetHeight(self.settings.barHeight)
	
	if not (self.tickerFrame.spark) then
		self.tickerFrame.spark = self.tickerFrame:CreateTexture(nil, "BACKGROUND")
		self.tickerFrame:Hide()
	end
	
	self.tickerFrame.spark:SetTexture(IceElement.TexturePath .. self.settings.barTexture)
	self.tickerFrame.spark:SetBlendMode("ADD")
	self.tickerFrame.spark:ClearAllPoints()
	self.tickerFrame.spark:SetAllPoints(self.tickerFrame)
	
	self.tickerFrame:SetStatusBarTexture(self.tickerFrame.spark)
	self.tickerFrame:SetStatusBarColor(self:GetColor("PlayerEnergy", self.moduleSettings.tickerAlpha))
	
	self.tickerFrame:ClearAllPoints()
	self.tickerFrame:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", 0, 0)
end


-- Load us up
PlayerMana:new()
