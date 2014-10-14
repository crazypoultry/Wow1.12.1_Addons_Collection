--[[

	File containing localized strings
	for Simplified Chinese and English versions, defaults to English

]]

local localization_loader = getglobal("SCS_Localization_"..GetLocale())
if( localization_loader ) then localization_loader()
else
	-- English localized variables (default)
	-- general
	SCS_Localization_enUS()
end

localization_loader = nil
