AUTO_INVITE_MOD_LOADED_SUCCESSFULLY="Mod loaded successfully. Version: %d. /ai for help.";

AUTO_INVITE_CLASS={
   DRUID = "Druid",
   HUNTER = "Hunter",
   MAGE = "Mage",
   PALADIN = "Paladin",
   SHAMAN = "Shaman",
   PRIEST = "Priest",
   ROGUE = "Rogue",
   WARRIOR = "Warrior",
   WARLOCK = "Warlock",
};
AUTO_INVITE_UNKNOWN_ENTITY="Unknown";

-- the GUI Main Frame
AUTO_INVITE_COMPLETELIST="Complete List (%d)";
AUTO_INVITE_NUMBER_OF_PLAYERS="Number of players: %d/%d";
AUTO_INVITE_TO_GROUP="To Group";
AUTO_INVITE_WISPER_PLAYER_IF_IN_GROUP="Wisper to player if already in group";
AUTO_INVITE_MOD_ACTIVE="Mod active";
AUTO_INVITE_RAID_INVITE="Raid-Invite";
AUTO_INVITE_GROUP_INVITE="Group-Invite";
AUTO_INVITE_READ_GROUPS="Read Groups";
AUTO_INVITE_MOVE_GROUPS="Move Groups";
AUTO_INVITE_LOAD_SAVE="Load-Save";
AUTO_INVITE_UPDATE="Update";
AUTO_INVITE_CLEAR="Clear";
AUTO_INVITE_ADD="Add";
AUTO_INVITE_SORT="Sort";
AUTO_INVITE_GET_STATE="Get State";
AUTO_INVITE_LOCK="Lock";
AUTO_INVITE_CLOSE="Close";
AUTO_INVITE_LOAD_GUILD="Load Guild";
-- Frame Add Player
AUTO_INVITE_ADDMEMBER_LABEL="Name to add to the complete list:";

-- Frame Save Groupsetup
AUTO_INVITE_SAVEDESCRPTION_LABEL="Description for current groupsetup";

-- Frame Load Save Config
AUTO_INVITE_LOAD_SAVE_CONFIG="Load Save Config";
AUTO_INVITE_SAVE_NEW="Save as new";
AUTO_INVITE_IMPORT_CSV="Import CSV";
AUTO_INVITE_LOAD="Load";
AUTO_INVITE_SAVE="Save";
AUTO_INVITE_DEL="Del";

-- Frame Import CSV
AUTO_INVITE_TITLE_IMPORT_CSV="Import CSV";
AUTO_INVITE_ENTER_NAME_FOR_PROFILE="Enter name for profile:";
AUTO_INVITE_COPY_CSV_HERE="Copy CSV here with CTRL+v:";
AUTO_INVITE_IMPORT="Import";

-- Shortcut Menu for WoW
BINDING_HEADER_AUTOINVITE="Auto Invite";
BINDING_NAME_AISHOW="Show and hide the configuration screen";
BINDING_NAME_AIINVITE="Invite people";
BINDING_NAME_AIADD="Add target to list";

-- Text which must be parsed to get player status must be localized!
AUTO_INVITE_DECLINES_YOUR_INVITATION     ="%a+ declines your group invitation.";
AUTO_INVITE_DECLINES_YOUR_INVITATION_FIND="^(.+) declines your group invitation.";
AUTO_INVITE_IGNORES_YOUR_INVITATION="%a+ is ignoring you.";
AUTO_INVITE_IGNORES_YOUR_INVITATION_FIND="^(.+) is ignoring you.";

AUTO_INVITE_IS_ALREADY_IN_GROUP="%a+ is already in a group.";
AUTO_INVITE_IS_ALREADY_IN_GROUP_FIND="^(.+) is already in a group.";
AUTO_INVITE_SEND_MESSAGE_ALREADY_IN_GROUP="You are already in group please leave it";

AUTO_INVITE_GROUP_LEAVE="%a+ leaves the party.";
AUTO_INVITE_GROUP_LEAVE_FIND="(.+) leaves the party.";
AUTO_INVITE_RAID_LEAVE="%a+ has left the raid group";
AUTO_INVITE_RAID_LEAVE_FIND="(.+) has left the raid group";

AUTO_INVITE_INVITED="You have invited %w+ to join your group.";
AUTO_INVITE_INVITED_FIND="You have invited (.+) to join your group.";
AUTO_INVITE_GROUP_DISBANDED="Your group has been disbanded";
AUTO_INVITE_GROUP_DISBANDED2="You leave the group.";
AUTO_INVITE_RAID_DISBANDED="You have left the raid group";

AUTO_INVITE_GONE_OFFLINE="%a+ has gone offline.";
AUTO_INVITE_IS_OFFLINE="Cannot find '%a+'.";
AUTO_INVITE_IS_OFFLINE_FIND="Cannot find '(.+)'.";

