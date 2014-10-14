TITAN_TRACKER_VERSION = "0.10";

TITAN_TRACKER_MENU_TEXT = "Tracker";
TITAN_TRACKER_BUTTON_LABEL = "Tracker";
TITAN_TRACKER_BUTTON_TEXT = "%s";
TITAN_TRACKER_TOOLTIP = "Tracker";

TITAN_TRACKER_TOOLTIP_TEXT = "Hint: Right-click to toggle Tracking abilities.";

TITAN_TRACKER_ABOUT_TEXT = "About";
TITAN_TRACKER_ABOUT_POPUP_TEXT = TitanUtils_GetGreenText("Titan Panel [Tracker]").."\n"..TitanUtils_GetNormalText("Version: ")..TitanUtils_GetHighlightText(TITAN_TRACKER_VERSION).."\n"..TitanUtils_GetNormalText("Author: ")..TitanUtils_GetHighlightText("Corgi");

-- Header Types
TITAN_TRACKER_SPELL_TYPE_FIND  = "Locating Abilities";
TITAN_TRACKER_SPELL_TYPE_TRACK = "Tracking Abilities";
TITAN_TRACKER_SPELL_TYPE_SENSE = "Sensing Abilities";

-- Object tracking
TITAN_TRACKER_SPELL_FIND_HERBS    = "Find Herbs";
TITAN_TRACKER_SPELL_FIND_MINERALS = "Find Minerals";
TITAN_TRACKER_SPELL_FIND_TREASURE = "Find Treasure";

-- Standard creature tracking
TITAN_TRACKER_SPELL_TRACK_BEASTS     = "Track Beasts";
TITAN_TRACKER_SPELL_TRACK_HUMANOIDS  = "Track Humanoids";
TITAN_TRACKER_SPELL_TRACK_HIDDEN     = "Track Hidden";
TITAN_TRACKER_SPELL_TRACK_ELEMENTALS = "Track Elementals";
TITAN_TRACKER_SPELL_TRACK_UNDEAD     = "Track Undead";
TITAN_TRACKER_SPELL_TRACK_DEMONS     = "Track Demons";
TITAN_TRACKER_SPELL_TRACK_GIANTS     = "Track Giants";
TITAN_TRACKER_SPELL_TRACK_DRAGONKIN  = "Track Dragonkin";

-- Class specific tracking
TITAN_TRACKER_SPELL_SENSE_UNDEAD = "Sense Undead";
TITAN_TRACKER_SPELL_SENSE_DEMONS = "Sense Demons";

-- Icon textures
TITAN_TRACKER_ICON_FIND_HERBS = "Interface\\Icons\\INV_Misc_Flower_02";
TITAN_TRACKER_ICON_FIND_MINERALS = "Interface\\Icons\\Spell_Nature_Earthquake";
TITAN_TRACKER_ICON_FIND_TREASURE = "Interface\\Icons\\Racial_Dwarf_FindTreasure";
TITAN_TRACKER_ICON_TRACK_BEASTS = "Interface\\Icons\\Ability_Tracking";
TITAN_TRACKER_ICON_TRACK_HUMANOIDS = "Interface\\Icons\\Spell_Holy_PrayerOfHealing";
TITAN_TRACKER_ICON_TRACK_HIDDEN = "Interface\\Icons\\Ability_Stealth"
TITAN_TRACKER_ICON_TRACK_ELEMENTALS = "Interface\\Icons\\Spell_Frost_SummonWaterElemental";
TITAN_TRACKER_ICON_TRACK_UNDEAD = "Interface\\Icons\\Spell_Shadow_DarkSummoning";
TITAN_TRACKER_ICON_TRACK_DEMONS = "Interface\\Icons\\Spell_Shadow_SummonFelHunter";
TITAN_TRACKER_ICON_TRACK_GIANTS = "Interface\\Icons\\Ability_Racial_Avatar";
TITAN_TRACKER_ICON_TRACK_DRAGONKIN = "Interface\\Icons\\INV_Misc_Head_Dragon_01";
TITAN_TRACKER_ICON_SENSE_UNDEAD = "Interface\\Icons\\Spell_Holy_SenseUndead";
TITAN_TRACKER_ICON_SENSE_DEMONS = "Interface\\Icons\\Spell_Shadow_Metamorphosis";

