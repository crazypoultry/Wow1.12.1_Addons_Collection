--=============================================================================
-- File:	CH_Buffs.lua
-- Author:	rudy
-- Description:	Config buffs
--=============================================================================

local gSelectedBuffIdx = 'none';

-- ============================================================================
--   buff config             
-- ============================================================================

local function CHHL_PartyBuffFormat( object, msg, spellName, partySpellName, partySpellType )

  msg = gsub( msg, "#SPELLNAME#", spellName );
  msg = gsub( msg, "#PARTYSPELLNAME#", partySpellName );

  if ( partySpellType == 'BLESSING' ) then
    msg = gsub( msg, "#PARTYSPELLSPEC#", CHHT_LABEL_RAID_LC );
  else
    msg = gsub( msg, "#PARTYSPELLSPEC#", CHHT_LABEL_PARTY_LC );
  end

  object:SetText( msg );

end

local function CHHL_BuffInitClasses( buffIdx )

  local class, classData, classBox, classBoxText;

  for class,classData in CH_BUFF_DATA[buffIdx].classes do
    classBox = getglobal( 'CHH_BuffClass'..class );
    classBoxText = getglobal( 'CHH_BuffClass'..class..'Name' );
    if ( classData > -1 ) then
      if ( CH_BuffData[buffIdx].classes[class] > 0 ) then
        classBox:SetChecked( true );
      else
        classBox:SetChecked( false );
      end
      classBox:Enable();
      classBoxText:SetTextColor( 1, 1, 1 );
    else
      classBox:Disable();
      classBox:SetChecked( false );
      classBoxText:SetTextColor( 0.5, 0.5, 0.5 );
    end
  end

end

local function CHHL_BuffInitUnits( buffIdx )

  local unit, unitData, unitBox, unitBoxText;

  for unit,unitData in CH_BUFF_DATA[buffIdx].units do
    unitBox = getglobal( 'CHH_BuffUnit'..unit );
    unitBoxText = getglobal( 'CHH_BuffUnit'..unit..'Name' );
    if ( unitData > -1 ) then
      if ( CH_BuffData[buffIdx].units[unit] > 0 ) then
        unitBox:SetChecked( true );
      else
        unitBox:SetChecked( false );
      end
      unitBox:Enable();
      unitBoxText:SetTextColor( 1, 1, 1 );
    else
      unitBox:Disable();
      unitBox:SetChecked( false );
      unitBoxText:SetTextColor( 0.5, 0.5, 0.5 );
    end
  end

end

local function CHHL_BuffInitData( buffIdx )

  CHH_BuffData:Show();
  CHH_BuffDataSliderShow( CHH_BuffDataWarnExpire, buffIdx, 'warnTime' );
  CHH_BuffDataSliderShow( CHH_BuffDataRefreshTime, buffIdx, 'refreshTime' );

end

local function CHHL_BuffInitParty( buffIdx )

  if ( CH_BUFF_DATA[buffIdx].partySpellName ) then
    local partySpellName = CH_BUFF_DATA[buffIdx].partySpellName;
    local displayName = CH_BUFF_DATA[buffIdx].displayName;

--    CHH_BuffPartyTitleText:SetText( partySpellName );
    CHHL_PartyBuffFormat( CHH_BuffPartyMissingMyText, CHHT_BUFF_UPGRADE_Q, displayName, partySpellName, CH_BUFF_DATA[buffIdx].partySpellType );
    CHHL_PartyBuffFormat( CHH_BuffPartyUpgradeMyText, CHHT_BUFF_UPGRADE_MSG, displayName, partySpellName, CH_BUFF_DATA[buffIdx].partySpellType );

    UIDropDownMenu_Initialize( CHH_BuffPartyMissing, CHH_BuffPartyMissingInit );
    CHH_BuffPartyUpgrade:SetChecked( CH_BuffData[buffIdx].partySpellUpgrade );
    CHH_BuffPartyInBattlefield:SetChecked( CH_BuffData[buffIdx].partySpellInBattlefield );

    CHH_BuffParty:Show();
  else
    CHH_BuffParty:Hide();
  end

end

local function CHHL_BuffHighlightSelected( buffIdx )

  local box, lBuffIdx;
  local i = 1;

  box = getglobal('CHH_BuffListBuff'..i);
  lBuffIdx = CHH_GetVari( box, "buffIdx" );
  while ( lBuffIdx and lBuffIdx ~= 'none' ) do
    if ( lBuffIdx == buffIdx ) then
      getglobal(box:GetName().."Background"):Show();
    else
      getglobal(box:GetName().."Background"):Hide();
    end
    i = i + 1;
    box = getglobal('CHH_BuffListBuff'..i);
    lBuffIdx = CHH_GetVari( box, "buffIdx" );
  end

end

