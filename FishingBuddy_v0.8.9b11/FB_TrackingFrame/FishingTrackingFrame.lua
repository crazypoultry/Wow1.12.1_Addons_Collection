-- Handle tracking cycle fish

FB_TFConstants = {};

-- set up
FishingBuddy.Setup.Translate("FB_OutfitDisplayFrame", FB_TFTranslations, FB_TFConstants);

local byweeks = {};
byweeks[FB_TFConstants.ABBREV_JANUARY] = 0;
byweeks[FB_TFConstants.ABBREV_APRIL] = 13;
byweeks[FB_TFConstants.ABBREV_JULY] = 26;
byweeks[FB_TFConstants.ABBREV_OCTOBER] = 39;
byweeks[FB_TFConstants.ABBREV_DECEMBER] = 52;

FB_TFConstants.BYWEEKS_TABLE = byweeks;

if ( FishingBuddy_Info and FishingBuddy_Info["FishTracking"] ) then
   PBTF_Info = {};
   for k,v in pairs(FishingBuddy_Info["FishTracking"]) do
      PBTF_Info[k] = v;
   end
   FishingBuddy_Info["FishTracking"] = nil;
end
-- free up the space
FB_TFTranslations = nil;

--

FB_TrackingFrame = {};

local GRAPH_HEIGHT = 120;

