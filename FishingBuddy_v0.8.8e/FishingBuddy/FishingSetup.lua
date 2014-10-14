-- FishingSetup
--
-- Load out translation strings and such

FishingBuddy.VERSION = GetAddOnMetadata("FishingBuddy", "Version");
FishingBuddy.CURRENTVERSION = 8800;

FishingBuddy.Colors = {};
FishingBuddy.Colors.RED   = "ffff0000";
FishingBuddy.Colors.GREEN = "ff00ff00";
FishingBuddy.Colors.BLUE  = "ff0000ff";
FishingBuddy.Colors.YELLOW  = "ff00ffff";
FishingBuddy.Colors.PURPLE = "ffff00ff";
FishingBuddy.Colors.WHITE = "ffffffff";

FishingBuddy.DEFAULT_MINIMAP_POSITION = 256;

local Setup = {};

Setup.FixupThis = function(tag, what)
   if ( type(what) == "table" ) then
      for idx,str in what do
	 what[idx] = Setup.FixupThis(tag, str);
      end
      return what;
   elseif ( type(what) == "string" ) then
      local pattern = "#([A-Z0-9_]+)#";
      local s,e,w = string.find(what, pattern);
      while ( w ) do
	 if ( type(FishingBuddy[w]) == "string" ) then
	    local s1 = strsub(what, 1, s-1);
	    local s2 = strsub(what, e+1);
	    what = s1..FishingBuddy[w]..s2;
	    s,e,w = string.find(what, pattern);
	 elseif ( FishingBuddy.Colors[w] ) then
	    local s1 = strsub(what, 1, s-1);
	    local s2 = strsub(what, e+1);
	    what = s1..FishingBuddy.Colors[w]..s2;
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

Setup.FixupStrings = function(locale)
   local translation = FishingTranslations["enUS"];
   for tag,_ in translation do
      FishingBuddy[tag] = Setup.FixupThis(tag, FishingBuddy[tag]);
   end
end

Setup.FixupBindings = function()
   local translation = FishingTranslations["enUS"];
   for tag,str in translation do      
      if ( string.find(tag, "^BINDING") ) then
	 setglobal(tag, FishingBuddy[tag]);
	 FishingBuddy[tag] = nil;
      end
   end
end

local missing = {};
Setup.LoadTranslation = function(lang, record)
   local translation = FishingTranslations[lang];
   for tag,value in translation do
      if ( not FishingBuddy[tag] ) then
	 FishingBuddy[tag] = value;
	 if ( record ) then
	    missing[tag] = 1;
	 end
      end
   end
end

Setup.Translate = function()
   local locale = GetLocale();
   if ( FBEnEspagnolFlag ) then
      locale = "esES";
   end
   --locale = "deDE";
   Setup.LoadTranslation(locale);
   if ( locale ~= "enUS" ) then
      Setup.LoadTranslation("enUS");
   end
   Setup.FixupStrings(locale);
   Setup.FixupBindings();
end

Setup.Translate();

-- throw all this away now that we're done with it
Setup = nil;
-- dump the memory we've allocated for all the translations
FishingTranslations = nil;

local byweeks = {};
byweeks[FishingBuddy.ABBREV_JANUARY] = 0;
byweeks[FishingBuddy.ABBREV_APRIL] = 13;
byweeks[FishingBuddy.ABBREV_JULY] = 26;
byweeks[FishingBuddy.ABBREV_OCTOBER] = 39;
byweeks[FishingBuddy.ABBREV_DECEMBER] = 52;

FishingBuddy.BYWEEKS_TABLE = byweeks;

FishingBuddy.KEYS_NONE = 0;
FishingBuddy.KEYS_SHIFT = 1;
FishingBuddy.KEYS_CTRL = 2;
FishingBuddy.KEYS_ALT = 3;
FishingBuddy.Keys = {};
FishingBuddy.Keys[FishingBuddy.KEYS_NONE] = FishingBuddy.KEYS_NONE_TEXT;
FishingBuddy.Keys[FishingBuddy.KEYS_SHIFT] = FishingBuddy.KEYS_SHIFT_TEXT;
FishingBuddy.Keys[FishingBuddy.KEYS_CTRL] = FishingBuddy.KEYS_CTRL_TEXT;
FishingBuddy.Keys[FishingBuddy.KEYS_ALT] = FishingBuddy.KEYS_ALT_TEXT;

FishingBuddy.SCHOOL_FISH = 0;
FishingBuddy.SCHOOL_WRECKAGE = 1;
FishingBuddy.SCHOOL_DEBRIS = 2;
FishingBuddy.SCHOOL_WATER = 3;
FishingBuddy.SCHOOL_TASTY = 4;
FishingBuddy.SCHOOL_OIL = 5;
