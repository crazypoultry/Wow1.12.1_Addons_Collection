--=============================================================================
-- File:	CHH_Common.lua
-- Author:	rudy
-- Description:	Config, Common functions
--=============================================================================

function CHH_GetVari( object, index )

  while ( object ) do
    if ( object[index] ~= nil ) then
      return( object[index] );
    end

    object = object:GetParent();
  end

  return( nil );

end

function CHH_DropdownSetLabel( spellName, frame, noneIdx, noneLabel )

  if ( spellName == noneIdx ) then
    UIDropDownMenu_SetText( noneLabel, frame );
  else
    UIDropDownMenu_SetText( spellName, frame );
  end

end

-- ----- Option prepanding ---------------------------------------------------------------------------------

function CHH_HintOptionSetConfigPrepand( key, value )

  this['ch_config_option_prepand_'..key] = value;

end

local function CHH_HintOptionBuildConfigOption( frame )

  if ( not frame ) then
    frame = this;
  end

  if ( frame.ch_config_option_prepand_key ) then
    pre = CHH_GetVari( frame, 'ch_config_option_prepand_'..frame.ch_config_option_prepand_key );
    if ( pre ) then
      frame.ch_config_option = pre .. frame.ch_config_option;
      frame.ch_config_option_prepand_key = nil;
    end
  end

end

-- ----- Common functions for HintXXXX ---------------------------------------------------------------------

function CHH_HintOptionCheckConfig()

  CHH_HintOptionBuildConfigOption( );

  if ( CH_ConfigGetOption(this.ch_config_option) == nil ) then
    CH_Dbg( 'Unknown option: '..(this.ch_config_option or 'NIL'), CH_DEBUG_ERR );
    return( false );
  end

  return( true );

end

local function CHHL_HintOptionSetPostClickFunc( postClickFunc )

  CHH_HintOptionBuildConfigOption( );

  this.ch_config_post_click_func = postClickFunc;

end

local function CHHL_HintOptionSetPrepandKey( prepandKey )

  this.ch_config_option_prepand_key = prepandKey;

end

-- ----- Hint CheckBox -------------------------------------------------------------------------------------

function CHH_HintOptionCheckBoxLoad( option, unused, frame )

  if ( frame == nil ) then
    frame = this;
  end

  frame.ch_config_option = option;

end

function CHH_HintOptionCheckBoxShow()

  CHH_HintOptionBuildConfigOption( );

  this:SetChecked( CH_Config[this.ch_config_option] );

end

function CHH_HintOptionCheckBoxClicked()

  CHH_HintOptionBuildConfigOption( );

  CH_ConfigSetOption( this.ch_config_option, CH_ToBoolean(this:GetChecked()) );

  if ( this.ch_config_post_click_func ) then
    this.ch_config_post_click_func();
  end

end

function CHH_HintOptionCheckBoxSetPostClickFunc( postClickFunc )

  CHHL_HintOptionSetPostClickFunc( postClickFunc );

end

function CHH_HintOptionCheckBoxSetPrepandKey( prepandKey )

  CHHL_HintOptionSetPrepandKey( prepandKey );

end

-- ----- Hint Slider ---------------------------------------------------------------------------------------

function CHH_HintOptionSliderLoad( option, min, max, step, minTxt, highTxt, title, titleMin, titleMax )

  this.ch_config_option = option;
  this.ch_slider_title = title;
  this.ch_slider_title_min = titleMin;
  this.ch_slider_title_max = titleMax;

  getglobal(this:GetName().."Text"):SetTextColor( CH_COLOR.WOWTEXTHIGHLIGHT.r, CH_COLOR.WOWTEXTHIGHLIGHT.g, CH_COLOR.WOWTEXTHIGHLIGHT.b );

  getglobal(this:GetName().."High"):SetText(highTxt);
  getglobal(this:GetName().."High"):SetTextColor( CH_COLOR.WOWTEXTNORMAL.r, CH_COLOR.WOWTEXTNORMAL.g, CH_COLOR.WOWTEXTNORMAL.b );
  getglobal(this:GetName().."Low"):SetText(minTxt);
  getglobal(this:GetName().."Low"):SetTextColor( CH_COLOR.WOWTEXTNORMAL.r, CH_COLOR.WOWTEXTNORMAL.g, CH_COLOR.WOWTEXTNORMAL.b );
  this:SetMinMaxValues(min,max);
  this:SetValueStep(step);

