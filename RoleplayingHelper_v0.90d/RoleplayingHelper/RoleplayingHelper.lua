-- Roleplaying Helper

-- initialize the RPWORDLIST table
RPWORDLIST = {}

-- Register with myAddOns

RPHELPER_TITLE =       "Roleplaying Helper";
RPHELPER_VERSION =     "0.90d"
RPHELPER_RELEASEDATE = "Nov 6, 2006";
RPHELPER_AUTHOR =      "Talyn";
RPHELPER_EMAIL =       ""
RPHELPER_WEBSITE =     "http://ui.worldofwar.net/ui.php?id=2914";

RoleplayingHelperDetails	= {	
			name =         RPHELPER_TITLE,
			version =      RPHELPER_VERSION,
			releaseDate =  RPHELPER_RELEASEDATE,
			author =       RPHELPER_AUTHOR,
			email =        RPHELPER_EMAIL,
			website =      RPHELPER_WEBSITE,
			category =     MYADDONS_CATEGORY_CHAT,
			optionsframe = "RPConfigFrame",
		};

RoleplayingHelperHelp	= {};
RoleplayingHelperHelp[1] = "Roleplaying Helper lets your character automatically roleplay when certain events occur.\n\nCommands:\n\n/rp\n/rp on\n/rp off";

-- Keybindings
BINDING_HEADER_RPH = "Roleplaying Helper";
BINDING_NAME_RPH_TOGGLE = "Toggle RPH On/Off";
BINDING_NAME_RPH_CONFIG = "Show RPH Options"

-- Add spell tables to RPWORDLIST  (localization.lua must load before this)
table.foreach( SPELLS, function(k,v)
	table.foreach( SPELLS[k], function(k2,v2)
		table.foreach( SPELLS[k][k2], function(k3,v3)
			RPWORDLIST[ k3 ]  = {}
		end)
	end)	
end)

-- Add RPEvents table to RPWORDLIST
table.foreach( RPEvents, function(k,v)
	RPWORDLIST[ k ]  = {}
end)

RPWORDLIST.randominsult = {}
RPWORDLIST.randomemote = {}

RPHelper_Debug_Events = {
	"UPDATE_SELECTED_CHARACTER",
	"CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS",
	"CHAT_MSG_COMBAT_FRIENDLY_DEATH",              
	"PLAYER_QUITING",
	--"PLAYER_CONTROL_GAINED",
	--"PLAYER_CONTROL_LOST",	     
	--"PLAYER_DAMAGE_DONE_MODS",	
	"PLAYER_PET_CHANGED",	  	  
	--"UPDATE_SHAPESHIFT_FORMS", 
	"UNIT_SPELLMISS",         
	"CHAT_MSG_COMBAT_PARTY_HITS", 
	"CHAT_MSG_COMBAT_PARTY_MISSES",
	"CHAT_MSG_BG_SYSTEM_ALLIANCE",
	"CHAT_MSG_BG_SYSTEM_HORDE",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL",
	"PLAYER_PVP_KILLS_CHANGED",
	--"PLAYER_PVP_RANK_CHANGED",
	"PLAYER_PVPLEVEL_CHANGED",
	"PLAYER_FLAGS_CHANGED",
	--"UPDATE_PENDING_MAIL",
	--"UPDATE_WORLD_STATES",
	"CHAT_MSG_MONSTER_EMOTE",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_SAY",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_MONSTER_WHISPER",
	"CHAT_MSG_EMOTE",
	"CHAT_MSG_TEXT_EMOTE",
	--"UI_INFO_MSG",
	--"CHAT_MSG_CHANNEL",
	"CHAT_MSG_COMBAT_SELF_HITS",
	
	"DUEL_REQUESTED",
	"DUEL_FINISHED",
	"DUEL_OUTOFBOUNDS",
	"CHAT_MSG_COMBAT_FACTION_CHANGED",
	"SPELLCAST_START",
	"SPELLCAST_CHANNEL_START",
	"SPELLCAST_CHANNEL_UPDATE",
	--"SPELLCAST_STOP",
	"SPELLCAST_INTERRUPTED",
	"CHAT_MSG_SPELL_SELF_BUFF",
	"CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_BUFFS",
	"CHAT_MSG_SKILL",
	--"PLAYER_GUILD_UPDATE",
	--"UNIT_FACTION",
	--"CHAT_MSG_SYSTEM",
    "CHAT_MSG_SPELL_ITEM_ENCHANTMENTS",
    "CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF",
    "AUCTION_HOUSE_SHOW",
    "AUCTION_HOUSE_CLOSED",
    "BANKFRAME_OPENED",
    "BANKFRAME_CLOSED",
    "BATTLEFIELDS_SHOW",
    "BATTLEFIELDS_CLOSED",
    "CRAFT_SHOW",
    "CRAFT_CLOSE",
    "MAIL_SHOW",
    "MAIL_CLOSED",
    "PET_STABLE_SHOW",
    "PET_STABLE_CLOSED",
    "TAXIMAP_OPENED",
    "TAXIMAP_CLOSED",
    "TRADE_SKILL_SHOW",
    "TRADE_SKILL_CLOSED",
    "TRAINER_SHOW",
    "TRAINER_CLOSED",
    "MINIMAP_PING",
--    "ZONE_CHANGED",
--    "ZONE_CHANGED_INDOORS",
    "ZONE_UNDER_ATTACK",
    "PLAYER_ENTERING_WORLD",
    "PARTY_LEADER_CHANGED",
    "QUEST_GREETING",
    "QUEST_DETAIL",
    "QUEST_ACCEPT_CONFIRM",
    "QUEST_COMPLETE",
    "QUEST_FINISHED",
    "PLAYER_TRADE_MONEY",
    "PLAYER_ALIVE",
    "RESURRECT_REQUEST",
    "LOCALPLAYER_PET_RENAMED",
--    "UNIT_HAPPINESS",
    
    
	
}


--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- FUNCTION FOR INITIALIZATION
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function RP_OnLoad()

--=====================================================================--
-- Events Registered
--=====================================================================--

-- Non-combat events
   	this:RegisterEvent("VARIABLES_LOADED")

   	this:RegisterEvent("CHAT_MSG_MONSTER_SAY")
   	this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
   	
   	this:RegisterEvent("CHAT_MSG_CHANNEL")
   	this:RegisterEvent("CHAT_MSG_SYSTEM")

	this:RegisterEvent("PLAYER_UNGHOST")

	this:RegisterEvent("GOSSIP_SHOW")
	this:RegisterEvent("GOSSIP_CLOSED")

   	this:RegisterEvent("MERCHANT_SHOW")
    this:RegisterEvent("MERCHANT_CLOSED")

	this:RegisterEvent("QUEST_FINISHED")
   	this:RegisterEvent("QUEST_COMPLETE")
   	this:RegisterEvent("QUEST_GREETING")
   	this:RegisterEvent("QUEST_PROGRESS") 
	this:RegisterEvent("QUEST_DETAIL")

   	this:RegisterEvent("PLAYER_DEAD")
   	
   	this:RegisterEvent("TRADE_SHOW")
   	this:RegisterEvent("TRADE_CLOSED")

-- Combat events
   	this:RegisterEvent("PLAYER_REGEN_DISABLED") -- Enter Combat
   	this:RegisterEvent("PLAYER_REGEN_ENABLED") -- Leave Combat

   	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS") -- Creature hits you
   	this:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE") -- Creature hits you with spell
                                                             
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS") -- Hostile player hits you
   	this:RegisterEvent("CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE") -- Hostile player hits you with spell
   	
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES") -- Creature misses you
    this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES")
		      	
   	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS") -- You hit something.
   	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE") -- You hit something with spell.

	this:RegisterEvent("SPELLCAST_START")

   	this:RegisterEvent("PET_ATTACK_START")
   	this:RegisterEvent("PET_ATTACK_STOP")
   	
	this:RegisterEvent("CHAT_MSG_COMBAT_FRIENDLY_DEATH")

	this:RegisterEvent("SPELLCAST_CHANNEL_START")
	this:RegisterEvent("SPELLCAST_CHANNEL_UPDATE")

    this:RegisterEvent("SPELLCAST_FAILED")
	this:RegisterEvent("SPELLCAST_STOP")
	this:RegisterEvent("SPELLCAST_INTERRUPTED")

	this:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF")  -- Used when healing
    
	this:RegisterEvent("PLAYER_CAMPING")  -- When you logout
                                                             
	this:RegisterEvent("PLAYER_LEVEL_UP")
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA") -- change zones

	table.foreach( RPHelper_Debug_Events, function(k,v)
		this:RegisterEvent( v )	
	end)


--=====================================================================--
-- Variables Initialized
--=====================================================================--
   	this.hp = -1
   	this.lasthp = -1
   	this.lastmana = -1
   	this.lastpethp = -1

	TalkToNPCBoxClosed = GetTime()
   	LastRP = GetTime()
   	IsDead = false
   	IsChanneling = false

	RPedAtLeastOnce = false
   	JustRPed = false
	
  -- For statistics
	RPStats = {}
	RPStats.GETHURT = {}
	RPStats.GETHURT.rp = 0
	RPStats.CREATURE_VS_SELF_MISSES = {}
	RPStats.CREATURE_VS_SELF_MISSES.rp = 0
   	RPStats.PET_ATTACK_START = {}
   	RPStats.PET_ATTACK_START.rp = 0
   	RPStats.MONSTER_SAY = {}
   	RPStats.MONSTER_SAY.rp = 0
   	RPStats.EVENT = {}
    RPStats.EVENT.rp = 0
    RPStats.SPELL = {}
    RPStats.SPELL.rp = 0 

  -- Gossip Box Variables
	TalkingToNPC = false
   	INTRODUCED = {} -- A list of all of the people your character speaks to.

  -- Used by RPEventsFrame & RPSpellsFrame to keep track of the Events & Spell page you were on.
   	RP_EventsPage = 1
   	RP_SpellPage = 1

--=====================================================================--
-- Slash Command /rp Initialized
--=====================================================================--
	SLASH_RP1 = "/rp"
	SlashCmdList["RP"] = RP_SlashCommands

