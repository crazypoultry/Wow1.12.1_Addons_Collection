--[[ 

PanzaPFM.lua
Panza PFM (Panza Free Module) Dialog 
Revision 4.0

10-01-06 "for in pairs()" completed for BC
]]

-----------------------------------------
-- 3.0 PFM reverse lookups - dummy values
-----------------------------------------
function PA:SetupPFM()
	PA.PFMLookup = {};
	PA.PFMLookup[1] = "WARRIOR";
	PA.PFMLookup[2] = "ROGUE";
	PA.PFMLookup[3] = "PRIEST";
	PA.PFMLookup[4] = "DRUID";
	PA.PFMLookup[5] = "HUNTER";
	PA.PFMLookup[6] = "MAGE";
	PA.PFMLookup[7] = "WARLOCK";
	PA.PFMLookup[8] = PA.HybridClass;
end

function PA:PFM_OnLoad()
	PA.OptionsMenuTree[7] = {Title="Freeing", Frame=this, Tooltip="Freeing Options", Filter={Spell="bof"}};
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end

function PA:PFM_SetValues()
	for i = 1, 8 do
		getglobal("SliderPAPFM"..i):SetValue(PASettings.PFMWeight[PA.PFMLookup[i]]);
		getglobal("SliderPAPFM"..i.."Text"):SetText(PA:Capitalize(PA.ClassName[PA.PFMLookup[i]]));
	end										
end

function PA:PFM_Defaults()

	if (PA:CheckMessageLevel("Core", 4)) then
		PA:Message4("Resetting PFM settings to default");
	end

	PASettings.PFMClass = {};
	PASettings.PFMClass["WARRIOR"] 		= 1;
	PASettings.PFMClass["ROGUE"] 		= 2;
	PASettings.PFMClass["PRIEST"] 		= 3;
	PASettings.PFMClass["DRUID"]		= 4;
	PASettings.PFMClass["HUNTER"]		= 5;
	PASettings.PFMClass["MAGE"]			= 6;
	PASettings.PFMClass["WARLOCK"] 		= 7;
	PASettings.PFMClass[PA.HybridClass] = 8;
	
	PASettings.PFMWeight = {};
	PASettings.PFMWeight["PRIEST"] 			= 6; -- Weighting Higher freed 1st
	PASettings.PFMWeight["DRUID"]			= 5;
	PASettings.PFMWeight["MAGE"] 			= 3;
	PASettings.PFMWeight["WARLOCK"]			= 3;
	PASettings.PFMWeight[PA.HybridClass]	= 1;
	PASettings.PFMWeight["WARRIOR"]			= 8;
	PASettings.PFMWeight["HUNTER"] 			= 4;
	PASettings.PFMWeight["ROGUE"]			= 7;
	
	PA.PFMLookup = {};
	for key, value in pairs(PASettings.PFMClass) do
		--PA:Message(PA_GREN..key..""..PA_WHITE.." - "..PA_BLUE..""..value);
		PA.PFMLookup[value] = key;
	end
	
	PASettings.Switches["PFM"] = {useweight=false}; -- Use weighting for free

end

function PA:PFM_OnShow()
	PA:Reposition(PanzaPFMFrame, "UIParent", true);
	PanzaPFMFrame:SetAlpha(PASettings.Alpha);
	PA:PFM_SetValues();
end

function PA:PFM_OnHide()
	-- place holder
end

function PA:PFM_btnDone_OnClick()
	PA:FrameToggle(PanzaPFMFrame);
end

--------------------------------------
-- Generic Tooltip Function
--------------------------------------
function PA:PFM_ShowTooltip(item, index)
	GameTooltip:SetOwner( getglobal(item:GetName()), "ANCHOR_TOP" );
	GameTooltip:ClearLines();
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPLEFT", item:GetName(), "BOTTOMLEFT", 0, -2);
	if (index>0) then
		GameTooltip:AddLine(PA.PFM_Tooltips.SliderPAPFM.tooltip1.." - "..PA_YEL..PA:Capitalize(PA.ClassName[PA.PFMLookup[index]]));
		GameTooltip:AddLine(PA.PFM_Tooltips.SliderPAPFM.tooltip2, 1, 1, 1, 1, 1 );
	else
		GameTooltip:AddLine(PA.PFM_Tooltips[item:GetName()].tooltip1 );
		GameTooltip:AddLine(PA.PFM_Tooltips[item:GetName()].tooltip2, 1, 1, 1, 1, 1 );
	end
	GameTooltip:Show();
end