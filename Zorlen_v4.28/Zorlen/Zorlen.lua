

local TOC_FBN = 689

local Druid_FBN = 688
local Hunter_FBN = 688
local Mage_FBN = 687
local Paladin_FBN = 688
local Priest_FBN = 688
local Rogue_FBN = 688
local Shaman_FBN = 684
local Warlock_FBN = 687
local Warrior_FBN = 688

local Other_FBN = 687
local Pets_FBN = 683

local ImmuneMobList_FBN = 683
local XML_FBN = 687

local Localization_FBN = 687
-- All of the Localization files must always have the same build number listed inside of them


Zorlen_MaxPlayerLevel = 60
Zorlen_MaxDebuffSlots = 16


-- Make sure that all the build numbers listed above are always the same as they are listed inside of the corresponding files



--[[
  Started by Marcus S. Zarra
 
  4.27
		Fixed the lag in german game clients!
 
  4.26
		Functions from other classes that can not be used will no longer be loaded into memory if you are not playing on that class.
		Added an option in the options window to turn off the Auto Mob Immunity Detection.
 
  4.25
		Converted all the localization into an array for more versatility. This means that most of the LOCALIZATION_ZORLEN_SpellName will now be LOCALIZATION_ZORLEN.SpellName
		Added an option in the options window to clear the Immune Mob Database.
		Set it so that it will not detect a mob as immune if they are in combat but have no target. This is to try to prevent mobs that are banished or have some other immune spell that makes them not target anyone from being detected as immune. This will cause some real immunitys to not be detected at first, but not very often since you only need it to log the immunity once.
 
  4.24
		Fixed the nasty lock up bug.
 
  4.23
		Zorlen will now keep track of mob immunity to spells and abilitys. -- You can set a mob to ignore this list in the Zorlen options window.
		I have hopefully fixed the problems that some german clients had been having.
 
  4.22
		Added a GUI Options Window. To open it you may use the slash command:
		/zorlen
		or
		/zf
 
  4.20
		Added a Version History text file in the addon folders.
		Added slash command to help with localization translation: /zorlen log
		You may now add a file named MyFunctions.lua to the Zorlen folder that may contain your own custom functions that you may have.
		Zorlen_HealthDamagePercent(unit) added by BigRedBrent
		Zorlen_HealthDamage(unit) added by BigRedBrent
		Zorlen_ManaMissing(unit) added by BigRedBrent
		Zorlen_ManaPercent(unit) added by BigRedBrent
		Zorlen_GetItemNameFromItemID(id) added by BigRedBrent
		isActionInRangeBySpellName(SpellName) added by BigRedBrent -- This still requires that the spell be on one of your action bars.
		Fixed: Zorlen_CancelSelfBuff()
 
  4.19
		Zorlen_HealthPercent(unit) added by BigRedBrent
 
  4.18
		Zorlen_isTrinketByNameReady(name) added by BigRedBrent
		Zorlen_isTrinketByItemIDReady(id) added by BigRedBrent
		isDruid(unit) added by BigRedBrent
		isHunter(unit) added by BigRedBrent
		isPaladin(unit) added by BigRedBrent
		isPriest(unit) added by BigRedBrent
		isMage(unit) added by BigRedBrent
		isRogue(unit) added by BigRedBrent
		isShaman(unit) added by BigRedBrent
		isWarlock(unit) added by BigRedBrent
		isWarrior(unit) added by BigRedBrent
		Fixed: Zorlen_isMainHandEquipped()
 
  4.16
		Added functions to use 
 
  4.16
		Added functions to use items by there Item ID instead of there names, these will also work with the full item links as well as the item id strings
		Zorlen_useTrinketByItemID(id) added by BigRedBrent
		Zorlen_useContainerItemByItemID(id) added by BigRedBrent
		Zorlen_useEquippedItemByItemID(id) added by BigRedBrent
		Zorlen_useItemByItemID(id) added by BigRedBrent
 
  4.15
		Zorlen_CancelSelfBuffByName(SpellName) added by BigRedBrent
 
  4.12
		Zorlen_checkMainHandItemBuffByName(SpellName) added by BigRedBrent
		Zorlen_checkOffHandItemBuffByName(SpellName) added by BigRedBrent
		Zorlen_checkItemBuffByName(SpellName) added by BigRedBrent
		Zorlen_GetRaidTargetName() added by BigRedBrent
		Zorlen_inBG() added by BigRedBrent
		Zorlen_isMoving() added by BigRedBrent
 
  4.11
		A few small bug fixes.
		You can now use this slash command to add some pre made macros to your hunter or warlock  specific macro lists:
		/zorlen macros
		You must be on a hunter or warlock for them to be added.
		This slash command has been made to not replace any macros even if they have the same name. If you ever need to restore one of the macros then just delete that macro and run the slash command.
  
  4.10
		Hooked casting functions to get spell information
		Will now be able to also use spell information such as spell name and rank from spells that are cast outside of a macro
		The casting and channeling detection functions will now be able to work for all spells and macros that are not from the zorlen library
		Removed the "Zorlen_RegisterButtons.lua" file, and added all of its functionality to the main "Zorlen.lua" file
		Significantly reduced the lag caused when the action bar buttons are being scanned
  
  4.02
		Food function scanner is now blocked when in combat
		Eat and Drink functions will now work when the food scanner is disabled by calling the food scanner when calling the Eat and Drink functions
  
  4.01
		Updated Zorlen_isBreakOnDamageCC() to detect the sleep debuff of Wyvern Sting and not the damage debuff of Wyvern Sting
		Fixed: Zorlen_HasTalent(TalentName) and Zorlen_GetTalentRank(TalentName)
		Fixed bug with timer functions
  
  4.0
		Zorlen_SetTimer(Seconds, Name, Pre) added by BigRedBrent
		Zorlen_IsTimer(Name, Pre) added by BigRedBrent
		Zorlen_ClearTimer(Name, Pre) added by BigRedBrent
		Added the ability for most of the DOT spells to be able to cast if someone else has the same DOT spell on the target
  
  3.99
		Added French Localization by Dornuwynn
  
  3.98.09
		Fixed healing spells
		Food functions have been disabled by default since they have a higher chance then other functions to cause lag
  
  3.98.07
		Updated: Zorlen_GetSpellID(SpellName, SpellRank)
		Updated: Zorlen_IsSpellKnown(SpellName, SpellRank)
  
  3.98.04
		Added slash command to disable equipped item scanning for healer classes:
		/zorlen itemscan
  
  3.98.02
		Zorlen_GivesXP() added by BigRedBrent
  
  3.98.01
		Zorlen_isActiveEnemyThatGivesXP() added by BigRedBrent
		Zorlen_TargetActiveEnemyThatGivesXPOnly() added by BigRedBrent
  
  3.98
		Fixed food macros
  
  3.96
		Fixed immunity detection that I (BigRedBrent) broke
  
  3.95
		Zorlen_checkDebuffByName(name, unit) added by BigRedBrent
		Zorlen_checkBuffByName(name, unit) added by BigRedBrent
  
  3.94
		Further fixed bug with channeling spells recasting over top of themselves and not casting in some situations
  
  3.92
		Fixed the ability to select spell rank for most spells by adding a number value in the function,
		and will now also use the max spell rank unless a rank is given even if the max spell rank is not on any of the action bars
		Fixed bug with channeling spells recasting if you cast over top of another channeling spell
  
  3.91
		Fixed errors with Zorlen_InventoryScan()
  
  3.90
		Completely revamped the action bar spell button detection to scan tool tip names instead of texture names,
		and also seams to have much less lag when refreshing the buttons
		Added the ability to select spell rank for most spells by adding a number value in the function:
		Example:
		/script castArcane(1)  --will cast Arcane Shot(Rank 1)
  
  3.80
		Fixed eat and drink functions that I (BigRedBrent) broke last patch
  
  3.79
		Fixed bug where spells would stop casting if you use the function when casting the spell
		Zorlen_MakeMacro(name, macro, percharacter, macroicontecture, iconindex, replace, show, nocreate, replacemacroindex) added by BigRedBrent
  
  3.78
		Added slash commands for eat and drink functions:   Use "/zorlen food" to see them
		Zorlen_GiveGroupUnit(mode, showdebug, notunit, notunitarray, buff, notlowesthealth, dispelabledebuff, findbuff1, findbuff2)
		Zorlen_GiveGroupUnitWithLowestHealthWithoutBuff(buff, mode, showdebug, notunit, notunitarray)
		Zorlen_GiveGroupUnitWithLowestHealthWithoutBuffBySpellName(SpellName, mode, showdebug, notunit, notunitarray)
		Zorlen_GiveGroupUnitWithLowestHealthWithBuff(findbuff1, findbuff2, mode, showdebug, notunit, notunitarray)
		Zorlen_GiveGroupUnitWithLowestHealthWithBuffBySpellName(SpellName1, SpellName2, mode, showdebug, notunit, notunitarray)
		Moved Zorlen_Eat() and Zorlen_Drink() to Zorlen.lua file
		
  
  3.76.01
		Added a few fixes and optimizations
  
  3.76.00
		Zorlen_useContainerItemByName(name) added by BigRedBrent
		Zorlen_useContainerItemWithLowestCountByName(name) added by BigRedBrent
		Zorlen_isItemByNameInContainer(name) added by BigRedBrent
		Zorlen_isItemByNameEquippedOrInContainer(name) added by BigRedBrent
		Zorlen_useContainerItemBySlotNumber(bag, slot, name) added by BigRedBrent
		Zorlen_GiveContainerItemSlotNumberByName(name, notname, mode) added by BigRedBrent
		Zorlen_GiveContainerItemSlotNumberWithLowestCountByName(name) added by BigRedBrent
		Zorlen_GiveContainerItemSlotNumberWithLowestCountByToolTipLineText(name)
		Zorlen_GiveContainerItemSlotNumberByToolTipLineText(name, notname, mode)
		Zorlen_useEquippedItemBySlotNumber(id) added by BigRedBrent
		Zorlen_GiveMacroIconIndex(texture) added by BigRedBrent
		Zorlen_GiveContainerItemCountByName(name) added by BigRedBrent
		Zorlen_MakeEatMacro(show) added by BigRedBrent
		Zorlen_MakeDrinkMacro(show) added by BigRedBrent
		Added slash commands to show buff and debuff textures:
		/zorlen buffs
		/zorlen debuffs
		Added slash commands to use food and water:
		/zorlen eat
		/zorlen drink
		Added slash commands to make a macro for food and water:
		/zorlen eat macro
		/zorlen drink macro
		/zorlen macro
  
  3.74.02
		Small fix for the healing spells as well as a few other bug fixes
  
  3.74.01
		Small fix for the healing spells
  
  3.74.00
		Zorlen_TargetGroupMemberWithoutBuffBySpellName(SpellName) added by BigRedBrent
		Zorlen_TargetGroupMemberWithoutBuff(buff) added by BigRedBrent
		Zorlen_GiveGroupUnitWithoutBuffBySpellName(SpellName) added by BigRedBrent
		Zorlen_GiveGroupUnitWithoutBuff(buff) added by BigRedBrent
		Zorlen_TargetGroupMemberWithDispelableDebuff(mode, show)
		Zorlen_GiveGroupUnitWithDispelableDebuff(mode, show)
		Zorlen_useItemByName(name) added by BigRedBrent
		Zorlen_useEquippedItemByName(name) added by BigRedBrent
		Zorlen_isItemByNameEquipped(name) added by BigRedBrent
		Zorlen_GiveEquippedItemSlotNumberByName(name) added by BigRedBrent
  
  3.73.00
		Fixed: Zorlen_GiveGroupUnitWithLowestHealth()
  
  3.72.00
		Zorlen_CancelSelfBuff(buff) added by BigRedBrent
		Zorlen_GiveSelfBuffIndex(buff) added by BigRedBrent
		Zorlen_GiveDebuffIndex(debuff, unit) added by BigRedBrent
		Zorlen_GiveBuffIndex(buff, unit) added by BigRedBrent
  
  3.70.00
		Improved Zorlen_CastMultiNamedHealingSpell() by BigRedBrent
		Zorlen_GiveGroupUnitWithLowestHealth() added by BigRedBrent
		Zorlen_TargetEnemyRaidTargetOnly() added by BigRedBrent
		Zorlen_useTrinketByName("name") added by BigRedBrent
		Zorlen_isTrinketByNameEquipped("name") added by BigRedBrent
		Zorlen_GiveTrinketSlotNumberByName("name") added by Trev
  
  3.69.00
		Included more polymorph spells into the CC detection
  
  3.67.00
		Mind Control control is no longer included as a CC in Zorlen_isNoDamageCC()
  
  3.66.00
		Zorlen_CastHealingSpell(SpellName, ManaArray, MinHealArray, MaxHealArray, TimeArray, LevelLearnedArray, Mode, RankAdj, unit) added by Jiral
		Zorlen_CastMultiNamedHealingSpell(SpellNameArray, SpellRankArray, ManaArray, MinHealArray, MaxHealArray, TimeArray, LevelLearnedArray, Mode, RankAdj, unit) added by Jiral
		Zorlen_InventoryScan() added by Jiral
  
  3.63.00
		Zorlen_TargetGroupMemberWithLowestHealth() added by BigRedBrent
		Zorlen_TargetGroupMemberWithLowestHealth("pets") added by BigRedBrent
		Zorlen_TargetByFindInName("name") added by BigRedBrent
  
  3.59.00
		Zorlen_ShowSpellTextureByName(SpellName) added by BigRedBrent
  
  3.53.00
		Updated: Zorlen_isEnemy() Should now work fine in duels
  
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
		Zorlen_isEnemyPlayer() added by BigRedBrent
		Zorlen_isEnemyMob() added by BigRedBrent
		Zorlen_isActiveEnemyMob() added by BigRedBrent
		Zorlen_TargetEnemyMobOnly() added by BigRedBrent
		Zorlen_TargetActiveEnemyMobOnly() added by BigRedBrent
		
  
  3.25.02
		Fixed a bug with Zorlen_isActiveEnemy(unit) that would incorrectly label a neutral mob as being active.
  
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
		Zorlen_checkDebuff(debuff, unit)
		Zorlen_checkBuff(buff, unit)
		Zorlen_GetDebuffStack(debuff, unit)
		Zorlen_GetDebuffStackBySpellName(SpellName, unit)
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
		Zorlen_isCrowedControlled() replaced by Zorlen_isBreakOnDamageCC()
  
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
		Zorlen_GetDebuffStack(debuff) added by BigRedBrent
		Zorlen_isMainHandEquipped() added by BigRedBrent
  
  3.3.0
		Zorlen_GetSpellRank(SpellName) added by BigRedBrent
  
  3.0.3c  
		Zorlen_IsSpellKnown(SpellName) added by BigRedBrent
  
  3.0.3  
		Zorlen_notInCombat() added by BigRedBrent
		Zorlen_isEnemyTargetingYou() added by BigRedBrent
		Zorlen_isEnemyTargetingFriendButNotYou() added by BigRedBrent
		Zorlen_isEnemyTargetingEnemy() added by BigRedBrent
		Zorlen_isEnemy() added by BigRedBrent
		Zorlen_isActiveEnemy() added by BigRedBrent
		Zorlen_isDieingEnemy() added by BigRedBrent
		Zorlen_isDieingEnemyWithNoTarget() added by BigRedBrent
		Zorlen_isFriendTargetingEnemy() added by BigRedBrent
		Zorlen_isFriendTargetingActiveEnemy() added by BigRedBrent
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



zorlen_version = GetAddOnMetadata("Zorlen", "Version")
ZorlenOptionsFrame_Title = "Zorlen "..zorlen_version
Zorlen_TOC_FileBuildNumber = tonumber(GetAddOnMetadata("Zorlen", "X-TocFileBuildNumber"))

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

local zorlen_startup_message = "Zorlen Functions Library enabled"
ZORLEN_ZPN = nil
ZORLEN_ZDS = "dodge_silent"
ZORLEN_ASSIST = "assist"
ZORLEN_TARGETBYNAME = "target_by_name"
ZORLEN_DEBUG = "debug"
ZORLEN_FULLDEBUG = "full_debug_mode"
ZORLEN_DEBUGRELOADUI = "debug_reloadui"
ZORLEN_PETISDEAD = "pet_is_dead"
ZORLEN_AUTOBUTTONSCANOFF = "auto_button_refresh_scan_off"
ZORLEN_AUTOMOBIMMUNEOFF = "auto_mob_immune_detection_off"
ZORLEN_FOODOFF = "food_off"
ZORLEN_ITEMSCANOFF = "item_scan_off"
ZORLEN_EVENT_LOG = "Event_Log"
ZORLEN_LOG_EVENTS = "Event_Log_On"
Zorlen_VariablesLoaded = nil
ZorlenInitialized = nil
Zorlen_DebugCount = 0
Zorlen_PlusHealingMin  = 0
Zorlen_PlusHealingMax  = 0
Zorlen_VariableHealing = 0
Zorlen_SpellDamage = 0
Zorlen_ShadowDamage = 0
Zorlen_CastingSpellCastTime = 0
Zorlen_CastingSpellRank = 0
Zorlen_Temp_CastingSpellRank = 0
local Zorlen_Timer = {}
Zorlen_Timer.Name = {}
Zorlen_Timer.Pre = {}
Zorlen_Timer.Tag = {}
Zorlen_Timer.Slot = {}
Zorlen_Timer.Seconds = {}
Zorlen_Timer.FullName = {}
Zorlen_Timer.Show = {}
Zorlen_Timer.TimerTimer = {}
Zorlen_Timer.RunFunction = {}
Zorlen_LocalizedPlayerClass, Zorlen_PlayerClass = UnitClass("player")
Zorlen_LocalizedPlayerRace, Zorlen_PlayerRace = UnitRace("player")

local Zorlen_EatItemName = ""
local Zorlen_EatBagID = nil
local Zorlen_EatSlotID = nil
local Zorlen_EatItemCount = 0
local Zorlen_EatItemlevel = 0

local Zorlen_DrinkItemName = ""
local Zorlen_DrinkBagID = nil
local Zorlen_DrinkSlotID = nil
local Zorlen_DrinkItemCount = 0
local Zorlen_DrinkItemLevel = 0

local NoFoodTexture = "Interface\\Icons\\INV_Misc_Fork&Knife.blp"
local NoWaterTexture = "Interface\\Icons\\INV_Drink_04.blp"

local ConjuredCinnamonRollTexture = "Interface\\Icons\\INV_Misc_Food_73CinnamonRoll.blp"
local ConjuredSweetRollTexture = "Interface\\Icons\\INV_Misc_Food_33.blp"
local ConjuredSourdoughTexture = "Interface\\Icons\\INV_Misc_Food_11.blp"
local ConjuredPumpernickelTexture = "Interface\\Icons\\INV_Misc_Food_08.blp"
local ConjuredRyeTexture = "Interface\\Icons\\INV_Misc_Food_12.blp"
local ConjuredBreadTexture = "Interface\\Icons\\INV_Misc_Food_09.blp"
local ConjuredMuffinTexture = "Interface\\Icons\\INV_Misc_Food_10.blp"

local ConjuredCrystalWaterTexture = "Interface\\Icons\\INV_Drink_18.blp"
local ConjuredSparklingWaterTexture = "Interface\\Icons\\INV_Drink_11.blp"
local ConjuredMineralWaterTexture = "Interface\\Icons\\INV_Drink_09.blp"
local ConjuredSpringWaterTexture = "Interface\\Icons\\INV_Drink_10.blp"
local ConjuredPurifiedWaterTexture = "Interface\\Icons\\INV_Drink_Milk_02.blp"
local ConjuredFreshWaterTexture = "Interface\\Icons\\INV_Drink_07.blp"
local ConjuredWaterTexture = "Interface\\Icons\\INV_Drink_06.blp"

local Food3180Texture = ConjuredCinnamonRollTexture
local Food2148Texture = "Interface\\Icons\\INV_Misc_Food_15.blp"
local Food1392Texture = "Interface\\Icons\\INV_Misc_Food_14.blp"
local Food874Texture = "Interface\\Icons\\INV_Misc_Food_13.blp"
local Food552Texture = "Interface\\Icons\\INV_Misc_Food_14.blp"
local Food243Texture = "Interface\\Icons\\INV_Misc_Food_18.blp"
local Food61Texture = "Interface\\Icons\\INV_Misc_Food_16.blp"
local FoodAnyTexture = "Interface\\Icons\\INV_Misc_Food_27.blp"

local Drink4200Texture = ConjuredCrystalWaterTexture
local Drink2934Texture = "Interface\\Icons\\INV_Potion_01.blp"
local Drink1992Texture = "Interface\\Icons\\INV_Drink_02.blp"
local Drink1344Texture = "Interface\\Icons\\INV_Drink_12.blp"
local Drink835Texture = "Interface\\Icons\\INV_Drink_09.blp"
local Drink436Texture = "Interface\\Icons\\INV_Drink_Milk_01.blp"
local Drink151Texture = "Interface\\Icons\\INV_Drink_07.blp"
local DrinkAnyTexture = "Interface\\Icons\\INV_Drink_08.blp"

local FoodTextureArray = {
	ConjuredCinnamonRollTexture,
	ConjuredSweetRollTexture,
	ConjuredSourdoughTexture,
	ConjuredPumpernickelTexture,
	ConjuredRyeTexture,
	ConjuredBreadTexture,
	ConjuredMuffinTexture,
	Food3180Texture,
	Food2148Texture,
	Food1392Texture,
	Food874Texture,
	Food552Texture,
	Food243Texture,
	Food61Texture,
	FoodAnyTexture,
	NoFoodTexture,
}

local DrinkTextureArray = {
	ConjuredCrystalWaterTexture,
	ConjuredSparklingWaterTexture,
	ConjuredMineralWaterTexture,
	ConjuredSpringWaterTexture,
	ConjuredPurifiedWaterTexture,
	ConjuredFreshWaterTexture,
	ConjuredWaterTexture,
	Drink4200Texture,
	Drink2934Texture,
	Drink1992Texture,
	Drink1344Texture,
	Drink835Texture,
	Drink436Texture,
	Drink151Texture,
	DrinkAnyTexture,
	NoWaterTexture,
}



if (Zorlen_PlayerClass == "PRIEST") then
	Zorlen_isCurrentClassPriest = 1
elseif (Zorlen_PlayerClass == "ROGUE") then
	Zorlen_isCurrentClassRogue = 1
elseif (Zorlen_PlayerClass == "PALADIN") then
	Zorlen_isCurrentClassPaladin = 1
elseif (Zorlen_PlayerClass == "WARLOCK") then
	Zorlen_isCurrentClassWarlock = 1
elseif (Zorlen_PlayerClass == "WARRIOR") then
	Zorlen_isCurrentClassWarrior = 1
elseif (Zorlen_PlayerClass == "HUNTER") then
	Zorlen_isCurrentClassHunter = 1
elseif (Zorlen_PlayerClass == "MAGE") then
	Zorlen_isCurrentClassMage = 1
elseif (Zorlen_PlayerClass == "SHAMAN") then
	Zorlen_isCurrentClassShaman = 1
elseif (Zorlen_PlayerClass == "DRUID") then
	Zorlen_isCurrentClassDruid = 1
end

if (Zorlen_PlayerRace == "Human") then
	Zorlen_isCurrentRaceHuman = 1
elseif (Zorlen_PlayerRace == "Dwarf") then
	Zorlen_isCurrentRaceDwarf = 1
elseif (Zorlen_PlayerRace == "Gnome") then
	Zorlen_isCurrentRaceGnome = 1
elseif (Zorlen_PlayerRace == "Night Elf") then
	Zorlen_isCurrentRaceNightElf = 1
elseif (Zorlen_PlayerRace == "Orc") then
	Zorlen_isCurrentRaceOrc = 1
elseif (Zorlen_PlayerRace == "Scourge") or (Zorlen_PlayerRace == "Undead") then
	Zorlen_isCurrentRaceUndead = 1
elseif (Zorlen_PlayerRace == "Tauren") then
	Zorlen_isCurrentRaceTauren = 1
elseif (Zorlen_PlayerRace == "Troll") then
	Zorlen_isCurrentRaceTroll = 1
end


function Zorlen_OnLoad()
	ZorlenFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
	ZorlenFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
	ZorlenFrame:RegisterEvent("PLAYER_ENTER_COMBAT")
	ZorlenFrame:RegisterEvent("PLAYER_LEAVE_COMBAT")
	ZorlenFrame:RegisterEvent("START_AUTOREPEAT_SPELL")
	ZorlenFrame:RegisterEvent("STOP_AUTOREPEAT_SPELL")
	ZorlenFrame:RegisterEvent("PET_ATTACK_START")
	ZorlenFrame:RegisterEvent("PET_ATTACK_STOP")
	ZorlenFrame:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES")
	ZorlenFrame:RegisterEvent("VARIABLES_LOADED")
	ZorlenFrame:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
	ZorlenFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	ZorlenFrame:RegisterEvent("PLAYER_LEAVING_WORLD")
	ZorlenFrame:RegisterEvent("PLAYER_LOGIN")
	ZorlenFrame:RegisterEvent("ACTIONBAR_HIDEGRID")
	ZorlenFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
	ZorlenFrame:RegisterEvent("SPELLCAST_START")
	ZorlenFrame:RegisterEvent("SPELLCAST_CHANNEL_START")
	ZorlenFrame:RegisterEvent("SPELLCAST_CHANNEL_UPDATE")
	ZorlenFrame:RegisterEvent("SPELLCAST_DELAYED")
	ZorlenFrame:RegisterEvent("SPELLCAST_CHANNEL_STOP")
	ZorlenFrame:RegisterEvent("SPELLCAST_STOP")
	ZorlenFrame:RegisterEvent("SPELLCAST_INTERRUPTED")
	ZorlenFrame:RegisterEvent("SPELLCAST_FAILED")
	ZorlenFrame:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE")
	ZorlenFrame:RegisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER")
	ZorlenFrame:RegisterEvent("CHAT_MSG_COMBAT_SELF_MISSES")
	ZorlenFrame:RegisterEvent("UI_ERROR_MESSAGE")
	ZorlenFrame:RegisterEvent("BAG_UPDATE")
	ZorlenFrame:RegisterEvent("UNIT_INVENTORY_CHANGED")
	ZorlenFrame:RegisterEvent("LEARNED_SPELL_IN_TAB")
	ZorlenFrame:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
	SlashCmdList["Zorlen"] = Zorlen_SlashHandler
	SLASH_Zorlen1 = "/Zorlen"
	SLASH_Zorlen2 = "/Zfl"
	SLASH_Zorlen3 = "/Zl"
	SLASH_Zorlen4 = "/Zf"
	SlashCmdList["ZorlenT"] = Zorlen_ZorlenTargetSlashHandler
	SLASH_ZorlenT1 = "/Zorlentarget"
	SLASH_ZorlenT2 = "/Ztarget"
	SLASH_ZorlenT3 = "/Zorlent"
	SLASH_ZorlenT4 = "/Zt"
	SlashCmdList["ZorlenChangeT"] = Zorlen_ZorlenChangeTargetSlashHandler
	SLASH_ZorlenChangeT1 = "/Zorlenchangetarget"
	SLASH_ZorlenChangeT2 = "/Zorlensettarget"
	SLASH_ZorlenChangeT3 = "/Zchangetarget"
	SLASH_ZorlenChangeT4 = "/Zsettarget"
	SLASH_ZorlenChangeT5 = "/Zctarget"
	SLASH_ZorlenChangeT6 = "/Zstarget"
	SLASH_ZorlenChangeT7 = "/Zorlenct"
	SLASH_ZorlenChangeT8 = "/Zorlenst"
	SLASH_ZorlenChangeT9 = "/Zct"
	SLASH_ZorlenChangeT10 = "/Zst"
	SlashCmdList["ZorlenClearT"] = Zorlen_ZorlenClearTargetSlashHandler
	SLASH_ZorlenClearT1 = "/Zorlencleartarget"
	SLASH_ZorlenClearT2 = "/Zorlencleart"
	SLASH_ZorlenClearT3 = "/Zcleartarget"
	SLASH_ZorlenClearT4 = "/Zcleart"
	SlashCmdList["ZorlenA"] = Zorlen_ZorlenAssistSlashHandler
	SLASH_ZorlenA1 = "/Zorlenassist"
	SLASH_ZorlenA2 = "/Zassist"
	SLASH_ZorlenA3 = "/Zorlena"
	SLASH_ZorlenA4 = "/Za"
	SlashCmdList["ZorlenChangeA"] = Zorlen_ZorlenChangeAssistSlashHandler
	SLASH_ZorlenChangeA1 = "/Zorlenchangeassist"
	SLASH_ZorlenChangeA2 = "/Zorlensetassist"
	SLASH_ZorlenChangeA3 = "/Zchangeassist"
	SLASH_ZorlenChangeA4 = "/Zsetassist"
	SLASH_ZorlenChangeA5 = "/Zcassist"
	SLASH_ZorlenChangeA6 = "/Zsassist"
	SLASH_ZorlenChangeA7 = "/Zorlenca"
	SLASH_ZorlenChangeA8 = "/Zorlensa"
	SLASH_ZorlenChangeA9 = "/Zca"
	SLASH_ZorlenChangeA10 = "/Zsa"
	SlashCmdList["ZorlenClearA"] = Zorlen_ZorlenClearAssistSlashHandler
	SLASH_ZorlenClearA1 = "/Zorlenclearassist"
	SLASH_ZorlenClearA2 = "/Zorlencleara"
	SLASH_ZorlenClearA3 = "/Zclearassist"
	SLASH_ZorlenClearA4 = "/Zcleara"
	Zorlen_debug(zorlen_startup_message, 1)
end



function Zorlen_FileBuildCheck()
	if
		Zorlen_TOC_FileBuildNumber == TOC_FBN
		and
		Zorlen_XML_FileBuildNumber == XML_FBN
		and
		Zorlen_CN_FileBuildNumber == Localization_FBN
		and
		Zorlen_DE_FileBuildNumber == Localization_FBN
		and
		Zorlen_EN_FileBuildNumber == Localization_FBN
		and
		Zorlen_FR_FileBuildNumber == Localization_FBN
		and
		Zorlen_KR_FileBuildNumber == Localization_FBN
		and
		Zorlen_RU_FileBuildNumber == Localization_FBN
		and
		Zorlen_TW_FileBuildNumber == Localization_FBN
		and
		Zorlen_ImmuneMobList_FileBuildNumber == ImmuneMobList_FBN
		and
		Zorlen_Other_FileBuildNumber == Other_FBN
		and
		Zorlen_Pets_FileBuildNumber == Pets_FBN
		and
		Zorlen_Priest_FileBuildNumber == Priest_FBN
		and
		Zorlen_Rogue_FileBuildNumber == Rogue_FBN
		and
		Zorlen_Shaman_FileBuildNumber == Shaman_FBN
		and
		Zorlen_Warlock_FileBuildNumber == Warlock_FBN
		and
		Zorlen_Warrior_FileBuildNumber == Warrior_FBN
		and
		Zorlen_Druid_FileBuildNumber == Druid_FBN
		and
		Zorlen_Hunter_FileBuildNumber == Hunter_FBN
		and
		Zorlen_Mage_FileBuildNumber == Mage_FBN
		and
		Zorlen_Paladin_FileBuildNumber == Paladin_FBN
	then
		return true
	end
return false
end

function Zorlen_SlashHandler(message)
	local msg = nil
	if message then
		msg = string.lower(""..message.."")
	end
	if (msg == "") then
		ZorlenOptionsFrame:Show()
	end
	if (msg == "admin") then
		if ZorlenConfig[ZORLEN_ZPN]["admin"] then
			ZorlenConfig[ZORLEN_ZPN]["admin"] = nil
			Zorlen_msg("Zorlen Admin: OFF")
		else
			ZorlenConfig[ZORLEN_ZPN]["admin"] = true
			Zorlen_msg("Zorlen Admin: ON")
		end
	end
	if (msg == "options") or (msg == "help") or (msg == "debug options") or (msg == "debug help") then
		if Zorlen_FileBuildCheck() then
			Zorlen_debug("Zorlen "..zorlen_version.." options:", 1)
		else
			Zorlen_debug("Zorlen options:", 1)
		end
		if Zorlen_isCurrentClassHunter then
			Zorlen_debug("   [  status  |  version  |  food  |  make macros  |  dodge  ]", 1)
		elseif Zorlen_isCurrentClassPriest or Zorlen_isCurrentClassDruid or Zorlen_isCurrentClassShaman or Zorlen_isCurrentClassPaladin or Zorlen_isCurrentClassWarlock then
			Zorlen_debug("   [  status  |  version  |  food  |  make macros  |  itemscan  ]", 1)
		else
			Zorlen_debug("   [  status  |  version  |  food  |  make macros  ]", 1)
		end
		Zorlen_debug("   [  button scan mode  |  button scan  |  reset  |  reset all  ]", 1)
		if ZorlenConfig[ZORLEN_ZPN]["admin"] or ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUG] or ZorlenConfig[ZORLEN_ZPN][ZORLEN_FULLDEBUG] or Zorlen_DebugFlag or (msg == "debug options") or (msg == "debug help") then
			Zorlen_debug("   [  button scan on  |  button scan off  |  show buffs  |  show debuffs  ]", 1)
			Zorlen_debug("   [  debug  |  debug on  |  debug off  |  debug mode  ]", 1)
			Zorlen_debug("   [  debug temp  |  debug temp on  |  debug temp off  ]", 1)
			Zorlen_debug("   [  debug options  |  debug status  |  reloadui  |  debug reloadui  ]", 1)
			Zorlen_debug("   [  event log  |  clear event log  ]", 1)
		end
	end
	if (msg == "event log") or (msg == "eventlog") or (msg == "log") then
		if ZorlenConfig[ZORLEN_ZPN][ZORLEN_LOG_EVENTS] then
			ZorlenConfig[ZORLEN_ZPN][ZORLEN_LOG_EVENTS] = nil
			Zorlen_msg("Events are no longer being saved in the file:")
			Zorlen_msg("          \\World of Warcraft\\WTF\\Account\\ACCOUNTNAME\\SavedVariables\\Zorlen.lua")
		else
			if not ZorlenConfig[ZORLEN_EVENT_LOG] then
				ZorlenConfig[ZORLEN_EVENT_LOG] = {}
			end
			ZorlenConfig[ZORLEN_ZPN][ZORLEN_LOG_EVENTS] = true
			Zorlen_msg("Events are now being logged in the file:")
			Zorlen_msg("          \\World of Warcraft\\WTF\\Account\\ACCOUNTNAME\\SavedVariables\\Zorlen.lua")
		end
	end
	if (msg == "clear log") or (msg == "clearlog") or (msg == "cleareventlog") or (msg == "clear event log") then
		ZorlenConfig[ZORLEN_EVENT_LOG] = nil
		Zorlen_msg("Logged events have been cleared.")
	end
	if (msg == "reset") then
		ZorlenConfig[ZORLEN_ZPN] = nil
		ZorlenInitialized = nil
		Zorlen_CheckVariables()
		if not ZorlenConfig[ZORLEN_ZPN][ZORLEN_FOODOFF] then
			Zorlen_UpdateEatItemInfo()
			Zorlen_UpdateDrinkItemInfo()
		end
		if Zorlen_MakeFirstMacros then
			Zorlen_MakeMacros()
			Zorlen_MakeFirstMacros = nil
		end
		Zorlen_debug("Zorlen settings have been reset for "..UnitName("player"), 1)
	end
	if (msg == "resetall") or (msg == "reset all") then
		ZorlenConfig = nil
		ZorlenInitialized = nil
		Zorlen_CheckVariables()
		if not ZorlenConfig[ZORLEN_ZPN][ZORLEN_FOODOFF] then
			Zorlen_UpdateEatItemInfo()
			Zorlen_UpdateDrinkItemInfo()
		end
		if Zorlen_MakeFirstMacros then
			Zorlen_MakeMacros()
			Zorlen_MakeFirstMacros = nil
		end
		Zorlen_debug("Zorlen settings have been reset for all players", 1)
	end
	if (msg == "itemscan") then
		if Zorlen_isCurrentClassPriest or Zorlen_isCurrentClassDruid or Zorlen_isCurrentClassShaman or Zorlen_isCurrentClassPaladin or Zorlen_isCurrentClassWarlock then
			if ZorlenConfig[ZORLEN_ZPN][ZORLEN_ITEMSCANOFF] then
				Zorlen_debug("Equipped item scanning is enabled", 1)
				ZorlenConfig[ZORLEN_ZPN][ZORLEN_ITEMSCANOFF] = nil
			else
				Zorlen_debug("Equipped item scanning is disabled", 1)
				ZorlenConfig[ZORLEN_ZPN][ZORLEN_ITEMSCANOFF] = true
			end
		end
	end
	if (msg == "food") then
		Zorlen_debug("Valid options are:", 1)
		Zorlen_debug("   [  food scan on  |  food scan off  |  eat  |  drink  |  make food macros  ]", 1)
	elseif (msg == "food scan off") or (msg == "food off") then
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_FOODOFF] = true
		Zorlen_debug("Eat and Drink auto scanning disabled", 1)
	elseif (msg == "food scan on") or (msg == "food on") then
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_FOODOFF] = nil
		Zorlen_debug("Eat and Drink auto scanning enabled", 1)
	end
	if (msg == "version") or (msg == "ver") or (msg == "v") then
		if Zorlen_FileBuildCheck() then
			Zorlen_debug("Zorlen Functions Library Version: "..zorlen_version.."", 1)
		end
	end
	if (msg == "debug") then
		if ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUG] or Zorlen_DebugFlag then
			Zorlen_debug("Zorlen debug is disabled", 1)
			Zorlen_debug("Use (  /zorlen debug options  ) to see full list of options", 1)
			ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUG] = nil
			Zorlen_DebugFlag = nil
		else
			Zorlen_debug("Zorlen debug is enabled", 1)
			ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUG] = true
			Zorlen_DebugFlag = 1
		end
	end
	if (msg == "debug on") then
		Zorlen_DebugFlag = 1
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUG] = true
		Zorlen_debug("Zorlen debug is enabled", 1)
	end
	if (msg == "debug off") then
		Zorlen_DebugFlag = nil
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUG] = nil
		Zorlen_debug("Zorlen debug is disabled", 1)
		Zorlen_debug("Use (  /zorlen debug options  ) to see full list of options", 1)
	end
	if (msg == "debug temp") or (msg == "debug tmp") or (msg == "debug temporary") then
		if Zorlen_DebugFlag then
			Zorlen_DebugFlag = nil
			if ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUG] then
				Zorlen_debug("Zorlen debug is disabled for this session only", 1)
				Zorlen_debug("Zorlen debug will be enabled if you logout or reload the UI", 1)
			else
				Zorlen_debug("Zorlen debug is disabled", 1)
				Zorlen_debug("Use (  /zorlen debug options  ) to see full list of options", 1)
			end
		else 
			Zorlen_DebugFlag = 1
			if ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUG] then
				Zorlen_debug("Zorlen debug is enabled", 1)
			else
				Zorlen_debug("Zorlen debug is enabled for this session only", 1)
				Zorlen_debug("Zorlen debug will be disabled if you logout or reload the UI", 1)
			end
		end
	end
	if (msg == "debug temp on") or (msg == "debug tmp on") or (msg == "debug temporary on") then
		Zorlen_DebugFlag = 1
		if ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUG] then
			Zorlen_debug("Zorlen debug is enabled", 1)
		else
			Zorlen_debug("Zorlen debug is enabled for this session only", 1)
			Zorlen_debug("Zorlen debug will be disabled if you logout or reload the UI", 1)
		end
	end
	if (msg == "debug temp off") or (msg == "debug tmp off") or (msg == "debug temporary off") then
		Zorlen_DebugFlag = nil
		if ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUG] then
			Zorlen_debug("Zorlen debug is disabled for this session only", 1)
			Zorlen_debug("Zorlen debug will be enabled if you logout or reload the UI", 1)
		else
			Zorlen_debug("Zorlen debug is disabled", 1)
			Zorlen_debug("Use (  /zorlen debug options  ) to see full list of options", 1)
		end
	end
	if (msg == "debug mode") then
		if ZorlenConfig[ZORLEN_ZPN][ZORLEN_FULLDEBUG] then
			Zorlen_FullDebug = nil
			ZorlenConfig[ZORLEN_ZPN][ZORLEN_FULLDEBUG] = nil
			Zorlen_debug("Zorlen debug mode has been set to normal", 1)
		else
			Zorlen_FullDebug = 1
			ZorlenConfig[ZORLEN_ZPN][ZORLEN_FULLDEBUG] = true
			Zorlen_debug("Zorlen debug mode has been set to full", 1)
		end
	end
	if (msg == "debug full on") or (msg == "debug mode full on") or (msg == "debug full") or (msg == "debug mode full") then
		Zorlen_FullDebug = 1
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_FULLDEBUG] = true
		Zorlen_debug("Zorlen debug mode has been set to full", 1)
	end
	if (msg == "debug full off") or (msg == "debug mode full off") or (msg == "debug normal") or (msg == "debug normal on") or (msg == "debug mode normal") or (msg == "debug mode normal on") then
		Zorlen_FullDebug = nil
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_FULLDEBUG] = nil
		Zorlen_debug("Zorlen debug mode has been set to normal", 1)
	end
	if (msg == "debug reloadui") or (msg == "debug reload ui") or (msg == "debug reload") or (msg == "debug rl") or (msg == "debug rui") or (msg == "debug rlui") then
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUGRELOADUI] = true
		ReloadUI()
	end
	if (msg == "reloadui") or (msg == "reload ui") or (msg == "reload") or (msg == "rui") or (msg == "rl") or (msg == "rlui") then
		ReloadUI()
	end
	if (msg == "dodge") then
		if Zorlen_isCurrentClassHunter then
			if ZorlenConfig[ZORLEN_ZPN][ZORLEN_ZDS] then
				Zorlen_debug("Dodge sound is enabled", 1)
				ZorlenConfig[ZORLEN_ZPN][ZORLEN_ZDS] = nil
			else
				Zorlen_debug("Dodge sound is disabled", 1)
				ZorlenConfig[ZORLEN_ZPN][ZORLEN_ZDS] = true
			end
		else
			Zorlen_debug("This function is only for Hunters", 1)
		end
	end
	if (msg == "silent") or (msg == "silent on") or (msg == "dodge off") then
		if Zorlen_isCurrentClassHunter then
			Zorlen_debug("Dodge sound is disabled", 1)
			ZorlenConfig[ZORLEN_ZPN][ZORLEN_ZDS] = true
		else
			Zorlen_debug("This function is only for Hunters", 1)
		end
	end
	if (msg == "silent off") or (msg == "dodge on") then
		if Zorlen_isCurrentClassHunter then
			Zorlen_debug("Dodge sound is enabled", 1)
			ZorlenConfig[ZORLEN_ZPN][ZORLEN_ZDS] = nil
		else
			Zorlen_debug("This function is only for Hunters", 1)
		end
	end
	if (msg == "button scan") or (msg == "buttonscan") then
		Zorlen_Button_MaxRank = {}
		Zorlen_RegisterButtons(1)
	end
	if (msg == "button scan mode") or (msg == "buttonscan mode") then
		if ZorlenConfig[ZORLEN_ZPN][ZORLEN_AUTOBUTTONSCANOFF] then
			Zorlen_debug("Auto action bar button refresh scan is enabled", 1)
			ZorlenConfig[ZORLEN_ZPN][ZORLEN_AUTOBUTTONSCANOFF] = nil
		else
			Zorlen_debug("Auto action bar button refresh scan is disabled", 1)
			ZorlenConfig[ZORLEN_ZPN][ZORLEN_AUTOBUTTONSCANOFF] = true
		end
	end
	if (msg == "button scan off") or (msg == "buttonscan off") or (msg == "button scan mode off") or (msg == "buttonscan mode off") then
		Zorlen_debug("Auto action bar button refresh scan is disabled", 1)
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_AUTOBUTTONSCANOFF] = true
	end
	if (msg == "button scan on") or (msg == "buttonscan on") or (msg == "button scan mode on") or (msg == "buttonscan mode on") then
		Zorlen_debug("Auto action bar button refresh scan is enabled", 1)
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_AUTOBUTTONSCANOFF] = nil
	end
	if (msg == "status") or (msg == "show") or (msg == "debug status") or (msg == "debug show") then
		if Zorlen_FileBuildCheck() then
			Zorlen_debug("Zorlen "..zorlen_version.." Status:", 1)
		else
			Zorlen_debug("Zorlen Status:", 1)
		end
		if Zorlen_isCurrentClassHunter then
			if ZorlenConfig[ZORLEN_ZPN][ZORLEN_ZDS] then
				Zorlen_debug("-  Dodge sound is set to OFF", 1)
			else
				Zorlen_debug("-  Dodge sound is set to ON", 1)
			end
		end
		if Zorlen_isCurrentClassPriest or Zorlen_isCurrentClassDruid or Zorlen_isCurrentClassShaman or Zorlen_isCurrentClassPaladin or Zorlen_isCurrentClassWarlock then
			if ZorlenConfig[ZORLEN_ZPN][ZORLEN_ITEMSCANOFF] then
				Zorlen_debug("-  Equipped item scanning is set to OFF", 1)
			else
				Zorlen_debug("-  Equipped item scanning is set to ON", 1)
			end
		end
		if ZorlenConfig[ZORLEN_ZPN][ZORLEN_AUTOBUTTONSCANOFF] then
			Zorlen_debug("-  Auto action bar button refresh scan is set to OFF", 1)
		else
			Zorlen_debug("-  Auto action bar button refresh scan is set to ON", 1)
		end
		if ZorlenConfig[ZORLEN_ZPN][ZORLEN_FOODOFF] then
			Zorlen_debug("-  Eat and Drink auto scanning turned OFF", 1)
		else
			Zorlen_debug("-  Eat and Drink auto scanning turned ON", 1)
		end
		if ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUG] then
			if Zorlen_DebugFlag then
				Zorlen_debug("-  Debug is set to ON", 1)
			else
				Zorlen_debug("-  Debug is set to ON,   but has been turned off for this session only", 1)
			end
			if not ZorlenConfig[ZORLEN_ZPN][ZORLEN_FULLDEBUG] then
				Zorlen_debug("-  Debug mode is set to normal", 1)
			end
			if ZorlenConfig[ZORLEN_ZPN][ZORLEN_LOG_EVENTS] then
				Zorlen_msg("-  Event logging is set to ON")
			else
				Zorlen_msg("-  Event logging is set to OFF")
			end
		elseif Zorlen_DebugFlag then
			Zorlen_debug("-  Debug is set to OFF,   but has been turned on for this session only", 1)
			if not ZorlenConfig[ZORLEN_ZPN][ZORLEN_FULLDEBUG] then
				Zorlen_debug("-  Debug mode is set to normal", 1)
			end
			if ZorlenConfig[ZORLEN_ZPN][ZORLEN_LOG_EVENTS] then
				Zorlen_msg("-  Event logging is set to ON")
			else
				Zorlen_msg("-  Event logging is set to OFF")
			end
		elseif ZorlenConfig[ZORLEN_ZPN][ZORLEN_FULLDEBUG] or ((msg == "debug status") or (msg == "debug show")) then
			Zorlen_debug("-  Debug is set to OFF", 1)
			if not ZorlenConfig[ZORLEN_ZPN][ZORLEN_FULLDEBUG] then
				Zorlen_debug("-  Debug mode is set to normal", 1)
			end
			if ZorlenConfig[ZORLEN_ZPN][ZORLEN_LOG_EVENTS] then
				Zorlen_msg("-  Event logging is set to ON")
			else
				Zorlen_msg("-  Event logging is set to OFF")
			end
		elseif ZorlenConfig[ZORLEN_ZPN][ZORLEN_LOG_EVENTS] then
			Zorlen_msg("-  Event logging is set to ON")
		end
		if ZorlenConfig[ZORLEN_ZPN][ZORLEN_FULLDEBUG] then
			Zorlen_debug("-  Debug mode is set to full", 1)
		end
		if Zorlen_isCurrentClassWarlock then
			if Zorlen_ShardBagSize then
				Zorlen_debug("-  Soul Bag size detected as: "..Zorlen_ShardBagSize, 1)
			else
				Zorlen_debug("-  Soul Bag size not found!", 1)
			end
		end
	end
	if (msg == "buff") or (msg == "buffs") or (msg == "showbuffs") or (msg == "showallbuffs") or (msg == "show buffs") or (msg == "show all buffs") or (msg == "allbuffs") or (msg == "all buffs") then
		Zorlen_ShowAllBuffs()
	end
	if (msg == "debuff") or (msg == "debuffs") or (msg == "showdebuffs") or (msg == "showalldebuffs") or (msg == "show debuffs") or (msg == "show all debuffs") or (msg == "alldebuffs") or (msg == "all debuffs") then
		Zorlen_ShowAllDebuffs()
	end
	if (msg == "eat") or (msg == "food") or (msg == "bread") then
		Zorlen_Eat()
	end
	if (msg == "drink") or (msg == "water") then
		Zorlen_Drink()
	end
	if (msg == "food macro") or (msg == "make food macro") or (msg == "make food macros") or (msg == "makefoodmacro") or (msg == "makefoodmacros") or (msg == "foodmacro") then
		Zorlen_MakeEatMacro(1)
		Zorlen_MakeDrinkMacro(1)
	end
	if (msg == "eat macro") or (msg == "bread macro") or (msg == "eatmacro") or (msg == "breadmacro") or (msg == "make eat macro") or (msg == "make bread macro") or (msg == "makeeatmacro") or (msg == "makebreadmacro") then
		Zorlen_MakeEatMacro(1)
	end
	if (msg == "drink macro") or (msg == "water macro") or (msg == "drinkmacro") or (msg == "watermacro") or (msg == "make drink macro") or (msg == "make water macro") or (msg == "makedrinkmacro") or (msg == "makewatermacro") then
		Zorlen_MakeDrinkMacro(1)
	end
	if (msg == "macro") or (msg == "macros") or (msg == "make macro") or (msg == "make macros") or (msg == "makemacro") or (msg == "makemacros") or (msg == "make food macros") then
		Zorlen_MakeMacros()
	end
	if not Zorlen_FileBuildCheck() then
		Zorlen_debug("<<< Files that are not the same version have been detected in the Zorlen folder! >>>", 1)
	end
