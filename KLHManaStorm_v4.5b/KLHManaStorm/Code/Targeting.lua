
-- module setup
local me = { name = "target"}
local mod = thismod
mod[me.name] = me

--[[
Targeting.lua

This module determines who in the raid to heal.
]]

me.save = 
{
	class = 
	{
		warrior = 1.0,
		druid = 1.0,
		shaman = 1.0,
		rogue = 1.0,
		paladin = 1.0,
		priest = 1.0,
		mage = 1.0,
		warlock = 1.0,
		hunter = 1.0,
	},
	raidgroup =  -- careful, the keys are numbers, not strings
	{
		[1] = 1.0,
		[2] = 1.0,
		[3] = 1.0,
		[4] = 1.0,
		[5] = 1.0,
		[6] = 1.0,
		[7] = 1.0,
		[8] = 1.0,
	},
	friend = { },
	personal = 
	{
		you = 1.0,
		target = 1.0,
		group = 1.0,
	},
	aggro = 
	{
		boss = 1.5,
		elite = 1.2,
		nonelite = 1.1,
	},
	randomisation = 
	{
		maxmultiplier = 1.3,
	}
}

me.prioritylistindex = 0 -- set to 0 after every call to redoprioritylist

-- checks if the casting engine is up and running
me.isspellcapable = function()
	
	local action = mod.data.findanyspellaction()
	if action == nil then
		return
	end
	
	-- check usable
	local isusable, mana = IsUsableAction(action)
	
	if isusable == nil and mana == nil then
		return
	end
	
	return true 
	
end


-- return: <unitid>, or nil
me.getnextbesttarget = function()
	
	-- get a spell action
	local action = mod.data.findanyspellaction()
	if action == nil then
		mod.print("Can't find any healing spells on your action bars.")
		return
	end
		
	-- iterate over priority list
	me.prioritylistindex = me.prioritylistindex + 1
	local target, ismytarget
	
	for x = me.prioritylistindex, table.getn(me.prioritylist) do
		if (me.prioritylist[x] == nil) or (me.prioritylist[x].name == "") then
			break
		end
	
		target = me.prioritylist[x].unitid
		if UnitIsUnit(target, "target") then
			ismytarget = true
		else
			ismytarget = false
		end
		
		-- investigate this guy for targetting
		TargetUnit(target)
		
		-- in range? alive?
		if (IsActionInRange(action) == 1) and (UnitIsDeadOrGhost(target) == nil) then
			
			-- revert target
			if ismytarget == false then
				TargetLastTarget()
			end
			
			return target
			
		else
			if ismytarget == false then
				TargetLastTarget()
			end
		end
	end
	
	return nil
	
end

-- return: true or nil
me.istargetvalid = function(target)

	-- get a spell action
	local action = mod.data.findanyspellaction()
	if action == nil then
		mod.print("Can't find any healing spells on your action bars.")
		return
	end

	TargetUnit(target)
	
	-- in range? alive?
	if (IsActionInRange(action) == 1) and (UnitIsDeadOrGhost(target) == nil) then
		return true
	end
	
end

--[[
me.targettogroupunitid()
Finds the "partyx" or "raidx" or "player" unitid for the target. Includes pets too.

Return:	string; unitid of the unit, or nil if the target is not in your group.
]]
me.targettogroupunitid = function()
	
	local unit
	
	-- raid
	if GetNumRaidMembers() > 0 then
		
		for x = 1, 40 do
			unit = "raid" .. x
			if UnitIsUnit("target", unit) then
				return unit
			end
			
			unit = "raid" .. x .. "pet"
			if UnitIsUnit("target", unit) then
				return unit
			end
		end
	
	-- party
	elseif GetNumPartyMembers() > 0 then
		
		for x = 1, 4 do
			unit = "party" .. x
			if UnitIsUnit("target", unit) then
				return unit
			end
			
			unit = "party" .. x .. "pet"
			if UnitIsUnit("target", unit) then
				return unit
			end
		end
		
	end
	
	-- self
	if UnitIsUnit("target", "player") then
		return "player"
	end
	
	if UnitIsUnit("target", "playerpet") then
		return "player"
	end
	
	-- (return nil)
end

me.test = function()
	
	me.redoprioritylist()
	me.dumpprioritylist()
	
end

