-- Create the addon
Fizzle = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.1", "AceDB-2.0", "AceConsole-2.0")
Fizzle:RegisterDB("FizzleDB")
Fizzle:RegisterDefaults('profile', {
	Percent = true,
	Border = true,
	Invert = false,
	HideText = false,
	DisplayWhenFull = true,
	ShowRepairCost = true,
	discount = true,
})

local fontSize = 12
local abacus = AceLibrary("Abacus-2.0")
local crayon = AceLibrary("Crayon-2.0")
local gratuity = AceLibrary("Gratuity-2.0")
local tablet = AceLibrary("Tablet-2.0")
local L = AceLibrary("AceLocale-2.2"):new("Fizzle")
local _G = getfenv(0)

function Fizzle:OnInitialize()
	-- Register Chat Commands
	Fizzle:RegisterChatCommand({ "/fizzle", "/fizz" }, {
		desc = L["Displays Item Quality and Durability in the character frame."],
		type = "group",
		args = {
			percent = {
				name = L["Percent"],
				desc = L["Toggle percentage display."],
				type = "toggle",
				get = function() return self.db.profile.Percent end,
				set = function(val) self.db.profile.Percent = val self:UpdateItems() end,
			},
			border = {
				name = L["Border"],
				desc = L["Toggle quality borders."],
				type = "toggle",
				get = function() return self.db.profile.Border end,
				set = function(val) self.db.profile.Border = val self:BorderToggle() end,
			},
			invert = {
				name = L["Invert"],
				desc = L["Show numbers the other way around. Eg. 0% = full durability , 100 = no durability."],
				type = "toggle",
				get = function() return self.db.profile.Invert end,
				set = function(val) self.db.profile.Invert = val self:UpdateItems() end,
			},
			hidetext = {
				name = L["Hide Text"],
				desc = L["Hide durability text."],
				type = "toggle",
				get = function() return self.db.profile.HideText end,
				set = function(val) self.db.profile.HideText = val self:UpdateItems() end,
			},
			showfull = {
				name = L["Show Full"],
				desc = L["Show durability when full."],
				type = "toggle",
				get = function() return self.db.profile.DisplayWhenFull end,
				set = function(val) self.db.profile.DisplayWhenFull = val self:UpdateItems() end,
			},
			repaircost = {
				name = L["Show Repair Cost"],
				desc = L["Show the total repair cost of your items."],
				type = "toggle",
				get = function() return self.db.profile.ShowRepairCost end,
				set = function() self.db.profile.ShowRepairCost = not self.db.profile.ShowRepairCost end,
			},
			discount = {
				name = L["Discount"],
				desc = L["Show the repair cost minus the 10% faction discount."],
				type = "toggle",
				get = function() return self.db.profile.discount end,
				set = function() self.db.profile.discount = not self.db.profile.discount end,
			}
		}
	})

	self:MakeTypeTable()
end

function Fizzle:OnEnable()
	self:RegisterEvent("UPDATE_INVENTORY_ALERTS", "UpdateItems")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "UpdateItems")
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnWorldEnter")
	self:RegisterEvent("PLAYER_LEAVING_WORLD", "OnWorldLeave")
	self:SecureHook("CharacterFrame_OnShow")
end

function Fizzle:OnDisable()
	for _, item in ipairs(self.items) do
		_G[item.slot .. "FizzleS"]:SetText("")
	end
	self:HideBorders()
end

function Fizzle:OnWorldEnter()
	self:RegisterEvent("UPDATE_INVENTORY_ALERTS", "UpdateItems")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "UpdateItems")
end

function Fizzle:OnWorldLeave()
	self:UnregisterEvent("UPDATE_INVENTORY_ALERTS")
	self:UnregisterEvent("UNIT_INVENTORY_CHANGED")
end

function Fizzle:MakeTypeTable()
	-- Table of item types and slots.  Thanks Tekkub.
	self.items = self.items or {
		{slot = "Head"},
		{slot = "Shoulder"},
		{slot = "Chest"},
		{slot = "Waist"},
		{slot = "Legs"},
		{slot = "Feet"},
		{slot = "Wrist"},
		{slot = "Hands"},
		{slot = "MainHand"},
		{slot = "SecondaryHand"},
		{slot = "Ranged"},
	}
         
	-- Items without durability but with some quality, needed for border colouring.
	self.nditems = self.nditems or {
		{slot = "Ammo"},
		{slot = "Neck"},
		{slot = "Back"},
		{slot = "Finger0"},
		{slot = "Finger1"},
		{slot = "Trinket0"},
		{slot = "Trinket1"},
		{slot = "Relic"},
	}
         
	-- Go through the table and create the font strings and borders for each slot.
	local font, _, flags = NumberFontNormal:GetFont()

	for _, item in ipairs(self.items) do
		local gslot = _G["Character"..item.slot.."Slot"]
		if gslot then
			local str = gslot:CreateFontString(item.slot .. "FizzleS", "OVERLAY")
			local border = gslot:CreateTexture(item.slot .. "FizzleB", "OVERLAY")
			border:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
			border:SetBlendMode("ADD")
			border:SetAlpha(0.75)
			border:SetHeight(68)
			border:SetWidth(68)
			border:SetPoint("CENTER", gslot, "CENTER", 0, 1)
			border:Hide()
			str:SetFont(font, fontSize, flags)
			str:SetPoint("CENTER", gslot, "BOTTOM", 0, 8)
		end
	end

	-- Same again, but for ND items, and only creating a border
	for _, nditem in ipairs(self.nditems) do
		local ndslot = _G["Character"..nditem.slot.."Slot"]
		if ndslot then
			local border = ndslot:CreateTexture(nditem.slot .. "FizzleB", "OVERLAY")
			border:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
			border:SetBlendMode("ADD")
			border:SetAlpha(0.75)
			border:SetHeight(68)
			border:SetWidth(68)
			border:SetPoint("CENTER", ndslot, "CENTER", 0, 1)
			border:Hide()
		end
	end
