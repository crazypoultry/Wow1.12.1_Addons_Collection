-- Handle displaying all the fish in their habitats

FishingBuddy.Locations = {};

local NUM_THINGIES_DISPLAYED = 20;
FishingBuddy.Locations.FRAME_THINGIEHEIGHT = 16;

local Collapsed = false;
local LocationLineSelected = 0;
local LocationLines = {};
local LocationLastLine = 1;

local function MakeInfo(line, level, collapsible, expanded, hasicon, text, tipinfo, index, id)
   if ( not LocationLines[line] ) then
      LocationLines[line] = {};
   end
   LocationLines[line].level = level;
   LocationLines[line].collapsible = collapsible;
   LocationLines[line].expanded = expanded;
   LocationLines[line].hasicon = hasicon;
   LocationLines[line].text = text;
   LocationLines[line].tipinfo = tipinfo;
   if ( index ) then
      LocationLines[line].index = index;
   else
      LocationLines[line].index = text;
   end
   LocationLines[line].id = id;
   LocationLines[line].valid = true;
end

local function CountLocationLines()
   local linecount = 0;
   local j = 1;
   local limit = LocationLastLine;
   while ( j <= limit ) do
      local info = LocationLines[j];
      j = j + 1;
      if ( info and info.valid ) then
         linecount = linecount + 1;
         if ( info.collapsible and not info.expanded ) then
            local i2 = LocationLines[j];
            while ( i2 and i2.valid and (i2.level > info.level) ) do
               j = j + 1;
               i2 = LocationLines[j];
            end
         end         
      end
   end
   if ( linecount > 0 ) then
      -- I have no idea why this works this way at all
      if ( linecount > NUM_THINGIES_DISPLAYED and linecount < limit ) then
	 return linecount+1;
      else
	 return linecount;
      end
   else
      return 0;
   end
end

local function FishCount(zone, subzone)
   local zidx, sidx = FishingBuddy.GetZoneIndex(zone, subzone);
   local count = 0;
   local total = 0;
   local fh = FishingBuddy_Info["FishingHoles"];
   if( fh[zidx] and fh[zidx][sidx] ) then
      for fishie in fh[zidx][sidx] do
         count = count + 1;
         total = total + fh[zidx][sidx][fishie];
      end
   end
   return count, total;
end
FishingBuddy.FishCount = FishCount;

local function FishiesChanged()
   local fh = FishingBuddy_Info["FishingHoles"];
   local ff = FishingBuddy_Info["Fishies"];
   local line = 1
   local fishcount = table.getn(FishingBuddy.SortedFishies);
   local zonetotals = {};

   for i=1,fishcount,1 do
      local fishid = FishingBuddy.SortedFishies[i].id;
      local fishname = FishingBuddy.StripRaw(ff[fishid].name);
      local locsort = {};
      local total = 0;
      for indexer,count in FishingBuddy.ByFishie[fishid] do
         local _,_,zidx,sidx = string.find(indexer, "(%d+).(%d+)");
         zidx = tonumber(zidx);
         sidx = tonumber(sidx);
         if ( not zonetotals[zidx] ) then
            if ( fh[zidx] and fh[zidx][sidx] ) then
               local tot = 0;
               local fi = fh[zidx][sidx];
               for f in fi do
                  tot = tot + fi[f];
               end
               zonetotals[zidx] = tot;
            end
         end
         local info = {};
	 if ( FishingBuddy_Info["SubZones"][zidx] ) then
	    if ( not FishingBuddy_Info["SubZones"][zidx][sidx] ) then
	       info.text = FishingBuddy_Info["ZoneIndex"][zidx];
	    else
	       info.text = FishingBuddy_Info["SubZones"][zidx][sidx];
	    end
	 else
	    info.text = FBConstants.UNKNOWN;
	 end
         info.count = count;
         info.total = zonetotals[zidx];
         if ( not info.total or info.total == 0) then
            info.total = 1;
         end
         tinsert(locsort, info);
         total = total + count;
      end
      local tipinfo = {};
      tipinfo.total = total;
      if ( ff[fishid].level ) then
         tipinfo.level = ff[fishid].level;
      end
      MakeInfo(line, 0, true, true, true, fishname, extra, nil, fishid);
      line = line + 1;
      FishingBuddy.FishSort(locsort);
      for j=1,table.getn(locsort),1 do
         local zone = locsort[j].text;
         local amount = locsort[j].count;
         local total = locsort[j].total;
	 local percent = format(" (%.1f%%)", ( amount / total ) * 100);
         MakeInfo(line, 1, false, false, false, zone..percent, { amount = amount, total = total, title = zone });
         line = line + 1;
      end
   end
   LocationLastLine = line;
