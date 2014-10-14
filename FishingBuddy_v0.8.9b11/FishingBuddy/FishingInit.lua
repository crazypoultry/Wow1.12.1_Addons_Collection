-- FishingBuddy
--
-- Everything you wanted support for in your fishing endeavors

local gotSetupDone = false;
local lastVersion;
local playerName;
local realmName;

local DEFAULT_MINIMAP_POSITION = 256;

local function tablecount(tab)
   local n = 0;
   for k,v in pairs(tab) do
      n = n + 1;
   end
   return n;
end
FishingBuddy.tablecount = tablecount;

FishingBuddy.IsLoaded = function()
   return gotSetupDone;
end

-- if the old information is still there, then we might not have per
-- character saved info, so let's save it away just in case. It'll go
-- away the second time we load the add-on
FishingBuddy.SavePlayerInfo = function()
   if ( FishingBuddy_Info[realmName] and
        FishingBuddy_Info[realmName]["Settings"] and
        FishingBuddy_Info[realmName]["Settings"][playerName] ) then
      local tabs = { "Settings", "Outfit", "WasWearing" };
      for _,tab in pairs(tabs) do
	 for k,v in pairs(FishingBuddy_Player[tab]) do
	    FishingBuddy_Info[realmName][tab][playerName][k] = v;
	 end
      end
   end
end

local FishingInit = {};

-- Fill in the player name and realm
FishingInit.SetupNameInfo = function()
   playerName = UnitName("player");
   realmName = GetRealmName();
   return playerName, realmName;
end

FishingInit.CheckPlayerInfo = function()
   local tabs = { "Settings", "Outfit", "WasWearing" };
   if ( not FishingBuddy_Player ) then
      FishingBuddy_Player = {};
      for _,tab in pairs(tabs) do
	 FishingBuddy_Player[tab] = { };
      end
      if ( FishingBuddy_Info[realmName] and
	   FishingBuddy_Info[realmName]["Settings"] and
	   FishingBuddy_Info[realmName]["Settings"][playerName] ) then
	 for _,tab in pairs(tabs) do
	    if ( FishingBuddy_Info[realmName][tab] and
		 FishingBuddy_Info[realmName][tab][playerName] ) then
	       for k,v in pairs(FishingBuddy_Info[realmName][tab][playerName]) do
		  FishingBuddy_Player[tab][k] = v;
	       end
	    end
	 end
      end
   elseif ( FishingBuddy_Info[realmName] and
	   FishingBuddy_Info[realmName]["Settings"] ) then
      -- the saved information is there, kill the old stuff
      for _,tab in pairs(tabs) do
	 if ( FishingBuddy_Info[realmName][tab] ) then
	    FishingBuddy_Info[realmName][tab][playerName] = nil;
	    -- Duh, table.getn doesn't work because there
	    -- aren't any integer keys in this table
	    if ( next(FishingBuddy_Info[realmName][tab]) == nil ) then
	       FishingBuddy_Info[realmName][tab] = nil;
	    end
	 end
      end
      if ( next(FishingBuddy_Info[realmName]) == nil ) then
	 FishingBuddy_Info[realmName] = nil;
      end
   end
end

FishingInit.CheckPlayerSetting = function(setting, defaultvalue)
   if ( not FishingBuddy_Player["Settings"] ) then
      FishingBuddy_Player["Settings"] = { };
   end
   if ( not FishingBuddy_Player["Settings"][setting] ) then
      FishingBuddy_Player["Settings"][setting] = defaultvalue;
   end
end

FishingInit.CheckGlobalSetting = function(setting, defaultvalue)
   if ( not FishingBuddy_Info[setting] ) then
      if ( not defaultvalue ) then
	 FishingBuddy_Info[setting] = {};
      else
	 FishingBuddy_Info[setting] = defaultvalue;
      end
   end
end

FishingInit.CheckRealm = function()
   local tabs = { "Settings", "Outfit", "WasWearing" };
   for _,tab in pairs(tabs) do
      if ( FishingBuddy_Info[tab] ) then
	 local old = FishingBuddy_Info[tab][playerName];
	 if ( old ) then
	    if ( not FishingBuddy_Info[realmName] ) then
	       FishingBuddy_Info[realmName] = { };
	       for _,tab in pairs(tabs) do
		  FishingBuddy_Info[realmName][tab] = { };
	       end
	    end

	    FishingBuddy_Info[realmName][tab][playerName] = { };
	    for k, v in pairs(old) do
	       FishingBuddy_Info[realmName][tab][playerName][k] = v;
	    end
	    FishingBuddy_Info[tab][playerName] = nil;
	 end

	 -- clean out cruft, if we have some
	 FishingBuddy_Info[tab][UNKNOWNOBJECT] = nil;
	 FishingBuddy_Info[tab][UKNOWNBEING] = nil;

	 -- Duh, table.getn doesn't work because there
	 -- aren't any integer keys in this table
	 if ( next(FishingBuddy_Info[tab]) == nil ) then
	    FishingBuddy_Info[tab] = nil;
	 end
      end
   end
