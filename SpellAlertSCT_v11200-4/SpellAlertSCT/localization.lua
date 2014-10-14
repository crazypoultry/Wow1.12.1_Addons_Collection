-- English

-- Default Spells/Emotes that will be ignored
SA_SPELLS_IGNORE = 
{	
	["bomb"] = 1; -- 11200-2
	["abolish poision"] = 1;
	["aimed shot"] = 1;
	["arcane intellect"] = 1;
	["arcane shot"] = 1;
	["argent dawn commission"] = 1;
	["aspect of the cheetah"] = 1;
	["aspect of the hawk"] = 1;
	["aspect of the monkey"] = 1;
	["attack"] = 1;
	["battle shout"] = 1;
	["bloodrage"] = 1;
	["blood craze"] = 1;
	["blood pact"] = 1;
	["battle shout"] = 1;
	["battle stance"] = 1;
	["berserker stance"] = 1;
	["blade flurry"] = 1;
	["blink"] = 1;
	["clearcasting"] = 1;
	["cold blood"] = 1;
	["concussive shot"] = 1;
	["dash"] = 1;
	["defensive stance"] = 1;
	["detect traps"] = 1;
	["devotion aura"] = 1;
	["enrage"] = 1;
	["evasion"] = 1;
	["explosive shot"] = 1;
	["fade"] = 1;
	["fire resistance aura"] = 1;
	["flurry"] = 1;
	["focused casting"] = 1;
	["haste"] = 1;
	["holy strength"] = 1;
	["inspiration"] = 1;
	["julie's blessing"] = 1;
	["presence of mind"] = 1;
	["remorseless"] = 1;
	["serpent sting"] = 1;
	["scatter shot"] = 1;
	["shield block"] = 1;
	["spirit of redemption"] = 1;
	["spirit tap"] = 1;
	["sprint"] = 1;
	["stealth"] = 1;
	["swiftshifting"] = 1;
	["travel form"] = 1;
	["trueshot aura"] = 1;
	["viper sting"] = 1;
};


SA_PTN_SPELL_BEGIN_CAST = "(.+) begins to cast (.+).";
SA_PTN_SPELL_GAINS_X = "(.+) gains (%d+) (.+).";
SA_PTN_SPELL_GAINS = "(.+) gains (.+).";
SA_PTN_SPELL_TOTEM = "(.+) casts (.+) Totem.";
SA_PTN_SPELL_FADE = "(.+) fades from (.+).";
SA_PTN_SPELL_BEGIN_PERFORM = "(.+) begins to perform (.+).";

SA_WOTF = "Will of the Forsaken";
SA_BERSERKER_RAGE = "Berserker Rage";
SA_AFFLICT_LIVINGBOMB = "You are afflicted by Living Bomb.";
SA_EMOTE_DEEPBREATH = "%s takes in a deep breath...";

SASCT_NOSCTD = "Couldn't Find SCTD Installed.  Make sure you have the latest version." -- 11200-3

SASCT_HUNTER = "Hunter";
SASCT_FEIGNDEATH = "Feign Death";
SASCT_ERRNOSTYLE = "There is an error in your settings, style not found.";
SASCT_ADDONTEST = "testing SpellAlertSCT.";
SASCT_ONY = "Onyxia";
SASCT_EMOTESPACE = " ";
SASCT_LOADPRINT = "  by BarryJ (Eugorym of Perenolde). /sasct for help";
SASCT_PROFILELOADED = " profile loaded.";

SASCT_BEGIN_CAST = "begins to cast";
SASCT_GAINS = "gains";

SASCT_NOSCT = "You must have SCT 5.0 Installed to use SpellAlertSCT."

