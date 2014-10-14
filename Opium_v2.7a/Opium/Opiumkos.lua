--[[
OPIUM (Opium Personal Identification User Manager)
An internal player database AddOn, by Oystein.
]]

local OPIUM_KOS_ITEMS_SHOWN = 19;
local lastAlert;
local kosSelected = nil;

local kosgListStats;
local currentSender;



function Opium_GetKoSFlag(id)

   if( not OpiumData.flags ) then
      return "KoS";
   end

   local default = OpiumData.flags[0];
   if( not default ) then
      default = "KoS";
   end

   if( not id or not OpiumData.flags[id]) then
      return default;
   end

   return OpiumData.flags[id].name;

end


function OpiumAddKosEntryFlagDropDown_OnClick()
   local oldID = UIDropDownMenu_GetSelectedID(OpiumAddKosEntryFlagDropDown);
   UIDropDownMenu_SetSelectedID(OpiumAddKosEntryFlagDropDown, this:GetID());
	
end


local function OpiumAddKosEntryFlagDropDown_Initialize()
  if( not OpiumData or not OpiumData.flags ) then
     return;
  end

	local info;
	for i = 1, getn(OpiumData.flags), 1 do
		info = { };
		info.text = OpiumData.flags[i].name;
		info.func = OpiumAddKosEntryFlagDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function OpiumAddKosEntryFlagDropDown_OnShow()
	UIDropDownMenu_Initialize(OpiumAddKosEntryFlagDropDown, OpiumAddKosEntryFlagDropDown_Initialize);
        UIDropDownMenu_SetSelectedID(OpiumAddKosEntryFlagDropDown, 1);
	UIDropDownMenu_SetWidth(80);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", OpiumAddKosEntryFlagDropDown)
end

function OpiumAddKosEntry(arg1, arg2, arg3)
   if( opiumKosCurrentList == 1 ) then
      OK_NameLabel:SetText(OPIUM_TEXT_GUILD);
   else
      OK_NameLabel:SetText(OPIUM_TEXT_KOS_PLAYER);
   end

   if( arg1 ) then
      OK_NameEditBox:SetText(arg1);
   end
   if( arg2 ) then
      OK_ReasonEditBox:SetText(arg2);
   end

   ShowUIPanel(OpiumKosAddFrame);

   if( arg3 ) then
      UIDropDownMenu_SetSelectedID(OpiumAddKosEntryFlagDropDown, arg3);
   else
      UIDropDownMenu_SetSelectedID(OpiumAddKosEntryFlagDropDown, 1);
   end


end


function OpiumKosShareReceiveFrame_Block()
   HideUIPanel(OpiumKosShareReceiveFrame);
   Sky.getNextMessage("Opium");
   
   if( currentSender ) then
      OpiumTempData.BlockedSenders[currentSender] = true;
   end

end


function OpiumKosShareReceiveFrameConfirm()
   HideUIPanel(OpiumKosShareReceiveFrame);
   local envelope = Sky.getNextMessage("Opium");
   local message = envelope.msg;
   local activeList, activeListName;

   if( not message ) then
      Opium_PrintMessage("Opium: Received an empty list!");
      return;
   end


   if( message.tabletype == 1 ) then
      activeList = OpiumData.kosGuild[realmName];
      activeListName = OPIUM_TEXT_KOSGUILDS;
   else
      activeList = OpiumData.kosPlayer[realmName];
      activeListName = OPIUM_TEXT_KOSPLAYERS;
   end
 
   message.tabletype = nil;

   if( message.version == 2 ) then
      message.version = nil;
      local i = 0;
      for index, value in message do
         if( not activeList[index] ) then
            i = i + 1;
	    activeList[index] = { };
            if( value[OPIUM_INDEX_REASON] ) then
   	       activeList[index][OPIUM_INDEX_REASON] = value[OPIUM_INDEX_REASON];
   	    end
            if( value[OPIUM_INDEX_FLAG] and OpiumData.flags[value[OPIUM_INDEX_FLAG]]) then
   	       activeList[index][OPIUM_INDEX_FLAG] = value[OPIUM_INDEX_FLAG];
   	    end
	 end
      end
   elseif( message.version == 1 ) then
      message.version = nil;
      local i = 0;
      for index, value in message do
         if( not activeList[index] ) then
            i = i + 1;
	    activeList[index] = { };
            if( value and value ~= "" and value ~= " ") then
   	       activeList[index][OPIUM_INDEX_REASON] = value;
   	    end
         end
      end

   else
      message("Your version of Opium is too old to receive this data.");
      return;
   end


   Opium_PrintMessage("Opium" .. ": " .. i .. " " .. OPIUM_TEXT_SHARE_NEW .. " " .. 
                         activeListName .. " " .. OPIUM_TEXT_SHARE_ADDED .. ".");


