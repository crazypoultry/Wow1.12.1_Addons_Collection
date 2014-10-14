--=============================================================================
-- File:	CH_Help.lua
-- Author:	rudy
-- Description:	Help pages and config
--=============================================================================

local function CHH_ExtraInitDropdown( frame, spellNr )

  frame.cooldownIdx = spellNr;
  frame.myFrameName = frame:GetName();
  UIDropDownMenu_Initialize( frame, CHH_CooldownWatchSpellInit );
  CHH_DropdownSetLabel( CH_CooldownWatchList[spellNr].spellName, frame, 'None', CHHT_LABEL_NONE );

end

function CHH_ExtraInit()

  CHH_InitTabs( CHH_Extra, CHH_ExtraGeneral, nil, nil, nil, nil );

  CHH_ExtraGeneral1TitleText:SetText( string.format(CHHT_EXTRA_LABEL_FORMAT,1) );
  CHH_ExtraGeneral2TitleText:SetText( string.format(CHHT_EXTRA_LABEL_FORMAT,2) );
  CHH_ExtraGeneral3TitleText:SetText( string.format(CHHT_EXTRA_LABEL_FORMAT,3) );
  CHH_ExtraGeneral4TitleText:SetText( string.format(CHHT_EXTRA_LABEL_FORMAT,4) );

  CHH_ExtraGeneral1Hidden:SetChecked( CH_Config.extra1Hidden );
  CHH_ExtraGeneral2Hidden:SetChecked( CH_Config.extra2Hidden );
  CHH_ExtraGeneral3Hidden:Hide();
  CHH_ExtraGeneral4Hidden:Hide();

  CHH_ExtraGeneral1NameEditText:SetText( CH_Config['extra1Name'] );
  CHH_ExtraGeneral2NameEditText:SetText( CH_Config['extra2Name'] );
  CHH_ExtraGeneral3NameEditText:SetText( CH_Config['extra3Name'] );
  CHH_ExtraGeneral4NameEditText:SetText( CH_Config['extra4Name'] );

  CHH_ExtraInitDropdown( CHH_ExtraGeneral1Show, 1 );
  CHH_ExtraInitDropdown( CHH_ExtraGeneral2Show, 2 );
  CHH_ExtraInitDropdown( CHH_ExtraGeneral3Show, 3 );
  CHH_ExtraInitDropdown( CHH_ExtraGeneral4Show, 4 );

  CHH_ExtraPage1Button:Hide();
  CHH_ExtraPage2Button:Hide();
  CHH_ExtraPage3Button:Hide();
  CHH_ExtraPage4Button:Hide();
  CHH_ExtraResetButton:Hide();

  CHH_ExtraGeneral1.extraIdx = 1;
  CHH_ExtraGeneral2.extraIdx = 2;
  CHH_ExtraGeneral3.extraIdx = 3;
  CHH_ExtraGeneral4.extraIdx = 4;

end

function CHH_ExtraHiddenClicked( frame )

  local extraIdx = CHH_GetVari( frame, 'extraIdx' );

  CH_ConfigSetOption( 'extra'..extraIdx..'Hidden', CH_ToBoolean(this:GetChecked()) );

end

function CHH_ExtraEditBox( frame )

  local extraIdx = CHH_GetVari( frame, 'extraIdx' );
  local frame = getglobal( 'CHH_ExtraGeneral'..extraIdx..'NameEditText' );

  CH_Config['extra'..extraIdx..'Name'] = frame:GetText();

  CH_OnExtraUpdate( extraIdx );

end

function CHH_ExtraSpellAssign( page )

  local extraIdx = CHH_GetVari( this, 'extraIdx' );

  CHH_ExtraPage2Button.extraIdx = extraIdx;
  CHH_ExtraPage3Button.extraIdx = extraIdx;
  CHH_ExtraPage4Button.extraIdx = extraIdx;

  CHH_ExtraPage1Button:Show();
  CHH_ExtraPage2Button:Show();
  CHH_ExtraPage3Button:Show();
  CHH_ExtraPage4Button:Show();
  CHH_ExtraResetButton:Show();

  CHH_InitTabs( CHH_Extra, CHH_ExtraAction, 'EXTRA'..extraIdx, 'MOUSE', nil, nil );
  CHH_SpellAssignInit( 'CHH_ExtraAction', 'Extra'..extraIdx, 'extra', page, string.format(CHHT_EXTRA_TITLE_FORMAT,extraIdx) );

end

function CHH_ExtraRestoreDefaults( )

  local extraIdx = CHH_GetVari( this, 'extraIdx' );

  CHH_ResetDefaults( 'EXTRA'..extraIdx, 'MISC' );
  CHH_ExtraInit();

end
