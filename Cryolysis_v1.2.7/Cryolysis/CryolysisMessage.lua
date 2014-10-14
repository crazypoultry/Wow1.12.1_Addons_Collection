------------------------------------------------------------------------------------------------------
-- Cryolysis
--
-- Based on Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
-- Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Cryolysis Maintainer : Kaeldra of Aegwynn
--
-- Contact : darklyte@gmail.com
-- Send me in-game mail!  Yersinia on Aegwynn, Horde side.
-- Guild: <Working as Intended>
-- Version Date: 07.14.2006
------------------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------
-- POSTING FUNCTIONS (CONSOLE, CHAT, MESSAGE SYSTEM) 
------------------------------------------------------------------------------------------------------

function Cryolysis_Msg(msg, type)
	if (msg and type) then
		-- If the message type is "USER" then the message is displayed
		if (type == "USER") then
			-- Colorize the message
			msg = Cryolysis_MsgAddColor(msg);
			local Intro = "|C2D47E7EECr|C2B7EECEEyo|C2AA2EFEEly|C28C6F4EEsis|CFFFFFFFF: ";
			if CryolysisConfig.ChatType then
				-- ...... On the first chat window
				ChatFrame1:AddMessage(Intro..msg, 0.2, 0.9, 0.95, 1.0, UIERRORS_HOLD_TIME);
			else
				-- ...... or in the middle of the screen
				UIErrorsFrame:AddMessage(Intro..msg, 0.2, 0.9, 0.95, 1.0, UIERRORS_HOLD_TIME);
			end
		-- If the type of the message is “WORLD”, the message will be sent in raid, failing this in group, and failing this in local chat
		elseif (type == "WORLD") then
			if (GetNumRaidMembers() > 0) then
				SendChatMessage(msg, "RAID");
			elseif (GetNumPartyMembers() > 0) then
				SendChatMessage(msg, "PARTY");
			else
				SendChatMessage(msg, "SAY");
			end
		elseif (type == "GROUP") then
			if (GetNumRaidMembers() > 0) then
				SendChatMessage(msg, "RAID");
			elseif (GetNumPartyMembers() > 0) then
				SendChatMessage(msg, "PARTY");
			end
		-- If the message type is "PARTY", then display to group
		elseif (type == "PARTY") then
			SendChatMessage(msg, "PARTY");
		-- If the message type is "PARTY", then display to raid
		elseif (type == "RAID") then
			SendChatMessage(msg, "RAID");
		elseif (type == "SAY") then
		-- Otherwise send to local chat
			SendChatMessage(msg, "SAY");
		end
	end
end


------------------------------------------------------------------------------------------------------
-- ... COLORIZATION!
------------------------------------------------------------------------------------------------------

-- Define Colors easily
function Cryolysis_MsgAddColor(msg)
	msg = string.gsub(msg, "<white>", "|CFFFFFFFF");
	msg = string.gsub(msg, "<lightBlue>", "|CFF99CCFF");
	msg = string.gsub(msg, "<brightGreen>", "|CFF00FF00");
	msg = string.gsub(msg, "<lightGreen2>", "|CFF66FF66");
	msg = string.gsub(msg, "<lightGreen1>", "|CFF99FF66");
	msg = string.gsub(msg, "<yellowGreen>", "|CFFCCFF66");
	msg = string.gsub(msg, "<lightYellow>", "|CFFFFFF66");
	msg = string.gsub(msg, "<darkYellow>", "|CFFFFCC00");
	msg = string.gsub(msg, "<lightOrange>", "|CFFFFCC66");
	msg = string.gsub(msg, "<dirtyOrange>", "|CFFFF9933");
	msg = string.gsub(msg, "<darkOrange>", "|CFFFF6600");
	msg = string.gsub(msg, "<redOrange>", "|CFFFF3300");
	msg = string.gsub(msg, "<red>", "|CFFFF0000");
	msg = string.gsub(msg, "<lightRed>", "|CFFFF5555");
	msg = string.gsub(msg, "<lightPurple1>", "|CFFFFC4FF");
	msg = string.gsub(msg, "<lightPurple2>", "|CFFFF99FF");
	msg = string.gsub(msg, "<purple>", "|CFFFF50FF");
	msg = string.gsub(msg, "<darkPurple1>", "|CFFFF00FF");
	msg = string.gsub(msg, "<darkPurple2>", "|CFFB700B7");
	msg = string.gsub(msg, "<close>", "|r");
	msg = string.gsub(msg, "<darkBlue>", "|C2D59E9FF");
	return msg;
