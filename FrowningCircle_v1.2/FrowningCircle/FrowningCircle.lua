BINDING_HEADER_TOTEM = "Frowning Circle";

FrowningCircle_Initialized = false;
FrowningCircle_LastTotem = 1;
FrowningCircle_DidCast = nil;

-- Config Version, configs will get reset if they differ
FrowningCircle_ConfigVersion = 1;

function FrowningCircle_InitVars()
  FrowningCircle_Config = {
    SmartRecast = 1;
    OffensiveDelay = 30;
    Sets = {};
    ActiveSet = 1;
    -- Config Version, configs will get reset if they differ
    ConfigVersion = FrowningCircle_ConfigVersion;
  };

  FrowningCircle_State = nil;
  FrowningCircle_States = {};

  local i = 1;
  for i = 1, 5 do
    FrowningCircle_Config.Sets[i] = {};
    FrowningCircle_States[i] = {};
    FrowningCircle_States[i].Selected = {};
    FrowningCircle_States[i].LastCastTimes = {};
  end
end

FrowningCircle_ObjectType = 
{
  SmartRecast = "check";
  OffensiveDelay = "slider";
};

function FrowningCircle_OnLoad()
  FrowningCircle_InitVars();

  if (UnitClass("player") ~= FROWNINGCIRCLE_SHAMAN) then
    return;
  end

  this:RegisterEvent("VARIABLES_LOADED");
  this:RegisterEvent("LEARNED_SPELL_IN_TAB");
  this:RegisterEvent("SPELLCAST_FAILED");
  this:RegisterEvent("SPELLCAST_INTERRUPTED");
  this:RegisterEvent("SPELLCAST_STOP");

end

function FrowningCircle_SetDropDownInitialize()
  local info;
  local i;
  for i=1, 5 do
    info = {};
    info.text = "Totem Set " .. i;
    info.func = FrowningCircle_SetDropDownOnClick;
    UIDropDownMenu_AddButton(info);
  end
end

function FrowningCircle_SetDropDownOnClick()
  local set = this:GetID();
  FrowningCircle_UpdateConfigData();
  FrowningCircle_DisplaySet(set);
end

function FrowningCircle_OnEvent()
  if (event == "VARIABLES_LOADED") then
    if (FrowningCircle_Config.ConfigVersion ~= FrowningCircle_ConfigVersion) then
      FrowningCircle_InitVars();
    end
  elseif (event == "LEARNED_SPELL_IN_TAB") then
    FrowningCircle_LoadSettings();
  elseif (event == "SPELLCAST_FAILED" or event == "SPELLCAST_INTERRUPTED") then
    FrowningCircle_DidCast = nil;
  elseif (event == "SPELLCAST_STOP") then
    if (FrowningCircle_DidCast ~= nil) then
      FrowningCircle_State.LastCastTimes[FrowningCircle_DidCast] = GetTime();
    end
    FrowningCircle_DidCast = nil;
  end
end

function FrowningCircle_Msg(msg)
  if (DEFAULT_CHAT_FRAME ~= nil) then
    DEFAULT_CHAT_FRAME:AddMessage(msg);
  end
end

function FrowningCircle_ShowConfig()
  if (FrowningCircle_Initialized == false) then
    if (not FrowningCircle_LoadSettings()) then
      return;
    end
  end

  if (not TotemConfigFrame:IsVisible()) then
    FrowningCircle_ConfigFrameInit();
  
    FrowningCircle_ConfigSets = {};
    FrowningCircle_ConfigActive = FrowningCircle_Config.ActiveSet;
    local i, set;
    for set = 1, 5 do
      FrowningCircle_ConfigSets[set] = {};
      for i = 1, 4 do
        FrowningCircle_ConfigSets[set][i] = FrowningCircle_States[set].Selected[i];
      end   
    end
    FrowningCircle_DisplaySet(FrowningCircle_Config.ActiveSet);
    UIDropDownMenu_SetText("Totem Set " .. FrowningCircle_Config.ActiveSet, TotemConfigSetDropDown);
    TotemConfigFrame:Show();
  end
end

function FrowningCircle_UpdateConfigData()
  local i;
  for i = 1, 4 do
    FrowningCircle_ConfigSets[FrowningCircle_ConfigActive][i] = FrowningCircle_GetSelectedButton(i);
  end
end

function FrowningCircle_DisplaySet(set)
  local i;

  FrowningCircle_ConfigActive = set;
  UIDropDownMenu_SetSelectedID(TotemConfigSetDropDown, set, true);

  for i = 1, 4 do
    FrowningCircle_SetSelectedButton(i, FrowningCircle_ConfigSets[set][i]);
  end
end

function FrowningCircle_SetSelectedButton(school, id)
  local i = 1;
  for i = 1, 8 do
    local button = getglobal("TotemConfig" .. TotemSchools[school] .. "Button"..i);
    if (i == id) then
      button:SetChecked(1);
    else
      button:SetChecked(0);
    end
  end
end

