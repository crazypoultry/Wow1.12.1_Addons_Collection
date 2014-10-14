-- Handle tracking cycle fish

FishingBuddy.TrackingFrame = {};

local GRAPH_HEIGHT = 120;

local trackingWordMap = {
   ["WEEKLY"] = FishingBuddy.WEEKLY,
   ["HOURLY"] = FishingBuddy.HOURLY,
   [FishingBuddy.WEEKLY] = "WEEKLY",
   [FishingBuddy.HOURLY] = "HOURLY",
};

local byhours = {
   [13759] = {
      ["enUS"] = "Raw Nightfin Snapper",
      ["deDE"] = "Roher Nachtflossenschnapper",
      ["frFR"] = "Lutjan nagenuit cru",
      ["c"] = { r = 0.5, g = 0.5, b = 1.0, a = 0.75 },
   },
   [13760] = {
      ["enUS"] = "Raw Sunscale Salmon",
      ["deDE"] = "Roher Sonnenschuppenlachs",
      ["frFR"] = "Saumon sol\195\169caille cru",
     ["c"] = { r = 0.8, g = 0.8, b = 0.1, a = 0.75 },
   },
};
local byweeks = {
   [13756] = {
      ["enUS"] = "Raw Summer Bass",
      ["deDE"] = "Roher Sommerbarsch",
      ["frFR"] = "Perche estivale crue",
      ["c"] = { r = 1.0, g = 1.0, b = 0.0, a = 0.75 },
   },
   [13755] = {
      ["enUS"] = "Winter Squid",
      ["deDE"] = "Winterkalmar",
      ["frFR"] = "Calmar hivernal",
      ["c"] = { r = 0.4, g = 0.1, b = 0.4, a = 0.75 },
   },
};

local function UntrackThis(id, name)
   if ( not byhours[id] and not byweeks[id] ) then
      for how in FishingBuddy_Info["FishTracking"] do
	 if ( FishingBuddy_Info["FishTracking"][how][id] ) then
	    FishingBuddy_Info["FishTracking"][how][id] = nil;
	    FishingBuddy.Print(FishingBuddy.NOTRACKMSG, name);
	 end
      end
   else
      FishingBuddy.Message(FishingBuddy.NOTRACKERRMSG);
   end
end

local function TrackThis(how, id, color, name)
   if ( not FishingBuddy_Info["FishTracking"][how] ) then
      FishingBuddy_Info["FishTracking"][how] = {};
   end
   local limit = 23;
   if ( how == "WEEKLY" ) then
      limit = 52;
   end
   if ( not FishingBuddy_Info["FishTracking"][how][id] ) then
      FishingBuddy_Info["FishTracking"][how][id] = {};
      FishingBuddy_Info["FishTracking"][how][id].data = {};
      for i=0,limit,1 do
	 FishingBuddy_Info["FishTracking"][how][id].data[i] = 0;
      end
      FishingBuddy_Info["FishTracking"][how][id].data.n = limit+1;
   end
   if ( name and not FishingBuddy_Info["FishTracking"][how][id].name ) then
      FishingBuddy_Info["FishTracking"][how][id].name = name;
   end
   if ( color ) then
      if ( type(color) == "string") then
	 local a = tonumber(string.sub(color,1,2),16);
	 local r = tonumber(string.sub(color,3,4),16);
	 local g = tonumber(string.sub(color,5,6),16);
	 local b = tonumber(string.sub(color,7,8),16);
	 color = { a = a, r = r, g = g, b = b };
      end
      FishingBuddy_Info["FishTracking"][how][id].color = color;
   end
end
FishingBuddy.TrackThis = TrackThis;

FishingBuddy.Commands[FishingBuddy.TRACK] = {};
FishingBuddy.Commands[FishingBuddy.TRACK].args = {};
FishingBuddy.Commands[FishingBuddy.TRACK].args[1] = "[%w]+";
FishingBuddy.Commands[FishingBuddy.TRACK].args[2] = "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[.-%]|h|r";
FishingBuddy.Commands[FishingBuddy.TRACK].help = FishingBuddy.TRACKING_HELP;
FishingBuddy.Commands[FishingBuddy.TRACK].func =
   function(how, fishlink)
      if ( how and (how == FishingBuddy.HOURLY or
		     how == FishingBuddy.WEEKLY)) then
	 local c, i, n = FishingBuddy.SplitFishLink(fishlink);
	 if ( i ) then
	    TrackThis(trackingWordMap[how], i, c, n);
	    FishingBuddy.Print(FishingBuddy.TRACKINGMSG, n, how);
	    return true;
	 end
      end
   end;
