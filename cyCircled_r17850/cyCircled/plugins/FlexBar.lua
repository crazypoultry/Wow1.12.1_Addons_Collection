--[[
	Plugin by Steve
]]

local addonName = "FlexBar"

cyCircled_FlexBar = cyCircled:NewModule(addonName)

function cyCircled_FlexBar:AddonLoaded()
	self.db = cyCircled:AcquireDBNamespace(addonName)
	cyCircled:RegisterDefaults(addonName, "profile", {
		["Main"] = true,
--		["Popup"] = true,
	})
	
	self:SetupElements()
end

function cyCircled_FlexBar:GetElements()
	return {
		["Main"] = true,
--		["Popup"] = true,
	}
end

function cyCircled_FlexBar:SetupElements()
	self.elements = {
		["Main"] = { 
			args = {
				button = { width = 35, height = 35, },
				hotkey = false,
				eborder = false,
			},
			elements = {}, 
		},
--		["Popup"] = { 
--			args = {
--				button = { width = 35, height = 35, },
--				hotkey = false,
--			},
--			elements = {}, 
--		},
	}
	
	for i=1, 120, 1 do
		table.insert(self.elements["Main"].elements, format("FlexBarButton%d", i))
	end
	
--	for i=1, 12, 1 do
--		table.insert(self.elements["Popup"].elements, format("FlexBarPopupFrame_Button%d", i))
--	end
end