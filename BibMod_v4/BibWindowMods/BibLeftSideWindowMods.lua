
--overridden because the default version of this function moves the buffframe
function TicketStatusFrame_OnEvent()
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		GetGMTicket();
	else
		if ( arg1 ~= 0 ) then		
			this:Show();
			refreshTime = GMTICKET_CHECK_INTERVAL;
		else
			this:Hide();
		end
	end	
end