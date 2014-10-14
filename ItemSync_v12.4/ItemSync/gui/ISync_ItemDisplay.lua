--[[--------------------------------------------------------------------------------
  ItemSync ItemDisplay Framework

  Author:  Derkyle
  Website: http://www.manaflux.com
-----------------------------------------------------------------------------------]]


---------------------------------------------------
-- ISync:ItemDisplay_Update()
---------------------------------------------------
function ISync:ItemDisplay_Update()

	--make sure we have the frame duh
	if(not ISync_ID_Frame) then return nil; end

	if(ISyncOpt and ISyncOpt.ItemDisplay) then
		
		--show if on
		if(ISyncOpt.ItemDisplay and ISyncOpt.ItemDisplay == 1 and not ISync_ID_Frame:IsVisible()) then
			ISync_ID_Frame:Show();
		end
		
		--hide if off
		if(ISyncOpt.ItemDisplay and ISyncOpt.ItemDisplay == 0 and ISync_ID_Frame:IsVisible()) then
			ISync_ID_Frame:Hide();
		end
		
	
	else
		--hide it if error
		if(ISync_ID_Frame) then ISync_ID_Frame:Hide(); end
		
	end

	--check for DB	
	if( not ISyncDB ) then ISync_ID_Frame:Hide(); ISyncOpt.ItemDisplay = 0; return nil; end
	if( not ISync_RealmNum) then ISync_ID_Frame:Hide(); ISyncOpt.ItemDisplay = 0; return nil; end
	if( not ISyncDB[ISync_RealmNum]) then ISync_ID_Frame:Hide(); ISyncOpt.ItemDisplay = 0; return nil; end

	if(not ISyncOpt) then ISyncOpt = { }; end
	if( not ISyncOpt.ItemCount_Valid) then ISyncOpt.ItemCount_Valid = 0; end
	if( not ISyncOpt.ItemCount_InValid) then ISyncOpt.ItemCount_InValid = 0; end
			
	--reset
	ISync_ID_Frame_Text:SetText(""); --empty current text
	
	--update the count
	ISync_ID_Frame_Text:SetText("|c0000FF00Items:|r |c00BDFCC9"..ISyncOpt.ItemCount_Valid.."|r");


end