NanoStats = AceAddon:new({
    name            = NanoStatsLocals.NAME,
    description     = NanoStatsLocals.DESCRIPTION,
    version         = NanoStatsLocals.VERSION,
    releaseDate     = NanoStatsLocals.DATE,
    aceCompatible   = "103",
    author          = "Neronix",
    email           = "neronix@gmail.com",
    category        = "combat",
    cmd             = AceChatCmd:new(NanoStatsLocals.COMMANDS, NanoStatsLocals.CMD_OPTIONS),
})

-- Register embedded libs
local tablet = TabletLib:GetInstance("1.0")
local dewdrop = DewdropLib:GetInstance("1.0")
local babble = BabbleLib:GetInstance("Deformat 1.2")
local metrognome = Metrognome:GetInstance("1")

--[[
		Initialization
--]]


function NanoStats:Initialize()
-- No Config table --> first time user --> Create defaults table
    if ( not NanoStatsConfig ) then
        NanoStatsConfig = {
            Damage = TRUE,
            Healing = TRUE,
			-- Other defualts are FALSE, which is equal to nil, which means we don't need to define them
        }
        -- Other defaults filled in by TabletLib
    end
	

    -- We call this to initialise the variables used for data and calculations
	-- If we don't initialise here, we get "zOMGWTFBBQ arithmetic on nil! GYAAAAA!!!" errors
    NanoStats:ResetSession()

    -- Initial text for the tablet
	NanoStats.DurationDisplay = NanoStatsLocals.MESSAGE_NODATA
    NanoStats.DamageDisplay = NanoStatsLocals.MESSAGE_NODATA
    NanoStats.SessionDamageDisplay = NanoStatsLocals.MESSAGE_NODATA
    NanoStats.HealingDisplay = NanoStatsLocals.MESSAGE_NODATA
    NanoStats.SessionHealingDisplay = NanoStatsLocals.MESSAGE_NODATA

	-- If we're in non-Fu mode, we'll now create the tablet for display
	if ( not NanoStatsFu ) then
	
		-- Define non-fu Enable and Disable
		function NanoStats:Enable()
			tablet:Open(NanoStats.TabletParent)
			NanoStats.EventRegistrar()
		end

		function NanoStats:Disable()
			NanoStats:UnregisterAllEvents()
			tablet:Close(NanoStats.TabletParent)
			-- Stop processing, just in case the luser decides to disable while in combat
			NanoStats:EndCombat()

		end

		-- Since NSFu's not present, we'll define our version of this.
		-- I could've defined this like any other function, but then NSFu would overwrite it, causing garbage
		function NanoStats:Refresh()
			tablet:Refresh(NanoStats.TabletParent)
		end
		-- Making a string to act as the tablet's parent
		NanoStats.TabletParent = "NanoStatsTabletParent"
		-- Create the tablet
		tablet:Register(NanoStats.TabletParent,
		-- Create config menu via DewDrop
			'menu', function()
				-- For NSFu, the dewdrop stuff has to go elsewhere, but otherwise, the code for it's the same
				NanoStats:DropDownMenu()
			end,
			'cantAttach', true,
			'detachedData', NanoStatsConfig,
			'children', function()
				tablet:SetTitle("NanoStats") -- If there's no text to display (ie, the user turned everything off)
											 -- Then the title will be displayed
				NanoStats:TabletContents()
			end
		)
	else
		-- Define Enable and Disable for Fu mode
		function NanoStats:Enable()
			NanoStats.EventRegistrar()
		end
	
		function NanoStats:Disable()
			NanoStats:UnregisterAllEvents()
			-- Stop processing, just in case the luser decides to disable while in combat
			NanoStats:EndCombat()
		end
	end

    metrognome:Register("NSUpdate", NanoStats.Update, 1)

end