local function CHHL_BuffInitAll()

  local buffIdx, buffData, buffButtonText, buffCheck, i, frame;

  i = 1;
  for _,buffIdx in CH_BuffPriority do
    buffData = CH_BuffData[buffIdx];
    frame = getglobal( 'CHH_BuffListBuff'..i );
    buffButtonText = getglobal( 'CHH_BuffListBuff'..i..'ButtonText' );
    buffCheck = getglobal( 'CHH_BuffListBuff'..i..'Check' );
    buffButtonText:SetText( CH_BUFF_DATA[buffIdx].displayName );
    buffCheck:SetChecked( buffData.enabled );
    if ( CH_BuffData[buffIdx].castable ) then
      buffButtonText:SetTextColor( 0, 1, 0 );
      buffCheck:Enable();
    else
      buffButtonText:SetTextColor( 1, 0, 0 );
      buffCheck:Disable();
    end
    frame.buffIdx = buffIdx;
    if ( gSelectedBuffIdx == 'none' ) then
      gSelectedBuffIdx = buffIdx;
    end
    i = i + 1;
  end

  while ( i <= CH_MAX_BUFFS ) do
    frame = getglobal( 'CHH_BuffListBuff'..i );
    frame:Hide();
    frame.buffIdx = 'none';
    i = i + 1;
  end

  CHHL_BuffInitClasses( gSelectedBuffIdx );
  CHHL_BuffInitUnits( gSelectedBuffIdx );
  CHHL_BuffInitData( gSelectedBuffIdx );
  CHHL_BuffInitParty( gSelectedBuffIdx );
  CHHL_BuffHighlightSelected( gSelectedBuffIdx );

end

-- buff config setup
function CHH_BuffInit( page )

  local playerClass = CH_UnitClass('player');

  CHH_BuffGeneral:Hide();
  CHH_BuffList:Hide();
  CHH_BuffClass:Hide();
  CHH_BuffUnit:Hide();
  CHH_BuffData:Hide();
  CHH_BuffParty:Hide();

  if ( playerClass == 'WARRIOR' or playerClass == 'HUNTER' or playerClass == 'ROGUE' ) then
    CHH_BuffPage2Button:Hide();
    page = 'options';
  end

  if ( page == 'options' ) then
    CHH_InitTabs( CHH_Buff, CHH_BuffGeneral, 'BUFF', 'MISC', CHH_BuffInit, 'options' );

  elseif ( page == 'list' ) then
    CHH_InitTabs( CHH_Buff, nil, 'BUFF', 'BUFF', CHH_BuffInit, 'list' );
    CHH_BuffList:Show();
    CHH_BuffClass:Show();
    CHH_BuffUnit:Show();

    gSelectedBuffIdx = 'none';
    CHHL_BuffInitAll();
  end

end

function CHH_BuffPartyMissingInit()

  local k, v;
  local info = {};

  for k,v in {CHHT_LABEL_ALWAYS,CHHT_NUMBER_TWO,CHHT_NUMBER_THREE,CHHT_NUMBER_FOUR,CHHT_NUMBER_FIVE,CHHT_LABEL_NEVER} do
    if ( k <= 1 ) then
      info.text = CHHT_LABEL_ALWAYS;
    elseif ( k > 5 ) then
      info.text = CHHT_LABEL_NEVER;
    else
      info.text = v..' '..CHHT_LABEL_MEMBERS;
    end
    if ( k == CH_BuffData[gSelectedBuffIdx].partySpellPrefer ) then
      UIDropDownMenu_SetText( info.text, CHH_BuffPartyMissing );
    end
    info.func = CHH_BuffPartyMissingClicked;
    info.value = {idx=k,text=info.text};
    UIDropDownMenu_AddButton(info);
  end

end

function CHH_BuffPartyMissingClicked()

  CH_BuffData[gSelectedBuffIdx].partySpellPrefer = this.value.idx;
  UIDropDownMenu_SetText( this.value.text, CHH_BuffPartyMissing );

end

function CHH_BuffListBuffClicked( object )

  gSelectedBuffIdx = CHH_GetVari( object, "buffIdx" );

  CHHL_BuffInitClasses( gSelectedBuffIdx );
  CHHL_BuffInitUnits( gSelectedBuffIdx );
  CHHL_BuffInitData( gSelectedBuffIdx );
  CHHL_BuffInitParty( gSelectedBuffIdx );
  CHHL_BuffHighlightSelected( gSelectedBuffIdx );

end

function CHH_BuffListCheckClicked( object )

  local buffIdx = CHH_GetVari( object, 'buffIdx' );

  if ( CH_BuffData[buffIdx].castable ) then
    CH_BuffData[buffIdx].enabled = CH_ToBoolean( this:GetChecked() );
  end

end

