--=============================================================================
-- File:	CH_Help.lua
-- Author:	rudy
-- Description:	Help pages and config
--=============================================================================

local gPreviousTabButton = nil;

-- ============================================================================
--   helper functions
-- ============================================================================

function CHH_InitTabs( activeFrame, activeSubFrame, tab, group, initFunc, initFuncArg )

  if ( CHH_Frame.active_sub_frame_name ) then
    getglobal(CHH_Frame.active_sub_frame_name):Hide();
  end

  if ( CHH_Frame.active_frame_name ) then
    getglobal(CHH_Frame.active_frame_name):Hide();
  end

  if ( activeFrame ) then
    activeFrame:Show();
    if ( activeSubFrame ) then
      activeSubFrame:Show();
    end

    CHH_Frame.ch_tab_idx = tab;
    CHH_Frame.ch_group_idx = group;
    CHH_Frame.active_frame_name = activeFrame:GetName();
    if ( activeSubFrame ) then
      CHH_Frame.active_sub_frame_name = activeSubFrame:GetName();
    end
    CHH_Frame.ch_init_func = initFunc;
    CHH_Frame.ch_init_func_arg = initFuncArg;
  else
    CHH_Frame.ch_tab_idx = nil;
    CHH_Frame.ch_group_idx = nil;
    CHH_Frame.active_frame_name = nil;
    CHH_Frame.active_sub_frame_name = nil;
    CHH_Frame.ch_init_func = nil;
    CHH_Frame.ch_init_func_arg = nil;
  end

  CHH_UpdateControls( activeFrame );

end

function CHH_UpdateControls( tabFrame )

  local tabButton;

  if ( not (tabFrame and tabFrame.ch_tab_button_name) ) then
     return;
  end

  tabButton = getglobal( tabFrame.ch_tab_button_name );
  tabButton:SetTextColor( CH_COLOR.WOWTEXTHIGHLIGHT.r, CH_COLOR.WOWTEXTHIGHLIGHT.g, CH_COLOR.WOWTEXTHIGHLIGHT.b );

  if ( gPreviousTabButton and gPreviousTabButton ~= tabButton ) then
    gPreviousTabButton:SetTextColor( CH_COLOR.WOWTEXTNORMAL.r, CH_COLOR.WOWTEXTNORMAL.g, CH_COLOR.WOWTEXTNORMAL.b );
  end
  gPreviousTabButton = tabButton;

end

-- ============================================================================
--   Defaults
-- ============================================================================

function CHH_ResetDefaults( tab, group )

  local redraw = true;

  if ( tab == nil ) then
    tab = CHH_Frame.ch_tab_idx;
  else
    redraw = false;
  end

  if ( group == nil ) then
    group = CHH_Frame.ch_group_idx;
  else
    redraw = false;
  end

  CH_ConfigReset( tab, group );

  if ( redraw ) then
    if ( CHH_Frame.ch_group_idx == 'MOUSE' ) then
      local actionFrame = getglobal(CHH_Frame.active_sub_frame_name);
      CHH_InitTabs( getglobal(CHH_Frame.active_frame_name), actionFrame, CHH_Frame.ch_tab_idx, 'MOUSE', nil, nil );
      CHH_SpellAssignInit( actionFrame.mouseSpellFrameName, actionFrame.mouseSpellIdx, actionFrame.mouseSpellAllowed, actionFrame.mouseSpellPage, actionFrame.mouseSpellHeader );
    else
      CHH_Frame.ch_init_func( CHH_Frame.ch_init_func_arg );
    end
  end

end

-- ============================================================================
--   Spell Assign
-- ============================================================================

function CHH_PetAttackDropdownValues()

  return( {NONE=CHHT_PET_ATTACK_NONE,HUNTERS_MARK=CHHT_PET_ATTACK_HUNTERS_MARK} );

end

function CHH_BuffDropdownValues()

  return( {AUTOMATIC=CHHT_UNITBUFF_AUTOMATIC,POPUP=CHHT_UNITBUFF_POPUP} );

end

function CHH_GrpBuffDropdownValues()

  return( {REFRESH_TIME=CHHT_GROUPBUFF_REFRESH_TIME,WARN_TIME=CHHT_GROUPBUFF_WARN_TIME} );

