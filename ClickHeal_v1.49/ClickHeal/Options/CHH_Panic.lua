--=============================================================================
-- File:	CH_Help.lua
-- Author:	rudy
-- Description:	Help pages and config
--=============================================================================

CHH_PanicBehaviorOptions = {{key='FULL',        label=CHHT_PANIC_TITLE_FULL},
                            {key='TRASH',       label=CHHT_PANIC_TITLE_TRASH},
                            {key='BATTLEFIELD', label=CHHT_PANIC_TITLE_BATTLEFIELD},
                            {key='CUSTOM1',     label=CHHT_PANIC_TITLE_CUSTOM1},
                            {key='CUSTOM2',     label=CHHT_PANIC_TITLE_CUSTOM2},
                            {key='CUSTOM3',     label=CHHT_PANIC_TITLE_CUSTOM3}};

local gPanicHeadings = {Heal = CHHT_PANIC_TITLE_HEAL,
                        Buff = CHHT_PANIC_TITLE_BUFF};
local gPanicBehaviorOptions = { {id='FULL',        title=CHHT_PANIC_TITLE_FULL,        editable=false},
                                {id='TRASH',       title=CHHT_PANIC_TITLE_TRASH,       editable=false},
                                {id='BATTLEFIELD', title=CHHT_PANIC_TITLE_BATTLEFIELD, editable=false},
                                {id='CUSTOM1',     title=CHHT_PANIC_TITLE_CUSTOM1,     editable=true},
                                {id='CUSTOM2',     title=CHHT_PANIC_TITLE_CUSTOM2,     editable=true},
                                {id='CUSTOM3',     title=CHHT_PANIC_TITLE_CUSTOM3,     editable=true},
                              };

local gEmergencyMapping = {[1] = 'None', [2] = 'Wounded', [3] = 'Fair', [4] = 'Poor', [5] = 'Critic'}

local gPanicBehavior = 'FULL';
local gPanicBehaviorClass = 'DRUID';
local gPanicBehaviorEmergency = CH_EMERGENCY_NONE;
local gPanicBehaviorSpells = {};

local CH_MAX_SPELLS_PER_EMERGENCY = 4;

function CHH_PanicInit()

  local panicType, panicTitle, unit;

  CHH_PanicGeneralNoBFTitleText:SetText( CHHT_PANIC_NO_BATTLEFIELD );
  for panicType,panicTitle in gPanicHeadings do
    getglobal('CHH_PanicGeneralNoBFPanic'..panicType..'TitleText'):SetText( panicTitle );
    for _,unit in {'Player','Pet','Party','PartyPet','Raid','RaidPet'} do
      CHH_HintOptionCheckBoxLoad( 'panic'..panicType..unit, nil, getglobal('CHH_PanicGeneralNoBFPanic'..panicType..unit) );
    end
  end

  CHH_PanicGeneralBFTitleText:SetText( CHHT_PANIC_IN_BATTLEFIELD );
  for panicType,panicTitle in gPanicHeadings do
    getglobal('CHH_PanicGeneralBFPanic'..panicType..'TitleText'):SetText( panicTitle );
    for _,unit in {'Player','Pet','Party','PartyPet','Raid','RaidPet'} do
      CHH_HintOptionCheckBoxLoad( 'panic'..panicType..unit..'InBattlefield', nil, getglobal('CHH_PanicGeneralBFPanic'..panicType..unit) );
    end
  end

  CHH_InitTabs( CHH_Panic, CHH_PanicGeneral, 'PANIC', 'MISC', CHH_PanicInit, nil ); 

  CHH_PanicGeneralNoBFPanicHealPlayer:Disable();
  CHH_PanicGeneralBFPanicHealPlayer:Disable();

end

-- ========== PANIC BEHAVIOR =========================================================================================================================

function CHH_PanicBehaviorInit()

  CHH_InitTabs( CHH_Panic, CHH_PanicBehavior, 'PANIC', 'BEHAVIOR', CHH_PanicBehaviorInit, nil ); 

  UIDropDownMenu_Initialize( CHH_PanicBehaviorBehavior, CHH_PanicBehaviorBehaviorInit );

  CHH_PanicBehaviorClassClicked( gPanicBehaviorClass )

end

function CHH_PanicBehaviorBehaviorInit()

  local i;
  local info = {};

  for i,_ in gPanicBehaviorOptions do
    info.checked = nil;
    info.text = gPanicBehaviorOptions[i].title;
    if ( gPanicBehaviorOptions[i].id == gPanicBehavior ) then 
      UIDropDownMenu_SetText( info.text, CHH_PanicBehaviorBehavior );
      info.checked = true;
    end
    info.func = CHH_PanicBehaviorBehaviorClicked;
    info.value = i;
    UIDropDownMenu_AddButton(info);
  end

end

