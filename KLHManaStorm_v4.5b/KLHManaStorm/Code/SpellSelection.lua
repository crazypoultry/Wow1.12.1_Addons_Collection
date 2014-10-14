--! special comment!
-- module setup
local me = { name = "spell"}
local mod = thismod
mod[me.name] = me

--[[
SpellSelection.lua

This module picks an appropriate spell to cast, given a target.

One minor problem is that we would prefer Heal and GreaterHeal to be the same spell, with GreaterHeal 1 == Heal 5. So there is a bit of fiddling about converting Heal to GreaterHeal and vice versa to make several methods run more smoothly.
]]

me.save = 
{
	hitpointvoidscale = 0.85,
	maximumoverheal = 0.15,
	minimumaverageheal = 800,
}

--[[
mod.spell.bestspellfortarget(targetid, spellid)
	Picks the best spell for the target. The primary concern is to match the heal to the target's life; a larger hit point void needs a larger heal. We don't want the spell to overheal, so we pick the highest spell rank that has at least some minimum efficiency. e.g. "pick the highest rank of heal that we predict will be 90% or more used on the target".

<targetid>	string; unitid of the target of the spell.
<spellid>	string; internal spell name, e.g. "greaterheal"

Return: x, y
	<x>		string; internal spell name of the chosen spell, e.g. "greaterheal"
	<y>		integer; rank of the chosen spell, e.g. 3
]]
me.bestspellfortarget = function(targetid, spellid, minheal)
	
	local hpvoid = UnitHealthMax(targetid) - UnitHealth(targetid)
	hpvoid = hpvoid * me.save.hitpointvoidscale
	
	-- treat greaterheal as just a high rank of heal
	if spellid == "greaterheal" then
		spellid = "heal"
	end
	
	-- this gets the best spell rank just in terms of efficiency
	local spellid, rank = me.biggestefficientspell(hpvoid, targetid, spellid, minheal)
	
	-- we don't want to downrank too far though! This gets the minimum rank we should use
	local minrank = me.minimumspellrank(spellid, targetid, minheal)
	
	return me.realspellrank(spellid, math.max(rank, minrank))
	
end

--[[
me.biggestefficientspell(hpvoid, targetid)
	Picks the best spell to match the given hit point void. Too low a rank would not heal enough of the void. Too high a rank would likely be an overheal.
	
<hpvoid>	number; the amount of hitpoints the target is missing.
<targetid>	string; unitid of the target of the spell.

Return:	spellid, rank
	<spellid>	string; internal name of the spell to cast, e.g. "greaterheal"
	<rank>		integer; rank of the spell to cast
]]
me.biggestefficientspell = function(hpvoid, targetid, spellid)
		
	-- desired efficiency
	local minefficiency = 1 - me.save.maximumoverheal
	
	-- get maximum rank
	local maxspellrank = mod.my.maxspellrank(spellid)
	
	local efficiency
	local bestrank = 0
	
	-- The lowest spells will be 100% efficient, the highest spells will be 0% efficient (or maybe more, if hpvoid is very large). Efficiency is monotonically decreasing with increasing ranks.
	for x = 1, maxspellrank do
		local efficiency = me.spellefficiency(spellid, x, hpvoid, targetid)
		
		if efficiency < minefficiency then
			break
		else
			bestrank = x
		end
	end
		
	return me.realspellrank(spellid, bestrank)
	
end

