--[[-------------------------------------------------------------------------
-- Bartender2_Pagemaster - Performs page swaps on bar 1 when you hold shift, ctrl, alt, etc.
--  original version by Khyax and Mikma
--  extended by PProvost to include features from Greywind's Bartender2_Druidbar
--
--  Last Modified: $Date: 2006-10-19 00:39:17 -0400 (Thu, 19 Oct 2006) $
--  Revision: $Revision: 14374 $
--]]-------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Bartender_Pagemaster")

L:RegisterTranslations("enUS", function()
	return {	
		["OPT_TARGETFRIENDLYPAGE_NAME"] = "Target Friendly Page",
		["OPT_TARGETFRIENDLYPAGE_DESC"] = "Page # to use when targeting friendlies. Set to zero to disable.",

		["OPT_SHIFTPAGE_NAME"] = "SHIFT Page",
		["OPT_SHIFTPAGE_DESC"] = "Page # to use when shift key pressed. Set to zero to disable.",

		["OPT_CONTROLPAGE_NAME"] = "CTRL Page",
		["OPT_CONTROLPAGE_DESC"] = "Page # to use when CTRL key pressed. Set to zero to disable.",

		["OPT_ALTPAGE_NAME"] = "ALT Page",
		["OPT_ALTPAGE_DESC"] = "Page # to use when ALT key pressed. Set to zero to disable.",

		["OPT_PROWLPAGE_NAME"] = "Prowl Page (Druid)",
		["OPT_PROWLPAGE_DESC"] = "Page # to use when Prowling in Druid Cat-form. Set to zero to disable.",

		["OPT_SHADOWFORMPAGE_NAME"] = "Shadowform Page (Priest)",
		["OPT_SHADOWFORMPAGE_DESC"] = "Page # to use while in Shadowform with Priest. Set zero to disable.",
	}
end)
