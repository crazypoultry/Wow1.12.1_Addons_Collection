-------------------------------------------------------------------------------
-- English localization (Default)
-------------------------------------------------------------------------------

ASPECTED_MSG_RESET = "Page swap for $a reset to none";
ASPECTED_MSG_BIND = "Setting page swap for $a to page ";

ASPECTED_CLASS_PRIEST = "Priest";
ASPECTED_CLASS_SHAMAN = "Shaman";
ASPECTED_CLASS_HUNTER = "Hunter";

ASPECTED_SPELLS = {
	[ASPECTED_CLASS_PRIEST] = { [1] = "Shadowform", },
	[ASPECTED_CLASS_SHAMAN] = { [1] = "Ghost Wolf", },
	[ASPECTED_CLASS_HUNTER] = {
		[5] = "Aspect of the Beast",
		[3] = "Aspect of the Cheetah",
		[2] = "Aspect of the Hawk",
		[1] = "Aspect of the Monkey",
		[4] = "Aspect of the Pack",
		[6] = "Aspect of the Wild",
	},
};

-------------------------------------------------------------------------------
-- French localization (Incomplete)
-------------------------------------------------------------------------------

if (GetLocale() == "frFR") then

ASPECTED_CLASS_PRIEST = "Pr\195\170tre";
ASPECTED_CLASS_SHAMAN = "Chaman";
ASPECTED_CLASS_HUNTER = "Chasseur";



ASPECTED_SPELLS = {
	[ASPECTED_CLASS_PRIEST] = { [1] = "Forme d\'Ombre", },
	[ASPECTED_CLASS_SHAMAN] = { [1] = "Loup Fant\195\180me", },
	[ASPECTED_CLASS_HUNTER] = {
		[5] = "Aspect de la b\195\170te",
		[3] = "Aspect du gu\195\169pard",
		[2] = "Aspect du faucon",
		[1] = "Aspect du singe",
		[4] = "Aspect de la meute",
		[6] = "Aspect de la nature",
	},
};

end

-------------------------------------------------------------------------------
-- German localization (Incomplete)
-------------------------------------------------------------------------------

if (GetLocale() == "deDE") then

ASPECTED_CLASS_PRIEST = "Priester";
ASPECTED_CLASS_SHAMAN = "Schamane";
ASPECTED_CLASS_HUNTER = "J\195\164ger";

ASPECTED_SPELLS = {
	[ASPECTED_CLASS_PRIEST] = { [1] = "Schattenform", },
	[ASPECTED_CLASS_SHAMAN] = { [1] = "Geisterwolf", },
	[ASPECTED_CLASS_HUNTER] = {
		[5] = "Aspekt des Wildtiers",
		[3] = "Aspekt des Geparden",
		[2] = "Aspekt des Falken",
		[1] = "Aspekt des Affen",
		[4] = "Aspekt des Rudels",
		[6] = "Aspekt der Wildnis",
	},
};

end