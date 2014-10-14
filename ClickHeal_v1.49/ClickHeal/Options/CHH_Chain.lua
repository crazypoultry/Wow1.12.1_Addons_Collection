--=============================================================================
-- File:	CH_Chain.lua
-- Author:	rudy
-- Description:	Options for (Spell) Chains
--=============================================================================

local gChainCondition = {NONE='none',THEN='then',AND='and'};
local gChainFrequency = {ONCE='once',REFRESH='refresh',LOOP='loop'};

-- ============================================================================
--   Init lists for spell dropdown selection
-- ============================================================================

function CHH_ChainDropdownValues()

  local i;
  local data = {};

  for i=1,CH_MAX_CHAINS do
    data[i] = string.format( CHHT_CHAINS_NAME_FORMAT, i );
  end

  return( data );

end

-- ============================================================================
--   Spell Chain config             
-- ============================================================================

local function CHHL_ChainHideLine( mb )

  getglobal( 'CHH_ChainActionAction'..mb ):Hide();
  getglobal( 'CHH_ChainActionFrequency'..mb ):Hide();

end

local function CHHL_ChainShowLine( mb )

  getglobal( 'CHH_ChainActionAction'..mb ):Show();
  getglobal( 'CHH_ChainActionFrequency'..mb ):Show();

end

function CHH_ChainConditionDropDownInit()

  local k, v, info;
  local mouseSpellIdx = CHH_GetVari( this, 'mouseSpellIdx' );
  local mouseButton = CHH_GetVari( this, 'mouseButton' );
  local frameName = CHH_GetVari( this, 'frameName' );

  for k,v in gChainCondition do
    info = {};
    info.text = v;
    info.check = nil;
    info.func = CHH_ChainConditionDropDownClicked;
    info.value = {key=k,value=v,frameName=frameName,mouseSpellIdx=mouseSpellIdx,mouseButton=mouseButton};
    UIDropDownMenu_AddButton( info );
  end

end

function CHH_ChainConditionDropDownClicked()

  if ( this.value.key == 'NONE' ) then
    CH_MouseSpells[this.value.mouseSpellIdx][this.value.mouseButton] = nil;
    CH_MouseSpellsData[this.value.mouseSpellIdx][this.value.mouseButton] = nil;
    CH_ChainData[this.value.mouseSpellIdx][this.value.mouseButton] = nil;
    CHHL_ChainHideLine( this.value.mouseButton );
  elseif ( not CH_MouseSpells[this.value.mouseSpellIdx][this.value.mouseButton] ) then
    CH_ChainData[this.value.mouseSpellIdx][this.value.mouseButton] = {condition=this.value.key,frequency='ONCE'};
    CHHL_ChainShowLine( this.value.mouseButton );
  else
    CHHL_ChainShowLine( this.value.mouseButton );
  end

  UIDropDownMenu_SetText( this.value.value, getglobal(this.value.frameName) );

end

function CHH_ChainFrequencyDropDownInit()

  local k, v, info;
  local mouseSpellIdx = CHH_GetVari( this, 'mouseSpellIdx' );
  local mouseButton = CHH_GetVari( this, 'mouseButton' );
  local frameName = CHH_GetVari( this, 'frameName' );

  for k,v in gChainFrequency do
    info = {};
    info.text = v;
    info.check = nil;
    info.func = CHH_ChainFrequencyDropDownClicked;
    info.value = {key=k,value=v,frameName=frameName,mouseSpellIdx=mouseSpellIdx,mouseButton=mouseButton};
    UIDropDownMenu_AddButton( info );
  end

end

function CHH_ChainFrequencyDropDownClicked()

  CH_ChainData[this.value.mouseSpellIdx][this.value.mouseButton].frequency = this.value.key;

  UIDropDownMenu_SetText( this.value.value, getglobal(this.value.frameName) );

end

