local AceOO = AceLibrary("AceOO-2.0")

local PlayerHealth = AceOO.Class(IceUnitBar)

-- Constructor --
function PlayerHealth.prototype:init()
	PlayerHealth.super.prototype.init(self, "PlayerHealth", "player")
	
	self:SetDefaultColor("PlayerHealth", 37, 164, 30)
end


function PlayerHealth.prototype:GetDefaultSettings()
	local settings = PlayerHealth.super.prototype.GetDefaultSettings(self)
	settings["side"] = IceCore.Side.Left
	settings["offset"] = 1
	settings["hideBlizz"] = true
	return settings
end


function PlayerHealth.prototype:Enable(core)
	PlayerHealth.super.prototype.Enable(self, core)

	self:RegisterEvent("UNIT_HEALTH", "Update")
	self:RegisterEvent("UNIT_MAXHEALTH", "Update")

	if (self.moduleSettings.hideBlizz) then
		self:HideBlizz()
	end

	self:Update(self.unit)
end


-- OVERRIDE
function PlayerHealth.prototype:GetOptions()
	local opts = PlayerHealth.super.prototype.GetOptions(self)
	
	opts["classColor"] = {
		type = "toggle",
		name = "Class color bar",
		desc = "Use class color as the bar color instead of default color",
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
		order = 40
	}
	
	opts["hideBlizz"] = {
		type = "toggle",
		name = "Hide Blizzard Frame",
		desc = "Hides Blizzard Player frame and disables all events related to it",
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
		order = 41
	}
	
	return opts
end


function PlayerHealth.prototype:Update(unit)
	PlayerHealth.super.prototype.Update(self)
	if (unit and (unit ~= self.unit)) then
		return
	end

	local color = "PlayerHealth"

	if (self.moduleSettings.classColor) then
		color = self.unitClass
	end

	if not (self.alive) then
		color = "Dead"
	end


	self:UpdateBar(self.health/self.maxHealth, color)
	self:SetBottomText1(self.healthPercentage)
	self:SetBottomText2(self:GetFormattedText(self.health, self.maxHealth), color)
end




function PlayerHealth.prototype:ShowBlizz()
	PlayerFrame:Show()

	PlayerFrame:RegisterEvent("UNIT_LEVEL");
	PlayerFrame:RegisterEvent("UNIT_COMBAT");
	PlayerFrame:RegisterEvent("UNIT_FACTION");
	PlayerFrame:RegisterEvent("UNIT_MAXMANA");
	PlayerFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	PlayerFrame:RegisterEvent("PLAYER_ENTER_COMBAT");
	PlayerFrame:RegisterEvent("PLAYER_LEAVE_COMBAT");
	PlayerFrame:RegisterEvent("PLAYER_REGEN_DISABLED");
	PlayerFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
	PlayerFrame:RegisterEvent("PLAYER_UPDATE_RESTING");
	PlayerFrame:RegisterEvent("PARTY_MEMBERS_CHANGED");
	PlayerFrame:RegisterEvent("PARTY_LEADER_CHANGED");
	PlayerFrame:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");
	PlayerFrame:RegisterEvent("RAID_ROSTER_UPDATE");
	PlayerFrame:RegisterEvent("PLAYTIME_CHANGED");
end


function PlayerHealth.prototype:HideBlizz()
	PlayerFrame:Hide()

	PlayerFrame:UnregisterAllEvents()
end



-- Load us up
PlayerHealth:new()
