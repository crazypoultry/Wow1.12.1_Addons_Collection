TITAN_PETXP_FREQUENCY=1
TITAN_PETXP_ID="PetXp"

------------
-- OnLoad --
------------
function TitanPanelPetXpButton_OnLoad()
	-- Events used to update the button
	this:RegisterEvent("PLAYER_XP_UPDATE")
	this:RegisterEvent("PET_BAR_UPDATE")
	this:RegisterEvent("PLAYER_PET_CHANGED")

	-- Check class and switch to warlock mode if needed
	local _, class = UnitClass("player")
	if class == "WARLOCK" then
		tooltip = TITAN_PETXP_TOOLTIP_WARLOCK
	else
		tooltip = TITAN_PETXP_TOOLTIP
	end

	-- Register the addon
	this.registry={
		id="PetXp",
		menuText=TITAN_PETXP_TEXT_MENU,
		buttonTextFunction="TitanPanelPetXpButton_GetButtonText",
		frequency=1,
		tooltipTitle=tooltip,
		tooltipTextFunction="TitanPanelPetXpButton_GetTooltipText",
		updateType=TITAN_PANEL_UPDATE_TOOLTIP,
		savedVariables={
			Mode = 0,
			Color = 0,
			BarLevel = 0,
			Experience = 1,
			Level = 1,
			Loyalty = 1,
			Food = 1,
			TrainingPoints = 0,
			Health = 1,
			Damage = 1,
			Armor = 1,
			Stats = 0
		}
	}
end

-------------
-- OnEvent --
-------------
function TitanPanelPetXpButton_OnEvent()
	TitanPanelButton_UpdateButton("PetXp")
end

-------------------
-- GetButtonText --
-------------------
function TitanPanelPetXpButton_GetButtonText()
	local rawXP, perXP, color = TitanPanelPetXpButton_GetPetXp()
	local _, class = UnitClass("player") -- Using second return variable, it will be the same on all clients (like german)
	if class == "HUNTER" and UnitExists("pet") then
		-- Select Display Mode
		if TitanGetVar(TITAN_PETXP_ID, "Mode") == 0 then
			xp = perXP
		elseif TitanGetVar(TITAN_PETXP_ID, "Mode") == 1 then
			xp = rawXP
		else
			xp = rawXP.." ("..perXP..")"
		end
		-- Color or not?
		if TitanGetVar(TITAN_PETXP_ID, "Color") == 1 then
			buttonRichText = format(TITAN_PETXP_TEXT_BUTTON, TitanPanelPetXpButton_GetColor(xp, color))
		else
			buttonRichText = format(TITAN_PETXP_TEXT_BUTTON, TitanUtils_GetHighlightText(xp))
		end
		-- Display Level?
		if TitanGetVar(TITAN_PETXP_ID, "BarLevel") == 1 then
			buttonRichText = buttonRichText.."        "..format(TITAN_PETXP_TEXT_BUTTON_LEVEL, TitanUtils_GetHighlightText(UnitLevel("pet")))
		end
	elseif class == "WARLOCK" and UnitExists("pet") then
		buttonRichText = TITAN_PETXP_TEXT_BUTTON_WARLOCK
	else
		buttonRichText = "o"
	end
	return buttonRichText
end

