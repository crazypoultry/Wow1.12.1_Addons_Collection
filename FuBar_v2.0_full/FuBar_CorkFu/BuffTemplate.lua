
local AceOO = AceLibrary("AceOO-2.0")
local seaura = AceLibrary("SpecialEvents-Aura-2.0")
local selearn = AceLibrary("SpecialEvents-LearnSpell-2.0")
local tablet = AceLibrary("Tablet-2.0")
local BS = AceLibrary("Babble-Spell-2.0")
local chips = AceLibrary("PaintChips-2.0")
local core = FuBar_CorkFu

local groupthresh = 3
local partyids = {player = "Self", pet = "Pet"}
local raidunitnum, raidgroups = {}, {}
for i=1,8 do raidgroups["group"..i] = true end
local raidunitnum = {}
for i=1,40 do raidunitnum["raid"..i] = i end
for i=1,4 do
	partyids["party"..i] = "Party"
	partyids["partypet"..i] = "Party Pet"
end
local function GetClassColor(unit)
	local _,class = UnitClass(unit)
	return chips(class)
end


local template = AceOO.Mixin {
	"OnEnable",
	"OnDisable",
	"ItemValid",
	"MultiValid",
	"UnitValid",
	"GetIcon",
	"PutACorkInIt",
	"PutACorkInItMulti",
	"GetUnitInGroup",
	"CorkFu_Rescan",
	"SpecialEvents_UnitBuffGained",
	"SpecialEvents_UnitBuffLost",
	"SpecialEvents_AuraRaidRosterUpdate",
	"SpecialEvents_AuraPartyMembersChanged",
	"SpecialEvents_AuraTargetChanged",
	"ScanUnits",
	"TestUnit",
	"GetSpell",
	"GetSpellFilter",
	"GetRank",
	"GetGroupNeeds",
	"OnTooltipUpdate",
	"GetTopItem",
}
core:RegisterTemplate("Buffs", template)



--~~ CorkFu_BuffTemplate = {}

--~~ function CorkFu_BuffTemplate:New(info)
--~~ 	local bt = AceAddon:new(info)
--~~ 	for i,v in pairs(template) do bt[i] = v end
--~~ 	bt.tagged = {}
--~~ 	bt:RegisterForLoad()
--~~ 	return bt
--~~ end


function template:OnEnable()
	if not self.tagged then self.tagged = {} end
	self:RegisterEvent("CorkFu_Rescan")

	self:RegisterEvent("SpecialEvents_UnitBuffLost")
	self:RegisterEvent("SpecialEvents_UnitBuffGained")
	if self.target ~= "Self" then self:RegisterEvent("SpecialEvents_AuraRaidRosterUpdate") end
	if self.target ~= "Self" then self:RegisterEvent("SpecialEvents_AuraPartyMembersChanged") end
	if self.target ~= "Self" then self:RegisterEvent("SpecialEvents_AuraTargetChanged") end

	self:ScanUnits()

	self:TriggerEvent("CorkFu_Update")
end


----------------------------
--      Cork Methods      --
----------------------------

function template:ItemValid()
	if self.spell then return selearn:SpellKnown(self.spell) end
	if self.spells then
		for i in pairs(self.spells) do
			if selearn:SpellKnown(i) then return true end
		end
	end
end


function template:MultiValid()
	if self.multispell then return selearn:SpellKnown(self.multispell) end
	if self.multispells then
		for i in pairs(self.multispells) do
			if selearn:SpellKnown(i) then return true end
		end
	end
end


function template:UnitValid(unit)
	return (self.target == "Self" and unit == "player")
	or self.target ~= "Self" and (GetNumRaidMembers() == 0 or (not partyids[unit]))
	and UnitExists(unit) and not UnitIsDeadOrGhost(unit) and UnitIsConnected(unit)
end


function template:GetIcon(unit)
	if raidgroups[unit] then return self.multispell and BS:GetSpellIcon(self.multispell) or self.icon end
	local spell = self:GetSpell(unit)
	return spell and BS:GetSpellIcon(spell) or self.icon
end


function template:GetTopItem()
	if not self:ItemValid() then return end

	local groupneeds = {}
	if self.MultiValid and self:MultiValid() then self:GetGroupNeeds(groupneeds) end

	for group,num in pairs(groupneeds) do
		if num >= groupthresh then
			return self:GetIcon("group"..group), "Group "..group, "group"..group
		end
	end

	for unit,val in pairs(self.tagged) do
		if val == true and self:UnitValid(unit) and not self:UnitIsFiltered(unit) then
			local color = (UnitInParty(unit) or UnitInRaid(unit)) and ("|cff".. GetClassColor(unit)) or "|cff00ff00"
			return self:GetIcon(unit), color.. UnitName(unit), unit
		end
	end
