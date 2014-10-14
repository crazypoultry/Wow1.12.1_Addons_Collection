--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- FUNCTIONS FOR THE GUI MENUS
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

--[[
I don't think I need these anymore.  They could probably be erased.

RPTypes = {}
RPTypes["AllCombat"] = { "EnterCombat","LeaveCombat","HostileHit","HostileMiss","YouCrit","YouCritSpell","PetAttackStart","PetAttackStop","PetDies" }
RPTypes["NonCombat"] = { "Resurrect","TalkToNPC","TalkToNPCMid" }
RPTypes["Anytime"] =   { "NPCTalksFriend","NPCTalksEnemy","YouHeal","YouCritHeal" }
]]

--=====================================================================--
-- RPConfigFrame
--=====================================================================--
function RPConfigFrame_OnShow()
	getglobal(this:GetName().."CheckButtonOn"):SetChecked( RPCONFIG.on )
	RPConfigFrameButtonRPLanguage:SetText( RPCONFIG.RPLang )
    FontStringRPHVersion:SetText("RPH "..RPHELPER_VERSION)

--    CreateFrame("Button", "RPConfigFrameButtonRPLanguage", RPConfigFrame)
    FontStringRPLanguage:ClearAllPoints()
	FontStringRPLanguage:SetPoint("TOP", RPConfigFrameButtonRPLanguage, "TOP", 0, 14 )
end

function RPConfigFrame_OnUpdate()
	local LastRPMessage
	local sec, min, hour = ParseTime( GetTime() - LastRP )
	local x

	if RPedAtLeastOnce then
		x = "Last RP was: "
	else
		x = "RPH Loaded: "
	end

	if hour >= 1 then
		LastRPMessage = x .. hour .. "h " .. min .. "m " .. sec .. "s ago."
	elseif min >= 1 then
		LastRPMessage = x .. min .. "min " .. sec .. "sec ago."
	else
		LastRPMessage = x .. sec .. "sec ago."
	end

	getglobal("LastRPText"):SetText( LastRPMessage )
end

function RPConfigFrame_RPListsButton()
	if (RPListFrame:IsVisible()) then
    	HideUIPanel(RPListFrame)
	else
    	ShowUIPanel(RPListFrame)
	end
end

function RPConfigFrame_RPAdvancedButton()
	if (RPEventsFrame:IsVisible()) then
    	HideUIPanel(RPEventsFrame)
	else
    	ShowUIPanel(RPEventsFrame)
	end
end

function RPConfigFrame_RPSpellsButton()
	if (RPSpellsFrame:IsVisible()) then
    	HideUIPanel(RPSpellsFrame)
	else
    	ShowUIPanel(RPSpellsFrame)
	end
end
                                
function RPConfigFrame_RPLanguageButton()
	RPHelper_SetLanguage()
	RPConfigFrameButtonRPLanguage:SetText( RPCONFIG.RPLang )	
end

function RPOnOffSwitch()
	if RPCONFIG.on then
		RPCONFIG.on = false
	else
		RPCONFIG.on = true
	end
end

--=====================================================================--
-- RPListFrame
--=====================================================================--
function RPListFrame_OnShow()
	getglobal(this:GetName().."CheckButtonANY"):SetChecked( PlaceInArray( RPCONFIG.traits, "ANY" ) )
	getglobal(this:GetName().."CheckButtonDWARF"):SetChecked( PlaceInArray( RPCONFIG.traits, "DWARF" ) )
	getglobal(this:GetName().."CheckButtonGNOME"):SetChecked( PlaceInArray( RPCONFIG.traits, "GNOME" ) )
	getglobal(this:GetName().."CheckButtonHUMAN"):SetChecked( PlaceInArray( RPCONFIG.traits, "HUMAN" ) )
	getglobal(this:GetName().."CheckButtonNIGHTELF"):SetChecked( PlaceInArray( RPCONFIG.traits, "NIGHTELF" ) )
	getglobal(this:GetName().."CheckButtonORC"):SetChecked( PlaceInArray( RPCONFIG.traits, "ORC" ) )
	getglobal(this:GetName().."CheckButtonTAUREN"):SetChecked( PlaceInArray( RPCONFIG.traits, "TAUREN" ) )
	getglobal(this:GetName().."CheckButtonTROLL"):SetChecked( PlaceInArray( RPCONFIG.traits, "TROLL" ) )
	getglobal(this:GetName().."CheckButtonUNDEAD"):SetChecked( PlaceInArray( RPCONFIG.traits, "UNDEAD" ) )
	getglobal(this:GetName().."CheckButtonDRUID"):SetChecked( PlaceInArray( RPCONFIG.traits, "DRUID" ) )
	getglobal(this:GetName().."CheckButtonHUNTER"):SetChecked( PlaceInArray( RPCONFIG.traits, "HUNTER" ) )
	getglobal(this:GetName().."CheckButtonMAGE"):SetChecked( PlaceInArray( RPCONFIG.traits, "MAGE" ) )
	getglobal(this:GetName().."CheckButtonPALADIN"):SetChecked( PlaceInArray( RPCONFIG.traits, "PALADIN" ) )
	getglobal(this:GetName().."CheckButtonPRIEST"):SetChecked( PlaceInArray( RPCONFIG.traits, "PRIEST" ) )
	getglobal(this:GetName().."CheckButtonROGUE"):SetChecked( PlaceInArray( RPCONFIG.traits, "ROGUE" ) )
	getglobal(this:GetName().."CheckButtonSHAMAN"):SetChecked( PlaceInArray( RPCONFIG.traits, "SHAMAN" ) )
	getglobal(this:GetName().."CheckButtonWARLOCK"):SetChecked( PlaceInArray( RPCONFIG.traits, "WARLOCK" ) )
	getglobal(this:GetName().."CheckButtonWARRIOR"):SetChecked( PlaceInArray( RPCONFIG.traits, "WARRIOR" ) )	
	getglobal(this:GetName().."CheckButtonSPELLS"):SetChecked( RPCONFIG.UseSpellRPs )
	
	RPListFrameCheckButtonSPELLSText:SetText( "Use Spell RPs from " .. englishClass .. ".lua" )			
	if PlaceInArray( RPCONFIG.traits, englishClass ) then
		RPListFrameCheckButtonSPELLS:Hide()		
	else                                     
		RPListFrameCheckButtonSPELLS:Show()	
	end
