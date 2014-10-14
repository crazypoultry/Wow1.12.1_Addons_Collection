
if (GetLocale() == "enUS" or GetLocale() == "enGB") then
	-- equip and set bonus prefixes:
	HEALPOINTSBS_PREFIX_EQUIP = "Equip: ";
	HEALPOINTSBS_PREFIX_SET = "Set: ";
	HEALPOINTSBS_PREFIX_USE = "Use: "; 
	
	-- passive bonus patterns. checked against lines which start with above prefixes
	HEALPOINTSBS_PATTERNS_PASSIVE = {
		{ pattern = "Improves your chance to get a critical strike with spells by (%d+)%%%.", effect = "SPELLCRIT" },
		{ pattern = "Improves your chance to get a critical strike with Holy spells by (%d+)%%%.", effect = "HOLYCRIT" },
		{ pattern = "Increases the critical effect chance of your Holy spells by (%d+)%%%.", effect = "HOLYCRIT" },
		{ pattern = "Increases healing done by spells and effects by up to (%d+)%.", effect = "HEAL" },
		{ pattern = "Increases damage and healing done by magical spells and effects by up to (%d+)%.", effect = "HEAL" },
		{ pattern = "Restores (%d+) mana per 5 sec%.", effect = "MANAREG" },
		{ pattern = "Restores (%d+) mana every 5 sec%.", effect = "MANAREG" },
	
		-- Added
		{ pattern = "Allows (%d+)%% of your Mana regeneration to continue while casting%.", effect = "CASTINGREG"},		
		{ pattern = "Improves your chance to get a critical strike with Nature spells by (%d+)%%%.", effect = "NATURECRIT"}, 
		{ pattern = "Reduces the casting time of your Regrowth spell by 0%.(%d+) sec%.", effect = "CASTINGREGROWTH"}, 
		{ pattern = "Reduces the casting time of your Holy Light spell by 0%.(%d+) sec%.", effect = "CASTINGHOLYLIGHT"},
		{ pattern = "Reduces the casting time of your Healing Touch spell by 0%.(%d+) sec%.", effect = "CASTINGHEALINGTOUCH"},
		{ pattern = "%-0%.(%d+) sec to the casting time of your Flash Heal spell%.", effect = "CASTINGFLASHHEAL"},
		{ pattern = "%-0%.(%d+) seconds on the casting time of your Chain Heal spell%.", effect = "CASTINGCHAINHEAL"},
		{ pattern = "Increases the duration of your Rejuvenation spell by (%d+) sec%.", effect = "DURATIONREJUV"},
		{ pattern = "Increases the duration of your Renew spell by (%d+) sec%.", effect = "DURATIONRENEW"},
		{ pattern = "Increases your normal health and mana regeneration by (%d+)%.", effect = "MANAREGNORMAL"},
		{ pattern = "Increases the amount healed by Chain Heal to targets beyond the first by (%d+)%%%.", effect = "IMPCHAINHEAL"},
		{ pattern = "Increases healing done by Rejuvenation by up to (%d+)%.", effect = "IMPREJUVENATION"},
		{ pattern = "Increases healing done by Lesser Healing Wave by up to (%d+)%.", effect = "IMPLESSERHEALINGWAVE"},
		{ pattern = "Increases healing done by Flash of Light by up to (%d+)%.", effect = "IMPFLASHOFLIGHT"},
		{ pattern = "After casting your Healing Wave or Lesser Healing Wave spell%, gives you a 25%% chance to gain Mana equal to (%d+)%% of the base cost of the spell%.", effect = "REFUNDHEALINGWAVE"},
		{ pattern = "Your Healing Wave will now jump to additional nearby targets%. Each jump reduces the effectiveness of the heal by (%d+)%%%, and the spell will jump to up to two additional targets%.", effect = "JUMPHEALINGWAVE"},
		{ pattern = "Reduces the mana cost of your Healing Touch%, Regrowth%, Rejuvenation%,  and Tranquility spells by (%d+)%%%.", effect = "CHEAPERDRUID"},
		{ pattern = "On Healing Touch critical hits%, you regain (%d+)%% of the mana cost of the spell%.", effect = "REFUNDHTCRIT"},
		{ pattern = "Reduces the mana cost of your Renew spell by (%d+)%%%.", effect = "CHEAPERRENEW"},
		{ pattern = "Your Greater Heals now have a heal over time component equivalent to a rank (%d+) Renew%.", effect = "GHEALRENEW"}
	};
	
	-- generic patterns have the form "+xx bonus" or "bonus +xx" with an optional % sign after the value.
	
	-- first the generic bonus string is looked up in the following table
	HEALPOINTSBS_PATTERNS_GENERIC_LOOKUP = {
		["All Stats"] 			= {"INT", "SPI"},
		["Intellect"]			= "INT",
		["Spirit"] 				= "SPI",
	
		["Healing Spells"] 		= "HEAL",
		["Increases Healing"] 	= "HEAL",
		["Healing and Spell Damage"] = "HEAL",
		["Damage and Healing Spells"] = "HEAL",
		["Spell Damage and Healing"] = "HEAL",	
		["mana every 5 sec"] 	= "MANAREG",
		["Spell Damage"] 		= "HEAL", -- Spell Power enchant also increase +healing (added in patch 1.12)
		["Mana Regen"] 			= "MANAREG",
		["Mana"]				= "MANA",
	};	
	
	-- finally if we got no match, we match against some special enchantment patterns.
	HEALPOINTSBS_PATTERNS_OTHER = {
		{ pattern = "Mana Regen (%d+) per 5 sec%.", effect = "MANAREG" },
		{ pattern = "Zandalar Signet of Mojo", effect = "HEAL", value = 18 },
		{ pattern = "Zandalar Signet of Serenity", effect = "HEAL", value = 33 },
		
		{ pattern = "Minor Wizard Oil", effect = "HEAL", value = 8 },
		{ pattern = "Lesser Wizard Oil", effect = "HEAL", value = 16 },
		{ pattern = "Wizard Oil", effect = "HEAL", value = 24 },
		{ pattern = "Brilliant Wizard Oil", effect = {"HEAL", "SPELLCRIT"}, value = {36, 1} },
	
		{ pattern = "Minor Mana Oil", effect = "MANAREG", value = 4 },
		{ pattern = "Lesser Mana Oil", effect = "MANAREG", value = 8 },
		{ pattern = "Brilliant Mana Oil", effect = { "MANAREG", "HEAL"}, value = {12, 25} },	
	};

