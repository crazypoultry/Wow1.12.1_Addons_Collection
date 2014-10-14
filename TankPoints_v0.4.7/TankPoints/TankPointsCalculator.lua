function TankPointsCalculator_OnLoad()
	tinsert(UISpecialFrames, "TankPointsCalculator"); -- Esc closes the window
	UIPanelWindows["TankPointsCalculator"] = nil;
	
	-- Register events
	this:RegisterEvent("UNIT_LEVEL");
	this:RegisterEvent("UNIT_RESISTANCES");
	this:RegisterEvent("UNIT_STATS");
	this:RegisterEvent("UNIT_DEFENSE");
	this:RegisterEvent("UNIT_MAXHEALTH");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
end

function TankPointsCalculator_OnEvent(event)
	-- Do nothing if Calculator frame is not visable
	if (not TankPointsCalculator:IsVisible()) then
		return;
	end
	--DEFAULT_CHAT_FRAME:AddMessage("Event: "..event.." for >>"..arg1.."<<") -- debug
	-- Do nothing if event target is not player
	if (not arg1 == "player") then
		return;
	end
	TankPointsCalculator_Update();
end

-- Drag functions
function TankPointsCalculator_OnMouseDown(arg1)
	if (arg1 == "LeftButton") then
		TankPointsCalculator:StartMoving();
	end
end

function TankPointsCalculator_OnMouseUp(arg1)
	if (arg1 == "LeftButton") then
		TankPointsCalculator:StopMovingOrSizing();
	end
end