--------------------
-- GetTooltipText --
--------------------
function TitanPanelPetXpButton_GetTooltipText()
	-- Xp stats
	local rawXP, perXP, _ = TitanPanelPetXpButton_GetPetXp()
	local _, class = UnitClass("player")
	if UnitExists("pet") then
		-----------------
		-- Gather Data --
		-----------------
		-- Level
		level = UnitLevel("pet").." "..UnitCreatureFamily("pet")

		-- Loyalty
		if class == "HUNTER" then
			if ( GetLocale() == "deDE" ) then
				-- German
				loyalty = string.sub(GetPetLoyalty(), 11, 12)
				loyalty = loyalty.." ("..string.sub(GetPetLoyalty(), 15)..")"
			else
				-- Not supported or english, trying the english method
				loyalty = string.sub(GetPetLoyalty(), 15, 16)
				loyalty = loyalty.." ("..string.sub(GetPetLoyalty(), 19)..")"
			end
			totalPoints, spent = GetPetTrainingPoints()
			points = totalPoints - spent
		end

		-- Health/Focus/Mana
		local curHealth = UnitHealth("pet")
		local maxHealth = UnitHealthMax("pet")
		health = curHealth.."/"..maxHealth.." ("..floor(curHealth/maxHealth*100).."%)"

		local curFocus = UnitMana("pet")
		local maxFocus = UnitManaMax("pet")
		focus = floor(curFocus/curFocus*100).."%"
		mana = curFocus.."/"..maxFocus.." ("..focus..")"
		
		-- Food
		if class == "HUNTER" then
			food = BuildListString(GetPetFoodTypes())
		end

		-- Damage stats
		speed, _ = UnitAttackSpeed("pet")
		local minDamage, maxDamage, _, _, physicalBonusPos, physicalBonusNeg, percent = UnitDamage("pet")

		local baseDamage = (minDamage + maxDamage) * 0.5
		local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent
		local damageTooltip = floor(minDamage).." - "..ceil(maxDamage)

		local totalBonus = (fullDamage - baseDamage)
		displayMin = max(floor(minDamage + totalBonus),1)
		displayMax = max(ceil(maxDamage + totalBonus),1)
		damagePerSecond = format("%01.2f", (max(fullDamage,1) / speed))
		speed = format("%01.1f", speed)

		-- Armor stats
		local base, effectiveArmor, _, posBuff, negBuff = UnitArmor("pet")
		local totalBufs = posBuff + negBuff
		armorReduction = effectiveArmor/((85 * UnitLevel("pet")) + 400)
		armorReduction = format("%01.2f", 100 * (armorReduction/(armorReduction + 1))).."%"
		armor = effectiveArmor;

		-- Statistics
		_, strength, _, _ = UnitStat("pet",1);
		_, agility, _, _ = UnitStat("pet",2);
		_, stamina, _, _ = UnitStat("pet",3);
		_, intellect, _, _ = UnitStat("pet",4);
		_, spirit, _, _ = UnitStat("pet",5);

		------------------
		-- Display Data --
		------------------
		buttonRichText = ""
		-- Experience
		if class == "HUNTER" and TitanGetVar(TITAN_PETXP_ID, "Experience") == 1 then
			buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_RAW, TitanUtils_GetHighlightText(rawXP)).."\n"
			buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_PERCENT, TitanUtils_GetHighlightText(perXP)).."\n\n"
		end
		-- Level
		if TitanGetVar(TITAN_PETXP_ID, "Level") == 1 then
			buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_LEVEL, TitanUtils_GetHighlightText(level)).."\n"
		end
		if class == "HUNTER" then
			-- Food
			if TitanGetVar(TITAN_PETXP_ID, "Food") == 1 then
				buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_FOOD, TitanUtils_GetHighlightText(food)).."\n"
			end
			-- Loyalty
			if TitanGetVar(TITAN_PETXP_ID, "Loyalty") == 1 then
				buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_LOYALTY, TitanUtils_GetHighlightText(loyalty)).."\n\n"
			end
			-- Training Points
			if TitanGetVar(TITAN_PETXP_ID, "TrainingPoints") == 1 then
				buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_TRAININGPOINTS, TitanUtils_GetHighlightText(totalPoints)).."\n"
				buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_LEFT, TitanUtils_GetHighlightText(points)).."\n"
				buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_SPENT, TitanUtils_GetHighlightText(spent)).."\n\n"
			end
		end
		-- Health & Mana
		if TitanGetVar(TITAN_PETXP_ID, "Health") == 1 then
			buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_HEALTH, TitanUtils_GetHighlightText(health)).."\n"
			if class == "HUNTER" then
				buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_FOCUS, TitanUtils_GetHighlightText(focus)).."\n\n"
			else
				buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_MANA, TitanUtils_GetHighlightText(mana)).."\n\n"
			end
		end
		-- Damage
		if TitanGetVar(TITAN_PETXP_ID, "Damage") == 1 then
			buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_MINDMG, TitanUtils_GetHighlightText(displayMin)).."\n"
			buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_MAXDMG, TitanUtils_GetHighlightText(displayMax)).."\n"
			buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_DPS, TitanUtils_GetHighlightText(damagePerSecond)).."\n"
			buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_SPEED, TitanUtils_GetHighlightText(speed)).."\n"
		end
		-- Armor
		if TitanGetVar(TITAN_PETXP_ID, "Armor") == 1 then
			buttonRichText = buttonRichText.."\n"..format(TITAN_PETXP_TOOLTIP_ARMOR, TitanUtils_GetHighlightText(armor)).."\n"
			buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_DMGRED, TitanUtils_GetHighlightText(armorReduction)).."\n"
		end
		-- Statistics
		if TitanGetVar(TITAN_PETXP_ID, "Stats") == 1 then
			buttonRichText = buttonRichText.."\n"..format(TITAN_PETXP_TOOLTIP_STRENGTH, TitanUtils_GetHighlightText(strength)).."\n"
			buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_AGILITY, TitanUtils_GetHighlightText(agility)).."\n"
			buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_STAMINA, TitanUtils_GetHighlightText(stamina)).."\n"
			buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_INTELLECT, TitanUtils_GetHighlightText(intellect)).."\n"
			buttonRichText = buttonRichText..format(TITAN_PETXP_TOOLTIP_SPIRIT, TitanUtils_GetHighlightText(spirit)).."\n"
		end
	else
		-- No pet active
		buttonRichText = TITAN_PETXP_TOOLTIP_NA
	end
	return buttonRichText
