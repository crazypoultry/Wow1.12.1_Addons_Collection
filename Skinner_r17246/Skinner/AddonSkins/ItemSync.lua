
function Skinner:ItemSync() 

	self:hookDDScript(ISync_MainFrame_DropDownButton)
	self:hookDDScript(ISync_Location_DropDownButton)
	self:hookDDScript(ISync_Rarity_DropDownButton)
	self:hookDDScript(ISync_Weapons_DropDownButton)
	self:hookDDScript(ISync_Level_DropDownButton)
	self:hookDDScript(ISync_Tradeskills_DropDownButton)
	self:hookDDScript(ISync_Armor_DropDownButton)
	self:hookDDScript(ISync_Shield_DropDownButton)
	self:hookDDScript(ISync_FavFrame_DropDownButton)
	self:hookDDScript(ISync_FilterPurgeRare_DropDownButton)
	
	for i = 1, 4 do
	  self:removeRegions(_G["ISync_OptionsFrameTab"..i], {1, 2, 3, 4})
	  self:moveObject(_G["ISync_OptionsFrameTab"..i], "+", 15, nil, nil)
	  self:applySkin(_G["ISync_OptionsFrameTab"..i])
	end
	
	self:applySkin(_G["ISync_MainFrame"])
	self:applySkin(_G["ISync_SearchFrame"])
	self:applySkin(_G["ISync_BV_Frame"])
	self:applySkin(_G["ISync_FavFrame"])
	self:applySkin(_G["ISync_FiltersFrame"])
	self:applySkin(_G["ISync_OptionsFrame"])

end
