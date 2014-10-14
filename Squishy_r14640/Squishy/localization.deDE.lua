-- deDE localization by Gamefaq

local L = AceLibrary("AceLocale-2.2"):new("Squishy")

L:RegisterTranslations("deDE", function() return {

	-- bindings
	["Target unit with highest priority"] = "Spieler mit h\195\182ster Priorit\195\164t anw\195\164hlen",
	["Target unit with 2nd highest priority"] = "Spieler mit zweith\195\182ster Priorit\195\164t anw\195\164hlen",
	["Target unit with 3rd highest priority"] = "Spieler mit dritth\195\182ster Priorit\195\164t anw\195\164hlen",
	
	-- from combatlog
	["(.+) begins to cast (.+)."] = "(.+) beginnt (.+) zu wirken.",
	["(.+) gains (.+) Mana from (.+)'s Life Tap."] = "(.+) bekommt (.+) Mana durch (.+)'s Lebensentzug.",
	
	-- options
	["Default"] = "Grundeinstellung",
	["Smooth"] = "Glatt",
	["Button"]		= "Button",
	["BantoBar"]	= "BantoBar",
	["Charcoal"]	= "Charcoal",
	["Otravi"]		= "Otravi",
	["Perl"]		= "Perl",
	["Smudge"]		= "Smudge",
	
	["always"] = "Immer",
	["grouped"] = "Gruppe",
	
	["Frame options"] = "Fenster Optionen",
	["Show Border"] = "Zeige Ramen",
	["Shows/hides the frame border."] = "Zeigt/Versteckt den Fenster Ramen",
	["Show Header"] = "Zeige \195\188berschrift",
	["Shows/hides the frame header."] = "Zeigt/Versteckt die Fenster \195\188berschrift",
	["Scale"] = "Skalierung",
	["Scales the Emergency Monitor."] = "Skaliert die gr\195\182\195\159e des Fensters.",
	["Number of units"] = "Anzahl der sichtbaren Spieler",
	["Number of max visible units."] = "Anzahl der maximal sichtbaren Spieler.",
	["Frame lock"] = "Fenster sperren",
	["Locks/unlocks the emergency monitor."] = "Sperrt/entsperrt das Fenster gegen ungewolltes Verschieben.",
	["Show Frame"] = "Fensteranzeige",
	["Sets when the Squishy frame is visible: Choose 'always' or 'grouped'."] = "Justiert wann das Fenster sichtbar wird. W\195\164hle aus: 'Immer' oder 'Gruppe'.",
	["Pet support"] = "Auch Begleiter anzeigen",
	["Toggles the display of pets in the emergency frame."] = "Aktiviert die Anzeige von Begleitern im Fenster.",
	
	["Unit options"] = "Zeilen Optionen",
	["Alpha"] = "Transparenz",
	["Changes background+border visibility"] = "Justiert die Transparenz von Hintergrund und Rahmen.",
	["Style"] = "Style",
	["Color bar either by health, class or use the CTRA style."] = "F\195\164rbe Leiste entweder durch Leben, Klasse oder benutze CTRA Style.",
	["Health"] = "Leben",
	["Class"] = "Klasse",
	["CTRA"] = "CTRA",
	["Texture"] = "Textur",
	["Sets the bar texture. Choose 'Default', 'BantoBar', 'Button', 'Charcoal', 'Otravi', 'Perl', 'Smooth' or 'Smudge'."] = "Stellt die Textur der Gesundheitsleisten ein. W\195\164hle aus 'Blizzard', 'Grundeinstellung' oder 'Glatt'.",
	["Health deficit"] = "Lebensdefizit",
	["Toggles the display of health deficit in the emergency frame."] = "Aktiviert das Anzeigen von verlorenen Lebenspunkten im Fenster.",
	["Unit bar height"] = "Einheit Leisten h\195\182he",
	["Unit bar width"] = "Einheit Leisten breite",
	["Bar Spacing"] = "Leisten Abstand",
	["Change the spacing between bars"] = "\195\164ndert den Abstand zwischen den Leisten",
	["Inside Bar"] = "Innnerhalb Leiste",
	["Outside Bar"] = "Au\195\159erhalb Leiste",
	["Name position inside bar"] = "Namen Position innerhalb der Leiste",
	["Show name position inside bar"] = "Zeige Namen Position innerhalb der Leiste",
	["Class colored name"] = "Nach Klassen eingef\195\164rbte Namen",
	["Color names by class"] = "F\195\164rbe Namen nach Klasse",
	
	["Class options"] = "Klassen Optionen",
	
	["Various options"] = "Sonstige Optionen",
	["Audio alert on aggro"] = "Audio-Alarm bei Aggro",
	["Toggle on/off audio alert on aggro."] = "Audio-Alarm abspielen wenn man Aggro bekommt.",
	["Log range"] = "Kampfaufzeichnungsreichweite",
	["Changes combat log range. Set it to your max healing range"] = "Justiert Kampfaufzeichnungsreichweite. Stell dies gem\195\164\195\159 deiner max. Heilungsreichweite ein.",
	["Version Query"] = "Versionsabfrage",
	["Checks the group for Squishy users and prints their version data."] = "Pr\195\188ft die Gruppe auf Squishy User.",
	["Checking group for Squishy users, please wait."] = "Überpr\195\188fe Gruppe",
	["using"] = "verwendet",

	-- notifications in frame
	[" is healing you."] = " heilt dich.",
	[" healing your group."] = " heilt deine Gruppe.",
	[" died."] = " ist gestorben.",
	
	-- frame header
	["Squishy Emergency"] = "Squishy Monitor",
	
	-- debuffs and other spell related locals
	["Mortal Strike"] = "Mortal Strike",
	["Mortal Cleave"] = "Mortal Cleave",
	["Gehennas\' Curse"] = "Gehennas\' Curse",
	["Curse of the Deadwood"] = "Curse of the Deadwood",
	["Blood Fury"] = "Blood Fury",
	["Brood Affliction: Green"] = "Brood Affliction: Green",
	["Necrotic Poison"] = "Necrotic Poison",
	["Conflagration"] = "Conflagration",
	["Petrification"] = "Petrification",
} end)
