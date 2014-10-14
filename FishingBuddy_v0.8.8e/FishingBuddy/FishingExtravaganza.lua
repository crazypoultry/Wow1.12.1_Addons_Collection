-- Support for the Extravaganza
--
-- Map support liberally borrowed from GuildMap, by Bru on Blackhand

FishingBuddy.Extravaganza = {};

local NUMMINIPOIS = 10;
local ICONPATH = "Interface\\AddOns\\FishingBuddy\\Icons\\";

-- the actual names don't matter, except to help make sure I've got 'em all
local ExtravaganzaFish = {};
ExtravaganzaFish[19807] = "Speckled Tastyfish";
ExtravaganzaFish[19806] = "Dezian Queenfish";
ExtravaganzaFish[19805] = "Keefer's Angelfish";
-- makes you wonder what item 19804 is, doesn't it...
ExtravaganzaFish[19803] = "Brownell's Blue Striped Racer";

FishingBuddy.Extravaganza.Fish = ExtravaganzaFish;

local UPDATETIME_POI = 0.2;
local UPDATETIME_SCHOOLS = 0.1;
local UPDATETIME_COUNTER = 60.0;
local STVUpdateTimer = 0;
local numCaught = 0;
local tastyfish_id = 19807;
local tastyfish;
local ExtravaganzaIsOver;

-- convert zone coords into minimap coords
local STVInfo = { scale = 0.18128603034401,
   xoffset = 0.39145470225916, yoffset = 0.79412224886668 };

local ZoomScale = {};
ZoomScale[0] = { xscale = 10448.3, yscale = 7072.7 };
ZoomScale[1] = { xscale = 12160.5, yscale = 8197.8 };
ZoomScale[2] = { xscale = 14703.1, yscale = 9825.0 };
ZoomScale[3] = { xscale = 18568.7, yscale = 12472.2 };
ZoomScale[4] = { xscale = 24390.3, yscale = 15628.5 };
ZoomScale[5] = { xscale = 37012.2, yscale = 25130.6 };

local function GetSTVPosition(x, y)
   if ( not x or not y ) then
      x, y = GetPlayerMapPosition("player");
   end
   x = (x * STVInfo.scale) + STVInfo.xoffset;
   y = (y * STVInfo.scale) + STVInfo.yoffset;
   return x, y;
end

local function SetTextureCoords(texture, A, B, C, D, E, F)
	local det = A*E - B*D;
	local ULx, ULy, LLx, LLy, URx, URy, LRx, LRy;
	
	ULx, ULy = ( B*F - C*E ) / det, ( -(A*F) + C*D ) / det;
	LLx, LLy = ( -B + B*F - C*E ) / det, ( A - A*F + C*D ) / det;
	URx, URy = ( E + B*F - C*E ) / det, ( -D - A*F + C*D ) / det;
	LRx, LRy = ( E - B + B*F - C*E ) / det, ( -D + A -(A*F) + C*D ) / det;
	
	texture:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
end

local function SetTextureAngle(texture, angrads)
   local c = math.cos(angrads);
   local s = math.sin(angrads);
   SetTextureCoords(texture, c, s, 0, -s, c, 0);
end

local function GetAngleIcon(x, y)
   local angle = asin(x / 57);
   if (x <= 0 and y <= 0) then
      angle = 180 - angle;
   elseif (x <= 0 and y > 0) then
      angle = 360 + angle;
   elseif (x > 0 and y >= 0) then
      angle = angle;
   else
      angle = 180 - angle;
   end
   local fileNumber = math.floor((angle / 10) + 0.5) * 10;
   if (fileNumber == 360) then
      fileNumber = 0;
   end
   return ICONPATH.."MiniMapArrow"..fileNumber;
end

local function PlotPOI(index, x, y, rot, scale)
   local poi = getglobal("FishingExtravaganzaMini"..index);
   if ( poi ) then
      if ( x and y ) then
         local tex = getglobal("FishingExtravaganzaMini"..index.."Texture");
         local zoom = ZoomScale[Minimap:GetZoom()];
         x = x * zoom.xscale;
         y = y * zoom.yscale;
         local dist = math.sqrt(x*x + y*y);
         if ( dist > 56.5 ) then
            x = x * 57 / dist;
            y = y * 57 / dist;
            if ( rot) then
               tex:SetTexture(ICONPATH.."MiniMapArrow");
              SetTextureAngle(tex, math.asin(x / 57));
            else
               tex:SetTexture(GetAngleIcon(x, y));
               tex:SetTexCoord(0.0, 1.0, 0.0, 1.0);
            end
         else
            tex:SetTexture("Interface\\Minimap\\ObjectIcons");
            tex:SetTexCoord(0.0, 0.25, 0.25, 0.5);
         end
         poi:SetPoint("CENTER", "MinimapCluster", "TOPLEFT", 107 + x, y - 92);
         if ( scale ) then
            poi:SetWidth(scale);
            poi:SetHeight(scale);
         end
         poi:Show();
         return true;
      else
         poi:Hide();
      end
   end
   return false;
