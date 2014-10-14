function Perl_Config_ColorChange_Display()
	Perl_Config_Hide_All();
	if (Perl_Config_ColorChange_Frame) then
		Perl_Config_ColorChange_Frame:Show();
		Perl_Config_ColorChange_Set_Values();
	else
		Perl_Config_NotInstalled_Frame:Show();
	end
end


function Perl_Config_ColorChange_Set_Values()
	if (Perl_ColorChangeSaved.TARGET == 1) then
		Perl_Config_ColorChange_Frame_CheckButton1:SetChecked(1);
	else
		Perl_Config_ColorChange_Frame_CheckButton1:SetChecked(nil);
	end

	if (Perl_ColorChangeSaved.TARGETCOLOR == 0) then
		Perl_Config_ColorChange_Frame_CheckButton2:SetChecked(1);
		Perl_Config_ColorChange_Frame_CheckButton3:SetChecked(nil);
		Perl_Config_ColorChange_Frame_CheckButton4:SetChecked(nil);
	elseif (Perl_ColorChangeSaved.TARGETCOLOR == 1) then
		Perl_Config_ColorChange_Frame_CheckButton2:SetChecked(nil);
		Perl_Config_ColorChange_Frame_CheckButton3:SetChecked(1);
		Perl_Config_ColorChange_Frame_CheckButton4:SetChecked(nil);
	elseif (Perl_ColorChangeSaved.TARGETCOLOR == 2) then
		Perl_Config_ColorChange_Frame_CheckButton2:SetChecked(nil);
		Perl_Config_ColorChange_Frame_CheckButton3:SetChecked(nil);
		Perl_Config_ColorChange_Frame_CheckButton4:SetChecked(1);
	end
	
	if (Perl_ColorChangeSaved.DEBUFF == 1) then
		Perl_Config_ColorChange_Frame_CheckButton5:SetChecked(1);
	else
		Perl_Config_ColorChange_Frame_CheckButton5:SetChecked(nil);
	end
	
	if (Perl_ColorChangeSaved.DEBUFFCOLOR == 0) then
		Perl_Config_ColorChange_Frame_CheckButton6:SetChecked(1);
		Perl_Config_ColorChange_Frame_CheckButton7:SetChecked(nil);
		Perl_Config_ColorChange_Frame_CheckButton8:SetChecked(nil);
	elseif (Perl_ColorChangeSaved.DEBUFFCOLOR == 1) then
		Perl_Config_ColorChange_Frame_CheckButton6:SetChecked(nil);
		Perl_Config_ColorChange_Frame_CheckButton7:SetChecked(1);
		Perl_Config_ColorChange_Frame_CheckButton8:SetChecked(nil);
	elseif (Perl_ColorChangeSaved.DEBUFFCOLOR == 2) then
		Perl_Config_ColorChange_Frame_CheckButton6:SetChecked(nil);
		Perl_Config_ColorChange_Frame_CheckButton7:SetChecked(nil);
		Perl_Config_ColorChange_Frame_CheckButton8:SetChecked(1);
	end
	
	Perl_Config_ColorChange_Frame_Slider1Text:SetText(Perl_ColorChangeSaved.ALPHA * 100);
	Perl_Config_ColorChange_Frame_Slider1:SetValue(Perl_ColorChangeSaved.ALPHA * 100);
end

function Perl_Config_ColorChange_Set_colorisation(type, mode)
	if not type then
		return ;
	end
	
	if not mode then
		return ;
	end
	
	if type == "target" then
		if mode == "all" then
			Perl_ColorChangeSaved.TARGETCOLOR = Perl_ColorChange.TARGETCOLOR.ALL ;
		elseif mode == "border" then
			Perl_ColorChangeSaved.TARGETCOLOR = Perl_ColorChange.TARGETCOLOR.BORDER ;
		else
			Perl_ColorChangeSaved.TARGETCOLOR = Perl_ColorChange.TARGETCOLOR.MIX ;
		end
	end
	
	if type == "debuff" then
		if mode == "all" then
			Perl_ColorChangeSaved.DEBUFFCOLOR = Perl_ColorChange.DEBUFFCOLOR.ALL ;
		elseif mode == "border" then
			Perl_ColorChangeSaved.DEBUFFCOLOR = Perl_ColorChange.DEBUFFCOLOR.BORDER ;
		else
			Perl_ColorChangeSaved.DEBUFFCOLOR = Perl_ColorChange.DEBUFFCOLOR.MIX ;
		end
	end
	
	Perl_Config_ColorChange_Set_Values() ;
end


function Perl_Config_ColorChange_Set_OnOff (type)

	if type == "target" then
		if Perl_ColorChangeSaved.TARGET == 1 then
			Perl_ColorChangeSaved.TARGET = 0 ;
		else
			Perl_ColorChangeSaved.TARGET = 1 ;
		end
	end
	
	if type == "debuff" then
		if Perl_ColorChangeSaved.DEBUFF == 1 then
			Perl_ColorChangeSaved.DEBUFF = 0 ;
		else
			Perl_ColorChangeSaved.DEBUFF = 1 ;
		end
	end
	Perl_Config_ColorChange_Set_Values() ;
end


function Perl_Config_ColorChange_Set_Alpha (value)
	Perl_ColorChangeSaved.ALPHA = value / 100;
end