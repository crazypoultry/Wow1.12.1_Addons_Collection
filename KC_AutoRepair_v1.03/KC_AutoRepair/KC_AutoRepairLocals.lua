-- This statement will load any translation that is present or default to English.
KC_AUTOREPAIR_LOCALS = {};
if( not ace:LoadTranslation("KC_AutoRepair") ) then

local locals = KC_AUTOREPAIR_LOCALS;

locals.name	= "KC_AutoRepair"
locals.desc	= "A small utility to remind one that they need to repair their stuff."

locals.on	= "On"
locals.off	= "Off"

locals.prompt = {};
locals.prompt.title		= "KC_AutoRepair Prompt"
locals.prompt.both		= "Both"
locals.prompt.inventory	= "Inventory"
locals.prompt.equipment	= "Equipment"
locals.prompt.line1		= "To repair your Inventory it will cost:"
locals.prompt.line2		= "To repair your Equipment it will cost:"
locals.prompt.line3		= "To repair both it will cost:"

locals.config = {};
locals.config.title		= "KC_AutoRepair Config"
locals.config.prompt		= "Prompt"
locals.config.verbose	= "Verbose"
locals.config.skipinv	= "SkipInv"
locals.config.mincost	= "MinCost"
locals.config.threshold	= "Threshold"
locals.config.set		= "Set"

locals.config.tips = {};
locals.config.tips.prompt1	= "Prompt Help"
locals.config.tips.prompt2	= "Toggles display of the conformation prompt."
locals.config.tips.skipinv1	= "SkipInv Help"
locals.config.tips.skipinv2	= "Toggles automatic repair of your inventory."
locals.config.tips.verbose1	= "Verbose Help"
locals.config.tips.verbose2	= "Toggles display of verbose messages."
locals.config.tips.threshold1= "Threshold Help"
locals.config.tips.threshold2= "Sets the threshold amount shown in the boxes to the left."
locals.config.tips.threshold3= "Must be clicked in order to take effect."
locals.config.tips.mincost1	= "MinCost Help"
locals.config.tips.mincost2	= "Sets the mincost amount shown in the boxes to the left."
locals.config.tips.mincost3	= "Must be clicked in order to take effect."

locals.colors = {};
locals.colors.silver = "Silver";
locals.colors.copper = "Copper";
locals.colors.gold	= "Gold";

locals.errors = {};
locals.errors.noamt		= "No Amount Entered";
locals.errors.notcopper	= "|cffff6633Value must be in numeric, and entered in copper."
locals.errors.noacegui	= "|cffff6633You must have AceGUI installed in order to use this feature."

locals.msgs = {};
locals.msgs.both			= "|cfff5f530Your Total repair bill was [%s|cfff5f530]."
locals.msgs.inventory	= "|cfff5f530Your Inventory repair bill was [%s|cfff5f530]."
locals.msgs.equipment	= "|cfff5f530Your Equipment repair bill was [%s|cfff5f530]."


locals.chat = {};
locals.chat.togmsg	= "|cfff5f530You have set [|cff66ff33%s|cfff5f530] to [|cff66ff33%s|cfff5f530]."
locals.chat.commands = {"/kcar", "/ar", "/KC_AutoRepair", "/AutoRepair"}
locals.chat.options	= {
    {
		option = "prompt", -- Don't Localize
        desc   = "Toggles display of the conformation prompt.",
		method = "TogPrompt", -- Don't Localize
    },
    {
		option = "skipinv", -- Don't Localize
        desc   = "Toggles automatic repair of your inventory.",
		method = "TogSkipinv", -- Don't Localize
    },
    {
		option = "verbose", -- Don't Localize
        desc   = "Toggles display of verbose messages.",
		method = "TogVerbose", -- Don't Localize
    },
    {
		option = "mincost", -- Don't Localize
        desc   = "Set the mincost amount.  Must be in copper.",
		method = "SetMinCost", -- Don't Localize
		input  = TRUE, -- Don't Localize
    },
    {
		option = "threshold", -- Don't Localize
        desc   = "Set the threshold amount.  Must be in copper.",
		method = "SetThreshold", -- Don't Localize
		input  = TRUE, -- Don't Localize
    },
	{
		option = "report", 
        desc   = "Prints out your current settings.",
		method = "Report", -- Don't Localize
	},
	{
		option = "config",
        desc   = "Opens the configuration window.",
		method = "TogConfig", -- Don't Localize
	}
}
end