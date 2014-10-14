--[[ 

PanzaPAM.lua
Panza Message Settings Dialog 
Revision 4.0

]]

MessageLevelTxt = { [1]='Normal', [2]='Low Detail', [3]='Medium Detail', [4]='High Detail', [5]='All Messages' };

function PA:PAM_OnLoad()
	PA.OptionsMenuTree[3] = {Title="Messages", Frame=this, Tooltip="Message Options", Check=true, Sub={}};
	PA.OptionsMenuTree[3].Sub[1] = {Title="Custom", Frame=PanzaPAMCustomFrame, Tooltip="Custom Message Options"};
	PA.GUIFrames[this:GetName()] = this;
	UIPanelWindows[this:GetName()] = {area = "center", pushable = 0};
end

function PA:PAM_SetValues()

	SliderPanzaPAMBless:SetValue(PASettings.Switches.MsgLevel.Bless);
	SliderPanzaPAMHeal:SetValue(PASettings.Switches.MsgLevel.Heal);
	SliderPanzaPAMCure:SetValue(PASettings.Switches.MsgLevel.Cure);
	SliderPanzaPAMCore:SetValue(PASettings.Switches.MsgLevel.Core);
	SliderPanzaPAMRez:SetValue(PASettings.Switches.MsgLevel.Rez);
	SliderPanzaPAMUI:SetValue(PASettings.Switches.MsgLevel.UI);
	SliderPanzaPAMCoop:SetValue(PASettings.Switches.MsgLevel.Coop);
	SliderPanzaPAMOffen:SetValue(PASettings.Switches.MsgLevel.Offen);

	cbxPanzaPAMHealParty:SetChecked(PASettings.Switches.MsgGroup.Heal.Party == true);
	cbxPanzaPAMHealRaid:SetChecked(PASettings.Switches.MsgGroup.Heal.Raid == true);
	cbxPanzaPAMHealWhis:SetChecked(PASettings.Switches.MsgGroup.Heal.Whisper == true);
	cbxPanzaPAMHealSay:SetChecked(PASettings.Switches.MsgGroup.Heal.Say == true);
	cbxPanzaPAMHealEM:SetChecked(PASettings.Switches.MsgGroup.Heal.EM == true);
	cbxPanzaPAMBlessParty:SetChecked(PASettings.Switches.MsgGroup.Bless.Party == true);
	cbxPanzaPAMBlessRaid:SetChecked(PASettings.Switches.MsgGroup.Bless.Raid == true);
	cbxPanzaPAMBlessWhis:SetChecked(PASettings.Switches.MsgGroup.Bless.Whisper == true);
	cbxPanzaPAMBlessSay:SetChecked(PASettings.Switches.MsgGroup.Bless.Say == true);
	cbxPanzaPAMBlessEM:SetChecked(PASettings.Switches.MsgGroup.Bless.EM == true);
	cbxPanzaPAMCureParty:SetChecked(PASettings.Switches.MsgGroup.Cure.Party == true);
	cbxPanzaPAMCureRaid:SetChecked(PASettings.Switches.MsgGroup.Cure.Raid == true);
	cbxPanzaPAMCureWhis:SetChecked(PASettings.Switches.MsgGroup.Cure.Whisper == true);	
	cbxPanzaPAMCureSay:SetChecked(PASettings.Switches.MsgGroup.Cure.Say == true);
	cbxPanzaPAMCureEM:SetChecked(PASettings.Switches.MsgGroup.Cure.EM == true);
	cbxPanzaPAMRezParty:SetChecked(PASettings.Switches.MsgGroup.Rez.Party == true);
	cbxPanzaPAMRezRaid:SetChecked(PASettings.Switches.MsgGroup.Rez.Raid == true);
	cbxPanzaPAMRezWhis:SetChecked(PASettings.Switches.MsgGroup.Rez.Whisper == true);	
	cbxPanzaPAMRezSay:SetChecked(PASettings.Switches.MsgGroup.Rez.Say == true);
	cbxPanzaPAMRezEM:SetChecked(PASettings.Switches.MsgGroup.Rez.EM == true);
	cbxPanzaPAMSendProgress:SetChecked(PASettings.Switches.HealProgress == true);
	cbxPanzaPAMNotifyFail:SetChecked(PASettings.Switches.NotifyFail == true);
	cbxPanzaPAMShowRanks:SetChecked(PASettings.Switches.ShowRanks.enabled == true);
	cbxPanzaPAMQuietNotRequired:SetChecked(PASettings.Switches.QuietOnNotRequired==true);
	
	PA:PAM_UpdateHeal();
	PA:PAM_UpdateBless();
	PA:PAM_UpdateCure();
	PA:PAM_UpdateRez();
	PA:PAM_UpdateCore();
	PA:PAM_UpdateUI();
	PA:PAM_UpdateCoop();
	PA:PAM_UpdateOffen();

