SSPVPVersion = "1.6.8";

--[[
************
** ENGLISH
************
]]

-- Battleground names
SS_WARSONGGULCH = "Warsong Gulch";
SS_ALTERACVALLEY = "Alterac Valley";
SS_ARATHIBASIN = "Arathi Basin";

-- BINDINGS
BINDING_HEADER_SSPVP = "SSPVP";
BINDING_NAME_TEFC = "Target Enemy Flag";
BINDING_NAME_TFFC = "Target Friendly Flag"
BINDING_NAME_SSGROUP = "Auto Group Queue";
BINDING_NAME_SSSOLO = "Auto Solo Queue";

-- Auto queue stuff
SS_AUTOQ_SOLO = "Auto solo queueing enabled!";
SS_AUTOQ_DISSOLO = "Auto solo queueing disabled!";

SS_AUTOQ_GROUP = "Auto group queueing enabled!";
SS_AUTOQ_DISGROUP = "Auto group queueing disabled!";

-- Alert that the timer is between 1-10 seconds and that it's been disabled.
SS_UI_HIGHERABINT = "The Arathi Basin alert interval is set to a value under 10 seconds and has been changed to 30 seconds.";
SS_UI_HIGHERAVINT = "The Alterac Valley alert interval is set to a value under 10 seconds and has been changed to 60 seconds.";

-- Mark turnin text
SSPVP_NOTENOUGHMARKS = "You do not currently have enough marks, talk to me again when you do.";
SS_ALLIANCE_TURNIN = "Alliance Brigadier General";
SS_HORDE_TURNIN = "Horde Warbringer";

-- 3/3/3 Turn in
SS_MARKS_HALL = "For Great Honor";
SS_MARKS_AALL = "Concerted Efforts";

-- Warsong Gulch Turn in
SS_MARKS_HWSG = "Battle of Warsong Gulch";
SS_MARKS_AWSG = "Fight for Warsong Gulch";

-- Arathi Basin Turn in
SS_MARKS_HAB = "Conquering Arathi Basin";
SS_MARKS_AAB = "Claiming Arathi Basin";

-- Alterac Valley Turn in
SS_MARKS_HAV = "Invaders of Alterac Valley";
SS_MARKS_AAV = "Remember Alterac Valley!";

-- Mark item name from battlegrounds
SS_MARKITEM_WSG = "Warsong Gulch Mark of Honor";
SS_MARKITEM_AV = "Alterac Valley Mark of Honor";
SS_MARKITEM_AB = "Arathi Basin Mark of Honor";

SS_MARKROW = "%s (%s/20)"; -- Warsong Gulch (12/20)

-- Misc stuff
SS_ON = "ON";
SS_OFF = "OFF";

SS_SECONDS = "second";
SS_MINUTES = "minute";

SS_LOADED = "Loaded";
SS_DISABLED = "Disabled";

SS_SHOWING_MINIMAP = "Showing battlefield minimap.";
SS_HIDING_MINIMAP = "Hiding battlefield minimap.";

SS_NO_RANK = "No Rank"

SS_MINING = "Mining";
SS_HERBING = "Herb Gathering";

SS_CURRENTLY_MINING = "You are currently mining and will be auto joined in 10 seconds.";
SS_CURRENTLY_HERBING = "You are currently picking an herb and will be auto joined in 10 seconds."; -- Yes i know herbing isn't a word
SS_NOT_ENOUGH_TIME = "Your queue will expire in under 10 seconds, auto joining you now.";

SS_AUTOQUEUE_GROUP = "Auto group queueing";
SS_AUTOQUEUE_SOLO = "Auto solo queueing";
SS_AUTOQUEUE_NOTLEADER = "You have to be a group leader to queue as a group.";

SS_RELEASING = "Auto Releasing...";
SS_SOULSTONE = "Soulstone active";

SS_HERALD = "Herald";

SS_CMD_MOD = "SSPVP is now %s";

SS_NO_TIMERS = "No timers are currently queued.";

SS_UNKNOWN_UNIT = "Unknown unit.";

SS_YOU_SLAIN = "You have slain (.+)!";
SS_KILLING_BLOW = "Killing Blow!";