end


function OpiumKosShareReceiveFrame_Cancel()
   HideUIPanel(OpiumKosShareReceiveFrame);
   Sky.getNextMessage("Opium");
end


function OpiumAcceptanceTest(envelope)
   if ( envelope.type == SKY_PLAYER and envelope.target == "Opium" and 
        not OpiumKosShareReceiveFrame:IsVisible() and
	not OpiumData.config.blockallsends and
	not OpiumTempData.BlockedSenders[envelope.sender] and
	envelope.msg and envelope.msg.tabletype) then 

      local i = 0;
      for index, value in envelope.msg do
         i = i + 1;
      end

      local typename;
      if( envelope.msg.tabletype == 1 ) then
         typename = OPIUM_TEXT_SHARE_GUILDS;
      else
         typename = OPIUM_TEXT_SHARE_PLAYERS;
      end

      OKSR_TitleLabel:SetText(OPIUM_TEXT_SHARE_RECEIVECONFIRM .. " " .. envelope.sender .. 
                                 "? (" .. i-2 .. " " .. typename .. " " .. OPIUM_TEXT_SHARE_ENTRIES .. ")");



      ShowUIPanel(OpiumKosShareReceiveFrame);
      currentSender = envelope.sender;
      return true;

   else
      return false;
   end
end



function OpiumKosShareFrameConfirm()
   if( Sky ) then
      local target = OKS_NameEditBox:GetText();

      if( not target or target == "" ) then
         return;
      end

	if (Sky.isSkyUser(target)) then
	   local activeList;

	        if( opiumKosCurrentList == 1 ) then
        	   activeList = OpiumData.kosGuild[realmName];
	        else
         	   activeList = OpiumData.kosPlayer[realmName];
         	end

           activeList.tabletype = opiumKosCurrentList;
	   activeList.version = 2;

	   Sky.sendTable(activeList, SKY_PLAYER, "Opium", target);

	   activeList.tabletype = nil;
	   activeList.version = nil;

           Opium_PrintMessage(OPIUM_TEXT_SHARE_SENTTABLE .. " " .. target ..".");
	   HideUIPanel(OpiumKosShareFrame);
           OKS_NameEditBox:SetText("");
	else
  	   message(OPIUM_TEXT_SHARE_NOTSKYUSER1 ..  " " .. target .. " " .. OPIUM_TEXT_SHARE_NOTSKYUSER2);
        end
	
   end
end


function OpiumKosFrame_Share()
   if( Sky ) then
      ShowUIPanel(OpiumKosShareFrame);
   else
      message("You need Sky installed to share KoS lists!");
   end
end


function OpiumKosShareFrame_Cancel()
   HideUIPanel(OpiumKosShareFrame);
end




function Opium_KosgListStats()

   kosgListStats = { };

   for index, value in kosDisplayIndices do
      for index2, value2 in OpiumData.playerLinks[realmName] do
         if( value2[OPIUM_INDEX_GUILD] ) then
	    if( value == string.lower( string.gsub(value2[OPIUM_INDEX_GUILD], "%s", "_") ) ) then
               if(  not kosgListStats[index] ) then
                  kosgListStats[index]  = { };
	       end
	      
	       if( kosgListStats[index].m ) then
		  kosgListStats[index].m = kosgListStats[index].m + 1;
	       else
		  kosgListStats[index].m = 1;
	       end

	       if( value2[OPIUM_INDEX_WINS] ) then
	          if( kosgListStats[index].w ) then
		     kosgListStats[index].w = kosgListStats[index].w + value2[OPIUM_INDEX_WINS];
	          else
		     kosgListStats[index].w = value2[OPIUM_INDEX_WINS];
	          end
               end

	       if( value2[OPIUM_INDEX_LOSSES] ) then
	          if( kosgListStats[index].l ) then
		     kosgListStats[index].l = kosgListStats[index].l + value2[OPIUM_INDEX_LOSSES];
	          else
		     kosgListStats[index].l = value2[OPIUM_INDEX_LOSSES];
	          end
               end

	       if( not kosgListStats[index].f ) then
                  kosgListStats[index].f = value2[OPIUM_INDEX_FACTION];
	       end
	    end
	 end
      end

   end

