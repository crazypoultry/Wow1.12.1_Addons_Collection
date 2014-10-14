--Commands
FM_GROUP_ON = "on";
FM_GROUP_OFF = "off";
FM_WHISPERCOMMAND_FOLLOW = "!follow";
FM_WHISPERCOMMAND_STATUS = "!status";
FM_COMMAND_STATUS = "status";
FM_COMMAND_ANNOUNCE = "party";
FM_COMMAND_RAID = "raid";
FM_COMMAND_TARGET = "whisper";
FM_COMMAND_ENABLE = "enable";
FM_COMMAND_DISABLE = "disable";
FM_COMMAND_TELLGROUP = "tellgroup";
FM_COMMAND_TELLRAID = "tellraid";
FM_COMMAND_FOLLOWGUILD = "guild";
FM_COMMAND_FOLLOWFRIENDS = "friends";

--Usage
FM_USE_TITLE	 = "  Usage:";
FM_USE_STATUS	 = "         status - Reports FollowMe status";
FM_USE_ENABLE	 = "         enable - Enables FollowMe";
FM_USE_DISABLE	 = "        disable - Disables FollowMe";
FM_USE_GUILD	 = "   guild on/off - Toggles that guild members can put you in auto-follow";
FM_USE_FRIENDS	 = " friends on/off - Toggles that friends can put you in auto-follow";
FM_USE_ANNOUNCE1 = "          party - Announces to your group that";
FM_USE_ANNOUNCE2 = "                  you have the FollowMe AddOn";
FM_USE_RAID1	 = "           raid - Announces to your raid that";
FM_USE_RAID2	 = "                  you have the FollowMe AddOn";
FM_USE_WHISPER1	 = "        whisper - Announces to your target that";
FM_USE_WHISPER2	 = "                  you have the FollowMe AddOn";
FM_USE_TELL1	 = "tellgroup on/off- Toggles sending auto-follow messages to";
FM_USE_TELL2	 = "                  your group";
FM_USE_TELL3	 = "tellraid on/off - Toggles sending auto-follow messages to";
FM_USE_TELL4	 = "                  your raid";

--Status
FM_STATUS_LOADED = "loaded";
FM_STATUS_ENABLED = "Enabled";
FM_STATUS_DISABLED = "Disabled";
FM_STATUS_GROUP = "   Group messages are ";
FM_STATUS_RAID = "   Raid messages are ";
FM_STATUS_GUILD = "   Accept auto-follow requests by guild members is ";
FM_STATUS_FRIENDS = "   Accept auto-follow requests by friends is ";

--Tellgroup
FM_TELLGROUP = "FollowMeEnhanced: Group messages are ";
FM_TELLRAID = "FollowMeEnhanced: Raid messages are ";
FM_FOLLOWGUILD = "FollowMeEnhanced: Accept auto-follow requests by guild members is ";
FM_FOLLOWFRIENDS = "FollowMeEnhanced: Accept auto-follow requests by friends is ";

--Event messages
FM_ERR_AUTOFOLLOW_TOO_FAR = "I cannot follow you.  Perhaps you're not close enough?";
FM_ERR_INVALID_FOLLOW_TARGET = "I cannot follow you.  Perhaps you're not close enough?";
FM_ERR_GENERIC = "I cannot follow you.  Perhaps you're not close enough?";
FM_ERR_NOGROUP = "I can't follow you -- we're not in a group/raid";
FM_WHISPER_AUTOFOLLOW_BEGIN = "Following you...lead on :)";
FM_PARTY_AUTOFOLLOW_BEGIN = "Auto-follow on ";
FM_WHISPER_AUTOFOLLOW_END = "I'm no longer following you.";
FM_PARTY_AUTOFOLLOW_END = "I'm no longer auto-following ";
FM_WHISPER_DISABLED = "I can't follow you -- FollowMe addon is disabled";
FM_WHISPER_STATUS_FOLLOW = "  Currently following ";

--Announce
FM_ANNOUNCE = [[I have the "FollowMeEnhanced" AddOn Installed.  If you want me to auto-follow you, send me a whisper with "]]..FM_WHISPERCOMMAND_FOLLOW..[[".]]..[[ For the actual status use "]]..FM_WHISPERCOMMAND_STATUS..[["."]];
