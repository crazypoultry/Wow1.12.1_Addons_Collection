--[[

	TODO:
	
	Buff Share
	
	OHW on Target = buff / heal / whatnot?
	
	Well Buff nohow
	
	Appropriate buff? If not in party / raid, inexpensive buff?
	
	IsResting() => Buff til you DROP!
	
	Thanks to thez for his Warlock code!

]]--

OHW_VERSION	= "1.9";

OneHitWonder_ChatEffectNamesGained = {};
OneHitWonder_ChatEffectNamesAfflicted = {};
OneHitWonder_ChatEffectNamesStartsToCast = {};


OneHitWonder_TrackMultipleHostiles = 0;
OneHitWonder_DisableCleaning = 0;
OneHitWonder_AutomatedGiveMeWonder = 0;
OneHitWonder_ReportSpells = 0;

ONEHITWONDER_SCAN_WEAPON_EVERY_SECONDS = 2;

ONEHITWONDER_INTERRUPT_SPELL_LEEWAY = 2;


OneHitWonder_PreferredTrackingSpell = nil;

OneHitWonder_TrackingSpellsList = {
	ONEHITWONDER_ABILITY_FIND_HERBS_NAME,
	ONEHITWONDER_ABILITY_FIND_MINERALS_NAME,
	ONEHITWONDER_ABILITY_FIND_TREASURE_NAME,
	ONEHITWONDER_ABILITY_SENSE_DEMONS_NAME,
	ONEHITWONDER_ABILITY_SENSE_UNDEAD_NAME,
	ONEHITWONDER_ABILITY_TRACK_BEASTS_NAME,
	ONEHITWONDER_ABILITY_TRACK_UNDEAD_NAME,
	ONEHITWONDER_ABILITY_TRACK_HIDDEN_NAME,
	ONEHITWONDER_ABILITY_TRACK_ELEMENTALS_NAME,
	ONEHITWONDER_ABILITY_TRACK_HUMANOID_NAME,
	ONEHITWONDER_ABILITY_TRACK_DEMONS_NAME,
	ONEHITWONDER_ABILITY_TRACK_GIANTS_NAME,
	ONEHITWONDER_ABILITY_TRACK_DRAGONKIN_NAME
};

OneHitWonder_CurrentAuras = {};

ONEHITWONDER_HEALTH_UPDATE_DELAY = 0.5;

OneHitWonder_OnlyShowCurrentClassSettings = 0;

OneHitWonder_UseWilloftheForsaken = 1;
OneHitWonder_UseStoneform = 1;
OneHitWonder_ShouldReactiveText = 1;

OneHitWonder_InitiateCombat = 1;
OneHitWonder_ShouldShowQueue = 1;
OneHitWonder_ShouldShowQueueFull = true;
OneHitWonder_DisableRangeFinding = 0;

OneHitWonder_ShouldTryToInterruptSpell = true;
OneHitWonder_ShouldTryToDispellSpell = true;
OneHitWonder_UseBlockCounter = true;
OneHitWonder_UseDodgeCounter = true;
OneHitWonder_UseParryCounter = true;
OneHitWonder_ShouldTryToAntiDodge = true;
OneHitWonder_ShouldMeleeAttack = 1;


OneHitWonder_OnlyShowImperativeMessage = 0;
OneHitWonder_ShouldBerserk = 1;

OneHitWonder_ShouldOverrideBindings = 1;
OneHitWonder_ShowInfoMessages = 0;

OneHitWonder_ShouldKeepBuffsUp = 1;
OneHitWonder_ShouldKeepBuffsUpParty = 1;
OneHitWonder_NoBuffWhileFishing = 1;
OneHitWonder_ShouldAutoCure = 1;
OneHitWonder_AutoCureDelay = 5;

OneHitWonder_ShouldOnlyBuffInFightIfNotRegenerating = 0;


ONEHITWONDER_ACTIONID_SPELL = 1;
ONEHITWONDER_ACTIONID_SPELL_TIMEOUT = 2;
ONEHITWONDER_ACTIONID_SPELL_TARGET = 3;
ONEHITWONDER_ACTIONID_SPELL_ITEM = 4;
ONEHITWONDER_ACTIONID_ACTION_SELF = 5;

-- could be replaced with appropriate spells, of course
ONEHITWONDER_ACTIONID_BUFF = 3;
ONEHITWONDER_ACTIONID_DEBUFF = 4;

OneHitWonder_PetIsAttacking = false;
OneHitWonder_RegularSpellRunning = false;
OneHitWonder_ChannelSpellRunningStarted = 0;
OneHitWonder_ChannelSpellRunning = false;
OneHitWonder_RegularSpellRunningStarted = 0;
OneHitWonder_TimeSpellStopped = 0;

OneHitWonder_BuffsToKeepUp = {};

ONEHITWONDER_MAXIMUM_NUMBER_OF_ACTION_IDS = 120;

ONEHITWONDER_MAXIMUM_TIME_SINCE_LAST_BUFF = 5;

OneHitWonder_ActionQueue = {};

OneHitWonder_Enabled = 1;


OneHitWonder_EnergyReservation = 0;

OneHitWonder_RageReservation = 0;

OneHitWonder_UnitHealthLastCalled = {};

OneHitWonder_PlayerClass = nil;

OneHitWonder_PlayerRace = nil;

OneHitWonder_LastBuffed = 0;

OneHitWonder_WarlockDemonBuffNames = {
	ONEHITWONDER_SPELL_DEMON_SKIN_NAME,
	ONEHITWONDER_SPELL_DEMON_ARMOR_NAME
};

OneHitWonder_WarlockDetectInvisibilityBuffNames = {
	ONEHITWONDER_SPELL_DETECT_LESSER_INVISIBILITY_NAME,
	ONEHITWONDER_SPELL_DETECT_INVISIBILITY_NAME,
	ONEHITWONDER_SPELL_DETECT_GREATER_INVISIBILITY_NAME
};

OneHitWonder_Items = {};

--OneHitWonder_Saved_ChatFrame_OnEvent = nil;

OneHitWonder_WaitForFeedBack = false;
OneHitWonder_WaitForFeedBackTimeout = 0;
OneHitWonder_WaitForFeedBackDefaultTimeout = 2;
OneHitWonder_ChatFeedBack = "";

-- verify this
ONEHITWONDER_QUEUE_INTERRUPT_SPELL_CHAT_TYPES = {
	"SPELL_HOSTILEPLAYER_DAMAGE",
	"SPELL_HOSTILEPLAYER_BUFF",
	"SPELL_PERIODIC_CREATURE_DAMAGE",
	"SPELL_PERIODIC_CREATURE_BUFFS",
	"SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE",
	"SPELL_PERIODIC_HOSTILEPLAYER_BUFFS",
	"SPELL_CREATURE_VS_SELF_DAMAGE",
	"SPELL_CREATURE_VS_SELF_BUFF",
	"SPELL_CREATURE_VS_PARTY_DAMAGE",
	"SPELL_CREATURE_VS_PARTY_BUFF",
	"SPELL_CREATURE_VS_CREATURE_DAMAGE",
	"SPELL_CREATURE_VS_CREATURE_BUFF"
};

ONEHITWONDER_IMMUNE_SPELL_TYPES = {
	"SPELL_SELF_DAMAGE",
};


ONEHITWONDER_QUEUE_INTERRUPT_SPELL_DODGEPARRYBLOCK_TYPES = {
	"COMBAT_SELF_HITS",
	"COMBAT_SELF_MISSES",
	"COMBAT_HOSTILEPLAYER_HITS",
	"COMBAT_HOSTILEPLAYER_MISSES",
	"COMBAT_CREATURE_VS_SELF_HITS",
	"COMBAT_CREATURE_VS_SELF_MISSES"
};

ONEHITWONDER_PARTY_EVENTS = {
	"COMBAT_CREATURE_VS_PARTY_HITS",
	"COMBAT_CREATURE_VS_PARTY_MISSES"
};

ONEHITWONDER_ATTACKING_UNITS_EVENTS = {
	"CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS",
	"CHAT_MSG_COMBAT_HOSTILEPLAYER_MISSES",
	"CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS",
	"CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES",
	"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS",
	"CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES",
	"CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE",
	"CHAT_MSG_SPELL_HOSTILEPLAYER_BUFF",
	"CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE",
	"CHAT_MSG_SPELL_CREATURE_VS_SELF_BUFF",
	"CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE",
	"CHAT_MSG_SPELL_CREATURE_VS_PARTY_BUFF",
};

ONEHITWONDER_WARRIOR_STANCE_BATTLE = 1;
ONEHITWONDER_WARRIOR_STANCE_DEFENSIVE = 2;
ONEHITWONDER_WARRIOR_STANCE_AGGRESSIVE = 3;
ONEHITWONDER_WARRIOR_STANCE_BERSERK = 4;

-- taken from ItemBuff - thanks, Telo!
OneHitWonder_InventorySlotNames = {
	{ name = "HeadSlot" },
	{ name = "NeckSlot" },
	{ name = "ShoulderSlot" },
	{ name = "BackSlot" },
	{ name = "ChestSlot" },
	{ name = "ShirtSlot" },
	{ name = "TabardSlot" },
	{ name = "WristSlot" },
	{ name = "HandsSlot" },
	{ name = "WaistSlot" },
	{ name = "LegsSlot" },
	{ name = "FeetSlot" },
	{ name = "Finger0Slot" },
	{ name = "Finger1Slot" },
	{ name = "Trinket0Slot" },
	{ name = "Trinket1Slot" },
	{ name = "MainHandSlot" },
	{ name = "SecondaryHandSlot" },
	{ name = "RangedSlot" },
};

OneHitWonder_Options_Default = {
	"OneHitWonder_OnlyShowImperativeMessage",
	"OneHitWonder_AutomatedGiveMeWonder",
	"OneHitWonder_UseWilloftheForsaken",
	"OneHitWonder_UseStoneform",
	"OneHitWonder_InitiateCombat",
	"OneHitWonder_PreferredTrackingSpell",
	"OneHitWonder_DisableRangeFinding",
	"OneHitWonder_OnlyShowCurrentClassSettings",
	"OneHitWonder_ShouldShowQueueFull",
	"OneHitWonder_ShouldShowQueue",
	"OneHitWonder_Enabled",
	"OneHitWonder_ShouldKeepBuffsUp", 
	"OneHitWonder_ShouldKeepBuffsUpParty",
	"OneHitWonder_NoBuffWhileFishing",
	"OneHitWonder_ShouldReactiveText",
	"OneHitWonder_ShouldOverrideBindings",
	"OneHitWonder_ShouldAutoCure",
	"OneHitWonder_AutoCureDelay",
};

OneHitWonder_Options = {
--[[	
	["OneHitWonder_OnlyShowImperativeMessage"] = OneHitWonder_OnlyShowImperativeMessage,
	["OneHitWonder_AutomatedGiveMeWonder"] = OneHitWonder_AutomatedGiveMeWonder,
	["OneHitWonder_UseWilloftheForsaken"] = OneHitWonder_UseWilloftheForsaken,
	["OneHitWonder_UseStoneform"] = OneHitWonder_UseStoneform,
	["OneHitWonder_InitiateCombat"] = OneHitWonder_InitiateCombat,
	["OneHitWonder_PreferredTrackingSpell"] = OneHitWonder_PreferredTrackingSpell,
	["OneHitWonder_DisableRangeFinding"] = OneHitWonder_DisableRangeFinding,
	["OneHitWonder_OnlyShowCurrentClassSettings"] = OneHitWonder_OnlyShowCurrentClassSettings,
	["OneHitWonder_ShouldShowQueueFull"] = OneHitWonder_ShouldShowQueueFull,
	["OneHitWonder_ShouldShowQueue"] = OneHitWonder_ShouldShowQueue,
	["OneHitWonder_Enabled"] = OneHitWonder_Enabled,
	["OneHitWonder_ShouldKeepBuffsUp"] = OneHitWonder_ShouldKeepBuffsUp, 
	["OneHitWonder_ShouldKeepBuffsUpParty"] = OneHitWonder_ShouldKeepBuffsUpParty,
	["OneHitWonder_NoBuffWhileFishing"] = OneHitWonder_NoBuffWhileFishing,
	["OneHitWonder_ShouldReactiveText"] = OneHitWonder_ShouldReactiveText,
	["OneHitWonder_ShouldOverrideBindings"] = OneHitWonder_ShouldOverrideBindings,
	["OneHitWonder_ShouldAutoCure"] = OneHitWonder_ShouldAutoCure,
	["OneHitWonder_AutoCureDelay"] = OneHitWonder_AutoCureDelay,
]]--
};

function OneHitWonder_ShowZoneMessage(msg, color, sound)
	local msgColor = color;
	if ( not msgColor ) then
		msgColor = { 1.0, 0.2, 0.2 };
	else
		if ( color.red ) then
			msgColor = { color.red, color. green, color.blue };
		end
	end
    ZoneTextString:SetText(msg);
    ZoneTextString:SetTextColor(msgColor[1], msgColor[2], msgColor[3]);
    ZoneTextFrame.startTime = GetTime();
    PVPInfoTextString:SetText("");
    SubZoneTextString:SetText("");
    PVPArenaTextString:SetText("");
    ZoneTextFrame:Show();
    if ( sound ) then
    	PlaySound(sound);
    end
end

function OneHitWonder_ShowBigMessage(msg, noSound)
	local sound = "MapPing";
	if ( noSound ) then
		sound = nil;
	end
    local color = { 1.0, 0.2, 0.2 };
	OneHitWonder_ShowZoneMessage(msg, color, sound);
end

function OneHitWonder_ShowInfoMessage(msg)
	if ( OneHitWonder_ShowInfoMessages == 1 ) then
	    local color = { 0.2, 0.2, 1.0 };
		OneHitWonder_ShowZoneMessage(msg, color);
	end
end

function OneHitWonder_IsTargetedUnit(name)
	if ( UnitName("target") == name ) then
		return true;
	else
		return false;
	end
end

function OneHitWonder_ExtractUnitNameFromCombatMessage(msg, source, stringAfterName)
	local unitName = "";
	if ( ( source ) and ( strlen(source) > 0 ) ) then 
		unitName = source;
	end
	local index = strfind(msg, stringAfterName);
	local spellName = "";
	if ( index ~= nil ) then
		local tmpStr = strsub(msg, 1, index-2);
		local cutAwayStr = "%. "; -- sigh. damn patterns
		local index2 = strfind(tmpStr, cutAwayStr);
		if ( index2 ) then
			tmpStr = strsub(tmpStr, index2+2);
		end
		if ( strlen(unitName) <= 0 ) then
			unitName = tmpStr;
		end
		local spellCutPoint = index+strlen(stringAfterName);
		if ( spellCutPoint < strlen(msg) ) then
			tmpStr = strsub(msg, spellCutPoint);
			spellName = tmpStr;
			while ( strsub(spellName, 1, 1) == " " ) do
				spellName = strsub(spellName, 2);
			end
			if ( strsub(spellName, strlen(spellName)) == "." ) then
				spellName = strsub(spellName, 1, strlen(spellName)-1);
			end
		end
	end
	return unitName, spellName;
end

function OneHitWonder_IsSpellBased(spellName, exactMatch, keywordMatch, excludeExactMatch)
	if ( not spellName ) then
		return false;
	end
	local lowName = strlower(spellName);
	local index = strfind(lowName, "%(rank");
	if ( index ) then
		lowName = strsub(lowName, 1, index-1);
	end
	if ( excludeExactMatch ) then
		for k, v in excludeExactMatch do
			if ( v == lowName ) then
				return false;
			end
		end
	end
	for k, v in exactMatch do
		if ( v == lowName ) then
			return true;
		end
	end
	for k, v in keywordMatch do
		if ( strfind(lowName, v ) ) then
			return true;
		end
	end
	return false;
end

function OneHitWonder_IsSpellShadowBased(spellName)
	return OneHitWonder_IsSpellBased(spellName, OneHitWonder_ShadowSpells, OneHitWonder_ShadowSpellKeyWords, OneHitWonder_NotShadowSpells);
end

function OneHitWonder_IsSpellFireBased(spellName)
	return OneHitWonder_IsSpellBased(spellName, OneHitWonder_FireSpells, OneHitWonder_FireSpellKeyWords, OneHitWonder_NotFireSpells);
end

function OneHitWonder_IsSpellFrostBased(spellName)
	return OneHitWonder_IsSpellBased(spellName, OneHitWonder_FrostSpells, OneHitWonder_FrostSpellKeyWords, OneHitWonder_NotFrostSpells);
end

OneHitWonder_NonInterruptSpellEffects = nil;

function OneHitWonder_GetNonInterruptSpellEffects()
	if ( not OneHitWonder_NonInterruptSpellEffects ) then
		OneHitWonder_NonInterruptSpellEffects = {};
	end
	local l = { ONEHITWONDER_STUN_EFFECTS, ONEHITWONDER_SLEEP_EFFECTS, ONEHITWONDER_SILENCE_EFFECTS };
	for k, v in l do
		for key, value in v do
			table.insert(OneHitWonder_NonInterruptSpellEffects, value);
		end
	end
	return OneHitWonder_NonInterruptSpellEffects;
end

function OneHitWonder_TryToInterruptSpell(unitName, spellName)
	OneHitWonder_AddEffectNameStartsToCast(spellName);
	if ( OneHitWonder_InitiateCombat == 0 ) and ( not OneHitWonder_IsInCombat() ) then
		return false;
	end
	if ( spellName ) and ( OneHitWonder_IsStringInListLoose(spellName, OneHitWonder_SpellsThatShouldNotBeInterrupted, false) ) then
		return false;
	end
	if ( OneHitWonder_HasUnitEffect("target", nil, OneHitWonder_GetNonInterruptSpellEffects()) ) then
		return -1, "";
	end
	return OneHitWonder_DoGenericActionAdding("TryToInterruptSpell", unitName, spellName);
end

OneHitWonder_UnitNameIsAfflictedBy_List = { "pet", "party1", "party2", "party3", "party4", };

function OneHitWonder_UnitNameIsAfflictedBy(unitName, spellName)
	OneHitWonder_AddEffectNameAfflicted(spellName);
	local funcName = format("OneHitWonder_UnitNameIsAfflictedBy_%s", class);
	local func = getglobal(funcName);
	if ( func ) then
		func(unitName, spellName);
	end
	for k, v in OneHitWonder_UnitNameIsAfflictedBy_List do
		if ( UnitExists(v) ) and ( UnitName(v) == unitName ) then
			OneHitWonder_UnitIsAfflictedBy(v, spellName);
		end
	end
end

function OneHitWonder_UnitIsAfflictedBy(unit, spellName)
	local funcName = format("OneHitWonder_UnitIsAfflictedBy_%s", class);
	local func = getglobal(funcName);
	if ( func ) then
		func(unitName, spellName);
	end
end

function OneHitWonder_AddEffectNameTable(tableVar, spellName)
	if ( spellName ) and ( type(spellName) == "string" ) and ( strlen(spellName) ) then
		for k, v in tableVar do
			if ( v == spellName ) then
				return false;
			end
		end
		table.insert(tableVar, spellName);
		return true;
	end
	return false;
end

function OneHitWonder_AddEffectNameGained(spellName)
	return OneHitWonder_AddEffectNameTable(OneHitWonder_ChatEffectNamesGained, spellName);
end

function OneHitWonder_AddEffectNameAfflicted(spellName)
	return OneHitWonder_AddEffectNameTable(OneHitWonder_ChatEffectNamesAfflicted, spellName);
end

function OneHitWonder_AddEffectNameStartsToCast(spellName)
	return OneHitWonder_AddEffectNameTable(OneHitWonder_ChatEffectNamesStartsToCast, spellName);
end


function OneHitWonder_UnitHasGainedSpell(unitName, spellName)
	OneHitWonder_AddEffectNameGained(spellName);
	if ( OneHitWonder_InitiateCombat == 0 ) and ( not OneHitWonder_IsInCombat() ) then
		return false;
	end
	local class = OneHitWonder_GetPlayerClass();
	if ( not class ) then
		return;
	end
	local funcName = format("OneHitWonder_UnitHasGainedSpell_%s", class);
	local func = getglobal(funcName);
	if ( func ) then
		func(unitName, spellName);
	end
end

function OneHitWonder_DoGenericActionAdding(addFuncName, p1, p2, p3, p4, p5, p6, p7, p8, p9)
	local counterId = -1;
	local abilityName = "";
	local timeout = 3;
	local target = nil;
	local class = OneHitWonder_GetPlayerClass();
	if ( not class ) then
		return;
	end
	local funcName = format("OneHitWonder_%s_%s", addFuncName, class);
	local func = getglobal(funcName);
	if ( func ) then
		local r1, r2, r3, r4, r5;
		r1, r2, r3, r4, r5 = func(p1, p2, p3, p4, p5, p6, p7, p8, p9);
		--[[
		--counterId, abilityName, timeout = func(arg1, arg2, arg3, arg4);
		local r1, r2, r3, r4, r5 = func(arg1, arg2, arg3, arg4);
		]]--
		counterId = r1;
		abilityName = r2;
		if ( r3 ) then
			if ( type(r3) == "number" ) then
				timeout = r3;
				target = r4;
			elseif ( type(r3) == "string" ) then
				target = r3;
				timeout = r4;
			end
		end
	end
	if ( counterId > -1 ) then
		OneHitWonder_ShowImperativeMessage(abilityName);
		if ( OneHitWonder_OnlyShowImperativeMessage == 1 ) then
			return;
		end
		if ( ( not timeout ) or ( timeout <= 0 ) ) then
			timeout = 3;
		end
		--[[
		local parameters = { counterId, GetTime() + timeout};
		OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TIMEOUT, parameters);
		]]--
		local parameters = { counterId, "target", GetTime() + timeout};
		OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TARGET, parameters);
	end
end

function OneHitWonder_DoBlockCounter()
	return OneHitWonder_DoGenericActionAdding("GetBlockCounter");
end

function OneHitWonder_DoDodgeCounter()
	return OneHitWonder_DoGenericActionAdding("GetDodgeCounter");
end

function OneHitWonder_DoParryCounter()
	return OneHitWonder_DoGenericActionAdding("GetParryCounter");
end

function OneHitWonder_ShowImperativeMessage(name)
	if ( OneHitWonder_ShouldReactiveText ~= 1 ) then
		return;
	end
	if ( ( name ) and ( strlen(name) > 0 ) ) then
		OneHitWonder_ShowBigMessage(format(ONEHITWONDER_IMPERATIVE_ABILITY_MESSAGE, name));
	end
end

function OneHitWonder_DoTargetDodgeCounter()
	return OneHitWonder_DoGenericActionAdding("GetTargetDodgeCounter");
end

OneHitWonder_StringCompressionTable = {
};

function OneHitWonder_CreateCompressionTable()
	local index = 1;
	for i = 45, 57 do
		OneHitWonder_StringCompressionTable[i] = index;
		index = index + 1;
	end
	for i = 64, 90 do
		OneHitWonder_StringCompressionTable[i] = index;
		index = index + 1;
	end
end

function OneHitWonder_CompressString(str)
	if ( not str ) then
		return nil;
	end
end

OneHitWonder_GetHashForString_List = {};

function OneHitWonder_GetHashForString(str)
	if ( type(str) ~= "string" ) then
		return str;
	end
	local sum = 0;
	local size = strlen(str);
	local value = nil;
	local values = OneHitWonder_GetHashForString_List;
	for i = 1, size do
		value = string.byte(str, i);
		values[i] = value;
		sum = sum + value;
	end
	value = 0;
	--[[
	for i = 1, size do
		value = value + values[i];
		if ( math.mod(i, 2) == 0 ) then
			sum = math.xor(sum, value);
			value = 0;
		else
			value = value * 256;
		end
	end
	if ( value > 0 ) then
		sum = math.xor(sum, value);
		value = 0;
	end
	]]--
	return size..""..sum;
end

function OneHitWonder_GetHashForStringQWEqe()
	local size = strlen(str);
	local hash = ""..size;
	local index = 1;
	local sum = 0;
	local value = 0;
	for index = 1, size do
		value = string.byte(str, index);
		sum = sum + value;
		if ( math.mod(index, 2) == 0 ) then
			if ( sum > 255 ) then
				sum = math.mod(sum, 255);
			end
			hash = hash..string.char(sum);
			sum = 0;
		end
	end
	if ( sum > 255 ) then
		sum = math.mod(sum, 255);
	end
	hash = hash..string.char(sum);
	return hash;
end

OneHitWonder_AbilityNames = {};

function OneHitWonder_GetAbilityStringFromIndex(index)
	if ( not OneHitWonder_AbilityNames ) then
		return nil;
	end
	for k, v in OneHitWonder_AbilityNames do 
		if ( v == index ) then
			return k;
		end
	end
	return nil;
end

function OneHitWonder_GetAbilityStringIndex(ability)
	if ( not ability ) then
		if ( not OneHitWonder_GetAbilityStringIndex_Debug ) then
			OneHitWonder_Print("OHW: OneHitWonder_GetAbilityStringIndex() got a nil value. Contact sarf.");
			OneHitWonder_GetAbilityStringIndex_Debug = 1;
		end
		return nil;
	end
	if ( not OneHitWonder_AbilityNames ) then
		OneHitWonder_AbilityNames = {};
	end
	local value = OneHitWonder_AbilityNames[ability];
	if ( value ) then
		return value;
	end
	local highestIndex = 0;
	for k, v in OneHitWonder_AbilityNames do 
		if ( v > highestIndex ) then
			highestIndex = v;
		end
	end
	value = highestIndex+1;
	OneHitWonder_AbilityNames[ability] = value;
	-- RegisterForSave("OneHitWonder_AbilityNames");
	return value;
end


function OneHitWonder_IsUnitImmuneToAbility(unit, ability)
	--_print("OneHitWonder_IsUnitImmuneToAbility")
	if UnitClass(unit) == ONEHITWONDER_CLASS_PALADIN or OneHitWonder_IsUnitNameInList(unit,OneHitWonder_NonImmuneMobs) then
		return false
	end
	local name = UnitName(unit);
	local index1 = OneHitWonder_GetHashForUnit(unit);
	local index2 = OneHitWonder_GetAbilityStringIndex(ability);
	if ( index2 ) and ( OneHitWonder_CreatureInfoTable ) and ( OneHitWonder_CreatureInfoTable[index1] ) and ( OneHitWonder_CreatureInfoTable[index1][index2] == 1 ) then
		return true;
	else
		return false;
	end
end

function OneHitWonder_IsCreatureImmuneToAbility(creature, ability)
	local index1 = OneHitWonder_GetHashForString(creature);
	local index2 = OneHitWonder_GetAbilityStringIndex(ability);
	if ( index2 ) and ( OneHitWonder_CreatureInfoTable ) and ( OneHitWonder_CreatureInfoTable[index1] ) and ( OneHitWonder_CreatureInfoTable[index1][index2] == 1 ) then
		return true;
	else
		return false;
	end
end

