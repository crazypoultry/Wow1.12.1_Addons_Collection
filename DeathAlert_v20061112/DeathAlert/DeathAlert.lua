--DeathAlert by Odlaw, inspired by Artemas

DeathAlert_Icon = {};
DeathAlert_Icon.Star = "Star";
DeathAlert_Icon.Circle = "Circle";
DeathAlert_Icon.Diamond = "Diamond";
DeathAlert_Icon.Triangle = "Triangle";
DeathAlert_Icon.Moon = "Moon";
DeathAlert_Icon.Square = "Square";
DeathAlert_Icon.X = "X";
DeathAlert_Icon.Skull = "Skull";
DeathAlert_Color = {};
DeathAlert_Color.Yellow = "Yellow";
DeathAlert_Color.Orange = "Orange";
DeathAlert_Color.Purple = "Purple";
DeathAlert_Color.Green = "Green";
DeathAlert_Color.White = "White";
DeathAlert_Color.Blue = "Blue";
DeathAlert_Color.Red = "Red";

DeathAlert_InStance = 0;
DeathAlert_Target = {};
DeathAlert_Target.Name = "";
DeathAlert_Target.Icon = "";
DeathAlert_FontBeige = "|cFFFFCC66";
DeathAlert_FontLBlue = "|cFF0066FF";
DeathAlert_FontLGreen = "|cFF00FF33";
DeathAlert_ChatHeader = DeathAlert_FontBeige.."[DeathAlert]|r";
DeathAlert_IconColor = {};
DeathAlert_IconColor[DeathAlert_Icon.Star] = DeathAlert_Color.Yellow;
DeathAlert_IconColor[DeathAlert_Icon.Circle] = DeathAlert_Color.Orange;
DeathAlert_IconColor[DeathAlert_Icon.Diamond] = DeathAlert_Color.Purple;
DeathAlert_IconColor[DeathAlert_Icon.Triangle] = DeathAlert_Color.Green;
DeathAlert_IconColor[DeathAlert_Icon.Moon] = DeathAlert_Color.White;
DeathAlert_IconColor[DeathAlert_Icon.Square] = DeathAlert_Color.Blue;
DeathAlert_IconColor[DeathAlert_Icon.X] = DeathAlert_Color.Red;
DeathAlert_IconColor[DeathAlert_Icon.Skull] = DeathAlert_Color.White;

