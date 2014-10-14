-- $Id: autoInvite.lua 138 2006-11-14 14:31:16Z idefix $

-- Definition of autoInvite.control object
--
-- array autoInvite.control.member[]
--  the keys of this array are the names of the members
--  runtime information about the members in AutoInviteCompleteList
--      string status
--          "unknown" = default status, nothing done to the player yet
--          "invited" = user has been invited, but did not react yet
--          "offline" = user has been offline during last invite
--          "declined" = user declined our invite
--          "ignored" = user is ignoring us (d'oh! How dare he?)
--          "grouped" = user is already in a group
--          "joined" = user has joined our raid/group
--      integer lastChecked
--          GetTime()*1000 when AI has last interacted with the player - aka time of last information
--
-- boolean autoInvite.control.isLoaded
--  true = AI is fully initialized
--  false = guess what
--
-- boolean autoInvite.control.changeToRaid
--  true = convert group to raid as soon as possible (set by pressing the Start-Invite button)
--  false = don't do
--
-- integer autoInvite.control.lastUpdate
--  contains the last GetTime() * 1000 that autoInvite_OnUpdate() ran
--
-- boolean autoInvite.control.doInvites
--  true = _OnUpdate() should do inviting (set by pressing the Start-Invite button)
--  false = go figure...

autoInvite = {};

-- Initialization
if(AutoInviteConfig == nil) then
   AutoInviteConfig={};
end
if(AutoInviteSavedList == nil) then
   AutoInviteSavedList={};
end

autoInvite.groupCount = { 
   DRUID    = 0,
   HUNTER   = 0,
   MAGE     = 0,
   PALADIN  = 0,
   PRIEST   = 0,
   ROGUE    = 0,
   WARRIOR  = 0,
   WARLOCK  = 0,
   SHAMAN   = 0;
};

AutoInviteDebugOn=false;
autoInvite.revision="$Revision: 138 $";
autoInvite.version=autoInvite.revision;
-- remove the $ sign
autoInvite.version=string.gsub(autoInvite.version,"(%$)","");
-- remove upper letters
autoInvite.version=string.gsub(autoInvite.version,"(%u+)","");
-- remove lower letters
autoInvite.version=string.gsub(autoInvite.version,"(%l+)","");
-- remove spaces
autoInvite.version=string.gsub(autoInvite.version,"( )","");
-- remove :
autoInvite.version=string.gsub(autoInvite.version,"(:)","");

autoInvite.maxlevel=60;
autoInvite.checkTime=60000;
autoInvite.inviteDelay=1500;

autoInvite.yellowColor = { r=1, g=1, b=0 };
autoInvite.greyColor = { r=0.5, g=0.5, b=0.5 };
autoInvite.greenColor = { r=0.1, g=1, b=0.1 };
autoInvite.redColor = { r=1, g=0.1, b=0.1 };
autoInvite.blueColor = { r=0.1, g=0.1, b=1 };

autoInvite.groupCountLimit = { 0, 0, 0, 0, 0, 0, 0, 0};

autoInvite.checkOnlineState=false;
autoInvite.checkOnlineLastId=1;
autoInvite.checkOnlineMaxId=1;

-- variable for moving players in groups
autoInvite.movePlayersActive=false;
autoInvite.needMovePlayers=0;

StaticPopupDialogs["AUTOINVITE_ADDMEMBER"] = {
   text = TEXT(AUTO_INVITE_ADDMEMBER_LABEL),
   button1 = TEXT(ACCEPT),
   button2 = TEXT(CANCEL),
   hasEditBox=1,
   maxLetters=12,
   OnAccept = function()
		 local editBox=getglobal(this:GetParent():GetName().."EditBox");
		 autoInvite:completeAdd(editBox:GetText());
	      end,
   OnShow = function()
	       getglobal(this:GetName().."EditBox"):SetFocus();
	    end,
   OnHide = function()
	       if(ChatFrameEditBox:IsVisible()) then
		  ChatFrameEditBox:SetFocus();
	       end
	       getglobal(this:GetName().."EditBox"):SetText("");
	    end,
   EditBoxOnEnterPressed = function()
			      local editBox=getglobal(this:GetParent():GetName().."EditBox");
			      autoInvite:completeAdd(editBox:GetText());
			      this:GetParent():Hide();
			   end,
   EditBoxOnEscapePressed = function()
			      this:GetParent():Hide();
			   end,
   timeout=0,
   exclusive=1,
   hideOnEscape=1
};

StaticPopupDialogs["AUTOINVITE_ENTERDESCRIPTION"] = {
   text = TEXT(AUTO_INVITE_SAVEDESCRPTION_LABEL),
   button1 = TEXT(ACCEPT),
   button2 = TEXT(CANCEL),
   hasEditBox=1,
   maxLetters=50,
   OnAccept = function()
		 local editBox=getglobal(this:GetParent():GetName().."EditBox");
		 autoInvite:loadSaveFrameSave(editBox:GetText());
	      end,
   OnShow = function()
	       getglobal(this:GetName().."EditBox"):SetFocus();
	    end,
   OnHide = function()
	       if(ChatFrameEditBox:IsVisible()) then
		  ChatFrameEditBox:SetFocus();
	       end
	       getglobal(this:GetName().."EditBox"):SetText("");
	    end,
   EditBoxOnEnterPressed = function()
			      local editBox=getglobal(this:GetParent():GetName().."EditBox");
			      autoInvite:loadSaveFrameSave(editBox:GetText());
			      this:GetParent():Hide();
			   end,
   timeout=0,
   exclusive=1,
   hideOnEscape=1
};

function autoInvite:init()
   -- if we don't have a config, initialize the arrays
   if(AutoInviteCompleteList == nil) then
      AutoInviteCompleteList= { };
   end
   if(AutoInviteConfig == nil) then
      AutoInviteConfig={};
   end
   if(AutoInviteSavedList == nil) then
      AutoInviteSavedList={};
   end

   self:resetControlObject();
   -- we always start deactivated
   AutoInviteConfig['modActive']=0;
   -- Register for our events
   autoInvite:registerEvents();
end

function autoInvite:resetControlObject()
   autoInvite:debugMsg("autoInvite:resetControlObject called");
   -- Initialize the controlobject
   autoInvite.control = {
      isLoaded = true,
      changeToRaid = false,
      doInvites = false,
      lastUpdate = GetTime() * 1000,
      
      member = {}
   }
   
   -- map the loaded members into the control object with status unknown and never checked
   for i in AutoInviteCompleteList do
      autoInvite.control.member[AutoInviteCompleteList[i]['name']] = { status = "unknown", online = false, inGuild=false, lastChecked = 0, errorMessage="" };
   end
end

function autoInvite:registerEvents()
   this:RegisterEvent("CHAT_MSG_SYSTEM");
   this:RegisterEvent("PARTY_MEMBERS_CHANGED");
   this:RegisterEvent("RAID_ROSTER_UPDATE");
end

function autoInvite:unregisterEvents()
   this:UnregisterEvent("CHAT_MSG_SYSTEM");
   this:UnregisterEvent("PARTY_MEMBERS_CHANGED");
   this:UnregisterEvent("RAID_ROSTER_UPDATE");
end

function autoInvite:onLoad()
   autoInvite:debugMsg("In function autoInvite:onLoad()");

   this:RegisterEvent("VARIABLES_LOADED");
   this:RegisterForDrag("LeftButton");

   -- those are needed so we can deactivate events during zoning, which helps lowering reloadtime a lot
   this:RegisterEvent("PLAYER_ENTERING_WORLD");
   this:RegisterEvent("PLAYER_LEAVING_WORLD");
   --   GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
   --   GameTooltip:ClearLines();
end

-- Update handler -- EXPERIMENTAL!!!
-- Manages the invites over time
function autoInvite:onUpdate()
--   autoInviteDebugMsg("OnUpdate Ping!: "..GetTime());

   -- bail out early if we are not active at all 
   if (AutoInviteConfig['modActive'] == 0) then
      return;
   end

   local curTime = GetTime() * 1000;
   -- if less then 0,5 secs passed since the last update, we just bail out - don't overstress the system
   -- if the mod ain't active right now - nothing to do for us!
   if ( curTime - autoInvite.control.lastUpdate < autoInvite.inviteDelay ) then
      return;
   end;

   -- Last update is more the 0,5 secs ago, set current time as last update time
   autoInvite.control.lastUpdate = curTime;

--   autoInviteDebugMsg("OnUpdate Ping!: "..GetTime());

   -- change group to raid if a second member is present
   if (autoInvite.control.changeToRaid == true and GetNumPartyMembers() > 0) then
      autoInvite:debugMsg("OnUpdate: autoInvite.control.changeToRaid was true and Party is available - converting");
      autoInvite.control.changeToRaid = false;
      ConvertToRaid();
   end

   -- iterate through the control object
   -- - manage the timeouts
   -- - do an invite
   -- local helper boolean to remember if we already did our invite for this pass
   local notYetInvited = true;
   for i=1,table.getn(AutoInviteCompleteList) do
      name=AutoInviteCompleteList[i]['name'];
      if (name and notYetInvited and autoInvite.control.doInvites and AutoInviteCompleteList[i]['inGroup'] and autoInvite.control.member[name]['status'] == "unknown") then
         notYetInvited = false;
	 autoInvite:debugMsg("Invite: "..name);
         InviteByName(name);
         autoInvite.control.member[name]['lastChecked'] = curTime;
         autoInvite.control.member[name]['status'] = "invited";
      end;
      if (autoInvite.control.member[name]['status'] ~= "joined"
            and autoInvite.control.member[name]['status'] ~= "unknown"
            and curTime - autoInvite.control.member[name]['lastChecked'] > autoInvite.checkTime) then
	 -- disabled because getting error here
--         autoInvite:debugMsg("In OnUpdate: status timeout after 60 secs, resetting entry "..AutoInviteCompleteList[i]['name']);
         autoInvite.control.member[name]['lastChecked'] = curTime;
         autoInvite.control.member[name]['status'] = "unknown";
         -- refresh the frame
         autoInvite:buildGroups()
      end;
   end

end

function autoInvite:getMemberByName(memberName)
    for i=1,table.getn(AutoInviteCompleteList) do
        if AutoInviteCompleteList[i]['name'] == memberName then
            return AutoInviteCompleteList[i]
        end
    end
    autoInvite:chatMsg(format(AUTO_INVITE_AUTOINVITEGETMEMBERBYNAME_ERROR,memberName));
end

-- Event handler
function autoInvite:onEvent()
   --   if(event=="PLAYER_ENTERING_WORLD") then
   --      autoInviteInit();
   autoInvite:debugMsg("In function autoInvite:onEvent()");

   if (event == "VARIABLES_LOADED") then
      autoInvite:chatMsg(format(AUTO_INVITE_MOD_LOADED_SUCCESSFULLY,autoInvite.version));
      autoInvite:debugMsg("Set shortcuts");
      SlashCmdList["AUTOINVITE"]= function(msg) self:command(msg) end;
      SLASH_AUTOINVITE1="/ai";
      SLASH_AUTOINVITE2="/autoinvite";
      autoInvite:init();
      --      autoInvite:showConfigFrame();
      autoInvite:debugMsg("Update saved values");
      autoInvite:completeList_Update();
      autoInvite:buildGroups();
      autoInvite:updateGroupCount();
      autoInvite:ifWisperOnLoad();
      autoInvite:sortCompleteListOnLoad();
      autoInvite:lockCompleteListOnLoad();
      autoInvite:updateMainHeader();
      
   elseif (event == "PARTY_MEMBERS_CHANGED") then
      autoInvite:debugMsg("Event PARTY_MEMBERS_CHANGED triggered");
      if(AutoInviteConfig['modActive']==1) then
	 if(autoInvite.movePlayersActive) then
	    autoInvite:debugMsg("Sort players from event");
	    autoInvite:doMovePlayers();
	 end
         autoInvite:memberJoinedParty();
      end

   elseif (event == "RAID_ROSTER_UPDATE") then
      autoInvite:debugMsg("Event RAID_ROSTER_UPDATE triggered");
      if(AutoInviteConfig['modActive']==1) then
	 if(autoInvite.movePlayersActive) then
	    autoInvite:debugMsg("Sort players from event");
	    autoInvite:doMovePlayers();
	 end
         autoInvite:memberJoinedRaid();
      end

   elseif (event == "CHAT_MSG_CHANNEL_JOIN") then
      --autoInvite:chatMsg("Channel joined was called, arg1: "..arg1.." arg2: "..arg2.." arg3: "..arg3.." arg4: "..arg4.." arg5: "..arg5);

   elseif (event == "CHAT_MSG_SYSTEM") then
      autoInvite:debugMsg("Event CHAT_MSG_SYSTEM triggered");
      if(AutoInviteConfig['modActive']==1) then
         if(string.find(arg1,AUTO_INVITE_DECLINES_YOUR_INVITATION)) then
            autoInvite:debugMsg("In OnEvent: AUTO_INVITE_DECLINES_YOUR_INVITATION matched!");
	    local _,_,playerName = string.find(arg1,AUTO_INVITE_DECLINES_YOUR_INVITATION_FIND);
	    --	         autoInvite:chatMsg("dummy1: "..dummy1);
	    --	         autoInvite:chatMsg("dummy2: "..dummy2);
	    --	         autoInvite:chatMsg("Player: "..playerName.." declined invitiation");
	    local id=autoInvite:getId(AutoInviteCompleteList,playerName);
	    autoInvite:chatMsg(format(AUTO_INVITE_ERROR_FOUND_NO_ID,playerName));
	    if(id==0) then
	       -- player is not in complete list, add him
	       autoInvite:completeAdd(playerName);
	       id=autoInvite:getId(AutoInviteCompleteList,playerName);
	       AutoInviteCompleteList[id]["inGroup"]=true;
	    end
	    autoInvite.control.member[playerName]["status"]="declined";
	    autoInvite:debugMsg("User: "..playerName.." declined invitation");
	    autoInvite:buildGroups();
	 elseif (string.find(arg1,AUTO_INVITE_IGNORES_YOUR_INVITATION)) then
	    autoInvite:debugMsg("In OnEvent: AUTO_INVITE_IGNORES_YOUR_INVITATION matched!");
	    local dummy,dummy,playerName=string.find(arg1,AUTO_INVITE_IGNORES_YOUR_INVITATION_FIND);
	    local id=autoInvite:getId(AutoInviteCompleteList,playerName);
	    if(id==0) then
	       -- player is not in complete list, add him
	       autoInvite:completeAdd(playerName);
	       id=autoInvite:getId(AutoInviteCompleteList,playerName);
	       AutoInviteCompleteList[id]["inGroup"]=true;
	    end
	    autoInvite.control.member[playerName]["status"]="ignored";
	    autoInvite:chatMsg(format(AUTO_INVITE_PLAYER_IGNORES_YOU,playerName));
	    autoInvite:buildGroups();
	 elseif (string.find(arg1,AUTO_INVITE_IS_ALREADY_IN_GROUP)) then
	    autoInvite:debugMsg("In OnEvent: AUTO_INVITE_IS_ALREADY_IN_GROUP matched!");
	    local dummy,dummy,playerName=string.find(arg1,AUTO_INVITE_IS_ALREADY_IN_GROUP_FIND);
	    local id=autoInvite:getId(AutoInviteCompleteList,playerName);
	    if(id==0) then
	       -- player is not in complete list, add him
	       autoInvite:completeAdd(playerName);
               id=autoInvite:getId(AutoInviteCompleteList,playerName);
               AutoInviteCompleteList[id]["inGroup"]=true;
	    end
	    -- check if player is in our group
	    if(autoInvite:playerIsInGroup(playerName) or autoInvitePlayerIsInRaid(playerName)) then
	       autoInvite.control.member[playerName]["status"]="joined";
	    else
	       autoInvite.control.member[playerName]["status"]="grouped";
	       autoInvite:chatMsg(format(AUTO_INVITE_PLAYER_IS_ALREADY_IN_GROUP,playerName));
	       if(AutoInviteConfig['ifWisper']==1) then
		  SendChatMessage(AUTO_INVITE_SEND_MESSAGE_ALREADY_IN_GROUP, "WHISPER", this.language, playerName);
	       end
	    end
            autoInvite:buildGroups();
	 elseif (string.find(arg1,AUTO_INVITE_INVITED)) then
	    autoInvite:debugMsg("In OnEvent: AUTO_INVITE_INVITE_INVITED matched!");
            local dummy,dummy,playerName=string.find(arg1,AUTO_INVITE_INVITED_FIND);
	    local id=autoInvite:getId(AutoInviteCompleteList,playerName);
	    if(id==0) then
	       -- player is not in complete list, add him
	       autoInvite:completeAdd(playerName);
	       id=autoInvite:getId(AutoInviteCompleteList,playerName);
	       if(id<=0) then
		  autoInvite:chatMsg(format(AUTO_INVITE_ERROR_ADDING_PLAYER_CONTACT_AUTHOR,playerName)); -- and send the file
                  return;
	       end
	       AutoInviteCompleteList[id]["inGroup"]=true;
	    end
	    autoInvite.control.member[playerName]["status"]="invited";
	    autoInvite:debugMsg("User: "..playerName.." invited to group");
	    autoInvite:buildGroups();
	 elseif (string.find(arg1,AUTO_INVITE_GROUP_LEAVE)) then
	    autoInvite:debugMsg("In OnEvent: AUTO_INVITE_GROUP_LEAVE matched!");
	    local dummy,dummy,playerName=string.find(arg1,AUTO_INVITE_GROUP_LEAVE_FIND);
	    local id=autoInvite:getId(AutoInviteCompleteList,playerName);
	    if(id==0) then
	       -- player is not in complete list, add him
	       autoInvite:completeAdd(playerName);
	       id=autoInvite:getId(AutoInviteCompleteList,playerName);
	       AutoInviteCompleteList[id]["inGroup"]=true;
	    end
	    autoInvite.control.member[playerName]["status"]="unknown";
	    autoInvite:chatMsg(format(AUTO_INVITE_PLAYER_LEFT_THE_GROUP,playerName));
	    autoInvite:buildGroups();
	 elseif (string.find(arg1,AUTO_INVITE_RAID_LEAVE)) then
	   autoInvite:debugMsg("In OnEvent: AUTO_INVITE_RAID_LEAVE matched!");
            local dummy,dummy,playerName=string.find(arg1,AUTO_INVITE_RAID_LEAVE_FIND);
            local id=autoInvite:getId(AutoInviteCompleteList,playerName);
	    if(id==0) then
	       -- player is not in complete list, add him
	       autoInvite:completeAdd(playerName);
	       id=autoInvite:getId(AutoInviteCompleteList,playerName);
	       AutoInviteCompleteList[id]["inGroup"]=true;
	    end
	    autoInvite.control.member[playerName]["status"]="unknown";
	    autoInvite:chatMsg(format(AUTO_INVITE_PLAYER_LEFT_THE_RAID,playerName));
	    autoInvite:buildGroups();
	 elseif (string.find(arg1,AUTO_INVITE_IS_OFFLINE)) then
	    autoInvite:debugMsg("In OnEvent: AUTO_INVITE_IS_OFFLINE matched!");
	    -- do something when he is offline
	    local _,_,playerName=string.find(arg1,AUTO_INVITE_IS_OFFLINE_FIND);
	    autoInvite:debugMsg("Player is: "..playerName);
	    local id=autoInvite:getId(AutoInviteCompleteList,playerName);
	    autoInvite.control.member[playerName]["status"]="offline";
	 elseif (string.find(arg1,AUTO_INVITE_GROUP_DISBANDED) or string.find(arg1,AUTO_INVITE_GROUP_DISBANDED2) or string.find(arg1,AUTO_INVITE_RAID_DISBANDED)) then
        -- reset the status of all known members - better safe then sorry
	    for name in autoInvite.control.member do
	       autoInvite.control.member[name]["status"]="unknown";
	    end
	    autoInvite:debugMsg("Group or Raid was dispanded");
	    --	    autoInviteBuildGroups();
	 elseif (event == "PLAYER_LEAVING_WORLD") then
	    autoInvite:unregisterEvents();
	 elseif (event == "PLAYER_ENTERING_WORLD") then
	    autoInvite:registerEvents();
	 end
	 -- update the complete list
	 autoInvite:buildGroups();
	 autoInvite:completeList_Update();
	 autoInvite:updateGroupCount();
      end
   end
end

function autoInvite:dropDownCLASS_OnLoad()
   autoInvite:debugMsg(this:GetName().." dropDownClass_OnLoad "..this:GetID());
   UIDropDownMenu_Initialize(this, autoInvite.dropDownCLASS_Init, "MENU");
end

function autoInvite:dropDownCLASS_Init()
   autoInvite:debugMsg(this:GetName().." dropDownClass_Init "..this:GetID());
   local id=this:GetID();
   autoInvite:debugMsg("Set Callback for ID: " .. id.." Name "..this:GetName());
   info = {};
   info.text = AUTO_INVITE_TO_GROUP;
   info.isTitle = 1;
   info.justifyH = "CENTER";
   info.notCheckable=1;
   UIDropDownMenu_AddButton(info);

   info = {};
   info.text = "-";
   info.notCheckable=1;
   if(this:GetID()==0) then
      info.value = getglobal(this:GetName().."TextLabelName"):GetText();
   end
   info.func = autoInvite.dropDownCLASS_OnClick;
   UIDropDownMenu_AddButton(info);

   local i=1;
   while(i<=8) do
      info = { };
      info.text = i;
      info.notCheckable = 1;
      --      autoInvite:chatMsg("BASE: "..this:GetName().." ID: "..this:GetID());
      if(this:GetID()==0) then
         info.value = getglobal(this:GetName().."TextLabelName"):GetText();
      end
      info.func = autoInvite.dropDownCLASS_OnClick;
      if(autoInvite.groupCountLimit[i]>=5) then
         info.text="Full";
         info.isTitle=1;
      end
      UIDropDownMenu_AddButton(info);
      i=i+1;
   end
end

-- Count who much player are in each group
function autoInvite:updateGroupCount()
   autoInvite:debugMsg("in function autoInvite:updateGroupCount()");
   local max=table.getn(AutoInviteCompleteList);
   local i=1;
   autoInvite:debugMsg("Count group members");
   autoInvite.groupCountLimit[1] = 0;
   autoInvite.groupCountLimit[2] = 0;
   autoInvite.groupCountLimit[3] = 0;
   autoInvite.groupCountLimit[4] = 0;
   autoInvite.groupCountLimit[5] = 0;
   autoInvite.groupCountLimit[6] = 0;
   autoInvite.groupCountLimit[7] = 0;
   autoInvite.groupCountLimit[8] = 0;
   while i<= max do
      if(AutoInviteCompleteList[i]["group"]~="-") then
--	 autoInvite:debugMsg("List: "..AutoInviteCompleteList[i]["group"]);
         autoInvite.groupCountLimit[AutoInviteCompleteList[i]["group"]]=autoInvite.groupCountLimit[AutoInviteCompleteList[i]["group"]]+1;
      end
      i=i+1;
   end
end

function autoInvite:dropDownCLASS_OnClick()
   autoInvite:debugMsg("Clicked "..this:GetName().." id: "..this:GetID().." user "..this.value);
   local id=autoInvite:getId(AutoInviteCompleteList,this.value);
   if(this:GetID()==2) then
      AutoInviteCompleteList[id]["group"]="-";
   else
      AutoInviteCompleteList[id]["group"]=this:GetID()-2;
   end
   autoInvite:updateGroupCount();
   autoInvite:buildGroups();
end

function autoInvite:onDragStart()
   autoInviteMainConfigFrame:StartMoving();
end

function autoInvite:onDragStop()
   autoInviteMainConfigFrame:StopMovingOrSizing();
end

-- displayes the given message on the screen
function autoInvite:chatMsg(msg)
   if( DEFAULT_CHAT_FRAME ) then
      DEFAULT_CHAT_FRAME:AddMessage(string.format("|cff00ff00AI: |cffff0000 %s",msg));
   end
   --   ChatFrame1:AddMessage(msg,1.0,1.0,0.0);
   --   UIErrorsFrame:AddMessage(msg, 0.0, 0.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
   --    GameTooltip:AddLine(msg, 0, 0, 1);
   --    GameTooltip:Show();
--   UIErrorsFrame:AddMessage(string.format("|cff00ff00AI: |cffff0000 %s",msg), 0,0,0,0,UIERRORS_HOLD_TIME);
end

-- displayes messages if debug==true
function autoInvite:debugMsg(msg)
   if(AutoInviteDebugOn) then
      autoInvite:chatMsg(msg);
   end
end

-- toggle the main window
function autoInvite:showConfigFrame()
   if(autoInviteMainConfigFrame:IsVisible()) then
      autoInviteMainConfigFrame:Hide();
   else
      autoInviteMainConfigFrame:Show();
      autoInvite:countMembersInGroup();
   end
end   

-- the function is called if the user enter /ai <command>
function autoInvite:command(msg)
   autoInvite:debugMsg("in autoInvite:command Command: "..msg);
   if (msg=="show") then 
      autoInvite:showConfigFrame();
   elseif (msg=="add") then 
      autoInvite:debugMsg("Playername to add: "..UnitName("target")); 
      if(UnitName("target")) then
         autoInvite:completeAdd(UnitName("target"));
         autoInvite:completeList_Update();
      else
         autoInvite:chatMsg(AUTO_INVITE_NO_TARGET_SELECTED_SKIPPING);
      end
   elseif (msg=="debug") then
      autoInvite:chatMsg(AUTO_INVITE_DEBUG_CALLED);
      autoInvite:dumpVariables();
   elseif (msg=="dump") then
      autoInvite:chatMsg(AUTO_INVITE_DUMP_CALLED);
      autoInvite:saveDebug();
   elseif (msg=="cleardump") then
      autoInvite:chatMsg(AUTO_INVITE_CLEAR_DUMP_CALLED);
      autoInvite:clearDebug();
   elseif (msg=="guild") then
      autoInvite:chatMsg(AUTO_INVITE_IMPORT_GUILD_MEMBERS);
      autoInvite:importGuildMembers();
   elseif (msg=="verbose") then
      if(AutoInviteDebugOn) then
	 AutoInviteDebugOn=false;
	 autoInvite:chatMsg(AUTO_INVITE_VERBOSE_MOD_DEACTIVE);
      else
	 AutoInviteDebugOn=true;
	 autoInvite:chatMsg(AUTO_INVITE_VERBOSE_MOD_ACTIVE);
      end
   elseif (msg=="reset") then
      autoInvite:reset();
   else
      autoInvite:chatMsg(AUTO_INVITE_COMMAND_HELP1);
      autoInvite:chatMsg(AUTO_INVITE_COMMAND_HELP2);
      autoInvite:chatMsg(AUTO_INVITE_COMMAND_HELP3);
      autoInvite:chatMsg(AUTO_INVITE_COMMAND_HELP4);
      autoInvite:chatMsg(AUTO_INVITE_COMMAND_HELP5);
      autoInvite:chatMsg(AUTO_INVITE_COMMAND_HELP6);
      autoInvite:chatMsg(AUTO_INVITE_COMMAND_HELP7);
      autoInvite:chatMsg(AUTO_INVITE_COMMAND_HELP8);
   end
end

-- Add the playerName to the completelist
function autoInvite:completeAdd(playerName)
   autoInvite:debugMsg("In function autoInvite:completeAdd("..playerName..")");
   --   autoInvite:chatMsg("Adding the target to the complete List");
   -- If playername is defined, add playername to list else add target to list
   if(playerName and playerName~="") then
      autoInvite:debugMsg("Add Player: -"..playerName.."-");
      if(playerName == AUTO_INVITE_UNKNOWN_ENTITY) then
	 autoInvite:chatMsg(AUTO_INVITE_GOT_UNKOWN_SKIPPING);
         return;
      end
      --      autoInvite:chatMsg("Unit exists");
      if(UnitIsPlayer("target") and string.lower(UnitName("target"))==string.lower(playerName)) then
	 --	 autoInvite:chatMsg("Unit is player");
         local name=UnitName("target");
         for _, pname in AutoInviteCompleteList do
            if(name == pname["name"]) then
               autoInvite:debugMsg("Selected Player "..name.." is in list, skipping");
               return;
            end
         end
         local class,eClass=UnitClass("target");
         local level=UnitLevel("target");
         autoInvite:chatMsg(format(AUTO_INVITE_ADD_PLAYER_XXX_TO_LIST,name,level,class,eClass));
         table.insert(AutoInviteCompleteList,{ ["group"]='-', ["name"]=name, ["eClass"]=eClass, ["inGroup"]=false });
         autoInvite.control.member[name] = { lastChecked = 0, status = "unknown", online = false, inGuild=false, errorMessage="" };
      else
	 -- Not possible because blizzard not allows to read this in big distance
	 --	 if(UnitIsPlayer("target")) then
         for _, pname in AutoInviteCompleteList do
            if(string.lower(playerName) == string.lower(pname["name"])) then
               autoInvite:chatMsg(format(AUTO_INVITE_PLAYER_ALREADY_IN_LIST,playerName));
               return;
            end
         end
         autoInvite:chatMsg(format(AUTO_INVITE_ADD_PLAYER_NOT_IN_TARGET,playerName));
         if(playerName == AUTO_INVITE_UNKNOWN_ENTITY) then
            autoInvite:chatMsg(AUTO_INVITE_GOT_UNKOWN_SKIPPING);
            return;
         end
         table.insert(AutoInviteCompleteList,{ ["group"]='-', ["name"]=playerName, ["level"]=0, ["eClass"]="DRUID", ["inGroup"]=false });
         autoInvite.control.member[playerName] = { lastChecked = 0, status = "unknown", online = false, inGuild=false, errorMessage="" };
	 --	 end
      end
   end
   --   autoInvite:chatMsg("Number of items in list: "..table.getn(AutoInviteCompleteList));
   autoInvite:sortCompleteList();
   autoInvite:completeList_Update();
end

function autoInvite:sortCompleteList()
   autoInvite:debugMsg("In function autoInvite:sortComepleteList");
   autoInvite:debugMsg("check if sorting is enabled");
   if(AutoInviteConfig['sortComplete']==1) then
      autoInvite:debugMsg("Sort complete list");
      table.sort(AutoInviteCompleteList,
		 function (v1, v2)
		    return v1.name < v2.name
		 end
	      );
   end
end

-- The Event which is called if in the list the user clicks with the mouse
function autoInvite:completeListClick(button,text)
   autoInvite:debugMsg("In function autoInvite:completeListeClick");
   local btnName=getglobal(this:GetName().."TextLabelName");
   local btnLevel=getglobal(this:GetName().."TextLabelLevel");
   local btnClass=getglobal(this:GetName().."TextLabelClass");
   local user=btnName:GetText();
   local idToRemove;
   local oldCount=table.getn(AutoInviteCompleteList);

   autoInvite:sortCompleteList();
   if(button == "LeftButton") then
      local j,k=string.find(this:GetName(),"CompleteList");
      if(j) then
         -- Click was in Complete List
         if(user) then
	    --	    autoInvite:chatMsg("Left Click: "..user);
            autoInvite:addToGroup(user);
         end
      else
         if(user) then
            autoInvite:removeFromGroup(user);
            -- close all dropdown menus
            CloseDropDownMenus(1, nil, autoInviteDropDownDRUID);
            CloseDropDownMenus(1, nil, autoInviteDropDownHUNTER);
            CloseDropDownMenus(1, nil, autoInviteDropDownMAGE);
            CloseDropDownMenus(1, nil, autoInviteDropDownPALADIN);
            CloseDropDownMenus(1, nil, autoInviteDropDownPRIEST);
            CloseDropDownMenus(1, nil, autoInviteDropDownROGUE);
            CloseDropDownMenus(1, nil, autoInviteDropDownWARRIOR);
            CloseDropDownMenus(1, nil, autoInviteDropDownWARLOCK);
         end
      end

   elseif (button == "RightButton") then
      local j,k=string.find(this:GetName(),"CompleteList");
      if(j) then
         -- Click was in Complete List
         if(user and AutoInviteConfig['lockComplete']==0) then
	    autoInvite:chatMsg("Remove player "..user.." from complete list");
            idToRemove=autoInvite:getId(AutoInviteCompleteList,user);
	    autoInvite.control.member[user]=nil;
            table.remove(AutoInviteCompleteList,idToRemove);
            autoInvite:completeList_Update(oldCount);
         end
      else
         if(user) then
            local id=autoInvite:getId(AutoInviteCompleteList,user);
            autoInvite:debugMsg("User: "..id);
	    autoInvite:debugMsg("User-class: "..AutoInviteCompleteList[id]["eClass"]);
            if(AutoInviteCompleteList[id]["eClass"]=="DRUID") then
               autoInviteDropDownDRUID.relativeTo="autoInviteMainConfigFrameDRUIDListSlot01";
               ToggleDropDownMenu(1, nil, autoInviteDropDownDRUID);
	    elseif (AutoInviteCompleteList[id]["eClass"]=="HUNTER") then
               autoInviteDropDownHUNTER.relativeTo="autoInviteMainConfigFrameHUNTERListSlot01";
               ToggleDropDownMenu(1, nil, autoInviteDropDownHUNTER);
	    elseif (AutoInviteCompleteList[id]["eClass"]=="MAGE") then
               autoInviteDropDownMAGE.relativeTo="autoInviteMainConfigFrameMAGEListSlot01";
               ToggleDropDownMenu(1, nil, autoInviteDropDownMAGE);
	    elseif (AutoInviteCompleteList[id]["eClass"]=="PALADIN" or AutoInviteCompleteList[id]["eClass"]=="SHAMAN") then
               autoInviteDropDownPALADIN.relativeTo="autoInviteMainConfigFramePALADINListSlot01";
               ToggleDropDownMenu(1, nil, autoInviteDropDownPALADIN);
	    elseif (AutoInviteCompleteList[id]["eClass"]=="PRIEST") then
               autoInviteDropDownPRIEST.relativeTo="autoInviteMainConfigFramePRIESTListSlot01";
               ToggleDropDownMenu(1, nil, autoInviteDropDownPRIEST);
	    elseif (AutoInviteCompleteList[id]["eClass"]=="ROGUE") then
               autoInviteDropDownROGUE.relativeTo="autoInviteMainConfigFrameROGUEListSlot01";
               ToggleDropDownMenu(1, nil, autoInviteDropDownROGUE);
	    elseif (AutoInviteCompleteList[id]["eClass"]=="WARRIOR") then
               autoInviteDropDownWARRIOR.relativeTo="autoInviteMainConfigFrameWARRIORListSlot01";
               ToggleDropDownMenu(1, nil, autoInviteDropDownWARRIOR);
	    elseif (AutoInviteCompleteList[id]["eClass"]=="WARLOCK") then
               autoInviteDropDownWARLOCK.relativeTo="autoInviteMainConfigFrameWARLOCKListSlot01";
               ToggleDropDownMenu(1, nil, autoInviteDropDownWARLOCK);
            end
         end
      end
      
   elseif (button == "MiddleButton") then
      autoInvite:debugMsg("MiddleClick");
   end
end

-- Update the complete list
function autoInvite:completeList_Update(oldCount)
   autoInvite:debugMsg("In function autoInvite:completeList_Update");
   local baseName = "autoInviteMainConfigFrameCompleteList";
   local maxCount=table.getn(AutoInviteCompleteList);
   local maxDisplay=20;
   local i=0;
   local index=0;
   local id="";
   local offset=0;
   autoInvite:countMembersInGroup();
   local scrollOffset=FauxScrollFrame_GetOffset(autoInviteMainConfigFrameCompleteListScrollFrame);
   local displayNames={};
   local j=0;

   --   autoInvite:chatMsg("Create list to display");
   for i=1, maxCount do
      --      autoInvite:chatMsg("Check player: "..AutoInviteCompleteList[i]["name"]);
      if(AutoInviteCompleteList[i]["inGroup"]==false) then
	 --	 autoInvite:chatMsg("Display player: "..AutoInviteCompleteList[i]["name"]);
         j=j+1;
         displayNames[j]={};
         displayNames[j]["name"]=AutoInviteCompleteList[i]["name"];
         displayNames[j]["level"]=AutoInviteCompleteList[i]["level"];
         displayNames[j]["eClass"]=AutoInviteCompleteList[i]["eClass"];
      end
   end
   --   autoInvite:chatMsg("ScrollOffset: "..scrollOffset);

   --   autoInvite:chatMsg("Display the created list");
   for i=1, maxDisplay do
      local linePlusOffset=i+scrollOffset;
      id=i;
      if(i<10) then
         id="0"..i;
      end
      --      if(displayNames[linePlusOffset]) then
      --         autoInvite:chatMsg("Display: "..displayNames[linePlusOffset]["name"]);
      --      end
      --      autoInvite:chatMsg("Id: "..id);
      if(linePlusOffset <= maxCount and displayNames[linePlusOffset]) then
         --	 autoInvite:chatMsg("Display: "..displayNames[linePlusOffset]["name"]);
         getglobal(baseName.."Slot"..id.."TextLabelName"):SetText(displayNames[linePlusOffset]["name"]);
         getglobal(baseName.."Slot"..id.."TextLabelLevel"):SetText(displayNames[linePlusOffset]["level"]);
         getglobal(baseName.."Slot"..id.."TextLabelClass"):SetText(AUTO_INVITE_CLASS[displayNames[linePlusOffset]["eClass"]]);
         getglobal(baseName.."Slot"..id.."TextLabelBackground"):Hide();
	 if(autoInvite.control['member'][displayNames[linePlusOffset]["name"]]['online']) then
	    getglobal(baseName.."Slot"..id.."TextLabelName"):SetVertexColor(autoInvite.greenColor.r, autoInvite.greenColor.g, autoInvite.greenColor.b);
	    getglobal(baseName.."Slot"..id.."TextLabelLevel"):SetVertexColor (autoInvite.greenColor.r, autoInvite.greenColor.g, autoInvite.greenColor.b);
	    getglobal(baseName.."Slot"..id.."TextLabelClass"):SetVertexColor(autoInvite.greenColor.r, autoInvite.greenColor.g, autoInvite.greenColor.b);
	 else
	    getglobal(baseName.."Slot"..id.."TextLabelName"):SetVertexColor (NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	    getglobal(baseName.."Slot"..id.."TextLabelLevel"):SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	    getglobal(baseName.."Slot"..id.."TextLabelClass"):SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	 end
      else
         --	 autoInvite:chatMsg("Empty");
         getglobal(baseName.."Slot"..id.."TextLabelName"):SetText("");
         getglobal(baseName.."Slot"..id.."TextLabelLevel"):SetText("");
         getglobal(baseName.."Slot"..id.."TextLabelClass"):SetText("");
         getglobal(baseName.."Slot"..id.."TextLabelBackground"):Show();

	 getglobal(baseName.."Slot"..id.."TextLabelName"):SetVertexColor (NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	 getglobal(baseName.."Slot"..id.."TextLabelLevel"):SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	 getglobal(baseName.."Slot"..id.."TextLabelClass"):SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
      end
   end
end

-- return the internal id, search string is the userName
function autoInvite:getId(searchStr,user)
   local i;
   for i=1, table.getn(searchStr) do
      --      autoInvite:chatMsg(i..": Compare: "..user.." with: "..searchStr[i]["name"]);
      if(user==searchStr[i]["name"]) then
         return i;
      end
   end
   return 0;
end

-- Add the user to the raid/group list and refreshes the window
function autoInvite:addToGroup(user)
   local userId=autoInvite:getId(AutoInviteCompleteList,user);
   AutoInviteCompleteList[userId]["inGroup"]=true;
   autoInvite:buildGroups();
   autoInvite:completeList_Update();
   --   autoInvite:chatMsg("Base: "..baseName);
end

-- Remove the user from the raid/group list and refreshes the window
function autoInvite:removeFromGroup(user)
   autoInvite:debugMsg("In function autoInvite:removeFromGroup("..user..")");
   local userId=autoInvite:getId(AutoInviteCompleteList,user);
   AutoInviteCompleteList[userId]["inGroup"]=false;
   -- should we really delete the current saved group?
   AutoInviteCompleteList[userId]["group"]="-";
   autoInvite.control.member[user]["status"]="unknown";
   -- if removed player is in group, maybe remove him XXXX

   autoInvite:buildGroups();
   autoInvite:completeList_Update();
   autoInvite:updateGroupCount();
end

-- Refresh the raid/group list on the window
function autoInvite:buildGroups()
   autoInvite:debugMsg("In function autoInvite:buildGroups()");
   local max=table.getn(AutoInviteCompleteList);
   local i=0;
   local v=0;
   local class;

   -- Clear all buttons in the raid/group list
   --   autoInvite:chatMsg("Try to clean the Buttons");
   for i,v in autoInvite.groupCount do
      if(v~=0) then
         local baseName="autoInviteMainConfigFrame";
         class=i;
         if(class=="SHAMAN") then
            class="PALADIN";
         end
         local lBaseName=baseName..class.."List";
	 --	 autoInvite:chatMsg("i: "..i.." v: "..v);
         for j=1,v do
            local id=""..j;
            if(j<10) then
               id="0"..j;
            end
            if(j<=10) then
               local btnGroup = getglobal(lBaseName.."Slot"..id.."TextLabelGroup");
               local btnName = getglobal(lBaseName.."Slot"..id.."TextLabelName");
               local btnLevel = getglobal(lBaseName.."Slot"..id.."TextLabelLevel");
               local btnClass = getglobal(lBaseName.."Slot"..id.."TextLabelClass");
               local btnBack = getglobal(lBaseName.."Slot"..id.."TextLabelBackground");
	       --               staticDebugMg("In function autoInviteBuildGroups()");
	       --               autoInvite:chatMsg(lBaseName.."Slot"..id.."TextLabelName");
               btnGroup:SetText("");
               btnName:SetText("");
               btnLevel:SetText("");
               btnClass:SetText("");
               btnBack:Show();
            end
         end
      end
   end

   autoInvite.groupCount["DRUID"]=0;
   autoInvite.groupCount["HUNTER"]=0;
   autoInvite.groupCount["MAGE"]=0;
   autoInvite.groupCount["PALADIN"]=0;
   autoInvite.groupCount["PRIEST"]=0;
   autoInvite.groupCount["ROGUE"]=0;
   autoInvite.groupCount["WARRIOR"]=0;
   autoInvite.groupCount["WARLOCK"]=0;
   autoInvite.groupCount["SHAMAN"]=0;
   getglobal("autoInviteMainConfigFrameDRUIDListLabel"):SetText(AUTO_INVITE_CLASS["DRUID"].." (0)");
   getglobal("autoInviteMainConfigFrameHUNTERListLabel"):SetText(AUTO_INVITE_CLASS["HUNTER"].." (0)");
   getglobal("autoInviteMainConfigFrameMAGEListLabel"):SetText(AUTO_INVITE_CLASS["MAGE"].." (0)");
   getglobal("autoInviteMainConfigFramePALADINListLabel"):SetText(AUTO_INVITE_CLASS["PALADIN"].." (0)");
   getglobal("autoInviteMainConfigFramePRIESTListLabel"):SetText(AUTO_INVITE_CLASS["PRIEST"].." (0)");
   getglobal("autoInviteMainConfigFrameROGUEListLabel"):SetText(AUTO_INVITE_CLASS["ROGUE"].." (0)");
   getglobal("autoInviteMainConfigFrameWARRIORListLabel"):SetText(AUTO_INVITE_CLASS["WARRIOR"].." (0)");
   getglobal("autoInviteMainConfigFrameWARLOCKListLabel"):SetText(AUTO_INVITE_CLASS["WARLOCK"].." (0)");

   for i=1, max do
      if(AutoInviteCompleteList[i]["inGroup"]==true) then
         local baseName="autoInviteMainConfigFrame";
	 --         autoInvite:chatMsg("Group-Insert: "..AutoInviteCompleteList[i]["name"]);
         if(not AutoInviteCompleteList[i]["eClass"])then
            autoInvite:chatMsg(format(AUTO_INVITE_NO_INFO_AVAILABLE_MOVE_DRUIDE,AutoInviteCompleteList[i]["name"]));
            AutoInviteCompleteList[i]["eClass"]="DRUID";
         end
	 --         autoInvite:chatMsg("Debug: "..AutoInviteCompleteList[i]["eClass"]);
         local eClass=AutoInviteCompleteList[i]["eClass"];
         if(eClass=="SHAMAN") then
            baseName=baseName.."PALADINList";
         else
            baseName=baseName..eClass.."List";
         end
	 --         autoInvite:chatMsg("eClass: "..eClass);
         autoInvite.groupCount[eClass]=autoInvite.groupCount[eClass]+1;
         local id=""..autoInvite.groupCount[eClass];
         if(autoInvite.groupCount[eClass]<10) then
            id="0"..autoInvite.groupCount[eClass];
         end
         -- Update Count for each group
         getglobal(baseName.."Label"):SetText(AUTO_INVITE_CLASS[eClass].." ("..autoInvite.groupCount[eClass]..")");

         if(autoInvite.groupCount[eClass]<=10) then
            local btnGroup = getglobal(baseName.."Slot"..id.."TextLabelGroup");
            local btnName = getglobal(baseName.."Slot"..id.."TextLabelName");
            local btnLevel = getglobal(baseName.."Slot"..id.."TextLabelLevel");
            local btnClass = getglobal(baseName.."Slot"..id.."TextLabelClass");
            local btnBack = getglobal(baseName.."Slot"..id.."TextLabelBackground");
            --	 autoInvite:chatMsg(baseName.."Slot"..id.."TextLabelName");
            if(AutoInviteCompleteList[i]["group"]==nil) then
               autoInvite:debugMsg("Add key to array");
               AutoInviteCompleteList[i]["group"]='-';
            end
            btnGroup:SetText(AutoInviteCompleteList[i]["group"]);
            btnName:SetText(AutoInviteCompleteList[i]["name"]);
            btnLevel:SetText(AutoInviteCompleteList[i]["level"]);
            btnClass:SetText(AUTO_INVITE_CLASS[AutoInviteCompleteList[i]["eClass"]]);
            --	 btnName:SetVertexColor(color.r, color.g, color.b);
            if(autoInvite.control.member[AutoInviteCompleteList[i]['name']]["status"]==nil) then
               autoInvite.control.member[AutoInviteCompleteList[i]['name']]["status"]="unknown";
            end
            if(autoInvite.control.member[AutoInviteCompleteList[i]['name']]["status"]=="invited") then
               -- is invited set color to yellow
               btnGroup:SetVertexColor(autoInvite.yellowColor.r, autoInvite.yellowColor.g, autoInvite.yellowColor.b);
               btnName:SetVertexColor(autoInvite.yellowColor.r, autoInvite.yellowColor.g, autoInvite.yellowColor.b);
               btnLevel:SetVertexColor(autoInvite.yellowColor.r, autoInvite.yellowColor.g, autoInvite.yellowColor.b);
               btnClass:SetVertexColor(autoInvite.yellowColor.r, autoInvite.yellowColor.g, autoInvite.yellowColor.b);
	    elseif (autoInvite.control.member[AutoInviteCompleteList[i]['name']]["status"]=="unknown") then
               -- not invited set color to grey
               btnGroup:SetVertexColor(autoInvite.greyColor.r, autoInvite.greyColor.g, autoInvite.greyColor.b);
               btnName:SetVertexColor(autoInvite.greyColor.r, autoInvite.greyColor.g, autoInvite.greyColor.b);
               btnLevel:SetVertexColor(autoInvite.greyColor.r, autoInvite.greyColor.g, autoInvite.greyColor.b);
               btnClass:SetVertexColor(autoInvite.greyColor.r, autoInvite.greyColor.g, autoInvite.greyColor.b);
	    elseif (autoInvite.control.member[AutoInviteCompleteList[i]['name']]["status"]=="joined") then
               -- joined the group set color to green
               btnGroup:SetVertexColor(autoInvite.greenColor.r, autoInvite.greenColor.g, autoInvite.greenColor.b);
               btnName:SetVertexColor (autoInvite.greenColor.r, autoInvite.greenColor.g, autoInvite.greenColor.b);
               btnLevel:SetVertexColor(autoInvite.greenColor.r, autoInvite.greenColor.g, autoInvite.greenColor.b);
               btnClass:SetVertexColor(autoInvite.greenColor.r, autoInvite.greenColor.g, autoInvite.greenColor.b);
	    elseif (autoInvite.control.member[AutoInviteCompleteList[i]['name']]["status"]=="ignored"
		    or autoInvite.control.member[AutoInviteCompleteList[i]['name']]["status"]=="declined"
		       or autoInvite.control.member[AutoInviteCompleteList[i]['name']]["status"]=="offline") then
               -- will not join the group set color to red
               btnGroup:SetVertexColor(autoInvite.redColor.r, autoInvite.redColor.g, autoInvite.redColor.b);
               btnName:SetVertexColor (autoInvite.redColor.r, autoInvite.redColor.g, autoInvite.redColor.b);
               btnLevel:SetVertexColor(autoInvite.redColor.r, autoInvite.redColor.g, autoInvite.redColor.b);
               btnClass:SetVertexColor(autoInvite.redColor.r, autoInvite.redColor.g, autoInvite.redColor.b);
	    elseif (autoInvite.control.member[AutoInviteCompleteList[i]['name']]["status"]=="grouped") then
               -- is allready in group set color to blue
               btnGroup:SetVertexColor(autoInvite.blueColor.r, autoInvite.blueColor.g, autoInvite.blueColor.b);
               btnName:SetVertexColor(autoInvite.blueColor.r, autoInvite.blueColor.g, autoInvite.blueColor.b);
               btnLevel:SetVertexColor(autoInvite.blueColor.r, autoInvite.blueColor.g, autoInvite.blueColor.b);
               btnClass:SetVertexColor(autoInvite.blueColor.r, autoInvite.blueColor.g, autoInvite.blueColor.b);
            end
            btnBack:Hide();
         end
      end
   end
   autoInvite:countMembersInGroup();
end

-- invite the people, which are in the list
function autoInvite:invite()
   autoInvite:debugMsg("In function autoInvite:invite()");
   -- activate the mod
   autoInvite:activate();
   local max=table.getn(AutoInviteCompleteList);
   local i;
   --local id=autoInviteGetId(AutoInviteCompleteList,UnitName("player"));
   if(autoInvite:getId(AutoInviteCompleteList,UnitName("player"))==0) then
      --      autoInvite:chatMsg("Player is not in complete list");
      autoInvite:completeAdd(UnitName("player"));
   end
   autoInvite:addToGroup(UnitName("player"));
   
   for i=1, max do
      if(AutoInviteCompleteList[i]["inGroup"]==true) then
	 --	 autoInvite:chatMsg("Invite "..AutoInviteCompleteList[i]['name']);
         if(UnitName("player")==AutoInviteCompleteList[i]['name']) then
	    --            autoInvite:chatMsg("Invite myself");
            autoInvite.control.member[AutoInviteCompleteList[i]['name']]['status']="joined";
            autoInvite:buildGroups();
	 elseif (autoInvite.control.member[AutoInviteCompleteList[i]['name']]['status']=="joined") then
	    --            autoInvite:chatMsg("Player "..AutoInviteCompleteList[i]['name'].." already in group, dont invite him or her");
         else
            InviteByName(AutoInviteCompleteList[i]['name']);
         end
      end
   end
end

-- Event which is triggered if a member leaves or joins the group
function autoInvite:memberJoinedParty()
   autoInvite:debugMsg("In function autoInvite:memberJoinedParty()");
   local memberCount=GetNumPartyMembers();
   local i, name;

   for i=0, memberCount do
      --      autoInvite:chatMsg("Count: "..i.." from "..memberCount);
      if(i==0) then
         name=UnitName("player");
      else
         name=UnitName("party"..i);
      end
      if(name) then
	 --         autoInvite:chatMsg("Member "..name.." joined");
         local id=autoInvite:getId(AutoInviteCompleteList,name);
         if(id==0) then
            -- player is not in complete list, add him
	    autoInvite:debugMsg("Player "..name.." has no ID, create it");
            autoInvite:completeAdd(name);
            id=autoInvite:getId(AutoInviteCompleteList,name);
         end
         if(id~=0) then
            autoInvite.control.member[AutoInviteCompleteList[id]['name']]["status"]="joined";
            AutoInviteCompleteList[id]["inGroup"]=true;
            --	 autoInvite:chatMsg("Level: "..AutoInviteCompleteList[id]["level"].." name: "..AutoInviteCompleteList[id]["name"].." name2: "..name);
            --	 if(AutoInviteCompleteList[id]["level"]==0) then
            --	    autoInvite:chatMsg("Read player information");
            local class,eClass,level;
            if(i==0) then
               class,eClass=UnitClass("player");
               level=UnitLevel("player");
            else
               class,eClass=UnitClass("party"..i);
               level=UnitLevel("party"..i);
            end
            --	    autoInvite:chatMsg("Read class: "..class.." eClass: "..eClass);
            --	    autoInvite:chatMsg("Readed level: "..level);
	    -- always read player information	
	    if(level~=0) then
--            if(level>AutoInviteCompleteList[id]["level"]) then
               AutoInviteCompleteList[id]["level"]=level;
            end
            AutoInviteCompleteList[id]["eClass"]=eClass;
            --	 end
            --	 end
         end
      end
   end
   autoInvite:buildGroups();
end

-- Event which is called if a member joins or leaves the raid
function autoInvite:memberJoinedRaid()
   autoInvite:debugMsg("function autoInvite:memberJoinedRaid is called");
   local memberCount=GetNumRaidMembers();
   autoInvite:debugMsg("RaidCount: "..memberCount);
   local i;
   for i=1, memberCount do
      local name,rank,subgroup,level,class,eClass=GetRaidRosterInfo(i);
      if(name) then
         --	 autoInvite:chatMsg("Member "..name.." joined");
	 local id=autoInvite:getId(AutoInviteCompleteList,name);
	 if(id==0) then
            -- player is not in complete list, add him
	    autoInvite:debugMsg("Player "..name.. " has no ID, create it");
            autoInvite:completeAdd(name);
            id=autoInvite:getId(AutoInviteCompleteList,name);
         end
         if(id~=0) then
            --	 autoInvite:chatMsg("ID: "..id);
            autoInvite.control.member[AutoInviteCompleteList[id]['name']]["status"]="joined";
            AutoInviteCompleteList[id]["inGroup"]=true;
            --	 if(AutoInviteCompleteList[id]["level"]==0) then
	    --	    autoInvite:chatMsg("Read player information");
	    --	    autoInvite:chatMsg("Readed class: "..class.." eClass: "..eClass);
	    --	    autoInvite:chatMsg("Readed level: "..level);
	    -- always save playerinformation
	    --	 if(level~=0) then
--            if(level>AutoInviteCompleteList[id]["level"]) then
	    if(level~=0) then
--	       autoInvite:debugMsg("Set group for "..name);
	       AutoInviteCompleteList[id]["level"]=level;
	    end
--            end
            AutoInviteCompleteList[id]["eClass"]=eClass;
            --	 end
            --	 end
	    --	 autoInvite:chatMsg("Player: "..name.." subgroup: "..subgroup.." Level: "..level.." eClass: "..eClass);
         end
      end
   end
   autoInvite:buildGroups();
end

-- count how much players are in the raid group, how much are really invited and statistic for each group
function autoInvite:countMembersInGroup()
   autoInvite:debugMsg("In function autoInvite:countMembersInGroup()");
   local complete=0;
   local completeInvited=0;
   local max=table.getn(AutoInviteCompleteList);
   local i;

   for i=1, max do
      if(AutoInviteCompleteList[i]["inGroup"]==true) then
         if(autoInvite.control.member[AutoInviteCompleteList[i]['name']]["status"]=="joined") then
            completeInvited=completeInvited+1;
         end
         complete=complete+1;
      end
   end
   --   autoInvite:chatMsg("Corrent Count: "..complete.." invited: "..completeInvited);

   local textCompleteStatistic = getglobal("autoInviteMainConfigFramePlayerStatistic");
   textCompleteStatistic:SetText(format(AUTO_INVITE_NUMBER_OF_PLAYERS,completeInvited,complete));

   FauxScrollFrame_Update(autoInviteMainConfigFrameCompleteListScrollFrame, max-complete,20,20);
   getglobal("autoInviteMainConfigFrameCompleteListLabel"):SetText(format(AUTO_INVITE_COMPLETELIST,max-complete));
   --   FauxScrollFrame_Update(autoInviteMainConfigFrameCompleteListScrollFrame, max-completeInvited-complete,20,20);
   --   getglobal("autoInviteMainConfigFrameCompleteListLabel"):SetText(AUTO_INVITE_COMPLETELIST.."("..max-completeInvited-complete..")");
end

-- Read the current groupsetup and save it
function autoInvite:readGroupSetup()
   autoInvite:chatMsg(AUTO_INVITE_READ_GROUP_SETUP);
   -- check if in raid
   -- ??? dont know how to do it XXXX
   local i;
   local max=table.getn(AutoInviteCompleteList);
   for i=1, max do
      autoInvite:debugMsg("Reset member: "..i);
      AutoInviteCompleteList[i]["group"]="-";
   end
   
   -- maybe at first read members?
   local memberCount=GetNumRaidMembers();
   for i=1, memberCount do
      local name,rank,subgroup,level,class,eClass=GetRaidRosterInfo(i);
      if(name) then
         local id=autoInvite:getId(AutoInviteCompleteList,name);
         if(level>=1 or level<=autoInvite.maxlevel) then
	    if(not AutoInviteCompleteList[id]) then
	       AutoInviteCompleteList[id]={};
	    end
            AutoInviteCompleteList[id]["level"]=level;
            AutoInviteCompleteList[id]["eClass"]=eClass;
            AutoInviteCompleteList[id]["group"]=subgroup;
         end
      end
   end
   autoInvite:updateGroupCount();
   autoInvite:buildGroups();
   autoInvite:chatMsg(AUTO_INVITE_DONE);
end

-- set the saved group setup and move players in defined groups
function autoInvite:movePlayers(forceMove)
   autoInvite:debugMsg("In function autoInvite;movePlayers()");
   if(not IsRaidLeader()) then
      if(not forceMove) then
	 autoInvite:chatMsg(AUTO_INVITE_IM_NOT_THE_RAID_LEADER_SKIPPING);
	 do return end;
      end
   end
   local memberCount=GetNumRaidMembers();
   local i, j;
   autoInvite.needMovePlayers=0;

   autoInvite:debugMsg(memberCount.." players are analysed");
   -- mark players, which need to be moved
   for i=1, memberCount do
      local name,rank,subgroup,level,class,eClass=GetRaidRosterInfo(i);
      if(name) then
         local id=autoInvite:getId(AutoInviteCompleteList,name);
         if(AutoInviteCompleteList[id]["group"]=="-") then
            autoInvite:chatMsg(format(AUTO_INVITE_FOR_XXX_NO_GROUP_DEFINED,name));
            return;
	 elseif (AutoInviteCompleteList[id]["group"]==subgroup) then
            autoInvite.control['member'][name]["needMove"]=false;
         else
            autoInvite.control['member'][name]["needMove"]=true;
            autoInvite.needMovePlayers=autoInvite.needMovePlayers+1;
            autoInvite:debugMsg("Player "..name.." is marked for moving");
         end
      end
   end
   autoInvite:debugMsg("Analyse done.");
   if(autoInvite.NeedMovePlayers>0) then
      autoInvite:chatMsg(AUTO_INVITE_START_TO_MOVE_PLAYERS);
      autoInvite.movePlayersActive=true;
      autoInvite:doMovePlayers();
   else
      autoInvite:chatMsg(AUTO_INVITE_MOVING_FINISHED);
   end
end

function autoInvite:doMovePlayers()
   autoInvite:debugMsg("Starting to swap players...");
   local memberCount=GetNumRaidMembers();
   local i, j;

   if (autoInvite.NeedMovePlayers>1) then
      autoInvite:debugMsg("Starting to swap players...");
      -- swap players
      for i=1, memberCount do
         local name,rank,subgroup,level,class,eClass=GetRaidRosterInfo(i);
         if(name) then
            local id=autoInvite:getId(AutoInviteCompleteList,name);
            if(autoInvite.control['member'][name]["needMove"]==true) then
               for j=1, memberCount do
                  local name2,rank2,subgroup2,level2,class2,eClass2=GetRaidRosterInfo(j);
                  if(name2) then
                     local id2=autoInvite:getId(AutoInviteCompleteList,name2);
                     if(autoInvite.control['member'][name2]["needMove"]==true and AutoInviteCompleteList[id2]["group"]==subgroup) then
                        SwapRaidSubgroup(i,j);
                        autoInvite.control['member'][name2]["needMove"]=false;
                        autoInvite:debugMsg("Swap player "..name.." and "..name2);
                        autoInvite.NeedMovePlayers=autoInvite.NeedMovePlayers-1;
			if(AutoInviteCompleteList[id]['group']==subgroup2) then
			   autoInvite:debugMsg("Both players are in correct group, reduce count");
			   autoInvite.control['member'][name]["needMove"]=false;
			   autoInvite.NeedMovePlayers=autoInvite.NeedMovePlayers-1;
			end
			autoInvite:debugMsg("Player swaped exit");
			do return end;
                     end
                  end
               end
            end
         end
      end
      autoInvite:debugMsg("Finished Swap players");
   end

   autoInvite:debugMsg("Check if players need moving...");
   if (autoInvite.NeedMovePlayers>0) then
      autoInvite:debugMsg("Starting to move players...");
      -- check if needMove is left
      for i=1, memberCount do
	 local name,rank,subgroup,level,class,eClass=GetRaidRosterInfo(i);
	 if(name) then
	    local id=autoInvite:getId(AutoInviteCompleteList,name);
	    if(autoInvite.control['member'][name]["needMove"]==true) then
	       local countWishGroup=0;
	       -- count wishgroup
	       for j=1, memberCount do
		  local name2,rank2,subgroup2,level2,class2,eClass2=GetRaidRosterInfo(j);
		  local id2=autoInvite:getId(AutoInviteCompleteList,name2);
		  if(AutoInviteCompleteList[id2]["group"]==subgroup) then
		     countWishGroup=countWishGroup+1;
		  end
	       end
	       if(countWishGroup<5) then
		  autoInvite:debugMsg("Move player "..name.." to group "..AutoInviteCompleteList[id]["group"]);
		  SetRaidSubgroup(i,AutoInviteCompleteList[id]["group"]);
		  autoInvite.control['member'][name]["needMove"]=false;
		  autoInvite.NeedMovePlayers=autoInvite.NeedMovePlayers-1;
		  do return end;
	       else
		  autoInvite:chatMsg(format(AUTO_INVITE_CANNOT_MOVE_PLAYER_GROUP_IS_FULL,name));
	       end
	    end
	 end
      end
      autoInvite:debugMsg("Finished moving players");
   end
   autoInvite.movePlayersActive=false;
   autoInvite:movePlayers();
end

function autoInvite:ifWisperOnLoad()
   local baseName="autoInviteMainConfigFrame";
   local btnWisper = getglobal(baseName.."CheckButtonWisper");
   if(AutoInviteConfig['ifWisper']==1) then
      -- set check
      btnWisper:SetChecked(1);
   else
      -- remove check
      AutoInviteConfig['ifWisper']=0;
      btnWisper:SetChecked(0);
   end
end

function autoInvite:ifWisperOnClick()
   local baseName="autoInviteMainConfigFrame";
   local btnWisper = getglobal(baseName.."CheckButtonWisper");
   local state=btnWisper:GetChecked();
   if(state == 1) then
      --      autoInvite:chatMsg("Button was not selected, select it now");
      AutoInviteConfig['ifWisper']=1;
      btnWisper:SetChecked(1);
   else
      --      autoInvite:chatMsg("Button was selected, unselect it now");
      AutoInviteConfig['ifWisper']=0;
      btnWisper:SetChecked(0);
   end
end

function autoInvite:loadSaveConfig()
   if(autoInviteLoadSaveFrame:IsVisible()) then
      autoInviteLoadSaveFrame:Hide();
   else
      autoInviteLoadSaveFrame:Show();
      autoInvite:loadSaveScrollBar_Update();
   end
end

function autoInvite:loadSaveScrollBar_Update()
   local i, index, item;
   local baseName="autoInviteLoadSaveFrame";
   local max=table.getn(AutoInviteSavedList);
   --   autoInvite:chatMsg("Max: "..max);
   -- function FauxScrollFrame_Update(frame, numItems, numToDisplay, valueStep, button, smallWidth, bigWidth, highlightFrame, smallHighlightWidth, bigHighlightWidth )
   FauxScrollFrame_Update(autoInviteLoadSaveScrollFrame, max,8,8);
   
   for i=1,8 do
      index = i + FauxScrollFrame_GetOffset(autoInviteLoadSaveScrollFrame);
      if index <= max then
         --	 autoInvite:chatMsg("Index: "..index);
         --	 autoInvite:chatMsg("Set: "..AutoInviteSavedList[index].name);
         getglobal(baseName.."LoadSaveDetail"..i.."_Index"):SetText(index);
         getglobal(baseName.."LoadSaveDetail"..i.."_Description"):SetText(AutoInviteSavedList[index].description);
         getglobal(baseName.."LoadSaveDetail"..i.."_Dummy"):SetText(AutoInviteSavedList[index].text);
         getglobal(baseName.."LoadSaveDetail"..i):Show();
      else
         getglobal(baseName.."LoadSaveDetail"..i):Hide();
      end
   end
   --   end
   
end

function autoInvite:loadSaveFrameLoadButton_OnClick()
   autoInvite:debugMsg("Load button clicked, in function autoInvite:loadSaveFrameLoadButton_OnClick");
   local name=this:GetName();
   local searchIndex=string.find(name,"_");
   local class=string.sub(name,1,searchIndex-1);
   local index=tonumber(getglobal(class.."_Index"):GetText());
   autoInvite:debugMsg("index: "..index);
   local userCount=table.getn(AutoInviteSavedList[index]["list"]);
   autoInvite:debugMsg("Count: "..userCount);
   AutoInviteCompleteList={};
   for i=1,userCount do
      autoInvite:debugMsg("i: "..i);
      AutoInviteCompleteList[i]={};
      AutoInviteCompleteList[i]['group']=AutoInviteSavedList[index]['list'][i]['group'];
      AutoInviteCompleteList[i]['eClass']=AutoInviteSavedList[index]['list'][i]['eClass'];
      AutoInviteCompleteList[i]['name']=AutoInviteSavedList[index]['list'][i]['name'];
      AutoInviteCompleteList[i]['inGroup']=AutoInviteSavedList[index]['list'][i]['inGroup'];
      AutoInviteCompleteList[i]['status']=AutoInviteSavedList[index]['list'][i]['status'];
      AutoInviteCompleteList[i]['level']=AutoInviteSavedList[index]['list'][i]['level'];
      AutoInviteCompleteList[i]['invited']=AutoInviteSavedList[index]['list'][i]['invited'];
      AutoInviteCompleteList[i]['comment']=AutoInviteSavedList[index]['list'][i]['comment'];
   end
   autoInvite:resetControlObject();
   autoInvite:chatMsg(AUTO_INVITE_LIST_LOADED);
   autoInvite:loadSaveConfig();
   -- update groups
   autoInvite:sortCompleteList();
   autoInvite:completeList_Update();
   autoInvite:buildGroups();
   autoInvite:updateGroupCount();
end

function autoInvite:loadSaveFrameWriteButton_OnClick()
   autoInvite:debugMsg("Overwrite it");
   local name=this:GetName();
   local index=string.find(name,"_");
   local class=string.sub(name,1,index-1);
   local id=tonumber(getglobal(class.."_Index"):GetText());
   autoInvite:debugMsg("ID: "..id);

   local countUser=table.getn(AutoInviteCompleteList);
   AutoInviteSavedList[id]['list']={};
   for i=1,countUser do
      AutoInviteSavedList[id]['list'][i]={};
      AutoInviteSavedList[id]['list'][i]['group']=AutoInviteCompleteList[i]['group'];
      AutoInviteSavedList[id]['list'][i]['eClass']=AutoInviteCompleteList[i]['eClass'];
      AutoInviteSavedList[id]['list'][i]['name']=AutoInviteCompleteList[i]['name'];
      AutoInviteSavedList[id]['list'][i]['inGroup']=AutoInviteCompleteList[i]['inGroup'];
      AutoInviteSavedList[id]['list'][i]['status']=AutoInviteCompleteList[i]['status'];
      AutoInviteSavedList[id]['list'][i]['level']=AutoInviteCompleteList[i]['level'];
      AutoInviteSavedList[id]['list'][i]['invited']=AutoInviteCompleteList[i]['invited'];
      AutoInviteSavedList[id]['list'][i]['comment']=AutoInviteCompleteList[i]['comment'];
   end
   autoInvite:loadSaveScrollBar_Update();
   autoInvite:loadSaveConfig();
   autoInvite:completeList_Update();
   autoInvite:buildGroups();
   autoInvite:updateGroupCount();
   autoInvite:chatMsg(AUTO_INVITE_SUCCESSFULLY_SAVED);
end

function autoInvite:loadSaveFrameSave(description)
   autoInvite:debugMsg("Got description: "..description);
   local max=table.getn(AutoInviteSavedList);
   local countUser=table.getn(AutoInviteCompleteList);
   AutoInviteSavedList[max+1]={};
   AutoInviteSavedList[max+1]['description']=description;
   AutoInviteSavedList[max+1]['list']={};
   for i=1,countUser do
      AutoInviteSavedList[max+1]['list'][i]={};
      AutoInviteSavedList[max+1]['list'][i]['group']=AutoInviteCompleteList[i]['group'];
      AutoInviteSavedList[max+1]['list'][i]['eClass']=AutoInviteCompleteList[i]['eClass'];
      AutoInviteSavedList[max+1]['list'][i]['name']=AutoInviteCompleteList[i]['name'];
      AutoInviteSavedList[max+1]['list'][i]['inGroup']=AutoInviteCompleteList[i]['inGroup'];
      AutoInviteSavedList[max+1]['list'][i]['status']=AutoInviteCompleteList[i]['status'];
      AutoInviteSavedList[max+1]['list'][i]['level']=AutoInviteCompleteList[i]['level'];
      AutoInviteSavedList[max+1]['list'][i]['invited']=AutoInviteCompleteList[i]['invited'];
      AutoInviteSavedList[max+1]['list'][i]['comment']=AutoInviteCompleteList[i]['comment'];
   end
   autoInvite:loadSaveScrollBar_Update();
   autoInvite:completeList_Update();
   autoInvite:buildGroups();
   autoInvite:updateGroupCount();
end

function autoInvite:loadSaveFrameDelButton_OnClick()
   autoInvite:debugMsg("Delete it");
   local name=this:GetName();
   local index=string.find(name,"_");
   local class=string.sub(name,1,index-1);
   local id=tonumber(getglobal(class.."_Index"):GetText());
   autoInvite:debugMsg("ID: "..id);
   
   local count=table.getn(AutoInviteSavedList);
   local i;
   if(id<count) then
      autoInvite:debugMsg("Delete entry before");
      AutoInviteSavedList[id]={};
      for i=id,count do
         AutoInviteSavedList[i]=AutoInviteSavedList[i+1];
      end
      AutoInviteSavedList[count]=nil;
   else
      autoInvite:debugMsg("Delete last entry in list");
      AutoInviteSavedList[id]=nil;
   end
   
   autoInvite:loadSaveScrollBar_Update();
   autoInvite:loadSaveConfig();
   autoInvite:completeList_Update();
   autoInvite:buildGroups();
   autoInvite:updateGroupCount();
   autoInvite:chatMsg(AUTO_INVITE_SUCCESSFULLY_DELETED);
end

function autoInvite:switchPowerStatus()
   local baseName="autoInviteMainConfigFrame";
   local btnActive = getglobal(baseName.."CheckButtonModActive");
   local state=btnActive:GetChecked();
   if(state == 1) then
      --      autoInvite:chatMsg("Button was not selected, select it now");
      AutoInviteConfig['modActive']=1;
      btnActive:SetChecked(1);
   else
      --      autoInvite:chatMsg("Button was selected, unselect it now");
      --      autoInvite:chatMsg("kick everyone out of the groupsetup");
      for i=1, table.getn(AutoInviteCompleteList) do
         autoInvite.control.member[AutoInviteCompleteList[i]['name']]["status"]='unknown';
      end

      -- need to maybe remove the lines to disable the button in function autoInvite_InviteButton_OnClick(status)
      local raidBtn=getglobal("autoInviteMainConfigFrameButtonInviteRaid");
      local groupBtn=getglobal("autoInviteMainConfigFrameButtonInviteGroup");
      raidBtn:SetTextColor(1,0.82,0);
      raidBtn:SetHighlightTextColor(1,1,1);
      groupBtn:SetTextColor(1,0.82,0);
      groupBtn:SetHighlightTextColor(1,1,1);
      autoInvite.control.doInvites = false;

      -- Update to group display
      autoInvite:buildGroups();
      AutoInviteConfig['modActive']=0;
      btnActive:SetChecked(0);
   end
end

function autoInvite:activate()
   AutoInviteConfig['modActive']=1;
   local baseName="autoInviteMainConfigFrame";
   local btnActive = getglobal(baseName.."CheckButtonModActive");
   btnActive:SetChecked(1);
end

-- return true if playerName is in group otherwise return false
function autoInvite:playerIsInGroup(playerName)
   autoInvite:debugMsg("In function autoInvite:playerIsInGroup(playerName)");
   local memberCount=GetNumPartyMembers();
   local i, name;
   autoInvite:debugMsg("Check if player "..playerName.." is in group...");
   for i=1,memberCount do
      name=UnitName("party"..i);
      if(name) then
         autoInvite:debugMsg("Player is in group");
         do return true end;
      else
         autoInvite:debugMsg("Player is NOT in group");
         do return false end;
      end
   end
end

-- return true if playerName is in raid otherwise return false
function autoInvite:playerIsInRaid(playerName)
   autoInvite:debugMsg("In function autoInvite:playerIsInRaid(playerName)");
   local memberCount=GetNumRaidMembers();
   local i;
   autoInvite:debugMsg("Check if player "..playerName.." is in raid...");
   for i=1, memberCount do
      local name,rank,subgroup,level,class,eClass=GetRaidRosterInfo(i);
      if(name) then
         autoInvite:debugMsg("Player is in raid");
         do return true end;
      else
         autoInvite:debugMsg("Player is NOT in raid");
         do return false end;
      end
   end
end

-- function is called if the update button is clicked
-- Update the complete interface from the mod
function autoInvite:updateButton_OnClick()
   autoInvite:debugMsg("In function autoInvite:updateButton_OnClick()");
   autoInvite:memberJoinedParty();
   autoInvite:memberJoinedRaid();
   -- disabled because is called in autoInviteJoinedParty and autoInviteJoinedRaid
   --   autoInviteBuildGroups();
   autoInvite:completeList_Update();
   autoInvite:updateGroupCount();
end

-- function is called if the Clear button is clicked
-- move all player back to the complete list
function autoInvite:clearButton_OnClick()
   autoInvite:debugMsg("In function autoInvite:clearButton_OnClick()");
   for i=1, table.getn(AutoInviteCompleteList) do
      AutoInviteCompleteList[i]["inGroup"]=false;
      autoInvite.control.member[AutoInviteCompleteList[i]['name']]["status"]="unknown";
   end
   autoInvite:updateButton_OnClick();
end

-- function is called if Raid-Invite/Group-Invite button is clicked
function autoInvite:inviteButton_OnClick(status)
   if (status=="raid" and GetNumRaidMembers() == 0) then
      autoInvite.control.changeToRaid = true;
   else
      autoInvite.control.changeToRaid = false;
   end
   -- standard color: <Color r="1.0" g="0.82" b="0"/>
   -- standard highlightcolor: <Color r="1.0" g="1.0" b="1.0"/>
   if (autoInvite.control.doInvites == false) then
      this:SetTextColor(0,1,0);
      this:SetHighlightTextColor(0,1,0);
      autoInvite.control.doInvites = true;
      autoInvite:activate();
   elseif (autoInvite.control.doInvites == true) then
      this:SetTextColor(1,0.82,0);
      this:SetHighlightTextColor(1,1,1);
      autoInvite.control.doInvites = false;
   end
   autoInvite:switchPowerStatus();
end


function autoInvite:updateMainHeader()
   autoInvite:debugMsg("In function autoInvite:updateMainHeader()");
   local header = getglobal("autoInviteMainConfigFrameVersionText");
   local text=header:GetText();

   text=text..autoInvite.version;
   header:SetText(text);
end

function autoInvite:loadCSV()
   autoInvite:debugMsg("In function autoInvite:loadCSV(msg)");
   if(autoInviteLoadCSVFrame:IsVisible()) then
      autoInviteLoadCSVFrame:Hide();
   else
      autoInviteLoadCSVFrame:Show();
      --      autoInviteLoadCSVScrollBar_Update();
   end
end

function autoInvite:importCSVData()
   autoInvite:debugMsg("In function autoInvite:importCSVData()");
   local base="autoInviteLoadCSVFrame";
   local description=getglobal(base.."EditBoxProfileName"):GetText();
   local data=getglobal(base.."EditBoxCSVDataText"):GetText().."\n";

   local pos;
   local array={};
   while(string.find(data,"\n")) do
      pos=string.find(data,"\n");
      table.insert(array,string.sub(data,0,pos-1));
      data=string.sub(data,pos+1,-1);
   end

   -- clear current lists
   AutoInviteCompleteList={};
   autoInvite:resetControlObject();
   local max=table.getn(array);
   for i=1, max do
      -- build the new group array here with the description and the function
      local _,_,name,eClass,level,inGroup,group,comment=string.find(array[i],"^(.-):(.-):(.-):(.-):(.-):(.-)$");
      if(name and eClass and level and inGroup and group) then
	 AutoInviteCompleteList[i]={};
	 autoInvite:debugMsg("Name: ->"..name.."<-");
	 autoInvite:debugMsg("Class: ->"..eClass.."<-");
	 autoInvite:debugMsg("level: ->"..level.."<-");
	 autoInvite:debugMsg("inGroup: ->"..inGroup.."<-");
	 autoInvite:debugMsg("group: ->"..group.."<-");
	 autoInvite:debugMsg("comment: ->"..comment.."<-");
	 AutoInviteCompleteList[i]['name']=name;
	 AutoInviteCompleteList[i]['eClass']=eClass;
	 AutoInviteCompleteList[i]['level']=tonumber(level);
	 AutoInviteCompleteList[i]['comment']=comment;
	 if(inGroup=="1") then
	    AutoInviteCompleteList[i]['inGroup']=true;
	 else
	    AutoInviteCompleteList[i]['inGroup']=false;
	 end
	 if(group=='1' or group=='2' or group=='3' or group=='4' or
	    group=='5' or group=='6' or group=='7' or group=='8') then
	    AutoInviteCompleteList[i]['group']=tonumber(group);
	 else
	    autoInvite:debugMsg("Group invalid, set group to -");
	    AutoInviteCompleteList[i]['group']='-';
	 end
	 if (not autoInvite.control.member[AutoInviteCompleteList[i]['name']]) then
	    autoInvite.control.member[AutoInviteCompleteList[i]['name']] = {};
	 end
	 autoInvite.control.member[AutoInviteCompleteList[i]['name']]['status']="unknown";
	 autoInvite.control.member[AutoInviteCompleteList[i]['name']]['online']=false;
	 autoInvite.control.member[AutoInviteCompleteList[i]['name']]['inGuild']=false;
	 autoInvite.control.member[AutoInviteCompleteList[i]['name']]['lastChecked']=0;
	 autoInvite.control.member[AutoInviteCompleteList[i]['name']]['errorMessage']="";
	 autoInvite:debugMsg("Read name: "..AutoInviteCompleteList[i]['name']..
			    ", eClass: "..AutoInviteCompleteList[i]['eClass']..
			       ", level: "..AutoInviteCompleteList[i]['level']..
			       ", group: "..AutoInviteCompleteList[i]['group']..
			       ", online: false "..
			       ", inGuild: false "..
			       ", saved posiotion: "..i);
      end
   end
   if(description~="") then
      autoInvite:debugMsg("Description is: *"..description.."*");
      autoInvite:loadSaveFrameSave(description);
   else
      autoInvite:chatMsg(AUTO_INVITE_NO_NAME_FOR_PROFILE_DONT_SAVE_IT)
   end
   -- Close the load-save window
   autoInvite:loadSaveConfig();
   -- update groups
   autoInvite:completeList_Update();
   autoInvite:buildGroups();
   autoInvite:updateGroupCount();
end

function autoInvite:playerButton_OnEnter()
   GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
   local btnName=getglobal(this:GetName().."TextLabelName");
   local btnLevel=getglobal(this:GetName().."TextLabelLevel");
   local btnClass=getglobal(this:GetName().."TextLabelClass");
   local user=btnName:GetText();
   if(user) then
      local max=table.getn(AutoInviteCompleteList);
      local i;
      
      for i=1, max do
	 if(AutoInviteCompleteList[i]["name"]==user) then
	    GameTooltip:SetText(user..":");
	    if(AutoInviteCompleteList[i]["comment"]) then
	       -- splitt text on <br> and add several lines
	       test = AutoInviteCompleteList[i]["comment"];
	       if string.find(test,"<br>",1,true) then
		  while string.find(test,"<br>",1,true) do
		     pos=string.find(test,"<br>",1,true);
		     line=string.sub(test,1,pos-1);
		     GameTooltip:AddLine(line, 1, 1, 1, nil);
		     test=string.sub(test,pos+4,string.len(test));
		  end
		  GameTooltip:AddLine(test, 1, 1, 1, nil);
	       else
		  GameTooltip:AddLine(test, 1, 1, 1, nil);
	       end
	    end
	    break;
	 end
      end
      
      GameTooltip:Show();
   end
end

function autoInvite:generateDump()

   debugOutput={};
   table.insert(debugOutput,"---START---");
   table.insert(debugOutput,"-Dump AutoInviteCompleteList-");
   -- dump complete list
   for number in pairs(AutoInviteCompleteList) do
      if(AutoInviteCompleteList[number]["name"]) then
	 name=AutoInviteCompleteList[number]["name"];
      else
	 name="ERROR";
      end
      if(AutoInviteCompleteList[number]["inGroup"]) then
	 inGroup="true";
      else
	 inGroup="false";
      end
      if(AutoInviteCompleteList[number]["group"]) then
	 group=AutoInviteCompleteList[number]["group"];
      else
	 group="ERROR";
      end
      if(AutoInviteCompleteList[number]["level"]) then
	 level=AutoInviteCompleteList[number]["level"];
      else
	 level="ERROR";
      end
      if(AutoInviteCompleteList[number]["eClass"]) then
	 eClass=AutoInviteCompleteList[number]["eClass"];
      else
	 eClass="ERROR";
      end
      table.insert(debugOutput,"Number="..number..", Name="..name..", inGroup="..inGroup..", group="..group..", level="..level..", eClass="..eClass);
   end

   -- dump control list
   table.insert(debugOutput,"-Dump autoInvite.controlList-");
   if(autoInvite.control.isLoaded) then
      table.insert(debugOutput,"autoInvite.control.isLoaded=true");
   else
      table.insert(debugOutput,"autoInvite.control.isLoaded=false");
   end
   if(autoInvite.control.changeToRaid) then
      table.insert(debugOutput,"autoInvite.control.changeToRaid=true");
   else
      table.insert(debugOutput,"autoInvite.control.changeToRaid=false");
   end
   table.insert(debugOutput,"autoInvite.control.lastUpdate:"..autoInvite.control.lastUpdate);
   if(autoInvite.control.doInvites) then
      table.insert(debugOutput,"autoInvite.control.doInvites=true");
   else
      table.insert(debugOutput,"autoInvite.control.doInvites=false");
   end
   for name in pairs(autoInvite.control.member) do
      online="false";
      if(autoInvite.control["member"][name]["online"]) then
	 online="true";
      end
      inGuild="false";
      if(autoInvite.control["member"][name]["inGuild"]) then
	 inGuild="true";
      end
      table.insert(debugOutput,"name="..name..", status="..autoInvite.control["member"][name]["status"]..", inGuild="..inGuild..", online="..online..", errorMessage="..autoInvite.control['member'][name]['errorMessage']..", lastCheck="..autoInvite.control["member"][name]["lastChecked"]);
   end

   -- dump combined complete-control list

--   autoInvite:chatMsg("");
--   autoInvite:chatMsg("");
   table.insert(debugOutput,"---STOP---");
   return(debugOutput);
end

function autoInvite:dumpVariables()
   debugOutput=autoInvite:generateDump();
   for i,line in debugOutput do
      autoInvite:chatMsg(line);
   end
end

function autoInvite:saveDebug()
   autoInvite:chatMsg(AUTO_INVITE_GENERATE_DUMP);
   AutoInviteDebug=autoInvite:generateDump();
   autoInvite:chatMsg(AUTO_INVITE_DUMP_SUCCESSFULLY_SEND_TO);
   
   autoInvite:chatMsg(format(AUTO_INVITE_DUMP_SEND_FILE,GetCVar("accountName"),GetCVar("realmName"),UnitName("Player")));
   autoInvite:chatMsg(AUTO_INVITE_THX_FOR_HELP);
   autoInvite:chatMsg(AUTO_INVITE_TO_SAVE_DUMP);
end

function autoInvite:clearDebug()
   autoInvite:chatMsg(AUTO_INVITE_CLEAR_DUMP_LOG);
   AutoInviteDebug=nil;
   autoInvite:chatMsg(AUTO_INVITE_DONE);
end

function autoInvite:sortCompleteListOnLoad()
   local baseName="autoInviteMainConfigFrame";
   local btnWisper = getglobal(baseName.."CompleteListCheckButtonSortCompleteList");
   if(AutoInviteConfig['sortComplete']==1) then
      -- set check
      btnWisper:SetChecked(1);
   else
      -- remove check
      AutoInviteConfig['sortComplete']=0;
      btnWisper:SetChecked(0);
   end
end

function autoInvite:sortCompleteListOnClick()
   autoInvite:debugMsg(this:GetName().." autoInvite:sortCompleteListOnClick "..this:GetID());

   local baseName=this:GetName();
   local btnSort = getglobal(baseName);
   local state=btnSort:GetChecked();
   if(state == 1) then
      autoInvite:debugMsg("Button was not selected, select it now");
      AutoInviteConfig['sortComplete']=1;
      btnSort:SetChecked(1);
   else
      autoInvite:debugMsg("Button was selected, unselect it now");
      AutoInviteConfig['sortComplete']=0;
      btnSort:SetChecked(0);
   end
end

function autoInvite:lockCompleteListOnLoad()
   local baseName="autoInviteMainConfigFrame";
   local btnWisper = getglobal(baseName.."CompleteListCheckButtonLockCompleteList");
   if(AutoInviteConfig['lockComplete']==1) then
      -- set check
      btnWisper:SetChecked(1);
   else
      -- remove check
      AutoInviteConfig['lockComplete']=0;
      btnWisper:SetChecked(0);
   end
end

function autoInvite:lockCompleteListOnClick()
   autoInvite:debugMsg(this:GetName().." autoInvite:lockCompleteListOnClick "..this:GetID());

   local baseName=this:GetName();
   local btnSort = getglobal(baseName);
   local state=btnSort:GetChecked();
   if(state == 1) then
      autoInvite:debugMsg("Button was not selected, select it now");
      AutoInviteConfig['lockComplete']=1;
      btnSort:SetChecked(1);
   else
      autoInvite:debugMsg("Button was selected, unselect it now");
      AutoInviteConfig['lockComplete']=0;
      btnSort:SetChecked(0);
   end
end

-- Trigger the online check function, send /who and use WoW Events to upate
-- the list which is player is online
function autoInvite:checkOnlineOfflineState()
   autoInvite:debugMsg("In function autoInvite:checkOnlineOfflineState");
   autoInvite:debugMsg("Enable the mod");
   autoInvite:switchPowerStatus();

   -- read information about player which are in the guild
   FriendsFrame:UnregisterEvent("GUILD_ROSTER_UPDATE");
   GuildRoster();
   FriendsFrame:RegisterEvent("GUILD_ROSTER_UPDATE");
   local guildCount=GetNumGuildMembers();
   -- go through guild list and mark players in the AutoInviteCompleteList if the are in the guild
   autoInvite:debugMsg("found "..guildCount.." guildmembers");
   for i=1, guildCount do
      local name, rank, rankIndex, level, class, zone, note, officernote, online, status = GetGuildRosterInfo(i);
      autoInvite:debugMsg("Check player "..name);
      local id=autoInvite:getId(AutoInviteCompleteList,name);
      if(id ~= 0) then
	 autoInvite:debugMsg("Player "..name.." is in the guild, flag him");
	 autoInvite.control['member'][name]['inGuild']=true;
	 if(online) then
	    autoInvite:debugMsg("Guildplayer "..name.." is online, set online flag");
	    autoInvite.control['member'][name]['online']=true;
	 end
      end
   end
   autoInvite:completeList_Update();

   if(IsAddOnLoaded("QueueWho")) then
      -- need to check if QueueWho is installed
      local max=table.getn(AutoInviteCompleteList);
      autoInvite.checkOnlineState=true;
      autoInvite.checkOnlineLastId=1;
      autoInvite.checkOnlineMaxId=0;

      for i=1, max do
	 local name=AutoInviteCompleteList[i]['name'];
	 if(autoInvite.control['member'][name]['inGuild']==false and AutoInviteCompleteList[i]['inGroup']==false) then
	    autoInvite:chatMsg(format(AUTO_INVITE_CHECK_ONLINE_STATUS_WITH_WHO,name));
	    autoInvite.checkOnlineMaxId=autoInvite.checkOnlineMaxId+1;
	    QueueWho:AddWhoRequest(name, autoInvite.getOnlineStatus, name);
	 end
      end
   else
      autoInvite:chatMsg(AUTO_INVITE_NEED_ADDON_QUEUE_WHO);
   end
   autoInvite:debugMsg("Finished autoInviteCheckOnlineOfflineState");
end

function autoInvite:getOnlineStatus(playerName)
   autoInvite:debugMsg("In function autoInvite:getOnlineStatus");
   
   if(autoInvite.CheckOnlineState) then
      if(playerName) then
	 autoInvite:debugMsg("Check Player "..playerName);
	 numWhos, totalCount=GetNumWhoResults();
	 autoInvite:debugMsg("Got "..numWhos.." results");
	 for i=1, numWhos do
	    autoInvite:debugMsg("Check i:"..i);
	    charname, guildname, level, race, class, zone, unknown = GetWhoInfo(i);
	    autoInvite:debugMsg("Compare "..charname.." with "..playerName);
	    if(charname and charname == playerName) then
	       autoInvite:debugMsg("Set online to true");
	       autoInvite.control['member'][playerName]['online']=true;
	    end
	 end
	 -- check if we reached the end or we need to check more players
	 autoInvite:debugMsg("Check if we need to trigger more events for the update check");
	 if(autoInvite.CheckOnlineLastId<autoInvite.CheckOnlineMaxId) then
	    autoInvite:debugMsg("Need more online checks, they are allready queued");
	    autoInvite.CheckOnlineLastId=autoInvite.CheckOnlineLastId+1;
	 else
	    autoInvite:chatMsg(AUTO_INVITE_DONE);
	    autoInvite.CheckOnlineState=false;
	 end
	 autoInvite:completeList_Update();
      end
   end
end

-- reset all values to default
function autoInvite:reset()
   autoInvite:debugMsg("In function autoInvite:reset()");
   AutoInviteCompleteList=nil;
   AutoInviteConfig=nil;
   AutoInviteSavedList=nil;
   
   autoInvite:init();
   autoInvite:clearDebug();
   AutoInviteConfig['ifWisper']=0;
   AutoInviteConfig['modActive']=0;
   AutoInviteConfig['sortComplete']=0;
   autoInvite:ifWisperOnLoad();
   local baseName="autoInviteMainConfigFrame";
   local btnActive = getglobal(baseName.."CheckButtonModActive");
   btnActive:SetChecked(0);
   autoInvite:sortCompleteListOnLoad();

   autoInvite:completeList_Update();
   autoInvite:buildGroups();
   autoInvite:chatMsg(AUTO_INVITE_ALL_SETTINGS_RESETED);
end

function autoInvite:importGuildMembers()
   GuildRoster();
   local name, rank, rankIndex, level, class, zone, note, officernote, online;
   local numGuildMembers = GetNumGuildMembers(true);
   local gname = GetGuildInfo("player");
   local num = 0;

   if (gname == nil or numGuildMembers == 0) then
      self:chatMsg("No guild members to add");
      -- DEFAULT_CHAT_FRAME:AddMessage("No guild members to add",0.3,0.3,1);
      return;
   end

   AutoInviteCompleteList={};
   autoInvite:resetControlObject();

   for i=1, numGuildMembers do
      local name, rank, rankIndex, level, eClass, zone, comment, officernote, online = GetGuildRosterInfo(i);

      AutoInviteCompleteList[i]={};
      AutoInviteCompleteList[i]['name']=name;
      AutoInviteCompleteList[i]['eClass']=strupper(eClass);
      AutoInviteCompleteList[i]['level']=tonumber(level);
      AutoInviteCompleteList[i]['comment']=comment;
      AutoInviteCompleteList[i]['inGroup']=false;
      AutoInviteCompleteList[i]['group']='-';

      if (not autoInvite.control.member[AutoInviteCompleteList[i]['name']]) then
	 autoInvite.control.member[AutoInviteCompleteList[i]['name']] = {};
      end

      autoInvite.control.member[AutoInviteCompleteList[i]['name']]['status']="unknown";
      autoInvite.control.member[AutoInviteCompleteList[i]['name']]['online']=false;
      autoInvite.control.member[AutoInviteCompleteList[i]['name']]['inGuild']=false;
      autoInvite.control.member[AutoInviteCompleteList[i]['name']]['lastChecked']=0;
      autoInvite.control.member[AutoInviteCompleteList[i]['name']]['errorMessage']="";
   end

   -- update groups
   autoInvite:buildGroups();
   autoInvite:completeList_Update();
   autoInvite:updateGroupCount();
   autoInvite:sortCompleteList();
   autoInvite:updateButton_OnClick();
end
