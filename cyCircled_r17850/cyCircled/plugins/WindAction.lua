local addonName = "WindAction"

cyCircled_WindAction = cyCircled:NewModule(addonName)

function cyCircled_WindAction:AddonLoaded(addon)
	self.db = cyCircled:AcquireDBNamespace(addonName)
	cyCircled:RegisterDefaults(addonName, "profile", {
		["WindActionMain"] = true,
		["WindActionRight"] = true,
		["WindActionLeft"] = true,
		["WindActionBottomRight"] = true,
		["WindActionBottomBonusAction"] = true,
		["PetActionButton"] = true,
		["ShapeshiftButton"] = true,
		["WindActionBag"] = true,
	})
	
	self:SetupElements()
end

function cyCircled_WindAction:GetElements()
	return {
		["WindActionMain"] = GetLocale() == "koKR" and "메인바" or true,
		["WindActionRight"] = GetLocale() == "koKR" and "첫번째 우측 행동 단축바" or true,
		["WindActionLeft"] = GetLocale() == "koKR" and "두번째 우측 행동 단축바" or true,
		["WindActionBottomRight"] = GetLocale() == "koKR" and "우측 하단 행동 단축바" or true,
		["WindActionBottomLeft"] = GetLocale() == "koKR" and "좌측 하단 행동 단축바" or true,
		["WindActionBonusAction"] = GetLocale() == "koKR" and "확장바" or true,
		["PetActionButton"] = GetLocale() == "koKR" and "소환수바" or true,
		["ShapeshiftButton"] = GetLocale() == "koKR" and "태세바" or true,
		["WindActionBag"] = GetLocale() == "koKR" and "가방바" or true,
	}
end

function cyCircled_WindAction:SetupElements()
	self.elements = {
		["WindActionMain"] = { elements = {}, },
		["WindActionRight"] = { elements = {}, },
		["WindActionLeft"] = { elements = {}, },
		["WindActionBottomRight"] = { elements = {}, },
		["WindActionBottomLeft"] = { elements = {}, },
		["WindActionBonusAction"] = { elements = {}, },
		["PetActionButton"] = { elements = {}, },
		["ShapeshiftButton"] = { elements = {}, },
		["WindActionBag"] = { alias = { icon = "IconTexture", }, elements = {}, },
	}
	
	self.elements["WindActionMain"].args = {
		button = { width = 36, height = 36, },
		parentname = true,
	}
	for i=1, 12, 1 do
		table.insert(self.elements["WindActionMain"].elements, format("ActionButton%d", i))
	end
	self.elements["WindActionRight"].args = {
		button = { width = 36, height = 36, },
		parentname = true,
	}
	for i=1, 12, 1 do
		table.insert(self.elements["WindActionRight"].elements, format("MultiBarRightButton%d", i))
	end
	self.elements["WindActionLeft"].args = {
		button = { width = 36, height = 36, },
		parentname = true,
	}
	for i=1, 12, 1 do
		table.insert(self.elements["WindActionLeft"].elements, format("MultiBarLeftButton%d", i))
	end
	self.elements["WindActionBottomRight"].args = {
		button = { width = 36, height = 36, },
		parentname = true,
	}
	for i=1, 12, 1 do
		table.insert(self.elements["WindActionBottomRight"].elements, format("MultiBarBottomRightButton%d", i))
	end
	self.elements["WindActionBottomLeft"].args = {
		button = { width = 36, height = 36, },
		parentname = true,
	}
	for i=1, 12, 1 do
		table.insert(self.elements["WindActionBottomLeft"].elements, format("MultiBarBottomLeftButton%d", i))
	end
	
	self.elements["WindActionBonusAction"].args = {
		button = { width = 36, height = 36, },
		parentname = true,
	}
	for i=1, 12, 1 do
		table.insert(self.elements["WindActionBonusAction"].elements, format("ExtensionBarButton%d", i))
	end
	
	self.elements["PetActionButton"].args = {
		button = { width = 30, height = 30, },
		parentname = true,
	}
	for i=1, 10, 1 do
		table.insert(self.elements["PetActionButton"].elements, format("PetActionButton%d", i))
	end

	self.elements["ShapeshiftButton"].args = {
		button = { width = 30, height = 30, },
		parentname = true,
	}
	for i=1, 10, 1 do
		table.insert(self.elements["ShapeshiftButton"].elements, format("ShapeshiftButton%d", i))
	end

	-- bagbar
	self.elements["WindActionBag"].args = {
		button = { width = 37, height = 37, },
		hotkey = false,
		count = false,
		eborder = false,
		ft = false,
		cooldown = false,
		parentname = true,
	}
	table.insert(self.elements["WindActionBag"].elements, "MainMenuBarBackpackButton")
	for i=0, 3, 1 do
		table.insert(self.elements["WindActionBag"].elements, format("CharacterBag%dSlot", i))
	end

end