--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- FUNCTION used by GetPhrase( EventType ) to replace keywords
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
function RPHelper_ReplaceKeywords( x, RPType )
--[[
	dcf( "BEFORE:" )
	local i = 1
	while x[i] do
		dcf( "x["..i.."]="..x[i] )
		i = i + 1
	end
]]
	table.foreach( x,
		function(k,v)
			---------------------------------------------------------------------------
			-- RINSULT! or RINSULT
            ---------------------------------------------------------------------------
			if string.find( v, "RINSULT%!" ) then
				local ri = RandInsult()
				if ri then
      				ri = string.gsub( ri, "%.", "%!" ) -- Replace period with exclamation mark
      				v = string.gsub( v, "RINSULT%!", ri ) -- Only substitute the ones with exclamation marks
				else
				    v = "REMOVE ME"
				end
			end

			if string.find( v, "RINSULT" ) then
				if RandInsult() then
      				v = string.gsub( v, "RINSULT", RandInsult() )
				else
				    v = "REMOVE ME"
				end
			end

			---------------------------------------------------------------------------
			-- Pet's name
            ---------------------------------------------------------------------------
			if string.find( v, "PNAME" ) then
				if UnitExists("pet") then
					v = string.gsub( v, "PNAME", (UnitName("pet")) )
				else
				    v = "REMOVE ME"
				end
			end

			---------------------------------------------------------------------------
			-- Your class
            ---------------------------------------------------------------------------
            if string.find( v, "PLAYER_CLASS" ) then
            	local class = UnitClass("player")
				v = string.gsub( v, "PLAYER_CLASS", class )
            end
            
            ---------------------------------------------------------------------------
			-- Your race
            ---------------------------------------------------------------------------
            if string.find( v, "PLAYER_RACE" ) then
            	local race = UnitRace("player")
				v = string.gsub( v, "PLAYER_RACE", race )
            end

			---------------------------------------------------------------------------
			-- Your target's class
            ---------------------------------------------------------------------------
            if string.find( v, "TARGET_CLASS" ) then
				if UnitExists("target") and UnitIsPlayer("target") and ( (UnitName("target")) ~= (UnitName("player")) ) then
					local class = UnitClass("target")
					v = string.gsub( v, "TARGET_CLASS", class )
				else
				    v = "REMOVE ME"
				end
            end
            
            ---------------------------------------------------------------------------
			-- Your target's race
            ---------------------------------------------------------------------------
            if string.find( v, "TARGET_RACE" ) then
            	local race = UnitRace("player")
				v = string.gsub( v, "TARGET_RACE", race )
            end

			---------------------------------------------------------------------------
			-- Your guild's name & rank
            ---------------------------------------------------------------------------
            if string.find( v, "PLAYER_GUILDNAME" ) or string.find( v, "PLAYER_GUILDRANK" )  then
				local guildName, guildRankName, guildRankIndex = GetGuildInfo("player")
				if guildName and guildRankName then
					v = string.gsub( v, "PLAYER_GUILDNAME", guildName )
					v = string.gsub( v, "PLAYER_GUILDRANK", guildRankName )
				else
				    v = "REMOVE ME"
				end
            end

			---------------------------------------------------------------------------
			-- Your target's guild's name & rank
            ---------------------------------------------------------------------------
            if string.find( v, "TARGET_GUILDNAME" ) or string.find( v, "TARGET_GUILDRANK" ) then
				local guildName, guildRankName, guildRankIndex = GetGuildInfo("target")
				if UnitExists("target") and UnitIsPlayer("target") and ((UnitName("target")) ~= (UnitName("player")) ) and guildName and guildRankName then
					v = string.gsub( v, "TARGET_GUILDNAME", guildName )
					v = string.gsub( v, "TARGET_GUILDRANK", guildRankName )
				else
				    v = "REMOVE ME"
				end
            end

			---------------------------------------------------------------------------
			-- Pet's target (name & personal pronouns)
            ---------------------------------------------------------------------------
			if string.find( v, "PT.P" ) or string.find( v, "PTNAME" ) then
				if UnitExists("pettarget") then

		  			if ( GetLocale() == "deDE" ) then
				    	if UnitSex("pettarget") == 2 then		PTSP, PTOP, PTPP = "Er",  "ihn", "seinen"
				        elseif UnitSex("pettarget") == 3 then	PTSP, PTOP, PTPP = "Sie", "sie", "ihren"
				        else									PTSP, PTOP, PTPP = "Es",  "es",  "dem Ding"		end
				    else
				    	if UnitSex("pettarget") == 2 then		PTSP, PTOP, PTPP = "he",  "him", "his"
				        elseif UnitSex("pettarget") == 3 then	PTSP, PTOP, PTPP = "she", "her", "her"
				        else									PTSP, PTOP, PTPP = "it",  "it",  "its"	end
			        end

					v = string.gsub( v, "PTNAME", (UnitName("pettarget")) )
					v = string.gsub( v, "PTSP", PTSP )
					v = string.gsub( v, "PTOP", PTOP )
					v = string.gsub( v, "PTPP", PTPP )
				else
				    v = "REMOVE ME"
				end
			end

			---------------------------------------------------------------------------
			-- Your target (Name & Personal pronouns)
            ---------------------------------------------------------------------------
			-- PTSP, PTOP & PTPP have already been taken out so...
			if string.find( v, "TSP" ) or string.find( v, "TOP" ) or string.find( v, "TPP" ) or string.find( v, "TARGET" ) then
				if UnitExists("target") then

		  			if ( GetLocale() == "deDE" ) then
				    	if UnitSex("target") == 2 then			TSP, TOP, TPP = "Er",  "ihn", "seinen"
				        elseif UnitSex("target") == 3 then		TSP, TOP, TPP = "Sie", "sie", "ihren"
				        else									TSP, TOP, TPP = "Es",  "es",  "dem Ding"		end
				    else
				    	if UnitSex("target") == 2 then			TSP, TOP, TPP = "he",  "him", "his"
				        elseif UnitSex("target") == 3 then		TSP, TOP, TPP = "she", "her", "her"
				        else									TSP, TOP, TPP = "it",  "it",  "its"		end
			        end

					v = string.gsub( v, "TARGET", (UnitName("target")) )
					v = string.gsub( v, "TSP", TSP )
					v = string.gsub( v, "TOP", TOP )
					v = string.gsub( v, "TPP", TPP )
				else
				    v = "REMOVE ME"
				end
			end

			---------------------------------------------------------------------------
			-- You (Name & Personal pronouns)
            ---------------------------------------------------------------------------
			-- PTSP, PTOP, PTPP, TSP, TOP, & TPP have already been taken out so...
			if string.find( v, "SP" ) or string.find( v, "OP" ) or string.find( v, "PP" ) or string.find( v, "PLAYER" ) then

	  			if ( GetLocale() == "deDE" ) then
			    	if UnitSex("player") == 2 then			SP, OP, PP = "Er",  "ihn", "seinen"
			        elseif UnitSex("player") == 3 then		SP, OP, PP = "Sie", "sie", "ihren"
			        else									SP, OP, PP = "Es",  "es",  "dem Ding"	end
			    else
			    	if UnitSex("player") == 2 then			SP, OP, PP = "he",  "him", "his"
			        elseif UnitSex("player") == 3 then		SP, OP, PP = "she", "her", "her"
			        else									SP, OP, PP = "it",  "it",  "its"	end -- Probably not necessary since PLAYER always has a gender
		        end

                v = string.gsub( v, "PLAYER", (UnitName("player")) )
				v = string.gsub( v, "SP", SP )
				v = string.gsub( v, "OP", OP )
				v = string.gsub( v, "PP", PP )
			end

            ---------------------------------------------------------------------------
			-- Home (your hearthstone bind location)
            ---------------------------------------------------------------------------
            if string.find( v, "HOME" ) then
                v = string.gsub( v, "HOME", GetBindLocation() )
            end
            
            ---------------------------------------------------------------------------
			-- Faction Groups
			-- FFG  = Friendly Faction Group
			-- EFG  = Enemy Faction Group
			-- BGFG = Battleground Faction Group
            ---------------------------------------------------------------------------
            if string.find( v, "FFG" ) then
                local faction, _ = UnitFactionGroup("player")
                v = string.gsub( v, "FFG", faction )
            end
            if string.find( v, "EFG" ) then
                local faction, _ = UnitFactionGroup("player")
                local efaction
                if ( faction == "Alliance" ) then
                    efaction = "Horde"
                else
                    efaction = "Alliance"
                end
                v = string.gsub( v, "EFG", efaction)
            end

            if string.find(v, "BGFG") then
                local englishFaction, playerFaction = UnitFactionGroup("player");
                local bgfaction
                if (englishFaction == "Alliance") then
                    if (GetRealZoneText() == "Arathi Basin") then bgfaction = "League of Arathor" end
                    if (GetRealZoneText() == "Alterac Valley") then bgfaction = "Stormpike Guard" end
                    if (GetRealZoneText() == "Warsong Gulch") then bgfaction = "Silverwing Sentinels" end
                else
                    if (GetRealZoneText() == "Arathi Basin") then bgfaction = "Defilers" end
                    if (GetRealZoneText() == "Alterac Valley") then bgfaction = "Frostwolf Clan" end
                    if (GetRealZoneText() == "Warsong Gulch") then bgfaction = "Warsong Outriders" end
                end
                v = string.gsub(v, "BGFG", bgfaction)
            end
            ---------------------------------------------------------------------------
			-- Zone Info
			-- MAIN_ZONE is the zone you're in, ie. Western Plaguelands
			-- SUB_ZONE is the subzone you're in, ie. Ruins of Andorhall
			-- (if you're not in a subzone, SUB_ZONE will revert to MAIN_ZONE)
            ---------------------------------------------------------------------------
            if string.find( v, "MAIN_ZONE" ) then
                v = string.gsub( v, "MAIN_ZONE", GetRealZoneText() )
            end
            
            if string.find( v, "SUB_ZONE" ) then
                local zonetext = GetSubZoneText()
                if (zonetext == "") then
                    zonetext = GetRealZoneText()
                end
                    v = string.gsub( v, "SUB_ZONE", zonetext )
            end
            
            ---------------------------------------------------------------------------
			-- MOUNT gives the name of your current mount while you're casting (mounting)
			-- The variable is set the first time you mount, so if you attempt to call 
			-- it beforehand, it will be blank and RPH will skip that phrase
            ---------------------------------------------------------------------------
            if string.find( v, "MOUNT" ) and RPH_MyMount then
                v = string.gsub( v, "MOUNT", RPH_MyMount )
            --else
            --    v = "REMOVE ME"
            end
            
            ---------------------------------------------------------------------------
			-- Power Types: Player and Target
			-- Tells what power type you or your target uses (mana, rage, energy)
            ---------------------------------------------------------------------------
            if string.find( v, "PLAYER_POWER" ) then
                local power = UnitPowerType("player")
                if (power == 0) then power = "mana" 
                elseif (power == 1) then power = "rage" 
                elseif (power == 3) then power = "energy" end
                v = string.gsub( v, "PLAYER_POWER", power)
            end
            
            if string.find( v, "TARGET_POWER" ) and UnitExists("target") and (UnitName("target")) ~= (UnitName("player")) then
                local power = UnitPowerType("target")
                if (power == 0) then power = "mana" 
                elseif (power == 1) then power = "rage" 
                elseif (power == 3) then power = "energy" end
                v = string.gsub( v, "TARGET_POWER", power)
            end
            
			---------------------------------------------------------------------------
			-- Capitalize after a period, exclamation mark or question mark
			-- MISSING capitalization for beginnings of sayings.
            ---------------------------------------------------------------------------
			v = string.gsub( v, "%.  (%l)", function(s) return ".  "..string.upper(s) end )     -- 2 spaces
			v = string.gsub( v, "%.   (%l)", function(s) return ".   "..string.upper(s) end )   -- 3 spaces
			v = string.gsub( v, "%.%s+(%l)", function(s) return ". "..string.upper(s) end )     -- any other # becomes 1 space

			v = string.gsub( v, "%!  (%l)", function(s) return "!  "..string.upper(s) end )
			v = string.gsub( v, "%!   (%l)", function(s) return "!   "..string.upper(s) end )
			v = string.gsub( v, "%!%s+(%l)", function(s) return "! "..string.upper(s) end )

			v = string.gsub( v, "%?  (%l)", function(s) return "?  "..string.upper(s) end )
			v = string.gsub( v, "%?   (%l)", function(s) return "?   "..string.upper(s) end )
			v = string.gsub( v, "%?%s+(%l)", function(s) return "? "..string.upper(s) end )

			---------------------------------------------------------------------------
			-- Capitalize the beginning of a saying
            ---------------------------------------------------------------------------
			if RPType == "saying" then
			    v = string.gsub( v, "^(%l)", function(s) return string.upper(s) end )
			end

			---------------------------------------------------------------------------
			-- Put the edited phrase into the original phrase's spot.
            ---------------------------------------------------------------------------
			x[k] = v
		end)

 	---------------------------------------------------------------------------
	-- If you table.remove() inside a table.foreach() loop:
	-- (Example: remove 2; 3 becomes 2; foreach() loop has done 2 so it doesn't look at it again)
    ---------------------------------------------------------------------------
	local i = 1
	while x[i] do
		if x[i] == "REMOVE ME" then
			table.remove( x, i )
			i = i - 1
		end
		i = i + 1
	end
--[[
	dcf( "AFTER:" )
	local i = 1
	while x[i] do
		dcf( "x["..i.."]="..x[i] )
		i = i + 1
	end
]]

	return x
end
