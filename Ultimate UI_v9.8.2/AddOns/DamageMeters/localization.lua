--[[
--
--	DamageMeters Localization Data (ENGLISH)
--
--]]

-- General --
DamageMeters_PRINTCOLOR = "|cFF8F8FFF"

-- Bindings --
BINDING_HEADER_DAMAGEMETERSHEADER 		= "DamageMeters";
BINDING_NAME_DAMAGEMETERS_TOGGLESHOW	= "Toggle Visible";
BINDING_NAME_DAMAGEMETERS_CYCLEQUANT	= "Cycle Visible Quantity";
BINDING_NAME_DAMAGEMETERS_CYCLEQUANTBACK= "Cycle Visible Quantity Backwards";
BINDING_NAME_DAMAGEMETERS_CLEAR			= "Clear Data";
BINDING_NAME_DAMAGEMETERS_TOGGLEPAUSED	= "Toggle Paused";
BINDING_NAME_DAMAGEMETERS_SHOWREPORTFRAME = "Show Report Frame";
BINDING_NAME_DAMAGEMETERS_SWAPMEMORY	= "Swap Memory";
BINDING_NAME_DAMAGEMETERS_TOGGLESHOWMAX	= "Toggle Show Max Bars";
BINDING_NAME_DAMAGEMETERS_SYNCREADY		= "Send Sync Ready";
BINDING_NAME_DAMAGEMETERS_TOGGLESHOWFIGHTASPS = "Toggle Show Fight Data As Per/Second";
BINDING_NAME_DAMAGEMETERS_TOGGLENORMALANDFIGHT = "Toggle Between Normal and Fight Quantities";
BINDING_NAME_DAMAGEMETERS_TOGGLEMINIMODE = "Toggle Mini Mode";
BINDING_NAME_DAMAGEMETERS_SYNCPAUSE = "Sync Pause";
BINDING_NAME_DAMAGEMETERS_SYNCUNPAUSE = "Sync Unpause";
BINDING_NAME_DAMAGEMETERS_SYNCCLEAR = "Sync Clear";
BINDING_NAME_DAMAGEMETERS_THREAT_SETTARGETANDCLEAR = "Threat Set Target And Clear";

--[[ work in progress
-- command, function, help string
DM_HELPDEF = {
	-- Main commands.
	{ "help", DamageMeters_Help, DM_CMD_HELP },
	{ "cmd", DamageMeters_ListCommands, DM_CMD_CMD },
	{ "version", DamageMeters_ShowVersion, DM_CMD_VERSION },
	{ "show", DamageMeters_ToggleShow, DM_CMD_SHOW },
	{ "hide", DamageMeters_Hide, DM_CMD_HIDE },
	{ "clear", DamageMeters_Clear, DM_CMD_CLEAR },
	{ "report", DamageMeters_Report, DM_CMD_REPORT },
	{ "sort", DamageMeters_SetSort, DM_CMD_SORT },
	{ "count", DamageMeters_SetCount, DM_CMD_SETCOUNT },
	{ "autocount", DamageMeters_SetAutoCount, DM_CMD_AUTOCOUNT },
	{ "lock", DamageMeters_ToggleLock, DM_CMD_LOCK },
	{ "pause", DamageMeters_TogglePause, DM_CMD_PAUSE },
	{ "ready", DamageMeters_SetReady, DM_CMD_READY },
	{ "resetpos", DamageMeters_ResetPos, DM_CMD_RESETPOS },
	{ "pop", DamageMeters_Populate, DM_CMD_POP },
	{ "listbanned", DamageMeters_ListBanned, DM_CMD_LISTBANNED },
	{ "clearbanned", DamageMeters_ClearBanned, DM_CMD_CLEARBANNED },

	-- Memory
	{ "save", DamageMeters_Save, DM_CMD_SAVE },
	{ "restore", DamageMeters_Restore, DM_CMD_RESTORE },
	{ "swap", DamageMeters_Swap, DM_CMD_SWAP },
	{ "memclear", DamageMeters_MemClear, DM_CMD_MEMCLEAR },

	-- These all have menu options.
	{ "color", DamageMeters_SetColorScheme, DM_CMD_COLOR },
	{ "quant", DamageMeters_SetQuantity, DM_CMD_QUANT },
	{ "text", DamageMeters_SetTextOptions, DM_CMD_TEXT },
	{ "visinparty", DamageMeters_SetVisibleInParty, DM_CMD_VISINPARTY },
	{ "lockpos", DamageMeters_ToggleLockPos, DM_CMD_LOCKPAUSE },
	{ "grouponly", DamageMeters_ToggleGroupMembersOnly, DM_CMD_GROUPONLY },
	{ "addpettoplayer", DamageMeters_ToggleAddPetToPlayer, DM_CMD_ADDPETTOPLAYER },
	{ "resetoncombat", DamageMeters_ToggleResetWhenCombatStarts, DM_CMD_RESETONCOMBAT },
	{ "total", DamageMeters_ToggleTotal, DM_CMD_TOTAL },
	{ "showmax", DamageMeters_ToggleMaxBars, DM_CMD_SHOWMAX },	

	-- Sync commands.
	{ "sync", DamageMeters_Sync, DM_CMD_SYNC },
	{ "syncchan", DamageMeters_SyncChan, DM_CMD_SYNCCHAN },
	{ "syncleave", DamageMeters_SyncLeaveChanCmd, DM_CMD_SYNCLEAVE },
	{ "syncsend", DamageMeters_SyncReport, DM_CMD_SYNCSEND },
	{ "syncrequest", DamageMeters_SyncRequest, DM_CMD_SYNCREQUEST },
	{ "syncclear", DamageMeters_SyncClear, DM_CMD_SYNCCLEAR },
	{ "syncmsg", DamageMeters_SendSyncMsg, DM_CMD_SYNCMSG },
	{ "syncbroadcastchan", DamageMeters_SyncBroadcastChan, DM_CMD_SYNCBROADCASTCHAN },
	{ "syncping", DamageMeters_SyncPingRequest, DM_CMD_SYNCPING },
	{ "syncpause", DamageMeters_SyncPause, DM_CMD_SYNCPAUSE },
	{ "syncunpause", DamageMeters_SyncUnpause, DM_CMD_SYNCUNPAUSE },
	{ "syncready", DamageMeters_SyncReady, DM_CMD_SYNCREADY },
	{ "synckick", DamageMeters_SyncKick, DM_CMD_SYNCKICK },
	{ "synclabel", DamageMeters_SyncLabel, DM_CMD_SYNCLABEL },
	{ "syncstart", DamageMeters_SyncStart, DM_CMD_SYNCSTART },
	{ "synchalt", DamageMeters_SyncHalt, DM_CMD_SYNCHALT },
	{ "synce", DamageMeters_SyncEmote, DM_CMD_SYNCEMOTE },

	-- Debug commands.
	{ "reset", DamageMeters_Reset, DM_CMD_RESET },
	{ "test", DamageMeters_Test, DM_CMD_TEST },
	{ "add", DamageMeters_Add, DM_CMD_ADD },
	{ "dumptable", DamageMeters_DumpTable, DM_CMD_DUMPTABLE },
	{ "debug", DM_ToggleDMPrintD, DM_CMD_DEBUG },
	{ "dumpmsg", DM_DumpMsg, DM_CMD_DUMPMSG },
	{ "print", DM_ConsolePrint, DM_CMD_PRINT },
};
]]--

-- Help --
DamageMeters_helpTable = {
		"The following commands can be entered into the console:",
		"/dmhelp : Gives help on using DamageMeters.",
		"/dmcmd : Lists available /dm (DamageMeters) commands.",
		"/dmshow : Toggles whether or not the meters are visible.  Note that data collection continues when meters are not visible.",
		"/dmhide : Hides the meters.",
		"/dmclear [#] : Removes entries from the bottom of the list, leaving #.  If # not specified, entire list is cleared.",
		"/dmreport [help] [total] [c/s/p/r/w/h/g/f[#]] [whispertarget/channelNAME] - Prints a report of the current data: use '/dmreport help' for details.",
		"/dmsort [#] - Sets sorting style.  Specify no number for a list of available styles.",
		"/dmcount [#] - Sets number of bars visible at once.  If # not given shows the maximum possible.",
		"/dmsave - Saves the current table internally.",
		"/dmrestore - Restores a previously saved table, overwriting any new data.",
		--"/dmmerge - Merges a previously saved table with any existing data.",
		"/dmswap - Swaps the previously saved table with the current one.",
		"/dmmemclear - Clears the saved table.",
		"/dmresetpos - Resets the position of the window (helpful incase you lose it)%.",
		"/dmtext 0/<[r][n][p][l][v]> - Sets what text should be shown on the bars. r - Rank. n - Player name. p - Percentage of total. l - Percentage of leader. v - Value.",
		"/dmcolor # - Sets the color scheme for the bars.  Specify no # for a list of options.",
		"/dmquant # - Sets the quantity the bars should use.  Specify no # for a list of options.",
		"/dmvisinparty [y/n] - Sets whether or not the window should only be visible while you are in a party/raid.  Specify no argument to toggle.",
		"/dmautocount # - If # is greater than zero, then the window will show as many bars as it has information for up to #.  If # is zero, it turns off the auto-count function.",
		"/dmlistbanned - Lists all banned entities.",
		"/dmclearbanned - Clears list of all banned entities.",

		"/dmsync [d#] [e] - Causes you to synchronize your data with other users using the same sync channel.  (Calls dmsyncsend and dmsyncrequest.)  If d specified, the sync will be delayed that many seconds.  If e specified, event data will be sent/requested.",
		"/dmsyncchan - Sets the name of the channel to use for synchronizing.",
		"/dmsyncleave - Leaves the current sync chan.",
		"/dmsyncsend - Sends sync information on the sync channel.",
		"/dmsyncrequest - Sends request for an automatic dmsync to other people using your sync channel.",
		"/dmsyncclear - Sends request for everyone to clear their data.",
		"/dmsyncmsg msg - Sends a message to other people in the same syncchan.  Can also use /dmm.",
		"/dmsyncbroadcastchan - Broadcasts the current sync channel to your party or raid.  Can also use /dmsyncb.",
		"/dmsyncping - 'Pings' the other people in the sync chan, causing them to respond with their current version of DM.",
		"/dmsyncpause - Makes other DMs on your syncchan pause.",
		"/dmsyncunpause - Makes other DMs on your syncchan unpause.",
		"/dmsyncready - Transmits a command to make everyone in the sync chan go into the ready state.",
		"/dmsynckick player - Kickes player out of the sync channel.",
		"/dmsynclabel label - Labels the current session. (Index defaults to 1).",
		"/dmsyncstart label - Convenience function which does dmsynclabel, dmsyncpause, and dmsyncclear automatically.",
		"/dmsynchalt - Aborts any syncing in progress (clears incoming and outgoing message queues).",

		"/dmpop - Populates it with your current party/raid members (though will not remove any existing entries)%.",
		"/dmlock - Toggles whether or not the list is locked. New people cannot be added to a locked list, but people already in can are updated.",
		"/dmpause - Toggles whether or not the parsing of data is to occur.",
		"/dmlockpos - Toggles whether or not the position of the window is locked.",
		"/dmgrouponly - Toggles whether or not to reject anyone who is not in your raid/party.  (Your pet will be monitored regardless of this setting.)",
		"/dmaddpettoplayer - Toggles whether or not to consider pet's data as coming directly from the player.",
		"/dmresetoncombat = Toggles whether or not to reset data when combat starts.",
		"/dmversion - Shows version information.",
		"/dmtotal - Toggles display of the total display.",
		"/dmshowmax - Toggles whether or not to show the max number of bars.",
};

