--[[

PanzaOpts.lua
Panza Settings Dialog
Revision 4.0

]]


function PA:Opts_OnLoad()
	PA.OptionsMenuTree[1] = {Title="General", Frame=this, Tooltip="General Options"};
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end

function PA:Opts_SetValues()
	cbxPanzaButton:SetChecked(PASettings.Switches.Button == true);
	cbxPanzaEnableSave:SetChecked(PASettings.Switches.EnableSave == true);
	cbxPanzaEnableSelf:SetChecked(PASettings.Switches.EnableSelf == true);
	cbxPanzaEnableMLS:SetChecked(PASettings.Switches.EnableMLS == true);
	cbxPanzaEnableOut:SetChecked(PASettings.Switches.EnableOutside == true);
	cbxPanzaEnableRGS:SetChecked(PASettings.Switches.UseRGS.enabled == true);
	cbxPanzaNoPVP:SetChecked(PASettings.Switches.NoPVP.enabled == true);
	cbxPanzaCastBar:SetChecked(PASettings.Switches.CastBar.enabled == true);
	cbxPanzaUseActionHeal:SetChecked(PASettings.Switches.UseActionRange.Heal == true);
	cbxPanzaUseActionCure:SetChecked(PASettings.Switches.UseActionRange.Cure == true);
	cbxPanzaUseActionBless:SetChecked(PASettings.Switches.UseActionRange.Bless == true);
	cbxPanzaUseActionFree:SetChecked(PASettings.Switches.UseActionRange.Free == true);
	cbxPanzaUseActionOffense:SetChecked(PASettings.Switches.UseActionRange.Offense == true);
	SliderPanzaButtonPos:SetValue(PASettings.ButtonPosition);
	SliderPanzaButton:SetValue(PASettings.Button);
	SliderPanzaAlpha:SetValue(PASettings.Alpha);
end


function PA:Opts_UpdateMLS()
	if (PanzaSTAFrame:IsVisible()) then
		txtPanzaSTAL12:SetText(PA:MapLibrary("STATUS"));
	end
end


function PA:Opts_OnShow()
	PA:Reposition(PanzaOptsFrame, "UIParent", true);
	PanzaOptsFrame:SetAlpha(PASettings.Alpha);
	PA:Opts_SetValues();
end

function PA:Opts_OnHide()
	if (MYADDONS_ACTIVE_OPTIONSFRAME == this) then
		myAddOnsFrame:Show();
	end
end

function PA:Opts_btnDone_OnClick()
	PA:OptsToggle();
end

function PA:ButtonUpdatePicture()
	local Button = 1;
	if (PASettings~=nil and PASettings.Button~=nil) then
		Button = PASettings.Button;
	end
    PanzaButton:SetNormalTexture("Interface\\AddOns\\Panza\\Images\\PanzaButton-Up"..Button..".tga");
    PanzaButton:SetPushedTexture("Interface\\AddOns\\Panza\\Images\\PanzaButton-Down"..Button..".tga");
end

--------------------------------------
-- Generic Tooltip Function
--------------------------------------
function PA:Opts_ShowTooltip(item)
	GameTooltip:SetOwner( getglobal(item:GetName()), "ANCHOR_TOP" );
	GameTooltip:ClearLines();
	GameTooltip:ClearAllPoints();
	GameTooltip:SetPoint("TOPLEFT", item:GetName(), "BOTTOMLEFT", 0, -2);
	GameTooltip:AddLine( PA.Opts_Tooltips[item:GetName()].tooltip1 );
	GameTooltip:AddLine( PA.Opts_Tooltips[item:GetName()].tooltip2, 1, 1, 1, 1, 1 );
	GameTooltip:Show();
end

