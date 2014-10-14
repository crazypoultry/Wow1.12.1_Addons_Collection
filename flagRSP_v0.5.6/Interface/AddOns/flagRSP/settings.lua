--[[

settings.lua

- flagRSP setting file. Keeps default values and methods to handle settings.

]]--

FlagRSPSettings = {};
FlagRSPConfigure = {
   loaded = false;
};

-- default settings.
FlagRSPSettings[0] = {};
FlagRSPSettings[0][0] = {};



--[[

FlagRSPConfigure_IsInitialized()

- check if game is initialized.

]]--
function FlagRSPConfigure_IsInitialized()

   playerName=UnitName("player");
   realmName=GetCVar("realmName");
   initialized = true;

   --if playerName ~= nil then
   --   DEFAULT_CHAT_FRAME:AddMessage("DEBUG: Friendlist: playerName: " .. playerName, 1.0, 1.0, 0.0);
   --end

   if FlagRSPConfigure == nil then
      initialized = false;
   end
   if (playerName == nil) or (realmName == nil) or (playerName == UNKNOWNOBJECT) or (playerName == UKNOWNBEING) then
      initialized = false;
   end

   FlagRSP.pName=UnitName("player");
   FlagRSP.rName=GetCVar("realmName");
   
   return initialized;
end

--[[

FlagRSPConfigure.isInitialized()

- check if game is initialized.

]]--
function FlagRSPConfigure.isInitialized()
   return FlagRSPConfigure_IsInitialized()
end