-- Filters --
DamageMeters_Filter_STRING1 = "party members";
DamageMeters_Filter_STRING2 = "all friendly characters";

-- Relationships --
DamageMeters_Relation_STRING = {
		"Self",
		"Your Pet",
		"Party",
		"Friendly"};

-- Color Schemes -- 
DamageMeters_colorScheme_STRING = {
		"Relationship",
		"Class Colors"};

-- Quantities -- 
DM_QUANTSTRING_DAMAGEDONE = "Damage Done";
DM_QUANTSTRING_HEALINGDONE = "Healing Done";
DM_QUANTSTRING_DAMAGETAKEN = "Damage Taken";
DM_QUANTSTRING_HEALINGTAKEN = "Healing Taken";
DM_QUANTSTRING_DAMAGEDONE_FIGHT = "Fight Damage Done";
DM_QUANTSTRING_HEALINGDONE_FIGHT = "Fight Healing Done";
DM_QUANTSTRING_DAMAGETAKEN_FIGHT = "Fight Damage Taken";
DM_QUANTSTRING_HEALINGTAKEN_FIGHT = "Fight Healing Taken";
DM_QUANTSTRING_DAMAGEDONE_PS = "DPS";
DM_QUANTSTRING_HEALINGDONE_PS = "HPS";
DM_QUANTSTRING_DAMAGETAKEN_PS = "DTPS";
DM_QUANTSTRING_HEALINGTAKEN_PS = "HTPS";
DM_QUANTSTRING_IDLETIME = "Idle Time";
DM_QUANTSTRING_NETDAMAGE = "Net Damage";
DM_QUANTSTRING_NETHEALING = "Net Healing";
DM_QUANTSTRING_DAMAGEPLUSHEALING = "Damage+Healing";
DM_QUANTSTRING_CURING = "Curing Done";
DM_QUANTSTRING_CURING_FIGHT = "Fight Curing Done";
DM_QUANTSTRING_CURING_PS = "Cures PS";
DM_QUANTSTRING_DANDERATING = "Dande-Rating";
-- Threat DM_QUANTSTRING_THREAT = "Threat";

DMI_NAMES = {
	DM_QUANTSTRING_DAMAGEDONE,
	DM_QUANTSTRING_HEALINGDONE,
	DM_QUANTSTRING_DAMAGETAKEN,
	DM_QUANTSTRING_HEALINGTAKEN,
	DM_QUANTSTRING_CURING,
	-- Threat DM_QUANTSTRING_THREAT
};

-- Sort --
DamageMeters_Sort_STRING = {
		"Decreasing", 
		"Increasing",
		"Alphabetical"};

-- Class Names
function DamageMeters_GetClassColor(className)
	return RAID_CLASS_COLORS[string.upper(className)];
end

-- Damage type constants.
DM_DMGTYPE_ARCANE = 1;
DM_DMGTYPE_FIRE = 2;
DM_DMGTYPE_NATURE = 3;
DM_DMGTYPE_FROST = 4;
DM_DMGTYPE_SHADOW = 5;
DM_DMGTYPE_RESISTMAX = 5;

DM_DMGTYPE_HOLY = 6;
DM_DMGTYPE_PHYSICAL = 7;
DM_DMGTYPE_DEFAULT = 8;

DM_DMGNAMETOID = {
	Arcane = DM_DMGTYPE_ARCANE,
	Fire = DM_DMGTYPE_FIRE,
	Nature = DM_DMGTYPE_NATURE,
	Frost = DM_DMGTYPE_FROST,
	Shadow = DM_DMGTYPE_SHADOW,
	Holy = DM_DMGTYPE_HOLY,
	Physical = DM_DMGTYPE_PHYSICAL,
};

DM_DMGTYPENAMES = {
	"Arcane",
	"Fire",
	"Nature",
	"Frost",
	"Shadow",
	"Holy",
	"Physical",
	"Default",
};

-- Errors --
DM_ERROR_INVALIDARG = "DamageMeters: Invalid argument(s).";
DM_ERROR_MISSINGARG = "DamageMeters: Argument(s) missing.";
DM_ERROR_NOSAVEDTABLE = "DamageMeters: No saved table.";
DM_ERROR_BADREPORTTARGET = "DamageMeters: Invalid report target = ";
DM_ERROR_MISSINGWHISPERTARGET = "DamageMeters: Whisper specified but no player given.";
DM_ERROR_MISSINGCHANNEL = "DamageMeters: Channel specified but no number given.";
DM_ERROR_NOSYNCCHANNEL = "DamageMeters: Sync channel must be specified with dmsyncchan before calling sync functions.";
DM_ERROR_JOINSYNCCHANNEL = "DamageMeters: You must join sync channel ('%s') before you can call sync functions.";
DM_ERROR_SYNCTOOSOON = "DamageMeters: Sync request too soon after last one; ignoring.";
DM_ERROR_POPNOPARTY = "DamageMeters: Cannot populate table; you are not in a party or raid.";
DM_ERROR_NOROOMFORPLAYER = "DamageMeters: Cannot merge pet data with players because cannot add player to list (list full?).";
DM_ERROR_BROADCASTNOGROUP = "DamageMeters: Must be in a party or raid to broadcast the sync channel.";
DM_ERROR_NOPARTY = "DamageMeters: You are not in a party.";
DM_ERROR_NORAID = "DamageMeters: You are not in a raid.";

