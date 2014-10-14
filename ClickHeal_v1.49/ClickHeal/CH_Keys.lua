--=============================================================================
-- File:	CH_Keys.lua
-- Author:	rudy
-- Description:	Key bindings and slash commands for ClickHeal
--=============================================================================

function CH_SlashCmdClickHeal( param )

  if ( not param or param == '' ) then
    CH_HelpButton();
  elseif ( param == 'reset' ) then
    CH_ResetFramePositions();
  else
    CH_Msg( 'Unknown parameter: '..param );
    CH_Msg( 'Usage: /clickheal [reset]' );
  end

end

function CH_KeyToggleClickHealFrames()

  CH_ConfigSetOption( 'showClickHeal', not CH_ConfigGetOption('showClickHeal') );

end

function CH_KeyToggleAnchors()

  CH_ConfigSetOption( 'showAnchors', not CH_ConfigGetOption('showAnchors') );

end

function CH_SwitchPanicBehavior( newOption )

  if ( CH_PlayerIsInBattlefield() ) then
    CH_ConfigSetOption( 'panicBehaviorInBattlefield', newOption );
  else
    CH_ConfigSetOption( 'panicBehavior', newOption );
  end

  if ( CHH_PanicGeneral:IsVisible() ) then
    CHH_PanicInit();
  end

end

function CH_RaidShowConfig()

  CH_HelpButton();
  CHH_ExtendedRaidTab();

end

function CH_RaidToggleFrames( config )

  CH_ConfigSetOption( config, not CH_ConfigGetOption(config) );

  if ( CHH_GuiRaid:IsVisible() ) then
    CHH_GuiRaidTab();
  end

end

function CH_KeyAssistMainTank( no )

  local tankName = CH_MainTankUnitName( no );

  if ( tankName ) then
    AssistByName( tankName );
  end

end
