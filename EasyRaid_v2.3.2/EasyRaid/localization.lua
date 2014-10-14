-------------------------------------------------------------------------------
-- the constants for the mod
-------------------------------------------------------------------------------
ER_VERSION = "2.3.2";
ER_VERSION_NUMBER = 020302;
ER_VERSION_STRING = 'EasyRaid '..ER_VERSION;

ER_FORCED_ENGLISH = false; -- I use this to take screenshot with my French WoW client

ER_MYADDONS_DETAILS = {
	name = 'EasyRaid',
	version = ER_VERSION,
	releaseDate = 'January 13, 2006',
	author = "Soin (Vol'jin)",
	email = 'soin@3base.com',
	website = 'http://www.3base.com/easyraid/',
	category = MYADDONS_CATEGORY_RAID
};

ER_INTERFACE_ICON_PATH = "Interface\\Icons\\";
ER_MIN_BUFFS = 2;
ER_MAX_BUFFS = 8;

ER_RAID_PULLOUT_FRAME_OFFSET_X = 6;

ER_CONTAINER_FRAME_ALPHA = 0.3;

ER_MAX_MAIN_TANKS = 10;
ER_MAX_TARGETS = 10;
ER_TARGET_BUTTON_HEIGHT = 33;

-------------------------------------------------------------------------------
-- English localization (Default)
-------------------------------------------------------------------------------
ER_CLASSES_NAME = {
	["WARRIOR"] = "Warrior",
	["MAGE"] = "Mage",
	["WARLOCK"] = "Warlock",
	["ROGUE"] = "Rogue",
	["HUNTER"] = "Hunter",
	["PRIEST"] = "Priest",
	["DRUID"] = "Druid",
	["PALADIN"] = "Paladin",
	["SHAMAN"] = "Shaman"
}

BINDING_HEADER_EASYRAID = "EasyRaid";
BINDING_NAME_ER_OPTIONS = "Show Options";
BINDING_NAME_ER_BUFF_TOGGLE = "Toggle Buffs/Debuffs";
BINDING_NAME_ER_RAID_TOGGLE = "Show/Hide Raid";

ER_OPTIONS = "Options";
ER_RAID_TAB = "Raid";
ER_YOUR_GROUP = "Always show your group";
ER_HIDE_PLAYERS_ALREADY_DISPLAYED = "Hide already displayed players";
ER_HIDE_PLAYER = "Hide your own player";
ER_SCALE = "Scale:";
ER_ALIGNMENT = "Alignment";
ER_SMART = "Smart";
ER_TOP_LEFT = "Top Left";
ER_TOP_RIGHT = "Top Right";
ER_BOTTOM_LEFT = "Bottom Left";
ER_BOTTOM_RIGHT = "Bottom Right";

ER_BUFFS_TAB = "Buffs";
ER_SHOW_BUFFS = "Show buffs";
ER_SHOW_CASTABLE_BUFFS = "Castable only";
ER_SHOW_ALL_GROUPS = "Switch raid display to show all groups";
ER_MAX_DISPLAYABLE_BUFFS = "Maximum:";
ER_SHOW_DEBUFFS = "Show debuffs";
ER_SHOW_DISPELLABLE_DEBUFFS = "Dispellable only";
ER_SHOW_DEBUFFS_IN_COMBAT = "Show debuffs when you enter in combat";
ER_MAX_DISPLAYABLE_DEBUFFS = "Maximum:";
ER_KEY_BINDING_ADVICE_TO_SWITCH_BUFF_MODE = "Advice: Add a key binding to easily switch from buff to debuff mode.";

ER_MAIN_TANKS = "Main Tanks";
ER_MAIN_TANKS_TAB = "MTs";
ER_SHOW_MAIN_TANKS = "Show main tanks";
ER_ATTACH_MAIN_TANKS_TO = "Attached to:";
ER_RAID_ATTACHMENT = "Raid";
ER_TARGETS_ATTACHMENT = "Targets";
ER_MAIN_TANKS_MEMBER_ADVICE = "You must be the raid leader or officer to change the main tanks.";

ER_TARGETS = "Targets";
ER_TARGETS_TAB = "Targets";
ER_SHOW_TARGETS = "Show targets";
ER_SHOW_HOSTILE_TARGETS_ONLY = "Show hostile targets only";
ER_HIDE_DUPLICATED_TARGETS = "Hide duplicated targets";
ER_AUTOMATICALLY_SET_TARGETS_ICONS = "Automatically set targets icons";

ER_MISC_TAB = "Misc.";
ER_SHOW_TITLE_OF_THE_FRAMES = "Show title of the frames";
ER_HIGHLIGHT_ATTACKED_PLAYER = "Highlight attacked players";
ER_SOUNDS_ON_AGGRO = "Sounds when aggro switch to you";
ER_USE_ASSIST = "Double-Click to assist";
ER_HIGHLIGHT_CURRENT_TARGET = "Highlight the current target";
ER_CHANNEL = "Channel";
ER_JOIN_CHANNEL = "Join";
ER_BROADCAST_CHANNEL = "Broadcast";

