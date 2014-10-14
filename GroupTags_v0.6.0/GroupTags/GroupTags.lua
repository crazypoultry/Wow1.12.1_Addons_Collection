--[[ 

Group Tags

Revision History:
-----------------
.
. 0.6.0 - Class colored tags.
. 0.5.0 - Color option works with all channel colors now.
. 0.4.0 - Show group tag in whispers as well as raid chat.
. 0.3.0 - Save color and enabled flags between sessions.
. 0.2.0 - First public release.
.

]]--

gtags_roster = {};
gtags_status_version_txt = "0.6.0";
GroupTags_Enabled = 1;
GroupTags_Whispers = 0;
GroupTags_Color = 1;
gtags_time = 0;
local old_chat_handler;
local gtags_class_colors = {
	Warlock = "|cff9482C9",
	Hunter = "|cffABD473",
	Priest = "|cffFFFFFF",
	Paladin = "|cffF58CBA",
	Mage = "|cff69CCFF",
	Rogue = "|cffFFF569",
	Druid = "|cffFF7D0A",
	Shaman  = "|cffF58CBA",
	Warrior = "|cffC79C6E"
};

function gtags_load()
	SlashCmdList["gtags"] = gtags_slash;
	SLASH_gtags1 = "/gtags";
	DEFAULT_CHAT_FRAME:AddMessage("Group Tags (/gtags) version "..gtags_status_version_txt.." loaded.");
	old_chat_handler = ChatFrame_OnEvent;
	ChatFrame_OnEvent = gtags_event;
end


function gtags_slash(msg)
	if (msg == "enable") then
		GroupTags_Enabled = 1;
		DEFAULT_CHAT_FRAME:AddMessage("/gtags |cff00ff00enabled");
	elseif (msg == "disable") then
		GroupTags_Enabled = 0;
		DEFAULT_CHAT_FRAME:AddMessage("/gtags |cffff0000disabled");
      elseif (msg == "enabled") then
		if (GroupTags_Enabled == 1) then
			GroupTags_Enabled = 0;
		else
			GroupTags_Enabled = 1;
		end
		DEFAULT_CHAT_FRAME:AddMessage("/gtags |cff8888ffenabled is "..GroupTags_Enabled);
      elseif (msg == "whispers") then
		if (GroupTags_Whispers == 1) then
			GroupTags_Whispers = 0;
		else
			GroupTags_Whispers = 1;
		end
		DEFAULT_CHAT_FRAME:AddMessage("/gtags |cff8888ffwhispers are "..GroupTags_Whispers);
	elseif (msg == "refresh") then
		gtags_time = 0;
		DEFAULT_CHAT_FRAME:AddMessage("/gtags |cff8888ffrefreshing on next chat event");
	elseif (msg == "color" or msg == "colour") then
		if (GroupTags_Color == 1) then
			GroupTags_Color = 0;
		else
			GroupTags_Color = 1;
		end
		DEFAULT_CHAT_FRAME:AddMessage("/gtags |cff8888ffcolor is "..GroupTags_Color);
	else
		DEFAULT_CHAT_FRAME:AddMessage("Group Tags v"..gtags_status_version_txt);
		DEFAULT_CHAT_FRAME:AddMessage("    /gtags |cff8888ffenabled");
		DEFAULT_CHAT_FRAME:AddMessage("    /gtags |cff8888ffrefresh");
		DEFAULT_CHAT_FRAME:AddMessage("    /gtags |cff8888ffwhispers");
		DEFAULT_CHAT_FRAME:AddMessage("    /gtags |cff8888ffcolor");
	end
end


function gtags_refresh()
	local now = GetTime();
	if (now > gtags_time + 30) then
		gtags_roster = {};

		local name,rank,subgroup,l,c,f,z,o,d;
		local res;
		for i=1,GetNumRaidMembers() do
			name,rank,subgroup,l,c,f,z,o,d = GetRaidRosterInfo(i);
			res = {};
			res["name"] = name;
			res["rank"] = rank;
			res["subgroup"] = subgroup;
			res["class"] = c;
			tinsert(gtags_roster, res);
		end
		gtags_time = now;
	end
end

function gtags_event(event)
	if (GroupTags_Enabled == 0) then
		old_chat_handler(event);
		return;
	end

	if (event == 'CHAT_MSG_WHISPER' and GroupTags_Whispers == 0) then
		old_chat_handler(event);
		return;
	end

	if (event ~= 'CHAT_MSG_RAID' and event ~= 'CHAT_MSG_RAID_LEADER' and event ~= 'CHAT_MSG_WHISPER') then
		old_chat_handler(event);
		return;
	end

	gtags_refresh();

	local res = nil;
	for i=1,getn(gtags_roster) do
		if (gtags_roster[i]["name"] == arg2) then
			res = gtags_roster[i];
			break;
		end
	end
	if (res ~= nil) then
		if (GroupTags_Color == 1) then
			arg1 = "["..gtags_class_colors[res["class"]].."G"..res["subgroup"].."|r]: "..arg1;
		else
			arg1 = "[G"..res["subgroup"].."]: "..arg1;
		end
	end
	old_chat_handler(event);
end

