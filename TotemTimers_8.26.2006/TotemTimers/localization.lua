
TT_DISEASE_CLEANSING = "Disease Cleansing";
TT_EARTHBIND = "Earthbind";
TT_FIRE_NOVA = "Fire Nova";
TT_FIRE_RESISTANCE = "Fire Resistance";
TT_FROST_RESISTANCE = "Frost Resistance";
TT_FLAMETONGUE = "Flametongue";
TT_GRACE_OF_AIR = "Grace of Air";
TT_GROUNDING = "Grounding";
TT_HEALING_STREAM = "Healing Stream";
TT_MAGMA = "Magma";
TT_ENAMORED_WATER_SPIRIT = "Enamored Water";
--TT_ENAMORED_WATER_SPIRIT = "Crescent";
TT_ANCIENT_MANA_SPRING = "Ancient Mana Spring";
TT_MANA_SPRING = "Mana Spring";
TT_MANA_TIDE = "Mana Tide";
TT_NATURE_RESISTANCE = "Nature Resistance";
TT_POISON_CLEANSING = "Poison Cleansing";
TT_SEARING = "Searing";
TT_SENTRY = "Sentry";
TT_STONECLAW = "Stoneclaw";
TT_STONESKIN = "Stoneskin";
TT_STRENGTH_OF_EARTH = "Strength of Earth";
TT_TREMOR = "Tremor";
TT_TRANQUIL_AIR = "Tranquil Air";
TT_WINDFURY = "Windfury";
TT_WINDWALL = "Windwall";

TT_EARTH = "Earth";
TT_AIR = "Air";
TT_WATER = "Water";
TT_FIRE = "Fire";

TT_SHAMAN = "Shaman";

TT_VERTICAL = "vertical";
TT_HORIZONTAL = "horizontal";
TT_BOX = "box";
TT_LEFT = "left";
TT_RIGHT = "right";
TT_TOP = "top";
TT_BOTTOM = "bottom";
TT_ON = "on";
TT_OFF = "off";
TT_BUFF = "buff";
TT_FIXED = "fixed";
TT_ELEMENT = "element";
TT_STICKY = "sticky";
TT_BLIZZARD = "blizzard";
TT_CT = "ct";
TT_SHOW = "show";
TT_HIDE = "hide";
TT_LOCK = "lock";
TT_UNLOCK = "unlock";
TT_ARRANGE = "arrange";
TT_ALIGN = "align";
TT_WARN = "warn";
TT_NOTIFY = "notify";
TT_STYLE = "style";
TT_TIME = "time";
TT_ORDER = "order";

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

TT_PLAYERDEATH = "Player Death - TotemTimers reset";

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

-- Important Stuff
TT_CAST_REGEX = "You cast (.+) Totem%.";
TT_DEATH_REGEX = "(.+) Totem ?(%a*) is destroyed%.";
TT_DAMAGE_REGEX = { 
	".+ [crh]+its (.+) Totem ?(%a*) for (%d+).*"
};

TT_TOTEM_REGEX = "(.+) Totem";
--TT_TRINKET_REGEX = "(.+) Staff"
TT_TRINKET_REGEX = "(.+) Spirit";
TT_RANK_REGEX = "Rank (%d+)";
TT_ELEMENT_REGEX = "Tools: (.+) Totem";

TT_NAME_STRING = "%s Totem";
TT_NAME_LEVEL_STRING = "%s Totem %d";
