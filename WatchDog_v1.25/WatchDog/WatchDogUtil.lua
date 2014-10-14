-- This code is taken from Satrina's Party Frames
-- Thanks to Satrina <Silent Transcendence> for permission to gank the code

WatchDog_Disabled = {}
WatchDog_Disabled.player = nil;
WatchDog_Disabled.party = nil;
WatchDog_Disabled.pet = nil;
WatchDog_Disabled.target = nil;

function WatchDog_DisablePlayerFrame()
	-- Toggle, so we don't do this often
	if WatchDog_Disabled.player then return end
	
	WatchDog_Disabled.player = true;

	-- Unregister default player frame events
	PlayerFrame:UnregisterEvent("UNIT_LEVEL");
	PlayerFrame:UnregisterEvent("UNIT_COMBAT");
	PlayerFrame:UnregisterEvent("UNIT_SPELLMISS");
	PlayerFrame:UnregisterEvent("UNIT_PVP_UPDATE");
	PlayerFrame:UnregisterEvent("UNIT_MAXMANA");
	PlayerFrame:UnregisterEvent("PLAYER_ENTER_COMBAT");
	PlayerFrame:UnregisterEvent("PLAYER_LEAVE_COMBAT");
	PlayerFrame:UnregisterEvent("PLAYER_UPDATE_RESTING");
	PlayerFrame:UnregisterEvent("PARTY_MEMBERS_CHANGED");
	PlayerFrame:UnregisterEvent("PARTY_LEADER_CHANGED");
	PlayerFrame:UnregisterEvent("PARTY_LOOT_METHOD_CHANGED");
	PlayerFrame:UnregisterEvent("PLAYER_ENTERING_WORLD");
	PlayerFrame:UnregisterEvent("PLAYER_REGEN_DISABLED");
	PlayerFrame:UnregisterEvent("PLAYER_REGEN_ENABLED");
	PlayerFrame:UnregisterEvent("UNIT_NAME_UPDATE");
	PlayerFrame:UnregisterEvent("UNIT_PORTRAIT_UPDATE");
	PlayerFrame:UnregisterEvent("UNIT_DISPLAYPOWER");
	PlayerFrameHealthBar:UnregisterEvent("UNIT_HEALTH");
	PlayerFrameHealthBar:UnregisterEvent("UNIT_MAXHEALTH");
	PlayerFrameManaBar:UnregisterEvent("UNIT_MANA");
	PlayerFrameManaBar:UnregisterEvent("UNIT_RAGE");
	PlayerFrameManaBar:UnregisterEvent("UNIT_FOCUS");
	PlayerFrameManaBar:UnregisterEvent("UNIT_ENERGY");
	PlayerFrameManaBar:UnregisterEvent("UNIT_HAPPINESS");
	PlayerFrameManaBar:UnregisterEvent("UNIT_MAXMANA");
	PlayerFrameManaBar:UnregisterEvent("UNIT_MAXRAGE");
	PlayerFrameManaBar:UnregisterEvent("UNIT_MAXFOCUS");
	PlayerFrameManaBar:UnregisterEvent("UNIT_MAXENERGY");
	PlayerFrameManaBar:UnregisterEvent("UNIT_MAXHAPPINESS");
	PlayerFrameManaBar:UnregisterEvent("UNIT_DISPLAYPOWER");
	PlayerFrame:Hide();
end

function WatchDog_DisablePetFrame()
	-- Toggle, so we don't do this often
	if WatchDog_Disabled.pet then return end
	WatchDog_Disabled.pet = true;

	-- Unregister default pet frame events
	PetFrame:UnregisterEvent("UNIT_COMBAT");
	PetFrame:UnregisterEvent("UNIT_SPELLMISS");
	PetFrame:UnregisterEvent("UNIT_AURA");
	PetFrame:UnregisterEvent("PLAYER_PET_CHANGED");
	PetFrame:UnregisterEvent("PET_ATTACK_START");
	PetFrame:UnregisterEvent("PET_ATTACK_STOP");
	PetFrame:UnregisterEvent("UNIT_HAPPINESS");
	PetFrame:UnregisterEvent("PLAYER_ENTERING_WORLD");
	PetFrame:Hide();
end

