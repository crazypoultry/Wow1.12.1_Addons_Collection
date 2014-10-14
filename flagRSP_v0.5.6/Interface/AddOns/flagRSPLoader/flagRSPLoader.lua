
flagRSPLoader = {
   rName = nil,
   pName = nil,

   initalitzed = false,

   loadTick = 0,
   checked = false
};

flagRSPLoaderSettings = {};


function flagRSPLoader_OnLoad()
   this:RegisterEvent("PLAYER_ENTERING_WORLD");
   --this:RegisterEvent("ADDON_LOADED");

   SlashCmdList["RSPLOADER"] = flagRSPLoader.slashHandler;
   SLASH_RSPLOADER1 = "/rspload";
end


function flagRSPLoader_OnEvent(event)
   if event == "PLAYER_ENTERING_WORLD" then
      if not flagRSPLoader.initialized then
	 flagRSPLoader.printM(flagRSPLoader_Locale_Initializing);
	 
	 flagRSPLoader.rName = GetCVar("realmName");
	 flagRSPLoader.pName = UnitName("player");
	 
	 --flagRSPLoader.checkLoadConditions();

	 flagRSPLoader.loadTick = GetTime() + 1;

	 flagRSPLoader.initialized = true;
      end
   end
end


function flagRSPLoader_OnUpdate()
   if flagRSPLoader.loadTick ~= 0 and GetTime() > flagRSPLoader.loadTick and not flagRSPLoader.checked then
      flagRSPLoader.checkLoadConditions();
      flagRSPLoader.checked = true;
   end
end


function flagRSPLoader.slashHandler(msg)
   --flagRSPLoader.printM("You have entered: " .. msg);
   msg = string.lower(msg);

   if string.sub(msg,1,5) == "realm" then
      if flagRSPLoaderSettings[flagRSPLoader.rName] == nil then
	 flagRSPLoaderSettings[flagRSPLoader.rName] = {};
      end

      local submsg = string.sub(msg,7,string.len(msg));

      if submsg == "on" then
	 flagRSPLoaderSettings[flagRSPLoader.rName].load = true;
	 flagRSPLoader.printM(flagRSPLoader_Locale_RealmActivated);
	 flagRSPLoader.checkLoadConditions();
      elseif submsg == "off" then
	 flagRSPLoaderSettings[flagRSPLoader.rName].load = false;
	 flagRSPLoader.printM(flagRSPLoader_Locale_RealmDeactivated);
      end
   elseif string.sub(msg,1,4) == "char" then
      if flagRSPLoaderSettings[flagRSPLoader.rName] == nil then
	 flagRSPLoaderSettings[flagRSPLoader.rName] = {};
      end

      local submsg = string.sub(msg,6,string.len(msg));

      if submsg == "on" then
	 flagRSPLoaderSettings[flagRSPLoader.rName][flagRSPLoader.pName] = true;
	 flagRSPLoader.printM(flagRSPLoader_Locale_CharActivated);
	 flagRSPLoader.checkLoadConditions();
      elseif submsg == "off" then
	 flagRSPLoaderSettings[flagRSPLoader.rName][flagRSPLoader.pName] = false;
	 flagRSPLoader.printM(flagRSPLoader_Locale_CharDeactivated);
      end      
   elseif string.sub(msg,1,4) == "auto" then
      local submsg = string.sub(msg,6,string.len(msg));

      if submsg == "on" then
	 flagRSPLoaderSettings.autoload = true;
	 flagRSPLoader.printM(flagRSPLoader_Locale_GeneralActivated);
	 flagRSPLoader.checkLoadConditions();
      elseif submsg == "off" then
	 flagRSPLoaderSettings.autoload = false;
	 flagRSPLoader.printM(flagRSPLoader_Locale_GeneralDeactivated);
      end      
   elseif string.sub(msg,1,4) == "load" then
      flagRSPLoader.loadFlagRSP();
   else
      -- help.

      t = 1;
      while flagRSPLoader_Locale_Help[t] ~= nil do
	 flagRSPLoader.printM(flagRSPLoader_Locale_Help[t]);
	 t = t + 1;
      end
   end
end


--[[

flagRSPLoader.printM(msg)

-- Prints message msg in flagRSP style.

]]--
function flagRSPLoader.printM(msg)
   DEFAULT_CHAT_FRAME:AddMessage("|CFFFFFF7F<flagRSPLoader>|r " .. msg,1,1,1);
end


function flagRSPLoader.loadFlagRSP()
   flagRSPLoader.printM(flagRSPLoader_Locale_Loading);

   LoadAddOn("Friendlist");
   LoadAddOn("flagRSP");
end


function flagRSPLoader.checkLoadConditions()
   if IsAddOnLoaded("flagRSP") ~= 1 then
      local load = true;
      
      if flagRSPLoaderSettings.autoload ~= nil then
	 load = flagRSPLoaderSettings.autoload;
      end
      
      if flagRSPLoaderSettings[flagRSPLoader.rName] ~= nil and flagRSPLoaderSettings[flagRSPLoader.rName].load ~= nil then
	 load = flagRSPLoaderSettings[flagRSPLoader.rName].load;
      end
      
      if flagRSPLoaderSettings[flagRSPLoader.rName] ~= nil and flagRSPLoaderSettings[flagRSPLoader.rName][flagRSPLoader.pName] ~= nil then
	 load = flagRSPLoaderSettings[flagRSPLoader.rName][flagRSPLoader.pName];
      end
      
      if load then
	 flagRSPLoader.loadFlagRSP();
      end
   end
end