--[[

PanzaBLP.lua
for Panza Blessing Parameter Dialog
Revision 3.0

]]


function PA:BLP_OnLoad()
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end

function PA:BLP_SetValues()


	cbxPanzaEnableCycle:SetChecked(PASettings.Switches.EnableCycle == true);
	cbxPanzaEnableNPC:SetChecked(PASettings.Switches.EnableNPC == true);
	SliderPanzaBLPNPC:SetValue(tonumber(PASettings.Switches.NPCount));
	SliderPanzaBLPRebless:SetValue(tonumber(PASettings.Switches.Rebless));
	SliderPanzaBLPNearRestart:SetValue(tonumber(PASettings.Switches.NearRestart));

end


function PA:BLP_OnShow()
	PA:Reposition(PanzaBLPFrame, "UIParent", true);
	PanzaBLPFrame:SetAlpha(PASettings.Alpha);
	PA:BLP_SetValues();
end

function PA:BLP_OnHide()
	-- place holder
end


function PA:BLP_UpdateNPCS()
        local txt;

        txt = PASettings.Switches.NPCount;
        txtPanzaBLPNPCount:SetText(txt);
        txtPanzaBLPNPCount:Show();

end

function PA:BLP_UpdateRebless()
        local txt;

        txt = PASettings.Switches.Rebless;
        txtPanzaBLPRebless:SetText(txt);
        txtPanzaBLPRebless:Show();

end

function PA:BLP_UpdateNearRestart()
        local txt;

        txt = PASettings.Switches.NearRestart;
        txtPanzaBLPNearRestart:SetText(txt);
        txtPanzaBLPNearRestart:Show();


end

function PA:BLP_OnMouseDown(arg1)
	if (arg1 == "LeftButton") then
		PanzaBLPFrame:StartMoving();
	end
end

function PA:BLP_OnMouseUp(arg1)
	if (arg1 == "LeftButton") then
		PanzaBLPFrame:StopMovingOrSizing();
	end
end

function PA:BLP_btnDone_OnClick()
	Panza_BLP_Toggle()
end

--------------------------------------
-- Generic Tooltip Function
--------------------------------------

function PA:BLP_ShowTooltip(item)
	GameTooltip:SetOwner( getglobal(item:GetName()), "ANCHOR_TOP" );
	GameTooltip:ClearLines();
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPLEFT", item:GetName(), "BOTTOMLEFT", 0, -2);
	GameTooltip:AddLine( PA:BLP_Tooltips[item:GetName()].tooltip1 );
	GameTooltip:AddLine( PA:BLP_Tooltips[item:GetName()].tooltip2, 1, 1, 1, 1, 1 );
	GameTooltip:Show();
end

