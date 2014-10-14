CharactersViewer.PaperDollFrame = {}

CharactersViewer.PaperDollFrame.OnLoad = function ()
	CVCharacterAttackFrameLabel:SetText(TEXT(MELEE_ATTACK));
	CVCharacterDamageFrameLabel:SetText(TEXT(DAMAGE_COLON));
	CVCharacterAttackPowerFrameLabel:SetText(TEXT(ATTACK_POWER_COLON));
	CVCharacterRangedAttackFrameLabel:SetText(TEXT(RANGED_ATTACK));
	CVCharacterRangedDamageFrameLabel:SetText(TEXT(DAMAGE_COLON));
	CVCharacterRangedAttackPowerFrameLabel:SetText(TEXT(ATTACK_POWER_COLON));
	CVCharacterArmorFrameLabel:SetText(TEXT(ARMOR_COLON));
end;

CharactersViewer.PaperDollFrame.OnShow = function ()
	CharactersViewer.PaperDollFrame.drawPaperdoll();
end

CharactersViewer.PaperDollFrame.drawPaperdoll = function ()
	-- Level / Honor
	CharactersViewer.PaperDollFrame.SetLevel();
	CharactersViewer.PaperDollFrame.SetGuild();
	CharactersViewer.PaperDollFrame.SetStats();  
	CharactersViewer.PaperDollFrame.SetResistances();
	CharactersViewer.PaperDollFrame.SetArmor();
	CharactersViewer.PaperDollFrame.SetDamage();
	CharactersViewer.PaperDollFrame.SetAttackPower();
	CharactersViewer.PaperDollFrame.SetAttackBothHands();
	CharactersViewer.PaperDollFrame.SetRangedAttack();
	CharactersViewer.PaperDollFrame.SetRangedDamage();
	CharactersViewer.PaperDollFrame.SetRangedAttackPower();
	CharactersViewer.PaperDollFrame.SetGenericInfo();
	---- Todo: There is no defence display by default, but blizz lua code contain stuff for it, gotta reuse it

	--[[
		if ( UnitHasRelicSlot("player") ) then
		CharacterAmmoSlot:Hide();
	else
		CharacterAmmoSlot:Show();
	end--]]
	-- Equipments
	local index, slotname, item;
	for index = 0, 19 do
		slotname = "CVCharacter" .. CharactersViewer["CP"]["Slot"][index];
		SetItemButtonCount( getglobal(slotname.."Slot"), nil );
		item = CharactersViewer.Api.GetInventoryItem(index, true);
		if ( item ~= nil and item["itemTexture"] ~= nil) then
			getglobal(slotname .. "SlotIconTexture"):SetTexture(item["itemTexture"]);
			if ( item ~= nil and item["itemCount"] ~= nil and item["itemCount"] > 1) then
				SetItemButtonCount( getglobal(slotname.."Slot"), tonumber(item["itemCount"]) );
			end
		else
			getglobal(slotname .. "SlotIconTexture"):SetTexture(CharactersViewer.constant.inventorySlot.Texture[index]);
		end
	end
	
	-- Stats
end;

CharactersViewer.PaperDollFrame.SetLevel = function()
	-- level race class
	local level = CharactersViewer.Api.GetParam("level");
	local race = CharactersViewer.Api.GetParam("race")
	local class = CharactersViewer.Api.GetParam("class");
	local server = CharactersViewer.Api.GetParam("server");
	local name = CharactersViewer.Api.GetParam("name");
	local location = CharactersViewer.Api.GetParam("location") ;

	CVCharacterNameServerText:SetText(format(TEXT(CV_PLAYERSERVER), name, server));
	CVCharacterLevelText:SetText(format(TEXT(PLAYER_LEVEL), level, race, class, name));
	-- .. " - " .. CharactersViewer.Api.GetParam("location")
end;

