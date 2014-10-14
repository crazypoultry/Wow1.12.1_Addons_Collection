--[[

locale-conversions.lua

This file handles converting various data styles between locales.

The zone number mappings are defined keyed to the enUS locale, as that is the locale of the author.

locale mappings:-
à : \195\160		è : \195\168		ì : \195\172		ò : \195\178		ù : \195\185
á : \195\161		é : \195\169		í : \195\173		ó : \195\179		ú : \195\186
â : \195\162		ê : \195\170		î : \195\174		ô : \195\180		û : \195\187
ã : \195\163		ë : \195\171		ï : \195\175		õ : \195\181		ü : \195\188
ä : \195\164					ñ : \195\177		ö : \195\182
æ : \195\166					ø : \195\184
ç : \195\167

Â : \195\130								Ö : \195\150

As a reminder - this lua like any I write are usable by any addon author EXCEPT the cosmos development team.
I do not wish my name associated with an addon pack that has been known at times to edge the line of ToS violations, as well as be very bad code otherwise.
This may be used by members of the cosmos team for addons they do not include in the cosmos suite.

]]

-- Use this to cut down on function calls.
LLC_LOCALE = GetLocale();

-- Error Message (enUS)
LLC_MSG_ERRORZONE = format("EFM Error: Zone %%s is not known, please report this.")

-- Error Message (frFR)
if (LLC_LOCALE == "frFR") then
LLC_MSG_ERRORZONE = format("EFM Erreur: Cette Zone %%s n\'est pas connue, faites un rapport de bug s\'il vous plait."); -- Translated 04/19/2006 
end

-- Error Message (deDE)
if (LLC_LOCALE == "deDE") then
--LLC_MSG_ERRORZONE = format("EFM Error: Zone %%s, in flight node %%s is not known, please report this.")
end

