loothog_version = "2.7.0(Suan)"
loothog_line_height = 12
--loothog_top_height = 56
--loothog_button_height = 50
loothog_top_height = 72
loothog_button_height = 80
loothog_default_lines = 10

loothog_upperRollBoundary = 100
loothog_lowerRollBoundary = 1

loothog_countdownStarted = false
loothog_defaultNumberOfSecondsToCountDown = 5
loothog_numberOfSecondsToCountDown = 5
loothog_countdownStartTime = 0

loothog_rollStats = {} --this one should be cross session saved via the .toc - file

loothog_titanPanelActive = false --on load check if Titan Panel is present

--myAddOns
LootHogDetails = {
name = "LootHog",
version = loothog_version,
releaseDate = "",
author = "Suan (Inventor: Chompers)",
email = "",
website = "",
category = MYADDONS_CATEGORY_OTHERS,
optionsframe = "loothog_config"
};

--HelloWorldHelp = {};
--HelloWorldHelp[1] = "Help Page1 line1\nline2\nline3...";
--HelloWorldHelp[2] = "Help Page2 line1\nline2\nline3...";

function loothog_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("CHAT_MSG_SYSTEM")
	this:RegisterEvent("CHAT_MSG_SAY")
	this:RegisterEvent("CHAT_MSG_PARTY")
	this:RegisterEvent("CHAT_MSG_RAID")
	this:RegisterEvent("CHAT_MSG_RAID_LEADER")
	
	--myAddOns - Support
	if(myAddOnsFrame_Register) then
		myAddOnsFrame_Register(LootHogDetails);
	end
	
	--leave raid bug fix array
	loothog_classes = {}
		
	-- Default settings:
	loothog_settings = {}
	loothog_settings["enable"] = true
	loothog_settings["auto_show"] = true
	loothog_settings["triggered_clear"] = false
	loothog_settings["group_only"] = false
	loothog_settings["listtochat"] = false
	loothog_settings["suppress_chat"] = false
	loothog_settings["close_on_announce"] = false
	loothog_settings["finalize"] = false
	loothog_settings["ack_rolls"] = false
	loothog_settings["reject"] = true
	loothog_settings["reject_announce"] = false	
	loothog_settings["timeout"] = 60
	loothog_settings["timeout_enabled"] = false
	loothog_settings["announce_new"] = false
	loothog_settings["new_roll_text"] = LOOTHOG_LABEL_NEW_ROLL_TEXT

	
	-- Register a slash command:
	SlashCmdList["LOOTHOG"] = loothog_slash;
	SLASH_LOOTHOG1 = "/loothog";
	SLASH_LOOTHOG2 = "/lh";
	
	if (TitanPlugins) then
		loothog_titanPanelActive = true
	else
		loothog_titanPanelActive = false
	end
	
	-- Hook the function to add messages to Chat Frame 1:
	loothog_o_AddMessage = ChatFrame1.AddMessage
	ChatFrame1.AddMessage = loothog_AddMessage
	
	-- Make the options frame closable with ESC:
	table.insert(UISpecialFrames,"loothog_config");
end

function loothog_slash(cmd)
	if cmd and cmd == "statistic" then
		return loothog_printStatistics()
	end
	if cmd and cmd == "statisticReset" then
		return loothog_resetStatistics()
	end
	loothog_toggle_visible()
end

function loothog_OnEvent()
	if (event == "VARIABLES_LOADED") then
		loothog_initialize()
	end
	
	if (event == "CHAT_MSG_SYSTEM") then
		loothog_sys_msg_received()
	end
	if (event == "CHAT_MSG_" .. loothog_get_auto_channel() or event == "CHAT_MSG_RAID_LEADER") then
		loothog_chat_msg_received()
	end
end

