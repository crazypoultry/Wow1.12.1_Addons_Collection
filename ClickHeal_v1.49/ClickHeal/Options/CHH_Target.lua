--=============================================================================
-- File:	CH_Help.lua
-- Author:	rudy
-- Description:	Help pages and config
--=============================================================================

CHH_EnemyTargetingModeOptions = {{key='KEEP',   label=CHHT_TARGET_TARGETING_KEEP},
                                 {key='TARGET', label=CHHT_TARGET_TARGETING_TARGET},
                                 {key='INT',    label=CHHT_TARGET_TARGETING_INT}};

function CHHL_TargetColorLabel( colorIdx )

  local color, label;

  if ( CH_Config.nameColor[colorIdx] and CH_Config.nameColor[colorIdx] ~= 'DEFAULT' ) then
    color = CH_Config.nameColor[colorIdx];
  else
    color = CH_DEFAULT_NAME_COLOR[colorIdx];
  end

  label = "|cFF"..CH_COLOR[color].html;
  
  if ( CH_Config.nameColor[colorIdx] == 'DEFAULT' ) then
    label = label..CHHT_LABEL_DEFAULT;
  else
    label = label..CH_COLOR[color].name;
  end
  label = label.."|r";

  return( label );

end

function CHHL_TargetInitColorDropdown( dropdown, colorIdx )

  dropdown.colorIdx = colorIdx;
  dropdown.frameName = dropdown:GetName();
  UIDropDownMenu_Initialize( dropdown, CHH_TargetGeneralColorAssignInit );
  UIDropDownMenu_SetText( CHHL_TargetColorLabel(colorIdx), dropdown );

end

function CHH_TargetInit()

  CHH_InitTabs( CHH_Target, CHH_TargetGeneral, 'ENEMY', 'MISC', CHH_TargetInit, nil );

  CHHL_TargetInitColorDropdown( CHH_TargetGeneralColorAssignPlayer, 'playertarget' );
  CHHL_TargetInitColorDropdown( CHH_TargetGeneralColorAssignParty1, 'party1target' );
  CHHL_TargetInitColorDropdown( CHH_TargetGeneralColorAssignParty2, 'party2target' );
  CHHL_TargetInitColorDropdown( CHH_TargetGeneralColorAssignParty3, 'party3target' );
  CHHL_TargetInitColorDropdown( CHH_TargetGeneralColorAssignParty4, 'party4target' );
  CHHL_TargetInitColorDropdown( CHH_TargetGeneralColorAssignPet, 'pettarget' );
  CHHL_TargetInitColorDropdown( CHH_TargetGeneralColorAssignPartyPet1, 'partypet1target' );
  CHHL_TargetInitColorDropdown( CHH_TargetGeneralColorAssignPartyPet2, 'partypet2target' );
  CHHL_TargetInitColorDropdown( CHH_TargetGeneralColorAssignPartyPet3, 'partypet3target' );
  CHHL_TargetInitColorDropdown( CHH_TargetGeneralColorAssignPartyPet4, 'partypet4target' );

  CHH_TargetShapeshiftFormToggle( false );

  if ( CHH_Target.currentShapeshiftForm == nil ) then
    CHH_Target.currentShapeshiftForm = CH_GetShapeshiftFormIdx();
  end
  CHH_Target.currentMousePage = nil;

end

function CHH_TargetSpellAssignInit( idx )

  local shapeshift = (CHH_Target.currentShapeshiftForm or '' );

  CHH_InitTabs( CHH_Target, CHH_TargetAction, 'ENEMY', 'MOUSE', nil, nil );
  CHH_SpellAssignInit( 'CHH_TargetAction', 'Enemy'..shapeshift, 'enemy', idx, CHHT_TARGET_MOUSE_TITLE );
  CHH_TargetShapeshiftFormToggle( true );

  CHH_Target.currentMousePage = idx;

end

function CHH_TargetResetDefaults( )

  if ( CHH_Target.currentMousePage == nil ) then
    CH_ConfigReset( 'ENEMY', 'MISC' );
    CHH_TargetInit();
  else
    CH_ConfigReset( 'ENEMY', 'MOUSE', CHH_Target.currentShapeshiftForm );
    CHH_TargetSpellAssignInit( CHH_Target.currentMousePage );
  end

