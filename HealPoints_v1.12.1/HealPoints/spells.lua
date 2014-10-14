
HealPointsSpells = {
  SPELLTABLE = { };
};

function HealPointsSpells:init()
	local _, className = UnitClass("player");
	if (className == "PALADIN") then
    self.SPELLTABLE[1] = {	
                { name = HPC_SPELL_FOL, type = 'normal', rank = 1, abbr = "FoL", avg = 67, time = 1.5, mana = 35, level = 20, bolfactor = 1},
                { name = HPC_SPELL_FOL, type = 'normal', rank = 2, abbr = "FoL", avg = 103, time = 1.5, mana = 50, level = 26, bolfactor = 1},
                { name = HPC_SPELL_FOL, type = 'normal', rank = 3, abbr = "FoL", avg = 154, time = 1.5, mana = 70, level = 34, bolfactor = 1},
                { name = HPC_SPELL_FOL, type = 'normal', rank = 4, abbr = "FoL", avg = 209, time = 1.5, mana = 90, level = 42, bolfactor = 1},
                { name = HPC_SPELL_FOL, type = 'normal', rank = 5, abbr = "FoL", avg = 283, time = 1.5, mana = 115, level = 50, bolfactor = 1},
                { name = HPC_SPELL_FOL, type = 'normal', rank = 6, abbr = "FoL", avg = 363, time = 1.5, mana = 140, level = 58, bolfactor = 1}};
    self.SPELLTABLE[2] = {	
                { name = HPC_SPELL_HL, type = 'normal', rank = 1, abbr = "HL", avg = 43, time = 2.5, mana = 35, level = 1, bolfactor = 0.2},
                { name = HPC_SPELL_HL, type = 'normal', rank = 2, abbr = "HL", avg = 83, time = 2.5, mana = 60, level = 6, bolfactor = 0.4},
                { name = HPC_SPELL_HL, type = 'normal', rank = 3, abbr = "HL", avg = 173, time = 2.5, mana = 110, level = 14, bolfactor = 0.7},
                { name = HPC_SPELL_HL, type = 'normal', rank = 4, abbr = "HL", avg = 333, time = 2.5, mana = 190, level = 22, bolfactor = 1},
                { name = HPC_SPELL_HL, type = 'normal', rank = 5, abbr = "HL", avg = 522, time = 2.5, mana = 275, level = 30, bolfactor = 1},
                { name = HPC_SPELL_HL, type = 'normal', rank = 6, abbr = "HL", avg = 739, time = 2.5, mana = 365, level = 38, bolfactor = 1},
                { name = HPC_SPELL_HL, type = 'normal', rank = 7, abbr = "HL", avg = 999, time = 2.5, mana = 465, level = 46, bolfactor = 1},
                { name = HPC_SPELL_HL, type = 'normal', rank = 8, abbr = "HL", avg = 1317, time = 2.5, mana = 580, level = 54, bolfactor = 1},
                { name = HPC_SPELL_HL, type = 'normal', rank = 9, abbr = "HL", avg = 1680, time = 2.5, mana = 660, level = 60, bolfactor = 1}};
    self.SPELLTABLE[3] = { 
                { name = HPC_SPELL_HS, type = 'instant', rank = 1, abbr = "HS", avg = 212, time = 30, mana = 220, level = 40},
                { name = HPC_SPELL_HS, type = 'instant', rank = 2, abbr = "HS", avg = 290, time = 30, mana = 275, level = 48},
                { name = HPC_SPELL_HS, type = 'instant', rank = 3, abbr = "HS", avg = 370, time = 30, mana = 325, level = 56}};
                
	elseif (className == "PRIEST") then
    self.SPELLTABLE[1] = {	
                { name = HPC_SPELL_FH, type = 'normal', rank = 1, abbr = "FH", avg = 215, time = 1.5, mana = 125, level = 20},
                { name = HPC_SPELL_FH, type = 'normal', rank = 2, abbr = "FH", avg = 286, time = 1.5, mana = 155, level = 26},
                { name = HPC_SPELL_FH, type = 'normal', rank = 3, abbr = "FH", avg = 360, time = 1.5, mana = 185, level = 32},
                { name = HPC_SPELL_FH, type = 'normal', rank = 4, abbr = "FH", avg = 439, time = 1.5, mana = 215, level = 38},
                { name = HPC_SPELL_FH, type = 'normal', rank = 5, abbr = "FH", avg = 567, time = 1.5, mana = 265, level = 44},
                { name = HPC_SPELL_FH, type = 'normal', rank = 6, abbr = "FH", avg = 704, time = 1.5, mana = 315, level = 50},
                { name = HPC_SPELL_FH, type = 'normal', rank = 7, abbr = "FH", avg = 885, time = 1.5, mana = 380, level = 56}};
    self.SPELLTABLE[2] = {	
                { name = HPC_SPELL_LH, type = 'normal', rank = 1, abbr = "LH", avg = 53, time = 1.5, mana = 30, level = 1},
                { name = HPC_SPELL_LH, type = 'normal', rank = 2, abbr = "LH", avg = 84, time = 2.0, mana = 45, level = 4},
                { name = HPC_SPELL_LH, type = 'normal', rank = 3, abbr = "LH", avg = 154, time = 2.5, mana = 75, level = 10},
                { name = HPC_SPELL_HEAL, type = 'normal', rank = 1, abbr = "Heal", avg = 330, time = 3.0, mana = 155, level = 16},
                { name = HPC_SPELL_HEAL, type = 'normal', rank = 2, abbr = "Heal", avg = 476, time = 3.0, mana = 205, level = 22},
                { name = HPC_SPELL_HEAL, type = 'normal', rank = 3, abbr = "Heal", avg = 624, time = 3.0, mana = 255, level = 28},
                { name = HPC_SPELL_HEAL, type = 'normal', rank = 4, abbr = "Heal", avg = 781, time = 3.0, mana = 305, level = 34},
                { name = HPC_SPELL_GH, type = 'normal', rank = 1, abbr = "GH", avg = 967, time = 3.0, mana = 370, level = 40},
                { name = HPC_SPELL_GH, type = 'normal', rank = 2, abbr = "GH", avg = 1248, time = 3.0, mana = 455, level = 46},
                { name = HPC_SPELL_GH, type = 'normal', rank = 3, abbr = "GH", avg = 1556, time = 3.0, mana = 545, level = 52},
                { name = HPC_SPELL_GH, type = 'normal', rank = 4, abbr = "GH", avg = 1917, time = 3.0, mana = 655, level = 58},
                { name = HPC_SPELL_GH, type = 'normal', rank = 5, abbr = "GH", avg = 2080, time = 3.0, mana = 710, level = 60}};
    self.SPELLTABLE[3] = {	
                { name = HPC_SPELL_RENEW, type = 'hot', rank = 1, abbr = "Renew", avg = 45, time = 15, mana = 30, level = 8},
                { name = HPC_SPELL_RENEW, type = 'hot', rank = 2, abbr = "Renew", avg = 100, time = 15, mana = 65, level = 14},
                { name = HPC_SPELL_RENEW, type = 'hot', rank = 3, abbr = "Renew", avg = 175, time = 15, mana = 105, level = 20},
                { name = HPC_SPELL_RENEW, type = 'hot', rank = 4, abbr = "Renew", avg = 245, time = 15, mana = 140, level = 26},
                { name = HPC_SPELL_RENEW, type = 'hot', rank = 5, abbr = "Renew", avg = 315, time = 15, mana = 170, level = 32},
                { name = HPC_SPELL_RENEW, type = 'hot', rank = 6, abbr = "Renew", avg = 400, time = 15, mana = 205, level = 38},
                { name = HPC_SPELL_RENEW, type = 'hot', rank = 7, abbr = "Renew", avg = 510, time = 15, mana = 250, level = 44},
                { name = HPC_SPELL_RENEW, type = 'hot', rank = 8, abbr = "Renew", avg = 650, time = 15, mana = 305, level = 50},
                { name = HPC_SPELL_RENEW, type = 'hot', rank = 9, abbr = "Renew", avg = 810, time = 15, mana = 365, level = 56},
                { name = HPC_SPELL_RENEW, type = 'hot', rank = 10, abbr = "Renew", avg = 970, time = 15, mana = 410, level = 60}};

  elseif (className == "DRUID") then
    self.SPELLTABLE[1] = {	
                { name = HPC_SPELL_REGR, type = 'regrowth', rank = 1, abbr = "Regr", avg = 100, time = 2, mana = 120, hotavg = 98, hottime = 21, level = 12},
                { name = HPC_SPELL_REGR, type = 'regrowth', rank = 2, abbr = "Regr", avg = 176, time = 2, mana = 205, hotavg = 175, hottime = 21, level = 18},
                { name = HPC_SPELL_REGR, type = 'regrowth', rank = 3, abbr = "Regr", avg = 257, time = 2, mana = 280, hotavg = 259, hottime = 21, level = 24},
                { name = HPC_SPELL_REGR, type = 'regrowth', rank = 4, abbr = "Regr", avg = 339, time = 2, mana = 350, hotavg = 343, hottime = 21, level = 30},
                { name = HPC_SPELL_REGR, type = 'regrowth', rank = 5, abbr = "Regr", avg = 431, time = 2, mana = 420, hotavg = 427, hottime = 21, level = 36},
                { name = HPC_SPELL_REGR, type = 'regrowth', rank = 6, abbr = "Regr", avg = 543, time = 2, mana = 510, hotavg = 546, hottime = 21, level = 42},
                { name = HPC_SPELL_REGR, type = 'regrowth', rank = 7, abbr = "Regr", avg = 685, time = 2, mana = 615, hotavg = 686, hottime = 21, level = 48},
                { name = HPC_SPELL_REGR, type = 'regrowth', rank = 8, abbr = "Regr", avg = 857, time = 2, mana = 740, hotavg = 861, hottime = 21, level = 54},
                { name = HPC_SPELL_REGR, type = 'regrowth', rank = 9, abbr = "Regr", avg = 1061, time = 2, mana = 880, hotavg = 1064, hottime = 21, level = 60}};
    self.SPELLTABLE[2] = { 	
                { name = HPC_SPELL_HT, type = 'normal', rank = 1, abbr = "HT", avg = 44, time = 1.5, mana = 25, level = 1},
                { name = HPC_SPELL_HT, type = 'normal', rank = 2, abbr = "HT", avg = 100, time = 2.0, mana = 55, level = 8},
                { name = HPC_SPELL_HT, type = 'normal', rank = 3, abbr = "HT", avg = 219, time = 2.5, mana = 110, level = 14},
                { name = HPC_SPELL_HT, type = 'normal', rank = 4, abbr = "HT", avg = 404, time = 3.0, mana = 185, level = 20},
                { name = HPC_SPELL_HT, type = 'normal', rank = 5, abbr = "HT", avg = 633, time = 3.5, mana = 270, level = 26},
                { name = HPC_SPELL_HT, type = 'normal', rank = 6, abbr = "HT", avg = 818, time = 3.5, mana = 335, level = 32},
                { name = HPC_SPELL_HT, type = 'normal', rank = 7, abbr = "HT", avg = 1028, time = 3.5, mana = 405, level = 38},
                { name = HPC_SPELL_HT, type = 'normal', rank = 8, abbr = "HT", avg = 1313, time = 3.5, mana = 495, level = 44},
                { name = HPC_SPELL_HT, type = 'normal', rank = 9, abbr = "HT", avg = 1656, time = 3.5, mana = 600, level = 50},
                { name = HPC_SPELL_HT, type = 'normal', rank = 10, abbr = "HT", avg = 2060, time = 3.5, mana = 720, level = 56},
                { name = HPC_SPELL_HT, type = 'normal', rank = 11, abbr = "HT", avg = 2472, time = 3.5, mana = 800, level = 60}};
    self.SPELLTABLE[3] = {		
                { name = HPC_SPELL_REJUV, type = 'hot', rank = 1, abbr = "Rejuv", avg = 32, time = 12, mana = 25, level = 4},
                { name = HPC_SPELL_REJUV, type = 'hot', rank = 2, abbr = "Rejuv", avg = 56, time = 12, mana = 40, level = 10},
                { name = HPC_SPELL_REJUV, type = 'hot', rank = 3, abbr = "Rejuv", avg = 116, time = 12, mana = 75, level = 16},
                { name = HPC_SPELL_REJUV, type = 'hot', rank = 4, abbr = "Rejuv", avg = 180, time = 12, mana = 105, level = 22},
                { name = HPC_SPELL_REJUV, type = 'hot', rank = 5, abbr = "Rejuv", avg = 244, time = 12, mana = 135, level = 28},
                { name = HPC_SPELL_REJUV, type = 'hot', rank = 6, abbr = "Rejuv", avg = 304, time = 12, mana = 160, level = 34},
                { name = HPC_SPELL_REJUV, type = 'hot', rank = 7, abbr = "Rejuv", avg = 388, time = 12, mana = 195, level = 40},
                { name = HPC_SPELL_REJUV, type = 'hot', rank = 8, abbr = "Rejuv", avg = 488, time = 12, mana = 235, level = 46},
                { name = HPC_SPELL_REJUV, type = 'hot', rank = 9, abbr = "Rejuv", avg = 608, time = 12, mana = 280, level = 52},
                { name = HPC_SPELL_REJUV, type = 'hot', rank = 10, abbr = "Rejuv", avg = 756, time = 12, mana = 335, level = 58},
                { name = HPC_SPELL_REJUV, type = 'hot', rank = 11, abbr = "Rejuv", avg = 888, time = 12, mana = 360, level = 60}};

  elseif (className == "SHAMAN") then
    self.SPELLTABLE[1] = {	
                { name = HPC_SPELL_LHW, type = 'normal', rank = 1, abbr = "LHW", avg = 174, time = 1.5, mana = 105, level = 20},
                { name = HPC_SPELL_LHW, type = 'normal', rank = 2, abbr = "LHW", avg = 264, time = 1.5, mana = 145, level = 28},
                { name = HPC_SPELL_LHW, type = 'normal', rank = 3, abbr = "LHW", avg = 359, time = 1.5, mana = 185, level = 36},
                { name = HPC_SPELL_LHW, type = 'normal', rank = 4, abbr = "LHW", avg = 486, time = 1.5, mana = 235, level = 44},
                { name = HPC_SPELL_LHW, type = 'normal', rank = 5, abbr = "LHW", avg = 668, time = 1.5, mana = 305, level = 52},
                { name = HPC_SPELL_LHW, type = 'normal', rank = 6, abbr = "LHW", avg = 880, time = 1.5, mana = 380, level = 60}};
    self.SPELLTABLE[2] = {	
                { name = HPC_SPELL_HW, type = 'normal', rank = 1, abbr = "HW", avg = 39, time = 1.5, mana = 25, level = 1},
                { name = HPC_SPELL_HW, type = 'normal', rank = 2, abbr = "HW", avg = 71, time = 2.0, mana = 45, level = 6},
                { name = HPC_SPELL_HW, type = 'normal', rank = 3, abbr = "HW", avg = 142, time = 2.5, mana = 80, level = 12},
                { name = HPC_SPELL_HW, type = 'normal', rank = 4, abbr = "HW", avg = 292, time = 3.0, mana = 155, level = 18},
                { name = HPC_SPELL_HW, type = 'normal', rank = 5, abbr = "HW", avg = 408, time = 3.0, mana = 200, level = 24},
                { name = HPC_SPELL_HW, type = 'normal', rank = 6, abbr = "HW", avg = 579, time = 3.0, mana = 265, level = 32},
                { name = HPC_SPELL_HW, type = 'normal', rank = 7, abbr = "HW", avg = 797, time = 3.0, mana = 340, level = 40},
                { name = HPC_SPELL_HW, type = 'normal', rank = 8, abbr = "HW", avg = 1092, time = 3.0, mana = 440, level = 48},
                { name = HPC_SPELL_HW, type = 'normal', rank = 9, abbr = "HW", avg = 1464, time = 3.0, mana = 560, level = 56},
                { name = HPC_SPELL_HW, type = 'normal', rank = 10, abbr = "HW", avg = 1735, time = 3.0, mana = 620, level = 60}};
    self.SPELLTABLE[3] = {  
                { name = HPC_SPELL_CHAIN, type = 'chain', rank = 1, abbr = "CH", avg = 344, time = 2.5, mana = 260, level = 40},
                { name = HPC_SPELL_CHAIN, type = 'chain', rank = 2, abbr = "CH", avg = 435, time = 2.5, mana = 315, level = 46},
                { name = HPC_SPELL_CHAIN, type = 'chain', rank = 3, abbr = "CH", avg = 590, time = 2.5, mana = 405, level = 54}};
	end
