if ( GetLocale() == "deDE" ) then

BINDING_HEADER_SpiritSphere_BIND = "Spirit Sphere";   
BINDING_NAME_STEED = "Geisterwolf";
BINDING_NAME_MIGHT = "Totem der Erdst\195\164rke";
BINDING_NAME_WISDOM = "Totem der luftgleichen Anmut";
BINDING_NAME_SALVATION = "Totem der Steinhaut";
BINDING_NAME_LIGHT = "Totem des Windzorns";
BINDING_NAME_KINGS = "Totem des Erdsto\195\159es";
BINDING_NAME_SANCTUARY = "Totem der beruhigenden Winde";
BINDING_NAME_FREEDOM = "Totem der Manaquelle";
BINDING_NAME_SACRIFICE = "Totem der Manaflut";
BINDING_NAME_SCOMMAND = "Waffe des Windfurors";
BINDING_NAME_SCRUSADER = "Totem der Krankheitsreinigung";
BINDING_NAME_SJUSTICE = "Vergiftung heilen";
BINDING_NAME_SLIGHT = "Totem der Giftreinigung";
BINDING_NAME_SRIGHTEOUSNESS = "Krankheit heilen";
BINDING_NAME_SWISDOM = "Fernsicht";
BINDING_NAME_JUDGEMENT = "Blitzschlagschild";

SpiritSphere_UNIT_PALADIN = "Schamane";

SpiritSphere_SPELL_TABLE = {
	["ID"] = {},
	["Rank"] = {},
	["Name"] = {
		"Geisterwolf",			   --1
		"Geisterwolf",	         --2
		"Totem der Erdst\195\164rke",                       --3
		"Totem der luftgleichen Anmut", 	--4
		"Totem der Steinhaut",	--5
		"Totem des Windzorns",                      --6
		"Totem des Erdsto\195\159es",               --7
		"Totem der beruhigenden Winde",                   --8
		"Totem der Manaquelle",                    --9
		"Totem der Manaflut",                    --10
		"Totem des Naturwiderstands",         --11
		"Totem der Erdung",      --12
		"Totem der Erdbindung",       --13
		"Totem des Feuerwiderstands",        --14
		"Totem des Frostwiderstands", --15
		"Totem der Verbrennung",     --16
		"Waffe des Windfurors",                    --17
		"Totem der Krankheitsreinigung",               --18
		"Vergiftung heilen",              --19
		"Totem der Giftreinigung",                     --20
		"Krankheit heilen",          --21
		"Fernsicht",                   --22
		"Blitzschlagschild",                           --23
		},
	["Mana"] = {}
};

SpiritSphere_ITEM = {
	["Kings"] = "Ankh",
	["Hearthstone"] = "Ruhestein",
	["QuirajiMount"] = "Qirajiresonanzkristall",
};

SpiritSphere_TRANSLATION = {
	["Cooldown"] = "Abklingzeit",
	["Rank"] = "Rang",
};

SpiritSphere_MESSAGE = {
  ["SLASH"] = {
    ["InitOn"] = "|r|cff00ff00Knorr's|r Spirit Sphere geladen. /spiritsphere oder /ssphere f\195\188r Optionen",
  },
  ["TOOLTIP"] = {
    ["Clic"] = "Sphere Stance: ",
    ["RightClic"] = "Rechtsklick: Ruhestein",
    ["NotUp"] = "Buff", --class blessings
    ["Up"] = "Resistance & Offensive", --individual
    ["Judgement"] = "Blitzschlagschild",
  },
  ["nohearthstone"] = "Kein Ruhestein gefunden.",
};

MOUNT_ITEM = {
  ["ReinsMount"] = "Horn des schnellen Waldwolfs",
  ["RamMount"] = "Horn des schnellen Waldwolfs",
  ["BridleMount"] = "Zaumzeug",
  ["BridleMount2"] = "Zaumzeug",
  ["BridleMount3"] = "Zaumzeug",
  ["MechanostriderMount"] = "Horn des schnellen Waldwolfs",
  ["QuirajiMount"] = "Qirajiresonanzkristall",
};

SpiritSphere_MENU = {
  ["Show"] = "Zeige: ",
  ["Drag"] = "Freisetzen: ",
  ["Tooltips"] = "Darstellung der Tooltips: ",
  ["Blessing"] = "Totems",
  ["Seal"] = "Extra",
  ["Mount"] = "Geisterwolf",
  ["Off"] = "Aus",
  ["Partial"] = "Nur Mana",
  ["Total"] = "Standard",  
};

end
