--{{{ Libraries
local Aura = AceLibrary("SpecialEvents-Aura-2.0")
local Dewdrop = AceLibrary("Dewdrop-2.0")
local L = AceLibrary("AceLocale-2.2"):new("Grid")
local BS = AceLibrary("Babble-Spell-2.2")
--}}}

GridStatusAuras = GridStatus:NewModule("GridStatusAuras")
GridStatusAuras.menuName = "Auras"


local function statusForSpell(spell, isBuff)
	local prefix = "debuff_"

	if isBuff then
		prefix = "buff_"
	end

	return prefix .. string.gsub(spell, "[^%a]", "")
end


GridStatusAuras.defaultDB = {
	debug = false,
	["debuff_poison"] = {
		["desc"] = L["Debuff type: "]..L["Poison"],
		["text"] = L["Poison"],
		["enable"] = true,
		["priority"] = 90,
		["range"] = true,
		["color"] = { r =  0, g = .6, b =  0, a = 1 },
	},
	["debuff_disease"] = {
		["desc"] = L["Debuff type: "]..L["Disease"],
		["text"] = L["Disease"],
		["enable"] = true,
		["priority"] = 90,
		["range"] = true,
		["color"] = { r = .6, g = .4, b =  0, a = 1 },
	},
	["debuff_magic"] = {
		["desc"] = L["Debuff type: "]..L["Magic"],
		["text"] = L["Magic"],
		["enable"] = true,
		["priority"] = 90,
		["range"] = true,
		["color"] = { r = .2, g = .6, b =  1, a = 1 },
	},
	["debuff_curse"] = {
		["desc"] = L["Debuff type: "]..L["Curse"],
		["text"] = L["Curse"],
		["enable"] = true,
		["priority"] = 90,
		["range"] = true,
		["color"] = { r = .6, g =  0, b =  1, a = 1 },
	},
	[statusForSpell(BS["Weakened Soul"])] = {
		["desc"] = L["Debuff: "]..BS["Weakened Soul"],
		["text"] = BS["Weakened Soul"],
		["enable"] = true,
		["priority"] = 90,
		["range"] = true,
		["color"] = { r = .5, g = .5, b = .5, a = 1 },

	},
	[statusForSpell(BS["Mortal Strike"])] = {
		["desc"] = L["Debuff: "]..BS["Mortal Strike"],
		["text"] = BS["Mortal Strike"],
		["enable"] = true,
		["priority"] = 90,
		["range"] = true,
		["color"] = { r = .8, g = .2, b = .2, a = 1 },
	},
	[statusForSpell(BS["Renew"], true)] = {
		["desc"] = L["Buff: "]..BS["Renew"],
		["text"] = BS["Renew"],
		["enable"] = true,
		["priority"] = 90,
		["range"] = true,
		["color"] = { r =  0, g = .7, b = .3, a = 1 },
	},
	[statusForSpell(BS["Rejuvenation"], true)] = {
		["desc"] = L["Buff: "]..BS["Rejuvenation"],
		["text"] = BS["Rejuvenation"],
		["enable"] = true,
		["priority"] = 90,
		["range"] = true,
		["color"] = { r =  0, g = .3, b = .7, a = 1 },
	},
	[statusForSpell(BS["Power Word: Shield"], true)] = {
		["desc"] = L["Buff: "]..BS["Power Word: Shield"],
		["text"] = BS["Power Word: Shield"],
		["enable"] = true,
		["priority"] = 91,
		["range"] = true,
		["color"] = { r = .8, g = .8, b =  0, a = 1 },
	},
 }

function GridStatusAuras:OnInitialize()
	self.super.OnInitialize(self)

	self:RegisterStatuses()
end


function GridStatusAuras:RegisterStatuses()
	local status, statusTbl, desc

	for status, statusTbl in pairs(self.db.profile) do
		if type(statusTbl) == "table" and statusTbl.text then
			desc = statusTbl.desc or statusTbl.text
			self:Debug("registering", status, desc)
			self:RegisterStatus(status, desc)
		end
	end
end


function GridStatusAuras:UnregisterStatuses()
	local status, moduleName, desc
	for status, moduleName, desc in self.core:RegisteredStatusIterator() do
		if moduleName == self.name then
			self:UnregisterStatus(status)
			self.options.args[status] = nil
		end
	end
end


function GridStatusAuras:OnEnable()
	self.debugging = self.db.profile.debug
	self:RegisterEvent("SpecialEvents_UnitDebuffGained")
	self:RegisterEvent("SpecialEvents_UnitDebuffLost")
	self:RegisterEvent("SpecialEvents_UnitBuffGained")
	self:RegisterEvent("SpecialEvents_UnitBuffLost")
	self:RegisterEvent("Grid_UnitDeath")
	self:CreateAddRemoveOptions()
end


function GridStatusAuras:Reset()
	self.super.Reset(self)

	self:UnregisterStatuses()
	self:RegisterStatuses()
	self:CreateAddRemoveOptions()
