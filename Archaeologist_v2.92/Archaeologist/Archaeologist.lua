--------------------------------------------------------------------------
-- Archaeologist.lua 
--------------------------------------------------------------------------
--[[
Archaeologist v2.92
	Unearthing Health and Mana values at a unit frame near you.

By: AnduinLothar    <KarlKFI@cosmosui.org>

	$Id: Archaeologist.lua 4050 2006-09-06 00:26:27Z karlkfi $
	$Rev: 4050 $
	$LastChangedBy: karlkfi $
	$Date: 2006-09-05 19:26:27 -0500 (Tue, 05 Sep 2006) $

]]--

-- <= == == == == == == == == == == == == =>
-- => Localization Registration
-- <= == == == == == == == == == == == == =>

local function TEXT(key) return Localization.GetString("Archaeologist", key) end
Localization.SetAddonDefault("Archaeologist", "enUS");

-- <= == == == == == == == == == == == == =>
-- => Global Variables
-- <= == == == == == == == == == == == == =>

ARCHAEOLOGIST_SUPER_SLASH_COMMAND	= "/arch";

Archaeologist_TextStringPercentStatusBars = { };
Archaeologist_TextStringValueStatusBars = { };
Archaeologist_TextStringHideMaxValueStatusBars = { };
Archaeologist_TextStringInvertPercentStatusBars = { };
Archaeologist_TextStringInvertValueStatusBars = { };
Archaeologist_TextStringAltTextStatusBars = { };

ArchaeologistStatusBars = { };
ArchaeologistOptionSetName = "Archaeologist";

ArchaeologistFonts = { 
	GameFontNormal = "Fonts\\FRIZQT__.TTF";
	NumberFontNormal = "Fonts\\ARIALN.TTF";
	ItemTextFontNormal = "Fonts\\MORPHEUS.TTF";
};

function Archaeologist_GetLocalizedFonts()
	
	return { 
		[TEXT("Default")] = "Default";
		[TEXT("GameFontNormal")] = "GameFontNormal";
		[TEXT("NumberFontNormal")] = "NumberFontNormal";
		[TEXT("ItemTextFontNormal")] = "ItemTextFontNormal";
	};
	
end

function Archaeologist_GetOnOffMouseover()
	return { 
		[TEXT("ARCHAEOLOGIST_ON")] = "on";
		[TEXT("ARCHAEOLOGIST_OFF")] = "off";
		[TEXT("ARCHAEOLOGIST_MOUSEOVER")] = "mouseover";
	};
end

function Archaeologist_DefineStatusBars()

	ArchaeologistStatusBars.player  = { frame = PlayerFrame, statusText = PlayerStatusText };
	ArchaeologistStatusBars.party1  = { frame = PartyMemberFrame1, statusText = PartyMemberFrame1.statusText };
	ArchaeologistStatusBars.party2  = { frame = PartyMemberFrame2, statusText = PartyMemberFrame2.statusText };
	ArchaeologistStatusBars.party3  = { frame = PartyMemberFrame3, statusText = PartyMemberFrame3.statusText };
	ArchaeologistStatusBars.party4  = { frame = PartyMemberFrame4, statusText = PartyMemberFrame4.statusText };
	ArchaeologistStatusBars.pet		= { frame = PetFrame, statusText = PetStatusText };
	ArchaeologistStatusBars.target  = { frame = TargetFrame, statusText = TargetDeadText };

end

-- <= == == == == == == == == == == == == =>
-- => Variable Sync Tables
-- <= == == == == == == == == == == == == =>

ArchaeologistVars = { };
ArchaeologistVarData = { };

function Archaeologist_DefineVarData()
	ArchaeologistVarData = {

		PLAYERHP = { name = "PlayerHp", default = "mouseover", options = Archaeologist_GetOnOffMouseover, func = function(value) Archaeologist_PrimaryOnOffMouseover("player", "healthbar", value); end },
		PLAYERHP2 = { name = "PlayerHp2", default = "off", options = Archaeologist_GetOnOffMouseover, func = function(value) Archaeologist_SecondaryOnOffMouseover("player", "healthbar", value); Archaeologist_UpdateTargetLocation(); end },
		PLAYERMP = { name = "PlayerMp", default = "mouseover", options = Archaeologist_GetOnOffMouseover, func = function(value) Archaeologist_PrimaryOnOffMouseover("player", "manabar", value);  end },
		PLAYERMP2 = { name = "PlayerMp2", default = "off", options = Archaeologist_GetOnOffMouseover, func = function(value) Archaeologist_SecondaryOnOffMouseover("player", "manabar", value); Archaeologist_UpdateTargetLocation(); end },
		PLAYERHPNOMAX = { name = "PlayerHpNoMaxValue", default = 0, func = Archaeologist_TurnOffPlayerHPMaxValue },
		PLAYERMPNOMAX = { name = "PlayerMpNoMaxValue", default = 0, func = Archaeologist_TurnOffPlayerMPMaxValue },
		PLAYERHPVINVERT = { name = "PlayerHpValueInvert", default = 0, func = Archaeologist_TurnOnPlayerHPValueInvert },
		PLAYERMPVINVERT = { name = "PlayerMpValueInvert", default = 0, func = Archaeologist_TurnOnPlayerMPValueInvert },
		PLAYERHPPINVERT = { name = "PlayerHpPercentInvert", default = 0, func = Archaeologist_TurnOnPlayerHPPercentInvert },
		PLAYERMPPINVERT = { name = "PlayerMpPercentInvert", default = 0, func = Archaeologist_TurnOnPlayerMPPercentInvert },
		PLAYERHPNOPREFIX = { name = "PlayerHpPrefix", default = 0, func = Archaeologist_TurnOffPlayerHPPrefix },
		PLAYERMPNOPREFIX = { name = "PlayerMpPrefix", default = 0, func = Archaeologist_TurnOffPlayerMPPrefix },
		PLAYERCLASSICON = { name = "PlayerClassIcon", default = 0, disabled = 0, func = Archaeologist_TurnOnPlayerClassIcon },
		PLAYERHPSWAP = { name = "PlayerAltHpText", default = 1, func = function(toggle) Archaeologist_SetUnitBarValuePercentSwap("player", "healthbar", toggle); end },
		PLAYERMPSWAP = { name = "PlayerAltMpText", default = 1, func = function(toggle) Archaeologist_SetUnitBarValuePercentSwap("player", "manabar", toggle); end },
		
		MAINXP = { name = "PlayerXp", default = "mouseover", options = Archaeologist_GetOnOffMouseover, func = Archaeologist_PlayerXPOnOffMouseover },
		MAINXPNOMAX = { name = "PlayerXpNoMaxValue", default = 0, func = Archaeologist_TurnOffPlayerXPMaxValue },
		MAINXPVINVERT = { name = "PlayerXpValueInvert", default = 0, func = Archaeologist_TurnOnPlayerXPValueInvert },
		MAINXPPINVERT = { name = "PlayerXpPercentInvert", default = 0, func = Archaeologist_TurnOnPlayerXPPercentInvert },
		MAINXPP = { name = "PlayerXpPercent", default = 0, func = Archaeologist_TurnOnPlayerXPPercent },
		MAINXPV = { name = "PlayerXpValue", default = 1, func = Archaeologist_TurnOnPlayerXPValue },
		MAINXPNOPREFIX = { name = "PlayerXpPrefix", default = 0, func = Archaeologist_TurnOffPlayerXPPrefix },
		
		MAINREP = { name = "PlayerRep", default = "mouseover", options = Archaeologist_GetOnOffMouseover, func = Archaeologist_PlayerRepOnOffMouseover },
		MAINREPNOMAX = { name = "PlayerRepNoMaxValue", default = 0, func = Archaeologist_TurnOffPlayerRepMaxValue },
		MAINREPVINVERT = { name = "PlayerRepValueInvert", default = 0, func = Archaeologist_TurnOnPlayerRepValueInvert },
		MAINREPPINVERT = { name = "PlayerRepPercentInvert", default = 0, func = Archaeologist_TurnOnPlayerRepPercentInvert },
		MAINREPP = { name = "PlayerRepPercent", default = 0, func = Archaeologist_TurnOnPlayerRepPercent },
		MAINREPV = { name = "PlayerRepValue", default = 1, func = Archaeologist_TurnOnPlayerRepValue },
		MAINREPNOPREFIX = { name = "PlayerRepPrefix", default = 0, func = Archaeologist_TurnOffPlayerRepPrefix },
		
		PARTYHP = { name = "PartyHp", default = "mouseover", options = Archaeologist_GetOnOffMouseover, func = function(value) for i=1,4 do Archaeologist_PrimaryOnOffMouseover("party"..i, "healthbar", value); end end },
		PARTYHP2 = { name = "PartyHp2", default = "off", options = Archaeologist_GetOnOffMouseover, func = function(value) for i=1,4 do Archaeologist_SecondaryOnOffMouseover("party"..i, "healthbar", value); end end },
		PARTYMP = { name = "PartyMp", default = "mouseover", options = Archaeologist_GetOnOffMouseover, func = function(value) for i=1,4 do Archaeologist_PrimaryOnOffMouseover("party"..i, "manabar", value); end end },
		PARTYMP2 = { name = "PartyMp2", default = "off", options = Archaeologist_GetOnOffMouseover, func = function(value) for i=1,4 do Archaeologist_SecondaryOnOffMouseover("party"..i, "manabar", value); end end },
		PARTYHPNOMAX = { name = "PartyHpNoMaxValue", default = 0, func = Archaeologist_TurnOffPartyHPMaxValue },
		PARTYMPNOMAX = { name = "PartyMpNoMaxValue", default = 0, func = Archaeologist_TurnOffPartyMPMaxValue },
		PARTYHPVINVERT = { name = "PartyHpValueInvert", default = 0, func = Archaeologist_TurnOnPartyHPValueInvert },
		PARTYMPVINVERT = { name = "PartyMpValueInvert", default = 0, func = Archaeologist_TurnOnPartyMPValueInvert },
		PARTYHPPINVERT = { name = "PartyHpPercentInvert", default = 0, func = Archaeologist_TurnOnPartyHPPercentInvert },
		PARTYMPPINVERT = { name = "PartyMpPercentInvert", default = 0, func = Archaeologist_TurnOnPartyMPPercentInvert },
		PARTYHPNOPREFIX = { name = "PartyHpPrefix", default = 1, func = Archaeologist_TurnOffPartyHPPrefix },
		PARTYMPNOPREFIX = { name = "PartyMpPrefix", default = 0, func = Archaeologist_TurnOffPartyMPPrefix },
		PARTYCLASSICON = { name = "PartyClassIcon", default = 1, disabled = 0, func = Archaeologist_TurnOnPartyClassIcon },
		PARTYHPSWAP = { name = "PartyAltHpText", default = 1, func = function(toggle) for i=1,4 do Archaeologist_SetUnitBarValuePercentSwap("party"..i, "healthbar", toggle); end end },
		PARTYMPSWAP = { name = "PartyAltMpText", default = 1, func = function(toggle) for i=1,4 do Archaeologist_SetUnitBarValuePercentSwap("party"..i, "manabar", toggle); end end },
		
		PETHP = { name = "PetHp", default = "mouseover", options = Archaeologist_GetOnOffMouseover, func = function(value) Archaeologist_PrimaryOnOffMouseover("pet", "healthbar", value); end },
		PETHP2 = { name = "PetHp2", default = "off", options = Archaeologist_GetOnOffMouseover, func = function(value) Archaeologist_SecondaryOnOffMouseover("pet", "healthbar", value); end },
		PETMP = { name = "PetMp", default = "mouseover", options = Archaeologist_GetOnOffMouseover, func = function(value) Archaeologist_PrimaryOnOffMouseover("pet", "manabar", value); end },
		PETMP2 = { name = "PetMp2", default = "off", options = Archaeologist_GetOnOffMouseover, func = function(value) Archaeologist_SecondaryOnOffMouseover("pet", "manabar", value); end },
		PETXP = { name = "PetXp", default = "mouseover", options = Archaeologist_GetOnOffMouseover, func = Archaeologist_PetXPOnOffMouseover },
		PETHPNOMAX = { name = "PetHpNoMaxValue", default = 0, func = Archaeologist_TurnOffPetHPMaxValue },
		PETMPNOMAX = { name = "PetMpNoMaxValue", default = 0, func = Archaeologist_TurnOffPetMPMaxValue },
		PETXPNOMAX = { name = "PetXpNoMaxValue", default = 0, func = Archaeologist_TurnOffPetXPMaxValue },
		PETHPVINVERT = { name = "PetHpValueInvert", default = 0, func = Archaeologist_TurnOnPetHPValueInvert },
		PETMPVINVERT = { name = "PetMpValueInvert", default = 0, func = Archaeologist_TurnOnPetMPValueInvert },
		PETXPVINVERT = { name = "PetXpValueInvert", default = 0, func = Archaeologist_TurnOnPetXPValueInvert },
		PETHPPINVERT = { name = "PetHpPercentInvert", default = 0, func = Archaeologist_TurnOnPetHPPercentInvert },
		PETMPPINVERT = { name = "PetMpPercentInvert", default = 0, func = Archaeologist_TurnOnPetMPPercentInvert },
		PETXPPINVERT = { name = "PetXpPercentInvert", default = 0, func = Archaeologist_TurnOnPetXPPercentInvert },
		PETXPP = { name = "PetXpPercent", default = 0, func = Archaeologist_TurnOnPetXPPercent },
		PETXPV = { name = "PetXpValue", default = 1, func = Archaeologist_TurnOnPetXPValue },
		PETHPNOPREFIX = { name = "PetHpPrefix", default = 1, func = Archaeologist_TurnOffPetHPPrefix },
		PETMPNOPREFIX = { name = "PetMpPrefix", default = 0, func = Archaeologist_TurnOffPetMPPrefix },
		PETXPNOPREFIX = { name = "PetXpPrefix", default = 0, func = Archaeologist_TurnOffPetXPPrefix },
		PETHPSWAP = { name = "PetAltHpText", default = 1, func = function(toggle) Archaeologist_SetUnitBarValuePercentSwap("pet", "healthbar", toggle); end },
		PETMPSWAP = { name = "PetAltMpText", default = 1, func = function(toggle) Archaeologist_SetUnitBarValuePercentSwap("pet", "manabar", toggle); end },
		
		TARGETHP = { name = "TargetHp", default = "mouseover", options = Archaeologist_GetOnOffMouseover, func = function(value) Archaeologist_PrimaryOnOffMouseover("target", "healthbar", value); end },
		TARGETHP2 = { name = "TargetHp2", default = "off", options = Archaeologist_GetOnOffMouseover, func = function(value) Archaeologist_SecondaryOnOffMouseover("target", "healthbar", value); Archaeologist_UpdateTargetLocation(); end },
		TARGETMP = { name = "TargetMp", default = "mouseover", options = Archaeologist_GetOnOffMouseover, func = function(value) Archaeologist_PrimaryOnOffMouseover("target", "manabar", value); end },
		TARGETMP2 = { name = "TargetMp2", default = "off", options = Archaeologist_GetOnOffMouseover, func = function(value) Archaeologist_SecondaryOnOffMouseover("target", "manabar", value); Archaeologist_UpdateTargetLocation(); end },
		TARGETHPNOMAX = { name = "TargetHpNoMaxValue", default = 0, func = Archaeologist_TurnOffTargetHPMaxValue },
		TARGETMPNOMAX = { name = "TargetMpNoMaxValue", default = 0, func = Archaeologist_TurnOffTargetMPMaxValue },
		TARGETHPVINVERT = { name = "TargetHpValueInvert", default = 0, func = Archaeologist_TurnOnTargetHPValueInvert },
		TARGETMPVINVERT = { name = "TargetMpValueInvert", default = 0, func = Archaeologist_TurnOnTargetMPValueInvert },
		TARGETHPPINVERT = { name = "TargetHpPercentInvert", default = 0, func = Archaeologist_TurnOnTargetHPPercentInvert },
		TARGETMPPINVERT = { name = "TargetMpPercentInvert", default = 0, func = Archaeologist_TurnOnTargetMPPercentInvert },
		TARGETHPNOPREFIX = { name = "TargetHpPrefix", default = 1, func = Archaeologist_TurnOffTargetHPPrefix },
		TARGETMPNOPREFIX = { name = "TargetMpPrefix", default = 0, func = Archaeologist_TurnOffTargetMPPrefix },
		TARGETCLASSICON = { name = "TargetClassIcon", default = 1, disabled = 0, func = Archaeologist_TurnOnTargetClassIcon },
		TARGETHPSWAP = { name = "TargetAltHpText", default = 1, func = function(toggle) Archaeologist_SetUnitBarValuePercentSwap("target", "healthbar", toggle); end },
		TARGETMPSWAP = { name = "TargetAltMpText", default = 1, func = function(toggle) Archaeologist_SetUnitBarValuePercentSwap("target", "manabar", toggle); end },
		
		PBUFFS = { name = "PartyBuffDisable", default = 0, func = Archaeologist_TurnOffPartyBuffs },
		PBUFFNUM = { name = "PartyBuffCount", dependencies = {["PartyBuffDisable"]={checked=false}}, default = 16, min = 0, max = 16, func = Archaeologist_SetPartyBuffs },
		
		PDEBUFFS = { name = "PartyDebuffDisable", default = 0, func = Archaeologist_TurnOffPartyDebuffs },
		PDEBUFFNUM = { name = "PartyDebuffCount", dependencies = {["PartyDebuffDisable"]={checked=false}}, default = 16, min = 0, max = 16, func = Archaeologist_SetPartyDebuffs },
		
		PPTBUFFS = { name = "PartyPetBuffDisable", default = 1, func = Archaeologist_TurnOffPartyPetBuffs },
		PPTBUFFNUM = { name = "PartyPetBuffCount", dependencies = {["PartyPetBuffDisable"]={checked=false}}, default = 16, min = 0, max = 16, func = Archaeologist_SetPartyPetBuffs },
		
		PPTDEBUFFS = { name = "PartyPetDebuffDisable", default = 0, func = Archaeologist_TurnOffPartyPetDebuffs },
		PPTDEBUFFNUM = { name = "PartyPetDebuffCount", dependencies = {["PartyPetDebuffDisable"]={checked=false}}, default = 16, min = 0, max = 16, func = Archaeologist_SetPartyPetDebuffs },
		
		PTBUFFS = { name = "PetBuffDisable", default = 0, func = Archaeologist_TurnOffPetBuffs },
		PTBUFFNUM = { name = "PetBuffCount", dependencies = {["PetBuffDisable"]={checked=false}}, default = 16, min = 0, max = 16, func = Archaeologist_SetPetBuffs },
		
		PTDEBUFFS = { name = "PetDebuffDisable", default = 0, func = Archaeologist_TurnOffPetDebuffs },
		PTDEBUFFNUM = { name = "PetDebuffCount", dependencies = {["PetDebuffDisable"]={checked=false}}, default = 4, min = 0, max = 16, func = Archaeologist_SetPetDebuffs },
		
		TBUFFS = { name = "TargetBuffDisable", default = 0, func = Archaeologist_TurnOffTargetBuffs },
		TBUFFNUM = { name = "TargetBuffCount", dependencies = {["TargetBuffDisable"]={checked=false}}, default = 8, min = 0, max = 16, func = Archaeologist_SetTargetBuffs },
		
		TDEBUFFS = { name = "TargetDebuffDisable", default = 0, func = Archaeologist_TurnOffTargetDebuffs },
		TDEBUFFNUM = { name = "TargetDebuffCount", dependencies = {["TargetDebuffDisable"]={checked=false}}, default = 16, min = 0, max = 16, func = Archaeologist_SetTargetDebuffs },
		
		HPCOLOR = { name = "HealthGradient", default = 0, func = function() end },
		DEBUFFALT = { name = "DebuffRelocate", default = 0, func = Archaeologist_SetAltDebuffLocation },
		TBUFFALT = { name = "TargetBuffAlignment", default = 0, func = Archaeologist_TargetDebuffButton_Update },
		CLASSPORTRAIT = { name = "ClassPortrait", default = 0, func = Archaeologist_EnableClassPortrait },
		THPALT = { name = "TargetHpAlt", default = 0, func = function() Archaeologist_TextStatusBar_UpdateTextString(ArchaeologistStatusBars.target.frame.healthbar); end };
		HPMPLARGESIZE = { name = "LargeTextSize", default = 14, min = 6, max = 20, func = Archaeologist_SetHPMPLargeTextSize },
		HPMPSMALLSIZE = { name = "SmallTextSize", default = 12, min = 6, max = 20, func = Archaeologist_SetHPMPSmallTextSize },
		HPMPLARGEFONT = { name = "LargeFontSelect", default = "Default", options = Archaeologist_GetLocalizedFonts, func = Archaeologist_SetHPMPLargeFont },
		HPMPSMALLFONT = { name = "SmallFontSelect", default = "Default", options = Archaeologist_GetLocalizedFonts, func = Archaeologist_SetHPMPSmallFont },
		COLORPHP = { name = "PrimaryHpColorSelect", default = {r=1,g=1,b=1,opacity=1}, func = Archaeologist_SetPrimaryHPColor },
		COLORPMP = { name = "PrimaryMpColorSelect", default = {r=1,g=1,b=1,opacity=1}, func = Archaeologist_SetPrimaryMPColor },
		COLORSHP = { name = "SecondaryHpColorSelect", default = {r=1,g=1,b=1,opacity=1}, func = Archaeologist_SetSecondaryHPColor },
		COLORSMP = { name = "SecondaryMpColorSelect", default = {r=1,g=1,b=1,opacity=1}, func = Archaeologist_SetSecondaryMPColor },
	};
