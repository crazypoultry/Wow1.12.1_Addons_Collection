
function Skinner:Possessions() 

	self:hookDDScript(Possessions_CharDropDownButton)
	self:hookDDScript(Possessions_LocDropDownButton)
	self:hookDDScript(Possessions_SlotDropDownButton)
	
	self:removeRegions(_G["Possessions_IC_ScrollFrame"])
	self:skinScrollBar(_G["Possessions_IC_ScrollFrame"])
	
	self:applySkin(_G["Possessions_Frame"])

end
