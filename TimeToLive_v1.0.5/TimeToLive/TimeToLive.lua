TTL_VerMajor = 1;
TTL_VerMinor = 0;
TTL_VerRev = 5;
TTL_Title = "TimeToLive v" .. TTL_VerMajor .. "." .. TTL_VerMinor .. "." .. TTL_VerRev .. " (Dahlinas)";
TOTAL_DAMAGE = 0;
FIRST_DAMAGE = GetTime();
LAST_HEALTH = 100;
TTLFrameVisible = 0;

TitanTTLString = "Unknown";

function ChatPrint(msg, r, g, b, frame) 
	if ( not r ) then r=1.0; end;
	if ( not g ) then g=1.0; end;
	if ( not b ) then b=1.0; end;
	if ( frame ) then 
		frame:AddMessage(msg,r,g,b);
	else
		DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
	end
end

function TTL_OnLoad()
	ChatPrint(TTL_Title .. " Loaded!",1,1,1);
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterForDrag("LeftButton");

	SLASH_TTLSHOW1 = "/ttlshow";
	SlashCmdList["TTLSHOW"] = TTL_Show;
	SLASH_TTLHIDE1 = "/ttlhide";
	SlashCmdList["TTLHIDE"] = TTL_Hide;
end

function TTL_OnEvent(event,arg1)

	if ( event == "PLAYER_TARGET_CHANGED" ) then

		if ( not UnitExists("target") ) then
			TTL_Target:SetText("No Target");
			TTL_Text:SetText("");
			TitanTTLString = "Unknown";
		else
			TTL_Target:SetText(UnitName("target"));

			if ( UnitHealth("target") <= 0 and UnitIsConnected("target") ) then
				TTL_Text:SetText("TTL - It's Over!");
				TitanTTLString = "It's Over!";
			else
				TTL_Text:SetText("TTL - Unknow");
				TitanTTLString = "Unknown";
				TOTAL_DAMAGE = 0;
				FIRST_DAMAGE = 0;
				LAST_HEALTH = UnitHealth("target");
			end
			
		end

	elseif ( event == "UNIT_HEALTH" ) then

		if ( not UnitIsUnit("target",arg1) ) then
			return;
		end

		if ( UnitHealth("target") <= 0 and UnitIsConnected("target") ) then
			TTL_Text:SetText("TTL - It's Over!");
			TitanTTLString = "It's Over!";
			return;
		end

		local current_health = UnitHealth("target");
		local time_now = GetTime();
		TOTAL_DAMAGE = TOTAL_DAMAGE + (LAST_HEALTH - current_health);
		
		if ( FIRST_DAMAGE == 0 ) then
			FIRST_DAMAGE = time_now;
			return;
		end

		dps = TOTAL_DAMAGE / (time_now - FIRST_DAMAGE);

		if ( dps <= 0 ) then
			TTL_Text:SetText("TTL - Unknow");
			TitanTTLString = "Unknown";
			return;
		end
		
		local secstolive = floor( UnitHealth("target") / dps );
		
		local DTString = string.format("TTL - %02d:%02d secs", floor( secstolive / 60 ), mod(secstolive,60));
		TTL_Text:SetText(DTString);
		TitanTTLString = string.format("%02d:%02d secs", floor( secstolive / 60 ), mod(secstolive,60));
		LAST_HEALTH = current_health;
	elseif ((event == "ADDON_LOADED") and (arg1 == "TimeToLive")) then

		if ( TTLFrameVisible == 1) then
			TTL_Show();
		else
			TTL_Hide();
		end
	
	end

end

function TTL_Show()
	TTL_Frame:Show();
	TTLFrameVisible = 1;
end

function TTL_Hide()
	TTL_Frame:Hide();
	TTLFrameVisible = 0;
end

function TTL_OnDragStart()
	TTL_Frame:StartMoving()
end

function TTL_OnDragStop()
	TTL_Frame:StopMovingOrSizing()
end