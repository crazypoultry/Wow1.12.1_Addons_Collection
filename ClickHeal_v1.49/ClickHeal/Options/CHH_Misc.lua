--=============================================================================
-- File:	CH_Help.lua
-- Author:	rudy
-- Description:	Configs Miscallenius
--=============================================================================

local gNotify2SpellListSelectedSpellName = nil;

-- ============================================================================
--   the config page(s)
-- ============================================================================

function CHH_MiscPage()

  CHH_InitTabs( CHH_Config, CHH_ConfigMisc, 'CONFIG', 'MISC', CHH_MiscPage, nil );

  UIDropDownMenu_Initialize( CHH_ConfigMiscDebugLevel, CHH_ConfigMiscDebugLevelInit )

  CHH_ConfigMiscResetAll:SetChecked( false );

end

function CHH_MiscAddonCheckInstall( addon )

  local isInstalled = false;

  if ( addon == 'CTRA' ) then
    isInstalled = (CT_RAMenuFrame ~= nil);
  elseif ( addon == 'ORA' ) then
    isInstalled = (oRA ~= nil);
    this:Disable();
  elseif ( addon == 'DUF' ) then
    isInstalled = (DUF_Element_OnClick ~= nil);
  elseif ( addon == 'DCR' ) then
    isInstalled = (Dcr_Clean ~= nil);
  elseif ( addon == 'NeedyList' ) then
    isInstalled = (NL_Configure ~= nil);
  elseif ( addon == 'WoWGui' ) then
    isInstalled = (PlayerFrame ~= nil);
    this:Disable();
  elseif ( addon == 'BONUSSCANNER' ) then
    isInstalled = (BonusScanner ~= nil);
    this:Disable();
  elseif ( addon == 'PCUF' ) then
    isInstalled = (Perl_Player_MouseClick ~= nil);
  else
    return;
  end

  if ( isInstalled ) then
    getglobal(this:GetParent():GetName()..'Name'):SetTextColor( 0, 1, 0 );
  else
    getglobal(this:GetParent():GetName()..'Name'):SetTextColor( 1, 0, 0 );
    this:Disable();
  end

end

function CHH_MiscAddonConfigure( addon )

  if ( addon == 'CTRA' ) then
    CHH_Frame:Hide();
    CT_RAMenuFrame:Show();
  elseif ( addon == 'DUF' ) then
    DUF_Slash_Handler( '' );
    CHH_Frame:Hide();
  elseif ( addon == 'DCR' ) then
    CHH_Frame:Hide();
--    if ( not DecursiveAfflictedListFrame:IsVisible() ) then
      Dcr_ShowHideAfflictedListUI();
--    end
  elseif ( addon == 'NeedyList' ) then
    CHH_Frame:Hide();
    NL_Configure();
  elseif ( addon == 'PCUF' ) then
    Perl_Config_SlashHandler( '' );
    CHH_Frame:Hide();
  elseif ( addon == 'BONUSSCANNER' ) then
    --
  elseif ( addon == 'WoWGui' ) then
    --
  end

end

function CHH_ConfigMiscDebugLevelInit()

  local k, v;
  local info = {};

  for k,v in CH_DebugLevels do
    info.text = v;
    info.checked = nil;
    if ( (k < CH_Config.debugLevel and k ~= CH_DEBUG_NONE) or k == CH_Config.debugLevel ) then
      info.checked = 1;
      UIDropDownMenu_SetText( v, CHH_ConfigMiscDebugLevel );
    end
    info.func = CHH_ConfigMiscDebugLevelClicked;
    info.value = k;
    UIDropDownMenu_AddButton(info);
  end

end

function CHH_ConfigMiscDebugLevelClicked()

  CH_ConfigSetOption( 'debugLevel', this.value );
  UIDropDownMenu_SetText( CH_DebugLevels[this.value], CHH_ConfigMiscDebugLevel );

end

