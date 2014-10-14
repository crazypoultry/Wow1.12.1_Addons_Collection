--[[
  Guild Event Manager by Kiki of European Cho'gall (Alliance)
    Version 2.15
  Home Page : http://christophe.calmejane.free.fr/wow/gem/

  ---
  ChangeLog :
  ----------------
  - 2.152 :
   - October, 13th 2006 :
    - Fixed some other lua errors
    - Guild channel init fixed
  - 2.15 :
   - October, 10th 2006 :
    - Fixed some lua errors
    - Added an experimental feature to "pause" gem (/gem pause [on/off]). In pause mode, no messages will be sent (but they are queued) or received (channels are left)
  - 2.14 :
   - September, 26th 2006 :
    - Added esES localization (thx to carahuevo)
    - Attempting to detect joins/leaves in the guild channel (needed for events and subscriptions to be broadcasted)
   - September, 18th 2006 :
    - Fixed incorrect re-initialization of the 'guild' channel during next login
    - Greatly improved special 'guild' channel usage
    - Fixed issue with 'guild' channel, for multiple toons, in multiple guilds
    - Added possibility to remove a player from the Auto-Add members list
   - September, 11th 2006 :
    - Fixed events disapearing too soon (after scheduled date), even for the leader
  - 2.13 :
   - September, 1st 2006 :
    - Fixed possible lua error, if using new "GUILD" channel for some people, and not the other
  - 2.12 :
   - July, 28th 2006 :
    - Fixed GB instance reset times
   - July, 26th 2006 :
    - Added support for multi channels in Members list !
   - July, 21th 2006 :
    - Added support for GUILD channel (using the new 1.12 SendAddonMessage function). You must enter add a new channel named "guild" (localized !! so it's "guilde" in frFR) in GEM config
    - Fixed nil values in channel config
  - 2.11 :
   - July, 18th 2006 :
    - Moved default values to a new file : GEM_defaults.lua
    - Added possibility to diffuse the GEM_defaults.lua file to *force* banned people upgrades
   - July, 17th 2006 :
    - Added a new /gem command : "/gem scale <value>" -> Changes GEM windows scale value
    - Added a new /gem command : "/gem events" -> Prints all incoming events (with IDs)
    - Added a new /gem command : "/gem archive <EventID>" -> Archives a passed event
    - Added a new /gem command : "/gem delchar <CharName>" -> Removes one of your Characters from the dropdown list in subscribe and new event tabs
    - Added a new Date display in the New Event tab, showing current computer time (helps debug ppl with wrong clock setting)
    - Added a new option in config : "Only show events your current character's channels is on"
  - 2.10 :
   - July, 11th 2006 :
    - Fixed "Ignored events" commands (see "/gem help")
    - Added a new submenu when right clicking an event
    - Added possibility to Ban/Unban a player (all events from this player will be ignored automatically) (see "/gem help" to unban a player)
   - July, 10th 2006 :
    - No longer sending data (except if really needed) when being AFK. Should prevent most of the "AFK/UNAFK" flood
    - Fixed several lua errors
  - 2.09 :
   - June, 20th 2006 :
    - Updated TOC for 1.11
   - June, 19th 2006 :
    - Now passing *Event* struct to plugin *Sort* function
   - May, 31th 2006 :
    - Fixed grouped colors in subscribers view
   - May, 10th 2006 :
    - Added 2 new slash commands 'ignored' and 'unignore'. See '/gem help' for details
   - May, 2nd 2006 :
    - Fixed : Cannot set player's comment in option (not saved)
    - Fixed : "Slash" char automatically removed if set

  [ Previous changes in readme.txt file ]

  ---
  Description :
  ----------------
  This AddOn allows you to create/schedule/manage future raid instance directly in-game. Players can register (join) and reserve a room for your instance, or cancel subscription.
  You can setup a maximum players for your event, as well as the min/max per class.
  When a player wants to join and there is no room left for his class, he is put in a *substitute* queue, waiting for someone to cancel his subscription.
  
  The leader of an event does not have to be logged in for a player to subscribe.
  
  This addon has been designed to help guilds to schedule events, and its member to say *I'll be there*, and count the number of players that are ok for an instance.
  It does work for multiple guilds (kind of Alliance of guilds), if you want, or even with your friend list.
  
  All dates are stored in universal time, and displayed in local time, so if someone creates an event in a different timezone than yours, you will see the correct time on your side.
  
  
  ---
  Installation :
  ---------------
  
  1. Extract .zip file to WorldOfWarcraft\Interface\AddOns\
  2. load up WoW check the Addon is enabled ("/gem help" should print infos)
  3. Bind a key to GuildEventManager or type "/gem toggle"
  4. in the options TAB set the channel to whichever you are going to use
  
  
  ---
  Notes :
  --------
  
  COLOR CODE :
   - Events List in Events Tab, Where column :
     - White = Old event (already displayed)
     - Green = New event (never seen)
   - Events List in Events Tab, Leader column :
     - White = Leader not connected
     - Green = Leader connected
   - Events List in Events Tab, Subscribers column :
     - White = Not subscribed
     - Purple = Level of your selected character does not match event's level range
     - DarkGrey = Subscription sent, but not ACKed yet
     - Bleu = Subscription ACKed but you are in Substitute queue
     - Green = Subscription ACKed and you are in Titular list
     - Yellow = Subscription ACKed and you are in Replacement list
     - DarkRed = You have been kicked from event (and thus unsubscribed). You can re-subscribe
     - LightRed = You have been banned from event (and thus unsubscribed). You cannot re-subscribe until you are unbanned
   - Admin List in Events Tab, Place column :
     - White = Normal subscriber
     - Green = Leader or Assistant
   - Admin List in Events Tab, Name column :
     - White = Player not connected (or external)
     - Blue = Player connected but not grouped
     - Green = Player connected and grouped
   - Members list, Guild column :
     - Green = Guild leader
     - Blue = Guild officer
     - White = Guild member
  
  TODO :
   http://christophe.calmejane.free.fr/wow/phpBB2/viewtopic.php?p=3103#3103
    - Check when I receive an event update, if I'm in the list of the members, if I subscribed for it. If not, print a message, and remove my subscription
    - Option de config : Combien d'heures on garde un event passé
    - REVOIR le code de groupage (detection more raid/group), et virer le warning si je suis deja dans un grp
    - Faire une verif qd on set un alias, qu'il n'existe pas deja pour un autre canal GEM
    - Pouvoir changer de reroll dans un EditEvent
    - Store ServerTimeStamp and os.time() at each startup, for each Realm
    - WDS : Pour chaque event, envoyer os.time() et ServerTimeStamp
    - Add a sorting plugin : By assigning points to someone (DKP like)
    - Add a sorting plugin : By auto adding ppl on a list for the event (only when already created, by using AddExternal)
    - Find a way to *block* people we don't want to subscribe (auto ban your ignore list, for example)
    - Option to limit event creation to officers (not possible but see CanViewOfficerNote() IsGuildLeader() )
    - Handle event restrictions (guild only) -- Tag event with a bit 'guild only'
    - Possibility to modify the subscription comment
    - GEM_COM_JoinChannel() -> Change DEFAULT_CHAT_FRAME:GetID(), by a value specified in config
    - New parameter for Events : "Can subscribe only when leader is online"
    - Handle guild channel  as GEM channel
    - Add a new type of limit : Healers (priest/druid/paladin/shaman) Dps (rogue/mage/hunter) (v666.0)
  
  TODO GUI:
    - Possibility to remove offline members from the list (right clic on them)
    - Panel transparency
  
  KNOWN BUGS:
   - Impossible de rejoindre un canal si on reco a griffon (max count 100 reached)


CODE TODO :
*--*--*--*
 * To handle multiple channels :
   GUI
   -> GEM_Players.lua : GEMPlayers_GetPlayers() must handle multiple channels (and the GUI too)


  ---
  FAQ :
  --------
  Q : I don't see events of other people, and others don't see mine
  A : Are you sure you are on the same channel (check GEM options) ? Are you sure you don't have joined more than 9 channels (there is a limit of 9 or 10 channels you can join) ? Are you sure your PC's clock is correctly set ?
      If you still don't see events, try "/gem debug 1", it will show a new TAB, look at the debug log (screenshot it) for warnings or event related messages, then contact me.
  
  Q : I see garbage on my channels, like "<GEM-1>01..."
  A : Check if the channel you see garbage is the same than the one in your GEM config. Maybe you have changed the channel with a character, and changed reroll. Leave the garbaged one with a /leave ChanNum. In v2.0, channel will be saved per char, so you will not have this problem anymore.
  
  Q : I just subscribed to an event, but I don't appear in the list, nor the titulars count has changed.
  A : If the leader of the event is not logged, all commands (subscribe, unsubscribe, ...) are stored and broadcasted to every person in the channel (and each time someone logs in). In order to see your subscription in the list (and titulars count increased/decreased), you must wait until the leader logs. When he does, all commands are flushed and he processes them, in the order they were submitted.
      Look at the color codes above, they help you know in which state you are.
  
  Q : All thoses stored commands don't flood the channel when someone (or the leader) logs in ?
  A : No, there is an algorithm that makes people to sent commands at different time when someone joins, and if a known command has just been sent, the sent from your side is canceled. There is also a  maximum of commands that can be sent per second, so you are not (less) flooded.

  Q : I don't like the subscribers sorting modes available. I want something else, custom.
  A : Well, that's where the Sorting plugin system comes in ! Look at the "GEM_sort_stamp.lua" file, there is all you need to make your own plugin (there is no need for the plugin to be installed on each player's computer, only on the leader's one). Simply make a new addon with a .toc file, that depends on GuildEventManager, and you're done. The plugin will be loaded by GEM, and you'll be able to choose your custom sorting in GEM's "Create new Event" tab.
  
  Q : I have a lua error, but I cannot tell you the file/line it occured
  A : Please install (even temporarily) ImprovedErrorFrame (http://www.curse-gaming.com/mod.php?addid=170), and you'll be able to see the full error text

  Q : When I link an item to the GEM channel, it displays the name only.
  A : For links to be sent, you must use the SlashCmd specified in GEM config. If you speak using /# (# being GEM's channel number), it will not work.
  
  Q : I don't see anybody in the Members list, and the list populates very slowly. Also, I always see "N/A" for people's location.
  A : This is to greatly reduce traffic in the channel. Each player sends his personal informations ONLY when he changes of zone, NOT when someone logs in (otherwise every single player will have to send his current info upon each login, which causes too much traffic).
      Because of this, the first time you come to a channel, we don't see anybody, you must wait for each player to move to another zone. When this happens, the player is saved and stored in your variables, so the next time, only it's current location will show as 'N/A' until he moves.
  
  Q : I'm using SlashCmd and alias, and when I try to send a message, I don't see anything in my chatframe, nor I see messages from others.
  A : Some addons are not hooking chatframe like they should.
      - If you have GuildAds : Get the latest version, it has been fixed
      - If you have flagRSP : Get the latest version, it has been fixed
      - If you have Guilded : Why do you need this one anymore ? oO
      
  Q : I don't like the way Dates are displayed. How can I change that ?
  A : Change the option "Displayed dates format" ingame, in the GEM Configuration tab with the value you want.
      You can find help on the parameters here : http://www.opengroup.org/onlinepubs/007908799/xsh/strftime.html

  Q : I don't understand the 'time offset' option
  A : When someone creates an event, the time/date for the event is (by default, if you don't change the offset in GEM config) relative to it's computer's clock (which uses international time).
      Example :
       My computer's clock is set at GMT+1, I play on a server where time is set to GMT.
       I create an event for tonight 8pm, GEM will flag (create) the event for 8pm GMT+1 (and store it using universal time value), not 8pm GMT (so not the server time).
       BUT the date will be displayed for eveybody, using their local time. For someone playing on a computer with clock set at GMT+2, the event will show for him at 9pm.
       The offset value in GEM config, is for people who want events to be shown using server time (or any other time offset), not local time.
       They can set an offset from local time to match server time. If you don't set anything, it will display/create events based on your computer time (local).

  Q : When are events removed from the list ?
  A : Events are auto removed (not closed, removed completly from GEM) 1 hour after event's date for non-leader players, and 10 hours after event's date for leader.
      Using the previous example, the event will disapear for eveybody at 9pm GMT+1 (so for the guy playing at GMT+2 time, it will disapear when his computer's clock will reachs 10pm).

]]


--------------- Default values Moved to GEM_defaults.lua ---------------

--------------- Saved variables ---------------
GEM_Events = {};
GEM_Templates = {};
GEM_Players = {};

--------------- Shared variables ---------------
GEM_MAJOR = "2";
GEM_MINOR = "15";
GEM_VERSION = GEM_MAJOR.."."..GEM_MINOR;
GEM_PlayerName = nil;
GEM_Realm = nil;
GEM_DefaultSendChannel = nil;
GEM_NewMinorVersion = false;
GEM_OldVersion = false;
GEM_ConnectedPlayers = {};
GEM_YouAreDrunk = false;
GEM_ServerOffset = 666;
GEM_AFK_Mode = false;
GEM_PlayerGuild = nil;
GEM_GuildChannelName = nil;
GEM_Paused = false;

--------------- Local variables ---------------
local _GEM_NeedInit = true;
local _GEM_MaxJoinRetry = 10;
local _GEM_WrongChanNotified = {};

--------------- Internal functions ---------------

local function _GEM_Commands(command)
  local i,j, cmd, param = string.find(command, "^([^ ]+) (.+)$");
  if(not cmd) then cmd = command; end
  if(not cmd) then cmd = ""; end
  if(not param) then param = ""; end

  if((cmd == "") or (cmd == "help"))
  then
    GEM_ChatPrint(GEM_TEXT_USAGE);
    GEM_CMD_Help();
  else
    if(not GEM_CMD_Command(cmd,param))
    then
    GEM_ChatPrint(GEM_CHAT_CMD_UNKNOWN);
    end
  end
end

local function _GEM_CheckForJoined(channel)
  if(GEM_COM_Channels[channel].id ~= 0)
  then
    return;
  end
  -- Have we joined the channel ?
  GEM_COM_Channels[channel].id = GEM_GetChannelNameOrGuild(channel);
  
  if(GEM_COM_Channels[channel].id == 0)
  then
    if(GEM_COM_Channels[channel].retries > (_GEM_MaxJoinRetry/2))
    then
      GEM_ChatDebug(GEM_DEBUG_CHANNEL,"_GEM_CheckForJoined : Not in channel '"..channel.."' after "..GEM_COM_Channels[channel].retries.." retries, restarting sequence");
      GEM_InitChannels(false);
      -- Don't return, we need to reschedule
    elseif(GEM_COM_Channels[channel].retries > _GEM_MaxJoinRetry)
    then
      GEM_ChatDebug(GEM_DEBUG_CHANNEL,"_GEM_CheckForJoined : Not in channel '"..channel.."' after "..GEM_COM_Channels[channel].retries.." retries, aborting (channel password protected ?)");
      GEM_COM_Channels[channel].retries = 0;
      return;
    end
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"_GEM_CheckForJoined : Not joined yet, reschedule in 0.25 sec");
    GEM_COM_Channels[channel].retries = GEM_COM_Channels[channel].retries + 1;
    GEMSystem_Schedule(0.25,_GEM_CheckForJoined,channel); -- Re schedule in 250 msec
  else
    GEM_COM_Channels[channel].retries = 0;
    ListChannelByName(channel);
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"_GEM_CheckForJoined : Ok joined channel, time to bcast !");
    GEM_COM_AliasChannel(channel,GEM_COM_Channels[channel].alias,GEM_COM_Channels[channel].slash);
    if(GEM_COM_Channels[channel].already_bcast == nil)
    then
      GEM_QUE_BuildBroadcastQueues(channel,GEM_PlayerName);
      GEM_COM_PlayerInfosSingle(channel);
      GEM_COM_Channels[channel].already_bcast = 1;
    end
  end
end

local function GEM_LoadDefaults()
  local banned = GEM_Defaults_Banned[GEM_Realm];
  if(banned)
  then
    for name in banned
    do
      GEM_Events.realms[GEM_Realm].ignore_players[name] = true;
    end
  end
end

local function _GEM_CheckPlayerLeft(channel,pl_name)
  if(GEM_ConnectedPlayers[channel] == nil)
  then
    GEM_ConnectedPlayers[channel] = {};
  end
  if(GEM_ConnectedPlayers[channel][pl_name] ~= nil)
  then
    local chaninfos = GEM_COM_Channels[channel];
    if(chaninfos and chaninfos.notify)
    then
      local alias = channel;
      if(chaninfos.alias and chaninfos.alias ~= "")
      then
        alias = chaninfos.alias;
      end
      GEM_ChatMsg(alias.." : "..string.format(GEM_TEXT_PLAYER_LEFT,pl_name));
    end
    if(GEM_Players[GEM_Realm] and GEM_Players[GEM_Realm][channel] and GEM_Players[GEM_Realm][channel][pl_name])
    then
      GEM_Players[GEM_Realm][channel][pl_name].lastleave = time();
    end
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"_GEM_CheckPlayerLeft : Player "..pl_name.." left channel "..channel);
    GEM_ConnectedPlayers[channel][pl_name] = nil;
    GEMList_Notify(GEM_NOTIFY_MY_SUBSCRIPTION,"");
  end
end

local function _GEM_StartupInitVars()
  local playerName = UnitName("player");
  if((playerName) and (playerName ~= UNKNOWNOBJECT) and (playerName ~= UKNOWNBEING))
  then
    GEM_PlayerName = playerName;
    GEM_Realm = GetCVar("realmName");
    _GEM_NeedInit = false;
    if(GEM_Events.realms == nil) -- First time module init (ever)
    then
      GEM_Events = {}; -- Reset everything
      GEM_Events.next_event_id = 0;
      GEM_Events.realms = {};
      GEM_Events.MinimapRadiusOffset = 77;
      GEM_Events.MinimapArcOffset = 296;
      GEM_Events.MinimapTexture = "Spell_Nature_TimeStop";
      GEM_Events.DateFormat = GEM_DATE_FORMAT;
      --GEM_Events.debug = 1;
      GEM_Events.debug = nil;
    end
    GEM_Events.my_bcast_offset = 2 + math.mod(time(),85); -- Change value each login
    if(GEM_Events.realms[GEM_Realm] == nil) -- First time in this realm
    then
      GEM_Events.realms[GEM_Realm] = {};
      GEM_Events.realms[GEM_Realm].events = {};
      GEM_Events.realms[GEM_Realm].commands = {};
      GEM_Events.realms[GEM_Realm].subscribed = {};
      GEM_Events.realms[GEM_Realm].my_names = {};
      GEM_Events.realms[GEM_Realm].ChannelPassword = nil;
      GEM_Events.realms[GEM_Realm].kicked = {};
      GEM_Events.realms[GEM_Realm].banned = {};
      GEM_Events.realms[GEM_Realm].forward = {};
      GEM_Events.realms[GEM_Realm].ignore_players = {};
      GEM_Events.realms[GEM_Realm].archived = {};
    end
    if(GEM_Events.scale == nil) -- v2.11 addition
    then
      GEM_Events.scale = 1.0;
    end
    if(GEM_Events.realms[GEM_Realm].archived == nil) -- v2.11 addition
    then
      GEM_Events.realms[GEM_Realm].archived = {};
    end
    if(GEM_Events.realms[GEM_Realm].ignore_players == nil) -- v2.10 addition
    then
      GEM_Events.realms[GEM_Realm].ignore_players = {};
    end
    if(GEM_Events.realms[GEM_Realm].my_closed_events == nil) -- v2.02 addition
    then
      GEM_Events.realms[GEM_Realm].my_closed_events = {};
    end
    if(GEM_Events.realms[GEM_Realm].ignore == nil) -- v2.01 addition
    then
      GEM_Events.realms[GEM_Realm].ignore = {};
      GEM_Events.realms[GEM_Realm].assistant = {};
    end
    if(GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName] == nil) -- First time with this toon in this realm
    then
      GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName] = {};
      local _,class = UnitClass("player");
      GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].class = class;
    end
    local playerGuild = GetGuildInfo("player"); -- Thanks to blizz 1.7 changes, this might not been initialized here
    GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].level = UnitLevel("player");
    GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].guild = playerGuild;
    GEMOptions_LoadChannelsConfig(GEM_PlayerName); -- Load channels config
    GEM_InitChannels(true); -- And init channels
    GEM_LoadDefaults();
    GEM_COM_InitRoutines();
    GEMMinimapButton_Update();
    GEM_DBG_SetDebugMode(GEM_Events.debug,false);
    GEMMainFrame:SetScale(GEM_Events.scale);
    GEMCalendarFrame:SetScale(GEM_Events.scale);
    GEMExternalFrame:SetScale(GEM_Events.scale);
    GEMListBannedFrame:SetScale(GEM_Events.scale);
    GEMNewAutoMembersFrame:SetScale(GEM_Events.scale);
  end