end

local function CloseEnough(x1, y1, x2, y2)
   local zoom = Minimap:GetZoom();
   local x = (x1 - x2) * ZoomScale[zoom].xscale;
   local y = (y1 - y2) * ZoomScale[zoom].yscale;
   if (sqrt( (x * x) + (y * y) ) > 56.5) then
      return; -- false
   end
   return true;
end

local function GetDistance(x1, y1, x2, y2)
   local dx = (x1 - x2);
   local dy = (y1 - y2);
   return math.sqrt(dx*dx + dy*dy);
end

local function GetMinimapDistance(x1, y1, x2, y2)
   local zoom = ZoomScale[Minimap:GetZoom()];
   local dx = (x1 - x2) * zoom.xscale;
   local dy = (y1 - y2) * zoom.yscale;
   return math.sqrt(dx*dx+dy*dy);
end

local lx, ly;
local lastten;
local function GetNearestTen(x, y)
   local schools = FishingBuddy.Schools.GetSchools(FishingBuddy.STVZONENAME);
   if ( not x or not y ) then
      x, y = GetSTVPosition();
   end
   -- if we've moved less than half the distance to the closest hole
   -- don't recalculate
   if ( lastten ) then
      if ( lx == x and ly == y ) then
	 return lastten;
      end
      if ( table.getn(lastten) > 0 ) then
	 local d = GetDistance(x, y, lx, ly);
	 if ( d < (lastten[1].dist/2) ) then
	    return lastten;
	 end
      end 
   end

   local bydist = {};
   for idx=1,table.getn(schools) do
      local t = schools[idx];
      if ( t.kind == FishingBuddy.SCHOOL_TASTY ) then
         local sx, sy = GetSTVPosition(t.x, t.y);
         local d = GetDistance(sx, sy, x, y);
         local info = {};
         info.x = sx;
         info.y = sy;
         info.dist = d;
         tinsert(bydist, info);
      end
   end
   table.sort(bydist, function(a, b) return a.dist < b.dist; end);
   local idx = 1;
   lastten = {};
   for _,info in bydist do
       if ( idx < 10 ) then
          tinsert(lastten, { dist = info.dist, x = info.x, y = info.y });
          idx = idx + 1;
       end
   end
   lx = x;
   ly = y;
   return lastten;
end

local function UpdatePOI()
   local x, y = GetSTVPosition();
   local loc1 = GetNearestTen(x, y);
   for idx=1,NUMMINIPOIS do
      local t = loc1[idx];
      if ( t ) then
         PlotPOI(idx, t.x - x, y - t.y);
      else
         PlotPOI(idx);
      end
   end
end

local function HidePOI()
   local poi = getglobal("FishingExtravaganzaMini1");
   if ( poi:IsVisible() ) then
      for idx=1,NUMMINIPOIS do
         PlotPOI(idx);
      end
   end
end

local POIUpdateTimer = UPDATETIME_POI;
FishingBuddy.Extravaganza.POI_OnUpdate = function(elapsed)
   POIUpdateTimer = POIUpdateTimer - elapsed;
   if ( POIUpdateTimer < 0 ) then
      FishingExtravaganzaPOIUpdate:Hide();
      UpdatePOI();
      POIUpdateTimer = UPDATETIME_POI;
   end
end

local function DoUpdatePOI()
   POIUpdateTimer = UPDATETIME_POI;
   FishingExtravaganzaPOIUpdate:Show();
end

-- let an external entity forcibly mark a school
FishingBuddy.Extravaganza.MarkSchool = function()
   local zone, subzone = FishingBuddy.GetZoneInfo();
   if ( zone == FishingBuddy.STVZONENAME ) then
      FishingBuddy.Schools.AddFishingSchool(FishingBuddy.SCHOOL_TASTY, tastyfish_id, zone);
   end
end

local function ExtravaganzaHijackCheck()
   if ( FishingBuddy.NormalHijackCheck() ) then
      -- also check to make sure we're over a pool
      return FishingBuddy.Schools.IsFishingHole(FishingBuddy.GetTooltipText());
   end
end

-- Sunday, 2pm
local STVDay = "0";
local STVStartHour = 14;

