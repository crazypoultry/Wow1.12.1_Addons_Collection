--=============================================================================
-- File:	ClickHeal.lua
-- Author:	rudy
-- Description:	The healing part
--=============================================================================


--=============================================================================
-- Variables:

      CH_Version = 14900;		-- 1.01.00
      CH_VersionSaveFile = nil;

      CH_ScriptUnit = nil;		-- initalized every time before RunScript is executed

      CH_MAX_PARTY_MEMBERS = 4;
      CH_MAX_RAID_MEMBERS = 40;
      CH_MAX_RAID_GROUPS = 8;
      CH_MAX_RAID_GROUP_MEMBERS = 5;
      CH_MAX_RAID_PETS = 10;

local POWER_MANA = 0;
local POWER_RAGE = 1;
local POWER_FOCUS = 2;
local POWER_ENERGY = 3;
local POWER_HAPPINESS = 4;

local CH_UNIT_FRAME_UPDATE_INTERVAL_NON_CRITICAL = 0.5;		-- update "non critical" frames every 0.5 seconds

local CH_MAX_ACTION_SLOTS = 120;

local INVENTORY_SLOTS = { "HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot", "TabardSlot", "WristSlot",
                          "HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot",
                          "MainHandSlot", "SecondaryHandSlot", "RangedSlot", "AmmoSlot"
                        };

      CH_MAX_BUFFS = 12;	-- buffs in display and tooltip/popup
local CH_BUFF_REFRESH_MISSING = -200000;	-- only valid at Refresh Buff!!
local CH_BUFF_REFRESH_UNKNOWN = 0;		-- only valid at Refresh Buff!!
local CH_BUFF_GRACE_PERIOD = 0.5;		-- milliseconds, time where buff stays in 'warn' when still active but already expired due to calculations
      CH_BUFF_POPUP_AUTOCLOSE = 0.1;		-- time in seconds
      CH_BuffPopupCloseTime = 0;		-- time when popup should close (or 0)

      CH_MAX_UNIT_DEBUFFS = 16;	-- max number of debuffs shown for one particular unit

local gSeenDebuffs = {};	-- list with seen debuffs gSeenDebuffs = { debuffName = {canCast=bool,lastSeen=time}, ... } 
local gSeenDebuffsCount = 0;	-- how many elems in list
local MAX_SEEN_DEBUFFS = 20;	-- max entries in gSeenDebuffs
local KEEP_SEEN_DEBUFFS = 1800; -- keep seen debuffs for 30 minutes (1800 seconds)

      CH_SpellMap = nil;        -- mapping for spellName to spellId  {spellName = {1=id,2=id,MAX=id},... }
      CH_DistinctSpells = nil;	-- mapping with distinct spells (spellname only once, same order as book) {idx=spellName}

      CH_Spells =  { };		-- { QUICK/SLOW/LeftButton/PWF = { spellName=nil, spellRank=nil, spellBookIdx=nil, manaCost=nil } }, ...

      CH_BuffData = {};		-- {buffIdx={classes={},units={},enabled=bool,priority=int,castable=bool}, ... }
      CH_BuffPriority = {};	-- {prio=buffIdx, ...}
      CH_BuffDataLookup = {};	-- {spellName=buffIdx, ..}		-- NOTE: also includes partySpell reference
local gBuffLastWarnFeedback = 0;	-- time of last userfeedback of buff warns
local gBuffLastExpireFeedback = 0;	-- time of last userfeedback of buff expires
local BUFF_FEEDBACK_DELAY = 3;		-- time in second

      CH_ActionList = {};		-- Initialized in InitVars, because of function variables
      CH_ActionListSort = {};		-- see above (CH_ActionList)

      CH_MouseSpells = nil;		-- {Panic|Enemy|Friend|Extra1={LefButton='QUICK',AltRightButton='SPELL',CtrlMiddleButton='HOT',...},.. }
      CH_MouseSpellsData = nil;		-- {Panic|Enemy|Friend|Extra1={LeftButton='Info',AltRightButton='Info',} ...}
      CH_ChainData = nil;		-- {Chain1|Chain2 = {LeftButton={frequency=,condition=}, .. }, .. }
      CH_TotemSetData = nil;		-- {set#={totem#={name,spellID,wait},resetSeconds,lastCastTime,nextTotem}, ...}

      CH_ActionBar = {};		-- {ActionBarName(Spell/macro/...) = {slot=,}, ... }

      CH_MAX_TOTEM_SETS = 6;

      CH_MAX_CHAINS = 4;
      CH_MAX_LINES_CHAIN = 10;

local BLACKLIST_DURATION = 5;
local gBlacklist = {};

local gDPS = { };
local gDPSCurr = { };
local gDPSRecent = { };

local DPS_MEMORY = 11;
local DPS_RECENT = 5;

local gPetVisibility = { pet=false, partypet1=false, partypet2=false, partypet3=false, partypet4=false };

local gUnitEffects = {};		-- { PlayerName|petUnit={buffIdx={startime,..},lastUpdate=TIME,isPlayer=BOOL}, .. }
local EFFECT_EXPIRATION = 1;		-- when effect data expires (needs to be recalculated). in seconds

local gCSNextName = nil;		-- the spell to be cast (CastSpell(), CastSpellByName() )
local gCSNextRank = nil;
local gCSNextTargetUnit = nil;
local gCSNextTargetName = nil;
local gCSName = nil;
local gCSRank = nil;
local gCSStartTime = nil;
local gCSDuration = nil;
local gCSDisruptionTime = nil;
local gCSIsChanneling = nil;
local gCSIsCasting = nil;		-- currently casting (or channeling) a spell
local gCSTargetUnit = nil;		-- the unit on which the current spell is cast on. ONLY valid if gCSName ~= nil!
local gCSTargetName = nil;
local gCSPrevName = nil;		-- name of previous (last) spell
local gCSPrevRank = nil;
local gCSPrevStartTime = nil;
local gCSPrevEndTime = nil;
local gCSPrevTargetUnit = nil;
local gCSPrevTargetName = nil;
local gCSPrevEndState = nil;		-- how it finished (one of INTERRUPTED, FAILED, STOP, CHANNEL);
local gCSPrevDuration = nil;

      CH_Config = nil;			-- initiated in InitVars()

local gRoundRobinRaidIdx = 1;			-- scan the raid in PANIC, in batches
local gRaidMemberMap = {};			-- array with mapping raid member name -> raid unit

      CH_CooldownWatchList = nil;		-- init in InitVars
local gCooldownBagWatchList = {};		-- dynamic list, BAG_UPDATE_COOLDOWN = {cdStart*1000 = {cdStart,cdDuration,cdEnd,texture}}
      CH_MAX_COOLDOWN_ICONS = 10;		-- WARN: This is not the max size of CH_CooldownWatchList, but the numer of icons displayed next to PANIC!!

      CH_MesmerizeWatchList = {};		-- { UnitName = {SHAKLE|SHEEP = {startTime=N,duration=N}, ... }, ... }
      CH_MAX_MESMERIZE_WATCH = 5;

      CH_PluginList = {};			-- { plugin(sub)ID = pluginOjbect, ... }
      CH_PluginListSort = {};			-- "sorted" plugin list, with numerical indexes {n=PluginActionID}

      CH_Overheal = {};				-- { QUICK|SLOW = { 1 = {spellID1,spellName1,spellRank1,manaCost,minHeal,maxHeal,healWindow}, ..., n = size }, ... }
local CH_OverhealOld = nil;			-- when initializing spells, briefly remember old data for restore of mana (spirit of redemption, omen of clarity)

local gPlayerHitSoundPlayTime = 0;			-- Last time hit sound was played
local gAnnounceHitToPartyPlayTime = 0;			-- Last time hit was announced to party
local gAnnounceOOMToPartyPlayTime = 0;			-- Last time oom was announced to party

      CH_TooltipFrameIndex = nil;			-- the index of the frame the tooltip is hovering over (player, pettarget, extra1)
      CH_TooltipVisible = false;			-- tooltip visible?

local gPlayerActiveMelee = false;			-- if player is in active combat (melee) PLAYER_ENTER/LEAVE_COMBAT
local gPlayerActiveAutoShot = false;			-- if player is in active combat (auto shot) checked via ActionBar events
local gPlayerPendingAttack = false;
local gPlayerRestartCombat = nil;			-- restart the combat (e.g. after targeting), {attackType=MELEE/AUTOSHOT/DELAYED,time=time,delay=sec}

local gWandActionBarSlot = -1;				-- The action slot where the wand OR bow is stored

local gPlayerCanCastTrackingBuff = false;		-- true if the player can cast tracking buff

local gOriginalFunction = {};				-- { functionName = originalFunc, ...}

local gLastUsedBagItem = {bag=0,slot=0,useTime=0};	-- masked UseContainerItem()

local gUnitManaRegain = nil;				-- how much regained in last tick
local gUnitManaLast = 0;				-- mana of last tick

local gLastUsedAction = {slot=-1,useTime=0,checkCursor=nil,onSelf=nil};		-- last used action

      CH_MAX_MAIN_TANKS = 10;
      CH_MainTanks = {};				-- array with main tanks {[n] = "NameOfTank, ..}
local gMainTankUnit = {};				-- mapping of mtIdx->unit

local gNotifyCustomChannelJoinTime = 0;			-- when to join the new notifyCustomChannel (delayed join)

local gWowHidePartyInterface = nil;			-- value of WoW's HIDE_PARTY_INTERFACE, to detect changes

      CH_Anchor = nil;					-- list with how anchors are anchored
local gAnchorIsRedocking = false;			-- if anchors are just redocking
local gAnchorNeedRedock = false;			-- if anchors should be redocked (in next main loop, to avoid double run)
local gAnchorIsMoving = false;				-- if one of the anchors is moving (if yes, show all other)

local gFirstMainLoop = true;				-- if the main loop is executed for the first time (post-load initialization possibilities)

local gPlayerIsInBattlefield = false;			-- if the player is in a battlefield
local gPlayerIsInBattlefieldLastUpdate = 0;		-- when info had been last updated

      CH_HealRange = {};				-- unitName[PET]={range=int,timeAdded=time}
local gHealRangeActionSlot = -1;			-- action slot number where the spell for checking is located
local gHealRangeIsScanning = false;			-- currently scanning?

local gSilentTarget = false;				-- silenty untarget a unit (see CH_ClearTargetSilently() )

      CH_MAX_NEEDY_LIST_MEMBERS = 20;			-- max members per list

local gNeediestHeal = {};				-- list with neediest heal {n=unit,...}
local gIsPanicHealing = nil;				-- currently panic healing, only call this once! (e.g. fast clicks)

local gNeedyList = { HEAL = {wipe=0,lastScan=0,		-- data for needyList
                             isProcessing=false},
                     CURE = {wipe=0,lastScan=0,
                             isProcessing=false},
                     BUFF = {wipe=0,lastScan=0,
                             isProcessing=false},
                     DEAD = {wipe=0,lastScan=0,
                             isProcessing=false},
                   };

      CH_SpiritualGuidance = 0;				-- rank of spiritual guidance, if any

local gcMemInitial = nil;
local gcMemLastSec = nil;
local gcMemTimeInitial = 0;
local gcMemLastUpdate = 0;

-- ==========================================================================================================================
-- Message output
-- ==========================================================================================================================

local function CH_MsgFormat( msg )

  if ( msg == nil ) then
    msg = 'NIL';
  elseif ( type(msg) == 'boolean' and msg == true ) then
    msg = 'TRUE';
  elseif ( type(msg) == 'boolean' and msg == false ) then
    msg = 'FALSE';
  elseif ( type(msg) == 'table' ) then
    msg = '[table]';
  elseif ( type(msg) == 'function' ) then
    msg = '[function]';
  end

  return( msg );

end

function CH_Msg(msg)

  msg = CH_MsgFormat( msg );
  
  if ( DEFAULT_CHAT_FRAME ) then
     DEFAULT_CHAT_FRAME:AddMessage( "[CH] "..msg, 0.0, 1.0, 0.0 );
  end

end

function CH_Debug( msg, level )

  local dLevel;
  local color = 'YELLOW';

  if ( level == nil ) then
    level = CH_DEBUG_DEBUG;
  end

  if ( (not CH_Config) or (not CH_Config.debugLevel) ) then
    dLevel = CH_DEBUG_WARNING;
  else
    dLevel = CH_Config.debugLevel;
  end

  if ( dLevel == CH_DEBUG_NONE or level > dLevel ) then
    return;
  end

  msg = CH_MsgFormat( msg );

  if ( DEFAULT_CHAT_FRAME ) then
     if ( level <= CH_DEBUG_ERR ) then
       color = 'RED';
     elseif ( level <= CH_DEBUG_NOTICE ) then
       color = 'ORANGE';
     else
       color = 'YELLOW';
     end
     DEFAULT_CHAT_FRAME:AddMessage( "[CH-"..CH_DebugLevels[level].."] "..msg, CH_COLOR[color].r, CH_COLOR[color].g, CH_COLOR[color].b );
  end

end

function CH_Dbg( msg, level )

  CH_Debug( msg, level );

end


-- ==========================================================================================================================
-- Memory Usage 
-- ==========================================================================================================================

function CH_MemoryUsage()

  local gcMemNow,gcMemMax = gcinfo();
  local gcTimeNow = GetTime();
  local gcLast;

  if ( not gcMemInitial ) then
    gcMemInitial = gcMemNow;
    gcMemLastSec = gcMemNow;
    gcTimeInitial = gcTimeNow;
    gcMemLastUpdate = gcTimeNow;
  end

  if ( gcMemNow < gcMemLastSec ) then
    gcMemInitial = gcMemNow;
    gcTimeInitial = gcTimeNow;
    gcMemLastSec = gcMemNow;
  end

  gcLast = ceil( gcTimeNow - gcTimeInitial );

  if ( gcMemLastUpdate <= gcTimeNow - 1 ) then
    CH_Dbg( 'last: '..string.format("%2.3f",(gcMemNow-gcMemLastSec)/(gcTimeNow-gcMemLastUpdate))..
            ', overall: '..string.format("%2.3f",(gcMemNow-gcMemInitial)/(gcTimeNow-gcTimeInitial))..' k/s'..
            ', abs: '..gcMemNow..'/'..gcMemMax..
            ', last gc: -'..floor(gcLast/60)..':'..string.format("%02d",mod(gcLast,60))..
            ', fsp: '..string.format("%3.2f",GetFramerate()) );
    gcMemLastUpdate = gcTimeNow;
    gcMemLastSec = gcMemNow;
  end

end

-- ==========================================================================================================================
-- Array 
-- ==========================================================================================================================

function CH_ArrayInit()

  return( nil );

end

function CH_ArrayAdd( arr, elem )

  if ( arr ) then
    return( arr..'#'..elem );
  end

  return( elem );

end

function CH_ArrayGet( arr, idx )

  local sep = "#";
  local pos = 1;
  local len = strlen( arr );
  local copy = '';
  local char = nil;
  local currIdx = 1;
  local found = false;

  while ( pos <= len and currIdx <= idx ) do
    char = strsub( arr, pos, pos );
    if ( char == sep ) then
      currIdx = currIdx + 1;
    elseif ( currIdx == idx ) then
      found = true;
      copy = copy .. char;
    end
    pos = pos + 1;
  end

  if ( found ) then
    return( copy );
  end

  return( nil );

end

function CH_ArrayNext( arr, iterPos )

  iterPos = (iterPos or 1);

  local len = strlen( arr );
  local sep = '#';
  local startIterPos = iterPos;

  if ( iterPos < 1 or iterPos > len ) then
    return nil, iterPos;
  end

  char = strsub( arr, iterPos, iterPos );
  while ( iterPos <= len and char ~= sep ) do
    iterPos = iterPos + 1;
    char = strsub( arr, iterPos, iterPos );
  end

  if ( char == sep ) then
    return strsub(arr,startIterPos,iterPos-1), iterPos+1;
  end

  return strsub(arr,startIterPos), iterPos;

end

-- ==========================================================================================================================
-- Helper Methods
-- ==========================================================================================================================

function CH_CheckVersion()

  if ( CH_VersionSaveFile ~= nil and CH_VersionSaveFile < 12803 ) then
    CH_ConfigReset( 'ALL', 'ALL' );
  end

  if ( CH_VersionSaveFile ~= nil and CH_VersionSaveFile < 12900 ) then
    local buffIdx;

    if ( CH_CooldownWatchList[20] == nil ) then
      CH_CooldownWatchList[20] = {spellName='None',bookType=nil,spellID=-1};
    end

    for buffIdx,_ in CH_BuffData do
      if ( CH_BUFF_DATA[buffIdx].partySpellName and CH_BuffData[buffIdx].partySpellPrefer == nil ) then
        CH_BuffData[buffIdx].partySpellPrefer = 3;
        CH_BuffData[buffIdx].partySpellUpgrade = true;
      end
    end
  end

  if ( CH_VersionSaveFile ~= nil and CH_VersionSaveFile < 13000 ) then
    local idx, mb;
    for idx in CH_MouseSpells do
      for mb in CH_MouseSpells[idx] do
        if ( CH_MouseSpells[idx][mb] == 'BUFF' ) then
          CH_MouseSpellsData[idx][mb] = 'AUTOMATIC';
        elseif ( CH_MouseSpells[idx][mb] == 'GRPBUFF' ) then
          CH_MouseSpellsData[idx][mb] = 'REFRESH_TIME';
        elseif ( CH_MouseSpells[idx][mb] == 'PETATTACK' ) then
          CH_MouseSpellsData[idx][mb] = {action='NONE',condition='NONE'};
        end
      end
    end
  end

  if ( CH_VersionSaveFile ~= nil and CH_VersionSaveFile < 13100 ) then
    if ( CH_CLASS_INFO[CH_UnitClass('player')].shapeshift ) then
      CH_ConfigReset( 'ENEMY', 'MOUSE', 'ALL' );
    end
  end

  if ( CH_VersionSaveFile ~= nil and CH_VersionSaveFile < 13101 ) then
    if ( CH_CLASS_INFO[CH_UnitClass('player')].shapeshift ) then
      CH_MouseSpells['Enemy'] = nil;
      CH_MouseSpellsData['Enemy'] = nil;
    end
  end

  if ( CH_VersionSaveFile ~= nil and CH_VersionSaveFile < 13502 ) then
    local idx, mb;
    for idx in CH_MouseSpells do
      for mb in CH_MouseSpells[idx] do
        if ( CH_MouseSpells[idx][mb] == 'BUFF' and 
             (CH_MouseSpellsData[idx] == nil or CH_MouseSpellsData[idx][mb] == nil or type(CH_MouseSpellsData[idx][mb]) ~= 'string') ) 
        then
          CH_MouseSpellsData[idx][mb] = 'AUTOMATIC';
        elseif ( CH_MouseSpells[idx][mb] == 'GRPBUFF' and 
                 (CH_MouseSpellsData[idx] == nil or CH_MouseSpellsData[idx][mb] == nil or type(CH_MouseSpellsData[idx][mb]) ~= 'string') ) 
        then
          CH_MouseSpellsData[idx][mb] = 'REFRESH_TIME';
        elseif ( CH_MouseSpells[idx][mb] == 'PETATTACK' and 
                 (CH_MouseSpellsData[idx] == nil or CH_MouseSpellsData[idx][mb] == nil or type(CH_MouseSpellsData[idx][mb]) ~= 'table') ) 
        then
          CH_MouseSpellsData[idx][mb] = {action='NONE',condition='NONE'};
        end
      end
    end
  end

  if ( CH_VersionSaveFile ~= nil and CH_VersionSaveFile <= 13700 ) then
    if ( CH_Config.overheal.QUICK.clickAbortPerc == nil ) then
      CH_Config.overheal.QUICK.clickAbortPerc = 101;
    end
    if ( CH_Config.overheal.SLOW.clickAbortPerc == nil ) then
      CH_Config.overheal.SLOW.clickAbortPerc = 101;
    end
  end

  if ( CH_VersionSaveFile ~= nil and CH_VersionSaveFile <= 13800 ) then
    if ( CH_Config.overheal.QUICK.modifyTotalPerc == nil ) then
      CH_Config.overheal.QUICK.modifyTotalPerc = 100;
    end
    if ( CH_Config.overheal.SLOW.modifyTotalPerc == nil ) then
      CH_Config.overheal.SLOW.modifyTotalPerc = 100;
    end
    if ( CH_Config.overheal.QUICK.lomDowngradeRanks == nil ) then
      CH_Config.overheal.QUICK.lomDowngradeRanks = 0;
    end
    if ( CH_Config.overheal.SLOW.lomDowngradeRanks == nil ) then
      CH_Config.overheal.SLOW.lomDowngradeRanks = 0;
    end
  end

  if ( CH_VersionSaveFile ~= nil and CH_VersionSaveFile <= 14000 ) then
    local ai, mb;
    for ai,_ in CH_MouseSpells do 
      for mb,_ in CH_MouseSpells[ai] do
        if ( CH_MouseSpells[ai][mb] == 'SPELL' and (not CH_MouseSpellsData[ai][mb]) ) then
          CH_SetCHAction( 'SPELL', ai, mb, nil );
        elseif ( CH_MouseSpells[ai][mb] == 'PETSPELL' and (not CH_MouseSpellsData[ai][mb]) ) then
          CH_SetCHAction( 'PETSPELL', ai, mb, nil );
        end
      end
    end
  end

  if ( CH_VersionSaveFile ~= nil and CH_VersionSaveFile <= 14202 ) then
    if ( type(CH_Config.needyListHealEnabled) == 'boolean' ) then
      CH_Config.needyListHealEnabled = 'PARTYRAID';
    end
    if ( type(CH_Config.needyListCureEnabled) == 'boolean' ) then
      CH_Config.needyListCureEnabled = 'PARTYRAID';
    end
    if ( type(CH_Config.needyListBuffEnabled) == 'boolean' ) then
      CH_Config.needyListBuffEnabled = 'PARTYRAID';
    end
    if ( type(CH_Config.needyListDeadEnabled) == 'boolean' ) then
      CH_Config.needyListDeadEnabled = 'PARTYRAID';
    end
  end

  if ( CH_VersionSaveFile ~= nil and CH_VersionSaveFile <= 14303 ) then
    local buffIdx;
    for buffIdx,_ in CH_BuffData do
      if ( CH_BUFF_DATA[buffIdx].partySpellName and CH_BuffData[buffIdx].partySpellInBattlefield == nil ) then
        CH_BuffData[buffIdx].partySpellInBattlefield = true;
      end
    end
  end 

  if ( CH_VersionSaveFile ~= nil and CH_VersionSaveFile <= 14500 ) then
    if ( CH_Anchor ~= nil ) then
      local anchorID;
      for anchorID,_ in CH_Anchor do
        if ( CH_Anchor[anchorID].grow == nil ) then
          CH_Anchor[anchorID].grow = 'DOWN';
        end
      end
    end
  end

  if ( CH_VersionSaveFile ~= nil and CH_VersionSaveFile <= 14600 ) then
    local k;
    if ( CH_DefaultEmergencySpells ) then
      if ( not CH_EmergencySpells ) then
        CH_ConfigReset( 'PANIC', 'BEHAVIOR', nil );
      else
        for k,_ in CH_DefaultEmergencySpells do
          if ( not CH_EmergencySpells[k] ) then
            CH_EmergencySpells[k] = CH_CloneTable( CH_DefaultEmergencySpells[k] );
          end
        end
      end
    end
    if ( CH_Config.overheal.QUICK.overhealAllowance == nil ) then
      CH_Config.overheal.QUICK.overhealAllowance = 50;
    end
    if ( CH_Config.overheal.SLOW.overhealAllowance == nil ) then
      CH_Config.overheal.SLOW.overhealAllowance = 50;
    end
  end

  if ( CH_VersionSaveFile ~= nil and CH_VersionSaveFile <= 14800 ) then
    if ( CH_Config.friendFrameBackground == 'BLACK' or CH_Config.friendFrameBackground == 'TRANS' ) then
      CH_Config.friendFrameBackground = 'CUSTOM';
    end
  end

  CH_VersionSaveFile = CH_Version;

end

function CH_GetFrameVari( object, index )

  while ( object ) do
    if ( object[index] ~= nil ) then
      return( object[index] );
    end

    object = object:GetParent();
  end

  return( nil );

end

function CH_UpdateBattlefieldFlag()

  local currZone, oldInBF;

  if ( gPlayerIsInBattlefieldLastUpdate > GetTime() - 1 ) then
    return;
  end

  gPlayerIsInBattlefieldLastUpdate = GetTime();
  currZone = GetRealZoneText();
  oldInBF = gPlayerIsInBattlefield;

  if ( currZone == CH_ZONE_REAL_NAME_ALTERAC_VALLEY or currZone == CH_ZONE_REAL_NAME_WARSONG_GULCH or currZone == CH_ZONE_REAL_NAME_ARATHI_BASIN ) then
    gPlayerIsInBattlefield = true;
  else
    gPlayerIsInBattlefield = false;
  end

  if ( gPlayerIsInBattlefield ~= oldInBF ) then
    if ( CH_Config.needyListHealHideInBattlefield ) then
      CH_NeedyListRegisterWipe( 'HEAL', true );
    end
    if ( CH_Config.needyListCureHideInBattlefield ) then
      CH_NeedyListRegisterWipe( 'CURE', true );
    end
    if ( CH_Config.needyListBuffHideInBattlefield ) then
      CH_NeedyListRegisterWipe( 'BUFF', true );
    end
    if ( CH_Config.needyListDeadHideInBattlefield ) then
      CH_NeedyListRegisterWipe( 'DEAD', true );
    end
  end

end

function CH_PlayerIsInBattlefield()

  return( gPlayerIsInBattlefield );

end

function CH_GetItemIDFromItemLink( itemLink )

  local itemID = nil;

  if ( type(itemLink) == "string" ) then
    _,_,itemID = string.find( itemLink, "item:(%d+):" );
  end

  return( itemID );

end

function CH_ToBoolean( value )

  if ( value == nil ) then
    return( false );
  end

  if ( type(value) == 'boolean' ) then
    return( value );
  end

  return( true );

end

function CH_CloneTable( src )

  local k,v;
  local dest = {};

  for k,v in src do
    if ( type(v) == 'table' ) then
      dest[k] = CH_CloneTable( v );
    else
      dest[k] = v;
    end
  end

  return( dest );

end

function CH_InTable( haystack, needle )

  local value;

  if ( haystack == nil ) then
    return( false );
  end

  for _,value in haystack do
    if ( value == needle ) then
      return( true );
    end
  end

 return( false ); 

end

function CH_IsEmptyTable( t )

  if ( t == nil or next(t) == nil ) then
    return( true );
  end

  return( false );

end

function CH_TableSize( t )

  local s = 0;

  if ( not t ) then
    return( nil );
  end

  for _,_ in t do
    s = s + 1;
  end

  return( s );

end

function CH_UnitClass( unit )

  if ( unit == nil ) then
    CH_Debug( 'CH_UnitClass() called with nil!', CH_DEBUG_ERR );
    return( 'UNKNOWN' );
  end

  local lc,c = UnitClass( unit );

  return( c or 'UNKNOWN' );

end

function CH_LocalClass( class )

  return( CH_LOCAL_CLASS[class] );

end

function CH_LocalClassAbbr( class )

  return( CH_LOCAL_CLASS_ABBR[class] );

end

function CH_UnitRace( unit )

  local lr,r = UnitRace( unit );
  
  return( r );

end

function CH_UnitName( unit )

  return( UnitName(unit) or 'Unknown' );

end

function CH_UnitIsDeadOrGhostForReal( unit )

  return( UnitIsDeadOrGhost(unit) and (not CH_UnitHasBuff(unit,CH_SPELL_FEIGN_DEATH)) );

end

function CH_UnitsPetUnit( unit )

  local len;

  if ( unit == nil ) then
    return( nil );
  end

  len = strlen( unit );
  if ( unit == 'player' ) then
    return( 'pet' );
  elseif ( len == 6 and strsub(unit,1,5) == 'party' ) then
    return( 'partypet'..strsub(unit,6) );
  elseif ( len == 5 and strsub(unit,1,4) == 'raid' ) then
    return( 'raidpet'..strsub(unit,5) );
  end

  return( nil );			-- pet for unit not known

end

function CH_PetUnitsUnit( petUnit )

  local idx, len;

  if ( petUnit == nil ) then
    return( nil );
  end

  len = strlen( petUnit );
  if ( petUnit == 'pet' ) then
    return( 'player' );
  elseif ( len == 9 and strsub(petUnit,1,8) == 'partypet' ) then
    return( 'party'..strsub(petUnit,9) );
  elseif ( len == 8 and strsub(petUnit,1,7) == 'raidpet' ) then
    return( 'raid'..strsub(petUnit,8) );
  end

  return( nil );

end

local function CHL_SetUnitColorReal( idx, useClassColors, frame )

  if ( useClassColors and RAID_CLASS_COLORS[idx]) then
    frame:SetTextColor( RAID_CLASS_COLORS[idx].r, RAID_CLASS_COLORS[idx].g, RAID_CLASS_COLORS[idx].b );
  elseif ( CH_Config.nameColor[idx] and CH_Config.nameColor[idx] ~= 'DEFAULT' ) then
    frame:SetTextColor( CH_COLOR[CH_Config.nameColor[idx]].r, CH_COLOR[CH_Config.nameColor[idx]].g, CH_COLOR[CH_Config.nameColor[idx]].b );
  elseif ( CH_DEFAULT_NAME_COLOR[idx] ) then
    frame:SetTextColor( CH_COLOR[CH_DEFAULT_NAME_COLOR[idx]].r, CH_COLOR[CH_DEFAULT_NAME_COLOR[idx]].g, CH_COLOR[CH_DEFAULT_NAME_COLOR[idx]].b );
  else
    frame:SetTextColor( CH_COLOR[CH_DEFAULT_NAME_COLOR['DEFAULT']].r, CH_COLOR[CH_DEFAULT_NAME_COLOR['DEFAULT']].g, CH_COLOR[CH_DEFAULT_NAME_COLOR['DEFAULT']].b );
  end

  return( true );

end

local function CHL_SetUnitColor( unit, isPet, isTarget, isMTT, frame )

  local i;

  -- ----- not target
  if ( ((not isTarget) and (not isMTT)) or (isMTT and UnitIsPlayer(unit)) ) then
    if ( (not isMTT) and CH_IsEffectedBy(unit,CH_EFFECT_POWER_WORD_SHIELD,false) ) then		-- shielded
      return( CHL_SetUnitColorReal('SHIELD',false,frame) );
    elseif ( CH_Config.partyLabel == 'COLOR' or CH_Config.partyLabel == 'BOTHCOLOR' ) then
      return( CHL_SetUnitColorReal(CH_UnitClass(unit),true,frame) );
    end

    return( CHL_SetUnitColorReal('FRIEND',false,frame) );
  end

  -- ----- MainTankTarget or MainTankTargetTarget
  if ( isMTT ) then
    return( CHL_SetUnitColorReal('MTT',false,frame) );
  end

  -- ----- player
  if ( UnitIsUnit('target',unit) and (not isPet) ) then
    for i=1,GetNumPartyMembers() do
      if ( UnitIsUnit(unit,'party'..i..'target') ) then
        return( CHL_SetUnitColorReal('party'..i..'target',false,frame) );
      end
    end
    if ( UnitExists('pet') and UnitIsUnit(unit,'pettarget') ) then
      return( CHL_SetUnitColorReal('pettarget',false,frame) );
    end
    for i=1,GetNumPartyMembers() do
      if ( UnitExists('partypet'..i) and UnitIsUnit(unit,'partypet'..i..'target') ) then
        return( CHL_SetUnitColorReal('partypet'..i..'target',false,frame) );
      end
    end

    return( CHL_SetUnitColorReal('playertarget',false,frame) );
  end

  -- ----- party
  for i=1,GetNumPartyMembers() do
    if ( UnitIsUnit(unit,'party'..i..'target') ) then				-- "unit" can be party and partypet !
      return( CHL_SetUnitColorReal('party'..i..'target',false,frame) );
    end
  end

  -- (party) pets
  if ( UnitExists('pet') and UnitIsUnit(unit,'pettarget') ) then
    return( CHL_SetUnitColorReal('pettarget',false,frame) );
  end
  for i=1,GetNumPartyMembers() do
    if ( UnitExists('partypet'..i) and UnitIsUnit(unit,'partypet'..i..'target') ) then			-- "unit" can be party and partypet !
      return( CHL_SetUnitColorReal('partypet'..i..'target',false,frame) );
    end
  end

  -- this shoudl never be reached !!!
  CH_Dbg( 'CHL_SetUnitColor() UNREACHABLE '..unit, CH_DEBUG_ERR );
  return( CHL_SetUnitColorReal(unit..'target',false,frame) );

end

function CH_SetUnitLabel( unit, frameData, isPet, isTarget, isMTT, frame )

  local frameWidth, unitLabel, uc;

  if ( not frame ) then
    return;
  end

  if ( unit == nil ) then						-- this CAN happen, dunno how though
    frame:SetText( 'Unknown' );
  end

  if ( (isTarget and (not isMTT)) or 					-- target and not MTT
       (isMTT and not UnitIsPlayer(unit)) )				-- or MMT but not a player (hostile??? canattack?)
  then															-- check BEFORE pet!
    if ( isMTT and (not UnitExists(unit)) ) then
      unitLabel = CH_MainTankLabel( frameData );
    else
      unitLabel = CH_UnitName(unit);
      if ( not UnitIsPlayer(unit) ) then
        uc = UnitClassification(unit);
        if ( uc == 'elite' or uc == 'rareelite' ) then
          unitLabel = '+'..unitLabel;
        elseif ( uc == 'worldboss' ) then
          unitLabel = '++'..unitLabel;
        end
      end
    end
    frame:SetText( unitLabel );
    CHL_SetUnitColor( unit, isPet, isTarget, isMTT, frame );
    return;
  end

  if ( isPet ) then							-- pet
    local petName;
    if ( unit == 'pet' ) then
      petName = CH_UnitName( unit );
    elseif ( UnitCreatureFamily(unit) == CH_CREATURE_FAMILY_DEMON ) then
      petName = UnitCreatureType(unit) or UnitCreatureFamily(unit) or CH_LABEL_PET;
    else
      petName = UnitCreatureFamily( unit );
    end
    unitLabel = (petName or CH_LABEL_PET);
  elseif ( unit == 'player' ) then						-- player
    unitLabel = CH_UnitName( unit );
  elseif ( CH_Config.partyLabel == 'CLASS' ) then				-- party (/raid)
    unitLabel = CH_LocalClass( CH_UnitClass(unit) );
  elseif ( CH_Config.partyLabel == 'NAME' or CH_Config.partyLabel == 'COLOR' ) then
    unitLabel = CH_UnitName( unit );
  elseif ( CH_Config.partyLabel == 'BOTH' ) then
    unitLabel = CH_LocalClassAbbr(CH_UnitClass(unit)).."-"..CH_UnitName(unit);
  elseif ( CH_Config.partyLabel == 'BOTHCOLOR' ) then
    unitLabel = CH_LocalClassAbbr(CH_UnitClass(unit)).."-"..CH_UnitName(unit);
  else
    unitLabel = "!!"..CH_UnitName(unit).."!!";
  end

--  frameWidth = floor( ceil(frame:GetParent():GetParent():GetWidth()-40) );
  frameWidth = floor( frame:GetParent():GetWidth()-40 );
  frame:SetText( unitLabel );
  while ( frame:GetStringWidth(unitLabel) > frameWidth and strlen(unitLabel) > 3 ) do
    unitLabel = strsub( unitLabel, 1, -2 );
    frame:SetText( unitLabel );
  end

  CHL_SetUnitColor( unit, isPet, isTarget, isMTT, frame );

end

function CH_UnitHPLabel( unit, hp, hpMax, hpPerc, isTarget )

  local perc,label, inHealRange;

  if ( UnitIsCharmed(unit) ) then
    if ( UnitCanAttack('player',unit) ) then
      return ceil(hpPerc), '|c00'..CH_COLOR.RED.html..CH_LABEL_CHARMED..'|r';
    else
      return floor(hpPerc), '|c00'..CH_COLOR.RED.html..CH_LABEL_CHARMED..'|r';
    end
  elseif ( UnitCanAttack('player',unit) ) then
    perc,label = ceil(hpPerc), ceil(hpPerc);
--  elseif ( isTarget ) then
--    perc,label = floor(hpPerc), floor(hpPerc);
  elseif ( CH_Config.checkHealRange ~= 'NEVER' and CH_Config.healRangeVisualizationPossible == 'OOR' and CH_IsUnitInRange(unit,'HEAL') == -1 ) then
    perc,label = floor(hpPerc), '|c00'..CH_COLOR.LIGHTORANGE.html..CHT_LABEL_OUT_OF_RANGE..'|r';
  elseif ( CH_Config.checkHealRange ~= 'NEVER' and CH_Config.healRangeVisualizationVerified == 'OOR' and CH_IsUnitInRange(unit,'HEAL') == -2 ) then
    perc,label = floor(hpPerc), '|c00'..CH_COLOR.RED.html..CHT_LABEL_OUT_OF_RANGE..'|r';
  elseif ( CH_Config.friendHPLabel == 'PERCENT' ) then
    perc,label = floor(hpPerc), floor(hpPerc);
  elseif ( CH_Config.friendHPLabel == 'PERCENT_SIGN' ) then
    perc,label = floor(hpPerc), floor(hpPerc).."%";
  elseif ( CH_Config.friendHPLabel == 'CURRENT') then
    perc,label = floor(hpPerc), hp;
  elseif ( CH_Config.friendHPLabel == 'MISSING' ) then
    perc,label = floor(hpPerc), (hpMax-hp) * -1;
  elseif ( CH_Config.friendHPLabel == 'NONE' ) then
    perc,label = floor(hpPerc), '';
  else
    CH_Debug( 'CH_UnitHPLabel in ELSE for unit: '..unit, CH_DEBUG_WARNING );
    perc,label = floor(hpPerc), floor(hpPerc);
  end

  if ( CH_Config.checkHealRange ~= 'NEVER' and (not UnitCanAttack('player',unit)) ) then 
    if ( CH_Config.healRangeVisualizationPossible == 'HP' and CH_IsUnitInRange(unit,'HEAL') == -1 ) then
      label = '|c00'..CH_COLOR.LIGHTORANGE.html..label..'|r';
    elseif ( CH_Config.healRangeVisualizationVerified == 'HP' and CH_IsUnitInRange(unit,'HEAL') == -2 ) then
      label = '|c00'..CH_COLOR.RED.html..label..'|r';
    end
  end

  return perc,label;

end

function CH_UnitAffectingCombat( unit )

  if ( UnitAffectingCombat(unit) ) then
    return( 'Y' );
  end
  return( 'N' );

end

function CH_UnitIsAvatar( unit )

  return( UnitIsUnit('player',unit) );

end

function CH_UnitIsAvatarOrPet( unit )

  return( CH_UnitIsAvatar(unit) or (UnitExists('pet') and UnitIsUnit('pet',unit)) );

end

function CH_UnitPlayerInParty( unit )

  if ( GetNumPartyMembers() < 1 ) then
    return( false );
  elseif ( UnitIsUnit('player',unit) ) then
    return( false );
  else
    return( UnitInParty(unit) == 1 );
  end

end

function CH_UnitInParty( unit )

  if ( GetNumPartyMembers() < 1 ) then
    return( false );
  else
    return( UnitPlayerOrPetInParty(unit) == 1 );
  end

end

function CH_UnitPlayerInRaid( unit )

  return( UnitInRaid(unit) );

end

function CH_UnitInRaid( unit )

  return( UnitPlayerOrPetInRaid(unit) == 1 );

end

function CH_UnitPlayerInPartyOrRaid( unit )

  return( CH_UnitPlayerInRaid(unit) or CH_UnitPlayerInParty(unit) );

end

function CH_UnitInPartyOrRaid( unit )

  return( CH_UnitInRaid(unit) or CH_UnitInParty(unit) );

end

function CH_UnitInRaidOnly( unit )

  if ( CH_UnitIsAvatarOrPet(unit) ) then
    return( false );
  end

  if ( CH_UnitInParty(unit) ) then
    return( false );
  end

  return( CH_UnitInRaid(unit) );

end

function CH_PlayerNameInParty( playerName )

  local i = GetNumPartyMembers();

  if ( playerName == UnitName('player') ) then
    return( 'player' );
  end

  while ( i > 0 ) do
    if ( UnitName('party'..i) == playerName ) then
      return( 'party'..i );
    end
    i = i - 1;
  end

  return( nil );

end

function CH_PlayerNameInRaid( playerName )

  return( gRaidMemberMap[playerName] );

--  local i = GetNumRaidMembers();

--  while ( i > 0 ) do
--    if ( UnitName('raid'..i) == playerName ) then
--      return( 'raid'..i );
--    end
--    i = i - 1;
--  end

--  return( nil );

end

function CH_PlayerNameInPartyOrRaid( playerName )

  local unit;

  unit = CH_PlayerNameInParty( playerName );
  if ( unit ) then
    return( unit );
  end

  return( CH_PlayerNameInRaid(playerName) );

end

function CH_IsUnitInSameParty( unit, otherUnit )

  local unitIdx, otherUnitIdx, unitGroup, otherUnitGroup;

  if ( unit == nil or otherUnit == nil ) then
    return( false );
  end

  if ( UnitIsUnit(unit,otherUnit) ) then										-- the same unit
    return( true );
  elseif ( CH_UnitIsAvatarOrPet(otherUnit) ) then									-- switch arguments
    return( CH_IsUnitInSameParty(otherUnit,unit) );
  elseif ( UnitIsUnit('player',unit) and (CH_UnitInParty(otherUnit) or UnitIsUnit(otherUnit,'pet')) ) then
    return( true );
  elseif ( UnitIsUnit('pet',unit) and (CH_UnitInParty(otherUnit) or CH_UnitIsAvatar(otherUnit)) ) then
    return( true );
  elseif ( CH_UnitInParty(unit) and (CH_UnitInParty(otherUnit) or CH_UnitIsAvatarOrPet(otherUnit)) ) then
    return( true );
  elseif ( CH_UnitInRaid(unit) and CH_UnitInRaid(otherUnit) ) then
    unitIdx = CH_UnitToRaidIdx( unit );
    if ( unitIdx ) then
      otherUnitIdx = CH_UnitToRaidIdx( otherUnit );
      if ( otherUnitIdx ) then
        _,_,unitGroup = GetRaidRosterInfo( unitIdx );
        _,_,otherUnitGroup = GetRaidRosterInfo( otherUnitIdx );
        return( unitGroup == otherUnitGroup );
      end
    end
  end

  return( false );

end

function CH_UnitNameToUnit( unitName )

  return( CH_PlayerNameInPartyOrRaid(unitName) );

end

function CH_UnitToRaidIdx( unit )

  local len = strlen( unit );

  if ( not (((len == 5 or len == 6) and (strsub(unit,1,4) == 'raid')) or ((len == 8 or len == 9) and (strsub(unit,1,7) == 'raidpet'))) ) then
    unit = CH_NormalizeUnit( unit );
  end

  if ( (len == 5 or len == 6) and (strsub(unit,1,4) == 'raid') ) then
    return( tonumber(strsub(unit,5)) );
  elseif ( (len == 8 or len == 9) and (strsub(unit,1,7) == 'raidpet') ) then
    return( tonumber(strsub(unit,8)) );
  else
    return( nil );
  end

end

function CH_GetPetMaster( unit )

  local i, len;

  if ( (not unit) or UnitIsPlayer(unit) ) then
    return( nil );
  end

  if ( UnitIsUnit(unit,'pet') ) then
    return( 'player' );
  end

  len = strlen( unit );

  if ( len == 9 and strsub(unit,1,8) == 'partypet' ) then
    return( 'party'..strsub(unit,-1) );
  elseif ( (len == 8 or len == 9) and strsub(unit,1,7) == 'raidpet' ) then
    return( 'raid'..strsub(unit,7-len) );
  end

  for i=1,GetNumPartyMembers() do
    if ( UnitIsUnit(unit,'partypet'..i) ) then
      return( 'party'..i );
    end
  end

  if ( CH_UnitInRaid(unit) ) then
    for i=1,GetNumRaidMembers() do
      if ( UnitIsUnit(unit,'raidpet'..i) ) then
        return( 'raid'..i );
      end
    end
  end

  return( nil );

end

function CH_GetSpellName( spellID, booktype )

  local name,rank = GetSpellName( spellID, booktype );

  if ( rank ) then
    _,_,rank = string.find( rank, CH_SPELL_RANK_REGEXP );
    if ( rank ) then
      rank = tonumber(rank);
    end
  end

  return name,rank;

end

function CH_CalcPercentage( curr, max )

  local perc;

  if ( curr <= 0 ) then
    return( 0 );
  end
  
--  hpPerc = tonumber( hp * 100 / hpMax );	-- do i need to_number() ???
  perc = curr * 100 / max;
  if ( perc <= 0 ) then
    return( 0 );
  elseif ( perc > 100 ) then
    return( 100 );
  elseif ( perc <= 0 ) then
    return( 0 );
  end

  return( perc );

end

function CH_FormatTimeMMSS( seconds )

  local m,s;

  m = floor( seconds / 60 );
  s = mod( seconds, 60 );

  if ( m > 0 ) then
    return( string.format("%d:%02d "..CHT_LABEL_TIME_MINUTES,m,s) );
  else
    return( string.format("%d "..CHT_LABEL_TIME_SECONDS,s) );
  end

end

function CH_BuildMouseButton( mouse )
  local mb = '';

  if ( IsShiftKeyDown() ) then
    mb = mb .. 'Shift';
  end
  if ( IsControlKeyDown() ) then
    mb = mb .. 'Ctrl';
  end
  if ( IsAltKeyDown() ) then
    mb = mb .. 'Alt';
  end

  return( mb .. mouse );

end

function CH_FindBagItemByName( lookupName )

  local bag, slot, itemLink, itemName;

  lookupName = strlower( lookupName );

  for bag=0,4 do
    for slot=1,GetContainerNumSlots(bag) do
      itemLink = GetContainerItemLink( bag, slot );
      if ( itemLink ) then
        _,_,itemName = strfind( itemLink, "%[(.*)%]" );
        if ( itemName and strlower(itemName) == lookupName ) then
          return bag, slot, itemName;
        end
      end
    end
  end

  return nil, nil, nil;

end

function CH_UseBagItemByName( lookupName, unit, evaluateTarget )

  local itemID, itemType, itemSubType 
  local bag,slot = CH_FindBagItemByName( lookupName );

  if ( evaluateTarget ) then
    itemID = CH_GetItemIDFromItemLink( GetContainerItemLink(bag,slot) );
    _,_,_,_,itemType,itemSubType = GetItemInfo(itemID); 
    if ( unit and itemType == 'Trade Goods' and itemSubType == 'Explosives' and (not UnitCanAttack('player',unit)) ) then
      unit = nil;
    end
  end

  if ( bag ~= nil ) then
    if ( (not unit) or UnitCanAttack('player',unit) ) then
      CH_CastSpellOnEnemy( {bag=bag,slot=slot}, nil, unit, 'BAG' );
    else
      CH_CastSpellOnFriend( {bag=bag,slot=slot}, nil, unit, 'BAG' );
    end

    return( true );
  end

  return( false );

end

function CH_FindInventoryItemByName( lookupName )

  local slotID, slotName, itemLink;

  lookupName = strlower( lookupName );

  for _,slotName in INVENTORY_SLOTS do
    slotID = GetInventorySlotInfo( slotName );
    itemLink = GetInventoryItemLink( 'player', slotID );
    if ( itemLink ) then
      local _, _, itemCode = strfind(itemLink, "(%d+):");		-- if I do not do this, next line crashes!!!!
      _,_,itemName = strfind( itemLink, "%[(.*)%]" );
      if ( itemName and strlower(itemName) == lookupName ) then
        return slotID, slotName, itemName;
      end
    end
  end

  return nil, nil, nil;

end

function CH_UseInventoryItemByName( lookupName, unit )
 
  local slotID = CH_FindInventoryItemByName( lookupName );
  
  if ( slotID ~= nil ) then
    if ( UnitCanAttack('player',unit) ) then
      CH_CastSpellOnEnemy( slotID, nil, unit, 'INV' );
    else
      CH_CastSpellOnFriend( slotID, nil, unit, 'INV' );
    end

    return( true );
  end

  return( false );

end

-- NOTE: if findRank is given and no spell with this rank is found, the highest spell with the same findSpellName will be returned!
function CH_GetSpellID( findSpell, findRank, booktype, checkReagent )

  local i, spellName, spellRank, reagent;
  local foundID = -1;
  local foundName = nil;
  local foundRank = nil;
  local spellID = nil;

  if ( findSpell == nil ) then
    CH_Dbg( 'CH_GetSpellID(), findspell is NIL, please report on boards, together with how this bug occurred. Thanx!', CH_DEBUG_WARNING );
    return foundID, foundName, foundRank;
  end

  if ( not GetSpellName(1,booktype ) ) then
    CH_Dbg( 'CH_GetSpellID(), Spells not yet loaded (booktype = '..booktype..'), please report on boards, together with how this bug occurred. Thanx!', CH_DEBUG_WARNING );
    return foundID, foundName, foundRank;
  end

  findSpell = strlower( findSpell );

  if ( booktype == BOOKTYPE_SPELL and (not checkReagent) and (not CH_SpellMap) ) then
    CH_Dbg( 'CH_SpellMap is nil, please report on boards, together with how this bug occurred. Thanx!', CH_DEBUG_WARNING );
  end

  -- via spellmap
  if ( CH_SpellMap and booktype == BOOKTYPE_SPELL and (not checkReagent) ) then
    if ( findRank == nil ) then
      findRank = 'MAX';
    end

    spellID = nil;
    if ( CH_SpellMap[findSpell] ) then
      spellID = CH_SpellMap[findSpell][findRank];
      if ( not spellID ) then
        spellID = CH_SpellMap[findSpell].MAX;
      end
    end

    if ( spellID ) then
      spellName,spellRank = CH_GetSpellName( spellID, booktype );
      return spellID, spellName, spellRank;
    else
      return -1, nil, nil;
    end
  end

  -- old method (scanning)
  if ( findRank == 'MAX' ) then
    findRank = nil;
  end

  i = 1;
  spellName,spellRank = CH_GetSpellName( i, booktype );
  while ( spellName ) do
    if ( findSpell == strlower(spellName) ) then
      if ( findRank and spellRank == findRank ) then
        return foundID, foundName, foundRank;
      elseif ( foundRank == nil or spellRank > foundRank ) then
        if ( checkReagent ) then
          CH_TooltipSetSpell( i, booktype );
          _,_,reagent = CH_TooltipGetReagents();
          if ( (not reagent) or (reagent and CH_FindBagItemByName(reagent)) ) then
            foundID = i;
            foundName = spellName;
            foundRank = spellRank;
          end
        else
          foundID = i;
          foundName = spellName;
          foundRank = spellRank;
        end
      end
    end
    i = i + 1;
    spellName,spellRank = CH_GetSpellName( i, booktype );
  end

  return foundID, foundName, foundRank;
    
end

function CH_GetTalentInfoByName( findName )

  local numTalents;
  local numTabs = GetNumTalentTabs();

  while ( numTabs > 0 ) do
    numTalents = GetNumTalents( numTabs );
    while ( numTalents > 0 ) do
      if ( GetTalentInfo(numTabs,numTalents) == findName ) then
        return GetTalentInfo( numTabs, numTalents );
      end
      numTalents = numTalents - 1;
    end
    numTabs = numTabs - 1;
  end

  return nil;

end

function CH_UnitCanLearnBuff( buffIdx, unit )

  local unitRace = CH_UnitRace(unit);

  if ( CH_BUFF_DATA[buffIdx].learnRaces == nil or CH_BUFF_DATA[buffIdx].learnRaces[unitRace] ) then
    return( true );
  end

  return( false );

end

function CH_IsUnitIDUnique( unit )

  local len;

  if ( unit == nil ) then
    return( false );
  end

  len = strlen( unit );

  if ( unit == 'player' or unit == 'pet' or 
       (len == 6 and (strsub(unit,1,5) == 'party')) or
       (len == 9 and (strsub(unit,1,8) == 'partypet')) or
       ((len == 5 or len == 6) and (strsub(unit,1,4) == 'raid')) or
       ((len == 8 or len == 9) and (strsub(unit,1,7) == 'raidpet'))
      )
  then
    return( true );
  end

  return( false );

end

local function CHL_NormalizeUnitScan( unit )

  local i;

  if ( UnitIsFriend('player',unit ) ) then			-- i can only normalize friends!
    if ( UnitIsUnit('player',unit) ) then
      return( 'player' );
    elseif ( UnitExists('pet') and UnitIsUnit('pet',unit) ) then
      return( 'pet' );
    elseif ( UnitInParty(unit) ) then
      for i=GetNumPartyMembers(),1,-1 do
        if ( UnitIsUnit('party'..i,unit) ) then
          return( 'party'..i );
        elseif ( UnitExists('partypet'..i) and UnitIsUnit('partypet'..i,unit) ) then
          return( 'partypet'..i );
        end
      end
    elseif ( UnitInRaid(unit) ) then
      for i=GetNumRaidMembers(),1,-1 do
        if ( UnitIsUnit('raid'..i,unit) ) then
          return( 'raid'..i );
        elseif ( UnitExists('raidpet'..i) and UnitIsUnit('raidpet'..i,unit) ) then
          return( 'raidpet'..i );
        end
      end
    end
  end

  if ( UnitIsUnit('target',unit) ) then
    return( 'target' );
  end

  return( unit );

end

function CH_NormalizeUnit( unit )

  local isTarget, i, pos, len;
  local loopUnit, restUnit, matchUnit;
  local didChange = false;
  local origUnit = unit;

  if ( unit == nil ) then							-- NIL
    return( unit );
  elseif ( unit == 'mouseover' and (not UnitIsFriend('player',unit)) ) then	-- can no further normalize
    return( unit );
  elseif ( strsub(unit,1,12) == 'playertarget' ) then				-- abbrevate
    if ( UnitIsUnit('target','player') ) then						-- if I am the target, the target of my target is myself again
      unit = 'player';
    else
      unit = 'target'..strsub(unit,13);
    end
  end

  isTarget = strfind( unit, 'target', 1, true );

  if ( isTarget ) then								-- contains "target"
    unit = CHL_NormalizeUnitScan( unit );						-- first, scan passed "unit"
    if ( unit ~= origUnit ) then
      return( unit );
    end

    len = strlen( unit );								-- nothing found, break down
    pos = strfind( unit, 'target', 1, true );
    while ( (pos and didChange) or
            ((not didChange) and pos < len-5) )						-- skip last if not changed, done above
    do
      loopUnit = strsub( unit, 1, pos+5 );
      restUnit = strsub( unit, pos+6 );
      if ( loopUnit == 'playertarget' ) then
        matchUnit = 'target';
      else
        matchUnit = CHL_NormalizeUnitScan( loopUnit );
      end
      if ( matchUnit ~= loopUnit ) then
        unit = matchUnit..restUnit;
        pos = strfind( unit, 'target', 1, true );
        didChange = true;
      else
        pos = strfind( unit, 'target', pos+6, true );						 -- next occurance
      end
    end
  elseif ( strsub(unit,1,7) == 'raidpet' ) then					-- raidpet
    if ( UnitExists('pet') and UnitIsUnit('pet',unit) ) then
      return( 'pet' );
    end
    for i=GetNumPartyMembers(),1,-1 do
      if ( UnitExists('partypet'..i) and UnitIsUnit('partypet'..i,unit) ) then
        return( 'partypet'..i );
      end
    end
  elseif ( strsub(unit,1,4) == 'raid' ) then					-- raid member
    if ( UnitIsUnit('player',unit) ) then
      return( 'player' );
    end
    for i=GetNumPartyMembers(),1,-1 do
      if ( UnitIsUnit('party'..i,unit) ) then
        return( 'party'..i );
      end
    end
  end

  return( unit );

end

function CH_UnitHasBuff( unit, findBuff, findBuff2 )

  local i = 1;
  local buffName, buffTexture;

--  if ( getglobal("CH_Tooltip") == nil or getglobal("CH_TooltipTextLeft1") ) then
--    return( false );
--  end

  findBuff = strlower( findBuff );
  if ( findBuff2 ) then
    findBuff2 = strlower( findBuff2 );
  end

  buffTexture = UnitBuff( unit, i );
  while ( buffTexture ) do

    CH_TooltipSetUnitBuff( unit, i );
    buffName = strlower( CH_TooltipGetTitle() );

    if ( buffName == findBuff or (findBuff2 and buffName == findBuff2) ) then
      return( true );
    end

    i = i + 1;
    buffTexture = UnitBuff( unit, i );
  end

  return( false );

end

function CH_UnitHasDebuff( unit, findDebuff, checkPrevCast )

  local i = 1;
  local buffName, buffTexture;

--  if ( getglobal("CH_Tooltip") == nil or getglobal("CH_TooltipTextLeft1") ) then
--    return( false );
--  end

  findDebuff = strlower( findDebuff );

  buffTexture = UnitDebuff( unit, i );
  while ( buffTexture ) do

    CH_TooltipSetUnitDebuff( unit, i );
    buffName = CH_TooltipGetTitle();

    if ( strlower(buffName) == findDebuff ) then
      return( true );
    end

    i = i + 1;
    buffTexture = UnitDebuff( unit, i );
  end

  if ( checkPrevCast and gCSPrevName and strlower(gCSPrevName) == findDebuff and (gCSPrevEndState == 'STOP' or gCSPrevEndState == 'CHANNEL') and 
       gCSPrevEndTime >= GetTime() - CH_UNIT_BUFF_VISIBLE_DELAY ) 
  then
    return( true );
  end

  return( false );

end

function CH_GetPlayerBuffByName( findBuff )

  local i = 0;
  local buffName, buffIdx, untilCancelled;

--  if ( getglobal("CH_Tooltip") == nil or getglobal("CH_TooltipTextLeft1") ) then
--    return( false );
--  end

  findBuff = strlower( findBuff );

  buffIdx,untilCancelled = GetPlayerBuff( i );
  while ( buffIdx >= 0 ) do

    CH_TooltipSetPlayerBuff( buffIdx );
    buffName = CH_TooltipGetTitle();

    if ( strlower(buffName) == findBuff ) then
      return buffIdx, untilCancelled;
    end

    i = i + 1;
    buffIdx,untilCancelled = GetPlayerBuff( i );
  end

  return -1;

end

function CH_UnitIsMesmerized( unit )

  local i = 1;
  local buffName, buffTexture;

--  if ( getglobal("CH_Tooltip") == nil or getglobal("CH_TooltipTextLeft1") ) then
--    return( false );
--  end

  buffTexture = UnitDebuff( unit, i );
  while ( buffTexture ) do

    CH_TooltipSetUnitDebuff( unit, i );
    buffName = CH_TooltipGetTitle();

    if ( buffName and (CH_MESMERIZE_INFO[buffName] or buffName == CH_SPELL_SAP or buffName == CH_DEBUFF_SEDUCTION) ) then
      return( true );
    end

    i = i + 1;
    buffTexture = UnitDebuff( unit, i );
  end

  return( false );

end

function CH_UnitCanUseWand( unit )

  return( CH_CLASS_INFO[CH_UnitClass(unit)].canUseWand ); 

end

-- scanActionBar: scan actionbar directly and do not use the cache CH_ActionBar
function CH_FindActionSlotByName( findName, scanActionBar )

  local i = 1;
  local actionName;

  if ( scanActionBar ) then
    findName = strlower( findName );
    while ( i <= CH_MAX_ACTION_SLOTS ) do
      if ( HasAction(i) and (not GetActionText(i)) ) then
        CH_TooltipSetAction( i );
        actionName = CH_TooltipGetTitle();
        if ( actionName and findName == strlower(actionName) ) then
          return( i );
        end
      end
      i = i + 1;
    end
  elseif ( CH_ActionBar[findName] ) then
    return( CH_ActionBar[findName].slot );
  end

  return( -1 );

end

local function CHL_DockChainFrame( idx, frameName, parentFrame, parentRel, parentYOff )

  local point, relativePoint;
  local frame = getglobal(frameName..idx);
  local sisterFrame;

  if ( CH_Config.dockTarget == 'LEFT' ) then
    point = 'RIGHT';
    relativePoint = 'LEFT';
  else
    point = 'LEFT';
    relativePoint = 'RIGHT';
  end

  frame:ClearAllPoints();

  if ( idx == 1 ) then
    frame:SetPoint( 'TOP'..point, parentFrame, parentRel..relativePoint, 0, parentYOff );
  else
    sisterFrame = getglobal( frameName..(idx-1) );
    frame:SetPoint( point, sisterFrame, relativePoint, 1, 0 );
  end

end

local function CHL_MirrorAnchor( anchor, how )

  if ( string.find(how,'H') ) then
    if ( string.find(anchor,'LEFT') ) then
      anchor = gsub( anchor, 'LEFT', 'RIGHT' );
    else
      anchor = gsub( anchor, 'RIGHT', 'LEFT' );
    end
  end
  if ( string.find(how,'V') ) then
    if ( string.find(anchor,'TOP') ) then
      anchor = gsub( anchor, 'TOP', 'BOTTOM' );
    else
      anchor = gsub( anchor, 'BOTTOM', 'TOP' );
    end
  end

  return( anchor );

end

function CH_RangeOrMelee( unit )

  if ( not unit ) then
    return( 'RANGE' );
  elseif ( gWandActionBarSlot and UnitIsUnit(unit,'target') and (IsActionInRange(gWandActionBarSlot) == 1 or (not CheckInteractDistance('target',2))) ) then
    return( 'RANGE' );
  elseif ( CheckInteractDistance(unit,1) ) then
    return( 'MELEE' );
  end

  return( 'RANGE' );

end

function CH_GetShapeshiftFormIdx( unit )

  local i, name, active;
  local playerClass = CH_UnitClass('player');

  if ( playerClass == 'DRUID' ) then
    i = 1;
    _,name,active = GetShapeshiftFormInfo( i );
    while ( name and (not active) ) do
      i = i + 1;
      _,name,active = GetShapeshiftFormInfo( i );
    end

    if ( active ) then
      if ( name == CH_SHAPESHIFT_DIRE_BEAR_FORM_NAME or name == CH_SHAPESHIFT_BEAR_FORM_NAME ) then
        return( 'BEAR' );
      elseif ( name == CH_SHAPESHIFT_CAT_FORM_NAME ) then
        return( 'CAT' );
      end
    end

    return( CH_CLASS_INFO[playerClass].shapeshift.default );
  elseif ( playerClass == 'HUNTER' ) then
    return( CH_RangeOrMelee(unit) );
  elseif ( playerClass == 'ROGUE' ) then
    _,name,active = GetShapeshiftFormInfo( 1 );
    if ( active and name == CH_SHAPESHIFT_STEALTH ) then
      return( 'STEALTH' );
    end
    return( CH_CLASS_INFO[playerClass].shapeshift.default );
  elseif ( playerClass == 'WARRIOR' ) then
    i = 1;
    _,name,active = GetShapeshiftFormInfo( i );
    while ( name and (not active) ) do
      i = i + 1;
      _,name,active = GetShapeshiftFormInfo( i );
    end

    if ( active ) then
      if ( name == CH_SHAPESHIFT_BATTLE_STANCE ) then
        return( 'BAT' );
      elseif ( name == CH_SHAPESHIFT_BERSERKER_STANCE ) then
        return( 'BER' );
      elseif ( name == CH_SHAPESHIFT_DEFENSIVE_STANCE ) then
        return( 'DEF' );
      end
    end

    return( CH_CLASS_INFO[playerClass].shapeshift.default );
  end

  return( nil );

end

function CH_UnitListIndex( unit, inParty, noWarning )

  local petMaster;

  if ( not unit ) then
    return( nil );
  end

  if ( inParty and (not (CH_UnitInPartyOrRaid(unit) or CH_UnitIsAvatarOrPet(unit))) ) then
    return( nil );
  end

  if ( UnitIsPlayer(unit) ) then
    return( UnitName(unit) );
  end

  petMaster = CH_GetPetMaster(unit);
  if ( petMaster ) then
    return( UnitName(petMaster)..'PET' );
  end

--  if ( unit ~= 'target' ) then
  if ( not noWarning ) then
    CH_Dbg( 'CH_UnitListIndex returns NIL for '..(unit or 'NIL'), CH_DEBUG_ERR );
  end
--  end

  return( nil );

end

function CH_UnitListIndexToUnitID( unitIdx )

  local isPet, i;

  if ( strsub(unitIdx,-3) == 'PET' ) then
    isPet = true;
    unitIdx = strsub( unitIdx, 1, -4 );
  end

  if ( CH_UnitName('player') == unitIdx ) then
    if ( isPet ) then
      return( 'pet' );
    else
      return( 'player' );
    end
  end

  for i=GetNumPartyMembers(),1,-1 do
    if ( CH_UnitName('party'..i) == unitIdx ) then
      if ( isPet ) then
        return( 'partypet'..i );
      else
        return( 'party'..i );
      end
    end
  end

  for i=GetNumRaidMembers(),1,-1 do
    if ( CH_UnitName('raid'..i) == unitIdx ) then
      if ( isPet ) then
        return( 'raidpet'..i );
      else
        return( 'raid'..i );
      end
    end
  end

  return( nil );

end

function CH_ReTarget( unit )

  local len = strlen( unit );

  if ( CH_IsUnitIDUnique(unit) ) then
    CH_TargetUnitSilently( unit );
  else
    CH_TargetLastTargetSilently();
  end

end

function CH_ClearTargetSilently()

  gSilentTarget = true;
  ClearTarget();

end

function CH_TargetUnitSilently( unit )

  gSilentTarget = true;
  TargetUnit( unit );

end

function CH_TargetLastTargetSilently()

  gSilentTarget = true;
  TargetLastTarget();

end

-- ==========================================================================================================================
-- Loading of variables
-- ==========================================================================================================================
function CH_InitVars()

  local mbIdx,mbIdxData,mb,actionType, i, k, v;
  local playerClass = CH_UnitClass('player');

  -- ----- initializing action list
  CH_ActionList = { 
   CONFIG   = {editable=nil,       editable2=nil, isMetaspell=false, plugin=nil, func=CH_HelpButton},
   TARGET   = {editable=nil,       editable2=nil, isMetaspell=false, plugin=nil, func=CH_ActionTargetUnit},
   ASSIST   = {editable=nil,       editable2=nil, isMetaspell=false, plugin=nil, func=CH_ActionAssistUnit},
   ATTACK   = {editable=nil,       editable2=nil, isMetaspell=false, plugin=nil, func=CH_ActionAttackUnit},
   PETATTACK= {editable='SPECIAL', editable2=nil, isMetaspell=false, plugin=nil, func=CH_ActionPetAttackUnit},
   USEWAND  = {editable=nil,       editable2=nil, isMetaspell=false, plugin=nil, func=CH_ActionUseWand},
   ANYITEM  = {editable='TEXT',    editable2=nil, isMetaspell=false, plugin=nil, func=CH_ActionUseAnyItem},
   TOTEMSET = {editable='SPECIAL', editable2=nil, isMetaspell=false, plugin=nil, func=CH_ActionStompTotem},
   CHAIN    = {editable='SPECIAL', editable2=nil, isMetaspell=false, plugin=nil, func=CH_ActionProcessChain},
   SCRIPT   = {editable='TEXT',    editable2=nil, isMetaspell=false, plugin=nil, func=CH_ActionExecuteScript},
   MENU     = {editable=nil,       editable2=nil, isMetaspell=false, plugin=nil, func=CH_ActionMenu},
   TOOLTIP  = {editable=nil,       editable2=nil, isMetaspell=false, plugin=nil, func=CH_ActionTooltip},
   SPELL    = {editable='SPECIAL', editable2=nil, isMetaspell=false, plugin=nil, func=nil},
   PETSPELL = {editable='SPECIAL', editable2=nil, isMetaspell=false, plugin=nil, func=nil},
   QUICK    = {editable=nil,       editable2=nil, isMetaspell=true,  plugin=nil, func=nil},
   HOT      = {editable=nil,       editable2=nil, isMetaspell=true,  plugin=nil, func=nil},
   SLOW     = {editable=nil,       editable2=nil, isMetaspell=true,  plugin=nil, func=nil},
   SHIELD   = {editable=nil,       editable2=nil, isMetaspell=true,  plugin=nil, func=nil},
   BUFF     = {editable='SPECIAL', editable2=nil, isMetaspell=true,  plugin=nil, func=nil},
   DEBUFF   = {editable=nil,       editable2=nil, isMetaspell=true,  plugin=nil, func=nil},
   PANIC    = {editable=nil,       editable2=nil, isMetaspell=false, plugin=nil, func=nil},
   GRPBUFF  = {editable='SPECIAL', editable2=nil, isMetaspell=false, plugin=nil, func=nil},
   GRPCURE  = {editable=nil,       editable2=nil, isMetaspell=false, plugin=nil, func=nil},
   NONE     = {editable=nil,       editable2=nil, isMetaspell=false, plugin=nil, func=nil},
  };

  CH_ActionList.CONFIG.allowed =    {'extra'};
  CH_ActionList.TARGET.allowed =    {'friend','enemy'};
  CH_ActionList.ASSIST.allowed =    {'friend'};
  CH_ActionList.ATTACK.allowed =    {'enemy','chain'};
  CH_ActionList.PETATTACK.allowed = {'enemy','chain'};
  CH_ActionList.USEWAND.allowed =   {'enemy','chain'};
  CH_ActionList.ANYITEM.allowed =   {'friend','enemy','panic','extra'};
  CH_ActionList.TOTEMSET.allowed =  {'extra'};
  CH_ActionList.CHAIN.allowed =     {'enemy'};
  CH_ActionList.SCRIPT.allowed =    {'friend','enemy','panic','extra'};
  CH_ActionList.MENU.allowed =      {'friend','enemy'};
  CH_ActionList.TOOLTIP.allowed =   {'friend','enemy'};
  CH_ActionList.SPELL.allowed =     {'friend','enemy','panic','extra','chain'};
  CH_ActionList.PETSPELL.allowed =  {'friend','enemy','panic','extra','chain'};
  CH_ActionList.QUICK.allowed =     {'friend'};
  CH_ActionList.HOT.allowed =       {'friend'};
  CH_ActionList.SLOW.allowed =      {'friend'};
  CH_ActionList.SHIELD.allowed =    {'friend'};
  CH_ActionList.BUFF.allowed =      {'friend'};
  CH_ActionList.DEBUFF.allowed =    {'friend'};
  CH_ActionList.PANIC.allowed =     {'panic'};
  CH_ActionList.GRPBUFF.allowed =   {'panic','extra'};
  CH_ActionList.GRPCURE.allowed =   {'panic','extra'};
  CH_ActionList.NONE.allowed =      {'friend','enemy','panic','extra','chain'};

  CH_ActionList.CONFIG.classes =    {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=1,WARLOCK=1,MAGE=1,ROGUE=1,WARRIOR=1};
  CH_ActionList.TARGET.classes =    {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=1,WARLOCK=1,MAGE=1,ROGUE=1,WARRIOR=1};
  CH_ActionList.ASSIST.classes =    {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=1,WARLOCK=1,MAGE=1,ROGUE=1,WARRIOR=1};
  CH_ActionList.ATTACK.classes =    {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=1,WARLOCK=1,MAGE=1,ROGUE=1,WARRIOR=1};
  CH_ActionList.PETATTACK.classes = {PRIEST=0,DRUID=0,SHAMAN=0,PALADIN=0,HUNTER=1,WARLOCK=1,MAGE=0,ROGUE=0,WARRIOR=0};
  CH_ActionList.USEWAND.classes =   {PRIEST=1,DRUID=0,SHAMAN=0,PALADIN=0,HUNTER=1,WARLOCK=1,MAGE=1,ROGUE=1,WARRIOR=1};
  CH_ActionList.ANYITEM.classes =   {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=1,WARLOCK=1,MAGE=1,ROGUE=1,WARRIOR=1};
  CH_ActionList.TOTEMSET.classes =  {PRIEST=0,DRUID=0,SHAMAN=1,PALADIN=0,HUNTER=0,WARLOCK=0,MAGE=0,ROGUE=0,WARRIOR=0};
  CH_ActionList.CHAIN.classes =     {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=1,WARLOCK=1,MAGE=1,ROGUE=1,WARRIOR=1};
  CH_ActionList.SCRIPT.classes =    {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=1,WARLOCK=1,MAGE=1,ROGUE=1,WARRIOR=1};
  CH_ActionList.MENU.classes =      {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=1,WARLOCK=1,MAGE=1,ROGUE=1,WARRIOR=1};
  CH_ActionList.TOOLTIP.classes =   {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=1,WARLOCK=1,MAGE=1,ROGUE=1,WARRIOR=1};
  CH_ActionList.SPELL.classes =     {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=1,WARLOCK=1,MAGE=1,ROGUE=1,WARRIOR=1};
  CH_ActionList.PETSPELL.classes =  {PRIEST=0,DRUID=0,SHAMAN=0,PALADIN=0,HUNTER=1,WARLOCK=1,MAGE=0,ROGUE=0,WARRIOR=0};
  CH_ActionList.QUICK.classes =     {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=0,WARLOCK=0,MAGE=0,ROGUE=0,WARRIOR=0};
  CH_ActionList.HOT.classes =       {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=0,WARLOCK=0,MAGE=0,ROGUE=0,WARRIOR=0};
  CH_ActionList.SLOW.classes =      {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=0,WARLOCK=0,MAGE=0,ROGUE=0,WARRIOR=0};
  CH_ActionList.SHIELD.classes =    {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=0,WARLOCK=0,MAGE=0,ROGUE=0,WARRIOR=0};
  CH_ActionList.BUFF.classes =      {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=0,WARLOCK=1,MAGE=1,ROGUE=0,WARRIOR=0};
  CH_ActionList.DEBUFF.classes =    {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=0,WARLOCK=0,MAGE=1,ROGUE=0,WARRIOR=0};
  CH_ActionList.PANIC.classes =     {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=0,WARLOCK=1,MAGE=1,ROGUE=0,WARRIOR=0};
  CH_ActionList.GRPBUFF.classes =   {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=0,WARLOCK=1,MAGE=1,ROGUE=0,WARRIOR=0};
  CH_ActionList.GRPCURE.classes =   {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=0,WARLOCK=0,MAGE=1,ROGUE=0,WARRIOR=0};
  CH_ActionList.NONE.classes =      {PRIEST=1,DRUID=1,SHAMAN=1,PALADIN=1,HUNTER=1,WARLOCK=1,MAGE=1,ROGUE=1,WARRIOR=1};

  CH_ActionListSort = {'QUICK','HOT','SLOW','SHIELD','BUFF','DEBUFF','PANIC','GRPBUFF','GRPCURE','SPELL','PETSPELL','TOTEMSET','CHAIN',
                       'TARGET','ASSIST','ATTACK','PETATTACK','USEWAND','ANYITEM','SCRIPT','MENU','TOOLTIP','CONFIG','NONE'};

  -- ----- initialize mouse spells
  if ( CH_MouseSpells == nil ) then					-- first load
    CH_ConfigReset( 'ALL', 'ALL' );
  end

  -- initialize config
  CH_ConfigInit();

  -- cleanup config (remove invalid or expired entries)
  CH_ConfigCleanup();

  -- slash cmd
  SlashCmdList["CLICKHEALCONF"] = CH_SlashCmdClickHeal;
  SLASH_CLICKHEALCONF1 = "/clickheal";
  if ( CH_SLASH_COMMAND_LOCAL ) then
    SLASH_CLICKHEALCONF2 = CH_SLASH_COMMAND_LOCAL;
  end

  -- mana regain
  if ( UnitPowerType('player') == POWER_MANA ) then
    gUnitManaLast = UnitMana( 'player' );
  end

end

-- ==========================================================================================================================
-- Masking functions
-- ==========================================================================================================================

function CH_MaskFunctions()

  gOriginalFunction['UseContainerItem'] = UseContainerItem;
  UseContainerItem = CH_UseContainerItemMasked;
  gOriginalFunction['CastSpell'] = CastSpell;
  CastSpell = CH_CastSpellMasked;
  gOriginalFunction['CastSpellByName'] = CastSpellByName;
  CastSpellByName = CH_CastSpellByNameMasked;
  gOriginalFunction['UseAction'] = UseAction;
  UseAction = CH_UseActionMasked;
  gOriginalFunction['SpellTargetUnit'] = SpellTargetUnit;
  SpellTargetUnit = CH_SpellTargetUnitMasked;
  gOriginalFunction['SpellStopTargeting'] = SpellStopTargeting;
  SpellStopTargeting = CH_SpellStopTargetingMasked;
  gOriginalFunction['TargetUnit'] = TargetUnit;
  TargetUnit = CH_TargetUnitMasked;
  gOriginalFunction['PlaySound'] = PlaySound;
  PlaySound = CH_PlaySoundMasked;


  CH_MaskWoWGuiFunctions();

  -- CTRA main tanks
  gOriginalFunction['CT_RATarget_SetMT'] = CT_RATarget_SetMT;
  CT_RATarget_SetMT = CH_CTRASetMT;
  gOriginalFunction['CT_RATarget_RemoveMT'] = CT_RATarget_RemoveMT;
  CT_RATarget_RemoveMT = CH_CTRARemoveMT;

end

function CH_UseContainerItemMasked( bag, slot )

  CH_HealRangeAbortScan();

  gOriginalFunction['UseContainerItem']( bag, slot );

  gLastUsedBagItem = {bag=bag,slot=slot,useTime=GetTime()};

end

-- ==========================================================================================================================
-- Std Wow Integration
-- ==========================================================================================================================

function CH_MaskWoWGuiFunctions()

  gOriginalFunction['PlayerFrame_OnClick'] = PlayerFrame_OnClick;
  PlayerFrame_OnClick = CH_PlayerFrameOnClickMasked;
  gOriginalFunction['PartyMemberFrame_OnClick'] = PartyMemberFrame_OnClick;
  PartyMemberFrame_OnClick = CH_PartyMemberFrameOnClickMasked;
  gOriginalFunction['PartyMemberPetFrame_OnClick'] = PartyMemberPetFrame_OnClick;
  PartyMemberPetFrame_OnClick = CH_PartyMemberPetFrameOnClickMasked;
  gOriginalFunction['PetFrame_OnClick'] = PetFrame_OnClick;
  PetFrame_OnClick = CH_PetFrameOnClickMasked;
  gOriginalFunction['TargetFrame_OnClick'] = TargetFrame_OnClick;
  TargetFrame_OnClick = CH_TargetFrameOnClickMasked;
  gOriginalFunction['TargetofTarget_OnClick'] = TargetofTarget_OnClick;
  TargetofTarget_OnClick = CH_TargetofTargetOnClickMasked;

  CH_WowGuiRegisterClicks();

end

function CH_WowGuiRegisterClicks( )

  if ( CH_Config.WoWGuiEnabled ) then
    PlayerFrame:RegisterForClicks( "LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down" );
    PartyMemberFrame1:RegisterForClicks( "LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down" );
    PartyMemberFrame2:RegisterForClicks( "LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down" );
    PartyMemberFrame3:RegisterForClicks( "LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down" );
    PartyMemberFrame4:RegisterForClicks( "LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down" );
    PetFrame:RegisterForClicks( "LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down" );
    PartyMemberFrame1PetFrame:RegisterForClicks( "LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down" );
    PartyMemberFrame2PetFrame:RegisterForClicks( "LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down" );
    PartyMemberFrame3PetFrame:RegisterForClicks( "LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down" );
    PartyMemberFrame4PetFrame:RegisterForClicks( "LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down" );
    TargetFrame:RegisterForClicks( "LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down" );
    TargetofTargetFrame:RegisterForClicks( "LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down" );
  else
    PlayerFrame:RegisterForClicks( "LeftButtonUp", "RightButtonUp" );
    PartyMemberFrame1:RegisterForClicks( "LeftButtonUp", "RightButtonUp" );
    PartyMemberFrame2:RegisterForClicks( "LeftButtonUp", "RightButtonUp" );
    PartyMemberFrame3:RegisterForClicks( "LeftButtonUp", "RightButtonUp" );
    PartyMemberFrame4:RegisterForClicks( "LeftButtonUp", "RightButtonUp" );
    PetFrame:RegisterForClicks( "LeftButtonUp", "RightButtonUp" );
    PartyMemberFrame1PetFrame:RegisterForClicks( "LeftButtonUp", "RightButtonUp" );
    PartyMemberFrame2PetFrame:RegisterForClicks( "LeftButtonUp", "RightButtonUp" );
    PartyMemberFrame3PetFrame:RegisterForClicks( "LeftButtonUp", "RightButtonUp" );
    PartyMemberFrame4PetFrame:RegisterForClicks( "LeftButtonUp", "RightButtonUp" );
    TargetFrame:RegisterForClicks( "LeftButtonUp", "RightButtonUp" );
    TargetofTargetFrame:RegisterForClicks( "LeftButtonUp", "RightButtonUp" );
  end

end

function CH_PlayerFrameOnClickMasked( button )

  if ( CH_Config.WoWGuiEnabled ) then
    CH_FriendlyClicked( 'player', arg1 );
  else
    gOriginalFunction['PlayerFrame_OnClick']( button );
  end

end

function CH_PartyMemberFrameOnClickMasked( frame )

  if ( CH_Config.WoWGuiEnabled ) then
    CH_FriendlyClicked( this.unit, arg1 );
  else
    gOriginalFunction['PartyMemberFrame_OnClick']( frame );
  end

end

function CH_PartyMemberPetFrameOnClickMasked( frame )

  if ( CH_Config.WoWGuiEnabled ) then
    CH_FriendlyClicked( this.unit, arg1 );
  else
    gOriginalFunction['PartyMemberPetFrame_OnClick']( frame );
  end

end

function CH_PetFrameOnClickMasked( button )

  if ( CH_Config.WoWGuiEnabled ) then
    CH_FriendlyClicked( 'pet', arg1 );
  else
    gOriginalFunction['PetFrame_OnClick']( button );
  end

end

function CH_TargetFrameOnClickMasked( button )

  if ( CH_Config.WoWGuiEnabled ) then
    CH_UnitClicked( 'target', arg1 );
  else
    gOriginalFunction['TargetFrame_OnClick']( button );
  end

end

function CH_TargetofTargetOnClickMasked( button )

  if ( CH_Config.WoWGuiEnabled ) then
    CH_UnitClicked( 'targettarget', arg1 );
  else
    gOriginalFunction['TargetofTarget_OnClick']( button );
  end

end

-- ==========================================================================================================================
-- Needy Lists
-- ==========================================================================================================================

local function CHL_NeedyListGetConfig( nlType )

  return( 'needyList'..strsub(nlType,1,1)..strlower(strsub(nlType,2)) );

end

local function CHL_NeedyListGetAnchor( nlType )

  if ( nlType == 'HEAL' ) then
    return( CH_NeedyListHealAnchor );
  elseif ( nlType == 'BUFF' ) then
    return( CH_NeedyListBuffAnchor );
  elseif ( nlType == 'CURE' ) then
    return( CH_NeedyListCureAnchor );
  elseif ( nlType == 'DEAD' ) then
    return( CH_NeedyListDeadAnchor );
  end

  return( nil );

end

local function CHL_NeedyListShouldShow( nlType )

  local conf = CH_Config[CHL_NeedyListGetConfig(nlType)..'Enabled'];
  local hideInBF = CH_Config[CHL_NeedyListGetConfig(nlType)..'HideInBattlefield'];

  if ( conf == 'ALWAYS' ) then
    return( not (hideInBF and CH_PlayerIsInBattlefield()) );
  elseif ( (conf == 'PARTY' or conf == 'PARTYRAID') and GetNumPartyMembers() > 0 ) then
    return( not (hideInBF and CH_PlayerIsInBattlefield()) );
  elseif ( (conf == 'RAID' or conf == 'PARTYRAID') and GetNumRaidMembers() > 0 ) then
    return( not (hideInBF and CH_PlayerIsInBattlefield()) );
  end

  return( false );

end

local function CHL_NeedyListShouldShowUnit( nlType, unit )

  local raidSubGroup, i;
  local option = CHL_NeedyListGetConfig( nlType );

  -- should the list be shown?
  if ( not CHL_NeedyListShouldShow(nlType) ) then
    return( false );
  end

  -- ALWAYS main tanks
  if ( nlType == 'HEAL' and CH_Config.needyListHealLockTanks and CH_MainTankIndex(unit) ~= nil ) then
    return( true );
  end

  -- is connected
  if ( not UnitIsConnected(unit) ) then
    return( false );
  end

  -- should this class be shown?
  if ( not CH_Config[option..'ShowClass'..CH_UnitClass(unit)] ) then
    return( false );
  end

  -- range checking
  if ( CH_Config[option..'HideOOR'] == 'POSSIBLE' and CH_IsUnitInRange(unit,nlType) < 0 ) then
    return( false );
  elseif ( CH_Config[option..'HideOOR'] == 'VERIFIED' and CH_IsUnitInRange(unit,nlType) == -2 ) then
    return( false );
  end

  -- should this "unit" be shown?
  if ( (not CH_Config[option..'ShowPlayer']) and UnitIsUnit('player',unit) ) then
    return( false );
  elseif ( (not CH_Config[option..'ShowPet']) and UnitIsUnit('pet',unit) ) then
    return( false );
  elseif ( (not CH_Config[option..'ShowParty']) and CH_UnitPlayerInParty(unit) ) then
    return( false );
  elseif ( (not CH_Config[option..'ShowPartyPets']) and (not UnitIsPlayer(unit)) and CH_UnitInParty(unit) ) then
    return( false );
  elseif ( UnitIsPlayer(unit) and CH_UnitInRaidOnly(unit) ) then
    i = GetNumRaidMembers();
    while ( i > 0 and (not UnitIsUnit('raid'..i,unit)) ) do
      i = i - 1;
    end
    if ( i > 0 ) then
      _,_,raidSubGroup = GetRaidRosterInfo( i );
      if ( not CH_Config[option..'ShowRaidGroup'..raidSubGroup] ) then
        return( false );
      end
    end
  elseif ( (not CH_Config[option..'ShowRaidPets']) and (not UnitIsPlayer(unit)) and CH_UnitInRaidOnly(unit) ) then
    return( false );
  end

  -- LAST check conditions
  if ( nlType == 'HEAL' and floor(CH_CalcPercentage(UnitHealth(unit),UnitHealthMax(unit))) <= CH_Config.needyListHealHealthPercentage and (not CH_UnitIsDeadOrGhostForReal(unit)) ) then
    return( true );
  elseif ( nlType == 'BUFF' and CH_EffectsAsString(unit,'BUFF') ~= '') then
    return( true );
  elseif ( nlType == 'CURE' and ((CH_Config.needyListCureShowCurse and CH_IsEffectedBy(unit,CH_EFFECT_CURSE,false)) or
                                 (CH_Config.needyListCureShowPoison and CH_IsEffectedBy(unit,CH_EFFECT_POISON,false)) or
                                 (CH_Config.needyListCureShowDisease and CH_IsEffectedBy(unit,CH_EFFECT_DISEASE,false)) or
                                 (CH_Config.needyListCureShowMagic and CH_IsEffectedBy(unit,CH_EFFECT_MAGIC,false))) )
  then
    return( true );
  elseif ( nlType == 'DEAD' and CH_UnitIsDeadOrGhostForReal(unit) ) then
    return( true );
  end

  return( false );

end

local function CHL_NeedyListShouldScan( nlType )

  local conf = CHL_NeedyListGetConfig( nlType );

  if ( not CHL_NeedyListShouldShow(nlType) ) then
    return( false );
  elseif ( nlType == 'HEAL' and
           (gNeedyList[nlType].lastScan > GetTime() - CH_Config.needyListHealScanInterval or 
               (CH_NeedyListHealAnchor.members >= CH_Config.needyListHealMaxUnits and CH_Config[conf..'Sort'] ~= 'EMERGENCY' and CH_Config[conf..'Sort'] ~= 'EMERGLOCKED')) )
  then
    return( false );
  elseif ( nlType == 'BUFF' and
           (gNeedyList[nlType].lastScan > GetTime() - CH_Config.needyListBuffScanInterval or CH_NeedyListBuffAnchor.members >= CH_Config.needyListBuffMaxUnits) )
  then
    return( false );
  elseif ( nlType == 'CURE'and
           (gNeedyList[nlType].lastScan > GetTime() - CH_Config.needyListCureScanInterval or CH_NeedyListCureAnchor.members >= CH_Config.needyListCureMaxUnits) )
  then
    return( false );
  elseif ( nlType == 'DEAD' and
         (gNeedyList[nlType].lastScan > GetTime() - CH_Config.needyListDeadScanInterval or CH_NeedyListDeadAnchor.members >= CH_Config.needyListDeadMaxUnits) )
  then
    return( false );
  end

  return( true );

end

local function CH_NeedyListUpdateUnitIdx( anchor, unitIdx, nlType )

  local unit;
  local oldUnit = anchor.unitAssign[unitIdx].unit;
  local newUnitIdx = CH_UnitListIndex( oldUnit, true );

  if ( (not newUnitIdx) or unitIdx ~= newUnitIdx or     					-- unit changed
       CH_UnitInParty(oldUnit) and strsub(oldUnit,1,5) ~= 'party' )				-- or joined party
  then
    unit = CH_UnitListIndexToUnitID( unitIdx, false );
    if ( unit ) then
      anchor.unitAssign[unitIdx].unit = unit;							-- update with new unit
      CH_OnUnitFrameLoad( unit, anchor.unitAssign[unitIdx].frameUnit, nlType );
    else
      return( false );										-- unit left party/raid
    end
    
  end

  return( true );
 
end

local function CHL_NeedyListUpdateHealthiest( anchor )

  local unitIdx, unit, hpPerc, healRange, isMT;

  anchor.healthiestUnitIdx = nil;
  anchor.healthiestHealth = nil;
  anchor.healthiestHealRange = nil;
  anchor.healthiestIsMT = nil;

  for unitIdx,_ in anchor.unitAssign do
    unit = anchor.unitAssign[unitIdx].unit;
    hpPerc = floor( CH_CalcPercentage(UnitHealth(unit),UnitHealthMax(unit)) );
    healRange = CH_IsUnitInRange( unit, 'HEAL' );
    isMT = anchor.unitAssign[unitIdx].frame.isMT;
    if( not anchor.healthiestUnitIdx or 							-- first unit
        ((not isMT) and anchor.healthiestIsMT and CH_Config.needyListHealLockTanks) or		-- always prefer non MTs to MTs when MTs should be locked
        healRange < anchor.healthiestHealRange or 						-- the "further" away (1 in range, 0 unknow, -1 possibly, -2 certainly)
        hpPerc > anchor.healthiestHealth )							-- higher health
    then
      anchor.healthiestUnitIdx = unitIdx;
      anchor.healthiestHealth = hpPerc;
      anchor.healthiestHealRange = healRange;
      anchor.healthiestIsMT = isMT;
    end
  end

end

local function CHL_NeedyListReplaceHealthiest( anchor, unit, nlType, isMT )

  local frame, frameUnit;
  local hpPerc = floor( CH_CalcPercentage(UnitHealth(unit),UnitHealthMax(unit)) );

  -- no cached values, cache them
  if ( not anchor.healthiestUnitIdx ) then
    CHL_NeedyListUpdateHealthiest( anchor );
  end

  -- found one?, replace it
  if ( not anchor.healthiestUnitIdx ) then
    return;
  elseif ( CH_Config.needyListHealLockTanks and anchor.healthiestIsMT and (not isMT) ) then	-- lock MTs, healthiest is MT, i am no MT
    return;
  elseif (CH_Config.needyListHealLockTanks and (isMT and (not anchor.healthiestIsMT)) or	-- prefer MTs to non MTs, when config
         (anchor.healthiestHealRange == -2 and CH_IsUnitInRange(unit,'HEAL') ~= -2) or		-- in range, but 'healthiest' not in range
         hpPerc < anchor.healthiestHealth )							-- more wounded
  then
    frame = anchor.unitAssign[anchor.healthiestUnitIdx].frame;
    frameUnit = anchor.unitAssign[anchor.healthiestUnitIdx].frameUnit;

    frame.isMT = isMT;
    anchor.unitAssign[anchor.healthiestUnitIdx] = nil;
    anchor.unitAssign[CH_UnitListIndex(unit,false)] = {frame=frame,unit=unit,frameUnit=frameUnit};

    CH_OnUnitFrameLoad( unit, frameUnit, nlType );
    CH_OnUnitFrameUpdate( frame.index, frameUnit, frame.frameData, false, not UnitIsPlayer(frame.index), false, false, true );

    -- reset the cached values
    anchor.healthiestUnitIdx = nil;
  end

end

local function CHL_NeedyListTryAddUnit( unit, nlType, anchor, anchorID, isMT )

  local frameName, frame;
  local unitIdx;
  local conf = CHL_NeedyListGetConfig( nlType );
  local i = 1;

  if ( not (unit and UnitExists(unit)) ) then			-- check before normalize (speed)
    return;
  end

  unit = CH_NormalizeUnit( unit );
  unitIdx = CH_UnitListIndex( unit, true );

  -- unit already in list?
  if ( anchor.unitAssign[unitIdx] ) then
    return;
  end

  -- should displaye unit?
  if ( not CHL_NeedyListShouldShowUnit(nlType,unit) ) then
    return;
  end

  -- already too many members
  if ( anchor.members >= CH_Config[conf..'MaxUnits'] or anchor.members >= CH_MAX_NEEDY_LIST_MEMBERS ) then
    if ( nlType == 'HEAL' and (CH_Config[conf..'Sort'] == 'EMERGENCY' or CH_Config[conf..'Sort'] == 'EMERGLOCKED') ) then
      CHL_NeedyListReplaceHealthiest( anchor, unit, nlType, isMT );
    end
    return;
  end

  -- find first free (hidden) frame
  frame = getglobal( 'CH_NeedyList'..nlType..i..'Frame' );
  while ( frame and frame.isInUse ) do
    i = i + 1;
    frame = getglobal( 'CH_NeedyList'..nlType..i..'Frame' );
  end

  -- found a free frame and sortmode == 'LOCKED' ?
  if ( frame and (CH_Config[conf..'Sort'] == 'LOCKED' or CH_Config[conf..'Sort'] == 'EMERGLOCKED') ) then
    frame:SetWidth( CH_Config[conf..'FrameWidth'] );
    frame:SetHeight( CH_Config[conf..'FrameHeight'] );
    frame:SetScale( CH_Config[conf..'FrameScale'] / 100 );
    frame.chNeedyListAnchor = anchor;							-- for tooltips
    frame.isMT = isMT;
    frame.isInUse = true;

    anchor.unitAssign[unitIdx] = {frame=frame,unit=unit,frameUnit='NeedyList'..nlType..i};
    anchor.members = anchor.members + 1;
    anchor.chNeedyListConf = conf;							-- for tooltips
    CH_AnchorUpdateVisibility( anchor, nlType, anchor.members > 0 );

    CH_OnUnitFrameLoad( unit, 'NeedyList'..nlType..i, nlType );
    CH_OnUnitFrameUpdate( frame.index, 'NeedyList'..nlType..i, frame.frameData, false, not UnitIsPlayer(frame.index), false, false, true );
    frame:Show();
  -- other sortmode
  elseif ( frame ) then
    frame:ClearAllPoints();
    frame:SetPoint( CH_AnchorGrowToPoint(anchorID), anchor.bottomFrame or anchor, CH_AnchorGrowToRelativePoint(anchorID), 0, 0 );
    frame:SetWidth( CH_Config[conf..'FrameWidth'] );
    frame:SetHeight( CH_Config[conf..'FrameHeight'] );
    frame:SetScale( CH_Config[conf..'FrameScale'] / 100 );
    frame.chNeedyListAnchor = anchor;							-- for tooltips
    frame.isMT = isMT;
    frame.isInUse = true;

    CH_AnchorSetTopFrame( anchor, anchor.topFrame or frame );
    CH_AnchorSetBottomFrame( anchor, frame );
    anchor.unitAssign[unitIdx] = {frame=frame,unit=unit,frameUnit='NeedyList'..nlType..i};
    anchor.members = anchor.members + 1;
    anchor.chNeedyListConf = conf;							-- for tooltips
    table.insert( anchor.frameList, frame );
    CH_AnchorUpdateVisibility( anchor, nlType, anchor.members > 0 );

    CH_OnUnitFrameLoad( unit, 'NeedyList'..nlType..i, nlType );
    CH_OnUnitFrameUpdate( frame.index, 'NeedyList'..nlType..i, frame.frameData, false, not UnitIsPlayer(frame.index), false, false, true );
    frame:Show();
  end

end

local function CHL_NeedyListRemoveUnit( nlType, unitIdx )

  local i = 1;
  local conf = CHL_NeedyListGetConfig( nlType );
  local anchor = CHL_NeedyListGetAnchor(nlType);
  local anchorID = CH_AnchorFrameNameToID(anchor:GetName());
  local removeFrame = anchor.unitAssign[unitIdx].frame;

  -- sortmode locked, no relinking necessary 
  if ( CH_Config[conf..'Sort'] == 'LOCKED' or CH_Config[conf..'Sort'] == 'EMERGLOCKED' ) then
    if ( removeFrame ) then
      anchor.members = anchor.members - 1;
      anchor.unitAssign[unitIdx] = nil;
      removeFrame.isInUse = nil;
      removeFrame:Hide();
      CH_AnchorUpdateVisibility( anchor, nlType, anchor.members > 0 );
    end

    return;
  end

  -- find frame to be removed
  while ( i <= anchor.members and anchor.frameList[i] ~= removeFrame ) do
    i = i + 1;
  end

  -- found unit, remove it
  if ( i <= anchor.members ) then
    if ( anchor.members == 1 ) then			-- only member in list
      CH_AnchorSetTopFrame( anchor, nil );
      CH_AnchorSetBottomFrame( anchor, nil );
    elseif ( i == 1 ) then				-- first in list
      anchor.frameList[i+1]:ClearAllPoints();
      anchor.frameList[i+1]:SetPoint( CH_AnchorGrowToPoint(anchorID), anchor, CH_AnchorGrowToRelativePoint(anchorID), 0, 0 );
      CH_AnchorSetTopFrame( anchor, anchor.frameList[i+1] );
    elseif ( i == anchor.members ) then			-- last in list
      CH_AnchorSetBottomFrame( anchor, anchor.frameList[i-1] );
    else						-- somewhere in the middle
      anchor.frameList[i+1]:ClearAllPoints();
      anchor.frameList[i+1]:SetPoint( CH_AnchorGrowToPoint(anchorID), anchor.frameList[i-1], CH_AnchorGrowToRelativePoint(anchorID), 0, 0 );
    end

    anchor.members = anchor.members - 1;
    anchor.unitAssign[unitIdx] = nil;
    anchor.frameList[i]:ClearAllPoints();
    anchor.frameList[i].isInUse = nil;
    anchor.frameList[i]:Hide();
    table.remove( anchor.frameList, i );
    CH_AnchorUpdateVisibility( anchor, nlType, anchor.members > 0 );
  end

end

local function CHL_NeedyListScan( nlType, scanMTs )

  local i, unit;
  local conf = CHL_NeedyListGetConfig( nlType );
  local anchor = CHL_NeedyListGetAnchor( nlType );
  local anchorID = CH_AnchorFrameNameToID( anchor:GetName() );

  -- update last scan time
  gNeedyList[nlType].lastScan = GetTime();

  -- store health info for speed on emergency sorting
  if ( nlType == 'HEAL' and (CH_Config[conf..'Sort'] == 'EMERGENCY' or CH_Config[conf..'Sort'] == 'EMERGLOCKED') ) then
    anchor.healthiestUnitIdx = nil;
  end

  -- if HEAL, then tanks first if so configed
  if ( scanMTs and nlType == 'HEAL' and CH_Config.needyListHealLockTanks ) then
    for i=1,CH_MAX_MAIN_TANKS do
      unit = CH_MainTankGetUnit( i );
      if ( unit ) then
        CHL_NeedyListTryAddUnit( unit, nlType, anchor, anchorID, true );
      end
    end
  end

  -- first players
  CHL_NeedyListTryAddUnit( 'player', nlType, anchor, anchorID, false );

  if ( GetNumPartyMembers() > 0 ) then
    for i=1,GetNumPartyMembers() do
      CHL_NeedyListTryAddUnit( 'party'..i, nlType, anchor, anchorID, false );
    end
  end

  if ( GetNumRaidMembers() > 0 ) then
    for i=1,GetNumRaidMembers() do
      CHL_NeedyListTryAddUnit( 'raid'..i, nlType, anchor, anchorID, false );
    end
  end

  -- then pets
  if ( CH_Config[conf..'ShowPet'] ) then
    CHL_NeedyListTryAddUnit( 'pet', nlType, anchor, anchorID, false );
  end

  if ( CH_Config[conf..'ShowPartyPets'] ) then
    if ( GetNumPartyMembers() > 0 ) then
      for i=1,GetNumPartyMembers() do
        CHL_NeedyListTryAddUnit( 'partypet'..i, nlType, anchor, anchorID, false );
      end
    end
  end

  if ( CH_Config[conf..'ShowRaidPets'] ) then
    if ( GetNumRaidMembers() > 0 ) then
      for i=1,GetNumRaidMembers() do
        CHL_NeedyListTryAddUnit( 'raidpet'..i, nlType, anchor, anchorID, false );
      end
    end
  end

end

local function CHL_NeedyListWipe( nlType, forceRedraw )

  local frame;
  local i, anchorID, point, relativePoint;
  local anchor = CHL_NeedyListGetAnchor(nlType);
  local conf = CHL_NeedyListGetConfig( nlType );

  -- hide all frames
  for _,frame in anchor.frameList do
    frame:ClearAllPoints();
    frame.isInUse = nil;
    frame:Hide();
  end

  -- reset anchor data
  CH_AnchorSetTopFrame( anchor, nil );
  CH_AnchorSetBottomFrame( anchor, nil );
  anchor.frameList = {};
  anchor.unitAssign = {};
  anchor.members = 0;

  -- sort mode is 'locked'
  if ( CH_Config[conf..'Sort'] == 'LOCKED' or CH_Config[conf..'Sort'] == 'EMERGLOCKED' ) then
    anchorID = CH_AnchorFrameNameToID( anchor:GetName() );
    point = CH_AnchorGrowToPoint( anchorID );
    relativePoint = CH_AnchorGrowToRelativePoint( anchorID );
    getglobal('CH_NeedyList'..nlType..'1Frame'):SetPoint( point, anchor, relativePoint, 0, 0 );
    table.insert( anchor.frameList, getglobal('CH_NeedyList'..nlType..'1Frame') );
    for i=2,CH_Config[conf..'MaxUnits'] do
      getglobal('CH_NeedyList'..nlType..i..'Frame'):SetPoint( point, getglobal('CH_NeedyList'..nlType..(i-1)..'Frame'), relativePoint, 0, 0 );
      table.insert( anchor.frameList, getglobal('CH_NeedyList'..nlType..i..'Frame') );
    end
    CH_AnchorSetTopFrame( anchor, getglobal('CH_NeedyList'..nlType..'1Frame') );
    CH_AnchorSetBottomFrame( anchor, getglobal('CH_NeedyList'..nlType..CH_Config[conf..'MaxUnits']..'Frame') );
  end

  -- update the visibility (if not already done by rescan)
  CH_AnchorUpdateVisibility( anchor, nlType, anchor.members > 0 );

  -- forced redraw?
  if ( forceRedraw ) then
    CH_AnchorAdjust( nlType );
    CH_AnchorRedockAll();
  end

end

function CH_NeedyListRegisterWipe( nlType, forceRedraw )

  local anchor;

  -- ----- insert event in list
  if ( data == forceRedraw ) then
    gNeedyList[nlType].wipe = 2;			-- force redraw
  else
    gNeedyList[nlType].wipe = 1;			-- "only" wipe
  end

end

function CH_NeedyListProcessEvents( nlType, viaAnchor )

  local forcedRedraw, unit, unitIdx;
  local scanMTs = false;
  local mtIdx = 1; 
  local forceScan = false;
  local anchor = CHL_NeedyListGetAnchor(nlType);
  local shouldShowList = CHL_NeedyListShouldShow(nlType);

  -- ----- quickfix anchor and 'ghost' frames
  if ( anchor:IsVisible() and (not shouldShowList) ) then					-- QUICKFIX only, remove
    anchor:Hide();
  end

  if ( (not shouldShowList) and anchor.members > 0 ) then					-- does this fix above ????
    gNeedyList[nlType].wipe = 2;
  end

  -- ----- already processing or needy list not visible
  if ( gNeedyList[nlType].isProcessing ) then							-- already processing
    return;
  elseif ( gNeedyList[nlType].wipe == 0 and (not shouldShowList) ) then				-- should not be shown and no wipe
    return;
  elseif ( anchor:IsVisible() and (not viaAnchor) ) then					 -- anchor is visible, but called from somewhere else
    return;
  end

  -- ----- set processing state, to avoid concurrent runs
  gNeedyList[nlType].isProcessing = true;

  -- ----- check if all MTs are (on top of) the HEAL list
  if ( nlType == 'HEAL' and CH_Config.needyListHealLockTanks and gNeedyList[nlType].wipe == 0 ) then
    while ( mtIdx <= CH_MAX_MAIN_TANKS and gNeedyList[nlType].wipe == 0 ) do
      unit = CH_MainTankGetUnit( mtIdx );
      if ( unit and (not anchor.unitAssign[CH_UnitListIndex(unit,false)]) ) then
        gNeedyList[nlType].wipe = 1;
      end
      mtIdx = mtIdx + 1;
    end
  end

  -- ----- wipe
  if ( gNeedyList[nlType].wipe ~= 0 ) then
    if ( gNeedyList[nlType].wipe == 2 ) then
      forcedRedraw = true;
    else
      forceRedraw = false;
    end
    gNeedyList[nlType].wipe = 0;
    CHL_NeedyListWipe( nlType, forcedRedraw );
    forceScan = true;
    scanMTs = true;
  end

  -- ----- check if units on list need update (e.g. removal)
  for unitIdx,_ in anchor.unitAssign do
    if ( (not CH_NeedyListUpdateUnitIdx(anchor,unitIdx,nlType)) or 				-- unit left party or invalid index
         (not CHL_NeedyListShouldShowUnit(nlType,anchor.unitAssign[unitIdx].unit)) )		-- or no longer to be displayed (e.g. health > x%)
    then
      CHL_NeedyListRemoveUnit( nlType, unitIdx );
    end
  end

  -- ----- scan
  if ( forceScan or CHL_NeedyListShouldScan(nlType) ) then
    CHL_NeedyListScan( nlType, scanMTs );
  end

  -- reset processing state
  gNeedyList[nlType].isProcessing = false;

end

function CH_NeedyListBuffString( unit )

  local rts = CH_EffectsAsString( unit, 'BUFF' );

  if ( CH_IsEffectedBy(unit,CH_EFFECT_PHASE_SHIFT,false) ) then
    rts = rts .. '|cFF'..CH_COLOR[CH_EFFECT_DATA[CH_EFFECT_PHASE_SHIFT].color].html .. CH_EFFECT_DATA[CH_EFFECT_PHASE_SHIFT].sign .. '|r';
  end

  return( rts );

end

function CH_NeedyListDebuffString( unit )

  local rts = '';

  if ( CH_Config.needyListCureShowCurse and CH_IsEffectedBy(unit,CH_EFFECT_CURSE,false) ) then
    rts = rts .. '|cFF'..CH_COLOR[CH_EFFECT_DATA[CH_EFFECT_CURSE].color].html .. CH_EFFECT_DATA[CH_EFFECT_CURSE].sign;
  end
  if ( CH_Config.needyListCureShowMagic and CH_IsEffectedBy(unit,CH_EFFECT_MAGIC,false) ) then
    rts = rts .. '|cFF'..CH_COLOR[CH_EFFECT_DATA[CH_EFFECT_MAGIC].color].html .. CH_EFFECT_DATA[CH_EFFECT_MAGIC].sign;
  end
  if ( CH_Config.needyListCureShowPoison and CH_IsEffectedBy(unit,CH_EFFECT_POISON,false) ) then
    rts = rts .. '|cFF'..CH_COLOR[CH_EFFECT_DATA[CH_EFFECT_POISON].color].html .. CH_EFFECT_DATA[CH_EFFECT_POISON].sign;
  end
  if ( CH_Config.needyListCureShowDisease and CH_IsEffectedBy(unit,CH_EFFECT_DISEASE,false) ) then
    rts = rts .. '|cFF'..CH_COLOR[CH_EFFECT_DATA[CH_EFFECT_DISEASE].color].html .. CH_EFFECT_DATA[CH_EFFECT_DISEASE].sign;
  end
  if ( CH_IsEffectedBy(unit,CH_EFFECT_PHASE_SHIFT,false) ) then
    rts = rts .. '|cFF'..CH_COLOR[CH_EFFECT_DATA[CH_EFFECT_PHASE_SHIFT].color].html .. CH_EFFECT_DATA[CH_EFFECT_PHASE_SHIFT].sign;
  end

  if ( rts ) then
    rts = rts .. '|r';
  end

  return( rts );

end

-- ==========================================================================================================================
-- Defend yourself
-- ==========================================================================================================================

local function CHL_DefendYourself( isHit )

  -- already initiated attack (waiting for "slow" feedback of client event)
  if ( gPlayerPendingAttack ) then 
    return; 
  end

  -- check my target
  if ( not UnitExists('target') or CH_UnitIsDeadOrGhostForReal('target') ) then
    return;
  end

  -- not under (direct) attack
  if ( not UnitAffectingCombat('player') ) then				-- not under attack at all
    return;
  end

  if ( CH_Config.selfDefenseDirectAttack and (not isHit) ) then		-- not under direct attack
    return;
  end

  -- do not defend in party/raid?
  if ( CH_Config.selfDefenseNotInParty and (GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0) ) then
    return;
  end

  -- check the pet
  if ( CH_Config.selfDefensePetAttackTarget and UnitExists('pet') and (not UnitExists('pettarget')) and UnitCanAttack('pet','target') ) then
    if ( CH_Config.selfDefenseNoMesmerize and CH_UnitIsMesmerized('target') ) then
    else
      PetAttack();
    end
  end

  -- player does not want to defend or in combat or cannot attack 
  if ( (not CH_Config.selfDefenseAttackTarget) or gPlayerActiveMelee or gPlayerActiveAutoShot or (not UnitCanAttack('player','target')) ) then
    return;
  end

  -- no mezzed units if disabled
  if ( CH_Config.selfDefenseNoMesmerize and CH_UnitIsMesmerized('target') ) then
    return;
  end

  -- all checked, we are free to attack now
  if ( not (gPlayerPendingAttack or gPlayerActiveMelee or gPlayerActiveAutoShot) ) then		-- final check, could be set active by other method
    gPlayerPendingAttack = true;
    AttackTarget();
  end

end

-- ==========================================================================================================================
-- Chat Channel Handling
-- ==========================================================================================================================

local function CHL_IsChatChannelJoined( channel )

  local name;

  if ( not channel ) then
    return( false );
  end

  name = string.gsub(channel, "[^%w]", "");

  return( GetChannelName(name) ~= 0 );

end

function CH_JoinChatChannel( channel, password, frame )

  local name, zoneChannel, channelName, i;

  if ( not channel ) then
    return;
  end

  if ( frame == nil ) then
    frame = DEFAULT_CHAT_FRAME;
  end

  name = string.gsub(channel, "[^%w]", "");

  if ( GetChannelName(name) == 0 ) then
    zoneChannel, channelName = JoinChannelByName( name, password, DEFAULT_CHAT_FRAME:GetID() );

    if ( channelName ) then
      name = channelName;
    end
    if ( not zoneChannel ) then
      return;
    end

    i = 1;
    while ( frame.channelList[i] ) do
      i = i + 1;
    end

    frame.channelList[i] = name;
    frame.zoneChannelList[i] = zoneChannel;
  end

end

function CH_LeaveChatChannel( channel )

  local name, serverChannels, sChannel;

  if ( not channel ) then
    return;
  end

  name = string.gsub(channel, "[^%w]", "");

  if ( GetChannelName(name) ~= 0 ) then
    serverChannels = { EnumerateServerChannels() };
    for _,sChannel in serverChannels do
      if ( strlower(sChannel) == strlower(name) ) then			-- dont leave server channels
        return;
      end
    end

    LeaveChannelByName( name );
  end

end

function CH_SendChannelMessage( msg, channelName )

  if ( CHL_IsChatChannelJoined(channelName) ) then
    SendChatMessage( msg, "CHANNEL", nil, GetChannelName(channelName) );
  end

end

function CH_LeaveNotifyChannel( )

  CH_LeaveChatChannel( CH_Config.notifyCustomChannelName );
  gNotifyCustomChannelJoinTime = GetTime() + 1;

end

function CH_CheckNotifyChannel()

  local chatFrame, password;

  if ( gNotifyCustomChannelJoinTime < 0 ) then						-- already joined
    return;
  elseif ( gNotifyCustomChannelJoinTime > GetTime() ) then				-- join in the future
    return;
  elseif ( not EnumerateServerChannels() ) then						-- no server channels yet, we are too fast
    return;
  end

  if ( not CHL_IsChatChannelJoined(CH_Config.notifyCustomChannelName) ) then
    if ( CH_Config.notifyCustomChannelChatFrameName == 'DEFAULT' ) then
      chatFrame = DEFAULT_CHAT_FRAME;
    else
      chatFrame = getglobal( CH_Config.notifyCustomChannelChatFrameName );
    end

    password = CH_Config.notifyCustomChannelPassword;
    if ( password == '' ) then
      password = nil;
    end

    CH_JoinChatChannel( CH_Config.notifyCustomChannelName, password, chatFrame );
  end

  gNotifyCustomChannelJoinTime = -1;

end

-- ==========================================================================================================================
-- MainTanks
-- ==========================================================================================================================

function CH_MainTankUnitName( idx )

  if ( (not idx) or (not CH_MainTanks[idx]) ) then
    return( nil );
  elseif ( strsub(CH_MainTanks[idx],1,6) == 'CTRAMT' and CT_RA_MainTanks ) then
    return( CT_RA_MainTanks[tonumber(strsub(CH_MainTanks[idx],7))] );
  elseif ( strsub(CH_MainTanks[idx],1,6) == 'CTRAPT' and CT_RA_PTargets) then
    return( CT_RA_PTargets[tonumber(strsub(CH_MainTanks[idx],7))] );
  else
    return( CH_MainTanks[idx] );
  end

end

function CH_MainTankLabel( idx )

  return( CH_MainTankUnitName(idx) or CHT_LABEL_UNKNOWN );

end

function CH_MainTankGetUnit( idx )

  local u;
  local tankName = CH_MainTanks[idx];

  if ( tankName == nil ) then
    return( nil );
  elseif ( strsub(tankName,1,6) == 'CTRAMT' and CT_RA_MainTanks ) then
    u = tonumber( strsub(tankName,7) );
    tankName = CT_RA_MainTanks[u];
  elseif ( strsub(tankName,1,6) == 'CTRAPT' and CT_RA_PTargets ) then
    u = tonumber( strsub(tankName,7) );
    tankName = CT_RA_PTargets[u];
  end

  if ( gMainTankUnit[idx] and CH_UnitName(gMainTankUnit[idx]) == tankName ) then
    return( gMainTankUnit[idx] );
  end

  gMainTankUnit[idx] = CH_PlayerNameInPartyOrRaid( tankName );

  return( gMainTankUnit[idx] );

end

function CH_MainTankIndex( unit )

  local i;

  for i=1,CH_MAX_MAIN_TANKS do
    if ( CH_MainTanks[i] and CH_MainTankGetUnit(i) == unit ) then
      return( i );
    end
  end
 
  return( nil ); 

end

-- ==========================================================================================================================
-- Heal Range checks
-- ==========================================================================================================================

-- returns: 1) in range, -1) out of 28yds, -2) not in range, 0) unknown
local function CHL_IsUnitInHealRange( unit )

  local unitIdx;

  if ( UnitIsUnit(unit,'player') ) then					-- player always in range
    return( 1 );
  elseif ( CheckInteractDistance(unit,4) ) then				-- in 28yd range, thus in range
    return( 1 );
  end

  unitIdx = CH_UnitListIndex( unit, true );
  if ( CH_HealRange[unitIdx] and CH_HealRange[unitIdx].timeAdded < GetTime() - CH_Config.healRangeKeepDuration ) then		-- clean up ?
    CH_HealRange[unitIdx] = nil;
  end

  if ( CH_HealRange[unitIdx] ) then					-- have data about unit, return this data
    return( CH_HealRange[unitIdx].range );
  elseif ( not CheckInteractDistance(unit,4) ) then			-- not in 28yd range
    return( -1 );
  end

  return( 0 );

end

-- range type can be HEAL, BUFF and CURE
-- returns: 1) in range, -1) possibly OOR (valid for HEAL only), -2) certainly OOR, 0) unknown
function CH_IsUnitInRange( unit, rangeType )

  if ( rangeType == 'HEAL' ) then
    return( CHL_IsUnitInHealRange(unit) );
  elseif ( range == 'DEAD' ) then
    return( 0 );
  end

  if ( UnitIsUnit(unit,'player') ) then					-- player always in range
    return( 1 );
  elseif ( CheckInteractDistance(unit,4) ) then				-- in 28yd range, thus in range
    return( 1 );
  end

  return( -1 );

end

local function CHL_HealRangeCheckUnit( unit )

  local range = -2;
  local unitIdx = CH_UnitListIndex( unit, true );

  if ( not unitIdx ) then
    return( 0 );
  elseif (not SpellIsTargeting() ) then
    return( -1 )
  end

  if ( SpellCanTargetUnit(unit) ) then
    range = 1;
  end

  CH_HealRange[unitIdx] = {range=-2,timeAdded=GetTime()};

  return( 1 );

end

local function CHL_HealRangeScan()

  -- already scanning?
  if ( gHealRangeIsScanning or SpellIsTargeting() or (GetNumPartyMembers() < 1 and GetNumRaidMembers() < 1) ) then
    return;
  end

  gHealRangeIsScanning = true;

  -- initialization
  local i;
  local continueScan = 1;
  local reTarget = nil;
  local autoSelfCast = GetCVar( 'autoSelfCast' );

  -- clear targegt if required
  if ( UnitExists('target') ) then
    reTarget = CH_NormalizeUnit( 'target' );
    CH_ClearTargetSilently();
  end

  -- auto self cast?
  if ( autoSelfCast == '1' ) then
    SetCVar( 'autoSelfCast', '0' );
  end

  -- cast appropriate spell
  if ( CH_Spells.INSTARANGE and GetSpellCooldown(CH_Spells.INSTARANGE.spellBookIdx,BOOKTYPE_SPELL) <= 0 ) then
    CH_CastSpell( CH_Spells.INSTARANGE.spellBookIdx, BOOKTYPE_SPELL, nil, true );
  else
    CH_CastSpell( CH_Spells.RANGE.spellBookIdx, BOOKTYPE_SPELL, nil, true );
  end

  -- scan the units, abort immediately if no longer targeting
  if ( UnitExists('pet') ) then
    continueScan = CHL_HealRangeCheckUnit( 'pet' );
  end
  i = GetNumPartyMembers();
  while ( i >= 0 and continueScan >= 0 ) do
    continueScan = CHL_HealRangeCheckUnit( 'party'..i );
    if ( continueScan >= 0 and UnitExists('partypet'..i) ) then
      continueScan = CHL_HealRangeCheckUnit( 'partypet'..i );
    end
    i = i - 1;
  end
  i = GetNumRaidMembers();
  while ( i >= 0 and continueScan >= 0 ) do
    continueScan = CHL_HealRangeCheckUnit( 'raid'..i );
    if ( continueScan >= 0 and UnitExists('raidpet'..i) ) then
      continueScan = CHL_HealRangeCheckUnit( 'raidpet'..i );
    end
    i = i - 1;
  end

  -- still targeting
  if ( SpellIsTargeting() ) then
    CH_SpellStopTargeting( true );
  end

  -- clean up
  if ( GetCVar('autoSelfCast') ~= autoSelfCast ) then
    SetCVar( 'autoSelfCast', autoSelfCast );
  end

  if ( (not UnitExists('target')) and reTarget ) then			-- savely retarget
    CH_ReTarget( reTarget );
  end

  gHealRangeIsScanning = false;

end

function CH_HealRangeAbortScan()

  if ( gHealRangeIsScanning and SpellIsTargeting() ) then
    CH_SpellStopTargeting( true );
  end

end

local function CHL_HealRangeAddTargetedUnit( unit )

  local range = -2;
  local unitIdx = CH_UnitListIndex(unit,true );

--  CH_Dbg( 'HealRange: Adding unit '..(unit or 'NIL') );

  if ( not unitIdx ) then
    CH_Dbg( 'CHL_HealRangeAddTargetedUnit: unitIdx == NIL for '..(unit or 'NIL'), CH_DEBUG_ERR );
    return;
  end

  if ( gHealRangeActionSlot < 0 ) then
    CH_Dbg( 'CHL_HealRangeAddTargetedUnit: No spell at action bar!', CH_DEBUG_WARNING );
    return;
  end

  if ( IsActionInRange(gHealRangeActionSlot) == 1 ) then
    range = 1;
  end

  CH_HealRange[unitIdx] = {range=range,timeAdded=GetTime()};

end

-- called by PLAYER_TARGET_CHANGED and MainUpdateLoop
function CH_HealRangeTargetChanged()

  if ( CH_Config.checkHealRange == 'NEVER' or (not UnitExists('target')) or						-- no range checking or no target 
      (not UnitIsFriend('player','target')) or (not (CH_UnitInPartyOrRaid('target') or UnitIsUnit('target','pet')))	-- not a friend, not in party, not pet
     )
  then
    return;
  end

  CHL_HealRangeAddTargetedUnit( CH_NormalizeUnit('target') );

end

function CH_HealRangeWipe()

  CH_HealRange = {};

end

-- ==========================================================================================================================
-- Effects handling (buffs/debuffs)
-- ==========================================================================================================================

local function CHL_EffectDuration( unit, effIdx )

  local unitIdx = CH_UnitListIndex( unit, true ); 

  if ( unitIdx and gUnitEffects[unitIdx] and gUnitEffects[unitIdx][effIdx] ) then
    if ( gUnitEffects[unitIdx][effIdx].duration ~= nil ) then
      return( gUnitEffects[unitIdx][effIdx].duration );
    elseif ( gUnitEffects[unitIdx][effIdx].buffName and CH_SPELL_INFO[gUnitEffects[unitIdx][effIdx].buffName] ) then
      spellName = gUnitEffects[unitIdx][effIdx].buffName;
      if ( CH_SPELL_INFO[spellName] and CH_SPELL_INFO[spellName].duration ) then
        return( CH_SPELL_INFO[spellName].duration );
      end
    end
  end

  return( nil );

end

-- returns: timeRemaining, timeRemainingRounded, unitOfMeasuer
local function CHL_EffectRemainingTime( unit, effIdx )

  local spellName, buffCastTime;
  local buffDuration = nil;
  local unitIdx = CH_UnitListIndex( unit, true ); 

  if ( unitIdx and gUnitEffects[unitIdx] and gUnitEffects[unitIdx][effIdx] and gUnitEffects[unitIdx][effIdx].castTime ) then
    buffDuration = CHL_EffectDuration( unit, effIdx );

    if ( buffDuration == nil ) then
      return nil, nil, nil;
    end

    buffCastTime = gUnitEffects[unitIdx][effIdx].castTime;
    remainTime = (buffCastTime + buffDuration) - GetTime();
    if ( remainTime < 0 ) then
      return 0, nil, nil;
    elseif ( remainTime >= 100 ) then
      return remainTime, ceil(remainTime/60), 'm';
    else
      return remainTime, floor(remainTime), 's';
    end
  end

  return nil, nil, nil;

end

local function CHL_BuffNameToEffect( findBuffName )

  local buffIdx,buffName;

  -- a buff ?
  buffIdx = CH_BuffDataLookup[findBuffName];
  if ( buffIdx ) then
    return( buffIdx );
  end

  -- one of the HOTs?
  for buffName,buffIdx in CH_EFFECT_MAP do
    if ( buffName == findBuffName ) then
      return( buffIdx );
    end
  end

  -- not found
  return( nil );

end

-- mode: WARN/EXPIRED
local function CHL_BuffWarnExpire( unit, effIdx, mode )

  if ( (not CH_BuffData[effIdx]) or (not CH_BuffData[effIdx].enabled) or (not CH_IsValidBuffTarget(effIdx,unit,false,false)) ) then
    return;
  end

  if ( mode == 'EXPIRED' ) then
    if ( gBuffLastExpireFeedback < GetTime() - BUFF_FEEDBACK_DELAY ) then
      if ( CH_Config.buffPlayExpireSound ) then
        PlaySound( 'igQuestFailed' );
      end
      if ( CH_Config.buffShowExpireMsg ) then
        CH_BuffExpireMsg:AddMessage( 'buff expired', CH_COLOR['RED'].r, CH_COLOR['RED'].g, CH_COLOR['RED'].b, 1, 3 );
      end
    end
    gBuffLastExpireFeedback = GetTime();
  elseif ( mode == 'WARN' ) then
    if ( gBuffLastExpireFeedback < GetTime() - BUFF_FEEDBACK_DELAY and gBuffLastWarnFeedback < GetTime() ) then
      if ( CH_Config.buffPlayWarnSound ) then
        PlaySound( 'igQuestFailed' );
      end
      if ( CH_Config.buffShowWarnMsg ) then
        CH_BuffExpireMsg:AddMessage( 'buff about to expire', CH_COLOR['GOLD'].r, CH_COLOR['GOLD'].g, CH_COLOR['GOLD'].b, 1, 3 );
      end
    end
    gBuffLastWarnFeedback = GetTime();
  else
    CH_Dbg( 'CHL_BuffWarnExpire() called with unknown mode: '..mode, CH_DEBUG_ERR );
  end

end

-- unit = unit
-- unitIdx: if player, name of unit, if pet then unit
-- effIdx: idx of the buff
-- spellType: BUFF (for buffs in CH_BuffData), EFFECT for all effects, WBUFF for weapon buffs
-- runTime: current time (index)
local function CHL_UpdateEffect( unit, unitIdx, effIdx, buffName, expiration, spellType, runTime )

  local now = GetTime();
  local warnTime, duration;

  if ( gUnitEffects[unitIdx][effIdx] ) then
    gUnitEffects[unitIdx][effIdx].lastSeen = runTime;
  else
    gUnitEffects[unitIdx][effIdx] = {startTime=GetTime(),castTime=nil,buffName=buffName,warn=false,lastSeen=runTime};
  end

  if ( not (spellType == 'BUFF' or spellType == 'WBUFF' or (spellType == 'EFFECT' and CH_EFFECT_DATA[effIdx].effectType == 'BUFF')) ) then
    return;														 -- only tracking additional data for (weapon) buffs
  end
--  if ( spellType == 'EFFECT' and 		-- only tracking additional data for buffs (currently) (also for speed)
--       (CH_EFFECT_DATA[effIdx].effectType == 'DEBUFF' or CH_EFFECT_DATA[effIdx].effectType == 'TRACKING') )
--  then
--    return;					-- possible problem: if receive a debuff and i just casted the same debuff, i would "track" my debuff
--  end

  local delay = 1;										-- global cooldown at 1.5, everything below should be save
  if ( gCSPrevName and 												-- have a spell casted lately
       gCSPrevName == buffName and 										-- with the same name as the buff
       gCSPrevEndState == 'STOP' and 										-- casting was successful
       gCSPrevEndTime > GetTime()-delay and 									-- and not too long ago
       (gCSPrevTargetName == unitIdx or 									-- on the target i am scanning
           (gCSPrevTargetUnit and gCSPrevTargetUnit == unit and gCSPrevTargetName == UnitName(unit)) or		-- direct cast (and pets)
           (unit == 'player' and CH_SPELL_INFO[buffName] and CH_SPELL_INFO[buffName].selfOnly ) or		--    scanning player and buff self only
           (CH_BUFF_DATA[effIdx] and buffName == CH_BUFF_DATA[effIdx].partySpellName and 			--    or buff and party version cast  
              ( (CH_BUFF_DATA[effIdx].partySpellType == 'PARTY' and CH_IsUnitIDUnique(gCSPrevTargetUnit) and	--      PARTY and party member
                 CH_IsUnitInSameParty(unit,gCSPrevTargetUnit)) or
                (CH_BUFF_DATA[effIdx].partySpellType == 'BLESSING' and CH_IsUnitIDUnique(gCSPrevTargetUnit) and	--      BLESSING and same class
                 CH_UnitClass(unit) == CH_UnitClass(gCSPrevTargetUnit) and CH_UnitClass(unit) ~= 'UNKNOWN')
              )
           )
       ) and
       ((not gUnitEffects[unitIdx][effIdx].castTime) or gUnitEffects[unitIdx][effIdx].castTime ~= gCSPrevEndTime) )	-- not already updated castTime
  then
    gUnitEffects[unitIdx][effIdx].castTime = gCSPrevEndTime;
    gUnitEffects[unitIdx][effIdx].warn = false;
    gUnitEffects[unitIdx][effIdx].duration = nil;
    if ( CH_SPELL_INFO[buffName] and CH_SPELL_INFO[buffName].duration ) then
      gUnitEffects[unitIdx][effIdx].duration = CH_SPELL_INFO[buffName].duration;
    end
  end

  if ( spellType == 'WBUFF' ) then
    if ( expiration == nil or expiration == 0 ) then
      duration = 0;
    else
      duration = floor( expiration / 1000 );
    end
    if ( duration <= CH_BuffData[effIdx].warnTime ) then
      if ( not gUnitEffects[unitIdx][effIdx].warn ) then
        gUnitEffects[unitIdx][effIdx].warn = true;
        CHL_BuffWarnExpire( unit, effIdx, 'WARN' );
      end
    else
      gUnitEffects[unitIdx][effIdx].warn = false;
    end
    gUnitEffects[unitIdx][effIdx].expiration = (expiration or 0);
  elseif ( not gUnitEffects[unitIdx][effIdx].castTime ) then	-- castTime unknown (e.g. reload), reset flag (it could be true)
    gUnitEffects[unitIdx][effIdx].warn = false;
  elseif ( CHL_EffectDuration(unit,effIdx) and gUnitEffects[unitIdx][effIdx].castTime ) then
    duration = CHL_EffectDuration( unit, effIdx );
    if ( spellType == 'BUFF' ) then
      warnTime = CH_BuffData[effIdx].warnTime;
    else
      warnTime = CH_SPELL_INFO[buffName].warnTime;
    end
    if ( (not gUnitEffects[unitIdx][effIdx].warn) and 
         GetTime() >= gUnitEffects[unitIdx][effIdx].castTime+duration-warnTime )      -- warn period
    then
      if ( not gUnitEffects[unitIdx][effIdx].warn ) then
        gUnitEffects[unitIdx][effIdx].warn = true;
        CHL_BuffWarnExpire( unit, effIdx, 'WARN' );
      end
    elseif ( gUnitEffects[unitIdx][effIdx].warn ) then
      if ( GetTime() > gUnitEffects[unitIdx][effIdx].castTime+duration+CH_BUFF_GRACE_PERIOD ) then	-- too old (someone else refreshed buff)
        gUnitEffects[unitIdx][effIdx].warn = false;
        gUnitEffects[unitIdx][effIdx].castTime = nil;					-- zero out cast time!? (dangerous?)
      elseif ( GetTime() < gUnitEffects[unitIdx][effIdx].castTime+duration-warnTime ) then                   -- outside period (value changed in GUI)
        gUnitEffects[unitIdx][effIdx].warn = false;
      end
    end
  end

end

local function CHL_UpdateUnitEffects( unit )

  local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges, hasItem;
  local texture, applications, dispelType, unitIdx;
  local i = 1;
  local buffIdx;
  local runTime = GetTime();

  if ( (not unit) or (not UnitExists(unit)) ) then
    return;
  end

  unitIdx = CH_UnitListIndex( unit, true );

  if ( unitIdx == nil ) then
    CH_Dbg( 'CHL_UpdateUnitEffects(): CH_UnitListIndex() returns NIL for unit '..unit, CH_DEBUG_ERR );
    return;
  end

  if ( not gUnitEffects[unitIdx] ) then
    gUnitEffects[unitIdx] = {lastUpdate=0};
  end

  if ( gUnitEffects[unitIdx].lastUpdate > GetTime() - CH_Config.updateEffectsInterval or
       (gUnitEffects[unitIdx].isUpdating and gUnitEffects[unitIdx].lastUpdate > GetTime() - EFFECT_EXPIRATION) )
  then
    return;
  end

  gUnitEffects[unitIdx].isUpdating = 1;

  -- ----- buffs
  texture = UnitBuff( unit, i );
  while ( texture ) do

    CH_TooltipSetUnitBuff( unit, i );
    buffName = CH_TooltipGetTitle();

    if ( CH_EFFECT_MAP[buffName] and CH_EFFECT_DATA[CH_EFFECT_MAP[buffName]].effectType == 'BUFF' ) then		-- HOT and Phase Shift
      CHL_UpdateEffect( unit, unitIdx, CH_EFFECT_MAP[buffName], buffName, nil, 'EFFECT', runTime );
    elseif ( CH_BuffDataLookup[buffName] ) then							-- also handles group buffs (MotW, Prayer, Brilliance)
      CHL_UpdateEffect( unit, unitIdx, CH_BuffDataLookup[buffName], buffName, nil, 'BUFF', runTime );
    end

    i = i + 1;
    texture = UnitBuff( unit, i );
  end

  -- ----- debuffs
  i = 1;
  texture,applications,dispelType = UnitDebuff( unit, i );
  while ( texture ) do

    CH_TooltipSetUnitDebuff( unit, i );
    buffName = CH_TooltipGetTitle();

    if ( CH_EFFECT_MAP[buffName] and CH_EFFECT_DATA[CH_EFFECT_MAP[buffName]].effectType == 'DEBUFF' ) then
      CHL_UpdateEffect( unit, unitIdx, CH_EFFECT_MAP[buffName], buffName, nil, 'EFFECT', runTime );
    elseif ( dispelType and CH_EFFECT_MAP[dispelType] and CH_EFFECT_DATA[CH_EFFECT_MAP[dispelType]].effectType == 'DEBUFF' ) then
      CHL_UpdateEffect( unit, unitIdx, CH_EFFECT_MAP[dispelType], dispelType, nil, 'EFFECT', runTime );
    end

    i = i + 1;
    texture,applications,dispelType = UnitDebuff( unit, i );
  end

  -- ----- weapon buffs
  if ( unit == 'player' ) then
    hasMainHandEnchant,mainHandExpiration,mainHandCharges,hasOffHandEnchant,offHandExpiration,offHandCharges = GetWeaponEnchantInfo();
    if ( hasMainHandEnchant ) then
      if ( CH_TooltipSetInventoryItem( 'player', GetInventorySlotInfo("MainHandSlot") ) ) then
        for buffIdx,_ in CH_BuffData do
          if ( CH_BUFF_DATA[buffIdx].isWeaponBuff ) then
            if ( CH_TooltipContainsPatternLeft(CH_BUFF_DATA[buffIdx].weaponBuffPattern) ) then
              CHL_UpdateEffect( unit, unitIdx, buffIdx, CH_BUFF_DATA[buffIdx].weaponBuffPattern, mainHandExpiration, 'WBUFF', runTime );
            end
          end
        end
      end
    end
  end

  -- ----- clean up expired buffs
  for buffIdx,_ in gUnitEffects[unitIdx] do
    if ( type(gUnitEffects[unitIdx][buffIdx]) == 'table' ) then
      if ( gUnitEffects[unitIdx][buffIdx].lastSeen < runTime ) then
        gUnitEffects[unitIdx][buffIdx] = nil;
        if ( CH_Config.buffPlayExpireSound or CH_Config.buffShowExpireMsg ) then
          CHL_BuffWarnExpire( unit, buffIdx, 'EXPIRED' );
        end
      end
    end
  end

  gUnitEffects[unitIdx].lastUpdate = runTime;
  if ( UnitIsPlayer(unit) ) then
    gUnitEffects[unitIdx].isPlayer = true;
  else
    gUnitEffects[unitIdx].isPlayer = false;
  end

  gUnitEffects[unitIdx].isUpdating = nil;

end

function CH_IsEffectedBy( unit, effIdx, excludeWarning )

  local unitIdx = CH_UnitListIndex( unit, true );

  if ( unitIdx == nil ) then
    return( false );
  elseif ( CH_UnitIsDeadOrGhostForReal(unit) ) then
    return( false );
  end

  if ( not gUnitEffects[unitIdx] and (CH_UnitInPartyOrRaid(unit) or CH_UnitIsAvatarOrPet(unit)) ) then
--    CH_Dbg( 'CH_IsEffectedBy, unit effect unknown ('..unit..'/'..unitIdx..'/'..effIdx..'), restoring now', CH_DEBUG_DEBUG );
    CHL_UpdateUnitEffects( unit );
  elseif ( gUnitEffects[unitIdx] and gUnitEffects[unitIdx].lastUpdate <= GetTime() - EFFECT_EXPIRATION - CH_Config.updateEffectsInterval ) then
--    CH_Dbg( 'CH_IsEffectedBy, unit effect expired ('..unit..'/'..unitIdx..'/'..effIdx..' : '..
--            (GetTime()-gUnitEffects[unitIdx].lastUpdate-EFFECT_EXPIRATION-CH_Config.updateEffectsInterval)..'/'..(EFFECT_EXPIRATION)..'), restoring now', 
--            CH_DEBUG_DEBUG );
    CHL_UpdateUnitEffects( unit );
  end

  if ( gUnitEffects[unitIdx] and gUnitEffects[unitIdx][effIdx] ) then
    if ( excludeWarning and gUnitEffects[unitIdx][effIdx].warn ) then
      return( false );
    end
    return( true );
  end

  return( false );

end

local function CHL_ColorEffect( units, effIdx, abbr, color, buffIdx, isParty, buffString, isWeaponBuff )

  local rts = '';
  local unit;
  local unitIdx;

  if ( CH_Config.showFriendDebuffs == 'NONE' and CH_EFFECT_DATA[effIdx] and CH_EFFECT_DATA[effIdx].effectType == 'DEBUFF' ) then
    return( '' );
  elseif ( CH_Config.showFriendDebuffs == 'CURABLE' and CH_EFFECT_DATA[effIdx] and CH_EFFECT_DATA[effIdx].effectType == 'DEBUFF' and 
           CH_EFFECT_DATA[effIdx].curableBy and (not CH_EFFECT_DATA[effIdx].curableBy[CH_UnitClass('player')]) )
  then
    return( '' );
  end

  local unit,iter = CH_ArrayNext( units, nil );
  while ( unit ) do
    unitIdx = CH_UnitListIndex( unit, true );

    if ( effIdx == CH_EFFECT_TRACKING and unit == 'player' ) then		-- tracking buff
      if ( gPlayerCanCastTrackingBuff and CH_Config.warnTrackingBuff and (not GetTrackingTexture()) and (not CH_UnitIsDeadOrGhostForReal('player')) ) then
        return( '|cFF'..CH_COLOR[color].html..abbr );
      end
    elseif ( gUnitEffects[unitIdx] and gUnitEffects[unitIdx][effIdx] ) then	-- active effect or buff
      if ( isParty and gUnitEffects[unitIdx].PS ) then
        -- "phaseshift" not for party/panic
      else
        if ( gUnitEffects[unitIdx][effIdx].warn ) then
          abbr = strlower( abbr );
        end
        if ( not buffIdx ) then								-- effect
          return( '|cFF'..CH_COLOR[color].html..abbr );
        elseif ( gUnitEffects[unitIdx][effIdx].warn ) then				-- buff
          if ( isParty and CH_Config.combineMissingBuffsInPanic and (not isWeaponBuff) ) then	-- combine missing buffs
            if ( buffString == '' ) then								--  still empty, return it
              return( '|cFF'..CH_COLOR[color].html..strlower(CHT_EFFECT_MISSING_BUFF) );
            else											--  already returned, dont update
              return( buffString );
            end
          end
          return( buffString..'|cFF'..CH_COLOR[color].html..abbr );
        end
      end
    elseif ( buffIdx ) then							-- expired buff
      if ( CH_IsValidBuffTarget(buffIdx,unit,not isParty,false) ) then 				-- only 'force' if for single unit
        if ( isParty and CH_Config.combineMissingBuffsInPanic and (not isWeaponBuff) ) then		-- combine missing buffs
          return( '|cFF'..CH_COLOR[color].html..CHT_EFFECT_MISSING_BUFF );
        end
        return( buffString..'|cFF'..CH_COLOR[color].html..abbr );
      end
    end

    unit,iter = CH_ArrayNext( units, iter );
  end

  if ( buffIdx ) then
    return( buffString );
  else
    return( '' );
  end

end

function CH_EffectsAsString( unit, which )

  local rts = '';
  local units = CH_ArrayInit();
  local i, buffIdx, val;
  local unitIdx = nil;
  local isParty = (unit == 'party');
  local buffString = '';
  local debuffString = '';

  if ( isParty ) then
    if ( GetNumRaidMembers() > 0 and CH_Config.showRaidEffects ) then
      for i=GetNumRaidMembers(),1,-1 do
        units = CH_ArrayAdd( units, 'raid'..i );
        if ( UnitExists('raidpet'..i) ) then
          units = CH_ArrayAdd( units, 'raidpet'..i );
        end
      end
    else
      units = CH_ArrayAdd( units, 'player' );

      if ( UnitExists('pet') ) then
        units = CH_ArrayAdd( units, 'pet' );
      end

      for i=1,GetNumPartyMembers() do
        units = CH_ArrayAdd( units, 'party'..i );
        if ( UnitExists('partypet'..i) ) then
          units = CH_ArrayAdd( units, 'partypet'..i );
        end
      end
    end
  else 
    unitIdx = CH_UnitListIndex( unit, true );
    if ( not gUnitEffects[unitIdx] ) then	-- can happen at load
      return( '' );
    elseif ( gUnitEffects[unitIdx].effStringBuildTime == nil or gUnitEffects[unitIdx].effStringBuildTime < gUnitEffects[unitIdx].lastUpdate ) then
      gUnitEffects[unitIdx].effStringBuildTime = GetTime();
      units = CH_ArrayAdd( units, unit );
    elseif ( which == 'BUFF' ) then
      return( gUnitEffects[unitIdx].buffString );
    elseif ( which == 'DEBUFF' ) then
      return( gUnitEffects[unitIdx].debuffString );
    else
      return( gUnitEffects[unitIdx].effString );
    end
  end

  rts = CHL_ColorEffect( units, CH_EFFECT_TRACKING, CH_EFFECT_DATA[CH_EFFECT_TRACKING].sign, CH_EFFECT_DATA[CH_EFFECT_TRACKING].color, nil, isParty );

  for _,buffIdx in CH_BuffPriority do
    if ( CH_BuffData[buffIdx].enabled ) then
      if ( CH_BUFF_DATA[buffIdx].isWeaponBuff ) then
        rts = rts..CHL_ColorEffect( units, buffIdx, CH_BUFF_DATA[buffIdx].effect, 'PINK', buffIdx, isParty, '', true );
      else
        buffString = CHL_ColorEffect( units, buffIdx, CH_BUFF_DATA[buffIdx].effect, 'YELLOW', buffIdx, isParty, buffString, false );
      end
    end
  end
  buffString = rts..buffString;
  rts = buffString;

  if ( unit == 'party' ) then
    for _,i in CH_EFFECT_DISPLAY_PARTY do
      rts = rts..CHL_ColorEffect( units, i, CH_EFFECT_DATA[i].sign, CH_EFFECT_DATA[i].color, nil, isParty );
    end
  else
    for _,i in CH_EFFECT_DISPLAY_UNIT do
      val = CHL_ColorEffect( units, i, CH_EFFECT_DATA[i].sign, CH_EFFECT_DATA[i].color, nil, isParty );
      rts = rts..val;
      debuffString = debuffString .. val;
    end
  end

  if ( rts ~= '' ) then
    rts = rts .. '|r';
  end

  if ( buffString ~= '' ) then
    buffString = buffString .. '|r';
  end

  if ( debuffString ~= '' ) then
    debuffString = debuffString .. '|r';
  end

  if ( unit ~= 'party' and unitIdx ) then
    gUnitEffects[unitIdx].effString = rts;
    gUnitEffects[unitIdx].buffString = buffString;
    gUnitEffects[unitIdx].debuffString = debuffString;
  end

  if ( which == 'BUFF' ) then
    return( gUnitEffects[unitIdx].buffString );
  elseif ( which == 'DEBUFF' ) then
    return( gUnitEffects[unitIdx].debuffString );
  end

  return( rts );					-- not gUnitEffects[unitIdx].effString, because of 'party'

end

function CH_EffectsCleanUp()

  -- delete all pets and all members no longer in party/raid
  for unitIdx,_ in gUnitEffects do
    if ( gUnitEffects[unitIdx].isPlayer and (not CH_PlayerNameInPartyOrRaid(unitIdx)) ) then
      gUnitEffects[unitIdx] = nil;
    elseif ( (not gUnitEffects[unitIdx].isPlayer) and (not CH_PlayerNameInPartyOrRaid(strsub(unitIdx,1,-4))) ) then		-- remove the 'PET'
      gUnitEffects[unitIdx] = nil;
    end
  end

end

-- ==========================================================================================================================
-- Action bar events
-- ==========================================================================================================================

function CH_ActionBarInit()

  local i, actionName, spellName;

  CH_ActionBar = {};			-- this is a bit dangerous, as a simultaneous run might request the info, but otherwise it contains "wrong" info

  -- scan the bar and build array
  for i=1,CH_MAX_ACTION_SLOTS do
    if ( HasAction(i) and (not GetActionText(i)) ) then
      CH_TooltipSetAction( i );
      actionName = CH_TooltipGetTitle();
      if ( actionName ) then
        CH_ActionBar[actionName] = {slot=i};
      end
    end
  end

  -- get the slots for bow and wand
  if ( CH_UnitClass('player') == 'HUNTER' ) then
    gWandActionBarSlot = CH_FindActionSlotByName( CH_SPELL_AUTO_SHOT, nil );
  elseif ( CH_CLASS_INFO[CH_UnitClass('player')].canUseWand ) then
    gWandActionBarSlot = CH_FindActionSlotByName( CH_SPELL_SHOOT, nil );
  end

  -- get the slot for Heal Range Checking
  if ( CH_SPELL_DATA ) then
    gHealRangeActionSlot = -1;
    for _,spellName in CH_SPELL_DATA.RANGE do
      if ( gHealRangeActionSlot < 0 ) then
        gHealRangeActionSlot = CH_FindActionSlotByName( spellName, nil );
      end
    end
  end

end

function CH_ActionBarSlotChanged( slot )

  CH_ActionBarInit();			-- Problem: I can have action with same name in two slots!

end

function CH_UseActionMasked( slot, checkCursor, onSelf )

  if ( not CH_CastSpellPrecheck(nil,nil,nil,slot) ) then
    return;
  end

  CH_HealRangeAbortScan();

  gLastUsedAction.slot = slot;
  gLastUsedAction.useTime = GetTime();
  gLastUsedAction.checkCursor = checkCursor;
  gLastUsedAction.onSelf = onSelf;

  CH_CastSpellByActionData( slot );

  gOriginalFunction['UseAction']( slot, checkCursor, onSelf );

end

-- ==========================================================================================================================
-- Combat / Mana events
-- ==========================================================================================================================

function CH_RegenEnabled()

  gPlayerHitSoundPlayTime = 0;
  gAnnounceHitToPartyPlayTime = 0;
  gAnnounceOOMToPartyPlayTime = 0;

end

function CH_RegenDisabled()

  gPlayerHitSoundPlayTime = 0;
  gAnnounceHitToPartyPlayTime = 0;
  gAnnounceOOMToPartyPlayTime = 0;

end

function CH_EnterCombat()

  gPlayerActiveMelee = true;
  gPlayerPendingAttack = false;

end

function CH_LeaveCombat()

  gPlayerActiveMelee = false;
  gPlayerPendingAttack = false;

  CH_TryRestartCombat();

end

function CH_SetRestartCombat()

  if ( gPlayerActiveMelee ) then
    gPlayerRestartCombat = {time=GetTime(),delay=1};
  else
    gPlayerRestartCombat = nil;
  end

end

function CH_TryRestartCombat( )

  if ( gPlayerRestartCombat ) then								-- NIL
    if ( not (gPlayerActiveMelee or gPlayerActiveAutoShot) and gPlayerRestartCombat.time > GetTime()-gPlayerRestartCombat.delay and 
         UnitExists('target') and UnitCanAttack('player','target') ) 
    then
      AttackTarget();
      CH_Debug( 'RESTARTING ATTACK', CH_DEBUG_DEBUG );
    end
    gPlayerRestartCombat = nil;
  end

end

function CH_UnitHit( unit, action, critical, damage, damageType )

  -- ----- defend yourself
  if ( unit == 'player' and action ~= 'HEAL' ) then
    CHL_DefendYourself( true );
  end

  -- ----- hit sound
  if ( unit == 'player' and CH_Config.playerHitSound and UnitAffectingCombat(unit) and action ~= 'HEAL' ) then
    if ( gPlayerHitSoundPlayTime == 0 or 
         (gPlayerHitSoundPlayTime <= GetTime() - CH_Config.playerHitSoundDelay and CH_Config.playerHitSoundDelay < 61) )	-- 61 == never
    then
      gPlayerHitSoundPlayTime = GetTime();
      PlaySoundFile( "Interface\\AddOns\\ClickHeal\\Sounds\\AvatarHit.wav" );
    end
  end

  -- ----- hit announce (under attack)
  if ( unit == 'player' and UnitAffectingCombat(unit) and action ~= 'HEAL' and
       ((CH_Config.announceHitToParty and GetNumPartyMembers() > 0 ) or (CH_Config.announceHitPlayEmote) and (GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0)) )
  then
    local hpPerc = floor( CH_CalcPercentage(UnitHealth(unit),UnitHealthMax(unit)) );
    local tryPlay = false;

    if ( hpPerc <= CH_Config.announceHitToPartyHP ) then
      tryPlay = true;
    elseif ( hpPerc <= CH_Config.announceHitToPartyHPFade ) then
      local fadeID = CH_GetSpellID( CH_SPELL_FADE, nil, BOOKTYPE_SPELL, false );
      if ( fadeID > 0 ) then
        local start = GetSpellCooldown( fadeID, BOOKTYPE_SPELL );
        if ( start >= GetTime() - 1.5 ) then
          tryPlay = CH_UnitHasBuff( unit, CH_SPELL_FADE );		-- could be global cooldown!
        elseif ( start > 0 ) then
          tryPlay = true;
        end
      end
    end

    if ( tryPlay == true and gAnnounceHitToPartyPlayTime <= GetTime() - CH_Config.announceHitToPartyDelay and
         CH_Config.announceHitToPartyDelay < 61 ) 										   -- 61 == never
    then
      if ( CH_Config.announceHitToParty ) then
        SendChatMessage( CH_Config.announceHitToPartyMsg, "PARTY" );
      end
      if ( CH_Config.announceHitPlayEmote ) then
        DoEmote( "HELPME" );
      end
      gAnnounceHitToPartyPlayTime = GetTime();
    end
    
  end

end

function CH_UnitMana( unit )

  if ( unit == 'player' and UnitPowerType('player') == POWER_MANA ) then
    gUnitManaRegain = UnitMana('player') - gUnitManaLast;
    gUnitManaLast = UnitMana('player');

    if ( (CH_Config.announceOOMToParty or CH_Config.announceOOMToRaid or CH_Config.announceOOMToCustomChannel or CH_Config.announceOOMPlayEmote) and 
         gAnnounceOOMToPartyPlayTime <= GetTime() - CH_Config.announceOOMToPartyDelay and CH_Config.announceOOMToPartyDelay < 61 and UnitAffectingCombat(unit) )  -- 61 == never
    then
      local spPerc = floor( CH_CalcPercentage(UnitMana(unit),UnitManaMax(unit)) );

      if ( spPerc <= CH_Config.announceOOMToPartyMana ) then
        if ( CH_Config.announceOOMToRaid and GetNumRaidMembers() > 0 ) then
          SendChatMessage( string.format(CH_LOW_ON_MANA_MSG_FORMAT,spPerc), "RAID" );
        elseif ( CH_Config.announceOOMToParty and GetNumPartyMembers() > 0 ) then
          SendChatMessage( string.format(CH_LOW_ON_MANA_MSG_FORMAT,spPerc), "PARTY" );
        end
        if ( CH_Config.announceOOMToCustomChannel ) then
          CH_SendChannelMessage( string.format(CH_LOW_ON_MANA_MSG_FORMAT,spPerc), CH_Config.notifyCustomChannelName );
        end
        if ( CH_Config.announceOOMPlayEmote ) then
          DoEmote( "OOM" );
        end
        gAnnounceOOMToPartyPlayTime = GetTime();
      end
    end
  end

end

-- ==========================================================================================================================
-- Cooldown Handling
-- ==========================================================================================================================

local function CHL_CooldownRemainString( cdRemain )

  if ( cdRemain >= 600 ) then
    return( CHT_COOLDOWN_LABEL_OVERFLOW );
  elseif ( cdRemain >= 100 ) then
    return( ceil( cdRemain / 60 )..CHT_LABEL_TIME_M );
  end

  return( cdRemain );

end

local function CHL_CooldownShow()

  local cdIdx = 1;
  local spellTexture, i;
  local cooldownFrame, cooldownIcon, cooldownTime;
  local cdStart, cdDuration, cdRemain, cdData, cdBagIdx;

  for i,cdData in CH_CooldownWatchList do
    if ( cdData.spellName ~= 'None' and cdData.spellID > 0 and i > 4 ) then		-- 1-4 reserved for Extra
      spellTexture = GetSpellTexture( cdData.spellID, cdData.bookType );
      cdStart,cdDuration = GetSpellCooldown( cdData.spellID, cdData.bookType );
      cdRemain = ceil( (cdStart + cdDuration) - GetTime() );

      if ( cdStart > 0 and cdDuration > 1.5 and cdRemain > 0 ) then
        cooldownFrame = getglobal( 'CH_PanicCooldown'..cdIdx );
        cooldownIcon = getglobal( 'CH_PanicCooldown'..cdIdx..'Icon' );
        cooldownTime = getglobal( 'CH_PanicCooldown'..cdIdx..'Time' );

        CHL_DockChainFrame( cdIdx, 'CH_PanicCooldown', CH_PanicFrame, 'TOP', -2 );
        cooldownIcon:SetTexture( spellTexture );
        cooldownTime:SetText( CHL_CooldownRemainString(cdRemain) );
        cooldownFrame:Show();
   
        cdIdx = cdIdx + 1;
      end
    end
  end

  for cdBagIdx,_ in gCooldownBagWatchList do
    if ( gCooldownBagWatchList[cdBagIdx].cdEnd < GetTime() ) then
      gCooldownBagWatchList[cdBagIdx] = nil;
    elseif ( cdIdx <= CH_MAX_COOLDOWN_ICONS and gCooldownBagWatchList[cdBagIdx].cdDuration > 1.5 and gCooldownBagWatchList[cdBagIdx].texture ) then
      cdRemain = ceil( (gCooldownBagWatchList[cdBagIdx].cdStart + gCooldownBagWatchList[cdBagIdx].cdDuration) - GetTime() );

      cooldownFrame = getglobal( 'CH_PanicCooldown'..cdIdx );
      cooldownIcon = getglobal( 'CH_PanicCooldown'..cdIdx..'Icon' );
      cooldownTime = getglobal( 'CH_PanicCooldown'..cdIdx..'Time' );

      CHL_DockChainFrame( cdIdx, 'CH_PanicCooldown', CH_PanicFrame, 'TOP', -2 );
      cooldownIcon:SetTexture( gCooldownBagWatchList[cdBagIdx].texture );
      cooldownTime:SetText( CHL_CooldownRemainString(cdRemain) );
      cooldownFrame:Show();

      cdIdx = cdIdx + 1;
    end
  end

  cooldownFrame = getglobal( 'CH_PanicCooldown'..cdIdx );
  while ( cooldownFrame and cooldownFrame:IsVisible() ) do
    cooldownFrame:Hide();
    cdIdx = cdIdx + 1;
    cooldownFrame = getglobal( 'CH_PanicCooldown'..cdIdx );
  end

end

-- the idea here is, that when this event fired, all bags are scanned and all items which now have a cooldown are added to the list. This assumes, that
-- all these items share a common cooldown. Only one of these items will be visible though, by setting a texture.
-- called by CH_UpdateBags() for every bagitem
function CH_CooldownBagUpdateCooldown( bag, slot, itemLink, runID )

  local visibleItem = nil;
  local itemName;
  local cdStart, cdDuration;

  if ( (not CH_Config.showBagCooldown) or (not CH_Config.showClickHeal) ) then
    gCooldownBagWatchList = {};
    return;
  end

  _,_,itemName = strfind( itemLink, "%[(.*)%]" );
  cdStart,cdDuration = GetContainerItemCooldown( bag, slot );
  if ( cdStart > 0 and cdDuration > 0 and itemName ~= CH_ITEM_HEARTHSTONE_NAME ) then				-- has cooldown
    if ( gCooldownBagWatchList[cdStart*1000] ) then									-- existing entry
      gCooldownBagWatchList[cdStart*1000].runID = runID;
    else															-- new entry
      lastCdStart,lastCdDuration = GetContainerItemCooldown( gLastUsedBagItem.bag, gLastUsedBagItem.slot );
      if ( lastCdStart > 0 and lastCdDuration > 0 and lastCdStart == cdStart and lastCdDuration == cdDuration ) then	-- item used to trigger cooldown
        itemTexture = GetContainerItemInfo( gLastUsedBagItem.bag, gLastUsedBagItem.slot );
      else
        itemTexture = GetContainerItemInfo( bag, slot );
      end
      gCooldownBagWatchList[cdStart*1000] = {cdStart=cdStart,cdDuration=cdDuration,cdEnd=cdStart+cdDuration,texture=itemTexture,runID=runID};
    end
    if ( CH_ActionBar[itemName] and gLastUsedAction.slot == CH_ActionBar[itemName].slot ) then			-- action bar triggered, override "Default" icon
      gCooldownBagWatchList[cdStart*1000].texture = GetContainerItemInfo( bag, slot );
    end
  end

end

-- finished scanning bags
function CH_CooldownBagUpdateCooldownFinished( runID )

  local k;

  -- if item not found in bag, remove it from list
  for k,_ in gCooldownBagWatchList do
    if ( gCooldownBagWatchList[k].runID < runID ) then
      gCooldownBagWatchList[k] = nil;
    end
  end

end

-- ==========================================================================================================================
-- Mesmerize
-- ==========================================================================================================================

function CH_MesmerizeUpdateUnit( spellName, spellRank, unitName )

  CH_MesmerizeWatchList = {};					-- because i can only shakle one !!!

  if ( spellRank == nil ) then
    _,_,spellRank = CH_GetSpellID( spellName, spellRank, BOOKTYPE_SPELL, false );
   if ( spellRank == nil ) then
     spellRank = 'MAX';
   elseif ( not CH_MESMERIZE_INFO[spellName].duration[spellRank] ) then
     CH_Msg( 'WARNING: CH_MESMERIZE_INFO for spell '..spellName..', rank '..spellRank..' unknown!' );
     CH_Msg( 'Please post above warning exactly as it is on the boards. Thanx!' );
     spellRank = 'MAX';
   end
  end

  if ( not CH_MesmerizeWatchList[unitName] ) then
    CH_MesmerizeWatchList[unitName] = {};
  end

  CH_MesmerizeWatchList[unitName][spellName] = {startTime=GetTime(),duration=CH_MESMERIZE_INFO[spellName].duration[spellRank]};

end

--function CH_MesmerizeOnEvent( msg )
--
--  local mKey, mData, mesUnit;
--  local dummyA, dummyB;
--
--  if ( not CH_Config.showMesmerize ) then
--    return;
--  end
--
--  for mKey,mData in CH_MESMERIZE_INFO do
--    dummyA,dummyB,mesUnit = string.find( msg, mData.pattern );
--    if ( mesUnit ) then
--      CH_MesmerizeUpdateUnit( mKey, mesUnit );	WRONG PARAMS !!
--    end
--  end
--
--end

local function CHL_ShowMesmerize()

  local mUnit, mUnitData, mEffect, mEffectData;
  local wipeUnit, mRemain, mFrame, mIcon, mTime;
  local mIdx = 1;
  local parentFrame = CH_Extra4Frame;

  if ( CH_Config.showMesmerize and CH_Config.showClickHeal ) then
    if ( CH_Config.dockTarget == 'LEFT' ) then
      parentFrame = CH_Extra3Frame;
    end
    for mUnit,mUnitData in CH_MesmerizeWatchList do
      wipeUnit = mUnit;
      for mEffect, mEffectData in mUnitData do
        mRemain = ceil( (mEffectData.startTime + mEffectData.duration) - GetTime() );
        if ( mRemain > 0 ) then
          mFrame = getglobal( 'CH_Mesmerize'..mIdx );
          mIcon = getglobal( 'CH_Mesmerize'..mIdx..'Icon' );
          mTime = getglobal( 'CH_Mesmerize'..mIdx..'Time' );

          CHL_DockChainFrame( mIdx, 'CH_Mesmerize', parentFrame, 'TOP', 10 );
          mIcon:SetTexture( CH_MESMERIZE_INFO[mEffect].texture );
          mTime:SetText( mRemain );

          mFrame:Show();

          mIdx = mIdx + 1;
          wipeUnit = nil;
        else
          CH_MesmerizeWatchList[mUnit][mEffect] = nil;
        end
      end
      if ( wipeUnit ) then
        CH_MesmerizeWatchList[mUnit] = nil;
      end
    end
  else
    CH_MesmerizeWatchList = {};					-- because i can only shakle one !!!
  end

  mFrame = getglobal( 'CH_Mesmerize'..mIdx );
  while ( mIdx < CH_MAX_MESMERIZE_WATCH and mFrame:IsVisible() ) do
    mFrame:Hide();
    mIdx = mIdx + 1;
    mFrame = getglobal( 'CH_Mesmerize'..mIdx );
  end

end

-- ==========================================================================================================================
-- configuration(s)              
-- ==========================================================================================================================

function CH_SetCHAction( actionType, mouseSpellIdx, mouseButton, data )

  if ( actionType == 'NONE' ) then
    CH_MouseSpells[mouseSpellIdx][mouseButton] = nil;
    data = nil;
  else
    CH_MouseSpells[mouseSpellIdx][mouseButton] = actionType;
  end

  if ( data ) then
    CH_MouseSpellsData[mouseSpellIdx][mouseButton] = data;
  elseif ( CH_ActionList[actionType] and CH_ActionList[actionType].plugin ) then
    if ( CH_ActionList[actionType].plugin.DefaultData ) then
      CH_MouseSpellsData[mouseSpellIdx][mouseButton] = CH_ActionList[actionType].plugin:DefaultData( actionType );
    else
      CH_MouseSpellsData[mouseSpellIdx][mouseButton] = nil;
    end
  elseif ( actionType == 'SPELL' ) then
    CH_MouseSpellsData[mouseSpellIdx][mouseButton] = {spellName='None',spellRank='MAX'};
  elseif ( actionType == 'PETSPELL' ) then
    CH_MouseSpellsData[mouseSpellIdx][mouseButton] = {spellName='None'};
  elseif ( actionType == 'PETATTACK' ) then
    CH_MouseSpellsData[mouseSpellIdx][mouseButton] = {action='NONE',condition='NONE'};
  elseif ( actionType == 'TOTEMSET' ) then
    CH_MouseSpellsData[mouseSpellIdx][mouseButton] = 1;
  elseif ( actionType == 'BUFF' ) then
    CH_MouseSpellsData[mouseSpellIdx][mouseButton] = 'AUTOMATIC';
  elseif ( actionType == 'GRPBUFF' ) then
    CH_MouseSpellsData[mouseSpellIdx][mouseButton] = 'REFRESH_TIME';
  elseif ( actionType == 'CHAIN' ) then
    CH_MouseSpellsData[mouseSpellIdx][mouseButton] = 1;
  elseif ( actionType == 'NONE' ) then
    CH_MouseSpellsData[mouseSpellIdx][mouseButton] = nil;
  else
    CH_MouseSpellsData[mouseSpellIdx][mouseButton] = {};
  end

end

local function CHL_ConfigHookAddon( addonFuncName, chFuncName )

  if ( getglobal(addonFuncName) and getglobal(addonFuncName) ~= getglobal(chFuncName) ) then
    gOriginalFunction[addonFuncName] = getglobal( addonFuncName );
    setglobal( addonFuncName, getglobal(chFuncName) );
  end

end

local function CHL_ConfigUnhookAddon( addonFuncName, force )

  if ( gOriginalFunction[addonFuncName] or force ) then
    setglobal( addonFuncName, gOriginalFunction[addonFuncName] );
  end

end

function CHL_ConfigPreChange( option )

  if ( option == 'notifyCustomChannelName' ) then
    CH_LeaveNotifyChannel();
  elseif ( option == 'notifyCustomChannelPassword' ) then
    CH_LeaveNotifyChannel();
  elseif ( option == 'notifyCustomChannelChatFrameName' ) then
    CH_LeaveNotifyChannel();
  end

end

function CHL_ConfigPostChange( option )

  if ( option == 'CTRAEnabled' ) then
    if ( CH_Config[option] ) then
      gOriginalFunction['CT_RA_CustomOnClickFunction'] = CT_RA_CustomOnClickFunction;
      CT_RA_CustomOnClickFunction = CH_CTRAClicked;
    else
      CHL_ConfigUnhookAddon( 'CT_RA_CustomOnClickFunction', true );
    end
  elseif ( option == 'ORAEnabled' ) then
    if ( CH_Config[option] ) then
      gOriginalFunction['oRA_MainTankFramesCustomClick'] = oRA_MainTankFramesCustomClick;
      oRA_MainTankFramesCustomClick = CH_ORAClicked;
    else
      CHL_ConfigUnhookAddon( 'oRA_MainTankFramesCustomClick', true );
    end
  elseif ( option == 'NeedyListEnabled' ) then
    if ( CH_Config[option] ) then
      CHL_ConfigHookAddon( 'NLMember_OnClick', 'CH_NeedyListAddonClicked' );
    else
      CHL_ConfigUnhookAddon( 'NLMember_OnClick' );
    end
  elseif ( option == 'DUFEnabled' ) then
    if ( CH_Config[option] ) then
      CHL_ConfigHookAddon( 'DUF_Element_OnClick', 'CH_DUFClicked' );
    else
      CHL_ConfigUnhookAddon( 'DUF_Element_OnClick' );
    end
  elseif ( option == 'showWoWParty' ) then
    if ( CH_Config[option] ) then
      ShowPartyFrame();
    else
      HidePartyFrame();
    end
  elseif ( option == 'showBagCooldown' ) then
    CH_UpdateBags();
  elseif ( option == 'extra1Hidden' and (not CH_Config[option]) ) then
    CH_Extra1Frame:Show();
  elseif ( option == 'extra2Hidden' and (not CH_Config[option]) ) then
    CH_Extra2Frame:Show();
  elseif ( option == 'extra3Hidden' and (not CH_Config[option]) ) then
    CH_Extra3Frame:Show();
  elseif ( option == 'extra4Hidden' and (not CH_Config[option]) ) then
    CH_Extra4Frame:Show();
  elseif ( option == 'showAnchors' ) then
    CH_AnchorAdjust( 'ALL' );
  elseif ( option == 'showDockAnchors' ) then
    CH_AnchorAdjust( 'ALL' );
    CH_AnchorRedockAll( 'ALL' );
  elseif ( option == 'frameGroupMode' ) then
    CH_AdjustClickHealFrames();
  elseif ( option == 'frameAlign' ) then
    CH_AdjustPartyFrames();
  elseif ( option == 'showParty' ) then
    CH_AdjustPartyFrames();
  elseif ( option == 'showPartyPets' ) then
    CH_AdjustPartyFrames();
  elseif ( option == 'hidePartyInRaid' ) then
    CH_AdjustPartyFrames();
  elseif ( option == 'showClickHeal' ) then
    CH_AdjustClickHealFrames();
  elseif ( strsub(option,1,13) == 'showRaidGroup' ) then
    CH_AdjustRaidFrames();
  elseif ( option == 'showRaidPets' ) then
    CH_AdjustRaidPetFrames();
    CH_AnchorAdjust( 'RAIDPET' );
  elseif ( strsub(option,1,13) == 'showRaidClass' ) then
    CH_AdjustRaidFrames();
  elseif ( option == 'WoWGuiEnabled' ) then
    CH_WowGuiRegisterClicks();
  elseif ( option == 'showFiveSecondRule' ) then
    if ( CH_Config.showFiveSecondRule and (UnitPowerType('player') == POWER_MANA or CH_UnitClass('player') == 'DRUID') ) then
      CH_FiveSecRuleBar:Show();
      CH_CastBar:ClearAllPoints();
      CH_CastBar:SetPoint( 'TOPLEFT', CH_PlayerManaBar, 'LEFT', 30, 0 );
      CH_CastBar:SetPoint( 'BOTTOMRIGHT', CH_PlayerManaBar, 'BOTTOMRIGHT', 0, 0 );
      CH_CastBarCastTime:ClearAllPoints();
      CH_CastBarCastTime:SetPoint( 'TOPLEFT', CH_CastBar, 'TOPLEFT', 3, 0 );
      CH_CastBarCastTime:SetPoint( 'BOTTOMRIGHT', CH_CastBar, 'BOTTOMRIGHT', 0, 0 );
      CH_CastBarCastTime:SetJustifyH( 'LEFT' );
    else
      CH_FiveSecRuleBar:Hide();
      CH_CastBar:ClearAllPoints();
      CH_CastBar:SetPoint( 'TOPLEFT', CH_PlayerManaBar, 'LEFT', 0, 0 );
      CH_CastBar:SetPoint( 'BOTTOMRIGHT', CH_PlayerManaBar, 'BOTTOMRIGHT', 0, 0 );
      CH_CastBarCastTime:ClearAllPoints();
      CH_CastBarCastTime:SetPoint( 'TOPLEFT', CH_CastBar, 'TOPLEFT', 0, 0 );
      CH_CastBarCastTime:SetPoint( 'BOTTOMRIGHT', CH_CastBar, 'BOTTOMRIGHT', 0, 0 );
      CH_CastBarCastTime:SetJustifyH( 'CENTER' );
    end
    CH_PlayerManaBarLeft:Hide();
  elseif ( option == 'dockTarget' ) then
    CH_DockTargetFrames();
  elseif ( option == 'needyListHealEnabled' or option == 'needyListHealHideInBattlefield' ) then
    CH_NeedyListRegisterWipe( 'HEAL', true );
  elseif ( option == 'needyListBuffEnabled' or option == 'needyListBuffHideInBattlefield' ) then
    CH_NeedyListRegisterWipe( 'BUFF', true );
  elseif ( option == 'needyListCureEnabled' or option == 'needyListCureHideInBattlefield' ) then
    CH_NeedyListRegisterWipe( 'CURE', true );
  elseif ( option == 'needyListDeadEnabled' or option == 'needyListDeadHideInBattlefield' ) then
    CH_NeedyListRegisterWipe( 'DEAD', true );
  elseif ( option == 'needyListHealMaxUnits' or option == 'needyListHealHideOOR' or option == 'needyListHealSort' ) then
    CH_NeedyListRegisterWipe( 'HEAL', false );
  elseif ( option == 'needyListBuffMaxUnits' or option == 'needyListBuffHideOOR' or option == 'needyListHealSort' ) then
    CH_NeedyListRegisterWipe( 'BUFF', false );
  elseif ( option == 'needyListCureMaxUnits' or option == 'needyListCureHideOOR' or option == 'needyListHealSort' ) then
    CH_NeedyListRegisterWipe( 'CURE', false );
  elseif ( option == 'needyListDeadMaxUnits' or option == 'needyListDeadHideOOR' or option == 'needyListHealSort' ) then
    CH_NeedyListRegisterWipe( 'DEAD', false );
  elseif ( option == 'needyListHealHealthPercentage' ) then
    CH_NeedyListRegisterWipe( 'HEAL', false );
  elseif ( option == 'needyListHealLockTanks' ) then
    CH_NeedyListRegisterWipe( 'HEAL', false );
  elseif ( option == 'needyListCureShowCurse' or option == 'needyListCureShowPoison' or option == 'needyListCureShowDisease' or option == 'needyListCureShowMagic' ) then
    CH_NeedyListRegisterWipe( 'CURE', false );
  elseif ( option == 'extraFrameWidth' or option == 'extraFrameHeight' or option == 'extraFrameScale' ) then
    CH_AdjustFrames( 'extra' ); 
  elseif ( option == 'panicFrameWidth' or option == 'panicFrameHeight' or option == 'panicFrameScale' ) then
    CH_AdjustFrames( 'panic' ); 
  elseif ( option == 'playerFrameWidth' or option == 'playerFrameHeight' or option == 'playerFrameScale' ) then
    CH_AdjustFrames( 'player' ); 
  elseif ( option == 'partyFrameWidth' or option == 'partyFrameHeight' or option == 'partyFrameScale' ) then
    CH_AdjustFrames( 'party' ); 
  elseif ( option == 'petFrameWidth' or option == 'petFrameHeight' or option == 'petFrameScale' ) then
    CH_AdjustFrames( 'pet' ); 
  elseif ( option == 'partyPetFrameWidth' or option == 'partyPetFrameHeight' or option == 'partyPetFrameScale' ) then
    CH_AdjustFrames( 'partypet' ); 
  elseif ( option == 'playerTargetFrameWidth' or option == 'playerTargetFrameHeight' or option == 'playerTargetFrameScale' ) then
    CH_AdjustFrames( 'playertarget' ); 
  elseif ( option == 'partyTargetFrameWidth' or option == 'partyTargetFrameHeight' or option == 'partyTargetFrameScale' ) then
    CH_AdjustFrames( 'partytarget' ); 
  elseif ( option == 'petTargetFrameWidth' or option == 'petTargetFrameHeight' or option == 'petTargetFrameScale' ) then
    CH_AdjustFrames( 'pettarget' ); 
  elseif ( option == 'partyPetTargetFrameWidth' or option == 'partyPetTargetFrameHeight' or option == 'partyPetTargetFrameScale' ) then
    CH_AdjustFrames( 'partypettarget' ); 
  elseif ( option == 'raidGroupFrameWidth' or option == 'raidGroupFrameHeight' or option == 'raidGroupFrameScale' ) then
    CH_AdjustFrames( 'raidgroup' ); 
  elseif ( option == 'raidClassFrameWidth' or option == 'raidClassFrameHeight' or option == 'raidClassFrameScale' ) then
    CH_AdjustFrames( 'raidclass' ); 
  elseif ( option == 'mainTankFrameWidth' or option == 'mainTankFrameHeight' or option == 'mainTankFrameScale' ) then
    CH_AdjustFrames( 'maintank' ); 
  elseif ( option == 'needyListHealFrameWidth' or option == 'needyListHealFrameHeight' or option == 'needyListHealFrameScale' ) then
    CH_AdjustFrames( 'needylistheal' ); 
  elseif ( option == 'needyListBuffFrameWidth' or option == 'needyListBuffFrameHeight' or option == 'needyListBuffFrameScale' ) then
    CH_AdjustFrames( 'needylistbuff' ); 
  elseif ( option == 'needyListCureFrameWidth' or option == 'needyListCureFrameHeight' or option == 'needyListCureFrameScale' ) then
    CH_AdjustFrames( 'needylistcure' ); 
  elseif ( option == 'needyListDeadFrameWidth' or option == 'needyListDeadFrameHeight' or option == 'needyListDeadFrameScale' ) then
    CH_AdjustFrames( 'needylistdead' ); 
  end

end

local function CHL_ConfigPostInit( option )

  CHL_ConfigPostChange( 'CTRAEnabled' );
  CHL_ConfigPostChange( 'ORAEnabled' );
  CHL_ConfigPostChange( 'NeedyListEnabled' );
  CHL_ConfigPostChange( 'DUFEnabled' );
  CHL_ConfigPostChange( 'showWoWParty' );
  CHL_ConfigPostChange( 'showBagCooldown' );
  CHL_ConfigPostChange( 'extra1Hidden' );
  CHL_ConfigPostChange( 'extra2Hidden' );
  CHL_ConfigPostChange( 'extra3Hidden' );
  CHL_ConfigPostChange( 'extra4Hidden' );
  CHL_ConfigPostChange( 'WoWGuiEnabled' );
  CHL_ConfigPostChange( 'showFiveSecondRule' );

  CH_AdjustPartyFrames();
  CH_AdjustRaidFrames();
  CH_AdjustRaidPetFrames();
  CH_AdjustMainTankFrames();
  CH_AdjustClickHealFrames();

  CH_AnchorAdjust( 'ALL' );

  CH_AdjustFrames( 'all' ); 

  CH_DockTargetFrames();

  CH_NeedyListRegisterWipe( 'HEAL', false );
  CH_NeedyListRegisterWipe( 'CURE', false );
  CH_NeedyListRegisterWipe( 'BUFF', false );
  CH_NeedyListRegisterWipe( 'DEAD', false );

end

function CH_ConfigSetOption( option, value, force )

  if ( force or value ~= CH_Config[option] ) then
    CHL_ConfigPreChange( option, value );
    CH_Config[option] = value;
    CHL_ConfigPostChange( option );
  end

end

function CH_ConfigGetOption( option )

  return( CH_Config[option] );

end

local function CHL_ConfigInitOption( option )

  local idx;

  if ( option == 'selfDefenseAttackTarget' ) then
    CH_Config.selfDefenseAttackTarget = CH_ToBoolean( playerClass == 'SHAMAN' or playerClass == 'HUNTER' );
  elseif ( option == 'extra1Name' ) then
    CH_Config.extra1Name = CH_DEF_EXTRA_DATA.Extra1.name;
  elseif ( option == 'extra2Name' ) then
    CH_Config.extra2Name = CH_DEF_EXTRA_DATA.Extra2.name;
  elseif ( option == 'extra3Name' ) then
    CH_Config.extra3Name = CH_DEF_EXTRA_DATA.Extra3.name;
  elseif ( option == 'extra4Name' ) then
    CH_Config.extra4Name = CH_DEF_EXTRA_DATA.Extra4.name;
  elseif ( CH_DefaultConfig[option] ) then
    if ( CH_DefaultConfig[option][CH_UnitClass('player')] ) then
      idx = CH_UnitClass('player');
    else
      idx = 'value';
    end
    if ( type(CH_DefaultConfig[option][idx]) == 'table' ) then
      CH_Config[option] = CH_CloneTable( CH_DefaultConfig[option][idx] );
    else
      CH_Config[option] = CH_DefaultConfig[option][idx];
    end
  else
    CH_Dbg( "Tried to init option "..option..", which does not have defaults!", CH_DEBUG_ERR );
  end

end

function CH_ConfigInit( )

  local option;

  if ( CH_Config == nil ) then
    CH_Config = {};
  end

  -- anchors: FIRST copy only the base values, as we have loop dependencies here
  if ( not CH_Anchor ) then
    CH_Anchor = {};
  end

  for k,_ in CH_DefaultAnchor do
    if ( not CH_Anchor[k] ) then
      CH_Anchor[k] = CH_CloneTable( CH_DefaultAnchor[k] );
    end
  end

  -- NOTE: First reset/init all, THEN call the OnChange()
  -- NO PreChange here, as this is the real init
  for option,_ in CH_DefaultConfig do
    if ( CH_Config[option] == nil ) then
      CHL_ConfigInitOption( option );
    end
  end

  -- post triggers Config
  CHL_ConfigPostInit( option );

  -- post triggers Anchors
  CH_AnchorAdjust( 'ALL' );
  CH_AnchorRedockAll();

end

function CH_ConfigCleanup()

  local option;

  if ( CH_DefaultConfig and (not CH_IsEmptyTable(CH_DefaultConfig)) ) then
    for option,_ in CH_Config do
      if ( not CH_DefaultConfig[option] ) then
        CH_Dbg( 'Removing unknown (or expired) option: '..option, CH_DEBUG_INFO );
        CH_Config[option] = nil;
      end
    end
  end

end
 
local function CHL_ConfigResetMouse( tab, spec )

  local idx, defIdx, resetIndexes, mb, actionData, ss;
  local playerClass = CH_UnitClass('player');
  local resetIndexes = { FRIEND='Friend', ENEMY='Enemy', PANIC='Panic', EXTRA1='Extra1', EXTRA2='Extra2', EXTRA3='Extra3', EXTRA4='Extra4' };

  -- ----- check params
  if ( tab == 'ALL' ) then
    -- nop
  else
    resetIndexes = {[tab]=resetIndexes[tab]};
  end

  if ( resetIndexes == nil or CH_IsEmptyTable(resetIndexes) ) then
    CH_Dbg( 'CHLConfigResetMouse() called with invalid tab ('..tab..')', CH_DEBUG_WARNING );
    return;
  end

  -- ----- need to initalize ?
  if ( CH_MouseSpells == nil ) then
    CH_MouseSpells = { Friend={}, Panic={}, Extra1={}, Extra2={}, Extra3={} };
    CH_MouseSpellsData = { Friend={}, Panic={}, Extra1={}, Extra2={}, Extra3={} };
  end

  if ( CH_MouseSpellsData == nil ) then
    CH_MouseSpellsData = { Friend={}, Panic={}, Extra1={}, Extra2={}, Extra3={} };
  end

  -- ----- enemy / shapeshift
  if ( CH_CLASS_INFO[playerClass].shapeshift ) then
    for ss,_ in CH_CLASS_INFO[playerClass].shapeshift.forms do
      if ( CH_MouseSpells['Enemy'..ss] == nil ) then
        CH_MouseSpells['Enemy'..ss] = {};
      end
      if ( CH_MouseSpellsData['Enemy'..ss] == nil ) then
        CH_MouseSpellsData['Enemy'..ss] = {};
      end
    end
  else
    if ( CH_MouseSpells['Enemy'] == nil ) then
      CH_MouseSpells['Enemy'] = {};
    end
    if ( CH_MouseSpellsData['Enemy'] == nil ) then
      CH_MouseSpellsData['Enemy'] = {};
    end
  end

  -- ----- loop over indexes and reset "all"
  for _,idx in resetIndexes do

    -- ----- first clean old data
    if ( idx == 'Enemy' and CH_CLASS_INFO[playerClass].shapeshift ) then
      if ( spec == nil or spec == 'ALL' ) then
        resetIndexes = {};
        for ss,_ in CH_CLASS_INFO[playerClass].shapeshift.forms do
          CH_MouseSpells[idx..ss] = {};
          CH_MouseSpellsData[idx..ss] = {};
          table.insert( resetIndexes, idx..ss );
        end
      elseif ( CH_CLASS_INFO[playerClass].shapeshift.forms[spec] ) then
        CH_MouseSpells[idx..spec] = {};
        CH_MouseSpellsData[idx..spec] = {};
        resetIndexes = {idx..spec};
      else
        CH_Dbg( 'CH_ConfigResetMouse(): spec does not exist! (tab='..tab..', spec='..spec..')', CH_DEBUG_NOTICE );
        resetIndexes = {};
      end
    else
      CH_MouseSpellsData[idx] = {};
      CH_MouseSpells[idx] = {};
      resetIndexes = {idx};
    end

    -- ----- then insert default data
    for _,defIdx in resetIndexes do
      if ( CH_DEF_MOUSE_SPELLS[defIdx] ) then
        for mb,actionData in CH_DEF_MOUSE_SPELLS[defIdx] do 
          if ( actionData[1] == 'ACTION' and CH_ActionList[actionData[2]] ) then
            CH_SetCHAction( actionData[2], defIdx, mb, nil );
          elseif ( actionData[1] == 'PLUGIN' ) then
            CH_SetCHAction( actionData[2], defIdx, mb, nil );
          elseif ( actionData[1] == 'SPELL' ) then
            CH_SetCHAction( actionData[1], defIdx, mb, {spellName=actionData[2],spellRank='MAX'} );
          elseif ( actionData[1] == 'PETSPELL' ) then
            CH_SetCHAction( actionData[1], defIdx, mb, {spellName=actionData[2]} );
          end
        end
      end
    end

  end

end

local function CHL_ConfigResetChain( tab )

  local idx;
  local resetIndexes = {};

  -- ----- check params
  if ( tab == 'ALL' ) then
    for idx=1,CH_MAX_CHAINS do
      resetIndexes['CHAIN'..idx] = 'Chain'..idx;
    end
  else
    resetIndexes[tab] = strsub(tab,1,1)..strlower(strsub(tab,2));
  end

  if ( CH_IsEmptyTable(resetIndexes) ) then
    CH_Dbg( 'CHLConfigResetChain() called with invalid tab ('..tab..')', CH_DEBUG_WARNING );
    return;
  end

  -- ----- need to initalize ?
  if ( CH_ChainData == nil ) then
    CH_ChainData = {};
  end

  -- ----- loop over indexes and reset "all"
  for _,idx in resetIndexes do

    -- ----- clean old data
    CH_MouseSpellsData[idx] = {};
    CH_MouseSpells[idx] = {};
    CH_ChainData[idx] = {};

    -- ----- then insert default data
    -- there is no default data (yet)
    
  end

end

local function CHL_ConfigResetBuffs( )

  local buffIdx;

  CH_BuffData = {};

  for buffIdx,_ in CH_BUFF_DATA do
    if ( CH_UnitCanLearnBuff(buffIdx,'player') ) then
      CH_BuffData[buffIdx] = { classes={}, units={}, enabled=CH_BUFF_DATA[buffIdx].buffEnabled, priority=CH_BUFF_DATA[buffIdx].buffPriority, 
                               warnTime=CH_SPELL_INFO[CH_BUFF_DATA[buffIdx].spellName[1]].warnTime, refreshTime=CH_SPELL_INFO[CH_BUFF_DATA[buffIdx].spellName[1]].refreshTime, 
                               castable=false };

      for k,v in CH_BUFF_DATA[buffIdx].classes do
        if ( v < 0 ) then v = 0; end;
        CH_BuffData[buffIdx].classes[k] = v;
      end

      for k,v in CH_BUFF_DATA[buffIdx].units do
        if ( v < 0 ) then v = 0; end;
        CH_BuffData[buffIdx].units[k] = v;
      end

      if ( CH_BUFF_DATA[buffIdx].partySpellName ) then
        CH_BuffData[buffIdx].partySpellPrefer = 3;
        CH_BuffData[buffIdx].partySpellUpgrade = true;
        CH_BuffData[buffIdx].partySpellInBattlefield = true;
      end
    end
  end

  CH_InitBuffs();

end

local function CHL_ConfigResetCooldown()

  CH_CooldownWatchList = { [1]  = {spellName='None',bookType=nil,spellID=-1},
                           [2]  = {spellName='None',bookType=nil,spellID=-1},
                           [3]  = {spellName='None',bookType=nil,spellID=-1},
                           [4]  = {spellName='None',bookType=nil,spellID=-1},
                           [5]  = {spellName='None',bookType=nil,spellID=-1},
                           [6]  = {spellName='None',bookType=nil,spellID=-1},
                           [7]  = {spellName='None',bookType=nil,spellID=-1},
                           [8]  = {spellName='None',bookType=nil,spellID=-1},
                           [9]  = {spellName='None',bookType=nil,spellID=-1},
                           [10] = {spellName='None',bookType=nil,spellID=-1},
                           [11] = {spellName='None',bookType=nil,spellID=-1},
                           [12] = {spellName='None',bookType=nil,spellID=-1},
                           [13] = {spellName='None',bookType=nil,spellID=-1},
                           [14] = {spellName='None',bookType=nil,spellID=-1},
                           [15] = {spellName='None',bookType=nil,spellID=-1},
                           [16] = {spellName='None',bookType=nil,spellID=-1},
                           [17] = {spellName='None',bookType=nil,spellID=-1},
                           [18] = {spellName='None',bookType=nil,spellID=-1},
                           [19] = {spellName='None',bookType=nil,spellID=-1},
                           [20] = {spellName='None',bookType=nil,spellID=-1},
                         };
  if ( CH_DEF_EXTRA_DATA.Extra1.cooldownSpellName ) then					-- check if spells exists? spell already loaded???
    CH_CooldownWatchList[1].spellName = CH_DEF_EXTRA_DATA.Extra1.cooldownSpellName;
    CH_CooldownWatchList[1].bookType = BOOKTYPE_SPELL;
  end
  if ( CH_DEF_EXTRA_DATA.Extra2.cooldownSpellName ) then
    CH_CooldownWatchList[2].spellName = CH_DEF_EXTRA_DATA.Extra2.cooldownSpellName;
    CH_CooldownWatchList[2].bookType = BOOKTYPE_SPELL;
  end
  if ( CH_DEF_EXTRA_DATA.Extra3.cooldownSpellName ) then
    CH_CooldownWatchList[3].spellName = CH_DEF_EXTRA_DATA.Extra3.cooldownSpellName;
    CH_CooldownWatchList[3].bookType = BOOKTYPE_SPELL;
  end
  if ( CH_DEF_EXTRA_DATA.Extra4.cooldownSpellName ) then
    CH_CooldownWatchList[4].spellName = CH_DEF_EXTRA_DATA.Extra4.cooldownSpellName;
    CH_CooldownWatchList[4].bookType = BOOKTYPE_SPELL;
  end

  CH_InitCooldownWatchList();

end

local function CHL_ConfigResetTotemSet()

  local set, i;

  CH_TotemSetData = {};

  for set=1,CH_MAX_TOTEM_SETS do
    CH_TotemSetData[set] = {};
    for i=1,4 do
      CH_TotemSetData[set][i] = {name='None',spellID=nil,wait=true};
    end
    CH_TotemSetData[set].lastCastTime = -1;
    CH_TotemSetData[set].nextTotem = 1;
    CH_TotemSetData[set].resetSeconds = 5;
  end

end

local function CHL_ConfigResetMainTanks()

  CH_MainTanks = {};

end

local function CHL_ConfigResetEmergencySpells()

  if ( CH_DefaultEmergencySpells ) then
    CH_EmergencySpells = CH_CloneTable( CH_DefaultEmergencySpells );
  else
    CH_EmergencySpells = nil;
  end

end

local function CHL_ConfigResetAnchors()

  local k;

  CH_Anchor = {};

  for k,_ in CH_DefaultAnchor do
    CH_Anchor[k] = CH_CloneTable( CH_DefaultAnchor[k] );
  end

  -- NEVER call any GUI functions here, ONLY init variables (e.g. no redocking or so, done in CH_ConfigReset() below)

end

function CH_ConfigReset( tab, group, spec )

  local option;
  local cnt = 0;

  if ( tab == nil ) then
    CH_Dbg( 'CH_ConfigReset() called with no arguments!', CH_DEBUG_ERR );
    return;
  elseif ( group == nil ) then
    CH_Dbg( 'CH_ConfigReset() called with group == nil!', CH_DEBUG_ERR );
    return;
  end

  if ( CH_Config == nil ) then
    CH_Config = {};
  end

  if ( group == 'MOUSE' or group == 'ALL' ) then
    CHL_ConfigResetMouse( tab, spec );
  end

  if ( (tab == 'ALL' or strsub(tab,1,5) == 'CHAIN') and (group == 'CHAIN' or group == 'ALL') ) then
    CHL_ConfigResetChain( tab );
  end

  if ( (tab == 'BUFF' or tab == 'ALL') and (group == 'BUFF' or group == 'ALL') ) then
    CHL_ConfigResetBuffs();
  end

  if ( (tab == 'CONFIG' or tab == 'ALL') and (group == 'COOLDOWN' or group == 'ALL') ) then
    CHL_ConfigResetCooldown();
  end

  if ( (tab == 'TOTEMSET' or tab == 'ALL') and (group == 'TOTEMSET' or group == 'ALL') ) then
    CHL_ConfigResetTotemSet();
  end

  if ( (tab == 'EXTENDED' or tab == 'ALL') and (group == 'MAINTANK' or group == 'ALL') ) then
    CHL_ConfigResetMainTanks();
  end

  if ( (tab == 'PANIC' or tab == 'ALL') and (group == 'BEHAVIOR' or group == 'ALL') ) then
    CHL_ConfigResetEmergencySpells();
  end

  if ( (tab == 'GUI' or tab == 'ALL') and (group == 'ANCHOR' or group == 'ALL') ) then
    CHL_ConfigResetAnchors();
  end

  -- NOTE: first reset/init all, THEN call the OnChange()
  if ( spec ) then
    CH_Dbg( 'Resetting: '..tab..'/'..group..'/'..spec, CH_DEBUG_INFO );
  else
    CH_Dbg( 'Resetting: '..tab..'/'..group..'/NIL', CH_DEBUG_INFO );
  end

  for option,_ in CH_DefaultConfig do
    if ( (tab == 'ALL' or CH_DefaultConfig[option].tab == tab) and (group == 'ALL' or CH_DefaultConfig[option].group == group) ) then
      CHL_ConfigPreChange( option );
    end
  end
  for option,_ in CH_DefaultConfig do
    if ( (tab == 'ALL' or CH_DefaultConfig[option].tab == tab) and (group == 'ALL' or CH_DefaultConfig[option].group == group) ) then
      CHL_ConfigInitOption( option );
      cnt = cnt + 1;
    end
  end
  for option,_ in CH_DefaultConfig do
    if ( (tab == 'ALL' or CH_DefaultConfig[option].tab == tab) and (group == 'ALL' or CH_DefaultConfig[option].group == group) ) then
      CHL_ConfigPostChange( option );
    end
  end

  if ( (tab == 'EXTENDED' or tab == 'ALL') and (group == 'MAINTANK' or group == 'ALL') ) then
    CH_AdjustMainTankFrames();
  end

  if ( (tab == 'GUI' or tab == 'ALL') and (group == 'ANCHOR' or group == 'ALL') ) then
    CH_AnchorAdjust( 'ALL' );
    CH_AnchorRedockAll();
  end

  if ( cnt < 1 ) then
    CH_Dbg( 'CH_ConfigReset(): tab ('..tab..') or group ('..group..') might not exist!', CH_DEBUG_NOTICE );
  end

end

-- ==========================================================================================================================
-- DPS calculations / handling
-- ==========================================================================================================================

local function CHL_UpdateDPS( unit, tick )

  local diff;
  local unitDPS = gDPS[unit];
  local oldIdx = -1;
  local totalDiff = 0;
  local n = 0;
  local hp = UnitHealth(unit);
  local dpsRecent = -1;
  local idx = tick - DPS_MEMORY + 2;

  if ( not gDPS[unit] ) then
    gDPS[unit] = {};
  end

  if ( gDPS[unit][tick] ) then						-- existing value for tick
    if ( gDPS[unit][tick] > hp ) then						-- take lowest
      gDPS[unit][tick] = hp;
    end
  else									-- new tick
    gDPS[unit][tick] = hp;
   
    while ( idx <= tick ) do							-- for k,v does not return ordered results!
      if ( gDPS[unit][idx] ~= nil and gDPS[unit][idx-1] ~= nil ) then
        diff = gDPS[unit][idx] - gDPS[unit][idx-1];
        if ( diff < 0 ) then
          diff = diff * -1;
          dpsRecent = idx;
        else
          diff = 0;
        end
        if ( idx + DPS_RECENT > tick ) then					-- weigh recent DPS heavier
          totalDiff = totalDiff + diff*2;
        else
          totalDiff = totalDiff + diff;
        end
        n = n + 2;
      end
      idx = idx + 1;
    end

    for idx,_ in gDPS[unit] do							-- clean out too old values
      if ( gDPS[unit][idx] and idx <= tick - DPS_MEMORY ) then
        gDPS[unit][idx] = nil;
      end
    end

    if ( n > 0 ) then
      gDPSCurr[unit] = ceil( totalDiff / 15 );   -- ceil( totalDiff / n );
      gDPSRecent[unit] = dpsRecent;
    else
      gDPSCurr[unit] = 0;
      gDPSRecent[unit] = -1;
    end
  end

end

-- ==========================================================================================================================
-- Debuff handling
-- ==========================================================================================================================

local function CHL_PlayerCanCastDebuff( debuffName )

  -- ----- new debuff
  if ( gSeenDebuffs[debuffName] == nil ) then

    -- ----- lookup in spellbook
    local i = 1;
    local spellName = GetSpellName( i, BOOKTYPE_SPELL );
    while ( spellName and spellName ~= debuffName ) do
      i = i + 1;
      spellName = GetSpellName( i, BOOKTYPE_SPELL );
    end

    gSeenDebuffs[debuffName] = {};
    if ( spellName ) then
      gSeenDebuffs[debuffName].canCast = true;
    else
      gSeenDebuffs[debuffName].canCast = false;
    end
    gSeenDebuffs[debuffName].lastSeen = GetTime();
    gSeenDebuffsCount = gSeenDebuffsCount + 1;

    -- ----- too many entries, remove oldest
    if ( gSeenDebuffsCount > MAX_SEEN_DEBUFFS ) then
      local k,v;
      local nameOldest, timeOldest;
      for k,v in gSeenDebuffs do						-- find oldest
        if ( v.lastSeen < GetTime() - KEEP_SEEN_DEBUFFS ) then				-- already older than _30_ minutes, junk in any case
          gSeenDebuffs[k] = nil;
          gSeenDebuffsCount = gSeenDebuffsCount - 1;
        elseif ( timeOldest == nil or v.lastSeen < timeOldest ) then
          timeOldest = v.lastSeen;
          nameOldest = k;
        end
      end
      if ( gSeenDebuffsCount > MAX_SEEN_DEBUFFS ) then				-- still too big (none too old), remove oldest
        gSeenDebuffs[nameOldest] = nil;
        gSeenDebuffsCount = gSeenDebuffsCount - 1;
      end
    end
  end

  -- ----- return the data
  return( gSeenDebuffs[debuffName].canCast );

end

local function CHL_DebuffDockFrame( debuffIdx, targetFrame, debuffFrame, frameUnit )

  local point, relativePoint, relativeTo;

  if ( CH_Config.dockTarget == 'LEFT' ) then
    point = 'RIGHT';
    relativePoint = 'LEFT';
  else
    point = 'LEFT';
    relativePoint = 'RIGHT';
  end

  debuffFrame:ClearAllPoints();

  if ( debuffIdx == 1 ) then
    debuffFrame:SetPoint( 'BOTTOM'..point, targetFrame, relativePoint, 0, 1 );
  elseif ( debuffIdx == 2 ) then
    debuffFrame:SetPoint( 'TOP'..point, targetFrame, relativePoint, 0, -1 );
  else
    relativeTo = getglobal( 'CH_'..frameUnit..'FrameDebuff'..(debuffIdx-2) );
    debuffFrame:SetPoint( point, relativeTo, relativePoint, 1, 0 );
  end

end

local function CHL_ShowTargetDebuffs( unit, frameUnit )

  local i = 1;
  local debuffIdx = 1;
  local debuffName, debuffTexture;
  local onlyCastable = false;
  local targetFrame, debuffFrame, debuffIcon;

--  if ( getglobal("CH_Tooltip") == nil or getglobal("CH_TooltipTextLeft1") ) then
--    return( false );
--  end

  if ( CH_Config.showTargetDebuffs == 'NONE' ) then
    -- nop;
  elseif ( (CH_Config.showTargetDebuffs == 'ENEMY_ALL' or CH_Config.showTargetDebuffs == 'ENEMY_CASTABLE') and (UnitIsFriend('player',unit)) ) then
    -- nop;
  else
    if ( CH_Config.showTargetDebuffs == 'CASTABLE' or CH_Config.showTargetDebuffs == 'ENEMY_CASTABLE' ) then
      onlyCastable = true;
    end

    debuffTexture = UnitDebuff( unit, i );
    while ( debuffTexture and getglobal('CH_'..frameUnit..'FrameDebuff'..debuffIdx) ) do
      CH_TooltipSetUnitDebuff( unit, i );
      debuffName = CH_TooltipGetTitle();

      if ( (not onlyCastable) or (onlyCastable and CHL_PlayerCanCastDebuff(debuffName)) ) then
        targetFrame = getglobal( 'CH_'..frameUnit..'Frame' );
        debuffFrame = getglobal( 'CH_'..frameUnit..'FrameDebuff'..debuffIdx );
        debuffIcon = getglobal( 'CH_'..frameUnit..'FrameDebuff'..debuffIdx..'Icon' );
  
        CHL_DebuffDockFrame( debuffIdx, targetFrame, debuffFrame, frameUnit );
        debuffIcon:SetTexture( debuffTexture );
        debuffFrame:Show();
     
        debuffIdx = debuffIdx + 1;
      end
  
      i = i + 1;
      debuffTexture = UnitDebuff( unit, i );
    end
  end

  debuffFrame = getglobal( 'CH_'..frameUnit..'FrameDebuff'..debuffIdx );				-- can be NIL (which is ok)
  while ( debuffFrame and debuffFrame:IsVisible() ) do
    debuffFrame:Hide();
    debuffIdx = debuffIdx + 1;
    debuffFrame = getglobal( 'CH_'..frameUnit..'FrameDebuff'..debuffIdx );
  end

end

-- ==========================================================================================================================
-- Blacklist handling
-- ==========================================================================================================================

local function CHL_AddUnitToBlacklist( unit, unitName, spellName, spellRank )

  local idx, spellID, start, duration, enabled;

  if ( unitName and ((not unit) or UnitName(unit) ~= unitName) ) then		-- e.g. unit == 'target' and target changed , can happen at spellcast with duration
    unit = CH_UnitNameToUnit( unitName );
  end

  if ( (not unit) or UnitCanAttack('player',unit) ) then	-- dont track enemies
    return;
  end

  if ( UnitIsUnit(unit,'player') ) then				-- dont track yourself
    return;
  end

  if ( spellName ) then						-- spell passed, check for mana and cooldown
    if ( spellName and type(spellName) == 'string' ) then
      spellID = CH_GetSpellID( spellName, nil, BOOKTYPE_SPELL, false );
    else
      spellID = spellName;
    end

    if ( spellID ~= nil and spellID > 0 ) then					-- only if we found the spell
      start,duration,enabled = GetSpellCooldown( spellID, BOOKTYPE_SPELL );
      if ( start > 0 and duration > 0 ) then						-- spell in cooldown (or global cooldown)
        CH_Dbg( 'BLACKLIST: in cooldown '..spellName );
        return;
      elseif ( UnitMana('player')/UnitManaMax('player') < 0.08 ) then			-- mana too low (less than 8%)
        CH_Dbg( 'BLACKLIST: mana less than 8%' );
        return;
      end
    end
  end

  idx = CH_UnitListIndex(unit,false);

  if ( idx ) then
    gBlacklist[idx] = GetTime() + BLACKLIST_DURATION;
    CH_Debug( 'Unit '..idx..' added to blacklist', CH_DEBUG_INFO );
  end

end

local function CHL_IsOnBlacklist( unit )

  local unitName, expiry;
  local rtc = false;
  local idx = CH_UnitListIndex(unit,false);

  if ( not idx ) then
    return;
  end

  expiry = gBlacklist[idx];

  if ( expiry ) then
    if ( expiry > GetTime() ) then
      rtc = true;
    else
      gBlacklist[idx] = nil;
    end
  end

  -- cleanup
  if ( random(1,100) <= 5 ) then
    for idx,expiry in gBlacklist do
      if ( expiry < GetTime() ) then
        gBlacklist[idx] = nil;
      end
    end
  end

  return( rtc );

end

-- ==========================================================================================================================
-- Events and helper methods, Update
-- ==========================================================================================================================

local function CHL_ShowAmmo()

  if ( CH_UnitClass('player') ~= 'HUNTER' ) then
    return;
  end

  local ammoSlot = GetInventorySlotInfo( "AmmoSlot" );
  local rangedSlot = GetInventorySlotInfo( "RangedSlot" );
  local rangedLink = GetInventoryItemLink( "player", rangedSlot );
  local ammoCount = -1;

  if ( rangedLink ) then
    local _, _, itemCode = strfind( rangedLink, ":(%d+):" );
    local _,_,_,_,itemType,itemSubType = GetItemInfo(itemCode)
    if ( itemType == CH_ITEM_TYPE_WEAPON and itemSubType == CH_ITEM_SUBTYPE_THROWN ) then
      ammoCount = GetInventoryItemCount( "player", rangedSlot );
    end
  end

  if ( ammoCount < 0 ) then
    if ( GetInventoryItemTexture("player",ammoSlot) ) then
      ammoCount = GetInventoryItemCount( "player", ammoSlot );
    else
      ammoCount = 0;
    end
  end

  if ( ammoCount > 1000 ) then
    ammoCount = floor(ammoCount/100)/10;
    ammoCount = ammoCount .. "k";
  end

  CH_PlayerManaBarLeft:SetText( ammoCount );

end

function CH_UpdateBags()

  local bag, slot;
  local runID = GetTime();

  -- !!!!!!!!!!!!!!!! REMOVE THIS REMOVE THIS IF I SCAN SOMETHING ELSE THAN COOLDOWN !!!!! OR DO CHECKS FOR ALL HERE .e.g NeedToUpdateBags()
  if ( not CH_Config.showBagCooldown ) then
    gCooldownBagWatchList = {};				-- KEEP THIS, RESET IT !!!
    return;		 -- !!!!!!!!!!!!!!!! REMOVE THIS REMOVE THIS IF I SCAN SOMETHING ELSE THAN COOLDOWN !!!!! OR DO CHECKS FOR ALL HERE .e.g NeedToUpdateBags()
  end

  -- scan bag for cooldown items
  for bag=0,4 do
    for slot=1,GetContainerNumSlots(bag) do
      itemLink = GetContainerItemLink( bag, slot );
      if ( itemLink ) then
        CH_CooldownBagUpdateCooldown( bag, slot, itemLink, runID );
      end
    end
  end

  CH_CooldownBagUpdateCooldownFinished( runID );

end

function CH_PlayerTargetChanged( when )

  CH_ChainResetNextLine();

end

function CH_PartyMembersChanged( )

  local i;

  gDPS = {};
  gDPSCurr = {};
  gDPSRecent = {};

--  CH_EffectsCleanUp();			DONE in CH_AdjustPartyFrames();

  CH_InitCooldownWatchList();			-- possible new pet

  CH_AdjustPartyFrames();
  CH_AdjustMainTankFrames();

  CH_HealRangeWipe();

end

function CH_RaidRosterUpdate( )

  local i;

  gDPS = {};
  gDPSCurr = {};
  gDPSRecent = {};

  gRaidMemberMap = {};
  if ( GetNumRaidMembers() ) then
    for i=GetNumRaidMembers(),1,-1 do
      gRaidMemberMap[UnitName('raid'..i)] = 'raid'..i;
    end
  end

  CH_AdjustRaidFrames();
  CH_AdjustRaidPetFrames();
  CH_AdjustMainTankFrames();

  CH_EffectsCleanUp();

  CH_HealRangeWipe();

end

function CH_MainUpdateLoop()

  local i, unit, petUnit, rm, batchSize, batchFrom, batchTo;

--  CH_MemoryUsage();
--

  -- first time main loop entered, use to "initialize" data which cannot be done during startup
  if ( gFirstMainLoop ) then
    CH_AnchorAdjust( 'ALL' );
    CH_AnchorRedockAll();
    gFirstMainLoop = false;
  end

  -- update battlefield flag
  CH_UpdateBattlefieldFlag();

  -- range scanning
  CH_HealRangeTargetChanged();

  -- Scan hidden NeedyLists (HIDDEN only!)
  CH_NeedyListProcessEvents( 'HEAL', false );
  CH_NeedyListProcessEvents( 'CURE', false );
  CH_NeedyListProcessEvents( 'BUFF', false );
  CH_NeedyListProcessEvents( 'DEAD', false );

  -- anchors need redocking
  if ( gAnchorNeedRedock ) then
    CH_AnchorRedockAll();
  end

  -- update autoshot/wandusage (inCombat check)
  if ( gWandActionBarSlot > 0 ) then
    if ( IsAutoRepeatAction(gWandActionBarSlot) ) then
      gPlayerActiveAutoShot = true;
      gPlayerPendingAttack = false;
    else
      gPlayerActiveAutoShot = false;
    end
  end

  -- defend myself
  CHL_DefendYourself( false );

  -- how long is buff popup open? autoclose?
  if ( CH_BuffPopupCloseTime > 0 and GetTime() > CH_BuffPopupCloseTime ) then
    CH_PopupBuffs:Hide();
    CH_BuffPopupCloseTime = 0;
  end

  -- delayed join of notify channel
  CH_CheckNotifyChannel();

  -- detect changes in the hide wow party setting
  if ( gWowHidePartyInterface ~= HIDE_PARTY_INTERFACE ) then
    if ( gWowHidePartyInterface ) then
      CH_AdjustPartyFrames( );
    end
    gWowHidePartyInterface = HIDE_PARTY_INTERFACE;
  end

  -- scan the raid (in batches)
  rm = GetNumRaidMembers();
  if ( rm > 0 ) then
    if ( rm <= 10 ) then
      batchSize = 2;
    elseif ( rm <= 20 ) then
      batchSize = 4;
    elseif ( rm <= 30 ) then
      batchSize = 6;
    elseif ( rm <= 40 ) then
      batchSize = 8;
    else
      batchSize = ceil( (rm+1) / 10 );			-- need to scan whole raid in 1 second
    end
      
    for i=1,batchSize do
      if ( gRoundRobinRaidIdx > rm or gRoundRobinRaidIdx < 1 ) then
        gRoundRobinRaidIdx = 1;
      end
      unit = 'raid'..gRoundRobinRaidIdx;
      petUnit = 'raidpet'..gRoundRobinRaidIdx;
      if ( CH_UnitInRaidOnly(unit) ) then
        CHL_UpdateUnitEffects( unit );
        CHL_UpdateUnitEffects( petUnit );
        CHL_UpdateDPS( unit, floor(GetTime()) );
        CHL_UpdateDPS( petUnit, floor(GetTime()) );
      end
      gRoundRobinRaidIdx = gRoundRobinRaidIdx + 1;
    end
  end

  -- update the raid pets
  if ( GetNumRaidMembers() > 0 and CH_Config.showRaidPets and CH_RaidPetsAnchor.lastUpdate < GetTime() - CH_Config.raidPetsScanInterval ) then
    CH_RaidPetsAnchor.lastUpdate = GetTime();
    CH_AdjustRaidPetFrames();
  end

  -- if wow is hidden, update the player effects
  CHL_UpdateUnitEffects( 'player' );
  CHL_UpdateUnitEffects( 'pet' );
  CHL_UpdateDPS( 'player', floor(GetTime()) );
  CHL_UpdateDPS( 'pet', floor(GetTime()) );

  -- update the party
  local pm = GetNumPartyMembers();
  for i=1,pm do
    unit = 'party'..i;
    petUnit = 'partypet'..i;
    CHL_UpdateUnitEffects( unit );
    CHL_UpdateUnitEffects( petUnit );
    CHL_UpdateDPS( unit, floor(GetTime()) );
    CHL_UpdateDPS( petUnit, floor(GetTime()) );
  end

  -- if WoWParty is hidden, hide it again because it might sneaked in
  if ( CH_Config.showWoWParty == false ) then
    HidePartyFrame();
  end

end

local function CHL_HideUnitsTarget( frameUnit )

  local frame = getglobal( 'CH_'..frameUnit..'targetFrame' );

  if ( frame ) then
    frame:Hide();
  end

end

local function CHL_DisplayTargetFrame( frameUnit, unit, isRaid, isPet )

  local frame = getglobal( 'CH_'..frameUnit..'Frame' );

  if ( isRaid ) then
    return( false );
  end

  if ( CH_Config.dockTarget == 'NONE' or (not UnitExists(unit)) or (CH_UnitIsDeadOrGhostForReal(unit) and not UnitIsPlayer(unit)) ) then
    frame:Hide();
    return( false );
  end

  if ( isPet and unit ~= 'pet' and (not CH_Config.showPartyPetTarget) ) then
    frame:Hide();
    return( false );
  end

  frame:Show();

  return( true );

end

	
local function CHL_MayCureGroup( config, viaPanic )

  if ( viaPanic ) then
    if ( CH_PlayerIsInBattlefield() ) then
      return( CH_Config[config..'InBattlefield'] );
    end

    return( CH_Config[config] );
  end

  return( true );
  
end

local function CHL_Decurse( unit, viaPanic )

  -- ----- check if Decursive present
  if ( not CH_Config.DcrEnabled ) then
    CH_Msg( 'decursive support not enabled!' );
    return( false );
  elseif ( not Dcr_CureUnit ) then
    CH_Msg( 'Addon "Decursive" not installed, cannot cure without it!' );
    return( false );
  end

  -- ----- decurse
  if ( unit and Dcr_CureUnit ) then						-- unit
    return( Dcr_CureUnit(unit) );
  elseif ( Dcr_Clean and CHL_MayCureGroup('panicCure',viaPanic)) then		-- panic/group
    return( Dcr_Clean() );
  end

  return( false );

end

local function CHL_UnitBackdropColor( frame, health, unit, checkCombat, isTarget, isMTT, hl )

  local unitClass, r, g, b, a;
  local useBackdrop = true;

  if ( health < 0 ) then
    r,g,b,a = 0.2, 0.2, 0.2, CH_Config.friendFrameBackgroundAlpha;
  elseif ( CH_Config.checkHealRange ~= 'NEVER' and CH_Config.healRangeVisualizationPossible == 'BACKGROUND' and CH_IsUnitInRange(unit,'HEAL') == -1 ) then
    r,g,b,a = CH_Config.healRangeVisualizationPossibleCustomColor.r, CH_Config.healRangeVisualizationPossibleCustomColor.g, CH_Config.healRangeVisualizationPossibleCustomColor.b,
              CH_Config.healRangeVisualizationPossibleCustomColor.a;
  elseif ( CH_Config.checkHealRange ~= 'NEVER' and CH_Config.healRangeVisualizationVerified == 'BACKGROUND' and CH_IsUnitInRange(unit,'HEAL') == -2 ) then
    r,g,b,a = CH_Config.healRangeVisualizationVerifiedCustomColor.r, CH_Config.healRangeVisualizationVerifiedCustomColor.g, CH_Config.healRangeVisualizationVerifiedCustomColor.b,
              CH_Config.healRangeVisualizationVerifiedCustomColor.a;
  elseif ( (isTarget or isMTT) and ( CH_Config.colorTarget == 'NEVER' or (CH_Config.colorTarget == 'PLAYER' and (not UnitIsPlayer(unit))) ) ) then
    r,g,b,a = 0.2, 0.2, 0.2, 0.8;
  elseif ( (not isTarget) and (not isMTT) and CH_Config.friendFrameBackground == 'CUSTOM' ) then
    r,g,b,a = CH_Config.friendFrameBackgroundCustomColor.r, CH_Config.friendFrameBackgroundCustomColor.g, CH_Config.friendFrameBackgroundCustomColor.b,
              CH_Config.friendFrameBackgroundCustomColor.a;
  elseif ( (not isTarget) and (not isMTT) and CH_Config.friendFrameBackground == 'CLASS' ) then
    unitClass = CH_UnitClass( unit );
    if ( RAID_CLASS_COLORS[unitClass] ) then
      r,g,b,a = RAID_CLASS_COLORS[unitClass].r, RAID_CLASS_COLORS[unitClass].g, RAID_CLASS_COLORS[unitClass].g, CH_Config.friendFrameBackgroundAlpha;
    else
      r,g,b,a = 0.2, 0.2, 0.2, 1;
    end
  elseif ( health >= 80 ) then
    r,g,b,a = CH_COLOR['GREEN'].r, CH_COLOR['GREEN'].g, CH_COLOR['GREEN'].b, CH_Config.friendFrameBackgroundAlpha;
  elseif ( health > 60 ) then
    r,g,b,a = CH_COLOR['DARKYELLOW'].r, CH_COLOR['DARKYELLOW'].g, CH_COLOR['DARKYELLOW'].b, CH_Config.friendFrameBackgroundAlpha;
  elseif (health > 40 ) then
    r,g,b,a = CH_COLOR['GOLD'].r, CH_COLOR['GOLD'].g, CH_COLOR['GOLD'].b, CH_Config.friendFrameBackgroundAlpha;
  elseif ( health > 20 ) then
    r,g,b,a = CH_COLOR['ORANGE'].r, CH_COLOR['ORANGE'].g, CH_COLOR['ORANGE'].b, CH_Config.friendFrameBackgroundAlpha;
  elseif ( health > 0 ) then
    r,g,b,a = CH_COLOR['RED'].r, CH_COLOR['RED'].g, CH_COLOR['RED'].b, CH_Config.friendFrameBackgroundAlpha;
  else
    r,g,b,a = 0.2, 0.2, 0.2, 0.8;
  end

  getglobal(frame:GetName()..'Background'):SetTexture( r, g, b, a );

  if ( checkCombat and UnitAffectingCombat(unit) ) then
    frame:SetBackdropBorderColor( 1, 0, 0 );
  else
    frame:SetBackdropBorderColor( 1, 1, 1, 1 );
  end

end

local function CHL_ShouldDisplayHPBar( isNL, nlType )

  if ( isNL and (nlType == 'BUFF' or nlType == 'CURE' or nlType == 'DEAD') ) then
    return( false );
  end

  return( true );

end

local function CHL_ShouldDisplaySPBar( unit, isNL, nlType )

  local powerType = UnitPowerType( unit );

  if ( isNL and nlType == 'HEAL' ) then
    return( true );
  elseif ( unit == 'player' or UnitIsUnit('player',unit) ) then			-- player
    if ( CH_Config.showPlayerMana ) then
      return( true );
    end
  elseif ( unit == 'pet' or UnitIsUnit('pet',unit) ) then			-- pet
    if ( CH_Config.showPetFocus ) then
      return( true );
    end
  elseif ( UnitCanAttack('player',unit) ) then					-- enemy
    if ( powerType == POWER_MANA and CH_Config.showEnemyMana ) then
      return( true );
    elseif ( powerType == POWER_RAGE and CH_Config.showEnemyRage ) then
      return( true );
    elseif ( powerType == POWER_ENERGY and CH_Config.showEnemyEnergy ) then
      return( true );
    elseif ( powerType == POWER_FOCUS and CH_Config.showEnemyFocus ) then
      return( true );
    end
  else										-- friend (or neutral)
    if ( powerType == POWER_MANA and CH_Config.showFriendMana ) then
      return( true );
    elseif ( powerType == POWER_RAGE and CH_Config.showFriendRage ) then
      return( true );
    elseif ( powerType == POWER_ENERGY and CH_Config.showFriendEnergy ) then
      return( true );
    elseif ( powerType == POWER_FOCUS and CH_Config.showFriendFocus ) then
      return( true );
    end
  end

  return( false );

end

local function CHL_GetSPBarColor( unit )

  local powerType = UnitPowerType( unit );

  if ( powerType == nil ) then
    return 1,0,0;
  elseif ( powerType == POWER_MANA ) then
    return 0,0,1;
  elseif ( powerType == POWER_RAGE ) then
    return 1,0,0;
  elseif ( powerType == POWER_FOCUS ) then
    return 0,0,1;
  elseif ( powerType == POWER_ENERGY ) then
    return 1,1,0;
  elseif ( powerType == POWER_HAPPINESS ) then
    return 1,0,0;
  end

  return( {r=1,g=0,b=0} );

end

-- unit: the unit (player,party1,raidpet5,target,...)
-- frameUnit: actually, the name of the frame
-- frameData: 0: player, else the numerical part of the unit (party3=3,raid15=15); if isMTT, the number of the frame; if isNL, the list id (HEAL/BUFF/CURE/DEAD)
-- isRaid: if it is a raid frame (group/class), NOT if the unit is in the raid (or is a raid unit)
-- isPet: if the unit is a pet or not
-- isTarget: if the frame is a target frame
-- isMTT: if the frame is a MainTank frame
-- isNL: if the frame is a NeedyList frame
function CH_OnUnitFrameUpdate( unit, frameUnit, frameData, isRaid, isPet, isTarget, isMTT, isNL )

  local unitFrame = getglobal( 'CH_'..frameUnit..'Frame' );

  -- ----- check if already updating or recently updated for "non critical" frames
  if ( unitFrame.isUpdating and unitFrame.chLastUpdate and unitFrame.chLastUpdate > GetTime() - 1 ) then 			-- already updating and update not too long ago (rescue)
    return;
  elseif ( (isRaid or isMTT or (isNL and frameUnit ~= 'NeedyListHEAL')) and 							-- non critical frames
           unitFrame.chLastUpdate and unitFrame.chLastUpdate > GetTime() -  CH_UNIT_FRAME_UPDATE_INTERVAL_NON_CRITICAL )	-- recently updated
  then
    return;
  end

  unitFrame.chLastUpdate = GetTime();
  unitFrame.isUpdating = true;

  -- ----- initialize values
  local maLabel = getglobal( 'CH_'..frameUnit..'FrameLabel' );
  local effText = getglobal( 'CH_'..frameUnit..'FrameEffects' );
  local hpBar = getglobal( 'CH_'..frameUnit..'FrameHPBar' );
  local barText = getglobal( 'CH_'..frameUnit..'FrameHPBarSPBarCenter' );
  local barDPS = getglobal( 'CH_'..frameUnit..'FrameHPBarSPBarRight' );
  local spBar = getglobal( 'CH_'..frameUnit..'FrameHPBarSPBar' );
  local hp, hpMax, hpPerc, hpBarValue, hpLabelText, eff, sp, spMax, spPerc, spBarColor;
  local r, g, b;
  local petUnit;
  local frameIndex = unit;
  local displayHPBar = CHL_ShouldDisplayHPBar(isNL,frameData);

  -- ----- normalize the passed unit
  unit = CH_NormalizeUnit( unit );

  -- ----- check if target still exists
  if ( isTarget ) then
    if ( not CHL_DisplayTargetFrame(frameUnit,unit,isRaid,isPet) ) then		-- does not 'exist' any longer (or should not be displayed)
      unitFrame.chLastUpdate = nil;
      return;
    end
  end

  -- ----- check if NL still required
--  if ( isNL and (not CH_NeedyListUpdateUnit(unit,frameData)) ) then				now done in NL ProcessEvent
--      unitFrame.chLastUpdate = nil;
--    return;
--  end

  -- ----- check if pet still in group or new pet added
  if ( (not isTarget) and (not isMTT) and (not isNL) ) then
    if ( isRaid ) then								-- Raid Pets
      if ( isPet and (not UnitExists(unit) ) ) then
        CH_AdjustRaidPetFrames();
        unitFrame.chLastUpdate = nil;
        return;
      end
    else									-- Party Pets
      if ( isPet ) then
        if ( (not UnitExists(unit)) and gPetVisibility[unit] == true ) then
          CH_PartyMembersChanged();
          unitFrame.chLastUpdate = nil;
          return;
        end
      else 
        petUnit = CH_UnitsPetUnit( unit );
        if ( petUnit ~= nil and UnitExists(petUnit) and gPetVisibility[petUnit] == false and CH_ConfigGetOption('showPartyPets') ) then
          CH_PartyMembersChanged();
        end
      end
    end
  end

  -- ----- the name/class/pet"race"
  CH_SetUnitLabel( unit, frameData, isPet, isTarget, isMTT, maLabel );

  -- ----- check if unit has target
  if ( (not isTarget) and (not isRaid) and (not isNL) ) then
    CHL_DisplayTargetFrame( frameUnit.."target", CH_NormalizeUnit(unit.."target"), isRaid, isPet );
  end

  -- ----- check unit status
  if ( isMTT and (not UnitExists(unit)) ) then				-- MT but target does not exist (aka nothing targeted)
    hpBar:SetValue( 0 );
    spBar:SetValue( 0 );
    barText:SetTextColor( 0.5, 0.5, 0.5 );
    barText:SetText( '<'..CHT_LABEL_NO_TARGET..'>' );
    barDPS:SetText( '' );
    effText:SetText( '' );
    CHL_UnitBackdropColor( unitFrame, -1, unit, true, isTarget, isMTT ); 
    unitFrame:SetBackdropBorderColor( 1, 1, 1, 1 );
    CHL_HideUnitsTarget( frameUnit )
  elseif ( UnitIsPlayer(unit) and not UnitIsConnected(unit) ) then	-- disconnected
    hpBar:SetValue( 0 );
    spBar:SetValue( 0 );
    barText:SetTextColor( 1, 0, 0 );
    barText:SetText( CH_LABEL_LINKLESS );
    barDPS:SetText( '' );
    effText:SetText( '' );
    CHL_UnitBackdropColor( unitFrame, -1, unit, true, isTarget, isMTT ); 
    unitFrame:SetBackdropBorderColor( 1, 1, 1, 1 );
    CHL_HideUnitsTarget( frameUnit )
  elseif ( UnitIsGhost(unit) ) then					-- ghost
    hpBar:SetValue( 0 );
    spBar:SetValue( 0 );
    barText:SetTextColor( 1, 0, 0 );
    barText:SetText( CH_LABEL_GHOST );
    barDPS:SetText( '' );
    effText:SetText( '' );
    CHL_UnitBackdropColor( unitFrame, -1, unit, true, isTarget, isMTT ); 
    unitFrame:SetBackdropBorderColor( 1, 1, 1, 1 );
    CHL_HideUnitsTarget( frameUnit )
  elseif ( UnitIsDead(unit) and CH_UnitHasBuff(unit,CH_SPELL_FEIGN_DEATH) ) then	-- feigned Death
    hpBar:SetValue( 0 );
    spBar:SetValue( 0 );
    barText:SetTextColor( 1, 0, 0 );
    barText:SetText( CH_LABEL_FEIGN_DEATH );
    barDPS:SetText( '' );
    effText:SetText( '' );
    CHL_UnitBackdropColor( unitFrame, -1, unit, true, isTarget, isMTT ); 
    unitFrame:SetBackdropBorderColor( 1, 1, 1, 1 );
  elseif ( UnitIsDead(unit) ) then					-- dead
    hpBar:SetValue( 0 );
    spBar:SetValue( 0 );
    barText:SetTextColor( 1, 0, 0 );
    barText:SetText( CH_LABEL_DEAD );
    barDPS:SetText( '' );
    effText:SetText( '' );
    CHL_UnitBackdropColor( unitFrame, -1, unit, true, isTarget, isMTT ); 
    unitFrame:SetBackdropBorderColor( 1, 1, 1, 1 );
    CHL_HideUnitsTarget( frameUnit )
  else									-- alive and kicking
    -- --- unit effects
    if ( ((not isTarget) and (not isMTT)) or 
          (isMTT and (CH_UnitIsAvatarOrPet(unit) or CH_UnitInPartyOrRaid(unit))) ) 
    then
      if ( isNL and frameData == 'BUFF' ) then
        eff = CH_NeedyListBuffString( unit );
      elseif ( isNL and frameData == 'CURE' ) then
        eff = CH_NeedyListDebuffString( unit );
      else
        eff = CH_EffectsAsString( unit, 'ALL' );
      end
      if ( CHL_IsOnBlacklist(unit) ) then
        eff = '|c00FFFFFF'..CH_LABEL_BLACKLISTED..eff;
      end
      effText:SetText( eff );
    end
  
    -- --- unit health
    hp = UnitHealth( unit );
    hpMax = UnitHealthMax( unit );
    hpPerc = CH_CalcPercentage( hp, hpMax );

    -- --- healthbar display
    if ( displayHPBar ) then
      hpBarValue,hpLabelText = CH_UnitHPLabel( unit, hp, hpMax, hpPerc, isTarget );
      hpBar:SetValue( hpBarValue );
      barText:SetText( hpLabelText );
      barText:SetTextColor( 1, 1, 1 );
    end

    -- --- level difference display and enemy class
    if ( isTarget or isMTT ) then
      if ( UnitIsPlayer(unit) and UnitCanAttack('player',unit) ) then
        effText:SetText( CH_LocalClassAbbr(CH_UnitClass(unit)) );
	effText:Show();
      elseif ( (not isMTT) or (isMTT and not (CH_UnitIsAvatarOrPet(unit) or CH_UnitInPartyOrRaid(unit))) ) then
	effText:Hide();
      end

      if ( (not CH_Config.showLevelDiff) or CH_UnitIsAvatarOrPet(unit) or CH_UnitInPartyOrRaid(unit) ) then
        barDPS:SetText( '' );
      elseif ( UnitLevel(unit) and UnitLevel(unit) > 0 ) then
        local lvlDiff = UnitLevel(unit) - UnitLevel('player');
        if ( lvlDiff > 0 ) then
          lvlDiff = '+'..lvlDiff;
        end
        barDPS:SetText( lvlDiff );
        barDPS:SetTextColor( 1, 1, 1 );
      else
        barDPS:SetText( '??' );
        barDPS:SetTextColor( 1, 1, 1 );
      end
    -- --- DPS display
    elseif ( displayHPBar ) then
      if ( not gDPSCurr[unit] or gDPSCurr[unit] <= 0 ) then
        barDPS:SetTextColor( 0.5, 0.5, 0.5 );
      elseif ( gDPSRecent[unit] and gDPSRecent[unit] > -1 and gDPSRecent[unit] + DPS_RECENT > floor(GetTime()) ) then
        barDPS:SetTextColor( 1, 0, 0 );
      else
         barDPS:SetTextColor( 1, 1, 0 );
      end

      if ( gDPSCurr[unit] ) then
        barDPS:SetText( gDPSCurr[unit] );
      else
        barDPS:SetText( 0 );
      end
    end
  
    -- --- unit in combat? red border
    CHL_UnitBackdropColor( unitFrame, hpPerc, unit, true, isTarget, isMTT ); 

    -- ----- spell bar?
    if ( CHL_ShouldDisplaySPBar(unit,isNL,frameData) ) then
      r,g,b = CHL_GetSPBarColor( unit );
      sp = UnitMana( unit );
      spMax = UnitManaMax( unit );
      spPerc = CH_CalcPercentage( sp, spMax );
      spBar:SetValue( spPerc );
      spBar:SetStatusBarColor( r, g, b );
    else
      spBar:SetValue( 0 );
    end

    -- ----- Debuffs?
    if ( isTarget and (not isMTT) ) then
      CHL_ShowTargetDebuffs( unit, frameUnit );
    end
  end

  -- ----- show or hide the HPBar
  if ( displayHPBar ) then
    hpBar:Show();
    spBar:Show();
  else
    hpBar:Hide();
    spBar:Hide();
  end

  -- ----- refresh tooltip
  CH_TooltipRefresh( unit, frameIndex );
  CH_TooltipActionsRefresh( unit, frameIndex );

  -- ----- ready with update
  unitFrame.isUpdating = nil;

end

function CH_OnPlayerManaUpdate()

  local spPerc = CH_CalcPercentage( UnitMana('player'), UnitManaMax('player') );
  local spTxt = floor(spPerc);

  if ( UnitPowerType('player') == POWER_ENERGY ) then
    spTxt = spTxt..'/'..GetComboPoints();
  end

  CH_PlayerManaBar:SetValue( spPerc );
  CH_PlayerManaBarCenter:SetText( spTxt );

  CH_PlayerManaBarRight:SetText( CH_EffectsAsString('party','ALL') );

  CHL_CooldownShow();

  CHL_ShowAmmo();

  CH_TooltipActionsRefresh( nil, 'Panic' );

end

-- spellName: - string/int: Name or id of Spell or slotID if INV
--            - table:  BAG: {bag=#,slot=#}
-- unit:      the unit to cast/use on
-- spellType: SPELL or PETSPELL BAG or INV
function CH_CastSpellOnFriend( spellName, spellRank, unit, spellType )

  local reTarget = nil;
  local castOnSelf = nil;

  -- ----- valid spell name?
  if ( spellName == nil ) then
    return;
  elseif ( (spellType == 'SPELL' or spellType == 'PETSPELL') and type(spellName) == 'string' and spellName == '' ) then
    return;
  elseif ( (spellType == 'SPELL' or spellType == 'PETSPELL') and type(spellName) == 'number' and spellName < 0 ) then
    return;
  end

  -- ----- convert spellID to spellName/spellRank
  if ( spellType == 'SPELL' and type(spellName) == 'number' ) then
    spellName,spellRank = CH_GetSpellName( spellName, BOOKTYPE_SPELL );
  end

  -- ----- shadowform/ghost wolf/hide toggle?
  if ( (spellName == CH_SPELL_SHADOWFORM or spellName == CH_SPELL_GHOST_WOLF or spellName == CH_SPELL_STEALTH) and CH_Config.toggleShadowform ) then
    local buffIdx = CH_GetPlayerBuffByName( spellName );
    if ( buffIdx >= 0 ) then
      CancelPlayerBuff( buffIdx );
      return;
    end
  end

  -- ----- charmed?
  if ( unit and UnitIsCharmed(unit) and (((not CH_Config.castOnCharmedFriend) and (not UnitIsEnemy('player',unit))) or 
                                         ((not CH_Config.castOnCharmedFriend) and UnitIsEnemy('player',unit))) )
  then
    CH_Dbg( 'Not casting on charmed (friendly/enemy) unit', CH_DEBUG_INFO );
    return;
  end

  -- ----- check rank
  if ( spellRank and spellRank == 'MAX' ) then
    spellRank = nil;
  end

  -- ----- pet spell and name given?
  if ( spellType == 'PETSPELL' and type(spellName) == 'string' ) then
    spellName = CH_GetSpellID( spellName, nil, BOOKTYPE_PET, false );
    if ( spellName < 0 ) then
      return;
    end
  end

  -- ----- adjust spell rank
  if ( spellType == 'SPELL' and unit ) then
    spellName,spellRank = CH_AdjustSpellRank( unit, spellName, spellRank );
  end

  -- ----- chose the target
  if ( UnitIsUnit('player',unit) and spellType == 'SPELL' and CH_Config.castSpellByNameOnSelf ) then
    castOnSelf = 1;
  elseif ( UnitExists('target') and (not UnitIsUnit(unit,"target")) ) then
    if ( unit and (GetCVar('autoSelfCast') == '1' or (spellType == 'SPELL' and (spellName == CH_SPELL_HOLY_SHOCK or spellName == CH_SPELL_DISPEL_MAGIC))) ) then
      reTarget = CH_NormalizeUnit( 'target' );
      TargetUnit( unit );
    elseif ( not UnitCanAttack('player','target') ) then			-- OLD: not UnitIsEnemy('player','target')
      reTarget = CH_NormalizeUnit( 'target' );
      CH_ClearTargetSilently();
    end
  elseif ( (not UnitExists('target')) and GetCVar('autoSelfCast') == '1' ) then
    reTarget = CH_NormalizeUnit( 'target' );
    TargetUnit( unit );
  end

  -- ----- cast the spell
  if ( spellType == 'SPELL' ) then
    CH_CastSpellByName( spellName, spellRank, unit, castOnSelf );
  elseif ( spellType == 'PETSPELL' ) then
    CH_CastSpell( spellName, BOOKTYPE_PET, unit );
  elseif ( spellType == 'BAG' ) then
    UseContainerItem( spellName.bag, spellName.slot );
  elseif ( spellType == 'INV' ) then
    UseInventoryItem( spellName );
  end

  -- ----- Target selection
  if ( SpellIsTargeting() ) then
    if ( SpellCanTargetUnit(unit) ) then
      CH_SpellTargetUnit( unit );
    else
      CH_SpellStopTargeting();
      CHL_AddUnitToBlacklist( unit, UnitName(unit), spellName, spellRank );
    end
  end

  -- ----- Retarget if required
  if ( reTarget ) then
    CH_ReTarget( reTarget );
  end

end

-- spellName: - string/int: Name or id of Spell or slotID if INV
--            - table:  BAG: {bag=#,slot=#}
-- unit:      the unit to cast/use on
-- spellType: SPELL or PETSPELL or BAG or INV
function CH_CastSpellOnEnemy( spellName, spellRank, unit, spellType )

  local reTarget = nil;

  -- ----- valid spell name?
  if ( spellName == nil ) then
    return;
  elseif ( (spellType == 'SPELL' or spellType == 'PETSPELL') and type(spellName) == 'string' and spellName == '' ) then
    return;
  elseif ( (spellType == 'SPELL' or spellType == 'PETSPELL') and type(spellName) == 'number' and spellName < 0 ) then
    return;
  end

  -- ----- shadowform/ghost wolf/stealth toggle?
  if ( (spellName == CH_SPELL_SHADOWFORM or spellName == CH_SPELL_GHOST_WOLF or spellName == CH_SPELL_STEALTH) and CH_Config.toggleShadowform ) then
    local buffIdx = CH_GetPlayerBuffByName( spellName );
    if ( buffIdx >= 0 ) then
      CancelPlayerBuff( buffIdx );
      return;
    end
  end

  -- ----- charmed?
  if ( unit and UnitIsCharmed(unit) and (((not CH_Config.castOnCharmedFriend) and (not UnitIsEnemy('player',unit))) or 
                                         ((not CH_Config.castOnCharmedFriend) and UnitIsEnemy('player',unit))) )
  then
    CH_Dbg( 'Not casting on charmed (friendly/enemy) unit', CH_DEBUG_INFO );
    return;
  end

  -- ----- check rank
  if ( spellRank and spellRank == 'MAX' ) then
    spellRank = nil;
  end

  -- ----- pet spell and name given?
  if ( spellType == 'PETSPELL' and type(spellName) == 'string' ) then
    spellName = CH_GetSpellID( spellName, nil, BOOKTYPE_PET, false );
    if ( spellName < 0 ) then
      return;
    end
  end

  -- ----- adjust spell rank
  if ( spellType == 'SPELL' and unit ) then
    spellName,spellRank = CH_AdjustSpellRank( unit, spellName, spellRank );
  end

  -- ----- chose the target
  if ( unit and (not UnitIsUnit(unit,"target")) ) then
    if ( CH_Config.targetingMode == 'KEEP' or (CH_Config.targetingMode == 'INT' and UnitExists('target')) ) then
      reTarget = CH_NormalizeUnit( 'target' );
    end
    TargetUnit( unit );
  end

  -- ----- cast the spell
  if ( spellType == 'SPELL' and type(spellName) == 'string' ) then
    CH_CastSpellByName( spellName, spellRank, unit, false );
  elseif ( spellType == 'SPELL' ) then
    CH_CastSpell( spellName, BOOKTYPE_SPELL, unit );
  elseif ( spellType == 'PETSPELL' ) then
    CH_CastSpell( spellName, BOOKTYPE_PET, unit );
  elseif ( spellType == 'BAG' ) then
    UseContainerItem( spellName.bag, spellName.slot );
  elseif ( spellType == 'INV' ) then
    UseInventoryItem( spellName );
  end

  -- ----- Retarget if required
  if ( reTarget ) then
    CH_ReTarget( reTarget );
  end

end

-- ==========================================================================================================================
-- Group buffing
-- ==========================================================================================================================

local function CHL_BuffRemainingTime( unit, effIdx )

  local buffName = CH_BUFF_DATA[effIdx].spellName[1];
  local unitIdx = CH_UnitListIndex( unit, true );

  if (  CH_IsEffectedBy(unit,effIdx,false) ) then
    if ( gUnitEffects[unitIdx][effIdx].castTime ) then
      if ( gUnitEffects[unitIdx][effIdx].warn ) then
        return( CH_BUFF_REFRESH_MISSING + (gUnitEffects[unitIdx][effIdx].castTime+CHL_EffectDuration(unit,effIdx)-GetTime()) );
      else
        return( gUnitEffects[unitIdx][effIdx].castTime+CHL_EffectDuration(unit,effIdx)-GetTime() );
      end
    end
    return( CH_BUFF_REFRESH_UNKNOWN );
  end

  return( CH_BUFF_REFRESH_MISSING );

end

local function CHL_MayRefreshBuff( unit, effIdx, useWarnTime )

  local checkTime, duration;
  local buffName = CH_BUFF_DATA[effIdx].spellName[1];
  local unitIdx = CH_UnitListIndex( unit, true );

  if ( CH_IsEffectedBy(unit,effIdx,false) ) then
    if ( useWarnTime ) then
      checkTime = CH_BuffData[effIdx].warnTime;
    else
      checkTime = CH_BuffData[effIdx].refreshTime;
    end
    -- no refresh wanted
    if ( checkTime <= 0 ) then
      return( false );
    -- weapon buffs
    elseif ( CH_BUFF_DATA[effIdx] and CH_BUFF_DATA[effIdx].isWeaponBuff ) then
      return( checkTime >= floor(gUnitEffects[unitIdx][effIdx].expiration/1000) );		-- ERROR (ui.worldofwar.net, Hratgard);
    -- other buffs
    elseif ( gUnitEffects[unitIdx][effIdx].castTime ) then
      duration =  CHL_EffectDuration( unit, effIdx );
      return( GetTime() >= gUnitEffects[unitIdx][effIdx].castTime+duration-checkTime );
    end
  end

  return( true );

end

-- returns: -1 if normal version should be cast
--          spellID of party spell if this is prefered
local function CHL_PreferPartyBuff( buffIdx, targetUnit, useWarnTime )

  local i = 0;
  local missing = 0;
  local unitClass = CH_UnitClass( targetUnit );
  local petUnit, unitGroup, subGroup, raidIdx;

  -- quick resolve
  if ( not CH_BUFF_DATA[buffIdx].partySpellName ) then			-- no party version
    return( -1 );
  elseif ( not  CH_BuffData[buffIdx].partySpellCastable ) then		-- cannot cast party version (e.g. not yet learned)
    return( -1 );
  elseif ( CH_BuffData[buffIdx].partySpellPrefer > 5 ) then		-- never upgrade
    return( -1 );
  elseif ( (not CH_BuffData[buffIdx].partySpellInBattlefield) and CH_PlayerIsInBattlefield() ) then	-- not in battlefield option
    return( -1 );
  end

  -- quick resolve possible ? (if cast is 'always' and my targetUnit is missing it)
  if ( CH_BuffData[buffIdx].partySpellPrefer == 1 and 
              (CHL_MayRefreshBuff(targetUnit,buffIdx,useWarnTime) or 
               (CH_BuffData[buffIdx].partySpellUpgrade and (not CH_UnitHasBuff(targetUnit,CH_BUFF_DATA[buffIdx].partySpellName,CH_PETSPELL_PHASE_SHIFT)))) ) 
  then
    return( CH_GetSpellID(CH_BUFF_DATA[buffIdx].partySpellName,nil,BOOKTYPE_SPELL,true) );		-- -1: not know or missing component
  -- party version
  elseif ( CH_BUFF_DATA[buffIdx].partySpellType == 'PARTY' ) then
    if ( CH_UnitIsAvatarOrPet(targetUnit) or CH_UnitInParty(targetUnit) ) then			-- targetUnit is avatar or in Party
      while ( i <= GetNumPartyMembers() and missing < CH_BuffData[buffIdx].partySpellPrefer ) do
        if ( i < 1 ) then
          unit = 'player';
          petUnit = 'pet';
        else
          unit = 'party'..i;
          petUnit = 'partypet'..i;
        end
        if ( CHL_MayRefreshBuff(unit,buffIdx,useWarnTime) or
             (CH_BuffData[buffIdx].partySpellUpgrade and (not CH_UnitHasBuff(unit,CH_BUFF_DATA[buffIdx].partySpellName))) ) 
        then
          missing = missing + 1;
        end
        if ( UnitExists(petUnit) and (CHL_MayRefreshBuff(petUnit,buffIdx,useWarnTime) or
                                      (CH_BuffData[buffIdx].partySpellUpgrade and (not CH_UnitHasBuff(petUnit,CH_BUFF_DATA[buffIdx].partySpellName,CH_PETSPELL_SHAPE_SHIFT)))) ) 
        then
          missing = missing + 1;
        end
        i = i + 1;
      end
    elseif ( CH_UnitInRaid(targetUnit) ) then								-- target unit in raid
      raidIdx = CH_UnitToRaidIdx( targetUnit );
      if ( raidIdx ) then
        i = 1;
        _,_,unitGroup = GetRaidRosterInfo( raidIdx );
        while ( i <= GetNumRaidMembers() and missing < CH_BuffData[buffIdx].partySpellPrefer ) do
          unit = 'raid'..i;
          petUnit = 'raidpet'..i;
          _,_,subGroup = GetRaidRosterInfo( i );
          if ( unitGroup == subGroup ) then
            if ( CHL_MayRefreshBuff(unit,buffIdx,useWarnTime) or
                 (CH_BuffData[buffIdx].partySpellUpgrade and (not CH_UnitHasBuff(unit,CH_BUFF_DATA[buffIdx].partySpellName))) ) 
            then
              missing = missing + 1;
            end
            if ( UnitExists(petUnit) and (CHL_MayRefreshBuff(petUnit,buffIdx,useWarnTime) or
                                          (CH_BuffData[buffIdx].partySpellUpgrade and (not CH_UnitHasBuff(petUnit,CH_BUFF_DATA[buffIdx].partySpellName,CH_PETSPELL_SHAPE_SHIFT)))) ) 
            then
              missing = missing + 1;
            end
	  end
          i = i + 1;
        end
      end
    end
  -- (greater) blessing version
  elseif ( CH_BUFF_DATA[buffIdx].partySpellType == 'BLESSING' ) then
    while ( i <= GetNumRaidMembers() and missing < CH_BuffData[buffIdx].partySpellPrefer ) do
      if ( i < 1 ) then
        unit = 'player';
      else
        unit = 'raid'..i;
      end
      if ( CH_UnitClass(unit) ~= unitClass ) then
        -- nop
      elseif ( CHL_MayRefreshBuff(unit,buffIdx,useWarnTime) or
           (CH_BuffData[buffIdx].partySpellUpgrade and (not CH_UnitHasBuff(unit,CH_BUFF_DATA[buffIdx].partySpellName))) ) 
      then
        missing = missing + 1;
      end
      i = i + 1;
    end
  end

  if ( missing >= CH_BuffData[buffIdx].partySpellPrefer ) then						-- prefer to cast party version
    return( CH_GetSpellID(CH_BUFF_DATA[buffIdx].partySpellName,nil,BOOKTYPE_SPELL,true) );		-- -1: not know or missing component
  end

  -- do not upgrade
  return( -1 );

end

-- this function checks if the buff can technically be cast on the unit (wow restrictions)
-- for "normal" checking/execution, use CH_IsValidBuffTarget()
function CHL_MayCastBuffOnUnit( buffIdx, unit )

  local unitIsPlayer = UnitIsPlayer(unit);

  if ( unitIsPlayer and CH_BuffData[buffIdx].classes[CH_UnitClass(unit)] == -1 ) then
    return( false );
  elseif ( (not unitIsPlayer) and CH_BuffData[buffIdx].classes.PET == -1 ) then
    return( false );
  end

  if ( UnitIsUnit(unit,'player') ) then
    return( CH_BuffData[buffIdx].units['player'] ~= -1 );
  elseif ( UnitIsUnit(unit,'pet') ) then
    return( CH_BuffData[buffIdx].units['pet'] ~= -1 );
  elseif ( unitIsPlayer and CH_UnitPlayerInParty(unit) ) then
    return( CH_BuffData[buffIdx].units['party'] ~= -1 );
  elseif ( (not unitIsPlayer) and CH_UnitInParty(unit) ) then
    return( CH_BuffData[buffIdx].units['partypet'] ~= -1 );
  elseif ( unitIsPlayer and CH_UnitPlayerInRaid(unit) ) then
    return( CH_BuffData[buffIdx].units['raid'] ~= -1 );
  elseif ( (not unitIsPlayer) and CH_UnitInRaid(unit) ) then
    return( CH_BuffData[buffIdx].units['raidpet'] ~= -1 );
  elseif ( string.find(unit,'target') ) then
    return( CH_BuffData[buffIdx].units['target'] ~= -1 );
  end

  CH_Dbg( "CHL_MayCastBuffOnUnit: no settings found for "..unit, CH_DEBUG_WARNING );
  return( false );

end

function CH_IsValidBuffTarget( buffIdx, unit, force, useWarnTime )

  local unitOK = false;
  local unitIsPlayer = UnitIsPlayer(unit);
  local v;

  if ( (not CH_BuffData[buffIdx]) or (not CH_BuffData[buffIdx].castable) ) then
    return( false );
  end

  if ( (not UnitExists(unit)) or CH_UnitIsDeadOrGhostForReal(unit) or (unitIsPlayer and not UnitIsConnected(unit)) ) then
    return( false );
  end

  if ( CH_BuffData[buffIdx].buffEnabled == false ) then
    return( false );
  end

  if ( unitIsPlayer and CH_BuffData[buffIdx].classes[CH_UnitClass(unit)] == 0 ) then
    return( false );
  elseif ( (not unitIsPlayer) and CH_BuffData[buffIdx].classes.PET == 0 ) then
    return( false );
  end

  if ( UnitIsUnit(unit,'player') ) then
    unitOK = (CH_BuffData[buffIdx].units['player'] == 1);
  elseif ( UnitIsUnit(unit,'pet') ) then
    unitOK = (CH_BuffData[buffIdx].units['pet'] == 1);
  elseif ( unitIsPlayer and CH_UnitPlayerInParty(unit) ) then
    unitOK = (CH_BuffData[buffIdx].units['party'] == 1);
  elseif ( (not unitIsPlayer) and CH_UnitInParty(unit) ) then
    unitOK = (CH_BuffData[buffIdx].units['partypet'] == 1);
  elseif ( unitIsPlayer and CH_UnitPlayerInRaid(unit) ) then
    unitOK = (CH_BuffData[buffIdx].units['raid'] == 1);
  elseif ( (not unitIsPlayer) and CH_UnitInRaid(unit) ) then
    unitOK = (CH_BuffData[buffIdx].units['raidpet'] == 1);
  elseif ( string.find(unit,'target') ) then
    unitOK = (CH_BuffData[buffIdx].units['target'] == 1);
  else
    CH_Dbg( 'CH_IsValidBuffTarget in ELSE for unit '..unit, CH_DEBUG_ERROR );
    unitOK = false;
  end

  if ( not unitOK ) then
    return( false );
  end

  if ( force ) then
    return( true );
  end

  if ( CHL_IsOnBlacklist(unit) ) then
    return( false );
  elseif ( not CHL_MayRefreshBuff(unit,buffIdx,useWarnTime) ) then
    return( false );
  elseif ( CH_IsEffectedBy(unit,'PS',false) ) then
    return( false );
  end

  return( true );

end

local function CHL_TryCastBuff( buffIdx, unit, useWarnTime, forceCast )

  local spellID;

  if ( forceCast or CH_IsValidBuffTarget(buffIdx,unit,false,useWarnTime) ) then		-- REMOVE, already checked  (IS IT????)
    spellID = CHL_PreferPartyBuff( buffIdx, unit, useWarnTime );
    if ( spellID > 0 ) then
      CH_CastSpellOnFriend( spellID, nil, unit, 'SPELL' );
    else
      CH_CastSpellOnFriend( CH_Spells[buffIdx].spellName, nil, unit, 'SPELL' );
    end

    return( true );
  end

  return( false );

end

local function CHL_MayBuffGroup( config, viaPanic )

  if ( viaPanic ) then
    if ( CH_PlayerIsInBattlefield() ) then
      return( CH_Config[config..'InBattlefield'] );
    end

    return( CH_Config[config] );
  end

  return( true );
  
end

local function CHL_CompareRefreshBuff( unit, buffIdx, useWarnTime, refreshUnit, refreshBuffIdx, refreshTimeRemain )

  local timeRemain;

  if ( CH_IsValidBuffTarget(buffIdx,unit,false,useWarnTime) ) then
    timeRemain = CHL_BuffRemainingTime( unit, buffIdx );
    if ( (not refreshBuffIdx) or (timeRemain < refreshTimeRemain) ) then
      return unit, buffIdx, timeRemain;
    end
  end

  return refreshUnit, refreshBuffIdx, refreshTimeRemain;

end

local function CHL_BuffGroup( viaPanic, refreshMode )

  local buffIdx, timeRemain, useWarnTime;
  local refreshBuffIdx = nil;
  local refreshTimeRemain = nil;
  local refreshUnit = nil;

  if ( refreshMode == 'WARN_TIME' ) then
    useWarnTime = true;
  else
    useWarnTime = false;
  end

  for _,buffIdx in CH_BuffPriority do
    if ( CH_BuffData[buffIdx].enabled ) then
      if ( CHL_MayBuffGroup('panicBuffPlayer',viaPanic) ) then
        refreshUnit,refreshBuffIdx,refreshTimeRemain = CHL_CompareRefreshBuff( 'player', buffIdx, useWarnTime, refreshUnit, refreshBuffIdx, refreshTimeRemain );
        if ( refreshTimeRemain and refreshTimeRemain == CH_BUFF_REFRESH_MISSING ) then break; end;
      end
      if ( CHL_MayBuffGroup('panicBuffPet',viaPanic) ) then 
        refreshUnit,refreshBuffIdx,refreshTimeRemain = CHL_CompareRefreshBuff( 'pet', buffIdx, useWarnTime, refreshUnit, refreshBuffIdx, refreshTimeRemain );
        if ( refreshTimeRemain and refreshTimeRemain == CH_BUFF_REFRESH_MISSING ) then break; end;
      end

      for i=1,GetNumPartyMembers() do
        if ( CHL_MayBuffGroup('panicBuffParty',viaPanic) and CH_UnitInParty('party'..i) ) then
          refreshUnit,refreshBuffIdx,refreshTimeRemain = CHL_CompareRefreshBuff( 'party'..i, buffIdx, useWarnTime, refreshUnit, refreshBuffIdx, refreshTimeRemain );
          if ( refreshTimeRemain and refreshTimeRemain == CH_BUFF_REFRESH_MISSING ) then break; end;
        end
        if ( CHL_MayBuffGroup('panicBuffPartyPet',viaPanic) and CH_UnitInParty('partypet'..i) ) then 
          refreshUnit,refreshBuffIdx,refreshTimeRemain = CHL_CompareRefreshBuff( 'partypet'..i, buffIdx, useWarnTime, refreshUnit, refreshBuffIdx, refreshTimeRemain );
          if ( refreshTimeRemain and refreshTimeRemain == CH_BUFF_REFRESH_MISSING ) then break; end;
        end
      end
      if ( refreshTimeRemain and refreshTimeRemain == CH_BUFF_REFRESH_MISSING ) then break; end;

      for i=1,GetNumRaidMembers() do
        if ( CHL_MayBuffGroup('panicBuffRaid',viaPanic) and CH_UnitInRaidOnly('raid'..i) ) then 
          refreshUnit,refreshBuffIdx,refreshTimeRemain = CHL_CompareRefreshBuff( 'raid'..i, buffIdx, useWarnTime, refreshUnit, refreshBuffIdx, refreshTimeRemain );
          if ( refreshTimeRemain and refreshTimeRemain == CH_BUFF_REFRESH_MISSING ) then break; end;
        end
        if ( CHL_MayBuffGroup('panicBuffRaidPet',viaPanic) and CH_UnitInRaidOnly('raidpet'..i) ) then
          refreshUnit,refreshBuffIdx,refreshTimeRemain = CHL_CompareRefreshBuff( 'raidpet'..i, buffIdx, useWarnTime, refreshUnit, refreshBuffIdx, refreshTimeRemain );
          if ( refreshTimeRemain and refreshTimeRemain == CH_BUFF_REFRESH_MISSING ) then break; end;
        end
      end
      if ( refreshTimeRemain and refreshTimeRemain == CH_BUFF_REFRESH_MISSING ) then break; end;

    end
  end

  if ( refreshBuffIdx ) then
    return( CHL_TryCastBuff(refreshBuffIdx,refreshUnit,useWarnTime,false) );
  end

  return( false );

end

local function CHL_BuffUnitPopup( unit )

  local frame, visibleButtons, idx, timeAbs, timeRound, unitOfMeasure, timeStr, msg;
  local i = 1;
  local buffsEnabled = 0;
  local buffs = {};

  for _,buffIdx in CH_BuffPriority do
    if ( CH_BuffData[buffIdx].castable and CH_BUFF_DATA[buffIdx].classes[CH_UnitClass(unit)] ~= -1 ) then
      timeStr = nil;
      timeAbs,timeRound,unitOfMeasure = CHL_EffectRemainingTime( unit, buffIdx );
      if ( timeRound ) then
        timeStr = timeRound..unitOfMeasure;
      end

      if ( CH_BuffData[buffIdx].enabled ) then
        buffsEnabled = buffsEnabled + 1;
        if ( not CH_IsValidBuffTarget(buffIdx,unit,true,false) ) then
          table.insert( buffs, buffsEnabled, {buffIdx=buffIdx,color='ORANGE',remain=timeStr} );
        elseif ( CH_IsValidBuffTarget(buffIdx,unit,false,false) ) then
          table.insert( buffs, buffsEnabled, {buffIdx=buffIdx,color='BRIGHTGREEN',remain=timeStr} );
        else
          table.insert( buffs, buffsEnabled, {buffIdx=buffIdx,color='YELLOW',remain=timeStr} );
        end
      else
        table.insert( buffs, {buffIdx=buffIdx,color='RED',remain=timeStr} );
      end
    end
  end

  table.insert( buffs, buffsEnabled+1, {buffIdx='AUTOMATIC',color='SKYBLUE',remain=nil} );

  visibleButtons = table.getn( buffs );
  if ( visibleButtons > CH_MAX_BUFFS ) then
    visibleButtons = CH_MAX_BUFFS;
  end

  for idx,_ in buffs do
    if ( buffs[idx].buffIdx == 'AUTOMATIC' ) then
      msg = 'Automatic';
    else
      msg = CH_BUFF_DATA[buffs[idx].buffIdx].displayName;
    end
    if ( buffs[idx].remain ) then
      msg = msg .. " ["..buffs[idx].remain.."]";
    end
    getglobal( 'CH_PopupBuffsButton'..i..'Text' ):SetText( msg );
    getglobal( 'CH_PopupBuffsButton'..i..'Text' ):SetTextColor( CH_COLOR[buffs[idx].color].r, CH_COLOR[buffs[idx].color].g, CH_COLOR[buffs[idx].color].b );
    getglobal( 'CH_PopupBuffsButton'..i..'Background' ):Hide();
    getglobal( 'CH_PopupBuffsButton'..i ).ch_buff_idx = buffs[idx].buffIdx;
    getglobal( 'CH_PopupBuffsButton'..i ).ch_unit = unit;
    getglobal( 'CH_PopupBuffsButton'..i ):Show();
    i = i + 1;
    if ( i > CH_MAX_BUFFS ) then break; end;
  end

  frame = getglobal( 'CH_PopupBuffsButton'..i );
  while ( frame ) do
    frame:Hide();
    i = i + 1;
    frame = getglobal( 'CH_PopupBuffsButton'..i );
  end

  CH_PopupBuffs:ClearAllPoints();
  local mx,my = GetCursorPosition();
  CH_PopupBuffs:SetPoint( 'TOPLEFT', UIParent, 'BOTTOMLEFT', mx-20, my+buffsEnabled*10+10 );
  CH_PopupBuffs:SetHeight( 10 + 10*visibleButtons );
  CH_PopupBuffs:Show();

end

function CH_BuffUnit( unit, forceBuffIdx, forceBuffVersion )

  local buffIdx, effUnitIdx, buffName, hasBuff;
  local spellID = -1;
  local refreshUnit = nil;
  local refreshBuffIdx = nil;
  local refreshTimeRemain = nil;

  -- ---- bring popup to select buff
  if ( forceBuffIdx == 'POPUP' ) then
    CHL_BuffUnitPopup( unit );
    return( true );
  end

  -- ----- clickheal should select spell
  if ( forceBuffIdx == 'AUTOMATIC' ) then
    effUnitIdx = CH_UnitListIndex( unit, true );
    for _,buffIdx in CH_BuffPriority do
      if ( CH_BuffData[buffIdx].enabled ) then
        if ( effUnitIdx ) then					-- tracking effects
          refreshUnit,refreshBuffIdx,refreshTimeRemain = CHL_CompareRefreshBuff( unit, buffIdx, false, refreshUnit, refreshBuffIdx, refreshTimeRemain );
        elseif ( not refreshBuffIdx ) then			-- not tracking effects (e.g. "target" not in group/raid) (HACK!)
          hasBuff = false;
          for _,buffName in CH_BUFF_DATA[buffIdx].spellName do
            hasBuff = CH_UnitHasBuff(unit,buffName) or hasBuff;
          end
          if ( (not hasBuff) and CH_BUFF_DATA[buffIdx].partySpellName ) then
            hasBuff = CH_UnitHasBuff(unit,CH_BUFF_DATA[buffIdx].partySpellName) or hasBuff;
          end
          if ( not hasBuff and CH_IsValidBuffTarget(buffIdx,unit,false,false) ) then
            refreshBuffIdx = buffIdx;
            refreshUnit = unit;
          end
        end
      end
    end

    if ( refreshBuffIdx ) then
      return( CHL_TryCastBuff(refreshBuffIdx,refreshUnit,false,false) );
    end

    return( false );
  end

  -- ----- specific buff should be cast, party version
  if ( forceBuffVersion == 'PARTY' ) then
    if ( CH_BUFF_DATA[forceBuffIdx].partySpellName and CH_BuffData[forceBuffIdx].partySpellCastable ) then
      spellID = CH_GetSpellID( CH_BUFF_DATA[forceBuffIdx].partySpellName, nil, BOOKTYPE_SPELL, true );
      if ( spellID > -1 ) then
        CH_CastSpellOnFriend( spellID, nil, unit, 'SPELL' );
        return( true );
      end
    end
    return( CHL_TryCastBuff(forceBuffIdx,unit,false,true) );
  end

  -- ----- specific buff should be cast, single player version
  if ( forceBuffVersion == 'SINGLE' ) then
    CH_CastSpellOnFriend( CH_Spells[forceBuffIdx].spellName, nil, unit, 'SPELL' );
    return( true );
  end

  -- ----- specific buff should be cast, let ClickHeal decide on the version (single or party)
  return( CHL_TryCastBuff(forceBuffIdx,unit,false,true) );

end

-- ==========================================================================================================================
-- Spellcasting display (channel, casting time
-- ==========================================================================================================================

function CH_OnFiveSecRuleUpdate()

  local inFiveSecRule;
  local startTime = gCSStartTime or gCSPrevStartTime;

  if ( startTime and GetTime() - startTime < 5 ) then
    CH_FiveSecRuleBar:SetMinMaxValues( 0, 5000 );
    CH_FiveSecRuleBar:SetValue( 5000 - ceil((GetTime()-startTime)*1000) );
    CH_FiveSecRuleBar:SetStatusBarColor( CH_COLOR['GOLD'].r, CH_COLOR['GOLD'].g, CH_COLOR['GOLD'].b );
    inFiveSecRule = true;
  else
    CH_FiveSecRuleBar:SetMinMaxValues( 0, 5000 );
    CH_FiveSecRuleBar:SetValue( 5000 );
    CH_FiveSecRuleBar:SetStatusBarColor( CH_COLOR['GREEN'].r, CH_COLOR['GREEN'].g, CH_COLOR['GREEN'].b );
    inFiveSecRule = false;
  end

  if ( gUnitManaRegain == nil or UnitMana('player') == UnitManaMax('player') ) then
    CH_FiveSecRuleBarCenter:SetText( '-' );
  elseif ( gUnitManaRegain < 0 ) then
    CH_FiveSecRuleBarCenter:SetText( 0 );
  else
    CH_FiveSecRuleBarCenter:SetText( gUnitManaRegain );
  end

end

-- rank currently always nil!
-- unitName can be nil
function CH_NotifySpell( spellName, spellRank, unitName, condition )

  local msg, i, msgSpellName;

  if ( not (spellName and CH_Config.notifySpellCast[spellName]) ) then
    return;
  end

  if ( gCSPrevDuration and condition == 'STOP' ) then				-- spell just finished casting had a casting time. I already notified at spellcast start
    return;
  end

  if ( spellRank ) then
    msgSpellName = string.format( CH_SPELL_NAME_RANK_FORMAT, spellName, spellRank );
  else
    msgSpellName = spellName;
  end

  if ( unitName ) then
    msg = string.format( CHT_NOTIFY_SPELL_CAST, msgSpellName, unitName );
  else
    msg = string.format( CHT_NOTIFY_SPELL_CAST_NO_TARGET, msgSpellName );
  end

  if ( CH_Config.notifySpellCast[spellName].say ) then
    SendChatMessage( msg, "SAY" );
  end

  if ( CH_Config.notifySpellCast[spellName].target and unitName and unitName ~= UnitName('player') ) then
    SendChatMessage( string.format(CHT_NOTIFY_SPELL_CAST_TARGET,msgSpellName), "WHISPER", nil, unitName );
  end

  if ( CH_Config.notifySpellCast[spellName].raid and GetNumRaidMembers() > 0 ) then
    SendChatMessage( msg, "RAID" );
  elseif ( CH_Config.notifySpellCast[spellName].party and GetNumPartyMembers() > 0 ) then
    SendChatMessage( msg, "PARTY" );
  end

  if ( CH_Config.notifySpellCast[spellName].customChannel ) then
    CH_SendChannelMessage( msg, CH_Config.notifyCustomChannelName );
  end

end

function CH_OnSpellCastUpdate()

  if ( gCSName and gCSIsChanneling ) then
    local disruptionTime = gCSDisruptionTime / 1000;
    local duration = gCSDuration / 1000;
    local elapsed = (GetTime() - gCSStartTime) + disruptionTime;
    local remainingTime = duration-elapsed;

    if ( remainingTime < 0 ) then
      CH_CastBar:SetValue( 0 );
      remainingTime = 0;
    else
      CH_CastBar:SetValue( remainingTime * 100 / duration );
    end

    CH_CastBarCastTime:SetText( string.format("%3.1f",remainingTime) );
    if ( disruptionTime > 0 ) then
      CH_CastBarRight:SetText( string.format("%3.1f",disruptionTime) );
    else
      CH_CastBarRight:SetText( '' );
    end
    CH_CastBar:SetStatusBarColor( 0, 1, 0 );
    CH_CastBar:Show();
  elseif ( gCSName ) then
    local overhealIdx = nil;
    local disruptionTime = gCSDisruptionTime / 1000;
    local duration = gCSDuration / 1000;
    local elapsed = (GetTime() - gCSStartTime) - disruptionTime;

    if ( elapsed > duration ) then
      CH_CastBar:SetValue( 100 );
    else
      CH_CastBar:SetValue( elapsed * 100 / duration );
    end

    local remainingTime = duration - elapsed;
    if ( remainingTime < 0 ) then
      remainingTime = 0;
    end
    CH_CastBarCastTime:SetText( string.format("%3.1f",remainingTime) );
    if ( disruptionTime > 0 ) then
      CH_CastBarRight:SetText( string.format("%3.1f",disruptionTime) );
    else
      CH_CastBarRight:SetText( '' );
    end
    CH_CastBar:SetStatusBarColor( 1, 1, 0 );
    CH_CastBar:Show();
  elseif ( CH_Spells.COOLDOWN and CH_Spells.COOLDOWN.spellBookIdx ) then
    local start,duration,enable = GetSpellCooldown( CH_Spells.COOLDOWN.spellBookIdx, BOOKTYPE_SPELL );
    if ( start > 0 and duration > 0 ) then
      local remainTime = duration - (GetTime() - start);
      if ( remainTime < 0 ) then
        remainTime = 0;
        remainPerc = 0;
      else
        remainPerc = remainTime * 100 / duration;
      end
      CH_CastBar:SetValue( remainPerc );
      CH_CastBarCastTime:SetText( string.format("%3.1f",remainTime) );
      CH_CastBarRight:SetText( '' );
      CH_CastBar:SetStatusBarColor( 1, 0.5, 0 );
      CH_CastBar:Show();
    else
      CH_CastBar:Hide();
    end
  else
    CH_CastBar:Hide();
  end

end

-- ========== MASKED FUNCTIONS ==============================================================================================================

function CH_PlaySoundMasked( sound )

  if ( gSilentTarget ) then
    if ( sound == 'INTERFACESOUND_LOSTTARGETUNIT' or sound == 'igCharacterNPCSelect' ) then
      gSilentTarget = false;
    else 
      gOriginalFunction['PlaySound']( sound );
    end
  else
    gOriginalFunction['PlaySound']( sound );
  end

end

function CH_TargetUnitMasked( unit )

  gOriginalFunction['TargetUnit']( unit );

  if ( gCSNextName and (not gCSNextTargetUnit) ) then
    gCSNextTargetUnit = CH_NormalizeUnit( unit );

    if ( gCSNextTargetUnit ) then
      gCSNextTargetName = UnitName( gCSNextTargetUnit );
    end
  end

end

-- ========== SPELL MASKINGS and OWN SPELL FUNCTIONS ========================================================================================

-- called before every: CastSpell(), CastSpellByName(), UseAction()
-- spellName: name of spell [incl rank], e.g. 'Taunt' or 'Fireball(Rank 11)'
-- spellID/booktype: spellID and booktype of spell
-- the slot number of the action bar.
function CH_CastSpellPrecheck( spellName, spellID, booktype, actionSlot )

  if ( spellID ) then
    spellName = CH_GetSpellName( spellID, booktype );
  end

  -- taunt
  if ( CH_Config.safeTaunt and CH_UnitClass('player') == 'WARRIOR' and UnitExists('target') and UnitIsUnit('player','targettarget') ) then
    if ( (actionSlot and CH_ActionBar[CH_SPELL_TAUNT] and CH_ActionBar[CH_SPELL_TAUNT].slot == actionSlot) or
	 (spellName and strsub(spellName,1,strlen(CH_SPELL_TAUNT)) == CH_SPELL_TAUNT) )
    then  
      CH_Msg( string.format(CHT_SAFE_TAUNT_FORMAT,CH_UnitName('target')) );
      return( false );
     end
  end

  return( true );

end

function CH_CastSpellByNameData( spellName, spellRank, targetUnit )

  gCSNextName = spellName;
  gCSNextRank = tonumber(spellRank);

  if ( targetUnit ) then
    gCSNextTargetUnit = CH_NormalizeUnit( targetUnit );
  elseif ( not SpellIsTargeting() and UnitExists('target') ) then
    gCSNextTargetUnit = CH_NormalizeUnit('target');
  else
    gCSNextTargetUnit = nil;
  end

  if ( gCSNextTargetUnit ) then
    gCSNextTargetName = UnitName( gCSNextTargetUnit );
  end

end

function CH_CastSpellData( spellID, booktype, targetUnit )

  local spellName, spellRank;

  if ( booktype ~= BOOKTYPE_SPELL ) then		-- not interested in pet casts
    return;
  end

  spellName,spellRank = CH_GetSpellName( spellID, BOOKTYPE_SPELL );

  CH_CastSpellByNameData( spellName, spellRank, targetUnit );

end

function CH_CastSpellByActionData( actionSlot )

  local spellName;

  if ( GetActionText(actionSlot) ) then 			-- macro?
    return;
  end
  
  CH_TooltipSetAction( actionSlot );
  spellName = CH_TooltipGetTitle();

  if ( not (spellName and CH_SpellMap[strlower(spellName)]) ) then		-- spell ?
    return;
  end

  CH_CastSpellByNameData( spellName, nil, nil );

end

function CH_SpellTargetUnitData( unit )

  if ( gCSNextTargetUnit and gCSNextTargetUnit ~= unit ) then
    CH_Debug( 'CH_SpellTargetUnit() unit differs! '..gCSNextTargetUnit..' vs '..unit, CH_DEBUG_DEBUG );
  else
    gCSNextTargetUnit = CH_NormalizeUnit( unit );
  end

  if ( gCSNextTargetUnit ) then
    gCSNextTargetName = UnitName( gCSNextTargetUnit );
  end

end

function CH_SpellStopTargetingData()

  gCSNextName = nil;
  gCSNextRank = nil;
  gCSNextTargetUnit = nil;
  gCSNextTargetName = nil;

end

function CH_CastSpellByNameMasked( spellName, onSelf )

  local name, rank, unit;

  if ( not CH_CastSpellPrecheck(spellName,nil,nil,nil) ) then
    return;
  end

  if ( onSelf ) then
    unit = 'player';
  else
    unit = nil;
  end

  CH_HealRangeAbortScan();

  _,_,name,rank = strfind( spellName, CH_SPELL_NAME_RANK_REGEXP );
  if ( name ) then
    CH_CastSpellByNameData( name, rank, unit );
  else
    CH_CastSpellByNameData( spellName, nil, unit );
  end

  gOriginalFunction['CastSpellByName']( spellName, onSelf );

end

function CH_CastSpellByName( spellName, spellRank, targetUnit, onSelf )

  if ( not CH_CastSpellPrecheck(spellName,nil,nil,nil) ) then
    return;
  end

  CH_CastSpellByNameData( spellName, spellRank, targetUnit );

  if ( spellRank ) then
    gOriginalFunction['CastSpellByName']( string.format(CH_SPELL_NAME_RANK_FORMAT,spellName,spellRank), onSelf );
  else
    gOriginalFunction['CastSpellByName']( spellName, onSelf );
  end

end

function CH_CastSpellMasked( spellID, booktype )

  if ( not CH_CastSpellPrecheck(nil,spellID,booktype,nil) ) then
    return;
  end

  CH_HealRangeAbortScan();

  CH_CastSpellData( spellID, booktype, nil );
  gOriginalFunction['CastSpell']( spellID, booktype );

end

-- silently: do not collect data, useful for range checking
function CH_CastSpell( spellID, booktype, targetUnit, silently )

  if ( silently ) then
    gOriginalFunction['CastSpell']( spellID, booktype );
  else
    if ( not CH_CastSpellPrecheck(nil,spellID,booktype,nil) ) then
      return;
    end
  
    CH_CastSpellData( spellID, booktype, targetUnit );
    gOriginalFunction['CastSpell']( spellID, booktype );
  end

end

function CH_SpellTargetUnitMasked( unit )

  gOriginalFunction['SpellTargetUnit']( unit );
  CH_SpellTargetUnitData( unit );

end

function CH_SpellTargetUnit( unit )

  gOriginalFunction['SpellTargetUnit']( unit );
  CH_SpellTargetUnitData( unit );

end

function CH_SpellStopTargetingMasked()

  gOriginalFunction['SpellStopTargeting']( );
  CH_SpellStopTargetingData();

end

function CH_SpellStopTargeting( silently )

  gOriginalFunction['SpellStopTargeting']( );
  if ( not silently ) then
    CH_SpellStopTargetingData();
  end

end

-- ========== SPELL EVENTS ================================================================================================================

function CHL_FinishedCasting( endState )

  -- NOTE: It can happen that SPELLCAST_STOP is called __BEFORE__ SPELLCAST_START !!!! when you very quickly interrupt a spell

  gCSIsCasting = nil;

  if ( endState == 'INTERRUPTED' and gCSPrevEndState and gCSPrevEndState == 'STOP' and gCSPrevEndTime > GetTime()-0.5 ) then
    gCSPrevEndState = endState;
    return;
  end

  if ( gCSName ) then
    gCSPrevName = gCSName;
    gCSPrevRank = gCSRank;
    gCSPrevTargetUnit = gCSTargetUnit;
    gCSPrevTargetName = gCSTargetName;
    gCSPrevStartTime = gCSStartTime;
    gCSPrevDuration = gCSDuration;
  elseif ( gCSNextName ) then
    gCSPrevName = gCSNextName;
    gCSPrevRank = gCSPrevRank;
    gCSPrevTargetUnit = gCSNextTargetUnit;
    gCSPrevTargetName = gCSNextTargetName;
    gCSPrevStartTime = GetTime();
    gCSPrevDuration = nil;
  else
    gCSPrevName = nil;
    gCSPrevRank = nil;
    gCSPrevTargetUnit = nil;
    gCSPrevTargetName = nil;
    gCSPrevStartTime = nil;
    gCSPrevDuration = nil;
  end
  gCSPrevEndState = endState;
  gCSPrevEndTime = GetTime();

  gCSName = nil;
  gCSRank = nil;
  gCSStartTime = nil;
  gCSDuration = nil;
  gCSDisruptionTime = nil;
  gCSIsChanneling = nil;
  gCSTargetUnit = nil;
  gCSTargetName = nil;
  gCSNextName = nil;
  gCSNextRank = nil;
  gCSNextTargetUnit = nil;
  gCSNextTargetName = nil;

  if ( endState == 'STOP' ) then
    CH_NotifySpell( gCSPrevName, gCSPrevRank, gCSPrevTargetName, 'STOP' )
  end

end

function CH_SpellcastStart( spellName, duration )

  -- NOTE: It can happen that SPELLCAST_STOP is called __BEFORE__ SPELLCAST_START !!!! when you very quickly interrupt a spell

  gCSName = spellName;
  gCSStartTime = GetTime();
  gCSDuration = duration;
  gCSDisruptionTime = 0;
  gCSIsChanneling = false;
  gCSIsCasting = true;

  if ( spellName == gCSNextName ) then
    gCSRank = gCSNextRank;
    gCSTargetUnit = gCSNextTargetUnit;
    gCSTargetName = gCSNextTargetName;
  else
    gCSRank = nil;
    gCSTargetUnit = nil;
    gCSTargetName = nil;
  end

  gCSNextName = nil;
  gCSNextRank = nil;
  gCSNextTargetUnit = nil;
  gCSNextTargetName = nil;

  CH_NotifySpell( gCSName, gCSRank, gCSTargetName, 'START' )

end

function CH_SpellcastDelayed( disruptionTime )

  if ( gCSName ) then
    gCSDisruptionTime = gCSDisruptionTime + disruptionTime;
  end

end

function CH_SpellcastStop( event )

--  local stopTime = GetTime();

  if ( not gCSIsChanneling ) then
    if ( event == 'SPELLCAST_INTERRUPTED' ) then
      CHL_FinishedCasting( 'INTERRUPTED' );
    elseif ( event == 'SPELLCAST_FAILED' ) then
      CHL_FinishedCasting( 'FAILED' );
    elseif ( event == 'SPELLCAST_STOP' ) then
      CHL_FinishedCasting( 'STOP' );
    end
  end

  if ( event == 'SPELLCAST_STOP' ) then
    if ( CH_MESMERIZE_INFO[gCSPrevName] and gCSPrevTargetName ) then
      CH_MesmerizeUpdateUnit( gCSPrevName, gCSPrevRank, gCSPrevTargetName )
    end
  end

  if ( event == 'SPELLCAST_FAILED' and gCSPrevName and gCSPrevTargetName ) then
    CHL_AddUnitToBlacklist( gCSPrevTargetUnit, gCSPrevTargetName, gCSPrevName, gCSPrevRank );
  end

--  CH_Msg( 'SpellcastStop duration: '..(GetTime()-stopTime)..' seconds' );

end

function CH_SpellcastChannelStart( duration, spellName )

  if ( gCSNextName ) then
    gCSName = gCSNextName;					-- potentially dangerous, as i might try to cast a different spell (very fast clicking)
  else
    gCSName = spellName;					-- spellName is always "Channel"
  end

  gCSStartTime = GetTime();
  gCSDuration = duration;
  gCSDisruptionTime = 0;
  gCSIsChanneling = true;
  gCSIsCasting = true;

  if ( spellName == gCSNextName ) then
    gCSRank = gCSNextRank;
    gCSTargetUnit = gCSNextTargetUnit;
    gCSTargetName = gCSNextTargetName;
  else
    gCSRank = nil;
    gCSTargetUnit = nil;
    gCSTargetName = nil;
  end

  gCSNextName = nil;
  gCSNextRank = nil;
  gCSNextTargetUnit = nil;
  gCSNextTargetName = nil;

  CH_NotifySpell( gCSName, gCSRank, gCSTargetUnitName, 'START' )

end

function CH_SpellcastChannelUpdate( remainingDuration )

  local elapsed = GetTime() - gCSStartTime;
  gCSDisruptionTime = (gCSDuration - elapsed*1000) - remainingDuration;

end

function CH_SpellcastChannelStop( )

  CHL_FinishedCasting( 'CHANNEL' );

end

-- ========== SPELL RANK ADAPTION FOR LOW LEVELS ==========================================================================================

local function CHL_LevelMayReceiveSpell( unitLevel, spellName, spellRank )

  if ( CH_SPELL_INFO[spellName] ) then
    if ( CH_SPELL_INFO[spellName].ranks[spellRank] ) then
      if ( unitLevel < CH_SPELL_INFO[spellName].ranks[spellRank]-10 ) then
        return( false );
      end
    end
  end

  return( true );

end

function CH_AdjustSpellRank( unit, spellName, spellRank )

  local mySpellName, mySpellRank;
  local unitLevel = UnitLevel(unit);

  if ( not CH_Config.adjustSpellRank or unit == nil or unitLevel == nil or unit == 'player' or unitLevel >= UnitLevel('player')-10 or 
       UnitCanAttack('player',unit) or unitLevel < 1 ) 
  then
    return spellName, spellRank;
  end

  if ( type(spellName) == 'number' ) then
    mySpellName,mySpellRank = CH_GetSpellName( spellName, BOOKTYPE_SPELL );
  else
    mySpellName = spellName;
    mySpellRank = spellRank;
  end

  if ( CH_SPELL_INFO[mySpellName] and CH_SPELL_INFO[mySpellName].checkRank and CH_SPELL_INFO[mySpellName].ranks) then
    if ( not mySpellRank ) then
      mySpellRank = table.getn( CH_SPELL_INFO[spellName].ranks );
    end
    while ( mySpellRank > 0 and not (CH_SpellMap[strlower(mySpellName)][mySpellRank] and CHL_LevelMayReceiveSpell(unitLevel,mySpellName,mySpellRank)) ) do
      mySpellRank = mySpellRank - 1;
    end

    if ( mySpellRank > 0 ) then
      CH_Dbg( 'Adjusted to: '..mySpellName..' '..mySpellRank..', original rank '..(spellRank or 'NIL'), CH_DEBUG_INFO );
      return mySpellName, mySpellRank;
    end
      
  end

  return spellName, spellRank;

end


-- ==========================================================================================================================
-- Healing calculations
-- ==========================================================================================================================

local function CHL_CastSpellAtFullHealth( spell )

  if ( (not CH_SPELL_INFO[spell]) or CH_SPELL_INFO[spell].atFullHealth ) then
    return( true );
  end

  return( false );

end

function CHL_SpellManaZeroOrUnknown( spellID )

  local isFree = false;

  if ( CH_UnitClass('player') == 'PRIEST' ) then
    isFree = CH_UnitHasBuff( 'player', CH_BUFF_SPIRIT_OF_REDEMPTION, CH_SPELL_INNER_FOCUS )
  elseif ( CH_UnitClass('player') == 'DRUID' ) then
    isFree = CH_UnitHasBuff( 'player', CH_SPELL_OMEN_OF_CLARITY )
  else
    return( false );
  end

  if ( not isFree ) then
    CH_TooltipSetSpell( spellID, BOOKTYPE_SPELL );
    if ( CH_TooltipGetManaCost() == nil ) then
      isFree = true;
    end
  end

  return( isFree );

end

local function CHL_DowngradeSpellLom( overhealIdx, keepSpell )

  local playerMana = UnitMana( 'player' );
  local maxDownscales = CH_Config.overheal[overhealIdx].lomDowngradeRanks;
  local i = table.getn( CH_Overheal[overhealIdx] );
  local manaTxt;

  -- no downgrade wanted or required
  if ( maxDownscales < 1 or CH_Overheal[overhealIdx][i].manaCost <= playerMana ) then
    return CH_Overheal[overhealIdx][i].spellID, i;
  end

  -- check if 'clearcasting' or 'spirit of redemption' or whatever else that i need no mana
  if ( CHL_SpellManaZeroOrUnknown(CH_Overheal[overhealIdx][i].spellID) ) then
    CH_Dbg( 'Clearcast or Spirit of Redemption or Omen of Clarity', CH_DEBUG_DEBUG );
    return CH_Overheal[overhealIdx][i].spellID, i;						-- no mana information, return highest rank
  end

  -- downgrade, begin with second best (best already checked above)
  i = i - 1;
  while ( i >= 1 and CH_Overheal[overhealIdx][i].manaCost > playerMana and maxDownscales > 0 and 
         (keepSpell == nil or keepSpell == CH_Overheal[overhealIdx][i].spellName) )
  do
    i = i - 1;
    maxDownscales = maxDownscales - 1;
  end

  if ( i > 0 ) then
    return CH_Overheal[overhealIdx][i].spellID, i;
  else
    return nil, nil;
  end

end

local function CHL_DowngradeSpellHealPotential( overhealIdx, i, baseOnPerc, hotPerc, modifyTotalPerc, calcCastTime )

  local hotPotential, wis;
  local healPotential = CH_Overheal[overhealIdx][i].minHeal;

  healPotential = healPotential + CH_Overheal[overhealIdx][i].healWindow * baseOnPerc / 100;

  if ( CH_Config.includeEquipHealBonus and calcCastTime and BonusScanner ) then
    healPotential = healPotential + BonusScanner:GetBonus('HEAL') * calcCastTime / 3.5;
  end

  if ( CH_SpiritualGuidance > 0 and calcCastTime ) then
    _,wis = UnitStat( 'player', 5 );
    healPotential = healPotential + wis*(CH_SpiritualGuidance*5)/100 * calcCastTime / 3.5;
  end

  if ( hotPerc > 0 and CH_Overheal[overhealIdx][i].hotMaxHeal > 0 ) then
    hotPotential = CH_Overheal[overhealIdx][i].hotMinHeal;
    hotPotential = hotPotential + CH_Overheal[overhealIdx][i].hotWindow * baseOnPerc / 100;
    hotPotential = hotPotential * hotPerc / 100;

    healPotential = healPotential + hotPotential;
  end

  healPotential = healPotential * modifyTotalPerc / 100;

  return( floor(healPotential) );

end

local function CHL_DowngradeSpell( neediest, overhealIdx, withDPS, keepSpell, overhealSpellIdx )

  local missingHealth, i, baseOnPerc, hotPerc, modifyTotalPerc, preferedSpell, healPot, overhealAllowance;

  missingHealth = UnitHealthMax(neediest) - UnitHealth(neediest);

  -- not missing any health, return
  if ( missingHealth <= 0 ) then
    preferedSpell = nil;
  -- not in party or raid, only get % health
  elseif ( not (CH_UnitIsAvatarOrPet(neediest) or CH_UnitInPartyOrRaid(neediest)) ) then
    if ( keepSpell ) then
      preferedSpell = keepSpell;
    else
      i = table.getn( CH_Overheal[overhealIdx] );
      preferedSpell = CH_Overheal[overhealIdx][i].spellID;
    end
  -- other wise we get absolute numbers
  else
    if ( overhealIdx == 'HEALUP' ) then
      baseOnPerc = 50 + UnitLevel('player')/2;
      if ( baseOnPerc > 100 ) then baseOnPerc = 100; end;
      hotPerc = 25;
      modifyTotalPerc = 100;
      overhealAllowance = 75;
      withDPS = false;
    else
      baseOnPerc = CH_Config.overheal[overhealIdx].baseOnPerc;
      hotPerc = CH_Config.overheal[overhealIdx].hotPerc;
      modifyTotalPerc = CH_Config.overheal[overhealIdx].modifyTotalPerc;
      overhealAllowance = CH_Config.overheal[overhealIdx].overhealAllowance;
    end

    if ( withDPS and gDPSCurr[neediest] and gDPSCurr[neediest] > 0 and CH_Config.overheal[overhealIdx].dpsCheck > 0 and 
         gDPSRecent[neediest] >= floor(GetTime()+0.5)-CH_Config.overheal[overhealIdx].dpsCheck )
    then
      missingHealth = missingHealth + gDPSCurr[neediest]*2;
    end

    if ( overhealSpellIdx ) then							-- if spell index (position in array) passed
      i = overhealSpellIdx-1;									-- then use this position as the start (MINUS 1 to check weaker; i+1 below)
    else
      i = table.getn( CH_Overheal[overhealIdx] ) - 1;						-- else start with the second best
    end

    while ( i >= 1 and 									-- loop to find spell
           CHL_DowngradeSpellHealPotential(overhealIdx,i,baseOnPerc,hotPerc,modifyTotalPerc,CH_Overheal[overhealIdx][i].calcCastTime) > missingHealth and
           (keepSpell == nil or keepSpell == CH_Overheal[overhealIdx][i].spellName) ) 
    do
      i = i - 1;
    end

    healPot = CHL_DowngradeSpellHealPotential( overhealIdx, i+1, baseOnPerc, hotPerc, modifyTotalPerc, CH_Overheal[overhealIdx][i+1].calcCastTime );	-- check heal potential
    if ( healPot <= missingHealth or (healPot-missingHealth) * 100 / healPot <= overhealAllowance ) then
      i = i + 1;
    end

    if ( i > 0 ) then
      preferedSpell = CH_Overheal[overhealIdx][i].spellID;
    else
      preferedSpell = nil;
    end

    if ( i < 1 ) then
      CH_Dbg( 'Lowest spell still to high, missing health: '..missingHealth );
    elseif ( i < table.getn(CH_Overheal[overhealIdx]) ) then
      CH_Dbg( 'Downgraded spell to '..CH_Overheal[overhealIdx][i].spellName.."("..CH_Overheal[overhealIdx][i].spellRank..
              ") [calcHeal="..CHL_DowngradeSpellHealPotential(overhealIdx,i,baseOnPerc,hotPerc,modifyTotalPerc,CH_Overheal[overhealIdx][i].calcCastTime)..
              ", missingHP="..missingHealth..", overhealAllowance="..overhealAllowance..']' );
      CH_Dbg( "minHeal="..CH_Overheal[overhealIdx][i].minHeal..", maxHeal="..CH_Overheal[overhealIdx][i].maxHeal..
           ", hotMinHeal="..CH_Overheal[overhealIdx][i].hotMinHeal..", hotMaxHeal="..CH_Overheal[overhealIdx][i].hotMaxHeal );
      if ( BonusScanner or CH_SpiritualGuidance ) then
	local msg = "calcCastTime="..(CH_Overheal[overhealIdx][i].calcCastTime or 'NIL');
        if ( CH_Config.includeEquipHealBonus and BonusScanner ) then
          msg = msg ..', ItemBonus='..BonusScanner:GetBonus('HEAL');
        end
        if ( CH_SpiritualGuidance ) then
          msg = msg ..', SpiritualGuidance=rank '..CH_SpiritualGuidance;
        end
        CH_Dbg( msg );
      end
    end
  end

  return( preferedSpell );

end

-- returns spellName or spellID !!
local function CHL_FinetuneHealSpell( neediest, preferedSpell, actionType )

  local neediestInCombat = UnitAffectingCombat( neediest );
  local overhealIdx = nil;
  local keepSpell = nil;
  local overhealSpellIdx = nil;

  -- ----- shields
  if ( preferedSpell == CH_SPELL_POWER_WORD_SHIELD and CH_Config.finetunePwS ) then	-- Power Word: Shield
    if ( CH_IsEffectedBy(neediest,CH_EFFECT_POWER_WORD_SHIELD,true) or CH_IsEffectedBy(neediest,CH_EFFECT_WEAKENED_SOUL,false) ) then	-- already shielded or weakened
      preferedSpell = CH_SPELL_RENEW;
    end
  end

  -- ----- Swiftmend (do BEFORE rejuv and regrowth finetune)
  if ( preferedSpell == CH_SPELL_SWIFTMEND and CH_Config.finetuneSwiftmend ) then
    if ( GetSpellCooldown(CH_GetSpellID(CH_SPELL_SWIFTMEND,nil,BOOKTYPE_SPELL,false), BOOKTYPE_SPELL) > 0 or
         not (CH_IsEffectedBy(neediest,CH_EFFECT_REJUVENATION,false) or CH_IsEffectedBy(neediest,CH_EFFECT_REGROWTH,false)) )
    then
      if ( floor(CH_CalcPercentage(UnitHealth(neediest),UnitHealthMax(neediest))) >= 70 ) then				-- if unit above 70% health
        preferedSpell = CH_SPELL_REJUVENATION;											-- take rejuvenation
      else
        preferedSpell = CH_SPELL_REGROWTH;											-- otherwise regrowth
      end
    end
  end

  -- ----- HOTs
  if ( preferedSpell == CH_SPELL_RENEW and CH_Config.finetuneRenew ) then		-- Renew
    if ( CH_IsEffectedBy(neediest,CH_EFFECT_RENEW,true) ) then
      preferedSpell = CH_SPELL_FLASH_HEAL;
    end
  end

  if ( preferedSpell == CH_SPELL_REJUVENATION and CH_Config.finetuneRejuvenation ) then	-- Rejuvenation
    if ( CH_IsEffectedBy(neediest,CH_EFFECT_REJUVENATION,true) ) then
      if ( CH_IsEffectedBy(neediest,CH_EFFECT_REGROWTH,true) ) then
        preferedSpell = CH_SPELL_HEALING_TOUCH;
      else
        preferedSpell = CH_SPELL_REGROWTH;
      end
    end
  elseif ( preferedSpell == CH_SPELL_REGROWTH and CH_Config.finetuneRegrowth ) then	-- Regrowth
    if ( CH_IsEffectedBy(neediest,CH_EFFECT_REGROWTH,true) ) then
      if ( CH_IsEffectedBy(neediest,CH_EFFECT_REJUVENATION,true) ) then
        preferedSpell = CH_SPELL_REGROWTH;							-- then still cast Regrowth!
      else
        preferedSpell = CH_SPELL_REJUVENATION;
      end
    end
  end

  -- ----- in combat
  if ( neediestInCombat ) then
    if ( CH_InTable(CH_SPELL_DATA.SLOW,preferedSpell) ) then										-- SLOW
      if ( CH_Config.overheal.SLOW ) then
        overhealIdx = 'SLOW';
        keepSpell = nil;
      end
    elseif ( CH_InTable(CH_SPELL_DATA.QUICK,preferedSpell) ) then									-- QUICK
      if ( CH_Config.overheal.QUICK ) then
        overhealIdx = 'QUICK';
        keepSpell = preferedSpell;
      end
    else																-- do not know how to overheal
      overhealIdx = nil;
    end

    if ( overhealIdx ) then
      if ( floor(CH_CalcPercentage(UnitHealth(neediest),UnitHealthMax(neediest))) > CH_Config.overheal[overhealIdx].startBelow ) then
        preferedSpell = nil;
      else
        preferedSpell,overhealSpellIdx = CHL_DowngradeSpellLom( overhealIdx, keepSpell );
        if ( preferedSpell and CH_Config.overheal[overhealIdx].combatDowngrade ) then				-- CHL_DowngradeSpellLom may return nil (out of mana)
          preferedSpell = CHL_DowngradeSpell( neediest, overhealIdx, true, keepSpell, overhealSpellIdx );
        end
      end
    end
  -- ----- out of combat
  else
    if ( actionType == 'HEALUP' and CH_InTable(CH_SPELL_DATA.HEALUP,preferedSpell) ) then						-- HEALUP
      overhealIdx = 'HEALUP';
    elseif ( CH_InTable(CH_SPELL_DATA.SLOW,preferedSpell) ) then									-- SLOW
      if ( CH_Config.overheal.SLOW ) then
        overhealIdx = 'SLOW';
      end
    elseif ( CH_InTable(CH_SPELL_DATA.QUICK,preferedSpell) ) then									-- QUICK
      if ( CH_Config.overheal.QUICK ) then
        overhealIdx = 'QUICK';
        keepSpell = preferedSpell;
      end
    else																-- do not know how to overheal
      overhealIdx = nil;
    end

    if ( overhealIdx and (overhealIdx == 'HEALUP' or CH_Config.overheal[overhealIdx].downgrade) ) then
      preferedSpell = CHL_DowngradeSpell( neediest, overhealIdx, false, keepSpell, nil );
    end
  end

  return( preferedSpell );

end

local function CHL_SelectHealSpellNoCombat( neediest )

  if ( CH_Spells.HEALUP ) then
    return( CHL_FinetuneHealSpell(neediest,CH_Spells.HEALUP.spellName,'HEALUP') );
  end

  return( nil );

end

local function CHL_GetSpellFromList( behavior, emergency, class, idx, unit )

if ( not CH_EmergencySpells ) then
CH_Dbg( 'CHL_GetSpellFromList: CH_EmergencySpells is nil', CH_DEBUG_ERR );
CH_Dbg( (behavior or 'NULL') .. ' / ' .. (emergency or 'NULL') .. ' / ' .. (class or 'NULL') .. ' / ' .. (idx or 'NULL') .. ' / ' .. (unit or 'NULL') );
elseif ( not CH_EmergencySpells[behavior] ) then
CH_Dbg( 'CHL_GetSpellFromList: CH_EmergencySpells[behavior] is nil', CH_DEBUG_ERR );
CH_Dbg( (behavior or 'NULL') .. ' / ' .. (emergency or 'NULL') .. ' / ' .. (class or 'NULL') .. ' / ' .. (idx or 'NULL') .. ' / ' .. (unit or 'NULL') );
elseif ( not CH_EmergencySpells[behavior][emergency] ) then
CH_Dbg( 'CHL_GetSpellFromList: CH_EmergencySpells[behavior][emergency] is nil', CH_DEBUG_ERR );
CH_Dbg( (behavior or 'NULL') .. ' / ' .. (emergency or 'NULL') .. ' / ' .. (class or 'NULL') .. ' / ' .. (idx or 'NULL') .. ' / ' .. (unit or 'NULL') );
elseif ( not CH_EmergencySpells[behavior][emergency][class] ) then
CH_Dbg( 'CHL_GetSpellFromList: CH_EmergencySpells[behavior][emergency][class] is nil', CH_DEBUG_ERR );
CH_Dbg( (behavior or 'NULL') .. ' / ' .. (emergency or 'NULL') .. ' / ' .. (class or 'NULL') .. ' / ' .. (idx or 'NULL') .. ' / ' .. (unit or 'NULL') );
end

  local spellName = nil;
  local forceSpell = false;
  local spellType = CH_EmergencySpells[behavior][emergency][class][idx];

  if ( spellType == nil ) then
    return nil, nil;
  end

  if ( strsub(spellType,1,1) == '!' ) then						-- force this spell
    forceSpell = true;
    spellType = strsub( spellType, 2 );
  end

  if ( GetSpellCooldown(CH_Spells[spellType].spellBookIdx,BOOKTYPE_SPELL) > 0 ) then		-- cooldown
    return CHL_GetSpellFromList( behavior, emergency, class, idx+1, unit );
  end 

  if ( forceSpell ) then								-- forced
    return CH_Spells[spellType].spellName, spellTyp;
  end

  spellName = CH_Spells[spellType].spellName;

  if ( spellName == CH_SPELL_POWER_WORD_SHIELD and 
      (CH_IsEffectedBy(unit,CH_EFFECT_POWER_WORD_SHIELD,true) or CH_IsEffectedBy(unit,CH_EFFECT_WEAKENED_SOUL,false) or 
       (not (CH_UnitIsAvatarOrPet(unit) or CH_UnitInPartyOrRaid(unit))) or CH_UnitHasBuff('player',CH_BUFF_SPIRIT_OF_REDEMPTION)
      ) 
     )
  then
    return CHL_GetSpellFromList( behavior, emergency, class, idx+1, unit );
  end

  if ( spellName == CH_SPELL_RENEW and CH_IsEffectedBy(unit,CH_EFFECT_RENEW,true) ) then
    return CHL_GetSpellFromList( behavior, emergency, class, idx+1, unit );
  end

  if ( spellName == CH_SPELL_REJUVENATION and CH_IsEffectedBy(unit,CH_EFFECT_REJUVENATION,true) ) then
    return CHL_GetSpellFromList( behavior, emergency, class, idx+1, unit );
  end

  if ( spellName == CH_SPELL_REGROWTH and CH_IsEffectedBy(unit,CH_EFFECT_REGROWTH,true) ) then
    return CHL_GetSpellFromList( behavior, emergency, class, idx+1, unit );
  end

  if ( spellName == CH_SPELL_SWIFTMEND and not (CH_IsEffectedBy(unit,CH_EFFECT_REJUVENATION,false) or CH_IsEffectedBy(unit,CH_EFFECT_REGROWTH,false)) ) then
    return CHL_GetSpellFromList( behavior, emergency, class, idx+1, unit );
  end

  return spellName, spellType;

end

local function CHL_SelectHealSpell( neediest, emergency )

  local spellName = nil;
  local spellType = nil;
  local class = nil;
  local healData = nil;
  local behavior = nil;

  if ( UnitIsPlayer(neediest) ) then
    class = CH_UnitClass( neediest );
  else
    class = 'PET';
  end

  if ( CH_EmergencySpells ) then
    if ( CH_PlayerIsInBattlefield() ) then
      behavior = CH_Config.panicBehaviorInBattlefield;
    else
      behavior = CH_Config.panicBehavior;
    end
    spellName,spellType = CHL_GetSpellFromList(behavior,emergency,class,1,neediest); 
    if ( CH_Config.panicSpellDowngrade and (spellType == 'SLOW' or spellType == 'QUICK') ) then
      if ( spellType == 'SLOW' ) then
        spellName = nil;
       end
       spellName = CHL_DowngradeSpell( neediest, spellType, true, spellName, nil );
    end
  end

  return( spellName );

end

-- unitInCombat: Y/N, as by CH_UnitAffectingCombat( unit ) 
function CH_EmergencyLevel( unit, unitInCombat )

  local el, elb;
  local unitPercent = -1;
  local class = CH_UnitClass( unit );
  local healthPerc = floor(CH_CalcPercentage(UnitHealth(unit),UnitHealthMax(unit)));

  -- player or pet?
  if ( not UnitIsPlayer(unit) ) then
    class = 'PET';
  -- class unknown (should not happen, but CAN happen)
  elseif ( class == 'UNKNOWN' ) then
    CH_Dbg( 'CH_EmergencyLevel(), class is UNKNOWN for unit '..unit, CH_DEBUG_ERR );
    return CH_EMERGENCY_NONE,100;
  end

  -- get the values
  el = CH_EMERGENCY_CRITIC;
  while ( el >= CH_EMERGENCY_NONE and unitPercent < 0 ) do 
    elb = CH_EMERGENCY_STATE[el][unitInCombat][class];
    if ( healthPerc <= elb ) then
      unitPercent = healthPerc * 100 / elb;
    else
      el = el - 1;
    end
  end

  return el, healthPerc;

end

-- returns true if a < b
function CH_NeediestHealSort( unit1, unit2 )

  local elUnit1,hpPercUnit1 = CH_EmergencyLevel( unit1, CH_UnitAffectingCombat(unit1) );
  local elUnit2,hpPercUnit2 = CH_EmergencyLevel( unit2, CH_UnitAffectingCombat(unit2) );

  if ( elUnit1 < elUnit2 ) then
    return( true );
  elseif ( elUnit1 == elUnit2 and hpPercUnit1 < hpPercUnit2 ) then
    return( true );
  end

  return( false );

end

-- Looks for the unit, who needs healing most (lowest hp)
-- NOTE: do not use CH_UnitIsDeadOrGhostForReal(), as I cannot calculate health on FDed hunters anyway!
-- returns: unit
local function CHL_NeediestHeal()

  local i;
  local currUnit;

  gNeediestHeal = {};

  -- player
  table.insert( gNeediestHeal, 'player' );

  -- pet
  if ( CH_Config.panicHealPet and UnitExists('pet') and (not UnitIsDeadOrGhost(currUnit)) and UnitHealth(currUnit) > 0 and (not CHL_IsOnBlacklist(currUnit)) ) then
    table.insert( gNeediestHeal, 'pet' );
  end

  -- Party member and pets
  for i = 1, GetNumPartyMembers() do
    if ( CH_Config.panicHealParty ) then
      currUnit = 'party' .. i;
      if ( (not UnitIsDeadOrGhost(currUnit)) and UnitIsConnected(currUnit) and UnitHealth(currUnit) > 0 and (not CHL_IsOnBlacklist(currUnit)) ) then
        table.insert( gNeediestHeal, currUnit );
      end
    end
    if ( CH_Config.panicHealPartyPet ) then
      currUnit = 'partypet' .. i;
      if ( UnitExists(currUnit) and (not UnitIsDead(currUnit)) and UnitHealth(currUnit) > 0 and (not CHL_IsOnBlacklist(currUnit)) ) then
        table.insert( gNeediestHeal, currUnit );
      end
    end
  end

  -- Raid member and pets
  if ( CH_Config.panicHealRaid or CH_Config.panicHealRaidPet ) then
    for i = 1, GetNumRaidMembers() do
      if ( CH_Config.panicHealRaid ) then
        currUnit = 'raid' .. i;
        if ( (not UnitIsDeadOrGhost(currUnit)) and UnitIsConnected(currUnit) and UnitHealth(currUnit) > 0 and (not CHL_IsOnBlacklist(currUnit)) and
             CH_UnitInRaidOnly(currUnit) ) 
        then
          table.insert( gNeediestHeal, currUnit );
        end
      end
      if ( CH_Config.panicHealRaidPet ) then
        currUnit = 'raidpet' .. i;
        if ( UnitExists(currUnit) and (not UnitIsDead(currUnit)) and UnitHealth(currUnit) > 0 and (not CHL_IsOnBlacklist(currUnit)) and CH_UnitInRaidOnly(currUnit) ) then
          table.insert( gNeediestHeal, currUnit );
        end
      end
    end
  end

  table.sort( gNeediestHeal, CH_NeediestHealSort );

end

local function CHL_PanicHeal()

  local neediest;
  local currHealthPerc;
  local el;
  local avatarInCombat = UnitAffectingCombat( 'player' );
  local loopDone = false;
  local spellName = nil;
  local n = 0;
  local i = 1;

  -- ----- already casting a spell?
  if ( gCSIsCasting ) then
    CH_Dbg( 'Already casting a spell ('..(gCSName or 'NIL')..')' );
    return;
  end

  -- ----- only execute once
  if ( gIsPanicHealing and gIsPanicHealing >= GetTime() - 1 ) then
    CH_Dbg( 'Already panic healing', CH_DEBUG_NOTICE );
    return;
  end

  gIsPanicHealing = GetTime();

  -- ----- get sorted list with neediest (from most wounded to healthiest)
  CHL_NeediestHeal();
  n = table.getn( gNeediestHeal );

  -- ----- check if curing/buffing prefered?
  if ( n > 0 and CH_CalcPercentage(UnitHealth(gNeediestHeal[1]),UnitHealthMax(gNeediestHeal[1])) >= 90 ) then 	-- most wounded above 90%
    loopDone = CHL_Decurse( nil, true );									--   -> try curing
    if ( not loopDone and (not avatarInCombat) and (not UnitAffectingCombat(gNeediestHeal[1])) ) then		-- "none" in combat
      loopDone = CHL_BuffGroup( true, 'WARN_TIME' );								--  -> try buffing
    end
  end

  -- ----- loop over all units and heal the first who is eligible
  if ( not loopDone and n > 0 ) then

    if ( CH_Config.checkHealRange ~= 'ONHWEVENT' and CH_Config.panicCheckRange ) then
      CHL_HealRangeScan();
    end

    while ( i <= n and (not loopDone) ) do
      neediest = gNeediestHeal[i];

      if ( (not CH_Config.panicCheckRange) or CH_IsUnitInRange(neediest,'HEAL') ) then
        el = CH_EmergencyLevel( neediest, CH_UnitAffectingCombat(neediest) );
        currHealthPerc = CH_CalcPercentage( UnitHealth(neediest), UnitHealthMax(neediest) );

        if ( avatarInCombat or UnitAffectingCombat(neediest) or					-- unit or avatar in combat?
             (CH_Config.panicCombatHealingInBattlefield and CH_PlayerIsInBattlefield()) )	-- or in battlefield and config
        then
          spellName = CHL_SelectHealSpell( neediest, el );
        else
          spellName = CHL_SelectHealSpellNoCombat( neediest );
        end
      
        if ( spellName ) then							-- we have a spell

if ( neediest ) then
local dbgSpellName=spellName;
local dbgHP = UnitHealth(neediest);
local dbgHPMax = UnitHealthMax(neediest);
if ( type(dbgSpellName) == 'number') then
  dbgSpellName,dbgSpellRank = CH_GetSpellName(dbgSpellName,BOOKTYPE_SPELL);
  dbgSpellName = dbgSpellName..' ('..dbgSpellRank..')';
end
CH_Dbg( 'PANIC-healing '..neediest..' ('..CH_LocalClassAbbr(CH_UnitClass(neediest))..'/'..CH_UnitName(neediest)..'/'..
        floor(CH_CalcPercentage(dbgHP,dbgHPMax))..'%/-'..(dbgHPMax-dbgHP)..'), spell='..dbgSpellName );
end

          CH_CastSpellOnFriend( spellName, nil, neediest, 'SPELL' );
          loopDone = true;
        end
      end
      i = i + 1;
    end

  end

  -- ----- noone got healed, try to decurse and buff (again)
  if ( (not loopDone) and avatarInCombat ) then					-- if not in combat, above
    if ( not CHL_Decurse(nil,true) ) then						-- lets try to cure
      if ( not avatarInCombat ) then								-- if uplayer out of combat
        CHL_BuffGroup( true, 'WARN_TIME' );								-- try to buff
      end
    end
  end

  -- ----- cleaning up
  gIsPanicHealing = nil;

end

local function CHL_PanicNoHeal()

  -- ----- already casting a spell?
  if ( gCSIsCasting ) then
    CH_Dbg( 'Already casting a spell ('..(gCSName or 'NIL')..')' );
    return;
  end

  -- ----- only execute once
  if ( gIsPanicHealing and gIsPanicHealing >= GetTime() - 1 ) then
    CH_Dbg( 'Already panic healing', CH_DEBUG_NOTICE );
    return;
  end

  gIsPanicHealing = GetTime();

  -- decurse or buff
  loopDone = CHL_Decurse( nil, true );
  if ( loopDone ) then
    loopDone = CHL_BuffGroup( true, 'WARN_TIME' );
  end

  -- ----- cleaning up
  gIsPanicHealing = nil;

end

-- ==========================================================================================================================
-- Special spell casting (e.g. for resurrect)
-- ==========================================================================================================================

local function CHL_ResurrectUnit( unit )

  local spellID = CH_GetSpellID( CH_RESURRECT_SPELL, nil, BOOKTYPE_SPELL, true );
  
  if ( spellID < 0 ) then
    CH_Msg( 'You do not know a resurrection spell or are out of reagents.' );
  elseif ( UnitIsDead(unit) ) then
    CH_CastSpellOnFriend( spellID, nil, unit, 'SPELL' );
  elseif ( UnitIsGhost(unit) ) then
    CH_CastSpell( spellID, BOOKTYPE_SPELL, unit );
  end

end

-- ==========================================================================================================================
-- Loading and initializing
-- ==========================================================================================================================

function CH_InitSpellMap()

  local i, spellName, lcSpellName, spellRank, reagent;
  local foundID = -1;
  local foundName = nil;
  local foundRank = nil;
  local lcOldSpellName = nil;

  CH_SpellMap = {};
  CH_DistinctSpells = {};

  if ( not GetSpellName(1,BOOKTYPE_SPELL) ) then			-- not yet available (during load)
    return;
  end

  i = 1;
  spellName,spellRank = CH_GetSpellName( i, BOOKTYPE_SPELL );
  while ( spellName ) do
    lcSpellName = strlower(spellName);

    if ( lcOldSpellName and lcOldSpellName ~= lcSpellName and (not CH_SpellMap[lcOldSpellName].MAX) ) then
      CH_SpellMap[lcOldSpellName].MAX = (i-1);
    end

    if ( not CH_SpellMap[lcSpellName] ) then
      CH_SpellMap[lcSpellName] = {};
    end

    if ( spellRank == nil ) then
      CH_SpellMap[lcSpellName].MAX = i;
    else
      CH_SpellMap[lcSpellName][spellRank] = i;
    end

    if ( lcOldSpellName and lcOldSpellName ~= lcSpellName ) then
      table.insert( CH_DistinctSpells, spellName );
    end

    lcOldSpellName = lcSpellName;
    i = i + 1;
    spellName,spellRank = CH_GetSpellName( i, BOOKTYPE_SPELL );
  end

  CH_SpellMap[lcOldSpellName].MAX = (i-1);
    
end

local function CHL_InitSpellData( healData, spellType, initOverheal )

  local i, findSpell, spellName, spellRank, manaCost, castTime, minHeal, maxHeal, hotMinHeal, hotMaxHeal, calcCastTime;
  local found = false;
  local overhealIdx = 1;

  if ( not healData ) then
    return( found );
  end

  for _,findSpell in healData do
    findSpell = strlower( findSpell );
    i = 1;
    spellName,spellRank = CH_GetSpellName( i, BOOKTYPE_SPELL );
    while ( spellName ) do
      if ( findSpell == strlower(spellName) ) then
        CH_TooltipSetSpell( i, BOOKTYPE_SPELL );
        manaCost = CH_TooltipGetManaCost();
        castTime = CH_TooltipGetCastTime();

        if ( CH_Spells[spellType] == nil or CH_Spells[spellType].spellName ~= spellName or 
             CH_Spells[spellType].spellRank == nil or tonumber(CH_Spells[spellType].spellRank) <= tonumber(spellRank) ) 
        then
          if ( CH_Spells[spellType] == nil ) then
            CH_Spells[spellType] = {};
          end

          CH_Spells[spellType].spellBookIdx = i;
          CH_Spells[spellType].spellName = spellName;
          CH_Spells[spellType].spellRank = tonumber(spellRank);
          CH_Spells[spellType].manaCost = tonumber(manaCost);

          found = true;
        end

        if ( initOverheal and CH_SPELL_INFO[spellName] and CH_SPELL_INFO[spellName].pattern ) then
          if ( CH_SPELL_INFO[spellName].type == 'once' ) then
            minHeal,maxHeal = CH_TooltipGetHealOnce( CH_SPELL_INFO[spellName].pattern, CH_SPELL_INFO[spellName].pattern1 );
            hotMinHeal = 0;
            hotMaxHeal = 0;
          elseif ( CH_SPELL_INFO[spellName].type == 'regrowth' ) then
            minHeal,maxHeal,hotMinHeal,hotMaxHeal = CH_TooltipGetHealRegrowth( CH_SPELL_INFO[spellName].pattern, CH_SPELL_INFO[spellName].pattern1 );
          end

          if ( minHeal == nil ) then
            CH_Msg( 'Please post below on boards, exactly as it is, together with below error msg. Thanx!' );
            CH_Msg( 'ERROR: CHL_InitSpellData(), spellName="'..spellName..'", spellRank="'..spellRank..'", spellType="'..spellType..'", overhealIdx="'..overhealIdx..'"' );
            CH_Msg( 'ERROR: spellType = '..CH_SPELL_INFO[spellName].type );
            CH_Msg( 'ERROR: pattern = '..CH_SPELL_INFO[spellName].pattern );
            if ( CH_SPELL_INFO[spellName].pattern1 ) then
              CH_Msg( 'ERROR: pattern1 = '..CH_SPELL_INFO[spellName].pattern1 );
            end
            CH_Msg( 'ERROR: Tooltip = >'..CH_TooltipTextLeft4:GetText()..'<' );
            minHeal,maxHeal,hotMinHeal,hotMaxHeal = 0,0,0,0;
          end

          if ( not CH_Overheal[spellType] ) then
            CH_Overheal[spellType] = {};
          end

	  if ( not castTime ) then
            calcCastTime = nil;
          elseif ( castTime == 0 ) then
            calcCastTime = 1.5;
          else
            calcCastTime = tonumber(castTime);
          end

          if ( manaCost == nil ) then
            if ( CH_OverhealOld[spellType] and CH_OverhealOld[spellType][overhealIdx] and CH_OverhealOld[spellType][overhealIdx].manaCost ) then
              manaCost = CH_OverhealOld[spellType][overhealIdx].manaCost;
            else
              manaCost = 0;
              CH_Msg( '----------------------------------------------------' );
              CH_Msg( 'manaCost is NIL at init CH_Overheal!!!' );
              CH_Msg( 'Spell: '..spellName..' '..spellRank );
              CH_Msg( CH_TooltipTextLeft2:GetText() );
              CH_Msg( CH_TOOLTIP_MANA_REGEXP );
              CH_Msg( 'Please post above information on the boards, exactly as written (use screenshots)' );
            end
          end

          CH_Overheal[spellType][overhealIdx] = {spellID=i,spellName=spellName,spellRank=tonumber(spellRank),manaCost=tonumber(manaCost),castTime=tonumber(castTime),
                                                 minHeal=tonumber(minHeal),maxHeal=tonumber(maxHeal),hotMinHeal=tonumber(hotMinHeal),hotMaxHeal=tonumber(hotMaxHeal),
                                                 healWindow=tonumber(maxHeal)-tonumber(minHeal),hotWindow=tonumber(hotMaxHeal)-tonumber(hotMinHeal),
                                                 calcCastTime=calcCastTime,manaCost=tonumber(manaCost)};
          table.setn( CH_Overheal[spellType], overhealIdx );
          overhealIdx = overhealIdx + 1;
        end
      end
      i = i + 1;
      spellName,spellRank = CH_GetSpellName( i, BOOKTYPE_SPELL );
    end
  end

  return( found );
    
end

function CH_InitSpells()

  local mb, actionType, tabIdx, tabData;
  local class = CH_UnitClass('player');

  if ( not GetSpellName(1,BOOKTYPE_SPELL) ) then		-- spells not yet loaded
    return;
  end

  CH_OverhealOld = CH_CloneTable( CH_Overheal );		-- keep old data, to lookup mana at omen of clarity and spirit of redemption

  CH_Spells = {};
  CH_Overheal = {};

  CHL_InitSpellData( CH_SPELL_DATA['QUICK'],      'QUICK',      true  );
  CHL_InitSpellData( CH_SPELL_DATA['SLOW'],       'SLOW',       true  );
  CHL_InitSpellData( CH_SPELL_DATA['HOT'],        'HOT',        false );
  CHL_InitSpellData( CH_SPELL_DATA['SHIELD'],     'SHIELD',     false );
  CHL_InitSpellData( CH_SPELL_DATA['COOLDOWN'],   'COOLDOWN',   false );
  CHL_InitSpellData( CH_SPELL_DATA['HEALUP'],     'HEALUP',     true  );
  CHL_InitSpellData( CH_SPELL_DATA['RANGE'],      'RANGE',      false  );
  CHL_InitSpellData( CH_SPELL_DATA['INSTARANGE'], 'INSTARANGE', false  );

  if ( CH_GetSpellID(CH_SPELL_FIND_HERBS,nil,BOOKTYPE_SPELL,false) > 0 or CH_GetSpellID(CH_SPELL_FIND_MINERALS,nil,BOOKTYPE_SPELL,false) > 0 ) then
    gPlayerCanCastTrackingBuff = true;
  elseif ( CH_UnitClass('player') == 'HUNTER' and UnitLevel('player') >= 2 ) then		-- shortcut for hunters (at lvl 2 they get Track Beasts)
    gPlayerCanCastTrackingBuff = true;
  end

  CH_OverhealOld = nil;						-- wipe old data again (save memory)

end

function CH_InitTalents()

  local _,_,_,_,spiritualGuidance = CH_GetTalentInfoByName('Spiritual Guidance');

  if ( spiritualGuidance and spiritualGuidance > 0 ) then
    CH_SpiritualGuidance = spiritualGuidance;
  else
    CH_SpiritualGuidance = 0;
  end

end

function CH_InitBuffPriority( )

  local buffIdx;
  local tableSize = 0;

  CH_BuffPriority = {};

  for buffIdx,_ in CH_BuffData do
    CH_BuffPriority[CH_BuffData[buffIdx].priority] = buffIdx;
    if ( CH_BuffData[buffIdx].priority > tableSize ) then
      tableSize = CH_BuffData[buffIdx].priority;
    end
  end

  table.setn( CH_BuffPriority, tableSize );

end

function CH_InitBuffs( )

  local buffIdx, spellName, partySpellName, dummy1, buffName;
  local playerClass = CH_UnitClass( 'player' );
  local playerRace = CH_UnitRace( 'player' );

  if ( not GetSpellName(1,BOOKTYPE_SPELL) ) then		-- spells not yet loaded
    return;
  end

  CH_BuffDataLookup = {};

  for buffIdx,_ in CH_BuffData do
    spellName = CH_BUFF_DATA[buffIdx].spellName;
    if ( CHL_InitSpellData(spellName,buffIdx) ) then
      CH_BuffData[buffIdx].castable = true;
      for dummy1,buffName in spellName do 					-- an array, can be more than one
        CH_BuffDataLookup[buffName] = buffIdx;
      end
      CH_BuffData[buffIdx].partySpellCastable = false;
      partySpellName = CH_BUFF_DATA[buffIdx].partySpellName;
      if ( partySpellName ) then
        CH_BuffDataLookup[partySpellName] = buffIdx;				-- always map it, even if i dont know it (missing buff detection)!
        if ( CH_GetSpellID(partySpellName,nil,BOOKTYPE_SPELL,false) ) then
          CH_BuffData[buffIdx].partySpellCastable = true;
        end
      end
    else
      CH_BuffData[buffIdx].castable = false;
      CH_BuffData[buffIdx].enabled = false;
      CH_BuffData[buffIdx].partySpellCastable = false;
    end
  end

  CH_InitBuffPriority();

end

function CH_InitTotemSets()

  local set, setData, totem;

  if ( not CH_TotemSetData ) then
    return;
  end

  for set,setData in CH_TotemSetData do
    for totem=1,4 do
      if ( setData[i] and setData[i].name and setData[i].name ~= 'None' ) then
        setData[i].spellID = CH_GetSpellID( setData.totem1Name, nil, BOOKTYPE_SPELL, false );
      end
    end
    setData.lastCastTime = -1;
    setData.nextTotem = 1;
  end

end

function CH_InitCooldownWatchList()

  local k;

  if ( not GetSpellName(1,BOOKTYPE_SPELL) or (not CH_SpellMap) ) then		-- spells not yet loaded or not mapped
    return;
  end

  for k,_ in CH_CooldownWatchList do
    if ( CH_CooldownWatchList[k].spellName ~= 'None' ) then
      CH_CooldownWatchList[k].spellID = CH_GetSpellID( CH_CooldownWatchList[k].spellName, nil, CH_CooldownWatchList[k].bookType, false );
    end
  end

end

local function CHL_DockFrame( frame, relativeTo, relativePoint )

  frame:ClearAllPoints();
  if ( relativePoint == 'RIGHT' ) then
     frame:SetPoint( "LEFT", relativeTo, "RIGHT", 0, 0 );
  else
     frame:SetPoint( "RIGHT", relativeTo, "LEFT", 0, 0 );
  end

end

function CH_OnUnitFrameLoad( idx, frameUnit, frameData )

  local frame;

  if ( idx == 'Extra4' or idx == 'Extra3' or idx == 'extra2' or idx == 'Extra1' ) then 
    getglobal('CH_'..frameUnit..'FrameLabel'):SetText( 'Ex'..frameData );
  end

  frame = getglobal( 'CH_'..frameUnit..'Frame' );
  frame.frameUnit = frameUnit;
  frame.frameData = frameData;
  frame.index = idx;

  frame:RegisterForClicks( "LeftButtonDown", "MiddleButtonDown", "RightButtonDown", "Button4Down", "Button5Down" );

end

-- ==========================================================================================================================
-- Frames and anchoring          
-- ==========================================================================================================================

function CH_AdjustClickHealFrames()

  if ( CH_Config.showClickHeal ) then
    CH_PanicFrame:Show();
    CH_Extra1Frame:Show();
    CH_Extra2Frame:Show();
    CH_Extra3Frame:Show();
    CH_Extra4Frame:Show();
    CH_PlayerFrame:Show();
  else
    CH_PanicFrame:Hide();
    CH_Extra1Frame:Hide();
    CH_Extra2Frame:Hide();
    CH_Extra3Frame:Hide();
    CH_Extra4Frame:Hide();
    CH_PlayerFrame:Hide();
  end

  CH_AnchorAdjust( 'MAIN' );
  CH_AnchorAdjust( 'PARTY' );
  CH_AdjustPartyFrames();

end

local function CHL_AdjustFrameLocal( conf, frames, spec )

  local frame, rg, u, mt, i;

  if ( frames == 'raidgroup' ) then
    for rg=1,CH_MAX_RAID_GROUPS do
      for u=1,CH_MAX_RAID_GROUP_MEMBERS do
        frame = getglobal( 'CH_Raid'..rg..'Unit'..u..'Frame' );
        frame:SetWidth( CH_Config[conf..'Width'] );
        frame:SetHeight( CH_Config[conf..'Height'] );
        frame:SetScale( CH_Config[conf..'Scale'] / 100 );
      end
    end
  elseif ( frames == 'raidclass' ) then
    for u=1,CH_MAX_RAID_MEMBERS do
      frame = getglobal( 'CH_RaidClassUnit'..u..'Frame' );
      frame:SetWidth( CH_Config[conf..'Width'] );
      frame:SetHeight( CH_Config[conf..'Height'] );
      frame:SetScale( CH_Config[conf..'Scale'] / 100 );
    end
    for u=1,CH_MAX_RAID_PETS do
      frame = getglobal( 'CH_RaidPet'..u..'Frame' );
      frame:SetWidth( CH_Config[conf..'Width'] );
      frame:SetHeight( CH_Config[conf..'Height'] );
      frame:SetScale( CH_Config[conf..'Scale'] / 100 );
    end
  elseif ( frames == 'maintank' ) then
    for mt=1,CH_MAX_MAIN_TANKS do
      frame = getglobal( 'CH_MT'..mt..'Frame' );
      frame:SetWidth( CH_Config[conf..'Width'] );
      frame:SetHeight( CH_Config[conf..'Height'] );
      frame:SetScale( CH_Config[conf..'Scale'] / 100 );
      frame = getglobal( 'CH_MT'..mt..'targetFrame' );
      frame:SetWidth( CH_Config[conf..'Width'] );
      frame:SetHeight( CH_Config[conf..'Height'] );
      frame:SetScale( CH_Config[conf..'Scale'] / 100 );
    end
  elseif ( frames == 'needylist' ) then
    for i=1,CH_MAX_NEEDY_LIST_MEMBERS do
      frame = getglobal( 'CH_NeedyList'..spec..i..'Frame' );
      frame:SetWidth( CH_Config[conf..'Width'] );
      frame:SetHeight( CH_Config[conf..'Height'] );
      frame:SetScale( CH_Config[conf..'Scale'] / 100 );
    end
  else
    for _,frame in frames do
      frame:SetWidth( CH_Config[conf..'Width'] );
      frame:SetHeight( CH_Config[conf..'Height'] );
      frame:SetScale( CH_Config[conf..'Scale'] / 100 );
    end
  end

end

function CH_AdjustFrames( idx )

  if ( idx == 'all' or idx == 'align' ) then
    CH_AdjustPartyFrames();
  end

  if ( idx == 'extra' or idx == 'all' ) then
    CHL_AdjustFrameLocal( 'extraFrame', {CH_Extra1Frame,CH_Extra2Frame,CH_Extra3Frame,CH_Extra4Frame} );
    CH_AnchorAdjust( 'MAIN' );
  end

  if ( idx == 'panic' or idx == 'all' ) then
    CHL_AdjustFrameLocal( 'panicFrame', {CH_PanicFrame} );
    CH_AnchorAdjust( 'MAIN' );
  end

  if ( idx == 'player' or idx == 'all' ) then
    CHL_AdjustFrameLocal( 'playerFrame', {CH_PlayerFrame} );
    CH_AnchorAdjust( 'PARTY' );
  end

  if ( idx == 'party' or idx == 'all' ) then
    CHL_AdjustFrameLocal( 'partyFrame', {CH_Party1Frame,CH_Party2Frame,CH_Party3Frame,CH_Party4Frame} );
    CH_AnchorAdjust( 'PARTY' );
  end

  if ( idx == 'pet' or idx == 'all' ) then
    CHL_AdjustFrameLocal( 'petFrame', {CH_PetFrame} );
    CH_AnchorAdjust( 'PARTY' );
  end

  if ( idx == 'partypet' or idx == 'all' ) then
    CHL_AdjustFrameLocal( 'partyPetFrame', {CH_Partypet1Frame,CH_Partypet2Frame,CH_Partypet3Frame,CH_Partypet4Frame} );
    CH_AnchorAdjust( 'PARTY' );
  end

  if ( idx == 'playertarget' or idx == 'all' ) then
    CHL_AdjustFrameLocal( 'playerTargetFrame', {CH_PlayertargetFrame} );
  end

  if ( idx == 'partytarget' or idx == 'all' ) then
    CHL_AdjustFrameLocal( 'partyTargetFrame', {CH_Party1targetFrame,CH_Party2targetFrame,CH_Party3targetFrame,CH_Party4targetFrame} );
  end

  if ( idx == 'pettarget' or idx == 'all' ) then
    CHL_AdjustFrameLocal( 'petTargetFrame', {CH_PettargetFrame} );
  end

  if ( idx == 'partypettarget' or idx == 'all' ) then
    CHL_AdjustFrameLocal( 'partyPetTargetFrame', {CH_Partypet1targetFrame,CH_Partypet2targetFrame,CH_Partypet3targetFrame,CH_Partypet4targetFrame} );
  end

  if ( idx == 'raidgroup' or idx == 'all' ) then
    CHL_AdjustFrameLocal( 'raidGroupFrame', 'raidgroup' );
    CH_AnchorAdjust( 'RAIDGROUP' );
  end

  if ( idx == 'raidclass' or idx == 'all' ) then
    CHL_AdjustFrameLocal( 'raidClassFrame', 'raidclass' );
    CH_AnchorAdjust( 'RAIDCLASS' );
  end

  if ( idx == 'maintank' or idx == 'all' ) then
    CHL_AdjustFrameLocal( 'mainTankFrame', 'maintank' );
    CH_AnchorAdjust( 'MAINTANK' );
  end

  if ( idx == 'needylistheal' or idx == 'all' ) then
    CHL_AdjustFrameLocal( 'needyListHealFrame', 'needylist', 'HEAL' );
    CH_AnchorAdjust( 'HEAL' );
  end

  if ( idx == 'needylistcure' or idx == 'all' ) then
    CHL_AdjustFrameLocal( 'needyListCureFrame', 'needylist', 'CURE' );
    CH_AnchorAdjust( 'CURE' );
  end

  if ( idx == 'needylistbuff' or idx == 'all' ) then
    CHL_AdjustFrameLocal( 'needyListBuffFrame', 'needylist', 'BUFF' );
    CH_AnchorAdjust( 'BUFF' );
  end

  if ( idx == 'needylistdead' or idx == 'all' ) then
    CHL_AdjustFrameLocal( 'needyListDeadFrame', 'needylist', 'DEAD' );
    CH_AnchorAdjust( 'DEAD' );
  end

end

function CH_AdjustPartyFrames( )

  local i, unit;
  local frame, unitLabelFrame, targetFrame, showUnit, isPet, adjustConfig, unitNo;
  local point, relativePoint, prePoint, preRelativePoint, dockTo;
  local firstUnitFrame = nil;

  if ( CH_Config.frameGroupMode == 'ALL' ) then
    dockTo = CH_PanicFrame;
    prePoint = 'TOP';
    preRelativePoint = 'BOTTOM';
  else
    dockTo = CH_PartyAnchor;
    prePoint = CH_AnchorGrowToPoint( 'Party' );
    preRelativePoint = CH_AnchorGrowToRelativePoint( 'Party' );
  end

  if ( CH_Config.frameAlign == 'LEFT' ) then
    point = prePoint..'LEFT';
    relativePoint = preRelativePoint..'LEFT';
  elseif ( CH_Config.frameAlign == 'CENTER' ) then
    point = prePoint;
    relativePoint = preRelativePoint;
  else
    point = prePoint..'RIGHT';
    relativePoint = preRelativePoint..'RIGHT';
  end

  for i,unit in CH_Config.partySort do
    if ( unit == 'player' ) then
      unitNo = 0;
      frame = CH_PlayerFrame;
      unitLabelFrame = CH_PlayerNameText;
      targetFrame = CH_PlayertargetFrame;
      showUnit = CH_Config.showClickHeal;
      isPet = false;
      adjustConfig = 'playerFrame';
    elseif ( strsub(unit,1,5) == 'party' and strsub(unit,6,8) ~= 'pet' ) then
      unitNo = strsub( unit, 6, 6 );
      frame = getglobal( 'CH_Party'..unitNo..'Frame' );
      unitLabelFrame = getglobal( 'CH_Party'..unitNo..'NameText' );
      targetFrame = getglobal( 'CH_Party'..unitNo..'targetFrame' );
      showUnit = (CH_Config.showParty and CH_Config.showClickHeal and UnitExists(unit));
      if ( showUnit and CH_UnitPlayerInRaid('player') and (CH_Config.hidePartyInRaid == 'HIDE' or (CH_Config.hidePartyInRaid == 'WOW' and HIDE_PARTY_INTERFACE == '1')) ) then
       showUnit = false;
      end
      isPet = false;
      adjustConfig = 'partyFrame';
    elseif ( unit == 'pet' ) then
      unitNo = 0;
      frame = CH_PetFrame;
      unitLabelFrame = CH_PetNameText;
      targetFrame = CH_PettargetFrame;
      showUnit = (CH_Config.showClickHeal and UnitExists(unit));
      adjustConfig = 'petFrame';
      if ( showUnit ) then
        gPetVisibility[unit] = true;
      else
        gPetVisibility[unit] = false;
      end
    elseif ( strsub(unit,1,8) == 'partypet' ) then
      unitNo = strsub( unit, 9, 9 );
      frame = getglobal( 'CH_Partypet'..unitNo..'Frame' );
      unitLabelFrame = getglobal( 'CH_Partypet'..unitNo..'NameText' );
      targetFrame = getglobal( 'CH_Partypet'..unitNo..'targetFrame' );
      showUnit = (CH_Config.showParty and CH_Config.showPartyPets and CH_Config.showClickHeal and UnitExists(unit) and UnitExists('party'..unitNo));
      if ( showUnit and CH_UnitPlayerInRaid('player') and (CH_Config.hidePartyInRaid == 'HIDE' or (CH_Config.hidePartyInRaid == 'WOW' and HIDE_PARTY_INTERFACE == '1')) ) then
       showUnit = false;
      end
      isPet = true;
      adjustConfig = 'partyPetFrame';
      if ( showUnit ) then
        gPetVisibility[unit] = true;
      else
        gPetVisibility[unit] = false;
      end
    else
      CH_Debug( 'AdjustPartyFrames, ELSE ('..unit..')', CH_DEBUG_WARNING );
    end

    if ( showUnit ) then
      CHL_AdjustFrameLocal( adjustConfig, {frame} );
      frame:ClearAllPoints();
      frame:SetPoint( point, dockTo, relativePoint, 0, 0 );
      CH_SetUnitLabel( unit, unitNo, isPet, false, false, unitLabelFrame );
      frame:Show();
      dockTo = frame;
      if ( not firstUnitFrame ) then
        firstUnitFrame = frame;
      end
    else
      frame:Hide();
      targetFrame:Hide();
    end
  end

  if ( CH_Config.frameGroupMode == 'ALL' ) then
    CH_AnchorSetTopFrame( CH_MainAnchor, CH_PanicFrame );
    CH_AnchorSetBottomFrame( CH_MainAnchor, dockTo );
    CH_AnchorSetTopFrame( CH_PartyAnchor, nil );
    CH_AnchorSetBottomFrame( CH_PartyAnchor, nil );
  else
    CH_AnchorSetTopFrame( CH_MainAnchor, CH_PanicFrame );
    CH_AnchorSetBottomFrame( CH_MainAnchor, CH_PanicFrame );
    CH_AnchorSetTopFrame( CH_PartyAnchor, firstUnitFrame );
    CH_AnchorSetBottomFrame( CH_PartyAnchor, dockTo );
  end

  CH_EffectsCleanUp();

end

function CH_AdjustRaidFrames()

  local r,u,c;
  local frame, anchorFrame, anchorID;

  -- wipe all raid groups
  for r=1,CH_MAX_RAID_GROUPS do
    anchorFrame = getglobal( 'CH_Raid'..r..'Anchor' );
    CH_AnchorSetTopFrame( anchorFrame, nil );
    CH_AnchorSetBottomFrame( anchorFrame, nil );
    anchorFrame.members = 0;
    for u=1,CH_MAX_RAID_GROUP_MEMBERS do
      getglobal('CH_Raid'..r..'Unit'..u..'Frame'):Hide();
    end
    anchorFrame.isVisible = false;
  end

  -- wipe all raid classes
  for _,c in CH_ALL_CLASSES do
    anchorFrame = getglobal( 'CH_Raid'..c..'Anchor' );
    CH_AnchorSetTopFrame( anchorFrame, nil );
    CH_AnchorSetBottomFrame( anchorFrame, nil );
    anchorFrame.members = 0;
    anchorFrame.isVisible = false;
  end
  for u=1,CH_MAX_RAID_MEMBERS do
    getglobal('CH_RaidClassUnit'..u..'Frame'):Hide();
  end

  -- now fill in values
  for u=1,GetNumRaidMembers() do
    local name,rank,subgroup,level,local_class,fileName,zone,online,isDead = GetRaidRosterInfo( u );
    anchorFrame = getglobal( 'CH_Raid'..subgroup..'Anchor' );

    -- raid groups
    if ( anchorFrame.members <= CH_MAX_RAID_GROUP_MEMBERS and CH_Config['showRaidGroup'..subgroup]) then
      anchorID = CH_AnchorFrameNameToID( anchorFrame:GetName() );
      anchorFrame.members = anchorFrame.members + 1;
      anchorFrame.isVisible = true;
      frame = getglobal( 'CH_Raid'..subgroup..'Unit'..anchorFrame.members..'Frame' );
      frame:ClearAllPoints();
      frame:SetPoint( CH_AnchorGrowToPoint(anchorID), anchorFrame.bottomFrame or anchorFrame, CH_AnchorGrowToRelativePoint(anchorID), 0, 0 );
      if ( anchorFrame.members == 1 ) then
        CH_AnchorSetTopFrame( anchorFrame, frame );
      end
      CH_AnchorSetBottomFrame( anchorFrame, frame );
      CH_OnUnitFrameLoad( 'raid'..u, 'Raid'..subgroup..'Unit'..anchorFrame.members, u );
      frame:Show();
    end

    -- raid classes
    local class = CH_UnitClass( 'raid'..u );
    if ( class and class ~= 'UNKNOWN' and CH_Config['showRaidClass'..class] ) then
      anchorFrame = getglobal( 'CH_Raid'..class..'Anchor' );
      anchorID = CH_AnchorFrameNameToID( anchorFrame:GetName() );
      anchorFrame.members = anchorFrame.members + 1;
      anchorFrame.isVisible = true;
      frame = getglobal('CH_RaidClassUnit'..u..'Frame');
      frame:ClearAllPoints();
      frame:SetPoint( CH_AnchorGrowToPoint(anchorID), anchorFrame.bottomFrame or anchorFrame, CH_AnchorGrowToRelativePoint(anchorID), 0, 0 );
      if ( anchorFrame.members == 1 ) then
        CH_AnchorSetTopFrame( anchorFrame, frame );
      end
      CH_AnchorSetBottomFrame( anchorFrame, frame );
      CH_OnUnitFrameLoad( 'raid'..u, 'RaidClassUnit'..u, u );
      frame:Show();
    end

  end

  CH_AnchorAdjust( 'RAIDGROUP' );
  CH_AnchorAdjust( 'RAIDCLASS' );
  CH_AnchorRedockAll();

end

function CH_AdjustRaidPetFrames()

  local u, frame;
  local idx = 1;
  local anchorID = 'RaidPets';

  CH_AnchorSetTopFrame( CH_RaidPetsAnchor, nil );
  CH_AnchorSetBottomFrame( CH_RaidPetsAnchor, nil );
  CH_RaidPetsAnchor.members = 0;

  if ( CH_Config.showRaidPets ) then
    for u=1,GetNumRaidMembers() do
      if ( UnitExists('raidpet'..u) ) then
        frame = getglobal('CH_RaidPet'..idx..'Frame');
        frame:ClearAllPoints();
        frame:SetPoint( CH_AnchorGrowToPoint(anchorID), CH_RaidPetsAnchor.bottomFrame or CH_RaidPetsAnchor, CH_AnchorGrowToRelativePoint(anchorID), 0, 0 );

        if ( idx == 1 ) then
          CH_AnchorSetTopFrame( CH_RaidPetsAnchor, CH_RaidPet1Frame );
        end
        CH_AnchorSetBottomFrame( CH_RaidPetsAnchor, getglobal('CH_RaidPet'..idx..'Frame') );
        CH_RaidPetsAnchor.members = CH_RaidPetsAnchor.members + 1;

        CH_OnUnitFrameLoad( 'raidpet'..u, 'RaidPet'..idx, u );

        getglobal('CH_RaidPet'..idx..'Frame'):Show();
        idx = idx + 1;
        if ( idx > CH_MAX_RAID_PETS ) then
          break;
        end
      end
    end
  end

  CH_AnchorUpdateVisibility( CH_RaidPetsAnchor, 'RAIDPET', CH_RaidPetsAnchor.members > 0 );

  if ( CH_RaidPet1Frame:IsVisible() ) then				-- dont enter if all is hidden already!
    frame = getglobal('CH_RaidPet'..idx..'Frame');
    while ( idx <= CH_MAX_RAID_PETS and frame:IsVisible() ) do
      frame:Hide();
      idx = idx + 1;
      frame = getglobal('CH_RaidPet'..idx..'Frame');
    end
  end

end

function CH_AdjustMainTankFrames()

  local unit, frame, targetFrame, i;
  local idx = 1;
  local anchorID = 'MainTank';

  CH_AnchorSetTopFrame( CH_MTAnchor, nil );
  CH_AnchorSetBottomFrame( CH_MTAnchor, nil );
  CH_MTAnchor.members = 0;
  CH_MTAnchor.targetTopFrame = nil;
  CH_MTAnchor.targetBottomFrame = nil;

  for i=1,CH_MAX_MAIN_TANKS do
    unit = CH_MainTankGetUnit( i );
    if ( unit ) then
      frame = getglobal('CH_MT'..idx..'Frame');
      targetFrame = getglobal('CH_MT'..idx..'targetFrame');
      frame.chSisterFrame = targetFrame;
      targetFrame.chSisterFrame = frame;

      frame:ClearAllPoints();
      frame:SetPoint( CH_AnchorGrowToPoint(anchorID), CH_MTAnchor.bottomFrame or CH_MTAnchor, CH_AnchorGrowToRelativePoint(anchorID), 0, 0 );

      if ( idx == 1 ) then
        CH_AnchorSetTopFrame( CH_MTAnchor, CH_MT1Frame );
        CH_MTAnchor.targetTopFrame = CH_MT1targetFrame;
      end
      CH_AnchorSetBottomFrame( CH_MTAnchor, getglobal('CH_MT'..idx..'Frame') );
      CH_MTAnchor.targetBottomFrame = getglobal( 'CH_MT'..idx..'targetFrame' );
      CH_MTAnchor.members = CH_MTAnchor.members + 1;

      CH_OnUnitFrameLoad( unit..'target', 'MT'..idx, i );
      CH_OnUnitFrameLoad( unit..'targettarget', 'MT'..idx..'target', i );

      frame:Show();
      idx = idx + 1;
    end
  end

  CH_AnchorUpdateVisibility( CH_MTAnchor, 'MAINTANK', CH_MTAnchor.members > 0 );

  if ( CH_MT1Frame:IsVisible() ) then				-- dont enter if all is hidden already!
    frame = getglobal('CH_MT'..idx..'Frame');
    while ( idx <= CH_MAX_MAIN_TANKS and frame:IsVisible() ) do
      frame:Hide();
      getglobal('CH_MT'..idx..'targetFrame'):Hide();
      idx = idx + 1;
      frame = getglobal('CH_MT'..idx..'Frame');
    end
  end

end

function CH_ResetFramePositions()

  CH_ConfigReset( 'GUI', 'ANCHOR' );

  CHH_Frame:ClearAllPoints();
  CHH_Frame:SetPoint( 'CENTER', UIParent, 'CENTER', 0, 20 );

end

function CH_DockTargetFrames()

    CHL_DockFrame( CH_PlayertargetFrame, CH_PlayerFrame, CH_Config.dockTarget );

    CHL_DockFrame( CH_Party1targetFrame, CH_Party1Frame, CH_Config.dockTarget );
    CHL_DockFrame( CH_Party2targetFrame, CH_Party2Frame, CH_Config.dockTarget );
    CHL_DockFrame( CH_Party3targetFrame, CH_Party3Frame, CH_Config.dockTarget );
    CHL_DockFrame( CH_Party4targetFrame, CH_Party4Frame, CH_Config.dockTarget );

    CHL_DockFrame( CH_PettargetFrame, CH_PetFrame, CH_Config.dockTarget );
    CHL_DockFrame( CH_Partypet1targetFrame, CH_Partypet1Frame, CH_Config.dockTarget );
    CHL_DockFrame( CH_Partypet2targetFrame, CH_Partypet2Frame, CH_Config.dockTarget );
    CHL_DockFrame( CH_Partypet3targetFrame, CH_Partypet3Frame, CH_Config.dockTarget );
    CHL_DockFrame( CH_Partypet4targetFrame, CH_Partypet4Frame, CH_Config.dockTarget );

end

-- ==========================================================================================================================
-- Anchors               
-- ==========================================================================================================================

local function CHL_AnchorUpdateLabel( anchor, isVisible, label )

  local anchorID;

  anchorID = CH_AnchorFrameNameToID( anchor:GetName() );
  if ( gAnchorIsMoving or CH_Config.showDockAnchors or (CH_AnchorIDIsVisible(anchorID) and isVisible) ) then
    if ( label ) then
      if ( (gAnchorIsMoving or CH_Config.showDockAnchors) and CH_Anchor[anchorID].visibility == 'COLLAPSE' ) then
        getglobal(anchor:GetName()..'MoveLabel'):SetText( '>'..label..'<' );
      else
        getglobal(anchor:GetName()..'MoveLabel'):SetText( label );
      end
    end
    anchor:Show();
    getglobal(anchor:GetName()..'MoveBackground'):Hide();
    getglobal(anchor:GetName()..'MoveHighlight'):Hide();
    getglobal(anchor:GetName()..'MoveDisabled'):Hide();
    if ( gAnchorIsMoving or CH_Config.showDockAnchors ) then
      if ( CH_AnchorIsMovable(anchor:GetName()) ) then
        getglobal(anchor:GetName()..'MoveHighlight'):Show();
      else
        getglobal(anchor:GetName()..'MoveDisabled'):Show();
      end
    elseif ( CH_Config.showAnchors and CH_AnchorIsMovable(anchor:GetName()) ) then
      getglobal(anchor:GetName()..'MoveBackground'):Show();
    end
  else
    anchor:Hide();
  end

end

local function CHL_AnchorResize( anchorID, newScale, newWidth, newHeight )

  local anchorFrame = getglobal( CH_ANCHOR_DATA[anchorID].frameName );
  local bottomFrame = getglobal( CH_ANCHOR_DATA[anchorID].bottomFrameName );
  local scaledWidth = newWidth * newScale / 100;

  anchorFrame:SetWidth( scaledWidth );
  anchorFrame:SetScale( 1 );
--  anchorFrame:SetWidth( newWidth );
--  anchorFrame:SetScale( newScale / 100 );

  bottomFrame:SetWidth( scaledWidth );
  bottomFrame:SetScale( 1 );
--  bottomFrame:SetWidth( newWidth );
--  bottomFrame:SetScale( newScale / 100 );

end

local function CHL_AnchorCalculatePartyAnchorValues( scale, width, height )

  local conf;
  local newScale = scale or -1;
  local newWidth = width or -1;
  local newHeight = height or -1;

  for _,conf in {'player','pet','party','partyPet'} do
    if ( CH_Config[conf..'FrameScale'] > newScale ) then newScale = CH_Config[conf..'FrameScale']; end;
    if ( CH_Config[conf..'FrameWidth'] > newWidth ) then newWidth = CH_Config[conf..'FrameWidth']; end;
    if ( CH_Config[conf..'FrameHeight'] > newHeight ) then newHeight = CH_Config[conf..'FrameHeight']; end;
  end

  return newScale, newWidth, newHeight;

end

local function CHL_AnchorCalculateMainAnchorValues()

  local newScale = CH_Config.panicFrameScale;
  local newWidth = CH_Config.panicFrameWidth;
  local newHeight = CH_Config.panicFrameHeight;

  if ( CH_Config.extraFrameScale > newScale ) then newScale = CH_Config.extraFrameScale; end;
  if ( CH_Config.extraFrameWidth*2 > newWidth ) then newWidth = CH_Config.extraFrameWidth*2; end;
  if ( CH_Config.extraFrameHeight > newHeight ) then newHeight = CH_Config.extraFrameHeight; end;

  if ( CH_Config.frameGroupMode == 'ALL' ) then
    return CHL_AnchorCalculatePartyAnchorValues( newScale, newWidth, newHeight );
  end

  return newScale, newWidth, newHeight;

end

-- anchorGroup: the 'meta' type or the anchorID
function CH_AnchorAdjust( anchorGroup )

  local i, c, anchorID
  local newScale, newWidth, newHeight;

  if ( anchorGroup == 'MAIN' or anchorGroup == 'Main' or anchorGroup == 'ALL' ) then
    CHL_AnchorUpdateLabel( CH_MainAnchor, CH_Config.showAnchors and CH_Config.showClickHeal, CHT_LABEL_ANCHOR_CLICKHEAL_BAR );
    newScale,newWidth,newHeight = CHL_AnchorCalculateMainAnchorValues();
    CHL_AnchorResize( 'Main', newScale, newWidth, newHeight )
  end

  if ( anchorGroup == 'PARTY' or anchorGroup == 'Party' or anchorGroup == 'ALL' ) then
    CHL_AnchorUpdateLabel( CH_PartyAnchor, CH_Config.showAnchors and CH_Config.showClickHeal and CH_Config.frameGroupMode == 'GROUP', CHT_LABEL_ANCHOR_PARTY_BAR );
    newScale,newWidth,newHeight = CHL_AnchorCalculateMainAnchorValues();
    CHL_AnchorResize( 'Main', newScale, newWidth, newHeight )
    newScale,newWidth,newHeight = CHL_AnchorCalculatePartyAnchorValues();
    CHL_AnchorResize( 'Party', newScale, newWidth, newHeight )
  end

  if ( anchorGroup == 'HEAL' or anchorGroup == 'NeedyListHeal' or anchorGroup == 'ALL' ) then
    CHL_AnchorUpdateLabel( CHL_NeedyListGetAnchor('HEAL'), CHL_NeedyListShouldShow('HEAL'), CHT_LABEL_ANCHOR_NEEDY_LIST_HEAL_BAR );
    CHL_AnchorResize( 'NeedyListHeal', CH_Config.needyListHealFrameScale, CH_Config.needyListHealFrameWidth, CH_Config.needyListHealFrameHeight )
  end

  if ( anchorGroup == 'CURE' or anchorGroup == 'NeedyListCure' or anchorGroup == 'ALL' ) then
    CHL_AnchorUpdateLabel( CHL_NeedyListGetAnchor('CURE'), CHL_NeedyListShouldShow('CURE'), CHT_LABEL_ANCHOR_NEEDY_LIST_CURE_BAR );
    CHL_AnchorResize( 'NeedyListCure', CH_Config.needyListCureFrameScale, CH_Config.needyListCureFrameWidth, CH_Config.needyListCureFrameHeight )
  end

  if ( anchorGroup == 'BUFF' or anchorGroup == 'NeedyListBuff' or  anchorGroup == 'ALL' ) then
    CHL_AnchorUpdateLabel( CHL_NeedyListGetAnchor('BUFF'), CHL_NeedyListShouldShow('BUFF'), CHT_LABEL_ANCHOR_NEEDY_LIST_BUFF_BAR );
    CHL_AnchorResize( 'NeedyListBuff', CH_Config.needyListBuffFrameScale, CH_Config.needyListBuffFrameWidth, CH_Config.needyListBuffFrameHeight )
  end

  if ( anchorGroup == 'DEAD' or anchorGroup == 'NeedyListDead' or anchorGroup == 'ALL' ) then
    CHL_AnchorUpdateLabel( CHL_NeedyListGetAnchor('DEAD'), CHL_NeedyListShouldShow('DEAD'), CHT_LABEL_ANCHOR_NEEDY_LIST_DEAD_BAR );
    CHL_AnchorResize( 'NeedyListDead', CH_Config.needyListDeadFrameScale, CH_Config.needyListDeadFrameWidth, CH_Config.needyListDeadFrameHeight )
  end

  if ( anchorGroup == 'MAINTANK' or anchorGroup == 'MainTank' or anchorGroup == 'ALL' ) then
    CHL_AnchorUpdateLabel( CH_MTAnchor, true, CHT_LABEL_ANCHOR_MAIN_TANK_BAR );
    CHL_AnchorResize( 'MainTank', CH_Config.mainTankFrameScale, CH_Config.mainTankFrameWidth, CH_Config.mainTankFrameHeight )
  end

  if ( anchorGroup == 'RAIDGROUP' or anchorGroup == 'ALL' or strsub(anchorGroup,1,9) == 'RaidGroup' ) then
    for i=1,CH_MAX_RAID_GROUPS do
      anchorID = 'RaidGroup'..i;
      CHL_AnchorUpdateLabel( getglobal(CH_ANCHOR_DATA[anchorID].frameName), CH_Config['showRaidGroup'..i], getglobal('CHT_LABEL_ANCHOR_RAID_GROUP_'..i..'_BAR') );
      CHL_AnchorResize( anchorID, CH_Config.raidGroupFrameScale, CH_Config.raidGroupFrameWidth, CH_Config.raidGroupFrameHeight )
    end
  end

  if ( anchorGroup == 'RAIDCLASS' or anchorGroup == 'ALL' or anchorGroup == 'RaidDruid' or anchorGroup == 'RaidHunter' or anchorGroup == 'RaidMage' or anchorGroup == 'RaidPaladin' or
                                    anchorGroup == 'RaidPriest' or anchorGroup == 'RaidRogue' or anchorGroup == 'RaidShaman' or anchorGroup == 'RaidWarlock' or anchorGroup == 'RaidWarrior' )
  then
    for _,c in CH_ALL_CLASSES do
      anchorID = 'Raid'..strsub(c,1,1)..strlower(strsub(c,2));
      CHL_AnchorUpdateLabel( getglobal(CH_ANCHOR_DATA[anchorID].frameName), CH_Config['showRaidClass'..c], getglobal('CHT_LABEL_ANCHOR_RAID_CLASS_'..c..'_BAR') );
      CHL_AnchorResize( anchorID, CH_Config.raidClassFrameScale, CH_Config.raidClassFrameWidth, CH_Config.raidClassFrameHeight )
    end
    CHL_AnchorResize( 'RaidPets', CH_Config.raidClassFrameScale, CH_Config.raidClassFrameWidth, CH_Config.raidClassFrameHeight )
  end

  if ( anchorGroup == 'RAIDPET' or anchorGroup == 'ALL' or anchorGroup == 'RaidPets' ) then
    CHL_AnchorUpdateLabel( CH_RaidPetsAnchor, CH_Config.showRaidPets, CHT_LABEL_ANCHOR_RAID_PETS_BAR );
    CHL_AnchorResize( 'RaidPets', CH_Config.raidClassFrameScale, CH_Config.raidClassFrameWidth, CH_Config.raidClassFrameHeight )
  end

end

local function CHL_AnchorRedock( anchorID )

  local point, relativePoint, offsetX, offsetY;
  local lAnchorID;
  local relativeTo = nil;
  local frame = getglobal(CH_ANCHOR_DATA[anchorID].frameName);

  if ( not frame ) then
    CH_Dbg( 'Cannot get frame object for anchor '..anchorID..' ('..CH_ANCHOR_DATA[anchorID].frameName..')', CH_DEBUG_ERR );
    return;
  end

  if ( CH_Anchor[anchorID].relativeTo == 'GUI' ) then
    relativeTo = UIParent;
    point = CH_Anchor[anchorID].relativePoint;
    relativePoint = point;
    offsetX = CH_Anchor[anchorID].offsetX;
    offsetY = CH_Anchor[anchorID].offsetY;
  else
    lAnchorID = CH_Anchor[anchorID].relativeTo;
    while ( CH_Anchor[lAnchorID].relativeTo ~= 'GUI' and CH_Anchor[lAnchorID].visibility == 'COLLAPSE' and (not CH_AnchorIDIsVisible(lAnchorID)) ) do
      anchorID = lAnchorID;
      lAnchorID = CH_Anchor[anchorID].relativeTo;
    end
    if ( CH_Anchor[lAnchorID].relativeTo == 'GUI' and CH_Anchor[lAnchorID].visibility == 'COLLAPSE' and (not CH_AnchorIDIsVisible(lAnchorID)) ) then
      relativeTo = UIParent;
      point = CH_Anchor[lAnchorID].relativePoint;
      relativePoint = point;
      offsetX = CH_Anchor[lAnchorID].offsetX;
      offsetY = CH_Anchor[lAnchorID].offsetY;
    else
      relativePoint = CH_Anchor[anchorID].relativePoint;
      point = CHL_MirrorAnchor( relativePoint, 'HV' );
      offsetX = CH_Anchor[anchorID].offsetX;
      offsetY = CH_Anchor[anchorID].offsetY;
      if ( relativePoint == 'BOTTOM' ) then
        relativeTo = getglobal( CH_ANCHOR_DATA[lAnchorID].bottomFrameName );
        if ( CH_Anchor[lAnchorID].grow == 'UP' ) then
          relativePoint = 'TOP';
          point = 'BOTTOM';
        end
      else
        relativeTo = getglobal( CH_ANCHOR_DATA[lAnchorID].frameName );
      end
    end
  end

--  CH_Dbg( 'doing '..frame:GetName()..' point:'..point..', relativeTo: '..relativeTo:GetName()..', relativePoint: '..relativePoint );

  frame:ClearAllPoints();
  frame:SetPoint( point, relativeTo, relativePoint, offsetX, offsetY );

end

function CH_AnchorMayAnchorTo( anchorID, toAnchorID, relativePoint )

  local lAnchorID;
  local mirrorRelativePoint = CHL_MirrorAnchor(relativePoint,'HV');

  -- may not dock to itself
  if ( toAnchorID == anchorID ) then
    CH_Dbg( 'CH_AnchorMayAnchorTo(): EXIT-1' );
    return( false );
  end

  -- currently only TOP/LEFF/BOTTOM/RIGHT
  if ( not (relativePoint == 'TOP' or relativePoint == 'LEFT' or relativePoint == 'BOTTOM' or relativePoint == 'RIGHT') ) then
    CH_Dbg( 'CH_AnchorMayAnchorTo(): EXIT-2' );
    return( false );
  end

  -- check for loop dependencies
  if ( toAnchorID ~= 'GUI' ) then
    lAnchorID = toAnchorID;
    while ( lAnchorID and CH_Anchor[lAnchorID].relativeTo ~= 'GUI' ) do
      if ( CH_Anchor[lAnchorID].relativeTo == anchorID ) then
        CH_Dbg( 'CH_AnchorMayAnchorTo(): EXIT-3' );
        return( false );
      end
      lAnchorID = CH_Anchor[lAnchorID].relativeTo;
    end
  end

  -- check if toAnchor has docked itself on that side already
  if ( CH_Anchor[toAnchorID].relativeTo ~= 'GUI' and CH_Anchor[toAnchorID].relativePoint == mirrorRelativePoint and relativePoint ~= 'BOTTOM' ) then
    CH_Dbg( 'CH_AnchorMayAnchorTo(): EXIT-4' );
    return( false );
  end

  -- check grow direction on vertical dock 
  if ( (relativePoint == 'TOP' and CH_Anchor[anchorID].grow == CH_Anchor[toAnchorID].grow) or (relativePoint == 'BOTTOM' and CH_Anchor[anchorID].grow ~= CH_Anchor[toAnchorID].grow) ) then
   CH_Dbg( 'CH_AnchorMayAnchorTo(): EXIT-5' );
   return( false );
  end

  for lAnchorID,_ in CH_Anchor do
    -- check if something else is already docked to the toAnchor on the same side
    if ( lAnchorID ~= toAnchorID and CH_Anchor[lAnchorID].relativeTo == toAnchorID and CH_Anchor[lAnchorID].relativePoint == relativePoint) then
      CH_Dbg( 'CH_AnchorMayAnchorTo(): EXIT-6' );
      return( false );
    end
    -- frame already docked at this side of the anchor
    if ( lAnchorID ~= anchorID and CH_Anchor[lAnchorID].relativeTo == anchorID and CH_Anchor[lAnchorID].relativePoint == mirrorRelativePoint and
         (relativePoint ~= 'TOP' or CH_Anchor[anchorID].grow == CH_Anchor[toAnchorID].grow) )
    then
      CH_Dbg( 'CH_AnchorMayAnchorTo(): EXIT-7' );
      return( false );
    end
  end

  return( true );

end

local function CHL_AnchorDockTo( anchorID, toAnchorID, relativePoint, redraw, skipCheck )

  if ( (not skipCheck) and (not CH_AnchorMayAnchorTo(anchorID,toAnchorID,relativePoint)) ) then
    return( false );
  end

  CH_Anchor[anchorID].relativeTo = toAnchorID;
  CH_Anchor[anchorID].relativePoint = relativePoint;
  CH_Anchor[anchorID].offsetX = 0;
  CH_Anchor[anchorID].offsetY = 0;

  if ( redraw ) then
    CH_AnchorAdjust( anchorID );
    CHL_AnchorRedock( anchorID );
  end

  return( true );

end

function CH_AnchorRedockAll()

  local anchorID;

  if ( gAnchorIsRedocking ) then
    gAnchorNeedRedock = true;
    CH_Dbg( 'CH_AnchorRedockAll: Delaying redocking' );
  end

  gAnchorIsRedocking = true;
  gAnchorNeedRedock = false;

  CH_Dbg( 'CH_AnchorRedockAll: Redocking all anchors' );

  -- undock all
  for anchorID,_ in CH_Anchor do
    getglobal(CH_ANCHOR_DATA[anchorID].frameName):ClearAllPoints();
  end

  -- updating
  for anchorID,_ in CH_Anchor do
    CHL_AnchorRedock( anchorID );
  end

  gAnchorIsRedocking = false;

end

function CH_AnchorRedrawContent( anchorID )

  if ( CH_ANCHOR_DATA[anchorID].redrawFuncParam ) then
    getglobal(CH_ANCHOR_DATA[anchorID].redrawFuncName)( CH_ANCHOR_DATA[anchorID].redrawFuncParam );
  else
    getglobal(CH_ANCHOR_DATA[anchorID].redrawFuncName)();
  end

end

function CH_AnchorSetTopFrame( anchor, topFrame )

  anchor.topFrame = topFrame;

end

function CH_AnchorSetBottomFrame( anchor, bottomFrame )

  local anchorID = CH_AnchorFrameNameToID( anchor:GetName() );
  local bottomAnchor = getglobal(CH_ANCHOR_DATA[anchorID].bottomFrameName);

  anchor.bottomFrame = bottomFrame;

  bottomAnchor:ClearAllPoints();
  if ( bottomFrame ) then
    bottomAnchor:SetPoint( CH_AnchorGrowToPoint(anchorID), bottomFrame, CH_AnchorGrowToRelativePoint(anchorID), 0, 0 );
  else
    bottomAnchor:SetPoint( CH_AnchorGrowToPoint(anchorID), anchor, CH_AnchorGrowToRelativePoint(anchorID), 0, 0 );
  end

end

function CH_AnchorFrameNameToID( frameName )

  return( CH_ANCHOR_FRAME_NAME_MAP[frameName] );

end

function CH_AnchorGrowToPoint( anchorID )

  if ( CH_Anchor[anchorID].grow == 'DOWN' ) then
    return( 'TOP' );
  else
    return( 'BOTTOM' );
  end

end

function CH_AnchorGrowToRelativePoint( anchorID )

  if ( CH_Anchor[anchorID].grow == 'DOWN' ) then
    return( 'BOTTOM' );
  else
    return( 'TOP' );
  end

end

function CH_AnchorDockTooltipTo( point, anchorID )

  if ( point == 'TOP' ) then
    if ( CH_Anchor[anchorID].grow == 'DOWN' ) then
      return( getglobal(CH_ANCHOR_DATA[anchorID].frameName).topFrame or getglobal(CH_ANCHOR_DATA[anchorID].frameName) );
    else
      return( getglobal(CH_ANCHOR_DATA[anchorID].frameName).bottomFrame or getglobal(CH_ANCHOR_DATA[anchorID].bottomFrameName) );
    end
  elseif ( point == 'BOTTOM' ) then
    if ( CH_Anchor[anchorID].grow == 'DOWN' ) then
      return( getglobal(CH_ANCHOR_DATA[anchorID].frameName).bottomFrame or getglobal(CH_ANCHOR_DATA[anchorID].bottomFrameName) );
    else
      return( getglobal(CH_ANCHOR_DATA[anchorID].frameName).topFrame or getglobal(CH_ANCHOR_DATA[anchorID].frameName) );
    end
  else
    CH_Dbg( 'CH_AnchorDockTooltip() called with invalid point! ('..(point or 'NIL')..'/'..(anchorID or 'NIL')..')', CH_DEBUG_ERR );
  end

end

function CH_AnchorIDIsVisible( anchorID )

  local anchorFrame = getglobal( CH_ANCHOR_DATA[anchorID].frameName );

  return( CH_Anchor[anchorID].visibility == 'SHOW' or anchorFrame.isVisible or CH_Config.showDockAnchors or gAnchorIsMoving );

end

function CH_AnchorFrameIsVisible( anchorFrame )

  local anchorID = CH_AnchorFrameNameToID( anchorFrame:GetName() );

  return( CH_AnchorIDIsVisible( anchorID ) );

end

function CH_AnchorIsMovable( anchorID )			-- anchorID or frameName

  if ( not anchorID ) then
    return( false );
  end

  if ( not CH_Anchor[anchorID] ) then
    anchorID = CH_AnchorFrameNameToID( anchorID );
  end

  if ( CH_Anchor[anchorID].relativeTo == 'GUI' ) then
    return( CH_Config.showAnchors or CH_Config.showDockAnchors );
  end

  return( false );

end

-- the screen visibility, not the property!
function CH_AnchorUpdateVisibility( anchor, anchorGroup, isVisible )

  local anchorID;

  if ( anchor.isVisible ~= isVisible ) then
    anchor.isVisible = isVisible;

    if ( anchorGroup == 'HEAL' or anchorGroup == 'BUFF' or anchorGroup == 'CURE' or anchorGroup == 'DEAD' ) then
      CH_AnchorAdjust( anchorGroup );
    elseif ( anchorGroup == 'MAINTANK' ) then
      CH_AnchorAdjust( 'MAINTANK' );
    elseif ( anchorGroup == 'RAIDGROUP' ) then
      -- CH_AnchorAdjust( 'RAIDGROUP' );	done in CH_RaidFramesAdjust()
    elseif ( anchorGroup == 'RAIDCLASS' ) then
      -- CH_AnchorAdjust( 'RAIDCLASS' );	done in CH_RaidFramesAdjust()
    elseif ( anchorGroup == 'RAIDPET' ) then
      CH_AnchorAdjust( 'RAIDPET' );
    end

    anchorID = CH_AnchorFrameNameToID( anchor:GetName() );
    if ( CH_Anchor[anchorID].visibility == 'COLLAPSE' ) then
      CH_AnchorRedockAll();						-- needy list optimize by only (recurivly) updating anchors dependant on this one
    end
  end

end

local function CHL_AnchorSetGrow( anchorID, grow, isFirst )

  -- TEMPORARY, below code for recursive chagnes
  if ( CH_Anchor[anchorID].grow ~= grow ) then
    CH_Anchor[anchorID].grow = grow;
    CH_AnchorRedrawContent( anchorID );
  end

  if ( 1 == 1 ) then return; end
  -- END TEMPORARY

  local lAnchorID, lRelativePoint;

  -- anchor LEFT or RIGHT
  if ( CH_Anchor[anchorID].relativePoint == 'LEFT' or CH_Anchor[anchorID].relativePoint == 'RIGHT' ) then
    CH_Anchor[anchorID].grow = grow;
    CH_AnchorRedrawContent( anchorID );
    return;
  end

  -- anchor TOP or BOTTOM, find 'root' : exit if 'docking' direction changes (butterfly effects)
  if ( isFirst ) then
    while ( CH_Anchor[anchorID].relativeTo ~= 'GUI' and CH_Anchor[CH_Anchor[anchorID].relativeTo].relativePoint == CH_Anchor[anchorID].relativePoint ) do
      anchorID = CH_Anchor[anchorID].relativeTo;
    end
  end

  -- set the value and redraw content
  if ( CH_Anchor[anchorID].grow ~= grow ) then
    CH_Anchor[anchorID].grow = grow;
    CH_AnchorRedrawContent( anchorID );
  end

  -- recursively change dependant anchors
  for lAnchorID,_ in CH_Anchor do
    lRelativePoint = CH_Anchor[lAnchorID].relativePoint;
    if ( CH_Anchor[lAnchorID].relativeTo == anchorID and relativePoint ~= grow and (lRelativePoint == 'TOP' or lRelativePoint == 'BOTTOM') ) then
      CHL_AnchorSetGrow( lAnchorID, grow, false );
    end
  end

end

function CH_AnchorSetValue( anchorID, property, value )

  local relativePoint;

  if ( property == 'offsetX' ) then
    value = string.gsub( value, "[^%d-]", "" );
    value = tonumber( value );
    if ( value == nil ) then
      value = 0;
    end
  elseif ( property == 'offsetY' ) then
    value = string.gsub( value, "[^%d-]", "" );
    value = tonumber( value );
    if ( value == nil ) then
      value = 0;
    end
  elseif ( property == 'relativeTo') then
    if ( value ~= 'GUI' ) then
      relativePoint = CH_Anchor[anchorID].relativePoint;
      if ( relativePoint == 'BOTTOMLEFT' or relativePoint == 'BOTTOMRIGHT' or relativePoint == 'TOPLEFT' or relativePoint == 'TOPRIGHT') then
        CH_Anchor[anchorID].relativePoint = 'LEFT';
      end
    end
  end
    
  if ( property == 'grow' ) then
    CHL_AnchorSetGrow( anchorID, value, true );
  else
    CH_Anchor[anchorID][property] = value;
  end

  if ( property == 'relativeTo' ) then
    CH_AnchorAdjust( 'ALL' );
  elseif ( property == 'visibility' ) then
    CH_AnchorAdjust( 'ALL' );
  end

  CH_AnchorRedockAll();

  return( true );
 
end

function CH_AnchorOnUpdate( )

  local mAnchorID, mFrame, mLeft, mRight, mTop, mBottom, mCenterX, mCenterY, mScale;	-- the moving anchor
  local anchorID, aFrame, aLeft, aRight, aTop, aBottom, aCenterX, aCenterY, aScale;	-- the anchor to dock to
  local bFrame, bTop, bBottom, bCenterX, bCenterY;					-- the bottom anchor to dock to
  local mr = CH_Config.anchorMagneticRange;

  if ( CH_IsMoving(this:GetParent()) and (not IsShiftKeyDown()) and mr > 0 ) then
    mFrame = this:GetParent();
    mAnchorID = CH_AnchorFrameNameToID( mFrame:GetName() );
    mScale = mFrame:GetScale();
    mLeft = ceil( mFrame:GetLeft() * mScale + 0.5 );
    mRight = ceil( mFrame:GetRight() * mScale + 0.5 );
    mTop = ceil( mFrame:GetTop() * mScale + 0.5 );
    mBottom = ceil( mFrame:GetBottom() * mScale + 0.5 );
    mCenterX,mCenterY = mFrame:GetCenter();
    mCenterX = ceil( mCenterX * mScale + 0.5 );
    mCenterY = ceil( mCenterY * mScale + 0.5 );

    for anchorID,_ in CH_ANCHOR_DATA do
      aFrame = getglobal( CH_ANCHOR_DATA[anchorID].frameName );
      if ( anchorID ~= mAncorID and aFrame:IsVisible() ) then
        aScale = aFrame:GetScale();
        aLeft = ceil( aFrame:GetLeft() * aScale + 0.5 );
        aRight = ceil( aFrame:GetRight() * aScale + 0.5 );
        aTop = ceil( aFrame:GetTop() * aScale + 0.5 );
        aBottom = ceil( aFrame:GetBottom() * aScale + 0.5 );
        aCenterX,aCenterY = aFrame:GetCenter();
        aCenterX = ceil( aCenterX * aScale + 0.5 );
        aCenterY = ceil( aCenterY * aScale + 0.5 );

        bFrame = getglobal( CH_ANCHOR_DATA[anchorID].bottomFrameName );
        bScale = bFrame:GetScale();
        bTop = ceil( bFrame:GetTop() * bScale + 0.5 );
        bBottom = ceil( bFrame:GetBottom()* bScale  + 0.5 );
        bCenterX,bCenterY = bFrame:GetCenter();
        bCenterX = ceil( bCenterX * bScale + 0.5 );

        if ( mRight < aLeft+mr/2 and mRight >= aLeft-mr and mCenterY >= aCenterY-mr and mCenterY <= aCenterY+mr and   		-- dock to the left ('move' is left of frame)
            CH_AnchorMayAnchorTo(mAnchorID,anchorID,'LEFT') )
        then
          if ( CHL_AnchorDockTo(mAnchorID,anchorID,'LEFT',true,true) ) then
            CH_StopMoving( this:GetParent()  );
            gAnchorIsMoving = false;
            CH_AnchorAdjust( 'ALL' );
            CH_AnchorRedockAll();
          end
        elseif ( mLeft > aRight-mr/2 and mLeft <= aRight+mr and mCenterY >= aCenterY-mr and mCenterY <= aCenterY+mr and   	-- dock to the right ('move' is right of frame) 
                CH_AnchorMayAnchorTo(mAnchorID,anchorID,'RIGHT') )
        then
          if ( CHL_AnchorDockTo(mAnchorID,anchorID,'RIGHT',true,true) ) then
            CH_StopMoving( this:GetParent()  );
            gAnchorIsMoving = false;
            CH_AnchorAdjust( 'ALL' );
            CH_AnchorRedockAll();
          end
        elseif (     ((CH_Anchor[anchorID].grow == 'DOWN' and mTop < bBottom and mTop >= bBottom-mr) 				-- growing upward
                      or (CH_Anchor[anchorID].grow =='UP' and mBottom > bTop and mBottom <= bTop+mr))				-- growing downwards
                 and mCenterX >= bCenterX-mr and mCenterX <= bCenterX+mr          			 			-- dock to the bottom ('move' is below frame)
                 and CH_AnchorMayAnchorTo(mAnchorID,anchorID,'BOTTOM') )
        then
          if ( CHL_AnchorDockTo(mAnchorID,anchorID,'BOTTOM',true,true) ) then
            CH_StopMoving( this:GetParent()  );
            gAnchorIsMoving = false;
            CH_AnchorAdjust( 'ALL' );
            CH_AnchorRedockAll();
          end
        elseif ( CH_Anchor[anchorID].grow == 'DOWN' and										-- list growing donwards
                 mBottom > aTop and mBottom <= aTop+mr and mCenterX >= aCenterX-mr and mCenterX <= aCenterX+mr and		-- dock to the top ('move' is above frame)
                 CH_AnchorMayAnchorTo(mAnchorID,anchorID,'TOP') )
        then
          if ( CHL_AnchorDockTo(mAnchorID,anchorID,'TOP',true,true) ) then
            CH_StopMoving( this:GetParent()  );
            gAnchorIsMoving = false;
            CH_AnchorAdjust( 'ALL' );
            CH_AnchorRedockAll();
          end
        end
      end
    end
  end

end

function CH_AnchorOnMouseDown( mouseButton )

  local anchorID = CH_AnchorFrameNameToID( this:GetParent():GetName() );

  if ( mouseButton == 'LeftButton' and (IsShiftKeyDown() or CH_AnchorIsMovable(anchorID)) ) then
    gAnchorIsMoving = true;
    CH_AnchorAdjust( 'ALL' );
    CH_AnchorRedockAll();
    CH_Anchor[anchorID].relativeTo = 'GUI';
    CH_StartMoving( this:GetParent() );
  elseif ( mouseButton == 'RightButton' and CH_Anchor[anchorID].showMenu ) then
    CH_HelpButton();
    getglobal(CH_ANCHOR_DATA[anchorID].menuFuncName)();
  elseif ( mouseButton == 'MiddleButton' and CH_Anchor[anchorID].showMenu ) then
    CH_HelpButton();
    CHH_GuiAnchorsTab();
  end

end

function CH_AnchorOnMouseUp( mouseButton )

  local point, relativeTo, relativePoint, offsetX, offsetY;
  local anchorID = CH_AnchorFrameNameToID( this:GetParent():GetName() );

  if ( CH_IsMoving(this:GetParent()) ) then
    CH_StopMoving( this:GetParent()  );

    point,relativeTo,relativePoint,offsetX,offsetY = this:GetParent():GetPoint();

    CH_Anchor[anchorID].relativeTo = 'GUI';
    CH_Anchor[anchorID].relativePoint = point;
    CH_Anchor[anchorID].offsetX = floor(offsetX+0.5);
    CH_Anchor[anchorID].offsetY = floor(offsetY+0.5);

    gAnchorIsMoving = false;
    CH_AnchorAdjust( 'ALL' );
--    CH_AnchorRedockAll();		-- not needed, no redocking done, just move!

    if ( CHH_GuiAnchors:IsVisible() ) then
      CHH_GuiAnchorsTab();
    end
  end

end

function CH_AnchorOnHide()

  CH_StopMoving( this:GetParent()  );
  gAnchorIsMoving = false;
--  CH_AnchorAdjust( 'ALL' );

end

-- ==========================================================================================================================
-- Plugin Support
-- ==========================================================================================================================

function CH_RegisterPlugin( plugin, actionID, allowed, classes, editable, editable2, insertAfter )

  local i=1;

  if ( CH_PluginList[actionID] ) then
    CH_Msg( 'Plugin '..plugin:GetName()..' already registered ID '..actionID );
    return( false );
  end

  CH_PluginList[actionID] = plugin;
  table.insert( CH_PluginListSort, actionID );

  CH_ActionList[actionID] = {allowed=allowed,classes=classes,editable=editable,editable2=editable2,isMetaspell=false,plugin=plugin,func=nil};

  while ( CH_ActionListSort[i] and CH_ActionListSort[i] ~= insertAfter ) do
    i = i + 1;
  end

  if ( CH_ActionListSort[i] and CH_ActionListSort[i] == insertAfter ) then
    table.insert( CH_ActionListSort, i+1, actionID );
  else
    table.insert( CH_ActionListSort, actionID );
  end

  CH_Debug( 'ID '..actionID..' for plugin '..plugin:GetName()..' registered', CH_DEBUG_INFO );

  return( true );

end

-- ==========================================================================================================================
-- Healing spells called by the XML
-- ==========================================================================================================================

function CH_PanicClicked( mouse )

  local rtc = true;
  local actionType = nil;
  local mb = CH_BuildMouseButton( mouse );

  actionType = CH_MouseSpells.Panic[mb];
  unit = CH_NormalizeUnit( unit );

  if ( actionType == nil and CH_Config.panicOnUnmapped ) then						-- panic on unmapped
    actionType = 'PANIC';
  end

  if ( actionType == nil ) then										-- no spell
    CH_Debug( 'No spell assigned to: '..mb, CH_DEBUG_NOTICE );
    rtc = false;
  elseif ( actionType and (not CH_ActionList[actionType]) ) then
    CH_Debug( 'Unknown action: '..mb..' (disabled plugin?)', CH_DEBUG_NOTICE );
    rtc = false;
  elseif ( actionType == 'PANIC' ) then 								-- PANIC
    if ( CH_CLASS_INFO[CH_UnitClass('player')].isHealer ) then
      CHL_PanicHeal();
    else
      CHL_PanicNoHeal();
    end
  elseif ( actionType == 'GRPBUFF' ) then								-- GRPBUFF
    rtc = CHL_BuffGroup( false, CH_MouseSpellsData.Panic[mb] );
  elseif ( actionType == 'GRPCURE' ) then								-- GRPCURE
    rtc = CHL_Decurse( nil, false );
  elseif ( actionType == 'SPELL' ) then									-- SPELL
    CH_CastSpellOnEnemy( CH_MouseSpellsData.Panic[mb].spellName, CH_MouseSpellsData.Panic[mb].spellRank, nil, 'SPELL' );
  elseif ( actionType == 'PETSPELL' ) then								-- PETSPELL
    CH_CastSpellOnEnemy( CH_MouseSpellsData.Panic[mb].spellName, nil, nil, 'PETSPELL' );
  elseif ( CH_ActionList[actionType].plugin ) then							-- plugin call
    CH_ActionList[actionType].plugin:Callback( nil, CH_MouseSpellsData.Panic[mb], actionType );
  elseif ( CH_ActionList[actionType].func ~= nil ) then							-- function call
    CH_ActionList[actionType].func( 'Panic', mb, nil );
  else													-- ELSE (error)
    CH_Debug( 'ELSE in CH_PanicClicked(), actionType='..actionType, CH_DEBUG_ERROR );
    rtc = false;
  end

  return( rtc );

end

function CH_ExtraClicked( extraIdx, mouse )

  local rtc = true;
  local actionType = nil;
  local mb = CH_BuildMouseButton( mouse );

  actionType = CH_MouseSpells[extraIdx][mb];

  if ( actionType == nil ) then
    CH_Debug( 'No spell assigned to: '..mb, CH_DEBUG_NOTICE );
    rtc = false;
  elseif ( actionType and (not CH_ActionList[actionType]) ) then
    CH_Debug( 'Unknown action: '..mb..' (disabled plugin?)', CH_DEBUG_NOTICE );
    rtc = false;
  elseif ( actionType == 'SPELL' ) then
    CH_CastSpellOnEnemy( CH_MouseSpellsData[extraIdx][mb].spellName, CH_MouseSpellsData[extraIdx][mb].spellRank, nil, 'SPELL' );
  elseif ( actionType == 'PETSPELL' ) then
    CH_CastSpellOnEnemy( CH_MouseSpellsData[extraIdx][mb].spellName, nil, nil, 'PETSPELL' );
  elseif ( CH_ActionList[actionType].plugin ) then
    CH_ActionList[actionType].plugin:Callback( nil, CH_MouseSpellsData[extraIdx][mb], actionType );
  elseif ( CH_ActionList[actionType].func ~= nil ) then
    CH_ActionList[actionType].func( extraIdx, mb, nil );
  elseif ( actionType == 'GRPBUFF' ) then								-- GRPBUFF
    rtc = CHL_BuffGroup( false, CH_MouseSpellsData[extraIdx][mb] );
  elseif ( actionType == 'GRPCURE' ) then								-- GRPCURE
    rtc = CHL_Decurse( nil, false );
  else
    CH_Debug( 'ELSE in CH_ExtraClicked()', CH_DEBUG_ERROR );
    rtc = false;
  end

  return( rtc );

end

function CH_FriendlyClicked( unit, mouse )

  local rtc = true;
  local clickedUnit = unit;
  local actionType = nil;
  local mb = CH_BuildMouseButton( mouse );

  actionType = CH_MouseSpells.Friend[mb];
  unit = CH_NormalizeUnit( unit );

  if ( SpellIsTargeting() and SpellCanTargetUnit(unit) ) then
    SpellTargetUnit( unit );
  elseif ( not UnitExists(unit) ) then
    CH_Dbg( 'Unit does not exist', CH_DEBUG_DEBUG );
    rtc = false;
  elseif ( CursorHasItem() ) then
    if ( UnitIsUnit(unit,'player') ) then
      AutoEquipCursorItem();
    else
      DropItemOnUnit( unit );
    end
  elseif ( gCSName and 
       (   (CH_SPELL_DATA.SLOW and CH_Config.overheal.SLOW.clickAbortPerc <= 100 and CH_InTable(CH_SPELL_DATA.SLOW,gCSName) and 
            floor(CH_CalcPercentage(UnitHealth(unit),UnitHealthMax(unit))) >= CH_Config.overheal.SLOW.clickAbortPerc)
        or (CH_SPELL_DATA.QUICK and CH_Config.overheal.QUICK.clickAbortPerc <= 100 and CH_InTable(CH_SPELL_DATA.QUICK,gCSName) and
            floor(CH_CalcPercentage(UnitHealth(unit),UnitHealthMax(unit))) >= CH_Config.overheal.QUICK.clickAbortPerc) ) )
  then
    CH_Dbg( 'Aborting spell (clickAbortPerc)', CH_DEBUG_INFO );
    SpellStopCasting();
  elseif ( UnitIsPlayer(unit) and CH_UnitIsDeadOrGhostForReal(unit) and CH_RESURRECT_SPELL and (not UnitIsUnit('player',unit)) and
       (CH_Config.resurrectPlayer == 'ALWAYS' or (CH_Config.resurrectPlayer == 'AFTER_COMBAT' and (not UnitAffectingCombat('player')))) and
       actionType ~= 'TARGET' and actionType ~= 'MENU' and actionType ~= 'TOOLTIP' )
  then
    CHL_ResurrectUnit( unit );
  elseif ( actionType == nil ) then
    CH_Debug( 'No spell assigned to: '..mb, CH_DEBUG_NOTICE );
    rtc = false;
  elseif ( actionType and (not CH_ActionList[actionType]) ) then
    CH_Debug( 'Unknown action: '..mb..' (disabled plugin?)', CH_DEBUG_NOTICE );
    rtc = false;
  elseif ( actionType == 'BUFF' ) then
    rtc = CH_BuffUnit( unit, CH_MouseSpellsData.Friend[mb] );
  elseif ( actionType == 'DEBUFF' ) then
    rtc = CHL_Decurse( unit, false );
  elseif ( CH_ActionList[actionType].isMetaspell ) then
    local spellName = CHL_FinetuneHealSpell( unit, CH_Spells[actionType].spellName, actionType );
    if ( spellName ) then
      CH_CastSpellOnFriend( spellName, nil, unit, 'SPELL' );
    else
      CH_Debug( 'No spell to cast', CH_DEBUG_INFO );
    end
  elseif ( actionType == 'SPELL' ) then
    CH_CastSpellOnFriend( CH_MouseSpellsData.Friend[mb].spellName, CH_MouseSpellsData.Friend[mb].spellRank, unit, 'SPELL' );
  elseif ( actionType == 'PETSPELL' ) then
    CH_CastSpellOnEnemy( CH_MouseSpellsData.Friend[mb].spellName, nil, unit, 'PETSPELL' );
  elseif ( CH_ActionList[actionType].plugin ) then							-- plugin call
    CH_ActionList[actionType].plugin:Callback( unit, CH_MouseSpellsData.Friend[mb], actionType );
  elseif ( CH_ActionList[actionType].func ~= nil ) then
    CH_ActionList[actionType].func( 'Friend', mb, unit, clickedUnit );
  else
    CH_Debug( 'ELSE in CH_FriendlyClicked(), actionType='..actionType, CH_DEBUG_ERROR );
    rtc = false;
  end

  return( rtc );

end

function CH_EnemyClicked( unit, mouse )

  local rtc = true;
  local clickedUnit = unit;
        unit = CH_NormalizeUnit( unit );
  local actionType = nil;
  local mb = CH_BuildMouseButton( mouse );
  local ssfIdx = CH_GetShapeshiftFormIdx( unit );
  local idx = 'Enemy'..(ssfIdx or '');

  actionType = CH_MouseSpells[idx][mb];

  if ( SpellIsTargeting() and SpellCanTargetUnit(unit) ) then
    SpellTargetUnit( unit );
  elseif ( not UnitExists(unit) ) then
    CH_Dbg( 'Unit does not exist', CH_DEBUG_DEBUG );
    rtc = false;
  elseif ( CursorHasItem() ) then
    DropItemOnUnit( unit );
  elseif ( actionType == nil ) then
    CH_Debug( 'No spell assigned to: '..mb , CH_DEBUG_NOTICE );
    rtc = false;
  elseif ( actionType and (not CH_ActionList[actionType]) ) then
    CH_Debug( 'Unknown action: '..mb..' (disabled plugin?)', CH_DEBUG_NOTICE );
    rtc = false;
  elseif ( actionType == 'SPELL' ) then
    CH_CastSpellOnEnemy( CH_MouseSpellsData[idx][mb].spellName, CH_MouseSpellsData[idx][mb].spellRank, unit, 'SPELL' );
  elseif ( actionType == 'PETSPELL' ) then
    CH_CastSpellOnEnemy( CH_MouseSpellsData[idx][mb].spellName, nil, unit, 'PETSPELL' );
  elseif ( CH_ActionList[actionType].plugin ) then							-- plugin call
    CH_ActionList[actionType].plugin:Callback( unit, CH_MouseSpellsData[idx][mb], actionType );
  elseif ( CH_ActionList[actionType].func ~= nil ) then
    CH_ActionList[actionType].func( idx, mb, unit, clickedUnit );
  else
    CH_Debug( 'ELSE in CH_EnemyClicked()', CH_DEBUG_ERROR );
    rtc = false;
  end

  return( rtc );

end

function CH_UnitClicked( unit, mouse )

  local rtc = true;

  if ( CH_Config.checkHealRange == 'ONHWEVENT' ) then
    CHL_HealRangeScan();
  end

  if ( unit == 'Panic' ) then
    rtc = CH_PanicClicked( mouse );
  elseif ( strsub(unit,1,5) == 'Extra' ) then
    rtc = CH_ExtraClicked( unit, mouse );
  elseif ( UnitCanAttack('player',unit) ) then
    rtc = CH_EnemyClicked( unit, mouse );
  else
    rtc = CH_FriendlyClicked( unit, mouse );
  end

  return( rtc );

end

local function CHL_HideExtraBar( frame, bar, frameText, text )

  frameText:SetText( text );
  getglobal(frame:GetName()..'Background'):SetTexture( 0.2, 0.2, 0.2, 0.8 );
  bar:Hide();

end

function CH_OnExtraUpdate( extraIdx )

  local frame = getglobal('CH_Extra'..extraIdx..'Frame');
  local frameText = getglobal('CH_Extra'..extraIdx..'FrameLabel');
  local bar = getglobal('CH_Extra'..extraIdx..'FrameBar');
  local barCenter = getglobal('CH_Extra'..extraIdx..'FrameBarCenter');
  local text = CH_Config['extra'..extraIdx..'Name'];

  if ( CH_Config['extra'..extraIdx..'Hidden'] ) then
    if ( frame:IsVisible() ) then
      frame:Hide();
    end
    return;
  end

  if ( extraIdx == 4 ) then
    CHL_ShowMesmerize();
  end

  CH_TooltipActionsRefresh( nil, 'Extra'..extraIdx );

  if ( (not CH_CooldownWatchList[extraIdx]) or CH_CooldownWatchList[extraIdx].spellID < 0 ) then
    CHL_HideExtraBar( frame, bar, frameText, text );
    return;
  end

  local start,duration,enable = GetSpellCooldown( CH_CooldownWatchList[extraIdx].spellID, CH_CooldownWatchList[extraIdx].bookType );

  if ( start > 0 and duration > 1.5 ) then
    bar:Show();
    bar:SetValue( (duration-(GetTime()-start)) * 100 / duration );
    getglobal(this:GetName()..'Background'):SetTexture( 1, 0.5, 0, 0.5 );
    frameText:SetText( '' );
    local remain = ceil( duration - (GetTime()-start) );
    if ( remain > 60 ) then
      remain = string.format( "%d:%02d", floor(remain/60), mod(remain,60) );
    end
    barCenter:SetText( remain );
  else
    CHL_HideExtraBar( frame, bar, frameText, text );
  end

end

function CH_StartMoving( frame )

  frame:StartMoving();
  frame.ch_is_moving = true;

end

function CH_StopMoving( frame )

  if ( not frame.ch_is_moving ) then
    return;
  end

  frame:StopMovingOrSizing();

  frame.ch_is_moving = nil;

end

function CH_IsMoving( frame )

  return( frame.ch_is_moving );

end

-- ==========================================================================================================================
-- (Pre)Defined Actions
-- ==========================================================================================================================

function CH_ActionTargetUnit( extraIdx, mouseButton, unit )

  TargetUnit( unit );

end

function CH_ActionAssistUnit( extraIdx, mouseButton, unit )

  AssistUnit( unit );

end

function CH_ActionAttackUnit( extraIdx, mouseButton, unit )

  TargetUnit( unit );

--  if ( not UnitAffectingCombat('player') ) then		PROBLEM: If in combat, but passive
    AttackTarget();
--  end

end

function CH_ActionPetAttackUnit( extraIdx, mouseButton, unit )

  local action;
  local reTarget = nil;

  if ( not unit ) then
    unit = 'pettarget';
  end

  if ( not UnitExists(unit) ) then
    PetAttack();						-- maybe lag
    return;
  end

  if ( not UnitIsUnit('target',unit) ) then
    reTarget = CH_NormalizeUnit( 'target' );
    TargetUnit( unit );
  end

  PetAttack();
  CH_SetRestartCombat();

  action = CH_MouseSpellsData[extraIdx][mouseButton].action;
  if ( (not action) or action == 'NONE' ) then
    -- nop
  elseif ( action == 'HUNTERS_MARK' ) then
    if ( not CH_UnitHasDebuff(unit,CH_SPELL_HUNTERS_MARK,false) ) then
      CH_CastSpellOnEnemy( CH_SPELL_HUNTERS_MARK, nil, unit, 'SPELL' );
    end
  end

  if ( reTarget ) then
    CH_ReTarget( reTarget );
  end

end

function CH_ActionUseWand( extraIdx, mouseButton, unit )

  if ( HasWandEquipped() ) then
    TargetUnit( unit );
    CH_CastSpellByName( CH_SPELL_SHOOT );
  elseif ( CH_UnitClass('player') == 'HUNTER' and GetInventoryItemLink('player',GetInventorySlotInfo('RangedSlot')) ) then
    TargetUnit( unit );
    CH_CastSpellByName( CH_SPELL_AUTO_SHOT );
  else
    CH_Msg( 'You do not have a wand/bow/gun equipped' );
  end

end

function CH_ActionUseAnyItem( extraIdx, mouseButton, unit )

  local lookupName = CH_MouseSpellsData[extraIdx][mouseButton][1];

  if ( lookupName == nil or lookupName == '' ) then
    CH_Msg( 'No item given to use' );
    return;
  end

  lookupName = strlower( lookupName );

  if ( not unit ) then
    unit = 'player';
  end

  if ( not CH_UseInventoryItemByName(lookupName,unit) ) then
    if ( not CH_UseBagItemByName(lookupName,unit,true) ) then
      CH_Msg( 'No suitable item found ('..CH_MouseSpellsData[extraIdx][mouseButton]..')' );
    end
  end

end

function CH_ActionStompTotem( extraIdx, mouseButton, unit )

  local set = CH_MouseSpellsData[extraIdx][mouseButton];

  if ( not CH_TotemSetData[set] ) then
    CH_Msg( 'Set '..set..' not defined' );
    return;
  end

  if ( CH_TotemSetData[set].resetSeconds > 0 and GetTime() - CH_TotemSetData[set].lastCastTime >= CH_TotemSetData[set].resetSeconds ) then
    CH_TotemSetData[set].nextTotem = 1;
  end

  local oldNextTotem = CH_TotemSetData[set].nextTotem;

  while ( CH_TotemSetData[set][CH_TotemSetData[set].nextTotem].name == 'None' ) do
    CH_TotemSetData[set].nextTotem = CH_TotemSetData[set].nextTotem + 1;
    if ( CH_TotemSetData[set].nextTotem > 4 ) then
      CH_TotemSetData[set].nextTotem = 1;
    end
    if ( CH_TotemSetData[set].nextTotem == oldNextTotem ) then
      CH_Msg( "Totem Set "..set.." is empty" );
      return;
    end
  end

  local start,duration,enable = GetSpellCooldown( CH_TotemSetData[set][CH_TotemSetData[set].nextTotem].spellID, BOOKTYPE_SPELL );
  if ( start > 0 and duration > 0 ) then
    return;						-- wait for cooldown
  end

--  CH_Msg( 'Stomping '..CH_TotemSetData[set][CH_TotemSetData[set].nextTotem].name );
  CastSpellByName( CH_TotemSetData[set][CH_TotemSetData[set].nextTotem].name );

  CH_TotemSetData[set].nextTotem = CH_TotemSetData[set].nextTotem + 1;
  if ( CH_TotemSetData[set].nextTotem > 4 ) then
    CH_TotemSetData[set].nextTotem = 1;
  end

  CH_TotemSetData[set].lastCastTime = GetTime();

end

function CH_ActionExecuteScript( extraIdx, mouseButton, unit )

  local script = CH_MouseSpellsData[extraIdx][mouseButton][1];

  if ( script == nil or script == '' ) then
    CH_Msg( 'Script is empty' );
    return;
  end

  if ( strsub(script,1,8) == "/script " ) then
    script = strsub( script, 9 );
  end
  if ( strsub(script,-1) ~= ";" ) then
    script = script .. ";";
  end

  CH_ScriptUnit = unit;
  RunScript( script );

end

function CH_ActionMenu( extraIdx, mouseButton, unit, clickedUnit )

  local menu = nil;
  local idx = nil;

  if ( string.find(clickedUnit,'target') ) then
    menu = TargetFrameDropDown;
  elseif ( clickedUnit == 'player' ) then
    menu = PlayerFrameDropDown;
  elseif ( clickedUnit == 'pet' ) then
    menu = PetFrameDropDown;
  elseif ( strsub(clickedUnit,1,8) == 'partypet' ) then
    menu = nil;
  elseif ( strsub(clickedUnit,1,5) == 'party' ) then
    _,_,idx = string.find( clickedUnit, '(%d+)' ); 
    menu = getglobal( 'PartyMemberFrame'..idx..'DropDown' );
    this:SetID( idx );
  elseif ( strsub(clickedUnit,1,4) == 'raid' ) then
    -- nop
  end

  if ( menu ) then
    menu.unit = clickedUnit;
    menu.name = CH_UnitName( clickedUnit );
    ToggleDropDownMenu( 1, nil, menu, 'cursor' );
  end

end

function CH_ActionTooltip( extraIdx, mouseButton, unit )

  if ( CH_Config.dockTarget == 'RIGHT' ) then
    CH_TooltipShow( this.index, unit, 'UNIT', this, 'ANCHOR_BOTTOMRIGHT' );
  else
    CH_TooltipShow( this.index, unit, 'UNIT', this, 'ANCHOR_BOTTOMLEFT' );
  end

end

-- ==========================================================================================================================
-- TOOLTIPS
-- ==========================================================================================================================

local function CHL_TooltipShowBuffs( unit, dockRelative )

  local buffFrame, buffTexture, buffApplications;
  local buffName, buffIdx, buffRemainTime, buffRemainUnit;
  local frame;
  local i = 1;

  CH_TooltipBuffs.dockRelative = (dockRelative or CH_TooltipBuffs.dockRelative);

  buffTexture,buffApplications = UnitBuff( unit, i );
  while ( buffTexture and getglobal('CH_TooltipBuff'..i..'Icon') ) do
    getglobal('CH_TooltipBuff'..i..'Icon'):SetTexture( buffTexture );
--    if ( buffApplications < 2 ) then
--      getglobal('CH_TooltipBuff'..i..'Applications'):SetText( '' );
--    else
--      getglobal('CH_TooltipBuff'..i..'Applications'):SetText( buffApplications );
--    end

    CH_TooltipSetUnitBuff( unit, i );
    buffName = CH_TooltipGetTitle();
    buffIdx = CHL_BuffNameToEffect( buffName );
    if ( buffIdx ) then
      _,buffRemainTime,buffRemainUnit = CHL_EffectRemainingTime( unit, buffIdx );
    else
      buffRemainTime = '';
    end
    frame = getglobal('CH_TooltipBuff'..i..'Applications');
    frame:SetText( buffRemainTime );

    getglobal('CH_TooltipBuff'..i):Show();
    i = i + 1;
    buffTexture,buffApplications = UnitBuff( unit, i );
  end

  if ( i > 1 ) then
    CH_TooltipBuffs:ClearAllPoints();
    CH_TooltipBuffs:SetPoint( CHL_MirrorAnchor(CH_TooltipBuffs.dockRelative,'V'), GameTooltip, CH_TooltipBuffs.dockRelative, 0, -2 );
    CH_TooltipBuffs:SetWidth( 5*2 + 15*(i-1) );
    CH_TooltipBuffs:Show();
  else
    CH_TooltipBuffs:Hide();
  end

  buffFrame = getglobal( 'CH_TooltipBuff'..i );
  while ( buffFrame and buffFrame:IsVisible() ) do
    buffFrame:Hide();
    i = i + 1;
    buffFrame = getglobal( 'CH_TooltipBuff'..i );
  end

end

local function CHL_TooltipShowDebuffs( unit, dockRelative )

  local debuffFrame, debuffTexture, debuffApplications;
  local i = 1;
  local point,relativePoint = 'BOTTOMLEFT','TOPLEFT';

  CH_TooltipDebuffs.dockRelative = (dockRelative or CH_TooltipDebuffs.dockRelative);

  debuffTexture,debuffApplications = UnitDebuff( unit, i );
  while ( debuffTexture and getglobal('CH_TooltipDebuff'..i..'Icon') ) do
    getglobal('CH_TooltipDebuff'..i..'Icon'):SetTexture( debuffTexture );
    if ( debuffApplications < 2 ) then
      getglobal('CH_TooltipDebuff'..i..'Applications'):SetText( '' );
    else
      getglobal('CH_TooltipDebuff'..i..'Applications'):SetText( debuffApplications );
    end
    getglobal('CH_TooltipDebuff'..i):Show();
    i = i + 1;
    debuffTexture,debuffApplications = UnitDebuff( unit, i );
  end

  if ( i > 1 ) then
    CH_TooltipDebuffs:ClearAllPoints();
    if ( CH_TooltipBuffs:IsVisible() ) then
      CH_TooltipDebuffs:SetPoint( CHL_MirrorAnchor(CH_TooltipBuffs.dockRelative,'V'), CH_TooltipBuffs, CH_TooltipDebuffs.dockRelative, 0, -4 );
    else
      CH_TooltipDebuffs:SetPoint( CHL_MirrorAnchor(CH_TooltipBuffs.dockRelative,'V'), GameTooltip, CH_TooltipDebuffs.dockRelative, 0, -2 );
    end
    CH_TooltipDebuffs:SetWidth( 5*2 + 15*(i-1) );
    CH_TooltipDebuffs:Show();
  else
    CH_TooltipDebuffs:Hide();
  end

  debuffFrame = getglobal( 'CH_TooltipDebuff'..i );
  while ( debuffFrame and debuffFrame:IsVisible() ) do
    debuffFrame:Hide();
    i = i + 1;
    debuffFrame = getglobal( 'CH_TooltipDebuff'..i );
  end

end

function CHL_TooltipRelativeTo( extraIdx )

  if ( CH_Config.frameGroupMode == 'GROUP' ) then
    return( CH_AnchorDockTooltipTo('TOP','Party') );
  elseif ( CH_Config.extra1Hidden and CH_Config.extra2Hidden ) then
    return( getglobal('CH_Extra'..(extraIdx+2)..'Frame') );
  end

  return( getglobal('CH_Extra'..(extraIdx)..'Frame') );

end

function CH_TooltipShow( unit, frameIndex, position, dockFrame, anchor )

  local nlAnchor, nlAnchorID;
  local isMTTTarget;
  local showTooltip = true;
  local dockBuffsRelative = 'TOPLEFT';
  local isTarget, relativeTo, subgroup;
  local isRaid = (strsub(this:GetName(),1,7) == 'CH_Raid');
  local isMTT = (strsub(this:GetName(),1,5) == 'CH_MT');
  local isNL = (strsub(this:GetName(),1,12) == 'CH_NeedyList');

  if ( not CH_TooltipFrameIndex or frameIndex ~= CH_TooltipFrameIndex ) then	-- not inside one of my units frames or wrong frame
    return;
  end

  if ( (not unit) or CH_Config.unitTooltipInfo == 'NEVER' or strsub(unit,1,5) == 'Extra' or unit == 'Panic' or (not UnitExists(unit)) or
       CH_UnitClass(unit) == 'UNKNOWN' ) 
  then
    return;
  end

  if ( position == 'UNIT' ) then
    showTooltip = true;
  elseif ( isMTT and CH_Config.mainTankTooltipInfo == 'HIDE' ) then
    showTooltip = false;
  elseif ( isRaid and CH_Config.raidTooltipInfo == 'HIDE' ) then
    showTooltip = false;
  elseif ( isNL ) then
    nlAnchor = CH_GetFrameVari(this,'chNeedyListAnchor');
    if ( CH_Config[nlAnchor.chNeedyListConf..'TooltipInfo'] == 'HIDE' ) then
      showTooltip = false;
    end
  elseif ( CH_Config.unitTooltipInfo == 'ALWAYS' ) then
    showTooltip = true;
  else
    if ( string.find(CH_Config.unitTooltipInfo,'SHIFT') and (not IsShiftKeyDown()) ) then
      showTooltip = false;
    end
    if ( string.find(CH_Config.unitTooltipInfo,'CTRL') and (not IsControlKeyDown()) ) then
      showTooltip = false;
    end
    if ( string.find(CH_Config.unitTooltipInfo,'ALT') and (not IsAltKeyDown()) ) then
      showTooltip = false;
    end
  end

  isTarget = string.find( frameIndex, 'target' );

  if ( showTooltip ) then
    -- ----- unit
    if ( position == 'UNIT' ) then
      GameTooltip:SetOwner( dockFrame, anchor, 0, 0 );
    -- ----- standard WoW location
    elseif ( (isMTT and CH_Config.mainTankTooltipInfo == 'WOW') or
             (isNL and CH_Config[CH_GetFrameVari(this,'chNeedyListAnchor').chNeedyListConf..'TooltipInfo'] == 'WOW') or
             (isRaid and CH_Config.raidTooltipInfo == 'WOW') or
             ( (not isMTT) and (not isNL) and (not isRaid) and CH_Config.unitTooltipLocation == 'WOW') )
    then
      GameTooltip_SetDefaultAnchor( GameTooltip, UIParent );
    -- ----- MainTanks
    elseif ( isMTT and CH_Config.mainTankTooltipInfo ~= 'MAIN' ) then
      isMTTTarget = string.find( this:GetName(), 'target' );
      GameTooltip:SetOwner( this, 'ANCHOR_NONE' );
      if ( isMTTTarget and CH_Config.mainTankTooltipInfo == 'TOP' and CH_Anchor.MainTank.grow == 'DOWN' ) then
        GameTooltip:SetPoint( 'BOTTOM', CH_MTAnchor.targetTopFrame, 'TOP', 0, 10 );
      elseif ( isMTTTarget and CH_Config.mainTankTooltipInfo == 'TOP' and CH_Anchor.MainTank.grow == 'UP' ) then
        GameTooltip:SetPoint( 'BOTTOM', CH_MTAnchor.targetBottomFrame, 'TOP', 0, 10 );
      elseif ( CH_Config.mainTankTooltipInfo == 'TOP' and CH_Anchor.MainTank.grow == 'DOWN' ) then
        GameTooltip:SetPoint( 'BOTTOM', CH_MTAnchor.topFrame, 'TOP', 0, 10 );
      elseif ( CH_Config.mainTankTooltipInfo == 'TOP' and CH_Anchor.MainTank.grow == 'UP' ) then
        GameTooltip:SetPoint( 'BOTTOM', CH_MTAnchor.bottomFrame, 'TOP', 0, 10 );
      elseif ( isMTTTarget and CH_Config.mainTankTooltipInfo == 'BOTTOM' and CH_Anchor.MainTank.grow == 'DOWN' ) then
        GameTooltip:SetPoint( 'TOP', CH_MTAnchor.targetBottomFrame, 'BOTTOM', 0, 0 );
      elseif ( isMTTTarget and CH_Config.mainTankTooltipInfo == 'BOTTOM'  and CH_Anchor.MainTank.grow == 'UP') then
        GameTooltip:SetPoint( 'TOP', CH_MTAnchor.targetTopFrame, 'BOTTOM', 0, 0 );
      elseif ( CH_Config.mainTankTooltipInfo == 'BOTTOM' and CH_Anchor.MainTank.grow == 'DOWN' ) then
        GameTooltip:SetPoint( 'TOP', CH_MTAnchor.bottomFrame, 'BOTTOM', 0, 0 );
      elseif ( CH_Config.mainTankTooltipInfo == 'BOTTOM' and CH_Anchor.MainTank.grow == 'UP' ) then
        GameTooltip:SetPoint( 'TOP', CH_MTAnchor.topFrame, 'BOTTOM', 0, 0 );
      elseif ( isMTTTarget and CH_Config.mainTankTooltipInfo == 'LEFT' ) then
        GameTooltip:SetPoint( 'RIGHT', CH_GetFrameVari(this,'chSisterFrame'), 'LEFT', 0, 0 );
      elseif ( CH_Config.mainTankTooltipInfo == 'LEFT' ) then
        GameTooltip:SetPoint( 'RIGHT', this, 'LEFT', 0, 0 );
      elseif ( (not isMTTTarget) and CH_Config.mainTankTooltipInfo == 'RIGHT' ) then
        GameTooltip:SetPoint( 'LEFT', CH_GetFrameVari(this,'chSisterFrame'), 'RIGHT', 0, 0 );
      elseif ( CH_Config.mainTankTooltipInfo == 'RIGHT' ) then
        GameTooltip:SetPoint( 'LEFT', this, 'RIGHT', 0, 0 );
      end
      if ( CH_Config.mainTankTooltipInfo == 'BOTTOM' ) then
        dockBuffsRelative = 'BOTTOMLEFT';
      end
    -- ----- NeedyList
    elseif ( isNL and CH_Config[CH_GetFrameVari(this,'chNeedyListAnchor').chNeedyListConf..'TooltipInfo'] ~= 'MAIN' ) then
      nlAnchorID = CH_AnchorFrameNameToID( nlAnchor:GetName() );
      GameTooltip:SetOwner( this, 'ANCHOR_NONE' );
      if ( CH_Config[nlAnchor.chNeedyListConf..'TooltipInfo'] == 'TOP' ) then
        GameTooltip:SetPoint( 'BOTTOM', CH_AnchorDockTooltipTo('TOP',nlAnchorID), 'TOP', 0, 10 );
      elseif ( CH_Config[nlAnchor.chNeedyListConf..'TooltipInfo'] == 'RIGHT' ) then
        GameTooltip:SetPoint( 'LEFT', this, 'RIGHT', 0, 0 );
      elseif ( CH_Config[nlAnchor.chNeedyListConf..'TooltipInfo'] == 'BOTTOM' ) then
        GameTooltip:SetPoint( 'TOP', CH_AnchorDockTooltipTo('BOTTOM',nlAnchorID), 'BOTTOM', 0, 0 );
      elseif ( CH_Config[nlAnchor.chNeedyListConf..'TooltipInfo'] == 'LEFT' ) then
        GameTooltip:SetPoint( 'RIGHT', this, 'LEFT', 0, 0 );
      end
      if ( CH_Config[nlAnchor.chNeedyListConf..'TooltipInfo'] == 'BOTTOM' ) then
        dockBuffsRelative = 'BOTTOMLEFT';
      end
    -- ----- Raid
    elseif ( isRaid and (not isMTT) and CH_Config.raidTooltipInfo ~= 'MAIN' ) then
      GameTooltip:SetOwner( CH_Raid1Unit1Frame, 'ANCHOR_NONE' );
      GameTooltip:ClearAllPoints();
      if ( not UnitIsPlayer(unit) ) then					-- raid pets
        if ( CH_Config.raidTooltipInfo == 'BOTTOM' ) then
          relativeTo = CH_AnchorDockTooltipTo( 'BOTTOM', 'RaidPets' );
	  dockBuffsRelative = 'BOTTOMLEFT';
        elseif ( CH_Config.raidTooltipInfo == 'TOP' ) then
          relativeTo = CH_AnchorDockTooltipTo( 'TOP', 'RaidPets' );
	else
          relativeTo = this;
        end
      elseif ( strsub(this:GetName(),1,16) == 'CH_RaidClassUnit' ) then		-- raid classes
        if ( CH_Config.raidTooltipInfo == 'BOTTOM' ) then
          relativeTo = CH_AnchorDockTooltipTo( 'BOTTOM', CH_AnchorFrameNameToID('CH_Raid'..CH_UnitClass(unit)..'Anchor') );
	  dockBuffsRelative = 'BOTTOMLEFT';
        elseif ( CH_Config.raidTooltipInfo == 'TOP' ) then
          relativeTo = CH_AnchorDockTooltipTo( 'TOP', CH_AnchorFrameNameToID('CH_Raid'..CH_UnitClass(unit)..'Anchor') );
	else
          relativeTo = this;
        end
      else									-- raid groups
        _,_,subgroup = GetRaidRosterInfo( strsub(frameIndex,5) );
        if ( CH_Config.raidTooltipInfo == 'BOTTOM' ) then
          relativeTo = CH_AnchorDockTooltipTo( 'BOTTOM', CH_AnchorFrameNameToID('CH_Raid'..subgroup..'Anchor') );
	  dockBuffsRelative = 'BOTTOMLEFT';
        elseif ( CH_Config.raidTooltipInfo == 'TOP' ) then
          relativeTo = CH_AnchorDockTooltipTo( 'TOP', CH_AnchorFrameNameToID('CH_Raid'..subgroup..'Anchor') );
	else
          relativeTo = this;
        end
      end
      if ( CH_Config.raidTooltipInfo == 'TOP' ) then
        GameTooltip:SetPoint( 'BOTTOM', relativeTo, 'TOP', 0, 10 );
      elseif ( CH_Config.raidTooltipInfo == 'RIGHT' ) then
        GameTooltip:SetPoint( 'LEFT', relativeTo, 'RIGHT', 0, 0 );
      elseif ( CH_Config.raidTooltipInfo == 'BOTTOM' ) then
        GameTooltip:SetPoint( 'TOP', relativeTo, 'BOTTOM', 0, 0 );
      elseif ( CH_Config.raidTooltipInfo == 'LEFT' ) then
        GameTooltip:SetPoint( 'RIGHT', relativeTo, 'LEFT', 0, 0 );
      end
    -- ----- Main frame, align RIGHT
    elseif ( CH_Config.dockTarget == 'RIGHT' ) then
      if ( isTarget ) then
        GameTooltip:SetOwner( CHL_TooltipRelativeTo(2), 'ANCHOR_RIGHT', 0, 10 );
      else
        GameTooltip:SetOwner( CHL_TooltipRelativeTo(1), 'ANCHOR_TOPLEFT', 0, 10 );
      end
    -- ----- Main frame, align LEFT
    else
      if ( isTarget ) then
        GameTooltip:SetOwner( CHL_TooltipRelativeTo(1), 'ANCHOR_LEFT', 0, 10 );
      else
        GameTooltip:SetOwner( CHL_TooltipRelativeTo(2), 'ANCHOR_TOPRIGHT', 0, 10 );
      end
    end

    GameTooltip:SetScale( CH_Config.unitTooltipScale / 100 );
    GameTooltip:SetUnit( unit );

    CHL_TooltipShowBuffs( unit, dockBuffsRelative );
    CHL_TooltipShowDebuffs( unit, dockBuffsRelative );

    CH_TooltipVisible = true;
  end

end

function CH_TooltipRefresh( unit, frameIndex )

  if ( not CH_TooltipFrameIndex or frameIndex ~= CH_TooltipFrameIndex ) then
    return;
  end

  if ( CH_TooltipVisible == true ) then
    CHL_TooltipShowBuffs( unit );
    CHL_TooltipShowDebuffs( unit );
  else
    CH_TooltipShow( unit, frameIndex, 'GLOBAL' );
  end

end

function CH_TooltipTargetChanged()

  if ( CH_TooltipVisible == true ) then
    GameTooltip:SetUnit( 'target' );
    CHL_TooltipShowBuffs( 'target' );
    CHL_TooltipShowDebuffs( 'target' );
  end

end

function CH_TooltipHide()

  GameTooltip:Hide();
  CH_TooltipBuffs:Hide();
  CH_TooltipDebuffs:Hide();

  CH_TooltipVisible = false;

end

-- ==========================================================================================================================
-- TOOLTIP ACTIONS
-- ==========================================================================================================================

function CH_TooltipActionToString( actionType, mb, unit )

  local colorR,colorG,colorB = 1,1,1;
  local txt, spellName, spellRank;
  local actionID = CH_MouseSpells[actionType][mb];
  local spellRankString = nil;
  local spellID = nil;

  if ( not actionID ) then
    txt = '';
  elseif ( actionID and (not CH_ActionList[actionID]) ) then
    txt = CHT_LABEL_ACTION_ID_UNKNOWN;
  elseif ( actionID == 'SPELL' or actionID == 'QUICK' or actionID == 'SLOW' or actionID == 'HOT' or actionID == 'SHIELD' ) then
    if ( actionID == 'SPELL' ) then
      spellName = CH_MouseSpellsData[actionType][mb].spellName;
      if ( spellName ~= 'None' ) then
        spellRankString = CH_MouseSpellsData[actionType][mb].spellRank;
        spellID = CH_GetSpellID( spellName, nil, BOOKTYPE_SPELL, false );
        txt = spellName;
      else
        txt = '';
      end
    else
      spellName = CH_Spells[actionID].spellName;
      spellRankString = 'MAX';
      spellID = CH_Spells[actionID].spellBookIdx;
      txt = CH_ACTION_TYPE_TEXT[actionID];
    end
      
    if ( spellName ~= 'None' ) then
      if ( CH_Config.actionsTooltipShowSpellRank ) then
        if ( CH_Config.actionsTooltipSpellRankShowMax or spellRankString ~= 'MAX' ) then
          txt = txt .. " ("..strlower(spellRankString)..")";
        end
      end
      if ( spellName == gCSName ) then								-- current cast
        colorR,colorG,colorB = CH_COLOR.SKYBLUE.r,CH_COLOR.SKYBLUE.g,CH_COLOR.SKYBLUE.b;
      elseif ( CH_ActionBar[spellName] and IsCurrentAction(CH_ActionBar[spellName].slot) ) then
        colorR,colorG,colorB = CH_COLOR.ORANGE.r,CH_COLOR.ORANGE.g,CH_COLOR.ORANGE.b;
      else
        if ( unit == 'target' and spellName and CH_ActionBar[spellName] and IsActionInRange(CH_ActionBar[spellName].slot) == 0 ) then	-- oor check
          txt = txt .. ' ['..CH_LABEL_OUT_OF_RANGE..']';
          colorR,colorG,colorB = 1,0,0;
        end
        if ( spellID > 0 ) then														-- cooldown check
          local cdStart,cdDuration = GetSpellCooldown( spellID, BOOKTYPE_SPELL );
          if ( cdStart > 0 and cdDuration > 0 ) then
            cdRemain = cdStart + cdDuration - GetTime();
            if ( cdRemain >= 60 ) then
              cdRemain = ceil(cdRemain/60)..CHT_LABEL_TIME_M;
            else
              cdRemain = ceil(cdRemain)..CHT_LABEL_TIME_S;
            end
            txt = txt .. " ["..cdRemain.."]";
            colorR,colorG,colorB = 1,0,0;
          end
        end
        if ( CH_ActionBar[spellName] and (not IsUsableAction(CH_ActionBar[spellName].slot)) ) then
          colorR,colorG,colorB = 1,0,0;
        end
      end
    end
  elseif ( actionID == 'BUFF' ) then
    txt = CH_ACTION_TYPE_TEXT[actionID]..' ('..CHH_BuffDropdownValues()[CH_MouseSpellsData[actionType][mb]]..')';
  elseif ( actionID == 'GRPBUFF' ) then
    txt = CH_ACTION_TYPE_TEXT[actionID]..' ('..CHH_GrpBuffDropdownValues()[CH_MouseSpellsData[actionType][mb]]..')';
  elseif ( actionID == 'USEWAND' ) then
    if ( gWandActionBarSlot >= 0 and IsAutoRepeatAction(gWandActionBarSlot) ) then
      colorR,colorG,colorB = CH_COLOR.ORANGE.r,CH_COLOR.ORANGE.g,CH_COLOR.ORANGE.b;
    end
    txt = CH_ACTION_TYPE_TEXT[actionID];
  elseif ( actionID == 'PETSPELL' ) then
    txt = 'Pet: '..CH_MouseSpellsData[actionType][mb].spellName;
  elseif ( actionID == 'ANYITEM' ) then
    txt = CH_ACTION_TYPE_TEXT[actionID]..': '..CH_MouseSpellsData[actionType][mb][1];
  elseif ( actionID == 'CHAIN' or actionID == 'TOTEMSET' ) then
    txt = CH_ACTION_TYPE_TEXT[actionID]..' '..CH_MouseSpellsData[actionType][mb];
  elseif ( CH_ActionList[actionID].plugin ) then
    txt,colorR,colorG,colorB = CH_ActionList[actionID].plugin:GetTooltipInfo( actionID, CH_MouseSpellsData[actionType][mb], unit );
    colorR = colorR or 1;
    colorG = colorG or 1;
    colorB = colorB or 1;
  elseif ( CH_ACTION_TYPE_TEXT[actionID] ) then
    txt = CH_ACTION_TYPE_TEXT[actionID];
  else
    txt = actionID;
  end

  return txt,colorR,colorG,colorB;

end

function CHL_TooltipActionsRelativeTo( isExtra )

  -- extra or panic button
  if ( isExtra ) then
    if ( CH_Config.frameGroupMode == 'GROUP' ) then
      return( CH_PanicFrame );
    else
      return( CH_MainBottomAnchor );
    end
  -- unit button (player, party, pet, partypet)
  else
    if ( CH_Config.frameGroupMode == 'GROUP' ) then
      if ( CH_Anchor.Party.grow == 'DOWN' ) then
        return( CH_PartyBottomAnchor );
      else
        return( CH_PartyAnchor );
      end
    else
      return( CH_MainBottomAnchor );
    end
  end

end

function CH_TooltipActionsShow( unit, frameIndex )

  local actionType, mouseButton, mb, txt, relativeTo;
  local colorR,colorG,colorB = 1,1,1;

  if ( not frameIndex or CH_Config.actionsTooltipInfo == 'NEVER' ) then
    return;
  end

  if ( strsub(frameIndex,1,5) == 'Extra' ) then
    actionType = frameIndex;
    relativeTo = CHL_TooltipActionsRelativeTo( true );
  elseif ( frameIndex == 'Panic' ) then
    actionType = 'Panic';
    relativeTo = CHL_TooltipActionsRelativeTo( true );
  elseif ( unit == nil ) then
    return;
  elseif ( UnitCanAttack('player',unit) ) then
    actionType = 'Enemy'..(CH_GetShapeshiftFormIdx(unit) or '');
    relativeTo = CHL_TooltipActionsRelativeTo( false );
  else
    actionType = 'Friend';
    relativeTo = CHL_TooltipActionsRelativeTo( false );
  end

  for _,mouseButton in CH_MOUSE_BUTTONS do
    mb = CH_BuildMouseButton( mouseButton );
    txt,colorR,colorG,colorB = CH_TooltipActionToString( actionType, mb, unit );

    getglobal('CH_TooltipActions'..mouseButton):SetText( CH_MOUSE_BUTTONS_ABBR_ALL[mb] );
    getglobal('CH_TooltipActions'..mouseButton..'Text'):SetText( txt );
    getglobal('CH_TooltipActions'..mouseButton..'Text'):SetTextColor( colorR, colorG, colorB );
  end

  CH_TooltipActions:ClearAllPoints();
  if ( CH_Config.dockTarget == 'RIGHT' ) then
    CH_TooltipActions:SetPoint( 'TOPLEFT', relativeTo, 'BOTTOMLEFT', 0, 0 );
  else
    CH_TooltipActions:SetPoint( 'TOPRIGHT', relativeTo, 'BOTTOMRIGHT', 0, 0 );
  end

  CH_TooltipActions:SetScale( CH_Config.actionsTooltipScale / 100 );
  CH_TooltipActions:Show();

end

function CH_TooltipActionsRefresh( unit, frameIndex )

  if ( CH_TooltipFrameIndex and frameIndex == CH_TooltipFrameIndex and CH_TooltipActions:IsVisible() ) then
    CH_TooltipActionsShow( unit, frameIndex );
  end

end

function CH_TooltipActionsHide()

  CH_TooltipActions:Hide();

end

-- ==========================================================================================================================
-- TOOLTIP HINTS
-- ==========================================================================================================================

function CH_HintTooltipShow( frame, option, x, y, msg )

  if ( not msg ) then
    msg = CH_DefaultConfig[option].hint;
  end

  GameTooltip:SetOwner( frame, 'ANCHOR_TOPLEFT', x, y );
  GameTooltip:AddLine( msg, nil, nil, nil, 1 );
  GameTooltip:SetScale( CH_Config.hintTooltipScale / 100 );
  GameTooltip:Show();

end

function CH_HintTooltipHide()

  GameTooltip:Hide();

end

-- ==========================================================================================================================
-- (SPELL) Chains
-- ==========================================================================================================================

local function CHL_ChainLineIncrease( chainIdx )

  local oldLine = CH_ChainData[chainIdx].nextLine;

  -- ----- "loop"?
  if ( CH_ChainData[chainIdx].nextLine > 0 ) then
    mb = CH_MOUSE_BUTTONS_ALL[CH_ChainData[chainIdx].nextLine];
    if ( CH_ChainData[chainIdx][mb] and CH_ChainData[chainIdx][mb].condition ~= 'NONE' and CH_ChainData[chainIdx][mb].frequency == 'LOOP' ) then
      return( true );
    end
  end

  -- ----- increase
  CH_ChainData[chainIdx].nextLine = CH_ChainData[chainIdx].nextLine + 1;
  mb = CH_MOUSE_BUTTONS_ALL[CH_ChainData[chainIdx].nextLine];
  while ( CH_ChainData[chainIdx].nextLine ~= oldLine and 
          ((not CH_ChainData[chainIdx][mb]) or CH_ChainData[chainIdx][mb].condition == 'NONE' or (not CH_MouseSpells[chainIdx][mb])) ) 
  do
    if ( CH_ChainData[chainIdx].nextLine == CH_MAX_LINES_CHAIN and oldLine == 0 ) then
      CH_ChainData[chainIdx] = nil;				-- reset/empty the whole chain
      return( false );
    elseif ( CH_ChainData[chainIdx].nextLine == CH_MAX_LINES_CHAIN ) then
      CH_ChainData[chainIdx].nextLine = 1;
    else
      CH_ChainData[chainIdx].nextLine = CH_ChainData[chainIdx].nextLine + 1;
    end
    mb = CH_MOUSE_BUTTONS_ALL[CH_ChainData[chainIdx].nextLine];
  end

  return( true );

end

local function CHL_ChainProcessLine( chainIdx, mb, unit )

  local actionType = CH_MouseSpells[chainIdx][mb];

--  CH_Debug( 'DBG: Chain '..mb..': Doing '..(actionType or 'NIL') );

  if ( actionType == nil ) then
    CH_Debug( 'No spell assigned to: '..mb, CH_DEBUG_NOTICE );
  elseif ( actionType == 'SPELL' ) then
    if ( unit and UnitIsFriend('player',unit) ) then
      CH_CastSpellOnFriend( CH_MouseSpellsData[chainIdx][mb].spellName, CH_MouseSpellsData[chainIdx][mb].spellRank, unit, 'SPELL' );
    else
      CH_CastSpellOnEnemy( CH_MouseSpellsData[chainIdx][mb].spellName, CH_MouseSpellsData[chainIdx][mb].spellRank, unit, 'SPELL' );
    end
  elseif ( actionType == 'PETSPELL' ) then
    CH_CastSpellOnEnemy( CH_MouseSpellsData[chainIdx][mb].spellName, nil, unit, 'PETSPELL' );
  elseif ( CH_ActionList[actionType].plugin ) then							-- plugin call
    CH_ActionList[actionType].plugin:Callback( unit, CH_MouseSpellsData[chainIdx][mb], actionType );
  elseif ( CH_ActionList[actionType].func ~= nil ) then
    CH_ActionList[actionType].func( chainIdx, mb, unit );
  else
    CH_Debug( 'ELSE in CHL_ChainProcessLine()', CH_DEBUG_ERROR );
  end

end

function CH_ChainResetNextLine()

  local i;

  for i=1,CH_MAX_CHAINS do
    chainIdx = 'Chain'..i;
    if ( CH_ChainData[chainIdx] ) then
      CH_ChainData[chainIdx].nextLine = nil;
    end
  end

end

function CH_ActionProcessChain( extraIdx, mouseButton, unit )

  local chainIdx = 'Chain'..CH_MouseSpellsData[extraIdx][mouseButton];
  local i = 1;
  local mb;
  local prevLine;

  if ( not CH_ChainData[chainIdx] ) then
    CH_Msg( 'This chain is not set up' );
    return;
  end

  if ( not CH_ChainData[chainIdx].nextLine ) then
    CH_ChainData[chainIdx].nextLine = 0;
-- Check if chain is empty!
    if ( not CHL_ChainLineIncrease(chainIdx) ) then
      CH_Msg( chainIdx..' is empty.' );
      return;
    end
  end

  -- ----- check if there are spells to refresh
  while ( i <= CH_MAX_LINES_CHAIN and i < CH_ChainData[chainIdx].nextLine ) do
    mb = CH_MOUSE_BUTTONS_ALL[i];
    if ( CH_ChainData[chainIdx][mb] ) then
      if ( CH_ChainData[chainIdx][mb].frequency == 'REFRESH' and CH_MouseSpells[chainIdx][mb] == 'SPELL' and
          (not CH_UnitHasDebuff(unit,CH_MouseSpellsData[chainIdx][mb].spellName,true)) ) 			-- can only refresh spells (atm)
      then
        CHL_ChainProcessLine( chainIdx, mb, unit );
        return;
      end
    end
    i = i + 1;
  end

  -- ----- process current line
  mb = CH_MOUSE_BUTTONS_ALL[CH_ChainData[chainIdx].nextLine];
  CHL_ChainProcessLine( chainIdx, mb, unit );

  -- ----- increase line
  prevLine = CH_ChainData[chainIdx].nextLine;
  CHL_ChainLineIncrease( chainIdx );
  mb = CH_MOUSE_BUTTONS_ALL[CH_ChainData[chainIdx].nextLine];
  while ( CH_ChainData[chainIdx][mb].condition == 'AND' and CH_ChainData[chainIdx].nextLine > prevLine ) do	-- did it increase (e.g. no LOOP)
    CHL_ChainProcessLine( chainIdx, mb, unit );
    prevLine = CH_ChainData[chainIdx].nextLine;
    CHL_ChainLineIncrease( chainIdx );
    mb = CH_MOUSE_BUTTONS_ALL[CH_ChainData[chainIdx].nextLine];
  end

end

-- ==========================================================================================================================
-- CTRA (CT Raid) Support
-- ==========================================================================================================================

function CH_CTRAClicked( button, unit )

  return( CH_UnitClicked(unit,button) );

end

function CH_CTRASetMT( id )

  gOriginalFunction['CT_RATarget_SetMT']( id );
  CH_AdjustMainTankFrames();
  CH_NeedyListRegisterWipe( 'HEAL', false );

end

function CH_CTRARemoveMT( id )

  gOriginalFunction['CT_RATarget_RemoveMT']( id );
  CH_AdjustMainTankFrames();
  CH_NeedyListRegisterWipe( 'HEAL', false );

end

-- ==========================================================================================================================
-- ORA Support
-- ==========================================================================================================================

function CH_ORAClicked( button, unit )

  return( CH_UnitClicked(unit,button) );

end

-- ==========================================================================================================================
-- NeedyList Addon Support
-- ==========================================================================================================================

function CH_NeedyListAddonClicked( button, frame )

  return( CH_UnitClicked(frame.Unit,button) );

end

-- ==========================================================================================================================
-- DUF (Discord Unit Frames) Support
-- ==========================================================================================================================

function CH_DUFClicked( button )

  if ( this.moving ) then
    DUF_Element_OnDragStop();
  end

  return( CH_UnitClicked(this.unit or this:GetParent().unit,button) );

end

-- ==========================================================================================================================
-- External interface (API), both for mouse click or macros
-- ==========================================================================================================================

function CH_HealNeediest( )				-- also called by Key binding!!!

  if ( CH_Config.checkHealRange == 'ONHWEVENT' ) then
    CHL_HealRangeScan();
  end

  CHL_PanicHeal();

end
