assert(oRA, "oRA not found!")


------------------------------
--      Are you local?      --
------------------------------

local MAX_BUFFS = 16
local PLAYER = UnitName("player")


local SEA = AceLibrary("SpecialEvents-Aura-2.0")
local ST = AceLibrary("SpellTimes-1.0")

local L = AceLibrary("AceLocale-2.0"):new("Grimwald_oRAOBuffLocal")


local _UnitsDirty = false


----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["bufflocaloptional"] = true,
	["Optional/Buff"] = true,
	["bufflocal"] = true,
	["Buff"] = true,
	["Options for buffs."] = true,
} end)


----------------------------------
--      Module Declaration      --
----------------------------------

oRAOBuffLocal = oRA:NewModule(L["bufflocaloptional"])

oRAOBuffLocal.defaults = {
}
oRAOBuffLocal.optional = true
oRAOBuffLocal.name = L["Optional/Buff"]


------------------------------
--      Initialization      --
------------------------------

function oRAOBuffLocal:OnInitialize()
	local core, name = self.core, L["bufflocaloptional"]

	-- register at core
	core:RegisterModule(name, self)
	core:RegisterDefaults(name, "profile", self.defaults)
	self.db = core:AcquireDBNamespace(name)
	self.debugFrame = core.debugFrame

	self:SetDebugging(true)
end

function oRAOBuffLocal:OnEnable()
	-- acquire or reclaim tables for units joining or leaving the raid
    self:RegisterEvent("RosterLib_RosterChanged", "RosterChanged")
	self:RegisterEvent("SpecialEvents_AuraRaidRosterUpdate", "RosterChanged_AurasUpdated")
	self:RegisterEvent("SpecialEvents_AuraPartyMembersChanged", "RosterChanged_AurasUpdated")

	-- keep track of buffs on the player
	self:RegisterEvent("SpecialEvents_PlayerBuffGained", "PlayerBuffGained")
	self:RegisterEvent("PLAYER_AURAS_CHANGED", "PlayerBuffsChanged")

	-- keep track of buffs on units in range
	self:RegisterEvent("SpecialEvents_UnitBuffGained", "UnitBuffGained")
    self:RegisterEvent("SpecialEvents_UnitBuffLost", "UnitBuffLost")
end


------------------------------
--      Event Handlers      --
------------------------------

-- handle units joining and leaving the party or raid
-- this could be called before or after or after RosterChanged_AurasUpdated
function oRAOBuffLocal:RosterChanged(units)
	_UnitsDirty  = not _UnitsDirty
end

function oRAOBuffLocal:RosterChanged_AurasUpdated()
	_UnitsDirty  = not _UnitsDirty
end


-- player gaining a buff - also is triggered at login
function oRAOBuffLocal:PlayerBuffGained(buffname)
	ST:BuffGained(PLAYER, buffname, "PLAYER")
end

-- at least one buff has changed... maybe rebuffed?
function oRAOBuffLocal:PlayerBuffsChanged()
	local unitbuffs = ST.BuffTimes[PLAYER]
	local buff, buffindex

	for _buffname, buffid in SEA:BuffIter("player") do
		buff = ST.Buffs[_buffname]
		if buff then
			buffindex = GetPlayerBuff(buffid, "HELPFUL")
			if buffindex >= 0 then
				ST:BuffChanged(PLAYER, buff["name"], GetPlayerBuffTimeLeft(buffindex), "PLAYER")
			end
		end
	end
end


-- handle units receiving Buffs and add them to the table if the duration is known
function oRAOBuffLocal:UnitBuffGained(unitid, buffname)
	if _UnitsDirty or unitid == target then return end

	-- check if this update was triggered because an aura changed,
	-- not because a unit joined the raid or was moved
	if arg1 ~= unitid then return end

	-- we're not interested in "player"...
	if UnitIsUnit(unitid, "player") then return end

	ST:BuffGained(UnitName(unitid), buffname, "UNIT")
end

-- units losing a buff
function oRAOBuffLocal:UnitBuffLost(unitid, buffname)
	-- we're not interested in "target"...
	if unitid == "target" then return end

	ST:BuffLost(UnitName(unitid), buffname, "UNIT")
end
