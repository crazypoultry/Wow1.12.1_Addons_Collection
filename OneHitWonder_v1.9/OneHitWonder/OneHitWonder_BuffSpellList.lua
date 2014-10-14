OneHitWonder_NormalBuffProgression_FiveRanks = {
	1, 
	6, 
	20,
	34,
	48
};

OneHitWonder_NormalBuffProgression_SixRanks = {
	1, 
	6, 
	14,
	26,
	38,
	50
};

OneHitWonder_NormalBuffProgression_SevenRanks = {
	1, 
	1, 
	10,
	20,
	30,
	40,
	50
};

OneHitWonder_NormalBuffProgression_NineRanks = {
	1, 
	4, 
	10, 
	16, 
	22,
	28,
	34,
	40,
	46
};

OneHitWonder_NormalBuffProgression_TenRanks = {
	1, 
	4, 
	10, 
	16, 
	22,
	28,
	34,
	40,
	46,
	50
};

OneHitWonder_SpellLevelList = {
	[ONEHITWONDER_SPELL_BLESSING_OF_MIGHT_NAME] = OneHitWonder_NormalBuffProgression_SixRanks,
	[ONEHITWONDER_SPELL_ARCANE_INTELLECT_NAME] = OneHitWonder_NormalBuffProgression_FiveRanks,
	[ONEHITWONDER_SPELL_POWER_WORD_FORTITUDE_NAME] = OneHitWonder_NormalBuffProgression_SixRanks,
	[ONEHITWONDER_SPELL_RENEW_NAME] = OneHitWonder_NormalBuffProgression_NineRanks,
	[ONEHITWONDER_SPELL_REJUVENATION_NAME] = OneHitWonder_NormalBuffProgression_TenRanks,
-- shamelessly stolen from BuffBot
	[ONEHITWONDER_SPELL_DAMPEN_MAGIC_NAME] = {
		2,
		14,
		26,
		38,
		50
	},
	[ONEHITWONDER_SPELL_AMPLIFY_MAGIC_NAME] = {
		8,
		20,
		32,
		44
	},
	[ONEHITWONDER_SPELL_SHADOW_PROTECTION_NAME] = {
		20,
		30,
		40
	},
	[ONEHITWONDER_SPELL_DIVINE_SPIRIT_NAME] = {
		30,
		40,
		50
	},
};


function OneHitWonder_GetHighestSpellName(spellName, highestSpellRank, spellBook, doNotUseCache)
	local i = 1;
	local highestId = -1;
	local highestRankSoFar = -1;
	local rank;
	local spellRankNumber = 0;
	if (highestSpellRank) then
		spellRankNumber = tonumber(highestSpellRank);
		if (not spellRankNumber) then
			spellRankNumber = 0;
		end
	end
	if ( not spellBook ) then
		spellBook = OneHitWonder_GetSpellBook();
	end
	local name, rankName;
	name, rankName = OneHitWonder_GetSpellName(i, spellBook, doNotUseCache);
	while name do
		if ( name == spellName) then
			if ( highestSpellRank == nil ) then
				rank = OneHitWonder_GetRankAsNumber(rankName);
				if ( rank ) then
					if ( rank > highestRankSoFar ) then
						highestRankSoFar = rank;
						highestId = i;
					end
				else
					return i;
				end
			else
				rank = OneHitWonder_GetRankAsNumber(rankName);
				if ( rank == spellRankNumber ) then
					highestId = i;
					highestRankSoFar = rank;
					break;
				elseif ( rank < spellRankNumber ) then
					if ( rank > highestRankSoFar ) then
						highestId = i;
						highestRankSoFar = rank;
					end
				end
			end
		end
		i = i + 1;
		name, rankName = OneHitWonder_GetSpellName(i, spellBook)
	end
	local qwe = highestRankSoFar;
	if ( highestRankSoFar <= 0 ) then
		qwe = nil;
	end
	return spellName, qwe, highestId;
end


function OneHitWonder_GetAppropriateBuffId(unitLevel, buffName)
	return OneHitWonder_GetAppropriateSpellId(unitLevel, buffName);
end

function OneHitWonder_GetAppropriateBuff(unitLevel, buffName)
	return OneHitWonder_GetAppropriateSpell(unitLevel, buffName);
end

function OneHitWonder_GetAppropriateSpellId(unitLevel, buffName)
	local _, _, id = OneHitWonder_GetAppropriateSpell(unitLevel, buffName)
	return id;
end

function OneHitWonder_GetAppropriateSpell(unitLevel, buffName)
	local list = OneHitWonder_SpellLevelList[buffName];
	if ( list ) then
		local highestI = 0;
		for i = getn(list), 1, -1 do
			if ( unitLevel >= list[i] ) then
				highestI = i;
				break;
			end
		end
		if ( unitLevel > list[getn(list)] ) then
			return OneHitWonder_GetHighestSpellName(buffName);
		else
			return OneHitWonder_GetHighestSpellName(buffName, highestI);
		end
	else
		return OneHitWonder_GetHighestSpellName(buffName);
	end
end