end


--------------- From XML functions ---------------

function GEM_OnEvent()
  if(event == "VARIABLES_LOADED")
  then
    if(_GEM_NeedInit)
    then
      _GEM_StartupInitVars();
    end
    return;
  end

  local channel = nil;
  if(arg9)
  then
    channel = strlower(arg9);
  end

  -- Check events
  if(event == "CHAT_MSG_CHANNEL" and channel and GEM_Realm)
  then
    if(GEM_IsChannelInList(channel)) -- Channel joined, process
    then
      if(strsub(arg1, strlen(arg1)-7) == " ...hic!") then
        arg1 = strsub(arg1, 1, strlen(arg1)-8);
      end
      if(string.find(arg1,"^<GEM")) -- Process only GEM messages
      then
        GEM_COM_ParseChannelMessage(channel,arg2,arg1);
      elseif(UnitName("player") ~= arg2 and GEMOptions_MustBip(arg1))
      then
        GEM_ChatDebug(GEM_DEBUG_CHANNEL,"Found your name in the channel, COIN !");
        PlaySoundFile("Interface\\AddOns\\GuildEventManager2\\coin.wav");
      end
    --[[else
      if(string.find(arg1,"^<GEM")) -- Got a GEM message on another channel ?
      then
        if(_GEM_WrongChanNotified[channel] == nil)
        then
          GEM_ChatPrint("Warning : Found a GEM command From "..tostring(arg2).." on Channel '"..channel.."' but it is not the channel set in GEM configuration. You can leave this chan, but if you have this message by mistake, please inform Kiki");
          _GEM_WrongChanNotified[channel] = 1;
        end
      end]]
    end
  elseif(event == "CHAT_MSG_ADDON" and arg3 == "GUILD" and arg1 == GEM_ADDON_PREFIX and not GEM_Paused)
  then
    GEM_COM_ParseChannelMessage(GEM_GuildChannelName,arg4,arg2);
  elseif(event == "GUILD_ROSTER_UPDATE")
  then
    GEM_CheckGuildMembers();
  elseif(event == "CHAT_MSG_CHANNEL_NOTICE" and channel and GEM_Realm)
  then
    if(arg1 and GEM_COM_Channels and GEM_COM_Channels[channel])
    then
      if(arg1 == "YOU_LEFT" and GEM_COM_Channels[channel].id ~= 0)
      then
        GEM_COM_Channels[channel].id = 0;
        GEM_ChatDebug(GEM_DEBUG_CHANNEL,"Leaving by hand "..channel);
      elseif(arg1 == "YOU_JOINED" and GEM_COM_Channels[channel].id == 0 and not GEM_COM_Channels[channel].already_bcast)
      then
        GEM_ChatDebug(GEM_DEBUG_CHANNEL,"Re-joining by hand "..channel);
        _GEM_CheckForJoined(channel);
      elseif(arg1 == "WRONG_PASSWORD")
      then
        if(GEM_COM_Channels[channel].password and GEM_COM_Channels[channel].password ~= "") -- Had a password
        then
          if(GEM_COM_Channels[channel].retries and GEM_COM_Channels[channel].retries > 2) -- More than 2 retries, try without a password
          then
            GEM_ChatPrint("You set a password ("..GEM_COM_Channels[channel].password..") for channel '"..channel.."' but it is not correct, retrying without password...");
            GEM_ChatDebug(GEM_DEBUG_CHANNEL,"You set a password ("..GEM_COM_Channels[channel].password..") for channel '"..channel.."' but it is not correct, retrying without password...");
            GEM_COM_Channels[channel].password = "";
            GEMSystem_Schedule(1,GEM_InitChannels,false); -- Schedule retry in 1sec
          end
        else -- No password -> Print error
          GEM_COM_Channels[channel].retries = _GEM_MaxJoinRetry + 1;
          GEM_ChatPrint("Incorrect password for channel '"..channel.."'");
        end
      end
    end
  elseif(event == "UNIT_NAME_UPDATE")
  then
    if((arg1) and (arg1 == "player"))
    then
      GEM_CheckPlayerGuild();
    end
  elseif(event == "CHAT_MSG_CHANNEL_JOIN" and channel)
  then
    if(GEM_IsChannelInList(channel))
    then
      GEM_CheckPlayerJoined(channel,arg2,true);
      GEM_QUE_BuildBroadcastQueues(channel,arg2);
    end
  elseif(event == "CHAT_MSG_CHANNEL_LEAVE" and channel)
  then
    if(GEM_IsChannelInList(channel))
    then
      _GEM_CheckPlayerLeft(channel,arg2);
    end
  elseif(event == "CHAT_MSG_CHANNEL_LIST" and channel)
  then
    if(GEM_IsChannelJoined(channel))
    then
      local users = {};
        for value in string.gfind(arg1,"[^,]+") do
        table.insert(users, value);
      end
      for k,v in users do 
        k2 = string.gsub(v, "%s*%@*%**([^%s]+)", "%1");
        GEM_CheckPlayerJoined(channel,k2,false);
      end
      local count = 0;
      for n in GEM_ConnectedPlayers[channel]
      do
        count = count + 1;
        if(count >=2) then break; end
      end
      if(count == 1 and GEM_COM_Channels[channel].password and GEM_COM_Channels[channel].password ~= "") -- I'm alone, and there is a password for this channel
      then
        SetChannelPassword(channel,GEM_COM_Channels[channel].password);
        GEM_ChatDebug(GEM_DEBUG_CHANNEL,"I'm alone in channel '"..channel.."' and I must set a password... setting it to "..GEM_COM_Channels[channel].password);
      end
    end
  elseif(event == "PARTY_MEMBERS_CHANGED")
  then
    if(GetNumPartyMembers() == 0)
    then
      GEMList_CurrentGroupIDMustReset = true;
    else
      GEMList_CurrentGroupIDMustReset = false;
    end
    if(GEMList_CurrentGroupID ~= nil and GEMList_CurrentGroupIDMustReset ~= true)
    then
      if(GEMList_MustConvertToRaid == true)
      then
        ConvertToRaid();
        GEMList_CurrentGroupIsRaid = true;
        GEM_ChatDebug(GEM_DEBUG_GLOBAL,"Converted to raid !");
        GEMList_MustConvertToRaid = false;
      end
      if(GEMList_CurrentGroupIsRaid == false and GEM_Events.realms[GEM_Realm].events[GEMList_CurrentGroupID] and GEM_Events.realms[GEM_Realm].events[GEMList_CurrentGroupID].max_count > 5) -- A raid
      then
        GEMList_MustConvertToRaid = true;
        GEM_ChatDebug(GEM_DEBUG_GLOBAL,"Must convert to raid !");
      end
    end
  elseif(event == "ZONE_CHANGED_NEW_AREA")
  then
    GEM_COM_PlayerInfos(); -- Send an update of my infos
    GEM_NotifyGUI(GEM_NOTIFY_PLAYER_INFOS);

    -- Check channel IDs
    for name,chantab in GEM_COM_Channels
    do
      local id = GEM_GetChannelNameOrGuild(name);
      if(GEM_COM_Channels[name].id ~= 0 and GEM_COM_Channels[name].id ~= id) -- If channel ID has changed
      then
        --GEM_ChatWarning("ZONE_CHANGED_NEW_AREA : ChannelID for '"..name.."' has changed from "..GEM_COM_Channels[name].id.." to "..id);
        GEM_COM_Channels[name].id = id;
      end
    end
  elseif(event == "CHAT_MSG_SYSTEM")
  then
    if(arg1 == MARKED_AFK or string.find(arg1,string.format(MARKED_AFK_MESSAGE,".*")))
    then
      GEM_AFK_Mode = true;
      return;
    end
    --GEM_CheckPlayerJoined(channel,pl_name,mustprint)
    if(arg1 == CLEARED_AFK)
    then
      GEM_AFK_Mode = false;
      return;
    end
    for i=1,GEM_DRUNK_MESSAGES_COUNT
    do
      if(arg1 == GEM_DRUNK_MESSAGES[i])
      then
        GEM_YouAreDrunk = true;
        break;
      end
    end
    if(arg1 == GEM_DRUNK_NORMAL)
    then
      GEM_YouAreDrunk = false;
    end
  end
