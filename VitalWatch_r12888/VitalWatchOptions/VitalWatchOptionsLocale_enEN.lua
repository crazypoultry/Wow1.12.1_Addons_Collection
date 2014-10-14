--[[ VitalWatch by Thrae
-- 
-- English Localization (Default)
-- 
--]]

-- Add below to your FIRST included localization file.
VitalWatchLocale.optLocale = getglobal("GetLocale")()

if VitalWatchLocale.optLocale then
	VitalWatchLocale.MenuTitle = "VitalWatch Options"

	VitalWatchLocale.Profiles_Opt = "Save Settings Per Character"
	VitalWatchLocale.Profiles_Desc = "Toggle whether to save your settings per character or globally."

	VitalWatchLocale.Main_Default_Opt = "Reset Options"
	VitalWatchLocale.Main_Default_Desc = "Return this addon's settings back to their defaults."

	VitalWatchLocale.Main_Health_Opt = "Health"
	VitalWatchLocale.Main_Health_Desc = "Change settings related to low or critical health."
	VitalWatchLocale.ThresholdLowHealth_Opt = "Threshold - Low Health"
	VitalWatchLocale.ThresholdLowHealth_Desc = "Change the threshold (percentage) where below which health is low. Default is 0.4, or 40%."
	VitalWatchLocale.ThresholdCritHealth_Opt = "Threshold - Critical Health"
	VitalWatchLocale.ThresholdCritHealth_Desc = "Change the threshold (percentage) where below which health is critical. Default is 0.2, or 20%."
	VitalWatchLocale.ColourLowHealth_Opt = "Message Frame Colour - Your Low Health"
	VitalWatchLocale.ColourLowHealth_Desc = "Change the colour used for your low health Message Frame alerts."
	VitalWatchLocale.ColourCritHealth_Opt = "Message Frame Colour - Your Critical Health"
	VitalWatchLocale.ColourCritHealth_Desc = "Change the colour used for your critical health Message Frame alerts."
	VitalWatchLocale.ColourLowHealthOther_Opt = "Message Frame Colour - Others' Low Health"
	VitalWatchLocale.ColourLowHealthOther_Desc = "Change the colour used for low Health Message Frame alerts."
	VitalWatchLocale.ColourCritHealthOther_Opt = "Message Frame Colour - Others' Critical Health"
	VitalWatchLocale.ColourCritHealthOther_Desc = "Change the colour used for critical health Message Frame alerts."
	VitalWatchLocale.HealthWatch_Opt = "Health Check Options"
	VitalWatchLocale.HealthWatch_Desc = "Determine who will be checked for low or critical health."
	VitalWatchLocale.PetHealthWatch_Opt = "Pet Health Check Options"
	VitalWatchLocale.PetHealthWatch_Desc = "Determine which pets will be checked for low or critical health."
	VitalWatchLocale.HealthNoWatchClass_Opt = "Ignore Class for Health"
	VitalWatchLocale.HealthNoWatchClass_Desc = "Ignore checking health for certain classes."
	VitalWatchLocale.HealthNoWatchName_Opt = "Ignore Name for Health"
	VitalWatchLocale.HealthNoWatchName_Desc = "Ignore checking health for certain players."
	VitalWatchLocale.MsgLowHealth_Opt = "Channel Message - Low Health"
	VitalWatchLocale.MsgLowHealth_Desc = "Set the message sent out to the channel of your choice when your health is low."
	VitalWatchLocale.MsgCritHealth_Opt = "Channel Message - Critical Health"
	VitalWatchLocale.MsgCritHealth_Desc = "Set the message sent out to the channel of your choice when your health is critical."
	VitalWatchLocale.MsgOtherLowHealth_Opt = "Channel Message - Others' Low Health"
	VitalWatchLocale.MsgOtherLowHealth_Desc = "Set the message sent out to the channel of your choice when someone else's health is low."
	VitalWatchLocale.MsgOtherCritHealth_Opt = "Channel Message - Others' Critical Health"
	VitalWatchLocale.MsgOtherCritHealth_Desc = "Set the message sent out to the channel of your choice when someone else's health is critical."
	VitalWatchLocale.EmoteLowHealth_Opt = "Emote - Your Low Health"
	VitalWatchLocale.EmoteLowHealth_Desc = "Set the emote used when your health is low. For voice or other builtin emotes, put / in front of the given emote command."
	VitalWatchLocale.EmoteCritHealth_Opt = "Emote - Your Critical Health"
	VitalWatchLocale.EmoteCritHealth_Desc = "Set the emote used when your health is critical. For voice or other builtin emotes, put / in front of the given emote command."
	VitalWatchLocale.SoundLowHealth_Opt = "Sound - Your Low Health"
	VitalWatchLocale.SoundLowHealth_Desc = "Change the sound played when your health is low. Just give the root filename, do not add the extension (IE, leave out .wav). Additionally, do not give a path. Instead, put your sound in the sounds folder within VitalWatch's folder."
	VitalWatchLocale.SoundCritHealth_Opt = "Sound - Your Critical Health"
	VitalWatchLocale.SoundCritHealth_Desc = "Change the sound played when your health is critical. Just give the root filename, do not add the extension (IE, leave out .wav). Additionally, do not give a path. Instead, put your sound in the sounds folder within VitalWatch's folder."
	VitalWatchLocale.SoundLowHealthOther_Opt = "Sound - Others' Low Health"
	VitalWatchLocale.SoundLowHealthOther_Desc = "Change the sound played when someone else's health is low. Just give the root filename, do not add the extension (IE, leave out .wav). Additionally, do not give a path. Instead, put your sound in the sounds folder within VitalWatch's folder."
	VitalWatchLocale.SoundCritHealthOther_Opt = "Sound - Others' Critical Health"
	VitalWatchLocale.SoundCritHealthOther_Desc = "Change the sound played when someone else's health is critical. Just give the root filename, do not add the extension (IE, leave out .wav). Additionally, do not give a path. Instead, put your sound in the sounds folder within VitalWatch's folder."
	VitalWatchLocale.DisableMessageFrameHealth_Opt = "Disable Message Frame for Health"
	VitalWatchLocale.DisableMessageFrameHealth_Desc = "Disable the Message Frame from showing health alerts."
	VitalWatchLocale.Heartbeat_Opt = "Enable Heartbeat"
	VitalWatchLocale.Heartbeat_Desc = "Enable a heartbeat-like effect where the rate of the sound gets faster as your health falls further below the set low health threshold."
	VitalWatchLocale.FlashFrameHealth_Opt = "Enable Screen Flash for Health"
	VitalWatchLocale.FlashFrameHealth_Desc = "Enable the screen flash effect for health, where the sides of the screen flash in a semi-transparent red hue at a rate determined by the amount of health below the set low health threshold."

	-- Mana
	VitalWatchLocale.Main_Mana_Opt = "Mana"
	VitalWatchLocale.Main_Mana_Desc = "Change settings related to low or critical mana."
	VitalWatchLocale.ThresholdLowMana_Opt = "Threshold - Low Mana"
	VitalWatchLocale.ThresholdLowMana_Desc = "Change the threshold (percentage) where below which mana is low. Default is 0.4, or 40%."
	VitalWatchLocale.ThresholdCritMana_Opt = "Threshold - Critical Mana"
	VitalWatchLocale.ThresholdCritMana_Desc = "Change the threshold (percentage) where below which mana is critical. Default is 0.2, or 20%."
	VitalWatchLocale.ColourLowMana_Opt = "Message Frame Colour - Your Low Mana"
	VitalWatchLocale.ColourLowMana_Desc = "Change the colour used for your low mana Message Frame alerts."
	VitalWatchLocale.ColourCritMana_Opt = "Message Frame Colour - Your Critical Mana"
	VitalWatchLocale.ColourCritMana_Desc = "Change the colour used for your critical mana Message Frame alerts."
	VitalWatchLocale.ColourLowManaOther_Opt = "Message Frame Colour - Others' Low Mana"
	VitalWatchLocale.ColourLowManaOther_Desc = "Change the colour used for low mana Message Frame alerts."
	VitalWatchLocale.ColourCritManaOther_Opt = "Message Frame Colour - Others' Critical Mana"
	VitalWatchLocale.ColourCritManaOther_Desc = "Change the colour used for critical mana Message Frame alerts."
	VitalWatchLocale.ManaWatch_Opt = "Mana Check Options"
	VitalWatchLocale.ManaWatch_Desc = "Determine who will be checked for low or critical mana."
	VitalWatchLocale.ManaNoWatchClass_Opt = "Ignore Class for Mana"
	VitalWatchLocale.ManaNoWatchClass_Desc = "Ignore checking mana for certain classes."
	VitalWatchLocale.ManaNoWatchName_Opt = "Ignore Name for Mana"
	VitalWatchLocale.ManaNoWatchName_Desc = "Ignore checking mana for certain players."
	VitalWatchLocale.MsgLowMana_Opt = "Channel Message - Low Mana"
	VitalWatchLocale.MsgLowMana_Desc = "Set the message sent out to the channel of your choice when your mana is low."
	VitalWatchLocale.MsgCritMana_Opt = "Channel Message - Critical Mana"
	VitalWatchLocale.MsgCritMana_Desc = "Set the message sent out to the channel of your choice when your mana is critical."
	VitalWatchLocale.MsgOtherLowMana_Opt = "Channel Message - Others' Low Mana"
	VitalWatchLocale.MsgOtherLowMana_Desc = "Set the message sent out to the channel of your choice when someone else's mana is low."
	VitalWatchLocale.MsgOtherCritMana_Opt = "Channel Message - Others' Critical Mana"
	VitalWatchLocale.MsgOtherCritMana_Desc = "Set the message sent out to the channel of your choice when someone else's mana is critical."
	VitalWatchLocale.EmoteLowMana_Opt = "Emote - Your Low Mana"
	VitalWatchLocale.EmoteLowMana_Desc = "Set the emote used when your mana is low. For voice or other builtin emotes, put / in front of the given emote command."
	VitalWatchLocale.EmoteCritMana_Opt = "Emote - Your Critical Mana"
	VitalWatchLocale.EmoteCritMana_Desc = "Set the emote used when your mana is critical. For voice or other builtin emotes, put / in front of the given emote command."
	VitalWatchLocale.SoundLowMana_Opt = "Sound - Your Low Mana"
	VitalWatchLocale.SoundLowMana_Desc = "Change the sound played when your mana is low. Just give the root filename, do not add the extension (IE, leave out .wav). Additionally, do not give a path. Instead, put your sound in the sounds folder within VitalWatch's folder."
	VitalWatchLocale.SoundCritMana_Opt = "Sound - Your Critical Mana"
	VitalWatchLocale.SoundCritMana_Desc = "Change the sound played when your mana is critical. Just give the root filename, do not add the extension (IE, leave out .wav). Additionally, do not give a path. Instead, put your sound in the sounds folder within VitalWatch's folder."
	VitalWatchLocale.SoundLowManaOther_Opt = "Sound - Others' Low Mana"
	VitalWatchLocale.SoundLowManaOther_Desc = "Change the sound played when someone else's mana is low. Just give the root filename, do not add the extension (IE, leave out .wav). Additionally, do not give a path. Instead, put your sound in the sounds folder within VitalWatch's folder."
	VitalWatchLocale.SoundCritManaOther_Opt = "Sound - Others' Critical Mana"
	VitalWatchLocale.SoundCritManaOther_Desc = "Change the sound played when someone else's mana is critical. Just give the root filename, do not add the extension (IE, leave out .wav). Additionally, do not give a path. Instead, put your sound in the sounds folder within VitalWatch's folder."
	VitalWatchLocale.DisableMessageFrameMana_Opt = "Disable Message Frame for Mana"
	VitalWatchLocale.DisableMessageFrameMana_Desc = "Disable the Message Frame from showing mana alerts."
	VitalWatchLocale.FlashFrameMana_Opt = "Enable Screen Flash for Mana"
	VitalWatchLocale.FlashFrameMana_Desc = "Enable the screen flash effect for mana, where the sides of the screen flash in a semi-transparent red hue at a rate determined by the amount of mana below the set low mana threshold."

	-- Aggro
	VitalWatchLocale.Main_Aggro_Opt = "Aggro"
	VitalWatchLocale.Main_Aggro_Desc = "Change settings related to aggro (under attack) messages."
	VitalWatchLocale.ColourAggro_Opt = "Message Frame Colour - Your Aggro"
	VitalWatchLocale.ColourAggro_Desc = "Change the colour used for your aggro Message Frame alerts."
	VitalWatchLocale.ColourAggroOther_Opt = "Message Frame Colour - Other Aggro"
	VitalWatchLocale.ColourAggroOther_Desc = "Change the colour used for other aggro Message Frame alerts."
	VitalWatchLocale.AggroTargetWatch_Opt = "Target Aggro Check Options"
	VitalWatchLocale.AggroTargetWatch_Desc = "Determine how we will search through your own, party, and raid members targets and targets of targets, if at all."
	VitalWatchLocale.AggroLogWatch_Opt = "Combat Log Aggro Check Options"
	VitalWatchLocale.AggroLogWatch_Desc = "Determine how we will search through your own, party, and raid members combat log messages, if at all."
	VitalWatchLocale.AggroNoWatchClass_Opt = "Ignore Class for Aggro"
	VitalWatchLocale.AggroNoWatchClass_Desc = "Ignore checking aggro for certain classes."
	VitalWatchLocale.AggroNoWatchName_Opt = "Ignore Name for Aggro"
	VitalWatchLocale.AggroNoWatchName_Desc = "Ignore checking aggro for certain players."
	VitalWatchLocale.AggroWatchRate_Opt = "Your Aggro Refresh Rate"
	VitalWatchLocale.AggroWatchRate_Desc = "Change the rate at which your own aggro (under attack) status is forcibly refreshed. Default is 3 seconds."
	VitalWatchLocale.AggroWatchRateOther_Opt = "Others' Aggro Refresh Rate"
	VitalWatchLocale.AggroWatchRateOther_Desc = "Change the rate at which aggro (under attack) status is forcibly refreshed. Default is 5 seconds."
	VitalWatchLocale.MsgAggro_Opt = "Channel Message - Your Aggro"
	VitalWatchLocale.MsgAggro_Desc = "Set the message sent out to the channel of your choice when you are under attack."
	VitalWatchLocale.MsgAggroOther_Opt = "Channel Message - Others' Aggro"
	VitalWatchLocale.MsgAggroOther_Desc = "Set the message sent out to the channel of your choice when someone else is under attack."
	VitalWatchLocale.EmoteLowAggro_Opt = "Emote - Your Aggro"
	VitalWatchLocale.EmoteLowAggro_Desc = "Set the emote used when you are under attack. For voice or other builtin emotes, put / in front of the given emote command."
	VitalWatchLocale.SoundAggro_Opt = "Sound - Your Aggro"
	VitalWatchLocale.SoundAggro_Desc = "Change the sound played when you are under attack. Just give the root filename, do not add the extension (IE, leave out .wav). Additionally, do not give a path. Instead, put your sound in the sounds folder within VitalWatch's folder."
	VitalWatchLocale.SoundAggroOther_Opt = "Sound - Others' Aggro"
	VitalWatchLocale.SoundAggroOther_Desc = "Change the sound played when someone else is under attack. Just give the root filename, do not add the extension (IE, leave out .wav). Additionally, do not give a path. Instead, put your sound in the sounds folder within VitalWatch's folder."
	VitalWatchLocale.EnableMessageFrameAggro_Opt = "Enable Message Frame Aggro Alerts"
	VitalWatchLocale.EnableMessageFrameAggro_Desc = "Enable the Message Frame to show aggro (under attack) alerts."

	-- Messages (Misc)
	VitalWatchLocale.Main_Messages_Opt = "Messages and Misc"
	VitalWatchLocale.Main_Messages_Desc = "Change the way messages are handled for all alerts, as well as other settings."
	VitalWatchLocale.MessageLogFade_Opt = "Log Fade Time"
	VitalWatchLocale.MessageLogFade_Desc = "Change the fade time for the message log entries. Must be above 0."
	VitalWatchLocale.MaxMessages_Opt = "Maximum Log Messages"
	VitalWatchLocale.MaxMessages_Desc = "Change the number of maximum messages allowed on the log. Must be above 0."
	VitalWatchLocale.MsgRate_Opt = "Emote and Channel Message Rate"
	VitalWatchLocale.MsgRate_Desc = "Change the throttled rate at which emotes and channel messages are sent. Default is 0.2, or every 200 milliseconds."
	VitalWatchLocale.MsgChan_Opt = "Message Channel for Your Health/Mana Alerts"
	VitalWatchLocale.MsgChan_Desc = "Change the channel used for your own health and mana alerts."
	VitalWatchLocale.MsgChanOther_Opt = "Message Channel for Other Health/Mana Alerts"
	VitalWatchLocale.MsgChanOther_Desc = "Change the channel used for other health and mana alerts."
	VitalWatchLocale.MsgAggroChan_Opt = "Message Channel for Your Aggro Alerts"
	VitalWatchLocale.MsgAggroChan_Desc = "Change the channel used for your own aggro (under attack) alerts."
	VitalWatchLocale.MsgAggroChanOther_Opt = "Message Channel for Other Aggro Alerts"
	VitalWatchLocale.MsgAggroChanOther_Desc = "Change the channel used for other aggro (under attack) alerts."
	VitalWatchLocale.EnableInBGs_Opt = "Enable Channel Messages / Emotes in Battlegrounds"
	VitalWatchLocale.EnableInBGs_Desc = "As Battlegrounds is PvP, public messages and emotes are silenced by default."
	VitalWatchLocale.DisableMsg_Opt = "Disable Channel Messages"
	VitalWatchLocale.DisableMsg_Desc = "Disable channel messages from being sent. This does not effect your other settings."

	VitalWatchLocale.PlayerOnly = "Player Only"
	VitalWatchLocale.PlayerMap = {
		[1] = "Disabled",
		[2] = "Player and Party",
		[3] = "All"
	}
	VitalWatchLocale.YourPet = "Your Pet"
	VitalWatchLocale.PetMap = {
		[1] = "Disabled",
		[2] = "Your Pet and Party Pets",
		[3] = "All Pets"
	}
	VitalWatchLocale.Disabled = "Disabled"
	VitalWatchLocale.AggroMap = {
		[1] = "Player Only",
		[2] = "Player and Party",
		[3] = "All"
	}
	VitalWatchLocale.PARTY = "PARTY"
	VitalWatchLocale.AddCustomChannel_Opt = "Custom Channel..."
	VitalWatchLocale.AddCustomChannel_Desc = "Add a custom channel."
	VitalWatchLocale.ChannelMap = {
		["RAID"] = "RAID",
		["GUILD"] = "GUILD",
		["BATTLEGROUP"] = "BATTLEGROUP",
		["SAY"] = "SAY"
	}
	VitalWatchLocale.ClassMap = {
		["WARRIOR"] = "Warrior",
		["ROGUE"] = "Rogue",
		["DRUID"] = "Druid",
		["PRIEST"] = "Priest",
		["MAGE"] = "Mage",
		["WARLOCK"] = "Warlock",
		["HUNTER"] = "Hunter",
		["PALADIN"] = "Paladin",
		["SHAMAN"] = "Shaman"
	}
	VitalWatchLocale.ManaClassMap = {
		["DRUID"] = "Druid",
		["PRIEST"] = "Priest",
		["MAGE"] = "Mage",
		["WARLOCK"] = "Warlock",
		["HUNTER"] = "Hunter",
		["PALADIN"] = "Paladin",
		["SHAMAN"] = "Shaman"
	}

	VitalWatchLocale.AddName = "Add Name"
	VitalWatchLocale.More = "more..."

	-- slash command-related stuff
	VitalWatchLocale.DefaultWarning = "Are you SURE you want to return your settings to their default values? Type in "
	VitalWatchLocale.NotValidCommand = "is not a valid command."

	VitalWatchLocale.Confirm = "confirm" -- must be lowercase!
	VitalWatchLocale.Slash_Default_Opt = "default" -- ditto

	-- Defaults
	VitalWatchLocale.DEFAULT_MsgLowHealth 		= "My health is low!"
	VitalWatchLocale.DEFAULT_MsgLowMana				= "My mana is low!"
	VitalWatchLocale.DEFAULT_MsgCritMana			= "My mana is CRITICAL!"
	VitalWatchLocale.DEFAULT_MsgAggro					= "I am under attack by"
	VitalWatchLocale.DEFAULT_MsgAggroOther 		= "is under attack by"

	-- Below are voice emotes for your locale. On an English client, you
	-- would type in /oom to announce to everyone you're out of mana. To
	-- properly translate, you must find out the command for your locale.
	VitalWatchLocale.DEFAULT_EmoteLowHealth		= "/helpme"
	VitalWatchLocale.DEFAULT_EmoteCritHealth	= "/healme"

	-- Below is just a regular emote through /emote.
	VitalWatchLocale.DEFAULT_EmoteLowMana			= "is low on mana!"

	VitalWatchLocale.optLocale = nil -- we're done with this
end

