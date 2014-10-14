
ProcWatcher = {

"--",0,0,0;	-- name,count,crits,highest
"--",0,0,0;
"--",0,0,0;
"--",0,0,0;
"--",0,0,0;
"--",0,0,0;
"--",0,0,0;
"--",0,0,0;
"--",0,0,0;
"--",0,0,0;

};

------------------------------------------------------------------------

function ProcWatcher_OnLoad()

        this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF");
	ProcWatcherFrame:RegisterForDrag("LeftButton");

	SLASH_PROCWATCHER1 = "/pw";
	SlashCmdList["PROCWATCHER"] = ProcWatcher_SlashCommandHandler;
end

------------------------------------------------------------------------

function ProcWatcher_ResetVars()

ProcWatcher = {

"--",0,0,0;
"--",0,0,0;
"--",0,0,0;
"--",0,0,0;
"--",0,0,0;
"--",0,0,0;
"--",0,0,0;
"--",0,0,0;
"--",0,0,0;
"--",0,0,0;

};

ProcWatcher_UpdateFrame();

end

------------------------------------------------------------------------

function ProcWatcher_UpdateFrame()

-- +0 name
-- +1 count
-- +2 crits
-- +3 highest

	if (ProcWatcher[1+1] == 0) then
	ProcWatcherText_Action1Chance:SetText("0%");
	else
	ProcWatcherText_Action1Chance:SetText(ceil(ProcWatcher[1+2]/ProcWatcher[1+1]*100) .. "%");
	end
	ProcWatcherText_Action1Name:SetText(ProcWatcher[1+0]);
	ProcWatcherText_Action1Count:SetText(ProcWatcher[1+1] .. "/" .. ProcWatcher[1+2]);
	ProcWatcherText_Action1Highest:SetText(ProcWatcher[1+3]);


	if (ProcWatcher[5+1] == 0) then
	ProcWatcherText_Action2Chance:SetText("0%");
	else
	ProcWatcherText_Action2Chance:SetText(ceil(ProcWatcher[5+2]/ProcWatcher[5+1]*100) .. "%");
	end
	ProcWatcherText_Action2Name:SetText(ProcWatcher[5+0]);
	ProcWatcherText_Action2Count:SetText(ProcWatcher[5+1] .. "/" .. ProcWatcher[5+2]);
	ProcWatcherText_Action2Highest:SetText(ProcWatcher[5+3]);


	if (ProcWatcher[9+1] == 0) then
	ProcWatcherText_Action3Chance:SetText("0%");
	else
	ProcWatcherText_Action3Chance:SetText(ceil(ProcWatcher[9+2]/ProcWatcher[9+1]*100) .. "%");
	end
	ProcWatcherText_Action3Name:SetText(ProcWatcher[9+0]);
	ProcWatcherText_Action3Count:SetText(ProcWatcher[9+1] .. "/" .. ProcWatcher[9+2]);
	ProcWatcherText_Action3Highest:SetText(ProcWatcher[9+3]);


	if (ProcWatcher[13+1] == 0) then
	ProcWatcherText_Action4Chance:SetText("0%");
	else
	ProcWatcherText_Action4Chance:SetText(ceil(ProcWatcher[13+2]/ProcWatcher[13+1]*100) .. "%");
	end
	ProcWatcherText_Action4Name:SetText(ProcWatcher[13+0]);
	ProcWatcherText_Action4Count:SetText(ProcWatcher[13+1] .. "/" .. ProcWatcher[13+2]);
	ProcWatcherText_Action4Highest:SetText(ProcWatcher[13+3]);


	if (ProcWatcher[17+1] == 0) then
	ProcWatcherText_Action5Chance:SetText("0%");
	else
	ProcWatcherText_Action5Chance:SetText(ceil(ProcWatcher[17+2]/ProcWatcher[17+1]*100) .. "%");
	end
	ProcWatcherText_Action5Name:SetText(ProcWatcher[17+0]);
	ProcWatcherText_Action5Count:SetText(ProcWatcher[17+1] .. "/" .. ProcWatcher[17+2]);
	ProcWatcherText_Action5Highest:SetText(ProcWatcher[17+3]);


	if (ProcWatcher[21+1] == 0) then
	ProcWatcherText_Action6Chance:SetText("0%");
	else
	ProcWatcherText_Action6Chance:SetText(ceil(ProcWatcher[21+2]/ProcWatcher[21+1]*100) .. "%");
	end
	ProcWatcherText_Action6Name:SetText(ProcWatcher[21+0]);
	ProcWatcherText_Action6Count:SetText(ProcWatcher[21+1] .. "/" .. ProcWatcher[21+2]);
	ProcWatcherText_Action6Highest:SetText(ProcWatcher[21+3]);


	if (ProcWatcher[25+1] == 0) then
	ProcWatcherText_Action7Chance:SetText("0%");
	else
	ProcWatcherText_Action7Chance:SetText(ceil(ProcWatcher[25+2]/ProcWatcher[25+1]*100) .. "%");
	end
	ProcWatcherText_Action7Name:SetText(ProcWatcher[25+0]);
	ProcWatcherText_Action7Count:SetText(ProcWatcher[25+1] .. "/" .. ProcWatcher[25+2]);
	ProcWatcherText_Action7Highest:SetText(ProcWatcher[25+3]);


	if (ProcWatcher[29+1] == 0) then
	ProcWatcherText_Action8Chance:SetText("0%");
	else
	ProcWatcherText_Action8Chance:SetText(ceil(ProcWatcher[29+2]/ProcWatcher[29+1]*100) .. "%");
	end
	ProcWatcherText_Action8Name:SetText(ProcWatcher[29+0]);
	ProcWatcherText_Action8Count:SetText(ProcWatcher[29+1] .. "/" .. ProcWatcher[29+2]);
	ProcWatcherText_Action8Highest:SetText(ProcWatcher[29+3]);


	if (ProcWatcher[33+1] == 0) then
	ProcWatcherText_Action9Chance:SetText("0%");
	else
	ProcWatcherText_Action9Chance:SetText(ceil(ProcWatcher[33+2]/ProcWatcher[33+1]*100) .. "%");
	end
	ProcWatcherText_Action9Name:SetText(ProcWatcher[33+0]);
	ProcWatcherText_Action9Count:SetText(ProcWatcher[33+1] .. "/" .. ProcWatcher[33+2]);
	ProcWatcherText_Action9Highest:SetText(ProcWatcher[33+3]);


	if (ProcWatcher[37+1] == 0) then
	ProcWatcherText_Action10Chance:SetText("0%");
	else
	ProcWatcherText_Action10Chance:SetText(ceil(ProcWatcher[37+2]/ProcWatcher[37+1]*100) .. "%");
	end
	ProcWatcherText_Action10Name:SetText(ProcWatcher[37+0]);
	ProcWatcherText_Action10Count:SetText(ProcWatcher[37+1] .. "/" .. ProcWatcher[37+2]);
	ProcWatcherText_Action10Highest:SetText(ProcWatcher[37+3]);

