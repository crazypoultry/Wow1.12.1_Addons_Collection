--=============================================================================
-- File:		TankAssist.lua
-- Author:		rudy
-- Description:		Assist a tank
-- 
-- Changes:
--     v1.1 : - name of target now max of 2 lines
--            - fixed alignment of Tank's target (now in center again)
--=============================================================================


-- ####################################################################################################################
-- # Variables
-- ####################################################################################################################

TankAssist_assist1Name = 'none';
TankAssist_assist2Name = 'none';
TankAssist_assist3Name = 'none';
TankAssist_assist4Name = 'none';

TankAssist_showTarget = true;

local gAssist1Unit = nil;
local gAssist2Unit = nil;
local gAssist3Unit = nil;
local gAssist4Unit = nil;

local maIsMoving = false;

local FRAME_HEIGHT = 34;
local FRAME_HEIGHT_SHOW_TARGET = FRAME_HEIGHT + 12;

-- ####################################################################################################################
-- # Helper functions
-- ####################################################################################################################

function TA_Msg( msg )
   if( DEFAULT_CHAT_FRAME ) then
      DEFAULT_CHAT_FRAME:AddMessage("<TA> "..msg, 0.0, 1.0, 0.0);
   end
end

function TA_SetAssist( assistName, index, byKhaos )

  local i, name;

  if ( assistName == nil or assistName == '' ) then
    if ( UnitName('target') and UnitIsFriend('player','target') and UnitIsPlayer('target') ) then
      assistName = UnitName('target');
    else
      assistName = 'none';
    end
  end

  for i=1,GetNumPartyMembers() do
    name = UnitName( 'party'..i );
    if ( strlower(assistName) == strlower(name) ) then
      assistName = name;
    end
    name = UnitName( 'partypet'..i );
    if ( name and strlower(assistName) == strlower(name) ) then
      assistName = name;
    end
  end

  for i=1,GetNumRaidMembers() do
    name = UnitName( 'raid'..i );
    if ( strlower(assistName) == strlower(name) ) then
      assistName = name;
    end
    name = UnitName( 'raidpet'..i );
    if ( name and strlower(assistName) == strlower(name) ) then
      assistName = name;
    end
  end

  name = UnitName( 'player' );
  if ( strlower(assistName) == strlower(name) ) then
    assistName = name;
  end

  name = UnitName( 'pet' );
  if ( name and strlower(assistName) == strlower(name) ) then
    assistName = name;
  end

  if ( not byKhaos ) then
    TA_Msg( "Assist "..index.." set to "..assistName );
  end

  setglobal( "TankAssist_assist"..index.."Name", assistName );

  TA_OnMAUpdate( index );

  if ( Khaos and not byKhaos ) then
    Khaos.setSetKeyParameter( "TankAssist", "KeyAssist"..index.."Name", "value", assistName );
    Khaos.refresh( false, false, true );
  end

end

function TA_ResetFrames()

  TA_OnMALoad( 1 );
  TA_OnMALoad( 2 );
  TA_OnMALoad( 3 );
  TA_OnMALoad( 4 );

end

function TA_ShowTarget( newState, byKhaos )

  TankAssist_showTarget = newState;

  TA_AdjustFrame( 1 );
  TA_AdjustFrame( 2 );
  TA_AdjustFrame( 3 );
  TA_AdjustFrame( 4 );

  if ( Khaos and not byKhaos ) then
    Khaos.setSetKeyParameter( "TankAssist", "KeyShowTarget", "checked", TankAssist_showTarget );
    Khaos.refresh( false, false, true );
  end

end

local function TAL_IsValidAttackTarget( unit )

  if ( UnitName(unit) and
       UnitCanAttack('player',unit) and
       UnitIsEnemy('player',unit) and
       (not UnitIsDeadOrGhost(unit)) )
  then
    return( true );
  end

  return( false );

end

local function TAL_GetMTUnit( name )

  for i=1, GetNumPartyMembers() do 
    if ( UnitName("party"..i) == name ) then
      return( "party"..i );
    end
    if ( UnitName("partypet"..i) == name ) then
      return( "partypet"..i );
    end
  end

  for i=1, GetNumRaidMembers() do 
    if ( UnitName("raid"..i) == name ) then
      return( "raid"..i );
    end
    if ( UnitName("raidpet"..i) == name ) then
      return( "raidpet"..i );
    end
  end

  if ( UnitName('player') == name ) then
    return( 'player' );
  end

  if ( UnitName('pet') == name ) then
    return( 'pet' );
  end

