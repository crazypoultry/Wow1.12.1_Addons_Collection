--=============================================================================
-- File:	CH_Extended.lua
-- Author:	rudy
-- Description:	Help pages and config
--=============================================================================

CHH_ExtendedNeedyListEnabledOptions   = {{key='ALWAYS',      label=CHHT_EXTENDED_NEEDY_LIST_ENABLED_ALWAYS},
                                         {key='PARTY',       label=CHHT_EXTENDED_NEEDY_LIST_ENABLED_PARTY},
                                         {key='RAID',        label=CHHT_EXTENDED_NEEDY_LIST_ENABLED_RAID},
                                         {key='PARTYRAID',   label=CHHT_EXTENDED_NEEDY_LIST_ENABLED_PARTYRAID},
                                         {key='NEVER',       label=CHHT_EXTENDED_NEEDY_LIST_ENABLED_NEVER}};
CHH_ExtendedNeedyListHideOOROptions   = {{key='NONE',        label=CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR_NONE},
                                         {key='POSSIBLE',    label=CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR_POSSIBLE},
                                         {key='VERIFIED',    label=CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR_VERIFIED}};
CHH_ExtendedNeedyListHealSortOptions  = {{key='UNSORTED',    label=CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_UNSORTED},
                                         {key='LOCKED',      label=CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_LOCKED},
                                         {key='EMERGENCY',   label=CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_EMERGENCY},
                                         {key='EMERGLOCKED', label=CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_EMERGLOCKED}};
CHH_ExtendedNeedyListCureSortOptions  = {{key='UNSORTED',    label=CHHT_EXTENDED_NEEDY_LIST_CURE_SORT_UNSORTED},
                                         {key='LOCKED',      label=CHHT_EXTENDED_NEEDY_LIST_CURE_SORT_LOCKED}};
CHH_ExtendedNeedyListBuffSortOptions  = {{key='UNSORTED',    label=CHHT_EXTENDED_NEEDY_LIST_BUFF_SORT_UNSORTED},
                                         {key='LOCKED',      label=CHHT_EXTENDED_NEEDY_LIST_BUFF_SORT_LOCKED}};
CHH_ExtendedNeedyListDeadSortOptions  = {{key='UNSORTED',    label=CHHT_EXTENDED_NEEDY_LIST_DEAD_SORT_UNSORTED},
                                         {key='LOCKED',      label=CHHT_EXTENDED_NEEDY_LIST_DEAD_SORT_LOCKED}};
CHH_ExtendedRaidShowParty             = {{key='SHOW',        label=CHHT_EXTENDED_RAID_HIDE_PARTY_SHOW},
                                         {key='HIDE',        label=CHHT_EXTENDED_RAID_HIDE_PARTY_HIDE},
                                         {key='WOW',         label=CHHT_EXTENDED_RAID_HIDE_PARTY_WOW}};
CHH_ExtendedTooltipOrientationOptions = {{key='MAIN',        label=CHHT_EXTENDED_TOOLTIP_ORIENTATION_MAIN},
                                         {key='WOW',         label=CHHT_EXTENDED_TOOLTIP_ORIENTATION_WOW},
                                         {key='TOP',         label=CHHT_EXTENDED_TOOLTIP_ORIENTATION_TOP},
                                         {key='BOTTOM',      label=CHHT_EXTENDED_TOOLTIP_ORIENTATION_BOTTOM},
                                         {key='RIGHT',       label=CHHT_EXTENDED_TOOLTIP_ORIENTATION_RIGHT},
                                         {key='LEFT',        label=CHHT_EXTENDED_TOOLTIP_ORIENTATION_LEFT},
                                         {key='HIDE',        label=CHHT_EXTENDED_TOOLTIP_ORIENTATION_HIDE}};

-- ============================================================================
--   Raid
-- ============================================================================

function CHH_ExtendedRaidTab()

  CHH_InitTabs( CHH_Extended, CHH_ExtendedRaid, 'EXTENDED', 'RAID', CHH_ExtendedRaidTab, nil );

