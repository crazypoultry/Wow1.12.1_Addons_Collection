local addonName = "ItemRack"

cyCircled_ItemRack = cyCircled:NewModule(addonName)

function cyCircled_ItemRack:AddonLoaded()
	self.db = cyCircled:AcquireDBNamespace(addonName)
	cyCircled:RegisterDefaults(addonName, "profile", {
		["Inv"] = true,
		["Menu"] = true,
	})
	
	self:SetupElements()
	self:OnEnable()
end

function cyCircled_ItemRack:GetElements()
	return {
		["Inv"] = GetLocale() == "koKR" and "착용 아이템" or "Inventory",
		["Menu"] = GetLocale() == "koKR" and "아이템 메뉴" or true,
	}
end

function cyCircled_ItemRack:SetupElements()
	self.elements = {
		["Inv"] = { 
			args = {
				button = { width = 35, height = 35, },
				ft = false,
				hotkey = false,
			},
			elements = {}, 
		},
		["Menu"] = { 
			args = {
				button = { width = 35, height = 35, },
				ft = false,
				hotkey = false,
			},
			elements = {}, 
		},
	}
	
	for i=0, 20, 1 do
		table.insert(self.elements["Inv"].elements, format("ItemRackInv%d", i))
	end
	
	for i=1, 30, 1 do
		table.insert(self.elements["Menu"].elements, format("ItemRackMenu%d", i))
	end
end