end

function GEM_OnLoad()
  -- Print init message
  GEM_ChatPrint("Version "..GEM_VERSION.." "..GEM_CHAT_MISC_LOADED);

  -- Register events
  this:RegisterEvent("VARIABLES_LOADED");
  this:RegisterEvent("ADDON_LOADED");
  this:RegisterEvent("CHAT_MSG_CHANNEL");
  this:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
  this:RegisterEvent("CHAT_MSG_CHANNEL_JOIN");
  this:RegisterEvent("CHAT_MSG_CHANNEL_LEAVE");
  this:RegisterEvent("CHAT_MSG_CHANNEL_LIST");
  this:RegisterEvent("CHAT_MSG_SYSTEM");
  this:RegisterEvent("UNIT_NAME_UPDATE");
  this:RegisterEvent("PARTY_MEMBERS_CHANGED");
  this:RegisterEvent("ZONE_CHANGED_NEW_AREA");

  -- Initialize Slash commands
  SLASH_GEM1 = "/gem";
  SlashCmdList["GEM"] = function(msg)
    _GEM_Commands(msg);
  end
  
  tinsert(UISpecialFrames, "GEMMainFrame");
  tinsert(UISpecialFrames, "GEMCalendarFrame");
  tinsert(UISpecialFrames, "GEMExternalFrame");
  tinsert(UISpecialFrames, "GEMListBannedFrame");
  tinsert(UISpecialFrames, "GEMNewAutoMembersFrame");