SS_PRINTAV_HELP = "/printav <raid/party/say/guild/channel name> - Prints the time left on Alterac Valley resources for destroying or capturing.";

-- Zone names that shouldn't be considered an instance
SS_NOT_ANINSTANCE = {};
SS_NOT_ANINSTANCE[1] = "Deeprun Tram";
SS_NOT_ANINSTANCE[2] = "Champions' Hall";
SS_NOT_ANINSTANCE[3] = "Hall of Legends";

-- Main stuff besides configuration
SS_PVP = "SSPVP";
SS_MAIN_STATUS = "SSPVP %s %s!";

SS_ACCEPTING_INVITE = "Accepting invite from %s!";

SS_NOW_AFK = "You will no longer join the battlegrounds until you are no longer AFK.";
SS_NOLONGER_AFK = "Battleground joining re-enabled.";
SS_CURRENTLY_AFK = "You are currently AFK, will not auto join.";

SS_WINDOW_HIDDEN = "Battleground entry window is hidden, will not auto join.";
SS_INSIDE_BG = "You are currently inside an active battleground, will not auto join.";
SS_INSIDE_INSTANCE = "You are currently inside an instance, will not auto join.";
SS_CONFIRM_BGLEAVE = "Are you sure you want to leave the queue for %s?";

SS_DISABLED_QUEUED = "SSPVP was either disabled or Auto join was turned off, will not auto join.";

SS_PLAYING_SOUND = "Playing sound file %s";
SS_PLAY_INFO = "The sound file must be located inside the Interface\\AddOns\\SSPVP\\ directory at the start of the game. You cannot load a new music file by typing /console reloadui it must be a game restart.";
SS_STOPPED_PLAYING = "Sound stopped.";
SS_MP3_ERROR = "It appears that your music sound settings are set to off. This means you may not be hearing the sound file you are trying to play.";
SS_WAV_ERROR = "It appears that your sound settings are set to off. This means you may not be hearing the sound file you are trying to play.";

-- WSG Pick/Drop/Captured messages
SS_WSG_PICKEDUP = "The %s [fF]lag was picked up by ([^!]+)!";
SS_WSG_DROPPED = "The %s [fF]lag was dropped by ([^!]+)!";
SS_WSG_CAPTURED = "(.+) captured the %s [fF]lag!";

-- For flag targetting
SS_NO_FFC = "<no friendly flag carrier>";
SS_NO_EFC = "<no enemy flag carrier>";

-- You can change these to change the shortcut used in chat for friendly flag carrier and enemy flag carrier
SS_FFC_TAG = "$ffc";
SS_EFC_TAG = "$efc";

SS_TARGET_FLAGOOR = "%s is out of range!";
SS_FLAG_SETTO = "%s flag carrier set to %s";
SS_ENEMY = "Enemy";
SS_FRIENDLY = "Friendly";

SS_NOBODY_HASFLAG = "Nobody has your flag.";

SS_ALLIANCE = "Alliance";
SS_HORDE = "Horde";

-- Alterac valley
SS_AV_TAKEN = "(.+) was taken by the";
SS_AV_DESTROYED = "(.+) was destroyed by the";
SS_AV_CLAIMS = "claims the ([^!]+)!";

SS_DESTROYED = "destroyed";
SS_DESTROY = "destroy";
SS_CAPTURED = "captured";
SS_CAPTURE = "capture";

SS_AV_STATUS = "%s will be %s by the %s in %s"; -- Tower point will be destroyed by the Alliance in 5 minutes.
SS_AV_CHATTIMERS = "%s %s: %s"; -- Tower Point destroyed: 4:23

SS_AV_UNDERATTACK = "(.+) is under attack!";

-- AB Messages
-- Shadowd claims the blacksmith!  If left unchallenged, the Horde will control it in 1 minute!
SS_AB_TAKEN = "has taken the ([^!]+)!";
SS_AB_ASSAULTED = "has assaulted the ([^!]+)!";
SS_AB_CLAIMS = "claims the ([^!]+)!";

