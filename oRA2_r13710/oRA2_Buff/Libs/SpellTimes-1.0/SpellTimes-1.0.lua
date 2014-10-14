--[[
Name: SpellTimes-1.0
Revision: $Rev: 13355 $
Author(s): Grimwald
Website: http://svn.wowace.com/
Documentation: http://wiki.wowace.com/index.php
SVN: http://svn.wowace.com/root/branches/oRA2_Buff/Grimwald/SpellTimes-1.0
Description: A library to provide buff times and cooldowns for spells.
Dependencies: AceLibrary, AceDebug, AceEvent, Babble-Spell-2.0, Compost-2.0, RosterLib-2.0
]]

local MAJOR_VERSION = "SpellTimes-1.0"
local MINOR_VERSION = tonumber(string.sub("$Revision: 13355 $", 12, -3))

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

if not AceLibrary:HasInstance("AceDebug-2.0") then error(MAJOR_VERSION .. " requires AceDebug-2.0") end
if not AceLibrary:HasInstance("AceEvent-2.0") then error(MAJOR_VERSION .. " requires AceEvent-2.0") end
if not AceLibrary:HasInstance("Babble-Spell-2.0") then error(MAJOR_VERSION .. " requires Babble-Spell-2.0") end
if not AceLibrary:HasInstance("Compost-2.0") then error(MAJOR_VERSION .. " requires Compost-2.0") end
if not AceLibrary:HasInstance("RosterLib-2.0") then error(MAJOR_VERSION .. " requires RosterLib-2.0") end


----------------------------
--   LIBRARY REFERENCES   --
----------------------------

local AceDebug = AceLibrary("AceDebug-2.0")
local AceEvent = AceLibrary("AceEvent-2.0")
local BS = AceLibrary("Babble-Spell-2.0")
local Compost = AceLibrary("Compost-2.0")
local Roster = AceLibrary("RosterLib-2.0")


--------------------
--   SPELL DATA   --
--------------------