elseif (GetLocale() == "deDE") then
	-- Präfixe für passive und Set-Boni
	HEALPOINTSBS_PREFIX_EQUIP = "Anlegen: ";
	HEALPOINTSBS_PREFIX_SET = "Set: ";
	HEALPOINTSBS_PREFIX_USE = "Benutzen: ";

	-- Suchmuster für passive Boni. Wird auf Zeilen angewandt, die mit obigen Präfixen beginnen.
	HEALPOINTSBS_PATTERNS_PASSIVE = {
		{ pattern = "Erh\195\182ht Eure Chance, einen kritischen Schlag durch Zauber zu erzielen, um (%d+)%%%.", effect = "SPELLCRIT" },
		{ pattern = "Erh\195\182ht Eure Chance, einen kritischen Schlag durch Heiligzauber zu erzielen, um (%d+)%%%.", effect = "HOLYCRIT" },
		{ pattern = "Erh\195\182ht durch Zauber und magische Effekte zugef\195\188gten Schaden und Heilung um bis zu (%d+)%.", effect = "HEAL" },
		{ pattern = "Erh\195\182ht durch Zauber und Effekte verursachte Heilung um bis zu (%d+)%.", effect = "HEAL" },
		{ pattern = "Erh\195\182ht die durch Zauber und Effekte verursachte Heilung um bis zu (%d+)%.", effect = "HEAL" },
		{ pattern = "Stellt alle 5 Sek%. (%d+) Punkt%(e%) Mana wieder her%.", effect = "MANAREG" },

		{ pattern = "Erm\195\182glicht, dass (%d+)%% Eurer Manaregeneration w\195\164hrend des Zauberwirkens weiterl\195\164uft%.", effect = "CASTINGREG"},		
		{ pattern = "Erh\195\182ht Eure Chance, einen kritischen Schlag durch Naturzauber zu erzielen, um (%d+)%%%.", effect = "NATURECRIT"}, 
		{ pattern = "Verringert die Zauberzeit Eures %'Nachwachsen%'%-Zaubers um 0%.(%d+) Sekunden%.", effect = "CASTINGREGROWTH"}, 
		{ pattern = "Verringert die Zauberzeit Eures %'Heiliges Licht%'%-Zaubers um 0%.(%d+) Sekunden%.", effect = "CASTINGHOLYLIGHT"}, 
		{ pattern = "%-0%.(%d+) Sek%. Zauberzeit f\195\188r Euren %'Blitzheilungs%'%-Zauber%.", effect = "CASTINGFLASHHEAL"}, 
		{ pattern = "Zauberzeit von Kettenheilung um %-0%.(%d+) Sekunden reduziert%.", effect = "CASTINGCHAINHEAL"},
		{ pattern = "Verringert die Zauberzeit Eures Zaubers %'Heilende Ber\195\188hrung%' um 0%.(%d+) Sekunden%.", effect = "CASTINGHEALINGTOUCH"},
		{ pattern = "Verl\195\164ngert die Dauer eures %'Verj\195\188ngung%'%-Zaubers um (%d+) Sekunden%.", effect = "DURATIONREJUV"},
		{ pattern = "Erh\195\182ht die Dauer Eures Erneuern-Zaubers um (%d+) Sekunden%.", effect = "DURATIONRENEW"},
		{ pattern = "Erh\195\182ht Gesundheit%- und Manaregeneration um (%d+)%.", effect = "MANAREGNORMAL"},
		{ pattern = "Erh\195\182ht den geheilten Wert bei jedem Ziel nach dem ersten um (%d+)%%%.", effect = "IMPCHAINHEAL"},
		{ pattern = "Erh\195\182ht die Heilwirkung Eures Zaubers %'Verj\195\188ngung%' um bis zu (%d+)%.", effect = "IMPREJUVENATION"},
		{ pattern = "Erh\195\182ht die Heilung Eures Zaubers %'Geringe Welle der Heilung%' um bis zu (%d+)%.", effect = "IMPLESSERHEALINGWAVE"},
		{ pattern = "Erh\195\182ht die Heilung Eures Zaubers %'Lichtblitz%' um bis zu (%d+)%.", effect = "IMPFLASHOFLIGHT"},
		{ pattern = "Wenn die Zauber %'Welle der Heilung%' oder %'Geringe Welle der Heilung%' gewirkt werden%, besteht eine Chance von 25%%%, Mana zu gewinnen%. Der Managewinn entspricht (%d+)%% der Basiskosten des Zaubers%.", effect = "REFUNDHEALINGWAVE"},
		{ pattern = "Eure Zauber %'Welle der Heilung%' springen auf bis zu zwei zus\195\164tzliche Ziele \195\188ber%. Bei jedem Sprung reduziert sich die Effektivit\195\164t der Heilung um (%d+)%%%.", effect = "JUMPHEALINGWAVE"},
  		{ pattern = "Verringert die Manakosten Eurer Zauber %'Heilende Ber\195\188hrung%'%, %'Nachwachsen%'%, %'Verj\195\188ngung%' und %'Gelassenheit%' um (%d+)%%%.", effect = "CHEAPERDRUID"},
		{ pattern = "Bei kritischen Treffern Eures Zaubers %'Heilende Ber\195\188hrung%' erhaltet Ihr (%d+)%% der Manakosten dieses Zaubers zur\195\188ck%.", effect = "REFUNDHTCRIT"},
		{ pattern = "Verringert die Manakosten Eures Zaubers %'Erneuerung%' um (%d+)%%%.", effect = "CHEAPERRENEW"},
		{ pattern = "Euer Zauber %'Gro\195\159e Heilung%' hat nun einen zus\195\164 tzlichen Heileffekt%, der dem Zauber %'Erneuerung%' mit Rang (%d+) entspricht%.", effect = "GHEALRENEW"}
};
		
		
	-- Suchmuster für allgemeine Gegenstandsboni in der Form "+xx bonus" oder "bonus +xx" (%-Zeichen nach dem Wert ist optional)
	
	-- Zuerst wird versucht den "bonus"-String in der folgenden Tabelle nachzuschlagen
	HEALPOINTSBS_PATTERNS_GENERIC_LOOKUP = {
		["Alle Werte"] 			= {"INT", "SPI"},
		["Intelligenz"]			= "INT",
		["Willenskraft"] 		= "SPI",
	
		["Mana alle 5 Sek"] 	= "MANAREG",
		["Manaregeneration"]	= "MANAREG",
		["Heilzauber"]			= "HEAL",
		["Heilung und Zauberschaden"] = "HEAL",
		["Zauberschaden"] 		= "HEAL",
		["Mana"]				= "MANA",
	};
	
	-- Zuletzt, falls immer noch kein Treffer vorliegt wird noch auf einige spezielle Verzauberungen überprüft.
	HEALPOINTSBS_PATTERNS_OTHER = {
		{ pattern = "Manaregeneration (%d+) per 5 Sek%.", effect = "MANAREG" },
		{ pattern = "Zandalarianisches Siegel des Mojo", effect = "HEAL", value = 18 },
		{ pattern = "Zandalarianisches Siegel der Inneren Ruhe", effect = "HEAL", value = 33 },
		
		{ pattern = "Schwaches Zauber\195\182l", effect = "HEAL", value = 8 },
		{ pattern = "Geringes Zauber\195\182l", effect = "HEAL", value = 16 },
		{ pattern = "Zauber\195\182l", effect = "HEAL", value = 24 },
		{ pattern = "Hervorragendes Zauber\195\182l", effect = {"HEAL", "SPELLCRIT"}, value = {36, 1} },
	
		{ pattern = "Schwaches Mana\195\182l", effect = "MANAREG", value = 4 },
		{ pattern = "Geringes Mana\195\182l", effect = "MANAREG", value = 8 },
		{ pattern = "Hervorragendes Mana\195\182l", effect = { "MANAREG", "HEAL"}, value = {12, 25} }
	
	};
