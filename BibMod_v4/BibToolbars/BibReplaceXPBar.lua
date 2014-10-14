
-- This function handles events for the XP bar we're using
-- to replace the one we removed in RemoveMainActionBar()
function BibmodXPBarOnEvent (event)
	if (event == "PLAYER_XP_UPDATE" or event == "PLAYER_LEVEL_UP" or event == "PLAYER_ENTERING_WORLD") then
		local currXP = UnitXP("player");
		local nextlevelXP = UnitXPMax("player");
		local restXP = GetXPExhaustion();
		
		this:SetMinMaxValues(min(0, currXP), nextlevelXP);
		BibFatigueBar:SetMinMaxValues(min(0, currXP), nextlevelXP);
		this:SetValue(currXP);
		if(restXP == nil) then
			BibFatigueBar:SetValue(currXP);
		else
			BibFatigueBar:SetValue(currXP + (tonumber(restXP) / 2));
		end	
		UpdateBibXPBarText();
		return;
	end
end

function UpdateBibXPBarText()
		local currXP = UnitXP("player");
		local nextlevelXP = UnitXPMax("player");
		local restXP = GetXPExhaustion();
		
		if(restXP == nil) then
			BibXPBarText:SetText("XP "..currXP.." / "..nextlevelXP);
		else
			BibXPBarText:SetText("XP "..currXP.." / "..nextlevelXP.." (+"..(tonumber(restXP) / 2)..")");
		end
end
