

zorlen_version = "3.62.00"


--[[
  Started by Marcus S. Zarra
  
  3.59.00
		Zorlen_ShowSpellTextureByName(SpellName) added by BigRedBrent
  
  3.53.00
		Updated: Zorlen_TargetIsEnemy() Should now work fine in duels
  
  3.52.00
		Zorlen_TargetNearestActiveEnemyWithHighestHealth() added by BigRedBrent
		Updated casting and channeling detection some.
		Added slash commands:
		This will allow you to disable the auto action bar button scanning that is done one second after the action bar grid is hidden:
		/zorlen button scan mode
		This will scan the action bars when used and is not needed unless you disable the auto action bar scanning or if you do not add or remove anything from your action bars:
		/zorlen button scan
  
  3.50.00
		Improved targeting to first target an active enemy around you with the lowest health.
  
  3.34.00
		Zorlen_UnitClass(unit) added by BigRedBrent -- Will only return the english names.
		Zorlen_UnitRace(unit) added by BigRedBrent -- Will only return the english names.
		Zorlen_isClass(class, unit) added by BigRedBrent
		Zorlen_isRace(race, unit) added by BigRedBrent
  
  3.33.33
		Zorlen_AllDebuffSlotsUsed() added by BigRedBrent
  
  3.33.02
		Updated Zorlen_isCrowedControlled()
  
  3.33.01
		Updated Zorlen_isNoDamageCC()
  
  3.30.00
		Updated targeting.
		Renamed some targeting functions to make more sense.
		Renamed: Zorlen_TargetAvtiveEnemy(mode) to: Zorlen_TargetNearestEnemy(mode)
		Renamed: Zorlen_TargetEnemyPlayer() to: Zorlen_TargetEnemyPlayerFirst()
		Renamed: Zorlen_TargetEnemyPlayerOrActiveEnemyOnly to: Zorlen_TargetEnemyPlayerFirstOrActiveEnemyOnly
		Zorlen_isNoDamageCC() added by BigRedBrent
		Zorlen_isCrowedControlled() added by BigRedBrent
		Zorlen_TargetIsEnemyPlayer() added by BigRedBrent
		Zorlen_TargetIsEnemyMob() added by BigRedBrent
		Zorlen_TargetIsActiveEnemyMob() added by BigRedBrent
		Zorlen_TargetEnemyMobOnly() added by BigRedBrent
		Zorlen_TargetActiveEnemyMobOnly() added by BigRedBrent
		
  
  3.25.02
		Fixed a bug with Zorlen_TargetIsActiveEnemy(unit) that would incorrectly label a neutral mob as being active.
  
  3.25.00
		Updated targeting some.
		Zorlen_TargetMarkedEnemyOnly() added by BigRedBrent
  
  3.24.00
		Added casting detection and updated warlock section to support it.
  
  3.22.00
		Added more key bindings.
		
		Replaced all buff/debuff functions with:
		Zorlen_ShowAllDebuffs(unit)
		Zorlen_ShowAllBuffs(unit)
		Zorlen_checkDebuff(buff, unit)
		Zorlen_checkBuff(buff, unit)
		Zorlen_checkDebuffBySpellName(SpellName, unit)
		Zorlen_checkBuffBySpellName(SpellName, unit)
		Zorlen_checkSelfDebuffBySpellName(SpellName)
		Zorlen_checkTargetBuffBySpellName(SpellName)
		Zorlen_checkDebuffBySpellID(SpellID, unit)
		Zorlen_checkBuffBySpellID(SpellID, unit)
		Zorlen_GetDebuffStack(buff, unit)
		Zorlen_GetDebuffStackBySpellName(SpellName, unit)
		Zorlen_GetDebuffStackBySpellID(SpellID, unit)
		Zorlen_isBreakOnDamageCC(unit)
  
  3.21.00
		Zorlen_TargetEnemyPlayerFirst() added by BigRedBrent
		Zorlen_TargetEnemyPlayerOnly() added by BigRedBrent
		Zorlen_clearAssist() added by BigRedBrent
		Zorlen_TargetByName() added by BigRedBrent
		Zorlen_changeTargetByName() added by BigRedBrent
		Zorlen_clearTargetByName() added by BigRedBrent
		Slash commands "/ztarget" or "/zt" added by BigRedBrent - Example: "/ztarget Bigredbrent" will target the specified target name (me) if in range (and if you happen to be on the Bonechewer server) and will not target anything else unless the name is exactly the same
		Slash commands "/zchangetarget" or "/zct" or "/zsettarget" or "/zst" added by BigRedBrent - Example: "/zchangetarget Bigredbrent" will save Bigredbrent as your saved target name. Then you can use "/ztarget" (with no name after it) or the "Target By Name" key binding to target the saved name.
		Slash commands "/zcleartarget" or "/zcleart" added by BigRedBrent  -  Will remove and clear the saved target.
		Slash commands "/zassist" or "/za" added by BigRedBrent - Example: "/zassist Bigredbrent" will assist Bigredbrent
		Slash commands "/zchangeassist" or "/zca" or "/zsetassist" or "/zsa" added by BigRedBrent - Example: "/zchangeassist Bigredbrent" will save Bigredbrent as your saved assist name. Then you can use "/zassist" (with no name after it) or the "Assist" key binding to assist the saved name.
		Slash commands "/zclearassist" or "/zcleara" added by BigRedBrent  -  Will remove and clear the saved assist.
  
  3.20.00
		Zorlen_TargetActiveEnemyOnly() added by BigRedBrent
		Zorlen_TargetFirstEnemy() added by BigRedBrent
  
  3.17.00
		Zorlen_TargetIsCrowedControlled() replaced by Zorlen_isBreakOnDamageCC()
  
  3.16.01
		Zorlen_isBreakOnDamageCC() Fixed by BigRedBrent
  
  3.11
		Zorlen_isBreakOnDamageCC() added by BigRedBrent
		Zorlen_isMainHandDagger() added by BigRedBrent
		Zorlen_isMainHandSword() added by BigRedBrent
		Zorlen_isMainHandAxe() added by BigRedBrent
		Zorlen_isMainHandMace() added by BigRedBrent
		Zorlen_isMainHandFistWeapon() added by BigRedBrent
		Zorlen_isPolearmEquipped() added by BigRedBrent
		Zorlen_isStaveEquipped() added by BigRedBrent
		Zorlen_isFishingPoleEquipped() added by BigRedBrent
  
  3.9.12
		Zorlen_checkTargetDebuffBySpellName(SpellName) added by BigRedBrent
		Improved Zorlen_TargetEnemy()
  
  3.9.0
		Zorlen_GetSpellTextureByName(SpellName) added by BigRedBrent
		Zorlen_GiveMaxTargetRange() added by BigRedBrent
  
  3.5.5
		Moved isMeld() to the Zorlen_Other.lua file.
  
  3.5.1
		Removed: Zorlen_checkTargetDebuffByName(TextureName)    since Zorlen_checkDebuff(buff) does the same thing.
  
  3.3.1
  
  3.3.1
		Zorlen_isShieldEquipped() added by BigRedBrent
		Zorlen_GetDebuffStack(buff) added by BigRedBrent
		Zorlen_isMainHandEquipped() added by BigRedBrent
  
  3.3.0
		Zorlen_GetSpellRank(SpellName) added by BigRedBrent
  
  3.0.3c  
		Zorlen_IsSpellKnown(SpellName) added by BigRedBrent
  
  3.0.3  
		Zorlen_notInCombat() added by BigRedBrent
		Zorlen_TargetIsEnemyTargetingYou() added by BigRedBrent
		Zorlen_TargetIsEnemyTargetingFriendButNotYou() added by BigRedBrent
		Zorlen_TargetIsEnemyTargetingEnemy() added by BigRedBrent
		Zorlen_TargetIsEnemy() added by BigRedBrent
		Zorlen_TargetIsActiveEnemy() added by BigRedBrent
		Zorlen_TargetIsDieingEnemy() added by BigRedBrent
		Zorlen_TargetIsDieingEnemyWithNoTarget() added by BigRedBrent
		Zorlen_TargetIsFriendTargetingEnemy() added by BigRedBrent
		Zorlen_TargetIsFriendTargetingActiveEnemy() added by BigRedBrent
		Zorlen_TargetEnemy() added by BigRedBrent
		Zorlen_TargetNearestEnemy() added by BigRedBrent
		Zorlen_AssistTargetedFriendTargetingActiveEnemy() added by BigRedBrent
		Zorlen_checkCooldown(SpellID)
		Zorlen_checkSelfBuff(SpellID)
		Zorlen_checkTargetBuff(SpellID)
		Zorlen_checkTargetDebuff(SpellID)
		Replaced: GetSpellID(SpellName) With: Zorlen_GetSpellID(SpellName)
		Replaced: checkCoolThenCast(SpellID) With: Zorlen_checkCoolThenCast(SpellID)

  3.0.2  Changed the local variables to non local so that they can be seen
        in the other files.
  3.0.1  Changed default behavior for dodge sound.  Now off by default.
  3.0.0  Rewrite by Wynn (Bleeding Hollow), break units into class functions.
  		Added Zorlen_Hunter, Zorlen_Warrior, Zorlen_Warlock. Zorlen_Pets
  		Move all Hunter specific functions to Zorlen_Hunter.lua
  		Zorlen_HasTalent() added by Wynn
		Zorlen_GetTalentRank() added by Wynn  		
  
  2.14  castMend() added by Trevor with help by BigRedBrent
        castMaxMend() added by Trevor with help by BigRedBrent
        castOverMend() added by Trevor with help by BigRedBrent
        needPet() added by Trevor
        rezPet() added by Trevor
        Zorlen_IsSpellRankKnown(spell, rank) added by Bear
  2.13  zProwl() added by Trevor
        isRapidActive() and isQuickshotsActive() added by Leica
        hasMana() and usesMana() added by Zorlen with help from chazz
        castMark() will now return true if it casts and false otherwise
        castMend() added by BigRedBrent
        petInCombat() added by chazz
  2.11  castClip() added by Jayphen
        castRaptor(), castMong(), castCon() added by Nuckin
        Modifications to melee and combat detection functions
  2.10  isHiding() and isFeigning() added.  
        Both written by Malnyth of Ravencrest
  2.9.1 Zorlen_inCombat is functioning again.  Added melee()
  2.9   Added zDash, zDive, zClaw, zBite, zCower and zGrowl
  2.8.1 Added a check for the target's mana in castViper().  Now if a target
        does not have mana then the cast will return false.  
        Thanks to Tom Martin for this addition.
]]



BINDING_HEADER_ZORLEN_BINDINGS = "   < < <   Zorlen   > > >"
BINDING_HEADER_ZORLEN_DRUID_BINDINGS = "   < < <   Druid   > > >"
BINDING_HEADER_ZORLEN_HUNTER_BINDINGS = "   < < <   Hunter   > > >"
BINDING_HEADER_ZORLEN_MAGE_BINDINGS = "   < < <   Mage   > > >"
BINDING_HEADER_ZORLEN_PALADIN_BINDINGS = "   < < <   Paladin   > > >"
BINDING_HEADER_ZORLEN_PRIEST_BINDINGS = "   < < <   Priest   > > >"
BINDING_HEADER_ZORLEN_ROGUE_BINDINGS = "   < < <   Rogue   > > >"
BINDING_HEADER_ZORLEN_SHAMAN_BINDINGS = "   < < <   Shaman   > > >"
BINDING_HEADER_ZORLEN_WARLOCK_BINDINGS = "   < < <   Warlock   > > >"
BINDING_HEADER_ZORLEN_WARRIOR_BINDINGS = "   < < <   Warrior   > > >"
local feedTypeMsg = "Item in Slot is type: [%s]"
local feedErrorMsg = "Please place food in the first slot of the bag."
local macroErrorMsg = "You have too many macros, cannot add another."
local zorlen_startup_message = "Zorlen Functions Library v"..zorlen_version.." enabled"
local ZPN = nil;
local ZDS = "dodge_silent"
local ASSIST = "assist"
local TARGETBYNAME = "target_by_name"
local DEBUG = "debug"
local FULLDEBUG = "full_debug_mode"
local DEBUGRELOADUI = "debug_reloadui"
local PETISDEAD = "pet_is_dead"
local AUTOBUTTONSCANOFF = "auto_button_refresh_scan_off"
local Zorlen_VariablesLoaded = nil;
local ZorlenInitialized = nil;
Zorlen_LocalizedPlayerClass, Zorlen_PlayerClass = UnitClass("player");
Zorlen_LocalizedPlayerRace, Zorlen_PlayerRace = UnitRace("player");


if (Zorlen_PlayerClass == "PRIEST") then
	Zorlen_isCurrentClassPriest = 1
else if (Zorlen_PlayerClass == "ROGUE") then
	Zorlen_isCurrentClassRogue = 1
else if (Zorlen_PlayerClass == "PALADIN") then
	Zorlen_isCurrentClassPaladin = 1
else if (Zorlen_PlayerClass == "WARLOCK") then
	Zorlen_isCurrentClassWarlock = 1
