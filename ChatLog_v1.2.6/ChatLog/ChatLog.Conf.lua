--ADDON INFORMATION
CHAT_LOG_TITLE = "ChatLog";
CHAT_LOG_VERSION = "1.2.6";

--FUNCTIONS PARAMETERS & GLOBAL SETTINGS
--Global settings
CHAT_LOG_CHAT_ENABLED = 0;
CHAT_LOG_COMBATCHAT_ENABLED = 0;
CHAT_LOG_ALPHA = 1;
CHAT_LOG_MAXSIZE = 1000;
CHAT_LOG_COPY_MAXSIZE = 250;
CHAT_LOG_SCROLLING_MESSAGE_FRAME_MAXLINES = 31;
CHAT_LOG_DROPDOWN_MAXBUTTONS = 25;
CHAT_LOG_CURRENT_MAXLINE = 1;
CHAT_LOG_ENABLED_DEFAULT = 1;
--Chat IDs
CHAT_LOG_WHISPER_ID = "684170601";
CHAT_LOG_RAID_ID = "684170602";
CHAT_LOG_PARTY_ID = "684170603";
CHAT_LOG_SAY_ID = "684170604";
CHAT_LOG_YELL_ID = "684170605";
CHAT_LOG_OFFICER_ID = "684170606";
CHAT_LOG_GUILD_ID = "684170607";
--Chat index
CHAT_LOG_WHISPER_INDEX = 1;
CHAT_LOG_RAID_INDEX = 2;
CHAT_LOG_PARTY_INDEX = 3;
CHAT_LOG_SAY_INDEX = 4;
CHAT_LOG_YELL_INDEX = 5;
CHAT_LOG_OFFICER_INDEX = 6;
CHAT_LOG_GUILD_INDEX = 7;
--Current displayed index
CHAT_LOG_CURRENT_INDEX = 0;
CHAT_LOG_DEFAULT_INDEX = CHAT_LOG_WHISPER_INDEX;
--ChatTypeInfo table correction 
CHAT_LOG_COLORS = {
	["SYSTEM"] = {
		["r"] = 1.0,
		["g"] = 1.0,
		["b"] = 0.0,
	},
	["RAID_LEADER"] = {
		["r"] = 1.0,
		["g"] = 1.0,
		["b"] = 0.0,
	},
	["MAXLOG_INFO_TEXT"] = {
		["r"] = 1.0,
		["g"] = 1.0,
		["b"] = 1.0,
	},
};

--LOGS
--Main structure
ChatLog_Logs = {
	[CHAT_LOG_WHISPER_INDEX] = {
		["id"] = CHAT_LOG_WHISPER_ID,
		["name"] = "",
		["enabled"] = 1,
		["logs"] = {},
	},
	[CHAT_LOG_RAID_INDEX] = {
		["id"] = CHAT_LOG_RAID_ID,
		["name"] = "",
		["enabled"] = 1,
		["logs"] = {},
	},
	[CHAT_LOG_PARTY_INDEX] = {
		["id"] = CHAT_LOG_PARTY_ID,
		["name"] = "",
		["enabled"] = 1,
		["logs"] = {},
	},
	[CHAT_LOG_SAY_INDEX] = {
		["id"] = CHAT_LOG_SAY_ID,
		["name"] = "",
		["enabled"] = 1,
		["logs"] = {},
	},
	[CHAT_LOG_YELL_INDEX] = {
		["id"] = CHAT_LOG_YELL_ID,
		["name"] = "",
		["enabled"] = 1,
		["logs"] = {},
	},
	[CHAT_LOG_OFFICER_INDEX] = {
		["id"] = CHAT_LOG_OFFICER_ID,
		["name"] = "",
		["enabled"] = 1,
		["logs"] = {},
	},
	[CHAT_LOG_GUILD_INDEX] = {
		["id"] = CHAT_LOG_GUILD_ID,
		["name"] = "",
		["enabled"] = 1,
		["logs"] = {},
	},
};

--STATUS
CHAT_LOG_NUM_PARTY_MEMBERS = 0;
CHAT_LOG_NUM_RAID_MEMBERS = 0;