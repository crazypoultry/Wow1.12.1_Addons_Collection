--
-- FollowMe Enhanced 1.2b
-- by Lyriane of EU-Alleria
-- based on FollowMe 1.1.1a by Kingen
--
-- See Readme.txt for documentation
--

-- Local Variables
local following=nil;
local sender=nil;
local FMEnabled=true;
local FMVer="1.2b"


function FollowMe_LocalMsg(txt)
   DEFAULT_CHAT_FRAME:AddMessage(txt);
end

function FollowMe_OnLoad()
   FM_LOAD="FollowMeEnhanced "..FMVer.." loaded";
   SLASH_FOLLOWME1="/fm";
   SLASH_FOLLOWME2="/followme";
   SlashCmdList["FOLLOWME"] = FollowMe_CmdParser;

   FollowMe_LocalMsg(FM_LOAD);
   UIErrorsFrame:AddMessage(FM_LOAD, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
   FollowMe_InitOptions();
   
   this:RegisterEvent("VARIABLES_LOADED");
   this:RegisterEvent("CHAT_MSG_WHISPER");
   this:RegisterEvent("UI_ERROR_MESSAGE");
   this:RegisterEvent("AUTOFOLLOW_BEGIN");
   this:RegisterEvent("AUTOFOLLOW_END");
end

-- /fm command handler
function FollowMe_CmdParser(parm)
   parm=string.lower(parm);
--   FollowMe_LocalMsg(parm);

   -- Code "borrowed" from AutoDruidBuff...
   local x, y, cmd, opr=string.find(parm, "(%w+) (%w+)");
   if ( cmd == nil ) then
      x, y, cmd=string.find(parm, "(%w+)");
      if ( cmd == nil ) then
         FollowMe_LocalMsg("FollowMeEnhanced v"..FMVer);
         FollowMe_LocalMsg(FM_USE_TITLE);
         FollowMe_LocalMsg(FM_USE_STATUS);
         FollowMe_LocalMsg(FM_USE_ENABLE);
         FollowMe_LocalMsg(FM_USE_DISABLE);
         FollowMe_LocalMsg(FM_USE_GUILD);
         FollowMe_LocalMsg(FM_USE_FRIENDS);
         FollowMe_LocalMsg(FM_USE_ANNOUNCE1);
         FollowMe_LocalMsg(FM_USE_ANNOUNCE2);
         FollowMe_LocalMsg(FM_USE_RAID1);
         FollowMe_LocalMsg(FM_USE_RAID2);
         FollowMe_LocalMsg(FM_USE_WHISPER1);
         FollowMe_LocalMsg(FM_USE_WHISPER2);
         FollowMe_LocalMsg(FM_USE_TELL1);
         FollowMe_LocalMsg(FM_USE_TELL2);
         FollowMe_LocalMsg(FM_USE_TELL3);
         FollowMe_LocalMsg(FM_USE_TELL4);
         return;
      end
   end

   --Status
   if ( cmd == FM_COMMAND_STATUS ) then
   
      if ( ( tellgrp == nil ) or ( tellraid == nil ) ) then
         FollowMe_InitOptions();
      end
      
      if ( FMEnabled ) then
         msg=FM_STATUS_ENABLED;
      else
         msg=FM_STATUS_DISABLED;
      end
      FollowMe_LocalMsg("FollowMeEnhanced: "..msg );
      FollowMe_LocalMsg(FM_STATUS_GROUP..tellgrp..".");
      FollowMe_LocalMsg(FM_STATUS_RAID..tellraid..".");
      FollowMe_LocalMsg(FM_STATUS_GUILD..followguild..".");
      FollowMe_LocalMsg(FM_STATUS_FRIENDS..followfriends..".");
      UIErrorsFrame:AddMessage(FM_STATUS_GROUP..tellgrp..".", 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
      UIErrorsFrame:AddMessage(FM_STATUS_RAID..tellraid..".", 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
      UIErrorsFrame:AddMessage(FM_STATUS_GUILD..followguild..".", 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
      UIErrorsFrame:AddMessage(FM_STATUS_FRIENDS..followfriends..".", 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
      UIErrorsFrame:AddMessage("FollowMeEnhanced: "..msg, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
      return;
   end

   --Announce Party
   if ( cmd == FM_COMMAND_ANNOUNCE ) then
      if ( GetNumPartyMembers() > 0 ) then
         msg=FM_ANNOUNCE;
         SendChatMessage(msg, "PARTY", nil, nil);
      end
      return;
   end

   --Announce Raid
   if ( cmd == FM_COMMAND_RAID ) then
      if ( GetNumRaidMembers() > 0 ) then
         msg=FM_ANNOUNCE;
         SendChatMessage(msg, "RAID", nil, nil);
      end
      return;
   end

   --Announce Target
   if ( cmd == FM_COMMAND_TARGET ) then
      msg=FM_ANNOUNCE;
      FollowMe_SendWhisper(UnitName("target"), msg);
      return;
   end

   --Enable
   if ( cmd == FM_COMMAND_ENABLE ) then
      FollowMe_LocalMsg("FollowMeEnhanced "..FM_STATUS_ENABLED);
      UIErrorsFrame:AddMessage("FollowMeEnhanced "..FM_STATUS_ENABLED, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
      FMEnabled=true;
      return;
   end

   --Disable
   if ( cmd == FM_COMMAND_DISABLE ) then
      FollowMe_LocalMsg("FollowMeEnhanced "..FM_STATUS_DISABLED);
      UIErrorsFrame:AddMessage("FollowMeEnhanced "..FM_STATUS_DISABLED, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
      FMEnabled=false;
      return;
   end
   
   --Guild
   if ( cmd == FM_COMMAND_FOLLOWGUILD ) then
      if (opr == FM_GROUP_ON ) then
         followguild=FM_STATUS_ENABLED;
         FollowMe_Options["FollowGuild"] = true;
      elseif ( opr == FM_GROUP_OFF) then
         followguild=FM_STATUS_DISABLED;
         FollowMe_Options["FollowGuild"] = false;
      else
         FollowMe_LocalMsg("/fm "..FM_USE_GUILD);
         return;
      end
      FollowMe_LocalMsg(FM_FOLLOWGUILD..followguild..".");
      UIErrorsFrame:AddMessage(FM_FOLLOWGUILD..followguild..".", 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
   end
   
   --Friends
   if ( cmd == FM_COMMAND_FOLLOWFRIENDS ) then
      if (opr == FM_GROUP_ON ) then
         followfriends=FM_STATUS_ENABLED;
         FollowMe_Options["FollowFriends"] = true;
      elseif ( opr == FM_GROUP_OFF) then
         followfriends=FM_STATUS_DISABLED;
         FollowMe_Options["FollowFriends"] = false;
      else
         FollowMe_LocalMsg("/fm "..FM_USE_FRIENDS);
         return;
      end
      FollowMe_LocalMsg(FM_FOLLOWFRIENDS..followfriends..".");
      UIErrorsFrame:AddMessage(FM_FOLLOWFRIENDS..followfriends..".", 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
   end

   --Tellgroup
   if ( cmd == FM_COMMAND_TELLGROUP ) then
      if (opr == FM_GROUP_ON ) then
         tellgrp=FM_GROUP_ON;
         FollowMe_Options["Group"] = true;
      elseif ( opr == FM_GROUP_OFF) then
         tellgrp=FM_GROUP_OFF;
         FollowMe_Options["Group"] = false;
      else
         FollowMe_LocalMsg("/fm "..FM_USE_TELL1);
         FollowMe_LocalMsg("    "..FM_USE_TELL2);
         return;
      end
      FollowMe_LocalMsg(FM_TELLGROUP..tellgrp);
      UIErrorsFrame:AddMessage(FM_TELLGROUP..tellgrp, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
   end
   
   --Tellraid
   if ( cmd == FM_COMMAND_TELLRAID ) then
      if (opr == FM_GROUP_ON ) then
         tellraid=FM_GROUP_ON;
         FollowMe_Options["Raid"] = true;
      elseif ( opr == FM_GROUP_OFF) then
         tellraid=FM_GROUP_OFF;
         FollowMe_Options["Raid"] = true;
      else
         FollowMe_LocalMsg("/fm "..FM_USE_TELL3);
         FollowMe_LocalMsg("    "..FM_USE_TELL4);
         return;
      end
      FollowMe_LocalMsg(FM_TELLRAID..tellraid);
      UIErrorsFrame:AddMessage(FM_TELLRAID..tellraid, 1.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);
   end
   
end

-- Whisper Function
function FollowMe_SendWhisper(name, message)
   SendChatMessage(message, "WHISPER", nil, name);
end

-- Event handler (receive whisper, UI error, auto-follow begin/end, etc)
function FollowMe_OnEvent(event)

   -- Saved Variables loaded
   if ( event == "VARIABLES_LOADED" ) then
      FollowMe_InitOptions();
   end

   -- Chat Message Received --
   if ( event == "CHAT_MSG_WHISPER" ) then
      if ( arg1 and arg2 ) then
         sender=arg2;
   	     FollowMe_ProcessWhisper(arg1, arg2);
      end
   end

   -- Trap UI Errors
   if ( event == "UI_ERROR_MESSAGE" ) then
      if ( arg1 == ERR_AUTOFOLLOW_TOO_FAR ) then
         FollowMe_SendWhisper(sender, FM_ERR_AUTOFOLLOW_TOO_FAR);
         following=nil;
      else
          if ( arg1 == ERR_INVALID_FOLLOW_TARGET ) then
             FollowMe_SendWhisper(sender, FM_ERR_INVALID_FOLLOW_TARGET);
             following=nil;
          end
      end
      return;
   end

-- AutoFollow Begin --
   if ( event == "AUTOFOLLOW_BEGIN" ) then
      following=arg1;
      if ( following ~= nil ) then
         FollowMe_SendWhisper(following, FM_WHISPER_AUTOFOLLOW_BEGIN);
         if( ( tellgrp == FM_GROUP_ON ) and ( GetNumPartyMembers() > 0 ) ) then
            SendChatMessage(FM_PARTY_AUTOFOLLOW_BEGIN..following, "PARTY", nil, nil);
            return;
         end
         if ( ( tellraid == FM_GROUP_ON ) and ( GetNumRaidMembers() > 0 ) ) then
            SendChatMessage(FM_PARTY_AUTOFOLLOW_BEGIN..following, "RAID", nil, nil);
            return;
         end
      end
   end

-- AutoFollow End --
   if ( event == "AUTOFOLLOW_END" ) then
      if ( following ~= nil ) then
         FollowMe_SendWhisper(following, FM_WHISPER_AUTOFOLLOW_END);
         if ( ( tellgrp == FM_GROUP_ON ) and ( GetNumPartyMembers() > 0 ) ) then
            SendChatMessage(FM_PARTY_AUTOFOLLOW_END..following, "PARTY", nil, nil);
         end
         if ( ( tellraid == FM_GROUP_ON ) and ( GetNumRaidMembers() > 0 ) ) then
            SendChatMessage(FM_PARTY_AUTOFOLLOW_END..following, "RAID", nil, nil);
         end
         following=nil;
      end
   end
end

-- Parse the received whisper.
-- "!follow" turns on auto-follow
-- "!status" returns the addon status (Enabled/Disabled).
function FollowMe_ProcessWhisper(whisper, sender)
   tok=string.sub(whisper,1,1)
   if ( tok ~= "!" ) then
	   return;
   end

   if (string.find(whisper, " ") == nil ) then
      cmd=string.lower(whisper);
   else
      cmd=string.lower(string.sub(whisper, 1, string.find(whisper, " ")));
   end

   if ( cmd == FM_WHISPERCOMMAND_FOLLOW ) then
      if ( FMEnabled == false ) then
         FollowMe_SendWhisper(sender, FM_WHISPER_DISABLED);
         return;
      end
      if ( FollowMe_InMyGroup(sender) ) then
         TargetByName(sender);
         if ( UnitName("target") == sender ) then
            FollowUnit("target");
            TargetLastTarget();
         else
            FollowMe_SendWhisper(sender, FM_ERR_GENERIC);
            TargetLastTarget();
         end
      else
         FollowMe_SendWhisper(sender, FM_ERR_NOGROUP);
         TargetLastTarget();
      end
   end

   if ( cmd == FM_WHISPERCOMMAND_STATUS ) then
      msg="FollowMeEnhanced ("..FMVer.."): ";
      if ( FMEnabled == false ) then
         msg=msg..FM_STATUS_DISABLED;
      else
         msg=msg..FM_STATUS_ENABLED;
         if ( following ~= nil ) then
            msg=msg..FM_WHISPER_STATUS_FOLLOW..following;
         end
      end
      FollowMe_SendWhisper(sender, msg);
   end
end


-- This function is based on WhisperCast:
-- Modification for raid and cosmetics inspired by "FollowTheLeader"
function FollowMe_InMyGroup(name)
   if ( name == UnitName("player" ) ) then
      return true;
   else

      local numParty = GetNumPartyMembers();
      if ( numParty > 0 ) then
		for i=1, numParty do
            if ( name == UnitName("party"..i) ) then
               return true;
            end
        end
      end
      
      local numRaid = GetNumRaidMembers();
      if ( numRaid > 0 ) then
		for i=1, numRaid do
            if ( name == UnitName("raid"..i) ) then
               return true;
            end
         end
	  end
	  
      local numFriends = GetNumFriends();
      if ( ( numFriends > 0 ) and ( FollowMe_Options["FollowFriends"] ) ) then
		for i=1, numFriends do
            if ( name == GetFriendInfo(i) ) then
               return true;
            end
         end
	  end

      if ( IsInGuild() ) then
		for i=1, GetNumGuildMembers() do
            if ( ( name == GetGuildRosterInfo(i) )  and ( FollowMe_Options["FollowGuild"] ) ) then
               return true;
            end
         end
	  end

	  return false;
   end
end

-- Init Options
function FollowMe_InitOptions()

   if ( FollowMe_Options == nil ) then
      FollowMe_Options = {
         ["Raid"] = false,
         ["Group"] = false,
         ["FollowFriends"] = false,
         ["FollowGuild"] = false
      }
   end
   
   if ( FollowMe_Options["Raid"] ) then
      tellraid=FM_GROUP_ON;
   else
      tellraid=FM_GROUP_OFF;
   end
   
   if ( FollowMe_Options["Group"] ) then
      tellgrp=FM_GROUP_ON;
   else
      tellgrp=FM_GROUP_OFF;
   end
   
   if ( FollowMe_Options["FollowGuild"] ) then
      followguild=FM_STATUS_ENABLED;
   else
      followguild=FM_STATUS_DISABLED;
   end

   if ( FollowMe_Options["FollowFriends"] ) then
      followfriends=FM_STATUS_ENABLED;
   else
      followfriends=FM_STATUS_DISABLED;
   end

end