local Spells = {
	-----------
	-- DRUID
	-----

	["Innervate"] = {
		["cooldown"] = 360,
		["duration"] = 20,
	},

	["Mark of the Wild"] = {
		["duration"] = 1800,
		["ra_rn_id"] = 2,
		["ra_rn_subid"] = 1,
	},
	["Gift of the Wild"] = {
		["duration"] = 3600,
		["ra_rn_id"] = 2,
		["ra_rn_subid"] = 2,
	},

	["Rebirth"] = {
		["cooldown"] = 1800,
		["ra_cd_id"] = 1,
		["group"] = "Combat Resurrections"
	},

	["Regrowth"] = {
		["duration"] = 21,
		["ra_rn_id"] = 19,
		["group"] = "Druid: Heals over Time",
	},
	["Rejuvenation"] = {
		["duration"] = 12,
		["ra_rn_id"] = 18,
		["group"] = "Druid: Heals over Time",
	},

	["Thorns"] = {
		["duration"] = 600,
		["ra_rn_id"] = 9,
	},


	----------
	-- MAGE
	----

	["Amplify Magic"] = {
		["duration"] = 600,
		["ra_rn_id"] = 20,
		["group"] = 20,
	},
	["Dampen Magic"] = {
		["duration"] = 600,
		["ra_rn_id"] = 21,
		["group"] = 20,
	},

	["Arcane Intellect"] = {
		["duration"] = 1800,
		["ra_rn_id"] = 3,
		["ra_rn_subid"] = 1,
	},
	["Arcane Brilliance"] = {
		["duration"] = 3600,
		["ra_rn_id"] = 3,
		["ra_rn_subid"] = 2,
	},


	-------------
	-- PALADIN
	-------

	["Blessing of Kings"] = {
		["duration"] = 300,
		["ra_rn_id"] = 13,
		["ra_rn_subid"] = 1,
	},
	["Greater Blessing of Kings"] = {
		["duration"] = 900,
		["ra_rn_id"] = 13,
		["ra_rn_subid"] = 2,
	},

	["Blessing of Light"] = {
		["duration"] = 300,
		["ra_rn_id"] = 15,
		["ra_rn_subid"] = 1,
	},
	["Greater Blessing of Light"] = {
		["duration"] = 900,
		["ra_rn_id"] = 15,
		["ra_rn_subid"] = 2,
	},

	["Blessing of Might"] = {
		["duration"] = 300,
		["ra_rn_id"] = 11,
		["ra_rn_subid"] = 1,
	},
	["Greater Blessing of Might"] = {
		["duration"] = 900,
		["ra_rn_id"] = 11,
		["ra_rn_subid"] = 2,
	},

	["Blessing of Sanctuary"] = {
		["duration"] = 300,
		["ra_rn_id"] = 16,
		["ra_rn_subid"] = 1,
	},
	["Greater Blessing of Sanctuary"] = {
		["duration"] = 900,
		["ra_rn_id"] = 16,
		["ra_rn_subid"] = 2,
	},

	["Blessing of Salvation"] = {
		["duration"] = 300,
		["ra_rn_id"] = 14,
		["ra_rn_subid"] = 1,
	},
	["Greater Blessing of Salvation"] = {
		["duration"] = 900,
		["ra_rn_id"] = 14,
		["ra_rn_subid"] = 2,
	},

	["Blessing of Wisdom"] = {
		["duration"] = 300,
		["ra_rn_id"] = 12,
		["ra_rn_subid"] = 1,
	},
	["Greater Blessing of Wisdom"] = {
		["duration"] = 900,
		["ra_rn_id"] = 12,
		["ra_rn_subid"] = 2,
	},


	------------
	-- PRIEST
	------

	["Divine Spirit"] = {
		["duration"] = 1800,
		["ra_rn_id"] = 8,
		["ra_rn_subid"] = 1,
	},
	["Prayer of Spirit"] = {
		["duration"] = 3600,
		["ra_rn_id"] = 8,
		["ra_rn_subid"] = 2,
	},

	["Fear Ward"] = {
		["duration"] = 600,
		["ra_rn_id"] = 10,
	},

	["Power Word: Fortitude"] = {
		["duration"] = 1800,
		["ra_rn_id"] = 1,
		["ra_rn_subid"] = 1,
	},
	["Prayer of Fortitude"] = {
		["duration"] = 3600,
		["ra_rn_id"] = 1,
		["ra_rn_subid"] = 2,
	},

	["Power Word: Shield"] = {
		["duration"] = 30,
		["ra_rn_id"] = 6,
	},

	["Renew"] = {
		["duration"] = 15,
		["ra_rn_id"] = 17,
	},

	["Shadow Protection"] = {
		["duration"] = 600,
		["ra_rn_id"] = 5,
		["ra_rn_subid"] = 1,
	},
	["Prayer of Shadow Protection"] = {
		["duration"] = 1200,
		["ra_rn_id"] = 5,
		["ra_rn_subid"] = 2,
	},


	------------
	-- SHAMAN
	------

	["Reincarnation"] = {
		["cooldown"] = 3600,
		["ra_cd_id"] = 2,
		["group"] = "Soulstone Resurrections"
	},


	-------------
	-- WARLOCK
	-------

	["Soulstone Resurrection"] = {
		["cooldown"] = 1800,
		["duration"] = 1800,
		["ra_cd_id"] = 3,
		["ra_rn_id"] = 7,
		["group"] = "Soulstone Resurrections"
	},
}
local _Spells_Lookup, _Spells_AmbigiousLookup = {}, {}


-----------------------
--   LOOKUP TABLES   --
-----------------------

local Buffs, _Buffs_Lookup, _Buffs_AmbigiousLookup, BuffNames = {}, {}, {}, {}
local BuffGroups, BuffGroupNames = {}, {}

local Cooldowns, _Cooldowns_Lookup, _Cooldowns_AmbigiousLookup, CooldownNames = {}, {}, {}, {}
local CooldownGroups, CooldownGroupNames = {}, {}

local BuffTimes, CooldownTimes = {}, {}

local UnitNames = {}


------------------------
--   INITIALISATION   --
------------------------

local PLAYER = UnitName("player")


