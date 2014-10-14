--=============================================================================
-- File:	CHH_Gui.lua
-- Author:	rudy
-- Description:	Configs for teh GUI
--=============================================================================

CHH_GuiFrameGroupModeOptions       = {{key='ALL',           label=CHHT_GUI_FRAME_GROUP_MODE_ALL},
                                      {key='GROUP',         label=CHHT_GUI_FRAME_GROUP_MODE_GROUP}};
CHH_GuiFrameAlignOptions           = {{key='LEFT',          label=CHHT_GUI_FRAME_ALIGN_LEFT},
                                      {key='CENTER',        label=CHHT_GUI_FRAME_ALIGN_CENTER},
                                      {key='RIGHT',         label=CHHT_GUI_FRAME_ALIGN_RIGHT}};
CHH_GuiDockTargetOptions           = {{key='NONE',          label=CHHT_GUI_DOCK_TARGET_NONE},
                                      {key='RIGHT',         label=CHHT_GUI_DOCK_TARGET_RIGHT},
                                      {key='LEFT',          label=CHHT_GUI_DOCK_TARGET_LEFT}};
CHH_GuiTargetDebuffsOptions        = {{key='NONE',          label=CHHT_GUI_TARGET_DEBUFF_NONE},
                                      {key='CASTABLE',      label=CHHT_GUI_TARGET_DEBUFF_CASTABLE},
                                      {key='ENEMY_CASTABLE',label=CHHT_GUI_TARGET_DEBUFF_ENEMY_CASTABLE},
                                      {key='ENEMY_ALL',     label=CHHT_GUI_TARGET_DEBUFF_ENEMY_ALL},
                                      {key='ALL',           label=CHHT_GUI_TARGET_DEBUFF_ALL}};
CHH_GuiTargetColorOptions          = {{key='NEVER',         label=CHHT_GUI_TARGET_COLOR_NEVER},
                                      {key='PLAYER',        label=CHHT_GUI_TARGET_COLOR_PLAYER},
                                      {key='ALWAYS',        label=CHHT_GUI_TARGET_COLOR_ALWAYS}};
CHH_GuiUnitTooltipOptions          = {{key='ALWAYS',        label=CHHT_GUI_UNIT_TOOLTIP_ALWAYS},
                                      {key='SHIFT',         label=CHHT_GUI_UNIT_TOOLTIP_SHIFT},
                                      {key='CTRL',          label=CHHT_GUI_UNIT_TOOLTIP_CTRL},
                                      {key='ALT',           label=CHHT_GUI_UNIT_TOOLTIP_ALT},
                                      {key='SHIFTCTRL',     label=CHHT_GUI_UNIT_TOOLTIP_SHIFTCTRL},
                                      {key='SHIFTALT',      label=CHHT_GUI_UNIT_TOOLTIP_SHIFTALT},
                                      {key='CTRLALT',       label=CHHT_GUI_UNIT_TOOLTIP_CTRLALT},
                                      {key='SHIFTCTRLALT',  label=CHHT_GUI_UNIT_TOOLTIP_SHIFTCTRLALT},
                                      {key='NEVER',         label=CHHT_GUI_UNIT_TOOLTIP_NEVER}};
CHH_GuiUnitTooltipLocationOptions  = {{key='MAIN',          label=CHHT_GUI_UNIT_TOOLTIP_LOCATION_MAIN},
                                      {key='WOW',           label=CHHT_GUI_UNIT_TOOLTIP_LOCATION_WOW}};
CHH_GuiActionsTooltipOptions       = {{key='ALWAYS',        label=CHHT_GUI_ACTION_TOOLTIP_ALWAYS},
                                      {key='NEVER',         label=CHHT_GUI_ACTION_TOOLTIP_NEVER}};
CHH_GuiAnchorRelativePointOptions  = {LEFT=CHHT_LABEL_LEFT,
                                      BOTTOM=CHHT_LABEL_BOTTOM,
                                      RIGHT=CHHT_LABEL_RIGHT,
                                      TOP=CHHT_LABEL_TOP};
