-- Global settings

function NovaWatch_Globals()

NOVAWATCH = {}
NOVAWATCH.ACTIVE = false
NOVAWATCH.STATUS = 0 						-- 0: Disabled 1: Enabled 2: Visible/Active 3: Unlocked
NOVAWATCH.TIMER_START = 0
NOVAWATCH.TIMER_END = -15
NOVAWATCH.MOBNAME = ""
NOVAWATCH.PLAYER = nil
NOVAWATCH.LENGTH = 8 
NOVAWATCH.COUNTER = false
NOVAWATCH.DECIMALS = true 							
NOVAWATCH.VERBOSE = false					
NOVAWATCH.ALPHA_STEP = 0.2
NOVAWATCH.PVPCC = nil
NOVAWATCH.DIMINISH = 1
NOVAWATCH.DIMINISHES = 1
NOVAWATCH.DIRECTION = 1									
NOVAWATCH.SCALE = 1
NOVAWATCH["barcolor"] = {
					{ r = "1.0", g = "1.0", b = "0.0"}
}
NOVAWATCH.ALPHA = 1

-- Ability to clear users profile when neccessary
NOVAWATCH.CLEAR = true

NOVAWATCH_PROFILE = ""
NOVAWATCH_VARIABLES_LOADED = false
NovaWatch_Settings = {}

end