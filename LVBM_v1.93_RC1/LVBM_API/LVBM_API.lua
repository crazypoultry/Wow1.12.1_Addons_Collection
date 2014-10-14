-- ----------------------------------------------------------------------------------------------------- --
-- La Vendetta Boss Mods AddOn by DeadlyMinds|Tandanu @ EU-Aegwynn and La Vendetta|Nitram @ EU-Azshara   --
--                                      http://www.deadlyminds.net                                       --
-- ----------------------------------------------------------------------------------------------------- --
-- ------- --
-- Changes --
-- ------- --
--
--  v1.93
--
-- updated Four Horsemen boss mod
-- updated Hakkar boss mod (pull detection)
-- updated Nefarian boss mod (kill counter)
-- updated zhTW translations (Thanks to CuteMiyu via Curse)
-- updated zhCN translations (Thanks to DiabloHu via Curse)
--
-- fixed Battleground statusbar color bug
-- fixed Gui bug with disabled sync
-- fixed Patchwork boss mod error message
-- fixed API bug on filtering outdated client syncs
-- fixed debugstack bug
-- 
-- added new RaidTools v0.2
-- added LVRT Slashcommand "/lvrt" with help messages
-- added LVRT Slashcommand "/lvrt ver" 
-- added LVRT Slashcommand "/lvrt emote <emote> [target]"
-- added LVRT Slashcommand "/lvrt enable <AddOn> <Player>"
-- added LVRT Slashcommand "/lvrt disable <AddOn> <Player>"
-- added LVRT Slashcommand "/lvrt announce <AddOn> <Player> <on|off>"
-- added LVRT Slashcommand "/lvrt bosslist"
-- added LVRT Slashcommand "/lvrt remote <on|off>
-- added LVRT Slashcommand "/lvrt logout <name>" (needs Promoted or Leader)
-- added LVRT Slashcommand "/lvrt pull <x>" (moved out of the GUI)
-- added LVRT Slashcommand "/lvrt ui" to reload you UI
-- moved slash command "/pull <x>" to LVRT
-- added new boss translation system for statusbars with dynamic content (LVBM_SBT[addon][x]={"search, "replace"})
-- added GUI options to change the combat log distance
-- added Thaddius lag fix by reducing the combat log range during phase 2
--
-- removed some old debug code
-- separated API, GUI, BossMods, RaidTools for performance tweaks
-- Optimized loading times
-- Optimized memory usage
-- added base for LoadOnDemand commands for LVBM (performance tweak)
--
--
--  v1.92
--
-- optimized BossTemplate API with field "MinVersionToSync" to prevent old Version Syncs
--
-- fixed some bar problems
-- fixed Four Horsemen AddOn (Mark problem with Bars)
-- fixed Grand Widow Faerlina out of Range Problem (now sync Enrage)
-- fixed some missing Localization Strings
-- fixed GUI first time scroll bug
-- 
-- updated Grand Widow Faerlina for deDE Client (enrage Detection timers)
-- updated Four Horsemen AddOn Meteor Code
-- updated AQ20 Anubisath Mod
-- updated Localizations
-- 
-- added Gui Option to disable Sync with old Clients
-- added Gui Option to Hide Playernames in Raidgroups
-- added API Option in BossTemplate to handle old Version Syncs
-- added Slashcommand \"/lv ver2\" which informs users with outdated versions
-- added Slashcommand \"/pull <x>\" (x = sec)
--
--
--  v1.91
--
-- creating new bars no longer sets the status bars color to default
-- fixed some minor bugs in the combat detection system
-- fixed a bug in the Loatheb healer rotation sync system with /loatheb undelete
-- fixed Sapphiron emote, Blizzard forgot %s in their emote string
-- fixed Kel'Thuzad combat detection bug
-- 
-- optimized status bar code -> reduced bar memory usage by ~30%, fixed memory leak bug in PullBarsTogether function
-- optimized Loatheb sync code -> reduced channel spam
-- players without (A) or (L) can now set a healer rotation for Loatheb, but their settings can't be broadcasted
-- you can now disable the "status" whisper command
-- changed default bar design
-- improved Sapphiron mod
-- improved Kel'Thuzad mod
-- updated BG mod, it now uses colored bars
-- updated chinese localization (thanks 2 DiabloHu)
--
-- added support for Lua 5.1 (Burning Crusade)
-- status bars will now flash when they are about to expire
-- status bars will now change their color over time
-- added french translation (only GUI and Blackwing Lair, more coming soon) (thanks 2 Proreborn)
--
--
--  v1.90
-- 
-- fixed Buru %s bug
-- fixed Huhuran %s Frenzy bug
-- fuxed Moam stone form detection
-- fixed Ossirian curse
-- fixed battleground 5vs0 timer
-- fixed InfoFrame UI scale positioning bug
-- fixed InfoFrame:Delete(), it now removes script handlers
-- fixed some minor InfoFrame bugs
-- fixed compatibility issues with chat addons, whispers will now be properly hidden
-- the Yauj fear timer can no longer be started by other mobs in AQ40
-- fixed some sync issues
--
-- InfoFrames now save their positions by their title
-- Pizzatimers will now show a warning 10 seconds before they expire
-- slightly adjusted Anub'Rekhan timers, changed messages for first Locust Swarm
-- adjusted Gluth's Decimate timer
-- changed Razuvious timers to use repeating status bars, this will fix issues after a wipe
--
-- Warsong Gulch InfoFrame added
-- added Four Horseman support
-- added Thaddius phase 1 support (Kick and Power Surge)
-- added Azuregos support (beta)
-- added Sapphiron support (beta)
-- added Kel'Thuzad support (beta)
-- added Geddon Inferno warning
-- added Loatheb Spore spawn timers
-- added bug explode warning to the Twin Emperor mod
-- added stats for Patchwerk fights (Hateful Strikes: x Hits: y Misses: z Dodges: blah...etc)
-- added option to remove healers from the Loatheb heal rotation frame by setting their sort ID to 0, use /loa undelete to undelete them
-- added OnStop handlers for boss mods, they will be called if the boss mod is stopped by a "stop all" sync command or by the "stop AddOn" button/slash command
-- added function LVBM.SendHiddenWhisper(msg, target) do send hidden whisper messages
-- added option to announce timers to your raid group by shift + left-clicking on the status bar
-- added combat detection system, this allows many combat related features, like the auto respond function. You will also see how long you were in combat in the chat frame :)
-- added "auto respond to whisper" function while fighting bosses (only enabled for whispers from players who are not in your raid group)
-- added OnCombatStart and OnCombatEnd handlers to all boss mods. Since they will be synced, they will allow more accurate and dependable timers for the first use of some abilities
-- added function LVBM.StartColoredStatusBarTimer() to create colored status bars, this color will overwrite the color set be the user, see API documentation for details
-- added more designs for status bars, see options menu and screenshots :)
--
--
--
--  v1.80
--  *** you need to restart your game after installing Vendetta Boss Mods 1.80 ***
--  fixed LVBM.Rank bug
--  fixed ZG/AQ20 bugs
--  fixed Onyxia
--  fixed Thaddius phase 2
--  fixed Gothik timer repetitions
--  fixed some minor bugs
--
--  updated Patchwerk boss mod
--  updated Thaddius boss mod
--  updated Noth boss mod
--  updated Anub boss mod
--  updated Faerlina boss mod
--  updated battleground mod
--  changed battleground timer sync channel from "RAID" to "BATTLEGROUND"
--  adjusted frenzy timers
--
--  added "C'Thun pulled" and C'Thun phase 2 sync commands, this will fix "timer adjustment failed" and missing special warnings for dark glare
--  added a range check frame to the C'Thun boss mod
--  added cool Loatheb boss mod (see screenshot!)
--  added Kri/Yauj/Vem mod
--  added Lethon/Taerar/Ysondre/Emeriss boss mod
--  added option to resize the status bars
--  added option to resize the special warnings
--  added german localization
--  added chinese localization (simplified chinese by Killerking, traditional chinese by hmj1026)
--  added function LVBM.UpdateStatusBarTimer(name[, elapsed, timer, newName, noBroadcast])
--  added functions to create frames, see "Information for AddOn Developers"
--
--
--  v1.71
--  fixed Ahn'Qiraj 20 mods
--  fixed Zul'Gurub mods
--  fixed 1.12 emote strings
--  fixed C'Thun phase 2 detection
--  
--  added option to copy and paste the URL when a newer version is available
--  added option to unequip bows and guns before Nefarian's class call
--  added auto turn-in function for Alterac Valley
--  added option to hide the local and/or raid warning frame
--  changed shake default setting to disabled
--
--
--  v1.70
--  *** german localization for options and mc, zg and aq20 is missing...coming soon! ***
--  fixed Viscidus mod
--  fixed hunter feign death bug, PLAYER_REGEN_DISABLED will now be ignored if player is a hunter and has feigned death in the last 20 seconds
--  fixed CastSpellByName() bug
--  fixed many minor bugs
--
--  changed "special warning" default color to blue
--  adjusted Nefarian phase 2 timer
--  adjusted Anub'Rekhan timers
--  reduced sync channel spam
--  optimized code
--  redesigned options frame
--
--  added support for SendAddonMessage/CHAT_MSG_ADDON, removed sync channel!
--  added Molten Core boss mods
--  added AQ20 boss mods (beta!)
--  added Zul'Gurub boss mods (beta!)
--  added Fankriss boss mod
--  added Options to customize the local warning frame
--  added variable LVBM.Rank which always contains your current rank (0 = nothing, 1 = promoted, 2 = leader). This variable is updated on RAID_ROSTER_UPDATE
--  added aggro alert
--  added a range check...use /range to see who is more than 30 yards away
--  added frenzy timers
--  added special warning for Faerlina's enrage if the player is currently mind controlling one the Worshippers
--  added function LVBM_Gui_AddTab(instance, text) to add a new tab, removed old hardcoded tabs
--  added support for battlegrounds (by LeoLeal - thank you!)
--  added option to block healing spells while Nefarian's priest call is active
--
--
--  v1.60
--  fixed Huhuran mod
--  fixed C'Thun whisper spam, whispers will only be sent if announce is enabled
--  fixed Ouros emerge timer when standing too far away from the Dirt Mounds
--  fixed Chromaggus Fenzy bug xD
--  fixed a bug that stopped status bars while the UI was hidden or the map was shown
--  fixed math.round function
--
--  changed Gothik mod to use the new repeating timers, this will fix bars that restarted in the first 0.5 seconds
--  changed Grobbulus addon to use other raid target icons if the skull set on another player with Mutating Injection
--  changed status bar tooltip to display the name of the boss mod instead of the internal used abbreviation
--  /lv stop will no longer kill "Pizza Timers" :)
--
--  added options to change the raid warning frame's position, font size and font color
--  added "special warnings"
--  added screen shake effect (default setting: enabled, you can disable it in the options tab)
--  added flash effect
--  added LVBM.AddSpecialWarning() to add a special warning, see "Information for AddOn developers" for details
--  added LVBM.StartRepeatingStatusBarTimer(timer, name[, repetitions, noBroadcast]) to start repeating bars, see "Information for AddOn developers" for details
--  added LVBM.EndRepeatingStatusBarTimer(name[, noBroadcast]) to end a repeating bar, see "Information for AddOn developers" for details.
--  added more options to some boss mods
--  added Thaddius boss mod
--
--
--  v1.50
--  fixed charge bug
--  fixed bloodrage bug
--  fixed spirit of redemption bug
--  fixed auto attack bug. If you still experience this bug, please try to disable other boss mods that use automatic combat start detection. I tested my new combat detection code for hours and this bug is definitely fixed.
--  fixed Sarturas Whirlwind timers
--  fixed Twin Emps enrage timer when player died in combat
--  fixed status bars with long names
--
--  re-enabled PLAYER_REGEN_DISABLED for Rogues and Warriors.
--  rewrote combat detection code
--  added functions LVBM.UnitExists and LVBM.DetectCombat, see "Information for AddOn developers" below
--  changed synchronization commands...so this version will not be able to sync with older clients!
--  status bars that belong to disabled boss mods are now longer shown, even if the bar is synced by another player
--
--  added LVBM.GetBuff() and LVBM.GetDebuff(), see "Information for AddOn developers" below
--  added german translation for GUI and most boss mods
--  added subtabs in the options tab
--  added a dialog (see options tab) to start your own timers
--  added a option to change the raid warning sound
--  added tooltips to the status bars
--  added Heigan the Unclean mod
--  added Gothik the Harvester mod
--  added Huhuran mod
--  added Anubisath Defender mod
--  added /lv stop, this stops all timers, status bars, scheduled tasks. You need to be the raid leader or promoted to use this command.
--  added option to download the patch notes from another player who got a newer version than you






-- ----------------- --
-- API Documentation --
-- ----------------- --
--
-- --------------- --
-- Timer Functions --
-- --------------- --
--  LVBM.Schedule(Delay, NameOrFunction[, Argument1, Argument2]);
--  Delay must be a number. NameOfFunction must be a string or a function. Argument1 & 2 can be strings, numbers, tables, functions etc.
--  Example: LVBM.Schedule(10, "SendChatMessage", "lol", "GUILD"); will write "lol" after 10 sec
--
--  LVBM.UnSchedule(NameOrFunction[, Argument1, Argument2]);
--  If you only specify the name of the function, all scheduled tasks which call this function will be deleted.
--  Example: LVBM.UnSchedule("SendChatMessage", "lol", "GUILD"); will delete the scheduled task of the example above.
--           LVBM.UnSchedule("SendChatMessage"); will delete all scheduled tasks which call SendChatMessage
--
--  timeLeft, timeElapsed = LVBM.GetScheduleTimeLeft(NameOrFunction[, Argument1, Argument2]);
--	Returns the time left until the scheduled function is executed and the time elapsed.
--  Example: timeLeft, timeElapsed = LVBM.GetSchedule("SendChatMessage", "lol", "GUILD")
--  timeLeft will be 9 and timeElapsed will be 1, if you call this function 1 second after the LVBM.Schedule example above
--
--  isScheduled = LVBM.FunctionIsScheduled(func);
--  Returns true if a given function is scheduled to be called
--
--  LVBM.StartTimer("name");
--  Starts a timer.
--
--  elapsed = LVBM.GetTimer("name");
--  Returns the elapsed time since LVBM.StartTimer
--
--  elapsed = LVBM.StopTimer("name");
--  Stops the timer and returns the elapsed time
--
--  elapsed = LVBM.ResumeTimer("name");
--  Resumes a stopped timer and returns the elapsed time
--
--  elapsed = LVBM.EndTimer("name");
--  Deletes a timer and returns the elapsed time
--
--  LVBM.StartStatusBarTimer(timer, "text"[, noBroadcast]);
--  Adds a status bar timer. If noBroadcast is set and is true, the timer won't be broadcasted to the raid group.
--
--  LVBM.StartColoredStatusBarTimer(timer, "text", r, g, b[, a, noBroadcast]);
--  Starts a status bar timer with a specific color, this color will overwrite the color set by the user
--
--  timeLeft, timeElapsed = LVBM.GetStatusBarTimerTimeLeft("text");
--	Returns the time left and the time elapsed of the status bar with the text "text"
--
--  LVBM.EndStatusBarTimer("text"[, noBroadcast]);
--  Removes the status bar timer with the text "text"
--
--  LVBM.StartRepeatingStatusBarTimer(timer, name[, repetitions, noBroadcast])
--  Starts a repeating status bar timer which will be shown "repetitions" times, if repetitions is not set it will be infinite.
--
--  LVBM.StartRepeatingColoredStatusBarTimer(timer, name[, repetitions], r, g, b[, a, noBroadcast]);
--  See StartColoredStatusBarTimer and StartRepeatingStatusBarTimer
--
--  LVBM.EndRepeatingStatusBarTimer(name[, noBroadcast]);
--  End a repeating status bar timer, calling LVBM.EndStatusBarTimer() on a repeating timer will just reset the timer and reduce the times it will be repeated by 1
--
--  LVBM.UpdateStatusBarTimer(name[, elapsed, timer, newName, noBroadcast]);
--  Updates a status bar timer