else if (Zorlen_PlayerClass == "WARRIOR") then
	Zorlen_isCurrentClassWarrior = 1
else if (Zorlen_PlayerClass == "HUNTER") then
	Zorlen_isCurrentClassHunter = 1
else if (Zorlen_PlayerClass == "MAGE") then
	Zorlen_isCurrentClassMage = 1
else if (Zorlen_PlayerClass == "SHAMAN") then
	Zorlen_isCurrentClassShaman = 1
else if (Zorlen_PlayerClass == "DRUID") then
	Zorlen_isCurrentClassDruid = 1
end
end
end
end
end
end
end
end
end

if (Zorlen_PlayerRace == "Human") then
	Zorlen_isCurrentRaceHuman = 1
else if (Zorlen_PlayerRace == "Dwarf") then
	Zorlen_isCurrentRaceDwarf = 1
else if (Zorlen_PlayerRace == "Gnome") then
	Zorlen_isCurrentRaceGnome = 1
else if (Zorlen_PlayerRace == "Night Elf") then
	Zorlen_isCurrentRaceNightElf = 1
else if (Zorlen_PlayerRace == "Orc") then
	Zorlen_isCurrentRaceOrc = 1
else if (Zorlen_PlayerRace == "Scourge") or (Zorlen_PlayerRace == "Undead") then
	Zorlen_isCurrentRaceUndead = 1
else if (Zorlen_PlayerRace == "Tauren") then
	Zorlen_isCurrentRaceTauren = 1
else if (Zorlen_PlayerRace == "Troll") then
	Zorlen_isCurrentRaceTroll = 1
end
end
end
end
end
end
end
end

function Zorlen_SlashHandler(msg)
	if (msg == '') or (msg == 'options') or (msg == 'help') or (msg == 'debug options') or (msg == 'debug help') then
		if ZorlenConfig[ZPN][DEBUG] or Zorlen_DebugFlag or (msg == 'debug options') or (msg == 'debug help') then
			DEFAULT_CHAT_FRAME:AddMessage("Zorlen options:");
			DEFAULT_CHAT_FRAME:AddMessage("[  dodge  |  status  |  version  |  button scan mode  |  button scan  ]");
			DEFAULT_CHAT_FRAME:AddMessage("[  button scan on  |  button scan off  ]");
			DEFAULT_CHAT_FRAME:AddMessage("[  debug  |  debug on  |  debug off  |  debug mode  ]");
			DEFAULT_CHAT_FRAME:AddMessage("[  debug temp  |  debug temp on  |  debug temp off  ]");
			DEFAULT_CHAT_FRAME:AddMessage("[  debug options  |  debug status  |  debug reloadui  ]");
		else
			DEFAULT_CHAT_FRAME:AddMessage("Zorlen options:");
			DEFAULT_CHAT_FRAME:AddMessage("[  dodge  |  status  |  version  |  button scan mode  |  button scan  ]");
		end
	end
	if (msg == 'version') or (msg == 'ver') or (msg == 'v') then
		DEFAULT_CHAT_FRAME:AddMessage("Zorlen Functions Library Version: "..zorlen_version.."");
	end
	if (msg == 'debug') then
		if ZorlenConfig[ZPN][DEBUG] or Zorlen_DebugFlag then
			DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug is disabled");
			DEFAULT_CHAT_FRAME:AddMessage("Use (  /zorlen debug options  ) to see full list of options");
			ZorlenConfig[ZPN][DEBUG] = nil;
			Zorlen_DebugFlag = nil;
		else
			DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug is enabled");
			ZorlenConfig[ZPN][DEBUG] = true;
			Zorlen_DebugFlag = 1;
		end
	end
	if (msg == 'debug on') then
		Zorlen_DebugFlag = 1;
		ZorlenConfig[ZPN][DEBUG] = true;
		DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug is enabled");
	end
	if (msg == 'debug off') then
		Zorlen_DebugFlag = nil;
		ZorlenConfig[ZPN][DEBUG] = nil;
		DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug is disabled");
		DEFAULT_CHAT_FRAME:AddMessage("Use (  /zorlen debug options  ) to see full list of options");
	end
	if (msg == 'debug temp') or (msg == 'debug tmp') or (msg == 'debug temporary') then
		if Zorlen_DebugFlag then
			Zorlen_DebugFlag = nil;
			if ZorlenConfig[ZPN][DEBUG] then
				DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug is disabled for this session only");
				DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug will be enabled if you logout or reload the UI");
			else
				DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug is disabled");
				DEFAULT_CHAT_FRAME:AddMessage("Use (  /zorlen debug options  ) to see full list of options");
			end
		else 
			Zorlen_DebugFlag = 1;
			if ZorlenConfig[ZPN][DEBUG] then
				DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug is enabled");
			else
				DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug is enabled for this session only");
				DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug will be disabled if you logout or reload the UI");
			end
		end
	end
	if (msg == 'debug temp on') or (msg == 'debug tmp on') or (msg == 'debug temporary on') then
		Zorlen_DebugFlag = 1;
		if ZorlenConfig[ZPN][DEBUG] then
			DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug is enabled");
		else
			DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug is enabled for this session only");
			DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug will be disabled if you logout or reload the UI");
		end
	end
	if (msg == 'debug temp off') or (msg == 'debug tmp off') or (msg == 'debug temporary off') then
		Zorlen_DebugFlag = nil;
		if ZorlenConfig[ZPN][DEBUG] then
			DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug is disabled for this session only");
			DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug will be enabled if you logout or reload the UI");
		else
			DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug is disabled");
			DEFAULT_CHAT_FRAME:AddMessage("Use (  /zorlen debug options  ) to see full list of options");
		end
	end
	if (msg == 'debug mode') then
		if ZorlenConfig[ZPN][FULLDEBUG] then
			Zorlen_FullDebug = nil;
			ZorlenConfig[ZPN][FULLDEBUG] = nil;
			DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug mode has been set to normal");
		else
			Zorlen_FullDebug = 1;
			ZorlenConfig[ZPN][FULLDEBUG] = true;
			DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug mode has been set to full");
		end
	end
	if (msg == 'debug full on') or (msg == 'debug mode full on') or (msg == 'debug full') or (msg == 'debug mode full') then
		Zorlen_FullDebug = 1;
		ZorlenConfig[ZPN][FULLDEBUG] = true;
		DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug mode has been set to full");
	end
	if (msg == 'debug full off') or (msg == 'debug mode full off') or (msg == 'debug normal') or (msg == 'debug normal on') or (msg == 'debug mode normal') or (msg == 'debug mode normal on') then
		Zorlen_FullDebug = nil;
		ZorlenConfig[ZPN][FULLDEBUG] = nil;
		DEFAULT_CHAT_FRAME:AddMessage("Zorlen debug mode has been set to normal");
	end
	if (msg == 'debug reloadui') or (msg == 'debug reload ui') or (msg == 'debug reload') or (msg == 'debug rl') or (msg == 'debug rui') or (msg == 'debug rlui') then
		ZorlenConfig[ZPN][DEBUGRELOADUI] = true;
		ReloadUI();
	end
	if (msg == 'reloadui') or (msg == 'reload ui') or (msg == 'reload') or (msg == 'rui') or (msg == 'rl') or (msg == 'rlui') then
		ReloadUI();
	end
	if (msg == 'dodge') then
		if Zorlen_isCurrentClassHunter then
			if ZorlenConfig[ZPN][ZDS] then
				DEFAULT_CHAT_FRAME:AddMessage("Dodge sound is enabled");
				ZorlenConfig[ZPN][ZDS] = nil;
			else
				DEFAULT_CHAT_FRAME:AddMessage("Dodge sound is disabled");
				ZorlenConfig[ZPN][ZDS] = true;
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("This function is only for Hunters");
		end
	end
	if (msg == 'silent') or (msg == 'silent on') or (msg == 'dodge off') then
		if Zorlen_isCurrentClassHunter then
			DEFAULT_CHAT_FRAME:AddMessage("Dodge sound is disabled");
			ZorlenConfig[ZPN][ZDS] = true;
		else
			DEFAULT_CHAT_FRAME:AddMessage("This function is only for Hunters");
		end
	end
	if (msg == 'silent off') or (msg == 'dodge on') then
		if Zorlen_isCurrentClassHunter then
			DEFAULT_CHAT_FRAME:AddMessage("Dodge sound is enabled");
			ZorlenConfig[ZPN][ZDS] = nil;
		else
			DEFAULT_CHAT_FRAME:AddMessage("This function is only for Hunters");
		end
	end
	if (msg == 'button scan') or (msg == 'buttonscan') then
		Zorlen_RegisterButtons("show")
	end
	if (msg == 'button scan mode') or (msg == 'buttonscan mode') then
		if ZorlenConfig[ZPN][AUTOBUTTONSCANOFF] then
			DEFAULT_CHAT_FRAME:AddMessage("Auto action bar button refresh scan is enabled");
			ZorlenConfig[ZPN][AUTOBUTTONSCANOFF] = nil;
		else
			DEFAULT_CHAT_FRAME:AddMessage("Auto action bar button refresh scan is disabled");
			ZorlenConfig[ZPN][AUTOBUTTONSCANOFF] = true;
		end
	end
	if (msg == 'button scan off') or (msg == 'buttonscan off') or (msg == 'button scan mode off') or (msg == 'buttonscan mode off') then
		DEFAULT_CHAT_FRAME:AddMessage("Auto action bar button refresh scan is disabled");
		ZorlenConfig[ZPN][AUTOBUTTONSCANOFF] = true;
	end
	if (msg == 'button scan on') or (msg == 'buttonscan on') or (msg == 'button scan mode on') or (msg == 'buttonscan mode on') then
		DEFAULT_CHAT_FRAME:AddMessage("Auto action bar button refresh scan is enabled");
		ZorlenConfig[ZPN][AUTOBUTTONSCANOFF] = nil;
	end
	if (msg == 'status') or (msg == 'show') or (msg == 'debug status') or (msg == 'debug show') then
		DEFAULT_CHAT_FRAME:AddMessage("Zorlen v"..zorlen_version.." Status:");
		if ZorlenConfig[ZPN][ZDS] then
			DEFAULT_CHAT_FRAME:AddMessage("Dodge sound is set to OFF");
		else
			DEFAULT_CHAT_FRAME:AddMessage("Dodge sound is set to ON");
		end
		if ZorlenConfig[ZPN][DEBUG] and Zorlen_DebugFlag then
			DEFAULT_CHAT_FRAME:AddMessage("Debug is set to ON");
		end
		if ZorlenConfig[ZPN][DEBUG] and not Zorlen_DebugFlag then
			DEFAULT_CHAT_FRAME:AddMessage("Debug is set to ON,   but has been turned off for this session only");
		end
		if not ZorlenConfig[ZPN][DEBUG] and Zorlen_DebugFlag then
			DEFAULT_CHAT_FRAME:AddMessage("Debug is set to OFF,   but has been turned on for this session only");
		end
		if not ZorlenConfig[ZPN][DEBUG] and not Zorlen_DebugFlag and ((msg == 'debug status') or (msg == 'debug show')) then
			DEFAULT_CHAT_FRAME:AddMessage("Debug is set to OFF");
		end
	end
end

function Zorlen_ZorlenTargetSlashHandler(msg)
	if (msg == '') then
		Zorlen_TargetByName()
	else
		Zorlen_TargetByName(msg)
	end
end

function Zorlen_ZorlenChangeTargetSlashHandler(msg)
	if (msg == '') then
		Zorlen_changeTargetByName()
	else
		Zorlen_changeTargetByName(msg)
	end
end

function Zorlen_ZorlenClearTargetSlashHandler()
	Zorlen_clearTargetByName()
end

function Zorlen_ZorlenAssistSlashHandler(msg)
	if (msg == '') then
		Zorlen_assist()
	else
		Zorlen_assist(msg)
	end
end

function Zorlen_ZorlenChangeAssistSlashHandler(msg)
	if (msg == '') then
		Zorlen_changeAssist()
	else
		Zorlen_changeAssist(msg)
	end
end

function Zorlen_ZorlenClearAssistSlashHandler()
	Zorlen_clearAssist()
end