end



function OpiumKosButton_OnEnter()

   local buttonID = this:GetID();
   local offset = buttonID + FauxScrollFrame_GetOffset(OpiumKosListScrollFrame)
   local name = kosDisplayIndices[offset];
   local stats;
   local tooltip;
   
   if( opiumKosCurrentList ~= 1 ) then
     if( OpiumData.playerLinks[realmName][name] ) then
        OpiumPlayerListTooltip(name);
	return;
     else
        tooltip = "|c00ffff00" .. opiumCapitalizeWords(name);
        tooltip = tooltip .. "|c00ffffff";
        local entry = OpiumData.kosPlayer[realmName][name];
        if( entry ) then
	   if( entry[OPIUM_INDEX_REASON] ) then
              tooltip = tooltip .. "\n" .. Opium_GetKoSFlag(entry[OPIUM_INDEX_FLAG]) .. " " 
	               .. OPIUM_TEXT_PLAYER .. ": " .. entry[OPIUM_INDEX_REASON];

	   else
              tooltip = tooltip .. "\n" .. Opium_GetKoSFlag(entry[OPIUM_INDEX_FLAG]) .. " " 
	               .. OPIUM_TEXT_PLAYER;
           end
        end
     end
    
   else


  
      tooltip = "|c00ffff00" .. opiumCapitalizeWords(string.gsub(name, "_", " "));

      tooltip = tooltip .. "|c00ffffff";

      local entry = OpiumData.kosGuild[realmName][name];
      if( entry ) then
         tooltip = tooltip .. "\n" .. Opium_GetKoSFlag(entry[OPIUM_INDEX_FLAG]) .. " " .. OPIUM_TEXT_GUILD;
      end

      if( kosgListStats ) then
         stats = kosgListStats[offset];
         if( stats ) then

            if( stats.m ) then
               tooltip = tooltip .. "\n" .. OPIUM_TEXT_KOS_MEMBERSSTORED .. ": " .. stats.m;
            end
            if( stats.w ) then
               tooltip = tooltip .. "\n" .. OPIUM_TEXT_KOS_KILLS .. ": " .. stats.w;
            end
            if( stats.l ) then
               tooltip = tooltip .. "\n" .. OPIUM_TEXT_KOS_DEATHS .. ": " .. stats.l;
            end
         end
      end
   end


   if( stats and stats.f ) then
      if( OPIUM_FACTIONINDEX[UnitFactionGroup("player")] == stats.f ) then
         GameTooltip:SetBackdropColor(0.2, 0.2, 1);
      else
         GameTooltip:SetBackdropColor(1, 0.2, 0.2);
      end
   end

   GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
   GameTooltip:SetText(tooltip);
   GameTooltip:Show();

end



function OpiumTargetKosPressed()
   if( IsShiftKeyDown() ) then
      return;
   end

   if( UnitExists("target") and UnitIsPlayer("target") ) then
      local playerName = string.lower(UnitName("target"));
      if( OpiumData.kosPlayer[realmName][playerName] == nil ) then
         OpiumData.kosPlayer[realmName][playerName] = { };
	 Opium_PrintMessage(UnitName("target") .. " " .. OPIUM_TEXT_KOS_ADDED);
      else
         OpiumData.kosPlayer[realmName][playerName] = nil;
         Opium_PrintMessage(UnitName("target") .. " " .. OPIUM_TEXT_KOS_REMOVED);
      end
      Opium_DrawTargetText();
   end
end