CHH_GuiAnchorRelativePointGuiOptions  = {LEFT=CHHT_LABEL_LEFT,
                                         BOTTOM=CHHT_LABEL_BOTTOM,
                                         RIGHT=CHHT_LABEL_RIGHT,
                                         TOP=CHHT_LABEL_TOP,
                                         TOPLEFT=CHHT_LABEL_TOPLEFT,
                                         TOPRIGHT=CHHT_LABEL_TOPRIGHT,
                                         BOTTOMLEFT=CHHT_LABEL_BOTTOMLEFT,
                                         BOTTOMRIGHT=CHHT_LABEL_BOTTOMRIGHT};
CHH_GuiAnchorVisibilityOptions     = {SHOW=CHHT_GUI_ANCHORS_VISIBILITY_SHOW,
                                      AUTOHIDE=CHHT_GUI_ANCHORS_VISIBILITY_AUTOHIDE,
                                      COLLAPSE=CHHT_GUI_ANCHORS_VISIBILITY_COLLAPSE};
CHH_GuiAnchorGrowOptions           = {UP=CHHT_GUI_ANCHORS_GROW_UP,
                                      DOWN=CHHT_GUI_ANCHORS_GROW_DOWN};

-- ============================================================================
--   GUI / Misc
-- ============================================================================

function CHH_GuiMiscTab()

  CHH_InitTabs( CHH_Gui, CHH_GuiMisc, 'GUI', 'MISC', CHH_GuiMiscTab, nil );

  UIDropDownMenu_Initialize( CHH_GuiMiscFrameGroupMode, CHH_GuiMiscFrameGroupModeInit );

  CHH_GuiMiscPartySortInit();

end

function CHH_GuiMiscPartySortInit()

  local line, unit;

  for line,unit in CH_Config.partySort do
    if ( UnitExists(unit) ) then
      getglobal('CHH_GuiMiscPartySortLine'..line..'Unit'):SetText( string.format("%s (%s)",getglobal('CHHT_LABEL_'..strupper(unit)),CH_UnitName(unit)) );
    else
      getglobal('CHH_GuiMiscPartySortLine'..line..'Unit'):SetText( getglobal('CHHT_LABEL_'..strupper(unit)) );
    end
    getglobal('CHH_GuiMiscPartySortLine'..line).lineNo = line;
  end

end

function CHH_GuiMiscPlayerSortButtonUpClicked()

  local lineNo = this:GetParent().lineNo;

  if ( (not lineNo) or lineNo < 2 ) then
    return;
  end

  lineUnit = CH_Config.partySort[lineNo];
  CH_Config.partySort[lineNo] = CH_Config.partySort[lineNo-1];
  CH_Config.partySort[lineNo-1] = lineUnit;

  CHH_GuiMiscPartySortInit();
  CH_AdjustPartyFrames();

end

function CHH_GuiMiscPlayerSortButtonDownClicked()

  local lineNo = this:GetParent().lineNo;

  if ( (not lineNo) or lineNo > 9 ) then
    return;
  end

  lineUnit = CH_Config.partySort[lineNo];
  CH_Config.partySort[lineNo] = CH_Config.partySort[lineNo+1];
  CH_Config.partySort[lineNo+1] = lineUnit;

  CHH_GuiMiscPartySortInit();
  CH_AdjustPartyFrames();

end

-- ============================================================================
--   GUI / Basic Frames
-- ============================================================================

function CHH_GuiBasicTab()

  CHH_InitTabs( CHH_Gui, CHH_GuiBasic, 'GUI', 'MAIN_FRAME', CHH_GuiBasicTab, nil );

end

-- ============================================================================
--   GUI / Target Frames
-- ============================================================================

function CHH_GuiTargetTab()

  CHH_InitTabs( CHH_Gui, CHH_GuiTarget, 'GUI', 'TARGET_FRAME', CHH_GuiTargetTab, nil );

end

-- ============================================================================
--   GUI / Tooltips
-- ============================================================================

function CHH_GuiTooltipTab()

  CHH_InitTabs( CHH_Gui, CHH_GuiTooltip, 'GUI', 'TOOLTIP', CHH_GuiTooltipTab, nil );

end

