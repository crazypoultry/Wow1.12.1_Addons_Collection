local L = AceLibrary("AceLocale-2.2"):new("ag_UnitFrames")

-- UTILITY FUNCTIONS

function aUF:UtilFactionColors(unit)
	local r, g, b = 0,0,0
	local a = 0.5
	if ( UnitPlayerControlled(unit) ) then
		if ( UnitCanAttack(unit, "player") ) then
			if ( not UnitCanAttack("player", unit) ) then
				r = self.ManaColor[0].r
				g = self.ManaColor[0].g
				b = self.ManaColor[0].b
			else
				r = self.ManaColor[1].r
				g = self.ManaColor[1].g
				b = self.ManaColor[1].b
			end
		elseif ( UnitCanAttack("player", unit) ) then
				r = self.ManaColor[3].r
				g = self.ManaColor[3].g
				b = self.ManaColor[3].b
		elseif ( UnitIsPVP(unit) ) then
			r = self.HealthColor.r
			g = self.HealthColor.g
			b = self.HealthColor.b
		else
			r = self.ManaColor[0].r
			g = self.ManaColor[0].g
			b = self.ManaColor[0].b
		end
	elseif ( UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) ) or UnitIsDead(unit) then
		r = 0.5
		g = 0.5
		b = 0.5
	else
		local reaction = UnitReaction(unit, "player")
		if ( reaction ) then
			if reaction == 5 or reaction == 6 or reaction == 7 then
				r = self.HealthColor.r
				g = self.HealthColor.g
				b = self.HealthColor.b
			elseif reaction == 4 then
				r = self.ManaColor[3].r
				g = self.ManaColor[3].g
				b = self.ManaColor[3].b
			elseif reaction == 1 or reaction == 2 or reaction == 3 then
				r = self.ManaColor[1].r
				g = self.ManaColor[1].g
				b = self.ManaColor[1].b
			else
				r = UnitReactionColor[reaction].r
				g = UnitReactionColor[reaction].g
				b = UnitReactionColor[reaction].b
			end
		end
	end
	return {r = r,g = g,b = b}
end

function aUF:GiveHex(r,g,b)
	r=r*255
	g=g*255
	b=b*255
	return string.format("|cff%2x%2x%2x", r, g, b) or ""
end

function aUF:GetRaidColors(class)
	if self.RaidColors[class] then
		return self.RaidColors[class]
	else
		return "|r"
	end
end

function aUF:formatLargeValue(value)
	if value < 9999 then
		return value
	elseif value < 999999 then
		return string.format("%.1fk", value / 1000)
	else
		return string.format("%.2fm", value / 1000000)
	end
end

function aUF:TargetGetMobType(unit)
	local classification = UnitClassification(unit)
	if ( classification == "worldboss" ) then
		return L["Boss"]
	elseif ( classification == "rareelite" ) then
		return L["Rare-Elite"]
	elseif ( classification == "elite" ) then
		return L["Elite"]
	elseif ( classification == "rare" ) then
		return L["Rare"]
	else
		return nil
	end
end

function aUF:UnitDebuff(unit,id,filter)
	local aura, count, t = UnitDebuff(unit,id)
	if filter == 1 then
		local _, eClass = UnitClass("player")
		if ( self.CanDispel[eClass] and self.CanDispel[eClass][t] == true or ( eClass == "PRIEST" and (aura == "Interface\\Icons\\Spell_Holy_AshesToAshes")) ) then
			return aura, count or 0, t
		end
	else
		return aura, count or 0, t
	end
end

function aUF:tonum(val, base)
	return tonumber((val or 0), base) or 0
end

function aUF:round(num)
	return floor(aUF:tonum(num)+.5)
end