function Opium_DrawTargetText()
   OpiumTargetFrame.tooltip = nil;

   if( UnitExists("target") and UnitIsPlayer("target") )  then

      local playerName = string.lower(UnitName("target"));
      
      local guildName = GetGuildInfo("target");
      local guildlc;

      if( guildName ) then
         guildlc = string.gsub(string.lower(guildName), "%s", "_");
      end


      local kosp = OpiumData.kosPlayer[realmName][playerName];
      local kosg = OpiumData.kosGuild[realmName][guildlc];

      if(  kosp or kosg) then
         OpiumTargetText:SetText(OPIUM_TEXT_KOS);
	 OpiumTargetText:SetTextColor(1.0, 0.0, 0.0);
         OpiumTargetText:Show();

         if( kosp ) then
	    if( kosp[OPIUM_INDEX_FLAG] ) then
               OpiumTargetText:SetText(Opium_GetKoSFlag(kosp[OPIUM_INDEX_FLAG]));
	    end
	 
	    if( kosp[OPIUM_INDEX_REASON] ) then
	       OpiumTargetFrame.tooltip = OPIUM_TEXT_KOSPLAYER .. ": " .. kosp[OPIUM_INDEX_REASON];
	    else
               OpiumTargetFrame.tooltip = OPIUM_TEXT_KOSPLAYER;
	    end
         elseif( kosg ) then
	    if( kosg[OPIUM_INDEX_FLAG] ) then
               OpiumTargetText:SetText(Opium_GetKoSFlag(kosg[OPIUM_INDEX_FLAG]));
	    end

	    if( kosg[OPIUM_INDEX_REASON] ) then
	       OpiumTargetFrame.tooltip = OPIUM_TEXT_KOSGUILD .. ": " .. kosg[OPIUM_INDEX_REASON];
	    else
               OpiumTargetFrame.tooltip = OPIUM_TEXT_KOSGUILD;
	    end
	 
	 end

      else
         OpiumTargetText:Hide();
      end
      if( OpiumData.config.targetbutton ) then
         OpiumTargetKosFrame:Show();
      end
   else
      OpiumTargetText:Hide();
      OpiumTargetKosFrame:Hide();     
   end

end



function OpiumEditKosEntry()
   local activeList;

   if( kosSelected == nil ) then
      return
   end

   local name = kosDisplayIndices[kosSelected + FauxScrollFrame_GetOffset(OpiumKosListScrollFrame)];

        if( opiumKosCurrentList == 1 ) then
	   activeList = OpiumData.kosGuild[realmName];
	else
	   activeList = OpiumData.kosPlayer[realmName];
	end

   local entry = activeList[string.lower(name)];
   if( not entry ) then
      return;
   end

   local reason = entry[OPIUM_INDEX_REASON];
   local flag   = entry[OPIUM_INDEX_FLAG];

   if( reason == nil ) then
      reason = "";
   end

   OpiumAddKosEntry(opiumCapitalizeWords(string.gsub(name, "_", " ")), reason, flag);
end


function OpiumAddKosEntryFrame_Cancel()
   OK_NameEditBox:SetText("");
   OK_ReasonEditBox:SetText("");
   HideUIPanel(OpiumKosAddFrame);
end


function OpiumAddKosEntryConfirm()
   local name = OK_NameEditBox:GetText();
   local reason = OK_ReasonEditBox:GetText();
   local flag = UIDropDownMenu_GetSelectedID(OpiumAddKosEntryFlagDropDown);
   local activeList;

   if( name == "" ) then
      message(OPIUM_TEXT_KOS_NOSPECIFIED);
      return;
   end

   OK_NameEditBox:SetText("");
   OK_ReasonEditBox:SetText("");
   HideUIPanel(OpiumKosAddFrame);

   if( string.gsub(name, "%s+", "x") == "x" ) then
      message(OPIUM_TEXT_KOS_NEEDMORETHANSPACES);
      return;
   end

   local namelc = string.gsub(string.lower(name), "%s", "_");  

        if( opiumKosCurrentList == 1 ) then
	   activeList = OpiumData.kosGuild[realmName];
	else
	   activeList = OpiumData.kosPlayer[realmName];
	end

   activeList[namelc] = { };

   if( reason ~= "" ) then
      activeList[namelc][OPIUM_INDEX_REASON] = reason;
   end

   activeList[namelc][OPIUM_INDEX_FLAG] = flag;

   Opium_BuildKosDisplayIndices();
   Opium_KosUpdate();
   Opium_DrawTargetText();

end