TITAN_TRACKER_NOTHING_TEXT = "Nothing to track.";
TITAN_TRACKER_STOP_TRACKING = "Track Nothing";

TITAN_TRACKER_HIDE_MINIMAP = "Hide Minimap Tracking Icon";

-- German localization
-- by Kaesemuffin
if ( GetLocale() == "deDE" ) then

	TITAN_TRACKER_MENU_TEXT = "Tracker";
	TITAN_TRACKER_BUTTON_LABEL = "Tracker";

	TITAN_TRACKER_ABOUT_TEXT = "\195\188ber";
	TITAN_TRACKER_TOOLTIP_TEXT = "Hint: Right-click to toggle Tracking abilities.";
	TITAN_TRACKER_TOOLTIP_TEXT = "Hinweis: Rechts-klick zu ausw\195\164hlen der Tracking F\195\164higkeitem.";
    TITAN_TRACKER_NOTHING_TEXT = "Nichts zu \195\188berwachen.";

	TITAN_TRACKER_STOP_TRACKING = "Nichts \195\188berwachen";	

	-- Header Types
	TITAN_TRACKER_SPELL_TYPE_FIND		= "Finden F\195\164higkeit";
	TITAN_TRACKER_SPELL_TYPE_TRACK		= "Aufsp\195\188ren F\195\164higkeit";
	TITAN_TRACKER_SPELL_TYPE_SENSE		= "Sp\195\188ren F\195\164higkeit";

	-- Object tracking
	TITAN_TRACKER_SPELL_FIND_HERBS		= "Kr\195\164utersuche";
	TITAN_TRACKER_SPELL_FIND_MINERALS	= "Mineraliensuche";
	TITAN_TRACKER_SPELL_FIND_TREASURE	= "Schatzsuche";

	-- Standard creature tracking
	TITAN_TRACKER_SPELL_TRACK_BEASTS	= "Wildtiere aufsp\195\188ren";
	TITAN_TRACKER_SPELL_TRACK_HUMANOIDS	= "Humanoide aufsp\195\188ren";
	TITAN_TRACKER_SPELL_TRACK_HIDDEN	= "Verborgenes aufsp\195\188ren";
	TITAN_TRACKER_SPELL_TRACK_ELEMENTALS	= "Elementare aufsp\195\188ren";
	TITAN_TRACKER_SPELL_TRACK_UNDEAD	= "Untote aufsp\195\188ren";
	TITAN_TRACKER_SPELL_TRACK_DEMONS	= "D\195\164monen aufsp\195\188ren";
	TITAN_TRACKER_SPELL_TRACK_GIANTS	= "Riesen aufsp\195\188ren";
	TITAN_TRACKER_SPELL_TRACK_DRAGONKIN	= "Drachkin aufsp\195\188ren";

	-- Class specific tracking
	TITAN_TRACKER_SPELL_SENSE_UNDEAD	= "Untote sp\195\188ren";
	TITAN_TRACKER_SPELL_SENSE_DEMONS	= "D\195\164monen sp\195\188ren";

end

