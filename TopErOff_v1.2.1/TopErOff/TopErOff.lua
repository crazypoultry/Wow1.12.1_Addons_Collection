BINDING_HEADER_TEOHEADER = "Top Er Off Bindings";
function TEO_Initialize()
	local  teo_ver = "1.2";
	local TEO_Class = UnitClass("player");

	DEFAULT_CHAT_FRAME:AddMessage("You're a " .. TEO_Class .. "!  Top Er Off " .. teo_ver .. " Loaded");
	SlashCmdList["TOPEROFF"] = toperoff_command;
	SLASH_TOPEROFF1 = "/toperoff";
	SLASH_TOPEROFF2 = "/teo";
end

function toperoff_BonusScanner()
	if (IsAddOnLoaded("BonusScanner")) then
		local TEO_Bonus = BonusScanner:GetBonus("HEAL");
		if UnitClass("player") == "Priest" then
			local nameTalent, icon, iconx, icony, currRank, maxRank = GetTalentInfo(2,14);
			if currRank > 0 then
				local TEO_GuidanceMultiplier = .05 * currRank;
				local base, stat, posBuff, negBuff = UnitStat("Player", 5);
				local TEO_GuidanceBonus = (stat * TEO_GuidanceMultiplier);
				TEO_GuidanceBonus = math.floor(TEO_GuidanceBonus);
				TEO_Bonus = TEO_Bonus + TEO_GuidanceBonus;
				return TEO_Bonus;
			else
				return TEO_Bonus;
			end
		else
			return TEO_Bonus;
		end
	else
		return -1;
	end
end

