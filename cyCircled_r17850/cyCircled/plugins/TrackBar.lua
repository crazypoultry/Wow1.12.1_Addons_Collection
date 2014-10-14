local addonName = "TrackBar"

cyCircled_TrackBar = cyCircled:NewModule(addonName)

function cyCircled_TrackBar:AddonLoaded()
	self.db = cyCircled:AcquireDBNamespace(addonName)
	cyCircled:RegisterDefaults(addonName, "profile", {
		["Tracking"] = true,
	})
	
	self:SetupElements()
	self:OnEnable()
end

function cyCircled_TrackBar:GetElements()
	return {
		["Tracking"] = GetLocale() == "koKR" and "추적 버튼" or true,
	}
end

function cyCircled_TrackBar:SetupElements()
	self.elements = {
		["Tracking"] = { 
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
	
	for i=1, 13, 1 do
		table.insert(self.elements["Tracking"].elements, format("TrackBarButton%d", i))
	end
end