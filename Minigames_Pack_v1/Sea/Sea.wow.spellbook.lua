----------------------------------------------------------------------------
-- $Id: SeaSpellbook.lua 184 2006-04-29 03:03:08Z Miravlix $
--
-- WoW SpellBook cache
----------------------------------------------------------------------------

local VERSION = 1.0
local Revision = 0
SeaSpellbook_debug = false

--
-- Setup all our variables and tables
--
	Sea.versions.SeaSpellbook = VERSION

	Sea.wow.spellbook = {
		REVISION = Revision,
		firstRun = true,

		scholars = {},
		[BOOKTYPE_SPELL] = {},
		[BOOKTYPE_PET] = {},
		textures = { [BOOKTYPE_SPELL] = {}, [BOOKTYPE_PET] = {}, },
	}
	table.setn( Sea.wow.spellbook.scholars, 0 )
	table.setn( Sea.wow.spellbook[BOOKTYPE_SPELL], 0 )
	table.setn( Sea.wow.spellbook[BOOKTYPE_PET], 0 )
	table.setn( Sea.wow.spellbook.textures[BOOKTYPE_SPELL], 0 )
	table.setn( Sea.wow.spellbook.textures[BOOKTYPE_PET], 0 )

	local SeaSpellbook_Compare, SeaSpellbook_FindPattern

--
-- ShortCut
--
	SeaSpellbook = Sea.wow.spellbook


--
-- Create a new frame if none exist
--
	if not FRAME then
		FRAME = CreateFrame("Frame", "SeaSpellbookFrame")
	end
	Sea.wow.spellbook.FRAME = FRAME

--
-- Create tooltip frame
--
-- Disabled due to being broken in 1.10.1
--[[
	if not TOOLTIP then
		TOOLTIP = CreateFrame("GameTooltip", "SeaSpellbookTooltip")
		for i = 1, 30 do
			SeaSpellbookTooltip:CreateFontString("SeaSpellbookTooltipTextRight" .. i)
			SeaSpellbookTooltip:CreateFontString("SeaSpellbookTooltipTextLeft" .. i)
		end

--		SeaSpellbookTooltip:SetOwner(SeaSpellbookTooltip, "ANCHOR_NONE")
	end
	Sea.wow.spellbook.TOOLTIP = TOOLTIP
]]--


--
-- OnEvent handler
--
-- We monitor a few events to get our data.
	function Sea.wow.spellbook.OnEvent()
		Sea.wow.spellbook.dprint(SeaSpellbook_debug, "Sea spellbook: ", event, " ", arg1)

		-- Pet spellbook update
		-- UNIT_PET - Call/Dismiss
		-- UNIT_PET_TRAINING_POINTS - Training pet
		if event == "UNIT_PET" and arg1 == "player" or
			event == "UNIT_PET_TRAINING_POINTS" then

			if HasPetSpells() then
				if GetTime() - Sea.wow.spellbook.petTimer > 3 then
					Sea.wow.spellbook[BOOKTYPE_PET] = {}
					SeaSpellbook[BOOKTYPE_PET] = Sea.wow.spellbook[BOOKTYPE_PET]
					Sea.wow.spellbook[BOOKTYPE_PET].petName = UnitName("pet")
					Sea.wow.spellbook.ReadSpellbook( BOOKTYPE_PET )
					Sea.wow.spellbook.petTimer = GetTime()
				end
			else
				Sea.wow.spellbook[BOOKTYPE_PET].petName = nil
			end

		-- When the spellbook change this event is fired
		elseif event == "LEARNED_SPELL_IN_TAB" then
			Sea.wow.spellbook.ReadSpellbook( BOOKTYPE_SPELL, arg1)

		-- Mana cost changes for some spells on level up
		-- Talents effects the spellbook
		elseif event == "PLAYER_LEVEL_UP" or 
			event == "CHARACTER_POINTS_CHANGED" and arg1 == -1 then
			Sea.wow.spellbook.ReadSpellbook( BOOKTYPE_SPELL )

		-- First event where we can always read the spellbook
		elseif event == "PLAYER_ENTERING_WORLD" then
			Sea.wow.spellbook.Pew()

		-- Handle Blizzards Zoning nonsense
		elseif event == "PLAYER_LEAVING_WORLD" then
			this:UnregisterEvent("UNIT_PET")

		-- Initialization
		elseif event == "VARIABLES_LOADED" then
			Sea.wow.spellbook.variablesLoaded = true
			SeaSpellbookTooltip:SetOwner(SeaSpellbookTooltip, "ANCHOR_NONE")
			Sea.wow.spellbook.petTimer = GetTime()

			local _, eClass = UnitClass("player")
			if eClass == "WARLOCK" or eClass == "HUNTER" then
				Sea.wow.spellbook.petClass = true
			end
				
			this:RegisterEvent("PLAYER_ENTERING_WORLD")

			-- Debug due to saving the SeaSpellbook we update here
			SeaSpellbook[BOOKTYPE_SPELL] = Sea.wow.spellbook[BOOKTYPE_SPELL]
			SeaSpellbook[BOOKTYPE_PET] = Sea.wow.spellbook[BOOKTYPE_PET]

			SeaSpellbook.textures[BOOKTYPE_SPELL] = Sea.wow.spellbook.textures[BOOKTYPE_SPELL]
			SeaSpellbook.textures[BOOKTYPE_PET] = Sea.wow.spellbook.textures[BOOKTYPE_PET]

		end
	end

