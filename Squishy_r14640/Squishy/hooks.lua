function Squishy:CastSpell(spellId, spellbookTabNum)
	self.hooks["CastSpell"](spellId, spellbookTabNum)
	Squishy_Tooltip:SetSpell(spellId, spellbookTabNum)
	local spellName = Squishy_TooltipTextLeft1:GetText()
	if SpellIsTargeting() then 
		self.spell = spellName
	elseif UnitExists("target") then
		self.spell = spellName
		self.target = UnitName("target")
	end
end


function Squishy:CastSpellByName(a1, a2)
	self.hooks["CastSpellByName"](a1, a2)
	local _, _, spellName = string.find(a1, "^([^%(]+)");
	if spellName then
		if SpellIsTargeting() then
			self.spell = spellName
		else
			self.spell = spellName
			self.target = UnitName("target")
		end
	end
end


function Squishy:UseAction(a1, a2, a3)
	Squishy_Tooltip:SetAction(a1)
	local spellName = Squishy_TooltipTextLeft1:GetText()
	self.spell = spellName
	self.hooks["UseAction"](a1, a2, a3)
	if GetActionText(a1) or not self.spell then return end
	if SpellIsTargeting() then return
	elseif a3 then
		self.target = UnitName("player")
	elseif UnitExists("target") then
		self.target = UnitName("target")
	end
end


function Squishy:SpellTargetUnit(a1)
	local shallTargetUnit
	if SpellIsTargeting() then
		shallTargetUnit = true
	end
	self.hooks["SpellTargetUnit"](a1)
	if shallTargetUnit and self.spell and not SpellIsTargeting() then
		self.target = UnitName(a1)
	end
end


function Squishy:SpellStopTargeting()
	self.hooks["SpellStopTargeting"]()
	self.spell = nil
	self.target = nil
end


function Squishy:TargetUnit(a1)
	self.hooks["TargetUnit"](a1)
	if self.spell and UnitExists(a1) then
		self.target = UnitName(a1)
	end
end


function Squishy:SquishyOnMouseDown()
	if self.spell and UnitName("mouseover") then
		self.target = UnitName("mouseover")
	elseif self.spell and GameTooltipTextLeft1:IsVisible() then
		local _, _, name = string.find(GameTooltipTextLeft1:GetText(), "^Corpse of (.+)$")
		if ( name ) then
			self.target = name;
		end
	end
	self.hooks[WorldFrame]["OnMouseDown"]()
end