end

--------------
-- GetPetXp --
--------------
function TitanPanelPetXpButton_GetPetXp()
	local currXP, nextXP = GetPetExperience()
	local perXP = 0
	if nextXP > 0 then
		perXP = floor(currXP/nextXP*100)
	end
	return currXP.." / "..nextXP, perXP.."%", perXP
end

--------------
-- GetColor --
--------------
function TitanPanelPetXpButton_GetColor(text, percent)
	if percent < 50 then
		redColorCode = "ff"
		greenColorCode = format("%2x", (percent/100)*255*2)
	else
		greenColorCode = "ff"
		redColorCode = format("%2x", ((100-percent)/100)*255*2)
	end
	local colorCode = "|cff"..redColorCode..greenColorCode.."00"
	return colorCode..text..FONT_COLOR_CODE_CLOSE
end

----------------------
-- PreparePetXpMenu --
----------------------
function TitanPanelRightClickMenu_PreparePetXpMenu()
	local id = "PetXp"
	-- Options
	info={}
	info.text=TITAN_PETXP_MENU_OPTIONS
	info.func=TitanPanelPetXpButton_OptionsClick
	UIDropDownMenu_AddButton(info)
	-- Hide
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE,id,TITAN_PANEL_MENU_FUNC_HIDE)
end