function CHH_ConfigResetAll()

  if ( CHH_ConfigMiscResetAll:GetChecked() ) then
    CHH_ResetDefaults( 'ALL', 'ALL' );
    CHH_MiscPage();
  else
    CH_Msg( 'Option not checked' );
  end

end

-- ============================================================================
--   the plugins page (part of config tab)
-- ============================================================================

function CHH_PluginsPage()

  CHH_InitTabs( CHH_Config, CHH_ConfigPlugins, 'CONFIG', 'PLUGINS', CHH_PluginsPage, nil );

end

function CHH_ConfigPluginsListUpdate()

  local entry, plugin, actionID, version, versionString;
  local scrollFrame = CHH_ConfigPluginsListScrollBar;
  local listFrameName = 'CHH_ConfigPluginsList';
  local i = 1;
  local offset = FauxScrollFrame_GetOffset( scrollFrame );

  FauxScrollFrame_Update( scrollFrame, table.getn(CH_PluginListSort), 10, 20 );       -- fame, numItems, numDisplay, valueStep (pixel height of one entry)

  i = 1;
  entry = getglobal( listFrameName..'Entry'..i );
  while ( entry and CH_PluginListSort[offset+i] ) do
    actionID = CH_PluginListSort[offset+i];
    plugin = CH_PluginList[actionID];
    version = plugin:GetVersion();
    if ( type(version) == 'number' or (tostring(tonumber(version)) == version) ) then
      versionString = string.format("v%d.%02d.%02d",  floor(version/10000), floor(mod(version,10000)/100), mod(version,100) );
    else
      versionString = version;
    end
    
    getglobal(listFrameName..'Entry'..i..'Name'):SetText( plugin:GetName() );
    getglobal(listFrameName..'Entry'..i..'Version'):SetText( versionString );
    getglobal(listFrameName..'Entry'..i..'Label'):SetText( plugin:GetActionLabel(actionID) );
    getglobal(listFrameName..'Entry'..i..'ActionID'):SetText( actionID );
    entry:Show();
    i = i + 1;
    entry = getglobal( listFrameName..'Entry'..i );
  end

end

-- ============================================================================
--   the self defense / combat page (part of config tab)
-- ============================================================================

function CHH_CombatPage()

  CHH_InitTabs( CHH_Config, CHH_ConfigCombat, 'CONFIG', 'COMBAT', CHH_CombatPage, nil );

end

-- ============================================================================
--   the cooldown watch page (part of config tab)
-- ============================================================================

function CHH_CooldownWatchPage()

  local spellNr, cdData, frame;

  CHH_InitTabs( CHH_Config, CHH_ConfigCooldownWatch, 'CONFIG', 'COOLDOWN', CHH_CooldownWatchPage, nil );

  for spellNr,cdData in CH_CooldownWatchList do
    if ( spellNr <= 4 ) then							-- the extra frames
      frame = getglobal( "CHH_ConfigCooldownWatchExtra"..spellNr..'CD' );
    else									-- the spells
      frame = getglobal( "CHH_ConfigCooldownWatchSpellsCD"..(spellNr-4) );
    end
    frame.cooldownIdx = spellNr;
    frame.myFrameName = frame:GetName();
    UIDropDownMenu_SetWidth( 150, frame );
    UIDropDownMenu_Initialize( frame, CHH_CooldownWatchSpellInit );
    CHH_DropdownSetLabel( cdData.spellName, frame, 'None', CHHT_LABEL_NONE );
  end

end