function OneHitWonder_HandleImmuneAbility(unit, ability)
	if ( not unit ) or ( not ability ) then
		return;
	end
	if ( not OneHitWonder_CreatureInfoTable ) then
		OneHitWonder_CreatureInfoTable = {};
	end
	local index1 = OneHitWonder_GetHashForUnit(unit);
	if ( index1 ) then
		if ( not OneHitWonder_CreatureInfoTable[index1] ) then
			OneHitWonder_CreatureInfoTable[index1] = {};
		end
		local index2 = OneHitWonder_GetAbilityStringIndex(ability);
		if ( index2 ) then
			OneHitWonder_CreatureInfoTable[index1][index2] = 1;
			-- RegisterForSave("OneHitWonder_CreatureInfoTable");
		end
	end
end

function OneHitWonder_HandleImmune(event, message)
	-- Kinesia. Added handling for banished units.
	for ability, target in string.gfind(message, ONEHITWONDER_IMMUNE_CHAT_MESSAGE) do
		if ( UnitName("target") == target ) and  not UnitIsPlayer("target") and  (not UnitClass("target") == ONEHITWONDER_CLASS_PALADIN) and
			not OneHitWonder_IsUnitNameInList("target",OneHitWonder_NonImmuneMobs) then
			if (not OneHitWonder_HasUnitEffect("target",nil,ONEHITWONDER_SPELL_BANISHED_EFFECT)) then
				OneHitWonder_HandleImmuneAbility("target", ability);
			end
		end
	end
end

function OneHitWonder_CheckForBerserk(msg)
	if ( OneHitWonder_ShouldBerserk == 1 ) then
		local shouldBerserk = false;
		local globalStrings3 = {
			COMBATHITCRITOTHERSELF,
			SPELLLOGCRITOTHERSELF,
		};
		local globalStrings2 = {
			SPELLLOGCRITSELFSELF,
		}
		for k, v in globalStrings3 do
			for creature, damage, somethingElse in string.gfind(msg, v) do
				shouldBerserk = true;
				break;
			end
			if ( shouldBerserk ) then
				break;
			end
		end
		if ( not shouldBerserk ) then
			for k, v in globalStrings2 do
				for creature, damage, somethingElse in string.gfind(msg, v) do
					shouldBerserk = true;
					break;
				end
				if ( shouldBerserk ) then
					break;
				end
			end
		end
		if ( shouldBerserk ) then
			OneHitWonder_ShowImperativeMessage(ONEHITWONDER_ABILITY_BERSERK_NAME);
			local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_BERSERK_NAME);
			if ( spellId > -1 ) and ( OneHitWonder_IsSpellAvailable(spellId) ) then
				OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL_TIMEOUT, { spellId, ( GetTime() + 2) }  );
			end
		end
	end
end

OneHitWonder_AttackingEntitiesDuration = 10;

OneHitWonder_AttackingEntities = {};

function OneHitWonder_CleanAttackingEntities()
	local ok = true;
	local curTime = GetTime();
	while ( ok ) do
		ok = false;
		for k, v in OneHitWonder_AttackingEntities do
			if ( curTime - v.time > OneHitWonder_AttackingEntitiesDuration ) then
				OneHitWonder_AttackingEntities[k] = nil;
				ok = true;
				break;
			end
		end
	end
end

function OneHitWonder_GetNumberOfAttackingEntities()
	local i = 0;
	for k, v in OneHitWonder_AttackingEntities do
		i = i + 1;
	end
	return i;
end

function OneHitWonder_GetAttackingEntities()
	OneHitWonder_CleanAttackingEntities();
	local list = {};
	for k, v in OneHitWonder_AttackingEntities do
		table.insert(list, k);
	end
	return list;
end

function OneHitWonder_AttackingEntity(entityName)
	if ( not entityName ) then
		return;
	end
	if ( not OneHitWonder_AttackingEntities[entityName] ) then
		OneHitWonder_AttackingEntities[entityName] = {};
	end
	OneHitWonder_AttackingEntities[entityName].time = GetTime();
	OneHitWonder_CleanAttackingEntities();
end

OneHitWonder_AllyList = {
	"player", "pet", 
	"party1", "party2", "party3", "party4", 
	"raid1", "raid2", "raid3", "raid4", "raid5", "raid6", "raid7", "raid8", "raid9",  
	"raid10", "raid11", "raid12", "raid13", "raid14", "raid15", "raid16", "raid17", "raid18", "raid19", 
	"raid20", "raid21", "raid22", "raid23", "raid24", "raid25", "raid26", "raid27", "raid28", "raid29", 
	"raid30", "raid31", "raid32", "raid33", "raid34", "raid35", "raid36", "raid37", "raid38", "raid39", 
	"raid40", 
};

function OneHitWonder_IsAlly(name)
	for k, v in OneHitWonder_AllyList do
		if ( UnitExists(v) ) and ( UnitName(v) == name ) then
			return true;
		end
	end
	return false;
end

function OneHitWonder_RegisterAttackingUnitsOld(event, msg)	
	local name, target = nil, nil;
	local index, index2 = nil, nil;
	local meleeList = { " hits ", " crits " };
	for k, v in meleeList do
		index = string.find(msg, v);
		if ( index ) then
			index2 = string.find(msg, " for");
			local name = strsub(msg, 1, index-1);
			local target = strsub(msg, index+strlen(v), index2-1);
			if ( not OneHitWonder_IsAlly(name) ) and ( ( target == "you" ) or ( OneHitWonder_IsAlly(target) ) ) then
				OneHitWonder_AttackingEntity(name);
				return;
			end
		end
	end
	index = string.find(msg, " casts");
	local index2 = string.find(msg, " on ");
	if ( index ) and ( index2 ) then
		name = strsub(msg, 1, index-1);
		target = strsub(msg, index2+4, strlen(msg)-1);
		if ( not OneHitWonder_IsAlly(name) ) and ( ( target == "you") or ( OneHitWonder_IsAlly(target) ) ) then
			OneHitWonder_AttackingEntity(name);
			return
		end
	end
end

OneHitWonder_GlobalStringTranslations = {
	["%%s"] = "%(%.+%)",
	["%%d"] = "%(%%d%)",
};
function OneHitWonder_GlobalStringTogfind(str)
	local retStr = str;
	for k, v in OneHitWonder_GlobalStringTranslations do
		retStr = string.gsub(str, k, v);
	end
	return retStr;
end

OneHitWonder_GetYouIdentifiers = {
	["enEN"] = "you",
};

function OneHitWonder_GetYouIdentifier()
	local youIdent = OneHitWonder_GetYouIdentifiers[GetLocale()];
	if ( not youIdent ) then youIdent = "you"; end
	return youIdent;
end

function OneHitWonder_RegisterAttackingUnits(event, msg)	
	local youIdentifier = OneHitWonder_GetYouIdentifier()
	local meleeselflist = {  -- no need for these
		OneHitWonder_GlobalStringTogfind(TEXT(COMBATHITCRITOTHERSELF)), 
		OneHitWonder_GlobalStringTogfind(TEXT(COMBATHITOTHERSELF)),
	}; 
	local meleeotherlist = { 
		OneHitWonder_GlobalStringTogfind(TEXT(COMBATHITCRITOTHEROTHER)), 
		OneHitWonder_GlobalStringTogfind(TEXT(COMBATHITOTHEROTHER)),
	};
	for k, v in meleeotherlist do
		for attacker, target, damage in string.gfind(msg, v) do
			if ( (target == youIdentifier) or ( OneHitWonder_IsAlly(target) ) ) and ( not OneHitWonder_IsAlly(attacker) ) then
				OneHitWonder_AttackingEntity(attacker);
				return;
			end
		end
	end
	local advancedselflist = {-- no need for these
		OneHitWonder_GlobalStringTogfind(TEXT(SIMPLECASTOTHERSELF)),
		OneHitWonder_GlobalStringTogfind(TEXT(SIMPLEPERFORMOTHERSELF)),
	};
	local advancedotherlist = { 
		OneHitWonder_GlobalStringTogfind(TEXT(SPELLCASTGOOTHERTARGETTED)), 
		OneHitWonder_GlobalStringTogfind(TEXT(SIMPLEPERFORMOTHEROTHER)),
	};
	for k, v in advancedotherlist do
		for attacker, spell, target in string.gfind(msg, v) do
			if ( ( target == youIdentifier ) or ( OneHitWonder_IsAlly(target) ) ) and ( not OneHitWonder_IsAlly(attacker) ) then
				OneHitWonder_AttackingEntity(attacker);
				return;
			end
		end
	end
end

function OneHitWonder_Chat_OnEvent(event, msg, sender)
	if ( OneHitWonder_IsEnabled() ) then
		if ( strsub(event, 1, 8) == "CHAT_MSG" ) then
			if ( OneHitWonder_TrackMultipleHostiles == 1 ) then
				for k, v in ONEHITWONDER_ATTACKING_UNITS_EVENTS do
					if ( v == event ) then
						OneHitWonder_RegisterAttackingUnits(event, msg);
						break;
					end
				end
			end
			OneHitWonder_CheckForBerserk(msg);
			OneHitWonder_HandleImmune(event, msg);
			local typeOfEvent = strsub(event, 10);
			local info = ChatTypeInfo[type];
			local unitName = nil;
			local spellName = nil;
			local shouldInterrupt = false;
			local spellShouldNotBeInterrupted = false;
			for unitName, spellName in string.gfind(msg, AURAADDEDOTHERHARMFUL) do
				OneHitWonder_UnitNameIsAfflictedBy(unitName, spellName);
			end
			if ( 
				( OneHitWonder_HasTarget() ) and 
				( UnitCanAttack("target", "player") ) ) then
				for k, spellStartStr in OneHitWonder_Chat_SpellCastingStartingStrings do
					spellShouldNotBeInterrupted = false;
					if ( strfind(arg1, spellStartStr ) ) then
						unitName, spellName = OneHitWonder_ExtractUnitNameFromCombatMessage(msg, sender, spellStartStr);
						local qweqwe = "No unit found";
						if ( unitName ) then
							qweqwe = unitName;
						end
						if ( spellName ) then
							qweqwe = qweqwe..":"..spellName;
						end
						if ( (not spellShouldNotBeInterrupted ) and (OneHitWonder_IsTargetedUnit(unitName)) and ( OneHitWonder_ShouldTryToInterruptSpell ) ) then
							for k, v in ONEHITWONDER_QUEUE_INTERRUPT_SPELL_CHAT_TYPES do
								if ( strfind(event, v) ) then
									shouldInterrupt = true;
									break;
								end
							end
							if ( shouldInterrupt ) then
								OneHitWonder_TryToInterruptSpell(unitName, spellName);
								break;
							end
						end
						if ( shouldInterrupt ) then break; end
					end
				end
				shouldInterrupt = false;
				for k, spellStartStr in OneHitWonder_Chat_SpellCastingCompletedStrings do
					if ( strfind(arg1, spellStartStr ) ) then
						unitName, spellName = OneHitWonder_ExtractUnitNameFromCombatMessage(msg, sender, spellStartStr);
						local qweqwe = "No unit found";
						if ( unitName ) then
							qweqwe = unitName;
						end
						if ( spellName ) then
							qweqwe = qweqwe..":"..spellName;
						end
						if ( (OneHitWonder_IsTargetedUnit(unitName)) and ( OneHitWonder_ShouldTryToDispellSpell ) ) then
							OneHitWonder_UnitHasGainedSpell(unitName, spellName);
							break;
						end
						if ( shouldInterrupt ) then break; end
					end
				end
				for k, dodgeStr in OneHitWonder_Chat_DodgingStrings do
					if ( strfind(arg1, dodgeStr) ) then
						unitName = OneHitWonder_ExtractUnitNameFromCombatMessage(msg, sender, dodgeStr);
						if ( ( strfind(arg1, dodgeStr ) ) and (OneHitWonder_IsTargetedUnit(unitName)) and ( OneHitWonder_ShouldTryToAntiDodge ) ) then
							OneHitWonder_DoTargetDodgeCounter();
							break;
						end
					end
				end
			end
			for k, parryStr in OneHitWonder_Chat_ParryStrings do
				if ( ( OneHitWonder_UseParryCounter ) and ( strfind(msg, parryStr) ) ) then
					OneHitWonder_DoParryCounter();
					break;
				end
			end
			for k, str in OneHitWonder_Chat_BlockStrings do
				if ( ( OneHitWonder_UseBlockCounter ) and ( strfind(msg, str) ) ) then
					OneHitWonder_DoBlockCounter();
					break;
				end
			end
			for k, str in OneHitWonder_Chat_DodgeStrings do
				if ( ( OneHitWonder_UseDodgeCounter ) and ( strfind(msg, str) ) ) then
					OneHitWonder_DoDodgeCounter();
					break;
				end
			end
		end
	end
end

function OneHitWonder_HasTarget()
	local targetName = UnitName("target");
	if ( not targetName ) or ( strlen(targetName) <= 0 ) then
		return false;
	else
		return true;
	end
end

function OneHitWonder_HasTargetBuffTexture(texture)
	local buff;
	for i=1, MAX_TARGET_DEBUFFS do
		buff = UnitBuff("target", i);
		if ( buff == texture ) then
			return true;
		end
	end
	return false;
end

function OneHitWonder_HasTargetDebuffTexture(texture)
	local debuff;
	local i = 0;
	for i=1, MAX_TARGET_DEBUFFS do
		debuff = UnitDebuff("target", i);
		if ( debuff == texture ) then
			return true;
		end
	end
	return false;
end

function OneHitWonder_HasTargetAnyBuffTexture(texture)
	if ( OneHitWonder_HasTargetBuffTexture(texture) ) then
		return true;
	else
		return OneHitWonder_HasTargetDebuffTexture(texture);
	end
end

-- OneHitWonder_HasUnitEffect (unitName, texture, name) 
--
--  determines if the specified unit has an effect (buff/debuff) with the specified texture(s) and name(s)
--
--  unitName - the unit name to check for buffs - accepts pet/player/partyX/target
--  
function OneHitWonder_HasUnitEffect(unitName, texture, name)
	if ( OneHitWonder_GetUnitEffect(unitName, texture, name) ) then
		return true;
	else
		return false;
	end
end

function OneHitWonder_GetUnitEffect(unitName, texture, name)
	return DynamicData.effect.getEffectInfo(unitName, name, texture);
end

function OneHitWonder_HasUnitEffectOld(unitName, texture, name)
	if ( unitName == "player") then
		return OneHitWonder_HasPlayerEffectOld(texture, name);
	end
	local id = 1;
	local i, buffName;
	local buffIndex, untilCancelled;
	local textureList = {};
	if ( type(texture) == "table" ) then
		textureList = texture;
	else
		textureList = { texture };
	end
	local nameList = {};
	if ( type(name) == "table" ) then
		nameList = name;
	else
		nameList = { name };
	end
	if ( name ) then
		for i = 0, MAX_PARTY_TOOLTIP_BUFFS do
			buffName = OneHitWonder_GetBuffNameUsingBuffIndex(unitName, i);
			if ( OneHitWonder_IsStringInList(buffName, nameList) ) then
				return true;
			end
		end
		for i = 0, MAX_PARTY_TOOLTIP_DEBUFFS do
			buffName = OneHitWonder_GetBuffNameUsingBuffIndex(unitName, i, true);
			if ( OneHitWonder_IsStringInList(buffName, nameList) ) then
				return true;
			end
		end
	end
	if ( texture ) then
		local buffTexture = nil;
		for i = 0, MAX_PARTY_TOOLTIP_BUFFS do
			buffTexture = UnitBuff(unitName, i);
			if ( OneHitWonder_IsStringInList(buffTexture, textureList) ) then
				return true;
			end
		end
		for i = 0, MAX_PARTY_TOOLTIP_DEBUFFS do
			buffTexture = UnitDebuff(unitName, i);
			if ( OneHitWonder_IsStringInList(buffTexture, textureList) ) then
				return true;
			end
		end
	end
	return false;
end

function OneHitWonder_GetPlayerTrackingBuffStrings()
	local tooltipName = "OneHitWonderTooltip";
	local tooltip = getglobal(tooltipName);
	if ( not tooltip ) then
		OneHitWonder_Print("OHW: Could not find tooltip to extract spell ID info from "..tooltipName, 1.0, 0.2, 0.2);
		return nil;
	end
	OneHitWonder_ClearTooltip(tooltipName);
	if ( DynamicData ) and ( DynamicData.util ) and ( DynamicData.util.protectTooltipMoney ) then
		DynamicData.util.protectTooltipMoney();
	end 
	tooltip:SetTrackingSpell();
	if ( DynamicData ) and ( DynamicData.util ) and ( DynamicData.util.unprotectTooltipMoney ) then
		DynamicData.util.unprotectTooltipMoney();
	end 
	
	local strings = OneHitWonder_ScanTooltip(tooltipName);
	return strings;
end

function OneHitWonder_GetPlayerTrackingBuffName()
	local tooltipName = "OneHitWonderTooltip";
	local tooltip = getglobal(tooltipName);
	if ( not tooltip ) then
		OneHitWonder_Print("OHW: Could not find tooltip to extract spell ID info from "..tooltipName, 1.0, 0.2, 0.2);
		return nil;
	end
	OneHitWonder_ClearTooltip(tooltipName);
	if ( DynamicData ) and ( DynamicData.util ) and ( DynamicData.util.protectTooltipMoney ) then
		DynamicData.util.protectTooltipMoney();
	end 
	tooltip:SetTrackingSpell();
	if ( DynamicData ) and ( DynamicData.util ) and ( DynamicData.util.unprotectTooltipMoney ) then
		DynamicData.util.unprotectTooltipMoney();
	end 
	
	local strings = OneHitWonder_ScanTooltip(tooltipName);
	
	if ( strings ) and ( strings[1] ) and ( strings[1].left ) then
		return strings[1].left;
	else
		return nil;
	end
end

function OneHitWonder_HasPlayerEffect(texture, name)
	return OneHitWonder_HasUnitEffect("player", texture, name);
end

function OneHitWonder_HasPlayerEffectOld(texture, name)
	local id = 1;
	local i, buffName;
	local buffIndex, untilCancelled;
	local textureList = {};
	if ( type(texture) == "table" ) then
		textureList = texture;
	else
		textureList = { texture };
	end
	local nameList = {};
	if ( type(name) == "table" ) then
		nameList = name;
	else
		nameList = { name };
	end
	if ( texture ) then
		local isDebuff = false;
		local buffTexture = nil;
		local buffName = nil;
		for id = 1, 24 do
			buffTexture = GetPlayerBuffTexture(id);
			if ( OneHitWonder_IsStringInList(buffTexture, textureList) ) then
				if ( name ) then
					if ( id >= 20 ) then
						isDebuff = true;
					else
						isDebuff = false;
					end
					buffName = OneHitWonder_GetBuffNameUsingBuffIndex("player", id, isDebuff);
					if ( OneHitWonder_IsStringInList(buffName, nameList) ) then
						return true;
					end
				else
					return true;
				end
			end
		end
		local icon = GetTrackingTexture();
		if ( icon == texture ) then 
			if ( name ) then
				local trackBuffName = OneHitWonder_GetPlayerTrackingBuffName()
				if ( trackBuffName == name) then
					return true;
				end
			else
				return true;
			end
		end
	end
	if ( name ) then
		for i = 0, MAX_PARTY_TOOLTIP_BUFFS do
			buffIndex, untilCancelled = GetPlayerBuff(i, "HELPFUL|PASSIVE");
			if ( buffIndex >= 0 ) then
				buffName = OneHitWonder_GetBuffNameUsingBuffIndex("player", buffIndex);
				if ( OneHitWonder_IsStringInList(buffName, nameList) ) then
					return true;
				end
			end
		end
		for i = 0, MAX_PARTY_TOOLTIP_DEBUFFS do
			buffIndex, untilCancelled = GetPlayerBuff(i, "HARMFUL");
			if ( buffIndex >= 0 ) then
				buffName = OneHitWonder_GetBuffNameUsingBuffIndex("player", buffIndex, true);
				if ( OneHitWonder_IsStringInList(buffName, nameList) ) then
					return true;
				end
			end
		end
		local trackBuffName = OneHitWonder_GetPlayerTrackingBuffName()
		if ( trackBuffName == name) then
			return true;
		end
	end
	return false;
end

function OneHitWonder_HasBuffTexture(texture)
	local id = 1;
	for id = 0, 15 do
		if ( GetPlayerBuffTexture(id) == texture ) then
			return true;
		end
	end
	return false;
end

ONEHITWONDER_BOOK_TYPE_SPELL = "spell";

function OneHitWonder_GetRankAsNumber(rankName)
	if ( rankName ) then
		local index, index2 = strfind(rankName, "Rank");
		if ( ( index ) and (index2 ) ) then
			local tmpStr = strsub(rankName, index2+1);
			while ( ( tmpStr) and ( strlen(tmpStr) > 1 ) and ( strsub(tmpStr, 1, 1) == " " ) ) do
				tmpStr = strsub(tmpStr, 2);
			end
			local i = tonumber(tmpStr);
			if ( i ) then
				return i;
			else
				return 0;
			end
		else
			return 0;
		end
	else
		return 0;
	end
end

function OneHitWonder_GetSpellName(spellId, spellBook, doNoUseCache)
	local name = nil;
	local rankName = nil;
	if ( ( 1 ) or 
		( ( not OneHitWonder_SpellIdInfo ) or ( not OneHitWonder_SpellIdInfo[spellBook]) or 
			( not OneHitWonder_SpellIdInfo[spellBook][spellId]) ) ) then
		name, rankName = GetSpellName(spellId, spellBook);
	else
		spellInfo = OneHitWonder_SpellIdInfo[spellBook][spellId];
		if ( spellInfo ) and ( getn(spellInfo) >= 1 ) then
			name = spellInfo[1].left;
			if ( getn(spellInfo) >= 2 ) then
			 	rankName = spellInfo["rank"];
			end
		-- else
		--	name, rankName = GetSpellName(spellId, spellBook);
		end
	end
	return name, rankName;
end

function OneHitWonder_GetSpellId(spellName, spellRank, spellBook, doNotUseCache)
	local i = 1;
	local highestId = -1;
	local highestRankSoFar = -1;
	local rank;
	local spellRankNumber = 0;
	if (spellRank) then
		spellRankNumber = tonumber(spellRank);
		if (not spellRankNumber) then
			spellRankNumber = 0;
		end
	end
	if ( not spellBook ) then
		spellBook = OneHitWonder_GetSpellBook();
	end
	local name, rankName;
	name, rankName = OneHitWonder_GetSpellName(i, spellBook, doNotUseCache);
	while name do
		if ( name == spellName) then
			if ( spellRank == nil ) then
				rank = OneHitWonder_GetRankAsNumber(rankName);
				if ( rank ) then
					if ( rank > highestRankSoFar ) then
						highestRankSoFar = rank;
						highestId = i;
					end
				else
					return i;
				end
			else
				rank = OneHitWonder_GetRankAsNumber(rankName);
				if ( rank == spellRankNumber ) then
					highestId = i;
					break;
				elseif ( rank > highestRankSoFar ) then
					highestRankSoFar = rank;
					highestId = i;
				end
			end
		end
		i = i + 1;
		name, rankName = OneHitWonder_GetSpellName(i, spellBook)
	end
	return highestId;
end

function OneHitWonder_HasEnoughEnergy(abilityName, ignoreEnergyReservation)
	local energy = PlayerFrameManaBar:GetValue();
	
	if ( not ignoreEnergyReservation ) then
		energy = energy - OneHitWonder_EnergyReservation;
	end

	if ( OneHitWonder_GetEnergyConsumption(abilityName) <= energy ) then
		return true;
	else
		return false;
	end
end

function OneHitWonder_HasEnoughRage(abilityName, ignoreRageReservation)
	local rage = PlayerFrameManaBar:GetValue();
	local rageRequired = OneHitWonder_GetRageConsumption(abilityName);

	if ( ignoreRageReservation == true ) then
	else
		rage = rage - OneHitWonder_RageReservation;
		if ( type(ignoreRageReservation) == "number" ) and ( ignoreRageReservation > rageRequired ) then
			if ( rage >= ignoreRageReservation ) then
				return true;
			else
				return false;
			end
		end
	end

	if ( rageRequired <= rage ) then
		return true;
	else
		return false;
	end
end


function OneHitWonder_GetActionId(texture)
	if ( texture ) then
		local id = 1;
		local actionTexture;
		for id = 1, 120 do
			actionTexture = GetActionTexture(id);
			if ( ( actionTexture ) and ( actionTexture == texture ) ) then
				return id;
			end
		end
	end
	return -1;
end

function OneHitWonder_GetSpellBook(spellBook)
	if ( not spellBook ) then spellBook = ONEHITWONDER_BOOK_TYPE_SPELL; end;
	return spellBook;
end

OneHitWonder_SpellsNotInActionBar = {};

function OneHitWonder_CheckIfInRangeSpellId(id, spellBook)
	local actionId = 0;
	spellBook = OneHitWonder_GetSpellBook(spellBook);
	actionId = OneHitWonder_GetActionIdFromSpellId(id, spellBook);
	if ( actionId <= -1 ) then
		OneHitWonder_SpellsNotInActionBar[actionId] = 1;
	end
	return OneHitWonder_CheckIfInRangeActionId(actionId);
end

function OneHitWonder_CheckIfInRangeActionId(id)
	if ( ( id ) and ( id >= 1) and ( IsActionInRange(id) == 0) ) then
		return false;
	else	
		return true;
	end
end

function OneHitWonder_CheckIfUsableActionId(id)
	if ( id ) and ( id >= 1) then
		local isUsable, notEnoughMana = IsUsableAction(id);
		if ( ( isUsable ) and ( not notEnoughMana ) )  then
			return true;
		else
			return false;
		end
	else	
		return true;
	end
end

function OneHitWonder_CheckIfSpellIsCoolingdownById(id, spellBook)
	if ( id == -1 ) then
		return true;
	end
	spellBook = OneHitWonder_GetSpellBook(spellBook);
	local start, duration, enable = GetSpellCooldown(id, spellBook);
	--OneHitWonder_Log(spellId, spellBook, start, duration, enable);
	if ( enable == 1 ) then
		if ( ( (start + duration) < GetTime() ) or ( (start + duration) == 0 ) ) then
			return false;
		end
	end
	return true;
end

function OneHitWonder_CheckIfUsable(actionId, spellId, spellBook)
	spellBook = OneHitWonder_GetSpellBook(spellBook);
	if ( spellId > -1 ) then
		if ( OneHitWonder_CheckIfSpellIsCoolingdownById(spellId, spellBook) ) then
			return false;
		end
	end
	return OneHitWonder_CheckIfUsableActionId(actionId);
end

function OneHitWonder_CheckIfUsableSpellId(id, spellBook)
	if ( id == -1 ) then
		return false;
	end
	spellBook = OneHitWonder_GetSpellBook(spellBook);
	local actionId = -1;
	if ( not OneHitWonder_CheckIfSpellIsCoolingdownById(id, spellBook) ) then
		actionId = OneHitWonder_GetActionIdFromSpellId(id, spellBook);
		return OneHitWonder_CheckIfUsableActionId(actionId);
	end
	return false;
