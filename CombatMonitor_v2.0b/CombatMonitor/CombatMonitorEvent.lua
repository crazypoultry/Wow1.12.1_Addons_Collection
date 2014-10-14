--
-- CombatMonitor
-- World of Warcraft UI AddOn to track defensive combat statistics
-- 2005 Satrina@Stormrage
--

COMBATMONITOR_UPDATE_TIME = 1.0;
local CMON_elapsed = 0;

TYPE_PHYSICAL = 1;
TYPE_ARCANE = 2;
TYPE_FIRE = 3;
TYPE_FROST = 4;
TYPE_HOLY = 5;
TYPE_NATURE = 6;
TYPE_SHADOW = 7;

TYPE_DODGE = 10;
TYPE_FULL_BLOCK = 11;
TYPE_PARRY = 12;
TYPE_MISS = 13;
TYPE_RESIST = 14;
TYPE_ENVIRONMENTAL = 15;

TYPE_CRITICAL = 1;
TYPE_CRUSHING = 2;
TYPE_GLANCING = 3;

CLASS_MELEE = 1;
CLASS_SPELL = 2;
CLASS_DOTPULSE = 3;

----------------------------
-- Debugging
----------------------------
function CombatMonitor_DebugLog(str)
	if CMON_debug then
		CMON_debugDestination:AddMessage(str);
	end
end

--function CombatMonitor_DamageStr(damageType)
--	if (damageType == TYPE_PHYSICAL) then
--		return "Physical"
--	end
--	if (damageType == TYPE_ARCANE) then
--		return "Arcane"
--	end
--	if (damageType == TYPE_FIRE) then
--		return "Fire"
--	end
--	if (damageType == TYPE_FROST) then
--		return "Frost"
--	end
--	if (damageType == TYPE_HOLY) then
--		return "Holy"
--	end
--	if (damageType == TYPE_NATURE) then
--		return "Nature"
--	end
--	if (damageType == TYPE_SHADOW) then
--		return "Shadow"
--	end
--	if (damageType == TYPE_DODGE) then
--		return "Dodge"
--	end
--	if (damageType == TYPE_FULL_BLOCK) then
--		return "Block"
--	end
--	if (damageType == TYPE_PARRY) then
--		return "Parry"
--	end
--	if (damageType == TYPE_MISS) then
--		return "Miss"
--	end
--	if (damageType == TYPE_RESIST) then
--		return "Resist"
--	end
--	return "Unknown"
--end
--
--function CombatMonitor_DumpEvent(event)
--	if CMON_debug then
--		str = CMON_DEBUG_EVENT;
--		if(event.source) then
--			str = str..event.source;
--		else
--			str = str.."nil";
--		end
--		str = str.." type = "		
--		if(event.damageType) then
--			str = str..event.damageType;
--		else
--			str = str.."nil";
--		end
--		str = str.." damage = "
--		if(event.damage) then
--			str = str..event.damage;
--		else
--			str = str.."nil";
--		end
--		if(event.spell) then
--			str = str.." spell = "..event.spell;
--		end
--		if(event.absorbed) then
--			str = str.." absorbed = "..event.absorbed;
--		end
--		if(event.blocked) then
--			str = str.." blocked = "..event.blocked;
--		end
--		CombatMonitor_DebugLog(str);
--	end
--end
--
----------------------------
-- Combat Event
----------------------------
-- Called from events other than UNIT_COMBAT
--function CombatMonitor_NewEvent(chatLine, source, spell, damage, type, class)
--	CMON_event =
--	{
--		ttl = 0;
--		source = source;
--		spell = spell;
--		crit = nil;
--		damage = damage;
--		absorbed = 0;
--		blocked = 0;
--		resisted = 0;
--		damageType = type;
--		class = class;
--	};
--
--	CombatMonitor_FindAbsorb(chatLine, CMON_event);
--	CombatMonitor_FindBlock(chatLine, CMON_event);
--	CombatMonitor_FindResisted(chatLine, CMON_event);
--	CombatMonitor_FindCrit(chatLine, CMON_event);
--	if CMON_debug then
--		CombatMonitor_DumpEvent(CMON_event)
--	end
--	CombatMonitor_HandleEvent(CMON_event);
--end
--
------------------------------
---- Functions to find data in event log trailers
------------------------------
--function CombatMonitor_FindAbsorb(arg1, event)
--	for absorbed, amount in string.gfind(arg1, SEARCH_ABSORB) do
--		event.absorbed = tonumber(amount);
--	end
--end
--
--function CombatMonitor_FindBlock(arg1, event)
--	for blocked, amount in string.gfind(arg1, SEARCH_BLOCK) do
--		event.blocked = tonumber(amount);
--	end
--end
--
--function CombatMonitor_FindResisted(arg1, event)
--	for resisted, amount in string.gfind(arg1, SEARCH_RESISTED) do
--		event.resisted = tonumber(amount);
--	end
--end
--
--function CombatMonitor_FindCrit(arg1, event)
--	for crushing in string.gfind(arg1, SEARCH_CRUSHING) do
--		event.crit = TYPE_CRUSHING;
--		return;
--	end
--	for glancing in string.gfind(arg1, SEARCH_CRITICAL) do
--		event.crit = TYPE_CRITICAL;
--		return;
--	end
--end
--
--function CombatMonitor_DamageType(arg1)
--	if string.find(arg1, SEARCH_TYPE_ARCANE) then
--		return TYPE_ARCANE;
--	elseif string.find(arg1, SEARCH_TYPE_FIRE) then
--		return TYPE_FIRE;
--	elseif string.find(arg1, SEARCH_TYPE_FROST) then
--		return TYPE_FROST;
--	elseif string.find(arg1, SEARCH_TYPE_HOLY) then
--		return TYPE_HOLY;
--	elseif string.find(arg1, SEARCH_TYPE_NATURE) then
--		return TYPE_NATURE;
--	elseif string.find(arg1, SEARCH_TYPE_SHADOW) then
--		return TYPE_SHADOW;
--	else
--		return TYPE_PHYSICAL;
--	end
--end
--
function CombatMonitor_OnUpdate(elapsed)
	if (CMON_elapsed < COMBATMONITOR_UPDATE_TIME) then
		CMON_elapsed = CMON_elapsed + elapsed;	
	else
		CMON_elapsed = 0;
		if CMON_trackingDPS then
			CombatMonitor_TimerIncrement();
		end
	end
