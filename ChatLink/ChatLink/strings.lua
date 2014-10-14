--[[
strings.lua

Strings for ChatLink.  Makes for easy editing and localization.
]]--

-- ENGLISH LANGUAGE STRINGS.
-- Function strings.
STR_CHATLINK_LOADED = "ChatLink %s loaded."

-- System channel names.
STR_GENERAL = "General -"
STR_TRADE = "Trade -"
STR_LFG = "LookingForGroup -"
STR_LOCALDEF = "LocalDefense -"
STR_WORLDDEF = "WorldDefense"


-- GERMAN LANGUAGE STRINGS.
if (GetLocale() == "deDE") then
	-- Function strings.
	STR_CHATLINK_LOADED = "ChatLink %s geladen."

	-- System channel names.
	STR_GENERAL = "Allgemein -"
	STR_TRADE = "Handel -"
	STR_LFG = "SucheNachGruppe -"
	STR_LOCALDEF = "LokaleVerteidigung -"
	STR_WORLDDEF = "WeltVerteidigung"
end


-- FRENCH LANGUAGE STRINGS.
if (GetLocale() == "frFR") then
	-- Function strings.
	STR_CHATLINK_LOADED = "ChatLink %s charg\195\169."

	-- System channel names.
	STR_GENERAL = "G\195\169n\195\169ral -"
	STR_TRADE = "Commerce -"
	STR_LFG = "RechercheGroupe -"
	STR_LOCALDEF = "D\195\169fenseLocale -"
	STR_WORLDDEF = "D\195\169fenseUniverselle"
end
