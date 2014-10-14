PassLoot_FontColor = "|cFFFFCC66";
PassLoot_ChatHeader = PassLoot_FontColor.."[PassLoot]|r";

PassLoot_Loot = {};
PassLoot_Loot["Zul'Gurub"] = {};
PassLoot_Loot["Zul'Gurub"][1] = "Bloodscalp Coin";
PassLoot_Loot["Zul'Gurub"][2] = "Gurubashi Coin";
PassLoot_Loot["Zul'Gurub"][3] = "Hakkari Coin";
PassLoot_Loot["Zul'Gurub"][4] = "Razzashi Coin";
PassLoot_Loot["Zul'Gurub"][5] = "Sandfury Coin";
PassLoot_Loot["Zul'Gurub"][6] = "Skullsplitter Coin";
PassLoot_Loot["Zul'Gurub"][7] = "Vilebranch Coin";
PassLoot_Loot["Zul'Gurub"][8] = "Witherbark Coin";
PassLoot_Loot["Zul'Gurub"][9] = "Zulian Coin";
PassLoot_Loot["Zul'Gurub"][10] = "Blue Hakkari Bijou";
PassLoot_Loot["Zul'Gurub"][11] = "Bronze Hakkari Bijou";
PassLoot_Loot["Zul'Gurub"][12] = "Gold Hakkari Bijou";
PassLoot_Loot["Zul'Gurub"][13] = "Green Hakkari Bijou";
PassLoot_Loot["Zul'Gurub"][14] = "Orange Hakkari Bijou";
PassLoot_Loot["Zul'Gurub"][15] = "Purple Hakkari Bijou";
PassLoot_Loot["Zul'Gurub"][16] = "Red Hakkari Bijou";
PassLoot_Loot["Zul'Gurub"][17] = "Silver Hakkari Bijou";
PassLoot_Loot["Zul'Gurub"][18] = "Yellow Hakkari Bijou";
PassLoot_Loot["Ruins of Ahn'Qiraj"] = {};
PassLoot_Loot["Ruins of Ahn'Qiraj"][1] = "Bone Scarab";
PassLoot_Loot["Ruins of Ahn'Qiraj"][2] = "Bronze Scarab";
PassLoot_Loot["Ruins of Ahn'Qiraj"][3] = "Clay Scarab";
PassLoot_Loot["Ruins of Ahn'Qiraj"][4] = "Crystal Scarab";
PassLoot_Loot["Ruins of Ahn'Qiraj"][5] = "Gold Scarab";
PassLoot_Loot["Ruins of Ahn'Qiraj"][6] = "Ivory Scarab";
PassLoot_Loot["Ruins of Ahn'Qiraj"][7] = "Silver Scarab";
PassLoot_Loot["Ruins of Ahn'Qiraj"][8] = "Stone Scarab";
PassLoot_Loot["Ruins of Ahn'Qiraj"][9] = "Alabaster Idol";
PassLoot_Loot["Ruins of Ahn'Qiraj"][10] = "Amber Idol";
PassLoot_Loot["Ruins of Ahn'Qiraj"][11] = "Azure Idol";
PassLoot_Loot["Ruins of Ahn'Qiraj"][12] = "Jasper Idol";
PassLoot_Loot["Ruins of Ahn'Qiraj"][13] = "Lambent Idol";
PassLoot_Loot["Ruins of Ahn'Qiraj"][14] = "Obsidian Idol";
PassLoot_Loot["Ruins of Ahn'Qiraj"][15] = "Onyx Idol";
PassLoot_Loot["Ahn'Qiraj"] = {};
PassLoot_Loot["Ahn'Qiraj"][1] = "Bone Scarab";
PassLoot_Loot["Ahn'Qiraj"][2] = "Bronze Scarab";
PassLoot_Loot["Ahn'Qiraj"][3] = "Clay Scarab";
PassLoot_Loot["Ahn'Qiraj"][4] = "Crystal Scarab";
PassLoot_Loot["Ahn'Qiraj"][5] = "Gold Scarab";
PassLoot_Loot["Ahn'Qiraj"][6] = "Ivory Scarab";
PassLoot_Loot["Ahn'Qiraj"][7] = "Silver Scarab";
PassLoot_Loot["Ahn'Qiraj"][8] = "Stone Scarab";
PassLoot_Loot["Ahn'Qiraj"][9] = "Alabaster Idol";
PassLoot_Loot["Ahn'Qiraj"][10] = "Amber Idol";
PassLoot_Loot["Ahn'Qiraj"][11] = "Azure Idol";
PassLoot_Loot["Ahn'Qiraj"][12] = "Jasper Idol";
PassLoot_Loot["Ahn'Qiraj"][13] = "Lambent Idol";
PassLoot_Loot["Ahn'Qiraj"][14] = "Obsidian Idol";
PassLoot_Loot["Ahn'Qiraj"][15] = "Onyx Idol";
PassLoot_Loot["Naxxramas"] = {};
PassLoot_Loot["Naxxramas"][1] = "Wartorn Chain Scrap";
PassLoot_Loot["Naxxramas"][2] = "Wartorn Cloth Scrap";
PassLoot_Loot["Naxxramas"][3] = "Wartorn Leather Scrap";
PassLoot_Loot["Naxxramas"][4] = "Wartorn Plate Scrap";

