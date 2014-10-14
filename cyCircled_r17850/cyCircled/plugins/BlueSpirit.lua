local addonName = "BlueSpirit"

cyCircled_BlueSpirit = cyCircled:NewModule(addonName)

function cyCircled_BlueSpirit:AddonLoaded()
	self.db = cyCircled:AcquireDBNamespace(addonName)
	cyCircled:RegisterDefaults(addonName, "profile", {
		["BlueSpirit"] = true,
		["BlueCurse"] = true,
	})
	
	self:SetupElements()
	self:OnEnable()
end

function cyCircled_BlueSpirit:GetElements()
	return {
		["BlueSpirit"] = GetLocale() == "koKR" and "기본바" or true,
		["BlueCurse"] = GetLocale() == "koKR" and "저주바" or true,
	}
end

function cyCircled_BlueSpirit:SetupElements()
	self.elements = {
		["BlueSpirit"] = { 
			args = {
				button = { width = 28, height = 28, },
				nt = false,
				ft = false,
				ct = false,
				count = false,
				eborder = false,
				hotkey = false,
			},
			elements = {}, 
		},
		["BlueCurse"] = { 
			args = {
				button = { width = 28, height = 28, },
				nt = false,
				ft = false,
				ct = false,
				count = false,
				eborder = false,
				hotkey = false,
			},
			elements = {}, 
		},
	}
	
	for i=1, 7, 1 do
		table.insert(self.elements["BlueSpirit"].elements, format("BlueSpiritButton%d", i))
	end
	
	for i=1, 4, 1 do
		table.insert(self.elements["BlueCurse"].elements, format("BlueCurseButton%d", i))
	end
end