function TalentReminder_OnLoad()

	-- Register for Events
	this:RegisterEvent("VARIABLES_LOADED");
	
	-- Define Chat Commands
	SlashCmdList["TALENTS"] = TalentReminder_ChatCommandHandler;
	SLASH_TALENTS1 = "/talentreminder";

	-- Define Variables

	-- If TalentInterval was not previously defined...
	if (TalentInterval == nil) then
		-- Set it for five minutes.
		TalentInterval = 300;
	end

	-- Set the initial start time as the time that the AddOn was loaded.
	TalentStartTime = ceil(GetTime());
	
end

-- ***************************************

function TalentReminder_ChatCommandHandler(message)

	-- Check for both a command and a value.
	message = string.lower(message);
	local firsti, lasti, command, value = string.find(message, "(%w+) ([_%w]+)"); 
	
	-- If the player enters "/talentreminder interval" then...
	if (command == "interval") then
		-- If the value is blank...
		if (value == nil) then
			-- Display command usage for this AddOn.
			TalentDisplayUsage();
		else
			-- Convert the time from minutes to seconds, then store it in the variable.
			TalentInterval = value * 60;
			ChatMessage("TalentReminder has been configured to remind you every " .. value .. " minutes of unspent talent points.");
		end
	else
		-- Display command usage for this AddOn.
		TalentDisplayUsage();
	end

end

-- ***************************************

function TalentDisplayUsage()
	-- Display command usage for this AddOn.
	ChatMessage("To use Kortalh's TalentReminder, type '/talentreminder interval <value>'. Where <value> is the time between messages, in minutes.");	
end

-- ***************************************

function TalentReminder_OnEvent(event)


	if (event == "VARIABLES_LOADED") then
		
		ChatMessage("Kortalh's TalentReminder v1.0 Loaded.");

	end

end

-- ***************************************

function TalentReminder_OnUpdate()

	-- Fetch the number of talent points the player has,
	---- and store them in the TPNumber variable.
	TalentPointNumber = UnitCharacterPoints("player");
	-- If the character has one or more talent points and...
	if (TalentPointNumber > 0) then
		-- If the current time is later than the start time plus a user-defined interval...
		if ((TalentStartTime + TalentInterval) < ceil(GetTime())) then
			-- Display the alert message above the player's head and...
			AlertMessage("You have " .. TalentPointNumber .. " talent points available!");
			-- Play a warning sound, then...
			PlaySound("igQuestFailed");
			-- Reset the start time.
			TalentStartTime = ceil(GetTime());
		end
	end
	
end

-- ***************************************

function ChatMessage(message)

	-- Prints the specified message to the chat window.
	DEFAULT_CHAT_FRAME:AddMessage(message);

end

-- ***************************************

function AlertMessage(message)

	-- Prints the specified message to the overhead float area in red.
	UIErrorsFrame:AddMessage(message, 1.0, 0.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
	
end