end

--[[
function Cryolysis_MsgAddColor(msg)
	msg = string.gsub(msg, "<white>", "|CFFFFFFFF");
	msg = string.gsub(msg, "<lightBlue>", "|CFF99CCFF");
	msg = string.gsub(msg, "<brightGreen>", "|C2D47E7FF");
	msg = string.gsub(msg, "<lightGreen2>", "|C2D59E9FF");
	msg = string.gsub(msg, "<lightGreen1>", "|C2C6BEBFF");
	msg = string.gsub(msg, "<yellowGreen>", "|C2B7EECFF");
	msg = string.gsub(msg, "<lightYellow>", "|C2A90EEFF");
	msg = string.gsub(msg, "<darkYellow>", "|C2AA2EFFF");
	msg = string.gsub(msg, "<lightOrange>", "|CFFFFCC66");
	msg = string.gsub(msg, "<dirtyOrange>", "|C29B5F2FF");
	msg = string.gsub(msg, "<darkOrange>", "|C28C6F4FF");
	msg = string.gsub(msg, "<redOrange>", "|C28D8F5FF");
	msg = string.gsub(msg, "<red>", "|C26FBF8FF");
	msg = string.gsub(msg, "<lightRed>", "|CFFFF5555");
	msg = string.gsub(msg, "<lightPurple1>", "|CFFFFC4FF");
	msg = string.gsub(msg, "<lightPurple2>", "|CFFFF99FF");
	msg = string.gsub(msg, "<purple>", "|CFFFF50FF");
	msg = string.gsub(msg, "<darkPurple1>", "|CFFFF00FF");
	msg = string.gsub(msg, "<darkPurple2>", "|CFFB700B7");
	msg = string.gsub(msg, "<close>", "|r");
	return msg;
end
]]--

-- Insert in the timers of the codes of colouring according to the percentage of remaining time
function CryolysisTimerColor(percent)
	local color = "<brightGreen>";   -- |C2D47E7FF
	if (percent < 10) then
		color = "<red>";             -- |C26FBF8FF
	elseif (percent < 20) then
		color = "<redOrange>";       -- |C28D8F5FF
	elseif (percent < 30) then
		color = "<darkOrange>";      -- |C28C6F4FF      350
	elseif (percent < 40) then
		color = "<dirtyOrange>";     -- |C29B5F2FF       300
	elseif (percent < 50) then
		color = "<darkYellow>";      -- |C2AA2EFFF
	elseif (percent < 60) then
		color = "<lightYellow>";     -- |C2A90EEFF
	elseif (percent < 70) then
		color = "<yellowGreen>";     -- |C2B7EECFF
	elseif (percent < 80) then
		color = "<lightGreen1>";     -- |C2C6BEBFF
	elseif (percent < 90) then
		color = "<lightGreen2>";     -- |C2D59E9FF
	end
	return color;
end

------------------------------------------------------------------------------------------------------
-- USER-FRIENDLY VARIABLES WHEN DISPLAYING CHAT
------------------------------------------------------------------------------------------------------

function Cryolysis_MsgReplace(msg, target, portal, mount)
	msg = string.gsub(msg, "<player>", UnitName("player"));
	if target then
		msg = string.gsub(msg, "<target>", target);
	end
	if portal then
		msg = string.gsub(msg, "<portal>", portal);
	end
	if mount then
		msg = string.gsub(msg, "<mount>", mount);
	end
	return msg;
end