function CHH_ChainAssignInit( frameName, mouseSpellIdx, allowed, header )

  local i = 1;
  local yOffset = 30;
  local frame = getglobal( frameName );

  if ( header ) then
    getglobal(frameName..'TitleText'):SetText( header );
  end

  frame:Show();

  frame.mouseSpellIdx = mouseSpellIdx;
  frame.mouseSpellAllowed = allowed;

  while ( i <= CH_MAX_LINES_CHAIN ) do
    local mb = CH_MOUSE_BUTTONS_ALL[i];
    local mouseButtonFrame = getglobal( frameName..'Action'..mb );
    local mouseButtonFrameText = getglobal( frameName..'Action'..mb..'MyText' );
    local conditionFrame = getglobal( frameName..'Condition'..mb );
    local frequencyFrame = getglobal( frameName..'Frequency'..mb );

    conditionFrame.mouseButton = mb;
    conditionFrame.frameName = conditionFrame:GetName();
    frequencyFrame.mouseButton = mb;
    frequencyFrame.frameName = frequencyFrame:GetName();
    mouseButtonFrame.mouseButton = mb;
    mouseButtonFrame.mouseSpellFrameName = frameName..'Action';

    conditionFrame:ClearAllPoints();
    conditionFrame:SetPoint( 'TOPLEFT', frame, 'TOPLEFT', 0, yOffset*-1 );
    UIDropDownMenu_Initialize( conditionFrame, CHH_ChainConditionDropDownInit );
    UIDropDownMenu_SetWidth( 60, conditionFrame );
    if ( CH_ChainData[mouseSpellIdx][mb] ) then
      UIDropDownMenu_SetText( gChainCondition[CH_ChainData[mouseSpellIdx][mb].condition], conditionFrame );
    else
      UIDropDownMenu_SetText( gChainCondition.NONE, conditionFrame );
    end
    conditionFrame:Show();
    mouseButtonFrameText:Hide();

    frequencyFrame:ClearAllPoints();
    frequencyFrame:SetPoint( 'TOPLEFT', frame, 'TOPLEFT', 570, yOffset*-1 );
    UIDropDownMenu_Initialize( frequencyFrame, CHH_ChainFrequencyDropDownInit );
    UIDropDownMenu_SetWidth( 70, frequencyFrame );
    if ( CH_ChainData[mouseSpellIdx][mb] ) then
      UIDropDownMenu_SetText( gChainFrequency[CH_ChainData[mouseSpellIdx][mb].frequency], frequencyFrame );
      frequencyFrame:Show();
    else
      UIDropDownMenu_SetText( gChainFrequency.ONCE, frequencyFrame );
      frequencyFrame:Hide();
    end

    mouseButtonFrame:ClearAllPoints();
    mouseButtonFrame:SetPoint( 'TOPLEFT', frame, 'TOPLEFT', 90, yOffset*-1 );
    UIDropDownMenu_Initialize( mouseButtonFrame, CHH_SpellAssignDropDownInit );
    UIDropDownMenu_SetWidth( 150, mouseButtonFrame );
    if ( CH_ChainData[mouseSpellIdx][mb] ) then
      UIDropDownMenu_SetText( CHH_GetActionLabel(CH_MouseSpells[mouseSpellIdx][mb]), mouseButtonFrame );
      mouseButtonFrame:Show();
    else
      UIDropDownMenu_SetText( '', mouseButtonFrame );
      mouseButtonFrame:Hide();
    end

    CHH_ShowEditBox( mouseSpellIdx, mb, frameName..'Action'..mb );

    yOffset = yOffset + 30;
    i = i + 1;
  end 

end

function CHH_ChainSpellAssign( chainIdx )

  if ( not CH_ChainData['Chain'..chainIdx] ) then
    CH_MouseSpells['Chain'..chainIdx] = {};
    CH_MouseSpellsData['Chain'..chainIdx] = {};
    CH_ChainData['Chain'..chainIdx] = {};
  end

  CHH_InitTabs( CHH_Chain, CHH_ChainAction, 'CHAIN'..chainIdx, 'CHAIN', CHH_ChainSpellAssign, chainIdx );
  CHH_ChainAssignInit( 'CHH_ChainAction', 'Chain'..chainIdx, 'chain', string.format(CHHT_CHAINS_TITLE_FORMAT,chainIdx) );

end
