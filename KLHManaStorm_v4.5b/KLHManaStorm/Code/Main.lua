
-- module setup
local me = { name = "main"}
local mod = thismod
mod[me.name] = me

--[[
Main.lua

Here goes stuff that i don't know where else to put!

]]


me.myevents = { "SPELLCAST_START", "SPELLCAST_STOP", "SPELLCAST_FAILED", "SPELLCAST_UPDATE", "SPELLCAST_INTERRUPTED", "UI_ERROR_MESSAGE", "SPELLCAST_DELAYED"}

me.lastuierror = ""

me.onevent = function()
	
	if event == "SPELLCAST_START" then	
		
		if (me.currentspell.isactive == true) and (arg1 == mod.string.get("spellname", me.currentspell.spell.id)) then
			-- update duration
			me.currentspell.duration = arg2
			me.currentspell.isconfirmed = true
		end
		
	elseif event == "SPELLCAST_STOP" then
		
		me.currentspell.isactive = false
		mod.castbar.frame:Hide()
		mod.targetbar.frame:Hide()
		
	elseif event == "SPELLCAST_FAILED" then
		
		me.currentspell.isactive = false
		mod.castbar.frame:Hide()
		mod.targetbar.frame:Hide()
		
	elseif event == "SPELLCAST_INTERRUPTED" then
		me.currentspell.isactive = false
		mod.castbar.frame:Hide()
		mod.targetbar.frame:Hide()
		
	elseif event == "SPELLCAST_DELAYED" then
		me.currentspell.cast.delay = me.currentspell.cast.delay + arg1
		
	elseif event == "UI_ERROR_MESSAGE" then
		me.lastuierror = arg1
	end
	
end


me.onupdate = function()
		
	if me.currentspell.isactive == true then
		local timenow = GetTime()
		local lag = me.getlag() 
		
		if timenow > me.currentspell.cast.start + (me.currentspell.cast.duration + me.currentspell.cast.delay + lag) * 0.001 then
			me.currentspell.isactive = false
			mod.castbar.frame:Hide()
			mod.targetbar.frame:Hide()
		
		else
			-- the last parameter is "time elapsed" in milliseconds. First bit is "time now - time started", with 1000x to converty it to milliseconds. Second bit is the delay from spell interruptions. Last bit is compensating for screen update delay
			mod.castbar.setbarvalues(me.currentspell.cast.duration, lag, me.save.cancelzoneduration, 1000 * (timenow - me.currentspell.cast.start) - me.currentspell.cast.delay + math.min(200, 1000 / GetFramerate()))
			
			local currenthealth = UnitHealth(me.currentspell.target.unitid)
			local maxhealth = UnitHealthMax(me.currentspell.target.unitid)
			
			local heal = mod.healstats.expectedoverheal(maxhealth - currenthealth, me.currentspell.spell.id, me.currentspell.spell.rank, me.currentspell.target.unitid)
			
			mod.targetbar.redraw(me.currentspell.target.unitid, heal)
		end
	end	
	
end


--[[
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
					New Good Stuff
______________________________________________________________________
]]

--[[
me.dospellcast(targetunit, caststring)
Performs the healing spell.

<targetunit>	string; unitid of the desired target
<caststring>	string; exact argument to CastSpellByName

Return:	??
]]
me.dospellcast = function(targetunit, caststring)

	-- first stop any targetting that might have happened
	if SpellIsTargeting() then
		SpellStopTargeting()
	end
	
	-- clear ui error message
	me.lastuierror = ""

	-- now a bit of mumbojumbo to get a target
	if (UnitExists("target") == nil) or UnitIsEnemy("target", "player") then
		
		if me.trycast(caststring) == nil then
			return
		end
		
		if SpellCanTargetUnit(targetunit) then
			SpellTargetUnit(targetunit)
		
		else
			SpellStopTargeting()
			return
		end
	
	elseif UnitIsUnit("target", targetunit) then
		
		CastSpellByName(caststring)
		
		if SpellIsTargeting() then
			SpellStopTargeting()
			return
		end

	else
		
		ClearTarget()
		if me.trycast(caststring) == nil then
			TargetLastTarget()
			return
		end
		
		if SpellCanTargetUnit(targetunit) then
			SpellTargetUnit(targetunit)
		
		else
			SpellStopTargeting()
			TargetLastTarget()
			return
		end
		
		TargetLastTarget()
	end
	
	-- finally detect error messages:
	if me.lastuierror ~= "" then
		return
	end
	
	mod.castbar.frame:Show()
	mod.castbar.setspellname(caststring)
	
	mod.targetbar.frame:Show()
	return true
	
end