end

-- ----------------------------------------------------------------------------
-- Events
-- ----------------------------------------------------------------------------
function CM_Combat_OnEvent(event,info)

	CMON_event =
	{
		ttl = 0;
		source = nil;
		spell = nil;
		crit = nil;
		damage = 0;
		absorbed = 0;
		blocked = 0;
		resisted = 0;
		damageType = nil;
		class = nil;
	};

	local playerUnitName = UnitName("Player");

	-- ----------------------------------------
	-- Notifiy if impossible things occur.
	-- ----------------------------------------
        if ((info.type           == "hit" )  and
	    (info.isCrit         == true  )  and (info.amountBlocked  ~= nil   )) then
		PlaySound("AuctionWindowOpen");
		UIErrorsFrame:AddMessage(arg1, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);	
	end

        if ((info.type           == "hit" )  and
	    (info.isCrushing     == true  )  and (info.amountBlocked  ~= nil   )) then
		PlaySound("AuctionWindowOpen");
		UIErrorsFrame:AddMessage(arg1, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);	
	end

	-- ----------------------------------------
	-- Track the player tossing up shield block
	-- ----------------------------------------
        if ((info.type           == "buff")  and
	    (info.victim         == ParserLib_SELF ) and
	    (info.skill          == "Shield Block"  )) then
		CMON_shieldBlock = 1;
		return
	end

        if ((info.type           == "fade")  and
	    (info.victim         == ParserLib_SELF ) and
	    (info.skill          == "Shield Block"  )) then
		CMON_shieldBlock = nil;
		return
	end
	-- ----------------------------------------
	-- Process Enviromental damage.
	-- ----------------------------------------
        if ((info.type           == "environment"  )  and
	    (info.victim         == ParserLib_SELF )  and
	    (CMVar[CMON_player].trackEnvironmental )) then
		-- CombatMonitor_NewEvent(arg1, CMON_ENVIRONMENTAL, nil, info.amount, TYPE_ENVIRONMENTAL);
		CMON_event.ttl        = 0;
		CMON_event.source     = CMON_ENVIRONMENTAL;
		CMON_event.spell      = nil;
		CMON_event.crit       = nil;
		CMON_event.damage     = info.amount;
		CMON_event.absorbed   = info.amountAbsorb;
		CMON_event.blocked    = info.amountBlock;
		CMON_event.resisted   = info.amountResist;
		CMON_event.damageType = TYPE_ENVIRONMENTAL;
		CMON_event.class      = nill;
		CombatMonitor_HandleEvent(CMON_event);
		return;
	end

	-- ----------------------------------------
	-- Process CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES
	-- ----------------------------------------
        if ((info.type           == "miss"         )  and
	    (info.victim         == ParserLib_SELF )) then

		if ((info.missType == "deflect" ) or 
		    (info.missType == "immune"  ) or
		    (info.missType == "evade"   ) or
		    (info.missType == "resist"  ) or
		    (info.missType == "reflect" ) ) then
			return;
		end

		CMON_event.ttl        = 0;
		CMON_event.source     = info.source;
		CMON_event.spell      = nil;
		CMON_event.crit       = nil;
		CMON_event.damage     = 0;
		CMON_event.absorbed   = 0;
		CMON_event.blocked    = 0;
		CMON_event.resisted   = 0;
		CMON_event.damageType = TYPE_PHYSICAL;
		CMON_event.class      = CLASS_MELEE;

		if (info.source     == ParserLib_Self) then
			CMON_event.source = playerUnitName;
		end;

		if(info.missType == "miss"     ) then CMON_event.damageType = TYPE_MISS;
		elseif(info.missType == "dodge"    ) then CMON_event.damageType = TYPE_DODGE;
		elseif(info.missType == "block"    ) then CMON_event.damageType = TYPE_FULL_BLOCK;
		elseif(info.missType == "parry"    ) then CMON_event.damageType = TYPE_PARRY;
		elseif(info.missType == "resist"   ) then CMON_event.damageType = TYPE_RESIST;
		end;

		if (info.skill == ParserLib_MELEE) then
			CMON_event.class      = CLASS_MELEE;
		else
			CMON_event.class      = CLASS_SPELL;
		end

		CombatMonitor_HandleEvent(CMON_event);
		return;
	end

	-- ----------------------------------------
	-- Process CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS
	-- ----------------------------------------
        if ((info.type           == "hit"          )  and
	    (info.victim         == ParserLib_SELF )) then

		CMON_event.ttl        = 0;
		CMON_event.source     = info.source;
		CMON_event.spell      = nil;
		CMON_event.crit       = nil;
		CMON_event.damage     = info.amount;
		CMON_event.absorbed   = info.amountAbsorb;
		CMON_event.blocked    = info.amountBlock;
		CMON_event.resisted   = info.amountResist;
		CMON_event.damageType = TYPE_PHYSICAL;
		CMON_event.class      = CLASS_MELEE;

		if (info.source     == ParserLib_Self) then
			CMON_event.source = playerUnitName;
		end;

		if (info.isDot      == true) then 
			CMON_event.class = CLASS_DOTPULSE; 
		end;

		if (info.isCrit     == true) then CMON_event.crit = TYPE_CRITICAL;
		elseif (info.isCrushing == true) then CMON_event.crit = TYPE_CRUSHING;
		elseif (info.isGlancing == true) then CMON_event.crit = TYPE_GLANCING;
		end;

		if (info.skill == ParserLib_MELEE) then
			CMON_event.class      = CLASS_MELEE;
			CMON_event.damageType = TYPE_PHYSICAL;
		else
			CMON_event.class      = CLASS_SPELL;
			-- CMON_debugDestination:AddMessage(info.element);
			if (info.element == "Arcane")   then CMON_event.damageType = TYPE_ARCANE;
			elseif (info.element == "Fire"  )   then CMON_event.damageType = TYPE_FIRE;
			elseif (info.element == "Frost" )   then CMON_event.damageType = TYPE_FROST;
			elseif (info.element == "Holy"  )   then CMON_event.damageType = TYPE_HOLY;
			elseif (info.element == "Nature")   then CMON_event.damageType = TYPE_NATURE;
			elseif (info.element == "Shadow")   then CMON_event.damageType = TYPE_SHADOW;
			end
		end;

		CombatMonitor_HandleEvent(CMON_event);
		return;
	end

	-- ----------------------------------------
	-- Process CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE
	-- ----------------------------------------
	-- I rolled this into the code above.

	-- -------------------------------------------------------
	-- CHAT_MSG_SPELL_SELF_DAMAGE
	-- -------------------------------------------------------

	-- Ignored

	-- -------------------------------------------------------
	--		CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE
	-- -------------------------------------------------------

	-- Ignored

	-- -------------------------------------------------------
	-- CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE
	-- -------------------------------------------------------

	-- This was merged into the meelee section
