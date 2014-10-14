if not ace:LoadTranslation("FwgFu") then

FwgFuLocals = {
	NAME = "FuBar - FelwoodGather",
	DESCRIPTION = "FuBar plugin for FelwoodGather",
	VERSION = "0.10",
	COMMANDS = {"/fwgfu"},
	CMD_OPTIONS = {},
	
	ARGUMENT_SHARE = "share",
	ARGUMENT_ANNOUNCE = "announce",
	ARGUMENT_TIMER = "timer",
	ARGUMENT_SUBZONE = "subzone",
	ARGUMENT_COORDS = "coords",
	ARGUMENT_MINIMAP = "minimap",
	ARGUMENT_COUNT = "count",

	MENU_SHARE = "Share",
	MENU_ANNOUNCE = "Announce",
	MENU_CONFIG = "Toggle Config",
	MENU_COUNT = "Count down",
	MENU_MINIMAP = "Toggle Minimap",
	
	MENU_SHOW_TIMER = "Show Timer",
	MENU_SHOW_SUBZONE = "Show Subzone",
	MENU_SHOW_COORDS = "Show coords",
	
	ICON_TEXTURE="Interface\\Icons\\INV_Misc_Food_55",
	NO_TIMER = "No Timer"
}

FwgFuLocals.CMD_OPTIONS = {
	{
		option = FwgFuLocals.ARGUMENT_SHARE,
		desc = "Share timer.",
		method = "ShareTimer"
	},
	{
		option = FwgFuLocals.ARGUMENT_ANNOUNCE,
		desc = "Announce next timer to your rosters.",
		method = "Announce"
	},
	{
		option = FwgFuLocals.ARGUMENT_COUNT,
		desc = "Count down to pick the object together.",
		method = "Count"
	},
	{
		option = FwgFuLocals.ARGUMENT_MINIMAP,
		desc = "Toggle FelwoodGather Minimap window.",
		method = "ToggleMinimap"
	},
	{
		option = FwgFuLocals.ARGUMENT_TIMER,
		desc = "Toggle whether to show the tiemr.",
		method = "ToggleShowTimer"
	},
	{
		option = FwgFuLocals.ARGUMENT_SUBZONE,
		desc = "Toggle whether to show subzone text.",
		method = "ToggleShowSubzone"
	},
	{
		option = FwgFuLocals.ARGUMENT_COORDS,
		desc = "Toggle whether to show Coords.",
		method = "ToggleShowCoords"
	}
}

end