if ( GetLocale() == "frFR" ) then

	-- need translation
	TITAN_TRACKER_MENU_TEXT = "Tracker";
	TITAN_TRACKER_BUTTON_LABEL = "Tracker";
	
	TITAN_TRACKER_ABOUT_TEXT = "About";
	
	TITAN_TRACKER_TOOLTIP_TEXT = "Hint: Right-click to toggle Tracking abilities.";
	TITAN_TRACKER_NOTHING_TEXT = "Nothing to track.";
	TITAN_TRACKER_STOP_TRACKING = "Track Nothing";
	
	TITAN_TRACKER_HIDE_MINIMAP = "Hide Minimap Tracking Icon";
	-- end need translation

	TITAN_TRACKER_SPELL_FIND_HERBS    = "D\195\169couverte d'herbes";
	TITAN_TRACKER_SPELL_FIND_MINERALS = "D\195\169couverte de gisements";
	TITAN_TRACKER_SPELL_FIND_TREASURE = "D\195\169couverte de tr\195\169sors";

	TITAN_TRACKER_SPELL_TRACK_BEASTS     = "Pistage des B\195\170tes";
	TITAN_TRACKER_SPELL_TRACK_HUMANOIDS  = "Pistage des humano\195\175des";
	TITAN_TRACKER_SPELL_TRACK_HIDDEN     = "Pistage des Camoufl\195\169s";
	TITAN_TRACKER_SPELL_TRACK_ELEMENTALS = "Pistage des Elementaires";
	TITAN_TRACKER_SPELL_TRACK_UNDEAD     = "Pistage des Morts-vivants";
	TITAN_TRACKER_SPELL_TRACK_DEMONS     = "Pistage des D\195\169mons";
	TITAN_TRACKER_SPELL_TRACK_GIANTS     = "Pistage des G\195\169ants";
	TITAN_TRACKER_SPELL_TRACK_DRAGONKIN  = "Pistage des Draconiens";

	TITAN_TRACKER_SPELL_SENSE_UNDEAD = "Sentir les Morts-vivants";
	TITAN_TRACKER_SPELL_SENSE_DEMONS = "Sentir les D\195\169mons";

end

if ( GetLocale() == "koKR" ) then

	TITAN_TRACKER_MENU_TEXT = "Tracker";
	TITAN_TRACKER_BUTTON_LABEL = "Tracker";
	TITAN_TRACKER_TOOLTIP = "Tracker";

	TITAN_TRACKER_TOOLTIP_TEXT = "Hint: Right-click to toggle Tracking abilities.";

	TITAN_TRACKER_ABOUT_TEXT = "About";
	
	-- Header Types
	TITAN_TRACKER_SPELL_TYPE_FIND  = "Locating Abilities";
	TITAN_TRACKER_SPELL_TYPE_TRACK = "Tracking Abilities";
	TITAN_TRACKER_SPELL_TYPE_SENSE = "Sensing Abilities";

	-- Object tracking
	TITAN_TRACKER_SPELL_FIND_HERBS    = "Find Herbs";
	TITAN_TRACKER_SPELL_FIND_MINERALS = "Find Minerals";
	TITAN_TRACKER_SPELL_FIND_TREASURE = "Find Treasure";

	-- Standard creature tracking
	TITAN_TRACKER_SPELL_TRACK_BEASTS     = "Track Beasts";
	TITAN_TRACKER_SPELL_TRACK_HUMANOIDS  = "Track Humanoids";
	TITAN_TRACKER_SPELL_TRACK_HIDDEN     = "Track Hidden";
	TITAN_TRACKER_SPELL_TRACK_ELEMENTALS = "Track Elementals";
	TITAN_TRACKER_SPELL_TRACK_UNDEAD     = "Track Undead";
	TITAN_TRACKER_SPELL_TRACK_DEMONS     = "Track Demons";
	TITAN_TRACKER_SPELL_TRACK_GIANTS     = "Track Giants";
	TITAN_TRACKER_SPELL_TRACK_DRAGONKIN  = "Track Dragonkin";

	-- Class specific tracking
	TITAN_TRACKER_SPELL_SENSE_UNDEAD = "Sense Undead";
	TITAN_TRACKER_SPELL_SENSE_DEMONS = "Sense Demons";
	
	TITAN_TRACKER_NOTHING_TEXT = "Nothing to track.";
	TITAN_TRACKER_STOP_TRACKING = "Track Nothing";

	TITAN_TRACKER_HIDE_MINIMAP = "Hide Minimap Tracking Icon";
end