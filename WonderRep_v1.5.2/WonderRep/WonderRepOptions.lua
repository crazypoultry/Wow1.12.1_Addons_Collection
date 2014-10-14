local WONDERREP_COLOR_DROPDOWN_LIST = {
	{ name = "Red", color = "red" },
	{ name = "Green", color = "green" },
	{ name = "Emerald", color = "emerald" },
	{ name = "Yellow", color = "yellow" },
	{ name = "Orange", color = "orange" },
	{ name = "Blue", color = "blue" },
	{ name = "Purple", color = "purple" },
	{ name = "Cyan", color = "cyan" },	
};

function WonderRepOptions_AnnounceToggle()
	if(Wr_save.AnnounceLeft) then
		Wr_save.AnnounceLeft = false;
	else
		Wr_save.AnnounceLeft = true;
	end
	WonderRepOptions_Init();
end

function WonderRepOptions_AutoBarToggle()
	if(Wr_save.ChangeBar) then
		Wr_save.ChangeBar = false;
	else
		Wr_save.ChangeBar = true;
	end
	WonderRepOptions_Init();
end

function WonderRepOptions_BarChangeToggle()
	if(Wr_save.RepChange) then
		Wr_save.RepChange = false;
	else
		Wr_save.RepChange = true;
	end
	WonderRepOptions_Init();
end

function WonderRepOptions_ChatToggle()
	if(Wr_save.frame) then
		WRep.frame = getglobal("ChatFrame2");
		Wr_save.frame = false;
	else
		WRep.frame = getglobal("ChatFrame1");
		Wr_save.frame = true;
	end
	WonderRepOptions_Init();
end

function WonderRepOptions_TimeToggle()
	if(Wr_save.ATimeLeft) then
		Wr_save.ATimeLeft = false;
	else
		Wr_save.ATimeLeft = true;
	end
	WonderRepOptions_Init();
end

function WonderRepOptions_Toggle()
	if(WonderRepOptionsFrame:IsVisible()) then
		WonderRepOptionsFrame:Hide();
		Wr_Status();
	else
		WonderRepOptions_Init();
		WonderRepOptionsFrame:Show();
	end
end

function WonderRepOptions_ResetTime()
	WRep.SessionTime = 0;
	WonderRepOptions_Init();
end

function WonderRepOptions_IntervalSlider()
	WRep.AmountGainedLevel = Wr_save.AmountGainedLevel;
end

function WonderRepOptionsColorDropDown_OnLoad()
	UIDropDownMenu_Initialize(WonderRepOptionsColorDropDown, WonderRepOptionsColorDropDown_Initialize);
	UIDropDownMenu_SetSelectedID(WonderRepOptionsColorDropDown, Wr_save.colorid);
	UIDropDownMenu_SetWidth(80);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", WonderRepOptionsColorDropDown)
end

function WonderRepOptionsColorDropDown_Initialize()
	local info;
	for i = 1, getn(WONDERREP_COLOR_DROPDOWN_LIST), 1 do
		info = { };
		info.text = WONDERREP_COLOR_DROPDOWN_LIST[i].name;
		info.func = WonderRepOptionsColorDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end


function WonderRepOptionsColorDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(WonderRepOptionsColorDropDown, Wr_save.colorid);
	if ( this:GetID() == 1 ) then
		WRep.Color.a = 1;
		WRep.Color.b = 0;
		WRep.Color.c = 0;
		WRep.Color.HEX = "ff0000";
		WRep.Color.id = 1;
		Wr_save.colorid = 1;
		Wr_save.colora = 1;
		Wr_save.colorb = 0;
		Wr_save.colorc = 0;
		Wr_save.HEX = "ff0000";	
		WRep.frame:AddMessage("WonderRep: Color Changed", WRep.Color.a, WRep.Color.b, WRep.Color.c);
	elseif ( this:GetID() == 2 ) then
		WRep.Color.a = 0;
		WRep.Color.b = 1;
		WRep.Color.c = 0;
		WRep.Color.HEX = "00ff00";
		WRep.Color.id = 2;
		Wr_save.colorid = 2;
		Wr_save.colora = 0;
		Wr_save.colorb = 1;
		Wr_save.colorc = 0;
		Wr_save.HEX = "00ff00";	
		WRep.frame:AddMessage("WonderRep: Color Changed", WRep.Color.a, WRep.Color.b, WRep.Color.c);
	elseif ( this:GetID() == 3 ) then
		WRep.Color.a = .3;
		WRep.Color.b = .8;
		WRep.Color.c = .5;
		WRep.Color.HEX = "50C878";
		WRep.Color.id = 3;
		Wr_save.colorid = 3;
		Wr_save.colora = .3;
		Wr_save.colorb = .8;
		Wr_save.colorc = .5;
		Wr_save.HEX = "50C878";
		WRep.frame:AddMessage("WonderRep: Color Changed", WRep.Color.a, WRep.Color.b, WRep.Color.c);
	elseif ( this:GetID() == 4 ) then
		WRep.Color.a = 1;
		WRep.Color.b = 1;
		WRep.Color.c = 0;
		WRep.Color.HEX = "ffff00";
		WRep.Color.id = 4;
		Wr_save.colorid = 4;
		Wr_save.colora = 1;
		Wr_save.colorb = 1;
		Wr_save.colorc = 0;
		Wr_save.HEX = "ffff00";
		WRep.frame:AddMessage("WonderRep: Color Changed", WRep.Color.a, WRep.Color.b, WRep.Color.c);
	elseif ( this:GetID() == 5 ) then
		WRep.Color.a = 1;
		WRep.Color.b = .61;
		WRep.Color.c = 0;
		WRep.Color.HEX = "FFA500";
		WRep.Color.id = 5;
		Wr_save.colorid = 5;
		Wr_save.colora = 1;
		Wr_save.colorb = .61;
		Wr_save.colorc = 0;
		Wr_save.HEX = "FFA500";
		WRep.frame:AddMessage("WonderRep: Color Changed", WRep.Color.a, WRep.Color.b, WRep.Color.c);
	elseif ( this:GetID() == 6 ) then
		WRep.Color.a = 0;
		WRep.Color.b = 0;
		WRep.Color.c = 1;
		WRep.Color.HEX = "0000ff";
		WRep.Color.id = 6;
		Wr_save.colorid = 6;			
		Wr_save.colora = 0;
		Wr_save.colorb = 0;
		Wr_save.colorc = 1;
		Wr_save.HEX = "0000ff";	
		WRep.frame:AddMessage("WonderRep: Color Changed", WRep.Color.a, WRep.Color.b, WRep.Color.c);
	elseif ( this:GetID() == 7 ) then
		WRep.Color.a = .4;
		WRep.Color.b = 0;
		WRep.Color.c = .6;
		WRep.Color.HEX = "660099";
		WRep.Color.id = 7;
		Wr_save.colorid = 7;
		Wr_save.colora = .4;
		Wr_save.colorb = 0;
		Wr_save.colorc = .6;
		Wr_save.HEX = "660099";
		WRep.frame:AddMessage("WonderRep: Color Changed", WRep.Color.a, WRep.Color.b, WRep.Color.c);
	elseif ( this:GetID() == 8 ) then
		WRep.Color.a = 0;
		WRep.Color.b = 1;
		WRep.Color.c = 1;
		WRep.Color.HEX = "00ffff";
		WRep.Color.id = 8;
		Wr_save.colorid = 8;
		Wr_save.colora = 0;
		Wr_save.colorb = 1;
		Wr_save.colorc = 1;
		Wr_save.HEX = "00ffff";
		WRep.frame:AddMessage("WonderRep: Color Changed", WRep.Color.a, WRep.Color.b, WRep.Color.c);
	end
	WonderRepOptions_Init();
end

function WonderRepOptions_OnLoad()
	UIPanelWindows['WonderRepOptionsFrame'] = {area = 'center', pushable = 0};
end

function WonderRepOptions_Init()
	WonderRepOptions_SessionTimeNumber:SetText(WonderRep_TimeText(WRep.SessionTime));
	UIDropDownMenu_SetSelectedID(WonderRepOptionsColorDropDown, Wr_save.colorid);
	WonderRepOptionsFrameAnnounce:SetChecked(Wr_save.AnnounceLeft);
	WonderRepOptionsFrameAutoBar:SetChecked(Wr_save.ChangeBar);
	WonderRepOptionsFrameBarChange:SetChecked(Wr_save.RepChange);
	WonderRepOptionsFrameChat:SetChecked(Wr_save.frame);
	WonderRepOptionsFrameCombatLog:SetChecked(not Wr_save.frame);
	WonderRepOptionsFrameTime:SetChecked(Wr_save.ATimeLeft);
	SliderInterval:SetValue(Wr_save.AmountGainedLevel);
end