-- Chat messages send to GUI
AUTO_INVITE_NEED_ADDON_QUEUE_WHO="Can only read status for players in guild\nYou need the addon QueueWho to use this feature for all players, see the readme.txt";
AUTO_INVITE_AUTOINVITEGETMEMBERBYNAME_ERROR="AutoInvite ERROR in autoInviteGetMemberByName: Player %s is unknown";
AUTO_INVITE_ERROR_FOUND_NO_ID="Error with player: %s found no ID";
AUTO_INVITE_PLAYER_IGNORES_YOU="User: %s ignores you";
AUTO_INVITE_PLAYER_IS_ALREADY_IN_GROUP="User: %s is already in Group";
AUTO_INVITE_ERROR_ADDING_PLAYER_CONTACT_AUTHOR="Error in adding player: %s please contact the author of this mod";
AUTO_INVITE_PLAYER_LEFT_THE_GROUP="User: %s left the group";
AUTO_INVITE_PLAYER_LEFT_THE_RAID="User: %s left the raid";
AUTO_INVITE_COMMAND_HELP1="/ai show: show the configuration window";
AUTO_INVITE_COMMAND_HELP2="/ai add: add the corrent target to the complete list";
AUTO_INVITE_COMMAND_HELP3="/ai debug: view some debugging variables";
AUTO_INVITE_COMMAND_HELP4="/ai dump: save debugging info to file, please always do it when reporting bugs";
AUTO_INVITE_COMMAND_HELP5="/ai cleardump: clear the debug infos from the file";
AUTO_INVITE_COMMAND_HELP6="/ai verbose: de-/activate verbose mode";
AUTO_INVITE_COMMAND_HELP7="/ai reset: reset all values to default";
AUTO_INVITE_COMMAND_HELP8="/ai guild: add all guild members to the complete list";
AUTO_INVITE_NO_TARGET_SELECTED_SKIPPING="No target selected, skipping";
AUTO_INVITE_DEBUG_CALLED="DEBUG called, dump variables";
AUTO_INVITE_DUMP_CALLED="DUMP called, dump variables to file";
AUTO_INVITE_CLEAR_DUMP_CALLED="CLEARDUMP called, empty dump field";
AUTO_INVITE_VERBOSE_MOD_ACTIVE="VERBOSE mod activated";
AUTO_INVITE_VERBOSE_MOD_DEACTIVE="VERBOSE mod deactivated";
AUTO_INVITE_ADD_PLAYER_XXX_TO_LIST="Adding %s %d %s %s to list"
AUTO_INVITE_PLAYER_ALREADY_IN_LIST="Player %s is already in the list, skipping";
AUTO_INVITE_GOT_UNKOWN_SKIPPING="Got playername Unknown, skipping";
AUTO_INVITE_ADD_PLAYER_NOT_IN_TARGET="Player is not in target, got no information about it, added %s to list";
AUTO_INVITE_NO_INFO_AVAILABLE_MOVE_DRUIDE="No information about player %s available, move it to DRUIDE";
AUTO_INVITE_READ_GROUP_SETUP="Read Group Setup";
AUTO_INVITE_DONE="done.";
AUTO_INVITE_IM_NOT_THE_RAID_LEADER_SKIPPING="I am not the Raid Leader, skipping.";
AUTO_INVITE_FOR_XXX_NO_GROUP_DEFINED="For player %s no group defined, define it and try again";
AUTO_INVITE_PLAYER_MARKED_FOR_MOVING="Player %s is marked for moving";
AUTO_INVITE_START_TO_MOVE_PLAYERS="Start to move players...";
AUTO_INVITE_MOVING_FINISHED="Moving finished";
AUTO_INVITE_CANNOT_MOVE_PLAYER_GROUP_IS_FULL="Cannot move %s wish group is full";
AUTO_INVITE_LIST_LOADED="List has been loaded";
AUTO_INVITE_SUCCESSFULLY_SAVED="Successfully saved";
AUTO_INVITE_SUCCESSFULLY_DELETED="Successfully deleted";
AUTO_INVITE_NO_NAME_FOR_PROFILE_DONT_SAVE_IT="No name for profile is given, don't save it.";
AUTO_INVITE_GENERATE_DUMP="Generate dump...";
AUTO_INVITE_DUMP_SUCCESSFULLY_SEND_TO="dump successfully generated send the following file to 'idefix@fechner.net':";
AUTO_INVITE_DUMP_SEND_FILE="<WOW-DiR>\\WTF\\Account\\%s\\%s\\%s\\SavedVariables\\AutoInvite.lua";
AUTO_INVITE_THX_FOR_HELP="Thanks a lot for help!";
AUTO_INVITE_TO_SAVE_DUMP="To save the dump, exit the game or press <ENTER> and write: '/console reloadui'";
AUTO_INVITE_CLEAR_DUMP_LOG="Clear debug log...";
AUTO_INVITE_CHECK_ONLINE_STATUS_WITH_WHO="Check online status of player %s with the /who command...";
AUTO_INVITE_ALL_SETTINGS_RESETED="All settings resetted.";
AUTO_INVITE_IMPORT_GUILD_MEMBERS="Importing guild members";
