
HealPointsCalculatorUI = { 
  SELECTED = { };
};

local function setResultInfo(number, name, currentStat, newStat, numberFormat)
  local frame = getglobal("HealPointsResult"..number);
  local label = getglobal(frame:GetName().."Label");
  local current = getglobal(frame:GetName().."Current");
  local delta = getglobal(frame:GetName().."Difference");
  local new = getglobal(frame:GetName().."Result");

  local deltaStat = newStat - currentStat;
  local deltaText = deltaStat;
  label:SetText(name);
  if (numberFormat) then
    currentStat = format(numberFormat, currentStat);
    newStat = format(numberFormat, newStat);
    deltaText = format(numberFormat, deltaText);
  end
  current:SetText(currentStat);
  HealPointsCalculatorUI:setStat(delta, deltaText, deltaStat);
  HealPointsCalculatorUI:setStat(new, newStat, deltaStat);
 end

function HealPointsCalculatorUI:setStat(statString, stat, delta)
  if (delta == 0) then
    statString:SetText(stat);
  elseif (delta > 0) then
    statString:SetText(GREEN_FONT_COLOR_CODE..stat..FONT_COLOR_CODE_CLOSE);
  else 
    statString:SetText(RED_FONT_COLOR_CODE..stat..FONT_COLOR_CODE_CLOSE);
  end	
end

function HealPointsCalculatorUI:setStatInfo(number, name, currentStat, extraDelta, numberFormat)
  local frame = getglobal("HealPointsVariables"..number);
  local label = getglobal(frame:GetName().."Label");
  local originalStatText = getglobal(frame:GetName().."OriginalStat");
  local inputBox = getglobal(frame:GetName().."InputBox");
  local newStatText = getglobal(frame:GetName().."NewStat");
  
  local delta = inputBox:GetNumber() + extraDelta;
  local newStat = currentStat + delta;
  label:SetText(name);
  if (numberFormat) then
    currentStat = format(numberFormat, currentStat);
    newStat = format(numberFormat, newStat);
  end
  originalStatText:SetText(currentStat);
  HealPointsCalculatorUI:setStat(newStatText, newStat, delta);
end

function HealPointsCalculatorUI:setSpellInfo(number, spellType, oldVal, newVal, formatString)
  if (newVal < 0) then
    newVal = GREEN_FONT_COLOR_CODE.."Infinite"..FONT_COLOR_CODE_CLOSE;
  elseif (newVal > oldVal) then
    newVal = GREEN_FONT_COLOR_CODE..format(formatString,newVal)..FONT_COLOR_CODE_CLOSE;
  elseif (newVal < oldVal) then
    newVal = RED_FONT_COLOR_CODE..format(formatString,newVal)..FONT_COLOR_CODE_CLOSE;
  else
    newVal = format(formatString,newVal);
  end
  local spellString = getglobal("HealPointsSpell"..number..spellType);
  if (oldVal < 0) then
    spellString:SetText(newVal.."(Infinite)");
  else
    spellString:SetText(format("%s("..formatString..")", newVal, oldVal));
  end
end

function HealPointsCalculatorUI:inputBoxChanged()
	HealPointsCalculator:updateStats();
	HealPointsCalculator:updateSpellStats();
	HealPointsCalculator:updateHealPoints();
end

function HealPointsCalculatorUI:bolChanged()
  HealPointsCalculator:updateSpellStats();
  HealPointsCalculator:updateHealPoints();
end

