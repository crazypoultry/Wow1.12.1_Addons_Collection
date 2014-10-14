--Copyright 2006 Ryan Hamshire
--This document may be redistributed as a whole, provided it is unaltered and this copyright notice is not removed.

--Thanks to Belgor for localization code and German translation
--Thanks to Antonio Farinetti for the solution to merging friend lists

--================

--GLOBAL VARIABLES

--================

SGP_ignoreList = {}
SGP_characterList = {}
SGP_friendList = {}
SGP_chatData = {}
SGP_ignoreSessionList = {}

SGP_blockUnIgnore = 0
SGP_blockIgnore = 0

SGP_blockFriend = 0
SGP_blockUnFriend = 0

SGP_realmName = nil

SGP_synchronized = false
SGP_variablesLoaded = false
SGP_friendsLoaded = false

SGP_rosterClock = 0

--========================

--INTERFACE EVENT HANDLERS

--========================

function SGP_OnLoad()

  --register for events
  this:RegisterEvent('VARIABLES_LOADED')

  this:RegisterEvent('CHAT_MSG_CHANNEL')
  this:RegisterEvent('CHAT_MSG_EMOTE')
  this:RegisterEvent('CHAT_MSG_SAY')
  this:RegisterEvent('CHAT_MSG_TEXT_EMOTE')
  this:RegisterEvent('CHAT_MSG_YELL')
  this:RegisterEvent('CHAT_MSG_WHISPER')
  this:RegisterEvent('ZONE_CHANGED_NEW_AREA')
  this:RegisterEvent('FRIENDLIST_UPDATE')

  --hook some functions
  SGP_wowChatFrameOnEvent = ChatFrame_OnEvent
  SGP_wowIgnore = AddIgnore
  SGP_wowUnIgnore = DelIgnore
  SGP_wowToggleIgnore = AddOrDelIgnore

  ChatFrame_OnEvent = SGP_chatFrameOnEvent
  AddIgnore = SGP_ignore
  DelIgnore = SGP_unIgnore
  AddOrDelIgnore = SGP_toggleIgnore

  --register slash command
  SlashCmdList["SGPtempIgnore"] = SGP_tempIgnoreHandler
  SLASH_SGPtempIgnore1 = SGP_LOCALIZED_TEMPSLASH

end

function SGP_OnEvent()

  if event == 'CHAT_MSG_CHANNEL' then 

    SGP_chatChannelHandler()

  elseif event == 'CHAT_MSG_EMOTE' or event == 'CHAT_MSG_SAY' or event == 'CHAT_MSG_TEXT_EMOTE' or event == 'CHAT_MSG_WHISPER' or event == 'CHAT_MSG_YELL' then
  
    SGP_chatHandler()
  
  elseif event == 'VARIABLES_LOADED' then

    SGP_variablesHandler()

  elseif event == 'ZONE_CHANGED_NEW_AREA' then
  
    SGP_zoneHandler()
  
  elseif event == 'FRIENDLIST_UPDATE' then
  
    SGP_friendUpdateHandler()
    
  end

end

