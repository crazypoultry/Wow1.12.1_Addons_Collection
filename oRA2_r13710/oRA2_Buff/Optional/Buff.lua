assert(oRA, "oRA not found!")


------------------------------
--      Are you local?      --
------------------------------

local PLAYER = UnitName("player")


local ST = AceLibrary("SpellTimes-1.0")

local L = AceLibrary("AceLocale-2.0"):new("Grimwald_oRAOBuff")


----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["grimwald_buffoptional"] = true,
	["Optional/Buff"] = true,
	["buff"] = true,
	["Buff"] = true,
	["Options for buffs."] = true,
	["print"] = true,
	["Print buff times"] = true,
	["Print the remaining buff times."] = true,

	["Buffs"] = true,
	["Buff: %s"] = true,
	["buffgroup"] = true,
	["Buff Groups"] = true,
	["Buffs: %s"] = true,
	["unitbuff"] = true,
	["Buffs on %s"] = true,
	["Buffs (per unit)"] = true,
} end)


----------------------------------
--      Module Declaration      --
----------------------------------

oRAOBuff = oRA:NewModule(L["grimwald_buffoptional"])

oRAOBuff.defaults = {
}
oRAOBuff.optional = true
oRAOBuff.name = L["Optional/Buff"]
oRAOBuff.consoleCmd = L["buff"]
oRAOBuff.consoleOptions = {
	type = "group",
	name = L["Buff"],
	desc = L["Options for buffs."],
	args = {
		[L["print"]] = {
			type = "execute",
			name = L["Print buff times"],
			desc = L["Print the remaining buff times."],
			func = function()
				oRAOBuff:PrintTimesLeft()
			end,
		},
		["test"] = {
			type = "text",
			name = "Test Sync Message",
			desc = "Test with a given sync message.",
			get = false,
			set = function(v)
				oRAOBuff:UnitBuffReceived(v, PLAYER)
			end,
			usage = "<sync message>",
			visible = function() oRAOBuff:IsDebugging() end,
		},
	}
}


------------------------------
--      Initialization      --
------------------------------

function oRAOBuff:OnInitialize()
	local core, name = self.core, L["grimwald_buffoptional"]

	-- register at core
	core:RegisterModule(name, self)
	core:RegisterDefaults(name, "profile", self.defaults)
	self.db = core:AcquireDBNamespace(name)
	self.debugFrame = core.debugFrame
end

function oRAOBuff:OnEnable()
	-- CTRA check
    self:RegisterCheck("RN", "UnitBuffReceived")

	-- register our timber bars
	if oRAOTimer then
		oRAOTimer:Register(
			L["buff"],
			"SpellTimes_BuffChanged",
			ST:GetBuffIterator(),
			ST.BuffNames,
			L["Buffs"],
			L["Buff: %s"]
		)
		oRAOTimer:Register(
			L["buffgroup"],
			"SpellTimes_BuffGroupChanged",
			ST:GetBuffGroupIterator(),
			ST.BuffGroupNames,
			L["Buff Groups"],
			L["Buffs: %s"]
		)
		oRAOTimer:Register(
			L["unitbuff"],
			"SpellTimes_UnitChanged",
			ST:GetUnitBuffIterator(),
			ST.UnitNames,
			L["Buffs (per unit)"],
			L["Buffs on %s"]
		)
	end
end


------------------------------
--      Event Handlers      --
------------------------------

-- handle received buff durations
function oRAOBuff:UnitBuffReceived(message, sender)
	local _, _, timeleft, _buff = string.find(message, "RN ([%d]+) ([%d ]+)")
	timeleft = tonumber(timeleft)
	if not timeleft then
		self:Debug("SYNC from "..sender..": '"..message.."' has invalid format")
		return
	end

	ST:BuffChanged(sender, _buff, timeleft, "SYNC")
end


---------------------------------
--      Utility Functions      --
---------------------------------

function oRAOBuff:PrintTimesLeft()
	local now, endtime, time

	now = GetTime()
	for unitname, unitbuffs in ST.BuffTimes do
		self:Print("Buffs for "..unitname..":")

		for buffname, endtime in pairs(unitbuffs) do
			-- is the end time not in the past?
			time = endtime - now
			if time > 0 then self:Print("   "..buffname..": "..SecondsToTimeAbbrev(time)) end
		end
	end
end