local _Spell_MT = {
	__lt = function(a, b)
		return a["name"] < b["name"]
	end,
	__le = function(a, b)
		return a["name"] <= b["name"]
	end,
	__eq = function(a, b)
		return a["name"] == b["name"]
	end,
	__tostring = function(spell)
		return spell["name"]
	end,
}


local function AddLookup(lookup, ambigiouslookup, key, value)
	local existingvalues = ambigiouslookup[key]
	if existingvalues then
		table.insert(existingvalues, value)
	else
		local existingvalue = lookup[key]
		if existingvalue then
			ambigiouslookup[key] = {existingvalue, value}
			lookup[key] = nil
		else
			lookup[key] = value
		end
	end
end

local function AddSpell(spells, lookup, ambigiouslookup, groups, spell)
	-- sort the spell into 
	spells[spell["name"]] = spell

	-- add a lookup by texture
	AddLookup(lookup, ambigiouslookup, spell["texture"], spell)

	-- sort the spell into it's group
	local spellgroup = spell["group"]
	if spellgroup then
		local existinggroup = groups[spellgroup]
		if existinggroup then
			table.insert(existinggroup, spell)
		else
			groups[spellgroup] = {spell}
		end
	end
end


local function CreateGroups(groups, groupnames, _groups)
	local name

	for key, spells in pairs(_groups) do
		if type(key) == "string" then
			name = key
		else
			local spellnames = Compost:Acquire()

			for _, spell in ipairs(spells) do
				table.insert(spellnames, spell["name"])
			end

			table.sort(spellnames)
			name = table.concat(spellnames, ", ")

			Compost:Reclaim(spellnames)
		end

		groups[name] = spells
		table.insert(groupnames, name)

		for _, spell in ipairs(spells) do
			spell["group"] = name
		end
	end
	table.sort(groupnames)
end


local function OnInitialise()
	-- generate name, texture and group attributes for spells automatically
	-- add spell to the buff and cooldown tables and create the lookup tables
	local buffgroups, cooldowngroups = Compost:Acquire(), Compost:Acquire()
	local ra_cd_id, ra_rn_id, ra_rn_subid, spellname, spelltexture

	for _spellname, spell in pairs(Spells) do
		setmetatable(spell, _Spell_MT)

		spellname = BS[_spellname]
		spelltexture = BS:GetSpellIcon(_spellname)

		spell["index"] = _spellname
		spell["name"] = spellname
		spell["texture"] = spelltexture

		if _spellname ~= spellname then
			AddLookup(_Spells_Lookup, _Spells_AmbigiousLookup, spellname, spell)
		end
		AddLookup(_Spells_Lookup, _Spells_AmbigiousLookup, spelltexture, spell)

		if spell["duration"] then
			-- it's a buff
			ra_rn_id, ra_rn_subid = spell["ra_rn_id"], spell["ra_rn_subid"]
			if ra_rn_id then
				-- add RN lookup
				AddLookup(_Buffs_Lookup, _Buffs_AmbigiousLookup, ra_rn_id.." "..(ra_rn_subid or "0"), spell)

				-- add group entry
				if ra_rn_id and not spell["group"] then 
					spell["group"] = ra_rn_id
				end
			end

			AddSpell(Buffs, _Buffs_Lookup, _Buffs_AmbigiousLookup, buffgroups, spell)
			table.insert(BuffNames, spellname)
		end

		if spell["cooldown"] then
			-- spell has a cooldown to track
			ra_cd_id = spell["ra_cd_id"]
			if ra_cd_id then
				-- add CD lookup
				AddLookup(_Cooldowns_Lookup, _Cooldowns_AmbigiousLookup, tostring(ra_cd_id), spell)
			end

			AddSpell(Cooldowns, _Cooldowns_Lookup, _Cooldowns_AmbigiousLookup, cooldowngroups, spell)
			table.insert(CooldownNames, spellname)
		end
	end

	-- set lookup tables as __index in the metatable
	setmetatable(Spells, {__index = _Spells_Lookup})

	setmetatable(Buffs, {__index = _Buffs_Lookup})
	setmetatable(Cooldowns, {__index = _Cooldowns_Lookup})

	-- sort name tables
	table.sort(BuffNames)
	table.sort(CooldownNames)

	-- create group tables
	CreateGroups(BuffGroups, BuffGroupNames, buffgroups)
	CreateGroups(CooldownGroups, CooldownGroupNames, cooldowngroups)

	Compost:Reclaim(buffgroups)
	Compost:Reclaim(cooldowngroups)
