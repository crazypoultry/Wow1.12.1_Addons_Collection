



function PRD_UpdateGUI()

	if (PRD_State == 0) then
		PRD_Config_Frame_Bar_AlphaRange:SetValue((PRD_Running["Alpha"]["Range"] * 100));
		PRD_Config_Frame_Bar_AlphaDead:SetValue((PRD_Running["Alpha"]["Dead"] * 100));
		PRD_Config_Frame_Bar_AlphaOffline:SetValue((PRD_Running["Alpha"]["Offline"] * 100));
		
		if (PRD_Running["Yards"] == 40) then
			PRD_Config_Frame_Radio_RetriveMethod_1_1:SetChecked(1);
		else
			PRD_Config_Frame_Radio_RetriveMethod_1_1:SetChecked(0);
		end;
	end
	
	PRD_Config_Frame_Radio_RetriveMethod_1:SetChecked(0);
	PRD_Config_Frame_Radio_RetriveMethod_2:SetChecked(0);
	PRD_Config_Frame_Radio_RetriveMethod_3:SetChecked(0);
	getglobal("PRD_Config_Frame_Radio_RetriveMethod_"..PRD_Running["RetriveMethod"]):SetChecked(1);
	
	-- Disable sub button
	if ( PRD_Running["RetriveMethod"] == 1 or PRD_Running["RetriveMethod"] == 3 ) then
		PRD_Config_Frame_Radio_RetriveMethod_1_1:Enable();
	else
		PRD_Config_Frame_Radio_RetriveMethod_1_1:Disable();
	end
	
	
	PRD_Config_Frame_Radio_DisplayMethod_1:SetChecked(0);
	PRD_Config_Frame_Radio_DisplayMethod_2:SetChecked(0);
	PRD_Config_Frame_Radio_DisplayMethod_3:SetChecked(0);
	PRD_Config_Frame_Radio_DisplayMethod_4:SetChecked(0);
	getglobal("PRD_Config_Frame_Radio_DisplayMethod_"..PRD_Running["DisplayMethod"]):SetChecked(1);
	
end

--Hoock
function PRD_ShowOptions()
	Perl_Config_Hide_All();
	PRD_Config_Frame:Show();
end


-- Repos button & options for PCUF 0.81
Perl_Config_Button_OnClick_Org = Perl_Config_Button_OnClick;
function Perl_Config_Button_OnClick(arg1)
	Perl_Config_Button_OnClick_Org(arg1);
	Perl_Config_ThirdParty_Raid_Distance_Button1:Show();
	Perl_Config_ThirdParty_Raid_Distance_Button1:SetParent(Perl_Config_ThirdParty_Frame);
	Perl_Config_ThirdParty_Raid_Distance_Button1:SetPoint("LEFT", Perl_Config_ThirdParty_Frame, "TOPLEFT", 40, -120);
	PRD_Config_Frame:SetPoint("TOPLEFT", Perl_Config_Frame, "TOPLEFT", 0, -120);
end

----------------------
-- Update Perl config --
----------------------
Perl_Config_Hide_All_Org = Perl_Config_Hide_All;
function Perl_Config_Hide_All()
	Perl_Config_Hide_All_Org();
	PRD_Config_Frame:Hide();
end