-- ----------------- --
-- Message Functions --
-- ----------------- --
--  LVBM.AddMsg("message"[, "addon"]);
--  Prints a message in the default chat frame, "addon" is used as prefix...if not set, the boss mod which called the function will be detected automatically and used as prefix
--  Example: LVBM.AddMsg("zomg!");
--
--  LVBM.Announce("message");
--  Announces a message to the raid, using Blizzard's "Raid Warning" chat
--  Example: LVBM.Announce("*** Locust Swarm in 3 sec ***");
--
--  LVBM.SendHiddenWhisper("message", "target");
--  Sends a whisper message which is not displayed in your chat frame

-- ------------------------- --
-- Special Warning Functions --
-- ------------------------- --
--  LVBM.AddSpecialWarning("text", shake, flash);
--  Adds a "Special Warning" with shake and/or flash effect

-- -------------- --
-- Buff Functions --
-- -------------- --
--  buffIndex = LVBM.GetBuff("unitID", "buff");
--  Returns the buff index of a buff on a unit. If the unit does not exist or doesn't have the buff this function will return nil.
--
--  buffIndex = LVBM.GetDebuff("unitID", "debuff");
--  Same as LVBM.GetBuff...just for debuffs

-- -------------- --
-- Icon Functions --
-- -------------- --
--  LVBM.SetIconByName(name, icon);
--  Sets a raid target icon an a player in your raid group
--
--  LVBM.ClearIconByName(name);
--  Removes a raid target icon an a player in your raid group

-- ---------------- --
-- Combat Functions --
-- ---------------- --
--  unitID = LVBM.DetectCombat("name");
--  Detects if a unit with a given name is in combat.
--  Returns nil if unit not found or not in combat, returns unitID if unit found and in combat.
--  This function does not change your target so it's absolute safe to use this.
--  But it will return nil if nobody in your raid group has the unit targeted, but this shouldn't be a problem since this function should be used a few seconds after the pull.
--
--  unitExists = LVBM.UnitExists("name");
--  Detects if a unit with a given name exists.
--  Returns true if unit can be targeted, returns nil if unit can't be targeted, returns nil and does not change targets if  
--  -player is a warrior, rogue, druid or paladin and auto attack is enabled and unit is not the current target
--  -player is a priest and spirit of redemption is active (PLAYER_REGEN_DISABLED is fired when you die with the spirit of redemption talent)
--  -player has used charge, feral charge or bloodrage in the last 7.5 seconds
--  -player has combo points
--  So it is safe to use this function on PLAYER_REGEN_DISABLED.

-- ------------- --
-- GUI functions --
-- ------------- --
--	myInfoFrame = LVBMGui:CreateInfoFrame(title, text);
--	myInfoFrame:SetTitle(title);
--	myInfoFrame:SetText(text);
--
--  myInfoFrameStatusBar = myInfoFrame:CreateStatusBar(min, max, value, title, leftText, rightText);
--  myInfoFrameStatusBar:SetValue(value);
--  myInfoFrameStatusBar:SetTitle(title);
--
--  myInfoFrameTextField = myInfoFrame:CreateTextField(text);
--  myInfoFrameTextField:SetText(text);
--
--	these methods are also available for status bars and text fields
--	myInfoFrame:Show();
--	myInfoFrame:Hide();
--  myInfoFrame:GetObject(); - returns the frame object
--  myInfoFrame:Delete(); - you can not delete frames, but this function hides the frame and moves it to a "trash can"...the frame will be re-used next time you create a frame of this type

if not math.mod and math.fmod then --math.mod will be renamed in burning crusade
	math.mod = math.fmod;
end

LVBM_SavedVars = {
	["AddOns"] = {
	},
	["LVBM"] = {
	},
}

LVBM = {}

LVBM.Version = "1.93";
LVBM.VersionBeta = "(1.93 RC1)";

LVBM.Bosses = {
}

LVBM.ScheduleData = {
}

LVBM.TimerData = {
}

LVBM.StatusBarData = {
}

LVBM.Hooks = {
}

LVBM.SpamProtection = {
}

LVBM.HideDNDAFKMessages = {
};

LVBM.HideLoadInfo = false;

LVBM.InRaid = false;

LVBM.SyncInfo = {
	["Clients"] = {},
};

LVBM.LongMsg = "";

LVBM.AddOns = {	
};

LVBM.MsgQueue = {
};

LVBM.AggroUpdate = 0;

LVBM.MsgQueueElapsed = 0;

LVBM.SortedAddOns = { --table.sort sucks...
};

LVBM.HiddenWhisperMessages = {
};

LVBM.CombatUpdate = 0;

LVBM.Rank = 0;

LVBM.CombatStartTime = GetTime();

LVBM.HideWhispers = false;

LVBM.StatusBarCount = 0;

LVBM.Raid = {
};

LVBM.WhispersDuringCombat = {
};

LVBM.WhisperSpamProtection = {
};

LVBM.StatusSpamProtection = {
};

LVBM.FilteredBars = {
    "Mark #%d+",
    "ABWINALLY",
    "ABWINHORDE",
};

LVBM.LastCharge = GetTime();
LVBM.LastBloodrage = GetTime();
LVBM.LastFeignDeath = GetTime();
LVBM.AutoAttack = false;
LVBM.Options = {
	["StatusBarColor"] = {
		["r"] = 1.0,
		["g"] = 0.7,
		["b"] = 0.0,
		["a"] = 0.8,
	},
	["StatusBarDesign"] = 2,
	["MaxStatusBars"] = 10,
	["StatusBarsFlippedOver"] = false,
	["FillUpStatusBars"] = true,
	["EnableStatusBars"] = true,
	["EnableSync"] = true,
	["AllowSyncFromOldVersions"] = true,
	["MinimapButton"] = {
		["Position"] = 225,
		["Radius"] = 78.1,
		["Enabled"] = true,
	},
	["SpecialWarningsEnabled"] = true,
	["ShakeIntensity"] = 30,
	["ShakeDuration"] = 0.5,
	["SpecialWarningTextDuration"] = 5,
	["SpecialWarningTextFadeTime"] = 3,
	["SpecialWarningTextSize"]	= 40,
	["FlashDuration"] = 2,
	["NumFlashes"] = 1,
	["ShakeEnabled"] = false,
	["FlashEnabled"] = true,
	["FlashColor"] = "red",
	["SpecialWarningTextColor"] = {
		["r"] = 0.0,
		["g"] = 0.0,
		["b"] = 1.0,
		["a"] = 1.0,
	},
	["FirstTimeLoaded191"] = true,
	["StatusBarSize"] = {
		["Scale"] = 1,
		["Width"] = 205,
	},
	["FlashBars"] = true,
	["BusyMessage"] = LVBM_DEFAULT_BUSY_MSG.." "..LVBM_SEND_STATUS_INFO,
	["AutoRespond"] = true,
	["ShowAutoRespondInfo"] = true,
	["ShowWhispersDuringCombat"] = true,
	["HideOutgoingInfoWhisper"] = true,
	["EnableStatusCommand"] = true,
	["ShowCombatInformations"] = true,
	["AutoColorBars"] = true,
};

LVBM.Options.CharSettings = {
};

LVBM.Options.CharSettings[UnitName("player")] = {
};

if UnitClass("player") == LVBM_WARRIOR then
	LVBM.Options.CharSettings[UnitName("player")].AggroAlert = false;
	LVBM.Options.CharSettings[UnitName("player")].AggroSound = false;
	LVBM.Options.CharSettings[UnitName("player")].AggroFlash = false;
	LVBM.Options.CharSettings[UnitName("player")].AggroShake = false;
	LVBM.Options.CharSettings[UnitName("player")].AggroSpecialWarning = false;
	LVBM.Options.CharSettings[UnitName("player")].AggroLocalWarning = false;
else
	LVBM.Options.CharSettings[UnitName("player")].AggroAlert = true;
	LVBM.Options.CharSettings[UnitName("player")].AggroSound = false;
	LVBM.Options.CharSettings[UnitName("player")].AggroFlash = true;
	LVBM.Options.CharSettings[UnitName("player")].AggroShake = true;
	LVBM.Options.CharSettings[UnitName("player")].AggroSpecialWarning = true;
	LVBM.Options.CharSettings[UnitName("player")].AggroLocalWarning = false;
end

---------------------
--OnEvent Functions--
---------------------
function LVBM.OnLoad()
	SLASH_LVNAXXRAMASBOSSMODS1 = "/vendetta";
	SLASH_LVNAXXRAMASBOSSMODS2 = "/lv";
	SLASH_LVNAXXRAMASBOSSMODS3 = "/bossmods";
	SLASH_LVNAXXRAMASBOSSMODS4 = "/bm";
	SLASH_LVNAXXRAMASBOSSMODS5 = "/lvbm";
	SLASH_LVNAXXRAMASBOSSMODS6 = "/lvbossmods";
	SlashCmdList["LVNAXXRAMASBOSSMODS"] = function(msg)
		if string.lower(msg) == "unlock" then
			LVBM_StatusBarTimerDrag:Show();
		elseif string.lower(msg) == "lock" then
			LVBM_StatusBarTimerDrag:Hide();
		elseif string.lower(msg) == "ver" or string.lower(msg) == "version" then
			local syncInfo = {};
			for i = 1, GetNumRaidMembers() do
				if (tonumber(LVBM.SyncInfo.Clients[UnitName("raid"..i)])) then	
					--bla table.sort bla
					table.insert(syncInfo, {["Name"] = UnitName("raid"..i), ["Version"] = LVBM.SyncInfo.Clients[UnitName("raid"..i)]});
--				else
--					table.insert(syncInfo, {["Name"] = UnitName("raid"..i), ["Version"] = 0});
				end
			end
			
			table.sort(syncInfo, function(v1, v2) return tonumber(v1.Version) > tonumber(v2.Version); end);
			for index, value in pairs(syncInfo) do
				LVBM.AddMsg(value.Name..": "..value.Version);
			end
			LVBM.AddMsg(string.format(LVBM_FOUND_CLIENTS, table.getn(syncInfo)));

		elseif string.lower(msg) == "ver2" then
			local syncInfo = {};
			local msg = "";
			for i = 1, GetNumRaidMembers() do
				msg = "raid"..i.." - ";
				msg = msg.."Name: "..UnitName("raid"..i).." - ";
				if (LVBM.SyncInfo.Clients[UnitName("raid"..i)] and LVBM.SyncInfo.Clients[UnitName("raid"..i)] == LVBM.Version) then
					msg = msg.."Version: "..LVBM.SyncInfo.Clients[UnitName("raid"..i)];
				elseif (LVBM.SyncInfo.Clients[UnitName("raid"..i)]) then
					msg = msg.."Version: "..LVBM.SyncInfo.Clients[UnitName("raid"..i)].." OLD";
					LVBM.SendHiddenWhisper("<Vendetta Boss Mods> "..LVBM_YOUR_VERSION_SUCKS, UnitName("raid"..i));
				else
					msg = msg.."Version: -none-";
				end

				LVBM.AddMsg(msg);
			end

			LVBM.AddMsg(string.format(LVBM_FOUND_CLIENTS, i));

		elseif string.lower(msg) == "bars" or string.lower(msg) == "barinfo" or string.lower(msg) == "syncedby" or string.lower(msg) == "syncinfo" then
			local syncedBars = false;
			for index, value in pairs(LVBM.StatusBarData) do
				if value.syncedBy then
					LVBM.AddMsg(index..": "..value.syncedBy);
					syncedBars = true;
				end
			end
			if( syncedBars == false ) then
				LVBM.AddMsg(LVBM_NOSYNCBARS);
			end
		elseif string.lower(msg) == "stop" then
			if LVBM.Rank >= 1 then
				LVBM.AddSyncMessage("ENDALL", true);
				LVBM.AddMsg(LVBM_ALL_STOPPED);
			else
				LVBM.AddMsg(LVBM_NEED_LEADER_STOP_ALL);
			end
		else
			if not LVBMBossModFrame then
				LVBM.AddMsg(LVBM_NOGUI_ERROR);
				return;
			end

			if LVBMBossModFrame:IsShown() then
				HideUIPanel(LVBMBossModFrame);			
			else
				ShowUIPanel(LVBMBossModFrame);
			end
		end
	end

	SLASH_LVRANGECHECK1 = "/range";
	SLASH_LVRANGECHECK2 = "/rangecheck";
	SLASH_LVRANGECHECK3 = "/checkrange";
	SlashCmdList["LVRANGECHECK"] = LVBM.RangeCheck;

	SLASH_LVCLEANUP1 = "/cleanup";
	SlashCmdList["LVCLEANUP"] = LVBM.CleanUp;
	
	LVBM_API:RegisterEvent("VARIABLES_LOADED");
	LVBM_API:RegisterEvent("PLAYER_LOGIN");
	LVBM_API:RegisterEvent("PLAYER_ENTERING_WORLD");
	LVBM_API:RegisterEvent("PLAYER_LEAVING_WORLD");
	LVBM_API:RegisterEvent("CHAT_MSG_WHISPER");
	LVBM_API:RegisterEvent("RAID_ROSTER_UPDATE");
	LVBM_API:RegisterEvent("PLAYER_ENTER_COMBAT");
	LVBM_API:RegisterEvent("PLAYER_LEAVE_COMBAT");
	LVBM_API:RegisterEvent("CHAT_MSG_ADDON");
	LVBM_API:RegisterEvent("PLAYER_REGEN_DISABLED");
	LVBM_API:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	LVBM_API:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
	LVBM_API:RegisterEvent("PLAYER_DEAD");
end

function LVBM.RangeCheck()
	local name, playersOutOfRange;
	playersOutOfRange = "";
	for i = 1, GetNumRaidMembers() do
		name = GetRaidRosterInfo(i)
		if name and (not CheckInteractDistance("raid"..i, 4)) then
			playersOutOfRange = playersOutOfRange..UnitName("raid"..i)..", ";
		end						
	end
	LVBM.AddMsg(LVBM_RANGE_CHECK..string.sub(playersOutOfRange, 1, (string.len(playersOutOfRange) - 2)));
end
	
function LVBM.CleanUp()
	if LVBM.Rank >= 1 then
		for i = 1, GetNumRaidMembers() do
			SetRaidTargetIcon("raid"..i, 0);
		end
		LVBM.AddMsg("Cleaned up raid icons!");
	end
end