end

-- ---------- Init lists for generic drop down --------------------------------
function CHH_SpellDropdownValues( maxRank )

  local i;
  local data = {};

  if ( maxRank ) then
    for i=1,maxRank do
      data[i] = string.format( CH_SPELL_RANK_FORMAT, i );
    end
  end
  data['MAX'] = CHHT_LABEL_HIGHEST;

  return( data );

end

-- ---------- generic edit text handling ------------------------------------
local function CHHL_MouseInitText( actionType, mouseSpellIdx, mouseButton )

  return( CH_MouseSpellsData[mouseSpellIdx][mouseButton][1] or '' );

end

local function CHHL_MouseInitText2( actionType, mouseSpellIdx, mouseButton )

  return( CH_MouseSpellsData[mouseSpellIdx][mouseButton][2] or '' );

end

-- ---------- generic drop down handling ------------------------------------
local function CHHL_MouseCreateDropdown( dropDownFrame, dataIndex, values, selected )

  dropDownFrame.frameName = dropDownFrame:GetName();
  dropDownFrame.myValues = values;
  dropDownFrame.myDataIndex = dataIndex;
  UIDropDownMenu_Initialize( dropDownFrame, CHH_MouseInitDropDown );
  UIDropDownMenu_SetText( values[selected], dropDownFrame );

end

function CHH_MouseInitDropDown()

  local k, v, info;
  local mouseSpellIdx = CHH_GetVari( this, 'mouseSpellIdx' );
  local mouseButton = CHH_GetVari( this, 'mouseButton' );
  local frameName = CHH_GetVari( this, 'frameName' );
  local values = CHH_GetVari( this, 'myValues' );
  local dataIndex = CHH_GetVari( this, 'myDataIndex' );

  if ( not values ) then
    return;
  end

  for k,v in values do
    info = {};
    info.text = v;
    info.check = nil;
    info.func = CHH_MouseDropDownClicked;
    info.value = {key=k,value=v,frameName=frameName,mouseSpellIdx=mouseSpellIdx,mouseButton=mouseButton,dataIndex=dataIndex};
    UIDropDownMenu_AddButton( info );
  end

end

function CHH_MouseDropDownClicked()

  if ( CH_MouseSpells[this.value.mouseSpellIdx][this.value.mouseButton] == 'SPELL' ) then
    CH_MouseSpellsData[this.value.mouseSpellIdx][this.value.mouseButton].spellRank = this.value.key;
  elseif ( CH_MouseSpells[this.value.mouseSpellIdx][this.value.mouseButton] == 'PETATTACK' ) then
    CH_MouseSpellsData[this.value.mouseSpellIdx][this.value.mouseButton].action = this.value.key;
  elseif ( CH_MouseSpells[this.value.mouseSpellIdx][this.value.mouseButton] == 'TOTEMSET' ) then
    CH_MouseSpellsData[this.value.mouseSpellIdx][this.value.mouseButton] = this.value.key;
  elseif ( CH_MouseSpells[this.value.mouseSpellIdx][this.value.mouseButton] == 'BUFF' ) then
    CH_MouseSpellsData[this.value.mouseSpellIdx][this.value.mouseButton] = this.value.key;
  elseif ( CH_MouseSpells[this.value.mouseSpellIdx][this.value.mouseButton] == 'GRPBUFF' ) then
    CH_MouseSpellsData[this.value.mouseSpellIdx][this.value.mouseButton] = this.value.key;
  elseif ( CH_MouseSpells[this.value.mouseSpellIdx][this.value.mouseButton] == 'CHAIN' ) then
    CH_MouseSpellsData[this.value.mouseSpellIdx][this.value.mouseButton] = this.value.key;
  else
    CH_MouseSpellsData[this.value.mouseSpellIdx][this.value.mouseButton][this.value.dataIndex] = this.value.key;
  end

  UIDropDownMenu_SetText( this.value.value, getglobal(this.value.frameName) );

end