end

function PA:PAM_UpdateHeal()
	local txt;	
	if (PASettings.Switches.MsgLevel.Heal > 0) then
		txt = MessageLevelTxt[PASettings.Switches.MsgLevel.Heal];
	else
		txt = 'Errors Only';
	end
	txtPanzaPAMHeal:SetText(txt);
	txtPanzaPAMHeal:Show();
end

function PA:PAM_UpdateBless()
	local txt;
	if (PASettings.Switches.MsgLevel.Bless > 0) then
		txt = MessageLevelTxt[PASettings.Switches.MsgLevel.Bless];
	else
		txt = 'Errors Only';
	end		
	txtPanzaPAMBless:SetText(txt);
	txtPanzaPAMBless:Show();
end

function PA:PAM_UpdateCure()
	local txt;
	if (PASettings.Switches.MsgLevel.Cure > 0) then
		txt = MessageLevelTxt[PASettings.Switches.MsgLevel.Cure];
	else
		txt = 'Errors Only';
	end		
	txtPanzaPAMCure:SetText(txt);
	txtPanzaPAMCure:Show();
end

function PA:PAM_UpdateRez()
    local txt;
	if (PASettings.Switches.MsgLevel.Rez > 0) then
		txt = MessageLevelTxt[PASettings.Switches.MsgLevel.Rez];
	else
		txt = 'Errors Only';
	end		
	txtPanzaPAMRez:SetText(txt);
	txtPanzaPAMRez:Show();
end

function PA:PAM_UpdateCore()
	local txt;
	if (PASettings.Switches.MsgLevel.Core > 0) then
		txt = MessageLevelTxt[PASettings.Switches.MsgLevel.Core];
	else
		txt = 'Errors Only';
	end		
	txtPanzaPAMCore:SetText(txt);
	txtPanzaPAMCore:Show();
end

function PA:PAM_UpdateUI()
	local txt;
	if (PASettings.Switches.MsgLevel.UI > 0) then
		txt = MessageLevelTxt[PASettings.Switches.MsgLevel.UI];
	else
		txt = 'Errors Only';
	end		
	txtPanzaPAMUI:SetText(txt);
	txtPanzaPAMUI:Show();
end

function PA:PAM_UpdateCoop()
	local txt;
	if (PASettings.Switches.MsgLevel.Coop > 0) then
		txt = MessageLevelTxt[PASettings.Switches.MsgLevel.Coop];
	else
		txt = 'Errors Only';
	end		
	txtPanzaPAMCoop:SetText(txt);
	txtPanzaPAMCoop:Show();
end

function PA:PAM_UpdateOffen()
	local txt;
	if (PASettings.Switches.MsgLevel.Offen > 0) then
		txt = MessageLevelTxt[PASettings.Switches.MsgLevel.Offen];
	else
		txt = 'Errors Only';
	end		
	txtPanzaPAMOffen:SetText(txt);
	txtPanzaPAMOffen:Show();
end

function PA:PAM_OnShow()
	PA:Reposition(PanzaPAMFrame, "UIParent", true);
	PanzaPAMFrame:SetAlpha(PASettings.Alpha);
	PA:PAM_SetValues();
end

function PA:PAM_OnHide()
	-- place holder
end

function PA:PAM_btnDone_OnClick()
	HideUIPanel(PanzaPAMFrame);
end

function PA:PAM_btnQuiet_OnClick()
	Panza_SlashHandler("quiet")
	PA:PAM_SetValues();
end

