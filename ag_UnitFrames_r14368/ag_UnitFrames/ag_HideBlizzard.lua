-- Blizzard hide and show

function aUF:UpdateBlizzVisibility()
	if aUF.db.profile.BlizFramesVisibility.HidePlayerFrame == true then
		aUF:HideBlizzPlayer()
	else
		aUF:ShowBlizzPlayer()
	end
	if aUF.db.profile.BlizFramesVisibility.HidePartyFrame == true then
		aUF:HideBlizzParty()
	else
		aUF:ShowBlizzParty()
	end
	if aUF.db.profile.BlizFramesVisibility.HideTargetFrame == true then
		aUF:HideBlizzTarget()
	else
		aUF:ShowBlizzTarget()
	end
end

function aUF:HideBlizzPlayer()
	PlayerFrame:UnregisterEvent("UNIT_LEVEL")
	PlayerFrame:UnregisterEvent("UNIT_COMBAT")
	PlayerFrame:UnregisterEvent("UNIT_SPELLMISS")
	PlayerFrame:UnregisterEvent("UNIT_PVP_UPDATE")
	PlayerFrame:UnregisterEvent("UNIT_MAXMANA")
	PlayerFrame:UnregisterEvent("PLAYER_ENTER_COMBAT")
	PlayerFrame:UnregisterEvent("PLAYER_LEAVE_COMBAT")
	PlayerFrame:UnregisterEvent("PLAYER_UPDATE_RESTING")
	PlayerFrame:UnregisterEvent("PARTY_MEMBERS_CHANGED")
	PlayerFrame:UnregisterEvent("PARTY_LEADER_CHANGED")
	PlayerFrame:UnregisterEvent("PARTY_LOOT_METHOD_CHANGED")
	PlayerFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
	PlayerFrame:UnregisterEvent("PLAYER_REGEN_DISABLED")
	PlayerFrame:UnregisterEvent("PLAYER_REGEN_ENABLED")
	PlayerFrameHealthBar:UnregisterEvent("UNIT_HEALTH")
	PlayerFrameHealthBar:UnregisterEvent("UNIT_MAXHEALTH")
	PlayerFrameManaBar:UnregisterEvent("UNIT_MANA")
	PlayerFrameManaBar:UnregisterEvent("UNIT_RAGE")
	PlayerFrameManaBar:UnregisterEvent("UNIT_FOCUS")
	PlayerFrameManaBar:UnregisterEvent("UNIT_ENERGY")
	PlayerFrameManaBar:UnregisterEvent("UNIT_HAPPINESS")
	PlayerFrameManaBar:UnregisterEvent("UNIT_MAXMANA")
	PlayerFrameManaBar:UnregisterEvent("UNIT_MAXRAGE")
	PlayerFrameManaBar:UnregisterEvent("UNIT_MAXFOCUS")
	PlayerFrameManaBar:UnregisterEvent("UNIT_MAXENERGY")
	PlayerFrameManaBar:UnregisterEvent("UNIT_MAXHAPPINESS")
	PlayerFrameManaBar:UnregisterEvent("UNIT_DISPLAYPOWER")
	PlayerFrame:UnregisterEvent("UNIT_NAME_UPDATE")
	PlayerFrame:UnregisterEvent("UNIT_PORTRAIT_UPDATE")
	PlayerFrame:UnregisterEvent("UNIT_DISPLAYPOWER")
	PlayerFrame:Hide()
end

