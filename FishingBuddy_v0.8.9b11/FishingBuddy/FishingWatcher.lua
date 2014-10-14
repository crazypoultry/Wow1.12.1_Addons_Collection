-- Display the fish you're catching and/or have caught in a live display

FishingBuddy.WatchFrame = {};

local MAX_FISHINGWATCH_LINES = 20;
local WATCHDRAGGER_SHOW_DELAY = 0.2;

local WATCHDRAGGER_FADE_TIME = 0.15;

local function PlaceDraggerFrame()
   local where = FishingBuddy.GetSetting("WatcherLocation");
   if ( not where ) then
      where = {};
      where.x = 0;
      where.y = -384;
   end
   FishingWatchDrag:ClearAllPoints();
   FishingWatchDrag:SetPoint("TOPLEFT", "UIParent", "TOPLEFT",
				  where.x, where.y);
end

local function ShowDraggerFrame()
   if ( not FishingWatchDrag:IsVisible() ) then
      FishingWatchFrame:Show();
      local width = FishingWatchFrame:GetWidth();
      local height = FishingWatchFrame:GetHeight();
      FishingWatchDrag:SetHeight(height);
      FishingWatchDrag:SetWidth(width);
      FishingWatchTab:SetText(FBConstants.NAME);
      PanelTemplates_TabResize(10, FishingWatchTab);
      FishingWatchDrag:Show();
      FishingWatchTab:Show();
      UIFrameFadeIn(FishingWatchDrag, WATCHDRAGGER_FADE_TIME, 0, 0.15);
      UIFrameFadeIn(FishingWatchTab, WATCHDRAGGER_FADE_TIME, 0, 1.0);
      GameTooltip_AddNewbieTip(FBConstants.NAME, 1.0, 1.0, 1.0,
			       FBConstants.WATCHERCLICKHELP, 1);
   end
end

local function HideDraggerFrame(save)
   if ( FishingWatchDrag:IsVisible() ) then
      if ( save ) then
	 FishingWatchFrame:Show();
	 local qx = UIParent:GetLeft()
	 local qy = UIParent:GetTop();
	 local wx = FishingWatchDrag:GetLeft()
	 local wy = FishingWatchDrag:GetTop();
	 local where;
	 if ( wx and wy ) then
	    where = {};
	    where.x = wx - qx;
	    where.y = wy - qy;
	 end
	 FishingBuddy.SetSetting("WatcherLocation", where);
      end
      UIFrameFadeOut(FishingWatchDrag, WATCHDRAGGER_FADE_TIME, 0.15, 0);
      UIFrameFadeOut(FishingWatchTab, WATCHDRAGGER_FADE_TIME, 1.0, 0);
      FishingWatchDrag:Hide();
      FishingWatchTab:Hide();
      GameTooltip:Hide();
   end
end

local function ResetWatcherFrame(update)
   FishingWatchTab:Show();
   FishingWatchDrag:Show();
   FishingWatchDrag:ClearAllPoints();
   FishingWatchDrag:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
   HideDraggerFrame(true);
   if ( update ) then
      FishingBuddy.WatchUpdate();
   end
end

FishingBuddy.ShowDraggerFrame = ShowDraggerFrame;
FishingBuddy.HideDraggerFrame = HideDraggerFrame;
FishingBuddy.PlaceDraggerFrame = PlaceDraggerFrame;
FishingBuddy.ResetWatcherFrame = ResetWatcherFrame;

FishingBuddy.Commands[FBConstants.WATCHER] = {};
FishingBuddy.Commands[FBConstants.WATCHER].help = FBConstants.WATCHER_HELP;
FishingBuddy.Commands[FBConstants.WATCHER].func =
   function(what)
      if ( what and ( what == FBConstants.RESET ) ) then
	 ResetWatcherFrame(true);
         return true;
      end
   end;

-- fix old data
local function UpdateUnknownZone(zone, subzone, zidx, sidx)
   local uzidx = FishingBuddy.GetZoneIndex(FBConstants.UNKNOWN);
   if ( uzidx ) then
      local fh = FishingBuddy_Info["FishingHoles"];
      for usidx in pairs(fh[uzidx]) do
	 local uszone = FishingBuddy_Info["SubZones"][uzidx][usidx];
	 if ( uszone == subzone ) then
	    for k,v in pairs(fh[uzidx][usidx]) do
	       if ( fh[zidx][sidx][k] ) then
		  fh[zidx][sidx][k] = fh[zidx][sidx][k] + v;
	       else
		  fh[zidx][sidx][k] = v;
	       end
	    end
	    for k,_ in pairs(fh[uzidx][usidx]) do
	       fh[uzidx][usidx][k] = nil;
	    end
	 end
      end
   end
end

