RAIDHEALER_NAME 						= "RaidHealer";
RAIDHEALER_CLOSE 						= "Close";
RAIDHEALER_LOADED						= "loaded";

RAIDHEALER_TAB1_TEXT				= "Heal-Assignments";
RAIDHEALER_TAB2_TEXT				= "Buff-Assignments";
RAIDHEALER_TAB3_TEXT				= "Configuration";

RAIDHEALER_ANNOUNCE					= "Announce";
RAIDHEALER_ONLY_CLASS				= "Only Class";
RAIDHEALER_ONLY_BUFF				= "Only Buff";
RAIDHEALER_RESET						= "Reset";
RAIDHEALER_HEALCLASSES_TXT	= "Heal Classes";
RAIDHEALER_UNASSIGNED				= "Unassigned";
RAIDHEALER_AUTOMATIC				= "Automatic";

RAIDHEALER_GROUP						= "Group ";

RAIDHEALER_HA_DESC					= "Assign healers to tanks by simply clicking checkboxes. Afterwards announce to channel/player.";
RAIDHEALER_YOU_HEAL					= "You heal ";
RAIDHEALER_YOU_HEAL_NOTHING	= "You have no heal assignments. Please heal random.";
RAIDHEALER_HEALS						= " heals ";

RAIDHEALER_BA_DESC					= "Assign buffer to groups by simply clicking checkboxes. Afterwards announce to channel/player.";
RAIDHEALER_YOU_BUFF					= "You buff ";
RAIDHEALER_YOU_BUFF_NOTHING	= "You have no buff assignments. Watch on missings.";
RAIDHEALER_BUFFS						= " buffs ";

RAIDHEALER_HEAL_ASSIGNMENT			= "Attention: Heal Assignment";
RAIDHEALER_HEAL_ASSIGNMENT_SEP	= "-------------------------------------------------------";
RAIDHEALER_BUFF_ASSIGNMENT			= "Attention: Buff Assignment";
RAIDHEALER_BUFF_ASSIGNMENT_SEP	= "-------------------------------------------------------";

RAIDHEALER_ONLYINRAID				= "Full functionality only available when in a raid group.";
RAIDHEALER_ONLYINRAID_INFO	= "The info frame is only available when in a raid group.";

RAIDHEALER_WHISPER_SETUP					= "Whisper Setup";
RAIDHEALER_WHISPER_ASSIGNMENT			= "Whisper Assignments";
RAIDHEALER_WHISPER_HIDE_OUTGOING	= "Hide outgoing whispers";
RAIDHEALER_WHISPER_HIDE_INCOMMING	= "Hide incoming whispers";

RAIDHEALER_CHANNEL_SETUP					= "Channel Setup";
RAIDHEALER_SPECIALGLOBALCHANNELS	= { "LookingForGroup", "WorldDefense" };

RAIDHEALER_MINIMAP_SETUP					= "Minimap Button Setup";
RAIDHEALER_SHOW_MINIMAP_BUTTON		= "Show minimap button";
RAIDHEALER_MINIMAP_PLACEMENT			= "Button Placement";

RAIDHEALER_ANNOUNCEMENTS_SETUP		= "Announcement Setup";
RAIDHEALER_ANNOUNCEMENTS_ALT			= "Use alternative ann.";
RAIDHEALER_ANNOUNCEMENTS_ALT_TT		= "If checked tanks will be announced with their healers. If unckecked healers will be announced with their targets.";
RAIDHEALER_ANNOUNCEMENTS_HEAL			= "Hide heal announcement";
RAIDHEALER_ANNOUNCEMENTS_BUFF			= "Hide buff announcement";
RAIDHEALER_ANNOUNCEMENTS_HIDE_TT	= "If checked announcements will not be posted to the channel, but whispered if selected.";

RAIDHEALER_INNERVATE_SETUP				= "Innervate Setup (only for Druids)";
RAIDHEALER_INNERVATE_ALERT				= "Show lowest priest bar";
RAIDHEALER_INNERVATE_ALERT_TT			= "Shows a mana bar for the lowest priest which is under the percentage you set.\n\nLeft-Click on the bar will target the player.\n\nRight-Click will cast Innervate if you have no cooldown and priest hasn't an innervate already.";
RAIDHEALER_INNERVATE_ALERT_VALUE	= "Show when a priests mana is under %s%%.";
RAIDHEALER_INNERVATE_RAID					= "Announce innervate to /ra";
RAIDHEALER_INNERVATE_SAY					= "Announce innervate to /s";

RAIDHEALER_INNERVATE_ANNOUNCES		= {
	"%s got innervated. Don't die right now!",
	"Mana is power, %s now has the power - don't waste it.",
	"Do you save your mana pots %s?. Well here is your innervate.",
	"%s feels innervated.",
	"Chance of survival increased!. %s soon has enough mana to heal."
}

RAIDHEALER_NOT_IN_GROUP						= "You are not in my raid group";
RAIDHEALER_NOT_A_HEALER						= "You do not have a healing spell.";
RAIDHEALER_NOT_A_BUFFER						= "You do not have a long running buff spell.";

RAIDHEALER_TANK_DD_TOOLTIP				= "Select the desired tank class.";

RAIDHEALER_SHOW_INFOFRAME_NOTE		= "To show the info frame again type /rh info";

RAIDHEALER_CLASS_NAMES = {
	["WARRIOR"]	= "Warrior",
	["PRIEST"]	= "Priest",
	["PALADIN"]	= "Paladin",
	["DRUID"]	= "Druid",
	["SHAMAN"]	= "Shaman",
	["WARLOCK"]	= "Warlock",
	["MAGE"]	= "Mage",
	["ROGUE"]	= "Rogue",
	["HUNTER"]	= "Hunter"
};