end

function RPListUpdate()
	local command = string.gsub( this:GetName(), this:GetParent():GetName().."CheckButton", "" )

	if PlaceInArray( RPCONFIG.traits, command ) then
		table.remove( RPCONFIG.traits, PlaceInArray(RPCONFIG.traits, command ) )
		if 		( command == "ANY" ) then
			dcf( "You're no longer using the generic lists when you RP." )
		elseif	( command == "NIGHTELF" ) then
			dcf( "You're no longer roleplaying like a night elf." )
		elseif	( command == "ORC" ) then
			dcf( "You're no longer roleplaying like an orc." )
		else
			dcf( "You're no longer roleplaying like a " .. string.lower(command) .. "." )
		end
		
		if command == englishClass then
			RPListFrameCheckButtonSPELLS:Show()
		end
	else
		table.insert( RPCONFIG.traits, command )
		if 		( command == "ANY" ) then
			dcf( "You're now roleplaying using the generic lists when you RP." )
		elseif	( command == "NIGHTELF" ) then
			dcf( "You're now roleplaying like a night elf." )
		elseif	( command == "ORC" ) then
			dcf( "You're now roleplaying like an orc." )
		else
			dcf( "You're now roleplaying like a " .. string.lower(command) .. "." )
		end
		
		if command == englishClass then
			RPListFrameCheckButtonSPELLS:Hide()
		end
	end
end

function RPList_CheckButtonSPELLS()
	if RPCONFIG.UseSpellRPs then
		RPCONFIG.UseSpellRPs = false
	else
		RPCONFIG.UseSpellRPs = true
	end		
end

--=====================================================================--
-- RPSpellsFrame
--=====================================================================--
function RPSpellsFrame_OnShow()

	-- Physically set up the Frame
	RPSpellsFrameTextDelay:SetPoint("TOPLEFT", RPSpellsFrame, "TOPLEFT", 177, -27 )
	RPSpellsFrameTextChance:SetPoint("TOPLEFT", RPSpellsFrame, "TOPLEFT", 230, -27 )
	
	RPSpellsFrameFontString1:SetPoint("TOPLEFT", RPSpellsFrame, "TOPLEFT", 20, -45 )		
		
	RPSpellsFrameButtonDelay1:SetPoint("TOPLEFT", RPSpellsFrameFontString1, "TOPLEFT", 150, 4 )	
	RPSpellsFrameButtonChance1:SetPoint("TOPLEFT", RPSpellsFrameFontString1, "TOPLEFT", 210, 4 )
	RPSpellsFrameButtonDelay1:SetWidth( 50 )                                           
	RPSpellsFrameButtonChance1:SetWidth( 50 )
	                                                        
	RPSpellsFrameFontStringCountdown1:SetPoint("TOPLEFT", RPSpellsFrameFontString1, "TOPLEFT", 265, 0 )
	
	for i = 2, 18 do
    	getglobal( "RPSpellsFrameFontString"..i ):SetPoint("TOPLEFT", "RPSpellsFrameFontString"..i-1, "TOPLEFT", 0, -20 ) 
        getglobal( "RPSpellsFrameButtonDelay"..i ):SetPoint("TOPLEFT", "RPSpellsFrameButtonDelay"..i-1, "TOPLEFT", 0, -20 )
        getglobal( "RPSpellsFrameButtonChance"..i ):SetPoint("TOPLEFT", "RPSpellsFrameButtonChance"..i-1, "TOPLEFT", 0, -20 )  
    	getglobal( "RPSpellsFrameFontStringCountdown"..i ):SetPoint("TOPLEFT", "RPSpellsFrameFontStringCountdown"..i-1, "TOPLEFT", 0, -20 )
        getglobal( "RPSpellsFrameButtonDelay"..i ):SetWidth( 50 )                                                           
        getglobal( "RPSpellsFrameButtonChance"..i ):SetWidth( 50 ) 
	end	


	-- Get a numbered & sorted list of all of your spells
	RPSpells_localized = {}		-- localized spell names
	RPSpellsFrame_english = {}       -- formatted english spell names
	local spelltypes = { "casttime", "channeled", "instant", "next_melee"  }

 	table.foreachi( spelltypes, function( k, spelltype )
	 	table.foreach( SPELLS[spelltype][englishClass], function( formatted_spellname, spellname )
			if not PlaceInArray( RPSpells_localized, spellname ) then  -- Needed since "Corruption" is listed as both "instant" and "casttime"
	        	table.insert( RPSpells_localized, spellname )
			end
	    end)
	end)
    table.sort(RPSpells_localized)


	-- Remove spells not in your Spellbook
	-- HEY ME!!!   WHAT ABOUT "Heal" & "Lesser Heal"?!?!
	if ( RPCONFIG.Spells_to_Show == "All Known" ) or ( RPCONFIG.Spells_to_Show == "Known with RPs" ) then
		local i = 1
		while RPSpells_localized[i] do
		    local j = 1
			local Spell_is_known = false
			while GetSpellName( j, "spell" ) do
				local Spellbook_Spellname = GetSpellName( j, "spell" )
				if string.find( Spellbook_Spellname, RPSpells_localized[i] ) then
				    Spell_is_known = true
				end
		       	j = j + 1
			end
			if not Spell_is_known then
				table.remove( RPSpells_localized, i )
				i = i - 1
			end
			i = i + 1
		end
	end

	-- Kind of a hack but...  Table 'RPSpells_localized' is alphabetically sorted based on the localized language
	-- we need another numbered list of the "English formatted spell names" that matches the same numbers
	table.foreachi( RPSpells_localized, function( keynumber, localized_spell_name )
 		table.foreachi( spelltypes, function( k, spelltype )
	 		table.foreach( SPELLS[spelltype][englishClass], function( formatted_spellname, spellname )
				if spellname == localized_spell_name then
					if not PlaceInArray( RPSpellsFrame_english, formatted_spellname ) then -- Same as above
						table.insert( RPSpellsFrame_english, formatted_spellname )
					end
				end
			end)
	    end)
	end)

	if ( RPCONFIG.Spells_to_Show == "All with RPs" ) or ( RPCONFIG.Spells_to_Show == "Known with RPs" ) then
        local i = 1
		local Spell_has_RP = false
			
		while RPSpellsFrame_english[i] do
	        local sayings_size, emotes_size, custom_emotes_size, random_size = 0, 0, 0, 0
	        if RPWORDLIST[ RPSpellsFrame_english[ i ] ][ englishClass ] then
	        	sayings_size = table.getn( RPWORDLIST[ RPSpellsFrame_english[ i ] ][ englishClass ] )
				if RPWORDLIST[ RPSpellsFrame_english[ i ] ][ englishClass ][ "emote" ] then
					emotes_size = table.getn( RPWORDLIST[ RPSpellsFrame_english[ i ] ][ englishClass ][ "emote" ] )
				end
				if RPWORDLIST[ RPSpellsFrame_english[ i ] ][ englishClass ][ "customemote" ] then
					custom_emotes_size = table.getn( RPWORDLIST[ RPSpellsFrame_english[ i ] ][ englishClass ][ "customemote" ] )
				end
				if RPWORDLIST[ RPSpellsFrame_english[ i ] ][ englishClass ][ "random" ] then
					random_size = table.getn( RPWORDLIST[ RPSpellsFrame_english[ i ] ][ englishClass ][ "random" ] )
				end
			end
	        if sayings_size + emotes_size + custom_emotes_size + random_size == 0 then
				table.remove( RPSpellsFrame_english, i )
				table.remove( RPSpells_localized, i )
				i = i - 1
	        end
	        i = i + 1
		end
	end
	
	-- Give ButtonSpellToShow the correct option
	RPSpellsFrameButtonSpellsToShow:SetText( RPCONFIG.Spells_to_Show )
	
    RPSpellsFrameSetupSpellPage()
