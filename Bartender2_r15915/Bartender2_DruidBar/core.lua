BT2DruidBar = Bartender:NewModule("druidbar")
local BS = AceLibrary("Babble-Spell-2.2")

function BT2DruidBar:OnEnable()
	self.ab = {}
	self.ab[2] = 8
	self:RegisterEvent("SpecialEvents_PlayerBuffGained", "ShiftON")
	self:RegisterEvent("SpecialEvents_PlayerBuffLost", "ShiftOFF")
	Bartender:Print("Druid Bar enabled")
end

function BT2DruidBar:ShiftON(buffName, buffIndex)
	if buffName == BS["Prowl"] then 
	self.ab[1] = CURRENT_ACTIONBAR_PAGE
	CURRENT_ACTIONBAR_PAGE = self.ab[2]
	ChangeActionBarPage()
	end
end

function BT2DruidBar:ShiftOFF(buffName)
	if buffName == BS["Prowl"] then 
	CURRENT_ACTIONBAR_PAGE = self.ab[1]
	ChangeActionBarPage()
	end
end