end

FishingInit.SetupZoneMapping = function()
   local continentNames = { GetMapContinents() };
   if ( not FishingBuddy_Info["ZoneIndex"] ) then
      FishingBuddy_Info["ZoneIndex"] = {};
      for idx,name in pairs(continentNames) do
         local zones = { GetMapZones(idx) };
         for jdx,zone in pairs(zones) do
            tinsert(FishingBuddy_Info["ZoneIndex"], zone);
         end
      end
   end
   if ( not FishingBuddy_Info["SubZones"] ) then
	    FishingBuddy_Info["SubZones"] = {};
   end
end

FishingInit.UpdateFishingDB1 = function()
   local version = FishingBuddy_Info["Version"];
   if ( not version ) then
      version = 7700; -- be really old
   end

   if ( FishingBuddy_Info["FishingHoles"] ) then
      if ( version < 8300 ) then
         -- handle a beta bug where we missed that GetSubZoneText() returns "" and not nil
         for zone in pairs(FishingBuddy_Info["FishingHoles"]) do
	    if ( FishingBuddy_Info["FishingHoles"][zone][""] ) then
	       if ( not FishingBuddy_Info["FishingHoles"][zone][zone] ) then
	          FishingBuddy_Info["FishingHoles"][zone][zone] = { };
	       end
	       for k,v in pairs(FishingBuddy_Info["FishingHoles"][zone][""]) do
	          FishingBuddy_Info["FishingHoles"][zone][zone][k] = v;
	       end
	       FishingBuddy_Info["FishingHoles"][zone][""] = nil;
	    end
         end
      end

      if ( version < 8503 ) then
         local fh = FishingBuddy_Info["FishingHoles"];
         local ff = FishingBuddy_Info["Fishies"];
         for zone in pairs(fh) do
	    for subzone in pairs(fh[zone]) do
	       local crap = {};
	       for fishie in pairs(fh[zone][subzone]) do
	          if ( type(fishie) == "string" ) then
	             tinsert(crap, fishie);
	          end
	       end
	       for _,fishie in pairs(crap) do
	          if ( ff[fishie] ) then
		     local item = ff[fishie].item;
		     if ( item ) then
		        local _,_,id = string.find(item, "^(%d+):");
		        id = id + 0;
		        fh[zone][subzone][id] = fh[zone][subzone][fishie];
		        fh[zone][subzone][fishie] = nil;
		        end
	          end
	       end
	    end
         end
         local fishes = {};
         for fishie in pairs(ff) do
            if ( type(fishie) == "string" ) then
	           tinsert(fishes, fishie);
	        end
         end
         for _,fishie in pairs(fishes) do
	    local item = ff[fishie].item;
	    if ( item ) then
	       local _,_,id = string.find(item, "^(%d+):");
	       id = id + 0;
	       ff[id] = {};
	       ff[id].name = fishie;
	       for k,v in pairs(ff[fishie]) do
	          if ( k ~= "item" ) then
	             ff[id][k] = v;
	          end
           end
	       ff[fishie] = nil;
	    end
         end
      --    tracking information
         if ( FishingBuddy_Info and FishingBuddy_Info["FishTracking"] ) then
            local ft = FishingBuddy_Info["FishTracking"];
            for how in pairs(ft) do
	       local fishes = {};
	       for item in pairs(ft[how]) do
              if ( type(item) == "string" ) then
	             tinsert(fishes, item);
	          end
	       end
	       for _,item in pairs(fishes) do
	          local _,_,id = string.find(item, "^(%d+):");
	          id = tonumber(id);
	          ft[how][id] = {};
	          for k,v in pairs(ft[how][item]) do
	             ft[how][id][k] = v;
 	          end
	          if ( ft[how][id].count ) then
	             ft[how][id].data = {};
	             for k,v in pairs(ft[how][id].count) do
	                ft[how][id].data[k] = v;
	             end
	             ft[how][id].count = nil;
	          end
	       end
	       for _,item in pairs(fishes) do
	          ft[how][item] = nil;
	       end
            end
         end
      end
   end

   if ( version < 8504 ) then
      -- Let's not store default colors for things
      local ff = FishingBuddy_Info["Fishies"];
      if ( ff ) then
	 for id in pairs(ff) do
	    if ( ff[id].color and ff[id].color == "ffffffff" ) then
	       ff[id].color = nil;
	    end
	 end
      end
   end

   if ( version < 8509 and FishingBuddy_Info["FishTracking"] ) then
      local ft = FishingBuddy_Info["FishTracking"]["WEEKLY"];
      for id,what in pairs(ft) do
	 if ( not ft[id].data[52] ) then
	    ft[id].data[52] = 0;
	    table.setn(ft[id].data, 53);
	 end
      end
   end

   if ( not FishingBuddy_Info["Locations"] ) then
      return;
   end

   -- Duh, table.getn doesn't work because there aren't any integer
   -- keys in this table
   if ( next(FishingBuddy_Info["Locations"]) == nil ) then
      FishingBuddy_Info["Locations"] = nil;
      return;
   end

   FishingBuddy_Info["FishingHoles"] = { };
   FishingBuddy_Info["FishingHoles"][FBConstants.UNKNOWN] = { };
   for zone in pairs(FishingBuddy_Info["Locations"]) do
      FishingBuddy_Info["FishingHoles"][FBConstants.UNKNOWN][zone] = { };
      local tab = FishingBuddy_Info["FishingHoles"][FBConstants.UNKNOWN][zone];
      for k,v in pairs(FishingBuddy_Info["Locations"][zone]) do
	 tab[k] = v;
      end
   end
   FishingBuddy_Info["Locations"] = nil;