end




function RPSpellsFrameSetupSpellPage( x )
    local Number_of_Spells = table.getn( RPSpells_localized )
    
	-- Pick which Page of Spells to show
    if (x == "Previous") and (RP_SpellPage ~= 1) then
        RP_SpellPage = RP_SpellPage - 1
	elseif (x == "Next") and ( RP_SpellPage * 18 < Number_of_Spells ) then
        RP_SpellPage = RP_SpellPage + 1
	end
  
	-- Show the Spell names, Delay Buttons, & Chance Buttons
	for i = 1, 18 do
	    local SpellNumber = i + (18 * RP_SpellPage) - 18
	    if RPSpells_localized[SpellNumber] then
        	getglobal( "RPSpellsFrameFontString"..i ):SetText( RPSpells_localized[SpellNumber] )
        	getglobal( "RPSpellsFrameButtonDelay"..i ):Show()                 
        	getglobal( "RPSpellsFrameButtonChance"..i ):Show() 
        	getglobal( "RPSpellsFrameButtonDelay"..i ):SetText( RPCONFIG[RPSpellsFrame_english[SpellNumber]]["Delay"] )
        	getglobal( "RPSpellsFrameButtonChance"..i ):SetText( RPCONFIG[RPSpellsFrame_english[SpellNumber]]["Chance"] * 100 .. "%" )
		else
		    getglobal( "RPSpellsFrameFontString"..i ):SetText( "" )
		    getglobal( "RPSpellsFrameFontString"..i ):SetTextColor( (1 - (i / 36) ), ( 0.5 + (i / 36) ), 1)
			getglobal( "RPSpellsFrameButtonDelay"..i ):Hide()     
			getglobal( "RPSpellsFrameButtonChance"..i ):Hide()
        end
	end
	
	-- If there are no spells with RPs, tell the player what to do.
	if 	( RPSpellsFrameFontString1:GetText() == nil ) and
		( ( RPCONFIG.Spells_to_Show == "All with RPs" ) or ( RPCONFIG.Spells_to_Show == "Known with RPs" ) ) then
		RPSpellsFrameFontString4:SetText( "You don't have any phrases or emotes to RP with" )
  		RPSpellsFrameFontString5:SetText( "when a " .. playerClass .. " casts a spell." )
  		RPSpellsFrameFontString7:SetText( "Please edit:    " .. englishClass .. ".lua" )
  		RPSpellsFrameFontString9:SetText( "For instructions, please read:    How to Customize.txt" )
	end
	
	-- Show or Hide "Previous" & "Next" Buttons
	if RP_SpellPage == 1 then
	    RPSpellsFrameButtonPrevious:Hide()
	else
	    RPSpellsFrameButtonPrevious:Show()
	end
	
	if RP_SpellPage * 18 >= Number_of_Spells then
	    RPSpellsFrameButtonNext:Hide()
	else
	    RPSpellsFrameButtonNext:Show()
	end

	-- Clear the EditBox in case you left it open
    RPSpellsFrameEditBox1:SetText("")
	RPSpellsFrameEditBox1:Hide()