function PassLoot_GetStatus(mode)
  if ( mode == "disabled" ) then
    return "|cFF777777Disabled|r";
  elseif ( mode == "pass" ) then
    return "|cFF00FF00Pass|r";
  elseif ( mode == "greed" ) then
    return "|cFFFF3333Greed|r";
  elseif ( mode == "need" ) then
    return "|cFFFF0000Need|r";
  elseif ( mode == "off" ) then
    return "|cFFFF0000Off|r";
  elseif ( mode == "on" ) then
    return "|cFF00FF00On|r";
  elseif ( mode == "enabled" ) then
    return "|cFF00FF00Enabled|r";
  end
end

function PassLoot_SlashCmdHandler(msg)
  msg = string.lower(msg);
  local a,b,cmd,arg = string.find(msg,"(%S+)%s*(%S*)");

  if ( cmd == "specific" ) then
    if ( arg == "pass" ) then
      PassLoot_Vars.Specific = "pass";
    elseif ( arg == "greed" ) then
      PassLoot_Vars.Specific = "greed";
    elseif ( arg == "need" ) then
      PassLoot_Vars.Specific = "need";
    elseif ( arg == "disable" ) then
      PassLoot_Vars.Specific = "disabled";
    else
      DEFAULT_CHAT_FRAME:AddMessage(PassLoot_ChatHeader.." Usage: /passloot specific [pass | greed | need | disable]");
    end
    DEFAULT_CHAT_FRAME:AddMessage(PassLoot_ChatHeader.." Specific loot set to "..PassLoot_GetStatus(PassLoot_Vars.Specific)..".");
  elseif ( cmd == "boe" ) then
    if ( arg == "pass" ) then
      PassLoot_Vars.BOE = "pass";
    elseif ( arg == "greed" ) then
      PassLoot_Vars.BOE = "greed";
    elseif ( arg == "need" ) then
      PassLoot_Vars.BOE = "need";
    elseif ( arg == "disable" ) then
      PassLoot_Vars.BOE = "disabled";
    else
      DEFAULT_CHAT_FRAME:AddMessage(PassLoot_ChatHeader.." Usage: /passloot boe [pass | greed | need | disable]");
    end
    DEFAULT_CHAT_FRAME:AddMessage(PassLoot_ChatHeader.." Bind on equip loot set to "..PassLoot_GetStatus(PassLoot_Vars.BOE)..".");
  elseif ( cmd == "bop" ) then
    if ( arg == "pass" ) then
      PassLoot_Vars.BOP = "pass";
    elseif ( arg == "greed" ) then
      PassLoot_Vars.BOP = "greed";
    elseif ( arg == "need" ) then
      PassLoot_Vars.BOP = "need";
    elseif ( arg == "disable" ) then
      PassLoot_Vars.BOP = "disabled";
    else
      DEFAULT_CHAT_FRAME:AddMessage(PassLoot_ChatHeader.." Usage: /passloot bop [pass | greed | need | disable]");
    end
    DEFAULT_CHAT_FRAME:AddMessage(PassLoot_ChatHeader.." Bind on pickup loot set to "..PassLoot_GetStatus(PassLoot_Vars.BOP)..".");
  elseif ( cmd == "mod" ) then
    if ( arg == "on" ) then
      PassLoot_Vars.Mod = "on";
    elseif ( arg == "off" ) then
      PassLoot_Vars.Mod = "off";
    else
      DEFAULT_CHAT_FRAME:AddMessage(PassLoot_ChatHeader.." Usage: /passloot mod [on | off]");
    end
    DEFAULT_CHAT_FRAME:AddMessage(PassLoot_ChatHeader.." PassLoot mod turned "..PassLoot_GetStatus(PassLoot_Vars.Mod)..".");
  elseif ( cmd == "quiet" ) then
    if ( arg == "enable" ) then
      PassLoot_Vars.Quiet = "enabled";
    elseif ( arg == "disable" ) then
      PassLoot_Vars.Quiet = "disabled";
    else
      DEFAULT_CHAT_FRAME:AddMessage(PassLoot_ChatHeader.." Usage: /passloot quiet [enable | disable]");
    end
    DEFAULT_CHAT_FRAME:AddMessage(PassLoot_ChatHeader.." Quiet mode set to "..PassLoot_GetStatus(PassLoot_Vars.Quiet)..".");
  else
    DEFAULT_CHAT_FRAME:AddMessage(PassLoot_ChatHeader.." Usage: /passloot [mod | specific | boe | bop | quiet]");
    DEFAULT_CHAT_FRAME:AddMessage(" - "..PassLoot_FontColor.."mod:|r ["..PassLoot_GetStatus(PassLoot_Vars.Mod).."] Turns the PassLoot mod on/off.");
    DEFAULT_CHAT_FRAME:AddMessage(" - "..PassLoot_FontColor.."specific:|r ["..PassLoot_GetStatus(PassLoot_Vars.Specific).."] Loot such as coins/bijous in ZG, set in the .lua file.");
    DEFAULT_CHAT_FRAME:AddMessage(" - "..PassLoot_FontColor.."boe:|r ["..PassLoot_GetStatus(PassLoot_Vars.BOE).."] Set loot options for bind on equip.");
    DEFAULT_CHAT_FRAME:AddMessage(" - "..PassLoot_FontColor.."bop:|r ["..PassLoot_GetStatus(PassLoot_Vars.BOP).."] Set loot options for bind on pickup.");
    DEFAULT_CHAT_FRAME:AddMessage(" - "..PassLoot_FontColor.."quiet:|r ["..PassLoot_GetStatus(PassLoot_Vars.Quiet).."] Turn loot messages on/off.");
  end