end

-- <= == == == == == == == == == == == == =>
-- => XML Function Calls
-- <= == == == == == == == == == == == == =>

local SavedHealthBar_OnValueChanged = nil;

function Archaeologist_OnLoad()
	
	Sea.util.hook( "TargetFrame_CheckDead", "Archaeologist_TargetCheckDead", "replace" );
	Sea.util.hook( "ShowTextStatusBarText", "Archaeologist_ShowTextStatusBarText", "replace" );
	Sea.util.hook( "HideTextStatusBarText", "Archaeologist_HideTextStatusBarText", "replace" );
	Sea.util.hook( "TextStatusBar_UpdateTextString", "Archaeologist_TextStatusBar_UpdateTextString", "replace" );
	Sea.util.hook( "CharacterFrame_OnShow", "Archaeologist_CharacterFrame_OnShow", "replace" );
	Sea.util.hook( "CharacterFrame_OnHide", "Archaeologist_CharacterFrame_OnHide", "replace" );
	Sea.util.hook( "UnitFrame_UpdateManaType", "Archaeologist_UnitFrame_UpdateManaType", "replace" );
	
	Sea.util.hook( "RefreshBuffs", "Archaeologist_RefreshBuffsBufFix", "before" );
	Sea.util.hook( "RefreshBuffs", "Archaeologist_RefreshBuffs", "replace" );
	
	Sea.util.hook( "PartyMemberBuffTooltip_Update", "Archaeologist_PartyMemberBuffs_Update", "replace" );
	Sea.util.hook( "ShowPartyFrame", "Archaeologist_UpdatePartyMemberBuffs", "after" );
	Sea.util.hook( "TargetDebuffButton_Update", "Archaeologist_TargetDebuffButton_Update", "replace" );
	Sea.util.hook( "PartyMemberFrame_UpdatePet", "Archaeologist_PartyMemberFrame_UpdatePet", "replace" );
	
	Sea.util.hook( "UnitFrame_Update", "Archaeologist_UnitFrame_Update_After", "after" );
	Sea.util.hook( "UnitFrame_OnEvent", "Archaeologist_UnitFrame_OnEvent_After", "after" );
	Sea.util.hook( "SetTextStatusBarText", "Archaeologist_SetTextStatusBarText", "after" );
	Sea.util.hook( "ReputationWatchBar_Update", "Archaeologist_UpdatePlayerRepPrefix", "after" );
	
	Sea.util.hook( "RaidFrame_LoadUI", "Archaeologist_LoadArchRaid", "replace" );
	
	Sea.util.hook( "HealthBar_OnValueChanged", "Archaeologist_HealthBar_OnValueChanged", "before" );
	
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("UNIT_PET");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PARTY_MEMBER_DISABLE");
	this:RegisterEvent("PARTY_MEMBER_ENABLE");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("PLAYER_LEVEL_UP");
	
	Archaeologist_DefineVarData();
	Archaeologist_InitializeAddedStatusBarTexts();
	Archaeologist_DefineStatusBars();
	Archaeologist_HookStatusBars_OnLeave(); -- Add Hiding Handlers for 2ndary Displays
	Archaeologist_VarSync_SavedToVars(); --set all to default since nothing has loaded yet
end

function Archaeologist_OnEvent(event)
	if (event == "VARIABLES_LOADED") then
		
		local _, class = UnitClass("player");
		Archaeologist_PlayerIsHunter = (class == "HUNTER");
		
		if (not ArchaeologistVars) then
			ArchaeologistVars = { };
		end
		
		if (MobHealth_OnEvent) then
			if (MI2_OnEvent) then
				Sea.util.hook( "MI2_OnEvent", "Archaeologist_MobHealth_OnEvent", "after" );
			else
				Sea.util.hook( "MobHealth_OnEvent", "Archaeologist_MobHealth_OnEvent", "after" );
			end
			ArchaeologistVarData["MOBHEALTH"] = { name = "UseMobHealth", default = 0, func = Archaeologist_EnableMobHealth };
		end
		
		Archaeologist_VarSync_SavedToVars();
		Archaeologist_RegisterForMCom();
		
		if (not Khaos) and (not Cosmos_RegisterConfiguration) then
			Archaeologist_VarSync_VarsToLive();
		end
		
		Archaeologist_PlayerCheckDead();
		Archaeologist_UpdatePartyMembersDead();
		Archaeologist_PetCheckDead();
		Archaeologist_HideOrigBuffs();
		Archaeologist_UpdateOverlapPositions()
	
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		Archaeologist_UpdatePartyMemberBuffs();
		Archaeologist_UpdatePlayerClassIcon();
		Archaeologist_PlayerCheckDead();
		Archaeologist_UpdatePartyMembersDead();
		Archaeologist_PetCheckDead();
	
	elseif ( event == "UNIT_HEALTH" ) then
		if (arg1 == "player") then
			Archaeologist_PlayerCheckDead();
		elseif (arg1 == "target") then
			--called by hook
			--Archaeologist_TargetCheckDead();
		elseif (arg1 == "pet") then
			Archaeologist_PetCheckDead();
		else
			local partyIndex = Archaeologist_PartyIndexFromUnit(arg1);
			Archaeologist_PartyCheckDead(partyIndex);
		end
	
	elseif ( event == "UNIT_PET" ) then
		if ( arg1 == "player" ) then
			Archaeologist_PetCheckDead();
		end
		
	elseif ( event == "PLAYER_LEVEL_UP" ) then
		if (UnitLevel('player') == MAX_PLAYER_LEVEL) then
			MainMenuExpBar:Hide();
		end
		
	elseif (event == "PLAYER_TARGET_CHANGED") then
		Archaeologist_UpdateTargetClassIcon();
		
	elseif (event == "PARTY_MEMBERS_CHANGED") then
		Archaeologist_UpdatePartyMembersDead();
		Archaeologist_UpdatePartyClassIcons();
		
	elseif (event == "PARTY_MEMBER_ENABLE") then
		local partyIndex = Archaeologist_PartyIndexFromName(arg1);
		Archaeologist_PartyCheckDead(partyIndex);
		
	elseif (event == "PARTY_MEMBER_DISABLE") then
		local partyIndex = Archaeologist_PartyIndexFromName(arg1);
		Archaeologist_PartyCheckDead(partyIndex);
	
	elseif (event == "UNIT_AURA") then
		local partyIndex = Archaeologist_PartyIndexFromUnit(arg1);
		Archaeologist_PartyCheckDead(partyIndex);
		if (arg1 == "pet") then
			Archaeologist_PetCheckDead();
		elseif (arg1 == "player") and (Archaeologist_PlayerIsHunter) then
			--Scan for feigning
			PlayerFrame.feigning = nil;
			for i=1, 24 do
				texture = UnitBuff("player", i);
				if (texture == "Interface\\Icons\\Ability_Rogue_FeignDeath") then
					PlayerFrame.feigning = true;
				end
			end
		end
	end

end

-- <= == == == == == == == == == == == == =>
-- => Load ArchRaid
-- <= == == == == == == == == == == == == =>

function Archaeologist_LoadArchRaid()
	local loaded,reason = LoadAddOn("ArchRaid");
	if (not loaded) then
		return true;
	end
end

-- <= == == == == == == == == == == == == =>
-- => Status Bar Initializing
-- <= == == == == == == == == == == == == =>

function Archaeologist_SetTextStatusBarText(bar, text, text2, showWhileOverFrame)
	if ( not bar or not text2 ) then
		return
	end
	bar.TextString2 = text2;
	if (showWhileOverFrame) then
		bar.showWhileOverFrame = showWhileOverFrame;
	else
		bar.showWhileOverFrame = bar;
	end
end

function Archaeologist_InitializeAddedStatusBarTexts()

	SetTextStatusBarText(PartyMemberFrame1HealthBar, PartyMemberFrame1HealthBarTextString, PartyMemberFrame1HealthBarTextString2);
	SetTextStatusBarText(PartyMemberFrame2HealthBar, PartyMemberFrame2HealthBarTextString, PartyMemberFrame2HealthBarTextString2);
	SetTextStatusBarText(PartyMemberFrame3HealthBar, PartyMemberFrame3HealthBarTextString, PartyMemberFrame3HealthBarTextString2);
	SetTextStatusBarText(PartyMemberFrame4HealthBar, PartyMemberFrame4HealthBarTextString, PartyMemberFrame4HealthBarTextString2);
	
	SetTextStatusBarText(PartyMemberFrame1ManaBar, PartyMemberFrame1ManaBarTextString, PartyMemberFrame1ManaBarTextString2);
	SetTextStatusBarText(PartyMemberFrame2ManaBar, PartyMemberFrame2ManaBarTextString, PartyMemberFrame2ManaBarTextString2);
	SetTextStatusBarText(PartyMemberFrame3ManaBar, PartyMemberFrame3ManaBarTextString, PartyMemberFrame3ManaBarTextString2);
	SetTextStatusBarText(PartyMemberFrame4ManaBar, PartyMemberFrame4ManaBarTextString, PartyMemberFrame4ManaBarTextString2);
	
	SetTextStatusBarText(TargetFrameHealthBar, TargetFrameHealthBarTextString, TargetFrameHealthBarTextString2);
	SetTextStatusBarText(TargetFrameManaBar, TargetFrameManaBarTextString, TargetFrameManaBarTextString2);
	
	SetTextStatusBarText(PetFrameHealthBar, PetFrameHealthBarText, PetFrameHealthBarText2String);
	SetTextStatusBarText(PetFrameManaBar, PetFrameManaBarText, PetFrameManaBarText2String);
	
	SetTextStatusBarText(PlayerFrameHealthBar, PlayerFrameHealthBarText, PlayerFrameHealthBarText2String);
	SetTextStatusBarText(PlayerFrameManaBar, PlayerFrameManaBarText, PlayerFrameManaBarText2String);
	
	SetTextStatusBarText(ReputationWatchStatusBar, ReputationWatchStatusBarText);
end

-- <= == == == == == == == == == == == == =>
-- => Variable Sync
-- <= == == == == == == == == == == == == =>

function Archaeologist_VarSync_SavedToVars()
	--sync saved values with internal values, else use default stored, else default to 0
	for index, var in ArchaeologistVarData do
		if (ArchaeologistVars[index]) then
			--already saved
		elseif (var.default) then
			ArchaeologistVars[index] = var.default;
		else
			ArchaeologistVars[index] = 0;
		end
	end
end


function Archaeologist_VarSync_VarsToLive()
	--sync live status with internal values, else use default stored, else default to 0
	for index, var in ArchaeologistVarData do
		if (var.min) and (var.max) then --slider
			if (ArchaeologistVars[index]) and (var.func) then
				var.func(ArchaeologistVars[index])
			elseif (var.func) and (var.default) then
				var.func(var.default);
			elseif (var.func) then
				var.func(0);
			end
		elseif (type(var.default) == "table") then --colorwheel
			if (ArchaeologistVars[index]) and (var.func) then
				var.func(ArchaeologistVars[index])
			elseif (var.func) and (var.default) then
				var.func(var.default);
			elseif (var.func) then
				var.func({});
			end
		elseif (ArchaeologistVars[index]) and (var.func) then
			var.func(ArchaeologistVars[index])
		elseif (var.func) and (var.default) then
			var.func(var.default);
		elseif (var.func) then
			var.func(0);
		end
	end
end


-- <= == == == == == == == == == == == == =>
-- => HP Color Mod
-- <= == == == == == == == == == == == == =>

function Archaeologist_HealthBar_OnValueChanged(value, smooth)
	if (ArchaeologistVars) and (ArchaeologistVars["HPCOLOR"] == 1) then
		return true, value, not smooth;
	end
	--SavedHealthBar_OnValueChanged(value, smooth)
end

-- <= == == == == == == == == == == == == =>
-- => HPMP Text Size
-- <= == == == == == == == == == == == == =>

function Archaeologist_SetHPMPLargeTextSize(size)
	if (type(size) ~= "number") then
		return;
	end
	local barParent = ArchaeologistStatusBars["player"].frame;
	barParent.healthbar.TextString:SetTextHeight(size);
	barParent.manabar.TextString:SetTextHeight(size);
	barParent.healthbar.TextString2:SetTextHeight(size);
	barParent.manabar.TextString2:SetTextHeight(size);
	local scale = barParent:GetScale();
	barParent:SetScale(scale+.1);
	barParent:SetScale(scale);
	barParent = ArchaeologistStatusBars["target"].frame;
	barParent.healthbar.TextString:SetTextHeight(size);
	barParent.manabar.TextString:SetTextHeight(size);
	barParent.healthbar.TextString2:SetTextHeight(size);
	barParent.manabar.TextString2:SetTextHeight(size);
	scale = barParent:GetScale();
	barParent:SetScale(scale+.1);
	barParent:SetScale(scale);
end

function Archaeologist_SetHPMPSmallTextSize(size)
	if (type(size) ~= "number") then
		return;
	end
	local barParent = ArchaeologistStatusBars["pet"].frame;
	barParent.healthbar.TextString:SetTextHeight(size);
	barParent.manabar.TextString:SetTextHeight(size);
	barParent.healthbar.TextString2:SetTextHeight(size);
	barParent.manabar.TextString2:SetTextHeight(size);
	local scale = barParent:GetScale();
	barParent:SetScale(scale+.1);
	barParent:SetScale(scale);
	for i=1, 4 do
		barParent = ArchaeologistStatusBars["party"..i].frame;
		barParent.healthbar.TextString:SetTextHeight(size);
		barParent.manabar.TextString:SetTextHeight(size);
		barParent.healthbar.TextString2:SetTextHeight(size);
		barParent.manabar.TextString2:SetTextHeight(size);
		scale = barParent:GetScale();
		barParent:SetScale(scale+.1);
		barParent:SetScale(scale);
	end
end

-- <= == == == == == == == == == == == == => <= == == == == == == == == == == == == =>
-- => Toggle Functions
-- <= == == == == == == == == == == == == => <= == == == == == == == == == == == == =>

