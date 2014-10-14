-- TargetCensus code

TargetCensus = {
   internal = {};
};

local INFO_KEY_LIST = {
   c = "Class",
   fc = 'Faction',
   s = 'Sex',
   pvp = 'PvP',
   pw = 'PowerType',
   sk = 'Skinnable',

   -- Retired fields below for information only
   fg = 'fg',
   fn = 'fn',
   tv = 'tv',
   am = 'am',
   am = 'ao',
   ar = 'ar',
   as = 'as',
   df = 'df',
};

local LEVEL_INFO_KEY_LIST = {
   am = 'AtkMain',
   am = 'AtkOff',
   ar = 'AtkRanged',
   as = 'AtkSpeed',
   df = 'Defense',
};

local POWER_TYPE_MAP = {
   [0] = "mana",
   [1] = "rage",
   [2] = "focus",
   [3] = "energy",
   [4] = "happy"
};

local SEX_MAP = {
   [1] = 'U',
   [2] = 'M',
   [3] = 'F',
   ['1'] = 'U',
   ['2'] = 'M',
   ['3'] = 'F',
};

local SEX_FIX_MAP = {
--   ['MFU'] = 'MFU',
   ['MUF'] = 'MFU',
   ['FMU'] = 'MFU',
   ['FUM'] = 'MFU',
   ['UMF'] = 'MFU',
   ['UFM'] = 'MFU',

--   ['MF'] = 'MF',
   ['FM'] = 'MF',
--   ['MU'] = 'MU',
   ['UM'] = 'MU',
--   ['FU'] = 'FU',
   ['UF'] = 'FU',
}

local function Print(message)
   DEFAULT_CHAT_FRAME:AddMessage("TargetCensus: " .. message);
end

local function Info(message)
   DEFAULT_CHAT_FRAME:AddMessage("|cffccccccTargetCensus: " .. message .. "|r");
end

local function ShowArg(label,value)
   if (value ~= nil) then
      DEFAULT_CHAT_FRAME:AddMessage("[" .. label .. "] " .. value);
   end
end

local function GetSubtable(table, index) 
   local ret = table[index];
   if (ret == nil) then
      ret = {};
      table[index] = ret;
   end
   return ret;
end

local function GetPower(power)
   if (power and (power > 0)) then
      return power;
   end
end

local function GetFactionPair(group,name)
   if (group) then
      if (name) then
	 return group .. "/" .. name;
      else
	 return group;
      end
   else
      if (name) then
	 return "/" .. name;
      end
   end
end

local function PackWorker(c)
   return ((c == '\\') and '\\\\') or ((c == ';') and 's') or c;
end
local PackInfo_Keys = {};
local function PackInfo(info)
   local keys = PackInfo_Keys;
   table.setn(keys, 0);
   for k,v in info do
      table.insert(keys, k);
   end
   table.sort(keys);
   table.insert(keys, nil);
   local str = string;
   local fmt,gsub,ret=str.format,str.gsub;
   for _,k in ipairs(keys) do
      ret = fmt((ret and "%s;%s=%s") or "%s%s=%s", ret or '', k, 
                gsub(info[k], "([\\;])", PackWorker));
   end
   return ret;
end

local function UnpackSubWorker(c)
   return ((c=='s') and ';') or c;
end
local function UnpackWorker(name,value)
   UnpackTable[name] = string.gsub(value, "\\(.)", UnpackSubWorker);
end
local function UnpackInfo(info, rtable)
   UnpackTable = rtable or {};
   if (info) then
      string.gsub(info, "([^=;]*)=([^;]*);?", UnpackWorker);
   end
   rtable = UnpackTable;
   UnpackTable = nil;
   return rtable;
end

local TOOLTIP_NAME = nil;
local TOOLTIP_FLAG_SKINNABLE = false;
local TOOLTIP_FLAG_CORPSE = false;

local function Reset_Tooltip_Flags(name)
   TOOLTIP_NAME = name;
   TOOLTIP_FLAG_SKINNABLE = false;
   TOOLTIP_FLAG_CORPSE = false;
end

local function Filter_Tooltip(value, name)
   if (value == "Skinnable") then
      TOOLTIP_FLAG_SKINNABLE = true;
      return nil;
   end
   if ((value == "PvP") or (value == TOOLTIP_NAME)) then
      return nil;
   end
   if (string.sub(value,1,6) == 'Level ') then
      if (string.find(value, "Corpse")) then
	 TOOLTIP_FLAG_CORPSE = true;
      end
      return '-';
   end
   return gsub(value, "([\\;])", PackWorker);
end