end

function PassLoot_OnEvent()
  local Key, Value;
  if ( event == "ADDON_LOADED" ) then
    if ( arg1 == "PassLoot" ) then
      local TempDB = {};
      if ( not PassLoot_Vars ) then
        PassLoot_Vars = {};
      end
      if ( not PassLoot_Vars.Specific ) then
        TempDB.Specific = "pass";
      else
        TempDB.Specific = PassLoot_Vars.Specific;
      end
      if ( not PassLoot_Vars.BOP ) then
        TempDB.BOP = "disabled";
      else
        TempDB.BOP = PassLoot_Vars.BOP;
      end
      if ( not PassLoot_Vars.BOE ) then
        TempDB.BOE = "disabled";
      else
        TempDB.BOE = PassLoot_Vars.BOE;
      end
      if ( not PassLoot_Vars.Mod ) then
        TempDB.Mod = "on";
      else
        TempDB.Mod = PassLoot_Vars.Mod;
      end
      if ( not PassLoot_Vars.Quiet ) then
        TempDB.Quiet = "disabled";
      else
        TempDB.Quiet = PassLoot_Vars.Quiet;
      end
      PassLoot_Vars = TempDB;
    end
    return;
  end

  if ( event == "PLAYER_ENTERING_WORLD" ) then
    DEFAULT_CHAT_FRAME:AddMessage(PassLoot_ChatHeader.." Check if settings are fine: PassLoot Mod ["..PassLoot_GetStatus(PassLoot_Vars.Mod).."] Specific ["..PassLoot_GetStatus(PassLoot_Vars.Specific).."] BoE ["..PassLoot_GetStatus(PassLoot_Vars.BOE).."] BoP ["..PassLoot_GetStatus(PassLoot_Vars.BOP).."]");
    return;
  end

  if ( event == "START_LOOT_ROLL" ) then
    local _, name, _, _, bop = GetLootRollItemInfo(arg1);
    if ( PassLoot_Vars.Mod == "off" ) then
      return;
    end
    if ( PassLoot_Vars.Specific ~= "disabled" ) then
      if ( PassLoot_Loot[GetRealZoneText()] ) then
        for Key, Value in PassLoot_Loot[GetRealZoneText()] do
          if ( name == Value ) then
            if ( PassLoot_Vars.Specific == "pass" ) then
              RollOnLoot(arg1, 0);
            elseif ( PassLoot_Vars.Specific == "greed" ) then
              RollOnLoot(arg1, 2);
            elseif ( PassLoot_Vars.Specific == "need" ) then
              RollOnLoot(arg1, 1);
            end
            if ( PassLoot_Vars.Quiet == "disabled" ) then
              DEFAULT_CHAT_FRAME:AddMessage(PassLoot_ChatHeader.." rolling "..PassLoot_Vars.Specific.." on "..name);
            end
            return;
          end
        end
      end
    end
    if ( bop ) then
      if ( PassLoot_Vars.BOP == "pass" ) then
        RollOnLoot(arg1, 0);
      elseif ( PassLoot_Vars.BOP == "greed" ) then
        RollOnLoot(arg1, 2);
      elseif ( PassLoot_Vars.BOP == "need" ) then
        RollOnLoot(arg1, 1);
      else
        --disabled, so do nothing
      end
      if ( PassLoot_Vars.Quiet == "disabled" ) then
        DEFAULT_CHAT_FRAME:AddMessage(PassLoot_ChatHeader.." rolling "..PassLoot_Vars.BOP.." on "..name);
      end
    else
      if ( PassLoot_Vars.BOE == "pass" ) then
        RollOnLoot(arg1, 0);
      elseif ( PassLoot_Vars.BOE == "greed" ) then
        RollOnLoot(arg1, 2);
      elseif ( PassLoot_Vars.BOE == "need" ) then
        RollOnLoot(arg1, 1);
      else
        --disabled, so do nothing
      end
      if ( PassLoot_Vars.Quiet == "disabled" ) then
        DEFAULT_CHAT_FRAME:AddMessage(PassLoot_ChatHeader.." rolling "..PassLoot_Vars.BOE.." on "..name);
      end
    end
  end
end

SLASH_PASSLOOT1 = "/passloot";
SlashCmdList["PASSLOOT"] = function(msg)
  PassLoot_SlashCmdHandler(msg);
end

local PassLootFrame = CreateFrame("Frame");
PassLootFrame:SetScript("OnEvent", PassLoot_OnEvent);
PassLootFrame:RegisterEvent("ADDON_LOADED");
PassLootFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
PassLootFrame:RegisterEvent("START_LOOT_ROLL");
