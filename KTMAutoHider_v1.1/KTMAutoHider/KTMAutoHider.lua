KTMAH_config = { };
KTMAH_config["raid"] = 1;
KTMAH_config["party"] = 1;

function KTMAutoHider_OnLoad()
	
	this:RegisterEvent("CHAT_MSG_SYSTEM");
	this:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");
	
	if (not UnitInParty("party1")) then
		KLHTM_SetVisible(false);
	end

	SlashCmdList["KTMAH"] = KTMAH_SlashHandler;
	SLASH_KTMAH1 = "/ktmah";

	DEFAULT_CHAT_FRAME:AddMessage("KTMAutoHider loaded");
end

function KTMAH_SlashHandler(msg)
	local args = {};
	for value in string.gfind(msg, "[^ ]+") do
		table.insert(args, string.lower(value));
	end		
	if (args[1]=="party") then
		if (KTMAH_config["party"] == 1) then
			KTMAH_config["party"] = 0;
			if (not UnitInRaid("raid1")) then
				KLHTM_SetVisible(false);
			end
			DEFAULT_CHAT_FRAME:AddMessage("KLHThreatMeter will be hidden while in party");
		else
			KTMAH_config["party"] = 1;
			if (UnitInParty("party1")) then
				KLHTM_SetVisible(true);
			end
			DEFAULT_CHAT_FRAME:AddMessage("KLHThreatMeter will be shown while in party");
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("KTMAutoHider Help: /ktmah <command>");
		DEFAULT_CHAT_FRAME:AddMessage("Commands:");
		DEFAULT_CHAT_FRAME:AddMessage("- party");
	end
end

function KTMAutoHider_OnEvent(event)
	if (event == "CHAT_MSG_SYSTEM") then
		if (arg1 == ERR_RAID_YOU_JOINED) then
			KLHTM_SetVisible(true);	
		elseif (arg1 == ERR_LEFT_GROUP_YOU) then
			KLHTM_SetVisible(false);
		elseif (arg1 == ERR_GROUP_DISBANDED) then
			KLHTM_SetVisible(false);
		end
	elseif (event == "PARTY_LOOT_METHOD_CHANGED") then
		if (KTMAH_config["party"] == 1) then
			KLHTM_SetVisible(true);
		end
	end
end