end

local function BothLocationsChanged()
   local fh = FishingBuddy_Info["FishingHoles"];
   local ff = FishingBuddy_Info["Fishies"];
   local sorted = FishingBuddy.SortedZones;
   local line = 1;
   local zonecount = table.getn(sorted);
   for i=1,zonecount,1 do
      local zone = sorted[i];
      local zidx = FishingBuddy.GetZoneIndex(zone);
      if ( fh[zidx] ) then
	 local where = zone;
	 MakeInfo(line, 0, true, true, false, zone, nil, where);
	 line = line + 1;
	 local subsorted = FishingBuddy.SortedByZone[zone];
	 local subcount = table.getn(subsorted);
	 for s=1,subcount,1 do
	    local subzone = subsorted[s];
	    local count, total = FishCount(zone, subzone);
	    if ( total > 0 ) then
	       local zidx, sidx = FishingBuddy.GetZoneIndex(zone, subzone);
	       where = zone.."."..subzone;
	       local tipinfo = {};
	       tipinfo.types = count;
	       tipinfo.total = total;
	       if ( FishingBuddy_Info["FishingSkill"][zidx] and FishingBuddy_Info["FishingSkill"][zidx][sidx] ) then
	          tipinfo.skill = FishingBuddy_Info["FishingSkill"][zidx][sidx];
	       end
	       if ( fh[zidx][sidx] ) then
		  MakeInfo(line, 1, true, true, false, subzone, tipinfo, where);
		  line = line + 1;
		  local fishsort = {};
		  for fishid in fh[zidx][sidx] do
		     local info = {};
		     info.id = fishid;
		     info.text = FishingBuddy.StripRaw(ff[fishid].name);
		     info.count = fh[zidx][sidx][fishid];
		     tinsert(fishsort, info);
		  end
		  FishingBuddy.FishSort(fishsort);
		  for j=1,table.getn(fishsort),1 do
		     local fishie = fishsort[j].text;
		     local id = fishsort[j].id;
		     local amount = fishsort[j].count;
		     local percent = format(" (%.1f%%)", ( amount / total ) * 100);
		     MakeInfo(line, 2, false, false, true, fishie..percent, { amount = amount, total = total, title = fishie }, nil, id);
		     line = line + 1;
		  end
	       end
	    end
	 end
      end
   end
   LocationLastLine = line;
end

