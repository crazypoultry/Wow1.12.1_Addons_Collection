local addonName = "TrinketMenu"

cyCircled_TrinketMenu = cyCircled:NewModule(addonName)

function cyCircled_TrinketMenu:AddonLoaded(addon)
	self.db = cyCircled:AcquireDBNamespace(addonName)
	cyCircled:RegisterDefaults(addonName, "profile", {
		["Main"] = true,
		["Menu"] = true,
	})
	
	self:SetupElements()
end

function cyCircled_TrinketMenu:GetElements()
	return {
		["Main"] = true,
		["Menu"] = true,
	}
end

function cyCircled_TrinketMenu:SetupElements()
	self.elements = {
		["Main"] =  {
			args = {
				button = { width = 35, height = 35, },
				hotkey = false,
				count = false,
				eborder = false,
				ft = false,
			},
			elements = {
				"TrinketMenu_Trinket0",
				"TrinketMenu_Trinket1",
			},
		},
		["Menu"] = { 
			args = {
				button = { width = 35, height = 35, },
				hotkey = false,
				count = false,
				eborder = false,
				ft = false,
			},
			elements = {},
		},
	}
	
	for i=1, 30, 1 do
		table.insert(self.elements["Menu"].elements, format("TrinketMenu_Menu%d", i))
	end
end