-- ---------- drop down for mouse spells ------------------------------------
function CHH_MouseSpellListDropDownInit( level )

  local k, v, i, spellName;
  local prevSpellName = nil;
  local info = {};
  local tabName, tabTexture, tabOffset, tabNumSpells;
  local mouseSpellIdx, mouseButton, frameName, tabIdx;

  if ( level == nil ) then
    level = 1;
  end

  -- ----- level 1 ---------------
  if ( level == 1 ) then
    mouseSpellIdx = CHH_GetVari( this, 'mouseSpellIdx' );
    mouseButton = CHH_GetVari( this, 'mouseButton' );
    frameName = CHH_GetVari( this, 'frameName' );

    if ( mouseSpellIdx == nil ) then
      return;
    end

    i = 1;
    tabName,tabTextur,tabOffset,tabNumSpells = GetSpellTabInfo(i);
    while ( tabName ) do
      info = {};
      info.text = tabName;
      info.hasArrow = 1;
      info.value = {mouseSpellIdx=mouseSpellIdx,mouseButton=mouseButton,frameName=frameName,tabIdx=i};
      UIDropDownMenu_AddButton( info, 1 );
      i = i + 1;
      tabName,tabTextur,tabOffset,tabNumSpells = GetSpellTabInfo(i);
    end

    info = {};
    info.text = CHHT_LABEL_NONE;
    info.checked = nil;
    info.func = CHH_MouseSpellListDropDownClicked;
    info.value = {mouseSpellIdx=mouseSpellIdx,mouseButton=mouseButton,spellName='None',frameName=frameName};
    UIDropDownMenu_AddButton( info, level );

    return;
  end

  -- ----- level 2 --------------
  mouseSpellIdx = UIDROPDOWNMENU_MENU_VALUE.mouseSpellIdx;
  mouseButton = UIDROPDOWNMENU_MENU_VALUE.mouseButton;
  frameName = UIDROPDOWNMENU_MENU_VALUE.frameName;
  tabIdx = UIDROPDOWNMENU_MENU_VALUE.tabIdx;

  tabName,tabTextur,tabOffset,tabNumSpells = GetSpellTabInfo(tabIdx);

  i = 1+tabOffset;
  spellName = GetSpellName( i, BOOKTYPE_SPELL );
  while ( spellName and i < 1+tabOffset+tabNumSpells ) do
    if ( (not prevSpellName) or spellName ~= prevSpellName ) then
      info = {};
      info.text = spellName;
      info.checked = nil;
      info.func = CHH_MouseSpellListDropDownClicked;
      info.value = {mouseSpellIdx=mouseSpellIdx,mouseButton=mouseButton,spellName=spellName,frameName=frameName};
      UIDropDownMenu_AddButton( info, level );
    end
    i = i + 1;
    prevSpellName = spellName;
    spellName = GetSpellName( i, BOOKTYPE_SPELL );
  end

end

function CHH_MouseSpellListDropDownClicked()

  local frame = getglobal(this.value.frameName);

  if ( this.value.spellName == 'None' ) then
    CH_SetCHAction( 'SPELL', this.value.mouseSpellIdx, this.value.mouseButton, nil );
    frame.spellRankDropDownFrame:Hide();
  elseif ( this.value.spellName ~= CH_MouseSpellsData[this.value.mouseSpellIdx][this.value.mouseButton] ) then
    CH_MouseSpellsData[this.value.mouseSpellIdx][this.value.mouseButton] = {spellName=this.value.spellName,spellRank='MAX'};

    local _,_,spellRank = CH_GetSpellID( this.value.spellName, nil, BOOKTYPE_SPELL, false );
    frame.spellRankDropDownFrame:Show();
    CHHL_MouseCreateDropdown( frame.spellRankDropDownFrame, 2, CHH_SpellDropdownValues(tonumber(spellRank)), 
                              CH_MouseSpellsData[this.value.mouseSpellIdx][this.value.mouseButton].spellRank );
  end

  CHH_DropdownSetLabel( this.value.spellName, frame, 'None', CHHT_LABEL_NONE );

end