function FrowningCircle_GetSelectedButton(school)
  local i = 1;
  for i = 1, 8 do
    local button = getglobal("TotemConfig" .. TotemSchools[school] .. "Button"..i);
    if (button:GetChecked() == 1) then
      return i;
    end
  end
  return 1;
end


function FrowningCircle_SetTooltip()
  local id = this:GetID();
  if (id == nil or id == 0) then
    return;
  end

  if (id == 1) then
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
    if (GameTooltip:SetText("None", 10, 10, 10)) then
      this.updateTooltip = TOOLTIP_UPDATE_TIME;
    else
      this.updateTooltip = nil;
    end
    return;    
  end

  local school = FrowningCircle_GetSchoolFromName(this:GetName());

  id = FrowningCircle_Data.IDs[school][id];
  if (id == nil) then
    return;
  end

  GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
  if ( GameTooltip:SetSpell(id, BOOKTYPE_SPELL) ) then
    this.updateTooltip = TOOLTIP_UPDATE_TIME;
  else
    this.updateTooltip = nil;
  end
end

function FrowningCircle_LoadSettings()
  if (UnitClass("player") ~= FROWNINGCIRCLE_SHAMAN) then
    FrowningCircle_Msg("You're not a shaman");
    return false;
  end

  if (FrowningCircle_Data.Initialized ~= true) then
    FrowningCircle_ScanSpells();
  end

  -- Verify and initialize set data
  local set, school, i;
  for set = 1, 5 do
    for school = 1, 4 do
      local found = false;
      i = 2;
      while (FrowningCircle_Data.Totems[school][i] ~= nil) do
        if (FrowningCircle_Data.Totems[school][i] == FrowningCircle_Config.Sets[set][school]) then
          found = true;
          break;
        end
        i = i + 1;
      end
      FrowningCircle_States[set].LastCastTimes[school] = nil;
      if (found == false) then
        FrowningCircle_Config.Sets[set][school] = nil;
        FrowningCircle_States[set].Selected[school] = 1;
      else
        FrowningCircle_States[set].Selected[school] = i;
      end
    end
  end

  FrowningCircle_State = FrowningCircle_States[FrowningCircle_Config.ActiveSet];
  FrowningCircle_Set = FrowningCircle_Config.Sets[FrowningCircle_Config.ActiveSet];

  -- Update buttons
  for school = 1, 4 do
    getglobal("TotemConfig" .. TotemSchools[school] .. "Button1Icon"):SetTexture("Interface\\Icons\\Spell_Shadow_SacrificialShield.blp");

    for i = 2, 8 do
      local id = FrowningCircle_Data.IDs[school][i];

      local button = getglobal("TotemConfig" .. TotemSchools[school] .. "Button"..i);
      if (id == nil) then
        button:Hide();
      else
        button:Show();
        local icon = getglobal("TotemConfig" .. TotemSchools[school] .. "Button".. i .. "Icon");
        local texture = GetSpellTexture(id, BOOKTYPE_SPELL);
        icon:SetTexture(texture);
      end
    end
  end

  FrowningCircle_Initialized = true;

  return true;
end

function FrowningCircle_GetSchoolFromName(name)
  local i = 0;
  for i = 1, 4 do
    if (string.find(name, TotemSchools[i]) ~= nil) then
      return i;
    end
  end

  return nil;
end

function FrowningCircle_ButtonClick()
  local school = FrowningCircle_GetSchoolFromName(this:GetName());
  local id = this:GetID();

  FrowningCircle_SetSelectedButton(school, id);
end

function FrowningCircle_SaveConfig()
  FrowningCircle_UpdateConfigData();
  local set, school;
  for set = 1, 5 do
    for school = 1, 4 do
      local selected = FrowningCircle_ConfigSets[set][school];
      FrowningCircle_States[set].Selected[school] = selected;
      FrowningCircle_Config.Sets[set][school] = FrowningCircle_Data.Totems[school][selected];
    end
  end
  FrowningCircle_Config.ActiveSet = FrowningCircle_ConfigActive;
  FrowningCircle_ConfigActive = nil;
  FrowningCircle_ConfigSets = nil;
  FrowningCircle_Set = FrowningCircle_Config.Sets[FrowningCircle_Config.ActiveSet];
  FrowningCircle_State = FrowningCircle_States[FrowningCircle_Config.ActiveSet];

  local key, value;
  for key,value in pairs(FrowningCircle_ObjectType) do
    if (value == "check") then
      local object = getglobal("TotemConfigFrame" .. key);
      FrowningCircle_Config[key] = object:GetChecked();
    elseif (value == "slider") then
      local object = getglobal("TotemConfigFrame" .. key);
      FrowningCircle_Config[key] = object:GetValue();
    end
  end

  FrowningCircle_State.LastCastTimes = {};
  FrowningCircle_DidCast = nil;
end