CharactersViewer.PaperDollFrame.SetGuild = function()
	local guildName;
	local rank;
	guildName = CharactersViewer.Api.GetParam("guildname");
	title = CharactersViewer.Api.GetParam("guildtitle")
	rank = CharactersViewer.Api.GetParam("guildrank");
	
	if ( guildName ) then
		CVCharacterGuildText:Show();
		CVCharacterGuildText:SetText(format(TEXT(GUILD_TITLE_TEMPLATE), title, guildName));
		-- Set it for the honor frame while we're at it
		--CVHonorGuildText:Show();
		--CVHonorGuildText:SetText(format(TEXT(GUILD_TITLE_TEMPLATE), title, guildName));
	else
		CVCharacterGuildText:Hide();

		--CVHonorGuildText:Hide();
	end
end;

CharactersViewer.PaperDollFrame.SetStats = function()
	for i=1, NUM_STATS, 1 do
		local label = getglobal("CVCharacterStatFrame"..i.."Label");
		local text = getglobal("CVCharacterStatFrame"..i.."StatText");
		local frame = getglobal("CVCharacterStatFrame"..i);
		local stat;
		local effectiveStat;
		local posBuff;
		local negBuff;
		label:SetText(TEXT(getglobal("SPELL_STAT"..(i-1).."_NAME"))..":");
		stat, effectiveStat, posBuff, negBuff = CharactersViewer.Api.splitstats( CharactersViewer.Api.GetParam(CharactersViewer["CP"]["StatsLowerCase"][i]) )
		
		-- Set the tooltip text
		local tooltipText = HIGHLIGHT_FONT_COLOR_CODE..getglobal("SPELL_STAT"..(i-1).."_NAME").." ";

		if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
			text:SetText(effectiveStat);
			frame.tooltip = tooltipText..effectiveStat..FONT_COLOR_CODE_CLOSE;
		else 
			tooltipText = tooltipText..effectiveStat;
			if ( posBuff > 0 or negBuff < 0 ) then
				tooltipText = tooltipText.." ("..(stat - posBuff - negBuff)..FONT_COLOR_CODE_CLOSE;
			end
			if ( posBuff > 0 ) then
				tooltipText = tooltipText..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..posBuff..FONT_COLOR_CODE_CLOSE;
			end
			if ( negBuff < 0 ) then
				tooltipText = tooltipText..RED_FONT_COLOR_CODE.." "..negBuff..FONT_COLOR_CODE_CLOSE;
			end
			if ( posBuff > 0 or negBuff < 0 ) then
				tooltipText = tooltipText..HIGHLIGHT_FONT_COLOR_CODE..")"..FONT_COLOR_CODE_CLOSE;
			end
			frame.tooltip = tooltipText;

			-- If there are any negative buffs then show the main number in red even if there are
			-- positive buffs. Otherwise show in green.
			if ( negBuff < 0 ) then
				text:SetText(RED_FONT_COLOR_CODE..effectiveStat..FONT_COLOR_CODE_CLOSE);
			else
				text:SetText(GREEN_FONT_COLOR_CODE..effectiveStat..FONT_COLOR_CODE_CLOSE);
			end
		end
	end
end;

CharactersViewer.PaperDollFrame.SetResistances = function()
	for i=1, NUM_RESISTANCE_TYPES, 1 do
		local resistance;
		local positive;
		local negative;
		local base;
		local text = getglobal("CVMagicResText"..i);
		local frame = getglobal("CVMagicResFrame"..i);
		
		base, resistance, positive, negative = CharactersViewer.Api.splitstats( CharactersViewer.Api.GetParam( "resist" .. CharactersViewer["CP"]["ResistLowerCase"][i]) );

		local resistanceName = getglobal("RESISTANCE"..(frame:GetID()).."_NAME");
		frame.tooltip = resistanceName.." "..resistance;

		-- resistances can now be negative. Show Red if negative, Green if positive, white otherwise
		if( abs(negative) > positive ) then
			text:SetText(RED_FONT_COLOR_CODE..resistance..FONT_COLOR_CODE_CLOSE);
		elseif( abs(negative) == positive ) then
			text:SetText(resistance);
		else
			text:SetText(GREEN_FONT_COLOR_CODE..resistance..FONT_COLOR_CODE_CLOSE);
		end

		if ( positive ~= 0 or negative ~= 0 ) then
			-- Otherwise build up the formula
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
		unitLevel = max(unitLevel, 20);
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
		frame.tooltipSubtext = format(RESISTANCE_TOOLTIP_SUBTEXT, getglobal("RESISTANCE_TYPE"..frame:GetID()), unitLevel, resistanceLevel);
	end