function WatchDog_DisableTargetFrame()
	-- Toggle, so we don't do this often
	if WatchDog_Disabled.target then return end
	WatchDog_Disabled.target = true;

	-- Unregister default target frame events
	TargetFrame:UnregisterEvent("UNIT_HEALTH");
	TargetFrame:UnregisterEvent("UNIT_LEVEL");
	TargetFrame:UnregisterEvent("UNIT_FACTION");
	TargetFrame:UnregisterEvent("UNIT_DYNAMIC_FLAGS");
	TargetFrame:UnregisterEvent("UNIT_CLASSIFICATION_CHANGED");
	TargetFrame:UnregisterEvent("PLAYER_PVPLEVEL_CHANGED");
	TargetFrame:UnregisterEvent("PLAYER_TARGET_CHANGED");
	TargetFrame:UnregisterEvent("PARTY_MEMBERS_CHANGED");
	TargetFrame:UnregisterEvent("PARTY_LEADER_CHANGED");
	TargetFrame:UnregisterEvent("PARTY_MEMBER_ENABLE");
	TargetFrame:UnregisterEvent("PARTY_MEMBER_DISABLE");
	TargetFrame:UnregisterEvent("UNIT_AURA");
	TargetFrame:UnregisterEvent("PLAYER_FLAGS_CHANGED");
	TargetFrame:UnregisterEvent("UNIT_NAME_UPDATE");
	TargetFrame:UnregisterEvent("UNIT_PORTRAIT_UPDATE");
	TargetFrame:UnregisterEvent("UNIT_DISPLAYPOWER");
	TargetFrameHealthBar:UnregisterEvent("UNIT_HEALTH");
	TargetFrameHealthBar:UnregisterEvent("UNIT_MAXHEALTH");
	TargetFrameManaBar:UnregisterEvent("UNIT_MANA");
	TargetFrameManaBar:UnregisterEvent("UNIT_RAGE");
	TargetFrameManaBar:UnregisterEvent("UNIT_FOCUS");
	TargetFrameManaBar:UnregisterEvent("UNIT_ENERGY");
	TargetFrameManaBar:UnregisterEvent("UNIT_HAPPINESS");
	TargetFrameManaBar:UnregisterEvent("UNIT_MAXMANA");
	TargetFrameManaBar:UnregisterEvent("UNIT_MAXRAGE");
	TargetFrameManaBar:UnregisterEvent("UNIT_MAXFOCUS");
	TargetFrameManaBar:UnregisterEvent("UNIT_MAXENERGY");
	TargetFrameManaBar:UnregisterEvent("UNIT_MAXHAPPINESS");
	TargetFrameManaBar:UnregisterEvent("UNIT_DISPLAYPOWER");

	-- Combo points frame too
	ComboFrame:UnregisterEvent("PLAYER_TARGET_CHANGED");
	ComboFrame:UnregisterEvent("PLAYER_COMBO_POINTS");
	TargetFrame:Hide();
end

function WatchDog_DisablePartyFrame()
	-- Toggle, so we don't do this often
	if WatchDog_Disabled.party then return end
	WatchDog_Disabled.party = true;

	-- Unregister default party frame events
	for i=1,4 do
		frame = getglobal("PartyMemberFrame"..i);
		healthBar = getglobal("PartyMemberFrame"..i.."HealthBar");
		manaBar = getglobal("PartyMemberFrame"..i.."ManaBar");
		frame:UnregisterEvent("PARTY_MEMBERS_CHANGED");
		frame:UnregisterEvent("PARTY_LEADER_CHANGED");
		frame:UnregisterEvent("PARTY_MEMBER_ENABLE");
		frame:UnregisterEvent("PARTY_MEMBER_DISABLE");
		frame:UnregisterEvent("PARTY_LOOT_METHOD_CHANGED");
		frame:UnregisterEvent("UNIT_PVP_UPDATE");
		frame:UnregisterEvent("UNIT_AURA");
		frame:UnregisterEvent("UNIT_NAME_UPDATE");
		frame:UnregisterEvent("UNIT_PORTRAIT_UPDATE");
		frame:UnregisterEvent("UNIT_DISPLAYPOWER");
		healthBar:UnregisterEvent("UNIT_HEALTH");
		healthBar:UnregisterEvent("UNIT_MAXHEALTH");
		manaBar:UnregisterEvent("UNIT_MANA");
		manaBar:UnregisterEvent("UNIT_RAGE");
		manaBar:UnregisterEvent("UNIT_FOCUS");
		manaBar:UnregisterEvent("UNIT_ENERGY");
		manaBar:UnregisterEvent("UNIT_HAPPINESS");
		manaBar:UnregisterEvent("UNIT_MAXMANA");
		manaBar:UnregisterEvent("UNIT_MAXRAGE");
		manaBar:UnregisterEvent("UNIT_MAXFOCUS");
		manaBar:UnregisterEvent("UNIT_MAXENERGY");
		manaBar:UnregisterEvent("UNIT_MAXHAPPINESS");
		manaBar:UnregisterEvent("UNIT_DISPLAYPOWER");
	end
	HidePartyFrame();		
	ShowPartyFrame = function () end;
end