-- <= == == == == == == == == == == == == =>
-- => TurnOn HP/MP/XP Functions
-- <= == == == == == == == == == == == == =>

function Archaeologist_PrimaryOnOffMouseover(unit, bartype, value)
	if (ArchaeologistStatusBars[unit]) then
		OverrideShowStatusBarText(ArchaeologistStatusBars[unit].frame[bartype], value);
	end
end

function Archaeologist_SecondaryOnOffMouseover(unit, bartype, value)
	if (ArchaeologistStatusBars[unit]) then
		OverrideShowStatusBarText2(ArchaeologistStatusBars[unit].frame[bartype], value);
		if (unit == "pet") then
			Archaeologist_SetPetFrameHappinessLocation();
		end
	end
end

function Archaeologist_PlayerXPOnOffMouseover(toggle)
	OverrideShowStatusBarText(MainMenuExpBar, toggle);
end

function Archaeologist_PlayerRepOnOffMouseover(toggle)
	OverrideShowStatusBarText(ReputationWatchStatusBar, toggle);
end

function Archaeologist_PetXPOnOffMouseover(toggle)
	OverrideShowStatusBarText(PetPaperDollFrameExpBar, toggle);
end

function Archaeologist_RestorePlayerHP()
	Archaeologist_PrimaryOnOffMouseover("player", "healthbar", ArchaeologistVars["PLAYERHP"]);
end

function Archaeologist_RestorePlayerMP()
	Archaeologist_PrimaryOnOffMouseover("player", "manabar", ArchaeologistVars["PLAYERMP"]);
end

function Archaeologist_RestorePlayerXP()
	Archaeologist_PlayerXPOnOffMouseover(ArchaeologistVars["MAINXP"])
end

function Archaeologist_RestorePlayerRep()
	Archaeologist_PlayerRepOnOffMouseover(ArchaeologistVars["MAINREP"])
end

-- <= == == == == == == == == == == == == =>
-- => Change HP/MP/XP Values to Percent Functions
-- <= == == == == == == == == == == == == =>

function Archaeologist_TurnOnPlayerXPPercent(toggle)
	Archaeologist_TextStringPercentStatusBars["MainMenuExpBar"] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(MainMenuExpBar);
	if (UnitLevel('player') == MAX_PLAYER_LEVEL) then
		MainMenuExpBar:Hide();
	end
end

function Archaeologist_TurnOnPlayerXPValue(toggle)
	Archaeologist_TextStringValueStatusBars["MainMenuExpBar"] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(MainMenuExpBar);
	if (UnitLevel('player') == MAX_PLAYER_LEVEL) then
		MainMenuExpBar:Hide();
	end
end

function Archaeologist_TurnOnPlayerRepPercent(toggle)
	Archaeologist_TextStringPercentStatusBars["ReputationWatchStatusBar"] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(ReputationWatchStatusBar);
end

function Archaeologist_TurnOnPlayerRepValue(toggle)
	Archaeologist_TextStringValueStatusBars["ReputationWatchStatusBar"] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(ReputationWatchStatusBar);
end

function Archaeologist_TurnOnPetXPPercent(toggle)
	Archaeologist_TextStringPercentStatusBars["PetPaperDollFrameExpBar"] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(PetPaperDollFrameExpBar);
end

function Archaeologist_TurnOnPetXPValue(toggle)
	Archaeologist_TextStringValueStatusBars["PetPaperDollFrameExpBar"] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(PetPaperDollFrameExpBar);
end

-- <= == == == == == == == == == == == == =>
-- => Hide Max HP/MP Values
-- <= == == == == == == == == == == == == =>

function Archaeologist_TurnOffPlayerHPMaxValue(toggle)
	local statusBar = ArchaeologistStatusBars["player"].frame.healthbar;
	Archaeologist_TextStringHideMaxValueStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOffPlayerMPMaxValue(toggle)
	local statusBar = ArchaeologistStatusBars["player"].frame.manabar;
	Archaeologist_TextStringHideMaxValueStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOffPlayerXPMaxValue(toggle)
	local statusBar = MainMenuExpBar;
	Archaeologist_TextStringHideMaxValueStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
	if (UnitLevel('player') == MAX_PLAYER_LEVEL) then
		MainMenuExpBar:Hide();
	end
end

function Archaeologist_TurnOffPlayerRepMaxValue(toggle)
	local statusBar = ReputationWatchStatusBar;
	Archaeologist_TextStringHideMaxValueStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOffPartyHPMaxValue(toggle)
	for i=1, 4 do
		local statusBar = ArchaeologistStatusBars["party"..i].frame.healthbar;
		Archaeologist_TextStringHideMaxValueStatusBars[statusBar:GetName()] = toggle;
		Archaeologist_TextStatusBar_UpdateTextString(statusBar);
	end
end

function Archaeologist_TurnOffPartyMPMaxValue(toggle)
	for i=1, 4 do
		local statusBar = ArchaeologistStatusBars["party"..i].frame.manabar;
		Archaeologist_TextStringHideMaxValueStatusBars[statusBar:GetName()] = toggle;
		Archaeologist_TextStatusBar_UpdateTextString(statusBar);
	end
end

function Archaeologist_TurnOffTargetHPMaxValue(toggle)
	local statusBar = ArchaeologistStatusBars["target"].frame.healthbar;
	Archaeologist_TextStringHideMaxValueStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOffTargetMPMaxValue(toggle)
	local statusBar = ArchaeologistStatusBars["target"].frame.manabar;
	Archaeologist_TextStringHideMaxValueStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end


function Archaeologist_TurnOffPetHPMaxValue(toggle)
	local statusBar = ArchaeologistStatusBars["pet"].frame.healthbar;
	Archaeologist_TextStringHideMaxValueStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOffPetMPMaxValue(toggle)
	local statusBar = ArchaeologistStatusBars["pet"].frame.manabar;
	Archaeologist_TextStringHideMaxValueStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOffPetXPMaxValue(toggle)
	local statusBar = PetPaperDollFrameExpBar;
	Archaeologist_TextStringHideMaxValueStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

-- <= == == == == == == == == == == == == =>
-- => Invert HP/MP/XP Values
-- <= == == == == == == == == == == == == =>

-- Values
function Archaeologist_TurnOnPlayerHPValueInvert(toggle)
	local statusBar = ArchaeologistStatusBars["player"].frame.healthbar;
	Archaeologist_TextStringInvertValueStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOnPlayerMPValueInvert(toggle)
	local statusBar = ArchaeologistStatusBars["player"].frame.manabar;
	Archaeologist_TextStringInvertValueStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOnPlayerXPValueInvert(toggle)
	local statusBar = MainMenuExpBar;
	Archaeologist_TextStringInvertValueStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
	if (UnitLevel('player') == MAX_PLAYER_LEVEL) then
		statusBar:Hide();
	end
end

function Archaeologist_TurnOnPlayerRepValueInvert(toggle)
	local statusBar = ReputationWatchStatusBar;
	Archaeologist_TextStringInvertValueStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOnPartyHPValueInvert(toggle)
	for i=1, 4 do
		local statusBar = ArchaeologistStatusBars["party"..i].frame.healthbar;
		Archaeologist_TextStringInvertValueStatusBars[statusBar:GetName()] = toggle;
		Archaeologist_TextStatusBar_UpdateTextString(statusBar);
	end
end

function Archaeologist_TurnOnPartyMPValueInvert(toggle)
	for i=1, 4 do
		local statusBar = ArchaeologistStatusBars["party"..i].frame.manabar;
		Archaeologist_TextStringInvertValueStatusBars[statusBar:GetName()] = toggle;
		Archaeologist_TextStatusBar_UpdateTextString(statusBar);
	end
end

function Archaeologist_TurnOnTargetHPValueInvert(toggle)
	local statusBar = ArchaeologistStatusBars["target"].frame.healthbar;
	Archaeologist_TextStringInvertValueStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOnTargetMPValueInvert(toggle)
	local statusBar = ArchaeologistStatusBars["target"].frame.manabar;
	Archaeologist_TextStringInvertValueStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end


function Archaeologist_TurnOnPetHPValueInvert(toggle)
	local statusBar = ArchaeologistStatusBars["pet"].frame.healthbar;
	Archaeologist_TextStringInvertValueStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOnPetMPValueInvert(toggle)
	local statusBar = ArchaeologistStatusBars["pet"].frame.manabar;
	Archaeologist_TextStringInvertValueStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOnPetXPValueInvert(toggle)
	local statusBar = PetPaperDollFrameExpBar;
	Archaeologist_TextStringInvertValueStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

-- Percents
function Archaeologist_TurnOnPlayerHPPercentInvert(toggle)
	local statusBar = ArchaeologistStatusBars["player"].frame.healthbar;
	Archaeologist_TextStringInvertPercentStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOnPlayerMPPercentInvert(toggle)
	local statusBar = ArchaeologistStatusBars["player"].frame.manabar;
	Archaeologist_TextStringInvertPercentStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOnPlayerXPPercentInvert(toggle)
	local statusBar = MainMenuExpBar;
	Archaeologist_TextStringInvertPercentStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
	if (UnitLevel('player') == MAX_PLAYER_LEVEL) then
		statusBar:Hide();
	end
end

function Archaeologist_TurnOnPlayerRepPercentInvert(toggle)
	local statusBar = ReputationWatchStatusBar;
	Archaeologist_TextStringInvertPercentStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOnPartyHPPercentInvert(toggle)
	for i=1, 4 do
		local statusBar = ArchaeologistStatusBars["party"..i].frame.healthbar;
		Archaeologist_TextStringInvertPercentStatusBars[statusBar:GetName()] = toggle;
		Archaeologist_TextStatusBar_UpdateTextString(statusBar);
	end
end

function Archaeologist_TurnOnPartyMPPercentInvert(toggle)
	for i=1, 4 do
		local statusBar = ArchaeologistStatusBars["party"..i].frame.manabar;
		Archaeologist_TextStringInvertPercentStatusBars[statusBar:GetName()] = toggle;
		Archaeologist_TextStatusBar_UpdateTextString(statusBar);
	end
end

function Archaeologist_TurnOnTargetHPPercentInvert(toggle)
	local statusBar = ArchaeologistStatusBars["target"].frame.healthbar;
	Archaeologist_TextStringInvertPercentStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOnTargetMPPercentInvert(toggle)
	local statusBar = ArchaeologistStatusBars["target"].frame.manabar;
	Archaeologist_TextStringInvertPercentStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end


function Archaeologist_TurnOnPetHPPercentInvert(toggle)
	local statusBar = ArchaeologistStatusBars["pet"].frame.healthbar;
	Archaeologist_TextStringInvertPercentStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOnPetMPPercentInvert(toggle)
	local statusBar = ArchaeologistStatusBars["pet"].frame.manabar;
	Archaeologist_TextStringInvertPercentStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOnPetXPPercentInvert(toggle)
	local statusBar = PetPaperDollFrameExpBar;
	Archaeologist_TextStringInvertPercentStatusBars[statusBar:GetName()] = toggle;
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

-- <= == == == == == == == == == == == == =>
-- => Hide HP/MP/XP Value Prefix Functions
-- <= == == == == == == == == == == == == =>

function Archaeologist_UnitFrame_UpdateManaType(unitFrame)
	if ( not unitFrame ) then
		unitFrame = this;
	end
	if ( not unitFrame.manabar ) then
		return;
	end
	local info = ManaBarColor[UnitPowerType(unitFrame.unit)];
	unitFrame.manabar:SetStatusBarColor(info.r, info.g, info.b);
	
	-- Update the manabar prefix only if not hidden
	if ( Archaeologist_ManaPrefixNotHidden(unitFrame) ) then
		SetTextStatusBarTextPrefix(unitFrame.manabar, info.prefix);
		TextStatusBar_UpdateTextString(unitFrame.manabar);
	end

	-- Setup newbie tooltip
	if ( unitFrame:GetName() == "PlayerFrame" ) then
		unitFrame.manabar.tooltipTitle = info.prefix;
		unitFrame.manabar.tooltipText = getglobal("NEWBIE_TOOLTIP_MANABAR"..UnitPowerType(unitFrame.unit));
	else
		unitFrame.manabar.tooltipTitle = nil;
		unitFrame.manabar.tooltipText = nil;
	end
	
end


function Archaeologist_ManaPrefixNotHidden(frame)
	if  ( (ArchaeologistVars["PLAYERMPNOPREFIX"] == 0) and (frame == ArchaeologistStatusBars.player.frame) ) or
		( (ArchaeologistVars["PARTYMPNOPREFIX"] == 0) and (
			(frame == ArchaeologistStatusBars.party1.frame) or
			(frame == ArchaeologistStatusBars.party2.frame) or
			(frame == ArchaeologistStatusBars.party3.frame) or
			(frame == ArchaeologistStatusBars.party4.frame)
		) ) or
		( (ArchaeologistVars["PETMPNOPREFIX"] == 0) and (frame == ArchaeologistStatusBars.pet.frame) ) or
		( (ArchaeologistVars["TARGETMPNOPREFIX"] == 0) and (frame == ArchaeologistStatusBars.target.frame) )
	then
		return true;
	end
end


function Archaeologist_TurnOffUnitHPPrefix(unit, toggle)
	local statusBar = ArchaeologistStatusBars[unit].frame.healthbar;
	if (toggle == 1) then
		SetTextStatusBarTextPrefix(statusBar, nil);
	else
		SetTextStatusBarTextPrefix(statusBar, TEXT("HEALTH"));
	end
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOffUnitMPPrefix(unit, toggle)
	local statusBar = ArchaeologistStatusBars[unit].frame.manabar;
	if (toggle == 1) then
		SetTextStatusBarTextPrefix(statusBar, nil);
	else
		SetTextStatusBarTextPrefix(statusBar, ManaBarColor[UnitPowerType(unit)].prefix);
	end
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end


function Archaeologist_TurnOffPlayerHPPrefix(toggle)
	Archaeologist_TurnOffUnitHPPrefix("player", toggle)
end

function Archaeologist_TurnOffPlayerMPPrefix(toggle)
	Archaeologist_TurnOffUnitMPPrefix("player", toggle)
end

function Archaeologist_TurnOffPlayerXPPrefix(toggle)
	local statusBar = MainMenuExpBar;
	if (toggle == 1) then
		SetTextStatusBarTextPrefix(statusBar, nil);
	else
		SetTextStatusBarTextPrefix(statusBar, TEXT("XP"));
	end
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
	if (UnitLevel('player') == MAX_PLAYER_LEVEL) then
		MainMenuExpBar:Hide();
	end
end

function Archaeologist_TurnOffPlayerRepPrefix(toggle)
	local statusBar = ReputationWatchStatusBar;
	if (toggle == 1) then
		SetTextStatusBarTextPrefix(statusBar, nil);
	else
		local name, reaction, min, max, value = GetWatchedFactionInfo();
		SetTextStatusBarTextPrefix(statusBar, name);
	end
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_UpdatePlayerRepPrefix()
	local statusBar = ReputationWatchStatusBar;
	if (ArchaeologistVars["MAINREPNOPREFIX"] == 1) then
		SetTextStatusBarTextPrefix(statusBar, nil);
	else
		local name, reaction, min, max, value = GetWatchedFactionInfo();
		SetTextStatusBarTextPrefix(statusBar, name);
	end
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end

function Archaeologist_TurnOffPartyHPPrefix(toggle)
	Archaeologist_TurnOffUnitHPPrefix("party1", toggle)
	Archaeologist_TurnOffUnitHPPrefix("party2", toggle)
	Archaeologist_TurnOffUnitHPPrefix("party3", toggle)
	Archaeologist_TurnOffUnitHPPrefix("party4", toggle)
end

function Archaeologist_TurnOffPartyMPPrefix(toggle)
	Archaeologist_TurnOffUnitMPPrefix("party1", toggle)
	Archaeologist_TurnOffUnitMPPrefix("party2", toggle)
	Archaeologist_TurnOffUnitMPPrefix("party3", toggle)
	Archaeologist_TurnOffUnitMPPrefix("party4", toggle)
end

function Archaeologist_TurnOffTargetHPPrefix(toggle)
	Archaeologist_TurnOffUnitHPPrefix("target", toggle)
end

function Archaeologist_TurnOffTargetMPPrefix(toggle)
	Archaeologist_TurnOffUnitMPPrefix("target", toggle)
end


function Archaeologist_TurnOffPetHPPrefix(toggle)
	Archaeologist_TurnOffUnitHPPrefix("pet", toggle)
end

function Archaeologist_TurnOffPetMPPrefix(toggle)
	Archaeologist_TurnOffUnitMPPrefix("pet", toggle)
end

function Archaeologist_TurnOffPetXPPrefix(toggle)
	local statusBar = PetPaperDollFrameExpBar;
	if (toggle == 1) then
		SetTextStatusBarTextPrefix(statusBar, nil);
	else
		SetTextStatusBarTextPrefix(statusBar, TEXT("XP"));
	end
	Archaeologist_TextStatusBar_UpdateTextString(statusBar);
end


-- <= == == == == == == == == == == == == =>
-- => Status HP/MP/XP Bar Overrides
-- <= == == == == == == == == == == == == =>

function OverrideShowStatusBarText(bar, toggle)
	if (type(toggle) == "string") then
		if (toggle == "on") then
			SetStatusBarTextOverride(bar, 1);
		elseif (toggle == "off") then
			SetStatusBarTextOverride(bar, 0);
		else --mouseover
			SetStatusBarTextOverride(bar, nil);
		end
	else
		if (toggle == 1) then
			SetStatusBarTextOverride(bar, 1);
		else
			SetStatusBarTextOverride(bar, nil);
		end
	end
end

