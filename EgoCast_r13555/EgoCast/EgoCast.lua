-- EgoCast is based on SuperSelfCast
-- with a slight modifcation and the fact that it's Ace2

EgoCast = AceLibrary("AceAddon-2.0"):new("AceHook-2.0")

function EgoCast:OnEnable()
	SetCVar("autoSelfCast", 0)
	self:Hook("UseAction")
end

function EgoCast:UseAction( id, type, me )
	self.hooks["UseAction"](id, type, me)
	if SpellIsTargeting() and SpellCanTargetUnit("player") then
		if UnitExists("target") and not UnitCanAttack("player","target") and not UnitCanAttack("target","player") then
				UIErrorsFrame:AddMessage(ERR_SPELL_OUT_OF_RANGE, 1.0, 0.1, 0.1, 1.0, 1)
				SpellStopTargeting()
		else
			SpellTargetUnit("player")		
		end
	end
end