end




function RPSpellsFrame_Button_OnClick()
	RPSpellsFrameEditBox1:ClearFocus();
	RPSpellsFrameEditBox1:ClearAllPoints()
	RPSpellsFrameEditBox1:SetPoint("TOPLEFT", this:GetName(), "TOPLEFT")
	RPSpellsFrameEditBox1:SetPoint("BOTTOMRIGHT", this:GetName(), "BOTTOMRIGHT")
	RPSpellsFrameEditBox1:SetTextColor(1,1,1)
	RPSpellsFrameEditBox1:Show()
	this:Hide()
	
	RPSpellsFrame_Current_Button = this	
end

function RPSpellsFrame_EditBox_Escape()
	this:SetText("")
	this:Hide()
	RPSpellsFrame_Current_Button:Show()
end

function RPSpellsFrame_EditBox_Enter()
	local n = this:GetNumber()
	local t = this:GetText()
	
	if  ( n > 0 ) or
		( ( n == 0 ) and ( ( t == "0" ) or ( t == "0%" ) or ( t == "0s" ) or ( t == "0sec" ) or ( t == "0seconds" ) or
		( t == "0 " ) or ( t == "0 s" ) or ( t == "0 sec" ) or ( t == "0 seconds" ) or ( t == "0 percent" ) ) ) then
			if string.find( RPSpellsFrame_Current_Button:GetName(), "Chance" ) then
				if ( n > 100 ) then
					dcf( "Your number must be between 0 & 100" )
				else
					RPSpellsFrame_Current_Button:SetText( n .. "%" )
					
					local This_Buttons_Number = string.gsub( RPSpellsFrame_Current_Button:GetName(), "RPSpellsFrameButtonChance", "" )
					local Place_in_t2 = ( ( RP_SpellPage - 1 ) * 18 ) + tonumber( This_Buttons_Number )
					RPCONFIG[ RPSpellsFrame_english[ Place_in_t2 ]]["Chance" ] = n / 100
				end
			else
				RPSpellsFrame_Current_Button:SetText( n )
				
				local This_Buttons_Number = string.gsub( RPSpellsFrame_Current_Button:GetName(), "RPSpellsFrameButtonDelay", "" )
				local Place_in_t2 = ( ( RP_SpellPage - 1 ) * 18 ) + tonumber( This_Buttons_Number )
				RPCONFIG[ RPSpellsFrame_english[ Place_in_t2 ]]["Delay" ] = n
			end
	end
	
	this:SetText("")
	this:Hide()
	RPSpellsFrame_Current_Button:Show()
end

-- Change the colors & countdown (^_^)
function RPSpellsFrame_OnUpdate()
	for i = 1, 18 do
		local Spell_Number = ( ( RP_SpellPage - 1 ) * 18 ) + i
	    if RPSpellsFrame_english[ Spell_Number ] then
	    
	    	-- make the spell name less opaque if you don't have any RPs
	        local opacity = 1
	        local sayings_size, emotes_size, custom_emotes_size, random_size = 0, 0, 0, 0
	        if RPWORDLIST[ RPSpellsFrame_english[ Spell_Number ] ][ englishClass ] then
	        	sayings_size = table.getn( RPWORDLIST[ RPSpellsFrame_english[ Spell_Number ] ][ englishClass ] )
				if RPWORDLIST[ RPSpellsFrame_english[ Spell_Number ] ][ englishClass ][ "emote" ] then
					emotes_size = table.getn( RPWORDLIST[ RPSpellsFrame_english[ Spell_Number ] ][ englishClass ][ "emote" ] )
				end
				if RPWORDLIST[ RPSpellsFrame_english[ Spell_Number ] ][ englishClass ][ "customemote" ] then
					custom_emotes_size = table.getn( RPWORDLIST[ RPSpellsFrame_english[ Spell_Number ] ][ englishClass ][ "customemote" ] )
				end
				if RPWORDLIST[ RPSpellsFrame_english[ Spell_Number ] ][ englishClass ][ "random" ] then
					random_size = table.getn( RPWORDLIST[ RPSpellsFrame_english[ Spell_Number ] ][ englishClass ][ "random" ] )
				end
			end
	        if sayings_size + emotes_size + custom_emotes_size + random_size == 0 then
	        	opacity = .5          
        		getglobal( "RPSpellsFrameButtonDelay"..i ):Hide()
	        	getglobal( "RPSpellsFrameButtonChance"..i ):Hide()
	        end
	        
			local delay = RPCONFIG[ RPSpellsFrame_english[ Spell_Number ]]["Delay" ]
			if RPCONFIG[ RPSpellsFrame_english[ Spell_Number ]]["Chance" ] == 0 then      -- 0% Chance?
				getglobal( "RPSpellsFrameFontString" .. i ):SetTextColor(1, 0, 0) 			-- Spellname color (red)
				getglobal( "RPSpellsFrameFontStringCountdown" .. i ):SetText( "" )			-- Countdown becomes invisible
			elseif ( GetTime() - LastRP ) < delay then
				local x = delay - ( GetTime() - LastRP )                                     -- Delay?
				getglobal( "RPSpellsFrameFontStringCountdown" .. i ):SetText( math.ceil(x) ) -- Countdown text

				local r, g
				if x > delay / 2 then
					r = 1
					g = ( 1 - ( x / delay ) ) * 2
				else
					r = ( x / delay ) * 2
					g = 1
				end
				getglobal( "RPSpellsFrameFontString" .. i ):SetTextColor(r, g, 0, opacity) 			-- Spellname color
				getglobal( "RPSpellsFrameFontStringCountdown" .. i ):SetTextColor(r, g, 0, opacity) -- Countdown color
			else
				getglobal( "RPSpellsFrameFontString" .. i ):SetTextColor(0, 1, 0, opacity) 	-- Spellname color (green)
				getglobal( "RPSpellsFrameFontStringCountdown" .. i ):SetText( "" )			-- Countdown becomes invisible
			end
		else
		    getglobal( "RPSpellsFrameFontStringCountdown" .. i ):SetText( "" )			-- Countdown becomes invisible
		end
	end