end




function CombatMonitor_OnEvent(event)
	local spell, source, damage, damageType

--	if arg1 and string.find(arg1, "crit") and string.find(arg1, "blocked") then
--		PlaySound("AuctionWindowOpen");
--		UIErrorsFrame:AddMessage(arg1, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);	
--	end
--
--	if arg1 and string.find(arg1, "crushing") and string.find(arg1, "blocked") then
--		PlaySound("AuctionWindowOpen");
--		UIErrorsFrame:AddMessage(arg1, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);	
--	end
--	
--	if (event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS") then
--		if string.find(arg1, "You gain Shield Block") then
--			CMON_shieldBlock = 1;
--		end			
--		return
--	end
--	
--	if (event == "CHAT_MSG_SPELL_AURA_GONE_SELF") then
--		if string.find(arg1, "Shield Block fades from you") then
--			CMON_shieldBlock = nil;
--		end			
--		return
--	end


	if (event == "PLAYER_TARGET_CHANGED") then
		id = CombatMonitor_IDFromName(UnitName("target")) or 1
		CMVar[CMON_player].currentIndex = id;
		CombatMonitor_UpdateSummary()
		CombatMonitor_UpdateDetails();
	end


	if (event == "PLAYER_TARGET_CHANGED") then
		id = CombatMonitor_IDFromName(UnitName("target")) or 1
		CMVar[CMON_player].currentIndex = id;
		CombatMonitor_UpdateSummary()
		CombatMonitor_UpdateDetails();
	end

---------------------------------------------------------
-- CHAT_MSG_COMBAT_SELF_HITS
---------------------------------------------------------
--	if (event == "CHAT_MSG_COMBAT_SELF_HITS" and not string.find(arg1, "You hit") and CMVar[CMON_player].trackEnvironmental) then
--		for damage in string.gfind(arg1, ENVIRONMENTAL_FALLING) do
--			CombatMonitor_NewEvent(arg1, CMON_ENVIRONMENTAL, nil, damage, TYPE_ENVIRONMENTAL)
--			return;
--		end
--		for damage in string.gfind(arg1, ENVIRONMENTAL_FIRE) do
--			CombatMonitor_NewEvent(arg1, CMON_ENVIRONMENTAL, nil, damage, TYPE_ENVIRONMENTAL)
--			return;
--		end
--		for damage in string.gfind(arg1, ENVIRONMENTAL_LAVA) do
--			CombatMonitor_NewEvent(arg1, CMON_ENVIRONMENTAL, nil, damage, TYPE_ENVIRONMENTAL)
--			return;
--		end
--		for damage in string.gfind(arg1, ENVIRONMENTAL_DROWNING) do
--			CombatMonitor_NewEvent(arg1, CMON_ENVIRONMENTAL, nil, damage, TYPE_ENVIRONMENTAL)
--			return;
--		end
--		for damage in string.gfind(arg1, ENVIRONMENTAL_FATIGUE) do
--			CombatMonitor_NewEvent(arg1, CMON_ENVIRONMENTAL, nil, damage, TYPE_ENVIRONMENTAL)
--			return;
--		end
--		for damage in string.gfind(arg1, ENVIRONMENTAL_SLIME) do
--			CombatMonitor_NewEvent(arg1, CMON_ENVIRONMENTAL, nil, damage, TYPE_ENVIRONMENTAL)
--			return;
--		end
--	end
--
---------------------------------------------------------
-- CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES
---------------------------------------------------------
--	if (event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES" or event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES") then
--		for source, damage, absorbed in string.gfind(arg1, SEARCH_FULL_ABSORB) do
--			return;
--		end
--		for source in string.gfind(arg1, SEARCH_MISS) do
--			CombatMonitor_NewEvent(arg1, source, nil, 0, TYPE_MISS, CLASS_MELEE)
--			return;
--		end
--		for source in string.gfind(arg1, SEARCH_FULL_BLOCK) do
--			CombatMonitor_NewEvent(arg1, source, nil, 0, TYPE_FULL_BLOCK, CLASS_MELEE)
--			return;
--		end
--		for source in string.gfind(arg1, SEARCH_DODGE) do
--			CombatMonitor_NewEvent(arg1, source, nil, 0, TYPE_DODGE, CLASS_MELEE)
--			return;
--		end
--		for source in string.gfind(arg1, SEARCH_PARRY) do
--			CombatMonitor_NewEvent(arg1, source, nil, 0, TYPE_PARRY, CLASS_MELEE)
--			return;
--		end
--		CombatMonitor_DebugLog("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES "..arg1);
--	end
--
---------------------------------------------------------
-- CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS
--------------------------------------------------------
--	if (event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS" or event == "CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS") then
--		
--		-- Yeah, you could do something clever here, like:
--		-- source, crit, damage = string.gfind(arg1, "(.+) (.+)its you for (%d+).")
--		-- instead of separate checks for hit, and determine hit or crit based on (crit == "h") or (crit == "cr")
--		-- It's like this for localisation, so that it doesn't have to be torn apart and redone just because 
--		-- some other language doesn't happen to have the hit/crit coincidence of words.
--		
--		for source, damage in string.gfind(arg1, SEARCH_CRIT) do
--			CombatMonitor_NewEvent(arg1, source, nil, tonumber(damage), CombatMonitor_DamageType(arg1), CLASS_MELEE);
--			return;
--		end
--		-- Voir documentation pour le francais deux chaines possibles
--		-- See documentation in French, two possible strings
--		if (GetLocale() == "frFR") then
--	    for source, damage in string.gfind(arg1, SEARCH_HIT1) do
--				CombatMonitor_NewEvent(arg1, source, nil, tonumber(damage), CombatMonitor_DamageType(arg1), CLASS_MELEE);
--				return;
--	    end
--      for source, damage in string.gfind(arg1, SEARCH_HIT) do
--		    CombatMonitor_NewEvent(arg1, source, nil, tonumber(damage), CombatMonitor_DamageType(arg1), CLASS_MELEE);
--		    return;
--	    end
--   	else 
--	   	-- Initial English code
--			for source, damage in string.gfind(arg1, SEARCH_HIT) do
--	      CombatMonitor_NewEvent(arg1, source, nil, tonumber(damage), CombatMonitor_DamageType(arg1), CLASS_MELEE);
--  	    return;
--			end
--		end
--		CombatMonitor_DebugLog("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS "..arg1);
--	end
--
---------------------------------------------------------
-- CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE
---------------------------------------------------------
--	if (event == "CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE") then
--		if (GetLocale() == "frFR") then
--			-- Call CombatMonitor_ParseString to filter through a list of regular expressions to correctly extract the data
--			spell, source, damage, damageType = CombatMonitor_ParseString(arg1, SEARCH_PERIODIC)
--			if spell and source and damage then
--				CombatMonitor_NewEvent(arg1, source, nil, damage, CombatMonitor_DamageTypeFromString(damageType), CLASS_DOTPULSE);
--				return;
--			end
--			-- Call CombatMonitor_ParseString to filter through a list of regular expressions to correctly extract the data
--			spell, source, damage = CombatMonitor_ParseString(arg1, SEARCH_TYPE_DAMAGE)
--			if spell and source and damage then
--				CombatMonitor_NewEvent(arg1, source, nil, damage, TYPE_PHYSICAL, CLASS_DOTPULSE);
--				return;
--			end
--		else
--			for damage, damageType, source, spell in string.gfind(arg1, SEARCH_PERIODIC) do
--				CombatMonitor_NewEvent(arg1, source, nil, damage, CombatMonitor_DamageTypeFromString(damageType), CLASS_DOTPULSE);
--				return;
--			end
--			for source, damage in string.gfind(arg1, SEARCH_TYPE_DAMAGE) do
--				CombatMonitor_NewEvent(arg1, source, nil, damage, TYPE_PHYSICAL, CLASS_DOTPULSE);
--				return;
--			end
--		end
--		--
--		-- Someday we might be able to do something useful with these
--		--
--		for damage, damageType, source, spell in string.gfind(arg1, SEARCH_SPELL_AFFLICTED) do
--			return;
--		end
--		for damage, damageType, source, spell in string.gfind(arg1, SEARCH_SPELL_PERFORM) do
--			return;
--		end
--		CombatMonitor_DebugLog("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE "..arg1);
--	end
--
---------------------------------------------------------
-- CHAT_MSG_SPELL_SELF_DAMAGE
---------------------------------------------------------
	if (event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
		-- This seems to never fire.  If debug is on and it does, we'll say something.
		CombatMonitor_DebugLog("CHAT_MSG_SPELL_SELF_DAMAGE "..arg1);
	end

---------------------------------------------------------
--		CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE
---------------------------------------------------------
	if (event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE") then
		-- This seems to never fire.  If debug is on and it does, we'll say something.
		CombatMonitor_DebugLog("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE "..arg1);
	end

---------------------------------------------------------
-- CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE
---------------------------------------------------------
--	if (event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or event == "CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE") then
--
--		for source in string.gfind(arg1, SEARCH_SPELL_FULL_BLOCK) do
--			CombatMonitor_NewEvent(arg1, source, nil, 0, TYPE_FULL_BLOCK, CLASS_SPELL);
--			return;
--		end
--		for source, spell in string.gfind(arg1, SEARCH_SPELL_RESIST) do
--			CombatMonitor_NewEvent(arg1, source, nil, 0, TYPE_RESIST, CLASS_SPELL);
--			return;
--		end
--		for source, spell in string.gfind(arg1, SEARCH_SPELL_DODGE) do
--			CombatMonitor_NewEvent(arg1, source, nil, 0, TYPE_DODGE, CLASS_SPELL)
--			return;
--		end
--		
--		if (GetLocale() == "frFR") then
--			-- Call CombatMonitor_ParseString to filter through a list of regular expressions to correctly extract the data
--			spell, source = CombatMonitor_ParseString(arg1, SEARCH_SPELL_PARRY)
--			if spell and source then
--				CombatMonitor_NewEvent(arg1, source, nil, 0, TYPE_PARRY, CLASS_SPELL)
--				return;
--			end
--			-- Call CombatMonitor_ParseString to filter through a list of regular expressions to correctly extract the data
--			spell, source = CombatMonitor_ParseString(arg1, SEARCH_SPELL_MISS)
--			if spell and source then
--				CombatMonitor_NewEvent(arg1, source, nil, 0, TYPE_PARRY, CLASS_SPELL)
--				return;
--			end
--		else   
--			-- Initial English code
--			for source, spell in string.gfind(arg1, SEARCH_SPELL_PARRY) do
--				CombatMonitor_NewEvent(arg1, source, nil, 0, TYPE_PARRY, CLASS_SPELL)
--				return;
--			end
--			for source, spell in string.gfind(arg1, SEARCH_SPELL_MISS) do
--				CombatMonitor_NewEvent(arg1, source, nil, 0, TYPE_MISS, CLASS_SPELL)
--				return;
--			end
--		end
--				
--		
--		-- Everything below here will cause a UNIT_COMBAT to appear after the CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE
--		-- event.  Queue it up and when the UNIT_COMBAT event that matches fires, we'll complete the event
--		-- and add it to the stats.
--
--		-- This is where the issue with determining "melee spells" is.  There is nothing in arg1 to say
--		-- that we have a melee attack spell, or a fireball.
--		-- So, we will take the simple road and look for "strike" (as in mortal strike, crusader strike) and
--		-- "cleave" (as in cleave), and just assign them as melee attacks if we find it.  We may end up with more
--		-- cases later, but this is a reasonable compromise between getting numbers that don't add up and trying
--		-- to keep a list of every melee spell in the game.
--				
--		if (GetLocale() == "frFR") then
--			-- Nouvelle chaine de caractère, voir doucumentation en francais
--			-- New string, see French documemtation
--			for source, spell, damage in string.gfind(arg1, SEARCH_SPELL1) do
--				CombatMonitor_NewEvent(arg1, source, spell, tonumber(damage), CombatMonitor_DamageType(arg1), CLASS_SPELL);
--				return;
--			end
--			-- Call CombatMonitor_ParseString to filter through a list of regular expressions to correctly extract the data
--			spell, source, damage = CombatMonitor_ParseString(arg1, SEARCH_SPELL)
--			if spell and source and damage then
--				CombatMonitor_NewEvent(arg1, source, spell, tonumber(damage), CombatMonitor_DamageType(arg1), CLASS_SPELL);
--				return;
--			end
--			-- Call CombatMonitor_ParseString to filter through a list of regular expressions to correctly extract the data
--			spell, source, damage = CombatMonitor_ParseString(arg1, SEARCH_CRIT_SPELL)
--			if spell and source and damage then
--				CombatMonitor_NewEvent(arg1, source, spell, tonumber(damage), CombatMonitor_DamageType(arg1), CLASS_SPELL);
--				return;
--			end
--		else
--			-- Initial English code
--			for source, spell, damage in string.gfind(arg1, SEARCH_SPELL) do
--				CombatMonitor_NewEvent(arg1, source, spell, tonumber(damage), CombatMonitor_DamageType(arg1), CLASS_SPELL);
--				return;
--			end
--			for source, spell, damage in string.gfind(arg1, SEARCH_CRIT_SPELL) do
--				CombatMonitor_NewEvent(arg1, source, spell, tonumber(damage), CombatMonitor_DamageType(arg1), CLASS_SPELL);
--				return;
--			end
--		end
--
--		--
--		-- Someday we might want/be able to do something with these
--		--
--		for spell in string.gfind(arg1, SEARCH_SPELL_FULL_ABSORB) do
--			-- Fully absorbed, so nothing to track.
--			return;
--		end
--		for spell in string.gfind(arg1, SEARCH_SPELL_AFFLICTED) do
--			-- After you are afflicted, you take "ownership" of the spell, and get
--			-- "Your XXX hits you for YYY" messages.  Can maybe correlate this event with
--			-- the SELF_DAMAGE event to attribute the damage to the right source.
--			return;
--		end
--		for source, spell in string.gfind(arg1, SEARCH_SPELL_PERFORM) do
--			-- Usually stuff like Garr's Antimagic Pulse, no damage
--			return;
--		end
--		CombatMonitor_DebugLog("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE "..arg1);
--	end
	
---------------------------------------------------------
-- ADDON_LOADED
---------------------------------------------------------
	if (event == "ADDON_LOADED" and arg1 == "CombatMonitor") then
		CMON_player = UnitName("player");
		CombatMonitor_Initialise();
		return
	end

	if (event == "PLAYER_ENTERING_WORLD") then
		CombatMonitor_RegisterEvents(CMVar[CMON_player].enabled);
		return
	end

	if (event == "PLAYER_LEAVING_WORLD") then
		CombatMonitor_RegisterEvents();
		return
	end

---------------------------------------------------------
-- PLAYER_REGEN_XXX
---------------------------------------------------------
	if (event == "PLAYER_REGEN_DISABLED") then
		CombatMonitor_ToggleDPS(1);
	end
	
	if (event == "PLAYER_REGEN_ENABLED") then
		CombatMonitor_ToggleDPS(0);
	end

end

----------------------------
-- Event Tracking
----------------------------


function CombatMonitor_HandleEvent(event)

	if(event.resisted == nil) then
		event.resisted = 0;
	end;

	if CMON_trackingDPS and event.damage then
		CMON_damage = CMON_damage + event.damage;
	end
	
	local id = CombatMonitor_IDFromName(event.source);			
	if not id then
		if CMVar[CMON_player].trackNew then
			id = CombatMonitor_AddName(event.source);
		else
			return
		end
	end
	
	if event.damage then
		CMVar[CMON_player].defenseStats[id].meleeTotalDamage = CMVar[CMON_player].defenseStats[id].meleeTotalDamage + event.damage;
		-- Keep the total correct if the user has all opponents in the summary
		CMVar[CMON_player].defenseStats[1].meleeTotalDamage = CMVar[CMON_player].defenseStats[1].meleeTotalDamage + event.damage;
	end
	
	if (event.blocked ~= nil) then
		if (event.blocked > CMVar[CMON_player].blockValue) then
			CMVar[CMON_player].blockValue = event.blocked
		end
		if (event.class == CLASS_MELEE) then
			CMVar[CMON_player].defenseStats[id].meleeBlocks = CMVar[CMON_player].defenseStats[id].meleeBlocks + 1;
			CMVar[CMON_player].defenseStats[id].meleeBlocked = CMVar[CMON_player].defenseStats[id].meleeBlocked + event.blocked;
		else
			CMVar[CMON_player].defenseStats[id].spellBlocks = CMVar[CMON_player].defenseStats[id].spellBlocks + 1;
			CMVar[CMON_player].defenseStats[id].spellBlocked = CMVar[CMON_player].defenseStats[id].spellBlocked + event.blocked;
		end
	end

	if event.crit then
		if (event.crit == TYPE_CRITICAL) then
			if (event.class == CLASS_MELEE) then
				CMVar[CMON_player].defenseStats[id].meleeCriticals = CMVar[CMON_player].defenseStats[id].meleeCriticals + 1;
			else
				CMVar[CMON_player].defenseStats[id].spellCriticals = CMVar[CMON_player].defenseStats[id].spellCriticals + 1;
			end			
			CMVar[CMON_player].defenseStats[id].critCount = CMVar[CMON_player].defenseStats[id].critCount + 1;
			if (CMVar[CMON_player].defenseStats[id].critCount == 2) then
				CMVar[CMON_player].defenseStats[id].doubleCrits = CMVar[CMON_player].defenseStats[id].doubleCrits + 1;
			elseif (CMVar[CMON_player].defenseStats[id].critCount == 3) then
				CMVar[CMON_player].defenseStats[id].tripleCrits = CMVar[CMON_player].defenseStats[id].tripleCrits + 1;
				CMVar[CMON_player].defenseStats[id].doubleCrits = CMVar[CMON_player].defenseStats[id].doubleCrits - 1;
			end
		elseif (event.crit == TYPE_CRUSHING) then
			if (event.class == CLASS_MELEE) then
				CMVar[CMON_player].defenseStats[id].meleeCrushing = CMVar[CMON_player].defenseStats[id].meleeCrushing + 1;
			else
				CMVar[CMON_player].defenseStats[id].spellCrushing = CMVar[CMON_player].defenseStats[id].spellCrushing + 1;
			end
			CMVar[CMON_player].defenseStats[id].critCount = 0;
		end
	else
		CMVar[CMON_player].defenseStats[id].critCount = 0;
	end

	if (event.damageType < TYPE_DODGE) then	
		if (event.class == CLASS_MELEE) then
			CMVar[CMON_player].defenseStats[id].meleeAttacks = CMVar[CMON_player].defenseStats[id].meleeAttacks + 1;
			CMVar[CMON_player].defenseStats[id].meleeDamage[event.damageType] = CMVar[CMON_player].defenseStats[id].meleeDamage[event.damageType] + event.damage;	
			CMVar[CMON_player].defenseStats[id].resistedMelee[event.damageType] = CMVar[CMON_player].defenseStats[id].resistedMelee[event.damageType] + event.resisted;	
			CMVar[CMON_player].defenseStats[id].meleeHits[event.damageType] = CMVar[CMON_player].defenseStats[id].meleeHits[event.damageType] + 1;	
		else
			CMVar[CMON_player].defenseStats[id].spellDamage[event.damageType] = CMVar[CMON_player].defenseStats[id].spellDamage[event.damageType] + event.damage;	
			CMVar[CMON_player].defenseStats[id].resistedSpell[event.damageType] = CMVar[CMON_player].defenseStats[id].resistedSpell[event.damageType] + event.resisted;	
			if (event.class ~= CLASS_DOTPULSE) then
				if (event.damageType == TYPE_PHYSICAL) then
					CMVar[CMON_player].defenseStats[id].spellAttacks = CMVar[CMON_player].defenseStats[id].spellAttacks + 1;
				end
				CMVar[CMON_player].defenseStats[id].spellHits[event.damageType] = CMVar[CMON_player].defenseStats[id].spellHits[event.damageType] + 1;	
			end
		end
	elseif (event.damageType == TYPE_DODGE) then
		if (event.class == CLASS_MELEE) then
			CMVar[CMON_player].defenseStats[id].meleeAttacks = CMVar[CMON_player].defenseStats[id].meleeAttacks + 1;
			CMVar[CMON_player].defenseStats[id].meleeDodges = CMVar[CMON_player].defenseStats[id].meleeDodges + 1;
		else
			CMVar[CMON_player].defenseStats[id].spellAttacks = CMVar[CMON_player].defenseStats[id].spellAttacks + 1;
			CMVar[CMON_player].defenseStats[id].spellDodges = CMVar[CMON_player].defenseStats[id].spellDodges + 1;
		end		
		CMVar[CMON_player].defenseStats[id].critCount = 0;
	elseif (event.damageType == TYPE_RESIST) then
		CMVar[CMON_player].defenseStats[id].resists = CMVar[CMON_player].defenseStats[id].resists + 1;
	elseif (event.damageType == TYPE_PARRY) then
		if (event.class == CLASS_MELEE) then
			CMVar[CMON_player].defenseStats[id].meleeAttacks = CMVar[CMON_player].defenseStats[id].meleeAttacks + 1;
			CMVar[CMON_player].defenseStats[id].meleeParries = CMVar[CMON_player].defenseStats[id].meleeParries + 1;
		else
			CMVar[CMON_player].defenseStats[id].spellAttacks = CMVar[CMON_player].defenseStats[id].spellAttacks + 1;
			CMVar[CMON_player].defenseStats[id].spellParries = CMVar[CMON_player].defenseStats[id].spellParries + 1;
		end
		CMVar[CMON_player].defenseStats[id].critCount = 0;
	elseif (event.damageType == TYPE_FULL_BLOCK) then
		if (event.class == CLASS_MELEE) then
			CMVar[CMON_player].defenseStats[id].meleeAttacks = CMVar[CMON_player].defenseStats[id].meleeAttacks + 1;
			CMVar[CMON_player].defenseStats[id].meleeFullBlocks = CMVar[CMON_player].defenseStats[id].meleeFullBlocks + 1;
		else
			CMVar[CMON_player].defenseStats[id].spellAttacks = CMVar[CMON_player].defenseStats[id].spellAttacks + 1;
			CMVar[CMON_player].defenseStats[id].spellFullBlocks = CMVar[CMON_player].defenseStats[id].spellFullBlocks + 1;
		end
		CMVar[CMON_player].defenseStats[id].critCount = 0;
	elseif (event.damageType == TYPE_MISS) then	
		if (event.class == CLASS_MELEE) then
			CMVar[CMON_player].defenseStats[id].meleeAttacks = CMVar[CMON_player].defenseStats[id].meleeAttacks + 1;
			CMVar[CMON_player].defenseStats[id].meleeMisses = CMVar[CMON_player].defenseStats[id].meleeMisses + 1;	
		else
			CMVar[CMON_player].defenseStats[id].spellAttacks = CMVar[CMON_player].defenseStats[id].spellAttacks + 1;
			CMVar[CMON_player].defenseStats[id].spellMisses = CMVar[CMON_player].defenseStats[id].spellMisses + 1;	
		end
		CMVar[CMON_player].defenseStats[id].critCount = 0;
	elseif (event.damageType == TYPE_ENVIRONMENTAL) then
		CMVar[CMON_player].defenseStats[id].meleeDamage[TYPE_PHYSICAL] = CMVar[CMON_player].defenseStats[id].meleeDamage[TYPE_PHYSICAL] + event.damage;	
		CMVar[CMON_player].defenseStats[id].meleeHits[TYPE_PHYSICAL] = CMVar[CMON_player].defenseStats[id].meleeHits[TYPE_PHYSICAL] + 1;	
	end

	CombatMonitor_UpdateSummary();
	if (CombatMonitorDetailsFrame:IsVisible()) then
		CombatMonitor_UpdateDetails();
	end	
	return 1;
end

--function CombatMonitor_ParseString(str, postfix)
--	local mob, spell, damage, damageType
--
--	for index,expstr in SPELL_PREFIXES do
--		_,_,spell,mob,damage,damageType = string.find(str, expstr..postfix)
--		if spell and mob then
--			return spell, mob, damage, damageType
--		end
--	end
--end
--
--function CombatMonitor_IsMeleeSpell(str)
--	if not str then 
--		return nil 
--	end
--	
--	for index,value in CMON_MELEE_SPELLS do
--		if string.find(str, value) then
--			return 1
--		end
--	end
--	return nil
--end