FishingBuddy.Commands[FishingBuddy.NOTRACK] = {};
FishingBuddy.Commands[FishingBuddy.NOTRACK].args = {};
FishingBuddy.Commands[FishingBuddy.NOTRACK].args[1] = "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[.-%]|h|r";
FishingBuddy.Commands[FishingBuddy.NOTRACK].help = FishingBuddy.TRACKING_HELP;
FishingBuddy.Commands[FishingBuddy.NOTRACK].func =
   function(fishlink)
      local c, i, n = FishingBuddy.SplitFishLink(fishlink);
      if ( i ) then
	 UntrackThis(i, n);
	 return true;
      end
   end;
FishingBuddy.Commands[FishingBuddy.TRACKING] = {};
FishingBuddy.Commands[FishingBuddy.TRACKING].help = FishingBuddy.TRACKING_HELP;
FishingBuddy.Commands[FishingBuddy.TRACKING].func =
   function()
      local pr = FishingBuddy.Print;
      for jdx in FishingBuddy_Info["FishTracking"] do
	 local how = trackingWordMap[jdx];
	 pr("Tracking "..how);
	 local ft = FishingBuddy_Info["FishTracking"];
	 for id in ft[jdx] do
	    local name;
	    if ( ft[jdx][id].name ) then
	       name = ft[jdx][id].name;
	    else
	       name = id;
	    end
	    local line = name.."; ";
	    for k,v in ft[jdx][id].data do
	       line = line.." "..k..": "..v;
	    end
	    pr(line);
	 end
      end
      return true;
   end;

FishingBuddy.InitTracking = function()
   if ( not FishingBuddy_Info["FishTracking"] ) then
      FishingBuddy_Info["FishTracking"] = { };
   end
   for k,v in byhours do
      TrackThis("HOURLY", k, v.c);
   end
   for k,v in byweeks do
      TrackThis("WEEKLY", k, v.c);
   end
end

FishingBuddy.AddTracking = function(id, name)
   local ft = FishingBuddy_Info["FishTracking"];
   local index, how;

   -- clean up fish removed from the tracking system
   local hourly = ft["HOURLY"][id];
   local weekly = ft["WEEKLY"][id];
   if ( hourly and hourly.nevermore ) then
      FishingBuddy_Info["FishTracking"]["HOURLY"][id] = nil;
   end
   if ( weekly and weekly.nevermore ) then
      FishingBuddy_Info["FishTracking"]["WEEKLY"][id] = nil;
   end

   ft = FishingBuddy_Info["FishTracking"];
   if ( ft["HOURLY"][id] ) then
      how = "HOURLY";
      index,_ = GetGameTime();
   elseif ( ft["WEEKLY"][id] ) then
      how = "WEEKLY";
      index = date("%W");
   else
      return false;
   end
   if ( not FishingBuddy_Info["FishTracking"][how][id].name ) then
      FishingBuddy_Info["FishTracking"][how][id].name = name;
   end
   index = tonumber(index);

   local p = FishingBuddy.printable;
   FishingBuddy_Info["FishTracking"][how][id].data[index] =
      FishingBuddy_Info["FishTracking"][how][id].data[index] + 1;
   return true;
end

local function PlotData(graph, num, bw, bs, graphdata, plotthese, hlabels)
   local maxval = 0;
   local width = 0;
   local line;
   GraphHandler.ClearPlot(graph);
   for _,info in graphdata do
      if ( info.maxval and info.maxval > maxval ) then
	 maxval = info.maxval;
      end
      local w = info.count * (bw+bs);
      if ( w > width ) then
	 width = w;
      end
   end
   local delta = math.mod(maxval, 5);
   if ( delta > 0 ) then
      maxval = maxval + (5 - delta);
   end
   graph.maxVal = maxval;
   graph.barWidth = bw;
   graph.barSpacing = bs;
   local count = num;
   for idx,fishid in plotthese do
      local info = graphdata[fishid];
      local c = info.color;
      GraphHandler.PlotLegend(graph, num-count+1,
			      info.name, info.item, info.texture,
			      c.r, c.g, c.b);
      _ = GraphHandler.PlotData(graph, info.data, num-count, 1,
					 c.r, c.g, c.b);
      if ( line ) then
         line = line.." / "..info.name;
      else
         line = info.name;
      end
      count = count - 1;
   end
   local values = {};
   local delta = maxval/5;
   for v=0,5 do
      values[string.format("%d", v*delta)] = v;
   end
   GraphHandler.PlotGrid(graph, line or "", values, width, hlabels);
end

