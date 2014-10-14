
-- module setup
local me = { name = "my"}
local mod = thismod
mod[me.name] = me

--[[
My.lua

This module tracks data for our character.
]]

_, me.class = UnitClass("player")
me.class = string.lower(me.class)

-- These methods will be called periodically by Core.lua. Key = method name, value = seconds between method calls.
me.myonupdates = 
{
	updatespellranks = 10.0,
}

--[[
mod.my.getspellcrit()
Gives our spell crit rate.

<spellid>	string; the internal name of the spell being cast, e.g. "greaterheal"

Return: number; between 0 and 1.
]]
me.getspellcritstat = function(spellid)
	
	local _, intellect = UnitStat("player", 4)
	local crit = intellect / 60
	
	-- get item buffs from bonus scanner, if available
	if BonusScanner then
		crit = crit + BonusScanner:GetBonus("SPELLCRIT")
	end
	
	-- get buffs from talents:
	if me.class == "priest" then
		crit = crit + mod.data.gettalentvalue("holyspec")
		
	elseif (me.class == "druid") and (spellid == "regrowth") then
		crit = crit + mod.data.gettalentvalue("regrowth")
		
	elseif me.class == "paladin" then
		crit = crit + mod.data.gettalentvalue("holypower")
		
	elseif me.class == "shaman" then
		crit = crit + mod.data.gettalentvalue("tidalmastery")
	end
	
	-- get buffs from buffs (zhc / prayer beads / etc):
	
	-- convert to percentage
	return crit * 0.01
	
end

--[[
mod.my.gethealingstat()
Gives the total +healing stat you currently have.

Return: number; your +healing value
]]
me.gethealingstat = function()
	
	local healing = 0
	
	-- get item buffs from bonus scanner, if available
	if BonusScanner then
		healing = healing + BonusScanner:GetBonus("HEAL")
	end
	
	-- talent buffs:
	if me.class == "priest" then
		local _, spirit = UnitStat("player", 5)
		local multiplier = mod.data.gettalentvalue("spiritualguidance")
		
		healing = healing + spirit * multiplier
	end
	
	-- get buffs from buffs (zhc / prayer beads / etc):
	
	return healing
	
end

--[[
mod.my.getspellrange(spell, rank)
Gives the minimum and maximum healing value of the specified spell, including all your active bonuses.

<spell>	string; a key in <mod.data.<class>>, e.g. "heal", "greaterheal"
<rank>	integer; the rank of the spell.

Return:	number, number; the minimum heal and maximum heal possible.
]]
me.getspellrange = function(spell, rank)

	local spelldata = mod.data.spell[spell][rank]
	
	local min = spelldata.min
	local max = spelldata.max

	-- talents that affect the base value:
	if me.class == "priest" then
		local multiplier = 1.0 + mod.data.gettalentvalue("spiritualhealing")
		
		min = min * multiplier
		max = max * multiplier
		
	elseif me.class == "druid" then
		local multiplier = 1.0 + mod.data.gettalentvalue("giftofnature")
		
		min = min * multiplier
		max = max * multiplier
		
	elseif me.class == "paladin" then
		local multiplier = 1.0 + mod.data.gettalentvalue("holylight")
		
		min = min * multiplier
		max = max * multiplier
		
	elseif me.class == "shaman" then
		local multiplier = 1.0 + mod.data.gettalentvalue("purification")
		
		min = min * multiplier
		max = max * multiplier
	end

	-- +healing coefficient
	local healing = me.gethealingstat()

	-- modifier for spell level
	if spelldata.level < 20 then
		healing = healing * (1 - (20 - spelldata.level) * 0.035)
	end

	-- modifier for spell casting time
	local casttime = mod.data.spell[spell][rank].time
	
	casttime = math.max(casttime, 1.5)
	casttime = math.min(casttime, 3.5)
	
	healing = healing * casttime / 3.5
	
	-- modifier for specific spells
	if spellid == "regrowth" then
		healing = healing / 2
	end
	
	min = min + healing
	max = max + healing
	
	return min, max
	
end

--[[
mod.my.getspellcasttime(spell, rank)
Gets the cast time of the specified spell, including talents and other bonuses.

<spell>	string; a key in <mod.data.<class>>, e.g. "heal", "greaterheal"
<rank>	integer; the rank of the spell.

Return:	number; the casting time in seconds.
]]
me.getspellcasttime = function(spell, rank)
	
	local spelldata = mod.data.spell[spell][rank]

	if spelldata == nil then
		mod.print(string.format("no spell data for spell = %s, rank = %s.", tostring(spell), tostring(rank)))
	end
	
	-- got spelldata == nil here. What spell / rank combo was it? gheal problem?!
	local casttime = spelldata.time
	
	-- 1) update for talents
	if me.class == "priest" then
		if spell == "heal" or spell == "greaterheal" then
			casttime = casttime + mod.data.gettalentvalue("divinefury")
		end
		
	elseif (me.class == "druid") and (spell == "healingtouch") then
		casttime = casttime + mod.data.gettalentvalue("healingtouch")
		
	elseif (me.class == "shaman") and (spell == "healingwave") then
		casttime = casttime + mod.data.gettalentvalue("healingwave")
	end
	
	-- 2) other bonuses. items? buffs?
	
	return casttime
	
end

--[[
--------------------------------------------------------------------------
			What Ranks of Each Spell Do I Know?
--------------------------------------------------------------------------
]]

--[[
me.spellranks is a keyed list. The key is the internal name of the spell, and the value is the highest rank of the spell we have learnt. It might look like this:

	me.spellranks = 
	{
		heal = 4,
		greaterheal = 4,
	}
	
It is updated regularly but infrequently, in the off chance you learn a new rank. It only records spells that this mod is interested.
]]
me.spellranks = { } 

--[[
mod.my.maxspellrank(spellid)
	Gives the maximum rank of the given spell that you know. We treat Greater Heal as a higher rank of Heal, so their ranks will be added together.
	
<spellid>	string; internal spell name, e.g. "greaterheal"

Return:		integer; highest rank of that spell we know.
]]
me.maxspellrank = function(spellid)
	
	local value = me.spellranks[spellid]
	
	-- return 0 if we don't have the spell
	if value == nil then
		return 0
	end
	
	if spellid == "heal" and me.spellranks.greaterheal then
		value = value + me.spellranks.greaterheal
	end
	
	return value
	
end

--[[
me.updatespellranks()
Redetermines the max ranks of your healing spells. This will be called periodically by Core.lua.
]]
me.updatespellranks = function()
	
	local index = 0
	local name, rankstring, rank, spellid
	local rankpattern = mod.string.get("spellrank") -- e.g. "Rank %d" in english.
		
	while true do
		index = index + 1
		name, rankstring = GetSpellName(index, "spell")
		
		if name == nil then
			break
		end
		
		-- get the internal spell ID
		spellid = mod.string.unlocalise("spellname", name)
		
		if spellid and mod.data.spell[spellid] then
			rank = 0
			
			_, _, rank = string.find(rankstring, rankpattern)
			if rank then
				me.spellranks[spellid] = rank
			end
		end
	end
	
end