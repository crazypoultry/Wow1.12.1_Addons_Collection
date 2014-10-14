function WeaponRebuff_LocalizeEN()
	chargeNames = {
	    'Instant Poison',
	    'Instant Poison II',
	    'Instant Poison III',
	    'Instant Poison IV',
	    'Instant Poison V',
	    'Instant Poison VI',
	    'Wound Poison',
	    'Wound Poison II',
	    'Wound Poison III',
	    'Wound Poison IV',
	    'Deadly Poison',
	    'Deadly Poison II',
	    'Deadly Poison III',
	    'Deadly Poison IV',
	    'Deadly Poison V',
	    'Mind-numbing Poison',
	    'Mind-numbing Poison II',
	    'Mind-numbing Poison III',
	    'Crippling Poison',
	    'Crippling Poison II',
	    'Rough Sharpening Stone',
	    'Coarse Sharpening Stone',
	    'Heavy Sharpening Stone',
	    'Solid Sharpening Stone',
	    'Dense Sharpening Stone',
	    'Elemental Sharpening Stone',
	    'Rough Weightstone',
	    'Coarse Weightstone',
	    'Heavy Weightstone',
	    'Solid Weightstone',
	    'Dense Weightstone',
	    'Shiny Bauble',
	    'Aquadynamic Fish Lens',
	    'Nightcrawlers',
	    'Bright Baubles',
	    'Flesh Eating Worm',
	    'Aquadynamic Fish Attractor',
	    'Brilliant Wizard Oil',
	    'Lesser Wizard Oil',
	    'Minor Wizard Oil',
	    'Wizard Oil',
	    'Brilliant Mana Oil',
	    'Lesser Mana Oil',
	    'Minor Mana Oil',
	    'Mana Oil'
	}
	spellNames = {
		'Windfury Weapon',
		'Flametongue Weapon',
		'Rockbiter Weapon',
		'Frostbrand Weapon',
		'Omen of Clarity'
	}
	WR_MINUTE = "min";
	WR_SECOND = "sec";
	WR_CHARGES = "Charges";
	ERROR_NO_BUFFS_REMEMBERED = "There are no buffs remembered!";
	WEAPONREBUFF_MSG_BUFFEXPIRED = "BUFF EXPIRED";
	WEAPONREBUFF_MSG_BUFFABOUTTOEXPIRE = "ABOUT TO EXPIRE";	
	WEAPONREBUFF_MSG_LOWONGHARGES = "RUNNING OUT OF CHARGES";
	WEAPONREBUFF_HELPMSG_LOCKED = "moving-mode |caaaaddffdisabled|r";
	WEAPONREBUFF_HELPMSG_UNLOCKED = "moving-mode |caaaaddffenabled|r";
	WEAPONREBUFF_HELPMSG_POSRESET = "button positions |caaaaddffreset|r";
	WEAPONREBUFF_HELPMSG_CMDLINETEXT = "loaded, type |caaaaddff/weaponrebuff|r (or |caaaaddff/wr|r) for help";
	WEAPONREBUFF_SHOWMSG_LOCKED 	= "type |caaaaddff/wr unlock|r to enable moving-mode";
	WEAPONREBUFF_SHOWMSG_UNLOCKED = "type |caaaaddff/wr lock|r to disable moving-mode";
	WEAPONREBUFF_SHOWMSG_POSRESET = "type |caaaaddff/wr reset|r to reset the button positions";
	WEAPONREBUFF_SHOWMSG_SETSIZE  = "type |caaaaddff/wr size <size>|r to set the button size to <size>";
	WEAPONREBUFF_SHOWMSG_BUFFITEMTHRESHOLD  = "type |caaaaddff/wr buffitems <number>|r to set the buff-items-remaining warning threshold to <number>";
	WEAPONREBUFF_SHOWMSG_CHARGETHRESHOLD  = "type |caaaaddff/wr charges <number>|r to set the charges-remaining warning threshold to <number>";

	WEAPONREBUFF_TRAILINGTEXT_MAINHAND = " on your Main Hand"
	WEAPONREBUFF_TRAILINGTEXT_OFFHAND  = " on your Off Hand"
	WEAPONREBUFF_SHOWMSG_UPDATEDBUFFITEMTHRESHOLD  = "Buff-Item Warning Threshold changed to ";
	WEAPONREBUFF_SHOWMSG_UPDATEDCHARGETHRESHOLD  = "Charges-Remaining Warning Threshold changed to ";

end

-- Localization French