local WipeTable_Keys={};
local function WipeTableKeyHelper(k) table.insert(WipeTable_Keys,k) end
local function WipeTable(t)
   local wk = WipeTable_Keys;
   table.setn(wk, 0);
   table.foreach(t, WipeTableKeyHelper);
   table.insert(wk, nil);
   for _,k in ipairs(wk) do t[k]=nil; end
   return t;
end

local CheckUnit_Info={};
local CheckUnit_Compare={};
local CheckUnit_TTData={};
local CheckUnit_TTKeep={};
local CheckUnit_Diff={};

local function Check_Unit_TTFilter(k,v)
   v=Filter_Tooltip(v); 
   if (v) then table.insert(CheckUnit_TTKeep, v); end;
end

local function Check_Unit_Compare(info, oldEnc, diff, fieldMap)
   local cmp = UnpackInfo(oldEnc, WipeTable(CheckUnit_Compare));
   for k,v in fieldMap do
      if (info[k] ~= cmp[k]) then
	 if (not cmp[k]) then
	    table.insert(diff,'+'..v);
	 elseif (not info[k]) then
	    table.insert(diff,'-'..v);
	 elseif (tostring(info[k]) ~= cmp[k]) then
	    table.insert(diff, v);
	 end
      end
   end
end

local function Check_Unit(unit)
   if ((not UnitExists(unit))
       or UnitPlayerControlled(unit)
	  or (UnitName(unit) == UNKNOWNOBJECT)) then
      return nil;
   end
   local type = UnitCreatureType(unit) or 'UNKNOWN';
   local family = UnitCreatureFamily(unit) or '';
   local class = UnitClassification(unit);
   local name = UnitName(unit);
   local level = UnitLevel(unit);
   if (level == 0) then
      return;
   end
   local factionGroup, factionName = UnitFactionGroup(unit);

   TargetCensusTTip:SetOwner(UIParent, "ANCHOR_NONE");
   TargetCensusTTip:SetUnit(unit);
   local ttrow = 0;
   local ttdata = CheckUnit_TTData;
   table.setn(ttdata, 0);
   while (true) do
      ttrow = ttrow + 1;
      local ttip = getglobal("TargetCensusTTipTextLeft" .. ttrow);
      if (not ttip) then
	 break;
      end
      local ttxt = ttip:GetText();
      if (not ttxt) then
	 break;
      end
      if (ttxt ~= '') then
	 table.insert(ttdata, ttxt);
      end
   end
   -- Stick a nil in the end.
   table.insert(ttdata, nil);
   table.remove(ttdata);

   local db = TargetCensus_DB;
   local SILENT = db["_silent"];

   local TYPE = GetSubtable(db, type);
   local FAMILY = GetSubtable(TYPE, family);

   local now = date() .. ' ' .. UnitName("player");

   local ENTITY = FAMILY[name];
   local isNew = nil;
   if (ENTITY == nil) then
      if (not SILENT) then
	 Print("Recording new " .. type .. ": " .. name);
      end
      isNew = true;
      ENTITY = {};
      ENTITY.created = now;
      FAMILY[name] = ENTITY;
   end
   ENTITY.seen = now;

   ---------------------------------------------------------------------------
   -- Scan tooltip info
   local ttkeep = CheckUnit_TTKeep;
   table.setn(ttkeep,0);
   Reset_Tooltip_Flags(name);
   table.foreachi(ttdata, Check_Unit_TTFilter);

   -- ----------------------------------------------------------------------
   -- Handle basic statistics
   local sex = UnitSex(unit);
   local sex = SEX_MAP[sex] or '_';

   local oi = ';' .. (ENTITY.info or '');
   local _,_,osex = string.find(oi, ";s=([^;]*)");
   -- Convert old data
   if (osex and SEX_MAP[osex]) then
      osex = SEX_MAP[osex];
   end
   -- Insert new sex if we've seen one before
   if (osex and string.find(osex, sex)) then
      sex = osex;
   elseif (osex) then
      sex = osex .. sex;
      -- Normalize order
      sex = SEX_FIX_MAP[sex] or sex;
   end

   local info = WipeTable(CheckUnit_Info);

   info.c = class;
   info.fc = GetFactionPair(factionGroup, factionName);
   info.s = sex;
   info.pvp = UnitIsPVP(unit);
   if (UnitManaMax(unit) > 0) then
      local pt = UnitPowerType(unit);
      info.pw = POWER_TYPE_MAP[pt] or pt;
   end

   if (not (TOOLTIP_FLAG_CORPSE and TOOLTIP_FLAG_SKINNABLE)) then
      if (string.find(oi,';sk=')) then
	 info.sk="1";
      end
   else 
      info.sk="1";
   end
   
   local diff = CheckUnit_Diff;
   table.setn(diff, 0);

   local infoStr = PackInfo(info);
   if (infoStr ~= ENTITY.info) then
      if (not isNew) then
	 Check_Unit_Compare(info, ENTITY.info, diff, INFO_KEY_LIST);
      end
      ENTITY.info = infoStr;
   end
 
   -- ----------------------------------------------------------------------
   -- Handle level-related statistics
   local info = WipeTable(CheckUnit_Info);
   local mainDmg,_,offDmg,_ = UnitAttackBothHands(unit);
   local rngDmg,_ = UnitRangedAttack(unit);
   local as = UnitAttackSpeed(unit);
   local def,_ = UnitDefense(unit);

   info.am = GetPower(mainDmg);
   info.ao = GetPower(offDmg);
   info.at = GetPower(rngDmg);
   info.df = GetPower(def);
   if (as and as > 0) then
      info.as = string.format("%.2f", as);
   end
   local lkey = "lvl_" .. level;
   local levelInfoStr = PackInfo(info);
   local oldLevelInfo = ENTITY[lkey];
   if (levelInfoStr ~= oldLevelInfo) then
      if (not isNew) then
	 if (not oldLevelInfo) then
	    table.insert(diff, "+L<" .. level .. ">");
	 else
	    Check_Unit_Compare(info, oldLevelInfo, diff, LEVEL_INFO_KEY_LIST);
	 end
      end
      ENTITY[lkey] = levelInfoStr;
   end

   local ttstr;
   if (table.getn(ttkeep) > 0) then
      ttstr = table.concat(ttkeep, ';');
      -- Drop level only
      if (ttstr == '-') then
	 ttstr = nil;
      end
   end

   if (ttstr ~= ENTITY.ttip) then
      if (not isNew) then
	 if (ENTITY.ttip) then
	    if (ttstr) then
	       table.insert(diff,"Tooltip");
	    else
	       table.insert(diff,"-Tooltip");
	    end
	 else
	    table.insert(diff,"+Tooltip");
	 end
      end
      ENTITY.ttip = ttstr;
   end

   ---------------------------------------------------------------------------
   -- Handle location
   local zoneKey = "loc_" .. (GetZoneText() or 'UNKNOWN');
   local zoneLoc = (GetSubZoneText() or '');
   local loc = ENTITY[zoneKey];
   if (not loc) then
      ENTITY[zoneKey] = zoneLoc;
      if (not isNew) then
	 table.insert(diff, '+Zone');
      end
   elseif (loc ~= zoneLoc) then
      local multiLoc = zoneLoc .. '*';
      if (loc ~= multiLoc) then
	 if (multiLoc == '*') then
	    if (string.sub(loc, -1) ~= '*') then
	       ENTITY[zoneKey] = loc .. '*';
	    end
	 else
	    ENTITY[zoneKey] = multiLoc;
	 end
      end
   end

   
   if (table.getn(diff) > 0) then
      if (not SILENT) then
	 Info(name .. ": " .. table.concat(diff, " "));
      end
   end

   ---------------------------------------------------------------------------
   -- Handle level range summary
   if (ENTITY.level and ((ENTITY.level=='-1') or (ENTITY.level=='0'))) then
      if (not SILENT) then
	 Info("Fixing improperly stored level for " .. name);
      end
      ENTITY.level = nil;
   end
   if (level > 0) then
      local l = ENTITY.level;

      if (l == nil) then
	 ENTITY.level = level;
      end
      if (l) then
	 local b,e,lo,hi = string.find(l, "^(%d+)-(%d+)$");
	 if (lo) then
	    if (level < tonumber(lo)) then
	       ENTITY.level = level .. "-" .. hi;
	    elseif (level > tonumber(hi)) then
	       ENTITY.level = lo .. "-" .. level;
	    end
	 else
	    if (l < level) then
	       ENTITY.level = l .. "-" .. level;
	    elseif (l > level) then
	       ENTITY.level = level .. "-" .. l;
	    end
	 end
      end
   end

   ---------------------------------------------------------------------------
   -- Handle reaction summary
   local rkey = "react_" .. UnitFactionGroup("player");
   local reaction = UnitReaction(unit, "player");
   if (reaction ~= ENTITY[rkey]) then
      ENTITY[rkey] = reaction;
   end
   return ENTITY;