function OverrideShowStatusBarText2(bar, toggle)
	if (type(toggle) == "string") then
		if (toggle == "on") then
			SetStatusBarTextOverride2(bar, 1);
		elseif (toggle == "off") then
			SetStatusBarTextOverride2(bar, 0);
		else --mouseover
			SetStatusBarTextOverride2(bar, nil);
		end
	else
		if (toggle == 1) then
			SetStatusBarTextOverride2(bar, 1);
		else
			SetStatusBarTextOverride2(bar, nil);
		end
	end
end

--[[unused.. yet
function OverrideHideStatusBarText(bar, toggle)
	if (toggle == 1) then
		SetStatusBarTextOverride(bar, 0);
	else
		SetStatusBarTextOverride(bar, nil);
	end
end
]]--

--sets the override for StatusBarTexts.
--override = nil removes override, 0 sets to hide, 1 sets to show
function SetStatusBarTextOverride(bar, override)
	if(not bar) then
		return;
	end
	if(override == "1" or override == 1 or override == "show") then
		bar.override = "show";
		--UIOptionsFrameCheckButtons["STATUS_BAR_TEXT"].value = "1"
		if (bar ~= MainMenuExpBar) or (UnitLevel('player') < MAX_PLAYER_LEVEL) then
			ShowTextStatusBarText(bar);
		end
	elseif(override == "0" or override == 0 or override == "hide") then
		bar.override = "hide";
		HideTextStatusBarText(bar);
	else
		bar.override = nil;
		HideTextStatusBarText(bar);
	end
end

--sets the override for secondary StatusBarTexts.
--override = nil removes override, 0 sets to hide, 1 sets to show
function SetStatusBarTextOverride2(bar, override)
	if(not bar) then
		return;
	end
	if(override == "1" or override == 1 or override == "show") then
		bar.override2 = "show";
		if (bar ~= MainMenuExpBar) or (UnitLevel('player') < MAX_PLAYER_LEVEL) then
			Archaeologist_ShowTextStatusBarText2(bar);
		end
	elseif(override == "0" or override == 0 or override == "hide") then
		bar.override2 = "hide";
		Archaeologist_HideTextStatusBarText2(bar);
	else
		bar.override2 = nil;
		Archaeologist_HideTextStatusBarText2(bar);
	end
end


--updates old lockShow to the new override notation
local function ConvertLockShowToOverrideSyntax(bar)
	if (bar.textLockable) then
		bar.textLockable = nil;
	end
	if (bar.lockShow) then
		if (bar.lockShow == 1) then
			bar.override = "show";
		end
		bar.lockShow = nil;
	end
end


--allows the setting of textStatusBar.oneText to override other values if value = 1
--used to hide hp text of a ghost
--also added optional percents
function Archaeologist_TextStatusBar_UpdateTextString(textStatusBar)
	if ( not textStatusBar ) then
		textStatusBar = this;
	end
	local string = textStatusBar.TextString;
	local string2 = textStatusBar.TextString2;
	if (string) then
		local value = textStatusBar:GetValue();
		local valueMin, valueMax = textStatusBar:GetMinMaxValues();
		if ( valueMax > 0 ) then
			textStatusBar:Show();
			if (textStatusBar.isOffline) then
				HideTextStatusBarText(textStatusBar);
				Archaeologist_HideTextStatusBarText2(textStatusBar);
			elseif ( value == 0 and textStatusBar.zeroText ) then
				string:SetText(textStatusBar.zeroText);
				textStatusBar.isZero = 1;
				ShowTextStatusBarText(textStatusBar);
			elseif ( value == 1 and textStatusBar.oneText ) then
				string:SetText(textStatusBar.oneText);
				textStatusBar.isOne = 1;
				ShowTextStatusBarText(textStatusBar);
			else
				textStatusBar.isZero = nil;
				textStatusBar.isOne = nil;
				
				local barName = textStatusBar:GetName();
				local stringText1, stringText2 = Archaeologist_GetCurrentTextStrings(
					value, valueMax,
					textStatusBar.prefix,
					(not Archaeologist_TextStringPercentStatusBars[barName]) or (Archaeologist_TextStringPercentStatusBars[textStatusBar:GetName()] == 1),
					(Archaeologist_TextStringValueStatusBars[barName] == 1),
					(Archaeologist_TextStringInvertPercentStatusBars[barName] == 1),
					(Archaeologist_TextStringInvertValueStatusBars[barName] == 1),
					(textStatusBar == TargetFrame.healthbar),
					(Archaeologist_TextStringAltTextStatusBars[barName] == 1),
					(textStatusBar == TargetFrame.healthbar) and (ArchaeologistVars["THPALT"] == 1),
					(Archaeologist_TextStringHideMaxValueStatusBars[barName] == 1)
				);
				string:SetText(stringText1);
				if (string2) then
					string2:SetText(stringText2);
				end
				
				if (textStatusBar.showWhileOverFrame) then
					if (textStatusBar.override == "show") or (textStatusBar:GetLeft()) and (MouseIsOver(textStatusBar.showWhileOverFrame)) then
						ShowTextStatusBarText(textStatusBar);
					else
						HideTextStatusBarText(textStatusBar);
					end
					
					if (textStatusBar.override2 == "show") or (textStatusBar:GetLeft()) and (MouseIsOver(textStatusBar.showWhileOverFrame)) then
						Archaeologist_ShowTextStatusBarText2(textStatusBar);
					else
						Archaeologist_HideTextStatusBarText2(textStatusBar);
					end
				else
					if (textStatusBar.override == "show") or (textStatusBar:GetLeft()) and (MouseIsOver(textStatusBar)) then
						ShowTextStatusBarText(textStatusBar);
					else
						HideTextStatusBarText(textStatusBar);
					end
					
					if (textStatusBar.override2 == "show") or (textStatusBar:GetLeft()) and (MouseIsOver(textStatusBar)) then
						Archaeologist_ShowTextStatusBarText2(textStatusBar);
					else
						Archaeologist_HideTextStatusBarText2(textStatusBar);
					end
				end
			end
		else
			textStatusBar:Hide();
		end
	end
end

function Archaeologist_GetCurrentTextStrings(value, valueMax, prefix, percent, exactValue, invertP, invertV, isTargetHP, altText, altTargetHP, hideMaxValue)
	
	local stringText1 = "";
	local stringText2 = "";
	local percentText;
	if (invertP) then
		percentText = "-"..(100-Archaeologist_Round(value / valueMax * 100)).."%";
	else
		percentText = Archaeologist_Round(value / valueMax * 100).."%";
	end
	local valueText;
	
	local mobValue, mobValueMax;
	-- Create Value String
	-- Special Case Target HP (Passed as Percent)
	if (isTargetHP) and (valueMax == 100) then
		value = nil;
		valueMax = nil;
		if (MobHealth_GetTargetCurHP) and (MobHealth_GetTargetMaxHP) and (ArchaeologistVars["MOBHEALTH"] == 1) then
			mobValue = MobHealth_GetTargetCurHP();
			mobValueMax = MobHealth_GetTargetMaxHP();
			if (mobValue) and (mobValueMax) and (mobValueMax ~= 0) then
				-- Use estimated hp values
				value = mobValue;
				valueMax = mobValueMax;
			end
		end
	end
	
	if (value) and (valueMax) then
		-- Account for optionally hidden Max Value
		if (hideMaxValue) then
			valueText = "";
		else
			valueText = " / "..valueMax;
		end
		-- Account for Inverted Value Display
		if (invertV) then
			valueText = "-"..(valueMax-value)..valueText;
		else
			valueText = value..valueText;
		end
	elseif (altTargetHP) then
		-- altTargetHP hides value when unavailible
		valueText = "";
	else
		-- Value display defaults to percent
		valueText = percentText;
	end
	
	-- Set the values and percents to the right string (1 or 2)
	if (percent) and (exactValue) then
		stringText1 = percentText.." "..valueText;
		stringText2 = percentText.." "..valueText;
	elseif (percent) then
		stringText1 = percentText;
		stringText2 = valueText;
	elseif (exactValue) then
		stringText1 = valueText;
		stringText2 = valueText;
	end
	
	-- Account for display swap
	if (altText) then
		local temp = stringText1;
		stringText1 = stringText2;
		stringText2 = temp;
	end
	
	-- Account for prefix
	if (prefix) then
		stringText1 = prefix.." "..stringText1;
	end
	return stringText1, stringText2;
end

--removes lockShow and adds override
function Archaeologist_ShowTextStatusBarText(bar)
	if ( bar and bar.TextString ) then
		ConvertLockShowToOverrideSyntax(bar);
		if (bar.override ~= "hide") and (not bar.isOffline) then
			bar.TextString:Show();
		end
	end
end

function Archaeologist_ShowTextStatusBarText2(bar)
	if ( bar and bar.TextString2 ) then
		if (bar.override2 ~= "hide") and (not bar.isOffline) then
			bar.TextString2:Show();
		end
	end
end

--removes old lockShow, adds override, adds visibility for isOne, and removes UIOptions check
--effectively breaks the 'Show HP/Mana/XP Always Vislible' in the default UIOptions
function Archaeologist_HideTextStatusBarText(bar)
	if ( bar and bar.TextString ) then
		ConvertLockShowToOverrideSyntax(bar);
		if (bar.override == "hide") or (bar.isOffline) then
			bar.TextString:Hide();
		elseif (bar.isZero) or (bar.isOne) or (bar.override == "show") then -- or (MouseIsOver(bar)) then
			bar.TextString:Show();
		else
			bar.TextString:Hide();
		end
	end
end

function Archaeologist_HideTextStatusBarText2(bar)
	if ( bar and bar.TextString2 ) then
		if (bar.override2 == "hide") or (bar.isOffline) then
			bar.TextString2:Hide();
		elseif (bar.isZero) or (bar.isOne) or (bar.override2 == "show") then -- or (MouseIsOver(bar)) then
			bar.TextString2:Show();
		else
			bar.TextString2:Hide();
		end
	end
end

function Archaeologist_HookStatusBars_OnLeave()
	local afterHook = function(bar)
		Archaeologist_HideTextStatusBarText2(bar);
	end
	for unit, data in ArchaeologistStatusBars do
		local bar1 = data.frame.healthbar;
		setglobal("Archaeologist_"..bar1:GetName().."_OnLeave_orig", bar1:GetScript("OnLeave"));
		bar1:SetScript("OnLeave", function() getglobal("Archaeologist_"..bar1:GetName().."_OnLeave_orig")(); afterHook(bar1); end);
		
		local bar2 = data.frame.manabar;
		setglobal("Archaeologist_"..bar2:GetName().."_OnLeave_orig", bar2:GetScript("OnLeave"));
		bar2:SetScript("OnLeave", function() getglobal("Archaeologist_"..bar2:GetName().."_OnLeave_orig")(); afterHook(bar2); end);
	end
	
	ReputationWatchBar:SetScript("OnEnter", function() Archaeologist_ShowTextStatusBarText(ReputationWatchStatusBar) end);
	ReputationWatchBar:SetScript("OnLeave", function() Archaeologist_HideTextStatusBarText(ReputationWatchStatusBar) end);
end

--sets bar.oneText
function SetTextStatusBarTextOneText(bar, oneText)
	if ( bar and bar.TextString ) then
		bar.oneText = oneText;
	end
end

function Archaeologist_CharacterFrame_OnShow()
	PlaySound("igCharacterInfoOpen");
	SetPortraitTexture(CharacterFramePortrait, "player");
	CharacterNameText:SetText(UnitPVPName("player"));
	UpdateMicroButtons();
	OverrideShowStatusBarText(PlayerFrameHealthBar, 1);
	OverrideShowStatusBarText(PlayerFrameManaBar, 1);
	OverrideShowStatusBarText(MainMenuExpBar, 1);
	OverrideShowStatusBarText(ReputationWatchStatusBar, 1);
end

function Archaeologist_CharacterFrame_OnHide()
	PlaySound("igCharacterInfoClose");
	UpdateMicroButtons();
	Archaeologist_RestorePlayerHP();
	Archaeologist_RestorePlayerMP();
	Archaeologist_RestorePlayerXP();
	Archaeologist_RestorePlayerRep();
end

-- <= == == == == == == == == == == == == =>
-- => Dead/Offline/Ghost Status Overrides
-- <= == == == == == == == == == == == == =>


function Archaeologist_TargetCheckDead()
	local unit = "target";
	local healthbar = ArchaeologistStatusBars[unit].frame.healthbar;
	local manabar = ArchaeologistStatusBars[unit].frame.manabar;
	local statusText = ArchaeologistStatusBars[unit].statusText;
	Archaeologist_UnitCheckDead(unit, statusText, healthbar, manabar);
end


function Archaeologist_PartyCheckDead(partyIndex)
	if (type(partyIndex) ~= "number")  then
		return;
	end
	local unit = "party"..partyIndex;
	local healthbar = ArchaeologistStatusBars[unit].frame.healthbar;
	local manabar = ArchaeologistStatusBars[unit].frame.manabar;
	local statusText = ArchaeologistStatusBars[unit].statusText;
	Archaeologist_UnitCheckDead(unit, statusText, healthbar, manabar);
end


function Archaeologist_UpdatePartyMembersDead()
	if (GetNumPartyMembers() > 0) then
		for i=1, GetNumPartyMembers() do
			Archaeologist_PartyCheckDead(i);
		end
	end
end


function Archaeologist_PlayerCheckDead()
	local unit = "player";
	local healthbar = ArchaeologistStatusBars[unit].frame.healthbar;
	local manabar = ArchaeologistStatusBars[unit].frame.manabar;
	local statusText = ArchaeologistStatusBars[unit].statusText;
	Archaeologist_UnitCheckDead(unit, statusText, healthbar, manabar);
end


function Archaeologist_PetCheckDead()
	local unit = "pet";
	local healthbar = ArchaeologistStatusBars[unit].frame.healthbar;
	local manabar = ArchaeologistStatusBars[unit].frame.manabar;
	local statusText = ArchaeologistStatusBars[unit].statusText;
	Archaeologist_UnitCheckDead(unit, statusText, healthbar, manabar);
end


function Archaeologist_UnitCheckDead(unit, statusText, healthbar, manabar)
	--adds Dead text if unit is Dead
	--adds Offline text if unit is a player and not connected
	--adds Ghost/Wisp text if unit is a player
	
	healthbar.isOffline = nil;
	manabar.isOffline = nil;
	
	if ( UnitIsDead(unit) ) and ( Archaeologist_UnitIsConnected(unit) ) then
		local _, class = UnitClass(unit);
		if (ArchaeologistStatusBars[unit].frame.feigning) or (class == "HUNTER" and UnitIsEnemy("player", unit)) then
			statusText:SetText(TEXT("FEIGN_DEATH"));
		else
			statusText:SetText(TEXT("PLAYER_DEAD"));
		end
		statusText:Show();
		
		--hide health/mana if dead 
		SetTextStatusBarTextZeroText(healthbar, "");
		SetTextStatusBarTextZeroText(manabar, "");
		
	elseif ( UnitIsPlayer(unit) ) and ( not Archaeologist_UnitIsConnected(unit) ) then
		
		statusText:SetText(PLAYER_OFFLINE);
		--healthbar:Hide();
		healthbar.isOffline = 1;
		--manabar:Hide();
		manabar.isOffline = 1;
		statusText:Show();
		
		--hide health/mana if offline 
		SetTextStatusBarTextZeroText(healthbar, "");
		SetTextStatusBarTextZeroText(manabar, "");
		
	elseif ( UnitIsGhost(unit) ) then
	
		if ( UnitRace(unit) == "Night Elf" ) then
			statusText:SetText(TEXT("PLAYER_WISP"));
		else
			statusText:SetText(TEXT("PLAYER_GHOST"));
		end
		statusText:Show();

		--hide health/mana if ghost 
		SetTextStatusBarTextOneText(healthbar, "");
		SetTextStatusBarTextZeroText(manabar, "");
		
	else
	
		statusText:Hide();
		
		--show health/mana if not dead, offline or ghost
		SetTextStatusBarTextZeroText(healthbar, nil);
		SetTextStatusBarTextOneText(healthbar, nil);
		SetTextStatusBarTextZeroText(manabar, nil);
		
		--reset to override show
		ShowTextStatusBarText(healthbar);
		
	end
	
	TextStatusBar_UpdateTextString(healthbar);
	TextStatusBar_UpdateTextString(manabar);
	
end

function Archaeologist_UnitIsConnected(unit)
	ArchaeologistTooltip:SetOwner(UIParent, "ANCHOR_NONE");
	ArchaeologistTooltip:SetUnit(unit);
	if (ArchaeologistTooltipTextLeft3:IsShown()) and (ArchaeologistTooltipTextLeft3:GetText() == PLAYER_OFFLINE) then
		ArchaeologistTooltip:ClearLines();
		ArchaeologistTooltip:Hide();
		return;
	end
	ArchaeologistTooltip:ClearLines();
	ArchaeologistTooltip:Hide();
	return UnitIsConnected(unit);
end


-- <= == == == == == == == == == == == == =>
-- => Party and Pet Buffs
-- <= == == == == == == == == == == == == =>

function Archaeologist_UpdateOverlapPositions()
	Archaeologist_UpdatePartyMemberLocations();
	Archaeologist_UpdatePartyPetLocations();
	Archaeologist_UpdateTargetLocation();
end
	
