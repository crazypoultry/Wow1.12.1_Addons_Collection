RaidHealer_GlobalConfig_Default = {
	["WHISPER_ASSIGNMENT"] 			= true,
	["HIDE_OUTGOING_WHISPER"] 	= false,
	["HIDE_INCOMMING_WHISPER"] 	= false,
	["ANNOUNCE_ALTERNATE"]			= false,
	["HIDE_ANNOUNCE_HEAL"]			= false,
	["HIDE_ANNOUNCE_BUFF"]			= false,
	["MINIMAP_SHOW"] 						= true,
	["MINIMAP_POS"] 						= RAIDHEALER_DEFAULT_MINIMAP_POS,
	["INNERVATE_ALERT"]					= true,
	["INNERVATE_ALERT_VALUE"]		= 0.35,
	["INNERVATE_ANNOUNCE_RAID"] = true,
	["INNERVATE_ANNOUNCE_SAY"]	= true
}

RaidHealer_CharacterConfig_Default = {
	["HEAL_CLASSES"] = {},
	["ASSIGNMENT_CHANNEL_HEAL"]	= "RAID",
	["ASSIGNMENT_CHANNEL_BUFF"]	= "RAID",
	["CURRENT_TANK_CLASS"]			= RAIDHEALER_CLASS_WARRIOR,
	["CURRENT_BUFF_TYPE"]				= 1,
	["LAST_ANNOUNCER_HEAL"]			= "",
	["LAST_ANNOUNCER_BUFF"]			= "",
	["SHOW_INFOFRAME"] 					= true
}

RaidHealer_Assignments_Default = {
	["HEAL"] = {},
	["BUFF"] = {
		["STAMINA"] = {},
		["SPIRIT"] = {},
		["SHADOW"] = {},
		["MOTW"] = {},
		["THORNS"] = {},
		["INTELLECT"] = {}
	}
}

-- assign default values, will be ovrwrtitten by saved variables
RaidHealer_GlobalConfig			= RaidHealer_GlobalConfig_Default;
RaidHealer_CharacterConfig	= RaidHealer_CharacterConfig_Default;
RaidHealer_Assignments			= RaidHealer_Assignments_Default;

RaidHealer_RaidMember = {
	[RAIDHEALER_CLASS_WARRIOR] = { },
	[RAIDHEALER_CLASS_PRIEST] = { },
	[RAIDHEALER_CLASS_PALADIN] = { },
	[RAIDHEALER_CLASS_DRUID] = { },
	[RAIDHEALER_CLASS_SHAMAN] = { },
	[RAIDHEALER_CLASS_WARLOCK] = { },
	[RAIDHEALER_CLASS_MAGE] = { },
	[RAIDHEALER_CLASS_ROGUE] = { },
	[RAIDHEALER_CLASS_HUNTER] = { }
};

RaidHealer_User = {};
RaidHealer_User.class = "";
RaidHealer_User.channels = {};
RaidHealer_User.inRaid = function () if (UnitInRaid("player") or RAIDHEALER_DEBUG == true) then return true; else return false; end end
RaidHealer_User.faction = "";
RaidHealer_User.innervateId = nil;