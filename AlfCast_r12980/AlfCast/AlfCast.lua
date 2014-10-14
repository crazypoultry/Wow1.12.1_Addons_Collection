-- AlfCast is based completely on EgoCast which is based on SuperSelfCast
-- http://svn.wowace.com/wowace/trunk/EgoCast/

AlfCast = AceLibrary("AceAddon-2.0"):new("AceHook-2.0")

function AlfCast:OnEnable()
	SetCVar("autoSelfCast", 0)
	if EgoCast then 
		DisableAddOn("AlfCast")
		return 
	else
		self:Hook("UseAction")
	end
end

function AlfCast:OnDisable()
	self:UnhookAll()
end

function AlfCast:UseAction( id, type, me )
	if ( IsAltKeyDown() ) then
		self.hooks["UseAction"].orig(id, type, me)
		if SpellIsTargeting() and SpellCanTargetUnit("player") then
			if UnitExists("target") and not UnitCanAttack("player","target") and not UnitCanAttack("target","player") then
					UIErrorsFrame:AddMessage(ERR_SPELL_OUT_OF_RANGE, 1.0, 0.1, 0.1, 1.0, 1)
					SpellStopTargeting()
			else
				SpellTargetUnit("player")
			end
		end
	else
		self.hooks["UseAction"](id, type, me);
	end
end