function CHH_CooldownWatchSpellInit( level )

  local k, v, cdIdx, i, spellName;
  local prevSpellName = nil;
  local info = {};
  local tabName, tabTexture, tabOffset, tabNumSpells;
  local cdIdx, frameName, tabIdx;

  if ( level == nil ) then
    level = 1;
  end

  -- ----- level 1 ---------------------------------
  if ( level == 1 ) then
    cdIdx = CHH_GetVari( this, 'cooldownIdx' );
    frameName = CHH_GetVari( this, 'myFrameName' );

    if ( cdIdx == nil ) then
      return;
    end;

    i = 1;
    tabName,tabTextur,tabOffset,tabNumSpells = GetSpellTabInfo(i);
    while ( tabName ) do
      info = {};
      info.text = tabName;
      info.hasArrow = 1;
      info.value = {cooldownIdx=cdIdx,frameName=frameName,tabIdx=i};
      UIDropDownMenu_AddButton( info, 1 );
      i = i + 1;
      tabName,tabTextur,tabOffset,tabNumSpells = GetSpellTabInfo(i);
    end

    if ( GetSpellName(1,BOOKTYPE_PET) ) then
      info = {};
      info.text = CHHT_LABEL_PET;
      info.hasArrow = 1;
      info.value = {cooldownIdx=cdIdx,frameName=frameName,tabIdx=-1};
      UIDropDownMenu_AddButton( info, 1 );
    end

    info = {};
    info.text = CHHT_LABEL_NONE;
    info.check = nil;
    info.func = CHH_CooldownWatchSpellClicked;
    info.value = {cooldownIdx=cdIdx,spellName='None',bookType=nil,spellID=-1,frameName=frameName};
    UIDropDownMenu_AddButton( info, level );

    return;
  end

  -- ----- level 2 ---------------------------------
  cdIdx = UIDROPDOWNMENU_MENU_VALUE.cooldownIdx;
  frameName = UIDROPDOWNMENU_MENU_VALUE.frameName;
  tabIdx = UIDROPDOWNMENU_MENU_VALUE.tabIdx;

  if ( tabIdx > 0 ) then 										-- player spells
    tabName,tabTextur,tabOffset,tabNumSpells = GetSpellTabInfo(tabIdx);

    i = 1+tabOffset;
    spellName = GetSpellName( i, BOOKTYPE_SPELL );
    while ( spellName and i < 1+tabOffset+tabNumSpells ) do
      if ( (not prevSpellName) or spellName ~= prevSpellName ) then
        CH_TooltipSetSpell( i, BOOKTYPE_SPELL );
        if ( CH_TooltipGetCooldown() ) then
          info = {};
          info.text = spellName;
        info.check = nil;
          info.func = CHH_CooldownWatchSpellClicked;
          info.value = {cooldownIdx=cdIdx,spellName=spellName,bookType=BOOKTYPE_SPELL,spellID=i,frameName=frameName};
          UIDropDownMenu_AddButton( info, level );
        end
      end
      i = i + 1;
      prevSpellName = spellName;
      spellName = GetSpellName( i, BOOKTYPE_SPELL );
    end
  else													-- pet spells
    prevSpellName = nil;
    i = 1;
    spellName = GetSpellName( i, BOOKTYPE_PET );
    while ( spellName ) do
      if ( (not prevSpellName) or spellName ~= prevSpellName ) then
        CH_TooltipSetSpell( i, BOOKTYPE_PET );
        if ( CH_TooltipGetCooldown() ) then
          info = {};
          info.text = spellName;
          info.check = nil;
          info.func = CHH_CooldownWatchSpellClicked;
          info.value = {cooldownIdx=cdIdx,spellName=spellName,bookType=BOOKTYPE_PET,spellID=i,frameName=frameName};
          UIDropDownMenu_AddButton( info, level );
        end
      end
      i = i + 1;
      prevSpellName = spellName;
      spellName = GetSpellName( i, BOOKTYPE_PET );
    end
  end

end

function CHH_CooldownWatchSpellClicked()

  CHH_DropdownSetLabel( this.value.spellName, getglobal(this.value.frameName), 'None', CHHT_LABEL_NONE );
  CH_CooldownWatchList[this.value.cooldownIdx] = { spellName=this.value.spellName, bookType=this.value.bookType, spellID=this.value.spellID };

end

-- ============================================================================
--   the overheal page (part of config tab)
-- ============================================================================

