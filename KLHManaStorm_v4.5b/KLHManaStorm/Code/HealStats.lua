
-- module setup
local me = { name = "healstats"}
local mod = thismod
mod[me.name] = me

-- debug crap

--[[
to start:

/script klhms.healstats.go()

after 50 events to keep going

/script klhms.healstats.eventcount = 0

]]

me.go = function()
	
	if me.frame then
		mod.print("our frame already exists!")
		return
	end
	
	me.frame = CreateFrame("Frame", nil, UIParent)
	me.frame:SetScript("OnEvent", me.eventhandler)
	me.frame:RegisterAllEvents()
	
	me.eventcount = 0
	
	mod.print("operational!")
end


me.eventhandler = function()
	
	me.eventcount = me.eventcount + 1
	
	if me.eventcount > 50 then
		return
	end
	
	me.printevent()
		
end

me.printevent = function()
	
	local argcount = 0
	
	for x = 9, 1, -1 do
		if getglobal("arg" .. x) then
			argcount = x
			break
		end
	end
	
	local message = event .. ": "
	
	for x = 1, argcount do
		message = message  .. tostring(getglobal("arg" .. x)) .. ", "
	end
	
	mod.print(message)
	
end


--[[
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
			Computing the expected overheal of a spell
______________________________________________________________________
]]

--[[
mod.main.expectedoverheal(hpvoid, spellid, spellrank, target)
Gives the average amount of overheal from the specified spell and target hitpoint deficit. The average is ranged over all possible heal values and ciritical heal values. It includes bonuses from talents and +healing. Also gets mods from Mortal Strike, Mortal Wounds, Blessing of Light.

<hpvoid>		integer; amount of hitpoints the target is missing
<spellid>	string; spell identifier; key in level 2 of mod.data.spell, e.g. "greaterheal"
<spellrank>	integer; rank of the spell.
<target>		string; unitid of the target of the heal.

Return:		number, number; average total heal, average overheal.
]]
me.expectedoverheal = function(hpvoid, spellid, spellrank, target)
	
	local min, max = mod.my.getspellrange(spellid, spellrank)
	
	local critrate = mod.my.getspellcritstat(spellid)
	
	-- healing modifiers due to target debuffs:
	local add = 0
	local multiply = 1.0
	
	-- 1) Blessing of Light for Paladins
	if (mod.my.class == "paladin") and mod.unithasbuff(target, "Icons\\Interface\\Spell_Holy_PrayerOfHealing02") then
		if UnitLevel("player") >= 60 then
			if spellid == "flashoflight" then
				add = 115
			elseif spellid == "holylight" then
				add = 400
			end
		
		elseif UnitLevel("player") >= 50 then
			if spellid == "flashoflight" then
				add = 85
			elseif spellid == "holylight" then
				add = 300
			end
			
		elseif UnitLevel("player") >= 40 then
			if spellid == "flashoflight" then
				add = 60
			elseif spellid == "holylight" then
				add = 210
			end
		end
	end
		
	-- 2) Mortal Strike
	if me.unithasdebuff(target, "Icons\\Interface\\Ability_Warrior_SavageBlow") then
		multiply = 0.5
	end
	
	-- 3) Mortal Wound
	local stacks = me.unithasdebuff(target, "Icons\\Interface\\Ability_CriticalStrike")
	
	if stacks then
		multiply = 1 - 0.1 * stacks
	end
	
	-- recalculate min, max
	min = (min + add) * multiply
	max = (max + add) * multiply
	
	return me.expectedoverhealinternal(hpvoid, min, max, critrate)
	
end

--[[
me.expectedoverhealinternal(hpvoid, mineffect, maxeffect, critrate)
Gives the average amount of overheal given the range of a non-crit heal, your crit rate, and the target's hitpoint deficit. 

<hpvoid>		integer; amount of hitpoints the target is missing
<mineffect>	number; minimum non-crit heal from the spell, including bonuses
<maxeffect> number; maximum non-crit heal from the spell, including bonuses
<critrate>  number; spell crit chance, should be between 0 and 1.

Return:		number, number; average total heal, average overheal.
]]
me.expectedoverhealinternal = function(hpvoid, mineffect, maxeffect, critrate)
	
	local hitheal = (mineffect + maxeffect) / 2
	local critheal = hitheal * 1.5
	local heal = hitheal * (1 - critrate) + critheal * critrate
	
	local hitoverheal = me.expectedoverhealinternal2(hpvoid, mineffect, maxeffect)
	local critoverheal = me.expectedoverhealinternal2(hpvoid, mineffect * 1.5, maxeffect * 1.5)
	local overheal = hitoverheal * (1 - critrate) + critoverheal * critrate
	
	return heal, overheal
end