--[[
		Contents for the tablet and dropdown menus
		When NSFu's not present, NS calls this code to create its tablet display and dropdown menu
		When NSFu is present, NSFu calls this code to create its tooltip and dropdown menu
--]]


-- In non-Fu mode, this is called under the children section of the tablet registration
-- In Fu mode, this is called by UpdateTooltip
function NanoStats:TabletContents()
	local cat = tablet:AddCategory()
	-- Line 1: Current/last battle duration
	if ( NanoStatsConfig.Duration == TRUE ) then
		cat:AddLine(
			'text', NanoStats.DurationDisplay,
			'justify', "CENTER",
			'wrap', false,
			'textR', 1,
			'textG', 1,
			'textB', 1
		)
	end
	-- Line 2: Current/last battle damage info
	if ( NanoStatsConfig.Damage == TRUE ) then
		cat:AddLine(
			'text', NanoStats.DamageDisplay,
			'justify', "CENTER",
			'wrap', false,
			'textR', 1,
			'textG', 0,
			'textB', 0
		)
	end
	-- Line 3: Session damage total
	if ( NanoStatsConfig.SessionDamage == TRUE ) then
		cat:AddLine(
			'text', NanoStats.SessionDamageDisplay,
			'justify', "CENTER",
			'wrap', false,
			'textR', 1,
			'textG', 0,
			'textB', 0
		)
	end
	-- Line 4: Current/last battle healing info
	if ( NanoStatsConfig.Healing == TRUE ) then
		cat:AddLine(
			'text', NanoStats.HealingDisplay,
			'justify', "CENTER",
			'wrap', false,
			'textR', 0,
			'textG', 1,
			'textB', 0
		)
	end
	-- Line 5: Session healing total
	if ( NanoStatsConfig.SessionHealing == TRUE ) then
		cat:AddLine(
			'text', NanoStats.SessionHealingDisplay,
			'justify', "CENTER",
			'wrap', false,
			'textR', 0,
			'textG', 1,
			'textB', 0
		)
	end
end

-- In non-Fu mode, this is called by the menu section of the tablet registration
-- In Fu mode, this is called by MenuSettings
function NanoStats:DropDownMenu()
	-- Line 1: Toggle Duration
	dewdrop:AddLine(
		'text', NanoStatsLocals.CONFIG_TOGGLEDURATION,
		'checked', (NanoStatsConfig.Duration),
		'arg1', NanoStats,
		'arg2', "Duration",
		'func', "ToggleOpt"
	)
	-- Line 2: Toggle Damage
	dewdrop:AddLine(
		'text', NanoStatsLocals.CONFIG_TOGGLEDAMAGE,
		'checked', (NanoStatsConfig.Damage),
		'arg1', NanoStats,
		'arg2', "Damage",
		'func', "ToggleOpt"
	)
	-- Line 3: Toggle Session Damage
	dewdrop:AddLine(
		'text', NanoStatsLocals.CONFIG_TOGGLESESSIONDAMAGE,
		'checked', (NanoStatsConfig.SessionDamage),
		'arg1', NanoStats,
		'arg2', "SessionDamage",
		'func', "ToggleOpt"
	)
	-- Line 4: Toggle Healing
	dewdrop:AddLine(
		'text', NanoStatsLocals.CONFIG_TOGGLEHEALING,
		'checked', (NanoStatsConfig.Healing),
		'arg1', NanoStats,
		'arg2', "Healing",
		'func', "ToggleOpt"
	)
	-- Line 5: Toggle Session Healing
	dewdrop:AddLine(
		'text', NanoStatsLocals.CONFIG_TOGGLESESSIONHEALING,
		'checked', (NanoStatsConfig.SessionHealing),
		'arg1', NanoStats,
		'arg2', "SessionHealing",
		'func', "ToggleOpt"
	)
	-- Line 6: Reset Session
	dewdrop:AddLine(
		'text', NanoStatsLocals.CONFIG_RESETSESSION,
		'func', function()
			NanoStats:ResetSession()
			NanoStats:Refresh()
		end
	)
