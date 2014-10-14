local L = AceLibrary("AceLocale-2.0"):new("FuBar_oRA2CooldownFu")

L:RegisterTranslations("enUS", function() return {
	["Ready"]		= true,
	["Offline"]		= true,
	
	["ora2cooldownfuparticipant"] = true,
	["Participant/CooldownFu"] = true,
	
	["Show Druids"] = true,
	["Shows cooldown of combat resurrections in tooltip."] = true,
	["Show Warlocks"]								= true,
	["Shows cooldown of soulstones in tooltip."]	= true,
	["Show Shaman"]									= true,
	["Shows ankh cooldown timer in tooltip."]		= true,

	["DRUIDheader"]		= "Rebirth",
	["WARLOCKheader"]	= "Soulstone",
	["SHAMANheader"]	= "Ankh",

	["Active"]		= true,
	["Inactive"]	= true
	
} end)
