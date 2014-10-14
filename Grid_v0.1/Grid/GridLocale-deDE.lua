local L = AceLibrary("AceLocale-2.2"):new("Grid")

local strings_deDE = {
	--{{{ GridCore
	["Debugging"]                     = "Debuggen",
	["Module debugging menu."]        = "Debug-Men\195\188",
	["debug"]                         = "debug",
	["Debug"]                         = "Debug",
	["Toggle debugging."]             = "Aktiviere das Debuggen",
	["Toggle debugging for "] 		  = "Aktiviere das Debuggen f\195\188r ",
	
	--}}}
	--{{{ GridStatus
	["group"]                         = "Gruppe",
	["options"]                       = "Optionen",
	["Options for "]                  = "Optionen f\195\188r ",
	["Enable"]                        = "Aktivieren ",
	["Status"]                        = "Status",
	["Send"]                          = "Sende ",
	["Color"]                         = "Farbe",
	["Color for "]                    = "Farbe f\195\188r ",
	["Priority"]                      = "Priorit\195\164t",
	["Priority for "]                 = "Priorit\195\164t f\195\188r ",
	["Range filter"]                  = "Entfernungsfilter",
	["Range filter for "]             = "Entfernungsfilter f\195\188r ",
	
	--}}}
	--{{{ GridStatusAggro
	["Aggro"]                         = "Aggro",
	["Aggro alert"]                   = "Aggro-Alarm",
	
	--}}}
	--{{{ GridStatusName
	["Unit Name"]                     = "Namen",
	["Letters"]                       = "Buchstaben",
	["Number of unit name letters."]  = "Die Anzahl der Anfangsbuchstaben.",
	["Color by class"]                = "In Klassenfarbe",
	
	--}}}
	--{{{ GridStatusMana
	["Mana threshold"]                = "Mana Grenzwert",
	["Set the percentage for the low mana warning."] = "Setzt den % Grenzwert f\195\188r die Wenig-Mana Warnung" ,
	["Low Mana warning"]              = "Wenig-Mana Warnung",
	["Low Mana"]                      = "Wenig Mana",
	
	--}}}
	--{{{ GridStatusHeals
	["Heals"]                         = "Heilungen",
	["Incoming heals"]                = "eingehende Heilung",
	["(.+) begins to cast (.+)."]     = "(.+) beginnt (.+) zu wirken.",
	["(.+) gains (.+) Mana from (.+)'s Life Tap."] = "(.+) bekommt (.+) Mana durch (.+)'s Lebensentzug.",
	["^Corpse of (.+)$"]              = "^Corpse of (.+)$",
	
	--}}}
	--{{{ GridStatusHealth
	["Unit health"]                   = "Gesundheit",
	["Health deficit"]                = "Gesundheitsdefizit",
	["Low HP warning"]                = "Wenig-HP Warnung",
	["Death warning"]                 = "Todeswarnung",
	["Offline warning"]               = "Offlinewarnung",
	["Health"]                        = "Gesundheit",
	["Show dead as full health"]      = "Zeige Tote mit voller Gesundheit an",
	["Treat dead units as being full health."] = "Behandele Tote als h\195\164tten sie volle Gesundheit",
	["Use class color"]               = "Benutze Klassenfarbe",
	["Color health based on class."]  = "F\195\164rbe den Gesundheitsbalken in Klassenfarbe",
	["Health threshold"]              = "Gesundheitsgrenzwert",
	["Only show deficit above % damage."] = "Zeige Defizit bei mehr als % Schaden",
	["Color deficit based on class."] = "F\195\164rbe das Defizit nach Klassenfarbe",
	["Low HP threshold"]              = "Wenig HP Grenzwert",
	["Set the HP % for the low HP warning."] = "Setzt den % Grenzwert f\195\188r die Wenig-Gesundheit Warnung",
	
	--}}}
	--{{{ GridStatusAuras
	["Debuff type: "]                 = "Schw\195\164chungszauber: ",
	["Poison"]                        = "Gift",
	["Disease"]                       = "Krankheit",
	["Magic"]                         = "Magie",
	["Curse"]                         = "Fluch",
	["Add new Buff"]                  = "Neuen St\195\164rkungszauber hinzuf\195\188gen",
	["Adds a new buff to the status module"] = "F\195\188gt einen neuen St\195\164rkungszauber zum Status Modul hinzu",
	["Add new Debuff"]                = "Neuen Schw\195\164chungszauber hinzuf\195\188gen",
	["Adds a new debuff to the status module"] = "F\195\188gt einen neuen Schw\195\164chungszauber zum Status Modul hinzu",
	["Delete (De)buff"]               = "L\195\182sche Schw\195\164chungszauber",
	["Deletes an existing debuff from the status module"] = "L\195\182scht einen existierenden Schw\195\164chungszauber vom Status Modul.",
	["Remove %s from the menu"]       = "Entfernt %s vom Men\195\188",
	["Debuff: "]                      = "Schw\195\164chungszauber: ",
	["Buff: "]                        = "St\195\164rkungszauber: ",

	--}}}
	
	--{{{ GridLayout
	["Layout"] 						  = "Anordnung",
	["Options for GridLayout."] 	  = "Optionen für die GridAnordnung.",
	["Padding"] 				= "Padding",
	["Adjust frame padding."] 	= "Adjust frame padding.",
	["Spacing"] 				= "Abstand",
	["Adjust frame spacing."] 	= "Den Abstand anpassen.",
	["Scale"] 					= "Skalierung",
	["Adjust Grid scale."] 		= "Skalierung anpassen.",
	["Border"] 					= "Rand",
	["Adjust border color and alpha."] = "Anpassen der Rahmenfarbe und Transparenz.",
	["Background"] 				= "Hintergrund",
	["Adjust background color and alpha."] = "Anpassen der Hintergrundfarbe und Transparenz.",
	["Frame lock"] 				= "Rahmen sperren",
	["Locks/unlocks the grid for movement."] = "Sperrt/entsperrt den Rahmen zum Bewegen",
	["Horizontal groups"] 		= "Horizontal gruppieren",
	["Switch between horzontal/vertical groups."] = "Wechselt zwischen horizontaler/verikaler Gruppierung",
	["Show Frame"] 				= "Zeige den Rahmen",
	["Sets when the Grid is visible: Choose 'always' or 'grouped'."] = "Setzt die Sichtbarkeit von Grid: W\195\164hle 'immer' oder 'in Gruppe'.",
	["always"] 					= "immer",
	["grouped"] 				= "in Gruppe",
	["Show Party in Raid"] 		= "Zeige Gruppe im Schlachtzug",
	["Show party/self as an extra group."] = "Zeigen Gruppe/sich selbst als extra Gruppe an.",
	["Raid Layout"] 			= "Schlachtzug-Anordnung",
	["Select which raid layout to use."] = "W\195\164hle welche Schlachtzug-Anordnung benutzt wird",
	--}}}
	
	--{{{ GridLayoutLayouts
	["None"] = "Keine",
	["By Group 40"] 			= "40er Gruppe",
	["By Group 25"] 			= "25er Gruppe",
	["By Group 20"] 			= "20er Gruppe",
	["By Group 15"] 			= "15er Gruppe",
	["By Group 10"] 			= "10er Gruppe",
	["By Class"] 				= "Nach Klasse",
	["Onyxia"] 					= "Onyxia",
	
	--}}}
	
	--{{{ GridFrame
	["Center Text"] 			= "Text im Zentrum",
	["Border"] 					= "Rand",
	["Health Bar"] 				= "Gesundheitsleiste",
	["Bottom Left Corner"]		= "Untere linke Ecke",
	["Bottom Right Corner"] 	= "Untere rechte Ecke",
	["Top Right Corner"] 		= "Obere rechte Ecke",
	["Top Left Corner"] 		= "Obere linke Ecke",
	["Center Icon"] 			= "Icon im Zentrum",
	["Frame"] 					= "Rahmen",
	["Options for GridFrame."] 	= "Einstellungen die Grid-Rahmen",
	["Invert Bar Color"] 		= "Invetiere die Leistenfarbe",
	["Swap foreground/background colors on bars."] = "Tausche die Vordergrund-/Hintergrundfarbe der Leisten",
	--}}}
}

L:RegisterTranslations("deDE", function() return strings_deDE end)