end

FishingInit.FixupNumericZones = function()
   -- fix bad zones from FishSchools update bug
   local badones;
   local biggest = 0;
   local hardfix = false;
   for zidx,zone in pairs(FishingBuddy_Info["ZoneIndex"]) do
      if ( type(zone) ~= "string" ) then
         if ( not badones ) then
            badones = {};
         end
         badones[zidx] = zone;
         if ( biggest < zidx ) then
            biggest = zidx;
         end
      elseif ( biggest > 0 ) then
         -- found a string after we started seeing numbers
         hardfix = true;
      end
   end
   if ( badones ) then
      local fs = FishingBuddy_Info["FishingSkill"];
      local fh = FishingBuddy_Info["FishingHoles"];
      for bidx,gidx in pairs(badones) do
         if ( fs[bidx] ) then
            for sidx,skill in pairs(fs[bidx]) do
               local z = FishingBuddy_Info["ZoneIndex"][gidx];
               local sz = FishingBuddy_Info["SubZones"][gidx][sidx];
               FishingBuddy.SetZoneLevel(z, sz, fs[bidx][gidx]);
            end
         end
         if ( fh[bidx] ) then
            if ( not fh[gidx] ) then
               fh[gidx] = {};
            end
            for sidx,fishies in pairs(fh[bidx]) do
               for id,cnt in pairs(fishies) do
                  if ( fh[gidx] and
		       fh[gidx][sidx] and
		       fh[gidx][sidx][id] ) then
                     fh[gidx][sidx][id] = fh[gidx][sidx][id] + cnt;
                  else
		     if ( not fh[gidx] ) then
			fh[gidx] = {};
		     end
		     if ( not fh[gidx][sidx] ) then
			fh[gidx][sidx] = {};
		     end
                     fh[gidx][sidx][id] = cnt;
                  end
               end
            end
         end
      end
      if ( not hardfix ) then
         -- these are already in numerical order
         local count = table.getn(FishingBuddy_Info["ZoneIndex"]);
         for idx=count,1,-1 do
            if ( badones[idx] ) then
               table.remove(FishingBuddy_Info["ZoneIndex"], idx);
               FishingBuddy_Info["FishingSkill"][idx] = nil;
               FishingBuddy_Info["FishingHoles"][idx] = nil;
               FishingBuddy_Info["SubZones"][idx] = nil;
            end
         end
      else
         local fixers = { "FishingSkill", "FishingHoles", "SubZones" };
         -- okay, this gonna be tough
         -- strip out the numbers after the string
         while ( badones ) do
            local count = table.getn(FishingBuddy_Info["ZoneIndex"]);
            local gotstring = false;
            local sidx;
            for idx=count,1,-1 do
               if ( not gotstring ) then
                  if (type(fh[idx]) ~= "string" ) then
                     table.remove(FishingBuddy_Info["ZoneIndex"], idx);
                     for _,k in pairs(fixers) do
                        FishingBuddy_Info[k][idx] = nil;
                     end
                     badones[idx] = nil;
                  else
                     gotstring = true;
                     sidx = idx;
                  end
               end
            end
            if ( next(badones) == nil) then
               badones = nil;
            end
            if ( sidx and sidx ~= count ) then
               count = table.getn(FishingBuddy_Info["ZoneIndex"]);
               local fidx = 1;
               while ( fidx < count and type(FishingBuddy_Info["ZoneIndex"][fidx] == "string" ) ) do
		  fidx = fidx + 1;
               end
               for k,v in FishingBuddy_Info["ZoneIndex"][sidx] do
                  FishingBuddy_Info["ZoneIndex"][fidx][k] = v;
               end
               FishingBuddy_Info["ZoneIndex"][sidx] = nil;
               for _,f in fixers do
                  for k,v in FishingBuddy_Info[f][sidx] do
                     FishingBuddy_Info[f][fidx][k] = v;
                  end
                  FishingBuddy_Info[f][sidx] = nil;
               end
            else
               -- if it's not already nil, we're in trouble
               badones = nil;
            end
         end
      end
   end