function WatchDog_EnablePlayerFrame()
	-- Toggle, so we don't do this often
	if not WatchDog_Disabled.player then return end
	WatchDog_Disabled.player = nil;

	-- Unregister default player frame events
	PlayerFrame:RegisterEvent("UNIT_LEVEL");
	PlayerFrame:RegisterEvent("UNIT_COMBAT");
	PlayerFrame:RegisterEvent("UNIT_SPELLMISS");
	PlayerFrame:RegisterEvent("UNIT_PVP_UPDATE");
	PlayerFrame:RegisterEvent("UNIT_MAXMANA");
	PlayerFrame:RegisterEvent("PLAYER_ENTER_COMBAT");
	PlayerFrame:RegisterEvent("PLAYER_LEAVE_COMBAT");
	PlayerFrame:RegisterEvent("PLAYER_UPDATE_RESTING");
	PlayerFrame:RegisterEvent("PARTY_MEMBERS_CHANGED");
	PlayerFrame:RegisterEvent("PARTY_LEADER_CHANGED");
	PlayerFrame:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");
	PlayerFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	PlayerFrame:RegisterEvent("PLAYER_REGEN_EnableD");
	PlayerFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
	PlayerFrame:RegisterEvent("UNIT_NAME_UPDATE");
	PlayerFrame:RegisterEvent("UNIT_PORTRAIT_UPDATE");
	PlayerFrame:RegisterEvent("UNIT_DISPLAYPOWER");
	PlayerFrameHealthBar:RegisterEvent("UNIT_HEALTH");
	PlayerFrameHealthBar:RegisterEvent("UNIT_MAXHEALTH");
	PlayerFrameManaBar:RegisterEvent("UNIT_MANA");
	PlayerFrameManaBar:RegisterEvent("UNIT_RAGE");
	PlayerFrameManaBar:RegisterEvent("UNIT_FOCUS");
	PlayerFrameManaBar:RegisterEvent("UNIT_ENERGY");
	PlayerFrameManaBar:RegisterEvent("UNIT_HAPPINESS");
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXMANA");
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXRAGE");
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXFOCUS");
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXENERGY");
	PlayerFrameManaBar:RegisterEvent("UNIT_MAXHAPPINESS");
	PlayerFrameManaBar:RegisterEvent("UNIT_DISPLAYPOWER");
	PlayerFrame:Show();
end

function WatchDog_EnablePetFrame()
	-- Toggle, so we don't do this often
	if not WatchDog_Disabled.pet then return end
	WatchDog_Disabled.pet = nil;

	-- Unregister default pet frame events
	PetFrame:RegisterEvent("UNIT_COMBAT");
	PetFrame:RegisterEvent("UNIT_SPELLMISS");
	PetFrame:RegisterEvent("UNIT_AURA");
	PetFrame:RegisterEvent("PLAYER_PET_CHANGED");
	PetFrame:RegisterEvent("PET_ATTACK_START");
	PetFrame:RegisterEvent("PET_ATTACK_STOP");
	PetFrame:RegisterEvent("UNIT_HAPPINESS");
	PetFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	PetFrame:Show();
end

function WatchDog_EnableTargetFrame()
	-- Toggle, so we don't do this often
	if not WatchDog_Disabled.target then return end
	WatchDog_Disabled.target = nil;

	-- Unregister default target frame events
	TargetFrame:RegisterEvent("UNIT_HEALTH");
	TargetFrame:RegisterEvent("UNIT_LEVEL");
	TargetFrame:RegisterEvent("UNIT_FACTION");
	TargetFrame:RegisterEvent("UNIT_DYNAMIC_FLAGS");
	TargetFrame:RegisterEvent("UNIT_CLASSIFICATION_CHANGED");
	TargetFrame:RegisterEvent("PLAYER_PVPLEVEL_CHANGED");
	TargetFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
	TargetFrame:RegisterEvent("PARTY_MEMBERS_CHANGED");
	TargetFrame:RegisterEvent("PARTY_LEADER_CHANGED");
	TargetFrame:RegisterEvent("PARTY_MEMBER_ENABLE");
	TargetFrame:RegisterEvent("PARTY_MEMBER_Enable");
	TargetFrame:RegisterEvent("UNIT_AURA");
	TargetFrame:RegisterEvent("PLAYER_FLAGS_CHANGED");
	TargetFrame:RegisterEvent("UNIT_NAME_UPDATE");
	TargetFrame:RegisterEvent("UNIT_PORTRAIT_UPDATE");
	TargetFrame:RegisterEvent("UNIT_DISPLAYPOWER");
	TargetFrameHealthBar:RegisterEvent("UNIT_HEALTH");
	TargetFrameHealthBar:RegisterEvent("UNIT_MAXHEALTH");
	TargetFrameManaBar:RegisterEvent("UNIT_MANA");
	TargetFrameManaBar:RegisterEvent("UNIT_RAGE");
	TargetFrameManaBar:RegisterEvent("UNIT_FOCUS");
	TargetFrameManaBar:RegisterEvent("UNIT_ENERGY");
	TargetFrameManaBar:RegisterEvent("UNIT_HAPPINESS");
	TargetFrameManaBar:RegisterEvent("UNIT_MAXMANA");
	TargetFrameManaBar:RegisterEvent("UNIT_MAXRAGE");
	TargetFrameManaBar:RegisterEvent("UNIT_MAXFOCUS");
	TargetFrameManaBar:RegisterEvent("UNIT_MAXENERGY");
	TargetFrameManaBar:RegisterEvent("UNIT_MAXHAPPINESS");
	TargetFrameManaBar:RegisterEvent("UNIT_DISPLAYPOWER");

	-- Combo points frame too
	ComboFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
	ComboFrame:RegisterEvent("PLAYER_COMBO_POINTS");
	TargetFrame:Show();