end

function OneHitWonder_CheckIfInRangeAndUsableInActionBar(texture)
	if ( texture ) then
		local id = OneHitWonder_GetActionId(texture);
		if ( (OneHitWonder_CheckIfUsableActionId(id) ) and ( OneHitWonder_CheckIfInRangeActionId(id) ) ) then
			return true;
		else
			return false;
		end
	end
	return false;
end

function OneHitWonder_CheckIfInRangeAndUsableInActionBarByActionId(actionId)
	if ( (OneHitWonder_CheckIfUsableActionId(actionId) ) and ( OneHitWonder_CheckIfInRangeActionId(actionId) ) ) then
		return true;
	else
		return false;
	end
end

-- /script PrintTable(OneHitWonder_SpellAvailability);
-- /script OneHitWonder_SpellAvailability = {};

OneHitWonder_SpellAvailability = {};

function OneHitWonder_Log(spellId, spellBook, start, duration, enable)
	if ( spellId <= -1 ) then
		return
	end
	if ( enable == 0 ) then
		return;
	end
	if ( not OneHitWonder_SpellAvailability[spellId]) then
		OneHitWonder_SpellAvailability[spellId] = {};
	end
	local currentTime = GetTime() * 1000;
	local cooldownTime = start * 1000 + duration * 1000;
	local available = "true";
	if ( cooldownTime > currentTime ) then
		available = "false";
	end
	local parameter = {start, duration, enable, GetTime(), available};
	table.insert(OneHitWonder_SpellAvailability[spellId], parameter);
end

function OneHitWonder_IsSpellAvailable(spellId, spellBook)
	if ( spellId ) and ( type(spellId) ~= "number" ) then
		--OneHitWonder_Print("strangespell id = "..spellId);
		local attemptId = tonumber(spellId);
		if ( not attemptId ) then
			return false;
		else
			spellId = attemptId;
		end
	end
	if ( not spellId ) or ( spellId <= -1 ) then
		return false;
	end
	spellBook = OneHitWonder_GetSpellBook(spellBook);
	if( OneHitWonder_IsSpellCoolingDown(spellId, spellBook ) ) then
		return false;
	elseif( OneHitWonder_CheckIfInRangeAndUsableInActionBar(GetSpellTexture(spellId, spellBook)) ) then
		return true;
	end
	return false;
end

function OneHitWonder_IsSpellCoolingDown(spellId, spellBook)
	if ( ( not spellId ) or (  spellId <= -1 ) ) then
		return false;
	end
	spellBook = OneHitWonder_GetSpellBook(spellBook);
	local start, duration, enable = GetSpellCooldown(spellId, spellBook);
	local sd = start + duration;
	if ( enable == 1 ) then
	end
		if ( ( sd == 0 ) or ( sd < GetTime() ) ) then
			return false;
		end
	return true;
end

function OneHitWonder_GetSpellCooldown(spellId, spellBook)
	if ( spellId <= -1 ) then
		return -1;
	end
	spellBook = OneHitWonder_GetSpellBook(spellBook);
	local start, duration, enable = GetSpellCooldown(spellId, spellBook);
	if ( enable == 1 ) then
		local dur = start + duration;
		if ( dur > 0 ) then
			dur = dur - GetTime();
		end
		if ( dur < 0 ) then
			dur = 0;
		end
		return dur;
	end
	return 0;
end

function OneHitWonder_CanCastSpells()
	if ( OneHitWonder_HasPlayerEffect(nil, ONEHITWONDER_DO_NOT_CAST_SPELLS_EFFECT) ) then
		return false;
	end
	return true;
end

OneHitWonder_LastSpellId = nil;
OneHitWonder_LastSpellBook = nil;

function OneHitWonder_CastSpell(spellId, spellBook)
	if ( not spellBook ) then
		spellBook = "spell";
	end
	if ( type(spellId) == "string" ) then
		local id = tonumber(spellId);
		if ( not id ) then
			id = OneHitWonder_GetSpellId(spellId, nil, spellBook);
		end
		spellId = id;
	end
	if ( not spellId ) or ( spellId <= -1 ) then
		return false;
	end
	if ( not OneHitWonder_CanCastSpells() ) then
		return false;
	end
	spellBook = OneHitWonder_GetSpellBook(spellBook);
	if ( OneHitWonder_IsSpellAvailable(spellId, spellBook) ) then
		OneHitWonder_LastSpellId = spellId;
		OneHitWonder_LastSpellBook = spellBook;
		
		if ( OneHitWonder_ReportSpells == 1 ) then
			local spellInfo = DynamicData.spell.getSpellInfo(spellId, spellBook);
			if ( spellInfo ) and ( spellInfo.name ) then
				OneHitWonder_Print("Attempted to cast "..spellInfo.name);
			end
		end
		-- in some cases (shadow word pain for example) the CastSpell call changes target to self. This is a hack to put it back.
		local targetName = UnitName("target");
		CastSpell(spellId, spellBook);
		local newTargetName = UnitName("target");
		if (targetName ~= newTargetName) then
			TargetLastTarget()
		end
		return true;
	end
	return false;
end

function OneHitWonder_GetTargetHPPercentage()
	return OneHitWonder_GetUnitHPPercentage("target");
-- old way
--	local unitMinHP, unitMaxHP, unitCurrHP;
--	unitMinHP, unitMaxHP = TargetFrameHealthBar:GetMinMaxValues();
--	unitCurrHP = TargetFrameHealthBar:GetValue();
--	
--	local unitHPPercent = TargetFrame.unitHPPercent;
--
--	if ( not UnitIsPlayer("target") ) then
--		unitHPPercent = unitCurrHP;
--	else
--		unitHPPercent = math.floor(unitHPPercent * 100);
--	end
--	return unitHPPercent;
end

function OneHitWonder_GetUnitHPPercentage(unit)
	local unitMaxHP, unitCurrHP;
	unitMaxHP = UnitHealthMax(unit);
	unitCurrHP = UnitHealth(unit);
	if ( unitCurrHP == 0 ) then
		return 0;
	else
		return (unitCurrHP * 100 )/ unitMaxHP;
	end
end

function OneHitWonder_GetPlayerHPPercentage()
	return OneHitWonder_GetUnitHPPercentage("player");
end

function OneHitWonder_GetUnitManaPercentage(unit)
	local unitMaxMana, unitCurrMana;
	unitMaxMana = UnitManaMax(unit);
	unitCurrMana = UnitMana(unit);
	if ( unitCurrMana == 0 ) then
		return 0;
	else
		return (unitCurrMana * 100 ) / unitMaxMana ;
	end
end

function OneHitWonder_GetPlayerManaPercentage()
	return OneHitWonder_GetUnitManaPercentage("player");
end

function OneHitWonder_WiggleStop()
	MoveForwardStop();
end

function OneHitWonder_Wiggle()
	if ( CosmosSchedule ) then
		MoveForwardStart();
		CosmosSchedule(0.2, OneHitWonder_WiggleStop);
	end
end

function OneHitWonder_IsInPartyOrRaid()
	if ( ( GetNumPartyMembers() > 0 ) or ( GetNumRaidMembers() > 0  ) ) then
		return true;
	else
		return false;
	end
end

function OneHitWonder_HasPartyMembers()
	if ( GetNumPartyMembers() > 0 ) then
		return true;
	else
		return false;
	end
end

function OneHitWonder_DumpDebuffsOnce()
	if ( not DebuffsShown ) then
		DebuffsShown = {};
	end
	local debuff;
	for i=1, MAX_TARGET_DEBUFFS do
		debuff = UnitDebuff("target", i);
		if ( ( debuff ) and ( not DebuffsShown[debuff] ) ) then
			OneHitWonder_Print(debuff);
			DebuffsShown[debuff] = true;
		end
	end
end

function OneHitWonder_DumpTargetBuffs()
	local debuff;
	for i=1, MAX_TARGET_DEBUFFS do
		debuff = UnitBuff("target", i);
		if ( ( debuff ) ) then
			OneHitWonder_Print(debuff);
		end
	end
end

function OneHitWonder_DumpTargetDebuffs()
	local debuff;
	for i=1, MAX_TARGET_DEBUFFS do
		debuff = UnitDebuff("target", i);
		if ( ( debuff ) ) then
			OneHitWonder_Print(debuff);
		end
	end
end

function OneHitWonder_DumpOwnBuffs()
	local texture, buffIndex, untilCancelled;
	for i = 0, MAX_PARTY_TOOLTIP_BUFFS do
		buffIndex, untilCancelled = GetPlayerBuff(i, "HELPFUL|PASSIVE");
		if ( buffIndex >= 0 ) then
			texture = GetPlayerBuffTexture(buffIndex);
			OneHitWonder_Print(texture);
		end
	end
end

function OneHitWonder_GetBuffNameUsingBuffIndex(unit, buffIndex, debuff)
-- New Tooltip handling by Kinesia.
	local name = nil
	-- if any texture is returned it's a good buff.
	if UnitBuff(unit,buffIndex) then 
		OneHitWonderTooltip:SetOwner(UIParent);
		OneHitWonderTooltipTextLeft1:SetText('');
		if (not debuff) then 
			OneHitWonderTooltip:SetUnitBuff(unit, buffIndex);
		else
			OneHitWonderTooltip:SetUnitDebuff(unit, buffIndex);
		end
		-- If the Tooltip has text on the Left1 it may be a buff player can cast
		name = OneHitWonderTooltipTextLeft1:GetText()
	end
	return name
end 

-- Kinesia Old way.
function OneHitWonder_GetBuffNameUsingBuffIndexOld(unit, buffIndex, debuff)
    if (buffIndex ~= -1) then
		local tooltipName = "OneHitWonderTooltip";
		local tooltip = getglobal(tooltipName);
		local tooltiptext = getglobal(tooltipName.."TextLeft1");
		if ( tooltiptext ) then
			tooltiptext:SetText("");
		end
		OneHitWonder_ClearTooltip(tooltipName);
		if ( unitName == "player" ) then
			tooltip:SetPlayerBuff(buffIndex);
		else
			if ( not debuff ) then
				tooltip:SetUnitBuff(unitName, buffIndex);
			else
				tooltip:SetUnitDebuff(unitName, buffIndex);
			end
		end
		if ( tooltiptext ) then
			local name = tooltiptext:GetText();
			if ( ( name ~= nil ) and ( strlen(name) > 0 ) ) then
				return name;
			end
		end
	end
	return nil;
end

function OneHitWonder_DumpOwnBuffNames()
	local name, buffIndex, untilCancelled;
	for i = 0, MAX_PARTY_TOOLTIP_BUFFS do
		buffIndex, untilCancelled = GetPlayerBuff(i, "HELPFUL|PASSIVE");
		if ( buffIndex >= 0 ) then
			name = OneHitWonder_GetBuffNameUsingBuffIndex("player", buffIndex);
			if ( name ) then
				OneHitWonder_Print(name);
			end
		end
	end
end

function OneHitWonder_AddActionToQueue(actionId, actionParameter)
	local foundEqual = false;
	local entry = { actionId, actionParameter};
	local actionParameterType = type(actionParameter);
	for k, v in OneHitWonder_ActionQueue do
		if ( v[1] == actionId ) then
			if ( type(v[2]) == actionParameterType ) then
				foundEqual = true;
				if ( actionParameterType == "table" ) then
					for key, value in v[2] do
						if ( actionParameter[key] ~= value ) then
							foundEqual = false;
							break;
						end
					end
				else
					foundEqual = ( v[2] == actionParameter );
				end
				if ( foundEqual ) then
					return;
				end
			end
		end
	end
	table.insert(OneHitWonder_ActionQueue, entry);
	OneHitWonder_ShowQueue();
	--OneHitWonder_ShowImperativeMessage(ONEHITWONDER_ACTION_QUEUE_UPDATED);
end

function OneHitWonder_RemoveActionFromQueue(actionId, actionParameter)
	local entry = table.remove(OneHitWonder_ActionQueue);
	OneHitWonder_ShowQueue();
	return entry[1], entry[2];
end

-- /script PrintTable(OneHitWonder_ActionQueue);
function OneHitWonder_GetTimeRemaining(spellId, spellBook)
	spellBook = OneHitWonder_GetSpellBook(spellBook);
	local start, duration, enable = GetSpellCooldown(spellId, spellBook);
	if ( ( start > 0 ) and ( duration > 0 ) ) then
		return (( start + duration ) - GetTime());
	else
		return 0;
	end
end

function OneHitWonder_UseCountermeasures()
	if ( not OneHitWonder_IsEnabled() ) then return; end
	return OneHitWonder_HandleActionQueue();
end

function OneHitWonder_ShouldHandleActionQueue()
	if ( OneHitWonder_IsChannelSpellRunning() ) or ( OneHitWonder_IsRegularSpellRunning() ) then
		return false;
	end
	if ( not OneHitWonder_CanCastSpells() ) then
		return false;
	end
	local class = OneHitWonder_GetPlayerClass();
	if ( not class ) then
		return true;
	end
	local func = getglobal(format("OneHitWonder_ShouldHandleActionQueue_%s", class));
	if ( func ) then
		return func;
	else
		return true;
	end
end

function OneHitWonder_GetSpellNameFromSpellId(spellId)
	local spellInfo = DynamicData.spell.getSpellInfo(spellId);
	if ( spellInfo ) then
		return spellInfo.name;
	else
		return "<Unknown Spell>";
	end
end

function OneHitWonder_GetActionNameFromActionId(actionId)
	local actionInfo = DynamicData.action.getActionInfo(actionId);
	if ( actionInfo ) then
		return actionInfo.name;
	else
		return "<Unknown Action>";
	end
end


function OneHitWonder_ShowQueue()
	if ( OneHitWonder_Enabled ~= 1 ) or ( ( not OneHitWonder_ShouldShowQueue ) or ( OneHitWonder_ShouldShowQueue == 0 ) ) then
		OneHitWonderQueueFrame:Hide();
		return;
	end
	--[[
	if ( MinimapCluster ) and ( MinimapCluster:IsVisible() ) then
		OneHitWonderQueueFrame:ClearAllPoints();
		OneHitWonderQueueFrame:SetPoint("RIGHT", "MinimapCluster", "LEFT", -10, -40);
	end
	]]--
	local queueNumber = getn(OneHitWonder_ActionQueue);
	local mainText = "";
	local subText = "";
	if ( queueNumber <= 0 ) then
		mainText = "Empty";
	else
		local extraName = nil;
		local currentAction = OneHitWonder_ActionQueue[1];
		local actionQueueId = currentAction[1];
		if ( ( actionQueueId == ONEHITWONDER_ACTIONID_SPELL ) or 
		( actionQueueId == ONEHITWONDER_ACTIONID_SPELL_TIMEOUT ) or 
		( actionQueueId == ONEHITWONDER_ACTIONID_SPELL_TARGET ) or 
		( actionQueueId == ONEHITWONDER_ACTIONID_SPELL_ITEM ) ) then
			local spellId = currentAction[2];
			if ( type(spellId) == "table" ) then
				spellId = spellId[1];
			end
			extraName = OneHitWonder_GetSpellNameFromSpellId(spellId);
			if ( OneHitWonder_ShouldShowQueueFull ) then
				mainText = format("%s Queued [%d]", extraName,queueNumber);
			end
		elseif ( actionQueueId == ONEHITWONDER_ACTIONID_ACTION_SELF ) then
			local actionId = currentAction[2];
			if ( type(actionId) == "table" ) then
				actionId = actionId[1];
			end
			extraName = OneHitWonder_GetActionNameFromActionId(actionId);
			if ( OneHitWonder_ShouldShowQueueFull ) then
				mainText = format("%s Queued [%d]", extraName, queueNumber);
			end
		else
			if ( OneHitWonder_ShouldShowQueueFull ) then
				mainText = format("Unknown Queued [%d]", queueNumber);
			end
		end
		if ( extraName ) then
			mainText = format("%d (%s)", queueNumber, extraName);
		else
			mainText = format("%d", queueNumber);
		end
	end
	if( strlen(mainText) > 0 ) then
		OneHitWonderQueueFrameString:SetText(mainText);
		OneHitWonderQueueFrameString:Show();
	else
		OneHitWonderQueueFrameString:Hide();
	end
	if( strlen(subText) > 0 ) then
		OneHitWonderQueueFrameSubString:SetText(subText);
		OneHitWonderQueueFrameSubString:Show();
	else
		OneHitWonderQueueFrameSubString:Hide();
	end
	OneHitWonderQueueFrame:Show();
end