function loothog_initialize()
	if (DEFAULT_CHAT_FRAME) then
		DEFAULT_CHAT_FRAME:AddMessage(string.format(LOOTHOG_MSG_LOAD, loothog_version))
	end
	-- Initialize session variables:
	loothog_last_roll = 0	-- The time of the most recent roll
	loothog_active = false
	loothog_hold = false
	loothog_rolls = {}
	loothog_peopleToRoll = {} --list of people in group/raid who have to roll
	
	-->Titan
	loothog_titanrolls = ""
	loothog_titannonrolls = ""
	loothog_titanwinner = ""
	loothog_titan_active = false
	loothog_titanstatus = "|cff0000ff"  .. LOOTHOG_LABEL_READY .. FONT_COLOR_CODE_CLOSE
	--<Titan
	
	loothog_interval = 10	-- Execute OnUpdate every x frames
	loothog_current_interval = 0
	loothog_player_count = 0
	loothog_players = {}
	local height = loothog_line_height * loothog_default_lines + loothog_top_height + loothog_button_height
	loothog_main:SetHeight(height)

	--Setting the width/height for the main and configuration window dependent on the needed height for each localization
	loothog_main:SetWidth(LOOTHOG_UI_MAIN_WIDTH)
	loothog_config:SetWidth(LOOTHOG_UI_CONFIG_WIDTH)
	loothog_config:SetHeight(LOOTHOG_UI_CONFIG_HEIGHT)

	loothog_language = GetDefaultLanguage("player")
	-- Set the checkboxes:
	loothog_configEnable:SetChecked(loothog_settings["enable"])
	loothog_configClear:SetChecked(loothog_settings["triggered_clear"])
	loothog_configFinalize:SetChecked(loothog_settings["finalize"])
	loothog_configAutoShow:SetChecked(loothog_settings["auto_show"])
	loothog_configGroupOnly:SetChecked(loothog_settings["group_only"])
	loothog_configSuppress:SetChecked(loothog_settings["suppress_chat"])
	loothog_configCloseOnAnnounce:SetChecked(loothog_settings["close_on_announce"])
	loothog_configAckRolls:SetChecked(loothog_settings["ack_rolls"])
	loothog_configReject:SetChecked(loothog_settings["reject"])
	loothog_configRejectAnnounce:SetChecked(loothog_settings["reject_announce"])
	loothog_configTimeoutEnabled:SetChecked(loothog_settings["timeout_enabled"])
	loothog_configTimeout:SetNumber(loothog_settings["timeout"])
	loothog_configAnnounceNew:SetChecked(loothog_settings["announce_new"])
	loothog_configAnnouncement:SetText(loothog_settings["new_roll_text"])
	
	-- Update the count text:
	loothog_update_counts()
	-- Hide the roll window:
	loothog_main:Hide()
	loothog_config:Hide()
end

function loothog_sys_msg_received()
	local msg = arg1
	local itemString = ""

	local pattern = LOOTHOG_ROLL_PATTERN

	-- Check to see if it's a /random roll:
	local player, roll, min_roll, max_roll, report, startIndex, endIndex
	if(loothog_settings["enable"]) then
		if (string.find(msg, pattern)) then
			_, _, player, roll, min_roll, max_roll = string.find(msg, pattern)
			
			--check if player who rolled is in your group or configured to count all rolls
			if (((loothog_isInGroup(player)) and (loothog_settings["group_only"])) or (not loothog_settings["group_only"])) then
				loothog_ProcessRoll(player, roll, min_roll, max_roll)
			end
		end
	end
end

function loothog_chat_msg_received()
	local msg = arg1
	local player = arg2
	if(loothog_settings["enable"]) then
		if (strlower(msg) == LOOTHOG_PASS_PATTERN) then
			loothog_ProcessRoll(player, "0", "1", "100")
		elseif ((string.find(msg, LOOTHOG_RESETONWATCH_PATTERN) or string.find(msg, LOOTHOG_RESETONWATCH_PATTERN2)) and loothog_settings["triggered_clear"]) then
			--DBM Used to be: loothog_clear()
			loothog_make_inactive()
		end
	end
end

function loothog_AddMessage(self, msg, ...)
	-- Pass along to the default handler unless it's a /random roll:
	local pattern = LOOTHOG_ROLL_PATTERN
	if (msg==nil) or (not loothog_settings["suppress_chat"]) or (not string.find(msg, pattern)) then
		loothog_o_AddMessage(self, msg, unpack(arg))
	end
end

function loothog_postInformation()
	local infoMsg = string.format(LOOTHOG_MSG_INFO, LOOTHOG_PASS_PATTERN)
	loothog_chat(infoMsg)
end

--Adds the current roll count to the internal statistic list if not present yet. If the current count is present increases the counter by 1
function loothog_updateRollStatistics(currentRoll)
	local isAlreadyInTable = false
	local indexInTable = 0
	--DEFAULT_CHAT_FRAME:AddMessage(testSTR)
	table.foreach(loothog_rollStats,
		function (k, v)
			--indexInTable = indexInTable + 1 --increase index
			if (v[1] == currentRoll) then
				loothog_rollStats[k][2] = loothog_rollStats[k][2] + 1 -- increase roll count
				isAlreadyInTable = true
				indexInTable = k
				return indexInTable
			end
		end
	)
	
	-- insert roll value to table
	if(not isAlreadyInTable) then
		local i = 1
		while (loothog_rollStats[i] ~= nil) and (loothog_rollStats[i][1] >= currentRoll) do i = i+1 end
		table.insert(loothog_rollStats, i, {currentRoll, 1})
	
	end
