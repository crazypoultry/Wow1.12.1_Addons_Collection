--=============================================================================
-- File:	CHH_Totemset.lua
-- Author:	rudy
-- Description:	Config for Totem sets
--=============================================================================

-- ============================================================================
--   Action Drop down assign
-- ============================================================================

function CHH_TotemsetDropdownValues()

  local i;
  local data = {};

  for i=1,CH_MAX_TOTEM_SETS do
    data[i] = string.format( CHHT_TOTEMSET_LABEL_FORMAT, i );
  end

  return( data );

end

-- ============================================================================
--   Totem config             
-- ============================================================================

local function CHHL_TotemColor( element, info )

  local color;

  info.textR = 0;
  info.textG = 0;
  info.textB = 0;

  if ( element == 'Fire' ) then
    info.textR = 1;
    color = 'FF0000';
  elseif ( element == 'Air' ) then
    info.textR = 1;
    info.textG = 1;
    info.textB = 1;
    color = 'FFFFFF';
  elseif ( element == 'Water' ) then
    info.textG = 1;
    info.textB = 1;
    color = '00FFFF';
  elseif ( element == 'Earth' ) then
    info.textR = 0.75;
    info.textG = 0.35;
    color = 'C05800';
  elseif ( element == 'None' ) then
    info.textR = 1;
    info.textG = 1;
    color = 'FFFF00';
  end

  return( "|c00"..color );

end

local function CHHL_InitTotem( frame, set, spell )

  local v, label;
  local dummy = {};
  local element, rts;

  if ( CH_TotemSetData[set][spell].name == 'None' ) then
    element = 'None';
    label = CHHT_LABEL_NONE;
  else
    for _,v in CH_TOTEMS do
      if ( v.totem == CH_TotemSetData[set][spell].name ) then
        element = v.element;
      end
    end
    label = CH_TotemSetData[set][spell].name;
  end

  UIDropDownMenu_SetWidth( 150, frame );
  UIDropDownMenu_Initialize( frame, CHH_TotemSpellInit );
  UIDropDownMenu_SetText( CHHL_TotemColor(element,dummy)..label.."|r", frame );

  frame.totemSpell = spell;

end

function CHH_TotemInit()

  local set, spell, i;

  CHH_InitTabs( CHH_Totem, nil, 'TOTEMSET', 'TOTEMSET', CHH_TotemInit, nil );

  for set=1,CH_MAX_TOTEM_SETS do
    if ( CH_TotemSetData[set] == nil ) then
      CH_TotemSetData[set] = {};
      for i=1,4 do
        CH_TotemSetData[set][i] = {name='None',spellID=nil,wait=true};
      end
      CH_TotemSetData[set].lastCastTime = -1;
      CH_TotemSetData[set].nextTotem = 1;
      CH_TotemSetData[set].resetSeconds = 5;
    end

    getglobal("CHH_TotemSet"..set).totemSet = set;
    getglobal("CHH_TotemSet"..set.."TitleText"):SetText( string.format(CHHT_TOTEMSET_LABEL_FORMAT,set) );
    getglobal("CHH_TotemSet"..set..'ResetTime'):SetValue( CH_TotemSetData[set].resetSeconds );
    for spell=1,4 do
      CHHL_InitTotem( getglobal('CHH_TotemSet'..set..'Spell'..spell), set, spell );
    end
  end

end

function CHH_TotemSpellInit( )

  local k, v, spellID;
  local info = {};

  local totemSet = CHH_GetVari( this, 'totemSet' );
  local totemSpell = CHH_GetVari( this, 'totemSpell' );

  if ( totemSet == nil ) then
    return;
  end

  for k,v in CH_TOTEMS do
    spellID = CH_GetSpellID( v.totem, nil, BOOKTYPE_SPELL, false );
    if ( spellID > 0 ) then
      info = {};
      info.text = v.totem;
      info.check = nil;
      info.func = CHH_TotemSpellClicked;
      info.value = {totemName=v.totem,totemID=spellID,totemElement=v.element,totemSet=totemSet,totemSpell=totemSpell};
      CHHL_TotemColor( v.element, info );
      UIDropDownMenu_AddButton( info );
    end
  end

  info = {};
  info.text = CHHT_LABEL_NONE;
  info.check = nil;
  info.func = CHH_TotemSpellClicked;
  info.value = {totemName='None',totemID=nil,totemElement='None',totemSet=totemSet,totemSpell=totemSpell};
  CHHL_TotemColor( 'None', info );
  UIDropDownMenu_AddButton( info );

end

function CHH_TotemSpellClicked()

  local dummy = {};
  local totemName;

  if ( this.value.totemName == 'None' ) then
    totemName = CHHL_TotemColor(this.value.totemElement,dummy)..CHHT_LABEL_NONE.."|r";
  else
    totemName = CHHL_TotemColor(this.value.totemElement,dummy)..this.value.totemName.."|r";
  end
  UIDropDownMenu_SetText( totemName, getglobal('CHH_TotemSet'..this.value.totemSet..'Spell'..this.value.totemSpell) );

  CH_TotemSetData[this.value.totemSet][this.value.totemSpell].name = this.value.totemName;
  CH_TotemSetData[this.value.totemSet][this.value.totemSpell].spellID = this.value.totemID;

  CH_TotemSetData[this.value.totemSet][this.value.totemSpell].lastCastTime = -1;
  CH_TotemSetData[this.value.totemSet][this.value.totemSpell].nextTitem = 1;

end

function CHH_TotemSliderClicked()

  local totemSet = CHH_GetVari( this, 'totemSet' );
  local rt = this:GetValue();
  local rts;

  if ( rt == 0 ) then
    rts = 'none';
  else
    rts = string.format( CHHT_TOTEMSET_SLIDER_TITLE_FORMAT, rt );
  end

  getglobal(this:GetName().."Text"):SetText( string.format(CHHT_TOTEMSET_RESET_TIME_TITLE_FORMAT,rts) );

  if ( totemSet == nil or CH_TotemSetData == nil ) then				-- happens at OnLoad() of the XML
    return;
  end

  CH_TotemSetData[totemSet].resetSeconds = rt;
  CH_TotemSetData[totemSet].lastCastTime = -1;
  CH_TotemSetData[totemSet].nextTotem = 1;

end
