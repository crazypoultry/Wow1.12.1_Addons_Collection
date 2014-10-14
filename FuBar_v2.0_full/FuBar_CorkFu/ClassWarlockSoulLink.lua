local _, c = UnitClass("player")
if c ~= "WARLOCK" then return end

local selearn = AceLibrary("SpecialEvents-LearnSpell-2.0")
local seaura = AceLibrary("SpecialEvents-Aura-2.0")
local tablet = AceLibrary("Tablet-2.0")

local gone = true

local icon = "Interface\\Icons\\Spell_Shadow_GatherShadows"
local core = FuBar_CorkFu

local slink = core:NewModule("Soul Link")
slink.target = "Self"


---------------------------
--      Ace Methods      --
---------------------------

function slink:OnEnable()
	self:RegisterEvent("UNIT_PET")
	self:RegisterEvent("SpecialEvents_UnitBuffLost")
	self:RegisterEvent("SpecialEvents_UnitBuffGained")

	self:TriggerEvent("CorkFu_Update")
end


function slink:OnDisable()
	seaura:UnregisterAllEvents(self)
end


----------------------------
--      Cork Methods      --
----------------------------

function slink:ItemValid()
	return selearn:SpellKnown("Soul Link")
end


function slink:UnitValid(unit)
	return unit == "pet" and UnitExists(unit) and not UnitIsDead(unit)
end


function slink:GetIcon()
	return icon
end


function slink:PutACorkInIt()
	if self:ItemValid() and self:UnitValid("pet") and not gone then
		CastSpellByName("Soul Link")
		return true
	end
end


function slink:OnTooltipUpdate()
	if not self:ItemValid() or not self:UnitValid("pet") or gone or self.db.profile["Filter Everyone"] == -1 then return end

	local cat = tablet:AddCategory("hideBlankLine", true)
	cat:AddLine("text", "Soul Link", "hasCheck", true, "checked", true, "checkIcon", icon,
		"func", self.PutACorkInIt, "arg1", self)
end


function slink:GetTopItem()
	if not self:ItemValid() or not self:UnitValid("pet") or self.db.profile["Filter Everyone"] == -1 then return end
	return icon, UnitName("pet")
end


------------------------------
--      Event Handlers      --
------------------------------

function slink:SLink()
	if seaura:UnitHasBuff("pet", "Soul Link") then return end
	gone = false
	self:TriggerEvent("CorkFu_Update")
end


function slink:UNIT_PET(unit)
	if unit == "player" then self:SLink() end
end


function slink:SpecialEvents_UnitBuffGained(unit, buff)
	if unit == "pet" and buff == "Soul Link" then
    gone = true
    self:TriggerEvent("CorkFu_Update")
  end
end


function slink:SpecialEvents_UnitBuffLost(unit, buff)
	if unit == "pet" and buff == "Soul Link" then self:SLink() end
end