-- Messages --
DM_MSG_SETQUANT = "DamageMeters: Setting visible quantity to ";
DM_MSG_CURRENTQUANT = "DamageMeters: Current quantity = ";
DM_MSG_CURRENTSORT = "DamageMeters: Current sort = ";
DM_MSG_SORT = "DamageMeters: Setting sort to ";
DM_MSG_CLEAR = "DamageMeters: Removing entries %d to %d.";
--DM_MSG_REMAINING = "DamageMeters: %d items remaining.";
DM_MSG_REPORTHEADER = "DamageMeters: <%s> report on %d/%d sources:";
DM_MSG_PLAYERREPORTHEADER = "DamageMeters: Player report on %s:";
DM_MSG_SETCOUNTTOMAX = "DamageMeters: No count argument specified, setting to max.";
DM_MSG_SETCOUNT = "DamageMeters: New bar count = ";
DM_MSG_RESETFRAMEPOS = "DamageMeters: Resetting frame position.";
DM_MSG_SAVE = "DamageMeters: Saving table.";
DM_MSG_RESTORE = "DamageMeters: Restoring saved table.";
DM_MSG_MERGE = "DamageMeters: Merging saved table with current.";
DM_MSG_SWAP = "DamageMeters: Swapping normal (%d) and saved (%d) table.";
DM_MSG_SETCOLORSCHEME = "DamageMeters: Setting color scheme to ";
DM_MSG_TRUE = "true";
DM_MSG_FALSE = "false";
DM_MSG_SETVISINPARTY = "DamageMeters: Visible-only-in-party is set to ";
DM_MSG_SETAUTOCOUNT = "DamageMeters: Setting new autocount limit to ";
DM_MSG_LISTBANNED = "DamageMeters: Listing banned entities:";
DM_MSG_CLEARBANNED = "DamageMeters: Clearing all banned entities.";
DM_MSG_HOWTOSHOW = "DamageMeters: Hiding window.  Use /dmshow to make it visible again.";
DM_MSG_SYNCCHAN = "DamageMeters: Synchronization channel name set to ";
DM_MSG_SYNCREQUESTACK = "DamageMeters: Sync requested from player ";
DM_MSG_SYNCREQUESTACKEVENTS = "DamageMeters: Sync (with events) requested from player ";
DM_MSG_SYNC = "DamageMeters: Sending sync data.";
DM_MSG_SYNCEVENTS = "DamageMeters: Sending sync data (with events).";
DM_MSG_LOCKED = "DamageMeters: List now locked.";
DM_MSG_NOTLOCKED = "DamageMeters: List unlocked.";
DM_MSG_PAUSED = "DamageMeters: Parsing paused.";
DM_MSG_UNPAUSED = "DamageMeters: Parsing resumed.";
DM_MSG_POSLOCKED = "DamageMeters: Position locked.";
DM_MSG_POSNOTLOCKED = "DamageMeters: Position unlocked.";
DM_MSG_CLEARRECEIVED = "DamageMeters: Clear request received from player ";
DM_MSG_ADDINGPETTOPLAYER = "DamageMeters: Now treating pet data as though it was yours.";
DM_MSG_NOTADDINGPETTOPLAYER = "DamageMeters: Pet data now treated separately from yours.";
DM_MSG_PETMERGE = "DamageMeters: Merging pet's (%s) information into your's.";
DM_MSG_RESETWHENCOMBATSTARTSCHANGE = "DamageMeters: Reset when combat starts = ";
DM_MSG_SHOWFIGHTASPS = "DamageMeters: Showing fight data as per/second = ";
DM_MSG_COMBATDURATION = "Combat duration = %.2f seconds.";
DM_MSG_RECEIVEDSYNCDATA = "DamageMeters: Receiving Sync data from %s.";
DM_MSG_TOTAL = "TOTAL";
DM_MSG_VERSION = "DamageMeters Version %s Active.";
DM_MSG_REPORTHELP = "The /dmreport command consists of three parts:\n\n1) The destination character.  This can be one of the following letters:\n  c - Console (only you can see it)%.\n  s - Say\n  p - Party chat\n  r - Raid chat\n  g - Guild chat\n  o - Guild Officer chat\n  h - Chat cHannel. /dmreport h mychannel\n  w - Whisper to player.  /dmreport w dandelion\n  f - Frame: Shows the report in this window.\n\nIf the letter is lower case the report will be in reverse order (lowest to highest)%.\n\n2) Optionally, the number of people to limit it to.  This number goes right after the destination character.\nExample: /dmreport p5.\n\n3) By default, reports are on the currently visible quantity only.  If the word 'total' is specified before the destination character, though, the report will be on the totals for every quantity. 'Total' reports are formatted so that they look good when cut-and-paste into a text file, and so work best with the Frame destination.\nExample: /dmreport total f\n\nExample: Whisper to player 'dandelion' the top three people in the list:\n/dmreport w3 dandelion";
DM_MSG_COLLECTORS = "Data collectors: (%s)";
DM_MSG_ACCUMULATING = "DamageMeters: Accumulating data in memory register.";
DM_MSG_REPORTTOTALDPS = "Total = %.1f (%.1f visible)";
DM_MSG_REPORTTOTAL = "Total = %d (%d visible)";
DM_MSG_SYNCMSG = "[DMM] |Hplayer:%s|h[%s]|h: %s";
DM_MSG_MEMCLEAR = "DamageMeters: Saved table cleared.";
DM_MSG_MAXBARS = "DamageMeters: Setting show-max-bars to %s.";
DM_MSG_MINBARS = "DamageMeters: Setting minimized to %s.";
DM_MSG_LEADERREPORTHEADER = "DamageMeters: Leaders Report on %d/%d Sources:\n #";
DM_MSG_FULLREPORTHEADER = "DamageMeters: Full Report on %d/%d Sources:\nPlayer        Damage     Healing     Damaged      Healed        Hits   Crits\n_______________________________________________________________________________";
DM_MSG_CLEARACKNOWLEDGED = "DamageMeters: Clear acknowledged from player %s.";
DM_MSG_EVENTREPORTHEADER = "DamageMeters: Event report on %d/%d sources:\n";
DM_MSG_PLAYERONLYEVENTDATAOFF = "DamageMeters: Recording all player's event data.";
DM_MSG_PLAYERONLYEVENTDATAON = "DamageMeters: Now recording only your own event data.";
DM_MSG_SYNCCHANBROADCAST = "<DamageMeters>: Setting this group's sync channel to: ";
DM_MSG_SYNCINGROUPON = "DamageMeters: You will now only sync with group members.";
DM_MSG_SYNCINGROUPOFF = "DamageMeters: You can now sync with anyone.";
DM_MSG_AUTOSYNCJOINON = "DamageMeters: You will automatically join broadcasted sync channels.";
DM_MSG_AUTOSYNCJOINOFF = "DamageMeters: You will no longer automatically join broadcasted sync channels.";
DM_MSG_SYNCHELP = "DamageMeters Sync'ing (short for synchronization) is a process whereby multiple DM users can transmit their data to each other.  Its primary use is for instances where the players are often far from each other and thus miss some of each other's combat messages.\n\nSync Quick-Start Guide:\n\n1) Someone (I'll call her the Sync Leader) chooses a channel name and joins it, ie. /dmsyncchan ourchannel.\n2) The Sync Leader then calls /dmsyncbroadcastchan (or just /dmsyncb).  Anyone who is running a sufficiently recent version of DM will automatically be joined into that channel.\n3) The Sync Leader choses a name for the session--for example, Onyxia-- then calls /dmsyncstart with that name. (/dmsyncstart Onyxia_.  This will clear everyone's data and pause them, as well as mark them with this label.\n3) Once everyone is in the channel, but before the activity begins, the Sync  Leader should call /dmsyncready or /dmsyncunpause so that data collection can happen.\n4) Play!  Collect data!\n5) Finally, the Sync Leader calls /dmsync whenever she wants the raid to share data.  Since it can cause a little slowdown it is best to do this between fights (though not necessarily between every fight).  If event data is desired, call (/dmsync e), though it takes a lot longer to sync.\n\nNote: There is nothing special about the Sync Leader: any player can perform any of these commands.  It just seems simpler to have one person in charge of it.";
DM_MSG_PINGING = "DamageMeters: Pinging other players...";
DM_MSG_SYNCONLYPLAYEREVENTSON = "DamageMeters: Only your event information will be transmitted.";
DM_MSG_SYNCONLYPLAYEREVENTSOFF = "DamageMeters: All player's event information will be transmitted.";
DM_MSG_SYNCPAUSE = "DamageMeters: Pause command recieved from %s.";
DM_MSG_SYNCUNPAUSE = "DamageMeters: Unpause command recieved from %s.";
DM_MSG_SYNCREADY = "DamageMeters: Ready command recieved from %s.";
DM_MSG_SYNCPAUSEREQ = "DamageMeters: Transmitting pause command...";
DM_MSG_SYNCUNPAUSEREQ = "DamageMeters: Transmitting unpause command...";
DM_MSG_SYNCREADYREQ = "DamageMeters: Transmitting ready command...";
DM_MSG_PRESSCONTROLEVENT = "Press Control To See Event Data";
DM_MSG_PRESSCONTROLQUANTITY = "Press Control To See Quantity Data";
DM_MSG_PRESSALTSINGLEQUANTITY = "Press Alt To See Only Current Quantity";
DM_MSG_PAUSEDTITLE = "Paused";
DM_MSG_READYTITLE = "Ready";
DM_MSG_EVENTDATALEVEL = {
	"DamageMeters: Parsing no event data.",
	"DamageMeters: Parsing player's event data only.",
	"DamageMeters: Parsing all players' event data."
};
DM_MSG_SYNCEVENTDATALEVEL = {
	"DamageMeters: Transmitting no event data.",
	"DamageMeters: Transmitting player's event data only.",
	"DamageMeters: Transmitting all players' event data."
};
DM_MSG_HELP = "- Enter /dmcmd for a list of commands.\n- If you cannot see the DM window, try /dmresetpos.";
DM_MSG_LEAVECHAN = "DamageMeters: Leaving sync channel '%s'.";
DM_MSG_READYUNPAUSING = "DamageMeters: Damage event received, transmitting sync unpause command...";
DM_MSG_KICKED = "DamageMeters: You have been removed from the sync channel by %s.";
DM_MSG_SETLABEL = "DamageMeters: Session label set to <%s>. (Index = %d)";
DM_MSG_SESSIONMISMATCH = "DamageMeters: Sync received with different session information.  Auto-clearing.";
DM_MSG_SHOWINGFIGHTEVENTSONLY = "Showing events for current fight only.";
DM_MSG_SYNCCLEARREQ = "DamageMeters: Transmitting clear request...";
DM_MSG_CURRENTBARWIDTH = "DamageMeters: Current bar width = %d.\nCall (/dmsetbarwidth default) to reset.";
DM_MSG_NEWBARWIDTH = "DamageMeters: New bar width = %d.";
DM_MSG_PLAYERJOINEDSYNCCHAN = "DamageMeters: Player %s joined sync channel. [Version %s]";
DM_MSG_SYNCSESSIONMISMATCH = "Player %s's session (%s:%d) mismatched: Player's data cleared.";
DM_MSG_SYNCHALTRECEIVED = "DamageMeters: Sync Halt command received from %s.";
DM_MSG_SYNCHALTSENT = "DamageMeters: Transmitting halt command...";
-- Threat DM_MSG_TARGETACKNOWLEDGED = "ThreatMeters: Target acknowledged by %s.";
-- RPS
DM_MSG_RPS_CHALLENGE = "You challenge %s to Rock-Paper Scissors!  You play %s.";
DM_MSG_RPS_CHALLENGED = "%s has challenged you to Rock-Paper-Scissors!  Use /dmrpsr [player] [r/p/s] to respond.";
DM_MSG_RPS_MISSING_PLAYER = "ERROR: Missing Arg.  Player argument can be omitted if and only if there is only one player currently challenging you.";
DM_MSG_RPS_NOTCHALLENGED = "Error: You were not challenged by %s.";
DM_MSG_RPS_YOUPLAY = "You play %s.";
DM_MSG_RPS_PLAYS = "%s plays %s.";
DM_MSG_RPS_DEFEATED = "%s has defeated you.";
DM_MSG_RPS_VICTORIOUS = "You have defeated %s!"
DM_MSG_RPS_TIE = "You have tied with %s.";

--[[ Note: This is only to help construct the DM_MSG_REPORTHELP string.
The /dmreport command consists of three parts:

1) The destination character.  This can be one of the following letters:
  c - Console (only you can see it)%.
  s - Say
  p - Party chat
  r - Raid chat
  g - Guild chat
  h - Chat cHannel. /dmreport h mychannel
  w - Whisper to player.  /dmreport w dandelion
  f - Frame: Shows the report in this window.

If the letter is lower case the report will be in reverse order (lowest to highest)%.

2) Optionally, the number of people to limit it to.  This number goes right after the destination character.
Example: /dmreport p5

3) By default, reports are on the currently visible quantity only.  If the word 'total' is specified before the destination character, though, the report will be on the totals for every quantity. 'Total' reports are formatted so that they look good when cut-and-paste into a text file, and so work best with the Frame destination.
Example: /dmreport total f

Example: Whisper to player "dandelion" the top three people in the list:
/dmreport w3 dandelion
]]--