end

-- ============================================================================
--   MainTank
-- ============================================================================

function CHH_ExtendedMainTankTab()

  CHH_InitTabs( CHH_Extended, CHH_ExtendedMTPA, 'EXTENDED', 'MAINTANK', CHH_ExtendedMainTankTab, nil );

  for i=1,CH_MAX_MAIN_TANKS do
    UIDropDownMenu_Initialize( getglobal('CHH_ExtendedMTPAMainTankMT'..i), CHH_ExtendedMainTankDropDownInit );
    CHH_ExtendedMainTankLabel( i );
  end

end

function CHH_ExtendedMainTankLabel( idx )

  local frame = getglobal('CHH_ExtendedMTPAMainTankMT'..idx);
  local label = CH_MainTanks[idx];

  if ( label == nil ) then
    label = CHHT_LABEL_NONE;
  elseif ( strsub(label,1,6) == 'CTRAMT' and CT_RA_MainTanks ) then
    label = string.format( CHHT_EXTENDED_MT_CTRA_MT_FORMAT, strsub(label,7), CT_RA_MainTanks[i] or CHHT_LABEL_NONE );
  elseif ( strsub(label,1,6) == 'CTRAPT' and CT_RA_PTargets ) then
    label = string.format( CHHT_EXTENDED_MT_CTRA_PT_FORMAT, strsub(label,7), CT_RA_PTargets[i] or CHHT_LABEL_NONE );
  end

  UIDropDownMenu_SetText( label, frame );
  frame.chMTIdx = idx;

end

function CHH_ExtendedMainTankDropDownInit( level )

  local k,i, raidGroup, subGroup, name;
  local info = {};
  local mtIdx = CHH_GetVari(this,'chMTIdx');
  local values = {};

  if ( level == nil ) then
    level = 1;
  end

  -- ----- level 1 ----------
  if ( level == 1 ) then
    if ( not mtIdx ) then
      return;
    end

    table.insert( values, {label=CHHT_LABEL_NONE,     hasArrow=nil, value={tankName='NONE'}} );
    table.insert( values, {label=UnitName('player'),  hasArrow=nil, value={tankName=CH_UnitName('player')}} );
    if ( CT_RA_MainTanks ) then
      table.insert( values, {label=CHHT_EXTENDED_MT_CTRA_MT, hasArrow=1, value={sectionName='CTRAMT'}} );
    end
    if ( UnitExists('party1') ) then
      table.insert( values, {label=CHHT_LABEL_PARTY, hasArrow=1, value={sectionName='PARTY'}} );
    end
    if ( UnitExists('raid1') ) then
      for i=1,CH_MAX_RAID_GROUPS do
        table.insert( values, {label=string.format(CHHT_LABEL_RAID_GROUP_FORMAT,i), hasArrow=1, value={sectionName='RAID'..i}} );
      end
    end

    for k,_ in values do
      info.text = values[k].label;
      info.checked = nil;
      info.hasArrow = values[k].hasArrow;
      info.func = CHH_ExtendedMainTankDropDownClicked;
      info.value = CH_CloneTable( values[k].value );
      info.value.mtIdx = mtIdx;
      UIDropDownMenu_AddButton(info,level);
    end

    return;
  end

  -- ----- level 2 ----------
  mtIdx = UIDROPDOWNMENU_MENU_VALUE.mtIdx;
  sectionName = UIDROPDOWNMENU_MENU_VALUE.sectionName;

  if ( sectionName == NIL ) then
    CH_Dbg( 'Unknown section name: '..(sectionName or 'NIL'), CH_DEBUG_ERR );
  elseif ( sectionName == 'CTRAMT' ) then
    for i=1,CH_MAX_MAIN_TANKS do
      name = '';
      if ( CT_RA_MainTanks[i] ) then
        name = ' ('..CT_RA_MainTanks[i]..')';
      end
      info.text = string.format( CHHT_EXTENDED_MT_CTRA_MT_FORMAT..name, i );
      info.checked = nil;
      info.func = CHH_ExtendedMainTankDropDownClicked;
      info.value = {mtIdx=mtIdx,tankName='CTRAMT'..i};
      UIDropDownMenu_AddButton(info,level);
    end
  elseif ( sectionName == 'CTRAPT' ) then
    for i=1,CH_MAX_MAIN_TANKS do
      name = '';
      if ( CT_RA_PTargets[i] ) then
        name = ' ('..CT_RA_PTargets[i]..')';
      end
      info.text = string.format( CHHT_EXTENDED_MT_CTRA_PT_FORMAT..name, i );
      info.checked = nil;
      info.func = CHH_ExtendedMainTankDropDownClicked;
      info.value = {mtIdx=mtIdx,tankName='CTRAPT'..i};
      UIDropDownMenu_AddButton(info,level);
    end
  elseif ( sectionName == 'PARTY' ) then
    for i=1,GetNumPartyMembers() do
      info.text = CH_UnitName( 'party'..i );
      info.checked = nil;
      info.func = CHH_ExtendedMainTankDropDownClicked;
      info.value = {mtIdx=mtIdx,tankName=CH_UnitName('party'..i)};
      UIDropDownMenu_AddButton(info,level);
    end
  elseif ( strsub(sectionName,1,4) == 'RAID' ) then
    raidGroup = tonumber( strsub(sectionName,5,5) );
    for i=1,GetNumRaidMembers() do
      _, _, subGroup = GetRaidRosterInfo( i );
      if ( subGroup == raidGroup ) then
        info.text = CH_UnitName( 'raid'..i );
        info.checked = nil;
        info.func = CHH_ExtendedMainTankDropDownClicked;
        info.value = {mtIdx=mtIdx,tankName=CH_UnitName('raid'..i)};
        UIDropDownMenu_AddButton(info,level);
      end
    end
  else
    CH_Dbg( 'Unknown section name: '..(sectionName or 'NIL'), CH_DEBUG_ERR );
  end

