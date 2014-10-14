--=============================================================================
-- File:		TA_SlashCmds.lua
-- Author:		rudy
-- Description:		The slash commands for TankAssist
--=============================================================================


--=============================================================================
-- Stores the main assist
--
function TA_SetAssist1( assistName )

  TA_SetAssist( assistName, 1, false );

end


--=============================================================================
-- Stores the secondary assist
--
function TA_SetAssist2( assistName )

  TA_SetAssist( assistName, 2, false );

end

--=============================================================================
-- Stores the 3 assist
--
function TA_SetAssist3( assistName )

  TA_SetAssist( assistName, 3, false );

end

--=============================================================================
-- Stores the 4 assist
--
function TA_SetAssist4( assistName )

  TA_SetAssist( assistName, 4, false );

end

--=============================================================================
-- Assists the given index or opens config dialog
--
function TA_Assist( idx )

  if ( not idx or idx == '' ) then
    TA_Help();
--    TA_OpenConfig();
  else
    TA_AssistTank( tonumber(idx) );
  end

end

--=============================================================================
-- Resets the frame window postion
--
function TA_Reset( )

  TA_ResetFrames();

end

--=============================================================================
-- Toggles dhe display of the target of the tank
--
function TA_ToggleTarget( newState )
  local updateKhaos = false;

  if ( TankAssist_showTarget ) then
    TA_ShowTarget( false, false );
  else
    TA_ShowTarget( true, false );
  end

end


--=============================================================================
-- Shows the help
--
function TA_Help()

  TA_Msg( '"/tankassist1 name" or "/ta1 name":' );
  TA_Msg( "- Set assist 1 to name, possible 1-4" );
  TA_Msg( '"/tankassist 1" or "/ta 1":' );
  TA_Msg( '- Assist tank number 1 (1-4)' );
  TA_Msg( '"/tareset": resets the frames' );
  TA_Msg( '"/tatoggletarget": shows/hide target of tank' );

end

--=============================================================================
-- Initializes the slash commands
--
function TA_InitSlashCommands()

  SlashCmdList["TANKASSISTSETONE"] = TA_SetAssist1;
  SLASH_TANKASSISTSETONE1 = "/tankassist1";
  SLASH_TANKASSISTSETONE2 = "/ta1";
  SLASH_TANKASSISTSETONE3 = "/settankassist1";

  SlashCmdList["TANKASSISTSETTWO"] = TA_SetAssist2;
  SLASH_TANKASSISTSETTWO1 = "/tankassist2";
  SLASH_TANKASSISTSETTWO2 = "/ta2";
  SLASH_TANKASSISTSETTWO3 = "/settankassist2";

  SlashCmdList["TANKASSISTSETTHREE"] = TA_SetAssist3;
  SLASH_TANKASSISTSETTHREE1 = "/tankassist3";
  SLASH_TANKASSISTSETTHREE2 = "/ta3";
  SLASH_TANKASSISTSETTHREE3 = "/settankassist3";

  SlashCmdList["TANKASSISTSETFOUR"] = TA_SetAssist4;
  SLASH_TANKASSISTSETFOUR1 = "/tankassist4";
  SLASH_TANKASSISTSETFOUR2 = "/ta4";
  SLASH_TANKASSISTSETFOUR3 = "/settankassist4";

  SlashCmdList["TANKASSISTASSIST"] = TA_Assist;
  SLASH_TANKASSISTASSIST1 = "/tankassist";
  SLASH_TANKASSISTASSIST2 = "/ta";
  SLASH_TANKASSISTASSIST3 = "/tassist";

  SlashCmdList["TANKASSISTRESET"] = TA_Reset;
  SLASH_TANKASSISTRESET1 = "/tareset";

  SlashCmdList["TANKASSISTSHOWTARGET"] = TA_ToggleTarget;
  SLASH_TANKASSISTSHOWTARGET1 = "/tatoggletarget";

end