function CHH_OverhealPage()

  local plusHeal = '?';

  CHH_InitTabs( CHH_Config, CHH_ConfigOverheal, 'CONFIG', 'OVERHEAL', CHH_OverhealPage, nil );

  CHH_ConfigOverhealQUICKStart:SetValue( CH_Config.overheal.QUICK.startBelow );
  CHH_ConfigOverhealQUICKDowngrade:SetChecked( CH_Config.overheal.QUICK.downgrade );
  CHH_ConfigOverhealQUICKCombatDowngrade:SetChecked( CH_Config.overheal.QUICK.combatDowngrade );
  CHH_ConfigOverhealQUICKHealAvg:SetValue( CH_Config.overheal.QUICK.baseOnPerc );
  CHH_ConfigOverhealQUICKHot:SetValue( CH_Config.overheal.QUICK.hotPerc );
  CHH_ConfigOverhealQUICKDPSCheck:SetValue( CH_Config.overheal.QUICK.dpsCheck );
  CHH_ConfigOverhealQUICKClickAbortPercentage:SetValue( CH_Config.overheal.QUICK.clickAbortPerc );
  CHH_ConfigOverhealQUICKModifyTotalPerc:SetValue( CH_Config.overheal.QUICK.modifyTotalPerc );
  CHH_ConfigOverhealQUICKLomDowngradeRanks:SetValue( CH_Config.overheal.QUICK.lomDowngradeRanks );
  CHH_ConfigOverhealQUICKOverhealAllowance:SetValue( CH_Config.overheal.QUICK.overhealAllowance );

  CHH_ConfigOverhealSLOWStart:SetValue( CH_Config.overheal.SLOW.startBelow );
  CHH_ConfigOverhealSLOWDowngrade:SetChecked( CH_Config.overheal.SLOW.downgrade );
  CHH_ConfigOverhealSLOWCombatDowngrade:SetChecked( CH_Config.overheal.SLOW.combatDowngrade );
  CHH_ConfigOverhealSLOWHealAvg:SetValue( CH_Config.overheal.SLOW.baseOnPerc );
  CHH_ConfigOverhealSLOWHot:SetValue( CH_Config.overheal.SLOW.hotPerc );
  CHH_ConfigOverhealSLOWDPSCheck:SetValue( CH_Config.overheal.SLOW.dpsCheck );
  CHH_ConfigOverhealSLOWClickAbortPercentage:SetValue( CH_Config.overheal.SLOW.clickAbortPerc );
  CHH_ConfigOverhealSLOWModifyTotalPerc:SetValue( CH_Config.overheal.SLOW.modifyTotalPerc );
  CHH_ConfigOverhealSLOWLomDowngradeRanks:SetValue( CH_Config.overheal.SLOW.lomDowngradeRanks );
  CHH_ConfigOverhealSLOWOverhealAllowance:SetValue( CH_Config.overheal.SLOW.overhealAllowance );

  if ( CH_UnitClass('player') == 'DRUID' ) then
    CHH_ConfigOverhealQUICKHot:Show();
    CHH_ConfigOverhealSLOWHot:Hide();
  else
    CHH_ConfigOverhealQUICKHot:Hide();
    CHH_ConfigOverhealSLOWHot:Hide();
  end

  if ( BonusScanner ) then
    plusHeal = BonusScanner:GetBonus('HEAL');
  end

  CHH_ConfigOverhealIncludeEquipHealBonusName:SetText( string.format(CHHT_MISC_OVERHEAL_GEAR,plusHeal) );
    
  CHH_ConfigOverhealUpdateFormula( 'QUICK' );
  CHH_ConfigOverhealUpdateFormula( 'SLOW' );

end

