function BUYPOISONS_DE()


--Slash commands:
SLASH_BUYPOISONS1							= "/buypoisons";
SLASH_BUYPOISONS2							= "/bp";

BUYPOISONS_HELP_MESSAGE = {
	"BUYPOISONS Hilfe :",
	"/bp <command> oder /buypoisons <command>",
	"",
	"Commands:",
	"/bp wpX Y - Kauft die Komponenten zur Herstellung von Y St\195\188ck Wundgift Rang X",
	"/bp cpX Y - Kauft die Komponenten zur Herstellung von Y St\195\188ck Verkr\195\188ppelndes Gift Rang X",
	"/bp dpX Y - Kauft die Komponenten zur Herstellung von Y St\195\188ck T\195\182dliches Rang X",
	"/bp mpX Y - Kauft die Komponenten zur Herstellung von Y St\195\188ck Gedankenbenebelndes Gift Rang X",
	"/bp ipX Y - Kauft die Komponenten zur Herstellung von Y St\195\188ck Sofort wirkendes Gift Rang X",
	"/bp fp Y - Kauft Y Blitzstrahlpulver",
	"zB '/bp wp3 10' kauft alle Komponenten, die f\195\188r 10 St\195\188ck Wundgift Rang 3 gebraucht werden.",
	"",
	"ACHTUNG: Es d\195\188rfen f\195\188r Y nur Vielfache der Zahl 5 verwendet werden, da sonst die Anzahl der Phiolen falsch berechnet wird.",
	"",
	"Automatischer Kauf von Blitzstrahlpulver jedesmal wenn du beim Gifth\195\164ndler bist:",
	"/bp rfp 0 - Deaktiviert den automatischen Kauf von Blitzstrahlpulver",
	"/bp rfp Y - F\195\188llt jedesmal den Vorrat an Blitzstrahlpulver auf Y St\195\188ck auf"
};

BUYPOISONS_CLASS = "Schurke";

--UI labels and tooltips:
BUYPOISONS_UI_VERSION_LABEL						= "Version "..BUYPOISONS_VERSION;
BUYPOISONS_BP_ENABLED_CHECKBT_LABEL					= "BUYPOISONS Enabled";
BUYPOISONS_BP_ENABLED_CHECKBT_TOOLTIP					= "Enable/Disable BUYPOISONS";

--Vendor Item Names
BUYPOISONS_COMPONENT_FLASH_POWDER					="Blitzstrahlpulver";

BUYPOISONS_COMPONENT_DEATHWEED					="Todeskraut";
BUYPOISONS_COMPONENT_DUST_OF_DECAY				="Staub des Verfalls";
BUYPOISONS_COMPONENT_DUST_OF_DETERIORATION		="Staub der Verschlechterung";
BUYPOISONS_COMPONENT_ESSENCE_OF_AGONY			="Essenz der Pein";
BUYPOISONS_COMPONENT_ESSENCE_OF_PAIN			="Essenz des Schmerzes";
BUYPOISONS_COMPONENT_LETHARGY_ROOT				="Lethargiewurzel";

BUYPOISONS_VIAL_EMPTY					="Leere Phiole";
BUYPOISONS_VIAL_CRYSTAL					="Kristallphiole";
BUYPOISONS_VIAL_LEADED					="Verbleite Phiole";



--Shortcut Key Commands


BUYPOISONS_SHORTKEY_CRYSTAL_VIAL				="crystalvial";
BUYPOISONS_SHORTKEY_DEATHWEED				="deathweed";
BUYPOISONS_SHORTKEY_DUST_OF_DECAY				="dustofdecay";
BUYPOISONS_SHORTKEY_DUST_OF_DETERIORATION			="dustofdeterioration";
BUYPOISONS_SHORTKEY_EMPTY_VIAL				="emptyvial";
BUYPOISONS_SHORTKEY_ESSENCE_OF_AGONY			="essenceofagony";
BUYPOISONS_SHORTKEY_ESSENCE_OF_PAIN			="essenceofpain";
BUYPOISONS_SHORTKEY_FLASH_POWDER				="flashpowder";
BUYPOISONS_SHORTKEY_LEADED_VIAL				="leadedvial";
BUYPOISONS_SHORTKEY_LETHARGY_ROOT				="lethargyroot";