function CHH_PanicBehaviorBehaviorClicked()

  gPanicBehavior = gPanicBehaviorOptions[this.value].id;
  UIDropDownMenu_SetText( gPanicBehaviorOptions[this.value].title, CHH_PanicBehaviorBehavior );
  CHH_PanicBehaviorClassClicked( gPanicBehaviorClass )

end

function CHH_PanicBehaviorUpdateLine( objectName, label, class, min, max )

  local minTxt, maxTxt, k, v;
  local spellTxt = '';

  if ( min == nil ) then
    minTxt = 0;
  else
    minTxt = CH_EMERGENCY_STATE[min].Y[class];
  end
  maxTxt = CH_EMERGENCY_STATE[max].Y[class];

  getglobal('CHH_PanicBehaviorEmergency'..objectName..'Label'):SetText( string.format('%s (%d%% - %d%%)',label,minTxt,maxTxt) );

  if ( CH_EmergencySpells ) then  
    for k,v in CH_EmergencySpells[gPanicBehavior][max][class] do
      if ( spellTxt ~= '' ) then
        spellTxt = spellTxt .. ', ';
      end
      if ( strsub(v,1,1) == '!' ) then
        spellTxt = spellTxt .. '|cFF'..CH_COLOR.YELLOW.html..CH_ACTION_TYPE_TEXT[strsub(v,2)]..'|r';
      else
        spellTxt = spellTxt .. CH_ACTION_TYPE_TEXT[v];
      end
    end
  end

  getglobal('CHH_PanicBehaviorEmergency'..objectName..'SpellLabel'):SetText( spellTxt );

end

function CHH_PanicBehaviorClassClicked( class )

  local c, el, isFilled;

  getglobal('CHH_PanicBehaviorClasses'..gPanicBehaviorClass..'Background'):Hide();
  
  gPanicBehaviorClass = class;

  for _,c in CH_ALL_CLASSES_PET do
    isFilled = false;
    for el,_ in gEmergencyMapping do
      isFilled = (CH_EmergencySpells and not CH_IsEmptyTable(CH_EmergencySpells[gPanicBehavior][el][c])) or isFilled;
    end
    if ( isFilled ) then
      getglobal('CHH_PanicBehaviorClasses'..c..'Label'):SetTextColor( CH_COLOR.WHITE.r, CH_COLOR.WHITE.g, CH_COLOR.WHITE.b );
    else
      getglobal('CHH_PanicBehaviorClasses'..c..'Label'):SetTextColor( CH_COLOR.RED.r, CH_COLOR.RED.g, CH_COLOR.RED.b );
    end
  end

  CHH_PanicBehaviorUpdateLine( 'None',    CHT_LABEL_EMERGENCY_NONE,    class, CH_EMERGENCY_WOUNDED, CH_EMERGENCY_NONE );
  CHH_PanicBehaviorUpdateLine( 'Wounded', CHT_LABEL_EMERGENCY_WOUNDED, class, CH_EMERGENCY_FAIR,    CH_EMERGENCY_WOUNDED );
  CHH_PanicBehaviorUpdateLine( 'Fair',    CHT_LABEL_EMERGENCY_FAIR,    class, CH_EMERGENCY_POOR,    CH_EMERGENCY_FAIR );
  CHH_PanicBehaviorUpdateLine( 'Poor',    CHT_LABEL_EMERGENCY_POOR,    class, CH_EMERGENCY_CRITIC,  CH_EMERGENCY_POOR );
  CHH_PanicBehaviorUpdateLine( 'Critic',  CHT_LABEL_EMERGENCY_CRITIC,  class, nil,                  CH_EMERGENCY_CRITIC );

  getglobal('CHH_PanicBehaviorClasses'..gPanicBehaviorClass..'Label'):SetTextColor( CH_COLOR.GOLD.r, CH_COLOR.GOLD.g, CH_COLOR.GOLD.b );
  getglobal('CHH_PanicBehaviorClasses'..gPanicBehaviorClass..'Background'):Show();

  CHH_PanicBehaviorEmergencySpellClicked( CH_EMERGENCY_NONE );

end

local function CHHL_PanicBehaviorIsCurrentEditable()

  local i;

  if ( not CH_EMERGENCY_SPELLS_ACTIONS ) then
    return( false );
  end

  for i,_ in gPanicBehaviorOptions do
    if ( gPanicBehavior == gPanicBehaviorOptions[i].id ) then
      return( gPanicBehaviorOptions[i].editable );
    end
  end

  return( false );

end

function CHH_PanicBehaviorSpellSelectInit()

  local spellType;
  local info = {};
  local line = CHH_GetVari(this,'chLineNo');

  if ( not line ) then
    return;
  end

  for _,spellType in CH_EMERGENCY_SPELLS_ACTIONS do
    info.checked = nil;
    info.text = CH_ACTION_TYPE_TEXT[spellType];
    if ( gPanicBehaviorSpells[line].spellType == spellType ) then 
      info.checked = true;
    end
    info.func = CHH_PanicBehaviorSpellSelectClicked;
    info.value = {line=line,spellType=spellType};
    UIDropDownMenu_AddButton(info);
  end