end

function CHH_TargetGeneralColorAssignInit( level )

  local k, colorGroupIdx;
  local info = {};
  local colorIdx;
  local frameName;

  -- level 2 -----------------------------------------------
  if ( level == 1 ) then
    colorIdx = CHH_GetVari( this, 'colorIdx' );
    frameName = CHH_GetVari( this, 'frameName' );
    if ( not colorIdx ) then
      return;
    end

    for k,_ in CH_COLOR_GROUP do
      info.text = string.format( CHHT_COLOR_GROUP_LABEL_FORMAT, k );
      info.hasArrow = 1;
      info.check = nil;
      info.value = {colorIdx=colorIdx,colorGroupIdx=k,frameName=frameName};
      UIDropDownMenu_AddButton( info, 1 );
    end

    info.text = "|cFF"..CH_COLOR[CH_DEFAULT_NAME_COLOR[colorIdx]].html..CHHT_LABEL_DEFAULT.."|r";	-- better readable (alpha?)
    info.hasArrow = nil;
    info.check = nil;
    info.func = CHH_TargetGeneralColorAssignClicked;
    info.value = {colorIdx=colorIdx,color='DEFAULT',frameName=frameName};
    UIDropDownMenu_AddButton( info, 1 );
  -- level 2 -----------------------------------------------
  elseif ( level == 2 ) then
    colorIdx = UIDROPDOWNMENU_MENU_VALUE.colorIdx;
    colorGroupIdx = UIDROPDOWNMENU_MENU_VALUE.colorGroupIdx;
    frameName = UIDROPDOWNMENU_MENU_VALUE.frameName;
    for _,k in CH_COLOR_GROUP[colorGroupIdx] do
      info.text = "|cFF"..CH_COLOR[k].html..CH_COLOR[k].name.."|r";			-- better readable (alpha?)
--      info.text = CH_COLOR[k].name;
--      info.textR = CH_COLOR[k].r;
--      info.textG = CH_COLOR[k].g;
--      info.textB = CH_COLOR[k].b;
      info.check = nil;
      info.func = CHH_TargetGeneralColorAssignClicked;
      info.value = {colorIdx=colorIdx,color=k,frameName=frameName};
      UIDropDownMenu_AddButton( info, 2 );
    end
  end

end

function CHH_TargetGeneralColorAssignClicked()

  CH_Config.nameColor[this.value.colorIdx] = this.value.color;
  UIDropDownMenu_SetText( CHHL_TargetColorLabel(this.value.colorIdx), getglobal(this.value.frameName) );

end

function CHH_TargetShapeshiftFormToggle( flag )

  if ( flag and CH_CLASS_INFO[CH_UnitClass('player')].shapeshift ) then
    CHH_TargetShapeshiftForm:Show();
    UIDropDownMenu_Initialize( CHH_TargetShapeshiftForm, CHH_TargetShapeshiftFormInit );
  else
    CHH_TargetShapeshiftForm:Hide();
  end

end

function CHH_TargetShapeshiftFormInit()

  local k, v;
  local info = {};

  for k,v in CH_CLASS_INFO[CH_UnitClass('player')].shapeshift.forms do
    info.text = v;
    if ( k == CHH_Target.currentShapeshiftForm ) then
      info.check = 1;
      UIDropDownMenu_SetText( v, CHH_TargetShapeshiftForm );
    else
      info.check = nil;
    end
    info.func = CHH_TargetShapeshiftFormClicked;
    info.value = { shapeshiftForm=k };
    UIDropDownMenu_AddButton(info);
  end

end

function CHH_TargetShapeshiftFormClicked()

  CHH_Target.currentShapeshiftForm = this.value.shapeshiftForm;
  UIDropDownMenu_SetText( CH_CLASS_INFO[CH_UnitClass('player')].shapeshift.forms[CHH_Target.currentShapeshiftForm], CHH_TargetShapeshiftForm );

  CHH_TargetSpellAssignInit( CHH_Target.currentMousePage );

end