function Zorlen_OnLoad()
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_REGEN_DISABLED");
	this:RegisterEvent("PLAYER_ENTER_COMBAT");
	this:RegisterEvent("PLAYER_LEAVE_COMBAT");
	this:RegisterEvent("START_AUTOREPEAT_SPELL");
	this:RegisterEvent("STOP_AUTOREPEAT_SPELL");
	this:RegisterEvent("PET_ATTACK_START");
	this:RegisterEvent("PET_ATTACK_STOP");
	this:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("UPDATE_BONUS_ACTIONBAR");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("ACTIONBAR_HIDEGRID");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_CHANNEL_START");
	this:RegisterEvent("SPELLCAST_CHANNEL_UPDATE");
	this:RegisterEvent("SPELLCAST_CHANNEL_STOP");
	this:RegisterEvent("SPELLCAST_STOP");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
	this:RegisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER");
	this:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES");
	this:RegisterEvent("UI_ERROR_MESSAGE");
	SlashCmdList["Zorlen"] = Zorlen_SlashHandler;
	SLASH_Zorlen1 = "/Zorlen"
	SLASH_Zorlen2 = "/Zfl"
	SlashCmdList["ZorlenTarget"] = Zorlen_ZorlenTargetSlashHandler;
	SLASH_ZorlenTarget1 = "/Zorlentarget"
	SLASH_ZorlenTarget2 = "/Ztarget"
	SLASH_ZorlenTarget3 = "/Zorlent"
	SLASH_ZorlenTarget4 = "/Zt"
	SlashCmdList["ZorlenChangeTarget"] = Zorlen_ZorlenChangeTargetSlashHandler;
	SLASH_ZorlenChangeTarget1 = "/Zorlenchangetarget"
	SLASH_ZorlenChangeTarget2 = "/Zorlensettarget"
	SLASH_ZorlenChangeTarget3 = "/Zchangetarget"
	SLASH_ZorlenChangeTarget4 = "/Zsettarget"
	SLASH_ZorlenChangeTarget5 = "/Zctarget"
	SLASH_ZorlenChangeTarget6 = "/Zstarget"
	SLASH_ZorlenChangeTarget7 = "/Zorlenct"
	SLASH_ZorlenChangeTarget8 = "/Zorlenst"
	SLASH_ZorlenChangeTarget9 = "/Zct"
	SLASH_ZorlenChangeTarget10 = "/Zst"
	SlashCmdList["ZorlenClearTarget"] = Zorlen_ZorlenClearTargetSlashHandler;
	SLASH_ZorlenClearTarget1 = "/Zorlencleartarget"
	SLASH_ZorlenClearTarget2 = "/Zorlencleart"
	SLASH_ZorlenClearTarget3 = "/Zcleartarget"
	SLASH_ZorlenClearTarget4 = "/Zcleart"
	SlashCmdList["ZorlenAssist"] = Zorlen_ZorlenAssistSlashHandler;
	SLASH_ZorlenAssist1 = "/Zorlenassist"
	SLASH_ZorlenAssist2 = "/Zassist"
	SLASH_ZorlenAssist3 = "/Zorlena"
	SLASH_ZorlenAssist4 = "/Za"
	SlashCmdList["ZorlenChangeAssist"] = Zorlen_ZorlenChangeAssistSlashHandler;
	SLASH_ZorlenChangeAssist1 = "/Zorlenchangeassist"
	SLASH_ZorlenChangeAssist2 = "/Zorlensetassist"
	SLASH_ZorlenChangeAssist3 = "/Zchangeassist"
	SLASH_ZorlenChangeAssist4 = "/Zsetassist"
	SLASH_ZorlenChangeAssist5 = "/Zcassist"
	SLASH_ZorlenChangeAssist6 = "/Zsassist"
	SLASH_ZorlenChangeAssist7 = "/Zorlenca"
	SLASH_ZorlenChangeAssist8 = "/Zorlensa"
	SLASH_ZorlenChangeAssist9 = "/Zca"
	SLASH_ZorlenChangeAssist10 = "/Zsa"
	SlashCmdList["ZorlenClearAssist"] = Zorlen_ZorlenClearAssistSlashHandler;
	SLASH_ZorlenClearAssist1 = "/Zorlenclearassist"
	SLASH_ZorlenClearAssist2 = "/Zorlencleara"
	SLASH_ZorlenClearAssist3 = "/Zclearassist"
	SLASH_ZorlenClearAssist4 = "/Zcleara"
	DEFAULT_CHAT_FRAME:AddMessage(zorlen_startup_message);
end

function Zorlen_OnUpdate(arg1)
	if not this.ACTIONBAR_HIDEGRID_timer and not this.TargetByName_timer and not this.Channeling_timer then
		if not Zorlen_isCurrentClassHunter then
			if not Zorlen_isCurrentClassWarrior or (not this.CastChargeDelay_timer and not this.Sunder_timer and not this.SunderImmune_timer and not this.RendImmune_timer and not this.HamstringImmune_timer and not this.Dodged_Overpower_timer and not this.castBerserkerRageSwap_SwapWindow_timer) then
				this:Hide();
			end
		end
	end
	if this.Channeling_timer then
		this.Channeling_timer = this.Channeling_timer - arg1;
		if this.Channeling_timer <= 0 then
			Zorlen_Channeling = nil;
			Zorlen_ChannelingSpellName = nil;
			Zorlen_ChannelingSpellRank = nil;
			this.Channeling_timer = nil;
			Zorlen_debug("Channeling Stop: from time out");
		end
	end
	if this.TargetByName_timer then
		this.TargetByName_timer = this.TargetByName_timer - arg1;
		if this.TargetByName_timer <= 0 or Zorlen_TargetByNameEnd then
			if Zorlen_TargetByNameEnd and not (Zorlen_TargetByNameName == UnitName("target")) then
				TargetLastTarget()
			end
			Zorlen_TargetByNameStart = nil;
			Zorlen_TargetByNameEnd = nil;
			Zorlen_TargetByNameName = nil;
			this.TargetByName_timer = nil;
		end
	end
	if this.ACTIONBAR_HIDEGRID_timer then
		this.ACTIONBAR_HIDEGRID_timer = this.ACTIONBAR_HIDEGRID_timer - arg1;
		if this.ACTIONBAR_HIDEGRID_timer <= 0 then
			if Zorlen_DebugFlag then
				Zorlen_RegisterButtons("show")
			else
				Zorlen_RegisterButtons()
			end
			this.ACTIONBAR_HIDEGRID_timer = nil;
		end
	end
	if Zorlen_isCurrentClassWarrior then
			if this.CastChargeDelay_timer then
				this.CastChargeDelay_timer = this.CastChargeDelay_timer - arg1;
				if (this.CastChargeDelay_timer <= 0) or (CheckInteractDistance("target", 1)) then
					Zorlen_CastChargeDelay = nil;
					this.CastChargeDelay_timer = nil;
				end
			end
			if this.castBerserkerRageSwap_SwapWindow_timer then
				this.castBerserkerRageSwap_SwapWindow_timer = this.castBerserkerRageSwap_SwapWindow_timer - arg1;
				if (this.castBerserkerRageSwap_SwapWindow_timer <= 0) then
					Zorlen_castBerserkerRageSwap_SwapStart = nil;
					Zorlen_castBerserkerRageSwap_SwapBack = nil;
					Zorlen_castBerserkerRageSwap_OldStance = nil;
					Zorlen_castBerserkerRageSwap_SwapWindow = nil;
					this.castBerserkerRageSwap_SwapWindow_timer = nil;
				end
			end
			if this.Dodged_Overpower_timer then
				this.Dodged_Overpower_timer = this.Dodged_Overpower_timer - arg1;
				if (this.Dodged_Overpower_timer <= 0) then
					Zorlen_TargetDodgedYou_Overpower = nil;
					this.Dodged_Overpower_timer = nil;
				end
			end
			if this.HamstringImmune_timer then
				this.HamstringImmune_timer = this.HamstringImmune_timer - arg1;
				if (this.HamstringImmune_timer <= 0) then
					Zorlen_HamstringSpellCastImmune = nil;
					this.HamstringImmune_timer = nil;
				end
			end
			if this.RendImmune_timer then
				this.RendImmune_timer = this.RendImmune_timer - arg1;
				if (this.RendImmune_timer <= 0) then
					Zorlen_RendSpellCastImmune = nil;
					this.RendImmune_timer = nil;
				end
			end
			if this.SunderImmune_timer then
				this.SunderImmune_timer = this.SunderImmune_timer - arg1;
				if (this.SunderImmune_timer <= 0) then
					Zorlen_SunderSpellCastImmune = nil;
					this.SunderImmune_timer = nil;
				end
			end
			if this.Sunder_timer then
				this.Sunder_timer = this.Sunder_timer - arg1;
				if (this.Sunder_timer <= 0) then
					Zorlen_SunderSpellCastStart = nil;
					Zorlen_SunderSpellCastEnd = nil;
					Zorlen_SunderSpellCastFailed = nil;
					Zorlen_SunderTimerHasPassed = 1;
					this.Sunder_timer = nil;
					if isSunderFull() then
						Zorlen_debug("Cast "..LOCALIZATION_ZORLEN_SunderArmor.." Now!")
					end
				end
			end
	end
	if Zorlen_isCurrentClassHunter then
			if this.AimedShotRotationWindow_timer then
				this.AimedShotRotationWindow_timer = this.AimedShotRotationWindow_timer - arg1;
				if (this.AimedShotRotationWindow_timer <= 0) then
					Zorlen_AimedShotRotationWindow = nil;
					this.AimedShotRotationWindow_timer = nil;
				end
			end
			if this.ViperStingImmune_timer then
				this.ViperStingImmune_timer = this.ViperStingImmune_timer - arg1;
				if (this.ViperStingImmune_timer <= 0) then
					Zorlen_ViperStingSpellCastImmune = nil;
					this.ViperStingImmune_timer = nil;
				end
			end
			if this.ConcussiveShotImmune_timer then
				this.ConcussiveShotImmune_timer = this.ConcussiveShotImmune_timer - arg1;
				if (this.ConcussiveShotImmune_timer <= 0) then
					Zorlen_ConcussiveShotSpellCastImmune = nil;
					this.ConcussiveShotImmune_timer = nil;
				end
			end
			if this.WingClipImmune_timer then
				this.WingClipImmune_timer = this.WingClipImmune_timer - arg1;
				if (this.WingClipImmune_timer <= 0) then
					Zorlen_WingClipSpellCastImmune = nil;
					this.WingClipImmune_timer = nil;
				end
			end
			if not Zorlen_PetIsDead then
				if (not (UnitHealth("pet") > 0) and (UnitIsDead("pet") or PetCanBeAbandoned())) then
					Zorlen_debug("Your pet is now dead!");
					Zorlen_PetIsDead = 1;
					ZorlenConfig[ZPN][PETISDEAD] = true;
				end
			end
			if Zorlen_PetIsDead then
				if UnitHealth("pet") > 0 then
					Zorlen_debug("Your pet is now alive!");
					Zorlen_PetIsDead = nil;
					ZorlenConfig[ZPN][PETISDEAD] = nil;
				end
			end
	end
end