-- ---------- drop down for pet mouse spells --------------------------------
function CHH_MousePetSpellListDropDownInit()

  local spellName;
  local prevSpellName = nil;
  local info = {};
  local mouseSpellIdx, mouseButton, frameName;

  mouseSpellIdx = CHH_GetVari( this, 'mouseSpellIdx' );
  mouseButton = CHH_GetVari( this, 'mouseButton' );
  frameName = CHH_GetVari( this, 'frameName' );

  if ( mouseSpellIdx == nil ) then
    return;
  end

  i = 1;
  spellName = GetSpellName( i, BOOKTYPE_PET );
  while ( spellName ) do
    if ( (not prevSpellName) or spellName ~= prevSpellName ) then
      info = {};
      info.text = spellName;
      info.check = nil;
      info.func = CHH_MousePetSpellListDropDownClicked;
      info.value = {mouseSpellIdx=mouseSpellIdx,mouseButton=mouseButton,spellName=spellName,frameName=frameName};
      UIDropDownMenu_AddButton( info );
    end
    i = i + 1;
    prevSpellName = spellName;
    spellName = GetSpellName( i, BOOKTYPE_PET );
  end

end

function CHH_MousePetSpellListDropDownClicked()

  local frame = getglobal(this.value.frameName);

  if ( this.value.spellName == 'None' ) then
    CH_SetCHAction( 'PETSPELL', this.value.mouseSpellIdx, this.value.mouseButton, nil );
    frame.spellRankDropDownFrame:Hide();
  elseif ( this.value.spellName ~= CH_MouseSpellsData[this.value.mouseSpellIdx][this.value.mouseButton] ) then
    CH_MouseSpellsData[this.value.mouseSpellIdx][this.value.mouseButton].spellName = this.value.spellName;
--    CH_MouseSpellsData[this.value.mouseSpellIdx][this.value.mouseButton] = {spellName=this.value.spellName,spellRank='MAX'};

--    local _,_,spellRank = CH_GetSpellID( this.value.spellName, nil, BOOKTYPE_PET, false );
--    frame.spellRankDropDownFrame:Show();
--    CHHL_MouseCreateDropdown( frame.spellRankDropDownFrame, 2, CHH_SpellDropdownValues(tonumber(spellRank)), 
--                              CH_MouseSpellsData[this.value.mouseSpellIdx][this.value.mouseButton].spellRank );
  end

  CHH_DropdownSetLabel( this.value.spellName, frame, 'None', CHHT_LABEL_NONE );

end