end

FishingInit.UpdateFishingDB2 = function()
   local version = FishingBuddy_Info["Version"];
   if ( not version ) then
      version = 7700; -- be really old
   end

   -- track the weekly fish that got missed at the end of the year
   if ( version < 8509 and FishingBuddy.ByFishie and FishingBuddy_Info["FishTracking"]) then
      local ft = FishingBuddy_Info["FishTracking"]["WEEKLY"];
      for id,what in ft do
	 if ( FishingBuddy.ByFishie[id] ) then
	    local total = 0;
	    for _,count in FishingBuddy.ByFishie[id] do
	       total = total + count;
	    end
	    local tracked = 0;
	    local limit = table.getn(what.data)-1;
	    for i=0,limit do
	       tracked = tracked + what.data[i];
	    end
	    local diff = total - tracked;
	    if ( diff > 0 ) then
	       ft[id].data[52] = ft[id].data[52] + diff;
	    end
	 end
      end
   end

   -- version < 8700
   local needCollapse = true;
   if ( FishingBuddy_Info["Schools"] ) then
      -- convert zone coords into minimap coords
      local STVInfo = { scale = 0.18128603034401,
         xoffset = 0.39145470225916, yoffset = 0.79412224886668 };
      local tastyfish_id = 19807;

      local addschool = FishingBuddy.Schools.AddFishingSchool;
      local zone = FBConstants.STVZONENAME;
      for _,pools in FishingBuddy_Info["Schools"] do
         for idx,entry in pools do
            local t;
            local x = (entry.x - STVInfo.xoffset) / STVInfo.scale;
            local y = (entry.y - STVInfo.yoffset) / STVInfo.scale;
            addschool(FBConstants.SCHOOL_TASTY, 19807, zone, x, y);
         end
      end
      FishingBuddy_Info["Schools"] = nil;
      needCollapse = nil;
   end

   if ( version < 8701 ) then
      FishingBuddy.SetSetting("FastCast", nil);
   end

   if ( version < 8703 ) then
      local azi = FishingBuddy.AddZoneIndex;
      if ( FishingBuddy_Info["FishingSkill"] ) then
         didsomething = false;
	 local fixit = false;
	 for zone,info in FishingBuddy_Info["FishingSkill"] do
	    if ( type(zone) == "string" ) then
	       fixit = true;
	       break;
	    end
	 end
	 if ( fixit ) then
	    local newskills = {};
	    for zone,info in FishingBuddy_Info["FishingSkill"] do
	       local zidx = azi(zone);
	       newskills[zidx] = {};
	       for subzone,count in info do
		  local _,sidx = azi(zone,subzone);
		  newskills[zidx][sidx] = count;
	       end
	       FishingBuddy_Info["FishingSkill"][zone] = nil;
	    end
	    FishingBuddy_Info["FishingSkill"] = newskills;
	 end
      end

      if ( FishingBuddy_Info["FishingHoles"] ) then
	 local fixit = false;
	 for zone,info in FishingBuddy_Info["FishingHoles"] do
	    if ( type(zone) == "string" ) then
	       fixit = true;
	       break;
	    end
	 end
	 if ( fixit ) then
	    local newholes = {};
	    for zone,info in FishingBuddy_Info["FishingHoles"] do
	       local zidx = azi(zone);
	       newholes[zidx] = {};
	       for subzone,stuff in info do
	          local _,sidx = azi(zone,subzone);
	          newholes[zidx][sidx] = stuff;
	       end
	       FishingBuddy_Info["FishingHoles"][zone] = nil;
	    end
	    FishingBuddy_Info["FishingHoles"] = newholes;
	 end
      end
   end

   if ( version < 8704 and needCollapse ) then
      if ( FishingBuddy_Info["FishSchools"] ) then
	 local azi = FishingBuddy.AddZoneIndex;
	 local fixit = false;
	 for zone,info in FishingBuddy_Info["FishSchools"] do
	    if ( type(zone) == "string" ) then
	       fixit = true;
	       break;
	    end
	 end
	 if ( fixit ) then
	    local newschools = {};
	    for zone,info in FishingBuddy_Info["FishSchools"] do
	       local zidx = azi(zone);
	       newschools[zidx] = {};
	       for idx,entry in info do
	          tinsert(newschools[zidx], entry);
	       end
	       FishingBuddy_Info["FishSchools"][zone] = nil;
	    end
	    FishingBuddy_Info["FishSchools"] = newschools;
	 end
      end
      FishingBuddy.Schools.CollapseHoles();
   end

   if ( version < 8707 ) then
      FishingInit.FixupNumericZones();
   end

   if ( version < 8712 and FishingBuddy_Info and FishingBuddy_Info["FishTracking"] ) then
      local ft = FishingBuddy_Info["FishTracking"];
      for how,info in ft do
	 for id,what in ft[how] do
	    what.plot = 1;
	 end
      end
   end

   if ( version < 8900 and FishingBuddy_Info["FishTracking"] ) then
      for idx,how in { "HOURLY", "WEEKLY" } do
         for id,info in FishingBuddy_Info["FishTracking"][how] do
            if ( info.name == FBConstants.FISH.." ("..id..")" ) then
               info.name = nil;
            end
         end
      end
   end

   if ( version < 8901 ) then
      local clickToSwitch;
      for idx,click in { "Titan", "Fubar", "InfoBar" } do
	 local setting = click.."ClickToSwitch";
	 local s = FishingBuddy_Player["Settings"][setting];
	 if ( s ~= nil ) then
	    clickToSwitch = s;
	 end
	 FishingBuddy_Player["Settings"][setting] = nil;
      end
      FishingBuddy_Player["Settings"]["ClickToSwitch"] = clickToSwitch;
   end

   -- save this for other pieces that might need to update
   lastVersion = version;

   FishingBuddy_Info["Version"] = FBConstants.CURRENTVERSION;