--Monitor combat status ourselves since the built in variables cannot be 
--trusted for some reason. 
function Zorlen_OnEvent(event, arg1, arg2, arg3)
	if (event == "PLAYER_REGEN_DISABLED") then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			Zorlen_Combat = 1
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "PLAYER_REGEN_ENABLED") then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			Zorlen_Combat = nil
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "PLAYER_ENTER_COMBAT") then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			Zorlen_Melee = 1
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "PLAYER_LEAVE_COMBAT") then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			Zorlen_Melee = nil
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "PET_ATTACK_START") then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			Zorlen_PetCombat = 1
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "PET_ATTACK_STOP") then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			Zorlen_PetCombat = nil
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES") then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			if Zorlen_isCurrentClassHunter then
					if (string.find(arg1, LOCALIZATION_ZORLEN_You_dodge)) then
						Zorlen_debug("You dodged an attack. Cast "..LOCALIZATION_ZORLEN_MongooseBite.." now!");
						if not ZorlenInitialized then
							Zorlen_CheckVariables()
						elseif (not ZorlenConfig[ZPN][ZDS]) then
							PlaySound("LEVELUPSOUND");
						end
					end
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "VARIABLES_LOADED") then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			Zorlen_RegisterButtons("show")
			Zorlen_VariablesLoaded = true;
			Zorlen_CheckVariables()
			if Zorlen_isCurrentClassHunter then
					ZorlenFrame:Show();
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "START_AUTOREPEAT_SPELL") then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			Zorlen_AutoShoot = 1
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "STOP_AUTOREPEAT_SPELL") then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			Zorlen_AutoShoot = nil
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "UPDATE_BONUS_ACTIONBAR") then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			if Zorlen_isCurrentClassWarrior then
					Zorlen_RegisterWarriorStance();
					if Zorlen_castBerserkerRageSwap_SwapWindow then
						Zorlen_castBerserkerRageSwap_SwapStart = nil;
						Zorlen_castBerserkerRageSwap_SwapBack = nil;
						Zorlen_castBerserkerRageSwap_OldStance = nil;
						Zorlen_castBerserkerRageSwap_SwapWindow = nil;
					end
					if Zorlen_castBerserkerRageSwap_SwapStart then
						Zorlen_castBerserkerRageSwap_SwapWindow = 1;
						ZorlenFrame.castBerserkerRageSwap_SwapWindow_timer = 30;
						Zorlen_castBerserkerRageSwap_SwapStart = nil;
						ZorlenFrame:Show();
					end
			end
			if Zorlen_isCurrentClassDruid then
					Zorlen_RegisterDruidForm();
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("PLAYER_ENTERING_WORLD")) then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			Zorlen_RegisterButtons()
			Zorlen_CheckVariables()
			if Zorlen_isCurrentClassHunter then
					ZorlenFrame:Show();
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("ACTIONBAR_HIDEGRID")) then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			if not ZorlenConfig[ZPN][AUTOBUTTONSCANOFF] then
				ZorlenFrame.ACTIONBAR_HIDEGRID_timer = 1;
				ZorlenFrame:Show();
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("PLAYER_TARGET_CHANGED")) then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			if Zorlen_TargetByNameStart and UnitExists("target") then
				Zorlen_TargetByNameEnd = 1;
				Zorlen_TargetByNameStart = nil;
			end
			if Zorlen_isCurrentClassHunter then
					Zorlen_WingClipSpellCastImmune = nil;
					Zorlen_ConcussiveShotSpellCastImmune = nil;
					Zorlen_SerpentStingSpellCastImmune = nil;
					Zorlen_ViperStingSpellCastImmune = nil;
					Zorlen_ScorpidStingSpellCastImmune = nil;
					Zorlen_HuntersMarkSpellCastImmune = nil;
			end
			if Zorlen_isCurrentClassWarlock then
					Zorlen_FireSpellCastImmune = nil;
					Zorlen_DrainLifeSpellCastImmune = nil;
			end
			if Zorlen_isCurrentClassWarrior then
					Zorlen_CastChargeDelay = nil;
					Zorlen_SunderSpellCastStart = nil;
					Zorlen_SunderSpellCastEnd = nil;
					Zorlen_SunderSpellCastFailed = 1;
					Zorlen_SunderSpellCastImmune = nil;
					Zorlen_RendSpellCastImmune = nil;
					Zorlen_DemoSpellCastImmune = nil;
					Zorlen_HamstringSpellCastImmune = nil;
					Zorlen_DisarmSpellCastImmune = nil;
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "CHAT_MSG_COMBAT_SELF_MISSES") then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			if Zorlen_isCurrentClassWarrior then
					if string.find(arg1, " "..LOCALIZATION_ZORLEN_dodges..".") then
						Zorlen_debug("Target dodged your attack. "..LOCALIZATION_ZORLEN_Overpower.." now!");
						Zorlen_TargetDodgedYou_Overpower = 1;
						ZorlenFrame.Dodged_Overpower_timer = 5;
						ZorlenFrame:Show();
					end
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			if Zorlen_isCurrentClassHunter then
					if string.find(arg1, LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_AutoShot.." ") then
						Zorlen_AimedShotRotationWindow = 1;
						ZorlenFrame.AimedShotRotationWindow_timer = 0.5;
						ZorlenFrame:Show();
					end
					if string.find(arg1, LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_WingClip.." ") then
						if string.find(arg1, " "..LOCALIZATION_ZORLEN_immune..".") then
							Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_WingClip.."!");
							Zorlen_WingClipSpellCastImmune = 1;
							ZorlenFrame.WingClipImmune_timer = 7;
							ZorlenFrame:Show();
						end
					end
					if string.find(arg1, LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_ConcussiveShot.." ") then
						if string.find(arg1, " "..LOCALIZATION_ZORLEN_immune..".") then
							Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_ConcussiveShot.."!");
							Zorlen_ConcussiveShotSpellCastImmune = 1;
							ZorlenFrame.ConcussiveShotImmune_timer = 10;
							ZorlenFrame:Show();
						end
					end
					if string.find(arg1, LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_ViperSting.." ") then
						if string.find(arg1, " "..LOCALIZATION_ZORLEN_immune..".") then
							Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_ViperSting.."!");
							Zorlen_ViperStingSpellCastImmune = 1;
							ZorlenFrame.ViperStingImmune_timer = 10;
							ZorlenFrame:Show();
						end
					end
					if string.find(arg1, LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_SerpentSting.." ") then
						if string.find(arg1, " "..LOCALIZATION_ZORLEN_immune..".") then
							Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_SerpentSting.."!");
							Zorlen_SerpentStingSpellCastImmune = 1;
						end
					end
					if string.find(arg1, LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_ScorpidSting.." ") then
						if string.find(arg1, " "..LOCALIZATION_ZORLEN_immune..".") then
							Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_ScorpidSting.."!");
							Zorlen_ScorpidStingSpellCastImmune = 1;
						end
					end
					if string.find(arg1, LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_HuntersMark.." ") then
						if string.find(arg1, " "..LOCALIZATION_ZORLEN_immune..".") then
							Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_HuntersMark.."!");
							Zorlen_HuntersMarkSpellCastImmune = 1;
						end
					end
			end
			if Zorlen_isCurrentClassWarlock then
					if
					string.find(arg1, LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_DrainLife.." ")
					or
					string.find(arg1, LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_SiphonLife.." ")
					then
						if string.find(arg1, " "..LOCALIZATION_ZORLEN_immune..".") then
							Zorlen_debug("Target is immune to life draining damage!");
							Zorlen_DrainLifeSpellCastImmune = 1;
						end
					end
					if
					string.find(arg1, LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_Immolate.." ")
					or
					string.find(arg1, LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_Hellfire.." ")
					or
					string.find(arg1, LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_SoulFire.." ")
					or
					string.find(arg1, LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_SearingPain.." ")
					then
						if string.find(arg1, " "..LOCALIZATION_ZORLEN_immune..".") then
							Zorlen_debug("Target is immune to fire damage!");
							Zorlen_FireSpellCastImmune = 1;
						end
					end
			end
			if Zorlen_isCurrentClassWarrior then
					if string.find(arg1, " "..LOCALIZATION_ZORLEN_dodged.." ") then
						if string.find(arg1, LOCALIZATION_ZORLEN_Your.." ") and not string.find(arg1, " "..LOCALIZATION_ZORLEN_immune..".") then
							Zorlen_debug("Target dodged your spell. "..LOCALIZATION_ZORLEN_Overpower.." now!");
							Zorlen_TargetDodgedYou_Overpower = 1;
							ZorlenFrame.Dodged_Overpower_timer = 5;
							ZorlenFrame:Show();
						end
					end
					if Zorlen_SunderSpellCastStart or Zorlen_SunderSpellCastEnd then
						if string.find(arg1, LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_SunderArmor.." ") then
							if not string.find(arg1, " "..LOCALIZATION_ZORLEN_immune..".") then
								Zorlen_debug(""..LOCALIZATION_ZORLEN_SunderArmor.." missed!");
								Zorlen_SunderSpellCastFailed = 1;
								Zorlen_SunderSpellCastStart = nil;
								Zorlen_SunderSpellCastEnd = nil;
							else
								Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_SunderArmor.."!");
								Zorlen_SunderSpellCastStart = nil;
								Zorlen_SunderSpellCastEnd = nil;
								Zorlen_SunderSpellCastFailed = nil;
								Zorlen_SunderSpellCastImmune = 1;
								ZorlenFrame.SunderImmune_timer = 7;
								ZorlenFrame:Show();
							end
						else
							Zorlen_SunderSpellCastStart = nil;
							Zorlen_SunderSpellCastEnd = nil;
						end
					end
					if string.find(arg1, LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_Rend.." ") then
						if string.find(arg1, " "..LOCALIZATION_ZORLEN_immune..".") then
							Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_Rend.."!");
							Zorlen_RendSpellCastImmune = 1;
							ZorlenFrame.RendImmune_timer = 7;
							ZorlenFrame:Show();
						end
					end
					if string.find(arg1, LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_Hamstring.." ") then
						if string.find(arg1, " "..LOCALIZATION_ZORLEN_immune..".") then
							Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_Hamstring.."!");
							Zorlen_HamstringSpellCastImmune = 1;
							ZorlenFrame.HamstringImmune_timer = 7;
							ZorlenFrame:Show();
						end
					end
					if string.find(arg1, LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_DemoralizingShout.." ") then
						if string.find(arg1, " "..LOCALIZATION_ZORLEN_immune..".") then
							Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_DemoralizingShout.."!");
							Zorlen_DemoSpellCastImmune = 1;
						end
					end
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "CHAT_MSG_SPELL_FAILED_LOCALPLAYER") then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			if Zorlen_isCurrentClassWarrior then
					if string.find(arg1, " "..LOCALIZATION_ZORLEN_Disarm..": ") then
						if string.find(arg1, " "..LOCALIZATION_ZORLEN_no_weapons_equipped..".") then
							Zorlen_debug(""..LOCALIZATION_ZORLEN_Disarm.." failed! Target has "..LOCALIZATION_ZORLEN_no_weapons_equipped..".");
							Zorlen_DisarmSpellCastImmune = 1;
						end
					end
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("SPELLCAST_START")) then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			Zorlen_Casting = 1;
			Zorlen_debug("Casting Start");
			Zorlen_CastingSpellName = arg1;
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("SPELLCAST_CHANNEL_START")) then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			Zorlen_debug("Channeling Start");
			Zorlen_Channeling = 1;
			ZorlenFrame.ChannelingSpellStart_timer = nil;
			ZorlenFrame.Channeling_timer = (arg1/1000);
			ZorlenFrame:Show();
			--Zorlen_ChannelingSpellName = arg2;
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("SPELLCAST_CHANNEL_UPDATE")) then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			if (arg1 > 0) then
				ZorlenFrame.Channeling_timer = (arg1/1000);
				ZorlenFrame:Show();
			end
			if not (arg1 > 0) and Zorlen_Channeling then
				ZorlenFrame.Channeling_timer = nil;
				Zorlen_Channeling = nil;
				Zorlen_ChannelingSpellName = nil;
				Zorlen_ChannelingSpellRank = nil;
				Zorlen_debug("Channeling Stop: from update");
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("SPELLCAST_CHANNEL_STOP")) then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			if Zorlen_Channeling then
				ZorlenFrame.Channeling_timer = nil;
				Zorlen_Channeling = nil;
				Zorlen_ChannelingSpellName = nil;
				Zorlen_ChannelingSpellRank = nil;
				Zorlen_debug("Channeling Stop");
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("SPELLCAST_STOP")) then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			if Zorlen_Casting then
				Zorlen_Casting = nil;
				Zorlen_CastingSpellName = nil;
				Zorlen_debug("Casting Stop");
			end
			if Zorlen_isCurrentClassWarrior then
					if Zorlen_SunderSpellCastStart then
						Zorlen_debug(""..LOCALIZATION_ZORLEN_SunderArmor.." spell cast stopped.");
						Zorlen_SunderSpellCastEnd = 1;
						Zorlen_SunderSpellCastStart = nil;
						Zorlen_SunderTimerHasPassed = nil;
					else
						Zorlen_SunderSpellCastEnd = nil;
					end
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("SPELLCAST_INTERRUPTED")) then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			if Zorlen_Channeling then
				ZorlenFrame.Channeling_timer = nil;
				Zorlen_Channeling = nil;
				Zorlen_ChannelingSpellName = nil;
				Zorlen_ChannelingSpellRank = nil;
				Zorlen_debug("Channeling Stop: from interruption");
			end
			if Zorlen_Casting then
				Zorlen_Casting = nil;
				Zorlen_CastingSpellName = nil;
				Zorlen_debug("Casting Stop: from interruption");
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("SPELLCAST_FAILED")) then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			if Zorlen_isCurrentClassWarrior then
					if Zorlen_castBerserkerRageSwap_SwapStart then
						ZorlenFrame.castBerserkerRageSwap_SwapWindow_timer = 30;
						ZorlenFrame:Show();
					end
					if Zorlen_SunderSpellCastStart then
						Zorlen_debug(""..LOCALIZATION_ZORLEN_SunderArmor.." failed!");
						Zorlen_SunderSpellCastStart = nil;
						Zorlen_SunderSpellCastEnd = nil;
					end
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("UI_ERROR_MESSAGE")) then
			if Zorlen_FullDebug then
				Zorlen_debug("Registered event: "..event);
				if arg1 then
					Zorlen_debug("arg1: "..arg1);
				end
				if arg2 then
					Zorlen_debug("arg2: "..arg2);
				end
				if arg3 then
					Zorlen_debug("arg3: "..arg3);
				end
			end
			---------------------------
			
			if Zorlen_isCurrentClassHunter then
					if string.find(arg1, ""..LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_pet_is_not_dead..".") then
						Zorlen_debug(""..LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_pet_is_not_dead..".");
						Zorlen_PetIsDead = nil;
						ZorlenConfig[ZPN][PETISDEAD] = nil;
					end
					if string.find(arg1, ""..LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_pet_is_dead..".") then
						Zorlen_debug(""..LOCALIZATION_ZORLEN_Your.." "..LOCALIZATION_ZORLEN_pet_is_dead..".");
						Zorlen_PetIsDead = 1;
						ZorlenConfig[ZPN][PETISDEAD] = true;
					end
			end
			
			--------------------------------------------------------------------------------------------------------
	end
end

