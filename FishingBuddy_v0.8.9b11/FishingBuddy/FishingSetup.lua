-- FishingSetup
--
-- Load out translation strings and such

FBConstants = {};

FBConstants.CURRENTVERSION = 8901;

FBConstants.Colors = {};
FBConstants.Colors.RED   = "ffff0000";
FBConstants.Colors.GREEN = "ff00ff00";
FBConstants.Colors.BLUE  = "ff0000ff";
FBConstants.Colors.YELLOW  = "ff00ffff";
FBConstants.Colors.PURPLE = "ffff00ff";
FBConstants.Colors.WHITE = "ffffffff";

FBConstants.DEFAULT_MINIMAP_POSITION = 256;

local Setup = {};
Setup.FixupThis = function(target, tag, what)
   if ( type(what) == "table" ) then
      for idx,str in what do
	 what[idx] = Setup.FixupThis(source, target, tag, str);
      end
      return what;
   elseif ( type(what) == "string" ) then
      local pattern = "#([A-Z0-9_]+)#";
      local s,e,w = string.find(what, pattern);
      while ( w ) do
	 if ( type(target[w]) == "string" ) then
	    local s1 = strsub(what, 1, s-1);
	    local s2 = strsub(what, e+1);
	    what = s1..target[w]..s2;
	    s,e,w = string.find(what, pattern);
	 elseif ( FBConstants.Colors and FBConstants.Colors[w] ) then
	    local s1 = strsub(what, 1, s-1);
	    local s2 = strsub(what, e+1);
	    what = s1..FBConstants.Colors[w]..s2;
	    s,e,w = string.find(what, pattern);
	 else
	    -- stop if we can't find something to replace it with
	    w = nil;
	 end
      end
      return what;
   else
      FishingBuddy.Debug("tag "..tag.." type "..type(what));
      FishingBuddy.Dump(what);
   end
end

Setup.FixupStrings = function(source, locale, target)
   local translation = source["enUS"];
   for tag,_ in translation do
      target[tag] = Setup.FixupThis(target, tag, target[tag]);
   end
end

Setup.FixupBindings = function(source, target)
   local translation = source["enUS"];
   for tag,str in translation do      
      if ( string.find(tag, "^BINDING") ) then
	 setglobal(tag, target[tag]);
	 target[tag] = nil;
      end
   end
end

local missing = {};
Setup.LoadTranslation = function(source, lang, target, record)
   local translation = source[lang];
   for tag,value in translation do
      if ( not target[tag] ) then
	 target[tag] = value;
	 if ( record ) then
	    missing[tag] = 1;
	 end
      end
   end
end

Setup.Translate = function(addon, source, target)
   local locale = GetLocale();
   if ( FBEnEspagnolFlag ) then
      locale = "esES";
   end
   --locale = "deDE";
   target.VERSION = GetAddOnMetadata(addon, "Version");
   Setup.LoadTranslation(source, locale, target);
   if ( locale ~= "enUS" ) then
      Setup.LoadTranslation(source, "enUS", target);
   end
   Setup.FixupStrings(source, locale, target);
   Setup.FixupBindings(source, target);
end

Setup.Translate("FishingBuddy", FishingTranslations, FBConstants);

-- Let the plugins use this
FishingBuddy.Setup = Setup;

-- dump the memory we've allocated for all the translations
FishingTranslations = nil;

FBConstants.KEYS_NONE = 0;
FBConstants.KEYS_SHIFT = 1;
FBConstants.KEYS_CTRL = 2;
FBConstants.KEYS_ALT = 3;
FBConstants.Keys = {};
FBConstants.Keys[FBConstants.KEYS_NONE] = FBConstants.KEYS_NONE_TEXT;
FBConstants.Keys[FBConstants.KEYS_SHIFT] = FBConstants.KEYS_SHIFT_TEXT;
FBConstants.Keys[FBConstants.KEYS_CTRL] = FBConstants.KEYS_CTRL_TEXT;
FBConstants.Keys[FBConstants.KEYS_ALT] = FBConstants.KEYS_ALT_TEXT;

FBConstants.BROADCAST_DUMP = 0;
FBConstants.BROADCAST_RECV = 1;
FBConstants.Broadcast = {};
FBConstants.Broadcast[FBConstants.BROADCAST_DUMP] = FBConstants.BROADCAST_DUMP_TEXT;
FBConstants.Broadcast[FBConstants.BROADCAST_RECV] = FBConstants.BROADCAST_RECV_TEXT;

FBConstants.SCHOOL_FISH = 0;
FBConstants.SCHOOL_WRECKAGE = 1;
FBConstants.SCHOOL_DEBRIS = 2;
FBConstants.SCHOOL_WATER = 3;
FBConstants.SCHOOL_TASTY = 4;
FBConstants.SCHOOL_OIL = 5;

FBConstants.WILDCARD_EVT = "*";
FBConstants.ADD_FISHIE_EVT = "ADD_FISHIE";
FBConstants.UIERROR_EVT = "UI_ERROR";

FBConstants.FBEvents = {};
FBConstants.FBEvents[FBConstants.WILDCARD_EVT] = 1;
FBConstants.FBEvents[FBConstants.ADD_FISHIE_EVT] = 1;
FBConstants.FBEvents[FBConstants.UIERROR_EVT] = 1;

