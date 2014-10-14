-- debugging

FishingBuddy = {};
FishingBuddy.API = {};
FishingBuddy.Commands = {};

FishingBuddy.Debugging = true;

local function printable(foo)
   if ( foo ) then
      if ( type(foo) == "table" ) then
	 return "table";
      elseif ( type(foo) == "boolean" ) then
	 if ( foo ) then
	    return "true";
	 else
	    return "false";
	 end
      else
	 return foo;
      end
   else
      return "nil";
   end
end
FishingBuddy.printable = printable;

FishingBuddy.Output = function(msg, r, g, b)
   if ( DEFAULT_CHAT_FRAME ) then
      if ( not r ) then
	 DEFAULT_CHAT_FRAME:AddMessage(msg);
      else
	 DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b);
      end
   end
end

FishingBuddy.Debug = function(msg, fixlinks)
   if ( FishingBuddy.Debugging ) then
      if ( fixlinks ) then
	 msg = string.gsub(msg, "|", ";");
      end
      local name = FBConstants.Name or "Fishing Buddy";
      FishingBuddy.Output("|c"..FBConstants.Colors.RED..name.."|r "..msg);
   end
end

FishingBuddy.DebugVars = function()
   FishingBuddy.Debugging = true;
end

FishingBuddy.Dump = function(thing)
   if ( FishingBuddy.Debugging ) then
      if ( DevTools_Dump ) then
	 DevTools_Dump(thing);
      else
	 FishingBuddy.Debug("Tried to dump a '"..FishingBuddy.printable(thing).."'.");
      end
   end
end

-- random debugging code, likely out of date
FishingBuddy.Commands["debug"] = {};
FishingBuddy.Commands["debug"].func =
   function(what)
      if ( what ) then
         if ( what == "on" ) then
            FishingBuddy.Debugging = true;
            FishingBuddy.SetSetting("FishDebug", true);
	    FishingBuddy.Debug("Debugging turned on");
	 elseif ( what == "off" ) then
	    FishingBuddy.Debug("Debugging turned off");
	    FishingBuddy.Debugging = nil;
	    FishingBuddy.SetSetting("FishDebug", nil);
         elseif ( what == "reset" ) then
            FishingBuddy_Info["Testing"] = nil;
	 elseif ( what == "test" ) then
	    local STVInfo = { scale = 0.18128603034401, xoffset = 0.39145470225916, yoffset = 0.79412224886668 };
	    local xscale = 10448.3;
	    local yscale = 7072.7;
	    local playerX, playerY = GetPlayerMapPosition("player");
	    local x = playerX * STVInfo.scale + STVInfo.xoffset;
	    local y = playerY * STVInfo.scale + STVInfo.yoffset;
	    FishingBuddy.Print("PlayerMap: %f, %f", x, y);
	    for idx=1,10 do
	       playerY = playerY + 0.01;
	       local dx = playerX * STVInfo.scale + STVInfo.xoffset;
	       local dy = playerY * STVInfo.scale + STVInfo.yoffset;
	       local dist = math.sqrt((dx*xscale*dx*xscale)+(dy*yscale*dy*yscale));
	       FishingBuddy.Print("PlayerMap: %f, %f - %f", dx, dy, dist);
	    end
         end
      end
      return true;
   end;