end  -- function RP_OnLoad()

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- FUNCTION TO RESET DEFAULT CONFIG
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function RPDefaults( x )

	-- setup tables
	if (not RPCONFIG) then RPCONFIG = {} end	

	-- On/Off	    
	if ( RPCONFIG.on == nil ) or ( x == "all" ) or ( x == "on" ) then RPCONFIG.on = true				end
	
--[[
	-- Delays & Chances	                                                                                                    
	if ( RPCONFIG.UseAllCombat == nil ) 	or ( x == "all" ) or ( x == "dc" ) then		RPCONFIG.UseAllCombat = false  	end 
	if ( RPCONFIG.UseNonCombat == nil ) 	or ( x == "all" ) or ( x == "dc" ) then		RPCONFIG.UseNonCombat = false  	end 
	if ( RPCONFIG.UseAnytime == nil ) 		or ( x == "all" ) or ( x == "dc" ) then		RPCONFIG.UseAnytime = false  	end
	if ( not RPCONFIG.AllCombatDelay ) 		or ( x == "all" ) or ( x == "dc" ) then		RPCONFIG.AllCombatDelay = 8   	end
	if ( not RPCONFIG.AllCombatChance ) 	or ( x == "all" ) or ( x == "dc" ) then  	RPCONFIG.AllCombatChance = .03 	end
	if ( not RPCONFIG.NonCombatDelay ) 		or ( x == "all" ) or ( x == "dc" ) then		RPCONFIG.NonCombatDelay = 5   	end
	if ( not RPCONFIG.NonCombatChance ) 	or ( x == "all" ) or ( x == "dc" ) then  	RPCONFIG.NonCombatChance = .9	end
	if ( not RPCONFIG.AnytimeDelay ) 		or ( x == "all" ) or ( x == "dc" ) then		RPCONFIG.AnytimeDelay = 2   	end
	if ( not RPCONFIG.AnytimeChance ) 		or ( x == "all" ) or ( x == "dc" ) then  	RPCONFIG.AnytimeChance = .03	end
]]	

	table.foreach( RPEvents, function(k,v)
	    if ( RPCONFIG[k] == nil ) then
	        RPCONFIG[k] = {}
	    end
	    if ( RPCONFIG[k]["Delay"] == nil ) or ( x == "all" ) or ( x == "events" ) then
	        if k == "petdies" then              -- petdies
	        	RPCONFIG[k]["Delay"] = 0
			elseif k == "resurrect" then       	-- resurrect
	        	RPCONFIG[k]["Delay"] = 0              
			elseif k == "player_level_up" then  -- player_level_up
	        	RPCONFIG[k]["Delay"] = 0                          
			elseif k == "player_camping" then   -- player_camping
	        	RPCONFIG[k]["Delay"] = 0
			else                                -- everything else
		    	RPCONFIG[k]["Delay"] = 8
			end
		end
	    if ( RPCONFIG[k]["Chance"] == nil ) or ( x == "all" ) or ( x == "events" ) then
	        if k == "youcrit" then          	-- youcrit
	        	RPCONFIG[k]["Chance"] = .08
	        elseif k == "youcritspell" then     -- youcritspell
	        	RPCONFIG[k]["Chance"] = .08
	        elseif k == "petdies" then          -- petdies
	        	RPCONFIG[k]["Chance"] = 1
	        elseif k == "resurrect" then       	-- resurrect
	        	RPCONFIG[k]["Chance"] = 1
	        elseif k == "talktonpc_firsttime" then   -- talktonpc_firsttime
	        	RPCONFIG[k]["Chance"] = 1
	        elseif k == "talktonpc_beginning" then   -- talktonpc_beginning
	        	RPCONFIG[k]["Chance"] = .25
	        elseif k == "talktonpc_middle" then -- talktonpc_middle
	        	RPCONFIG[k]["Chance"] = .1
	        elseif k == "talktonpc_end" then   	-- talktonpc_end
	        	RPCONFIG[k]["Chance"] = .25
	        elseif k == "npctalksfriend" then   -- npctalksfriend
	        	RPCONFIG[k]["Chance"] = .2
	        elseif k == "npctalksenemy" then   	-- npctalksenemy
	        	RPCONFIG[k]["Chance"] = .2                    
	        elseif k == "player_level_up" then  -- player_level_up
	        	RPCONFIG[k]["Chance"] = 1                        
	        elseif k == "player_camping" then   -- player_camping
	        	RPCONFIG[k]["Chance"] = 1
	        elseif k == "trade_show" then       -- trade window open
	            RPCONFIG[k]["Chance"] = .25
	        elseif k == "trade_closed" then      --- trade window closed
	            RPCONFIG[k]["Chance"] = .25
	        elseif k == "mount" then            -- mounting
	            RPCONFIG[k]["Chance"] = .2
	        elseif k == "learn" then
                RPCONFIG[k]["Chance"] = .1
            elseif k == "new_home" then
                RPCONFIG[k]["Chance"] = .2
	        else                                -- everything else
	        	RPCONFIG[k]["Chance"] = .03
			end
	    end
	end)

	-- Spells
	local spelltypes = { "casttime", "channeled", "instant", "next_melee"  }
	-- Trainable Spells
 	table.foreachi( spelltypes, function( k, spelltype )
	 	table.foreach( SPELLS[spelltype][englishClass], function( formatted_spellname, v2 )

			if ( not RPCONFIG[formatted_spellname]) or ( x == "all" ) or ( x == "spells" ) then
				RPCONFIG[formatted_spellname] = {}
				RPCONFIG[formatted_spellname]["Chance"] = .03 
				RPCONFIG[formatted_spellname]["Delay"] = 8
			end
						
	    end)
	end)
	-- Racial abilities
	table.foreachi( spelltypes, function( k, spelltype )
	 	table.foreach( SPELLS[spelltype][englishClass], function( formatted_spellname, v2 )

			if ( not RPCONFIG[formatted_spellname]) or ( x == "all" ) or ( x == "spells" ) then
				RPCONFIG[formatted_spellname] = {}
				RPCONFIG[formatted_spellname]["Chance"] = .03 
				RPCONFIG[formatted_spellname]["Delay"] = 8
			end
						
	    end)
	end)
	
	-- Events to Show (RPEventsFrame)
	if ( not RPCONFIG.Events_to_Show ) or ( x == "all" ) or ( x == "events" ) then
		local x = "All \(" .. playerClass .. "\)"
        RPCONFIG.Events_to_Show = x
	end
	
	-- Spells to Show (RPSpellsFrame)
	if ( not RPCONFIG.Spells_to_Show ) or ( x == "all" ) or ( x == "spells" ) then
        RPCONFIG.Spells_to_Show = "Known with RPs"
	end

	-- Traits
	if ( not RPCONFIG.traits ) or ( x == "all" ) or ( x == "trait" ) or ( x == "traits" ) then
		RPCONFIG.traits = {"ANY"}
		if englishRace == "Scourge" then
			table.insert( RPCONFIG.traits, "UNDEAD" )
		else
			table.insert( RPCONFIG.traits, string.upper(englishRace) )
		end
		table.insert( RPCONFIG.traits, englishClass )
	end

	-- if you take your class out of RPCONFIG.traits, you might still want to RP spells
	if ( RPCONFIG.UseSpellRPs == nil ) or ( x == "all" ) or ( x == "trait" ) or ( x == "traits" ) then
		RPCONFIG.UseSpellRPs = true		
	end	 

	-- Language to RP in
    if ( not RPCONFIG.RPLang ) or ( x == "all" ) or ( x == "lang" ) then 				RPCONFIG.RPLang = "Use Current"		end
	
	-- Debug to false unless it's already on
    if ( RPCONFIG.Debug == nil ) or ( x == "all" ) or ( x == "debug" ) then 			RPCONFIG.Debug = false				end
end


--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- FUNCTION FOR LOCALIZATION (Uses strings found in GlobalStrings.lua to compare words in a chat message)
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function SameEventStrings( GlobalString, x )
	-- To fix the "unfinished capture" error on French Clients
	GlobalString = string.gsub(GlobalString, "%(", "")
	GlobalString = string.gsub(GlobalString, "%)", "")
	x = string.gsub(x, "%(", "")
	x = string.gsub(x, "%)", "")

	local PartsToCompare = {}
	local a = 1
	local b = string.find( GlobalString, "%%" )
	while b do
		table.insert( PartsToCompare, string.sub( GlobalString, a, b-1 ) )
		a = b+2
		b = string.find( GlobalString, "%%", a )
	end
	table.insert( PartsToCompare, string.sub( GlobalString, a ) )

	local ItsTheSame = true
	table.foreach( PartsToCompare,
		function(k,v)
			if string.find( x, v ) == nil then
				ItsTheSame = false
				return ItsTheSame
			end
		end)

	return ItsTheSame
end


--=====================================================================--
-- RPTimerFrame
-- Waits 2 frame to see if you've finished talking to an NPC
--=====================================================================--
function RPTimerFrameOnUpdate()
	if RPNumFrames <= 2 then -- count up to 2 frames
    	RPNumFrames = RPNumFrames + 1
	else
	    RPTimerIsRunning = false
	    RPTimerFrame:Hide()
	    EndOfConversationWithNPC()
	end
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- FUNCTION TO SET RP LANGUAGE
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function RPHelper_SetLanguage()
	local Language_Choices = { "Use Current" }
	for i = 1, GetNumLaguages() do
		table.insert( Language_Choices, GetLanguageByIndex( i ) )
	end
	table.insert( Language_Choices, "Random" )
	
	local x = PlaceInArray( Language_Choices, RPCONFIG.RPLang )

	if x + 1 > table.getn( Language_Choices ) then
		RPCONFIG.RPLang = Language_Choices[1]
	else
		RPCONFIG.RPLang = Language_Choices[x+1]
	end
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- FUNCTION TO SET EVENTS SHOWN IN RPSpellsFrame
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function RPHelper_SetEventsShown()
	local y = "All \(" .. playerClass .. "\)"
	local EventsShown_Choices = { y, "All with RPs" }
	local x = PlaceInArray( EventsShown_Choices, RPCONFIG.Events_to_Show )

	if x + 1 > table.getn( EventsShown_Choices ) then
		RPCONFIG.Events_to_Show = EventsShown_Choices[1]
	else
		RPCONFIG.Events_to_Show = EventsShown_Choices[x+1]
	end
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- FUNCTION TO SET SPELLS SHOWN IN RPSpellsFrame
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function RPHelper_SetSpellsShown()
	local SpellsShown_Choices = { "All", "All Known", "All with RPs", "Known with RPs" }
	local x = PlaceInArray( SpellsShown_Choices, RPCONFIG.Spells_to_Show )

	if x + 1 > table.getn( SpellsShown_Choices ) then
		RPCONFIG.Spells_to_Show = SpellsShown_Choices[1]
	else
		RPCONFIG.Spells_to_Show = SpellsShown_Choices[x+1]
	end