--[[ Note: This is only to help construct the DM_MSG_SYNCHELP string.
DamageMeters Sync'ing (short for synchronization) is a process whereby multiple DM users can transmit their data to each other.  Its primary use is for instances where the players are often far from each other and thus miss some of each other's combat messages.\n\nSync Quick-Start Guide:\n\n1) Someone (I'll call her the Sync Leader) chooses a channel name and joins it, ie. /dmsyncchan ourchannel.\n2) The Sync Leader then calls /dmsyncbroadcastchan (or just /dmsyncb).  Anyone who is running a sufficiently recent version of DM will automatically be joined into that channel.\n3) The Sync Leader choses a name for the session--for example, Onyxia-- then calls /dmsyncstart with that name. (/dmsyncstart Onyxia_.  This will clear everyone's data and pause them, as well as mark them with this label.\n3) Once everyone is in the channel, but before the activity begins, the Sync  Leader should call /dmsyncready or /dmsyncunpause so that data collection can happen.\n4) Play!  Collect data!\n5) Finally, the Sync Leader calls /dmsync whenever she wants the raid to share data.  Since it can cause a little slowdown it is best to do this between fights (though not necessarily between every fight).  If event data is desired, call (/dmsync e), though it takes a lot longer to sync.\n\nNote: There is nothing special about the Sync Leader: any player can perform any of these commands.  It just seems simpler to have one person in charge of it.
]]--

-- Menu Options --
DM_MENU_CLEAR = "Clear";
DM_MENU_RESETPOS = "Reset Position";
DM_MENU_HIDE = "Hide Window";
DM_MENU_SHOW = "Show Window";
DM_MENU_VISINPARTY = "Visible Only While In A Party";
DM_MENU_REPORT = "Report";
DM_MENU_BARCOUNT = "Bar Count";
DM_MENU_AUTOCOUNTLIMIT = "Auto Count Limit";
DM_MENU_SORT = "Sort Type";
DM_MENU_VISIBLEQUANTITY = "Visible Quantity";
--DM_MENU_COLORSCHEME = "Color Scheme";
DM_MENU_MEMORY = "Memory Register";
DM_MENU_SAVE = "Save";
DM_MENU_RESTORE = "Restore";
DM_MENU_MERGE = "Merge";
DM_MENU_SWAP = "Swap";
DM_MENU_DELETE = "Delete";
DM_MENU_BAN = "Ban";
DM_MENU_CLEARABOVE = "Clear Above";
DM_MENU_CLEARBELOW = "Clear Below";
--DM_MENU_LOCK = "Lock List";
--DM_MENU_UNLOCK = "Unlock List";
DM_MENU_PAUSE = "Pause Parsing";
--DM_MENU_UNPAUSE = "Resume Parsing";
DM_MENU_LOCKPOS = "Lock Position";
DM_MENU_UNLOCKPOS = "Unlock Position";
DM_MENU_GROUPMEMBERSONLY = "Only Monitor Group Members";
DM_MENU_ADDPETTOPLAYER = "Treat Pet Data As Your Data";
DM_MENU_TEXT = "Text Options";
DM_MENU_TEXTRANK = "Rank";
DM_MENU_TEXTNAME = "Name";
DM_MENU_TEXTPERCENTAGE = "% of Total";
DM_MENU_TEXTPERCENTAGELEADER = "% of Leader's";
DM_MENU_TEXTVALUE = "Value";
DM_MENU_SETCOLORFORALL = "Set Color For All";
DM_MENU_DEFAULTCOLORS = "Restore Default Colors";
DM_MENU_RESETONCOMBATSTARTS = "Reset Data When Combat Starts";
DM_MENU_SHOWFIGHTASPS = "Show Fight Data as Per/Second";
DM_MENU_REFRESHBUTTON = "Refresh";
DM_MENU_TOTAL = "Total";
DM_MENU_CHOOSEREPORT = "Choose Report";
-- Note reordered this list in version 2.2.0
DM_MENU_REPORTNAMES = {"Frame", "Console", "Say", "Party", "Raid", "Guild", "Officer"};
DM_MENU_TEXTCYCLE = "Cycle";
DM_MENU_QUANTCYCLE = "Auto-Cycle";
DM_MENU_HELP = "Help";
DM_MENU_ACCUMULATEINMEMORY = "Accumulate Data";
DM_MENU_POSITION = "Position";
DM_MENU_RESIZELEFT = "Resize Left";
DM_MENU_RESIZEUP = "Resize Up";
DM_MENU_SHOWMAX = "Show Max";
DM_MENU_SHOWTOTAL = "Show Total";
DM_MENU_LEADERS = "Leaders";
DM_MENU_PLAYERREPORT = "Player Report";
DM_MENU_EVENTREPORT = "Event Report";
DM_MENU_EVENTDATA = "Event Data";
DM_MENU_EVENTDATA_NONE = "Parse No Events";
DM_MENU_EVENTDATA_PLAYER = "Parse Own Events";
DM_MENU_EVENTDATA_ALL = "Parse All Events";
--DM_MENU_SYNCEVENTDATA_NONE = "Transmit No Events";
--DM_MENU_SYNCEVENTDATA_PLAYER = "Transmit Own Events";
--DM_MENU_SYNCEVENTDATA_ALL = "Transmit All Events";
DM_MENU_SHOWEVENTDATATOOLTIP = "Tooltip Default";
DM_MENU_EVENTS1 = "Events 1-20";
DM_MENU_EVENTS2 = "Events 21-40";
DM_MENU_EVENTS3 = "Events 41-50";
DM_MENU_SYNC = "Synchronization";
DM_MENU_ONLYSYNCWITHGROUP = "Only Sync With Group";
DM_MENU_PERMITSYNCAUTOJOIN = "Join Broadcasted Channels";
DM_MENU_CLEARONAUTOJOIN = "Clear When Joining";
DM_MENU_SYNCBROADCASTCHAN = "Broadcast Channel";
DM_MENU_SYNCLEAVECHAN = "Leave Channel";
DM_MENU_SYNCONLYPLAYEREVENTS = "Sync Self Events Only";
DM_MENU_ENABLEDMM = "Show DMM Messages";
DM_MENU_NOSYNCCHAN = "NO SYNC CHANNEL SET";
DM_MENU_SYNCCHAN = "Current syncchan = ";
DM_MENU_SESSION = "Current session = ";
DM_MENU_JOINSYNCCHAN = "Join Channel: Use /dmsyncchan";
DM_MENU_PARSEEVENTMESSAGES = "Parse Incoming Events";
DM_MENU_SENDINGBAR = "Sending...";
DM_MENU_PROCESSINGBAR = "Processing...";
DM_MENU_QUANTITYFILTER = "Quantity Filter";
DM_MENU_MINIMIZE = "Minimize";
DM_MENU_LEFTJUSTIFYTEXT = "Left-Justify";
DM_MENU_RESTOREDEFAULTOPTIONS = "Restore Default Options";
DM_MENU_PLAYERALWAYSVISIBLE = "Self Always Visible";
DM_MENU_APPLYFILTERTOMANUALCYCLING = "Apply to Manual Cycling";
DM_MENU_APPLYFILTERTOAUTOCYCLING = "Apply to Auto-Cycle";
DM_MENU_GENERAL = "General Options";
DM_MENU_GROUPDPSMODE = "Group DPS Mode";
DM_MENU_CLEARBANNED = "Un-ban All";
DM_MENU_CONSTANTVISUALUPDATE = "Constant Visual Update";
-- Threat Meter Menus --
--[[ Threat
DM_MENU_THREAT = "Threat Functions (Beta)";
DM_MENU_THREAT_CLEAR = "Clear Threat";
DM_MENU_THREAT_TARGET = "Set Target";
DM_MENU_THREAT_PHASE = "Clear on phase change";
DM_MENU_THREAT_TALENTS = "Synchronize Talents";
DM_MENU_THREAT_EQUIP = "Synchronize Equipment";
DM_MENU_THREAT_PARTICIPATE = "Participate In Threat Syncing";
DM_MENU_THREAT_FORCECLEARONCOMBATSTART = "Force Threat Clear On Combat Start";
]]--

-- Misc
DM_CLASS = "Class"; -- The word for player class, like Druid or Warrior.
DM_TOOLTIP = "\nTime since last action = %.1fs\nRelationship = %s";
DM_YOU = "you"
DM_CRITSTR = "Crit";
DM_UNKNOWNENTITY = "Unknown Entity";
DM_SYNCSPELLNAME = "[Sync]";

DM_DMG_MELEE = "[Melee]";
DM_DMG_FALLING = "[Falling]";
DM_DMG_LAVA = "[Lava]";
DM_DMG_DAMAGESHIELD = "[DmgShield]";
DM_DMG_DEATH = "[Death]";
DM_DMG_COMBAT = "[Out of Combat]";

DM_Spellometer_Patterns = {
   { pattern="^([^ ]+) cast[s]? (.*) on (.*)%.$", caster=1, spell=2, target=3 },
   { pattern="^([^ ]+) cast[s]? (.*)%.$", caster = 1, spell=2, target=nil }
};

DM_CURESPELLS = {
	"Dispel Magic",
	"Remove Curse", 
	"Remove Lesser Curse",
	"Cure Poison", 
	"Abolish Poison",
	"Cure Disease",
	"Abolish Disease",
	"Cleanse",
	"Purification",
	"Poison Cleansing Totem",
	"Disease Cleansing Totem",
	"Ancestral Spirit",
	"Rebirth",
	"Redemption",
	"Resurrection",
	"Defibrillate",
};

DamageMeters_RPSmoveStrings = 
{ 
	r = "Rock", 
	p = "Paper", 
	s = "Scissors" 
};

