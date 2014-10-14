function Stacker_Locals_frFR()

ace:RegisterGlobals{
    version = STACKER.ACEUTIL_VERSION,
    
    ACEG_MAP_ONOFF = {[0]="|cffff5050Off|r",[1]="|cff00ff00On|r"},

    BINDING_HEADER_STACKER  = "Stacker",
    BINDING_NAME_STACK      = "Stack les objets au maximum.",
    BINDING_NAME_BANK_STACK = "Stack uniquement les objets en banque.",
}            

STACKER.NAME          = "Stacker"
STACKER.DESCRIPTION   = "Permet d'empiler les objets automagiquement."

STACKER.TEXT_AUTOSTACK = "Autostack des objets à l'ouverture des sacs."
STACKER.TEXT_AUTOSTACK = "Affichage détaillé"

STACKER.CMD_COMMAND_STACK = "/stack"

STACKER.COMMANDS      = { "/stacker", "/restack" }
STACKER.CMD_OPTIONS   = {
    {
        option = "autostack",
        desc   = "Bascule l'autostacking à l'ouverture des sacs.",
        method = "AutoStackToggle",
    },
    {
	option = "verbose",
	desc   = "Bascule l'affichage détaillé.",
	method = "VerboseToggle",
    },
    {
        option = "stack",
        desc   = "Procède au stacking",
        method = "Stack",
        args   = {
            {
                option = "bank",
                desc   = "Ne stack que les objets en banque.",
                method = "BankStack",
            },
        }
    }
}

end
