-- Globally used
local G = getfenv(0)
local pairs = pairs
local oGlow = oGlow

local loaded = false;

local items = {
	"Head",
	"Neck",
	"Shoulder",
	"Shirt",
	"Chest",
	"Waist",
	"Legs",
	"Feet",
	"Wrist",
	"Hands",
	"Finger0",
	"Finger1",
	"Trinket0",
	"Trinket1",
	"Back",
	"MainHand",
	"SecondaryHand",
	"Ranged",
	"Tabard",
}

local q
local function update()
	if(not InspectFrame) then return end
	local unit = InspectFrame.unit
	for i, key in pairs(items) do
		
		local link = GetInventoryItemLink(unit, i)
		local self = G["Inspect"..key.."Slot"]

		if link then
			local q=getQuality(link)
			-- DEFAULT_CHAT_FRAME:AddMessage(q);
			oGlow(self, q)
		elseif(self.bc) then
			self.bc:Hide()
		end
	end
end

local hook = CreateFrame("Frame","OglowInspect")
hook:RegisterEvent"VARIABLES_LOADED";

hook:SetScript("OnUpdate",  function()
	if(IsAddOnLoaded("Blizzard_InspectUI")) and (not loaded) then
		this:SetScript("OnShow", update)
		this:SetParent"InspectFrame"

		this:RegisterEvent"PLAYER_TARGET_CHANGED"
		this:UnregisterEvent"ADDON_LOADED"
		loaded = true
	end
end);

oGlow.updateInspect = update