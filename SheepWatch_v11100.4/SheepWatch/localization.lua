-- General

SHEEPWATCH_VERSION = "11100.4"

-- English localization

SHEEPWATCH_SPELL = "Polymorph"
SHEEPWATCH_SPELL2 = "Polymorph: Pig"

SHEEPWATCH_TEXT_LOADED = "SheepWatch " .. SHEEPWATCH_VERSION .. " loaded - Configure with /sheepwatch"
SHEEPWATCH_TEXT_WORLD_NOT_LOADED = "World isn't loaded. Please wait..."
SHEEPWATCH_TEXT_PROFILECLEARED = "SheepWatch: Your settings are incompatible for this version so your profile was cleared.\nSheepWatch: Please configure SheepWatch with /sheepwatch"
SHEEPWATCH_TEXT_LOCKED = "SheepWatch: Frame locked."
SHEEPWATCH_TEXT_UNLOCKED = "SheepWatch: Frame unlocked for moving."
SHEEPWATCH_TEXT_RANK  = " of Polymorph spell saved."
SHEEPWATCH_TEXT_NORANK  = "SheepWatch: Error: No " .. SHEEPWATCH_SPELL .. " rank found!\nSheepWatch: I disabled myself for this session."
SHEEPWATCH_TEXT_ANNOUNCE_NOTARGET = "SheepWatch: Wrong announce target.\nSheepWatch: Please set it with \'/sheepwatch target <value>\'\nSheepWatch: Allowed values are: say party guild raid auto"
SHEEPWATCH_TEXT_ANNOUNCE = "$s ($r) cast on $t (Lvl $l)"
SHEEPWATCH_TEXT_ANNOUNCE_CAST = " cast on "
SHEEPWATCH_TEXT_ANNOUNCE_BREAK = SHEEPWATCH_SPELL .. " broke on "
SHEEPWATCH_TEXT_ANNOUNCE_FADE = SHEEPWATCH_SPELL .. " faded from "
SHEEPWATCH_TEXT_ANNOUNCE_LEAVECOMBAT = "SheepWatch: You left combat mode. Resetting.."
SHEEPWATCH_TEXT_ANNOUNCE_TARGETSUCCESS = "SheepWatch: Re-Targeting successfull."
SHEEPWATCH_TEXT_ANNOUNCE_TARGETFAILED = "SheepWatch: Re-Targeting failed."
SHEEPWATCH_TEXT_ANNOUNCE_ABORTCAST = "SheepWatch: Casting aborted."
SHEEPWATCH_TEXT_RESETPOS = "SheepWatch: Bar position reset"
SHEEPWATCH_TOOLTIP_TRANSPARENCY = "Drag the slider to change the bar transparency"
SHEEPWATCH_TOOLTIP_SCALING = "Drag the slider to change the bar scaling"
SHEEPWATCH_LABEL_ANNOUNCEPATTERN = "$t=Target $l=Level $s=Spell $r=Rank" 
SHEEPWATCH_LABEL_ENABLE = "Enable SheepWatch"
SHEEPWATCH_LABEL_ANNOUNCE = "Announce the Polymorph"
SHEEPWATCH_LABEL_VERBOSE = "Be verbose"
SHEEPWATCH_LABEL_CLOSE = "Close"
SHEEPWATCH_LABEL_MOVE = "Move bar"
SHEEPWATCH_LABEL_MOVE2 = "Lock bar"
SHEEPWATCH_LABEL_ANNOUNCE_TARGET_LABEL = "Announce to:"
SHEEPWATCH_LABEL_ANNOUNCE_TIME_LABEL = "Announce when:"
SHEEPWATCH_LABEL_COUNTER = "Display an additional counter"
SHEEPWATCH_LABEL_COUNTER_DIGITS = "Show miliseconds"
SHEEPWATCH_LABEL_DIRECTION_LABEL = "Bar direction:"
SHEEPWATCH_LABEL_COLOR_LABEL = "Bar color:"
SHEEPWATCH_LABEL_TRANSPARENCY = "Bar transparency"
SHEEPWATCH_LABEL_SCALING = "Bar scaling"
SHEEPWATCH_LABEL_EDITBOX = "Announce pattern:"
SHEEPWATCH_LIST_DIRECTIONS = { 
					{ name = "Increasing", value = 1 },
					{ name = "Decreasing", value = 2 }
}
SHEEPWATCH_LIST_ANNOUNCETIME = {
					{ name = "Before the cast", value = 1 },
					{ name = "After the cast", value = 2 }
}
-- DON'T LOCALIZE THIS
SHEEPWATCH_LIST_ANNOUNCETARGETS = {
					{ name = "SAY", value = 1 },
					{ name = "YELL", value = 2 },
					{ name = "PARTY", value = 3 },
					{ name = "RAID", value = 4 },
					{ name = "GUILD", value = 5 },
					{ name = "AUTO", value = 6 }
}


SHEEPWATCH_HELP1  = " - Configure with '/sheepwatch'"

SHEEPWATCH_EVENT_ON = "(.+) is afflicted by (.+)."
SHEEPWATCH_EVENT_CAST = "You cast (.+) on (.+)."
SHEEPWATCH_EVENT_BREAK = "(.+)'s (.+) is removed."
SHEEPWATCH_EVENT_FADE = "(.+) fades from (.+)."
SHEEPWATCH_EVENT_DEATH = "(.+) has died."