function toperoff_command(normorfast)
	local TEO_Class = UnitClass("player");
	local TEO_USABLECLASS = 0;
	if TEO_Class == "Priest" then
		TEO_USABLECLASS = 1;
	end
	if TEO_Class == "Shaman" then
		TEO_USABLECLASS = 1;
	end
	if TEO_Class == "Druid" then
		TEO_USABLECLASS = 1;
	end
	if TEO_Class == "Paladin" then
		TEO_USABLECLASS = 1;
	end 
	if TEO_USABLECLASS == 0 then
		return;
	end
	local TEO_Bonus = toperoff_BonusScanner();
	if normorfast == "bonus" and TEO_Bonus > -1 then
		DEFAULT_CHAT_FRAME:AddMessage("You currently have +" .. TEO_Bonus .. " to healing");
		return;
	elseif normorfast == "bonus" then
		DEFAULT_CHAT_FRAME:AddMessage("You do not have BonusScanner installed");
		return;
	end
	local CT, ValidTarget = TEO_ValidTarget();
	local spell, normorfast = TEO_SpellToCast(normorfast);
		if spell == nil then
			DEFAULT_CHAT_FRAME:AddMessage(CT .. " is at near/max HP.  No spell cast.");
			return;
		end
		local spellName = "Error";
		local spellRank = "Error";
		if UnitClass("player") == "Priest" then
			if normorfast == "heal" or normorfast == "healover" then
				if spell == 1 or spell == 2 or spell == 3 then
					spellName = "Lesser Heal";
				elseif spell == 4 or spell == 5 or spell == 6 or spell == 7 then
					spellName = "Heal";
				elseif spell == 8 or spell == 9 or spell == 10 or spell == 11 or spell == 12 then
					spellName = "Greater Heal";
				end
				if spell == 1 or spell == 4 or spell == 8 then
					spellRank = "(Rank 1)";
				elseif spell == 2 or spell == 5 or spell == 9 then
					spellRank = "(Rank 2)";
				elseif spell == 3 or spell == 6 or spell == 10 then
					spellRank = "(Rank 3)";
				elseif spell == 7 or spell == 11 then
					spellRank = "(Rank 4)";
				elseif spell == 12 then
					spellRank = "(Rank 5)";
				end
			elseif normorfast == "fast" or normorfast == "fastover" then
				spellName = "Flash Heal";
		 		if spell == 1 then
					spellRank = "(Rank 1)";
				elseif spell == 2 then
					spellRank = "(Rank 2)";
				elseif spell == 3 then
					spellRank = "(Rank 3)";
				elseif spell == 4 then
					spellRank = "(Rank 4)";
				elseif spell == 5 then
					spellRank = "(Rank 5)";
				elseif spell == 6 then
					spellRank = "(Rank 6)";
				elseif spell == 7 then
					spellRank = "(Rank 7)";
				elseif spell == 8 then
					spellRank = "(Rank 8)";
				elseif spell == 9 then
					spellRank = "(Rank 9)";
				end
			end
			local spellNameRank = tostring(spellName .. spellRank);
			DEFAULT_CHAT_FRAME:AddMessage("Casting " .. spellNameRank .. " on " .. CT .. ".");
			if (UnitIsFriend("player", "target")) == 1 and UnitPlayerOrPetInParty("target") == nil and UnitPlayerOrPetInRaid("target") == nil then
				TargetUnit("player");
				CastSpellByName(spellNameRank);
			else
				CastSpellByName(spellNameRank);
				if (SpellIsTargeting()) then
  					SpellTargetUnit("player")
				end
			end
		elseif UnitClass("player") == "Shaman" then
			if normorfast == "heal" or normorfast == "healover" then
					spellName = "Healing Wave";
				if spell == 1 then
					spellRank = "(Rank 1)";
				elseif spell == 2 then
					spellRank = "(Rank 2)";
				elseif spell == 3 then
					spellRank = "(Rank 3)";
				elseif spell == 4 then
					spellRank = "(Rank 4)";
				elseif spell == 5 then
					spellRank = "(Rank 5)";
				elseif spell == 6 then
					spellRank = "(Rank 6)";
				elseif spell == 7 then
					spellRank = "(Rank 7)";
				elseif spell == 8 then
					spellRank = "(Rank 8)";
				elseif spell == 9 then
					spellRank = "(Rank 9)";
				end
			elseif normorfast == "fast" or normorfast == "fastover" then
				spellName = "Lesser Healing Wave";
		 		if spell == 1 then
					spellRank = "(Rank 1)";
				elseif spell == 2 then
					spellRank = "(Rank 2)";
				elseif spell == 3 then
					spellRank = "(Rank 3)";
				elseif spell == 4 then
					spellRank = "(Rank 4)";
				elseif spell == 5 then
					spellRank = "(Rank 5)";
				elseif spell == 6 then
					spellRank = "(Rank 6)";
				end
			end
			local spellNameRank = tostring(spellName .. spellRank);
			DEFAULT_CHAT_FRAME:AddMessage("Casting " .. spellNameRank .. " on " .. CT .. ".");
			if (UnitIsFriend("player", "target")) == 1 and UnitPlayerOrPetInParty("target") == nil and UnitPlayerOrPetInRaid("target") == nil then
				TargetUnit("player");
				CastSpellByName(spellNameRank);
			else
				CastSpellByName(spellNameRank);
				if (SpellIsTargeting()) then
  					SpellTargetUnit("player")
				end
			end
		elseif UnitClass("player") == "Druid" then
			if normorfast == "heal" or normorfast == "healover" then
				spellName = "Healing Touch";
				if spell == 1 then
					spellRank = "(Rank 1)";
				elseif spell == 2 then
					spellRank = "(Rank 2)";
				elseif spell == 3 then
					spellRank = "(Rank 3)";
				elseif spell == 4 then
					spellRank = "(Rank 4)";
				elseif spell == 5 then
					spellRank = "(Rank 5)";
				elseif spell == 6 then
					spellRank = "(Rank 6)";
				elseif spell == 7 then
					spellRank = "(Rank 7)";
				elseif spell == 8 then
					spellRank = "(Rank 8)";
				elseif spell == 9 then
					spellRank = "(Rank 9)";
				elseif spell == 10 then
					spellRank = "(Rank 10)";
				elseif spell == 11 then
					spellRank = "(Rank 11)";
				end
			elseif normorfast == "fast" or normorfast == "fastover" then
					spellName = "Regrowth";
				if spell == 1 then
					spellRank = "(Rank 1)";
				elseif spell == 2 then
					spellRank = "(Rank 2)";
				elseif spell == 3 then
					spellRank = "(Rank 3)";
				elseif spell == 4 then
					spellRank = "(Rank 4)";
				elseif spell == 5 then
					spellRank = "(Rank 5)";
				elseif spell == 6 then
					spellRank = "(Rank 6)";
				elseif spell == 7 then
					spellRank = "(Rank 7)";
				elseif spell == 8 then
					spellRank = "(Rank 8)";
				elseif spell == 9 then
					spellRank = "(Rank 9)";
				end
			end
			local spellNameRank = tostring(spellName .. spellRank);
			DEFAULT_CHAT_FRAME:AddMessage("Casting " .. spellNameRank .. " on " .. CT .. ".");
			if (UnitIsFriend("player", "target")) == 1 and UnitPlayerOrPetInParty("target") == nil and UnitPlayerOrPetInRaid("target") == nil then
				TargetUnit("player");
				CastSpellByName(spellNameRank);
			else
				CastSpellByName(spellNameRank);
				if (SpellIsTargeting()) then
  					SpellTargetUnit("player")
				end
			end
		elseif UnitClass("player") == "Paladin" then
			if normorfast == "heal" or normorfast == "healover" then
				spellName = "Holy Light";
				if spell == 1 then
					spellRank = "(Rank 1)";
				elseif spell == 2 then
					spellRank = "(Rank 2)";
				elseif spell == 3 then
					spellRank = "(Rank 3)";
				elseif spell == 4 then
					spellRank = "(Rank 4)";
				elseif spell == 5 then
					spellRank = "(Rank 5)";
				elseif spell == 6 then
					spellRank = "(Rank 6)";
				elseif spell == 7 then
					spellRank = "(Rank 7)";
				elseif spell == 8 then
					spellRank = "(Rank 8)";
				end
			elseif normorfast == "fast" or normorfast == "fastover" then
				spellName = "Flash of Light";
				if spell == 1 then
					spellRank = "(Rank 1)";
				elseif spell == 2 then
					spellRank = "(Rank 2)";
				elseif spell == 3 then
					spellRank = "(Rank 3)";
				elseif spell == 4 then
					spellRank = "(Rank 4)";
				elseif spell == 5 then
					spellRank = "(Rank 5)";
				elseif spell == 6 then
					spellRank = "(Rank 6)";
				end
			end
			local spellNameRank = tostring(spellName .. spellRank);
			DEFAULT_CHAT_FRAME:AddMessage("Casting " .. spellNameRank .. " on " .. CT .. ".");
			if (UnitIsFriend("player", "target")) == 1 and UnitPlayerOrPetInParty("target") == nil and UnitPlayerOrPetInRaid("target") == nil then
				TargetUnit("player");
				CastSpellByName(spellNameRank);
			else
				CastSpellByName(spellNameRank);
				if (SpellIsTargeting()) then
  					SpellTargetUnit("player")
				end
			end
		end
