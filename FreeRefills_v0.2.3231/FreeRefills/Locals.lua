if not ace:LoadTranslation("FreeRefills") then

FreeRefillsLocals = {
	NAME			= "FreeRefills",
	DESCRIPTION		= "Automatic Refilling of User Defined Items",
}

-- Chat handler locals
FreeRefillsLocals.COMMANDS	  = {"/freerefills", "/fr"}
FreeRefillsLocals.CMD_OPTIONS = {
	{
    	option	= "add",
        desc	= "Add an item to the refill list. (Usage: /freerefills add [Item Link] #)",
        method	= "AddRefillItem",
		input	= true
    },
		{
    	option	= "addstack",
        desc	= "Add an item to the refill list by stack. (Usage: /freerefills addstack [Item Link] #)",
        method	= "AddRefillItemStack",
		input	= true
    },
	{
    	option	= "del",
        desc	= "Remove an item from the refill list. (Usage: /freerefills del [Item Link])",
        method	= "RemoveRefillItem",
		input	= true
    },
	{
    	option	= "mood",
        desc	= "Toggle Between Optimist and Pessimest Mood.  (Pessimest will buy extra if you have partial stacks, Optimist will never buy more than you want.)",
        method	= "ToggleMood"
    },
	{
		option	= "clear",
		desc	= "Clear the refill list completely.",
		method	= "ClearRefills",
		input	= false
	}
}

end
