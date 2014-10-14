local _,class = UnitClass("player")
if class ~= "DRUID" then return end

local Babble = AceLibrary("Babble-Spell-2.2")

ClosetGnomeSwitcher_Druid = ClosetGnomeSwitcher:NewModule("ClosetGnomeSwitcher_Druid", "AceEvent-2.0")

function ClosetGnomeSwitcher_Druid:OnInitialize()
	self.db = ClosetGnomeSwitcher:AcquireDBNamespace("Druid")
	ClosetGnomeSwitcher:RegisterDefaults("Druid", "char", {
		catSet = nil,
		bearSet = nil,
		travelSet = nil,
		moonkinSet = nil,
	})

	ClosetGnomeSwitcher.Opts.args.catSet = {
		type = 'text',
		name = 'Cat Form',
		desc = 'The set to use when in Druid Cat Form.',
		usage = '<setName>',
		get = function() return self.db.char.catSet end,
		set = function(v) self.db.char.catSet = v end,
	}
	ClosetGnomeSwitcher.Opts.args.bearSet = {
		type = 'text',
		name = 'Bear Form',
		desc = 'The set to use when in Cat Form.',
		usage = '<setName>',
		get = function() return self.db.char.bearSet end,
		set = function(v) self.db.char.bearSet = v end,
	}
	ClosetGnomeSwitcher.Opts.args.travelSet = {
		type = 'text',
		name = 'Travel Form',
		desc = 'The set to use when in Travel Form.',
		usage = '<setName>',
		get = function() return self.db.char.travelSet end,
		set = function(v) self.db.char.travelSet = v end,
	}
	ClosetGnomeSwitcher.Opts.args.moonkinSet = {
		type = 'text',
		name = 'Moonkin Form',
		desc = 'The set to use when in Moonkin Form.',
		usage = '<setName>',
		get = function() return self.db.char.moonkinSet end,
		set = function(v) self.db.char.moonkinSet = v end,
	}
end

function ClosetGnomeSwitcher_Druid:OnEnable()
end

function ClosetGnomeSwitcher_Druid:DoSwitch()
	local currentForm = ClosetGnomeSwitcher:GetCurrentShapeshiftForm()

	if self.db.char.catSet ~= nil and currentForm == Babble["Cat Form"]  then 
		ClosetGnomeSwitcher:WearSet(self.db.char.catSet)	
		return true
	elseif self.db.char.bearSet ~= nil and (currentForm == Babble["Bear Form"] or currentForm == Babble["Dire Bear Form"]) then
		ClosetGnomeSwitcher:WearSet(self.db.char.bearSet)
		return true
	elseif self.db.char.travelSet ~= nil and (currentForm == Babble["Travel Form"] or currentForm == Babble["Dire Bear Form"]) then
		ClosetGnomeSwitcher:WearSet(self.db.char.travelSet)
		return true
	elseif self.db.char.moonkinSet ~= nil and (currentForm == Babble["Moonkin Form"] or currentForm == Babble["Dire Bear Form"]) then
		ClosetGnomeSwitcher:WearSet(self.db.char.moonkinSet)
		return true
	else
		return false
	end
end
