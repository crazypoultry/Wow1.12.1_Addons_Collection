local _,class = UnitClass("player")
if class ~= "WARRIOR" then return end

local Babble = AceLibrary("Babble-Spell-2.0")

ClosetGnomeSwitcher_Warrior = ClosetGnomeSwitcher:NewModule("ClosetGnomeSwitcher_Warrior", "AceEvent-2.0")

function ClosetGnomeSwitcher_Warrior:OnInitialize()
	self.db = ClosetGnomeSwitcher:AcquireDBNamespace("Warrior")
	ClosetGnomeSwitcher:RegisterDefaults("Warrior", "char", {
		battleStanceSet = nil,
		defensiveStanceSet = nil,
		berserkerStanceSet = nil,
	})

	ClosetGnomeSwitcher.Opts.args.battleStanceSet = {
		type = 'text',
		name = 'Battle Stance',
		desc = 'The set to use when in Battle Stance.',
		usage = '<setName>',
		get = function() return self.db.char.battleStanceSet end,
		set = function(v) self.db.char.battleStanceSet = v end,
	}
	ClosetGnomeSwitcher.Opts.args.defensiveStanceSet = {
		type = 'text',
		name = 'Defensive Stance',
		desc = 'The set to use when in Defensive Stance.',
		usage = '<setName>',
		get = function() return self.db.char.defensiveStanceSet end,
		set = function(v) self.db.char.defensiveStanceSet = v end,
	}
	ClosetGnomeSwitcher.Opts.args.berserkerStanceSet = {
		type = 'text',
		name = 'Beserker Stance',
		desc = 'The set to use when in Beserker Stance.',
		usage = '<setName>',
		get = function() return self.db.char.berserkerStanceSet end,
		set = function(v) self.db.char.berserkerStanceSet = v end,
	}
end

function ClosetGnomeSwitcher_Warrior:DoSwitch()
	local currentForm = ClosetGnomeSwitcher:GetCurrentShapeshiftForm()

	if self.db.char.battleStanceSet ~= nil and currentForm == Babble["Battle Stance"]  then 
		ClosetGnomeSwitcher:WearSet(self.db.char.battleStanceSet)	
		return true
	elseif self.db.char.defensiveStanceSet ~= nil and currentForm == Babble["Defensive Stance"]  then
		ClosetGnomeSwitcher:WearSet(self.db.char.defensiveStanceSet)
		return true
	elseif self.db.char.berserkerStanceSet ~= nil and currentForm == Babble["Berserker Stance"]  then
		ClosetGnomeSwitcher:WearSet(self.db.char.berserkerStanceSet)
		return true
	else
		return false
	end
end