function Archaeologist_UpdatePartyMemberLocations()
	local partyY = 0;   --Normal Offset
	if (ArchaeologistVars["PPTBUFFS"] == 0) and (ArchaeologistVars["PPTDEBUFFS"] == 0) then
		partyY = -20;   --Party Frames moved down 20 to make room for PartyPet Buffs and Debuffs
	end
	
	if (not PartyMemberFrame2:IsUserPlaced()) then
		PartyMemberFrame2:ClearAllPoints()
		PartyMemberFrame2:SetPoint("TOPLEFT", "PartyMemberFrame1PetFrame", "BOTTOMLEFT", -23, -10+partyY);
	end
	if (not PartyMemberFrame3:IsUserPlaced()) then
		PartyMemberFrame3:ClearAllPoints()
		PartyMemberFrame3:SetPoint("TOPLEFT", "PartyMemberFrame2PetFrame", "BOTTOMLEFT", -23, -10+partyY);
	end
	if (not PartyMemberFrame4:IsUserPlaced()) then
		PartyMemberFrame4:ClearAllPoints()
		PartyMemberFrame4:SetPoint("TOPLEFT", "PartyMemberFrame3PetFrame", "BOTTOMLEFT", -23, -10+partyY);
	end
end

function Archaeologist_UpdateTargetLocation()
	if (not TargetFrame:IsUserPlaced()) and (not PlayerFrame:IsUserPlaced()) then
		if (PlayerFrame:GetRight()) then
			local y = TargetFrame:GetTop() - UIParent:GetTop();
			local x = PlayerFrame:GetRight();
			if (ArchaeologistVars["TARGETHP2"] == "on") or (ArchaeologistVars["TARGETMP2"] == "on") or (ArchaeologistVars["PLAYERHP2"] == "on") or (ArchaeologistVars["PLAYERMP2"] == "on") then
				-- Only Move if the Secondary Display is on
				TargetFrame:ClearAllPoints()
				TargetFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", x+145, y);
			elseif (ArchaeologistVars["TARGETHP2"] == "mouseover") or (ArchaeologistVars["TARGETMP2"] == "mouseover") or (ArchaeologistVars["PLAYERHP2"] == "mouseover") or (ArchaeologistVars["PLAYERMP2"] == "mouseover") then
				-- Adjust for single Secondary Display mouseover
				TargetFrame:ClearAllPoints();
				TargetFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", x+75, y);
			else
				--Default
				TargetFrame:ClearAllPoints();
				TargetFrame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 250, y);
			end
		else
			--Dumb GetLeft == nil bug... don't do anything
		end
	end
end

function Archaeologist_PartyMemberFrame_UpdatePet(id)
	if ( not id ) then
		id = this:GetID();
	end
	
	local frameName = "PartyMemberFrame"..id;
	local petFrame = getglobal("PartyMemberFrame"..id.."PetFrame");
	
	local partypetY = 0;   --Normal Offset
	if ( UnitIsConnected("party"..id) and UnitExists("partypet"..id) and SHOW_PARTY_PETS == "1" ) then
		petFrame:Show();
		if (not petFrame:IsUserPlaced()) then
			if (ArchaeologistVars["PBUFFS"] == 0) and (ArchaeologistVars["PDEBUFFS"] == 0) and (ArchaeologistVars["DEBUFFALT"] == 1) then
				partypetY = -20;	--PartyPet Frames moved down 20 to make room for Pet Buffs and Debuffs
			end
		end
	else
		petFrame:Hide();
		if (not petFrame:IsUserPlaced()) then
			partypetY = 16  --PartyPet Frames moved up 16 to close party member gap
		end
	end
	
	petFrame:ClearAllPoints();
	petFrame:SetPoint("TOPLEFT", frameName, "TOPLEFT", 23, -43+partypetY);
	
	PartyMemberFrame_RefreshPetBuffs(id);
end

Archaeologist_BuffNums = {};
Archaeologist_BuffNums.pet = {
	buffs = "PTBUFFNUM";
	debuffs = "PTDEBUFFNUM";
	buffsEnabled = "PTBUFFS";
	debuffsEnabled = "PTDEBUFFS";
};
Archaeologist_BuffNums.target = {
	buffs = "TBUFFNUM";
	debuffs = "TDEBUFFNUM";
	buffsEnabled = "TBUFFS";
	debuffsEnabled = "TDEBUFFS";
};
Archaeologist_BuffNums.party1 = {
	buffs = "PBUFFNUM";
	debuffs = "PDEBUFFNUM";
	buffsEnabled = "PBUFFS";
	debuffsEnabled = "PDEBUFFS";
};
Archaeologist_BuffNums.party2 = Archaeologist_BuffNums.party1;
Archaeologist_BuffNums.party3 = Archaeologist_BuffNums.party1;
Archaeologist_BuffNums.party4 = Archaeologist_BuffNums.party1;
Archaeologist_BuffNums.partypet1 = {
	buffs = "PPTBUFFNUM";
	debuffs = "PPTDEBUFFNUM";
	buffsEnabled = "PPTBUFFS";
	debuffsEnabled = "PPTDEBUFFS";
};
Archaeologist_BuffNums.partypet2 = Archaeologist_BuffNums.partypet1;
Archaeologist_BuffNums.partypet3 = Archaeologist_BuffNums.partypet1;
Archaeologist_BuffNums.partypet4 = Archaeologist_BuffNums.partypet1;

function Archaeologist_RefreshBuffsBufFix(button, showBuffs, unit)
	if (unit == "targettarget" and button:GetName() == "TargetFrame") then
		return true, TargetofTargetFrame, showBuffs, unit;
	end
end

function Archaeologist_RefreshBuffs(button, showBuffs, unit)
	local buffNums = Archaeologist_BuffNums[unit];
	if (not buffNums) then
		return true;
	end
	if (type(button) ~= "string") then
		button = button:GetName();
	end
	local texture, debuffType, debuffStack, debuffColor, unitStatus, statusColor, debuffBorder, debuffIcon;
	local debuffTotal = 0;
	this.hasDispellable = nil;
	this.feigning = nil;
	
	local maxBuffs = ArchaeologistVarData[buffNums.buffs].max;
	local maxDebuffs = ArchaeologistVarData[buffNums.debuffs].max;
	local numBuffs = ArchaeologistVars[buffNums.buffs];
	local numDebuffs = ArchaeologistVars[buffNums.debuffs];
	local buffsEnabled = (ArchaeologistVars[buffNums.buffsEnabled] ~= 1);
	local debuffsEnabled = (ArchaeologistVars[buffNums.debuffsEnabled] ~= 1);
	local buffFrameName = "NewBuff";
	local debuffFrameName = "NewDebuff";
	
	for i=1, maxBuffs do
		texture = UnitBuff(unit, i, SHOW_CASTABLE_BUFFS);
		if (texture == "Interface\\Icons\\Ability_Rogue_FeignDeath") then
			this.feigning = true;
		end
		
		if (not getglobal(button..buffFrameName..i)) then
			Sea.io.print(button..buffFrameName..i)
		end
		
		--getglobal(button..buffFrameName..i.."Border"):SetVertexColor(0, 1, 0);
		if ( texture ) and ( buffsEnabled ) and (i <= numBuffs) then
			getglobal(button..buffFrameName..i.."Icon"):SetTexture(texture);
			getglobal(button..buffFrameName..i):SetID(i);
			getglobal(button..buffFrameName..i):Show();
		else
			getglobal(button..buffFrameName..i):Hide();
		end
	end

	for i=1, maxDebuffs do
		debuffBorder = getglobal(button..debuffFrameName..i.."Border");
		debuffIcon = getglobal(button..debuffFrameName..i.."Icon");
		if ( unit == "party"..i ) then
			unitStatus = getglobal(button.."Status");
		end
		texture, debuffStack, debuffType = UnitDebuff(unit, i, SHOW_DISPELLABLE_DEBUFFS);
		if ( texture ) and ( debuffsEnabled ) and (i <= numDebuffs) then
			debuffIcon:SetTexture(texture);
			if ( debuffBorder ) then
				if ( debuffType ) then
					debuffColor = DebuffTypeColor[debuffType];
					statusColor = DebuffTypeColor[debuffType];
					this.hasDispellable = 1;
					debuffTotal = debuffTotal + 1;
				else
					debuffColor = DebuffTypeColor["none"];
				end
				debuffBorder:SetVertexColor(debuffColor.r, debuffColor.g, debuffColor.b);
				debuffBorder:Show();
			end
			getglobal(button..debuffFrameName..i):Show();
		else
			getglobal(button..debuffFrameName..i):Hide();
		end
	end
	
	-- Reset unitStatus overlay graphic timer
	if ( this.numDebuffs ) then
		if ( debuffTotal >= this.numDebuffs ) then
			this.debuffCountdown = 30;
		end
	end
	if ( unitStatus and statusColor ) then
		unitStatus:SetVertexColor(statusColor.r, statusColor.g, statusColor.b);
	end

end

function Archaeologist_PetFrame_RefreshBuffs()
	RefreshBuffs(getglobal("PetFrame"), 1, "pet");
end

function Archaeologist_PetFrame_UpdateDebuffLocations()
	if (ArchaeologistVars["DEBUFFALT"] == 1) then
		if ( ArchaeologistVars["PTBUFFS"] == 1 ) then
			PetFrameNewDebuff1:ClearAllPoints();
			PetFrameNewDebuff1:SetPoint("TOPLEFT", "PetFrame", "TOPLEFT", 48, -42);
		else
			PetFrameNewDebuff1:ClearAllPoints();
			PetFrameNewDebuff1:SetPoint("TOP", "PetFrameNewBuff1", "BOTTOM", 0, -2);
		end
	else
		PetFrameNewDebuff1:ClearAllPoints();
		PetFrameNewDebuff1:SetPoint("TOPLEFT", "PetFrame", "TOPLEFT", 120, -24);
	end
end

function Archaeologist_PartyFrame_UpdateDebuffLocations()
	if (ArchaeologistVars["DEBUFFALT"] == 1) then
		if ( ArchaeologistVars["PBUFFS"] == 1 ) then
			for i=1, 4 do
				getglobal("PartyMemberFrame"..i.."NewDebuff1"):ClearAllPoints();
				getglobal("PartyMemberFrame"..i.."NewDebuff1"):SetPoint("TOPLEFT", "PartyMemberFrame"..i, "TOPLEFT", 48, -32);
			end
		else
			for i=1, 4 do
				getglobal("PartyMemberFrame"..i.."NewDebuff1"):ClearAllPoints();
				getglobal("PartyMemberFrame"..i.."NewDebuff1"):SetPoint("TOP", "PartyMemberFrame"..i.."NewBuff1", "BOTTOM", 0, -2);
			end
		end
	else
		for i=1, 4 do
			getglobal("PartyMemberFrame"..i.."NewDebuff1"):ClearAllPoints();
			getglobal("PartyMemberFrame"..i.."NewDebuff1"):SetPoint("TOPLEFT", "PartyMemberFrame"..i, "TOPLEFT", 124, -14);
		end
	end
	Archaeologist_UpdatePartyPetLocations();
end

function Archaeologist_PartyPetFrame_UpdateDebuffLocations()
	if ( ArchaeologistVars["PPTBUFFS"] == 1 ) then
		for i=1, 4 do
			getglobal("PartyMemberFrame"..i.."PetFrameNewDebuff1"):ClearAllPoints();
			getglobal("PartyMemberFrame"..i.."PetFrameNewDebuff1"):SetPoint("TOPLEFT", "PartyMemberFrame"..i.."PetFrame", "TOPLEFT", 24, -16);
		end
	else
		for i=1, 4 do
			getglobal("PartyMemberFrame"..i.."PetFrameNewDebuff1"):ClearAllPoints();
			getglobal("PartyMemberFrame"..i.."PetFrameNewDebuff1"):SetPoint("TOP", "PartyMemberFrame"..i.."PetFrameNewBuff1", "BOTTOM", 0, -2);
		end
	end
	Archaeologist_UpdatePartyMemberLocations();
end


function Archaeologist_UpdatePartyMemberBuffs()
	local tempThis = this;
	for i=1, MAX_PARTY_MEMBERS do
        if ( GetPartyMember(i) ) then
			this = getglobal("PartyMemberFrame"..i);
            Archaeologist_RefreshBuffs(this, 0, "party"..i);
        end
    end
	this = tempThis;
end

function Archaeologist_UpdatePartyPetBuffs()
	PartyMemberFrame_RefreshPetBuffs(1);
	PartyMemberFrame_RefreshPetBuffs(2);
	PartyMemberFrame_RefreshPetBuffs(3);
	PartyMemberFrame_RefreshPetBuffs(4);
end

function Archaeologist_UpdatePartyPetLocations()
	PartyMemberFrame_UpdatePet(1);
	PartyMemberFrame_UpdatePet(2);
	PartyMemberFrame_UpdatePet(3);
	PartyMemberFrame_UpdatePet(4);
end

function Archaeologist_PartyMemberBuffs_Update()
	--only show buff tooltip on mouseover if buffs are hidden
	if (arg1 == "pet") then
		return (ArchaeologistVars["PTBUFFS"] == 1);
	end
	return (ArchaeologistVars["PBUFFS"] == 1);
end


function Archaeologist_TurnOffPartyBuffs(toggle)
	Archaeologist_UpdatePartyMemberBuffs();
	Archaeologist_PartyFrame_UpdateDebuffLocations();
end

function Archaeologist_TurnOffPartyPetBuffs(toggle)
	Archaeologist_UpdatePartyPetBuffs();
	Archaeologist_PartyPetFrame_UpdateDebuffLocations();
end

function Archaeologist_TurnOffPetBuffs(toggle)
	Archaeologist_PetFrame_RefreshBuffs();
	Archaeologist_PetFrame_UpdateDebuffLocations();
end


function Archaeologist_TurnOffPartyDebuffs(toggle)
	Archaeologist_UpdatePartyMemberBuffs();
	Archaeologist_UpdatePartyPetLocations();
end

function Archaeologist_TurnOffPartyPetDebuffs(toggle)
	Archaeologist_UpdatePartyPetBuffs();
	Archaeologist_UpdatePartyMemberLocations();
end

function Archaeologist_TurnOffPetDebuffs(toggle)
	Archaeologist_PetFrame_RefreshBuffs();
end


function Archaeologist_SetPartyBuffs(count)
	if (count) then
		Archaeologist_UpdatePartyMemberBuffs();
	end
end

function Archaeologist_SetPartyPetBuffs(count)
	if (count) then
		Archaeologist_UpdatePartyPetBuffs();
	end
end

function Archaeologist_SetPetBuffs(count)
	if (count) then
		Archaeologist_PetFrame_RefreshBuffs();
	end
end


function Archaeologist_SetPartyDebuffs(count)
	if (count) then
		Archaeologist_UpdatePartyMemberBuffs();
	end
end

function Archaeologist_SetPartyPetDebuffs(count)
	if (count) then
		Archaeologist_UpdatePartyPetBuffs();
	end
end

function Archaeologist_SetPetDebuffs(count)
	if (count) then
		Archaeologist_PetFrame_RefreshBuffs();
	end
end

-- <= == == == == == == == == == == == == =>
-- => Target Buffs
-- <= == == == == == == == == == == == == =>

function Archaeologist_HideOrigBuffs()
	for i=1, MAX_TARGET_BUFFS do
		getglobal("TargetFrameBuff"..i):Hide();
	end
	for i=1, MAX_TARGET_DEBUFFS do
		getglobal("TargetFrameDebuff"..i):Hide();
	end
	for m=1, MAX_PARTY_MEMBERS do
		for i=1, MAX_PARTY_DEBUFFS do
			getglobal("PartyMemberFrame"..m.."Debuff"..i):Hide();
			getglobal("PartyMemberFrame"..m.."PetFrameDebuff"..i):Hide();
		end
	end
end

function Archaeologist_TargetDebuffButton_Update()
	
	local button, debuff, debuffButton, buff, buffButton, debuffCount, debuffApplications, debuffType, debuffBorder;
	local numBuffs = 0;
	TargetFrame.feigning = nil;
	for i=1, ArchaeologistVarData["TBUFFNUM"].max do
		buff = UnitBuff("target", i);
		if (buff == "Interface\\Icons\\Ability_Rogue_FeignDeath") then
			TargetFrame.feigning = true;
		end
		button = getglobal("TargetFrameNewBuff"..i);
		if ( buff ) and (i <= ArchaeologistVars["TBUFFNUM"]) and (ArchaeologistVars["TBUFFS"] == 0) then
			getglobal("TargetFrameNewBuff"..i.."Icon"):SetTexture(buff);
			button:Show();
			button.id = i;
			numBuffs = numBuffs + 1;
		else
			button:Hide();
		end
	end
	local numDebuffs = 0;
	for i=1, ArchaeologistVarData["TDEBUFFNUM"].max do
		debuffBorder = getglobal("TargetFrameNewDebuff"..i.."Border");
		debuff, debuffApplications, debuffType = UnitDebuff("target", i);
		button = getglobal("TargetFrameNewDebuff"..i);
		if ( debuff ) and (i <= ArchaeologistVars["TDEBUFFNUM"]) and (ArchaeologistVars["TDEBUFFS"] == 0) then
			getglobal("TargetFrameNewDebuff"..i.."Icon"):SetTexture(debuff);
			debuffCount = getglobal("TargetFrameNewDebuff"..i.."Count");
			if ( debuffApplications > 1 ) then
				debuffCount:SetText(debuffApplications);
				debuffCount:Show();
			else
				debuffCount:Hide();
			end
			if ( debuffType ) then
				color = DebuffTypeColor[debuffType];
			else
				color = DebuffTypeColor["none"];
			end
			debuffBorder:SetVertexColor(color.r, color.g, color.b);
			button:Show();
			numDebuffs = numDebuffs + 1;
		else
			button:Hide();
		end
		button.id = i;
	end
	
	Archaeologist_TargetBuffs_UpdateAlignment(numBuffs, numDebuffs);
end

