SSHonorVersion = "1.2.1";

-----------
-- ENGLISH
-----------

SSH_COMBATLOG_HONORGAIN = "%s dies, honorable kill Rank: %s (%s)";

SSH_ACTUAL = "Actual: %s";
SSH_ACTUALHP = "Actual Honor Points: %s";

SSH_ESTIMATED = "Estimated: %s";
SSH_ESTIMATEDHP = "Estimated Honor Points: %s";

SSH_KILLED = "Killed: %s";
SSH_RANKVALUE = "Rank Value: %s";
SSH_SPLIT = "Split By: %s";

SSH_UNKNOWN = "Unknown"

SSH_ON = "on";
SSH_OFF = "off";
SSH_HONOR = "Honor";

SSH_SCTTOOLTIP = "\n\nThis function has been hooked by SSHonor and will display actual honor from kills instead of estimated.";

SSH_HONOR_TT_TITLE = "Honor Stats";
SSH_HONOR_TT = "Total Honor: %s\n\nKill Honor %s (%s)%s\nBonus Honor %s (%s)%s\n\nMatch History %s:%s%s%s";
SSH_HONOR_TT_REP = "Reputation\n%s";

SSH_HONOR_TT_HONOR = "Time Online: %s\nHonor (Session): %s\nHonor per/hour: %s\nHonor per/minute: %s";

SSH_NONE = "None";
SSH_HONOR_ROW = "%s: %s";

SSH_HONOR_RESET = "Honor has been reset for the day. SSHonor estimated %s, actual honor is %s, difference of %s."
SSH_HONOR_RESET_WEEK = "Honor has been reset for the week, total honorable kills %s, total honor %s, standing %s.";

SSH_UPGRADED_CONFIG = "SSHonor configuration has been upgraded to %s.";

SSH_OTHER = "Other";
SSH_CITY = "City";
SSH_MARK = "Marks";

SSH_ALLIANCE_FORCES = "Alliance Forces";
SSH_HORDE_FORCES = "Horde Forces";

-- Do not translate the faction name, only city
SSH_CITIES = {	{ "Ironforge", "Alliance" },
		{ "Stormwind City", "Alliance" },
		{ "The Undercity", "Horde" },
		{ "Darnassus", "Alliance" },
		{ "Thunder Bluff", "Horde" },
		{ "Orgrimmar", "Horde" } };

-- Ranks
SSH_RANKS = {};
SSH_RANKS[1] = { names = { "Private", "Scout" }, amount = 198 };
SSH_RANKS[2] = { names = { "Corporal", "Grunt" }, amount = 210 };
SSH_RANKS[3] = { names = { "Sergeant", "Sergeant" }, amount = 221 };
SSH_RANKS[4] = { names = { "Master Sergeant", "Senior Sergeant" }, amount = 233 };
SSH_RANKS[5] = { names = { "Sergeant Major", "First Sergeant" }, amount = 246 };
SSH_RANKS[6] = { names = { "Knight", "Stone Guard" }, amount = 260 };
SSH_RANKS[7] = { names = { "Knight-Lieutenant", "Blood Guard" }, amount = 274 };
SSH_RANKS[8] = { names = { "Knight-Captain", "Legionnaire" }, amount = 289 };
SSH_RANKS[9] = { names = { "Knight-Champion", "Centurion" }, amount = 305 };
SSH_RANKS[10] = { names = { "Lieutenant Commander", "Champion" }, amount = 321 };
SSH_RANKS[11] = { names = { "Commander", "Lieutenant General" }, amount = 339 };
SSH_RANKS[12] = { names = { "Marshal", "General" }, amount = 357 };
SSH_RANKS[13] = { names = { "Field Marshal", "Warlord" }, amount = 377 };
SSH_RANKS[14] = { names = { "Grand Marshal", "High Warlord" }, amount = 398 };

-- fubar/titan localization
SSH_TODAYS_HONOR = "Todays Honor";

-- Configuration
-- Eventually this will be merged with the UI Configuration so it wont have two seperate ones
SSH_CMD_TOGGLE = "/sshonor %s <on/off> - %s";
SSH_CMD_EXECUTE = "/sshonor %s - %s";

SSH_MOD_NAME = "Enable SSHonor";
SSH_MOD_DESC = "SSHonor mod status";
SSH_MOD_CHANGED = "SSHonor is %s";

SSH_RESET_NAME = "Reset honor";
SSH_RESET_DESC = "Resets all of the honor data for this week and last";
SSH_RESET_CHANGED = "Honor has been reset";

SSH_HIDEICON_NAME = "Hide rank icon";
SSH_HIDEICON_DESC = "Hide the rank icon from the honor frame";
SSH_HIDEICON_CHANGED = "Rank icon is %s";

SSH_ACTUALHP_NAME = "Enemy actual honor on death";
SSH_ACTUALHP_DESC = "Shows the actual honor gain on enemy death";
SSH_ACTUALHP_CHANGED = "Actual honor is %s";

SSH_ESTIMATEDHP_NAME = "Enemy estimated honor on death";
SSH_ESTIMATEDHP_DESC = "Shows the estimated honor gain on enemy death";
SSH_ESTIMATEDHP_CHANGED = "Estimated honor is %s";

