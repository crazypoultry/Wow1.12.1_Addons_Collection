local addonName = "Pubcrawl"
local _G = getfenv(0)

cyCircled_Pubcrawl = cyCircled:NewModule(addonName)

function cyCircled_Pubcrawl:AddonLoaded(addon)
	self.db = cyCircled:AcquireDBNamespace(addonName)
	cyCircled:RegisterDefaults(addonName, "profile", {
		["Main"] = true,
	})
	
	self:SetupElements()
end

function cyCircled_Pubcrawl:InitHooks()
	self:Hook(Pubcrawl.ActionButtonTemplate.prototype, "SetLook", "Update")
end

function cyCircled_Pubcrawl:ApplyCustom(elements)
	for k, data in pairs(elements or self.elements) do
		if self.db.profile[k] then
			local args = data.args
			for k, id in pairs(data.elements) do
				if _G[id.."newBG"] then
					_G[id.."newBG"]:SetAlpha(0)
					_G[id.."newBG"]:Hide()
				end
			end
		end
	end
end

function cyCircled_Pubcrawl:GetElements()
	return {
		["Main"] = true,
	}
end

function cyCircled_Pubcrawl:SetupElements()
	self.elements = {
		["Main"] = { 
			args = {
				button = { width = 35, height = 35, },
			},
			elements = {},
		},
	}
	
	for i=1, 40, 1 do
		table.insert(self.elements["Main"].elements, format("PubcrawlButton%d", i))
	end
end

function cyCircled_Pubcrawl:Update(obj)
	self.hooks[Pubcrawl.ActionButtonTemplate.prototype].SetLook(obj)
	
	local data = {
		args = self.elements["Main"].args,
		elements = {"PubcrawlButton" .. obj.id},
	}
	
	cyCircled:ApplySkin(data)
	cyCircled:ApplyColors(data)
	self:ApplyCustom(data)
end