-- Fish watcher functions
local function WatchUpdate()
   if ( FishingWatchFrame:IsVisible() ) then
      HideDraggerFrame();
      FishingWatchFrame:Hide();
      for i=1, MAX_FISHINGWATCH_LINES, 1 do
         local line = getglobal("FishingWatchLine"..i);
         line:Hide();
      end
   end

   local reset = FishingBuddy.GetSetting("ResetWatcher");
   if ( not reset or reset < 1 ) then
      ResetWatcherFrame(false);
      FishingBuddy.SetSetting("ResetWatcher", 1);
   end

   local zone, subzone = FishingBuddy.GetZoneInfo();
   local zidx, sidx = FishingBuddy.GetZoneIndex(zone, subzone);

   UpdateUnknownZone();

   if ( FishingBuddy.GetSetting("WatchFishies") == 0 ) then
      return;
   end

   if ( FishingBuddy.GetSetting("WatchOnlyWhenFishing") == 1 and
       not FishingBuddy.API.IsFishingPole() ) then
      return;
   end

   local fz = FishingBuddy_Info["FishingHoles"][zidx];
   local current = FishingBuddy.currentFishies;
   local ff = FishingBuddy_Info["Fishies"];
   local fishsort = {};
   local totalCount = 0;
   local totalCurrent = 0;
   local gotDiffs = false;

   if ( fz and fz[sidx] ) then
      for fishid in fz[sidx] do
         local info = {};
         if ( not FishingBuddy_Info["HiddenFishies"][fishid] ) then
	    info.text = ff[fishid].name;
         end
         info.count = fz[sidx][fishid];
         totalCount = totalCount + info.count;
         if ( current[sidx] ) then
	    info.current = current[sidx][fishid] or 0;
         else
	    info.current = 0;
         end
         if ( info.current > 0 and info.current ~= info.count ) then
	    gotDiffs = true;
         end
         totalCurrent = totalCurrent + info.current;
         tinsert(fishsort, info);
      end

--   if ( totalCount == 0 and totalCurrent == 0 ) then
--      return;
--   end

      FishingBuddy.FishSort(fishsort);
   end

   local fishingWatchMaxWidth = 0;
   local tempWidth;
   local index = 1;
   local start = 1;
   local dopercent = FishingBuddy.GetSetting("WatchFishPercent");

   if ( FishingBuddy.GetSetting("WatchCurrentZone") == 1 ) then
      local entry = getglobal("FishingWatchLine"..index);
      local line = zone.." : "..subzone;
      entry:SetText(line);
      local tempWidth = entry:GetWidth();
      if ( tempWidth > fishingWatchMaxWidth ) then
	 fishingWatchMaxWidth = tempWidth;
      end
      entry:Show();
      index = index + 1;
   end
   if ( FishingBuddy.GetSetting("WatchCurrentSkill") == 1 ) then
      local entry = getglobal("FishingWatchLine"..index);
      local skill, mods = FishingBuddy.GetCurrentSkill();
      local line = "Skill: |cff00ff00"..skill.."+"..mods.."|r";
      local StartedFishing = FishingBuddy.StartedFishing;
      if ( StartedFishing ) then
	 local elapsed = GetTime() - StartedFishing;
	 local t = math.floor(elapsed);
	 local seconds = math.mod(t, 60);
	 t = math.floor(t / 60);
	 local minutes = math.mod(t, 60);
	 local hours = math.floor(t / 60);
	 line = line.."  Elapsed: ";
	 if ( hours < 10 ) then
	    line = line.."0";
	 end
	 line = line..hours..":";
	 if ( minutes < 10 ) then
	    line = line.."0";
	 end
	 line = line..minutes..":";
	 if ( seconds < 10 ) then
	    line = line.."0";
	 end
	 line = line..seconds;
      end

      entry:SetText(line);
      local tempWidth = entry:GetWidth();
      if ( tempWidth > fishingWatchMaxWidth ) then
	 fishingWatchMaxWidth = tempWidth;
      end
      entry:Show();
      index = index + 1;
   end
   
   for j=1,table.getn(fishsort),1 do
      local info = fishsort[j];
      if( index <= MAX_FISHINGWATCH_LINES ) then
	 local entry = getglobal("FishingWatchLine"..index);
	 local fishie = info.text;
	 if ( fishie ) then
	    fishie = FishingBuddy.StripRaw(fishie);
	    local amount = info.count;
	    local fishietext = fishie.." ("..amount;
	    if ( dopercent == 1 ) then
	       local percent = format("%.1f", ( amount / totalCount ) * 100);
	       fishietext = fishietext.." : "..percent.."%";
	    end
	    if ( gotDiffs ) then
	       amount = info.current;
	       local color;
	       fishietext = fishietext..", |c"..FBConstants.Colors.GREEN..amount;
	       if ( dopercent == 1 ) then
		  local percent = format("%.1f", ( amount / totalCurrent ) * 100);
		  fishietext = fishietext.." : "..percent.."%";
	       end
	       fishietext = fishietext.."|r";
	    end
	    fishietext = fishietext..")";
	    entry:SetText(fishietext);
	    tempWidth = entry:GetWidth();
	    entry:Show();
	    if ( tempWidth > fishingWatchMaxWidth ) then
	       fishingWatchMaxWidth = tempWidth;
	    end
	    index = index + 1;
	 end
      end
   end

   FishingWatchFrame:SetHeight((index - 1) * 13);
   FishingWatchFrame:SetWidth(fishingWatchMaxWidth + 10);
   ShowDraggerFrame();
   PlaceDraggerFrame();
   FishingWatchFrame:Show();