function Archaeologist_TargetBuffs_UpdateAlignment(numBuffs, numDebuffs)
	
	-- Position buffs depending on whether the targeted unit is friendly or not
	local topBuffPrefix = "TargetFrameNewDebuff";
	local bottomBuffPrefix = "TargetFrameNewBuff";
	local numTopBuffs = numDebuffs;
	local numBottomBuffs = numBuffs;
	if (UnitIsFriend("player", "target")) then
		topBuffPrefix = "TargetFrameNewBuff";
		bottomBuffPrefix = "TargetFrameNewDebuff";
		numTopBuffs = numBuffs;
		numBottomBuffs = numDebuffs;
	end
	
	-- Attach Buff Bars
	getglobal(topBuffPrefix.."1"):SetPoint("TOPLEFT", "TargetFrame", "BOTTOMLEFT", 5, 32);
	
	
	local buffSize = 21;
	local buffBorderSize = 23;
	local smallBuffSize = 17;
	local smallBuffBorderSize = 19;
	local bottomBuffWrap = 8;
	
	--Reset Buff Alignment
	for i=2, 16 do
		getglobal(topBuffPrefix..i):ClearAllPoints();
		getglobal(topBuffPrefix..i):SetPoint("LEFT", getglobal(topBuffPrefix..(i - 1)), "RIGHT", 3, 0);
		getglobal(bottomBuffPrefix..i):ClearAllPoints();
		getglobal(bottomBuffPrefix..i):SetPoint("LEFT", getglobal(bottomBuffPrefix..(i - 1)), "RIGHT", 3, 0);
	end
	
	-- Align buff bars
	local multiplier, smallBuffs;
	if (ArchaeologistVars["TBUFFALT"] == 1) then
		smallBuffs = 0
		
		getglobal(bottomBuffPrefix..(1)):ClearAllPoints();
		getglobal(bottomBuffPrefix..(1)):SetPoint("TOPLEFT", topBuffPrefix..(1), "BOTTOMLEFT", 0, -2);
	elseif ( numTopBuffs < 5 ) then
		smallBuffs = 0
		
		getglobal(bottomBuffPrefix..(1)):ClearAllPoints();
		getglobal(bottomBuffPrefix..(1)):SetPoint("TOPLEFT", topBuffPrefix..(1), "BOTTOMLEFT", 0, -2);
		getglobal(bottomBuffPrefix..(bottomBuffWrap + 1)):ClearAllPoints();
		if ( TargetofTargetFrame:IsShown() ) then
			bottomBuffWrap = 4
		end
		getglobal(bottomBuffPrefix..(bottomBuffWrap + 1)):SetPoint("TOPLEFT", bottomBuffPrefix..(1), "BOTTOMLEFT", 0, -2);
	elseif ( TargetofTargetFrame:IsShown() and numTopBuffs == 5 ) then
		smallBuffs = 5
		bottomBuffWrap = 4
		
		getglobal(bottomBuffPrefix..(1)):ClearAllPoints();
		getglobal(bottomBuffPrefix..(1)):SetPoint("TOPLEFT", topBuffPrefix..(1), "BOTTOMLEFT", 0, -2);
		getglobal(bottomBuffPrefix..(bottomBuffWrap + 1)):ClearAllPoints();
		getglobal(bottomBuffPrefix..(bottomBuffWrap + 1)):SetPoint("TOPLEFT", bottomBuffPrefix..(1), "BOTTOMLEFT", 0, -2);
	elseif ( TargetofTargetFrame:IsShown() ) then
		smallBuffs = 5
		getglobal(topBuffPrefix..(smallBuffs + 1)):ClearAllPoints();
		getglobal(topBuffPrefix..(smallBuffs + 1)):SetPoint("TOPLEFT", topBuffPrefix..(1), "BOTTOMLEFT", 0, -2);
		getglobal(topBuffPrefix..(smallBuffs*2 + 1)):ClearAllPoints();
		getglobal(topBuffPrefix..(smallBuffs*2 + 1)):SetPoint("TOPLEFT", topBuffPrefix..(smallBuffs + 1), "BOTTOMLEFT", 0, -2);
		
		getglobal(bottomBuffPrefix..(1)):ClearAllPoints();
		if ( numTopBuffs > smallBuffs*2 ) then
			getglobal(bottomBuffPrefix..(1)):SetPoint("TOPLEFT", topBuffPrefix..(smallBuffs*2 + 1), "BOTTOMLEFT", 0, -2);
		else
			-- Still > 5 (two rows)
			getglobal(bottomBuffPrefix..(1)):SetPoint("TOPLEFT", topBuffPrefix..(smallBuffs + 1), "BOTTOMLEFT", 0, -2);
		end
		getglobal(bottomBuffPrefix..(bottomBuffWrap + 1)):ClearAllPoints();
		getglobal(bottomBuffPrefix..(bottomBuffWrap + 1)):SetPoint("TOPLEFT", bottomBuffPrefix..(1), "BOTTOMLEFT", 0, -2);
		
		smallBuffs = smallBuffs*2
	else
		smallBuffs = 6
		getglobal(topBuffPrefix..(smallBuffs + 1)):ClearAllPoints();
		getglobal(topBuffPrefix..(smallBuffs + 1)):SetPoint("TOPLEFT", topBuffPrefix..(1), "BOTTOMLEFT", 0, -2);
		
		getglobal(bottomBuffPrefix..(1)):ClearAllPoints();
		if ( numTopBuffs > smallBuffs ) then
			getglobal(bottomBuffPrefix..(1)):SetPoint("TOPLEFT", topBuffPrefix..(smallBuffs + 1), "BOTTOMLEFT", 0, -2);
		else
			getglobal(bottomBuffPrefix..(1)):SetPoint("TOPLEFT", topBuffPrefix..(1), "BOTTOMLEFT", 0, -2);
		end
		getglobal(bottomBuffPrefix..(bottomBuffWrap + 1)):ClearAllPoints();
		getglobal(bottomBuffPrefix..(bottomBuffWrap + 1)):SetPoint("TOPLEFT", bottomBuffPrefix..(1), "BOTTOMLEFT", 0, -2);
	end
	
	-- Shrinks the debuffs if they begin to overlap the TargetFrame
	local buffFrame, buffBorder;
	-- Top Buffs
	for i=1, smallBuffs do
		buffFrame = getglobal(topBuffPrefix..i);
		buffBorder = getglobal(topBuffPrefix..i.."Border");
		buffFrame:SetWidth(smallBuffSize);
		buffFrame:SetHeight(smallBuffSize);
		buffBorder:SetWidth(smallBuffBorderSize);
		buffBorder:SetHeight(smallBuffBorderSize);
	end
	for i=smallBuffs+1, 16 do
		buffFrame = getglobal(topBuffPrefix..i);
		buffBorder = getglobal(topBuffPrefix..i.."Border");
		buffFrame:SetWidth(buffSize);
		buffFrame:SetHeight(buffSize);
		buffBorder:SetWidth(buffBorderSize);
		buffBorder:SetHeight(buffBorderSize);
	end
	-- Bottom Buffs
	for i=1, 16 do
		buffFrame = getglobal(bottomBuffPrefix..i);
		buffBorder = getglobal(bottomBuffPrefix..i.."Border");
		buffFrame:SetWidth(buffSize);
		buffFrame:SetHeight(buffSize);
		buffBorder:SetWidth(buffBorderSize);
		buffBorder:SetHeight(buffBorderSize);
	end
	
	--[[
	TargetFrameNewBuff1:ClearAllPoints();
	TargetFrameNewBuff9:ClearAllPoints();
	TargetFrameNewDebuff1:ClearAllPoints();
	TargetFrameNewDebuff9:ClearAllPoints();
	
	getglobal(topBuffPrefix..1):SetPoint("TOPLEFT", "TargetFrame", "BOTTOMLEFT", 5, 32);
	if (ArchaeologistVars["TBUFFALT"] == 1) and (numTopBuffs >= 9) then
		getglobal(topBuffPrefix..9):SetPoint("TOPLEFT", topBuffPrefix..1, "BOTTOMLEFT", 0, -2);
		getglobal(bottomBuffPrefix..1):SetPoint("TOPLEFT", topBuffPrefix..9, "BOTTOMLEFT", 0, -2);
	else
		getglobal(topBuffPrefix..9):SetPoint("LEFT", topBuffPrefix..8, "RIGHT", 3, 0);
		getglobal(bottomBuffPrefix..1):SetPoint("TOPLEFT", topBuffPrefix..1, "BOTTOMLEFT", 0, -2);
	end
	if (ArchaeologistVars["TBUFFALT"] == 1) and (numBottomBuffs >= 9) then
		getglobal(bottomBuffPrefix..9):SetPoint("TOPLEFT", bottomBuffPrefix..1, "BOTTOMLEFT", 0, -2);
	else
		getglobal(bottomBuffPrefix..9):SetPoint("LEFT", bottomBuffPrefix..8, "RIGHT", 3, 0);
	end
	]]--
	
end

function Archaeologist_TurnOffTargetBuffs(toggle)
	Archaeologist_TargetDebuffButton_Update();
end

function Archaeologist_TurnOffTargetDebuffs(toggle)
	Archaeologist_TargetDebuffButton_Update();
end


function Archaeologist_SetTargetBuffs(count)
	if (count) then
		Archaeologist_TargetDebuffButton_Update();
	end
end


function Archaeologist_SetTargetDebuffs(count)
	if (count) then
		Archaeologist_TargetDebuffButton_Update();
	end
end

-- <= == == == == == == == == == == == == =>
-- => Alternate Options
-- <= == == == == == == == == == == == == =>

function Archaeologist_SetAltDebuffLocation(toggle)
	Archaeologist_PetFrame_UpdateDebuffLocations();
	Archaeologist_SetPetFrameHappinessLocation();
	Archaeologist_PartyFrame_UpdateDebuffLocations();
end

function Archaeologist_SetUnitBarValuePercentSwap(unit, barType, toggle)
	if (ArchaeologistStatusBars[unit]) then
		local statusBar = ArchaeologistStatusBars[unit].frame[barType];
		Archaeologist_TextStringAltTextStatusBars[statusBar:GetName()] = toggle;
		Archaeologist_TextStatusBar_UpdateTextString(statusBar);
	end
end

function Archaeologist_SetPetFrameHappinessLocation()
	if  (ArchaeologistVars["PETHP2"] == "on") or (ArchaeologistVars["PETHP2"] == "mouseover") or 
		(ArchaeologistVars["PETMP2"] == "on") or (ArchaeologistVars["PETMP2"] == "mouseover") or
		((ArchaeologistVars["DEBUFFALT"] == 0) and (ArchaeologistVars["PTDEBUFFS"] == 0)) then
		--alt position
		PetFrameHappiness:ClearAllPoints();
		PetFrameHappiness:SetPoint("TOPRIGHT", "PetFrame", "BOTTOMLEFT", 8, 15);
	else
		--normal position
		PetFrameHappiness:ClearAllPoints();
		PetFrameHappiness:SetPoint("LEFT", "PetFrame", "RIGHT", -7, -4);
	end

end

-- <= == == == == == == == == == == == == =>
-- => Font Options
-- <= == == == == == == == == == == == == =>

function Archaeologist_SetPrimaryHPColor(colorTable)
	for unit, data in ArchaeologistStatusBars do
		data.frame.healthbar.TextString:SetTextColor(colorTable.r, colorTable.g, colorTable.b, colorTable.opacity);
	end
end

function Archaeologist_SetPrimaryMPColor(colorTable)
	for unit, data in ArchaeologistStatusBars do
		data.frame.manabar.TextString:SetTextColor(colorTable.r, colorTable.g, colorTable.b, colorTable.opacity);
	end
end

function Archaeologist_SetSecondaryHPColor(colorTable)
	for unit, data in ArchaeologistStatusBars do
		data.frame.healthbar.TextString2:SetTextColor(colorTable.r, colorTable.g, colorTable.b, colorTable.opacity);
	end
end

function Archaeologist_SetSecondaryMPColor(colorTable)
	for unit, data in ArchaeologistStatusBars do
		data.frame.manabar.TextString2:SetTextColor(colorTable.r, colorTable.g, colorTable.b, colorTable.opacity);
	end
end

function Archaeologist_SetHPMPLargeFont(key)
	if (not key) then
		return;
	end
	local font = ArchaeologistFonts[key];
	if (not font) then
		-- Will reset to default on next Reload
		return;
	end
	local frame;
	local size = ArchaeologistVars["HPMPLARGESIZE"];
	for i, unit in {"player", "target"} do
		frame = ArchaeologistStatusBars[unit].frame;
		frame.healthbar.TextString:SetFont(font, size);
		frame.healthbar.TextString2:SetFont(font, size);
		frame.manabar.TextString:SetFont(font, size);
		frame.manabar.TextString2:SetFont(font, size);
	end
	Archaeologist_SetHPMPLargeTextSize(size); --Size corrects refonting problem with linebreaks
end

function Archaeologist_SetHPMPSmallFont(key)
	if (not key) then
		return;
	end
	local font = ArchaeologistFonts[key];
	if (not font) then
		-- Will reset to default on next Reload
		return;
	end
	local frame;
	local size = ArchaeologistVars["HPMPSMALLSIZE"];
	for i, unit in {"party1", "party2", "party3", "party4", "pet"} do
		frame = ArchaeologistStatusBars[unit].frame;
		frame.healthbar.TextString:SetFont(font, size);
		frame.healthbar.TextString2:SetFont(font, size);
		frame.manabar.TextString:SetFont(font, size);
		frame.manabar.TextString2:SetFont(font, size);
	end
	Archaeologist_SetHPMPSmallTextSize(size); --Size corrects refonting problem with linebreaks
end

-- <= == == == == == == == == == == == == =>
-- => MobHealth Compatibility
-- <= == == == == == == == == == == == == =>

if (MobHealth_OnEvent) then
	if (not MobHealth_PPP) then
		MobHealth_PPP = function(index)
			if( index and MobHealthDB[index] ) then
				local s, e;
				local pts;
				local pct;
				
				s, e, pts, pct = string.find(MobHealthDB[index], "^(%d+)/(%d+)$");
				if( pts and pct ) then
					pts = pts + 0;
					pct = pct + 0;
					if( pct ~= 0 ) then
						return pts / pct;
					end
				end
			end
			return 0;
		end
	end
	
	if (not MobHealth_GetTargetCurHP) then
		MobHealth_GetTargetCurHP = function()
			local name = UnitName("target");
			if ( name ) then
				local currentPct = UnitHealth("target");
				local pointsPerPct = MobHealth_PPP(name..":"..UnitLevel("target"));
				return math.floor(currentPct * pointsPerPct + 0.5);
			end	
		end
	end
	
	if (not MobHealth_GetTargetMaxHP) then
		MobHealth_GetTargetMaxHP = function()
			local name = UnitName("target");
			if ( name ) then
				local currentPct = UnitHealth("target");
				local pointsPerPct = MobHealth_PPP(name..":"..UnitLevel("target"));
				return math.floor(100 * pointsPerPct + 0.5);
			end		
		end
	end
end

-- <= == == == == == == == == == == == == =>
-- => MobHealth2 Compatibility
-- <= == == == == == == == == == == == == =>

function Archaeologist_MobHealth_OnEvent(event)
	if (event == "PLAYER_TARGET_CHANGED") or (event == "UNIT_HEALTH" and arg1 == "target") then
		--Archaeologist_TargetCheckDead();
		TextStatusBar_UpdateTextString(ArchaeologistStatusBars.target.frame.healthbar);
	end
end

-- <= == == == == == == == == == == == == =>
-- => MobInfo2 Compatibility
-- <= == == == == == == == == == == == == =>

function Archaeologist_EnableMobHealth(toggle)
	local frame;
	if (MI2_MobHealthFrame) then
		frame = MI2_MobHealthFrame;
	elseif (MobHealthFrame) then
		frame = MobHealthFrame;
	else
		return;
	end
	if (toggle == 1) then
		frame:Hide();
	else
		frame:Show();
	end
end

-- <= == == == == == == == == == == == == =>
-- => Class Icons
-- <= == == == == == == == == == == == == =>

function Archaeologist_TurnOnPartyClassIcon(toggle)
	Archaeologist_UpdatePartyClassIcons();
	if (toggle == 1) then
		for i=1, 4 do
			getglobal("PartyMemberFrame"..i.."MasterIcon"):ClearAllPoints();
			getglobal("PartyMemberFrame"..i.."MasterIcon"):SetPoint("TOPLEFT", "PartyMemberFrame"..i, "TOPLEFT", 15, 5);
		end
	else
		for i=1, 4 do
			getglobal("PartyMemberFrame"..i.."MasterIcon"):ClearAllPoints();
			getglobal("PartyMemberFrame"..i.."MasterIcon"):SetPoint("TOPLEFT", "PartyMemberFrame"..i, "TOPLEFT", 32, 0);
		end
	end
end

function Archaeologist_UpdatePartyClassIcons()
	if (ArchaeologistVars["PARTYCLASSICON"] == 1) then
		local localizedClass, englishClass, icon;
		for i=1, GetNumPartyMembers() do
			localizedClass, englishClass = UnitClass("party"..i);
			icon = getglobal("PartyMemberFrame"..i.."ClassIcon");
			if (englishClass) then
				if (not icon:IsVisible()) then
					icon:Show();
				end
				getglobal(icon:GetName().."Texture"):SetTexture("Interface\\AddOns\\Archaeologist\\Skin\\ClassIcons\\"..Sea.string.capitalizeWords(englishClass));
			else
				if (icon:IsVisible()) then
					icon:Hide();
				end
			end
		end
	else
		for i=1, GetNumPartyMembers() do
			icon = getglobal("PartyMemberFrame"..i.."ClassIcon");
			if (icon:IsVisible()) then
				icon:Hide();
			end
		end
	end
end

function Archaeologist_TurnOnTargetClassIcon(toggle)
	Archaeologist_UpdateTargetClassIcon();
end

