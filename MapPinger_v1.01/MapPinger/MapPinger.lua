--[[
  MapPinger v1.01

  MapPinger display in chat window info about Minimap ping. Writed for control strange 
  players who **spaming** ping in raids or Battlegrounds.

  Original code by Fea of [EU.Warsong] (inferno@bugz.ru)
  Updated and maintained by Kamishimi of [US.Suramar]
]]

local VERSION = "v1.01";

function MapPinger_OnLoad()
  this:RegisterEvent("MINIMAP_PING");
  this:RegisterEvent("VARIABLES_LOADED");
end

function MapPinger_OnEvent()
  if (event == "VARIABLES_LOADED") then
    MapPinger_Load();
  end  

  if (event == "MINIMAP_PING") then
    local userName = UnitName(arg1);
    if (userName ~= UnitName("player")) then
      if (MPConfig["enabled"] == 1) then
        DEFAULT_CHAT_FRAME:AddMessage((userName.." pinged minimap"), 1, 1, 0);
      end
    end
  end
end

function MapPinger_Load()
  if (not MPConfig) then
    MPConfig = {};
    MPConfig["enabled"] = 1;
  end

  MapPinger_Chat("MapPinger "..VERSION.." by Kamishimi loaded");

  SLASH_MAPPINGER1 = "/mappinger";
  SlashCmdList["MAPPINGER"] = function(msg)
	MapPinger_SlashCommandHandler(msg);
  end
end

function MapPinger_Chat(message)
  DEFAULT_CHAT_FRAME:AddMessage("|c000066FF"..message);
end

function MapPinger_SlashCommandHandler(msg)
  if (msg == "enable") then
    MPConfig["enabled"] = 1;
    MapPinger_Chat("MapPinger output enabled.");
  elseif (msg == "disable") then
    MPConfig["disabled"] = 0;
    MapPinger_Chat("MapPinger output disabled.");
  else
    MapPinger_Chat("MapPinger Slash Commands: /mappinger <command>");
    MapPinger_Chat("enable -- Enables minimap pinger output");
    MapPinger_Chat("disable -- Disables minimap pinger output");
  end
end