--------------------------------------
-- Dynamic Tooltip Function
--------------------------------------
function PA:PAM_DynamicTooltip(item, Area)
	local txt;

	GameTooltip:SetOwner(item, "ANCHOR_TOPRIGHT", 0, 10);
	GameTooltip:ClearLines();

	if (Area == "Healing") then
		txt = txtPanzaPAMHeal:GetText();
		if (txt == 'Errors Only') then			
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMHealError"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMHealError"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'Normal') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMHealNormal"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMHealNormal"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'Low Detail') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMHealLow"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMHealLow"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'Medium Detail') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMHealMedium"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMHealMedium"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'High Detail') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMHealHigh"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMHealHigh"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'All Messages') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMHealAll"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMHealAll"].tooltip2, 1, 1, 1, 1, 1 );
		end

	elseif (Area == "Blessing") then
		txt = txtPanzaPAMBless:GetText();
		if (txt == 'Errors Only') then			
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMBlessError"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMBlessError"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'Normal') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMBlessNormal"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMBlessNormal"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'Low Detail') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMBlessLow"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMBlessLow"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'Medium Detail') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMBlessMedium"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMBlessMedium"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'High Detail') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMBlessHigh"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMBlessHigh"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'All Messages') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMBlessAll"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMBlessAll"].tooltip2, 1, 1, 1, 1, 1 );
		end

	elseif (Area == "Cure") then		
		txt = txtPanzaPAMCure:GetText();
		if (txt == 'Errors Only') then			
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMCureError"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMCureError"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'Normal') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMCureNormal"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMCureNormal"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'Low Detail') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMCureLow"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMCureLow"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'Medium Detail') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMCureMedium"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMCureMedium"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'High Detail') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMCureHigh"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMCureHigh"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'All Messages') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMCureAll"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMCureAll"].tooltip2, 1, 1, 1, 1, 1 );
		end

	elseif (Area == "Rez") then		
		txt = txtPanzaPAMRez:GetText();
		if (txt == 'Errors Only') then			
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMRezError"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMRezError"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'Normal') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMRezNormal"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMRezNormal"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'Low Detail') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMRezLow"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMRezLow"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'Medium Detail') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMRezMedium"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMRezMedium"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'High Detail') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMRezHigh"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMRezHigh"].tooltip2, 1, 1, 1, 1, 1 );
		elseif (txt == 'All Messages') then
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMRezAll"].tooltip1 );
			GameTooltip:AddLine( PA.PAM_Tooltips["txtPanzaPAMRezAll"].tooltip2, 1, 1, 1, 1, 1 );
		end

	elseif (Area == "Core") then
		txt = txtPanzaPAMCore:GetText();
	elseif (Area == "UI") then
		txt = txtPanzaPAMUI:GetText();
	elseif (Area == "Coop") then
		txt = txtPanzaPAMCoop:GetText();
	elseif (Area == "Offen") then
		txt = txtPanzaPAMOffen:GetText();
	end
	GameTooltip:Show();
end


--------------------------------------
-- Generic Tooltip Function
--------------------------------------
function PA:PAM_ShowTooltip(item)
	GameTooltip:SetOwner(item, "ANCHOR_TOPRIGHT", 0, 10);
	GameTooltip:ClearLines();
	GameTooltip:AddLine( PA.PAM_Tooltips[item:GetName()].tooltip1 );
	GameTooltip:AddLine( PA.PAM_Tooltips[item:GetName()].tooltip2, 1, 1, 1, 1, 1 );
	GameTooltip:Show();
end

-------------------------------------------------------------------------------------
-- 	Panza Message (PAM) Level and Message Groups 
--
--	MsgLevel 	0	Only Errors (not configurable)
--			1	Normal Messages
--			2 - 4	UnSpecified Higher Detail
--			5	Debug Level
--	MsgGroup	Heal	settings for Party, Raid, or Whisper
--			Bless	
--			Cure	
--			Rez
-------------------------------------------------------------------------------------
function PA:PAM_Defaults()

	if (PA:CheckMessageLevel("Core",5)) then
		PA:Message4(PANZA_PAM_ENTERRESET);
	end
	
	PASettings.Switches["MsgLevel"]		= {Heal=1,Bless=1,Cure=1,Core=1,Rez=1,UI=1,Coop=1,Offen=1};
	PASettings.Switches["MsgGroup"]		= {};
	PASettings.Switches.MsgGroup["Heal"] 	= {Party=false, Raid=false, Whisper=false, Say=false, EM=false};
	PASettings.Switches.MsgGroup["Bless"] 	= {Party=false, Raid=false, Whisper=false, Say=false, EM=false};
	PASettings.Switches.MsgGroup["Cure"] 	= {Party=false, Raid=false, Whisper=false, Say=false, EM=false};
	PASettings.Switches.MsgGroup["Rez"] 	= {Party=true,  Raid=false, Whisper=true,  Say=false, EM=false};

	PASettings.Switches["NotifyFail"] 	= false; 
	PASettings.Switches["HealProgress"]	= false;
	PASettings.Switches["ShowRanks"]	= {enabled=true};
	PASettings.Switches.QuietOnNotRequired 		= false; -- Used to suppress not required messages
	
	if (PA:CheckMessageLevel("Core", 1)) then
		PA:Message4(PANZA_PAM_DONERESET);
	end
end	