function OneHitWonder_HandleActionQueue()
	if ( getn(OneHitWonder_ActionQueue) <= 0 ) then
		return false;
	end

	if ( not OneHitWonder_ShouldHandleActionQueue() ) then
		return false;
	end

	
	local actionId, actionParameter = OneHitWonder_RemoveActionFromQueue();

	
	if ( actionId == ONEHITWONDER_ACTIONID_SPELL ) then
		if ( not actionParameter ) then
			return OneHitWonder_HandleActionQueue();
		end
		if ( OneHitWonder_CastSpell(actionParameter, ONEHITWONDER_BOOK_TYPE_SPELL ) ) then
			return true;
		else
			return false;
		end
	elseif ( actionId == ONEHITWONDER_ACTIONID_SPELL_TIMEOUT ) then
		local spellId = actionParameter[1];
		local timeout = actionParameter[2];
		if ( not spellId ) or ( GetTime() >= timeout ) then
			return OneHitWonder_HandleActionQueue();
		else
			if ( OneHitWonder_IsSpellAvailable(spellId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
				if ( OneHitWonder_CastSpell(spellId, ONEHITWONDER_BOOK_TYPE_SPELL ) ) then
					return true;
				else
					return false;
				end
			else
				OneHitWonder_AddActionToQueue(actionId, actionParameter);
				local remainingTime = OneHitWonder_GetTimeRemaining(spellId, ONEHITWONDER_BOOK_TYPE_SPELL );
				if ( remainingTime <= 1 ) then
					return true;
				end
				return false;
			end
		end
	elseif ( actionId == ONEHITWONDER_ACTIONID_SPELL_TARGET ) then
		local spellId = actionParameter[1];
		local unit = actionParameter[2];
		--[[
		local unitName = actionParameter[3];
		local timeout = actionParameter[4]
		if ( unitName ) and ( UnitName(unit) ~= unitName ) then
			return OneHitWonder_HandleActionQueue();
		end
		]]--
		local timeout = actionParameter[3];
		if ( type(timeout) == "string" ) then
			timeout = actionParameter[4];
			if ( not timeout ) then
				timeout = tonumber(actionParameter[3]);
			end
		end
		if ( not spellId ) or ( ( timeout ) and ( GetTime() >= timeout ) ) then
			return OneHitWonder_HandleActionQueue();
		end
		if ( OneHitWonder_IsSpellAvailable(spellId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
			if ( OneHitWonder_CastSpell(spellId, ONEHITWONDER_BOOK_TYPE_SPELL ) ) then
				SpellTargetUnit(unit);
				return true;
			else
				return false;
			end
		else
			OneHitWonder_AddActionToQueue(actionId, actionParameter);
			return false;
		end
	elseif ( actionId == ONEHITWONDER_ACTIONID_SPELL_ITEM ) then
		local spellId = actionParameter[1];
		local bag = actionParameter[2];
		local slot = actionParameter[3];
		if ( not spellId ) then
			return OneHitWonder_HandleActionQueue();
		end
		if ( OneHitWonder_IsSpellAvailable(spellId, ONEHITWONDER_BOOK_TYPE_SPELL) ) then
			if ( OneHitWonder_CastSpell(spellId, ONEHITWONDER_BOOK_TYPE_SPELL ) ) then
				if ( bag > -1 ) then
					UseContainerItem(bag, slot);
				else
					UseInventoryItem(slot);
				end
				return true;
			else
				return false;
			end
		else
			OneHitWonder_AddActionToQueue(actionId, actionParameter);
			return false;
		end
	elseif ( actionId == ONEHITWONDER_ACTIONID_ACTION_SELF ) then
		local realActionId = -1;
		local spellId = -1;
		if ( type(actionParameter) == "table" ) then
			realActionId = actionParameter[1];
			spellId = actionParameter[2];
		else
			realActionId = actionParameter;
		end
		if ( not realActionId ) then
			return OneHitWonder_HandleActionQueue();
		end
		if ( ( not spellId ) or ( OneHitWonder_IsSpellAvailable(spellId, ONEHITWONDER_BOOK_TYPE_SPELL) ) ) then
			UseAction(realActionId, 0, 1);
			return true;
		else
			OneHitWonder_AddActionToQueue(actionId, actionParameter);
			return false;
		end
	elseif ( actionId == ONEHITWONDER_ACTIONID_SPELL_BUFF ) then
		local unit = actionParameter[1];
		local timeout = actionParameter[2];
		if ( GetTime() >= timeout ) then
			return OneHitWonder_HandleActionQueue();
		else
			return OneHitWonder_BuffUnit(unit);
		end
	elseif ( actionId == ONEHITWONDER_ACTIONID_SPELL_DEBUFF ) then
		local unit = actionParameter[1];
		local timeout = actionParameter[2];
		if ( GetTime() >= timeout ) then
			return OneHitWonder_HandleActionQueue();
		else
			return OneHitWonder_DebuffUnit(unit);
		end
	else
		return false;
	end
end

function OneHitWonder_ClearTooltipStrings(tooltipName)
	local tooltip = getglobal(tooltipName);
	if ( tooltip ) then
		local textObj = nil;
		for i = 1, 15 do
			textObj = getglobal(tooltipName.."TextLeft"..i);
			if ( textObj ) then
				textObj:SetText("");
			end
			textObj = getglobal(tooltipName.."TextRight"..i);
			if ( textObj ) then
				textObj:SetText("");
			end
		end
	end
end
function OneHitWonder_GetTooltipStrings(tooltipName)
	local strings = {};
	local tooltip = getglobal(tooltipName);
	if ( tooltip ) then
		local textObj = nil;
		local textLeft = nil;
		local textRight = nil;
		for i = 1, 15 do
			strings[i] = {};
			textObj = getglobal(tooltipName.."TextLeft"..i);
			if ( textObj ) then
				textLeft = textObj:GetText();
			else
				textLeft = nil;
			end
			strings[i].left = textLeft;
			textObj = getglobal(tooltipName.."TextRight"..i);
			if ( textObj ) then
				textRight = textObj:GetText();
			else
				textRight = nil;
			end
			strings[i].right = textRight;
		end
	end
	return strings;
end

function OneHitWonder_GetItemTooltipInfo(bag, slot)
	local strings = nil;
	OneHitWonder_ClearTooltipStrings("OneHitWonderTooltip");
	if ( bag > -1 ) then
		DynamicData.util.protectTooltipMoney();
		OneHitWonderTooltip:SetBagItem(bag, slot);
		DynamicData.util.unprotectTooltipMoney();
		strings = OneHitWonder_GetTooltipStrings("OneHitWonderTooltip");
	else
		DynamicData.util.protectTooltipMoney();
		local hasItem, hasCooldown = OneHitWonderTooltip:SetInventoryItem("player", slot);
		DynamicData.util.unprotectTooltipMoney();
		strings = OneHitWonder_GetTooltipStrings("OneHitWonderTooltip");
		if ( not hasItem) then
			OneHitWonder_ClearTooltipStrings("OneHitWonderTooltip");
			if ( strings[1] ) then
				strings[1].left = "";
			end
		end
	end
	return strings;
end


-- Shamelessly stolen from SarfEquip - and modded by sarf.
-- http://www.fukt.bth.se/~k/wow/scripts/SarfEquip/Interface/AddOns/SarfEquip/SarfEquip.lua
function OneHitWonder_GetItemName(bag, slot)
	local name = "";
	if ( DynamicData ) and ( DynamicData.item ) and ( DynamicData.item.getInventoryInfo ) then
		local itemInfo = DynamicData.item.getInventoryInfo(bag, slot);
		if ( itemInfo ) then
			name = itemInfo.name;
		end
	elseif ( DynamicData ) and ( DynamicData.util ) and ( DynamicData.util.getItemNameFromLink ) then
		name = DynamicData.util.getItemNameFromLink(GetContainerItemLink(bag, slot));
	else
		local strings = OneHitWonder_GetItemTooltipInfo(bag, slot);
		if ( strings[1] ) then
			name = strings[1].left;
		end
	end
	return name;
end

function ohw_InitOptions( arr )
	if ( arr ) and (type(arr) == "table" ) then
		for k, v in arr do
			-- YZ: only if we dont have these options in saved ...
			local old_v = OneHitWonder_Options[v];
			if ( old_v == nil ) then
				-- no saved options, use the ones in other files
				local new_v = getglobal(v);
				-- YZLib.dbg.debug2( 1, "OHW new: "..v.." = "..tostring(new_v) );
				OneHitWonder_Options[v] = new_v;
			else
				-- we have saved ops in the Blizz data
				-- setglobal(v, old_v);
			end
		end
	end

end

function OneHitWonder_Init()
	local currentClass = OneHitWonder_GetPlayerClass();
	if ( not currentClass ) or ( strlen(currentClass) <= 0 ) then
		OneHitWonder_ScheduleByName("OHW_AI", 5, OneHitWonder_Init);
		return;
	end
	
	-- YZ: init general options
	ohw_InitOptions( OneHitWonder_Options_Default );

	-- YZ: init class-specific options
	ohw_InitOptions( getglobal(format("OneHitWonder_Options_%s", currentClass)) );
	
	-- YZ: and now, load ALL options back to the engine
	OneHitWonder_LoadOptions();
	
	local func = getglobal(format("OneHitWonder_Init_%s", currentClass));
	if ( func ) then
		func();
	end
	OneHitWonder_UpdateSpellInfo();
	OneHitWonder_RetrieveAllActionIdInfo();

	OneHitWonder_SetupStuffContinuously();
	
	-- YZ: all hooks now @ OneHitWonder_KhaosHooking.lua
	-- OneHitWonder_SetupOverrideBinding();
	
	-- YZ: sign OHW loading OK
	OneHitWonder_Print("OneHitWonder v"..OHW_VERSION.." loaded.", 1, 1, 0 );
end

function OneHitWonder_AfterInit()
end

function OneHitWonder_LoadOptions()
	-- YZLib.dbg.debug2(1, "OneHitWonder - loading options." );
	for k, v in OneHitWonder_Options do
		setglobal(k, v);
	end
end

OneHitWonder_needSetOptions = false;

function OneHitWonder_SetOptions()
	OneHitWonder_needSetOptions = true;
end

function OneHitWonder_DoSetOptions()
	if (OneHitWonder_needSetOptions) then
		OneHitWonder_needSetOptions = false;
		-- YZLib.dbg.debug2(1, "OneHitWonder - saving options." );
		for k, v in OneHitWonder_Options do
			OneHitWonder_Options[k] = getglobal(k);
		end
	end
end

function OneHitWonder_OnLoad()
	OneHitWonder_AddStuffToCosmos();
	OneHitWonder_RegisterInKhaos();

	-- RegisterForSave("OneHitWonder_Options");
	
	if ( ( DynamicData ) and ( DynamicData.item ) and ( DynamicData.item.addOnInventoryUpdateHandler ) ) then
		DynamicData.item.addOnInventoryUpdateHandler(OneHitWonder_Bag_Update);
	end
	
	OneHitWonder_TimeSpellStopped = GetTime();
	
	for k, v in ONEHITWONDER_QUEUE_INTERRUPT_SPELL_CHAT_TYPES do
		this:RegisterEvent("CHAT_MSG_"..v);
	end

	for k, v in ONEHITWONDER_QUEUE_INTERRUPT_SPELL_DODGEPARRYBLOCK_TYPES do
		this:RegisterEvent("CHAT_MSG_"..v);
	end
	
	for k, v in ONEHITWONDER_PARTY_EVENTS do
		this:RegisterEvent("CHAT_MSG_"..v);
	end
	
	for k, v in ONEHITWONDER_IMMUNE_SPELL_TYPES do
		this:RegisterEvent("CHAT_MSG_"..v);
	end
	this:RegisterEvent("CHAT_MSG_MONSTER_EMOTE");
	
	this:RegisterEvent("PET_ATTACK_START");
	this:RegisterEvent("PET_ATTACK_STOP");
	this:RegisterEvent("PET_BAR_HIDEGRID");
	this:RegisterEvent("PET_BAR_SHOWGRID");
	this:RegisterEvent("UNIT_HEALTH");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("CHARACTER_POINTS_CHANGED");
	this:RegisterEvent("ACTIONBAR_SLOT_CHANGED");
	this:RegisterEvent("LEARNED_SPELL_IN_TAB");
	this:RegisterEvent("SPELLS_CHANGED");
	this:RegisterEvent("VARIABLES_LOADED");
	
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");
	this:RegisterEvent("PARTY_MEMBER_ENABLE");
	this:RegisterEvent("PARTY_MEMBER_DISABLE");

	this:RegisterEvent("PLAYER_PET_CHANGED");


	this:RegisterEvent("SPELLCAST_CHANNEL_START");
	--this:RegisterEvent("SPELLCAST_CHANNEL_UPDATE");
	this:RegisterEvent("SPELLCAST_DELAYED");
	this:RegisterEvent("SPELLCAST_FAILED");
	this:RegisterEvent("SPELLCAST_INTERRUPTED");
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("SPELLCAST_STOP");
	
	--DynamicData.effect.addOnEffectUpdateHandler(OneHitWonder_CheckEffect);

	this:RegisterEvent("UI_ERROR_MESSAGE");
end

function OneHitWonder_SetShouldOverrideBindings(toggle)
	if ( OneHitWonder_ShouldOverrideBindings ~= toggle ) then
		OneHitWonder_ShouldOverrideBindings = toggle;
		-- OneHitWonder_SetupOverrideBinding();
	end
end

function OneHitWonder_SetShowInfoMessages(toggle)
	if ( OneHitWonder_ShowInfoMessages ~= toggle ) then
		OneHitWonder_ShowInfoMessages = toggle;
	end
end

function OneHitWonder_SetShouldKeepBuffsUp(toggle)
	if ( OneHitWonder_ShouldKeepBuffsUp ~= toggle ) then
		OneHitWonder_ShouldKeepBuffsUp = toggle;
		OneHitWonder_SetupStuffContinuously();
		OneHitWonder_SetOptions();
	end
end

function OneHitWonder_SetShouldKeepBuffsUpParty(toggle)
	if ( OneHitWonder_ShouldKeepBuffsUpParty ~= toggle ) then
		OneHitWonder_ShouldKeepBuffsUpParty = toggle;
		OneHitWonder_SetupStuffContinuously();
		OneHitWonder_SetOptions();
	end
end

function OneHitWonder_SetNoBuffWhileFishing(toggle)
	if ( OneHitWonder_NoBuffWhileFishing ~= toggle ) then
		OneHitWonder_NoBuffWhileFishing = toggle;
		OneHitWonder_SetOptions();
	end
end

function OneHitWonder_SetupByClass()
	if ( OneHitWonder_OnlyShowCurrentClassSettings == 1 ) then
		--(ugly hack)
		local class = OneHitWonder_GetPlayerClass();
		if ( not class ) then
			OneHitWonder_ScheduleByName("OHW_SETUP_CLASS", 5, OneHitWonder_SetupByClass);
			return;
		end
		func = getglobal(format("OneHitWonder_%s_Cosmos", class));
		if ( func ) then
			func();
		end
	else
		local func;
		for k, v in OneHitWonder_Classes do
			func = getglobal(format("OneHitWonder_%s_Cosmos", v));
			if ( func ) then
				func();
			end
		end
	end
end

function OneHitWonder_SetAutoCure(toggle, value)
	OneHitWonder_ShouldAutoCure = toggle;
	OneHitWonder_AutoCureDelay = value;
end

function OneHitWonder_SetInitiateCombat(toggle)
	OneHitWonder_InitiateCombat = toggle;
end

function OneHitWonder_AddStuffToCosmos()
	if ( Cosmos_RegisterConfiguration ) and ( Cosmos_UpdateValue ) then
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER",
			"SECTION",
			TEXT(ONEHITWONDER_CONFIG_HEADER),
			TEXT(ONEHITWONDER_CONFIG_HEADER_INFO)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_HEADER",
			"SEPARATOR",
			TEXT(ONEHITWONDER_CONFIG_HEADER),
			TEXT(ONEHITWONDER_CONFIG_HEADER_INFO)
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_ENABLED",
			"CHECKBOX",
			TEXT(ONEHITWONDER_ENABLED),
			TEXT(ONEHITWONDER_ENABLED_INFO),
			OneHitWonder_SetEnabled,
			OneHitWonder_Enabled
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_OVERRIDE_BINDINGS",
			"CHECKBOX",
			TEXT(ONEHITWONDER_OVERRIDE_BINDINGS),
			TEXT(ONEHITWONDER_OVERRIDE_BINDINGS_INFO),
			OneHitWonder_SetShouldOverrideBindings,
			OneHitWonder_ShouldOverrideBindings
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_START_COMBAT",
			"CHECKBOX",
			TEXT(ONEHITWONDER_START_COMBAT),
			TEXT(ONEHITWONDER_START_COMBAT_INFO),
			OneHitWonder_SetInitiateCombat,
			OneHitWonder_InitiateCombat
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_AUTO_CURE",
			"BOTH",
			TEXT(ONEHITWONDER_AUTO_CURE),
			TEXT(ONEHITWONDER_AUTO_CURE_INFO),
			OneHitWonder_SetAutoCure,
			OneHitWonder_ShouldAutoCure,
			OneHitWonder_AutoCureDelay,
			1, -- min value
			120, -- max value
			ONEHITWONDER_AUTO_CURE_DELAY_SLIDER, -- slider text
			1, 
			1, 
			ONEHITWONDER_AUTO_CURE_DELAY_APPEND -- slider text append
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_SHOW_REACTIVE_TEXT",
			"CHECKBOX",
			TEXT(ONEHITWONDER_SHOW_REACTIVE_TEXT),
			TEXT(ONEHITWONDER_SHOW_REACTIVE_TEXT_INFO),
			OneHitWonder_SetShouldShowReactiveText,
			OneHitWonder_ShouldReactiveText
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_SHOW_INFO_MESSAGES",
			"CHECKBOX",
			TEXT(ONEHITWONDER_SHOW_INFO_MESSAGES),
			TEXT(ONEHITWONDER_SHOW_INFO_MESSAGES_INFO),
			OneHitWonder_SetShowInfoMessages,
			OneHitWonder_ShowInfoMessages
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_SHOW_QUEUE",
			"CHECKBOX",
			TEXT(ONEHITWONDER_SHOW_QUEUE),
			TEXT(ONEHITWONDER_SHOW_QUEUE_INFO),
			OneHitWonder_SetShouldShowQueue,
			OneHitWonder_ShouldShowQueue
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_KEEP_UP_BUFFS",
			"CHECKBOX",
			TEXT(ONEHITWONDER_KEEP_UP_BUFFS),
			TEXT(ONEHITWONDER_KEEP_UP_BUFFS_INFO),
			OneHitWonder_SetShouldKeepBuffsUp,
			OneHitWonder_ShouldKeepBuffsUp
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_KEEP_UP_BUFFS_PARTY",
			"CHECKBOX",
			TEXT(ONEHITWONDER_KEEP_UP_BUFFS_PARTY),
			TEXT(ONEHITWONDER_KEEP_UP_BUFFS_PARTY_INFO),
			OneHitWonder_SetShouldKeepBuffsUpParty,
			OneHitWonder_ShouldKeepBuffsUpParty
		);
		Cosmos_RegisterConfiguration(
			"COS_ONEHITWONDER_NO_BUFF_WHILE_FISHING",
			"CHECKBOX",
			TEXT(ONEHITWONDER_NO_BUFF_WHILE_FISHING),
			TEXT(ONEHITWONDER_NO_BUFF_WHILE_FISHING_INFO),
			OneHitWonder_SetNoBuffWhileFishing,
			OneHitWonder_NoBuffWhileFishing
		);
		OneHitWonder_SetupByClass();
		
	end
end

function OneHitWonder_TargetIsRunningAway()
	local class = OneHitWonder_GetPlayerClass();
	if ( class ) then
		local func = getglobal(string.format("OneHitWonder_TargetIsRunningAway_%s", class));
		if ( func ) then
			func();
		end
	end
end

OneHitWonder_PartyUnits = {
		[1] = "party1",
		[2] = "party2",
		[3] = "party3",
		[4] = "party4",
};


function OneHitWonder_OnEvent(event)
	
	-- YZ: we use 'delayed' set options
	OneHitWonder_DoSetOptions();
	
	local class = OneHitWonder_GetPlayerClass();
	if ( class ) then
		local func = getglobal(string.format("OneHitWonder_OnEvent_%s", class));
		if ( func ) then
			func(event);
		end
	end
	if ( event == "CHAT_MSG_MONSTER_EMOTE" ) then
		for creatureName in string.gfind(arg1, ONEHITWONDER_CHAT_UNIT_STARTS_TO_FLEE) do
			if ( creatureName ) and ( UnitName("target") == creatureName ) then
				OneHitWonder_UnitWillRunAway("target");
				OneHitWonder_TargetIsRunningAway();
			end
		end
	end
	if ( event == "CHARACTER_POINTS_CHANGED" ) or ( event == "VARIABLES_LOADED" ) then
		local class = OneHitWonder_GetPlayerClass();
		if ( class ) then
			local func = getglobal(string.format("OneHitWonder_TalentPointsUpdated_%s", class));
			if ( func ) then
				func();
			end
		end
	end
	if ( event == "VARIABLES_LOADED" ) then
		OneHitWonder_Init();
		if ( not OneHitWonder_CreatureInfoTable ) then
			OneHitWonder_CreatureInfoTable = {};
		end
		if ( OneHitWonder_AbilityImmunityTable ) then
			for k, v in OneHitWonder_AbilityImmunityTable do
				if ( not OneHitWonder_CreatureInfoTable[k] ) then
					OneHitWonder_CreatureInfoTable[k] = v;
				end
			end
			OneHitWonder_AbilityImmunityTable = nil;
		end
		OneHitWonder_ShowQueue();
		return;
	end
	if ( ( event == "LEARNED_SPELL_IN_TAB" ) or ( event == "SPELLS_CHANGED" ) ) then
		OneHitWonder_UpdateSpellInfo();
		OneHitWonder_SetupStuffContinuously();
	end
	if ( event == "ACTIONBAR_SLOT_CHANGED" ) then
		OneHitWonder_UpdateActionIdInfo(arg1);
		return;
	end
	if ( event == "PLAYER_TARGET_CHANGED" ) then
		OneHitWonder_Target_Changed();
		return;
	end
	if ( event == "UNIT_HEALTH" ) then
		local curTime = GetTime();
		local unit = arg1;
		if ( not unit ) then
			unit = "GENERIC";
		end
		local oldTime = OneHitWonder_UnitHealthLastCalled[unit];
		if ( ( not oldTime ) or 
		( ( curTime - oldTime ) > ONEHITWONDER_HEALTH_UPDATE_DELAY ) ) then
			OneHitWonder_UnitHealthCheck(unit);
			OneHitWonder_UnitHealthLastCalled[unit] = curTime;
		end
		return;
	end
	-- effects
	if ( event == "PARTY_MEMBER_ENABLE" or event == "PARTY_MEMBER_DISABLE" ) then
		local unit = arg1;
		if ( strfind(unit, "party") ) then
			OneHitWonder_CurrentAuras[unit] = {};
			if ( UnitExists(unit) ) then
				--OneHitWonder_CheckEffect(unit);
			end
		end
		OneHitWonder_SetupStuffContinuously();
		return;
	end
	if ( event == "PARTY_MEMBERS_CHANGED" ) then
		local unit = "party";
		for i = 1, 4 do
			unit = OneHitWonder_PartyUnits[i];
			OneHitWonder_CurrentAuras[unit] = {};
			if ( UnitExists(unit) ) then
				--OneHitWonder_CheckEffect(unit);
			end
		end
		OneHitWonder_SetupStuffContinuously();
		return;
	end
	if ( event == "PLAYER_PET_CHANGED" ) then
		local unit = "pet";
		OneHitWonder_CurrentAuras[unit] = {};
		if ( UnitExists(unit) ) then
			--OneHitWonder_CheckEffect(unit);
		end
	end	
	-- chat
	
	if ( strfind(event, "CHAT_MSG") ) then
		OneHitWonder_Chat_OnEvent(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
	end

	if ( event == "PET_ATTACK_START" ) then
		OneHitWonder_PetIsAttacking = true;
	end
	
	if ( event == "PET_ATTACK_STOP" or event == "PET_BAR_HIDEGRID" or event == "PET_BAR_SHOWGRID" ) then
		OneHitWonder_PetIsAttacking = false;
	end

	--[[		
	if (strfind(event, "SPELLCAST_START")) then
		OneHitWonder_TimeSpellStarted = GetTime();
		OneHitWonder_Print("OneHitWonder_TimeSpellStarted="..OneHitWonder_TimeSpellStarted);
	end
	]]--
	
	if (event == "PLAYER_DEAD") then
		OneHitWonder_Warlock_SpellEnded();
		OneHitWonder_ChannelSpellRunning = false;
		OneHitWonder_ChannelSpellRunningStarted = 0;
		OneHitWonder_RegularSpellRunning = false;
		OneHitWonder_TimeSpellStopped = GetTime();
	end

	if (event == "SPELLCAST_STOP") then
		local class = OneHitWonder_GetPlayerClass();
		if ( class ) then
			local func = getglobal(string.format("OneHitWonder_%s_SpellEnded", class));
			if ( func ) then
				func();
			end
		end	
		OneHitWonder_ChannelSpellRunning = false;
		OneHitWonder_ChannelSpellRunningStarted = 0;
		OneHitWonder_RegularSpellRunning = false;
		OneHitWonder_RegularSpellRunningStarted = 0;
		OneHitWonder_TimeSpellStopped = GetTime();	
	end
	if (event == "SPELLCAST_START") then
		OneHitWonder_RegularSpellRunning = true;	
		OneHitWonder_RegularSpellRunningStarted = GetTime();
	end
	if (event == "SPELLCAST_CHANNEL_START") then
		OneHitWonder_ChannelSpellRunning = true;
		OneHitWonder_ChannelSpellRunningStarted = GetTime();
	end
	if (event == "SPELLCAST_INTERRUPTED" or event == "SPELLCAST_FAILED") then
		OneHitWonder_Warlock_SpellEnded();
		OneHitWonder_RegularSpellRunning = false;
		OneHitWonder_RegularSpellRunningStarted = 0;
		OneHitWonder_ChannelSpellRunning = false;	
		OneHitWonder_ChannelSpellRunningStarted = 0;
	end	
	if ( event == "UNIT_AURA" ) then
		local unit = arg1;
		if ( unit ) then
			OneHitWonder_CurrentAuras[unit] = {};
			if ( UnitExists(unit) ) then
				--OneHitWonder_CheckEffect(unit);
			end
		else
			--OneHitWonder_CheckEveryoneEffects();
		end
		return;
	end
end

function OneHitWonder_GetItemInfo(itemName)
	return OneHitWonder_Items[itemName];
end

function OneHitWonder_Bag_Update(bag, scanType)
	if ( scanType ) then
		if ( ( scanType and DYNAMICDATA_ITEM_SCAN_TYPE_ITEMINFO ) == 0 ) then
			return;
		end
	end
	if ( OneHitWonder_GetPlayerClass() == ONEHITWONDER_CLASS_WARLOCK ) then
		OneHitWonder_Warlock_CountShards();
	end
end

-- should translate external names to internal OHW names
function OneHitWonder_TranslatePlayerRace(class)
	local translated = OneHitWonder_Translations_Race[class];
	if ( translated ) then
		return translated;
	end
	return class;
end

-- should translate external names to internal OHW names
function OneHitWonder_TranslatePlayerClass(class)
	local translated = OneHitWonder_Translations_Class[class];
	if ( translated ) then
		return translated;
	end
	return class;
end

function OneHitWonder_GetUnitClass(unit)
	local tmpClass = nil;
	tmpClass = UnitClass(unit);
	if ( tmpClass ) then
		local tmp = strlower(OneHitWonder_PlayerClass);
		local unitName = UnitName(unit);
		if ( unitName == TEXT(UKNOWNBEING) ) or ( unitName == TEXT(UNKNOWNOBJECT) ) then
			tmp = tmpClass;
			return tmp;
		elseif ( ( tmp ) and ( strlen(tmp) > 0 ) ) then
			tmpClass = OneHitWonder_TranslatePlayerClass(tmpClass);
		end
	end
	return tmpClass;
end

function OneHitWonder_GetPlayerClass()
	if ( not OneHitWonder_PlayerClass ) then
		OneHitWonder_PlayerClass = UnitClass("player");
		if ( OneHitWonder_PlayerClass ) then
			local tmp = strlower(OneHitWonder_PlayerClass);
			local unitName = UnitName("player");
			if ( unitName == TEXT(UKNOWNBEING) ) or ( unitName == TEXT(UNKNOWNOBJECT) ) then
				tmp = OneHitWonder_PlayerClass;
				OneHitWonder_PlayerClass = nil;
				return tmp;
			elseif ( ( tmp ) and ( strlen(tmp) > 0 ) ) then
				OneHitWonder_PlayerClass = OneHitWonder_TranslatePlayerClass(OneHitWonder_PlayerClass);
			end
		end
	end
	return OneHitWonder_PlayerClass;
end

function OneHitWonder_GetPlayerRace()
	if ( not OneHitWonder_PlayerRace ) then
		OneHitWonder_PlayerRace = UnitRace("player");
		if ( OneHitWonder_PlayerRace ) then
			local tmp = strlower(OneHitWonder_PlayerRace);
			local unitName = UnitName("player");
			if ( unitName == TEXT(UKNOWNBEING) ) or ( unitName == TEXT(UNKNOWNOBJECT) ) then
				tmp = OneHitWonder_PlayerRace;
				OneHitWonder_PlayerRace = nil;
				return tmp;
			elseif ( ( tmp ) and ( strlen(tmp) > 0 ) ) then
				OneHitWonder_PlayerRace = OneHitWonder_TranslatePlayerRace(OneHitWonder_PlayerRace);
			end
		end
	end
	return OneHitWonder_PlayerRace;
end

function OneHitWonder_UnitHealthCheck(unit)
	local class = OneHitWonder_GetPlayerClass();
	local func = getglobal(format("OneHitWonder_UnitHealthCheck_%s", OneHitWonder_GetPlayerClass()));
	if ( func ) then
		func(unit);
	end
end

function OneHitWonder_UpdateRageConsumptionWithTalents(costTableName, reducerTable)
	local costTable = getglobal(costTableName);
	if ( not costTable ) or ( not reducerTable ) then
		return false;
	end
	local name, iconTexture, tier, column, rank, maxRank, isExceptional, meetsPrereq;
	local talentTable;
	local abilityName;
	local newCostTable;
	for k, v in reducerTable do
		talentTable = v[1];
		abilityName = v[2];
		newCostTable = v[3];
		name, iconTexture, tier, column, rank, maxRank = GetTalentInfo(talentTable[1], talentTable[2]);
		if ( ( rank > 0 ) and ( rank <= getn(newCostTable) ) ) then
			costTable[abilityName] = newCostTable[rank];
		end
	end
	return true;
end

--OneHitWonder_Debug = true;

function OneHitWonder_DebugPrint(msg)
	if ( OneHitWonder_Debug ) then
		OneHitWonder_Print(msg, 1.0, 0.3, 0.3);
	end
end

function _print(msg,r,g,b,frame,id,unknown4th)
    OneHitWonder_Print(msg,r,g,b,frame,id,unknown4th)
end

-- Prints out text to a chat box.
function OneHitWonder_Print(msg,r,g,b,frame,id,unknown4th)
	if(unknown4th) then
		local temp = id;
		id = unknown4th;
		unknown4th = id;
	end
				
	if (not r) then r = 1.0; end
	if (not g) then g = 1.0; end
	if (not b) then b = 1.0; end
	if ( frame ) then 
		frame:AddMessage(msg,r,g,b,id,unknown4th);
	else
		if ( DEFAULT_CHAT_FRAME ) then 
			DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b,id,unknown4th);
		end
	end
end


function OneHitWonder_GetTimeLeft(buffTexture)
	local timeLeft, texture;
	local buffIndex, untilCancelled;
	for i = 0, MAX_PARTY_TOOLTIP_BUFFS do
		buffIndex, untilCancelled = GetPlayerBuff(i, "HELPFUL|PASSIVE");
		if ( buffIndex < 0 ) then
			return 0;
		end
		texture = GetPlayerBuffTexture(buffIndex);
		if ( texture == buffTexture ) then
			timeLeft = GetPlayerBuffTimeLeft(buffIndex);
			return timeLeft;
		end
	end
	return 0;
end

function OneHitWonder_ShouldCast(buffTexture, minimalTimeLeft)
	if ( not minimalTimeLeft ) then
		minimalTimeLeft = 0;
	end
	local timeLeft = OneHitWonder_GetTimeLeft(buffTexture);
	if ( minimalTimeLeft > 0 ) then
		timeLeft = GetPlayerBuffTimeLeft(buffIndex);
		if ( timeLeft < minimalTimeLeft ) then
			return true;
		else
			return false;
		end
	else
		return false;
	end
	return true;
end

OneHitWonder_NextGiveMeWonder = 0;

function OneHitWonder_GiveMeWonder(removeDefense)
	if ( not OneHitWonder_IsEnabled() ) then return false; end
	if ( not OneHitWonder_CanCastSpells() ) then
		return false;
	end
	if ( OneHitWonder_NextGiveMeWonder > 0 ) and ( GetTime() < OneHitWonder_NextGiveMeWonder ) then return; else OneHitWonder_NextGiveMeWonder = 0; end
	local class = OneHitWonder_GetPlayerClass();
	if ( class == ONEHITWONDER_CLASS_DRUID ) then
		OneHitWonder_Druid(removeDefense);
	elseif ( class == ONEHITWONDER_CLASS_HUNTER ) then
		OneHitWonder_Hunter(removeDefense);
	elseif ( class == ONEHITWONDER_CLASS_MAGE ) then
		OneHitWonder_Mage(removeDefense);
	elseif ( class == ONEHITWONDER_CLASS_PALADIN ) then
		OneHitWonder_Paladin(removeDefense);
	elseif ( class == ONEHITWONDER_CLASS_PRIEST ) then
		OneHitWonder_Priest(removeDefense);
	elseif ( class == ONEHITWONDER_CLASS_ROGUE ) then
		OneHitWonder_Rogue(removeDefense);
	elseif ( class == ONEHITWONDER_CLASS_SHAMAN ) then
		OneHitWonder_Shaman(removeDefense);
	elseif ( class == ONEHITWONDER_CLASS_WARLOCK ) then
		OneHitWonder_Warlock(removeDefense);
	elseif ( class == ONEHITWONDER_CLASS_WARRIOR ) then
		OneHitWonder_Warrior(removeDefense);
	else
		if ( not OneHitWonder_UseCountermeasures() ) then
			OneHitWonder_DoBuffs();
		end
		if ( not OneHitWonder_NoWonder ) then
			OneHitWonder_Print("Sorry, no wonder for you yet.");
			OneHitWonder_NoWonder = true;
		end
	end
end

OneHitWonder_ActionIdInfo = {};

OneHitWonder_SpellIdInfo = {};

function OneHitWonder_GetNumberOfSpellsInSpellBook(spellBook)
	local name, rankName;
	local i = 1;
	name, rankName = GetSpellName(i, spellBook)
	while ( name ) do
		i = i + 1;
		name, rankName = GetSpellName(i, spellBook)
	end
	return i - 1;
end

function OneHitWonder_UpdateSpellBookInfo(spellBook)
	local ok = true;
	local index = 1;
	OneHitWonder_SpellIdInfo[spellBook] = {};
	local strings = {};

	local numberOfSpells = OneHitWonder_GetNumberOfSpellsInSpellBook(spellBook);
	
	for index = 1, numberOfSpells do
		OneHitWonder_SpellIdInfo[spellBook][index] = OneHitWonder_GetSpellIdInfo(index, spellBook);
	end
end

function OneHitWonder_UpdateSpellInfo()
	OneHitWonder_UpdateSpellBookInfo("spell");
	OneHitWonder_UpdateSpellBookInfo("pet");
end



function OneHitWonder_RetrieveAllActionIdInfo()
	local strings = nil;
	for i = 1, ONEHITWONDER_MAXIMUM_NUMBER_OF_ACTION_IDS do
		OneHitWonder_ActionIdInfo[i] = OneHitWonder_GetActionIdInfo(i);
	end
end

function OneHitWonder_UpdateActionIdInfo(id)
	if ( id <= 0 ) then
		OneHitWonder_RetrieveAllActionIdInfo();
	else
		OneHitWonder_ActionIdInfo[id] = OneHitWonder_GetActionIdInfo(id);
	end
end

function OneHitWonder_GetActionIdFromSpellId(spellId, spellBook, doNotUseCache)
	if ( ( not spellId ) or ( spellId == -1 ) ) then return -1; end
	local name, rank = GetSpellName(spellId, OneHitWonder_GetSpellBook(spellBook));
	if ( not name ) then
		return -1;
	end
	if ( DynamicData.action.getSpellAsActionId ) then
		local actionId = DynamicData.action.getSpellAsActionId(name, rank);
		if ( not actionId ) then
			return -1;
		else
			return actionId;
		end
	end
	
	local strings = nil;
	for i = 1, ONEHITWONDER_MAXIMUM_NUMBER_OF_ACTION_IDS do
		if ( doNotUseCache ) then
			strings = OneHitWonder_GetActionIdInfo(i);
		else
			strings = OneHitWonder_ActionIdInfo[i];
		end
		if ( ( strings ) and ( (getn(strings) >= 1) and ( name == strings[1].left ) ) 
			and ( ( not rank ) or ( (getn(strings) >= 2) and ( rank == strings[2].left ) ) ) ) then
			return i;
		end
	end
	return -1;
end

OneHitWonder_Sequences = {};

function OneHitWonder_AddContinuousSequence(sequenceName)
	table.insert(OneHitWonder_Sequences, sequenceName);
end

function OneHitWonder_AddStuffContinuously(pBuffName, pOnlySelf, pIsBuff, options)
	local element = {};
	if ( not pOnlySelf ) then
		pOnlySelf = false;
	elseif ( pOnlySelf == 1 ) then
		pOnlySelf = true;
	elseif ( pOnlySelf == "yes" ) then
		pOnlySelf = true;
	elseif ( pOnlySelf == "no" ) then
		pOnlySelf = false;
	end
	element.buffName = pBuffName;
	element.onlySelf = pOnlySelf;
	element.isBuff = pIsBuff;
	if ( options ) then
		for k, v in options do
			element[k] = v;
		end
	end
	tinsert(OneHitWonder_BuffsToKeepUp, element);
end

function OneHitWonder_GetHighestBuffName(buffNames, doNotUseCache)
	local highestBuffName = nil;
	local buffId = nil;
	for k, v in buffNames do
		buffId = OneHitWonder_GetSpellId(v, nil, nil, doNotUseCache);
		if ( buffId > -1 ) then
			highestBuffName = v;
		end
	end
	return highestBuffName;
end

OneHitWonder_ManaClassesArray = {
	ONEHITWONDER_CLASS_HUNTER, ONEHITWONDER_CLASS_MAGE, ONEHITWONDER_CLASS_WARLOCK, 
	ONEHITWONDER_CLASS_PALADIN, ONEHITWONDER_CLASS_PRIEST, ONEHITWONDER_CLASS_SHAMAN 
};

OneHitWonder_HealerClassesArray = {
	ONEHITWONDER_CLASS_DRUID,
	ONEHITWONDER_CLASS_PALADIN, 
	ONEHITWONDER_CLASS_PRIEST, 
	ONEHITWONDER_CLASS_SHAMAN
};

OneHitWonder_MeleeClassesArray = {
	ONEHITWONDER_CLASS_PALADIN, 
	ONEHITWONDER_CLASS_ROGUE,
	ONEHITWONDER_CLASS_WARRIOR
};

OneHitWonder_RangedClassesArray = {
	ONEHITWONDER_CLASS_HUNTER 
};

OneHitWonder_CasterClassesArray = {
	ONEHITWONDER_CLASS_HUNTER, ONEHITWONDER_CLASS_MAGE, 
	ONEHITWONDER_CLASS_WARLOCK, ONEHITWONDER_CLASS_PRIEST, 
	ONEHITWONDER_CLASS_SHAMAN
};
OneHitWonder_FighterClassesArray =  {
	ONEHITWONDER_CLASS_WARRIOR, ONEHITWONDER_CLASS_ROGUE, 
	ONEHITWONDER_CLASS_PALADIN
};

ONEHITWONDER_POWERTYPE_MANA = 0;
ONEHITWONDER_POWERTYPE_RAGE = 1;
ONEHITWONDER_POWERTYPE_FOCUS = 2;
ONEHITWONDER_POWERTYPE_ENERGY = 3;
ONEHITWONDER_POWERTYPE_HAPPINESS = 4;

-- will be called when the spells of player or group changes
function OneHitWonder_SetupStuffContinuously()
	--_print("OneHitWonder_SetupStuffContinuously")
	
	local setup = false;
	OneHitWonder_BuffsToKeepUp = {};
	OneHitWonder_Sequences = {};
	local currentClass = OneHitWonder_GetPlayerClass();
	local shouldKeepUpBuffs = ( OneHitWonder_ShouldKeepBuffsUp or OneHitWonder_ShouldKeepBuffsUpParty );
	if ( shouldKeepUpBuffs == 1 ) and ( currentClass ) then
		local func = getglobal(format("OneHitWonder_SetupStuffContinuously_%s", currentClass));
		if ( func ) then
			func();
			setup = true;
		end
		func = getglobal(format("OneHitWonder_SetupSequenceContinuously_%s", currentClass));
		if ( func ) then
			func();
			setup = true;
		end
	end
	if ( ( setup ) and ( not OneHitWonder_ContBuffSetup) ) then
		OneHitWonder_ContBuffSetup = true;
		--OneHitWonder_Print("Continuous Buffs setup for "..currentClass, 1.0, 1.0, 0);
	end
end

function OneHitWonder_IsItOkayToCastSpell(buffData)
	local hasTarget = OneHitWonder_HasTarget();
	local isDead = OneHitWonder_IsPlayerDead();
	local isOnTaxi = UnitOnTaxi("player");
	
	local isOkay = false;

	local buffId = -1;
	if ( type(buffData.buffName) == "table") then
		for k, v in buffData.buffName do
			buffId = OneHitWonder_GetSpellId(v);
			if ( buffId > -1 ) then
				break;
			end
		end
	else
		buffId = OneHitWonder_GetSpellId(buffData.buffName);
	end
	if ( buffId <= -1 ) then
		return false;
	end
	local actionId = OneHitWonder_GetActionIdFromSpellId(buffId);
	
	--Print(format("%s %d %d", buffData.buffName, buffId, actionId));

	
	local timeSinceLastBuff = GetTime() - OneHitWonder_LastBuffed;

	if ( ( not isDead) and ( not isOnTaxi ) and (
		( ( buffData.onlySelf) or ( not hasTarget ) or ( actionId > -1 ) ) or 
			( 
				( buffData.needsTarget ) and ( ( hasTarget ) or ( actionId > -1 ) ) and 
				( ( not buffData.needsHostileTarget ) or ( UnitCanAttack("player", "target") ) ) 
			) 
		) 
		and (
		( (timeSinceLastBuff <= ONEHITWONDER_MAXIMUM_TIME_SINCE_LAST_BUFF) ) 
		and ( ( buffData.notBuff ) or ( not OneHitWonder_HasPlayerEffect(nil, buffData.buffName) ) )
		)
		) then
		isOkay = true;
	end
	return isOkay;
end

function OneHitWonder_HasAnActiveWhatever(subName, shouldLowerCaseIt)
	local hasActive = false;
	local whateverName, whateverNameLower;
	local texture, name, isActive, isCastable;
	local numForms = GetNumShapeshiftForms();
	for i = 1, numForms do
		texture, whateverName, isActive, isCastable = GetShapeshiftFormInfo(i);
		if ( whateverName ) then
			if ( isActive == 1 ) or ( isActive == true ) then
				if ( shouldLowerCaseIt ) then
					whateverName = strlower(whateverName);
				end
				if ( strfind(whateverName, subName) ) then
					hasActive = true;
					break;
				end
			end
		end
	end
	return hasActive;
end

function OneHitWonder_IsPlayerDead()
	local isDead = OneHitWonder_HasPlayerEffect(nil, ONEHITWONDER_BUFF_GHOST);
	if ( ( not isDead ) and ( UnitIsDead("player") ) ) then
		isDead = true;
	end
	return isDead;
end

function OneHitWonder_IsPlayerOnTaxi()
	return UnitOnTaxi("player");
end

function OneHitWonder_GenerateMountList()
	local list = {};
	for k, mountColor in OneHitWonder_MountColorNames do
		for key, mountType in OneHitWonder_MountTypeNames do
			table.insert(list, string.format("%s %s", mountColor, mountType));
			if ( GetLocale() == "deDE" ) then
			elseif ( GetLocale() == "frFR" ) then
			end
		end
	end
	for k, v in OneHitWonder_SpecialMountNames do
		table.insert(list, v);
	end
	return list;
end

function OneHitWonder_GetMountList()
	if ( not OneHitWonder_MountNames ) then
		OneHitWonder_MountNames = OneHitWonder_GenerateMountList();
	end
	return OneHitWonder_MountNames;
end

function OneHitWonder_IsPlayerOnMount()
	--return OneHitWonder_HasPlayerEffect(OneHitWonder_MountEffectTextures, OneHitWonder_GetMountList());
	return OneHitWonder_HasPlayerEffect(nil, OneHitWonder_GetMountList());
end

OneHitWonder_DoBuffsList = {"target", "player", "party1", "party2", "party3", "party4", "pet"};
function OneHitWonder_DoBuffs(destroyTarget, specialOptions, buffList)
--	_print("OneHitWonder_DoBuffs")
	
	if ( not DynamicData.util.safeToUseTooltips() ) then
		return false;
	end
	
	if ( OneHitWonder_ShouldOnlyBuffInFightIfNotRegenerating == 1 ) then
		if ( ( PlayerFrame.inCombat == 1 ) and ( ( not specialOptions ) or ( not specialOptions.ignoreCombat ) ) ) then
			if ( PlayerFrame.onHateList == 1 ) then
				return false;
			end
		end
	end
	if ( not specialOptions ) then
		specialOptions = {};
	end
	if ( not OneHitWonder_ShouldTryToCastABuff(specialOptions.ignoreCloakEffects) ) then
		return false;
	end
	local ok = true;
	local tempList = nil;
	if ( buffList ) then
		tempList = buffList;
	else
		tempList = OneHitWonder_DoBuffsList;
	end
	for k, v in tempList do
		ok = false;
		if ( ( UnitExists(v) ) and 
			( ( v ~= "target" ) or ( UnitCanCooperate("player", v) ) ) 
			and ( not UnitIsDead(v) ) and ( not UnitIsGhost(v) ) ) then
			ok = true;
			if ( strfind(v, "party") ) then
				local i = strsub(v, 6, 1);
				if ( i ) then
					i = tonumber(i);
				end
				if ( i ) then
					if ( GetPartyMember(i) ) then
						ok = true;
					else
						ok = false;
					end
				end
			end
			if ( ok ) then 
				if ( OneHitWonder_BuffUnit(v, destroyTarget, specialOptions) ) then
					return true;
				end
			end
		end
	end
	return false;
end

function OneHitWonder_IsStringInList(param1, param2)
	if ( not param1 ) or ( not param2 ) then
		return false;
	end
	local str = param1;
	local list = param2;
	if ( type(param1) == "table" ) then
		str = param2;
		list = param1;
	end
	for k, v in list do
		if ( v == str ) then
			return true;
		end
	end
	return false;
end

OneHitWonder_AllBuffReason = {};
OneHitWonder_BuffReason = {};

OneHitWonder_BuffReasonData = {};


OneHitWonder_BuffDebug = 0;

function OneHitWonder_ArchiveBuffReason()
	if ( OneHitWonder_BuffDebug ~= 1 ) then
		return;
	end
	if ( table.getn(OneHitWonder_BuffReason) <= 0 ) then
		return;
	end
	local newElement = {};
	for i = 1, table.getn(OneHitWonder_BuffReason), 1 do
		newElement[i] = OneHitWonder_BuffReason[i];
	end
	local newBuffReason = { name = OneHitWonder_BuffReasonData[1], unit = OneHitWonder_BuffReasonData[3], reasons = newElement };
	table.insert(OneHitWonder_AllBuffReason, newBuffReason);
	OneHitWonder_BuffReason = {};
end

function OneHitWonder_AddBuffReason(reason)
	--_print(reason)
	if ( OneHitWonder_BuffDebug ~= 1 ) then
		return;
	end
	local str = reason;
	local castBuffName, buffData, unit, destroyTarget, specialOptions;
	castBuffName = OneHitWonder_BuffReasonData[1];
	buffData = OneHitWonder_BuffReasonData[2];
	unit = OneHitWonder_BuffReasonData[3]; 
	destroyTarget = OneHitWonder_BuffReasonData[4];
	specialOptions = OneHitWonder_BuffReasonData[5];
	str = string.gsub(str, "buff", castBuffName);
	str = string.gsub(str, "buffName", castBuffName);
	str = string.gsub(str, "buffname", castBuffName);
	str = string.gsub(str, "unit", unit);
	str = string.gsub(str, "unitName", UnitName(unit));
	str = string.gsub(str, "unitname", UnitName(unit));
	--str = string.gsub(str, "unitclass", UnitClass(unit));
	table.insert(OneHitWonder_BuffReason, str);
end


function OneHitWonder_CastBuff(castBuffName, v, unit, destroyTarget, specialOptions)
--	_print("OneHitWonder_CastBuff")
	if ( not UnitExists(unit) ) then
		return false, false;
	end
	local buffId = OneHitWonder_GetSpellId(castBuffName);
	local buffName, buffRank = OneHitWonder_GetBuffName(UnitLevel(unit), castBuffName);
	buffId = OneHitWonder_GetSpellId(buffName, buffRank);
	if ( not OneHitWonder_IsSpellAvailable(buffId) ) then
		return false, false;
	end
	if ( not v ) then
		v = {};
	end
	if ( not OneHitWonder_ShouldTryToCastABuff(v.ignoreCloakEffects) ) then
		return false, false;
	end
	--OneHitWonder_BuffReason = {};
	local hasTarget = OneHitWonder_HasTarget();
	if ( not specialOptions ) then
		specialOptions = {};
	end
	--OneHitWonder_BuffReasonData[1] = castBuffName;
	--OneHitWonder_BuffReasonData[2] = v;
	--OneHitWonder_BuffReasonData[3] = unit;
	--OneHitWonder_BuffReasonData[4] = destroyTarget;
	--OneHitWonder_BuffReasonData[5] = specialOptions;
	local ok = true;
	local effectName = castBuffName;

	local curTime = GetTime();
	if ( v ) and ( v.effectName ) then
		effectName = v.effectName;
	end
	if ( UnitIsDead(unit) ) then
		return false, false;
		--ok = false;
		--OneHitWonder_AddBuffReason("Did not use buff because unit was dead");
	end
	if ( UnitCanAttack(unit, "player") ) then
		return false, false;
		--ok = false;
		--OneHitWonder_AddBuffReason("Did not use buff because we can attack unit");
	end
	if ( OneHitWonder_IsUnitOffline(unit) ) then
		return false, false;
		--ok = false;
		--OneHitWonder_AddBuffReason("Did not use buff because unit was offline");
	end
	if ( not OneHitWonder_IsUnitInRange(unit) ) then
		return false, false;
		--ok = false;
		--OneHitWonder_AddBuffReason("Did not use buff because unit was out of range");
	end
	if ( ok ) then
		if ( v ) then
			if ( ( v.onlySelf ) and ( unit ~= "player" ) ) then
				ok = false;
				OneHitWonder_AddBuffReason("buff was self only - target was unit");
			end
			if ( ok ) and ( v.isBuff ) then
				local effectInfo = OneHitWonder_GetUnitEffect(unit, nil, effectName);
				
				if ( effectInfo ) then
					local shouldRecast = false;
					local buffLasts = OneHitWonder_BuffTime[castBuffName];
					if ( buffLasts ) then
						local buffRecastMaxTime = math.floor(buffLasts / 10);
						if ( buffRecastMaxTime > 15 ) then
							buffRecastMaxTime = 15;
						else
							buffRecastMaxTime = buffLasts;
						end
						if ( effectInfo.expires > 0 ) and ( effectInfo.expires-curTime <= buffRecastMaxTime ) then
							shouldRecast = true;
						end
					end

					if ( not shouldRecast ) then
						ok = false;
						OneHitWonder_AddBuffReason("buff was already present");
					end
				end
			end
			if ( ok ) and ( ( v.onlySelf ) and ( unit ~= "player" ) ) then
				ok = false;
				OneHitWonder_AddBuffReason("buff was self only - target was unit");
			end
			if ( ok ) and ( ( v.doNotBuffClass ) and ( not specialOptions.overrideClass ) ) then
				local class = UnitClass(unit);
				if ( OneHitWonder_IsStringInList(class, v.doNotBuffClass) ) then
					ok = false;
					OneHitWonder_AddBuffReason("Did not use buff because unit was not of the right class (doNotBuffClass)");
				end
			end
			if ( ok ) and ( ( v.onlyBuffClass ) and ( not specialOptions.overrideClass ) ) then
				local class = UnitClass(unit);
				if ( not OneHitWonder_IsStringInList(class, v.onlyBuffClass) ) then
					ok = false;
					OneHitWonder_AddBuffReason("Did not use buff because unit was not of the right class (onlyBuffClass)");
				end
			end
			if ( ok ) and ( ( v.notInCombat == true ) and ( not specialOptions.ignoreInCombat ) ) then
				if ( PlayerFrame.inCombat == 1 ) then
					ok = false;
					OneHitWonder_AddBuffReason("Did not use buff because we were in combat");
				end
			end
			if ( ok ) and ( ( v.notWhileHated == true ) and ( not specialOptions.ignoreWhileHated ) ) then
				if ( PlayerFrame.onHateList == 1 ) then
					ok = false;
					OneHitWonder_AddBuffReason("Did not use buff because we were on hate list");
				end
			end
			if ( ok ) and ( ( v.onlyWhileHated == true ) and ( not specialOptions.ignoreWhileHated ) ) then
				if ( PlayerFrame.onHateList ~= 1 ) then
					ok = false;
					OneHitWonder_AddBuffReason("Did not use buff because we were on hate list");
				end
			end
			if ( ok ) and ( ( v.requiresCombat == true ) and ( not specialOptions.ignoreRequiresCombat ) ) then
				if ( not PlayerFrame.inCombat ) then
					ok = false;
					OneHitWonder_AddBuffReason("Did not use buff because we were not in combat");
				end
			end
			if ( ok ) and ( ( v.validTarget ) and ( not specialOptions.ignoreValidTarget ) ) then
				if ( not OneHitWonder_IsStringInList(unit, v.validTarget) ) then
					ok = false;
					OneHitWonder_AddBuffReason("Did not use buff because unit wasn't part of the valid target list");
				end
			end
			if ( ok ) and ( ( not specialOptions.ignoreMana ) and ( not v.useAtAnyMana ) and ( ( v.useWhenHigherManaPercentage ) or ( v.useWhenLowerManaPercentage) ) ) then
				local manaPercentage = OneHitWonder_GetPlayerManaPercentage();
				if ( ( v.useWhenHigherManaPercentage ) and ( manaPercentage < v.useWhenHigherManaPercentage ) ) then
					ok = false;
					OneHitWonder_AddBuffReason(format("Did not use buff because our mana (%d) was not high enough (%d)", manaPercentage, v.useWhenHigherManaPercentage));
				end	
				if ( ( v.useWhenLowerManaPercentage ) and ( manaPercentage > v.useWhenLowerManaPercentage ) ) then
					ok = false;
					OneHitWonder_AddBuffReason(format("Did not use buff because our mana (%d) was not low enough (%d)", manaPercentage, v.useWhenLowerManaPercentage));
				end	
			end
			if ( ok ) and ( ( not specialOptions.ignoreHealth  ) and ( ( v.useWhenHigherHealthPercentage ) or ( v.useWhenLowerHealthPercentage) ) ) then
				local healthPercentage = OneHitWonder_GetPlayerHPPercentage();
				if ( ( v.useWhenHigherHealthPercentage ) and ( healthPercentage < v.useWhenHigherHealthPercentage ) ) then
					ok = false;
					OneHitWonder_AddBuffReason(format("Did not use buff because our HP (%d) was not low enough (%d)", healthPercentage, v.useWhenHigherHealthPercentage));
				end	
				if ( ( v.useWhenLowerHealthPercentage ) and ( healthPercentage > v.useWhenLowerHealthPercentage ) ) then
					ok = false;
					OneHitWonder_AddBuffReason(format("Did not use buff because our HP (%d) was not low enough (%d)", healthPercentage, v.useWhenLowerHealthPercentage));
				end	
			end
			if ( ok ) and ( ( v.invalidTarget ) and ( not specialOptions.ignoreInvalidTarget ) ) then
				if ( OneHitWonder_IsStringInList(unit, v.invalidTarget) ) then
					ok = false;
					OneHitWonder_AddBuffReason("Did not use buff because unit was an invalid target");
				end
			end
			if ( ok ) and ( ( v.powerType ) and ( not specialOptions.ignorePowerType ) ) then
				if ( not OneHitWonder_IsStringInList(UnitPowerType(unit), v.powerType) ) then
					ok = false;
					OneHitWonder_AddBuffReason("Did not use buff because our power type was not valid.");
				end
			end
			if ( ok ) and ( ( v.notPowerType ) and ( not specialOptions.ignoreNotPowerType ) ) then
				if ( OneHitWonder_IsStringInList(UnitPowerType(unit), v.notPowerType) ) then
					ok = false;
					OneHitWonder_AddBuffReason("Did not use buff because our power type was invalid.");
				end
			end
		end
		-- Kinesia. Changed order to enable target changes and restoration to prevent age old buffing of wrong person bug.
		local changedTarget = nil
		local madeTarget = nil
		if ( ok ) then
			local actionId = OneHitWonder_GetActionIdFromSpellId(buffId);
			
			OneHitWonder_InitiateRefreshEffects(unit);
			
			--[[ Kinesia. UseAction doesn't seem to work as well as explicit targetting changes
			if ( unit == "player" ) then
				if ( actionId ) and ( actionId > -1 ) then
					UseAction(actionId, 0, 1);
					return ok, true;
				end
			end]]--
			if ( hasTarget ) and ( unit ~= "target" ) then
				local targetName = UnitName("target");
				local unitName = UnitName(unit);
				if ( targetName ~= unitName ) then 
					TargetUnit(unit);
					changedTarget = 1;
				end
			end
			if (not hasTarget) then 
				TargetUnit(unit);
				madeTarget = 1;
			end
			--OneHitWonder_Print(format("%s should now be used on %s (%s)", buffName, UnitName(unit), unit));
			ok = OneHitWonder_CastSpell(buffId);
			if ( ok ) then
				if( SpellIsTargeting() ) then
					SpellTargetUnit(unit);
				end
				OneHitWonder_LastBuffed = GetTime();
			end
			if (changedTarget) then
				TargetLastTarget()
			end
			if (madeTarget) then
				ClearTarget()
			end
			return ok, true;
		end
	end
	--OneHitWonder_ArchiveBuffReason();
	return false, false;
end

function OneHitWonder_CastSpellOnSelf(spellId)
	-- Added by Kinesia 13/7/2006
	local hasTarget = OneHitWonder_HasTarget();
	local changedTarget = nil
	local madeTarget = nil
	if ( hasTarget ) and not UnitIsUnit("target","player") then
		changedTarget = 1;
	end
	if (not hasTarget) then 
		madeTarget = 1;
	end
	TargetUnit("player")
	ok = OneHitWonder_CastSpell(buffId);
	if ( ok ) then
		if( SpellIsTargeting() ) then
			SpellTargetUnit(unit);
		end
	end
	if (changedTarget) then
		TargetLastTarget()
	end
	if (madeTarget) then
		ClearTarget()
	end
	return ok;
end

function OneHitWonder_GetBuffName(unitLevel, buffName)
	if ( not buffName ) then
		return nil;
	end
	if ( type(buffName) == "table" ) then
		local tmp = nil;
		local index = nil;
		for k, v in pairs(buffName) do
			index = strfind(v, "%(");
			if ( index ) then
				buffName = strsub(v, index-1);
			end
			return OneHitWonder_GetAppropriateBuff(unitLevel, buffName);
		end
		return nil;
	else
		local index = strfind(buffName, "%(");
		if ( index ) then
			buffName = strsub(buffName, index-1);
		end
		return OneHitWonder_GetAppropriateBuff(unitLevel, buffName);
	end
end

OneHitWonder_RecentBuffees = {};

function OneHitWonder_CleanRecentBuffee()
	local curTime = GetTime();
	local removeIndices = {};
	for k, v in OneHitWonder_RecentBuffees do
		if ( v.time < curTime ) then
			table.insert(removeIndices, k);
		end
	end
	for k, v in removeIndices do
		table.remove(OneHitWonder_RecentBuffees, v);
	end
end

function OneHitWonder_GetRecentBuffee(buffeeName)
	OneHitWonder_CleanRecentBuffee();
	for k, v in OneHitWonder_RecentBuffees do
		if ( v.name == buffeeName ) then
			return v;
		end
	end
	return nil;
end

function OneHitWonder_IsRecentBuffee(buffeeName)
	if ( OneHitWonder_GetRecentBuffee(buffeeName) ) then
		return true;
	else
		return false;
	end
end

function OneHitWonder_AddRecentBuffee(buffeeName, extraTime)
	local buffee = OneHitWonder_CleanRecentBuffee();
	local newTime = GetTime() + extraTime;
	if ( not buffee ) then
		table.insert(OneHitWonder_RecentBuffees, { name = buffeeName, time = newTime } );
	else
		buffee.time = newTime;
	end
end

-- TODO: should add the amount of time before reapplying a buff to the same person

OneHitWonder_BuffTime = {
};

function OneHitWonder_GetBuffTime(buffName)
	local value = OneHitWonder_BuffTime[buffName];
	if ( not value ) then value = 30; end
	return value;
end

function OneHitWonder_DebuffUnit(unit)
	if ( OneHitWonder_IsPlayerDead() ) then
		return false;
	end
	if ( OneHitWonder_IsPlayerOnTaxi() ) then
		return false;
	end
	return false;
end

OneHitWonder_UnitStatus = {};

function OneHitWonder_UpdateUnitInfo(unit)
	local data = { };
	local curTime = GetTime();
	data.name = UnitName(unit);
	local addTime = 10;
	if ( unit == "target" ) then
		addTime = 1;
	end
	data.expiryTime = curTime + addTime;

	data.offline = OneHitWonder_IsUnitOffline(unit);

	OneHitWonder_UnitStatus[unit] = data;
end

function OneHitWonder_GetUnitInfo(unit)
	local curTime = GetTime();
	local data = OneHitWonder_UnitStatus[unit];
	if ( data ) and ( data.expiryTime ) and ( data.expiryTime > curTime ) then
		return data;
	else
		OneHitWonder_UpdateUnitInfo(unit);
		return OneHitWonder_UnitStatus[unit];
	end
end

function OneHitWonder_IsUnitOffline(unit)
	if ( not UnitExists(unit) ) then
		return true;
	end
	if ( UnitIsConnected(unit) ) then
		return false;
	else
		return true;
	end
--[[
	local data = OneHitWonder_GetUnitInfo(unit);
	return data.offline;
	DynamicData.util.protectTooltipMoney();
	OneHitWonderTooltip:SetUnit(unit);
	DynamicData.util.unprotectTooltipMoney();
	local strings = OneHitWonder_ScanTooltip("OneHitWonderTooltip");
	if ( strings ) then
		for k, v in strings do
			if ( v.left ) then
				if ( strfind(v.left, TEXT(PLAYER_OFFLINE)) ) then
					return true;
				end
			end
		end
	end
	return false;
]]--
end

function OneHitWonder_ShouldTryToCastABuff(ignoreCloakEffects)
	--_print("OneHitWonder_ShouldTryToCastABuff")
	if ( OneHitWonder_IsPlayerDead() ) then
		return false;
	end
	if ( OneHitWonder_IsPlayerOnTaxi() ) then
		return false;
	end
	if ( OneHitWonder_IsPlayerOnMount() ) then
		return false;
	end
	if ( OneHitWonder_NoBuffWhileFishing == 1 ) then
		local itemInfo = nil;
		if ( DynamicData ) and ( DynamicData.item ) and ( DynamicData.item.getEquippedSlotInfo ) then
			itemInfo = DynamicData.item.getEquippedSlotInfo(16);
		end
		if ( itemInfo ) and ( itemInfo.name ) and ( strlen(itemInfo.name) > 0 )
			and ( ( OneHitWonder_IsStringInList(itemInfo.name, OneHitWonder_FishingItems) ) 
			or ( OneHitWonder_IsStringInListLoose(itemInfo.name, OneHitWonder_FishingItemSubStrings, true) ) )
			then
			return false;
		end
	end
	if ( not ignoreCloakEffects ) then
		if ( OneHitWonder_HasPlayerEffect(nil, ONEHITWONDER_ABILITY_CLOAK_EFFECTS) ) then
			return false;
		end
	end
	local func = getglobal(format("OneHitWonder_ShouldTryToCastABuff_%s", OneHitWonder_GetPlayerClass()));
	if ( func ) then
		return func(ignoreCloakEffects);
	else
		return true;
	end
end


function OneHitWonder_HandleBuffUnit(buffName, v, unit, destroyTarget, specialOptions)
	if ( not UnitExists(unit) ) then
		return false;
	end
	local buffId = OneHitWonder_GetSpellId(buffName);
	
	local buffName, buffRank = OneHitWonder_GetBuffName(UnitLevel(unit), buffName);
	
	buffId = OneHitWonder_GetSpellId(buffName, buffRank);
	
	if ( not OneHitWonder_IsSpellAvailable(buffId) ) then
		return false;
	end
	if ( not v ) then
		v = {};
		v.effectName = buffName;
	end
	local curTime = GetTime();
	if ( not v.onlySelf ) or ( unit == "player" ) then
		if ( type(buffName) == "table" ) then
			local actualBuffs = {};
			for key, value in buffName do
				if ( OneHitWonder_GetSpellId(value) > 0 ) then
					table.insert(actualBuffs, value);
				end
			end
			local mx = OneHitWonder_GetNumberOfClassInParty(OneHitWonder_GetPlayerClass());
			local cur = 1;
			local buffId = -1;
			local hasAnyBuff = false;
			for key, value in actualBuffs do
			    OneHitWonder_Print("v "..value)
				if ( OneHitWonder_HasUnitEffect(unit, nil, value) ) then
					hasAnyBuff = true;
					break;
				end
			end
			local numBuffs = getn(actualBuffs);
			local effectName = nil;
			local tempEffectName = nil;
			for key, value in actualBuffs do
				currentBuffName = value;
				effectName = nil;
				if ( v.effectName ) and ( type(v.effectName) == "table") then
					effectName = v.effectName[key];
				end
				if ( not effectName ) then
					tempEffectName = currentBuffName;
				else
					tempEffectName = effectName;
				end
				buffId = OneHitWonder_GetSpellId(currentBuffName);
				local effectInfo = OneHitWonder_GetUnitEffect(unit, nil, tempEffectName);
				
				if ( ( buffId > -1 ) and 
					( ( not effectInfo ) or 
					( ( effectInfo.expires > 0 ) and ( effectInfo.expires-curTime < 15 ) ) ) ) then
					if (hasAnyBuff) then
						if ( ( v.canOverrideEffect ) and ( numBuffs > 1 ) ) then
							if ( OneHitWonder_IsRecentBuffee(unitName) ) then
								OneHitWonder_Print(format("Has recently buffed %s, won't do it again so soon.", unitName));
								return false;
							end
						else
							return false;
						end
					end
					castBuff, shouldQuit = OneHitWonder_CastBuff(currentBuffName, v, unit, destroyTarget, specialOptions)
					if ( castBuff ) then
						OneHitWonder_AddRecentBuffee(unitName, OneHitWonder_GetBuffTime(currentBuffName));
					end
					if ( shouldQuit ) then
						return castBuff;
					end
					if ( castBuff ) then
						return castBuff;
					end
					cur = cur + 1;
					--[[
					if ( cur > mx) then
						break;
					end
					]]--
				end
			end
		else
			castBuff, shouldQuit = OneHitWonder_CastBuff(v.buffName, v, unit, destroyTarget, specialOptions);
			if ( shouldQuit ) then
				return castBuff;
			end
			if ( castBuff ) then
				return castBuff;
			end
		end
	end
	return false;
end


function OneHitWonder_BuffUnit(unit, destroyTarget, specialOptions)
	if ( not UnitExists(unit) ) then
		return false;
	end
	if ( UnitIsDead(unit) ) then
		return false;
	end
	if ( not specialOptions ) then
		specialOptions = {};
	end
	if ( OneHitWonder_ShouldKeepBuffsUp == 0 ) and ( not specialOptions.ignoreNoBuffing ) then
		return false;
	end
	if ( OneHitWonder_ShouldKeepBuffsUpParty == 0 ) and 
		( strfind(unit, "party") ) and ( ( not specialOptions ) or ( not specialOptions.ignoreNoBuffing ) ) then
		return false;
	end
	if ( getn(OneHitWonder_BuffsToKeepUp) <= 0 ) and ( getn(OneHitWonder_Sequences) <= 0 ) then
		return false;
	end
	if ( not OneHitWonder_ShouldTryToCastABuff(true) ) then
		return false;
	end
	if ( strfind(unit, "party") ) then
		if ( not OneHitWonder_IsUnitInRange(unit) ) then
			--OneHitWonder_Print(format("%s is not in range for buff", unit));
			return false;
		end
	end
	local unitName = UnitName(unit);
	if ( ( not unitName ) or ( strlen(unitName) <= 0 ) ) then
		return false;
	end
	if ( OneHitWonder_IsUnitOffline(unit) ) then
		--OneHitWonder_Print(format("%s is offline", unit));
		return false;
	end
	local ok = true;
	local currentBuffName = nil;
	local castBuff, shouldQuit;
	local curTime = GetTime();
	
	if ( getglobal(format("OneHitWonder_SetupSequenceContinuously_%s", OneHitWonder_GetPlayerClass() ) ) ) then
		local tmpBuff = nil;
		local funcName = string.format("OneHitWonder_GetBuffName_%s", OneHitWonder_GetPlayerClass());
		local func = getglobal(funcName);
		if ( func ) then
			for k, v in OneHitWonder_Sequences do
				tmpBuff = func(v, unit);
				if ( tmpBuff ) then
					if ( OneHitWonder_HandleBuffUnit(tmpBuff, nil, unit, destroyTarget, specialOptions) ) then
						return true;
					end
				end
			end
		end
	end
	
	for k, v in OneHitWonder_BuffsToKeepUp do
	    ok = OneHitWonder_HandleBuffUnit(v.buffName, v, unit, destroyTarget, specialOptions);
		if ( ok ) then
			return true;
		end
	end
	return false;
end


function OneHitWonder_DoStuffContinuouslyBuffOld()
		for k, v in OneHitWonder_BuffsToKeepUp do
			if ( OneHitWonder_IsItOkayToCastSpell(v) ) then
				buffId = OneHitWonder_GetSpellId(v.buffName);
				if ( OneHitWonder_IsSpellAvailable(buffId) ) then
					local castBuff, shouldQuit = OneHitWonder_CastBuff(v.buffName, v, "player");
					if ( castBuff ) then
						OneHitWonder_LastBuffed = GetTime();
					end
					if ( castBuff ) or ( shouldQuit ) then
						return;
					end
					--[[
					local actionId = OneHitWonder_GetActionIdFromSpellId(buffId);
					if ( actionId ) and ( actionId > -1 ) then
						UseAction(actionId, 0, 1);
					else
						OneHitWonder_CastSpell(buffId);
						if( SpellIsTargeting() ) then
							SpellTargetUnit("player");
						end
					end
					OneHitWonder_LastBuffed = GetTime();
					return;
					]]--
				end
			end
		end
end

function OneHitWonder_IsSomeSpellRunning(name, maxTime)
	if ( not maxTime ) then
		maxTime = 15;
	end
	local boolName = format("OneHitWonder_%sSpellRunning", name);
	local startedName = format("OneHitWonder_%sSpellRunningStarted", name);
	local boolValue = getglobal(boolName);
	local startedValue = getglobal(startedName);
	if ( boolValue == true ) then
		local curTime = GetTime();
		if ( ( startedValue + 15 ) < curTime ) then
			boolValue = false;
			setglobal(boolName, false);
		end
	end
	return boolValue;
end

function OneHitWonder_IsChannelSpellRunning()
	return OneHitWonder_IsSomeSpellRunning("Channel");
end

function OneHitWonder_IsRegularSpellRunning()
	return OneHitWonder_IsSomeSpellRunning("Regular");
end

OneHitWonder_RacialEffects = nil;

function OneHitWonder_GetRacialEffects()
	if ( not OneHitWonder_RacialEffects ) then
		OneHitWonder_RacialEffects = {};
		if ( OneHitWonder_GetPlayerRace() == ONEHITWONDER_RACE_UNDEAD ) then
			for k, v in OneHitWonder_FearSpells do
				table.insert(OneHitWonder_RacialEffects, v);
			end
			for k, v in ONEHITWONDER_SLEEP_EFFECTS do
				table.insert(OneHitWonder_RacialEffects, v);
			end
		end
	end
	return OneHitWonder_RacialEffects;
end

OneHitWonder_ClassesThatCanCure = {
	[ONEHITWONDER_DEBUFF_TYPE_DISEASE] = {
		[ONEHITWONDER_CLASS_PALADIN] = {
			ONEHITWONDER_SPELL_PURIFY_NAME,
		},
		[ONEHITWONDER_CLASS_PRIEST] = {
			ONEHITWONDER_SPELL_CURE_DISEASE_NAME,
		}
	},
	[ONEHITWONDER_DEBUFF_TYPE_POISON] = {
		[ONEHITWONDER_CLASS_PALADIN] = {
			ONEHITWONDER_SPELL_PURIFY_NAME,
		},
		[ONEHITWONDER_CLASS_PRIEST] = {
			ONEHITWONDER_SPELL_CURE_DISEASE_NAME,
		}
	},
	[ONEHITWONDER_DEBUFF_TYPE_MAGIC] = {
		[ONEHITWONDER_CLASS_PALADIN] = {
			ONEHITWONDER_SPELL_CLEANSE_NAME,
		},
		[ONEHITWONDER_CLASS_PRIEST] = {
			ONEHITWONDER_SPELL_DISPEL_MAGIC_NAME,
		}
	},
};

function OneHitWonder_DoStuffContinuously_Racial()
	if ( OneHitWonder_GetPlayerRace() == ONEHITWONDER_RACE_UNDEAD ) then
		local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_RACIAL_WILL_OF_THE_FORSAKEN_NAME);
		if ( OneHitWonder_IsSpellAvailable(spellId) ) and ( OneHitWonder_UseWilloftheForsaken == 1 ) then
			if ( OneHitWonder_HasPlayerEffect(nil, OneHitWonder_GetRacialEffects()) ) then
				return OneHitWonder_CastSpell(spellId);
			end
		end
	elseif ( OneHitWonder_GetPlayerRace() == ONEHITWONDER_RACE_DWARF ) then
		local curTime = GetTime();
		local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_RACIAL_STONEFORM_NAME);
		if ( OneHitWonder_IsSpellAvailable(spellId) ) and ( OneHitWonder_UseStoneform == 1 ) then
			local debuffsByType = OneHitWonder_GetDebuffsByType("player");
			local shouldStoneform = false;
			if ( debuffsByType[ONEHITWONDER_DEBUFF_TYPE_DISEASE] ) and ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_DISEASE]) > 0 ) then
			-- Kinesia. The more complicated code that used to be here didn't work properly, and I'd rather use the racial all the time and save mana.
				for k, v in debuffsByType[ONEHITWONDER_DEBUFF_TYPE_DISEASE] do
					if ( v.expires-curTime > 10 ) then
						shouldStoneform = true;
						break;
					end
				end
			end
			if ( debuffsByType[ONEHITWONDER_DEBUFF_TYPE_POISON] ) and ( table.getn(debuffsByType[ONEHITWONDER_DEBUFF_TYPE_POISON]) > 0 ) then
				for k, v in debuffsByType[ONEHITWONDER_DEBUFF_TYPE_POISON] do
					if ( v.expires-curTime > 10 ) then
						shouldStoneform = true;
						break;
					end
				end
			end
			if ( shouldStoneform ) then
				return OneHitWonder_CastSpell(spellId);
			end
		end
	end
	return false;