function OpiumRemoveKosEntry()
   local activeList;

   if( kosSelected == nil ) then
      return
   end


   local name = kosDisplayIndices[kosSelected + FauxScrollFrame_GetOffset(OpiumKosListScrollFrame)];
 
   if( opiumKosCurrentList == 1 ) then
      activeList = OpiumData.kosGuild[realmName];
   else
      activeList = OpiumData.kosPlayer[realmName];
   end
   
   
   activeList[name] = nil;
   kosSelected = nil;
   Opium_BuildKosDisplayIndices();
   Opium_KosUpdate();
end


function OpiumKosFrame_Cancel()
   kosSelected = nil;
   HideUIPanel(OpiumKosFrame);
end


function OpiumKosItemButton_OnClick(arg1)
   local itemid = this:GetID();
   local newitemname = getglobal("OpiumKosItem" .. itemid .. "Name");
   local newitemreason = getglobal("OpiumKosItem" .. itemid .. "Reason");

  newitemname:SetTextColor(1.0, 0.0, 0.0);
  newitemreason:SetTextColor(1.0, 0.0, 0.0);

  if( kosSelected ~= nil and kosSelected ~= itemid) then
     local olditemname = getglobal("OpiumKosItem" .. kosSelected .. "Name");
     local olditemreason = getglobal("OpiumKosItem" .. kosSelected .. "Reason");

     olditemname:SetTextColor(1.0, 1.0, 0.0);
     olditemreason:SetTextColor(1.0, 1.0, 1.0);
  end

  kosSelected = itemid;

end



function Opium_KosUpdate()
   local iItem;
   local activeList;

   if( kosDisplayIndices == nil ) then
      Opium_BuildKosDisplayIndices();
   end

   if( kosDisplayIndices == nil ) then
      return;
   end

   kosSelected = nil;

        if( opiumKosCurrentList == 1 ) then
           OpiumKosTitleText:SetText(OPIUM_TEXT_KOSGUILDS);
	   activeList = OpiumData.kosGuild[realmName];
	else
           OpiumKosTitleText:SetText(OPIUM_TEXT_KOSPLAYERS);
	   activeList = OpiumData.kosPlayer[realmName];
	end



   FauxScrollFrame_Update(OpiumKosListScrollFrame, kosDisplayIndices.onePastEnd - 1, 
      OPIUM_KOS_ITEMS_SHOWN, OPIUM_ITEM_HEIGHT);

  

	for iItem = 1, OPIUM_KOS_ITEMS_SHOWN, 1 do
		local itemIndex = iItem + FauxScrollFrame_GetOffset(OpiumKosListScrollFrame);
		local kosItem = getglobal("OpiumKosItem" .. iItem);
		local kosEntryName = getglobal("OpiumKosItem" .. iItem .. "Name");
		local kosEntryReason = getglobal("OpiumKosItem" .. iItem .. "Reason");	

		if( itemIndex < kosDisplayIndices.onePastEnd ) then
			local name = kosDisplayIndices[itemIndex];
                        local reason = activeList[name][OPIUM_INDEX_REASON];

			kosEntryName:SetText(opiumCapitalizeWords(string.gsub(name, "_", " ")));
                        kosEntryReason:SetText( reason);
			kosEntryName:SetTextColor(1.0, 1.0, 0.0);
                        kosEntryReason:SetTextColor(1.0, 1.0, 1.0);
			
			kosItem:Show();
		else
			kosItem:Hide();
		end
	end
end



function Opium_BuildKosDisplayIndices()
	local iNew = 1;
        local activeList;

        if( OpiumData.kosPlayer == { } ) then
	   return;
	end

        if( opiumKosCurrentList == 1 ) then
	   activeList = OpiumData.kosGuild[realmName];
	else
	   activeList = OpiumData.kosPlayer[realmName];
	end

        FauxScrollFrame_SetOffset(OpiumKosListScrollFrame, 0);
	getglobal("OpiumKosListScrollFrameScrollBar"):SetValue(0);	


	kosDisplayIndices = { };
	for index, value in activeList do
              kosDisplayIndices[iNew] = index;
	      iNew = iNew + 1;
	end
	kosDisplayIndices.onePastEnd = iNew;
        table.setn(kosDisplayIndices, iNew - 1);
	table.sort(kosDisplayIndices);
end