--[[
-------------------------------------------------------------------------------
THIS IS WHERE COMBAT MESSAGES GET PARSED
-------------------------------------------------------------------------------

Notes:
- Using %a+ for player names is very risk as totems are pets and have spaces in their names.
- Absorb messages ignored, as they skew average damage taken and make it hard to 
  accurately calculate resists.

-----------------
THE EVENT MATRIX:
-----------------
					(S)Self		(E)Pet		(P)Party		(F)Friendly
01 Hit				x			x			x				x
02 Crit				x			x			0				x
03 Spell			x			x			x				x
04 SpellCrit		x			x			x				x
05 Dot				x			A			A				A
06 DmgShield		x			B			B				B
07 SplitDmg						0			0				0

10 IncHit			x			x			x				x
11 IncCrit			x			x			x				x
12 IncSpell			x			x			x				x
13 IncSpellCrit		x			0			x				x
14 IncDot			x			x			x				x
15 Falling			x			-			0				x
16 Lava 			x			-			0				x
17 Resist			0			0			0				0

20 Heal				x			0			x				x
21 HealCrit			x			0			x				x
22 Hot				x			0			x				x
23 NDB				-			0			0				x
24 JD				-			0			0				0


x : Confirmed
0 : Case exists, but unconfirmed.
- : Irrelevant.
A - Ambiguous: Dots messages come from the creature being hit, not the player.
B - Damage shield messags are only self and "other".
NDB - "Night Dragon's Blossom" : English special-case because of the "'s".
JD - "Julie's Dagger" : English special-case because of the "'s".


]]--

