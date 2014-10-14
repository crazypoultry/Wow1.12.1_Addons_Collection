--[[
    - Player Link Menu
      Constants and variables for the add-on.
]]

PLAYERLINKMENU_VERSION = "1.58";
PLAYERLINKMENU_NAME = "Player Link Menu";

PLAYERLINKMENU_STOREDNAME = nil;
PLAYERLINKMENU_PLAYERNAME = nil;
PLAYERLINKMENU_USEDSAVE = false;
PLAYERLINKMENU_USEDDEFAULT = false;
PLAYERLINKMENU_TIMEOUT = 3;
PLAYERLINKMENU_TIMEOUT_BACKUP = nil;
PLAYERLINKMENU_TITLE_HEIGHT = 18;
PLAYERLINKMENU_BUTTON_HEIGHT = 12;
PLAYERLINKMENU_BORDER_HEIGHT = 4;
PLAYERLINKMENU_BORDER_WIDTH = 16;
PLAYERLINKMENU_SPACER_SPACING = 3;
PLAYERLINKMENU_POSLEFT = 0;
PLAYERLINKMENU_POSBOTTOM = 0;

PLAYERLINKMENU_LABEL_VERSION = "Version "..PLAYERLINKMENU_VERSION;
PLAYERLINKMENU_LABEL_POSATCURSOR = "Position menu at mouse cursor";
PLAYERLINKMENU_LABEL_TOOLTIP = "Show tooltips for menu buttons";
PLAYERLINKMENU_LABEL_FROZEN = "Lock menu position (no dragging)";
PLAYERLINKMENU_LABEL_SHOWNAME = "Show player name in menu";
PLAYERLINKMENU_LABEL_NONE = "None";
PLAYERLINKMENU_LABEL_SHIFT = "Shift";
PLAYERLINKMENU_LABEL_CTRL = "Ctrl";
PLAYERLINKMENU_LABEL_ALT = "Alt";
PLAYERLINKMENU_LABEL_RESETWINDOW = "Reset window";
PLAYERLINKMENU_LABEL_TIMEOUT = "Window timeout"
PLAYERLINKMENU_TOOLTIP_TIMEOUT = "Click to change timeout value";

PLAYERLINKMENU_APPLY = "Apply";

plmOptions = {};
plmOptions[1] = {key="POSATCURSOR", frame="GeneralPosAtCursor", default=true, frametype="CHECKBOX"};
plmOptions[2] = {key="TOOLTIP", frame="GeneralTooltip", default=true, frametype="CHECKBOX"};
plmOptions[3] = {key="FROZEN", frame="GeneralFrozen", default=false, frametype="CHECKBOX"};
plmOptions[4] = {key="SHOWNAME", frame="GeneralShowName", default=true, frametype="CHECKBOX"};
plmOptions[5] = {key="TIMEOUT", frame="MiscStuffEditBox", default=3, frametype="EDITBOX"};

plmDropdowns = {};
plmDropdowns[1] = {button="Left", mode="None", default=4}; --EMERALD
plmDropdowns[2] = {button="Left", mode="Shift", default=3}; --EMERALD
plmDropdowns[3] = {button="Left", mode="Ctrl", default=7}; --EMERALD
plmDropdowns[4] = {button="Left", mode="Alt", default=2}; --EMERALD
plmDropdowns[5] = {button="Right", mode="None", default=1};
plmDropdowns[6] = {button="Right", mode="Shift", default=0};
plmDropdowns[7] = {button="Right", mode="Ctrl", default=0};
plmDropdowns[8] = {button="Right", mode="Alt", default=0};

plmLabels = {};
plmLabels[1] = "Open menu";
plmLabels[2] = "Invite";
plmLabels[3] = "Who";
plmLabels[4] = "Whisper";
plmLabels[5] = "Add friend";
plmLabels[6] = "Ignore";
plmLabels[7] = "Target";
plmLabels[8] = "Guild invite";
plmLabels[9] = "Close";

plmActions = {};
plmActions[1] = {
  label = nil,
  tooltip = "Shows the Player Link Menu",
  visible = true,
  onlyKey = true,
  action = function(name, frameName)
    PlayerLinkMenu_DoWindow(name, frameName);
  end,
};
plmActions[2] = {
  label = nil,
  tooltip = "Invites the player to join your party",
  visible = true,
  onlyKey = false,
  action = function(name)
    InviteByName(name);
  end,
};
plmActions[3] = {
  label = nil,
  tooltip = "Gives you the standard Who information about the player",
  visible = true,
  onlyKey = false,
  action = function(name)
    SendWho("n-"..name);
  end,
};
plmActions[4] = {
  label = nil,
  tooltip = "Sends a whisper to the player",
  visible = true,
  onlyKey = false,
  action = function(name)
    PlayerLinkMenu_DoWhisper(name);
  end,
};
plmActions[5] = {
  label = nil,
  tooltip = "Adds the player to your friends list",
  visible = true,
  onlyKey = false,
  action = function(name)
    AddFriend(name);
  end,
};
plmActions[6] = {
  label = nil,
  tooltip = "Adds the player to your ignore list",
  visible = true,
  onlyKey = false,
  action = function(name)
    AddIgnore(name);
  end,
};
plmActions[7] = {
  label = nil,
  tooltip = "Selects the player as your target (if within range)",
  visible = true,
  onlyKey = false,
  action = function(name)
    TargetByName(name);
    if (UnitName("target") ~= name) then
      ClearTarget();
    end
  end,
};
plmActions[8] = {
  label = nil,
  tooltip = "Invites the player to join your guild",
  visible = true,
  onlyKey = false,
  action = function(name)
    GuildInviteByName(name);
  end,
};
plmActions[9] = {
  label = nil,
  tooltip = "Closes this window",
  visible = true,
  onlyKey = nil,
  action = function()
  end,
};

plmActionsInUse = {};
plmActionsEdit = {};
