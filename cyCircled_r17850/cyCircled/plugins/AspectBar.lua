local addonName = "AspectBar"

cyCircled_AspectBar = cyCircled:NewModule(addonName)

function cyCircled_AspectBar:AddonLoaded()
	self.db = cyCircled:AcquireDBNamespace(addonName)
	cyCircled:RegisterDefaults(addonName, "profile", {
		["Aspect"] = true,
	})
	
	self:SetupElements()
	self:OnEnable()
end

function cyCircled_AspectBar:GetElements()
	return {
		["Aspect"] = GetLocale() == "koKR" and "상 버튼" or true,
	}
end

function cyCircled_AspectBar:SetupElements()
	self.elements = {
		["Aspect"] = { 
			args = {
				button = { width = 28, height = 28, },
				ft = false,
				count = false,
				hotkey = false,
				eborder = false,
			},
			elements = {}, 
		},
	}
	
	for i=1, 6, 1 do
		table.insert(self.elements["Aspect"].elements, format("AspectBarButton%d", i))
	end
end