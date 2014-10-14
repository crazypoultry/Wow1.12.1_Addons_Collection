-- TankPoints Mod
TankPoints_Version = "0.4.5";
TankPoints_Author = "Whitetooth";

-- Default Values

-- Function Hooks
local lOriginal_PaperDollFrame_SetResistances;

-- OnLoad
function TankPointsFrame_OnLoad()
	-- Slash commands
	SlashCmdList["TANKPOINTSCOMMAND"] = TankPoints_SlashHandler;
	SLASH_TANKPOINTSCOMMAND1 = "/tankpoints";
	SLASH_TANKPOINTSCOMMAND2 = "/tp";
	
	-- Register events
	this:RegisterEvent("UNIT_LEVEL");
	this:RegisterEvent("UNIT_RESISTANCES");
	this:RegisterEvent("UNIT_STATS");
	this:RegisterEvent("UNIT_DEFENSE");
	this:RegisterEvent("UNIT_MAXHEALTH");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	
	-- Hook PaperDollFrame_SetResistances
	if (not lOriginal_PaperDollFrame_SetResistances) then		
		lOriginal_PaperDollFrame_SetResistances = PaperDollFrame_SetResistances;
		PaperDollFrame_SetResistances = PaperDollFrame_SetResistances_New;
	end
end

function TankPoints_SlashHandler(msg)
	local index, value;
	if (not msg or msg == "") then --Show Help
		if(TankPointsCalculator:IsVisible()) then
			TankPointsCalculator:Hide();
		else
			TankPointsCalculator:Show();
		end
	else
		local command=strlower(msg);
		if (command == "test") then
		end
	end
end

function TankPointsFrame_OnShow()
	TankPointsFrame_SetPoints()
end

-- event handler
function TankPointsFrame_OnEvent(event)
	-- Do nothing if Character frame is not visable
	if (not CharacterFrame:IsVisible()) then
		return;
	end
	-- Do nothing if event target is not player
	if (not arg1 == "player") then
		return;
	end
	TankPointsFrame_SetPoints();
end

-- calculate TankPoints and set the text
function TankPointsFrame_SetPoints()
	local unit = "player";
	local label = getglobal("TankPointsFrameLabel");
	local text = getglobal("TankPointsFrameStatText");
	local frame = getglobal("TankPointsFrame");
	label:SetText("TankPoints:");
	
	local maxHealth = UnitHealthMax(unit);
	local playerLevel = UnitLevel(unit);
	local base, effectiveArmor, armor, posBuff, negBuff = UnitArmor(unit);
	local armorReduction = effectiveArmor/((85 * playerLevel) + 400);
	armorReduction = (armorReduction/(armorReduction + 1));
	
	local dodge = 0;
	local parry = 0;
	local block = 0;
	-- Check if player has the actual dodge, parry, block abilities
	local spellBookGeneralTab = 1;
	local spellTabName, spellTabTexture, spellTabOffset, spellTabNumSpells = GetSpellTabInfo(spellBookGeneralTab);
	for i=1, spellTabNumSpells, 1 do
		local spellName, spellRank = GetSpellName(i, spellBookGeneralTab)
		if (spellName == TANKPOINTS_DODGE_SPELL_NAME) then
			dodge = GetDodgeChance() * 0.01;
		elseif (spellName == PARRY) then
			parry = GetParryChance() * 0.01;
		elseif (spellName == BLOCK) then
			block = GetBlockChance() * 0.01;
		end
	end

	--Defense
	-- Increases the chance of being missed by an attack.
	-- Increases the chance to dodge, parry, and block.
	-- Decreases the chance of being affected by a critical hit.
	-- Decreases the chance of being affected by a "crushing blow".
	local base, modifier = UnitDefense(unit);
	local defense = base + modifier;
	local defenseModifier = (defense - playerLevel * 5) * 0.04 * 0.01;
	local mobCrit = max(0, 0.05 - defenseModifier);
	local mobMiss = 0.05 + defenseModifier;
	local mobDps = 1;
	
	-- Warrior stance
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
	local totalReduction = 1 - (mobCrit * 2 + (1 - mobCrit - mobMiss - dodge - parry)) * (1 - armorReduction) * stanceModifier;
	local tankPoints = maxHealth / (mobDps * (1 - totalReduction));
	
	text:SetText(format("%5.0f", tankPoints));
	
	-- Set the tooltip text
	frame.tankPoints = tankPoints;
	frame.effectiveArmor = effectiveArmor;
	frame.defense = defense;
	frame.armorReduction = armorReduction * 100;
	frame.dodge = dodge * 100;
	frame.parry = parry * 100;
	frame.block = block * 100;
	frame.critReduction = defenseModifier * 100;
	frame.totalReduction = totalReduction * 100;
	frame.currentStance = currentStance;
end

