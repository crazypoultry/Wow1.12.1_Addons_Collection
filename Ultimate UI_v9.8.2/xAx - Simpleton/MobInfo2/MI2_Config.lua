
-----------------------------------------------------------------------------
-- MI2_OptionsFrameOnLoad()
--
-- This "OnLoad" event handler for the options dialog installs the
-- ESC key handler.
-----------------------------------------------------------------------------
function MI2_OptionsFrameOnLoad()
  tinsert(UISpecialFrames, "frmMIConfig"); -- Esc Closes Options Frame
  UIPanelWindows["frmMIConfig"] = {area = "center", pushable = 0};
end  -- MI2_OptionsFrameOnLoad()


-----------------------------------------------------------------------------
-- MI2_SetHealthOptionsState()
--
-- Set the state of health options in health options dialog to either
-- enabled or disabled, as indicated by "MobInfoConfig.DisableHealth".
-----------------------------------------------------------------------------
function MI2_SetHealthOptionsState()
  local r,g,b;
  
  if  MobInfoConfig.DisableHealth > 0  then
    r = 0.5; g = 0.5; b = 0.5;
    MI2_OptStableMax:Disable();
    MI2_OptShowPercent:Disable();
  else
    r = 1.0; g = 0.8; b = 0.0;
    MI2_OptStableMax:Enable();
    MI2_OptShowPercent:Enable();
  end
  
  MI2_OptStableMaxText:SetTextColor( r, g, b );
  MI2_OptShowPercentText:SetTextColor( r, g, b );
  MI2_OptHealthPosXText:SetTextColor( r, g, b );
  MI2_OptHealthPosYText:SetTextColor( r, g, b );
  MI2_OptManaDistanceText:SetTextColor( r, g, b );
end  -- of MI2_SetHealthOptionsState()


-----------------------------------------------------------------------------
-- MI2_UpdateOptions()
--
-- Show help text for current hovered option in options dialog
-- in the game tooltip window.
-----------------------------------------------------------------------------
function MI2_UpdateOptions()
  MI2_OptShowClass:SetChecked(MobInfoConfig.ShowClass);
  MI2_OptShowHealth:SetChecked(MobInfoConfig.ShowHealth);
  MI2_OptShowDamage:SetChecked(MobInfoConfig.ShowDamage);
  MI2_OptShowKills:SetChecked(MobInfoConfig.ShowKills);
  MI2_OptShowLoots:SetChecked(MobInfoConfig.ShowLoots);
  MI2_OptShowEmpty:SetChecked(MobInfoConfig.ShowEmpty);
  MI2_OptShowXp:SetChecked(MobInfoConfig.ShowXp);
  MI2_OptShowNo2lev:SetChecked(MobInfoConfig.ShowNo2lev);
  MI2_OptShowQuality:SetChecked(MobInfoConfig.ShowQuality);
  MI2_OptShowCloth:SetChecked(MobInfoConfig.ShowCloth);
  MI2_OptShowCoin:SetChecked(MobInfoConfig.ShowCoin);
  MI2_OptShowIV:SetChecked( MobInfoConfig.ShowIV);
  MI2_OptShowTotal:SetChecked(MobInfoConfig.ShowTotal);
  MI2_OptShowBlankLines:SetChecked(MobInfoConfig.ShowBlankLines);
  MI2_OptSaveAllValues:SetChecked(MobInfoConfig.SaveAllValues);
  MI2_OptClearOnExit:SetChecked(MobInfoConfig.ClearOnExit);
  MI2_OptCombinedMode:SetChecked(MobInfoConfig.CombinedMode);
  MI2_OptKeypressMode:SetChecked(MobInfoConfig.KeypressMode);
  MI2_OptDisableHealth:SetChecked(MobInfoConfig.DisableHealth);
  MI2_OptStableMax:SetChecked(MobInfoConfig.StableMax);
  MI2_OptShowPercent:SetChecked(MobInfoConfig.ShowPercent);
  MI2_OptShowCombined:SetChecked(MobInfoConfig.ShowCombined);

  MI2_OptHealthPosX:SetValue( MobInfoConfig.HealthPosX );
  MI2_OptHealthPosY:SetValue( MobInfoConfig.HealthPosY );
  MI2_OptManaDistance:SetValue( MobInfoConfig.ManaDistance );
  
  -- handle enabling/disabling MobHealth
  MI2_SetHealthOptionsState();