end

function TEO_SpellList()
	local i = 1
	local spells = {};
	local fastspells ={};
	local cap = 0;
	local fastcap = 0;
	while true do
  	 	local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
  		if not spellName then
  		   do break end
  		end	
  	 	if UnitClass("player")  == "Priest" then
			if spellName == "Lesser Heal" then
				if spellRank == "Rank 1" then
					spells[1] = 1;
					cap = cap + 1;
				elseif spellRank == "Rank 2" then
					spells[2] = 2;
					cap = cap + 1;
				elseif spellRank == "Rank 3" then
					spells[3] = 3;
					cap = cap + 1;
				end
			elseif spellName == "Heal" then
				if spellRank == "Rank 1" then
					spells[4] = 4;
					cap = cap + 1;
				elseif spellRank == "Rank 2" then
					spells[5] = 5;
					cap = cap + 1;
				elseif spellRank == "Rank 3" then
					spells[6] = 6;
					cap = cap + 1;
				elseif spellRank == "Rank 4" then
					spells[7] = 7;
					cap = cap + 1;
				end
			elseif spellName == "Greater Heal" then
				if spellRank == "Rank 1" then
					spells[8] = 8;
					cap = cap + 1;
				elseif spellRank == "Rank 2" then
					spells[9] = 9;
					cap = cap + 1;
				elseif spellRank == "Rank 3" then
					spells[10] = 10;
					cap = cap + 1;
				elseif spellRank == "Rank 4" then
					spells[11] = 11;
					cap = cap + 1;
				elseif spellRank == "Rank 5" then
					spells[12] = 12;
					cap = cap + 1;
				end
			elseif spellName == "Flash Heal" then
				if spellRank == "Rank 1" then
					fastspells[1] = 1;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 2" then
					fastspells[2] = 2;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 3" then
					fastspells[3] = 3;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 4" then
					fastspells[4] = 4;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 5" then
					fastspells[5] = 5;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 6" then
					fastspells[6] = 6;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 7" then
					fastspells[7] = 7;
					fastcap = fastcap + 1;
				end
			end
		elseif UnitClass("player") == "Shaman" then
			if spellName == "Healing Wave" then
				if spellRank == "Rank 1" then
					spells[1] = 1;
					cap = cap + 1;
				elseif spellRank == "Rank 2" then
					spells[2] = 2;
					cap = cap + 1;
				elseif spellRank == "Rank 3" then
					spells[3] = 3;
					cap = cap + 1;
				elseif spellRank == "Rank 4" then
					spells[4] = 4;
					cap = cap + 1;
				elseif spellRank == "Rank 5" then
					spells[5] = 5;
					cap = cap + 1;
				elseif spellRank == "Rank 6" then
					spells[6] = 6;
					cap = cap + 1;
				elseif spellRank == "Rank 7" then
					spells[7] = 7;
					cap = cap + 1;
				elseif spellRank == "Rank 8" then
					spells[8] = 8;
					cap = cap + 1;
				elseif spellRank == "Rank 9" then
					spells[9] = 9;
					cap = cap + 1;
				end
			elseif spellName == "Lesser Healing Wave" then
				if spellRank == "Rank 1" then
					fastspells[1] = 1;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 2" then
					fastspells[2] = 2;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 3" then
					fastspells[3] = 3;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 4" then
					fastspells[4] = 4;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 5" then
					fastspells[5] = 5;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 6" then
					fastspells[6] = 6;
					fastcap = fastcap + 1;
				end
			end
		elseif UnitClass("player") == "Druid" then
			if spellName == "Healing Touch" then
				if spellRank == "Rank 1" then
					spells[1] = 1;
					cap = cap + 1;
				elseif spellRank == "Rank 2" then
					spells[2] = 2;
					cap = cap + 1;
				elseif spellRank == "Rank 3" then
					spells[3] = 3;
					cap = cap + 1;
				elseif spellRank == "Rank 4" then
					spells[4] = 4;
					cap = cap + 1;
				elseif spellRank == "Rank 5" then
					spells[5] = 5;
					cap = cap + 1;
				elseif spellRank == "Rank 6" then
					spells[6] = 6;
					cap = cap + 1;
				elseif spellRank == "Rank 7" then
					spells[7] = 7;
					cap = cap + 1;
				elseif spellRank == "Rank 8" then
					spells[8] = 8;
					cap = cap + 1;
				elseif spellRank == "Rank 9" then
					spells[9] = 9;
					cap = cap + 1;
				elseif spellRank == "Rank 10" then
					spells[10] = 10;
					cap = cap + 1;
				elseif spellRank == "Rank 11" then
					spells[11] = 11;
					cap = cap + 1;
				end
			elseif spellName == "Regrowth" then
				if spellRank == "Rank 1" then
					fastspells[1] = 1;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 2" then
					fastspells[2] = 2;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 3" then
					fastspells[3] = 3;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 4" then
					fastspells[4] = 4;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 5" then
					fastspells[5] = 5;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 6" then
					fastspells[6] = 6;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 7" then
					fastspells[7] = 7;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 8" then
					fastspells[8] = 8;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 9" then
					fastspells[9] = 9;
					fastcap = fastcap + 1;
				end
			end
		elseif UnitClass("player") == "Paladin" then
			if spellName == "Holy Light" then
				if spellRank == "Rank 1" then
					spells[1] = 1;
					cap = cap + 1;
				elseif spellRank == "Rank 2" then
					spells[2] = 2;
					cap = cap + 1;
				elseif spellRank == "Rank 3" then
					spells[3] = 3;
					cap = cap + 1;
				elseif spellRank == "Rank 4" then
					spells[4] = 4;
					cap = cap + 1;
				elseif spellRank == "Rank 5" then
					spells[5] = 5;
					cap = cap + 1;
				elseif spellRank == "Rank 6" then
					spells[6] = 6;
					cap = cap + 1;
				elseif spellRank == "Rank 7" then
					spells[7] = 7;
					cap = cap + 1;
				elseif spellRank == "Rank 8" then
					spells[8] = 8;
					cap = cap + 1;
				end
			elseif spellName == "Flash of Light" then
				if spellRank == "Rank 1" then
					fastspells[1] = 1;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 2" then
					fastspells[2] = 2;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 3" then
					fastspells[3] = 3;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 4" then
					fastspells[4] = 4;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 5" then
					fastspells[5] = 5;
					fastcap = fastcap + 1;
				elseif spellRank == "Rank 6" then
					fastspells[6] = 6;
					fastcap = fastcap + 1;
				end
			end
   		end
   			i = i + 1
   	end
	return cap, spells, fastcap, fastspells;