end


OneHitWonder_DoStuffContinuously_PreventLoop = 0;
OneHitWonder_BetweenDoStuffContinuously = nil;
OneHitWonder_LastDoStuffContinuously = nil;
ONEHITWONDER_TIME_BETWEEN_DO_STUFF_CONTINUOUSLY = 1;

function OneHitWonder_DoStuffContinuously()
--	_print("OneHitWonder_DoStuffContinuously")
	if ( not OneHitWonder_IsEnabled() ) then return false; end

-- Kinesia: Keep "Give me wonder" separate.
-- 	if ( OneHitWonder_DoStuffContinuously_PreventLoop == 1 ) then
--		OneHitWonder_DoStuffContinuously_PreventLoop = 0;
--	elseif ( OneHitWonder_AutomatedGiveMeWonder == 1 ) then
--		OneHitWonder_DoStuffContinuously_PreventLoop = 1;
--		local ok = OneHitWonder_GiveMeWonder();
--		if ( ok ) then
--			OneHitWonder_DoStuffContinuously_PreventLoop = 0;
--			return ok;
--		end
--	end
	
	local curTime = GetTime();
	if ( OneHitWonder_LastDoStuffContinuously ) and ( curTime - OneHitWonder_LastDoStuffContinuously <= ONEHITWONDER_TIME_BETWEEN_DO_STUFF_CONTINUOUSLY ) then
		return false;
	end
	if ( OneHitWonder_LastDoStuffContinuously ) then
		OneHitWonder_BetweenDoStuffContinuously = curTime - OneHitWonder_LastDoStuffContinuously;
	end
	if ( OneHitWonder_IsChannelSpellRunning() ) or ( OneHitWonder_IsRegularSpellRunning() ) then
		return false;
	end
	if ( not OneHitWonder_CanCastSpells() ) then
		return false;
	end
	local isOkayToBuff = true;
	if ( not OneHitWonder_ShouldTryToCastABuff(true) ) then
		return false;
	end
	OneHitWonder_LastDoStuffContinuously = curTime;
	local isTaxi = OneHitWonder_IsPlayerOnTaxi();
	local shouldTryToCastABuff = OneHitWonder_ShouldTryToCastABuff();
	if ( shouldTryToCastABuff ) then
		--OneHitWonder_CheckFriendlies();
	end
	if ( shouldTryToCastABuff ) and ( OneHitWonder_HandleActionQueue() ) then
		return true;
	end
	if ( shouldTryToCastABuff ) and ( OneHitWonder_DoStuffContinuously_Racial() ) then
		return true;
	end
	local func = getglobal(format("OneHitWonder_DoStuffContinuously_%s", OneHitWonder_GetPlayerClass()));
	if ( func ) then
		if ( func() ) then
			return true;
		end
	end
	local isOKToBuff = false;
	local timeSinceLastBuff = GetTime() - OneHitWonder_LastBuffed;
	--[[
	local fullMana = false;
	if ( OneHitWonder_GetPlayerManaPercentage() >= 100 ) then
		fullMana = true;
	end
	if ( (not isDead) and ( ( fullMana ) or ( timeSinceLastBuff <= 5 ) ) 
		--and ( not PlayerFrame.inCombat ) ) 
		then
		isOKToBuff = true;
	end
	]]--
	isOKToBuff = shouldTryToCastABuff;
	local buffId;
	if ( isOKToBuff ) then
		if ( OneHitWonder_DoBuffs(nil, nil, { "player" } ) ) then
			return true;
		end
	end
	local inCatForm = false;
	
	if ( OneHitWonder_GetPlayerClass() == ONEHITWONDER_CLASS_DRUID ) then
		if ( OneHitWonder_Druid_GetCurrentShapeshiftform ) then
			local currentForm = OneHitWonder_Druid_GetCurrentShapeshiftform();
			if ( currentForm == ONEHITWONDER_DRUID_SHAPESHIFT_FORM_CAT ) then
				inCatForm = true;
			end
		end
	end
	if ( ( shouldTryToCastABuff ) or ( inCatForm ) ) and ( OneHitWonder_ShouldKeepBuffsUp == 1 )  then
		local trackBuffName = OneHitWonder_GetPlayerTrackingBuffName();
		
		if false then 
			-- ( not trackBuffName ) then
			local spellId = -1;
			local shouldTrack = true;
			if ( shouldTrack ) and ( OneHitWonder_PreferredTrackingSpell ) then
				if ( OneHitWonder_PreferredTrackingSpell == ONEHITWONDER_ABILITY_FIND_NO_STUFF_NAME ) then
					shouldTrack = false;
				else
					spellId = OneHitWonder_GetSpellId(OneHitWonder_PreferredTrackingSpell);
					if ( spellId > 0 ) then
						if ( ( OneHitWonder_CastSpell(spellId) ) and ( OneHitWonder_IsSpellAvailable(spellId) ) ) then
							return true;
						end
					end
				end
			end
			if ( shouldTrack ) then
				if ( inCatForm ) then
					spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ABILITY_TRACK_HUMANOIDS_NAME);
					if ( spellId > 0 ) then
						if ( OneHitWonder_IsSpellAvailable(spellId) ) then
							if ( OneHitWonder_CastSpell(spellId) ) then
								return true;
							end
						end
					end
				end
				for k, v in OneHitWonder_TrackingSpellsList do
					spellId = OneHitWonder_GetSpellId(v);
					if ( spellId > 0 ) then
						if ( OneHitWonder_IsSpellAvailable(spellId) ) then
							if ( OneHitWonder_CastSpell(spellId) ) then
								return true;
							end
						end
					end
				end
			end
		end
	end
	if ( OneHitWonder_ShouldKeepBuffsUpParty == 1 ) then
		if ( not OneHitWonder_HasTarget() ) or ( UnitCanAttack("player", "target") ) then
			if ( OneHitWonder_DoBuffs() ) then
				return true;
			end
		else
			local targetName = UnitName("target");
			local petName = UnitName("pet");
			if ( petName ) and ( targetName == petName ) then
				if ( OneHitWonder_DoBuffs(nil, nil, { "pet" } ) ) then
					return true;
				end
			end
			local partyName = nil;
			local unitname = nil;
			for i = 1, 4 do
				unitname = OneHitWonder_PartyUnits[i];
				if ( UnitExists(unitname) ) then
					partyName = UnitName(unitname);
					if ( partyName ) and ( targetName == partyName ) then
						if ( OneHitWonder_DoBuffs(nil, nil, { unitname } ) ) then
							return true;
						end
					end
				end
			end
		end
	end
	
	-- YZ: options collectin job
	OneHitWonder_DoSetOptions();
	
	return OneHitWonder_HandleActionQueue();
