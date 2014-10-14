
BFC_Radio = {};

function BFC_Radio.Init()

end


function BFC_Radio.SendMessage(id)
	if(BFC_Radio.menuEntries and BFC_Radio.menuEntries[id]) then
		local area = GetMinimapZoneText();
		BFC_Comms.SendPartyMessage("<" .. area .. "> "  .. BFC_Radio.menuEntries[id]);
	else
		BFC.Log(BFC.LOG_ERROR, BFC_Strings.Errors.msgnotfound);
	end
end


function BFC_Radio.ShowGlobalMenu()
	BFC_Radio.ShowMenu(BFC_Strings.CommsMenu);
end


function BFC_Radio.SetLocalMenuItems(entries, zone)
	if(entries == nil) then
		BFC.Log(BFC.LOG_DEBUG, "nil local");
	else
		BFC.Log(BFC.LOG_DEBUG, "non-nil local");
	end
	BFC_Radio.localZone = zone;
	BFC_Radio.localMenuEntries = entries;
end


function BFC_Radio.ShowLocalMenu()
	if(not BFC_Radio.localMenuEntries) then return end -- can't show if nothing is defined
	BFC.Log(BFC.LOG_DEBUG, "showing local");
	--if(BFC_Radio.localZone and BFC_Radio.localZone == GetZoneText()) then
		BFC_Radio.ShowMenu(BFC_Radio.localMenuEntries);
	--end
end


function BFC_Radio.ShowMenu(entries)
	--if(GetNumRaidMembers() == 0 and GetNumPartyMembers() == 0) then return end -- only makes sense in a group
	
	BFC_Radio.menuEntries = entries;
	for i=1,5 do
		if(entries[i]) then
			getglobal("BFC_Radio_MenuButton" .. i):SetText(entries[i]);
			getglobal("BFC_Radio_MenuButton" .. i):Show();
		else
			getglobal("BFC_Radio_MenuButton" .. i):Hide();
		end
	end
	
	BFC_Radio_Menu:Show();
end


function BFC_Radio.HideMenu()
	for i=1,5 do
		BFC_Radio_Menu:Hide();
	end
end
