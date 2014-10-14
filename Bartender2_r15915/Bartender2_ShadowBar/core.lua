BT2ShadowBar = Bartender:NewModule("shadowbar")
local BS = AceLibrary("Babble-Spell-2.2")

function BT2ShadowBar:OnEnable()
	self.ab = {}
	self.ab[2] = 8
	self:RegisterEvent("SpecialEvents_PlayerBuffGained", "ShiftON")
	self:RegisterEvent("SpecialEvents_PlayerBuffLost", "ShiftOFF")
	Bartender:Print("Shadow Bar enabled")
end

function BT2ShadowBar:ShiftON(buffName, buffIndex)
	if buffName == BS["Shadowform"] then 
	self.ab[1] = CURRENT_ACTIONBAR_PAGE
	CURRENT_ACTIONBAR_PAGE = self.ab[2]
	ChangeActionBarPage()
	end
end

function BT2ShadowBar:ShiftOFF(buffName)
	if buffName == BS["Shadowform"] then 
	CURRENT_ACTIONBAR_PAGE = self.ab[1]
	ChangeActionBarPage()
	end
end