end

function Zorlen_ZorlenTargetSlashHandler(msg)
	if (msg == "") then
		Zorlen_TargetByName()
	else
		Zorlen_TargetByName(msg)
	end
end

function Zorlen_ZorlenChangeTargetSlashHandler(msg)
	if (msg == "") then
		Zorlen_changeTargetByName()
	else
		Zorlen_changeTargetByName(msg)
	end
end

function Zorlen_ZorlenClearTargetSlashHandler()
	Zorlen_clearTargetByName()
end

function Zorlen_ZorlenAssistSlashHandler(msg)
	if (msg == "") then
		Zorlen_assist()
	else
		Zorlen_assist(msg)
	end
end

function Zorlen_ZorlenChangeAssistSlashHandler(msg)
	if (msg == "") then
		Zorlen_changeAssist()
	else
		Zorlen_changeAssist(msg)
	end
end

function Zorlen_ZorlenClearAssistSlashHandler()
	Zorlen_clearAssist()
end





function Zorlen_Casting_timer_function()
	if Zorlen_Casting then
		Zorlen_debug("Casting Stop: from time out")
		Zorlen_SpellTimerSet()
		Zorlen_Casting = nil
		Zorlen_CastingSpellRank = 0
		Zorlen_CastingUnit = nil
		Zorlen_CastingNotUnitArray = nil
		Zorlen_CastingSpellTargetName = nil
		Zorlen_CastingSpellName = nil
		Zorlen_CastingSpellCastTime = 0
		Zorlen_Temp_CastingSpellTargetName = nil
		Zorlen_Temp_CastingSpellTargetIsMob = nil
		Zorlen_Temp_CastingSpellTargetIsBanished = nil
		Zorlen_Temp_CastingSpellName = nil
		Zorlen_Temp_CastingSpellRank = 0
		Zorlen_OtherCastingStopDone = 1
	end
end

function Zorlen_Channeling_timer_function()
	if Zorlen_Channeling then
		Zorlen_debug("Channeling Stop: from time out")
		Zorlen_Channeling = nil
		Zorlen_ChannelingSpellName = nil
		Zorlen_ChannelingSpellRank = nil
		Zorlen_Temp_CastingSpellTargetName = nil
		Zorlen_Temp_CastingSpellTargetIsMob = nil
		Zorlen_Temp_CastingSpellTargetIsBanished = nil
		Zorlen_Temp_CastingSpellName = nil
		Zorlen_Temp_CastingSpellRank = 0
	end
end

function Zorlen_InventoryScan_timer_function()
	if Zorlen_isCurrentClassWarlock then
		Zorlen_InventoryScan(nil,1)
	elseif Zorlen_isCurrentClassPriest or Zorlen_isCurrentClassDruid or Zorlen_isCurrentClassShaman or Zorlen_isCurrentClassPaladin then
		Zorlen_InventoryScan(1)
	end
end

function Zorlen_BagScan_timer_function()
	Zorlen_UpdateEatItemInfo()
	Zorlen_UpdateDrinkItemInfo()
end

function Zorlen_ACTIONBAR_HIDEGRID_timer_function()
	if not ZorlenConfig[ZORLEN_ZPN][ZORLEN_AUTOBUTTONSCANOFF] then
		Zorlen_RegisterButtons()
	end
	if Zorlen_isCurrentClassWarlock then
		Zorlen_SetShardBagSize()
	end
end

function Zorlen_EnteringWorld_timer_function()
	if not ZorlenConfig[ZORLEN_ZPN][ZORLEN_FOODOFF] then
		Zorlen_UpdateEatItemInfo()
		Zorlen_UpdateDrinkItemInfo()
	end
	if Zorlen_isCurrentClassWarlock then
		Zorlen_InventoryScan(nil,1)
	elseif Zorlen_isCurrentClassPriest or Zorlen_isCurrentClassDruid or Zorlen_isCurrentClassShaman or Zorlen_isCurrentClassPaladin then
		Zorlen_InventoryScan(1)
	end
	Zorlen_Button_MaxRank = {}
	Zorlen_RegisterButtons()
	if Zorlen_isCurrentClassWarlock then
		Zorlen_SetShardBagSize()
	end
	if Zorlen_MakeFirstMacros then
		Zorlen_MakeMacros()
		Zorlen_MakeFirstMacros = nil
	end
end

function Zorlen_OnUpdate(arg1)
	local TimerRunDown = Zorlen_OnUpdate_TimerRunDown(arg1)
	if TimerRunDown then
		if Zorlen_IsTimer("InventoryScan_timer", nil, "InternalZorlenMiscTimer") then
			Zorlen_ClearTimer("ACTIONBAR_HIDEGRID_timer", nil, "InternalZorlenMiscTimer")
			Zorlen_ClearTimer("BagScan_timer", nil, "InternalZorlenMiscTimer")
		end
		if Zorlen_IsTimer("BagScan_timer", nil, "InternalZorlenMiscTimer") then
			if Zorlen_IsTimer("AimedShotRotationWindow", nil, "InternalZorlenMiscTimer") or Zorlen_GetTimer("BagUpdateInCombat", nil, "InternalZorlenMiscTimer") >= 0.5 then
				Zorlen_ClearTimer("BagScan_timer", nil, "InternalZorlenMiscTimer")
				Zorlen_ClearTimer("BagUpdateInCombat", nil, "InternalZorlenMiscTimer")
				Zorlen_EatUpdateBlocked = 1
				Zorlen_DrinkUpdateBlocked = 1
			end
		end
	end
	if Zorlen_isCurrentClassHunter then
		Zorlen_Hunter_OnUpdate()
	elseif Zorlen_isCurrentClassWarrior then
		Zorlen_Warrior_OnUpdate(TimerRunDown)
	end
	Zorlen_MovingUpdate()
end

function Zorlen_OnUpdate_TimerRunDown(arg1)
	local counter = 1
	local found = false
	while Zorlen_Timer.FullName[counter] do
		if Zorlen_Timer.Seconds[Zorlen_Timer.FullName[counter]] then
			if not found then
				found = true
			end
			Zorlen_Timer.Seconds[Zorlen_Timer.FullName[counter]] = Zorlen_Timer.Seconds[Zorlen_Timer.FullName[counter]] - arg1
			if Zorlen_Timer.Seconds[Zorlen_Timer.FullName[counter]] <= 0 then
				if Zorlen_Timer.TimerTimer[Zorlen_Timer.FullName[counter]] then
					if Zorlen_DebugFlag then
						if Zorlen_Timer.Tag[counter] ~= "" and not string.find(Zorlen_Timer.Tag[counter], "InternalZorlen") then
							if Zorlen_Timer.Pre[counter] ~= "" then
								Zorlen_debug("Pre Timer Expired:  '"..Zorlen_Timer.Tag[counter].."'  '"..Zorlen_Timer.Pre[counter].."'  '"..Zorlen_Timer.Name[counter].."'", Zorlen_Timer.Show[counter])
							else
								Zorlen_debug("Pre Timer Expired:  '"..Zorlen_Timer.Tag[counter].."'  '"..Zorlen_Timer.Name[counter].."'", Zorlen_Timer.Show[counter])
							end
						else
							if Zorlen_Timer.Pre[counter] ~= "" then
								Zorlen_debug("Pre Timer Expired:  '"..Zorlen_Timer.Pre[counter].."'  '"..Zorlen_Timer.Name[counter].."'", Zorlen_Timer.Show[counter])
							else
								Zorlen_debug("Pre Timer Expired:  '"..Zorlen_Timer.Name[counter].."'", Zorlen_Timer.Show[counter])
							end
						end
					end
					local a = (Zorlen_Timer.TimerTimer[Zorlen_Timer.FullName[counter]][1] + Zorlen_Timer.Seconds[Zorlen_Timer.FullName[counter]])
					local b = Zorlen_Timer.TimerTimer[Zorlen_Timer.FullName[counter]][2]
					local c = Zorlen_Timer.TimerTimer[Zorlen_Timer.FullName[counter]][3]
					local d = Zorlen_Timer.TimerTimer[Zorlen_Timer.FullName[counter]][4]
					local e = Zorlen_Timer.TimerTimer[Zorlen_Timer.FullName[counter]][5]
					local f = Zorlen_Timer.TimerTimer[Zorlen_Timer.FullName[counter]][6]
					Zorlen_Timer.Seconds[Zorlen_Timer.FullName[counter]] = nil
					Zorlen_SetTimer(a, b, c, d, e, f)
					Zorlen_AfterPreSpellCancelTimers(b, c, d)
				else
					if Zorlen_DebugFlag then
						if Zorlen_Timer.Tag[counter] ~= "" and not string.find(Zorlen_Timer.Tag[counter], "InternalZorlen") then
							if Zorlen_Timer.Pre[counter] ~= "" then
								Zorlen_debug("Timer Expired:  '"..Zorlen_Timer.Tag[counter].."'  '"..Zorlen_Timer.Pre[counter].."'  '"..Zorlen_Timer.Name[counter].."'", Zorlen_Timer.Show[counter])
							else
								Zorlen_debug("Timer Expired:  '"..Zorlen_Timer.Tag[counter].."'  '"..Zorlen_Timer.Name[counter].."'", Zorlen_Timer.Show[counter])
							end
						else
							if Zorlen_Timer.Pre[counter] ~= "" then
								Zorlen_debug("Timer Expired:  '"..Zorlen_Timer.Pre[counter].."'  '"..Zorlen_Timer.Name[counter].."'", Zorlen_Timer.Show[counter])
							else
								Zorlen_debug("Timer Expired:  '"..Zorlen_Timer.Name[counter].."'", Zorlen_Timer.Show[counter])
							end
						end
					end
					Zorlen_Timer.Seconds[Zorlen_Timer.FullName[counter]] = nil
					if type(Zorlen_Timer.RunFunction[counter]) == "function" then
						Zorlen_Timer.RunFunction[counter]()
					end
				end
			end
		end
		counter = counter + 1
	end
	return found
end

function Zorlen_AllTimersAreExpired(counter)
	local c = counter or 1
	while Zorlen_Timer.FullName[c] do
		if Zorlen_Timer.Seconds[Zorlen_Timer.FullName[c]] then
			return false, c
		end
		c = c + 1
	end
	return true
end

function Zorlen_WipeAllTimers(counter)
	local c = counter or 1
	while Zorlen_Timer.FullName[c] do
		Zorlen_Timer.Seconds[Zorlen_Timer.FullName[c]] = nil
		Zorlen_Timer.Slot[Zorlen_Timer.FullName[c]] = nil
		Zorlen_Timer.TimerTimer[Zorlen_Timer.FullName[c]] = nil
		Zorlen_Timer.Pre[c] = nil
		Zorlen_Timer.Name[c] = nil
		Zorlen_Timer.Tag[c] = nil
		Zorlen_Timer.Show[c] = nil
		Zorlen_Timer.RunFunction[c] = nil
		Zorlen_Timer.FullName[c] = nil
		c = c + 1
	end
end

