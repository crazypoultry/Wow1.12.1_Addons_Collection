--[[
TalentWhisper v1.2
By Carra

Addon to whisper your talent build to a player or send it to a chatchannel.
	/TalentWhisper /w [Nick] || Whispers your build to the player.
	/TalentWhisper </g | /p | /ra | /s | /bg | /o> || Puts your build in the given channel.
	/TalentWhisper /number || Sends your build to the channel number, for example: /TalentWhisper /1.
	
Added in v1.2:
	-Whisper [TalentWhisper] to a player with this mod to get his talent build (ciury's idea).
]]

--[[
TO DO:
-Check if a player exists before whispering.
]]

-- String Constants
TALENTWHISPER_LOAD="TalentWhisper by Carra loaded";
TALENTWHISPER_KEYWORD="[TalentWhisper]"; --Keyword that a player whispers to send him/her your talent-build
--\String Constants

-- Localisation
--\Localisation

--Load Script
function TalentWhisper_OnLoad()
	--Register Events
	this:RegisterEvent("CHAT_MSG_WHISPER");	--Player gets a whisper
	
	--Register Chat Commands
	SlashCmdList["TalentWhisper"] = TalentWhisper_ChatCommandHandler;
	SLASH_TalentWhisper1 = "/TalentWhisper";
	SLASH_TalentWhisper2 = "/TW";
	
	--Print Load Message
	cprint(TALENTWHISPER_LOAD);
end

--Catch the Events
function TalentWhisper_OnEvent(event)
	if(event == "CHAT_MSG_WHISPER") then
		local message = arg1;
		local player = arg2
		if(string.find(string.lower(message), string.lower(TALENTWHISPER_KEYWORD), 1, true) ~= nil) then
			print_talents(whisper, player);
			--cprint("Send Talents!");
		end--if
	end
end

--Catch the chat commands
function TalentWhisper_ChatCommandHandler(msg)
	if ( ( not msg ) or ( strlen(msg) <= 0) ) then								--No Command: Usage
		TalentWhisper_print_usage();
	else 
		--Split the arguments, taken from omni cooldown count
		local args = {};
		for word in string.gfind(msg, "[^%s]+") do
			table.insert(args, word);
		end	
		----
		
		local send = nil;	--function to use
		local to = nil;	--user/channel to send to
		
		local command = args[1];
		if(command == "/w") then
			user = args[2];		
			if(user ~= nil) then
				send = whisper;
				to = user;
			else			
				TalentWhisper_print_usage();
			end
		elseif(command == "/g") then
			send = guild;
		elseif(command == "/p") then
			send = party;
		elseif(command == "/ra") then
			send = raid;
		elseif(command == "/s") then
			send = say;
		elseif(command == "/bg") then
			send = bg;
		elseif(command == "/o") then
			send = officer;
		else
			number = args[2];
			local numberstring = string.gsub(msg, "/", "");
			if(tonumber(numberstring)) then
				to = tonumber(numberstring);
				send = channel;
			else
				print_usage();			
			end
		end
		
		if(send ~= nil) then
			print_talents(send, to);
		end
	end
end

function TalentWhisper_print_usage()
	cprint("Usage:");
	cprint("/TalentWhisper /w [Nick] || Whispers your build to the player.");	--Whisper build to player
	cprint("/TalentWhisper </g | /p | /ra | /s | /bg> || Puts your build in the given channel.");
	cprint("/TalentWhisper /number || Sends your build to the channel number, for example: /TalentWhisper /1.");
end

--Print something to the user
function cprint(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

--Send a whisper to a player
function whisper(msg, player)
	SendChatMessage(msg, "WHISPER", nil, player);
end

function guild(msg)
	SendChatMessage(msg, "GUILD");
end

--Send a message to the party channel
function party(msg)
	SendChatMessage(msg, "PARTY");
end

--Send a message to the raid channel
function raid(msg)
	SendChatMessage(msg, "RAID");
end

--Send a message to the say channel
function say(msg)
	SendChatMessage(msg, "SAY");
end

--Send a message to the guild channel
function guild(msg)
	SendChatMessage(msg, "GUILD");
end

--Send a message to the battleground channel
function bg(msg)
	SendChatMessage(msg, "BATTLEGROUND");
end

--Send a message to the channel with number "number".
function channel(msg, number)
	SendChatMessage(msg, "CHANNEL", nil, number);
end

--Send a message to the officer channel
function officer(msg)
	SendChatMessage(msg, "OFFICER");
end

--Send your talent build to the channel
--send: function-channel to use to send
--to: if you whisper, the player name | if you send to a /number channel, the number
function print_talents(send, to)
	local numTabs = GetNumTalentTabs();
	
	for t=1, numTabs do
	    local nameTab, iconTexture, pointsSpent, background = GetTalentTabInfo(t);
	    if(pointsSpent ~= 0) then --Only send if the player gots points in it
	    	if(to) then
	    		send(pointsSpent .. " points in " .. nameTab .. ":", to);
	    	else
	    		send(pointsSpent .. " points in " .. nameTab .. ":");
	    	end
	    end
	    local numTalents = GetNumTalents(t);
	    for i=1, numTalents do
	        nameTalent, icon, tier, column, currRank, maxRank= GetTalentInfo(t,i);
	        if(currRank ~= 0) then	--Only send if the player gots points in it
				if(to) then
					send("- "..nameTalent..": "..currRank.."/"..maxRank, to);
				else
					send("- "..nameTalent..": "..currRank.."/"..maxRank);
				end
			end	    	
	    end
	end
end