function CHH_ConfigOverhealUpdateFormula( overhealIdx )

  if ( CH_IsEmptyTable(CH_Overheal) ) then
    getglobal('CHH_ConfigOverhealFormula'..overhealIdx):SetText( 'This character has no healing' );
    return;
  end

  local _,wis = UnitStat('player',5);
  local heal = CH_Overheal[overhealIdx][table.getn(CH_Overheal[overhealIdx])];
  local config = CH_Config.overheal[overhealIdx];
  local healAmt = heal.minHeal;
  local msg = '( '..heal.minHeal;

  if ( heal.minHeal ~= heal.maxHeal ) then
    msg = msg .. " + (" .. heal.maxHeal .. "-" .. heal.minHeal .. ")*|cFF00FF00" .. config.baseOnPerc .. '%|r';
    healAmt = healAmt + floor((heal.maxHeal-heal.minHeal)*config.baseOnPerc/100);
  end

  if ( heal.hotMaxHeal > 0 ) then
    if ( heal.hotMinHeal == heal.hotMaxHeal ) then		-- heals a-b and another x over n sec
      msg = msg .. " + " .. heal.hotMinHeal .. "*|cFF00CCFF" .. config.hotPerc .. '%|r';
    else							-- heals a-b and another x-y over n sec
      msg = msg .. " + (" .. heal.hotMinHeal .. "+(" .. heal.hotMaxHeal .. "-" .. heal.hotMinHeal ..")*|cFF00FF00" .. config.baseOnPerc .. '%|r)*|cFF00CCFF' .. config.hotPerc .. '%|r';
    end
    healAmt = healAmt + floor((heal.hotMinHeal+(heal.hotMaxHeal-heal.hotMinHeal)*config.baseOnPerc/100)*config.hotPerc/100);
  end

  if ( CH_SpiritualGuidance > 0 and CH_Config.includeEquipHealBonus and heal.calcCastTime and BonusScanner ) then
    msg = msg .. " + (|cFFFF00FF" .. BonusScanner:GetBonus('HEAL') .. '+' .. floor((wis*(CH_SpiritualGuidance*5)/100)+0.5) .. '|r)*' .. heal.calcCastTime .. '/3.5';
    healAmt = healAmt + (BonusScanner:GetBonus('HEAL')+floor((wis*(CH_SpiritualGuidance*5)/100)+0.5)) * heal.calcCastTime / 3.5;
  elseif ( CH_Config.includeEquipHealBonus and heal.calcCastTime and BonusScanner ) then
    msg = msg .. " + |cFFFF00FF" .. BonusScanner:GetBonus('HEAL') .. '|r*' .. heal.calcCastTime .. '/3.5';
    healAmt = healAmt + BonusScanner:GetBonus('HEAL') * heal.calcCastTime / 3.5;
  elseif ( CH_SpiritualGuidance > 0 ) then
    msg = msg .. " + (|cFFFF00FF" .. floor((wis*(CH_SpiritualGuidance*5)/100)+0.5) .. '|r)*' .. heal.calcCastTime .. '/3.5';
    healAmt = healAmt + floor((wis*(CH_SpiritualGuidance*5)/100)+0.5) * heal.calcCastTime / 3.5;
  end

  msg = msg .. ' ) * |cFFFFCC00' .. config.modifyTotalPerc .. '%|r';
  healAmt = floor( healAmt * config.modifyTotalPerc / 100 );

  msg = msg .. " = " .. healAmt;

  getglobal('CHH_ConfigOverhealFormula'..overhealIdx):SetText( msg );

end

function CHH_ConfigOverhealStartClicked( actionIdx )

  local rt = this:GetValue();

  getglobal(this:GetName().."Text"):SetText( string.format(CHHT_MISC_HEALTH_PERCENT_TITLE_FORMAT,rt) );

  if ( actionIdx ) then
    CH_Config.overheal[actionIdx].startBelow = tonumber(rt);
  end

end

function CHH_ConfigOverhealDowngradeClicked( actionIdx )

  CH_Config.overheal[actionIdx].downgrade = CH_ToBoolean( this:GetChecked() );

end