-- ---------- handling of edit/dropdown boxes to the right of action ---------------------------------------
function CHH_ShowEditBox( mouseSpellIdx, mouseButton, frameName ) 

  local editText = '';
  local actionType = CH_MouseSpells[mouseSpellIdx][mouseButton];
  local editFrame = getglobal( frameName.."EditText" );
  local dropDownFrame = getglobal( frameName.."DropDown" );
  local edit2Frame = getglobal( frameName.."EditText2" );
  local dropDown2Frame = getglobal( frameName.."DropDown2" );

  -- ----- first edit item -----------------------
  if ( actionType and (not CH_ActionList[actionType]) ) then	-- not loaded plugin
    editFrame:Hide();
    dropDownFrame:Hide();
  elseif ( actionType == 'SPELL' ) then
    dropDownFrame:Show();
    editFrame:Hide();
    dropDownFrame.frameName = dropDownFrame:GetName();
    UIDropDownMenu_Initialize( dropDownFrame, CHH_MouseSpellListDropDownInit );
    CHH_DropdownSetLabel( CH_MouseSpellsData[mouseSpellIdx][mouseButton].spellName, dropDownFrame, 'None', CHHT_LABEL_NONE );
    dropDownFrame.spellRankDropDownFrame = dropDown2Frame;
  elseif ( actionType == 'PETSPELL' ) then
    dropDownFrame:Show();
    editFrame:Hide();
    dropDownFrame.frameName = dropDownFrame:GetName();
    UIDropDownMenu_Initialize( dropDownFrame, CHH_MousePetSpellListDropDownInit );
    CHH_DropdownSetLabel( CH_MouseSpellsData[mouseSpellIdx][mouseButton].spellName, dropDownFrame, 'None', CHHT_LABEL_NONE );
    dropDownFrame.spellRankDropDownFrame = dropDown2Frame;
  elseif ( actionType == 'PETATTACK' ) then
    dropDownFrame:Show();
    editFrame:Hide();
    CHHL_MouseCreateDropdown( dropDownFrame, 1, CHH_PetAttackDropdownValues(), CH_MouseSpellsData[mouseSpellIdx][mouseButton].action );
  elseif ( actionType == 'TOTEMSET' ) then
    dropDownFrame:Show();
    editFrame:Hide();
    CHHL_MouseCreateDropdown( dropDownFrame, 1, CHH_TotemsetDropdownValues(), CH_MouseSpellsData[mouseSpellIdx][mouseButton] );
  elseif ( actionType == 'BUFF' ) then
    dropDownFrame:Show();
    editFrame:Hide();
    CHHL_MouseCreateDropdown( dropDownFrame, 1, CHH_BuffDropdownValues(), CH_MouseSpellsData[mouseSpellIdx][mouseButton] );
  elseif ( actionType == 'GRPBUFF' ) then
    dropDownFrame:Show();
    editFrame:Hide();
    CHHL_MouseCreateDropdown( dropDownFrame, 1, CHH_GrpBuffDropdownValues(), CH_MouseSpellsData[mouseSpellIdx][mouseButton] );
  elseif ( actionType == 'CHAIN' ) then
    dropDownFrame:Show();
    editFrame:Hide();
    CHHL_MouseCreateDropdown( dropDownFrame, 1, CHH_ChainDropdownValues(), CH_MouseSpellsData[mouseSpellIdx][mouseButton] );
  elseif ( actionType and CH_ActionList[actionType].editable == 'TEXT' ) then
    editFrame:Show();
    dropDownFrame:Hide();
    editText = CHHL_MouseInitText( actionType, mouseSpellIdx, mouseButton );
    editFrame:SetText( editText );
  elseif ( actionType and CH_ActionList[actionType].editable == 'DROPDOWN' ) then
    dropDownFrame:Show();
    editFrame:Hide();
    CHHL_MouseCreateDropdown( dropDownFrame, 1, CH_ActionList[actionType].plugin:DropDownList(actionType,1,CH_MouseSpellsData[mouseSpellIdx][mouseButton]),
                             CH_MouseSpellsData[mouseSpellIdx][mouseButton][1] );
  else
    editFrame:Hide();
    dropDownFrame:Hide();
  end

  -- ----- second edit item ----------------------
  if ( actionType and (not CH_ActionList[actionType]) ) then	-- not loaded plugin
    editFrame:Hide();
    dropDownFrame:Hide();
  elseif ( actionType == 'SPELL' ) then
    dropDown2Frame:Hide();
    edit2Frame:Hide();
    if ( CH_MouseSpellsData[mouseSpellIdx][mouseButton] ) then
      local spellID,spellName,spellRank = CH_GetSpellID( CH_MouseSpellsData[mouseSpellIdx][mouseButton].spellName, nil, BOOKTYPE_SPELL, false );
      if ( spellID > 0 ) then
        CHHL_MouseCreateDropdown( dropDown2Frame, 2, CHH_SpellDropdownValues(tonumber(spellRank)), CH_MouseSpellsData[mouseSpellIdx][mouseButton].spellRank );
        dropDown2Frame:Show();
      end
    end
  elseif ( actionType and CH_ActionList[actionType].editable2 == 'TEXT' ) then
    edit2Frame:Show();
    dropDown2Frame:Hide();
    editText = CHHL_MouseInitText2( actionType, mouseSpellIdx, mouseButton );
    edit2Frame:SetText( editText );
  elseif ( actionType and CH_ActionList[actionType].editable2 == 'DROPDOWN' ) then
    dropDown2Frame:Show();
    edit2Frame:Hide();
    CHHL_MouseCreateDropdown( dropDown2Frame, 2, CH_ActionList[actionType].plugin:DropDownList(actionType,2,CH_MouseSpellsData[mouseSpellIdx][mouseButton]),
                              CH_MouseSpellsData[mouseSpellIdx][mouseButton][2] );
  else
    edit2Frame:Hide();
    dropDown2Frame:Hide();
  end

end

