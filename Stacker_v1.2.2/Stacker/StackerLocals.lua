STACKER = { ACEUTIL_VERSION = 1.01 }

if (not ace:LoadTranslation("Stacker")) then

ace:RegisterGlobals{
    version = STACKER.ACEUTIL_VERSION,
    
    ACEG_MAP_ONOFF = {[0]="|cffff5050Off|r",[1]="|cff00ff00On|r"},

    BINDING_HEADER_STACKER  = "Stacker",
    BINDING_NAME_STACK      = "Stack the items at maximum.",
    BINDING_NAME_BANK_STACK = "Stack items in bank only.",
}            

STACKER.NAME          = "Stacker"
STACKER.DESCRIPTION   = "Permits to stack automagically items."

STACKER.TEXT_AUTOSTACK = "Autostacking of items on bags opening"
STACKER.TEXT_VERBOSE   = "Verbosity"

STACKER.CMD_COMMAND_STACK = "/stack"

STACKER.COMMANDS      = { "/stacker", "/restack" }
STACKER.CMD_OPTIONS   = {
    {
        option = "autostack",
        desc   = "Toggle autostacking on bag opening.",
        method = "AutoStackToggle",
    },
    {
	option = "verbose",
	desc   = "Toggle verbosity output.",
	method = "VerboseToggle",
    },
    {
        option = "stack",
        desc   = "Process stacking",
        method = "Stack",
        args   = {
            {
                option = "bank",
                desc   = "Stack only items in bank.",
                method = "BankStack",
            },
        }
    }
}

end