--[[
me.minimumspellrank(spellid, targetid)
	Gives the lowest rank of the spell that we are allowed to cast. It is pointless to cast level 1 spells since their dps is too low. Spells below level 20 are prohibited, since they receive a reduced effect from +healing, so will be less mana efficient than higher rank spells. Further, the user specifies a minimum expected heal, e.g. 1000 or so, that the spell must achieve.
]]
me.minimumspellrank = function(spellid, targetid, minheal)
	
	local minrank = 0
	if minheal == nil then
		minheal = me.save.minimumaverageheal
	end
	
	-- concern 1: spell level >= 10
	for x = 1, 4 do
		minrank = x
		
		if mod.data.spell[spellid][x].level >= 10 then
			break
		end
	end
	
	-- concern 2: expected heal above some certain minimum
	local maxspellrank = mod.my.maxspellrank(spellid)
	local expectedheal, realspellid, realrank
	
	for x = minrank, maxspellrank do
		
		realspellid, realrank = me.realspellrank(spellid, x)
		
		expectedheal = mod.healstats.expectedoverheal(0, realspellid, realrank, targetid)
		
		if expectedheal >= minheal then
			return x
		end
	end
	
	return maxspellrank
		
end

--[[
mod.spell.alternatespell(spellid, rank)
	Picks the next best spell if the given one is unavailable. When you cancel a spell and cast a new one at the same time, it isn't possible to cast the old spell again, or the new cast can't be cancelled. This is just a UI issue, nothing we can do about it. 
	Anyway, this method will be called after we have just cancelled the spell (<spellid>, <rank>). We want to pick a new one instead. In general we will downrank, to maintain / increase efficiency. But if <rank> was the minimum allowed rank of <spellid>, then we ill uprank instead.
	
<spellid>	string; internal spell name, e.g. "greaterheal"
<rank>		integer; rank of the spell just cancelled.

Return: <newspellid>, <newrank>
	<newspellid>	string; internal name of the new spell. Usually the same as <spellid>, unless e.g. Greater Heal 1 gets downranked to Heal 4
	<newrank>		integer; rank of the new spell.
]]
me.alternatespell = function(spellid, rank, targetid, minheal)
	
	-- convert gheal down
	if spellid == "greaterheal" then
		spellid, rank = "heal", rank + 4
	end
	
	if me.minimumspellrank(spellid, targetid, minheal) == rank then
		rank = rank + 1
	else
		rank = rank - 1
	end
	
	return me.realspellrank(spellid, rank)
end

--[[
me.realspellrank(spellid, rank)
	This basically converts "Heal 6" to "Greater Heal 2". As mentioned above, we treat ranks of Greater Heal as high ranks of Heal to make things run smoothly. But when we go to cast the spell, we have to use the proper name. 
	
<spellid>	string; internal spell name
<rank>		integer; rank of the spell

Return: <newspellid>, <newrank>
	<newspellid>	string; real internal spell name
	<rank>			integer; real rank
]]
me.realspellrank = function(spellid, rank)
	
	if spellid == "heal" and rank > 4 then
		return "greaterheal", rank - 4
	else
		return spellid, rank
	end
	
end

--[[
me.spellefficiency(spellid, rank, hpvoid, targetid)
	Gives the expected fraction of the given spell that will be used on the given target. e.g. big heal on small hit point void = low efficiency, small heal of high hit point void = high efficiency.

<spellid>	string; internal spell name
<rank>		integer; rank of the spell
<hpvoid>		number; hit points the target is missing
<targetid>	string; unitid of the spell target

Return: 		number; fraction of the heal amount used. between 0 and 1. 0 = 100% overheal, 1 = no overheal.
]]
me.spellefficiency = function(spellid, rank, hpvoid, targetid)
	
	spellid, rank = me.realspellrank(spellid, rank)
	
	local heal, overheal = mod.healstats.expectedoverheal(hpvoid, spellid, rank, targetid)
	
	return (heal - overheal) / heal
	
end

--[[
me.primaryclassspell()
	Gives the main healing spell for the purposes of the mod. We focus on spells with a long casting time, since they can effectively be chain cancelled.
]]
me.primaryclassspell = function()
	
	if mod.my.class == "priest" then
		return "heal"
	
	elseif mod.my.class == "druid" then
		return "healingtouch"
		
	elseif mod.my.class == "paladin" then
		return "holylight"
		
	elseif mod.my.class == "shaman" then
		return "healingwave"
		
	end
	
end