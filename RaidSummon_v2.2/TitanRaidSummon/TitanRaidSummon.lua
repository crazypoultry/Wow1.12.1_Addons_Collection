TITAN_RAIDSUMMON_ID=                "RaidSummon";
TITAN_RAIDSUMMON_ICON=              "Interface\\Icons\\Spell_Shadow_Twilight.blp";
TITAN_RAIDSUMMON_ICONWIDTH=         16;
TITAN_RAIDSUMMON_FREQUENCY=         1;

local summonCycle= 1;


-- change/update display data
local function UpdateButton()
  if (TitanPanelButton_UpdateButton ~= nil) then
    TitanPanelButton_UpdateButton(TITAN_RAIDSUMMON_ID);
  end;
end;

-- register plugin with titan
function TitanPanelRaidSummonButton_OnLoad()
  -- only load if character is a warlock
  local dummy, unitClass= UnitClass("player");
  if (unitClass ~= "WARLOCK") then
    return;
  end;
  
  -- add to titan registry
  this.registry = { 
    id=                   TITAN_RAIDSUMMON_ID,
    category=             "Interface",
    menuText=             TITAN_RAIDSUMMON_MENU_TEXT, 
    buttonTextFunction=   "TitanPanelRaidSummonButton_GetButtonText", 
    tooltipTitle=         TITAN_RAIDSUMMON_TOOLTIP,
    tooltipTextFunction=  "TitanPanelRaidSummonButton_GetTooltipText", 
    frequency=            TITAN_RAIDSUMMON_FREQUENCY, 
    icon=                 TITAN_RAIDSUMMON_ICON,
    iconWidth=            TITAN_RAIDSUMMON_ICONWIDTH,
    savedVariables= {
      ShowLabelText= 1,
      ShowIcon=      1,
      FlashQueue=    1
    }
  };

  -- register with raidsummon to receive update notifications
  RSM_RegisterForUpdate(UpdateButton);
end;

-- perform summon/skips on click or shift click
function TitanPanelRaidSummonButton_OnClick(arg1)
  if (arg1 == "LeftButton") then
    if (IsControlKeyDown()) then
      RSM_SkipQueue();
    elseif (IsShiftKeyDown()) then
      RSM_SummonAuto();
    else
      RSM_SummonQueued();
    end;
  end;
end;

-- return text to be displayed on panel button: raidsummon: disabled, nobody or playername
function TitanPanelRaidSummonButton_GetButtonText(id)
  --local button, id= TitanUtils_GetButton(id, true);
  local statusText;

--[[ TitanRaidSummon works properly even if "Ritual of Summoning" ability features are disabled
  -- return gray "disabled", if addon disabled
  if (not RSM_GetEnabled()) then
    statusText= TitanUtils_GetColoredText(TITAN_RAIDSUMMON_DISABLED, GRAY_FONT_COLOR);
    return TITAN_RAIDSUMMON_BUTTON_LABEL, statusText;
]]--

  -- return gray "paused", if RSM is not listening for whispers
  if (not RSM_GetListening()) then
    statusText= TitanUtils_GetColoredText(TITAN_RAIDSUMMON_PAUSED, GRAY_FONT_COLOR);
    return TITAN_RAIDSUMMON_BUTTON_LABEL, statusText;

  -- return gray AFK is player is currently AFK
  elseif (RSM_IsPlayerAFK()) then
    statusText= TitanUtils_GetColoredText(TITAN_RAIDSUMMON_AFK, GRAY_FONT_COLOR);
    return TITAN_RAIDSUMMON_BUTTON_LABEL, statusText;

  -- return red/yellow blinking (or red only) text if player queued
  elseif (RSM_GetSummonQueueCount() > 0) then
    if ((summonCycle == 0) and TitanGetVar(TITAN_RAIDSUMMON_ID, "FlashQueue")) then
      summonCycle= 1;
      return TITAN_RAIDSUMMON_BUTTON_LABEL, TitanUtils_GetNormalText(RSM_GetSummonQueue(1));
    else
      summonCycle= 0;
      return TitanUtils_GetRedText(TITAN_RAIDSUMMON_BUTTON_LABEL), TitanUtils_GetRedText(RSM_GetSummonQueue(1));
    end;

  -- return white text if no player is queued
  else
    return TITAN_RAIDSUMMON_BUTTON_LABEL, TitanUtils_GetHighlightText(TITAN_RAIDSUMMON_BUTTON_NONE);

  end;
end;

-- return list of players to be summoned in tooltip (along with other info)
function TitanPanelRaidSummonButton_GetTooltipText()
  local summonQueueCount= RSM_GetSummonQueueCount();  
  local statusText;
  
  if (summonQueueCount == 0) then
    statusText= TITAN_RAIDSUMMON_TOOLTIP_QUEUE_EMPTY.."\n";
  else
    statusText= TITAN_RAIDSUMMON_TOOLTIP_QUEUED.."\n";
    for i=1, summonQueueCount do
      statusText= statusText..TitanUtils_GetHighlightText(i..". "..RSM_GetSummonQueue(i)).."\n";
    end;
  end

  statusText= "\n"..statusText.."\n"..TitanUtils_GetGreenText(TITAN_RAIDSUMMON_TOOLTIP_HINT1).."\n"..TitanUtils_GetGreenText(TITAN_RAIDSUMMON_TOOLTIP_HINT2).."\n"..TitanUtils_GetGreenText(TITAN_RAIDSUMMON_TOOLTIP_HINT3);

  return statusText;
end;

-- prepare menu entries right-click menu
function TitanPanelRightClickMenu_PrepareRaidSummonMenu()
  -- only load if character is a warlock
  local dummy, unitClass= UnitClass("player");
  if (unitClass ~= "WARLOCK") then
    return;
  end;

  RSM_BuildBaseMenu();

  if (UIDROPDOWNMENU_MENU_LEVEL == 1) then
    TitanPanelRightClickMenu_AddToggleVar(TITAN_RAIDSUMMON_MENU_FLASH, TITAN_RAIDSUMMON_ID, "FlashQueue");
    TitanPanelRightClickMenu_AddSpacer();
    TitanPanelRightClickMenu_AddToggleIcon(TITAN_RAIDSUMMON_ID);	
    TitanPanelRightClickMenu_AddToggleLabelText(TITAN_RAIDSUMMON_ID);
    TitanPanelRightClickMenu_AddSpacer();
    TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_RAIDSUMMON_ID, TITAN_PANEL_MENU_FUNC_HIDE);
  end;
end;