function DamageMeters_ParseMessage(arg1, event)
	local creatureName;
	local damage;
	local spell;
	local spell2;
	local petName;
	local partialBlock;
	local damageType;
	local absorbed;
	local resisted;
	local unused;

	local playerUnitName = UnitName("Player");

	DamageMeters_StartDebugTimer(DMPROF_PARSEMESSAGE);

	---------------------
	-- DAMAGE MESSAGES --
	---------------------

	-- English: The following require special cases in English:
	-- Ramstein's Lightning Bolts - the 's breaks the patterns.  Known bug, as-is.

	if(	event == "CHAT_MSG_COMBAT_SELF_HITS" ) then
		for creatureName, damage in string.gfind(arg1, "You hit (.+) for (%d+)") do
			DM_CountMsg(arg1, "S01 Self Hit", event);
			DamageMeters_AddDamage(playerUnitName, damage, DM_HIT, DamageMeters_Relation_SELF, DM_DMG_MELEE);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_HIT, DamageMeters_Relation_SELF, DM_DMG_MELEE, "Physical", ThreatType_Damage);
			return;
		end
		for creatureName, damage in string.gfind(arg1, "You crit (.+) for (%d+)") do
			DM_CountMsg(arg1, "S02 Self Crit", event);
			DamageMeters_AddDamage(playerUnitName, damage, DM_CRIT, DamageMeters_Relation_SELF, DM_DMG_MELEE);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_CRIT, DamageMeters_Relation_SELF, DM_DMG_MELEE, "Physical", ThreatType_Damage);
			return;
		end

		for damage in string.gfind(arg1, "You fall and lose (%d+) health%.") do 
			DM_CountMsg(arg1, "S15 Falling", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_DOT, DamageMeters_Relation_SELF, DM_DMG_FALLING);
			return; 
		end
		for damage in string.gfind(arg1, "You lose (%d+) health for swimming in lava%.") do 
			DM_CountMsg(arg1, "S16 Lava", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_DOT, DamageMeters_Relation_SELF, DM_DMG_LAVA);
			return; 
		end
	end

	if ( event == "CHAT_MSG_SPELL_SELF_DAMAGE" )then
		for spell, creatureName, damage in string.gfind(arg1, "Your (.+) hits (.+) for (%d+)") do
			DM_CountMsg(arg1, "S03 Self Spell Hit", event);
			DamageMeters_AddDamage(playerUnitName, damage, DM_HIT, DamageMeters_Relation_SELF, spell);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_HIT, DamageMeters_Relation_SELF, spell, "Physical", ThreatType_Damage);
			return;
		end
		for spell, creatureName, damage in string.gfind(arg1, "Your (.+) crits (.+) for (%d+)") do
			DM_CountMsg(arg1, "S04 Self Spell Crit", event);
			DamageMeters_AddDamage(playerUnitName, damage, DM_CRIT, DamageMeters_Relation_SELF, spell);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_CRIT, DamageMeters_Relation_SELF, spell, "Physical", ThreatType_Damage);
			return;
		end
	end

	if ( event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE" ) then	
		for creatureName, damage, damageType, spell, unused in string.gfind(arg1, "(.+) suffers (%d+) (.+) damage from your (.+)%. %((.+)%)") do
			--DMPrint(creatureName..", "..damage..", "..damageType..", "..spell);
			DM_CountMsg(arg1, "S05 Self DOT", event);
			DamageMeters_AddDamage(playerUnitName, damage, DM_DOT, DamageMeters_Relation_SELF, spell);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_DOT, DamageMeters_Relation_SELF, spell, damageType, ThreatType_Damage);
			return;
		end
		for creatureName, damage, damageType, spell in string.gfind(arg1, "(.+) suffers (%d+) (.+) damage from your (.+)%.") do
			--DMPrint(creatureName..", "..damage..", "..damageType..", "..spell);
			DM_CountMsg(arg1, "S05 Self DOT", event);
			DamageMeters_AddDamage(playerUnitName, damage, DM_DOT, DamageMeters_Relation_SELF, spell);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_DOT, DamageMeters_Relation_SELF, spell, damageType, ThreatType_Damage);
			return;
		end

		for creatureName, damage, damageType, playerName, spell, unused in string.gfind(arg1, "(.+) suffers (%d+) (.+) damage from (.+)'s (.+)%. %((.+)%)") do
			DM_CountMsg(arg1, "F05 Friendly DOT", event);
			DamageMeters_AddDamage(playerName, damage, DM_DOT, DamageMeters_Relation_FRIENDLY, spell);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_DOT, DamageMeters_Relation_FRIENDLY, spell, damageType, ThreatType_Damage);
			return;
		end
		for creatureName, damage, damageType, playerName, spell in string.gfind(arg1, "(.+) suffers (%d+) (.+) damage from (.+)'s (.+)%.") do
			DM_CountMsg(arg1, "F05 Friendly DOT", event);
			DamageMeters_AddDamage(playerName, damage, DM_DOT, DamageMeters_Relation_FRIENDLY, spell);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_DOT, DamageMeters_Relation_FRIENDLY, spell, damageType, ThreatType_Damage);
			return;
		end
	end

	if (event == "CHAT_MSG_COMBAT_PARTY_HITS" or
		event == "CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS" or
		event == "CHAT_MSG_COMBAT_PET_HITS") then

		local relationship = DamageMeters_Relation_PARTY;
		local relationshipName = "P";
		if (event == "CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS") then
			relationship = DamageMeters_Relation_FRIENDLY;
			relationshipName = "F";
		elseif (event == "CHAT_MSG_COMBAT_PET_HITS") then
			relationship = DamageMeters_Relation_PET;
			relationshipName = "E";
		end
			
		for playerName, creatureName, damage in string.gfind(arg1, "(.+) hits (.+) for (%d+)") do
			DM_CountMsg(arg1, relationshipName.."01 Hit", event);
			DamageMeters_AddDamage(playerName, damage, DM_HIT, relationship, DM_DMG_MELEE);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_HIT, relationship, DM_DMG_MELEE, "Physical", ThreatType_Damage);
			return;
		end
		for playerName, creatureName, damage in string.gfind(arg1, "(.+) crits (.+) for (%d+)") do
			DM_CountMsg(arg1, relationshipName.."02 Crit", event);
			DamageMeters_AddDamage(playerName, damage, DM_CRIT, relationship, DM_DMG_MELEE);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_CRIT, relationship, DM_DMG_MELEE, "Physical", ThreatType_Damage);
			return;
		end

		for player, damage in string.gfind(arg1, "(.+) falls and loses (%d+) health%.") do 
			DM_CountMsg(arg1, relationshipName.."15 Falling", event);
			DamageMeters_AddDamageReceived(player, damage, DM_DOT, relationship, DM_DMG_FALLING);
			return; 
		end
		for player, damage in string.gfind(arg1, "(.+) loses (%d+) health for swimming in lava%.") do 
			DM_CountMsg(arg1, relationshipName.."16 Lava", event);
			DamageMeters_AddDamageReceived(player, damage, DM_DOT, relationship, DM_DMG_LAVA);
			return; 
		end
	end

	if (event == "CHAT_MSG_SPELL_PARTY_DAMAGE" or
		event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE" or
		event == "CHAT_MSG_SPELL_PET_DAMAGE") then

		local relationship = DamageMeters_Relation_PARTY;
		local relationshipName = "P";
		if (event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_DAMAGE") then
			relationship = DamageMeters_Relation_FRIENDLY;
			relationshipName = "F";
		elseif (event == "CHAT_MSG_SPELL_PET_DAMAGE") then
			relationship = DamageMeters_Relation_PET;
			relationshipName = "E";
		end

		for playerName, spell, creatureName, damage in string.gfind(arg1, "(.+)'s (.+) hits (.+) for (%d+)") do		
			DM_CountMsg(arg1, relationshipName.."03 Spell", event);
			DamageMeters_AddDamage(playerName, damage, DM_HIT, relationship, spell);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_HIT, relationship, spell, "Physical", ThreatType_Damage);
			return;
		end
		for playerName, spell, creatureName, damage in string.gfind(arg1, "(.+)'s (.+) crits (.+) for (%d+)") do
			DM_CountMsg(arg1, relationshipName.."04 SpellCrit", event);
			DamageMeters_AddDamage(playerName, damage, DM_CRIT, relationship, spell);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_CRIT, relationship, spell, "Physical", ThreatType_Damage);
			return;
		end

		-- For soul link
		-- SPELLSPLITDAMAGEOTHEROTHER
		--! todo SPELLSPLITDAMAGEOTHERSELF
		--! todo SPELLSPLITDAMAGESELFOTHER
		for creatureName, spell, playerName, damage in string.gfind(arg1, "(.+)'s (.+) causes (.+) (%d+) damage") do
			DM_CountMsg(arg1, relationshipName.."07 SplitDmg", event);
			DamageMeters_AddDamage(playerName, damage, DM_DOT, relationship, spell);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_DOT, relationship, spell, "Physical", ThreatType_Damage);
			return;
		end
	end

	-- Damage Shields --

	if (event == "CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF") then
		for damage, damageType, creatureName in string.gfind(arg1, "You reflect (%d+) (.+) damage to (.+)%.") do
			DM_CountMsg(arg1, "S06 DmgShield", event);
			DamageMeters_AddDamage(playerUnitName, damage, DM_DOT, DamageMeters_Relation_SELF, DM_DMG_DAMAGESHIELD);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_DOT, DamageMeters_Relation_SELF, DM_DMG_DAMAGESHIELD, "Physical", ThreatType_Damage);
			DamageMeters_StartDebugTimer(DMPROF_PARSEMESSAGE);
			DamageMeters_AddDamageReceived(creatureName, damage, DM_DOT, DamageMeters_Relation_FRIENDLY, DM_DMG_DAMAGESHIELD);
			return;
		end
	end
	if (event == "CHAT_MSG_SPELL_DAMAGESHIELDS_ON_OTHERS") then
		for playerName, damage, damageType, creatureName in string.gfind(arg1, "(.+) reflects (%d+) (.+) damage to (.+)%.") do
			DM_CountMsg(arg1, "F06 DmgShield", event);
			DamageMeters_AddDamage(playerName, damage, DM_DOT, DamageMeters_Relation_FRIENDLY, DM_DMG_DAMAGESHIELD);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_DOT, DamageMeters_Relation_FRIENDLY, DM_DMG_DAMAGESHIELD, damageType, ThreatType_Damage);
			DamageMeters_StartDebugTimer(DMPROF_PARSEMESSAGE);
			DamageMeters_AddDamageReceived(creatureName, damage, DM_DOT, DamageMeters_Relation_FRIENDLY, DM_DMG_DAMAGESHIELD);
			return;
		end
	end

	------------------------------
	-- DAMAGE-RECEIVED MESSAGES --
	------------------------------

	-- TODO: Reflected spells.  "you are affected by YOUR spell."
	-- 

	if (event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS" or	
		-- absorb event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES" or -- "Creature hits you for x (y absorbed)%."
		event == "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS" or
		-- absorb event == "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES" or
		event == "CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_HITS" or
		-- absorb event == "CHAT_MSG_COMBAT_CREATURE_VS_CREATURE_MISSES" or
		event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS") then

		for creatureName, damage in string.gfind(arg1, "(.+) hits you for (%d+)") do
			DM_CountMsg(arg1, "S10 IncHit", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_HIT, DamageMeters_Relation_SELF, DM_DMG_MELEE);
			return;
		end
		for creatureName, damage in string.gfind(arg1, "(.+) crits you for (%d+)") do
			DM_CountMsg(arg1, "S11 IncCrit", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_CRIT, DamageMeters_Relation_SELF, DM_DMG_MELEE);
			return;
		end

		local relationship = DamageMeters_Relation_FRIENDLY;
		local relationshipName = "F";
		if (event == "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS") then
			relationship = DamageMeters_Relation_PARTY;
			relationshipName = "P";
		elseif (event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS") then
			relationship = DamageMeters_Relation_PET;
			relationshipName = "E";
		end

		for creatureName, playerName, damage, resisted in string.gfind(arg1, "(.+) hits (.+) for (%d+)%. %((%d+) resisted%)") do
			DM_CountMsg(arg1, relationshipName.."10 IncHit Resist", event);
			DamageMeters_AddDamageReceived(playerName, damage, DM_HIT, relationship, DM_DMG_MELEE, nil, resisted);
			return;
		end
		for creatureName, playerName, damage in string.gfind(arg1, "(.+) hits (.+) for (%d+)%.") do
			DM_CountMsg(arg1, relationshipName.."10 IncHit", event);
			DamageMeters_AddDamageReceived(playerName, damage, DM_HIT, relationship, DM_DMG_MELEE);
			return;
		end
		for creatureName, playerName, damage, resisted in string.gfind(arg1, "(.+) crits (.+) for (%d+)%. %((%d+) resisted%)") do
			DM_CountMsg(arg1, relationshipName.."11 IncCrit Resist", event);
			DamageMeters_AddDamageReceived(playerName, damage, DM_CRIT, relationship, DM_DMG_MELEE, nil, resisted);
			return;
		end
		for creatureName, playerName, damage in string.gfind(arg1, "(.+) crits (.+) for (%d+)%.") do
			DM_CountMsg(arg1, relationshipName.."11 IncCrit", event);
			DamageMeters_AddDamageReceived(playerName, damage, DM_CRIT, relationship, DM_DMG_MELEE);
			return;
		end
		--[[ absorb
		for creatureName, playerName, damage, absorbed in string.gfind(arg1, "(.+) hits (.+) for (%d+) ((%d+) absorbed)%.") do
			DM_CountMsg(arg1, relationshipName.."10 IncHit Abs", event);
			DamageMeters_AddDamageReceived(playerName, damage, DM_HIT, relationship, DM_DMG_MELEE);
			return;
		end
		for creatureName, playerName, damage, absorbed in string.gfind(arg1, "(.+) crits (.+) for (%d+) ((%d+) absorbed)%.") do
			DM_CountMsg(arg1, relationshipName.."11 IncCrit Abs", event);
			DamageMeters_AddDamageReceived(playerName, damage, DM_CRIT, relationship, DM_DMG_MELEE);
			return;
		end
		]]--

		-- Dunno why, but party falling dmg is reported through CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS.
		for player, damage in string.gfind(arg1, "(.+) falls and loses (%d+) health.") do 
			DM_CountMsg(arg1, "P15 Falling", event);
			DamageMeters_AddDamageReceived(player, damage, DM_DOT, DamageMeters_Relation_PARTY, DM_DMG_FALLING);
			return; 
		end
		-- Guessing lava is the same.
		for player, damage in string.gfind(arg1, "(.+) loses (%d+) health for swimming in lava.") do 
			DM_CountMsg(arg1, "P16 Lava", event);
			DamageMeters_AddDamageReceived(player, damage, DM_DOT, DamageMeters_Relation_PARTY, DM_DMG_LAVA);
			return; 
		end
	end

	if (event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or
		event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" or
		event == "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE") then
		for creatureName, spell, damage, damageType, resisted in string.gfind(arg1, "(.+)'s (.+) hits you for (%d+) (.+) damage%. %((%d+) resisted%)") do
			DM_CountMsg(arg1, "S12 IncSpell", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_HIT, DamageMeters_Relation_SELF, spell, damageType, resisted);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_HIT, DamageMeters_Relation_SELF, spell, "Physical", ThreatType_Player);
			return;
		end
		for creatureName, spell, damage, damageType in string.gfind(arg1, "(.+)'s (.+) hits you for (%d+) (.+) damage%.") do
			DM_CountMsg(arg1, "S12 IncSpell", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_HIT, DamageMeters_Relation_SELF, spell, damageType);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_HIT, DamageMeters_Relation_SELF, spell, damageType, ThreatType_Player);
			return;
		end

		-- Gurubashi axe throwers do this: "Gurubashi Axe Thrower's Throw hits you for 123."
		for creatureName, spell, damage in string.gfind(arg1, "(.+)'s (.+) hits you for (%d+)%.") do
			DM_CountMsg(arg1, "S12 IncSpell", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_HIT, DamageMeters_Relation_SELF, spell);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_HIT, DamageMeters_Relation_SELF, spell, "Physical", ThreatType_Player);
			return;
		end
		for creatureName, spell, damage in string.gfind(arg1, "(.+)'s (.+) hits you for (%d+)%.") do
			DM_CountMsg(arg1, "S12 IncSpell", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_CRIT, DamageMeters_Relation_SELF, spell);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_CRIT, DamageMeters_Relation_SELF, spell, "Physical", ThreatType_Player);
			return;
		end

		for creatureName, spell, damage, damageType, resisted in string.gfind(arg1, "(.+)'s (.+) crits you for (%d+)% (.+) damage. %((%d+) resisted%)") do
			DM_CountMsg(arg1, "S13 IncSpellCrit", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_CRIT, DamageMeters_Relation_SELF, spell, damageType, resisted);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_HIT, DamageMeters_Relation_SELF, spell, damageType, ThreatType_Player);
			return;
		end
		-- Dand: This case taken from ThreatMeters.  Looks like it was probably an oversight on my part.
		for creatureName, spell, damage, damageType, resisted in string.gfind(arg1, "(.+)'s (.+) crits you for (%d+)% (.+) damage. %((%d+) resisted%)") do
			DM_CountMsg(arg1, "S13 IncSpellCrit", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_CRIT, DamageMeters_Relation_SELF, spell, damageType, resisted);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_CRIT, DamageMeters_Relation_SELF, spell, damageType, ThreatType_Player);
			return;
		end
		for creatureName, spell, damage, damageType in string.gfind(arg1, "(.+)'s (.+) crits you for (%d+)% (.+) damage.") do
			DM_CountMsg(arg1, "S13 IncSpellCrit", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_CRIT, DamageMeters_Relation_SELF, spell, damageType);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_CRIT, DamageMeters_Relation_SELF, spell, damageType, ThreatType_Player);
			return;
		end
		for creatureName, spell, player in string.gfind(arg1, "(.+)'s (.+) was resisted%.") do 
			DM_CountMsg(arg1, "S17 Resist", event);
			DamageMeters_AddDamageReceived(playerUnitName, 0, DM_HIT, DamageMeters_Relation_SELF, spell, nil, -1);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_CRIT, DamageMeters_Relation_SELF, spell, damageType, ThreatType_Player);
			return; 
		end

		local relationship = DamageMeters_Relation_FRIENDLY;
		local relationshipName = "F";
		if (event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE") then
			relationship = DamageMeters_Relation_PARTY;
			relationshipName = "P";
		elseif (event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE") then
			relationship = DamageMeters_Relation_PET;
			relationshipName = "E";
		end

		for creatureName, spell, playerName, damage, damageType, resisted in string.gfind(arg1, "(.+)'s (.+) hits (.+) for (%d+) (.+) damage%. %((%d+) resisted%)") do
			DM_CountMsg(arg1, relationshipName.."12 IncSpell Resist", event);
			DamageMeters_AddDamageReceived(playerName, damage, DM_HIT, relationship, spell, damageType, resisted);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_HIT, relationship, spell, "Physical", ThreatType_Player);
			return;
		end
		for creatureName, spell, playerName, damage, damageType in string.gfind(arg1, "(.+)'s (.+) hits (.+) for (%d+) (.+) damage%.") do
			DM_CountMsg(arg1, relationshipName.."12 IncSpell", event);
			DamageMeters_AddDamageReceived(playerName, damage, DM_HIT, relationship, spell, damageType);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_HIT, relationship, spell, damageType, ThreatType_Player);
			return;
		end
		for creatureName, spell, playerName, damage, damageType, resisted in string.gfind(arg1, "(.+)'s (.+) crits (.+) for (%d+) (.+) damage%. %((%d+) resisted%)") do
			DM_CountMsg(arg1, relationshipName.."13 IncSpellCrit Resist", event);
			DamageMeters_AddDamageReceived(playerName, damage, DM_CRIT, relationship, spell, damageType);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_HIT, relationship, spell, damageType, ThreatType_Player);
			return;
		end

		-- for Gurubashi Axe Thrower's Throw
		for creatureName, spell, playerName, damage in string.gfind(arg1, "(.+)'s (.+) hits (.+) for (%d+)%.") do
			DM_CountMsg(arg1, relationshipName.."12 IncSpell", event);
			DamageMeters_AddDamageReceived(playerName, damage, DM_HIT, relationship, spell);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_HIT, relationship, spell, "Physical", ThreatType_Player);
			return;
		end
		for creatureName, spell, playerName, damage in string.gfind(arg1, "(.+)'s (.+) crits (.+) for (%d+)%.") do
			DM_CountMsg(arg1, relationshipName.."12 IncSpell", event);
			DamageMeters_AddDamageReceived(playerName, damage, DM_CRIT, relationship, spell);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_CRIT, relationship, spell, "Physical", ThreatType_Player);
			return;
		end

		-- Dand: This case taken from ThreatMeters.  Looks like it was probably an oversight on my part.
		for creatureName, spell, playerName, damage, damageType, resisted in string.gfind(arg1, "(.+)'s (.+) crits (.+) for (%d+) (.+) damage%. %((%d+) resisted%)") do
			DM_CountMsg(arg1, relationshipName.."13 IncSpellCrit Resist", event);
			DamageMeters_AddDamageReceived(playerName, damage, DM_CRIT, relationship, spell, damageType);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_CRIT, relationship, spell, damageType, ThreatType_Player);
			return;
		end
		for creatureName, spell, playerName, damage, damageType in string.gfind(arg1, "(.+)'s (.+) crits (.+) for (%d+) (.+) damage") do
			DM_CountMsg(arg1, relationshipName.."13 IncSpellCrit", event);
			DamageMeters_AddDamageReceived(playerName, damage, DM_CRIT, relationship, spell, damageType);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_CRIT, relationship, spell, damageType, ThreatType_Player);
			return;
		end

		-- Resists
		for creatureName, spell, player in string.gfind(arg1, "(.+)'s (.+) was resisted by (.+)%.") do 
			DM_CountMsg(arg1, relationshipName.."17 Resist", event);
			DamageMeters_AddDamageReceived(player, 0, DM_HIT, relationship, spell, nil, -1);
			return; 
		end
		for creatureName, spell in string.gfind(arg1, "(.+)'s (.+) was resisted.") do 
			DM_CountMsg(arg1, "S17 Resist", event);
			DamageMeters_AddDamageReceived(playerUnitName, 0, DM_HIT, DamageMeters_Relation_SELF, spell, nil, -1);
			return; 
		end
	end

	if (event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE") then
		for creatureName, spell, damage, damageType in string.gfind(arg1, "(.+)'s (.+) hits you for (%d+) (.+) damage") do
			DM_CountMsg(arg1, "S12 IncSpell PVP", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_HIT, DamageMeters_Relation_SELF, spell, damageType);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_HIT, DamageMeters_Relation_SELF, spell, damageType, ThreatType_Player);
			return;
		end
		for creatureName, spell, damage, damageType in string.gfind(arg1, "(.+)'s (.+) crits you for (%d+) (.+) damage") do
			DM_CountMsg(arg1, "S13 IncSpellCrit PVP", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_CRIT, DamageMeters_Relation_SELF, spell, damageType);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_CRIT, DamageMeters_Relation_SELF, spell, damageType, ThreatType_Player);
			return;
		end

		for creatureName, spell, playerName, damage, damageType in string.gfind(arg1, "(.+)'s (.+) hits (.+) for (%d+) (.+) damage") do
			DM_CountMsg(arg1, "F12 IncSpell PVP", event);
			DamageMeters_AddDamageReceived(playerName, damage, DM_HIT, DamageMeters_Relation_FRIENDLY, spell, damageType);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_HIT, DamageMeters_Relation_FRIENDLY, spell, damageType, ThreatType_Player);
			return;
		end
		for creatureName, spell, playerName, damage, damageType in string.gfind(arg1, "(.+)'s (.+) crits (.+) for (%d+) (.+) damage") do
			DM_CountMsg(arg1, "F13 IncSpellCrit PVP", event);
			DamageMeters_AddDamageReceived(playerName, damage, DM_CRIT, DamageMeters_Relation_FRIENDLY, spell, damageType);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_CRIT, DamageMeters_Relation_FRIENDLY, spell, damageType, ThreatType_Player);
			return;
		end
	end

	-- Periodic.
	if (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE") then
		for damage, damageType, creatureName, spell, resisted in string.gfind(arg1, "You suffer (%d+) (.+) damage from (.+)'s (.+)%. %((%d+) resisted%)") do
			DM_CountMsg(arg1, "S14 IncDot Resist", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_DOT, DamageMeters_Relation_SELF, spell, damageType, resisted);
			return;
		end
		for damage, damageType, creatureName, spell in string.gfind(arg1, "You suffer (%d+) (.+) damage from (.+)'s (.+)%.") do
			DM_CountMsg(arg1, "S14 IncDot", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_DOT, DamageMeters_Relation_SELF, spell, damageType);
			return;
		end

		-- For reflected dots: 
		for damage, damageType, spell in string.gfind(arg1, "You suffer (%d+) (.+) damage from your (.+)%.") do
			DM_CountMsg(arg1, "S14 IncDot", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_DOT, DamageMeters_Relation_SELF, spell, damageType);
			return;
		end

		-- Pet
		for playerName, damage, damageType, creatureName, spell in string.gfind(arg1, "(.+) suffers (%d+) (.+) damage from (.+)'s (.+)%. %((%d+) resisted%)") do
			DM_CountMsg(arg1, "E14 IncDot", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_DOT, DamageMeters_Relation_PET, spell, damageType, resisted);
			return;
		end
		for playerName, damage, damageType, creatureName, spell in string.gfind(arg1, "(.+) suffers (%d+) (.+) damage from (.+)'s (.+)%.") do
			DM_CountMsg(arg1, "E14 IncDot", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_DOT, DamageMeters_Relation_PET, spell, damageType);
			return;
		end
	end
	if (event == "CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE") then
		for playerName, damage, damageType, creatureName, spell, resisted in string.gfind(arg1, "(.+) suffers (%d+) (.+) damage from (.+)'s (.+)%. %((%d+) resisted%)") do
			DM_CountMsg(arg1, "P14 IncDot", event);
			DamageMeters_AddDamageReceived(playerName, damage, DM_DOT, DamageMeters_Relation_PARTY, spell, damageType, resisted);
			return;
		end
		for playerName, damage, damageType, creatureName, spell in string.gfind(arg1, "(.+) suffers (%d+) (.+) damage from (.+)'s (.+)%.") do
			DM_CountMsg(arg1, "P14 IncDot", event);
			DamageMeters_AddDamageReceived(playerName, damage, DM_DOT, DamageMeters_Relation_PARTY, spell, damageType);
			return;
		end
	end
	if (event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_DAMAGE" or
		event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE") then
		-- For pvp.
		for damage, damageType, creatureName, spell in string.gfind(arg1, "You suffer (%d+) (.+) damage from (.+)'s (.+)") do
			DM_CountMsg(arg1, "S14 IncDot PVP", event);
			DamageMeters_AddDamageReceived(playerUnitName, damage, DM_DOT, DamageMeters_Relation_SELF, spell);
			return;
		end

		for playerName, damage, damageType, creatureName, spell in string.gfind(arg1, "(.+) suffers (%d+) (.+) damage from (.+)'s (.+)%.") do
			DM_CountMsg(arg1, "F14 IncDot", event);
			DamageMeters_AddDamageReceived(playerName, damage, DM_DOT, DamageMeters_Relation_FRIENDLY, spell, damageType);
			return;
		end

		--! This happens in bg right after you die.
		--! "Bob takes 100 Arcane damage from your Moonfire."
	end

	----------------------
	-- HEALING MESSAGES --
	----------------------

	-- NOTE: There is a kind of bug here--we cannot tell the relationship of the 
	-- healer from the message, so if the group filter is on healing pets (healing totems particularly)
	-- won't be added into the list until some other quantity puts them in.
	-- NOTE: Inexplicably, HOSTILEPLAYER_BUFF messages report for party members.
	-- Note: In English, the following things require special healing cases:
	-- Night Dragon's Breath, Julie's Dagger.

	if (event == "CHAT_MSG_SPELL_SELF_BUFF" or
		event == "CHAT_MSG_SPELL_PARTY_BUFF" or
		event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF" or
		event == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF"
		) then

		local targetRelationship = DamageMeters_Relation_FRIENDLY;

		for spell, creatureName, damage in string.gfind(arg1, "Your (.+) critically heals (.+) for (%d+)%.") do
			DM_CountMsg(arg1, "S21 HealCrit", event);
			if (creatureName == DM_YOU) then creatureName = playerUnitName; targetRelationship = DamageMeters_Relation_SELF; end
			DamageMeters_AddHealing(playerUnitName, creatureName, damage, DM_CRIT, DamageMeters_Relation_SELF, targetRelationship, spell);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_CRIT, DamageMeters_Relation_SELF, spell, "Physical", ThreatType_Healing);
			return;
		end
		for spell, creatureName, damage in string.gfind(arg1, "Your (.+) heals (.+) for (%d+)%.") do
			DM_CountMsg(arg1, "S20 Heal", event);
			if (creatureName == DM_YOU) then creatureName = playerUnitName; targetRelationship = DamageMeters_Relation_SELF; end
			DamageMeters_AddHealing(playerUnitName, creatureName, damage, DM_HIT, DamageMeters_Relation_SELF, targetRelationship, spell);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_HIT, DamageMeters_Relation_SELF, spell, "Physical", ThreatType_Healing);
			return;
		end

		-- English-only special cases. 
		for playerName, creatureName, damage in string.gfind(arg1, "(.+)'s Night Dragon's Breath critically heals (.+) for (%d+)%.") do
			spell = "Night Dragon's Breath";
			DM_CountMsg(arg1, "F23 NDB Crit", event);
			if (creatureName == DM_YOU) then creatureName = playerUnitName; targetRelationship = DamageMeters_Relation_SELF; end
			DamageMeters_AddHealing(playerName, creatureName, damage, DM_CRIT, DamageMeters_Relation_FRIENDLY, DamageMeters_Relation_FRIENDLY, spell);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_CRIT, DamageMeters_Relation_FRIENDLY, spell, "Physical", ThreatType_Healing);
			return;
		end
		for playerName, creatureName, damage in string.gfind(arg1, "(.+)'s Night Dragon's Breath heals (.+) for (%d+)%.") do
			spell = "Night Dragon's Breath";
			DM_CountMsg(arg1, "F23 NDB", event);
			if (creatureName == DM_YOU) then creatureName = playerUnitName; targetRelationship = DamageMeters_Relation_SELF; end
			DamageMeters_AddHealing(playerName, creatureName, damage, DM_HIT, DamageMeters_Relation_FRIENDLY, DamageMeters_Relation_FRIENDLY, spell);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_HIT, DamageMeters_Relation_FRIENDLY, spell, "Physical", ThreatType_Healing);
			return;
		end

		for playerName, spell, creatureName, damage in string.gfind(arg1, "(.+)'s (.+) critically heals (.+) for (%d+)%.") do
			DM_CountMsg(arg1, "F21 HealCrit", event);
			if (creatureName == DM_YOU) then creatureName = playerUnitName; targetRelationship = DamageMeters_Relation_SELF; end
			DamageMeters_AddHealing(playerName, creatureName, damage, DM_CRIT, DamageMeters_Relation_FRIENDLY, targetRelationship, spell);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_CRIT, DamageMeters_Relation_FRIENDLY, spell, "Physical", ThreatType_Healing);
			return;
		end
		for playerName, spell, creatureName, damage in string.gfind(arg1, "(.+)'s (.+) heals (.+) for (%d+)%.") do
			DM_CountMsg(arg1, "F20 Heal", event);
			if (creatureName == DM_YOU) then creatureName = playerUnitName; targetRelationship = DamageMeters_Relation_SELF; end
			DamageMeters_AddHealing(playerName, creatureName, damage, DM_HIT, DamageMeters_Relation_FRIENDLY, targetRelationship, spell);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_HIT, DamageMeters_Relation_FRIENDLY, spell, "Physical", ThreatType_Healing);
			return;
		end
	end

	if (event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" or
		event == "CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS" or
		event == "CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS" or
		event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS" -- why?
		) then

		-- English special case.
		for creatureName, damage, playerName in string.gfind(arg1, "(.+) gains (%d+) health from (.+)'s Julie's Blessing.") do
			spell = "Julie's Blessing";
			DM_CountMsg(arg1, "F22 Hot2", event);
			DamageMeters_AddHealing(playerName, creatureName, damage, DM_DOT, DamageMeters_Relation_FRIENDLY, DamageMeters_Relation_FRIENDLY, spell);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_DOT, DamageMeters_Relation_FRIENDLY, spell, "Physical", ThreatType_Healing);
			return;
		end

		for damage, playerName, spell in string.gfind(arg1, "You gain (%d+) health from (.+)'s (.+)%.") do
			DM_CountMsg(arg1, "F22 Hot2", event);
			DamageMeters_AddHealing(playerName, playerUnitName, damage, DM_DOT, DamageMeters_Relation_FRIENDLY, DamageMeters_Relation_SELF, spell);
			-- Threat ThreatMeters_AddThreat(playerName, playerUnitName, damage, DM_DOT, DamageMeters_Relation_FRIENDLY, spell, "Physical", ThreatType_Healing);
			return;
		end
		for damage, spell in string.gfind(arg1, "You gain (%d+) health from (.+)%.") do
			DM_CountMsg(arg1, "S22 Hot1", event);
			DamageMeters_AddHealing(playerUnitName, playerUnitName, damage, DM_DOT, DamageMeters_Relation_SELF, DamageMeters_Relation_SELF, spell);
			-- Threat ThreatMeters_AddThreat(playerUnitName, playerUnitName, damage, DM_DOT, DamageMeters_Relation_SELF, spell, "Physical", ThreatType_Healing);
			return;
		end
		for creatureName, damage, spell in string.gfind(arg1, "(.+) gains (%d+) health from your (.+)%.") do		
			DM_CountMsg(arg1, "S22 Hot2", event);
			DamageMeters_AddHealing(playerUnitName, creatureName, damage, DM_DOT, DamageMeters_Relation_SELF, DamageMeters_Relation_FRIENDLY, spell);
			-- Threat ThreatMeters_AddThreat(playerUnitName, creatureName, damage, DM_DOT, DamageMeters_Relation_SELF, spell, "Physical", ThreatType_Healing);
			return;
		end
		for creatureName, damage, playerName, spell in string.gfind(arg1, "(.+) gains (%d+) health from (.+)'s (.+)%.") do
			DM_CountMsg(arg1, "F22 Hot2", event);
			DamageMeters_AddHealing(playerName, creatureName, damage, DM_DOT, DamageMeters_Relation_FRIENDLY, DamageMeters_Relation_FRIENDLY, spell);
			-- Threat ThreatMeters_AddThreat(playerName, creatureName, damage, DM_DOT, DamageMeters_Relation_FRIENDLY, spell, "Physical", ThreatType_Healing);
			return;
		end
	end

	--Threat ThreatMeters_ParseMessage(arg1, event);

	DamageMeters_StopDebugTimer(DMPROF_PARSEMESSAGE);

	----------------------
	-- CURING MESSAGES --
	----------------------

	if (event == "CHAT_MSG_SPELL_SELF_BUFF" or
		event == "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF" or
		event == "CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF") then

		for i in DM_Spellometer_Patterns do
			local caster, spell, target;
			local matches = {};
			local found;

			found,_,matches[1],matches[2],matches[3] = string.find(arg1, DM_Spellometer_Patterns[i].pattern);

			if found then
				local casterRelationship = DamageMeters_Relation_FRIENDLY;

				caster = matches[DM_Spellometer_Patterns[i].caster];
				spell = matches[DM_Spellometer_Patterns[i].spell];
				if DM_Spellometer_Patterns[i].target ~= nil then 
					target = matches[DM_Spellometer_Patterns[i].target];
				else
					target = UnitName("player");
				end
				if caster == "You" then
					caster = UnitName("player");
					casterRelationship = DamageMeters_Relation_SELF;
				end

				local spellFound = false;
				for index, cureSpell in DM_CURESPELLS do
					if (cureSpell == spell) then
						spellFound = true;
						break;
					end
				end

				if (spellFound == true) then
					DamageMeters_AddValue(caster, 1, DM_HIT, casterRelationship, DamageMeters_Quantity_CURING, spell);
				end
				return;
			end
		end
	end

	----------------------

	-- Check the message to see if it is the kind of thing we should have caught.
	if (DamageMeters_enableDebugPrint and arg1) then
		local sub = string.sub(event, 1, 8);
		if (sub == "CHAT_MSG") then			
			-- We only care about messages with numbers in them.
			for amount in string.gfind(arg1, "(%d+)") do

				--DMPrint("UNPARSED NUMERIC ["..event.."] : "..arg1);

				-- GENERICPOWERGAIN_OTHER 
				-- GENERICPOWERGAIN_SELF 
				for player, amount, type in string.gfind(arg1, "(.+) gains (%d+) (.+)%.") do	return;	end
				for player, amount, type in string.gfind(arg1, "You gain (%d+) (.+)%.") do return; end
				-- SPELLEXTRAATTACKSOTHER_SINGULAR etc
				if (string.find(arg1, "extra attack")) then return; end
				-- ITEMENCHANTMENTADDOTHEROTHER, etc
				for player in string.gfind(arg1, "(.+) casts (.+) on (.+)'s (.+)%.") do return; end
				for player in string.gfind(arg1, "(.+) casts (.+) on your (.+)%.") do return; end
				for player in string.gfind(arg1, "You cast (.+) on (.+)'s (.+)%.") do return; end
				for player in string.gfind(arg1, "You cast (.+) on your (.+)%.") do return; end
				-- VSENVIRONMENTALDAMAGE_DROWNING_OTHER etc.
				for player in string.gfind(arg1, "You are drowning and lose (%d+) health.") do return; end
				for player in string.gfind(arg1, "(.+) is exhausted and and loses (%d+) health.") do return; end
				for player in string.gfind(arg1, "You are exhausted and lose (%d+) health.") do return; end
				for player in string.gfind(arg1, "(.+) suffers (%d+) points of fire damage.") do return; end
				for player in string.gfind(arg1, "You suffer (%d+) points of fire damage.") do return; end
				for player in string.gfind(arg1, "(.+) loses (%d+) health for swimming in (.+)%.") do return; end
				for player in string.gfind(arg1, "You lose (%d+) health for swimming in (.+)%.") do return; end
				-- SPELLPOWERDRAINOTHEROTHER etc
				for player in string.gfind(arg1, "(.+) drains (%d+) Mana from you.") do return; end
				for player in string.gfind(arg1, "(.+) drains (%d+) Mana from (.+)%.") do return; end
				for player in string.gfind(arg1, "You drain (%d+) Mana from (.+)%.") do return; end
				for player in string.gfind(arg1, "(.+) drains (%d+) Mana from you and gains (%d+)") do return; end
				for player in string.gfind(arg1, "You drain (%d+) Mana from (.+) and gain (%d+)") do return; end


				-- blah casts field repair bot 74a
				-- blah begins to cast armor +40
				---------------

				DMPrint("Numeric message missed! ["..event.."]");
				DMPrint(arg1);

				local newIndex = table.getn(DamageMeters_missedMessages) + 1;
				DamageMeters_missedMessages[newIndex] = event..": "..arg1;
				return;
			end
		end
	end
end