function LVBM.LoadAddOns()
	local loadedAddOns = {};
	LVBM.SortedAddOns = {};

	for index, value in pairs(LVBM.AddOns) do	--load AddOn's saved variables/add new addons to the LVBM_SavedVars table/set default values for missing fields		
		if not value.Name then
			LVBM.AddOns[index].Name = index;
		end
		if not value.Version then
			LVBM.AddOns[index].Version = "1.0";
		end
		if not value.Author then
			LVBM.AddOns[index].Author = LVBM.Capitalize(LVBM_UNKNOWN);
		end
		if not value.Description then
			LVBM.AddOns[index].Description = LVBM_DEFAULT_DESCRIPTION;
		end
		if not value.Instance then
			LVBM.AddOns[index].Instance = LVBM_OTHER;
		end
		if (value.Instance ~= LVBM_AQ40) and (value.Instance ~= LVBM_NAXX) and (value.Instance ~= LVBM_BWL) and (value.Instance ~= LVBM_MC) and (value.Instance ~= LVBM_ZG) and (value.Instance ~= LVBM_AQ20) and (value.Instance ~= LVBM_OTHER) then
			LVBM.AddOns[index].Instance = LVBM_OTHER;
		end
		if not value.GUITab then
			LVBM.AddOns[index].GUITab = (LVBMGUI_TAB_OTHER or "Other");
		end
		if not value.Sort then
			value.Sort = 9999;
		end
		if not value.Options then
			LVBM.AddOns[index].Options = {
				["Enabled"] = true,
				["Announce"] = false,
			}
		end		
		if value.Options.Enabled == nil then --not value.Options.Enabled would return true if the AddOn is disabled....and the next line would enable the addon
			LVBM.AddOns[index].Options.Enabled = true;
		end
		if not value.Events then
			LVBM.AddOns[index].Events = {};
		end
		if type(value.OnLoad) ~= "function" then
			LVBM.AddOns[index].OnLoad = function() end;
		end
		if type(value.OnEvent) ~= "function" then
			LVBM.AddOns[index].OnEvent = function() end;
		end
		if not value.UpdateInterval then
			LVBM.AddOns[index].UpdateInterval = 0;
		end
		if not value.elapsed then
			LVBM.AddOns[index].elapsed = 0;
		end

		if LVBM_SavedVars.AddOns[index] == nil then --load saved vars
			LVBM_SavedVars.AddOns[index] = value.Options
		else
			for index2, value2 in pairs(value.Options) do				
				if LVBM_SavedVars.AddOns[index][index2] == nil then					
					LVBM_SavedVars.AddOns[index][index2] = value2;
				else
					LVBM.AddOns[index].Options[index2] = LVBM_SavedVars.AddOns[index][index2];
				end
			end
		end
				
		setglobal("SLASH_"..index.."1", "/"..string.gsub(value.Name, " ", "")); --register slash commands
		for i = 1, 10 do
			if value["Abbreviation"..i] then
				setglobal("SLASH_"..index..(i+1), "/"..value["Abbreviation"..i]);
			else
				break;
			end
		end

		loadstring("SlashCmdList["..string.format('%q', index).."] = function(msg)\n"..
			"local abbrString = '';\n"..
			"if string.lower(msg) == 'on' then\n"..
				"LVBM.AddOns["..string.format('%q', index).."].Options.Enabled = true;\n"..
				"LVBM.AddMsg(LVBM_MOD_ENABLED, "..string.format('%q', value.Name)..");\n"..				
			"elseif string.lower(msg) == 'off' then\n"..
				"LVBM.AddOns["..string.format('%q', index).."].Options.Enabled = false;\n"..
				"LVBM.UnSchedule('LVBM.AddOns."..index..".OnEvent');\n"..
				"LVBM.AddMsg(LVBM_MOD_DISABLED, "..string.format('%q', value.Name)..");\n"..
			"elseif string.lower(msg) == 'announce on' then\n"..
				"LVBM.AddOns["..string.format('%q', index).."].Options.Announce = true;\n"..
				"LVBM.AddMsg(LVBM_ANNOUNCE_ENABLED, "..string.format('%q', value.Name)..");\n"..
			"elseif string.lower(msg) == 'announce off' then\n"..
				"LVBM.AddOns["..string.format('%q', index).."].Options.Announce = false;\n"..
				"LVBM.AddMsg(LVBM_ANNOUNCE_DISABLED, "..string.format('%q', value.Name)..");\n"..
			"elseif string.lower(msg) == 'stop' then\n"..
				"if type(LVBM.AddOns["..string.format('%q', index).."].OnStop) == 'function' then\n"..
					"LVBM.AddOns["..string.format('%q', index).."].OnStop()\n"..
				"end\n"..
				"LVBM.UnSchedule('LVBM.AddOns."..index..".OnEvent');\n"..
				"for index2, value2 in pairs(LVBM.StatusBarData) do\n"..
					"if index2 then\n"..
						"if LVBM.AddOns["..string.format('%q', index).."].Name == value2.startedBy then\n"..
							"LVBM.EndRepeatingStatusBarTimer(index2)\n"..
						"end\n"..
					"end\n"..
				"end\n"..
				"LVBM.AddMsg(LVBM_MOD_STOPPED, "..string.format('%q', value.Name)..");\n"..
			"else\n"..			
				"if type(LVBM.AddOns["..string.format('%q', index).."].OnSlashCommand) == 'function' then\n"..
					"if LVBM.AddOns["..string.format('%q', index).."].OnSlashCommand(msg) then\n"..
						"return;\n"..
					"end\n"..
				"end\n"..
			
				"LVBM.AddMsg(string.format(LVBM_MOD_INFO, LVBM.AddOns["..string.format('%q', index).."].Version, LVBM.AddOns["..string.format('%q', index).."].Author), "..string.format('%q', value.Name)..");\n"..
				"LVBM.AddMsg('/'..string.gsub(LVBM.AddOns["..string.format('%q', index).."].Name, ' ', '')..LVBM_SLASH_HELP1, "..string.format('%q', value.Name)..");\n"..
				"LVBM.AddMsg('/'..string.gsub(LVBM.AddOns["..string.format('%q', index).."].Name, ' ', '')..LVBM_SLASH_HELP2, "..string.format('%q', value.Name)..");\n"..
				"LVBM.AddMsg('/'..string.gsub(LVBM.AddOns["..string.format('%q', index).."].Name, ' ', '')..LVBM_SLASH_HELP3, "..string.format('%q', value.Name)..");\n"..
				"if type(LVBM.AddOns["..string.format('%q', index).."].SlashCmdHelpText) == 'table' then\n"..
					"for index, value in pairs(LVBM.AddOns["..string.format('%q', index).."].SlashCmdHelpText) do\n"..
						"if type(value) == 'string' then\n"..
							"LVBM.AddMsg(value, "..string.format('%q', value.Name)..");\n"..
						"end\n"..
					"end\n"..
				"end\n"..
					
				"if type(LVBM.AddOns["..string.format('%q', index).."].Abbreviation1) == 'string' then\n"..
					"abbrString = '/'..LVBM.AddOns["..string.format('%q', index).."].Abbreviation1;\n"..
				"end\n"..
				"if type(LVBM.AddOns["..string.format('%q', index).."].Abbreviation2) == 'string' and (not type(LVBM.AddOns["..string.format('%q', index).."].Abbreviation3) == 'string') then\n"..
					"abbrString = abbrString..' '..LVBM_OR..' /'..LVBM.AddOns["..string.format('%q', index).."].Abbreviation2;\n"..
				"elseif type(LVBM.AddOns["..string.format('%q', index).."].Abbreviation3) == 'string' then\n"..
					"abbrString = abbrString..', /'..LVBM.AddOns["..string.format('%q', index).."].Abbreviation2..' '..LVBM_OR..' /'..LVBM.AddOns["..string.format('%q', index).."].Abbreviation3;\n"..
				"end\n"..
					
				"if abbrString ~= '' then\n"..
					"LVBM.AddMsg(string.format(LVBM_SLASH_HELP4, abbrString, string.gsub(LVBM.AddOns["..string.format('%q', index).."].Name, ' ', '')), "..string.format('%q', value.Name)..");\n"..
				"end\n"..
			"end\n"..
		"end")();			

		if not loadedAddOns[value.Instance] then
			loadedAddOns[value.Instance] = 1;
		else
			loadedAddOns[value.Instance] = loadedAddOns[value.Instance] + 1;
		end
		
		LVBM.AddOns[index].OnLoad();
		
		table.insert(LVBM.SortedAddOns, index);		
	end
	if( not LVBM.HideLoadInfo ) then
		for index, value in pairs(loadedAddOns) do
			LVBM.AddMsg(string.format(LVBM_MODS_LOADED, value, index));
		end
		LVBM.HideLoadInfo = true;
	end
	table.sort(LVBM.SortedAddOns, function(v1, v2) return LVBM.AddOns[v1].Sort < LVBM.AddOns[v2].Sort; end);
	LVBM.Register();
end


function LVBM.OnVarsLoaded()
	local loadedAddOns = {};
	LVBM.Register();

	LVBM.AddMsg(string.format(LVBM_LOADED, LVBM.Version));
	
	if not LVBM_SavedVars.LVBM then --if we update from v0.5 or lower, we dont have this field...
		LVBM_SavedVars.LVBM = {} --...so we have to create it
	end
	
	for index, value in pairs(LVBM.Options) do --load saved vars
		if LVBM_SavedVars.LVBM[index] == nil then
			LVBM_SavedVars.LVBM[index] = value;
		elseif type(LVBM_SavedVars.LVBM[index]) == "table" and type(LVBM.Options[index]) == "table" and index ~= "CharSettings" then
			for index2, value2 in pairs(LVBM.Options[index]) do
				if LVBM_SavedVars.LVBM[index][index2] == nil then
					LVBM_SavedVars.LVBM[index][index2] = value;
				elseif type(LVBM_SavedVars.LVBM[index][index2]) == "table" and type(LVBM.Options[index][index2]) == "table" then
					for index3, value3 in pairs(LVBM.Options[index][index2]) do
						if LVBM_SavedVars.LVBM[index][index2][index3] == nil then
							LVBM_SavedVars.LVBM[index][index2][index3] = value;
						else
							LVBM.Options[index][index2][index3] = LVBM_SavedVars.LVBM[index][index2][index3];
						end				
					end
				else
					LVBM.Options[index][index2] = LVBM_SavedVars.LVBM[index][index2];
				end				
			end
		elseif index == "CharSettings" then
			for index2, value2 in pairs(LVBM.Options[index]) do
				if LVBM_SavedVars.LVBM[index][index2] == nil then
					LVBM_SavedVars.LVBM[index][index2] = LVBM.Options[index][index2];
				else
					LVBM.Options[index][index2] = LVBM_SavedVars.LVBM[index][index2];
				end
			end
			for index2, value2 in pairs(LVBM_SavedVars.LVBM[index]) do
				if LVBM.Options[index][index2] == nil then
					LVBM.Options[index][index2] = LVBM_SavedVars.LVBM[index][index2];
				else
					LVBM_SavedVars.LVBM[index][index2] = LVBM.Options[index][index2];
				end
			end
		else
			LVBM.Options[index] = LVBM_SavedVars.LVBM[index];
		end
	end	

	LVBMSpecialWarningFrameText:SetFont(STANDARD_TEXT_FONT, LVBM.Options.SpecialWarningTextSize, "THICKOUTLINE");
	LVBMStatusBars_ChangeDesign(LVBM.Options.StatusBarDesign, true);
	
	if GetNumRaidMembers() > 1 then
		LVBM.AddSyncMessage("REQ VER "..LVBM.Version, true);
		LVBM.InRaid = true;
		local name, rank;
		for i = 1, GetNumRaidMembers() do
			name, rank = GetRaidRosterInfo(i);
			if UnitName("player") == name then
				LVBM.Rank = rank;
			end
			LVBM.Raid[name] = rank;
		end
	end
	
	LVBM.LoadAddOns();
	
	if type(ForgottenChat_Blacklist) == "table" then
		local foundLVBM, foundLVPN;
		for index, value in pairs(ForgottenChat_Blacklist) do
			if value == "LVBM" then
				foundLVBM = true;
			elseif value == "LVPN" then
				foundLVPN = true;
			end
		end
		if not foundLVBM then
			table.insert(ForgottenChat_Blacklist, "LVBM")
		end
		if not foundLVPN then
			table.insert(ForgottenChat_Blacklist, "LVPN");
		end
	end
	if type(WIM_Filters) == "table" then
		WIM_Filters["^LVBM"] = "Ignore";
		WIM_Filters["^LVPN"] = "Ignore";
	end
	
	if LVBM.Options.FirstTimeLoaded191 then
		LVBM.Options.Gui.RaidWarning_Font = STANDARD_TEXT_FONT;
		LVBM.Options.Gui.SelfWarning_Font = STANDARD_TEXT_FONT;
		LVBM.Options.StatusBarDesign = 2;
		LVBM.Options.StatusBarColor = {
			["r"] = 1.0,
			["g"] = 0.7,
			["b"] = 0.0,
			["a"] = 0.8,
		};
		LVBM.Options.StatusBarSize = {
			["Scale"] = 1,
			["Width"] = 205,
		};
		LVBM.Options.BusyMessage = LVBM_DEFAULT_BUSY_MSG.." "..LVBM_SEND_STATUS_INFO;
		if( LVBM.AddOns.FourHorsemen ) then 	LVBM.AddOns.FourHorsemen.Options.Enabled = true;	end
		if( LVBM.AddOns.Sapphiron ) then	LVBM.AddOns.Sapphiron.Options.Enabled = true;		end
		if( LVBM.AddOns.Kelthuzad ) then	LVBM.AddOns.Kelthuzad.Options.Enabled = true;		end
		LVBM.Options.FirstTimeLoaded191 = false;
	end
end

function LVBM.OnEvent(event, arg1)
	if (event == "VARIABLES_LOADED") then
		LVBM.OnVarsLoaded();
	elseif (event == "PLAYER_LOGIN") then
		LVBM.SetHooks();
	elseif (event == "PLAYER_ENTERING_WORLD") then
		if (GetRealZoneText() == LVBM_NAXX) then
			LoadAddOn("LVBM_NAXX");
			LVBosses_Load_Naxx();

		elseif (GetRealZoneText() == LVBM_AQ40) then
			LoadAddOn("LVBM_AQ40");
			LVBosses_Load_AQ40();

		elseif (GetRealZoneText() == LVBM_BWL) then
			LoadAddOn("LVBM_BWL");
			LVBosses_Load_BWL();

		elseif (GetRealZoneText() == LVBM_MC) then
			LoadAddOn("LVBM_MC");
			LVBosses_Load_MC();

		elseif (GetRealZoneText() == LVBM_AQ20) then
			LoadAddOn("LVBM_AQ20");
			LVBosses_Load_AQ20();

		elseif (GetRealZoneText() == LVBM_ZG) then
			LoadAddOn("LVBM_ZG");
			LVBosses_Load_ZG();
		end
		
		LoadAddOn("LVBM_Other");
		LVBM.LoadAddOns();
	
	elseif (event == "PLAYER_LEAVING_WORLD") then
		LVBM_SavedVars.LVBM = LVBM.Options; --save variables
		for index, value in pairs(LVBM.AddOns) do
			LVBM_SavedVars.AddOns[index] = value.Options; --save AddOn variables
		end
	elseif (event == "CHAT_MSG_ADDON") and ((arg1 == "LVBM") or (arg1 == "LVBM NSP")) and arg2 and (arg3 == "RAID" or arg3 == "BATTLEGROUND") and (LVBM.Options.EnableSync) then
		if arg1 == "LVBM NSP" then
			LVBM.OnSyncMessage(arg2, arg4, true);
		elseif arg1 == "LVBM" then
			LVBM.OnSyncMessage(arg2, arg4);
		end
	elseif (event == "CHAT_MSG_WHISPER") and ((string.sub(arg1, 1, 4) == "LVPN") or (string.sub(arg1, 1, 5) == "LVBM ")) then
		if string.sub(arg1, 1, 5) == "LVPNS" then
			LVBM.OnPatchnoteMessage(string.sub(arg1, 6), false);
		elseif string.sub(arg1, 1, 5) == "LVPNL" then
			LVBM.OnPatchnoteMessage(string.sub(arg1, 6), true);
		elseif string.sub(arg1, 1, 7) == "LVPNREQ" then
			local version, language;
			_, _, version, language = string.find(arg1, "LVPNREQ ([^%s]+) (%w+)");
			LVBM.SendPatchnotes(arg2, version, language);
		elseif string.sub(arg1, 1, 5) == "LVBM " and string.sub(arg1, 6, 7) ~= "SC" then
			LVBM.OnSyncMessage(string.sub(arg1, 6), arg2, true);
		end
	elseif (event == "RAID_ROSTER_UPDATE") then
		local name, rank;
		if GetNumRaidMembers() > 1 then
			if not LVBM.InRaid then
				LVBM.InRaid = true;
				LVBM.AddSyncMessage("REQ VER "..LVBM.Version, true);
			end
			LVBM.Raid = {};
			for i = 1, GetNumRaidMembers() do
				name, rank = GetRaidRosterInfo(i);
				if UnitName("player") == name then
					LVBM.Rank = rank;
				end
				LVBM.Raid[name] = rank;
			end
		else
			if LVBM.InRaid then
				LVBM.InRaid = false;
			end
		end
	elseif (event == "PLAYER_ENTER_COMBAT") then
		LVBM.AutoAttack = true;
	elseif (event == "PLAYER_LEAVE_COMBAT") then
		LVBM.AutoAttack = false;
	elseif (event == "PLAYER_REGEN_DISABLED") then
		if LVBM.Bosses[GetRealZoneText()] and not LVBM.InCombat then
			local bossTable = {};
			local bosses = {};
			
			for index, value in pairs(LVBM.Bosses[GetRealZoneText()]) do
				if value.startMethod == "COMBAT" then
					bossTable[value.name] = {["index"] = index, ["value"] = value};
					table.insert(bosses, value.name);
				end
			end
			bosses = LVBM.UnitExists(bosses);
			if bosses then
				for index, value in pairs(bosses) do
					if value then
						LVBM.Schedule((bossTable[index].value.delay or 5), 	function(bossID)							
							if LVBM.Bosses[GetRealZoneText()] and LVBM.Bosses[GetRealZoneText()][bossID] then
								if LVBM.DetectCombat(LVBM.Bosses[GetRealZoneText()][bossID].name) then
									LVBM.CombatStart(bossID, (LVBM.Bosses[GetRealZoneText()][bossID].delay or 5));
								end
							end
						end, bossTable[index].index);
					end
				end
			end
		end
	elseif (event == "ZONE_CHANGED_NEW_AREA") then
		LVBM.CombatEnd();

		if (GetRealZoneText() == LVBM_NAXX) then
			LoadAddOn("LVBM_NAXX");
			LVBM.LoadAddOns();
			LVBosses_Load_Naxx();

		elseif (GetRealZoneText() == LVBM_AQ40) then
			LoadAddOn("LVBM_AQ40");
			LVBM.LoadAddOns();
			LVBosses_Load_AQ40();

		elseif (GetRealZoneText() == LVBM_BWL) then
			LoadAddOn("LVBM_BWL");
			LVBM.LoadAddOns();
			LVBosses_Load_BWL();

		elseif (GetRealZoneText() == LVBM_MC) then
			LoadAddOn("LVBM_MC");
			LVBM.LoadAddOns();
			LVBosses_Load_MC();

		elseif (GetRealZoneText() == LVBM_AQ20) then
			LoadAddOn("LVBM_AQ20");
			LVBM.LoadAddOns();
			LVBosses_Load_AQ20();

		elseif (GetRealZoneText() == LVBM_ZG) then
			LoadAddOn("LVBM_ZG");
			LVBM.LoadAddOns();
			LVBosses_Load_ZG();
		end


	elseif (event == "PLAYER_DEAD") then
		LVBM.EndHideWhispers();
	elseif (event == "CHAT_MSG_COMBAT_HOSTILE_DEATH") then
		local mobName
		_, _, mobName = string.find(arg1, string.gsub(UNITDIESOTHER, "%%s", "(.+)"));
		if mobName and LVBM.Bosses[GetRealZoneText()] then
			for index, value in pairs(LVBM.Bosses[GetRealZoneText()]) do
				if type(value.killName) == "table" then
					for index2, value2 in pairs(value.killName) do
						if value2.name == mobName then
							LVBM.CombatEnd(nil, nil, mobName)
						end
					end
				else
					if (value.killName or value.name) == mobName then
						LVBM.CombatEnd((value.killName or value.name));
					end
				end
			end
		end
	elseif (event == "CHAT_MSG_MONSTER_YELL") then
		if LVBM.Bosses[GetRealZoneText()] and not LVBM.InCombat then
			for index, value in pairs(LVBM.Bosses[GetRealZoneText()]) do
				if value.startMethod == "YELL" then
					if value.startTrigger[arg1] then
						LVBM.CombatStart(index, 0);
					end
				end
			end
		end
	elseif (event == "CHAT_MSG_MONSTER_EMOTE") then
		if LVBM.Bosses[GetRealZoneText()] and not LVBM.InCombat then
			for index, value in pairs(LVBM.Bosses[GetRealZoneText()]) do
				if value.startMethod == "EMOTE" then
					if value.startTrigger[arg1] then
						LVBM.CombatStart(index, 0);
					end
				end
			end
		end
	end
	for index, value in pairs(LVBM.AddOns) do
		if value.Options.Enabled and value.Events[event] and ((value.Instance == LVBM_OTHER) or (value.Instance == GetRealZoneText()) or (not (GetLocale() == "deDE" or GetLocale() == "enGB" or GetLocale() == "enUS"))) then
			LVBM.AddOns[index].OnEvent(event, arg1);
		end
	end
