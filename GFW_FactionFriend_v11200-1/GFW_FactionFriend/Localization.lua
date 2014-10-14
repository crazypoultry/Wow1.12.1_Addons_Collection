------------------------------------------------------
-- localization.lua
-- English strings by default, localizations override with their own.
------------------------------------------------------

-- Zone names must be localized or automatic switching of the reputation watch bar will not work!
ZONE_AV             = "Alterac Valley";
ZONE_AB             = "Arathi Basin";
ZONE_WSG            = "Warsong Gulch";
ZONE_HINTERLANDS	= "The Hinterlands";
ZONE_SILITHUS       = "Silithus";
ZONE_AQ20           = "Ruins of Ahn'Qiraj";
ZONE_AQ40           = "Ahn'Qiraj";
ZONE_ZG             = "Zul'Gurub";
ZONE_WPL            = "Western Plaguelands";
ZONE_EPL            = "Eastern Plaguelands";
ZONE_STRATHOLME     = "Stratholme";
ZONE_SCHOLOMANCE    = "Scholomance";
ZONE_NAXXRAMAS      = "Naxxramas";
ZONE_FELWOOD		= "Felwood";
ZONE_WINTERSPRING	= "Winterspring";

-- Faction names must be localized; otherwise neither automatic rep-watch-bar switching nor display of potential rep from item turnins will work!
FACTION_FROSTWOLF			= "Frostwolf Clan";   -- ???
FACTION_DEFILERS			= "The Defilers";     -- ???
FACTION_WARSONG				= "Warsong Outriders";     -- ???
FACTION_STORMPIKE			= "Stormpike Guard";
FACTION_ARATHOR				= "The League of Arathor";
FACTION_SILVERWING			= "Silverwing Sentinels";
FACTION_DARKMOON            = "Darkmoon Faire";
FACTION_ZANDALAR            = "Zandalar Tribe";
FACTION_BROOD_NOZDORMU      = "Brood of Nozdormu";
FACTION_CENARION_CIRCLE     = "Cenarion Circle";
FACTION_ARGENT_DAWN         = "Argent Dawn";
FACTION_TIMBERMAW           = "Timbermaw Hold";
FACTION_THORIUM_BROTHERHOOD = "Thorium Brotherhood";
FACTION_GADGETZAN			= "Gadgetzan";
FACTION_WILDHAMMER			= "Wildhammer Clan";
FACTION_DWARF               = "Ironforge";
FACTION_NELF                = "Darnassus";
FACTION_GNOME               = "Gnomeregan Exiles";
FACTION_HUMAN               = "Stormwind";
FACTION_ORC                 = "Orgrimmar";
FACTION_TAUREN              = "Thunder Bluff";
FACTION_TROLL               = "Darkspear Trolls";
FACTION_FORSAKEN            = "Undercity";

-- Localized strings below this line are just text shown by the addon's UI; it will still function if they aren't localized.

REPUTATION_TICK_TOOLTIP = "%d reputation points available:";
FFF_REPORT_LINE_ITEM = "%dx %s";            -- A in example below
FFF_REPORT_NUM_TURNINS = " (%d turnins)";	-- A in example below
FFF_REPORT_NUM_POINTS = "%d points";        -- A in example below
FFF_COUNT_IN_BANK = " (%d in bank)";        -- A in example below

-- example usage:
--	100 points (4 turnins):		40x [Invader's Scourgestone] (13 in bank)
--  |---A----||----B-----|		|------------C-------------||-----D-----|

-- Options panel

FFF_OPTIONS = "FactionFriend Options";
FFF_OPTIONS_SWITCHBAR = "Show/switch the reputation watch bar:";
FFF_OPTION_ZONES = "When entering zones with faction objectives";
FFF_OPTION_REP_GAINED = "When gaining reputation with any faction";
FFF_OPTIONS_OTHER = "Other reputation watch bar options:";
FFF_OPTION_SHOW_POTENTIAL = "Show potential reputation gain from item turnins";

