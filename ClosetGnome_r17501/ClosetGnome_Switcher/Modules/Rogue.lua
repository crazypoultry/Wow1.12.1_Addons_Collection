local _,class = UnitClass("player")
if class ~= "ROGUE" then return end

local Babble = AceLibrary("Babble-Spell-2.0")

ClosetGnomeSwitcher_Rogue = ClosetGnomeSwitcher:NewModule("ClosetGnomeSwitcher_Rogue", "AceEvent-2.0")

function ClosetGnomeSwitcher_Rogue:OnInitialize()
	self.db = ClosetGnomeSwitcher:AcquireDBNamespace("Rogue")
	ClosetGnomeSwitcher:RegisterDefaults("Rogue", "char", {
		stealthSet = nil,
	})

	ClosetGnomeSwitcher.Opts.args.stealthSet = {
		type = 'text',
		name = 'Stealth Set',
		desc = 'The set to use when in Stealthed.',
		usage = '<setName>',
		get = function() return self.db.char.stealthSet end,
		set = function(v) self.db.char.stealthSet = v end,
	}
end

function ClosetGnomeSwitcher_Rogue:DoSwitch()
	local currentForm = ClosetGnomeSwitcher:GetCurrentShapeshiftForm()

	if self.db.char.stealthSet ~= nil and currentForm == Babble["Stealth"]  then 
		ClosetGnomeSwitcher:WearSet(self.db.char.stealthSet)	
		return true
	else
		return false
	end
end