end

function OneHitWonder_GetSpellIdInfo(spellId, spellBook, tooltipName)
	if ( ( not spellId ) or ( spellId <= -1 ) ) then
		return nil;
	end
	if ( not spellBook ) then
		spellBook = OneHitWonder_GetSpellBook(spellBook);
	end
	if ( not tooltipName ) then
		tooltipName = "OneHitWonderTooltip";
	end
	local tooltip = getglobal(tooltipName);
	if ( not tooltip ) then
		tooltipName = "OneHitWonderTooltip";
		tooltip = getglobal(tooltipName);
		if ( not tooltip ) then
			OneHitWonder_Print("OHW: Could not find tooltip to extract spell ID info from "..tooltipName, 1.0, 0.2, 0.2);
			return nil;
		end
	end
	OneHitWonder_ClearTooltip(tooltipName);
	DynamicData.util.protectTooltipMoney();
	tooltip:SetSpell(spellId, spellBook);
	DynamicData.util.unprotectTooltipMoney();
	
	local strings = OneHitWonder_ScanTooltip(tooltipName);
	
	local name, rankName = GetSpellName(spellId, spellBook);
	strings["rank"] = rankName;
	
	return strings;
end

function OneHitWonder_GetActionIdInfo(actionId, tooltipName)
	if ( ( not actionId ) or ( actionId <= -1 ) ) then
		return nil;
	end
	if ( not tooltipName ) then
		tooltipName = "OneHitWonderTooltip";
	end
	local tooltip = getglobal(tooltipName);
	if ( not tooltip ) then
		tooltipName = "OneHitWonderTooltip";
		tooltip = getglobal(tooltipName);
		if ( not tooltip ) then
			OneHitWonder_Print("OHW: Could not find tooltip to extract action ID info from.", 1.0, 0.2, 0.2);
			return nil;
		end
	end
	OneHitWonder_ClearTooltip(tooltipName);
	DynamicData.util.protectTooltipMoney();
	tooltip:SetAction(actionId);
	DynamicData.util.unprotectTooltipMoney();
	
	local strings = OneHitWonder_ScanTooltip(tooltipName);
	
	return strings;
end

-- Thanks to Cosmos for this one!
function OneHitWonder_ScanTooltip(TooltipNameBase)
	if ( not TooltipNameBase  ) then 
		TooltipNameBase = "OneHitWonderTooltip";
	end
	
	local strings = {};
	local ttext = nil;
	local textLeft = nil;
	local textRight = nil;
	for idx = 1, 20 do
		textLeft = nil;
		textRight = nil;
		ttext = getglobal(TooltipNameBase.."TextLeft"..idx);
		if(ttext and ttext:IsVisible() and ttext:GetText() ~= nil)
		then
			textLeft = ttext:GetText();
		end
		ttext = getglobal(TooltipNameBase.."TextRight"..idx);
		if(ttext and ttext:IsVisible() and ttext:GetText() ~= nil)
		then
			textRight = ttext:GetText();
		end
		if (textLeft or textRight)
		then
			strings[idx] = {};
			strings[idx].left = textLeft;
			strings[idx].right = textRight;
		end
	end

	return strings;
end

function OneHitWonder_ClearTooltip(TooltipNameBase)
	if ( not TooltipNameBase  ) then 
		TooltipNameBase = "OneHitWonderTooltip";
	end
	
	local textLeft = nil;
	local textRight = nil;
	for idx = 1, 20 do
		textLeft = nil;
		textRight = nil;
		textLeft = getglobal(TooltipNameBase.."TextLeft"..idx);
		if ( textLeft ) then
			textLeft:SetText("");
		end
		textRight = getglobal(TooltipNameBase.."TextRight"..idx);
		if ( textRight ) then
			textRight:SetText("");
		end
	end
	
	local tooltip = getglobal(TooltipNameBase);
	if ( tooltip ) then
		tooltip:SetText("");
	end

end


OneHitWonder_PartyUnits = { "player", "party1", "party2", "party3", "party4"};


function OneHitWonder_GetClassesInParty()
	local classes = {};
	local class = "";
	for k, v in OneHitWonder_PartyUnits do
		class = UnitClass(v);
		if ( ( class ) and ( strlen(class) > 0 ) ) then
			if ( classes[class] ) then
				classes[class] = classes[class] + 1;
			else
				classes[class] = 1;
			end
		end
	end
	return classes;
end

function OneHitWonder_IsEnabled()
	if ( OneHitWonder_Enabled == 1 ) then
		return true;
	else
		return false;
	end
end

function OneHitWonder_SetEnabled(toggle)
	if ( OneHitWonder_Enabled ~= toggle ) then
		OneHitWonder_Enabled = toggle;
	end
	OneHitWonder_ShowQueue();
end

function OneHitWonder_SetShouldShowQueue(toggle)
	if ( OneHitWonder_ShouldShowQueue ~= toggle ) then
		OneHitWonder_ShouldShowQueue = toggle;
	end
	OneHitWonder_ShowQueue();
end

function OneHitWonder_SetShouldShowReactiveText(toggle)
	if ( OneHitWonder_ShouldReactiveText ~= toggle ) then
		OneHitWonder_ShouldReactiveText = toggle;
	end
end

function OneHitWonder_OverloadedCastSpell(spellId, spellBook)
	OneHitWonder_HandleSpellCast(OneHitWonder_GetSpellName(spellId, spellBook));
	return OneHitWonder_Saved_CastSpell(spellId, spellBook)
end

OneHitWonder_Saved_CastSpell = CastSpell;
CastSpell = OneHitWonder_OverloadedCastSpell;

function OneHitWonder_OverloadedUseAction(actionId, param1, param2)
	local arr = OneHitWonder_ActionIdInfo[actionId];
	if ( ( arr ) and ( arr[1] ) ) then
		OneHitWonder_HandleSpellCast(arr[1].left);
	end
	return OneHitWonder_Saved_UseAction(actionId, param1, param2);
end

OneHitWonder_Saved_UseAction = UseAction;
UseAction = OneHitWonder_OverloadedUseAction;

function OneHitWonder_HandleSpellCast(spellName)
	if ( OneHitWonder_GetPlayerClass() == ONEHITWONDER_CLASS_WARLOCK ) then
		OneHitWonder_HandleSpellCast_Warlock(spellName);
	end
end


function OneHitWonder_GetNumberOfClassInParty(class)
	local classes = OneHitWonder_GetClassesInParty();
	local nr = 0;
	local tmp = 0;
	if ( type(class) == "table" ) then
		for k, v in class do
			tmp = classes[v];
			if ( tmp ) then
				nr = nr + tmp;
			end
		end
	elseif ( type(class) == "string" ) then
		nr = classes[v];
	end
	if ( ( nr ) and ( nr >= 1 ) ) then
		return nr;
	else
		return 0;
	end
end

function OneHitWonder_GetNumberOfClassInGroup(class)
	return OneHitWonder_GetNumberOfClassInParty(class);
end

ONEHITWONDER_PETMODE_UNKNOWN = -1;
ONEHITWONDER_PETMODE_AGGRESSIVE = 0;
ONEHITWONDER_PETMODE_DEFENSIVE = 1;
ONEHITWONDER_PETMODE_PASSIVE = 2;