end

--------------- Exported functions ---------------

function GEM_ComputeServerOffset()
  if(GEM_Events.realms[GEM_Realm] and GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName] and GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].ForceHourOffset)
  then
    GEM_ServerOffset = GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].ForceHourOffset;
    return;
  end
  if(GEM_ServerOffset == 666)
  then
    local hour = GetGameTime();
    if(hour == nil or tonumber(hour) == -1)
    then
      return;
    end
    local today = date("*t");
    local offset = hour - today.hour;
  
    if(math.abs(offset) > 12)
    then
      if(offset > 0)
      then
        offset = offset - 24; 
      else
        offset = offset + 24; 
      end
    end
    GEM_ServerOffset = offset;
  end
end

function GEM_ComputeHourOffset()
  if(GEM_ServerOffset == 666)
  then
    GEM_ComputeServerOffset();
  end
  if(GEM_Events == nil or GEM_Events.realms == nil or GEM_Events.realms[GEM_Realm] == nil or GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].UseServerTime ~= 1 or GEM_ServerOffset == 666)
  then
    return 0;
  end
  return GEM_ServerOffset * 60 * 60;
end

-- Checks if 'name' is one of my rerolls
function GEM_IsMyReroll(name)
  if(GEM_Events.realms[GEM_Realm].my_names[name] ~= nil)
  then
    return true;
  end
  return false;