end

function TEO_MissingHP()
	if UnitHealth("target") == 0 then
		local CH = UnitHealth("player");
		local MH = UnitHealthMax("player");
		local NH = (MH - CH);
		return NH;
	elseif UnitPlayerOrPetInParty("target") == 1 or UnitPlayerOrPetInRaid("target") == 1 or UnitIsUnit("player", "target") == 1 then
		local CH = UnitHealth("target");
		local MH = UnitHealthMax("target");
		local NH = (MH - CH);
		return NH;
	else
		local CH = UnitHealth("player");
		local MH = UnitHealthMax("player");
		local NH = (MH - CH);
		return NH;
	end
end

function TEO_ValidTarget()
	local CT = UnitName("target");
	if UnitHealthMax("target") == 0 then
		local ValidTarget = 0;
		CT = UnitName("player")
		return CT, ValidTarget;
	elseif UnitPlayerOrPetInParty("target") == 1 or UnitPlayerOrPetInRaid("target") == 1 or CT == UnitName("player") then
		local ValidTarget = 1;
		return CT, ValidTarget;
	else
		local ValidTarget = 0;
		CT = UnitName("player");
		return CT, ValidTarget;
	end
end

function TEO_SpellToCast(normorfast)
	local spellName = "Error";
	local spellRank = "Error";
	local missingHP = TEO_MissingHP();
	local TEO_MaxHeal = 0;
	local TEO_HealTalentRank = 0;
	local TEO_HealMax = {};
	local TEO_Bonus = toperoff_BonusScanner();
	local TEO_SpellSpeed = {};
	local TEO_BonusMax = 0;
	if TEO_Bonus == -1 then
		TEO_Bonus = 0;
	end
	if normorfast == "heal" or normorfast == "fast" then
	elseif normorfast == "healover" or normorfast == "fastover" then
	elseif normorfast == "bonus" then
	else
		normorfast = "heal";
	end
	if UnitClass("player") == "Priest" then
		if normorfast == "heal" then
			TEO_HealMax = {56,85,157,341,491,642,804,1013,1289,1609,2006,2194};
			TEO_SpellSpeed = {0.429,0.571,0.714,0.857,0.857,0.857,0.857,0.857,0.857,0.857,0.857,0.857};
		elseif normorfast == "healover" then
			TEO_HealMax = {0,56,85,157,341,491,642,804,1013,1289,1609,2006};
			TEO_SpellSpeed = {0.429,0.571,0.714,0.857,0.857,0.857,0.857,0.857,0.857,0.857,0.857,0.857};
		elseif normorfast == "fast" then
			TEO_HealMax = {237,314,393,478,616,764,958};
			TEO_SpellSpeed = {0.429,0.429,0.429,0.429,0.429,0.429,0.429};
		elseif normorfast == "fastover" then
			TEO_HealMax = {0,237,314,393,478,616,764};
			TEO_SpellSpeed = {0.429,0.429,0.429,0.429,0.429,0.429,0.429};
		end
			local nameTalent, icon, iconx, icony, currRank, maxRank = GetTalentInfo(2,15);
			TEO_HealTalentRank = currRank * 0.02;
			TEO_HealTalentRank = TEO_HealTalentRank + 1;
			if normorfast == "heal" or normorfast == "healover" then
				for i=TEO_SPELLCAP,1,-1 do
					TEO_MaxHeal = TEO_HealMax[i] * TEO_HealTalentRank;
					TEO_BonusMax = TEO_SpellSpeed[i] * TEO_Bonus;
					TEO_BonusMax = math.floor(TEO_BonusMax);
					TEO_MaxHeal = TEO_MaxHeal + TEO_BonusMax;
					if missingHP > TEO_MaxHeal then
						local spell = TEO_SPELLS[i];
						for i=spell,1,-1 do
							if spell == nil then
								spell = spell - 1;
							else
								return spell, normorfast;
							end
						end
					else
					end
				end
			elseif normorfast == "fast" or normorfast == "fastover" then
				for i=TEO_FASTCAP,1,-1 do
					TEO_MaxHeal = TEO_HealMax[i] * TEO_HealTalentRank;
					TEO_BonusMax = TEO_SpellSpeed[i] * TEO_Bonus;
					TEO_BonusMax = math.floor(TEO_BonusMax);
					TEO_MaxHeal = TEO_MaxHeal + TEO_BonusMax;
					if missingHP > TEO_MaxHeal then
						local spell = TEO_FASTSPELLS[i];
						for i=spell,1,-1 do
							if spell == nil then
								spell = spell - 1;
							else
								return spell, normorfast;
							end
						end
					else
					end
				end
			end
	elseif UnitClass("player") == "Shaman" then
		if normorfast == "heal" then
			TEO_HealMax = {44,78,155,316,440,662,854,1167,1561};
			TEO_SpellSpeed = {0.429,0.571,0.714,0.857,0.857,0.857,0.857,0.857,0.857};
		elseif normorfast == "healover" then
			TEO_HealMax = {0,44,78,155,316,440,662,854,1167};
			TEO_SpellSpeed = {0.429,0.571,0.714,0.857,0.857,0.857,0.857,0.857,0.857};
		elseif normorfast == "fast" then
			TEO_HealMax = {186,281,381,514,705,928};
			TEO_SpellSpeed = {0.429,0.429,0.429,0.429,0.429,0.429};
		elseif normorfast == "fastover" then
			TEO_HealMax = {0,186,281,381,514,705};
			TEO_SpellSpeed = {0.429,0.429,0.429,0.429,0.429,0.429};
		end
			local nameTalent, icon, iconx, icony, currRank, maxRank= GetTalentInfo(3,13);
			TEO_HealTalentRank = currRank * 0.02;
			TEO_HealTalentRank = TEO_HealTalentRank + 1;
			if normorfast == "heal" or normorfast == "healover" then
				for i=TEO_SPELLCAP,1,-1 do
					TEO_MaxHeal = TEO_HealMax[i] * TEO_HealTalentRank;
					TEO_BonusMax = TEO_SpellSpeed[i] * TEO_Bonus;
					TEO_BonusMax = math.floor(TEO_BonusMax);
					TEO_MaxHeal = TEO_MaxHeal + TEO_BonusMax;
					if missingHP > TEO_MaxHeal then
						local spell = TEO_SPELLS[i];
						for i=spell,1,-1 do
							if spell == nil then
								spell = spell - 1;
							else
								return spell, normorfast;
							end
						end
					else
					end
				end
			elseif normorfast == "fast" or normorfast == "fastover" then
				for i=TEO_FASTCAP,1,-1 do
					TEO_MaxHeal = TEO_HealMax[i] * TEO_HealTalentRank;
					TEO_BonusMax = TEO_SpellSpeed[i] * TEO_Bonus;
					TEO_BonusMax = math.floor(TEO_BonusMax);
					TEO_MaxHeal = TEO_MaxHeal + TEO_BonusMax;
					if missingHP > TEO_MaxHeal then
						local spell = TEO_FASTSPELLS[i];
						for i=spell,1,-1 do
							if spell == nil then
								spell = spell - 1;
							else
								return spell, normorfast;
							end
						end
					else
					end
				end
			end
	elseif UnitClass("player") == "Druid" then
		if normorfast == "heal" then
			TEO_HealMax = {51,112,243,445,694,894,1120,1427,1796,2230,2677};
			TEO_SpellSpeed = {0.429,0.571,0.714,0.857,1,1,1,1,1,1,1};
		elseif normorfast == "healover" then
			TEO_HealMax = {0,51,112,243,445,694,894,1120,1427,1796,2230};
			TEO_SpellSpeed = {0.429,0.571,0.714,0.857,1,1,1,1,1,1,1};
		elseif normorfast == "fast" then
			TEO_HealMax = {98,188,274,360,457,575,724,905,1119};
			TEO_SpellSpeed = {0.278,0.278,0.278,0.278,0.278,0.278,0.278,0.278,0.278};
		elseif normorfast == "fastover" then
			TEO_HealMax = {0,98,188,274,360,457,575,724,905};
			TEO_SpellSpeed = {0.278,0.278,0.278,0.278,0.278,0.278,0.278,0.278,0.278};
		end
			local nameTalent, icon, iconx, icony, currRank, maxRank= GetTalentInfo(3,12);
			TEO_HealTalentRank = currRank * 0.02;
			TEO_HealTalentRank = TEO_HealTalentRank + 1;	
			if normorfast == "heal" or normorfast == "healover" then
				for i=TEO_SPELLCAP,1,-1 do
					TEO_MaxHeal = TEO_HealMax[i] * TEO_HealTalentRank;
					TEO_BonusMax = TEO_SpellSpeed[i] * TEO_Bonus;
					TEO_BonusMax = math.floor(TEO_BonusMax);
					TEO_MaxHeal = TEO_MaxHeal + TEO_BonusMax;
					if missingHP > TEO_MaxHeal then
						local spell = TEO_SPELLS[i];
						for i=spell,1,-1 do
							if spell == nil then
								spell = spell - 1;
							else
								return spell, normorfast;
							end
						end
					else
					end
				end
			elseif normorfast == "fast" or normorfast == "fastover" then
				for i=TEO_FASTCAP,1,-1 do
					TEO_MaxHeal = TEO_HealMax[i] * TEO_HealTalentRank;
					TEO_BonusMax = TEO_SpellSpeed[i] * TEO_Bonus;
					TEO_BonusMax = math.floor(TEO_BonusMax);
					TEO_MaxHeal = TEO_MaxHeal + TEO_BonusMax;
					if missingHP > TEO_MaxHeal then
						local spell = TEO_FASTSPELLS[i];
						for i=spell,1,-1 do
							if spell == nil then
								spell = spell - 1;
							else
								return spell, normorfast;
							end
						end
					else
					end
				end
			end
	elseif UnitClass("player") == "Paladin" then
		if normorfast == "heal" then
			TEO_HealMax = {47,90,187,356,553,780,945,1388};
			TEO_SpellSpeed = {0.714,0.714,0.714,0.714,0.714,0.714,0.714,0.714};
		elseif normorfast == "healover" then
			TEO_HealMax = {0,47,90,187,356,553,780,945};
			TEO_SpellSpeed = {0.714,0.714,0.714,0.714,0.714,0.714,0.714,0.714};
		elseif normorfast == "fast" then
			TEO_HealMax = {72,110,163,221,299,383};
			TEO_SpellSpeed = {0.429,0.429,0.429,0.429,0.429,0.429};
		elseif normorfast == "fastover" then
			TEO_HealMax = {0,72,110,163,221,299};
			TEO_SpellSpeed = {0.429,0.429,0.429,0.429,0.429,0.429};
		end
			local nameTalent, icon, iconx, icony, currRank, maxRank= GetTalentInfo(1,5);
			TEO_HealTalentRank = currRank * 0.04;
			TEO_HealTalentRank = TEO_HealTalentRank + 1;	
			if normorfast == "heal" or normorfast == "healover" then
				for i=TEO_SPELLCAP,1,-1 do
					TEO_MaxHeal = TEO_HealMax[i] * TEO_HealTalentRank;
					TEO_BonusMax = TEO_SpellSpeed[i] * TEO_Bonus;
					TEO_BonusMax = math.floor(TEO_BonusMax);
					TEO_MaxHeal = TEO_MaxHeal + TEO_BonusMax;
					if missingHP > TEO_MaxHeal then
						local spell = TEO_SPELLS[i];
						for i=spell,1,-1 do
							if spell == nil then
								spell = spell - 1;
							else
								return spell, normorfast;
							end
						end
					else
					end
				end
			elseif normorfast == "fast" or normorfast == "fastover" then
				for i=TEO_FASTCAP,1,-1 do
					TEO_MaxHeal = TEO_HealMax[i] * TEO_HealTalentRank;
					TEO_BonusMax = TEO_SpellSpeed[i] * TEO_Bonus;
					TEO_BonusMax = math.floor(TEO_BonusMax);
					TEO_MaxHeal = TEO_MaxHeal + TEO_BonusMax;
					if missingHP > TEO_MaxHeal then
						local spell = TEO_FASTSPELLS[i];
						for i=spell,1,-1 do
							if spell == nil then
								spell = spell - 1;
							else
								return spell, normorfast;
							end
						end
					else
					end
				end
			end
	end
end