end

function loothog_printStatistics()
	local statString = ""
	local rollsTotal = 0
	local chanceToRollNumber = 0
	local exactChanceToRollNumber = 0
	local sumOfProbabilities = 0
	
	--gather data needed for evaluation
	for i, p in ipairs(loothog_rollStats) do
		rollsTotal = rollsTotal + p[2] --add every count of the specific value
	end
	
	for i, p in ipairs(loothog_rollStats) do
		exactChanceToRollNumber = p[2] / rollsTotal
		sumOfProbabilities = sumOfProbabilities + exactChanceToRollNumber
		chanceToRollNumber = math.ceil(exactChanceToRollNumber * 1000) / 1000
		statString = p[1] .. ": " .. p[2] .. "  Wahrscheinlichkeit:  " .. chanceToRollNumber
		DEFAULT_CHAT_FRAME:AddMessage(statString)
		--loothog_chat(statString)
	end
	
	statString = "Gesamtanzahl der W\195\188rfe: " .. rollsTotal
	DEFAULT_CHAT_FRAME:AddMessage(statString)
end

function loothog_resetStatistics()
	loothog_rollStats = {}
end

--did this for future function calls to elminate reduntant code (e.g. processSystemLootRoll(...))
function growWindow()
	-- Grow the window if needed:
	local count = table.getn(loothog_rolls)
	local count2 = table.getn(loothog_peopleToRoll)
	count = count + count2
	
	if (count > loothog_default_lines) then
		local height = loothog_line_height * count + loothog_top_height + loothog_button_height
		loothog_main:SetHeight(height)
	end
end

--checks if the unit is in the current group of the player, return always true for the local player!
function loothog_isInGroup(playerName)
	--Check if the rolling player is in your group
	local isInParty = false
	--Check if in party or raid group
	if(GetNumRaidMembers() > 0) then
		local raidMemberString = "raid"
		for i = 1, GetNumRaidMembers(), 1 do
			raidMemberString = "raid" --reset string		
			raidMemberString = raidMemberString .. i --add the suffix of corresponding player
			if (UnitName(raidMemberString) == playerName) then
				isInParty = true	
			end
		end
	elseif(GetNumPartyMembers() > 0) then
		local partyMemberString = "party"
		for i = 1, GetNumPartyMembers(), 1 do
			partyMemberString = "party" --reset string		
			partyMemberString = partyMemberString .. i --add the suffix of corresponding player
			if (UnitName(partyMemberString) == playerName) then
				isInParty = true	
			end
		end
	end
	
	if(UnitName("player") == playerName) then
		isInParty = true
	end
	
	return isInParty
end

--returns if true if the roll is valid (meets bound requirements)
function loothog_validRoll(roll, lowerBoundary, upperBoundary)
	local validRoll = false
	--(min_roll ~= 1)  or (max_roll >= 100) thus it was in the past
	if ((lowerBoundary == loothog_lowerRollBoundary)  and (upperBoundary == loothog_upperRollBoundary)) then
		--prevent possible future cheating (totally "sinnfrei" ;-)
		if(((roll <= loothog_upperRollBoundary) and (roll >= loothog_lowerRollBoundary)) or roll == 0) then
			validRoll = true
		end
	else
		validRoll = false
	end
	return validRoll
end

-- checks if the roll tied, and returns the number of winners. Returns 1 if there was NO tie
function loothog_rollTied()
	local rollTied = false;
	local num_winners = 0;
	if (table.getn(loothog_rolls) ~= 0) then
		-- Determine if there was a tie:
		local winners = {}
		local best = loothog_rolls[1][2]
		winners[1] = loothog_rolls[1][1]
		local i = 2
		local rolls = table.getn(loothog_rolls)
		while (i <= rolls) and (loothog_rolls[i][2] == best) do
			table.insert(winners, loothog_rolls[i][1])
			i = i + 1
		end
		num_winners = table.getn(winners)
		if (num_winners > 1) then
			rollTied = true
		end
	end

	return num_winners
end