end


function GridStatusAuras:CreateAddRemoveOptions()
	self.options.args["add_buff"] = {
		type = "text",
		name = L["Add new Buff"],
		desc = L["Adds a new buff to the status module"],
		get = false,
		usage = "<buff name>",
		set = function(v) self:AddAura(v, true) end,
		order = 201
	}
	self.options.args["add_debuff"] = {
		type = "text",
		name = L["Add new Debuff"],
		desc = L["Adds a new debuff to the status module"],
		get = false,
		usage = "<debuff name>",
		set = function(v) self:AddAura(v, false) end,
		order = 202
	}
	self.options.args["delete_debuff"] = {
		type = "group",
		name = L["Delete (De)buff"],
		desc = L["Deletes an existing debuff from the status module"],
		args = {},
		order = 203
	}

	for status, statusTbl in pairs(self.db.profile) do
		local status = status
		if type(statusTbl) == "table" and statusTbl.text and not self.defaultDB[status] then
			local debuffName = (statusTbl.desc or statusTbl.text)
			self.options.args["delete_debuff"].args[status] = {
				type = "execute",
				name = debuffName,
				desc = string.format(L["Remove %s from the menu"], debuffName),
				func = function() return self:DeleteAura(status) end
			}
		end
	end
end


function GridStatusAuras:AddAura(name, isBuff)
	local status = statusForSpell(name, isBuff)
	local desc

	if isBuff then
		desc = L["Buff: "]..name
	else
		desc = L["Debuff: "]..name
	end

	self.db.profile[status] = {
		["text"] = name,
		["desc"] = desc,
		["enable"] = true,
		["priority"] = 90,
		["range"] = true,
		["color"] = { r = .5, g = .5, b = .5, a = 1 },
	}

	self:RegisterStatus(status, desc)
	self:CreateAddRemoveOptions()
end


function GridStatusAuras:DeleteAura(status)
	self:UnregisterStatus(status)
	self.options.args[status] = nil
	self.options.args["delete_debuff"].args[status] = nil
	self.db.profile[status] = nil
end


function GridStatusAuras:SpecialEvents_UnitDebuffGained(unit, debuff, apps, type, tex)
	-- check if this is a specific debuff or a debuff type
	local debuffNameStatus = statusForSpell(debuff, false)
	local debuffTypeStatus = "debuff_" .. strlower(type)
	self:Debug("gained",debuffNameStatus)
	local settings = self.db.profile[debuffNameStatus] or self.db.profile[debuffTypeStatus]
	local status   = (self.db.profile[debuffNameStatus] and debuffNameStatus) or debuffTypeStatus
	if not (settings and settings.enable) then return end

	self.core:SendStatusGained(UnitName(unit),
			status,
			settings.priority,
			(settings.range and 40),			
			settings.color,
			settings.text,
			nil,
			nil,
			tex)
end


function GridStatusAuras:SpecialEvents_UnitDebuffLost(unit, debuff, apps, type, tex)
	local debuffNameStatus = statusForSpell(debuff, false)
	local debuffTypeStatus = "debuff_" .. strlower(type)
	if self.db.profile[debuffNameStatus] then
		if not Aura:UnitHasDebuff(unit, debuff) then
			self:Debug("lost", debuffNameStatus)
			self.core:SendStatusLost(UnitName(unit), debuffNameStatus)
		end
	else
		if not Aura:UnitHasDebuffType(unit, type) then
			self:Debug("lost", debuffTypeStatus)
			self.core:SendStatusLost(UnitName(unit), debuffTypeStatus)
		end
	end
end


function GridStatusAuras:SpecialEvents_UnitBuffGained(unit, buff, apps, type, tex)
	local buffNameStatus = statusForSpell(buff, true)
	local settings = self.db.profile[buffNameStatus]
	if not (settings and settings.enable) then return end

	-- SE-Aura doesn't give the texture for buffs?
	if not tex then
		tex = BS:GetSpellIcon(buff)
	end
	self:Debug("gained", buffNameStatus, tex)
	self.core:SendStatusGained(UnitName(unit),
			buffNameStatus,
			settings.priority,
			(settings.range and 40),			
			settings.color,
			settings.text,
			nil,
			nil,
			tex)
end


function GridStatusAuras:SpecialEvents_UnitBuffLost(unit, buff, apps, type, tex)
	local buffNameStatus = statusForSpell(buff, true)
	if self.db.profile[buffNameStatus] then
		if not Aura:UnitHasBuff(unit, buff) then
			self.core:SendStatusLost(UnitName(unit), buffNameStatus)
		end
	end
end


function GridStatusAuras:Grid_UnitDeath(unitname)
	local status, moduleName, desc

	for status, moduleName, desc in self.core:RegisteredStatusIterator() do
		if moduleName == self.name then
			self.core:SendStatusLost(unitname, status)
		end
	end
end