SS_AB_STATUS = "The %s will be taken by the %s in %s";
SS_AB_ALLTIMERS = "The %s: %s";

-- PVP Who
SS_SEARCH_NOBG = "You need to be inside a battleground to use this feature.";

SS_SEARCH_HELP = "PVP Who help";
SS_SEARCH_HELP_CLASSLIST = "classes - Class break down of the battleground";
SS_SEARCH_HELP_NAME = "n-\"<name>\" - Name Search";
SS_SEARCH_HELP_RANK = "ra-\"<1-14>\" - Rank Search";
SS_SEARCH_HELP_CLASS = "c-\"<class>\" - Class Search";
SS_SEARCH_HELP_RACE = "r-\"<race>\" - Race Search";

SS_SEARCH_CLASSROW = "%s: %s total"; -- Mage: 3 total
SS_SEARCH_ROW = "%s: %s / %s / %s"; -- Shadowd: Commander / Night Elf / Warrior
SS_SEARCH_RESULTS = "%s players total";

SS_SEARCH_CLASSES = "classes"; -- Used for class breakdown

-- Text to search on if were looking at battlemaster gossip
SS_BG_GOSSIP = "I would like to go to the battleground";
SS_BG_GOSSIP2 = "I wish to join the battle!";

-- UI Tabs
SS_UI_TAB_GENERAL = "General";
SS_UI_TAB_AUTOJOIN = "Auto join";
SS_UI_TAB_AUTOLEAVE = "Auto leave";
SS_UI_TAB_ACCEPTINVITE = "Accept Invite";
SS_UI_TAB_MINIMAP = "Minimap";
SS_UI_TAB_AV = SS_ALTERACVALLEY;
SS_UI_TAB_AB = SS_ARATHIBASIN;
SS_UI_TAB_OVERLAY = "Overlay";
SS_UI_TAB_INVITE = "SSInvite";

-- UI Text
-- BFMinimap
SS_UI_MAP_TEAM = "Show Teammates";
SS_UI_MAP_LOCK = "Lock Minimap";
SS_UI_MAP_RESET = "Reset Map Location";
SS_UI_MAP_TOGGLE = "Toggle Minimap";

SS_UI_INTERVAL = "Intervals in seconds between alerts";
SS_UI_100_PERCENT = "100%";
SS_UI_0_PERCENT = "0%";
SS_UI_OPACITY = "Opacity: %d";
SS_UI_TEXT_OPACITY = "Text Opacity: %d";

-- AB
SS_UI_AB_ENABLE = "Enable Arathi Basin timer";
SS_UI_AB_ALLIANCE = "Enable Alliance timers";
SS_UI_AB_HORDE = "Enable Horde timers";

-- AV
SS_UI_AV_ENABLE = "Enable Alterac Valley timer";
SS_UI_AV_ALLIANCE = "Alliance timers (Graveyards/Bunkers/Towers)";
SS_UI_AV_HORDE = "Horde timers (Graveyards/Bunkers/Towers)";

-- Auto accept invite
SS_UI_INVITE_ACCEPT = "Names to auto accept invites from";
SS_UI_INVITE_FRIENDS = "Accept invites from friends";
SS_UI_INVITE_BATTLEGROUND = "Accept invites from battleground team mates";

-- Auto leave
SS_UI_LEAVE_ENABLE = "Enable auto leave";
SS_UI_LEAVE_TIMEOUT = "Seconds before auto leaving.";
SS_UI_LEAVE_GROUP = "Leave group when the battleground ends"

-- Auto join
SS_UI_JOIN_ENABLE = "Enable auto join";
SS_UI_JOIN_TIMEOUT = "Seconds before auto joining";
SS_UI_JOIN_BG = "Join inside a battleground";
SS_UI_JOIN_AFK = "Join AFK";
SS_UI_JOIN_INSTANCE = "Join inside an instance";
SS_UI_JOIN_GATHERING = "Join while gathering";
SS_UI_JOIN_WINDOW = "Disable auto join if the window is hidden";