end


--[[
		Misc Functions
--]]

function NanoStats:ResetSession()
	NanoStats.TotalDamageThisBattle = 0
    NanoStats.TotalHealingThisBattle = 0
    NanoStats.TotalDamageThisSession = 0
    NanoStats.TotalHealingThisSession = 0
    NanoStats.CurrentDPS = 0
    NanoStats.CurrentHPS = 0
    NanoStats.DurationOfThisBattle = 0
end

function NanoStats:ToggleOpt(VarName) -- VarName is a string
	NanoStatsConfig[VarName] = Ace.toggle(NanoStatsConfig[VarName])
	NanoStats:Refresh()
	NanoStats:EventRegistrar()
end


--[[
		The updater, called every Metrognome tick. What it does should be obvious
--]]

function NanoStats.Update()

    NanoStats.DurationOfThisBattle = NanoStats.DurationOfThisBattle + 1

	if ( NanoStatsConfig.Duration == TRUE ) then NanoStats.DurationDisplay = NanoStatsLocals.WORD_DURATION..": "..NanoStats.DurationOfThisBattle.."s" end
    if ( NanoStatsConfig.Damage == TRUE ) then NanoStats:SetTabletDamageDisplay() end
    if ( NanoStatsConfig.Healing == TRUE ) then NanoStats:SetTabletHealingDisplay() end
	-- There is no space between the Session and Quantity words in German. For other languages, we just add the space in the string
    if ( NanoStatsConfig.SessionDamage == TRUE ) then NanoStats.SessionDamageDisplay = NanoStats.TotalDamageThisSession.." "..NanoStatsLocals.WORD_SESSION..NanoStatsLocals.WORD_DAMAGE end
    if ( NanoStatsConfig.SessionHealing == TRUE ) then NanoStats.SessionHealingDisplay = NanoStats.TotalHealingThisSession.." "..NanoStatsLocals.WORD_SESSION..NanoStatsLocals.WORD_HEALING end

    NanoStats:Refresh()
end


--[[
		Oh noes! We aggroed the event registrar! He'll wipe us! :O
		Called on Enable() and every config change
--]]

function NanoStats:EventRegistrar()

    --[[
    I'll explain what my approach with this is:
    
    Code to unregister only the uneeded events is unnecessary.
    The unperceptible performance increase won't matter because the player will only be changing
    settings while idle - not in combat.
    Will still be unperceptible during login/reloadui because there's initally no events to unregister
    Not having the code will also free up some memory. Said memory will always be available, unlike the
    unperceptible performance boost.
    
    Hence, I'll take the unregister-everything-and-reregister-as-appropriate route
    --]]
    NanoStats:UnregisterAllEvents()

    -- Are we in combat?
    NanoStats:RegisterEvent("PLAYER_REGEN_DISABLED", "BeginCombat")
    NanoStats:RegisterEvent("PLAYER_REGEN_ENABLED", "EndCombat")

    -- Damage
    if ( NanoStatsConfig.Damage == TRUE ) or ( NanoStatsConfig.SessionDamage == TRUE ) then
        NanoStats:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS") -- Player melee hits
        NanoStats:RegisterEvent("CHAT_MSG_COMBAT_PET_HITS") -- Pet melee hits
        NanoStats:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE") -- Player spell hits, also melee skills
        NanoStats:RegisterEvent("CHAT_MSG_SPELL_PET_DAMAGE") -- Pet spell hits
        NanoStats:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE") -- Player DoT ticks on mobs/NPCs
        NanoStats:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE") -- Player DoT ticks on other players
        NanoStats:RegisterEvent("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF")	-- Lightning Shield, Thorns, Fire Shield, etc.
    end

    -- Healing
    -- The name of the HoT handler method is in ckknight's honour, for all his help :P
    if ( NanoStatsConfig.Healing == TRUE ) or ( NanoStatsConfig.SessionHealing == TRUE ) then
        NanoStats:RegisterEvent("CHAT_MSG_SPELL_SELF_BUFF", "Event_DirectHeals")  -- Direct heals
        NanoStats:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS", "ckknight") -- HoTs on player
	    NanoStats:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS", "ckknight") -- HoTs on other players
        NanoStats:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS", "ckknight") -- HoTs on party members
    end
