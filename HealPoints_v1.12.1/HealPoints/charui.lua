
HealPointsCharUI = { };

function HealPointsCharUI:setTooltip()
	if (HealPoints.ENABLED) then
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		GameTooltip:SetText("HealPoints "..format("%5.0f", this.healPoints),
								HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddDoubleLine("Mana regeneration while casting/5s:",
										format("%5.0f", this.manaRegenCasting),
										NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b,
										HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddDoubleLine("Normal mana regeneration/5s:",
										format("%5.0f", this.manaRegenNormal),
										NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b,
										HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddDoubleLine("+Healing:",
										format("%5.0f", this.healing),
										NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b,
										HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddDoubleLine("Chance to crit with healing spells:",
										format("%.2f%%", this.spellCrit),
										NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b,
										HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		GameTooltip:AddLine("Hint: Click to show the HealPoints calculator",
								GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
		GameTooltip:Show();
	end
end

function HealPointsCharUI:setStats(healPoints, manaRegenCasting, manaRegenNormal, healing, spellCrit)
	local label = getglobal("HealPoints_CharFrameLabel");
	local text = getglobal("HealPoints_CharFrameStatText");
	local frame = getglobal("HealPoints_CharFrame");

	frame.healPoints = healPoints;
	frame.manaRegenCasting = manaRegenCasting;
	frame.manaRegenNormal = manaRegenNormal;
	frame.healing = healing;
	frame.spellCrit = spellCrit;

	label:SetText("HealPoints:");
	text:SetText(format("%5.0f", healPoints));
end
