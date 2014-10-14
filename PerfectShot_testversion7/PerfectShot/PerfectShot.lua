--
-- PerfectShot testversion7
--
-- by Bastian Pflieger <wb@illogical.de>
--
-- Last update: August 23, 2006
--

local screens, delay, showNamesDuringSeries;
local screensTaken, timer;
local cvars = {};

function PerfectShot_OnLoad()
  this:RegisterEvent("VARIABLES_LOADED");

  SlashCmdList["PERFECTSHOT"] = PerfectShot_ChatCommand;
  SLASH_PERFECTSHOT1 = "/ps";

  PerfectShot_Message(PERFECTSHOT_VERSION .. PERFECTSHOT_LOADED);
end

function PerfectShot_PrepareScreenshot(showNames, clearTarget)
  -- save UI status and hide all windows
  PerfectShotFrameSS.showUIParent = UIParent:IsVisible();
  if UIParent:IsVisible() then
    CloseAllWindows();
    UIParent:Hide();
  end

  -- hide name plates
  HideNameplates();
  HideFriendNameplates();

  -- deselect current target if requested
  PerfectShotFrameSS.restoreTarget = clearTarget and UnitExists("target");
  if clearTarget then
    ClearTarget();
  end

  -- hide fps
  PerfectShotFrameSS.restoreFps = FramerateText:IsVisible();
  if FramerateText:IsVisible() then
    ToggleFramerate();
  end

  -- save and setup name config
  PerfectShot_SaveNameStatus();
  if showNames then
    PerfectShot_SetNameStatus(1);
  else
    PerfectShot_SetNameStatus(0);
  end
  -- always hide own name dispite user setup
  SetCVar("UnitNameOwn", 0);

  PerfectShotFrameSS:Show();
end

function PerfectShot_Reset()
  if NAMEPLATES_ON or FRIENDNAMEPLATES_ON then
    this.wait = 0;
  else
    this.wait = 1;
  end
end

function PerfectShot_TakeScreenshot()
  this.wait = this.wait + 1;
  if this.wait == 2 then
    -- the moment we all waited for
    TakeScreenshot();
  elseif this.wait >= 3 then
    PerfectShot_AfterScreenshot();
    this:Hide();
  end
end

function PerfectShot_AfterScreenshot()
  -- restore name plates
  if NAMEPLATES_ON then
    ShowNameplates();
  end
  if FRIENDNAMEPLATES_ON then
    ShowFriendNameplates();
  end

  -- restore fps and name status
  PerfectShot_SetNameStatus();
  if this.restoreFps then
    ToggleFramerate();
  end

  -- restore last target
  if this.restoreTarget then
    TargetLastTarget();
  end

  -- if UI was visible _before_ the screenshot then we show it again
  if this.showUIParent then
    UIParent:Show();
  end
end

function PerfectShot_SaveNameStatus()
  cvars.UnitNameNPC = GetCVar("UnitNameNPC");
  cvars.UnitNamePlayer = GetCVar("UnitNamePlayer");
  cvars.UnitNamePlayerGuild = GetCVar("UnitNamePlayerGuild");
  cvars.UnitNamePlayerPVPTitle = GetCVar("UnitNamePlayerPVPTitle");
  cvars.UnitNameOwn = GetCVar("UnitNameOwn");
  --cvars.PetNamePlates = GetCVar("PetNamePlates");
end

function PerfectShot_SetNameStatus(value_Override)
  for cvar_name, cvar_value in pairs(cvars) do
    if value_Override then
      SetCVar(cvar_name, value_Override);
    else
      SetCVar(cvar_name, cvar_value);
    end
  end
end

function PerfectShot_ChatCommand(msg)
  -- assign parsing results to temporary variables, in case user enters invalid data
  -- the current screenshot series is not affected (if any)
  local _, _, screens_, delay_ = string.find(msg, "([1-9]%d*) (%d+[%.]?%d*)");
  local _, _, showNamesDuringSeries_ = string.find(msg, "%d+ .+ (.+)");
  if screens_ and delay_ then
    -- ok, user input valid. It's save to override any active series (if any).
    screens = tonumber(screens_);
    delay = tonumber(delay_);
    showNamesDuringSeries = showNamesDuringSeries_;
    if showNamesDuringSeries then
      PerfectShot_Message(string.format(PERFECTSHOT_STATUS1a, screens, delay));
    else
      PerfectShot_Message(string.format(PERFECTSHOT_STATUS1b, screens, delay));
    end
    timer = 0;
    screensTaken = 0;
    PerfectShotFrame:Show();
  elseif msg == "cancel" then
    if PerfectShotFrame:IsVisible() then
      PerfectShot_Message(PERFECTSHOT_STATUS3);
    else
      PerfectShot_Message(PERFECTSHOT_STATUS4);
    end
    PerfectShotFrame:Hide();
  else
    PerfectShot_Message(PERFECTSHOT_CHATHELP1);
    PerfectShot_Message(PERFECTSHOT_CHATHELP2);
  end
end

function PerfectShot_OnUpdate(elapsed)
  timer = timer + elapsed;

  if timer > delay and not PerfectShotFrameSS:IsVisible() then
    PerfectShot_PrepareScreenshot(showNamesDuringSeries);
    timer = 0;
    screensTaken = screensTaken + 1;
    PerfectShot_Message(string.format(PERFECTSHOT_STATUS5, screensTaken, screens, delay));
  end

  if screensTaken >= screens then
    PerfectShot_Message(string.format(PERFECTSHOT_STATUS2, screens));
    this:Hide();
  end
end

function PerfectShot_Message(msg)
  ChatFrame1:AddMessage(string.format(PERFECTSHOT_CHATMESSAGE, msg));
end

-- MyAddons 2.0 support
function PerfectShot_RegisterMyAddons()
  if myAddOnsFrame_Register then
    myAddOnsFrame_Register( {
      name = PERFECTSHOT_NAME,
      description = PERFECTSHOT_MYADDONS_DESCRIPTION,
      version = PERFECTSHOT_VERSION,
      releaseDate = PERFECTSHOT_MYADDONS_RELEASEDATE,
      author = "wbb",
      email = "<wb@illogical.de>",
      website = "http://www.illogical.de",
      category = MYADDONS_CATEGORY_OTHERS,
      frame = "PerfectShotFrame"
    }, {
      PERFECTSHOT_CHATHELP1 .. "\n\n" ..
      PERFECTSHOT_CHATHELP2
    } );
  end
end