-------------------------------------------------------
function TankPointsCalculatorTooltip_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(this:GetName(), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddLine(this:GetParent():GetName(), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	if (this:GetName() == "TankPointsVariables1ShowTooltip") then
		GameTooltip:SetText("Strength", HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddLine("1 Strength = 2 Attack Power", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		GameTooltip:AddLine("1 Strength = 2 Attack Power", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		GameTooltip:AddLine("(14 Attack Power = 1 DPS)", NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
	GameTooltip:Show();
end

function TankPointsCalculatorReset_OnClick()
	for i = 1, 11, 1 do
		local frame = getglobal("TankPointsVariables"..i);
		local inputBox = getglobal("TankPointsVariables"..i.."InputBox");
		inputBox:SetText("0");
		inputBox:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end
end

function TankPointsCalculator_Update()
	------------------------------------------
	-- Get original stats info
	------------------------------------------
	local unit = "player";
	local maxHealth = UnitHealthMax(unit);
	local playerLevel = UnitLevel(unit);
	local base, effectiveArmor, armor, posBuff, negBuff = UnitArmor(unit);
	local armorReduction = effectiveArmor/((85 * playerLevel) + 400);
	armorReduction = (armorReduction/(armorReduction + 1));
	
	-- Dodge, Parry, Block
	local dodge = 0;
	local parry = 0;
	local block = 0;
	-- Check if player has the actual Dodge, Parry, Block abilities
	local spellBookGeneralTab = 1;
	local spellTabName, spellTabTexture, spellTabOffset, spellTabNumSpells = GetSpellTabInfo(spellBookGeneralTab);
	for i = 1, spellTabNumSpells, 1 do
		local spellName, spellRank = GetSpellName(i, spellBookGeneralTab)
		if (spellName == TANKPOINTS_DODGE_SPELL_NAME) then
			dodge = GetDodgeChance() * 0.01;
		end
		if (spellName == PARRY) then
			parry = GetParryChance() * 0.01;
		end
		if (spellName == BLOCK) then
			block = GetBlockChance() * 0.01;
		end
	end

	-- Defense
	local base, modifier = UnitDefense(unit);
	local defense = base + modifier;
	local defenseModifier = (defense - playerLevel * 5) * 0.04 * 0.01;
	local mobCrit = max(0, 0.05 - defenseModifier);
	local mobMiss = 0.05 + defenseModifier;
	local mobDps = 1;
	
	-- Warrior Stance
	local stanceModifier = 1;
	local currentStance = "Default";
	for i = 1, GetNumShapeshiftForms(), 1 do
		local icon, name, isActive = GetShapeshiftFormInfo(i);
		if isActive then
			currentStance = name;
		end
	end
	if (currentStance == TANKPOINTS_WARRIOR_DEFENSIVE_STANCE) then
		stanceModifier = 0.9;
	elseif (currentStance == TANKPOINTS_WARRIOR_BERSERKER_STANCE) then
		stanceModifier = 1.1;
	end
	
	-- the calculation
	local critReduction = defenseModifier;
	local totalReduction = 1 - (mobCrit * 2 + max(0, (1 - mobCrit - mobMiss - dodge - parry))) * (1 - armorReduction) * stanceModifier;
	local tankPoints = maxHealth / (mobDps * (1 - totalReduction));
	
	-------------------------------------------------
	-- Set original stats text and caculate new stats
	-------------------------------------------------
	-- TODO: add input checks
	local frame, label, originalStatText, inputBox, delta, newStat, newStatText;
	for i = 1, 5, 1 do
		-- Get widgets
		frame = getglobal("TankPointsVariables"..i);
		label = getglobal(frame:GetName().."Label");
		originalStatText = getglobal(frame:GetName().."OriginalStat");
		inputBox = getglobal(frame:GetName().."InputBox");
		newStatText = getglobal(frame:GetName().."NewStat");
		-- Set label text
		label:SetText(TEXT(getglobal("SPELL_STAT"..(i-1).."_NAME"))..":");
		-- Get current stat
		local stat, effectiveStat, posBuff, negBuff = UnitStat("player", i);
		-- Set current stat text
		originalStatText:SetText(effectiveStat);
		-- Caculate new stat
		newStat = originalStatText:GetText() + inputBox:GetNumber();
		-- Set new stat text
		if (inputBox:GetNumber() == 0) then
			newStatText:SetText(newStat);
		elseif (inputBox:GetNumber() > 0) then
			newStatText:SetText(GREEN_FONT_COLOR_CODE..newStat..FONT_COLOR_CODE_CLOSE);
		else -- inputBox:GetNumber() < 0
			newStatText:SetText(RED_FONT_COLOR_CODE..newStat..FONT_COLOR_CODE_CLOSE);
		end
	end
	local strInputBox = getglobal("TankPointsVariables1InputBox");
	local agiInputBox = getglobal("TankPointsVariables2InputBox");
	local stamInputBox = getglobal("TankPointsVariables3InputBox");
	local intInputBox = getglobal("TankPointsVariables4InputBox");
	local spiInputBox = getglobal("TankPointsVariables5InputBox");
	local defenseInputBox = getglobal("TankPointsVariables8InputBox");
	
	local strNew = getglobal("TankPointsVariables1OriginalStat"):GetText() + strInputBox:GetNumber();
	local agiNew = getglobal("TankPointsVariables2OriginalStat"):GetText() + agiInputBox:GetNumber();
	local stamNew = getglobal("TankPointsVariables3OriginalStat"):GetText() + stamInputBox:GetNumber();
	local intNew = getglobal("TankPointsVariables4OriginalStat"):GetText() + intInputBox:GetNumber();
	local spiNew = getglobal("TankPointsVariables5OriginalStat"):GetText() + spiInputBox:GetNumber();
	-------------------------
	-- Max Health 
	-- 1 stam = 10 MaxHealth
	-------------------------
	-- Get widgets
	i = 6;
	frame = getglobal("TankPointsVariables"..i);
	label = getglobal(frame:GetName().."Label");
	originalStatText = getglobal(frame:GetName().."OriginalStat");
	inputBox = getglobal(frame:GetName().."InputBox");
	newStatText = getglobal(frame:GetName().."NewStat");
	-- Set label text
	label:SetText(TANKPOINTS_CALCULATOR_MAX_HP..":");
	-- Set current stat text
	originalStatText:SetText(maxHealth);
	-- Caculate new stat
	local HealthFromStam = stamInputBox:GetNumber() * 10;
	-- Taurens get 5% bonus HP
	if (UnitRace("player") == TANKPOINTS_CALCULATOR_TAUREN) then
		local stat, effectiveStat, posBuff, negBuff = UnitStat("player", 3);
		HealthFromStam = (stamInputBox:GetNumber() * 10 * 1.05) - (math.mod(effectiveStat, 2) / 2);
		if (stamInputBox:GetNumber() > 0) then
			HealthFromStam = math.ceil(HealthFromStam);
		else
			HealthFromStam = math.ceil(HealthFromStam);
		end
	end
	delta = inputBox:GetNumber() + HealthFromStam;
	newStat = originalStatText:GetText() + delta;
	local maxHealthNew = newStat;
	-- Set new stat text
	if (delta == 0) then
		newStatText:SetText(newStat);
	elseif (delta > 0) then
		newStatText:SetText(GREEN_FONT_COLOR_CODE..newStat..FONT_COLOR_CODE_CLOSE);
	else -- delta < 0
		newStatText:SetText(RED_FONT_COLOR_CODE..newStat..FONT_COLOR_CODE_CLOSE);
	end
	-------------------------
	-- Armor 
	-- 1 agi = 2 armor
	-------------------------
	-- Get widgets
	i = i + 1;
	frame = getglobal("TankPointsVariables"..i);
	label = getglobal(frame:GetName().."Label");
	originalStatText = getglobal(frame:GetName().."OriginalStat");
	inputBox = getglobal(frame:GetName().."InputBox");
	newStatText = getglobal(frame:GetName().."NewStat");
	-- Set label text
	label:SetText(ARMOR..":");
	-- Set current stat text
	originalStatText:SetText(effectiveArmor);
	-- Caculate new stat
	-- warrior talent: Toughness, Increases your armor value from items by 2%/point
	-- does not affect armor gained from agi or enchant, not sure if its a good idea to include this in.
	delta = inputBox:GetNumber() + agiInputBox:GetNumber() * 2;
	newStat = originalStatText:GetText() + delta;
	local armorNew = newStat;
	-- Set new stat text
	if (delta == 0) then
		newStatText:SetText(newStat);
	elseif (delta > 0) then
		newStatText:SetText(GREEN_FONT_COLOR_CODE..newStat..FONT_COLOR_CODE_CLOSE);
	else -- delta < 0
		newStatText:SetText(RED_FONT_COLOR_CODE..newStat..FONT_COLOR_CODE_CLOSE);
	end
	-------------------------
	-- Defense
	-------------------------
	-- Get widgets
	i = i + 1;
	frame = getglobal("TankPointsVariables"..i);
	label = getglobal(frame:GetName().."Label");
	originalStatText = getglobal(frame:GetName().."OriginalStat");
	inputBox = getglobal(frame:GetName().."InputBox");
	newStatText = getglobal(frame:GetName().."NewStat");
	-- Set label text
	label:SetText(TANKPOINTS_TOOLTIP_DEFENSE..":");
	-- Set current stat text
	originalStatText:SetText(defense);
	-- Caculate new stat
	delta = inputBox:GetNumber();
	newStat = originalStatText:GetText() + delta;
	local defenseNew = newStat;
	-- Set new stat text
	if (delta == 0) then
		newStatText:SetText(newStat);
	elseif (delta > 0) then
		newStatText:SetText(GREEN_FONT_COLOR_CODE..newStat..FONT_COLOR_CODE_CLOSE);
	else -- delta < 0
		newStatText:SetText(RED_FONT_COLOR_CODE..newStat..FONT_COLOR_CODE_CLOSE);
	end
	-------------------------
	-- Parry
	-- 1 defense = 0.04 parry
	-------------------------
	-- Get widgets
	i = i + 1;
	frame = getglobal("TankPointsVariables"..i);
	label = getglobal(frame:GetName().."Label");
	originalStatText = getglobal(frame:GetName().."OriginalStat");
	inputBox = getglobal(frame:GetName().."InputBox");
	newStatText = getglobal(frame:GetName().."NewStat");
	-- Set label text
	label:SetText(PARRY.."(%):");
	-- Set current stat text
	originalStatText:SetText(format("%.2f", parry * 100));
	-- Caculate new stat
	delta = inputBox:GetNumber() + defenseInputBox:GetNumber() * 0.04;
	newStat = parry * 100 + delta;
	local parryNew = newStat;
	-- Set new stat text
	if (delta == 0) then
		newStatText:SetText(format("%.2f", newStat));
	elseif (delta > 0) then
		newStatText:SetText(GREEN_FONT_COLOR_CODE..format("%.2f", newStat)..FONT_COLOR_CODE_CLOSE);
	else -- delta < 0
		newStatText:SetText(RED_FONT_COLOR_CODE..format("%.2f", newStat)..FONT_COLOR_CODE_CLOSE);
	end
	-------------------------
	-- Dodge
	-- 1 defense = 0.04 dodge
	-- 1 agi = 0.05 dodge
	-------------------------
	-- Get widgets
	i = i + 1;
	frame = getglobal("TankPointsVariables"..i);
	label = getglobal(frame:GetName().."Label");
	originalStatText = getglobal(frame:GetName().."OriginalStat");
	inputBox = getglobal(frame:GetName().."InputBox");
	newStatText = getglobal(frame:GetName().."NewStat");
	-- Set label text
	label:SetText(DODGE.."(%):");
	-- Set current stat text
	originalStatText:SetText(format("%.2f", dodge * 100));
	-- Caculate new stat
	delta = inputBox:GetNumber() + defenseInputBox:GetNumber() * 0.04 + agiInputBox:GetNumber() * 0.05;
	newStat = dodge * 100 + delta;
	local dodgeNew = newStat;
	-- Set new stat text
	if (delta == 0) then
		newStatText:SetText(format("%.2f", newStat));
	elseif (delta > 0) then
		newStatText:SetText(GREEN_FONT_COLOR_CODE..format("%.2f", newStat)..FONT_COLOR_CODE_CLOSE);
	else -- delta < 0
		newStatText:SetText(RED_FONT_COLOR_CODE..format("%.2f", newStat)..FONT_COLOR_CODE_CLOSE);
	end
	-------------------------
	-- Block
	-- 1 defense = 0.04 block
	-------------------------
	-- Get widgets
	i = i + 1;
	frame = getglobal("TankPointsVariables"..i);
	label = getglobal(frame:GetName().."Label");
	originalStatText = getglobal(frame:GetName().."OriginalStat");
	inputBox = getglobal(frame:GetName().."InputBox");
	newStatText = getglobal(frame:GetName().."NewStat");
	-- Set label text
	label:SetText(BLOCK.."(%):");
	-- Set current stat text
	originalStatText:SetText(format("%.2f", block * 100));
	-- Caculate new stat
	delta = inputBox:GetNumber() + defenseInputBox:GetNumber() * 0.04;
	newStat = block * 100 + delta;
	local blockNew = newStat;
	-- Set new stat text
	if (delta == 0) then
		newStatText:SetText(format("%.2f", newStat));
	elseif (delta > 0) then
		newStatText:SetText(GREEN_FONT_COLOR_CODE..format("%.2f", newStat)..FONT_COLOR_CODE_CLOSE);
	else -- delta < 0
		newStatText:SetText(RED_FONT_COLOR_CODE..format("%.2f", newStat)..FONT_COLOR_CODE_CLOSE);
	end
	
	------------------------------------------
	-- Set ResultsFrame label and current text
	------------------------------------------
	-- TankPoints
	frame = getglobal("TankPointsResults1");
	label = getglobal("TankPointsResults1".."Label");
	current = getglobal("TankPointsResults1".."Current");
	label:SetText("TankPoints:");
	current:SetText(format("%.0f", tankPoints));
	
	-- TotalReduction
	frame = getglobal("TankPointsResults2");
	label = getglobal("TankPointsResults2".."Label");
	current = getglobal("TankPointsResults2".."Current");
	label:SetText(TANKPOINTS_TOOLTIP_TOTAL_REDUCTION.."(%):");
	current:SetText(format("%.2f", totalReduction * 100));
	
	-- CritReduction
	frame = getglobal("TankPointsResults3");
	label = getglobal("TankPointsResults3".."Label");
	current = getglobal("TankPointsResults3".."Current");
	label:SetText(TANKPOINTS_TOOLTIP_CRIT_REDUCTION.."(%):");
	current:SetText(format("%.2f", critReduction * 100));
	
	------------------------------------------
	-- Caculate new TankPoints
	------------------------------------------
	local unit = "player";
	local maxHealth = maxHealthNew;
	local playerLevel = UnitLevel(unit);
	local armorReduction = armorNew/((85 * playerLevel) + 400);
	armorReduction = (armorReduction/(armorReduction + 1));
	
	-- Dodge, Parry, Block
	local dodge = 0;
	local parry = 0;
	local block = 0;
	-- Check if player has the actual Dodge, Parry, Block abilities
	local spellBookGeneralTab = 1;
	local spellTabName, spellTabTexture, spellTabOffset, spellTabNumSpells = GetSpellTabInfo(spellBookGeneralTab);
	for i=1, spellTabNumSpells, 1 do
		local spellName, spellRank = GetSpellName(i, spellBookGeneralTab)
		if (spellName == TANKPOINTS_DODGE_SPELL_NAME) then
			dodge = dodgeNew * 0.01;
		end
		if (spellName == PARRY) then
			parry = parryNew * 0.01;
		end
		if (spellName == BLOCK) then
			block = blockNew * 0.01;
		end
	end

	-- Defense
	local defenseModifier = (defenseNew - playerLevel * 5) * 0.04 * 0.01;
	local mobCrit = max(0, 0.05 - defenseModifier);
	local mobMiss = 0.05 + defenseModifier;
	local mobDps = 1;
	
	-- Warrior Stance
	local stanceModifier = 1;
	local currentStance = "Default";
	for i = 1, GetNumShapeshiftForms(), 1 do
		local icon, name, isActive = GetShapeshiftFormInfo(i);
		if isActive then
			currentStance = name;
		end
	end
	if (currentStance == TANKPOINTS_WARRIOR_DEFENSIVE_STANCE) then
		stanceModifier = 0.9;
	elseif (currentStance == TANKPOINTS_WARRIOR_BERSERKER_STANCE) then
		stanceModifier = 1.1;
	end
	
	-- the calculation
	local critReduction = defenseModifier;
	local totalReduction = 1 - (mobCrit * 2 + max(0, (1 - mobCrit - mobMiss - dodge - parry))) * (1 - armorReduction) * stanceModifier;
	local tankPoints = maxHealth / (mobDps * (1 - totalReduction));
	
	
	------------------------------------------
	-- Set ResultsFrame difference and result text
	------------------------------------------
	-- TankPoints
	frame = getglobal("TankPointsResults1");
	current = getglobal("TankPointsResults1".."Current");
	difference = getglobal("TankPointsResults1".."Difference");
	result = getglobal("TankPointsResults1".."Result");
	result:SetText(format("%.0f", tankPoints));
	delta = result:GetText() - current:GetText();
	if (delta == 0) then
		result:SetText(format("%.0f", tankPoints));
		difference:SetText(format("%.0f", delta));
	elseif (delta > 0) then
		result:SetText(GREEN_FONT_COLOR_CODE..format("%.0f", tankPoints)..FONT_COLOR_CODE_CLOSE);
		difference:SetText(GREEN_FONT_COLOR_CODE..format("%.0f", delta)..FONT_COLOR_CODE_CLOSE);
	else -- delta < 0
		result:SetText(RED_FONT_COLOR_CODE..format("%.0f", tankPoints)..FONT_COLOR_CODE_CLOSE);
		difference:SetText(RED_FONT_COLOR_CODE..format("%.0f", delta)..FONT_COLOR_CODE_CLOSE);
	end
	
	-- TotalReduction
	frame = getglobal("TankPointsResults2");
	current = getglobal("TankPointsResults2".."Current");
	difference = getglobal("TankPointsResults2".."Difference");
	result = getglobal("TankPointsResults2".."Result");
	result:SetText(format("%.2f", totalReduction * 100));
	delta = gsub(result:GetText(), ",", "%.") - gsub(current:GetText(), ",", "%."); -- localization fix: replace all "," with "."
	if (delta == 0) then
		result:SetText(format("%.2f", totalReduction * 100));
		difference:SetText(format("%.2f", delta));
	elseif (delta > 0) then
		result:SetText(GREEN_FONT_COLOR_CODE..format("%.2f", totalReduction * 100)..FONT_COLOR_CODE_CLOSE);
		difference:SetText(GREEN_FONT_COLOR_CODE..format("%.2f", delta)..FONT_COLOR_CODE_CLOSE);
	else -- delta < 0
		result:SetText(RED_FONT_COLOR_CODE..format("%.2f", totalReduction * 100)..FONT_COLOR_CODE_CLOSE);
		difference:SetText(RED_FONT_COLOR_CODE..format("%.2f", delta)..FONT_COLOR_CODE_CLOSE);
	end
	
	-- CritReduction
	frame = getglobal("TankPointsResults3");
	current = getglobal("TankPointsResults3".."Current");
	difference = getglobal("TankPointsResults3".."Difference");
	result = getglobal("TankPointsResults3".."Result");
	result:SetText(format("%.2f", critReduction * 100));
	delta = gsub(result:GetText(), ",", "%.") - gsub(current:GetText(), ",", "%.");
	if (delta == 0) then
		result:SetText(format("%.2f", critReduction * 100));
		difference:SetText(format("%.2f", delta));
	elseif (delta > 0) then
		result:SetText(GREEN_FONT_COLOR_CODE..format("%.2f", critReduction * 100)..FONT_COLOR_CODE_CLOSE);
		difference:SetText(GREEN_FONT_COLOR_CODE..format("%.2f", delta)..FONT_COLOR_CODE_CLOSE);
	else -- delta < 0
		result:SetText(RED_FONT_COLOR_CODE..format("%.2f", critReduction * 100)..FONT_COLOR_CODE_CLOSE);
		difference:SetText(RED_FONT_COLOR_CODE..format("%.2f", delta)..FONT_COLOR_CODE_CLOSE);
	end
end

-- VariableFrame
function TankPointsIncrement_OnClick()
	local inputBox = getglobal(strsub(this:GetName(), 1, -16).."InputBox");
	inputBox:SetNumber(inputBox:GetNumber() + 1);
	inputBox:ClearFocus();
end

function TankPointsDecrement_OnClick()
	local inputBox = getglobal(strsub(this:GetName(), 1, -16).."InputBox");
	inputBox:SetNumber(inputBox:GetNumber() - 1);
	inputBox:ClearFocus();
end

function TankPointsInputBox_OnTextChanged()
	local inputBox = getglobal(this:GetName());
	if (inputBox:GetNumber() > 0) then
		inputBox:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
	elseif (inputBox:GetNumber() < 0) then
		inputBox:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
	else
		inputBox:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end
	TankPointsCalculator_Update();
end

function TankPointsInputBox_StrengthChanged()
	local originalStatText = getglobal(strsub(this:GetName(), 1, -9).."OriginalStat");
	local originalStat = originalStatText:GetText();
	local inputBox = getglobal(this:GetName());
	local newStatText = getglobal(strsub(this:GetName(), 1, -9).."NewStat");
	newStatText:SetText(originalStat + inputBox:GetNumber());
end

function TankPointsInputBox_AgilityChanged()
end

function TankPointsInputBox_StaminaChanged()
end

function TankPointsInputBox_IntellectChanged()
end

function TankPointsInputBox_SpiritChanged()
end

function TankPointsInputBox_ArmorChanged()
end

function TankPointsInputBox_DefenseChanged()
end

function TankPointsInputBox_ParryChanged()
end

function TankPointsInputBox_DodgeChanged()
end
