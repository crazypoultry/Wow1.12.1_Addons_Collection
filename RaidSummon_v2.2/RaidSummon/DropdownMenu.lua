-- add menu command/toggle/title/spacer
local function AddCommand(text, enabled, func, value)
  local info= { };
  info.text=     text;
  info.disabled= not enabled;
  info.func=     func;
  info.value=    value;
  UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end;
local function AddToggle(text, enabled, getfunc, togglefunc, value)
  local info= { };
  info.text=             text;
  info.disabled=         not enabled;
  info.func=             togglefunc;
  if (type(getfunc) == "function") then
    info.checked=        getfunc();
  else
    info.checked=        getfunc;
  end;
  info.keepShownOnClick= 1;
  info.value=            value;
  UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end;
local function AddTitle(title)
  local info= {};
  info.text=         title;
  info.notClickable= 1;
  info.isTitle=      1;
  UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end;
local function AddSpacer()
  local info= {};
  info.disabled= 1;
  UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end;
-- the UI function doesn't seem to hide this invisible layer, no clue why, or why it's even there
local function SetButtonStatus(level, index, enabled)
  local button= getglobal("DropDownList"..level.."Button"..index);
  local invis=  getglobal("DropDownList"..level.."Button"..index.."InvisibleButton");
  if (enabled) then
    button:Enable();
    invis:Hide();
  else
    button:Disable();
    invis:Show();
  end;
end;

-- simulate radiobuttons for language and minimum shard-count setting
local function SelectLang()
  local level= 2;

  if (this.value) then
    rsmSettings.SetNotificationLanguage(this.value, false);

    -- re-enable and deselect other language buttons
    local listFrame= getglobal("DropDownList"..level);
    for i= 1, listFrame.numButtons do
      local button=          getglobal("DropDownList"..level.."Button"..i);
      local invisibleButton= getglobal("DropDownList"..level.."Button"..i.."InvisibleButton");
      local checkImage=      getglobal("DropDownList"..level.."Button"..i.."Check");
      if (button.value and (type(button.value) == "string") and RSM_LANG[button.value]) then
        button.checked= nil;
        button.notClickable= nil;
        button:Enable();
        invisibleButton:Hide();
        checkImage:Hide();
      end;
    end;

    -- disable this button
    this:SetDisabledTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
    local invisibleButton= getglobal(this:GetName().."InvisibleButton");
    this:Disable();
    invisibleButton:Show();
  end;    
end;
local function SelectShards()
  local level= 2;

  if (this.value) then
    rsmSettings.SetShardMinimum(this.value, false);

    -- re-enable and deselect other shardcount buttons
    local listFrame= getglobal("DropDownList"..level);
    for i= 1, listFrame.numButtons do
      local button=          getglobal("DropDownList"..level.."Button"..i);
      local invisibleButton= getglobal("DropDownList"..level.."Button"..i.."InvisibleButton");
      local checkImage=      getglobal("DropDownList"..level.."Button"..i.."Check");
      if (button.value and tonumber(button.value)) then
        button.checked= nil;
        button.notClickable= nil;
        button:Enable();
        invisibleButton:Hide();
        checkImage:Hide();
      end;
    end;

    -- disable this button
    this:SetDisabledTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
    local invisibleButton= getglobal(this:GetName().."InvisibleButton");
    this:Disable();
    invisibleButton:Show();
  end;    
end;