end

function CHH_ExtendedMainTankDropDownClicked()

  if ( this.value.tankName == 'NONE' ) then
    CH_MainTanks[this.value.mtIdx] = nil;
  else
    CH_MainTanks[this.value.mtIdx] = this.value.tankName;
  end
  CHH_ExtendedMainTankLabel( this.value.mtIdx );

  CH_AdjustMainTankFrames();
  CH_NeedyListRegisterWipe( 'HEAL', false );

end

-- ============================================================================
--   Needy List Heal
-- ============================================================================

function CHH_ExtendedNeedyListHealInit()

  CHH_InitTabs( CHH_Extended, CHH_ExtendedNeedyListHeal, 'EXTENDED', 'NEEDYLISTHEAL', CHH_ExtendedNeedyListHealInit, nil );

end

-- ============================================================================
--   Needy List Buff
-- ============================================================================

function CHH_ExtendedNeedyListBuffInit()

  CHH_InitTabs( CHH_Extended, CHH_ExtendedNeedyListBuff, 'EXTENDED', 'NEEDYLISTBUFF', CHH_ExtendedNeedyListBuffInit, nil );

end

-- ============================================================================
--   Needy List Cure
-- ============================================================================

function CHH_ExtendedNeedyListCureInit()

  CHH_InitTabs( CHH_Extended, CHH_ExtendedNeedyListCure, 'EXTENDED', 'NEEDYLISTCURE', CHH_ExtendedNeedyListCureInit, nil );

end

-- ============================================================================
--   Needy List Dead
-- ============================================================================

function CHH_ExtendedNeedyListDeadInit()

  CHH_InitTabs( CHH_Extended, CHH_ExtendedNeedyListDead, 'EXTENDED', 'NEEDYLISTDEAD', CHH_ExtendedNeedyListDeadInit, nil );

  CHH_ExtendedNeedyListDeadHideOORMyText:Hide();
  CHH_ExtendedNeedyListDeadHideOOR:Hide();

end