function OneHitWonder_GetPetMode()
	for i=1, NUM_PET_ACTION_SLOTS, 1 do
		petActionButton = getglobal("PetActionButton"..i);
		petActionIcon = getglobal("PetActionButton"..i.."Icon");
		petAutoCastableTexture = getglobal("PetActionButton"..i.."AutoCastable");
		petAutoCastModel = getglobal("PetActionButton"..i.."AutoCast");
		local name, subtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i);
		if ( name ~= nil and isActive ) then
			if ( strfind(name, "MODE") ) then
				if ( strfind(name, "PET_MODE_AGGRESSIVE") ) then
					return ONEHITWONDER_PETMODE_AGGRESSIVE;
				elseif ( strfind(name, "PET_MODE_DEFENSIVE") ) then		
					return ONEHITWONDER_PETMODE_DEFENSIVE;
				elseif ( strfind(name, "PET_MODE_PASSIVE") ) then
					return ONEHITWONDER_PETMODE_PASSIVE;
				end
			end
		end
	end
	return ONEHITWONDER_PETMODE_UNKNOWN;
end

function OneHitWonder_SmartPetAttack(shouldAttack)
	if ( shouldAttack == 1 ) and ( not UnitIsDead("pet") ) and ( UnitExists("pet") ) then
		if (OneHitWonder_PetIsAttacking == false) then
			local petMode = OneHitWonder_GetPetMode();
			if ( ( petMode == ONEHITWONDER_PETMODE_AGGRESSIVE ) or ( petMode == ONEHITWONDER_PETMODE_DEFENSIVE ) ) then
				PetAttack();
			end
		end
	end
end

function OneHitWonder_IsAttacking()
	local actionId = DynamicData.action.getMatchingActionId(ONEHITWONDER_ATTACK_ACTION_NAME);
	if ( actionId ) and ( IsAttackAction(actionId) ) then
		if ( IsCurrentAction(actionId) ) then
			return true;
		end
	end
	return false;
end

function OneHitWonder_InMeleeRange()
	local inMeleeRange = true;
	local spellId = OneHitWonder_GetSpellId(ONEHITWONDER_ATTACK_ACTION_NAME)
	if ( spellId > -1 ) then
		inMeleeRange = OneHitWonder_CheckIfInRangeSpellId(spellId);
	end
	return inMeleeRange
end

function OneHitWonder_MeleeAttack()
	OneHitWonder_Attacking = false
	local actionId = DynamicData.action.getMatchingActionId(ONEHITWONDER_ATTACK_ACTION_NAME);
	if ( actionId ) and ( IsAttackAction(actionId) ) then
		if ( IsCurrentAction(actionId) ) then
			OneHitWonder_Attacking = true;
		end
	end
	if ( not OneHitWonder_Attacking) then
		AttackTarget();
		-- use auto attack blink on attack button
		OneHitWonder_Attacking = true;
	end
end

function OneHitWonder_GetBuffData(unit, buffIndex, debuff)
	if (buffIndex ~= -1) then
		local texture = nil;
		if ( debuff ) then
			texture = UnitDebuff(unit, buffIndex);
		else
			texture = UnitBuff(unit, buffIndex);
		end
		if ( not texture ) then
			return nil;
		end
		local tooltipName = "OneHitWonderTooltip";
		local tooltip = getglobal(tooltipName);
		OneHitWonder_ClearTooltip(tooltipName);
		DynamicData.util.protectTooltipMoney();
		if ( unit == "player" ) then
			tooltip:SetPlayerBuff(buffIndex);
		else
			if ( not debuff ) then
				tooltip:SetUnitBuff(unit, buffIndex);
			else
				tooltip:SetUnitDebuff(unit, buffIndex);
			end
		end
		DynamicData.util.unprotectTooltipMoney();
		local element = {};
		element.name = name;
		element.buffIndex = buffIndex;
		element.texture = texture;
		if ( DynamicData.util.getTooltipStrings ) then
			element.strings = DynamicData.util.getTooltipStrings(tooltipName);
		else
			element.strings = {};
			for i = 1, 15 do
				element.strings[i] = {};
			end
		end
		if ( ( element.strings ) and ( element.strings[1] ) and ( element.strings[1].left ) ) then
			element.name = element.strings[1].left;
		else
			element.name = "";
		end
		element.expires = ONEHITWONDER_BUFF_EXPIRES_UNKNOWN;
		return element;
	end
	return nil;
end

ONEHITWONDER_BUFF_EXPIRES_NEVER = -2;
ONEHITWONDER_BUFF_EXPIRES_UNKNOWN = -1;

function OneHitWonder_GetPlayerBuffData(buffIndex, untilCancelled, tooltipName)
	local tooltip = getglobal(tooltipName);
	if ( ( not tooltipName ) or ( not tooltip ) ) then
		tooltipName = "OneHitWonderTooltip";
		tooltip = getglobal(tooltipName);
	end
	if ( not tooltip ) then
		return nil;
	end

	local texture = GetPlayerBuffTexture(buffIndex);
	if ( not texture ) then
		return nil;
	end

	local element = {};
	element.texture = texture;
	element.buffIndex = buffIndex;
	OneHitWonder_ClearTooltip(tooltipName);
	DynamicData.util.protectTooltipMoney();
	tooltip:SetPlayerBuff(buffIndex);
	DynamicData.util.unprotectTooltipMoney();
	if ( untilCancelled == 1 ) then
		element.expires = ONEHITWONDER_BUFF_EXPIRES_NEVER;
	else
		element.expires = GetTime()+GetPlayerBuffTimeLeft(buffIndex);
	end
	if ( DynamicData.util.getTooltipStrings ) then
		element.strings = DynamicData.util.getTooltipStrings(tooltipName);
	else
		element.strings = {};
		for i = 1, 15 do
			element.strings[i] = {};
		end
	end
	if ( ( element.strings ) and ( element.strings[1] ) and ( element.strings[1].left ) ) then
		element.name = element.strings[1].left;
	else
		element.name = "";
	end
	return element;
end

function OneHitWonder_GetPlayerEffects(tooltipName)
	local currentBuffs = {};
	local currentDebuffs = {};
	local isDebuff = false;
	local id = 0;
	local buffIndex, untilCancelled;
	local buffFilter = "HELPFUL|PASSIVE";
	for id = 0, 15 do
		buffIndex, untilCancelled = GetPlayerBuff(id, buffFilter);
		if ( buffIndex >= 0 ) then
			element = OneHitWonder_GetPlayerBuffData(buffIndex, untilCancelled, tooltipName);
			if ( element ) then
				element.effectType = ONEHITWONDER_EFFECTTYPE_BUFF;
				table.insert(currentBuffs, element);
			end
		end
	end
	local buffFilter = "HARMFUL";
	for id = 0, 7 do
		buffIndex, untilCancelled = GetPlayerBuff(id, buffFilter);
		if ( buffIndex >= 0 ) then
			element = OneHitWonder_GetPlayerBuffData(buffIndex, untilCancelled, tooltipName);
			if ( element ) then
				element.effectType = ONEHITWONDER_EFFECTTYPE_DEBUFF;
				table.insert(currentDebuffs, element, tooltipName);
			end
		end
	end
	local icon = GetTrackingTexture();
	if ( icon ) then
		local strings = OneHitWonder_GetPlayerTrackingBuffStrings();
		local trackBuffName = "";
		if ( ( strings ) and ( strings[1] ) and ( strings[1].left ) ) then
			trackBuffName = strings[1].left;
		end
		buffData = {};
		buffData.texture = icon;
		buffData.name = trackBuffName;
		buffData.strings = strings;
		buffData.expires = ONEHITWONDER_BUFF_EXPIRES_NEVER;
		table.insert(currentBuffs, buffData);
	end
	return currentBuffs, currentDebuffs;
end

ONEHITWONDER_EFFECTTYPE_BUFF = "Buff";
ONEHITWONDER_EFFECTTYPE_DEBUFF = "Debuff";

local OneHitWonder_CheckEveryoneEffects_List = {
	"player", "pet", "party1", "party2", "party3", "party4",
};
	
function OneHitWonder_CheckEveryoneEffects()
	local doneStuff = false;
	if ( not OneHitWonder_CheckEffect("target") ) then
		local n = 1;
		local entry = nil;
		while ( n <= table.getn(OneHitWonder_CheckEveryoneEffects_List) ) do
			entry = table.remove(OneHitWonder_CheckEveryoneEffects_List);
			table.insert(OneHitWonder_CheckEveryoneEffects_List, entry);
			if ( OneHitWonder_CheckEffect(entry) ) then
				doneStuff = true;
				break;
			end
		end
		n = n + 1;
	else
		doneStuff = true;
	end
	return doneStuff;
end

local OneHitWonder_CheckFriendlies_List = {
	"player", "pet", "party1", "party2", "party3", "party4",
};
	
OneHitWonder_CheckFriendlies_Time = nil;

function OneHitWonder_CheckFriendlies_Immediate()
	OneHitWonder_DoCheckFriendlies();
end

function OneHitWonder_CheckFriendlies()
	if ( OneHitWonder_ShouldAutoCure ~= 1 ) then
		return false;
	end
	local curTime = GetTime();
	if ( not OneHitWonder_CheckFriendlies_Time ) or ( curTime - OneHitWonder_CheckFriendlies_Time > OneHitWonder_AutoCureDelay) then
		return OneHitWonder_DoCheckFriendlies();
	else
		return false;
	end
end

function OneHitWonder_DoCheckFriendlies()
	local curTime = GetTime();
	OneHitWonder_CheckFriendlies_Time = curTime;
	
	local doneStuff = false;
	local n = 1;
	local entry = nil;
	while ( n <= table.getn(OneHitWonder_CheckFriendlies_List) ) do
		entry = table.remove(OneHitWonder_CheckFriendlies_List);
		table.insert(OneHitWonder_CheckFriendlies_List, entry);
		if ( OneHitWonder_CheckEffect(entry) ) then
			doneStuff = true;
			break;
		end
		n = n + 1;
	end
	return doneStuff;
end

OneHitWonder_CheckUnit_Time = {};

function OneHitWonder_CheckEffect(unit)
	if ( not unit ) then
		return OneHitWonder_CheckEveryoneEffects();
	end
	if ( not UnitExists(unit) ) then
		return false;
	end
	local func = getglobal(format("OneHitWonder_CheckEffect_%s", OneHitWonder_GetPlayerClass()));
	if ( not func ) then
		return false;
	end
	return func(unit);
end

function OneHitWonder_CheckEffectOld(unit)
	if ( ( not unit ) or ( type(unit) ~= "string" ) ) then
		return;
	end
	if ( DynamicData.util.safeToUseTooltips ) then
		if ( not DynamicData.util.safeToUseTooltips() ) then
			OneHitWonder_ScheduleByName("ONEHITWONDER_CHECK_BUFFS_"..unit, 1, OneHitWonder_CheckEffects, unit);
			return;
		end
	end
	local timeout = 3;
	
	local buffData = nil;
	
	OneHitWonder_CurrentAuras[unit] = {};
	
	local currentBuffs = {};
	local currentDebuffs = {};

	if ( unit ~= "player" ) then
		for i = 0, MAX_PARTY_TOOLTIP_BUFFS do
			buffData = OneHitWonder_GetBuffData(unit, i);
			if ( buffData ) then
				buffData.effectType = ONEHITWONDER_EFFECTTYPE_BUFF;
				table.insert(currentBuffs, buffData);
			end
		end
		for i = 0, MAX_PARTY_TOOLTIP_DEBUFFS do
			buffData = OneHitWonder_GetBuffData(unit, i, debuff);
			if ( buffData ) then
				buffData.effectType = ONEHITWONDER_EFFECTTYPE_DEBUFF;
				table.insert(currentDebuffs, buffData);
			end
		end
	else
		currentBuffs, currentDebuffs = OneHitWonder_GetPlayerEffects();
	end
	
	OneHitWonder_CurrentAuras[unit].buffs = currentBuffs;
	OneHitWonder_CurrentAuras[unit].debuffs = currentDebuffs;
	
	if ( ( unit == "player" ) or ( unit == "pet") or ( strsub(unit, 1, 5) == "party") ) then
		local parameters = { unit, GetTime() + timeout};
		OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_BUFF, parameters);
	elseif ( unit == "target" ) then
		if ( ( PlayerFrame.inCombat == 1 ) and ( UnitCanAttackTarget("target", "player" ) ) ) then
			local parameters = { unit, GetTime() + timeout};
			OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_DEBUFF, parameters);
		end
	end
end

-- Taken from TargetDistance - all credits to it!

OneHitWonder_TargetDistance_Data = {};

-- Taken from TargetDistance - all credits to it!
function OneHitWonder_TargetDistance_SetContinent()
	local x, y = GetPlayerMapPosition("player");
	local continent = GetCurrentMapContinent();
	
	if(x == 0 and y == 0) then
		if ( continent == 1) then
			continent = 2;
		elseif( continent == 2) then
			continent = 1;
		else
			return false;
		end
	end

	if (continent) then
		SetMapZoom(continent, nil);
	else
		return false;
	end
	
	local mapFileName, textureHeight, textureWidth = GetMapInfo();
	OneHitWonder_TargetDistance_Data.mapFileName = mapFileName;
	OneHitWonder_TargetDistance_Data.textureHeight = textureHeight;
	OneHitWonder_TargetDistance_Data.textureWidth = textureWidth;
	return true;
end

-- first starts of DD party? who knows...
OneHitWonder_UnitDistanceTable = {};

function OneHitWonder_GetDistanceInYards(unit)
	return nil;
end

-- Taken from TargetDistance - all credits to it!
function OneHitWonder_GetDistanceInYardsQWE(unit)
	-- optimizations START
	if ( unit == "player" ) then
		return 0;
	end
	local curTime = GetTime();
	if ( OneHitWonder_UnitDistanceTable[unit] ) then
		local unitData = OneHitWonder_UnitDistanceTable[unit];
		if ( ( unitData.time + 1.0 ) >= curTime ) then
			return unitData.distanceInYards;
		end
	end
	-- optimizations END
	if ( not OneHitWonder_TargetDistance_SetContinent() ) then
		return nil;
	end
	if ( (OneHitWonder_TargetDistance_Data.mapFileName==nil ) or ( OneHitWonder_TargetDistance_Data.textureHeight==nil ) or ( OneHitWonder_TargetDistance_Data.textureWidth==nil ) ) then
		return nil;
	end
	local tx, ty = GetPlayerMapPosition(unit); 
	local px, py = GetPlayerMapPosition("player");
	
	if(tx == 0 and ty == 0) then
		  -- probably in an instance, no map position
		return nil;
	end
	
	if(px == 0 and py == 0) then
		  -- probably in an instance, no map position
		return nil;
	end

	tx = OneHitWonder_TargetDistance_Data.textureWidth * tx;
	ty = OneHitWonder_TargetDistance_Data.textureHeight * ty;

	px = OneHitWonder_TargetDistance_Data.textureWidth * px;
	py = OneHitWonder_TargetDistance_Data.textureHeight * py;

	local xdelta = tx-px;
	local ydelta = ty-py;

	local distance = 0;
	
	  -- For some reason I had to weight the distance formula in favor of the exponentiated xdelta
	  -- otherwise the distance is reported incorrectly along the x axis, and correctly along the y axis.
	distance = sqrt(math.pow(xdelta,2)*2+math.pow(ydelta,2));
	
	-- optimizations START
	local distanceInYards = nil;
	
	  -- until a better way of finding distance comes around, these formulas
	  -- roughly calibrate the calculated distance to yards via tested constants
	  -- on the respective continents
	if((string.find(ONEHITWONDER_CONTINENT_AZEROTH_NAME,OneHitWonder_TargetDistance_Data.mapFileName) ~= nil)) then
		distanceInYards = math.floor((math.floor(distance*10000)/7450)*10);
	elseif((string.find(ONEHITWONDER_CONTINENT_KALIMDOR_NAME,OneHitWonder_TargetDistance_Data.mapFileName) ~= nil)) then
		distanceInYards = math.floor((math.floor(distance*10000)/7000)*10);
	end

	OneHitWonder_UnitDistanceTable[unit] = {};
	OneHitWonder_UnitDistanceTable[unit].time = curTime;
	OneHitWonder_UnitDistanceTable[unit].distance = distance;
	OneHitWonder_UnitDistanceTable[unit].distanceInYards = distanceInYards;
	-- optimizations END
	return distanceInYards;
end


function OneHitWonder_GetUnitDistance(unit)
	if ( unit == "player" ) then
		return 0, 0;
	end
	local playerPos = nil;
	local partyPos = nil;
	if ( strfind(unit, "party") ) then
		playerPos = OneHitWonder_GetUnitPosition("player");
		partyPos = OneHitWonder_GetUnitPosition(unit);
	end
	if ( ( playerPos ) and ( partyPos ) ) then
		local diffX = math.abs(playerPos.x - partyPos.x)*100;
		local diffY = math.abs(playerPos.y - partyPos.y)*100;
		return diffX, diffY;
	else
		return -1, -1;
	end
end

function OneHitWonder_IsUnitInRange(unit, allowedRangeMin, allowedRangeMax)
	if ( unit == "player" ) then
		return true;
	end
	if ( unit == "target" ) then
		return true;
	end
	if ( OneHitWonder_DisableRangeFinding == 1 ) then
		return true;
	end
	if ( not allowedRangeMin ) then
		allowedRangeMin = 30;
	end
	if ( not allowedRangeMax ) then
		allowedRangeMax = allowedRangeMin;
	end
	if ( allowedRangeMin == allowedRangeMax ) then
		allowedRangeMin = 0;
	end
	local distanceInYards = OneHitWonder_GetDistanceInYards(unit);
	if ( not distanceInYards ) then
		return true;
	elseif ( distanceInYards ) and ( distanceInYards >= allowedRangeMin ) and ( distanceInYards <= allowedRangeMax) then
		return true;
	else
		return false;
	end

end


function OneHitWonder_GetUnitPosition(unit)
	local unitX, unitY = GetPlayerMapPosition(unit);
	local pos = nil;
	if ( ( unitX ~= 0 ) or ( unitY ~= 0 ) ) then
		pos = {};
		pos.x = unitX;
		pos.y = unitY;
	end
	return pos;
end


function OneHitWonder_GetDebuffsByType(unit, specialOptions)
	local effectInfo = DynamicData.effect.getEffectInfos(unit);
	local debuffsByType = {};
	local curTime = GetTime();
	local lowestExpiryTime = {};
	local ignoreDebuffs = {};
	local ignoreDebuffsByType = {};
	if ( not specialOptions ) then
		specialOptions = {};
	end
	if ( specialOptions.minimumDuration ) then
		for k, v in specialOptions.minimumDuration do
			lowestExpiryTime[k] = curTime + v;
		end
	end
	if ( specialOptions.ignoreDebuffs ) then
		for k, v in specialOptions.ignoreDebuffs do
			table.insert(ignoreDebuffs, v);
		end
	end
	if ( not specialOptions.doNotRemoveStandardIgnoreDebuffs ) then
		for debuffType, value in OneHitWonder_DoNotCountTheseDebuffSpells do
			for k, spellName in value do
				--table.insert(ignoreDebuffsByType, spellName);
				table.insert(ignoreDebuffs, spellName);
			end
		end
		if ( OneHitWonder_DoNotCountTheseDebuffSpells_User ) then
			for debuffType, value in OneHitWonder_DoNotCountTheseDebuffSpells_User do
				if ( type(value) == "table" ) then
					for k, spellName in value do
						--table.insert(ignoreDebuffsByType, spellName);
						table.insert(ignoreDebuffs, spellName);
					end
				else
					table.insert(ignoreDebuffs, value);
				end
			end
			-- RegisterForSave("OneHitWonder_DoNotCountTheseDebuffSpells_User");
		end
	end
	local debuffsToIgnore = table.getn(ignoreDebuffs);
	local shouldAdd = true;
	local debuffType = nil;
	if ( effectInfo.debuffs ) then
		for k, v in effectInfo.debuffs do
			shouldAdd = true;
			debuffType = nil;
			if ( v.name ) and ( debuffsToIgnore > 0 ) then
				if ( DynamicData.util.isStringInList(v.name, ignoreDebuffs) ) then
					shouldAdd = false;
				end
			end
			if ( v.strings ) and ( shouldAdd ) then
				if ( v.strings[1] ) and ( v.strings[1].right )  then
					debuffType = v.strings[1].right;
					shouldAdd = true;
					if ( ( lowestExpiryTime[debuffType] ) and ( ( v.expires > 0 ) and ( v.expires <= lowestExpiryTime[debuffType] ) ) ) then
						shouldAdd = false;
					end
				end
			else
				shouldAdd = false;
			end
			if ( shouldAdd ) and ( debuffType ) then
				if ( not debuffsByType[debuffType] ) then
					debuffsByType[debuffType] = {};
				end
				table.insert(debuffsByType[debuffType], v);
			end
		end
	end
	return debuffsByType;
end

OneHitWonder_buttonBuffList = nil;

function OneHitWonder_ExecuteBuffButton()
	local specialOptions = {
		ignoreMana = true,
		ignoreHealth = true,
		ignoreNotWhileHated = true,
		ignoreInCombat = true,
		ignoreNoBuffing = true
	};
	local buffList = {
		"target", "player", "pet", "party1", "party2", "party3", "party4"
	};
	if ( not OneHitWonder_buttonBuffList ) then
		OneHitWonder_buttonBuffList = buffList;
	else
--		local entry = table.remove(OneHitWonder_buttonBuffList);
--		table.insert(OneHitWonder_buttonBuffList, entry);
	end
	OneHitWonder_DoBuffs(true, specialOptions, OneHitWonder_buttonBuffList);
end

function OneHitWonder_RetrieveCleansingSpellId(unit)
	local func = getglobal(format("OneHitWonder_%s_RetrieveCleansingSpellId", OneHitWonder_GetPlayerClass()));
	if ( func ) then
		return func(unit);
	else
		return -1;
	end
end

-- Added by Kinesia
function OneHitWonder_CastSpellTarget(id, target, spellbook)
	local hasTarget = OneHitWonder_HasTarget();
	local madeTarget=0;
	local changedTarget=0;
	
	if ( hasTarget ) then
		local targetName = UnitName("target");
		local unitName = UnitName(target);
		if ( targetName ~= unitName ) then 
			TargetUnit(target);
			changedTarget = 1;
		end
	else
		TargetUnit(target);
		madeTarget = 1;
	end
	-- OneHitWonder_Print(format("%s should now be used on %s (%s)", buffName, UnitName(unit), unit));
	ok = OneHitWonder_CastSpell(id, spellbook);
	if ( ok ) then
		if( SpellIsTargeting() ) then
			SpellTargetUnit(target);
		end
		OneHitWonder_LastBuffed = GetTime();
	end		
	if (changedTarget) then
		TargetLastTarget()
	end
	if (madeTarget) then
		ClearTarget()
	end
end

function OneHitWonder_CleanSelf()
	local id = OneHitWonder_RetrieveCleansingSpellId("player");
	if ( id > -1 ) then
		local ok = OneHitWonder_CastSpell(id);
		if ( ok ) then
			SpellTargetUnit("player");
			return ok;
		end
	end
	return false;
end


function OneHitWonder_ExecuteCleanButton()
	local cleanList = {
		"target", "player", "pet", "party1", "party2", "party3", "party4"
	};
	if ( not OneHitWonder_buttonCleanList ) then
		OneHitWonder_buttonCleanList = cleanList;
	else
		local entry = table.remove(OneHitWonder_buttonCleanList);
		table.insert(OneHitWonder_buttonCleanList, entry);
	end
	local spellId = nil;
	for k, v in OneHitWonder_buttonCleanList do
		spellId = OneHitWonder_RetrieveCleansingSpellId(v);
		if ( spellId ) and ( spellId > -1 ) then
			if ( OneHitWonder_CastSpell(spellId) ) then
				return true;
			end
		end
	end
	return false;
end

function OneHitWonder_DumpEffects(unit)
	if ( not unit ) then return; end
	local effects = DynamicData.effect.getEffectInfos(unit);
	OneHitWonder_Print(format("DumpEffects for %s:", unit));
	for k, v in effects do
		OneHitWonder_Print(format("%s:", k));
		for key, effect in v do
			OneHitWonder_Print(format("%d. %s", key, effect.name));
		end
	end
end


function OneHitWonder_IsStringInListLoose(str, strList, loose)
	if ( not str ) then
		return false;
	end
	if ( not strList ) then
		return false;
	end
	if ( type(strList) ~= "table" ) then
		if ( type(str) == "table" ) then
			local tmp = str;
			str = strList;
			strList = tmp;
		else
			strList = { strList };
		end
	end
	if ( OneHitWonder_IsStringInList(str, strList) ) then
		return true;
	end
	if ( loose ) then
		for k, v in strList do
			if ( strfind(v, str ) ) then
				return true;
			end
			if ( strfind(str, v) ) then
				return true;
			end
		end
	end
	return false;
end

function OneHitWonder_IsUnitOfType(unit, typeList, loose)
	if ( not unit ) then
		return false;
	end
	if ( not typeList ) then
		return false;
	end
	if ( type(typeList) ~= "table" ) then
		typeList = { typeList };
	end
	local unitType = OneHitWonder_GetUnitType(unit);
	if ( not unitType ) then
		return false;
	end
	return OneHitWonder_IsStringInListLoose(unitType, typeList, loose);
end

function OneHitWonder_IsUnitNameInList(unit, nameList, loose)
	if ( not unit ) then
		return false;
	end
	if ( not nameList ) then
		return false;
	end
	if ( type(nameList) ~= "table" ) then
		nameList = { nameList };
	end
	local unitName = UnitName(unit);
	if ( not unitName ) then
		return false;
	end
	return OneHitWonder_IsStringInListLoose(unitName, nameList, loose);
end


function OneHitWonder_Target_Changed_CleanOld()
	local removeIndex = nil;
	local shouldContinue = true;
	while ( shouldContinue ) do
		removeIndex = nil;
		for k, v in OneHitWonder_ActionQueue do
			if ( v[1] == ONEHITWONDER_ACTIONID_SPELL_TARGET ) then
				local actionParameter = v[2];
				if ( actionParameter ) then
					local spellId = actionParameter[1];
					local unit = actionParameter[2];
					removeIndex = k;
					break;
				end
			end
		end
		if ( removeIndex ) then
			table.remove(OneHitWonder_ActionQueue, removeIndex);
		else
			break;
		end
	end
end

function OneHitWonder_Target_Changed()
	OneHitWonder_Attacking = false;
	OneHitWonder_UnitHealthLastCalled["target"] = nil;
	if ( TargetFrame.abilityApplied ) and ( false ) then
		for k, v in TargetFrame.abilityApplied do
			TargetFrame.abilityApplied[k] = 0;
		end
	end

	local i = 1;
	local data = nil;
	while ( i < table.getn(OneHitWonder_ActionQueue) ) do
		data = OneHitWonder_ActionQueue[i];
		if ( data[1] == ONEHITWONDER_ACTIONID_SPELL_TARGET ) then
			table.remove(OneHitWonder_ActionQueue, i);
		else
			i = i + 1;
		end
	end

	local func = getglobal(format("OneHitWonder_Target_Changed_%s", OneHitWonder_GetPlayerClass() ));
	if ( func ) then
		func();
	end
end

function OneHitWonder_RefreshEffects(unit)
	DynamicData.effect.initiateUpdateEffects(unit);
