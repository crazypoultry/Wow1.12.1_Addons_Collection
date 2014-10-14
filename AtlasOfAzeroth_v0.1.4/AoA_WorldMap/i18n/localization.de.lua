--------------------------------------------------------------------------------
--
-- Deutsch (German)
-- 
-- Für Tipps zu falschen oder fehlenden Namen
-- bitte im Forum bescheid geben! DANKE!
-- 
-- Lokalisation: Pernicius
--------------------------------------------------------------------------------
if (GetLocale() == "deDE") then



BINDING_NAME_AOA_WORLDMAP_TOGGLE = "Weltkarte (an/aus)";

AOA_WORLDMAP_TABTEXT = "Weltkarte";

AOA_WORLDMAP_PLAYERPOS = "Spieler Pos:";
AOA_WORLDMAP_CURSORPOS = "Zeiger Pos:";
AOA_WORLDMAP_FOLLOW    = "Spieler folgen";
AOA_WORLDMAP_FILTER    = "Filter";

AOA_WORLDMAP_FILTER_POSPLAYER = "Spieler Position";
AOA_WORLDMAP_FILTER_POSCURSOR = "Zeiger Position";
AOA_WORLDMAP_FILTER_PINPLAYER = "Spieler Pin";
AOA_WORLDMAP_FILTER_PINPARTY  = "Gruppen/Raid Pins";
AOA_WORLDMAP_FILTER_FWM       = "Unentdeckte Gebiete";

AOA_WORLDMAP_NOTES = {
	-- Regionen (Östliche Königreiche)
	["Wald von Elwynn"]                   = "Stufe 1-10 (Allianz, Startgebiet der Menschen)",
	["Dun Morogh"]                        = "Stufe 1-10 (Allianz, Startgebiet der Zwerge/Gnome)",
	["Tirisfal"]                          = "Stufe 1-10 (Horde, Startgebiet der Untoten)",
	["Loch Modan"]                        = "Stufe 10-20 (Allianz, \195\156berwiegend Zwerge)",
	["Silberwald"]                        = "Stufe 10-20 (Horde, \195\156berwiegend Untote)",
	["Westfall"]                          = "Stufe 10-20 (Allianz, \195\156berwiegend Menschen)",
	["Rotkammgebirge"]                    = "Stufe 15-25 (Umk\195\164mpft, \195\156berwiegend Allianz)",
	["D\195\164mmerwald"]                 = "Stufe 18-30 (Umk\195\164mpft, \195\156berwiegend Allianz)",
	["Vorgebirge von Hillsbrad"]          = "Stufe 20-30 (Umk\195\164mpft)",
	["Sumpfland"]                         = "Stufe 20-30 (Umk\195\164mpft, \195\156berwiegend Allianz)",
	["Alteracgebirge"]                    = "Stufe 30-40 (Umk\195\164mpft)",
	["Arathihochland"]                    = "Stufe 30-40 (Umk\195\164mpft)",
	["Schlingendorntal"]                  = "Stufe 30-45 (Umk\195\164mpft)",
	["\195\150dland"]                     = "Stufe 35-45 (Umk\195\164mpft)",
	["S\195\188mpfe des Elends"]          = "Stufe 35-45 (Umk\195\164mpft)",
	["Hinterland"]                        = "Stufe 40-50 (Umk\195\164mpft)",
	["Sengende Schlucht"]                 = "Stufe 43-50 (Umk\195\164mpft)",
	["Verw\195\188stete Lande"]           = "Stufe 45-55 (Umk\195\164mpft)",
	["Brennende Steppe"]                  = "Stufe 50-58 (Umk\195\164mpft)",
	["Westliche Pestl\195\164nder"]       = "Stufe 51-58 (Umk\195\164mpft)",
	["\195\150stliche Pestl\195\164nder"] = "Stufe 53-60 (Umk\195\164mpft)",
	["Gebirgspass der Totenwinde"]        = "Stufe 55-60 (Umk\195\164mpft)",
	-- Regionen (Kalimdor)
	["Durotar"]                           = "Stufe 1-10 (Horde, Startgebiet der Orcs/Trolle)",
	["Mulgore"]                           = "Stufe 1-10 (Horde, Startgebiet der Tauren)",
	["Teldrassil"]                        = "Stufe 1-10 (Allianz, Startgebiet der Nachtelfen)",
	["Dunkelk\195\188ste"]                = "Stufe 10-20 (Allianz, \195\156berwiegend Nachtelfen)",
	["Brachland"]                         = "Stufe 10-25 (Horde, \195\156berwiegend Horde)",
	["Steinkrallengebirge"]               = "Stufe 15-27 (Umk\195\164mpft, \195\156berwiegend Horde)",
	["Ashenvale"]                         = "Stufe 18-30 (Umk\195\164mpft, \195\156berwiegend Allianz)",
	["Tausend Nadeln"]                    = "Stufe 25-35 (Umk\195\164mpft, \195\156berwiegend Horde)",
	["Desolace"]                          = "Stufe 30-40 (Umk\195\164mpft, \195\156berwiegend Horde)",
	["Marschen von Dustwallow"]           = "Stufe 35-45 (Umk\195\164mpft)",
	["Feralas"]                           = "Stufe 40-50 (Umk\195\164mpft)",
	["Tanaris"]                           = "Stufe 40-50 (Umk\195\164mpft)",
	["Azshara"]                           = "Stufe 45-55 (Umk\195\164mpft)",
	["Teufelswald"]                       = "Stufe 48-55 (Umk\195\164mpft)",
	["Un'Goro-Krater"]                    = "Stufe 48-55 (Umk\195\164mpft)",
	["Moonglade"]                         = "Stufe 50-60 (Umk\195\164mpft)",
	["Winterspring"]                      = "Stufe 55-60 (Umk\195\164mpft)",
	["Silithus"]                          = "Stufe 55-60 (Umk\195\164mpft)",
	-- Städte
	["Darnassus"]                         = "Hauptstadt der Nachtelfen (Allianz)",
	["Ironforge"]                         = "Hauptstadt der Zwerge/Gnome (Allianz)",
	["Orgrimmar"]                         = "Hauptstadt der Orcs/Trolle (Horde)",
	["Undercity"]                         = "Hauptstadt der Untoten (Horde)",
	["Stormwind"]                         = "Hauptstadt der Menschen (Allianz)",
	["Thunder Bluff"]                     = "Hauptstadt der Tauren (Horde)",
	};



end


--[[
	ä : \195\164	Ä : \195\132	ß : \195\159
	ü : \195\188	Ü : \195\156
	ö : \195\182	Ö : \195\150
	
	umkämpft: cd832b
	allianz:  6774ec
	horde:    c32929
]]--