function CHH_GuiTooltipPostShowHints()

  if ( CH_Config.showHints ) then
    CH_HintTooltipShow( this, this.ch_config_option );
  else
    CH_HintTooltipHide();
  end

end

-- ============================================================================
--   GUI / Anchors
-- ============================================================================

function CHH_GuiAnchorsTab()

  local i,k;

  CHH_InitTabs( CHH_Gui, CHH_GuiAnchors, 'GUI', 'ANCHOR', CHH_GuiAnchorsTab, nil );

  CHH_GuiAnchorsListUpdate();				-- init scroll list

end

local function CHH_GuiAnchorsRelativeToLabel( anchorID )

  if ( anchorID == 'GUI' ) then
    return( CHT_LABEL_ANCHOR_GUI );
  else
    return( CH_ANCHOR_DATA[anchorID].label );
  end

end

function CHH_GuiAnchorsListUpdate()

  local line, anchorID;
  local relativeToFrame, relativePointFrame, visibilityFrame;
  local scrollFrame = CHH_GuiAnchorsScrollFrame;
  local i = 1;
  local offset = FauxScrollFrame_GetOffset( scrollFrame );

  FauxScrollFrame_Update( scrollFrame, table.getn(CH_AnchorSortedList), 11, 30 );       -- frame, numItems, numDisplay, valueStep (pixel height of one entry)

  i = 1;
  line = getglobal( 'CHH_GuiAnchors'..i );
  while ( line and CH_AnchorSortedList[offset+i] ) do
    anchorID = CH_AnchorSortedList[offset+i];
    getglobal('CHH_GuiAnchors'..i).ch_anchor_id = anchorID;
    getglobal('CHH_GuiAnchors'..i).ch_line_no = i;
    getglobal('CHH_GuiAnchors'..i..'AnchorName'):SetText( CHH_GuiAnchorsRelativeToLabel(anchorID) );
    getglobal('CHH_GuiAnchors'..i..'OffsetX'):SetText( CH_Anchor[anchorID].offsetX );
    getglobal('CHH_GuiAnchors'..i..'OffsetY'):SetText( CH_Anchor[anchorID].offsetY );

    -- relative to
    relativeToFrame = getglobal( 'CHH_GuiAnchors'..i..'RelativeTo' );
    relativeToFrame.ch_anchor_property = 'relativeTo';
    relativeToFrame.ch_frame_name = relativeToFrame:GetName();
    UIDropDownMenu_SetWidth( 110, relativeToFrame );
    UIDropDownMenu_Initialize( relativeToFrame, CHH_GuiAnchorsDropDownInit );
    UIDropDownMenu_SetText( CHH_GuiAnchorsRelativeToLabel(CH_Anchor[anchorID].relativeTo), relativeToFrame );

    -- relative point
    relativePointFrame = getglobal( 'CHH_GuiAnchors'..i..'RelativePoint' );
    relativePointFrame.ch_anchor_property = 'relativePoint';
    relativePointFrame.ch_frame_name = relativePointFrame:GetName();
    UIDropDownMenu_SetWidth( 70, relativePointFrame );
    UIDropDownMenu_Initialize( relativePointFrame, CHH_GuiAnchorsDropDownInit );
    UIDropDownMenu_SetText( CHH_GuiAnchorRelativePointGuiOptions[CH_Anchor[anchorID].relativePoint], relativePointFrame );

    -- visibility
    visibilityFrame = getglobal( 'CHH_GuiAnchors'..i..'Visibility');
    visibilityFrame.ch_anchor_property = 'visibility';
    visibilityFrame.ch_frame_name = visibilityFrame:GetName();
    UIDropDownMenu_SetWidth( 75, visibilityFrame );
    UIDropDownMenu_Initialize( visibilityFrame, CHH_GuiAnchorsDropDownInit );
    UIDropDownMenu_SetText( CHH_GuiAnchorVisibilityOptions[CH_Anchor[anchorID].visibility], visibilityFrame );

    -- grow
    growFrame = getglobal( 'CHH_GuiAnchors'..i..'Grow');
    growFrame.ch_anchor_property = 'grow';
    growFrame.ch_frame_name = growFrame:GetName();
    UIDropDownMenu_SetWidth( 55, growFrame );
    UIDropDownMenu_Initialize( growFrame, CHH_GuiAnchorsDropDownInit );
    UIDropDownMenu_SetText( CHH_GuiAnchorGrowOptions[CH_Anchor[anchorID].grow], growFrame );
    
    -- showMenu
    getglobal('CHH_GuiAnchors'..i..'ShowMenu'):SetChecked( CH_Anchor[anchorID].showMenu );
    getglobal('CHH_GuiAnchors'..i..'ShowMenu'):Enable();

    line:Show();

    i = i + 1;
    line = getglobal( 'CHH_GuiAnchors'..i );
  end

