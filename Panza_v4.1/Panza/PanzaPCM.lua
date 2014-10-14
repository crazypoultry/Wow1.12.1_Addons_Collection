--[[

PanzaPCM.lua
Panza PCM (Panza DeDebuff Module) Dialog
Revision 4.0

10-01-06 "for in pairs()" completed for BC
]]

function PA:PCM_OnLoad()
	PA.OptionsMenuTree[6] = {Title="Debuff Removal", Frame=this, Tooltip="Debuff Removal Options", Check=true, Sub={}, Filter={Spell="Cure"}};
	PA.OptionsMenuTree[6].Sub[1] = {Title="Biases", Frame=PanzaPHMBiasFrame, Tooltip="Bias Options"};
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end

-----------------------------------------
-- 3.0 PCM reverse lookups - dummy values
-----------------------------------------
function PA:SetupPCM()
	PA.PCMTypeLookup = {Poison=PANZA_POISON, Disease=PANZA_DISEASE, Magic=PANZA_MAGIC, Curse=PANZA_CURSE};
end

local HasDeDebuffs = {Disease=false, Poison=false, Magic=false, Curse=false}

function PA:PCM_SetValues()

	PA:PCM_Defaults();
	PA:PCM_SetSliders();
	
	for ShortSpell, Debuff in pairs(PA.SpellBook.DeDebuffs) do
		for Type, _ in pairs(PA.PCMTypeLookup) do
			if (Debuff[Type]==true) then
				HasDeDebuffs[Type] = true;
			end
		end
	end

	for Type, Has in pairs(HasDeDebuffs) do
		if (Has==true) then
			getglobal("SliderPCMCure_"..Type):EnableMouse(true);
		else
			getglobal("SliderPCMCure_"..Type):EnableMouse(false);
			getglobal("SliderPCMCure_"..Type):SetValue(0);
			getglobal("SliderPCMCure_"..Type.."Text"):SetTextColor(0.3,0.3,0.3);
		end
	end

end

function PA:PCM_Defaults()

	if (PA:CheckMessageLevel("Core", 4)) then
		PA:Message4("Resetting PCM settings to default");
	end

	PASettings.CurePriority	= {
		Poison	= 0.3,
		Disease	= 0.5,
		Magic	= 0.8,
		Curse	= 0.6
	};

end

function PA:PCM_SetSliders()
	SliderPCMCure_Magic:SetValue(PASettings.CurePriority.Magic);
	SliderPCMCure_MagicText:SetText(PANZA_MAGIC);
	SliderPCMCure_Poison:SetValue(PASettings.CurePriority.Poison);
	SliderPCMCure_PoisonText:SetText(PANZA_POISON);
	SliderPCMCure_Disease:SetValue(PASettings.CurePriority.Disease);
	SliderPCMCure_DiseaseText:SetText(PANZA_DISEASE);
	SliderPCMCure_Curse:SetValue(PASettings.CurePriority.Curse);
	SliderPCMCure_CurseText:SetText(PANZA_CURSE);
end

function PA:PCM_OnShow()
	PA:Reposition(PanzaPCMFrame, "UIParent", true);
	PanzaPCMFrame:SetAlpha(PASettings.Alpha);
	PA:PCM_SetValues();
end

function PA:PCM_OnHide()
	-- place holder
end

function PA:PCM_btnDone_OnClick()
	PA:FrameToggle(PanzaPCMFrame);
end

--------------------------------------
-- Generic Tooltip Function
--------------------------------------
function PA:PCM_ShowTooltip(item)
	local Name = item:GetName();
	local _,_,CureType = string.find(Name, "SliderPCMCure_(%w+)");
	local Text;
	local Tooltip;
	if (CureType~=nil) then
		Text = PA.PCMTypeLookup[CureType];
		Tooltip = PA.PCM_Tooltips.SliderPCMType;
	end
	GameTooltip:SetOwner( getglobal(Name), "ANCHOR_TOP" );
	GameTooltip:ClearLines();
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPLEFT", Name, "BOTTOMLEFT", 0, -2);
	if (Tooltip~=nil and Text~=nil) then
		GameTooltip:AddLine(Tooltip.tooltip1.." - "..PA_YEL..Text);
		GameTooltip:AddLine(Tooltip.tooltip2, 1, 1, 1, 1, 1 );
	else
		GameTooltip:AddLine(PA.PCM_Tooltips[Name].tooltip1 );
		GameTooltip:AddLine(PA.PCM_Tooltips[Name].tooltip2, 1, 1, 1, 1, 1 );
	end
	GameTooltip:Show();
end

function PA:PCM_ChangeValue(item)
	local Name = item:GetName();
	local ValueText = nil;
	local ValuePostfix= "";
	local _,_,CureType = string.find(Name, "SliderPCMCure_(%w+)");
	--PA:ShowText("Name=", Name, " CureType=", CureType);
	if (CureType~=nil) then
		if (HasDeDebuffs[CureType]==true) then
			PASettings.CurePriority[CureType] = this:GetValue();
		end
		ValueText= format("%.2f", tonumber(this:GetValue()));
	end

	local ValueTextLabel = getglobal(Name.."ValueTextLabel");
	if (ValueTextLabel~=nil) then
		if (this:GetValue()>0) then
			ValueTextLabel:SetText(ValueText);
		else
			ValueTextLabel:SetText("Off");
		end
	end
end