end

FishingBuddy.GetLastVersion = function()
   return lastVersion;
end

-- Based on code in QuickMountEquip
FishingInit.HookFunction = function(func, newfunc)
   local oldValue = getglobal(func);
   if ( oldValue ~= getglobal(newfunc) ) then
      setglobal(func, getglobal(newfunc));
      return true;
   end
   return false;
end

-- set up alternate view of fish data. do this as startup to
-- lower overall dynamic hit when loading the window
FishingInit.SetupByFishie = function()
   if ( not FishingBuddy.ByFishie ) then
      local fh = FishingBuddy_Info["FishingHoles"];
      local ff = FishingBuddy_Info["Fishies"];
      FishingBuddy.ByFishie = { };
      FishingBuddy.SortedFishies = { };
      for zidx in fh do
	 local zone = FishingBuddy_Info["ZoneIndex"][zidx];
	 for sidx in fh[zidx] do
	    local subzone = FishingBuddy_Info["SubZones"][zidx][sidx];
	    local indexer = zidx.."."..sidx;
	    for id in fh[zidx][sidx] do
	       local quantity = fh[zidx][sidx][id];
	       if ( not FishingBuddy.ByFishie[id] ) then
		  FishingBuddy.ByFishie[id] = { };
		  tinsert(FishingBuddy.SortedFishies,
			  { text = ff[id].name, id = id });
	       end
	       
	       if ( not FishingBuddy.ByFishie[id][indexer] ) then
		  FishingBuddy.ByFishie[id][indexer] = quantity;
	       else
		  FishingBuddy.ByFishie[id][indexer] = FishingBuddy.ByFishie[id][indexer] + quantity;
	       end
	    end
	 end
      end
      FishingBuddy.FishSort(FishingBuddy.SortedFishies, true);
   end
end

