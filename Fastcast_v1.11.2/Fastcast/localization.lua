------------------------------------------------------------------------------
-- Globals required by localized tables
------------------------------------------------------------------------------
FASTCAST_EM = {
	ON = "|cffffff00",					-- Yellow (default emphasis color)
	RED = "|cffff4000",					-- Red (used for warnings)
	OFF = "|r",
};


------------------------------------------------------------------------------
-- English localization (default) ,Korean localization
--
-- Original text by Cirk
-- Korean text by Bitz
------------------------------------------------------------------------------
-- For parsing spell names
FASTCAST_SPELLDATA = {
	NAME_AND_RANK_PATTERN = "^([^%(]+)%(?([^%(%)]-)%)?$",
};

-- General strings
FASTCAST_TEXT = {
	FRAME_TITLE = "Fastcast",
	FAST_ENABLE_OPTION = "Enable fast casting",
	FAST_CASTBAR_OPTION = "Adjust casting bar",
	FAST_PLAY_SOUND_OPTION = "Play sound effect",
	FAST_PADDING_TEXT = "Cast time padding",
	CHANNEL_PROTECT = "Protect channeled spells",
	CHANNEL_MAXIMUM_TEXT = "Maximum protected time",

	HELP_BUTTON_TEXT = "[?]",
	HELP_FAST_TITLE = "Fast casting",
	HELP_FAST_DESC = "Fast casting allows you to automatically stop casting your current spell early and start casting a new one in such a way that the first spell is still cast successfully.\n\nInstant cast spells are not affected by fast casting.\n\nYou can optionally have fast cast |cffffd100adjust the casting bar|r so that the casting bar reflects the actual spell timing, meaning when casting reaches the end of the bar, you can cast again.  You can also optionally have fast cast |cffffd100play a sound effect|r when you are trying to cast again before the end of the current spell has been reached to give you better feedback.\n\nThe |cffffd100cast time padding|r (in seconds) should be set large enough to absorb typical variations in the communication delay between your client and the server.  Smaller values will allow you to cast your spells one after another faster, but will have a higher chance of being interrupted or failing to cast.  Larger values will slow down how quickly you can cast spells one after another, but will improve your spell casting reliability.",
	HELP_CHANNEL_TITLE = "Channeling protection",
	HELP_CHANNEL_DESC = "Channeling protection prevents you from accidentally canceling or restarting a currently channeled spell when pressing the same casting action key or button, allowing you to spam your channeled spells just like you can do with normal cast-time spells.\n\nAny other spell cast action will still interrupt the current channeled spell.\n\nThe |cffffd100maximum protected time|r is the longest time (in seconds) for which your channeled spell will be protected from being cancelled or restarted while they are casting.  Changing this value allows you to keep your channeled spells protected when you need them (e.g., when starting a new cast), while still allowing you to cancel or recast your spells after the protected time (e.g., for spells like priest's Mind Vision or warlock's Drain Soul).",
	HELP_NO_CHANNEL_DESC = "Your class does not have any channeled spells, so this feature is disabled.",
	
	DEBUG = FASTCAST_EM.ON.."Fastcast: "..FASTCAST_EM.OFF;
	WARNING_DISABLED_ISCASTING = FASTCAST_EM.RED.."Fastcast warning: "..FASTCAST_EM.OFF.."FastcastIsCasting() requires fast-casting to be enabled!",
	WARNING_DISABLED_STOPCASTING = FASTCAST_EM.RED.."Fastcast warning: "..FASTCAST_EM.OFF.."FastcastStopCasting() requires fast-casting to be enabled!",
}