end

function OneHitWonder_InitiateRefreshEffects(unit) 
	OneHitWonder_ScheduleByName("REFRESHEFFECTS_"..unit, 1, OneHitWonder_RefreshEffects, unit);
end

-- Thanks to Verona, author of CustomTooltip, for introducing (inadvertently) me to UnitCreatureType.
function OneHitWonder_GetUnitType(unit)
	--[[
	if ( DynamicData ) and ( DynamicData.util ) and ( DynamicData.util.protectTooltipMoney ) then
		DynamicData.util.protectTooltipMoney();
	end 
	OneHitWonderTooltip:SetUnit(unit);
	if ( DynamicData ) and ( DynamicData.util ) and ( DynamicData.util.unprotectTooltipMoney ) then
		DynamicData.util.unprotectTooltipMoney();
	end 
	local text = OneHitWonderTooltipTextLeft2:GetText();
	return text;
	]]--
	return UnitCreatureType(unit);
end


function OneHitWonder_CastIfTargetNotHasEffect(spell, effect, stopCasting)
	return OneHitWonder_CastIfUnitNotHasEffect("target", spell, effect, stopCasting);
end

function OneHitWonder_CastIfUnitNotHasEffect(unit, spell, effect, stopCasting)
	if ( not OneHitWonder_CanSpellAffectUnit(spell, unit) ) then
		return false;
	end
	if ( effect ) then
		local effects = {};
		if ( type(effect) ~= "table" ) then
			effects = { effect };
		else
			effects = effect;
		end
		for k, v in effects do
			if ( OneHitWonder_HasUnitEffect(unit, nil, v) ) then
				return false;
			end
		end
	end
	return OneHitWonder_CastSpellSpecial(spell, stopCasting);
end

function OneHitWonder_CastSpellSpecial(spell, stopCasting)
	local spellId = -1;
	
	if ( type(spell) == "string" ) then
		spellId = OneHitWonder_GetSpellId(spell);
	elseif ( type(spell) == "number" ) then
		spellId = spell;
	else
		return false;
	end
	if ( OneHitWonder_IsSpellAvailable(spellId) ) then
		if ( stopCasting ) then
			SpellStopCasting();
		end
		return OneHitWonder_CastSpell(spellId);
	else
		return false;
	end
end

function OneHitWonder_CanAbilityAffectUnit(ability, unit)
	-- _print("OneHitWonder_CanAbilityAffectUnit")

	if ( not unit ) or ( strlen(unit) <= 0 ) or ( not UnitExists(unit) ) then
		return false;
	end
	
	if ( OneHitWonder_IsUnitImmuneToAbility(unit, ability) ) then
		return false;
	end
	
	local func = OneHitWonder_AbilityAffectToFunctionMap[ability];
	if ( not func ) then
		return true;
	else
		return func(unit);
	end
	return true
end

function OneHitWonder_GetHashForUnit(unit)
	if ( not unit ) or ( strlen(unit) <= 0 ) or ( not UnitExists(unit) ) then
		return "";
	end
	local creature = UnitName(unit);
	if ( not creature ) or ( strlen(creature) <= 0 ) then
		return "";
	end
	local cType = UnitCreatureType(unit);
	if ( not cType ) then
		return "";
	end
	return OneHitWonder_GetHashForString(creature)..OneHitWonder_GetHashForString(cType);
end

function OneHitWonder_WillUnitRunAway(unit)
	if ( not unit ) or ( strlen(unit) <= 0 ) or ( not UnitExists(unit) ) then
		return false;
	end
	if ( UnitCreatureType(unit) == ONEHITWONDER_CREATURE_TYPE_HUMANOID ) then
		return true;
	else
		return false;
	end;
	--[[
	local index1 = OneHitWonder_GetHashForUnit(unit);
	local index2 = ONEHITWONDER_UNIT_FLEE_STATE;
	if ( OneHitWonder_CreatureInfoTable ) and ( OneHitWonder_CreatureInfoTable[index1] ) and ( OneHitWonder_CreatureInfoTable[index1][index2] == 1 ) then
		return true;
	else
		return false;
	end
	]]--
end

function OneHitWonder_UnitWillRunAway(unit)
	local index1 = OneHitWonder_GetHashForUnit(unit);
	if ( strlen(index1) <= 0 ) then
		return;
	end
	local index2 = ONEHITWONDER_UNIT_FLEE_STATE;
	if ( not OneHitWonder_CreatureInfoTable ) then
		OneHitWonder_CreatureInfoTable = {};
	end
	if ( not OneHitWonder_CreatureInfoTable[index1] ) then
		OneHitWonder_CreatureInfoTable[index1] = {};
	end
	OneHitWonder_CreatureInfoTable[index1][index2] = 1;
end

function OneHitWonder_CanSpellAffectUnit(ability, unit)
	return OneHitWonder_CanAbilityAffectUnit(ability, unit);
end

function OneHitWonder_CanUnitBleed(unit)
	if ( OneHitWonder_IsUnitOfType(unit, OneHitWonder_NonBleedingMobTypes, true) ) then
		return OneHitWonder_IsUnitNameInList(unit, OneHitWonder_BleedingMobs, true);
	else
		if ( not OneHitWonder_IsUnitNameInList(unit, OneHitWonder_NonBleedingMobs, true) ) then
			return true;
		else
			return false;
		end
	end
end

function OneHitWonder_CanUnitBeRended(unit)
	if ( OneHitWonder_IsUnitOfType(unit, OneHitWonder_NonRendableMobTypes, true) ) then
		return OneHitWonder_IsUnitNameInList(unit, OneHitWonder_RendableMobs, true);
	else
		if ( not OneHitWonder_IsUnitNameInList(unit, OneHitWonder_NonRendableMobs, true) ) then
			return true;
		else
			return false;
		end
	end
end

function OneHitWonder_CanUnitBeDisarmed(unit)
	if ( OneHitWonder_IsUnitOfType(unit, OneHitWonder_NonDisarmableMobTypes, true) ) then
		return OneHitWonder_IsUnitNameInList(unit, OneHitWonder_DisarmableMobs, true);
	else
		if ( not OneHitWonder_IsUnitNameInList(unit, OneHitWonder_NonDisarmableMobs, true) ) then
			return true;
		else
			return false;
		end
	end
end

function OneHitWonder_CanUnitBeStunned(unit)
	if ( OneHitWonder_IsUnitOfType(unit, OneHitWonder_NonStunnableMobTypes, true) ) then
		return OneHitWonder_IsUnitNameInList(unit, OneHitWonder_StunnableMobs, true);
	else
		if ( not OneHitWonder_IsUnitNameInList(unit, OneHitWonder_NonStunnableMobs, true) ) then
			return true;
		else
			return false;
		end
	end
end

function OneHitWonder_CanUnitBePaused(unit)
	return OneHitWonder_CanUnitBeStunned(unit);
end

function OneHitWonder_CanUnitBePolymorphed(unit)
	-- TODO: Handle Hunter pets? Trouble said hers was sheeped...
	if ( UnitClass(unit) == ONEHITWONDER_CLASS_DRUID ) then
		local powerType = UnitPowerType(unit);
		if ( powerType == ONEHITWONDER_POWERTYPE_ENERGY ) or ( powerType == ONEHITWONDER_POWERTYPE_RAGE ) then
			return false;
		end
	end	
	if ( OneHitWonder_IsUnitOfType(unit, OneHitWonder_PolymorphableMobTypes, true) ) then
		if ( not OneHitWonder_IsUnitNameInList(unit, OneHitWonder_NonPolymorphableMobs, true) ) then
			return true;
		else
			return false;
		end
	else
		return OneHitWonder_IsUnitNameInList(unit, OneHitWonder_PolymorphableMobs, true);
	end
end

function OneHitWonder_CanUnitBePickpocketed(unit)
	if ( UnitIsPlayer(unit) ) then
		return false;
	end
	if ( not UnitCanAttack(unit, "player") ) then
		return false;
	end
	if ( UnitHealth(unit) < UnitHealthMax(unit) ) then
		return false;
	end
	if ( OneHitWonder_IsUnitNameInList(unit, OneHitWonder_PickpocketableMobs, true) ) then
		return true;
	end
	if ( OneHitWonder_IsUnitNameInList(unit, OneHitWonder_NonPickpocketableMobs, true) ) then
		return false;
	end
	--TODO: remove brute force fix
	if ( true ) then return true; end
	local creatureType = OneHitWonder_GetUnitType(unit);
	if ( ( creatureType ) and ( strlen(creatureType) > 0 ) ) then
		return OneHitWonder_IsUnitOfType(unit, OneHitWonder_PickpocketableTypes, true);
	else
		return true;
	end
end


OneHitWonder_AbilityAffectToFunctionMap = {
	[ONEHITWONDER_ABILITY_REND_NAME] = OneHitWonder_CanUnitBleed,
	[ONEHITWONDER_ABILITY_RUPTURE_NAME] = OneHitWonder_CanUnitBleed,
	[ONEHITWONDER_ABILITY_GARROTE_NAME] = OneHitWonder_CanUnitBleed,

	[ONEHITWONDER_TALENT_RIPOSTE_NAME] = OneHitWonder_CanUnitBeDisarmed,

	[ONEHITWONDER_ABILITY_PICKPOCKET_NAME] = OneHitWonder_CanUnitBePickpocketed,
	
	[ONEHITWONDER_ABILITY_CHEAPSHOT_NAME] = OneHitWonder_CanUnitBeStunned, 
	[ONEHITWONDER_ABILITY_KIDNEYSHOT_NAME] = OneHitWonder_CanUnitBeStunned, 
	
	[ONEHITWONDER_ABILITY_GOUGE_NAME] = OneHitWonder_CanUnitBePaused, 

	[ONEHITWONDER_SPELL_POLYMORPH_NAME] = OneHitWonder_CanUnitBePolymorphed, 
};


function OneHitWonder_IsUnitFacingMe(unit)
	return false;
end

function OneHitWonder_HasUnitBackTurned(unit)
	return false;
end


OneHitWonder_WeaponScannedAtTime = {};

function OneHitWonder_ScanWeapon(slotId)
	local curTime = GetTime();
	if ( DynamicData ) and ( DynamicData.item ) and ( DynamicData.item.scanItem ) then
		DynamicData.item.scanItem(-1, slotId, DYNAMICDATA_ITEM_SCAN_TYPE_TOOLTIP);
	end
	OneHitWonder_WeaponScannedAtTime[slotId] = curTime;
end

function OneHitWonder_HasItemEffect(effectNames, slotId, useBlizzardFunc)
	if ( useBlizzardFunc ) then
		local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo();
		if ( ( slotId == 16 ) and ( not hasMainHandEnchant ) ) or 
			( ( slotId == 17 ) and ( not hasOffHandEnchant ) ) then
			return false;
		end
	end
	local curTime = GetTime();
	if ( ( not OneHitWonder_WeaponScannedAtTime[slotId] ) or ( OneHitWonder_WeaponScannedAtTime[slotId] + ONEHITWONDER_SCAN_WEAPON_EVERY_SECONDS < curTime ) ) then
		OneHitWonder_ScanWeapon(slotId);
	end
	local itemInfo = nil;
	if ( DynamicData ) and ( DynamicData.item ) and ( DynamicData.item.getEquippedSlotInfo ) then
		itemInfo = DynamicData.item.getEquippedSlotInfo(slotId);
	end
	if ( not itemInfo ) then
		return true;
	end
	local hasEffect = false;
	if ( ( itemInfo ) and ( strlen(itemInfo.name) > 0 ) ) then
		if ( itemInfo.strings ) then
			for k, v in itemInfo.strings do
				if ( v.left ) then
					if ( type(effectNames) ~= "table" ) then
						if ( strfind(v.left, effectNames) ) then
							hasEffect = true;
						end
					else
						if ( OneHitWonder_IsStringInListLoose(v.left, effectNames, true) ) then
							hasEffect = true;
						end
					end
					if ( hasEffect ) then
						break;
					end
				end
			end
		end
	end
	return hasEffect;
end

function OneHitWonder_KeepUpWeaponSpell(spellName, effectNames, slotId, canCast)
	local spellId = OneHitWonder_GetSpellId(spellName);
	-- YZLib.dbg.debug2(1,"spellId="..tostring(spellId));
	if( spellId <= -1 ) then
		return false;
	end
	if ( OneHitWonder_HasPlayerEffect(nil, ONEHITWONDER_DISARM_EFFECTS ) ) then
		-- YZLib.dbg.debug2(1,"disarmed!");
		return false;
	end
	local itemInfo = nil;
	if ( DynamicData ) and ( DynamicData.item ) and ( DynamicData.item.getEquippedSlotInfo ) then
		itemInfo = DynamicData.item.getEquippedSlotInfo(slotId);
		-- YZLib.dbg.debug2(1,"itemInfo="..tostring(itemInfo));
	end
	if ( not itemInfo ) or ( not itemInfo.name ) or ( strlen(itemInfo.name) <= 0 ) or ( itemInfo.name == ONEHITWONDER_MAIN_HAND_NAME ) then
		-- YZLib.dbg.debug2(1,"item not compatible");
		return false;
	end
	if ( ( itemInfo ) and ( strlen(itemInfo.name) > 0 ) ) then
		if ( itemInfo.itemType == TEXT(ONEHITWONDER_ITEM_TYPE_SHIELD) ) then
			-- YZLib.dbg.debug2(1,"shield sux");
			return false;
		end
		
		if ( not OneHitWonder_HasItemEffect(effectNames, slotId) ) then
			if ( canCast ) then
				return OneHitWonder_CastSpell(spellId);
			else
				OneHitWonder_AddActionToQueue(ONEHITWONDER_ACTIONID_SPELL, spellId);
				return true;
			end
		end

	end
	return false;
end

function OneHitWonder_Loot()
	local slot = 1;
	if ( GetNumLootItems() > slot ) and ( ( LootSlotIsItem(slot) ) or ( LootSlotIsCoin(slot) ) ) then
		LootSlot(slot);
		return true;
	end
	return false;
end

function OneHitWonder_IsUnitTeamMember(unit)
	if ( not unit ) then
		return false;
	end
	if ( strfind(unit, "party") ) or ( unit == "player" ) or ( unit == "pet" ) then
		return true;
	end
	return false;
end

function OneHitWonder_Binding_Toggle(varName, chatEnabled, chatDisabled)
	local oldValue = getglobal(varName);
	if (oldValue) then
		setglobal(varName, false);
		OneHitWonder_Print(chatDisabled);
	else
		setglobal(varName, true);
		OneHitWonder_Print(chatEnabled);
	end
end

function OneHitWonder_UnitIsEliteOrBetter(unit)
	if ( not UnitExists(unit) ) then
		return false;
	end
	if ( UnitClassification(unit) == ONEHITWONDER_MOB_CLASSIFICATION_NORMAL ) then
		return false;
	end
	return true;
end

function OneHitWonder_UnitIsBossOrBetter(unit)
	if ( not UnitExists(unit) ) then
		return false;
	end
	if ( UnitClassification(unit) == ONEHITWONDER_MOB_CLASSIFICATION_WORLDBOSS ) then
		return true;
	end
	return false;
end


function OneHitWonder_InBossMode()
	return getglobal("ONEHITWONDER_BOSSMODE");
end

function OneHitWonder_CastSpellOnTarget(spellId, spellBook)
	spellBook = OneHitWonder_GetSpellBook(spellBook);
	local spellInfo = DynamicData.spell.getSpellInfo(spellId, spellBook);
	if ( not OneHitWonder_CanSpellAffectUnit(spellInfo.name, "target") ) then
		return false;
	end
	return OneHitWonder_CastSpell(spellId, spellBook);
end

OneHitWonder_AllowStackingAbilities = 1;

function OneHitWonder_HasTargetMyAbility(abilityName, effectName)
	if ( not effectName ) then 
		effectName = abilityName;
	end
	if ( not OneHitWonder_HasUnitEffect("target", nil, effectName) ) then
		return false;
	else
		if ( OneHitWonder_AllowStackingAbilities ~= 1 ) then
			return false;
		end
	end
	local index = OneHitWonder_GetAbilityStringIndex(abilityName);
	if ( not index ) then
		return false;
	end
	if ( not TargetFrame.abilityApplied ) then
		TargetFrame.abilityApplied = {};
	end
	local timeEnds = TargetFrame.abilityApplied[index];
	if ( not timeEnds ) or ( timeEnds == 0 ) then
		return false;
	elseif ( timeEnds == -1 ) then
		return true;
	else
		local curTime = GetTime();
		if ( ( timeEnds - curTime ) > 0 ) then
			return true;
		else
			TargetFrame.abilityApplied[index] = 0;
			return false;
		end
	end
end

function OneHitWonder_ApplyMyAbilityToTarget(abilityName, duration)
	if ( not abilityName ) then
		return;
	end
	if ( not TargetFrame.abilityApplied ) then
		TargetFrame.abilityApplied = {};
	end
	local curTime = GetTime();
	local index = OneHitWonder_GetAbilityStringIndex(abilityName);
	if ( not index ) then
		return;
	end
	if ( duration ) and ( duration > 0 ) then
		TargetFrame.abilityApplied[index] = duration+curTime;
	else
		TargetFrame.abilityApplied[index] = -1;
	end
end

function OneHitWonder_Binding_Cycle_WeaponBuff()
	local class = OneHitWonder_GetPlayerClass();
	if ( not class ) then
		return;
	end
	local func = getglobal(string.format("OneHitWonder_Cycle_WeaponBuff_%s", class));
	if ( func ) then
		func(true);
	end
end

function OneHitWonder_IsUnitValidToClean(unit)
	if ( ( strfind(unit, "party" ) ) or ( unit == "player" ) or ( unit == "pet" ) ) then
		return true;
	else
		return false;
	end
end


-- Will not cast HoT on unit if the buff still has X seconds left
ONEHITWONDER_HOT_TIME_PREVENTION = 2;

ONEHITWONDER_HOT_SPELL = nil;

ONEHITWONDER_HOT_SPELLS = {
	[ONEHITWONDER_SPELL_RENEW_NAME] = 15,
	[ONEHITWONDER_SPELL_REJUVENATION_NAME] = 12,
	-- ADD MORE!
};

function OneHitWonder_CanHoT()
	for k, v in ONEHITWONDER_HOT_SPELLS do
		if ( OneHitWonder_GetSpellId(k) > -1 ) then
			return true;
		end
	end
	return false;
end

OneHitWonder_HoTList = {
};

function OneHitWonder_ShouldHoTUnit(unit, spellName, hotDuration)
	local name = UnitName(unit);
	if ( not OneHitWonder_HoTList[name] ) then
		return true;
	elseif ( not OneHitWonder_HoTList[name][spellName] ) then
		return true;
	else
		if ( OneHitWonder_HasUnitEffect(unit, nil, spellName) ) then
			local curTime = GetTime();
			if ( ( curTime - OneHitWonder_HoTList[name][spellName] ) > (hotDuration-ONEHITWONDER_HOT_TIME_PREVENTION) ) then
				return true;
			else
				return false;
			end
		else
			return true;
		end
	end
end

-- returns true if a spell was cast, otherwise false
function OneHitWonder_HoTUnit(unit)
	if ( not unit ) or ( not UnitExists(unit) ) then
		return false;
	end
	if ( UnitCanAttack(unit, "player") ) then
		unit = "player";
		--return false;
	end
	if ( UnitIsUnit(unit, "player") ) then
		unit = "player";
	end
	local chosenSpell = nil;
	local chosenDuration = 0;
	if ( ONEHITWONDER_HOT_SPELL ) then
		chosenSpell = ONEHITWONDER_HOT_SPELL;
		chosenDuration = ONEHITWONDER_HOT_SPELLS[ONEHITWONDER_HOT_SPELL];
	else
		for k, v in ONEHITWONDER_HOT_SPELLS do
			if ( OneHitWonder_GetSpellId(k) > -1 ) and ( OneHitWonder_ShouldHoTUnit(unit, k, v) ) then
				ONEHITWONDER_HOT_SPELL = k;
				chosenSpell = k;
				chosenDuration = v;
				break;
			end
		end
	end
	if ( chosenSpell ) then
		local spellId = OneHitWonder_GetAppropriateSpellId(UnitLevel(unit), chosenSpell);
		if ( not UnitCanAttack("target", "player") ) then
			if ( unit == "player" ) then
				local actionId = OneHitWonder_GetActionIdFromSpellId(spellId);
				if ( actionId ) and ( actionId > -1 ) then
					UseAction(actionId, 0, 1);
					return true;
				end
			end
			return false;
		end
		if ( OneHitWonder_CastSpell(spellId) ) then
			SpellTargetUnit(unit);
			local name = UnitName(unit);
			if ( not OneHitWonder_HoTList[name] ) then
				OneHitWonder_HoTList[name] = {};
			end
			OneHitWonder_HoTList[name][chosenSpell] = GetTime();
		end
	end
	return false;
end

OneHitWonder_HoTTimeList = { "player", "party1", "party2", "party3", "party4" };

OneHitWonder_PreEmptiveCandidates = { ONEHITWONDER_CLASS_WARRIOR, ONEHITWONDER_CLASS_PALADIN };

function OneHitWonder_PreEmptiveHoTCandidate(unit)
	if ( unit == "target" ) or (OneHitWonder_IsStringInList(UnitClass(unit), OneHitWonder_PreEmptiveCandidates)) then
		return true;
	else
		return false;
	end
end

function OneHitWonder_HoTTime()
	if ( not OneHitWonder_CanHoT() ) then
		return false;
	end
	local loops = 0;
	local currentEntry = nil;
	local hasCast = OneHitWonder_HoTUnit("target");
	while ( not hasCast ) and ( loops < table.getn(OneHitWonder_HoTTimeList) ) do
		currentEntry = table.remove(OneHitWonder_HoTTimeList);
		table.insert(OneHitWonder_HoTTimeList, currentEntry);
		if ( UnitHealth(currentEntry) < UnitHealthMax(currentEntry) ) or ( OneHitWonder_PreEmptiveHoTCandidate(currentEntry) ) then
			hasCast = OneHitWonder_HoTUnit(currentEntry);
		end
		loops = loops + 1;
	end
	return hasCast;
end

function OneHitWonder_ExecuteHoTButton()
	OneHitWonder_HoTTime();
end

function OneHitWonder_HoTInCombat()
	local inCombat = OneHitWonder_IsInCombat()
	if ( inCombat == 1 ) and ( OneHitWonder_HoTTime() ) then
		return true;
	else
		return false;
	end
end

function OneHitWonder_Generic_CosmosUpdateCheckOnOff(varName, value)
	if ( not Cosmos_UpdateValue ) then
		return;
	end
	local name = varName;
	if ( ( not name ) or ( strlen(name) <= 0 ) ) then
		return
	end
	if ( strfind(name, "_X" ) ) then
		name = strsub(name, 1, strlen(name)-2);
	end
	if ( ( name ) and ( strlen(name) > 0 ) ) then
		Cosmos_UpdateValue(name, CSM_CHECKONOFF, value);
	end
	if ( CosmosMaster_DrawData ) then
		CosmosMaster_DrawData();
	end
end

function OneHitWonder_Generic_CosmosUpdateValue(varName, value)
	if ( not Cosmos_UpdateValue ) then
		return;
	end
	local name = varName;
	if ( ( not name ) or ( strlen(name) <= 0 ) ) then
		return
	end
	if ( strfind(name, "_X" ) ) then
		name = strsub(name, 1, strlen(name)-2);
	end
	if ( ( name ) and ( strlen(name) > 0 ) ) then
		Cosmos_UpdateValue(name, CSM_SLIDERVALUE, value);
	end
	if ( CosmosMaster_DrawData ) then
		CosmosMaster_DrawData();
	end
end

function OneHitWonder_IsInCombat(considerHate)
	if considerHate == nil then
	    considerHate = 1
	end
	if ( PlayerFrame.inCombat == 1 ) then
		return true;
	elseif UnitAffectingCombat("player") then
	    return true
	else
		if ( considerHate ) then 
			if ( PlayerFrame.onHateList == 1 ) then
				return true;
			end
		end
		return false;
	end
end

function OneHitWonder_UnitAliveEnemy(unit)
	if ( UnitExists(unit) ) then
		if ( not UnitIsDead(unit) ) and ( UnitCanAttack(unit, "player") and (UnitReaction(unit, "player") == 2 or UnitAffectingCombat(unit) )) then
			return true;
		else
			return false;
		end
	else
		return false;
	end
end

function OneHitWonder_TargetAliveEnemy()
	return OneHitWonder_UnitAliveEnemy("target");
end

-- Kinesia. Added to prevent OHW being so "enthusiastic" where tabbing to a new target
-- frequently launched an attack
function OneHitWonder_StartCombat()
	--_print(format("OneHitWonder_InitiateCombat %d",OneHitWonder_InitiateCombat))
	--_print(format("OneHitWonder_TargetAliveEnemy %s",tostring(OneHitWonder_TargetAliveEnemy())))
	--_print(format("OneHitWonder_IsIncombat %s",tostring(OneHitWonder_IsInCombat())))
	--_print(format("Unit_Reaction %s",tostring(UnitReaction("target","player"))))
	--_print(format("UnitAffectingcombat %s",tostring(UnitAffectingCombat("target"))))
	if (( OneHitWonder_InitiateCombat == 0 ) or UnitIsCivilian("target")) and ( not OneHitWonder_IsInCombat() ) then
		return false;
	end
	return true
end


function OneHitWonder_FindMostDamagingWeapon(weapons)
	local highestAverageDamage = 0;
	local highestIndex = 1;
	local damageMin, damageMax = nil, nil;
	local averageDamage = 0;
	for k, v in weapons do
		if ( v.strings ) then
			if ( DynamicData.util.isItemNotBindOnAnything(v.strings) ) then
				damageMin, damageMax = DynamicData.util.getDamage(v.strings);
				if ( damageMin ) and ( damageMax ) then
					averageDamage = ( damageMax + damageMin ) / 2;
					if ( averageDamage > highestAverageDamage ) then
						highestAverageDamage = averageDamage;
						highestIndex = k;
					end
				end
			end
		end
	end
	return weapons[highestIndex];
end

function OneHitWonder_InCombatWithMoreThanOneOpponent()
	-- TODO: implement chat monitoring, damage within 10 secs from sources written + current target > 1 then return true.
	if ( OneHitWonder_GetNumberOfAttackingEntities() > 1 ) then
		return true;
	end
	return false;
end

if ( Chronos ) and ( Chronos.schedule ) then
	OneHitWonder_Schedule = Chronos.schedule;
elseif ( Cosmos_Schedule ) then
	OneHitWonder_Schedule = Cosmos_Schedule;
end
if ( Chronos ) and ( Chronos.scheduleByName ) then
	OneHitWonder_ScheduleByName = Chronos.scheduleByName;
elseif ( Cosmos_ScheduleByName ) then
	OneHitWonder_ScheduleByName = Cosmos_ScheduleByName;
end