end


--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- FUNCTION FOR CHOOSING WHICH PHRASES TO SAY
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function GetPhrase( EventType )
	local s = {}	-- table of sayings
	local e = {}	-- table of emotes
	local c = {}	-- table of custom emotes
	local r	= {}	-- table of random phrase tables

	if RPWORDLIST[EventType] then
		table.foreach(RPCONFIG.traits, function(k,v)
		    if RPWORDLIST[EventType][v] then

				-- sayings
				JoinArrays( s, RPWORDLIST[EventType][v] )
		    
				table.foreach( RPWORDLIST[EventType][v], function(k2, v2)
	                -- custom emotes
					if string.find(k2, "customemote") then
						JoinArrays( c, RPWORDLIST[EventType][v][k2] )

					-- emotes
					elseif string.find(k2, "emote") then
						JoinArrays( e, RPWORDLIST[EventType][v][k2] )

					-- random phrases
					elseif string.find(k2, "random") then
						if ( table.getn( RPWORDLIST[EventType][v][k2] ) > 0 ) then
							if RandPhraseCheck( EventType, v, k2 ) then
								table.insert( r, RPWORDLIST[EventType][v][k2] )
							end
					    end
					end
			    end)

			end
		end)

		-- if you take your class out of RPCONFIG.traits, but still want to RP spells	
		if RPCONFIG.UseSpellRPs and ( PlaceInArray( RPCONFIG.traits, englishClass ) == false ) then
			local Its_a_spell = true
			table.foreach( RPEvents, function(k,v)
				if k == EventType then
					Its_a_spell = false
				end	
			end)
			if Its_a_spell then
			    if RPWORDLIST[EventType][englishClass] then
	
					-- sayings
					JoinArrays( s, RPWORDLIST[EventType][englishClass] )
			    
					table.foreach( RPWORDLIST[EventType][englishClass], function(k2, v2)
		                -- custom emotes
						if string.find(k2, "customemote") then
							JoinArrays( c, RPWORDLIST[EventType][englishClass][k2] )
	
						-- emotes
						elseif string.find(k2, "emote") then
							JoinArrays( e, RPWORDLIST[EventType][englishClass][k2] )
	
						-- random phrases
						elseif string.find(k2, "random") then
							if ( table.getn( RPWORDLIST[EventType][englishClass][k2] ) > 0 ) then
								if RandPhraseCheck( EventType, englishClass, k2 ) then
									table.insert( r, RPWORDLIST[EventType][englishClass][k2] )
								end
						    end
						end
				    end)
				end
			end 
		end
		
	else
        dcf( "RPWORDLIST."..EventType.." doesn't seem to exist." )
	end

	r = RPHelper_RandomPhraseChooser( r )

	-- The RANDOM PHRASE table is now setup exactly like the SAYINGS table, so it's okay to combine them.
 	s = JoinArrays( s, r )

	-- There are 37 emotes that have 1-3 clones each
	-- Example: /lol (clone) = /laugh (main)
	-- If you type these clones in the game using /emote, Blizzard will change them into the "main" emote
	-- Unfortunately, DoEmote() won't do ANYTHING if you feed it one of the clones
	-- so the following is used to replace them with the "main" emotes
 	table.foreachi( e, function(k,v)
 		if string.find( v, " SELF" ) then
	 		e[k] = string.gsub( v, " SELF", "" )
	 	    if RP_Emote_List[ string.lower(e[k]) ][ "clone_of" ] then
	 	        e[k] = RP_Emote_List[ string.lower(e[k]) ][ "clone_of" ]
	 	    end
	 	    e[k] = e[k] .. " SELF"
		elseif RP_Emote_List[ string.lower(e[k]) ] then
			if RP_Emote_List[ string.lower(e[k]) ][ "clone_of" ] then
	 	    	e[k] = RP_Emote_List[ string.lower(e[k]) ][ "clone_of" ]
	 	    end
		end
 	end)

	return s, e, c
end



--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- FUNCTION for:
-- 1. getting info about random phrases available (ex: Number of possible phrases)
-- 2. using that info to decide how many random phrases should be given a chance to be said
-- 3. making a table of completed phrases
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function RPHelper_RandomPhraseChooser( r )
	local RandomPhraseTable = {}

	if r then
		local NumOfPhrases = table.getn( r )

		table.foreach( r,
			function(k,v)
				local PhraseWithBlanks, NumOfBlanks = string.gsub( r[k]["phrase"], "BLANK", "BLANKx" )
				local NumOfPossibilities = 1
				for i = 1,NumOfBlanks do
     				NumOfPossibilities = NumOfPossibilities * table.getn( r[k][i] )
				end
				r[k]["NumOfPhrases"] = Round ( NumOfPossibilities / 40 )  -- 40 is an arbitrary number I picked
				if r[k]["NumOfPhrases"] < 1 then
					r[k]["NumOfPhrases"] = 1
				end

				-- We know how many phrases we're going to add to our phrase list.  Now let's do it.
				for i = 1, r[k]["NumOfPhrases"] do
				    local CompletedPhrase = PhraseWithBlanks
				
					for j = 1,NumOfBlanks do
						local x = math.random( table.getn( r[k][j] ) )
						CompletedPhrase = string.gsub( CompletedPhrase, "BLANKx", r[k][j][x], 1 )
					end
					
					table.insert( RandomPhraseTable, CompletedPhrase )
				end
			end)
	end

	return RandomPhraseTable

end