--
-- Register our OnEvent handler with the frame.
--
	FRAME:SetScript("OnEvent", Sea.wow.spellbook.OnEvent)


--
-- Setup our initialization event
--
	FRAME:RegisterEvent("VARIABLES_LOADED")


--
-- Pew()
--
-- PLAYER_ENTERING_WORLD
	function Sea.wow.spellbook.Pew()
		Sea.wow.spellbook.pew = true

		-- If no one has registered with us, we don't do any work
		if  table.getn( Sea.wow.spellbook.scholars ) > 0 then
			-- Only do the setup once
			if Sea.wow.spellbook.firstRun then
				Sea.wow.spellbook.firstRun = false

				Sea.wow.spellbook.ReadSpellbook( BOOKTYPE_SPELL )

				if Sea.wow.spellbook.petClass and HasPetSpells() then
					Sea.wow.spellbook[BOOKTYPE_PET].petName = UnitName("pet")
					Sea.wow.spellbook.ReadSpellbook( BOOKTYPE_PET )
					Sea.wow.spellbook.petTimer = GetTime()
				end

				-- Register our events now we are ready to handle them
				this:RegisterEvent("PLAYER_LEVEL_UP")
				this:RegisterEvent("LEARNED_SPELL_IN_TAB")
				this:RegisterEvent("CHARACTER_POINTS_CHANGED")

				if Sea.wow.spellbook.petClass then
					this:RegisterEvent("UNIT_PET_TRAINING_POINTS")
					this:RegisterEvent("PLAYER_LEAVING_WORLD")
				else
					this:UnregisterEvent("PLAYER_ENTERING_WORLD")
				end
			end

			-- Zone event overload fix
			if Sea.wow.spellbook.petClass then
				this:RegisterEvent("UNIT_PET")

				if Sea.wow.spellbook[BOOKTYPE_PET].petName then
					Sea.wow.spellbook.petTimer = GetTime()
				end
			end

		end

	end