local function UpdateGraphData(id, info)
   local maxval = 0;
   local n = table.getn(info.data);
   info.count = n;
   -- we're zero based
   n = n - 1;
   for idx=0,n do
      if ( info.data[idx] > maxval ) then
         maxval = info.data[idx];
      end
   end
   info.maxval = maxval;
   info.data = info.data;
   if ( not info.color ) then
      info.color = {};
   else
      if ( type(info.color) == "string") then
         local a = tonumber(string.sub(color,1,2),16);
         local r = tonumber(string.sub(color,3,4),16);
         local g = tonumber(string.sub(color,5,6),16);
         local b = tonumber(string.sub(color,7,8),16);
         info.color = { a = a, r = r, g = g, b = b };
      end
   end
   local name;
   info.item, info.texture, _, _, _, name = FishingBuddy.GetFishie(id);
   local loc = GetLocale();
   if ( not info.name ) then
      if ( byhours[id] and byhours[id][loc] ) then
         info.name = byhours[id][loc];
      elseif ( byweeks[d] and byweeks[id][loc] ) then
         info.name = byweeks[id][loc];
      elseif ( not name ) then
         info.name = FishingBuddy.FISH.." ("..id..")";
      else
         info.name = name;
      end
   end
   info.name = FishingBuddy.StripRaw(info.name);
end

local function DrawTrackingGraph(how, num, bw, bs)
   local fi = FishingBuddy_Info["FishTracking"];
   local graph;
   local labels;
   if ( how == "HOURLY" ) then
      graph = getglobal("FishingTrackingFrameGraph1");
      labels = {["00:00"] = 0, ["06:00"] = 6, ["12:00"] = 12, ["18:00"] = 18, ["23:59"] = 24};
      if ( not num ) then
         num = 2;
         bw = 5;
         bs = 5;
      end
   else
      graph = getglobal("FishingTrackingFrameGraph2");
      labels = FishingBuddy.BYWEEKS_TABLE;
      if ( not num ) then
         num = 2;
         bw = 3;
         bs = 2;
      end
   end
   local plotthese = {};
   local count = 0;
   graph.tracking = how;
   for id,info in fi[how] do
      UpdateGraphData(id, info);
      if ( count < num and fi[how][id].plot == 1 ) then
         count = count + 1;
         tinsert(plotthese, id);
      end
   end
   PlotData(graph, num, bw, bs, fi[how], plotthese, labels);
end

local function DrawTrackingGraphs()
   DrawTrackingGraph("HOURLY");
   DrawTrackingGraph("WEEKLY");
end

local function PlotFishToggle(fishid, how)
   local tab = FishingBuddy_Info["FishTracking"][how];
   if ( not tab[fishid].plot ) then
      tab[fishid].plot = 1;
   else
      tab[fishid].plot = 1 - tab[fishid].plot;
   end
   DrawTrackingGraph(how);
end

local PlotToggleFunctions = {};
local function PlotMakeToggle(fishid, how)
   if ( not PlotToggleFunctions[fishid] ) then
      local id = fishid;
      local h = how;
      PlotToggleFunctions[fishid] = function() PlotFishToggle(id, h); end;
   end
   return PlotToggleFunctions[fishid];
end

local function PlotMenuInitialize()
   local fi = FishingBuddy_Info["FishTracking"];
   local ff = FishingBuddy_Info["Fishies"];
   local how = this.tracking;
   local locale = GetLocale();
   for id,_ in fi[how] do
      if ( not fi[how][id].plot ) then
         fi[how][id].plot = 1;
      end
      info = {};
      if ( ff[id] and ff[id].name ) then
	 info.text = ff[id].name;
      elseif ( byhours[id] ) then
	 info.text = byhours[id][locale];
      elseif ( byweeks[id] ) then
	 info.text = byweeks[id][locale];
      end
      if ( info.text ) then
	 info.func = PlotMakeToggle(id, how);
	 info.checked = ( fi[how][id].plot == 1 );
	 UIDropDownMenu_AddButton(info);
      end
   end
end

FishingBuddy.TrackingFrame.OnClick = function(button, graph)
   if ( button == "RightButton" ) then
      local menu = getglobal("FishingBuddyGraphMenu");
      menu.tracking = this.tracking;
      menu.point = "CENTER";
      menu.relativePoint = "CENTER";
      UIDropDownMenu_Initialize(menu, PlotMenuInitialize, "MENU");
      FishingBuddy.ToggleDropDownMenu(1, nil, menu, this, 0, 0);
   end
end

FishingBuddy.TrackingFrame.OnShow = function()
   DrawTrackingGraphs();
end

FishingBuddy.TrackingFrame.OnEnter = function()
   GameTooltip_AddNewbieTip(FishingBuddy.TRACKINGFRAME, 1.0, 1.0, 1.0, 
      FishingBuddy.TRACKINGFRAME_CLICKS, 1);
end

FishingBuddy.TrackingFrame.OnLeave = function()
   GameTooltip:Hide();
end