FishingInit.InitSortHelpers = function()
   local fh = FishingBuddy_Info["FishingHoles"];
   FishingBuddy.SortedZones = {};
   FishingBuddy.SortedByZone = {};
   FishingBuddy.SortedSubZones = {};
   for zidx,zone in FishingBuddy_Info["ZoneIndex"] do
      tinsert(FishingBuddy.SortedZones, zone);
      FishingBuddy.SortedByZone[zone] = {};
      if ( fh[zidx] ) then
	 for sidx in fh[zidx] do
	    local subzone = FishingBuddy_Info["SubZones"][zidx][sidx];
	    tinsert(FishingBuddy.SortedByZone[zone], subzone);
	    tinsert(FishingBuddy.SortedSubZones, subzone);
	 end
	 table.sort(FishingBuddy.SortedByZone[zone]);
      end
   end
   table.sort(FishingBuddy.SortedZones);
   table.sort(FishingBuddy.SortedSubZones);
end

FishingInit.InitSettings = function()
   if( not FishingBuddy_Info ) then
      FishingBuddy_Info = { };
   end
   -- global stuff
   FishingInit.SetupZoneMapping();
   FishingInit.UpdateFishingDB1();
   FishingInit.CheckRealm();

   FishingInit.CheckGlobalSetting("ImppDBLoaded", 0);
   FishingInit.CheckGlobalSetting("FishInfo2", 0);
   FishingInit.CheckGlobalSetting("DataFish", 0);
   FishingInit.CheckGlobalSetting("FishingHoles");
   FishingInit.CheckGlobalSetting("FishingSkill");
   FishingInit.CheckGlobalSetting("Fishies");
   FishingInit.CheckGlobalSetting("HiddenFishies");

   FishingInit.CheckPlayerInfo();

   -- per user stuff
   if ( not FishingBuddy_Player["Settings"] ) then
      FishingBuddy_Player["Settings"] = { };
   end
   FishingInit.UpdateFishingDB2();
   FishingInit.SetupByFishie();
   FishingInit.InitSortHelpers();
end

FishingInit.RegisterMyAddOn = function()
   -- Register the addon in myAddOns
   if (myAddOnsFrame_Register) then
      local details = {
	 name = FBConstants.ID,
	 description = FBConstants.DESCRIPTION,
	 version = FBConstants.VERSION,
	 releaseDate = 'July 21, 2005',
	 author = 'Sutorix',
	 email = 'Windrunner',
	 category = MYADDONS_CATEGORY_PROFESSIONS,
	 frame = "FishingBuddy",
	 optionsframe = "FishingBuddyFrame",
      };
      local help = "";
      for _,line in FBConstants.HELPMSG do
	 if ( type(line) == "table" ) then
	    for _,l in line do
	       help = help.."\n"..l;
	    end
	 else
	    help = help.."\n"..line;
	 end
      end
      myAddOnsFrame_Register(details, { help });
   end
end

FishingInit.RegisterHandlers = function()
   temp = ToggleMinimap;
   if ( FishingInit.HookFunction("ToggleMinimap", "FishingBuddy_ToggleMinimap") ) then
      FishingBuddy.SavedToggleMinimap = temp;
   end
   FishingBuddy.TrapWorldMouse()
end

local WOW = {};
FishingBuddy.WOWVersion = function()
   return WOW.major, WOW.minor, WOW.dot;
end

FishingBuddy.Initialize = function()
   -- Set everything up, then dump the code we don't need anymore
   playerName, realmName = FishingInit.SetupNameInfo();
   if ( FishingInit ) then
      if ( GetBuildInfo ) then
	 local v, b, d = GetBuildInfo();
	 WOW.build = b;
	 WOW.date = d;
	 local s,e,maj,min,dot = string.find(v, "(%d+).(%d+).(%d+)");
	 WOW.major = tonumber(maj);
	 WOW.minor = tonumber(min);
	 WOW.dot = tonumber(dot);
      else
	 FBConstants.Is10900 = true;
      end
      FishingInit.RegisterHandlers();
      FishingInit.InitSettings();
      -- register with myAddOn
      FishingInit.RegisterMyAddOn();
      -- clean out some beta trash
      FishingBuddy.SetSetting("ClockOffset", nil);

      FishingBuddy.Schools.Init();

      gotSetupDone = true;
      FishingBuddy.WatchUpdate();
      -- debugging state
      FishingBuddy.Debugging = FishingBuddy.GetSetting("FishDebug");
      -- we don't need these functions anymore, gc 'em
      FishingInit = nil;
   end
end
