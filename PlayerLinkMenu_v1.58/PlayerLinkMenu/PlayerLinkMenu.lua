--[[
    - Player Link Menu
    
    - Adds a movable pop-up menu when clicking a mouse button on
      a name in the chat window.
    - Fully configurable and adds the option to also use Ctrl and
      Alt + click for different behaviors.

    - Version 1.58

    - Copyright © 2005, Viper (http://www.viper.dk/WoW/)
]]


local oldSetItemRef;
local PlayerLinkMenuDragging;
local storedX, storedY;

function PlayerLinkMenu_OnLoad()
  -- Hook the new functions instead of the old ones.
  oldSetItemRef = SetItemRef;
  SetItemRef = PlayerLinkMenu_SetItemRef;

  SLASH_PLM1 = "/plm";
  SlashCmdList["PLM"] = function()
    PlayerLinkMenu_ToggleOptionsFrame();
  end

  this:RegisterForDrag("LeftButton");
  this:RegisterEvent("VARIABLES_LOADED");

  PlayerLinkMenuDragging = false;

  table.insert(UISpecialFrames, "PlayerLinkMenuFrame");
  table.insert(UISpecialFrames, "PlayerLinkMenuOptions");
end


function PlayerLinkMenu_OnEvent(event)
  if (event == "VARIABLES_LOADED") then
    if (VipersAddonsLoaded) then
      local tablePos = table.getn(VipersAddonsLoaded)+1;
      VipersAddonsLoaded[tablePos] = {};
      VipersAddonsLoaded[tablePos]["NAME"] = PLAYERLINKMENU_NAME;
      VipersAddonsLoaded[tablePos]["VERSION"] = PLAYERLINKMENU_VERSION;
      VipersAddonsLoaded[tablePos]["OPTIONSFRAME"] = "PlayerLinkMenuOptions";
    end

    PLAYERLINKMENU_PLAYERNAME = UnitName("player");

    -- Clean up settings from very old versions --
    if ((PlayerLinkMenuSettings) and (PlayerLinkMenuSettings["NONE"])) then
      PlayerLinkMenuSettings = {};
    end

    -- Register for new settings --
    if (not PlayerLinkMenuSettings) then
      PlayerLinkMenuSettings = {};
    end

    -- Register settings for each unique player name --
    if (not PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]) then
      PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME] = {};
      PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["HASMOVED"] = false;
      PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["POSBOTTOM"] = PLAYERLINKMENU_POSBOTTOM;
      PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["POSLEFT"] = PLAYERLINKMENU_POSLEFT;
      PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["MENUSETTINGS"] = {};
      for i, v in plmOptions do
        PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME][v.key] = v.default;
      end
    end

    -- Create new keys for each mouse button --
    if (PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["LEFT"] == nil) then
      PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["LEFT"] = {};
      PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["LEFT"]["NONE"] = 4; --EMERALD
      PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["LEFT"]["SHIFT"] = 3; --EMERALD
      PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["LEFT"]["CTRL"] = 7; --EMERALD
      PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["LEFT"]["ALT"] = 2; --EMERALD
       --EMERALD: none=whisper, shift=who, ctrl=target, alt=invite(group)
    end
    if (PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["RIGHT"] == nil) then
      PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["RIGHT"] = {};
      PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["RIGHT"]["NONE"] = 1;
      PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["RIGHT"]["SHIFT"] = 0;
      PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["RIGHT"]["CTRL"] = 0;
      PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["RIGHT"]["ALT"] = 0;
    end

    -- Create new key for storing user changes to the menu --
    if (PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["MENUSETTINGS"] == nil) then
      PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["MENUSETTINGS"] = {};
    end
    -- Set new keys, if any --
    for i, v in plmOptions do
      if (PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME][v.key] == nil) then
        PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME][v.key] = v.default;
      end
    end

    PLAYERLINKMENU_TIMEOUT = PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["TIMEOUT"];

    -- Create the actions currently enabled --
    PlayerLinkMenu_GenerateActions();

    if ((not VipersAddonsSettings) or ((VipersAddonsSettings) and (not VipersAddonsSettings["SURPRESSLOADMSG"])) and (DEFAULT_CHAT_FRAME)) then
      DEFAULT_CHAT_FRAME:AddMessage("|cffffffff- |cff00f100Viper's Player Link Menu is loaded (version "..PLAYERLINKMENU_VERSION..").");
    end
    return;
  end