end


function LVBM.OnUpdate(elapsed)
	for index, value in pairs(LVBM.TimerData) do
		if not value.stopped then
			LVBM.TimerData[index].elapsed = LVBM.TimerData[index].elapsed + elapsed;
		end
	end
	for index = table.getn(LVBM.ScheduleData), 1, -1 do
		value = LVBM.ScheduleData[index];
		if LVBM.ScheduleData[index] then --to prevent an error, when a scheduled function tries to unschedule itself oO
			LVBM.ScheduleData[index].elapsed = LVBM.ScheduleData[index].elapsed + elapsed;
			if LVBM.ScheduleData[index].elapsed >= LVBM.ScheduleData[index].timer then
				if type(value.func) == "function" then
					value.func(value.argument1, value.argument2);
				elseif type(value.func) == "string" then
					LVBM.ScheduleData.func = function() end;
					LVBM.ScheduleData.func = loadstring(value.func.."(".."value.argument1, value.argument2"..")") --getglobal() does not work in table values...getglobal("LVBM.AddMsg")("test") --> attempt to call a nil value :(
					LVBM.ScheduleData.func();
				end
				table.remove(LVBM.ScheduleData, index);
			end
		end
	end	
	for index, value in pairs(LVBM.SpamProtection) do
		LVBM.SpamProtection[index] = LVBM.SpamProtection[index] - elapsed;
		if LVBM.SpamProtection[index] <= 0 then
			LVBM.SpamProtection[index] = nil;
		end
	end	
	LVBM.MsgQueueElapsed = LVBM.MsgQueueElapsed + elapsed;
	if LVBM.MsgQueueElapsed >= 0.1 then
		LVBM.MsgQueueElapsed = 0;
		if LVBM.MsgQueue[1] then
			if LVBM.MsgQueue[1].longMsg then
				SendChatMessage("LVPNL"..LVBM.MsgQueue[1].msg, "WHISPER", nil, LVBM.MsgQueue[1].target);
			else
				SendChatMessage("LVPNS"..LVBM.MsgQueue[1].msg, "WHISPER", nil, LVBM.MsgQueue[1].target);
			end
			table.remove(LVBM.MsgQueue, 1)			
		end
	end	
	for index, value in pairs(LVBM.AddOns) do 
		--execute the OnUpdate functions of the addons
		if value.Options.Enabled and type(value.OnUpdate) == "function" then
			if value.Instance == GetRealZoneText() 
			or value.Instance == LVBM_OTHER 
			or (not (GetLocale() == "deDE" or GetLocale() == "enGB" or GetLocale() == "enUS")) then		

				LVBM.AddOns[index].elapsed = LVBM.AddOns[index].elapsed + elapsed;
				if value.elapsed > value.UpdateInterval then
					LVBM.AddOns[index].OnUpdate(LVBM.AddOns[index].elapsed);
					LVBM.AddOns[index].elapsed = 0;
				end
			end
		end
	end
	for i = 1, LVBM.StatusBarCount do
		local frame = getglobal("LVBM_StatusBarTimer"..i);
		local frameBar = getglobal("LVBM_StatusBarTimer"..i.."Bar");
		if frame:IsShown() and not frame:IsVisible() then
			if frame.isUsed and LVBM.StatusBarData[frame.usedBy] then
				LVBM.StatusBarData[frame.usedBy].elapsed = LVBM.StatusBarData[frame.usedBy].elapsed + elapsed;
				if LVBM.Options.FillUpStatusBars then
					frameBar:SetValue(LVBM.StatusBarData[frame.usedBy].elapsed);
				else
					frameBar:SetValue(LVBM.StatusBarData[frame.usedBy].timer - LVBM.StatusBarData[frame.usedBy].elapsed);
				end
				getglobal(frameBar:GetName().."Timer"):SetText(LVBM.SecondsToTime(LVBM.StatusBarData[frame.usedBy].timer - LVBM.StatusBarData[frame.usedBy].elapsed));
				if LVBM.StatusBarData[frame.usedBy].elapsed >= LVBM.StatusBarData[frame.usedBy].timer then
					if GameTooltip:IsShown() and GameTooltipTextLeft1 and GameTooltipTextLeft1:GetText() == getglobal(frameBar:GetName().."Text"):GetText() and ((not LVBM.StatusBarData[frame.usedBy].repetitions) or LVBM.StatusBarData[frame.usedBy].repetitions <= 1) then
						GameTooltip:Hide();
					end
					LVBM.EndStatusBarTimer(frame.usedBy, true);
				end
			end
		end
	end
	LVBM.AggroUpdate = LVBM.AggroUpdate + elapsed;
	if LVBM.AggroUpdate > 1 and LVBM.Options.CharSettings[UnitName("player")].AggroAlert and ((GetRealZoneText() == LVBM_NAXX) or (GetRealZoneText() == LVBM_AQ40) or (GetRealZoneText() == LVBM_BWL) or (GetRealZoneText() == LVBM_MC) or (GetRealZoneText() == LVBM_AQ20) or (GetRealZoneText() == LVBM_ZG) or (not (GetLocale() == "deDE" or GetLocale() == "enGB" or GetLocale() == "enUS"))) then
		local posX, posY;
		posX, posY = GetPlayerMapPosition("player");
		LVBM.AggroUpdate = 0;
		if posX == 0 and posY == 0 then
			for i = 1, GetNumRaidMembers() do
				if UnitName("raid"..i.."targettarget") == UnitName("player") and not UnitIsPlayer("raid"..i.."target") then
					if LVBM.LastAggroTarget ~= UnitName("raid"..i.."target") then
						LVBM.HasAggro(UnitName("raid"..i.."target"));
						LVBM.LastAggroTarget = UnitName("raid"..i.."target");
						LVBM.AggroUpdate = -12.5
						LVBM.Schedule(25, function(target) if LVBM.LastAggroTarget == target then LVBM.LastAggroTarget = nil; end end, LVBM.LastAggroTarget)
					end
					break;
				end
			end
		end
	end
	LVBM.CombatUpdate = LVBM.CombatUpdate + elapsed;
	if LVBM.InCombat and LVBM.CombatUpdate > 2 then
		LVBM.CombatUpdate = 0;
		if not UnitAffectingCombat("player") and not UnitIsDead("player") and not LVBM.GetScheduleTimeLeft("LVBM.CheckForCombatEnd") then
			if LVBM.Bosses[GetRealZoneText()] and LVBM.Bosses[GetRealZoneText()][LVBM.InCombat] then
				if not LVBM.Bosses[GetRealZoneText()][LVBM.InCombat].minCombatTime or (GetTime() - LVBM.CombatStartTime) > LVBM.Bosses[GetRealZoneText()][LVBM.InCombat].minCombatTime then
					LVBM.Schedule((LVBM.Bosses[GetRealZoneText()][LVBM.InCombat].combatEndDelay or 10), "LVBM.CheckForCombatEnd");
				end
			end
		end
	end
	for index, value in pairs(LVBM.HideDNDAFKMessages) do
		if type(value) == "number" then
			LVBM.HideDNDAFKMessages[index] = value - elapsed;
			if LVBM.HideDNDAFKMessages[index] <= 0 then
				LVBM.HideDNDAFKMessages[index] = false;
			end
		end
	end
	for index, value in pairs(LVBM.HiddenWhisperMessages) do
		for index2, value2 in pairs(LVBM.HiddenWhisperMessages[index]["targets"]) do
			if type(value2) == "number" then
				LVBM.HiddenWhisperMessages[index]["targets"][index2] = value2 - elapsed;
				if LVBM.HiddenWhisperMessages[index]["targets"][index2] <= 0 then
					LVBM.HiddenWhisperMessages[index]["targets"][index2] = nil;
					local tableSize = 0;
					for index3, value3 in pairs(LVBM.HiddenWhisperMessages[index]["targets"]) do
						tableSize = tableSize + 1;
					end
					if tableSize == 0 then
						LVBM.HiddenWhisperMessages[index] = nil;
					end
				end
			end
		end
	end
end



-------------------
--Timer Functions--
-------------------
function LVBM.Schedule(timer, func, argument1, argument2)
	if (type(timer) ~= "number") or (not func) then
		return;
	end
	
	table.insert(LVBM.ScheduleData, {
		["elapsed"] = 0,
		["timer"] = timer,
		["func"] = func,
		["argument1"] = argument1,
		["argument2"] = argument2,
	});	
end


function LVBM.UnSchedule(func, argument1, argument2)
	if not func then
		return;
	end
	
	if argument1 or argument2 then
		for index = table.getn(LVBM.ScheduleData), 1, -1 do
			value = LVBM.ScheduleData[index];
			if value and value.func == func and value.argument1 == argument1 and value.argument2 == argument2 then
				LVBM.ScheduleData[index] = nil;
			end
		end
	else
		for index = table.getn(LVBM.ScheduleData), 1, -1 do
			value = LVBM.ScheduleData[index];
			if value then
				if value and value.func == func then
					LVBM.ScheduleData[index] = nil;
				end
			end
		end
	end	

end


function LVBM.GetScheduleTimeLeft(func, argument1, argument2)
	if not func then
		return;
	end
	
	for index, value in pairs(LVBM.ScheduleData) do
		if type(value) == "table" then
			if value and value.func == func and value.argument1 == argument1 and value.argument2 == argument2 then
				return (value.timer - value.elapsed), value.elapsed;
			end
		end
	end
end

function LVBM.FunctionIsScheduled(func)
	if not func then
		return;
	end
	
	for index, value in pairs(LVBM.ScheduleData) do
		if type(value) == "table" then
			if value and value.func == func then
				return true;
			end
		end
	end
	return false;
end

function LVBM.StartTimer(name)
	if not name then
		return;
	end
	
	LVBM.TimerData[name] = {
		["elapsed"] = 0,
		["stopped"] = false,
	};	
end


function LVBM.GetTimer(name)
	if (not name) or (not LVBM.TimerData[name]) then
		return 0;
	end
	
	return LVBM.TimerData[name].elapsed;
end


function LVBM.StopTimer(name)
	if (not name) or (not LVBM.TimerData[name]) then
		return 0;
	end
	
	LVBM.TimerData[name].stopped = true;
	return LVBM.TimerData[name].elapsed;
end


function LVBM.ResumeTimer(name)
	if (not name) or (not LVBM.TimerData[name]) then
		return 0;
	end
	
	LVBM.TimerData[name].stopped = false;
	return LVBM.TimerData[name].elapsed;
end


function LVBM.EndTimer(name)
	if (not name) or (not LVBM.TimerData[name]) then
		return 0;
	end
	
	local elapsed = LVBM.TimerData[name].elapsed;
	LVBM.TimerData[name] = nil;
	return elapsed;
end


function LVBM.StartStatusBarTimer(timer, name, noBroadcast, syncedBy, startedBy, repeatingTimer, repetitions, class, colorR, colorG, colorB, colorA)
	if (type(timer) ~= "number") or (not name) or (name == "") or not LVBM.Options.EnableStatusBars then
		return;
	end
	name = tostring(name);
	if type(syncedBy) ~= "string" then
		syncedBy = LVBM_LOCAL;
	else
        for index, value in pairs(LVBM.FilteredBars) do
            if string.find(name, value) then
                return;
            end
        end
    end
	local barId, addon, newAddon;	
	if LVBM.StatusBarData[name] then
		barId = LVBM.StatusBarData[name].barId;
	else
		for i=1, LVBM.StatusBarCount do
			if not getglobal("LVBM_StatusBarTimer"..i).isUsed then
				barId = i;
				break;
			end
		end	
		if not barId then
			barId = LVBMStatusBars_CreateNewBar();
			if not barId then
				return;
			end
		end
	end	
	if not startedBy then
        _, _, addon = string.find(debugstack(2, 2, 2), "\\([%w%s]+).lua");
        if type(addon) == "string" then
            addon = string.gsub(addon, "LV", "");
        else
            _, _, addon = string.find(debugstack(2, 2, 2), "\\[%w%s]+\\([%w%s]+).lua");
            if type(addon) == "string" then
                addon = string.gsub(addon, "LV", "");
            else
                _, _, addon = string.find(debugstack(2, 2, 2), "\\[%w%s]+\\[%w%s]+\\([%w%s]+).lua");
                if type(addon) == "string" then
                    addon = string.gsub(addon, "LV", "");
                else
                    addon = "UNKNOWN";
                end
            end
        end
	else
		addon = startedBy;
	end
	addon = string.gsub(addon, " ", "");
	if addon == "ChatFrame" or addon == "LVBM_API" or addon == "LVBM_GUI" or addon == "LVBM_StatusBars" or addon == "LootLink" then
		addon = "UNKNOWN";
	end

	if addon and addon ~= "UNKNOWN" and addon ~= "" then
		if LVBM.AddOns[addon] and not LVBM.AddOns[addon].Options.Enabled then
			return;
		elseif LVBM.AddOns[addon] and LVBM.AddOns[addon].Name then

			if LVBM.AddOns[addon]["MinVersionToSync"] and syncedBy ~= LVBM_LOCAL then	-- by Nitram!
				if tonumber(LVBM.SyncInfo.Clients[syncedBy]) < tonumber(LVBM.AddOns[addon]["MinVersionToSync"]) then
					-- LVBM.AddMsg("Filtered: "..name.." - "..syncedBy.." - "..addon);
					return;
				end
			end
			if addon == "ThreeBugs" and not LVBM.AddOns[addon].InCombat then --fix me!
				return;
			end
			newAddon = LVBM.AddOns[addon].Name;
		end
	end
	local specialColor, color;
	specialColor = false;
	if tonumber(colorR) and tonumber(colorG) and tonumber(colorB) then
		specialColor = true;
		color = {};
		color.R = tonumber(colorR);
		color.G = tonumber(colorG);
		color.B = tonumber(colorB);
		color.A = tonumber(colorA) or 1;
	end

	if getglobal("LVBM_StatusBarTimer"..barId) then
	
		LVBM.StatusBarData[name] = {
			["elapsed"]	= 0,
			["timer"]	= timer,
			["barId"]	= barId,
			["syncedBy"]	= syncedBy,
			["startedBy"]	= newAddon,
			["isRepeating"]	= repeatingTimer or false,
			["repetitions"]	= repetitions or 300,
			["infinite"]	= (repetitions or 300) > 299,
			["bossModID"]	= addon,
			["color"] 	= color,
			["frame"]	= getglobal("LVBM_StatusBarTimer"..barId),
		};
	
		if LVBM.StatusBarData[name].frame.specialColor and not specialColor then 
			--we need to reset the color if we restart a timer with the same name...but without a specific color
			getglobal(LVBM.StatusBarData[name].frame:GetName().."Bar"):SetStatusBarColor(
											LVBM.Options.StatusBarColor.r, 
											LVBM.Options.StatusBarColor.g, 
											LVBM.Options.StatusBarColor.b, 
											LVBM.Options.StatusBarColor.a
										   );
		end
		LVBM.StatusBarData[name].frame.isUsed = true;
		LVBM.StatusBarData[name].frame.usedBy = name;
		LVBM.StatusBarData[name].frame.syncedBy = syncedBy;
		LVBM.StatusBarData[name].frame.startedBy = newAddon;
		LVBM.StatusBarData[name].frame.isRepeating = repeatingTimer or false;
		LVBM.StatusBarData[name].frame.repetitions = repetitions or 1;
		LVBM.StatusBarData[name].frame.specialColor = specialColor;
		getglobal(LVBM.StatusBarData[name].frame:GetName().."Bar"):SetMinMaxValues(0, timer);
		LVBM.StatusBarData[name].frame.table = LVBM.StatusBarData[name];
		if type(LVBM_SBT[name]) == "string" then
			getglobal(LVBM.StatusBarData[name].frame:GetName().."BarText"):SetText(LVBM_SBT[name]);

		elseif type(LVBM_SBT[addon]) == "table" then
			-- Translation System for Bars with Dynamic Content "Injection: xxxx"
            local newName = name;
			for index, value in pairs(LVBM_SBT[addon]) do
				newName = string.gsub(newName, value[1], value[2]);
			end
			getglobal(LVBM.StatusBarData[name].frame:GetName().."BarText"):SetText(newName);

		else
			getglobal(LVBM.StatusBarData[name].frame:GetName().."BarText"):SetText(name);
		end

		getglobal(LVBM.StatusBarData[name].frame:GetName().."BarTimer"):SetText(LVBM.SecondsToTime(timer));
		if specialColor then
			getglobal(LVBM.StatusBarData[name].frame:GetName().."Bar"):SetStatusBarColor(color.R, color.G, color.B, color.A);
		end
		LVBM.StatusBarData[name].frame:Show();

	end
	if not noBroadcast then
		if specialColor then
			if repeatingTimer then
				if addon == "Battlegrounds" then
					LVBM.AddSyncMessage("STRPCSBT "..timer.." "..LVBM.StatusBarData[name].repetitions.." "..addon.." "..string.format("%1.2f", color.R).."~"..string.format("%1.2f", color.G).."~"..string.format("%1.2f", color.B).."~"..string.format("%1.2f", color.A).." "..name, nil, "BATTLEGROUND");
				else
					LVBM.AddSyncMessage("STRPCSBT "..timer.." "..LVBM.StatusBarData[name].repetitions.." "..addon.." "..string.format("%1.2f", color.R).."~"..string.format("%1.2f", color.G).."~"..string.format("%1.2f", color.B).."~"..string.format("%1.2f", color.A).." "..name);
				end
			else
				if addon == "Battlegrounds" then
					LVBM.AddSyncMessage("STCSBT "..timer.." "..addon.." "..string.format("%1.2f", color.R).."~"..string.format("%1.2f", color.G).."~"..string.format("%1.2f", color.B).."~"..string.format("%1.2f", color.A).." "..name, nil, "BATTLEGROUND");
				else
					LVBM.AddSyncMessage("STCSBT "..timer.." "..addon.." "..string.format("%1.2f", color.R).."~"..string.format("%1.2f", color.G).."~"..string.format("%1.2f", color.B).."~"..string.format("%1.2f", color.A).." "..name);
				end
			end
		else
			if repeatingTimer then
				if addon == "Battlegrounds" then
					LVBM.AddSyncMessage("STRPSBT "..timer.." "..LVBM.StatusBarData[name].repetitions.." "..addon.." "..name, nil, "BATTLEGROUND");
				else
					LVBM.AddSyncMessage("STRPSBT "..timer.." "..LVBM.StatusBarData[name].repetitions.." "..addon.." "..name);
				end
			else
				if addon == "Battlegrounds" then
					LVBM.AddSyncMessage("STSBT "..timer.." "..addon.." "..name, nil, "BATTLEGROUND");
				else
					LVBM.AddSyncMessage("STSBT "..timer.." "..addon.." "..name);
				end
			end
		end
	end	
end

function LVBM.StartRepeatingStatusBarTimer(timer, name, repetitions, noBroadcast, syncedBy, startedBy)	
	LVBM.StartStatusBarTimer(timer, name, noBroadcast, syncedBy, startedBy, true, repetitions)
end

function LVBM.StartColoredStatusBarTimer(timer, name, colorR, colorG, colorB, colorA, noBroadcast, syncedBy, startedBy)
	colorR = tonumber(colorR);
	colorG = tonumber(colorG);
	colorB = tonumber(colorB);
	colorA = tonumber(colorA) or 1;
	LVBM.StartStatusBarTimer(timer, name, noBroadcast, syncedBy, startedBy, nil, nil, nil, colorR, colorG, colorB, colorA);
end

function LVBM.StartRepeatingColoredStatusBarTimer(timer, name, repetitions, colorR, colorG, colorB, colorA, noBroadcast, syncedBy, startedBy)
	colorR = tonumber(colorR);
	colorG = tonumber(colorG);
	colorB = tonumber(colorB);
	colorA = tonumber(colorA) or 1;
	LVBM.StartStatusBarTimer(timer, name, noBroadcast, syncedBy, startedBy, true, repetitions, nil, colorR, colorG, colorB, colorA);
end

function LVBM.StartClassStatusBarTimer(timer, name, class, noBroadcast, syncedBy, startedBy)
	LVBM.StartStatusBarTimer(timer, name, noBroadcast, syncedBy, startedBy, false, nil, class);
end

function LVBM.EndRepeatingStatusBarTimer(name, noBroadcast, syncedBy)
	LVBM.EndStatusBarTimer(name, noBroadcast, syncedBy, true)
end

function LVBM.GetStatusBarTimerTimeLeft(name)
	if (not name) or (not LVBM.StatusBarData[name]) then
		return false;
	end
	
	return (LVBM.StatusBarData[name].timer - LVBM.StatusBarData[name].elapsed), LVBM.StatusBarData[name].elapsed, LVBM.StatusBarData[name].syncedBy;
end


function LVBM.EndStatusBarTimer(name, noBroadcast, syncedBy, endRepeating)
	if (not name) or (not LVBM.StatusBarData[name]) then
		return;
	end
	
	if syncedBy and (not LVBM.SyncInfo.Clients[syncedBy]) then
		return;
	end
	
	local timeLeft, elapsed = LVBM.GetStatusBarTimerTimeLeft(name);
	if syncedBy and elapsed < 3 and (not (endRepeating or LVBM.StatusBarData[name].isRepeating)) then --don't stop new timers on sync!
		return;
	end
	
	if syncedBy and LVBM.StatusBarData[name].isRepeating 
		    and (not endRepeating) 
		    and ((not LVBM.SyncInfo.Clients[syncedBy]) or (LVBM.SyncInfo.Clients[syncedBy] 
		    and tonumber(LVBM.SyncInfo.Clients[syncedBy]) < 1.60)) then
		return;
	end
	
	if LVBM.StatusBarData[name].isRepeating and not endRepeating then
		LVBM.StatusBarData[name].repetitions = LVBM.StatusBarData[name].repetitions - 1
		if LVBM.StatusBarData[name].repetitions <= 0 then
			LVBM.EndStatusBarTimer(name, true, nil, true);
			return;
		else
			getglobal("LVBM_StatusBarTimer"..LVBM.StatusBarData[name].barId).repetitions = LVBM.StatusBarData[name].repetitions;
			LVBM.StatusBarData[name].elapsed = 0;
		end
	else
		if LVBM.StatusBarData[name].frame then
			if LVBM.StatusBarData[name].isFlashing then
				UIFrameFadeRemoveFrame(LVBM.StatusBarData[name].frame);
				UIFrameFlashRemoveFrame(LVBM.StatusBarData[name].frame);
				LVBM.StatusBarData[name].frame:SetAlpha(1.0);
				LVBM.StatusBarData[name].frame.flashTimer = nil;
				LVBM.StatusBarData[name].frame.fadeInTime = nil;
				LVBM.StatusBarData[name].frame.fadeOutTime = nil;
				LVBM.StatusBarData[name].frame.flashDuration = nil;
				LVBM.StatusBarData[name].frame.showWhenDone = nil;
				LVBM.StatusBarData[name].frame.flashTimer = nil;
				LVBM.StatusBarData[name].frame.flashMode = nil;
				LVBM.StatusBarData[name].frame.flashInHoldTime = nil;
				LVBM.StatusBarData[name].frame.flashOutHoldTime = nil;
				LVBM.StatusBarData[name].frame.fadeInfo = nil;
				LVBM.StatusBarData[name].isFlashing = nil;
			end
			LVBM.StatusBarData[name].frame:Hide();	
			LVBM.StatusBarData[name].frame.isUsed = false;
			LVBM.StatusBarData[name].frame.syncedBy = "UNKNOWN";
			LVBM.StatusBarData[name].frame.startedBy = "UNKNOWN";
			LVBM.StatusBarData[name].frame.usedBy = "";
			LVBM.StatusBarData[name].frame.isRepeating = false;
			LVBM.StatusBarData[name].frame.repetitions = 0;
			LVBM.StatusBarData[name].frame.table = nil;
			LVBM.StatusBarData[name].frame.specialColor = false;			
			getglobal(LVBM.StatusBarData[name].frame:GetName().."Bar"):SetStatusBarColor(LVBM.Options.StatusBarColor.r, LVBM.Options.StatusBarColor.g, LVBM.Options.StatusBarColor.b, LVBM.Options.StatusBarColor.a);
			LVBM.StatusBarData[name] = nil;
		end
		
		if not noBroadcast then
			if endRepeating then
				LVBM.AddSyncMessage("ENDRPSBT "..name);
			else
				LVBM.AddSyncMessage("ENDSBT "..name);
			end
		end
		
		LVBMStatusBars_PullTogether();
	end
end

function LVBM.UpdateStatusBarTimer(name, elapsed, timer, newName, noBroadcast)
	if (not name) or (not LVBM.StatusBarData[name]) or (not LVBM.StatusBarData[name].frame) then
		return;
	end
	if newName and LVBM.StatusBarData[newName] then
		return;
	end
	local addon;
	if not startedBy then
		_, _, addon = string.find(debugstack(2, 2, 2), "\\([%w%s]+).lua");
        if type(addon) == "string" then
            addon = string.gsub(addon, "LV", "");
        else
            _, _, addon = string.find(debugstack(2, 2, 2), "\\[%w%s]+\\([%w%s]+).lua");
            if type(addon) == "string" then
                addon = string.gsub(addon, "LV", "");
            else
                _, _, addon = string.find(debugstack(2, 2, 2), "\\[%w%s]+\\[%w%s]+\\([%w%s]+).lua");
                if type(addon) == "string" then
                    addon = string.gsub(addon, "LV", "");
                else
                    addon = "UNKNOWN";
                end
            end
        end
	else
		addon = startedBy;
	end
	addon = string.gsub(addon, " ", "");
	if addon == "ChatFrame" or addon == "LVBM_API" or addon == "LVBM_GUI" or addon == "LVBM_StatusBars" or addon == "LootLink" then
		addon = "UNKNOWN";
	end

	if addon and addon ~= "UNKNOWN" and addon ~= "" then
		if LVBM.AddOns[addon] and not LVBM.AddOns[addon].Options.Enabled then
			return;
		end
	end
	if type(newName) == "string" then
		LVBM.StatusBarData[name].frame.usedBy = newName;
		if type(LVBM_SBT[newName]) == "string" then
			getglobal(LVBM.StatusBarData[name].frame:GetName().."BarText"):SetText(LVBM_SBT[newName]);

		elseif type(LVBM_SBT[addon]) == "table" then
			-- Translation System for Bars with Dynamic Content "Injection: xxxx"
			for index, value in pairs(LVBM_SBT[addon]) do
				newName = string.gsub(newName, value[1], value[2]);
			end
			getglobal(LVBM.StatusBarData[name].frame:GetName().."BarText"):SetText(newName);

		else
			getglobal(LVBM.StatusBarData[name].frame:GetName().."BarText"):SetText(newName);
		end
	end
	if tonumber(timer) then		
		getglobal(LVBM.StatusBarData[name].frame:GetName().."Bar"):SetMinMaxValues(0, timer);			
		LVBM.StatusBarData[name].timer = timer;
	else
		timer = LVBM.StatusBarData[name].timer;
	end
	if tonumber(elapsed) then		
		getglobal(LVBM.StatusBarData[name].frame:GetName().."BarTimer"):SetText(LVBM.SecondsToTime(elapsed));
		getglobal(LVBM.StatusBarData[name].frame:GetName().."Bar"):SetValue(tonumber(elapsed));
		LVBM.StatusBarData[name].elapsed = tonumber(elapsed);
	end	
	if type(newName) == "string" then
		LVBM.StatusBarData[newName] = LVBM.StatusBarData[name];
		LVBM.StatusBarData[name] = nil;
		if GameTooltip:IsShown() and GameTooltipTextLeft1 and GameTooltipTextLeft1:GetText() == (LVBM_SBT[name] or name) then
			GameTooltip:Hide();
			GameTooltip:ClearLines();
			GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
			GameTooltip:SetText(getglobal("LVBM_StatusBarTimer"..LVBM.StatusBarData[newName].barId.."BarText"):GetText());
			GameTooltip:AddDoubleLine(LVBM_SBT_TIMELEFT, LVBM.SecondsToTime(tonumber(timer) - LVBM.StatusBarData[newName].elapsed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			GameTooltip:AddDoubleLine(LVBM_SBT_TIMEELAPSED, LVBM.SecondsToTime(LVBM.StatusBarData[newName].elapsed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			GameTooltip:AddDoubleLine(LVBM_SBT_TOTALTIME, LVBM.SecondsToTime(timer), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			if LVBM.StatusBarData[newName].isRepeating and LVBM.StatusBarData[newName].repetitions then
				if LVBM.StatusBarData[newName].infinite then
					GameTooltip:AddDoubleLine(LVBM_SBT_REPETITIONS, LVBM_SBT_INFINITE, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
				else
					GameTooltip:AddDoubleLine(LVBM_SBT_REPETITIONS, LVBM.StatusBarData[newName].repetitions, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
				end
			end
			if LVBM.StatusBarData[newName].startedBy and LVBM.StatusBarData[newName].startedBy ~= "UNKNOWN" then
				GameTooltip:AddDoubleLine(LVBM_SBT_BOSSMOD, LVBM.StatusBarData[newName].startedBy, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			end
			if LVBM.StatusBarData[newName].syncedBy and LVBM.StatusBarData[newName].syncedBy ~= LVBM_LOCAL then	
				GameTooltip:AddDoubleLine(LVBM_SBT_STARTEDBY, LVBM.StatusBarData[newName].syncedBy, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			else
				GameTooltip:AddDoubleLine(LVBM_SBT_STARTEDBY, UnitName("player"), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			end
			GameTooltip:AddLine(LVBM_SBT_RIGHTCLICK, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
			GameTooltip:Show();
		end
	end
	
	if not noBroadcast then
		if addon == "Battlegrounds" then
			LVBM.AddSyncMessage("UPDSBT #"..tostring(name).."# "..tostring(elapsed).." "..tostring(timer).." "..tostring((newName or name)), nil, "BATTLEGROUND");
		else
			LVBM.AddSyncMessage("UPDSBT #"..tostring(name).."# "..tostring(elapsed).." "..tostring(timer).." "..tostring((newName or name)));
		end
	end
end


---------------------
--Message Functions--
---------------------
function LVBM.Announce(Warning, localWarning)
	local addon = "";	
    
    _, _, addon = string.find(debugstack(2, 2, 2), "\\([%w%s]+).lua");
    if type(addon) == "string" then
        addon = string.gsub(addon, "LV", "");
    else
        _, _, addon = string.find(debugstack(2, 2, 2), "\\[%w%s]+\\([%w%s]+).lua");  -- =[
        if type(addon) == "string" then
            addon = string.gsub(addon, "LV", "");
        else
            _, _, addon = string.find(debugstack(2, 2, 2), "\\[%w%s]+\\[%w%s]+\\([%w%s]+).lua");
            if type(addon) == "string" then
                addon = string.gsub(addon, "LV", "");
            else
                addon = "";
            end
        end
    end

	
	if ((not LVBM.AddOns[addon]) or LVBM.AddOns[addon].Options.Announce) and LVBM.Rank >= 1 and not localWarning then
		SendChatMessage(Warning, "RAID_WARNING");		
	elseif LVBMWarningFrame:IsShown() then
		PlaySound("RaidWarning");
	end
	if (LVBM.Options.Gui ~= nil) then
		LVBMWarningFrame:AddMessage(Warning, LVBM.Options.Gui["SelfWarning_R"], LVBM.Options.Gui["SelfWarning_G"], LVBM.Options.Gui["SelfWarning_B"], LVBM.Options.Gui["SelfWarning_Delay"]);
	else
		LVBMWarningFrame:AddMessage(Warning);
	end
end


function LVBM.AddMsg(msg, addon)
	if (DEFAULT_CHAT_FRAME) then
            if type(addon) ~= "string" then
            _, _, addon = string.find(debugstack(2, 2, 2), "\\([%w%s]+).lua");
            if type(addon) == "string" then
                addon = string.gsub(addon, "LV", "");
            else        
                _, _, addon = string.find(debugstack(2, 2, 2), "\\[%w%s]+\\([%w%s]+).lua");
                if type(addon) == "string" then
                    addon = string.gsub(addon, "LV", "");
                else
                    _, _, addon = string.find(debugstack(2, 2, 2), "\\[%w%s]+\\[%w%s]+\\([%w%s]+).lua");
                    if type(addon) == "string" then
                        addon = string.gsub(addon, "LV", "");
                    else
                        addon = "Vendetta Boss Mods";
                    end
                end
            end
		end
		if addon == "ChatFrame" or addon == "LVBM_API" or addon == "LVBM_GUI" or addon == "LVBM_StatusBars" or addon == "LootLink" then
			addon = "Vendetta Boss Mods";
		end
		DEFAULT_CHAT_FRAME:AddMessage("|cffff7d0a<|r|cffffd200"..addon.."|r|cffff7d0a>|r "..tostring(msg), 0.41, 0.8, 0.94);
	end	
end

function LVBM.SendHiddenWhisper(msg, target)
	if not msg or not target then return; end
	if msg == "" or target == "" then return; end
	LVBM.HiddenWhisperMessages[msg] = LVBM.HiddenWhisperMessages[msg] or {["targets"] = {}};
	LVBM.HiddenWhisperMessages[msg]["targets"][target] = 1;
	LVBM.HideDNDAFKMessages[target] = 1;
	SendChatMessage(msg, "WHISPER", nil, target);
end

function LVBM.InterceptWhisper(msg, player)
	if not LVBM.InCombat 
	or not LVBM.HideWhispers 
	or LVBM.Raid[player] 
	or not LVBM.Options.AutoRespond 
	or string.sub(msg, 1, 20) == "<Vendetta Boss Mods>" then
		return "SHOW";
	end
	if string.lower(msg) == "status" and LVBM.Options.EnableStatusCommand then
		if (GetTime() - (LVBM.StatusSpamProtection[player] or 0)) > 1 then
			LVBM.StatusSpamProtection[player] = GetTime();
			local message = LVBM_RAID_STATUS_WHISPER;
			message = string.gsub(message, "%%P", UnitName("player"));
			message = string.gsub(message, "%%B", tostring((LVBM.Bosses[GetRealZoneText()][LVBM.InCombat].realName or LVBM.Bosses[GetRealZoneText()][LVBM.InCombat].name)));
			message = string.gsub(message, "%%HP", LVBM.GetBossHP(LVBM.Bosses[GetRealZoneText()][LVBM.InCombat].name));
			message = string.gsub(message, "%%ALIVE", LVBM.GetNumRaidMembersAlive());
			message = string.gsub(message, "%%RAID", tostring(GetNumRaidMembers()));
			LVBM.SendHiddenWhisper("<Vendetta Boss Mods> "..message, player);
		end
		return "FORCE_HIDE";
	end
	if LVBM.WhisperSpamProtection[player] and (GetTime() - LVBM.WhisperSpamProtection[player]) < 60 then
		LVBM.WhisperSpamProtection[player] = GetTime();
		
		if not LVBM.WhispersDuringCombat[table.getn(LVBM.WhispersDuringCombat)] or not (LVBM.WhispersDuringCombat[table.getn(LVBM.WhispersDuringCombat)].name == player and LVBM.WhispersDuringCombat[table.getn(LVBM.WhispersDuringCombat)].msg == msg and (time() - LVBM.WhispersDuringCombat[table.getn(LVBM.WhispersDuringCombat)].time) <= 2) then
			table.insert(LVBM.WhispersDuringCombat, {["name"] = player, ["msg"] = msg, ["time"] = time(), ["hidden"] = not LVBM.Options.ShowWhispersDuringCombat})
		end
		return "HIDE";
	end
	if LVBM.Bosses[GetRealZoneText()] and LVBM.Bosses[GetRealZoneText()][LVBM.InCombat] then
		LVBM.WhisperSpamProtection[player] = GetTime();
		local message = LVBM.Options.BusyMessage;
		message = string.gsub(message, "%%P", UnitName("player"));
		message = string.gsub(message, "%%B", tostring((LVBM.Bosses[GetRealZoneText()][LVBM.InCombat].realName or LVBM.Bosses[GetRealZoneText()][LVBM.InCombat].name)));
		message = string.gsub(message, "%%HP", LVBM.GetBossHP(LVBM.Bosses[GetRealZoneText()][LVBM.InCombat].name));
		message = string.gsub(message, "%%ALIVE", LVBM.GetNumRaidMembersAlive());
		message = string.gsub(message, "%%RAID", tostring(GetNumRaidMembers()));
		if LVBM.Options.EnableStatusCommand then
			message = message;
		end
		if LVBM.Options.HideOutgoingInfoWhisper then		
			LVBM.SendHiddenWhisper("<Vendetta Boss Mods> "..message, player);
		else
			SendChatMessage("<Vendetta Boss Mods> "..message, "WHISPER", nil, player);
		end
		table.insert(LVBM.WhispersDuringCombat, {["name"] = player, ["msg"] = msg, ["time"] = time(), ["hidden"] = not LVBM.Options.ShowWhispersDuringCombat})
		return "AUTO_RESPONDED";
	else
		return "SHOW";
	end
end

function LVBM.EndHideWhispers(bossName)
	if not LVBM.HideWhispers then
		return;
	end
	local playersToInform = {};
	local infoString = "";	
	local missedWhispersInfoShown = false;
	
	if table.getn(LVBM.WhispersDuringCombat) >= 1 then
		
	end
	for index, value in pairs(LVBM.WhispersDuringCombat) do
		if value.name and not playersToInform[value.name] then
			playersToInform[value.name] = true;
		end
		if value.hidden then
			if not missedWhispersInfoShown then
				LVBM.AddMsg(LVBM_MISSED_WHISPERS);
				missedWhispersInfoShown = true;
			end
			LVBM.AddMsg(string.format(LVBM_SHOW_MISSED_WHISPER, value.name, value.msg), date("%H:%M:%S", value.time));
		end
	end
	
	if LVBM.InCombat and not bossName and LVBM.Options.ShowCombatInformations then
		LVBM.AddMsg(string.format(LVBM_COMBAT_ENDED, LVBM.SecondsToTime((GetTime() - LVBM.CombatStartTime), true)));
	end
	
	if bossName then
		infoString = string.format(LVBM_BOSS_DOWN, bossName, LVBM.SecondsToTime((GetTime() - LVBM.CombatStartTime), true))
	else
		infoString = string.format(LVBM_COMBAT_ENDED, LVBM.SecondsToTime((GetTime() - LVBM.CombatStartTime), true));
	end
	
	for index, value in pairs(playersToInform) do		
		LVBM.SendHiddenWhisper("<Vendetta Boss Mods> "..infoString, index);
	end
	
	LVBM.WhispersDuringCombat = {};
	LVBM.HideWhispers = false;
end

--------------------
--Special Warnings--
--------------------
function LVBM.AddSpecialWarning(text, shake, flash)
	if not LVBM.Options.SpecialWarningsEnabled then
		return;
	end
	if type(text) ~= "string" then
		text = "";
	end
	if shake == nil then
		shake = true;
	end
	if flash == nil then
		flash = true;
	end
	if shake and LVBM.Options.ShakeEnabled then
		LVBM.ShakeScreen()
	end
	if flash and LVBM.Options.FlashEnabled then
		LVBM.IsFlashing = LVBM.Options.FlashDuration * LVBM.Options.NumFlashes;
		if LVBM.Options.FlashColor == "red" then
			LVBM.RedFlash = LVBM.Options.FlashDuration;
			LVBM.BlueFlash = false;
			LowHealthFrame:SetAlpha(0);
		elseif LVBM.Options.FlashColor == "blue" then
			LVBM.BlueFlash = LVBM.Options.FlashDuration;
			LVBM.RedFlash = false;
			OutOfControlFrame:SetAlpha(0);
		end
	end
	if text ~= "" then
		LVBMSpecialWarningFrameText:SetTextColor(LVBM.Options.SpecialWarningTextColor.r, LVBM.Options.SpecialWarningTextColor.g, LVBM.Options.SpecialWarningTextColor.b, LVBM.Options.SpecialWarningTextColor.a);
		LVBMSpecialWarningFrameText:SetText(text);
		LVBM.SpecialWarningTextIsFadingIn = 1;
		LVBMSpecialWarningFrame:SetAlpha(0);
		LVBMSpecialWarningFrame:Show();
		LVBM.SpecialWarningTextIsShown = LVBM.Options.SpecialWarningTextDuration;
		LVBM.SpecialWarningTextIsFading = false;
	end
end

function LVBM.ShakeScreen()
	if not LVBM.IsShaking then
		LVBM.OldWorldFramePoints = {};
		for i = 1, WorldFrame:GetNumPoints() do
			local point, frame, relPoint, xOffset, yOffset = WorldFrame:GetPoint(i);
			LVBM.OldWorldFramePoints[i] = {
				["point"] = point,
				["frame"] = frame,
				["relPoint"] = relPoint,
				["xOffset"] = xOffset,
				["yOffset"] = yOffset,
			}
		end
		LVBM.IsShaking = LVBM.Options.ShakeDuration;
	end
end

function LVBM.SpecialWarningsOnUpdate(elapsed)
	if type(LVBM.IsShaking) == "number" then
		LVBM.IsShaking = LVBM.IsShaking - elapsed;
		if LVBM.IsShaking <= 0 then
			LVBM.IsShaking = false;
			WorldFrame:ClearAllPoints();
			for index, value in pairs(LVBM.OldWorldFramePoints) do
				WorldFrame:SetPoint(value.point, value.xOffset, value.yOffset);
			end
		else
			WorldFrame:ClearAllPoints();
			local moveBy;
			moveBy = math.random(-100, 100)/(101 - LVBM.Options.ShakeIntensity);
			for index, value in pairs(LVBM.OldWorldFramePoints) do
				WorldFrame:SetPoint(value.point, value.xOffset + moveBy, value.yOffset + moveBy);
			end
		end
	end
	if type(LVBM.SpecialWarningTextIsShown) == "number" then
		LVBM.SpecialWarningTextIsShown = LVBM.SpecialWarningTextIsShown - elapsed;
		if LVBM.SpecialWarningTextIsShown <= LVBM.Options.SpecialWarningTextFadeTime then
			LVBM.SpecialWarningTextIsShown = false;
			LVBM.SpecialWarningTextIsFading = LVBM.Options.SpecialWarningTextFadeTime;
		end
	end
	if type(LVBM.SpecialWarningTextIsFading) == "number" then
		LVBM.SpecialWarningTextIsFading = LVBM.SpecialWarningTextIsFading - elapsed;		
		if LVBM.SpecialWarningTextIsFading <= 0 then
			LVBMSpecialWarningFrame:Hide();
			LVBMSpecialWarningFrameText:SetText("");
			LVBMSpecialWarningFrame:SetAlpha(1);
			LVBM.SpecialWarningTextIsFading = false;
			LVBM.SpecialWarningTextIsShown = false;
		else
			LVBMSpecialWarningFrame:SetAlpha(LVBMSpecialWarningFrame:GetAlpha() - 1/(LVBM.SpecialWarningTextIsFading * GetFramerate()));
		end
	end
	if type(LVBM.IsFlashing) == "number" then
		LVBM.IsFlashing = LVBM.IsFlashing - elapsed;		
		if LVBM.IsFlashing <= 0 then
			LVBM.IsFlashing = false;
			LVBM.RedFlash = false;
			LVBM.BlueFlash = false;
			OutOfControlFrame:Hide();
			OutOfControlFrame:SetAlpha(1);
			LowHealthFrame:Hide();
			LowHealthFrame:SetAlpha(1);
		end
	end
	if type(LVBM.RedFlash) == "number" then
		LVBM.RedFlash = LVBM.RedFlash - elapsed;		
		if LVBM.RedFlash <= 0 then
			LVBM.RedFlash = LVBM.Options.FlashDuration;
			LowHealthFrame:SetAlpha(0);
		elseif LVBM.RedFlash >= (LVBM.Options.FlashDuration*(2/3)) then
			if not LowHealthFrame:IsShown() then
				LowHealthFrame:SetAlpha(0);
				LowHealthFrame:Show();
			end
			LowHealthFrame:SetAlpha(LowHealthFrame:GetAlpha() + 1/((LVBM.RedFlash - (LVBM.Options.FlashDuration*(2/3))) * GetFramerate()));
		elseif LVBM.RedFlash < (LVBM.Options.FlashDuration/3) then
			LowHealthFrame:SetAlpha(LowHealthFrame:GetAlpha() - 1/(LVBM.RedFlash * GetFramerate()));
		else
			LowHealthFrame:SetAlpha(1)
		end
	end
	if type(LVBM.BlueFlash) == "number" then
		LVBM.BlueFlash = LVBM.BlueFlash - elapsed;		
		if LVBM.BlueFlash <= 0 then
			LVBM.BlueFlash = LVBM.Options.FlashDuration;
			OutOfControlFrame:SetAlpha(0);
		elseif LVBM.BlueFlash >= (LVBM.Options.FlashDuration*(2/3)) then
			if not OutOfControlFrame:IsShown() then
				OutOfControlFrame:SetAlpha(0);
				OutOfControlFrame:Show();
			end
			OutOfControlFrame:SetAlpha(OutOfControlFrame:GetAlpha() + 1/((LVBM.BlueFlash - (LVBM.Options.FlashDuration*(2/3))) * GetFramerate()));
		elseif LVBM.BlueFlash < (LVBM.Options.FlashDuration/2) then
			OutOfControlFrame:SetAlpha(OutOfControlFrame:GetAlpha() - 1/(LVBM.BlueFlash * GetFramerate()));
		else
			OutOfControlFrame:SetAlpha(1);
		end
	end
	if type(LVBM.SpecialWarningTextIsFadingIn) == "number" then
		LVBM.SpecialWarningTextIsFadingIn = LVBM.SpecialWarningTextIsFadingIn - elapsed;
		if LVBM.SpecialWarningTextIsFadingIn <= 0 then
			LVBM.SpecialWarningTextIsFadingIn = false;
			LVBMSpecialWarningFrame:SetAlpha(1);
		else
			LVBMSpecialWarningFrame:SetAlpha(LVBMSpecialWarningFrame:GetAlpha() + 1/(LVBM.SpecialWarningTextIsFadingIn * GetFramerate()));
		end
	end
end

function LVBM.HasAggro(mob)
	if LVBM.Options.CharSettings[UnitName("player")].AggroSound then
		PlaySoundFile("Sound\\Spells\\PVPFlagTaken.wav");
	end
	
	if LVBM.Options.CharSettings[UnitName("player")].AggroSpecialWarning then
		LVBM.AddSpecialWarning(LVBM_AGGRO_FROM..mob, LVBM.Options.CharSettings[UnitName("player")].AggroShake, LVBM.Options.CharSettings[UnitName("player")].AggroFlash)
	else
		LVBM.AddSpecialWarning("", LVBM.Options.CharSettings[UnitName("player")].AggroShake, LVBM.Options.CharSettings[UnitName("player")].AggroFlash)
	end
	
	if LVBM.Options.CharSettings[UnitName("player")].AggroLocalWarning then
		if (LVBM.Options.Gui ~= nil) then
			LVBMWarningFrame:AddMessage(LVBM_AGGRO_FROM..mob, LVBM.Options.Gui["SelfWarning_R"], LVBM.Options.Gui["SelfWarning_G"], LVBM.Options.Gui["SelfWarning_B"], LVBM.Options.Gui["SelfWarning_Delay"]);
		else
			LVBMWarningFrame:AddMessage(LVBM_AGGRO_FROM..mob);
		end
	end
end

-----------------------------
--Synchronization Functions--
-----------------------------

function LVBM.AddSyncMessage(msg, noSpamProt, broadcastType)
	if not LVBM.Options.EnableSync and not string.find(msg, "VER") then
		return;
	end
	if not broadcastType then
		broadcastType = "RAID";
	end
	if type(msg) == "string" and (not LVBM.SpamProtection[msg]) then		
		if noSpamProt then
			SendAddonMessage("LVBM NSP", msg, broadcastType);
		else
			SendAddonMessage("LVBM", msg, broadcastType);
			LVBM.SpamProtection[msg] = 1.5;
		end
	end
end

function LVBM.OnSyncMessage(msg, player, noSpamProt)
	if not LVBM.Options.EnableSync and not (string.find(msg, "VER") or string.find(msg, "ENDALL")) then
		return;
	end

	if not LVBM.Options.AllowSyncFromOldVersions and not (string.find(msg, "VER") or string.find(msg, "ENDALL")) then
		if (tonumber(LVBM.SyncInfo.Clients[player]) or 0) < (tonumber(LVBM.Version) or 0) then
			-- LVBM.AddMsg("Recived Old Sync paket, dropped! ("..player.." - "..msg..")");
			return;
		end
	end
	
	if type(msg) == "string" and msg ~= "" and msg ~= " " and (not LVBM.SpamProtection[msg]) then		
		if not noSpamProt then
			LVBM.SpamProtection[msg] = 1.5;
		end	
		
		local name, color, colorR, colorG, colorB, colorA;
		local args = {};
		for value in string.gfind(msg, "([^%s]+)") do
			table.insert(args, value);
		end
		
		if not LVBM.SyncInfo.Clients[player] then
			LVBM.SyncInfo.Clients[player] = "1.60";
		end

		if args[1] == "STSBT" then
			_, _, _, _, _, name = string.find(msg, "([^%s]+) ([%d%.]+) ([^%s]+) (.*)");
			if not name then
				return;
			end
			if tonumber(args[2]) and args[3] and (not LVBM.GetStatusBarTimerTimeLeft(name)) then
				LVBM.StartStatusBarTimer(tonumber(args[2]), name, true, player, args[3]);
			end
		elseif args[1] == "ENDSBT" then
			_, _, _, name = string.find(msg, "([^%s]+) (.*)");
			if name then
				LVBM.EndStatusBarTimer(name, true, player);
			end
		elseif args[1] == "STRPSBT" then
			_, _, _, _, _, _, name = string.find(msg, "([^%s]+) ([%d%.]+) ([%d%.]+) ([^%s]+) (.*)");
			if not name then
				return;
			end
			if tonumber(args[2]) and tonumber(args[3]) and args[4] and (not LVBM.GetStatusBarTimerTimeLeft(name)) then
				LVBM.StartRepeatingStatusBarTimer(tonumber(args[2]), name, tonumber(args[3]), true, player, args[4]);
			end
		elseif args[1] == "ENDRPSBT" then
			_, _, _, name = string.find(msg, "([^%s]+) (.*)");
			if name then
				LVBM.EndRepeatingStatusBarTimer(name, true, player);
			end
		elseif args[1] == "STCSBT" then
			_, _, _, _, _, color, name = string.find(msg, "([^%s]+) ([%d%.]+) ([^%s]+) ([^%s]+) (.*)");
			if not name or not color then
				return;
			end
			_, _, colorR, colorG, colorB, colorA = string.find(color, "([%d%.]+)~([%d%.]+)~([%d%.]+)~([%d%.]+)");
			
			if tonumber(args[2]) and args[3] and (not LVBM.GetStatusBarTimerTimeLeft(name)) and tonumber(colorR) and tonumber(colorG) and tonumber(colorB) and tonumber(colorA) then
				LVBM.StartColoredStatusBarTimer(tonumber(args[2]), name, tonumber(colorR), tonumber(colorG), tonumber(colorB), tonumber(colorA), true, player, args[3]);
			end
		elseif args[1] == "STRPCSBT" then
			_, _, _, _, _, _, color, name = string.find(msg, "([^%s]+) ([%d%.]+) ([%d%.]+) ([^%s]+) ([^%s]+) (.*)");
			if not name or not color then
				return;
			end
			_, _, colorR, colorG, colorB, colorA = string.find(color, "([%d%.]+)~([%d%.]+)~([%d%.]+)~([%d%.]+)");
			
			if tonumber(args[2]) and tonumber(args[3]) and args[4] and (not LVBM.GetStatusBarTimerTimeLeft(name)) and tonumber(colorR) and tonumber(colorG) and tonumber(colorB) and tonumber(colorA) then
				LVBM.StartRepeatingColoredStatusBarTimer(tonumber(args[2]), name, tonumber(args[3]), tonumber(colorR), tonumber(colorG), tonumber(colorB), tonumber(colorA), true, player, args[4]);
			end
		elseif args[1] == "UPDSBT" then
			local elapsed, timer, newName;
			_, _, name, elapsed, timer, newName = string.find(msg, "UPDSBT #(.+)# (%w+) (%w+) (.*)");
			if newName == name then
				newName = nil;
			end
			LVBM.UpdateStatusBarTimer(name, tonumber(elapsed), tonumber(timer), newName, true);		
		elseif args[1] == "REQ" then
			if args[2] == "VER" and tonumber(args[3]) then
				SendChatMessage("LVBM VER "..LVBM.Version, "WHISPER", nil, player);
				LVBM.OnSyncMessage("VER "..args[3], player, true);
			elseif args[2] == "VER" then
				LVBM.AddSyncMessage("VER "..LVBM.Version, true);				
			end
		elseif args[1] == "SC" then
			if not LVBM.InCombat then
				LVBM.CombatStart(args[3], args[2], true, player);
			end
		elseif args[1] == "EC" then
			if LVBM.InCombat and LVBM.Bosses[GetRealZoneText()] and LVBM.Bosses[GetRealZoneText()][args[2]] then
				if type(LVBM.Bosses[GetRealZoneText()][args[2]].killName) == "table" then
					for index, value in pairs(LVBM.Bosses[GetRealZoneText()][args[2]].killName) do
						if value.notKilled then
							return;
						end
					end
					LVBM.CombatEnd((LVBM.Bosses[GetRealZoneText()][args[2]].realName or LVBM.Bosses[GetRealZoneText()][args[2]].name), true);
				else
					LVBM.CombatEnd((LVBM.Bosses[GetRealZoneText()][args[2]].killName or LVBM.Bosses[GetRealZoneText()][args[2]].name), true);
				end
			end
		elseif args[1] == "ECS" then
			if LVBM.InCombat and LVBM.Bosses[GetRealZoneText()] and LVBM.Bosses[GetRealZoneText()][args[2]] and type(LVBM.Bosses[GetRealZoneText()][args[2]].killName) == "table" and LVBM.Bosses[GetRealZoneText()][args[2]].killName[args[3]] then
				LVBM.CombatEnd(nil, true, LVBM.Bosses[GetRealZoneText()][args[2]].killName[args[3]].name);
			end
		elseif args[1] == "VER" and tonumber(args[2]) then
			LVBM.SyncInfo.Clients[player] = args[2];
			if tonumber(args[2]) > tonumber(LVBM.Version) then
				local player1, player2;
				player1 = player;
				for index, value in pairs(LVBM.SyncInfo.Clients) do
					if (value == args[2]) and (index ~= player1) then
						player2 = index;
						break;
					end
				end
				if player1 and player2 and (not LVBM.UpdateDialogShown) then
					LVBM.UpdateDialogShown = args[2];
					LVBMUpdateDialogText:SetText(string.format(LVBM_UPDATE_DIALOG, player1, player2, args[2]));
					LVBMUpdateDialog:Show();
				end
			end
		elseif args[1] == "ENDALL" then
			for i = 1, GetNumRaidMembers() do
				local name, rank;
				name, rank = GetRaidRosterInfo(i);
				if (name == player) and (rank >= 1) then
					LVBM.AddMsg(string.format(LVBM_REC_STOP_ALL, player));
					for index, value in pairs(LVBM.AddOns) do
						if type(value.OnStop) == "function" then
							value.OnStop();
						end
					end
					for index, value in pairs(LVBM.AddOns) do
						LVBM.UnSchedule("LVBM.AddOns."..index..".OnEvent");
					end					
					LVBM.TimerData	= {};
					for index, value in pairs(LVBM.StatusBarData) do
						if index then
							if not (LVBM.StatusBarData[index].syncedBy == LVBM_LOCAL and not LVBM.StatusBarData[index].startedBy) then
								LVBM.EndRepeatingStatusBarTimer(index);
							end
						end
					end
				end
			end
		end
	end
end

------------------
--Buff Functions--
------------------
function LVBM.GetBuff(unitID, buff)
	if not UnitExists(unitID) then
		return nil;
	end
	local i = 1;

	LVBMTooltipTextLeft1:SetText("LVBM Buff Tooltip");
	while (LVBMTooltipTextLeft1:GetText() and LVBMTooltipTextLeft1:GetText() ~= "") do
		LVBMTooltipTextLeft1:SetText("");
		LVBMTooltip:SetUnitBuff(unitID, i);
		if LVBMTooltipTextLeft1:GetText() and string.lower(buff) == string.lower(LVBMTooltipTextLeft1:GetText()) then
			return i;
		end
		i = i + 1;
	end	
end

function LVBM.GetDebuff(unitID, buff)
	if not UnitExists(unitID) then
		return nil;
	end
	local i = 1;
	
	LVBMTooltipTextLeft1:SetText("LVBM Buff Tooltip");
	while (LVBMTooltipTextLeft1:GetText() and LVBMTooltipTextLeft1:GetText() ~= "") do
		LVBMTooltipTextLeft1:SetText("");	
		LVBMTooltip:SetUnitDebuff(unitID, i);
		if LVBMTooltipTextLeft1:GetText() and string.lower(buff) == string.lower(LVBMTooltipTextLeft1:GetText()) then
			return i;
		end
		i = i + 1;
	end	
end

-- -------------- --
-- Icon Functions --
-- -------------- --

function LVBM.SetIconByName(name, icon)
	if (icon == nil or tonumber(icon) < 1 or tonumber(icon) > 8) then
		icon = 8;
	else 	icon = tonumber(icon);
	end
	for i=1, GetNumRaidMembers() do
		if (UnitName("raid"..i) == name) then
			SetRaidTargetIcon("raid"..i, icon);
			break;
		end
	end
end

function LVBM.ClearIconByName(name)
	for i=1, GetNumRaidMembers() do
		if (UnitName("raid"..i) == name) then
			SetRaidTargetIcon("raid"..i, 0);
			break;
		end
	end
end


--------------------
--Combat Functions--
--------------------
function LVBM.DetectCombat(name)
	local unitID
	if UnitName("target") == name and not UnitIsPlayer("target") then
		unitID = "target";
	else
		for i = 1, GetNumRaidMembers() do
			if UnitName("raid"..i.."target") == name and not UnitIsPlayer("raid"..i.."target") then
				unitID = "raid"..i.."target";
				break;
			end
		end
	end
	if unitID and UnitAffectingCombat(unitID) then
		return unitID;		
	else
		return nil;		
	end
end

function LVBM.UnitExists(name)
	if type(name) ~= "string" and type(name) ~= "table" then
		return false;
	end	
	
	if LVBM.GetBuff("player", LVBM_REDEMPTION) or ((GetTime() - LVBM.LastBloodrage) < 7.5) then		
		return false;
	end	
	if LVBM.GetBuff("player", LVBM_FEIGNDEATH) or ((GetTime() - LVBM.LastFeignDeath) < 20) then
		return false;
	end	
	if (GetTime() - LVBM.LastBloodrage) < 7.5 then
		return false;
	end
	if type(name) == "table" then
		local unitTable = {};
		for index, value in pairs(name) do
			unitTable[value] = false; --it would look much better if I would call LVBM.UnitExists(value) here, but I want to iterate only one time over the raid's targets...
		end
		if unitTable[UnitName("target")] ~= nil and not UnitIsPlayer("target") then
			unitTable[UnitName("target")] = true;
		end
		for i = 1, GetNumRaidMembers() do
			local raidTarget = UnitName("raid"..i.."target");
			if raidTarget ~= nil and unitTable[raidTarget] ~= nil and not UnitIsPlayer("raid"..i.."target") then
				unitTable[raidTarget] = true;
			end
		end
		return unitTable;
	else	
		if UnitName("target") == name and not UnitIsPlayer("target") then
			return true;
		end
		
		for i = 1, GetNumRaidMembers() do
			if UnitName("raid"..i.."target") == name and not UnitIsPlayer("raid"..i.."target") then
				return true;
			end
		end
		return false;
	end
end

function LVBM.CombatStart(bossID, delay, noBroadcast, syncedBy)
	if LVBM.Bosses[GetRealZoneText()] and LVBM.Bosses[GetRealZoneText()][bossID] and not LVBM.InCombat then
		for index, value in pairs(LVBM.Bosses[GetRealZoneText()][bossID].BossMods) do
			if LVBM.AddOns[value] then
				LVBM.AddOns[value].InCombat = true;
				if type(LVBM.AddOns[value].OnCombatStart) == "function" then
					LVBM.AddOns[value].OnCombatStart(delay);
				end				
			end
		end
		LVBM.InCombat = bossID;
		LVBM.HideWhispers = true;
		LVBM.CombatStartTime = GetTime() - delay;

		if( LVBM.Options.ShowCombatInformations ) then
			LVBM.AddMsg(string.format(LVBM_BOSS_ENGAGED, (LVBM.Bosses[GetRealZoneText()][bossID].realName or LVBM.Bosses[GetRealZoneText()][bossID].name)));
			if type(syncedBy) == "string" then
				LVBM.AddMsg(string.format(LVBM_BOSS_SYNCED_BY, syncedBy));
			end
		end

		if not noBroadcast then
			LVBM.AddSyncMessage("SC "..tostring(delay).." "..bossID);
		end
	end
end

function LVBM.CombatEnd(bossName, noBroadcast, subBossName)
	if not subBossName then
		for index, value in pairs(LVBM.AddOns) do
			if LVBM.AddOns[index].InCombat then
				LVBM.AddOns[index].InCombat = false;
				if type(LVBM.AddOns[index].OnCombatEnd) == "function" then
					LVBM.AddOns[index].OnCombatEnd();
				end
				LVBM.UnSchedule("LVBM.AddOns."..index..".OnEvent");
				for index2, value2 in pairs(LVBM.StatusBarData) do
					if value2 and value2.bossModID then
						if value2.bossModID == index then
							LVBM.EndRepeatingStatusBarTimer(index2, true);
						end
					end
				end
			end
		end
		for index, value in pairs(LVBM.Bosses) do
			for index2, value2 in pairs(value) do
				if type(value2.killName) == "table" then
					for index3, value3 in pairs(value2.killName) do
						value3.notKilled = true;
					end
				end
			end
		end
	end
	
	if bossName or subBossName then
		if LVBM.Bosses[GetRealZoneText()] then
			if subBossName then
				for index, value in pairs(LVBM.Bosses[GetRealZoneText()]) do
					if type(value.killName) == "table" then
						for index2, value2 in pairs(value.killName) do
							if value2.name == subBossName then
								value2.notKilled = false;
								if not noBroadcast then
									LVBM.AddSyncMessage("ECS "..index.." "..index2);
								end
							end
						end
					end
				end
			else
				if not noBroadcast then
					for index, value in pairs(LVBM.Bosses[GetRealZoneText()]) do
						local killName
						if type(value.killName) == "string" then
							killName = value.killName
						end
						if (value.killName or value.name) == bossName or value.realName == bossName then
							LVBM.AddSyncMessage("EC "..index);
						end
					end
				end
			end
		end
		if bossName and LVBM.Options.ShowCombatInformations then
			LVBM.AddMsg(string.format(LVBM_BOSS_DOWN, bossName, LVBM.SecondsToTime((GetTime() - LVBM.CombatStartTime), true)));
		end
		if subBossName and LVBM.Bosses[GetRealZoneText()] then
			local allBossesDown = true;
			for index, value in pairs(LVBM.Bosses[GetRealZoneText()]) do
				if type(value.killName) == "table" then					
					for index2, value2 in pairs(value.killName) do
						if value2.name == subBossName then
							for index3, value3 in  LVBM.Bosses[GetRealZoneText()][index].killName do
								if value3.notKilled then
									allBossesDown = false;
								end
							end
							if allBossesDown then
								LVBM.CombatEnd(LVBM.Bosses[GetRealZoneText()][index].name);
							end
							break;
						end
					end
				end
			end
		end
	end
	
	if not subBossName then
		LVBM.EndHideWhispers(bossName);
		LVBM.InCombat = false;
	end
end

function LVBM.CheckForCombatEnd()
	if not UnitAffectingCombat("player") and not UnitIsDead("player") then
		LVBM.CombatEnd();
	end
end

function LVBM.GetBossHP(name)
	local hitpoints;
	for i = 1, GetNumRaidMembers() do
		if UnitName("raid"..i.."target") == name and not UnitIsPlayer("raid"..i.."target") then
			hitpoints = tostring(math.floor((UnitHealth("raid"..i.."target")/UnitHealthMax("raid"..i.."target")) * 100)).."%%";
			break;
		end
	end
	if not hitpoints then
		if name == LVBM_THADDIUS_NAME then
			hitpoints = string.format(LVBM_PHASE, 1);
		elseif name == LVBM_GOTH_NAME then
			hitpoints = string.format(LVBM_WAVE, LVBM.AddOns.Gothik.Wave);
		elseif name == LVBM_NTP_NAME then
			hitpoints = string.format(LVBM_BALCONY_PHASE, LVBM.AddOns.Noth.Phase);
		end
	end
	if not hitpoints then
		hitpoints = "HP unknown";
	end
	return hitpoints;
end

function LVBM.GetNumRaidMembersAlive()
	local alive = 0;
	for i = 1, GetNumRaidMembers() do
		if not UnitIsDeadOrGhost("raid"..i) then
			alive = alive + 1;
		end
	end
	return tostring(alive);
end

-----------------------
--Patchnote Functions--
-----------------------
function LVBM.OnPatchnoteMessage(msg, longMsg)
	if longMsg then
		LVBM.LongMsg = LVBM.LongMsg..msg;
	else
		msg = LVBM.LongMsg..msg;
		LVBM.LongMsg = "";
		if LVBMPatchnoteFrame:IsShown() then
			LVBMPatchnoteFrameMessageFrame:AddMessage(msg);
			for i = 1, LVBMPatchnoteFrameMessageFrame:GetNumMessages() do
				LVBMPatchnoteFrameMessageFrame:ScrollUp();
			end
		end
	end
end

function LVBM.AddPatchnoteMessage(msg, target, longMsg)
	if type(target) ~= "string" or type(msg) ~= "string" then
		return;
	end
	if longMsg == nil then
		local longMsg = false;
	end
	if string.len(msg) > 240 then		
		LVBM.AddPatchnoteMessage(string.sub(msg, 1, 240), target, true);
		msg = string.sub(msg, 241);
		LVBM.AddPatchnoteMessage(msg, target);
	else
		table.insert(LVBM.MsgQueue, {["msg"] = msg, ["target"] = target, ["longMsg"] = longMsg});
	end
end

function LVBM.SendPatchnotes(target, version, lang)
	if type(target) ~= "string" or not version or not lang then
		return;
	end
	version = string.gsub(version, ",", ".");
	if tonumber(version) >= tonumber(LVBM.Version) then
		LVBM.AddPatchnoteMessage("I don't have a newer version than you.", target);
		return;
	end
	
	if not LVBM_PN[lang] then
		LVBM.AddPatchnoteMessage("Patchnotes in your language are not available. Sending english notes.", target);
		lang = "en";
	end
	local notesToSend = {};
	
	version = string.gsub(version, "%.", "");
	version = tonumber(version);
	for index, value in pairs(LVBM_PN[lang]) do
		table.insert(notesToSend, {["ver"] = index, ["notes"] = value});
	end
	table.sort(notesToSend, function(v1, v2) return v1.ver > v2.ver; end);
	for index, value in pairs(notesToSend) do
		if value.ver > version then
			for index2, value2 in pairs(notesToSend[index].notes) do
				LVBM.AddPatchnoteMessage(value2, target);
			end
		end
	end	
end

function LVBM.RequestPatchnotes(version)
	local clientTable = {};
	for index, value in pairs(LVBM.SyncInfo.Clients) do
		if value == version then
			table.insert(clientTable, index);
		end
	end
	if not clientTable[1] then return; end
	local player = clientTable[random(1, table.getn(clientTable))];
	LVBM.OnPatchnoteMessage(string.format(LVBM_REQ_PATCHNOTES, player));
	SendChatMessage("LVPNREQ "..LVBM.Version.." "..string.sub(GetLocale(), 1, 2), "WHISPER", nil, player);
end


---------------------------------
--Register/Unregister Functions--
---------------------------------
function LVBM.Register()
	for index, value in pairs(LVBM.AddOns) do
		for index2, value2 in pairs(value.Events) do
			LVBM_API:RegisterEvent(index2);
		end
	end	
end

function LVBM.Unregister()
	LVBM_API:UnregisterAllEvents();
end

------------------
--Misc Functions--
------------------
function LVBM.Capitalize(text)
    if GetLocale() == "krKR" or GetLocale() == "zhCN" or GetLocale() == "zhTW" then
        return text;
    end
	return string.upper(string.sub(text, 0, 1))..string.sub(text, 2)
end

function LVBM.CutText(tstring, len)
	if( string.len(tstring) < len ) then return tstring; end
	local last = 0;
	local i = 0
	while true do
		i = string.find(tstring, " ", i + 1) 
		if (i == nil) then 
			break;

		elseif( i < len) then
			last = i - 1;
			
		elseif( i > len) then
			break;
		end
	end

	return string.sub(tstring, 1, last).."...";
end


LVBM.math = {};
function LVBM.math.round(num, idp)
    if (idp == nil or idp < 0 or idp > 20 ) then idp = 1; end
    idp = 10 ^ idp;
    return math.floor((num * idp) + 0.5) / idp;
end


function LVBM.SecondsToTime(seconds, longFormat)
	local time, min, sec;
	if longFormat then
		if not tonumber(seconds) then
			return "0 "..LVBM_MINUTES.." "..LVBM_AND.." 0 "..LVBM_SECONDS;
		else
			seconds = tonumber(seconds);
		end
		
		min = math.floor(seconds / 60);
		sec = string.format("%.0f", math.mod(seconds, 60));
		if sec == "60" then
			sec = "0";
			min = min + 1;
		end
		if min == 1 then
			time = min.." "..LVBM_MINUTE.." "..LVBM_AND.." ";
		elseif min == 0 then
			time = "";
		else
			time = min.." "..LVBM_MINUTES.." "..LVBM_AND.." ";
		end
		if sec == "1" then
			time = time..sec.." "..LVBM_SECOND;
		elseif sec == "0" then
			time = string.gsub(time, " and ", "");
		else
			time = time..sec.." "..LVBM_SECONDS
		end
	else
		if not tonumber(seconds) then
			return "0.00";
		else
			seconds = tonumber(seconds);
		end		
		if seconds > 60 then
			min = math.floor(seconds / 60);
			sec = string.format("%02.0f", math.mod(seconds, 60));
			if sec == "60" then
				sec = "00";
				min = min + 1;
			end
			time = min..":"..sec;
		else
			time = string.format("%.1f", seconds);
		end
	end

	return time;
end


---------
--Hooks--
---------

function LVBM.SetHooks()
	LVBM.Hooks.oldChatFrame_OnEvent = ChatFrame_OnEvent;
	function LVBM.Hooks.newChatFrame_OnEvent(event)
		if (event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_WHISPER_INFORM") then
			if (string.sub(arg1, 1, 4) == "LVPN") or (string.sub(arg1, 1, 4) == "LVBM") then
				if event == "CHAT_MSG_WHISPER_INFORM" then
					LVBM.HideDNDAFKMessages[arg2] = 1.5;
				end
				return;
			elseif event == "CHAT_MSG_WHISPER_INFORM" and LVBM.HiddenWhisperMessages[arg1] and LVBM.HiddenWhisperMessages[arg1]["targets"] and LVBM.HiddenWhisperMessages[arg1]["targets"][arg2] then
				return;
			elseif event == "CHAT_MSG_WHISPER" then
				local whisperCheck = LVBM.InterceptWhisper(arg1, arg2);
				if whisperCheck == "AUTO_RESPONDED" then
					if LVBM.Options.ShowWhispersDuringCombat then
						LVBM.Hooks.oldChatFrame_OnEvent(event);
						if LVBM.Options.ShowAutoRespondInfo and LVBM.Options.HideOutgoingInfoWhisper then
							LVBM.AddMsg(LVBM_AUTO_RESPOND_SHORT);
						end
					else
						if LVBM.Options.ShowAutoRespondInfo and LVBM.Options.HideOutgoingInfoWhisper then
							LVBM.AddMsg(string.format(LVBM_AUTO_RESPOND_LONG, arg2));
						end
					end
				elseif whisperCheck == "HIDE" then
					if LVBM.Options.ShowWhispersDuringCombat then
						LVBM.Hooks.oldChatFrame_OnEvent(event);
					else
						return;
					end
				elseif whisperCheck == "FORCE_HIDE" then
					return;
				elseif whisperCheck == "SHOW" then
					LVBM.Hooks.oldChatFrame_OnEvent(event);
				end
			else
				LVBM.Hooks.oldChatFrame_OnEvent(event);
			end		
		elseif (event == "CHAT_MSG_AFK") or (event == "CHAT_MSG_DND") then
			if LVBM.HideDNDAFKMessages[arg2] then
				return;
			else
				LVBM.Hooks.oldChatFrame_OnEvent(event);
			end
		else
			LVBM.Hooks.oldChatFrame_OnEvent(event);
		end
	end
	ChatFrame_OnEvent = LVBM.Hooks.newChatFrame_OnEvent;
	
	local version, build, date = GetBuildInfo();
	if tonumber(string.sub(version, 0, 3)) < 2 then
		LVBM.Hooks.oldUseAction = UseAction;
		function LVBM.Hooks.newUseAction(slot, checkCursor, onSelf)
			LVBMTooltipTextLeft1:SetText("");
			LVBMTooltip:SetAction(slot);
			if LVBMTooltipTextLeft1:GetText() == LVBM_BLOODRAGE then
				LVBM.LastBloodrage = GetTime();
			elseif LVBMTooltipTextLeft1:GetText() == LVBM_CHARGE then
				LVBM.LastCharge = GetTime();
			elseif LVBMTooltipTextLeft1:GetText() == LVBM_FERALCHARGE then
				LVBM.LastCharge = GetTime();
			elseif LVBMTooltipTextLeft1:GetText() == LVBM_FEIGNDEATH then
				LVBM.LastFeignDeath = GetTime();
			end
			LVBM.Hooks.oldUseAction(slot, checkCursor, onSelf);
		end
		UseAction = LVBM.Hooks.newUseAction;

		LVBM.Hooks.oldCastSpellByName = CastSpellByName;
		function LVBM.Hooks.newCastSpellByName(spell, onSelf)
			if string.find(spell, LVBM_BLOODRAGE) then
				LVBM.LastBloodrage = GetTime();
			elseif string.find(spell, LVBM_CHARGE) then
				LVBM.LastCharge = GetTime();
			elseif string.find(spell, LVBM_FERALCHARGE) then
				LVBM.LastCharge = GetTime();
			elseif string.find(spell, LVBM_FEIGNDEATH) then
				LVBM.LastFeignDeath = GetTime();
			end
			LVBM.Hooks.oldCastSpellByName(spell, onSelf);
		end
		CastSpellByName = LVBM.Hooks.newCastSpellByName;
	end

	LVBM.Hooks.oldPlaySound = PlaySound;
	function LVBM.Hooks.newPlaySound(snd)
		if (snd == "RaidWarning") then
			if LVBM.Options.Gui.RaidWarnSound == 1 or LVBM.Options.Gui.RaidWarnSound == 2 or LVBM.Options.Gui.RaidWarnSound == 3 then
				if LVBM.Options.Gui.RaidWarnSound == 1 then
					LVBM.Hooks.oldPlaySound(snd);
					return;
				elseif LVBM.Options.Gui.RaidWarnSound == 2 then
					PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
					return;
				elseif LVBM.Options.Gui.RaidWarnSound == 3 then
					return;
				end
			else
				LVBM.Hooks.oldPlaySound(snd);
			end
		else
			LVBM.Hooks.oldPlaySound(snd);
		end
	end
	PlaySound = LVBM.Hooks.newPlaySound;
	
	if type(FC_IsValidWhisper) == "function" then
		LVBM.Hooks.oldFC_IsValidWhisper = FC_IsValidWhisper;
		function LVBM.Hooks.newFC_IsValidWhisper(Text, Name)
			if LVBM.HiddenWhisperMessages[Text] and LVBM.HiddenWhisperMessages[Text]["targets"] and LVBM.HiddenWhisperMessages[Text]["targets"][Name] then
				return 0;
			end
			return LVBM.Hooks.oldFC_IsValidWhisper(Text, Name);	
		end
		FC_IsValidWhisper = LVBM.Hooks.newFC_IsValidWhisper;
	end

	if type(WIM_FilterResult) == "function" then
		LVBM.Hooks.oldWIM_FilterResult = WIM_FilterResult;
		function LVBM.Hooks.newWIM_FilterResult(Text)
			if LVBM.HiddenWhisperMessages[Text] then--and LVBM.HiddenWhisperMessages[Text]["targets"] and LVBM.HiddenWhisperMessages[Text]["targets"][Name] then
				return 1;
			end
			return LVBM.Hooks.oldWIM_FilterResult(Text);
		end
		WIM_FilterResult = LVBM.Hooks.newWIM_FilterResult;
	end
end