function Archaeologist_UpdateTargetClassIcon()
	if (ArchaeologistVars["TARGETCLASSICON"] == 1) then
		if (UnitIsPlayer("target")) then
			local localizedClass, englishClass = UnitClass("target");
			if (not TargetFrameClassIcon:IsVisible()) then
				TargetFrameClassIcon:Show();
			end
			TargetFrameClassIconTexture:SetTexture("Interface\\AddOns\\Archaeologist\\Skin\\ClassIcons\\"..Sea.string.capitalizeWords(englishClass));
		else
			TargetFrameClassIcon:Hide();
		end
	else
		if (TargetFrameClassIcon:IsVisible()) then
			TargetFrameClassIcon:Hide();
		end
	end
end

function Archaeologist_TurnOnPlayerClassIcon(toggle)
	Archaeologist_UpdatePlayerClassIcon();
	if (toggle == 1) then
		PlayerMasterIcon:ClearAllPoints();
		PlayerMasterIcon:SetPoint("TOPLEFT", "PlayerFrame", "TOPLEFT", 65, -2);
	else
		PlayerMasterIcon:ClearAllPoints();
		PlayerMasterIcon:SetPoint("TOPLEFT", "PlayerFrame", "TOPLEFT", 80, -10);
	end
end

function Archaeologist_UpdatePlayerClassIcon()
	if (ArchaeologistVars["PLAYERCLASSICON"] == 1) then
		local localizedClass, englishClass = UnitClass("player");
		if (not PlayerFrameClassIcon:IsVisible()) then
			PlayerFrameClassIcon:Show();
		end
		PlayerFrameClassIconTexture:SetTexture("Interface\\AddOns\\Archaeologist\\Skin\\ClassIcons\\"..Sea.string.capitalizeWords(englishClass));
	else
		if (PlayerFrameClassIcon:IsVisible()) then
			PlayerFrameClassIcon:Hide();
		end
	end
end

function Archaeologist_ClassIcon_OnLoad()
	this:SetFrameLevel(this:GetFrameLevel()+2);
end

function Archaeologist_EnableClassPortrait(toggle)
	if (toggle == 1) then
		for unit, data in ArchaeologistStatusBars do
			if (unit ~= "pet") and (strsub(unit,1,4) ~= "raid") then
				if (UnitIsPlayer(unit)) then
					local localizedClass, englishClass = UnitClass(unit);
					if (englishClass) then
						data.frame.portrait:SetTexture("Interface\\AddOns\\Archaeologist\\Skin\\PortraitIcons\\"..Sea.string.capitalizeWords(englishClass));
					end
				end
			end
		end
	else
		SetPortraitTexture(PlayerFrame.portrait, "player");
		SetPortraitTexture(TargetFrame.portrait, "target");
		SetPortraitTexture(PartyMemberFrame1.portrait, "party1");
		SetPortraitTexture(PartyMemberFrame2.portrait, "party2");
		SetPortraitTexture(PartyMemberFrame3.portrait, "party3");
		SetPortraitTexture(PartyMemberFrame4.portrait, "party4");
	end
end

function Archaeologist_UnitFrame_Update_After()
	if (ArchaeologistVars["CLASSPORTRAIT"] == 1) then
		if (UnitIsPlayer(this.unit)) then
			local localizedClass, englishClass = UnitClass(this.unit);
			if (englishClass) then
				this.portrait:SetTexture("Interface\\AddOns\\Archaeologist\\Skin\\PortraitIcons\\"..Sea.string.capitalizeWords(englishClass));
			end
		end
	end
end

function Archaeologist_UnitFrame_OnEvent_After(event)
	if (ArchaeologistVars["CLASSPORTRAIT"] == 1) then
		if ( (event == "UNIT_PORTRAIT_UPDATE") and (arg1 == this.unit) ) then
			if (UnitIsPlayer(this.unit)) then
				local localizedClass, englishClass = UnitClass(this.unit);
				if (englishClass) then
					this.portrait:SetTexture("Interface\\AddOns\\Archaeologist\\Skin\\PortraitIcons\\"..Sea.string.capitalizeWords(englishClass));
				end
			end
		end
	end
end

-- <= == == == == == == == == == == == == =>
-- => Helpful Funcs
-- <= == == == == == == == == == == == == =>

-- 1 => 0, 0 => 1
function BinaryInvert(oneZero)
	if oneZero == 1 then
		return 0;
	else 
		return 1;
	end
end

function Archaeologist_PartyIndexFromName(name)
	for i=1, GetNumPartyMembers() do
		if ( name == UnitName("party"..i) ) then
			return i;
		end
	end
end


function Archaeologist_PartyIndexFromUnit(unit)
	if (type(unit) == "string") then
		if ( strsub(unit,0, string.len(unit)-1) == "party" ) then
			local partyIndex = tonumber( strsub(unit,string.len(unit)) );
			return partyIndex;
		end
	end
end


function Archaeologist_PartyIndexFromFrame(frame)
	local frameName = frame:GetName();
	if (frameName) then
		if ( strsub(frameName,0, string.len(frameName)-1) == "PartyMemberFrame" ) then
			local frameIndex = frame:GetID();
			if (frameIndex > 0) then
				return frameIndex;
			end
		end
	end
end

-- <= == == == == == == == == == == == =>
-- => Presets
-- <= == == == == == == == == == == == =>

