
-- module setup
local me = { name = "data"}
local mod = thismod
mod[me.name] = me

--[[
Data.lua

This module contains all the raw data for spells and talents, and some methods to retrieve them

]]

me.myevents = { "CHAT_MSG_SPELL_PARTY_DAMAGE" }

me.onevent = function()
	
	if event == "CHAT_MSG_SPELL_PARTY_DAMAGE" then
		
		_, _, a, b, c = string.find(arg1, "(.+) interrupts (.+)'s (.+)")
		
		if a then
			--ChatFrame1:AddMessage(arg1)	
		end
	end
	
end

--[[
This is a list of methods that Core.lua will call for us periodically. The key is the name of the method, and the value is the approximate (and minimum) interval between method calls, in seconds. 
]]
me.myonupdates = 
{
	updatetalentvalues = 10.0, -- = "Call me.updatetalentvalues every 10 seconds pls"
	updateactionids = 1.0, 
}

me.spell = 
{
	-- Priest: Heal, Flash Heal, Greater Heal
	heal = 
	{
		class = "priest",
		icon = "Interface\\Icons\\Spell_Holy_Heal",
		[1] = 
		{
			level = 16,
			min = 295,
			max = 341,
			time = 3.0,
		},
		[2] = 
		{
			level = 22,
			min = 429,
			max = 491,
			time = 3.0,
		},			
		[3] = 
		{
			level = 28,
			min = 566,
			max = 642,
			time = 3.0,
		},
		[4] = 
		{
			level = 34,
			min = 712,
			max = 804,
			time = 3.0,
		},
	},
		
	flashheal = 
	{
		class = "priest",
		icon = "Interface\\Icons\\Spell_Holy_FlashHeal",
		[1] = 
		{
			level = 20,
			min = 193,
			max = 237,
			time = 1.5,
		},
		[2] = 
		{
			level = 26,
			min = 258,
			max = 314,
			time = 1.5,
		},
		[3] = 
		{
			level = 32,
			min = 327,
			max = 393,
			time = 1.5,
		},
		[4] = 
		{
			level = 38,
			min = 400,
			max = 478,
			time = 1.5,
		},
		[5] = 
		{
			level = 44,
			min = 518,
			max = 616,
			time = 1.5,
		},
		[6] = 
		{
			level = 50,
			min = 644,
			max = 764,
			time = 1.5,
		},
		[7] = 
		{
			level = 56,
			min = 812,
			max = 958,
			time = 1.5,
		},
	},
	greaterheal = 
	{
		class = "priest",
		icon = "Interface\\Icons\\Spell_Holy_GreaterHeal",
		[1] = 
		{
			level = 40,
			min = 899,
			max = 1013,
			time = 3.0,
		},
		[2] = 
		{
			level = 46,
			min = 1149,
			max = 1289,
			time = 3.0,
		},
		[3] = 
		{
			level = 52,
			min = 1437,
			max = 1609,
			time = 3.0,
		},
		[4] = 
		{
			level = 58,
			min = 1798,
			max = 2006,
			time = 3.0,
		},
		[5] = 
		{
			level = 60,
			min = 1966,
			max = 2194,
			time = 3.0,
		},
	},
	
	-- Druid: healing touch, regrowth
	healingtouch = 
	{
		class = "druid",
		icon = "Interface\\Icons\\Spell_Nature_HealingTouch",
		[1] = 
		{
			level = 0,
			min = 37,
			max = 51,
			time = 1.5,
		},
		[2] = 
		{
			level = 8,
			min = 88,
			max = 112,
			time = 2.0,
		},
		[3] = 
		{
			level = 14,
			min = 195,
			max = 243,
			time = 2.5,
		},
		[4] = 
		{
			level = 20,
			min = 363,
			max = 445,
			time = 3.0,
		},
		[5] = 
		{
			level = 26,
			min = 572,
			max = 694,
			time = 3.5,
		},
		[6] = 
		{
			level = 32,
			min = 742,
			max = 894,
			time = 3.5,
		},
		[7] = 
		{
			level = 38,
			min = 936,
			max = 1120,
			time = 3.5,
		},
		[8] = 
		{
			level = 44,
			min = 1199,
			max = 1427,
			time = 3.5,
		},
		[9] = 
		{
			level = 50,
			min = 1516,
			max = 1796,
			time = 3.5,
		},
		[10] = 
		{
			level = 56,
			min = 1890,
			max = 2230,
			time = 3.5,
		},
		[11] = 
		{
			level = 60,
			min = 2267,
			max = 2677,
			time = 3.5,
		},
	},
	
	regrowth = 
	{
		class = "druid",
		icon = "Interface\\Icons\\Spell_Nature_ResistNature",
		[1] = 
		{
			level = 12,
			min = 84,
			max = 98,
			time = 2.0,
		},
		[2] = 
		{
			level = 18,
			min = 168,
			max = 188,
			time = 2.0,
		},
		[3] = 
		{
			level = 24,
			min = 240,
			max = 274,
			time = 2.0,
		},
		[4] = 
		{
			level = 30,
			min = 318,
			max = 360,
			time = 2.0,
		},
		[5] = 
		{
			level = 36,
			min = 405,
			max = 457,
			time = 2.0,
		},
		[6] = 
		{
			level = 42,
			min = 511,
			max = 575,
			time = 2.0,
		},
		[7] = 
		{
			level = 48,
			min = 646,
			max = 724,
			time = 2.0,
		},
		[8] = 
		{
			level = 54,
			min = 809,
			max = 905,
			time = 2.0,
		},
		[9] = 
		{
			level = 60,
			min = 1003,
			max = 1119,
			time = 2.0,
		},
	},
	
	-- Paladin: flash of light, holy light
	holylight = 
	{
		class = "paladin",
		icon = "Interface\\Icons\\Spell_Holy_HolyBolt",
		[1] = 
		{
			level = 0,
			min = 39,
			max = 47,
			time = 2.5,
		},
		[2] = 
		{
			level = 6,
			min = 76,
			max = 90,
			time = 2.5,
		},
		[3] = 
		{
			level = 14,
			min = 159,
			max = 187,
			time = 2.5,
		},
		[4] = 
		{
			level = 22,
			min = 310,
			max = 356,
			time = 2.5,
		},
		[5] = 
		{
			level = 30,
			min = 491,
			max = 553,
			time = 2.5,
		},
		[6] = 
		{
			level = 38,
			min = 698,
			max = 780,
			time = 2.5,
		},
		[7] = 
		{
			level = 46,
			min = 945,
			max = 1053,
			time = 2.5,
		},
		[8] = 
		{
			level = 54,
			min = 1246,
			max = 1388,
			time = 2.5,
		},
		[9] = 
		{
			level = 60,
			min = 1590,
			max = 1770,
			time = 2.5,
		},
	},
	
	flashoflight = 
	{
		class = "paladin",
		icon = "Interface\\Icons\\Spell_Holy_FlashHeal",
		[1] = 
		{
			level = 20,
			min = 62,
			max = 72,
			time = 1.5,
		},
		[2] = 
		{
			level = 26,
			min = 96,
			max = 110,
			time = 1.5,
		},
		[3] = 
		{
			level = 34,
			min = 143,
			max = 163,
			time = 1.5,
		},
		[4] = 
		{
			level = 42,
			min = 197,
			max = 221,
			time = 1.5,
		},
		[5] = 
		{
			level = 50,
			min = 267,
			max = 299,
			time = 1.5,
		},
		[6] = 
		{
			level = 58,
			min = 343,
			max = 383,
			time = 1.5,
		},
	},
	
	-- Shaman: Lesser Healing Wave, Healing Wave
	healingwave = 
	{
		class = "shaman",
		icon = "Interface\\Icons\\Spell_Nature_HealingWaveGreater",
		[1] = 
		{
			level = 0,
			min = 33,
			max = 44,
			time = 1.5,
		},
		[2] = 
		{
			level = 6,
			min = 64,
			max = 78,
			time = 2.0,
		},
		[3] = 
		{
			level = 14,
			min = 129,
			max = 155,
			time = 2.5,
		},
		[4] = 
		{
			level = 22,
			min = 268,
			max = 316,
			time = 3.0,
		},
		[5] = 
		{
			level = 30,
			min = 376,
			max = 440,
			time = 3.0,
		},
		[6] = 
		{
			level = 38,
			min = 536,
			max = 622,
			time = 3.0,
		},
		[7] = 
		{
			level = 46,
			min = 740,
			max = 854,
			time = 3.0,
		},
		[8] = 
		{
			level = 54,
			min = 1017,
			max = 1167,
			time = 3.0,
		},
		[9] = 
		{
			level = 60,
			min = 1367,
			max = 1561,
			time = 3.0,
		},
	},
	
	lesserhealingwave = 
	{
		class = "shaman",
		icon = "Interface\\Icons\\Spell_Nature_HealingWaveLesser",
		[1] = 
		{
			level = 20,
			min = 162,
			max = 186,
			time = 1.5,
		},
		[2] = 
		{
			level = 26,
			min = 247,
			max = 281,
			time = 1.5,
		},
		[3] = 
		{
			level = 34,
			min = 337,
			max = 381,
			time = 1.5,
		},
		[4] = 
		{
			level = 42,
			min = 458,
			max = 514,
			time = 1.5,
		},
		[5] = 
		{
			level = 50,
			min = 631,
			max = 705,
			time = 1.5,
		},
		[6] = 
		{
			level = 58,
			min = 832,
			max = 928,
			time = 1.5,
		},
	}
	
}