-------------------------------------------------------------------------------
-- French localization
-------------------------------------------------------------------------------
if ( GetLocale() == "frFR" and not ER_FORCED_ENGLISH ) then
	ER_CLASSES_NAME = {
		["WARRIOR"] = "Guerrier",
		["MAGE"] = "Mage",
		["WARLOCK"] = "D\195\169moniste",
		["ROGUE"] = "Voleur",
		["HUNTER"] = "Chasseur",
		["PRIEST"] = "Pr\195\170tre",
		["DRUID"] = "Druide",
		["PALADIN"] = "Paladin",
		["SHAMAN"] = "Chaman"
	}

	BINDING_HEADER_EASYRAID = "EasyRaid";
	BINDING_NAME_ER_OPTIONS = "Afficher les options";
	BINDING_NAME_ER_BUFF_TOGGLE = "Alterner buffs et debuffs";
	BINDING_NAME_ER_RAID_TOGGLE = "Afficher/masquer le raid";

	ER_OPTIONS = "Options";
	ER_RAID_TAB = "Raid";	
	ER_YOUR_GROUP = "Toujours afficher votre groupe";
	ER_HIDE_PLAYERS_ALREADY_DISPLAYED = "Masquer les joueurs d\195\169j\195\160 affich\195\169s";
	ER_HIDE_PLAYER = "Masquer votre propre joueur";
	ER_SCALE = "Echelle :";
	ER_ALIGNMENT = "Alignement";
	ER_SMART = "Intelligent";
	ER_TOP_LEFT = "Haut-gauche";
	ER_TOP_RIGHT = "Haut-droite";
	ER_BOTTOM_LEFT = "Bas-gauche";
	ER_BOTTOM_RIGHT = "Bas-droite";

	ER_BUFFS_TAB = "Buffs";
	ER_SHOW_BUFFS = "Afficher les am\195\169liorations";
	ER_SHOW_CASTABLE_BUFFS = "Lan\195\167ables uniquement";
	ER_SHOW_ALL_GROUPS = "Changer l'affichage du raid pour montrer\ntous les groupes";
	ER_MAX_DISPLAYABLE_BUFFS = "Maximum :";
	ER_SHOW_DEBUFFS = "Afficher les affaiblissements";
	ER_SHOW_DISPELLABLE_DEBUFFS = "Dissipables uniquement";
	ER_SHOW_DEBUFFS_IN_COMBAT = "Afficher les affaiblissements quand vous\nentrez en combat";
	ER_MAX_DISPLAYABLE_DEBUFFS = "Maximum :";
	ER_KEY_BINDING_ADVICE_TO_SWITCH_BUFF_MODE = "Conseil : ajouter un raccourci clavier pour basculer facilement entre l'affichage buff et debuff.";

	ER_MAIN_TANKS = "Main Tanks";
	ER_MAIN_TANKS_TAB = "MTs";
	ER_SHOW_MAIN_TANKS = "Afficher les tanks principaux (MTs)";
	ER_ATTACH_MAIN_TANKS_TO = "Attach\195\169 au :";
	ER_RAID_ATTACHMENT = "Raid";
	ER_TARGETS_ATTACHMENT = "Cibles";
	ER_MAIN_TANKS_MEMBER_ADVICE = "Vous devez \195\170tre chef du raid ou officier pour changer les tanks principaux.";

	ER_TARGETS = "Cibles";
	ER_TARGETS_TAB = "Cibles";
	ER_SHOW_TARGETS = "Afficher les cibles (MT Targets)";
	ER_SHOW_HOSTILE_TARGETS_ONLY = "Montrer seulement les cibles ennemies";
	ER_HIDE_DUPLICATED_TARGETS = "Masquer les cibles identiques";
	ER_AUTOMATICALLY_SET_TARGETS_ICONS = "Ajout d'ic\195\180nes aux cibles automatique";
	
	ER_MISC_TAB = "Divers";
	ER_SHOW_TITLE_OF_THE_FRAMES = "Afficher le titre des fen\195\170tres";
	ER_HIGHLIGHT_ATTACKED_PLAYER = "Montrer les joeurs attaqu\195\169s";
	ER_SOUNDS_ON_AGGRO = "Alerter quand vous avez l'aggro";
	ER_USE_ASSIST = "Double-cliquer pour assister";
	ER_HIGHLIGHT_CURRENT_TARGET = "Mettre la cible courante en surbrillance";
	ER_CHANNEL = "Canal";
	ER_JOIN_CHANNEL = "Rejoindre";
	ER_BROADCAST_CHANNEL = "Diffuser";

-------------------------------------------------------------------------------
-- German localization
-------------------------------------------------------------------------------
elseif ( GetLocale() == "deDE" and not ER_FORCED_ENGLISH ) then

-- To do...

end

-------------------------------------------------------------------------------
-- Forced English
-- I use this to take screenshot with my French WoW client
-- *** DO NOT TRANSLATE ***
-------------------------------------------------------------------------------
if ( ER_FORCED_ENGLISH ) then
	GROUP = "Group";
	DEFAULTS = "Defaults";
	FRIENDS = "Friends";
	FriendsFrameTab1:SetText(FRIENDS);
	WHO = "Who";
	FriendsFrameTab2:SetText(WHO);
	GUILD = "Guild";
	FriendsFrameTab3:SetText(GUILD);
	ADD_RAID_MEMBER = "Add Member";
	EMPTY = "Emtpy";
end