--
-- RegisterScholar( { scholar } )
--	scholar - table
--		{
--			id		- Unique id for the scholar
--			callback	- callback function
--				callback( bookType )
--
--					bookType - 1 spellbook, 2 petbook, 3 both
--
--			feedback	- table
--				{
--					spell = true,	- Set this to get called when the spellbook updates
--					pet = true,	- And for petbook updates.
--				}
--
--			description	- description string
--		}
--
-- Register a scholar with the specified id, that will be informed when the spellbook change
	function Sea.wow.spellbook.RegisterScholar( scholar )
		-- Are we ready to rumble!
		if not  Sea.wow.spellbook.variablesLoaded then
			Sea.wow.spellbook.print("SeaSpellbook: ", this:GetName(), " called us before we where initialized")
			return false
		end

		-- Check that scholar seems correct
		if not Sea.wow.spellbook.VerifyScholar( scholar ) then
			return false
		end

		local scholars = Sea.wow.spellbook.scholars

		-- Avoid that the same function is registered multiple times
		if table.getn( scholars ) > 0 then
			for i=1, table.getn( scholars ) do
				if scholars[i].id == scholar.id then
					Sea.wow.spellbook.print("SeaSpellbook: ", this:GetName(), " tried to register an already registered scholar.id")
					return false
				end
			end
		end

		tinsert( scholars, scholar )

		-- Call the newly created Scholar
		if Sea.wow.spellbook.pew and Sea.wow.spellbook.firstRun then
			Sea.wow.spellbook.Pew()
		elseif Sea.wow.spellbook.pew and not Sea.wow.spellbook.firstRun then
			local success, result = pcall( scholar.callback, bookType )
			if not success then
				message( result )
				Sea.wow.spellbook.print( "SeaSpellbook: Failed calling ", scholar.id )
				tremove(scholars, table.getn(scholars) )

				return false
			end
		end

		return true
	end
	SeaSpellbook.RegisterScholar = Sea.wow.spellbook.RegisterScholar


--
-- UnregisterScholar( id )
--
--
-- Remove a registered Scholar
	function Sea.wow.spellbook.UnregisterScholar( id )
		local scholars = Sea.wow.spellbook.scholars

		if table.getn( scholars ) > 0 then
			for i=1, table.getn( scholars ) do
				if scholars[i].id == id then
					tremove( scholars, i )
					return true
				end
			end
		end

		Sea.wow.spellbook.print("SeaSpellbook: ", this:GetName(), " tried to unregister unknown scholar id.")
		return false
	end
	SeaSpellbook.UnregisterScholar = Sea.wow.spellbook.UnregisterScholar


--
-- CallScholars( bookType )
--
-- Call the registered Scholars
	function Sea.wow.spellbook.CallScholars( bookType )
		local scholars = Sea.wow.spellbook.scholars

		for key, value in scholars do
			if value.feedback[bookType] then
				local success, result = pcall( value.callback, bookType )
				if not success then
					message( result )
					Sea.wow.spellbook.print( "SeaSpellbook: Failed calling ", value.id )
					tremove(scholars, key)
				end
			end
		end
	end


--
-- VerifyScholar( scholar )
--
-- Verify's that a correct scholar table has been submitted to us
	function Sea.wow.spellbook.VerifyScholar( scholar )
		if type(scholar) ~= "table" then
			Sea.wow.spellbook.print("SeaSpellbook: ", this:GetName(), " called us with an incorrect scholar.")
			return false
		end

		if not scholar.id then
			Sea.wow.spellbook.print("SeaSpellbook: ", this:GetName(), " called us with missing scholar.id.")
			return false
		end

		if not scholar.callback then
			Sea.wow.spellbook.print("SeaSpellbook: ", this:GetName(), " called us with missing scholar.callback.")
			return false
		end

		if type(scholar.callback) ~= "function" then
			Sea.wow.spellbook.print("SeaSpellbook: ", this:GetName(), " called us with incorrect scholar.callback.")
			return false
		end

		if not scholar.feedback then
			Sea.wow.spellbook.print("SeaSpellbook: ", this:GetName(), " called us with missing scholar.feedback.")
			return false
		end

		if type(scholar.feedback) ~= "table" then
			Sea.wow.spellbook.print("SeaSpellbook: ", this:GetName(), " called us with incorrect scholar.feedback.")
			return false
		end

		if not scholar.feedback.pet and not scholar.feedback.spell then
			Sea.wow.spellbook.print("SeaSpellbook: ", this:GetName(), " called us with no known feedback selection.")
			return false
		end

		if not scholar.description then
			Sea.wow.spellbook.print("SeaSpellbook: ", this:GetName(), " called us with missing scholar.description")
			return false
		end

		if type(scholar.description) ~= "string" then
			Sea.wow.spellbook.print("SeaSpellbook: ", this:GetName(), " called us with incorrect scholar.description.")
			return false
		end

		return true
	end


