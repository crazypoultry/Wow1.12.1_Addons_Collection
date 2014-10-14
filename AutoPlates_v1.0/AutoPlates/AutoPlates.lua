-- **************************************************************************
-- * AutoPlates
-- * by evil.oz
-- *
-- * v1.0
-- *Credits:
-- *used instance names from Metamap Written by MetaHawk - aka Urshuraks
-- *************************************************************************



-- mode    
-- 1 = always toggle autoplates
-- 2 = in instances always on
-- 3 = in instances disable (must toggle manually with v as usual
-- 4 = always off

-- #########################################################################################################
-- onload handler
-- #########################################################################################################
function AutoPlates_OnLoad()

	modeDesc = {
		[1]="always toggle autoplates",
		[2]="toggle, but in instances always show nameplates",
		[3]="toggle, but leave manual control in instances",
		[4]="always off - mod disabled",
		[5]="always turn on autoplates",
	};


	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("ZONE_CHANGED");
	this:RegisterEvent("ZONE_CHANGED_INDOORS");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");

	-- add the slash commands
	SlashCmdList["APCMD"] = function(msg)
		AutoPlates_cmd(msg);
	end
	SLASH_APCMD1 = "/ap";
	SLASH_APCMD2 = "/autoplates";


	SlashCmdList["APCMDDELAY"] = function(msg)
		AutoPlates_cmddelay(msg);
	end
	SLASH_APCMDDELAY1 = "/apdelay";
	SLASH_APCMDDELAY2 = "/autoplatesdelay";

end





-- #########################################################################################################
-- occours OFTEN
-- #########################################################################################################
function AutoPlates_OnUpdate()

	if (time()-timer)>0 then
		timer=time()
		AutoPlates_Timed()
	end

end






-- #########################################################################################################
-- occours every second
-- #########################################################################################################
function AutoPlates_Timed()

	--AutoPlates_Debug("timer: " .. tostring(time()) .. " h: "..tostring(timer_hideplates));

	if (timer_hideplates>0) then
		timer_hideplates=timer_hideplates-1;
		AutoPlates_Debug("hiding plates in : " .. tostring(timer_hideplates) .. " seconds");
		if (timer_hideplates==0) then
			AutoPlates_Print("Autoplates: hiding plates");
			HideNameplates()		
		end
	end
end





-- #########################################################################################################
-- does delayed hide of the plates 
-- if AutoPlates_delay is zero then istantly
-- #########################################################################################################
function AutoPlates_HidePlates()

	if (AutoPlates_mode ~= 5) then
		if (AutoPlates_delay==0) then
			HideNameplates()
		else	
			timer_hideplates=AutoPlates_delay
			AutoPlates_Print("Autoplates: hiding plates in " .. tostring(timer_hideplates) .. " seconds");
		end
	end

end




-- #########################################################################################################
-- main event routine
-- #########################################################################################################
function AutoPlates_OnEvent(event)


	if (event == "VARIABLES_LOADED") then

		if (AutoPlates_mode == nil) then
			AutoPlates_Print("AutoPlates: cannot find AutoPlates_mode, defaulting to 2");
			AutoPlates_mode=2;
		end

		if (AutoPlates_delay == nil) then
			AutoPlates_Print("AutoPlates: cannot find AutoPlates_delay, defaulting to 30");
			AutoPlates_delay=30;
		end

		timer=time()
		timer_hideplates=0
		debug=false

		DEFAULT_CHAT_FRAME:AddMessage("AutoPlates v0.6 loaded sucessful", 1.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage(" type /ap or /autoplates for options ");
		DEFAULT_CHAT_FRAME:AddMessage(" current mode is " .. AutoPlates_mode .. " (" .. modeDesc [AutoPlates_mode] ..")")
		DEFAULT_CHAT_FRAME:AddMessage(" current delay is " .. AutoPlates_delay .. " seconds")

	end

	if (event == "ZONE_CHANGED") or (event == "ZONE_CHANGED_INDOORS") or (event == "ZONE_CHANGED_NEW_AREA") then
		if isInstance() then
			AutoPlates_Debug("Zone changed, instance");	
			AutoPlates_Message("entering instance")
		else
			AutoPlates_Debug("Zone changed, not instance");
			if (timer_hideplates == 0) then
				HideNameplates()
			end
		end

		if (AutoPlates_mode == 5) then
			ShowNameplates()			
		end

	end




	if (event == "PLAYER_ENTERING_WORLD") then
		

		if isInstance() then
			AutoPlates_Print("AutoPlates: entering world (instance)");	
		else
			AutoPlates_Print("AutoPlates: entering world (not instance)");
		end


		if ((AutoPlates_mode == 1) or (AutoPlates_mode == 3)) then
			HideNameplates()
		end

		if ((isInstance() == false) and (AutoPlates_mode == 2)) then
			HideNameplates()
		end

		if ((isInstance()) and (AutoPlates_mode == 2)) then
			AutoPlates_Print("AutoPlates: entering instance, forcing nameplates ON");
			ShowNameplates()
		end

		if (AutoPlates_mode == 5) then
			AutoPlates_Print("AutoPlates: forcing nameplates ON");
			ShowNameplates()			
		end


	end


	if (event == "PLAYER_REGEN_DISABLED") then

		--interupt already running cool-down
		timer_hideplates=0

		if (isInstance()) then
			-- we ARE in instance
			if ((AutoPlates_mode == 1) or (AutoPlates_mode == 2)) then
				AutoPlates_Print("AutoPlates: Entering combat (instance)");
				ShowNameplates()
			end
		else
			-- we are not in instance
			if (AutoPlates_mode ~= 4) then
				AutoPlates_Print("AutoPlates: Entering combat");
				ShowNameplates()
			end
		end
	end

	if (event == "PLAYER_REGEN_ENABLED") then


		if (isInstance()) then
			-- we ARE in instance
			if (AutoPlates_mode == 1) then
				AutoPlates_Print("AutoPlates: Leaving combat (instance)");
				AutoPlates_HidePlates()
			end

		else
			-- we are not in instance
			if ((AutoPlates_mode ~= 4) and (AutoPlates_mode ~= 5)) then
				AutoPlates_Print("AutoPlates: Leaving combat");
				AutoPlates_HidePlates()
			end
		end			
	end



end





-- #########################################################################################################
-- called when /ap /autoplates invoked
-- #########################################################################################################
function AutoPlates_cmd(msg)


	if (msg=="debug") then
		if debug then
			debug=false
			AutoPlates_Print("Autoplates: debug OFF")
		else
			debug=true
			AutoPlates_Print("Autoplates: debug ON")
		end
		AutoPlates_Debug("AutoPlates_mode: "..tostring(AutoPlates_mode));
		AutoPlates_Debug("timer_hideplates: "..tostring(timer_hideplates));
		AutoPlates_Debug("timer: "..tostring(timer));
	end




	if ((msg == "1") or  (msg == "2") or (msg == "3") or (msg == "4") or (msg == "5")) then
		parm=tonumber(msg)
		AutoPlates_mode=parm
		AutoPlates_Message("new mode: "  .. AutoPlates_mode .. " (" .. modeDesc [AutoPlates_mode] ..")")
		DEFAULT_CHAT_FRAME:AddMessage("autoplates: new mode is "  .. AutoPlates_mode .. " (" .. modeDesc [AutoPlates_mode] ..")")
	else
		DEFAULT_CHAT_FRAME:AddMessage("usage: /ap <mode> or /autoplates <mode>", 1.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage("   where <mode> is:", 1.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage("   1 - " .. modeDesc[1], 1.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage("   2 - " .. modeDesc[2], 1.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage("   3 - " .. modeDesc[3], 1.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage("   4 - " .. modeDesc[4], 1.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage("   5 - " .. modeDesc[5], 1.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage("   (use /apdelay or /autoplatesdelay for setting delay time)", 1.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage("   current mode is " .. AutoPlates_mode .. " (" .. modeDesc [AutoPlates_mode] ..")", 1.0, 1.0, 0.0)

	end
end





-- #########################################################################################################
-- called when /apdelay /autoplatesdelay invoked
-- #########################################################################################################
function AutoPlates_cmddelay(msg)


	if (tonumber(msg) == nil) then
		parm=-1
	else
		parm=tonumber(msg)
	end


	if ((parm > 0) and  (parm < 3000)) then
		parm=tonumber(msg)
		AutoPlates_delay=parm
		DEFAULT_CHAT_FRAME:AddMessage("new delay is: "  .. AutoPlates_delay .. " seconds")
	else
		DEFAULT_CHAT_FRAME:AddMessage("usage: /apdelay <time> or /autoplatesdelay <delay>", 1.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage("   where <delay> is delay (in seconds) to wait for plates to fade off after combat", 1.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage("   current delay is " .. AutoPlates_delay .. " seconds)", 1.0, 1.0, 0.0)
	end


end
	

-- #########################################################################################################
-- returns a boolean if we are or not in instance
-- #########################################################################################################
function isInstance()

		AutoPlates_Debug("zone=" .. GetZoneText() .. "/" .. GetRealZoneText() .. "/" .. GetSubZoneText());	

		a=false;


		for index in AP_ZoneIdentifiers do
			if (GetRealZoneText()==AP_ZoneIdentifiers[index].z) then
				AutoPlates_Debug("match found, instance")
				a=true
			end
		end
		
		return a;

end



-- #########################################################################################################
-- misc service functions
-- #########################################################################################################
function AutoPlates_Print(str)
	if(ChatFrame2) then
		ChatFrame2:AddMessage(str, 1.0, 1.0, 0.0);
	end
end

function AutoPlates_Debug(str)
	if(ChatFrame2) then
		if debug then
			ChatFrame2:AddMessage("AutoPlates: " .. str, 1.0, 0.0, 1.0);
		end
	end
end

function AutoPlates_Message(msg)
	UIErrorsFrame:AddMessage(msg, 1.0, 0, 0, 1.0, 1);
end