end


function template:PutACorkInIt(unit)
	if not unit then
		local _, _, unit = self:GetTopItem()
		return unit and self:PutACorkInIt(unit)
	end

	if raidgroups[unit] then return self:PutACorkInItMulti(unit) end

	local spell, rank, retarget = self:GetSpell(unit)

	if UnitExists("target") and UnitIsFriend("player", "target") and not UnitIsUnit("target", unit) then
		TargetUnit(unit)
		retarget = true
	end

	if rank and selearn:SpellKnown(spell, rank) then CastSpellByName(string.format("%s(Rank %s)", spell, rank))
	else CastSpellByName(spell) end

	if SpellIsTargeting() then SpellTargetUnit(unit) end
	if SpellIsTargeting() then SpellStopTargeting() end
	if retarget then TargetLastTarget() end
	return true
end


function template:PutACorkInItMulti(group)
	local spell, retarget = self.multispell
	local unit = self:GetUnitInGroup(tonumber(string.sub(group, 6)))

	if UnitExists("target") and UnitIsFriend("player", "target") and not UnitIsUnit("target", unit) then
		TargetUnit(unit)
		retarget = true
	end

	CastSpellByName(spell)

	if SpellIsTargeting() then SpellTargetUnit(unit) end
	if SpellIsTargeting() then SpellStopTargeting() end
	if retarget then TargetLastTarget() end
	return true
end


function template:GetUnitInGroup(group)
	for unit in pairs(self.tagged) do
		if raidunitnum[unit] then
			local _, _, g = GetRaidRosterInfo(raidunitnum[unit])
			if group == g then return unit end
		end
	end
end


------------------------------
--      Event Handlers      --
------------------------------


function template:CorkFu_Rescan(spell)
	if spell == self.spell or self.spells and self.spells[spell] or spell == self.multispell or spell == "All" then
		self:ScanUnits()
	end
end


function template:SpecialEvents_UnitBuffGained(unit, buff)
	if unit == "mouseover" then return end
	if (not self.spell or buff ~= self.spell)
	and (not self.spells or not self.spells[buff])
	and (not self.multispell or buff ~= self.multispell) then return end

	self.tagged[unit] = buff
	self:TriggerEvent("CorkFu_Update")
end


function template:SpecialEvents_UnitBuffLost(unit, buff)
	if unit == "mouseover" then return end
	if (not self.spell or buff ~= self.spell)
	and (not self.spells or not self.spells[buff])
	and (not self.multispell or buff ~= self.multispell) then return end

	if self.tagged[unit] == buff then
		self.tagged[unit] = true
		self:TriggerEvent("CorkFu_Update")
	end
end


function template:SpecialEvents_AuraRaidRosterUpdate()
	for i=1,GetNumRaidMembers() do self:TestUnit("raid"..i) end
	self:TriggerEvent("CorkFu_Update")
end


function template:SpecialEvents_AuraPartyMembersChanged()
	for i=1,GetNumPartyMembers() do self:TestUnit("party"..i) end
	self:TriggerEvent("CorkFu_Update")
end


function template:SpecialEvents_AuraTargetChanged()
	self.tagged.target = nil

	if UnitExists("target") and UnitIsFriend("target", "player") then
		local sb = seaura:UnitHasBuff("target", self.spell) and self.spell
		local mb = seaura:UnitHasBuff("target", self.multispell) and self.multispell
		if self.spells then
			for i in pairs(self.spells) do
				if seaura:UnitHasBuff("target", i) then sb = i end
			end
		end
		self.tagged.target = sb or mb or true
	end

	self:TriggerEvent("CorkFu_Update")
end


------------------------------
--      Helper Methods      --
------------------------------

function template:ScanUnits()
	self:TestUnit("player")
	if self.target ~= "Self" then
		for i=1,GetNumPartyMembers() do self:TestUnit("party"..i) end
		for i=1,GetNumRaidMembers() do self:TestUnit("raid"..i) end
	end
end


function template:TestUnit(unit)
	if not UnitExists(unit) then
		self.tagged[unit] = nil
		return
	end

	local sb = seaura:UnitHasBuff(unit, self.spell) and self.spell
	local mb = seaura:UnitHasBuff(unit, self.multispell) and self.multispell
	if self.spells then
		for i in pairs(self.spells) do
			if seaura:UnitHasBuff(unit, i) then sb = i end
		end
	end
	self.tagged[unit] = sb or mb or true