function WeaponRebuff_LocalizeFR()
	chargeNames = {
	'Poison instantan\195\169',
	'Poison instantan\195\169 II',
	'Poison instantan\195\169 III',
	'Poison instantan\195\169 IV',
	'Poison instantan\195\169 V',
	'Poison instantan\195\169 VI',
	'Poison affaiblissant',
	'Poison affaiblissant II',
	'Poison affaiblissant III',
	'Poison affaiblissant IV',
	'Poison mortel',
	'Poison mortel II',
	'Poison mortel III',
	'Poison mortel IV',
	'Poison mortel V',
	'Poison de distraction mentale',
	'Poison de distraction mentale II',
	'Poison de distraction mentale III',
	'Poison douloureux',
	'Poison douloureux II',
	'Pierre \195\160 aiguiser brute',
	'Pierre \195\160 aiguiser grossi\195\168re',
	'Pierre \195\160 aiguiser lourde',
	'Pierre \195\160 aiguiser solide',
	'Pierre \195\160 aiguiser dense',
	'Pierre \195\160 aiguiser \195\169l\195\169mentaire',
	'Silex \195\160 aiguiser brut',
	'Silex \195\160 aiguiser grossier',
	'Silex \195\160 aiguiser lourd',
	'Silex \195\160 aiguiser solide',
	'Silex \195\160 aiguiser dense',
	'Verroterie brillante',
	'Oeil de poisson aquadynamique',
	'Asticots',
	'Verroterie',
	'Ver mangeur de chair',
	'Attracteur de poissons aquadynamique',
	'Huile de sorcier brillante',
	'Huile de sorcier inf\195\169rieure',
	'Huile de sorcier mineure',
	'Huile de sorcier',
	'Huile de mana brillante',
	'Huile de mana inf\195\169rieure',
	'Huile de mana mineure',
	'Huile de mana'
	}
	spellNames = {
	'Arme des Vents',
	'Arme Langue de Feu',
	'Arme Croque-Roc',
	'Arme de Glace',
	'Augure de Clart\195\169'
	}
	WR_MINUTE = "min";
	WR_SECOND = "sec";
	ERROR_NO_BUFFS_REMEMBERED = "Aucune am\195\169lioration d'arme m\195\169moris\195\169e!";
	WEAPONREBUFF_MSG_BUFFEXPIRED = "BUFF EXPIRED";
	WEAPONREBUFF_MSG_LOWONGHARGES = "RUNNING OUT OF CHARGES";	
	WEAPONREBUFF_HELPMSG_LOCKED = "weaponrebuff> moving-mode |caaaaddffdisabled|r";
	WEAPONREBUFF_HELPMSG_UNLOCKED = "weaponrebuff> moving-mode |caaaaddffenabled|r";
	WEAPONREBUFF_HELPMSG_POSRESET = "weaponrebuff> button positions |caaaaddffreset|r";
	WEAPONREBUFF_HELPMSG_CMDLINETEXT = "loaded, type |caaaaddff/weaponrebuff|r (or |caaaaddff/wr|r) for help";
	WEAPONREBUFF_SHOWMSG_LOCKED 	= "type |caaaaddff/wr unlock|r to enable moving-mode";
	WEAPONREBUFF_SHOWMSG_UNLOCKED = "type |caaaaddff/wr lock|r to disable moving-mode";
	WEAPONREBUFF_SHOWMSG_POSRESET = "type |caaaaddff/wr reset|r to reset the button positions";
	WEAPONREBUFF_SHOWMSG_SETSIZE  = "type |caaaaddff/wr size <size>|r to set the button size to <size>";
	WEAPONREBUFF_SHOWMSG_BUFFITEMTHRESHOLD  = "type |caaaaddff/wr buffitems <size>|r to set the buff-items-remaining warning threshold to <number>";
	WEAPONREBUFF_SHOWMSG_CHARGETHRESHOLD  = "type |caaaaddff/wr charges <number>|r to set the charges-remaining warning threshold to <number>";

	WEAPONREBUFF_TRAILINGTEXT_MAINHAND = " on your Main Hand"
	WEAPONREBUFF_TRAILINGTEXT_OFFHAND = " on your Off Hand"
	WEAPONREBUFF_SHOWMSG_BUFFITEMTHRESHOLD  = "type |caaaaddff/wr buffitems <size>|r to set the buff-items-remaining warning threshold to <number>";
	WEAPONREBUFF_SHOWMSG_CHARGETHRESHOLD  = "type |caaaaddff/wr charges <number>|r to set the charges-remaining warning threshold to <number>";

end

-- Localization German
-- Translation Help obviously needed!

