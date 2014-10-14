--[[ VitalWatch by Thrae
-- 
-- Chinese Localization
-- Any wrong words, change them here.
-- 
-- VitalWatchLocale should be defined in your FIRST included
-- localization file.
--
-- Contributors: Yzerman
--]]

VitalWatchLocale = {}
VitalWatchLocale.locale = getglobal("GetLocale")()

if VitalWatchLocale.locale and VitalWatchLocale.locale == "zhCN" then
	VitalWatchLocale.LogTitle = "VitalWatch Log"

	VitalWatchLocale.AlteracValley 	= "\229\165\165\231\137\185\229\133\176\229\133\139\229\177\177\232\176\183"
	VitalWatchLocale.ArathiBasin		= "\233\152\191\230\139\137\229\184\140\231\155\134\229\156\176"
	VitalWatchLocale.WarsongGulch		= "\230\136\152\230\173\140\229\179\161\232\176\183"

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
