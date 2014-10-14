
local seaura = AceLibrary("SpecialEvents-Aura-2.0")
local pt = PeriodicTableEmbed:GetInstance("1")
local tablet = AceLibrary("Tablet-2.0")
local core = FuBar_CorkFu

local loc = {
	nicename = "Argent Dawn Commission",
	buff = "Argent Dawn Commission",
}
local buff, icon, buffed = loc.buff, "Interface\\Icons\\INV_Jewelry_Talisman_07"

-- Add localized zone names directly into this table!
local zones = {
	["Western Plaguelands"] = true,
	["Eastern Plaguelands"] = true,
	["Stratholme"] = true,
	["Scholomance"] = true,
}


local adc = core:NewModule(loc.nicename)
adc.target = "Self"


---------------------------
--      Ace Methods      --
---------------------------

function adc:OnEnable()
	self:RegisterEvent("CorkFu_Rescan")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:ZONE_CHANGED_NEW_AREA()
end


----------------------------
--      Cork Methods      --
----------------------------

function adc:ItemValid()
	return zones[GetRealZoneText()]
end


function adc:UnitValid(unit)
	return unit == "player"
end


function adc:GetIcon(unit)
	return icon
end


function adc:PutACorkInIt()
	if not self:ItemValid() or buffed or not self:UnitValid("player") or self.db.profile["Filter Everyone"] == -1 then return end

	local bag, slot = pt:GetBest("argentdawncommission")
	if bag and slot then
		PickupContainerItem(bag, slot)
		AutoEquipCursorItem()
		return true
	end
end


function adc:GetTopItem()
	if not self:ItemValid() or buffed or not self:UnitValid("player") or self.db.profile["Filter Everyone"] == -1 then return end
	return icon, loc.nicename
end


function adc:OnTooltipUpdate()
	if not self:ItemValid() or buffed or not self:UnitValid("player") or self.db.profile["Filter Everyone"] == -1 then return end

	local cat = tablet:AddCategory("hideBlankLine", true)
	cat:AddLine("text", loc.nicename, "hasCheck", true, "checked", true, "checkIcon", icon,
		"func", self.PutACorkInIt, "arg1", self)
end


------------------------------
--      Event Handlers      --
------------------------------

function adc:ZONE_CHANGED_NEW_AREA()
	SetMapToCurrentZone()

	if zones[GetRealZoneText()] then
		self:RegisterEvent("SpecialEvents_PlayerBuffLost")
		self:RegisterEvent("SpecialEvents_PlayerBuffGained")

		self:Scan()
	elseif self:IsEventRegistered("SpecialEvents_PlayerBuffLost") then
		self:UnregisterEvent("SpecialEvents_PlayerBuffLost")
		self:UnregisterEvent("SpecialEvents_PlayerBuffGained")
	end

	self:TriggerEvent("CorkFu_Update")
end


function adc:CorkFu_Rescan(spell)
	if spell == "All" then
		self:Scan()
		self:TriggerEvent("CorkFu_Update")
	end
end


function adc:SpecialEvents_PlayerBuffGained(newbuff)
	if newbuff ~= buff then return end

	buffed = true
	self:TriggerEvent("CorkFu_Update")
end


function adc:SpecialEvents_PlayerBuffLost(lostbuff)
	if lostbuff ~= buff then return end

	if buffed then
		buffed = nil
		self:TriggerEvent("CorkFu_Update")
	end
end


------------------------------
--      Helper Methods      --
------------------------------

function adc:Scan()
	buffed = seaura:UnitHasBuff("player", buff)
end