--Monitor combat status ourselves since the built in variables cannot be 
--trusted for some reason. 
function Zorlen_OnEvent(event, arg1, arg2, arg3)
	Zorlen_EventsDebug(event, arg1, arg2, arg3, 2)
	if (event == "PLAYER_REGEN_DISABLED") then
			---------------------------
			
			Zorlen_Combat = 1
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "PLAYER_REGEN_ENABLED") then
			---------------------------
			
			Zorlen_Combat = nil
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "PLAYER_ENTER_COMBAT") then
			---------------------------
			
			Zorlen_Melee = 1
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "PLAYER_LEAVE_COMBAT") then
			---------------------------
			
			Zorlen_Melee = nil
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "PET_ATTACK_START") then
			---------------------------
			
			Zorlen_PetCombat = 1
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "PET_ATTACK_STOP") then
			---------------------------
			
			Zorlen_PetCombat = nil
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "BAG_UPDATE") then
			---------------------------
			
			if not ZorlenConfig[ZORLEN_ZPN][ZORLEN_FOODOFF] then
				if Zorlen_Combat then
					Zorlen_SetTimer(1, "BagUpdateInCombat", nil, "InternalZorlenMiscTimer", 2)
				end
				Zorlen_SetTimer(1, "BagScan_timer", nil, "InternalZorlenMiscTimer", 2, Zorlen_BagScan_timer_function)
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES") then
			---------------------------
			
			if Zorlen_isCurrentClassHunter then
					Zorlen_Hunter_OnEvent_CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES(arg1, arg2, arg3)
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "VARIABLES_LOADED") then
			---------------------------
			
			Zorlen_VariablesLoaded = true
			Zorlen_CheckVariables()
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "START_AUTOREPEAT_SPELL") then
			---------------------------
			
			Zorlen_AutoShoot = 1
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "STOP_AUTOREPEAT_SPELL") then
			---------------------------
			
			Zorlen_AutoShoot = nil
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "UPDATE_BONUS_ACTIONBAR") then
			---------------------------
			
			if Zorlen_isCurrentClassWarrior then
					Zorlen_Warrior_OnEvent_UPDATE_BONUS_ACTIONBAR()
			elseif Zorlen_isCurrentClassDruid then
					Zorlen_Druid_OnEvent_UPDATE_BONUS_ACTIONBAR()
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("PLAYER_LOGIN")) then
			---------------------------
			
			
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("PLAYER_ENTERING_WORLD")) then
			---------------------------
			
			Zorlen_CheckVariables()
			Zorlen_SetTimer(2, "EnteringWorld", nil, "InternalZorlenMiscTimer", 2, Zorlen_EnteringWorld_timer_function)
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("PLAYER_LEAVING_WORLD")) then
			---------------------------
			
			
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("UNIT_INVENTORY_CHANGED")) then
			---------------------------
			
			if not ZorlenConfig[ZORLEN_ZPN][ZORLEN_ITEMSCANOFF] and UnitIsUnit("player", arg1) then
				Zorlen_SetTimer(1, "InventoryScan_timer", nil, "InternalZorlenMiscTimer", 2, Zorlen_InventoryScan_timer_function)
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("LEARNED_SPELL_IN_TAB")) then
			---------------------------
			
			Zorlen_Button_MaxRank = {}
			Zorlen_RegisterButtons()
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("ACTIONBAR_HIDEGRID")) then
			---------------------------
			
			Zorlen_SetTimer(1, "ACTIONBAR_HIDEGRID_timer", nil, "InternalZorlenMiscTimer", 2, Zorlen_ACTIONBAR_HIDEGRID_timer_function)
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("PLAYER_TARGET_CHANGED")) then
			---------------------------
			
			Zorlen_DebuffTimer_OnEvent_PLAYER_TARGET_CHANGED()
			if Zorlen_isCurrentClassHunter then
					Zorlen_Hunter_OnEvent_PLAYER_TARGET_CHANGED()
			elseif Zorlen_isCurrentClassWarlock then
					Zorlen_Warlock_OnEvent_PLAYER_TARGET_CHANGED()
			elseif Zorlen_isCurrentClassWarrior then
					Zorlen_Warrior_OnEvent_PLAYER_TARGET_CHANGED()
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "CHAT_MSG_COMBAT_SELF_MISSES") then
			---------------------------
			
			if Zorlen_isCurrentClassWarrior then
					Zorlen_Warrior_OnEvent_CHAT_MSG_COMBAT_SELF_MISSES(arg1, arg2, arg3)
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "CHAT_MSG_SPELL_SELF_DAMAGE") then
			---------------------------
			local hit = nil
			local immune = nil
			for index,value in LOCALIZATION_ZORLEN.HitsOrCritsArray do
				if string.find(arg1, value) then
					hit = index
					break
				end
			end
			local failed = (not hit)
			if failed then
				for index,value in LOCALIZATION_ZORLEN.ImmuneArray do
					if string.find(arg1, value) then
						immune = index
						break
					end
				end
				if immune and not ZorlenConfig[ZORLEN_ZPN][ZORLEN_AUTOMOBIMMUNEOFF] and Zorlen_LastCastingSpellTargetIsMob and not Zorlen_LastCastingSpellTargetIsBanished and Zorlen_LastCastingSpellName and Zorlen_LastCastingSpellTargetName then
					if string.find(arg1, Zorlen_gsub(LOCALIZATION_ZORLEN.ImmuneArray[immune], "%(%.%+%)", Zorlen_LastCastingSpellName, "%(%.%*%)", Zorlen_LastCastingSpellTargetName)) then
						if not ZorlenConfig[ZORLEN_ZPN]["Immune"][Zorlen_LastCastingSpellName] then
							ZorlenConfig[ZORLEN_ZPN]["Immune"][Zorlen_LastCastingSpellName] = {}
						end
						if not ZorlenConfig[ZORLEN_ZPN]["Immune"][Zorlen_LastCastingSpellName][Zorlen_LastCastingSpellTargetName] and (not UnitAffectingCombat("target") or UnitExists("targettarget")) and Zorlen_LastCastingSpellTargetName == UnitName("target") then
							ZorlenConfig[ZORLEN_ZPN]["Immune"][Zorlen_LastCastingSpellName][Zorlen_LastCastingSpellTargetName] = "yes"
							Zorlen_msg(Zorlen_LastCastingSpellTargetName.." is immune to "..Zorlen_LastCastingSpellName.."!")
							Zorlen_msg("This will be saved in the Zorlen immunity database.")
						end
					end
				end
			end
			if Zorlen_LastCastingSpellName and failed then
				Zorlen_debug(arg1)
				if string.find(arg1, Zorlen_LastCastingSpellName) then
					if Zorlen_LastCastingSpellTargetName then
						Zorlen_ClearTimer(Zorlen_LastCastingSpellName, Zorlen_LastCastingSpellTargetName, "InternalZorlenSpellCastDelay")
						Zorlen_ClearTimer(Zorlen_LastCastingSpellName, Zorlen_LastCastingSpellTargetName, "InternalZorlenSpellTimers", 1)
					end
					Zorlen_ClearTimer(Zorlen_LastCastingSpellName, nil, "InternalZorlenSpellCastDelay")
					Zorlen_ClearTimer(Zorlen_LastCastingSpellName, nil, "InternalZorlenSpellTimers", 1)
				end
			end
			if Zorlen_isCurrentClassHunter then
				Zorlen_Hunter_OnEvent_CHAT_MSG_SPELL_SELF_DAMAGE(arg1, arg2, arg3, Zorlen_LastCastingSpellTargetName, failed, immune, hit)
			elseif Zorlen_isCurrentClassWarrior then
				Zorlen_Warrior_OnEvent_CHAT_MSG_SPELL_SELF_DAMAGE(arg1, arg2, arg3, Zorlen_LastCastingSpellTargetName, failed, immune, hit)
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == "CHAT_MSG_SPELL_FAILED_LOCALPLAYER") then
			---------------------------
			
			if Zorlen_isCurrentClassWarrior then
				Zorlen_Warrior_OnEvent_CHAT_MSG_SPELL_FAILED_LOCALPLAYER(arg1, arg2, arg3)
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("SPELLCAST_START")) then
			---------------------------
			
			Zorlen_Casting = 1
			Zorlen_CastingSpellRank = Zorlen_Temp_CastingSpellRank
			Zorlen_CastingSpellTargetName = Zorlen_Temp_CastingSpellTargetName
			Zorlen_CastingSpellName = arg1
			Zorlen_LastCastingSpellTargetIsMob = Zorlen_Temp_CastingSpellTargetIsMob
			Zorlen_LastCastingSpellTargetIsBanished = Zorlen_Temp_CastingSpellTargetIsBanished
			Zorlen_LastCastingSpellName = arg1
			Zorlen_LastCastingSpellTargetName = Zorlen_CastingSpellTargetName
			Zorlen_CastingSpellCastTime = arg2 / 1000
			if Zorlen_CastingSpellName and Zorlen_CastingSpellRank > 0 then
				Zorlen_debug("Casting Start:   "..Zorlen_CastingSpellName.."("..LOCALIZATION_ZORLEN.Rank.." "..Zorlen_CastingSpellRank..")")
			elseif Zorlen_CastingSpellName then
				Zorlen_debug("Casting Start:   "..Zorlen_CastingSpellName)
			else
				Zorlen_debug("Casting Start")
			end
			Zorlen_SetTimer(Zorlen_CastingSpellCastTime, "Casting_timer", nil, "InternalZorlenMiscTimer", 2, Zorlen_Casting_timer_function)
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("SPELLCAST_CHANNEL_START")) then
			---------------------------
			
			Zorlen_Channeling = 1
			local ChannelingTime = arg1 / 1000
			Zorlen_ChannelingSpellName = Zorlen_Temp_CastingSpellName
			Zorlen_ChannelingSpellRank = Zorlen_Temp_CastingSpellRank
			if Zorlen_ChannelingSpellName and Zorlen_ChannelingSpellRank then
				Zorlen_debug("Channeling Start:   "..Zorlen_ChannelingSpellName.."("..LOCALIZATION_ZORLEN.Rank.." "..Zorlen_ChannelingSpellRank..")")
			elseif Zorlen_ChannelingSpellName then
				Zorlen_debug("Channeling Start:   "..Zorlen_ChannelingSpellName)
			else
				Zorlen_debug("Channeling Start")
			end
			Zorlen_SetTimer(ChannelingTime, "Channeling_timer", nil, "InternalZorlenMiscTimer", 2, Zorlen_Channeling_timer_function)
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("SPELLCAST_CHANNEL_UPDATE")) then
			---------------------------
			
			if Zorlen_IsTimer("Channeling_timer", nil, "InternalZorlenMiscTimer") then
				local ChannelingTime = arg1 / 1000
				Zorlen_SetTimer(ChannelingTime, "Channeling_timer", nil, "InternalZorlenMiscTimer", 2, Zorlen_Channeling_timer_function)
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("SPELLCAST_DELAYED")) then
			---------------------------
			
			local CastingTime = Zorlen_GetTimer("Casting_timer", nil, "InternalZorlenMiscTimer") + (arg1 / 1000)
			Zorlen_SetTimer(CastingTime, "Casting_timer", nil, "InternalZorlenMiscTimer", 2, Zorlen_Casting_timer_function)
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("SPELLCAST_CHANNEL_STOP")) then
			---------------------------
			
			if Zorlen_Channeling then
				Zorlen_debug("Channeling Stop")
				Zorlen_Channeling = nil
				Zorlen_ChannelingSpellName = nil
				Zorlen_ChannelingSpellRank = nil
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("SPELLCAST_STOP")) then
			---------------------------
			
			if Zorlen_Casting then
				Zorlen_debug("Casting Stop")
				Zorlen_SpellTimerSet()
				Zorlen_Casting = nil
			elseif not Zorlen_Channeling and not Zorlen_OtherCastingStopDone then
				Zorlen_CastingSpellName = Zorlen_Temp_CastingSpellName
				if Zorlen_CastingSpellName then
					if Zorlen_CastingSpellCastTime == 0 then
						Zorlen_CastingSpellRank = Zorlen_Temp_CastingSpellRank
						Zorlen_CastingSpellTargetName = Zorlen_Temp_CastingSpellTargetName
						if Zorlen_CastingSpellTargetName then
							Zorlen_LastCastingSpellName = Zorlen_CastingSpellName
							Zorlen_LastCastingSpellTargetName = Zorlen_CastingSpellTargetName
							Zorlen_LastCastingSpellTargetIsMob = Zorlen_Temp_CastingSpellTargetIsMob
							Zorlen_LastCastingSpellTargetIsBanished = Zorlen_Temp_CastingSpellTargetIsBanished
							Zorlen_SpellTimerSet()
						end
					end
				else
					Zorlen_LastCastingSpellName = nil
					Zorlen_LastCastingSpellTargetName = nil
					Zorlen_LastCastingSpellTargetIsMob = nil
					Zorlen_LastCastingSpellTargetIsBanished = nil
					if Zorlen_isCurrentClassHunter then
						Zorlen_debug(LOCALIZATION_ZORLEN.AutoShot)
						Zorlen_SetTimer(0.5, "AimedShotRotationWindow", nil, "InternalZorlenMiscTimer", 2)
					end
				end
			end
			Zorlen_OtherCastingStopDone = nil
			Zorlen_CastingSpellRank = 0
			Zorlen_CastingUnit = nil
			Zorlen_CastingNotUnitArray = nil
			Zorlen_CastingSpellTargetName = nil
			Zorlen_CastingSpellName = nil
			Zorlen_CastingSpellCastTime = 0
			Zorlen_Temp_CastingSpellTargetName = nil
			Zorlen_Temp_CastingSpellTargetIsMob = nil
			Zorlen_Temp_CastingSpellTargetIsBanished = nil
			Zorlen_Temp_CastingSpellName = nil
			Zorlen_Temp_CastingSpellRank = 0
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("SPELLCAST_INTERRUPTED")) then
			---------------------------
			
			if not Zorlen_Casting and not Zorlen_Channeling then
				Zorlen_debug("Casting or Channeling Stop: from interruption")
			end
			if Zorlen_Channeling then
				Zorlen_debug("Channeling Stop: from interruption")
				Zorlen_Channeling = nil
			end
			if Zorlen_Casting then
				Zorlen_debug("Casting Stop: from interruption")
				Zorlen_Casting = nil
			end
			if Zorlen_LastCastingSpellName then
				if Zorlen_LastCastingSpellTargetName then
					Zorlen_ClearTimer(Zorlen_LastCastingSpellName, Zorlen_LastCastingSpellTargetName, "InternalZorlenSpellCastDelay")
					Zorlen_ClearTimer(Zorlen_LastCastingSpellName, Zorlen_LastCastingSpellTargetName, "InternalZorlenSpellTimers", 1)
				end
				Zorlen_ClearTimer(Zorlen_LastCastingSpellName, nil, "InternalZorlenSpellCastDelay")
				Zorlen_ClearTimer(Zorlen_LastCastingSpellName, nil, "InternalZorlenSpellTimers", 1)
			end
			Zorlen_ChannelingSpellName = nil
			Zorlen_ChannelingSpellRank = nil
			Zorlen_CastingSpellTargetName = nil
			Zorlen_CastingSpellName = nil
			Zorlen_CastingSpellCastTime = 0
			Zorlen_CastingSpellRank = 0
			Zorlen_CastingUnit = nil
			Zorlen_CastingNotUnitArray = nil
			Zorlen_Temp_CastingSpellTargetName = nil
			Zorlen_Temp_CastingSpellTargetIsMob = nil
			Zorlen_Temp_CastingSpellTargetIsBanished = nil
			Zorlen_Temp_CastingSpellName = nil
			Zorlen_Temp_CastingSpellRank = 0
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("SPELLCAST_FAILED")) then
			---------------------------
			
			if Zorlen_Channeling then
				Zorlen_debug("Channeling Stop: from failed cast")
				Zorlen_Channeling = nil
			end
			if Zorlen_Casting then
				Zorlen_debug("Casting Stop: from failed cast")
				Zorlen_Casting = nil
			end
			if Zorlen_isCurrentClassWarrior then
				if Zorlen_castBerserkerRageSwap_SwapStart then
					Zorlen_SetTimer(30, "castBerserkerRageSwap_SwapWindow", nil, "InternalZorlenMiscTimer", 2, Zorlen_castBerserkerRageSwap_SwapWindow_timer_function)
				end
			end
			Zorlen_CastingUnit = nil
			Zorlen_CastingNotUnitArray = nil
			Zorlen_Temp_CastingSpellTargetName = nil
			Zorlen_Temp_CastingSpellTargetIsMob = nil
			Zorlen_Temp_CastingSpellTargetIsBanished = nil
			Zorlen_Temp_CastingSpellName = nil
			Zorlen_Temp_CastingSpellRank = 0
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("UI_ERROR_MESSAGE")) then
			---------------------------
			
			if Zorlen_isCurrentClassHunter then
				Zorlen_Hunter_OnEvent_UI_ERROR_MESSAGE(arg1, arg2, arg3)
			end
			
			--------------------------------------------------------------------------------------------------------
	elseif (event == ("CHAT_MSG_COMBAT_HOSTILE_DEATH")) then
			---------------------------
			
			Zorlen_DebuffTimer_OnEvent_CHAT_MSG_COMBAT_HOSTILE_DEATH(arg1, arg2, arg3)
			
			--------------------------------------------------------------------------------------------------------
	end
end


function Zorlen_gsub(firststring, findstring1, replacestring1, findstring2, replacestring2)
	if firststring and findstring1 and replacestring1 and (not findstring2 or replacestring2) then
		firststring = string.gsub(firststring, findstring1, replacestring1)
		if findstring2 then
			firststring = string.gsub(firststring, findstring2, replacestring2)
		end
		return firststring
	end
	return "123 Zorlen: Required Strings Not Included 456"
end


function Zorlen_DebuffTimer_OnEvent_PLAYER_TARGET_CHANGED()
	local counter = 1
	while Zorlen_Timer.FullName[counter] do
		if (Zorlen_Timer.Tag[counter] == "InternalZorlenSpellTimers" or Zorlen_Timer.Tag[counter] == "InternalZorlenSpellCastDelay") and Zorlen_Timer.Pre[counter] == "" then
			Zorlen_ClearTimer(Zorlen_Timer.FullName[counter])
		end
		counter = counter + 1
	end
end

function Zorlen_DebuffTimer_OnEvent_CHAT_MSG_COMBAT_HOSTILE_DEATH(arg1, arg2, arg3)
	local counter = 1
	while Zorlen_Timer.FullName[counter] do
		if Zorlen_Timer.Tag[counter] == "InternalZorlenSpellTimers" then
			if Zorlen_Timer.Pre[counter] ~= "" and string.find(arg1, Zorlen_gsub(LOCALIZATION_ZORLEN.EnemyDies, "%(%.%*%)", Zorlen_Timer.Pre[counter])) then
				if UnitName("target") ~= Zorlen_Timer.Pre[counter] or UnitHealth("target") == 0 then
					Zorlen_ClearTimer(Zorlen_Timer.FullName[counter])
				end
			end
		end
		counter = counter + 1
	end
end

function Zorlen_CheckVariables()
	if not Zorlen_VariablesLoaded then
		return false
	end
	if ZorlenInitialized then
		return true
	end
	if not ZORLEN_ZPN then
		ZORLEN_ZPN = UnitName("player")
		if not ZORLEN_ZPN then
			--Character name not available yet
			return false
		else 
			ZORLEN_ZPN = GetCVar("realmName").."."..ZORLEN_ZPN
		end
	end
	--Build our variable table
	if not ZorlenConfig then
		ZorlenConfig = {}
	end
	--Initialize the array for this character
	if not ZorlenConfig[ZORLEN_ZPN] then
		ZorlenConfig[ZORLEN_ZPN] = {}
		if Zorlen_isCurrentClassHunter then
			ZorlenConfig[ZORLEN_ZPN][ZORLEN_ZDS] = true
		end
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_ASSIST] = nil
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_TARGETBYNAME] = nil
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUG] = nil
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_FULLDEBUG] = nil
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUGRELOADUI] = nil
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_PETISDEAD] = nil
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_AUTOBUTTONSCANOFF] = nil
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_FOODOFF] = true
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_ITEMSCANOFF] = nil
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_LOG_EVENTS] = nil
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_AUTOMOBIMMUNEOFF] = nil
		Zorlen_MakeFirstMacros = 1
	end
	if ZorlenConfig[ZORLEN_ZPN][ZORLEN_LOG_EVENTS] and not ZorlenConfig[ZORLEN_EVENT_LOG] then
		ZorlenConfig[ZORLEN_EVENT_LOG] = {}
	end
	if not ZorlenConfig[ZORLEN_ZPN]["Immune"] then
		ZorlenConfig[ZORLEN_ZPN]["Immune"] = {}
	end
	if not ZorlenConfig[ZORLEN_ZPN]["ImmuneIgnore"] then
		ZorlenConfig[ZORLEN_ZPN]["ImmuneIgnore"] = {}
	end
	if ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUG] then
		Zorlen_DebugFlag = 1
	end
	if ZorlenConfig[ZORLEN_ZPN][ZORLEN_FULLDEBUG] then
		Zorlen_FullDebug = 1
	end
	if ZorlenConfig[ZORLEN_ZPN][ZORLEN_PETISDEAD] then
		Zorlen_PetIsDead = 1
	end
	if ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUGRELOADUI] then
		Zorlen_DebugFlag = 1
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUGRELOADUI] = nil
	end
	ZorlenInitialized = true
	return true
end

function Zorlen_isImmune(SpellName, TargetName)
	if ZorlenConfig[ZORLEN_ZPN][ZORLEN_AUTOMOBIMMUNEOFF] or UnitPlayerControlled("target") then
		return false
	end
	local TargetName = TargetName or UnitName("target")
	if TargetName and TargetName ~= "" then
		if ZorlenConfig[ZORLEN_ZPN]["ImmuneIgnore"][TargetName] then
			return false
		elseif SpellName and SpellName ~= "" then
			if ZorlenConfig[ZORLEN_ZPN]["Immune"][SpellName] and ZorlenConfig[ZORLEN_ZPN]["Immune"][SpellName][TargetName] == "yes" then
				return true
			end
		end
	end
	return false
end


local Zorlen_PopList = {}
local GlobalDD;

function ZorlenPopulateDD()
	UIDropDownMenu_ClearAll(ZorlenOptionsFrame_ImmuneIgnoreList)
	UIDropDownMenu_Initialize(ZorlenOptionsFrame_ImmuneIgnoreList, ZorlenMakeDropDownMenuButtons);
end

function ZorlenMakeDropDownMenuButtons()
	local i = 0;
	local info = {};
	for name,value in Zorlen_PopList do
		info = {};
		info.text = name
		info.func = function()
			UIDropDownMenu_SetSelectedID(ZorlenOptionsFrame_ImmuneIgnoreList, this:GetID(), 0);
		end
		UIDropDownMenu_AddButton(info);
	end	
end

function ZorlenAddToImmuneIgnoreList(TargetName)
	local name = ZorlenOptionsFrame_AddImmuneIgnore:GetText() or TargetName
	if not name or name == "" then
		name = TargetName
	end
	if name and name ~= "" and not Zorlen_PopList[name] then
		local counter = 0
		for name,value in Zorlen_PopList do
			counter = counter + 1
		end
		if counter < 32 then
			Zorlen_PopList[name] = true
			ZorlenOptionsFrame_AddImmuneIgnore:SetText("")
			UIDropDownMenu_ClearAll(ZorlenOptionsFrame_ImmuneIgnoreList)
			ZorlenPopulateDD()
			ZorlenOptionsFrame_ImmuneIgnoreRemoveButton:Show()
		end
	else
		ZorlenOptionsFrame_AddImmuneIgnore:SetText("")
	end
end

function ZorlenRemoveFromImmuneIgnoreList()
	local name = UIDropDownMenu_GetText(ZorlenOptionsFrame_ImmuneIgnoreList)
	if name and name ~= "" then
		Zorlen_PopList[name] = nil
	end
	local counter = 0
	for name,value in Zorlen_PopList do
		counter = counter + 1
	end
	if counter == 0 then
		ZorlenOptionsFrame_ImmuneIgnoreRemoveButton:Hide()
	end
	ZorlenPopulateDD()
	
end


function Zorlen_LoadOptionsFrameSettings()
	Zorlen_PopList = {}
	local counter = 0
	for name,value in ZorlenConfig[ZORLEN_ZPN]["ImmuneIgnore"] do
		Zorlen_PopList[name] = value
		counter = counter + 1
	end
	if counter > 0 then
		ZorlenOptionsFrame_ImmuneIgnoreRemoveButton:Show()
	else
		ZorlenOptionsFrame_ImmuneIgnoreRemoveButton:Hide()
	end
	ZorlenPopulateDD()
	if ZorlenConfig[ZORLEN_ZPN]["admin"] or ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUG] or ZorlenConfig[ZORLEN_ZPN][ZORLEN_FULLDEBUG] or Zorlen_DebugFlag then
		ZorlenOptionsFrame_Debug:Show()
		ZorlenOptionsFrame_FullDebug:Show()
		ZorlenOptionsFrame_LogEvents:Show()
	elseif ZorlenConfig[ZORLEN_ZPN][ZORLEN_LOG_EVENTS] then
		ZorlenOptionsFrame_LogEvents:Show()
	end
	if Zorlen_isCurrentClassHunter then
		ZorlenOptionsFrame_DodgeSound:Show()
	elseif Zorlen_isCurrentClassPriest or Zorlen_isCurrentClassDruid or Zorlen_isCurrentClassShaman or Zorlen_isCurrentClassPaladin or Zorlen_isCurrentClassWarlock then
		ZorlenOptionsFrame_AutoItemScan:Show()
	end
	local dodgesound = (not ZorlenConfig[ZORLEN_ZPN][ZORLEN_ZDS])
	ZorlenOptionsFrame_DodgeSound:SetChecked(dodgesound)
	local assist = ZorlenConfig[ZORLEN_ZPN][ZORLEN_ASSIST] or ""
	ZorlenOptionsFrame_AssistName:SetText(assist)
	local target = ZorlenConfig[ZORLEN_ZPN][ZORLEN_TARGETBYNAME] or ""
	ZorlenOptionsFrame_TargetByName:SetText(target)
	ZorlenOptionsFrame_Debug:SetChecked(ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUG])
	ZorlenOptionsFrame_FullDebug:SetChecked(ZorlenConfig[ZORLEN_ZPN][ZORLEN_FULLDEBUG])
	local buttonscan = (not ZorlenConfig[ZORLEN_ZPN][ZORLEN_AUTOBUTTONSCANOFF])
	ZorlenOptionsFrame_AutoButtonScan:SetChecked(buttonscan)
	local foodscan = (not ZorlenConfig[ZORLEN_ZPN][ZORLEN_FOODOFF])
	ZorlenOptionsFrame_AutoFoodScan:SetChecked(foodscan)
	local itemscan = (not ZorlenConfig[ZORLEN_ZPN][ZORLEN_ITEMSCANOFF])
	ZorlenOptionsFrame_AutoItemScan:SetChecked(itemscan)
	ZorlenOptionsFrame_LogEvents:SetChecked(ZorlenConfig[ZORLEN_ZPN][ZORLEN_LOG_EVENTS])
	ZorlenOptionsFrame_ClearImmuneDatabase:SetChecked(false)
	local immunedetection = (not ZorlenConfig[ZORLEN_ZPN][ZORLEN_AUTOMOBIMMUNEOFF])
	ZorlenOptionsFrame_AutoMobImmunityDetection:SetChecked(immunedetection)
end

function Zorlen_SaveOptionsFrameSettings()
	ZorlenConfig[ZORLEN_ZPN]["ImmuneIgnore"] = {}
	for name,value in Zorlen_PopList do
		ZorlenConfig[ZORLEN_ZPN]["ImmuneIgnore"][name] = value
	end
	if ZorlenOptionsFrame_DodgeSound:GetChecked() then
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_ZDS] = nil
	else
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_ZDS] = true
	end
	local assist = ZorlenOptionsFrame_AssistName:GetText()
	if assist and assist ~= "" then
		if assist ~= ZorlenConfig[ZORLEN_ZPN][ZORLEN_ASSIST] then
			ZorlenConfig[ZORLEN_ZPN][ZORLEN_ASSIST] = assist
		end
	else
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_ASSIST] = nil
	end
	local target = ZorlenOptionsFrame_TargetByName:GetText()
	if target and target ~= "" then
		if target ~= ZorlenConfig[ZORLEN_ZPN][ZORLEN_TARGETBYNAME] then
			ZorlenConfig[ZORLEN_ZPN][ZORLEN_TARGETBYNAME] = target
		end
	else
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_TARGETBYNAME] = nil
	end
	if ZorlenOptionsFrame_Debug:GetChecked() then
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUG] = true
		Zorlen_DebugFlag = 1
	else
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_DEBUG] = nil
		Zorlen_DebugFlag = nil
	end
	if ZorlenOptionsFrame_FullDebug:GetChecked() then
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_FULLDEBUG] = true
		Zorlen_FullDebug = 1
	else
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_FULLDEBUG] = nil
		Zorlen_FullDebug = nil
	end
	if ZorlenOptionsFrame_AutoButtonScan:GetChecked() then
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_AUTOBUTTONSCANOFF] = nil
	else
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_AUTOBUTTONSCANOFF] = true
	end
	if ZorlenOptionsFrame_AutoFoodScan:GetChecked() then
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_FOODOFF] = nil
	else
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_FOODOFF] = true
	end
	if ZorlenOptionsFrame_AutoItemScan:GetChecked() then
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_ITEMSCANOFF] = nil
	else
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_ITEMSCANOFF] = true
	end
	if ZorlenOptionsFrame_ClearImmuneDatabase:GetChecked() then
		ZorlenConfig[ZORLEN_ZPN]["Immune"] = {}
		Zorlen_msg("Immune Mob Database for "..UnitName("player").." has been cleared!")
	end
	if ZorlenOptionsFrame_LogEvents:GetChecked() then
		if not ZorlenConfig[ZORLEN_ZPN][ZORLEN_LOG_EVENTS] then
			ZorlenConfig[ZORLEN_ZPN][ZORLEN_LOG_EVENTS] = true
			if not ZorlenConfig[ZORLEN_EVENT_LOG] then
				ZorlenConfig[ZORLEN_EVENT_LOG] = {}
			end
			Zorlen_msg("Events are now being logged in the file:")
			Zorlen_msg("          \\World of Warcraft\\WTF\\Account\\ACCOUNTNAME\\SavedVariables\\Zorlen.lua")
		end
	elseif ZorlenConfig[ZORLEN_ZPN][ZORLEN_LOG_EVENTS] then
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_LOG_EVENTS] = nil
		Zorlen_msg("Events are no longer being logged in the file:")
		Zorlen_msg("          \\World of Warcraft\\WTF\\Account\\ACCOUNTNAME\\SavedVariables\\Zorlen.lua")
	end
	if ZorlenOptionsFrame_AutoMobImmunityDetection:GetChecked() then
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_AUTOMOBIMMUNEOFF] = nil
	else
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_AUTOMOBIMMUNEOFF] = true
	end
end



--Will dump the value of msg to the default chat window
function Zorlen_msg(msg)
	if msg and msg ~= "" and DEFAULT_CHAT_FRAME then
		DEFAULT_CHAT_FRAME:AddMessage(msg)
	end
end

function Zorlen_debug(msg, show)
	--SendChatMessage(msg, "WHISPER", "Common", "Zorlen")
	if show ~= 0 then
		if show ~= 2 or Zorlen_FullDebug then
			if Zorlen_DebugFlag or show == 1 then
				if msg and msg ~= "" and DEFAULT_CHAT_FRAME then
					--DEFAULT_CHAT_FRAME:AddMessage(msg, 1, 1, 0)
					if show ~= 1 then
						Zorlen_DebugCount = Zorlen_DebugCount + 1
						DEFAULT_CHAT_FRAME:AddMessage("["..Zorlen_DebugCount.."]   "..msg)
					else
						DEFAULT_CHAT_FRAME:AddMessage(msg)
					end
				end
			end
		end
	end
end

