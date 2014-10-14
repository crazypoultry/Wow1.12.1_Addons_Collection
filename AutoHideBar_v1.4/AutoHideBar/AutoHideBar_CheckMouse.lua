-- Check if AHB shall be shown or not 

function AutoHideBar_CheckMouse()

	if (AHB_Save.showincombat == false 
		or (AHB_Save.showincombat == true and AHB_Save.incombat == false)) then

		if (AHB_Save.command == "on") then
			AutoHideBar_Button_Template:Show();
		elseif	((AHB_Save.key == AutoHideBar_Shift and MouseIsOver(AutoHideBar_Button_Template) and IsShiftKeyDown()) or 
				 (AHB_Save.key == AutoHideBar_Shift and MouseIsOver(AutoHideBar_Button_Template) and AutoHideBar_Button_Template:IsVisible())) then
			AutoHideBar_Button_Template:Show();
		elseif 	(AHB_Save.key == AutoHideBar_Mouse and MouseIsOver(AutoHideBar_Button_Template)) then
			AutoHideBar_Button_Template:Show();
		elseif (AHB_Save.bindingkey == AutoHideBar_OwnKey and MouseIsOver(AutoHideBar_Button_Template)) then
			AutoHideBar_Button_Template:Show();
		else
			if (AutoHideBar_Settings_Template:IsVisible()) then
				AutoHideBar_Button_Template:Show();
			else
				AutoHideBar_Button_Template:Hide();	
				
				AutoHideBar_Tab(1);		
				AutoHideBar_Tab_Level(1,0,0);			
			end
		end
	else
		AutoHideBar_Button_Template:Hide();	
	end
end