function SGP_OnUpdate()

  SGP_rosterClock = SGP_rosterClock + arg1
  if SGP_rosterClock > 500 and IsInGuild() then
	  SGP_rosterClock = 0
	  --request updated guild roster
	  GuildRoster()
  end
  
  if SGP_synchronized then return end

  if SGP_variablesLoaded and SGP_friendsLoaded then

    --request guild roster update
	if IsInGuild() then GuildRoster() end
	
    --get the server name
	SGP_realmName = GetRealmName()

    --if first time on this realm, do some initialization
    if not SGP_ignoreList[SGP_realmName] then 
    	SGP_ignoreList[SGP_realmName] = {}
		SGP_friendList[SGP_realmName] = {}
    	SGP_characterList[SGP_realmName] = {}
    end
	
	--for backward compatibility
	if not SGP_characterList[SGP_realmName] then
		SGP_characterList[SGP_realmName] = {}
	end

	--if first time on this character
	if not SGP_characterList[SGP_realmName][UnitName("PLAYER")] then
	  
		SGP_characterList[SGP_realmName][UnitName("PLAYER")] = true;
    
	    --add this character's friends to SGP's friends list
	  	local i = 1
      	local max = GetNumFriends()
      	while i <= max do
           	if table.getn(SGP_friendList[SGP_realmName]) < 50 then
    			local name = GetFriendInfo(i)
        		SGP_friendList[SGP_realmName][string.lower(name)] = true
        	end
        	i = i + 1
		end
		
		--add this character's ignore list to SGP's permanent ignore list
		i = 1
		max = GetNumIgnores()
		while i <= max do
			local name = GetIgnoreName(i)
			SGP_ignoreList[SGP_realmName][string.lower(name)] = true
			i = i + 1
		end
		
	end

	--update this character's ignore and friend lists
    local i = GetNumIgnores()
    while i > 0 do
	    --remove from game list anyone not on our ignore list
       	if not SGP_ignoreList[SGP_realmName][string.lower(GetIgnoreName(i))] then
       		SGP_blockUnIgnore = SGP_blockUnIgnore + 1
       		SGP_wowUnIgnore(GetIgnoreName(i))
       	end
       	i = i - 1
    end

   	--clear in game friends list
   	local i = GetNumFriends()
   	while i > 0 do
       	SGP_blockUnFriend = SGP_blockUnFriend + 1
       	RemoveFriend(i)
       	i = i - 1
   	end
      	
    --fill it in with SGP's friends list
   	for playerName in SGP_friendList[SGP_realmName] do
       	SGP_blockFriend = SGP_blockFriend + 1
       	AddFriend(playerName)
   	end
      	
    --leave some room for auto-ignore
    if GetNumIgnores() == 25 then
        SGP_blockUnIgnore = SGP_blockUnIgnore + 2
        SGP_wowUnIgnore(GetIgnoreName(2))
        SGP_wowUnIgnore(GetIgnoreName(1))
    elseif GetNumIgnores() == 24 then
        SGP_blockUnIgnore = SGP_blockUnIgnore + 1
        SGP_wowUnIgnore(GetIgnoreName(1))
    end

    --add ignore and temporary ignore to drop-down
    UnitPopupButtons["Ignore"] = {}
    UnitPopupButtons["Ignore"].text = SGP_LOCALIZED_IGNORE
    UnitPopupButtons["Ignore"].dist = 0
    table.insert(UnitPopupMenus["FRIEND"], table.getn(UnitPopupMenus["FRIEND"]), "Ignore")

    UnitPopupButtons["tempIgnore"] = {}
    UnitPopupButtons["tempIgnore"].text = SGP_LOCALIZED_SESSION
    UnitPopupButtons["tempIgnore"].dist = 0
    table.insert(UnitPopupMenus["FRIEND"], table.getn(UnitPopupMenus["FRIEND"]), "tempIgnore")

    SGP_wowHideButtons = UnitPopup_HideButtons
    UnitPopup_HideButtons = SGP_hideButtons

    SGP_wowUnitPopupOnClick = UnitPopup_OnClick
    UnitPopup_OnClick = SGP_unitPopupOnClick

	SGP_synchronized = true

  end

end

--==================

--WOW EVENT HANDLERS

--==================

function SGP_variablesHandler()

  SGP_variablesLoaded = true
  ShowFriends()

end

function SGP_friendUpdateHandler()

	SGP_friendsLoaded = true
	this:UnregisterEvent('FRIENDLIST_UPDATE')
	
end

function SGP_chatChannelHandler()

  if string.find(arg9, SGP_CHANNEL_LFG) or string.find(arg9, SGP_CHANNEL_GENERAL) or string.find(arg9, SGP_CHANNEL_TRADE) then
    SGP_chatHandler()
  end

end