end


--[[
		Damage/Healing data calculations and management
--]]

-- If values exist and are positive, then go ahead. IMO, no need to count negative numbers.

function NanoStats:UpdateDamageTotals(damage)
    if ( damage and damage >= 0 ) then
		if ( NanoStatsConfig.Damage == TRUE ) then NanoStats.TotalDamageThisBattle = NanoStats.TotalDamageThisBattle + damage end
		if ( NanoStatsConfig.SessionDamage == TRUE ) then NanoStats.TotalDamageThisSession = NanoStats.TotalDamageThisSession + damage end
    end
end

function NanoStats:UpdateHealingTotals(healing)
    if ( healing and healing >= 0 ) then
        if ( NanoStatsConfig.Healing == TRUE ) then NanoStats.TotalHealingThisBattle = NanoStats.TotalHealingThisBattle + healing end
		if ( NanoStatsConfig.SessionHealing == TRUE ) then NanoStats.TotalHealingThisSession = NanoStats.TotalHealingThisSession + healing end
    end
end


--[[
		Display Management.
		These will create strings that are either output to the tablet or the tooltip,
		depending on whether we're in non-Fu or Fu mode respectively
		
		Session quantities and duration are handled in the updater
--]]


function NanoStats:SetTabletDamageDisplay()

    -- Calculating DPS, rounded to 1dp
    NanoStats.CurrentDPS = string.format("%4.1f", NanoStats.TotalDamageThisBattle / NanoStats.DurationOfThisBattle)

    -- "123.4 DPS - 12340 Damage"
    NanoStats.DamageDisplay =  NanoStats.CurrentDPS.." DPS - "..NanoStats.TotalDamageThisBattle.." "..NanoStatsLocals.WORD_DAMAGE
end

function NanoStats:SetTabletHealingDisplay()

    -- Calculating HPS, rounded to 1dp
    NanoStats.CurrentHPS = string.format("%4.1f", NanoStats.TotalHealingThisBattle / NanoStats.DurationOfThisBattle)

    -- "123.4 HPS - 12340 Healing"
    NanoStats.HealingDisplay =  NanoStats.CurrentHPS.." HPS - "..NanoStats.TotalHealingThisBattle.." "..NanoStatsLocals.WORD_HEALING
end


--[[
		Non-parser event handlers
--]]

function NanoStats:BeginCombat()
    metrognome:Start("NSUpdate")
    NanoStats.InCombat = TRUE
end

function NanoStats:EndCombat()

    metrognome:Stop("NSUpdate")
    NanoStats:Update()
    NanoStats.InCombat = FALSE

    -- Reset these in preparation for next battle
    NanoStats.TotalDamageThisBattle = 0
    NanoStats.TotalHealingThisBattle = 0
    NanoStats.DurationOfThisBattle = 0
    -- DPS/HPS vars don't need zeroed because they're automatically overwritten
end


--[[
======================================

		PARSER EVENT HANDLERS

======================================
--]]


