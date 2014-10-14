-- FishingBuddy
--
-- Everything you wanted support for in your fishing endeavors

-- Information for the stylin' fisherman
local POLES = {
   ["Fishing Pole"] = "6256:0:0:0",
   ["Strong Fishing Pole"] = "6365:0:0:0",
   ["Darkwood Fishing Pole"] = "6366:0:0:0",
   ["Big Iron Fishing Pole"] = "6367:0:0:0",
   ["Blump Family Fishing Pole"] = "12225:0:0:0",
   ["Nat Pagle's Extreme Angler FC-5000"] = "19022:0:0:0",
   ["Arcanite Fishing Pole"] = "19970:0:0:0",
   -- yeah, so you can't really use these (for now :-)
   ["Dwarven Fishing Pole"] = "3567:0:0:0",
   ["Goblin Fishing Pole"] = "4598:0:0:0",
}

local FISHINGLURES = {
   [6533] = "Aquadynamic Fish Attractor",	-- 100 for 5 mins
   [7307] = "Flesh Eating Worm",		-- 75 for 10 mins
   [6532] = "Bright Baubles",			-- 75 for 10 mins
   [6811] = "Aquadynamic Fish Lens",		-- 50 for 10 mins
   [6530] = "Nightcrawlers",			-- 50 for 10 mins
   [6529] = "Shiny Bauble",			-- 25 for 10 mins
}

FishingBuddy.OPTIONS = {
   ["ShowNewFishies"] = {
      ["text"] = FBConstants.CONFIG_SHOWNEWFISHIES_ONOFF,
      ["tooltip"] = FBConstants.CONFIG_SHOWNEWFISHIES_INFO,
      ["v"] = 1,
      ["m"] = 1,
      ["default"] = 1 },
   ["WatchFishies"] = {
      ["text"] = FBConstants.CONFIG_FISHWATCH_ONOFF,
      ["tooltip"] = FBConstants.CONFIG_FISHWATCH_INFO,
      ["v"] = 1,
      ["m"] = 1,
      ["default"] = 1 },
   ["WatchCurrentSkill"] = {
      ["text"] = FBConstants.CONFIG_FISHWATCHSKILL_ONOFF,
      ["tooltip"] = FBConstants.CONFIG_FISHWATCHSKILL_INFO,
      ["v"] = 1,
      ["m"] = 1,
      ["default"] = 1,
      ["deps"] = { ["WatchFishies"] = "d" } },
   ["WatchCurrentZone"] = {
      ["text"] = FBConstants.CONFIG_FISHWATCHZONE_ONOFF,
      ["tooltip"] = FBConstants.CONFIG_FISHWATCHZONE_INFO,
      ["v"] = 1,
      ["m"] = 1,
      ["default"] = 0,
      ["deps"] = { ["WatchFishies"] = "d" } },
   ["WatchOnlyWhenFishing"] = {
      ["text"] = FBConstants.CONFIG_FISHWATCHONLY_ONOFF,
      ["tooltip"] = FBConstants.CONFIG_FISHWATCHONLY_INFO,
      ["v"] = 1,
      ["m"] = 1,
      ["default"] = 1,
      ["deps"] = { ["WatchFishies"] = "d" } },
   ["WatchFishPercent"] = {
      ["text"] = FBConstants.CONFIG_FISHWATCHPERCENT_ONOFF,
      ["tooltip"] = FBConstants.CONFIG_FISHWATCHPERCENT_INFO,
      ["v"] = 1,
      ["m"] = 1,
      ["default"] = 1,
      ["deps"] = { ["WatchFishies"] = "d" } },
   ["SortByPercent"] = {
      ["text"] = FBConstants.CONFIG_SORTBYPERCENT_ONOFF,
      ["tooltip"] = FBConstants.CONFIG_SORTBYPERCENT_INFO,
      ["v"] = 1,
      ["m"] = 1,
      ["default"] = 1 },
   ["SuitUpFirst"] = {
      ["text"] = FBConstants.CONFIG_SUITUPFIRST_ONOFF,
      ["tooltip"] = FBConstants.CONFIG_SUITUPFIRST_INFO,
      ["v"] = 1,
      ["m"] = 1,
      ["default"] = 0 },
   ["EasyCast"] = {
      ["text"] = FBConstants.CONFIG_EASYCAST_ONOFF,
      ["tooltip"] = FBConstants.CONFIG_EASYCAST_INFO,
      ["v"] = 1,
      ["m"] = 1,
      ["default"] = 1 },
   ["EasyLures"] = {
      ["text"] = FBConstants.CONFIG_EASYLURES_ONOFF,
      ["tooltip"] = FBConstants.CONFIG_EASYLURES_INFO,
      ["v"] = 1,
      ["m"] = 1,
      ["default"] = 0 },
   ["STVTimer"] = {
      ["text"] = FBConstants.CONFIG_STVTIMER_ONOFF,
      ["tooltip"] = FBConstants.CONFIG_STVTIMER_INFO,
      ["v"] = 1,
      ["m"] = 1,
      ["default"] = 0 },
   ["STVPoolsOnly"] = {
      ["text"] = FBConstants.CONFIG_STVPOOLSONLY_ONOFF,
      ["tooltip"] = FBConstants.CONFIG_STVPOOLSONLY_INFO,
      ["v"] = 1,
      ["m"] = 1,
      ["default"] = 0,
      ["deps"] = { ["STVTimer"] = "d", ["EasyCast"] = "d" } },
   ["UseButtonHole"] = {
      ["text"] = FBConstants.CONFIG_USEBUTTONHOLE_ONOFF,
      ["tooltip"] = FBConstants.CONFIG_USEBUTTONHOLE_INFO,
      ["v"] = 1,
      ["default"] = 0,
      ["check"] = function () return ButtonHole ~= nil; end,
      ["checkfail"] = 0 },
   ["UseGatherer"] = {
      ["text"] = FBConstants.CONFIG_USEGATHERER_ONOFF,
      ["tooltip"] = FBConstants.CONFIG_USEGATHERER_INFO,
      ["v"] = 1,
      ["default"] = 0,
      ["check"] = function () return Gatherer_OnLoad ~= nil; end,
      ["checkfail"] = 0 },
   ["MinimapButtonVisible"] = {
      ["tooltip"] = FBConstants.CONFIG_MINIMAPBUTTON_INFO,
      ["v"] = 1,
      ["default"] = 1,
      ["check"] = function () return not FishingBuddy.UseButtonHole(); end,
      ["checkfail"] = 0,
      ["update"] = function(checked)
		      local b = FishingBuddyOption_MinimapButtonVisible;
		      if ( b:GetChecked() ) then
			 b.text = "";
		      else
			 b.text = FBConstants.CONFIG_MINIMAPBUTTON_ONOFF;
		      end
		      FishingBuddyOption_MinimapButtonVisibleText:SetText(b.text);
		   end,
   },
   ["EnhanceFishingSounds"] = {
      ["text"] = FBConstants.CONFIG_ENHANCESOUNDS_ONOFF,
      ["tooltip"] = FBConstants.CONFIG_ENHANCESOUNDS_INFO,
      ["v"] = 1,
      ["m"] = 1,
      ["default"] = 0 },
   -- options not in a menu
   ["ShowLocationZones"] = {
      ["default"] = 1,
   },
   ["GroupByLocation"] = {
      ["default"] = 1,
   },
   -- bar switching
   ["ClickToSwitch"] = {
      ["default"] = 1,
   },
   ["MinimapClickToSwitch"] = {
      ["default"] = 0,
   },
   ["BroadcastFishies"] = {
      ["default"] = FBConstants.BROADCAST_RECV,
   },
   ["EasyCastKeys"] = {
      ["default"] = FBConstants.KEYS_NONE,
      ["deps"] = { ["EasyCast"] = "h" },
   },
   ["SuitUpKeys"] = {
      ["default"] = FBConstants.KEYS_NONE,
   },
   ["EnhanceSoundSoundVolume"] = {
      ["default"] = 1.0,
   },
   ["EnhanceSoundMusicVolume"] = {
      ["default"] = 0.0,
   },
   ["EnhanceSoundAmbienceVolume"] = {
      ["default"] = 0.0,
   },
   ["MinimapButtonPosition"] = {
      ["default"] = FBConstants.DEFAULT_MINIMAP_POSITION,
   },
   ["MinimapPosSlider"] = {
      ["deps"] = { ["MinimapButtonVisible"] = "h", },
   },
   ["ClockOffset"] = {
      ["default"] = 0,
      ["deps"] = { ["STVTimer"] = "h" },
      ["visible"] = function()
		       if ( FBConstants.ClockOffsets ) then
			  return 1;
		       else
			  return 0;
		       end;
		    end,
   },
   ["OutfitManager"] = {
      ["default"] = "OutfitDisplayFrame",
   },
}