end

function HealPointsSpells:getSpell(spellName, rank)
	for t = 1, 3, 1 do
		for i = 1, table.getn(self.SPELLTABLE[t]), 1 do
			if (self.SPELLTABLE[t][i]['name'] == spellName and self.SPELLTABLE[t][i]['rank'] == rank) then
				return self.SPELLTABLE[t][i];
			end
		end
	end
end

function HealPointsSpells:updateSpellTalents(spell)	
	local function clone(t)            -- return a copy of the table t
		local new = {}             -- create a new table
		local i, v = next(t, nil)  -- i is an index of t, v = t[i]
		while i do
			new[i] = v
			i, v = next(t, i)        -- get next index
		end
		new['orgtime'] = t['time']; -- copy the time-stat
		return new
	end

	local function updateSpellPercent(spell, aspect, percentIncrease)
		spell[aspect] = spell[aspect] * (1 + percentIncrease);
	end
	
	local function updateSpellAbsolute(spell, aspect, increase)
		spell[aspect] = spell[aspect] + increase;
	end
	
	if (spell == nil) then
		return;
	end
	
	spell = clone(spell);
	local _, className = UnitClass("player");
	
	if (className == "PALADIN") then
		-- talents for paladins
		if (spell['name'] == HPC_SPELL_FOL or spell['name'] == HPC_SPELL_HL) then
			local healingLight = HealPointsUtil:getTalentRank(HPC_TALENT_HEALIG);		-- Increases avg for both spells by 4% per rank
			updateSpellPercent(spell, 'avg', healingLight * 0.04);
		end
		
		-- special set bonuses
		if (HealPointsBS:GetBonus('CASTINGHOLYLIGHT') > 0 and spell['name'] == HPC_SPELL_HL) then
			updateSpellAbsolute(spell, 'time', - HealPointsBS:GetBonus('CASTINGHOLYLIGHT') / 10);
		end

	elseif (className == "PRIEST") then
		-- talents for priests
		local spiritualHealing = HealPointsUtil:getTalentRank(HPC_TALENT_SPIHEA);-- Increased avg for all spells by 2% per rank
		
		if (spell['name'] == HPC_SPELL_RENEW) then
			local improvedRenew = HealPointsUtil:getTalentRank(HPC_TALENT_IMPREN);		-- Increased avg for Renew by 5% per rank
			updateSpellPercent(spell, 'avg', improvedRenew * 0.05 + spiritualHealing * 0.02);
		else
			updateSpellPercent(spell, 'avg', spiritualHealing * 0.02);		
		end

		if (spell['name'] == HPC_SPELL_RENEW) then
			local mentalAgility = HealPointsUtil:getTalentRank(HPC_TALENT_MENAGI);		-- Reduced mana cost for Renew by 2% per rank
			updateSpellPercent(spell, 'mana', - mentalAgility * 0.02);
		end
		
		if (spell['name'] == HPC_SPELL_LH or spell['name'] == HPC_SPELL_HEAL or spell['name'] == HPC_SPELL_GH) then
			local improvedHealing = HealPointsUtil:getTalentRank(HPC_TALENT_IMPHEA);  -- Reduced mana cost for slow heal by 5% per rank
			updateSpellPercent(spell, 'mana', - improvedHealing * 0.05);
		end
		
		if (spell['name'] == HPC_SPELL_HEAL or spell['name'] == HPC_SPELL_GH) then
			local divineFury = HealPointsUtil:getTalentRank(HPC_TALENT_DIVFUR);	   -- Reduced time for Heal/Greater Heal by 0.1 per rank
			updateSpellAbsolute(spell, 'time', - divineFury * 0.1);
		end
		
		-- special set bonuses
		if (HealPointsBS:GetBonus('CASTINGFLASHHEAL') > 0 and spell['name'] == HPC_SPELL_FH) then
			updateSpellAbsolute(spell, 'time', - HealPointsBS:GetBonus('CASTINGFLASHHEAL') / 10);
		end

		if (HealPointsBS:GetBonus('DURATIONRENEW') > 0 and spell['name'] == HPC_SPELL_RENEW) then
			updateSpellAbsolute(spell, 'time', HealPointsBS:GetBonus('DURATIONRENEW'));
			updateSpellPercent(spell, 'avg', HealPointsBS:GetBonus('DURATIONRENEW') / 15); -- From 5 tics to 6 tics => 20 % increase
		end
		
		if (HealPointsBS:GetBonus('CHEAPERRENEW') > 0 and spell['name'] == HPC_SPELL_RENEW) then
			updateSpellPercent(spell, 'mana', - HealPointsBS:GetBonus('CHEAPERRENEW') / 100);
		end
		
	elseif (className == "DRUID") then
		-- talents for druids
		local moonglow = HealPointsUtil:getTalentRank(HPC_TALENT_MOONGL);					-- Reduced mana cost for all spells by 3% per rank
		
		if (spell['name'] == HPC_SPELL_HT) then
			local tranquilSpirit = HealPointsUtil:getTalentRank(HPC_TALENT_TRASPI)			-- Reduced mana cost for Healing Touch by 2% per rank
			updateSpellPercent(spell, 'mana', - (tranquilSpirit * 0.02 + moonglow * 0.03));
		else
			updateSpellPercent(spell, 'mana', - moonglow * 0.03);
		end
		
		local giftOfNature = HealPointsUtil:getTalentRank(HPC_TALENT_GIOFNA)				-- Increased avg for all spells by 2% per rank
		if (spell['name'] == HPC_SPELL_REGR) then
			updateSpellPercent(spell, 'hotavg', giftOfNature * 0.02);
		end

		if (spell['name'] == HPC_SPELL_REJUV) then
			local improvedRejuv = HealPointsUtil:getTalentRank(HPC_TALENT_IMPREJ)			-- Increased avg for Rejuvenation by 5% per rank
			updateSpellPercent(spell, 'avg', improvedRejuv * 0.05 + giftOfNature * 0.02);
		else
			updateSpellPercent(spell, 'avg', giftOfNature * 0.02);
		end
		
		if (spell['name'] == HPC_SPELL_HT) then
			local improvedHT = HealPointsUtil:getTalentRank(HPC_TALENT_IMPRHT)				-- Reduced time for Healing Touch by 0.1 per rank
			updateSpellAbsolute(spell, 'time', - improvedHT * 0.1);
		end
		
		-- special set bonuses
		if (HealPointsBS:GetBonus('CASTINGREGROWTH') > 0 and spell['name'] == HPC_SPELL_REGR) then
			updateSpellAbsolute(spell, 'time', - HealPointsBS:GetBonus('CASTINGREGROWTH') / 10);
		end

		if (HealPointsBS:GetBonus('CASTINGHEALINGTOUCH') > 0 and spell['name'] == HPC_SPELL_HT) then
		  updateSpellAbsolute(spell, 'time', - HealPointsBS:GetBonus('CASTINGHEALINGTOUCH') / 100); -- find a more reliable way
		end

		if (HealPointsBS:GetBonus('DURATIONREJUV') > 0 and spell['name'] == HPC_SPELL_REJUV) then
			updateSpellAbsolute(spell, 'time', HealPointsBS:GetBonus('DURATIONREJUV'));
			updateSpellPercent(spell, 'avg', HealPointsBS:GetBonus('DURATIONREJUV') / 12); -- From 4 tics to 5 tics => 25 % increase
		end

		if (HealPointsBS:GetBonus('CHEAPERDRUID') > 0) then
			updateSpellPercent(spell, 'mana', - HealPointsBS:GetBonus('CHEAPERDRUID') / 100);
		end
		
	elseif (className == "SHAMAN") then
		-- talents for shaman
		if (spell['name'] == HPC_SPELL_HW) then
			local improvedHealingWave = HealPointsUtil:getTalentRank(HPC_TALENT_IMHEWA)		-- Reduced time for Healing Wave by 0.1 per rank
			updateSpellAbsolute(spell, 'time', - improvedHealingWave * 0.1);
		end
		
		local tidalFocus = HealPointsUtil:getTalentRank(HPC_TALENT_TIDFOC)						-- Reduced mana cost for all spells by 1% per rank
		updateSpellPercent(spell, 'mana', - tidalFocus * 0.01);
		
		local purification = HealPointsUtil:getTalentRank(HPC_TALENT_PURIFI)					-- Increased avg for all spells by 2% per rank
		updateSpellPercent(spell, 'avg', purification * 0.02);

		-- special set bonuses
		if (HealPointsBS:GetBonus('CASTINGCHAINHEAL') > 0 and spell['name'] == HPC_SPELL_CHAIN) then
			updateSpellAbsolute(spell, 'time', - HealPointsBS:GetBonus('CASTINGCHAINHEAL') / 10);
		end
	end
	return spell;
end

function HealPointsSpells:getHighestSpellRank(spellName)
	local totalSpellTabs = GetNumSpellTabs();
	local totalSpells = 0;
	for t = 1, totalSpellTabs do
		local _, _, _, numSpells = GetSpellTabInfo(t);
		totalSpells = totalSpells + numSpells;
	end

	local highestRank = 0;
	for t = 1, totalSpells do
		local nameSpell, rankSpell = GetSpellName(t, BOOKTYPE_SPELL);
		if (nameSpell == spellName) then
			local j, k = string.find(rankSpell, HPC_DIV_RANK.." ");
			if (j ~= nil) then
				highestRank = math.max(highestRank, string.sub(rankSpell, k));
			end
		end
	end
	return highestRank;
end

function HealPointsSpells:getHighestKnownSpell(spellTable)
  if (spellTable ~= nil) then
    for i = table.getn(spellTable), 1, -1 do
      if (HealPointsSpells:getHighestSpellRank(spellTable[i]['name']) == spellTable[i]['rank']) then
        return spellTable[i];
      end
    end
  end
  return nil;
end