end

------------------------------------------------------------------------

function ProcWatcher_SlashCommandHandler(arg1)

	if (string.lower(arg1)=="") then

		DEFAULT_CHAT_FRAME:AddMessage("|cffff9999ProcWatcher 2.0|cffffffff");
		DEFAULT_CHAT_FRAME:AddMessage("|cff99ff99/pw|cffffffff - show the window.");
		DEFAULT_CHAT_FRAME:AddMessage("|cff99ff99/pw hide|cffffffff - hide the window (data still is collected).");
		DEFAULT_CHAT_FRAME:AddMessage("|cff99ff99/pw reset|cffffffff - reset all data.");

		ShowUIPanel(ProcWatcherFrame);
	end


	if (string.lower(arg1)=="hide") then

		HideUIPanel(ProcWatcherFrame);
	end


	if (string.lower(arg1)=="reset") then

		ProcWatcher_ResetVars();
	end
end

------------------------------------------------------------------------

function ProcWatcher_UpdateAction(action,dam,crit)

	local found = 0;

	for k,v in ProcWatcher do

		if (v == action) then
		found = k;
		break;
		end
	end


	if (found == 0) then

		for k,v in ProcWatcher do

			if (v == "--") then
			found = k;
			break;
			end
		end
	end


--DEFAULT_CHAT_FRAME:AddMessage(dam .. " | " .. crit .. " | " .. action);


	if not (found == 0) then

		ProcWatcher[found] = action;
		ProcWatcher[found+1] = ProcWatcher[found+1] + 1;

		if (crit == 1) then
		ProcWatcher[found+2] = ProcWatcher[found+2] + 1;
		end

		if (tonumber(dam) > tonumber(ProcWatcher[found+3])) then
		ProcWatcher[found+3] = tonumber(dam);
		end

	ProcWatcher_UpdateFrame();

	end

end

------------------------------------------------------------------------

function ProcWatcher_OnEvent(event,arg1)

	if (event == "VARIABLES_LOADED") then

		if (ProcWatcher[1] == nil) then
			ProcWatcher_ResetVars();
			else
			ProcWatcher_UpdateFrame();
		end
	end

	if event and (string.sub(event,1,14)=="CHAT_MSG_SPELL" or string.sub(event,1,15)=="CHAT_MSG_COMBAT") then

		local action = 0;
		local crit = 0;
		local dam = 0;

		if (string.find(arg1,"You hit ")) then

			dam = string.gsub(string.gsub(string.gsub(arg1,".* for ",""),"%..*","")," .*","");
			ProcWatcher_UpdateAction("Hit",dam,0);
		end

		if (string.find(arg1,"You crit ")) then

			dam = string.gsub(string.gsub(string.gsub(arg1,".* for ",""),"%..*","")," .*","");
			ProcWatcher_UpdateAction("Hit",dam,1);
		end


		if (string.find(arg1,"Your ") and string.find(arg1," for ")) then

			if (string.find(arg1," hits ")) then

				action = string.gsub(string.gsub(arg1,"Your ","")," hits .*","");
				dam = string.gsub(string.gsub(string.gsub(arg1,".* for ",""),"%..*","")," .*","");
				ProcWatcher_UpdateAction(action,dam,0);
			end


			if (string.find(arg1," crits ")) then

				action = string.gsub(string.gsub(arg1,"Your ","")," crits .*","");
				dam = string.gsub(string.gsub(string.gsub(arg1,".* for ",""),"%..*","")," .*","");
				ProcWatcher_UpdateAction(action,dam,1);
			end

			if (string.find(arg1," heals ")) then

				if (string.find(arg1," critically ")) then
					action = string.gsub(string.gsub(arg1,"Your ","")," critically .*","");
					crit = 1;
					else
					action = string.gsub(string.gsub(arg1,"Your ","")," heals .*","");
					crit = 0;
				end

				dam = string.gsub(string.gsub(string.gsub(arg1,".* for ",""),"%..*","")," .*","");
				ProcWatcher_UpdateAction(action,dam,crit);
			end

		end
	end
end