function CHH_ConfigOverhealCombatDowngradeClicked( actionIdx )

  CH_Config.overheal[actionIdx].combatDowngrade = CH_ToBoolean( this:GetChecked() );

end

function CHH_ConfigOverhealLomDowngradeRanksClicked( actionIdx )

  local rt = this:GetValue();


  if ( rt < 1 ) then
    getglobal(this:GetName().."Text"):SetText( CHHT_MISC_OVERHEAL_LOM_NONE );
  elseif ( rt >= 15 ) then
    getglobal(this:GetName().."Text"):SetText( CHHT_MISC_OVERHEAL_LOM_MAX );
  else
    getglobal(this:GetName().."Text"):SetText( string.format(CHHT_MISC_OVERHEAL_LOM_TITLE_FORMAT,rt) );
  end

  if ( actionIdx ) then
    CH_Config.overheal[actionIdx].lomDowngradeRanks = tonumber(rt);
  end

end

function CHH_ConfigOverhealHealAvgClicked( actionIdx )

  local rt = this:GetValue();

  getglobal(this:GetName().."Text"):SetText( string.format(CHHT_MISC_HEAL_POTENTIAL_TITLE_FORMAT,rt) );

  if ( actionIdx ) then
    CH_Config.overheal[actionIdx].baseOnPerc = tonumber(rt);
  end

  CHH_ConfigOverhealUpdateFormula( 'QUICK' );
  CHH_ConfigOverhealUpdateFormula( 'SLOW' );

end

function CHH_ConfigOverhealHotClicked( actionIdx )

  local rt = this:GetValue();

  getglobal(this:GetName().."Text"):SetText( string.format(CHHT_MISC_HOT_PERCENTAGE_TITLE_FORMAT,rt) );

  if ( actionIdx ) then
    CH_Config.overheal[actionIdx].hotPerc = tonumber(rt);
  end

  CHH_ConfigOverhealUpdateFormula( 'QUICK' );
  CHH_ConfigOverhealUpdateFormula( 'SLOW' );

end

function CHH_ConfigOverhealDPSCheckClicked( actionIdx )

  local rt = this:GetValue();

  if ( rt < 1 ) then
    getglobal(this:GetName().."Text"):SetText( CHHT_LABEL_NEVER );
  elseif ( rt > 9 ) then
    getglobal(this:GetName().."Text"):SetText( CHHT_LABEL_ALWAYS );
  else
    getglobal(this:GetName().."Text"):SetText( string.format(CHHT_MISC_HIT_AGO_TITLE_FORMAT,rt) );
  end

  if ( actionIdx ) then
    CH_Config.overheal[actionIdx].dpsCheck = tonumber(rt);
  end

end

function CHH_ConfigOverhealModifyTotalPercClicked( actionIdx )

  local rt = this:GetValue();

  getglobal(this:GetName().."Text"):SetText( string.format(CHHT_MISC_MODIFY_TOTAL_PERC_FORMAT,rt) );

  if ( actionIdx ) then
    CH_Config.overheal[actionIdx].modifyTotalPerc = tonumber(rt);
  end

  CHH_ConfigOverhealUpdateFormula( 'QUICK' );
  CHH_ConfigOverhealUpdateFormula( 'SLOW' );

end

function CHH_ConfigOverhealClickAbortPercentageClicked( actionIdx )

  local rt = this:GetValue();

  if ( rt < 1 ) then
    getglobal(this:GetName().."Text"):SetText( CHHT_LABEL_ALWAYS );
  elseif ( rt > 100 ) then
    getglobal(this:GetName().."Text"):SetText( CHHT_LABEL_NEVER );
  else
    getglobal(this:GetName().."Text"):SetText( string.format(CHHT_MISC_CLICK_ABORT_PERC_TITLE_FORMAT,rt) );
  end

  if ( actionIdx ) then
    CH_Config.overheal[actionIdx].clickAbortPerc = tonumber(rt);
  end

end

