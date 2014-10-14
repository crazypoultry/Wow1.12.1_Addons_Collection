if ( GetLocale() == "deDE" ) then

-- ä = \195\164 (z.B. Jäger = J\195\164ger)
-- Ä = \195\132 (z.B. Ärger = \195\132rger)
-- ö = \195\182 (z.B. schön = sch\195\182n)
-- Ö = \195\150 (z.B. Ödipus = \195\150dipus)
-- ü = \195\188 (z.B. Rüstung = R\195\188stung)
-- Ü = \195\156 (z.B. Übung = \195\156bung)
-- ß = \195\159 (z.B. Straße = Stra\195\159e)
--=====================================================================--
-- RANDOM INSULTS
-- "Ihr [1] [2] [3]."
-- "Ihr [bad] [pile of] [material]."

-- NOTE: Unlike other random phrases, every RP trait may be used in each insult.
-- Example:  "Ihr [1](WARRIOR) [2](ANY) [3](GNOME)."

-- This file & format will likely change in the future.
-- ä = \195\164 (z.B. Jäger = J\195\164ger) 
-- Ä = \195\132 (z.B. Ärger = \195\132rger) 
-- ö = \195\182 (z.B. schön = sch\195\182n) 
-- Ö = \195\150 (z.B. Ödipus = \195\150dipus) 
-- ü = \195\188 (z.B. Rüstung = R\195\188stung) 
-- Ü = \195\156 (z.B. Übung = \195\156bung) 
-- ß = \195\159 (z.B. Straße = Stra\195\159e) 
--=====================================================================--

RPWORDLIST.randominsult.YOU = "Du"

RPWORDLIST.randominsult.ANY = {

	[1] = {"hirnloser", "schleimiger", "vorlauter", "dreckiger", "garstiger", "lachhafter", "dummer", "trauriger", "nutzloser", "peinlicher", "lachhafter", "witzloser", "unf\195\164higer", "l\195\164cherlicher", "bl\195\182der", "plumper", "klumpf\195\188ssiger", "hirnloser", "mutterloser", "ehrloser", },

	[2] = {"Dummbeutel", "Wurm", "Idiot", "Dreckhaufen", "Lump", "Knittel", "Depp", "Dummschw\195\164tzer", "Trottel", "Taugenichts", "Volltrottel", "Narr", "Neunmalkluger", "Nichtsnutz", "Niemand", "Ochsentreiber", },

	[3] = {" voller Fl\195\182he!", " habt nun nichts mehr zu lachen!", " seid nichts weiter als ein Witz!", " mit Kretze im Gesicht!",  " seid nun verdammt!", " habt die l\195\164ngste Zeit gelebt!", " seid mein Opfer!", " seid nun verdammt!", " werdet nun das zeitliche segnen!", " werdet nun sterben!", " werdet nun zur H\195\182lle fahren!", " sterben sollt ihr!", " tretet eurem Sch\195\182pfer entgegen!", },
	}
-------------------------------------------------------------------------
-- Alliance
-------------------------------------------------------------------------
RPWORDLIST.randominsult.DWARF = {

	[1] = {"bescheuerter", },

	[2] = {"Schw\195\164chling", "Spucknapf", "Spinner", "Fuzzi", "Gest\195\182rter", "Giftzwerg", "Jammerlappen", "Kindskopf", "Qu\195\164lgeist", "Querkopf", "Saudepp", "Schmierlappen", },

	[3] = {" werdet noch sehen was ein Zwerg austeilen kann!", " habt keine Chance gegen Zwerge!",  " seid wirklich so naiv sich mit einem Zwerg anzulegen?", },
	}
RPWORDLIST.randominsult.GNOME = {

	[1] = {"st\195\188mperhafter", "ungeschickter", "unbeholfener", },

	[2] = {"Strohkopf", "Saftkopf", "Banause", "Empork\195\182mmling", "Esel", "Finsterling", "Hohlkopf", "Holzkopf", "Primitivling", "Rotzbengel", "R\195\188pel", },

	[3] = {" seit zwar recht gro\195\159 aber denoch schnell besiegt!", " solltet euch von Gnomen fernhalten!", },
	}
RPWORDLIST.randominsult.HUMAN = {

	[1] = {"st\195\188mperhafter", "anmassender", },

	[2] = {"Saftsack", "Aasgeier", "Clown", "Dorftrottel", "Gr\195\188nschnabel", "Ignorant", "Irrer", "Knirps", "Maulheld", "Mistk\195\164fer", "Pechvogel", },

	[3] = {" habt euch mit dem Falschen angelegt!", " haltet euch wohl f\195\188r stark aber ich werde euch lehren was wahre St\195\164rke ist!", },
	}