end  -- MI2_UpdateOptions()


-----------------------------------------------------------------------------
-- MI2_ShowOptionHelpTooltip()
--
-- Show help text for current hovered option in options dialog
-- in the game tooltip window.
-----------------------------------------------------------------------------
function MI2_ShowOptionHelpTooltip()
  GameTooltip_SetDefaultAnchor( GameTooltip, UIParent );
  GameTooltip:SetText( mifontWhite..MI2_OPTIONS[this:GetName()].text );
  
--  if  this:GetName() == "MI2_OptHealthPosY" 
--      or  this:GetName() == "MI2_OptHealthPosX" 
--      or  this:GetName() == "MI2_OptManaDistance"  then
--    GameTooltip:AddLine( mifontWhite.."Pos = "..math.floor(this:GetValue()) );
--  end
  
  GameTooltip:AddLine(mifontGold..MI2_OPTIONS[this:GetName()].help);
  if MI2_OPTIONS[this:GetName()].info then
    GameTooltip:AddLine(mifontGold..MI2_OPTIONS[this:GetName()].info);
  end
  GameTooltip:Show();
end -- of MI2_ShowOptionHelpTooltip()


-----------------------------------------------------------------------------
-- MI2_OptionsFrameOnShow()
--
-- Show help text for current hovered option in options dialog
-- in the game tooltip window.
-----------------------------------------------------------------------------
function MI2_OptionsFrameOnShow()
  txtMIConfigTitle:SetText( MI_TXT_CONFIG_TITLE );
  chattext(txtMIConfigTitle:GetText());

  -- Disable the button to enable built-in MobHealth if MobHealth
  -- has been automatically disabled
  if  MobInfoConfig.DisableHealth == 2  then
    MI2_OptDisableHealth:Disable();
    MI2_OptDisableHealthText:SetTextColor( 0.5, 0.5, 0.5 );
  end
  
  MI2_OptHealthPosYLow:Hide( );
  MI2_OptHealthPosYHigh:Hide( );
  MI2_OptHealthPosXLow:Hide( );
  MI2_OptHealthPosXHigh:Hide( );
  MI2_OptManaDistanceLow:Hide( );
  MI2_OptManaDistanceHigh:Hide( );
  MI2_OptHealthPosY:SetMinMaxValues( -20, 80 );
  MI2_OptHealthPosX:SetMinMaxValues( -25, 25 );
  MI2_OptManaDistance:SetMinMaxValues( -30, 10 );
  MI2_OptHealthPosX:SetValueStep( 1 );
  MI2_OptHealthPosY:SetValueStep( 1 );
  MI2_OptManaDistance:SetValueStep( 1 );

  MI2_UpdateOptions();
end  -- MI2_OptionsFrameOnShow()


function miConfig_OnMouseDown(arg1)
  if (arg1 == "LeftButton") then
		frmMIConfig:StartMoving();
	end
end


function miConfig_OnMouseUp(arg1)
  if (arg1 == "LeftButton") then
		frmMIConfig:StopMovingOrSizing();
  end
end


function miConfig_btnMIDone_OnClick()
  HideUIPanel(frmMIConfig);
	if MYADDONS_ACTIVE_OPTIONSFRAME then
    if (MYADDONS_ACTIVE_OPTIONSFRAME == this) then
      ShowUIPanel(myAddOnsFrame);
    end
  end
end

