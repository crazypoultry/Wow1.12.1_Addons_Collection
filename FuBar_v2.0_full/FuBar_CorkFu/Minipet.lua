
local pt = PeriodicTableEmbed:GetInstance("1")
local tablet = AceLibrary("Tablet-2.0")
local core = FuBar_CorkFu

local loc = {
	nicename = "Minipet",
	stone = "Hearthstone",
	astral = "Astral Recall",
	teleport = "Teleport"
}
local icon, needpet, state = "Interface\\Icons\\Ability_Seal", true


local minipet = core:NewModule(loc.nicename, "AceDebug-2.0")
minipet.debugFrame = ChatFrame5
minipet.target = "Self"


---------------------------
--      Ace Methods      --
---------------------------

function minipet:OnEnable()
	self:RegisterEvent("UNIT_FLAGS")
	self:RegisterEvent("CONFIRM_SUMMON")
	self:RegisterEvent("SPELLCAST_START")
	self:RegisterEvent("SPELLCAST_FAILED")
	self:RegisterEvent("SPELLCAST_INTERRUPTED", "SPELLCAST_FAILED")
	self:RegisterEvent("PLAYER_CONTROL_GAINED", "ActivateIfState")
	self:RegisterEvent("SPELLCAST_STOP", "ActivateIfState")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "ActivatePet")
	self:RegisterEvent("PLAYER_UNGHOST", "ActivatePet")
	self:RegisterEvent("BANKFRAME_OPENED")
	self:RegisterEvent("BANKFRAME_CLOSED")
end


----------------------------
--      Cork Methods      --
----------------------------

function minipet:ItemValid()
	if pt:GetBest("minipetall") then return true end
end


function minipet:GetIcon(unit)
	return icon
end


function minipet:PutACorkInIt()
	if not self:ItemValid() or not needpet or self.db.profile["Filter Everyone"] == -1 then return end
	self:Debug("Putting out the cat")

	local petbags, petslots = {}, {}
	for bag,slot in pt:BagIter("minipetall") do
		table.insert(petbags, bag)
		table.insert(petslots, slot)
	end

	if not next(petbags) then return end

	local ridx = math.random(1, table.getn(petbags))
	self:Debug("Using %s:%s", petbags[ridx], petslots[ridx])
	UseContainerItem(petbags[ridx], petslots[ridx])
	needpet = nil
	return true
end


function minipet:GetTopItem()
	if not self:ItemValid() or not needpet or self.db.profile["Filter Everyone"] == -1 then return end
	return icon, loc.nicename
end


function minipet:OnTooltipUpdate()
	if not self:ItemValid() or not needpet or self.db.profile["Filter Everyone"] == -1 then return end
	self:Debug("Updating tablet")

	local cat = tablet:AddCategory("hideBlankLine", true)
	cat:AddLine("text", loc.nicename, "hasCheck", true, "checked", true, "checkIcon", icon,
		"func", self.PutACorkInIt, "arg1", self)
end


------------------------------
--      Event Handlers      --
------------------------------

function minipet:CONFIRM_SUMMON()
	self:Debug("CONFIRM_SUMMON")
	state = true
end


function minipet:UNIT_FLAGS()
	self:Debug("UNIT_FLAGS", UnitOnTaxi("player"))
	if UnitOnTaxi("player") then state = true end
end


function minipet:SPELLCAST_START(spell)
	self:Debug("SPELLCAST_START", spell)
	if spell and (spell == loc.stone or spell == loc.astral
	or string.find(spell, loc.teleport)) then
		state = true
	else state = nil end
end


function minipet:SPELLCAST_FAILED(spell)
	self:Debug("SPELLCAST_FAILED", spell)
	if spell and (spell == loc.stone or spell == loc.astral
	or string.find(spell, loc.teleport)) then
		state = nil
	end
end


local bankstate, bankopen
function minipet:BANKFRAME_OPENED()
	self:Debug("BANKFRAME_OPENED")
	bankopen = true
	bankstate = pt:GetBest("minipetall") ~= nil
end


function minipet:BANKFRAME_CLOSED()
	if not bankopen then return end
	self:Debug("BANKFRAME_CLOSED", pt:GetBest("minipetall"))
	if (pt:GetBest("minipetall") ~= nil) ~= bankstate then self:ActivatePet() end
	bankopen = nil
end


function minipet:ActivateIfState()
	self:Debug("ActivateIfState", state and "true" or "false")
	if state then self:ActivatePet() end
end


------------------------------
--      Helper Methods      --
------------------------------

function minipet:ActivatePet()
	self:Debug("ActivatePet")
	state = nil
	needpet = pt:GetBest("minipetall") ~= nil
	self:TriggerEvent("CorkFu_Update")
end





