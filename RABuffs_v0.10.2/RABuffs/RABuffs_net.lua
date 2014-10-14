-- RABuffs_net.lua
--  Networking bridge, parsing of incoming chat/addon messages, sending available information.
-- Version 0.10.2

RAB_gSync_Version = "RABV %s %s";
RAB_gSync_VersionMask = "RABV ([%w.]+) (%d+)[.,](%d+)";
RAB_gSync_Channel = "rabuffsgvsync";
RAB_gSync_Sent = 0;

RAB_RequestingVersion = "<RAB> Requesting version.";
RAB_VersionReply_Mask = "<RAB> Version ([%w.]+) V(%d+)[.,](%d+)E";
RAB_VersionReply = "<RAB> Version %s V%sE";
RAB_VersionCheck_RequestsExpire = 0;

RAB_RA_VersionReplyMask = "([%w.]+) (%d+)[.,](%d+)";
RAB_RA_BuffsMaskPart = "(%a%w+) (%d+)";


function RAB_gSync_TimerEvent()
 local h, m, i = GetGameTime();
 if (m >= 57 and GetChannelName(RAB_gSync_Channel) == 0) then
  RAB_gSync_Sent = 0;
  for i=7,10 do -- Magic number: General, Trade, LocalDefense, WorldDefense, GuildRecruitment, LookingForGroup
   if (GetChannelName(i) == 0) then
    JoinChannelByName(RAB_gSync_Channel);
    break;
   end
  end
  if (GetChannelName(RAB_gSync_Channel) ~= 0) then
   RAB_Core_Register("CHAT_MSG_CHANNEL","gSync",RAB_gSync_ChatEvent);
  end
 elseif ( m > 3 and m < 57 and GetChannelName(RAB_gSync_Channel) ~= 0) then
  LeaveChannelByName(RAB_gSync_Channel);
  RAB_Core_Unregister("CHAT_MSG_CHANNEL","gSync");
 elseif (m == 0 and GetChannelName(RAB_gSync_Channel) ~= 0 and RAB_gSync_Sent == 0) then
  RAB_SendMessage(string.format(RAB_gSync_Version,RABuffs_Version,RABuffs_DeciVersion),"CHANNEL:" .. RAB_gSync_Channel);
  RAB_gSync_Sent = 1;
 end
end
function RAB_gSync_ChatEvent()
 if (strlower(arg9) == RAB_gSync_Channel and string.find(arg1,RAB_gSync_VersionMask) ~= nil) then
  local _, _, label, version1, version2 = string.find(arg1,RAB_gSync_VersionMask);
  if (label ~= "") then
   local version = tonumber(version1) + tonumber(version2)/(10^strlen(version2));
   RAB_UpdatePeople(arg2,label,version);
  end
 end
end
function RAB_gSync_Init()
 RAB_Core_AddTimer(30,"gSync",RAB_gSync_TimerEvent);
 if (IsInGuild()) then
  SendAddonMessage("RAB/VC", RABuffs_Version .. " " ..RABuffs_DeciVersion, "GUILD");
 end
 return "remove";
end
RAB_Core_Register("PLAYER_ENTERING_WORLD","gSyncInit", RAB_gSync_Init);

--RAB_Core_Register("CHAT_MSG_ADDON","samtest", function () DEFAULT_CHAT_FRAME:AddMessage(string.format("[SAM-%s] [%s]: <%s> %s", arg3, arg4, arg1, arg2), 0.1,0.45,0.9); end);

function RAB_Chat_VersionEvent()
 if ((arg1 == "RAB/V" or arg1 == "RAB/VC") and string.find(arg2,RAB_RA_VersionReplyMask) ~= nil) then
  local _, _, verstxt, vers1, vers2 = string.find(arg2,RAB_RA_VersionReplyMask);
  local versdeci = tonumber(vers1) + tonumber(vers2)/(10^strlen(vers2));
  if (arg3 ~= "BATTLEGROUND") then
   RAB_UpdatePeople(arg4,verstxt,tonumber(versdeci));
  end
  if (arg1 == "RAB/VC") then
   SendAddonMessage("RAB/V", RABuffs_Version .. " " ..RABuffs_DeciVersion, arg3);
  end
 end
end
function RAB_Chat_BuffData()
 if (arg1 == "RAB/BT" and string.find(arg2,RAB_RA_BuffsMaskPart) ~= nil and (arg3 == "RAID" or arg3 == "PARTY")) then
  local key, dur;
  for key, dur in string.gfind(arg2,RAB_RA_BuffsMaskPart) do
   RAB_BuffTimers[arg4 .. "." .. key] = tonumber(((strsub(key,1,3) ~= "h2o") and GetTime() or 0) + dur);
  end
 end
end
function RAB_Chat_SendVersion()
 if (arg1 > 0 and arg2 < 1) then
  local msg = RABuffs_Version .. " " .. RABuffs_DeciVersion;
  SendAddonMessage("RAB/VC",msg,arg1 == 2 and "RAID" or "PARTY");
  SendAddonMessage("RAB/VC",msg,"BATTLEGROUND");
 end
