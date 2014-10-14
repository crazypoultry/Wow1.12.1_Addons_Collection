--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- FUNCTION FOR CHANGING OPTIONS
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function RP_SlashCommands( cmd )
 	if ( ( not cmd ) or ( strlen( cmd ) <= 0 ) or ( string.lower(cmd) == "help" ) ) then
	    ShowUIPanel(RPConfigFrame)
	else

	local command, params = RP_Extract_NextParameter( cmd );

	command = string.lower( command )
	params = string.lower( params )
-------------------------------------------------------------------------
-- /rph on
-------------------------------------------------------------------------
        if ( command == "on" ) then
			if RPCONFIG.on then
				DEFAULT_CHAT_FRAME:AddMessage( "RPHelper is already on.", 0.0, 1.0, 1.0  )
			else
			    RPCONFIG.on = true
   				DEFAULT_CHAT_FRAME:AddMessage( "RPHelper is now turned on.", 0.0, 1.0, 1.0  )
			end
			DEFAULT_CHAT_FRAME:AddMessage( "---------------------------------------------------------", 1.0, 0.5, 0.5    )

	    	local sec, min, hour = ParseTime( GetTime() - LastRP )
	  		if hour >= 1 then
				DEFAULT_CHAT_FRAME:AddMessage( "Last RP was: " .. hour .. "h " .. min .. "m " .. sec .. "s ago.", 1.0, 1.0, 0.4 )
			elseif min >= 1 then
				DEFAULT_CHAT_FRAME:AddMessage( "Last RP was: " .. min .. "min " .. sec .. "sec ago.", 1.0, 1.0, 0.4 )
			else
				DEFAULT_CHAT_FRAME:AddMessage( "Last RP was: " .. sec .. "sec ago.", 1.0, 1.0, 0.4 )
			end
-------------------------------------------------------------------------
-- /rph off
-------------------------------------------------------------------------
		elseif ( command == "off" ) then
		    if RPCONFIG.on then
			    RPCONFIG.on = false
          		DEFAULT_CHAT_FRAME:AddMessage( "RPHelper is now off.", 0.0, 1.0, 1.0 )
			else
          		DEFAULT_CHAT_FRAME:AddMessage( "RPHelper is already off.", 0.0, 1.0, 1.0  )
			end
			
		elseif (command == "toggle") then
		  RPH:Toggle()
		  
-------------------------------------------------------------------------
-- /rph i(nsult)
-------------------------------------------------------------------------
	    elseif ( command == "insult" ) or ( command == "i" ) then
	        if RandInsult() then
				SendChatMessage(RandInsult())
			else
			    DEFAULT_CHAT_FRAME:AddMessage( "You don't have RInsult.lua setup properly to insult with your RP traits: " .. table.concat( RPCONFIG.traits, ", " ), 0,1,1 )
			end