--
-- ReadSpellbook( spellTab )
--	No arguments and it reads all tabs
--	spellTab # - To only update that tab
--
-- Function to decide how much of the spellbook we should read.
	function Sea.wow.spellbook.ReadSpellbook( bookType, spellTab )
		if bookType == BOOKTYPE_SPELL then
			if tonumber ( spellTab ) then
				Sea.wow.spellbook.ReadSpellTab( bookType, spellTab )
			else
				for i=1, GetNumSpellTabs() do
					Sea.wow.spellbook.ReadSpellTab( bookType, i )
				end
			end
		else
			Sea.wow.spellbook.ReadSpellTab(bookType)
		end

		Sea.wow.spellbook.CallScholars( bookType )
	end


	--
	-- ReadSpellTab( bookType, tabIndex )
	--	bookType = "spell" or "pet"
	--	tabIndex = Spellbook tab #
	--
	-- Reads a tab in the spellbook into our table
	function Sea.wow.spellbook.ReadSpellTab( bookType, tabIndex )
		local startIndex = 1
		local i = 1
		local maxIndex

		-- Shortcuts for easy access to our tables
		local spells	= Sea.wow.spellbook[bookType]
		local textures	= Sea.wow.spellbook.textures

		if bookType == BOOKTYPE_SPELL then
			-- Get the spell index we should start with.
			while i < tabIndex do
				local _, _, _, numSpells = GetSpellTabInfo( i )
				startIndex = startIndex + numSpells
				i = i + 1
			end

			-- Get the number of spells we should read
			local _, _, _, numSpells = GetSpellTabInfo( tabIndex )

			-- Since we calculated up to this point already, we reuse
			-- startIndex, but has to subtract 1.
			maxIndex = ( startIndex - 1 ) + numSpells
		else
			maxIndex, petToken = HasPetSpells()
		end
			
		-- Do the work of reading the choosen list of spells
		for index=startIndex, maxIndex  do
			local spellName, spellRank = GetSpellName( index, bookType )
			local spellTexture = GetSpellTexture( index, bookType )

			-- This code removes anything that isn't numbers, so even while spellRank
			-- isn't localized, we should still always parse it correctly.
			local rank, _ = gsub( spellRank, "(%D+)", "", 1 )
			rank = tonumber( rank )

			-- Unranked?
			if not rank then
				rank = 0
			end

			-- Did the ID change, the wipe and start over
			if spells[spellName] and
				spells[spellName][rank] and
				spells[spellName][rank].ID ~= index then

				tremove( spells, spellName )
			end

			-- Main database of spells initialization
			if not spells[spellName] then
				spells[spellName] = {}
				table.setn( spells, table.getn(spells) + 1 )
			end

			if not spells[spellName][rank] then
				spells[spellName][rank] = {}
				spells[spellName][rank].ID = index
			end
			spells[spellName].spellTexture = spellTexture

			if bookType == BOOKTYPE_PET then
				local autoCast, _ = GetSpellAutocast( index, BOOKTYPE_PET )
				if autoCast then
					spells[spellName].autoCast = true
				end
			end
				


			-- texture database for searching quicker
			local found = false
			if not textures[bookType][spellTexture] then
				textures[bookType][spellTexture] = {}
			else
				-- No need to add double textures for multi rank spells
				for i=1, table.getn( textures[bookType][spellTexture] ) do
					if textures[bookType][spellTexture][i] == spellName then
						found = true
						break
					end
				end
			end
			if not found then
				tinsert( textures[bookType][spellTexture], spellName )