end

local currentTargetEntity = nil;

function TargetCensus_OnEvent(event)
   -- ShowArg("event", event);
   -- ShowArg("arg0", arg0);
   -- ShowArg("arg1", arg1);
   -- ShowArg("arg2", arg2);
   -- ShowArg("arg3", arg3);
   -- ShowArg("arg4", arg4);
   -- ShowArg("arg5", arg5);
   -- ShowArg("arg6", arg6);
   -- ShowArg("arg7", arg7);
   -- ShowArg("arg8", arg8);
   -- ShowArg("arg9", arg9);
   
   if (event == "UPDATE_MOUSEOVER_UNIT") then
      Check_Unit("mouseover");
      return;
   end

   if (event == "PLAYER_TARGET_CHANGED") then
      currentTargetCreature = Check_Unit("target");
      return;
   end

end

local function TargetCensus_Cmd(msg)
   -- Just list everything we know in this zone
   local zone = GetZoneText() or '';

   local db = TargetCensus_DB;

   if (not db) then
      message("TargetCensus Database not present!");
      return;
   end

   Print("Census of " .. zone .. ":");

   local zoneKey = "loc_" .. zone;

   for type, TYPE in db do
      for family, FAMILY in TYPE do
	 for name, ENTITY in FAMILY do
	    if (ENTITY[zoneKey]) then
	       local class = ENTITY.class;
	       local fname = family;
	       if (fname == "") then
		  fname = type;
	       end

	       local class = ''; -- Until I do decoding

	       local levels = ENTITY.level;
	       if (levels) then
		  levels = ' level ' .. levels;
	       else
		  levels = ' unknown level'
	       end

	       local msg = "    " .. name .. ":" .. levels .. class
		  .. " " .. fname;
	       DEFAULT_CHAT_FRAME:AddMessage(msg);
	    end
	 end
      end
   end
