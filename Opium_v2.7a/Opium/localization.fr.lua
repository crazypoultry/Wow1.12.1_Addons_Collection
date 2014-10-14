if( GetLocale() == "frFR" ) then

-- Traduction par vjeux
	-- é: C3 A9  - \195\169
	-- ê: C3 AA  - \195\170
	-- à: C3 A0  - \195\160
	-- î: C3 AE  - \195\174
	-- è: C3 A8  - \195\168
	-- ë: C3 AB  - \195\171
	-- ô: C3 B4  - \195\180
	-- û: C3 BB  - \195\187
	-- â: C3 A2  - \195\162
	-- ç: C3 A7  - \185\167
	-- 
	-- ': E2 80 99  - \226\128\153

opiumDeathString = " meurt.";
opiumDuelString = "(.+) a triomph\195\169 de (.+) dans un duel";

opiumYourDamageMatch = {
    	

	-- Your damage or healing
	{ pattern = "Votre (.+) inflige (%d+) de d\195\169gats a (.+)", spell = 0, mob = 2, pts = 1 },
	{ pattern = "Votre (.+) inflige un coup critique de (%d+) d\195\169gats a (.+)", spell = 0, mob = 2, pts = 1 },
	{ pattern = "Vous retirez (%d+) (.+) a (.+)", mob = 2, pts = 0, stat = 1 },
	{ pattern = "Votre (.+) inflige a (.+) (%d+) de d\195\169gats", spell = 0, mob = 1, pts = 2 },
	{ pattern = "Vous renvoyez (%d+) de d\195\169gats de type (.+) a (.+)", mob = 2, pts = 0, type = 1 },
	{ pattern = "(.+) subit (%d+) de d\195\169gats de type (.+) suite a votre (.+)", spell = 3, mob = 0, 
                                                                 pts = 1, type = 2 },
	{ pattern = "Vous infligez a (.+) (%d+) de d\195\169gats", mob = 0, pts = 1 },
	{ pattern = "Vous infligez un coup critique de (%d+) a (.+) ", mob = 0, pts = 1 }
};

opiumDamageToYouMatch = {
	{ pattern = "(.+) vous inflige (%d+) de d\195\169gats avec (.+)", spell = 2, pts = 1, cause = 0 },
	{ pattern = "(.+) vous inflige un coup critique de (%d+) avec (.+)", spell = 2, pts = 1, cause = 0 },
	{ pattern = "(.+) vous retire (%d+) (.+)", pts = 1, stat = 2, cause = 0 },
	{ pattern = "(.+) vous inflige (%d+) de d\195\169gats avec (.+)", spell = 2, pts = 1, cause = 0 },
	{ pattern = "(.+) vous renvoie (%d+) de d\195\169gats de type (.+)", pts = 1, type = 2, cause = 0 },
	{ pattern = "Vous subissez (%d+) d\195\169gats de type (.+) de (.+) avec (.+)", spell = 3, pts = 0, 
                                                                 type = 1, cause = 2 },
	{ pattern = "(.+) vous inflige (%d+) de d\195\169gats", pts = 1, cause = 0 },
	{ pattern = "(.+) vous inflige un coup critique de (%d+)", pts = 1, cause = 0 }
};


   OPIUM_RACEINDEX = { };
   OPIUM_CLASSINDEX = { };
   OPIUM_FACTIONINDEX = { };

   OPIUM_RACEINDEX["Nain"]     = 1;
   OPIUM_RACEINDEX["Gnome"]     = 2;
   OPIUM_RACEINDEX["Humain"]     = 3;
   OPIUM_RACEINDEX["Elfe de la nuit"] = 4;
   OPIUM_RACEINDEX["Orc"]       = 5;
   OPIUM_RACEINDEX["Tauren"]    = 6;
   OPIUM_RACEINDEX["Troll"]     = 7;
   OPIUM_RACEINDEX["Mort-vivant"]    = 8;

   OPIUM_RACEINDEX[1] = "Nain";
   OPIUM_RACEINDEX[2] = "Gnome";
   OPIUM_RACEINDEX[3] = "Humain";
   OPIUM_RACEINDEX[4] = "Elfe de la nuit";
   OPIUM_RACEINDEX[5] = "Orc";
   OPIUM_RACEINDEX[6] = "Tauren";
   OPIUM_RACEINDEX[7] = "Troll";
   OPIUM_RACEINDEX[8] = "Mort-vivant";

   OPIUM_CLASSINDEX["Druide"]   = 1;
   OPIUM_CLASSINDEX["Chasseur"]  = 2;
   OPIUM_CLASSINDEX["Mage"]    = 3;
   OPIUM_CLASSINDEX["Paladin"] = 4;
   OPIUM_CLASSINDEX["Pr\195\170tre"]  = 5;
   OPIUM_CLASSINDEX["Voleur"]   = 6;
   OPIUM_CLASSINDEX["Chaman"]  = 7;
   OPIUM_CLASSINDEX["D\195\169moniste"] = 8;
   OPIUM_CLASSINDEX["Guerrier"] = 9;

   OPIUM_CLASSINDEX[1] = "Druide";
   OPIUM_CLASSINDEX[2] = "Chasseur";
   OPIUM_CLASSINDEX[3] = "Mage";
   OPIUM_CLASSINDEX[4] = "Paladin";
   OPIUM_CLASSINDEX[5] = "Pr\195\170tre";
   OPIUM_CLASSINDEX[6] = "Voleur";
   OPIUM_CLASSINDEX[7] = "Chaman";
   OPIUM_CLASSINDEX[8] = "D\195\169moniste";
   OPIUM_CLASSINDEX[9] = "Guerrier";


end