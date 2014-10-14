----[[
--
-- ---===:::{{{ A U L E ' S    U B E R B A N I S H }}}:::===---
--
--
-- Author		: joeh@foldingrain.com
-- Version		: 1.2b
-- Release Date	: Oct 1, 2006
-- Main			: Aule [Warlock]
-- Server		: Dunemaul
-- Guild		: NoX (Best Guild Ever)
-- Testers		: Tiamat, Janadine, Rhyana, Ampz, Kaed, Houseofm
--
--
-- Copyright (c)2006.  All Rights Reserved.
-- All players of World of Warcraft have permission to copy, reproduce, 
-- distribute and modify this computer code in any way they wish with no 
-- permission from the author or any corporation or organization.  The
-- author respectfully requests he be credited for the original inception.
--
--
-- OVERVIEW:
-- ---------
-- UberBanish is a Banish enhancement with the following main features:
--
--	- Informs the party/raid of how much time is left in your Banishes.
--	- If a Warlock's Banish breaks early, the group is informed and the
--	  Warlock gets a Big Fat Message and a sound indicating the break.
--	  Clicking on this message will rebanish the current target.
--	- Informs the other warlocks in the party/raid if you die while on
--	  Banish duty (that is to say within 1 minute of casting a Banish).
--	- If a warlock dies while on Banish duty, all other Warlocks in the 
--    group will be informed with a Big Fat Message above their toon.
--    Clicking on this message will select the dead Warlock's target.
--
-- UberBanish primarily responds to spellcasting events and manages a 
-- single, static timer which is reset on each new Banish.
--
--
-- DEVELOPERS:
-- -----------
-- - BFM = Big Fat Message.
-- - A "broadcast message" is a whisper sent to other Warlocks that 
--	 will result in a BFM being displayed to them.
--
--
-- CREDITS:
-- --------
-- Thanks to Scrum and Justin Milligan for their work on CountDoom,
-- which taught me just about everything I needed to know about
-- dealing with curses in an AddOn.
--
-- Thanks also to Andreas Broecking for the SheepWatch Mage mod which
-- gave me some great ideas for tracking banish breaks when the target
-- is not selected.
--
--
-- KNOWN ISSUES:
-- -------------
--	- If the player switches targets during a banish, early break
--	  detection becomes slightly less reliable.
--
--	- If the player switches during a banish to a target with the
--	  same name that has been banished by another Warlock, their 
--	  current banish timer becomes unreliable.  If the other 
--	  Warlock's Banish breaks while this Warlock has the mob 
--	  targetted, a broken Banish will be reported.
--
--	- Due to limitations of the API, debuff detection can be extremely
--	  unreliable under lag conditions.
--
--
-- TO DO:
-- ------
--	- Implement an out-of-combat delay like CountDoom (PLAYER_REGEN_ENABLED).
--	- New mod....CRITMINDER.  Tells you all yoru crits over 1k .
--	- Adjust raid spam on the type of mob being banished.
--	- Allow users to manually trigger the timer countdown.
--	- Discriminate between banish ranks.
--	- OO-ify.
--	- There may be a situation where a banish isn't resisted, but it breaks
--	  after 1 second.  In this case it won't be reported at all.  Might
--	  not be a concern because it will just appear as if it was resisted?
--	- Better localization.
--	? PROBABLY FIXED: If a banish is cast in the middle of another banish, and a break
--	  occurs right around the same time, the break will be missed.
--	  Shouldn't be a problem because you typically don't cast another
--	  banish right in the middle of a banish.
--
--
-- RELEASES:
-- ---------
--	Version 1.2b:
--	x Added on/off switches for spamming Banish start, Banish end, and notifying
--	  other Warlocks on death.
--	x Now properly discriminates between Banish Rank 1 & 2.
--
--
--	Version 1.1b:
--	x Fixed a small bug which could cause UberBanish to think you were in a party
--	  when you were actually in a raid.
--
--
--	Version 1.0b:
--	x Graduated to beta.
--
--
--	Version 0.4a:
--	x Implemented options GUI.
--	x Now detects when Banish is cast from a macro.
--
--
--	Version 0.3.1a:
--	x Fixed a bug that would sometimes prevent spells from being draggable
--	  into action slots.
--
--
--	Version 0.3a:
--	x UberBanish was using a timer mechanism that relied on updates from the
--	  the server rather than the local simulation clock.  This made banish
--	  reporting in high-latency situations (like in a 40-man raid) extremely
--	  unreliable.  UberBanish now uses the simulation clock instead and is
--	  much more reliable in large raids.
--	x Implemented a new, event-driven method of detecting banish breaking
--	  when another target is selected.
--	x Fixed a bug which caused resisted Banishes to be reported as breaks.
--	x Fixed a bug which would cause an early break report AND kill the
--	  Banish timer if a mob was banished, then a banish was attempted
--	  on another target but failed.
--	x Fixed a bug which sometimes caused an early break notice if a Warlock
--	  moved during a banish cast.
--	x Fixed a bug which sometimes caused a timer kill if another mob died.
--	x Fixed a bug which prevented a new timer from starting up if a
--	  new mob was banished during the banish duration of anotehr mob.
--	x Fixed a bug which caused an early break notice if the Warlock
--	  switched targets right after a banish.
--	x Fixed a bug which caused an improper mob name to appear in the banish
--	  message if the Warlock switched targets right after a banish.
--	x Fixed a bug which caused an early break notice if the Warlock 
--	  rebanished just at the end of a previous banish.
--	x Fixed a bug which caused the timers to kill if a pet was summoned.
--	x The mechanism for determing resists or immunes has been greatly improved.
--	x Death whisper no longer goes to the warlock who died.
--
--	
--  Version 0.2a:
--	x Banish detection and break logic has been greatly improved in situations
--	  where a warlock switches targets during a banish.
--	x Fixed a bug which caused UB to always report a broken banish when
--	  another target is banished while a current banish is up.
--	x Fixed a bug which caused the banish timer to stop every time another
--	  target is killed.
--	x Added Say-When-Solo debug feature.
--	x When the Warlock's banish breaks early and the BFM appears, clicking on it
--	  automatically rebanishes the current target.
--
--
--	Version 0.1a:
--	x Notify other locks if caster dies within 1 minute of a banish.
--	x Discriminate between party chat and raid chat.
--	x Consider when banish has been activated but no target is selected.
--	x Trap the party / raid join event and create a list of all warlocks.
--	x Broadcast early breaks to the party and banisher deaths to the other warlocks.
--	x Currently doesn't allow spell macros.
--	x When a aura clear event is fired, check if the current target is
--	  still banished.  If yes, ignore, if not, broadcast banish is broken.
--	x If self dies, check banish timer.  If > 0, broadcast the pickup message.
--	x Dismiss user notice early if banish is re-cast.
--	x Big fat message and a sound when your banish breaks.
--	x Notify caster if banish breaks.  Preferably a big warning with a sound.
--	x If not Warlock, disable.
--	x If you change targets, the timer should still tick?
--	x Properly unregister events.
--	x Position the break warning a little higher over the toon.
--	x Localization.
--	x Slash interface.
--	X Broadcast a BFM when a warlock dies.
--
--]]


-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
-- P E R S I S T A N T   S E T T I N G S
-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
Default_UberBanish_Config = {
	Version = "1.2b",
	SpamBanishStart = true,
	SpamBanishEnd = true,
	TwentySecWarning = true,
	TenSecWarning = true,
	FiveSecWarning = true,
	SpamEarlyBreak = true,
	SpamDeath = true,
	SayWhenSolo = false,
	NotifyLocksOnDeath = true,
};


-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
-- C O N S T A N T S
-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------

-- ----- DEPLOY MODE -----
--
-- Sets the deploy mode for the application.  Set to:
--
-- "DEV" for development.
--	- Debugging is off by default.
--	- Say-Solo is off by default.
--
-- "RELEASE" for standard release.
--	- Debugging is on by default.
--	- Say-Solo is on by default.
--
UB_DEPLOY_MODE = "RELEASE";
--UB_DEPLOY_MODE = "DEV";


-- How often do we update the state of banishes we are tracking? 
BANISH_CHECK_UPDATE_RATE = 1.0;


-- Duration of the banish spell.
BANISH_DURATION_RANK1 = 18;
BANISH_DURATION_RANK2 = 28;


-- The length of time your early banish break notification stays onscreen.
BFM_DURATION = 2.0;


COMMAND_BANISH = "COMMAND_BANISH";
COMMAND_TARGET = "COMMAND_TARGET";


-- All other localization strings are found in localization.lua.  This string
-- is initializaed here because we need it during the OnLoad event response at
-- which time the localization.lua variables are not yet available.

-- English
UB_WARLOCK							= "Warlock";
if (GetLocale() == "frFR") then
	-- French
    UB_WARLOCK						= "D\195\169moniste";
elseif (GetLocale() == "deDE") then
	-- German
    UB_WARLOCK						= "Hexenmeister";
end


-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
-- G L O B A L S
-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------

-- Only enable this AddOn if the player is a Warlock
gEnabled = false;

-- indicates whether the AddOn is initialized.
gInitialized = false;

-- Standard update clock.
gTimeSinceLastUpdate = 0;

-- Player's name
gPlayerName = nil;

-- Timer used to determine if this lock is on "banish duty".  If a lock dies
-- and this timer sits at under 60, this lock is considered on duty and the
-- other locks in the raid are notified.
gTimeSinceLastBanish = 0;

-- Used to determine when the early break notice should start fading out.
gTimeSinceLastBreakNotice = 0;

-- The name of the mob that is currently banished.
gCurrentBanishTarget = nil;

-- Indicates whether the player switched targets after beginning a banish.
gTargetDirtyFlag = false;

-- The warlock who is on deck for some kind of action (like they have died
-- and their target will be selected) when a BFM is clicked.
gWarlockOnDeck = nil;

-- The command that is on deck when a BFM is clicked.
gCommandOnDeck = nil;

-- The simulation time at which a banish was started (successfully cast).
gBanishStartTime = nil;

-- Timer that starts up after a banish is successfully cast.
gBanishTimer = BANISH_DURATION_RANK2;

-- Indicates there is a banish timer up.
gBanishFlag = false;

-- Counts the time since a Banish spellcast stopped. The reason for a
-- stop is unknown at the time it is received, and may be followed by
-- a failure event.  We have to wait until we check for that event
-- before we can declare the spell cast successful.
-- A value of -1 means no banish is scheduled.
gBanishTimerScheduled = -1;

-- Indicates there is already a banish active when another begins casting.
gAlreadyBanishFlag = false;

-- Indicates a banish was started but has not yet completed.
gBanishPendingFlag = false;

-- The current channel to announce messages on.  Currently one of "SAY", 
-- "PARTY", or "RAID".
gAnnounceChannel = "NONE";

-- Indicates that the current mob has the banish debuff to the best of our
-- knowledge.
gTargetHasBanishDebuff = false;		-- Target has the Banish debuff AFAIK

-- Count of the number of warlocks in the party/raid.
gNumWarlocks = 0;

-- List of the number of warlocks in the party/raid.
gWarlockList = {};

-- The current alpha level of the early break notice.  Used for fading it out.
gBFMFrameAlpha = 0.0;

-- Indicates whether or not to spit out debug messages.
gDebugFlag = true;

-- Indicates which rank of Banish is currently being cast.
gPreviousBanishRank = -1;
gCurrentBanishRank = 2;


-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
-- F U N C T I O N S
-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------

--[[
--
-- FUNCTION
--
-- Prints 'msg' if and only if the output frame is valid.
--
--]]
function UberBanish_Print(msg)
	local msgOutput = DEFAULT_CHAT_FRAME;
	if (msgOutput) then
		msgOutput:AddMessage("<UberBanish> " .. msg, .25, 1, 1);
	end
end


--[[
--
-- FUNCTION
--
-- Prints 'msg' if and only if the output frame is valid and the debug flag 
-- is up.
--
--]]
function UberBanish_Debug(msg)
	local msgOutput = DEFAULT_CHAT_FRAME;
	if (msgOutput and gDebugFlag) then
		msgOutput:AddMessage("<UberBanish> " .. msg, .25, 1, 1);
	end
end


--[[
--
-- FUNCTION
--
-- Sends a chat message on the selected channel.
--
--]]
function UberBanish_Say(msg)
	
	-- If the player is solo and they have say-when-solo off, don't display the message
	if (gAnnounceChannel == "SAY" and UberBanish_Config.SayWhenSolo == false) then
		return;
	end
	SendChatMessage(msg, gAnnounceChannel);

end


--[[
--
-- FUNCTION
--
-- Prints 'msg' if and only if the output frame is valid and the debug flag 
-- is up.
--
--]]
UberBanish_RegisterCommands = function()
	SLASH_UBERBANISH1 = "/uberbanish";
	SLASH_UBERBANISH2 = "/ub";
	SlashCmdList["UBERBANISH"] = function(msg)
		UberBanish_Slash(msg);
	end
end;


--[[
--
-- FUNCTION
--
-- Processes slash commands.
--
--]]
function UberBanish_Slash(msg)
	UberBanish_Debug("Slash command: " .. msg);

	msg = string.lower(msg);
	local first, last, cmd, val = string.find (msg, "(%w+) ([_%w]+)");

	if (cmd == nil and val == nil) then
		first, last, cmd = string.find(msg, "(%w+)");
	end

	if (cmd == nil) then
		UberBanish_DisplayCommands();
		return;
	end


	-- Config Panel
	if (cmd == "" or cmd == "config") then
		UberBanishConfigFrame:Show();
	end


	-- Enable / disable
	if (cmd == "enable") then

		if (gEnabled == true) then 
			return; 
		else
			gEnabled = true;
			UberBanish_Initialize();
		end

	elseif (cmd == "disable") then

		if (gEnabled == true) then
			return;
		else
			gEnabled = false;
			unregisterEvents();
		end

	end


	-- Debugging
	if (cmd == "debug") then
		if (val == nil) then
			UberBanish_Print("Debugging: " .. tostring(gDebugFlag));
		else
			if (val == "on") then
				gDebugFlag = true;
				UberBanish_Print("Debugging is now on.");
			elseif (val == "off") then
				gDebugFlag = false;
				UberBanish_Print("Debugging is now off.");
			else
				UberBanish_Print("Unable to understand: " .. val);
			end
		end
	end


	-- Say When Solo
	if (cmd == "saysolo") then
		if (val == nil) then
			UberBanish_Print("Say When Solo: " .. tostring(UberBanish_Config.SayWhenSolo));
		else
			if (val == "on") then
				UberBanish_Config.SayWhenSolo = true;
				UberBanish_Print("Say-When-Solo is now on.");
			elseif (val == "off") then
				UberBanish_Config.SayWhenSolo = false;
				UberBanish_Print("Say-When-Solo is now off.");
			else
				UberBanish_Print("Unable to understand: " .. val);
			end
		end
	end


end


-- check each variable in two tables making sure their variable type match.
function TableTypeMatch(table1, table2)
	if (table1 == nil or table2 == nil) then return false; end
	for key,value in pairs(table1) do
		if type(table1[key]) ~= type(table2[key]) then
			return false
		end
	end
	return true;
end


--[[
--
-- FUNCTION
--
-- Displays available slash commands.
--
--]]
UberBanish_DisplayCommands = function()
	UberBanish_Print("UberBanish Usage:");
	UberBanish_Print("/ub <enable|disable>         -- enable/disable UberBanish" );
	UberBanish_Print("/ub debug <on|off>           -- print debug msgs" );
	UberBanish_Print("/ub saysolo <on|off>        -- announce timer aloud when solo");
end;


--[[
--
-- FUNCTION
--
-- Registers this AddOn for all base and world events.
--
--]]
function registerEvents()
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	registerWorldEvents();
end


--[[
--
-- FUNCTION
--
-- Registers this AddOn for world events only.
--
--]]
function registerWorldEvents()

	-- Used to detect when a spell was resisted or immune
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER");
	this:RegisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:RegisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
	this:RegisterEvent("CHAT_MSG_WHISPER");

	this:RegisterEvent("PLAYER_DEAD");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");

	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("RAID_ROSTER_UPDATE");

	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");

end


--[[
--
-- FUNCTION
--
-- Unregisters this AddOn for all base and world events.
--
--]]
function unregisterEvents()
	this:UnregisterEvent("PLAYER_ENTERING_WORLD");
	this:UnregisterEvent("PLAYER_LEAVING_WORLD");
	unregisterWorldEvents();
end


--[[
--
-- FUNCTION
-- 
-- Deregisters this AddOn for world events only.
--
--]]
function unregisterWorldEvents()
	this:UnregisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:UnregisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER");
	this:UnregisterEvent("CHAT_MSG_SPELL_AURA_GONE_OTHER");
	this:UnregisterEvent("CHAT_MSG_SPELL_BREAK_AURA");
	this:UnregisterEvent("CHAT_MSG_WHISPER");

	this:UnregisterEvent("PLAYER_DEAD");
	this:UnregisterEvent("PLAYER_LEAVE_COMBAT");
	this:UnregisterEvent("PLAYER_TARGET_CHANGED");

	this:UnregisterEvent("PARTY_MEMBERS_CHANGED");
	this:UnregisterEvent("RAID_ROSTER_UPDATE");

	this:UnregisterEvent("SPELLCAST_STOP");
	this:UnregisterEvent("SPELLCAST_FAILED");
	this:UnregisterEvent("SPELLCAST_INTERRUPTED");
end


--[[
--
-- FUNCTION
--
-- Initializes session variables.
--
--]]
function UberBanish_InitVars()
	-- First install or upgrade, Load Variable from default and show config window
	if (type(UberBanish_Config) ~= "table" or 
		not TableTypeMatch(Default_UberBanish_Config, UberBanish_Config) or 
		(UberBanish_Config.Version ~= Default_UberBanish_Config.Version)) then
		UberBanish_Config = {};
		UberBanish_Config = Default_UberBanish_Config;
		UberBanish_Debug("No config set.  Loaded defaults.");
	else
		UberBanish_Debug("Config found and loaded.");
	end

	if (Default_UberBanish_Config.FiveSecWarning) then
		UberBanish_Debug("Config is valid...");
	end
end


--[[
--
-- FUNCTION
--
-- Initializes the AddOn.
--
--]]
function UberBanish_Initialize()

	-- If player isn't a warlock, bail.
	local class = UnitClass("player");
	UberBanish_Debug("Player class is: " .. class .. " and we're looking for: " .. UB_WARLOCK);
	if (class ~= UB_WARLOCK) then
		UberBanish_Debug("Player is not a Warlock.  Bailing...");
		gEnabled = false;
		return;
	end


	-- Check deploy mode.
	if (UB_DEPLOY_MODE == "DEV") then
		gDebugFlag = true;
	elseif (UB_DEPLOY_MODE == "RELEASE") then
		gDebugFlag = false;
	end


	gEnabled = true;

	gPlayerName = UnitName("player");
	
	UberBanish_Debug("Player is a Warlock.");
	registerEvents();

	-- Slash interface
	UberBanish_RegisterCommands();

	UberBanish_UpdateWarlockList();

	if (gDebugFlag) then
		UberBanish_BFM("UberBanish Initialized...");
	end
	gInitialized = true;
	UberBanish_Print(UB_TITLE_VERSION .. " initialized.");
	UberBanish_Print("/ub config for configuration panel.");
	UberBanish_Print("/ub help for command list.");

end


--[[
--
-- FUNCTION
--
-- Kills the Banish timer.
--
--]]
function UberBanish_StartTimer()
	UberBanish_Debug("BANISH CAST.  Starting timer...");
	gCurrentBanishTarget = UnitName("target");
	gTargetDirtyFlag = false;
	gBanishPendingFlag = false;
	gBanishFlag = true;
	gBanishTimer = UberBanish_GetBanishDuration();
	--gBanishTimer = BANISH_DURATION;
	gBanishStartTime = GetTime();
	gTimeSinceLastBanish = 0;
end


--[[
--
-- FUNCTION
--
-- Kills the Banish timer.
--
--]]
function UberBanish_KillTimer()

	UberBanish_Debug("BANISH ENDED.  Killing the timer...");
	gTargetHasBanishDebuff = false;
	gBanishFlag = false;
	gAlreadyBanishFlag = false;
	gBanishTimer = UberBanish_GetBanishDuration();
	--gBanishTimer = BANISH_DURATION;
	gCurrentBanishTarget = "";

end


--[[
--
-- FUNCTION
--
-- Used to determine when a banish has been started.
--
--]]
UberBanish_GameUseAction = UseAction;
function UberBanish_OnUseAction(slot, checkCursor, onSelf)

	UberBanish_GameUseAction(slot, checkCursor, onSelf);

	if (GetActionText(slot) == nil) then
	
		UberBanish_SpellDetector:Hide();
		UberBanish_SpellDetector:SetOwner(UberBanishFrame,"ANCHOR_NONE");
		UberBanish_SpellDetector:SetAction(slot);

		-- Get the spell name
		local spellName = nil;
	
		if (UberBanish_SpellDetectorTextLeft1 ~= nil) then
			spellName = UberBanish_SpellDetectorTextLeft1:GetText();
		end

		if (spellName == nil) then
			return;
		end

		local spellRank = nil;

		if UberBanish_SpellDetectorTextRight1 ~= nil then
			spellRank = UberBanish_SpellDetectorTextRight1:GetText();
		end;

		-- Get the spell rank
		local rank = nil;
	
		if spellRank ~= nil then
			local _, _, spellRankString = string.find( spellRank, "[^%d]*(%d+)");
				rank = tonumber(spellRankString);
				UberBanish_Debug("UseAction!! Code:" .. slot .. " Text: " .. spellName .. "  Rank: " .. tostring(spellRank));
		else
				UberBanish_Debug("UseAction!! Code:" .. slot .. " Text: " .. spellName .. " No Rank!!");
		end

		if (string.upper(spellName) == string.upper(UB_L8N_BANISH)) then
			UberBanish_Debug("Player has started a Banish!! ");
			gPreviousBanishRank = gCurrentBanishRank;
			gCurrentBanishRank = rank;
			gBanishTimer = UberBanish_GetBanishDuration();
			gBanishPendingFlag = true;
			-- Early Dismissal of Notice Banner
			gTimeSinceLastBreakNotice = BFM_DURATION;
		else
			gBanishPendingFlag = false;
		end

	end

end
UseAction = UberBanish_OnUseAction;


--[[
--
-- FUNCTION
--
-- Returns a group count, regardless of party type.
--
--]]
function UberBanish_GetGroupCount()

	local groupCount = GetNumRaidMembers();
	if (groupCount == 0) then
		-- We are not in a raid.
		groupCount = GetNumPartyMembers();
	end

	return groupCount;

end


--[[
--
-- FUNCTION
--
-- CURRENTLY UNUSED:  Will be for supressing notice of outgoing UberBanish whispers.
--
--]]
--[[UberBanish_GameChatFrame_OnEvent = ChatFrame_OnEvent;
function UberBanish_ChatFrame_OnEvent(event)
	if ((event == "CHAT_MSG_WHISPER") or (event == "CHAT_MSG_WHISPER_NOTICE")) then
		if (string.find(arg1, "<UberBanish>") == 1) then
			return;
		end
	end
	return UberBanish_GameChatFrame_OnEvent(event);
end
CastSpellByName = UberBanish_ChatFrame_OnEvent;--]]


--[[
--
-- FUNCTION
--
-- Traps the casting of a spell by name (as in a macro or AddOn).
--
--]]
UberBanish_GameCastSpellByName = CastSpellByName;
function UberBanish_OnCastSpellByName(spellName)

	UberBanish_GameCastSpellByName(spellName);
	UberBanish_Debug("CastSpellByName: " .. spellName);

	if (string.upper(spellName) == string.upper(UB_L8N_BANISH)) then
		
		UberBanish_Debug("Player has started a Banish!! (Assuming rank 2) ");
		gPreviousBanishRank = gCurrentBanishRank;
		gCurrentBanishRank = 2;
		gBanishPendingFlag = true;

	elseif(string.upper(spellName) == string.upper(UB_L8N_BANISH_RANK1)) then

		UberBanish_Debug("Player has started a Banish!! (Rank 1) ");
		gPreviousBanishRank = gCurrentBanishRank;
		gCurrentBanishRank = 1;
		gBanishPendingFlag = true;

	elseif(string.upper(spellName) == string.upper(UB_L8N_BANISH_RANK2)) then

		UberBanish_Debug("Player has started a Banish!! (Rank 2) ");
		gPreviousBanishRank = gCurrentBanishRank;
		gCurrentBanishRank = 2;
		gBanishPendingFlag = true;

	else 
		gBanishPendingFlag = false;
	end

	if (gBanishPendingFlag) then
		-- Early Dismissal of Notice Banner
		gTimeSinceLastBreakNotice = BFM_DURATION;
	end

end
CastSpellByName = UberBanish_OnCastSpellByName;


--[[
--
-- FUNCTION
--
-- UNUSED:  Traps the casting of a spell by id (as in a macro or AddOn).
--
--]]
--[[UberBanish_GameCastSpell = CastSpell;
function UberBanish_OnCastSpell(spellId, spellBookTabNum)
	UberBanish_GameCastSpell(spellId, spellBookTabNum);
	UberBanish_Debug("JOE:::: Cast Banish!!");
	-- local spellName, spellRank = GetSpellName(spellId, spellbookTabNum);
	-- UberBanish_Debug("CastSpell!!" .. spellName);
end
CastSpell = UberBanish_OnCastSpell;--]]


--[[
--
-- FUNCTION
--
-- Callback for OnLoad event.
--
--]]
function UberBanish_OnLoad()
	gInitialized = false;
	UberBanish_Initialize();
	-- this:RegisterForDrag("LeftButton");
	-- this:TimeSinceLastUpdate = 0;
end


--[[
--
-- FUNCTION
--
-- Callback for BFM Frame's OnLoad event.
--
--]]
function UberBanishBFMFrame_OnLoad()
end


--[[
--
-- FUNCTION
--
-- Callback for BFM Frame's OnMouseUp event.
--
--]]
function UberBanishBFMFrame_OnMouseUp()

	-- A warlock has died...select his target
	if (gWarlockOnDeck ~= nil and gCommandOnDeck == COMMAND_TARGET) then
		AssistByName(gWarlockOnDeck);

	-- This warlock's banish broke.  Rebanish.
	elseif (gWarlockOnDeck == nil and gCommandOnDeck == COMMAND_BANISH) then
		CastSpellByName("Banish");

	end

end


--[[
--
-- FUNCTION
--
-- Callback for OnEvent.
--
--]]
function UberBanish_OnEvent(event, arg1, arg2)

	UberBanish_Debug("Got An Event!!!" .. event);
	-- UberBanish_SpamWarlocks("You fuckers!!");

	
	if ((event == "SPELLCAST_FAILED") or 
		(event == "SPELLCAST_INTERRUPTED") or
		(event == "CHAT_MSG_SPELL_FAILED_LOCALPLAYER")) then
		
			UberBanish_Debug("Pending: " ..
				tostring(gBanishPendingFlag) ..
				"  already: " .. tostring(gAlreadyBanishFlag) ..
				"  banish: " .. tostring(gBanishFlag));
		-- If a pending banish failed AND there is not another banish up, then
		-- kill the timer.
		if (gBanishPendingFlag) then
			UberBanish_KillTimer();
			gBanishTimerScheduled = -1;
			return;
		end

	elseif (event == "CHAT_MSG_SPELL_SELF_DAMAGE") then

        -- Determine if the target resisted
        local found, _, spellName, mobName, index3, index4, index5 = string.find(arg1, UB_SPELLRESISTSELFOTHER);
        if (found and (spellName == UB_L8N_BANISH)) then
            UberBanish_Debug("CHECK: " .. tostring( spellName ) .. " was resisted by " .. tostring( mobName ));
			if (gAlreadyBanishFlag) then
				UberBanish_Debug("There is another active Banish up...not killing timer.");
			else
				gBanishTimerScheduled = -1;
				UberBanish_KillTimer();
			end
            return;
        end

        -- Determine if the target was immune
        local found, _, spellName, mobName, index3, index4, index5 = string.find(arg1, UB_SPELLIMMUNESELFOTHER);
        if (found and (spellName == UB_L8N_BANISH)) then
            UberBanish_Debug("CHECK: " .. tostring( mobName ) .. " was immune to " .. tostring( spellName ));
            UberBanish_Debug("FLAG: " .. tostring(gBanishFlag) .. "   TIMER: " .. tostring(gBanishTimer));
			if (gAlreadyBanishFlag) then
				UberBanish_Debug("There is another active Banish up...not killing timer.");
			else
				gBanishTimerScheduled = -1;
				UberBanish_KillTimer();
			end
            return;
        end

        -- Determine if the target was evaded
        local found, _, spellName, mobName, index3, index4, index5 = string.find(arg1, UB_SPELLEVADEDSELFOTHER);
        if (found and (spellName == UB_L8N_BANISH)) then
            UberBanish_Debug("CHECK: " .. tostring( mobName ) .. " evaded your " .. tostring( spellName ));
			if (gAlreadyBanishFlag) then
				UberBanish_Debug("There is another active Banish up...not killing timer.");
			else
				gBanishTimerScheduled = -1;
				UberBanish_KillTimer();
			end
            return;
        end


	elseif (event == "SPELLCAST_STOP") then

		-- Banish may have been cast properly, or may have been interrupted.
		-- Start up the timers anyway, but don't start reporting until we
		-- give the SPELLCAST_INTERRUPTED event a chance to come in.
		if (gBanishPendingFlag) then

			local existingBanishThreshold = 28;
			if (gPreviousBanishRank == 1) then
				existingBanishThreshold = 18;
			end

			-- If there's already an active Banish and the target hasn't switched, 
			-- we know this one will fail due to immunity.  In this case we don't want to
			-- clobber the exiting timer because that Banish will still
			-- play out.
			if (gBanishFlag and 
				(gTargetDirtyFlag == false) and
				gTimeSinceLastBanish <= existingBanishThreshold) then
				UberBanish_Debug("There is already another Banish up.  Flagging...");
				gAlreadyBanishFlag = true;
			else
				gAlreadyBanishFlag = false;
				-- This is possibly a new, successful banish.  If an interrupt or resist or 
				-- failure does not come next, then it is definitely a successful banish.
				-- The timer start actually occurs in UberBanish_UpdateBanishTimer().
				gBanishTimerScheduled = GetTime();
			end

		end

	elseif (event == "PLAYER_DEAD") then

		-- Player died.
		UberBanish_Debug("Player dead and time since last banish: " .. gTimeSinceLastBanish);

		if (gTimeSinceLastBanish <= 60 and UberBanish_Config.NotifyLocksOnDeath) then
			-- Player died within 60 seconds of a banish and so is considered
			-- "On banish duty".
			UberBanish_KillTimer();
			UberBanish_SpamWarlocks(UB_L8N_WARLOCKS .. ":  " .. 
				UnitName("player") .. 
				UB_L8N_HAS_DIED_WHILE_BANISHING);
			UberBanish_ReportWarlockDeath();
		end

	elseif (event == "PLAYER_LEAVE_COMBAT") then

		-- Player has left combat (except by fleeing).  Clear everything.
		--[[gTargetHasBanishDebuff = false;
		gBanishFlag = false;
		gBanishPendingFlag = false;
		--gBanishTimer = BANISH_DURATION;--]]
		
	elseif (event == "PLAYER_TARGET_CHANGED") then

		-- If we switch to a target that is NOT Banished, then targeting is
		-- considered "dirty".  There may still be a valid banish up but we 
		-- cannot make guesses about it's status, so we continue counting it
		-- down.  If we switch to a target that IS banished, we consider that
		-- a re-acquire and the dirty flag is cleared.  This will result in 
		-- a problem if the warlock selects another warlock's banished mob.
		local currentTarget = UnitName("target");
		if (UberBanish_IsTargetBanished() and (gCurrentBanishTarget == currentTarget)) then
			UberBanish_Debug("Banish target reacquired!");
			gTargetDirtyFlag = false;
		else
			gTargetDirtyFlag = true;
		end
	
	elseif (event == "CHAT_MSG_SPELL_AURA_GONE_OTHER") then 

		UberBanish_Debug("Banish may have broken early.  Checking...");
		local banishBroke = false;

		-- If there is a banish pending we want to skip this event.
		--[[if (gBanishPendingFlag) then
			UberBanish_Debug("There is a banish pending...skipping break check.");
			return;
		end--]]

		-- If there is no banish up, we want to skip this event.
		if (gBanishFlag == false) then
			UberBanish_Debug("There is no banish...skipping break check.");
			return;
		end

		-- If we are within the first 2 seconds of a Banish, the debuff might
		-- not be posted yet due to lag, so skip this check.
		local breakThreshold = 28;
		if (gCurrentBanishRank == 1) then
			breakThreshold = 18;
		end
		if (gBanishTimer >= breakThreshold) then
			UberBanish_Debug("We are in the first 2 seconds of a banish...skipping break check.");
			return;
		end

		-- First try a hard check.  If our target hasn't changed, then it's
		-- simply a matter of checking the current target for the Banish debuff.
		if (gTargetDirtyFlag == false) then

			UberBanish_Debug("Hard break check...");
			banishBroke = UberBanish_CheckBanishBroke();

		-- Otherwise try a soft check.  If our target has changed, we'll analyze
		-- the break message and see if the spell Banish faded off a mob with
		-- the same name as ours.
		else

			UberBanish_Debug("Soft break check...");

			-- arg1 "Banish fades from Felguard Elite "
        	local found, _, spellName, mobName, index3, index4, index5 = string.find(arg1, UB_SPELLEVADEDSELFOTHER);
			if ((spellName == UB_L8N_BANISH) and (mobName == gCurrentBanishTarget)) then
				banishBroke = true;
			end

		end

		-- If the banish was broken, report it!
		if (banishBroke) then
			
			UberBanish_KillTimer();
			
			UberBanish_Debug("Banish broke early!!");
			gWarlockOnDeck = nil;				-- Select THIS Warlock
			gCommandOnDeck = COMMAND_BANISH;	-- Banish THIS Warlock's target.
			UberBanish_BFM(UB_L8N_MOB_BROKE_YOUR_BANISH);
			PlaySound("igQuestLogAbandonQuest");
			UberBanish_ReportBanishBroke();
		end

	elseif (event == "CHAT_MSG_WHISPER") then

		local first, last, content = string.find(arg1, '<UberBanishBC> (.*)');
		if (first == 1) then
			PlaySound("igQuestLogAbandonQuest");
			UberBanish_ExtractPlayerFromContent(content);
			UberBanish_BFM(content);
		end

	elseif ((event == "PARTY_MEMBERS_CHANGED") or
			(event == "RAID_ROSTER_UPDATE")) then

		-- This event is raised on just about every group event.  We just
		-- refresh the warlock list here.
		UberBanish_UpdateWarlockList();
		UberBanish_UpdateAnnounceChannel();

	elseif event == "PLAYER_ENTERING_WORLD" then

		-- Player has changed zones
		UberBanish_InitVars();
		UberBanish_UpdateAnnounceChannel();
		registerWorldEvents();

	elseif event == "PLAYER_LEAVING_WORLD" then

		-- Player has changed zones
	    unregisterWorldEvents();

	end

end


--[[
--
-- FUNCTION
--
-- 
--
--]]
function UberBanish_UpdateAnnounceChannel()

	-- Are we in a raid?
	local groupCount = GetNumRaidMembers();
	if (groupCount >= 1) then
		gAnnounceChannel = "RAID";
		return;
	end

	-- Not in a raid. Party, or solo?
	local groupCount = UberBanish_GetGroupCount();

	if (groupCount == 0) then
		-- Solo
		gAnnounceChannel = "SAY";
	else
		-- Party
		gAnnounceChannel = "PARTY";
	end

	UberBanish_Debug("The new chnnel is: " .. gAnnounceChannel);

end


--[[
--
-- FUNCTION
--
-- Callback for the OnUpdate event.
--
--]]
function UberBanish_OnUpdate(arg1)

	-- Update all timers.
	gTimeSinceLastUpdate = gTimeSinceLastUpdate + arg1;
	gTimeSinceLastBanish = gTimeSinceLastBanish + arg1;
	gTimeSinceLastBreakNotice = gTimeSinceLastBreakNotice + arg1;


	-- If there is a BIG FAT MESSAGE up, check if it has completed its duration
	-- and begin fading out if yes.
	if (gTimeSinceLastBreakNotice > BFM_DURATION) then
		if (gBFMFrameAlpha > .2) then
			gBFMFrameAlpha = gBFMFrameAlpha - .05;
			UberBanishBFMFrame:SetAlpha(gBFMFrameAlpha);
		else
			UberBanishBFMFrame:Hide();
		end
	end

	UberBanish_UpdateBanishTimer();

end


--[[
--
-- FUNCTION
--
-- 
--
--]]
function UberBanish_UpdateBanishTimer()

	local currentTime = GetTime();

	-- Do we have a successful Banish?
	if (gBanishTimerScheduled >= 0) then

		-- Yes!!   A Banish was cast and landed successfully.
		local timeSinceSchedule = currentTime - gBanishTimerScheduled;
		-- Give half a second for the failure event to occur
		if (timeSinceSchedule > 1.0) then 
			gTargetHasBanishDebuff = UberBanish_IsTargetBanished();
			if (gTargetHasBanishDebuff) then
				UberBanish_Debug("BANISH WAS SUCCESSFULLY CAST!!!");
				gBanishTimerScheduled = -1;
				UberBanish_KillTimer();
				UberBanish_StartTimer();
			end
		else
			--UberBanish_Debug("There is a banish scheduled, but waiting for possible failure...");
		end

	end

	if (gBanishFlag == false) then
		return;
	end

	local rawDelta = currentTime - gBanishStartTime;
	local duration = UberBanish_GetBanishDuration();
	local tmp = duration - floor(rawDelta);
	local intSnap = false;

	-- Report timer only at the integers
	if (tmp < gBanishTimer) then
		intSnap = true;
		UberBanish_Debug("Banish Timer: " .. tmp);
	end

	gBanishTimer = tmp;
	

	-- First check to see if the banish is still up.  We can't always rely on
	-- the CHAT_MSG_SPELL_AURA_GONE_OTHER event being thrown.
	-- Also, if the player has switched targets during the banish, we don't
	-- want to make this check.
	-- We check only after 2 seconds have passed to allow lag time for the 
	-- Banish to appear on the MOB.
	if (rawDelta >= 2 and (gTargetDirtyFlag == false)) then
		local banishBroke = UberBanish_CheckBanishBroke();
		if (banishBroke and intSnap) then
			UberBanish_Debug("UberBanish_UpdateBanishTimer decided that Banish broke early!!");
			gWarlockOnDeck = nil;				-- Select THIS Warlock
			gCommandOnDeck = COMMAND_BANISH;	-- Banish THIS Warlock's target.
			UberBanish_KillTimer();
			UberBanish_BFM(UB_L8N_MOB_BROKE_YOUR_BANISH);
			PlaySound("igQuestLogAbandonQuest");
			UberBanish_ReportBanishBroke();
		end
	end

	-- We wait 2 seconds to report in case the spell is interrupted or 
	-- resisted because we need to allow time for the other events to come in.
	local reportThreshold = 27;
	if (gCurrentBanishRank == 1) then
		reportThreshold = 17;
	end
	if (gBanishTimer == reportThreshold and intSnap) then
		gTargetHasBanishDebuff = UberBanish_IsTargetBanished();
		if (gTargetHasBanishDebuff and UberBanish_Config.SpamBanishStart) then
			UberBanish_Say(gPlayerName .. UB_L8N_HAS_BANISHED .. gCurrentBanishTarget .. ".");
		end
	end

	-- Only report updates to the group at user designated intervals.
	if (intSnap) then
		if ((gBanishTimer == 20 and UberBanish_Config.TwentySecWarning) or
			(gBanishTimer == 10 and UberBanish_Config.TenSecWarning) or
			(gBanishTimer == 5 and UberBanish_Config.FiveSecWarning)) then
			UberBanish_Say(UB_L8N_BANISH_BREAKS_IN .. gBanishTimer .. UB_L8N_SECONDS);
		end
	end

	-- Banish is done!!
	if (gBanishTimer == 1 and intSnap and UberBanish_Config.SpamBanishEnd) then
		UberBanish_Say(UB_L8N_MY_BANISH_EXPIRES);
	end

	-- The banish has ended...reset.
	if (gBanishTimer < 0) then
		UberBanish_KillTimer();
	end

	gTimeSinceLastUpdate = 0;

end


--[[
--
-- FUNCTION
--
-- Puts up a BIG FAT MESSAGE box which fades out after 
-- BFM_DURATION seconds.
--
--]]
function UberBanish_BFM(msg)
	UberBanishBFMText:SetText(msg);
	gTimeSinceLastBreakNotice = 0.0;
	gBFMFrameAlpha = 1.0;
	UberBanishBFMFrame:SetAlpha(gBFMFrameAlpha);
	UberBanishBFMFrame:Show();
end


--[[
--
-- FUNCTION
--
-- Sends a message to all the other warlocks in the raid.
--
--]]
function UberBanish_SpamWarlocks(msg)

	local name;

	for i = 1, gNumWarlocks do
		name = gWarlockList[i];
		if ((name ~= nil) and (name ~= gPlayerName)) then 
			--UberBanish_Debug("index: " .. i);
			--UberBanish_Debug("Spamming: " .. name);
			SendChatMessage("<UberBanishBC> " .. msg, "WHISPER", nil, name);
		end
	end

end


--[[
--
-- FUNCTION
--
-- Iterates through all the group members, storing all the Warlocks.
--
--]]
function UberBanish_UpdateWarlockList()

	UberBanish_Debug(" UpdateWarlock: Refreshing Warlock List");

	gWarlockList = {};
	local index = 1;
	gWarlockList[1] = UnitName("player");
	index = index + 1;

	local groupCount = UberBanish_GetGroupCount();
	if (groupCount == 0) then
		UberBanish_Debug("Not in a group!  Bailing...");
		return;
	end
	local memberCount = GetNumRaidMembers();
	local isRaid = (memberCount > 0);
	local name, rank, subgroup, level, class, fileName, zone, online;


	-- For Raid
	if (isRaid) then

		for i = 1, groupCount do
	
			if (isRaid) then
	
				name, rank, subgroup, level, class, fileName, zone, online = GetRaidRosterInfo(i);
				if (class ~= nil) then
					UberBanish_Debug("UpdateWarlock: Checking raid member: " .. name .. " -> " .. class);
					if (class == "Warlock") then
						UberBanish_Debug("UpdateWarlock: " .. name .. " is a Warlock!!");
						gWarlockList[index] = name;
						index = index + 1;
					end
				end
			
			end

		end

	else

		gWarlockList[index] = UnitName("player");
		index = index + 1;

		for i = 1, MAX_PARTY_MEMBERS do

			if (GetPartyMember(i)) then
				UberBanish_Debug("UpdateWarlock: Checking party member: " .. i);
				name = UnitName("party" .. i);
				class = UnitClass("party" .. i);
				if (name ~= nil) then 
					UberBanish_Debug("Name: " .. name);
				end
				if (class ~= nil) then
					UberBanish_Debug("Class: " .. class);
				end
				if (class == "Warlock") then
					UberBanish_Debug("UpdateWarlock: " .. name .. " is a Warlock!!");
					gWarlockList[index] = name;
					index = index + 1;
				end
			end

		end

	end

	gNumWarlocks = index + 1;

end


--[[
--
-- FUNCTION
--
-- Reports that a banish broke early.
--
--]]
function UberBanish_ReportBanishBroke()
	if (UberBanish_Config.SpamEarlyBreak) then
		UberBanish_Say("WARNING!! My banish broke early!!");
	end
end


--[[
--
-- FUNCTION
--
-- Reports that a warlock died while on banish duty.
--
--]]
function UberBanish_ReportWarlockDeath()
	if (UberBanish_Config.SpamDeath) then
		UberBanish_Say("WARNING!! " .. UnitName("Player") .. " has died while banishing!");
	end
end


--[[
--
-- FUNCTION
--
-- Scans the current target for the Banish debuff.
--
--]]
function UberBanish_IsTargetBanished()

	local iIterator = 1;
	local result = false;

	-- Iterate through all debuffs on the current target and look for banish.
	while (UnitDebuff("target", iIterator)) do
	    local debuffString = UnitDebuff("target", iIterator);
	    if (string.find(debuffString, "Interface\\Icons\\Spell_Shadow_Cripple")) then
	        --UberBanish_Debug("I think this creature is still banished...");
	        result = true;
	        break;
	    end
	    iIterator = iIterator + 1;
	end

	return result;

end


--[[
--
-- FUNCTION
--
-- Looks for the banish debuff on the current target.  If there is not and there
-- is currently a banish timer up, we consider this an early break situation and
-- return true.
--
--]]
function UberBanish_CheckBanishBroke()

	local result = false;
	local detectBanish = false;

	gTargetHasBanishDebuff = UberBanish_IsTargetBanished();
	detectBanish = gTargetHasBanishDebuff;

	--UberBanish_Debug("CheckBanishBroke:");
	--UberBanish_Debug("detectBanish: " .. tostring(detectBanish));
	--UberBanish_Debug("gTargetHasBanishDebuff: " .. tostring(gTargetHasBanishDebuff));
	--UberBanish_Debug("gBanishFlag: " .. tostring(gBanishFlag));
	--UberBanish_Debug("gBanishTimer: " .. gBanishTimer);

	-- If the banish flag was up AND there isn't a Banish about to land AND we 
	-- did not find the banish debuff AND the timer is valid,
	-- then the banish is considered broken.
	if (gBanishFlag and
		(gBanishPendingFlag == false) and
		(detectBanish == false) and
		gBanishTimer > 0) then
		result = true;
		UberBanish_KillTimer();
	end

	return result;

end


--[[
--
-- FUNCTION
--
-- When an UberBanish broadcast message is sent that is intended to
-- identify a specific warlock, it will be of the form:
--
--	WARLOCKS: Foo has ....
--
-- This function grabs the Warlock name from these messages and places
-- it on deck.
--
--]]
function UberBanish_ExtractPlayerFromContent(content)
	local first, last, name = string.find(content, 'WARLOCKS: (%w*)');
	-- Place the warlock's name on deck so that if this warlock clicks
	-- the BFM, that warlock will be affected.
	if (first == 1) then
		gWarlockOnDeck = name;
		gCommandOnDeck = COMMAND_TARGET;
	end
end


--[[
--
-- FUNCTION
-- 
-- You *must* set these values explicitly as booleans otherwise they
-- don't persist properly in SavedVariables.
--
--]]
function CommitConfigSettings()

	-- Spam Banish Start
	if (CheckButton_SpamBanishStart:GetChecked()) then	
		UberBanish_Config.SpamBanishStart = true;
	else
		UberBanish_Config.SpamBanishStart = false;
	end

	-- 20 Second Warning
	if (CheckButton_SpamBanishEnd:GetChecked()) then	
		UberBanish_Config.SpamBanishEnd = true;
	else
		UberBanish_Config.SpamBanishEnd = false;
	end

	-- 20 Second Warning
	if (CheckButton_CD20Sec:GetChecked()) then	
		UberBanish_Config.TwentySecWarning = true;
	else
		UberBanish_Config.TwentySecWarning = false;
	end

	-- 10 Second Warning
	if (CheckButton_CD10Sec:GetChecked()) then
		UberBanish_Config.TenSecWarning = true;
	else
		UberBanish_Config.TenSecWarning = false;
	end

	-- 5 Second Warning
	if (CheckButton_CD05Sec:GetChecked()) then
		UberBanish_Config.FiveSecWarning = true;
	else
		UberBanish_Config.FiveSecWarning = false;
	end

	-- Notify locks on death
	if (CheckButton_NotifyOtherWarlocksOnDeath:GetChecked()) then
		UberBanish_Config.NotifyLocksOnDeath = true;
	else
		UberBanish_Config.NotifyLocksOnDeath = false;
	end

	-- Span Early Break
	if (CheckButton_SpamRaidEarlyBreak:GetChecked()) then
		UberBanish_Config.SpamEarlyBreak = true;
	else
		UberBanish_Config.SpamEarlyBreak = false;
	end

	-- Spam Death
	if (CheckButton_SpamRaidDeath:GetChecked()) then
		UberBanish_Config.SpamDeath = true;
	else
		UberBanish_Config.SpamDeath = false;
	end

	-- Say When Solo
	if (CheckButton_SayWhenSolo:GetChecked()) then
		UberBanish_Config.SayWhenSolo = true;
	else
		UberBanish_Config.SayWhenSolo = false;
	end

	UberBanish_Debug("Commit: Spam Banish Start: " .. tostring(UberBanish_Config.SpamBanishStart));
	UberBanish_Debug("Commit: Spam Banish End: " .. tostring(UberBanish_Config.SpamBanishEnd));
	UberBanish_Debug("Commit: 20 Seconds: " .. tostring(UberBanish_Config.TwentySecWarning));
	UberBanish_Debug("Commit: 10 Seconds: " .. tostring(UberBanish_Config.TenSecWarning));
	UberBanish_Debug("Commit: 05 Seconds: " .. tostring(UberBanish_Config.FiveSecWarning));
	UberBanish_Debug("Commit: Notify Locks On Death: " .. tostring(UberBanish_Config.NotifyLocksOnDeath));
	UberBanish_Debug("Commit: Spam Early Break: " .. tostring(UberBanish_Config.SpamEarlyBreak));
	UberBanish_Debug("Commit: Spam Death: " .. tostring(UberBanish_Config.SpamDeath));
	UberBanish_Debug("Commit: Say When Solo: " .. tostring(UberBanish_Config.SayWhenSolo));
end


--[[
--
-- FUNCTION
-- 
-- 
--
--]]
function PopulateCheckBoxes()
	CheckButton_SpamBanishStart:SetChecked(UberBanish_Config.SpamBanishStart);
	CheckButton_SpamBanishEnd:SetChecked(UberBanish_Config.SpamBanishEnd);
	CheckButton_CD20Sec:SetChecked(UberBanish_Config.TwentySecWarning);
	CheckButton_CD10Sec:SetChecked(UberBanish_Config.TenSecWarning);
	CheckButton_CD05Sec:SetChecked(UberBanish_Config.FiveSecWarning);
	CheckButton_NotifyOtherWarlocksOnDeath:SetChecked(UberBanish_Config.NotifyLocksOnDeath);
	CheckButton_SpamRaidEarlyBreak:SetChecked(UberBanish_Config.SpamEarlyBreak);
	CheckButton_SpamRaidDeath:SetChecked(UberBanish_Config.SpamDeath);
	CheckButton_SayWhenSolo:SetChecked(UberBanish_Config.SayWhenSolo);
end


--[[
--
-- FUNCTION
-- 
-- Returns what the banish duration should be based on the current rank.
--]]
function UberBanish_GetBanishDuration()

	local result = BANISH_DURATION_RANK2;

	if (gCurrentBanishRank == 1) then
		result = BANISH_DURATION_RANK1;
	end

	return result;

end


--[[
--
-- FUNCTION
-- 
-- Currently unused.
--
--]]
--[[function UberBanish_OnDragStart()
	this:StartMoving()
end--]]


--[[
--
-- FUNCTION
-- 
-- Currently unused.
--
--]]
--[[function UberBanish_OnDragStop()
	this:StopMovingOrSizing()
end--]]