--[[

FlagRSPConfigure.initializeSettings()

- initialize settings for current player.

]]--
function FlagRSPConfigure.initializeSettings()
   if not FlagRSPConfigure.isInitialized() then
      return "";
   end
   
   FlagRSP.pName=UnitName("player");
   FlagRSP.rName=GetCVar("realmName");
   
   if FlagRSPConfigure.loaded == false then

      FlagRSPSettings[0][0].InfoBoxX = 0;
      FlagRSPSettings[0][0].InfoBoxY = 400;
      FlagRSPSettings[0][0].InfoBoxAlphaBackdrop = 0.3;
      FlagRSPSettings[0][0].displayInfoBox = true;
      FlagRSPSettings[0][0].InfoBoxWidth = 300;
      FlagRSPSettings[0][0].InfoBoxTextSize = 12;
      FlagRSPSettings[0][0].InfoBoxExpandUpwards = true;
      FlagRSPSettings[0][0].InfoBoxLocked = false;
      FlagRSPSettings[0][0].InfoBoxAutoPopUp = true;

      FlagRSPSettings[0][0].CharDesc = "";
      FlagRSPSettings[0][0].CharDescRev = 0;

      -- New flags that are saved per character and per realm.
      FlagRSPSettings[0][0].Surname = "";
      FlagRSPSettings[0][0].Title = "";
      FlagRSPSettings[0][0].RPFlag = 0;
      FlagRSPSettings[0][0].CharStatus = "none";

      -- dummy flags to see if old flags have already been copied into new ones.
      FlagRSPSettings[0][0].SurnameConv = false;
      FlagRSPSettings[0][0].TitleConv = false;
      FlagRSPSettings[0][0].RPFlagConv = false;
      FlagRSPSettings[0][0].CharStatusConv = false;

      -- New options that are saved per character and per realm.
      FlagRSPSettings[0][0].nameChange = false;
      FlagRSPSettings[0][0].levelChange = false;
      FlagRSPSettings[0][0].showRanks = true;
      FlagRSPSettings[0][0].showGuilds = -1;
      
      -- dummy options to see if old options have already been copied into new ones.
      FlagRSPSettings[0][0].nameChangeConv = false;
      FlagRSPSettings[0][0].nevelChangeConv = false;
      FlagRSPSettings[0][0].showRanksConv = false;
      FlagRSPSettings[0][0].showGuildsConv = false;

      -- how many seconds are flags saved (default 14 days).
      if FlagRSPSettings.FlagPurgeInterval == nil then
	 --FlagRSP.printM("setting purge interval to inital value");
	 FlagRSPSettings.FlagPurgeInterval = 1209600;
      end

      FlagRSPSettings[0][0].SkinnableFancy = false;

      FlagRSPSettings[0][0].ShowVersionNotification = true;
      FlagRSPSettings[0][0].ShowTips = true;

      FlagRSPSettings[0][0].showFriendlistEntryBox = true;
      FlagRSPSettings[0][0].FriendlistEntryBoxLocked = false;

      FlagRSPSettings[0][0].FriendlistSortOrder = "FLSorting_onlineCompSurname";

      FlagRSPSettings[0][0].InfoBoxButtonX = -1;
      FlagRSPSettings[0][0].InfoBoxButtonY = -1;

      FlagRSPSettings[0][0].alwaysShowInfoBox = false;

      FlagRSPSettings[0][0].modifyTooltip = 1;

      FlagRSPSettings[0][0].numOnlineList = {};
      FlagRSPSettings[0][0].numOnlineList.position = 1;
      FlagRSPSettings[0][0].numOnlineList[1] = 0;
      FlagRSPSettings[0][0].numOnlineList[2] = 0;
      FlagRSPSettings[0][0].numOnlineList[3] = 0;
      FlagRSPSettings[0][0].numOnlineList[4] = 0;
      FlagRSPSettings[0][0].numOnlineList[5] = 0;
      FlagRSPSettings[0][0].numOnlineList[6] = 0;
      FlagRSPSettings[0][0].numOnlineList[7] = 0;
      FlagRSPSettings[0][0].numOnlineList[8] = 0;
      FlagRSPSettings[0][0].numOnlineList[9] = 0;
      FlagRSPSettings[0][0].numOnlineList[10] = 0;

      FlagRSPSettings[0][0].standby = false;
      
      if FlagRSPSettings[FlagRSP.rName] == nil then
	 FlagRSPSettings[FlagRSP.rName] = {};
      end
      if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName] == nil then
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName] = {};
      end

      if FlagRSPInfoBoxList[FlagRSP.rName] == nil then
	 FlagRSPInfoBoxList[FlagRSP.rName] = {};
      end
      if FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName] == nil then
	 FlagRSPInfoBoxList[FlagRSP.rName][FlagRSP.pName] = {};
      end
      
      for option,value in FlagRSPSettings[0][0] do
	 --FlagRSP.print(option);
	 if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName][option] == nil then
	    --FlagRSP.print("Option (is nil, will become): " .. option .. ", value: " .. value);	 
	    FlagRSPSettings[FlagRSP.rName][FlagRSP.pName][option] = value;
	 else
	    --FlagRSP.print("Option (is not nil): " .. option .. ", value: " .. FlagRSPSettings[FlagRSP.rName][FlagRSP.pName][option]);	 
	 end
      end

      TooltipHandler.buildSkinnableTable();
      FlagRSPInfo.purgeBoxList()
      FlagRSPConfigure.loadCustoms();

      -- purge cached flags.
      FlagHandler.purgeFlags();

      -- some stuff...
      FlagRSPInfo.maxDesc = math.ceil(FlagRSPInfo.maxDescChars/FlagRSPInfo.charPerPost);
      
      FlagRSPConfigure.loaded = true;

      -- convert old settings.
      if flagRSP_CharStatus[FlagRSP.pName] == "" then
	 flagRSP_CharStatus[FlagRSP.pName] = "none";
      end

      if FlagRSP ~= nil and Friendlist ~= nil then
	 if FlagRSPSettings.welcomeBoxShown == nil then
	    FlagRSPSettings.welcomeBoxShown = {};
	    
	    FlagRSPSettings.welcomeBoxShown.version = FlagRSP.versionString;
	    FlagRSPSettings.welcomeBoxShown.shown = true;
	    
	    FlagRSP.showWelcomeBox(true);
	 elseif FlagRSPSettings.welcomeBoxShown.version ~= FlagRSP.versionString then
	    FlagRSPSettings.welcomeBoxShown.version = FlagRSP.versionString;
	    FlagRSPSettings.welcomeBoxShown.shown = true;
	    
	    FlagRSP.showWelcomeBox(false);
	 else
	    if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].ShowTips then
	       FlagRSP.showDYKBox();
	    end
	 end
      end

      --FlagRSPSettings.welcomeBoxShown = nil;

      -- convert old surname, title and other flags.
      if not FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].SurnameConv then
	 if xTP_CustomTag[FlagRSP.pName] ~= nil and xTP_CustomTag[FlagRSP.pName] ~= "" then
	    FlagRSP.printM("Surname \"" .. xTP_CustomTag[FlagRSP.pName] .. "\" is being converted into new format.");
	    FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].Surname = xTP_CustomTag[FlagRSP.pName];
	 end
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].SurnameConv = true;
      end
      if not FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].TitleConv then
	 if xTP_CustomTag2[FlagRSP.pName] ~= nil and xTP_CustomTag2[FlagRSP.pName] ~= "" then
	    FlagRSP.printM("Title \"" .. xTP_CustomTag2[FlagRSP.pName] .. "\" is being converted into new format.");
	    FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].Title = xTP_CustomTag2[FlagRSP.pName];
	 end
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].TitleConv = true;
      end
      if not FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].RPFlagConv then
	 if xTP_RPTag[FlagRSP.pName] ~= nil then
	    FlagRSP.printM("RP flag is being converted into new format.");
	    FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].RPFlag = xTP_RPTag[FlagRSP.pName];
	 end
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].RPFlagConv = true;
      end
      if not FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharStatusConv then
	 if flagRSP_CharStatus[FlagRSP.pName] ~= nil then
	    FlagRSP.printM("Character status is being converted into new format.");
	    FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharStatus = flagRSP_CharStatus[FlagRSP.pName];
	 end
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharStatusConv = true;
      end

      if not FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].nameChangeConv then
	 if xTP_NameChange[FlagRSP.pName] ~= nil then
	    FlagRSP.printM("Name changing option is being converted into new format.");

	    if xTP_NameChange[FlagRSP.pName] == 0 then
	       FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].nameChange = false;
	    else
	       FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].nameChange = true;
	    end
	 end
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].nameChangeConv = true;
      end
      if not FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].levelChangeConv then
	 if xTP_LevelChange[FlagRSP.pName] ~= nil then
	    FlagRSP.printM("Level changing option is being converted into new format.");

	    if xTP_LevelChange[FlagRSP.pName] == 0 then
	       FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].levelChange = false;
	    else
	       FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].levelChange = true;
	    end
	 end
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].levelChangeConv = true;
      end
      if not FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showRanksConv then
	 if flagRSP_ShowRanks[FlagRSP.pName] ~= nil then
	    FlagRSP.printM("Rank display option is being converted into new format.");

	    if flagRSP_ShowRanks[FlagRSP.pName] == 0 then
	       FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showRanks = false;
	    else
	       FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showRanks = true;
	    end
	 end
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showRanksConv = true;
      end
      if not FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showGuildsConv then
	 if flagRSP_ShowGuild[FlagRSP.pName] ~= nil then
	    FlagRSP.printM("Guild display option is being converted into new format.");

	    if flagRSP_ShowGuild[FlagRSP.pName] == 0 then
	       FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showGuilds = -1;
	    else
	       FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showGuilds = 1;
	    end
	 end
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showGuildsConv = true;
      end
      
      -- set old variables with those flags to maintain downward compatibility.
      xTP_CustomTag[FlagRSP.pName] = FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].Surname;
      xTP_CustomTag2[FlagRSP.pName] = FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].Title;
      xTP_RPTag[FlagRSP.pName] = FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].RPFlag;
      flagRSP_CharStatus[FlagRSP.pName] = FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].CharStatus;
      
      if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].nameChange then
	 xTP_NameChange[FlagRSP.pName] = 1;
      else
	 xTP_NameChange[FlagRSP.pName] = 0;
      end
      if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].levelChange then
	 xTP_LevelChange[FlagRSP.pName] = 1;
      else
	 xTP_LevelChange[FlagRSP.pName] = 0;
      end
      if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showRanks then
	 flagRSP_ShowRanks[FlagRSP.pName] = 1;
      else
	 flagRSP_ShowRanks[FlagRSP.pName] = 0;
      end
      if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].showGuilds == 1 then
	 flagRSP_ShowGuild[FlagRSP.pName] = 1;
      else
	 flagRSP_ShowGuild[FlagRSP.pName] = 0;
      end

      if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].modifyTooltip == true then
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].modifyTooltip = 1;
      end
      if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].modifyTooltip == false then
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].modifyTooltip = -1;
      end

      if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].numOnlineList[FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].numOnlineList.position] > 0 then
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].numOnlineList.position = FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].numOnlineList.position + 1;
      end

      if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].numOnlineList.position > 10 then
	 FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].numOnlineList.position = 1;
      end

      local avgOnline = 0;
      local numList = 0;

      for i=1, 10 do
	 if FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].numOnlineList[i] ~= 0 then
	    numList = numList + 1;
	    avgOnline = avgOnline + FlagRSPSettings[FlagRSP.rName][FlagRSP.pName].numOnlineList[i];
	 end
      end

      if numList > 0 then
	 avgOnline = avgOnline / numList;
	 --FlagRSP.printM("Average max of online users: " .. avgOnline);
      end
      
      if avgOnline > 0 then
	 FlagRSP.postInterval = FlagRSP.maxPostingCost * avgOnline / FlagRSP.postingTargetBps;
	 FlagRSP.postIntervalHigh = FlagRSP.maxPostingCostHigh * avgOnline / FlagRSP.postingTargetBpsHigh;
      end

      --FlagRSP.printM("post interval: " .. FlagRSP.postInterval);
      --FlagRSP.printM("post interval (high): " .. FlagRSP.postIntervalHigh);
   end
end


--[[

FlagRSPConfigure.loadCustoms()

- User custom settings as long as there is no GUI.

]]--
function FlagRSPConfigure.loadCustoms()
--[[

Put your individual settings here as long as there is no GUI available.

To do so just copy one or more settings from the function 
FlagRSPConfigure.initializeSettings() above into this function. Then all you
have to do is replace the first 0 with your realm's name in "". The second 0
is for your player's name, also in "".

After the = set your wanted option. 

Note: If you just want the options as above (with the 0s) you don't have to
change anything. These settings are default settings. Only if you want to 
change them you have to set them here.

Examples:

-- Disable the InfoBox completely.
FlagRSPSettings["Your realms's name"]["Your player's name"].displayInfoBox = false;

-- Change width of InfoBox.
FlagRSPSettings["Cenarion Circle"]["Gurzilma"].InfoBoxWidth = 500;

-- Lock the InfoBox so you don't move it accidentally.
FlagRSPSettings["Aszshara"]["Ogrothok"].InfoBoxLocked = true;

-- Make the skinnable line's colour fancy.
FlagRSPSettings["Uther"]["Caelindia"].SkinnableFancy = true;

]]--

end