end

function GEM_IsChannelInList(channel)
  if(GEM_COM_Channels and GEM_COM_Channels[channel])
  then
    --[[if(GEM_COM_Channels[channel].id == 0)
    then
      if(GEM_COM_Channels[channel].already_bcast) -- Channel is in my list, but was left by hand !
      then
        return true;
      end
      GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_IsChannelInList : ChannelID for '"..tostring(channel).."' not found, calling InitChannels(false)");
      GEM_InitChannels(false);
    end
    return GEM_COM_Channels[channel].id ~= 0;]]
    return true;
  end
  return false;
end

function GEM_IsChannelInRerollList(pl_name,channel)
  if(GEM_Events.realms[GEM_Realm].my_names[pl_name] and GEM_Events.realms[GEM_Realm].my_names[pl_name].channels)
  then
    for i,chantab in GEM_Events.realms[GEM_Realm].my_names[pl_name].channels
    do
      if(chantab.name and strlower(chantab.name) == channel)
      then
        return true;
      end
    end
  end
  return false;
end

function GEM_IsChannelJoined(channel)
  if(GEM_COM_Channels and GEM_COM_Channels[channel] and GEM_COM_Channels[channel].id ~= 0)
  then
    return true;
  end
  return false;
end

function GEM_CheckEventHasChannel(event)
  if(event and event.channel == nil) -- Never set, set it now
  then
    event.channel = GEM_DefaultSendChannel;
  end