end

function WatchDog_EnablePartyFrame()
	-- Toggle, so we don't do this often
	if not WatchDog_Disabled.party then return end
	WatchDog_Disabled.party = nil;
	
	-- Unregister default party frame events
	for i=1,4 do
		frame = getglobal("PartyMemberFrame"..i);
		healthBar = getglobal("PartyMemberFrame"..i.."HealthBar");
		manaBar = getglobal("PartyMemberFrame"..i.."ManaBar");
		frame:RegisterEvent("PARTY_MEMBERS_CHANGED");
		frame:RegisterEvent("PARTY_LEADER_CHANGED");
		frame:RegisterEvent("PARTY_MEMBER_ENABLE");
		frame:RegisterEvent("PARTY_MEMBER_Enable");
		frame:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");
		frame:RegisterEvent("UNIT_PVP_UPDATE");
		frame:RegisterEvent("UNIT_AURA");
		frame:RegisterEvent("UNIT_NAME_UPDATE");
		frame:RegisterEvent("UNIT_PORTRAIT_UPDATE");
		frame:RegisterEvent("UNIT_DISPLAYPOWER");
		healthBar:RegisterEvent("UNIT_HEALTH");
		healthBar:RegisterEvent("UNIT_MAXHEALTH");
		manaBar:RegisterEvent("UNIT_MANA");
		manaBar:RegisterEvent("UNIT_RAGE");
		manaBar:RegisterEvent("UNIT_FOCUS");
		manaBar:RegisterEvent("UNIT_ENERGY");
		manaBar:RegisterEvent("UNIT_HAPPINESS");
		manaBar:RegisterEvent("UNIT_MAXMANA");
		manaBar:RegisterEvent("UNIT_MAXRAGE");
		manaBar:RegisterEvent("UNIT_MAXFOCUS");
		manaBar:RegisterEvent("UNIT_MAXENERGY");
		manaBar:RegisterEvent("UNIT_MAXHAPPINESS");
		manaBar:RegisterEvent("UNIT_DISPLAYPOWER");
	end
	ShowPartyFrame = WatchDog_OldShowPartyFrame;
	ShowPartyFrame();
end

WatchDog_OldShowPartyFrame = ShowPartyFrame;

function WatchDog_ShowHideDefaults()

	if (WatchDog.defaultplayer) then PlayerFrame:Show() else PlayerFrame:Hide(); end
	if (WatchDog.defaulttarget) then
		if UnitExists("target") then TargetFrame:Show() end
		ComboFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
		ComboFrame:RegisterEvent("PLAYER_COMBO_POINTS");				
	else
		TargetFrame:Hide()
		ComboFrame:Hide()
		ComboFrame:UnregisterEvent("PLAYER_TARGET_CHANGED")
		ComboFrame:UnregisterEvent("PLAYER_COMBO_POINTS")
	end
	if (WatchDog.defaultparty) then ShowPartyFrame() else HidePartyFrame() end

	-- Player Frame
	if WatchDog.defaultplayer and WatchDog_Disabled.player then
		WatchDog_EnablePlayerFrame();
		WatchDog_EnablePetFrame();
	elseif not WatchDog.defaultplayer and not WatchDog_Disabled.player then
		WatchDog_DisablePlayerFrame();	
		WatchDog_DisablePetFrame();
	end
	
	-- Target Frame
	if WatchDog.defaulttarget and WatchDog_Disabled.target then
		WatchDog_EnableTargetFrame();
	elseif not WatchDog.defaulttarget and not WatchDog_Disabled.target then
		WatchDog_DisableTargetFrame();	
	end

	-- Party Frame
	if WatchDog.defaultparty and WatchDog_Disabled.party then
		WatchDog_EnablePartyFrame();
	elseif not WatchDog.defaultparty and not WatchDog_Disabled.party then
		WatchDog_DisablePartyFrame();	
	end
end