FishingBuddy.ByFishie = nil;
FishingBuddy.SortedFishies = nil;

local ActionStartTime = 0;
local ActionDoubleTime = 0;
local ACTIONDOWNWAIT = 0.2;
local ACTIONDOUBLEWAIT = 0.4;
local SavedAddMessage = nil;

FishingBuddy.SavedToggleMinimap = nil;

FishingBuddy.StartedFishing = nil;

local TestingLures = false;
local CastingNow = false;
local AddingLure = false;
local IsLooting = false;

local FishingSpellID = nil;
local FishingSkillName = nil;

local gotSetupDone = false;
local playerName = nil;
local realmName = nil;
local schooltipText = nil;

FishingBuddy.currentFishies = {};

local DEFAULT_MINIMAP_POSITION = 256;

local function GetDefault(setting)
   local opt = FishingBuddy.OPTIONS[setting];
   if ( opt ) then
      if ( opt.check and opt.checkfail ) then
         if ( not opt.check() ) then
            return opt.checkfail;
         end
      end
      return opt.default;
   end
end
FishingBuddy.GetDefault = GetDefault;

local function GetSetting(setting)
   if ( not FishingBuddy_Player or
        not FishingBuddy_Player["Settings"] ) then
      return;
   end
   local val = FishingBuddy_Player["Settings"][setting];
   if ( val == nil ) then
      val = GetDefault(setting);
   end
   return val;
end
FishingBuddy.GetSetting = GetSetting;

local function SetSetting(setting, value)
   if ( FishingBuddy_Player and setting ) then
      local val = GetDefault(setting);
      if ( val == value ) then
	 FishingBuddy_Player["Settings"][setting] = nil;
      else
	 FishingBuddy_Player["Settings"][setting] = value;
      end
   end
end
FishingBuddy.SetSetting = SetSetting;

local function SetClockOffset(offset)
   if ( not FishingBuddy_Info["ClockOffsets"] ) then
      FishingBuddy_Info["ClockOffsets"] = {};
   end
   if ( offset == 0 ) then
      FishingBuddy_Info["ClockOffsets"][realmName] = nil;
   else
      FishingBuddy_Info["ClockOffsets"][realmName] = offset;
   end
end
FishingBuddy.SetClockOffset = SetClockOffset;

local function GetClockOffset()
   if ( not FishingBuddy_Info["ClockOffsets"] or
        not FishingBuddy_Info["ClockOffsets"][realmName] ) then
      return 0;
   end
   return FishingBuddy_Info["ClockOffsets"][realmName];
end
FishingBuddy.GetClockOffset = GetClockOffset;

-- We have to do this at PLAYER_ENTERING_WORLD or PLAYER_LOGIN
-- GetGameTime isn't correct at VARIABLES_LOADED
local function CheckClockOffset()
   local hour,minute = GetGameTime();
   local lhour = date("%H");
   local lminute = date("%M");
   local houroff;
   houroff = hour - lhour;
   if ( houroff ~= 0 ) then
      local houroff24;
      if ( houroff < 0 ) then
         houroff24 = 24 + houroff;
      else
         houroff24 = houroff - 24;
      end
      local offsets = { houroff, houroff24 };
      FBConstants.ClockOffsets = offsets;
      local current = GetClockOffset();
      -- don't change it if we've already got a good value
      if ( current ~= houroff and current ~= houroff24 ) then
         SetClockOffset(houroff);
      end
   else
      FBConstants.ClockOffsets = nil;
      SetClockOffset(0);
   end
   -- Set up the menu and such
   FishingBuddy.OptionsFrame.SetClockValues(GetClockOffset());
end

