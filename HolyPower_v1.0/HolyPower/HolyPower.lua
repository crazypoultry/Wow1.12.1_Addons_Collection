local whispervalue = 0;
local frameshown = 1;

function HolyPower_OnLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
end

function HolyPower_OnEvent()
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		this:UnregisterEvent("PLAYER_ENTERING_WORLD")
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS")
		this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS")
		SLASH_HolyPower1 = "/holy";
		SlashCmdList["HolyPower"] = HolyPower_SlashHandler;
		DEFAULT_CHAT_FRAME:AddMessage("Holy Power Watch Loaded");
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" ) then
		if ( arg1 == "You gain Holy Power." ) then
			UIErrorsFrame:AddMessage("Holy Power!",1,0.87,0.40,1,2);
--			PlaySoundFile("Interface\\AddOns\\HolyPower\\yoursoundfile.wav");
		end
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS" ) then
		local combatstring = arg1;
		if ( string.find(combatstring, "Holy Power") ) then
			local nameofchar = string.sub(combatstring, 1, string.find(combatstring, "%s")-1);
			UIErrorsFrame:AddMessage("Holy Power on "..nameofchar,0.93,0.76,0,1,2);
--			PlaySoundFile("Interface\\AddOns\\HolyPower\\yoursoundfile.wav");
			if ( whispervalue == 1 ) then
				SendChatMessage("You got Holy Power!", "WHISPER", GetDefaultLanguage("player"), nameofchar);
			end
		end
	end
end


function HolyPower_SlashHandler(msg)
	
	local command = string.lower(msg);
	if ( command == "" ) then
		if ( frameshown == 0 ) then
				DEFAULT_CHAT_FRAME:AddMessage("Addon OFF");
		elseif ( frameshown == 1 ) then
			if ( whispervalue == 1 ) then
				DEFAULT_CHAT_FRAME:AddMessage("Addon ON, Whispers ON");	
			elseif ( whispervalue == 0 ) then
				DEFAULT_CHAT_FRAME:AddMessage("Addon ON, Whispers OFF");	
			end
		end		
        elseif ( command == "on" ) then
             if ( frameshown == 1 ) then
               DEFAULT_CHAT_FRAME:AddMessage("HolyPower already enabled.");
             else
             	frameshown = 1;
                HolyPowerFrame:Show();
                DEFAULT_CHAT_FRAME:AddMessage("HolyPower enabled.");
             end
	elseif ( command == "off" ) then
	     if ( frameshown == 0 ) then
	        DEFAULT_CHAT_FRAME:AddMessage("HolyPower already disabled.");
	     else
		frameshown = 0;
		HolyPowerFrame:Hide();
		DEFAULT_CHAT_FRAME:AddMessage("HolyPower disabled.");
             end
	elseif ( command == "whispers" ) then
		if ( frameshown == 0 ) then
			if ( whispervalue == 0 ) then
				whispervalue = 1;
               			DEFAULT_CHAT_FRAME:AddMessage("Whispers enabled. Addon still off.");	
			elseif ( whispervalue == 1 ) then
				whispervalue = 0;
               			DEFAULT_CHAT_FRAME:AddMessage("Whispers disabled. Addon still off.");	
               		else 
               			DEFAULT_CHAT_FRAME:AddMessage("Exception!");
			end							
		elseif ( frameshown == 1 ) then
			if ( whispervalue == 0 ) then
				whispervalue = 1;
               			DEFAULT_CHAT_FRAME:AddMessage("Whispers enabled.");	
			elseif ( whispervalue == 1 ) then
				whispervalue = 0;
               			DEFAULT_CHAT_FRAME:AddMessage("Whispers disabled.");	
               		else 
               			DEFAULT_CHAT_FRAME:AddMessage("Exception!");
               			DEFAULT_CHAT_FRAME:AddMessage("Current value: "..whispervalue);	
			end
		end					
        else
		DEFAULT_CHAT_FRAME:AddMessage("Valid commands are /holy, /holy on, /holy off, and /holy whispers");
	end
end