end

function RPSpellsFrame_ButtonSpellsToShow_OnClick()
 	RPHelper_SetSpellsShown()
 	RP_SpellPage = 1
 	RPSpellsFrame_OnShow()
end




--=====================================================================--
-- RPEventsFrame
--=====================================================================--
function RPEventsFrame_OnShow()

	-- Physically set up the Frame
	RPEventsFrameTextDelay:SetPoint("TOPLEFT", RPEventsFrame, "TOPLEFT", 177, -27 )
	RPEventsFrameTextChance:SetPoint("TOPLEFT", RPEventsFrame, "TOPLEFT", 230, -27 )

	RPEventsFrameFontString1:SetPoint("TOPLEFT", RPEventsFrame, "TOPLEFT", 20, -45 )

	RPEventsFrameButtonDelay1:SetPoint("TOPLEFT", RPEventsFrameFontString1, "TOPLEFT", 150, 4 )
	RPEventsFrameButtonChance1:SetPoint("TOPLEFT", RPEventsFrameFontString1, "TOPLEFT", 210, 4 )
	RPEventsFrameButtonDelay1:SetWidth( 50 )
	RPEventsFrameButtonChance1:SetWidth( 50 )

	RPEventsFrameFontStringCountdown1:SetPoint("TOPLEFT", RPEventsFrameFontString1, "TOPLEFT", 265, 0 )

	for i = 2, 18 do
    	getglobal( "RPEventsFrameFontString"..i ):SetPoint("TOPLEFT", "RPEventsFrameFontString"..i-1, "TOPLEFT", 0, -20 )
        getglobal( "RPEventsFrameButtonDelay"..i ):SetPoint("TOPLEFT", "RPEventsFrameButtonDelay"..i-1, "TOPLEFT", 0, -20 )
        getglobal( "RPEventsFrameButtonChance"..i ):SetPoint("TOPLEFT", "RPEventsFrameButtonChance"..i-1, "TOPLEFT", 0, -20 )
    	getglobal( "RPEventsFrameFontStringCountdown"..i ):SetPoint("TOPLEFT", "RPEventsFrameFontStringCountdown"..i-1, "TOPLEFT", 0, -20 )
        getglobal( "RPEventsFrameButtonDelay"..i ):SetWidth( 50 )
        getglobal( "RPEventsFrameButtonChance"..i ):SetWidth( 50 )
	end

	-- Get a numbered list of all of your events
	RPEvents_Numbered = {}
	local i = 1
	local More_Events = true
	while More_Events do
	    local found = false
		table.foreach( RPEvents, function(k,v)
		    if RPEvents[k]["Menu Number"] == i then
		    	table.insert( RPEvents_Numbered, k )
				found = true
		    end
		end)
		if not found then
			More_Events = false
		end
		i = i + 1
	end
	

	-- Remove "Pet" events for every class except HUNTER, PRIEST, & WARLOCK
	if (englishClass ~= "HUNTER") and (englishClass ~= "PRIEST") and (englishClass ~= "WARLOCK") then
		local i = 1
		while RPEvents_Numbered[i] do
			if string.find( RPEvents_Numbered[i], "pet" ) then
				table.remove( RPEvents_Numbered, i )
				i = i - 1
			end
			i = i + 1
		end
	end

	-- Remove Pet events for every class except HUNTER, PRIEST, & WARLOCK
	if (englishClass ~= "DRUID") and (englishClass ~= "PALADIN") and (englishClass ~= "PRIEST") and (englishClass ~= "SHAMAN") then
		local i = 1
		while RPEvents_Numbered[i] do
			if string.find( RPEvents_Numbered[i], "heal" ) then
				table.remove( RPEvents_Numbered, i )
				i = i - 1
			end
			i = i + 1
		end
	end

	if ( RPCONFIG.Events_to_Show == "All with RPs" ) then
        local i = 1
		while RPEvents_Numbered[i] do
			local s, e, c = GetPhrase( RPEvents_Numbered[i] )			
	        if table.getn( s ) + table.getn( e ) + table.getn( c ) == 0 then
				table.remove( RPEvents_Numbered, i )
				i = i - 1
	        end
	        i = i + 1
		end
	end

	-- Give ButtonSpellToShow the correct option
	RPEventsFrameButtonEventsToShow:SetText( RPCONFIG.Events_to_Show )

    RPEventsFrameSetupEventsPage()
end