SASCT_USAGE_HEADER_1 = "-- Usage/Help for ";
SASCT_USAGE_HEADER_2 = " by BarryJ (Eugorym of Perenolde)";
SASCT_USAGE_CRIT = "Whether or not the message should be a crit; does nothing if style is set to Message.  [Default is Off]";
SASCT_USAGE_STATUS = "Displays the current configuration options.";
SASCT_USAGE_STYLE = "Animation Style to use.  [Default is Vertical]";
SASCT_USAGE_TARGETONLY = "Whether or not to display messages from the selected target only.  [Default is Off]";
SASCT_USAGE_TEST = "Send a test message to see how it looks.  (Also done automatically after a settings change)";
SASCT_USAGE_TARGETINDICATOR = "Text to be put before and after the message, if the spell is being cast by your target.  [Default is ' *** ']";
SASCT_USAGE_RETARGET = "Retarget after feign death like old SpellAlert.  [Default is On]";
SASCT_USAGE_BOSSWARNINGS = "Deep Breath and Living Bomb Warning like old SpellAlert.  [Default is On]";
SASCT_USAGE_TOGGLE = "Toggles alerting of spell casting on and off.  [Default is On]";
SASCT_USAGE_COLOR = "Sets the color component of the specified color."; -- 11000-9
SASCT_USAGE_EMOTES = "Whether or not to display emotes along with spells.  [Default is On]"; -- 11000-9
SASCT_USAGE_COMPACT = "Whether or not to compact messages.  [Default is Off]"; -- 11000-10
SASCT_USAGE_REPEAT = "How long in seconds to refrain from repeating the same message [Default is 2]"; -- 11100-1
SASCT_USAGE_IGNORE = "Toggles using the ignore list on and off.  [Default is On]"; -- 11100-2
SASCT_USAGE_IADD = "Adds and a spell to the ignore list"; -- 11100-2
SASCT_USAGE_IREM = "Removes a spell from the ignore list"; -- 11100-2
SASCT_USAGE_COLORIZE = "Toggles colorizing the messages on and off. (overrides color choices)  [Default is On]"; -- 11100-2
SASCT_USAGE_FRAME = "Sets the frame that SpellAlertSCT will output to (only if not using the message style).  [Default is 1]"; -- 11100-3


SASCT_RETARGET_1 = "Retargetting Hunter  ";
SASCT_RETARGET_2 = " : ";

SASCT_STATUS_CRIT = "Displaying the event as a crit using the "
SASCT_STATUS_CRIT_2 = " animation style.";
SASCT_STATUS_NONCRIT = "Displaying the event as a non-crit using the "
SASCT_STATUS_TARGETONLY_ON = "TargetOnly: On";
SASCT_STATUS_TARGETONLY_OFF = "TargetOnly: Off";
SASCT_STATUS_EMOTES_ON = "Alert to emotes: On";
SASCT_STATUS_EMOTES_OFF = "Alert to emotes: Off";
SASCT_STATUS_COLOR = "Using the color (r/g/b) ";
SASCT_STATUS_COLOR_DEFAULT = " for default."; -- 11000-9
SASCT_STATUS_COLOR_TARGET = " for your target."; -- 11000-9
SASCT_STATUS_COLOR_WARN = " for boss warnings."; -- 11000-9
SASCT_STATUS_COLOR_EMOTE = " for emotes."; -- 11000-10
SASCT_STATUS_TARGETINDICATOR = "TargetIndicator: ";
SASCT_STATUS_TOGGLE_ON = "Alerting to Spell Casting Enabled."; -- 11000-9
SASCT_STATUS_TOGGLE_OFF = "Alerting to Spell Casting Disabled."; -- 11000-9
SASCT_STATUS_COMPACT_ON = "Compact Messages Enabled."; -- 11000-10
SASCT_STATUS_COMPACT_OFF = "Compact Messages Disabled."; -- 11000-10
SASCT_STATUS_BOSSWARN_ON = "Alert to Boss Warnings: On"; -- 11000-11
SASCT_STATUS_BOSSWARN_OFF = "Alert to Boss Warnings: Off"; -- 11000-11
SASCT_STATUS_REPEAT = "Message Repeat Delay: " -- 11100-1
SASCT_STATUS_IGNORE_ON = "Ignore list filtering: On"; -- 11100-2
SASCT_STATUS_IGNORE_OFF = "Ignore list filtering: Off"; -- 11100-2
SASCT_STATUS_COLORIZE_ON = "Colorize: On"; -- 11100-2
SASCT_STATUS_COLORIZE_OFF = "Colorize: Off"; -- 11100-2
SASCT_STATUS_FRAME = "Outputting to SCT Frame "; -- 11100-3