function Zorlen_CheckVariables()
	if (not Zorlen_VariablesLoaded) then
		return false;
	end
	if (ZorlenInitialized) then
		return true;
	end
	if (ZPN == nil) then
		ZPN = UnitName("player");
		if (ZPN == nil) then
			--Character name not available yet
			return false;
		else 
			ZPN = GetCVar("realmName") .. "." .. ZPN;
		end
	end
	--Build our variable table
	if (not ZorlenConfig) then
		ZorlenConfig = {};
	end
	--Initialize the array for this character
	if (not ZorlenConfig[ZPN]) then
		ZorlenConfig[ZPN] = {};
		ZorlenConfig[ZPN][ZDS] = true;
		ZorlenConfig[ZPN][ASSIST] = nil;
		ZorlenConfig[ZPN][TARGETBYNAME] = nil;
		ZorlenConfig[ZPN][DEBUG] = nil;
		ZorlenConfig[ZPN][FULLDEBUG] = nil;
		ZorlenConfig[ZPN][DEBUGRELOADUI] = nil;
		ZorlenConfig[ZPN][PETISDEAD] = nil;
		ZorlenConfig[ZPN][AUTOBUTTONSCANOFF] = nil;
	end
	if ZorlenConfig[ZPN][DEBUG] then
		Zorlen_DebugFlag = 1;
	end
	if ZorlenConfig[ZPN][FULLDEBUG] then
		Zorlen_FullDebug = 1;
	end
	if ZorlenConfig[ZPN][PETISDEAD] then
		Zorlen_PetIsDead = 1;
	end
	if ZorlenConfig[ZPN][DEBUGRELOADUI] then
		Zorlen_DebugFlag = 1;
		ZorlenConfig[ZPN][DEBUGRELOADUI] = nil;
	end
	ZorlenInitialized = true;
	return true;
end



--Will dump the value of msg to the default chat window
function Zorlen_debug(msg)
	--SendChatMessage(msg, "WHISPER", "Common", "Zorlen")
	if msg ~= nil and Zorlen_DebugFlag then
		--DEFAULT_CHAT_FRAME:AddMessage(msg, 1, 1, 0)
		DEFAULT_CHAT_FRAME:AddMessage(msg)
	end
end




function Zorlen_changeAssist(name)
	if name then
		ZorlenConfig[ZPN][ASSIST] = name;
		DEFAULT_CHAT_FRAME:AddMessage("You have set "..ZorlenConfig[ZPN][ASSIST].." as your saved assist");
	else if UnitIsFriend("player", "target") then
		ZorlenConfig[ZPN][ASSIST] = UnitName("target");
		DEFAULT_CHAT_FRAME:AddMessage("You have set "..ZorlenConfig[ZPN][ASSIST].." as your saved assist");
	else
		Zorlen_debug("Your target is not a friend and can not be assisted");
		if ZorlenConfig[ZPN][ASSIST] then
			Zorlen_debug("Your saved assist is still "..ZorlenConfig[ZPN][ASSIST]);
		end
	end
	end
--[[
	local index = GetMacroIndexByName("Assist")
	DEFAULT_CHAT_FRAME:AddMessage("Index is " .. index)
	if (index > 0) then
		DEFAULT_CHAT_FRAME:AddMessage("Editing an existing macro " .. index)
		EditMacro(index, "Assist", nil, "/assist " .. i, 1)
	else
		local count = GetNumMacros()
		if (count >= 18) then
			DEFAULT_CHAT_FRAME:AddMessage(macroErrorMsg)
		else
			DEFAULT_CHAT_FRAME:AddMessage("Creating a new macro")
			CreateMacro("Assist", 23, "/assist " .. i, 1)
		end
	end
	DEFAULT_CHAT_FRAME:AddMessage("Now assisting " .. i);
	SaveMacros()
]]
end

function Zorlen_clearAssist()
	if ZorlenConfig[ZPN][ASSIST] then
		DEFAULT_CHAT_FRAME:AddMessage("You have removed "..ZorlenConfig[ZPN][ASSIST].." as your saved assist");
		ZorlenConfig[ZPN][ASSIST] = nil;
	else
		DEFAULT_CHAT_FRAME:AddMessage("Your saved assist is cleared");
	end
end

function Zorlen_assist(name)
	local i = ZorlenConfig[ZPN][ASSIST];
	if name then
		i = name;
	end
	if (not i) then
		DEFAULT_CHAT_FRAME:AddMessage("An assist has not been saved yet");
		Zorlen_changeAssist();
		return
	end
	AssistByName(i);
	Zorlen_debug("Assisting "..i);
end



function Zorlen_changeTargetByName(name)
	if name then
		ZorlenConfig[ZPN][TARGETBYNAME] = name;
		DEFAULT_CHAT_FRAME:AddMessage("You have set "..ZorlenConfig[ZPN][TARGETBYNAME].." as your saved target");
	else if UnitExists("target") then
		ZorlenConfig[ZPN][TARGETBYNAME] = UnitName("target");
		DEFAULT_CHAT_FRAME:AddMessage("You have set "..ZorlenConfig[ZPN][TARGETBYNAME].." as your saved target");
	end
	end
end

function Zorlen_clearTargetByName()
	if ZorlenConfig[ZPN][TARGETBYNAME] then
		DEFAULT_CHAT_FRAME:AddMessage("You have removed "..ZorlenConfig[ZPN][TARGETBYNAME].." as your saved target");
		ZorlenConfig[ZPN][TARGETBYNAME] = nil;
	else
		DEFAULT_CHAT_FRAME:AddMessage("Your your saved target is cleared");
	end
end

function Zorlen_TargetByName(name)
	local i = ZorlenConfig[ZPN][TARGETBYNAME];
	if name then
		i = name;
	end
	if (not i) then
		DEFAULT_CHAT_FRAME:AddMessage("A target has not been saved yet")
		Zorlen_changeTargetByName()
		return
	end
	if not (i == UnitName("target")) then
		if UnitExists("target") then
			Zorlen_TargetByNameFirstTarget = 1;
			Zorlen_TargetByNameStart = 1;
			ZorlenFrame.TargetByName_timer = 1;
			ZorlenFrame:Show();
			Zorlen_TargetByNameName = i;
		end
		TargetByName(i)
		if i == UnitName("target") then
			Zorlen_debug("Targeting "..i)
		else if UnitExists("target") and not Zorlen_TargetByNameFirstTarget then
			Zorlen_debug("Target "..i.." not found!")
			ClearTarget()
		else
			Zorlen_debug("Target "..i.." not found!")
		end
		end
		Zorlen_TargetByNameFirstTarget = nil;
	end
end





--Example: Zorlen_isClass("Paladin")
--The example above will return true if your target is a paladin.
--This function has been made so that english class names must be used with this function even if you are not using an english game client.
function Zorlen_isClass(class, unit)
	if (Zorlen_UnitClass(unit) == class) then
		return true
	end
	return false
end

--This returns the english class name: "Priest", "Rogue", "Paladin", "Warlock", "Warrior", "Hunter", "Mage",  "Shaman", "Druid", or nil.
function Zorlen_UnitClass(unit)
	local u = "target"
	if unit then
		u = unit
	end
	local _, class = UnitClass(u)
	if (class == "PRIEST") then
		return "Priest"
	else if (class == "ROGUE") then
		return "Rogue"
	else if (class == "PALADIN") then
		return "Paladin"
	else if (class == "WARLOCK") then
		return "Warlock"
	else if (class == "WARRIOR") then
		return "Warrior"
	else if (class == "HUNTER") then
		return "Hunter"
	else if (class == "MAGE") then
		return "Mage"
	else if (class == "SHAMAN") then
		return "Shaman"
	else if (class == "DRUID") then
		return "Druid"
	end
	end
	end
	end
	end
	end
	end
	end
	end
	return nil
end



--Example: Zorlen_isRace("Gnome")
--The example above will return true if your target is a gnome.
--This function has been made so that english race names must be used with this function even if you are not using an english game client.
function Zorlen_isRace(race, unit)
	if (Zorlen_UnitRace(unit) == race) then
		return true
	end
	return false
end

--This returns the english race name: "Human", "Dwarf", "Gnome", "Night Elf", "Orc", "Undead", "Tauren",  "Troll", or nil.
function Zorlen_UnitRace(unit)
	local u = "target"
	if unit then
		u = unit
	end
	local _, race = UnitRace(u)
	if (race == "Scourge") then
		return "Undead"
	end
	return race
end


-- The spell names for channeling do not work out side of the zorlen casting functions since blizzard has not fixed the channeling spell name argument yet
function Zorlen_isChanneling(SpellName)
	if SpellName then
		if (Zorlen_Channeling) and (SpellName == Zorlen_ChannelingSpellName) then
			return true
		end
	else if (Zorlen_Channeling) then
		return true
	end
	end
	return false
end


function Zorlen_isCasting(SpellName)
	if SpellName then
		if (Zorlen_Casting) and (SpellName == Zorlen_CastingSpellName) then
			return true
		end
	else if (Zorlen_Casting) then
		return true
	end
	end
	return false
end

-- The spell names for channeling do not work out side of the zorlen casting functions since blizzard has not fixed the channeling spell name argument yet
function Zorlen_isCastingOrChanneling(SpellName)
	if SpellName then
		if ((Zorlen_Casting) and (SpellName == Zorlen_CastingSpellName)) or ((Zorlen_Channeling) and (SpellName == Zorlen_ChannelingSpellName)) then
			return true
		end
	else if (Zorlen_Casting) or (Zorlen_Channeling) then
		return true
	end
	end
	return false
end

--Since the PlayerFrame combat variable can be wrong, The same information
--can be accessed here.	Returns true if you are in combat
function Zorlen_inCombat()
	if (Zorlen_Combat) then
		return true
	end
	return false
end

-- Returns true if you are not in combat, and may use abilitys that can only be used out of combat
function Zorlen_notInCombat()
	if (Zorlen_Combat) then
		return false
	end
	return true
end

function Zorlen_inMeleeCombat()
		return Zorlen_Melee
end

function usesMana()
	if (UnitPowerType("target") == 0) then
		return true
	end
	return false
end

function hasMana() 
	if (UnitPowerType("target") == 0 and UnitMana("target") > 0) then
		return true;
	end
	return false;
end

--Convenience function that will tell if the target is attackable
function Zorlen_canAttack(unit)
	local u = "target"
	if unit then
		u = unit
	end
	return UnitCanAttack("player", u)
end










--Internal function that returns the SpellID of the highest ranking spell for SpellName
--Written by Andrew Young(andrew@inmyroom.org)
function Zorlen_GetSpellID(SpellName)
	local SpellCount = 0
	local ReturnName
	while (SpellName ~= ReturnName) do
		SpellCount = SpellCount + 1
		ReturnName = GetSpellName(SpellCount, BOOKTYPE_SPELL)
	end
	while (SpellName == ReturnName) do
		SpellID = SpellCount
		SpellCount = SpellCount + 1
		ReturnName = GetSpellName(SpellCount, BOOKTYPE_SPELL)
		if (SpellName ~= ReturnName) then
			break
		end
	end
	return SpellID
end

--Written by Andrew Young(andrew@inmyroom.org)
function Zorlen_checkCoolThenCast(SpellID)
	local start, duration, enable = GetSpellCooldown(SpellID, 0)
	if (duration == 0) then
		CastSpell(SpellID, 0)
		return true
	else 
		Zorlen_debug("NOT Casting spell")
		return false
	end
end

--Written by Andrew Young(andrew@inmyroom.org)
-- Checks for spell cooldown. If cooldown has passed, a value of true is returned. If the spell is still on cool down a value of false is returned.
function Zorlen_checkCooldown(SpellID)
	if (GetSpellCooldown(SpellID, 0) == 0) then
		return true
	else
		return false
	end
end

