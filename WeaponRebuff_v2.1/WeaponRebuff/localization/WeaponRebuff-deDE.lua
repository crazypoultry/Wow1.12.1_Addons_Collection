-- Localization German
-- Translation Help obviously needed!
local T = AceLibrary("AceLocale-2.0"):new("WeaponRebuff")
T:RegisterTranslations("deDE", function()
	 return {
	["WR_MINUTE"] = "Min.",
	["WR_SECOND"] =  "Sek.",
	["WR_CHARGES"] =  "Stück",
	["ERROR_NO_BUFFS_REMEMBERED"] =  "Es sind keine Buffs bekannt!",
	["WEAPONREBUFF_MSG_BUFFEXPIRED"] =  "Buff ist ausgelaufen!",
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
  
  ["WEAPONREBUFF_TRAILINGTEXT_MAINHAND"] =  " der Mainhand aus!",
	["WEAPONREBUFF_TRAILINGTEXT_OFFHAND"] =  " der Offhand aus!",
	["WEAPONREBUFF_SHOWMSG_UPDATEDBUFFITEMTHRESHOLD"] =  "Buff-Item Warning Threshold changed to ",
	["WEAPONREBUFF_SHOWMSG_UPDATEDCHARGETHRESHOLD"] =  "Charges-Remaining Warning Threshold changed to ",
	["WEAPONREBUFF_UPDATEDTHRESHOLD_INSECONDS"] =  "Warning Threshold (in seconds) set to ",
	["WEAPONREBUFF_SHOWMSG_DESCRIBEHELP"] = "type |caaaaddff/wr help|r to show commands",
	["WEAPONREBUFF_SHOWMSG_DESCRIBECONFIG"] = "type |caaaaddff/wr config|r to display the config dialog",
	
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
	},
	spellNames = {
		'Windfuror-Waffe',
		'Waffe der Flammenzunge',
		'Felsbei\195\159erwaffe',
		'Waffe des Frostbrands',
		'Omen der Klarsicht'
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
