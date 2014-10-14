--[[ Vars - Shared
]]
local cd, bar, tex

--[[ Whitelist - Shared
]]
local Shared = {
	["PaperDollFrame"] = function(a1)
		local parent = getglobal(a1:GetParent():GetName())
		local inventoryLink = GetInventoryItemLink("player", parent:GetID())
		local _, _, itemCode = strfind(inventoryLink, "(%d+):")
		local sName, _, _, _, _, _, _, _, sTexture = GetItemInfo(itemCode)
		return sName, sTexture
	end,
	["SpellBookFrame"] = function(a1)
		return GetSpellName(SpellBook_GetSpellID(a1:GetParent():GetID()), BOOKTYPE_SPELL)
	end
}

if(BActionBar) then
--[[ Support - Bongos
	Functions
]]
	local BongosAction = function(a1)
			a1 = BActionButton.GetPagedID(a1:GetParent():GetID())
			oCD.gra:SetAction(a1)
			return oCD.gra:GetLine(1)
	end

--[[ Support - Bongos
	Whitelist
]]
	local Bongos = {
		["BActionBar1"] = BongosAction,
		["BActionBar2"] = BongosAction,
		["BActionBar3"] = BongosAction,
		["BActionBar4"] = BongosAction,
		["BActionBar5"] = BongosAction,
		["BActionBar6"] = BongosAction,
		["BActionBar7"] = BongosAction,
		["BActionBar8"] = BongosAction,
		["BActionBar9"] = BongosAction,
		["BActionBar10"] = BongosAction,
		["BClassBar"] = function(a1)
			oCD.gra:SetShapeshift(a1:GetParent():GetID())
			return oCD.gra:GetLine(1)
		end,
		["BPetBar"] = function(a1)
			return GetPetActionInfo(a1:GetParent():GetID())
		end
	}

--[[ Support - Bongos
	Hook
]]
	function oCD:CooldownFrame_SetTimer(this, start, duration, enable)
		if(start > 0 and duration > 0 and enable > 0) then
			bar = this:GetParent():GetParent():GetName()
			if(Shared[bar]) then
				name, tex = Shared[bar](this)
				cd = duration - (GetTime() - start)
				oCD:StartBar(name, cd, name, tex)
			elseif(Bongos[bar]) then
				name = Bongos[bar](this)
				if(name and self.spells[name]) then
					cd = duration - (GetTime() - start)
					self:StartBar(name, cd, name, self.spells[name])
				end
			end
		end
		
		return self.hooks["CooldownFrame_SetTimer"].orig(this, start, duration, enable)
	end

elseif(DAB_Initialize) then
--[[ Support - Discord
	Functions
]]
	local DiscordAction = function(a1)
		a1 = ActionButton_GetPagedID(a1:GetParent())
		oCD.gra:SetAction(a1)
		return oCD.gra:GetLine(1)
	end

--[[ Support - Discord
	Whitelist
 ]]
	 local Discord = {
		["DAB_ActionBar_1"] = DiscordAction,
		["DAB_ActionBar_2"] = DiscordAction,
		["DAB_ActionBar_3"] = DiscordAction,
		["DAB_ActionBar_4"] = DiscordAction,
		["DAB_ActionBar_5"] = DiscordAction,
		["DAB_ActionBar_6"] = DiscordAction,
		["DAB_ActionBar_7"] = DiscordAction,
		["DAB_ActionBar_8"] = DiscordAction,
		["DAB_ActionBar_9"] = DiscordAction,
		["DAB_ActionBar_10"] = DiscordAction,
		["DAB_OtherBar_Form"] = function(a1)
			oCD.gra:SetShapeshift(a1:GetParent():GetID())
			return oCD.gra:GetLine(1)
		end,
		["DAB_OtherBar_Pet"] = function(a1)
			return GetPetActionInfo(a1:GetParent():GetID())
		end,
	}

