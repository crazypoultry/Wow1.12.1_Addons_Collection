
How to add ModMenu entries for your mod (or someone else's)

Here are examples:
--------------------------------------------------------------------
	["CmdSample"] = {cat = TITAN_MODMENU_CAT_QUEST, cmd = "/cs"},
--------------------------------------------------------------------
	["SubmenuSample"] = {cat = TITAN_MODMENU_CAT_INVENTORY,
		submenu = {
			{text = TITAN_MODMENU_ENABLE, cmd = "/eqc on"},
			{text = TITAN_MODMENU_DISABLE, cmd = "/eqc off"},
			{text = TITAN_MODMENU_TOGGLE.. " Control Mode", cmd = "/eqc control"},
			{text = TITAN_MODMENU_HELP, cmd = "/eqc help"},
		},
		["deDE"] = {
			submenu = {
				{text = "This is the German Version"},
				{text = TITAN_MODMENU_ENABLE, cmd = "/eqc on"},
				{text = TITAN_MODMENU_DISABLE, cmd = "/eqc off"},
				{text = TITAN_MODMENU_TOGGLE.. " Control Mode", cmd = "/eqc control"},
				{text = TITAN_MODMENU_HELP, cmd = "/eqc help"},
			}
		},
		["frFR"] = {
			submenu = {
				{text = "This is the French Version"},
				{text = TITAN_MODMENU_ENABLE, cmd = "/eqc on"},
				{text = TITAN_MODMENU_DISABLE, cmd = "/eqc off"},
				{text = TITAN_MODMENU_TOGGLE.. " Control Mode", cmd = "/eqc control"},
				{text = TITAN_MODMENU_HELP, cmd = "/eqc help"},
			}
		},
	},
--------------------------------------------------------------------

So to begin, you must define you mod's name in the [] at the start.  This is the name WoW sees it by, which is also the folder name in \interface\addons.  If this does not match exactly your mod will fall under "unknown mods" and have no functionality aside for load/enable/disable.

All other values here in the root are optional.  Values can be cmd, func, toggle or submenu.  Only ONE will work tho, don't try for more than one.  You also probably want to define cat, if you don't want your mod in the "Others" category.

Submenus can hold any commands that the root level can.  There is also a blank line option.  You are limited to 32 items in a submenu.  Support for multiple submenus for the same mod is coming soon!

Localization has changed a tad.  In mod entries you can now define language-specific entries as in the example.  If your entry only has one language DO NOT USE THIS.  Bad things could happen if you do not define a root set.

Acceptable menu values:
text -- this variable is the menu text for your item, must always be defined.
cat -- The category menu the mad should be placed in (Default "other" if undefined)
toggle -- frame to toggle visibility
func -- function to call (does not pass arguments)
cmd -- a text slash command to send, like "/console reloadui"
submenu -- an array consisting on menu item arrays, only valid at root level
TITAN_MODMENU_SPACER -- use this to crate an empty entry, not valid in the root level

After you have created your menu array, call this function in your mod's onLoad.  You should also add an optional dependancy for MM so that MM loads first.

TitanPanelModMenu_RegisterMenu("ModName", menuarray);

WoW's mod name info (the folder name) is used for sort order in the menu.

If you are writing the menu for a mod that is not your own, please submit it to the comment section on curse gaming and I will hard-code it into the mod so everyone can use it.

A number of common strings are included in the localization file, you are encouraged to use them ^^

The way menus that are not based off mods (like the emote menu) has been altered slightly.  The entries for these categories is now in a seperaty table.  Behavior has not changed however, all old workings still work including loc.

You might notice that with v2 the root fields text and frame are no longer used.  This is becaule the info is pulled from WoW's new Addon functions.  If you are not seeing localized info here you need to get that info added to the mod's TOC file.  Mod authors are usually glad to accept localization info so send it to them! Here's an example of how a localized TOC should look:

## Interface: 1700
## Title: Gatherer
## Title-frFR: Gatherer
## Title-deDE: Gatherer
## Notes: Gatherer, displays stuff you gather in your minimap
## Notes-frFR: Gatherer, affiche les objets recoltes dans la minicarte et la carte du monde
## Notes-deDE: Gatherer, zeigt gesammelte Krauter und Erze auf der Minikarte und Weltkarte an
## SavedVariables: GatherItems, GatherConfig
## OptionalDeps: myAddOns
Gatherer.xml
GathererUI.xml
GathererInfo.xml