elseif (GetLocale() == "frFR") then
	HEALPOINTSBS_PREFIX_EQUIP = "Equip\195\169 : ";
	HEALPOINTSBS_PREFIX_SET = "Ensemble : ";
	HEALPOINTSBS_PREFIX_USE = "Utiliser: ";

	HEALPOINTSBS_PATTERNS_PASSIVE = {
		{ pattern = "Augmente vos chances d%'infliger des coups critiques avec vos sorts de (%d+)%%%.", effect = "SPELLCRIT" },
		{ pattern = "Augmente vos chances d%'infliger un coup critique avec vos sorts du Sacr\195\169 de (%d+)%%%.", effect = "HOLYCRIT" },
		{ pattern = "Augmente les effets des sorts de soins de (%d+)% au maximum%.", effect = "HEAL" },
		{ pattern = "Augmente les soins prodigu\195\169s par les sorts et effets de (%d+)% au maximum%.", effect = "HEAL" },
		{ pattern = "Augmente les d\195\169g\195\162ts et les soins produits par les sorts et effets magiques de (%d+)% au maximum%.", effect = "HEAL" },
		{ pattern = "Rend (%d+) points de mana toutes les 5 secondes%.", effect = "MANAREG" },

		-- Added
		{ pattern = "(%d+)%% de votre vitesse de r\195\169cup\195\169ration du Mana sont actifs lorsque vous incantez%.", effect = "CASTINGREG"},		
		{ pattern = "Vous conf\195\168re (%d+)%% de votre vitesse normale de r\195\169cup\195\169ration du mana pendant l%'incantation%.", effect = "CASTINGREG"},
		{ pattern = "Augmente vos chances d%'infliger un coup critique avec les sorts de Nature de (%d+)%%%.", effect = "NATURECRIT"}, 
		{ pattern = "R\195\169duit le temps d%'incantation de votre sort R\195\169tablissement de 0%.(%d+) sec%.", effect = "CASTINGREGROWTH"}, 
		{ pattern = "R\195\169duit le temps d%'incantation de votre sort Lumi\195\168re sacr\195\169e de 0%.(%d+) sec%.", effect = "CASTINGHOLYLIGHT"}, 
		{ pattern = "%-0%.(%d+) sec%. au temps d%'incantation de votre sort Soins rapides%.", effect = "CASTINGFLASHHEAL"}, 
		{ pattern = "%-0%,(%d+) secondes au temps d%'incantation de votre sort Salve de gu\195\169rnison%.", effect = "CASTINGCHAINHEAL"},
		{ pattern = "R\195\169duit le temps de lancement de Toucher Gu\195\169risseur de 0%.(%d+) secondes%.", effect = "CASTINGHEALINGTOUCH"},
		{ pattern = "Augmente la dur\195\169e de votre sort R\195\169cup\195\169ration de (%d+) sec%.", effect = "DURATIONREJUV"},
		{ pattern = "Augmente la dur\195\169e de votre sort R\195\169novation de (%d+) sec%.", effect = "DURATIONRENEW"},
		{ pattern = "Augmente la r\195\169g\195\169n\195\169ration des points de vie et de mana de (%d+)%.", effect = "MANAREGNORMAL"},
		{ pattern = "Augmente de (%d+)%% le montant de points de vie rendus par Salve de gu\195\169rison aux cibles qui suivent la premi\195\168re%.", effect = "IMPCHAINHEAL"},
		{ pattern = "Augmente les soins prodigu\195\169s par R\195\169cup\195\169ration de (%d+) au maximum%.", effect = "IMPREJUVENATION"},
		{ pattern = "Augmente les soins prodigu\195\169s par votre Vague de Soins Inf\195\169rieurs de (%d+)%.", effect = "IMPLESSERHEALINGWAVE"},
		{ pattern = "Augmente les soins prodigu\195\169s par votre Eclair lumineux de (%d+)%.", effect = "IMPFLASHOFLIGHT"},
		{ pattern = "Apr\195\168s avoir lanc\195\169 un sort de Vague de soins ou de Vague de soins inf\195\169rieurs%, vous avez 25%% de chances de gagner un nombre de points de mana \195\169gal \195\160 (%d+)%% du co\195\187t de base du sort%.", effect = "REFUNDHEALINGWAVE"},
		{ pattern = "Votre Vague de soins soigne aussi des cibles proches suppl\195\169mentaires%. Chaque nouveau soin perd (%d+)%% d%'efficacit\195\169%, et le sort soigne jusqu%'\195\160 deux cibles suppl\195\169mentaires%.", effect = "JUMPHEALINGWAVE"},
		{ pattern = "R\195\169duit de (%d+)%% le co\195\187t en mana de vos sorts Toucher gu\195\169risseur%, R\195\169tablissement%, R\195\169cup\195\169ration et Tranquillit\195\169%.", effect = "CHEAPERDRUID"},
		{ pattern = "En cas de r\195\169ussite critique sur un Toucher gu\195\169risseur%, vous r\195\169cup\195\169rez (%d+)%% du co\195\187t en mana du sort%.", effect = "REFUNDHTCRIT"},
		{ pattern = "Reduit le co\195\187t en mana de votre sort R\195\169novation de (%d+)%%%.", effect = "CHEAPERRENEW"},
		{ pattern = "Vos Soins sup\195\169rieurs soignent maintenant aussi sur la dur\195\169e %(\195\169quivalent de R\195\169novation rang (%d+)%)%.", effect = "GHEALRENEW"}
	};
	
	HEALPOINTSBS_PATTERNS_GENERIC_LOOKUP = {
		["Toutes les caract\195\169ristiques"] = {"INT", "SPI"},
		["Intelligence"] = "INT",
		["Esprit"] = "SPI",
		["Sorts de Soins"] = "HEAL",
		["Mana chaque 5 sec."] = "MANAREG",
		["D\195\169g\195\162ts et soins "] = "HEAL",
		["Sorts de Dommages"] = "HEAL", -- which of these two 
		["dÃ©gÃ¢ts des sorts"] = "HEAL", -- is the spell power enchant?
		["Mana"] = "MANA",
	};
		
	HEALPOINTSBS_PATTERNS_OTHER = {
		{ pattern = "Mana chaque (%d+) per 5 sec%.", effect = "MANAREG" }, --?
		{ pattern = "Cachet de mojo zandalar", effect = "HEAL", value = 18 }, --?
		{ pattern = "Cachet de s\195\169r\195\169nit\195\169 zandalar", effect = "HEAL", value = 33 }, 
		
		{ pattern = "Huile de sorcier mineure", effect = "HEAL", value = 8 },
		{ pattern = "Huile de sorcier inf\195\169rieure", effect = "HEAL", value = 16 },
		{ pattern = "Huile de sorcier", effect = "HEAL", value = 24 },
		{ pattern = "Huile de sorcier brillante", effect = {"HEAL", "SPELLCRIT"}, value = {36, 1} },
	
		{ pattern = "Huile de mana mineure", effect = "MANAREG", value = 4 },
		{ pattern = "Huile de mana inf\195\169rieure", effect = "MANAREG", value = 8 },
		{ pattern = "Huile de mana brillante", effect = { "MANAREG", "HEAL"}, value = {12, 25} },	
	};
end