function aUF:ShowBlizzPlayer()
	PlayerFrame:RegisterEvent("UNIT_LEVEL")
	PlayerFrame:RegisterEvent("UNIT_COMBAT")
	PlayerFrame:RegisterEvent("UNIT_SPELLMISS")
	PlayerFrame:RegisterEvent("UNIT_PVP_UPDATE")
	PlayerFrame:RegisterEvent("UNIT_MAXMANA")
	PlayerFrame:RegisterEvent("PLAYER_ENTER_COMBAT")
	PlayerFrame:RegisterEvent("PLAYER_LEAVE_COMBAT")
	PlayerFrame:RegisterEvent("PLAYER_UPDATE_RESTING")
	PlayerFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
	PlayerFrame:RegisterEvent("PARTY_LEADER_CHANGED")
	PlayerFrame:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")
	PlayerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	PlayerFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	PlayerFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
	PlayerFrameHealthBar:RegisterEvent("UNIT_HEALTH")
	PlayerFrameHealthBar:RegisterEvent("UNIT_MAXHEALTH")
	PlayerFrameManaBar:RegisterEvent("UNIT_MANA")
	PlayerFrameManaBar:RegisterEvent("UNIT_RAGE")
	PlayerFrameManaBar:RegisterEvent("UNIT_FOCUS")
	PlayerFrameManaBar:RegisterEvent("UNIT_ENERGY")
	PlayerFrameManaBar:RegisterEvent("UNIT_HAPPINESS")
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXMANA")
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXRAGE")
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXFOCUS")
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXENERGY")
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXHAPPINESS")
	PlayerFrameManaBar:RegisterEvent("UNIT_DISPLAYPOWER")
	PlayerFrame:RegisterEvent("UNIT_NAME_UPDATE")
	PlayerFrame:RegisterEvent("UNIT_PORTRAIT_UPDATE")
	PlayerFrame:RegisterEvent("UNIT_DISPLAYPOWER")
	PlayerFrame:Show()
end

function aUF:HideBlizzParty()
	self:Hook("RaidOptionsFrame_UpdatePartyFrames", function() end)
	for i=1,4 do
		local frame = getglobal("PartyMemberFrame"..i)
		frame:UnregisterAllEvents()
		frame:Hide()
	end
end

function aUF:ShowBlizzParty()
	self:Unhook("RaidOptionsFrame_UpdatePartyFrames")
	for i=1,4 do
		local frame = getglobal("PartyMemberFrame"..i)
		frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
		frame:RegisterEvent("PARTY_LEADER_CHANGED")
		frame:RegisterEvent("PARTY_MEMBER_ENABLE")
		frame:RegisterEvent("PARTY_MEMBER_DISABLE")
		frame:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")
		frame:RegisterEvent("UNIT_PVP_UPDATE")
		frame:RegisterEvent("UNIT_AURA")
		frame:RegisterEvent("UNIT_PET")
		frame:RegisterEvent("VARIABLES_LOADED")
		frame:RegisterEvent("UNIT_NAME_UPDATE")
		frame:RegisterEvent("UNIT_PORTRAIT_UPDATE")
		frame:RegisterEvent("UNIT_DISPLAYPOWER")

		UnitFrame_OnEvent("PARTY_MEMBERS_CHANGED")

		PartyMemberFrame_UpdateMember()
	end
end

function aUF:HideBlizzTarget()
	TargetFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
	TargetFrame:UnregisterEvent("UNIT_HEALTH")
	TargetFrame:UnregisterEvent("UNIT_LEVEL")
	TargetFrame:UnregisterEvent("UNIT_FACTION")
	TargetFrame:UnregisterEvent("UNIT_CLASSIFICATION_CHANGED")
	TargetFrame:UnregisterEvent("UNIT_AURA")
	TargetFrame:UnregisterEvent("PLAYER_FLAGS_CHANGED")
	TargetFrame:UnregisterEvent("PARTY_MEMBERS_CHANGED")
	TargetFrame:Hide()
	
	ComboFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
	ComboFrame:UnregisterEvent("PLAYER_COMBO_POINTS")
end

function aUF:ShowBlizzTarget()
	TargetFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
	TargetFrame:RegisterEvent("UNIT_HEALTH")
	TargetFrame:RegisterEvent("UNIT_LEVEL")
	TargetFrame:RegisterEvent("UNIT_FACTION")
	TargetFrame:RegisterEvent("UNIT_CLASSIFICATION_CHANGED")
	TargetFrame:RegisterEvent("UNIT_AURA")
	TargetFrame:RegisterEvent("PLAYER_FLAGS_CHANGED")
	TargetFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
	TargetFrame:Show()
	
	ComboFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
	ComboFrame:RegisterEvent("PLAYER_COMBO_POINTS")
end