function DeathAlert_SlashCmdHandler(msg)
  msg = string.lower(msg);
  local a,b,cmd,arg = string.find(msg,"(%S+)%s*(.*)");

  if ( cmd == "alert" ) then
    if ( arg == "on" ) then
      DeathAlert_Vars.Active = 1;
    elseif ( arg == "off" ) then
      DeathAlert_Vars.Active = 0;
    else
      DEFAULT_CHAT_FRAME:AddMessage(DeathAlert_ChatHeader.." Usage: /da alert [on | off]");
    end
    DEFAULT_CHAT_FRAME:AddMessage(DeathAlert_ChatHeader.." Alert turned "..DeathAlert_GetStatus(DeathAlert_Vars.Active)..".");
  elseif ( cmd == "pattern" ) then
    if ( string.find(arg, "^\34.*\34$") ) then
      DeathAlert_Vars.Pattern = string.gsub(arg, "\34", "");
    else
      DEFAULT_CHAT_FRAME:AddMessage(DeathAlert_ChatHeader.." Usage: /da pattern \34<pattern>\34");
      DEFAULT_CHAT_FRAME:AddMessage(DeathAlert_ChatHeader.." Available variables:|r %p, %n, %r");
      DEFAULT_CHAT_FRAME:AddMessage(" - "..DeathAlert_FontBeige.."%p:|r Players name");
      DEFAULT_CHAT_FRAME:AddMessage(" - "..DeathAlert_FontBeige.."%n:|r Mobs name");
      DEFAULT_CHAT_FRAME:AddMessage(" - "..DeathAlert_FontBeige.."%r:|r Raid Icon pattern information (if a raid icon available)");
    end
    DEFAULT_CHAT_FRAME:AddMessage(" - "..DeathAlert_FontBeige.."Pattern set to|r \34"..DeathAlert_FontLBlue..DeathAlert_Vars.Pattern.."|r\34");
    DEFAULT_CHAT_FRAME:AddMessage(" - "..DeathAlert_FontBeige.."Pattern in use:|r ["..DeathAlert_FontLGreen..DeathAlert_GetPattern("Murloc", 1).."|r]");
  elseif ( cmd == "iconpattern" ) then
    if ( string.find(arg, "^\34.*\34$") ) then
      DeathAlert_Vars.IconPattern = string.gsub(arg, "\34", "");
    else
      DEFAULT_CHAT_FRAME:AddMessage(DeathAlert_ChatHeader.." Usage: /da iconpattern \34<pattern>\34");
      DEFAULT_CHAT_FRAME:AddMessage(DeathAlert_ChatHeader.." Available variables:|r %c, %i");
      DEFAULT_CHAT_FRAME:AddMessage(" - "..DeathAlert_FontBeige.."%c:|r Color of the raid icon");
      DEFAULT_CHAT_FRAME:AddMessage(" - "..DeathAlert_FontBeige.."%i:|r The shape of the icon");
    end
    DEFAULT_CHAT_FRAME:AddMessage(" - "..DeathAlert_FontBeige.."Icon Pattern set to|r \34"..DeathAlert_FontLBlue..DeathAlert_Vars.IconPattern.."|r\34");
    DEFAULT_CHAT_FRAME:AddMessage(" - "..DeathAlert_FontBeige.."Icon Pattern in use:|r ["..DeathAlert_FontLGreen..DeathAlert_GetIconPattern(2).."|r]");
  else
    DEFAULT_CHAT_FRAME:AddMessage(DeathAlert_ChatHeader.." Usage: /da [alert | pattern | iconpattern]");
    DEFAULT_CHAT_FRAME:AddMessage(" - "..DeathAlert_FontBeige.."alert:|r ["..DeathAlert_GetStatus(DeathAlert_Vars.Active).."] Turns on/off raid alerts.");
    DEFAULT_CHAT_FRAME:AddMessage(" - "..DeathAlert_FontBeige.."pattern:|r ["..DeathAlert_FontLBlue..DeathAlert_Vars.Pattern.."|r] Sets the alert pattern to be used.");
    DEFAULT_CHAT_FRAME:AddMessage(" - "..DeathAlert_FontBeige.."iconpattern:|r ["..DeathAlert_FontLBlue..DeathAlert_Vars.IconPattern.."|r] Sets the icon pattern to be used if there is an icon present.");
    DEFAULT_CHAT_FRAME:AddMessage(" - "..DeathAlert_FontBeige.."Pattern in use:|r ["..DeathAlert_FontLGreen..DeathAlert_GetPattern("Murloc", 1).."|r] An example of the current pattern in use.");
  end
end

function DeathAlert_GetStatus(arg)
  if ( arg == 1 ) then
    return "|cFF00FF00On|r";
  else
    return "|cFFFF0000Off|r";
  end
end

function DeathAlert_GetStance()
  if ( GetNumShapeshiftForms() < 2 ) then
    return;
  end
  local _, name, active, _ = GetShapeshiftFormInfo(2);
  if ( name == "Defensive Stance" and active == 1 ) then
    DeathAlert_InStance = 1;
  else
    DeathAlert_InStance = 0;
  end
end

function DeathAlert_GetIcon(icon)
  if ( icon == 1 ) then
    return DeathAlert_Icon.Star;
  elseif ( icon == 2 ) then
    return DeathAlert_Icon.Circle;
  elseif ( icon == 3 ) then
    return DeathAlert_Icon.Diamond;
  elseif ( icon == 4 ) then
    return DeathAlert_Icon.Triangle;
  elseif ( icon == 5 ) then
    return DeathAlert_Icon.Moon;
  elseif ( icon == 6 ) then
    return DeathAlert_Icon.Square;
  elseif ( icon == 7 ) then
    return DeathAlert_Icon.X;
  elseif ( icon == 8 ) then
    return DeathAlert_Icon.Skull;
  else
    return "";
  end
end

function DeathAlert_ChangeTarget()
  if ( UnitHealth("player") == 0 or UnitName("targettarget") == UnitName("player") ) then
    return;
  end
    if ( UnitName("target") and UnitHealth("target") ~= 0 ) then
      DeathAlert_Target.Name = UnitName("target");
      if ( GetRaidTargetIndex("target") ) then
        DeathAlert_Target.Icon = GetRaidTargetIndex("target");
      else
        DeathAlert_Target.Icon = "";
      end
    else
      DeathAlert_Target.Name = "";
      DeathAlert_Target.Icon = "";
    end
end