end

local function TAL_UpdateMT( name, unit, idx )

  local frame = getglobal( "TA_MA"..idx.."Frame" );
  local maText = getglobal( 'TA_MA'..idx..'NameText' );
  local maTargetText = getglobal( 'TA_MA'..idx..'NameTarget' );
  local maHPBar = getglobal( 'TA_MA'..idx..'HPBar' );
  local tankTarget, tankTargetName, tankTargetTarget, tankTargetTargetName, hp;

  if ( name == 'none' ) then
    frame:Hide();
    return( nil );
  end

  if ( unit == nil or UnitName(unit) ~= name ) then
    unit = TAL_GetMTUnit( name );
  end

  if ( unit ) then
    tankTarget = unit.."target";
    tankTargetName = UnitName( unit.."target" );
    if ( tankTargetName ) then
      maText:SetText( tankTargetName );
      if ( UnitIsUnit("target",tankTarget) ) then
        maText:SetTextColor( 1, 1, 1 );
      else
        maText:SetTextColor( 1, 1, 0 );
      end

      maHPBar:Show();
      hp = UnitHealth( tankTarget );
      if ( hp < 1 ) then
        maHPBar:SetValue( 0 );
      else
        maHPBar:SetValue( hp*100/UnitHealthMax(tankTarget) );
      end

      tankTargetTarget = tankTarget.."target";
      tankTargetTargetName = UnitName( tankTargetTarget );
      if ( tankTargetTargetName ) then
        maTargetText:SetText( tankTargetTargetName );
        maTargetText:SetTextColor( 0, 1, 1 );
      else
        maTargetText:SetText( "no target" );
        maTargetText:SetTextColor( 0.5, 0.5, 0.5 );
      end
    else
      maText:SetText( UnitName(unit).."'s target" );
      maText:SetTextColor( 0.5, 0.5, 0.5 );
      maTargetText:SetText( "no target" );
      maTargetText:SetTextColor( 0.5, 0.5, 0.5 );
      maHPBar:Hide();
    end
  else
    if ( not name ) then
      name = 'Unknown';
    end

    maText:SetText( name.." not in group/raid" );
    maText:SetTextColor( 0.5, 0.5, 0.5 );

    maHPBar:Hide();

    maTargetText:SetText( "unknown" );
    maTargetText:SetTextColor( 0.5, 0.5, 0.5 );
  end


  frame:Show();

  return( unit );

end

-- ####################################################################################################################
-- # Events
-- ####################################################################################################################

function TA_OnLoad()

  TA_InitSlashCommands();

  this:RegisterEvent( "VARIABLES_LOADED" );

end

function TA_OnEvent( event, arg1, arg2, arg3 )

  if ( event == 'VARIABLES_LOADED' ) then

    TA_Khaos_Register();

    TA_OnMAUpdate( 1 );
    TA_OnMAUpdate( 2 );
    TA_OnMAUpdate( 3 );
    TA_OnMAUpdate( 4 );

  end

end