end


------------------------------------
--   SPELL TIMES INITIALISATION   --
------------------------------------

local _UnitSpellTimes_MT = {
	__index = function(spelltimes, spellname)
		-- check if the spell can be found using an alternate (unique) key
		local spell = _Spells_Lookup[spellname]
		if spell then return spelltimes[spell["index"]] end

		-- check if the spell can be found using ambigious keys
		local possiblespells = _Spells_AmbigiousLookup[spellname]
		if possiblespells then
			local endtime
			for _, spell in pairs(possiblespells) do
				endtime = spelltimes[spellname]
				if endtime then return endtime end
			end
		end
	end
}


local function UnitSpellTimes_New()
	return setmetatable(Compost:Acquire(), _UnitSpellTimes_MT)
end

local function UnitSpellTimes_Free(ust)
	Compost:Reclaim(ust)
end


-------------------------------
--   SPELL TIMES ITERATORS   --
-------------------------------

local function _DoNothing() end

local function Iterate(Times, _timeleft, spellname)
	local spell = Spells[spellname]
	if spell then
		local duration = spell[_timeleft]
		if duration then
			local spellname, now, texture = spell["name"], GetTime(), spell["texture"]

			local iterator = function(_unittimes, unitname)
				local unitbuffs, endtime
				repeat
					unitname, unitbuffs = next(_unittimes, unitname)
					if not unitbuffs then return end
					endtime = unitbuffs[spellname] or 0
				until endtime > now
				return unitname, texture, duration, endtime - now
			end

			return iterator, Times
		end
	end

	return _DoNothing
end

local function IterateGroup(Groups, Times, _timeleft, groupname)
	local spells = Groups[groupname]
	if spells then
		local timeleft = 0
		for _, spell in spells do
			if spell[_timeleft] > timeleft then
				timeleft = spell[_timeleft]
			end
		end

		if timeleft then
			-- for the iteration over the group
			local spellid, spell = next(spells)
			-- for the iteration over units
			local now, texture = GetTime(), spell["texture"]

			local iterator = function(_unittimes, unitname)
				local unittimes, endtime
				repeat
					-- move to the next unit
					unitname, unittimes = next(_unittimes, unitname)
					if not unittimes then
						-- move to the next spell
						spellid, spell = next(spells, spellid)
						if not spell then return end
						texture = spell["texture"]

						-- start iterating for the new spell
						unitname, unittimes = next(_unittimes)
					end

					endtime = unittimes[spell["name"]] or 0
				until endtime > now
				return unitname, texture, timeleft, endtime - now
			end

			return iterator, Times
		end
	end

	return _DoNothing
end

local function IterateUnit(Times, _timeleft, unitname)
	local unittimes = Times[unitname]
	if unittimes then
		local now = GetTime()
		
		local iterator = function(_unittimes, spellname)
			local endtime
			repeat
				spellname, endtime = next(_unittimes, spellname)
				if not spellname then return end
			until endtime > now
			local spell, timeleft = Spells[spellname], endtime - now
			return spellname, spell["texture"], spell[_timeleft] or timeleft, timeleft
		end

		return iterator, unittimes
	end

	return _DoNothing
end


----------------------------
--   LIBRARY DEFINITION   --
----------------------------

local SpellTimes = {}

SpellTimes.Buffs = Buffs
SpellTimes.BuffNames = BuffNames
SpellTimes.BuffGroups = BuffGroups
SpellTimes.BuffGroupNames = BuffGroupNames
SpellTimes.Cooldowns = Cooldowns
SpellTimes.CooldownNames = CooldownNames
SpellTimes.CooldownGroups = CooldownGroups
SpellTimes.CooldownGroupNames = CooldownGroupNames

