--=============================================================================
-- File:	CH_Help.lua
-- Author:	rudy
-- Description:	Help pages and config
--=============================================================================

CHH_FriendHPLabelOptions         = {{key='PERCENT',      label=CHHT_FRIEND_HP_LABEL_PERCENT},
                                    {key='PERCENT_SIGN', label=CHHT_FRIEND_HP_LABEL_PERCENT_SIGN},
                                    {key='CURRENT',      label=CHHT_FRIEND_HP_LABEL_CURRENT},
                                    {key='MISSING',      label=CHHT_FRIEND_HP_LABEL_MISSING},
                                    {key='NONE',         label=CHHT_FRIEND_HP_LABEL_NONE}};
CHH_FriendPartyLabelOptions      = {{key='CLASS',        label=CHHT_FRIEND_PARTY_LABEL_CLASS},
                                    {key='NAME',         label=CHHT_FRIEND_PARTY_LABEL_NAME},
                                    {key='BOTH',         label=CHHT_FRIEND_PARTY_LABEL_BOTH},
                                    {key='COLOR',        label=CHHT_FRIEND_PARTY_LABEL_COLOR},
                                    {key='BOTHCOLOR',    label=CHHT_FRIEND_PARTY_LABEL_BOTHCOLOR}};
CHH_FriendDebuffsOptions         = {{key='NONE',         label=CHHT_FRIEND_FRIEND_DEBUFF_NONE},
                                    {key='CURABLE',      label=CHHT_FRIEND_FRIEND_DEBUFF_CURABLE},
                                    {key='ALL',          label=CHHT_FRIEND_FRIEND_DEBUFF_ALL}};
CHH_FriendResurrectDruidOptions  = {{key='AFTER_COMBAT', label=CHHT_FRIEND_RESURRECT_AFTER_COMBAT},
                                    {key='ALWAYS',       label=CHHT_FRIEND_RESURRECT_ALWAYS},
                                    {key='NEVER',        label=CHHT_FRIEND_RESURRECT_NEVER}};
CHH_FriendResurrectOtherOptions  = {{key='AFTER_COMBAT', label=CHHT_FRIEND_RESURRECT_AFTER_COMBAT},
                                   {key='NEVER',         label=CHHT_FRIEND_RESURRECT_NEVER}};
CHH_FriendFrameBackgroundOptions = {{key='HEALTH',       label=CHHT_FRIEND_FRAME_BACKGROUND_HEALTH},
                                    {key='CLASS',        label=CHHT_FRIEND_FRAME_BACKGROUND_CLASS},
                                    {key='CUSTOM',       label=CHHT_FRIEND_FRAME_BACKGROUND_CUSTOM}};
CHH_FriendCheckHealRangeOptions  = {{key='NEVER',        label=CHHT_FRIEND_CHECK_HEAL_RANGE_NEVER},
                                    {key='FOLLOW',       label=CHHT_FRIEND_CHECK_HEAL_RANGE_FOLLOW},
                                    {key='ONHWEVENT',    label=CHHT_FRIEND_CHECK_HEAL_RANGE_ONHWEVENT}};
CHH_FriendHealRangeVisOptions    = {{key='OOR',          label=CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_OOR},
                                    {key='HP',           label=CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_HP},
                                    {key='BACKGROUND',   label=CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_BACKGROUND},
                                    {key='NONE',         label=CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_NONE}};

-- ============================================================================
--   friend config             
-- ============================================================================

function CHH_FriendInit()

  local playerClass = CH_UnitClass( 'player' );

  CHH_InitTabs( CHH_Friend, CHH_FriendGeneral, 'FRIEND', 'MISC', CHH_FriendInit, nil );

  if ( playerClass ~= 'PRIEST' and playerClass ~= 'DRUID' ) then
    CHH_FriendGeneralFinetuneSpell1:Hide();
    CHH_FriendGeneralFinetuneSpell2:Hide();
  end

  if ( playerClass ~= 'DRUID' ) then
    CHH_FriendGeneralFinetuneSwiftmend:Hide();
  end

  CHH_FriendGeneralFrameBackgroundChanged();
  CHH_FriendGeneralRangeVisualizationPossibleChanged();
  CHH_FriendGeneralRangeVisualizationVerifiedChanged();

end