end
FishingBuddy.WatchUpdate = WatchUpdate;

local WatchEvents = {};
WatchEvents["MINIMAP_ZONE_CHANGED"] = function()
   if ( not FishingBuddy.IsLoaded() ) then
      return;
   end
   FishingBuddy.currentFishies = {};
   WatchUpdate();
end

WatchEvents["SKILL_LINES_CHANGED"] = function()
   if ( FishingBuddy.GetSetting("WatchCurrentSkill") == 1 ) then
      WatchUpdate();
   end
end

WatchEvents["SPELLCAST_STOP"] = function()
   if ( FishingWatchFrame:IsVisible() ) then
      -- update the skill line if we have one
      if ( FishingBuddy.GetSetting("WatchCurrentSkill") == 1 ) then
         WatchUpdate();
      end
   end
end

WatchEvents[FBConstants.ADD_FISHIE_EVT] = function()
   if ( FishingWatchFrame:IsVisible() ) then
      WatchUpdate();
   end
end

FishingBuddy.WatchFrame.OnLoad = function()
   this:ClearAllPoints();
   this:SetPoint("TOPLEFT", "FishingWatchDrag", "TOPLEFT", 0, 0);

   -- Make everything draw at least once
   FishingWatchDrag:Show();
   FishingWatchTab:Show();
   FishingWatchDrag:Hide();
   FishingWatchTab:Hide();

   FishingBuddy.API.RegisterHandlers(WatchEvents);
end

local hover;
FishingBuddy.WatchFrame.OnUpdate = function(elapsed)
   if ( FishingWatchFrame:IsVisible() ) then
      if ( MouseIsOver(FishingWatchFrame) or
	  ( FishingWatchTab:IsVisible() and MouseIsOver(FishingWatchTab) ) ) then
	 local xPos, yPos = GetCursorPosition();
	 if ( hover ) then
	    if ( hover.xPos == xPos and hover.yPos == yPos ) then
	       hover.hoverTime = hover.hoverTime + elapsed;
	    else
	       hover.hoverTime = 0;
	       hover.xPos = xPos;
	       hover.yPos = yPos;
	    end
	 else
	    hover = {};
	    hover.hoverTime = 0;
	    hover.xPos = xPos;
	    hover.yPos = yPos;
	 end
	 if ( hover.hoverTime > WATCHDRAGGER_SHOW_DELAY ) then
	    ShowDraggerFrame();
	 end
      else
	 HideDraggerFrame(true);
	 hover = nil;
      end
   elseif ( hover ) then
      HideDraggerFrame(true);
      hover = nil;
   end
end

FishingBuddy.WatchFrame.OnMouseDown = function()
   if ( arg1 == "LeftButton" ) then
      FishingWatchDrag:StartMoving();
   end
end

FishingBuddy.WatchFrame.OnMouseUp = function()
   if ( arg1 == "LeftButton" ) then
      FishingWatchDrag:StopMovingOrSizing();
   end
end

local function HiddenFishToggle(id)
   if ( FishingBuddy_Info["HiddenFishies"][id] ) then
      FishingBuddy_Info["HiddenFishies"][id] = nil;
   else
      FishingBuddy_Info["HiddenFishies"][id] = true;
   end;
   FishingBuddy.WatchUpdate();
end

-- save some memory by keeping one copy of each one
local WatcherToggleFunctions = {};
-- let's use closures
local function WatcherMakeToggle(fishid)
   if ( not WatcherToggleFunctions[fishid] ) then
      local id = fishid;
      WatcherToggleFunctions[fishid] = function() HiddenFishToggle(id); end;
   end
   return WatcherToggleFunctions[fishid];
end
FishingBuddy.WatchFrame.MakeToggle = WatcherMakeToggle;

local function WatchMenu_Initialize()
   local zidx, sidx = FishingBuddy.GetZoneIndex();
   local fz = FishingBuddy_Info["FishingHoles"][zidx];
   if ( fz and fz[sidx] ) then
      local ff = FishingBuddy_Info["Fishies"];
      for fishid in fz[sidx] do
         info = {};
         info.text = ff[fishid].name;
         info.func = WatcherMakeToggle(fishid);
         info.checked = ( not FishingBuddy_Info["HiddenFishies"][fishid] );
         info.keepShownOnClick = 1;
         UIDropDownMenu_AddButton(info);
      end
   end
end

FishingBuddy.WatchFrame.OnClick = function()
   if ( arg1 == "RightButton" ) then
      local menu = getglobal("FishingBuddyWatcherMenu");
      UIDropDownMenu_Initialize(menu, WatchMenu_Initialize, "MENU");
      ToggleDropDownMenu(1, nil, menu, "FishingWatchDrag", 0, 0);
   end
end