--[[
me.unithasdebuff(unit, debuff)
	Tells whether the specified unit has the specified debuff. Returns nil for no, or the number of stacks if true.

<unit>	string; the unitit of the player of interest, e.g. "raid21"
<debuff>	string; the name of the texture of the debuff, e.g. "Icons\\Interface\\Ability_CriticalStrike"

Return:	nil if hte target doesn't have it, or the number of stacks if he does.
]]
me.unithasdebuff = function(unit, debuff)
	
	local texture, stacks
	
	for x = 1, 16 do
		texture, stacks = UnitDebuff(unit, x)
		
		if texture == nil then
			return
		end
		
		if texture == debuff then
			return stacks
		end
	end
	
end

--[[
me.unithasbuff(unit, buff)
	Tells whether the specified unit has the specified buff. Returns <nil> or <true>

<unit>	string; the unitit of the player of interest, e.g. "raid21"
<buff>	string; the name of the texture of the buff, e.g. "Icons\\Interface\\Ability_CriticalStrike"

Return:	<nil> if the target doesn't have it, <true> if he does.
]]
me.unithasbuff = function(unit, buff)
	
	local texture, stacks
	
	for x = 1, 16 do
		texture, stacks = UnitDebuff(unit, x)
		
		if texture == nil then
			return
		end
		
		if texture == buff then
			return true
		end
	end
	
end


--[[
me.expectedoverhealinternal2(hpvoid, mineffect, maxeffect)
Gives the average amount of overheal given the range of a heal with a known result (hit or crit) and the target's hitpoint deficit.

<hpvoid>		integer; amount of hitpoints the target is missing
<mineffect>	number; minimum non-crit heal from the spell, including bonuses
<maxeffect> number; maximum non-crit heal from the spell, including bonuses

Return:		number, number; average total heal, average overheal.
]]
me.expectedoverhealinternal2 = function(hpvoid, mineffect, maxeffect)

	-- case 1: even the small end of the heal range would be an overheal
	if hpvoid < mineffect then
		return ((mineffect + maxeffect) / 2) - hpvoid
	end
	
	-- case 2: even the large end of the heal range would not be an overheal
	if hpvoid > maxeffect then
		return 0
	end
	
	-- case 3: a large heal would overheal, but a small one would not
	return ((maxeffect - hpvoid)^2) / (2 * (maxeffect - mineffect))
	
end


--[[
mod.main.expectedunderheal(hpvoid, spellid, spellrank)
Gives the average amount of overheal from the specified spell and target hitpoint deficit. The average is ranged over all possible heal values and ciritical heal values. It includes bonuses from talents and +healing.

<hpvoid>		integer; amount of hitpoints the target is missing
<spellid>	string; spell identifier; key in level 2 of mod.data.spell, e.g. "greaterheal"
<spellrank>	integer; rank of the spell.

Return:		number, number; average total heal, average overheal.
]]
me.expectedunderheal = function(hpvoid, spellid, spellrank)
	
	local min, max = mod.my.getspellrange(spellid, spellrank)
	
	local critrate = mod.my.getspellcritstat(spellid)
	
	return me.expectedunderhealinternal(hpvoid, min, max, critrate)
	
end

--[[
me.expectedoverhealinternal(hpvoid, mineffect, maxeffect, critrate)
Gives the average amount of overheal given the range of a non-crit heal, your crit rate, and the target's hitpoint deficit.

<hpvoid>		integer; amount of hitpoints the target is missing
<mineffect>	number; minimum non-crit heal from the spell, including bonuses
<maxeffect> number; maximum non-crit heal from the spell, including bonuses
<critrate>  number; spell crit chance, should be between 0 and 1.

Return:		number, number; average total heal, average overheal.
]]
me.expectedunderhealinternal = function(hpvoid, mineffect, maxeffect, critrate)

	local hitheal = (mineffect + maxeffect) / 2
	local critheal = hitheal * 1.5
	local heal = hitheal * (1 - critrate) + critheal * critrate
	
	local hitunderheal = me.expectedunderhealinternal2(hpvoid, mineffect, maxeffect)
	local critunderheal = me.expectedunderhealinternal2(hpvoid, mineffect * 1.5, maxeffect * 1.5)
	local underheal = hitunderheal * (1 - critrate) + critunderheal * critrate
	
	return heal, underheal
end

--[[
me.expectedoverhealinternal2(hpvoid, mineffect, maxeffect)
Gives the average amount of overheal given the range of a heal with a known result (hit or crit) and the target's hitpoint deficit.

<hpvoid>		integer; amount of hitpoints the target is missing
<mineffect>	number; minimum non-crit heal from the spell, including bonuses
<maxeffect> number; maximum non-crit heal from the spell, including bonuses

Return:		number, number; average total heal, average overheal.
]]
me.expectedunderhealinternal2 = function(hpvoid, mineffect, maxeffect)

	-- case 1: even the small end of the heal range would be an overheal
	if hpvoid < mineffect then
		return 0
		--return ((mineffect + maxeffect) / 2) - hpvoid
	end
	
	-- case 2: even the large end of the heal range would not be an overheal
	if hpvoid > maxeffect then
		return hpvoid - ((mineffect + maxeffect) / 2)
		--return 0
	end
	
	-- case 3: a small heal would underheal, but a large one would not
	return ((hpvoid - mineffect)^2) / (2 * (maxeffect - mineffect))
	
end