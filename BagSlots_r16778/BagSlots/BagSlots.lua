BagSlots = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "AceConsole-2.0")
BagSlots:RegisterDB("BagSlotsDB")
BagSlots:RegisterDefaults('profile', {
	showDepletion = false,
	showTotal = true
})

local fontSize = 12 -- Font size setting.
local crayon = AceLibrary("Crayon-2.0")
local L = AceLibrary("AceLocale-2.2"):new("BagSlots")
local _G = getfenv(0)

L:RegisterTranslations("enUS", function() return {
	["Display bag usage on each of your bag slots."] = true,

	["Depletion"] = true,
	["Show depletion of bag slots"] = true,

	["Total"] = true,
	["Show total slots per bag"] = true,
} end)

local bags = {
	[1] = "MainMenuBarBackpackButton",
	[2] = "CharacterBag0Slot",
	[3] = "CharacterBag1Slot",
	[4] = "CharacterBag2Slot",
	[5] = "CharacterBag3Slot"
}

function BagSlots:OnInitialize()
	BagSlots:RegisterChatCommand({ "/bagslots", "/bslots" }, {
		desc = L["Display bag usage on each of your bag slots."],
		type = 'group',
		args = {
			depletion = {
				name = L["Depletion"],
				desc = L["Show depletion of bag slots"],
				type = "toggle",
				get = function() return self.db.profile.showDepletion end,
				set = function()
					self.db.profile.showDepletion = not self.db.profile.showDepletion
					self:UpdateSlotCount()
				end,
			},
			total = {
				name = L["Total"],
				desc = L["Show total slots per bag"],
				type = "toggle",
				get = function() return self.db.profile.showTotal end,
				set = function()
					self.db.profile.showTotal = not self.db.profile.showTotal
					self:UpdateSlotCount()
				end,
			},
		},
	})

	BagSlots:PrepOverlay()
end

-- Start
function BagSlots:OnEnable()
	self:RegisterBucketEvent("BAG_UPDATE", 1, "UpdateSlotCount")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnWorldEnter")
	self:RegisterEvent("PLAYER_LEAVING_WORLD", "OnWorldLeave")
	self:UpdateSlotCount()
end

function BagSlots:OnDisable()
	for _, bag in pairs(bags) do
		_G[bag.."BagSlotsStr"]:SetText("")
	end
end

function BagSlots:OnWorldEnter()
	self:RegisterBucketEvent("BAG_UPDATE", 1, "UpdateSlotCount")
end

function BagSlots:OnWorldLeave()
	self:UnregisterEvent("BAG_UPDATE")
end

function BagSlots:PrepOverlay()
	local font, _, flags = NumberFontNormal:GetFont()

	for _, bag in ipairs(bags) do
		local BagSlot = _G[bag]
		local BPStr = BagSlot:CreateFontString(bag.."BagSlotsStr", "OVERLAY")
		BPStr:SetFont(font, fontSize, flags)
		BPStr:SetPoint("CENTER", BagSlot, "BOTTOM", 0, 6)
	end	
end

function BagSlots:UpdateSlotCount()
	for bag = 0, 4 do
		local numSlots = GetContainerNumSlots(bag)

		if numSlots == 0 then
			return
		else
			local slotsText
			local usedSlots = 0
			local bagslot = _G[bags[bag+1].."BagSlotsStr"]

			for slot = 1, numSlots do
				if (GetContainerItemInfo(bag, slot)) then
					usedSlots = usedSlots + 1
				end
			end
			
			-- Colour the string before we check for showDepletion
			bagslot:SetTextColor(crayon:GetThresholdColor(usedSlots/numSlots, 1, 0.8, 0.6, 0.4, 0.2))
			
			if self.db.profile.showDepletion then
				usedSlots = numSlots - usedSlots
			end

			-- Decide what our string will be
			if self.db.profile.showTotal then
				slotsText = usedSlots.."/"..numSlots
			else
				slotsText = usedSlots
			end

			-- Show the string :)
			bagslot:SetText(slotsText)
		end
	end
end