function CHH_SpellAssignInit( frameName, mouseSpellIdx, allowed, page, header )

  local i, mb;
  local yOffset = 30;
  local lower, upper;
  frame = getglobal( frameName );

  if ( header ) then
    getglobal(frameName..'TitleText'):SetText( header );
  end

  frame:Show();

  frame.mouseSpellFrameName = frameName;
  frame.mouseSpellIdx = mouseSpellIdx;
  frame.mouseSpellAllowed = allowed;
  frame.mouseSpellPage = page;
  frame.mouseSpellHeader = header;

  for i,mb in CH_MOUSE_BUTTONS_ALL do
    local mouseButtonFrame = getglobal( frameName..mb );
    local mouseButtonFrameText = getglobal( frameName..mb..'MyText' );

    lower = (page-1)*15+1;
    upper = (page)*15;

    if ( i >= lower and i <= upper ) then
      mouseButtonFrame:ClearAllPoints();
      mouseButtonFrame:SetPoint( 'TOPLEFT', mouseButtonFrame:GetParent(), 'TOPLEFT', 180, yOffset*-1 );
      mouseButtonFrameText:SetText( CH_MOUSE_BUTTONS_LABEL_ALL[mb] );
      mouseButtonFrame.mouseButton = mb;
      UIDropDownMenu_Initialize( mouseButtonFrame, CHH_SpellAssignDropDownInit );
      UIDropDownMenu_SetWidth( 150, mouseButtonFrame );
      if ( CH_MouseSpells[mouseSpellIdx][mb] ) then
        UIDropDownMenu_SetText( CHH_GetActionLabel(CH_MouseSpells[mouseSpellIdx][mb]), mouseButtonFrame );
      else
        UIDropDownMenu_SetText( '', mouseButtonFrame );
      end
  
      CHH_ShowEditBox( mouseSpellIdx, mb, frameName..mb );
  
      yOffset = yOffset + 30;
      mouseButtonFrame:Show();
    else
      mouseButtonFrame:Hide();
    end 
  end

end

function CHH_GetActionLabel( actionType )

  if ( actionType == nil ) then
    CH_Dbg( 'CHH_GetActionLabel(): Action type is nil!!!', CH_DEBUG_CRIT );
    return( CHT_LABEL_UNKNOWN );
  elseif ( not CH_ActionList[actionType] ) then
    CH_Dbg( 'No label for actionType '..actionType..'! Disabled plugin?', CH_DEBUG_NOTICE );
    return( CHT_LABEL_UNKNOWN );
  elseif ( CH_ActionList[actionType].plugin ) then
    return( CH_ActionList[actionType].plugin:GetActionLabel(actionType) );
  else
    return( CH_ACTION_TYPE_TEXT[actionType] );
  end

end

function CHH_SpellAssignDropDownInit( )

  local mb = CHH_GetVari( this, 'mouseButton' );
  local mouseSpellIdx = CHH_GetVari( this, 'mouseSpellIdx' );
  local allowed = CHH_GetVari( this, 'mouseSpellAllowed' );
  local info = {};
  local playerClass = CH_UnitClass('player');

  if ( mb == nil ) then
    return;
  end

  for _,actionType in CH_ActionListSort do
    actionData = CH_ActionList[actionType];
    if ( CH_InTable(actionData.allowed,allowed) and actionData.classes[playerClass] == 1 ) then
      info.text = CHH_GetActionLabel( actionType );
      if ( actionType == CH_MouseSpells[mouseSpellIdx][mb] or (actionType == 'NONE' and CH_MouseSpells[mouseSpellIdx][mb] == nil) ) then
        info.check = 1;
      else
        info.check = nil;
      end
      info.func = CHH_SpellAssignClicked;
      info.value = { mouseButton=mb, actionType=actionType, mouseSpellIdx=mouseSpellIdx, frameName=CHH_GetVari(this,'mouseSpellFrameName') };
      UIDropDownMenu_AddButton(info);
    end
  end

end

function CHH_SpellAssignClicked()

  local frame;

  local actionType = this.value.actionType;
  local mouseButton = this.value.mouseButton;
  local frameName = this.value.frameName;
  local mouseSpellIdx = this.value.mouseSpellIdx;

  frame = getglobal( frameName .. mouseButton );
  if ( actionType == 'NONE' ) then  
    UIDropDownMenu_SetText( '', frame );
    if ( strsub(mouseSpellIdx,1,5) ~= 'Chain' ) then				-- this is when use at the CHAIN tab to assign spells to chains!
      CH_SetCHAction( actionType, mouseSpellIdx, mouseButton, nil );
    end
  else
    UIDropDownMenu_SetText( CHH_GetActionLabel(actionType), frame );
    CH_SetCHAction( actionType, mouseSpellIdx, mouseButton, nil );
  end

  CHH_ShowEditBox( mouseSpellIdx, mouseButton, frameName..mouseButton );