end

function CHH_HintOptionSliderShow()

  CHH_HintOptionBuildConfigOption( );

  this:SetValue( CH_Config[this.ch_config_option] );

end

function CHH_HintOptionSliderClicked()

  local rt = tonumber(this:GetValue());
  local min,max = this:GetMinMaxValues();

  CHH_HintOptionBuildConfigOption( );

  if ( this.ch_slider_title_min and rt == min ) then
    getglobal(this:GetName().."Text"):SetText( this.ch_slider_title_min );
  elseif ( this.ch_slider_title_max and rt == max ) then
    getglobal(this:GetName().."Text"):SetText( this.ch_slider_title_max );
  else 
    getglobal(this:GetName().."Text"):SetText( string.format(this.ch_slider_title,rt) );
  end

  CH_ConfigSetOption( this.ch_config_option, rt );

  if ( this.ch_config_post_click_func ) then
    this.ch_config_post_click_func();
  end

end

function CHH_HintOptionSliderSetPostClickFunc( postClickFunc )

  CHHL_HintOptionSetPostClickFunc( postClickFunc );

end

function CHH_HintOptionSliderSetPrepandKey( prepandKey )

  CHHL_HintOptionSetPrepandKey( prepandKey );

end

-- ----- HintDropDowns -------------------------------------------------------------------------------------

-- if value list is NIL, only hints are displayed
function CHH_HintDropDownLoad( option, valueList )

  this.ch_config_option = option;
  this.ch_value_list = valueList;

end

function CHH_HintDropDownShow()

  CHH_HintOptionBuildConfigOption( );

  if ( this.ch_value_list ) then
    UIDropDownMenu_Initialize( this, CHH_HintDropDownInitList );
  end

end

function CHH_HintDropDownInitList()

  local key, label, idx, dpFrame;
  local option, valueList;
  local info = {};

  if ( this.ch_config_option ) then
    CHH_HintOptionBuildConfigOption( );
    valueList = this.ch_value_list;
    option = this.ch_config_option;
    dpFrame = this;
  else
    CHH_HintOptionBuildConfigOption( this:GetParent() );
    valueList = this:GetParent().ch_value_list;
    option = this:GetParent().ch_config_option;
    dpFrame = this:GetParent();
  end

  for idx,_ in valueList do
    key = valueList[idx].key;
    label = valueList[idx].label;
    info.text = label;
    info.checked = nil;
    if ( key == CH_Config[option] ) then
      info.checked = 1;
      UIDropDownMenu_SetText( label, dpFrame );
    end
    info.func = CHH_HintDropDownClicked;
    info.value = {option=option,value=key,label=label,frameName=dpFrame:GetName()};
    UIDropDownMenu_AddButton(info);
  end

end

function CHH_HintDropDownClicked()

  CH_ConfigSetOption( this.value.option, this.value.value );
  UIDropDownMenu_SetText( this.value.label, getglobal(this.value.frameName) );

  if ( getglobal(this.value.frameName).ch_config_post_click_func ) then
    getglobal(this.value.frameName).ch_config_post_click_func();
  end

end

function CHH_HintDropDownSetPostClickFunc( postClickFunc )

  CHHL_HintOptionSetPostClickFunc( postClickFunc );

end

function CHH_HintOptionDropDownSetPrepandKey( prepandKey )

  CHHL_HintOptionSetPrepandKey( prepandKey );

end

-- ----- HintEditBox ---------------------------------------------------------------------------------------

function CHH_HintEditBoxLoad( option )

  this.ch_config_option = option;
  this:SetAutoFocus( false );

end

function CHH_HintOptionEditBoxSetPrepandKey( prepandKey )

  CHHL_HintOptionSetPrepandKey( prepandKey );

end


