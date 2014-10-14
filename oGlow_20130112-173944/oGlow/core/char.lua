-- Globally used
local G = getfenv(0)
local pairs = pairs
local oGlow = oGlow

-- Addon
local GetInventoryItemQuality = GetInventoryItemQuality
local CharacterFrame = CharacterFrame

local items = {
	[0] = "Ammo",
	"Head 1",
	"Neck",
	"Shoulder 2",
	"Shirt",
	"Chest 3",
	"Waist 4",
	"Legs 5",
	"Feet 6",
	"Wrist 7",
	"Hands 8",
	"Finger0",
	"Finger1",
	"Trinket0",
	"Trinket1",
	"Back",
	"MainHand 9",
	"SecondaryHand 10",
	"Ranged 11",
	"Tabard",
}

local q, key, self
local update = function()
	if(not CharacterFrame:IsShown()) then return end
	for i, value in pairs(items) do
		--key, index = string.split(" ", value)

		index = "";
		_, _, key, index = string.find(value, "(.*) (.*)")
		if (not key) then
			key = value;
		end

		--DEFAULT_CHAT_FRAME:AddMessage(key);
		q = GetInventoryItemQuality("player", i)
		--DEFAULT_CHAT_FRAME:AddMessage(q);
		self = getglobal("Character"..key.."Slot")
		if(oGlow.preventCharacter) then
			q = 0
		elseif(GetInventoryItemBroken("player", i)) then
			q = 100
		elseif(index and GetInventoryAlertStatus(index) == 3) then
			q = 99
		end

		oGlow(self, q)
	end
end

local hook = CreateFrame"Frame"
hook:SetParent"CharacterFrame"
hook:SetScript("OnShow", update)
hook:SetScript("OnEvent", function() if(event == "UNIT_INVENTORY_CHANGED") then update() end end)
hook:RegisterEvent"UNIT_INVENTORY_CHANGED"

oGlow.updateCharacter = update