function RPEventsFrameSetupEventsPage( x )
    local Number_of_Events = table.getn( RPEvents_Numbered )

	-- Pick which Page of Spells to show
    if (x == "Previous") and (RP_EventsPage ~= 1) then
        RP_EventsPage = RP_EventsPage - 1
	elseif (x == "Next") and ( RP_EventsPage * 18 < Number_of_Events ) then
        RP_EventsPage = RP_EventsPage + 1
	end

	-- Show the Event names, Delay Buttons, & Chance Buttons
	for i = 1, 18 do
	    local EventNumber = i + (18 * RP_EventsPage) - 18
	    local e = RPEvents_Numbered[ EventNumber ]
	    if e then
        	getglobal( "RPEventsFrameFontString"..i ):SetText( RPEvents[ e ]["English"] )
        	getglobal( "RPEventsFrameButtonDelay"..i ):Show()
        	getglobal( "RPEventsFrameButtonChance"..i ):Show()
        	getglobal( "RPEventsFrameButtonDelay"..i ):SetText( RPCONFIG[ e ]["Delay"] )
        	getglobal( "RPEventsFrameButtonChance"..i ):SetText( RPCONFIG[ e ]["Chance"] * 100 .. "%" )
		else
		    getglobal( "RPEventsFrameFontString"..i ):SetText( "" )
		    getglobal( "RPEventsFrameFontString"..i ):SetTextColor( (1 - (i / 36) ), ( 0.5 + (i / 36) ), 1)
			getglobal( "RPEventsFrameButtonDelay"..i ):Hide()
			getglobal( "RPEventsFrameButtonChance"..i ):Hide()
        end
	end

	-- If there are no events with RPs, tell the player what to do.
	if 	( RPEventsFrameFontString1:GetText() == nil ) and ( RPCONFIG.Events_to_Show == "All with RPs" ) then
		RPEventsFrameFontString4:SetText( "You don't have any phrases or emotes to RP with." )
		if table.getn( RPCONFIG.traits ) == 0 then
			RPEventsFrameFontString5:SetText( "This is because you aren't using any phrase lists." )
			RPEventsFrameFontString7:SetText( "Please click \"Phrase Lists\" and change those settings." )			
		else
			RPEventsFrameFontString5:SetText( "Your RP traits are: ".. table.concat(RPCONFIG.traits, ", ") )
			RPEventsFrameFontString7:SetText( "1: Please click \"Phrase Lists\" and change those settings," )
	  		RPEventsFrameFontString9:SetText( "2: Or please edit:    ".. table.concat(RPCONFIG.traits, ".lua, ") .. ".lua" )
	  		RPEventsFrameFontString10:SetText( "For instructions, please read:    How to Customize.txt" )
	  	end
	end

	-- Show or Hide "Previous" & "Next" Buttons
	if RP_EventsPage == 1 then
	    RPEventsFrameButtonPrevious:Hide()
	else
	    RPEventsFrameButtonPrevious:Show()
	end

	if RP_EventsPage * 18 >= Number_of_Events then
	    RPEventsFrameButtonNext:Hide()
	else
	    RPEventsFrameButtonNext:Show()
	end

	-- Clear the EditBox in case you left it open
    RPEventsFrameEditBox1:SetText("")
	RPEventsFrameEditBox1:Hide()
end


function RPEventsFrame_Button_OnClick()
	RPEventsFrameEditBox1:ClearFocus();
	RPEventsFrameEditBox1:ClearAllPoints()
	RPEventsFrameEditBox1:SetPoint("TOPLEFT", this:GetName(), "TOPLEFT")
	RPEventsFrameEditBox1:SetPoint("BOTTOMRIGHT", this:GetName(), "BOTTOMRIGHT")
	RPEventsFrameEditBox1:SetTextColor(1,1,1)
	RPEventsFrameEditBox1:Show()
	this:Hide()

	RPEventsFrame_Current_Button = this
end

function RPEventsFrame_EditBox_Escape()
	this:SetText("")
	this:Hide()
	RPEventsFrame_Current_Button:Show()
end

function RPEventsFrame_EditBox_Enter()
	local n = this:GetNumber()
	local t = this:GetText()

	if  ( n > 0 ) or
		( ( n == 0 ) and ( ( t == "0" ) or ( t == "0%" ) or ( t == "0s" ) or ( t == "0sec" ) or ( t == "0seconds" ) or
		( t == "0 " ) or ( t == "0 s" ) or ( t == "0 sec" ) or ( t == "0 seconds" ) or ( t == "0 percent" ) ) ) then

			if string.find( RPEventsFrame_Current_Button:GetName(), "Chance" ) then
				if ( n > 100 ) then
					dcf( "Your number must be between 0 & 100" )
				else
					RPEventsFrame_Current_Button:SetText( n .. "%" )

					local This_Buttons_Number = string.gsub( RPEventsFrame_Current_Button:GetName(), "RPEventsFrameButtonChance", "" )
					local Place_in_RPEvents_Numbered = ( ( RP_EventsPage - 1 ) * 18 ) + tonumber( This_Buttons_Number )
					local e = RPEvents_Numbered[ Place_in_RPEvents_Numbered ]
					RPCONFIG[ e ]["Chance"] = n / 100
				end
			else
				RPEventsFrame_Current_Button:SetText( n )

				local This_Buttons_Number = string.gsub( RPEventsFrame_Current_Button:GetName(), "RPEventsFrameButtonDelay", "" )
				local Place_in_RPEvents_Numbered = ( ( RP_EventsPage - 1 ) * 18 ) + tonumber( This_Buttons_Number )
				local e = RPEvents_Numbered[ Place_in_RPEvents_Numbered ]
				RPCONFIG[ e ]["Delay"] = n
			end
	end

	this:SetText("")
	this:Hide()
	RPEventsFrame_Current_Button:Show()
end