function CHH_ConfigOverhealOverhealAllowance( actionIdx )

  local rt = this:GetValue();

  getglobal(this:GetName().."Text"):SetText( string.format(CHHT_MISC_OVERHEAL_ALLOWANCE_TITLE_FORMAT,rt) );

  if ( actionIdx ) then
    CH_Config.overheal[actionIdx].overhealAllowance = tonumber(rt);
  end

end

function CHH_ConfigOverhealEquipHealBonusPostClick()

  CHH_ConfigOverhealUpdateFormula( 'QUICK' );
  CHH_ConfigOverhealUpdateFormula( 'SLOW' );

end

-- ============================================================================
--   the notify page (part of config tab)
-- ============================================================================

function CHH_NotifyPage()

  CHH_InitTabs( CHH_Config, CHH_ConfigNotify, 'CONFIG', 'NOTIFY', CHH_NotifyPage, nil );

  CHH_ConfigNotifyHitPartyMsg:SetText( CH_Config.announceHitToPartyMsg );
  CHH_ConfigNotifyCustomChannelName:SetText( CH_Config.notifyCustomChannelName );
  CHH_ConfigNotifyCustomChannelPassword:SetText( CH_Config.notifyCustomChannelPassword );
  UIDropDownMenu_Initialize( CHH_ConfigNotifyCustomChannelChatBox, CHH_ConfigNotifyCustomChannelChatBoxInit );

end

function CHH_Notify2Page()

  CHH_InitTabs( CHH_Config, CHH_ConfigNotify2, 'CONFIG', 'NOTIFY2', CHH_Notify2Page, nil );

end

function CHH_ConfigNotifyHitPartyMsgClicked()

  CH_Config.announceHitToPartyMsg = this:GetText();

end

function CHH_ConfigNotifyCustomChannelNameClicked()

  local value = this:GetText();
  local oldValue = CH_Config.notifyCustomChannelName;

  if ( value == nil ) then
    value = '';
  else
    value = string.gsub( value, "[^%w]", "" );
    CHH_ConfigNotifyCustomChannelName:SetText( value );
  end

  CH_ConfigSetOption( 'notifyCustomChannelName', value );

end

function CHH_ConfigNotifyCustomChannelPasswordClicked()

  local value = this:GetText();

  CH_ConfigSetOption( 'notifyCustomChannelPassword', value );

end

function CHH_ConfigNotifyCustomChannelChatBoxInit()

  local i;
  local info = {};

  for i=0,NUM_CHAT_WINDOWS do
    if ( i == 0 ) then
      info.text = CHHT_MISC_NOTIFY_DEFAULT_CHAT_WINDOW_LABEL;
      info.value = {id='DEFAULT',label=info.text};
    else
      info.text = GetChatWindowInfo(i);
      if ( info.text == '' ) then 
        info.text = string.format(CHHT_MISC_NOTIFY_CHAT_WINDOW_LABEL_FORMAT,i);
      end
      info.value = {id='ChatFrame'..i,label=info.text};
    end
    info.checked = nil;
    if ( CH_Config.notifyCustomChannelChatFrameName == info.value.id ) then
      info.checked = 1;
      UIDropDownMenu_SetText( info.text, CHH_ConfigNotifyCustomChannelChatBox );
    end
    info.func = CHH_ConfigNotifyCustomChannelChatBoxClicked;
    UIDropDownMenu_AddButton(info);
  end

end

function CHH_ConfigNotifyCustomChannelChatBoxClicked()

  CH_ConfigSetOption( 'notifyCustomChannelChatFrameName', this.value.id );
  UIDropDownMenu_SetText( this.value.label, CHH_ConfigNotifyCustomChannelChatBox );

end

