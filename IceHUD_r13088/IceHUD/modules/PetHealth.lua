local AceOO = AceLibrary("AceOO-2.0")

local PetHealth = AceOO.Class(IceUnitBar)

PetHealth.prototype.happiness = nil


-- Constructor --
function PetHealth.prototype:init()
	PetHealth.super.prototype.init(self, "PetHealth", "pet")
	
	self:SetDefaultColor("PetHealthHappy", 37, 164, 30)
	self:SetDefaultColor("PetHealthContent", 164, 164, 30)
	self:SetDefaultColor("PetHealthUnhappy", 164, 30, 30)
	
	self.scalingEnabled = true
end


-- OVERRIDE
function PetHealth.prototype:GetDefaultSettings()
	local settings = PetHealth.super.prototype.GetDefaultSettings(self)
	settings["side"] = IceCore.Side.Left
	settings["offset"] = -1
	settings.scale = 0.7
	return settings
end


-- OVERRIDE
function PetHealth.prototype:CreateFrame()
	PetHealth.super.prototype.CreateFrame(self)

	local point, relativeTo, relativePoint, xoff, yoff = self.frame.bottomUpperText:GetPoint()
	if (point == "TOPLEFT") then
		point = "BOTTOMLEFT"
	else
		point = "BOTTOMRIGHT"
	end

	self.frame.bottomUpperText:ClearAllPoints()
	self.frame.bottomUpperText:SetPoint(point, relativeTo, relativePoint, 0, 0)
end


function PetHealth.prototype:Enable(core)
	PetHealth.super.prototype.Enable(self, core)
	
	self:RegisterEvent("PET_UI_UPDATE",	 "CheckPet");
	self:RegisterEvent("PLAYER_PET_CHANGED", "CheckPet");
	self:RegisterEvent("PET_BAR_CHANGED", "CheckPet");
	self:RegisterEvent("UNIT_PET", "CheckPet");

	self:RegisterEvent("UNIT_HEALTH", "Update")
	self:RegisterEvent("UNIT_MAXHEALTH", "Update")
	
	self:RegisterEvent("UNIT_HAPPINESS", "PetHappiness")

	self:CheckPet()
end

function PetHealth.prototype:PetHappiness(unit)
	if (unit and (unit ~= self.unit)) then
		return
	end
	
	self.happiness = GetPetHappiness()
	self.happiness = self.happiness or 3 -- '3' means happy
	self:Update(unit)
end


function PetHealth.prototype:CheckPet()
	if (UnitExists(self.unit)) then
		self.frame:Show()
		self:PetHappiness(self.unit)
		self:Update(self.unit)
	else
		self.frame:Hide()
	end
end


function PetHealth.prototype:Update(unit)
	PetHealth.super.prototype.Update(self)
	if (unit and (unit ~= self.unit)) then
		return
	end
	
	local color = "PetHealthHappy"
	if (self.happiness == 2) then
		color = "PetHealthContent"
	elseif(self.happiness == 1) then
		color = "PetHealthUnhappy"
	end
	
	if not (self.alive) then
		color = "Dead"
	end


	self:UpdateBar(self.health/self.maxHealth, color)
	self:SetBottomText1(self.healthPercentage)
end



-- Load us up
PetHealth:new()
