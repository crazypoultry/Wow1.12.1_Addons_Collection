--[[ VitalWatch by Thrae
-- 
-- German Localization
-- Any wrong words, change them here.
-- 
-- VitalWatchLocale should be defined in your FIRST included
-- localization file.
--
-- Contributors: Slayman
--]]

if VitalWatchLocale.locale and VitalWatchLocale.locale == "deDE" then
	VitalWatchLocale.LogTitle = "VitalWatch Log"

	VitalWatchLocale.AlteracValley 	= "Alteractal"
	VitalWatchLocale.ArathiBasin		= "Arathibecken"
	VitalWatchLocale.WarsongGulch		= "Warsongschlucht"

	VitalWatchLocale.Floating_Message_Self_LowHealth 	= "Your health is low!"
	VitalWatchLocale.Floating_Message_Self_CritHealth = "Your health is CRITICAL!"
	VitalWatchLocale.Floating_Message_Self_LowMana 		= "Your mana is low!"
	VitalWatchLocale.Floating_Message_Self_CritMana 	= "Your mana is CRITICAL!"

	VitalWatchLocale.Floating_Message_LowHealth 	= "'s health is low!"
	VitalWatchLocale.Floating_Message_CritHealth	= "'s health is CRITICAL!"
	VitalWatchLocale.Floating_Message_LowMana 		= "'s mana is low!"
	VitalWatchLocale.Floating_Message_CritMana		= "'s mana is CRITICAL!"

	VitalWatchLocale.Floating_Message_AggroGainedOther 	= "is under attack!"
	VitalWatchLocale.Floating_Message_AggroGained				= "You are under attack!"
	VitalWatchLocale.AGGRO = "AGGRO: "
	VitalWatchLocale.aggrocount = "aggro'd ~"

	VitalWatchLocale.MyPetTag				= " (my pet)"
	VitalWatchLocale.PetTag					= " (pet)"

	VitalWatchLocale.DEFAULT_MsgCritHealth		= "My health is CRITICAL!"

	-- Below are voice emotes for your locale. On an English client, you
	-- would type in /oom to announce to everyone you're out of mana. To
	-- properly translate, you must find out the command for your locale.
	VitalWatchLocale.DEFAULT_EmoteCritMana		= "/oom"

	VitalWatchLocale.locale = nil -- we no longer need this
end