-- Something else that should be in a library
local function SplitLink(link)
   if ( link ) then
      local _,_, color, item, name = string.find(link, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r");
      return color, item, name;
   end
end
FishingBuddy.SplitLink = SplitLink;

local function SplitFishLink(link)
   if ( link ) then
      local _,_, color, id, name = string.find(link, "|c(%x+)|Hitem:(%d+):%d+:%d+:%d+|h%[(.-)%]|h|r");
      return color, tonumber(id), name;
   end
end
FishingBuddy.SplitFishLink = SplitFishLink;

local function _GetItemInfo(link)
   local maj,min,dot = FishingBuddy.WOWVersion();
-- name, link, rarity, itemlevel, minlevel, itemtype
-- subtype, stackcount, equiploc, texture
   local nm,li,ra,il,ml,it,st,sc,el,tx;
   if ( maj > 1 ) then
      nm,li,ra,il,ml,it,st,sc,el,tx = GetItemInfo(link);
   else
      nm,li,ra,ml,it,st,sc,el,tx = GetItemInfo(link);
   end
   return nm,li,ra,ml,it,st,sc,el,tx,il;
end

local function IsLinkableItem(item)
   local link = "item:"..item;
   local n,l,_,_,_,_,_,_ = _GetItemInfo(link);
   return ( n and l );
end
FishingBuddy.IsLinkableItem = IsLinkableItem;

-- event handling
local reg_events = {};
local event_handlers = {};
local function RegisterHandlers(handlers)
   for evt,info in pairs(handlers) do
      local func, fake;
      if ( not event_handlers[evt] ) then
	 event_handlers[evt] = {};
      end
      if ( type(info) == "function" ) then
	 func = info;
	 fake = false;
      else
	 func = info.func;
	 fake = info.fake;
      end
      if ( FBConstants.FBEvents[evt] ) then
	 fake = true;
      end
      tinsert(event_handlers[evt], func);
      if ( not fake ) then
	 -- register the event, if we haven't already
	 if ( FishingBuddy.StartedFishing and not reg_events[evt] ) then
	    FishingBuddyFrame:RegisterEvent(evt);
	 end
	 reg_events[evt] = 1;
      end
   end
end
FishingBuddy.API.RegisterHandlers = RegisterHandlers;

local function RunHandlers(what, ...)
   if ( event_handlers[what] ) then
      for idx,func in pairs(event_handlers[what]) do
	 func(unpack(arg));
      end
   end
end
FishingBuddy.RunHandlers = RunHandlers;

-- look at tooltips
local function GetTooltipText()
   local text = "";
   if ( GameTooltip:IsVisible() ) then
      text = getglobal("GameTooltipTextLeft1");
      if ( text ) then
         return text:GetText();
      end
   end
   return nil;
end
FishingBuddy.GetTooltipText = GetTooltipText;

local function LastTooltipText()
   return schooltipText;
end
FishingBuddy.LastTooltipText = LastTooltipText;

local function ClearTooltipText()
   schooltipText = nil;
end
FishingBuddy.ClearTooltipText = ClearTooltipText; 

local function OnFishingBobber()
   local text = GetTooltipText();
   if ( text ) then
	 -- let a partial match work (for translations)
	 return ( text and string.find(text, FBConstants.BOBBER_NAME ) );
   end
   return false;
end

-- support finding the fishing skill
local function FindSpellID(thisone)
   local id = 1;
   local spellTexture = GetSpellTexture(id, BOOKTYPE_SPELL);
   while (spellTexture) do
      if (spellTexture and spellTexture == thisone) then
	 return id;
      end
      id = id + 1;
      spellTexture = GetSpellTexture(id, BOOKTYPE_SPELL);
   end
   return nil;
end

local function GetFishingSpellID()
   if ( not FishingSpellID or not FishingSkillName) then
      FishingSpellID = FindSpellID(FBConstants.FISHINGTEXTURE);
   end
   if ( FishingSpellID and not FishingSkillName ) then
      FishingSkillName = GetSpellName(FishingSpellID, BOOKTYPE_SPELL);
   end
end

local function GetFishingSkillName()
   GetFishingSpellID();
   if ( not FishingSkillName ) then
      return FBConstants.FISHINGSKILL;
   else
      return FishingSkillName;
   end
end
FishingBuddy.GetFishingSkillName = GetFishingSkillName;

-- handle option keys for enabling casting
local key_actions = {
   [FBConstants.KEYS_NONE] = function() return true; end,
   [FBConstants.KEYS_SHIFT] = function() return IsShiftKeyDown(); end,
   [FBConstants.KEYS_CTRL] = function() return IsControlKeyDown(); end,
   [FBConstants.KEYS_ALT] = function() return IsAltKeyDown(); end,
}
local function CastingKeys()
   local setting = GetSetting("EasyCastKeys");
   if ( setting and key_actions[setting] ) then
      return key_actions[setting]();
   else
      return true;
   end
end

-- get our current fishing skill level
local lastSkillIndex = nil;
local function GetCurrentSkill()
   if ( lastSkillIndex ) then
      local name, _, _, rank, _, modifier = GetSkillLineInfo(lastSkillIndex);
      if ( name == GetFishingSkillName() )then
	 return rank, modifier;
      end
   end
   local n = GetNumSkillLines();
   for i=1,n do
      local name, _, _, rank, _, modifier = GetSkillLineInfo(i);
      if ( name == GetFishingSkillName() ) then
	 lastSkillIndex = i;
	 return rank, modifier;
      end
   end
   return 0, 0;
end
FishingBuddy.GetCurrentSkill = GetCurrentSkill;

-- handle dynamic event registration
local function EventRegistration(frame, events, reg)
   for evt,t in pairs(reg_events) do
      if ( reg ) then
	 frame:RegisterEvent(evt);
      else
	 frame:UnregisterEvent(evt);
      end
   end
end


-- handle the vagaries of zones and subzones
local function GetZoneInfo()
   local zone = GetRealZoneText();
   local subzone = GetSubZoneText();
   if ( not zone or zone == "" ) then
      zone = FBConstants.UNKNOWN;
   end
   if ( not subzone or subzone == "" ) then
      subzone = zone;
   end
   return zone, subzone;
end
FishingBuddy.GetZoneInfo = GetZoneInfo;

local zonemapping;
local subzonemapping;

local function DumpMappings()
   FishingBuddy.Debug("Zone mapping");
   FishingBuddy.Dump(zonemapping);
   FishingBuddy.Debug("SubZone mapping");
   FishingBuddy.Dump(subzonemapping);
end
FishingBuddy.DumpMappings = DumpMappings;

local function GetZoneIndex(zone, subzone)
   if ( not zone ) then
      zone, subzone = GetZoneInfo();
   end
   if ( not zonemapping ) then
      zonemapping = {};
      for idx,z in pairs(FishingBuddy_Info["ZoneIndex"]) do
         zonemapping[z] = idx;
      end
   end
   local zidx = zonemapping[zone];
   if ( not subzonemapping ) then
      subzonemapping = {};
      for idx,_ in pairs(FishingBuddy_Info["ZoneIndex"]) do
         subzonemapping[idx] = {};
         if ( FishingBuddy_Info["SubZones"][idx] ) then
            for jdx,sz in pairs(FishingBuddy_Info["SubZones"][idx]) do
               subzonemapping[idx][sz] = jdx;
            end
         end
      end
   end
   if ( not zidx ) then
      return;
   end
   if ( not subzonemapping[zidx] ) then
      subzonemapping[zidx] = {};
   end
   if ( not subzone or not subzonemapping[zidx][subzone] ) then
      return zidx;
   end
   return zidx, subzonemapping[zidx][subzone];
end
FishingBuddy.GetZoneIndex = GetZoneIndex;

local function AddZoneIndex(zone, subzone)
   if ( not zone ) then
      zone, subzone = GetZoneInfo();
   end
   if ( type(zone) ~= "string" ) then
      FishingBuddy.Debug("AddZoneIndex "..zone);
   end
   local zidx, sidx = GetZoneIndex(zone, subzone);
   if ( not zidx ) then
      tinsert(FishingBuddy_Info["ZoneIndex"], zone);
      zidx = table.getn(FishingBuddy_Info["ZoneIndex"]);
      zonemapping[zone] = zidx;
      -- keep sort helpers up to date
      if ( FishingBuddy.SortedZones ) then
         tinsert(FishingBuddy.SortedZones, zone);
         table.sort(FishingBuddy.SortedZones);
      end
   end
   if ( not subzone ) then
      return zidx;
   end
   if ( not subzonemapping[zidx] ) then
      subzonemapping[zidx] = {};
   end
   if ( not subzonemapping[zidx][subzone] ) then
      if ( not FishingBuddy_Info["SubZones"][zidx] ) then
         FishingBuddy_Info["SubZones"][zidx] = {};
      end
      tinsert(FishingBuddy_Info["SubZones"][zidx], subzone);
      subzonemapping[zidx][subzone] = table.getn(FishingBuddy_Info["SubZones"][zidx]);
      -- keep sort helpers up to date
      if ( FishingBuddy.SortedByZone ) then
         FishingBuddy.SortedByZone[zone] = {};
         tinsert(FishingBuddy.SortedByZone[zone], subzone);
         table.sort(FishingBuddy.SortedByZone[zone]);
         tinsert(FishingBuddy.SortedSubZones, subzone);
         table.sort(FishingBuddy.SortedSubZones);
      end
   end
   return zidx, subzonemapping[zidx][subzone];
end
FishingBuddy.AddZoneIndex = AddZoneIndex;

local function SetZoneLevel(zone, subzone, fishid)
   local skill, mods = GetCurrentSkill();
   local zidx, sidx = GetZoneIndex(zone, subzone);
   local fs = FishingBuddy_Info["FishingSkill"];
   if ( not fs[zidx] ) then
      fs[zidx] = {};
   end
   local skillcheck = skill + mods;
   if ( skillcheck > 0 ) then
      if ( not fs[zidx][sidx] or skillcheck < fs[zidx][sidx] ) then
         fs[zidx][sidx] = skillcheck;
      end
      if ( fishid ) then
         if ( not FishingBuddy_Info["Fishies"][fishid].level or
              skillcheck < FishingBuddy_Info["Fishies"][fishid].level ) then
            FishingBuddy_Info["Fishies"][fishid].level = skillcheck;
            FishingBuddy_Info["Fishies"][fishid].skill = skill;
            FishingBuddy_Info["Fishies"][fishid].mods = mods;
         end
      end
   end
   return skill + mods;
end
FishingBuddy.SetZoneLevel = SetZoneLevel;

local function AddFishie(color, id, name, zone, subzone, texture, quantity, quality, level)
   if ( not FishingBuddy_Info["Fishies"][id] ) then
      if ( not color ) then
         local _,_,_,hex = GetItemQualityColor(quality);
         _,_,color = string.find(hex, "|c(%a+)");
      end
      FishingBuddy_Info["Fishies"][id] = { };
      FishingBuddy_Info["Fishies"][id].name = name;
      FishingBuddy_Info["Fishies"][id].texture = texture;
      FishingBuddy_Info["Fishies"][id].quality = quality;
      if ( color ~= "ffffffff" ) then
	 FishingBuddy_Info["Fishies"][id].color = color;
      end
      if ( FishingBuddy.SortedFishies ) then
	 tinsert(FishingBuddy.SortedFishies, { text = name, id = id });
	 FishingBuddy.FishSort(FishingBuddy.SortedFishies, true);
      end
   end
   if ( name and not FishingBuddy_Info["Fishies"][id].name ) then
      FishingBuddy_Info["Fishies"][id].name = name;
   end

   if ( not zone ) then
      zone = FBConstants.UNKNOWN;
   end
   if ( not subzone ) then
      subzone = zone;
   end
   local zidx, sidx = AddZoneIndex(zone, subzone);

   if ( not FishingBuddy.currentFishies[sidx] ) then
      FishingBuddy.currentFishies[sidx] = {};
   end
   if ( not FishingBuddy.currentFishies[sidx][id] ) then
      FishingBuddy.currentFishies[sidx][id] = quantity;
   else
      FishingBuddy.currentFishies[sidx][id] = FishingBuddy.currentFishies[sidx][id] + quantity;
   end

   if( not FishingBuddy_Info["FishingHoles"][zidx] ) then
      FishingBuddy_Info["FishingHoles"][zidx] = { };
   end
   if( not FishingBuddy_Info["FishingHoles"][zidx][sidx] ) then
      FishingBuddy_Info["FishingHoles"][zidx][sidx] = { };
   end
   local fh = FishingBuddy_Info["FishingHoles"][zidx];
   if ( not fh[sidx][id] ) then
      fh[sidx][id] = quantity;
      if ( GetSetting("ShowNewFishies") == 1 ) then
	 FishingBuddy.Print(FBConstants.ADDFISHIEMSG, name, subzone);
      end
   else
      fh[sidx][id] = fh[sidx][id] + quantity;
   end

   if ( FishingBuddy.ByFishie ) then
      if ( not FishingBuddy.ByFishie[id] ) then
	 FishingBuddy.ByFishie[id] = {};
      end
      if ( not FishingBuddy.ByFishie[id][subzone] ) then
	 FishingBuddy.ByFishie[id][sidx] = quantity;
      else
	 FishingBuddy.ByFishie[id][sidx] = FishingBuddy.ByFishie[id][sidx] + quantity;
      end
   end

   if ( level ) then
      if ( not FishingBuddy_Info["Fishies"][id].level or
              level < FishingBuddy_Info["Fishies"][id].level ) then
         FishingBuddy_Info["Fishies"][id].level = level;
      end
   end
   RunHandlers(FBConstants.ADD_FISHIE_EVT, id, name, zone, subzone);
end
FishingBuddy.AddFishie = AddFishie;

local function AddFishieMessage(msg, group, who)
   local getbroadcast = GetSetting("BroadcastFishies");
   if ( getbroadcast ) then
      local _,_,v,loc,id,quantity,zone,subzone,level = string.find(msg, "(%a+)_(%a+)_(%a+)_(%a+)_(%a+)_(%a+)");
      -- First useful version is 8800
      FishingBuddy.Debug("ADDON "..msg);
      if ( loc == GetLocale() and v <= FBConstants.CURRENTVERSION ) then
         local link = "item:"..id..":0:0:0";
         FishingOutfitTooltip:SetHyperlink(link);
         local n,s,q,l,t,s,c,e,x = _GetItemInfo(link);
         FishingBuddy.AddFishie(nil, id, n, zone, subzone, x, quantity, q, level);
      end
   end
end
FishingBuddy.AddFishieMessage = AddFishieMessage;

local MsgCheck = {
   ["GUILD"] = function() return IsInGuild(); end,
   ["RAID"] = function() return (GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0); end,
};

local CaptureEvents = {};
CaptureEvents["LOOT_OPENED"] = function()
   IsLooting = true;
   if ( IsFishingLoot()) then
      local zone, subzone = GetZoneInfo();
      for index = 1, GetNumLootItems(), 1 do
	 if (LootSlotIsItem(index)) then
	    local texture, fishie, quantity, quality = GetLootSlotInfo(index);
	    local link = GetLootSlotLink(index);
	    local color, id, name = SplitFishLink(link);
	    AddFishie(color, id, name, zone, subzone, texture, quantity, quality);
	    local level = SetZoneLevel(zone, subzone, id);
	    -- Tell everybody we got one
	    local loc = GetLocale();
	    local msg = FBConstants.CURRENTVERSION.."_"..loc.."_"..id.."_"..quantity.."_"..zone.."_"..subzone.."_"..level;
            for target,check in pairs(MsgCheck) do
               if ( check() ) then
                  SendAddonMessage(FBConstants.MSGID, msg, target);
               end
            end
	 end
      end
      ClearTooltipText();
   end
end

CaptureEvents["LOOT_CLOSED"] = function()
   IsLooting = false;
end

CaptureEvents["CHAT_MSG_ADDON"] = function()
   if ( arg1 == FBConstants.MSGID and arg4 ~= UnitName("player") ) then
      AddFishieMessage(arg2, arg3, arg4);
   end
end

StatusEvents = {};
StatusEvents["SPELLS_CHANGED"] = function()
   -- Fishing might have moved, go look again
   FishingSpellID = nil;
end

StatusEvents["ITEM_LOCK_CHANGED"] = FishingMode;

StatusEvents["SPELLCAST_CHANNEL_START"] = function()
   -- Mugendai is one sharp cookie (shamelessly stealing from TackleBox)
   -- Keep up with whether or not we are casting
   CastingNow = true;
end

StatusEvents["SPELLCAST_CHANNEL_STOP"] = function()
   CastingNow = false;
end

StatusEvents["SPELLCAST_START"] = function()
   -- AddingLure = true;
end

StatusEvents["SPELLCAST_STOP"] = function()
   AddingLure = false;
end

StatusEvents["SPELLCAST_INTERRUPTED"] = function()
   AddingLure = false;
end

StatusEvents["SPELLCAST_FAILED"] = function()
   AddingLure = false;
end

local OldBindingKey;
local function UpdateBindings(onoff)
   if ( onoff ) then
      if ( not OldKeyBinding ) then
	 OldKeyBinding = GetBindingKey("TURNORACTION");
	 if ( OldKeyBinding ) then
	    SetBinding(OldKeyBinding, "FISHINGBUDDY_PERFORMCAST");
	 else
	    FishingBuddy.UIError(FBConstants.TOOMANYFISHERMEN);
	 end
      end
   else
      if ( OldKeyBinding ) then
	 SetBinding(OldKeyBinding, "TURNORACTION");
	 OldKeyBinding = nil;
      end
   end
end
FishingBuddy.UpdateBindings = UpdateBindings;

-- Shamelessly stolen from TackleBox
local function IsFishingPole()
   -- Get the main hand item texture
   local slot = GetInventorySlotInfo("MainHandSlot");
   local itemTexture = GetInventoryItemTexture("player", slot);
   -- If there is infact an item in the main hand, and it's texture
   -- that matches the fishing pole texture, then we have a fishing pole
   if ( itemTexture and string.find(itemTexture, "INV_Fishingpole") ) then
      local link = GetInventoryItemLink("player", slot);
	  local _, id, _ = SplitLink(link);
      -- Make sure it's not "Nat Pagle's Fish Terminator"
      if ( not string.find(id, "^19944") ) then
         return true;
       end
   end
   return false;
end
FishingBuddy.API.IsFishingPole = IsFishingPole;

-- override the error message method (need an object as the first arg)
local function UIError_AddMessage( o, msg, a, r, g, b, hold )
   -- If we should be hiding the can't use item error, then do so
   if ( TestingLures and msg == ERR_CANT_USE_ITEM  ) then
      -- We have the can't use item error, so abort
      return;
   end
   -- is anyone else looking for messages?
   RunHandlers(FishingBuddy.UIERROR_EVT, msg, a, r, g, b, hold);
   --Call the original
   local obj = SavedAddMessage.obj;
   local method = SavedAddMessage.method;
   return method( obj, msg, a, r, g, b, hold );
end
FishingBuddy.AddMessage = UIError_AddMessage;

local function NormalHijackCheck()
   if ( GetSetting("EasyCast") == 1 and
       CastingKeys() and IsFishingPole() ) then
      return true;
   end
end
FishingBuddy.NormalHijackCheck = NormalHijackCheck;

local HijackCheck = NormalHijackCheck;
local function SetHijackCheck(func)
   if ( not func ) then
      func = NormalHijackCheck;
   end
   HijackCheck = func;
end
FishingBuddy.SetHijackCheck = SetHijackCheck;

local SavedWFOnMouseUp;
local SavedWFOnMouseDown;
-- handle mouse up and mouse down in the WorldFrame so that we can steal
-- the hardware events to implement 'Easy Cast'
-- Thanks to the Cosmos team for figuring this one out -- I didn't realize
-- that the mouse handler in the WorldFrame got everything first!
local function WF_OnMouseDown()
   -- Only steal 'right clicks'
   if ( arg1 == "RightButton" and HijackCheck() ) then
      FishingBuddy.ActionStartCheck();
   end
   if ( SavedWFOnMouseDown ) then
      SavedWFOnMouseDown();
   end
end

-- disable click to move if we're fishing
local resetClickToMove = false;
local function WF_OnMouseUp()
   local retval;
   if ( SavedWFOnMouseUp ) then
      retval = SavedWFOnMouseUp();
   end
   -- Only steal 'right clicks'
   if ( arg1 == "RightButton" ) then
      -- we fail if there are multiple modifier keys
      if ( IsAltKeyDown() and ( IsShiftKeyDown() or IsControlKeyDown() ) ) then
	 return retval;
      end
      if ( IsShiftKeyDown() and IsControlKeyDown() ) then
	 return retval;
      end
      if ( HijackCheck() ) then
	 FishingBuddy.StopCastingCheck();
      elseif ( resetClickToMove ) then
	 -- Re-enable Click-to-Move if we changed it
	 SetCVar("autointeract", "1");
	 resetClickToMove = nil;
      end
   end
   return retval;
end

-- Find things in our inventory
local function FindItemByID(id)
   if ( id ) then
      local numSlots = 0;
      -- check each of the bags on the player
      for bag=0, NUM_BAG_FRAMES do
	 -- get the number of slots in the bag (0 if no bag)
	 numSlots = GetContainerNumSlots(bag);
	 if (numSlots > 0) then
	    -- check each slot in the bag
	    for slot=1, numSlots do
	       local link = GetContainerItemLink (bag,slot);
	       if (link) then
		  local c, check, n = SplitFishLink(link);
		  if ( check == id ) then
		     return bag, slot;
		  end
	       end
	    end
	 end
      end
   end
   return nil, nil;
end

local function SafeHookMethod(object, method, newmethod)
   local oldValue = object[method];
   if ( oldValue ~= getglobal(newmethod) ) then
      object[method] = newmethod;
      return true;
   end
   return false;
end

local function SafeHookScript(frame, handlername, newscript)
   local oldValue = frame:GetScript(handlername);
   frame:SetScript(handlername, newscript);
   return oldValue;
end

FishingBuddy.GetFishie = function(fishid)
   if( FishingBuddy_Info["Fishies"][fishid] ) then
      return string.format("%d:0:0:0", fishid),
      FishingBuddy_Info["Fishies"][fishid].texture,
      FishingBuddy_Info["Fishies"][fishid].color,
      FishingBuddy_Info["Fishies"][fishid].quantity,
      FishingBuddy_Info["Fishies"][fishid].quality,
      FishingBuddy_Info["Fishies"][fishid].name;
   end
end

local function ImportFish()
--   local oldShowNewFishies = GetSetting("ShowNewFishies");
--   SetSetting("ShowNewFishies");
--   if ( FishInfo2DataSub and FishingBuddy_Info["FishInfo2"] == 0 ) then
--      for toon in pairs(FishInfo2DataSub) do
--	 if ( not string.find(toon, "|User$") ) then
--	    for fishie in pairs(FishInfo2DataSub[toon]) do
--	       local texture = FishInfo2DataSub[toon][fishie]["texture"];
--	       local quality = FishInfo2DataSub[toon][fishie]["rarity"];
--	       local fz = FishInfo2DataSub[toon][fishie]["zones"];
--	       local link = FishInfo2DataSub[toon][fishie]["link"];
--	       if ( link ) then
--		  local _,_,id = string.find(link, "^(%d+):");
--		  for zone in pairs(fz) do
--		     for subzone in pairs(fz[zone]) do
--			local quantity = fz[zone][subzone];
--			AddFishie(nil, id, fishie, zone, subzone, texture, quantity, quality)
--		     end
--		  end
--	       end
--	    end
--	 end
--      end
--      FishingBuddy_Info["FishInfo2"] = 1;
--      FishingBuddy.Print(FBConstants.IMPORTMSG, "FishInfo2");
--   elseif ( imppfishinfoDB and FishingBuddy_Info["ImppDBLoaded"] == 0 ) then
--      for subzone in imppfishinfoDB do
--	 for item in imppfishinfoDB[subzone]["itemnames"] do
--	    local quantity = imppfishinfoDB[subzone]["itemnames"][item].number;
--	    local texture = imppfishinfoDB[subzone]["itemnames"][item].texture;
--	    local quality = imppfishinfoDB[subzone]["itemnames"][item].quality;
--	    AddFishie(nil, id, name, subzone, texture, item, quantity, quality)
--	 end
--      end
--      FishingBuddy_Info["ImppDBLoaded"] = 1;
--      FishingBuddy.Print(FBConstants.IMPORTMSG, "Impp's fishinfo");
--   elseif ( DataFishDB and FishingBuddy_Info["DataFish"] == 0 ) then
--      for fishie in DataFishDB["catches"] do
--	 for zone in DataFishDB["catches"][fishie]["locnames"] do
--	    for subzone in DataFishDB["catches"][fishie]["locnames"][zone] do
--	       local dfl = DataFishDB["locations"][subzone]["itemnames"][fishie];
--	       local quantity = dfl["number"];
--	       local texture = dfl["texture"];
--	       local quality = dfl["quality"];
--	       AddFishie(nil, id, name, zone, subzone, texture, quantity, quality)
--	    end
--	 end
--      end
--      FishingBuddy_Info["DataFish"] = 1;
--      FishingBuddy.Print(FBConstants.IMPORTMSG, "DataFish");
--   else
--      FishingBuddy.Message(FBConstants.NOIMPORTMSG);
--   end
--   SetSetting("ShowNewFishies", oldShowNewFishies);
end

local function InvokeFishing()
   GetFishingSpellID();
   if ( FishingSpellID ) then
      CastSpell(FishingSpellID, BOOKTYPE_SPELL);
   end
end

-- do everything we think is necessary when we start fishing
-- even if we didn't do the switch to a fishing pole
local function StartFishingMode()
   if ( not FishingBuddy.StartedFishing ) then
      FishingBuddy.StartedFishing = GetTime();
      FishingBuddy.EnhanceFishingSounds(true);
      FishingBuddy.WatchUpdate();
      EventRegistration(FishingBuddyRoot, ModeEventTable, true);
   end
end

local function StopFishingMode()
   if ( FishingBuddy.StartedFishing ) then
      FishingBuddy.EnhanceFishingSounds(false);
      FishingBuddy.WatchUpdate();
      FishingBuddy.StartedFishing = nil;
      EventRegistration(FishingBuddyRoot, ModeEventTable, false);
   end
   if ( resetClickToMove ) then
      -- Re-enable Click-to-Move if we changed it
      SetCVar("autointeract", "1");
      resetClickToMove = nil;
   end
end

local function FishingMode()
   if ( IsFishingPole() ) then
      StartFishingMode();
   else
      StopFishingMode();
   end
end
FishingBuddy.API.FishingMode = FishingMode;

-- Easy lures (borrowed from Mugendai's excellent code)
local function UpdateLure()
   -- if the pole has an enchantment, we can assume it's got a lure on it (so far, anyway)
   if ( ( GetSetting("EasyLures") == 1 ) and not GetWeaponEnchantInfo() ) then
      -- trap message handler if we haven't already
      if ( not SavedAddMessage ) then
	 FishingBuddy.TrapUIErrors();
      end

      --Check for a lure in the bags, starting with the highest power one
      local bag, slot;
      for lure in pairs(FISHINGLURES) do
	 --If we find this lure in the bag, then use it
	 bag, slot = FindItemByID(lure);
	 if (bag and slot) then
	    --We need to temporarily disable the cant use item error, incase this item is too high of a level to use
	    TestingLures = true;
	    --Temporarily disable error message sounds, incase this item is too high of a level to use
	    local soundState = GetCVar("EnableErrorSpeech");
	    if ( soundState == "1" ) then
	       SetCVar("EnableErrorSpeech", 0);
	    end
	    --Try to use the item
	    UseContainerItem(bag, slot);
	    -- re-enable the can't use item error message
	    TestingLures = false;
	    -- re-enable error message sounds
	    if ( soundState == "1" ) then
	       SetCVar("EnableErrorSpeech", 1);
	    end
	    -- if we have a targeting cursor, then we succesfully used the lure
	    if ( SpellIsTargeting() ) then
	       -- apply the lure to the fishing pole
	       local mainhandslot = GetInventorySlotInfo("MainHandSlot");
	       PickupInventoryItem(mainhandslot);
	       AddingLure = true;
	       return true;
	    end
	 end
      end
   end
   return false;
end

FishingBuddy.ActionStartCheck = function()
   -- Disable Click-to-Move if we're fishing
   if ( GetCVar("autointeract") == "1" ) then
      resetClickToMove = true;
      SetCVar("autointeract", "0");
   end
   -- Don't interrupt putting on a lure, or if we're not fastcasting
   if ( AddingLure ) then
      ActionStartTime = 0;
   else
      ActionStartTime = GetTime();
   end
end

-- add the double click checking in based on the code is Cosmos
FishingBuddy.StopCastingCheck = function()
   if ( not ActionStartTime ) then
      ActionStartTime = 0;
   end
   if ( not ActionDoubleTime ) then
      ActionDoubleTime = 0;
   end
   local time = GetTime();
   local pressTime = time - ActionStartTime;
   local doubleTime = time - ActionDoubleTime;
   -- if we're not putting on a lure
   if ( not SpellIsTargeting() ) then
      -- if the click was "short" enough that we're going to treat it
      -- as a cast
      if ( ActionStartTime > 0 and ACTIONDOWNWAIT >= pressTime) then
	 -- if we're already casting, enforce double click timing
	 if ( CastingNow and
	     ( ActionDoubleTime == 0 or ACTIONDOUBLEWAIT < doubleTime ) ) then
	    ActionDoubleTime = GetTime();
	 else
	    ActionDoubleTime = 0;
	    -- rebind the mouse event
	    UpdateBindings(true);
	 end
      end
   end
end

FishingBuddy.PerformCast = function()
   -- We're stealing the mouse-up hardware event, make sure we exit MouseLook
   if ( IsMouselooking() ) then
      MouselookStop();
   end
   -- reset the TURNORACTION binding so that everything else works 'right'
   UpdateBindings(false);

   if ( not schooltipText or not OnFishingBobber() ) then
      -- watch for fishing holes
      schooltipText = GetTooltipText();
   end

   -- put on a lure if we need to
   if ( not UpdateLure() ) then
      InvokeFishing();
   end
end

FishingBuddy.SuitUpAndGoFishing = function()
   if ( IsFishingPole() ) then
      -- put on a lure if we need to
      if ( not UpdateLure() ) then
	 InvokeFishing();
      end
   elseif ( GetSetting("SuitUpFirst") == 1 ) then
      FishingBuddy.OutfitManager.Switch();
   end
end

FishingBuddy.IsSwitchClick = function(setting)
   if ( not setting ) then
      setting = "ClickToSwitch";
   end
   local a = IsShiftKeyDown();
   local b = (FishingBuddy.GetSetting(setting) == 1);
   return ( (a and (not b)) or ((not a) and b) );
end

FishingBuddy.TrapUIErrors = function()
   local temp = {};
   temp.obj= UIErrorsFrame;
   temp.method = UIErrorsFrame["AddMessage"];
   if ( SafeHookMethod(UIErrorsFrame, "AddMessage", FishingBuddy.AddMessage) ) then
      SavedAddMessage = temp;
   end
end

FishingBuddy.TrapWorldMouse = function()
   SavedWFOnMouseUp = SafeHookScript(WorldFrame, "OnMouseUp", WF_OnMouseUp);
   SavedWFOnMouseDown = SafeHookScript(WorldFrame, "OnMouseDown", WF_OnMouseDown);
end

-- we should collect these, but then they would be in the cache
local QuestItems = {};
QuestItems[6717] = 1;  -- Gaffer Jack
QuestItems[6718] = 1;  -- Electropeller
QuestItems[16970] = 1; -- Misty Reed Mahi Mahi
QuestItems[16968] = 1; -- Sar'theris Striker
QuestItems[16969] = 1; -- Savage Coast Blue
QuestItems[16967] = 1; -- Feralas Ahi

-- User interface handling
local function IsRareFish(id, forced)
   -- always skip extravaganza fish
   if ( FishingBuddy.Extravaganza.Fish[id] ) then
      return true;
   end
   return ( not forced and QuestItems[id] );
end

FishingBuddy.Commands[FBConstants.UPDATEDB] = {};
FishingBuddy.Commands[FBConstants.UPDATEDB].help = FBConstants.UPDATEDB_HELP;
FishingBuddy.Commands[FBConstants.UPDATEDB].func =
   function(what)
      local ff = FishingBuddy_Info["Fishies"];
      local forced;
      if ( what and what == FBConstants.FORCE ) then
	 forced = true;
      end
      FishingOutfitTooltip:SetOwner(FishingBuddyFrame, "ANCHOR_RIGHT");
      FishingOutfitTooltip:Show();
      local count = 0;
      for id,info in pairs(ff) do
	 local item = id..":0:0:0";
	 if ( not IsLinkableItem(item) or not info.name ) then
	    if ( not IsRareFish(id, forced) ) then
	       local link = "item:"..item;
	       -- fetch the data (may disconnect)
	       FishingBuddy.Debug(link);
	       FishingOutfitTooltip:SetHyperlink(link);
	       -- now that we have it in our cache, get the name
	       local n,_,_,_,_,_,_,_ = _GetItemInfo(link);
	       if ( n ) then
		  count = count + 1;
   	          FishingBuddy_Info["Fishies"][id].name = n;
   	       end
	    end
	 end
      end
      FishingBuddy.Print(FBConstants.UPDATEDB_MSG, count);
      return true;
   end;

FishingBuddy.Commands[FBConstants.CURRENT] = {};
FishingBuddy.Commands[FBConstants.CURRENT].help = FBConstants.CURRENT_HELP;
FishingBuddy.Commands[FBConstants.CURRENT].func =
   function(what)
      if ( what and what == FBConstants.RESET) then
	 FishingBuddy.currentFishies = {};
	 FishingMode();
	 return true;
      end
   end;
FishingBuddy.Commands[FBConstants.IMPORT] = {};
FishingBuddy.Commands[FBConstants.IMPORT].help = FBConstants.IMPORT_HELP;
FishingBuddy.Commands[FBConstants.IMPORT].func =
   function()
      ImportFish();
      return true;
   end;
FishingBuddy.Commands[FBConstants.CLEANUP] = {};
FishingBuddy.Commands[FBConstants.CLEANUP].help = FBConstants.CLEANUP_HELP;
FishingBuddy.Commands[FBConstants.CLEANUP].func =
   function(what)
      local tabs = { "Settings", "Outfit", "WasWearing" };
      local rnames = {};
      local onames = {};
      if ( not what or what == FBConstants.CHECK ) then
	 if ( FishingBuddy_Info["Settings"] ) then
	    for name in pairs(FishingBuddy_Info["Settings"]) do
	       tinsert(onames, name);
	    end
	 end
	 if ( FishingBuddy_Info[realmName] ) then
	    local fs = FishingBuddy_Info[realmName]["Settings"];
	    if ( fs ) then
	       for name,info in pairs(fs) do
		  tinsert(rnames, name);
	       end
	    end
	 end
	 if ( next(rnames) or next(onames) ) then
	    if ( next(rnames) ) then
	       FishingBuddy.Print(FBConstants.CLEANUP_WILLMSG, realmName,
				  FishingBuddy.EnglishList(rnames));
	    end
	    if ( next(onames) ) then
	       FishingBuddy.Print(FBConstants.CLEANUP_WILLMSG,
				  FBConstants.NOREALM,
				  FishingBuddy.EnglishList(onames));
	    end
	 else
	    FishingBuddy.Message(FBConstants.CLEANUP_NONEMSG);
	 end
	 return true;
      else
	 if ( what == FBConstants.NOW ) then
	    if ( FishingBuddy_Info["Settings"] ) then
	       for name in pairs(FishingBuddy_Info["Settings"]) do
		  tinsert(onames, name);
	       end
	    end
	    if ( FishingBuddy_Info[realmName] ) then
	       local fs = FishingBuddy_Info[realmName]["Settings"];
	       if ( fs ) then
		  for name,info in pairs(fs) do
		     tinsert(rnames, name);
		  end
	       end
	    end
	 else
	    if ( FishingBuddy_Info["Settings"] and FishingBuddy_Info["Settings"][what] ) then
	       tinsert(onames, what);
	    elseif ( FishingBuddy_Info[realmName] and
	             FishingBuddy_Info[realmName]["Settings"] and
	             FishingBuddy_Info[realmName]["Settings"][what] ) then
	       tinsert(rnames, what);
	    else
	       FishingBuddy.Print(FBConstants.CLEANUP_NOOLDMSG, what);
	       return true;
	    end
	 end
	 if ( next(rnames) or next(onames) ) then
	    if ( next(rnames) ) then
	       for _,name in pairs(rnames) do
		  for _,tab in pairs(tabs) do
		     if ( FishingBuddy_Info[realmName] and FishingBuddy_Info[realmName][tab] ) then
			FishingBuddy_Info[realmName][tab][name] = nil;
			if ( next(FishingBuddy_Info[realmName][tab]) == nil ) then
			   FishingBuddy_Info[realmName][tab] = nil;
			end
		     end
		  end
	       end
	       if ( FishingBuddy_Info[realmName] and next(FishingBuddy_Info[realmName]) == nil ) then
		  FishingBuddy_Info[realmName] = nil;
	       end
	       FishingBuddy.Print(FBConstants.CLEANUP_DONEMSG, realmName,
				  FishingBuddy.EnglishList(rnames));
	    end
	    if ( next(onames) ) then
	       for _,name in pairs(onames) do
		  for _,tab in pairs(tabs) do
		     if ( FishingBuddy_Info[tab] ) then
			FishingBuddy_Info[tab][name] = nil;
			if ( next(FishingBuddy_Info[tab]) ) then
			   FishingBuddy_Info[tab] = nil;
			end
		     end
		  end
	       end
	       FishingBuddy.Print(FBConstants.CLEANUP_DONEMSG,
				  FBConstants.NOREALM,
				  FishingBuddy.EnglishList(onames));
	    end
	 else
	    FishingBuddy.Message(FBConstants.CLEANUP_NONEMSG);
	 end
	 return true;
      end
   end;

local function nextarg(msg, pattern)
   if ( not msg or not pattern ) then
      return nil, nil;
   end
   local s,e = string.find(msg, pattern);
   if ( s ) then
      local word = strsub(msg, s, e);
      msg = strsub(msg, e+1);
      return word, msg;
   end
   return nil, msg;
end

FishingBuddy.Command = function(msg)
   if ( not msg ) then
      return;
   end
   if ( FishingBuddy.IsLoaded() ) then
      -- collect arguments (whee, lua string manipulation)
      local cmd;
      cmd, msg = nextarg(msg, "[%w]+");

      -- the empty string gives us no args at all
      if ( not cmd ) then
	 -- toggle window
	 if ( FishingBuddyFrame:IsVisible() ) then
	    HideUIPanel(FishingBuddyFrame);
	 else
	    ShowUIPanel(FishingBuddyFrame);
	 end
      elseif ( cmd == FBConstants.HELP or cmd == "help" ) then
	 FishingBuddy.Output(FBConstants.WINDOW_TITLE);
	 FishingBuddy.PrintHelp(FBConstants.HELPMSG);
      else
	 local command = FishingBuddy.Commands[cmd];
	 if ( command ) then
	    local args = {};
	    local goodargs = true;
	    if ( command.args ) then
	       for _,pat in pairs(command.args) do
		  local w, msg = nextarg(msg, pat);
		  if ( not w ) then
		     goodargs = false;
		     break;
		  end
		  tinsert(args, w);
	       end
	    else
	       local a;
	       while ( msg ) do
		  a, msg = nextarg(msg, "[%w]+");
		  if ( not a ) then
		     break;
		  end
		  tinsert(args, a);
	       end
	    end
	    if ( not goodargs or not command.func(unpack(args)) ) then
	       if ( command.help ) then
		  FishingBuddy.PrintHelp(command.help);
	       else
		  FishingBuddy.Debug("command failed");
	       end
	    end
	 else
	    FishingBuddy.Command("help");
	 end
      end
   else
      FishingBuddy.Error(FBConstants.FAILEDINIT);
   end
end

FishingBuddy.Color = function (color, text)
   local c = FBConstants.Colors[color];
   if ( c ) then
      return "|c"..c..text.."|r";
   else
      return text;
   end
end

FishingBuddy.TooltipBody = function(hintcheck)
   local text = FBConstants.DESCRIPTION1.."\n"..FBConstants.DESCRIPTION2;
   if ( hintcheck ) then
      local hint = FBConstants.TOOLTIP_HINT.." ";
      if (FishingBuddy.GetSetting(hintcheck) == 1) then
         hint = hint..FBConstants.TOOLTIP_HINTSWITCH;
      else
         hint = hint..FBConstants.TOOLTIP_HINTTOGGLE;
      end
      text = text.."\n"..FishingBuddy.Color("GREEN", hint);
   end
   return text;
end

local IWEventTable = {
   "ITEM_LOCK_CHANGED",
};

FishingBuddy.OnLoad = function()
   this:RegisterEvent("PLAYER_ENTERING_WORLD");
   this:RegisterEvent("PLAYER_LEAVING_WORLD");

   this:RegisterEvent("PLAYER_LOGIN");
   this:RegisterEvent("PLAYER_LOGOUT");
   this:RegisterEvent("VARIABLES_LOADED");

   RegisterHandlers(CaptureEvents);
   RegisterHandlers(StatusEvents);

   -- Set up command
   SlashCmdList["fishingbuddy"] = FishingBuddy.Command;
   SLASH_fishingbuddy1 = "/fishingbuddy";
   SLASH_fishingbuddy2 = "/fb";

   FishingBuddy.Output(FBConstants.WINDOW_TITLE.." loaded");
end

local IsZoning;
local ZoneEvents;
local function TrackZoneEvents(evt)
   if ( IsZoning ) then
      if ( not ZoneEvents ) then
	 ZoneEvents = {};
      end
      if ( ZoneEvents[evt] ) then
	 ZoneEvents[evt] = ZoneEvents[evt] + 1;
      else
	 ZoneEvents[evt] = 1;
      end
   end
end

local function DumpZoneEvents()
   FishingBuddy.Dump(ZoneEvents);
   ZoneEvents = nil;
end

FishingBuddy.OnEvent = function()
   RunHandlers(event);
   RunHandlers("*");

-- TrackZoneEvents(event);
   if ( event == "PLAYER_LOGIN" ) then
      -- set up outfit stuff
      playerName = UnitName("player");
      realmName = GetRealmName();
      CheckClockOffset();
      FishingBuddy.OutfitManager.Initialize();
      FishingMode();
   elseif ( event == "PLAYER_LOGOUT" ) then
      -- reset the fishing sounds, if we need to
      StopFishingMode();
      FishingBuddy.SavePlayerInfo();
   elseif ( event == "VARIABLES_LOADED" ) then
      FishingBuddy.Initialize();
      this:UnregisterEvent("VARIABLES_LOADED");
   elseif ( event == "PLAYER_ENTERING_WORLD" ) then
      IsZoning = nil;
--    DumpZoneEvents();
      EventRegistration(this, IWEventTable, true);
   elseif ( event == "PLAYER_LEAVING_WORLD") then
      IsZoning = 1;
      EventRegistration(this, IWEventTable, false);
   end
   FishingBuddy.Extravaganza.IsTime(true);
end

FishingBuddy.PrintHelp = function(tab)
   if ( tab ) then
      if ( type(tab) == "table" ) then
	 for _,line in pairs(tab) do
	    FishingBuddy.PrintHelp(line);
	 end
      else
	 -- check for a reference to another help item
	 local _,_,w = string.find(tab, "^@([A-Z0-9_]+)$");
	 if ( w ) then
	    FishingBuddy.PrintHelp(FBConstants[w]);
	 else
	    FishingBuddy.Output(tab);
	 end
      end
   end
end

FishingBuddy["EFSV"] = {};
FishingBuddy["EFSV"]["MusicVolume"] = tonumber(GetCVar("MusicVolume"));
FishingBuddy["EFSV"]["AmbienceVolume"] = tonumber(GetCVar("AmbienceVolume"));
FishingBuddy["EFSV"]["SoundVolume"] =tonumber(GetCVar("SoundVolume"));
local SoundWasEnhanced;
FishingBuddy.EnhanceFishingSounds = function(turniton)
   if ( GetSetting("EnhanceFishingSounds") == 1 ) then
      if ( turniton ) then
         -- collect the current value
         FishingBuddy["EFSV"]["MusicVolume"] = tonumber(GetCVar("MusicVolume"));
         FishingBuddy["EFSV"]["AmbienceVolume"] = tonumber(GetCVar("AmbienceVolume"));
         FishingBuddy["EFSV"]["SoundVolume"] =tonumber(GetCVar("SoundVolume"));
	 -- turn 'em off!
	 for setting in pairs(FishingBuddy["EFSV"]) do
	    local value = GetSetting("EnhanceSound"..setting);
	    FishingBuddy.Debug("Enhance "..setting.." "..value);
	    SetCVar(setting, value);
	 end
	 SoundWasEnhanced = true;
      else
	 if ( SoundWasEnhanced ) then
	    for setting, value in pairs(FishingBuddy["EFSV"]) do
	       SetCVar(setting, value);
	    end
	    SoundWasEnhanced = false;
	 end
      end
   end
end

-- Drop-down menu support
local function ToggleSetting(setting)
   local value = GetSetting(setting);
   if ( not value ) then
      value = 0;
   end
   SetSetting(setting, 1 - value);
   FishingBuddy.WatchUpdate();
   FishingBuddy.UpdateMinimap();
end
FishingBuddy.ToggleSetting = ToggleSetting;

-- save some memory by keeping one copy of each one
local ToggleFunctions = {};
-- let's use closures
local function MakeToggle(name)
   if ( not ToggleFunctions[name] ) then
      local n = name;
      ToggleFunctions[name] = function() ToggleSetting(n) end;
   end
   return ToggleFunctions[name];
end
FishingBuddy.MakeToggle = MakeToggle;

FishingBuddy.MakeDropDown = function(switchItem, switchSetting)
   local info;
   -- If no outfit frame, we can't switch outfits...
   if ( FishingBuddy.OutfitManager.HasManager() ) then
      info = {};
      info.text = switchItem;
      info.func = MakeToggle(switchSetting);
      info.checked = (GetSetting(switchSetting) == 1);
      info.keepShownOnClick = 1;
      UIDropDownMenu_AddButton(info);
      info = {};
      info.disabled = 1;
      UIDropDownMenu_AddButton(info);
   end

   for name,option in pairs(FishingBuddy.OPTIONS) do
      if ( option.m ) then
	 local addthis = true;
	 if ( option.check ) then
	    addthis = option.check();
	 end
	 if ( addthis ) then
	    info = {};
	    info.text = option.text;
	    info.func = MakeToggle(name);
	    info.checked = (GetSetting(name) == 1);
	    info.keepShownOnClick = 1;
	    UIDropDownMenu_AddButton(info);
	 end
      end
   end
end

-- utility functions
FishingBuddy.AddTooltip = function(text, r, g, b)
   if ( text ) then
      if ( type(text) == "table" ) then
	 for _,l in pairs(text) do
	    FishingBuddy.AddTooltip(l.text, l.r, l.g, l.b);
	 end
      else
	 GameTooltip:AddLine(text, r, g, b);
      end
   end
end

FishingBuddy.ChatLink = function(item, name, color)
   if( item and name and ChatFrameEditBox:IsVisible() ) then
      if not color then
	 color = FBConstants.Colors.WHITE;
      end
      local link = "|c"..color.."|Hitem:"..item.."|h["..name.."]|h|r";
      ChatFrameEditBox:Insert(link);
   end
end

FishingBuddy.FishSort = function(tab, forcename)
   if ( forcename or GetSetting("SortByPercent") == 0 ) then
      table.sort(tab, function(a,b) return (a.index and b.index and a.index<b.index) or
                                           (a.text and b.text and a.text<b.text); end);
   else
      table.sort(tab, function(a,b) return a.count and b.count and b.count<a.count; end);
   end
end

FishingBuddy.StripRaw = function(fishie)
   if ( fishie ) then
      local s,e = string.find(fishie, FBConstants.RAW.." ");
      if ( s ) then
         if ( s > 1 ) then
	    fishie = string.sub(fishie, 1, s-1)..string.sub(fishie, e+1);
         else
	    fishie = string.sub(fishie, e+1);
         end
      else
         s,e = string.find(fishie, " "..FBConstants.RAW);
         if ( s ) then
	    fishie = string.sub(fishie, 1, s-1)..string.sub(fishie, e+1);
         end
      end
      return fishie;
   end
   -- this means an import failed somewhere
   return FBConstants.UNKNOWN;
end

FishingBuddy.ToggleDropDownMenu = function(level, value, menu, anchor, xOffset, yOffset)
   ToggleDropDownMenu(level, value, menu, anchor, xOffset, yOffset);
   if (not level) then
      level = 1;
   end
   local anchorName;
   if ( type(anchor) == "string" ) then
      anchorName = anchor;
   else
      anchorName = anchor:GetName();
   end
   local frame = getglobal("DropDownList"..level);
   local uiScale = UIParent:GetScale()
   if ( frame:GetRight() > ( GetScreenWidth()*uiScale ) ) then
      if ( anchorName == "cursor" ) then
         if ( not xOffset ) then
            xOffset = 0;
         end
         if ( not yOffset ) then
            yOffset = 0;
         end
         local cursorX, cursorY = GetCursorPosition();
         xOffset = -cursorX + xOffset;
         yOffset = cursorY + yOffset;
      else
         if ( not xOffset or not yOffset ) then
            xOffset = 8;
            yOffset = 22;
         end
      end
      frame:ClearAllPoints();
      frame:SetPoint("TOPRIGHT", anchorName, "BOTTOMLEFT", -xOffset, yOffset);
   end
   if ( frame:GetBottom() < 0 ) then
      frame:ClearAllPoints();
      frame:SetPoint("BOTTOMRIGHT", anchorName, "BOTTOMLEFT", -xOffset, yOffset);
   end
end

FishingBuddy.EnglishList = function(list, conjunction)
   if ( list ) then
      local n = table.getn(list);
      local str = "";
      for idx=1,n do
	 local name = list[idx];
	 if ( idx == 1 ) then
	    str = name;
	 elseif ( idx == n ) then
	    str = str .. ", ";
	    if ( conjunction ) then
	       str = str .. conjunction;
	    else
	       str = str .. "and";
	    end
	       str = str .. " " .. name;
	 else
	    str = str .. ", " .. name;
	 end
      end
      return str;
   end
end

FishingBuddy.Message = function(msg, r, g, b)
   FishingBuddy.Output(FBConstants.NAME..": "..msg, r, g, b);
end

FishingBuddy.Print = function(...)
   local msg = string.format(unpack(arg));
   FishingBuddy.Message(msg);
end

FishingBuddy.Error = function(msg)
   FishingBuddy.Output(FBConstants.NAME..": "..msg, 1.0, 0, 0);
end

FishingBuddy.UIError = function(msg)
   -- Okay, this check is probably not necessary...
   if ( UIErrorsFrame ) then
      UIErrorsFrame:AddMessage(msg, 1.0, 0.1, 0.1, 1.0, UIERRORS_HOLD_TIME);
   else
      FishingBuddy.Error(msg);
   end
end

FishingBuddy.Testing = function(line)
   if ( not FishingBuddy_Info["Testing"] ) then
      FishingBuddy_Info["Testing"] = {};
   end
   tinsert(FishingBuddy_Info["Testing"], line);
end