local function SubZonesChanged()
   local fh = FishingBuddy_Info["FishingHoles"];
   local ff = FishingBuddy_Info["Fishies"];
   local mapping = {};
   for zone in fh do
      for subzone in fh[zone] do
         mapping[subzone] = zone;
      end
   end
   local line = 1;
   local zonecount = table.getn(FishingBuddy.SortedSubZones);
   for i=1,zonecount,1 do
      local subzone = FishingBuddy.SortedSubZones[i];
      local zone = mapping[subzone];
      local count, total = FishCount(zone, subzone);
      if ( total > 0 ) then
	 local zidx, sidx = FishingBuddy.GetZoneIndex(zone, subzone);
	 local tipinfo = nil;
	 if ( FishingBuddy_Info["FishingSkill"][zidx] and FishingBuddy_Info["FishingSkill"][zidx][sidx] ) then
        tipinfo = { skill = FishingBuddy_Info["FishingSkill"][zidx][sidx] };
	 end
	 MakeInfo(line, 0, true, true, false, subzone, tipinfo);
	 line = line + 1;
	 local fishsort = {};
	 for fishid in fh[zidx][sidx] do
	    local info = {};
	    info.id = fishid;
	    info.text = FishingBuddy.StripRaw(ff[fishid].name);
	    info.count = fh[zidx][sidx][fishid];
	    tinsert(fishsort, info);
	 end
	 FishingBuddy.FishSort(fishsort);
	 for j=1,table.getn(fishsort),1 do
	    local id = fishsort[j].id;
	    local fishie = fishsort[j].text;
	    local amount = fishsort[j].count;
	    local percent = format(" (%.1f%%)", ( amount / total ) * 100);
	    MakeInfo(line, 1, false, false, true, fishie..percent, { amount = amount, total = total, title = fishie} , nil, id);
	    line = line + 1;
	 end
      end
   end
   LocationLastLine = line;
end

local function LinesChanged()
   if ( FishingBuddy.GetSetting("GroupByLocation") == 1 ) then
      if ( FishingBuddy.GetSetting("ShowLocationZones") == 1 ) then
         BothLocationsChanged();
      else
         SubZonesChanged();
      end
   else
      FishiesChanged();
   end
   for i=LocationLastLine,table.getn(LocationLines) do
      local info = LocationLines[i];
      if ( info ) then
         info.valid = false;
      end
   end
   FishingLocationsFrame.valid = true;
end

-- local MOUSEWHEEL_DELAY = 0.1;
-- local lastScrollTime = nil;
-- function FishingLocationsFrame_OnMouseWheel(value)
--    local now = GetTime();
--    if ( not lastScrollTime ) then
--       lastScrollTime = now - 0.2;
--    end
--    if ( (now - lastScrollTime) > MOUSEWHEEL_DELAY ) then
--       -- call the old mouse wheel function somehow?
--    end
-- end

function FishingLocationsFrame_SetSelection(id, line)
   local info = LocationLines[line];
   FishingLocationHighlightFrame:Hide();
   if info then
      if ( info.collapsible ) then
         info.expanded = not info.expanded;
      else
         LocationLineSelected = line;
         FishingLocationHighlightFrame:SetPoint ( "TOPLEFT" ,  getglobal("FishingLocations"..id):GetName() , "TOPLEFT" , 5 , 0 )
         FishingLocationHighlightFrame:Show()
      end
   end
end

function FishingLocationsFrame_MoveButtonText(i, what)
   local relativeTo = "FishingLocations"..i..what;
   local textfield = getglobal("FishingLocations"..i.."Text");
   textfield:SetPoint("LEFT", relativeTo, "RIGHT", 2, 0);
end