end
RAB_Core_Register("CHAT_MSG_ADDON","nativeTimers",RAB_Chat_BuffData);
RAB_Core_Register("CHAT_MSG_ADDON","readvc",RAB_Chat_VersionEvent);
RAB_Core_Register("RAB_GROUPSTATUS","sendvc",RAB_Chat_SendVersion);

function RAB_SendBuffData_Timer()
 if (RAB_Lock == 1) then
  return;
 end

 local pl = UnitName("player");

 local i, bi, ou, tex, ckey, app = 0, 0, "";
 if (UnitLevel("player") >= 55 and (UnitPowerType("player") == 0 or RAB_UnitClass("player") == "Druid")) then
  RAB_BuffTimers[pl .. ".h2oc"] = RAB_CountItems(8079);
  ou = "h2oc " .. RAB_BuffTimers[pl .. ".h2oc"];
 end
 bi = GetPlayerBuff(i,"HELPFUL");
 while (bi >= 0) do
  _,_, tex = string.find(tostring(GetPlayerBuffTexture(bi)),"\\([^\\]+)$");
  ckey = RAB_TextureToBuff(tostring(tex));
  if (ckey ~= nil and RAB_Buffs[ckey] ~= nil and RAB_Buffs[ckey].type ~= "aura" and floor(GetPlayerBuffTimeLeft(i)) ~= 0 and RAB_Buffs[ckey].recast ~= nil) then
   app = ckey .. " " .. floor(GetPlayerBuffTimeLeft(i)); 
   RAB_BuffTimers[pl .. "." .. ckey] = GetTime() + floor(GetPlayerBuffTimeLeft(i));
   if (UnitInRaid("player") and strlen(app .. ou) + 1 > 240) then
    SendAddonMessage("RAB/BT",ou,"RAID");
    ou = "";
   end
   ou = ou .. (ou ~= "" and " " or "") .. app;
  end
  i = i + 1;
  bi = GetPlayerBuff(i,"HELPFUL");
 end
 if (UnitInRaid("player") and ou ~= "") then
  SendAddonMessage("RAB/BT", ou, "RAID");
 end
end
RAB_Core_AddTimer(30,"buffbroadcast",RAB_SendBuffData_Timer);

function RAB_Chat_VersionCheck()
 if (string.find(arg1,RAB_RequestingVersion) ~= nil) then
  RAB_SendMessage(string.format(RAB_VersionReply,RABuffs_Version,RABuffs_DeciVersion), "WHISPER:" .. arg2);
  if (arg2 ~= UnitName("player")) then
   local checktarget = sRAB_VersionCheck_Requested_You;
   if (event == "CHAT_MSG_RAID") then
    checktarget = sRAB_VersionCheck_Requested_Raid;
   elseif (event == "CHAT_MSG_PARTY") then
    checktarget = sRAB_VersionCheck_Requested_Party;
   elseif (event == "CHAT_MSG_GUILD") then
    checktarget = sRAB_VersionCheck_Requested_Guild;
   end
   RAB_Print(string.format(sRAB_VersionCheck_Requested,arg2,arg2,checktarget));
  end
 end
end
function RAB_Chat_IncomingWhisper()
 if (string.find(arg1,RAB_VersionReply_Mask) ~= nil and RAB_VersionCheck_RequestsExpire > time()) then
  local _, _, display, vers1, vers2 = string.find(arg1,RAB_VersionReply_Mask);
  if (display ~= nil) then
   local version = tonumber(vers1) + tonumber(vers2)/(10^strlen(vers2));
   local out = string.format(sRAB_VersionCheck_Reply, arg2, arg2, display);
   if (version > RABuffs_DeciVersion) then
    RAB_Print(out .. sRAB_VersionCheck_Newer,"warn");
   elseif (version < RABuffs_DeciVersion) then
    RAB_Print(out .. sRAB_VersionCheck_Older,"warn");
   elseif (version == RABuffs_DeciVersion) then
    RAB_Print(out .. sRAB_VersionCheck_Same,"ok");
   end
   RAB_UpdatePeople(arg2,display, version);
  end
 end
end

RAB_Core_Register("CHAT_MSG_GUILD","versioncheck",RAB_Chat_VersionCheck);
RAB_Core_Register("CHAT_MSG_RAID","versioncheck",RAB_Chat_VersionCheck);
RAB_Core_Register("CHAT_MSG_RAID_LEADER","versioncheck",RAB_Chat_VersionCheck);
RAB_Core_Register("CHAT_MSG_PARTY","versioncheck",RAB_Chat_VersionCheck);
RAB_Core_Register("CHAT_MSG_WHISPER","versioncheck",RAB_Chat_VersionCheck);
RAB_Core_Register("CHAT_MSG_WHISPER","incoming",RAB_Chat_IncomingWhisper);