--				table.setn(textures[bookType][spellTexture], table.getn(textures[bookType][spellTexture]) + 1)
			end

			-- The very slow tooltip scanning
			Sea.wow.spellbook.GetSpellDetails( index, bookType, spells[spellName][rank] )
			spells[spellName][rank].rank = spellRank

			if rank ~= 0 then
				spells[spellName][0] = spells[spellName][rank]
			end
		end
	end


	--
	-- GetSpellDetails( index, bookType, spellType )
	--	index		= Spell Index
	--	bookType	= "spell" or "pet"
	--	spellTable	= Where we store the data
	--
	--	Returns a table: {
	--		ID		- SpellID for the spell in the spellbook
	--		castTime	- positive secs of cast time
	--				-  0 Channeled
	--				- -1 Instant Cast
	--				- -2 Instant
	--				- -3 Next melee / Next Ranged
	--		crit		- x.x% crit chance
	--		manaCost	- Mana cost
	--		energyCost	- Energy cost
	--		rageCost	- Rage cost
	--		minRange	- Casting min range to target
	--		maxRange	- Casting max range to target
	--		cooldown	- cooldown between casts in seconds
	--	These variables aren't localized
	--		requires	- What is required before the spell can be cast?
	--		tools		- Tools required to cast the spell
	--		reagents	- Reagents required to cast the spell
	--		description	- Description
	--
	-- Read the tooltip to get detailed information about a spell
	function Sea.wow.spellbook.GetSpellDetails( index, bookType, spellTable )
		spellTable.ID = index

		-- Clear the tooltip so we don't have old data
		SeaSpellbookTooltip:ClearLines()

		-- ClearLines() doesn't clear the Right/Left
		SeaSpellbookTooltipTextRight1:SetText()
		SeaSpellbookTooltipTextRight2:SetText()
		SeaSpellbookTooltipTextRight3:SetText()
		SeaSpellbookTooltipTextRight4:SetText()
		SeaSpellbookTooltipTextRight5:SetText()

		-- Set the tooltip with a spell
		SeaSpellbookTooltip:SetSpell( index, bookType )

		local tooltipText, temp
		-- L1 name
		-- Ignored

		for runSide = 1, 2 do
			if runSide == 1 then
				tooltipSide = "Left"
			else
				tooltipSide = "Right"
			end

			for runLevel = 2, 6 do
				tooltipText = getglobal("SeaSpellbookTooltipText" .. tooltipSide .. runLevel):GetText()

				if tooltipText == nil then
					-- Do nothing

				--	Instant
				elseif runLevel >= 2 and runLevel <= 3 and runSide == 1 and
					SEASPELLBOOK_INSTANT.func( tooltipText, SEASPELLBOOK_INSTANT.string ) then
					spellTable.castTime = -2

				--	Instant cast
				elseif runLevel == 3 and runSide == 1 and
					SEASPELLBOOK_INSTANTCAST.func( tooltipText, SEASPELLBOOK_INSTANTCAST.string ) then

					spellTable.castTime = -1

				--	Channeled
				elseif runLevel == 3 and runSide == 1 and
					SEASPELLBOOK_CHANNELED.func( tooltipText, SEASPELLBOOK_CHANNELED.string ) then

					spellTable.castTime = 0

				--	Next melee
				elseif runLevel == 3 and runSide == 1 and
					SEASPELLBOOK_NEXTMELEE.func( tooltipText, SEASPELLBOOK_NEXTMELEE.string ) then

					spellTable.castTime = -3

				--	Attack Speed
				elseif runLevel == 3 and runSide == 1 and
					SEASPELLBOOK_NEXTRANGED.func( tooltipText, SEASPELLBOOK_NEXTRANGED.string ) then

					spellTable.castTime = -3

				--	#.#% chance to crit
				elseif runLevel == 2 and runSide == 1 and
					SEASPELLBOOK_CRITCHANCE.func( tooltipText, SEASPELLBOOK_CRITCHANCE.string ) then

					temp, _ = gsub(tooltipText, SEASPELLBOOK_CRITCHANCE.string, "%1")
					spellTable.crit = tonumber( temp )

				--	#.#% chance to parry
				elseif runLevel == 3 and runSide == 1 and
					SEASPELLBOOK_PARRYCHANCE.func( tooltipText, SEASPELLBOOK_PARRYCHANCE.string ) then

					temp, _ = gsub(tooltipText, SEASPELLBOOK_PARRYCHANCE.string, "%1")
					spellTable.parry = tonumber( temp )

				--	#.#% chance to block
				elseif runLevel == 3 and runSide == 1 and
					SEASPELLBOOK_BLOCKCHANCE.func( tooltipText, SEASPELLBOOK_BLOCKCHANCE.string ) then

					temp, _ = gsub(tooltipText, SEASPELLBOOK_BLOCKCHANCE.string, "%1")
					spellTable.block = tonumber( temp )

				--	#.#% chance to dodge
				elseif runLevel == 2 and runSide == 1 and
					SEASPELLBOOK_DODGECHANCE.func( tooltipText, SEASPELLBOOK_DODGECHANCE.string ) then

					temp, _ = gsub(tooltipText, SEASPELLBOOK_DODGECHANCE.string, "%1")
					spellTable.dodge = tonumber( temp )

				--	# Mana
				elseif runLevel == 2 and runSide == 1 and
					SEASPELLBOOK_MANA.func(tooltipText, SEASPELLBOOK_MANA.string ) then

					temp, _ = gsub(tooltipText, SEASPELLBOOK_MANA.string, "%1")
					spellTable.manaCost = tonumber( temp )

				--	# Focus
				elseif runLevel == 2 and runSide == 1 and
					SEASPELLBOOK_FOCUS.func(tooltipText, SEASPELLBOOK_FOCUS.string ) then

					temp, _ = gsub(tooltipText, SEASPELLBOOK_FOCUS.string, "%1")
					spellTable.focusCost = tonumber( temp )

				--	Uses 100% mana
				elseif runLevel == 4 and runSide == 1 and
					SEASPELLBOOK_MANAALL.func(tooltipText, SEASPELLBOOK_MANAALL.string ) then

					spellTable.manaCost = -1

				--	# Energy
				elseif runLevel == 2 and runSide == 1 and
					SEASPELLBOOK_ENERGY.func(tooltipText, SEASPELLBOOK_ENERGY.string ) then

					temp, _ = gsub(tooltipText, SEASPELLBOOK_ENERGY.string, "%1")
					spellTable.energyCost = tonumber( temp )

				--	# Rage
				elseif runLevel == 2 and runSide == 1 and
					SEASPELLBOOK_RAGE.func(tooltipText, SEASPELLBOOK_RAGE.string ) then

					temp, _ = gsub(tooltipText, SEASPELLBOOK_RAGE.string, "%1")
					spellTable.rageCost = tonumber( temp )

				--	10 sec cast
				elseif runLevel >= 2 and runLevel <= 3 and runSide == 1 and
					SEASPELLBOOK_CASTTIME.func( tooltipText, SEASPELLBOOK_CASTTIME.string ) then

					temp, _ = gsub( tooltipText, SEASPELLBOOK_CASTTIME.string, "%1" )
					spellTable.castTime = tonumber( temp )

				--	8-25 yd range
				elseif ( runLevel == 2 and runSide == 1 or runSide == 2 ) and
					SEASPELLBOOK_RANGEMINMAX.func( tooltipText, SEASPELLBOOK_RANGEMINMAX.string ) then

					_, _, spellTable.minRange, spellTable.maxRange = string.find( tooltipText, SEASPELLBOOK_RANGEMINMAX.string )

					spellTable.maxRange = tonumber( spellTable.maxRange )
					spellTable.minRange = tonumber( spellTable.minRange )

				--	5 yd range
				elseif ( runLevel == 2 and runSide == 1 or runSide == 2 ) and
					SEASPELLBOOK_RANGE.func( tooltipText, SEASPELLBOOK_RANGE.string ) then

					temp, _ = gsub( tooltipText, SEASPELLBOOK_RANGE.string, "%1" )
					spellTable.maxRange = tonumber( temp )

				--	Requires Cat Form
				elseif runLevel >= 2 and runLevel <= 5 and runSide == 1 and
					SEASPELLBOOK_REQUIRES.func( tooltipText, SEASPELLBOOK_REQUIRES.string ) then

					if spellTable.requires then
						spellTable.requires = spellTable.requires .. ", " .. gsub( tooltipText, SEASPELLBOOK_REQUIRES.string, "%1" )
					else
						spellTable.requires = gsub( tooltipText, SEASPELLBOOK_REQUIRES.string, "%1" )
					end

				--	Tools: |cffff2020Flint and Tinder|r
				elseif runLevel >= 3 and runLevel <= 4 and runSide == 1 and
					SEASPELLBOOK_TOOLS.func( tooltipText, SEASPELLBOOK_TOOLS.string ) then

					spellTable.tools = gsub( tooltipText, SEASPELLBOOK_TOOLS.string, "%1" )

				--	Reagents: |cffff2020Simple Wood|r
				elseif runLevel >= 3 and runLevel <= 4 and runSide == 1 and
					SEASPELLBOOK_REAGENTS.func( tooltipText, SEASPELLBOOK_REAGENTS.string ) then

					spellTable.reagents = gsub( tooltipText, SEASPELLBOOK_REAGENTS.string, "%1" )

				--	# min cooldown
				elseif runSide == 2 and
					SEASPELLBOOK_COOLDOWN_MIN.func( tooltipText, SEASPELLBOOK_COOLDOWN_MIN.string ) then

					_, _, spellTable.cooldown, _ = string.find( tooltipText, SEASPELLBOOK_COOLDOWN_MIN.string )
					spellTable.cooldown = 60 * spellTable.cooldown

				--	# sec cooldown
				elseif runSide == 2 and
					SEASPELLBOOK_COOLDOWN_SEC.func( tooltipText, SEASPELLBOOK_COOLDOWN_SEC.string ) then

					_, _, spellTable.cooldown, _ = string.find( tooltipText, SEASPELLBOOK_COOLDOWN_SEC.string )
					spellTable.cooldown = tonumber( spellTable.cooldown )

				--	Description
				elseif runLevel >= 2 and runLevel <= 6 and runSide == 1 then
					spellTable.description = tooltipText

				end
			end
		end

		if SeaSpellbook_debug then
			spellTable.debug = {}
			for i = 1, SeaSpellbookTooltip:NumLines() do
				spellTable.debug["R"..i] = getglobal( "SeaSpellbookTooltipTextRight" .. i):GetText()
				spellTable.debug["L"..i] = getglobal( "SeaSpellbookTooltipTextLeft" .. i):GetText()
			end
		end
	end


--
-- Sea.io support
--
	Sea.wow.spellbook.print = Sea.IO.print
	Sea.wow.spellbook.dprint = Sea.IO.dprint


--
-- Compare two values and return true or false
--
	local function SeaSpellbook_Compare(var1, var2)
		if var1 == var2 then
			return true
		else
			return false
		end
	end

--
-- Find pattern var2 in var1
--
	local function SeaSpellbook_FindPattern(var1, var2)
		if string.find(var1, var2) then
			return true
		else
			return false
		end
	end

--
-- Everything here is localized by using GlobalStrings.lua
--
	SEASPELLBOOK_INSTANT = {
		string = SPELL_CAST_TIME_INSTANT_NO_MANA,
		func = SeaSpellbook_Compare,
	}
	SEASPELLBOOK_INSTANTCAST = {
		string = SPELL_CAST_TIME_INSTANT,
		func = SeaSpellbook_Compare,
	}
	SEASPELLBOOK_NEXTMELEE = {
		string = SPELL_ON_NEXT_SWING,
		func = SeaSpellbook_Compare,
	}
	SEASPELLBOOK_NEXTRANGED = {
		string = SPELL_ON_NEXT_RANGED,
		func = SeaSpellbook_Compare,
	}
	SEASPELLBOOK_CRITCHANCE = {
		string = gsub(CHANCE_TO_CRIT, "%%%.2f%%%%", "(%%d+.%%d+)%%%%"),
		func = SeaSpellbook_FindPattern,
	}
	SEASPELLBOOK_DODGECHANCE = {
		string = gsub(CHANCE_TO_DODGE, "%%%.2f%%%%", "(%%d+.%%d+)%%%%"),
		func = SeaSpellbook_FindPattern,
	}
	SEASPELLBOOK_PARRYCHANCE = {
		string = gsub(CHANCE_TO_PARRY, "%%%.2f%%%%", "(%%d+.%%d+)%%%%"),
		func = SeaSpellbook_FindPattern,
	}
	SEASPELLBOOK_BLOCKCHANCE = {
		string = gsub(CHANCE_TO_BLOCK, "%%%.2f%%%%", "(%%d+.%%d+)%%%%"),
		func = SeaSpellbook_FindPattern,
	}
	SEASPELLBOOK_MANA = {
		string = gsub(MANA_COST, "%%d", "(%%d)"),
		func = SeaSpellbook_FindPattern,
	}
	SEASPELLBOOK_FOCUS = {
		string = gsub(FOCUS_COST, "%%d", "(%%d)"),
		func = SeaSpellbook_FindPattern,
	}
	SEASPELLBOOK_MANAALL = {
		string = SPELL_USE_ALL_MANA,
		func = SeaSpellbook_Compare,
	}
	SEASPELLBOOK_ENERGY = {
		string = gsub(ENERGY_COST, "%%d", "(%%d)"),
		func = SeaSpellbook_FindPattern,
	}
	SEASPELLBOOK_RAGE = {
		string = gsub(RAGE_COST, "%%d", "(%%d)"),
		func = SeaSpellbook_FindPattern,
	}
	SEASPELLBOOK_CASTTIME = {
		string = gsub(SPELL_CAST_TIME_SEC, "%%%.3g", "(%%d%%%.%?%%d%*)"),
		func = SeaSpellbook_FindPattern,
	}
	SEASPELLBOOK_RANGE = {
		string = gsub(SPELL_RANGE, "%%s", "(%%d)"),
		func = SeaSpellbook_FindPattern,
	}
	SEASPELLBOOK_REQUIRES = {
		string = "^" .. gsub(SPELL_EQUIPPED_ITEM, "%%s", "(.+)"),
		func = SeaSpellbook_FindPattern,
	}
	SEASPELLBOOK_TOOLS = {
		string = SPELL_TOTEMS .. "(.+)",
		func = SeaSpellbook_FindPattern,
	}
	SEASPELLBOOK_REAGENTS = {
		string = SPELL_REAGENTS .. "(.+)",
		func = SeaSpellbook_FindPattern,
	}
	SEASPELLBOOK_RANGEMINMAX = {
		string = gsub(SPELL_RANGE, "%%s", "(%%d+)%%-(%%d+)"),
		func = SeaSpellbook_FindPattern,
	}
	SEASPELLBOOK_COOLDOWN_MIN = {
		string = gsub(SPELL_RECAST_TIME_MIN, "%%.3g", "(%%d*.*%%d)"),
		func = SeaSpellbook_FindPattern,
	}
	SEASPELLBOOK_COOLDOWN_SEC = {
		string = gsub(SPELL_RECAST_TIME_SEC, "%%.3g", "(%%d*.*%%d)"),
		func = SeaSpellbook_FindPattern,
	}
	SEASPELLBOOK_CHANNELED = {
		string = SPELL_CAST_CHANNELED,
		func = SeaSpellbook_Compare,
	}