end

function GEM_CheckCommandHasChannel(cmdstab)
  if(cmdstab.channel == nil) -- Never set, set it now
  then
    cmdstab.channel = GEM_DefaultSendChannel;
  end
end

function GEM_CheckPlayerJoined(channel,pl_name,mustprint)
  if(channel == nil) then return; end
  if(GEM_ConnectedPlayers[channel] == nil)
  then
    GEM_ConnectedPlayers[channel] = {};
  end
  if(GEM_ConnectedPlayers[channel][pl_name] == nil)
  then
    local chaninfos = GEM_COM_Channels[channel];
    if(mustprint and chaninfos and chaninfos.notify)
    then
      local alias = channel;
      if(chaninfos.alias and chaninfos.alias ~= "")
      then
        alias = chaninfos.alias;
      end
      GEM_ChatMsg(alias.." : "..string.format(GEM_TEXT_PLAYER_JOINED,pl_name));
    end
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_CheckPlayerJoined : Player "..pl_name.." joined "..channel);
    if(GEM_Players[GEM_Realm] and GEM_Players[GEM_Realm][channel] and GEM_Players[GEM_Realm][channel][pl_name])
    then
      GEM_Players[GEM_Realm][channel][pl_name].location = GEM_NA_FORMAT; -- Reset location
    end
    GEM_ConnectedPlayers[channel][pl_name] = 1;
    GEM_COM_LastJoinerTime = time();
    GEMList_Notify(GEM_NOTIFY_MY_SUBSCRIPTION,"");
  end
