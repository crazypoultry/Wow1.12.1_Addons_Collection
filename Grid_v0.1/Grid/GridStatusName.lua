--{{{ Libraries
local RL = AceLibrary("RosterLib-2.0")
local L = AceLibrary("AceLocale-2.2"):new("Grid")
--}}}

GridStatusName = GridStatus:NewModule("GridStatusName")
GridStatusName.menuName = "Unit Name"

--{{{ AceDB defaults
GridStatusName.defaultDB = {
	debug = false,
	unit_name = {
		text = "Unit Name",
		enable = true,
		color = { r = 1, g = 1, b = 1, a = 1 },
		priority = 1,
		letters = 3,
		class = true,
	},
}
--}}}	

GridStatusName.options = false

--{{{ additional options
local nameOptions = {
	["letters"] = {
		type = 'range',
		name = L["Letters"],
		desc = L["Number of unit name letters."],
		get = function() return GridStatusName.db.profile.unit_name.letters end,
		set = function(v) 
			GridStatusName.db.profile.unit_name.letters = v
			GridStatusName:UpdateAllUnits()
		end,
		min = 0,
		max = 4,
		step = 1,
		isPercent = false,
		order = 120,
	},
	["class"] = {
		type = 'toggle',
		name = L["Color by class"],
		desc = L["Color by class"],
		get = function() return GridStatusName.db.profile.unit_name.class end,
		set = function()
			GridStatusName.db.profile.unit_name.class = not GridStatusName.db.profile.unit_name.class
			GridStatusName:UpdateAllUnits()
		end,
		order = 150,
	},
	["range"] = false,    -- this module doesnt need a range filter, so lets remove the option
	                    -- unfortunately it doesnt work anyway. sigh.
}
--}}}

function GridStatusName:OnInitialize()
	self.super.OnInitialize(self)
	self:RegisterStatus("unit_name", L["Unit Name"], nameOptions, true)
end

function GridStatusName:OnEnable()
	self:RegisterEvent("Grid_UnitChanged", "UpdateUnit")
	self:RegisterEvent("Grid_UnitJoined", "UpdateUnit")
	self:UpdateAllUnits()
end

function GridStatusName:Reset()
	self.super.Reset(self)
	self:UpdateAllUnits()
end

function GridStatusName:UpdateUnit(name, unitid)
	local settings = self.db.profile.unit_name
	
	-- set text
	local text = ""
	if settings.letters >= 1 then
		text = string.sub(name, 1, settings.letters)
	end
	
	-- set color
	local color = settings.color
	if settings.class then
		local u = RL:GetUnitObjectFromName(name)
		color = RAID_CLASS_COLORS[u.class]
		color.a = 1
	end

	self.core:SendStatusGained(name, "unit_name",
				    settings.priority,
				    nil,
				    color,
				    text)
end

function GridStatusName:UpdateAllUnits()
	local name, status, statusTbl

	for name, status, statusTbl in self.core:CachedStatusIterator("unit_name") do
		self:UpdateUnit(name)
	end
end
