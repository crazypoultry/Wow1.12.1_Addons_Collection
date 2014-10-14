local addonName = "AutoBar"

cyCircled_AutoBar = cyCircled:NewModule(addonName)

function cyCircled_AutoBar:AddonLoaded()
	self.db = cyCircled:AcquireDBNamespace(addonName)
	cyCircled:RegisterDefaults(addonName, "profile", {
		["Main"] = true,
		["Popup"] = true,
	})
	
	self:SetupElements()
end

function cyCircled_AutoBar:GetElements()
	return {
		["Main"] = GetLocale() == "koKR" and "기본바" or true,
		["Popup"] = GetLocale() == "koKR" and "팝업 메뉴" or true,
	}
end

function cyCircled_AutoBar:SetupElements()
	self.elements = {
		["Main"] = { 
			args = {
				button = { width = 35, height = 35, },
				hotkey = false,
			},
			elements = {}, 
		},
		["Popup"] = { 
			args = {
				button = { width = 35, height = 35, },
				hotkey = false,
			},
			elements = {}, 
		},
	}
	
	for i=1, 24, 1 do
		table.insert(self.elements["Main"].elements, format("AutoBarFrameButton%d", i))
	end
	
	for i=1, 12, 1 do
		table.insert(self.elements["Popup"].elements, format("AutoBarPopupFrame_Button%d", i))
	end
end