end


function template:GetSpell(unit)
	assert(unit, "No unit passed")
	assert(raidgroups[unit] or UnitExists(unit), "Unit does not exist")

	if self.multispell and IsShiftKeyDown() and selearn:SpellKnown(self.multispell) then return self.multispell
	elseif self.spell then return self.spell, self:GetRank(unit)
	elseif self.spells then
		if self.target == "Self" then
			return self.db.profile["Filter Everyone"] or self.defaultspell
		else
			local spell = self:GetSpellFilter(unit)
			if not spell then return end

			local ms = self.multispells and self.multispells[spell]
			if IsShiftKeyDown() and ms then return ms end

			local rank = self:GetRank(unit, self.spells[spell])
			return spell, rank
		end
	end
end


function template:GetSpellFilter(unit)
	assert(unit, "No unit passed")
	assert(UnitExists(unit), "Unit does not exist")
	assert(self.defaultspell, "No default spell")

	local def = self.defaultspell
	local istarget = unit == "target"
	local ispc = UnitIsPlayer(unit) and not UnitInParty(unit) and not UnitInRaid(unit)

	local pc = istarget and ispc and self.db.profile["Filter Target Player"]
	if pc then return pc ~= -1 and pc or def end

	local npc = istarget and not ispc and self.db.profile["Filter Target NPC"]
	if npc then return npc ~= -1 and npc or def end

	local byname = self.db.profile["Filter Unit "..UnitName(unit)]
	if byname then return byname ~= -1 and byname or def end

	local _,class = UnitClass(unit)
	local byclass = class and self.db.profile["Filter Class ".. class]
	if byclass then return byclass ~= -1 and byclass or def end

	local i, g, byparty
	if GetNumRaidMembers() > 0 then _, _, i = string.find(unit, "raid(%d+)") end
	if i then _, _, g = GetRaidRosterInfo(tonumber(i)) end
	if g then byparty = self.db.profile["Filter Party "..g] end
	if byparty then return byparty ~= -1 and byparty or def end

	local everyone = self.db.profile["Filter Everyone"]
	if everyone then return everyone ~= -1 and everyone or def end

	return def
end


function template:GetRank(unit, ranks)
	local ranklevels = type(ranks) == "table" and ranks or self.ranklevels
	if ranklevels then
		local plvl, ulvl = UnitLevel("player"), UnitLevel(unit)
		for i,v in ipairs(ranklevels) do
			local nextr = ranklevels[i+1]
			if not nextr then return
			elseif (ulvl + 10) < nextr then return i end
		end
	end
end


function template:OnTooltipUpdate()
	if not self:ItemValid() then return end

	local cat = tablet:AddCategory("columns", 2, "hideBlankLine", true)
	local groupneeds = {}
	if self.MultiValid and self:MultiValid() then self:GetGroupNeeds(groupneeds) end

	for group,num in pairs(groupneeds) do
		if num >= groupthresh then
			local icon = self:GetIcon("group"..group) or questionmark
			cat:AddLine("text", "Group "..group, "hasCheck", true, "checked", true, "checkIcon", icon, "text2", num.." units",
				"func", self.PutACorkInIt, "arg1", self, "arg2", "group"..group)
		end
	end

	for unit,val in pairs(self.tagged) do
		if val == true and self:UnitValid(unit) and not self:UnitIsFiltered(unit) then
			local hidden
			local color = (UnitInParty(unit) or UnitInRaid(unit)) and UnitClass(unit) and ("|cff".. GetClassColor(unit)) or "|cff00ff00"
			local name = unit and (color.. UnitName(unit))
			local icon = self:GetIcon(unit) or questionmark
			local group
			if partyids[unit] then group = partyids[unit]
			elseif GetNumRaidMembers() > 0 and raidunitnum[unit] then
				_,_,group = GetRaidRosterInfo(raidunitnum[unit])
				hidden = groupneeds[group] and groupneeds[group] >= groupthresh
				group = "Group "..group
			end
			if not hidden then
				cat:AddLine("text", name, "hasCheck", true, "checked", true, "checkIcon", icon,
					"func", self.PutACorkInIt, "arg1", self, "arg2", unit, "text2", group)
			end
		end
	end
end


function template:GetGroupNeeds(t)
	if GetNumRaidMembers() == 0 then return end
	for unit,val in pairs(self.tagged) do
		if raidunitnum[unit] and val == true and self:UnitValid(unit) and not self:UnitIsFiltered(unit) then
			local _,_,group = GetRaidRosterInfo(raidunitnum[unit])
			t[group] = (t[group] or 0) + 1
		end
	end
end