--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- FUNCTION FOR SAYING or EMOTING; takes tables: sayings, emotes; randomly picks & does one or the other
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function Roleplay( sayings, emotes, customemotes )

	-- KEYWORDS
	sayings = RPHelper_ReplaceKeywords( sayings, "saying" )
	customemotes = RPHelper_ReplaceKeywords( customemotes, "customemote" )

	local sSize = table.getn( sayings ) 		-- Size of SAYINGS table
	local eSize = 0 							-- Size of EMOTES table (0 until we make sure we're not channeling)
	local cSize = table.getn( customemotes ) 	-- Size of CUSTOM EMOTES table

	if (IsChanneling == false) and (emotes) then	-- 'and (emotes)' was added so we can call this function with only 1 table of sayings sent to this function
	    eSize = table.getn( emotes )
	end

	-- Get language to RP in
    local RPLanguage    
    if RPCONFIG.RPLang == "Use Current" then
        RPLanguage = DEFAULT_CHAT_FRAME.editBox.language		-- DEFAULT_CHAT_FRAME.editBox.language = the language you are speaking now
    elseif RPCONFIG.RPLang == "Random" then
    	RPLanguage = GetLanguageByIndex( math.random( GetNumLaguages() ) )
    else
		RPLanguage = RPCONFIG.RPLang	
    end

	if (sSize + eSize + cSize) > 0 then
		local x = math.random(sSize + eSize + cSize)
		if x > (sSize + eSize) then
        	SendChatMessage( customemotes[x - sSize - eSize], "EMOTE" )  -- CUSTOM EMOTE
		elseif x > sSize then
			
			-- Just for you mithyk (^_^)  A way to self target emotes
			if string.find( emotes[x - sSize], " SELF" ) then
				emotes[x - sSize] = string.gsub( emotes[x - sSize], " SELF", "" )
				DoEmote( emotes[x - sSize], "player" )		  -- SELF EMOTE
			else
				DoEmote( emotes[x - sSize] )                  -- EMOTE	
			end
			 	
		else
		  	SendChatMessage( sayings[x], "SAY", RPLanguage )        -- SAYING
		end

		JustRPed = true
	end
end


--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- FUNCTIONS FOR RANDOM GENERATORS
	-- EventType:   Example: entercombat
	-- v:           Example: WARRIOR
	-- random:      Any phrase that has the word "random" in it.  This is so customizable files can have random1, random2, pukingrandompoop, etc.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function RandPhraseCheck( EventType, v, random )   -- Takes table with the random phrase parts inside; Returns boolean if the random phrase table is setup correctly
	local ErrorMessage = {}
	local EverythingOK = true
	local TempPhrase
	local num
	if not random then 	random = "random"; 		end

	if type( RPWORDLIST[EventType][v][random]["phrase"] ) ~= "string" then
		EverythingOK = false
		table.insert( ErrorMessage, 'RPWORDLIST.' .. EventType .. '.' .. v .. '.'..random..'["phrase"] seems to not exist or not be a valid string.' )
	else
		TempPhrase, num = string.gsub( RPWORDLIST[EventType][v][random]["phrase"], "BLANK", "BLANKp" ) -- TempPhrase is not important, we just need the number of "BLANK"s in the phrase

		if num < 1 then -- CHECK: there is at least 1 BLANK
			EverythingOK = false
			table.insert( ErrorMessage, 'There are no "BLANK"s in RPWORDLIST.' .. EventType .. '.' .. v .. '.'..random..'["phrase"]' )
		else
			for i = 1,num do
				if type( RPWORDLIST[EventType][v][random][i] ) == "table" then  -- CHECK: [i] is a table
				
					if table.getn( RPWORDLIST[EventType][v][random][i] ) < 1 then  -- CHECK: [i] table has at least 1 phrase to go with BLANK.
						EverythingOK = false
						table.insert( ErrorMessage, "There are no phrases in RPWORDLIST." .. EventType .. "." .. v .. "."..random.."[" .. i .. "]" )
					end -- if table.getn( RPWORDLIST[EventType][v]["random"][i] ) < 1
					
				else
					EverythingOK = false
					table.insert( ErrorMessage, "You have " .. num .. " BLANKs but RPWORDLIST." .. EventType .. "." .. v .. "."..random.."[" .. i .. "] seems to not exist or not be a valid table." )
				end
				
			end -- for i = 1,num do
		end -- if num < 1
	end -- if type( RPWORDLIST[EventType][v]["random"]["phrase"] ~= "string" ) then

	if ( EverythingOK == false ) then
            dcf( "You made an error when customizing your random phrase:" )
        
		table.foreach(ErrorMessage,
			function(k,v)
		    	dcf( v )
			end)
	end

	return EverythingOK
end


function RandInsult() -- returns "string" insult; if 1 of the parts is missing, returns false
	local Part1 = {}
	local Part2 = {}
	local Part3 = {}
	local insult

	table.foreach( RPCONFIG.traits,
	    function(k,v)
	    	if RPWORDLIST.randominsult[v][1] then
	        	Part1 = JoinArrays( Part1, RPWORDLIST.randominsult[v][1] )
	        end
	        
			if RPWORDLIST.randominsult[v][2] then
	        	Part2 = JoinArrays( Part2, RPWORDLIST.randominsult[v][2] )
	        end
	        
			if RPWORDLIST.randominsult[v][3] then
	        	Part3 = JoinArrays( Part3, RPWORDLIST.randominsult[v][3] )
	    	end
		end)
	    
	if ( table.getn( Part1 ) > 0 ) and ( table.getn( Part2 ) > 0 ) and ( table.getn( Part3 ) > 0 ) then
	    local p1 = math.random( table.getn( Part1 ) )
	    local p2 = math.random( table.getn( Part2 ) )
	    local p3 = math.random( table.getn( Part3 ) )
	    
	    -- YOU is a localized variable from Blizzard's GlobalStrings.lua
		insult = RPWORDLIST.randominsult.YOU .. " " .. Part1[p1] .. " " .. Part2[p2] .. " " .. Part3[p3] .. "."
		return insult
	else
	    return false
	end
end

function RandInsultEmote() -- returns "string" insult; if 1 of the parts is missing, returns false
    -- yes, this is a copy of RandInsult()
	local Part1 = {}
	local Part2 = {}
	local Part3 = {}
	local insult

	table.foreach( RPCONFIG.traits,
	    function(k,v)
	    	if RPWORDLIST.randomemote[v][1] then
	        	Part1 = JoinArrays( Part1, RPWORDLIST.randomemote[v][1] )
	        end
	        
			if RPWORDLIST.randomemote[v][2] then
	        	Part2 = JoinArrays( Part2, RPWORDLIST.randomemote[v][2] )
	        end
	        
			if RPWORDLIST.randomemote[v][3] then
	        	Part3 = JoinArrays( Part3, RPWORDLIST.randomemote[v][3] )
	    	end
		end)
	    
	if ( table.getn( Part1 ) > 0 ) and ( table.getn( Part2 ) > 0 ) and ( table.getn( Part3 ) > 0 ) then
	    local p1 = math.random( table.getn( Part1 ) )
	    local p2 = math.random( table.getn( Part2 ) )
	    local p3 = math.random( table.getn( Part3 ) )
	    
		insult = Part1[p1] .. " " .. Part2[p2] .. " " .. Part3[p3] .. "."
		return insult
	else
	    return false
	end
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- FUNCTION FOR EVENTS
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function RP_OnEvent(event)

--=====================================================================--
-- VARIABLES_LOADED
--=====================================================================--
	if (event == "VARIABLES_LOADED") then

		if(myAddOnsFrame_Register) then
			myAddOnsFrame_Register(RoleplayingHelperDetails,RoleplayingHelperHelp);
		end

	   	playerRace, englishRace = UnitRace("player");
	   	playerClass, englishClass = UnitClass("player");

		RPDefaults()
        local status = "(Disabled)";
        if RPCONFIG.on then 
            status = "(Enabled)"
        end
		DEFAULT_CHAT_FRAME:AddMessage( "Roleplaying Helper "..RPHELPER_VERSION.." loaded. "..status.." Type:  /rp", 0.0, 1.0, 1.0 )
--		DEFAULT_CHAT_FRAME:AddMessage( "Your RP traits are: ".. table.concat(RPCONFIG.traits, ", "), 0.0, 1.0, 1.0 )
--		DEFAULT_CHAT_FRAME:AddMessage( RandInsult(), 0.0, 1.0, 1.0 )
	end

	if ( RPCONFIG.on == false ) then
		return
	end
--=====================================================================--
-- We need to check if we are channeling, since emotes will interrupt it.
-- Thanks to Syllani for this code suggestion.
--=====================================================================--
	if (event=="SPELLCAST_CHANNEL_START") then
		IsChanneling = true
		if RPCONFIG.Debug then dcf(event) end
		return
	end

	if (event=="SPELLCAST_CHANNEL_UPDATE") then
		if (arg1==0) then
			IsChanneling = false
		end
		return
	end

--=====================================================================--
-- 'a' is the random number we will use for the chance that nothing will happen
--=====================================================================--
	local a = math.random()

--=====================================================================--
-- When you enter combat.
--=====================================================================--
   	if ( event == "PLAYER_REGEN_DISABLED" ) then
   	    if RPCONFIG.Debug then dcf("Entered combat! Chance="..RPCONFIG.entercombat["Chance"].." Roll="..a) end
    	if ( a <= RPCONFIG.entercombat["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.entercombat["Delay"] ) then
			local s, e, c = GetPhrase( "entercombat" )
			Roleplay( s, e, c )
		end -- Delay & Chance
--=====================================================================--
-- When you leave combat.
--=====================================================================--
   	elseif ( event == "PLAYER_REGEN_ENABLED" ) then
   	    if RPCONFIG.Debug then dcf("Left combat! Chance="..RPCONFIG.leavecombat["Chance"].." Roll="..a) end
    	if ( a <= RPCONFIG.leavecombat["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.leavecombat["Delay"] ) then
 			local s, e, c = GetPhrase( "leavecombat" )
			Roleplay( s, e, c )
		end -- Delay & Chance

--=====================================================================--
-- If you're getting hurt.
	-- CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS
	-- arg1 = "Attacker" hits (you/"pet name") for "number"
	
	-- COMBATHITOTHERSELF = "%s hits you for %d.";
	-- COMBATHITSCHOOLOTHERSELF = "%s hits you for %d %s damage.";
		-- These 2 work!  Haven't tested PVP yet though.
--=====================================================================--
   	elseif  ( event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS" ) 	or 
	   		( event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" ) 	or
	   		( event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS" )	 	or
   			( event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE" ) 	then

    	if ( a <= RPCONFIG.hurt["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.hurt["Delay"] ) then

			if arg1 then
                if SameEventStrings( COMBATHITSCHOOLOTHERSELF, arg1 ) or SameEventStrings( COMBATHITOTHERSELF, arg1 ) then
					this.lasthp = this.hp
			      	this.hp = UnitHealth("player")

			    	if (this.hp < this.lasthp) then
			    	    if RPCONFIG.Debug then dcf("You are hurt") end
	     				local s, e, c = GetPhrase( "hurt" )
						Roleplay( s, e, c )
			      	end
				end -- if SameEventStrings
			end -- if arg1
    	end -- Delay & Chance

--=====================================================================--
-- When a creature or hostile player misses you.
-- arg1 = the following "string"s
-- "target" misses you.
-- "target" attacks. You dodge.
-- "target" attacks. You block.
-- "target" attacks. You parry.
--=====================================================================--
   	elseif ( event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES" ) then    -- Unsure here:  or ( event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES" )
		if ( UnitHealth("player") / UnitHealthMax("player") ) >= 0.7 then  -- Your health must be above 70%

			RPStats.CREATURE_VS_SELF_MISSES.rp = RPStats.CREATURE_VS_SELF_MISSES.rp + 1  -- for statistics

			local s = {}
			local e = {}
			local c = {}
			local r = {}
                	
			if 	   SameEventStrings( VSABSORBOTHERSELF, arg1 ) then
			 if RPCONFIG.Debug then dcf("You absorb damage") end
    			if ( a <= RPCONFIG.absorb["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.absorb["Delay"] ) then	
					s, e, c = GetPhrase( "absorb" )
					Roleplay( s, e, c, r )
				end				
				
			elseif SameEventStrings( VSBLOCKOTHERSELF, arg1 ) then
			 if RPCONFIG.Debug then dcf("You block an attack") end
    			if ( a <= RPCONFIG.block["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.block["Delay"] ) then	
			    	s, e, c = GetPhrase( "block" )
					Roleplay( s, e, c, r )
			    end
			    
		    elseif SameEventStrings( VSDODGEOTHERSELF, arg1 ) then
		      if RPCONFIG.Debug then dcf("You dodge an attack") end
    			if ( a <= RPCONFIG.dodge["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.dodge["Delay"] ) then	
			    	s, e, c = GetPhrase( "dodge" )
					Roleplay( s, e, c, r )
			    end
			    
			elseif SameEventStrings( MISSEDOTHERSELF, arg1 ) then
			 if RPCONFIG.Debug then dcf("An attack misses you") end
    			if ( a <= RPCONFIG.miss["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.miss["Delay"] ) then
			    	s, e, c = GetPhrase( "miss" )
					Roleplay( s, e, c, r )
			    end
			    
			elseif SameEventStrings( VSPARRYOTHERSELF, arg1 ) then
			 if RPCONFIG.Debug then dcf("You parry an attack") end
    			if ( a <= RPCONFIG.parry["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.parry["Delay"] ) then
			    	s, e, c = GetPhrase( "parry" )
					Roleplay( s, e, c, r )
			    end
					
			end
		end -- if ( UnitHealth("player") / UnitHealthMax("player") ) >= 0.7

--=====================================================================--
-- You CRIT something
	-- "CHAT_MSG_COMBAT_SELF_HITS"
	-- is not called for Auto Shot or special melee moves (ie: Raptor Strike) only regular melee hits.
		-- arg1=You hit [enemy] for #.
		-- arg1=You crit [enemy] for #.
		-- arg1=You fall and lose # health.
		-- arg7=0
		-- arg8=0
	-- "CHAT_MSG_SPELL_SELF_DAMAGE"
		-- Your [spell name] hits [enemy] for #.
		-- Your [spell name] crits [enemy] for #.
		-- Your [spell name] missed [enemy].
		-- arg7=0
		-- arg8=0
		
	-- Physical Crits
		-- COMBATHITCRITSELFOTHER = "You crit %s for %d."
		-- SPELLLOGCRITSELFOTHER = "Your %s crits %s for %d."
	-- Spell Crits
		-- SPELLLOGCRITSCHOOLSELFOTHER = "Your %s crits %s for %d %s damage."
	-- Didn't use
		-- SPELLLOGCRITSCHOOLSELFSELF = "Your %s crits you for %d %s damage."
--=====================================================================--
	elseif ( event == "CHAT_MSG_COMBAT_SELF_HITS" ) or ( event == "CHAT_MSG_SPELL_SELF_DAMAGE" ) then
        if ( UnitHealth("player") / UnitHealthMax("player") ) >= 0.7 then
			if SameEventStrings( SPELLLOGCRITSCHOOLSELFOTHER, arg1 ) then
			 if RPCONFIG.Debug then dcf("You crit with a spell") end
    			if ( a <= RPCONFIG.youcritspell["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.youcritspell["Delay"] ) then
					local s, e, c = GetPhrase( "youcritspell" )
					Roleplay( s, e, c )
				end
			elseif SameEventStrings( COMBATHITCRITSELFOTHER, arg1 ) or SameEventStrings( SPELLLOGCRITSELFOTHER, arg1 ) then
			 if RPCONFIG.Debug then dcf("You crit") end
    			if ( a <= RPCONFIG.youcrit["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.youcrit["Delay"] ) then
					local s, e, c = GetPhrase( "youcrit" )
					Roleplay( s, e, c )
				end
			elseif SameEventStrings( VSENVIRONMENTALDAMAGE_FALLING_SELF, arg1 ) then
			 if RPCONFIG.Debug then dcf("You fall") end
                if ( a <= RPCONFIG.fall["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.fall["Delay"] ) then
                    local s, e, c = GetPhrase( "fall" )
                    Roleplay( s, e, c )
                end
            elseif SameEventStrings( VSENVIRONMENTALDAMAGE_DROWNING_SELF, arg1 ) then
                if RPCONFIG.Debug then dcf("You are drowning") end
                if ( a <= RPCONFIG.drowning["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.drowning["Delay"] ) then
                    local s, e, c = GetPhrase( "drowning" )
                    Roleplay( s, e, c )
                end
			end
		end
--=====================================================================--
-- You Heal Someone

	-- The event CHAT_MSG_SPELL_SELF_BUFF is called for Siphon Life

	-- You Heal
		-- HEALEDSELFOTHER = "Your %s heals %s for %d.";
		-- HEALEDSELFSELF = "Your %s heals you for %d.";

	-- You Crit Heal
		-- HEALEDCRITSELFOTHER = "Your %s critically heals %s for %d.";
		-- HEALEDCRITSELFSELF = "Your %s critically heals you for %d.";
--=====================================================================--
	elseif ( event == "CHAT_MSG_SPELL_SELF_BUFF" ) then
		if SameEventStrings( HEALEDCRITSELFOTHER, arg1 ) and ( not SameEventStrings( HEALEDCRITSELFSELF, arg1 ) ) then
		  if RPCONFIG.Debug then dcf("You critical heal") end
    		if ( a <= RPCONFIG.youcritheal["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.youcritheal["Delay"] ) then
				local s, e, c = GetPhrase( "youcritheal" )
				Roleplay( s, e, c )
			end			
		elseif SameEventStrings( HEALEDSELFOTHER, arg1 ) and ( not SameEventStrings( HEALEDSELFSELF, arg1 ) ) then
		  if RPCONFIG.Debug then dcf("You heal") end
    		if ( a <= RPCONFIG.youheal["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.youheal["Delay"] ) then
				local s, e, c = GetPhrase( "youheal" )
				Roleplay( s, e, c )
			end
		end	
--=====================================================================--
-- You cast a spell with a cast time (not instant or channeled)

	-- "SPELLCAST_START"
	    -- For any spell that takes time to start (Channeling & Instant spells do not call this)
	    -- arg1=(Name of spell)  Summon Felsteed, Searing Pain, etc.
	    -- arg2=(Time of cast in 1000 of a sec)  1500 = 1.5 sec

--=====================================================================--
	elseif ( event == "SPELLCAST_START" ) then
		table.foreach( SPELLS.casttime[ string.upper(englishClass) ],
		
			-- Example: k = "ritual_of_summoning";  v = "Ritual of Summoning";
			---------------------------------------------------------------------------
			-- Shamans have "Heal" & "Lesser Heal" so we distinguish between them
            ---------------------------------------------------------------------------
			function(k,v)
				if arg1 == v then
					if ( a <= RPCONFIG[ k ]["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG[ k ]["Delay"] ) then
						local s, e, c = GetPhrase( k )
						Roleplay( s, e, c )
						if RPCONFIG.Debug then dcf("[arg1==v] k="..k.." v="..v.." arg1="..arg1) end
						RPStats.SPELL.rp = RPStats.SPELL.rp + 1  -- for statistics
						return
					end
			
			---------------------------------------------------------------------------
			-- If we can't find an exact match we see if the name is included
			-- Rogues have things like "Crippling Poison" & "Crippling Poison II"
			-- They go together.
            ---------------------------------------------------------------------------
				elseif string.find( arg1, v ) then
					if ( a <= RPCONFIG[ k ]["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG[ k ]["Delay"] ) then
						local s, e, c = GetPhrase( k )
						Roleplay( s, e, c )
						if RPCONFIG.Debug then dcf("[string.find] arg1="..arg1.." k="..k.." v="..v) end
						RPStats.SPELL.rp = RPStats.SPELL.rp + 1  -- for statistics
						return
					end
				end											
			end)
			
			---------------------------------------------------------------------------
			-- Check to see if we're mounting (considered a spellcast)
			-- Only checks for normal mounts, not summoned mounts (paladins and warlocks)
			-- (not included in statistics for now) 
            ---------------------------------------------------------------------------
			local i = 1
			while RPMOUNTS[i] do
                if ( RPMOUNTS[i] == arg1 ) then
                    RPH_MyMount = arg1
                    if RPCONFIG.Debug then dcf("Mounting: "..arg1) end
                    if ( a <= RPCONFIG.mount["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.mount["Delay"] ) then
                        local s, e, c = GetPhrase( "mount" )
                        Roleplay( s, e, c )
                    end
                end
                i = i + 1
            end
            
            ---------------------------------------------------------------------------
			-- Hearthstone
            ---------------------------------------------------------------------------            
            if (arg1 == "Hearthstone") then
                if RPCONFIG.Debug then dcf("Hearthstone activated") end
                if (a <= RPCONFIG.hearthstone["Chance"]) and (GetTime() - LastRP >= RPCONFIG.hearthstone["Delay"]) then
                    local s, e, c = GetPhrase("hearthstone")
                    Roleplay(s,e,c)
                end
            end
            
            ---------------------------------------------------------------------------
			-- Stormpike Insignia trinket for Alterac Valley
            ---------------------------------------------------------------------------
            if ( arg1 == "Recall" ) and ( GetRealZoneText() == "Alterac Valley" ) then
                if RPCONFIG.Debug then dcf("Alterac Valley trinket (Recall)") end
                if ( a <= RPCONFIG.av_recall["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.av_recall["Delay"] ) then
                    local s, e, c = GetPhrase( "av_recall")
                    Roleplay(s, e, c)
                end
            end

--=====================================================================--
-- When your pet starts attacking.
-- No args
-- UnitSex("pettarget") seems to go back to 0 right after the pet starts attacking or UnitSex("pettarget") is called
--=====================================================================--
    elseif ( event == "PET_ATTACK_START" ) then
        if RPCONFIG.Debug then dcf(event) end
    	if ( a <= RPCONFIG.petattackstart["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.petattackstart["Delay"] ) then	
	
			RPStats.PET_ATTACK_START.rp = RPStats.PET_ATTACK_START.rp + 1
	
			local s, e, c = GetPhrase( "petattackstart" )
			Roleplay( s, e, c )			
		end -- Delay & Chance

--=====================================================================--
-- When your pet stops attacking.
-- No args
--=====================================================================--
    elseif ( event == "PET_ATTACK_STOP" ) then
        if RPCONFIG.Debug then dcf(event) end
    	if ( a <= RPCONFIG.petattackstop["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.petattackstop["Delay"] ) then		   
			local s, e, c = GetPhrase( "petattackstop" )
			Roleplay( s, e, c )			
		end -- Delay & Chance
		
--=====================================================================--
-- When your pet dies
-- This happens before "PET_ATTACK_STOP"
-- so if there's a delay before "PET_ATTACK_STOP" everything should be alright
--=====================================================================--
   	elseif ( event == "CHAT_MSG_COMBAT_FRIENDLY_DEATH" ) then
   	    if arg1 and (UnitName("pet")) then
	   	    if string.find( arg1, (UnitName("pet")) ) then
	   	       if RPCONFIG.Debug then dcf("Pet died") end
    			if ( a <= RPCONFIG.petdies["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.petdies["Delay"] ) then	
					local s, e, c = GetPhrase( "petdies" )
					Roleplay( s, e, c )
				end -- Delay & Chance
			end
		end

--=====================================================================--
-- When you Resurrect,
-- Note: PLAYER_UNGHOST is fired when you Resurrect, Enter the Game, or Enter an Instance / Battlefield
--=====================================================================--
   	elseif ( event == "PLAYER_UNGHOST" ) then
   		if IsDead == true then
   		   if RPCONFIG.Debug then dcf(event.." from death") end
    		if ( a <= RPCONFIG.resurrect["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.resurrect["Delay"] ) then	
				local s, e, c = GetPhrase( "resurrect" )
				Roleplay( s, e, c )				
			end -- Delay & Chance
		end
		IsDead = false


--=====================================================================--
-- PLAYER_CAMPING
--=====================================================================--		
	elseif ( event == "PLAYER_CAMPING" ) then
	   if RPCONFIG.Debug then dcf(event) end
    	if ( a <= RPCONFIG.player_camping["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.player_camping["Delay"] ) then
			local s, e, c = GetPhrase( "player_camping" )
			Roleplay( s, e, c )	
		end

--=====================================================================--
-- PLAYER_LEVEL_UP
	-- arg1 = new level
--=====================================================================--		
	elseif ( event == "PLAYER_LEVEL_UP" ) then  
        if RPCONFIG.Debug then dcf(event) end
    	if ( a <= RPCONFIG.player_level_up["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.player_level_up["Delay"] ) then
			local s, e, c = GetPhrase( "player_level_up" )
			
			table.foreach(s, function(k,v)
				v = string.gsub( v, "LEVEL", arg1 )
				s[k] = v
			end)
			
			table.foreach(c, function(k,v)
				v = string.gsub( v, "LEVEL", arg1 )
				c[k] = v
			end)
			
			Roleplay( s, e, c )	
		end

--=====================================================================--
-- When you die
--=====================================================================--
   	elseif ( event == "PLAYER_DEAD" ) then
		IsDead = true
		
		RPHelper_EndCast = nil
		RPHelper_Target = nil
	    RPHelper_Spell = nil


--=====================================================================--
-- BEGINNING or MIDDLE of a CONVERSATION with an NPC

-- "GOSSIP_SHOW"	Example: Talking to a guard or the beginning of talking to an innkeeper.
-- "MERCHANT_SHOW"	When you first see a vendor's goods
-- "QUEST_GREETING"	When there is more than one quest available listed in a dialogue box (Current Quests / Available Quests)
-- "QUEST_PROGRESS"	When an NPC asks if you've finished your quest.
-- "QUEST_DETAIL" 	When Quest's Detail OPENS
-- "QUEST_COMPLETE"	When the window with the "Complete Quest" button OPENS
--=====================================================================--
	elseif  (( event == "GOSSIP_SHOW" ) or 
			( event == "MERCHANT_SHOW" ) or
			( event == "QUEST_GREETING" ) or
			( event == "QUEST_DETAIL" ) or 
			( event == "QUEST_COMPLETE" ) or  
			( event == "QUEST_PROGRESS" )) and 
			UnitExists("target") then

		if not RPTimerIsRunning and (not RPHelper_TalkingToNPC) then
			RPHelper_TalkingToNPC = true
	----------------------------------------------------------------------------------------------------------
	--  If your character hasn't met this NPC before, 1) you'll introduce yourself & 2) the NPC name will be saved to INTRODUCED
	----------------------------------------------------------------------------------------------------------
			local found = false
			local i = 1
			while INTRODUCED[i] do
				if (UnitName("target")) == INTRODUCED[i] then
					found = true
					if RPCONFIG.Debug then dcf("NPC met before, #"..i) end
				end
				i = i + 1
			end

			if found == false then 
				table.insert( INTRODUCED, (UnitName("target")) )
				if RPCONFIG.Debug then dcf("New NPC, let's introduce ourself") end
    			if ( a <= RPCONFIG.talktonpc_firsttime["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.talktonpc_firsttime["Delay"] ) then	
					local s, e, c = GetPhrase( "talktonpc_firsttime" )
					Roleplay( s, e, c )
				end
			else
	----------------------------------------------------------------------------------------------------------
	--  Beginning of Conversation
	----------------------------------------------------------------------------------------------------------						
    			if ( a <= RPCONFIG.talktonpc_beginning["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.talktonpc_beginning["Delay"] ) then	
					local s, e, c = GetPhrase( "talktonpc_beginning" )
					
					if UnitSex("player") == 1 then 		-- if the player is female
						table.insert( e,"CURTSEY" )
					end

					if UnitLevel("target") >= UnitLevel("player") + 5 then   -- if the NPC is 5 levels higher than you
				   		table.insert( e,"KNEEL" )
					end

					Roleplay( s, e, c )
				end
			end
	----------------------------------------------------------------------------------------------------------
	--  Middle of Conversation
	----------------------------------------------------------------------------------------------------------
		else -- if you are still talking to the same person (but different dialogue)
		if RPCONFIG.Debug then dcf("Still talking to NPC") end
    		if ( a <= RPCONFIG.talktonpc_middle["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.talktonpc_middle["Delay"] ) then				
				local s, e, c = GetPhrase( "talktonpc_middle" )
				Roleplay( s, e, c )
			end
			
			RPTimerIsRunning = false
			RPTimerFrame:Hide() -- Stop the Timer
		end -- if not RPTimerIsRunning and (not RPHelper_TalkingToNPC) then


--=====================================================================--
-- Either the END or a CONTINUATION of a CONVERSATION with an NPC

-- "GOSSIP_CLOSED" is called twice when closing a "gossip" box
-- QUEST_FINISHED when QUEST_DETAIL CLOSES & when QUEST_COMPLETE CLOSES
-- arg1 = mouse button pressed to close the window -or- nil if no button was used
	
-- Other windows such as "Merchant" or "Quest" windows can open immediately after this event,
-- but you're still talking to the same person so Emotes like "BYE" are not appropriate
--=====================================================================--
	elseif  ( event == "GOSSIP_CLOSED" ) or
			( event == "MERCHANT_CLOSED" ) or
			( event == "QUEST_FINISHED" ) then
		RPHelper_TalkingToNPC = false
		RPNumFrames = 0
		RPTimerIsRunning = true
		RPTimerFrame:Show()
		if RPCONFIG.Debug then dcf(event) end
		
--=====================================================================--
-- Trading with other Players
-- "TRADE_SHOW" is called when a trade window opens after agreeing to a trade
-- "TRADE_CLOSED" is called when the trade window closes after a trade or a cancel
--=====================================================================--
-- TRADE_SHOW
    elseif ( event == "TRADE_SHOW" ) and ( UnitExists("target") ) and ( UnitIsPlayer("target") ) then
        if RPCONFIG.Debug then dcf(event) end
        if (a <= RPCONFIG.trade_show["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.trade_show["Delay"] ) then
            local s, e, c = GetPhrase( "trade_show" )
            if UnitSex("player") == 1 then 		-- if the player is female
		      table.insert( e,"CURTSEY" )
		  end

            Roleplay( s, e, c )
        end
    
-- TRADE_CLOSED
    elseif ( event == "TRADE_CLOSED" ) and ( UnitExists("target") ) and ( UnitIsPlayer("target") ) then
        if RPCONFIG.Debug then dcf(event) end
        if ( a <= RPCONFIG.trade_closed["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.trade_closed["Delay"] ) then
            local s, e, c = GetPhrase( "trade_closed" )
            Roleplay( s, e, c )
        end

--=====================================================================--
-- Check for instance / battleground
--=====================================================================--
    elseif (event == "PLAYER_ENTERING_WORLD") then
        local x,y = GetPlayerMapPosition("player")
        if (x == 0) and (y == 0) then
            if RPCONFIG.Debug then dcf("Entered Instance") end
        end
        local status, mapName, instanceID, minlevel, maxlevel;
        for i=1, MAX_BATTLEFIELD_QUEUES do
            status, mapName, instanceID, minlevel, maxlevel = GetBattlefieldStatus(i);
            if RPCONFIG.Debug then dcf(mapName.."(".. status..")"..instanceID) end
        end
--======================================================================--
-- Zone Change
--======================================================================--
    elseif ( event == "ZONE_CHANGED_NEW_AREA" ) then
        if (GetRealZoneText() == GetBindLocation()) then
            if RPCONFIG.Debug then dcf("Zoned into hearthstone location") end
            if ( a <= RPCONFIG.welcome_home["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.welcome_home["Delay"] ) then
                local s, e, c = GetPhrase("welcome_home")
                Roleplay(s, e, c)
                RPStats.EVENT.rp = RPStats.EVENT.rp + 1  -- for statistics
            end
        end

--======================================================================--
-- Miscellaneous (CHAT_MSG_SYSTEM)
--======================================================================--
    elseif ( event == "CHAT_MSG_SYSTEM" ) then
        if (SameEventStrings(ERR_LEARN_ABILITY_S, arg1)) or (SameEventStrings(ERR_LEARN_RECIPE_S, arg1)) or (SameEventStrings(ERR_LEARN_SPELL_S, arg1)) then
            if RPCONFIG.Debug then dcf("Learned New") end
            if ( a <= RPCONFIG.learn["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.learn["Delay"] ) then
                local s, e, c = GetPhrase( "learn" )
                Roleplay( s, e, c )
                RPStats.EVENT.rp = RPStats.EVENT.rp + 1  -- for statistics
            end
        elseif (SameEventStrings(DRUNK_MESSAGE_SELF2, arg1)) or (SameEventStrings(DRUNK_MESSAGE_SELF3, arg1)) or (SameEventStrings(DRUNK_MESSAGE_SELF4, arg1)) then
            if RPCONFIG.Debug then dcf("Drinking") end
            if ( a <= RPCONFIG.drunk["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.drunk["Delay"] ) then
                local s, e, c = GetPhrase( "drunk" )
                Roleplay( s, e, c )
                RPStats.EVENT.rp = RPStats.EVENT.rp + 1  -- for statistics
            end
        elseif (SameEventStrings(DRUNK_MESSAGE_SELF1, arg1)) then
            if RPCONFIG.Debug then dcf("Getting Sober") end
            if ( a <= RPCONFIG.sober["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.sober["Delay"] ) then
                local s, e, c = GetPhrase( "sober" )
                Roleplay( s, e, c )
                RPStats.EVENT.rp = RPStats.EVENT.rp + 1  -- for statistics
            end
        elseif (SameEventStrings(ERR_DEATHBIND_SUCCESS_S, arg1)) then
            if RPCONFIG.Debug then dcf("Set new home for hearthstone") end
            if ( a <= RPCONFIG.new_home["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.new_home["Delay"] ) then
                local s, e, c = GetPhrase( "new_home" )
                Roleplay( s, e, c )
                RPStats.EVENT.rp = RPStats.EVENT.rp + 1  -- for statistics
            end
        elseif (SameEventStrings(ERR_EXHAUSTION_NORMAL,arg1)) then
            if RPCONFIG.Debug then dcf("Rest bonus expired") end
            if ( a <= RPCONFIG.exhausted["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.exhausted["Delay"] ) then
                local s, e, c = GetPhrase("exhausted")
                Roleplay(s, e, c)
                RPStats.EVENT.rp = RPStats.EVENT.rp + 1  -- for statistics
            end
        

        
        end

--=====================================================================--
-- Monster Emotes
--=====================================================================--
    elseif ( event == "CHAT_MSG_MONSTER_EMOTE" ) then
        -- general emotes, let's make sure we're targetting them first
        if ( arg2 == (UnitName("target")) ) then -- are we targetting the unit(name) emoting?
        -- calls for help
            if ( arg1 == "%s calls for help!" ) then
                if RPCONFIG.Debug then dcf("MobEmote: Calls for Help") end
                if ( a <= RPCONFIG.monster_emote_help["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.monster_emote_help["Delay"] ) then
                    local s, e, c = GetPhrase( "monster_emote_help" )
                    Roleplay( s, e, c )
                end
        -- runs in fear
            elseif ( arg1 == "%s attempts to run away in fear!") then
                if RPCONFIG.Debug then dcf("MobEmote: Runs in Fear") end
                if ( a <= RPCONFIG.monster_emote_fear["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.monster_emote_fear["Delay"] ) then
                    local s, e, c = GetPhrase( "monster_emote_fear" )
                    Roleplay( s, e, c )
                end
        -- becomes enraged
            elseif ( arg1 == "%s becomes enraged!" ) then
                if RPCONFIG.Debug then dcf("MobEmote: Becomes Enraged") end
                if ( a <= RPCONFIG.monster_emote_enrage["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.monster_emote_enrage["Delay"] ) then
                    local s, e, c = GetPhrase( "monster_emote_enrage" )
                    Roleplay( s, e, c )
                end
            end
        -- special/rare emotes, we'll target for the RP then switch back
        -- BRD Slaves
        elseif (arg2 == "Slave") or (arg2 == "Tortured Slave") then
            if RPCONFIG.Debug then dcf("BRD Slave emote") end
            if ( a <= RPCONFIG.brd_emote_slave["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.brd_emote_slave["Delay"] ) then
                local s, e, c = GetPhrase( "brd_emote_slave" )
                TargetByName(arg2)
                Roleplay( s, e, c )
                TargetLastTarget()
            end
        -- WPL Scourge Cauldrons (can't target these)
        elseif (arg2 == "The Scourge Cauldron") then
            if RPCONFIG.Debug then dcf("Scourge Cauldron! Chance="..RPCONFIG.scourge_cauldron["Chance"].." Roll="..a) end
            if (a <= RPCONFIG.scourge_cauldron["Chance"]) and (GetTime() - LastRP >= RPCONFIG.scourge_cauldron["Delay"]) then
                local s, e, c = GetPhrase("scourge_cauldron")
                Roleplay(s,e,c)
            end
        end -- end of chat_msg_monster_emote
-- EPL Tower capture
    elseif ( event == "CHAT_MSG_CHANNEL" and string.find(arg1,"has been taken by the") and arg9 == "LocalDefense - Eastern Plaguelands" ) then
        local englishFaction, playerFaction = UnitFactionGroup("player");
        if RPCONFIG.Debug then dcf("EPL: Tower Capture") end
        if (string.find(arg1, englishFaction)) then
        if RPCONFIG.Debug then dcf("EPL: Capture by Own Faction ("..englishFaction..")") end
            if ( a <= RPCONFIG.epl_pvp_tower_capture["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.epl_pvp_tower_capture["Delay"] ) then
                local s, e, c = GetPhrase( "epl_pvp_tower_cap" )
                Roleplay( s, e, c )
                RPStats.EVENT.rp = RPStats.EVENT.rp + 1  -- for statistics
            end
        elseif ( a <= RPCONFIG.epl_pvp_tower_lose["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.epl_pvp_tower_lose["Delay"] ) then
                local s, e, c = GetPhrase( "epl_pvp_tower_lose" )
                Roleplay( s, e, c )
                RPStats.EVENT.rp = RPStats.EVENT.rp + 1  -- for statistics
        end

-- Battlegrounds    
    elseif ( event == "CHAT_MSG_BG_SYSTEM_NEUTRAL" ) then
        local bg = GetRealZoneText()
        if ( arg1 == "The battle for Arathi Basin has begun!" ) or ( arg1 == "The battle for Alterac Valley has begun!" ) or ( arg1 == "Let the battle for Warsong Gulch begin!" ) then
            if RPCONFIG.Debug then dcf("Battleground started: "..bg) end
            if ( a <= RPCONFIG.bg_begin["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.bg_begin["Delay"] ) then
                local s, e, c = GetPhrase("bg_begin")
                Roleplay(s, e, c)
                RPStats.EVENT.rp = RPStats.EVENT.rp + 1  -- for statistics
            end
        end
        
        if string.find(arg1, "and is near victory!") then
            local englishFaction, playerFaction = UnitFactionGroup("player");
            if string.find(arg1, englishFaction) then
                if RPCONFIG.Debug then dcf("Arathi Basin: 1800 Resources") end
            end
        end
        
        

--=====================================================================--
-- For capturing SPELL CASTS
	-- SPELLCAST_STOP is called before SPELLCAST_INTERRUPTED with a casttime spell.
--=====================================================================--
	elseif event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED" then

--	dcf( event )

		if RPHelper_EndCast then
	    	RPHelper_EndCast = nil
	       	RPHelper_Target = nil
	       	RPHelper_Spell = nil
	   	end

   -- This fires when a spell is completed casting, or you double escape a targeting spell
   	elseif event == "SPELLCAST_STOP" then

--	dcf( event )

   		if RPHelper_EndCast then

  -- 		dcf( "RPHelper_EndCast OK" )

			if PlaceInArray( RPCONFIG.traits, englishClass ) then -- Check if we're using the wordlist for your class
				Non_Casttime_Spells = {}
                RPHelper_Join_Entire_Tables( Non_Casttime_Spells, SPELLS.instant[ string.upper(englishClass) ] )
                RPHelper_Join_Entire_Tables( Non_Casttime_Spells, SPELLS.next_melee[ string.upper(englishClass) ] )
                RPHelper_Join_Entire_Tables( Non_Casttime_Spells, SPELLS.channeled[ string.upper(englishClass) ] )
   
				table.foreach( Non_Casttime_Spells,
					-- Example: k = "heroic_strike";  v = "Heroic Strike";
					function(k,v)
						if string.find( RPHelper_EndCast, v ) then
    						if ( a <= RPCONFIG[ k ]["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG[ k ]["Delay"] ) then	
								local s, e, c = GetPhrase( k )
								Roleplay( s, e, c )
								RPStats.SPELL.rp = RPStats.SPELL.rp + 1  -- for statistics
							end
							return
						end
					end)
   			end

	       	RPHelper_EndCast = nil
	       	RPHelper_Target = nil
	       	RPHelper_Spell = nil
		end

	end	-- of event occurance


----------------------------------------------------------------------------------------------------------------------------
--  Getting Time of the RP
----------------------------------------------------------------------------------------------------------------------------

	if JustRPed == true then
		LastRP = GetTime()
		JustRPed = false
        RPedAtLeastOnce = true
	end

--[[
--=====================================================================--
-- When a friendly unit dies.
--=====================================================================--
    if ( event == "CHAT_MSG_COMBAT_FRIENDLY_DEATH" ) then
   		local x = { "You will be avenged!","Nooo!","You bastard! That's my friend you killed!","I failed to protect you my friend." }

   		local y = math.random(table.getn(x))
		SendChatMessage(x[y])
   	end
]]


--=====================================================================--
-- debug
--=====================================================================--
	if RPCONFIG.Debug and RPHelper_Debug_Events then
		table.foreach( RPHelper_Debug_Events, function(k,v)
			if  ( event == v ) then
				local x = event
		 		if arg1 then		x = x .. " arg1=" .. arg1;			end
		 		if arg2 then		x = x .. " arg2=" .. arg2;			end
		 		if arg3 then		x = x .. " arg3=" .. arg3;			end
		 		if arg4 then		x = x .. " arg4=" .. arg4;			end
		 		if arg5 then		x = x .. " arg5=" .. arg5;			end
		 		if arg6 then		x = x .. " arg6=" .. arg6;			end
		 		if arg7 then		x = x .. " arg7=" .. arg7;			end
		 		if arg8 then		x = x .. " arg8=" .. arg8;			end
		 		if arg9 then		x = x .. " arg9=" .. arg9;			end
				--DEFAULT_CHAT_FRAME:AddMessage( x, 0.4, 1.0, 0.6 )
				dcf(x)
			end
		end)
	end




end -- function RP_OnEvent(event)






function EndOfConversationWithNPC()
    if RPCONFIG.Debug then dcf("End of Conversation with NPC") end
	----------------------------------------------------------------------------------------------------------
	--  End of Conversation
	----------------------------------------------------------------------------------------------------------
	if not UnitOnTaxi("player") then
        DoEmote("STAND")
        if RPCONFIG.Debug then dcf("DoEmote(STAND)") end
    end
	if UnitExists("target") then
		local a = math.random()
    	if ( a <= RPCONFIG.talktonpc_end["Chance"] ) and ( GetTime() - LastRP >= RPCONFIG.talktonpc_end["Delay"] ) then	
			
			local s, e, c = GetPhrase( "talktonpc_end" )
			if not UnitOnTaxi("player") then
                if UnitSex("player") == 1 then 		-- if the player is female
				    table.insert( e,"CURTSEY" )
                end
			end
            -- TODO: if UnitOnTaxi remove BOW,CURTSEY, etc. unable to do mounted
			Roleplay( s, e, c )

        	LastRP = GetTime()
			JustRPed = false
        	RPedAtLeastOnce = true
		end			
	end -- if UnitExists("target")
end



--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- FUNCTIONS FOR CATCHING SPELL CASTS

-- original code from: http://www.wowwiki.com/HOWTO:_Detect_Instant_Cast_Spells
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- This will contain the spell that is waiting to be targeted
RPHelper_Spell = nil
-- This will contain the spell that has been cast and targeted and is awaiting a SPELLCAST_STOP
RPHelper_EndCast = nil
-- This contains the target of the current spell being casting
RPHelper_Target = nil


-- This function catches spells when cast from the spell book
RPHelper_oldCastSpell = CastSpell;
function RPHelper_newCastSpell(spellId, spellbookTabNum)

--	dcf( "CastSpell" )
	
   -- Call the original function so there's no delay while we process
   RPHelper_oldCastSpell(spellId, spellbookTabNum)

   -- Load the tooltip with the spell information
   RPHelper_Tooltip:SetSpell(spellId, spellbookTabNum)

   local spellName = RPHelper_TooltipTextLeft1:GetText()

   if SpellIsTargeting() then
       -- Spell is waiting for a target
       RPHelper_Spell = spellName
   else
       -- Spell is being cast on the current target.
       -- If ClearTarget() had been called, we'd be waiting target
       RPHelper_EndCast = spellName
       RPHelper_Target = (UnitName("target"))		-- nil if no target
   end
end
CastSpell = RPHelper_newCastSpell



RPHelper_oldCastSpellByName = CastSpellByName;
function RPHelper_newCastSpellByName(spellName)

--	dcf( "CastSpellByName" )


   -- Call the original function
   RPHelper_oldCastSpellByName(spellName)

   -- This will give us the full spellname, including Rank.
   -- This can be filtered out quite easily
   local spellName = spellName

   if SpellIsTargeting() then
       -- Spell is waiting for a target
       RPHelper_Spell = spellName
   else
       -- Spell is being cast on the current target
       RPHelper_EndCast = spellName
       RPHelper_Target = (UnitName("target"))
   end
end
CastSpellByName = RPHelper_newCastSpellByName



RPHelper_oldUseAction = UseAction
function RPHelper_newUseAction(a1, a2, a3)

--	dcf( "UseAction" )


   -- Call the original function
   RPHelper_oldUseAction(a1, a2, a3)

   -- Test to see if this is a macro
   if GetActionText(a1) then return end

   RPHelper_Tooltip:SetAction(a1)
   local spellName = RPHelper_TooltipTextLeft1:GetText()
   
--   dcf( "a1="..a1 )  -- a1 is the slot number
--[[   
   if spellName then
   		dcf( spellName )
	else
		dcf( "No spellName" )
	end
]]   
   if SpellIsTargeting() then
       -- Spell is waiting for a target
       RPHelper_Spell = spellName
   else
       -- Spell is being cast on the current target
       RPHelper_EndCast = spellName
       RPHelper_Target = (UnitName("target"))
   end
end
UseAction = RPHelper_newUseAction



RPHelper_oldSpellTargetUnit = SpellTargetUnit
function RPHelper_newSpellTargetUnit(unit)

--	dcf( "SpellTargetUnit" )
	
   -- Call the original function
   RPHelper_oldSpellTargetUnit(unit)

   -- Look to see if we're currently waiting for a target internally
   -- If we are, then well glean the target info here.

   if RPHelper_Spell then
       -- Currently casting.. lets grab the target
       RPHelper_EndCast = RPHelper_Spell
       RPHelper_Target = (UnitName(unit))

       -- Clear RPHelper_Spell so we can wait for SPELLCAST_STOP
       RPHelper_Spell = nil
   end
end
SpellTargetUnit = RPHelper_newSpellTargetUnit



RPHelper_oldTargetUnit = TargetUnit
function RPHelper_newTargetUnit(unit)

--	dcf( "TargetUnit" )

   -- Call the original function
   RPHelper_oldTargetUnit(unit)

   -- Look to see if we're currently waiting for a target internally
   -- If we are, then well glean the target info here.
   
   if RPHelper_Spell then
       -- Currently casting.. lets grab the target
       RPHelper_EndCast = RPHelper_Spell
       RPHelper_Target = (UnitName(unit))

       -- Clear RPHelper_Spell so we can wait for SPELLCAST_STOP
       RPHelper_Spell = nil
   end
end
TargetUnit = RPHelper_newTargetUnit



RPHelper_oldSpellStopTargeting = SpellStopTargeting  -- fixed:  added "old" before "SpellStopTargeting"
function RPHelper_newSpellStopTargeting()

--	dcf( "SpellStopTargeting" )

   RPHelper_oldSpellStopTargeting()

   if RPHelper_Spell then
       RPHelper_Spell = nil
       RPHelper_EndCast = nil
       RPHelper_Target = nil
   end
end
SpellStopTargeting = RPHelper_newSpellStopTargeting



--[[
RPHelper_oldCameraOrSelectOrMoveStart = CameraOrSelectOrMoveStart
function RPHelper_newCameraOrSelectOrMoveStart()
   -- If we're waiting to target

   local targetName = nil

   if RPHelper_Spell and (UnitName("mouseover") then)
       targetName = (UnitName("mouseover"))
   end

   RPHelper_oldCameraOrSelectOrMoveStart();

   if RPHelper_Spell then
       RPHelper_EndCast = RPHelper_Spell
       RPHelper_Target = targetName
       RPHelper_Spell = nil
   end
end
CameraOrSelectOrMoveStart = RPHelper_newCameraOrSelectOrMoveStart
]]




-- DEBUG (Notes for the future)

	-- SendChatMessage("is sending an emote.", "EMOTE")

    -- "SPELLCAST_STOP"
        -- seems to have no args
    
		-- When a timed spell cast stops
		-- When an instant spell is cast
		-- When a channeled spell starts
		-- When a channeled spell stops

	-- "START_AUTOREPEAT_SPELL"
	    -- no args found
	    
	    -- Shoot (with wand) called this spell

	-- "UNIT_COMBAT"
		-- arg1=player/target/pet
		-- arg2=WOUND/PARRY/DODGE/HEAL
		-- arg3=CRITICAL/GLANCING
		-- arg4=# (damage)
		-- arg5=0,3,6 ?????

	-- "CHAT_MSG_MONSTER_YELL"
		-- arg1=Orcs are smarter than those couriers! Where the blazes are they?	(Text of MSG)
		-- arg2=Privateer Groy		(NPC yelling)
		-- arg3=Common				(Language)
		-- arg7=0
		-- arg8=0
		
	-- "CHAT_MSG_EMOTE"
		-- arg1=(Text after the name)
		-- arg2=Atiqual							(Person saying emote)
		-- arg7=0
		-- arg8=0
		
	-- "CHAT_MSG_TEXT_EMOTE"
		-- arg1=You say a prayer for Deer.		(Text you see)
		-- arg2=Atiqual							(Person saying emote)
		-- arg7=0
		-- arg8=0

    -- "CHAT_MSG_COMBAT_FRIENDLY_DEATH"
    -- This is called before PET_ATTACK_STOP
		-- arg1=You die.
		-- arg1="petname" dies.
		-- arg1="friendly name" dies.
		-- arg7=0
		-- arg8=0

    -- "CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS"
	-- this is not called for "Party"/"Raid" members.  Only other friendlies around you.
		-- arg1=[friendly name] hits [enemy] for #.
		-- arg1=[friendly name] crits [enemy] for #.
		-- arg1=[Nearby friendly] falls and loses # health.
		-- arg1=[friendly name] suffers 10 points of fire damage.
		-- arg7=0
		-- arg8=0
		
    -- "PLAYER_LEVEL_UP"
		-- arg1=Your new level
		-- arg2-9=other stuff
				
    -- "UPDATE_EXHAUSTION"
    -- happened after I killed something.
		-- arg1=player
				
    -- "CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS"
		-- arg1=[Nearby friendly] hits [Nearby enemy] for #.
		-- arg7=0
		-- arg8=0


	-- "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE"
	-- "Attacker"'s "Spell name" hits (you/"pet name") for # "Spell type [ex: Nature damage]".
	-- "Attacker"'s "Spell name" was resisted.
	-- You absorb "Attacker"'s "Spell name"

	-- "CHAT_MSG_COMBAT_PARTY_MISSES"
    	-- arg1="(friendname) misses (enemyname)."
    	-- arg1="(friendname) attacks.  (enemyname) dodges." 
    	-- arg7 & arg8 = 0
    
	-- "CHAT_MSG_COMBAT_PARTY_HITS"
    	-- arg1="(friendname) hits (enemyname) for #"
    	-- arg1="(friendname) crits (enemyname) for #" 
    	-- arg7 & arg8 = 0
    
	-- "CHAT_MSG_COMBAT_FRIENDLYPLAYER_HITS"
    	-- arg1="(friendname) hits (enemyname) for #"
    	-- arg1="(friendname) crits (enemyname) for #" 
    	-- arg1="(friendname) suffers # points of fire damage."
    	-- arg7 & arg8 = 0

	-- "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS"
	-- "player/party member" falls and loses "number" health.
	-- "party member" suffers # points of fire damage.
	-- "hostileplayer name" hits "friendly name" for #.

	-- TRADE_SHOW shows when you trade with another player and the trade window shows


--[[
RPHelper_DebugPhrases = {
	"Pet name: PNAME",

	"Pet target: PTNAME",
	"Pet target subject pronoun: PTSP",
	"Pet target object pronoun: PTOP",
	"Pet target possessive pronoun: PTPP",

	"My Name: PLAYER",
	"My subject pronoun: SP",
	"My object pronoun: OP",
	"My possessive pronoun: PP",
	"My Guild: PLAYER_GUILDNAME",
	"My Guild rank: PLAYER_GUILDRANK',

	"My target: TARGET",
	"My target subject pronoun: TSP",
	"My target object pronoun: TOP",
	"My target possessive pronoun: TPP",

    "My home: HOME",
    
    "Current zone: ZONE",
    
	"Random Insult: RINSULT",

	}
]]

