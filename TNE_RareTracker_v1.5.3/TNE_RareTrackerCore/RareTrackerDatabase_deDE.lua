
-- DEFAULT GERMAN DATABASE

-- all rare spawns currently known by http://blasc.planet-multiplayer.de
--  * sorted by zone, then by name
--  * elite creatures are marked, non-elite is default
--  * levels are give or take, they may vary
--  * creatureType are the general type reported by the game
--     - beasts are marked as just beasts until found to add some challenge,
--       and when found they get their correct family (cat, raptor, etc)
--  * locations will be added/update each time a rare is found (0,0 in instance or when unknown)
--  * subzones are added for found rares

-- � - \195\188 - ü
-- � - \195\156
-- � - \195\182 - ö
-- � - \195\150
-- � - \195\164 - ä
-- � - \195\134
-- � - \195\159 - ß

TNE_RareTracker_Default_Database_deDE = {
	["Die Vorgebirge von Hillsbrad"] = {
		["Kriechfänger"] = {
			["creatureType"] = "Wildtier",
			["level"] = 24,
		},
		["Lady Zephris"] = {
			["creatureType"] = "Humanoid",
			["level"] = 33,
		},
		["Ro'Bark"] = {
			["creatureType"] = "Humanoid",
			["level"] = 28,
		},
		["Samras"] = {
			["creatureType"] = "Wildtier",
			["level"] = 27,
		},
		["Scargil"] = {
			["creatureType"] = "Humanoid",
			["level"] = 30,
		},
	},
	["Das Arathi Hochland"] = {
		["Kovork"] = {
			["creatureType"] = "Humanoid",
			["level"] = 36,
		},
		["Molok der Zermalmer"] = {
			["creatureType"] = "Humanoid",
			["level"] = 39,
		},
		["Nimar der Töter"] = {
			["creatureType"] = "Humanoid",
			["level"] = 35,
		},
		["Prinz Nazjak"] = {
			["creatureType"] = "Humanoid",
			["level"] = 41,
		},
		["Singer"] = {
			["creatureType"] = "Humanoid",
			["level"] = 34,
		},
		["Zalas Witherbark"] = {
			["creatureType"] = "Humanoid",
			["level"] = 40,
		},
	},
	["Die westlichen Pestländer"] = {
		["Die Hülse"] = {
			["creatureType"] = "Elementar",
			["level"] = 62,
		},
		["Faulmähne"] = {
			["creatureType"] = "Untoter",
			["level"] = 52,
		},
		["Großknecht Marcrid"] = {
			["creatureType"] = "Humanoid",
			["level"] = 58,
		},
		["Lord Maldazzar"] = {
			["creatureType"] = "Humanoid",
			["level"] = 56,
		},
		["Scharlachroter Richter"] = {
			["creatureType"] = "Humanoid",
			["level"] = 60,
		},
		["Scharlachroter Schmied"] = {
			["creatureType"] = "Humanoid",
			["level"] = 58,
		},
		["Steinwüter"] = {
			["creatureType"] = "Elementar",
			["level"] = 37,
		},
	},
	["Das Hinterland"] = {
		["Eisenpanzer"] = {
			["creatureType"] = "Wildtier",
			["level"] = 51,
		},
		["Jalinde Summerdrake"] = {
			["creatureType"] = "Humanoid",
			["level"] = 49,
		},
		["Klippenspringer"] = {
			["creatureType"] = "Wildtier",
			["level"] = 40,
		},
		["Reißerklaue"] = {
			["creatureType"] = "Humanoid",
			["level"] = 44,
		},
		["Retherokk der Berserker"] = {
			["creatureType"] = "Humanoid",
			["level"] = 45,
		},
		["Witherheart der Pirscher"] = {
			["creatureType"] = "Humanoid",
			["level"] = 45,
		},
		["Zul'arek Hatefowler"] = {
			["creatureType"] = "Humanoid",
			["level"] = 43,
		},
	},
	["Mulgore"] = {
		["Der Kratzer"] = {
			["creatureType"] = "Wildtier",
			["level"] = 10,
		},
		["Geistheuler"] = {
			["creatureType"] = "Wildtier",
			["level"] = 12,
		},
		["Mazzranache"] = {
			["creatureType"] = "Wildtier",
			["level"] = 5,
		},
		["Snagglespear"] = {
			["creatureType"] = "Humanoid",
			["level"] = 9,
		},
		["Vollstrecker Emilgund"] = {
			["creatureType"] = "Humanoid",
			["level"] = 11,
		},
	},
	["Darkshore"] = {
		["Carnivous der Zerstörer"] = {
			["creatureType"] = "Humanoid",
			["level"] = 16,
		},
		["Feuerrufer Radison"] = {
			["creatureType"] = "Humanoid",
			["level"] = 19,
		},
		["Flagglemurk der Grausame"] = {
			["creatureType"] = "Humanoid",
			["level"] = 16,
		},
		["Lady Moongazer"] = {
			["creatureType"] = "Untoter",
			["level"] = 16,
		},
		["Lady Vespira"] = {
			["creatureType"] = "Humanoid",
			["level"] = 22,
		},
		["Licillin"] = {
			["creatureType"] = "Dämon",
			["level"] = 14,
		},
		["Lord Sinslayer"] = {
			["creatureType"] = "Humanoid",
			["level"] = 15,
		},
		["Schattenklaue"] = {
			["creatureType"] = "Wildtier",
			["level"] = 13,
		},
		["Schreitergelegemutter"] = {
			["creatureType"] = "Wildtier",
			["level"] = 20,
		},
	},
	["Dun Morogh"] = {
		["Altvater Arctikus"] = {
			["creatureType"] = "Humanoid",
			["level"] = 7,
		},
		["Bjarn"] = {
			["creatureType"] = "Wildtier",
			["level"] = 12,
		},
		["Edan der Heuler"] = {
			["creatureType"] = "Humanoid",
			["level"] = 9,
		},
		["Gibblewilt"] = {
			["creatureType"] = "Humanoid",
			["level"] = 11,
		},
		["Hammerspine"] = {
			["creatureType"] = "Humanoid",
			["level"] = 12,
		},
		["Holzplanke"] = {
			["creatureType"] = "Wildtier",
			["level"] = 5,
		},
	},
	["Desolace"] = {
		["Hissperak"] = {
			["creatureType"] = "Wildtier",
			["level"] = 37,
		},
		["Kaskk"] = {
			["creatureType"] = "Dämon",
			["level"] = 39,
		},
		["Kicherer"] = {
			["creatureType"] = "Wildtier",
			["level"] = 34,
		},
		["Prinz Kellen"] = {
			["creatureType"] = "Dämon",
			["level"] = 33,
		},
		["Verfluchter der Zackenkämme"] = {
			["creatureType"] = "Humanoid",
			["level"] = 35,
		},
	},
	["Das Steinkrallengebirge"] = {
		["Prachtschwingenpatriarch"] = {
			["creatureType"] = "Wildtier",
			["level"] = 25,
		},
		["Rachsüchtiges Urtum"] = {
			["creatureType"] = "Elementar",
			["level"] = 29,
		},
	},
	["Tanaris"] = {
		["Cyclok der Irre"] = {
			["creatureType"] = "Humanoid",
			["level"] = 48,
		},
		["Großer Feuervogel"] = {
			["creatureType"] = "Wildtier",
			["level"] = 46,
		},
		["Kregg Kielhol"] = {
			["creatureType"] = "Humanoid",
			["level"] = 46,
		},
		["Mordlustige Eiterpfote"] = {
			["creatureType"] = "Wildtier",
			["level"] = 43,
		},
		["Omgorn der Verirrte"] = {
			["creatureType"] = "Humanoid",
			["level"] = 50,
		},
	},
	["Die östlichen Pestländer"] = {
		["Duggan Wildhammer"] = {
			["creatureType"] = "Humanoid",
			["level"] = 55,
		},
		["Gish der Unbewegliche"] = {
			["creatureType"] = "Untoter",
			["level"] = 56,
		},
		["Hed'mush der Faulende"] = {
			["creatureType"] = "Untoter",
			["level"] = 57,
		},
		["Kriegsherr Thresh'jin"] = {
			["creatureType"] = "Humanoid",
			["level"] = 58,
		},
		["Lord Darkscythe"] = {
			["creatureType"] = "Untoter",
			["level"] = 57,
		},
		["Todessprecher Selendre"] = {
			["creatureType"] = "Humanoid",
			["level"] = 55,
		},
		["Waldläuferlord Hawkspear"] = {
			["creatureType"] = "Humanoid",
			["level"] = 60,
		},
		["Zul'Brin Warpbranch"] = {
			["creatureType"] = "Humanoid",
			["level"] = 59,
		},
	},
	["Duskwood"] = {
		["Fenros"] = {
			["creatureType"] = "Humanoid",
			["level"] = 32,
		},
		["Kommandant Felstrom"] = {
			["creatureType"] = "Untoter",
			["level"] = 32,
		},
		["Leprithus"] = {
			["creatureType"] = "Untoter",
			["level"] = 19,
		},
		["Lord Malathrom"] = {
			["creatureType"] = "Untoter",
			["level"] = 31,
		},
		["Lupos"] = {
			["creatureType"] = "Wildtier",
			["level"] = 23,
		},
		["Naraxis"] = {
			["creatureType"] = "Wildtier",
			["level"] = 27,
		},
		["Nefaru"] = {
			["creatureType"] = "Humanoid",
			["level"] = 34,
		},
	},
	["Stormwind"] = {
		["Kanalbestie"] = {
			["creatureType"] = "Wildtier",
			["level"] = 50,
		},
	},
	["Winterspring"] = {
		["Grizzel Schneepfote"] = {
			["creatureType"] = "Humanoid",
			["level"] = 59,
		},
		["Mezzir der Heuler"] = {
			["creatureType"] = "Humanoid",
			["level"] = 55,
		},
		["Rak'shiri"] = {
			["creatureType"] = "Wildtier",
			["level"] = 57,
		},
	},
	["Verwüsteten Lande"] = {
		["Akubar der Seher"] = {
			["creatureType"] = "Humanoid",
			["level"] = 54,
		},
		["Clack der Häscher"] = {
			["creatureType"] = "Wildtier",
			["level"] = 53,
		},
		["Dreadscorn"] = {
			["creatureType"] = "Humanoid",
			["level"] = 57,
		},
		["Fledderschnabel"] = {
			["creatureType"] = "Wildtier",
			["level"] = 52,
		},
		["Magronos der Unerschütterliche"] = {
			["creatureType"] = "Humanoid",
			["level"] = 56,
		},
		["Mojo der Verwachsene"] = {
			["creatureType"] = "Humanoid",
			["level"] = 48,
		},
		["Suhlaman"] = {
			["creatureType"] = "Wildtier",
			["level"] = 50,
		},
		["Todesauge"] = {
			["creatureType"] = "Wildtier",
			["level"] = 49,
		},
		["Verheerer"] = {
			["creatureType"] = "Wildtier",
			["level"] = 51,
		},
	},
	["Feralas"] = {
		["Antilus der Aufsteiger"] = {
			["creatureType"] = "Wildtier",
			["level"] = 48,
		},
		["Arash-ethis"] = {
			["creatureType"] = "Wildtier",
			["level"] = 49,
		},
		["Blutschrei der Pirscher"] = {
			["creatureType"] = "Humanoid",
			["level"] = 48,
		},
		["Diamantenkopf"] = {
			["creatureType"] = "Humanoid",
			["level"] = 45,
		},
		["Knurrer"] = {
			["creatureType"] = "Wildtier",
			["level"] = 42,
		},
		["Lady Szallah"] = {
			["creatureType"] = "Humanoid",
			["level"] = 45,
		},
		["Laubbruder Knarz"] = {
			["creatureType"] = "Elementar",
			["level"] = 43,
		},
		["Silbergrimm der Weise"] = {
			["creatureType"] = "Wildtier",
			["level"] = 43,
		},
	},
	["Tirisfal"] = {
		["Bauer Solliden"] = {
			["creatureType"] = "Humanoid",
			["level"] = 8,
		},
		["Bayne"] = {
			["creatureType"] = "Dämon",
			["level"] = 10,
		},
		["Deeb"] = {
			["creatureType"] = "Humanoid",
			["level"] = 12,
		},
		["Fellicents Schemen"] = {
			["creatureType"] = "Untoter",
			["level"] = 11,
		},
		["Gepeinigter Geist"] = {
			["creatureType"] = "Untoter",
			["level"] = 5,
		},
		["Muad"] = {
			["creatureType"] = "Humanoid",
			["level"] = 10,
		},
		["Ressan der Aufstachler"] = {
			["creatureType"] = "Wildtier",
			["level"] = 11,
		},
		["Sri'skulk"] = {
			["creatureType"] = "Wildtier",
			["level"] = 13,
		},
		["Verirrte Seele"] = {
			["creatureType"] = "Untoter",
			["level"] = 6,
		},
	},
	["Die Sengende Schlucht"] = {
		["Defekter Kriegsgolem"] = {
			["creatureType"] = "Elementar",
			["level"] = 45,
		},
		["Rekk'tilac"] = {
			["creatureType"] = "Wildtier",
			["level"] = 48,
		},
		["Scald"] = {
			["creatureType"] = "Elementar",
			["level"] = 49,
		},
		["Shleipnarr"] = {
			["creatureType"] = "Dämon",
			["level"] = 47,
		},
		["Sklavenmeister Blackheart"] = {
			["creatureType"] = "Humanoid",
			["level"] = 50,
		},
		["Smoldar"] = {
			["creatureType"] = "Elementar",
			["level"] = 50,
		},
	},
	["Das Alteracgebirge"] = {
		["Araga"] = {
			["creatureType"] = "Wildtier",
			["level"] = 35,
		},
		["Cranky Benj"] = {
			["creatureType"] = "Wildtier",
			["level"] = 32,
		},
		["Gravis Slipknot"] = {
			["creatureType"] = "Humanoid",
			["level"] = 36,
		},
		["Jimmy der Bluter"] = {
			["creatureType"] = "Humanoid",
			["level"] = 22,
		},
		["Lo'Grosh"] = {
			["creatureType"] = "Humanoid",
			["level"] = 39,
		},
		["Skhowl"] = {
			["creatureType"] = "Humanoid",
			["level"] = 36,
		},
	},
	["Durotar"] = {
		["Geolord Mottle"] = {
			["creatureType"] = "Humanoid",
			["level"] = 8,
		},
		["Kriegsherr Kolkanis"] = {
			["creatureType"] = "Humanoid",
			["level"] = 5,
		},
		["Todesschinder"] = {
			["creatureType"] = "Wildtier",
			["level"] = 11,
		},
		["Wachkommandant Zalaphil"] = {
			["creatureType"] = "Humanoid",
			["level"] = 7,
		},
	},
	["Maraudon"] = {
		["Verfluchter Zentaur"] = {
			["creatureType"] = "Humanoid",
			["level"] = 43,
		},
	},
	["Das Sumpfland"] = {
		["Brülmor"] = {
			["creatureType"] = "Elementar",
			["level"] = 25,
		},
		["Egelwitwe"] = {
			["creatureType"] = "Wildtier",
			["level"] = 24,
		},
		["Garneg Charskull"] = {
			["creatureType"] = "Humanoid",
			["level"] = 29,
		},
		["Kampfmeister der Dragonmaw"] = {
			["creatureType"] = "Humanoid",
			["level"] = 30,
		},
		["Knochennager"] = {
			["creatureType"] = "Humanoid",
			["level"] = 24,
		},
		["Ma'ruk Wyrmschuppe"] = {
			["creatureType"] = "Humanoid",
			["level"] = 23,
		},
		["Scharfzahnmatriarchin"] = {
			["creatureType"] = "Wildtier",
			["level"] = 31,
		},
	},
	["Thousand Needles"] = {
		["Achellios der Verbannte"] = {
			["creatureType"] = "Humanoid",
			["level"] = 31,
		},
		["Gibblesnik"] = {
			["creatureType"] = "Humanoid",
			["level"] = 28,
		},
		["Harb Foulmountain"] = {
			["creatureType"] = "Humanoid",
			["level"] = 27,
		},
	},
	["Stranglethorn"] = {
		["Gluggle"] = {
			["creatureType"] = "Humanoid",
			["level"] = 37,
		},
		["Kurmokk"] = {
			["creatureType"] = "Wildtier",
			["level"] = 42,
		},
		["Lord Sakrasis"] = {
			["creatureType"] = "Humanoid",
			["level"] = 44,
		},
		["Rippa"] = {
			["creatureType"] = "Wildtier",
			["level"] = 44,
		},
		["Roloch"] = {
			["creatureType"] = "Humanoid",
			["level"] = 38,
		},
		["Schuppenbauch"] = {
			["creatureType"] = "Wildtier",
			["level"] = 45,
		},
		["Verifonix"] = {
			["creatureType"] = "Humanoid",
			["level"] = 42,
		},
	},
	["Das Redridgegebirge"] = {
		["Chatter"] = {
			["creatureType"] = "Wildtier",
			["level"] = 23,
		},
		["Felsenherz"] = {
			["creatureType"] = "Riese",
			["level"] = 25,
		},
		["Fletschzahn"] = {
			["creatureType"] = "Drachkin",
			["level"] = 18,
		},
		["Kazon"] = {
			["creatureType"] = "Humanoid",
			["level"] = 27,
		},
		["Rippenbrecher"] = {
			["creatureType"] = "Humanoid",
			["level"] = 16,
		},
		["Rohh der Schweigsame"] = {
			["creatureType"] = "Humanoid",
			["level"] = 26,
		},
		["Squiddic"] = {
			["creatureType"] = "Humanoid",
			["level"] = 19,
		},
		["Sucher Aqualon"] = {
			["creatureType"] = "Elementar",
			["level"] = 21,
		},
	},
	["Die Sümpfe des Elends"] = {
		["Fingat"] = {
			["creatureType"] = "Humanoid",
			["level"] = 43,
		},
		["Gilmorian"] = {
			["creatureType"] = "Humanoid",
			["level"] = 43,
		},
		["Molt Thorn"] = {
			["creatureType"] = "Elementar",
			["level"] = 42,
		},
		["Verirrter Häuptling"] = {
			["creatureType"] = "Humanoid",
			["level"] = 39,
		},
		["Verirrter Koch"] = {
			["creatureType"] = "Humanoid",
			["level"] = 37,
		},
	},
	["Loch Modan"] = {
		["Boss Galgosh"] = {
			["creatureType"] = "Humanoid",
			["level"] = 22,
		},
		["Grizlak"] = {
			["creatureType"] = "Humanoid",
			["level"] = 15,
		},
		["Großer Lochkrokilisk"] = {
			["creatureType"] = "Wildtier",
			["level"] = 22,
		},
		["Lord Condar"] = {
			["creatureType"] = "Wildtier",
			["level"] = 15,
		},
		["Magosh"] = {
			["creatureType"] = "Humanoid",
			["level"] = 21,
		},
		["Shanda die Weberin"] = {
			["creatureType"] = "Wildtier",
			["level"] = 19,
		},
	},
	["Der Silberwald"] = {
		["Blutmaul"] = {
			["creatureType"] = "Wildtier",
			["level"] = 13,
		},
		["Dalaran-Zauberschreiber"] = {
			["creatureType"] = "Humanoid",
			["level"] = 21,
		},
		["Haudrauf der Moderfelle"] = {
			["creatureType"] = "Untoter",
			["level"] = 22,
		},
		["Krethis Shadowspinner"] = {
			["creatureType"] = "Wildtier",
			["level"] = 15,
		},
		["Ravenclaw-Regent"] = {
			["creatureType"] = "Untoter",
			["level"] = 22,
		},
		["Snarlmane"] = {
			["creatureType"] = "Untoter",
			["level"] = 23,
		},
		["Zwingenkiefer"] = {
			["creatureType"] = "Wildtier",
			["level"] = 14,
		},
	},
	["Die Marschen von Dustwallow"] = {
		["Brühschlammerwurm"] = {
			["creatureType"] = "Wildtier",
			["level"] = 42,
		},
		["Burgle Eye"] = {
			["creatureType"] = "Humanoid",
			["level"] = 38,
		},
		["Dart"] = {
			["creatureType"] = "Wildtier",
			["level"] = 38,
		},
		["Drogoth der Wanderer"] = {
			["creatureType"] = "Elementar",
			["level"] = 37,
		},
		["Graunebelwitwe"] = {
			["creatureType"] = "Wildtier",
			["level"] = 40,
		},
		["Hayoc"] = {
			["creatureType"] = "Wildtier",
			["level"] = 41,
		},
		["Lord Angler"] = {
			["creatureType"] = "Humanoid",
			["level"] = 44,
		},
		["Reißerschuppe"] = {
			["creatureType"] = "Wildtier",
			["level"] = 39,
		},
	},
	["Teufelswald"] = {
		["Alshirr Banebreath"] = {
			["creatureType"] = "Dämon",
			["level"] = 54,
		},
		["Mongress"] = {
			["creatureType"] = "Wildtier",
			["level"] = 50,
		},
		["Olm der Weise"] = {
			["creatureType"] = "Wildtier",
			["level"] = 52,
		},
		["Todesheuler"] = {
			["creatureType"] = "Wildtier",
			["level"] = 49,
		},
		["Wutpranke"] = {
			["creatureType"] = "Humanoid",
			["level"] = 51,
		},
	},
	["Der Un'Goro Krater"] = {
		["Ravasaurus-Matriarchin"] = {
			["creatureType"] = "Wildtier",
			["level"] = 50,
		},
		["Uhk'loc"] = {
			["creatureType"] = "Wildtier",
			["level"] = 50,
		},
	},
	["Das \195\150dland"] = {
		["7:XT"] = {
			["creatureType"] = "Mechanisch",
			["level"] = 41,
		},
		["Kriegsgolem"] = {
			["creatureType"] = "Elementar",
			["level"] = 36,
		},
		["Rumpler"] = {
			["creatureType"] = "Elementar",
			["level"] = 45,
		},
		["Shadowforge-Kommandant"] = {
			["creatureType"] = "Humanoid",
			["level"] = 40,
		},
		["Zerbrochener Zahn"] = {
			["creatureType"] = "Wildtier",
			["level"] = 37,
		},
	},
	["Das Brachland"] = {
		["Azzere die Himmelsklinge"] = {
			["creatureType"] = "Wildtier",
			["level"] = 25,
		},
		["Bruchspeer"] = {
			["creatureType"] = "Humanoid",
			["level"] = 17,
		},
		["Digger Flameforge"] = {
			["creatureType"] = "Humanoid",
			["level"] = 24,
		},
		["Dishu"] = {
			["creatureType"] = "Wildtier",
			["level"] = 13,
		},
		["Donnerstampfer"] = {
			["creatureType"] = "Wildtier",
			["level"] = 24,
		},
		["Geopriester Gukk'rok"] = {
			["creatureType"] = "Humanoid",
			["level"] = 19,
		},
		["Großknecht Grills"] = {
			["creatureType"] = "Humanoid",
			["level"] = 19,
		},
		["Heggin Stonewhisker"] = {
			["creatureType"] = "Humanoid",
			["level"] = 24,
		},
		["Ingenieur Whirleygig"] = {
			["creatureType"] = "Humanoid",
			["level"] = 19,
		},
		["Malgin Barleybrew"] = {
			["creatureType"] = "Humanoid",
			["level"] = 25,
		},
		["Rathorian"] = {
			["creatureType"] = "Dämon",
			["level"] = 15,
		},
		["Snort der Spotter"] = {
			["creatureType"] = "Wildtier",
			["level"] = 17,
		},
		["Steinarm"] = {
			["creatureType"] = "Humanoid",
			["level"] = 15,
		},
	},
	["Ashenvale"] = {
		["Akkrilus"] = {
			["creatureType"] = "Dämon",
			["level"] = 26,
		},
		["Apotheker Falthis"] = {
			["creatureType"] = "Humanoid",
			["level"] = 22,
		},
		["Astschnapper"] = {
			["creatureType"] = "Elementar",
			["level"] = 23,
		},
		["Eck'alom"] = {
			["creatureType"] = "Elementar",
			["level"] = 27,
		},
		["Grummelkehle"] = {
			["creatureType"] = "Humanoid",
			["level"] = 25,
		},
		["Knurrtatze"] = {
			["creatureType"] = "Humanoid",
			["level"] = 27,
		},
		["Lady Vespia"] = {
			["creatureType"] = "Humanoid",
			["level"] = 22,
		},
		["Mugglefin"] = {
			["creatureType"] = "Humanoid",
			["level"] = 23,
		},
		["Nebelheuler"] = {
			["creatureType"] = "Wildtier",
			["level"] = 22,
		},
		["Prinz Raze"] = {
			["creatureType"] = "Dämon",
			["level"] = 32,
		},
		["Terrowulf-Rudelführer"] = {
			["creatureType"] = "Humanoid",
			["level"] = 31,
		},
		["Ursol'lok"] = {
			["creatureType"] = "Wildtier",
			["level"] = 31,
		},
	},
	["Azshara"] = {
		["Antilos"] = {
			["creatureType"] = "Wildtier",
			["level"] = 50,
		},
		["Evalcharr"] = {
			["creatureType"] = "Wildtier",
			["level"] = 48,
		},
		["General Fangferror"] = {
			["creatureType"] = "Humanoid",
			["level"] = 50,
		},
		["Lady Sesspira"] = {
			["creatureType"] = "Humanoid",
			["level"] = 51,
		},
		["Magister Hawkhelm"] = {
			["creatureType"] = "Humanoid",
			["level"] = 51,
		},
		["Meister Feardred"] = {
			["creatureType"] = "Dämon",
			["level"] = 51,
		},
		["Torhüter Donnerschrei"] = {
			["creatureType"] = "Humanoid",
			["level"] = 49,
		},
		["Varo'thens Geist"] = {
			["creatureType"] = "Untoter",
			["level"] = 48,
		},
	},
	["Westfall"] = {
		["Brack"] = {
			["creatureType"] = "Humanoid",
			["level"] = 19,
		},
		["Feindschnitter 4000"] = {
			["creatureType"] = "Mechanisch",
			["level"] = 20,
		},
		["Meisterbuddler"] = {
			["creatureType"] = "Humanoid",
			["level"] = 15,
		},
		["Sergeant Geiferkralle"] = {
			["creatureType"] = "Humanoid",
			["level"] = 18,
		},
		["Slark"] = {
			["creatureType"] = "Humanoid",
			["level"] = 12,
		},
		["Vultros"] = {
			["creatureType"] = "Wildtier",
			["level"] = 26,
		},
	},
	["Der Wald von Elwynn"] = {
		["Fedfennel"] = {
			["creatureType"] = "Humanoid",
			["level"] = 12,
		},
		["Giftzahnbrutmutter"] = {
			["creatureType"] = "Wildtier",
			["level"] = 7,
		},
		["Gruff Swiftbite"] = {
			["creatureType"] = "Humanoid",
			["level"] = 7,
		},
		["Morgaine die Verschlagene"] = {
			["creatureType"] = "Humanoid",
			["level"] = 6,
		},
		["Narg der Zuchtmeister"] = {
			["creatureType"] = "Humanoid",
			["level"] = 8,
		},
		["Thuros Lightfingers"] = {
			["creatureType"] = "Humanoid",
			["level"] = 9,
		},
	},
	["Die brennende Steppe"] = {
		["Fehlfunktionierender Häscher"] = {
			["creatureType"] = "Elementar",
			["level"] = 56,
		},
		["Gorgon'och"] = {
			["creatureType"] = "Humanoid",
			["level"] = 54,
		},
		["Gruklash"] = {
			["creatureType"] = "Humanoid",
			["level"] = 59,
		},
		["Hahk'Zor"] = {
			["creatureType"] = "Humanoid",
			["level"] = 54,
		},
		["Terrorstifter"] = {
			["creatureType"] = "Dämon",
			["level"] = 55,
		},
		["Thauris Balgarr"] = {
			["creatureType"] = "Humanoid",
			["level"] = 57,
		},
		["Totenreißer"] = {
			["creatureType"] = "Wildtier",
			["level"] = 53,
		},
	},
	["Teldrassil"] = {
		["Dämmerpirscher"] = {
			["creatureType"] = "Wildtier",
			["level"] = 9,
		},
		["Furie Shelda"] = {
			["creatureType"] = "Humanoid",
			["level"] = 8,
		},
		["Grimmtatze"] = {
			["creatureType"] = "Humanoid",
			["level"] = 11,
		},
		["Schwarzmoos der Stinker"] = {
			["creatureType"] = "Elementar",
			["level"] = 11,
		},
		["Threggil"] = {
			["creatureType"] = "Dämon",
			["level"] = 6,
		},
		["Uruson"] = {
			["creatureType"] = "Humanoid",
			["level"] = 7,
		},
	},
	["Silithus"] = {
		["Gretheer"] = {
			["creatureType"] = "Wildtier",
			["level"] = 57,
		},
		["Grubthor"] = {
			["creatureType"] = "Wildtier",
			["level"] = 58,
		},
		["Hurrikanus"] = {
			["creatureType"] = "Elementar",
			["level"] = 58,
		},
		["Krellack"] = {
			["creatureType"] = "Wildtier",
			["level"] = 56,
		},
		["Lord der Twilight Everun"] = {
			["creatureType"] = "Humanoid",
			["level"] = 60,
		},
	},
}