me.getmaxspellrank = function(spellid)

	return table.getn(me.spell[spellid])

end

me.talent = 
{
	priest = 
	{
		holyspec = 
		{
			tree = 2,
			index = 3,
			ranks = 5,
			start = 1,
			step = 1,
		},
		divinefury = 
		{
			tree = 2,
			index = 5,
			ranks = 5,
			start = -0.1,
			step = -0.1,
		},
		spiritualguidance = 
		{
			tree = 2,
			index = 14,
			ranks = 5,
			start = 0.05,
			step = 0.05,
		},
		spiritualhealing = 
		{
			tree = 2,
			index = 15,
			ranks = 5,
			start = 0.02,
			step = 0.02,
		}
	},
	druid = 
	{
		healingtouch = 
		{
			tree = 3,
			index = 3,
			ranks = 5,
			start = -0.1,
			step = -0.1,
		},
		giftofnature = 
		{
			tree = 3,
			index = 12,
			ranks = 5,
			start = 0.02,
			step = 0.02,
		},	
		regrowth = 
		{
			tree = 3,
			index = 14,
			ranks = 5,
			start = 0.1,
			step = 0.1,
		},
	},
	paladin = 
	{
		holylight = 
		{
			tree = 1,
			index = 5,
			ranks = 3,
			start = 0.04,
			step = 0.04,
		},
		holypower = 
		{
			tree = 1,
			index = 13,
			ranks = 5,
			start = 1,
			step = 1,
		},
	},
	shaman = 
	{
		healingwave = 
		{
			tree = 3,
			index = 1,
			ranks = 5,
			start = -0.1,
			step = -0.1,
		},
		tidalmastery = 
		{
			tree = 3,
			index = 11,
			ranks = 5,
			start = 1,
			step = 1,
		},
		purification = 
		{
			tree = 3,
			index = 14,
			ranks = 5,
			start = 0.02,
			step = 0.02,
		},
	}
}

