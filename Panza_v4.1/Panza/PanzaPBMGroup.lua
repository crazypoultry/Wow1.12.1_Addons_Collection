--[[

PanzaPBMGroup.lua
Panza
Panza Group Buffing
Revision 4.2

]]

function PA:PBMGroup_OnLoad()
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end

function PA:PBMGroup_SetValues()
	cbxPanzaGBMe:SetChecked(PASettings.Switches.GreaterBlessings.SOLO == true);
	cbxPanzaGBParty:SetChecked(PASettings.Switches.GreaterBlessings.PARTY == true);
	cbxPanzaGBRaid:SetChecked(PASettings.Switches.GreaterBlessings.RAID == true);
	cbxPanzaGBBG:SetChecked(PASettings.Switches.GreaterBlessings.BG == true);

	SliderPanzaPBMGreater:SetValue(PASettings.Switches.GreaterBlessings.Threshold*100);
	
end

function PA:PBMGroup_Defaults()
	PASettings.Switches["GreaterBlessings"] 	= {SOLO=false,PARTY=false,RAID=true,BG=false, Warn=true, Threshold=0.0};
end

function PA:PBMGroup_OnShow()
	PA:Reposition(PanzaPBMGroupFrame, "UIParent", true);
	PanzaPBMGroupFrame:SetAlpha(PASettings.Alpha);
	PA:PBMGroup_SetValues();
end

function PA:PBMGroup_OnHide()
	-- place holder
end


function PA:PBMGroup_btnDone_OnClick()
	PA:FrameToggle(this:GetParent());
end

function PA:PBMGroup_UpdateGreater()
	local txt = PASettings.Switches.GreaterBlessings.Threshold * 100 .. "%";
	txtPanzaPBMGreater:SetText(txt);
	txtPanzaPBMGreater:Show();
end

--------------------------------------
-- Generic Tooltip Function
--------------------------------------

function PA:PBMGroup_ShowTooltip(item)
	GameTooltip:SetOwner(getglobal(item:GetName()), "ANCHOR_TOP");
	GameTooltip:ClearLines();
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPLEFT", item:GetName(), "BOTTOMLEFT", 0, -2);
	local TipIndex = 1;
	local TipLine = PA.PBM_Tooltips[item:GetName()]["tooltip"..TipIndex];
	while (TipLine~=nil) do
		if (TipIndex==1) then
			GameTooltip:AddLine(TipLine);
		else
			GameTooltip:AddLine(TipLine, 1, 1, 1, 1, 1);
		end
		TipIndex = TipIndex + 1;
		TipLine = PA.PBM_Tooltips[item:GetName()]["tooltip"..TipIndex];
	end
	GameTooltip:Show();
end
