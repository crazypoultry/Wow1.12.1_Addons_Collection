
MM_MINIMAP_TITLE = "Minimap";

-- Tracker stuff
MM_TRACKER_TITLE = "Tracker";
MM_NO_TRACKER = "None";

-- String.find patterns
-- Any spell that matchs one of these patterns will be added to the tracker menu
-- Capturing parentheses define what will be shown in menu
MM_TRACKER_PATTERNS = {
	-- Hunter trackers
	"^Track (.+)$",
	-- Mining and herb trackers
	"^Find (.+)$"
};

-- Gatherer options
MM_GATHERER_TITLE = "Gatherer";
MM_GATHERER_ENABLED = "Show minimap icons"
MM_GATHERER_THEME = "Icon theme";
MM_GATHERER_DIST = "Lookup distance";
MM_GATHERER_NUM = "Number of icons";
MM_GATHERER_FDIST = "Fade distance";
MM_GATHERER_FPERC = "Fade percentage";
MM_GATHERER_IDIST = "Iconic distance";

MM_GATHERER_HERBS = "Herbs";
MM_GATHERER_MINING = "Mining";
MM_GATHERER_TREASURE = "Treasures";

MM_GATHERER_ON = "show";
MM_GATHERER_OFF = "hide";
MM_GATHERER_AUTO = "auto";


-- Atlas options
MM_ATLAS_SHOW_BUTTON = "Show Atlas button";

-- FastQuest options
MM_FASTQUEST_SHOW_BUTTON = "Show FastQuest button";

-- Localization starts here

if(GetLocale() == "frFR") then
	-- French

	MM_MINIMAP_TITLE = "Minicarte";

	MM_TRACKER_TITLE = "Radar";
	MM_NO_TRACKER = "Aucun";

	MM_TRACKER_PATTERNS = {
		"^Pistage des (.+)$",
		"^Découverte d[e']%s*(.+)$"
	};

	MM_GATHERER_TITLE = "Gatherer";
	MM_GATHERER_ENABLED = "Afficher les icônes"
	MM_GATHERER_THEME = "Thème d'icônes";
	MM_GATHERER_DIST = "Distance de recherche";
	MM_GATHERER_NUM = "Nombre d'icônes";
	MM_GATHERER_FDIST = "Distance de transparence";
	MM_GATHERER_FPERC = "Tranparence maximale";
	MM_GATHERER_IDIST = "Distance d'icônification";

	MM_GATHERER_HERBS = "Herbes";
	MM_GATHERER_MINING = "Gisements";
	MM_GATHERER_TREASURE = "Trésors";

	MM_GATHERER_ON = "afficher";
	MM_GATHERER_OFF = "cacher";
	MM_GATHERER_AUTO = "auto";


	MM_ATLAS_SHOW_BUTTON = "Bouton d'Atlas";

	MM_FASTQUEST_SHOW_BUTTON = "Bouton de FastQuest";

elseif(GetLocale() == "deDE") then
	-- German... please help

end