-- General
SS_UI_GENERAL_ENABLE = "Enable SSPVP";
SS_UI_GENERAL_SOUND = "File to play when queue is ready";
SS_UI_GENERAL_GOSSIP = "Skip battlemaster gossip";
SS_UI_GENERAL_MINIMAP = "Open minimap on zone in";
SS_UI_GENERAL_RELEASE = "Auto release on death";
SS_UI_GENERAL_CHANNELS = "Battleground channels";
SS_UI_GENERAL_FLAGUI = "Warsong Gulch Flag UI";
SS_UI_GENERAL_KILLINGBLOW = "SCT Killing Blow Alert";
SS_UI_GENERAL_KILLINGBLOWCOLOR = "Killing Blow Text Color";

-- SSOverlay
SS_UI_OVERLAY_ENABLE = "Enable Overlay";
SS_UI_OVERLAY_AV = "Alterac Valley Overlay";
SS_UI_OVERLAY_AB = "Arathi Basin Overlay";
SS_UI_OVERLAY_QUEUE = "Battlefield queue status overlay";
SS_UI_OVERLAY_LOCK = "Lock Overlay, cannot be moved or resized";
SS_UI_OVERLAY_COLOR = "Background color";
SS_UI_OVERLAY_BORDERCOLOR = "Border color";
SS_UI_OVERLAY_TEXTCOLOR = "Text Color";

-- SSInvite


-- Misc stuff
SS_UI_ADDNAME = "Enter a players name to accept invites from.";
SS_UI_EDITNAME = "Edit a players name to accept invites from.";

SS_UI_ADDCHANNEL = "Enter a channel name to join when inside a battleground.";
SS_UI_EDITCHANNEL = "Edit a channel name to join when inside a battleground.";

SS_UI_PLAYER_NAMES = "Player Names";
SS_UI_CHANNEL_NAMES = "Channel Names";

SS_UI_ADD = "Add";
SS_UI_EDIT = "Edit";
SS_UI_DEL = "Del";

SS_UI_PLAY = "Play";
SS_UI_STOP = "Stop";

SS_UI_CLOSE = "Close";

-- "GENERIC" TOOLTIPS
SS_UI_INTERVALS_TOOLTIP = "Alerts how many seconds are remaining to your chat window for %s, alert frequency depends on what you set the interval to.";
SS_UI_ALERTTYPE_TOOLTIP = "Will display alerts triggered by the %s like somebody capturing a resource.";
SS_UI_SECCAPTURED_TOOLTIP = "Displays how many seconds before a resource is captured.";

-- SSINVITE TOOLTIPS
SS_UI_INVITEALERT_CHAN_TOOLTIP = "Channel to broadcast that invites are coming to.";

-- ARATHI BASIN TOOLTIPS
SS_UI_AB_ENABLE_TOOLTIP = string.format( SS_UI_INTERVALS_TOOLTIP, SS_ARATHIBASIN );
SS_UI_AB_ALLIANCE_TOOLTIP = string.format( SS_UI_ALERTTYPE_TOOLTIP, SS_ALLIANCE );
SS_UI_AB_HORDE_TOOLTIP = string.format( SS_UI_ALERTTYPE_TOOLTIP, SS_HORDE );

-- ALTERAC VALLEY TOOLTIPS
SS_UI_AV_ENABLE_TOOLTIP = string.format( SS_UI_INTERVALS_TOOLTIP, SS_ALTERACVALLEY );
SS_UI_AV_ALLIANCE_TOOLTIP = string.format( SS_UI_ALERTTYPE_TOOLTIP, SS_ALLIANCE );
SS_UI_AV_HORDE_TOOLTIP = string.format( SS_UI_ALERTTYPE_TOOLTIP, SS_HORDE );

-- MINIMAP TOOLTIPS
SS_UI_MAP_TEAM_TOOLTIP = "Displays your allies on the battlefield minimap.";
SS_UI_MAP_RESET_TOOLTIP = "Resets the minimaps position to something on the screen, useful if you accidently dragged it off.";
SS_UI_MAP_TOGGLE_TOOLTIP = "Lets you view/use the battlefield minimap without being in a battleground.";
SS_UI_MAP_LOCK_TOOLTIP = SS_UI_MAP_LOCK;