--[[ Support - Discord
	Hook
]]
	function oCD:CooldownFrame_SetTimer(this, start, duration, enable)
		if(start > 0 and duration > 0 and enable > 0) then
			bar = this:GetParent():GetParent():GetName()
			if(Shared[bar]) then
				name, tex = Shared[bar](this)
				cd = duration - (GetTime() - start)
				oCD:StartBar(name, cd, name, tex)
			elseif(Discord[bar]) then
				name = Discord[bar](this)
				if(name and self.spells[name]) then
					cd = duration - (GetTime() - start)
					self:StartBar(name, cd, name, self.spells[name])
				end
			end
		end
		
		return self.hooks["CooldownFrame_SetTimer"].orig(this, start, duration, enable)
	end

elseif(Nurfed_ActionBars and Nurfed_Options) then
--[[ Support - Nurfed
	Functions
]]
	local NurfedAction = function(a1)
		a1 = ActionButton_GetPagedID(a1:GetParent())
		oCD.gra:SetAction(a1)
		return oCD.gra:GetLine(1)
	end

--[[ Support - Nurfed
	Whitelist
]]

	local bars = Nurfed_Options:New():GetOption("actionbars", "bars");
	local Nurfed = {}
	for bar, _ in bars do
		Nurfed["Nurfed_bar".. bar] = NurfedAction
	end

	Nurfed["Nurfed_ss"] = function(a1)
		oCD.gra:SetShapeshift(a1:GetParent():GetID())
		return oCD.gra:GetLine(1)
	end

	Nurfed["Nurfed_petbar"] = function(a1)
			return GetPetActionInfo(a1:GetParent():GetID())
	end

--[[ Support - Nurfed
	Hook
]]
	function oCD:CooldownFrame_SetTimer(this, start, duration, enable)
		if(start > 0 and duration > 0 and enable > 0) then
			bar = this:GetParent():GetParent():GetName()
			if(Shared[bar]) then
				name, tex = Shared[bar](this)
				cd = duration - (GetTime() - start)
				oCD:StartBar(name, cd, name, tex)
			elseif(Nurfed[bar]) then
				name = Nurfed[bar](this)
				if(name and self.spells[name]) then
					cd = duration - (GetTime() - start)
					self:StartBar(name, cd, name, self.spells[name])
				end
			end
		end
		
		return self.hooks["CooldownFrame_SetTimer"].orig(this, start, duration, enable)
	end

else
--[[ Support - Blizzard
	Functions
]]
	local BlizzardAction = function(a1)
		a1 = ActionButton_GetPagedID(a1:GetParent())
		oCD.gra:SetAction(a1)
		return oCD.gra:GetLine(1)
	end

--[[ Support - Blizzard
	Whitelist
]]
	local Blizzard = {
		["Bar1"] = BlizzardAction,
		["MultiBarRight"] = BlizzardAction,
		["MultiBarLeft"] = BlizzardAction,
		["MultiBarBottomLeft"] = BlizzardAction,
		["MultiBarBottomRight"] = BlizzardAction,
		["MainMenuBarArtFrame"] = BlizzardAction,
		["BonusActionBarFrame"] = BlizzardAction,
		["PetActionBarFrame"] = function(a1)
			return GetPetActionInfo(a1:GetParent():GetID())
		end,
		["ShapeshiftBarFrame"] = function(a1)
			oCD.gra:SetShapeshift(a1:GetParent():GetID())
			return oCD.gra:GetLine(1)
		end
	}

--[[ Support - Blizzard
	Hook
]]
	function oCD:CooldownFrame_SetTimer(this, start, duration, enable)
		if(start > 0 and duration > 0 and enable > 0) then
			bar = this:GetParent():GetParent():GetName()
			if(Shared[bar]) then
				name, tex = Shared[bar](this)
				cd = duration - (GetTime() - start)
				oCD:StartBar(name, cd, name, tex)
			elseif(Blizzard[bar]) then
				name = Blizzard[bar](this)
				if(name and self.spells[name]) then
					cd = duration - (GetTime() - start)
					self:StartBar(name, cd, name, self.spells[name])
				end
			end
		end
		
		return self.hooks["CooldownFrame_SetTimer"].orig(this, start, duration, enable)
	end
end