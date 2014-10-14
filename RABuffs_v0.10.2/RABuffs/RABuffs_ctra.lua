-- RABuffs_ctra.lua
--  Handles interaction between RABuffs and CTRA, including minimalistic handling of CTRA messages.
-- Version 0.10.1

RAB_CTRA_NativeHandlerAddon = "CT_RaidAssist";
RAB_CTRA_ResponsibleHandler = "RAB";

RAB_CTRA_BuffsMaskPart = "RN (%d+) (%d+) (%d+)";

function RAB_CTRA_CheckLoad()
 if (IsAddOnLoaded(RAB_CTRA_NativeHandlerAddon)) then
  RAB_CTRA_ResponsibleHandler = "CTRA";
  return "remove";
 end
end
function RAB_CTRA_AddOnEvent()
 if (arg1 == "CTRA" and string.find(arg2,RAB_CTRA_BuffsMaskPart) ~= nil and arg3 == "RAID") then
  local inGroup, unitID = RAB_RaidMemberInfo(arg4);
  if (not inGroup) then
   return;
  end
  local dur, ctrakey, subtype;
  local nkey = GetCVar("realmName") .. "." .. arg4;
  if ((RAB_Versions[nkey] == nil or RAB_Versions[nkey].l < (time()-259200))) then
   for dur, ctrakey, subtype in string.gfind(arg2,RAB_CTRA_BuffsMaskPart) do
    ctrakey = RAB_CTRA_FindBuffKeyFromID(ctrakey);
    if (ctrakey ~= nil and RAB_IsBuffUp(unitID,ctrakey)) then
     RAB_BuffTimers[arg4 .. "." .. ctrakey] = GetTime() + tonumber(dur);
    end
   end
  end
 end
end
function RAB_CTRA_FindBuffKeyFromID(id)
 local key, val; id = tonumber(id);
 for key, val in RAB_Buffs do
  if (val.ctraid ~= nil and val.ctraid == id) then
   return key;
  end
 end
 return nil;
end

function RAB_CTRA_IsMT(name) -- Determines if unit is an MT.
 local key, val;
 if (RAB_CTRA_ResponsibleHandler == "CTRA") then
  for key, val in CT_RA_MainTanks do
   if (key == name) then
    return true;
   end
  end
 elseif (RAB_CTRA_ResponsibleHandler == "RAB") then
  -- We're doomed.
 end
 return false;
end
function RAB_CTRA_IsBeingRessed(name)
 local key, val;
 if (RAB_CTRA_ResponsibleHandler == "CTRA") then
  for key, val in CT_RA_Ressers do
   if (val == name) then
    return true;
   end
  end
  for key,val in CT_RA_Stats do
   if (key == name and val["Ressed"] == 1) then
    return true;
   end
  end
 elseif (RAB_CTRA_ResponsibleHandler == "RAB") then
  -- We're doomed.
 end
 for key, val in RAB_PendingRes do
  if (val > GetTime() and key == name) then
   return true;
  end
 end

 return false;
end
function RAB_CTRA_GetVersion(name) 
 if (RAB_CTRA_ResponsibleHandler == "CTRA") then
  if (CT_RA_Stats ~= nil and CT_RA_Stats[name] ~= nil and CT_RA_Stats[name]["Version"] ~= nil) then
   return CT_RA_Stats[name]["Version"];
  end
 end
 return false;
end
function RAB_CTRA_IsAFK(name) 
 if (RAB_CTRA_ResponsibleHandler == "CTRA") then
  if (CT_RA_Stats[name] ~= nil and CT_RA_Stats[name]["AFK"] ~= nil) then
   return true;
  end
 end
 return false;
end

RAB_Core_Register("ADDON_LOADED","ctraLoad",RAB_CTRA_CheckLoad);
RAB_Core_Register("CHAT_MSG_CHANNEL","ctraFilter",RAB_CTRA_ChannelEvent);
RAB_Core_Register("CHAT_MSG_ADDON","ctraBuffTimers",RAB_CTRA_AddOnEvent);