local function CHHL_ConfigNotify2SpellListEntryUpdate( entryID, spellName, configID )

  local entry = getglobal( 'CHH_ConfigNotify2'..entryID );
  local entryName = getglobal( 'CHH_ConfigNotify2'..entryID..'Name' );

  if ( spellName and CH_Config.notifySpellCast[spellName] ) then
    entry:SetChecked( CH_Config.notifySpellCast[spellName][configID] );
    entry:Enable();
    entryName:SetTextColor( 1, 1, 1 );
  else
    entry:SetChecked( false );
    entry:Disable();
    entryName:SetTextColor( 0.5, 0.5, 0.5 );
  end

end

local function CHHL_ConfigNotify2FillSpellListData()

  local spellName = gNotify2SpellListSelectedSpellName;

  CHH_ConfigNotify2SpellName:SetText( spellName );

  CHHL_ConfigNotify2SpellListEntryUpdate( 'Say', spellName, 'say' );
  CHHL_ConfigNotify2SpellListEntryUpdate( 'Party', spellName, 'party' );
  CHHL_ConfigNotify2SpellListEntryUpdate( 'Raid', spellName, 'raid' );
  CHHL_ConfigNotify2SpellListEntryUpdate( 'Target', spellName, 'target' );
  CHHL_ConfigNotify2SpellListEntryUpdate( 'CustomChannel', spellName, 'customChannel' );

end

function CHH_ConfigNotify2SpellListUpdate()

  local entry, checkBox, button, label, background, spellName, prevSpellName;
  local scrollFrame = CHH_ConfigNotify2SpellList;
  local i = 1;
  local spellOffset = FauxScrollFrame_GetOffset( scrollFrame );

  if ( not gNotify2SpellListSelectedSpellName ) then
    gNotify2SpellListSelectedSpellName = CH_DistinctSpells[1];
  end

  FauxScrollFrame_Update( scrollFrame, table.getn(CH_DistinctSpells), 20, 20 );       -- fame, numItems, numDisplay, valueStep (pixel height of one entry)

  i = 1;
  entry = getglobal( scrollFrame:GetName()..'Entry'..i );
  while ( entry ) do
    spellName = CH_DistinctSpells[spellOffset+ i];
    background = getglobal( scrollFrame:GetName()..'Entry'..i..'Background' );
    checkBox = getglobal( scrollFrame:GetName()..'Entry'..i..'CheckBox' );
    button = getglobal( scrollFrame:GetName()..'Entry'..i..'Button' );
    label = getglobal( scrollFrame:GetName()..'Entry'..i..'ButtonLabel' );
    if ( spellName ) then
      entry.spellName = spellName;
      entry:Show();
      label:SetText( spellName );
      checkBox:SetChecked( CH_Config.notifySpellCast[spellName] ~= nil );
      background:Hide();
      if ( gNotify2SpellListSelectedSpellName == spellName ) then
        background:Show();
      end
    else
      entry:Hide();
    end
    i = i + 1;
    entry = getglobal( scrollFrame:GetName()..'Entry'..i );
  end

  CHHL_ConfigNotify2FillSpellListData( );

end

function CHH_ConfigNotify2SpellListCheckBoxClicked( entry )

  if ( this:GetChecked() ) then
    CH_Config.notifySpellCast[entry.spellName] = {};
  else
    CH_Config.notifySpellCast[entry.spellName] = nil;
  end

  CHH_ConfigNotify2SpellListButtonClicked( entry, true )

end

function CHH_ConfigNotify2SpellListButtonClicked( entry, forceUpdate )

  local idx, prevFrameBackground;
  
  if ( (not forceUpdate) and entry.spellName == gNotify2SpellListSelectedSpellName ) then
    return;
  end

  gNotify2SpellListSelectedSpellName = entry.spellName;

  CHH_ConfigNotify2SpellListUpdate();

end 

function CHH_ConfigNotify2SpellListSettingClicked( optionSubID )

  if ( this:GetChecked() ) then
    CH_Config.notifySpellCast[gNotify2SpellListSelectedSpellName][optionSubID] = true;
  else
    CH_Config.notifySpellCast[gNotify2SpellListSelectedSpellName][optionSubID] = nil;
  end

end
