-- Loads on start

function AutoHideBar_OnLoad()
this:RegisterEvent("ADDON_LOADED");
this:RegisterEvent("PLAYER_REGEN_DISABLED");
this:RegisterEvent("PLAYER_REGEN_ENABLED");

-- Settings can be close with ESC.
tinsert(UISpecialFrames,"AutoHideBar_Settings_Template");

	UIErrorsFrame:AddMessage(AutoHideBar_Welcome1, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);	
	ChatFrame1:AddMessage(AutoHideBar_Welcome2, 1.0, 1.0, 0.0, 1.0);	
		
	SLASH_AutoHideBar1 = "/ahb"; 
	SlashCmdList["AutoHideBar"] = function (msg)
		AutoHideBar_SlashHandler(msg);
	end

end

function AutoHideBar_Event(event)
 	if (event == "ADDON_LOADED") then
		AutoHideBar_Init();
		AutoHideBar_Load();
	end
		
	if (event == "PLAYER_REGEN_DISABLED") then
		AHB_Save.incombat = true;
	end
	
	if (event == "PLAYER_REGEN_ENABLED") then
		AHB_Save.incombat = false;
	end
end

function AutoHideBar_SlashHandler(msg)
	msg = string.lower(msg)
	
	if (msg =="reset") then
		AutoHideBar_Reset();
	elseif (msg == "shift") then
		AHB_Save.key = "shift";
		key_is_set_to();
	elseif (msg == "mouse") then
		AHB_Save.key = "mouse";
		key_is_set_to();
	elseif (msg == "settings" or msg == "") then
		AutoHideBar_Settings_Template:Show();
	elseif (msg == "close") then
		AutoHideBar_Settings_Template:Hide();
	elseif (msg == "reload") then
		ReloadUI();
	elseif (msg == "own") then
		AHB_Save.key = "own key";
		key_is_set_to();
	elseif (msg == "combat") then
		if (AHB_Save.showincombat == false) then
			CombatCheckButton:SetChecked(true);
			ChatFrame1:AddMessage( AutoHideBar_Combat1, 1.0, 1.0, 0.0, 1.0);	
		else
			CombatCheckButton:SetChecked(false);
			ChatFrame1:AddMessage( AutoHideBar_Combat2, 1.0, 1.0, 0.0, 1.0);				
		end
	elseif (msg == "help") then
		ChatFrame1:AddMessage(AutoHideBar_Help, 1.0, 1.0, 0.0, 1.0);	
	else
		UIErrorsFrame:AddMessage(AutoHideBar_Syntax, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
	end
end

-- Reset/load data

function AutoHideBar_Reset()
	AHB_Save = {};
	AutoHideBar_Init();
	AutoHideBar_Load();
	
	AutoHideBar_Settings_Template:ClearAllPoints();
	AutoHideBar_Settings_Template:SetPoint("CENTER","UIParent","CENTER",0,0);
	
	AutoHideBar_Button_Template:ClearAllPoints();
	AutoHideBar_Button_Template:SetPoint("CENTER","UIParent","CENTER",300,0);	
	
	AutoHideBar_Button_Template:Hide();
	AutoHideBar_Button_Template:Show();
	key_is_set_to();
end

-- Load default settings

function AutoHideBar_Load()
	AutoHideBar_Button_Template:SetScale(AHB_Save.scale);
	AutoHideBar_Scale_Bar:SetValue(AHB_Save.scale*100);

	CombatCheckButton:SetChecked(AHB_Save.showincombat);
	AutoHideBarCheckButton:SetChecked(AHB_Save.locked);
	
	AHB:SetChecked(AHB_Save.Close);
	
	AHB_buttonid:SetText(AHB_Save.buttonid[1]);
	AHB_button:SetText(1);

	AHB_Settbutton();
			
	AutoHideBar_Tab(1);
	AutoHideBar_Tab_Level(1,0,0);
	
	if (AHB_Save.bag == "HIGH") then
		AHB:SetChecked("true");
	else
		AHB:SetChecked("false");
	end
	
	AutoHideBar_Button_Template:SetFrameStrata(AHB_Save.bag);
end