SSH_KILLED_NAME = "Killed count on death";
SSH_KILLED_DESC = "Shows how many times an enemy died today on there death";
SSH_KILLED_CHANGED = "Kill counter is %s";

SSH_KILLFIX_NAME = "Honor frame kill fix";
SSH_KILLFIX_DESC = "Fixes the honor frame rollover bug";
SSH_KILLFIX_CHANGED = "Kill fix is %s";

SSH_PERCENT_NAME = "Rank progression percent";
SSH_PERCENT_DESC = "Shows a percentage of how far you've progressed in a rank";
SSH_PERCENT_CHANGED = "Rank progression percent is %s";

SSH_HIDEICON_NAME = "Hide rank icon";
SSH_HIDEICON_DESC = "Hides the rank icon on the honor frame";
SSH_HIDEICON_CHANGED = "Hide rank icon is %s";

SSH_EXAMPLE_NAME = "Kill Example";
SSH_EXAMPLE_DESC = "Shows an example kill message using the options you've enabled";

SSH_RANKNUMBER_NAME = "Rank number on death";
SSH_RANKNUMBER_DESC = "Shows the rank number on on enemy death";
SSH_RANKNUMBER_CHANGED = "Rank number is %s";

SSH_RANKVALUE_NAME = "Rank honor value on death";
SSH_RANKVALUE_DESC = "Shows the total honor value of the rank on enemy death";
SSH_RANKVALUE_CHANGED = "Rank honor is %s";

SSH_HONORFRAME_NAME = "Show honor frame";
SSH_HONORFRAME_DESC = "Bring up the characters honor frame";

-- UI
SSH_UI_ENABLE = "Enable SSHonor";
SSH_UI_SHOWPERCENT = "Show how far you are into your rank";
SSH_UI_HIDEICON = "Hide rank icon on honor frame";
SSH_UI_SHOWACTUAL = "Show actual honor gain on enemy death";
SSH_UI_SHOWESTIMATED = "Show estimated honor gain on enemy death";
SSH_UI_SHOWKILLED = "Show how many times you've killed somebody today";
SSH_UI_SHOWSPLIT = "Show how many people a kill's honor was split with";
SSH_UI_FIXKILLS = "Fix kills for today when online for honor reset";
SSH_UI_FIXKILLS_TT = "Will fix honorable kills for today if you're online and PvPing during honor reset.\nIf your game crashes you may notice that the honorable kill counter is a little bit off.";
SSH_UI_DEATHOPTIONS_TT = "What information to show on the honorable kill (estimated honor points: 341) text.";
SSH_UI_RANKNUMBER_TT = "Shows the rank number on enemy death, instead of \"Marshal\" it'll show \"Marshal (12)\"";
SSH_UI_RANKNUMBER = "Show rank number on enemy death";
SSH_UI_RANKVALUE = "Show rank honor value on enemy death";
SSH_UI_RANKVALUE_TT = "Shows how much honor the enemy was worth total, ignoring honor split and diminishing.";
SSH_UI_KILLTEST = "Kill Example";

-- Example kill message info
SSH_KILL_EXAMPLE = { name = "Cleanse", rank = "Knight-Lieutenant" };

SSH_HELP = {};
SSH_HELP[1] = "/sshonor <on/off> - Change mod status";
SSH_HELP[2] = "/sshonor icon <on/off> - Displays the PVP icon on the honor frame and inspect frame.";
SSH_HELP[3] = "/sshonor percent <on/off> - Displays a percentage of how far you are into a rank.";
SSH_HELP[4] = "/sshonor actual <on/off> - Show actual honor points on enemy death";
SSH_HELP[5] = "/sshonor estimated <on/off> - Show estimated honor points on enemy death";
SSH_HELP[6] = "/sshonor killed <on/off> - Show how many times you've killed somebody when they die";
--SSH_HELP[7] = "/sshonor split <on/off> - Show how many people a kill's honor was split with";
SSH_HELP[8] = "/sshonor killfix <on/off> - Fixes honorable kills for today and will reset them to prevent the roll over bug.";
SSH_HELP[9] = "/sshonor rankn <on/off> - Show rank number on enemy death.";
SSH_HELP[10] = "/sshonor rankw <on/off> - Show rank honor value on enemy death.";
SSH_HELP[11] = "/sshonor honor - Pull up the honor frame.";
SSH_HELP[12] = "/sshonor example - Shows an example kill message using the options you have enabled.";
SSH_HELP[13] = "/sshonor reset - Resets all killed data for the day.";
SSH_HELP[13] = "/sshonor status - Display mod status";

SSH_HONORPOINTS = "Estimated Honor";

SSH_BGFACTIONS = {};
SSH_BGFACTIONS[1] = "Silverwing Sentinels";
SSH_BGFACTIONS[2] = "Warsong Outriders";
SSH_BGFACTIONS[3] = "Frostwolf Clan";
SSH_BGFACTIONS[4] = "The Defilers";
SSH_BGFACTIONS[5] = "Stormpike Guard";
SSH_BGFACTIONS[6] = "The League of Arathor";