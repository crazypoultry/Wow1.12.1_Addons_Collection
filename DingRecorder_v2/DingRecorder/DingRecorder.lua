function dingrecorder_Onevent(event)

	if (event == "PLAYER_LEVEL_UP") then 

		if (arg1 ~= nil) then

			--Notify Guild if enabled. 
			GuildNotify(arg1);
			
			-- Check if we Hide Interface 
			if (HideInt == 1) then
				UIErrorsFrame:AddMessage("Level " .. arg1,1.0,0.0,1.0,1.0,1);
			 	Chronos.schedule(0.1, iface.hide)
				
				Chronos.schedule(1, TakeScreenshot)
				Chronos.schedule(2.1, iface.show)
			else
				UIErrorsFrame:AddMessage("Level " .. arg1,1.0,0.0,1.0,1.0,1);
				Chronos.schedule(1.2, TakeScreenshot)
			end
		end
	end

	
end

iface = {
	hide = function()
		CloseAllWindows()
		UIParent:Hide()
	end;

	show = function()
		UIParent:Show()
	end;
}

function EnableGuildNotify()
	guildnotify = "yes";
	DEFAULT_CHAT_FRAME:AddMessage("Dingrecorder 1.1:Guild Notify = On");
end

function DisableGuildNotify()
	guildnotify = "no";
	DEFAULT_CHAT_FRAME:AddMessage("Dingrecorder 1.1:Guild Notify = Off");
end

function GuildNotify(newlvl)
	if guildnotify == "yes" then
		SendChatMessage("Ding! - " .. newlvl, "GUILD", nil,nil);
	end
end

function DRCommand(cmd)
	DEFAULT_CHAT_FRAME:AddMessage("Command: " .. cmd);
	
	--If no command show options
	if cmd == "" then
		DEFAULT_CHAT_FRAME:AddMessage("Dingrecorder 1.1: \n -Type /dr guildnotify to enable guild notify. \n -Type /dr noguildnotify to disable guild notify.\n -Type /dr hideint to hide interface for screenshot.\n -Type /dr showint to show interface for screenshot.\n -Type /dr showconfig to Show current settings.");
	end

	if cmd == "noguildnotify" then
		DisableGuildNotify();
	end
	if cmd == "guildnotify" then
		EnableGuildNotify();
	end

	if cmd == "showint" then
		HideInt = 0;
	end

	if cmd == "hideint" then
		HideInt = 1;
	end

	-- Show configuration settings
	if cmd == "showconfig" then
		DEFAULT_CHAT_FRAME:AddMessage("Ding Recorder Options: \n-GuildNotify: " .. guildnotify);
		if (HideInt == 1) then
			DEFAULT_CHAT_FRAME:AddMessage("-Hide Interface: On");
		else
			DEFAULT_CHAT_FRAME:AddMessage("-Hide Interface: Off");
		end
	end
end
