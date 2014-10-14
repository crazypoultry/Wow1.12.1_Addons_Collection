-- Localization French
-- Translation Help obviously needed!

local T = AceLibrary("AceLocale-2.0"):new("WeaponRebuff")
T:RegisterTranslations("frFR", function()
	 return {
	["WR_MINUTE"] = "min",
	["WR_SECOND"] =  "sec",
	["WR_CHARGES"] =  "Charges",
	["ERROR_NO_BUFFS_REMEMBERED"] =  "Aucune am\195\169lioration d'arme m\195\169moris\195\169e!",
	["WEAPONREBUFF_MSG_BUFFEXPIRED"] =  "BUFF EXPIRED",
	["WEAPONREBUFF_MSG_BUFFABOUTTOEXPIRE"] =  "ABOUT TO EXPIRE",	
	["WEAPONREBUFF_MSG_LOWONGHARGES"] =  "RUNNING OUT OF CHARGES",
	["WEAPONREBUFF_HELPMSG_LOCKED"] =  "moving-mode |caaaaddffdisabled|r",
	["WEAPONREBUFF_HELPMSG_UNLOCKED"] =  "moving-mode |caaaaddffenabled|r",
	["WEAPONREBUFF_HELPMSG_POSRESET"] =  "button positions |caaaaddffreset|r",
	["WEAPONREBUFF_HELPMSG_CMDLINETEXT"] =  "loaded, type |caaaaddff/wr|r) for help",
	
  ["WEAPONREBUFF_SHOWMSG_BUTTONSIZE"] = "Current Button Size ",
  ["WEAPONREBUFF_SHOWMSG_BUFFITEMTHRESHOLD_CUR"] = "Current Buff-Items Remaining Threshold ",
  ["WEAPONREBUFF_SHOWMSG_CHARGETHRESHOLD_CUR"] = "Current Charges Remaining Threshold ",
  ["WEAPONREBUFF_SHOWMSG_WARNINSECONDS"] = "Warning triggered when seconds-remaining is ",
	["WEAPONREBUFF_SHOWMSG_LOCKED"] 	= "|caaaaddff/wr unlock|r enable moving",
	["WEAPONREBUFF_SHOWMSG_UNLOCKED"] =  "|caaaaddff/wr lock|r disable moving",
	["WEAPONREBUFF_SHOWMSG_POSRESET"] =  "|caaaaddff/wr reset|r reset the button positions",
	["WEAPONREBUFF_SHOWMSG_SETSIZE"]  =  "|caaaaddff/wr size <size>|r rebuff button to <size>",
	["WEAPONREBUFF_SHOWMSG_BUFFITEMTHRESHOLD"] =  "|caaaaddff/wr buffitems <number>|r buffing items remaining less than <number>",
	["WEAPONREBUFF_SHOWMSG_CHARGETHRESHOLD"] =  "|caaaaddff/wr charges <number>|r weapon charges less than <number>",
	["WEAPONREBUFF_SHOWMSG_UPDATEDTHRESHOLD_INSECONDS"] =  "|caaaaddff/wr setseconds <number>|r trigger warning at <number> seconds (1-60)",

  ["WEAPONREBUFF_TRAILINGTEXT_MAINHAND"] =  " on your Main Hand",
	["WEAPONREBUFF_TRAILINGTEXT_OFFHAND"] =  " on your Off Hand",
	["WEAPONREBUFF_SHOWMSG_UPDATEDBUFFITEMTHRESHOLD"] =  "Buff-Item Warning Threshold changed to ",
	["WEAPONREBUFF_SHOWMSG_UPDATEDCHARGETHRESHOLD"] =  "Charges-Remaining Warning Threshold changed to ",
	["WEAPONREBUFF_UPDATEDTHRESHOLD_INSECONDS"] =  "Warning Threshold (in seconds) set to ",
	["WEAPONREBUFF_SHOWMSG_DESCRIBEHELP"] = "type |caaaaddff/wr help|r to show commands",
	["WEAPONREBUFF_SHOWMSG_DESCRIBECONFIG"] = "type |caaaaddff/wr config|r to display the config dialog",
	
	
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
	'Poison douloureux III',
	'Poison douloureux IV',
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
	},
	spellNames = {
	'Arme des Vents',
	'Arme Langue de Feu',
	'Arme Croque-Roc',
	'Arme de Glace',
	'Augure de Clart\195\169'
	}
    }
end)

-- function WeaponRebuff_Localize()
-- 	WeaponRebuff_LocalizeEN(),
-- 	
-- 	local locale = GetLocale(),
-- 	if ( locale == "deDE" ) then
-- 		WeaponRebuff_LocalizeDE(),
-- 	elseif ( locale == "frFR" ) then
-- 		WeaponRebuff_LocalizeFR(),
-- 	end
-- end
