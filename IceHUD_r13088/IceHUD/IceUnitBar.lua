local AceOO = AceLibrary("AceOO-2.0")

IceUnitBar = AceOO.Class(IceBarElement)
IceUnitBar.virtual = true

IceUnitBar.prototype.unit = nil
IceUnitBar.prototype.alive = nil
IceUnitBar.prototype.tapped = nil

IceUnitBar.prototype.health = nil
IceUnitBar.prototype.maxHealth = nil
IceUnitBar.prototype.healthPercentage = nil
IceUnitBar.prototype.mana = nil
IceUnitBar.prototype.maxMana = nil
IceUnitBar.prototype.manaPercentage = nil

IceUnitBar.prototype.unitClass = nil
IceUnitBar.prototype.hasPet = nil



-- Constructor --
function IceUnitBar.prototype:init(name, unit)
	IceUnitBar.super.prototype.init(self, name)
	assert(unit, "IceUnitBar 'unit' is nil")
	
	self.unit = unit
	_, self.unitClass = UnitClass(self.unit)
	
	self:SetDefaultColor("Dead", 0.5, 0.5, 0.5)
	self:SetDefaultColor("Tapped", 0.8, 0.8, 0.8)
end


-- OVERRIDE
function IceUnitBar.prototype:GetDefaultSettings()
	local settings = IceUnitBar.super.prototype.GetDefaultSettings(self)
	
	settings["lowThreshold"] = 0
	
	return settings
end


-- OVERRIDE
function IceUnitBar.prototype:GetOptions()
	local opts = IceUnitBar.super.prototype.GetOptions(self)
	
	opts["lowThreshold"] = 
	{
		type = 'range',
		name =  '|cff22bb22Low Threshold|r',
		desc = 'Threshold of pulsing the bar (0 means never)',
		get = function()
			return self.moduleSettings.lowThreshold
		end,
		set = function(value)
			self.moduleSettings.lowThreshold = value
			self:Redraw()
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		min = 0,
		max = 1,
		step = 0.05,
		isPercent = true,
		order = 37
	}
	
	return opts
end


-- 'Public' methods -----------------------------------------------------------

function IceUnitBar.prototype:Enable()
	IceUnitBar.super.prototype.Enable(self)
	
	self:RegisterEvent("PLAYER_UNGHOST", "Alive")
	self:RegisterEvent("PLAYER_ALIVE", "Alive")
	self:RegisterEvent("PLAYER_DEAD", "Dead")
	
	self.alive = not UnitIsDeadOrGhost(self.unit)
	self.combat = UnitAffectingCombat(self.unit)
end


-- OVERRIDE
function IceUnitBar.prototype:Redraw()
	IceUnitBar.super.prototype.Redraw(self)
	
	if (self.moduleSettings.enabled) then
		self:Update(self.unit)
	end
end





-- 'Protected' methods --------------------------------------------------------

-- OVERRIDE
function IceUnitBar.prototype:CreateFrame()
	IceUnitBar.super.prototype.CreateFrame(self)
	
	self:CreateFlashFrame()
end

-- Creates the low amount warning frame
function IceUnitBar.prototype:CreateFlashFrame()
	if not (self.flashFrame) then
		self.flashFrame = CreateFrame("StatusBar", nil, self.frame)
	end
	
	self.flashFrame:SetFrameStrata("BACKGROUND")
	self.flashFrame:SetWidth(self.settings.barWidth)
	self.flashFrame:SetHeight(self.settings.barHeight)
	
	
	if not (self.flashFrame.flash) then
		self.flashFrame.flash = self.flashFrame:CreateTexture(nil, "BACKGROUND")
	end
	
	self.flashFrame.flash:SetTexture(IceElement.TexturePath .. self.settings.barTexture)
	self.flashFrame.flash:SetBlendMode("ADD")
	self.flashFrame.flash:SetAllPoints(self.flashFrame)
	
	self.flashFrame:SetStatusBarTexture(self.flashFrame.flash)

	
	self:SetScale(self.flashFrame.flash, 1)
	self.flashFrame:SetAlpha(0)

	self.flashFrame:ClearAllPoints()
	self.flashFrame:SetPoint("BOTTOM", self.frame, "BOTTOM", 0, 0)
end


-- OVERRIDE
function IceUnitBar.prototype:Update()
	IceUnitBar.super.prototype.Update(self)
	self.tapped = UnitIsTapped(self.unit) and (not UnitIsTappedByPlayer(self.unit))
	
	self.health = UnitHealth(self.unit)
	self.maxHealth = UnitHealthMax(self.unit)
	self.healthPercentage = math.floor( (self.health/self.maxHealth)*100 )
	
	self.mana = UnitMana(self.unit)
	self.maxMana = UnitManaMax(self.unit)
	self.manaPercentage = math.floor( (self.mana/self.maxMana)*100 )
	
	_, self.unitClass = UnitClass(self.unit)
end


function IceUnitBar.prototype:Alive()
	-- instead of maintaining a state for 3 different things
	-- (dead, dead/ghost, alive) just afford the extra function call here
	self.alive = not UnitIsDeadOrGhost(self.unit)
	self:Update(self.unit)
end


function IceUnitBar.prototype:Dead()
	self.alive = false
	self:Update(self.unit)
end


-- OVERRIDE
function IceUnitBar.prototype:UpdateBar(scale, color, alpha)
	IceUnitBar.super.prototype.UpdateBar(self, scale, color, alpha)
	
	if (not self.flashFrame) then
		-- skip if flashFrame hasn't been created yet
		return
	end
	
	self.flashFrame:SetStatusBarColor(self:GetColor(color))
	
	if (self.moduleSettings.lowThreshold > 0 and self.moduleSettings.lowThreshold >= scale and self.alive) then
		self.flashFrame:SetScript("OnUpdate", function() self:OnFlashUpdate() end)
	else
		self.flashFrame:SetScript("OnUpdate", nil)
		self.flashFrame:SetAlpha(0)
	end
end


function IceUnitBar.prototype:OnFlashUpdate()
	local time = GetTime()
	local decimals = time - math.floor(time)
	
	if (decimals > 0.5) then
		decimals = 1 - decimals
	end
	
	decimals = decimals*1.1 -- add more dynanic to the color change
	
	self.flashFrame:SetAlpha(decimals)
end