function ToggleOpiumKosg()
   if( OpiumKosFrame:IsVisible() and opiumKosCurrentList == 1) then
      HideUIPanel(OpiumKosFrame);
   else
      opiumKosCurrentList = 1;
      Opium_BuildKosDisplayIndices();
      Opium_KosgListStats();
      Opium_KosUpdate();
      ShowUIPanel(OpiumKosFrame);
   end
end


function ToggleOpiumKosp()
   if( OpiumKosFrame:IsVisible() and opiumKosCurrentList == 2) then
      HideUIPanel(OpiumKosFrame);
   else
      opiumKosCurrentList = 2;
      Opium_BuildKosDisplayIndices();
      Opium_KosUpdate();
      ShowUIPanel(OpiumKosFrame);
   end
end


function Opium_KospCommandHandler(msg)
   local player, reason = unpack(opiumSplit(msg, ","));
   local playerlc;

   if( string.gsub(msg, "%s+", "x") == "x" ) then
      Opium_PrintMessage(OPIUM_TEXT_KOS_NEEDMORETHANSPACES);
      return;
   end

   if( player ) then
      playerlc = string.gsub(string.lower(player), "%s+", "");
   end

   if( player and reason ) then
      Opium_PrintMessage(opiumCapitalizeWords(player) .. " " .. OPIUM_TEXT_KOS_ISNOWKOS .. " " .. reason);
      Opium_PrintMessage(playerlc .. ": " .. reason);
      OpiumData.kosPlayer[realmName][ playerlc ] = { };
      OpiumData.kosPlayer[realmName][ playerlc ][OPIUM_INDEX_REASON] = reason;
   elseif( player and not reason ) then
     if( OpiumData.kosPlayer[realmName][ playerlc ] ) then
         OpiumData.kosPlayer[realmName][ playerlc ] = null;
	 Opium_PrintMessage(opiumCapitalizeWords(player) .. " " .. OPIUM_TEXT_KOS_NOLONGER);
      else
         OpiumData.kosPlayer[realmName][ playerlc ] = { };
	 Opium_PrintMessage(opiumCapitalizeWords(player) .. " " .. OPIUM_TEXT_KOS_ISKOSNOW);
      end
   elseif( not player and not reason ) then

      ToggleOpiumKosp();

   end
   
end



function Opium_KosgCommandHandler(msg)
  local guild, reason = unpack(opiumSplit(msg, ","));

  
   if( string.gsub(msg, "%s+", "x") == "x" ) then
      Opium_PrintMessage(OPIUM_TEXT_KOS_NEEDMORETHANSPACES);
      return;
   end

   if( guild ) then 
      guildlc = string.gsub(string.lower(guild), "%s", "_");  
   end
   

   if( guild and reason ) then
      Opium_PrintMessage(guild .. " " .. OPIUM_TEXT_KOS_ISNOWKOS .. " " .. reason);
      OpiumData.kosGuild[realmName][ guildlc ] = { };
      OpiumData.kosGuild[realmName][ guildlc ][OPIUM_INDEX_REASON] = reason;
   elseif( guild and not reason ) then
      if( OpiumData.kosGuild[realmName][ guildlc ] ) then
         OpiumData.kosGuild[realmName][ guildlc ] = null;
	 Opium_PrintMessage(guild .. " " .. OPIUM_TEXT_KOS_NOLONGER);
      else
         OpiumData.kosGuild[realmName][ guildlc ] = { };
	 Opium_PrintMessage(guild .. " " .. OPIUM_TEXT_KOS_ISKOSNOW);
      end
   elseif( not guild and not reason ) then
      ToggleOpiumKosg();

   end
 
end


