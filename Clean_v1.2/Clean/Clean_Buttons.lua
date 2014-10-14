function Clean_Button_Click()

-- This function wetch the ID from the checkboxes

local ID = this:GetID();
	
	if (getglobal("CleanButton" .. ID):GetChecked()) then
		C.Frame[ID] = true;
	else
		C.Frame[ID] = false;
	end
	
	--ChatFrame1:AddMessage(format("CleanButton" .. ID .. " is set to " .. tostring(C.Frame[ID])), 1.0, 1.0, 0.0, 1.0);	
end