function TA_AdjustFrame( idx )

  local frame = getglobal( 'TA_MA'..idx..'Frame' );
  local target = getglobal( 'TA_MA'..idx..'NameTarget' );
  local name = getglobal( 'TA_MA'..idx..'Name' );

  if ( TankAssist_showTarget ) then
    frame:SetHeight( FRAME_HEIGHT_SHOW_TARGET );
    name:ClearAllPoints();
    name:SetPoint( "TOPLEFT", frame, "TOPLEFT", 0, 0 );
    name:SetPoint( "BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0 );
    target:ClearAllPoints();
    target:SetPoint( "TOPLEFT", frame, "BOTTOMLEFT", 5, 20 );
    target:SetPoint( "BOTTOMRIGHT", frame, "BOTTOMRIGHT", -5, 5 );
    target:Show();
  else
    frame:SetHeight( FRAME_HEIGHT );
    name:SetPoint( "TOPLEFT", frame, "TOPLEFT", 0, 0 );
    name:SetPoint( "BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0 );
    target:Hide();
  end

end

function TA_OnMALoad( idx )

  local frame = getglobal( 'TA_MA'..idx..'Frame' );
  local name = getglobal( 'TA_MA'..idx..'Name' );
  local hpBar = getglobal( 'TA_MA'..idx..'HPBar' );
  local frameHeight = FRAME_HEIGHT;

  if ( TankAssist_showTarget ) then
    frameHeight = FRAME_HEIGHT_SHOW_TARGET;
  end

  frame:ClearAllPoints();
  frame:SetPoint( "TOP", "UIParent", "TOP", 0, -25-((idx-1)*frameHeight) );
  name:ClearAllPoints();
  name:SetPoint( "TOP", frame, "TOP", 0, -4 );
  name.index = idx;
  hpBar:ClearAllPoints();
  hpBar:SetPoint( "TOP", frame, "TOP", 0, -22 );
 
  TA_AdjustFrame( idx );

end

function TA_OnMAUpdate( idx )

  if ( idx == 1 ) then
    gAssist1Unit = TAL_UpdateMT( TankAssist_assist1Name, gAssist1Unit, 1 );
  elseif ( idx == 2 ) then
    gAssist2Unit = TAL_UpdateMT( TankAssist_assist2Name, gAssist2Unit, 2 );
  elseif ( idx == 3 ) then
    gAssist3Unit = TAL_UpdateMT( TankAssist_assist3Name, gAssist3Unit, 3 );
  elseif ( idx == 4 ) then
    gAssist4Unit = TAL_UpdateMT( TankAssist_assist4Name, gAssist4Unit, 4 );
  end

end

function TA_MAStopMoving( index )

  if ( maIsMoving ) then
    local frame = getglobal( 'TA_MA'..index..'Frame' );
    frame:StopMovingOrSizing();
    maIsMoving = false;
  end

end

function TA_AssistOrMove( index, arg1, arg2, arg3, arg4 )

  if ( IsShiftKeyDown() ) then
    local frame = getglobal( 'TA_MA'..index..'Frame' );
    frame:StartMoving();
    maIsMoving = true;
  else
    TA_AssistTank( index );
  end

end
  

-- ####################################################################################################################
-- # API
-- ####################################################################################################################

--=============================================================================
-- Retarget (after e.g. a heal)
-- first it tries to get your old enemy
-- if this is not possible, assist the tank
-- if also not possible, grab the nearest mob
--
function TA_ReTarget()

  -- last enemy?
  TargetLastEnemy();
  if ( TAL_IsValidAttackTarget('target') ) then
    return;
  end

  -- can we assist tank?
  if ( TankAssist_assist1Name and UnitName('player') ~= TankAssist_assist1Name ) then
    AssistByName( TankAssist_assist1Name );
    if ( TAL_IsValidAttackTarget('target') ) then
      return;
    end
  end

  -- at last, try to attack nearest enemy
  TargetNearestEnemy();

end

--=============================================================================
-- Assist the given index (1-4)
--
function TA_AssistTank( index )

  local name = 'none';

  -- ----- ASSIST
  if ( index == 1 ) then
    name = TankAssist_assist1Name;
  elseif ( index == 2 ) then
    name = TankAssist_assist2Name;
  elseif ( index == 3 ) then
    name = TankAssist_assist3Name;
  elseif ( index == 4 ) then
    name = TankAssist_assist4Name;
  end

  if ( name ~= 'none' ) then
    if ( name == UnitName('player') and UnitName("target") ) then
      DoEmote( EMOTE161_TOKEN );
    else
      AssistByName( name );
    end
  else
    TA_Msg( "No such tank defined (index "..index..")" );
  end

end

--=============================================================================
-- Assist the given partyID
-- If no assistID given, assist tank (only if partyID ~= tank)
-- If tank has an invalid target, target last enemy.
-- If there is no last enemy, attack closest enemy
--
-- NOTE: if "assistID" has a target, this will then change your target,
--       no matter if you can attack it or not!!!
function TA_AssistUnit( assistID )
  local name = nil;

  -- assistID passed ?
  if ( assistID ~= nil ) then
    if ( assistID == "P" and UnitName('player') ~= TankAssist_assist1Name ) then
      name = TankAssist_assist1Name;
    elseif ( assistID == "S" and UnitName('player') ~= TankAssist_assist2Name ) then
      name = TankAssist_assist2Name;
    else
      name = nil;
    end
  end

  if ( name ) then
    AssistByName( name );
    if ( TAL_IsValidAttackTarget('target') ) then
      return;
    end
  end

  -- can we assist current target
  if ( UnitName('target') ) then
    AssistUnit( 'target' );
    if ( TAL_IsValidAttackTarget('target') ) then
      return;
    end
  end

  -- target last enemy?
  TargetLastEnemy();
  if ( TAL_IsValidAttackTarget('target') ) then
    return;
  end

  -- at last, try to attack nearest enemy
  TargetNearestEnemy();

end
