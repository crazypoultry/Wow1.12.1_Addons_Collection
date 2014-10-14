--{{{ Libraries
local RL = AceLibrary("RosterLib-2.0")
local L = AceLibrary("AceLocale-2.2"):new("Grid")
--}}}

GridStatusMana = GridStatus:NewModule("GridStatusMana")
GridStatusMana.menuName = "Mana"

--{{{ AceDB defaults
GridStatusMana.defaultDB = {
	debug = false,
	alert_lowMana = {
		text = "Low Mana",
		enable = true,
		color = { r = .5, g = .5, b = 1, a = 1 },
		priority = 40,
		threshold = 10,
		range = true,
	},
}
--}}}

GridStatusMana.options = false

--{{{ additional options
local low_manaOptions = {
	["threshold"] = {
		type = "range",
		name = L["Mana threshold"],
		desc = L["Set the percentage for the low mana warning."],
		max = 100,
		min = 0,
		step = 1,
		get = function ()
			      return GridStatusMana.db.profile.alert_lowMana.threshold
		      end,
		set = function (v)
			      GridStatusMana.db.profile.alert_lowMana.threshold = v
		      end,
	},
}
--}}}

function GridStatusMana:OnInitialize()
	self.super.OnInitialize(self)
	self:RegisterStatus("alert_lowMana", L["Low Mana warning"], low_manaOptions, true)
end

function GridStatusMana:OnEnable()
	self:RegisterEvent("Grid_UnitJoined")
	self:RegisterBucketEvent("UNIT_MANA", 0.2)
end


function GridStatusMana:UNIT_MANA(units)
	for unitid in pairs(units) do
		self:UpdateUnit(unitid)
	end
end


function GridStatusMana:Grid_UnitJoined(name)
	local unitid = RL:GetUnitIDFromName(name)
	if unitid then
		self:UpdateUnit(unitid)
	end

end


function GridStatusMana:UpdateAllUnits()
	local name, status, statusTbl

	for name, status, statusTbl in GridStatus:CachedStatusIterator("alert_lowMana") do
		self:Grid_UnitJoined(name)
	end
end


function GridStatusMana:UpdateUnit(unitid)
	local name = UnitName(unitid)
	if not name then return end
	
	local cur, max = UnitMana(unitid), UnitManaMax(unitid)
	if self:IsLowMana(unitid, cur, max) and
		not UnitIsDeadOrGhost(unitid) then
		self:StatusLowMana(unitid, true)
	else
		self:StatusLowMana(unitid, false)
	end
end


function GridStatusMana:IsLowMana(unitid, cur, max)
	if UnitPowerType(unitid) == 0 then 
		return (cur / max * 100) <= self.db.profile.alert_lowMana.threshold
	else
		return false
	end
end


-- all of these status functions should be turned into one generic CachedStatus function
function GridStatusMana:StatusLowMana(unitid, gained)
	local name = UnitName(unitid)
	local settings = self.db.profile.alert_lowMana

	-- return if this option isnt enabled
	if not settings.enable then return end

	if gained then
		GridStatus:SendStatusGained(name, "alert_lowMana",
				  settings.priority,
				  (settings.range and 40),
				  settings.color,
				  settings.text)

	else
		GridStatus:SendStatusLost(name, "alert_lowMana")
	end

end