-- Slash commands and responses
FASTCAST_COMMANDS = {
	-- Slash commands
	COMMAND_HELP = "help",
	COMMAND_ON = "on",
	COMMAND_ENABLE = "enable",
	COMMAND_OFF = "off",
	COMMAND_DISABLE = "disable",
	COMMAND_FAST = "fast",
	COMMAND_PROTECT = "protect",
	COMMAND_STATUS = "status",
	COMMAND_DEBUGON = "debugon",
	COMMAND_DEBUGOFF = "debugoff",

	-- Slash command responses
	COMMAND_FAST_ENABLE_CONFIRM = FASTCAST_EM.ON.."Fast-casting mode is enabled."..FASTCAST_EM.OFF,
	COMMAND_FAST_DISABLE_CONFIRM = FASTCAST_EM.ON.."Fast-casting mode is disabled."..FASTCAST_EM.OFF,
	COMMAND_FAST_PADDING_FORMAT = FASTCAST_EM.ON.."Fast-casting padding set to %.2f seconds."..FASTCAST_EM.OFF;
	COMMAND_FAST_ENABLED_STATUS_FORMAT = FASTCAST_EM.ON.."Fast-casting mode is currently enabled with padding %.2f seconds."..FASTCAST_EM.OFF,
	COMMAND_FAST_DISABLED_STATUS = FASTCAST_EM.ON.."Fast-casting mode is currently disabled."..FASTCAST_EM.OFF,
	COMMAND_FAST_NOT_ENABLED = FASTCAST_EM.ON.."Fast-casting mode must be enabled to use this option."..FASTCAST_EM.OFF,
	COMMAND_PROTECT_ENABLE_CONFIRM = FASTCAST_EM.ON.."Channeling protection is enabled."..FASTCAST_EM.OFF,
	COMMAND_PROTECT_DISABLE_CONFIRM = FASTCAST_EM.ON.."Channeling protection is disabled."..FASTCAST_EM.OFF,
	COMMAND_PROTECT_MAXIMUM_FORMAT = FASTCAST_EM.ON.."Channeling protection maximum set to %.1f seconds."..FASTCAST_EM.OFF;
	COMMAND_PROTECT_ENABLED_STATUS_FORMAT = FASTCAST_EM.ON.."Channeling protection is currently enabled with maximum %.1f seconds."..FASTCAST_EM.OFF,
	COMMAND_PROTECT_DISABLED_STATUS = FASTCAST_EM.ON.."Channeling protection is currently disabled."..FASTCAST_EM.OFF,
	COMMAND_PROTECT_NOT_ENABLED = FASTCAST_EM.ON.."Channeling protection must be enabled to use this option."..FASTCAST_EM.OFF,
	COMMAND_USAGE_FAILED = FASTCAST_EM.RED.."Your class does not have any actions that Fastcast can help with.\nFastcast macros are still usable however."..FASTCAST_EM.OFF,
	COMMAND_PROTECT_USAGE_FAILED = FASTCAST_EM.RED.."Your class does not have any channeled spells."..FASTCAST_EM.OFF,
	COMMAND_CHANNELCAST_PRESENT_NOTICE = FASTCAST_EM.RED.."Channelcast is still installed, please make sure to remove it.\nTurning off Channelcast..."..FASTCAST_EM.OFF,
	COMMAND_DEBUGON_CONFIRM = "Fastcast debug is enabled.",
	COMMAND_DEBUGOFF_CONFIRM = "Fastcast debug is disabled.",
};

-- Help text
FASTCAST_HELP = {
	FASTCAST_EM.ON.."Provides support for fast-casting of cast-time spells, and protection of channeled spells from accidental interruptions."..FASTCAST_EM.OFF;
	"   /fastcast "..FASTCAST_COMMANDS.COMMAND_HELP..FASTCAST_EM.ON.." shows this help message"..FASTCAST_EM.OFF;
	"   /fastcast"..FASTCAST_EM.ON.." shows or hides the Fastcast options window."..FASTCAST_EM.OFF;
	"   /fastcast "..FASTCAST_COMMANDS.COMMAND_FAST.." ["..FASTCAST_COMMANDS.COMMAND_ON.."|"..FASTCAST_COMMANDS.COMMAND_OFF.."]"..FASTCAST_EM.ON.." enables or disables fast casting mode."..FASTCAST_EM.OFF;
	"   /fastcast "..FASTCAST_COMMANDS.COMMAND_FAST.." #"..FASTCAST_EM.ON.." sets the cast time padding."..FASTCAST_EM.OFF;
	"   /fastcast "..FASTCAST_COMMANDS.COMMAND_PROTECT.." ["..FASTCAST_COMMANDS.COMMAND_ON.."|"..FASTCAST_COMMANDS.COMMAND_OFF.."]"..FASTCAST_EM.ON.." enables or disables channeling protection."..FASTCAST_EM.OFF;
	"   /fastcast "..FASTCAST_COMMANDS.COMMAND_PROTECT.." #"..FASTCAST_EM.ON.." sets the maximum channeling protection time."..FASTCAST_EM.OFF;
	"   /fastcast "..FASTCAST_COMMANDS.COMMAND_STATUS..FASTCAST_EM.ON.." shows the status of Fastcast"..FASTCAST_EM.OFF,
};

if ( GetLocale() == "koKR" ) then

-- For parsing spell names
FASTCAST_SPELLDATA = {
	NAME_AND_RANK_PATTERN = "^([^%(]+)%(?([^%(%)]-)%)?$",
};