function Archaeologist_SetValuePercentPresets(index)
	local ARCHAEOLOGIST_ON = TEXT("ARCHAEOLOGIST_ON");
	local ARCHAEOLOGIST_OFF = TEXT("ARCHAEOLOGIST_OFF");
	if (index) then
		local id = MCom.getComID("/arch");
		if (index == 1) then
			-- Values on the Bars
			for k, v in {"player", "pet", "party", "target"} do
				MCom.SlashCommandHandler(id, v.."hp "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."hp2 "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mp "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mp2 "..ARCHAEOLOGIST_OFF);
				
				MCom.SlashCommandHandler(id, v.."hpvinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."hppinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpvinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mppinvert "..ARCHAEOLOGIST_OFF);
				
				MCom.SlashCommandHandler(id, v.."hpswap "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mpswap "..ARCHAEOLOGIST_ON);
			end

			MCom.SlashCommandHandler(id, "thpalt "..ARCHAEOLOGIST_OFF);
			if (MobHealth_OnEvent) then
				MCom.SlashCommandHandler(id, "mobhealth "..ARCHAEOLOGIST_ON);
			end
		
		elseif (index == 2) then
			-- Values next to the Bars
			for k, v in {"player", "pet", "party", "target"} do
				MCom.SlashCommandHandler(id, v.."hp "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."hp2 "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mp "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mp2 "..ARCHAEOLOGIST_ON);
				
				MCom.SlashCommandHandler(id, v.."hpvinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."hppinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpvinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mppinvert "..ARCHAEOLOGIST_OFF);
				
				MCom.SlashCommandHandler(id, v.."hpswap "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpswap "..ARCHAEOLOGIST_OFF);
			end

			MCom.SlashCommandHandler(id, "thpalt "..ARCHAEOLOGIST_OFF);
			if (MobHealth_OnEvent) then
				MCom.SlashCommandHandler(id, "mobhealth "..ARCHAEOLOGIST_ON);
			end
		
		elseif (index == 3) then
			-- Percentage on the Bars
			for k, v in {"player", "pet", "party", "target"} do
				MCom.SlashCommandHandler(id, v.."hp "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."hp2 "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mp "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mp2 "..ARCHAEOLOGIST_OFF);
				
				MCom.SlashCommandHandler(id, v.."hpvinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."hppinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpvinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mppinvert "..ARCHAEOLOGIST_OFF);
				
				MCom.SlashCommandHandler(id, v.."hpswap "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpswap "..ARCHAEOLOGIST_OFF);
			end
			
		elseif (index == 4) then
			-- Percentage next to the Bars
			for k, v in {"player", "pet", "party", "target"} do
				MCom.SlashCommandHandler(id, v.."hp "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."hp2 "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mp "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mp2 "..ARCHAEOLOGIST_ON);
				
				MCom.SlashCommandHandler(id, v.."hpvinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."hppinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpvinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mppinvert "..ARCHAEOLOGIST_OFF);
				
				MCom.SlashCommandHandler(id, v.."hpswap "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mpswap "..ARCHAEOLOGIST_ON);
			end
			
		elseif (index == 5) then
			-- Percentage on the Bars, Values next to the Bars
			for k, v in {"player", "pet", "party", "target"} do
				MCom.SlashCommandHandler(id, v.."hp "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."hp2 "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mp "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mp2 "..ARCHAEOLOGIST_ON);
				
				MCom.SlashCommandHandler(id, v.."hpvinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."hppinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpvinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mppinvert "..ARCHAEOLOGIST_OFF);
				
				MCom.SlashCommandHandler(id, v.."hpswap "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpswap "..ARCHAEOLOGIST_OFF);
			end
			
			MCom.SlashCommandHandler(id, "thpalt "..ARCHAEOLOGIST_ON);
			if (MobHealth_OnEvent) then
				MCom.SlashCommandHandler(id, "mobhealth "..ARCHAEOLOGIST_ON);
			end
			
		elseif (index == 6) then
			-- Values on the Bars, Percentage next to the Bars
			for k, v in {"player", "pet", "party", "target"} do
				MCom.SlashCommandHandler(id, v.."hp "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."hp2 "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mp "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mp2 "..ARCHAEOLOGIST_ON);
				
				MCom.SlashCommandHandler(id, v.."hpvinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."hppinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpvinvert "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mppinvert "..ARCHAEOLOGIST_OFF);
				
				MCom.SlashCommandHandler(id, v.."hpswap "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mpswap "..ARCHAEOLOGIST_ON);
			end
			
			MCom.SlashCommandHandler(id, "thpalt "..ARCHAEOLOGIST_ON);
			if (MobHealth_OnEvent) then
				MCom.SlashCommandHandler(id, "mobhealth "..ARCHAEOLOGIST_ON);
			end
			
		end
		
		if (Khaos) and (KhaosFrame:IsVisible()) then
			Khaos.refresh(false, false, true);
		elseif (CosmosMasterFrame) and (CosmosMasterFrame:IsVisible()) and (not CosmosMasterFrame_IsLoading) then
			CosmosMaster_DrawData();
		end
	end
end

function Archaeologist_SetPrefixPresets(index)
	local ARCHAEOLOGIST_ON = TEXT("ARCHAEOLOGIST_ON");
	local ARCHAEOLOGIST_OFF = TEXT("ARCHAEOLOGIST_OFF");
	if (index) then
		local id = MCom.getComID("/arch");
		if (index == 1) then
			-- All off
			for k, v in {"player", "pet", "party", "target"} do
				MCom.SlashCommandHandler(id, v.."hpnoprefix "..ARCHAEOLOGIST_ON);
				MCom.SlashCommandHandler(id, v.."mpnoprefix "..ARCHAEOLOGIST_ON);
			end
			
			MCom.SlashCommandHandler(id, "mainxpnoprefix "..ARCHAEOLOGIST_ON);
			MCom.SlashCommandHandler(id, "petxpnoprefix "..ARCHAEOLOGIST_ON);
		
		elseif (index == 2) then
			-- All on
			for k, v in {"player", "pet", "party", "target"} do
				MCom.SlashCommandHandler(id, v.."hpnoprefix "..ARCHAEOLOGIST_OFF);
				MCom.SlashCommandHandler(id, v.."mpnoprefix "..ARCHAEOLOGIST_OFF);
			end
			
			MCom.SlashCommandHandler(id, "mainxpnoprefix "..ARCHAEOLOGIST_OFF);
			MCom.SlashCommandHandler(id, "petxpnoprefix "..ARCHAEOLOGIST_OFF);
		
		elseif (index == 3) then
			-- All default
			for k, v in {"player", "pet", "party", "target"} do
				MCom.SlashCommandHandler(id, v.."hpnoprefix "..ArchaeologistVarData[strupper(v.."hpnoprefix")].default);
				MCom.SlashCommandHandler(id, v.."mpnoprefix "..ArchaeologistVarData[strupper(v.."mpnoprefix")].default);
			end
			
			MCom.SlashCommandHandler(id, "mainxpnoprefix "..ArchaeologistVarData[strupper("mainxpnoprefix")].default);
			MCom.SlashCommandHandler(id, "petxpnoprefix "..ArchaeologistVarData[strupper("petxpnoprefix")].default);
		
		end
		
		if (Khaos) and (KhaosFrame:IsVisible()) then
			Khaos.refresh(false, false, true);
		elseif (CosmosMasterFrame) and (CosmosMasterFrame:IsVisible()) and (not CosmosMasterFrame_IsLoading) then
			CosmosMaster_DrawData();
		end
	end
end

-- <= == == == == == == == == == == == =>
-- => Sorting Function
-- <= == == == == == == == == == == == =>

Archaeologist_SortPrefixes = {};

local stubFinder = function(indexString)
	for i, prefix in Archaeologist_SortPrefixes do
		local prefixlen = string.len(prefix);
		if (strsub(indexString, 0, prefixlen) == prefix) then
			return strsub(indexString, prefixlen+1);
		end
	end
end

ArchaeologistVarStubDisplayRank = {
	HP = 1,
	MP = 2,
	HP2 = 3,
	MP2 = 4,
	HPNOMAX = 5,
	MPNOMAX = 6,
	HPVINVERT = 7,
	HPPINVERT = 7,
	MPVINVERT = 8,
	MPPINVERT = 8,
	HPNOPREFIX = 9,
	MPNOPREFIX = 10,
	HPSWAP = 11,
	MPSWAP = 12,
	
	CLASSICON = 13,
	
	XP = 1,
	REP = 2,
	XPNOMAX = 3,
	REPNOMAX = 4,
	XPINVERT = 5,
	REPINVERT = 6,
	XPP = 7,
	REPP = 8,
	XPV = 9,
	REPV = 10,
	XPNOPREFIX = 11,
	REPNOPREFIX = 12,

};

function Archaeologist_StatusBarOptionSort(a,b)
	local stubA = stubFinder(a);
	local stubB = stubFinder(b);
	local aVal = stubA and ArchaeologistVarStubDisplayRank[stubA];
	local bVal = stubB and ArchaeologistVarStubDisplayRank[stubB];
	if (aVal == bVal) then
		return a < b;
	else
		return aVal and ((not bVal) or (aVal < bVal));
	end
end

-- <= == == == == == == == == == == == =>
-- => Configuration Registeration
-- <= == == == == == == == == == == == =>

function Archaeologist_RegisterForMCom()	
	
	local optionSet = {};
	
	-- <= == == == == == == == == == == == =>
	-- => Presets Registering
	-- <= == == == == == == == == == == == =>
	
	table.insert(optionSet, {
		id="PresetsHeader";
		text=function() return TEXT("ARCHAEOLOGIST_CONFIG_PRESETS") end;
		helptext=function() return TEXT("ARCHAEOLOGIST_CONFIG_PRESETS") end;
		type=K_HEADER;
		difficulty=1;
	});
	
	table.insert(optionSet, {
		id="Preset1ValuesOnBars";
		type=K_BUTTON;
		text=function() return TEXT("ARCHAEOLOGIST_CONFIG_VALUES_ON_BARS") end;
		helptext=function() return TEXT("ARCHAEOLOGIST_CONFIG_VALUES_ON_BARS") end;
		callback=function()Archaeologist_SetValuePercentPresets(1)end;
		setup={buttonText=function() return TEXT("ARCHAEOLOGIST_CONFIG_SET") end};
		mcopts = {
			subcom = string.lower("Preset1");
		};
	});
	
	table.insert(optionSet, {
		id="Preset2ValuesNextToBars";
		type=K_BUTTON;
		text=function() return TEXT("ARCHAEOLOGIST_CONFIG_VALUES_NEXTTO_BARS") end;
		helptext=function() return TEXT("ARCHAEOLOGIST_CONFIG_VALUES_NEXTTO_BARS") end;
		callback=function()Archaeologist_SetValuePercentPresets(2)end;
		setup={buttonText=function() return TEXT("ARCHAEOLOGIST_CONFIG_SET") end};
		mcopts = {
			subcom = string.lower("Preset2");
		};
	});
	
	table.insert(optionSet, {
		id="Preset3PercentageOnBars";
		type=K_BUTTON;
		text=function() return TEXT("ARCHAEOLOGIST_CONFIG_PERCENTAGE_ON_BARS") end;
		helptext=function() return TEXT("ARCHAEOLOGIST_CONFIG_PERCENTAGE_ON_BARS") end;
		callback=function()Archaeologist_SetValuePercentPresets(3)end;
		setup={buttonText=function() return TEXT("ARCHAEOLOGIST_CONFIG_SET") end};
		mcopts = {
			subcom = string.lower("Preset3");
		};
	});
	
	table.insert(optionSet, {
		id="Preset4PercentageNextToBars";
		type=K_BUTTON;
		text=function() return TEXT("ARCHAEOLOGIST_CONFIG_PERCENTAGE_NEXTTO_BARS") end;
		helptext=function() return TEXT("ARCHAEOLOGIST_CONFIG_PERCENTAGE_NEXTTO_BARS") end;
		callback=function()Archaeologist_SetValuePercentPresets(4)end;
		setup={buttonText=function() return TEXT("ARCHAEOLOGIST_CONFIG_SET") end};
		mcopts = {
			subcom = string.lower("Preset4");
		};
	});
	
	table.insert(optionSet, {
		id="Preset5PercentageOnValuesNextToBars";
		type=K_BUTTON;
		text=function() return TEXT("ARCHAEOLOGIST_CONFIG_PERCENTAGE_ON_VALUES_NEXTTO_BARS") end;
		helptext=function() return TEXT("ARCHAEOLOGIST_CONFIG_PERCENTAGE_ON_VALUES_NEXTTO_BARS") end;
		callback=function()Archaeologist_SetValuePercentPresets(5)end;
		setup={buttonText=function() return TEXT("ARCHAEOLOGIST_CONFIG_SET") end};
		mcopts = {
			subcom = string.lower("Preset5");
		};
	});
	
	table.insert(optionSet, {
		id="Preset6ValuesOnPercentageNextToBars";
		type=K_BUTTON;
		text=function() return TEXT("ARCHAEOLOGIST_CONFIG_VALUES_ON_PERCENTAGE_NEXTTO_BARS") end;
		helptext=function() return TEXT("ARCHAEOLOGIST_CONFIG_VALUES_ON_PERCENTAGE_NEXTTO_BARS") end;
		callback=function()Archaeologist_SetValuePercentPresets(6)end;
		setup={buttonText=function() return TEXT("ARCHAEOLOGIST_CONFIG_SET") end};
		mcopts = {
			subcom = string.lower("Preset6");
		};
	});
	
	table.insert(optionSet, {
		id="Preset1PrefixesOff";
		type=K_BUTTON;
		text=function() return TEXT("ARCHAEOLOGIST_CONFIG_PREFIXES_OFF") end;
		helptext=function() return TEXT("ARCHAEOLOGIST_CONFIG_PREFIXES_OFF") end;
		callback=function()Archaeologist_SetPrefixPresets(1)end;
		setup={buttonText=function() return TEXT("ARCHAEOLOGIST_CONFIG_SET") end};
		mcopts = {
			subcom = string.lower("PrefixOff");
		};
	});
	
	table.insert(optionSet, {
		id="Preset1PrefixesOn";
		type=K_BUTTON;
		text=function() return TEXT("ARCHAEOLOGIST_CONFIG_PREFIXES_ON") end;
		helptext=function() return TEXT("ARCHAEOLOGIST_CONFIG_PREFIXES_ON") end;
		callback=function()Archaeologist_SetPrefixPresets(2)end;
		setup={buttonText=function() return TEXT("ARCHAEOLOGIST_CONFIG_SET") end};
		mcopts = {
			subcom = string.lower("PrefixOn");
		};
	});
	
	table.insert(optionSet, {
		id="Preset1PrefixesDefault";
		type=K_BUTTON;
		text=function() return TEXT("ARCHAEOLOGIST_CONFIG_PREFIXES_DEFAULT") end;
		helptext=function() return TEXT("ARCHAEOLOGIST_CONFIG_PREFIXES_DEFAULT") end;
		callback=function()Archaeologist_SetPrefixPresets(3)end;
		setup={buttonText=function() return TEXT("ARCHAEOLOGIST_CONFIG_SET") end};
		mcopts = {
			subcom = string.lower("PrefixDefault");
		};
	});
	
	
	-- <= == == == == == == == == == == == =>
	-- => Looped Registering
	-- <= == == == == == == == == == == == =>
	
	local varPrefixes = { "MAIN", "PLAYER", "PARTY", "PET", "TARGET" };
	
	Archaeologist_SortPrefixes = varPrefixes;
	local keyList = Archaeologist_GetTableKeyList(ArchaeologistVarData);
	table.sort(keyList, Archaeologist_StatusBarOptionSort);
	
	for index, varPrefix in varPrefixes do
		local curText = "ARCHAEOLOGIST_CONFIG_"..varPrefix.."_SEP";
		local curHelpText = "ARCHAEOLOGIST_CONFIG_UNIT_SEP_INFO";
		local header = {
			id = Sea.string.capitalizeWords(varPrefix).."Header";
			type = K_HEADER;
			difficulty = 1;
			text = function() return TEXT(curText) end;
			helptext = function() return TEXT(curHelpText) end;
		};

		table.insert(optionSet, header);
		
		for k, index in keyList do
			local var = ArchaeologistVarData[index];
			if (type(index) == "string") then
				if (Sea.string.startsWith(index, varPrefix)) then
					local indexStub = strsub(index, string.len(varPrefix)+1);
					local f = ArchaeologistVarData[index].func;
					local option;
					if (ArchaeologistVarData[index].options) then
						option = {
							id = ArchaeologistVarData[index].name;
							type = K_PULLDOWN;
							difficulty = 1;
							text = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..indexStub) end;
							helptext = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..indexStub.."_INFO") end;
							--feedback = function(state) return Archaeologist_Feedback(index, state.value) end;
							dependencies = ArchaeologistVarData[index].dependencies;

							default = { 
								value = ArchaeologistVarData[index].default; 
							};
							disabled = {
								value = ArchaeologistVarData[index].disabled or ArchaeologistVarData[index].default;
							};
							setup = {
								options = ArchaeologistVarData[index].options;
								multiSelect = false;
							};
							mcopts = {
								subcom = string.lower(index);
								--subhelp = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..index.."_INFO") end;
								varchoice = "ArchaeologistVars."..index;
								update = function(varName) f(Sea.util.getValue(varName)); end;
								noupdate = function(varName) f(Sea.util.getValue(varName)); end;
							};
						};
					else
						option = {
							id = ArchaeologistVarData[index].name;
							check = true;
							type = K_TEXT;
							difficulty = 1;
							text = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..indexStub) end;
							helptext = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..indexStub.."_INFO") end;
							--feedback = function(state) return Archaeologist_Feedback(index, state.checked) end;
							default = { 
								checked = (ArchaeologistVarData[index].default == 1); 
							};
							disabled = {
								checked = (ArchaeologistVarData[index].disabled == 1) or (ArchaeologistVarData[index].disabled == nil and ArchaeologistVarData[index].default == 1);
							};
							dependencies = ArchaeologistVarData[index].dependencies;
							mcopts = {
								subcom = string.lower(index);
								varbool = "ArchaeologistVars."..index;
								update = function(varName) f(Sea.util.getValue(varName)); end;
								noupdate = function(varName) f(Sea.util.getValue(varName)); end;
							};
						};
					end

					table.insert(optionSet, option);
				end
			end
		end
		
	end
	
	-- <= == == == == == == == == == == == =>
	-- => Alternate Options Registering
	-- <= == == == == == == == == == == == =>

	local varPrefix = "ALTOPTS";
	
	local header = {
		id = Sea.string.capitalizeWords(varPrefix).."Header";
		type = K_HEADER;
		difficulty = 2;
		text = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..varPrefix.."_SEP") end;
		helptext = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..varPrefix.."_SEP_INFO") end;
	};
	table.insert(optionSet, header);
	
	varPrefixes = { "HPCOLOR", "DEBUFFALT", "TBUFFALT", "CLASSPORTRAIT", "THPALT" };

	if ( MobHealth_OnEvent ) then
		table.insert(varPrefixes, "MOBHEALTH" );
	end
	
	for index, varPrefix in varPrefixes do
		local f = ArchaeologistVarData[varPrefix].func;
		local curText = "ARCHAEOLOGIST_CONFIG_"..varPrefix;
		local curHelpText = "ARCHAEOLOGIST_CONFIG_"..varPrefix.."_INFO";
		local option = {
			id = ArchaeologistVarData[varPrefix].name;
			check = true;
			type = K_TEXT;
			difficulty = 2;
			text = function() return TEXT(curText) end;
			helptext = function() return TEXT(curHelpText) end;
			--feedback = function(state) return Archaeologist_Feedback(varPrefix, state.checked) end;
			default = { 
				checked = (ArchaeologistVarData[varPrefix].default == 1); 
			};
			disabled = {
				checked = (ArchaeologistVarData[varPrefix].disabled == 1) or (ArchaeologistVarData[varPrefix].default == nil and ArchaeologistVarData[varPrefix].default == 1);
			};
			dependencies = ArchaeologistVarData[varPrefix].dependencies;
			mcopts = {
				subcom = string.lower(varPrefix);
				varbool = "ArchaeologistVars."..varPrefix;
				update = function(varName) f(Sea.util.getValue(varName)); end;
				noupdate = function(varName) f(Sea.util.getValue(varName)); end;
			};
		};
		
		table.insert(optionSet, option);
	end
	
	-- <= == == == == == == == == == == == =>
	-- => Font Options Registering
	-- <= == == == == == == == == == == == =>
	
	local varPrefix = "FONTOPTS";
	
	local header = {
		id = Sea.string.capitalizeWords(varPrefix).."Header";
		type = K_HEADER;
		difficulty = 3;
		text = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..varPrefix.."_SEP") end;
		helptext = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..varPrefix.."_SEP_INFO") end;
	};
	table.insert(optionSet, header);
	
	varPrefixes = { "HPMPLARGE", "HPMPSMALL" };
	
	for index, varPrefix in varPrefixes do
		local id = varPrefix.."FONT";
		local f = ArchaeologistVarData[id].func;
		local option = {
			id = ArchaeologistVarData[id].name;
			type = K_PULLDOWN;
			difficulty = 3;
			text = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..id) end;
			helptext = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..id) end;
			--feedback = function(state) return Archaeologist_Feedback(id, state.value) end;
			dependencies = ArchaeologistVarData[id].dependencies;

			default = { 
				value = ArchaeologistVarData[id].default; 
			};
			disabled = {
				value = ArchaeologistVarData[id].default;
			};
			setup = {
				options = ArchaeologistVarData[id].options;
				multiSelect = false;
			};
			mcopts = {
				subcom = string.lower(id);
				subhelp = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..id.."_INFO") end;
				varchoice = "ArchaeologistVars."..id;
				update = function(varName) f(Sea.util.getValue(varName)); end;
				noupdate = function(varName) f(Sea.util.getValue(varName)); end;
			};
		};
		table.insert(optionSet, option);
		
		local id = varPrefix.."SIZE";
		local f = ArchaeologistVarData[id].func;
		local option = {
			id = ArchaeologistVarData[id].name;
			type = K_SLIDER;
			difficulty = 3;
			text = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..id) end;
			helptext = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..id) end;
			--feedback = function(state) return Archaeologist_Feedback(id, state.checked) end;
			dependencies = ArchaeologistVarData[id].dependencies;

			default = { 
				slider = ArchaeologistVarData[id].default; 
			};
			disabled = {
				slider = ArchaeologistVarData[id].default;
			};
			setup = {
				sliderMin = ArchaeologistVarData[id].min;
				sliderMax = ArchaeologistVarData[id].max;
				sliderStep = 1;
				sliderText = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..id.."_SLIDER_TEXT") end;
			};
			mcopts = {
				subcom = string.lower(id);
				varnum = "ArchaeologistVars."..id;
				update = function(varName) f(Sea.util.getValue(varName)); end;
				noupdate = function(varName) f(Sea.util.getValue(varName)); end;
			};
		};
		if ( ArchaeologistVars[id] == 1 ) then 
			option.default.checked = true;
		end
		table.insert(optionSet, option);			
	end
	
	varPrefixes = { "COLORPHP", "COLORPMP", "COLORSHP", "COLORSMP" };
	
	for index, varPrefix in varPrefixes do
		
		local data = ArchaeologistVarData[varPrefix];
		local subcom = string.lower(varPrefix);
		local varcolor = "ArchaeologistVars."..varPrefix;
		local colorResetFeedback = function(state)
			return string.format(TEXT("ARCHAEOLOGIST_COLOR_RESET"), Sea.string.colorToString(state.color), data.name );
		end
		
		local curText = "ARCHAEOLOGIST_CONFIG_"..varPrefix;
		local curHelpText = "ARCHAEOLOGIST_CONFIG_"..varPrefix.."_INFO";
		table.insert(
			optionSet,
			{
				id=ArchaeologistVarData[varPrefix].name;
				text=function() return TEXT(curText) end;
				helptext=function() return TEXT(curHelpText) end;
				difficulty=3;
				type=K_COLORPICKER;
				setup= {
					hasOpacity=true;
				};
				default={
					color=ArchaeologistVarData[varPrefix].default;
				};
				disabled={
					color=ArchaeologistVarData[varPrefix].default;
				};
				mcopts = {
					subcom = subcom;
					varcolor = varcolor;
					update = function(varName) data.func(Sea.util.getValue(varName)); end;
					noupdate = function(varName) data.func(Sea.util.getValue(varName)); end;
				};
			}
		);
		local curText = "ARCHAEOLOGIST_CONFIG_"..varPrefix.."_RESET";
		local curHelpText = "ARCHAEOLOGIST_CONFIG_"..varPrefix.."_RESET_INFO";
		table.insert(
			optionSet,
			{
				id=ArchaeologistVarData[varPrefix].name.."Reset";
				text=function() return TEXT(curText) end;
				helptext=function() return TEXT(curHelpText) end;
				difficulty=3;
				callback=function(state)
					--Khaos.setSetKey(KhaosCore.getCurrentSet(), data.name, {color=data.default});
					--Khaos.refresh(false, false, true);  --Refresh Visible
					Sea.util.setValue(varcolor, data.default);
					MCom.updateUI(ARCHAEOLOGIST_SUPER_SLASH_COMMAND, subcom)
				end;
				--feedback=colorResetFeedback;
				type=K_BUTTON;
				setup = {
					buttonText=RESET;
				};
			}
		);
	end
	
	-- <= == == == == == == == == == == == =>
	-- => Buff Registering
	-- <= == == == == == == == == == == == =>
	
	local varSections = { 
		PARTYBUFFS		= { "PBUFF", "PDEBUFF" };
		PARTYPETBUFFS   = { "PPTBUFF", "PPTDEBUFF" };
		PETBUFFS		= { "PTBUFF", "PTDEBUFF" };
		TARGETBUFFS		= { "TBUFF", "TDEBUFF" };
	};
	
	for headerPrefix, varPrefixes in varSections do
	
		local curText = "ARCHAEOLOGIST_CONFIG_"..headerPrefix.."_SEP";
		local curHelpText = "ARCHAEOLOGIST_CONFIG_"..headerPrefix.."_SEP_INFO";
		local header = {
			id = Sea.string.capitalizeWords(headerPrefix).."Header";
			type = K_HEADER;
			difficulty = 2;
			text = function() return TEXT(curText) end;
			helptext = function() return TEXT(curHelpText) end;
		};
		table.insert(optionSet, header);
		
		for index, varPrefix in varPrefixes do
			local id = varPrefix.."S";
			local f = ArchaeologistVarData[id].func;
			local option = {
				id = ArchaeologistVarData[id].name;
				check = true;
				type = K_TEXT;
				difficulty = 2;
				text = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..id) end;
				helptext = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..id.."_INFO") end;
				--feedback = function(state) return Archaeologist_Feedback(id, state.checked) end;
				default = { 
					checked = false; 
				};
				disabled = {
					checked = false;
				};
				dependencies = ArchaeologistVarData[id].dependencies;
				mcopts = {
					subcom = string.lower(id);
					varbool = "ArchaeologistVars."..id;
					update = function(varName) f(Sea.util.getValue(varName)); end;
					noupdate = function(varName) f(Sea.util.getValue(varName)); end;
				};
			};
			if ( ArchaeologistVars[id] == 1 ) then 
				option.default.checked = true;
			end
			
			table.insert(optionSet, option);
			
			local id = varPrefix.."NUM";
			local f = ArchaeologistVarData[id].func;

			local optionSlider = {
				id = ArchaeologistVarData[id].name;
				type = K_SLIDER;
				difficulty = 2;
				text = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..id) end;
				helptext = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..id.."_INFO") end;
				--feedback = function(state) return Archaeologist_Feedback(id, state.slider) end;
				dependencies = ArchaeologistVarData[id].dependencies;

				default = { 
					slider = ArchaeologistVarData[id].default; 
				};
				disabled = {
					slider = ArchaeologistVarData[id].default;
				};
				setup = {
					sliderMin = ArchaeologistVarData[id].min;
					sliderMax = ArchaeologistVarData[id].max;
					sliderStep = 1;
					sliderText = function() return TEXT("ARCHAEOLOGIST_CONFIG_"..id.."_SLIDER_TEXT") end;
				};
				mcopts = {
					subcom = string.lower(id);
					varnum = "ArchaeologistVars."..id;
					update = function(varName) f(Sea.util.getValue(varName)); end;
					noupdate = function(varName) f(Sea.util.getValue(varName)); end;
				};
			};
			if ( ArchaeologistVars[id] == 1 ) then 
				option.default.checked = true;
			end
			
			table.insert(optionSet, optionSlider);		
		end
	
	end
	
	-- <= == == == == == == == == == == == =>
	-- => Config Set Registering
	-- <= == == == == == == == == == == == =>
			
	MCom.registerSmart(
		{
			supercom = ARCHAEOLOGIST_SUPER_SLASH_COMMAND;
			uifolder = "frames",
			uiset = {
				id = ArchaeologistOptionSetName;
				text = function() return TEXT("ARCHAEOLOGIST_CONFIG_SEP") end;
				helptext = function() return TEXT("ARCHAEOLOGIST_CONFIG_SEP_INFO") end;
				difficulty = 1;
				options = optionSet;
			}
		}
	);

end

function Archaeologist_Feedback(id, setToValue)
	if (not id) then
		id = TEXT("UNKNOWN");
	end
	if (not setToValue) then
		setToValue = "false";
	end
	return string.format(TEXT("ARCHAEOLOGIST_FEEDBACK_STRING"), id, tostring(setToValue));
end


-- <= == == == == == == == == == == == =>
-- => Optional Sea duplicates (Don't waste memory if they already exists)
-- <= == == == == == == == == == == == =>

if (Sea and Sea.math and Sea.math.round) then
	Archaeologist_Round = Sea.math.round;
else
	Archaeologist_Round = function (x)
		if(x - math.floor(x) > 0.5) then
			x = x + 0.5;
		end
		return math.floor(x);
	end
end

if (Sea and Sea.table and Sea.table.getKeyList) then
	Archaeologist_GetTableKeyList = Sea.table.getKeyList;
else
	Archaeologist_GetTableKeyList = function (passedTable)
		if( type(passedTable) ~= "table" ) then
			return nil;
		end
		
		local keyList = { };
		for key, value in passedTable do
			table.insert(keyList, key)
		end
		return keyList;	
	end
end
