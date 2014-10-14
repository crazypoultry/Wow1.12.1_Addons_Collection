function BgMap_onload()
	DEFAULT_CHAT_FRAME:AddMessage(BGM_LOADED);
	SlashCmdList["BGMAP"] = BgMap_command;
	SLASH_BGMAP1 = "/bgmap";
	SLASH_BGMAP2 = "/bgm";
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
end

function BgMap_command() 
DEFAULT_CHAT_FRAME:AddMessage(BGM_HELP_MSG);
end 

function BgMap_display()
  if(event == "PLAYER_ENTERING_WORLD") then
	ZoneName = GetRealZoneText();
	if not( (ZoneName == BGM_WARSONG) or (ZoneName == BGM_ALTERAC) or (ZoneName == BGM_ARATHI)  ) then ToggleBattlefieldMinimap();
	end
  end
end