-- General strings
FASTCAST_TEXT = {
	FRAME_TITLE = "시전 속도 증가",
	FAST_ENABLE_OPTION = "시전 속도 증가 사용",
	FAST_CASTBAR_OPTION = "시전바에 적용",
	FAST_PLAY_SOUND_OPTION = "효과음 재생",
	FAST_PADDING_TEXT = "시전 시간 패딩값",
	CHANNEL_PROTECT = "정신 집중 주문 보호",
	CHANNEL_MAXIMUM_TEXT = "최대 보호 시간",

	HELP_BUTTON_TEXT = "[?]",
	HELP_FAST_TITLE = "시전 속도 증가",
	HELP_FAST_DESC = "시전 속도 증가는 현재 시전 중인 주문을 자동으로 빨리 끝마치게 하고 다른 주문 시전을 시작할 수 있도록 해 줍니다.\n\n즉시 시전 주문은 시전 속도 증가의 영향을 받지 않습니다.\n\n시전 속도 증가를 |cffffd100시전바에 적용|r하여 시전바가 실제 시전 타이밍을 반영하도록 설정할 수 있습니다. 이는 시전바가 끝까지 닿으면 다시 주문 시전이 가능하다는 것을 의미합니다. 진행 중인 주문 시전이 끝나기도 전에 다시 주문을 시전하려고 할 때 |cffffd100효과음을 재생|r하도록 설정하여 더 나은 피드백을 얻을 수 있습니다.\n\n|cffffd100시전 시간 패딩값|r(초 단위)은 클라이언트와 서버와의 통신 지연 시 발생하는 일반적인 변수들을 흡수할 수 있도록 큰 값으로 설정하는 것이 좋습니다.  값을 낮게 설정할 수록 시전 속도 증가 폭은 커지지만 시전이 실패하거나 방해 받을 확률도 높아집니다.  값을 높게 설정하면 시전 속도 증가 폭은 떨어지지만 주문 시전의 신뢰도는 증가합니다.",
	HELP_CHANNEL_TITLE = "정신 집중 보호",
	HELP_CHANNEL_DESC = "정신 집중 보호는 실수로 같은 주문 버튼을 눌러서 시전 중인 주문을 취소하거나 다시 시작하는 것을 방지해 줍니다. 이는 정신 집중 주문을 마치 일반 주문을 시전하듯 연속적으로 빠르게 사용할 수 있게 해 줍니다.\n\n다른 주문을 시전할 경우에는 현재 시전 중인 채널링 주문은 중지됩니다.\n\n|cffffd100최대 보호 시간|r은 정신 집중 주문을 시전하고 있는 동안 취소되거나 재시작하게 되는 것을 막는 최대 시간(초 단위)을 뜻합니다.  이 값을 변경해서 필요한 경우 정신 집중 주문이 보호받을 수 있도록 할 수 있으며 보호되어 있는 시간 이후에는 주문을 취소하거나 재시전할 수 있습니다.",
	HELP_NO_CHANNEL_DESC = "정신 집중 주문이 없는 직업은 이 기능을 사용할 수 없습니다.",
	
	DEBUG = FASTCAST_EM.ON.."시전 속도 증가: "..FASTCAST_EM.OFF;
}