-------------------------------------------------------------------------
-- /rph ip (When you want to point at what you're insulting)
-------------------------------------------------------------------------
		elseif ( command == "ip" ) then
			if RandInsult() then
				SendChatMessage(RandInsult())
				if UnitExists("target") then
					DoEmote("POINT")
				end
			else
			    DEFAULT_CHAT_FRAME:AddMessage( "RInsult.lua is not setup properly to insult with your RP traits: " .. table.concat( RPCONFIG.traits, ", " ), 0,1,1 )
			end
-------------------------------------------------------------------------
-- /rph e(mote)
-------------------------------------------------------------------------
        elseif ( command == "emote" ) or ( command == "e" ) then
            if RandInsultEmote() then
                SendChatMessage(RandInsultEmote(),"EMOTE")
            else
                DEFAULT_CHAT_FRAME:AddMessage( "REmote.lua is not setup properly to insult with your RP traits: " .. table.concat ( RPCONFIG.traits, ", " ), 0,1,1 )
            end
-------------------------------------------------------------------------
-- /rph d(efault)
-------------------------------------------------------------------------
		elseif ( command == "default" ) or ( command == "d" ) then
			RPDefaults( "all" )
			DEFAULT_CHAT_FRAME:AddMessage( "All settings are now at their default settings.", 0,1,1 )	
-------------------------------------------------------------------------
-- /rph time
-------------------------------------------------------------------------
	    elseif ( command == "time" ) then

	    	local sec, min, hour = ParseTime( GetTime() - LastRP )
	  		if hour >= 1 then
				DEFAULT_CHAT_FRAME:AddMessage( "Last RP was: " .. hour .. "h " .. min .. "m " .. sec .. "s ago.", 0.4, 1.0, 0.6 )
			elseif min >= 1 then
				DEFAULT_CHAT_FRAME:AddMessage( "Last RP was: " .. min .. "min " .. sec .. "sec ago.", 0.4, 1.0, 0.6 )
			else
				DEFAULT_CHAT_FRAME:AddMessage( "Last RP was: " .. sec .. "sec ago.", 0.4, 1.0, 0.6 )
			end

--[[			if ( GetTime() - LastRP > GlobalDelay ) then  -- GlobalDelay undefined
				DEFAULT_CHAT_FRAME:AddMessage( "You now have a " .. SaySomethingChance * 100 .. "% chance to RP" , 0.4, 1.0, 0.6  )
			else
				DEFAULT_CHAT_FRAME:AddMessage( "You have to wait " .. math.ceil(GlobalDelay - (GetTime() - LastRP)) .. "sec before your ".. SaySomethingChance * 100 .. "% chance to RP" , 0.4, 1.0, 0.6  )
			end
]]
-------------------------------------------------------------------------
-- /rph c(hance) [number]
-------------------------------------------------------------------------
--[[	    elseif ( command == "chance" ) or ( command == "c" ) then
	    	if params == "" then
				DEFAULT_CHAT_FRAME:AddMessage( "Chance to say something on an event after the " .. GlobalDelay .. "sec delay: " .. SaySomethingChance * 100 .. "%", 0.4, 1.0, 0.6  )
				if SaySomethingChance >= 1 then
					DEFAULT_CHAT_FRAME:AddMessage( "(You'll say something every possible event)", 0.4, 1.0, 0.6 )
				elseif SaySomethingChance == 0 then
                    DEFAULT_CHAT_FRAME:AddMessage( "(You won't role play on any event.)", 0.4, 1.0, 0.6 )
				else
					DEFAULT_CHAT_FRAME:AddMessage( "(Once every " .. Round(1/SaySomethingChance) .. " events)", 0.4, 1.0, 0.6 )
				end
			elseif tonumber(params) == nil then
				DEFAULT_CHAT_FRAME:AddMessage( params .. " is not a valid number.", 0.4, 1.0, 0.6  )
			elseif (tonumber(params) < 0) or (tonumber(params) > 1) then
				DEFAULT_CHAT_FRAME:AddMessage( "Your number must be between 0 and 1", 0.4, 1.0, 0.6  )
			else
				SaySomethingChance = tonumber(params)
				DEFAULT_CHAT_FRAME:AddMessage( "Chance to say something on an event after the " .. GlobalDelay .. "sec delay is now: " .. SaySomethingChance * 100 .. "%", 0.4, 1.0, 0.6  )
				if SaySomethingChance >= 1 then
					DEFAULT_CHAT_FRAME:AddMessage( "(You'll say something every possible event)", 0.4, 1.0, 0.6 )
				elseif SaySomethingChance == 0 then
                    DEFAULT_CHAT_FRAME:AddMessage( "(You won't role play on any event.)", 0.4, 1.0, 0.6 )
				else
					DEFAULT_CHAT_FRAME:AddMessage( "(Once every " .. Round(1/SaySomethingChance) .. " events)", 0.4, 1.0, 0.6 )
				end
			end
-------------------------------------------------------------------------
-- /rph config
-------------------------------------------------------------------------
	    elseif ( command == "config" ) then
			DEFAULT_CHAT_FRAME:AddMessage( "               Roleplaying Helper Config                 ", 0.0, 1.0, 1.0  )
			DEFAULT_CHAT_FRAME:AddMessage( "---------------------------------------------------------", 1.0, 0.5, 0.5    )
			DEFAULT_CHAT_FRAME:AddMessage( "Chance to say something on an event: " .. SaySomethingChance * 100 .. "%", 1.0, 1.0, 0.4  )
			DEFAULT_CHAT_FRAME:AddMessage( "Delay between event chances: " .. GlobalDelay .. "sec.", 1.0, 1.0, 0.4 )

	    	local sec, min, hour = ParseTime( GetTime() - LastRP )
	  		if hour >= 1 then
				DEFAULT_CHAT_FRAME:AddMessage( "Last RP was: " .. hour .. "h " .. min .. "m " .. sec .. "s ago.", 1.0, 1.0, 0.4 )
			elseif min >= 1 then
				DEFAULT_CHAT_FRAME:AddMessage( "Last RP was: " .. min .. "min " .. sec .. "sec ago.", 1.0, 1.0, 0.4 )
			else
				DEFAULT_CHAT_FRAME:AddMessage( "Last RP was: " .. sec .. "sec ago.", 1.0, 1.0, 0.4 )
			end

            if ( GetTime() - LastRP < GlobalDelay ) then
				DEFAULT_CHAT_FRAME:AddMessage( "You have to wait " .. math.ceil(GlobalDelay - (GetTime() - LastRP)) .. "sec before your ".. SaySomethingChance * 100 .. "% chance to RP" , 1.0, 1.0, 0.4  )
			end
]]
-------------------------------------------------------------------------
-- /rph s(tats)
-------------------------------------------------------------------------
	    elseif ( command == "stat" ) or ( command == "s" ) or ( command == "stats" ) then
            local met = table.getn(INTRODUCED)
			DEFAULT_CHAT_FRAME:AddMessage( "               Roleplaying Helper Stats                  ", 0.0, 1.0, 1.0  )
			DEFAULT_CHAT_FRAME:AddMessage( "---------------------------------------------------------", 1.0, 0.5, 0.5    )
			DEFAULT_CHAT_FRAME:AddMessage( "Times when your character Roleplayed:", 1.0, 1.0, 0.4  )
			DEFAULT_CHAT_FRAME:AddMessage( "Attacked but not hurt: "..RPStats.CREATURE_VS_SELF_MISSES.rp, 1.0, 1.0, 0.4 )
			DEFAULT_CHAT_FRAME:AddMessage( "Hurt in combat: "..RPStats.GETHURT.rp, 1.0, 1.0, 0.4  )
			DEFAULT_CHAT_FRAME:AddMessage( "Cast a spell or talent: "..RPStats.SPELL.rp, 1.0, 1.0, 0.4 )
			DEFAULT_CHAT_FRAME:AddMessage( "React to a special event: "..RPStats.EVENT.rp, 1.0, 1.0, 0.4 )
			DEFAULT_CHAT_FRAME:AddMessage( "Pet attacked: "..RPStats.PET_ATTACK_START.rp, 1.0, 1.0, 0.4 )
			DEFAULT_CHAT_FRAME:AddMessage( "Monster or NPC spoke: "..RPStats.MONSTER_SAY.rp, 1.0, 1.0, 0.4 )
			if not (met == 0) then
                DEFAULT_CHAT_FRAME:AddMessage( "You have met "..met.." NPC's", 1.0, 1.0, 0.4 )
                DEFAULT_CHAT_FRAME:AddMessage( "Recently introduced to: "..INTRODUCED[met], 1.0, 1.0, 0.4 )
			end

	    	local sec, min, hour = ParseTime( GetTime() - LastRP )
	  		if hour >= 1 then
				DEFAULT_CHAT_FRAME:AddMessage( "Last RP was: " .. hour .. "h " .. min .. "m " .. sec .. "s ago.", 1.0, 1.0, 0.4 )
			elseif min >= 1 then
				DEFAULT_CHAT_FRAME:AddMessage( "Last RP was: " .. min .. "min " .. sec .. "sec ago.", 1.0, 1.0, 0.4 )
			else
				DEFAULT_CHAT_FRAME:AddMessage( "Last RP was: " .. sec .. "sec ago.", 1.0, 1.0, 0.4 )
			end
-------------------------------------------------------------------------
-- /rph [trait]
-------------------------------------------------------------------------
	    elseif  ( command == "dwarf" ) or
				( command == "gnome" ) or
				( command == "human" ) or
				( command == "nightelf" ) or
				( command == "orc" ) or
				( command == "tauren" ) or
				( command == "troll" ) or
				( command == "undead" ) or
				( command == "druid" ) or
				( command == "hunter" ) or
				( command == "mage" ) or
				( command == "paladin" ) or
				( command == "priest" ) or
				( command == "rogue" ) or
				( command == "shaman" ) or
				( command == "warlock" ) or
				( command == "warrior" ) then
			if PlaceInArray( RPCONFIG.traits, string.upper(command) ) then
			    table.remove( RPCONFIG.traits, PlaceInArray(RPCONFIG.traits,string.upper(command)) )
				DEFAULT_CHAT_FRAME:AddMessage( "You're no longer role playing like a " .. string.lower(command) .. ".", 0.4, 1.0, 0.6  )
			else
				table.insert( RPCONFIG.traits, string.upper(command) )
				DEFAULT_CHAT_FRAME:AddMessage( "You're now role playing like a " .. string.lower(command) .. ".", 0.4, 1.0, 0.6  )
			end
			DEFAULT_CHAT_FRAME:AddMessage( "Your RP traits are: ".. table.concat(RPCONFIG.traits, ", "), 0.4, 1.0, 0.6 )

   		elseif ( command == "night" ) then
			if PlaceInArray( RPCONFIG.traits, "NIGHTELF" ) then
			    table.remove( RPCONFIG.traits, PlaceInArray(RPCONFIG.traits,"NIGHTELF") )
				DEFAULT_CHAT_FRAME:AddMessage( "You're no longer role playing like a night elf.", 0.4, 1.0, 0.6  )
			else
				table.insert( RPCONFIG.traits, "NIGHTELF" )
				DEFAULT_CHAT_FRAME:AddMessage( "You're now role playing like a night elf.", 0.4, 1.0, 0.6  )
			end
			DEFAULT_CHAT_FRAME:AddMessage( "Your RP traits are: ".. table.concat(RPCONFIG.traits, ", "), 0.4, 1.0, 0.6 )

   		elseif ( command == "any" ) then
			if PlaceInArray( RPCONFIG.traits, "ANY" ) then
			    table.remove( RPCONFIG.traits, PlaceInArray(RPCONFIG.traits,"ANY") )
				DEFAULT_CHAT_FRAME:AddMessage( "You're no longer using the generic lists when you RP.", 0.4, 1.0, 0.6  )
			else
				table.insert( RPCONFIG.traits, "ANY" )
				DEFAULT_CHAT_FRAME:AddMessage( "You're now role using the generic lists when you RP.", 0.4, 1.0, 0.6  )
			end
			DEFAULT_CHAT_FRAME:AddMessage( "Your RP traits are: ".. table.concat(RPCONFIG.traits, ", "), 0.4, 1.0, 0.6 )
-------------------------------------------------------------------------
-- /rph trait(s)
-------------------------------------------------------------------------
		elseif ( command == "trait" ) or ( command == "traits" ) then
            DEFAULT_CHAT_FRAME:AddMessage( "Your RP traits are: ".. table.concat(RPCONFIG.traits, ", "), 0.4, 1.0, 0.6 )
-------------------------------------------------------------------------
-- /rph r(esurrect)
-------------------------------------------------------------------------
		elseif ( command == "resurrect" ) or ( command == "r" ) then
   			IsDead = true
		    RP_OnEvent( "PLAYER_UNGHOST" )
-------------------------------------------------------------------------
-- /rph l(anguage)
-------------------------------------------------------------------------
		elseif ( command == "l" ) or ( command == "lang" ) or ( command == "language" )  then
    		RPHelper_SetLanguage()
-------------------------------------------------------------------------
-- /rph sp(ell(s))
-------------------------------------------------------------------------
		elseif ( command == "sp" ) or ( command == "spell" ) or ( command == "spells" )  then
    		ShowUIPanel(RPSpellsFrame)
-------------------------------------------------------------------------
-- /rph h(i) or h(ello)
-------------------------------------------------------------------------
		elseif ( command == "h" ) or ( command == "hi" ) or ( command == "hello" )  then
			local s, e, c = GetPhrase( "talktonpc_beginning" )
			Roleplay( s, e, c )
-------------------------------------------------------------------------
-- /rph b(y(e)) or goodbye
-------------------------------------------------------------------------
		elseif ( command == "b" ) or ( command == "by" ) or ( command == "bye" ) or ( command == "goodbye" ) then
			local s, e, c = GetPhrase( "talktonpc_end" )
			Roleplay( s, e, c )				
-------------------------------------------------------------------------
-- /rph t(est)
-------------------------------------------------------------------------
		elseif ( command == "test" ) or ( command == "t" )  then
			DEFAULT_CHAT_FRAME:AddMessage( "Nope...  not gonna test... no sir...  not gonna do it.", 0,1,1 )
	    	ShowUIPanel(RPLeftHandFrame)
-------------------------------------------------------------------------
-- /rph debug
-------------------------------------------------------------------------
		elseif ( command == "debug" ) then
		    if RPCONFIG.Debug then   
		    	RPCONFIG.Debug = false
				DEFAULT_CHAT_FRAME:AddMessage( "RPH Debugging: OFF", 0,1,1 )
		    else     
		    	RPCONFIG.Debug = true
				DEFAULT_CHAT_FRAME:AddMessage( "RPH Debugging: ON", 0,1,1 )
		    end	    	
	    	
--[[
-------------------------------------------------------------------------
-- /rph en(glish)
-------------------------------------------------------------------------
		elseif ( command == "en" ) or ( command == "english" ) then
			if RPCONFIG.SetLang == "English" then
				DEFAULT_CHAT_FRAME:AddMessage( "You are already speaking English.", 0,1,1 )
			else
				RPCONFIG.SetLang = "English"
		    	DEFAULT_CHAT_FRAME:AddMessage( "Settings will not take effect until you reload.", 0,1,1 )
			end
-------------------------------------------------------------------------
-- /rph de(utsch)
-------------------------------------------------------------------------
		elseif ( command == "de" ) or ( command == "deutsch" ) or ( command == "german" )  then
			if RPCONFIG.SetLang == "Deutsch" then
				DEFAULT_CHAT_FRAME:AddMessage( "You are already speaking Deutsch.", 0,1,1 )
			else
				RPCONFIG.SetLang = "Deutsch"
		    	DEFAULT_CHAT_FRAME:AddMessage( "Settings will not take effect until you reload.", 0,1,1 )
			end
]]
-------------------------------------------------------------------------
-- /rph [anything else]
-------------------------------------------------------------------------
		else
            ShowUIPanel(RPConfigFrame)
		end -- /rp + command
	end -- /rp options (including "help")
end

