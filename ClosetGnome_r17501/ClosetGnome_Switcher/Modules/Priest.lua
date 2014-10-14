local _,class = UnitClass("player")
if class ~= "PRIEST" then return end

local Babble = AceLibrary("Babble-Spell-2.0")
local SpecialEventsAura = AceLibrary("SpecialEvents-Aura-2.0")

ClosetGnomeSwitcher_Priest = ClosetGnomeSwitcher:NewModule("ClosetGnomeSwitcher_Priest", "AceEvent-2.0")

function ClosetGnomeSwitcher_Priest:OnInitialize()
	self.db = ClosetGnomeSwitcher:AcquireDBNamespace("Priest")
	ClosetGnomeSwitcher:RegisterDefaults("Priest", "char", {
		shadowSet = nil,
	})

	ClosetGnomeSwitcher.Opts.args.shadowFormSet = {
		type = 'text',
		name = 'Shadowform Set',
		desc = 'The set to use when in Shadowform.',
		usage = '<setName>',
		get = function() return self.db.char.shadowSet end,
		set = function(v) self.db.char.shadowSet = v end,
	}
end

function ClosetGnomeSwitcher_Priest:DoSwitch()
	if self.db.char.shadowSet ~= nil and SpecialEventsAura:UnitHasBuff("player", Babble["Shadowform"]) then
		ClosetGnomeSwitcher:WearSet(self.db.char.shadowSet)
		return true
	else
		return false
	end
end

