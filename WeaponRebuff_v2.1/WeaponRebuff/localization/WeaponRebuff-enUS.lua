local T = AceLibrary("AceLocale-2.0"):new("WeaponRebuff")
T:RegisterTranslations("enUS", function()
	 return {
	["WR_MINUTE"] = "min",
	["WR_SECOND"] =  "sec",
	["WR_CHARGES"] =  "Charges",
	["ERROR_NO_BUFFS_REMEMBERED"] =  "There are no buffs remembered!",
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
	},
	
	spellNames = {
		'Windfury Weapon',
		'Flametongue Weapon',
		'Rockbiter Weapon',
		'Frostbrand Weapon',
		'Omen of Clarity'
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
