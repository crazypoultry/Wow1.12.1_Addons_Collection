local AceOO = AceLibrary("AceOO-2.0")

local DruidMana = AceOO.Class(IceUnitBar)

DruidMana.prototype.inForms = nil
DruidMana.prototype.mode = nil
DruidMana.prototype.druidMana = nil
DruidMana.prototype.druidMaxMana = nil


-- Constructor --
function DruidMana.prototype:init()
	DruidMana.super.prototype.init(self, "DruidMana", "player")
	self.side = IceCore.Side.Right
	self.offset = 0
	
	self:SetDefaultColor("DruidMana", 87, 82, 141)
end


function DruidMana.prototype:GetDefaultSettings()
	local settings = DruidMana.super.prototype.GetDefaultSettings(self)
	settings["side"] = IceCore.Side.Right
	settings["offset"] = 0
	settings["textVisible"] = {upper = true, lower = false}
	return settings
end


function DruidMana.prototype:Enable(core)
	DruidMana.super.prototype.Enable(self, core)
	
	if (IsAddOnLoaded("SoleManax")) then
		self.mode = "SoleManax"
		SoleManax:AddUser(self.UpdateSoleManax, TRUE, self)
		self:UpdateSoleManax(SoleManax:GetPlayerMana())
		
	elseif (IsAddOnLoaded("DruidBar")) then
		self.mode = "DruidBar"
		self:ScheduleRepeatingEvent("DruidBar", self.UpdateDruidBarMana, 0.2, self)
	end
	
	self:RegisterEvent("UNIT_DISPLAYPOWER", "FormsChanged")
	
	self:FormsChanged(self.unit)
end


function DruidMana.prototype:Disable(core)
	DruidMana.super.prototype.Disable(self, core)
	
	if (IsAddOnLoaded("SoleManax")) then
        SoleManax.DelUser(self.UpdateSoleManax)
    end
	
	if (IsAddOnLoaded("DruidBar")) then
		self:CancelScheduledEvent("DruidBar")
	end
end


function DruidMana.prototype:FormsChanged(unit)
	if (unit ~= self.unit) then
		return
	end

	self.inForms = (UnitPowerType(self.unit) ~= 0)
	self:Update()
end


function DruidMana.prototype:UpdateSoleManax(mana, maxMana)
	self:Update()
	self.druidMana = mana
	self.druidMaxMana = maxMana
end


function DruidMana.prototype:UpdateDruidBarMana()
	self:Update()
	self.druidMana = DruidBarKey.keepthemana
	self.druidMaxMana = DruidBarKey.maxmana
end


function DruidMana.prototype:Update()
	DruidMana.super.prototype.Update(self)
	if ((not self.alive) or (not self.inForms)) then
		self.frame:Hide()
		return
	else
		self.frame:Show()
	end
	
	self:UpdateBar(self.druidMana / self.druidMaxMana, "DruidMana")

	local percentage = (self.druidMana / self.druidMaxMana) * 100
	self:SetBottomText1(math.floor(percentage))
	self:SetBottomText2(self:GetFormattedText(string.format("%.0f", self.druidMana), string.format("%.0f", self.druidMaxMana)), "DruidMana")
end



-- Load us up (if we are a druid)
local _, unitClass = UnitClass("player")
if (unitClass == "DRUID" and (IsAddOnLoaded("SoleManax") or IsAddOnLoaded("DruidBar"))) then
	DruidMana:new()
end