SpellTimes.BuffTimes = BuffTimes
SpellTimes.CooldownTimes = CooldownTimes

SpellTimes.UnitNames = UnitNames


------------------------
--   EVENT HANDLERS   --
------------------------

function SpellTimes:OnUnitJoined(unitname)
	local u = Roster:GetUnitObjectFromName(unitname)
	local unitspelltimes

	unitspelltimes = BuffTimes[unitname] or UnitSpellTimes_New()
	BuffTimes[unitname] = unitspelltimes
	u["st_buffs"] = unitspelltimes

	unitspelltimes = CooldownTimes[unitname] or UnitSpellTimes_New()
	CooldownTimes[unitname] = unitspelltimes
	u["st_cooldowns"] = unitspelltimes
end

function SpellTimes:OnUnitLeft(unitname)
	local unitbufftimes, unitcooldowntimes = BuffTimes[unitname], CooldownTimes[unitname]
	BuffTimes[unitname], CooldownTimes[unitname] = nil, nil

	if unitbufftimes then
		for spellname, _ in pairs(unitbufftimes) do
			self:TriggerEvent("SpellTimes_BuffChanged", spellname)
		end
		UnitSpellTimes_Free(BuffTimes[unitname])
	end
	if unitcooldowntimes then
		for spellname, _ in pairs(unitcooldowntimes) do
			self:TriggerEvent("SpellTimes_CooldownChanged", spellname)
		end
		UnitSpellTimes_Free(CooldownTimes[unitname])
	end
	self:TriggerEvent("SpellTimes_UnitChanged", unitname)
end

function SpellTimes:OnRosterChanged(units)
	local name, oldname, u, bufftimes, cdtimes
	for _, unit in pairs(units) do
		if unit["class"] ~= "PET" then
			name, oldname = unit["name"], unit["oldname"]
			if not oldname then
				self:OnUnitJoined(name)
			elseif not name then
				self:OnUnitLeft(oldname)
			end
		end
	end

	Compost:Erase(UnitNames)
	for name, unit in pairs(Roster.roster) do
		if unit["class"] ~= "PET" then
			table.insert(UnitNames, name)
		end
	end
	table.sort(UnitNames)
end


function SpellTimes:OnEnable()
	-- acquire or reclaim tables for units joining or leaving the raid
    self:RegisterEvent("RosterLib_RosterChanged", "OnRosterChanged")
end


-------------------------
--   LIBRARY METHODS   --
-------------------------

function SpellTimes:BuffGained(unitname, buffname, source)
	local buff = Buffs[buffname]
	if buff then
		local duration = buff["duration"]
		if duration then
			self:BuffChanged(unitname, buff["name"], duration, source)
		end
	end
end

function SpellTimes:BuffChanged(unitname, buffname, timeleft, source)
	local unitbufftimes = BuffTimes[unitname]
	if not unitbufftimes then
		self:Debug(source .. ": unit " .. unitname .. " not found")
		return
	end

	local buff = Buffs[buffname]
	if not buff then
		self:Debug(source .. " (" .. unitname .. "): buff '" .. buffname .. "' not found")
		return
	end
	buffname = buff["name"]

	local now = GetTime()
	if timeleft and timeleft > 1 then
		local endtime = now + timeleft

		if math.abs(endtime - (unitbufftimes[buffname] or 0)) > 1 then
			unitbufftimes[buffname] = endtime

			self:TriggerEvent("SpellTimes_BuffChanged", buffname)
			if buff["group"] then self:TriggerEvent("SpellTimes_BuffGroupChanged", buff["group"]) end
			self:TriggerEvent("SpellTimes_UnitChanged", unitname)
		end
	elseif ((unitbufftimes[buffname] or 0) - now) > 1 then
		unitbufftimes[buffname] = nil

		self:TriggerEvent("SpellTimes_BuffChanged", buffname)
		if buff["group"] then self:TriggerEvent("SpellTimes_BuffGroupChanged", buff["group"]) end
		self:TriggerEvent("SpellTimes_UnitChanged", unitname)
	end
end