end

function CHH_PanicBehaviorSpellSelectClicked()

  gPanicBehaviorSpells[this.value.line].spellType = this.value.spellType;
  UIDropDownMenu_SetText( CH_ACTION_TYPE_TEXT[this.value.spellType], getglobal( 'CHH_PanicBehaviorSpellEdit'..this.value.line..'SpellSelect' ) );

end

function CHH_PanicBehaviorForceClicked()

  local line = CHH_GetVari(this,'chLineNo');

  if ( not line ) then
    return;
  end

  if ( this:GetChecked() ) then
    gPanicBehaviorSpells[line].isForced = true;
  else
    gPanicBehaviorSpells[line].isForced = false;
  end

end

function CHH_PanicBehaviorEmergencySpellClicked( emergency )

  local i, frame, spellFrame, spellSelectFrame, forceFrame, spellType, isForced;
  local isEditable = CHHL_PanicBehaviorIsCurrentEditable();

  frame = getglobal('CHH_PanicBehaviorEmergency'..gEmergencyMapping[gPanicBehaviorEmergency]..'SpellBackground'):Hide();
  frame = getglobal('CHH_PanicBehaviorEmergency'..gEmergencyMapping[emergency]..'SpellBackground'):Show();

  gPanicBehaviorEmergency = emergency;
  gPanicBehaviorSpells = {};

  for i=1,CH_MAX_SPELLS_PER_EMERGENCY do
    frame = getglobal( 'CHH_PanicBehaviorSpellEdit'..i );
    spellFrame = getglobal( 'CHH_PanicBehaviorSpellEdit'..i..'Spell' );
    spellSelectFrame = getglobal( 'CHH_PanicBehaviorSpellEdit'..i..'SpellSelect' );
    forceFrame = getglobal( 'CHH_PanicBehaviorSpellEdit'..i..'ForceCast' );
    forceFrameLabel = getglobal( 'CHH_PanicBehaviorSpellEdit'..i..'ForceCastLabel' );

    if ( not CH_EmergencySpells ) then
      spellType = 'NONE';
      isForced = false;
    else
      spellType = CH_EmergencySpells[gPanicBehavior][gPanicBehaviorEmergency][gPanicBehaviorClass][i];
      if ( spellType and strsub(spellType,1,1) == '!' ) then
        isForced = true;
        spellType = strsub( spellType, 2 );
      else
        isForced = false;
      end
    end

    if ( isEditable ) then 										-- editable
      frame.chLineNo = i;
      gPanicBehaviorSpells[i] = {spellType=(spellType or 'NONE'),isForced=isForced};
      UIDropDownMenu_Initialize( spellSelectFrame, CHH_PanicBehaviorSpellSelectInit );
      UIDropDownMenu_SetText( CH_ACTION_TYPE_TEXT[(spellType or 'NONE')], spellSelectFrame );
      forceFrame:Enable();
      forceFrame:SetChecked( isForced );
      forceFrameLabel:SetTextColor( 1, 1, 1 );
      spellFrame:Hide();
      spellSelectFrame:Show();
    else												-- static
      spellFrame:Show();
      spellFrame:SetText( CH_ACTION_TYPE_TEXT[spellType] );
      forceFrame:SetChecked( isForced );
      forceFrame:Disable();
      forceFrameLabel:SetTextColor( 0.5, 0.5, 0.5 );
      spellSelectFrame:Hide();
    end
    frame:Show();
  end

  if ( isEditable ) then
    CHH_PanicBehaviorSpellEditCommit:Show();
  else
    CHH_PanicBehaviorSpellEditCommit:Hide();
  end

end

function CHH_PanicBehaviorSpellUpdateClicked()

  local pos = 1;
  local i, spellType;

  CH_EmergencySpells[gPanicBehavior][gPanicBehaviorEmergency][gPanicBehaviorClass] = {};

  for i=1,CH_MAX_SPELLS_PER_EMERGENCY do
    if ( gPanicBehaviorSpells[i].spellType and gPanicBehaviorSpells[i].spellType ~= 'NONE' ) then
      spellType = gPanicBehaviorSpells[i].spellType;
      if ( gPanicBehaviorSpells[i].isForced ) then
        spellType = '!'..spellType;
      end
      CH_EmergencySpells[gPanicBehavior][gPanicBehaviorEmergency][gPanicBehaviorClass][pos] = spellType;
      pos = pos + 1;
    end
  end

  CHH_PanicBehaviorClassClicked( gPanicBehaviorClass );

end