local trackingWordMap = {
   ["WEEKLY"] = FBConstants.WEEKLY,
   ["HOURLY"] = FBConstants.HOURLY,
   [FBConstants.WEEKLY] = "WEEKLY",
   [FBConstants.HOURLY] = "HOURLY",
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
      for how in pairs(PBTF_Info) do
	 if ( PBTF_Info[how][id] ) then
	    PBTF_Info[how][id] = nil;
	    FishingBuddy.Print(FB_TFConstants.NOTRACKMSG, name);
	 end
      end
   else
      FishingBuddy.Message(FB_TFConstants.NOTRACKERRMSG);
   end
end

local function TrackThis(how, id, color, name)
   if ( not PBTF_Info[how] ) then
      PBTF_Info[how] = {};
   end
   local limit = 23;
   if ( how == "WEEKLY" ) then
      limit = 52;
   end
   if ( not PBTF_Info[how][id] ) then
      PBTF_Info[how][id] = {};
      PBTF_Info[how][id].data = {};
      for i=0,limit,1 do
	 PBTF_Info[how][id].data[i] = 0;
      end
      PBTF_Info[how][id].data.n = limit+1;
   end
   if ( name and not PBTF_Info[how][id].name ) then
      PBTF_Info[how][id].name = name;
   end
   if ( color ) then
      if ( type(color) == "string") then
	 local a = tonumber(string.sub(color,1,2),16);
	 local r = tonumber(string.sub(color,3,4),16);
	 local g = tonumber(string.sub(color,5,6),16);
	 local b = tonumber(string.sub(color,7,8),16);
	 color = { a = a, r = r, g = g, b = b };
      end
      PBTF_Info[how][id].color = color;
   end
end
FishingBuddy.TrackThis = TrackThis;

FishingBuddy.Commands[FB_TFConstants.TRACK] = {};
FishingBuddy.Commands[FB_TFConstants.TRACK].args = {};
FishingBuddy.Commands[FB_TFConstants.TRACK].args[1] = "[%w]+";
FishingBuddy.Commands[FB_TFConstants.TRACK].args[2] = "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[.-%]|h|r";
FishingBuddy.Commands[FB_TFConstants.TRACK].help = FB_TFConstants.TRACKING_HELP;
FishingBuddy.Commands[FB_TFConstants.TRACK].func =
   function(how, fishlink)
      if ( how and (how == FBConstants.HOURLY or
		     how == FBConstants.WEEKLY)) then
	 local c, i, n = FishingBuddy.SplitFishLink(fishlink);
	 if ( i ) then
	    TrackThis(trackingWordMap[how], i, c, n);
	    FishingBuddy.Print(FB_TFConstants.TRACKINGMSG, n, how);
	    return true;
	 end
      end
   end;
FishingBuddy.Commands[FB_TFConstants.NOTRACK] = {};
FishingBuddy.Commands[FB_TFConstants.NOTRACK].args = {};
FishingBuddy.Commands[FB_TFConstants.NOTRACK].args[1] = "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[.-%]|h|r";
FishingBuddy.Commands[FB_TFConstants.NOTRACK].help = FB_TFConstants.TRACKING_HELP;
FishingBuddy.Commands[FB_TFConstants.NOTRACK].func =
   function(fishlink)
      local c, i, n = FishingBuddy.SplitFishLink(fishlink);
      if ( i ) then
	 UntrackThis(i, n);
	 return true;
      end
   end;
FishingBuddy.Commands[FB_TFConstants.TRACKING] = {};
FishingBuddy.Commands[FB_TFConstants.TRACKING].help = FB_TFConstants.TRACKING_HELP;
FishingBuddy.Commands[FB_TFConstants.TRACKING].func =
   function()
      local pr = FishingBuddy.Print;
      for jdx in pairs(PBTF_Info) do
	 local how = trackingWordMap[jdx];
	 pr("Tracking "..how);
	 local ft = PBTF_Info;
	 for id in pairs(ft[jdx]) do
	    local name;
	    if ( ft[jdx][id].name ) then
	       name = ft[jdx][id].name;
	    else
	       name = id;
	    end
	    local line = name.."; ";
	    for k,v in pairs(ft[jdx][id].data) do
	       line = line.." "..k..": "..v;
	    end
	    pr(line);
	 end
      end
      return true;
   end;

local function InitTracking()
   if ( not PBTF_Info ) then
      PBTF_Info = { };
   end
   for k,v in pairs(byhours) do
      TrackThis("HOURLY", k, v.c);
   end
   for k,v in pairs(byweeks) do
      TrackThis("WEEKLY", k, v.c);
   end
end

local function AddTracking(id, name)
   local ft = PBTF_Info;
   local index, how;

   -- clean up fish removed from the tracking system
   local hourly = ft["HOURLY"][id];
   local weekly = ft["WEEKLY"][id];
   if ( hourly and hourly.nevermore ) then
      PBTF_Info["HOURLY"][id] = nil;
   end
   if ( weekly and weekly.nevermore ) then
      PBTF_Info["WEEKLY"][id] = nil;
   end

   ft = PBTF_Info;
   if ( ft["HOURLY"][id] ) then
      how = "HOURLY";
      index,_ = GetGameTime();
   elseif ( ft["WEEKLY"][id] ) then
      how = "WEEKLY";
      index = date("%W");
   else
      return false;
   end
   if ( not PBTF_Info[how][id].name ) then
      PBTF_Info[how][id].name = name;
   end
   index = tonumber(index);

   local p = FishingBuddy.printable;
   PBTF_Info[how][id].data[index] =
      PBTF_Info[how][id].data[index] + 1;
   return true;
end
FishingBuddy.AddTracking = AddTracking;

local function PlotData(graph, num, bw, bs, graphdata, plotthese, hlabels)
   local maxval = 0;
   local width = 0;
   local line;
   GraphHandler.ClearPlot(graph);
   for _,info in pairs(graphdata) do
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
   for idx,fishid in pairs(plotthese) do
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
      elseif ( byweeks[id] and byweeks[id][loc] ) then
         info.name = byweeks[id][loc];
      elseif ( not name ) then
         info.name = FBConstants.FISH.." ("..id..")";
      else
         info.name = name;
      end
   end
   info.name = FishingBuddy.StripRaw(info.name);
end

local function DrawTrackingGraph(how, num, bw, bs)
   local fi = PBTF_Info;
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
      labels = FBConstants.BYWEEKS_TABLE;
      if ( not num ) then
         num = 2;
         bw = 3;
         bs = 2;
      end
   end
   local plotthese = {};
   local count = 0;
   graph.tracking = how;
   for id,info in pairs(fi[how]) do
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
   local tab = PBTF_Info[how];
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
   local fi = PBTF_Info;
   local ff = FishingBuddy_Info["Fishies"];
   local how = this.tracking;
   local locale = GetLocale();
   for id,_ in pairs(fi[how]) do
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

FB_TrackingFrame.OnClick = function(button, graph)
   if ( button == "RightButton" ) then
      local menu = getglobal("FishingBuddyGraphMenu");
      menu.tracking = this.tracking;
      menu.point = "CENTER";
      menu.relativePoint = "CENTER";
      UIDropDownMenu_Initialize(menu, PlotMenuInitialize, "MENU");
      FishingBuddy.ToggleDropDownMenu(1, nil, menu, this, 0, 0);
   end
end

FB_TrackingFrame.OnShow = function()
   DrawTrackingGraphs();
end

FB_TrackingFrame.OnEnter = function()
   GameTooltip_AddNewbieTip(FB_TFConstants.TRACKINGFRAME, 1.0, 1.0, 1.0, 
      FB_TFConstants.TRACKINGFRAME_CLICKS, 1);
end

FB_TrackingFrame.OnLeave = function()
   GameTooltip:Hide();
end

local TrackingEvents = {};
TrackingEvents[FBConstants.ADD_FISHIE_EVT] = function(id, name, zone, subzone)
   AddTracking(id, name);
end

FB_TrackingFrame.OnLoad = function()
   this:RegisterEvent("VARIABLES_LOADED");
   InitTracking();
end

local function TrackFishToggle(fishid, how)
   local tab = PBTF_Info[how];
   if ( not tab[fishid] ) then
      local ff = FishingBuddy_Info["Fishies"];
      FishingBuddy.TrackThis(how, fishid, ff[fishid].color, ff[fishid].name);
   else
      if ( not tab[fishid].nevermore ) then
         tab[fishid].nevermore = true;
      else
         tab[fishid].nevermore = nil;
      end
   end
end

local function MakeTrackFishToggle(fishid, how)
   local id = fishid;
   local h = how;
   return function() TrackFishToggle(id, h); end;
end

local function TrackFishEntry(fishid, how)
   local fi = PBTF_Info;
   local info = {};
   info.text = FB_TFConstants["TRACKFISH"..how];
   info.func = MakeTrackFishToggle(fishid, how);
   info.checked = ( fi[how][fishid] and not fi[how][fishid].nevermore );
   return info;
end

local function TrackOptionsMenu(fishid)
   UIDropDownMenu_AddButton(TrackFishEntry(fishid, "HOURLY"));
   UIDropDownMenu_AddButton(TrackFishEntry(fishid, "WEEKLY"));
end

FB_TrackingFrame.OnEvent = function()
   FishingBuddy.API.RegisterHandlers(TrackingEvents);
   FishingBuddy.Locations.PerFishOptions(TrackOptionsMenu);
   FishingBuddy.ManageFrame(FishingTrackingFrame,
                            FB_TFConstants.TRACKING_TAB,
                            FB_TFConstants.TRACKING_INFO,
                            "_TRK");
   this:UnregisterEvent("VARIABLES_LOADED");
end