function Zorlen_EventsDebug(event, arg1, arg2, arg3, show)
	if event then
		if ZORLEN_ZPN and ZorlenConfig[ZORLEN_ZPN][ZORLEN_LOG_EVENTS] and ZorlenConfig[ZORLEN_EVENT_LOG] and event ~= "UNIT_INVENTORY_CHANGED" and event ~= "SPELLCAST_START" and event ~= "SPELLCAST_CHANNEL_START" and event ~= "START_AUTOREPEAT_SPELL" and event ~= "SPELLCAST_FAILED" and event ~= "PLAYER_TARGET_CHANGED" and event ~= "ACTIONBAR_HIDEGRID" then
			if arg1 and arg1 ~= "" and not string.find(""..arg1.."", "^(%d+)$") and not string.find(""..arg1.."", "^/script ") then
				local arg_1 = Zorlen_gsub(arg1, "%d+", "%(%%d%+%)")
				local SpellName1 = "arg1"
				if Zorlen_LastCastingSpellName and string.find(arg_1, Zorlen_LastCastingSpellName) then
					arg_1 = Zorlen_gsub(arg_1, Zorlen_LastCastingSpellName, "%(%.%+%)")
					SpellName1 = "(.+) = "..Zorlen_LastCastingSpellName
				elseif Zorlen_Temp_CastingSpellName and string.find(arg_1, Zorlen_Temp_CastingSpellName) then
					arg_1 = Zorlen_gsub(arg_1, Zorlen_Temp_CastingSpellName, "%(%.%+%)")
					SpellName1 = "(.+) = "..Zorlen_Temp_CastingSpellName
				end
				if Zorlen_LastCastingSpellTargetName and Zorlen_LastCastingSpellTargetName ~= "" and string.find(arg_1, Zorlen_LastCastingSpellTargetName) then
					arg_1 = Zorlen_gsub(arg_1, Zorlen_LastCastingSpellTargetName, "%(%.%*%)")
				elseif UnitName("target") and UnitName("target") ~= "" then
					arg_1 = Zorlen_gsub(arg_1, UnitName("target"), "%(%.%*%)")
				end
				if arg_1 ~= "" and arg_1 ~= "(.+)" then
					if not ZorlenConfig[ZORLEN_EVENT_LOG][event] then
						ZorlenConfig[ZORLEN_EVENT_LOG][event] = {}
					end
					if not ZorlenConfig[ZORLEN_EVENT_LOG][event][arg_1] then
						ZorlenConfig[ZORLEN_EVENT_LOG][event][arg_1] = {}
					end
					ZorlenConfig[ZORLEN_EVENT_LOG][event][arg_1][SpellName1] = "arg1"
					Zorlen_msg("Logged Event:   [\""..event.."\"]")
					Zorlen_msg("          [\""..arg_1.."\"]")
					Zorlen_msg("                    [\""..SpellName1.."\"]  =  \"arg1\"")
				end
			end
			if arg2 and arg2 ~= "" and not string.find(""..arg2.."", "^(%d+)$") and not string.find(""..arg2.."", "^/script ") then
				local arg_2 = Zorlen_gsub(arg2, "%d+", "%(%%d%+%)")
				local SpellName2 = "arg2"
				if Zorlen_LastCastingSpellName and string.find(arg_2, Zorlen_LastCastingSpellName) then
					arg_2 = Zorlen_gsub(arg_2, Zorlen_LastCastingSpellName, "%(%.%+%)")
					SpellName2 = "(.+) = "..Zorlen_LastCastingSpellName
				elseif Zorlen_Temp_CastingSpellName and string.find(arg_2, Zorlen_Temp_CastingSpellName) then
					arg_2 = Zorlen_gsub(arg_2, Zorlen_Temp_CastingSpellName, "%(%.%+%)")
					SpellName2 = "(.+) = "..Zorlen_Temp_CastingSpellName
				end
				if Zorlen_LastCastingSpellTargetName and Zorlen_LastCastingSpellTargetName ~= "" and string.find(arg_2, Zorlen_LastCastingSpellTargetName) then
					arg_2 = Zorlen_gsub(arg_2, Zorlen_LastCastingSpellTargetName, "%(%.%*%)")
				elseif UnitName("target") and UnitName("target") ~= "" then
					arg_2 = Zorlen_gsub(arg_2, UnitName("target"), "%(%.%*%)")
				end
				if arg_2 ~= "" and arg_2 ~= "(.+)" then
					if not ZorlenConfig[ZORLEN_EVENT_LOG][event] then
						ZorlenConfig[ZORLEN_EVENT_LOG][event] = {}
					end
					if not ZorlenConfig[ZORLEN_EVENT_LOG][event][arg_2] then
						ZorlenConfig[ZORLEN_EVENT_LOG][event][arg_2] = {}
					end
					ZorlenConfig[ZORLEN_EVENT_LOG][event][arg_2][SpellName2] = "arg2"
					Zorlen_msg("Logged Event:   [\""..event.."\"]")
					Zorlen_msg("          [\""..arg_2.."\"]")
					Zorlen_msg("                    [\""..SpellName2.."\"]  =  \"arg2\"")
				end
			end
			if arg3 and arg3 ~= "" and not string.find(""..arg3.."", "^(%d+)$") then
				local arg_3 = Zorlen_gsub(arg3, "%d+", "%(%%d%+%)")
				local SpellName3 = "arg3"
				if Zorlen_LastCastingSpellName and string.find(arg_3, Zorlen_LastCastingSpellName) and not string.find(""..arg2.."", "^/script ") then
					arg_3 = Zorlen_gsub(arg_3, Zorlen_LastCastingSpellName, "%(%.%+%)")
					SpellName3 = "(.+) = "..Zorlen_LastCastingSpellName
				elseif Zorlen_Temp_CastingSpellName and string.find(arg_3, Zorlen_Temp_CastingSpellName) and not string.find(""..arg2.."", "^/script ") then
					arg_3 = Zorlen_gsub(arg_3, Zorlen_Temp_CastingSpellName, "%(%.%+%)")
					SpellName3 = "(.+) = "..Zorlen_Temp_CastingSpellName
				end
				if Zorlen_LastCastingSpellTargetName and Zorlen_LastCastingSpellTargetName ~= "" and string.find(arg_3, Zorlen_LastCastingSpellTargetName) then
					arg_3 = Zorlen_gsub(arg_3, Zorlen_LastCastingSpellTargetName, "%(%.%*%)")
				elseif UnitName("target") and UnitName("target") ~= "" then
					arg_3 = Zorlen_gsub(arg_3, UnitName("target"), "%(%.%*%)")
				end
				if arg_3 ~= "" and arg_3 ~= "(.+)" then
					if not ZorlenConfig[ZORLEN_EVENT_LOG][event] then
						ZorlenConfig[ZORLEN_EVENT_LOG][event] = {}
					end
					if not ZorlenConfig[ZORLEN_EVENT_LOG][event][arg_3] then
						ZorlenConfig[ZORLEN_EVENT_LOG][event][arg_3] = {}
					end
					ZorlenConfig[ZORLEN_EVENT_LOG][event][arg_3][SpellName3] = "arg3"
					Zorlen_msg("Logged Event:   [\""..event.."\"]")
					Zorlen_msg("          [\""..arg_3.."\"]")
					Zorlen_msg("                    [\""..SpellName3.."\"]  =  \"arg3\"")
				end
			end
		end
		if show ~= 0 then
			if show ~= 2 or Zorlen_FullDebug then
				if Zorlen_DebugFlag or show == 1 then
					Zorlen_debug("event:  "..event, show)
					if arg1 and arg1 ~= "" then
						Zorlen_debug("       arg1:  "..arg1, show)
					end
					if arg2 and arg2 ~= "" then
						Zorlen_debug("       arg2:  "..arg2, show)
					end
					if arg3 and arg3 ~= "" then
						Zorlen_debug("       arg3:  "..arg3, show)
					end
				end
			end
		end
	end
end




function Zorlen_changeAssist(name)
	if name and name ~= "" then
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_ASSIST] = name
		Zorlen_debug("You have set "..ZorlenConfig[ZORLEN_ZPN][ZORLEN_ASSIST].." as your saved assist", 1)
	elseif UnitIsFriend("player", "target") then
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_ASSIST] = UnitName("target")
		Zorlen_debug("You have set "..ZorlenConfig[ZORLEN_ZPN][ZORLEN_ASSIST].." as your saved assist", 1)
	else
		Zorlen_debug("Your target is not a friend and can not be assisted")
		if ZorlenConfig[ZORLEN_ZPN][ZORLEN_ASSIST] then
			Zorlen_debug("Your saved assist is still "..ZorlenConfig[ZORLEN_ZPN][ZORLEN_ASSIST])
		end
	end
end

function Zorlen_clearAssist()
	if ZorlenConfig[ZORLEN_ZPN][ZORLEN_ASSIST] then
		Zorlen_debug("You have removed "..ZorlenConfig[ZORLEN_ZPN][ZORLEN_ASSIST].." as your saved assist", 1)
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_ASSIST] = nil
	else
		Zorlen_debug("Your saved assist is cleared", 1)
	end
end

function Zorlen_assist(name)
	local i = name or ZorlenConfig[ZORLEN_ZPN][ZORLEN_ASSIST]
	if (not i) then
		Zorlen_debug("An assist has not been saved yet", 1)
		Zorlen_changeAssist()
		return
	end
	AssistByName(i)
	Zorlen_debug("Assisting "..i)
end



function Zorlen_changeTargetByName(name)
	if name and name ~= "" then
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_TARGETBYNAME] = name
		Zorlen_debug("You have set "..ZorlenConfig[ZORLEN_ZPN][ZORLEN_TARGETBYNAME].." as your saved target", 1)
	elseif UnitExists("target") then
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_TARGETBYNAME] = UnitName("target")
		Zorlen_debug("You have set "..ZorlenConfig[ZORLEN_ZPN][ZORLEN_TARGETBYNAME].." as your saved target", 1)
	end
end

function Zorlen_clearTargetByName()
	if ZorlenConfig[ZORLEN_ZPN][ZORLEN_TARGETBYNAME] then
		Zorlen_debug("You have removed "..ZorlenConfig[ZORLEN_ZPN][ZORLEN_TARGETBYNAME].." as your saved target", 1)
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_TARGETBYNAME] = nil
	else
		Zorlen_debug("Your your saved target is cleared", 1)
	end
end

function Zorlen_TargetByName(name)
	local i = name or ZorlenConfig[ZORLEN_ZPN][ZORLEN_TARGETBYNAME]
	if not i or i == "" then
		Zorlen_debug("A target has not been saved yet", 1)
		return Zorlen_changeTargetByName()
	end
	local t = UnitName("target")
	if i ~= t then
		TargetByName(i, true)
		t = UnitName("target")
		if (i == t) then
			Zorlen_debug("Targeting "..t)
			return true
		end
	else
		Zorlen_debug("Targeting "..t)
		return true
	end
	Zorlen_debug("Target "..i.." not found!")
	return false
end

function Zorlen_TargetByFindInName(name, enemy)
	local Zorlen_TargetByNameFirstTargetName = nil
	local i = name or ZorlenConfig[ZORLEN_ZPN][ZORLEN_TARGETBYNAME]
	if (not i) then
		Zorlen_debug("A target has not been saved yet", 1)
		return Zorlen_changeTargetByName()
	end
	local t = UnitName("target")
	if not t or not strfind(t, i) or (enemy and not Zorlen_isEnemy()) then
		if UnitExists("target") then
			Zorlen_TargetByNameFirstTargetName = t
		end
		TargetByName(i)
		t = UnitName("target")
		if t and strfind(t, i) and (not enemy or Zorlen_isEnemy()) then
			Zorlen_debug("Targeting "..t)
			return true
		elseif not Zorlen_TargetByNameFirstTargetName then
			ClearTarget()
		elseif Zorlen_TargetByNameFirstTargetName ~= t then
			TargetLastTarget()
		end
	else
		Zorlen_debug("Targeting "..t)
		return true
	end
	Zorlen_debug("Target "..i.." not found!")
	return false
end





--Example: Zorlen_isClass("Paladin")
--The example above will return true if your target is a paladin.
--This function has been made so that english class names must be used with this function even if you are not using an english game client.
function Zorlen_isClass(class, unit)
	if class then
		local unit = unit or "target"
		local _, c = UnitClass(unit)
		if c then
			if string.lower(c) == string.lower(class) then
				return true
			end
		end
	end
	return false
end
function isDruid(unit)
	return Zorlen_isClass("DRUID", unit)
end
function isHunter(unit)
	return Zorlen_isClass("HUNTER", unit) 
end
function isPaladin(unit)
	return Zorlen_isClass("PALADIN", unit) 
end
function isPriest(unit)
	return Zorlen_isClass("PRIEST", unit) 
end
function isMage(unit)
	return Zorlen_isClass("MAGE", unit) 
end
function isRogue(unit)
	return Zorlen_isClass("ROGUE", unit) 
end
function isShaman(unit)
	return Zorlen_isClass("SHAMAN", unit) 
end
function isWarlock(unit)
	return Zorlen_isClass("WARLOCK", unit) 
end
function isWarrior(unit)
	return Zorlen_isClass("WARRIOR", unit) 
end

--This returns the english class name: "Priest", "Rogue", "Paladin", "Warlock", "Warrior", "Hunter", "Mage",  "Shaman", "Druid", or nil.
function Zorlen_UnitClass(unit)
	local unit = unit or "target"
	local _, class = UnitClass(unit)
	if (class == "PRIEST") then
		return "Priest"
	elseif (class == "ROGUE") then
		return "Rogue"
	elseif (class == "PALADIN") then
		return "Paladin"
	elseif (class == "WARLOCK") then
		return "Warlock"
	elseif (class == "WARRIOR") then
		return "Warrior"
	elseif (class == "HUNTER") then
		return "Hunter"
	elseif (class == "MAGE") then
		return "Mage"
	elseif (class == "SHAMAN") then
		return "Shaman"
	elseif (class == "DRUID") then
		return "Druid"
	end
	return nil
end



--Example: Zorlen_isRace("Gnome")
--The example above will return true if your target is a gnome.
--This function has been made so that english race names must be used with this function even if you are not using an english game client.
function Zorlen_isRace(race, unit)
	if string.lower(Zorlen_UnitRace(unit)) == string.lower(race) then
		return true
	end
	return false
end

--This returns the english race name: "Human", "Dwarf", "Gnome", "Night Elf", "Orc", "Undead", "Tauren",  "Troll", or nil.
function Zorlen_UnitRace(unit)
	local unit = unit or "target"
	local _, race = UnitRace(unit)
	if (race == "Scourge") then
		return "Undead"
	end
	return race
end


function Zorlen_isCasting(SpellName, SpellRank)
	if Zorlen_Casting then
		if SpellName then
			if SpellName == Zorlen_CastingSpellName then
				if SpellRank then
					if SpellRank == Zorlen_CastingSpellRank then
						return true
					end
				else
					return true
				end
			end
		else
			return true
		end
	end
	return false
end


function Zorlen_isChanneling(SpellName, SpellRank)
	if Zorlen_Channeling then
		if SpellName then
			if SpellName == Zorlen_ChannelingSpellName then
				if SpellRank then
					if SpellRank == Zorlen_ChannelingSpellRank then
						return true
					end
				else
					return true
				end
			end
		else
			return true
		end
	end
	return false
end


function Zorlen_isCastingOrChanneling(SpellName, SpellRank)
	if Zorlen_isCasting(SpellName, SpellRank) or Zorlen_isChanneling(SpellName, SpellRank) then
		return true
	end
	return false
end

--Since the PlayerFrame combat variable can be wrong, The same information
--can be accessed here.	Returns true if you are in combat
function Zorlen_inCombat()
	if Zorlen_Combat then
		return true
	end
	return false
end

-- Returns true if you are not in combat, and may use abilitys that can only be used out of combat
function Zorlen_notInCombat()
	if Zorlen_Combat then
		return false
	end
	return true
end

function Zorlen_inMeleeCombat()
	if Zorlen_Melee then
		return true
	end
	return false
end

function usesMana(unit)
	local unit = unit or "target"
	if UnitPowerType(unit) == 0 then
		return true
	end
	return false
end

function hasMana(unit)
	local unit = unit or "target"
	if UnitPowerType(unit) == 0 and UnitMana(unit) > 0 then
		return true
	end
	return false
end

function Zorlen_HealthPercent(unit)
	local unit = unit or "target"
	local percent = (UnitHealth(unit) / UnitHealthMax(unit)) * 100
	return percent
end

function Zorlen_HealthDamagePercent(unit)
	local percent = 100 - Zorlen_HealthPercent(unit)
	return percent
end

function Zorlen_HealthDamage(unit)
	local unit = unit or "target"
	local damage = UnitHealthMax(unit) - UnitHealth(unit)
	return damage
end

function Zorlen_ManaMissing(unit)
	local unit = unit or "target"
	local damage = UnitManaMax(unit) - UnitMana(unit)
	return damage
end

function Zorlen_ManaPercent(unit)
	local unit = unit or "target"
	local percent = (UnitMana(unit) / UnitManaMax(unit)) * 100
	return percent
end

--Convenience function that will tell if the target is attackable
function Zorlen_canAttack(unit)
	local unit = unit or "target"
	return UnitCanAttack("player", unit)
end










--Internal function that returns the SpellID of the highest ranking spell for SpellName
function Zorlen_GetSpellID(SpellName, SpellRank, Book)
	local B = Book or BOOKTYPE_SPELL
	local SpellID = nil
	if SpellName then
		local SpellCount = 0
		local ReturnName = nil
		local ReturnRank = nil
		while SpellName ~= ReturnName do
			SpellCount = SpellCount + 1
			ReturnName, ReturnRank = GetSpellName(SpellCount, B)
			if not ReturnName then
				break
			end
		end
		while SpellName == ReturnName do
			if SpellRank then
				if SpellRank == 0 then
					return SpellCount
				elseif ReturnRank and ReturnRank ~= "" then
					local found, _, Rank = string.find(ReturnRank, "(%d+)")
					if found then
						ReturnRank = tonumber(Rank)
					else
						ReturnRank = 1
					end
				else
					ReturnRank = 1
				end
				if SpellRank == ReturnRank then
					return SpellCount
				end
			else
				SpellID = SpellCount
			end
			SpellCount = SpellCount + 1
			ReturnName, ReturnRank = GetSpellName(SpellCount, B)
		end
	end
	return SpellID
end


function Zorlen_checkCoolThenCast(SpellID, Book)
	local B = Book or BOOKTYPE_SPELL
	if Zorlen_checkCooldown(SpellID, Book) then
		CastSpell(SpellID, B)
		return true
	end
	return false
end


function Zorlen_castSpellByName(SpellName, SpellRank, Book)
	local SpellID = Zorlen_GetSpellID(SpellName, SpellRank, Book)
	return Zorlen_checkCoolThenCast(SpellID, Book)
end

-- Checks for spell cooldown. If cooldown has passed, a value of true is returned. If the spell is still on cool down a value of false is returned.
function Zorlen_checkCooldown(SpellID, Book)
	local B = Book or BOOKTYPE_SPELL
	if SpellID then
		if GetSpellCooldown(SpellID, B) == 0 then
			return true
		end
	end
	return false
end

-- Checks for spell cooldown. If cooldown has passed, a value of true is returned. If the spell is still on cool down a value of false is returned.
function Zorlen_checkCooldownByName(SpellName, Book)
	return Zorlen_checkCooldown(Zorlen_GetSpellID(SpellName, 0, Book), Book)
end

--function to check if a certain spell is known
-- Example: Zorlen_IsSpellKnown("Spell Name")
-- Example above will return true if any rank of the named spell is located in your spell book.
function Zorlen_IsSpellKnown(SpellName, SpellRank, Book)
	if SpellRank then
		if Zorlen_GetSpellID(SpellName, SpellRank, Book) then
			return true
		end
	elseif Zorlen_GetSpellID(SpellName, 0, Book) then
		return true
	end
	return false
end

--function to check if a certain spell and rank are known
-- Example: Zorlen_IsSpellRankKnown("Spell Name", 2)
-- Example above will return true if the named spell and rank 2 of that spell are located in your spell book.
-- This function will do the exact same thing as Zorlen_IsSpellKnown(SpellName, SpellRank) but has been left in for legacy support.
function Zorlen_IsSpellRankKnown(SpellName, SpellRank, Book)
	return Zorlen_IsSpellKnown(SpellName, SpellRank, Book)
end

-- Returns the the spell rank as a number
function Zorlen_GetSpellRank(SpellName, Book)
	local B = Book or BOOKTYPE_SPELL
	local rslt = 0
	if SpellName then
		local spell, rank
		local i = Zorlen_GetSpellID(SpellName, nil, B)
		if i then
			spell, rank = GetSpellName(i, B)
			rslt = rank
			if rslt and rslt ~= "" then
				local found, _, Rank = string.find(rslt, "(%d+)")
				if found then
					rslt = tonumber(Rank)
				else
					rslt = 1
				end
			else
				rslt = 1
			end
		end
	end
	return rslt
end

function Zorlen_HasTalent(TalentName)
	if Zorlen_GetTalentRank(TalentName) > 0 then
		return true
	end
	return false
end

-- Returns the the value of how many talent points that have been spent on a talent.
-- Example: Zorlen_GetTalentRank("Talent Name") == 1
-- Example above will return true if the named talent has only one point spent in it.
function Zorlen_GetTalentRank(TalentName)
	for iTab=1,GetNumTalentTabs() do
		for iTal=1,GetNumTalents(iTab) do
			local nameTalent , iconPath , iconX , iconY , currentRank , maxRank = GetTalentInfo( iTab, iTal )
			if nameTalent == TalentName then
				return currentRank 
			end
		end
	end
	return 0
end

function Zorlen_GetSpellTextureByName(SpellName, Book)
	local B = Book or BOOKTYPE_SPELL
	if SpellName then
		if Zorlen_IsSpellKnown(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName, 0, Book)
			local texture = GetSpellTexture(SpellID, B)
			if texture then
				return texture
			end
		end
	end
	return "texture was not found"
end

function Zorlen_ShowSpellTextureByName(SpellName)
	if SpellName then
		return Zorlen_debug(Zorlen_GetSpellTextureByName(SpellName), 1)
	end
end










--Test function to display all debuffs on your target or a specified unit.
function Zorlen_ShowAllDebuffs(unit)
	local u = unit or "target"
	if not unit and not UnitExists("target") then
		u = "player"
	end
	if UnitName(u) then
		if not UnitDebuff(u, 1) then
			Zorlen_debug("No debuffs found for "..UnitName(u), 1)
			return
		end
		Zorlen_debug("All debuffs for "..UnitName(u)..":", 1)
		local counter = 1
		while (UnitDebuff(u, counter)) do
			ZORLEN_Buff_Tooltip:SetUnitDebuff(u, counter)
			local name = ZORLEN_Buff_TooltipTextLeft1:GetText()
			local texture = UnitDebuff(u, counter)
			texture = string.gsub(texture, "Interface\\Icons\\", "")
			Zorlen_debug("Debuff Slot #"..counter..":", 1)
			Zorlen_debug("       Debuff Name:   "..name, 1)
			Zorlen_debug("       Debuff Texture:   "..texture, 1)
			counter = counter + 1
		end
	end
end


--Test function to display all buffs on yourself or a specified unit.
function Zorlen_ShowAllBuffs(unit)
	local u = unit or "target"
	if not unit and not UnitExists("target") then
		u = "player"
	end
	if UnitName(u) then
		if not UnitBuff(u, 1) then
			Zorlen_debug("No buffs found for "..UnitName(u), 1)
			return
		end
		Zorlen_debug("All buffs for "..UnitName(u)..":", 1)
		local counter = 1
		while (UnitBuff(u, counter)) do
			ZORLEN_Buff_Tooltip:SetUnitBuff(u, counter)
			local name = ZORLEN_Buff_TooltipTextLeft1:GetText()
			local texture = UnitBuff(u, counter)
			texture = string.gsub(texture, "Interface\\Icons\\", "")
			Zorlen_debug("Buff Slot #"..counter..":", 1)
			Zorlen_debug("       Buff Name:   "..name, 1)
			Zorlen_debug("       Buff Texture:   "..texture, 1)
			counter = counter + 1
		end
	end
end

--returns true if there are 16 debuffs on the target
function Zorlen_AllDebuffSlotsUsed(unit)
	unit = unit or "target"
	if UnitDebuff(unit, Zorlen_MaxDebuffSlots) then
		return true
	end
	return false
end


--Loops through all self buffs looking for a match and returns the index number
function Zorlen_GiveSelfBuffIndex(buff, SpellName, buffFilter, DispelType, HasDuration)
	local counter = 0
	while GetPlayerBuff(counter) >= 0 do
		if not buffFilter or GetPlayerBuff(counter, buffFilter) >= 0 then
			local index, untilCancelled = GetPlayerBuff(counter)
			if not HasDuration or untilCancelled ~= 1 then
				if not DispelType or DispelType == GetPlayerBuffDispelType(index) then
					if SpellName then
						ZORLEN_Buff_Tooltip:SetPlayerBuff(index)
						local buffname = ZORLEN_Buff_TooltipTextLeft1:GetText()
						if buffname then
							if string.find(buffname, SpellName) then
								return index
							end
						end
					elseif buff then
						if string.find(GetPlayerBuffTexture(index), buff) then
							return index
						end
					else
						return index
					end
				end
			end
		end
		counter = counter + 1
	end
	return nil
end

function Zorlen_GiveSelfBuffIndexByName(SpellName, buffFilter, DispelType, HasDuration, buff)
	return Zorlen_GiveSelfBuffIndex(buff, SpellName, buffFilter, DispelType, HasDuration)
end


function Zorlen_checkSelfBuff(buff, SpellName, buffFilter, DispelType, HasDuration)
	if Zorlen_GiveSelfBuffIndex(buff, SpellName, buffFilter, DispelType, HasDuration) then
		return true
	end
	return false
end

function Zorlen_checkSelfBuffByName(SpellName, buffFilter, DispelType, HasDuration, buff)
	return Zorlen_checkSelfBuff(buff, SpellName, buffFilter, DispelType, HasDuration)
end


function Zorlen_CancelSelfBuff(buff, SpellName)
	local i = Zorlen_GiveSelfBuffIndex(buff, SpellName)
	if i then
		CancelPlayerBuff(i)
		return true
	end
	return false
end

function Zorlen_CancelSelfBuffByName(SpellName, buff)
	return Zorlen_CancelSelfBuff(buff, SpellName)
end


--Loops through all debuffs looking for a match and returns the index number
function Zorlen_GiveDebuffIndex(debuff, unit, dispelable, SpellName, SpellToolTipLineTwo)
	local u = unit or "target"
	local d = nil
	local counter = 1
	if dispelable then
		if (dispelable == 1) or (dispelable == 0) then
			d = dispelable
		else
			d = 1
		end
	end
	while UnitDebuff(u, counter) do
		if UnitDebuff(u, counter, d) then
			if SpellName then
				ZORLEN_Buff_Tooltip:SetUnitDebuff(u, counter)
				local debuffname = ZORLEN_Buff_TooltipTextLeft1:GetText()
				if debuffname then
					if string.find(debuffname, SpellName) then
						if SpellToolTipLineTwo then
							local debuffline2 = ZORLEN_Buff_TooltipTextLeft2:GetText() or ""
							if string.find(debuffline2, SpellToolTipLineTwo) then
								return counter
							end
							return nil
						end
						return counter
					end
				end
			elseif debuff then
				local debufftexture = UnitDebuff(u, counter)
				if debufftexture then
					if string.find(debufftexture, debuff) then
						return counter
					end
				end
			else
				return counter
			end
		end
		counter = counter + 1
	end
	return nil
end

--Loops through all buffs looking for a match and returns the index number
function Zorlen_GiveBuffIndex(buff, unit, castable, SpellName)
	local u = unit or "player"
	local c = nil
	local counter = 1
	if castable then
		if (castable == 1) or (castable == 0) then
			c = castable
		else
			c = 1
		end
	end
	while UnitBuff(u, counter) do
		if UnitBuff(u, counter, c) then
			if SpellName then
				ZORLEN_Buff_Tooltip:SetUnitBuff(u, counter)
				local buffname = ZORLEN_Buff_TooltipTextLeft1:GetText()
				if buffname then
					if string.find(buffname, SpellName) then
						return counter
					end
				end
			elseif buff then
				local bufftexture = UnitBuff(u, counter)
				if bufftexture then
					if string.find(bufftexture, buff) then
						return counter
					end
				end
			else
				return counter
			end
		end
		counter = counter + 1
	end
	return nil
end


--Loops through all debuffs looking for a match
function Zorlen_checkDebuff(debuff, unit, dispelable, SpellName, SpellToolTipLineTwo)
	if Zorlen_GiveDebuffIndex(debuff, unit, dispelable, SpellName, SpellToolTipLineTwo) then
		return true
	end
	return false
end

--Loops through all buffs looking for a match
function Zorlen_checkBuff(buff, unit, castable, SpellName)
	if Zorlen_GiveBuffIndex(buff, unit, castable, SpellName) then
		return true
	end
	return false
end


function Zorlen_checkDebuffByName(SpellName, unit, dispelable, debuff, SpellToolTipLineTwo)
	return Zorlen_checkDebuff(debuff, unit, dispelable, SpellName, SpellToolTipLineTwo)
end

function Zorlen_checkBuffByName(SpellName, unit, castable, buff)
	if unit == "MainHandSlot" or unit == "SecondaryHandSlot" then
		local slot = GetInventorySlotInfo(unit)
		if SpellName and GetInventoryItemLink("player", slot) then
			ZORLEN_Buff_Tooltip:SetInventoryItem("player", slot)
			for i=1,ZORLEN_Buff_Tooltip:NumLines() do
				local line = getglobal("ZORLEN_Buff_TooltipTextLeft"..i):GetText()
				if line then
					if string.find(line, SpellName) then
						return true
					end
				end
			end
		end
		return false
	end
	return Zorlen_checkBuff(buff, unit, castable, SpellName)
end

function Zorlen_checkMainHandItemBuffByName(SpellName)
	return Zorlen_checkBuffByName(SpellName, "MainHandSlot")
end

function Zorlen_checkOffHandItemBuffByName(SpellName)
	return Zorlen_checkBuffByName(SpellName, "SecondaryHandSlot")
end

function Zorlen_checkItemBuffByName(SpellName, hand)
	if hand then
		local hand = string.lower(""..hand.."")
		if hand == "main" or hand == "1" or hand == "mainhand" or hand == "main hand" or hand == "mainhandslot" then
			return Zorlen_checkMainHandItemBuffByName(SpellName)
		elseif hand == "off" or hand == "2" or hand == "offhand" or hand == "off hand" or hand == "secondaryhandslot" then
			return Zorlen_checkOffHandItemBuffByName(SpellName)
		end
		Zorlen_debug("Valid options for Zorlen_checkItemBuffByName() are: \"main\", \"off\", 1, 2, and nil")
	elseif Zorlen_checkMainHandItemBuffByName(SpellName) or Zorlen_checkOffHandItemBuffByName(SpellName) then
		return true
	end
	return false
end


-- Returns the amount of times a debuff is stacked on the target, and returns 0 if the debuff is not on the target.
function Zorlen_GetDebuffStack(debuff, unit, dispelable, SpellName, SpellToolTipLineTwo)
	local u = unit or "target"
	local index = Zorlen_GiveDebuffIndex(debuff, u, dispelable, SpellName, SpellToolTipLineTwo)
	if index then
		local texture, applications = UnitDebuff(u, index)
		return applications
	end
	return 0
end

function Zorlen_GetDebuffStackByName(SpellName, unit, SpellToolTipLineTwo, dispelable, debuff)
	return Zorlen_GetDebuffStack(debuff, unit, dispelable, SpellName, SpellToolTipLineTwo)
end




function Zorlen_isBreakOnDamageCC(unit, dispelable)
	if
	Zorlen_checkDebuff("Spell_Nature_Polymorph", unit, dispelable, LOCALIZATION_ZORLEN.Polymorph) --Polymorph
	or
	Zorlen_checkDebuff("Spell_Nature_Sleep", unit, dispelable) --Sleep: Hibernate
	or
	Zorlen_checkDebuff("Spell_Nature_Slow", unit, dispelable, LOCALIZATION_ZORLEN.ShackleUndead) --Shackle Undead
	or
	Zorlen_checkDebuff("Ability_Sap", unit, dispelable, LOCALIZATION_ZORLEN.Sap) --Sap
	or
	Zorlen_checkDebuff("Spell_Shadow_MindSteal", unit, dispelable, LOCALIZATION_ZORLEN.Seduction) --Succubus Seduction
	or
	Zorlen_checkDebuff("Ability_GolemStormBolt", unit, dispelable, LOCALIZATION_ZORLEN.ScatterShot) --Scatter Shot
	or
	Zorlen_checkDebuff("Spell_Frost_ChainsOfIce", unit, dispelable, LOCALIZATION_ZORLEN.FreezingTrap) --Freezing Trap
	or
	Zorlen_checkDebuff("INV_Spear_02", unit, dispelable, LOCALIZATION_ZORLEN.WyvernSting, LOCALIZATION_ZORLEN.Asleep) --Sleep: Wyvern Sting
	then
		return true
	end
	return false
end

--all forms of fear and movement impairing affects are not included since they do not prevent the target from being damaged
--Mind Control control is no longer included as a CC in this function
function Zorlen_isNoDamageCC(unit, dispelable)
	if
	Zorlen_isBreakOnDamageCC(unit, dispelable)
	or
	Zorlen_checkDebuff("Spell_Shadow_Cripple", unit, dispelable, LOCALIZATION_ZORLEN.Banish) --Banish
	--[[
	or
	Zorlen_checkDebuff("Spell_Shadow_ShadowWordDominate", unit, dispelable) --Mind Control
	--]]
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
	Zorlen_checkDebuff("Spell_Shadow_Possession", unit, dispelable, LOCALIZATION_ZORLEN.Fear) --Fear
	or
	Zorlen_checkDebuff("Spell_Shadow_DeathScream", unit, dispelable, LOCALIZATION_ZORLEN.HowlOfTerror) --Fear: Howl of Terror
	or
	Zorlen_checkDebuff("Spell_Shadow_PsychicScream", unit, dispelable, LOCALIZATION_ZORLEN.PsychicScream) --Fear: Psychic Scream
	or
	Zorlen_checkDebuff("Ability_Druid_Cower", unit, dispelable, LOCALIZATION_ZORLEN.ScareBeast) --Fear: Scare Beast
	then
		return true
	end
	return false
end