end

function CHH_MouseButtonEditBox( editBox, editBoxIdx )

  local mb, mouseButton, actionType;
  local mouseSpellIdx = CHH_GetVari( editBox, 'mouseSpellIdx' );
  local editBoxName = editBox:GetName();

  for _,mb in CH_MOUSE_BUTTONS_ALL do
    if ( strfind(editBoxName,mb) ) then
      mouseButton = mb;
    end
  end

  actionType = CH_MouseSpells[mouseSpellIdx][mouseButton];

  if ( actionType == 'ANYITEM' ) then								-- inventory or bag item
    local itemName;
    itemName = editBox:GetText();
    if ( itemName == '' ) then
      CH_MouseSpellsData[mouseSpellIdx][mouseButton] = nil;
      editBox:SetTextColor( 1, 0.5, 0 );
    else
      local slotID,slotName,invItemName = CH_FindInventoryItemByName( itemName );
      local bag,slot,bagItemName = CH_FindBagItemByName( itemName );
      if ( slotID ~= nil ) then
        editBox:SetTextColor( 0, 1, 0 );
        CH_MouseSpellsData[mouseSpellIdx][mouseButton] = {invItemName};
        editBox:SetText( invItemName );
      elseif ( bag ~= nil ) then
        editBox:SetTextColor( 0, 1, 0 );
        CH_MouseSpellsData[mouseSpellIdx][mouseButton] = {bagItemName};
        editBox:SetText( bagItemName );
      else
        editBox:SetTextColor( 1, 0.5, 0 );
        CH_MouseSpellsData[mouseSpellIdx][mouseButton] = {itemName};
      end
    end
  else												-- or something else (no spell)
    local actionText;
    actionText = editBox:GetText();
    if ( actionText == '' ) then
      actionText = nil;
    end
    CH_MouseSpellsData[mouseSpellIdx][mouseButton][editBoxIdx] = actionText;
  end

end

-- ============================================================================
--   someone clicked the help button
-- ============================================================================

function CH_HelpButton()

  local version = string.format( "%d.%02d.%02d", floor(CH_Version/10000), floor(mod(CH_Version,10000)/100), mod(CH_Version,100) );

  CHH_Page( 'help' );
  CHH_Frame:Show();

  CHH_FrameTitleText:SetText( 'ClickHeal v'..version );

  if ( CH_UnitClass('player') ~= 'SHAMAN' ) then
    CHH_ButtonTotem:Hide();
  end

end

-- ============================================================================
--   one of the help tabs clicked
-- ============================================================================

function CHH_Page( page )

  local buffIdx,buffData,color;
  local msg = '';

  CHH_InitTabs( CHH_Help );

  CHH_HelpGeneral:Show();

  if ( page == 'help' ) then
    msg = CHHT_HELP_HELP;
  elseif ( page == 'abbr' ) then
    msg = CHHT_HELP_TEXT_DEBUFFS..
          CHHT_HELP_TEXT_HOT..
          CHHT_HELP_TEXT_SHIELD..
          CHHT_HELP_TEXT_BUFFS;

    for buffIdx,buffData in CH_BUFF_DATA do
      if ( CH_UnitCanLearnBuff(buffIdx,'player') ) then
        if ( CH_BUFF_DATA[buffIdx].isWeaponBuff ) then
          color = "|c00FF00FF";
        else
          color = "|c00FFFF00";
        end
        msg = msg .. color..buffData.effect.."|r ("..buffData.displayName..")\n";
      end
    end
    msg = msg .. "|c00FFFF00*|r "..CHHT_HELP_TRACKING_BUFF.."\n";
    msg = msg .. "\n";

    msg = msg .. CHHT_HELP_TEXT_FINETUNE;
    msg = msg .. CHHT_HELP_TEXT_UPPER_LOWER;
  elseif ( page == 'faq' ) then
    msg = CHHT_HELP_FAQ;
  elseif ( page == 'credits' ) then
    msg = CHHT_HELP_CREDITS;
  end

  CHH_HelpGeneralMyText:SetText( msg );

end
