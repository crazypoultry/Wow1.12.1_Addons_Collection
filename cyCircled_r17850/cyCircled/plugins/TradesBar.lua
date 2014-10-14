local addonName = "TradesBar"

cyCircled_TradesBar = cyCircled:NewModule(addonName)

function cyCircled_TradesBar:AddonLoaded()
	self.db = cyCircled:AcquireDBNamespace(addonName)
	cyCircled:RegisterDefaults(addonName, "profile", {
		["Main"] = true,
	})
	
	self:SetupElements()
	self:OnEnable()
end

function cyCircled_TradesBar:GetElements()
	return {
		["Main"] = true,
	}
end

function cyCircled_TradesBar:SetupElements()
	self.elements = {
		["Main"] = { 
			args = {
				button = { width = 28, height = 28, },
				ft = false,
				count = false,
				eborder = false,
				hotkey = false,
			},
			elements = {}, 
		},
	}
	
	for i=1, 15, 1 do
		table.insert(self.elements["Main"].elements, format("TradesBarButton%d", i))
	end
end