-- Change the colors & countdown (^_^)
function RPEventsFrame_OnUpdate()
	for i = 1, 18 do
		local Event_Number = ( ( RP_EventsPage - 1 ) * 18 ) + i
	    if RPEvents_Numbered[ Event_Number ] then

	    	-- make the event name less opaque if you don't have any RPs
	        local opacity = 1
	        local s, e, c = GetPhrase( RPEvents_Numbered[ Event_Number ] )

     
		    if table.getn( s ) + table.getn( e ) + table.getn( c ) == 0 then
	        	opacity = .5
        		getglobal( "RPEventsFrameButtonDelay"..i ):Hide()
	        	getglobal( "RPEventsFrameButtonChance"..i ):Hide()
			end

			local e = RPEvents_Numbered[ Event_Number ]
			local delay = RPCONFIG[ e ]["Delay"]
			if RPCONFIG[ e ][ "Chance" ] == 0 then      									-- 0% Chance?
				getglobal( "RPEventsFrameFontString" .. i ):SetTextColor(1, 0, 0) 			-- Spellname color (red)
				getglobal( "RPEventsFrameFontStringCountdown" .. i ):SetText( "" )			-- Countdown becomes invisible
			elseif ( GetTime() - LastRP ) < delay then                                       -- Delay?
				local x = delay - ( GetTime() - LastRP )
				getglobal( "RPEventsFrameFontStringCountdown" .. i ):SetText( math.ceil(x) ) -- Countdown text

				local r, g
				if x > delay / 2 then
					r = 1
					g = ( 1 - ( x / delay ) ) * 2
				else
					r = ( x / delay ) * 2
					g = 1
				end
				getglobal( "RPEventsFrameFontString" .. i ):SetTextColor(r, g, 0, opacity) 			-- Spellname color
				getglobal( "RPEventsFrameFontStringCountdown" .. i ):SetTextColor(r, g, 0, opacity) -- Countdown color
			else
				getglobal( "RPEventsFrameFontString" .. i ):SetTextColor(0, 1, 0, opacity) 	-- Spellname color (green)
				getglobal( "RPEventsFrameFontStringCountdown" .. i ):SetText( "" )			-- Countdown becomes invisible
			end

		else
		    getglobal( "RPEventsFrameFontStringCountdown" .. i ):SetText( "" )			-- Countdown becomes invisible
		end
	end
end

function RPEventsFrame_ButtonSpellsToShow_OnClick()
 	RPHelper_SetEventsShown()
 	RP_EventsPage = 1
 	RPEventsFrame_OnShow()
end





-- ScrollFrame tests
function RPScrollChildFrame_OnShow( x )

	local x = "spells"

	-- List on the Left: 1st FontString
	RPScrollChildFrame:CreateFontString("RPScrollChildFrameFontString1", "OVERLAY")
	RPScrollChildFrameFontString1:SetFontObject( GameFontNormal )
	RPScrollChildFrameFontString1:SetText( "1" )
	RPScrollChildFrameFontString1:SetPoint("TOPLEFT", "RPScrollChildFrame", "TOPLEFT", 6, -20 )

	-- Delay FontString
	RPScrollChildFrame:CreateFontString("RPScrollChildFrameFontStringDelay", "OVERLAY")
	RPScrollChildFrameFontStringDelay:SetFontObject( GameFontNormal )
	RPScrollChildFrameFontStringDelay:SetText( "Delay" )
	RPScrollChildFrameFontStringDelay:SetPoint("TOPLEFT", "RPScrollChildFrameFontString1", "TOPLEFT", 153, 17 )

    -- Chance FontString
	RPScrollChildFrame:CreateFontString("RPScrollChildFrameFontStringChance", "OVERLAY")
	RPScrollChildFrameFontStringChance:SetFontObject( GameFontNormal )
	RPScrollChildFrameFontStringChance:SetText( "Chance" )
	RPScrollChildFrameFontStringChance:SetPoint("TOPLEFT", "RPScrollChildFrameFontString1", "TOPLEFT", 212, 17 )

    -- Delay & Chance Buttons
	RPScrollChildFrameButtonDelay1:SetPoint("TOPLEFT", RPScrollChildFrameFontString1, "TOPLEFT", 150, 4 )
	RPScrollChildFrameButtonChance1:SetPoint("TOPLEFT", RPScrollChildFrameFontString1, "TOPLEFT", 210, 4 )
	RPScrollChildFrameButtonDelay1:SetWidth( 50 )
	RPScrollChildFrameButtonChance1:SetWidth( 50 )

	-- Countdown: 1st FontString
	RPScrollChildFrame:CreateFontString("RPScrollChildFrameFontStringCountdown1", "OVERLAY")
	RPScrollChildFrameFontStringCountdown1:SetFontObject( GameFontNormal )
	RPScrollChildFrameFontStringCountdown1:SetText( "Countdown" )
	RPScrollChildFrameFontStringCountdown1:SetPoint("TOPLEFT", "RPScrollChildFrameFontString1", "TOPLEFT", 263, 0 )
	

	-- Get a numbered & sorted list of all of your spells
	RPSpells_localized = {}		-- localized spell names
	RPSpells_english = {}       -- formatted english spell names
	local spelltypes = { "casttime", "channeled", "instant", "next_melee"  }

 	table.foreachi( spelltypes, function( k, spelltype )
	 	table.foreach( SPELLS[spelltype][englishClass], function( formatted_spellname, spellname )
			if not PlaceInArray( RPSpells_localized, spellname ) then  -- Needed since "Corruption" is listed as both "instant" and "casttime"
	        	table.insert( RPSpells_localized, spellname )
			end
	    end)
	end)
    table.sort(RPSpells_localized)


	-- Remove spells not in your Spellbook
	-- HEY ME!!!   WHAT ABOUT "Heal" & "Lesser Heal"?!?!
	if ( RPCONFIG.Spells_to_Show == "All Known" ) or ( RPCONFIG.Spells_to_Show == "Known with RPs" ) then
		local i = 1
		while RPSpells_localized[i] do
		    local j = 1
			local Spell_is_known = false
			while GetSpellName( j, "spell" ) do
				local Spellbook_Spellname = GetSpellName( j, "spell" )
				if string.find( Spellbook_Spellname, RPSpells_localized[i] ) then
				    Spell_is_known = true
				end
		       	j = j + 1
			end
			if not Spell_is_known then
				table.remove( RPSpells_localized, i )
				i = i - 1
			end
			i = i + 1
		end
	end

	-- Kind of a hack but...  Table 'RPSpells_localized' is alphabetically sorted based on the localized language
	-- we need another numbered list of the "English formatted spell names" that matches the same numbers
	table.foreachi( RPSpells_localized, function( keynumber, localized_spell_name )
 		table.foreachi( spelltypes, function( k, spelltype )
	 		table.foreach( SPELLS[spelltype][englishClass], function( formatted_spellname, spellname )
				if spellname == localized_spell_name then
					if not PlaceInArray( RPSpells_english, formatted_spellname ) then -- Same as above
						table.insert( RPSpells_english, formatted_spellname )
					end
				end
			end)
	    end)
	end)

	if ( RPCONFIG.Spells_to_Show == "All with RPs" ) or ( RPCONFIG.Spells_to_Show == "Known with RPs" ) then
        local i = 1
		local Spell_has_RP = false

		while RPSpells_english[i] do
	        local sayings_size, emotes_size, custom_emotes_size, random_size = 0, 0, 0, 0
	        if RPWORDLIST[ RPSpells_english[ i ] ][ englishClass ] then
	        	sayings_size = table.getn( RPWORDLIST[ RPSpells_english[ i ] ][ englishClass ] )
				if RPWORDLIST[ RPSpells_english[ i ] ][ englishClass ][ "emote" ] then
					emotes_size = table.getn( RPWORDLIST[ RPSpells_english[ i ] ][ englishClass ][ "emote" ] )
				end
				if RPWORDLIST[ RPSpells_english[ i ] ][ englishClass ][ "customemote" ] then
					custom_emotes_size = table.getn( RPWORDLIST[ RPSpells_english[ i ] ][ englishClass ][ "customemote" ] )
				end
				if RPWORDLIST[ RPSpells_english[ i ] ][ englishClass ][ "random" ] then
					random_size = table.getn( RPWORDLIST[ RPSpells_english[ i ] ][ englishClass ][ "random" ] )
				end
			end
	        if sayings_size + emotes_size + custom_emotes_size + random_size == 0 then
				table.remove( RPSpells_english, i )
				table.remove( RPSpells_localized, i )
				i = i - 1
	        end
	        i = i + 1
		end
	end