end

function Fizzle:UpdateItems()
	-- Don't update unless the charframe is open.
	-- No point updating what we can't see.
	if CharacterFrame:IsVisible() then
		self.repairCost = 0
		-- Go and set the durability string for each slot that has an item equipped that has durability.
		-- Thanks Tekkub again for the base of this code.
		for _, item in ipairs(self.items) do
			local id, _ = GetInventorySlotInfo(item.slot .. "Slot")
			local hasItem, _, cost = gratuity:SetInventoryItem("player", id)

			local str = _G[item.slot.."FizzleS"]

			local v1, v2
			if hasItem then v1, v2 = gratuity:FindDeformat(DURABILITY_TEMPLATE) end

			v1, v2, cost = tonumber(v1) or 0, tonumber(v2) or 0, tonumber(cost) or 0
			local percent = v1 / v2 * 100
			self.repairCost = self.repairCost + cost

			if (((v2 ~= 0) and ((percent ~= 100) or self.db.profile.DisplayWhenFull)) and not self.db.profile.HideText) then
				local text
			
				-- Colour our string depending on current durability percentage
				str:SetTextColor(crayon:GetThresholdColor(v1/v2))

				if self.db.profile.Invert then
					v1 = v2 - v1
					percent = 100 - percent
				end

				-- Are we showing the % or raw cur/max
				if self.db.profile.Percent then
					text = string.format("%d%%", percent)
				else
					text = v1.."/"..v2
				end

				str:SetText(text)
			else
				-- No durability in slot, so hide the text.
				str:SetText("")
			end
             
			--Finally, colour the borders
			if self.db.profile.Border then
				self:ColourBorders(id, item.slot)
			end
		end
         
		-- Colour the borders of ND items
		if self.db.profile.Border then
			self:ColourBordersND()
		end
	end
end

function Fizzle:ShowTablet()
	-- Register the tablet if we didn't yet.
	if not tablet:IsRegistered(CharacterFrame) then
		tablet:Register(CharacterFrame,
			'point', "TOPRIGHT",
			'relativePoint', "TOPLEFT",
			'clickable', false
		)
	end
	local cat = tablet:AddCategory(
		'columns', 2
	)
	local realCost
	if self.db.profile.discount then
		realCost = self.repairCost - ((self.repairCost / 100) * 10)
	else
		realCost = self.repairCost
	end
	cat:AddLine(
		'text', "Repair Cost",
		'text2', abacus:FormatMoneyFull(realCost, true, false)
	)
end

function Fizzle:CharacterFrame_OnShow()
	self:UpdateItems()
	-- temp printing of repair cost until we work out where to put it.
	if self.db.profile.ShowRepairCost then
		self:Print("Repair Cost: " .. abacus:FormatMoneyFull(self.repairCost, true, false))
		--self:ShowTablet()
	end
end

-- Border colouring split into two functions so I only need to iterate over each table once.
-- Border colouring for items with durability.
function Fizzle:ColourBorders(slotID, rawslot)
	local quality = GetInventoryItemQuality("player", slotID)
	if quality then
		local r, g, b, _ = GetItemQualityColor(quality)
		_G[rawslot.."FizzleB"]:SetVertexColor(r, g, b)
		_G[rawslot.."FizzleB"]:Show()
	else
		_G[rawslot.."FizzleB"]:Hide()
	end
end

-- Border colouring for items without durability
function Fizzle:ColourBordersND()
	for _, nditem in ipairs(self.nditems) do
		if _G["Character"..nditem.slot.."Slot"] then
			local slotID, _ = GetInventorySlotInfo(nditem.slot .."Slot")
			local quality = GetInventoryItemQuality("player", slotID)
			if quality then
				local r, g, b, _ = GetItemQualityColor(quality)
				_G[nditem.slot.."FizzleB"]:SetVertexColor(r, g, b)
				_G[nditem.slot.."FizzleB"]:Show()
			else
				_G[nditem.slot.."FizzleB"]:Hide()
			end
		end
	end
end

-- Toggle the border colouring
function Fizzle:BorderToggle()
	if not self.db.profile.Border then
		self:HideBorders()
	else
		self:UpdateItems()
	end
end

-- Hide quality borders
function Fizzle:HideBorders()
	for _, item in ipairs(self.items) do
		local border = _G[item.slot.."FizzleB"]
		if border then
			border:Hide()
		end
	end
	
	for _, nditem in ipairs(self.nditems) do
		local border = _G[nditem.slot.."FizzleB"]
		if border then
			border:Hide()
		end
	end
end