function Zorlen_IsUnit(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
	local u = unit or "target"
	if UnitExists(u) then
		if not enemy or (UnitCanAttack("player", u) and not UnitIsCivilian(u) and (UnitHealth(u) > 0 or UnitExists(u.."target") or UnitAffectingCombat(u) or (UnitIsPlayer(u) and Zorlen_isClass("Hunter", u)))) then
			if not active or ((UnitAffectingCombat(u) or UnitExists(u.."target") or UnitHealth(u) < UnitHealthMax(u) or UnitIsPlayer(u) or (UnitIsEnemy("player", u) and CheckInteractDistance(u, 3))) and not Zorlen_isNoDamageCC(u)) then
				if not player or UnitIsPlayer(u) then
					if not mob or (not UnitPlayerControlled(u) and (enemy or UnitExists(u))) then
						if not givesxp or ((enemy or (UnitCanAttack("player", u) and not UnitIsCivilian(u) and (UnitHealth(u) > 0 or UnitExists(u.."target") or UnitAffectingCombat(u) or (UnitIsPlayer(u) and Zorlen_isClass("Hunter", u))))) and not UnitIsTrivial(u) and UnitFactionGroup(u) ~= UnitFactionGroup("player") and not UnitIsPet(u) and (UnitIsPlayer(u) or not UnitIsTapped(u) or UnitIsTappedByPlayer(u))) then
							if not lessthenhealthpercent or Zorlen_HealthPercent(u) <= lessthenhealthpercent then
								if not unithasnotarget or not UnitExists(u.."target") then
									if not unitistargetingyou or UnitIsUnit(u.."target", "player") then
										if not unitistargetingyourfriend or (not UnitIsUnit(u.."target", "player") and UnitIsFriend("player", u.."target")) then
											if not unitistargetingselforitsfriend or UnitCanAttack("player", u.."target") then
												return true
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	return false
end


-- Will return true if your target is not a friend and is still alive.
-- This will not be able to return the correct results if the target is an enemy hunter that has feigned death and is not targeting anything.
function Zorlen_isEnemy(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
	return Zorlen_IsUnit(unit, 1, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
end
Zorlen_TargetIsEnemy = Zorlen_isEnemy
isEnemy = Zorlen_isEnemy

-- Will try to determine if the targeted enemy is aggroed or doing anything that would make attacking the target acceptable.
function Zorlen_isActiveEnemy(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
	return Zorlen_IsUnit(unit, 1, 1, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
end
Zorlen_TargetIsActiveEnemy = Zorlen_isActiveEnemy
isActiveEnemy = Zorlen_isActiveEnemy

function Zorlen_isActiveEnemyThatGivesXP(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
	return Zorlen_IsUnit(unit, 1, 1, player, mob, 1, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
end
Zorlen_TargetIsActiveEnemyThatGivesXP = Zorlen_isActiveEnemyThatGivesXP
isActiveEnemyThatGivesXP = Zorlen_isActiveEnemyThatGivesXP

function Zorlen_GivesXP(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
	return Zorlen_IsUnit(unit, 1, active, player, mob, 1, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
end
givesXP = Zorlen_GivesXP

function Zorlen_isEnemyPlayer(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
	return Zorlen_IsUnit(unit, 1, active, 1, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
end
Zorlen_TargetIsEnemyPlayer = Zorlen_isEnemyPlayer
isEnemyPlayer = Zorlen_isEnemyPlayer

function Zorlen_isEnemyMob(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
	return Zorlen_IsUnit(unit, 1, active, player, 1, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
end
Zorlen_TargetIsEnemyMob = Zorlen_isEnemyMob
isEnemyMob = Zorlen_isEnemyMob

-- Will try to determine if the targeted enemy is a mob and aggroed or doing anything that would make attacking the target acceptable.
function Zorlen_isActiveEnemyMob(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
	return Zorlen_IsUnit(unit, 1, 1, player, 1, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
end
Zorlen_TargetIsActiveEnemyMob = Zorlen_isActiveEnemyMob
isActiveEnemyMob = Zorlen_isActiveEnemyMob

-- Returns true if the target is an enemy with 20% health or lower.
function Zorlen_isDieingEnemy(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
	return Zorlen_IsUnit(unit, 1, active, player, mob, givesxp, 20, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
end
Zorlen_TargetIsDieingEnemy = Zorlen_isDieingEnemy
isDieingEnemy = Zorlen_isDieingEnemy

-- Returns true if the target is an enemy with 20% health or lower that has no target.
function Zorlen_isDieingEnemyWithNoTarget(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
	return Zorlen_IsUnit(unit, 1, active, player, mob, givesxp, 20, 1, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
end
Zorlen_TargetIsDieingEnemyWithNoTarget = Zorlen_isDieingEnemyWithNoTarget
isDieingEnemyWithNoTarget = Zorlen_isDieingEnemyWithNoTarget

-- Will return true if the targeted enemy is targeting you.
function Zorlen_isEnemyTargetingYou(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
	return Zorlen_IsUnit(unit, 1, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, 1, unitistargetingyourfriend, unitistargetingselforitsfriend)
end
Zorlen_TargetIsEnemyTargetingYou = Zorlen_isEnemyTargetingYou
isEnemyTargetingYou = Zorlen_isEnemyTargetingYou

-- Will return true if the targeted enemy is targeting a friend but not you.
function Zorlen_isEnemyTargetingFriendButNotYou(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
	return Zorlen_IsUnit(unit, 1, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, 1, unitistargetingselforitsfriend)
end
Zorlen_TargetIsEnemyTargetingFriendButNotYou = Zorlen_isEnemyTargetingFriendButNotYou
isEnemyTargetingFriendButNotYou = Zorlen_isEnemyTargetingFriendButNotYou

-- Will return true if the enemy target is targeting himself or another enemy.
-- Mobs will some times target themselves or another enemy when they are casting a beneficial spell.
function Zorlen_isEnemyTargetingEnemy(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
	return Zorlen_IsUnit(unit, 1, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, 1)
end
Zorlen_TargetIsEnemyTargetingEnemy = Zorlen_isEnemyTargetingEnemy
isEnemyTargetingEnemy = Zorlen_isEnemyTargetingEnemy

-- Will return true if your target is a friend that is targeting an enemy.
-- This will not be able to return the correct results if the target's target is an enemy hunter that has feigned death and is not targeting anything.
function Zorlen_isFriendTargetingEnemy(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
	local u = unit or "target"
	if UnitIsFriend("player", u) and Zorlen_isEnemy(u.."target", enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend) then
		return true
	end
	return false
end
Zorlen_TargetIsFriendTargetingEnemy = Zorlen_isFriendTargetingEnemy
isFriendTargetingEnemy = Zorlen_isFriendTargetingEnemy

-- Will return true if your target is a friend that is targeting an active enemy.
-- See description for Zorlen_isActiveEnemy() for description of "active enemy".
function Zorlen_isFriendTargetingActiveEnemy(unit, enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend)
	local u = unit or "target"
	if UnitIsFriend("player", u) and Zorlen_isActiveEnemy(u.."target", enemy, active, player, mob, givesxp, lessthenhealthpercent, unithasnotarget, unitistargetingyou, unitistargetingyourfriend, unitistargetingselforitsfriend) then
		return true
	end
	return false
end
Zorlen_TargetIsFriendTargetingActiveEnemy = Zorlen_isFriendTargetingActiveEnemy
isFriendTargetingActiveEnemy = Zorlen_isFriendTargetingActiveEnemy







-- Will not do anything if you are already targeting an enemy.
function Zorlen_TargetEnemy(cycles, givesxp)
	if not Zorlen_isEnemy(nil, nil, nil, nil, nil, givesxp) then
		Zorlen_TargetNearestEnemy(nil, cycles, givesxp)
	end
end
zTargetEnemy = Zorlen_TargetEnemy

--I only added this for those who do not want the targeting to attempt more than one target cycle when targeting for them.
function Zorlen_TargetFirstEnemy(givesxp)
	if not Zorlen_isEnemy(nil, nil, nil, nil, nil, givesxp) then
		Zorlen_TargetNearestEnemy("first", nil, givesxp)
	end
end
zTargetFirstEnemy = Zorlen_TargetFirstEnemy

--Will clear target if you are targeting an enemy that is not active.
function Zorlen_TargetActiveEnemyOnly(cycles, givesxp)
	if not Zorlen_isActiveEnemy(nil, nil, nil, nil, nil, givesxp) then
		Zorlen_TargetNearestEnemy("only", cycles, givesxp)
	end
end
zTargetActiveEnemyOnly = Zorlen_TargetActiveEnemyOnly

--Will clear target if you are targeting an enemy that is not active or does not give xp.
function Zorlen_TargetActiveEnemyThatGivesXPOnly(cycles)
	return Zorlen_TargetActiveEnemyOnly(cycles, 1)
end
zTargetActiveEnemyThatGivesXPOnly = Zorlen_TargetActiveEnemyThatGivesXPOnly

--Will clear target if you are targeting an enemy that is not a player.
function Zorlen_TargetEnemyPlayerOnly(cycles)
	if not Zorlen_isEnemyPlayer() then
		Zorlen_TargetNearestEnemy("playeronly", cycles)
	end
end
zTargetEnemyPlayerOnly = Zorlen_TargetEnemyPlayerOnly

--Will clear target if you are targeting an enemy that is not active or a player.
function Zorlen_TargetEnemyPlayerFirstOrActiveEnemyOnly(cycles, givesxp)
	if not Zorlen_isActiveEnemy(nil, nil, nil, nil, nil, givesxp) then
		Zorlen_TargetNearestEnemy("playeroractiveonly", cycles, givesxp)
	end
end
zTargetEnemyPlayerFirstOrActiveEnemyOnly = Zorlen_TargetEnemyPlayerFirstOrActiveEnemyOnly

-- Will not do anything if you are already targeting an enemy player.
function Zorlen_TargetEnemyPlayerFirst(cycles, givesxp)
	if not Zorlen_isEnemy(nil, nil, nil, nil, nil, givesxp) then
		Zorlen_TargetNearestEnemy("player", cycles, givesxp)
	end
end
zTargetEnemyPlayerFirst = Zorlen_TargetEnemyPlayerFirst



--Will clear target if you are targeting an enemy that is not active.
function Zorlen_TargetActiveEnemyMobOnly(cycles, givesxp)
	if not Zorlen_isActiveEnemyMob(nil, nil, nil, nil, nil, givesxp) then
		Zorlen_TargetNearestEnemy("activemobonly", cycles, givesxp)
	end
end
zTargetActiveEnemyMobOnly = Zorlen_TargetActiveEnemyMobOnly

--Will clear target if you are targeting an enemy that is not a player.
function Zorlen_TargetEnemyMobOnly(cycles, givesxp)
	if not Zorlen_isEnemyMob(nil, nil, nil, nil, nil, givesxp) then
		Zorlen_TargetNearestEnemy("mobonly", cycles, givesxp)
	end
end
zTargetEnemyMobOnly = Zorlen_TargetEnemyMobOnly




--Will always clear target to find the best target
function Zorlen_TargetNearestEnemy(mode, cycles, givesxp)
	local number = cycles or 7
	local healthscan = true
	local health = 0
	local lowesthealth = 0
	local name = UnitName("target")
	local counter = 1
	local wasenemy = nil
	local wasplayerenemy = nil
	if Zorlen_isEnemy() then
		wasenemy = 1
		if not Zorlen_isEnemyMob() then
			wasplayerenemy = 1
			if (mode == "mobonly") or (mode == "activemobonly") then
				ClearTarget()
				Zorlen_debug("Clearing Target!", 2)
			end
		end
		ClearTarget()
		Zorlen_debug("Clearing Target!", 2)
	elseif UnitCanAttack("player", "target") then
		ClearTarget()
		Zorlen_debug("Clearing Target!", 2)
	end
	if (mode == "first") then
		if Zorlen_isFriendTargetingActiveEnemy(nil, nil, nil, nil, nil, givesxp) then
			Zorlen_debug("Assisting "..name.."!")
			AssistUnit("target")
		elseif UnitExists("pettarget") and Zorlen_isActiveEnemy("pettarget", nil, nil, nil, nil, givesxp) then
			if not UnitIsUnit("target", "pettarget") and not Zorlen_isActiveEnemy(nil, nil, nil, nil, nil, givesxp) then
				Zorlen_debug("Assisting your pet "..UnitName("pet").."!")
				AssistUnit("pet")
			end
		elseif not Zorlen_isEnemy(nil, nil, nil, nil, nil, givesxp) then
			TargetNearestEnemy()
		end
		return
	elseif not Zorlen_isActiveEnemy(nil, nil, nil, nil, nil, givesxp) or (((mode == "playeronly") or (mode == "player")) and not Zorlen_isEnemyPlayer()) then
		if ((mode == "playeronly") or (mode == "player") or (mode == "playeroractiveonly")) then
			if (UnitCanAttack("player", "target")) or (wasenemy and UnitExists("target")) then
				ClearTarget()
				Zorlen_debug("Clearing Target!", 2)
			end
			while (counter <= number) do
				TargetNearestEnemy()
				name = UnitName("target")
				if Zorlen_isEnemyPlayer() and (not (UnitIsUnit("pet", "targettarget") and not UnitIsUnit("pettarget", "target")) or not UnitExists("pettarget")) then
					Zorlen_debug("Player found for player targeting attempt #"..counter..": "..name)
					return
				elseif Zorlen_DebugFlag and name and Zorlen_isEnemy() then
					Zorlen_debug("Player targeting attempt #"..counter..": "..name, 2)
				end
				counter = counter + 1
			end
			Zorlen_debug("Player target not found!")
		end
		if mode ~= "playeronly" then
			if ((UnitCanAttack("player", "target")) or (wasenemy and UnitExists("target"))) then
				ClearTarget()
				Zorlen_debug("Clearing Target!", 2)
			end
			counter = 1
			while (counter <= number) do
				TargetNearestEnemy()
				name = UnitName("target")
				if Zorlen_isActiveEnemy(nil, nil, nil, nil, nil, givesxp) and not (((mode == "mobonly") or (mode == "activemobonly")) and not Zorlen_isEnemyMob()) and (not (UnitIsUnit("pet", "targettarget") and not UnitIsUnit("pettarget", "target")) or not UnitExists("pettarget")) then
					health = UnitHealth("target") / UnitHealthMax("target")
					if healthscan and ((health < lowesthealth) or (lowesthealth == 0)) then
						lowesthealth = health
					end
					if Zorlen_DebugFlag and healthscan then
						Zorlen_debug("Active target health scan on attempt #"..counter..": "..name, 2)
					end
					if not healthscan then
						if health <= lowesthealth then
							if Zorlen_DebugFlag then
								if UnitIsPlayer("target") then
									Zorlen_debug("Lowest health player found for targeting attempt #"..counter..": "..name)
								else
									Zorlen_debug("Lowest health target found for targeting attempt #"..counter..": "..name)
								end
							end
							return
						else
							Zorlen_debug("Finding saved lowest health target attempt #"..counter..": "..name, 2)
						end
					end
				elseif Zorlen_DebugFlag and name and Zorlen_isEnemy() then
					Zorlen_debug("Active targeting attempt #"..counter..": "..name, 2)
				end
				if counter == number and number > 1 and healthscan and lowesthealth > 0 then
					counter = 0
					healthscan = nil
					ClearTarget()
					Zorlen_debug("Clearing Target!", 2)
				elseif counter == number and number > 1 and not healthscan and lowesthealth > 0 then
					counter = 0
					healthscan = true
					lowesthealth = 0
					ClearTarget()
					Zorlen_debug("Clearing Target!", 2)
				end
				counter = counter + 1
			end
			if Zorlen_isFriendTargetingActiveEnemy(nil, nil, nil, nil, nil, givesxp) then
				Zorlen_debug("Assisting "..name.."!")
				AssistUnit("target")
				return
			elseif UnitExists("pettarget") and Zorlen_isActiveEnemy("pettarget", nil, nil, nil, nil, givesxp) then
				if not UnitIsUnit("target", "pettarget") and not Zorlen_isActiveEnemy(nil, nil, nil, nil, nil, givesxp) then
					Zorlen_debug("Assisting your pet "..UnitName("pet").."!")
					AssistUnit("pet")
				end
				return
			end
			if (mode == "mobonly") or (mode == "activemobonly") then
				Zorlen_debug("Active mob not found!")
			else
				Zorlen_debug("Active target not found!")
			end
		end
		if (mode == "only") or (mode == "playeronly") or (mode == "playeroractiveonly") or (mode == "activemobonly") then
			if (UnitCanAttack("player", "target")) then
				ClearTarget()
				Zorlen_debug("Clearing Target!", 2)
			end
			return
		end
		if ((UnitCanAttack("player", "target")) or (wasenemy and not ((mode == "mobonly") and wasplayerenemy))) or ((mode == "mobonly") and not Zorlen_isEnemyMob() and not UnitIsFriend("player", "target")) then
			if UnitExists("target") then
				ClearTarget()
				Zorlen_debug("Clearing Target!", 2)
			end
			counter = 1
			while (counter <= number) do
				TargetNearestEnemy()
				name = UnitName("target")
				if Zorlen_isEnemy() and not ((mode == "mobonly") and not Zorlen_isEnemyMob()) then
					if Zorlen_DebugFlag and (mode == "mobonly") and counter ~= 1 then
						Zorlen_debug("Target found for targeting attempt #"..counter..": "..name)
					elseif Zorlen_DebugFlag then
						Zorlen_debug("Targeting nearest enemy: "..name)
					end
					return
				elseif Zorlen_DebugFlag and name and Zorlen_isEnemy() then
					Zorlen_debug("Targeting attempt #"..counter..": "..name, 2)
				end
				counter = counter + 1
			end
		end
		if wasenemy and not ((mode == "mobonly") and wasplayerenemy) then
			TargetLastTarget()
		end
		if ((not Zorlen_isEnemy()) or ((mode == "mobonly") and not Zorlen_isEnemyMob())) then
			if (mode == "mobonly") then
				Zorlen_debug("Enemy mob not found!")
			else
				Zorlen_debug("Enemy target not found!")
			end
			if UnitCanAttack("player", "target") then
				ClearTarget()
				Zorlen_debug("Clearing Target!", 2)
			end
			return
		end
	end
end
zTargetNearestEnemy = Zorlen_TargetNearestEnemy

--Will always clear target to find the target with the highest health   -   This may be useful for core hound packs for those who do not use aoe damage
function Zorlen_TargetNearestActiveEnemyWithHighestHealth(cycles)
	local number = cycles or 7
	local healthscan = true
	local health = 0
	local highesthealth = 0
	local name = nil
	local counter = 1
	if UnitCanAttack("player", "target") then
		ClearTarget()
		Zorlen_debug("Clearing Target!", 2)
	end
	while (counter <= number) do
		TargetNearestEnemy()
		name = UnitName("target")
		if Zorlen_isActiveEnemy() then
			health = UnitHealth("target") / UnitHealthMax("target")
			if healthscan and ((health > highesthealth) or (highesthealth == 0)) then
				highesthealth = health
			end
			if Zorlen_DebugFlag and healthscan then
				Zorlen_debug("Active target health scan on attempt #"..counter..": "..name, 2)
			end
			if not healthscan then
				if health >= highesthealth then
					if Zorlen_DebugFlag then
						if UnitIsPlayer("target") then
							Zorlen_debug("Highest health player found for targeting attempt #"..counter..": "..name)
						else
							Zorlen_debug("Highest health target found for targeting attempt #"..counter..": "..name)
						end
					end
					return
				else
					Zorlen_debug("Finding saved highest health target attempt #"..counter..": "..name, 2)
				end
			end
		elseif Zorlen_DebugFlag and name and Zorlen_isEnemy() then
			Zorlen_debug("Active targeting attempt #"..counter..": "..name, 2)
		end
		if counter == number and healthscan and highesthealth > 0 then
			counter = 0
			healthscan = nil
			ClearTarget()
			Zorlen_debug("Clearing Target!", 2)
		elseif counter == number and not healthscan and highesthealth > 0 then
			counter = 0
			healthscan = true
			highesthealth = 0
			ClearTarget()
			Zorlen_debug("Clearing Target!", 2)
		end
		counter = counter + 1
	end
	Zorlen_debug("Active target not found!")
	if (UnitCanAttack("player", "target")) then
		ClearTarget()
		Zorlen_debug("Clearing Target!", 2)
	end
end
zTargetNearestActiveEnemyWithHighestHealth = Zorlen_TargetNearestActiveEnemyWithHighestHealth

--This is included for those who want to target an enemy that a hunter has marked.
function Zorlen_TargetMarkedEnemyOnly(cycles)
	local number = cycles or 7
	local name = UnitName("target")
	local counter = 1
	if not Zorlen_isEnemy() or not Zorlen_checkDebuff("Sniper") then
		if Zorlen_isFriendTargetingEnemy() and Zorlen_checkDebuff("Sniper", "targettarget") then
			Zorlen_debug("Assisting "..name.."!")
			AssistUnit("target")
			return true
		elseif UnitExists("pettarget") and Zorlen_checkDebuff("Sniper", "pettarget") then
			if not UnitIsUnit("target", "pettarget") and not Zorlen_checkDebuff("Sniper") then
				Zorlen_debug("Assisting your pet "..UnitName("pet").."!")
				AssistUnit("pet")
			end
			return true
		end
		if UnitCanAttack("player", "target") then
			ClearTarget()
			Zorlen_debug("Clearing Target!", 2)
		end
		while (counter <= number) do
			TargetNearestEnemy()
			name = UnitName("target")
			if Zorlen_isEnemy() and Zorlen_checkDebuff("Sniper") then
				Zorlen_debug("Marked target found for targeting attempt #"..counter..": "..name)
				return true
			elseif name and Zorlen_isEnemy() then
				Zorlen_debug("Marked targeting attempt #"..counter..": "..name, 2)
			end
			counter = counter + 1
		end
		Zorlen_debug("Marked target not found!")
		if UnitCanAttack("player", "target") then
			ClearTarget()
			Zorlen_debug("Clearing Target!", 2)
		end
	end
	return false
end
zTargetMarkedEnemyOnly = Zorlen_TargetMarkedEnemyOnly

--This is included for those who want to target an enemy that has been raid targeted with a skull icon.
function Zorlen_TargetEnemyRaidTargetOnly(icon, cycles)
	local i = icon or 8
	local number = cycles or 7
	local name = UnitName("target")
	local counter = 1
	if not Zorlen_isEnemy() or GetRaidTargetIndex("target") ~= i then
		if Zorlen_isFriendTargetingEnemy() and (GetRaidTargetIndex("targettarget") == i) then
			Zorlen_debug("Assisting "..name.."!")
			AssistUnit("target")
			return true
		elseif UnitExists("pettarget") and (GetRaidTargetIndex("pettarget") == i) then
			if not UnitIsUnit("target", "pettarget") and GetRaidTargetIndex("target") ~= i then
				Zorlen_debug("Assisting your pet "..UnitName("pet").."!")
				AssistUnit("pet")
			end
			return true
		end
		if UnitCanAttack("player", "target") then
			ClearTarget()
			Zorlen_debug("Clearing Target!", 2)
		end
		while (counter <= number) do
			TargetNearestEnemy()
			name = UnitName("target")
			if Zorlen_isEnemy() and (GetRaidTargetIndex("target") == i) then
				Zorlen_debug("Raid Target found for targeting attempt #"..counter..": "..name)
				return true
			elseif name and Zorlen_isEnemy() then
				Zorlen_debug("Raid Target targeting attempt #"..counter..": "..name, 2)
			end
			counter = counter + 1
		end
		Zorlen_debug("Raid Target not found!")
		if UnitCanAttack("player", "target") then
			ClearTarget()
			Zorlen_debug("Clearing Target!", 2)
		end
	end
	return false
end
zTargetEnemyRaidTargetOnly = Zorlen_TargetEnemyRaidTargetOnly



function Zorlen_TargetNamesFromArray(TargetNamesArray, EnemyOnly, Find, DeadOrAlive)
	if TargetNamesArray then
		local f = true
		if Find then
			f = nil
		end
		local counter = 1
		while TargetNamesArray[counter] do
			local n = UnitName("target")
			local h = UnitHealth("target")
			if not n or n == "" or (not DeadOrAlive and h == 0) or (not Find and TargetNamesArray[counter] ~= n) or (Find and not string.find(n, TargetNamesArray[counter])) or (EnemyOnly and not Zorlen_isEnemy()) then
				TargetByName(TargetNamesArray[counter], f)
			end
			local N = UnitName("target")
			local H = UnitHealth("target")
			if N and (DeadOrAlive or H > 0) and (Find or TargetNamesArray[counter] == N) and (not Find or string.find(N, TargetNamesArray[counter])) and (not EnemyOnly or Zorlen_isEnemy()) then
				return true
			elseif N ~= n or H ~= h then
				TargetLastTarget()
			end
			counter = counter + 1
		end
	end
	return false
end
zTargetNamesFromArray = Zorlen_TargetNamesFromArray






function Zorlen_GiveGroupUnit(mode, showdebug, notunit, notunitarray, buff, notlowesthealth, dispelabledebuff, findbuff1, findbuff2, isFunction, not_isFunction)
	local InRaid = UnitInRaid("player")
	local PLAYER = "player"
	local PET = ""
	local group = nil
	local NumMembers = nil
	local counter = nil
	local u = nil
	local unit = nil
	local h = nil
	local health = 0
	local notunitarraystart = 1
	local Mode = mode
	if InRaid then
		NumMembers = GetNumRaidMembers()
		counter = 1
		group = "raid"
	else
		NumMembers = GetNumPartyMembers()
		counter = 0
		group = "party"
		if not Mode then
			Mode = "pets"
		end
	end
	local goto = NumMembers + 2
	Zorlen_debug("Looking for group unit", showdebug)
	while counter <= NumMembers do
		if counter == 0 then
			u = PLAYER..""..PET
		else
			u = group..""..PET..""..counter
		end
		if UnitExists(u) then
			h = UnitHealth(u)
			if (not notunit or not UnitIsUnit(notunit, u)) and (notlowesthealth or h / UnitHealthMax(u) < 0.85) and h > 0 and UnitIsVisible(u) and not UnitIsDeadOrGhost(u) and (not buff or not Zorlen_checkBuff(buff, u)) and (not dispelabledebuff or Zorlen_checkDebuff(nil, u, "dispelable")) and ((not findbuff1 and not findbuff2) or (findbuff1 and Zorlen_checkBuff(findbuff1, u)) or (findbuff2 and Zorlen_checkBuff(findbuff2, u))) and (isFunction == nil or isFunction(u)) and (not_isFunction == nil or not not_isFunction(u)) then
				if PLAYER == "player" or UnitCreatureFamily(u) ~= LOCALIZATION_ZORLEN.Imp or not Zorlen_checkBuff("Spell_Shadow_ImpPhaseShift", u) then
					if not unit or h < health then
						local skip = nil
						if notunitarray then
							for i=notunitarraystart,goto do
								if not notunitarray[i] then
									break
								end
								if UnitIsUnit(u, notunitarray[i]) then
									skip = 1
									Zorlen_debug("Skipping group unit: "..u.." ("..UnitName(u)..")", showdebug)
									notunitarraystart = i + 1
									break
								end
							end
						end
						if not skip then
							if notlowesthealth then
								return u
							end
							unit = u
							health = h
						end
					end
				end
			end
		end
		counter = counter + 1
		if PLAYER == "player" and Mode ~= "nopets" and counter > NumMembers and (Mode == "pets" or not unit) then
			PLAYER = ""
			PET = "pet"
			if InRaid then
				counter = 1
			else
				counter = 0
			end
		end
	end
	if unit then
		Zorlen_debug("Group unit found: "..unit.." ("..UnitName(unit)..")", showdebug)
	else
		Zorlen_debug("Group unit not found", showdebug)
	end
	return unit
end


function Zorlen_GiveGroupUnitWithLowestHealth(mode, showdebug, notunit, notunitarray)
	return Zorlen_GiveGroupUnit(mode, showdebug, notunit, notunitarray)
end

function Zorlen_GiveGroupUnitWithLowestHealthWithoutBuff(buff, mode, showdebug, notunit, notunitarray)
	return Zorlen_GiveGroupUnit(mode, showdebug, notunit, notunitarray, buff)
end

function Zorlen_GiveGroupUnitWithLowestHealthWithBuff(findbuff1, findbuff2, mode, showdebug, notunit, notunitarray)
	return Zorlen_GiveGroupUnit(mode, showdebug, notunit, notunitarray, nil, nil, nil, findbuff1, findbuff2)
end

function Zorlen_GiveGroupUnitWithoutBuff(buff, mode, showdebug, notunit, notunitarray)
	return Zorlen_GiveGroupUnit(mode, showdebug, notunit, notunitarray, buff, 1)
end


function Zorlen_GiveGroupUnitWithDispelableDebuff(mode, showdebug, notunit, notunitarray)
	return Zorlen_GiveGroupUnit(mode, showdebug, notunit, notunitarray, nil, 1, 1)
end



function Zorlen_GiveGroupUnitWithoutBuffBySpellName(SpellName, mode, showdebug, notunit, notunitarray)
	if SpellName then
		if Zorlen_IsSpellKnown(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			local buff = GetSpellTexture(SpellID, 0)
			return Zorlen_GiveGroupUnitWithoutBuff(buff, mode, showdebug, notunit, notunitarray)
		end
	end
	return nil
end


function Zorlen_GiveGroupUnitWithLowestHealthWithoutBuffBySpellName(SpellName, mode, showdebug, notunit, notunitarray)
	if SpellName then
		if Zorlen_IsSpellKnown(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			local buff = GetSpellTexture(SpellID, 0)
			return Zorlen_GiveGroupUnitWithLowestHealthWithoutBuff(buff, mode, showdebug, notunit, notunitarray)
		end
	end
	return nil
end



function Zorlen_GiveGroupUnitWithLowestHealthWithBuffBySpellName(SpellName1, SpellName2, mode, showdebug, notunit, notunitarray)
	local SpellID1 = nil
	local findbuff1 = nil
	local SpellID2 = nil
	local findbuff2 = nil
	if SpellName1 then
		if Zorlen_IsSpellKnown(SpellName1) then
			SpellID1 = Zorlen_GetSpellID(SpellName1)
			findbuff1 = GetSpellTexture(SpellID1, 0)
		end
	end
	if SpellName2 then
		if Zorlen_IsSpellKnown(SpellName2) then
			SpellID2 = Zorlen_GetSpellID(SpellName2)
			findbuff2 = GetSpellTexture(SpellID2, 0)
		end
	end
	if findbuff1 or findbuff2 then
		return Zorlen_GiveGroupUnitWithLowestHealthWithBuff(findbuff1, findbuff2, mode, showdebug, notunit, notunitarray)
	end
	return nil
end



function Zorlen_TargetGroupMemberWithLowestHealth(mode, show, notunit, notunitarray)
	local unit = Zorlen_GiveGroupUnitWithLowestHealth(mode, show, notunit, notunitarray)
	if unit then
		if not UnitIsUnit("target", unit) then
			TargetUnit(unit)
		end
		return true
	end
	return false
end

function Zorlen_TargetGroupMemberWithoutBuff(buff, mode, showdebug, notunit, notunitarray)
	local unit = Zorlen_GiveGroupUnitWithoutBuff(buff, mode, showdebug, notunit, notunitarray)
	if unit then
		if not UnitIsUnit("target", unit) then
			TargetUnit(unit)
		end
		return true
	end
	return false
end

function Zorlen_TargetGroupMemberWithDispelableDebuff(mode, showdebug, notunit, notunitarray)
	local unit = Zorlen_GiveGroupUnitWithDispelableDebuff(mode, showdebug, notunit, notunitarray)
	if unit then
		if not UnitIsUnit("target", unit) then
			TargetUnit(unit)
		end
		return true
	end
	return false
end

function Zorlen_TargetGroupMemberWithoutBuffBySpellName(SpellName, mode, showdebug, notunit, notunitarray)
	local unit = Zorlen_GiveGroupUnitWithoutBuffBySpellName(SpellName, mode, showdebug, notunit, notunitarray)
	if unit then
		if not UnitIsUnit("target", unit) then
			TargetUnit(unit)
		end
		return true
	end
	return false
end



-- Will only assist a targeted friend if there target is an active enemy.
-- This is to try to allow safe assisting of a targeted friend.
function Zorlen_AssistTargetedFriendTargetingActiveEnemy()
	if Zorlen_isFriendTargetingActiveEnemy() then
		AssistUnit("target")
	end
end



Zorlen_RaidTargetNameArray = {
	LOCALIZATION_ZORLEN.YellowStar,
	LOCALIZATION_ZORLEN.OrangeCircle,
	LOCALIZATION_ZORLEN.PurpleDiamond,
	LOCALIZATION_ZORLEN.GreenTriangle,
	LOCALIZATION_ZORLEN.WhiteCrescentMoon,
	LOCALIZATION_ZORLEN.BlueSquare,
	LOCALIZATION_ZORLEN.RedX,
	LOCALIZATION_ZORLEN.WhiteSkull,
}

function Zorlen_GetRaidTargetName(unit)
	local unit = unit or "target"
	local i = GetRaidTargetIndex(unit)
	if i then
		return Zorlen_RaidTargetNameArray[i]
	end
	return ""
end





-- checks to see if a fist weapon is equipped in the main hand
function Zorlen_isMainHandFistWeapon()
	local slot = GetInventorySlotInfo("MainHandSlot")
	local link = GetInventoryItemLink("player", slot)
	if link then
		if Zorlen_GetItemSubType(link) == LOCALIZATION_ZORLEN["Fist Weapons"] then
			if GetInventoryItemBroken("player", slot) then
				Zorlen_debug("Your fist weapon in the main hand is broken.")
				return false
			end
			Zorlen_debug("You have a fist weapon equipped in the main hand.", 2)
			return true
		end
	end
	Zorlen_debug("You do not have a fist weapon equipped in the main hand.", 2)
	return false
end

-- checks to see if a fishing pole is equipped
function Zorlen_isFishingPoleEquipped()
	local slot = GetInventorySlotInfo("MainHandSlot")
	local link = GetInventoryItemLink("player", slot)
	if link then
		if Zorlen_GetItemSubType(link) == LOCALIZATION_ZORLEN["Fishing Pole"] then
			if GetInventoryItemBroken("player", slot) then
				Zorlen_debug("Your fishing pole in the main hand is broken.")
				return false
			end
			Zorlen_debug("You have a fishing pole equipped in the main hand.", 2)
			return true
		end
	end
	Zorlen_debug("You do not have a fishing pole equipped.", 2)
	return false
end

-- checks to see if a stave is equipped
function Zorlen_isStaveEquipped()
	local slot = GetInventorySlotInfo("MainHandSlot")
	local link = GetInventoryItemLink("player", slot)
	if link then
		if Zorlen_GetItemSubType(link) == LOCALIZATION_ZORLEN.Staves then
			if GetInventoryItemBroken("player", slot) then
				Zorlen_debug("Your stave in the main hand is broken.")
				return false
			end
			Zorlen_debug("You have a stave equipped in the main hand.", 2)
			return true
		end
	end
	Zorlen_debug("You do not have a stave equipped.", 2)
	return false
end

-- checks to see if a polearm is equipped
function Zorlen_isPolearmEquipped()
	local slot = GetInventorySlotInfo("MainHandSlot")
	local link = GetInventoryItemLink("player", slot)
	if link then
		if Zorlen_GetItemSubType(link) == LOCALIZATION_ZORLEN.Polearms then
			if GetInventoryItemBroken("player", slot) then
				Zorlen_debug("Your polearm in the main hand is broken.")
				return false
			end
			Zorlen_debug("You have a polearm equipped in the main hand.", 2)
			return true
		end
	end
	Zorlen_debug("You do not have a polearm equipped.", 2)
	return false
end

-- checks to see if a one or two handed mace is equipped in the main hand
function Zorlen_isMainHandMace()
	local slot = GetInventorySlotInfo("MainHandSlot")
	local link = GetInventoryItemLink("player", slot)
	if link then
		local itemType = Zorlen_GetItemSubType(link)
		if itemType == LOCALIZATION_ZORLEN["One-Handed Maces"] or itemType == LOCALIZATION_ZORLEN["Two-Handed Maces"] then
			if GetInventoryItemBroken("player", slot) then
				Zorlen_debug("Your mace in the main hand is broken.")
				return false
			end
			Zorlen_debug("You have a mace equipped in the main hand.", 2)
			return true
		end
	end
	Zorlen_debug("You do not have a mace equipped in the main hand.", 2)
	return false
end

-- checks to see if a one or two handed axe is equipped in the main hand
function Zorlen_isMainHandAxe()
	local slot = GetInventorySlotInfo("MainHandSlot")
	local link = GetInventoryItemLink("player", slot)
	if link then
		local itemType = Zorlen_GetItemSubType(link)
		if itemType == LOCALIZATION_ZORLEN["One-Handed Axes"] or itemType == LOCALIZATION_ZORLEN["Two-Handed Axes"] then
			if GetInventoryItemBroken("player", slot) then
				Zorlen_debug("Your axe in the main hand is broken.")
				return false
			end
			Zorlen_debug("You have a axe equipped in the main hand.", 2)
			return true
		end
	end
	Zorlen_debug("You do not have a axe equipped in the main hand.", 2)
	return false
end

-- checks to see if a one or two handed sword is equipped in the main hand
function Zorlen_isMainHandSword()
	local slot = GetInventorySlotInfo("MainHandSlot")
	local link = GetInventoryItemLink("player", slot)
	if link then
		local itemType = Zorlen_GetItemSubType(link)
		if itemType == LOCALIZATION_ZORLEN["One-Handed Swords"] or itemType == LOCALIZATION_ZORLEN["Two-Handed Swords"] then
			if GetInventoryItemBroken("player", slot) then
				Zorlen_debug("Your sword in the main hand is broken.")
				return false
			end
			Zorlen_debug("You have a sword equipped in the main hand.", 2)
			return true
		end
	end
	Zorlen_debug("You do not have a sword equipped in the main hand.", 2)
	return false
end

-- checks to see if a dagger is equipped in the main hand
function Zorlen_isMainHandDagger()
	local slot = GetInventorySlotInfo("MainHandSlot")
	local link = GetInventoryItemLink("player", slot)
	if link then
		if Zorlen_GetItemSubType(link) == LOCALIZATION_ZORLEN.Daggers then
			if GetInventoryItemBroken("player", slot) then
				Zorlen_debug("Your dagger in the main hand is broken.")
				return false
			end
			Zorlen_debug("You have a dagger equipped in the main hand.", 2)
			return true
		end
	end
	Zorlen_debug("You do not have a dagger equipped in the main hand.", 2)
	return false
end

-- checks to see if a shield is equipped
function Zorlen_isShieldEquipped()
	local slot = GetInventorySlotInfo("SecondaryHandSlot")
	local link = GetInventoryItemLink("player", slot)
	if link then
		if Zorlen_GetItemSubType(link) == LOCALIZATION_ZORLEN.Shields then
			if GetInventoryItemBroken("player", slot) then
				Zorlen_debug("Your shield is broken.")
				return false
			end
			Zorlen_debug("You have a shield equipped.", 2)
			return true
		end
	end
	Zorlen_debug("You do not have a shield equipped.", 2)
	return false
end

-- checks to see if a main hand item is equipped
function Zorlen_isMainHandEquipped()
	local slot = GetInventorySlotInfo("MainHandSlot")
	local link = GetInventoryItemLink("player", slot)
	if link then
		if GetInventoryItemBroken("player", slot) then
			Zorlen_debug("Your main hand item is broken.")
			return false
		end
		Zorlen_debug("You have a main hand item equipped.", 2)
		return true
	end
	Zorlen_debug("You do not have a main hand item equipped.", 2)
	return false
end


-- This is a test function
function Zorlen_GiveName_OffHandType()
	local link = GetInventoryItemLink("player", GetInventorySlotInfo("SecondaryHandSlot"))
	if link then
		Zorlen_debug(Zorlen_GetItemSubType(link), 1)
	else
		Zorlen_debug("You do not have a off hand item equipped.", 1)
	end
end

-- This is a test function
function Zorlen_GiveName_MainHandType()
	local link = GetInventoryItemLink("player", GetInventorySlotInfo("MainHandSlot"))
	if link then
		Zorlen_debug(Zorlen_GetItemSubType(link), 1)
	else
		Zorlen_debug("You do not have a main hand item equipped.", 1)
	end
end







function Zorlen_GiveMaxTargetRange(IsWithinRangeNumber, IsOutOfRangeNumber)
	if UnitExists("target") then
		if (not IsWithinRangeNumber or IsWithinRangeNumber <= 10) and (not IsOutOfRangeNumber or IsOutOfRangeNumber == 0) and CheckInteractDistance("target", 3) then
			Zorlen_debug("Your target is within 0 to 10 yards from you.")
			if IsWithinRangeNumber or IsOutOfRangeNumber then
				return true
			end
			return 10
		elseif (not IsWithinRangeNumber or IsWithinRangeNumber <= 11.1) and (not IsOutOfRangeNumber or (IsOutOfRangeNumber >= 10 and ((IsWithinRangeNumber and IsWithinRangeNumber > IsOutOfRangeNumber) or IsOutOfRangeNumber < 11.1))) and CheckInteractDistance("target", 1) then
			Zorlen_debug("Your target is within 10 to 11.1 yards from you.")
			if IsWithinRangeNumber or IsOutOfRangeNumber then
				return true
			end
			return 11.1
		elseif (not IsWithinRangeNumber or IsWithinRangeNumber <= 11.11) and (not IsOutOfRangeNumber or (IsOutOfRangeNumber >= 11.1 and ((IsWithinRangeNumber and IsWithinRangeNumber > IsOutOfRangeNumber) or IsOutOfRangeNumber < 11.11))) and CheckInteractDistance("target", 2) then
			Zorlen_debug("Your target is within 11.1 to 11.11 yards from you.")
			if IsWithinRangeNumber or IsOutOfRangeNumber then
				return true
			end
			return 11.11
		elseif (not IsWithinRangeNumber or IsWithinRangeNumber <= 28) and (not IsOutOfRangeNumber or (IsOutOfRangeNumber >= 11.11 and ((IsWithinRangeNumber and IsWithinRangeNumber > IsOutOfRangeNumber) or IsOutOfRangeNumber < 28))) and CheckInteractDistance("target", 4) then
			Zorlen_debug("Your target is within 11.11 to 28 yards from you.")
			if IsWithinRangeNumber or IsOutOfRangeNumber then
				return true
			end
			return 28
		elseif (not IsWithinRangeNumber or IsWithinRangeNumber <= 100) and (not IsOutOfRangeNumber or (IsOutOfRangeNumber >= 28 and ((IsWithinRangeNumber and IsWithinRangeNumber > IsOutOfRangeNumber) or IsOutOfRangeNumber < 100))) and not CheckInteractDistance("target", 4) then
			Zorlen_debug("Your target is more than 28 yards from you.")
			if IsWithinRangeNumber or IsOutOfRangeNumber then
				return true
			end
			return 100
		end
	end
	if IsWithinRangeNumber or IsOutOfRangeNumber then
		return false
	end
	Zorlen_debug("You do not have a target.")
	return 9999999999999999
end






-- From: Jiral
-- Casts healing spell of appropriate rank versus damage taken
--   Note: WoW doesn't return actual health numbers for non-self/party/raid members (only percents), so maximum rank will be used when healing these types of targets
function Zorlen_CastHealingSpell(SpellName, ManaArray, MinHealArray, MaxHealArray, TimeArray, LevelLearnedArray, Mode, RankAdj, unit, SpellButton)
--[[ 	SpellName - This is the localized name of the healing spell to cast
	ManaArray - This is an array of the mana cost for each rank of the spell.  Once the following parameters determine which rank is desired, this routine will cast the highest rank less than or equal to the chosen rank for which the caster has sufficient mana to cast
	MinHealArray - This is an array of the minimum number of hit points healed by each rank of the spell
	MaxHealArray - This is an array of the maximum number of hit points healed by each rank of the spell
	Mode - This is used to determine which rank of the spell to cast:
		"maximum" - Always use the maximum rank known
		"over" - Use the rank of the spell whose minimum healed amount will fully heal the target
		"under" - Use one rank less than the rank that would have been chosen by "over"
		"standard" - Use the rank of the spell whose average healed amount will fully heal the target
	RankAdj - Once the Mode has determined the suggested rank to use, this value (if present) is used to adjust the rank up or down
]]
	if Zorlen_IsSpellKnown(SpellName) then
		local SpellNameArray={}
		local SpellButtonArray={}
		local SpellRankArray={}

		local SpellRanks = 1
		repeat
			SpellNameArray[SpellRanks] = SpellName
			SpellButtonArray[SpellRanks] = SpellButton
			SpellRankArray[SpellRanks] = SpellRanks
			SpellRanks = SpellRanks + 1
		until not ManaArray[SpellRanks]
		return Zorlen_CastMultiNamedHealingSpell(SpellNameArray, SpellRankArray, ManaArray, MinHealArray, MaxHealArray, TimeArray, LevelLearnedArray, Mode, RankAdj, unit, SpellButtonArray)
	end
	return false	-- Don't know any rank of the spell, so just exit
end

-- From: Jiral
function Zorlen_CastMultiNamedHealingSpell(SpellNameArray, SpellRankArray, ManaArray, MinHealArray, MaxHealArray, TimeArray, LevelLearnedArray, Mode, RankAdj, unit, SpellButtonArray)
--[[ 	SpellNameArray - This is an array of localized healing spells to cast
	SpellRankArray - This is an array of the ranks for the associated SpellNameArray
	ManaArray - This is an array of the mana cost for each rank of the spell.  Once the following parameters determine which rank is desired, this routine will cast the highest rank less than or equal to the chosen rank for which the caster has sufficient mana to cast
	MinHealArray - This is an array of the minimum number of hit points healed by each rank of the spell
	MaxHealArray - This is an array of the maximum number of hit points healed by each rank of the spell
	Mode - This is used to determine which rank of the spell to cast:
		"maximum" - Always use the maximum rank known
		"over" - Use the rank of the spell whose minimum healed amount will fully heal the target
		"under" - Use one rank less than the rank that would have been chosen by "over"
		"standard" - Use the rank of the spell whose average healed amount will fully heal the target
	RankAdj - Once the Mode has determined the suggested rank to use, this value (if present) is used to adjust the rank up or down
]]
	local CurrentCastingSpellRank = Zorlen_CastingSpellRank
	local retarget = nil
	local dotarget = nil
	local SpellRanks = 1
	while ManaArray[SpellRanks+1] do										-- Quick loop to calculate spell ranks
		SpellRanks = SpellRanks + 1
	end
	for i=1,SpellRanks do
		local castadj = 1
		if TimeArray[i] < 3.5 then
			if TimeArray[i] < 1.5 then
				castadj = 1.5 / 3.5
			else
				castadj = TimeArray[i]/3.5
			end
		end
		local leveladj = 1
		if LevelLearnedArray[i] < 20 then
			leveladj = 1-((20-LevelLearnedArray[i])*0.0375)
		end	
		MinHealArray[i] = MinHealArray[i] + math.min(Zorlen_PlusHealingMin + (Zorlen_VariableHealing * castadj * leveladj),MaxHealArray[i])
		MaxHealArray[i] = MaxHealArray[i] + math.min(Zorlen_PlusHealingMax + (Zorlen_VariableHealing * castadj * leveladj),MaxHealArray[i])
	end
	local SpellTarget = unit or "target"
	if unit then
		if not UnitExists(unit) or UnitCanAttack("player", unit) or not UnitIsFriend(unit, "player") or not (UnitHealth(unit) > 0) or not UnitIsVisible(unit) or UnitIsDeadOrGhost(unit) then
			return false
		end
		if not UnitIsUnit("target", unit) and UnitIsFriend("target", "player") then
			dotarget = 1
		end
	elseif not UnitExists("target") or UnitCanAttack("player", "target") or not UnitIsFriend("target", "player") or not (UnitHealth("target") > 0) or not UnitIsVisible("target") or UnitIsDeadOrGhost("target") or UnitIsUnit("target", "player") then
		SpellTarget = "player"
	end
	local TargetMaxHealth = UnitHealthMax(SpellTarget)
	local TargetDamage = UnitHealthMax(SpellTarget) - UnitHealth(SpellTarget)
	if TargetDamage == 0 then
		return false							-- Notheing to heal, so don't waste the time/mana
	end
	local DamageArray = {}
	if Mode=="maximum" or SpellTarget=="target" then						-- If requesting maximum heal or healing out-of-group
		for i=1,SpellRanks do					 							-- 	Force rank to be max known
			DamageArray[i]=0
		end
	elseif Mode=="over" then												-- If requesting overheal
		for i=1,SpellRanks do												-- 	Assume heal will only heal minimum amount
			DamageArray[i]=MinHealArray[i]
		end
	elseif (not (UnitAffectingCombat(SpellTarget) or Mode=="standard")) or Mode == "under" then	-- If target not in combat or requesting underheal
		for i=1,SpellRanks do												--	Don't heal more then minimum of next rank
			DamageArray[i]=MinHealArray[i+1] or 999999
		end
	else																	-- If none of the above
		for i=1,SpellRanks do												--	Assume heal will heal average amount
			DamageArray[i]=(MinHealArray[i]+MaxHealArray[i])/2
		end
	end
	DamageArray[SpellRanks] = TargetDamage									-- Assume final rank will fully heal target
	for i=1,SpellRanks do
		if TargetDamage <= DamageArray[i] then
			local k = i
			if RankAdj then
				k = k + RankAdj
				if k < 1 then
					k = 1
				elseif k > SpellRanks then
					k = SpellRanks
				end
			end
			for j = k,1,-1 do
				if UnitMana("player") >= ManaArray[j] then
					if Zorlen_IsSpellKnown(SpellNameArray[j]) then
						if Zorlen_IsSpellKnown(SpellNameArray[j], SpellRankArray[j]) then
							if not CurrentCastingSpellRank then
								CurrentCastingSpellRank = 0
							end
							if not Zorlen_isCasting(SpellNameArray[j]) or ((SpellRankArray[j] - CurrentCastingSpellRank) > 1) or ((CurrentCastingSpellRank - SpellRankArray[j]) > 1) then
								if Zorlen_isCasting() then
									SpellStopCasting()
									Zorlen_debug("Stopping current cast to cast: "..SpellNameArray[j].."("..LOCALIZATION_ZORLEN.Rank.." "..SpellRankArray[j]..") on "..SpellTarget.." ("..UnitName(SpellTarget)..")")
								else
									if dotarget then
										TargetUnit(unit)
										retarget = 1
									end
									if SpellButtonArray[j] then
										if UnitIsUnit(SpellTarget, "target") then
											local inRange = IsActionInRange(SpellButtonArray[j])
											local hasRange = ActionHasRange(SpellButtonArray[j])
											if hasRange then
												if inRange ~= 1 then
													return false
												end
											end
										end
										local isUsable = IsUsableAction(SpellButtonArray[j])
										local _, duration = GetActionCooldown(SpellButtonArray[j])
										local isCurrent = IsCurrentAction(SpellButtonArray[j])
										if isUsable ~= 1 or duration ~= 0 or isCurrent == 1 then
											return false
										end
									elseif not Zorlen_checkCooldownByName(SpellNameArray[j]) then
										return false
									end
									Zorlen_CastingUnit = SpellTarget
									local SpellTargetName = UnitName(SpellTarget)
									CastSpellByName(SpellNameArray[j].."("..LOCALIZATION_ZORLEN.Rank.." "..SpellRankArray[j]..")")
									Zorlen_debug("Casting: "..SpellNameArray[j].."("..LOCALIZATION_ZORLEN.Rank.." "..SpellRankArray[j]..") on "..SpellTarget.." ("..SpellTargetName..")")
								end
							end
							if (retarget) then
								TargetLastTarget()
							end
							if SpellIsTargeting() then
								if SpellCanTargetUnit(SpellTarget) then
									SpellTargetUnit(SpellTarget)
								else
									SpellStopTargeting()
									return false
								end
							end
							return true
						end
					end
				end
			end
			return false	-- Not enough mana to cast any rank, so just exit
		end	
	end
end

-- From: Jiral
--Edited by: BigRedBrent
function Zorlen_InventoryScan(Healing, ShadowDamage, SpellDamage)
	if not (Healing or ShadowDamage or SpellDamage) then
		return
	end
	Zorlen_PlusHealingMin  = 0
	Zorlen_PlusHealingMax  = 0
	Zorlen_VariableHealing = 0
	Zorlen_SpellDamage = 0
	Zorlen_ShadowDamage = 0
	local SetsWorn = {}
	local SetName = nil
	local counter = 1
	local found = nil
	local _ = nil
	local minplus = nil
	local maxplus = nil
	local bonusName = nil
	local setname = nil
	local varplus = nil
	for slot=0,23 do
		if GetInventoryItemLink("player", slot) then
			local hasItem, hasCooldown, repairCost = ZORLEN_Tooltip:SetInventoryItem("player", slot)
			local Lines = ZORLEN_Tooltip:NumLines()
			SetName = nil
			--Zorlen_debug("Unit slot: "..slot.."  Total Toool Tip Lines: "..Lines, 2)
			for line=1,Lines do
				local lt = getglobal("ZORLEN_TooltipTextLeft"..line)
				local lefttext = nil
				if lt:IsShown() then
					lefttext = lt:GetText()
					if lefttext == "" then
						lefttext = nil
					end
				end
				if lefttext then
					--Zorlen_debug("Unit slot: "..slot.."  Lefttext Line#"..line..": '"..lefttext.."'")
					found, _, setname = string.find(lefttext, "^(.*) %(%d+%/%d+%)$")
					if found then
						SetName = setname
						if SetsWorn[SetName] then
						   break
						else
							SetsWorn[SetName] = true
						end
					elseif not SetName or not string.find(lefttext, "^%(%d+%) ") then
						while true do
							found = nil
							_, _, minplus, maxplus, bonusName = string.find(lefttext, "^%+(%d+)%-(%d+) (.*)$")
							if not bonusName then
									_, _, bonusName, minplus, maxplus = string.find(lefttext, "^(.*) %+(%d+)%-(%d+)$")
								if not bonusName then
									_, _, minplus, bonusName = string.find(lefttext, "^%+(%d+) (.*)$")
									if not bonusName then
										_, _, bonusName, minplus = string.find(lefttext, "^(.*) %+(%d+)$")
									end
								end
							end
							if Healing then
									if bonusName then
										counter = 1
										while LOCALIZATION_ZORLEN.HealingBonusWordsArray[counter] do
											if LOCALIZATION_ZORLEN.HealingBonusWordsArray[counter] == bonusName then
												minplus = tonumber(minplus)
												if maxplus then
													maxplus = tonumber(maxplus)
													Zorlen_debug("Slot: "..slot.."  Healing Bonus: "..minplus.."-"..maxplus)
												else
													maxplus = minplus
													Zorlen_debug("Slot: "..slot.."  Healing Bonus: "..minplus)
												end
												Zorlen_debug("Text: "..lefttext, 2)
												Zorlen_PlusHealingMin = Zorlen_PlusHealingMin + minplus
												Zorlen_PlusHealingMax = Zorlen_PlusHealingMax + maxplus
												found = 1
												break
											end
											counter = counter + 1
										end
										if found then
											break
										end
									else
										counter = 1
										while LOCALIZATION_ZORLEN.HealingBonusPhraseArray[counter] do
											found, _, varplus = string.find(lefttext, LOCALIZATION_ZORLEN.HealingBonusPhraseArray[counter])
											if found then
												varplus = tonumber(varplus)
												Zorlen_debug("Slot: "..slot.."  Healing Bonus: "..varplus)
												Zorlen_debug("Text: "..lefttext, 2)
												Zorlen_VariableHealing = Zorlen_VariableHealing + varplus
												break
											end
											counter = counter + 1
										end
										if found then
											break
										end
									end
							end
							if SpellDamage or Healing or ShadowDamage then
									if bonusName then
										counter = 1
										while LOCALIZATION_ZORLEN.SpellDamageAndHealingBonusWordsArray[counter] do
											if LOCALIZATION_ZORLEN.SpellDamageAndHealingBonusWordsArray[counter] == bonusName then
												minplus = tonumber(minplus)
												if maxplus then
													maxplus = tonumber(maxplus)
													Zorlen_debug("Slot: "..slot.."  Spell and Healing Bonus: "..minplus.."-"..maxplus)
												else
													maxplus = minplus
													Zorlen_debug("Slot: "..slot.."  Spell and Healing Bonus: "..minplus)
												end
												Zorlen_debug("Text: "..lefttext, 2)
												if Healing then
													Zorlen_PlusHealingMin = Zorlen_PlusHealingMin + minplus
													Zorlen_PlusHealingMax = Zorlen_PlusHealingMax + maxplus
												end
												if SpellDamage then
													Zorlen_SpellDamage = Zorlen_SpellDamage + minplus
												end
												if ShadowDamage then
													Zorlen_ShadowDamage = Zorlen_ShadowDamage + minplus
												end
												found = 1
												break
											end
											counter = counter + 1
										end
										if found then
											break
										end
									else
										counter = 1
										while LOCALIZATION_ZORLEN.SpellDamageAndHealingBonusPhraseArray[counter] do
											found, _, varplus = string.find(lefttext, LOCALIZATION_ZORLEN.SpellDamageAndHealingBonusPhraseArray[counter])
											if found then
												varplus = tonumber(varplus)
												Zorlen_debug("Slot: "..slot.."  Spell and Healing Bonus: "..varplus)
												Zorlen_debug("Text: "..lefttext, 2)
												if Healing then
													Zorlen_VariableHealing = Zorlen_VariableHealing + varplus
												end
												if SpellDamage then
													Zorlen_SpellDamage = Zorlen_SpellDamage + varplus
												end
												if ShadowDamage then
													Zorlen_ShadowDamage = Zorlen_ShadowDamage + varplus
												end
												break
											end
											counter = counter + 1
										end
										if found then
											break
										end
									end
							end
							if SpellDamage or ShadowDamage then
									if bonusName then
										counter = 1
										while LOCALIZATION_ZORLEN.SpellDamageBonusWordsArray[counter] do
											if LOCALIZATION_ZORLEN.SpellDamageBonusWordsArray[counter] == bonusName then
												minplus = tonumber(minplus)
												if maxplus then
													maxplus = tonumber(maxplus)
													Zorlen_debug("Slot: "..slot.."  Spell Bonus: "..minplus.."-"..maxplus)
												else
													maxplus = minplus
													Zorlen_debug("Slot: "..slot.."  Spell Bonus: "..minplus)
												end
												Zorlen_debug("Text: "..lefttext, 2)
												if SpellDamage then
													Zorlen_SpellDamage = Zorlen_SpellDamage + minplus
												end
												if ShadowDamage then
													Zorlen_ShadowDamage = Zorlen_ShadowDamage + minplus
												end
												found = 1
												break
											end
											counter = counter + 1
										end
										if found then
											break
										end
									else
										counter = 1
										while LOCALIZATION_ZORLEN.SpellDamageBonusPhraseArray[counter] do
											found, _, varplus = string.find(lefttext, LOCALIZATION_ZORLEN.SpellDamageBonusPhraseArray[counter])
											if found then
												varplus = tonumber(varplus)
												Zorlen_debug("Slot: "..slot.."  Spell Bonus: "..varplus)
												Zorlen_debug("Text: "..lefttext, 2)
												if SpellDamage then
													Zorlen_SpellDamage = Zorlen_SpellDamage + varplus
												end
												if ShadowDamage then
													Zorlen_ShadowDamage = Zorlen_ShadowDamage + varplus
												end
												break
											end
											counter = counter + 1
										end
										if found then
											break
										end
										if string.find(lefttext, "^"..LOCALIZATION_ZORLEN.BrilliantWizardOil) then
											Zorlen_debug("Slot: "..slot.."  Spell Bonus: 36")
											Zorlen_debug("Text: "..lefttext, 2)
											if SpellDamage then
												Zorlen_SpellDamage = Zorlen_SpellDamage + 36
											end
											if ShadowDamage then
												Zorlen_ShadowDamage = Zorlen_ShadowDamage + 36
											end
											break
										elseif string.find(lefttext, "^"..LOCALIZATION_ZORLEN.WizardOil) then
											Zorlen_debug("Slot: "..slot.."  Spell Bonus: 24")
											Zorlen_debug("Text: "..lefttext, 2)
											if SpellDamage then
												Zorlen_SpellDamage = Zorlen_SpellDamage + 24
											end
											if ShadowDamage then
												Zorlen_ShadowDamage = Zorlen_ShadowDamage + 24
											end
											break
										elseif string.find(lefttext, "^"..LOCALIZATION_ZORLEN.LesserWizardOil) then
											Zorlen_debug("Slot: "..slot.."  Spell Bonus: 16")
											Zorlen_debug("Text: "..lefttext, 2)
											if SpellDamage then
												Zorlen_SpellDamage = Zorlen_SpellDamage + 16
											end
											if ShadowDamage then
												Zorlen_ShadowDamage = Zorlen_ShadowDamage + 16
											end
											break
										elseif string.find(lefttext, "^"..LOCALIZATION_ZORLEN.MinorWizardOil) then
											Zorlen_debug("Slot: "..slot.."  Spell Bonus: 8")
											Zorlen_debug("Text: "..lefttext, 2)
											if SpellDamage then
												Zorlen_SpellDamage = Zorlen_SpellDamage + 8
											end
											if ShadowDamage then
												Zorlen_ShadowDamage = Zorlen_ShadowDamage + 8
											end
											break
										end
									end
							end
							if ShadowDamage then
									if bonusName then
											counter = 1
											while LOCALIZATION_ZORLEN.ShadowDamageBonusWordsArray[counter] do
												if LOCALIZATION_ZORLEN.HealingBonusWordsArray[counter] == bonusName then
													minplus = tonumber(minplus)
													if maxplus then
														maxplus = tonumber(maxplus)
														Zorlen_debug("Slot: "..slot.."  Shadow Bonus: "..minplus.."-"..maxplus)
													else
														maxplus = minplus
														Zorlen_debug("Slot: "..slot.."  Shadow Bonus: "..minplus)
													end
													Zorlen_debug("Text: "..lefttext, 2)
													Zorlen_ShadowDamage = Zorlen_ShadowDamage + minplus
													found = 1
													break
												end
												counter = counter + 1
											end
											if found then
												break
											end
									else
										counter = 1
										while LOCALIZATION_ZORLEN.ShadowDamageBonusPhraseArray[counter] do
											found, _, varplus = string.find(lefttext, LOCALIZATION_ZORLEN.ShadowDamageBonusPhraseArray[counter])
											if found then
												varplus = tonumber(varplus)
												Zorlen_debug("Slot: "..slot.."  Shadow Bonus: "..varplus)
												Zorlen_debug("Text: "..lefttext, 2)
												Zorlen_ShadowDamage = Zorlen_ShadowDamage + varplus
												break
											end
											counter = counter + 1
										end
										if found then
											break
										end
									end
							end
							if true then
								break
							end
						end
					end
				end
			end
		end
	end
	Zorlen_debug("Inventory scan complete:")
	if Healing then
		Zorlen_debug("  Zorlen_PlusHealing: "..Zorlen_PlusHealingMin.." - "..Zorlen_PlusHealingMax)
		Zorlen_debug("  Zorlen_VariableHealing = "..Zorlen_VariableHealing)
	end
	if SpellDamage then
		Zorlen_debug("  Zorlen_SpellDamage = "..Zorlen_SpellDamage)
	end
	if ShadowDamage then
		Zorlen_debug("  Zorlen_ShadowDamage = "..Zorlen_ShadowDamage)
	end
end




function Zorlen_useTrinketByName(name, find, id)
	if name or id then
		local n = Zorlen_GiveTrinketSlotNumberByName(name, find, id)
		if n then
			local s, d, e = GetInventoryItemCooldown("player", n)
			if e == 1 then
				if s == 0 then
					UseInventoryItem(n)
					return true
				elseif name then
					Zorlen_debug("Trinket: ( "..name.." ) in slot#"..n.." is on cooldown!")
				else
					Zorlen_debug("Trinket: ( "..Zorlen_GiveItemNameFromItemLink(GetInventoryItemLink("player", n)).." ) in slot#"..n.." is on cooldown!")
				end
			elseif name then
				Zorlen_debug("Trinket: ( "..name.." ) in slot#"..n.." has nothing to use!")
			else
				Zorlen_debug("Trinket: ( "..Zorlen_GiveItemNameFromItemLink(GetInventoryItemLink("player", n)).." ) in slot#"..n.." has nothing to use!")
			end
		end
	end
	return false
end
function Zorlen_useTrinketByItemID(id, name, find)
	return Zorlen_useTrinketByName(name, find, id)
end




function Zorlen_isTrinketByNameReady(name, find, id)
	if name or id then
		local n = Zorlen_GiveTrinketSlotNumberByName(name, find, id)
		if n then
			local s, d, e = GetInventoryItemCooldown("player", n)
			if e == 1 then
				if s == 0 then
					return true
				elseif name then
					Zorlen_debug("Trinket: ( "..name.." ) in slot#"..n.." is on cooldown!")
				else
					Zorlen_debug("Trinket: ( "..Zorlen_GiveItemNameFromItemLink(GetInventoryItemLink("player", n)).." ) in slot#"..n.." is on cooldown!")
				end
			elseif name then
				Zorlen_debug("Trinket: ( "..name.." ) in slot#"..n.." has nothing to use!")
			else
				Zorlen_debug("Trinket: ( "..Zorlen_GiveItemNameFromItemLink(GetInventoryItemLink("player", n)).." ) in slot#"..n.." has nothing to use!")
			end
		end
	end
	return false
end
function Zorlen_isTrinketByItemIDReady(id, name, find)
	return Zorlen_useTrinketByName(name, find, id)
end


function Zorlen_isTrinketByNameEquipped(name, find, id)
	if Zorlen_GiveTrinketSlotNumberByName(name, find, id) then
		return true
	end
	return false
end
function Zorlen_isTrinketByItemIDEquipped(id, name, find)
	return Zorlen_isTrinketByNameEquipped(name, find, id)
end


function Zorlen_GiveTrinketSlotNumberByName(name, find, id)
	if name or id then
		local id = Zorlen_GiveItemIDFromItemLink(id) or id
		for i=0,1 do
			local slot = GetInventorySlotInfo("Trinket"..i.."Slot")
			local link = GetInventoryItemLink("player", slot)
			local n, d = Zorlen_DecodeItemLink(link)
			if id then
				if d and (d == id or ""..d == id or "item:"..d..":0:0:0" == id or "item:"..d == id or d..":0:0:0" == id) then
					return slot
				end
			elseif name then
				if n then
					if (find and string.find(n, name)) or n == name then
						return slot
					end
				end
			end
		end
		if name then
			Zorlen_debug("Trinket: ( "..name.." ) is not equipped!")
		else
			local N = Zorlen_GetItemNameFromItemID(id)
			if N then
				Zorlen_debug("Trinket: ( "..N.." ) is not equipped!")
			end
		end
	else
		Zorlen_debug("Trinket name and id not given!")
	end
	return nil
end
function Zorlen_GiveTrinketSlotNumberByItemID(id, name, find)
	return Zorlen_GiveTrinketSlotNumberByName(name, find, id)
end




function Zorlen_useItemByName(name, find, id)
	local slot = Zorlen_GiveEquippedItemSlotNumberByName(name, find, id)
	if slot then
		return Zorlen_useEquippedItemBySlotNumber(slot)
	end
	return Zorlen_useContainerItemByName(name, find, id)
end
function Zorlen_useItemByItemID(id, name, find)
	return Zorlen_useItemByName(name, find, id)
end


function Zorlen_isItemByNameEquippedOrInContainer(name, find, notname, mode, id)
	if Zorlen_GiveEquippedItemSlotNumberByName(name, find, id) or Zorlen_GiveContainerItemSlotNumberByName(name, find, notname, mode, id) then
		return true
	end
	return false
end
function Zorlen_isItemByItemIDEquippedOrInContainer(id, name, find, notname, mode)
	return Zorlen_isItemByNameEquippedOrInContainer(name, find, notname, mode, id)
end




function Zorlen_useContainerItemByName(name, find, notname, mode, id)
	local bag, slot = Zorlen_GiveContainerItemSlotNumberByName(name, find, notname, mode, id)
	return Zorlen_useContainerItemBySlotNumber(bag, slot, name)
end
function Zorlen_useContainerItemByItemID(id, name, find, notname, mode)
	return Zorlen_useContainerItemByName(name, find, notname, mode, id)
end

function Zorlen_useContainerItemWithLowestCountByName(name, find, notname, id)
	local bag, slot = Zorlen_GiveContainerItemSlotNumberWithLowestCountByName(name, find, notname, id)
	return Zorlen_useContainerItemBySlotNumber(bag, slot, name)
end
function Zorlen_useContainerItemWithLowestCountByItemID(id, name, find, notname, mode)
	return Zorlen_useContainerItemWithLowestCountByName(name, find, notname, mode, id)
end

function Zorlen_isItemByNameInContainer(name, find, notname, mode, id)
	if Zorlen_GiveContainerItemSlotNumberByName(name, find, notname, mode, id) then
		return true
	end
	return false
end
function Zorlen_isItemByItemIDInContainer(id, name, find, notname, mode)
	return Zorlen_isItemByNameInContainer(name, find, notname, mode, id)
end

function Zorlen_useContainerItemBySlotNumber(bag, slot, name)
	if bag and bag ~= "" and slot and slot ~= "" then
		if GetContainerItemLink(bag, slot) then
			local s, d, e = GetContainerItemCooldown(bag, slot)
			if s == 0 then
				CloseMerchant()
				CloseBankFrame()
				CloseMail()
				CloseTrade()
				CloseAuctionHouse()
				UseContainerItem(bag, slot)
				return true
			else
				if name then
					Zorlen_debug("Bag Item: ( "..name.." ) in  Bag#: "..bag.."  Slot#: "..slot.."  is on cooldown!")
				else
					Zorlen_debug("Bag Item in  Bag#: "..bag.."  Slot#: "..slot.."  is on cooldown!")				
				end
			end
		else
			Zorlen_debug("No item is in  Bag#: "..bag.."  Slot#: "..slot)
		end
	else
		Zorlen_debug("No container slot given!")
	end
	return false
end

function Zorlen_GiveContainerItemSlotNumberWithLowestCountByName(name, find, notname, id)
	return Zorlen_GiveContainerItemSlotNumberByName(name, find, notname, "LowestCount", id)
end
function Zorlen_GiveContainerItemSlotNumberWithLowestCountByItemID(id, name, find, notname)
	return Zorlen_GiveContainerItemSlotNumberWithLowestCountByName(name, find, notname, id)
end

function Zorlen_GiveContainerItemSlotNumberByName(name, find, notname, mode, id)
	if name or id then
		local id = Zorlen_GiveItemIDFromItemLink(id) or id
		local fullcount = 0
		local c = 0
		local b = nil
		local s = nil
		local link = nil
		local bagslots = nil
		local PlayerLevel = UnitLevel("player")
		for bag=0,NUM_BAG_FRAMES do
			bagslots = GetContainerNumSlots(bag)
			if bagslots and bagslots > 0 then
				for slot=1,bagslots do
					link = GetContainerItemLink(bag, slot)
					if link then
						local n, d = Zorlen_DecodeItemLink(link)
						if (id and d and (d == id or ""..d == id or "item:"..d..":0:0:0" == id or "item:"..d == id or d..":0:0:0" == id)) or (n and find and string.find(n, name) and (not notname or not string.find(n, notname))) or (not find and n == name) then
							local RequiredLevelNumberToHigh = nil
							if PlayerLevel ~= Zorlen_MaxPlayerLevel then
								local RequiredLevelNumber = nil
								local hasCooldown, repairCost = ZORLEN_Tooltip:SetBagItem(bag, slot)
								local Lines = ZORLEN_Tooltip:NumLines()
								Zorlen_debug("Bag Item: ( "..n.." )  Bag#: "..bag.."  Slot#: "..slot.."  Total Toool Tip Lines: "..Lines, 2)
								for line=2,Lines do
									local lt = getglobal("ZORLEN_TooltipTextLeft"..line)
									local lefttext = nil
									if lt:IsShown() then
										lefttext = lt:GetText()
										if lefttext == "" then
											lefttext = nil
										end
									end
									if lefttext then
										Zorlen_debug("Bag Item: ( "..n.." )  Bag#: "..bag.."  Slot#: "..slot.."  Lefttext Line#"..line..": "..lefttext, 2)
										if string.find(lefttext, LOCALIZATION_ZORLEN.RequiresLevel) then
											local found, _, RequiredLevel = string.find(lefttext, "(%d+)")
											if found then
												RequiredLevelNumber = tonumber(RequiredLevel)
												if RequiredLevelNumber and RequiredLevelNumber > PlayerLevel then
													Zorlen_debug("Bag Item: ( "..n.." )  Bag#: "..bag.."  Slot#: "..slot.."  Required Level: "..RequiredLevelNumber.." is to high!")
													RequiredLevelNumberToHigh = 1
													break
												end
											end
											if RequiredLevelNumber then
												Zorlen_debug("Bag Item: ( "..n.." )  Bag#: "..bag.."  Slot#: "..slot.."  Required Level: "..RequiredLevelNumber, 2)
												break
											end
										end
									end
								end
							end
							if not RequiredLevelNumberToHigh then
								local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag, slot)
								if mode ~= "LowestCount" then
									return bag, slot, itemCount
								end
								fullcount = fullcount + itemCount
								if not b or not s or (itemCount and itemCount < c) then
									c = itemCount
									b = bag
									s = slot
								end
							end
						end
					end
				end
			end
		end
		if b and s then
			return b, s, fullcount
		end
		if name then
			Zorlen_debug("Bag Item: ( "..name.." ) is not in any of your bags!", 2)
		else
			local N = Zorlen_GetItemNameFromItemID(id)
			if N then
				Zorlen_debug("Bag Item: ( "..N.." ) is not in any of your bags!", 2)
			end
		end
	else
		Zorlen_debug("Bag Item name and id not given!", 2)
	end
	return nil
end

function Zorlen_GiveContainerItemSlotNumberWithLowestCountByToolTipLineText(name, find, notname, side)
	return Zorlen_GiveContainerItemSlotNumberByToolTipLineText(name, find, notname, "LowestCount", side)
end

function Zorlen_GiveContainerItemSlotNumberByToolTipLineText(name, find, notname, mode, side)
	if name and name ~= "" then
		local fullcount = 0
		local c = 0
		local b = nil
		local s = nil
		local bagslots = nil
		local PlayerLevel = UnitLevel("player")
		for bag=0,NUM_BAG_FRAMES do
			bagslots = GetContainerNumSlots(bag)
			if bagslots and bagslots > 0 then
				for slot=1,bagslots do
					if GetContainerItemLink(bag, slot) then
						local RequiredLevelNumberToHigh = nil
						local lt = nil
						local lefttext = nil
						local rt = nil
						local righttext = nil
						local ItemFound = nil
						local NotItemFound = nil
						local RequiredLevelNumber = nil
						local hasCooldown, repairCost = ZORLEN_Tooltip:SetBagItem(bag, slot)
						local Lines = ZORLEN_Tooltip:NumLines()
						for line=1,Lines do
							if side ~= "right" then
								lt = getglobal("ZORLEN_TooltipTextLeft"..line)
								lefttext = nil
								if lt:IsShown() then
									lefttext = lt:GetText()
									if lefttext == "" then
										lefttext = nil
									end
								end
								if lefttext then
									if find and notname and string.find(lefttext, notname) then
										NotItemFound = 1
										break
									end
									if (find and string.find(lefttext, name)) or (not find and lefttext == name) then
										ItemFound = 1
										if not notname or line == Lines then
											Zorlen_debug("Bag Item  Bag#: "..bag.."  Slot#: "..slot.."  Lefttext Line#"..line..": "..lefttext, 2)
											break
										end
									end
								end
							end
							if side ~= "left" then
								rt = getglobal("ZORLEN_TooltipTextRight"..line)
								righttext = nil
								if rt:IsShown() then
									righttext = rt:GetText()
									if righttext == "" then
										righttext = nil
									end
								end
								if righttext then
									if find and notname and string.find(righttext, notname) then
										NotItemFound = 1
										break
									end
									if (find and string.find(righttext, name)) or (not find and righttext == name) then
										ItemFound = 1
										if not notname or line == Lines then
											Zorlen_debug("Bag Item  Bag#: "..bag.."  Slot#: "..slot.."  Righttext Line#"..line..": "..righttext, 2)
											break
										end
									end
								end
							end
						end
						if ItemFound and not NotItemFound then
							Zorlen_debug("Bag Item  Bag#: "..bag.."  Slot#: "..slot.."  Total Toool Tip Lines: "..Lines, 2)
							if PlayerLevel ~= Zorlen_MaxPlayerLevel then
								for line=2,Lines do
									lt = getglobal("ZORLEN_TooltipTextLeft"..line)
									lefttext = nil
									if lt:IsShown() then
										lefttext = lt:GetText()
										if lefttext == "" then
											lefttext = nil
										end
									end
									if lefttext then
										Zorlen_debug("Bag Item  Bag#: "..bag.."  Slot#: "..slot.."  Lefttext Line#"..line..": "..lefttext, 2)
										if string.find(lefttext, LOCALIZATION_ZORLEN.RequiresLevel) then
											local found, _, RequiredLevel = string.find(lefttext, "(%d+)")
											if found then
												RequiredLevelNumber = tonumber(RequiredLevel)
												if RequiredLevelNumber and RequiredLevelNumber > PlayerLevel then
													RequiredLevelNumberToHigh = 1
													Zorlen_debug("Bag Item  Bag#: "..bag.."  Slot#: "..slot.."  Required Level: "..RequiredLevelNumber.." is to high!")
													break
												end
											end
										end
									end
									if RequiredLevelNumber then
										Zorlen_debug("Bag Item  Bag#: "..bag.."  Slot#: "..slot.."  Required Level: "..RequiredLevelNumber, 2)
										break
									end
								end
							end
							if not RequiredLevelNumberToHigh then
								local texture, itemCount, locked, quality, readable = GetContainerItemInfo(bag, slot)
								if mode ~= "LowestCount" then
									return bag, slot, itemCount
								end
								fullcount = fullcount + itemCount
								if not b or (itemCount and itemCount < c) then
									c = itemCount
									b = bag
									s = slot
								end
							end
						end
					end
				end
			end
		end
		if b then
			return b, s, fullcount
		end
	else
		Zorlen_debug("Bag Item tool tip text not given!", 2)
	end
	return nil
end




function Zorlen_useEquippedItemByName(name, find, id)
	return Zorlen_useEquippedItemBySlotNumber(Zorlen_GiveEquippedItemSlotNumberByName(name, find, id), name)
end
function Zorlen_useEquippedItemByItemID(id, name, find)
	return Zorlen_useEquippedItemByName(name, find, id)
end

function Zorlen_isItemByNameEquipped(name, find, id)
	if Zorlen_GiveEquippedItemSlotNumberByName(name, find, id) then
		return true
	end
	return false
end
function Zorlen_isItemByItemIDEquipped(id, name, find)
	return Zorlen_isItemByNameEquipped(name, find, id)
end

function Zorlen_useEquippedItemBySlotNumber(slot, name)
	if slot and slot ~= "" then
		if GetInventoryItemLink("player", slot) then
			local s, d, e = GetInventoryItemCooldown("player", slot)
			if e == 1 then
				if s == 0 then
					UseInventoryItem(slot)
					return true
				else
					if name and name ~= "" then
						Zorlen_debug("Equipped Item: ( "..name.." ) in slot#"..slot.." is on cooldown!")
					else
						Zorlen_debug("Equipped Item in slot#"..slot.." is on cooldown!")				
					end
				end
			else
				if name and name ~= "" then
					Zorlen_debug("Equipped Item: ( "..name.." ) in slot#"..slot.." has nothing to use!")
				else
					Zorlen_debug("Equipped Item in slot#"..slot.." has nothing to use!")
				end
			end
		else
			Zorlen_debug("No item is equipped in slot#"..slot)
		end
	else
		Zorlen_debug("No slot number given!")
	end
	return false
end

function Zorlen_GiveEquippedItemSlotNumberByName(name, find, id)
	if name or id then
		local id = Zorlen_GiveItemIDFromItemLink(id) or id
		for slot=0,19 do
			local link = GetInventoryItemLink("player", slot)
			local n, d = Zorlen_DecodeItemLink(link)
			if id then
				if d and (d == id or ""..d == id or "item:"..d..":0:0:0" == id or "item:"..d == id or d..":0:0:0" == id) then
					return slot
				end
			elseif name then
				if n then
					if (find and string.find(n, name)) or n == name then
						return slot
					end
				end
			end
		end
		if name then
			Zorlen_debug("Item: ( "..name.." ) is not equipped!")
		else
			local N = Zorlen_GetItemNameFromItemID(id)
			if N then
				Zorlen_debug("Item: ( "..N.." ) is not equipped!")
			end
		end
	else
		Zorlen_debug("Equipped Item name and id not given!")
	end
	return nil
end
function Zorlen_GiveEquippedItemSlotNumberByItemID(id, name, find)
	return Zorlen_GiveEquippedItemSlotNumberByName(name, find, id)
end


function Zorlen_GiveContainerItemCountByName(name, find, id)
	local count = 0
	if name or id then
		local id = Zorlen_GiveItemIDFromItemLink(id) or id
		for b=0, NUM_BAG_FRAMES do
			local bagslots = GetContainerNumSlots(b)
			if bagslots and bagslots > 0 then
				for s=1, bagslots do
					local link = GetContainerItemLink(b, s)
					local n, d = Zorlen_DecodeItemLink(link)
					if id then
						if d and (d == id or ""..d == id or "item:"..d..":0:0:0" == id or "item:"..d == id or d..":0:0:0" == id) then
							local _, c = GetContainerItemInfo(b, s)
							count = count + c
						end
					elseif name then
						if n then
							if (find and string.find(n, name)) or n == name then
								local _, c = GetContainerItemInfo(b, s)
								count = count + c
							end
						end
					end
				end
			end
		end
	end
	return count
end
function Zorlen_GiveContainerItemCountByItemID(id, name, find)
	return Zorlen_GiveContainerItemCountByName(name, find, id)
end


function Zorlen_DecodeItemLink(link)
	if link then
		local found, _, id, name = string.find(link, "item:(%d+):.*%[(.*)%]")
		if found then
			id = tonumber(id)
			return name, id
		end
	end
	return nil
end

function Zorlen_GiveItemNameFromItemLink(link)
	local name = Zorlen_DecodeItemLink(link)
	return name
end

function Zorlen_GiveItemIDFromItemLink(link)
	local name, id = Zorlen_DecodeItemLink(link)
	return id
end

function Zorlen_GetItemInfo(id)
	local id = Zorlen_GiveItemIDFromItemLink(id) or id
	return GetItemInfo(id)
end

function Zorlen_GetItemSubType(id)
	local Name, Link, Quality, Level, Type, SubType, Count = Zorlen_GetItemInfo(id)
	return SubType
end

function Zorlen_GetItemNameFromItemID(id)
	local Name, Link, Quality, Level, Type, SubType, Count = Zorlen_GetItemInfo(id)
	return Name
end


function Zorlen_UpdateEatItemInfo(MaxItems)
	Zorlen_EatUpdateBlocked = nil
	local Max = MaxItems or 15
	if not MaxItems and Zorlen_isCurrentClassMage and Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.ConjureFood) then
		Max = 7
	end
	local bag, slot, fullcount, level = Zorlen_GetEatSlotNumber(Max)
	if bag then
		local link = GetContainerItemLink(bag, slot)
		local Name = Zorlen_GiveItemNameFromItemLink(link)
		if Name ~= Zorlen_EatItemName then
			Zorlen_EatItemName = Name
			Zorlen_debug("Updated Food Item:  "..Name)
		end
		if slot ~= Zorlen_EatSlotID or bag ~= Zorlen_EatBagID then
			Zorlen_EatBagID = bag
			Zorlen_EatSlotID = slot
			Zorlen_debug("Updated Food  '"..Zorlen_EatItemName.."'  Bag#: "..bag.."  Slot#: "..slot)
		end
		Zorlen_EatItemCount = fullcount
		Zorlen_EatItemlevel = level
	else
		Zorlen_EatItemName = ""
		Zorlen_EatBagID = nil
		Zorlen_EatSlotID = nil
		Zorlen_EatItemCount = 0
		Zorlen_EatItemlevel = 16
	end
	if Zorlen_EatItemCount > 0 then
		Zorlen_debug("Updated Food  '"..Zorlen_EatItemName.."'  Count:  "..Zorlen_EatItemCount)
	else
		Zorlen_debug("Updated Food Item Count:  "..Zorlen_EatItemCount)
	end
end

function Zorlen_UpdateDrinkItemInfo(MaxItems)
	Zorlen_DrinkUpdateBlocked = nil
	if UnitPowerType("player") == 0 or
		Zorlen_isCurrentClassDruid or
		Zorlen_isCurrentClassShaman or
		Zorlen_isCurrentClassMage or
		Zorlen_isCurrentClassHunter or
		Zorlen_isCurrentClassWarlock or
		Zorlen_isCurrentClassPaladin or
		Zorlen_isCurrentClassPriest
	then
		local Max = MaxItems or 15
		if not MaxItems and Zorlen_isCurrentClassMage and Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.ConjureWater) then
			Max = 7
		end
		local bag, slot, fullcount, level = Zorlen_GetDrinkSlotNumber(Max)
		if bag then
			local link = GetContainerItemLink(bag, slot)
			local Name = Zorlen_GiveItemNameFromItemLink(link)
			if Name ~= Zorlen_DrinkItemName then
				Zorlen_DrinkItemName = Name
				Zorlen_debug("Updated Drink Item:  "..Name)
			end
			if bag ~= Zorlen_DrinkBagID or slot ~= Zorlen_DrinkSlotID then
				Zorlen_DrinkBagID = bag
				Zorlen_DrinkSlotID = slot
				Zorlen_debug("Updated Drink  '"..Zorlen_DrinkItemName.."'  Bag#: "..bag.."  Slot#: "..slot)
			end
			Zorlen_DrinkItemCount = fullcount
			Zorlen_DrinkItemLevel = level
		else
			Zorlen_DrinkItemName = ""
			Zorlen_DrinkBagID = nil
			Zorlen_DrinkSlotID = nil
			Zorlen_DrinkItemCount = 0
			Zorlen_DrinkItemLevel = 16
		end
		if Zorlen_DrinkItemCount > 0 then
			Zorlen_debug("Updated Drink  '"..Zorlen_DrinkItemName.."'  Count:  "..Zorlen_DrinkItemCount)
		else
			Zorlen_debug("Updated Drink Item Count:  "..Zorlen_DrinkItemCount)
		end
	end
end


function Zorlen_GetEatSlotNumber(MaxItems)
	local Max = MaxItems or 15
	local Start = 1
	if not Zorlen_GiveContainerItemSlotNumberByName(LOCALIZATION_ZORLEN.Conjured, 1, LOCALIZATION_ZORLEN.Water) then
		if (Max < 8) then
			Start = nil
		else
			Start = 8
		end
	end
	local name = {
		LOCALIZATION_ZORLEN.ConjuredCinnamonRoll,
		LOCALIZATION_ZORLEN.ConjuredSweetRoll,
		LOCALIZATION_ZORLEN.ConjuredSourdough,
		LOCALIZATION_ZORLEN.ConjuredPumpernickel,
		LOCALIZATION_ZORLEN.ConjuredRye,
		LOCALIZATION_ZORLEN.ConjuredBread,
		LOCALIZATION_ZORLEN.ConjuredMuffin,
		LOCALIZATION_ZORLEN.FoodToolTipText3180,
		LOCALIZATION_ZORLEN.FoodToolTipText2148,
		LOCALIZATION_ZORLEN.FoodToolTipText1392,
		LOCALIZATION_ZORLEN.FoodToolTipText874,
		LOCALIZATION_ZORLEN.FoodToolTipText552,
		LOCALIZATION_ZORLEN.FoodToolTipText243,
		LOCALIZATION_ZORLEN.FoodToolTipText61,
		LOCALIZATION_ZORLEN.FoodToolTipTextAny,
	}
	local bag = nil
	local slot = nil
	local b = nil
	local s = nil
	local notname = LOCALIZATION_ZORLEN.well_fed
	local level = nil
	local fullcount = nil
	if Start then
		if Start ~= 1 and Max == 15 then
			if not Zorlen_GiveContainerItemSlotNumberByToolTipLineText(name[Max], 1, nil, nil, "left") then
				return nil
			elseif not Zorlen_GiveContainerItemSlotNumberByToolTipLineText(name[Max]..".*"..notname, 1, nil, nil, "left") then
				notname = nil
			elseif not Zorlen_GiveContainerItemSlotNumberByToolTipLineText(name[Max], 1, notname, nil, "left") then
				notname = nil
			end
		end
		for i = Start,Max do
			if Start < 8 then
				b, s, fullcount = Zorlen_GiveContainerItemSlotNumberWithLowestCountByName(name[i], 1)
			else
				b, s, fullcount = Zorlen_GiveContainerItemSlotNumberWithLowestCountByToolTipLineText(name[i], 1, notname, "left")
			end
			if b then
				bag = b
				slot = s
				level = i
				break
			end
		end
	end
	if bag then
		return bag, slot, fullcount, level
	end
	return nil
end

function Zorlen_GetDrinkSlotNumber(MaxItems)
	local Max = MaxItems or 15
	local Start = 1
	if not Zorlen_GiveContainerItemSlotNumberByName(LOCALIZATION_ZORLEN.AllConjuredWater, 1) then
		if (Max <= 7) then
			Start = nil
		else
			Start = 8
		end
	end
	local name = {
		LOCALIZATION_ZORLEN.ConjuredCrystalWater,
		LOCALIZATION_ZORLEN.ConjuredSparklingWater,
		LOCALIZATION_ZORLEN.ConjuredMineralWater,
		LOCALIZATION_ZORLEN.ConjuredSpringWater,
		LOCALIZATION_ZORLEN.ConjuredPurifiedWater,
		LOCALIZATION_ZORLEN.ConjuredFreshWater,
		LOCALIZATION_ZORLEN.ConjuredWater,
		LOCALIZATION_ZORLEN.DrinkToolTipText4200,
		LOCALIZATION_ZORLEN.DrinkToolTipText2934,
		LOCALIZATION_ZORLEN.DrinkToolTipText1992,
		LOCALIZATION_ZORLEN.DrinkToolTipText1344,
		LOCALIZATION_ZORLEN.DrinkToolTipText835,
		LOCALIZATION_ZORLEN.DrinkToolTipText436,
		LOCALIZATION_ZORLEN.DrinkToolTipText151,
		LOCALIZATION_ZORLEN.DrinkToolTipTextAny,
	}
	local bag = nil
	local slot = nil
	local b = nil
	local s = nil
	local level = nil
	local fullcount = nil
	if Start then
		if Start ~= 1 and Max == 15 then
			if not Zorlen_GiveContainerItemSlotNumberByToolTipLineText(name[Max], 1, nil, nil, "left") then
				return nil
			end
		end
		for i = Start,Max do
			if i <= 7 then
				b, s, fullcount = Zorlen_GiveContainerItemSlotNumberWithLowestCountByName(name[i], 1)
			else
				b, s, fullcount = Zorlen_GiveContainerItemSlotNumberWithLowestCountByToolTipLineText(name[i], 1, nil, "left")
			end
			if b then
				bag = b
				slot = s
				level = i
				break
			end
		end
	end
	if bag then
		return bag, slot, fullcount, level
	end
	return nil
end



function Zorlen_Eat()
	if Zorlen_notInCombat() and UnitHealth("player") / UnitHealthMax("player") <= 0.9 and not isEatingActive() then
		if ZorlenConfig[ZORLEN_ZPN][ZORLEN_FOODOFF] or Zorlen_EatUpdateBlocked or not Zorlen_EatBagID then
			Zorlen_UpdateEatItemInfo()
		end
		if Zorlen_EatBagID then
			local MageSpellKnown = nil
			local MaxItems = 15
			if Zorlen_isCurrentClassMage and Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.ConjureFood) then
				MageSpellKnown = 1
				MaxItems = 7
			end
			local link = GetContainerItemLink(Zorlen_EatBagID, Zorlen_EatSlotID)
			local name = Zorlen_GiveItemNameFromItemLink(link)
			if not name or name ~= Zorlen_EatItemName then
				Zorlen_UpdateEatItemInfo(MaxItems)
			end
			if Zorlen_EatBagID then
				if UnitHealth("player") / UnitHealthMax("player") <= 0.9 and not isEatingActive() and Zorlen_useContainerItemBySlotNumber(Zorlen_EatBagID, Zorlen_EatSlotID) then
					return true
				end
			elseif MageSpellKnown and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.ConjureFood) then
				CastSpellByName(LOCALIZATION_ZORLEN.ConjureFood)
				return true
			end
		end
	end
	return false
end

function Zorlen_Drink()
	if Zorlen_notInCombat() and UnitPowerType("player") == 0 and UnitMana("player") / UnitManaMax("player") <= 0.9 and not isDrinkingActive() then
		if ZorlenConfig[ZORLEN_ZPN][ZORLEN_FOODOFF] or Zorlen_DrinkUpdateBlocked or not Zorlen_DrinkBagID then
			Zorlen_UpdateDrinkItemInfo()
		end
		if Zorlen_DrinkBagID then
			local MageSpellKnown = nil
			local MaxItems = 15
			if Zorlen_isCurrentClassMage and Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.ConjureWater) then
				MageSpellKnown = 1
				MaxItems = 7
			end
			local link = GetContainerItemLink(Zorlen_DrinkBagID, Zorlen_DrinkSlotID)
			local name = Zorlen_GiveItemNameFromItemLink(link)
			if not name or name ~= Zorlen_DrinkItemName then
				Zorlen_UpdateDrinkItemInfo(MaxItems)
			end
			if Zorlen_DrinkBagID then
				if UnitMana("player") / UnitManaMax("player") <= 0.9 and not isDrinkingActive() and Zorlen_useContainerItemBySlotNumber(Zorlen_DrinkBagID, Zorlen_DrinkSlotID) then
					return true
				end
			elseif MageSpellKnown and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.ConjureWater) then
				CastSpellByName(LOCALIZATION_ZORLEN.ConjureWater)
				return true
			end
		end
	end
	return false
end



function Zorlen_MakeEatMacro(show)
	return Zorlen_MakeMacro(LOCALIZATION_ZORLEN.EatMacroName, "/zorlen eat", 0, "Spell_Misc_Food", nil, 1, show)
end

function Zorlen_MakeDrinkMacro(show)
	return Zorlen_MakeMacro(LOCALIZATION_ZORLEN.DrinkMacroName, "/zorlen drink", 0, "Spell_Misc_Drink", nil, 1, show)
end



function Zorlen_MakeMacro(name, macro, percharacter, macroicontecture, iconindex, replace, show, nocreate, replacemacroindex, replacemacroname)
	local globalorlocal = "global"
	local macroindex = replacemacroindex or GetMacroIndexByName(name) or 0
	local macroiconindex = iconindex or 1
	if not iconindex and macroicontecture then
		local mi = Zorlen_GiveMacroIconIndex(macroicontecture)
		if mi then
			macroiconindex = mi
		end
	end
	if not replacemacroindex and not (macroindex > 0) then
		if not nocreate then
			if name then
				local numglobal, numperchar = GetNumMacros()
				local pc = 0
				local num = numglobal
				if percharacter == 1 then
					pc = 1
					num = numperchar
					globalorlocal = "per character"
				end
				if num < 18 then
					CreateMacro(name, macroiconindex, macro, 1, pc)
					macroindex = GetMacroIndexByName(name)
					if macroindex > 0 then
						Zorlen_debug("Created  '"..name.."'  macro in "..globalorlocal.." index: "..macroindex, show)
						return true
					end
				elseif name then
					Zorlen_debug("No "..globalorlocal.." macro spaces left to create  '"..name.."'  macro!", show)
				else
					Zorlen_debug("No "..globalorlocal.." macro spaces left to create macro!", show)
				end
			end
		end
	elseif macroindex > 0 then
		if replace or replacemacroindex then
			if replacemacroname then
				EditMacro(macroindex, name, macroiconindex, macro, 1)
				if name then
					Zorlen_debug("Replaced  '"..name.."'  macro in index: "..macroindex, show)
				else
					Zorlen_debug("Replaced macro in index: "..macroindex, show)
				end
			else
				EditMacro(macroindex, nil, macroiconindex, macro, 1)
				if name then
					Zorlen_debug("Replaced  '"..name.."'  macro in index: "..macroindex, show)
				else
					Zorlen_debug("Replaced macro in index: "..macroindex, show)
				end
			end
		elseif name then
			Zorlen_debug("Found  '"..name.."'  macro in index: "..macroindex, show)
		else
			Zorlen_debug("Found macro in index: "..macroindex, show)
		end
		return true
	end
	return false
end




function Zorlen_EditMacro(name, macro, macroicontecture, iconindex, show, replacemacroindex, replacemacroname)
	return Zorlen_MakeMacro(name, macro, nil, macroicontecture, iconindex, 1, show, 1, replacemacroindex, replacemacroname)
end


function Zorlen_MakeMacros()
	Zorlen_MakeEatMacro(1)
	Zorlen_MakeDrinkMacro(1)
	if Zorlen_isCurrentClassWarlock then
		Zorlen_Warlock_MakeMacros()
	elseif Zorlen_isCurrentClassHunter then
		Zorlen_Hunter_MakeMacros()
	end
end


function Zorlen_GiveMacroIconIndex(texture)
	for i = 1, GetNumMacroIcons() do
		if (string.find(GetMacroIconInfo(i), texture)) then
			Zorlen_debug("Macro Icon Index#"..i.." for texture:"..texture, 2)
			return i
		end
	end
	Zorlen_debug("Macro Icon Index# not found for texture:"..texture, 2)
	return nil
end

-- Test Function
function Zorlen_ShowAllMacroIconIndexTextures(numberstart, numberend)
	local s = 1
	local e = GetNumMacroIcons()
	if numberend then
		if numberend <= e and numberend >= s then
			e = numberend
		end
	end
	if numberstart then
		if numberstart <= e and numberstart >= s then
			s = numberstart
		end
	end
	if s > e then
		return false
	end
	if GetNumMacroIcons() >= s then
		for i = s, e do
			Zorlen_debug("Macro Icon Index#"..i..": Texture: "..GetMacroIconInfo(i), 1)
		end
		return true
	end
	return false
end


function Zorlen_ShowButtonToolTips(startslot, stopslot, line, side)
	local start = 1
	local stop = 120
	if startslot and startslot <= 120 and startslot > 0 then
		start = startslot
	end
	if stopslot and stopslot <= 120 and stopslot >= start then
		stop = stopslot
	end
	for i = start, stop do
		if HasAction(i) then
			local lt = nil
			local lefttext = nil
			local rt = nil
			local righttext = nil
			ZORLEN_Tooltip:SetAction(i)
			local startlines = 1
			local Lines = ZORLEN_Tooltip:NumLines()
			if line and line <= Lines and line > 0 then
				startlines = line
				Lines = line
			end
			for LINE = startlines,Lines do
				if side ~= "right" then
					lt = getglobal("ZORLEN_TooltipTextLeft"..LINE)
					lefttext = nil
					if lt:IsShown() then
						lefttext = lt:GetText()
						if lefttext == "" then
							lefttext = nil
						end
					end
					if lefttext then
						Zorlen_debug("Action Button Slot#: "..i.."  Lefttext Line#"..LINE..": "..lefttext, 1)
					end
				end
				if side ~= "left" then
					rt = getglobal("ZORLEN_TooltipTextRight"..LINE)
					righttext = nil
					if rt:IsShown() then
						righttext = rt:GetText()
						if righttext == "" then
							righttext = nil
						end
					end
					if righttext then
						Zorlen_debug("Action Button Slot#: "..i.."  Righttext Line#"..LINE..": "..righttext, 1)
					end
				end
			end
		end
	end
end







function Zorlen_CastCommonRegisteredSpell(InfoArray ,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w)
	if type(InfoArray) ~= "table" then
		if not b then
			return false
		end
		local z = {}
		z.Rank = InfoArray
		z.SpellName = b
		z.DebuffName = c
		z.DebuffImmune = d
		z.ManaNeeded = e
		z.SelfHealthGreaterThanPercent = f
		z.EnemyTargetNotNeeded = g
		z.BuffName = h
		z.TargetThatUsesManaNeeded = i
		z.DebuffCheckIncluded = j
		z.DebuffCheck = k
		z.BuffCheckIncluded = l
		z.BuffCheck = m
		z.SpellCheckNotNeeded = n
		z.BuffUnit = o
		z.DoDebuffIncluded = p
		z.DoDebuff = q
		z.DoBuffIncluded = r
		z.DoBuff = s
		z.StopCasting = t
		z.NoRangeCheck = u
		z.Test = v
		z.DebuffTimer = w
		InfoArray = z
	elseif not InfoArray.SpellName then
		return false
	end
	if InfoArray.Rank then
		InfoArray.SpellButton = Zorlen_Button[InfoArray.SpellName.."."..InfoArray.Rank]
	else
		InfoArray.SpellButton = Zorlen_Button[InfoArray.SpellName]
	end
	local SpellID, STOP = Zorlen_CheckIfCommonRegisteredSpellCastable(InfoArray)
	if SpellID then
		if not InfoArray.Test then
			if InfoArray.StopCasting and Zorlen_isCasting() then
				SpellStopCasting()
			else
				if InfoArray.SpellButton then
					UseAction(InfoArray.SpellButton)
				elseif InfoArray.Rank and InfoArray.Rank <= Zorlen_GetSpellRank(InfoArray.SpellName) then
					CastSpellByName(InfoArray.SpellName.."("..LOCALIZATION_ZORLEN.Rank.." "..InfoArray.Rank..")")
				else
					CastSpell(SpellID, 0)
				end
			end
		end
		return true
	elseif STOP and not InfoArray.Test then
		SpellStopCasting()
	end
	return false
end

function Zorlen_CheckIfCommonRegisteredSpellCastable(InfoArray)
	if not InfoArray or not InfoArray.SpellName then
		return nil
	end
	local _ = nil
	local isUsable = nil
	local notEnoughMana = nil
	local duration = nil
	local hasRange = nil
	local inRange = nil
	local isCurrent = nil
	local SpellID = nil
	InfoArray.AnySpellButton = InfoArray.SpellButton or Zorlen_Button[InfoArray.SpellName..".Any"]
	if InfoArray.DoBuffIncluded or InfoArray.BuffName or InfoArray.BuffCheckIncluded then
		InfoArray.BuffUnit = InfoArray.BuffUnit or "player"
	else
		InfoArray.BuffUnit = "target"
	end
	InfoArray.TargetName = UnitName(InfoArray.BuffUnit)
	if InfoArray.DebuffImmune or Zorlen_isImmune(InfoArray.SpellName, InfoArray.TargetName) then
		if Zorlen_isCasting(InfoArray.SpellName) then
			return nil, 1
		end
		return nil
	elseif InfoArray.SpellButton then
		isUsable, notEnoughMana = IsUsableAction(InfoArray.SpellButton)
		isCurrent = IsCurrentAction(InfoArray.SpellButton)
	elseif InfoArray.SpellCheckNotNeeded or InfoArray.AnySpellButton or Zorlen_IsSpellKnown(InfoArray.SpellName) then
		SpellID = Zorlen_GetSpellID(InfoArray.SpellName)
		Zorlen_debug(""..InfoArray.SpellName.." was not found on any of the action bars!")
	else
		return nil
	end
	if InfoArray.AnySpellButton then
		_, duration, _ = GetActionCooldown(InfoArray.AnySpellButton)
		hasRange = ActionHasRange(InfoArray.AnySpellButton)
		inRange = IsActionInRange(InfoArray.AnySpellButton)
	end
	if not Zorlen_isCasting() or InfoArray.StopCasting then
		if not Zorlen_isChanneling(InfoArray.SpellName) and (InfoArray.SpellButton or not SpellIsTargeting() or InfoArray.StopCasting) then
			if not InfoArray.SpellButton or ( isUsable == 1 and not notEnoughMana and (isCurrent ~= 1 or InfoArray.StopCasting) ) then
				if not InfoArray.AnySpellButton or ( duration == 0 and (InfoArray.NoRangeCheck or not hasRange or inRange ~= 0) ) then
					if InfoArray.AnySpellButton or Zorlen_checkCooldown(SpellID) then
						if InfoArray.SpellButton or (not InfoArray.ManaNeeded or UnitMana("player") >= InfoArray.ManaNeeded) then
							if not InfoArray.TargetThatUsesManaNeeded or UnitPowerType(InfoArray.BuffUnit) == 0 then
								if not InfoArray.SelfHealthGreaterThanPercent or Zorlen_HealthPercent("player") > InfoArray.SelfHealthGreaterThanPercent then
									if InfoArray.EnemyTargetNotNeeded or Zorlen_isEnemy() then
										if (not InfoArray.DoDebuffIncluded and not InfoArray.DebuffName and not InfoArray.DebuffCheckIncluded and not InfoArray.DebuffTimer) or (InfoArray.DoDebuffIncluded and InfoArray.DoDebuff) or (not Zorlen_AllDebuffSlotsUsed() and not Zorlen_IsTimer(InfoArray.SpellName, nil, "InternalZorlenSpellCastDelay") and ((InfoArray.DebuffName and not Zorlen_checkDebuffByName(InfoArray.DebuffName)) or (InfoArray.DebuffCheckIncluded and not InfoArray.DebuffCheck) or (InfoArray.DebuffTimer and not Zorlen_IsTimer(InfoArray.SpellName, InfoArray.TargetName, "InternalZorlenSpellTimers")))) then
											if (not InfoArray.DoBuffIncluded and not InfoArray.BuffName and not InfoArray.BuffCheckIncluded) or (InfoArray.DoBuffIncluded and InfoArray.DoBuff) or (not Zorlen_IsTimer(InfoArray.SpellName, InfoArray.TargetName, "InternalZorlenSpellCastDelay") and ((InfoArray.BuffName and not Zorlen_checkBuffByName(InfoArray.BuffName, InfoArray.BuffUnit)) or (InfoArray.BuffCheckIncluded and not InfoArray.BuffCheck))) then
												if InfoArray.SpellButton then
													return InfoArray.SpellButton
												else
													return SpellID
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	elseif Zorlen_isCasting(InfoArray.SpellName) then
		if (not InfoArray.DoDebuffIncluded and not InfoArray.DebuffName and not InfoArray.DebuffCheckIncluded and not InfoArray.DebuffTimer) or (InfoArray.DoDebuffIncluded and InfoArray.DoDebuff) or (not Zorlen_AllDebuffSlotsUsed() and ((not InfoArray.DebuffTimer and InfoArray.DebuffName and not Zorlen_checkDebuffByName(InfoArray.DebuffName)) or (not InfoArray.DebuffTimer and InfoArray.DebuffCheckIncluded and not InfoArray.DebuffCheck) or (InfoArray.DebuffTimer and not Zorlen_IsTimer(InfoArray.SpellName, InfoArray.TargetName, "InternalZorlenSpellTimers")))) then
			if (not InfoArray.DoBuffIncluded and not InfoArray.BuffName and not InfoArray.BuffCheckIncluded) or (InfoArray.DoBuffIncluded and InfoArray.DoBuff) or ((InfoArray.BuffName and not Zorlen_checkBuffByName(InfoArray.BuffName, InfoArray.BuffUnit)) or (InfoArray.BuffCheckIncluded and not InfoArray.BuffCheck)) then
			elseif InfoArray.DoBuffIncluded or InfoArray.BuffName or InfoArray.BuffCheckIncluded then
				return nil, 1
			end
		elseif InfoArray.DoDebuffIncluded or InfoArray.DebuffName or InfoArray.DebuffCheckIncluded or InfoArray.DebuffTimer then
			return nil, 1
		end
	end
	return nil
end

--[[

-- Example code:
function castSpellName(SpellRank, test)
	local z = {}
	z.SpellName = 
	z.Rank = SpellRank
	z.Test = test
	z.DebuffName = 
	z.DebuffImmune = 
	z.ManaNeeded = 
	z.SelfHealthGreaterThanPercent = 
	z.EnemyTargetNotNeeded = 
	z.BuffName = 
	z.TargetThatUsesManaNeeded = 
	z.DebuffCheckIncluded = 
	z.DebuffCheck = 
	z.BuffCheckIncluded = 
	z.BuffCheck = 
	z.SpellCheckNotNeeded = 
	z.BuffUnit = 
	z.DoDebuffIncluded = 
	z.DoDebuff = 
	z.DoBuffIncluded = 
	z.DoBuff = 
	z.StopCasting = 
	z.NoRangeCheck = 
	z.DebuffTimer = 
	return Zorlen_CastCommonRegisteredSpell(z)
end

--]]


function Zorlen_SetTimer(Seconds, Name, Pre, Tag, show, Function, StartTimer)
	local Sec = StartTimer or Seconds
	if Name and Name ~= "" and Sec and Sec > 0 then
		local tt = ""
		local TT = nil
		if StartTimer then
			if StartTimer > 0 and StartTimer < Seconds then
				local S = (Seconds - StartTimer)
				TT = {S, Name, Pre, Tag, show, Function}
				tt = "TT"
				Function = nil
			else
				return
			end
		end
		local p = Pre or ""
		local t = Tag or ""
		local fn = p.."___Pre_DEVIDER_123__"..Name.."___Tag_DEVIDER_456__"..t.."___Timer_Timer_DEVIDER_789__"..tt
		local counter = Zorlen_Timer.Slot[fn] or 1
		if not Zorlen_Timer.Slot[fn] then
			while Zorlen_Timer.FullName[counter] and Zorlen_Timer.Seconds[Zorlen_Timer.FullName[counter]] do
				counter = counter + 1
			end
		end
		if Zorlen_Timer.FullName[counter] and Zorlen_Timer.FullName[counter] ~= fn then
			Zorlen_Timer.Seconds[Zorlen_Timer.FullName[counter]] = nil
			Zorlen_Timer.Slot[Zorlen_Timer.FullName[counter]] = nil
			Zorlen_Timer.TimerTimer[Zorlen_Timer.FullName[counter]] = nil
		end
		Zorlen_Timer.Seconds[fn] = Sec
		Zorlen_Timer.Slot[fn] = counter
		Zorlen_Timer.TimerTimer[fn] = TT
		Zorlen_Timer.Name[counter] = Name
		Zorlen_Timer.Pre[counter] = p
		Zorlen_Timer.Tag[counter] = t
		Zorlen_Timer.FullName[counter] = fn
		Zorlen_Timer.RunFunction[counter] = Function
		Zorlen_Timer.Show[counter] = show
		if Zorlen_DebugFlag then
			if StartTimer then
				if t ~= "" and not string.find(t, "InternalZorlen") then
					if p ~= "" then
						Zorlen_debug("Pre Timer Set in Slot#"..counter..":  '"..t.."'  '"..p.."'  '"..Name.."'  "..Seconds.." Second(s).", Zorlen_Timer.Show[counter])
					else
						Zorlen_debug("Pre Timer Set in Slot#"..counter..":  '"..t.."'  '"..Name.."'  "..Seconds.." Second(s).", Zorlen_Timer.Show[counter])
					end
				else
					if p ~= "" then
						Zorlen_debug("Pre Timer Set in Slot#"..counter..":  '"..p.."'  '"..Name.."'  "..Seconds.." Second(s).", Zorlen_Timer.Show[counter])
					else
						Zorlen_debug("Pre Timer Set in Slot#"..counter..":  '"..Name.."'  "..Seconds.." Second(s).", Zorlen_Timer.Show[counter])
					end
				end
			else
				if t ~= "" and not string.find(t, "InternalZorlen") then
					if p ~= "" then
						Zorlen_debug("Timer Set in Slot#"..counter..":  '"..t.."'  '"..p.."'  '"..Name.."'  "..Seconds.." Second(s).", Zorlen_Timer.Show[counter])
					else
						Zorlen_debug("Timer Set in Slot#"..counter..":  '"..t.."'  '"..Name.."'  "..Seconds.." Second(s).", Zorlen_Timer.Show[counter])
					end
				else
					if p ~= "" then
						Zorlen_debug("Timer Set in Slot#"..counter..":  '"..p.."'  '"..Name.."'  "..Seconds.." Second(s).", Zorlen_Timer.Show[counter])
					else
						Zorlen_debug("Timer Set in Slot#"..counter..":  '"..Name.."'  "..Seconds.." Second(s).", Zorlen_Timer.Show[counter])
					end
				end
			end
		end
		ZorlenFrame:Show()
	end
end

function Zorlen_IsTimer(Name, Pre, Tag)
	if Name and Name ~= "" then
		if Zorlen_Timer.Seconds[Name] then
			return true
		end
		local p = Pre or ""
		local t = Tag or ""
		local fn = p.."___Pre_DEVIDER_123__"..Name.."___Tag_DEVIDER_456__"..t.."___Timer_Timer_DEVIDER_789__"
		if Zorlen_Timer.Seconds[fn] or Zorlen_Timer.Seconds[fn.."TT"] then
			return true
		end
	end
	return false
end

function Zorlen_GetTimer(Name, Pre, Tag)
	if Name and Name ~= "" then
		if Zorlen_Timer.Seconds[Name] and Zorlen_Timer.Seconds[Name] > 0 then
			return Zorlen_Timer.Seconds[Name]
		end
		local p = Pre or ""
		local t = Tag or ""
		local fn = p.."___Pre_DEVIDER_123__"..Name.."___Tag_DEVIDER_456__"..t.."___Timer_Timer_DEVIDER_789__"
		if Zorlen_Timer.Seconds[fn.."TT"] then
			return (Zorlen_Timer.TimerTimer[fn.."TT"][1] + Zorlen_Timer.Seconds[fn.."TT"])
		elseif Zorlen_Timer.Seconds[fn] and Zorlen_Timer.Seconds[fn] > 0 then
			return Zorlen_Timer.Seconds[fn]
		end
	end
	return 0
end

function Zorlen_ClearTimer(Name, Pre, Tag, StartTimer)
	if Name and Name ~= "" then
		local p = Pre or ""
		local t = Tag or ""
		local n = Name
		local tt = ""
		if StartTimer then
			tt = "TT"
		end
		local fn = p.."___Pre_DEVIDER_123__"..n.."___Tag_DEVIDER_456__"..t.."___Timer_Timer_DEVIDER_789__"..tt
		local s = Zorlen_Timer.Slot[fn]
		if Zorlen_Timer.Seconds[n] then
			s = Zorlen_Timer.Slot[n]
			p = Zorlen_Timer.Pre[s]
			t = Zorlen_Timer.Tag[s]
			n = Zorlen_Timer.Name[s]
			fn = Zorlen_Timer.FullName[s]
		end
		if Zorlen_Timer.Seconds[fn] then
			Zorlen_Timer.Seconds[fn] = nil
			if Zorlen_DebugFlag then
				if Zorlen_Timer.TimerTimer[fn] then
					if t ~= "" and not string.find(t, "InternalZorlen") then
						if p ~= "" then
							Zorlen_debug("Pre Timer Cleared:  '"..t.."'  '"..p.."'  '"..n.."'", Zorlen_Timer.Show[s])
						else
							Zorlen_debug("Pre Timer Cleared:  '"..t.."'  '"..n.."'", Zorlen_Timer.Show[s])
						end
					else
						if p ~= "" then
							Zorlen_debug("Pre Timer Cleared:  '"..p.."'  '"..n.."'", Zorlen_Timer.Show[s])
						else
							Zorlen_debug("Pre Timer Cleared:  '"..n.."'", Zorlen_Timer.Show[s])
						end
					end
				else
					if t ~= "" and not string.find(t, "InternalZorlen") then
						if p ~= "" then
							Zorlen_debug("Timer Cleared:  '"..t.."'  '"..p.."'  '"..n.."'", Zorlen_Timer.Show[s])
						else
							Zorlen_debug("Timer Cleared:  '"..t.."'  '"..n.."'", Zorlen_Timer.Show[s])
						end
					else
						if p ~= "" then
							Zorlen_debug("Timer Cleared:  '"..p.."'  '"..n.."'", Zorlen_Timer.Show[s])
						else
							Zorlen_debug("Timer Cleared:  '"..n.."'", Zorlen_Timer.Show[s])
						end
					end
				end
			end
			return true
		end
	end
	return false
end




function Zorlen_AfterPreSpellCancelTimers(Name, Pre, Tag)
	if Zorlen_isCurrentClassWarlock then
		Zorlen_Warlock_AfterPreSpellCancelTimers(Name, Pre, Tag)
	elseif Zorlen_isCurrentClassHunter then
		Zorlen_Hunter_AfterPreSpellCancelTimers(Name, Pre, Tag)
	--[[
	elseif Zorlen_isCurrentClassDruid then
		Zorlen_Druid_AfterPreSpellCancelTimers(Name, Pre, Tag)
	elseif Zorlen_isCurrentClassWarrior then
		Zorlen_Warrior_AfterPreSpellCancelTimers(Name, Pre, Tag)
	elseif Zorlen_isCurrentClassPriest then
		Zorlen_Priest_AfterPreSpellCancelTimers(Name, Pre, Tag)
	elseif Zorlen_isCurrentClassRogue then
		Zorlen_Rogue_AfterPreSpellCancelTimers(Name, Pre, Tag)
	elseif Zorlen_isCurrentClassPaladin then
		Zorlen_Paladin_AfterPreSpellCancelTimers(Name, Pre, Tag)
	elseif Zorlen_isCurrentClassMage then
		Zorlen_Mage_AfterPreSpellCancelTimers(Name, Pre, Tag)
	elseif Zorlen_isCurrentClassShaman then
		Zorlen_Shaman_AfterPreSpellCancelTimers(Name, Pre, Tag)
	]]
	end
end

function Zorlen_SpellTimerSet()
	if Zorlen_isCurrentClassWarlock then
		Zorlen_Warlock_SpellTimerSet()
	elseif Zorlen_isCurrentClassHunter then
		Zorlen_Hunter_SpellTimerSet()
	elseif Zorlen_isCurrentClassDruid then
		Zorlen_Druid_SpellTimerSet()
	elseif Zorlen_isCurrentClassWarrior then
		Zorlen_Warrior_SpellTimerSet()
	elseif Zorlen_isCurrentClassPriest then
		Zorlen_Priest_SpellTimerSet()
	--[[
	elseif Zorlen_isCurrentClassRogue then
		Zorlen_Rogue_SpellTimerSet()
	elseif Zorlen_isCurrentClassPaladin then
		Zorlen_Paladin_SpellTimerSet()
	elseif Zorlen_isCurrentClassMage then
		Zorlen_Mage_SpellTimerSet()
	elseif Zorlen_isCurrentClassShaman then
		Zorlen_Shaman_SpellTimerSet()
	]]
	end
end


Zorlen_Old_CastSpellByName = CastSpellByName
function Zorlen_Hook_CastSpellByName(Spell, onSelf)
	if Spell then
		local s = Spell
		local _, i, r
		_, _, s = string.find(s, "^(.*);?%s*$")
		while ( string.sub( s, -2 ) == "()" ) do
			s = string.sub( s, 1, -3 )
		end
		_, _, s = string.find(s, "^%s*(.*)$")
		_, _, i, r = string.find(s, "(.*)%(.*(%d)%)$")
		if (i and r) then
			s = i
			r = tonumber(r)
		else
			r = Zorlen_GetSpellRank(s)
		end
		if
			s
			 and
			s ~= LOCALIZATION_ZORLEN.Attack
			 and
			s ~= LOCALIZATION_ZORLEN.AutoShot
			 and
			s ~= LOCALIZATION_ZORLEN.Shoot
			 and
			s ~= LOCALIZATION_ZORLEN.Throw
			 and
			s ~= LOCALIZATION_ZORLEN.ShootBow
			 and
			s ~= LOCALIZATION_ZORLEN.ShootGun
			 and
			s ~= LOCALIZATION_ZORLEN.ShootCrossbow
		then
			Zorlen_Temp_CastingSpellName = s
			Zorlen_Temp_CastingSpellRank = r
			if onSelf then
				Zorlen_Temp_CastingSpellTargetName = UnitName("player")
				Zorlen_Temp_CastingSpellTargetIsMob = nil
				Zorlen_Temp_CastingSpellTargetIsBanished = nil
			else
				Zorlen_Temp_CastingSpellTargetName = UnitName("target")
				Zorlen_Temp_CastingSpellTargetIsMob = (not UnitPlayerControlled("target"))
				Zorlen_Temp_CastingSpellTargetIsBanished = (not (not UnitAffectingCombat("target") or UnitExists("targettarget")))
			end
		end
	end
	Zorlen_Old_CastSpellByName(Spell, onSelf)
end
CastSpellByName = Zorlen_Hook_CastSpellByName
cast = Zorlen_Hook_CastSpellByName
zcast = Zorlen_Hook_CastSpellByName
csbn = Zorlen_Hook_CastSpellByName
zcsbn = Zorlen_Hook_CastSpellByName


Zorlen_Old_CastSpell = CastSpell
function Zorlen_Hook_CastSpell(SpellID, Book)
	local s, r = GetSpellName(SpellID, Book)
	if
		s
		 and
		s ~= LOCALIZATION_ZORLEN.Attack
		 and
		s ~= LOCALIZATION_ZORLEN.AutoShot
		 and
		s ~= LOCALIZATION_ZORLEN.Shoot
		 and
		s ~= LOCALIZATION_ZORLEN.Throw
		 and
		s ~= LOCALIZATION_ZORLEN.ShootBow
		 and
		s ~= LOCALIZATION_ZORLEN.ShootGun
		 and
		s ~= LOCALIZATION_ZORLEN.ShootCrossbow
	then
		Zorlen_Temp_CastingSpellName = s
		if r and r ~= "" then
			local f, _, r = string.find(r, "(%d+)")
			if f then
				Zorlen_Temp_CastingSpellRank = tonumber(r)
			else
				Zorlen_Temp_CastingSpellRank = 1
			end
		else
			Zorlen_Temp_CastingSpellRank = 1
		end
		Zorlen_Temp_CastingSpellTargetName = UnitName("target")
		Zorlen_Temp_CastingSpellTargetIsMob = (not UnitPlayerControlled("target"))
		Zorlen_Temp_CastingSpellTargetIsBanished = (not (not UnitAffectingCombat("target") or UnitExists("targettarget")))
	end
	Zorlen_Old_CastSpell(SpellID, Book)
end
CastSpell = Zorlen_Hook_CastSpell

Zorlen_Old_UseAction = UseAction
function Zorlen_Hook_UseAction(slot, checkCursor, onSelf)
	local SpellName, SpellRank, RankName, text = Zorlen_GiveActionButtonToolTipFirstLineInfo(slot)
	if
		SpellName
		 and
		SpellName ~= LOCALIZATION_ZORLEN.Attack
		 and
		SpellName ~= LOCALIZATION_ZORLEN.AutoShot
		 and
		SpellName ~= LOCALIZATION_ZORLEN.Shoot
		 and
		SpellName ~= LOCALIZATION_ZORLEN.Throw
		 and
		SpellName ~= LOCALIZATION_ZORLEN.ShootBow
		 and
		SpellName ~= LOCALIZATION_ZORLEN.ShootGun
		 and
		SpellName ~= LOCALIZATION_ZORLEN.ShootCrossbow
	then
		Zorlen_Temp_CastingSpellName = SpellName
		Zorlen_Temp_CastingSpellRank = SpellRank
		if onSelf == 1 then
			Zorlen_Temp_CastingSpellTargetName = UnitName("player")
			Zorlen_Temp_CastingSpellTargetIsMob = nil
			Zorlen_Temp_CastingSpellTargetIsBanished = nil
		else
			Zorlen_Temp_CastingSpellTargetName = UnitName("target")
			Zorlen_Temp_CastingSpellTargetIsMob = (not UnitPlayerControlled("target"))
			Zorlen_Temp_CastingSpellTargetIsBanished = (not (not UnitAffectingCombat("target") or UnitExists("targettarget")))
		end
	end
	Zorlen_Old_UseAction(slot, checkCursor, onSelf)
end
UseAction = Zorlen_Hook_UseAction


Zorlen_Button = {}
Zorlen_Button_MaxRank = {}
function Zorlen_RegisterButtons(show)
	Zorlen_debug("Zorlen Button Scan:", show)
	Zorlen_Button = {}
	for i = 1, 120 do
		local SpellName, SpellRank, RankName, text = Zorlen_GiveActionButtonToolTipFirstLineInfo(i)
		if text then
			if not Zorlen_Button["Macro."..text] then
				Zorlen_Button["Macro."..text] = i
				Zorlen_debug("Macro Button "..i..":  "..text, 2)
			end
		elseif SpellName and not Zorlen_Button[SpellName.."."..SpellRank] then
			if not Zorlen_Button_MaxRank[SpellName] then
				Zorlen_Button_MaxRank[SpellName] = Zorlen_GetSpellRank(SpellName)
			end
			if Zorlen_Button_MaxRank[SpellName] > 0 then
				Zorlen_Button[SpellName.."."..SpellRank] = i
				if not Zorlen_Button[SpellName] and SpellRank == Zorlen_Button_MaxRank[SpellName] then
					Zorlen_Button[SpellName] = i
				end
				if not Zorlen_Button[SpellName..".Any"] then
					Zorlen_Button[SpellName..".Any"] = i
				end
				Zorlen_debug("Action Button "..i..":  "..SpellName..""..RankName, show)
			end
		end
	end
end

function Zorlen_GiveActionButtonToolTipFirstLineInfo(slot)
	if slot and HasAction(slot) then
		local text = GetActionText(slot)
		if text then
			return nil, nil, nil, text
		end
		local lt = nil
		local SpellName = nil
		local rt = nil
		local RankName = nil
		local SpellRank = nil
		ZORLEN_RegisterButtons_Tooltip:SetAction(slot)
		local Lines = ZORLEN_RegisterButtons_Tooltip:NumLines()
		if Lines and Lines > 0 then
			lt = getglobal("ZORLEN_RegisterButtons_TooltipTextLeft1")
			if lt:IsShown() then
				SpellName = lt:GetText()
				if SpellName == "" then
					SpellName = nil
				end
			end
			
		end
		if SpellName then
			rt = getglobal("ZORLEN_RegisterButtons_TooltipTextRight1")
			if rt:IsShown() then
				RankName = rt:GetText()
				if RankName == "" then
					RankName = nil
				end
			end
			if RankName then
				local found, _, rank = string.find(RankName, "(%d+)")
				if found then
					SpellRank = tonumber(rank)
					RankName = "("..RankName..")"
				else
					RankName = ""
					SpellRank = 1
				end
			else
				RankName = ""
				SpellRank = 1
			end
			return SpellName, SpellRank, RankName, nil
		end
	end	
	return nil
end


function Zorlen_inBG()
	local t = GetRealZoneText()
	if t == LOCALIZATION_ZORLEN.WarsongGulch or t == LOCALIZATION_ZORLEN.AlteracValley or t == LOCALIZATION_ZORLEN.ArathiBasin then
		return true
	end
	return false
end

function Zorlen_isActionInRangeBySpellName(SpellName)
	if SpellName then
		local SpellButton = Zorlen_Button[SpellName..".Any"]
		if SpellButton and IsActionInRange(SpellButton) == 1 then
			return true
		end
	end
	return false
end
isActionInRangeBySpellName = Zorlen_isActionInRangeBySpellName


function Zorlen_isMoving()
	if Zorlen_Moving then
		return true
	end
	return false
end
Zorlen_isMoveing = Zorlen_isMoving
isMoveing = Zorlen_isMoving
isMoving = Zorlen_isMoving

function Zorlen_MovingUpdate()
	local x, y = GetPlayerMapPosition("player")
	if x == Zorlen_Moving_X and y == Zorlen_Moving_Y then
		Zorlen_Moving = nil
	else
		Zorlen_Moving_X = x
		Zorlen_Moving_Y = y
		Zorlen_Moving = 1
	end
end

-- Test function
function Zorlen_CountNearestActiveEnemys(cycles, TargetingYouOnly)
	if UnitExists("target") and UnitIsUnit("target", "playertarget") then
		cycles = cycles or 2
		local counter = 0
		local c = 0
		if Zorlen_isActiveEnemy() and CheckInteractDistance("target", 3) and (not TargetingYouOnly or UnitIsUnit("player", "targettarget")) then
			c = 1
		end
		for i = 1, cycles do
			TargetNearestEnemy()
			if not UnitIsUnit("target", "playertarget") then
				if Zorlen_isActiveEnemy() and CheckInteractDistance("target", 3) and (not TargetingYouOnly or UnitIsUnit("player", "targettarget")) then
					counter = counter + 1
				end
			else
				break
			end
			if i == cycles then
				if counter > 1 then
					counter = 1
				end
			end
		end
		TargetUnit("playertarget")
		return (counter + c)
	end
	return 0
end


