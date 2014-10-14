HealPointsUtil = { };

function HealPointsUtil:colorValue(value)
  local v = format("%5.0f", value);
  if (value == 0) then
    return v;
  elseif (value > 0) then
    return GREEN_FONT_COLOR_CODE..v..FONT_COLOR_CODE_CLOSE;
  else
    return RED_FONT_COLOR_CODE..v..FONT_COLOR_CODE_CLOSE;
  end
end

function HealPointsUtil:getTableIndex(t, entry)
	for i = 1, table.getn(t), 1 do
		if (t[i] == entry) then
			return i;
		end
	end
end

function HealPointsUtil:round(num)
	return math.floor(num + 0.5);
end

function HealPointsUtil:isPlayerBuffUp(buffName)
  local iIterator = 1
  while (UnitBuff("player", iIterator)) do
    if (string.find(UnitBuff("player", iIterator), buffName)) then
      return true
    end
    iIterator = iIterator + 1
  end
  return false
end;

function HealPointsUtil:getTalentRank(talentName)
	local numTabs = GetNumTalentTabs();
	for t=1, numTabs do
		local numTalents = GetNumTalents(t);
		for i=1, numTalents do
			local nameTalent, _, _, _, currRank, _ = GetTalentInfo(t,i);
			if (nameTalent == talentName) then
				return currRank
			end
		end
	end
	return 0;
end