end

function CHH_GuiAnchorsDropDownInit()

  local k,v,key, label;
  local values;
  local anchorID = CHH_GetVari( this, 'ch_anchor_id' );
  local anchorProperty = CHH_GetVari( this, 'ch_anchor_property' );
  local frameName = CHH_GetVari( this, 'ch_frame_name' );
  local lineNo = CHH_GetVari( this, 'ch_line_no' );
  local info = {};

  if ( not anchorID ) then
    return;
  end

  if ( anchorProperty == 'relativeTo' ) then
    values = {};
    for k,v in CH_AnchorSortedList do
      if ( CH_AnchorMayAnchorTo(anchorID,v,CH_Anchor[anchorID].relativePoint) ) then
        table.insert( values, v );
      end
    end
    table.insert( values, 'GUI' );
  elseif ( anchorProperty == 'relativePoint' ) then
    if ( CH_Anchor[anchorID].relativeTo == 'GUI') then
      values = CHH_GuiAnchorRelativePointGuiOptions;
    else
      values = {};
      for k,v in CHH_GuiAnchorRelativePointOptions do
        if ( k == CH_Anchor[anchorID].relativePoint or CH_AnchorMayAnchorTo(anchorID,CH_Anchor[anchorID].relativeTo,k) ) then
          values[k] = v;
        end
      end
    end
  elseif ( anchorProperty == 'visibility' ) then
    values = CHH_GuiAnchorVisibilityOptions;
  elseif ( anchorProperty == 'grow' ) then
    values = CHH_GuiAnchorGrowOptions;
  end

  for k,v in values do
    if ( anchorProperty == 'relativeTo' ) then
      key = v;
      label = CHH_GuiAnchorsRelativeToLabel( key );
    else
      key = k;
      label = v;
    end
    info.text = label;
    info.checked = nil;
    if ( key == CH_Anchor[anchorID][anchorProperty] ) then
      info.checked = 1;
    end
    info.func = CHH_GuiAnchorsDropDownClicked;
    info.value = {anchorID=anchorID,anchorProperty=anchorProperty,value=key,label=label,frameName=frameName,lineNo=lineNo};
    UIDropDownMenu_AddButton(info);
  end

end

function CHH_GuiAnchorsDropDownClicked()

  if ( CH_AnchorSetValue(this.value.anchorID,this.value.anchorProperty,this.value.value) ) then
    CHH_GuiAnchorsTab(); -- redraw screen!
--    UIDropDownMenu_SetText( this.value.label, getglobal(this.value.frameName) );
  end

end

function CHH_GuiAnchorsOffsetClicked( anchorProperty )

  local anchorID = CHH_GetVari( this, 'ch_anchor_id' );

  if ( this:GetText() == '-' or this:GetText() == '-0' ) then
    -- dont submit yet
  elseif ( this:GetText() == '0-' ) then
    this:SetText( '-' );
  elseif ( this:GetText() ~= tostring(CH_Anchor[anchorID][anchorProperty]) ) then
    CH_AnchorSetValue( anchorID, anchorProperty, this:GetText() );
    this:SetText( CH_Anchor[anchorID][anchorProperty] );
  end

end

function CHH_GuiAnchorsShowMenuClicked()

  local anchorID = CHH_GetVari( this, 'ch_anchor_id' );

  CH_AnchorSetValue( anchorID, 'showMenu', CH_ToBoolean(this:GetChecked()) );
  this:SetChecked( CH_Anchor[anchorID].showMenu );

end