-- Slash commands and responses
FASTCAST_COMMANDS = {
	-- Slash commands
	COMMAND_HELP = "help",
	COMMAND_ON = "on",
	COMMAND_ENABLE = "enable",
	COMMAND_OFF = "off",
	COMMAND_DISABLE = "disable",
	COMMAND_FAST = "fast",
	COMMAND_PROTECT = "protect",
	COMMAND_STATUS = "status",
	COMMAND_DEBUGON = "debugon",
	COMMAND_DEBUGOFF = "debugoff",

	-- Slash command responses
	COMMAND_FAST_ENABLE_CONFIRM = FASTCAST_EM.ON.."시전 속도 증가 모드가 활성화됩니다."..FASTCAST_EM.OFF,
	COMMAND_FAST_DISABLE_CONFIRM = FASTCAST_EM.ON.."시전 속도 증가 모드가 비활성화됩니다."..FASTCAST_EM.OFF,
	COMMAND_FAST_PADDING_FORMAT = FASTCAST_EM.ON.."시전 속도 증가 패딩값이 %.2f초로 설정되었습니다."..FASTCAST_EM.OFF;
	COMMAND_FAST_ENABLED_STATUS_FORMAT = FASTCAST_EM.ON.."시전 속도 증가 모드가 현재 %.2f초 패딩값으로 활성화되어 있습니다."..FASTCAST_EM.OFF,
	COMMAND_FAST_DISABLED_STATUS = FASTCAST_EM.ON.."시전 속도 증가 모드는 현재 비활성화 상태입니다."..FASTCAST_EM.OFF,
	COMMAND_FAST_NOT_ENABLED = FASTCAST_EM.ON.."이 설정을 사용하려면 시전 속도 증가 모드가 활성화되어 있어야 합니다."..FASTCAST_EM.OFF,
	COMMAND_PROTECT_ENABLE_CONFIRM = FASTCAST_EM.ON.."정신 집중 보호가 활성화됩니다."..FASTCAST_EM.OFF,
	COMMAND_PROTECT_DISABLE_CONFIRM = FASTCAST_EM.ON.."정신 집중 보호가 비활성화됩니다."..FASTCAST_EM.OFF,
	COMMAND_PROTECT_MAXIMUM_FORMAT = FASTCAST_EM.ON.."정신 집중 보호가 최대 %.1f초로 설정되었습니다."..FASTCAST_EM.OFF;
	COMMAND_PROTECT_ENABLED_STATUS_FORMAT = FASTCAST_EM.ON.."정신 집중 보호가 현재 최대 %.1f초로 활성화되어 있습니다."..FASTCAST_EM.OFF,
	COMMAND_PROTECT_DISABLED_STATUS = FASTCAST_EM.ON.."정신 집중 보호가 현재 비활성화 상태입니다."..FASTCAST_EM.OFF,
	COMMAND_PROTECT_NOT_ENABLED = FASTCAST_EM.ON.."이 설정을 사용하려면 정신 집중 보호가 활성화되어 있어야 합니다."..FASTCAST_EM.OFF,
	COMMAND_USAGE_FAILED = FASTCAST_EM.RED.."현재 직업이 시전 속도 증가의 도움을 받을 수 있는 기술을 가지고 있지 않습니다.\n하지만 시전 속도 증가 매크로는 사용 가능합니다."..FASTCAST_EM.OFF,
	COMMAND_PROTECT_USAGE_FAILED = FASTCAST_EM.RED.."현재 직업에는 사용 가능한 정신 집중 주문이 없습니다."..FASTCAST_EM.OFF,
	COMMAND_CHANNELCAST_PRESENT_NOTICE = FASTCAST_EM.RED.."채널캐스트(Channelcast)가 설치되어 있습니다. 채널캐스트를 제거해 주십시오.\n채널캐스트를 종료합니다..."..FASTCAST_EM.OFF,
	COMMAND_DEBUGON_CONFIRM = "시전 속도 증가 디버그가 활성화됩니다.",
	COMMAND_DEBUGOFF_CONFIRM = "시전 속도 증가 디버그가 비활성화됩니다.",
};

-- Help text
FASTCAST_HELP = {
	FASTCAST_EM.ON.."주문 시전 시간을 증가시켜 주며 채널링 주문이 실수로 중지되는 것을 방지해 주는 기능을 제공합니다."..FASTCAST_EM.OFF;
	"   /fastcast "..FASTCAST_COMMANDS.COMMAND_HELP..FASTCAST_EM.ON.." 도움말을 출력합니다."..FASTCAST_EM.OFF;
	"   /fastcast"..FASTCAST_EM.ON.." 시전 속도 증가 설정 창을 열거나 닫습니다."..FASTCAST_EM.OFF;
	"   /fastcast "..FASTCAST_COMMANDS.COMMAND_FAST.." ["..FASTCAST_COMMANDS.COMMAND_ON.."|"..FASTCAST_COMMANDS.COMMAND_OFF.."]"..FASTCAST_EM.ON.." 시전 속도 증가 모드를 활성화하거나 비활성화합니다."..FASTCAST_EM.OFF;
	"   /fastcast "..FASTCAST_COMMANDS.COMMAND_FAST.." #"..FASTCAST_EM.ON.." 시전 시간 패딩값을 설정합니다."..FASTCAST_EM.OFF;
	"   /fastcast "..FASTCAST_COMMANDS.COMMAND_PROTECT.." ["..FASTCAST_COMMANDS.COMMAND_ON.."|"..FASTCAST_COMMANDS.COMMAND_OFF.."]"..FASTCAST_EM.ON.." 정신 집중 보호를 활성화하거나 비활성화합니다."..FASTCAST_EM.OFF;
	"   /fastcast "..FASTCAST_COMMANDS.COMMAND_PROTECT.." #"..FASTCAST_EM.ON.." 최대 정신 집중 보호 시간을 설정합니다."..FASTCAST_EM.OFF;
	"   /fastcast "..FASTCAST_COMMANDS.COMMAND_STATUS..FASTCAST_EM.ON.." 시전 속도 증가 설정 상태를 출력합니다."..FASTCAST_EM.OFF,
};

end
