
function Skinner:MetaMap()
	if not self.db.profile.WorldMap then return end

	self:hookDDScript(MetaMapFrameDropDownButton)	

	self:Hook("MetaMapMenu_OnShow", function(mode)
		self.hooks.MetaMapMenu_OnShow(mode)
		self:keepRegions(_G["MetaMapMenu"], {1}) -- N.B. region 1 is text
		self:applySkin(_G["MetaMapMenu"])
		end)
		
	self:keepRegions(_G["MetaMapFrameDropDown"], {4}) -- N.B. region 4 is text
	self:moveObject(_G["WorldMapFrameCloseButton"], "-", 10, "-", 5)
	self:applySkin(_G["MetaMapTopFrame"])

	self:moveObject(_G["MetaMapSliderMenu"], nil, nil, "-", 10)
	self:applySkin(_G["MetaMapSliderMenu"])
		
	for i = 1, 6 do
		local tabName = _G["MetaMap_DialogFrameTab"..i]
		-- hook the OnShow script to allow tab widths to be changed
		self:HookScript(tabName, "OnShow", function()
--			self:Debug(tabName:GetName().."OnShow")
			self.hooks[tabName].OnShow()
			tabName:SetWidth(tabName:GetWidth() * 0.85)
			end)
		self:keepRegions(tabName, {7}) -- N.B. region 7 is text
		tabName:SetHeight(tabName:GetHeight() * (FTyMult + FTyMult))
		if i == 1 then 
			self:moveObject(tabName, nil, nil, "_", 8) 
		else
			self:moveObject(tabName, "+", 15, nil, nil) 
		end
        if self.db.profile.TexturedTab then self:applySkin(tabName, nil, 0, 1)
		else self:applySkin(tabName) end
	end

	self:moveObject(_G["MetaMap_CloseButton"], nil, nil, "_", 2)

	self:applySkin(_G["MetaMap_DialogFrame"], 1)
	
end