function HealPointsCalculatorUI:updateSpellLists() 	-- Update dropdown menus 
	local function updateSpellList(objref, spellTable)
		if (spellTable) then
			local count = 0;
			for i = 1, table.getn(spellTable), 1 do
				if (HealPointsSpells:getHighestSpellRank(spellTable[i]['name']) >= spellTable[i]['rank']) then
					local info = {};
					info.text = spellTable[i]['abbr'].." ("..spellTable[i]['rank']..")";
					info.func = HealPointsCalculatorUI.spellSelected;
					if (objref and type(objref) == "table") then
						info.owner = objref;
					end
					UIDropDownMenu_AddButton(info)
					count = count + 1;
				end
			end
			if (UIDropDownMenu_GetSelectedID(objref) == nil) then
				UIDropDownMenu_SetSelectedID(objref, count);
			end
		end
	end

	UIDropDownMenu_Initialize(HealPointsSpellShort,function() updateSpellList(HealPointsSpellShort, HealPointsSpells.SPELLTABLE[1]); end);
	UIDropDownMenu_Initialize(HealPointsSpellLong,function() updateSpellList(HealPointsSpellLong, HealPointsSpells.SPELLTABLE[2]); end);
	UIDropDownMenu_Initialize(HealPointsSpellHOT,function() updateSpellList(HealPointsSpellHOT, HealPointsSpells.SPELLTABLE[3]); end);
end

function HealPointsCalculatorUI:spellSelected()
	if (this.owner) then
		UIDropDownMenu_SetSelectedID(this.owner, this:GetID());
		HealPointsCalculatorUI:updateSpellTable();
		HealPointsCalculator:updateSpellStats();
	end
end

function HealPointsCalculatorUI:updateSpellTable() 	-- Update tables with info about currently selected spellrank 
	if (UIDropDownMenu_GetSelectedID(HealPointsSpellLong) == nil) then -- should not happen
		HealPointsCalculatorUI:updateSpellLists()
	end
	
	HealPointsCalculatorUI.SELECTED = { };
	local selectedRank = { };
	selectedRank[1] = UIDropDownMenu_GetSelectedID(HealPointsSpellShort);
	selectedRank[2] = UIDropDownMenu_GetSelectedID(HealPointsSpellLong);
	selectedRank[3] = UIDropDownMenu_GetSelectedID(HealPointsSpellHOT);	
	
	for i = 1, 3 do
		if (selectedRank[i] and HealPointsSpells.SPELLTABLE[i] ~= nil) then
			HealPointsCalculatorUI.SELECTED[i] = HealPointsSpells.SPELLTABLE[i][selectedRank[i]];
			HealPointsCalculatorUI.SELECTED[i] = HealPointsSpells:updateSpellTalents(HealPointsCalculatorUI.SELECTED[i]);
		end
	end
end	
	