------------------
-- OptionsClick --
------------------
function TitanPanelPetXpButton_OptionsClick()
	-- Show options screen
	TitanPanelPetXpOptions:Show()

	-- Set labels
	TitanPanelPetXpOptions_TitleText:SetText(TITAN_PETXP_OPTIONS_TITLE)
	TitanPanelPetXpOptions_ModeText:SetText(TITAN_PETXP_OPTIONS_TITLE_MODE)
	TitanPanelPetXpOptions_BarText:SetText(TITAN_PETXP_OPTIONS_TITLE_BAR)
	TitanPanelPetXpOptions_TooltipText:SetText(TITAN_PETXP_OPTIONS_TITLE_TOOLTIP)
	
	TitanPanelPetXpOptions_PercentText:SetText(TITAN_PETXP_OPTIONS_PERCENT)
	TitanPanelPetXpOptions_RawText:SetText(TITAN_PETXP_OPTIONS_RAW)
	TitanPanelPetXpOptions_BothText:SetText(TITAN_PETXP_OPTIONS_BOTH)
	
	TitanPanelPetXpOptions_ColorText:SetText(TITAN_PETXP_OPTIONS_COLOR)
	TitanPanelPetXpOptions_BarLevelText:SetText(TITAN_PETXP_OPTIONS_LEVEL)
	
	TitanPanelPetXpOptions_ExperienceText:SetText(TITAN_PETXP_OPTIONS_EXPERIENCE)
	TitanPanelPetXpOptions_LevelText:SetText(TITAN_PETXP_OPTIONS_LEVEL)
	TitanPanelPetXpOptions_FoodText:SetText(TITAN_PETXP_OPTIONS_DIET)
	TitanPanelPetXpOptions_LoyaltyText:SetText(TITAN_PETXP_OPTIONS_LOYALTY)
	TitanPanelPetXpOptions_TrainingPointsText:SetText(TITAN_PETXP_OPTIONS_TRAININGPOINTS)
	TitanPanelPetXpOptions_HealthText:SetText(TITAN_PETXP_OPTIONS_HEALTH)
	TitanPanelPetXpOptions_DamageText:SetText(TITAN_PETXP_OPTIONS_DAMAGE)
	TitanPanelPetXpOptions_ArmorText:SetText(TITAN_PETXP_OPTIONS_ARMOR)
	TitanPanelPetXpOptions_StatsText:SetText(TITAN_PETXP_OPTIONS_STATS)
	TitanPanelPetXpOptions_Close:SetText(TITAN_PETXP_OPTIONS_CLOSE)
	
	-- Set Header Colors
	TitanPanelPetXpOptions_ModeBg:SetBackdropColor(0,0,0,0.6)
	TitanPanelPetXpOptions_BarBg:SetBackdropColor(0,0,0,0.6)
	TitanPanelPetXpOptions_TooltipBg:SetBackdropColor(0,0,0,0.6)
	TitanPanelPetXpOptions_ModeText:SetTextColor(1,1,1)
	TitanPanelPetXpOptions_BarText:SetTextColor(1,1,1)
	TitanPanelPetXpOptions_TooltipText:SetTextColor(1,1,1)

	-- Set default values
	TitanPanelPetXpOptions_Experience:SetChecked(TitanGetVar(TITAN_PETXP_ID, "Experience"))
	TitanPanelPetXpOptions_Level:SetChecked(TitanGetVar(TITAN_PETXP_ID, "Level"))
	TitanPanelPetXpOptions_Food:SetChecked(TitanGetVar(TITAN_PETXP_ID, "Food"))
	TitanPanelPetXpOptions_Loyalty:SetChecked(TitanGetVar(TITAN_PETXP_ID, "Loyalty"))
	TitanPanelPetXpOptions_TrainingPoints:SetChecked(TitanGetVar(TITAN_PETXP_ID, "TrainingPoints"))
	TitanPanelPetXpOptions_Health:SetChecked(TitanGetVar(TITAN_PETXP_ID, "Health"))
	TitanPanelPetXpOptions_Damage:SetChecked(TitanGetVar(TITAN_PETXP_ID, "Damage"))
	TitanPanelPetXpOptions_Armor:SetChecked(TitanGetVar(TITAN_PETXP_ID, "Armor"))
	TitanPanelPetXpOptions_Stats:SetChecked(TitanGetVar(TITAN_PETXP_ID, "Stats"))
	
	TitanPanelPetXpOptions_Percent:SetChecked(0)
	TitanPanelPetXpOptions_Raw:SetChecked(0)
	TitanPanelPetXpOptions_Both:SetChecked(0)
	if TitanGetVar(TITAN_PETXP_ID, "Mode") == 0 then
		TitanPanelPetXpOptions_Percent:SetChecked(1)
	elseif TitanGetVar(TITAN_PETXP_ID, "Mode") == 1 then
		TitanPanelPetXpOptions_Raw:SetChecked(1)
	else
		TitanPanelPetXpOptions_Both:SetChecked(1)
	end
	
	TitanPanelPetXpOptions_Color:SetChecked(TitanGetVar(TITAN_PETXP_ID, "Color"))
	TitanPanelPetXpOptions_BarLevel:SetChecked(TitanGetVar(TITAN_PETXP_ID, "BarLevel"))
end