-- Should we display the extravaganza message?
local function IsTime(activate)
   local showit = false;
   if ( FishingBuddy.IsLoaded() ) then
      if ( FishingBuddy.GetSetting("STVTimer") == 1 ) then
         local mhour = date("%H");
         local hour,minute = GetGameTime();
         local day = date("%w");
         local off = FishingBuddy.GetClockOffset();
         if ( off ~= 0 ) then
            local lhour = date("%H");
            lhour = lhour + off;
            if ( lhour >= 24 ) then
               day = day + 1;
            elseif( lhour < 0 ) then
               day = day - 1;
            end
         end
         -- Is it Sunday?
         if ( day == STVDay and
             (hour >= (STVStartHour-2) and hour <(STVStartHour+2))) then
            showit = true;
         end
      end
   end
   if ( showit ) then
      if ( activate ) then
         FishingExtravaganzaFrame:Show();
      end
      if ( FishingBuddy.GetSetting("STVPoolsOnly") == 1 ) then
	 local zone,_ = FishingBuddy.GetZoneInfo();
	 if ( zone == FishingBuddy.STVZONENAME ) then
	    FishingBuddy.SetHijackCheck(ExtravaganzaHijackCheck);
	 else
	    FishingBuddy.SetHijackCheck();
	 end
      end
   else
      if ( FishingExtravaganzaFrame:IsVisible() or
	  FishingExtravaganzaMini1:IsVisible() ) then
	 FishingExtravaganzaFrame:Hide();
	 HidePOI();
      end
      FishingBuddy.SetHijackCheck();
   end
   return showit;
end
FishingBuddy.Extravaganza.IsTime = IsTime;

-- Check for mouse down event for dragging frame.
FishingBuddy.Extravaganza.OnDragStart = function(arg1)
   if (arg1 == "LeftButton") then
      FishingExtravaganzaFrame:StartMoving();
      FishingExtravaganzaFrame.isMoving = true;
   end
end

-- Check for drag stop event to stop dragging.
FishingBuddy.Extravaganza.OnDragStop = function(arg1)
   if (arg1 == "LeftButton") then
      FishingExtravaganzaFrame:StopMovingOrSizing();
      FishingExtravaganzaFrame.isMoving = false;
   end
end

-- Handle watching the loot
FishingBuddy.Extravaganza.OnLoad = function()
   this:RegisterEvent("PLAYER_LOGIN");
   this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
   this:RegisterEvent("VARIABLES_LOADED");

   this:RegisterForDrag("LeftButton");
   this:Hide();
end

FishingBuddy.Extravaganza.OnShow = function()
   -- check each of the bags on the player
   numCaught = 0;
   for bag=0, NUM_BAG_FRAMES do
      -- get the number of slots in the bag (0 if no bag)
      numSlots = GetContainerNumSlots(bag);
      if (numSlots > 0) then
         -- check each slot in the bag
         for slot=1, numSlots do
            local link = GetContainerItemLink (bag, slot);
            if (link) then
               local _,id,_ = FishingBuddy.SplitFishLink(link);
               if ( id and id == tastyfish_id ) then
                  local _,c,_,_,_ = GetContainerItemInfo(bag, slot);
                  numCaught = numCaught + c;
	           end
	        end
         end
      end
   end
end