BuyPoisonsItemInfo[1]["name"] = "T\195\182dliches Gift V";
BuyPoisonsItemInfo[2]["name"] = "Sofort wirkendes Gift VI";
BuyPoisonsItemInfo[3]["name"] = "Wundgift IV";
BuyPoisonsItemInfo[4]["name"] = "T\195\182dliches Gift IV";
BuyPoisonsItemInfo[5]["name"] = "Sofort wirkendes Gift V";
BuyPoisonsItemInfo[6]["name"] = "Gedanken benebelndes Gift III";
BuyPoisonsItemInfo[7]["name"] = "Verkr\195\188ppelndes Gift II";
BuyPoisonsItemInfo[8]["name"] = "Wundgift III";
BuyPoisonsItemInfo[9]["name"] = "T\195\182dliches Gift III";
BuyPoisonsItemInfo[10]["name"] = "Sofort wirkendes Gift IV";
BuyPoisonsItemInfo[11]["name"] = "Wundgift II";
BuyPoisonsItemInfo[12]["name"] = "T\195\182dliches Gift II";
BuyPoisonsItemInfo[13]["name"] = "Gedanken benebelndes Gift II";
BuyPoisonsItemInfo[14]["name"] = "Sofort wirkendes Gift III";
BuyPoisonsItemInfo[15]["name"] = "Wundgift ";
BuyPoisonsItemInfo[16]["name"] = "T\195\182dliches Gift ";
BuyPoisonsItemInfo[17]["name"] = "Sofort wirkendes Gift II";
BuyPoisonsItemInfo[18]["name"] = "Gedanken benebelndes Gift";
BuyPoisonsItemInfo[19]["name"] = "Verkr\195\188ppelndes Gift";
BuyPoisonsItemInfo[20]["name"] = "Sofort wirkendes Gift ";
BuyPoisonsItemInfo[21]["name"] = "Blitzstrahlpulver";

BuyPoisonsItemInfo[1]["shortkey"] = "dp5";
BuyPoisonsItemInfo[2]["shortkey"] = "ip6";
BuyPoisonsItemInfo[3]["shortkey"] = "wp4";
BuyPoisonsItemInfo[4]["shortkey"] = "dp4";
BuyPoisonsItemInfo[5]["shortkey"] = "ip5";
BuyPoisonsItemInfo[6]["shortkey"] = "mp3";
BuyPoisonsItemInfo[7]["shortkey"] = "cp2";
BuyPoisonsItemInfo[8]["shortkey"] = "wp3";
BuyPoisonsItemInfo[9]["shortkey"] = "dp3";
BuyPoisonsItemInfo[10]["shortkey"] = "ip4";
BuyPoisonsItemInfo[11]["shortkey"] = "wp2";
BuyPoisonsItemInfo[12]["shortkey"] = "dp2";
BuyPoisonsItemInfo[13]["shortkey"] = "mp2";
BuyPoisonsItemInfo[14]["shortkey"] = "ip3";
BuyPoisonsItemInfo[15]["shortkey"] = "wp1";
BuyPoisonsItemInfo[16]["shortkey"] = "dp1";
BuyPoisonsItemInfo[17]["shortkey"] = "ip2";
BuyPoisonsItemInfo[18]["shortkey"] = "mp1";
BuyPoisonsItemInfo[19]["shortkey"] = "cp1";
BuyPoisonsItemInfo[20]["shortkey"] = "ip1";
BuyPoisonsItemInfo[21]["shortkey"] = "fp1";


end