-- This defines the zone number mappings.
LLC_Zones = {
	[1]	= {
		[1]	= {
			["enUS"]	= "Ashenvale",
			["deDE"]	= "Ashenvale",
			["frFR"]	= "Ashenvale",
		},
		[2]	= {
			["enUS"]	= "Azshara",
			["deDE"]	= "Azshara",
			["frFR"]	= "Azshara",
		},
		[3]	= {
			["enUS"]	= "Darkshore",
			["deDE"]	= "Dunkelk\195\188ste",
			["frFR"]	= "Sombrivage (Darkshore)",
		},
		[4]	= {
			["enUS"]	= "Darnassus",
			["deDE"]	= "Darnassus",
			["frFR"]	= "Darnassus",
		},
		[5]	= {
			["enUS"]	= "Desolace",
			["deDE"]	= "Desolace",
			["frFR"]	= "D\195\169solace",
		},		
		[6]	= {
			["enUS"]	= "Durotar",
			["deDE"]	= "Durotar",
			["frFR"]	= "Durotar",
		},
		[7]	= {
			["enUS"]	= "Dustwallow Marsh",
			["deDE"]	= "Die Marschen von Dustwallow",
			["frFR"]	= "Mar\195\169cage d\'\195\130prefange (Dustwallow Marsh)",
		},
		[8]	= {
			["enUS"]	= "Felwood",
			["deDE"]	= "Teufelswald",
			["frFR"]	= "Gangrebois",
		},
		[9]	= {
			["enUS"]	= "Feralas",
			["deDE"]	= "Feralas",
			["frFR"]	= "Feralas",
		},
		[10]	= {
			["enUS"]	= "Moonglade",
			["deDE"]	= "Moonglade",
			["frFR"]	= "Reflet-de-Lune (Moonglade)",
		},
		[11]	= {
			["enUS"]	= "Mulgore",
			["deDE"]	= "Mulgore",
			["frFR"]	= "Mulgore",
		},
		[12]	= {
			["enUS"]	= "Orgrimmar",
			["deDE"]	= "Orgrimmar",
			["frFR"]	= "Orgrimmar",
		},
		[13]	= {
			["enUS"]	= "Silithus",
			["deDE"]	= "Silithus",
			["frFR"]	= "Silithus",
		},
		[14]	= {
			["enUS"]	= "Stonetalon Mountains",
			["deDE"]	= "Das Steinkrallengebirge",
			["frFR"]	= "Les Serres-Rocheuses (Stonetalon Mts)",
		},
		[15]	= {
			["enUS"]	= "Tanaris",
			["deDE"]	= "Tanaris",
			["frFR"]	= "Tanaris",
		},
		[16]	= {
			["enUS"]	= "Teldrassil",
			["deDE"]	= "Teldrassil",
			["frFR"]	= "Teldrassil",
		},
		[17]	= {
			["enUS"]	= "The Barrens",
			["deDE"]	= "Das Brachland",
			["frFR"]	= "Les Tarides (the Barrens)",
		},
		[18]	= {
			["enUS"]	= "Thousand Needles",
			["deDE"]	= "Tausend Nadeln",
			["frFR"]	= "Mille Pointes (Thousand Needles)",
		},
		[19]	= {
			["enUS"]	= "Thunder Bluff",
			["deDE"]	= "Thunder Bluff",
			["frFR"]	= "Thunder Bluff",
		},
		[20]	= {
			["enUS"]	= "Un\'Goro Crater",
			["deDE"]	= "Der Un\'Goro-Krater",
			["frFR"]	= "Crat\195\168re d\'Un\'Goro",
		},
		[21]	= {
			["enUS"]	= "Winterspring",
			["deDE"]	= "Winterspring",
			["frFR"]	= "Berceau-de-l\'Hiver (Winterspring)",
		},
	},
	[2]	={
		[1]	= {
			["enUS"]	= "Alterac Mountains",
			["deDE"]	= "Das Alteracgebirge ",
			["frFR"]	= "Montagnes d\'Alterac",
		},
		[2]	= {
			["enUS"]	= "Arathi Highlands",
			["deDE"]	= "Das Arathihochland ",
			["frFR"]	= "Hautes-terres d\'Arathi",
		},
		[3]	= {
			["enUS"]	= "Badlands",
			["deDE"]	= "Das \195\150dland",
			["frFR"]	= "Terres ingrates (Badlands)",
		},
		[4]	= {
			["enUS"]	= "Blasted Lands",
			["deDE"]	= "Die verw\195\188steten Lande",
			["frFR"]	= "Terres foudroy\195\169es (Blasted Lands)",
		},
		[5]	= {
			["enUS"]	= "Burning Steppes",
			["deDE"]	= "Die brennende Steppe",
			["frFR"]	= "Steppes ardentes",
		},
		[6]	= {
			["enUS"]	= "Deadwind Pass",
			["deDE"]	= "Der Gebirgspass der Totenwinde",
			["frFR"]	= "D\195\169fil\195\169 de Deuillevent (Deadwind Pass)",
		},
		[7]	= {
			["enUS"]	= "Dun Morogh",
			["deDE"]	= "Dun Morogh",
			["frFR"]	= "Dun Morogh",
		},
		[8]	= {
			["enUS"]	= "Duskwood",
			["deDE"]	= "D\195\164mmerwald",
			["frFR"]	= "Bois de la p\195\169nombre (Duskwood)",
		},
		[9]	= {
			["enUS"]	= "Eastern Plaguelands",
			["deDE"]	= "Die \195\182stlichen Pestl\195\164nder",
			["frFR"]	= "Maleterres de l\'est (Eastern Plaguelands)",
		},
		[10]	= {
			["enUS"]	= "Elwynn Forest",
			["deDE"]	= "Der Wald von Elwynn",
			["frFR"]	= "For\195\170t d\'Elwynn",
		},
		[11]	= {
			["enUS"]	= "Hillsbrad Foothills",
			["deDE"]	= "Die Vorgebirge von Hillsbrad",
			["frFR"]	= "Contreforts d\'Hillsbrad",
		},
		[12]	= {
			["enUS"]	= "Ironforge",
			["deDE"]	= "Ironforge",
			["frFR"]	= "Ironforge",
		},
		[13]	= {
			["enUS"]	= "Loch Modan",
			["deDE"]	= "Loch Modan",
			["frFR"]	= "Loch Modan",
		},
		[14]	= {
			["enUS"]	= "Redridge Mountains",
			["deDE"]	= "Das Rotkammgebirge",
			["frFR"]	= "Les Carmines (Redridge Mts)",
		},
		[15]	= {
			["enUS"]	= "Searing Gorge",
			["deDE"]	= "Die sengende Schlucht",
			["frFR"]	= "Gorge des Vents br\195\187lants (Searing Gorge)",
		},
		[16]	= {
			["enUS"]	= "Silverpine Forest",
			["deDE"]	= "Der Silberwald",
			["frFR"]	= "For\195\170t des Pins argent\195\169s (Silverpine Forest)",
		},
		[17]	= {
			["enUS"]	= "Stormwind City",
			["deDE"]	= "Stormwind",
			["frFR"]	= "Cit\195\169 de Stormwind",
		},
		[18]	= {
			["enUS"]	= "Stranglethorn Vale",
			["deDE"]	= "Schlingendorntal",
			["frFR"]	= "Vall\195\169e de Strangleronce (Stranglethorn Vale)",
		},
		[19]	= {
			["enUS"]	= "Swamp of Sorrows",
			["deDE"]	= "Die S\195\188mpfe des Elends",
			["frFR"]	= "Marais des Chagrins (Swamp of Sorrows)",
		},
		[20]	= {
			["enUS"]	= "The Hinterlands",
			["deDE"]	= "Das Hinterland",
			["frFR"]	= "Les Hinterlands",
		},
		[21]	= {
			["enUS"]	= "Tirisfal Glades",
			["deDE"]	= "Tirisfal",
			["frFR"]	= "Clairi\195\168res de Tirisfal",
		},
		[22]	= {
			["enUS"]	= "Undercity",
			["deDE"]	= "Undercity",
			["frFR"]	= "Undercity",
		},
		[23]	= {
			["enUS"]	= "Western Plaguelands",
			["deDE"]	= "Die westlichen Pestl\195\164nder",
			["frFR"]	= "Maleterres de l\'ouest (Western Plaguelands)",
		},
		[24]	= {
			["enUS"]	= "Westfall",
			["deDE"]	= "Westfall",
			["frFR"]	= "Marche de l\'Ouest (Westfall)",
		},
		[25]	= {
			["enUS"]	= "Wetlands",
			["deDE"]	= "Das Sumpfland",
			["frFR"]	= "Les Paluns (Wetlands)",
		},
	},
};

