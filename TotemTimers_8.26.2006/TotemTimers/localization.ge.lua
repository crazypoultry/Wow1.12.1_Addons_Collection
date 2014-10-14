if( GetLocale() == "deDE" ) then
-- Much Thanks to Oliver Becker for These.
-- Thanks to Danemo for help with the trinket translations 2.14.2006

TT_DISEASE_CLEANSING = "der Krankheitsreinigung";
TT_EARTHBIND = "der Erdbindung";
TT_FIRE_NOVA = "der Feuernova";
TT_FIRE_RESISTANCE = "des Feuerwiderstands";
TT_FLAMETONGUE = "der Flammenzunge";
TT_FROST_RESISTANCE = "des Frostwiderstands";
TT_GRACE_OF_AIR = "der luftgleichen Anmut";
TT_GROUNDING = "der Erdung";
TT_HEALING_STREAM = "des heilenden Flusses";
TT_MAGMA = "der gl\195\188henden Magma";
TT_ENAMORED_WATER_SPIRIT = "Entz\195\188ckter";
TT_ANCIENT_MANA_SPRING = "Uraltes Totem der Manaquelle";
TT_MANA_SPRING = "der Manaquelle";
TT_MANA_TIDE = "der Manaflut";
TT_NATURE_RESISTANCE = "des Naturwiderstands";
TT_POISON_CLEANSING = "der Giftreinigung";
TT_SEARING = "der Verbrennung";
TT_SENTRY = "des Wachens";
TT_STONECLAW = "der Steinklaue";
TT_STONESKIN = "der Steinhaut";
TT_STRENGTH_OF_EARTH = "der Erdst\195\164rke";
TT_TREMOR = "des Erdsto\195\159es";
TT_TRANQUIL_AIR = "der beruhigenden Winde";
TT_WINDFURY = "des Windzorns";
TT_WINDWALL = "der Windmauer";

TT_EARTH = "Erd";
TT_AIR = "Luft";
TT_WATER = "Wasser";
TT_FIRE = "Feuer";

TT_SHAMAN = "Schamane";

-- Here we do an aliasing.  Anytime we parse a chat message we see if we 
-- need to update the alias.  Simple search and replace.
TT_ALIAS = {};
TT_ALIAS[1] = { string = TT_NATURE_RESISTANCE, alias = "des Naturwiderstandes" };

TT_VERTICAL = "vertikal";
TT_HORIZONTAL = "horizontal";
TT_BOX = "box";
TT_LEFT = "links";
TT_RIGHT = "rechts";
TT_TOP = "oben";
TT_BOTTOM = "unten";
TT_ON = "an";
TT_OFF = "aus";
TT_BUFF = "buff";
TT_FIXED = "fixed";
TT_ELEMENT = "elemente";
TT_STICKY = "sticky";
TT_BLIZZARD = "blizzard";
TT_CT = "ct";
TT_SHOW = "zeigen";
TT_HIDE = "verstecken";
TT_LOCK = "sperren";
TT_UNLOCK = "entsperren";
TT_ARRANGE = "anordnung";
TT_ALIGN = "ausrichtung";
TT_WARN = "warnung";
TT_NOTIFY = "nachricht";
TT_STYLE = "stil";
TT_TIME = "zeit";
TT_ORDER = "reihenfolge";

TT_SLASH = {};
TT_SLASH[1] = "TotemTimers Slash Kommandos:";
TT_SLASH[2] = "/tt "..TT_SHOW.." - Zeige TotemTimers (enable)";
TT_SLASH[3] = "/tt "..TT_HIDE.." - Verstecke TotemTimers (disable)";
TT_SLASH[4] = "/tt "..TT_LOCK.." - Sperre TotemTimers Position";
TT_SLASH[5] = "/tt "..TT_UNLOCK.." - Entsperre TotemTimers Position";
TT_SLASH[TT_ARRANGE] = "/tt "..TT_ARRANGE.." ["..TT_HORIZONTAL.."|"..TT_VERTICAL.."|"..TT_BOX.."] - Icon Anordnung";
TT_SLASH[TT_ALIGN]   = "/tt "..TT_ALIGN.." ["..TT_LEFT.."|"..TT_RIGHT.."|"..TT_TOP.."|"..TT_BOTTOM.."] - Icon Ausrichtung";
TT_SLASH[TT_WARN]    = "/tt "..TT_WARN.." ["..TT_ON.."|"..TT_OFF.."] - Warnungen bei Verschwinden an/aus";
TT_SLASH[TT_NOTIFY]  = "/tt "..TT_NOTIFY.." ["..TT_ON.."|"..TT_OFF.."] - Nachrichten bei Zerst\195\182rung an/aus";
TT_SLASH[TT_STYLE]   = "/tt "..TT_STYLE.." ["..TT_BUFF.."|"..TT_FIXED.."|"..TT_ELEMENT.."|"..TT_STICKY.."] - Setze TotemTimers Stil";
TT_SLASH[TT_TIME]    = "/tt "..TT_TIME.." ["..TT_BLIZZARD.."|"..TT_CT.."] - Setze Zeitformat";
TT_SLASH[TT_ORDER]   = "/tt "..TT_ORDER.." [element1] [element2] [element3] [element4] - Setze Totem Reihenfolge";

TT_ERROR = "TotemTimers Fehler!";
TT_RESET = "TotemTimers Reset!";

TT_USAGE = "Benutzung:";

TT_VISIBLE = "[TT] sichtbar";
TT_HIDDEN = "[TT] versteckt";

TT_UNLOCKED = "[TT] entsperrt";
TT_LOCKED = "[TT] gesperrt";

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
TT_SETTING[TT_ARRANGE] = "[TT] Ausrichtung: %s";
TT_SETTING[TT_ALIGN] = "[TT] Anordnung: %s";
TT_SETTING[TT_WARN] = "[TT] Warnungen: %s";
TT_SETTING[TT_NOTIFY] = "[TT] Nachrichten: %s";
TT_SETTING[TT_STYLE] =  "[TT] Stil: %s";
TT_SETTING[TT_TIME] = "[TT] Zeitformat: %s";
TT_SETTING[TT_ORDER] = "[TT] Totem Order: %s";

TT_DESTROYED = "ist zerst\195\182rt!";
TT_WARNING = "verschwindet bald!";

TT_LOADED = "TotemTimers Addon geladen";

-- Important Stuff
TT_CAST_REGEX = "Ihr wirkt Totem (.+)%.";
TT_DEATH_REGEX = "Totem (.-) ?(%u*)%.? ist zerst\195\182rt%.";
TT_DAMAGE_REGEX = { 
	".+ trifft Totem (.-) ?(%u*)%.? kritisch f\195\188r (%d+).",
	".+ trifft Totem (.-) ?(%u*)%.? f\195\188r (%d+)."
};

TT_TOTEM_REGEX = "Totem (.+)";
TT_TRINKET_REGEX ="(.+) Wassergeist";
TT_RANK_REGEX = "Rang (%d+)";
TT_ELEMENT_REGEX = "Werkzeuge: (.+)%totem";

TT_NAME_STRING = "Totem %s";
TT_NAME_LEVEL_STRING = "Totem %s %s";
end