function CHH_FriendGeneralFrameBackgroundChanged()

  if ( CH_Config.friendFrameBackground == 'CUSTOM' ) then
    CHH_FriendGeneralFrameBackgroundAlpha:Hide();
    CHH_FriendGeneralFrameBackgroundColor:Show();
  else
    CHH_FriendGeneralFrameBackgroundColor:Hide();
    CHH_FriendGeneralFrameBackgroundAlpha:Show();
  end

end

function CHH_FriendGeneralColorPickerOK( )

  if ( arg1 == 'LeftButton' ) then
    CH_ColorPicker:Hide();
    CH_HelpButton();
    CHH_FriendInit();
  end

  CH_Config.friendFrameBackgroundCustomColor.r,CH_Config.friendFrameBackgroundCustomColor.g,CH_Config.friendFrameBackgroundCustomColor.b = ColorPickerFrame:GetColorRGB();

end

function CHH_FriendGeneralColorPickerAlpha( )

  if ( arg1 == 'LeftButton' ) then
    CH_ColorPicker:Hide();
    CH_HelpButton();
    CHH_FriendInit();
  end

  CH_Config.friendFrameBackgroundCustomColor.a = floor(OpacitySliderFrame:GetValue()*100+0.5)/100;

end

function CHH_FriendGeneralColorPickerCancel()

  CH_ColorPicker:Hide();
  CH_HelpButton();
  CHH_FriendInit();
  
  CH_Config.friendFrameBackgroundCustomColor.r = ColorPickerFrame.previousValues[1];
  CH_Config.friendFrameBackgroundCustomColor.g = ColorPickerFrame.previousValues[2];
  CH_Config.friendFrameBackgroundCustomColor.b = ColorPickerFrame.previousValues[3];
  CH_Config.friendFrameBackgroundCustomColor.a = ColorPickerFrame.previousAlpha;

end

function CHH_FriendGeneralOpenColorPicker()

  ColorPickerFrame.hasOpacity = true;
  ColorPickerFrame.opacity = CH_Config.friendFrameBackgroundCustomColor.a;
  ColorPickerFrame:SetColorRGB( CH_Config.friendFrameBackgroundCustomColor.r, CH_Config.friendFrameBackgroundCustomColor.g, CH_Config.friendFrameBackgroundCustomColor.b );
  ColorPickerFrame.previousValues = {CH_Config.friendFrameBackgroundCustomColor.r, CH_Config.friendFrameBackgroundCustomColor.g, CH_Config.friendFrameBackgroundCustomColor.b};
  ColorPickerFrame.previousAlpha = CH_Config.friendFrameBackgroundCustomColor.a;
--  ColorSwatch:SetTexture( 1, 1, 1 );
--
  ColorPickerFrame.func = CHH_FriendGeneralColorPickerOK;
  ColorPickerFrame.cancelFunc = CHH_FriendGeneralColorPickerCancel;
  ColorPickerFrame.opacityFunc = CHH_FriendGeneralColorPickerAlpha;
  
  ColorPickerFrame:Show();
  CH_ColorPicker:Show();
  CHH_Frame:Hide();

end

-- ============================================================================
--   friend config  (RANGE CHECK)
-- ============================================================================

function CHH_FriendGeneralRangeVisualizationPossibleChanged()

  if ( CH_Config.healRangeVisualizationPossible == 'BACKGROUND' ) then
    CHH_FriendGeneralCheckHealRangeVisualizationPossibleColor:Show();
  else
    CHH_FriendGeneralCheckHealRangeVisualizationPossibleColor:Hide();
  end

end

function CHH_FriendGeneralRangeVisualizationVerifiedChanged()

  if ( CH_Config.healRangeVisualizationVerified == 'BACKGROUND' ) then
    CHH_FriendGeneralCheckHealRangeVisualizationVerifiedColor:Show();
  else
    CHH_FriendGeneralCheckHealRangeVisualizationVerifiedColor:Hide();
  end

end

function CHH_FriendGeneralRangeVisualizationColorPickerOK()

  if ( arg1 == 'LeftButton' ) then
    CH_ColorPicker:Hide();
    CH_HelpButton();
    CHH_FriendInit();
  end

  if ( ColorPickerFrame.oorType == 'POSSIBLE' ) then
    CH_Config.healRangeVisualizationPossibleCustomColor.r,CH_Config.healRangeVisualizationPossibleCustomColor.g,CH_Config.healRangeVisualizationPossibleCustomColor.b = 
                                                                                                                                         ColorPickerFrame:GetColorRGB();
  else
    CH_Config.healRangeVisualizationVerifiedCustomColor.r,CH_Config.healRangeVisualizationVerifiedCustomColor.g,CH_Config.healRangeVisualizationVerifiedCustomColor.b = 
                                                                                                                                         ColorPickerFrame:GetColorRGB();
  end

