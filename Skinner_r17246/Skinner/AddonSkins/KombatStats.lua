
function Skinner:KombatStats() 

	self:applySkin(_G["KombatStatsFrame"])
	if _G["KombatStats"].dpsButton then 
		self:applySkin(_G["KombatStats"].dpsButton)
	end

end
