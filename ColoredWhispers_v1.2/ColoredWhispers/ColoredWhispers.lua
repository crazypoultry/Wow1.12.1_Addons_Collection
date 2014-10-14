-- -------------------------- --
--                            --
--  Elkano's ColoredWhispers  --
--                            --
--        version 1.1         --
--                            --
-- -------------------------- --

local ColoredWhispers_original_ChatFrame_OnEvent = ChatFrame_OnEvent;
local ColoredWhispers_original_CHAT_PARTY_GET;
local ColoredWhispers_original_CHAT_RAID_GET;
local ColoredWhispers_original_CHAT_WHISPER_GET;
local ColoredWhispers_original_CHAT_WHISPER_INFORM_GET;

local ColoredWhispers_name2color = {};
local ColoredWhispers_name2class = {};

local function ColoredWhispers_update_name2class_party()
	ColoredWhispers_name2class = {};
	local name, localizedClass, englishClass;
	name = UnitName("player");
	if (name and name ~= UNKNOWNOBJECT and name ~= UKNOWNBEING) then
		localizedClass, englishClass = UnitClass("player");
		ColoredWhispers_name2class[name] = englishClass;
	end
	for i=1, GetNumPartyMembers() do
		name = UnitName("party"..i);
		if (name and name ~= UNKNOWNOBJECT and name ~= UKNOWNBEING) then
			localizedClass, englishClass = UnitClass("party"..i);
			ColoredWhispers_name2class[name] = englishClass;
		end
	end
end

local function ColoredWhispers_update_name2class_raid()
	ColoredWhispers_name2class = {};
	local name, rank, subgroup, level, class, fileName, zone, online, isDead;
	for i=1, MAX_RAID_MEMBERS do
		name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
		if (name) then
			ColoredWhispers_name2class[name] = fileName;
		end
	end
end

function ColoredWhispers_OnLoad()
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("Elkano's ColoredWhispers AddOn v1.1 loaded");
	end
end

function ChatFrame_OnEvent(event)
	if( event == "CHAT_MSG_PARTY" and arg1 ) then
		ColoredWhispers_original_CHAT_PARTY_GET = CHAT_PARTY_GET;
		if ( ColoredWhispers_name2class[arg2] == nil ) then
			ColoredWhispers_update_name2class_party()
		end
		if ( ColoredWhispers_name2class[arg2] ~= nil ) then
			local color = RAID_CLASS_COLORS[ColoredWhispers_name2class[arg2]];
			CHAT_PARTY_GET = gsub(CHAT_PARTY_GET, "%%s", string.format("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255).."%%s|r");
		end
	end
	if( event == "CHAT_MSG_RAID" and arg1 ) then
		ColoredWhispers_original_CHAT_RAID_GET = CHAT_RAID_GET;
		if ( ColoredWhispers_name2color[arg2] == nil ) then
			ColoredWhispers_update_name2class_raid()
		end
		if ( ColoredWhispers_name2class[arg2] ~= nil ) then
			local color = RAID_CLASS_COLORS[ColoredWhispers_name2class[arg2]];
			CHAT_RAID_GET = gsub(CHAT_RAID_GET, "%%s", string.format("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255).."%%s|r");
		end
	end
	if( event == "CHAT_MSG_WHISPER" and arg1 ) then
		ColoredWhispers_original_CHAT_WHISPER_GET = CHAT_WHISPER_GET;
		if ( ColoredWhispers_name2color[arg2] == nil ) then
			ColoredWhispers_name2color[arg2] = {};
-- Suggestion by BOOL ( http://ui.worldofwar.net/users.php?id=158608 )
			ColoredWhispers_name2color[arg2].r = (math.random()*.33)+.33;
			ColoredWhispers_name2color[arg2].g = (math.random()*.33)+.66;
			ColoredWhispers_name2color[arg2].b = (math.random()*.33)+.66;
		end
		CHAT_WHISPER_GET = gsub(CHAT_WHISPER_GET, "%%s", string.format("|cff%02x%02x%02x", ColoredWhispers_name2color[arg2].r * 255, ColoredWhispers_name2color[arg2].g * 255, ColoredWhispers_name2color[arg2].b * 255).."%%s|r");
	end
	if( event == "CHAT_MSG_WHISPER_INFORM" and arg1 ) then
		ColoredWhispers_original_CHAT_WHISPER_INFORM_GET = CHAT_WHISPER_INFORM_GET;
		if ( ColoredWhispers_name2color[arg2] == nil ) then
			ColoredWhispers_name2color[arg2] = {};
			ColoredWhispers_name2color[arg2].r = math.random();
			ColoredWhispers_name2color[arg2].g = math.random();
			ColoredWhispers_name2color[arg2].b = math.random();
		end
		CHAT_WHISPER_INFORM_GET = gsub(CHAT_WHISPER_INFORM_GET, "%%s", string.format("|cff%02x%02x%02x", ColoredWhispers_name2color[arg2].r * 255, ColoredWhispers_name2color[arg2].g * 255, ColoredWhispers_name2color[arg2].b * 255).."%%s|r");
	end
	ColoredWhispers_original_ChatFrame_OnEvent(event);
	if( event == "CHAT_MSG_PARTY" and arg1 ) then
		CHAT_PARTY_GET = ColoredWhispers_original_CHAT_PARTY_GET;
	end
	if( event == "CHAT_MSG_RAID" and arg1 ) then
		CHAT_RAID_GET = ColoredWhispers_original_CHAT_RAID_GET;
	end
	if( event == "CHAT_MSG_WHISPER" and arg1 ) then
		CHAT_WHISPER_GET = ColoredWhispers_original_CHAT_WHISPER_GET;
	end
	if( event == "CHAT_MSG_WHISPER_INFORM" and arg1 ) then
		CHAT_WHISPER_INFORM_GET = ColoredWhispers_original_CHAT_WHISPER_INFORM_GET;
	end
end