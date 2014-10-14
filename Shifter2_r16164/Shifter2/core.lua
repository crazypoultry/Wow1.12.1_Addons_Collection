local BS = AceLibrary("Babble-Spell-2.2")
Shifter2 = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0")

Shifter2:RegisterDB("Shifter2DB")
Shifter2:RegisterDefaults("profile", {
} )

function Shifter2:OnInitialize()

end

function Shifter2:OnEnable()
	self.Forms = {}
	self:LoadForms()
	self:RegisterEvent("LEARNED_SPELL_IN_TAB", "LoadForms")
end

function Shifter2:OnDisable()

end

function Shifter2:LoadForms()
	local i
	local n = GetNumShapeshiftForms()
	if n ~= 0 then
		for i=1,n do
		local _, name = GetShapeshiftFormInfo(i)
		self.Forms[name] = i
	end
end
end

function Shifter2:CurrentForm()
	local cf = "Humanoid"
	for i=1,GetNumShapeshiftForms() do
		local _, name, isActive = GetShapeshiftFormInfo(i)
		if isActive == 1 then cf = name end
	end
	return cf
end

function Shifter2:Shift(f)
	local _, class = UnitClass("player")
	if class == "DRUID" then
	if f ~= cf then
		CastShapeshiftForm(self.Forms[f])
	else
		CastShapeshiftForm(self.Forms[cf])
	end
	else return end
end