end

local function TargetCensus_Fix_Cmd(msg)
   -- Fix crocilisk problem
   local db = TargetCensus_DB;

   if (not db) then
      message("TargetCensus Database not present!");
      return;
   end

   local TYPE = db["Beast"];
   local FAMILY = TYPE and TYPE["Crocilisk"];
   local NEW_FAMILY = TYPE and TYPE["Crocolisk"];

   for name, ENTITY in FAMILY do
      local NEW_ENTITY = NEW_FAMILY[name];

      if (not NEW_ENTITY) then
	 DEFAULT_CHAT_FRAME:AddMessage("Fixing " .. name);
	 NEW_FAMILY[name] = FAMILY[name];
	 FAMILY[name] = nil;
      else
	 DEFAULT_CHAT_FRAME:AddMessage("Duplicate " .. name);
      end
   end
end

function TargetCensus_OnLoad()
   TargetCensus_DB = {};
   this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
   this:RegisterEvent("PLAYER_TARGET_CHANGED");

   SLASH_TARGETCENSUS_CMD1 = "/tcensus";
   SlashCmdList["TARGETCENSUS_CMD"] = TargetCensus_Cmd;

   -- SLASH_TARGETCENSUS_FIX_CMD1 = "/tcensusfix";
   -- SlashCmdList["TARGETCENSUS_FIX_CMD"] = TargetCensus_Fix_Cmd;
end

---------------------------------------------------------------------------

function TargetCensus.GetTypes()
   local ret = {};
   if (not TargetCensus_DB) then
      return nil;
   end
   for t in TargetCensus_DB do
      table.insert(ret, t);
   end
   return ret;
end

function TargetCensus.GetFamilies(type)
   local ret = {};
   if (not TargetCensus_DB) then
      return nil;
   end
   local TYPE = TargetCensus_DB[type];
   if (not TYPE) then
      return nil;
   end
   for f in TYPE do
      table.insert(ret, f);
   end
   return ret;
end

-- Get all the entities of a specific type and family (Zone is optional, but
-- if specified then only those that have been seen in the zone are returned)
function TargetCensus.GetEntities(type, family, zone)
   local ret = {};
   if (not TargetCensus_DB) then
      return nil;
   end
   local TYPE = TargetCensus_DB[type];
   if (not TYPE) then
      return nil;
   end
   local FAMILY = TYPE[family];
   if (not FAMILY) then
      return nil;
   end
   local zoneKey = zone and "loc_" .. zone;
   for e,E in FAMILY do
      if ((not zoneKey) or E[zoneKey]) then
	 table.insert(ret, e);
      end
   end
   return ret;
end

function TargetCensus.GetEntity(type, family, name)
   if (not TargetCensus_DB) then
      return nil;
   end
   local TYPE = TargetCensus_DB[type];
   if (not TYPE) then
      return nil;
   end
   local FAMILY = TYPE[family];
   if (not FAMILY) then
      return nil;
   end
   return TargetCensus.internal.MakeEntity(type, family, name, FAMILY[name]);
end