function DeathAlert_LoadVars()
  local TempDB = {};
  if ( not DeathAlert_Vars ) then
    DeathAlert_Vars = {};
  end
  if ( not DeathAlert_Vars.Active ) then
    TempDB.Active = 1;
  else
    TempDB.Active = DeathAlert_Vars.Active;
  end
  if ( not DeathAlert_Vars.Pattern ) then
    TempDB.Pattern = "%p is dead, ** %n%r ** is loose!";
  else
    TempDB.Pattern = DeathAlert_Vars.Pattern;
  end
  if ( not DeathAlert_Vars.IconPattern ) then
    TempDB.IconPattern = " (%c %i)";
  else
    TempDB.IconPattern = DeathAlert_Vars.IconPattern;
  end
  DeathAlert_Vars = TempDB;
end

function DeathAlert_GetPattern(Name, Icon)
  local DeathPattern, IconPattern;
  if ( not Name ) then
    Name = DeathAlert_Target.Name;
  end
  if ( not Icon ) then
    Icon = DeathAlert_Target.Icon;
  end
  DeathPattern = string.gsub(DeathAlert_Vars.Pattern, "%%p", UnitName("player"));
  DeathPattern = string.gsub(DeathPattern, "%%n", Name);
  DeathPattern = string.gsub(DeathPattern, "%%r", DeathAlert_GetIconPattern(Icon));
  return DeathPattern;
end

function DeathAlert_GetIconPattern(Icon)
  local IconPattern;
  if ( DeathAlert_GetIcon(Icon) ~= "" ) then
    IconPattern = string.gsub(DeathAlert_Vars.IconPattern, "%%i", DeathAlert_GetIcon(Icon));
    IconPattern = string.gsub(IconPattern, "%%c", DeathAlert_IconColor[DeathAlert_GetIcon(Icon)]);
  else
    IconPattern = "";
  end
  return IconPattern;
end

function DeathAlert_OnEvent()
  if ( event == "ADDON_LOADED" ) then
    if ( arg1 == "DeathAlert" ) then
      DeathAlert_LoadVars();
    end
  end
  if ( event == "PLAYER_ENTERING_WORLD" ) then
    DeathAlert_GetStance();
    return;
  end

  if ( event == "PLAYER_DEAD" ) then
    local chattype;
    if ( GetNumPartyMembers() == 0 and GetNumRaidMembers() == 0 ) then
      return;
    end
    if ( UnitInRaid("player") ) then
      chattype = "RAID";
    else
      chattype = "PARTY";
    end
    if ( DeathAlert_InStance == 1 and DeathAlert_Vars.Active == 1 ) then
      if ( Death_Alert_Target.Name ~= "" ) then
        SendChatMessage(DeathAlert_GetPattern(), chattype, nil, nil);
      end
      DeathAlert_InStance = 0;
    end
    return;
  end

  if ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" ) then
    DeathAlert_GetStance();
    return;
  end

  if ( event == "PLAYER_TARGET_CHANGED" ) then
    DeathAlert_ChangeTarget();
    return;
  end

  if ( event == "RAID_TARGET_UPDATE" ) then
    DeathAlert_ChangeTarget();
    return;
  end

  if ( string.find(event, "CHAT_MSG_COMBAT") or string.find(event, "SELF_DAMAGE") ) then
    DeathAlert_ChangeTarget();
    return;
  end

  if ( event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" ) then
    if ( string.find(arg1, DeathAlert_Target.Name) ) then
      if ( UnitHealth("target") == 0 ) then
        DeathAlert_Target.Name = "";
        DeathAlert_Target.Icon = "";
      end
    else
      DeathAlert_Target.Name = "";
      DeathAlert_Target.Icon = "";
    end
  end
end

SLASH_DEATHALERT1 = "/da";
SlashCmdList["DEATHALERT"] = function(msg)
  DeathAlert_SlashCmdHandler(msg);
end

local DeathAlertFrame = CreateFrame("Frame");
DeathAlertFrame:SetScript("OnEvent", DeathAlert_OnEvent);
DeathAlertFrame:RegisterEvent("ADDON_LOADED");
DeathAlertFrame:RegisterEvent("PLAYER_DEAD");
DeathAlertFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
DeathAlertFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
DeathAlertFrame:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
DeathAlertFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
DeathAlertFrame:RegisterEvent("RAID_TARGET_UPDATE");
DeathAlertFrame:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS");
DeathAlertFrame:RegisterEvent("CHAT_MSG_COMBAT_SELF_HITS");
DeathAlertFrame:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE");
DeathAlertFrame:RegisterEvent("CHAT_MSG_SPELL_SELF_DAMAGE");
DeathAlertFrame:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE");