end

function GEM_CheckGuildMembers()
  if(GEM_GuildChannelName == nil)
  then
    return;
  end

  GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_CheckGuildMembers : Checking for Join/Leave in the Guild channel : "..tostring(GEM_GuildChannelName));

  local count = GetNumGuildMembers(true);
  local new_connected = {};
  local to_remove = {};

  for i=1,count
  do
    local name, _, _, _, _, _, _, _, online = GetGuildRosterInfo(i);
    if(name and online)
    then
      new_connected[name] = true;
    end
  end
  
  -- Check for disconnected players
  for n,tab in GEM_ConnectedPlayers[GEM_GuildChannelName]
  do
    if(new_connected[n] == nil) -- No longer connected
    then
      to_remove[n] = true;
    end
  end
  
  -- Remove them
  for n in to_remove
  do
    _GEM_CheckPlayerLeft(GEM_GuildChannelName,n);
  end

  for n,tab in new_connected -- Check for new connected
  do
    if(GEM_ConnectedPlayers[GEM_GuildChannelName][n] == nil) -- Was not connected
    then
      GEM_CheckPlayerJoined(GEM_GuildChannelName,n);
      GEM_QUE_BuildBroadcastQueues(GEM_GuildChannelName,n);
    end
  end
end

function GEM_IsPlayerConnected(channel,pl_name)
  if(GEM_ConnectedPlayers[channel] and GEM_ConnectedPlayers[channel][pl_name] ~= nil)
  then
    return true;
  end
  return false;