RPWORDLIST.randominsult.NIGHTELF = {

	[1] = {"trotteliger", "unselbst\195\164ndiger", "tr\195\164ger", },

	[2] = {"Stinkefisch", "Barbar", "Bl\195\182dmann", "Eierkopf", "Fettsack", "Lumpensack", "Minderwertiger", "Mops", "Mutant", "Packesel", "Primat", },
	
	[3] = {" habt in k\195\188rze kein Leben mehr in euch!", },
	}
-------------------------------------------------------------------------
-- Horde
-------------------------------------------------------------------------
RPWORDLIST.randominsult.ORC = {

	[1] = {"kleiner", },

	[2] = {"Saftsack", "Wicht", "Fuzzi", "Irrer", "Jammerlappen", "Knirps", "Lumpensack", "Maulheld", "Packesel", "Pechvogel", "Schmierlappen", "Schw\195\164chling", },

	[3] = {" werdet gleich eure Knochen brechen h\195\182ren!", " werdet unvorstellbare Schmerzen erleiden!", " habt keine Chance!", " werdet euch nie wieder einen Ork in den Weg stellen!", " werdet gleich sehen was mit jemanden passiert der sich einen Ork in den Weg stellt!", },
	}
RPWORDLIST.randominsult.TAUREN = {

	[1] = {"seltsamer", "undisziplinierter", },

	[2] = {"R\195\188pel", "Saftkopf", "Qu\195\164lgeist", "St\195\188mper", "B\195\188ffelj\195\164ger", "Gest\195\182rter", "Giftzwerg", "Mops", "Mutant", "Primat", },
	
	[3] = {" habt euch mit den falschen Tauren angelegt!", " seid wirklich so naiv sich mit einem Tauren anzulegen?", " seid keines Tauren w\195\188rdig!", },
	}
RPWORDLIST.randominsult.TROLL = {

	[1] = {"trotteliger", },

	[2] = {"Spucknapf", "Stinkefisch", "Saudepp", "Amateur", "Fettsack", "Ignorant", "Kindskopf", "Mistk\195\164fer", "Querkopf", "Rotzbengel", },

	[3] = {" seid mir v\195\182llig unterlegen!", " habt gegen keinen Troll eine Chance!", " solltet euch von Trollen fernhalten!", },
	}
RPWORDLIST.randominsult.UNDEAD = {

	[1] = {"mieser", "begriffsstutziger", "idiotischerer", },

	[2] = {"Strohkopf", "Primitivling", "T\195\182lpel", "Lebender", "Bauernt\195\182lpel", "Esel", "Gr\195\188nschnabel", "Hohlkopf", "Holzkopf", "Minderwertiger", },

	[3] = {" bekommt euren Todeswunsch erf\195\188llt!", " werdet in kurzer Zeit das Zeitliche segnen!", " werdet an euren Verletzungen zu Grunde gehen!", " werdet  bestimmt ein fabelhafter Untoter sein!", " werdet ziemlich kalt sein!", " werdet alsbald im sterben liegen!", },
	}
-------------------------------------------------------------------------
-- Classes
-------------------------------------------------------------------------
RPWORDLIST.randominsult.DRUID = {

	[1] = {},

	[2] = {},

	[3] = {},

	}
RPWORDLIST.randominsult.HUNTER = {

	[1] = {},

	[2] = {},

	[3] = {},

	}
RPWORDLIST.randominsult.MAGE = {

	[1] = {},

	[2] = {},

	[3] = {},

	}
RPWORDLIST.randominsult.PALADIN = {

	[1] = {},

	[2] = {},

	[3] = {},

	}
RPWORDLIST.randominsult.PRIEST = {

	[1] = {},

	[2] = {},

	[3] = {},

	}
RPWORDLIST.randominsult.ROGUE = {

	[1] = {},

	[2] = {},

	[3] = {},

	}
RPWORDLIST.randominsult.SHAMAN = {

	[1] = {},

	[2] = {},

	[3] = {},

	}
RPWORDLIST.randominsult.WARLOCK = {

	[1] = {},

	[2] = {},

	[3] = {},

	}
RPWORDLIST.randominsult.WARRIOR = {

	[1] = {},

	[2] = {},

	[3] = {},

	}

end