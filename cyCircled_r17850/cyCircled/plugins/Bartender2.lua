--[[
	The module
	
		The module name has to be the addon name.
	
	Element structure
	
		{
			args = {}			Contains parameters
				button		The main button
					width		Button width (should normally be 35)
					height	Button height (should normally be 35)
				parentname		true - Retrieve and use parent name (Default: false)
				
				By default, those parameters are set to true.
				
				nt			false - Normal texture
				ht			false - Highlight texture
				pt			false - Pushed texture
				ct			false - Checked texture
				ft			false - Flash texture
				hotkey		false - Hotkey string
				count			false - Count string
				eborder		false - Equipped border
				cooldown		false - Cooldown animation
				icon			false - Icon
				
			elements = {}		Contains all the elements
			alias = {}			Alias mapping(not implemented yet)
			modifiers = {}		Adjustments to skins (not implemeneted yet)
		}
	
	GetElements function
		returns a table where
			key 	= element
			value = true to use the key name or a string containing the element name
		
		The key has to be named the same as the element itself.
		The table is used for the options.
]]

local addonName = "Bartender2"

cyCircled_Bartender2 = cyCircled:NewModule(addonName)

function cyCircled_Bartender2:AddonLoaded(addon)
	self.db = cyCircled:AcquireDBNamespace(addonName)
	cyCircled:RegisterDefaults(addonName, "profile", {
		["Bar1"] = true,
		["Bar2"] = true,
		["Bar3"] = true,
		["Bar4"] = true,
		["Bar5"] = true,
		["Bar6"] = true,
		["Bar7"] = true,
		["Bar8"] = true,
	})
	
	self:SetupElements()
end

function cyCircled_Bartender2:GetElements()
	return {
		["Bar1"] = GetLocale() == "koKR" and "행동단축바 1페이지" or true,
		["Bar2"] = GetLocale() == "koKR" and "행동단축바 2페이지" or true,
		["Bar3"] = GetLocale() == "koKR" and "행동단축바 3페이지" or true,
		["Bar4"] = GetLocale() == "koKR" and "행동단축바 4페이지" or true,
		["Bar5"] = GetLocale() == "koKR" and "행동단축바 5페이지" or true,
		["Bar6"] = GetLocale() == "koKR" and "태세바" or "Shapeshift bar",
		["Bar7"] = GetLocale() == "koKR" and "소환수바" or "Pet bar",
		["Bar8"] = GetLocale() == "koKR" and "가방바" or "Bag bar",
	}
end

function cyCircled_Bartender2:SetupElements()
	self.elements = {
		["Bar1"] = { elements = {}, },
		["Bar2"] = { elements = {}, },
		["Bar3"] = { elements = {}, },
		["Bar4"] = { elements = {}, },
		["Bar5"] = { elements = {}, },
		
		-- shapeshift bar
		["Bar6"] = { elements = {}, },
		-- pet bar
		["Bar7"] = { elements = {}, },
		-- bag bar
		["Bar8"] = { alias = { icon = "IconTexture", }, elements = {}, },
	}
	
	-- bar 1-5
	for i=1, 5, 1 do
		self.elements["Bar"..i].args = {
			button = { width = 35, height = 35, },
			parentname = true,
		}
		for j=1, 12, 1 do
			table.insert(self.elements["Bar"..i].elements, format("Bar%dButton%d", i, j))
		end
	end
	
	-- bar 6+7
	for i=6, 7, 1 do
		self.elements["Bar"..i].args = {
			button = { width = 35, height = 35, },
			parentname = true,
		}
		for j=1, 10, 1 do
			table.insert(self.elements["Bar"..i].elements, format("Bar%dButton%d", i, j))
		end
	end
	
	-- bagbar
	self.elements["Bar8"].args = {
		button = { width = 35, height = 35, },
		hotkey = false,
		count = false,
		eborder = false,
		ft = false,
		cooldown = false,
		parentname = true,
	}
	for i=1, 5, 1 do
		table.insert(self.elements["Bar8"].elements, format("Bar8Button%d", i))
	end
end