end

function GEM_CheckPlayerGuild()
  if(GEM_Realm == nil)
  then
    GEM_ChatWarning("GEM_CheckPlayerGuild : GEM_Realm is nil. Aborting");
    return;
  end

  local playerName = UnitName("player");
  if((playerName) and (playerName ~= UNKNOWNOBJECT) and (playerName ~= UKNOWNBEING))
  then
    GEM_PlayerGuild = GetGuildInfo("player");
    if(GEM_PlayerGuild)
    then
      GEM_GuildChannelName = strlower(GUILD).."-"..strlower(GEM_PlayerGuild);
    end
    GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].level = UnitLevel("player");
    GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].guild = GEM_PlayerGuild;
    local _,class = UnitClass("player");
    GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].class = class;
    GEM_ChatDebug(GEM_DEBUG_GLOBAL,"GEM_CheckPlayerGuild : Player "..playerName.." level "..GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].level.." from guild "..tostring(GEM_Events.realms[GEM_Realm].my_names[GEM_PlayerName].guild));
  end
end

function GEM_GetChannelNameOrGuild(channel)
  if(channel == GEM_GuildChannelName)
  then
    return -1;
  end
  return GetChannelName(channel);
end

local _GEM_CheckGuildMembersScheduled = false;
local function _GEM_CheckGuildMembers()
  if(not GEM_Paused)
  then
    if(GEM_GuildChannelName)
    then
      GuildRoster(); -- Request a Guild members update
    end
  end
  GEMSystem_Schedule(30,_GEM_CheckGuildMembers); -- Reschedule in 30 sec
end

local _GEM_ScheduledChannelsInitDone = false;
local _GEM_InitChannelsCount = 0;
function GEM_InitChannels(schedule)
  if(GEM_Paused)
  then
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_InitChannels : GEM is paused, doing nothing");
    return;
  end
  GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_InitChannels : Starting channel Initialization (reschedule="..tostring(schedule).." count=".._GEM_InitChannelsCount..")");
  _GEM_InitChannelsCount = _GEM_InitChannelsCount + 1;
  
  if(_GEM_InitChannelsCount == 1000)
  then
    GEM_ChatWarning("GEM_InitChannels : _GEM_InitChannelsCount reached 1000, you might be in flight");
  end

  if(schedule and _GEM_ScheduledChannelsInitDone)
  then
    GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_InitChannels : Returning, schedule="..tostring(schedule).." and _GEM_ScheduledChannelsInitDone="..tostring(_GEM_ScheduledChannelsInitDone));
    return;
  end

  -- Check for general channels
  local firstChannelNumber = GetChannelList();
  if(firstChannelNumber == nil)
  then
    if(schedule)
    then
      GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_InitChannels : Main channels not init yet, reschedule init in 2 sec");
      GEMSystem_Schedule(2,GEM_InitChannels,schedule); -- Re schedule in 2 sec
    else
      GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_InitChannels : Main channels not init yet, but not rescheduling.");
    end
    return;
  end

  GEM_CheckPlayerGuild(); -- Check for player's guild, if not ok yet
  _GEM_InitChannelsCount = 0;
  GEM_EVT_CheckExpiredEvents();
  GEM_CMD_CheckExpiredCommands();

  -- Join our channels
  for name,chantab in GEM_COM_Channels
  do
    GEMPlayers_CheckExpiredPlayers(name);
    if(chantab.id == 0) -- If this channel is not init
    then
      if(chantab.guild)
      then
        GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_InitChannels : Fake join of GUILD channel ("..GEM_GuildChannelName..")");
        GEM_ConnectedPlayers[name] = {}; -- Reset players for the guild channel
        GEM_CheckPlayerJoined(name,GEM_PlayerName,false); -- Set myself as joined !
        if(not _GEM_CheckGuildMembersScheduled)
        then
          GEMSystem_Schedule(30,_GEM_CheckGuildMembers); -- Schedule in 30 sec
          _GEM_CheckGuildMembersScheduled = true;
        end
      else
        GEM_COM_JoinChannel(name,chantab.password);
      end
      -- Wait for our channel joined
      GEM_ChatDebug(GEM_DEBUG_CHANNEL,"GEM_InitChannels : Join request sent for channel "..name..", prepare _GEM_CheckForJoined schedule ? : "..tostring(chantab.retries));
      if(chantab.retries == 0) -- Not already in a schedule check
      then
        GEMSystem_Schedule(3,_GEM_CheckForJoined,name); -- Schedule in 3 sec
      end
    end
  end
  if(schedule)
  then
    _GEM_ScheduledChannelsInitDone = true;
  end
end

