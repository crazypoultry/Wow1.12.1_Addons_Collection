-- ShowGuild 11000.1 - Shows guild above target frame.
-- Credits: Shim / PIng -- Extracted from SKMap 1.6.

function ShowGuild_OnLoad()
  this:RegisterEvent("PLAYER_TARGET_CHANGED");
end

function ShowGuild_OnEvent()
  if ( event == "PLAYER_TARGET_CHANGED" ) then
    local sGuildName = GetGuildInfo("target");
    ShowGuild_setGuild(sGuildName);
  end
end

function ShowGuild_setGuild(sGuildName)
  if (sGuildName == nil) or (sGuildName == "") then
    TargetGuildInfo:Hide();
  else
    local id=1;
    TextValue = getglobal("TargetGuildInfoButton"..id.."Value");
    TextValue:SetText("|cffffffff"..sGuildName);
    TargetGuildInfo:Show();
  end
end
