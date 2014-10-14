TargetName = {};
TargetName[1] = "Yellow Star";
TargetName[2] = "Orange Circle";
TargetName[3] = "Purple Diamond";
TargetName[4] = "Green Triangle";
TargetName[5] = "White Moon";
TargetName[6] = "Blue Square";
TargetName[7] = "Red X";
TargetName[8] = "Skull";

function GOFAnnounce_OnLoad()
	SlashCmdList["GOFAnnounce"] = GOFAnnounce_SlashHandler;
	SLASH_GOFAnnounce1 = "/gofannounce";
	SLASH_GOFAnnounce2 = "/gofa";
end

local function AnnounceTarget()
  SendChatMessage(warning,"RAID_WARNING");
end

local function TranslateTarget()
  if (icon == nil) then
    TargetText = "Unmarked";
  else
    TargetText = TargetName[icon];
  end
end

function GOFAnnounce_SlashHandler(msg)

  Player = UnitName("player");
  Target = UnitName("target");
  
  if  UnitIsEnemy("player","target") then
    if  (UnitExists("target")) then
  
      icon=GetRaidTargetIndex("target");
      TranslateTarget();
      
      if  (msg == "") then
        warning = "Attack "..Player.."\'s >>"..Target.."<< now!                            ("..TargetText..")";
      elseif  (msg == "pull") then
        warning = ""..Player.." is pulling >>"..Target.."<< now!                            ("..TargetText..")";
      elseif  (msg == "sheep") then
        warning = "Sheep >>"..Target.."<< now!                                  ("..TargetText..")";
      elseif  (msg == "banish") then
        warning = "Banish >>"..Target.."<< now!                                  ("..TargetText..")";
      end  
  
      AnnounceTarget();
    else
      DEFAULT_CHAT_FRAME:AddMessage( "|cFF00FFFFGOFAnnounce|r - |cFFFF0000Invalid target.|r" );
    end
  
  else
    if  (UnitExists("target")) then
      DEFAULT_CHAT_FRAME:AddMessage( "|cFF00FFFFGOFAnnounce|r - |cFFFF0000Target is friendly.|r" );
    else
      DEFAULT_CHAT_FRAME:AddMessage( "|cFF00FFFFGOFAnnounce|r - |cFFFF0000No target.|r" );
    end

  end
  

end