--[[
me.trycast(spellname)
Casts the spell <spellname> and checks for an error. The target will be nil or a hostile target, so if <spellname> is invalid, we won't get the spell targetter cursor. 

<spellname>	string; the localised argument to CastSpellByName, e.g. "Greater Heal(Rank 1)"

Return:	boolean; true for success, nil otherwise.
]]
me.trycast = function(spellname)
	
	CastSpellByName(spellname)
	
	if SpellIsTargeting() then
		return true
		
	else
		return
	end
	
end

me.save = 
{
	cancelzoneduration = 400,
	maximumoverheal = 0.2,
}

--[[
<me.save.cancelzoneduration> is the time in milliseconds that the spell is in the "yellow" zone, where it will be cancelled if there is an overheal predicted.
<me.lagerror> is the difference between average lag and worst case lag. It is expressed as a fraction of your lag. e.g. if your lag is 500, and <me.lagerror> is 0.2, we are saying that (almost) all latencies will be 500ms +- 100ms. It is believed that <me.lagerror> should hold constant for different latencies. 
	The value is used to determine when it is safe to cancel a heal for chaincasting, etc.
<me.maximumoverheal> is the maximum expected overheal allowed.
<me.nextsafecasttime> is when we can next cast a spell without getting a global cooldown error.
]]
me.lagerror = 0.25
me.nextsafecasttime = 0

--[[
me.getspellzone()
Indicates how far along the spellcast is.
Return values - Meaning
"red" 		spell is safe to cancel for a chaincast
"redyellow" spell is unsafe to cancel for a chain cast, but cannot be guaranteed as cancellable
"yellow"		spell can be cancelled, and should if it is overhealing
"green"		spell still has a while to go
]]
me.getspellzone = function()
	
	if me.currentspell.isactive == false then
		return
	end
	
	local lag = me.getlag()
	
	local elapsed = 1000 * (GetTime() - me.currentspell.cast.start) - me.currentspell.cast.delay
	local remain = me.currentspell.cast.duration + lag - elapsed
	
	if remain < lag * (1 - me.lagerror * 1.5) then
		return "red"
	
	elseif remain < lag * (1 + me.lagerror) then
		return "redyellow"
		
	elseif remain < lag * (1 + me.lagerror) + me.save.cancelzoneduration then
		
		return "yellow"
		
	else
		return "green"
	end
	
end

--[[
me.getlag()
Gives your latency in milliseconds.
]]
me.getlag = function()
	
	local _, _, lag = GetNetStats()
	return lag
	
end

--[[
me.shouldcancelcurrentspell()
Determines whether to cancel the current spell.

Return: x, y
x	boolean;	true means the spell should be cancelled, false means it should not
y	string; return value of me.getspellzone()
]]
me.shouldcancelcurrentspell = function()
	
	local zone = me.getspellzone()
	
	-- too early?
	if zone == "green" then
		return false, zone
	end
	
	-- too late?
	if zone == "red" then
		return true, zone
	end
	
	-- mid range: cancel if it will overheal
	if (zone == "yellow") or (zone == "redyellow") then 
		
		-- find the target again
		if me.currentspell.target.name ~= UnitName(me.currentspell.target.unitid) then
			
			-- lost him! have a look
			local newunitid = me.findgroupunitbyname(me.currentspell.target.name)
			
			-- can't find him! Give up :(	
			if newunitid == nil then
				return false, zone
			
			else
				me.currentspell.target.unitid = newunitid
			end
		end
		
		-- got the target. Get his hpvoid
		local hpvoid = UnitHealthMax(me.currentspell.target.unitid) - UnitHealth(me.currentspell.target.unitid)
		
		-- determine the expected heal and overheal
		local heal, overheal = mod.healstats.expectedoverheal(hpvoid, me.currentspell.spell.id, me.currentspell.spell.rank, me.currentspell.target.unitid)
		
		if overheal > heal * me.save.maximumoverheal then
			-- too much overheal
			return true, zone
		else
			return false, zone
		end
	end
	
end

--[[
me.findgroupunitbyname(name)
Gives the unitid of the player in the party or raid whose name is <name>. Call this method when the unitid / name match has gone out of sync.

<name> 	string; the name of a player in the raid or party.

Return: 	string; the unitid for <name>, e.g. "party3" or "raid21". Returns nil if <name> can't be found.
]]
me.findgroupunitbyname = function(name)

	local x

	if GetNumRaidMembers() > 0 then
		for x = 1, 40 do
			if UnitName("raid" .. x) == name then
				return "raid" .. x
			end
		end
		
	else
		if GetNumPartyMembers() > 0 then
			for x = 1, 4 do
				if UnitName("party" .. x) == name then
					return "party" .. x
				end
			end
		end
		
		if UnitName("player") == name then
			return "player"
		end
	end
	
end



me.currentspell = 
{
	target = 
	{
		unitid = "",
		name = "",
	},
	spell = 
	{
		id = "",
		rank = 0,
	},
	cast = 
	{
		start = 0,
		string = "",
		duration = 0,
		delay = 0,
		isconfirmed = false,
	},
	isactive = false
}