-- public interface
rsmDropdownMenu= {

  -- provide some support functions to fill the menu
  AddToggle=       AddToggle;
  AddCommand=      AddCommand;
  AddTitle=        AddTitle;
  AddSpacer=       AddSpacer;
  SetButtonStatus= SetButtonStatus;
  
  -- called by RaidSummon.lua's OnLoad
  OnLoad= function()

  end;

  -- update enable/disable status
  OnUpdate= function(elapsed)
    -- return if dropdownlist not currently shown
	  if (not (rsmSaved.enabled and DropDownList1:IsVisible() and UIDROPDOWNMENU_OPEN_MENU ~= "RSM_DropDownMenu")) then
  		return;
  	end;

    -- get current environment
    local inGroup=        (GetNumPartyMembers() > 0) or (GetNumRaidMembers() > 0);
    local targetInGroup=  (UnitInParty("target") or UnitInRaid("target"));
    local somebodyQueued= (rsm.GetNumPlayerQueued() ~= 0);
    local massSummoning=  rsm.IsMassSummoning();
    
    -- enable or disable buttons based on new environmental conditions
    for i= 1, UIDROPDOWNMENU_MAXBUTTONS do
      value= getglobal("DropDownList1Button"..i).value;
      if (value == "summon_queue") then
        SetButtonStatus(1, i, inGroup and somebodyQueued);
      elseif (value == "summon_target") then
        SetButtonStatus(1, i, inGroup and targetInGroup);
      elseif (value == "summon_all") then
        SetButtonStatus(1, i, inGroup and not massSummoning and not IsInInstance());
      elseif (value == "queue_skip") then
        SetButtonStatus(1, i, somebodyQueued);
      elseif (value == "queue_reset") then
        SetButtonStatus(1, i, somebodyQueued);
      elseif (value == "announce") then
        SetButtonStatus(1, i, inGroup);  
      end;
    end;      
  end;
  
  -- create basic menu entries
  BuildBaseMenu= function()
    -- create notification submenu
    if (UIDROPDOWNMENU_MENU_LEVEL == 2 and this.value == "notifications") then
      AddTitle(RSM_MENU_SELECT);
      AddToggle(RSM_MENU_ANNOUNCING, true, rsmSaved.announce, rsmSettings.ToggleAnnounce);
      AddToggle(RSM_MENU_WHISPERING, true, rsmSaved.whisper,  rsmSettings.ToggleWhisper);
      AddSpacer();

      AddTitle(RSM_MENU_DISPLAY);
      AddToggle(RSM_MENU_HIDE_REQUESTS, true, rsmSaved.hideRequests, rsmSettings.ToggleHideRequests);
      AddToggle(RSM_MENU_HIDE_TELLS,    true, rsmSaved.hideReplies,  rsmSettings.ToggleHideReplies);
      AddSpacer();

      AddTitle(RSM_MENU_LOCALE);
      for tag, data in RSM_LANG do
        local name= data["LANGUAGE"];
        local info= { };
        info.text=             name;
        info.checked=          (tag == rsmSaved.interactLang);
        info.notClickable=     (tag == rsmSaved.interactLang);
        info.keepShownOnClick= 1;
        info.value=            tag;
        info.func=             SelectLang;
        UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
      end;

    -- create minumum-shard submenu
    elseif (UIDROPDOWNMENU_MENU_LEVEL == 2 and this.value == "shards") then
      AddTitle(RSM_MENU_SHARDS);
      for i= 1, 28, 3 do
        local info= { };
        info.text=             i;
        info.checked=          (i == rsmSaved.minShards);
        info.notClickable=     (i == rsmSaved.minShards);
        info.keepShownOnClick= 1;
        info.value=            i;
        info.func=             SelectShards;
        UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
      end;

    elseif (UIDROPDOWNMENU_MENU_LEVEL == 1) then
      -- check current environment
      local inGroup=        (GetNumPartyMembers() > 0) or (GetNumRaidMembers() > 0);
      local targetInGroup=  (UnitInParty("target") or UnitInRaid("target"));
      local somebodyQueued= (rsm.GetNumPlayerQueued() ~= 0);
      local massSummoning=  rsm.IsMassSummoning();
      local clearText;
      if (massSummoning) then
        clearText= RSM_MENU_STOP;
      else
        clearText= RSM_MENU_CLEAR;
      end;

      -- prevent stupid submenu arrows from actually hiding the submenu they are supposed to open... congrats Blizzard!
      for i= 1, UIDROPDOWNMENU_MAXBUTTONS do
        getglobal("DropDownList"..UIDROPDOWNMENU_MENU_LEVEL.."Button"..i.."ExpandArrow"):Disable();
      end;

      -- create menu
      AddTitle(BINDING_HEADER_RAIDSUMMON);

      AddCommand(RSM_MENU_SUMMON,        inGroup and somebodyQueued, rsm.SummonQueued, "summon_queue");
      AddCommand(RSM_MENU_SUMMON_TARGET, inGroup and targetInGroup,  rsm.SummonTarget, "summon_target");
      AddCommand(RSM_MENU_SUMMON_ALL,    inGroup and not massSummoning and not IsInInstance(), rsm.SummonAll, "summon_all");
      AddSpacer();

      AddCommand(RSM_MENU_SKIP,     somebodyQueued,    rsm.SkipQueue, "queue_skip");
      AddCommand(clearText,         somebodyQueued,    rsm.ResetQueue, "queue_reset");
      AddCommand(RSM_MENU_ANNOUNCE, inGroup,           rsm.Announce, "announce");
      AddSpacer();

      AddToggle(RSM_MENU_PROCESS, true, rsmSaved.listen, rsmSettings.ToggleListen);
      AddSpacer();

      UIDropDownMenu_AddButton({ ["text"]= RSM_MENU_SHARD_MINIMUM, ["hasArrow"]= 1, ["value"]="shards" });
      UIDropDownMenu_AddButton({ ["text"]= RSM_MENU_NOTIFICATIONS, ["hasArrow"]= 1, ["value"]="notifications" });
    end;
  end;

}