--[[
	-- Give ButtonSpellToShow the correct option
	RPScrollChildFrameButtonSpellsToShow:SetText( RPCONFIG.Spells_to_Show )
]]

	if RPSpells_localized[1] then
		RPScrollChildFrameFontString1:SetText( RPSpells_localized[1] )
	end

	dcf( "RPSpells_localized size=" .. table.getn( RPSpells_localized ) )
	
	fontstring_names = {}
	for i = 2,table.getn( RPSpells_localized ) do
	
	    -- Lefthand side FontString
		RPScrollChildFrame:CreateFontString("RPScrollChildFrameFontString"..i, "OVERLAY")
		getglobal( "RPScrollChildFrameFontString"..i ):SetFontObject( GameFontNormal )
		getglobal( "RPScrollChildFrameFontString"..i ):SetText( RPSpells_localized[i] )
    	getglobal( "RPScrollChildFrameFontString"..i ):SetPoint("TOPLEFT", "RPScrollChildFrameFontString"..i-1, "TOPLEFT", 0, -20 )

	    -- Righthand side Countdown FontString
		RPScrollChildFrame:CreateFontString("RPScrollChildFrameFontStringCountdown"..i, "OVERLAY")
		getglobal( "RPScrollChildFrameFontStringCountdown"..i ):SetFontObject( GameFontNormal )
		getglobal( "RPScrollChildFrameFontStringCountdown"..i ):SetText( i )
    	getglobal( "RPScrollChildFrameFontStringCountdown"..i ):SetPoint("TOPLEFT", "RPScrollChildFrameFontStringCountdown"..i-1, "TOPLEFT", 0, -20 )
    	
    	-- Delay & Chance buttons
    	getglobal( "RPScrollChildFrameButtonDelay"..i ):SetPoint("TOPLEFT", "RPScrollChildFrameButtonDelay"..i-1, "TOPLEFT", 0, -20 )
        getglobal( "RPScrollChildFrameButtonChance"..i ):SetPoint("TOPLEFT", "RPScrollChildFrameButtonChance"..i-1, "TOPLEFT", 0, -20 )
        getglobal( "RPScrollChildFrameButtonDelay"..i ):SetWidth( 50 )
        getglobal( "RPScrollChildFrameButtonChance"..i ):SetWidth( 50 )
        getglobal( "RPScrollChildFrameButtonDelay"..i ):Show()
        getglobal( "RPScrollChildFrameButtonChance"..i ):Show()
	end
	
	for i = table.getn( RPSpells_localized ) + 1, 100 do
	    if getglobal( "RPScrollChildFrameFontString"..i ) then
			getglobal( "RPScrollChildFrameFontString"..i ):SetText( "" )
    		getglobal( "RPScrollChildFrameFontString"..i ):SetPoint("TOPLEFT", "RPScrollChildFrame", "TOPLEFT", 0, 0 )
 			getglobal( "RPScrollChildFrameFontStringCountdown"..i ):SetText( "" )
    		getglobal( "RPScrollChildFrameFontStringCountdown"..i ):SetPoint("TOPLEFT", "RPScrollChildFrame", "TOPLEFT", 0, 0 )

    		getglobal( "RPScrollChildFrameButtonDelay"..i ):SetPoint("TOPLEFT", "RPScrollChildFrame", "TOPLEFT", 0, 0 )
      		getglobal( "RPScrollChildFrameButtonChance"..i ):SetPoint("TOPLEFT", "RPScrollChildFrame", "TOPLEFT", 0, 0 )
    		getglobal( "RPScrollChildFrameButtonDelay"..i ):Hide()
      		getglobal( "RPScrollChildFrameButtonChance"..i ):Hide()
		end
	end
	
	RPScrollFrame:UpdateScrollChildRect()
end 