me.dumpprioritylist = function()
	
	for x = 1, math.min(10, table.getn(me.prioritylist)) do
		if (me.prioritylist[x] == nil) or (me.prioritylist[x].name == "") then
			break
		end
		
		mod.print(string.format("|cffffff00%s  |cff00ff00%s.", me.prioritylist[x].name, me.prioritylist[x].value))
	end
	
end

me.reverseraidroster = { }

me.redoreverseraidroster = function()
		
	for x = 1, 40 do
		name, _, group = GetRaidRosterInfo(x)
		me.reverseraidroster[name] = group
	end
	
end


-- indexed by number (this is a sorted list)
-- items are of the form { name = , unitid = , value = }
me.prioritylist = { }

me.redoprioritylist = function(targetfirst)

	local count = 0
	local name, unitid, value
	
	if GetNumRaidMembers() > 0 then
		
		for x = 1, 40 do
			
			unitid = "raid" .. x
			name = UnitName(unitid)
			
			if name then
				count = count + 1
				value = me.getpriority(unitid)
				me.additemtoprioritylist(name, unitid, value, count)
			end
		end
		
	else
		
		-- 1) player
		count = count + 1
		unitid = "player"
		name = UnitName("player")
		value = me.getpriority(unitid)
		me.additemtoprioritylist(name, unitid, value, count)
		
		-- 2) Party
		if GetNumPartyMembers() > 0 then
			
			for x = 1, 4 do
				unitid = "party" .. x
				name = UnitName(unitid)
				
				if name then
					count = count + 1
					value = me.getpriority(unitid)
					me.additemtoprioritylist(name, unitid, value, count)
				end		
			end
		end
	end

	-- add the target first if user requests
	if targetfirst == true then
		local targetid = me.targettogroupunitid()
		
		if targetid then
			
			-- get the highest priority currently in the list
			if count == 0 then
				value = 1
			else
				value = me.prioritylist[1].value + 1
			end
			
			-- now add it
			count = count + 1
			me.additemtoprioritylist(UnitName("target"), targetid, value, count)
		end
	end

	-- seal the end of the list
	if me.prioritylist[count + 1] then 
		me.prioritylist[count + 1].name = ""
	end
	
	-- reset iterator index
	me.prioritylistindex = 0
	
end

me.getpriority = function(unitid)
	
	local score = UnitHealthMax(unitid) - UnitHealth(unitid)
		
	-- multipliers
	score = score * me.getmultipliers(unitid)
	
	-- done
	return score
end

me.getmultipliers = function(unitid)
	
	local score = 1
	
	-- class priority
	local _, class = UnitClass(unitid)
	class = string.lower(class)
	score = score * me.save.class[class]
	
	-- raid group priority
	if GetNumRaidMembers() > 0 then
		
		-- add group priority
		local group = me.reverseraidroster[UnitName(unitid)]
		if group and me.save.raidgroup[group] then
			score = score * me.save.raidgroup[group]
			
			-- add "my group" priority
			if group == me.reverseraidroster[UnitName("player")] then
				score = score * me.save.personal.group
			end
		end
		
	end
	
	-- "target" priority
	if UnitIsUnit(unitid, "target") then
		score = score * me.save.personal.target
	end
	
	-- "me" priority
	if UnitIsUnit(unitid, "player") then
		score = score * me.save.personal.you
	end
	
	-- randomisation
	score = score * math.random(100, 100 * me.save.randomisation.maxmultiplier) / 100
	
	return score
	
end

me.additemtoprioritylist = function(name, unitid, value, maxindex)
	
	-- after adding, this will have index at most <maxindex>
	-- i.e. there are <maxindex> - 1 items in the list already
	
	local x, newindex
	
	for x = 1, maxindex do
		
		if (x == maxindex) or (me.prioritylist[x] == nil) or (me.prioritylist[x].value < value) then		
			newindex = x
			break
		end
	end
	
	if me.prioritylist[newindex] == nil then
		me.prioritylist[newindex] = { }
	end
	
	-- first shuffle the rest down
	for x = maxindex, newindex + 1, -1 do
		
		if me.prioritylist[x] == nil then
			me.prioritylist[x] = { }
		end
		
		me.prioritylist[x].unitid = me.prioritylist[x - 1].unitid
		me.prioritylist[x].name = me.prioritylist[x - 1].name
		me.prioritylist[x].value = me.prioritylist[x - 1].value
		
	end
	
	me.prioritylist[newindex].unitid = unitid
	me.prioritylist[newindex].name = name
	me.prioritylist[newindex].value = value
	
end
	
	