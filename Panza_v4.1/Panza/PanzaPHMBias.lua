--[[

PanzaPHMBias.lua
Panza PHMBias (Panza Heal Module, class biases) Dialog
Revision 4.1

10-01-06 "for in pairs()" completed for BC
]]

-----------------------------------------
-- 3.0 PHMBias reverse lookups - dummy values
-----------------------------------------
function PA:SetupPHMBias()
	PA.PHMBiasLookup = {};
	PA.PHMBiasLookup[1] = "WARRIOR";
	PA.PHMBiasLookup[2] = "ROGUE";
	PA.PHMBiasLookup[3] = "PRIEST";
	PA.PHMBiasLookup[4] = "DRUID";
	PA.PHMBiasLookup[5] = "HUNTER";
	PA.PHMBiasLookup[6] = "MAGE";
	PA.PHMBiasLookup[7] = "WARLOCK";
	PA.PHMBiasLookup[8] = PA.HybridClass;
end

function PA:PHMBias_OnLoad()
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end

function PA:PHMBias_SetValues()
	for i = 1, 8 do
		getglobal("SliderPAPHMBias"..i):SetValue(PASettings.PHMBiasWeight[PA.PHMBiasLookup[i]]);
		getglobal("SliderPAPHMBias"..i.."Text"):SetText(PA:Capitalize(PA.ClassName[PA.PHMBiasLookup[i]]));
	end
	SliderPanzaSelfBias:SetValue(PASettings.Heal.SelfBias * 100);
	PA:PHMBias_UpdateSelfBias();
	SliderPanzaPartyBias:SetValue(PASettings.Heal.PartyBias * 100);
	PA:PHMBias_UpdatePartyBias();
	SliderPanzaMainTankBias:SetValue(PASettings.Heal.MainTankBias * 100);
	PA:PHMBias_UpdateMainTankBias();
	SliderPanzaMTTTBias:SetValue(PASettings.Heal.MTTTBias * 100);
	PA:PHMBias_UpdateMTTTBias();
end

function PA:PHMBias_Defaults()

	if (PA:CheckMessageLevel("Core", 4)) then
		PA:Message4("Resetting PHMBias settings to default");
	end

	PASettings.Heal.SelfBias = 0.0;
	PASettings.Heal.PartyBias = 0.25;
	PASettings.Heal.MainTankBias = 0.0;
	PASettings.Heal.MTTTBias = 0.0;

	PASettings.PHMBiasClass = {};
	PASettings.PHMBiasClass["WARRIOR"] 		= 1;
	PASettings.PHMBiasClass["ROGUE"] 		= 2;
	PASettings.PHMBiasClass["PRIEST"] 		= 3;
	PASettings.PHMBiasClass["DRUID"]		= 4;
	PASettings.PHMBiasClass["HUNTER"]		= 5;
	PASettings.PHMBiasClass["MAGE"]			= 6;
	PASettings.PHMBiasClass["WARLOCK"] 		= 7;
	
	if (not PA.HybridClass) then
		PA:SetupClasses();
	end
	
	PASettings.PHMBiasClass[PA.HybridClass] = 8;

	PASettings.PHMBiasWeight = {};
	PASettings.PHMBiasWeight["PRIEST"] 			= 0; -- Biases
	PASettings.PHMBiasWeight["DRUID"]			= 0;
	PASettings.PHMBiasWeight["MAGE"] 			= 0;
	PASettings.PHMBiasWeight["WARLOCK"]			= 0;
	PASettings.PHMBiasWeight[PA.HybridClass]	= 0;
	PASettings.PHMBiasWeight["WARRIOR"]			= 0;
	PASettings.PHMBiasWeight["HUNTER"] 			= 0;
	PASettings.PHMBiasWeight["ROGUE"]			= 0;

	PA.PHMBiasLookup = {};
	for key, value in pairs(PASettings.PHMBiasClass) do
		--PA:Message(PA_GREN..key..""..PA_WHITE.." - "..PA_BLUE..""..value);
		PA.PHMBiasLookup[value] = key;
	end

end

------------
-- Self Bias
------------
function PA:PHMBias_UpdateSelfBias()
	local txt = PASettings.Heal.SelfBias * 100 .. "%";
	txtPHMSelfBias:SetText(txt);
	txtPHMSelfBias:Show();
end

-------------
-- Party Bias
-------------
function PA:PHMBias_UpdatePartyBias()
	local txt = PASettings.Heal.PartyBias * 100 .. "%";
	txtPHMPartyBias:SetText(txt);
	txtPHMPartyBias:Show();
end

-----------------
-- Main Tank Bias
-----------------
function PA:PHMBias_UpdateMainTankBias()
	local txt = PASettings.Heal.MainTankBias * 100 .. "%";
	txtPHMMainTankBias:SetText(txt);
	txtPHMMainTankBias:Show();
end

-----------------------------------
-- Main Tanks' Target's Target Bias
-----------------------------------
function PA:PHMBias_UpdateMTTTBias()
	local txt = PASettings.Heal.MTTTBias * 100 .. "%";
	txtPHMMTTTBias:SetText(txt);
	txtPHMMTTTBias:Show();
end

function PA:PHMBias_OnShow()
	PA:Reposition(PanzaPHMBiasFrame, "UIParent", true);
	PanzaPHMBiasFrame:SetAlpha(PASettings.Alpha);
	PA:PHMBias_SetValues();
end

function PA:PHMBias_OnHide()
	-- place holder
end

function PA:PHMBias_btnDone_OnClick()
	PA:FrameToggle(PanzaPHMBiasFrame);
end

--------------------------------------
-- Generic Tooltip Function
--------------------------------------
function PA:PHMBias_ShowTooltip(item, index)
	GameTooltip:SetOwner( getglobal(item:GetName()), "ANCHOR_TOP" );
	GameTooltip:ClearLines();
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPLEFT", item:GetName(), "BOTTOMLEFT", 0, -2);
	if (index~=nil and index>0) then
		GameTooltip:AddLine(PA.PHMBias_Tooltips.SliderPAPHMBias.tooltip1.." - "..PA_YEL..PA:Capitalize(PA.ClassName[PA.PHMBiasLookup[index]]));
		GameTooltip:AddLine(PA.PHMBias_Tooltips.SliderPAPHMBias.tooltip2, 1, 1, 1, 1, 1 );
	else
		GameTooltip:AddLine(PA.PHMBias_Tooltips[item:GetName()].tooltip1 );
		GameTooltip:AddLine(PA.PHMBias_Tooltips[item:GetName()].tooltip2, 1, 1, 1, 1, 1 );
	end
	if (index~=nil and index==-1) then
		if (not PA:MainTanksAvailable()) then
			GameTooltip:AddLine("MainTanks support currently available for CTRA, RDX, and oRA", 0.8, 0.2, 0.2);
		else
			local MainTanks = PA:GetMainTanks();
			if (PA:TableSize(MainTanks)==0) then
				GameTooltip:AddLine("No Main Tanks set", 0.2, 0.2, 0.8);
			else
				for _, MTName in pairs(MainTanks) do
					GameTooltip:AddLine(MTName, 0.2, 0.2, 0.8);
				end
			end
		end
	end
	GameTooltip:Show();
end