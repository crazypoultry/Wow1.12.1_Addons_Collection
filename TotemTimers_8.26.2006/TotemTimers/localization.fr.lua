if(GetLocale() == "frFR") then
-- Thanks Tenebrok for the fixes on this 2.9.2006

TT_DISEASE_CLEANSING = "de Purification des maladies";
TT_EARTHBIND = "de lien terrestre";
TT_FIRE_NOVA = "Nova de feu";
TT_FIRE_RESISTANCE = "de r\195\169sistance au Feu";
TT_FROST_RESISTANCE = "de r\195\169sistance au Givre";
TT_FLAMETONGUE = "Langue de feu";
TT_GRACE_OF_AIR = "de Gr\195\162ce a\195\169rienne";
TT_GROUNDING = "de Gl\195\168be";
TT_HEALING_STREAM = "gu\195\169risseur";
TT_MAGMA = "de Magma";
TT_ENAMORED_WATER_SPIRIT = "de l\039eau amoureux";
TT_ANCIENT_MANA_SPRING = "Ressort Antique De Mana";
TT_MANA_SPRING = "Fontaine de mana";
TT_MANA_TIDE = "de Vague de mana";
TT_NATURE_RESISTANCE = "de r\195\169sistance \195\160 la Nature";
TT_POISON_CLEANSING = "de Purification du poison";
TT_SEARING = "incendiaire";
TT_SENTRY = "Sentinelle";
TT_STONECLAW = "de Griffes de pierre";
TT_STONESKIN = "de Peau de pierre";
TT_STRENGTH_OF_EARTH = "de Force de la Terre";
TT_TREMOR = "de S\195\169isme";
TT_TRANQUIL_AIR = "de Tranquillit\195\169 de l\039air";
TT_WINDFURY = "Furie-des-vents";
TT_WINDWALL = "de Mur des vents";

TT_EARTH = "terre"; 
TT_AIR = "air"; 
TT_WATER = "eau"; 
TT_FIRE = "feu"; 

TT_SHAMAN = "Chaman"


TT_SLASH = {};
TT_SLASH[1] = "TotemTimers Slash Commands:";
TT_SLASH[2] = "/tt "..TT_SHOW.." - Show TotemTimers (enable)";
TT_SLASH[3] = "/tt "..TT_HIDE.." - Hide TotemTimers (disable)";
TT_SLASH[4] = "/tt "..TT_LOCK.." - Lock TotemTimers Position";
TT_SLASH[5] = "/tt "..TT_UNLOCK.." - Unlock TotemTimers Position";
TT_SLASH[TT_ARRANGE] = "/tt "..TT_ARRANGE.." ["..TT_HORIZONTAL.."|"..TT_VERTICAL.."|"..TT_BOX.."] - Icon Arrangement";
TT_SLASH[TT_ALIGN]   = "/tt "..TT_ALIGN.." ["..TT_LEFT.."|"..TT_RIGHT.."|"..TT_TOP.."|"..TT_BOTTOM.."] - Icon Alignment";
TT_SLASH[TT_WARN]    = "/tt "..TT_WARN.." ["..TT_ON.."|"..TT_OFF.."] - Turn Expiration Warnings On/Off";
TT_SLASH[TT_NOTIFY]  = "/tt "..TT_NOTIFY.." ["..TT_ON.."|"..TT_OFF.."] - Turn Notifications On/Off";
TT_SLASH[TT_STYLE]   = "/tt "..TT_STYLE.." ["..TT_BUFF.."|"..TT_FIXED.."|"..TT_ELEMENT.."|"..TT_STICKY.."] - Set TotemTimers Style";
TT_SLASH[TT_TIME]    = "/tt "..TT_TIME.." ["..TT_BLIZZARD.."|"..TT_CT.."] - Set Time Format";
TT_SLASH[TT_ORDER]   = "/tt "..TT_ORDER.." [element1] [element2] [element3] [element4] - Set Totem Ordering";

TT_ERROR = "TotemTimers Error!";
TT_RESET = "TotemTimers Reset!";

TT_USAGE = "Usage:";

TT_VISIBLE = "[TT] Visible";
TT_HIDDEN = "[TT] Hidden";