function HealPointsCalculatorUI:setTooltip()
	local function spellToString(spell)
		if (spell == nil) then
			return "No spell selected";
		else
			return spell['name'].." ("..spell['rank']..")";
		end
	end

	local function totalTimeToString(curTime, newTime)
		if (curTime == null) then
			curTime = "NA";
		elseif (curTime < 0) then
			curTime = "Infinite";
		else
			curTime = format("%d", curTime).."s";
		end
		if (newTime == null) then
			newTime = "NA";
		elseif (newTime < 0) then
			newTime = "Infinite";
		else
			newTime = format("%d", newTime).."s";
		end
		return newTime.." ("..curTime..")";
	end
	
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	if (this:GetID() == 1) then	-- PowerPoints
		GameTooltip:SetText("PowerPoints", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		if (HealPoints.db.char.power['auto'] == true) then
			GameTooltip:AddLine("Hitpoints healed in "..HealPoints.db.char.power['duration'].." minute(s) using your most");
			GameTooltip:AddLine("powerful spell, starting with "..HealPoints.db.char.power['mana'].."% mana.");
			GameTooltip:AddLine("Regeneration and 5 sec rule are taken into account.");
			GameTooltip:AddLine("\nSelected spell:", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			GameTooltip:AddLine(spellToString(HealPointsCalculator.HP_LastPowerfulCurrent).." / "..spellToString(HealPointsCalculator.HP_LastPowerfulNew));
		else
			GameTooltip:AddLine("Hitpoints healed in "..HealPoints.db.char.power['duration'].." minute(s) using");
			GameTooltip:AddLine(HealPoints.db.char.power['spell'].." ("..HealPoints.db.char.power['rank'].."), starting with "..HealPoints.db.char.power['mana'].."% mana.");
			GameTooltip:AddLine("Regeneration and 5 sec rule are taken into account.");
		end
	elseif (this:GetID() == 2) then -- EndurancePoints
		GameTooltip:SetText("EndurancePoints", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		if (HealPoints.db.char.endurance['auto'] == true) then
			GameTooltip:AddLine("Hitpoints healed in "..HealPoints.db.char.endurance['duration'].." minute(s) using your most");
			GameTooltip:AddLine("efficient spell, starting with "..HealPoints.db.char.endurance['mana'].."% mana.");
			GameTooltip:AddLine("Regeneration and 5 sec rule are taken into account.");
			GameTooltip:AddLine("\nSelected spell:", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
			GameTooltip:AddLine(spellToString(HealPointsCalculator.HP_LastEfficientCurrent).." / "..spellToString(HealPointsCalculator.HP_LastEfficientNew));
		else
			GameTooltip:AddLine("Hitpoints healed in "..HealPoints.db.char.endurance['duration'].." minute(s) using");
			GameTooltip:AddLine(HealPoints.db.char.endurance['spell'].." ("..HealPoints.db.char.endurance['rank'].."), starting with "..HealPoints.db.char.endurance['mana'].."% mana.");
			GameTooltip:AddLine("Regeneration and 5 sec rule are taken into account.");		
		end
	elseif (this:GetID() == 8) then -- Tot. healed without regen
		GameTooltip:SetText("Total hitpoints healed (no regen)", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddLine("Hitpoints healed with selected spell");
		GameTooltip:AddLine("using the whole mana bar.");
		GameTooltip:AddLine("Regeneration not taken into account.");
	elseif (this:GetID() == 9) then -- Tot. healed with regen
		GameTooltip:SetText("Total hitpoints healed (regen)", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddLine("Hitpoints healed with selected spell");
		GameTooltip:AddLine("using the whole mana bar.");
		GameTooltip:AddLine("Casting regeneration is taken into account.");
		GameTooltip:AddLine("\nTime taken until mana bar is spent:", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddLine(totalTimeToString(HealPointsCalculator.TH_TotalTimeCurrent[1], HealPointsCalculator.TH_TotalTimeNew[1]).."    "..
							totalTimeToString(HealPointsCalculator.TH_TotalTimeCurrent[2], HealPointsCalculator.TH_TotalTimeNew[2]).."    "..
							totalTimeToString(HealPointsCalculator.TH_TotalTimeCurrent[3], HealPointsCalculator.TH_TotalTimeNew[3]));
	elseif (this:GetID() == 13) then -- Casting regen
		GameTooltip:SetText("Casting mana regeneration", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddLine("Mana regenerated when last spell");
		GameTooltip:AddLine("was casted less than 5 seconds ago.");
	elseif (this:GetID() == 14) then -- Normal regen
		GameTooltip:SetText("Normal mana regeneration", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddLine("Mana regenerated when last spell");
		GameTooltip:AddLine("was casted more than 5 seconds ago.");
	end
	GameTooltip:Show();
end

function HealPointsCalculatorUI:show()
	if (HealPointsCalculatorUI.SELECTED[2]	== nil) then
		HealPointsCalculatorUI:updateSpellLists();
		HealPointsCalculatorUI:updateSpellTable();	
	end
	HealPointsCalculator:updateStats();
	HealPointsCalculator:updateSpellStats();
	HealPointsCalculator:updateHealPoints();
end

function HealPointsCalculatorUI:setHealPoints(power, powerNew, efficient, efficientNew)
  local healPoints = power + efficient;
  local healPointsNew = powerNew + efficientNew;

	setResultInfo(1, "PowerPoints:", power, powerNew, "%5.0f");
	setResultInfo(2, "+ EndurancePoints:", efficient, efficientNew, "%5.0f");
	setResultInfo(4, "= HealPoints:", healPoints, healPointsNew, "%5.0f");
end