end


function PlayerLinkMenu_GenerateActions()
  plmActionsInUse = {};
  for i, v in plmActions do
    pos = i;
    tmp = v;
    tmp.index = i;
    tmp.label = plmLabels[i];
    if (PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["MENUSETTINGS"][i] ~= nil) then
      for n, k in PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["MENUSETTINGS"][i] do
        tmp[n] = k;
      end
      if (tmp.pos) then
        pos = tmp.pos;
        tmp.pos = nil;
      end
    end
    if ((tmp.visible == true) and (tmp.onlyKey ~= true)) then
      plmActionsInUse[pos] = tmp;
    end
  end
end


function PlayerLinkMenu_OnClick()
  local id = this:GetID();
  if (PLAYERLINKMENU_STOREDNAME == nil) then
    return;
  end

  local doAction = plmActions[id].action;
  doAction(PLAYERLINKMENU_STOREDNAME);

  PLAYERLINKMENU_STOREDNAME = nil;
  PlayerLinkMenuFrame:Hide();
end


function PlayerLinkMenu_OnUpdate(elapsed)
  if ((not PlayerLinkMenuDragging) and (PlayerLinkMenuFrame:IsVisible())) then
    local timeleft = PlayerLinkMenuFrame.timeleft - elapsed;
    if (timeleft <= 0) then
      PlayerLinkMenuFrame:Hide();
      return;
    end
    PlayerLinkMenuFrame.timeleft = timeleft;
  end
end


function PlayerLinkMenu_OnDragStart()
  if (not PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["FROZEN"]) then
    storedX, storedY = GetCursorPosition(UIParent);
    PlayerLinkMenuDragging = true;
    PlayerLinkMenuFrame:StartMoving();
  end
end


function PlayerLinkMenu_OnDragStop()
  if (PlayerLinkMenuDragging) then
    local newX, newY = GetCursorPosition(UIParent);
    PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["HASMOVED"] = true;
    PlayerLinkMenuFrame:StopMovingOrSizing();
    PlayerLinkMenuDragging = false;
    PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["POSLEFT"] = PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["POSLEFT"] + (newX - storedX);
    PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["POSBOTTOM"] = PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["POSBOTTOM"] + (newY - storedY);-- - newY;
  end
end


function PlayerLinkMenu_SetItemRef(link, text, button)
  local frameName = this:GetName();
  local iLink, iText, iButton;
  if (not link) then
    iLink = arg1;
  else
    iLink = link;
  end
  if (not text) then
    iText = arg2;
  else
    iText = text;
  end
  if (not button) then
    iButton = arg3;
  else
    iButton = button;
  end
  if ((not iLink) or (not iButton)) then
    return;
  end
  if (strsub(strlower(iLink), 1, 6) == "player") then
    local name = strsub(iLink, 8);
    if ((name) and (strlen(name) > 0)) then
      local offset = 1;
      local paramCutPos = string.find(name, " ", offset);
      if (paramCutPos) then
        while (paramCutPos) do
          offset = paramCutPos+1;
          paramCutPos = string.find(name, " ", offset);
        end
        name = strsub(name, offset);
      end

      local doAction;
      local usedButton = "LEFT";
      local key = "NONE";
      if (iButton == "RightButton") then
        usedButton = "RIGHT";
      end
      if (IsShiftKeyDown()) then
        key = "SHIFT";
      elseif (IsControlKeyDown()) then
        key = "CTRL";
      elseif (IsAltKeyDown()) then
        key = "ALT";
      end
      doAction = PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME][usedButton][key];
      if (doAction > 0) then
        doAction = plmActions[doAction].action;
        doAction(name, frameName);
      end
    end
    return;
  end
  oldSetItemRef(iLink, iText, iButton);
end


function PlayerLinkMenu_DoWhisper(name)
  DEFAULT_CHAT_FRAME.editBox.chatType = "WHISPER";
  DEFAULT_CHAT_FRAME.editBox.tellTarget = name;
  ChatEdit_UpdateHeader(DEFAULT_CHAT_FRAME.editBox);
  if (not DEFAULT_CHAT_FRAME.editBox:IsVisible()) then
    ChatFrame_OpenChat("", DEFAULT_CHAT_FRAME);
  end