--Written by Andrew Young(andrew@inmyroom.org)
-- Checks for spell cooldown. If cooldown has passed, a value of true is returned. If the spell is still on cool down a value of false is returned.
function Zorlen_checkCooldownByName(SpellName)
	if SpellName then
		if Zorlen_IsSpellKnown(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			if (GetSpellCooldown(SpellID, 0) == 0) then
				return true
			end
		end
	end
	return false
end

--function to check if a certain spell and rank are known
--written by Bear
-- Example: Zorlen_IsSpellRankKnown("Spell Name", "Rank 1")
-- Example above will return true if the named spell and rank of that spell are located in your spell book.
function Zorlen_IsSpellRankKnown(spell, rank)
	if spell and rank then
		local i = 1;
		local spellName, spellRank;
		repeat
			spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
			if (spellName == spell and rank == spellRank) then
				return true
			end
			i = i + 1
		until (not spellName)
	end
	return false
end

-- Returns the the spell rank.
-- Example: Zorlen_GetTalentRank("Talent Name") == "Rank 1"
-- Example above will return true if the named spell has only one rank known.
function Zorlen_GetSpellRank(SpellName)
	if SpellName then
		local rslt = 0
		local i = 1;
		local spell, rank;
		repeat
			spell, rank = GetSpellName(i, BOOKTYPE_SPELL)
			if (spell == SpellName) then
				rslt = rank
			end
			i = i + 1
		until (not spell)
		return rslt
	end
end

--function to check if a certain spell is known
-- Example: Zorlen_IsSpellKnown("Spell Name")
-- Example above will return true if any rank of the named spell is located in your spell book.
function Zorlen_IsSpellKnown(SpellName)
	if SpellName then
		local i = 1;
		local spell, rank;
		repeat
			spell, rank = GetSpellName(i, BOOKTYPE_SPELL)
			if (spell == SpellName) then
				return true
			end
			i = i + 1
		until (not spell)
	end
	return false
end

function Zorlen_HasTalent(value)
	local rslt = false
	NUM_TABS = GetNumTalentTabs()
	for iTab=1, NUM_TABS, 1 do
		NUM_TALENTS = GetNumTalents(iTab)
		for iTal=1, NUM_TALENTS, 1 do
			nameTalent , iconPath , iconX , iconY , currentRank , maxRank = GetTalentInfo( iTab, iTal );
			if nameTalent == value then
				rslt = true 
			end
		end
	end
	return rslt
end

-- Returns the the value of how many talent points that have been spent on a talent.
-- Example: Zorlen_GetTalentRank("Talent Name") == 1
-- Example above will return true if the named talent has only one point spent in it.
function Zorlen_GetTalentRank(value)
	local rslt = 0
	NUM_TABS = GetNumTalentTabs()
	for iTab=1, NUM_TABS, 1 do
		NUM_TALENTS = GetNumTalents(iTab)
		for iTal=1, NUM_TALENTS, 1 do
			nameTalent , iconPath , iconX , iconY , currentRank , maxRank = GetTalentInfo( iTab, iTal );
			if nameTalent == value then
				rslt = currentRank 
			end
		end
	end
	return rslt
end

function Zorlen_GetSpellTextureByName(SpellName)
	if SpellName then
		if Zorlen_IsSpellKnown(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			local texture = GetSpellTexture(SpellID, 0)
			if texture then
				return texture
			end
		end
	end
	return "texture was not found"
end

function Zorlen_ShowSpellTextureByName(SpellName)
	if SpellName then
		return DEFAULT_CHAT_FRAME:AddMessage(Zorlen_GetSpellTextureByName(SpellName));
	end
end










--Test function to display all debuffs on your target or a specified unit.
function Zorlen_ShowAllDebuffs(unit)
	local u = "target"
	if unit then
		u = unit
	else if not UnitExists("target") then
		u = "player"
	end
	end
	if UnitName(u) then
		if not UnitDebuff(u, 1) then
			DEFAULT_CHAT_FRAME:AddMessage("No debuffs found for "..UnitName(u))
			return
		end
		DEFAULT_CHAT_FRAME:AddMessage("All debuffs for "..UnitName(u)..":")
		local counter = 1
		while (UnitDebuff(u, counter)) do
			DEFAULT_CHAT_FRAME:AddMessage("Debuff Slot#"..counter.." Texture Name:   "..UnitDebuff(u, counter))
			counter = counter + 1
		end
	end
end


--Test function to display all buffs on yourself or a specified unit.
function Zorlen_ShowAllBuffs(unit)
	local u = "target"
	if unit then
		u = unit
	else if not UnitExists("target") then
		u = "player"
	end
	end
	if UnitName(u) then
		if not UnitBuff(u, 1) then
			DEFAULT_CHAT_FRAME:AddMessage("No buffs found for "..UnitName(u))
			return
		end
		DEFAULT_CHAT_FRAME:AddMessage("All buffs for "..UnitName(u)..":")
		local counter = 1
		while (UnitBuff(u, counter)) do
			DEFAULT_CHAT_FRAME:AddMessage("Buff Slot#"..counter.." Texture Name:   "..UnitBuff(u, counter))
			counter = counter + 1
		end
	end
end

--returns true if there are 16 debuffs on the target
function Zorlen_AllDebuffSlotsUsed(unit)
	local u = "target"
	if unit then
		u = unit
	end
	if UnitDebuff(u, 16) then
		return true
	end
	return false
end



--Loops through all debuffs looking for a match
function Zorlen_checkDebuff(debuff, unit, dispelable)
	local u = "target"
	local d = nil
	local counter = 1
	if unit then
		u = unit
	end
	if dispelable then
		if (dispelable == 1) or (dispelable == 0) then
			d = dispelable
		else
			d = 1
		end
	end
	while (UnitDebuff(u, counter)) do
		if UnitDebuff(u, counter, d) then
			if debuff then
				if (string.find(UnitDebuff(u, counter), debuff)) then
					return true
				end
			else
				return true
			end
		end
		counter = counter + 1
	end
	return false
end

--Loops through all buffs looking for a match
function Zorlen_checkBuff(buff, unit, castable)
	local u = "player"
	local c = nil
	local counter = 1
	if unit then
		u = unit
	end
	if castable then
		if (castable == 1) or (castable == 0) then
			c = castable
		else
			c = 1
		end
	end
	while (UnitBuff(u, counter)) do
		if UnitBuff(u, counter, c) then
			if buff then
				if (string.find(UnitBuff(u, counter), buff)) then
					return true
				end
			else
				return true
			end
		end
		counter = counter + 1
	end
	return false
end



--Written by Andrew Young(andrew@inmyroom.org)
-- Checks if a debuff is active on the target by comparing the texture of the specified Spell. A value of true is returned if debuff is active
function Zorlen_checkDebuffBySpellName(SpellName, unit, dispelable)
	if SpellName then
		if Zorlen_IsSpellKnown(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			local debuff = GetSpellTexture(SpellID, 0)
			return Zorlen_checkDebuff(debuff, unit, dispelable)
		end
	end
	return false
end



--Written by Andrew Young(andrew@inmyroom.org)
-- Checks if a buff is active on the player by comparing the texture of the specified Spell. A value of true is returned if buff is active.
function Zorlen_checkBuffBySpellName(SpellName, unit, castable)
	if SpellName then
		if Zorlen_IsSpellKnown(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			local buff = GetSpellTexture(SpellID, 0)
			return Zorlen_checkBuff(buff, unit, castable)
		end
	end
	return false
end



function Zorlen_checkSelfDebuffBySpellName(SpellName, dispelable)
	return Zorlen_checkDebuffBySpellName(SpellName, "player", dispelable)
end

function Zorlen_checkTargetBuffBySpellName(SpellName, castable)
	return Zorlen_checkBuffBySpellName(SpellName, "target", castable)
end



--Written by Andrew Young(andrew@inmyroom.org)
-- Checks if a debuff is active on the target by comparing the texture of the specified SpellID. A value of true is returned if debuff is active
function Zorlen_checkDebuffBySpellID(SpellID, unit, dispelable)
	if SpellID then
		local debuff = GetSpellTexture(SpellID, 0)
		return Zorlen_checkDebuff(debuff, unit, dispelable)
	end
	return false
end



--Written by Andrew Young(andrew@inmyroom.org)
-- Checks if a buff is active on the player by comparing the texture of the specified SpellID. A value of true is returned if buff is active.
function Zorlen_checkBuffBySpellID(SpellID, unit, castable)
	if SpellID then
		local buff = GetSpellTexture(SpellID, 0)
		return Zorlen_checkBuff(buff, unit, castable)
	end
	return false
end





-- Returns the amount of times a debuff is stacked on the target, and returns 0 if the debuff is not on the target.
function Zorlen_GetDebuffStack(debuff, unit)
	local u = "target"
	local counter = 1
	if unit then
		u = unit
	end
	while (UnitDebuff(u, counter)) do
		local texture, applications = UnitDebuff(u, counter)
		if (string.find(texture, debuff)) then
			return applications
		end
		counter = counter + 1
	end
	return 0
end

function Zorlen_GetDebuffStackBySpellName(SpellName, unit)
	if SpellName then
		if Zorlen_IsSpellKnown(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			local debuff = GetSpellTexture(SpellID, 0)
			return Zorlen_GetDebuffStack(debuff, unit)
		end
	end
	return 0
end

function Zorlen_GetDebuffStackBySpellID(SpellID, unit)
	if SpellID then
		local debuff = GetSpellTexture(SpellID, 0)
		return Zorlen_GetDebuffStack(debuff, unit)
	end
	return 0
end



--Zorlen_checkDebuff("INV_Spear_02", i) --Sleep: Wyvern Sting not included since it shares the same texture with a damage debuff that is applied after the sleep breaks
function Zorlen_isBreakOnDamageCC(unit, dispelable)
	if
	Zorlen_checkDebuff("Spell_Nature_Polymorph", unit, dispelable) --Polymorph
	or
	Zorlen_checkDebuff("Spell_Nature_Sleep", unit, dispelable) --Sleep
	or
	Zorlen_checkDebuff("Spell_Nature_Slow", unit, dispelable) --Shackle Undead
	or
	Zorlen_checkDebuff("Ability_Sap", unit, dispelable) --Sap
	or
	Zorlen_checkDebuff("Spell_Shadow_MindSteal", unit, dispelable) --Succubus Seduction
	or
	Zorlen_checkDebuff("Ability_GolemStormBolt", unit, dispelable) --Scatter Shot
	or
	Zorlen_checkDebuff("Spell_Frost_ChainsOfIce", unit, dispelable) --Freezing Trap
	then
		return true
	end
	return false
end

--all forms of fear and movement impairing affects are not included since they do not prevent the target from being damaged
--all forms of unit control are not included since they are not considered enemys while the affect is on them
function Zorlen_isNoDamageCC(unit, dispelable)
	if
	Zorlen_isBreakOnDamageCC(unit, dispelable)
	or
	Zorlen_checkDebuff("Spell_Shadow_Cripple", unit, dispelable) --Banish
	then
		return true
	end
	return false
end

--movement impairing affects are not included since the target could still attack
function Zorlen_isCrowedControlled(unit, dispelable)
	if
	Zorlen_isNoDamageCC(unit, dispelable)
	or
	Zorlen_checkDebuff("Spell_Shadow_Possession", unit, dispelable) --Fear
	or
	Zorlen_checkDebuff("Spell_Shadow_DeathScream", unit, dispelable) --Fear: Howl of Terror
	or
	Zorlen_checkDebuff("Spell_Shadow_PsychicScream", unit, dispelable) --Fear: Psychic Scream
	then
		return true
	end
	return false
end

-- Will return true if your target is not a friend and is still alive.
-- This will not be able to return the correct results if the target is an enemy hunter that has feigned death and is not targeting anything.
function Zorlen_TargetIsEnemy(unit)
	local u = "target"
	if unit then
		u = unit
	end
	if UnitCanAttack("player", u) and not UnitIsCivilian(u) and (UnitHealth(u) > 0 or UnitExists(u.."target") or UnitAffectingCombat(u) or (UnitIsPlayer(u) and Zorlen_isClass("Hunter", u))) then
		return true
	end
	return false
end

-- Will try to determine if the targeted enemy is aggroed or doing anything that would make attacking the target acceptable.
function Zorlen_TargetIsActiveEnemy(unit)
	local u = "target"
	if unit then
		u = unit
	end
	if Zorlen_TargetIsEnemy(u) and (UnitAffectingCombat(u) or UnitExists(u.."target") or UnitHealth(u) < UnitHealthMax(u) or UnitIsPlayer(u) or (UnitIsEnemy("player", u) and CheckInteractDistance(u, 1))) and not Zorlen_isNoDamageCC(u) then
		return true
	end
	return false
end

function Zorlen_TargetIsEnemyPlayer(unit)
	local u = "target"
	if unit then
		u = unit
	end
	if Zorlen_TargetIsEnemy(u) and UnitIsPlayer(u) then
		return true
	end
	return false
end

function Zorlen_TargetIsEnemyMob(unit)
	local u = "target"
	if unit then
		u = unit
	end
	if Zorlen_TargetIsEnemy(u) and not UnitIsPlayer(u) and not UnitIsPet(u) then
		return true
	end
	return false
end

-- Will try to determine if the targeted enemy is a mob and aggroed or doing anything that would make attacking the target acceptable.
function Zorlen_TargetIsActiveEnemyMob(unit)
	local u = "target"
	if unit then
		u = unit
	end
	if Zorlen_TargetIsEnemyMob(u) and (UnitAffectingCombat(u) or UnitExists(u.."target") or UnitHealth(u) < UnitHealthMax(u) or UnitDebuff(u, 1) or (UnitIsEnemy("player", u) and CheckInteractDistance(u, 1))) and not Zorlen_isNoDamageCC(u) then
		return true
	end
	return false
end

-- Returns true if the target is an enemy with 20% health or lower.
function Zorlen_TargetIsDieingEnemy(unit)
	local u = "target"
	if unit then
		u = unit
	end
	if Zorlen_TargetIsEnemy(u) and UnitHealth(u) / UnitHealthMax(u) <= 0.2 then
		return true
	end
	return false
end

-- Returns true if the target is an enemy with 20% health or lower that has no target.
function Zorlen_TargetIsDieingEnemyWithNoTarget(unit)
	local u = "target"
	if unit then
		u = unit
	end
	if Zorlen_TargetIsDieingEnemy(u) and not UnitExists(u.."target") then
		return true
	end
	return false
end

-- Will return true if the targeted enemy is targeting you.
function Zorlen_TargetIsEnemyTargetingYou(unit)
	local u = "target"
	if unit then
		u = unit
	end
	if Zorlen_TargetIsEnemy(u) and UnitIsUnit(u.."target", "player") then
		return true
	end
	return false
end

-- Will return true if the targeted enemy is targeting a friend but not you.
function Zorlen_TargetIsEnemyTargetingFriendButNotYou(unit)
	local u = "target"
	if unit then
		u = unit
	end
	if Zorlen_TargetIsEnemy(u) and not UnitIsUnit(u.."target", "player") and UnitIsFriend("player", u.."target") then
		return true
	end
	return false
end

-- Will return true if the enemy target is targeting himself or another enemy.
-- Mobs will some times target themselves or another enemy when they are casting a beneficial spell.
function Zorlen_TargetIsEnemyTargetingEnemy(unit)
	local u = "target"
	if unit then
		u = unit
	end
	if Zorlen_TargetIsEnemy(u) and UnitExists(u.."target") and not UnitIsFriend("player", u.."target") then
		return true
	end
	return false
end

-- Will return true if your target is a friend that is targeting an enemy.
-- This will not be able to return the correct results if the target's target is an enemy hunter that has feigned death and is not targeting anything.
function Zorlen_TargetIsFriendTargetingEnemy(unit)
	local u = "target"
	if unit then
		u = unit
	end
	if UnitIsFriend("player", u) and Zorlen_TargetIsEnemy(u.."target") then
		return true
	end
	return false
end

-- Will return true if your target is a friend that is targeting an active enemy.
-- See description for Zorlen_TargetIsActiveEnemy() for description of "active enemy".
function Zorlen_TargetIsFriendTargetingActiveEnemy(unit)
	local u = "target"
	if unit then
		u = unit
	end
	if UnitIsFriend("player", u) and Zorlen_TargetIsActiveEnemy(u.."target") then
		return true
	end
	return false
end







-- Will not do anything if you are already targeting an enemy.
function Zorlen_TargetEnemy()
	if not Zorlen_TargetIsEnemy() then
		Zorlen_TargetNearestEnemy()
	end
end

--I only added this for those who do not want the targeting to attempt more than one target cycle when targeting for them.
function Zorlen_TargetFirstEnemy()
	if not Zorlen_TargetIsEnemy() then
		Zorlen_TargetNearestEnemy("first")
	end
end

--Will clear target if you are targeting an enemy that is not active.
function Zorlen_TargetActiveEnemyOnly()
	if not Zorlen_TargetIsActiveEnemy() then
		Zorlen_TargetNearestEnemy("only")
	end
end

--Will clear target if you are targeting an enemy that is not a player.
function Zorlen_TargetEnemyPlayerOnly()
	if not Zorlen_TargetIsEnemyPlayer() then
		Zorlen_TargetNearestEnemy("playeronly")
	end
end

--Will clear target if you are targeting an enemy that is not active or a player.
function Zorlen_TargetEnemyPlayerFirstOrActiveEnemyOnly()
	if not Zorlen_TargetIsActiveEnemy() then
		Zorlen_TargetNearestEnemy("playeroractiveonly")
	end
end

-- Will not do anything if you are already targeting an enemy player.
function Zorlen_TargetEnemyPlayerFirst()
	if not Zorlen_TargetIsEnemy() then
		Zorlen_TargetNearestEnemy("player")
	end
end



--Will clear target if you are targeting an enemy that is not active.
function Zorlen_TargetActiveEnemyMobOnly()
	if not Zorlen_TargetIsActiveEnemyMob() then
		Zorlen_TargetNearestEnemy("activemobonly")
	end
end

--Will clear target if you are targeting an enemy that is not a player.
function Zorlen_TargetEnemyMobOnly()
	if not Zorlen_TargetIsEnemyMob() then
		Zorlen_TargetNearestEnemy("mobonly")
	end
end




--Will always clear target to find the best target
function Zorlen_TargetNearestEnemy(mode)
	local number = 9;
	local healthscan = true;
	local health = 0;
	local lowesthealth = 0;
	local name = UnitName("target");
	local counter = 1;
	local wasenemy = nil;
	local wasplayerenemy = nil;
	if Zorlen_TargetIsEnemy() then
		wasenemy = 1;
		if not Zorlen_TargetIsEnemyMob() then
			wasplayerenemy = 1;
			if (mode == "mobonly") or (mode == "activemobonly") then
				ClearTarget();
				Zorlen_debug("Clearing Target!");
			end
		end
		ClearTarget();
		Zorlen_debug("Clearing Target!");
	else if UnitCanAttack("player", "target") then
		ClearTarget();
		Zorlen_debug("Clearing Target!");
	end
	end
	if (mode == "first") then
		if not Zorlen_TargetIsEnemy() then
			TargetNearestEnemy();
		end
		return
	else if not Zorlen_TargetIsActiveEnemy() or (((mode == "playeronly") or (mode == "player")) and not Zorlen_TargetIsEnemyPlayer()) then
		if ((mode == "playeronly") or (mode == "player") or (mode == "playeroractiveonly")) then
			if (UnitCanAttack("player", "target")) or (wasenemy and UnitExists("target")) then
				ClearTarget();
				Zorlen_debug("Clearing Target!");
			end
			while (counter <= number) do
				TargetNearestEnemy();
				name = UnitName("target")
				if Zorlen_TargetIsEnemyPlayer() and (not (UnitIsUnit("pet", "targettarget") and not UnitIsUnit("pettarget", "target")) or not UnitExists("pettarget")) then
					Zorlen_debug("Player found for player targeting attempt #"..counter..": "..name);
					return
				else if Zorlen_DebugFlag and name and Zorlen_TargetIsEnemy() then
					Zorlen_debug("Player targeting attempt #"..counter..": "..name);
				end
				end
				counter = counter + 1
			end
			Zorlen_debug("Player target not found!");
		end
		if not (mode == "playeronly") then
			if ((UnitCanAttack("player", "target")) or (wasenemy and UnitExists("target"))) then
				ClearTarget();
				Zorlen_debug("Clearing Target!");
			end
			counter = 1;
			while (counter <= number) do
				TargetNearestEnemy();
				name = UnitName("target")
				if Zorlen_TargetIsActiveEnemy() and not (((mode == "mobonly") or (mode == "activemobonly")) and not Zorlen_TargetIsEnemyMob()) and (not (UnitIsUnit("pet", "targettarget") and not UnitIsUnit("pettarget", "target")) or not UnitExists("pettarget")) then
					health = UnitHealth("target") / UnitHealthMax("target");
					if healthscan and ((health < lowesthealth) or (lowesthealth == 0)) then
						lowesthealth = health;
					end
					if Zorlen_DebugFlag and healthscan then
						Zorlen_debug("Active target health scan on attempt #"..counter..": "..name);
					end
					if not healthscan then
						if health <= lowesthealth then
							if Zorlen_DebugFlag then
								if UnitIsPlayer("target") then
									Zorlen_debug("Lowest health player found for targeting attempt #"..counter..": "..name);
								else
									Zorlen_debug("Lowest health target found for targeting attempt #"..counter..": "..name);
								end
							end
							return
						else
							Zorlen_debug("Finding saved lowest health target attempt #"..counter..": "..name);
						end
					end
				else if Zorlen_DebugFlag and name and Zorlen_TargetIsEnemy() then
					Zorlen_debug("Active targeting attempt #"..counter..": "..name);
				end
				end
				if counter == number and healthscan and lowesthealth > 0 then
					counter = 0;
					healthscan = nil;
					ClearTarget();
					Zorlen_debug("Clearing Target!");
				else if counter == number and not healthscan and lowesthealth > 0 then
					counter = 0;
					healthscan = true;
					lowesthealth = 0;
					ClearTarget();
					Zorlen_debug("Clearing Target!");
				end
				end
				counter = counter + 1
			end
			if Zorlen_TargetIsFriendTargetingActiveEnemy() then
				Zorlen_debug("Assisting "..name.."!");
				AssistUnit("target");
				return
			else if UnitExists("pettarget") and Zorlen_TargetIsActiveEnemy("pettarget") then
				if not UnitIsUnit("target", "pettarget") and not Zorlen_TargetIsActiveEnemy() then
					Zorlen_debug("Assisting your pet "..UnitName("pet").."!");
					AssistUnit("pet");
				end
				return
			end
			end
			if (mode == "mobonly") or (mode == "activemobonly") then
				Zorlen_debug("Active mob not found!");
			else
				Zorlen_debug("Active target not found!");
			end
		end
		if (mode == "only") or (mode == "playeronly") or (mode == "playeroractiveonly") or (mode == "activemobonly") then
			if (UnitCanAttack("player", "target")) then
				ClearTarget();
				Zorlen_debug("Clearing Target!");
			end
			return
		end
		if ((UnitCanAttack("player", "target")) or (wasenemy and not ((mode == "mobonly") and wasplayerenemy))) or ((mode == "mobonly") and not Zorlen_TargetIsEnemyMob() and not UnitIsFriend("player", "target")) then
			if UnitExists("target") then
				ClearTarget();
				Zorlen_debug("Clearing Target!");
			end
			counter = 1;
			while (counter <= number) do
				TargetNearestEnemy();
				name = UnitName("target")
				if Zorlen_TargetIsEnemy() and not ((mode == "mobonly") and not Zorlen_TargetIsEnemyMob()) then
					if Zorlen_DebugFlag and (mode == "mobonly") and not (counter == 1) then
						Zorlen_debug("Target found for targeting attempt #"..counter..": "..name);
					else if Zorlen_DebugFlag then
						Zorlen_debug("Targeting nearest enemy: "..name);
					end
					end
					return
				else if Zorlen_DebugFlag and name and Zorlen_TargetIsEnemy() then
					Zorlen_debug("Targeting attempt #"..counter..": "..name);
				end
				end
				counter = counter + 1
			end
		end
		if wasenemy and not ((mode == "mobonly") and wasplayerenemy) then
			TargetLastTarget()
		end
		if ((not Zorlen_TargetIsEnemy()) or ((mode == "mobonly") and not Zorlen_TargetIsEnemyMob())) then
			if (mode == "mobonly") then
				Zorlen_debug("Enemy mob not found!");
			else
				Zorlen_debug("Enemy target not found!");
			end
			if UnitCanAttack("player", "target") then
				ClearTarget();
				Zorlen_debug("Clearing Target!");
			end
			return
		end
	end
	end
end

--Will always clear target to find the target with the highest health   -   This may be useful for core hound packs for those who do not use aoe damage
function Zorlen_TargetNearestActiveEnemyWithHighestHealth()
	local number = 9;
	local healthscan = true;
	local health = 0;
	local highesthealth = 0;
	local name = nil;
	local counter = 1;
	if UnitCanAttack("player", "target") then
		ClearTarget();
		Zorlen_debug("Clearing Target!");
	end
	while (counter <= number) do
		TargetNearestEnemy();
		name = UnitName("target")
		if Zorlen_TargetIsActiveEnemy() then
			health = UnitHealth("target") / UnitHealthMax("target");
			if healthscan and ((health > highesthealth) or (highesthealth == 0)) then
				highesthealth = health;
			end
			if Zorlen_DebugFlag and healthscan then
				Zorlen_debug("Active target health scan on attempt #"..counter..": "..name);
			end
			if not healthscan then
				if health >= highesthealth then
					if Zorlen_DebugFlag then
						if UnitIsPlayer("target") then
							Zorlen_debug("Highest health player found for targeting attempt #"..counter..": "..name);
						else
							Zorlen_debug("Highest health target found for targeting attempt #"..counter..": "..name);
						end
					end
					return
				else
					Zorlen_debug("Finding saved highest health target attempt #"..counter..": "..name);
				end
			end
		else if Zorlen_DebugFlag and name and Zorlen_TargetIsEnemy() then
			Zorlen_debug("Active targeting attempt #"..counter..": "..name);
		end
		end
		if counter == number and healthscan and highesthealth > 0 then
			counter = 0;
			healthscan = nil;
			ClearTarget();
			Zorlen_debug("Clearing Target!");
		else if counter == number and not healthscan and highesthealth > 0 then
			counter = 0;
			healthscan = true;
			highesthealth = 0;
			ClearTarget();
			Zorlen_debug("Clearing Target!");
		end
		end
		counter = counter + 1
	end
	Zorlen_debug("Active target not found!");
	if (UnitCanAttack("player", "target")) then
		ClearTarget();
		Zorlen_debug("Clearing Target!");
	end
end

--This is included for those who only want to target an enemy that a hunter has marked.
function Zorlen_TargetMarkedEnemyOnly()
	local number = 9;
	local name = UnitName("target");
	local counter = 1;
	if not Zorlen_TargetIsEnemy() or not Zorlen_checkDebuff("Sniper") then
		if Zorlen_TargetIsFriendTargetingEnemy() and Zorlen_checkDebuff("Sniper", "targettarget") then
			Zorlen_debug("Assisting "..name.."!");
			AssistUnit("target");
			return
		else if UnitExists("pettarget") and Zorlen_checkDebuff("Sniper", "pettarget") then
			if not UnitIsUnit("target", "pettarget") and not Zorlen_checkDebuff("Sniper") then
				Zorlen_debug("Assisting your pet "..UnitName("pet").."!");
				AssistUnit("pet");
			end
			return
		end
		end
		if UnitCanAttack("player", "target") then
			ClearTarget();
			Zorlen_debug("Clearing Target!");
		end
		while (counter <= number) do
			TargetNearestEnemy();
			name = UnitName("target")
			if Zorlen_TargetIsEnemy() and Zorlen_checkDebuff("Sniper") then
				Zorlen_debug("Marked target found for targeting attempt #"..counter..": "..name);
				return
			else if name and Zorlen_TargetIsEnemy() then
				Zorlen_debug("Marked targeting attempt #"..counter..": "..name);
			end
			end
			counter = counter + 1
		end
		Zorlen_debug("Marked target not found!");
		if UnitCanAttack("player", "target") then
			ClearTarget();
			Zorlen_debug("Clearing Target!");
		end
	end
end

-- Will only assist a targeted friend if there target is an active enemy.
-- This is to try to allow safe assisting of a targeted friend.
function Zorlen_AssistTargetedFriendTargetingActiveEnemy()
	if Zorlen_TargetIsFriendTargetingActiveEnemy() then
		AssistUnit("target")
	end
end











-- checks to see if a fist weapon is equipped in the main hand
-- Use "/script Zorlen_GiveName_MainHandType()" to get the localization for your game client if it has not yet been added.
-- You can also get the correct name from the auction house filters under the Weapon section.
function Zorlen_isMainHandFistWeapon()
	if GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot")) then
		local mainHandLink = GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"))
		local _, _, itemCode = strfind(mainHandLink, "(%d+):")
		local _, _, _, _, _, itemType = GetItemInfo(itemCode)
		if (itemType == LOCALIZATION_ZORLEN_FistWeapons) then
			if not GetInventoryItemBroken("player",GetInventorySlotInfo("MainHandSlot")) then
				--Zorlen_debug("You have a fist weapon equipped in the main hand.");
				return true;
			else
				Zorlen_debug("Your fist weapon in the main hand is broken.");
				return false;
			end
		else
			--Zorlen_debug("You do not have a fist weapon equipped in the main hand.");
			return false;
		end
	else
		Zorlen_debug("You do not have a main hand item equipped.");
		return false;
	end
end

-- checks to see if a fishing pole is equipped
-- Use "/script Zorlen_GiveName_MainHandType()" to get the localization for your game client if it has not yet been added.
-- You can also get the correct name from the auction house filters under the Weapon section.
function Zorlen_isFishingPoleEquipped()
	if GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot")) then
		local mainHandLink = GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"))
		local _, _, itemCode = strfind(mainHandLink, "(%d+):")
		local _, _, _, _, _, itemType = GetItemInfo(itemCode)
		if (itemType == LOCALIZATION_ZORLEN_FishingPole) then
			if not GetInventoryItemBroken("player",GetInventorySlotInfo("MainHandSlot")) then
				--Zorlen_debug("You have a fishing pole equipped in the main hand.");
				return true;
			else
				Zorlen_debug("Your fishing pole in the main hand is broken.");
				return false;
			end
		else
			--Zorlen_debug("You do not have a fishing pole equipped in the main hand.");
			return false;
		end
	else
		Zorlen_debug("You do not have a main hand item equipped.");
		return false;
	end
end

-- checks to see if a stave is equipped
-- Use "/script Zorlen_GiveName_MainHandType()" to get the localization for your game client if it has not yet been added.
-- You can also get the correct name from the auction house filters under the Weapon section.
function Zorlen_isStaveEquipped()
	if GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot")) then
		local mainHandLink = GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"))
		local _, _, itemCode = strfind(mainHandLink, "(%d+):")
		local _, _, _, _, _, itemType = GetItemInfo(itemCode)
		if (itemType == LOCALIZATION_ZORLEN_Staves) then
			if not GetInventoryItemBroken("player",GetInventorySlotInfo("MainHandSlot")) then
				--Zorlen_debug("You have a stave equipped in the main hand.");
				return true;
			else
				Zorlen_debug("Your stave in the main hand is broken.");
				return false;
			end
		else
			--Zorlen_debug("You do not have a stave equipped in the main hand.");
			return false;
		end
	else
		Zorlen_debug("You do not have a main hand item equipped.");
		return false;
	end
end

-- checks to see if a polearm is equipped
-- Use "/script Zorlen_GiveName_MainHandType()" to get the localization for your game client if it has not yet been added.
-- You can also get the correct name from the auction house filters under the Weapon section.
function Zorlen_isPolearmEquipped()
	if GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot")) then
		local mainHandLink = GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"))
		local _, _, itemCode = strfind(mainHandLink, "(%d+):")
		local _, _, _, _, _, itemType = GetItemInfo(itemCode)
		if (itemType == LOCALIZATION_ZORLEN_Polearms) then
			if not GetInventoryItemBroken("player",GetInventorySlotInfo("MainHandSlot")) then
				--Zorlen_debug("You have a polearm equipped in the main hand.");
				return true;
			else
				Zorlen_debug("Your polearm in the main hand is broken.");
				return false;
			end
		else
			--Zorlen_debug("You do not have a polearm equipped in the main hand.");
			return false;
		end
	else
		Zorlen_debug("You do not have a main hand item equipped.");
		return false;
	end
end

-- checks to see if a one or two handed mace is equipped in the main hand
-- Use "/script Zorlen_GiveName_MainHandType()" to get the localization for your game client if it has not yet been added.
-- You can also get the correct names from the auction house filters under the Weapon section.
function Zorlen_isMainHandMace()
	if GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot")) then
		local mainHandLink = GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"))
		local _, _, itemCode = strfind(mainHandLink, "(%d+):")
		local _, _, _, _, _, itemType = GetItemInfo(itemCode)
		if (itemType == LOCALIZATION_ZORLEN_OneHandedMaces) or (itemType == LOCALIZATION_ZORLEN_TwoHandedMaces) then
			if not GetInventoryItemBroken("player",GetInventorySlotInfo("MainHandSlot")) then
				--Zorlen_debug("You have a mace equipped in the main hand.");
				return true;
			else
				Zorlen_debug("Your mace in the main hand is broken.");
				return false;
			end
		else
			--Zorlen_debug("You do not have a mace equipped in the main hand.");
			return false;
		end
	else
		Zorlen_debug("You do not have a main hand item equipped.");
		return false;
	end
end

-- checks to see if a one or two handed axe is equipped in the main hand
-- Use "/script Zorlen_GiveName_MainHandType()" to get the localization for your game client if it has not yet been added.
-- You can also get the correct names from the auction house filters under the Weapon section.
function Zorlen_isMainHandAxe()
	if GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot")) then
		local mainHandLink = GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"))
		local _, _, itemCode = strfind(mainHandLink, "(%d+):")
		local _, _, _, _, _, itemType = GetItemInfo(itemCode)
		if (itemType == LOCALIZATION_ZORLEN_OneHandedAxes) or (itemType == LOCALIZATION_ZORLEN_TwoHandedAxes) then
			if not GetInventoryItemBroken("player",GetInventorySlotInfo("MainHandSlot")) then
				--Zorlen_debug("You have a axe equipped in the main hand.");
				return true;
			else
				Zorlen_debug("Your axe in the main hand is broken.");
				return false;
			end
		else
			--Zorlen_debug("You do not have a axe equipped in the main hand.");
			return false;
		end
	else
		Zorlen_debug("You do not have a main hand item equipped.");
		return false;
	end
end

-- checks to see if a one or two handed sword is equipped in the main hand
-- Use "/script Zorlen_GiveName_MainHandType()" to get the localization for your game client if it has not yet been added.
-- You can also get the correct names from the auction house filters under the Weapon section.
function Zorlen_isMainHandSword()
	if GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot")) then
		local mainHandLink = GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"))
		local _, _, itemCode = strfind(mainHandLink, "(%d+):")
		local _, _, _, _, _, itemType = GetItemInfo(itemCode)
		if (itemType == LOCALIZATION_ZORLEN_OneHandedSwords) or (itemType == LOCALIZATION_ZORLEN_TwoHandedSwords) then
			if not GetInventoryItemBroken("player",GetInventorySlotInfo("MainHandSlot")) then
				--Zorlen_debug("You have a sword equipped in the main hand.");
				return true;
			else
				Zorlen_debug("Your sword in the main hand is broken.");
				return false;
			end
		else
			--Zorlen_debug("You do not have a sword equipped in the main hand.");
			return false;
		end
	else
		Zorlen_debug("You do not have a main hand item equipped.");
		return false;
	end
end

-- checks to see if a dagger is equipped in the main hand
-- Use "/script Zorlen_GiveName_MainHandType()" to get the localization for your game client if it has not yet been added.
-- You can also get the correct name from the auction house filters under the Weapon section.
function Zorlen_isMainHandDagger()
	if GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot")) then
		local mainHandLink = GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"))
		local _, _, itemCode = strfind(mainHandLink, "(%d+):")
		local _, _, _, _, _, itemType = GetItemInfo(itemCode)
		if (itemType == LOCALIZATION_ZORLEN_Daggers) then
			if not GetInventoryItemBroken("player",GetInventorySlotInfo("MainHandSlot")) then
				--Zorlen_debug("You have a dagger equipped in the main hand.");
				return true;
			else
				Zorlen_debug("Your dagger in the main hand is broken.");
				return false;
			end
		else
			--Zorlen_debug("You do not have a dagger equipped in the main hand.");
			return false;
		end
	else
		Zorlen_debug("You do not have a main hand item equipped.");
		return false;
	end
end

-- checks to see if a shield is equipped
-- Use "/script Zorlen_GiveName_OffHandType()" to get the localization for your game client if it has not yet been added.
-- You can also get the correct name from the auction house filters under the Armor section.
function Zorlen_isShieldEquipped()
	if GetInventoryItemLink("player",GetInventorySlotInfo("SecondaryHandSlot")) then
		local offHandLink = GetInventoryItemLink("player",GetInventorySlotInfo("SecondaryHandSlot"))
		local _, _, itemCode = strfind(offHandLink, "(%d+):")
		local _, _, _, _, _, itemType = GetItemInfo(itemCode)
		if (itemType == LOCALIZATION_ZORLEN_Shields) then
			if not GetInventoryItemBroken("player",GetInventorySlotInfo("SecondaryHandSlot")) then
				--Zorlen_debug("You have a shield equipped.");
				return true;
			else
				Zorlen_debug("Your shield is broken.");
				return false;
			end
		else
			--Zorlen_debug("You do not have a shield equipped.");
			return false;
		end
	else
		Zorlen_debug("You do not have a off hand item equipped.");
		return false;
	end
end


-- This will give the name required for LOCALIZATION_ZORLEN_Shields
-- You must have a shield equipped to get the correct name
-- You can also get the correct name from the auction house filters under the Armor section.
function Zorlen_GiveName_OffHandType()
	if GetInventoryItemLink("player",GetInventorySlotInfo("SecondaryHandSlot")) then
		local offHandLink = GetInventoryItemLink("player",GetInventorySlotInfo("SecondaryHandSlot"))
		local _, _, itemCode = strfind(offHandLink, "(%d+):")
		local _, _, _, _, _, itemType = GetItemInfo(itemCode)
		DEFAULT_CHAT_FRAME:AddMessage(itemType)
	else
		DEFAULT_CHAT_FRAME:AddMessage("You do not have a off hand item equipped.");
	end
end

function Zorlen_GiveName_MainHandType()
	if (GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"))) then
		local mainHandLink = GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"))
		local _, _, itemCode = strfind(mainHandLink, "(%d+):")
		local _, _, _, _, _, itemType = GetItemInfo(itemCode)
		DEFAULT_CHAT_FRAME:AddMessage(itemType)
	else
		DEFAULT_CHAT_FRAME:AddMessage("You do not have a main hand item equipped.");
	end
end


-- checks to see if a main hand item is equipped
function Zorlen_isMainHandEquipped()
	if GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot")) then
		if not GetInventoryItemBroken("player",GetInventorySlotInfo("MainHandSlot")) then
			--Zorlen_debug("You have a main hand item equipped.");
			return true;
		else
			Zorlen_debug("Your main hand item is broken.");
			return false;
		end
	else
		Zorlen_debug("You do not have a main hand item equipped.");
		return false;
	end
end







function Zorlen_GiveMaxTargetRange()
	if UnitExists("target") then
		if CheckInteractDistance("target", 1) then
			Zorlen_debug("Your target is within 0 to 5 yards from you.");
			return 5
		else if CheckInteractDistance("target", 3) then
			Zorlen_debug("Your target is within 5 to 10 yards from you.");
			return 10
		else if CheckInteractDistance("target", 4) then
			Zorlen_debug("Your target is within 10 to 28 yards from you.");
			return 28
		else if not CheckInteractDistance("target", 4) then
			Zorlen_debug("Your target is more than 28 yards from you.");
			return 9999999999999999
		end
		end
		end
		end
	else
		Zorlen_debug("You do not have a target.");
		return 9999999999999999
	end
end