--[[
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
					Entry Points
______________________________________________________________________
]]

me.execute = function(spellname, extra, minheal)

--[[
	klhpm.main.blockevent("PLAYER_TARGET_CHANGED")
	klhpm.main.blockevent("ACTIONBAR_UPDATE_STATE")
	klhpm.main.blockevent("CURRENT_SPELL_CAST_CHANGED")
	
	me.executeinternal(spellname, extra, minheal)
	
	klhpm.main.unblockevent("PLAYER_TARGET_CHANGED")
	klhpm.main.unblockevent("ACTIONBAR_UPDATE_STATE")
	klhpm.main.unblockevent("CURRENT_SPELL_CAST_CHANGED")
	]]
	
	me.executeinternal(spellname, extra, minheal)
end

--[[
<mod>.main.execute(spellname, extra)
Entry Point - called from the user's macro. Checks up on the current spell, or casts a new one on the current target.
]]
me.executeinternal = function(spellname, extra, minheal)
	
	-- 1) Update Current Spell if Necessary
	local shouldcancel, spellzone, isrecast
	
	if me.currentspell.isactive == true then
		
		-- do we need to cancel it?
		shouldcancel, spellzone = me.shouldcancelcurrentspell()
				
		if shouldcancel == true then	
			me.nextsafecasttime = me.currentspell.cast.start + 1.5 + me.getlag() * me.lagerror * 0.001
			SpellStopCasting()
			isrecast = true
		else
			return
		end
	end
	
	-- 2) Check whether we are on the cooldown
	if GetTime() < me.nextsafecasttime then
		return
	end
	
	-- 3) Pick the Variety of Spell To Use
	-- has the user given us input? A valid spell, perhaps?
	local spellid = mod.string.unlocalise("spellname", spellname)
	
	if spellid and (mod.data.spell[spellid].class == mod.my.class) then
		-- spell is legit. yay.
		
	else
		spellid = mod.spell.primaryclassspell()
		
		-- if the guy is not a healer, barr him
		if spellid == nil then
			return
		end
	end
	
	-- 4) list all targets in order
	if extra == "target" then
		mod.target.redoprioritylist(true)
	else
		mod.target.redoprioritylist()
	end
	
	-- 5) cast a low rank spell to check valid targets
	
	-- a) cache old target
	local hadtarget = false
	
	if UnitExists("target") then
		hadtarget = true
	end
	
	-- b) get spall name
	local spellname = mod.string.get("spellname", spellid)
	
	-- c) cast on blank
	ClearTarget()
	CastSpellByName(string.format(mod.string.get("caststring"), spellname, 1))
	
	-- success?
	if SpellIsTargeting() == nil then
		return
	end
		
	-- 6) Iterate over the target list
	local targetdata
	
	for x = 1, table.getn(mod.target.prioritylist) do
		targetdata = mod.target.prioritylist[x]
		
		-- check for end of list
		if (targetdata == nil) or (targetdata.name == "") then
			break
		end
		
		-- check if we can target this guy
		if SpellCanTargetUnit(targetdata.unitid) and (UnitIsDead(targetdata.unitid) == nil) then
			SpellStopTargeting()
			me.dospellfortarget(spellid, isrecast, targetdata.unitid, minheal)
			break
		end
	end
	
	-- clean up
	if SpellIsTargeting() then
		SpellStopTargeting()
	end
	
	if hadtarget == true then
		TargetLastTarget()
	end

end


--[[
me.dospellfortarget(spellid, isrecast, targetunit, minheal)
Casts a spell. TargetUnit has passed a SpellCanTargetUnit test
]]
me.dospellfortarget = function(spellid, isrecast, targetunit, minheal)
		
	local spellid, rank = mod.spell.bestspellfortarget(targetunit, spellid, minheal)
	
	-- check for same spell recast
	if (isrecast == true) and (spellid == me.currentspell.spell.id) and (rank == me.currentspell.spell.rank) then
		-- alternate rank
		spellid, rank = mod.spell.alternatespell(spellid, rank, targetunit, minheal)
	end
	
	-- try cast
	local caststring = string.format(mod.string.get("caststring"), mod.string.get("spellname", spellid), rank)
	
	if me.dospellcast(targetunit, caststring) == nil then
		return
	end
	
	-- to get here, it succeeded
	me.currentspell.isactive = true
	
	-- fill in cast and spell details
	me.currentspell.spell.id = spellid
	me.currentspell.spell.rank = rank
	
	me.currentspell.target.unitid = targetunit
	me.currentspell.target.name = UnitName(targetunit)
	
	me.currentspell.cast.start = GetTime()
	me.currentspell.cast.string = caststring
	me.currentspell.cast.duration = mod.my.getspellcasttime(spellid, rank) * 1000
	me.currentspell.cast.delay = 0
	me.currentspell.cast.isconfirmed = false
	
	return true
	
end