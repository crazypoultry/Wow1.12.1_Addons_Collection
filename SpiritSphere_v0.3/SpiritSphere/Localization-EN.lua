if ( GetLocale() == "enUS" ) or ( GetLocale() == "enGB" ) then

BINDING_HEADER_SpiritSphere_BIND = "SpiritSphere";   
BINDING_NAME_STEED = "Ghost Wolf";
BINDING_NAME_MIGHT = "Strength of Earth Totem";
BINDING_NAME_WISDOM = "Grace of Air Totem";
BINDING_NAME_SALVATION = "Stoneskin Totem";
BINDING_NAME_LIGHT = "Windfury Totem";
BINDING_NAME_KINGS = "Tremor Totem";
BINDING_NAME_SANCTUARY = "Tranquil Air Totem";
BINDING_NAME_FREEDOM = "Mana Spring Totem";
BINDING_NAME_SACRIFICE = "Mana Tide Totem";
BINDING_NAME_SCOMMAND = "Windfury Weapon";
BINDING_NAME_SCRUSADER = "Disease Cleansing Totem";
BINDING_NAME_SJUSTICE = "Cure Poison";
BINDING_NAME_SLIGHT = "Poison Cleansing Totem";
BINDING_NAME_SRIGHTEOUSNESS = "Cure Disease";
BINDING_NAME_SWISDOM = "Far Sight";
BINDING_NAME_JUDGEMENT = "Lightning Shield";

SpiritSphere_UNIT_PALADIN = "Shaman";

SpiritSphere_SPELL_TABLE = {
	["ID"] = {},
	["Rank"] = {},
	["Name"] = {
		"Ghost Wolf",			          --1
		"Ghost Wolf",	          	    --2
		"Strength of Earth Totem",              --3
		"Grace of Air Totem",             --4
		"Stoneskin Totem",          --5
		"Windfury Totem",              --6
		"Tremor Totem",              --7
		"Tranquil Air Totem",          --8
		"Mana Spring Totem",            --9
		"Mana Tide Totem",          --10		
		"Nature Resistance Totem",      --11
		"Grounding Totem",     --12
		"Earthbind Totem",  --13
		"Fire Resistance Totem",      --14
		"Frost Resistance Totem",      --15
		"Searing Totem",  --16
		"Windfury Weapon",                --17
		"Disease Cleansing Totem",           --18
		"Cure Poison",                --19
		"Poison Cleansing Totem",                  --20
		"Cure Disease",          --21
		"Far Sight",                 --22
		"Lightning Shield",                      --23
		},
	["Mana"] = {}
};

SpiritSphere_ITEM = {
	["Kings"] = "Ankh",
	["Hearthstone"] = "Hearthstone",
	["QuirajiMount"] = "Qiraji Resonating Crystal",
};

SpiritSphere_TRANSLATION = {
	["Cooldown"] = "Cooldown",
	["Rank"] = "Rank",
};

SpiritSphere_MESSAGE = {
  ["SLASH"] = {
    --["InitOn"] = "SpiritSphere loaded. /spiritsphere or /ssphere to show options",
  },
  ["TOOLTIP"] = {
    ["Clic"] = "Sphere Stance:",
    ["RightClic"] = "Right Click: Hearthstone",
    ["NotUp"] = " Buff",
    ["Up"] = "Resistance & Offensive",
    ["Judgement"] = "Cast Lightning Shield",
  },
  ["nohearthstone"] = "You do not have any Hearthstone in your inventory.",
};

MOUNT_ITEM = {
  ["ReinsMount"] = "Reins",
  ["RamMount"] = "Ram",
  ["BridleMount"] = "Bridle",
  ["BridleMount2"] = "Bridle",
  ["BridleMount3"] = "Bridle",
  ["MechanostriderMount"] = "Mechanostrider",
  ["QuirajiMount"] = "Qiraji Resonating Crystal",
};

SpiritSphere_MENU = {
  ["Show"] = "Show",
  ["Drag"] = "Drag",
  ["Tooltips"] = "Tooltip Appearance",
  ["Blessing"] = "Totems",
  ["Seal"] = "Extra",
  ["Mount"] = "Ghostwolf",
  ["Off"] = "Off",
  ["Partial"] = "Only Mana",
  ["Total"] = "Standard",  
};

end