function SpellTimes:BuffLost(unitname, buffname, source)
	self:BuffChanged(unitname, buffname, nil, source)
end


function SpellTimes:CooldownTriggered(unitname, cdname, source)
	local cd = Cooldowns[cdname]
	if cd then
		local duration = cd["cooldown"]
		if duration then
			self:CooldownChanged(unitname, cdname, duration, source)
		end
	end
end

function SpellTimes:CooldownChanged(unitname, cdname, timeleft, source)
	local unitcooldowntimes = CooldownTimes[unitname]
	if not unitcooldowntimes then
		self:Debug(source .. ": unit " .. unitname .. " not found")
		return
	end

	local cd = Cooldowns[cdname]
	if not cd then
		self:Debug(source .. " (" .. unitname .. "): cooldown '" .. cdname .. "' not found")
		return
	end
	cdname = cd["name"]

	local now = GetTime()
	local endtime = now + timeleft

	if (endtime - (unitcooldowntimes[cdname] or 0)) > 1 then
		unitcooldowntimes[cdname] = endtime

		self:TriggerEvent("SpellTimes_CooldownChanged", cdname)
		if cd["group"] then self:TriggerEvent("SpellTimes_CooldownGroupChanged", cd["group"]) end
		self:TriggerEvent("SpellTimes_UnitChanged", unitname)
	end
end


function SpellTimes:GetBuffIterator()
	return function(buffname)
		return Iterate(BuffTimes, "duration", buffname)
	end
end

function SpellTimes:GetBuffGroupIterator()
	return function(buffname)
		return IterateGroup(BuffGroups, BuffTimes, "duration", buffname)
	end
end

function SpellTimes:GetUnitBuffIterator()
	return function(unitname)
		return IterateUnit(BuffTimes, "duration", unitname)
	end
end

function SpellTimes:GetCooldownIterator()
	return function(cdname)
		return Iterate(CooldownTimes, "cooldown", cdname)
	end
end

function SpellTimes:GetCooldownGroupIterator()
	return function(cdname)
		return IterateGroup(CooldownGroups, CooldownTimes, "cooldown", cdname)
	end
end

function SpellTimes:GetUnitCooldownIterator()
	return function(unitname)
		return IterateUnit(CooldownTimes, "cooldown", unitname)
	end
end


------------------------------
--   LIBRARY REGISTRATION   --
------------------------------

local function activate(self, oldlib, olddeactivate)
	if oldlib then
		-- upgrading from old version
		SpellTimes.BuffTimes = oldlib.BuffTimes
		SpellTimes.CooldownTimes = oldlib.CooldownTimes

		for _, unitspelltimes in pairs(SpellTimes.BuffTimes) do
			setmetatable(unitspelltimes, _UnitSpellTimes_MT)
		end
		for _, unitspelltimes in pairs(SpellTimes.CooldownTimes) do
			setmetatable(unitspelltimes, _UnitSpellTimes_MT)
		end
	else
		SpellTimes.BuffTimes = BuffTimes
		SpellTimes.CooldownTimes = CooldownTimes
	end

	-- initialise spell data
	OnInitialise()

	-- add player
	BuffTimes[PLAYER] = UnitSpellTimes_New()
	CooldownTimes[PLAYER] = UnitSpellTimes_New()

	if olddeactivate then
		-- clean up the old library
		olddeactivate(oldlib)
	end
end

local function deactivate(oldlib)
	oldlib:UnregisterAllEvents()
end

local function external(self, major, instance)
	if major == "AceEvent-2.0" then
		AceEvent = instance
		AceEvent:embed(self)
		self:OnEnable()
	elseif major == "AceDebug-2.0" then
		AceDebug = instance
		AceDebug:embed(self)
		self:SetDebugging(true)
		self.debugFrame = ChatFrame5
	elseif major == "Babble-Spell-2.0" then
		BS = instance
	elseif major == "Compost-2.0" then
		Compost = instance
	elseif major == "RosterLib-2.0" then
		Roster = instance
	end
end


AceLibrary:Register(SpellTimes, MAJOR_VERSION, MINOR_VERSION, activate, deactivate, external)
