local addonName = "Bongos"

cyCircled_Bongos = cyCircled:NewModule(addonName)

function cyCircled_Bongos:AddonLoaded(addon)
	self.db = cyCircled:AcquireDBNamespace(addonName)
	cyCircled:RegisterDefaults(addonName, "profile", {
		["Main"] = true,
		["Pet"] = true,
--		["Bag"] = true,
		["Class"] = true,
	})
	
	self:SetupElements()
end

function cyCircled_Bongos:ApplyCustom()
	
end

function cyCircled_Bongos:GetElements()
	return {
		["Main"] = true,
		["Pet"] = true,
--		["Bag"] = true,
		["Class"] = true,
	}
end

function cyCircled_Bongos:SetupElements()
	self.elements = {
		["Main"] = { 
			args = {
				button = { width = 35, height = 35, },
			},
			elements = {},
		},
		["Pet"] = {
			args = {
				button = { width = 35, height = 35, },
				eborder = false,
			},
			elements = {},
		},
--[[
		["Bag"] = {
			args = {
				button = { width = 35, height = 35, },
				hotkey = false,
				count = false,
				eborder = false,
				ft = false,
				cooldown = false,
				parentname = true,
			},
			elements = {},
		},
]]
		["Class"] = {
			args = {
				button = { width = 35, height = 35, },
				eborder = false,
			},
			elements = {},
		},
	}
	
	for i=1, 120, 1 do
		table.insert(self.elements["Main"].elements, format("BActionButton%d", i))
	end
	
	for i=1, 12, 1 do
		table.insert(self.elements["Pet"].elements, format("BPetActionButton%d", i))
	end
--[[	
	for i=0, 3, 1 do
		table.insert(self.elements["Bag"].elements, format("CharacterBag%dSlot", i))
	end
]]	
	for i=1, GetNumShapeshiftForms(), 1 do
		table.insert(self.elements["Class"].elements, format("BClassBarButton%d", i))
	end
end