end


function PlayerLinkMenu_DoWindow(name, frameName)
  PLAYERLINKMENU_STOREDNAME = name;
  PlayerLinkMenuFrame.timeleft = PLAYERLINKMENU_TIMEOUT;
  local width, btn;
  local maxWidth = 0;
  local titleOffset = 0;

  if (PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["SHOWNAME"]) then
    PlayerLinkMenuTitle:SetText(" "..name.." ");
    PlayerLinkMenuTitle:Show();
    maxWidth = PlayerLinkMenuTitle:GetStringWidth();
  else
    PlayerLinkMenuTitle:Hide();
    titleOffset = PLAYERLINKMENU_TITLE_HEIGHT;
  end

  local i = 1;
  local pos;
  for index, value in plmActionsInUse do
    btn = getglobal("PlayerLinkMenuButton"..i);
    if (btn == nil) then
      return;
    end

    btn:SetText(value.label);

    if (i == 1) then
      btn:ClearAllPoints();
      if (PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["SHOWNAME"]) then
        btn:SetPoint("TOP", "PlayerLinkMenuTitle", "BOTTOM", 0, -8);
      else
        btn:SetPoint("TOP", "PlayerLinkMenuFrame", "TOP", 0, -14);
      end
    elseif (i > 1) then
      btn:ClearAllPoints();
      btn:SetPoint("TOP", "PlayerLinkMenuButton"..(i-1), "BOTTOM", 0, -PLAYERLINKMENU_SPACER_SPACING);
    end

    if (PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["TOOLTIP"]) then
      btn.tooltip = value.tooltip;
    else
      btn.tooltip = nil;
    end

    pos = index;
    if (value.index) then
      pos = value.index;
    end
    btn:SetID(pos);
    btn:Show();

    width = btn:GetTextWidth();
    if (width > maxWidth) then
      maxWidth = width;
    end

    i = i + 1;
  end
  local buttons = i;

  if (i == 1) then
    PlayerLinkMenuFrame:Hide();
    return;
  end

  while (true) do
    btn = getglobal("PlayerLinkMenuButton"..i);
    if (btn) then
      btn:Hide();
    else
      break;
    end
    i = i + 1;
  end

  i = 1;
  for index, value in plmActionsInUse do
    local btn = getglobal("PlayerLinkMenuButton"..i);
    btn:SetWidth(maxWidth);
    i = i + 1;
  end

  local height = ((PLAYERLINKMENU_TITLE_HEIGHT - titleOffset) + (buttons * PLAYERLINKMENU_BUTTON_HEIGHT) + (2 * PLAYERLINKMENU_BORDER_HEIGHT));
  height = height + (buttons * PLAYERLINKMENU_SPACER_SPACING) + 4;
  local width = maxWidth + (2 * PLAYERLINKMENU_BORDER_WIDTH);

  local frame = getglobal(frameName);
  local scale = frame:GetEffectiveScale();
  if (PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["POSATCURSOR"]) then
    local mX, mY = GetCursorPosition(frame);
    mX = mX / scale;
    mY = mY / scale;
    PlayerLinkMenuFrame:ClearAllPoints();
    PlayerLinkMenuFrame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", mX, mY);
  else
    PlayerLinkMenuFrame:ClearAllPoints();
    PlayerLinkMenuFrame:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["POSLEFT"] / scale, PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["POSBOTTOM"] / scale);
  end

  PlayerLinkMenuFrame:SetHeight(height);
  PlayerLinkMenuFrame:SetWidth(width);
  PlayerLinkMenuFrame:Show();
end


function PlayerLinkMenu_ResetWindow()
  PlayerLinkMenuFrame:ClearAllPoints();
  PlayerLinkMenuFrame:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", PLAYERLINKMENU_POSBOTTOM, PLAYERLINKMENU_POSLEFT);
  PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["HASMOVED"] = false;
  PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["POSBOTTOM"] = PLAYERLINKMENU_POSBOTTOM;
  PlayerLinkMenuSettings[PLAYERLINKMENU_PLAYERNAME]["POSLEFT"] = PLAYERLINKMENU_POSLEFT;
  if (DEFAULT_CHAT_FRAME) then
    DEFAULT_CHAT_FRAME:AddMessage("[Player Link Menu] The menu window's position has now been reset back to default.");
  end
end
