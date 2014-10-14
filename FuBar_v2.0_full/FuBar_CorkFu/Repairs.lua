

local gratuity = AceLibrary("Gratuity-2.0")
local findstr = string.gsub(DURABILITY_TEMPLATE, "%%[^%s]+", "(.+)")
local abacus = AceLibrary("Abacus-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local tablet = AceLibrary("Tablet-2.0")
local crayon = AceLibrary("Crayon-2.0")
local core = FuBar_CorkFu

local myevents = {
	"PLAYER_UNGHOST",
	"PLAYER_DEAD",
	"PLAYER_REGEN_ENABLED",
	"UPDATE_INVENTORY_ALERTS",
	"MERCHANT_SHOW",
	"MERCHANT_CLOSED",
}
local items = {
	{name = INVTYPE_HEAD, slot = "Head"},
	{name = INVTYPE_SHOULDER, slot = "Shoulder"},
	{name = INVTYPE_CHEST, slot = "Chest"},
	{name = INVTYPE_WAIST, slot = "Waist"},
	{name = INVTYPE_LEGS, slot = "Legs"},
	{name = INVTYPE_FEET, slot = "Feet"},
	{name = INVTYPE_WRIST, slot = "Wrist"},
	{name = INVTYPE_HAND, slot = "Hands"},
	{name = INVTYPE_WEAPONMAINHAND, slot = "MainHand"},
	{name = INVTYPE_WEAPONOFFHAND, slot = "SecondaryHand"},
	{name = INVTYPE_RANGED, slot = "Ranged"},
}
local loc = {
	nicename = "Durability",
}
local icon, needpet, state, perc = "Interface\\Icons\\Ability_Seal", true
local xpath = "Interface\\AddOns\\FuBar_CorkFu\\X.tga"


local dura = core:NewModule(loc.nicename, "AceDebug-2.0")
dura.debugFrame = ChatFrame5
dura.target = "Self"
dura.uncorkable = true
dura.defaultDB = {threshold = .85}


---------------------------
--      Ace Methods      --
---------------------------

function dura:OnEnable()
	self:RegisterBucketEvent(myevents, 1, "Update")
	self:RegisterEvent("PLAYER_UPDATE_RESTING")
	self:PLAYER_UPDATE_RESTING()
end


----------------------------
--      Cork Methods      --
----------------------------

function dura:ItemValid()
	return IsResting()
end


function dura:GetIcon(unit)
	return icon
end


function dura:PutACorkInIt()
end


function dura:GetTopItem()
end


function dura:OnTooltipUpdate()
	if not self:ItemValid() or ((perc or 1) > .85) or self.db.profile["Filter Everyone"] == -1 then return end
	self:Debug("Updating tablet")

	local cat = tablet:AddCategory("hideBlankLine", true, "columns", 2)
	cat:AddLine("text", "Your equipment is damaged",
		"text2", string.format("|cff%s%d%%", crayon:GetThresholdHexColor(perc), perc * 100),
		"hasCheck", true, "checked", true, "checkIcon", icon)
end


local function setslider(v)
	dura:SetFilter("Everyone", v)
end


function dura:RootMenuItem()
	dewdrop:AddLine("text", self:ToString() or "No name???", "hasArrow", true,
		"checked", self.db.profile["Filter Everyone"] == 0, "checkIcon", xpath,
		"hasSlider", true, "sliderIsPercent", true, "sliderValue", self.db.profile["Filter Everyone"],
		"sliderFunc", self.SetFilter, "sliderArg1", self, "sliderArg2", "Everyone")
end


------------------------------
--      Event Handlers      --
------------------------------

function dura:PLAYER_UPDATE_RESTING()
	if IsResting() then
		self:Update()
	else
		self:TriggerEvent("CorkFu_Update")
	end
end


------------------------------
--      Helper Methods      --
------------------------------

function dura:Update()
	if not IsResting() then return end

	local t1, t2 = 0, 0
	for i in ipairs(items) do
		local v1, v2 = self:UpdateItem(i)
		t1, t2 = t1 + v1, t2 + v2
	end

	perc = (t2 == 0) and 1 or t1/t2

	self:TriggerEvent("CorkFu_Update")
end


function dura:UpdateItem(index)
	local item = items[index]
	local id = GetInventorySlotInfo(item.slot .. "Slot")
	local hasItem = gratuity:SetInventoryItem("player", id)

	local v1, v2
	if hasItem then _, _, v1, v2 = gratuity:Find(findstr) end
	v1, v2 = tonumber(v1) or 0, tonumber(v2) or 0
	return v1, v2
end