FishingBuddy.Locations.Update = function(forced)
   if ( not FishingLocationsFrame:IsVisible() ) then
      return;
   end

   if ( forced or not FishingLocationsFrame.valid ) then
      LinesChanged();
   end

   local offset = FauxScrollFrame_GetOffset(FishingLocsScrollFrame);
   FauxScrollFrame_Update( FishingLocsScrollFrame, CountLocationLines(),
                          NUM_THINGIES_DISPLAYED,
                          FishingBuddy.Locations.FRAME_THINGIEHEIGHT,
			  nil, nil, nil,
			  FishingLocationHighlightFrame,
			  230, 230
		       );

   local lastlevel = 0;
   FishingLocationHighlightFrame:Hide();
   local j = 1;
   local o = 1;
   while ( o < offset ) do
      local info = LocationLines[j];
      if ( info ) then
         j = j + 1;
         o = o + 1;
         if ( info.collapsible and not info.expanded ) then
            local i2 = LocationLines[j];
            while ( i2 and i2.level > info.level ) do
               j = j + 1;
               i2 = LocationLines[j];
            end
         end
      end
   end
   for i = 1,NUM_THINGIES_DISPLAYED,1 do
      local locButton = getglobal ( "FishingLocations"..i );
      local info = LocationLines[j];
      if ( info and info.valid ) then
         local icon = getglobal("FishingLocations"..i.."Icon");
         local icontex = getglobal("FishingLocations"..i.."IconTexture");
         locButton.id = i;
         locButton.line = j;

         local leveloffset = (info.level - lastlevel)*16;
         if ( i == 1 ) then
            locButton:SetPoint("TOPLEFT", leveloffset+25, -100);
         else
            local t = i - 1;
            locButton:SetPoint("TOPLEFT", "FishingLocations"..t, "BOTTOMLEFT", leveloffset, 0);
         end
         lastlevel = info.level;

         local text = info.text;
         if text and info.extra then
            text = text .. info.extra;
         end
         locButton.tipinfo = info.tipinfo;

         icon:ClearAllPoints();
         if ( info.collapsible ) then
            icon:SetPoint("LEFT", "FishingLocations"..i, "LEFT", 21, 0);
            locButton:SetTextColor( 1, 0.82, 0 );
            if ( info.expanded ) then
               locButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
            else
               locButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
            end
            getglobal("FishingLocations"..i.."Highlight"):SetTexture("Interface\\Buttons\\UI-PlusButton-Hilight");
            getglobal("FishingLocations"..i):UnlockHighlight();
         else
            icon:SetPoint("LEFT", "FishingLocations"..i, "LEFT", 3, 0);
            locButton:SetTextColor( .5, .5, .5 );
            locButton:SetNormalTexture("");
            getglobal("FishingLocations"..i.."Highlight"):SetTexture("");
            -- Place the highlight and lock the highlight state
            if ( LocationLineSelected == j ) then
               FishingLocationHighlightFrame:SetPoint("TOPLEFT", "FishingLocations"..i, "TOPLEFT", 21, 0);
               FishingLocationHighlightFrame:Show();
               locButton:LockHighlight();
            else
               locButton:UnlockHighlight();
            end
         end

         locButton.tooltip = nil;
         if ( info.hasicon ) then
            local item, texture, _, _, _ = FishingBuddy.GetFishie(info.id);
            locButton.item = item;
	    locButton.fishid = info.id;
            locButton.name = info.text;
            if( texture ) then
               icontex:SetTexture(texture);
               icon:Show();
               icontex:Show();
            end
            FishingLocationsFrame_MoveButtonText(i, "Icon");
         else
            locButton.item = nil;
	    locButton.fishid = nil;
            locButton.name = nil;
            icontex:SetTexture("");
            icontex:Hide();
            icon:Hide();
            FishingLocationsFrame_MoveButtonText(i, "Highlight");
         end

         if ( info.tipinfo ) then
	    local color = FBConstants.Colors.GREEN;
	    if ( locButton.item and
		 not FishingBuddy.IsLinkableItem(locButton.item) ) then
	       color = FBConstants.Colors.RED;
	    end
	    text = text.."|c"..color.."*|r";
         end
         locButton:SetText( text );
         locButton:Show();
         j = j + 1;
         if ( info.collapsible and not info.expanded ) then
            local i2 = LocationLines[j];            
            while ( i2 and (i2.level > info.level) ) do
               j = j + 1;
               i2 = LocationLines[j];
            end
         end
      else
         locButton:Hide();
         locButton.id = nil;
         locButton.line = nil;
      end
   end

   if ( LocationLines ) then
      -- Set the expand/collapse all button texture
      local numHeaders = 0;
      local notExpanded = 0;
      for i=1,table.getn(LocationLines),1 do
         local j = i + offset;
         local info = LocationLines[j];
         if ( info and info.collapsible ) then
            numHeaders = numHeaders + 1;
            if ( not info.expanded ) then
               notExpanded = notExpanded + 1;
            end
         end
      end
      FishingLocationsCollapseAllButton:Show();
      -- If all headers are not expanded then show collapse button, otherwise show the expand button
      if ( notExpanded ~= numHeaders ) then
         Collapsed = false;
         FishingLocationsCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up");
      else
         Collapsed = true;
         FishingLocationsCollapseAllButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up");
      end
   else
      FishingLocationsCollapseAllButton:Hide();
   end