function OpiumAlerts(target)
   if( UnitExists(target) and UnitIsPlayer(target) )  then
      local playerName = UnitName(target);
      local playerlc = string.lower(playerName);
      
      local guildName = GetGuildInfo(target);
      local guildlc;

      if( OpiumData.config.alertsonlyonenemy ) then
         if( UnitFactionGroup("player") == UnitFactionGroup(target) ) then
	    return;
	 end
      end


      if( guildName ) then
         guildlc = string.gsub(string.lower(guildName), "%s", "_");
      end

      local kosp = OpiumData.kosPlayer[realmName][playerlc];
      local kosg = OpiumData.kosGuild[realmName][guildlc];

      if( playerlc ~= opiumLastAlert ) then
         if(OpiumData.config.textalert ) then
            if( kosp ) then
	       if( kosp[OPIUM_INDEX_REASON] ) then
                       UIErrorsFrame:AddMessage(playerName .. " " ..  
		           Opium_GetKoSFlag(kosp[OPIUM_INDEX_FLAG]) .. ": " .. 
		          kosp[OPIUM_INDEX_REASON],   1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);

	       else
         	       UIErrorsFrame:AddMessage(playerName .. " " .. 
		          Opium_GetKoSFlag(kosp[OPIUM_INDEX_FLAG]), 
              	           1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
	       end
            elseif( kosg) then
	       if( kosg[OPIUM_INDEX_REASON] ) then
                  UIErrorsFrame:AddMessage(playerName .. " " .. OPIUM_TEXT_OF .. " " .. guildName .. 
		                   " " .. Opium_GetKoSFlag(kosg[OPIUM_INDEX_FLAG]) 
				   .. ": " .. kosg[OPIUM_INDEX_REASON], 
                	           1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);

	       else
                  UIErrorsFrame:AddMessage(playerName .. " " .. OPIUM_TEXT_OF .. " " .. guildName .. 
		                  " " .. Opium_GetKoSFlag(kosg[OPIUM_INDEX_FLAG]), 
                	           1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);

  	       end
            end
	 end

         if( OpiumData.config.soundalert and (kosp or kosg) ) then
            PlaySound("AuctionWindowOpen");
   	 end
         opiumLastAlert = playerlc; 
      end
   end
end



function Opium_DrawTooltip()

   if( not UnitIsPlayer("mouseover") ) then
      return;
   end
   
   local player = UnitName("mouseover");
   local playerlc = string.lower(player);
   local entry = OpiumData.kosPlayer[realmName][ playerlc ];
   local guildName = GetGuildInfo("mouseover");

   if( OpiumData.config.trackpvpstats ) then
      local name = GameTooltipTextLeft1:GetText();
      if( OpiumData.playerLinks[realmName] ) then
         name = name .. " " .. Opium_PvPStats(OpiumData.playerLinks[realmName][playerlc]);
      end
      GameTooltipTextLeft1:SetText(name);

   end


   if( guildName and OpiumData.config.guilddisplay ) then
   
      if(GameTooltipTextLeft3:GetText() == "PvP") then
         GameTooltipTextLeft3:SetTextColor(1.0, 1.0, 1.0);
         GameTooltipTextLeft3:SetText("<" .. guildName .. ">");
      elseif( GameTooltipTextLeft3:GetText() == nil ) then 
         GameTooltip:AddLine("<" .. guildName .. ">", 1.0, 1.0, 1.0);
      end
    
   end
 


   

      if( entry ) then
         if( entry[OPIUM_INDEX_REASON] ) then
            GameTooltip:AddLine(OPIUM_TEXT_PLAYER .. " " .. Opium_GetKoSFlag(entry[OPIUM_INDEX_FLAG]) ..
	            ": " .. entry[OPIUM_INDEX_REASON], 1.0, 1.0, 1.0);
         else
            GameTooltip:AddLine(OPIUM_TEXT_PLAYER .. " " .. Opium_GetKoSFlag(entry[OPIUM_INDEX_FLAG]), 1.0, 1.0, 1.0);
         end

      end

      
      if( guildName ) then 
         guildlc = string.gsub(string.lower(guildName), "%s", "_");
         entry = OpiumData.kosGuild[realmName][ guildlc ];

         if( entry ) then
            if( entry[OPIUM_INDEX_REASON] ) then
               GameTooltip:AddLine(OPIUM_TEXT_GUILD .. " " .. Opium_GetKoSFlag(entry[OPIUM_INDEX_FLAG])
	              .. ": " .. entry[OPIUM_INDEX_REASON], 1.0, 1.0, 1.0);
            else
               GameTooltip:AddLine(OPIUM_TEXT_GUILD .. " " .. Opium_GetKoSFlag(entry[OPIUM_INDEX_FLAG]),
	                  1.0, 1.0, 1.0);
            end

         end
      end


      OpiumAlerts("mouseover");


      GameTooltip:Show();

end




