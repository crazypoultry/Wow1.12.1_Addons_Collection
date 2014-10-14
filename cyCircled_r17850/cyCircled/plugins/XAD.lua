local addonName = "XAD"

cyCircled_XAD = cyCircled:NewModule(addonName)

function cyCircled_XAD:AddonLoaded(addon)
	self.db = cyCircled:AcquireDBNamespace(addonName)
	cyCircled:RegisterDefaults(addonName, "profile", {
		["Main"] = true,
	})
	
	self:SetupElements()
end

function cyCircled_XAD:GetElements()
	return {
		["Main"] = true,
	}
end

function cyCircled_XAD:SetupElements()
	self.elements = {
		["Main"] = { 
			args = {
				button = { width = 35, height = 35, },
				eborder = false,
				ft = false,
				ct = false,
			},
			elements = {},
		},
	}
	
	for i=1, XAD.Constants.maxbuttons, 1 do
		table.insert(self.elements["Main"].elements, format("XADButton%d", i))
	end
end