end

local OptionHandlers = {};
local function FishOptionsInitialize()
   local menu = getglobal("FishingBuddyLocationsMenu");
   if ( menu.fishid ) then
      local fishid = menu.fishid;
      local ff = FishingBuddy_Info["Fishies"];

      local info = {};
      info.text = FBConstants.HIDEINWATCHER;
      info.func = FishingBuddy.WatchFrame.MakeToggle(fishid);
      info.checked = ( not FishingBuddy_Info["HiddenFishies"][fishid] );
      UIDropDownMenu_AddButton(info);

      for idx,handler in pairs(OptionHandlers) do
	 handler(fishid);
      end
   end
end

FishingBuddy.Locations.Button_OnClick = function(button)
   if ( button == "LeftButton" ) then
      if( IsShiftKeyDown() and this.item ) then
         FishingBuddy.ChatLink(this.item, this.name, this.color);
      elseif ( this.id and this.line ) then
         FishingLocationsFrame_SetSelection(this.id, this.line);
         FishingBuddy.Locations.Update();
      end
   elseif ( this.fishid and button == "RightButton" ) then
      local menu = getglobal("FishingBuddyLocationsMenu");
      
      menu.fishid = this.fishid;
      UIDropDownMenu_Initialize(menu, FishOptionsInitialize, "MENU");
      FishingBuddy.ToggleDropDownMenu(1, nil, menu, this, 0, 0);
   end
end

function FishingLocationsCollapseAllButton_OnClick()
   if not Collapsed then
      FishingLocsScrollFrameScrollBar:SetValue(0);
      LocationLineSelected = 1;
   end
   for _,info in LocationLines do
      info.expanded = Collapsed;
   end
   Collapsed = not Collapsed;
   FishingBuddy.Locations.Update();
end

FishingBuddy.Locations.Button_OnEnter = function()
   if( GameTooltip.locbutfini ) then
      return;
   end
   if ( this.item or this.tooltip or this.tipinfo ) then
      GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
   end

   local gottitle;
   if( this.item or this.tooltip ) then
      gottitle = true;
      if ( this.item and this.item ~= "" ) then
         if ( FishingBuddy.IsLinkableItem(this.item) ) then
            GameTooltip:SetHyperlink("item:"..this.item);
         else
            this.tooltip = {}
            this.tooltip[1] = { ["text"] = this.name };
            this.tooltip[2] = { ["text"] = FBConstants.NOTLINKABLE, ["r"] = 1.0, ["g"] = 0, ["b"] = 0 };
            FishingBuddy.AddTooltip(this.tooltip);
            this.item = nil;
         end
      elseif ( this.tooltip ) then
         FishingBuddy.AddTooltip(this.tooltip, 1, 1, 1);
      end
   end
   if ( this.tipinfo ) then
      local ti = this.tipinfo;
      local line;
      if ( ti.title ) then
	 GameTooltip:AddLine(ti.title);
      elseif ( not gottitle ) then
	 GameTooltip:AddLine(this:GetText());
      end
      if ( ti.types ) then
	 GameTooltip:AddLine(string.format(FBConstants.FISHTYPES, ti.types));
      end
      if ( ti.amount ) then
	 line = string.format(FBConstants.CAUGHTTHISMANY, ti.amount);
      end
      if ( ti.total ) then
	 if ( not line ) then
	    line = "";
	 else
	    line = line.."/";
	 end
	 line = line..string.format(FBConstants.CAUGHTTHISTOTAL, ti.total);
      end
      if ( ti.percent ) then
	 if ( not line ) then
	    line = "";
	 else
	    line = line.." ";
	 end
	 line = line.."("..ti.percent.."%)";
      end
      if ( line ) then
	 GameTooltip:AddLine(line, 1, 1, 1);
      end
      if ( ti.skill ) then
	 line = string.format(FBConstants.MINIMUMSKILL, ti.skill);
	 GameTooltip:AddLine(line, 0, 1, 0);
      end
   end
   GameTooltip.locbutfini = 1;
   GameTooltip:Show();