-- AUTO ACCEPT INVITE TOOLTIPS
SS_UI_INVITE_ACCEPT_TOOLTIP = "List of players that you will automatically accept invites from.";
SS_UI_INVITE_FRIENDS_TOOLTIP = "Will accept all invites from people on your friends list.";
SS_UI_INVITE_BATTLEGROUND_TOOLTIP = "Will accept all invites from people inside the battleground with you.";

-- AUTO LEAVE TOOLTIPS
SS_UI_LEAVE_ENABLE_TOOLTIP = SS_UI_LEAVE_ENABLE;
SS_UI_LEAVE_TIMEOUT_TOOLTIP = SS_UI_LEAVE_TIMEOUT;
SS_UI_LEAVE_GROUP_TOOLTIP = SS_UI_LEAVE_GROUP;

-- AUTO JOIN TOOLTIPS
SS_UI_JOIN_GATHERING_TOOLTIP = "Useful if you don't want to auto join if you're in the middle of picking a herb or mining, will delay auto join by 10 seconds while you're picking or mining.";
SS_UI_JOIN_WINDOW_TOOLTIP = "Useful if you're in the middle of something and need some more time before joining the battleground. You will have to manually join if you hide the window after the auto join timeout has passed.";
SS_UI_JOIN_ENABLE_TOOLTIP = SS_UI_JOIN_ENABLE;
SS_UI_JOIN_TIMEOUT_TOOLTIP = SS_UI_JOIN_TIMEOUT;
SS_UI_JOIN_BG_TOOLTIP = SS_UI_JOIN_BG;
SS_UI_JOIN_AFK_TOOLTIP = SS_UI_JOIN_AFK;
SS_UI_JOIN_INSTANCE_TOOLTIP = SS_UI_JOIN_INSTANCE;

-- GENERAL TOOLTIPS
SS_UI_GENERAL_SOUND_TOOLTIP = "Sound file to play when you can enter a battleground.";
SS_UI_GENERAL_MINIMAP_TOOLTIP = "Opens the battlefield minimap when you enter a battleground.";
SS_UI_GENERAL_CHANNELS_TOOLTIP = "List of channels you want to join while inside a battleground, but not while you are outside one.";
SS_UI_GENERAL_FLAGUI_TOOLTIP = "Displays who has the Horde flag and who has the Alliance flag next to the Warsong Gulch scores.";
SS_UI_GENERAL_KILLINGBLOW_TOOLTIP = "Displays when you get a Killing Blow while inside a battleground through Scrolling Combat Text. \n\nScrolling Combat Text is REQUIRED for this.";
SS_UI_GENERAL_ENABLE_TOOLTIP = SS_UI_GENERAL_ENABLE;
SS_UI_GENERAL_GOSSIP_TOOLTIP = SS_UI_GENERAL_GOSSIP;
SS_UI_GENERAL_RELEASE_TOOLTIP = SS_UI_GENERAL_RELEASE;
SS_UI_GENERAL_KILLINGBLOWCOLOR_TOOLTIP = SS_UI_GENERAL_KILLINGBLOWCOLOR;

-- SSOVERLAY TOOLTIPS
SS_UI_OVERLAY_QUEUE_TOOLTIP = "Displays the status of your battleground queues, if a queue is ready to join it will also display how many seconds before you auto join.";
SS_UI_OVERLAY_ENABLE_TOOLTIP = SS_UI_OVERLAY_ENABLE;
SS_UI_OVERLAY_AV_TOOLTIP = SS_UI_SECCAPTURED_TOOLTIP;
SS_UI_OVERLAY_AB_TOOLTIP = SS_UI_SECCAPTURED_TOOLTIP;
SS_UI_OVERLAY_LOCK_TOOLTIP = SS_UI_OVERLAY_LOCK;
SS_UI_OVERLAY_COLOR_TOOLTIP = SS_UI_OVERLAY_COLOR;
SS_UI_OVERLAY_BORDERCOLOR_TOOLTIP = SS_UI_OVERLAY_BORDERCOLOR;
SS_UI_OVERLAY_TEXTCOLOR_TOOLTIP = SS_UI_OVERLAY_TEXTCOLOR;