function CHH_BuffListBuffUpClicked( object )

  local moveIdx = CHH_GetVari( object, 'buffIdx' );
  local lastIdx = nil;
  local prioIdx, buffIdx, prioBuffIdx;

  for prioIdx,buffIdx in CH_BuffPriority do
    if ( buffIdx == moveIdx and lastIdx ~= nil ) then
      prioBuffIdx = CH_BuffData[buffIdx].priority;
      CH_BuffData[buffIdx].priority = CH_BuffData[lastIdx].priority;
      CH_BuffData[lastIdx].priority = prioBuffIdx;
      break;
    end
    lastIdx = buffIdx;
  end

  CH_InitBuffPriority();

  CHHL_BuffInitAll();

end

function CHH_BuffListBuffDownClicked( object )

  local moveIdx = CHH_GetVari( object, 'buffIdx' );
  local lastIdx = nil;
  local prioIdx, buffIdx, prioBuffIdx;

  for prioIdx,buffIdx in CH_BuffPriority do
    if ( buffIdx == moveIdx ) then
      lastIdx = buffIdx;
    elseif ( lastIdx ~= nil ) then
      prioBuffIdx = CH_BuffData[buffIdx].priority;
      CH_BuffData[buffIdx].priority = CH_BuffData[lastIdx].priority;
      CH_BuffData[lastIdx].priority = prioBuffIdx;
      break;
    end
  end

  CH_InitBuffPriority();

  CHHL_BuffInitAll();

end

function CHH_BuffClassClicked( class )

  local buffIdx = gSelectedBuffIdx;

  if ( CH_BuffData[buffIdx].classes[class] == 1 ) then 
    CH_BuffData[buffIdx].classes[class] = 0;
  else
    CH_BuffData[buffIdx].classes[class] = 1;
  end

end

function CHH_BuffUnitClicked( unit )

  local buffIdx = gSelectedBuffIdx;

  if ( CH_BuffData[buffIdx].units[unit] == 1 ) then 
    CH_BuffData[buffIdx].units[unit] = 0;
  else
    CH_BuffData[buffIdx].units[unit] = 1;
  end

end

function CHH_BuffDataSliderShow( frame, buffIdx, option )

  frame.isUpdating = true;
  getglobal(frame:GetName().."Low"):SetText(CHHT_LABEL_NEVER);
  getglobal(frame:GetName().."High"):SetText(CHHT_LABEL_ALWAYS);
  frame:SetMinMaxValues(0,CH_SPELL_INFO[CH_BUFF_DATA[buffIdx].spellName[1]].duration);
  frame:SetValueStep(10);
  frame.isUpdating = false;
  frame:SetValue( CH_BuffData[buffIdx][option] );

end

function CHH_BuffDataSliderClicked( option )

  if ( this.isUpdating ) then
    return;
  end

  local spellName = CH_BUFF_DATA[gSelectedBuffIdx].spellName[1];
  local duration = CH_SPELL_INFO[spellName].duration;
  local currValue = this:GetValue();

  CH_BuffData[gSelectedBuffIdx][option] = currValue;

  if ( option == 'warnTime' ) then
    if ( currValue < 1 ) then
      getglobal(this:GetName().."Text"):SetText( CHHT_BUFFS_NEVER_WARN );
    elseif ( currValue >= duration ) then
      getglobal(this:GetName().."Text"):SetText( CHHT_BUFFS_ALWAYS_WARN );
    else
      getglobal(this:GetName().."Text"):SetText( string.format(CHHT_BUFFS_WARN_EXPIRE_TITLE,CH_FormatTimeMMSS(currValue)) );
    end
  else
    if ( currValue < 1 ) then
      getglobal(this:GetName().."Text"):SetText( CHHT_BUFFS_NEVER_REFRESH );
    elseif ( currValue >= duration ) then
      getglobal(this:GetName().."Text"):SetText( CHHT_BUFFS_ALWAYS_REFRESH );
    else
      getglobal(this:GetName().."Text"):SetText( string.format(CHHT_BUFFS_REFRESH_TITLE,CH_FormatTimeMMSS(currValue)) );
    end
  end

  if ( option == 'refreshTime' and CH_BuffData[gSelectedBuffIdx].refreshTime < CH_BuffData[gSelectedBuffIdx].warnTime ) then
    CHH_BuffDataWarnExpire:SetValue( CH_BuffData[gSelectedBuffIdx].refreshTime );
  elseif ( CH_BuffData[gSelectedBuffIdx].refreshTime < CH_BuffData[gSelectedBuffIdx].warnTime ) then
    CHH_BuffDataRefreshTime:SetValue( CH_BuffData[gSelectedBuffIdx].warnTime );
  end

end

function CHH_BuffPartyUpgradeClicked()

  CH_BuffData[gSelectedBuffIdx].partySpellUpgrade = CH_ToBoolean( this:GetChecked() );

end

function CHH_BuffPartyInBattlefieldClicked()

  CH_BuffData[gSelectedBuffIdx].partySpellInBattlefield = CH_ToBoolean( this:GetChecked() );

end