function NanoStats:CHAT_MSG_COMBAT_SELF_HITS() -- Player melee hits

    -- If it's not a damage message, why go further?
    if ( string.find(arg1, "%d" ) ) then

        -- Initialise here or we get wtfpwnt by scoping
        local damage, _

        -- Normal hits
        -- You hit It for 333
        _, damage = babble:Deformat(arg1, COMBATHITSELFOTHER)
        -- You hit It for 300. (33 blocked)
        if ( not damage ) then _, damage, _ = babble:Deformat(arg1, COMBATHITSELFOTHER, BLOCKED_TRAILER) end
		-- You hit It for 200. (glancing)
		if ( not damage ) then _, damage, _ = babble:Deformat(arg1, COMBATHITSELFOTHER, GLANCING_TRAILER) end


        -- Melee skill hits
        -- Your Sharp Logic hits Dumbass for 500
        if ( not damage) then _, _, damage = babble:Deformat(arg1, SPELLLOGSELFOTHER) end
        -- Your Sharp Logic hits Dumbass for 475. (25 blocked) 
        if ( not damage) then _, _, damage, _ = babble:Deformat(arg1, SPELLLOGSELFOTHER, BLOCKED_TRAILER) end

        -- Melee skill crits
        -- Your Sharp Logic crits Dumbass for 800
        if ( not damage) then _, _, damage = babble:Deformat(arg1, SPELLLOGCRITSELFOTHER) end
		
		--[[ I'm not 100% sure about whether any melee skills come under this event. Tests on my lv10 warrior alt say that
        they all go under CHAT_MSG_SPELL_SELF_DAMAGE, but a gut feeling's telling me there's one or 2 that go under here.
        Confirmation will be VERY welcome --]]

        -- Normal crits
        -- You crit It for 444
        if ( not damage) then _, damage = babble:Deformat(arg1, COMBATHITCRITSELFOTHER) end

        NanoStats:UpdateDamageTotals(damage)
    end
end

function NanoStats:CHAT_MSG_COMBAT_PET_HITS() -- Pet melee hits

    -- If the message doesn't involve the player's pet, then don't bother dealing with it.
    -- We firstly check whether the player even has a pet because this event fires for shaman totems. Logical short-circuiting FTW
    
    local playerpet = UnitName("pet") -- Saves us from having to call it twice
    if ( playerpet ) and ( string.find(arg1, playerpet) ) and ( string.find(arg1, "%d") ) then

        -- Initialise here or we get wtfpwnt by scoping
        local damage, _

        -- Normal hits
        -- SameSizeAsMe hits Number3 for 80.
        _, _, damage = babble:Deformat(arg1, COMBATHITOTHEROTHER)
        -- SameSizeAsMe hits Number3 for 70. (10 blocked)
        if ( not damage ) then _, _, _, damage, _ = babble:Deformat(arg1, COMBATHITOTHEROTHER, BLOCKED_TRAILER) end
		-- SameSizeAsMe hits Number3 for 55. (glancing)
		if ( not damage ) then _, _, _, damage, _ = babble:Deformat(arg1, COMBATHITOTHEROTHER, GLANCING_TRAILER) end

        -- Melee skill hits
        -- SameSizeAsMe's Pointy Thing hits Number3 for 100.
        if ( not damage ) then _, _, _, damage = babble:Deformat(arg1, SPELLLOGOTHEROTHER) end
        -- SameSizeAsMe's Pointy Thing hits Number3 for 85. (15 blocked)
        if ( not damage ) then _, _, _, damage, _ = babble:Deformat(arg1, SPELLLOGOTHEROTHER, BLOCKED_TRAILER) end

        -- Melee skill crits
        -- SameSizeAsMe's Pointy Thing crits Number3 for 170.
        if ( not damage ) then _, _, _, damage = babble:Deformat(arg1, SPELLLOGCRITOTHEROTHER) end

        -- Normal crits
        -- SameSizeAsMe crits Number3 for 150.
        if ( not damage ) then _, _, damage = babble:Deformat(arg1, COMBATHITCRITOTHEROTHER) end

        -- IIRC, melee crits can't be blocked. Please correct me if I'm wrong.

        NanoStats:UpdateDamageTotals(damage)
    end
end