end

FishingBuddy.Locations.Button_OnLeave = function()
   if( this.item or this.tooltip or this.tipinfo ) then
      GameTooltip:Hide();
   end
   GameTooltip.locbutfini = nil;
end

FishingBuddy.Locations.DisplayChanged = function()
   FishingLocsScrollFrameScrollBar:SetValue(0);
   LocationLineSelected = 1;
   FishingBuddy.Locations.Update(true);
end

local function UpdateButtonDisplay()
   if ( FishingBuddy.GetSetting("GroupByLocation") == 1 ) then
      FishingLocationsSwitchButton:SetText(FBConstants.SHOWFISHIES);
      FishingBuddyOptionSLZ:Show();
   else
      FishingLocationsSwitchButton:SetText(FBConstants.SHOWLOCATIONS);
      FishingBuddyOptionSLZ:Hide();
   end
end

FishingBuddy.Locations.SwitchDisplay = function()
   -- backwards logic check, we're about to change...
   local setting = FishingBuddy.GetSetting("GroupByLocation");
   setting = 1 - setting;
   FishingBuddy.SetSetting("GroupByLocation", setting);
   UpdateButtonDisplay();
   FishingBuddy.Locations.DisplayChanged();
end

FishingBuddy.Locations.SwitchButton_OnEnter = function()
   if ( FishingBuddy.GetSetting("GroupByLocation") == 1 ) then
      GameTooltip:SetText(FBConstants.SHOWFISHIES_INFO);
   else
      GameTooltip:SetText(FBConstants.SHOWLOCATIONS_INFO);
   end
   GameTooltip:Show();
end

local LocationEvents = {};
LocationEvents[FBConstants.ADD_FISHIE_EVT] = function()
   FishingLocationsFrame.valid = false;
end

FishingBuddy.Locations.OnLoad = function()
   this:RegisterEvent("VARIABLES_LOADED");
   FishingLocationsSwitchButton:SetText(FBConstants.SHOWFISHIES);
   -- Set up checkbox
   FishingBuddyOptionSLZ.name = "ShowLocationZones";
   FishingBuddyOptionSLZ.text = FBConstants.CONFIG_SHOWLOCATIONZONES_ONOFF;
   FishingBuddyOptionSLZ.tooltip = FBConstants.CONFIG_SHOWLOCATIONZONES_INFO;

   FishingBuddy.API.RegisterHandlers(LocationEvents);
end

FishingBuddy.Locations.OnShow = function()
   if ( FishingBuddy.IsLoaded() ) then
      UpdateButtonDisplay();
      FishingBuddy.Locations.Update();
   end
end

FishingBuddy.Locations.OnEvent = function()
   -- this crashes the client when enabled
   -- this:EnableMouseWheel(0);
end

FishingBuddy.Locations.DataChanged = function(zone, subzone, fishie)
   FishingLocationsFrame.valid = false;
end

FishingBuddy.ShowLocLine = function(j)
   FishingBuddy.Dump(LocationLines[j]);
end

FishingBuddy.Locations.PerFishOptions = function(handler)
   local found = false;
   for idx,h in pairs(OptionHandlers) do
      if ( h == handler ) then
	 found = true;
      end
   end
   if ( not found ) then
      table.insert(OptionHandlers, handler);
   end
end
