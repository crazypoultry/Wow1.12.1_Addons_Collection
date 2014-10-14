assert(oRA, "oRA not found!")


------------------------------
--      Are you local?      --
------------------------------

local PLAYER = UnitName("player")


local ST = AceLibrary("SpellTimes-1.0")

local L = AceLibrary("AceLocale-2.0"):new("Grimwald_oRAOCoolDown")


----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["grimwald_cooldownoptional"] = true,
	["Optional/Cooldown"] = true,
	["cd"] = true,
	["Cooldown"] = true,
	["Options for cooldowns."] = true,
	["print"] = true,
	["Print cooldown times"] = true,
	["Print the remaining cooldown times."] = true,

	["Cooldowns"] = true,
	["Cooldown: %s"] = true,
	["cdgroup"] = true,
	["Cooldown Groups"] = true,
	["Cooldowns: %s"] = true,
	["unitcd"] = true,
	["Cooldowns for %s"] = true,
	["Cooldowns (per unit)"] = true,
} end)


----------------------------------
--      Module Declaration      --
----------------------------------

oRAOCooldown = oRA:NewModule(L["grimwald_cooldownoptional"])

oRAOCooldown.defaults = {
}
oRAOCooldown.optional = true
oRAOCooldown.name = L["Optional/Cooldown"]
oRAOCooldown.consoleCmd = L["cd"]
oRAOCooldown.consoleOptions = {
	type = "group",
	name = L["Cooldown"],
	desc = L["Options for cooldowns."],
	args = {
		[L["print"]] = {
			type = "execute",
			name = L["Print cooldown times"],
			desc = L["Print the remaining cooldown times."],
			func = function()
				oRAOCooldown:PrintTimesLeft()
			end,
		},
		["test"] = {
			type = "text",
			name = "Test Sync Message",
			desc = "Test with a given sync message.",
			get = false,
			set = function(v)
				oRAOCooldown:UnitCoolDownReceived(v, PLAYER)
			end,
			usage = "<sync message>",
			visible = function() oRAOCooldown:IsDebugging() end,
		},
	}
}


------------------------------
--      Initialization      --
------------------------------

function oRAOCooldown:OnInitialize()
	local core, name = self.core, L["grimwald_cooldownoptional"]

	-- register at core
	core:RegisterModule(name, self)
	core:RegisterDefaults(name, "profile", self.defaults)
	self.db = core:AcquireDBNamespace(name)
	self.debugFrame = core.debugFrame
end

function oRAOCooldown:OnEnable()
	-- CTRA check
    self:RegisterCheck("CD", "UnitCoolDownReceived")

	-- register our timber bars
	if oRAOTimer then
		oRAOTimer:Register(
			L["cd"],
			"SpellTimes_CooldownChanged",
			ST:GetCooldownIterator(),
			ST.CooldownNames,
			L["Cooldowns"],
			L["Cooldown: %s"]
		)
		oRAOTimer:Register(
			L["cdgroup"],
			"SpellTimes_CooldownGroupChanged",
			ST:GetCooldownGroupIterator(),
			ST.CooldownGroupNames,
			L["Cooldown Groups"],
			L["Cooldowns: %s"]
		)
		oRAOTimer:Register(
			L["unitcd"],
			"SpellTimes_UnitChanged",
			ST:GetUnitCooldownIterator(),
			ST.UnitNames,
			L["Cooldowns (per unit)"],
			L["Cooldowns for %s"]
		)
	end
end


------------------------------
--      Event Handlers      --
------------------------------

-- handle received buff durations
function oRAOCooldown:UnitCoolDownReceived(message, sender)
	local _, _, _cd, timeleft = string.find(message, "CD ([%d]+) ([%d]+)")
	timeleft = tonumber(timeleft)
	if not timeleft then
		self:Debug("SYNC from "..sender..": '"..message.."' has invalid format")
		return
	end

	ST:CooldownChanged(sender, _cd, timeleft * 60, "SYNC")
end


---------------------------------
--      Utility Functions      --
---------------------------------

function oRAOCooldown:PrintTimesLeft()
	local now, endtime, time

	now = GetTime()
	for unitname, unitcds in ST.CooldownTimes do
		self:Print("CoolDowns for "..unitname..":")

		for cdname, endtime in pairs(unitcds) do
			-- is the end time not in the past?
			time = endtime - now
			if time > 0 then self:Print("   "..cdname..": "..SecondsToTimeAbbrev(time)) end
		end
	end
end