function NanoStats:CHAT_MSG_SPELL_SELF_DAMAGE() -- Player spell hits, also melee skills

    -- If it's not a damage message, why go further?
    -- Especially true for this event because some other messages use it often (e.g immunity and "Dude-X is afflicted by debuff-Y")
    if ( string.find(arg1, "%d") ) then
    
        -- Initialise here or we get wtfpwnt by scoping
        local damage, _

        -- Spell hits
        -- Your Rather Imba Fiery Thing hits A Cosmos Dev for 1337 fire damage.
        _, _, damage, _ = babble:Deformat(arg1, SPELLLOGSCHOOLSELFOTHER)
        -- Your Rather Imba Fiery Thing hits A Cosmos Dev for 1300 fire damage. (37 resisted)
        if ( not damage ) then _, _, damage, _, _ = babble:Deformat(arg1, SPELLLOGSCHOOLSELFOTHER, RESIST_TRAILER) end
        
        -- Melee skill hits (Yes, they apparently come under here for some odd reason)
        -- Your Sharp Logic hits Dumbass for 500
        if ( not damage ) then _, _, damage = babble:Deformat(arg1, SPELLLOGSELFOTHER) end
        -- Your Sharp Logic hits Dumbass for 475. (25 blocked)
        if ( not damage ) then _, _, damage, _ = babble:Deformat(arg1, SPELLLOGSELFOTHER, BLOCKED_TRAILER) end
        
        -- Spell crits
        -- Your Rather Imba Fiery Thing crits A Cosmos Dev for 2448 fire damage
        if ( not damage ) then _, _, damage, _  = babble:Deformat(arg1, SPELLLOGCRITSCHOOLSELFOTHER) end
        -- Your Rather Imba Fiery Thing hits A Cosmos Dev for 2350 fire damage. (98 resisted)
        if ( not damage ) then _, _, damage, _, _ = babble:Deformat(arg1, SPELLLOGCRITSCHOOLSELFOTHER, RESIST_TRAILER) end
        --[[ Not 100% sure about whether spell crits can be resisted. If they can't, please tell me so I can remove the previous line --]]
        
        -- Melee skill crits
        -- Your Sharp Logic crits Dumbass for 800
        if ( not damage ) then _, _, damage = babble:Deformat(arg1, SPELLLOGCRITSELFOTHER) end
        --[[ Melee crits can't be blocked, iirc. Please prove me wrong if I am :P ]]--
        
        NanoStats:UpdateDamageTotals(damage)
    end
end

function NanoStats:CHAT_MSG_SPELL_PET_DAMAGE() -- Pet spell hits
    
    -- If the message doesn't involve the player's pet, then don't bother dealing with it.
    -- We firstly check whether the player even has a pet because this event fires for shaman totems. Logical short-circuiting FTW
	-- Also, if there's no number to mercilessly rip out, why bother going further?

    local playerpet = UnitName("pet") -- Saves us from having to call it twice
    if ( playerpet ) and ( string.find(arg1, playerpet) ) and ( string.find(arg1, "%d") ) then -- I'd love to get rid of the ( playerpet ) part, but string.find doesn't love nil patterns :P

        -- Initialise here or we get wtfpwnt by scoping
        local damage, _

        -- Spell hits
        -- MaxiMe's Arcane Pie hits Dr Weavil for 276 arcane damage.
        _, _, _, damage, _ = babble:Deformat(arg1, SPELLLOGSCHOOLOTHEROTHER)
        -- MaxiMe's Arcane Pie hits Dr Weavil for 240 arcane damage. (36 resisted)
        if ( not damage ) then _, _, _, damage, _, _ = babble:Deformat(arg1, SPELLLOGSCHOOLOTHEROTHER, RESIST_TRAILER) end

        -- Spell crits
        -- MaxiMe's Arcane Pie crits Dr Weavil for 444 arcane damage.
        if ( not damage ) then _, _, _, damage, _ = babble:Deformat(arg1, SPELLLOGCRITSCHOOLOTHEROTHER) end
        -- MaxiMe's Arcane Pie crits Dr Weavil for 400 arcane damage. (44 resisted)
        if ( not damage ) then _, _, _, damage, _, _ = babble:Deformat(arg1, SPELLLOGCRITSCHOOLOTHEROTHER, RESIST_TRAILER) end
        
        NanoStats:UpdateDamageTotals(damage)
    end
end

function NanoStats:CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE() -- Player DoT ticks on mobs/NPCs

    -- If it's not a damage message, then why go further?
    if ( string.find(arg1, "%d") ) then

        -- Ignition Joe suffers 64 fire damage from your Set This Annoying Dude Alight
        local _, damage, _, _ = babble:Deformat(arg1, PERIODICAURADAMAGESELFOTHER)

        NanoStats:UpdateDamageTotals(damage)
    end
end

function NanoStats:CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE() -- PvP DoTs (They use this event, which also spits messages about other friendly players' PvP DoTs)

        -- Dr Why suffers 88 Physical damage from your Yalek Poison Thing
        local _, damage, _, _ = babble:Deformat(arg1, PERIODICAURADAMAGESELFOTHER)

        NanoStats:UpdateDamageTotals(damage)
end

function NanoStats:CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF() -- Lightning Shield, Thorns, Fire Shield, etc.
    
    -- If it's not a damage message, then why go further?
    if ( string.find(arg1, "%d") ) then

        -- You reflect 16 holy damage to Some Guy Who Can't Handle Holy Damage
        local damage, _, _ = babble:Deformat(arg1, DAMAGESHIELDSELFOTHER)

        NanoStats:UpdateDamageTotals(damage)
    end
end

function NanoStats:Event_DirectHeals()

    -- You can heal while out of combat, which would pollute the next battle's data if we didn't have this check
	-- Also, if there's no number to mercilessly rip out, why bother going further?
    if ( NanoStats.InCombat ) and ( string.find(arg1, "%d") )then

        -- Initialise here or we get wtfpwnt by scoping
        local healing, _

        -- Your Ass-Saver heals TheOneEatingBroodlord'sMortalStrikes for 1000
        _, _, healing = babble:Deformat(arg1, HEALEDSELFOTHER)
        -- Your Ass-Saver heals you for 1000
        if ( not healing ) then _, healing = babble:Deformat(arg1, HEALEDSELFSELF) end
        -- Your Ass-Saver critically heals TheOneEatingBroodlord'sMortalStrikes for 1700
        if ( not healing ) then _, _, healing = babble:Deformat(arg1, HEALEDCRITSELFOTHER) end
        -- Your Ass-Saver critically heals you for 1700
        if ( not healing ) then _, healing = babble:Deformat(arg1, HEALEDCRITSELFSELF) end
        
        NanoStats:UpdateHealingTotals(healing)
    end
end

function NanoStats:ckknight() -- HoTs. Method named in honour of ckknight, who helped out a lot

    -- You can heal while out of combat, which would pollute the next battle's data if we didn't have this check
	-- Also, if there's no number to mercilessly rip out, why bother going further?
    if ( NanoStats.InCombat ) and ( string.find(arg1, "%d") ) then

        -- Initialise here or we get wtfpwnt by scoping
        local healing, _

        -- GenericMT gains 100 health from your Generic HoT
        _, healing, _ = babble:Deformat(arg1, PERIODICAURAHEALSELFOTHER)
        -- You gain 100 health from Generic HoT
        if ( not healing ) then healing, _ = babble:Deformat(arg1, PERIODICAURAHEALSELFSELF) end

        NanoStats:UpdateHealingTotals(healing)
    end
end


--[[
"I have the results!"
"What is it Doctor!?"
"I'm sorry ma'am, but your son is DUMB!"
"NOOOOOOOOOOOOOOOOOOOOOO!!"
"... And you're BALD!"
--]]
NanoStats:RegisterForLoad()