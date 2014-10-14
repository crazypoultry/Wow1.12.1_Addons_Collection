-- Templates templates

function AutoHideBar_DragStart(frame)
	if (not AHB_Save.locked) then
		frame:StartMoving();
	end
end
	
function AutoHideBar_DragStop(frame)
	frame:StopMovingOrSizing();
end

-- check witch settings to be shown

function AutoHideBar_Tab(index)
	local index1 = this:GetID();

	if (index1 == 1 or index == 1) then
		getglobal("AutoHideBar_Scale_Bar"):Show();
		getglobal("AHB_button"):Hide();
		getglobal("AHB_buttonid"):Hide();
	elseif (index1 == 2 or index == 2) then
		getglobal("AutoHideBar_Scale_Bar"):Hide();
		getglobal("AHB_button"):Show();
		getglobal("AHB_buttonid"):Show();
	end
end

function AutoHideBar_Tab_Level(a,b,c)	
	myTabbedWindowFrameTab1:SetFrameLevel(a);
	myTabbedWindowFrameTab2:SetFrameLevel(b);
	AutoHideBar_Settings_Template:SetFrameLevel(c);
end

-- Bindings

function AutoHideBar_Binding_show()
	if (keystate == "down") then	
		if (AutoHideBar_Settings_Template:IsVisible()) then
			AutoHideBar_Settings_Template:Hide();
		else
			AutoHideBar_Settings_Template:Show();
		end
	end
end

function AutoHideBar_key_binding(id)
	if(keystate=="down") then
		local button = getglobal("AutoHideBarButton"..id);
		UseAction(button:GetID(), 0, onSelf);
	end
end

function AutoHideBar_showkey()
	if (keystate == "down") then
		AHB_Save.bindingkey = AutoHideBar_OwnKey;
	else	
		if (not AutoHideBar_Button_Template:IsVisible()) then
			AHB_Save.bindingkey = "none";
		end
	end
end

function AutoHideBar_openhide()
	if (keystate == "down") then
		if (not AutoHideBar_Button_Template:IsVisible()) then
			AHB_Save.command = "on"
		else
			AHB_Save.command = "off"
		end
	end
end

function AutoHideBar_SetBindingText()
	for i = 1, 20, 1 do
	
		local key1, key2 = GetBindingKey(format("AUTOHIDEBARBUTTON"..i));
			
		key1 = tostring(key1); 	
			
		key1 = string.gsub(key1,"ALT","a");
		key1 = string.gsub(key1,"CTRL","c");
		key1 = string.gsub(key1,"SHIFT","s");
		
		key1 = string.gsub(key1, "nil", "");
		
		local Button = format("Text_Button"..i);
		
		if (key1) then
			getglobal(Button):SetText(key1);
		end
		getglobal(Button):SetTextColor(1,1,1);
	end
end