-- show tooltips on enter
function TankPointsFrame_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText("TankPoints "..format("%.0f", this.tankPoints), HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	if (this.currentStance ~= "Default") then
		GameTooltip:AddLine(TANKPOINTS_TOOLTIP_IN..format("%s", this.currentStance), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	end
	GameTooltip:AddDoubleLine(ARMOR..":", format("%d (%.2f%%)", this.effectiveArmor, this.armorReduction), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(TANKPOINTS_TOOLTIP_DEFENSE..":", format("%d", this.defense), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	if (this.dodge ~= 0) then
		GameTooltip:AddDoubleLine(DODGE..":", format("%.2f%%", this.dodge), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end
	if (this.parry ~= 0) then
		GameTooltip:AddDoubleLine(PARRY..":", format("%.2f%%", this.parry), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end
	if (this.block ~= 0) then
		GameTooltip:AddDoubleLine(BLOCK..":", format("%.2f%%", this.block), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end
	GameTooltip:AddDoubleLine(TANKPOINTS_TOOLTIP_CRIT_REDUCTION..":", format("%.2f%%", this.critReduction), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(TANKPOINTS_TOOLTIP_TOTAL_REDUCTION..":", format("%.2f%%", this.totalReduction), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddLine(TANKPOINTS_TOOLTIP_HINT_CLICK_TO_SHOW_TANKPOINTS_CALCULATOR, GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
	GameTooltip:Show();
end

-- hide/show Calculator on click
function TankPointsFrame_OnClick()
	if(TankPointsCalculator:IsVisible()) then
		TankPointsCalculator:Hide();
	else
		TankPointsCalculator:Show();
	end
end

function PaperDollFrame_SetResistances_New()
	for i=1, NUM_RESISTANCE_TYPES, 1 do
		local resistance;
		local positive;
		local negative;
		local base;
		local text = getglobal("MagicResText"..i);
		local frame = getglobal("MagicResFrame"..i);
		
		base, resistance, positive, negative = UnitResistance("player", frame:GetID());

		local resistanceName = getglobal("RESISTANCE"..(frame:GetID()).."_NAME");
		frame.tooltip = resistanceName.." "..RESISTANCE_LABEL.." "..resistance;

		if( abs(negative) > positive ) then
			text:SetText(RED_FONT_COLOR_CODE..resistance..FONT_COLOR_CODE_CLOSE);
		elseif( abs(negative) == positive ) then
			text:SetText(resistance);
		else
			text:SetText(GREEN_FONT_COLOR_CODE..resistance..FONT_COLOR_CODE_CLOSE);
		end
		
		if ( positive ~= 0 or negative ~= 0 ) then
			frame.tooltip = frame.tooltip.. " ( "..HIGHLIGHT_FONT_COLOR_CODE..base;
			if( positive > 0 ) then
				frame.tooltip = frame.tooltip..GREEN_FONT_COLOR_CODE.." +"..positive;
			end
			if( negative < 0 ) then
				frame.tooltip = frame.tooltip.." "..RED_FONT_COLOR_CODE..negative;
			end
			frame.tooltip = frame.tooltip..FONT_COLOR_CODE_CLOSE.." )";
		end
		local unitLevel = UnitLevel("player");
		
		local magicResistanceNumber = resistance/unitLevel;
		if ( magicResistanceNumber > 5 ) then
			resistanceLevel = RESISTANCE_EXCELLENT;
		elseif ( magicResistanceNumber > 3.75 ) then
			resistanceLevel = RESISTANCE_VERYGOOD;
		elseif ( magicResistanceNumber > 2.5 ) then
			resistanceLevel = RESISTANCE_GOOD;
		elseif ( magicResistanceNumber > 1.25 ) then
			resistanceLevel = RESISTANCE_FAIR;
		elseif ( magicResistanceNumber > 0 ) then
			resistanceLevel = RESISTANCE_POOR;
		else
			resistanceLevel = RESISTANCE_NONE;
		end
		
		-- Added by Whitetooth
		unitLevel = max(unitLevel, 20, floor(resistance / 5));
		local spellReduction = 75 * min(resistance, unitLevel * 5) / (unitLevel * 5);
		local maxHealth = UnitHealthMax("player");
		local resistTP = maxHealth / (1 - spellReduction / 100);
		TANKPOINTS_RESISTANCE_TOOLTIP_SUBTEXT = RESISTANCE_TOOLTIP_SUBTEXT..GREEN_FONT_COLOR_CODE.." (%2.2f%%)\n"..LIGHTYELLOW_FONT_COLOR_CODE..resistanceName.." TankPoints: %.0f"..FONT_COLOR_CODE_CLOSE;
		frame.tooltipSubtext = format(TANKPOINTS_RESISTANCE_TOOLTIP_SUBTEXT, resistanceName, unitLevel, resistanceLevel, spellReduction, resistTP);
		-- end
	end
end