--[[
  Guild Event Manager by Kiki of European Cho'gall
    Subscribers sorting - By stamp and minimum - By Laric from code found on forum
]]


if ( GetLocale() == "frFR" ) then
GEM_SORT_MIN_NAME = "Date and min";
GEM_SORT_MIN_HELP = "Tri les joueurs en fonction de leur date d'inscription en respectant les minimas de classe.";
elseif ( GetLocale() == "deDE" ) then
GEM_SORT_MIN_NAME = "Datum and min";
GEM_SORT_MIN_HELP = "Sortiert Spieler unter Beachtung ihrer Anmeldezeit.";
else
GEM_SORT_MIN_NAME = "Date and min";
GEM_SORT_MIN_HELP = "Sort players using their subscription time and fill minimum first.";
end
--------------- Internal functions ---------------

local function _GEM_SORT_MIN_SortList(tab1,tab2)
  if(tab1.forcetit == 1)
  then
    if(tab2.forcetit == 0)
    then
      return true;
    end
  else
    if(tab2.forcetit == 1)
    then
      return false;
    end
  end
  return tab1.stamp < tab2.stamp;
end

local function _GEM_SORT_MIN_Sort(event,players,limits,max_count)
  local list = {};
  local tits = {};
  local subs = {};
   local classlist = { }
   classlist = {
      ["WARRIOR"] = {
         players = {},
      },
      ["PALADIN"] = {
         players = {},
      },
      ["SHAMAN"] = {
         players = {},
      },
      ["ROGUE"] = {
         players = {},
      },
      ["MAGE"] = {
         players = {},
      },
      ["WARLOCK"] = {
         players = {},
      },
      ["HUNTER"] = {
         players = {},
      },
      ["DRUID"] = {
         players = {},
      },
      ["PRIEST"] = {
         players = {},
      },
   };
   
   for class in limits do
      -- Create tables for each class
      --GEM_ChatPrint(class);
      for name, tab in players do
         if (class == tab.class) then
            if(tab.forcetit == nil) then
               tab.forcetit = 0;
            end;
            table.insert(classlist[class].players, {name=name; stamp = tab.update_time; class = tab.class; forcetit = tab.forcetit });
         end
      end
      --GEM_ChatPrint("  Found: "..getn(classlist[class].players));
       
      -- Sort this table
      table.sort(classlist[class].players, _GEM_SORT_MIN_SortList);
       
      -- insert players up to minimum class requirements
      for i, tab in classlist[class].players do
         --GEM_ChatPrint("  Number of Titulars: "..table.getn(tits));
         --GEM_ChatPrint("  Minimum Required: "..limits[class].min);
         --GEM_ChatPrint("  Number of Class: "..limits[class].count)
         if ( table.getn(tits) < max_count and limits[class].count < limits[class].min ) then             
            --GEM_ChatPrint("  Adding: "..tab.name.." to Titulars");
            table.insert(tits, tab.name)
            limits[class].count = limits[class].count + 1;
         else
            table.insert(list, {name=tab.name; stamp = tab.stamp; class = tab.class; forcetit = tab.forcetit });
         end
      end       
   end

--  -- Sort it by stamp
  table.sort(list,_GEM_SORT_MIN_SortList);
 
--  -- Fill tits and subs, using limits
  for i,tab in list do
    if(table.getn(tits) >= max_count or limits[tab.class].count >= limits[tab.class].max) -- Over the global or class limit ?
    then
      table.insert(subs,tab.name);
    else
      table.insert(tits,tab.name);
      limits[tab.class].count = limits[tab.class].count + 1;
    end
  end
 
  -- Return lists
  return tits,subs;
end


--------------- Plugin structure ---------------

GEM_SORT_MIN_Stamp = {
  --[[
    Name parameter. [MANDATORY]
     Displayed name of the sorting plugin.
  ]]
  Name = GEM_SORT_MIN_NAME;
 
  --[[
    SortType parameter. [MANDATORY]
     Internal code for the sorting type (must be unique).
  ]]
  SortType = "Stampmin";
 
  --[[
    Subscribers sorting function. [MANDATORY]
     Sorts all passed players in two lists.
     Params :
      - event : Event (STRUCT) : READ ONLY
      - players : Array indexed by Names (STRINGS) of {update_time(INT),guild(STRING),class(STRING),level(INT),forcetit(INT)} : READ ONLY
      - limits : Array indexed by Classes (STRINGS) of {min(INT),max(INT),count(INT)} : 'min'/'max' is the min/max allowed for this class, 'count' is the current count in the class (always 0) : READ/WRITE
      - max_count : (INT) is the max titulars allowed for the event
     Returns :
      - Array of Names (STRING) : Titulars
      - Array of Names (STRING) : Substitutes
  ]]
  Sort = function(event,players,limits,max_count)
    return _GEM_SORT_MIN_Sort(event,players,limits,max_count);
  end;
 
  --[[
    Subscribers recover function. [MANDATORY]
     Gives the plugin a chance to re-initialize its internal data (lost when leader crashed), based on the passed 'players' structure.
     The "Sort" function will be called just after this call, so your data must be initialized.
     Params :
      - event : Event (STRUCT) : READ ONLY
      - players : Array indexed by Names (STRINGS) of {update_time(INT),guild(STRING),class(STRING),level(INT)} : READ ONLY
                  WARNING : 'update_time' and 'guild' values are not accurate here, don't rely on them !
      - limits : Array indexed by Classes (STRINGS) of {min(INT),max(INT),count(INT)} : 'min'/'max' is the min/max allowed for this class, 'count' is the current count in the class (always 0) : READ/WRITE
      - max_count : (INT) is the max titulars allowed for the event
  ]]
  Recover = function(event,players,limits,max_count)
    -- Nothing to do, no internal data
  end;
 
  --[[
    Configure function. [OPTIONAL]
     Configures the plugin.
  ]]
  --Configure = function()
  --end;

  --[[
    Help parameter. [OPTIONAL]
     Help string displayed when you mouse over the sort type.
  ]]
  Help = GEM_SORT_MIN_HELP;
 
  --[[
    Default parameter. [MUST NOT BE SET]
     Sets this plugin as the default one. Must only be set by the "Stamp" plugin.
  ]]
  Default = false;
};

function GEM_SORT_MIN_OnLoad()
  GEM_SUB_RegisterPlugin(GEM_SORT_MIN_Stamp);
end 
