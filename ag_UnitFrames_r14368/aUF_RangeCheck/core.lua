--[[
	Range check code borrowed from PerfectRaid by Cladhaire.
	-> aUF_RangeCheck:RangeCheck()
]]

aUF_RangeCheck = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceEvent-2.0", "AceConsole-2.0")
local prox = ProximityLib:GetInstance("1")
local dimAlpha

function aUF_RangeCheck:OnInitialize()
	self:RegisterDB("aUFRangeCheck")
	self:RegisterDefaults('profile', {
		scanTime = 1.0,
		dimAlpha = 0.55,
	})
	self:RegisterChatCommand({ "/agufrc" }, {
		name = "agUF RangeCheck",
		desc = "Config for agUF RangeCheck",
		type = "group",
		args = {
			scantime = {
				name = "Scan time", type = 'range',
				desc = "Intervall the range should be checked.",
				min = 0.5, max = 3.0, step = 0.1,
				get = function() return self.db.profile.scanTime end,
				set = function(v)
					self.db.profile.scanTime = v
					self:UpdateScanTime()
				end,
				order = 1,
			},
			dimalpha = {
				name = "Transparency", type = 'range',
				desc = "Transparency of units who are out of range.",
				min = 0.1, max = 1.0, step = 0.1,
				get = function() return self.db.profile.dimAlpha end,
				set = function(v)
					self.db.profile.dimAlpha = v
					dimAlpha = v
				end,
				order = 2,
			},
		}
	})
	
	self.inraid = false
end

function aUF_RangeCheck:OnEnable()
	aUF_RangeCheck:RegisterEvent("RAID_ROSTER_UPDATE")
	dimAlpha = self.db.profile.dimAlpha
	
	if UnitInRaid("player") == 1 then
		self:RAID_ROSTER_UPDATE()
	end
end

function aUF_RangeCheck:OnDisable()
	self:Stop()
end

function aUF_RangeCheck:RAID_ROSTER_UPDATE()
	if GetNumRaidMembers() == 0 then
		self.inraid = false
		self:Stop()
	else
		if not self.inraid then
			self.inraid = true
			self:ScheduleRepeatingEvent("aUFRangeCheck", aUF_RangeCheck.RangeCheck, self.db.profile.scanTime, self)
		end
	end
end

function aUF_RangeCheck:Stop()
	self:CancelScheduledEvent("aUFRangeCheck")
	
	for unit in pairs(aUF.units) do
		aUF.units[unit].frame:SetAlpha(1.0)
	end
end

function aUF_RangeCheck:UpdateScanTime()
	if self.inraid then
		if self:IsEventScheduled("aUFRangeCheck") then
			self:CancelScheduledEvent("aUFRangeCheck")
			self:ScheduleRepeatingEvent("aUFRangeCheck", aUF_RangeCheck.RangeCheck, self.db.profile.scanTime, self)
		else
			self:ScheduleRepeatingEvent("aUFRangeCheck", aUF_RangeCheck.RangeCheck, self.db.profile.scanTime, self)
		end
	end
end

function aUF_RangeCheck:RangeCheck()
	local now = GetTime()
	
    for unit in pairs(aUF.units) do
		local _,time = prox:GetUnitRange(unit)
		if time and (now - time) < 6 then aUF.units[unit].frame:SetAlpha(1.0)
		else aUF.units[unit].frame:SetAlpha(dimAlpha) end
	end
end