FishingBuddy.Extravaganza.OnEvent = function()
   local zone, subzone = FishingBuddy.GetZoneInfo();
   if ( event == "LOOT_OPENED" ) then
      if ( IsFishingLoot()) then
         for index = 1, GetNumLootItems(), 1 do
            if (LootSlotIsItem(index)) then
               local fishlink = GetLootSlotLink(index);
               local _, id, name = FishingBuddy.SplitFishLink(fishlink);
               if ( ExtravaganzaFish[id] ) then
                  FishingBuddy.Schools.AddFishingSchool(FishingBuddy.SCHOOL_TASTY, id, zone);
                  STVUpdateTimer = 0;
                  if ( id == tastyfish_id ) then
                     numCaught = numCaught + 1;
		     -- make sure we've got the name of the fish for display
		     tastyfish = name;
                  end
               end
            end
         end
      end
   elseif ( event == "CHAT_MSG_YELL" ) then
      -- Riggle Bassbait yells: We have a winner! (.*) is the Master Angler!
      local e,s,n = string.find(arg1, FishingBuddy.RIGGLE_BASSBAIT);
      if ( e ) then
         ExtravaganzaIsOver = true;
      end
   elseif ( event == "MINIMAP_UPDATE_ZOOM" ) then
      if ( zone == FishingBuddy.STVZONENAME ) then
         if ( FishingBuddy.GetSetting("STVTimer") == 1 ) then
            DoUpdatePOI();
         end
      end
   elseif ( event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_LOGIN" ) then
      if ( zone == FishingBuddy.STVZONENAME and IsTime() ) then
         this:RegisterEvent("CHAT_MSG_YELL");
         this:RegisterEvent("LOOT_OPENED");
         this:RegisterEvent("MINIMAP_UPDATE_ZOOM");
      else
         this:UnregisterEvent("CHAT_MSG_YELL");
         this:UnregisterEvent("LOOT_OPENED");
         this:UnregisterEvent("MINIMAP_UPDATE_ZOOM");
      end
   elseif ( event == "VARIABLES_LOADED" ) then
      local _,_,_,_,_,n = FishingBuddy.GetFishie(tastyfish_id);
      if ( n ) then
         tastyfish = n;
      else
         tastyfish = FishingBuddy.FISH;
      end
      IsTime(true);
      this:UnregisterEvent("VARIABLES_LOADED");
   end
end

FishingBuddy.Extravaganza.OnUpdate = function(elapsed)
   if ( IsTime() ) then
      if ( not FishingExtravaganzaFrame:IsVisible() ) then
         FishingExtravaganzaFrame:Show();
      end
      STVUpdateTimer = STVUpdateTimer - elapsed;
      if ( STVUpdateTimer < 0 ) then
         local hour,minute = GetGameTime();
         local minleft;
         local checkhour = STVStartHour;
         local line;
         local contestNow = false;
         if ( hour >= STVStartHour ) then
            if ( ExtravaganzaIsOver ) then
               line = FishingBuddy.FATLADYSINGS;
            else
	       line = FishingBuddy.TIMELEFT;
	    end
            line = line..FishingBuddy.DASH.." |c";
            if ( numCaught < 20 ) then
               line = line..FishingBuddy.Colors.RED;
            elseif ( numCaught < 39 ) then
               line = line..FishingBuddy.Colors.YELLOW;
            else
               line = line..FishingBuddy.Colors.GREEN;
            end
            line = line..FishingBuddy.FISHCAUGHT.."|r";
            checkhour = checkhour + 2;
            contestNow = true;
         else
            line = FishingBuddy.TIMETOGO;
         end
         minleft = (checkhour - hour)*60 - minute;
         if ( minleft > 0 ) then
            FishingExtravaganzaFrameButtonText:SetTextColor(0.1, 1.0, 0.1);
            if ( minleft < 10 ) then
               FishingExtravaganzaFrameButtonText:SetTextColor(1.0, 0.1, 0.1);
            end
            line = string.format(line, minleft/60, math.mod(minleft, 60),
                                 numCaught, tastyfish);
            FishingExtravaganzaFrameButtonText:SetText(line);
            local width = FishingExtravaganzaFrameButtonText:GetWidth();
            FishingExtravaganzaFrame:SetWidth(width + 16);
            local zone,_ = FishingBuddy.GetZoneInfo();
            if ( zone == FishingBuddy.STVZONENAME ) then
               DoUpdatePOI();
               STVUpdateTimer = UPDATETIME_SCHOOLS;
            else
               STVUpdateTimer = UPDATETIME_COUNTER;
            end
         end
      end
   else
      FishingExtravaganzaFrame:Hide();
      HidePOI();
   end
end

local function GetObjectCoords(poi, index, numcolumns, texturewidth)
   local width = poi:GetWidth();
   local xCoord1, xCoord2, yCoord1, yCoord2; 
   local coordIncrement = width / texturewidth;
   xCoord1 = mod(index , numcolumns) * coordIncrement;
   xCoord2 = xCoord1 + coordIncrement;
   yCoord1 = floor(index / numcolumns) * coordIncrement;
   yCoord2 = yCoord1 + coordIncrement;
   return xCoord1, xCoord2, yCoord1, yCoord2;
end

local start = 0;
-- debugging routines
FishingBuddy.Extravaganza.Debug = function(day, hour, zone)
   STVDay = day;
   STVStartHour = hour;
   if ( zone ) then
      FishingBuddy.STVZONENAME = zone;
   end
   IsTime(true);
end

-- eventually, display what fish you caught here
FishingBuddy.Extravaganza.MiniMap_OnEnter = function()
end

-- test the extravaganze school marking functions
-- need to expand this for 1.9 if we can tell automatically
FishingBuddy.Commands["mark"] = {};
FishingBuddy.Commands["mark"].func =
   function(what)
      if ( what == "reset" ) then
         FishingBuddy_Info["FishSchools"] = nil;
      elseif ( what == "debug" ) then
         local hour,_ = GetGameTime();
         local day = date("%w");
         FishingBuddy.Extravaganza.Debug(day, hour);
      elseif ( what == "test" ) then
	 FishingBuddy.Debug("mark test");
	 local coord = 0.005;
	 local rot = 1;
         PlotPOI(1, 0, coord, rot, 16);
         PlotPOI(2, coord, coord, rot, 16);
         PlotPOI(3, coord, 0, rot, 16);
         PlotPOI(4, -coord, 0, rot, 16);
         PlotPOI(5, -coord, -coord, rot, 16);
         PlotPOI(6, 0, -coord, rot, 16);
      else
         FishingBuddy.Extravaganza.MarkSchool();
      end
      return true;
   end;

