function SB_InitSlider(slider)
    local sl = getglobal(slider)
	sl.tooltipText = "Adjust the alert frame vertical offset"
	getglobal(slider .. "Low"):SetText("-300")
	getglobal(slider .. "High"):SetText("300")
	getglobal(slider .. "Text"):SetText("Alert frame Offset - ")
end

function SB_SliderValue(value)
    SBVAR["SliderValue"] = value
end

function SB_ChangeColor()
	local r,g,b = ColorPickerFrame:GetColorRGB()
	SBBG1_ColorArea:SetTexture(r, g, b)
    SBVAR["MCR"] = r
    SBVAR["MCG"] = g
    SBVAR["MCB"] = b
end

function SB_ColorSet()
    r = SBVAR["MCR"]
    g = SBVAR["MCG"]
    b = SBVAR["MCB"]
	SBBG1_ColorArea:SetTexture(r, g, b)
end

function SB_RadioShowCheck()
	SBBG1_RadioButton1:SetChecked(nil);
	SBBG1_RadioButton2:SetChecked(nil);
	SBBG1_RadioButton3:SetChecked(nil);
	SBBG1_RadioButton4:SetChecked(nil); 
	if SBVAR["WeaponBuff"]==1 then SBBG1_RadioButton1:SetChecked(1); end
	if SBVAR["WeaponBuff"]==2 then SBBG1_RadioButton2:SetChecked(1); end
	if SBVAR["WeaponBuff"]==3 then SBBG1_RadioButton3:SetChecked(1); end
	if SBVAR["WeaponBuff"]==4 then SBBG1_RadioButton4:SetChecked(1); end
	if SBVAR["ListOrder"]==1 then SBBG1_RadioButton5:SetChecked(1); end
	if SBVAR["ListOrder"]==2 then SBBG1_RadioButton6:SetChecked(1); end
end

function SB_ListCheck()
	if (SBBG1_RadioButton5:GetChecked()) then
		SBVAR["ListOrder"] = 1;
	elseif (SBBG1_RadioButton6:GetChecked()) then
		SBVAR["ListOrder"] = 2;
	end
end

function SB_WeaponXMLCheck()
	if (SBBG1_RadioButton1:GetChecked()) then
		SBVAR["WeaponBuff"] = 1;
	elseif (SBBG1_RadioButton2:GetChecked()) then
		SBVAR["WeaponBuff"] = 2;
	elseif (SBBG1_RadioButton3:GetChecked()) then
		SBVAR["WeaponBuff"] = 3;
	elseif (SBBG1_RadioButton4:GetChecked()) then
		SBVAR["WeaponBuff"] = 4;
	end
end

function SB_FrameToggle()
	local frame = getglobal("SBBG1");
		if (frame) then
			if frame:IsVisible() then
				frame:Hide();
			else
				frame:Show();
			end
		end
end

function SB_ManaSet()
	if (SBBG1_InputBox:GetText()) then
		SBVAR["minmana"] = tonumber(SBBG1_InputBox:GetText());
	end
end

function SB_HealthSet()
	if (SBBG1_InputBox2:GetText()) then
		SBVAR["minhealth"] = tonumber(SBBG1_InputBox2:GetText());
	end
end

function SB_NSHealthSet()
	if (SBBG1_InputBox4:GetText()) then
		SBVAR["NSHealValue"] = tonumber(SBBG1_InputBox4:GetText());
	end
end

function SB_BezerkHealthSet()
	if (SBBG1_InputBox5:GetText()) then
		SBVAR["BezerkHealValue"] = tonumber(SBBG1_InputBox5:GetText());
	end
end

function SB_CheckBoxCheck1()
	if SBVAR["LSMessage"] == 0 then SBVAR["LSMessage"] = 1
	else SBVAR["LSMessage"] = 0 end
end

function SB_CheckBoxCheck2()
	if SBVAR["WepMessage"] == 0 then SBVAR["WepMessage"] = 1
	else SBVAR["WepMessage"] = 0 end
end

function SB_CheckBoxCheck3()
	if SBVAR["DebuffMsg"] == 0 then SBVAR["DebuffMsg"] = 1
	else SBVAR["DebuffMsg"] = 0 end
end

function SB_CheckBoxCheck4()
	if SBVAR["NSMsg"] == 0 then SBVAR["NSMsg"] = 1
	else SBVAR["NSMsg"] = 0 end
end

function SB_CheckBoxCheck5()
	if SBVAR["BeserkMsg"] == 0 then SBVAR["BeserkMsg"] = 1
	else SBVAR["BeserkMsg"] = 0 end
end

function SB_CheckBoxCheck6()
	if SBVAR["PlaySounds"] == 0 then SBVAR["PlaySounds"] = 1
	else SBVAR["PlaySounds"] = 0 end
end

function SB_CheckBoxCheck7()
	if SBVAR["HealthThreshold"] == 0 then SBVAR["HealthThreshold"] = 1
	else SBVAR["HealthThreshold"] = 0 end
end

function SB_CheckBoxCheck8()
	if SBVAR["City"] == 0 then SBVAR["City"] = 1
	else SBVAR["City"] = 0 end
end

function SB_CheckBoxCheck10()
	if SBVAR["AutoLSCast"] == 0 then SBVAR["AutoLSCast"] = 1
    else SBVAR["AutoLSCast"] = 0 end
end

function SB_CheckBoxCheck11()
	if SBVAR["WeaponBuffTog"] == 0 then SBVAR["WeaponBuffTog"] = 1
	else SBVAR["WeaponBuffTog"] = 0 end
end

function SB_CheckBoxCheck12()
    if SBVAR["DebuffToggle"] == 0 then SBVAR["DebuffToggle"] = 1
    else SBVAR["DebuffToggle"] = 0 end
end

function SB_CheckBoxCheck13()
	if SBVAR["NSHeal"] == 0 then SBVAR["NSHeal"] = 1
	else SBVAR["NSHeal"] = 0 end
end

function SB_CheckBoxCheck14()
	if SBVAR["TrollBezerk"] == 0 then SBVAR["TrollBezerk"] = 1
	else SBVAR["TrollBezerk"] = 0 end
end

function SB_CheckBoxCheck21()
	if SBVAR["LazyAssNamsar"] == 0 then SBVAR["LazyAssNamsar"] = 1
	else SBVAR["LazyAssNamsar"] = 0 end
end

function SB_SaveButton()
	if (SBBG1_InputBox1:GetText()) then
		SBVAR["minmana"] = tonumber(SBBG1_InputBox1:GetText());
	end
	if (SBBG1_InputBox2:GetText()) then
		SBVAR["minhealth"] = tonumber(SBBG1_InputBox2:GetText());
	end
	if (SBBG1_InputBox4:GetText()) then
		SBVAR["NSHealValue"] = tonumber(SBBG1_InputBox4:GetText());
	end
	if (SBBG1_InputBox5:GetText()) then
		SBVAR["BezerkHealValue"] = tonumber(SBBG1_InputBox5:GetText());
	end
	local frame = getglobal("SBBG1");
	if (frame) then
		if frame:IsVisible() then
			frame:Hide();
		else
			frame:Show();
		end
	end
end