SASCT_OPT_CRIT_OFF = "Displaying as Crit - Off.";
SASCT_OPT_CRIT_ON = "Displaying as Crit - On.";
SASCT_OPT_STYLE_NOSTYLE = "You must specify a style type to use.";
SASCT_OPT_STYLE_MESSAGE = "Displaying as an SCT Message.";
SASCT_OPT_STYLE_VERTICAL = "Displaying using the Vertical animation style.";
SASCT_OPT_STYLE_RAINBOW = "Displaying using the Rainbow animation style.";
SASCT_OPT_STYLE_HORIZONTAL = "Displaying using the Horizontal animation style.";
SASCT_OPT_STYLE_ANGLEDDOWN = "Displaying using the Angled Down animation style.";
SASCT_OPT_STYLE_ANGLEDUP = "Displaying using the Angled Up animation style.";
SASCT_OPT_STYLE_SPRINKLER = "Displaying using the Sprinkler animation style.";
SASCT_OPT_STYLE_DAMAGE = "Displaying using SCTD."; -- 11200-3
SASCT_OPT_STYLE_CHOICES = "You must choose from [message/vertical/rainbow/horizontal/angled down/angled up/sprinkler/damage] for the style.";
SASCT_OPT_TARGETONLY_OFF = "Alerting to events from all entities.";
SASCT_OPT_TARGETONLY_ON = "Alerting to events from the selected target only.";
SASCT_OPT_EMOTES_OFF = "No longer alerting to emotes.";
SASCT_OPT_EMOTES_ON = "Now alerting to emotes.";
SASCT_OPT_COLOR_COICES = "You must choose a number between 0.0 and 1.0";
SASCT_OPT_TARGETINDICATOR_BLANK = "TargetIndicator set to: (blank)";
SASCT_OPT_TARGETINDICATOR_SET = "TargetIndicator set to: ";
SASCT_OPT_RESET = "Options reset.";
SASCT_OPT_RETARGET_ON = "Retarget after Feign Death- On";
SASCT_OPT_RETARGET_OFF = "Retarget after Feign Death- Off";
SASCT_OPT_BOSSWARNINGS_ON = "Boss Warnings On";
SASCT_OPT_BOSSWARNINGS_OFF = "Boss Warnings Off";
SASCT_OPT_COMPACT_ON = "Compact Messages On";
SASCT_OPT_COMPACT_OFF = "Compact Messages Off";
SASCT_OPT_REPEAT_SET = "Message Repeat Time: "; -- 11100-1
SASCT_OPT_REPEAT_ERROR = "You must enter a number."; --11100-1
SASCT_OPT_IGNORE_ON = "Ignore list filtering on"; -- 11100-2
SASCT_OPT_IGNORE_OFF = "Ignore list filtering off"; -- 11100-2
SASCT_OPT_NEEDSPELL = "You must specify a spell"; -- 11100-2
SASCT_OPT_IADD = "Now ignoring "; -- 11100-2
SASCT_OPT_IREM = "No longer ignoring "; -- 11100-2
SASCT_OPT_ILIST = "Ignoring: "; --11200-2
SASCT_OPT_COLORIZE_ON = "Colorizing on"; -- 11100-2
SASCT_OPT_COLORIZE_OFF = "Colorizing off"; -- 11100-2
SASCT_OPT_FRAME_SET = "Now outputting to frame "; -- 11100-3
SASCT_OPT_FRAME_ERROR = "You must enter a frame to output to (1 or 2)"; --11100-3
SASCT_OPT_LOAD_ERROR = "Loading Options Addon Error: "

SASCT_OPT_TOGGLE_OFF = "Disabled.";
SASCT_OPT_TOGGLE_ON = "Enabled.";
SASCT_OPT_COLOR_COLORS = "You must specify which color [red/green/blue]." -- 11000-9
SASCT_OPT_COLOR_TYPES = "You must specify which color you wish to modify [default/target/warn/emote]" -- 11000-10
