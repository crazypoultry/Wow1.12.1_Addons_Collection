ZHunterMod_Saved["ZHunterAIPetAttack"] = {}
ZHunterMod_Saved["ZHunterAIPetAttack"]["petattack"] = nil

function ZPetAttackOrReturn()
	if not UnitExists("target") or UnitIsUnit("target", "pettarget") then
		PetFollow()
	else
		ZHunterAIPetAttack_PetAttack()
	end
end

ZHunterAIPetAttack_PetAttack = PetAttack
function PetAttack()
	if ZHunterMod_Saved["ZHunterAIPetAttack"]["petattack"] then
		if not UnitExists("target") or UnitIsUnit("target", "pettarget") then
			return PetFollow()
		end
	end
	return ZHunterAIPetAttack_PetAttack()
end

ZHunterAIPetAttack_CastPetAction = CastPetAction
function CastPetAction(index, a, b, c, d, e)
	if ZHunterMod_Saved["ZHunterAIPetAttack"]["petattack"] and GetPetActionInfo(index) == "PET_ACTION_ATTACK" then
		return PetAttack()
	end
	return ZHunterAIPetAttack_CastPetAction(index, a, b, c, d, e)
end

SLASH_ZHunterAIPetAttack1 = "/zpetattack"
SlashCmdList["ZHunterAIPetAttack"] = function(msg)
	if ZHunterMod_Saved["ZHunterAIPetAttack"]["petattack"] then
		ZHunterMod_Saved["ZHunterAIPetAttack"]["petattack"] = nil
		DEFAULT_CHAT_FRAME:AddMessage("Smart Pet Attack Disabled.", 0, 1, 1)
	else
		ZHunterMod_Saved["ZHunterAIPetAttack"]["petattack"] = 1
		DEFAULT_CHAT_FRAME:AddMessage("Smart Pet Attack Enabled.", 0, 1, 1)
	end
end