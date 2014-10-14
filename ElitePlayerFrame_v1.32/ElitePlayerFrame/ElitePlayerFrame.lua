function EPF_OnLoad()
 SLASH_ELITEPLAYERFRAME1 = "/epf";
 SlashCmdList["ELITEPLAYERFRAME"] = function(msg)
  EPF_OnMsg(msg);
 end
 if (EPF_Frame) then
  EPF_FrameHandler(EPF_Frame);
 else
  EPF_FrameHandler("elite");
 end
 if (TitanModMenu_MenuItems) then -- register for Titan ModMenu
  local myentry = {cat = TITAN_MODMENU_CAT_OTHER, submenu = {{text = "Elite Frame", cmd = "/epf elite"}, {text = "Rare Frame", cmd = "/epf rare"}, {text = "Lumpy Frame", cmd = "/epf lumpy"}, {text = "Undead Frame", cmd = "/epf undead"}, {text = "Undead Elite Frame", cmd = "/epf undeadelite"}, {text = "Elf Frame", cmd = "/epf elf"}, {text = "Elf Elite Frame", cmd = "/epf elfelite"}}};
  TitanPanelModMenu_RegisterMenu("Elite Player Frame", myentry);
 end
end

function EPF_OnMsg(msg)
 if (msg == "elite") then
  EPF_FrameHandler("elite");
  EPF_Frame = "elite";
 elseif (msg == "rare") then
  EPF_FrameHandler("rare");
  EPF_Frame = "rare";
 elseif (msg == "lumpy") then
  EPF_FrameHandler("lumpy");
  EPF_Frame = "lumpy";
 elseif (msg == "undead") then
  EPF_FrameHandler("undead");
  EPF_Frame = "undead";
 elseif (msg == "undeadelite") then
  EPF_FrameHandler("undeadelite");
  EPF_Frame = "undeadelite";
 elseif (msg == "elf") then
  EPF_FrameHandler("elf");
  EPF_Frame = "elf";
 elseif (msg == "elfelite") then
  EPF_FrameHandler("elfelite");
  EPF_Frame = "elfelite";
 end
end

function EPF_FrameHandler(unittype)
 if (unittype == "elite") then
  PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");
 elseif (unittype == "rare") then
  PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare");
 elseif (unittype == "lumpy") then
  PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-RareMob");
 elseif (unittype == "undead") then
  PlayerFrameTexture:SetTexture("Interface\\AddOns\\ElitePlayerFrame\\Undead");
 elseif (unittype == "undeadelite") then
  PlayerFrameTexture:SetTexture("Interface\\AddOns\\ElitePlayerFrame\\UndeadElite");
 elseif (unittype == "elf") then
  PlayerFrameTexture:SetTexture("Interface\\AddOns\\ElitePlayerFrame\\Elf");
 elseif (unittype == "elfelite") then
  PlayerFrameTexture:SetTexture("Interface\\AddOns\\ElitePlayerFrame\\ElfElite");
 else
  PlayerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");
 end
end