function FrowningCircle_HasTotemBuff(name)
  local i;
  for i=0, 15 do
    local index = GetPlayerBuff(i);
    if (index ~= nil and index >= 0) then
      TotemHTT:SetPlayerBuff(i);
      local text = TotemHTTTextLeft1:GetText();
      if (text ~= nil) then
        if (string.find(name, text)) then
          return true;
        end
        if (string.find(text, name)) then
          return true;
        end
      end
    end
  end

  -- Weapon enchants like Windfury
  
  local hasMainHandEnchant, mainHandExpiration, mainHandCharges, hasOffHandEnchant, offHandExpiration, offHandCharges = GetWeaponEnchantInfo();
	
  if ( hasOffHandEnchant ) then
    TotemHTT:SetInventoryItem("player", 17);
    local j = 2;
    local num = TotemHTT:NumLines();
    for j=2, num do
      local frame = getglobal("TotemHTTTextLeft" .. j);
      if (frame ~= nil) then
        if (string.find(frame:GetText(), name)) then
          return true;
        end
      end
    end
  end
  if ( hasMainHandEnchant ) then
    TotemHTT:SetInventoryItem("player", 16);
    local j = 2;
    local num = TotemHTT:NumLines();
    for j=2, num do
      local frame = getglobal("TotemHTTTextLeft" .. j);
      if (frame ~= nil) then
        if (string.find(frame:GetText(), name)) then
          return true;
        end
      end
    end
  end
  return false;
end

function FrowningCircle_ThrowTotem()

  if (FrowningCircle_Initialized == false) then
    if (not FrowningCircle_LoadSettings()) then
      return;
    end
  end

  local old = FrowningCircle_LastTotem;

  while (true) do
    if (FrowningCircle_Set[FrowningCircle_LastTotem] ~= nil) then
      local selected = FrowningCircle_State.Selected[FrowningCircle_LastTotem];
      local name = FrowningCircle_Data.Totems[FrowningCircle_LastTotem][selected];

      local throw = true;

      if (FrowningCircle_Config.SmartRecast) then
        if (FrowningCircle_HasTotemBuff(name)) then
          throw = false;
        end
        if (FrowningCircle_Data.Offensive[FrowningCircle_LastTotem][selected]) then
          local lastCastTime = FrowningCircle_State.LastCastTimes[FrowningCircle_LastTotem];
          if (lastCastTime ~= nil) then
            local diff = GetTime() - lastCastTime;
            if (diff >= 0 and diff < FrowningCircle_Config.OffensiveDelay) then
              throw = false;
            end
          end           
        end
      end

      local start, duration = GetSpellCooldown(FrowningCircle_Data.IDs[FrowningCircle_LastTotem][selected], BOOKTYPE_SPELL);
      if (start > 0 and duration > 0) then
        throw = false;
      end      

      if (throw == true) then
        CastSpellByName(FrowningCircle_Data.Spells[FrowningCircle_LastTotem][selected]);
        FrowningCircle_DidCast = FrowningCircle_LastTotem;
        FrowningCircle_LastTotem = FrowningCircle_LastTotem + 1;
        if (FrowningCircle_LastTotem == 5) then
          FrowningCircle_LastTotem = 1;
        end
        return;
      end
    end

    FrowningCircle_LastTotem = FrowningCircle_LastTotem + 1;
    if (FrowningCircle_LastTotem == 5) then
      FrowningCircle_LastTotem = 1;
    end

    if (FrowningCircle_LastTotem == old) then
      break;
    end
  end
end

function FrowningCircle_ConfigFrameInit()
  for key,value in pairs(FrowningCircle_ObjectType) do
    if (value == "check") then
      local object = getglobal("TotemConfigFrame" .. key);
      object.tooltipText = FrowningCircle_ObjectTooltip[key];
      object:SetChecked(FrowningCircle_Config[key]);
      local text = getglobal("TotemConfigFrame" .. key .. "Text");
      text:SetText(FrowningCircle_ObjectText[key]);
      text:SetTextColor(1, 1, 1);
    elseif (value == "slider") then
      local object = getglobal("TotemConfigFrame" .. key);
      local minv, maxv = object:GetMinMaxValues();
      object:SetValue(FrowningCircle_Config[key]);
      local object = getglobal("TotemConfigFrame" .. key .. "Text");
      object:SetText(FrowningCircle_ObjectText[key]);
      local low = getglobal("TotemConfigFrame" .. key .. "Low");
      low:SetText(minv .. "s");
      local high = getglobal("TotemConfigFrame" .. key .. "High");
      high:SetText(maxv .. "s");
    end
  end
end

function FrowningCircle_UseSet(set)
  if (set == "prev") then
    set = FrowningCircle_Config.ActiveSet - 1;
  elseif (set == "next") then
    set = FrowningCircle_Config.ActiveSet + 1;
  end
  if (set > 5) then
    set = 1;
  elseif (set < 1) then
    set = 5;
  end

  FrowningCircle_Msg("Using set" .. set);

  FrowningCircle_Config.ActiveSet = set;

  FrowningCircle_Set = FrowningCircle_Config.Sets[FrowningCircle_Config.ActiveSet];
  FrowningCircle_State = FrowningCircle_States[FrowningCircle_Config.ActiveSet];

  FrowningCircle_State.LastCastTimes = {};
  FrowningCircle_DidCast = nil;
end