function WeaponRebuff_LocalizeDE() 
	chargeNames = {
		'Sofort wirkendes Gift',
		'Sofort wirkendes Gift II',
		'Sofort wirkendes Gift III',
		'Sofort wirkendes Gift IV',
		'Sofort wirkendes Gift V',
		'Sofort wirkendes Gift VI',
		'Wundgift',
		'Wundgift II',
		'Wundgift III',
		'Wundgift IV',
		'T\195\182dliches Gift',
		'T\195\182dliches Gift II',
		'T\195\182dliches Gift III',
		'T\195\182dliches Gift IV',
		'T\195\182dliches Gift V',
		'Gedankenbenebelndes Gift',
		'Gedankenbenebelndes Gift II',
		'Gedankenbenebelndes Gift III',
		'Verkr\195\188ppelndes Gift',
		'Verkr\195\188ppelndes Gift II',
		'Rauer Wetzstein',
		'Grober Wetzstein',
		'Schwerer Wetzstein',
		'Robuster Wetzstein',
		'Verdichteter Wetzstein',
		'Elementarwetzstein',
		'Rauer Gewichtsstein',
		'Grober Gewichtsstein',
		'Schwerer Gewichtsstein',
		'Robuster Gewichtsstein',
		'Verdichteter Gewichtsstein',
		'Elementarwetzstein',
		'Helle Schmuckst\195\188cke',
		'Frost\195\182l',
		'Schatten\195\182l',
		'Gl\195\164nzendes Schmuckst\195\188ck',
		'Aquadynamische Fischlinse',
		'Nachtkriecher',
		'Helle Schmuckst195188cke',
		'Fleischfressender Wurm',
		'Aquadynamischer Fischanlocker',
		'Hervorragendes Zauber\195\182l',
		'Geringes Zauber\195\182l',
		'Schwaches Zauber\195\182l',
		'Zauber\195\182l',
		'Hervorragendes Mana\195\182l',
		'Geringes Mana\195\182l',
		'Schwaches Mana\195\182l',
		'Mana\195\182l' 				
	}
	spellNames = {
		'Windfuror-Waffe',
		'Waffe der Flammenzunge',
		'Felsbei\195\159erwaffe',
		'Waffe des Frostbrands',
		'Omen der Klarsicht'
	}
	WR_MINUTE = "Min.";
	WR_SECOND = "Sek.";
	ERROR_NO_BUFFS_REMEMBERED = "There are no buffs remembered!";
	WEAPONREBUFF_MSG_BUFFEXPIRED = "BUFF EXPIRED";
	WEAPONREBUFF_MSG_LOWONGHARGES = "RUNNING OUT OF CHARGES";
	WEAPONREBUFF_HELPMSG_LOCKED = "weaponrebuff> moving-mode |caaaaddffdisabled|r";
	WEAPONREBUFF_HELPMSG_UNLOCKED = "weaponrebuff> moving-mode |caaaaddffenabled|r";
	WEAPONREBUFF_HELPMSG_POSRESET = "weaponrebuff> button positions |caaaaddffreset|r";
	WEAPONREBUFF_HELPMSG_CMDLINETEXT = "loaded, type |caaaaddff/weaponrebuff|r (or |caaaaddff/wr|r) for help";
	WEAPONREBUFF_SHOWMSG_LOCKED 	= "type |caaaaddff/wr unlock|r to enable moving-mode";
	WEAPONREBUFF_SHOWMSG_UNLOCKED = "type |caaaaddff/wr lock|r to disable moving-mode";
	WEAPONREBUFF_SHOWMSG_POSRESET = "type |caaaaddff/wr reset|r to reset the button positions";
	WEAPONREBUFF_SHOWMSG_SETSIZE  = "type |caaaaddff/wr size <size>|r to set the button size to <size>";
	WEAPONREBUFF_SHOWMSG_BUFFITEMTHRESHOLD  = "type |caaaaddff/wr buffitems <size>|r to set the buff-items-remaining warning threshold to <number>";
	WEAPONREBUFF_SHOWMSG_CHARGETHRESHOLD  = "type |caaaaddff/wr charges <number>|r to set the charges-remaining warning threshold to <number>";

  WEAPONREBUFF_TRAILINGTEXT_MAINHAND = " on your Main Hand"
	WEAPONREBUFF_TRAILINGTEXT_OFFHAND = " on your Off Hand"
end


function WeaponRebuff_Localize()
	WeaponRebuff_LocalizeEN();
	
	local locale = GetLocale();
	if ( locale == "deDE" ) then
		WeaponRebuff_LocalizeDE();
	elseif ( locale == "frFR" ) then
		WeaponRebuff_LocalizeFR();
	end
end