-- This array contains the locale flight node reference to zone update table...
LLC_FlightZoneMatchTable = {
	["deDE"]	= {
		["\195\182stliche Pestl\195\164nder"]		= "Die \195\182stlichen Pestl\195\164nder",
		["sengende Schlucht"]					= "Die sengende Schlucht",
		["westliche Pestl\195\164nder"]			= "Die westlichen Pestl\195\164nder", 
		["Verw\195\188stete Lande"]				= "Die verw\195\188steten Lande",
	},
	["frFR"]	= {
		["Pins argent\195\169s"]				= "For\195\170t des Pins argent\195\169s (Silverpine Forest)",
	},
};

-- This function searches the zone references to return the correct zone numbers.
function LLC_SearchZones(zoneName)
	if (zoneName == nil) then
		return;
	end

	local myLocale = GetLocale();

	-- This should reference the LLC_FlightZoneMatchTable and give us the correct zone name for matching reference zones.
	if (LLC_FlightZoneMatchTable[myLocale] ~= nil) then
		if (LLC_FlightZoneMatchTable[myLocale][zoneName] ~= nil) then
			zoneName = LLC_FlightZoneMatchTable[myLocale][zoneName];
		end
	end

	-- Pass through the zone list for the continent and return the zone number for the zone.
	for continent = 1, 2 do
		for index = 1, getn(LLC_Zones[continent]) do
			if (string.find(string.lower(LLC_Zones[continent][index][myLocale]), string.lower(zoneName), 1, true) ~= nil) then
				return index;
			end
		end
	end

	return nil;
end

-- This function returns the zone name for the current locale when given a zone name for a different locale
function LLC_SearchZonesByLocale(zoneName, locale)
	-- Pass through the zone list for the continent and return the zone number for the zone.
	for continent = 1, 2 do
		for index = 1, getn(LLC_Zones[continent]) do
			if (string.find(string.lower(LLC_Zones[continent][index][locale]), string.lower(zoneName), 1, true) ~= nil) then
				return LLC_Zones[continent][index][GetLocale()];
			end
		end
	end

	return nil;
end
