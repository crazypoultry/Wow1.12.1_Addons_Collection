local AceOO = AceLibrary("AceOO-2.0")

local TargetHealth = AceOO.Class(IceUnitBar, "AceHook-2.0")

TargetHealth.prototype.color = nil


-- Constructor --
function TargetHealth.prototype:init()
	TargetHealth.super.prototype.init(self, "TargetHealth", "target")
	
	self:SetDefaultColor("TargetHealthHostile", 231, 31, 36)
	self:SetDefaultColor("TargetHealthFriendly", 46, 223, 37)
	self:SetDefaultColor("TargetHealthNeutral", 210, 219, 87)
end


function TargetHealth.prototype:GetDefaultSettings()
	local settings = TargetHealth.super.prototype.GetDefaultSettings(self)
	settings["side"] = IceCore.Side.Left
	settings["offset"] = 2
	settings["mobhealth"] = false
	settings["classColor"] = false
	settings["hideBlizz"] = true
	return settings
end


-- OVERRIDE
function TargetHealth.prototype:GetOptions()
	local opts = TargetHealth.super.prototype.GetOptions(self)
	
	opts["mobhealth"] = {
		type = "toggle",
		name = "MobHealth3 support",
		desc = "Enable/disable MobHealth3 target HP data. If this option is gray, you do not have MobHealth3.",
		get = function()
			return self.moduleSettings.mobhealth
		end,
		set = function(value)
			self.moduleSettings.mobhealth = value
			self:Update(self.unit)
		end,
		disabled = function()
			return (not self.moduleSettings.enabled) and (MobHealth3 == nil)
		end,
		order = 40
	}
	
	opts["classColor"] = {
		type = "toggle",
		name = "Class color bar",
		desc = "Use class color as the bar color instead of reaction color",
		get = function()
			return self.moduleSettings.classColor
		end,
		set = function(value)
			self.moduleSettings.classColor = value
			self:Update(self.unit)
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 41
	}
	
	opts["hideBlizz"] = {
		type = "toggle",
		name = "Hide Blizzard Frame",
		desc = "Hides Blizzard Target frame and disables all events related to it",
		get = function()
			return self.moduleSettings.hideBlizz
		end,
		set = function(value)
			self.moduleSettings.hideBlizz = value
			if (value) then
				self:HideBlizz()
			else
				self:ShowBlizz()
			end
		end,
		disabled = function()
			return not self.moduleSettings.enabled
		end,
		order = 42
	}
	
	return opts
end


function TargetHealth.prototype:Enable(core)
	TargetHealth.super.prototype.Enable(self, core)
	
	self:RegisterEvent("UNIT_HEALTH", "Update")
	self:RegisterEvent("UNIT_MAXHEALTH", "Update")
	self:RegisterEvent("UNIT_FLAGS", "Update")
	
	if (self.moduleSettings.hideBlizz) then
		self:HideBlizz()
	end
		
	self:Update(self.unit)
end


function TargetHealth.prototype:Disable(core)
	TargetHealth.super.prototype.Disable(self, core)
end



function TargetHealth.prototype:Update(unit)
	TargetHealth.super.prototype.Update(self)
	if (unit and (unit ~= self.unit)) then
		return
	end
	
	if not (UnitExists(unit)) then
		self.frame:Hide()
		return
	else	
		self.frame:Show()
	end

	self.color = "TargetHealthFriendly" -- friendly > 4

	local reaction = UnitReaction("target", "player")
	if (reaction and (reaction == 4)) then
		self.color = "TargetHealthNeutral"
	elseif (reaction and (reaction < 4)) then
		self.color = "TargetHealthHostile"
	end
	
	if (self.moduleSettings.classColor) then
		self.color = self.unitClass
	end

	if (self.tapped) then
		self.color = "Tapped"
	end

	self:UpdateBar(self.health/self.maxHealth, self.color)
	self:SetBottomText1(self.healthPercentage)
	
	
	-- assumption that if a unit's max health is 100, it's not actual amount
	-- but rather a percentage - this obviously has one caveat though

	if (self.maxHealth == 100 and self.moduleSettings.mobhealth and MobHealth3) then
		self.health, self.maxHealth, _ = MobHealth3:GetUnitHealth(self.unit, self.health, self.maxHealth)

		self.health = self:Round(self.health)
		self.maxHealth = self:Round(self.maxHealth)
	end


	if (self.maxHealth ~= 100) then
		self:SetBottomText2(self:GetFormattedText(self.health, self.maxHealth), self.color)
	else
		self:SetBottomText2()
	end
end


function TargetHealth.prototype:Round(health)
	if (health > 1000000) then
		return self:MathRound(health/1000000, 1) .. "M"
	end
	if (health > 1000) then
		return self:MathRound(health/1000, 1) .. "k"
	end
	return health
end


function TargetHealth.prototype:MathRound(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num  * mult + 0.5) / mult
end





function TargetHealth.prototype:ShowBlizz()
	TargetFrame:Show()
	TargetFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
	TargetFrame:RegisterEvent("UNIT_HEALTH")
	TargetFrame:RegisterEvent("UNIT_LEVEL")
	TargetFrame:RegisterEvent("UNIT_FACTION")
	TargetFrame:RegisterEvent("UNIT_CLASSIFICATION_CHANGED")
	TargetFrame:RegisterEvent("UNIT_AURA")
	TargetFrame:RegisterEvent("PLAYER_FLAGS_CHANGED")
	TargetFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
	TargetFrame:RegisterEvent("RAID_TARGET_UPDATE")
	
	ComboFrame:Show()
	ComboFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
	ComboFrame:RegisterEvent("PLAYER_COMBO_POINTS");
end


function TargetHealth.prototype:HideBlizz()
	TargetFrame:Hide()
	TargetFrame:UnregisterAllEvents()
	
	ComboFrame:Hide()
	ComboFrame:UnregisterAllEvents()
end



-- Load us up
TargetHealth:new()
