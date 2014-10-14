--[[ $Id: enUS.lua 15757 2006-11-02 15:26:11Z fenlis $ ]]--
local L = AceLibrary("AceLocale-2.2"):new("myBindings2")

L:RegisterTranslations("enUS", function()
	return {
		["An enhanced key bindings interface."] = true,
		["Opens the myBindings2 interface"] = true,
		
		["Standard Interface"] = true,
	    	["Action Bars"] = true,
	    	["Auction"] = true,
	    	["Audio"] = true,
	    	["Battlegrounds/PvP"] = true,
	    	["Buffs"] = true,
	    	["Chat/Communication"] = true,
	    	["Class"] = true,
	    	["Healer"] = true,
	    	["Tank"] = true,
	    	["Caster"] = true,
	    	["Combat"] = true,
	    	["Compilations"] = true,
	    	["Data Export"] = true,
	    	["Development Tools"] = true,
	    	["Guild"] = true,
	    	["Frame Modification"] = true,
	    	["Interface Enhancements"] = true,
	    	["Inventory"] = true,
	    	["Library"] = true,
	    	["Map"] = true,
	    	["Mail"] = true,
	    	["Miscellaneous"] = true,
	    	["Quest"] = true,
	    	["Raid"] = true,
	    	["Tradeskill"] = true,
	    	["UnitFrame"] = true,
		
		["MultiActionBar Bottom Left"] = true,
		["MultiActionBar Bottom Right"] = true,
		["MultiActionBar Right Side 1"] = true,
		["MultiActionBar Right Side 2"] = true,
		
		["Game Defaults"] = true,
	        ["Confirm"] = true,
	        ["Cancel"] = true,
	        ["Unbind"] = true,
	        ["Save"] = true,

		["Profile: |cffffffff%s|r"] = true,
		["|cffff0000%s is already bound to %s. Confirm replacement.|r"] = true,
		["Can't bind mousewheel to actions with up and down states"] = true,
		["Slash-Commands"] = { "/mybindings2", "/myb2" },
	}
end)