function SGP_chatHandler()

  if not SGP_synchronized then return end

  --if this chatter is on our ignore list, make sure he/she is on the in-game list
  if arg2 and SGP_ignoreList[SGP_realmName][string.lower(arg2)] and not SGP_ignoreSessionList[string.lower(arg2)] then
    SGP_blockIgnore = SGP_blockIgnore + 1
    SGP_ignore(arg2, true)
  
  --otherwise, execute anti-spam policy
  elseif arg1 and arg2 then

    --if first chat from this person
    if not SGP_chatData[arg2] then
      SGP_chatData[arg2] = {}
	  SGP_chatData[arg2].lastMessage = arg1
      SGP_chatData[arg2].lastIndex = 1
      SGP_chatData[arg2][1] = GetTime()
      SGP_chatData[arg2].repeats = 0

    --otherwise check for spam
    else

      local ignore = false
      local nextIndex = SGP_chatData[arg2].lastIndex + 1
      if nextIndex > 2 then nextIndex = 1 end

      --criteria for copy/paste spam
      if arg1 == SGP_chatData[arg2].lastMessage and GetTime() - SGP_chatData[arg2][SGP_chatData[arg2].lastIndex] < 30 then
		SGP_chatData[arg2].repeats = SGP_chatData[arg2].repeats + 1
		if SGP_chatData[arg2].repeats == 2 then ignore = true end
	  elseif arg1 ~= SGP_chatData[arg2].lastMessage then
	    SGP_chatData[arg2].repeats = 0
	  end

      --check for macro spam (doesn't apply to tells, to avoid conflict with other addons)
      if SGP_chatData[arg2][nextIndex] and GetTime() - SGP_chatData[arg2][nextIndex] < 2 and event ~= 'CHAT_MSG_WHISPER' then
        ignore = true
      end

      --record this message and its timestamp for later
      SGP_chatData[arg2].lastMessage = arg1
      SGP_chatData[arg2][nextIndex] = GetTime()
      SGP_chatData[arg2].lastIndex = nextIndex

	  --if necessary, ignore.  (but not friends or guildmates or group members!)
      if ignore and not SGP_friendList[SGP_realmName][string.lower(arg2)] then

	    --if player is in a guild, look for spammer in the guild roster
	    local chatterInGuild = false
		if IsInGuild() then
          local i = 1
      	  local name = GetGuildRosterInfo(i)
      	  while name and name ~= arg2 do
      	    i = i + 1
      	    name = GetGuildRosterInfo(i)
      	  end
      	
      	  if name then chatterInGuild = true end
        end

		--if player is in party or raid, check for spammer in party and raid
		local chatterInGroup = false
		
		--check group
		if(GetNumPartyMembers() > 0) then
		  local j = 1
		  for j = 1, 4 do
		  	if UnitName('party' .. j) and UnitName('party' .. j) == arg2 then chatterInGroup = true end
		  end
		end
		
		--check raid
		if(GetNumRaidMembers() > 0) then
		  local j = 1
		  for j = 1, 39 do
			if UnitName('raid' .. j) and UnitName('raid' .. j) == arg2 then chatterInGroup = true end
		  end
		end

        if not chatterInGuild and not chatterInGroup then SGP_ignore(arg2, false) end
      end
    end
  end
end

function SGP_tempIgnoreHandler(arg1)

	if arg1 then SGP_ignore(arg1, false) end

end

function SGP_zoneHandler()

  SGP_chatData = {}
  
end

--=============================================

--MODIFIED WOW FUNCTIONS USED AS EVENT HANDLERS

--=============================================

function SGP_chatFrameOnEvent(event, ...)

  --sometimes block chat messages
  if SGP_synchronized and arg2 and SGP_ignoreList[SGP_realmName][string.lower(arg2)] then
    return

  --sometimes respond to system messages
  elseif SGP_realmName and event == 'CHAT_MSG_SYSTEM' then

    --watch for added friends
    local start1, stop1, name = string.find(arg1, '(%a*) ' .. SGP_FRIENDS_ADDED)
    local start2, stop2 = string.find(arg1, SGP_FRIENDS_ALREADY)
    local start3, stop3 = string.find(arg1, SGP_FRIENDS_NOROOM)
    local start4, stop4, name2 = string.find(arg1, '(%a*) ' .. SGP_FRIENDS_REMOVED)
    local start5, stop5 = string.find(arg1, SGP_FRIENDS_PARTOF)
    local start6, stop6 = string.find(arg1, SGP_FRIENDS_NOTFOUND)
    local start7, stop7 = string.find(arg1, SGP_FRIENDS_YOURSELF)

    --note added friend
    if name and SGP_blockFriend == 0 then
      SGP_friendList[SGP_realmName][string.lower(name)] = true
   
    --or note removed friend
    elseif name2 and SGP_blockUnFriend == 0 then
      local newTable = {}
      for a in SGP_friendList[SGP_realmName] do
        if a ~= string.lower(name2) then newTable[a] = true end
      end
      SGP_friendList[SGP_realmName] = newTable

    --or just block friend system message
    elseif SGP_blockFriend > 0 and (start1 or start2 or start3 or start5 or start6 or start7) then
      SGP_blockFriend = SGP_blockFriend - 1
      return
    
    --or just block un-friend system message
    elseif SGP_blockUnFriend > 0 and start4 then
      SGP_blockUnFriend = SGP_blockUnFriend - 1
      return

    end

    --sometimes block unignore messages for transparency
    if SGP_blockUnIgnore > 0 then

      local start1, stop1, start2, stop2
      start1, stop1 = string.find(arg1, SGP_IGNORE_NOLONGER)
      start2, stop2 = string.find(arg1, SGP_IGNORE_NOTFOUND)

      if start1 or start2 then 
        SGP_blockUnIgnore = SGP_blockUnIgnore - 1
        return 
      end

    --sometimes block ignore messages for transparency
    elseif SGP_blockIgnore > 0 then

      local start1, stop1, start2, stop2, start3, stop3, start4, stop4
      start1, stop1 = string.find(arg1, SGP_IGNORE_NOWIGNORE)
      start2, stop2 = string.find(arg1, SGP_IGNORE_NOTFOUND)
      start3, stop3 = string.find(arg1, SGP_IGNORE_ALREADY)
      start4, stop4 = string.find(arg1, SGP_IGNORE_ANYMORE)

      if start1 or start2 or start3 or start4 then 
        SGP_blockIgnore = SGP_blockIgnore - 1
        return 
      end

    end
  end

  --pass it on to wow
  SGP_wowChatFrameOnEvent(event, unpack(arg))

end

function SGP_ignore(name, permanent)

  name = string.lower(name)

  --sometimes add to our data
  if permanent then SGP_ignoreList[SGP_realmName][name] = true end

  if SGP_ignoreSessionList[name] then return end

  --if at wow max for ignore, make room on wow's list
  if GetNumIgnores() > 23 then

    SGP_blockUnIgnore = SGP_blockUnIgnore + 1
    SGP_ignoreSessionList[GetIgnoreName(1)] = false
    SGP_wowUnIgnore(GetIgnoreName(1))

    if GetNumIgnores() == 25 then 
      SGP_blockUnIgnore = SGP_blockUnIgnore + 1
      SGP_ignoreSessionList[GetIgnoreName(2)] = false
      SGP_wowUnIgnore(GetIgnoreName(2))
    end

  end    

  --record ignore in this session
  SGP_ignoreSessionList[name] = true

  --pass it on to wow
  SGP_wowIgnore(name)

end

function SGP_unIgnore(name)

  name = string.lower(name)

  --remove from our data
  local newTable = {}
  for a in SGP_ignoreList[SGP_realmName] do
    if a ~= name then newTable[a] = true end
  end

  SGP_ignoreList[SGP_realmName] = newTable

  --record change for this session
  SGP_ignoreSessionList[name] = false

  --pass it on to wow
  SGP_wowUnIgnore(name)

end

function SGP_toggleIgnore(name)

  name = string.lower(name)

  if SGP_ignoreList[SGP_realmName][name] then
    SGP_unIgnore(name)
  else
    SGP_ignore(name, true)
  end

end

function SGP_unitPopupOnClick()

    local name = getglobal(UIDROPDOWNMENU_INIT_MENU).name

	if this.value == "Ignore" then
		SGP_ignore(name, true)
	elseif this.value == "tempIgnore" then
		SGP_ignore(name, false)
	else
		SGP_wowUnitPopupOnClick()
	end

end

function SGP_hideButtons()

    SGP_wowHideButtons()

    local name = getglobal(UIDROPDOWNMENU_INIT_MENU).name;

    if name then

        local show = true

		--can't ignore yourself
        if name == UnitName("PLAYER") then
            show = false;
        end

        --can't ignore someone already ignored
		if show then
			for i = 1, GetNumIgnores() do
            	if GetIgnoreName(i) == name then
                	show = false
                	break;
            	end
        	end
		end

        --tell wow whether or not to show them
        for i, text in UnitPopupMenus["FRIEND"] do
            if text == "Ignore" or text == "tempIgnore" then
				if show then
					UnitPopupShown[i] = 1
				else
				    UnitPopupShown[i] = 0
				end
            end
        end
    end
    
end

function say(text)

  DEFAULT_CHAT_FRAME:AddMessage(text)

end