function loothog_ProcessRoll(player, roll, min_roll, max_roll)
	roll = tonumber(roll)
	min_roll = tonumber(min_roll)
	max_roll = tonumber(max_roll)

	--call to update internal statistic
	loothog_updateRollStatistics(roll)
	
	-- Reject cheaters: at this position should be the new function loothog_validRoll(...)
	--if ((min_roll ~= 1)  or (max_roll > 100)) and (loothog_settings["reject"]) then
	if (not loothog_validRoll(roll, min_roll, max_roll) and (loothog_settings["reject"])) then
		local cheat_msg = string.format(LOOTHOG_MSG_CHEAT, player, roll, min_roll, max_roll)
		if (loothog_settings["reject_announce"]) then
			-- Bust the cheater if configured to announce rejects:
			loothog_chat(cheat_msg)
		else
			-- Otherwise just notify the local client:
			if (DEFAULT_CHAT_FRAME) then
				DEFAULT_CHAT_FRAME:AddMessage(cheat_msg)
			end
		end
		return
	end
	
	-- We've determined it's a valid roll.  Acknowledge if configured to do so and do it only if this is the first roll of the player:
	if (loothog_settings["ack_rolls"] and (not loothog_players[player]) and (UnitName("player") ~= player)) then
		local ack = string.format(LOOTHOG_MSG_ACK, roll)
		--send pass message to player if he did pass on this roll
		if (roll == 0) then
			ack = LOOTHOG_MSG_ACK_PASS
		end
		SendChatMessage(ack, "WHISPER", loothog_language, player)
	end
	
	if (not loothog_active) then
		-- Timeout has expired.  Consider this the first roll of a new set:
		loothog_clear()

		--setting up a list of people who are in the players group/raid and "have" to roll
		if(GetNumRaidMembers() > 0) then
			local raidMemberString = "raid"
			for i = 1, GetNumRaidMembers(), 1 do
				raidMemberString = "raid" --reset string		
				raidMemberString = raidMemberString .. i --add the suffix of corresponding player
				table.insert(loothog_peopleToRoll, (UnitName(raidMemberString)))
				loothog_classes[(UnitName(raidMemberString))] = {};
				loothog_classes[(UnitName(raidMemberString))].LocalClass, loothog_classes[UnitName(raidMemberString)].EnglishClass= UnitClass(raidMemberString);
				loothog_classes[(UnitName(raidMemberString))].UnitLevel = UnitLevel(raidMemberString);
			end
		elseif(GetNumPartyMembers() > 0) then
			local partyMemberString = "party"
			for i = 1, GetNumPartyMembers(), 1 do
				partyMemberString = "party" --reset string		
				partyMemberString = partyMemberString .. i --add the suffix of corresponding player
				table.insert(loothog_peopleToRoll, (UnitName(partyMemberString)))
				loothog_classes[(UnitName(partyMemberString))] = {};
				loothog_classes[(UnitName(partyMemberString))].LocalClass, loothog_classes[UnitName(partyMemberString)].EnglishClass= UnitClass(partyMemberString);
				loothog_classes[(UnitName(partyMemberString))].UnitLevel = UnitLevel(partyMemberString);
			end
		end
		
		--add roll to table of rolls
		-- DBM Used to be: loothog_rolls[1] = {player, roll}
		loothog_rolls[1] = {player, roll, min_roll, max_roll}
	else
		-- Insert the roll into the list at the proper spot:
		if (not loothog_players[player]) then
			local i = 1
			while (loothog_rolls[i] ~= nil) and (loothog_rolls[i][2] >= roll) do i = i+1 end
			-- DBM Used to be: table.insert(loothog_rolls, i, {player, roll})
			table.insert(loothog_rolls, i, {player, roll, min_roll, max_roll})
		end
	end
	
	-- Add to the list of players who have rolled:
	if (not loothog_players[player]) then
		loothog_player_count = loothog_player_count + 1
		loothog_players[player] = 1
		loothog_classes[player] = {};
		loothog_classes[player].LocalClass, loothog_classes[player].EnglishClass= UnitClass(loothog_getUnitIdentifier(player));
		loothog_classes[player].UnitLevel = UnitLevel(loothog_getUnitIdentifier(player));
	else
		-- Duplicate roll!
		local dupe_msg = string.format(LOOTHOG_MSG_DUPE, player)
		if (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage(dupe_msg)
		end
	end

	--remove player who rolled from the list
	for i = 1, table.getn(loothog_peopleToRoll), 1 do
		if(loothog_peopleToRoll[i] == player) then
			table.remove(loothog_peopleToRoll, i)
		end
	end
	
	-- repaint loothog window
	loothog_repaint()

	-- Auto-show the window if desired:
	if (loothog_settings["auto_show"]) then
		loothog_main:Show()
	end
end

--returns the identifier for the supplied player within raid/group (player; party1, party2,... party4; raid1, raid2, ..., raidN), nil if not in group/raid
function loothog_getUnitIdentifier (playerName)
	local identifierString = ""
		if(GetNumRaidMembers() > 0) then
			local raidMemberString = "raid"
			for i = 1, GetNumRaidMembers(), 1 do
				raidMemberString = "raid" --reset string		
				raidMemberString = raidMemberString .. i --add the suffix of corresponding player
				if (UnitName(raidMemberString) == playerName) then
					identifierString = raidMemberString
				end
			end
		elseif(GetNumPartyMembers() > 0) then
			local partyMemberString = "party"
			for i = 1, GetNumPartyMembers(), 1 do
				partyMemberString = "party" --reset string		
				partyMemberString = partyMemberString .. i --add the suffix of corresponding player
				if (UnitName(partyMemberString) == playerName) then
					identifierString = partyMemberString
				end
			end
		end
		
		--check if supplied player name is the local player
		if (UnitName("player") == playerName) then	
			identifierString = "player"
		end
		
	return identifierString
end

function loothog_announce_winner()
	-- If there are no rolls, don't do anything:
	if (table.getn(loothog_rolls) == 0) then
		return
	end

	--ACHTUNG MOMENTAN NOCH BAUSTELLE!!!
	if (loothog_settings["listtochat"]) then
		loothog_chat(LOOTHOG_LABEL_CHATLISTTOP)
		loothog_chat(LOOTHOG_LABEL_WINNERSDELIMITER)
		local roll_counter = table.getn(loothog_rolls)
		local report_roll = ""
		while (roll_counter >= 1) do
			--report_roll = ""
			if (report_roll == "") then
				report_roll = string.format(LOOTHOG_MSG_ROLLS, roll_counter, loothog_rolls[roll_counter][1], loothog_rolls[roll_counter][2])
			else
				report_roll = report_roll .. ", " ..  string.format(LOOTHOG_MSG_ROLLS, roll_counter, loothog_rolls[roll_counter][1], loothog_rolls[roll_counter][2])
			end
			--loothog_chat(report_roll)
			roll_counter = roll_counter - 1
		end
		loothog_chat(report_roll)
	end		
	
	-- Determine if there was a tie:
	local winners = {}
	local best = loothog_rolls[1][2]
	winners[1] = loothog_rolls[1][1]
	local i = 2
	local rolls = table.getn(loothog_rolls)
	while (i <= rolls) and (loothog_rolls[i][2] == best) do
		table.insert(winners, loothog_rolls[i][1])
		i = i + 1
	end
	local num_winners = table.getn(winners)
	-- Announce the winner(s) and prepare for the next set of rolls:
	local report
	if (num_winners == 1) then
		--first get group number, if master looter
		groupnum = "";
		lootmethod, masterlooter = GetLootMethod();
		if (lootmethod == "master") then
			--check all 40 raid slots for winner
			i=1;
			found = false;
			while ((i <= 40) and (found == false)) do
				name, rank, subgroup, level, class, fileName, zone, online = GetRaidRosterInfo(i);
					if (name and name == loothog_rolls[1][1]) then
						found = true;
						groupnum = " (group " .. subgroup .. ")";
					end
				i=i+1;
			end
			if (not found) then groupnum = " (group not found)"; end
		end
		
		report = string.format(LOOTHOG_MSG_WINNER, loothog_rolls[1][1], groupnum, loothog_rolls[1][2], loothog_rolls[1][3], loothog_rolls[1][4], "")
	else
		report = ""
		for i, v in ipairs(winners) do
			if (i > 1 and num_winners > 2) then report = report..", " end
			if (i == num_winners) then report = report..LOOTHOG_MSG_AND end
			report = report..v
		end
		report = report..string.format(LOOTHOG_MSG_TIED, best)
	end
	loothog_last_roll = 0
	loothog_make_inactive()
	loothog_chat(report)
	if loothog_settings["close_on_announce"] then
		loothog_main:Hide()
	end
end

function loothog_clear_clicked()
	loothog_clear()
	-- If so configured, announce the new roll:
	if (loothog_settings["announce_new"]) then
		loothog_chat(loothog_settings["new_roll_text"])
	end
end

function loothog_clear()
	-->Titan
	loothog_titanrolls = ""
	loothog_titannonrolls = ""
	loothog_titanwinner = ""
	--<Titan
	loothog_rolls = {}
	loothog_peopleToRoll = {}
	loothog_classes = {}
	loothog_players = {}
	loothog_player_count = 0
	loothog_make_inactive()
	loothog_mainText1:SetText("")
	loothog_mainText2:SetText("")
	local height = loothog_line_height * loothog_default_lines + loothog_top_height + loothog_button_height
	loothog_main:SetHeight(height)
	loothog_main:Hide()
end

function loothog_toggle_visible()
	if loothog_main:IsVisible() then
		loothog_main:Hide()
	else
		loothog_main:Show()
	end
end

function loothog_toggle_options()
	if loothog_config:IsVisible() then
		loothog_config:Hide()
	else
		loothog_config:Show()
	end
end

function loothog_toggle(setting, checked)
	loothog_settings[setting] = checked
end

function loothog_onupdate()

	loothog_current_interval = loothog_current_interval + 1
	if (loothog_current_interval >= loothog_interval) then
		loothog_current_interval = 0
		-- Update the counts:
		loothog_update_counts()
		if (loothog_active) then
			-- Update the status text:
			if (loothog_hold) then
				loothog_mainStatusText:SetTextColor(0, 1, 0)
				loothog_mainStatusText:SetText(LOOTHOG_LABEL_HOLDING)
			else
				if loothog_settings["timeout_enabled"] then
					loothog_mainStatusText:SetTextColor(1, 1, 0)
					local time_left = math.ceil(loothog_last_roll + loothog_settings["timeout"] - GetTime())
					loothog_mainStatusText:SetText(string.format(LOOTHOG_LABEL_TIMELEFT, time_left))
				else
					loothog_mainStatusText:SetTextColor(0, 1, 0)
					loothog_mainStatusText:SetText(LOOTHOG_LABEL_NOTIMEOUT)
				end
			end
			
			if(loothog_countdownStarted) then
				loothog_countdown()
			end
			
			-- See if it's time to go inactive:
			if (not loothog_hold) and (GetTime() - loothog_last_roll > loothog_settings["timeout"]) and (loothog_settings["timeout_enabled"]) then
				if(loothog_settings["finalize"])then
					loothog_announce_winner()
				end
				loothog_make_inactive()
				loothog_main:Hide()
			end
		end
	end
end

function loothog_update_counts()
	
	--set ratio number of players which have rolled/number of players in group
	local partyMemberCount = 0
	if (GetNumRaidMembers() > 0) then
		partyMemberCount = GetNumRaidMembers()
	elseif (GetNumPartyMembers() > 0) then
		partyMemberCount = GetNumPartyMembers() + 1
	end

	local titanPartyMemberCount = partyMemberCount
	
	--GetNumRaidMembers()
	--partyMemberCount = " -- [" .. table.getn(loothog_rolls) .. "/" .. partyMemberCount .. "]"
	--loothog_mainCountText:SetText(string.format(LOOTHOG_LABEL_COUNT, table.getn(loothog_rolls), loothog_player_count, partyMemberCount))
	loothog_mainCountText:SetText(string.format(LOOTHOG_LABEL_COUNT, table.getn(loothog_rolls), partyMemberCount))
	local fontcolor = RED_FONT_COLOR_CODE
	
	if (loothog_player_count < table.getn(loothog_rolls)) then
		loothog_mainCountText:SetTextColor(1, 0.3, 0.3)
	else
		loothog_mainCountText:SetTextColor(1, 1, 0)
	end
	
	-->Titan
	if(loothog_titanPanelActive) then
		local fontcolor = GREEN_FONT_COLOR_CODE
		local rolls = table.getn(loothog_rolls)
		if (rolls < titanPartyMemberCount)then
			fontcolor = RED_FONT_COLOR_CODE
		end
		if (rolls > 0) then
			local winner = loothog_rolls[1][1]
			local best = loothog_rolls[1][2]
			loothog_titanwinner = GREEN_FONT_COLOR_CODE .. winner .." ("..best.. ")" .. FONT_COLOR_CODE_CLOSE .. fontcolor .. " [" .. table.getn(loothog_rolls) .. "/" .. titanPartyMemberCount .. "]" .. FONT_COLOR_CODE_CLOSE 
		else
			loothog_titanwinner = ""
		end
	end
	--<Titan
end

function loothog_make_inactive()
	loothog_mainText1:SetTextColor(0.7, 0.7, 0.7)
	loothog_mainText2:SetTextColor(0.7, 0.7, 0.7)
	loothog_mainStatusText:SetTextColor(0.5, 0.5, 1.0)
	loothog_mainStatusText:SetText(LOOTHOG_LABEL_READY)
	loothog_active = false
	--> Titan
	loothog_titan_active = false
	loothog_titanstatus = "|cff0000ff" .. LOOTHOG_LABEL_READY .. FONT_COLOR_CODE_CLOSE 
	--< Titan
end

function loothog_holdclicked()
	if (loothog_hold) then
		loothog_hold = false
		loothog_last_roll = GetTime()
		loothog_mainHoldButton:SetText(LOOTHOG_BUTTON_HOLD)
	else
		loothog_hold = true
		loothog_mainHoldButton:SetText(LOOTHOG_BUTTON_UNHOLD)
	end
end

function loothog_AnnounceYetToRoll()
    local PeopleNeedingToRoll = "";
   	local unitIdentifier = ""	
	--print list of players which have yet to roll
	for i = 1, table.getn(loothog_peopleToRoll), 1 do
		if(i == 1) then
			PeopleNeedingToRoll = loothog_peopleToRoll[i];
		else
			unitIdentifier = loothog_getUnitIdentifier(loothog_peopleToRoll[i])
			PeopleNeedingToRoll = PeopleNeedingToRoll .. ", " .. loothog_peopleToRoll[i];
		end
	end

	if ( string.find(PeopleNeedingToRoll, '%a') ) then
	   loothog_chat(string.format(LOOTHOG_MSG_YETTOPASS, LOOTHOG_PASS_PATTERN))
	   loothog_chat(PeopleNeedingToRoll);
	end
	 
end
function loothog_rollclicked()
	-- Roll /random 100:
	RandomRoll(1, 100)
end

function loothog_countdown()
	if ((not loothog_countdownStarted) and (table.getn(loothog_rolls) > 0)) then
	--if (not loothog_countdownStarted) then
		loothog_countdownStarted = true
		loothog_countdownStartTime = GetTime()
	elseif (loothog_countdownStarted) then
		local currentTime = 0
		local elapsedTime = 0
		currentTime = GetTime()
		elapsedTime = currentTime - loothog_countdownStartTime
		if(elapsedTime >= 1) then
			loothog_countdownStartTime = GetTime()
			loothog_chat(loothog_numberOfSecondsToCountDown)
			loothog_numberOfSecondsToCountDown = loothog_numberOfSecondsToCountDown - 1
		end
		if(loothog_numberOfSecondsToCountDown == 0) then
			--announce winner at the end of the countdown
			loothog_announce_winner()
			loothog_numberOfSecondsToCountDown = loothog_defaultNumberOfSecondsToCountDown
			loothog_countdownStarted = false
		end
	end
end

function loothog_chat(msg)
	-- Send a chat message
	local channel = loothog_get_auto_channel()
	SendChatMessage(msg, channel)
end

function loothog_get_auto_channel()
	-- Return an appropriate channel in order of preference: /raid, /p, /s
	local channel = "SAY"
	if (GetNumPartyMembers() > 0) then
		channel = "PARTY"
	end
	if (GetNumRaidMembers() > 0) then
		channel = "RAID"
	end
	return channel
end

--> Titan
function loothog_getwinner()
	return loothog_titanwinner
end

function loothog_getrolls()
	return loothog_titanrolls
end

function loothog_getnonrolls()
	return loothog_titannonrolls
end

function loothog_getstatus()
	if (loothog_titanPanelActive) then
		if (loothog_hold) then
			loothog_titanstatus = RED_FONT_COLOR_CODE  .. LOOTHOG_LABEL_HOLDING .. FONT_COLOR_CODE_CLOSE
		else
			if loothog_settings["timeout_enabled"] then
				local titan_time_left = math.ceil(loothog_last_roll + loothog_settings["timeout"] - GetTime())
				loothog_titanstatus = GREEN_FONT_COLOR_CODE  .. string.format(LOOTHOG_LABEL_TIMELEFT, titan_time_left) .. FONT_COLOR_CODE_CLOSE
			else
				loothog_titanstatus = GREEN_FONT_COLOR_CODE  .. LOOTHOG_LABEL_NOTIMEOUT .. FONT_COLOR_CODE_CLOSE
			end
		end
		-- See if it's time to go inactive:
		if (not loothog_hold) and (GetTime() - loothog_last_roll > loothog_settings["timeout"]) and (loothog_settings["timeout_enabled"]) then
			loothog_make_inactive()
		end
	end

	return loothog_titanstatus
end
--<Titan

-- DBM This function should kick out the top roll if the loot leader thinks it was a joke roll, or was otherwise ineligible.  
-- It will broadcast a message explaining the kick, and will make the roller eligible to roll again if they would like.
--
-- This is needed because otherwise there is no way to remove the top roll and use the announce functionality.
-- Functionality to remove any arbitrary roll in the list would be preferred, but is infeasible given the text field structure of the LH main window.
-- 
function loothog_kickRoll()
	local player = ""
	if (table.getn(loothog_rolls) > 0) then

		player = loothog_rolls[1][1]

		--loothog_chat("LootHog: " .. player .. "'s roll of " .. loothog_rolls[1][2] .. " removed from consideration.")
		loothog_chat(string.format(LOOTHOG_MSG_REMOVEROLL, player, loothog_rolls[1][2]))
		table.remove(loothog_rolls, 1)
	
		-- Delete from rolled list
		loothog_players[player] = false
		loothog_player_count = loothog_player_count - 1
	
		--add player whose roll was kicked back onto the unrolled list
		table.insert(loothog_peopleToRoll, player)

		-- Update screen
		loothog_repaint()
	end
end

-- DBM This function re-paints the main LH window with roll results and people yet to roll, along with the Titan plug-in.
-- I extracted it from it's original location in loothog_processroll it because it is also needed by the new "loothog_kickRoll" function
function loothog_repaint()

	-- Update the list onscreen:
	local text1 = ""
	local text2 = ""
	-->Titan
	local text3 = ""
	local text4 = ""
	--<Titan
	local localClass = ""
	local unitString = ""
	local englishClass = ""
	local unitLevel = "-"
	local unitIdentifier = ""
	

	--get number of winners
	local winners_num = loothog_rollTied()
	
	--print those who have already rolled
	for i, p in ipairs(loothog_rolls) do
		if(loothog_isInGroup(p[1])) then
			localClass, englishClass = loothog_classes[p[1]].LocalClass, loothog_classes[p[1]].EnglishClass
			unitLevel = loothog_classes[p[1]].UnitLevel
			
			--check if supplied player name is the local player
			if (UnitName("player") == p[1]) then
				text1 = text1 .. "|cffff0000" .. p[1] .. "-" .. localClass .."(" .. unitLevel .. ")" .. "|r\n"
				text2 = text2 .. "|cffff0000" .. p[2] .. "|r\n"
			else
				text1 = text1 .. p[1] .. "-" .. localClass .."(" .. unitLevel .. ")" .. "\n"
				text2 = text2 .. p[2] .. "\n"
			end
			if(loothog_titanPanelActive) then
				-->Titan
				text3 = text3 .. GREEN_FONT_COLOR_CODE .. p[1] .. "-" .. localClass .."(" .. unitLevel .. ")" .. FONT_COLOR_CODE_CLOSE  .. "\t" .. GREEN_FONT_COLOR_CODE ..  p[2] .. FONT_COLOR_CODE_CLOSE .. "\n"
				--<Titan
			end
		else
			text1 = text1 .. p[1] .. "\n"
			text2 = text2 .. p[2] .. "\n"
			if(loothog_titanPanelActive) then
				-->Titan
				text3 = text3 .. GREEN_FONT_COLOR_CODE .. p[1] .. "\t" .. p[2] .. FONT_COLOR_CODE_CLOSE  .. "\n"
				--<Titan
			end
		end
		
		--printing delimiter to seperate multiple winners for visual clarity
		if((i == winners_num) and (i > 1)) then
			text1 = text1 .. LOOTHOG_LABEL_WINNERSDELIMITER .. "\n"
			text2 = text2 .. "===" .. "\n"
		end
	end
	
	--printing a delimiter
	if((table.getn(loothog_rolls) > 0) and (table.getn(loothog_peopleToRoll) > 0)) then
		text1 = text1 .. LOOTHOG_LABEL_DELIMITER .. "\n"
	end
	
	--print list of players which have yet to roll
	local unitIdentifier = ""	
	for i = 1, table.getn(loothog_peopleToRoll), 1 do
		localClass, englishClass = loothog_classes[loothog_peopleToRoll[i]].LocalClass, loothog_classes[loothog_peopleToRoll[i]].EnglishClass
		unitLevel = loothog_classes[loothog_peopleToRoll[i]].UnitLevel
		
		text1 = text1 .. loothog_peopleToRoll[i] .. "-" .. localClass .."(" .. unitLevel .. ")" .. "\n"
		if(loothog_titanPanelActive) then
			-->Titan
			text4 = text4 .. RED_FONT_COLOR_CODE .. loothog_peopleToRoll[i] .. "-" .. localClass .."(" .. unitLevel .. ")" .. FONT_COLOR_CODE_CLOSE  .. "\n"
			--<Titan
		end
	end

	loothog_mainText1:SetText(text1)
	loothog_mainText2:SetText(text2)
	loothog_update_counts()
	
	-->Titan
	loothog_titanrolls = text3
	loothog_titannonrolls = text4
	loothog_titan_active = true
	--<Titan


	-- Make the text white to indicate rolling is active:
	loothog_active = true
	loothog_mainText1:SetTextColor(1, 1, 1)
	loothog_mainText2:SetTextColor(1, 1, 1)
	
	-- Grow the window if needed:	
	growWindow()

	-- Update the last roll timestamp:
	loothog_last_roll = GetTime()

end