TT_UNLOCKED = "[TT] Unlocked";
TT_LOCKED = "[TT] Locked";

-- define our possible options for each setting
TT_OPTION = {};
TT_OPTION[TT_ARRANGE] = {};
TT_OPTION[TT_ARRANGE][TT_VERTICAL] = TT_VERTICAL;
TT_OPTION[TT_ARRANGE]["vert"] = TT_VERTICAL;
TT_OPTION[TT_ARRANGE]["v"] = TT_VERTICAL;
TT_OPTION[TT_ARRANGE][TT_HORIZONTAL] = TT_HORIZONTAL;
TT_OPTION[TT_ARRANGE]["hor"] = TT_HORIZONTAL;
TT_OPTION[TT_ARRANGE]["h"] = TT_HORIZONTAL;
TT_OPTION[TT_ARRANGE][TT_BOX] = TT_BOX;
TT_OPTION[TT_ALIGN] = {};
TT_OPTION[TT_ALIGN][TT_LEFT] = TT_LEFT;
TT_OPTION[TT_ALIGN][TT_BOTTOM] = TT_LEFT;
TT_OPTION[TT_ALIGN][TT_RIGHT] = TT_RIGHT;
TT_OPTION[TT_ALIGN][TT_TOP] = TT_RIGHT;
TT_OPTION[TT_WARN] = {};
TT_OPTION[TT_WARN][TT_ON] = TT_ON;
TT_OPTION[TT_WARN][TT_OFF] = TT_OFF;
TT_OPTION[TT_NOTIFY] = {};
TT_OPTION[TT_NOTIFY][TT_ON] = TT_ON;
TT_OPTION[TT_NOTIFY][TT_OFF] = TT_OFF;
TT_OPTION[TT_STYLE] = {};
TT_OPTION[TT_STYLE][TT_BUFF] = TT_BUFF;
TT_OPTION[TT_STYLE][TT_FIXED] = TT_FIXED;
TT_OPTION[TT_STYLE][TT_ELEMENT] = TT_ELEMENT;
TT_OPTION[TT_STYLE][TT_STICKY] = TT_STICKY;
TT_OPTION[TT_TIME] = {};
TT_OPTION[TT_TIME][TT_BLIZZARD] = TT_BLIZZARD;
TT_OPTION[TT_TIME][TT_CT] = TT_CT;

TT_SETTING = {};
TT_SETTING[TT_ARRANGE] = "[TT] Arrangement: %s";
TT_SETTING[TT_ALIGN] = "[TT] Alignment: %s";
TT_SETTING[TT_WARN] = "[TT] Warnings: %s";
TT_SETTING[TT_NOTIFY] = "[TT] Notifications: %s";
TT_SETTING[TT_STYLE] =  "[TT] Icon Style: %s";
TT_SETTING[TT_TIME] = "[TT] Time Format: %s";
TT_SETTING[TT_ORDER] = "[TT] Totem Order: %s";

TT_DESTROYED = "is Destroyed";
TT_WARNING = "is Expiring.";

TT_LOADED = "TotemTimers Addon Loaded";

-- These are the most important lines
TT_CAST_REGEX = "Vous lancez Totem (.+).";
TT_DEATH_REGEX = "Totem (.+) ?(%u*) a \195\169t\195\169 d\195\169truit\(e\)"; 
TT_DAMAGE_REGEX = {
	".+ touche Totem (.+) ?(%u*) et inflige (.+)  points de d195\169gats%.",
	".+ touche Totem (.+) ?(%u*) avec un coup critique et inflige (.+)  points de d195\169gats%.",
	".+ touche Totem (.+) ?(%u*) pour (.+)  points de d195\169gats%."
};

TT_TOTEM_REGEX = "Totem (.+)"; 
TT_TRINKET_REGEX ="Esprit (.+)";
TT_RANK_REGEX = "Rang (%d+)"; 
TT_ELEMENT_REGEX = "Outils\194\160: Totem d[e'][ ]?(.+)";

TT_NAME_STRING = "Totem %s";
TT_NAME_LEVEL_STRING = "Totem %s %s";


end