end;

CharactersViewer.PaperDollFrame.SetArmor = function(unit, prefix)
	if ( not unit ) then
		unit = "player";
	end
	if ( not prefix ) then
		prefix = "CVCharacter";
	end
	local base, effectiveArmor, posBuff = CharactersViewer.Api.splitstats( CharactersViewer.Api.GetParam("armor") ) ;
	local armor = 0;
	local negBuff =0;
	if ( posBuff == nil ) then
		posBuff = 0;
	end 
	if ( negBuff == nil ) then
		negBuff = 0;
	end
	
	local totalBufs = posBuff + negBuff;

	local frame = getglobal(prefix.."ArmorFrame");
	local text = getglobal(prefix.."ArmorFrameStatText");

	CVPaperDollFormatStat(ARMOR, base, posBuff, negBuff, frame, text);
	local playerLevel = UnitLevel(unit);
	local armorReduction = effectiveArmor/((85 * playerLevel) + 400);
	armorReduction = 100 * (armorReduction/(armorReduction + 1));
	
	frame.tooltipSubtext = format(ARMOR_TOOLTIP, playerLevel, armorReduction);
end;

CharactersViewer.PaperDollFrame.SetDamage = function (unit, prefix)
	if ( not unit ) then
		unit = "player";
	end
	if ( not prefix ) then
		prefix = "CVCharacter";
	end

	local damageText = getglobal(prefix.."DamageFrameStatText");
	local damageFrame = getglobal(prefix.."DamageFrame");

	local speed = CharactersViewer.Api.GetParam("attackspeed1")
	local offhandSpeed = CharactersViewer.Api.GetParam("attackspeed2")
	
	local minDamage;
	local maxDamage; 
	local minOffHandDamage;
	local maxOffHandDamage; 
	local physicalBonusPos;
	local physicalBonusNeg;
	local percent;
	minDamage, maxDamage = CharactersViewer.Api.splitstats( CharactersViewer.Api.GetParam("damagerange1") ) ;
	minOffHandDamage, maxOffHandDamage = CharactersViewer.Api.splitstats( CharactersViewer.Api.GetParam("damagerange2") ) ;
	physicalBonusPos = 0;
	physicalBonusNeg = 0;
	percent = 1;
	
	local displayMin = max(floor(minDamage),1);
	local displayMax = max(ceil(maxDamage),1);

	minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
	maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;

	local baseDamage = (minDamage + maxDamage) * 0.5;
	local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
	local totalBonus = (fullDamage - baseDamage);
	local damagePerSecond = (max(fullDamage,1) / speed);
	local damageTooltip = max(floor(minDamage),1).." - "..max(ceil(maxDamage),1);
	
	local colorPos = "|cff20ff20";
	local colorNeg = "|cffff2020";
	if ( totalBonus == 0 ) then
		if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
			damageText:SetText(displayMin.." - "..displayMax);	
		else
			damageText:SetText(displayMin.."-"..displayMax);
		end
	else
		
		local color;
		if ( totalBonus > 0 ) then
			color = colorPos;
		else
			color = colorNeg;
		end
		if ( ( displayMin < 100 ) and ( displayMax < 100 ) ) then 
			damageText:SetText(color..displayMin.."-"..displayMax.."|r");	
		else
			damageText:SetText(color..displayMin.." - "..displayMax.."|r");
		end
		if ( physicalBonusPos > 0 ) then
			damageTooltip = damageTooltip..colorPos.." +"..physicalBonusPos.."|r";
		end
		if ( physicalBonusNeg < 0 ) then
			damageTooltip = damageTooltip..colorNeg.." "..physicalBonusNeg.."|r";
		end
		if ( percent > 1 ) then
			damageTooltip = damageTooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
		elseif ( percent < 1 ) then
			damageTooltip = damageTooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
		end
		
	end
	damageFrame.damage = damageTooltip;
	damageFrame.attackSpeed = speed;
	damageFrame.dps = damagePerSecond;
	
	-- If there's an offhand speed then add the offhand info to the tooltip
	if ( offhandSpeed ) then
		minOffHandDamage = (minOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;
		maxOffHandDamage = (maxOffHandDamage / percent) - physicalBonusPos - physicalBonusNeg;

		local offhandBaseDamage = (minOffHandDamage + maxOffHandDamage) * 0.5;
		local offhandFullDamage = (offhandBaseDamage + physicalBonusPos + physicalBonusNeg) * percent;
		local offhandDamagePerSecond = (max(offhandFullDamage,1) / offhandSpeed);
		local offhandDamageTooltip = max(floor(minOffHandDamage),1).." - "..max(ceil(maxOffHandDamage),1);
		if ( physicalBonusPos > 0 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorPos.." +"..physicalBonusPos.."|r";
		end
		if ( physicalBonusNeg < 0 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorNeg.." "..physicalBonusNeg.."|r";
		end
		if ( percent > 1 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
		elseif ( percent < 1 ) then
			offhandDamageTooltip = offhandDamageTooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
		end
		damageFrame.offhandDamage = offhandDamageTooltip;
		damageFrame.offhandAttackSpeed = offhandSpeed;
		damageFrame.offhandDps = offhandDamagePerSecond;
	else
		damageFrame.offhandAttackSpeed = nil;
	end
	
end;

CharactersViewer.PaperDollFrame.SetAttackPower = function (unit, prefix)
	if ( not unit ) then
		unit = "player";
	end
	if ( not prefix ) then
		prefix = "CVCharacter";
	end
	
	local base, total, posBuff, negBuff = CharactersViewer.Api.splitstats( CharactersViewer.Api.GetParam("attackpower") ) ;

	local frame = getglobal(prefix.."AttackPowerFrame"); 
	local text = getglobal(prefix.."AttackPowerFrameStatText");

	CVPaperDollFormatStat(MELEE_ATTACK_POWER, base, posBuff, negBuff, frame, text);
	frame.tooltipSubtext = format(MELEE_ATTACK_POWER_TOOLTIP, max((base+posBuff+negBuff), 0)/ATTACK_POWER_MAGIC_NUMBER);
end;

CharactersViewer.PaperDollFrame.SetRangedAttack = function(unit, prefix)
	if ( not unit ) then
		unit = "player";
	elseif ( unit == "pet" ) then
		return;
	end
	if ( not prefix ) then
		prefix = "CVCharacter";
	end

	local hasRelic = CharactersViewer.Api.GetParam("hasrelic");
	local rangedAttackBase, rangedAttackMod = CharactersViewer.Api.splitstats( CharactersViewer.Api.GetParam("rangedattackrating") ) ;
	if ( rangedAttackMod == nil ) then
		rangedAttackMod = 0;
	end
	local frame = getglobal(prefix.."RangedAttackFrame"); 
	local text = getglobal(prefix.."RangedAttackFrameStatText");

	-- If no ranged texture then set stats to n/a
	local item = CharactersViewer.Api.GetInventoryItem(18, true);
	local rangedTexture = nil;
	if ( item["itemTexture"] ~= nil) then
		rangedTexture = item["itemTexture"];
	end
	
	local oldValue = CVPaperDollFrame.noRanged;
	if ( CharactersViewer.Api.GetParam("hasranged") == true) then
		CVPaperDollFrame.noRanged = nil;
	else
		text:SetText(NOT_APPLICABLE);
		CVPaperDollFrame.noRanged = 1;
		frame.tooltip = nil;
	end
	-- See if value has changed set the attack damage and power
	if ( oldValue ~= CVPaperDollFrame.noRanged ) then
		CharactersViewer.PaperDollFrame.SetRangedAttackPower();
		CharactersViewer.PaperDollFrame.SetRangedDamage();
	end
	if ( not rangedTexture or hasRelic ) then
		return;
	end
	
	if( rangedAttackMod == 0 ) then
		text:SetText(rangedAttackBase);
		frame.tooltip = nil;
	else
		local color = RED_FONT_COLOR_CODE;
		if( rangedAttackMod > 0 ) then
			color = GREEN_FONT_COLOR_CODE;
			frame.tooltip = rangedAttackBase..color.." +"..rangedAttackMod..FONT_COLOR_CODE_CLOSE;
		else
			frame.tooltip = rangedAttackBase..color.." "..rangedAttackMod..FONT_COLOR_CODE_CLOSE;
		end
		text:SetText(color..(rangedAttackBase + rangedAttackMod)..FONT_COLOR_CODE_CLOSE);
	end
end;


CharactersViewer.PaperDollFrame.SetRangedDamage = function(unit, prefix)
	if ( not unit ) then
		unit = "player";
	elseif ( unit == "pet" ) then
		return;
	end
	if ( not prefix ) then
		prefix = "CVCharacter";
	end

	local damageText = getglobal(prefix.."RangedDamageFrameStatText");
	local damageFrame = getglobal(prefix.."RangedDamageFrame");

	-- If no ranged attack then set to n/a
	if ( CVPaperDollFrame.noRanged ) then
		damageText:SetText(NOT_APPLICABLE);
		damageFrame.damage = nil;
		return;
	end

	--local temp1, temp2, temp3, temp4, physicalBonusPos, physicalBonusNeg, percent = UnitDamage(unit);
	local physicalBonusPos = 0;
	local physicalBonusNeg = 0; 
	local percent = 1;
	local rangedAttackSpeed = CharactersViewer.Api.GetParam("rangedattackspeed");
	local minDamage, maxDamage = CharactersViewer.Api.splitstats( CharactersViewer.Api.GetParam("rangeddamage") ) ;
	local displayMin = max(floor(minDamage),1);
	local displayMax = max(ceil(maxDamage),1);
	minDamage = (minDamage / percent) - physicalBonusPos - physicalBonusNeg;
	maxDamage = (maxDamage / percent) - physicalBonusPos - physicalBonusNeg;

	local baseDamage = (minDamage + maxDamage) * 0.5;
	local fullDamage = (baseDamage + physicalBonusPos + physicalBonusNeg) * percent;
	local totalBonus = (fullDamage - baseDamage);
	local damagePerSecond  = "";
	if (rangedAttackSpeed ~= nil and rangedAttackSpeed ~= 0) then
		damagePerSecond = (max(fullDamage,1) / rangedAttackSpeed);
	end
	local tooltip = max(floor(minDamage),1).."-"..max(ceil(maxDamage),1);

	if ( totalBonus == 0 ) then
		damageText:SetText(displayMin.." - "..displayMax);
	else
		local colorPos = "|cff20ff20";
		local colorNeg = "|cffff2020";
		local color;
		if ( totalBonus > 0 ) then
			color = colorPos;
		else
			color = colorNeg;
		end
		damageText:SetText(color..displayMin.." - "..displayMax.."|r");
		if ( physicalBonusPos > 0 ) then
			tooltip = tooltip..colorPos.." +"..physicalBonusPos.."|r";
		end
		if ( physicalBonusNeg < 0 ) then
			tooltip = tooltip..colorNeg.." "..physicalBonusNeg.."|r";
		end
		if ( percent > 1 ) then
			tooltip = tooltip..colorPos.." x"..floor(percent*100+0.5).."%|r";
		elseif ( percent < 1 ) then
			tooltip = tooltip..colorNeg.." x"..floor(percent*100+0.5).."%|r";
		end
		damageFrame.tooltip = tooltip.." "..format(TEXT(DPS_TEMPLATE), damagePerSecond);
	end
	damageFrame.attackSpeed = rangedAttackSpeed;
	damageFrame.damage = tooltip;
	damageFrame.dps = damagePerSecond;
end;

CharactersViewer.PaperDollFrame.SetRangedAttackPower = function(unit, prefix)
	if ( not unit ) then
		unit = "player";
	elseif ( unit == "pet" ) then
		return;
	end
	if ( not prefix ) then
		prefix = "CVCharacter";
	end
	local frame = getglobal(prefix.."RangedAttackPowerFrame"); 
	local text = getglobal(prefix.."RangedAttackPowerFrameStatText");
	
	-- If no ranged attack then set to n/a
	if ( CVPaperDollFrame.noRanged ) then
		text:SetText(NOT_APPLICABLE);
		frame.tooltip = nil;
		return;
	end
	if ( (CVPaperDollFrame.noRanged ~= true and CharactersViewer.Api.GetParam("rangedttackpower") == nil) or CharactersViewer.Api.GetParam("haswandequipped") == true  ) then 
	--CharactersViewer.Api.GetParam("haswandequipped") == 1 or CharactersViewer.Api.GetParam("haswandequipped") == nil) then
		text:SetText("--");
		frame.tooltip = nil;
		return;
	end

	local base = CharactersViewer.Api.GetParam("rangedttackpower");
	local posBuff = 0;
	local negBuff = 0;
	
	CVPaperDollFormatStat(RANGED_ATTACK_POWER, base, posBuff, negBuff, frame, text);
	frame.tooltipSubtext = format(RANGED_ATTACK_POWER_TOOLTIP, base/ATTACK_POWER_MAGIC_NUMBER);
end;

CVPaperDollFormatStat = function(name, base, posBuff, negBuff, frame, textString)
	local effective = max(0,base + posBuff + negBuff);
	local text = HIGHLIGHT_FONT_COLOR_CODE..name.." "..effective;
	if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
		text = text..FONT_COLOR_CODE_CLOSE;
		textString:SetText(effective);
	else 
		if ( posBuff > 0 or negBuff < 0 ) then
			text = text.." ("..base..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 ) then
			text = text..FONT_COLOR_CODE_CLOSE..GREEN_FONT_COLOR_CODE.."+"..posBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( negBuff < 0 ) then
			text = text..RED_FONT_COLOR_CODE.." "..negBuff..FONT_COLOR_CODE_CLOSE;
		end
		if ( posBuff > 0 or negBuff < 0 ) then
			text = text..HIGHLIGHT_FONT_COLOR_CODE..")"..FONT_COLOR_CODE_CLOSE;
		end

		-- if there is a negative buff then show the main number in red, even if there are
		-- positive buffs. Otherwise show the number in green
		if ( negBuff < 0 ) then
			textString:SetText(RED_FONT_COLOR_CODE..effective..FONT_COLOR_CODE_CLOSE);
		else
			textString:SetText(GREEN_FONT_COLOR_CODE..effective..FONT_COLOR_CODE_CLOSE);
		end
	end
	frame.tooltip = text;
end;

CharactersViewer.PaperDollFrame.CharacterDamageFrame_OnEnter =function()
	-- Main hand weapon
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(INVTYPE_WEAPONMAINHAND, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(ATTACK_SPEED_COLON, format("%.2f", this.attackSpeed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(DAMAGE_COLON, this.damage, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(DAMAGE_PER_SECOND, format("%.1f", this.dps), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	-- Check for offhand weapon
	if ( this.offhandAttackSpeed ) then
		GameTooltip:AddLine("\n");
		GameTooltip:AddLine(INVTYPE_WEAPONOFFHAND, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddDoubleLine(ATTACK_SPEED_COLON, format("%.2f", this.offhandAttackSpeed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddDoubleLine(DAMAGE_COLON, this.offhandDamage, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddDoubleLine(DAMAGE_PER_SECOND, format("%.1f", this.offhandDps), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end
	GameTooltip:Show();
end

function CharactersViewer.PaperDollFrame.CharacterRangedDamageFrame_OnEnter()
	if ( not this.damage ) then
		return;
	end
	GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	GameTooltip:SetText(INVTYPE_RANGED, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(ATTACK_SPEED_COLON, format("%.2f", this.attackSpeed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(DAMAGE_COLON, this.damage, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(DAMAGE_PER_SECOND, format("%.1f", this.dps), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:Show();
end

CharactersViewer.PaperDollFrame.SetAttackBothHands = function(unit, prefix)
	if ( not unit ) then
		unit = "player";
	end
	if ( not prefix ) then
		prefix = "CVCharacter";
	end
	-- FIXME: The offhand stats aren't displayed yet.
	-- Flisher: Got to analyse the behavior
	local mainHandAttackBase, mainHandAttackMod = UnitAttackBothHands(unit);

	local frame = getglobal(prefix.."AttackFrame"); 
	local text = getglobal(prefix.."AttackFrameStatText");

	if( mainHandAttackMod == 0 ) then
		text:SetText(mainHandAttackBase);
		frame.tooltip = nil;
	else
		local color = RED_FONT_COLOR_CODE;
		if( mainHandAttackMod > 0 ) then
			color = GREEN_FONT_COLOR_CODE;
			frame.tooltip = mainHandAttackBase..color.." +"..mainHandAttackMod..FONT_COLOR_CODE_CLOSE;
		else
			frame.tooltip = mainHandAttackBase..color.." "..mainHandAttackMod..FONT_COLOR_CODE_CLOSE;
		end
		text:SetText(color..(mainHandAttackBase + mainHandAttackMod)..FONT_COLOR_CODE_CLOSE);
	end
end;

CharactersViewer.PaperDollFrame.OnHide = function ()
end;

CharactersViewer.PaperDollFrame.SetGenericInfo = function ()
	CVCharacterHealthLabel:SetText(HEALTH .. ":");
	CVCharacterHealthStatText:SetText( CharactersViewer.PaperDollFrame.GetDisplayedValue( CharactersViewer.Api.GetParam("health") ) );

	CVCharacterManaLabel:SetText( CharactersViewer.PaperDollFrame.GetDisplayedValue( CharactersViewer.Api.GetParam("powertype") ));
	CVCharacterManaStatText:SetText( CharactersViewer.PaperDollFrame.GetDisplayedValue( CharactersViewer.Api.GetParam("mana") ));

	CVCharacterCritLabel:SetText(CHARACTERSVIEWER_CRIT );
	CVCharacterCritStatText:SetText( CharactersViewer.PaperDollFrame.GetDisplayedValue( CharactersViewer.Api.GetParam("crit") .. "%"));
	
	CVCharacterBlockLabel:SetText(BLOCK .. ":");
	CVCharacterBlockStatText:SetText( CharactersViewer.PaperDollFrame.GetDisplayedValue( CharactersViewer.Api.GetParam("block") .. "%" ));
	
	CVCharacterDodgeLabel:SetText(DODGE .. ":");
	CVCharacterDodgeStatText:SetText( CharactersViewer.PaperDollFrame.GetDisplayedValue( CharactersViewer.Api.GetParam("dodge") .. "%" ));
	
	CVCharacterParryLabel:SetText(PARRY);
	CVCharacterParryStatText:SetText( CharactersViewer.PaperDollFrame.GetDisplayedValue( CharactersViewer.Api.GetParam("parry")  .. "%"));

	CVCharacterDefLabel:SetText(DEFENSE_COLON);
	CVCharacterDefStatText:SetText( CharactersViewer.PaperDollFrame.GetDisplayedValue( CharactersViewer.Api.GetParam("defense") ));
end;

CharactersViewer.PaperDollFrame.GetDisplayedValue = function(param)
	if ( param ~= nil ) then
		return param;
	else
		return "--";
	end
end;

CharactersViewer.PaperDollFrame.BagToggle_Button_OnEnter = function()
	 ShowUIPanel(GameTooltip);	
	 GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	 GameTooltip:SetText(CHARACTERSVIEWER_TOOLTIP_BAGRESET);
end;

CharactersViewer.PaperDollFrame.BankToggle_Button_OnEnter = function()
	 ShowUIPanel(GameTooltip);	
	 GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	 GameTooltip:SetText(CHARACTERSVIEWER_TOOLTIP_BANK);
end;