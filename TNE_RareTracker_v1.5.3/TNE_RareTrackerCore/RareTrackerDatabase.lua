
-- DEFAULT ENGLISH DATABASE

-- all rare spawns currently known by http://wow.allakhazam.com/dyn/mobs/rare.html
--  * sorted by zone, then by name
--  * elite creatures are marked, non-elite is default
--  * levels are give or take, they may vary
--  * creatureType are the general type reported by the game
--     - beasts are marked as just beasts until found to add some challenge,
--       and when found they get their correct family (cat, raptor, etc)
--  * locations will be added/update each time a rare is found (0,0 in instance or when unknown)
--  * subzones are added for found rares

TNE_RareTracker_Default_Database = {
	["Searing Gorge"] = {
		["Faulty War Golem"] = {
			["creatureType"] = "Elemental",
			["level"] = 46,
		},
		["Highlord Mastrogonde"] = {
			["creatureType"] = "Humanoid",
			["level"] = 51,
			["elite"] = 1,
		},
		["Rekk'tilac"] = {
			["creatureType"] = "Beast",
			["level"] = 48,
		},
		["Scald"] = {
			["creatureType"] = "Elemental",
			["level"] = 49,
		},
		["Shleipnarr"] = {
			["creatureType"] = "Demon",
			["level"] = 47,
		},
		["Slave Master Blackheart"] = {
			["creatureType"] = "Humanoid",
			["level"] = 50,
			["subZone"] = "The Slag Pit",
		},
		["Smoldar"] = {
			["creatureType"] = "Elemental",
			["level"] = 50,
			["subZone"] = "Firewatch Ridge",
		},
	},
	["Alterac Mountains"] = {
		["Araga"] = {
			["creatureType"] = "Beast",
			["level"] = 35,
		},
		["Cranky Benj"] = {
			["creatureType"] = "Beast",
			["level"] = 32,
		},
		["Gravis Slipknot"] = {
			["creatureType"] = "Humanoid",
			["level"] = 36,
			["subZone"] = "Strahnbrad",
		},
		["Jimmy the Bleeder"] = {
			["creatureType"] = "Humanoid",
			["level"] = 23,
		},
		["Narillasanz"] = {
			["creatureType"] = "Dragon",
			["level"] = 44,
			["elite"] = 1,
		},
		["Lo'Grosh"] = {
			["creatureType"] = "Humanoid",
			["level"] = 39,
		},
		["Skhowl"] = {
			["creatureType"] = "Humanoid",
			["level"] = 36,
		},
		["Stone Fury"] = {
			["creatureType"] = "Elemental",
			["level"] = 38,
		},
	},
	["Hillsbrad Foothills"] = {
		["Big Samras"] = {
			["creatureType"] = "Beast",
			["level"] = 27,
			["subZone"] = "Durnholde Keep",
		},
		["Creepthess"] = {
			["creatureType"] = "Beast",
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
		["Scargil"] = {
			["creatureType"] = "Humanoid",
			["level"] = 30,
		},
		["Tamra Stormpike"] = {
			["creatureType"] = "Humanoid",
			["level"] = 28,
			["elite"] = 1,
		},
	},
	["Un'Goro Crater"] = {
		["Clutchmother Zavas"] = {
			["creatureType"] = "Silithid",
			["level"] = 54,
		},
		["Gruff"] = {
			["creatureType"] = "Beast",
			["level"] = 57,
		},
		["King Mosh"] = {
			["creatureType"] = "Beast",
			["level"] = 60,
		},
		["Ravasaur Matriarch"] = {
			["creatureType"] = "Beast",
			["level"] = 50,
		},
		["Uhk'loc"] = {
			["creatureType"] = "Beast",
			["level"] = 53,
		},
	},
	["Mulgore"] = {
		["Enforcer Emilgund"] = {
			["creatureType"] = "Humanoid",
			["level"] = 11,
		},
		["Ghost Howl"] = {
			["creatureType"] = "Beast",
			["level"] = 12,
		},
		["Mazzranache"] = {
			["creatureType"] = "Beast",
			["level"] = 9,
		},
		["Sister Hatelash"] = {
			["creatureType"] = "Humanoid",
			["level"] = 11,
			["elite"] = 1,
		},
		["Snagglespear"] = {
			["creatureType"] = "Humanoid",
			["level"] = 9,
		},
		["The Rake"] = {
			["creatureType"] = "Beast",
			["level"] = 10,
		},
	},
	["Darkshore"] = {
		["Carnivous the Breaker"] = {
			["creatureType"] = "Humanoid",
			["level"] = 16,
		},
		["Firecaller Radison"] = {
			["creatureType"] = "Humanoid",
			["level"] = 19,
		},
		["Flagglemurk the Cruel"] = {
			["creatureType"] = "Humanoid",
			["level"] = 16,
		},
		["Lady Moongazer"] = {
			["creatureType"] = "Undead",
			["level"] = 17,
		},
		["Lady Vespira"] = {
			["creatureType"] = "Humanoid",
			["level"] = 22,
		},
		["Licillin"] = {
			["creatureType"] = "Demon",
			["level"] = 14,
		},
		["Lord Sinslayer"] = {
			["creatureType"] = "Humanoid",
			["level"] = 16,
		},
		["Shadowclaw"] = {
			["creatureType"] = "Beast",
			["level"] = 13,
		},
		["Strider Clutchmother"] = {
			["creatureType"] = "Beast",
			["level"] = 20,
		},
	},
	["Blasted Lands"] = {
		["Akubar the Seer"] = {
			["creatureType"] = "Humanoid",
			["level"] = 54,
		},
		["Clack the Reaver"] = {
			["creatureType"] = "Beast",
			["level"] = 53,
		},
		["Deatheye"] = {
			["creatureType"] = "Beast",
			["level"] = 49,
		},
		["Dreadscorn"] = {
			["creatureType"] = "Humanoid",
			["level"] = 57,
		},
		["Grunter"] = {
			["creatureType"] = "Beast",
			["level"] = 50,
		},
		["Magronos the Unyielding"] = {
			["creatureType"] = "Humanoid",
			["level"] = 56,
		},
		["Mojo the Twisted"] = {
			["creatureType"] = "Humanoid",
			["level"] = 48,
		},
		["Ravage"] = {
			["creatureType"] = "Beast",
			["level"] = 51,
		},
		["Spiteflayer"] = {
			["creatureType"] = "Beast",
			["level"] = 52,
		},
	},
	["Swamp of Sorrows"] = {
		["Fingat"] = {
			["creatureType"] = "Humanoid",
			["level"] = 43,
		},
		["Gilmorian"] = {
			["creatureType"] = "Humanoid",
			["level"] = 43,
		},
		["Jade"] = {
			["creatureType"] = "Dragon",
			["level"] = 47,
			["elite"] = 1,
		},
		["Lord Captain Wyrmak"] = {
			["creatureType"] = "Dragon",
			["level"] = 45,
			["elite"] = 1,
		},
		["Lost One Chieftain"] = {
			["creatureType"] = "Humanoid",
			["level"] = 39,
		},
		["Lost One Cook"] = {
			["creatureType"] = "Humanoid",
			["level"] = 37,
		},
		["Molt Thorn"] = {
			["creatureType"] = "Elemental",
			["level"] = 42,
		},
	},
	["The Hinterlands"] = {
		["Grimungous"] = {
			["creatureType"] = "Giant",
			["level"] = 50,
			["elite"] = 1,
		},
		["Ironback"] = {
			["creatureType"] = "Beast",
			["level"] = 51,
		},
		["Jalinde Summerdrake"] = {
			["creatureType"] = "Humanoid",
			["level"] = 49,
		},
		["Mith'rethis the Enchanter"] = {
			["creatureType"] = "Humanoid",
			["level"] = 52,
			["elite"] = 1,
		},
		["Old Cliff Jumper"] = {
			["creatureType"] = "Beast",
			["level"] = 42,
		},
		["Razortalon"] = {
			["creatureType"] = "Humanoid",
			["level"] = 44,
		},
		["Retherokk the Berserker"] = {
			["creatureType"] = "Humanoid",
			["level"] = 48,
		},
		["Witherheart the Stalker"] = {
			["creatureType"] = "Humanoid",
			["level"] = 45,
		},
		["Zul'arek Hatefowler"] = {
			["creatureType"] = "Humanoid",
			["level"] = 43,
		},
	},
	["Dun Morogh"] = {
		["Bjarn"] = {
			["creatureType"] = "Beast",
			["level"] = 12,
		},
		["Edan the Howler"] = {
			["creatureType"] = "Humanoid",
			["level"] = 9,
		},
		["Gibblewilt"] = {
			["creatureType"] = "Humanoid",
			["level"] = 11,
		},
		["Great Father Arctikus"] = {
			["creatureType"] = "Humanoid",
			["level"] = 11,
		},
		["Hammerspine"] = {
			["creatureType"] = "Humanoid",
			["level"] = 12,
		},
		["Timber"] = {
			["creatureType"] = "Beast",
			["level"] = 10,
		},
	},
	["Burning Steppes"] = {
		["Deathmaw"] = {
			["creatureType"] = "Beast",
			["level"] = 53,
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
		["Hematos"] = {
			["creatureType"] = "Dragon",
			["level"] = 60,
		},
		["Malfunctioning Reaver"] = {
			["creatureType"] = "Elemental",
			["level"] = 56,
		},
		["Terrorspark"] = {
			["creatureType"] = "Demon",
			["level"] = 55,
		},
		["Thauris Balgarr"] = {
			["creatureType"] = "Humanoid",
			["level"] = 57,
		},
		["Volchan"] = {
			["creatureType"] = "Giant",
			["level"] = 60,
		},
	},
	["Arathi Highlands"] = {
		["Darbel Montrose"] = {
			["creatureType"] = "Humanoid",
			["level"] = 39,
			["elite"] = 1,
		},
		["Foulbelly"] = {
			["creatureType"] = "Humanoid",
			["level"] = 42,
			["elite"] = 1,
		},
		["Geomancer Flintdagger"] = {
			["creatureType"] = "Humanoid",
			["level"] = 40,
		},
		["Kovork"] = {
			["creatureType"] = "Humanoid",
			["level"] = 36,
		},
		["Molok the Crusher"] = {
			["creatureType"] = "Humanoid",
			["level"] = 39,
		},
		["Nimar the Slayer"] = {
			["creatureType"] = "Humanoid",
			["level"] = 37,
		},
		["Prince Nazjak"] = {
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
	["Desolace"] = {
		["Accursed Slitherblade"] = {
			["creatureType"] = "Humanoid",
			["level"] = 35,
		},
		["Cursed Centaur"] = {
			["creatureType"] = "Humanoid",
			["level"] = 43,
		},
		["Giggler"] = {
			["creatureType"] = "Beast",
			["level"] = 34,
		},
		["Hissperak"] = {
			["creatureType"] = "Beast",
			["level"] = 37,
		},
		["Kaskk"] = {
			["creatureType"] = "Demon",
			["level"] = 40,
		},
		["Prince Kellen"] = {
			["creatureType"] = "Demon",
			["level"] = 33,
		},
		["Ravenclaw Regent"] = {
			["creatureType"] = "Undead",
			["level"] = 22,
		},
	},
	["Elwynn Forest"] = {
		["Fedfennel"] = {
			["creatureType"] = "Humanoid",
			["level"] = 12,
		},
		["Gruff Swiftbite"] = {
			["creatureType"] = "Humanoid",
			["level"] = 12,
		},
		["Morgaine the Sly"] = {
			["creatureType"] = "Humanoid",
			["level"] = 10,
		},
		["Mother Fang"] = {
			["creatureType"] = "Beast",
			["level"] = 10,
		},
		["Narg the Taskmaster"] = {
			["creatureType"] = "Humanoid",
			["level"] = 10,
		},
		["Thuros Lightfingers"] = {
			["creatureType"] = "Humanoid",
			["level"] = 11,
		},
	},
	["Stormwind City"] = {
		["Sewer Beast"] = {
			["creatureType"] = "Beast",
			["level"] = 50,
		},
	},
	["Tanaris"] = {
		["Cyclok the Mad"] = {
			["creatureType"] = "Humanoid",
			["level"] = 48,
		},
		["Greater Firebird"] = {
			["creatureType"] = "Beast",
			["level"] = 46,
		},
		["Jin'Zallah the Sandbringer"] = {
			["creatureType"] = "Humanoid",
			["level"] = 46,
			["elite"] = 1,
		},
		["Kregg Keelhaul"] = {
			["creatureType"] = "Humanoid",
			["level"] = 47,
		},
		["Murderous Blisterpaw"] = {
			["creatureType"] = "Beast",
			["level"] = 43,
		},
		["Omgorn the Lost"] = {
			["creatureType"] = "Humanoid",
			["level"] = 50,
		},
		["Warleader Krazzilak"] = {
			["creatureType"] = "Humanoid",
			["level"] = 45,
			["elite"] = 1,
		},
	},
	["Silverpine Forest"] = {
		["Dalaran Spellscribe"] = {
			["creatureType"] = "Humanoid",
			["level"] = 21,
		},
		["Gorefang"] = {
			["creatureType"] = "Beast",
			["level"] = 13,
		},
		["Krethis Shadowspinner"] = {
			["creatureType"] = "Beast",
			["level"] = 15,
		},
		["Old Vicejaw"] = {
			["creatureType"] = "Beast",
			["level"] = 14,
		},
		["Rot Hide Bruiser"] = {
			["creatureType"] = "Undead",
			["level"] = 22,
		},
		["Snarlmane"] = {
			["creatureType"] = "Undead",
			["level"] = 23,
		},
	},
	["Stonetalon Mountains"] = {
		["Brother Ravenoak"] = {
			["creatureType"] = "Humanoid",
			["level"] = 29,
			["elite"] = 1,
		},
		["Foreman Rigger"] = {
			["creatureType"] = "Humanoid",
			["level"] = 24,
			["elite"] = 1,
		},
		["Nal'taszar"] = {
			["creatureType"] = "Dragon",
			["level"] = 30,
			["elite"] = 1,
		},
		["Sentinel Amarassan"] = {
			["creatureType"] = "Humanoid",
			["level"] = 27,
			["elite"] = 1,
		},
		["Sister Riven"] = {
			["creatureType"] = "Humanoid",
			["level"] = 28,
			["elite"] = 1,
		},
		["Taskmaster Whipfang"] = {
			["creatureType"] = "Humanoid",
			["level"] = 22,
			["elite"] = 1,
		},
		["Pridewing Patriarch"] = {
			["creatureType"] = "Beast",
			["level"] = 25,
		},
		["Vengeful Ancient"] = {
			["creatureType"] = "Elemental",
			["level"] = 30,
		},
	},
	["Dustwallow Marsh"] = {
		["Brimgore"] = {
			["creatureType"] = "Dragon",
			["level"] = 45,
			["elite"] = 1,
		},
		["Burgle Eye"] = {
			["creatureType"] = "Humanoid",
			["level"] = 38,
		},
		["Darkmist Widow"] = {
			["creatureType"] = "Beast",
			["level"] = 40,
		},
		["Dart"] = {
			["creatureType"] = "Beast",
			["level"] = 38,
		},
		["Drogoth the Roamer"] = {
			["creatureType"] = "Elemental",
			["level"] = 37,
		},
		["Hayoc"] = {
			["creatureType"] = "Beast",
			["level"] = 41,
		},
		["Lord Angler"] = {
			["creatureType"] = "Humanoid",
			["level"] = 44,
		},
		["Oozeworm"] = {
			["creatureType"] = "Beast",
			["level"] = 42,
		},
		["Ripscale"] = {
			["creatureType"] = "Beast",
			["level"] = 39,
		},
	},
	["Duskwood"] = {
		["Commander Felstrom"] = {
			["creatureType"] = "Undead",
			["level"] = 32,
		},
		["Fenros"] = {
			["creatureType"] = "Humanoid",
			["level"] = 32,
		},
		["Lord Malathrom"] = {
			["creatureType"] = "Undead",
			["level"] = 31,
		},
		["Lupos"] = {
			["creatureType"] = "Beast",
			["level"] = 23,
		},
		["Naraxis"] = {
			["creatureType"] = "Beast",
			["level"] = 27,
		},
		["Nefaru"] = {
			["creatureType"] = "Humanoid",
			["level"] = 34,
		},
	},
	["Felwood"] = {
		["Alshirr Banebreath"] = {
			["creatureType"] = "Demon",
			["level"] = 54,
		},
		["Death Howl"] = {
			["creatureType"] = "Beast",
			["level"] = 49,
		},
		["Dessecus"] = {
			["creatureType"] = "Elemental",
			["level"] = 56,
		},
		["Immolatus"] = {
			["creatureType"] = "Demon",
			["level"] = 56,
		},
		["Mongress"] = {
			["creatureType"] = "Beast",
			["level"] = 50,
		},
		["Olm the Wise"] = {
			["creatureType"] = "Beast",
			["level"] = 52,
		},
		["Ragepaw"] = {
			["creatureType"] = "Humanoid",
			["level"] = 51,
		},
	},
	["Eastern Plaguelands"] = {
		["Deathspeaker Selendre"] = {
			["creatureType"] = "Humanoid",
			["level"] = 56,
		},
		["Duggan Wildhammer"] = {
			["creatureType"] = "Humanoid",
			["level"] = 55,
		},
		["Gish the Unmoving"] = {
			["creatureType"] = "Undead",
			["level"] = 56,
		},
		["Hed'mush the Rotting"] = {
			["creatureType"] = "Undead",
			["level"] = 57,
		},
		["High General Abbendis"] = {
			["creatureType"] = "Humanoid",
			["level"] = 59,
			["elite"] = 1,
		},
		["Lord Darkscythe"] = {
			["creatureType"] = "Undead",
			["level"] = 57,
		},
		["Ranger Lord Hawkspear"] = {
			["creatureType"] = "Humanoid",
			["level"] = 60,
		},
		["Warlord Thresh'jin"] = {
			["creatureType"] = "Humanoid",
			["level"] = 58,
		},
		["Zul'Brin Warpbranch"] = {
			["creatureType"] = "Humanoid",
			["level"] = 59,
		},
	},
	["Winterspring"] = {
		["Azurous"] = {
			["creatureType"] = "Dragon",
			["level"] = 59,
			["elite"] = 1,
		},
		["General Colbatann"] = {
			["creatureType"] = "Dragon",
			["level"] = 57,
			["elite"] = 1,
		},
		["Grizzle Snowpaw"] = {
			["creatureType"] = "Humanoid",
			["level"] = 59,
		},
		["Kashoch the Reaver"] = {
			["creatureType"] = "Giant",
			["level"] = 60,
			["elite"] = 1,
		},
		["Mezzir the Howler"] = {
			["creatureType"] = "Humanoid",
			["level"] = 55,
		},
		["Rak'shiri"] = {
			["creatureType"] = "Beast",
			["level"] = 57,
		},
	},
	["Feralas"] = {
		["Antilus the Soarer"] = {
			["creatureType"] = "Beast",
			["level"] = 48,
		},
		["Arash-ethis"] = {
			["creatureType"] = "Beast",
			["level"] = 49,
		},
		["Bloodroar the Stalker"] = {
			["creatureType"] = "Humanoid",
			["level"] = 48,
		},
		["Diamond Head"] = {
			["creatureType"] = "Humanoid",
			["level"] = 45,
		},
		["Gnarl Leafbrother"] = {
			["creatureType"] = "Elemental",
			["level"] = 44,
		},
		["Lady Szallah"] = {
			["creatureType"] = "Humanoid",
			["level"] = 46,
		},
		["Old Grizzlegut"] = {
			["creatureType"] = "Beast",
			["level"] = 43,
		},
		["Qirot"] = {
			["subZone"] = "The Writhing Deep",
			["zone"] = "Feralas",
			["creatureType"] = "Silithid",
			["level"] = 47,
		},
		["Snarler"] = {
			["creatureType"] = "Beast",
			["level"] = 42,
		},
	},
	["Stranglethorn Vale"] = {
		["Gluggle"] = {
			["creatureType"] = "Humanoid",
			["level"] = 37,
		},
		["Kurmokk"] = {
			["creatureType"] = "Beast",
			["level"] = 42,
		},
		["Lord Sakrasis"] = {
			["creatureType"] = "Humanoid",
			["level"] = 47,
		},
		["Mosh'Ogg Butcher"] = {
			["creatureType"] = "Humanoid",
			["level"] = 44,
			["elite"] = 1,
		},
		["Rippa"] = {
			["creatureType"] = "Beast",
			["level"] = 44,
		},
		["Roloch"] = {
			["creatureType"] = "Humanoid",
			["level"] = 38,
		},
		["Scale Belly"] = {
			["creatureType"] = "Beast",
			["level"] = 45,
		},
		["Verifonix"] = {
			["creatureType"] = "Humanoid",
			["level"] = 42,
		},
	},
	["Wetlands"] = {
		["Dragonmaw Battlemaster"] = {
			["creatureType"] = "Humanoid",
			["level"] = 30,
		},
		["Garneg Charskull"] = {
			["creatureType"] = "Humanoid",
			["level"] = 29,
		},
		["Gnawbone"] = {
			["creatureType"] = "Humanoid",
			["level"] = 24,
		},
		["Leech Widow"] = {
			["creatureType"] = "Beast",
			["level"] = 24,
		},
		["Ma'ruk Wyrmscale"] = {
			["creatureType"] = "Humanoid",
			["level"] = 23,
		},
		["Mirelow"] = {
			["creatureType"] = "Elemental",
			["level"] = 25,
		},
		["Razormaw Matriarch"] = {
			["creatureType"] = "Beast",
			["level"] = 31,
		},
	},
	["Durotar"] = {
		["Death Flayer"] = {
			["creatureType"] = "Beast",
			["level"] = 11,
		},
		["Captain Flat Tusk"] = {
			["creatureType"] = "Humanoid",
			["level"] = 11,
			["elite"] = 1,
		},
		["Felweaver Scornn"] = {
			["creatureType"] = "Humanoid",
			["level"] = 11,
			["elite"] = 1,
		},
		["Geolord Mottle"] = {
			["creatureType"] = "Humanoid",
			["level"] = 9,
		},
		["Warlord Kolkanis"] = {
			["creatureType"] = "Humanoid",
			["level"] = 9,
		},
		["Watch Commander Zalaphil"] = {
			["creatureType"] = "Humanoid",
			["level"] = 9,
		},
	},
	["Thousand Needles"] = {
		["Achellios the Banished"] = {
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
		["Heartrazor"] = {
			["creatureType"] = "Beast",
			["level"] = 32,
		},
		["Ironeye the Invincible"] = {
			["creatureType"] = "Beast",
			["level"] = 37,
		},
		["Vile Sting"] = {
			["creatureType"] = "Beast",
			["level"] = 35,
		},
	},
	["Redridge Mountains"] = {
		["Boulderheart"] = {
			["creatureType"] = "Giant",
			["level"] = 25,
		},
		["Chatter"] = {
			["creatureType"] = "Beast",
			["level"] = 23,
		},
		["Kazon"] = {
			["creatureType"] = "Humanoid",
			["level"] = 27,
		},
		["Ribchaser"] = {
			["creatureType"] = "Humanoid",
			["level"] = 17,
		},
		["Rohh the Silent"] = {
			["creatureType"] = "Humanoid",
			["level"] = 26,
		},
		["Seeker Aqualon"] = {
			["creatureType"] = "Elemental",
			["level"] = 21,
		},
		["Snarlflare"] = {
			["creatureType"] = "Dragon",
			["level"] = 18,
		},
		["Squiddic"] = {
			["creatureType"] = "Humanoid",
			["level"] = 19,
		},
	},
	["Western Plaguelands"] = {
		["Foreman Jerris"] = {
			["creatureType"] = "Humanoid",
			["level"] = 62,
			["elite"] = 1,
			["subZone"] = "Hearthglen",
		},
		["Foreman Marcrid"] = {
			["creatureType"] = "Humanoid",
			["level"] = 58,
		},
		["Foulmane"] = {
			["creatureType"] = "Undead",
			["level"] = 52,
		},
		["Lord Maldazzar"] = {
			["creatureType"] = "Humanoid",
			["level"] = 56,
		},
		["Putridius"] = {
			["creatureType"] = "Undead",
			["level"] = 58,
			["elite"] = 1,
		},
		["Scarlet Executioner"] = {
			["creatureType"] = "Humanoid",
			["level"] = 60,
			["elite"] = 1,
			["subZone"] = "Hearthglen",
		},
		["Scarlet High Clerist"] = {
			["creatureType"] = "Humanoid",
			["level"] = 63,
			["elite"] = 1,
		},
		["Scarlet Interrogator"] = {
			["creatureType"] = "Humanoid",
			["level"] = 61,
			["elite"] = 1,
			["subZone"] = "Hearthglen",
		},
		["Scarlet Judge"] = {
			["creatureType"] = "Humanoid",
			["level"] = 60,
		},
		["Scarlet Smith"] = {
			["creatureType"] = "Humanoid",
			["level"] = 59,
			["elite"] = 1,
			["subZone"] = "Hearthglen",
		},
		["The Husk"] = {
			["creatureType"] = "Elemental",
			["level"] = 62,
		},
	},
	["Loch Modan"] = {
		["Boss Galgosh"] = {
			["creatureType"] = "Humanoid",
			["level"] = 22,
		},
		["Emogg the Crusher"] = {
			["creatureType"] = "Humanoid",
			["level"] = 19,
			["elite"] = 1,
		},
		["Grizlak"] = {
			["creatureType"] = "Humanoid",
			["level"] = 15,
		},
		["Large Loch Crocolisk"] = {
			["creatureType"] = "Beast",
			["level"] = 23,
		},
		["Lord Condar"] = {
			["creatureType"] = "Beast",
			["level"] = 16,
		},
		["Magosh"] = {
			["creatureType"] = "Humanoid",
			["level"] = 21,
		},
		["Shanda the Spinner"] = {
			["creatureType"] = "Beast",
			["level"] = 19,
		},
	},
	["Badlands"] = {
		["7:XT"] = {
			["creatureType"] = "Mechanical",
			["level"] = 41,
		},
		["Anathemus"] = {
			["creatureType"] = "Giant",
			["level"] = 45,
			["elite"] = 1,
		},
		["Broken Tooth"] = {
			["creatureType"] = "Beast",
			["level"] = 37,
		},
		["Rumbler"] = {
			["creatureType"] = "Elemental",
			["level"] = 45,
		},
		["Shadowforge Commander"] = {
			["creatureType"] = "Humanoid",
			["level"] = 40,
		},
		["War Golem"] = {
			["creatureType"] = "Elemental",
			["level"] = 36,
		},
		["Siege Golem"] = {
			["creatureType"] = "Elemental",
			["level"] = 40,
			["elite"] = 1,
		},
		["Zaricotl"] = {
			["elite"] = 1,
			["creatureType"] = "Beast",
			["level"] = 55,
		},
	},
	["The Barrens"] = {
		["Ambassador Bloodrage"] = {
			["creatureType"] = "Undead",
			["level"] = 36,
			["elite"] = 1,
		},
		["Azzere the Skyblade"] = {
			["creatureType"] = "Beast",
			["level"] = 25,
		},
		["Brokespear"] = {
			["creatureType"] = "Humanoid",
			["level"] = 17,
		},
		["Brontus"] = {
			["creatureType"] = "Beast",
			["level"] = 27,
			["elite"] = 1,
		},
		["Captain Gerogg Hammertoe"] = {
			["creatureType"] = "Humanoid",
			["level"] = 27,
			["elite"] = 1,
		},
		["Digger Flameforge"] = {
			["creatureType"] = "Humanoid",
			["level"] = 24,
		},
		["Dishu"] = {
			["creatureType"] = "Beast",
			["level"] = 13,
		},
		["Elder Mystic Razorsnout"] = {
			["creatureType"] = "Humanoid",
			["level"] = 15,
			["elite"] = 1,
		},
		["Engineer Whirleygig"] = {
			["creatureType"] = "Humanoid",
			["level"] = 19,
		},
		["Foreman Grills"] = {
			["creatureType"] = "Humanoid",
			["level"] = 19,
		},
		["Geopriest Gukk'rok"] = {
			["creatureType"] = "Humanoid",
			["level"] = 19,
		},
		["Gesharahan"] = {
			["creatureType"] = "Hydra",
			["level"] = 20,
			["elite"] = 1,
		},
		["Hagg Taurenbane"] = {
			["creatureType"] = "Humanoid",
			["level"] = 26,
			["elite"] = 1,
		},
		["Heggin Stonewhisker"] = {
			["creatureType"] = "Humanoid",
			["level"] = 24,
		},
		["Humar the Pridelord"] = {
			["creatureType"] = "Beast",
			["level"] = 23,
			["elite"] = 1,
		},
		["Malgin Barleybrew"] = {
			["creatureType"] = "Humanoid",
			["level"] = 25,
		},
		["Rathorian"] = {
			["creatureType"] = "Demon",
			["level"] = 15,
		},
		["Rocklance"] = {
			["creatureType"] = "Humanoid",
			["level"] = 17,
			["elite"] = 1,
		},
		["Sister Rathtalon"] = {
			["creatureType"] = "Humanoid",
			["level"] = 19,
			["elite"] = 1,
		},
		["Sludge Beast"] = {
			["creatureType"] = "Slime",
			["level"] = 19,
		},
		["Snort the Heckler"] = {
			["creatureType"] = "Beast",
			["level"] = 17,
		},
		["Stonearm"] = {
			["creatureType"] = "Humanoid",
			["level"] = 15,
		},
		["Swiftmane"] = {
			["creatureType"] = "Beast",
			["level"] = 21,
			["elite"] = 1,
		},
		["Swinegart Spearhide"] = {
			["creatureType"] = "Humanoid",
			["level"] = 22,
			["elite"] = 1,
		},
		["Takk the Leaper"] = {
			["creatureType"] = "Beast",
			["level"] = 19,
			["elite"] = 1,
		},
		["Thunderstomp"] = {
			["creatureType"] = "Beast",
			["level"] = 24,
		},
	},
	["Tirisfal Glades"] = {
		["Bayne"] = {
			["creatureType"] = "Demon",
			["level"] = 10,
		},
		["Deeb"] = {
			["creatureType"] = "Humanoid",
			["level"] = 12,
		},
		["Farmer Solliden"] = {
			["creatureType"] = "Humanoid",
			["level"] = 8,
		},
		["Fellicent's Shade"] = {
			["creatureType"] = "Undead",
			["level"] = 12,
		},
		["Lost Soul"] = {
			["creatureType"] = "Undead",
			["level"] = 7,
		},
		["Muad"] = {
			["creatureType"] = "Humanoid",
			["level"] = 10,
		},
		["Ressan the Needler"] = {
			["creatureType"] = "Beast",
			["level"] = 11,
		},
		["Sri'skulk"] = {
			["creatureType"] = "Beast",
			["level"] = 13,
		},
		["Tormented Spirit"] = {
			["creatureType"] = "Undead",
			["level"] = 9,
		},
	},
	["Ashenvale"] = {
		["Akkrilus"] = {
			["creatureType"] = "Demon",
			["level"] = 26,
		},
		["Apothecary Falthis"] = {
			["creatureType"] = "Humanoid",
			["level"] = 22,
		},
		["Branch Snapper"] = {
			["creatureType"] = "Elemental",
			["level"] = 25,
		},
		["Eck'alom"] = {
			["creatureType"] = "Elemental",
			["level"] = 27,
		},
		["Lady Vespia"] = {
			["creatureType"] = "Humanoid",
			["level"] = 22,
		},
		["Mist Howler"] = {
			["creatureType"] = "Beast",
			["level"] = 22,
		},
		["Mugglefin"] = {
			["creatureType"] = "Humanoid",
			["level"] = 23,
		},
		["Oakpaw"] = {
			["creatureType"] = "Humanoid",
			["level"] = 27,
		},
		["Prince Raze"] = {
			["creatureType"] = "Demon",
			["level"] = 32,
		},
		["Rorgish Jowl"] = {
			["creatureType"] = "Humanoid",
			["level"] = 25,
		},
		["Terrowulf Packlord"] = {
			["creatureType"] = "Humanoid",
			["level"] = 32,
		},
		["Ursol'lok"] = {
			["creatureType"] = "Beast",
			["level"] = 31,
		},
	},
	["Azshara"] = {
		["Antilos"] = {
			["creatureType"] = "Beast",
			["level"] = 50,
		},
		["Gatekeeper Rageroar"] = {
			["creatureType"] = "Humanoid",
			["level"] = 50,
		},
		["General Fangferror"] = {
			["creatureType"] = "Humanoid",
			["level"] = 51,
		},
		["Lady Sesspira"] = {
			["creatureType"] = "Humanoid",
			["level"] = 51,
		},
		["Magister Hawkhelm"] = {
			["creatureType"] = "Humanoid",
			["level"] = 52,
		},
		["Master Feardred"] = {
			["creatureType"] = "Demon",
			["level"] = 52,
		},
		["Monnos the Elder"] = {
			["creatureType"] = "Giant",
			["level"] = 54,
			["elite"] = 1,
		},
		["Scalebeard"] = {
			["creatureType"] = "Beast",
			["level"] = 52,
			["elite"] = 1,
		},
		["The Evalcharr"] = {
			["creatureType"] = "Beast",
			["level"] = 48,
		},
		["Varo'then's Ghost"] = {
			["creatureType"] = "Undead",
			["level"] = 48,
		},
	},
	["Westfall"] = {
		["Brack"] = {
			["creatureType"] = "Humanoid",
			["level"] = 19,
		},
		["Foe Reaper 4000"] = {
			["creatureType"] = "Mechanical",
			["level"] = 20,
		},
		["Leprithus"] = {
			["creatureType"] = "Undead",
			["level"] = 19,
		},
		["Master Digger"] = {
			["creatureType"] = "Humanoid",
			["level"] = 15,
		},
		["Sergeant Brashclaw"] = {
			["creatureType"] = "Humanoid",
			["level"] = 18,
		},
		["Slark"] = {
			["creatureType"] = "Humanoid",
			["level"] = 15,
		},
		["Vultros"] = {
			["creatureType"] = "Beast",
			["level"] = 26,
		},
	},
	["Teldrassil"] = {
		["Blackmoss the Fetid"] = {
			["creatureType"] = "Elemental",
			["level"] = 13,
		},
		["Duskstalker"] = {
			["creatureType"] = "Beast",
			["level"] = 9,
		},
		["Fury Shelda"] = {
			["creatureType"] = "Humanoid",
			["level"] = 8,
		},
		["Grimmaw"] = {
			["creatureType"] = "Humanoid",
			["level"] = 11,
		},
		["Threggil"] = {
			["creatureType"] = "Demon",
			["level"] = 6,
		},
		["Uruson"] = {
			["creatureType"] = "Humanoid",
			["level"] = 7,
		},
	},
	["Silithus"] = {
		["Gretheer"] = {
			["creatureType"] = "Beast",
			["level"] = 57,
		},
		["Grubthor"] = {
			["creatureType"] = "Beast",
			["level"] = 58,
		},
		["Huricanian"] = {
			["creatureType"] = "Elemental",
			["level"] = 58,
		},
		["Krellack"] = {
			["creatureType"] = "Beast",
			["level"] = 56,
		},
		["Lapress"] = {
			["creatureType"] = "Silithid",
			["level"] = 60,
			["elite"] = 1,
		},
		["Rex Ashil"] = {
			["creatureType"] = "Silithid",
			["level"] = 57,
			["elite"] = 1,
		},
		["Setis"] = {
			["creatureType"] = "Humanoid",
			["level"] = 61,
			["elite"] = 1,
		},
		["Twilight Lord Everun"] = {
			["creatureType"] = "Humanoid",
			["level"] = 60,
		},
		["Zora"] = {
			["creatureType"] = "Silithid",
			["level"] = 59,
			["elite"] = 1,
		},
	},
	["Blackrock Depths"] = { 
		["Lord Roccor"] = {
			["creatureType"] = "Elemental",
			["level"] = 51,
			["elite"] = 1,
		},
		["Panzor the Invincible"] = {
			["creatureType"] = "Elemental",
			["level"] = 57,
			["elite"] = 1,
		},
		["Pyromancer Loregrain"] = {
			["creatureType"] = "Humanoid",
			["level"] = 52,
			["elite"] = 1,
		},
		["Verek"] = {
			["creatureType"] = "Demon",
			["level"] = 55,
			["elite"] = 1,
		},
		["Warder Stilgiss"] = {
			["creatureType"] = "Humanoid",
			["level"] = 56,
			["elite"] = 1,
		},
	},
	["Blackrock Mountain"] = {
		["The Behemoth"] = {
			["creatureType"] = "Humanoid",
			["level"] = 50,
			["elite"] = 1,
		},
	},
	["Blackrock Spire"] = { -- need to verify area names (perhaps some should be listed as "Hall of Blackhand")
		["Bannok Grimaxe"] = {
			["creatureType"] = "Humanoid",
			["level"] = 59,
			["elite"] = 1,
		},
		["Burning Felguard"] = {
			["creatureType"] = "Demon",
			["level"] = 57,
			["elite"] = 1,
		},
		["Crystal Fang"] = {
			["creatureType"] = "Beast",
			["level"] = 60,
			["elite"] = 1,
		},
		["Ghok Bashguud"] = {
			["creatureType"] = "Humanoid",
			["level"] = 59,
			["elite"] = 1,
		},
		["Jed Runewatcher"] = {
			["creatureType"] = "Humanoid",
			["level"] = 59,
			["elite"] = 1,
		},
		["Quartermaster Zigris"] = {
			["creatureType"] = "Humanoid",
			["level"] = 59,
			["elite"] = 1,
		},
		["Spirestone Battle Lord"] = {
			["creatureType"] = "Humanoid",
			["level"] = 58,
			["elite"] = 1,
		},
		["Spirestone Butcher"] = {
			["creatureType"] = "Humanoid",
			["level"] = 57,
			["elite"] = 1,
		},
		["Spirestone Lord Magus"] = {
			["creatureType"] = "Humanoid",
			["level"] = 58,
			["elite"] = 1,
		},
		["Urok Doomhowl"] = {
			["creatureType"] = "Humanoid",
			["level"] = 60,
			["elite"] = 1,
		},
	},
	["Dire Maul"] = {
		["Mushgog"] = {
			["creatureType"] = "Elemental",
			["level"] = 60,
			["elite"] = 1,
		},
		["Skarr the Unbreakable"] = {
			["creatureType"] = "Humanoid",
			["level"] = 58,
			["elite"] = 1,
		},
		["The Razza"] = {
			["creatureType"] = "Beast",
			["level"] = 60,
			["elite"] = 1,
		},
	},
	["Gnomeregan"] = { 
		["Dark Iron Ambassador"] = {
			["creatureType"] = "Humanoid",
			["level"] = 33,
			["elite"] = 1,
		},
	},
	["Maraudon"] = { 
		["Meshlok the Harvester"] = {
			["creatureType"] = "Elemental",
			["level"] = 48,
			["elite"] = 1,
		},
	},
	["Razorfen Kraul"] = { 
		["Blind Hunter"] = {
			["creatureType"] = "Beast",
			["level"] = 32,
			["elite"] = 1,
		},
		["Earthcaller Halmgar"] = {
			["creatureType"] = "Humanoid",
			["level"] = 32,
			["elite"] = 1,
		},
	},
	["Scarlet Monastery"] = { 
		["Azshir the Sleepless"] = {
			["creatureType"] = "Undead",
			["level"] = 33,
			["elite"] = 1,
		},
		["Fallen Champion"] = {
			["creatureType"] = "Undead",
			["level"] = 33,
			["elite"] = 1,
		},
		["Ironspine"] = {
			["creatureType"] = "Undead",
			["level"] = 33,
			["elite"] = 1,
		},
	},
	["Shadowfang Keep"] = { 
		["Deathsworn Captain"] = {
			["creatureType"] = "Undead",
			["level"] = 25,
			["elite"] = 1,
		},
	},
	["The Stockade"] = { 
		["Bruegal Ironknuckle"] = {
			["creatureType"] = "Humanoid",
			["level"] = 26,
			["elite"] = 1,
		},
	},
	["Stratholme"] = { 
		["Hearthsinger Forresten"] = {
			["creatureType"] = "Undead",
			["level"] = 57,
			["elite"] = 1,
		},
		["Skul"] = {
			["creatureType"] = "Undead",
			["level"] = 58,
			["elite"] = 1,
		},
		["Stonespine"] = {
			["creatureType"] = "Undead",
			["level"] = 60,
			["elite"] = 1,
		},
		["Timmy the Cruel"] = {
			["creatureType"] = "Undead",
			["level"] = 58,
			["elite"] = 1,
		},
	},
	["The Deadmines"] = { 
		["Brainwashed Noble"] = {
			["creatureType"] = "Humanoid",
			["level"] = 18,
			["elite"] = 1,
		},
		["Edwin VanCleef"] = {
			["disabled"] = true, -- game reports this guy as rare
			["elite"] = 1,
			["creatureType"] = "Humanoid",
			["level"] = 21,
		},
		["Marisa du'Paige"] = {
			["creatureType"] = "Humanoid",
			["level"] = 18,
			["elite"] = 1,
		},
		["Miner Johnson"] = {
			["creatureType"] = "Humanoid",
			["level"] = 18,
			["elite"] = 1,
		},
	},
	["The Temple of Atal'Hakkar"] = { 
		["Veyzhak the Cannibal"] = {
			["creatureType"] = "Humanoid",
			["level"] = 48,
			["elite"] = 1,
		},
		["Zekkis"] = {
			["creatureType"] = "Undead",
			["level"] = 38,
			["elite"] = 1,
		},
	},
	["Wailing Caverns"] = { 
		["Boahn"] = {
			["creatureType"] = "Humanoid",
			["level"] = 20,
			["elite"] = 1,
		},
		["Deviate Faerie Dragon"] = {
			["creatureType"] = "Dragon",
			["level"] = 20,
			["elite"] = 1,
		},
		["Trigore the Lasher"] = {
			["creatureType"] = "Hydra",
			["level"] = 19,
			["elite"] = 1,
		},
	},
	["Uldaman"] = { 
		["Digmaster Shovelphlange"] = {
			["creatureType"] = "Humanoid",
			["level"] = 38,
			["elite"] = 1,
		},
	},
	["Zul'Farrak"] = { 
		["Zerillis"] = {
			["creatureType"] = "Humanoid",
			["level"] = 45,
			["elite"] = 1,
		},
	},
}