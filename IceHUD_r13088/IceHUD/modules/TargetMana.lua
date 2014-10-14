local AceOO = AceLibrary("AceOO-2.0")

local TargetMana = AceOO.Class(IceUnitBar)


-- Constructor --
function TargetMana.prototype:init()
	TargetMana.super.prototype.init(self, "TargetMana", "target")
	
	self:SetDefaultColor("TargetMana", 52, 64, 221)
	self:SetDefaultColor("TargetRage", 235, 44, 26)
	self:SetDefaultColor("TargetEnergy", 228, 242, 31)
	self:SetDefaultColor("TargetFocus", 242, 149, 98)
end


function TargetMana.prototype:GetDefaultSettings()
	local settings = TargetMana.super.prototype.GetDefaultSettings(self)
	settings["side"] = IceCore.Side.Right
	settings["offset"] = 2
	return settings
end


function TargetMana.prototype:Enable(core)
	TargetMana.super.prototype.Enable(self, core)
	
	self:RegisterEvent("UNIT_MANA", "Update")
	self:RegisterEvent("UNIT_MAXMANA", "Update")
	self:RegisterEvent("UNIT_RAGE", "Update")
	self:RegisterEvent("UNIT_MAXRAGE", "Update")
	self:RegisterEvent("UNIT_ENERGY", "Update")
	self:RegisterEvent("UNIT_MAXENERGY", "Update")
	self:RegisterEvent("UNIT_AURA", "Update")
	self:RegisterEvent("UNIT_FLAGS", "Update")
	
	self:Update("target")
end



function TargetMana.prototype:Update(unit)
	TargetMana.super.prototype.Update(self)
	if (unit and (unit ~= self.unit)) then
		return
	end
	
	if ((not UnitExists(unit)) or (self.maxMana == 0)) then
		self.frame:Hide()
		return
	else	
		self.frame:Show()
	end
	
	
	local manaType = UnitPowerType(self.unit)
	
	local color = "TargetMana"
	if (manaType == 1) then
		color = "TargetRage"
	elseif (manaType == 2) then
		color = "TargetFocus"
	elseif (manaType == 3) then
		color = "TargetEnergy"
	end
	
	if (self.tapped) then
		color = "Tapped"
	end
	
	self:UpdateBar(self.mana/self.maxMana, color)
	self:SetBottomText1(self.manaPercentage)
	self:SetBottomText2(self:GetFormattedText(self.mana, self.maxMana), color)
end



-- Load us up
TargetMana:new()