end

function CHH_FriendGeneralRangeVisualizationColorPickerAlpha()

  if ( arg1 == 'LeftButton' ) then
    CH_ColorPicker:Hide();
    CH_HelpButton();
    CHH_FriendInit();
  end

  if ( ColorPickerFrame.oorType == 'POSSIBLE' ) then
    CH_Config.healRangeVisualizationPossibleCustomColor.a = floor(OpacitySliderFrame:GetValue()*100+0.5)/100;
  else
    CH_Config.healRangeVisualizationVerifiedCustomColor.a = floor(OpacitySliderFrame:GetValue()*100+0.5)/100;
  end


end

function CHH_FriendGeneralRangeVisualizationColorPickerCancel()

  CH_ColorPicker:Hide();
  CH_HelpButton();
  CHH_FriendInit();
  
  if ( ColorPickerFrame.oorType == 'POSSIBLE' ) then
    CH_Config.healRangeVisualizationPossibleCustomColor.r = ColorPickerFrame.previousValues[1];
    CH_Config.healRangeVisualizationPossibleCustomColor.g = ColorPickerFrame.previousValues[2];
    CH_Config.healRangeVisualizationPossibleCustomColor.b = ColorPickerFrame.previousValues[3];
    CH_Config.healRangeVisualizationPossibleCustomColor.a = ColorPickerFrame.previousAlpha;
  else
    CH_Config.healRangeVisualizationVerifiedCustomColor.r = ColorPickerFrame.previousValues[1];
    CH_Config.healRangeVisualizationVerifiedCustomColor.g = ColorPickerFrame.previousValues[2];
    CH_Config.healRangeVisualizationVerifiedCustomColor.b = ColorPickerFrame.previousValues[3];
    CH_Config.healRangeVisualizationVerifiedCustomColor.a = ColorPickerFrame.previousAlpha;
  end

end

function CHH_FriendGeneralOpenRangeVisiualizationColorPicker( oorType )

  ColorPickerFrame.hasOpacity = true;
  ColorPickerFrame.oorType = oorType;
  if ( oorType == 'POSSIBLE' ) then
    ColorPickerFrame.opacity = CH_Config.healRangeVisualizationPossibleCustomColor.pa;
    ColorPickerFrame:SetColorRGB( CH_Config.healRangeVisualizationPossibleCustomColor.r, CH_Config.healRangeVisualizationPossibleCustomColor.g, 
                                  CH_Config.healRangeVisualizationPossibleCustomColor.b );
    ColorPickerFrame.previousValues = {CH_Config.healRangeVisualizationPossibleCustomColor.r, CH_Config.healRangeVisualizationPossibleCustomColor.g, 
                                       CH_Config.healRangeVisualizationPossibleCustomColor.b};
    ColorPickerFrame.previousAlpha = CH_Config.healRangeVisualizationPossibleCustomColor.a;
  else
    ColorPickerFrame.opacity = CH_Config.healRangeVisualizationVerifiedCustomColor.a;
    ColorPickerFrame:SetColorRGB( CH_Config.healRangeVisualizationVerifiedCustomColor.r, CH_Config.healRangeVisualizationVerifiedCustomColor.g, 
                                  CH_Config.healRangeVisualizationVerifiedCustomColor.b );
    ColorPickerFrame.previousValues = {CH_Config.healRangeVisualizationVerifiedCustomColor.r, CH_Config.healRangeVisualizationVerifiedCustomColor.g, 
                                       CH_Config.healRangeVisualizationVerifiedCustomColor.b};
    ColorPickerFrame.previousAlpha = CH_Config.healRangeVisualizationVerifiedCustomColor.a;
  end

  ColorPickerFrame.func = CHH_FriendGeneralRangeVisualizationColorPickerOK;
  ColorPickerFrame.cancelFunc = CHH_FriendGeneralRangeVisualizationColorPickerCancel;
  ColorPickerFrame.opacityFunc = CHH_FriendGeneralRangeVisualizationColorPickerAlpha;
  
  ColorPickerFrame:Show();
  CH_ColorPicker:Show();
  CHH_Frame:Hide();

end