me.talentvalues = { }

--[[
This a special update method. It's called periodically by Core.lua. See <me.onupdates> above.

]]
me.updatetalentvalues = function()
	
	-- get my class
	local _, class = UnitClass("player")
	class = string.lower(class)
	
	-- get talent data for my class
	local classdata = me.talent[class]
	if classdata == nil then return end
	
	-- loop through all talents
	local name, data, value, talentdata, rank
	for name, data in classdata do
		
		-- get current rank
		talentdata = me.talent[class][name]
		_, _, _, _, rank = GetTalentInfo(talentdata.tree, talentdata.index)
	
		-- get current value
		if rank == 0 then
			value =  0
		else
			value = talentdata.start + (rank - 1) * talentdata.step
		end
		
		-- save value
		me.talentvalues[name] = value
	end
	
end

--[[
mod.data.gettalentvalue(class, talent)
Gives the effect your character has for a talent. 

<talent>		string; a key in <me.talents[<class>]>

Return: 		number; the actual benefit the talent gives, not just the rank you have.
]]
me.gettalentvalue = function(talent)

 	if me.talentvalues[talent] == nil then
		if mod.trace.check("error", me, "talent") then
			mod.trace.print(string.format(mod.string.get("trace", me.name, "badtalentname")), tostring(talent))
		end
		
		return 0
	end
	
	return me.talentvalues[talent]
	
end

--[[
mod.data.updateactionids()
Finds the location of class spells on your action bar
]]
me.updateactionids = function()
	
	for spellname, spelldata in me.spell do
		if spelldata.class == mod.my.class then
			
			-- check if the current action works
			if spelldata.actionid and me.actionmatchesspell(spellname, spelldata.actionid) then
				-- current action is ok
				
			else
				spelldata.actionid = 0
				
				-- can't find it! search
				for x = 1, 120 do
					if me.actionmatchesspell(spellname, x) then
						spelldata.actionid = x
						break
					end
				end
			end
		end
	end
	
end

--[[
me.actionmatchesspell(spellid, actionid)
Checks whether the action at <actionid> is the spell <spellid>. We assume they match if the action has the same texture, has no text (as a macro would) and has no action count (as a stack of potions or other consumables would).

<spellid>	string; an internal spell name, e.g. "greaterheal".
<actionid>	integer; index of an action button. From 1 to 120 odd.

Return: 	true or nil.
]]
me.actionmatchesspell = function(spellid, actionid)
	
	local texture = me.spell[spellid].icon
	
	if (GetActionTexture(actionid) == texture) and (GetActionText(actionid) == nil) and (GetActionCount(actionid) == 0) then
		return true
	end
	
end

-- searches your action bars for ANY healing spell
me.findanyspellaction = function()
	
	for spellname, spelldata in me.spell do
		if spelldata.class == mod.my.class then
			
			-- check if the current action works
			if spelldata.actionid and me.actionmatchesspell(spellname, spelldata.actionid) then
				return spelldata.actionid
			end
		end
	end
end