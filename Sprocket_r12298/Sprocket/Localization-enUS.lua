local L = AceLibrary("AceLocale-2.0"):new("Sprocket")

L:RegisterTranslations("enUS", function()
	return {
		["Sprocket"] = "Sprocket",
	}
end)

CHOOSE_ICON = "Choose Icon..."

GENERAL_OPTIONS = "General"
MENU_OPTIONS = "Menus"
MINIBUTTON_OPTIONS = "Minimap Button"
BIGBUTTON_OPTIONS = "Floating Button"

SPROCKETMENUCONFIG = "Sprocket Menu Config"
SPROCKETTRIGGERCONFIG = "Sprocket Trigger Config"

TRIGGERS = "Triggers"
TRIGGER_TAB_TOOLTIP = "Used to open menus. A trigger can be a key binding, or a mouse button."

MENUS = "Menus"
MENU_TOOLTIP = "A radial menu of up to eight items, centered around your cursor."

BUTTON_OFFSET = "Button Offset"
OFFSET_TOOLTIP = "Distance of item buttons from the center of the menu."

MENUSCALE = "Menu Scale"
MENUSCALE_TOOLTIP = "Scale menu display size."

MINIBUTTON_POS = "Minimap Button Position"
MINIBUTTON_POS_TOOLTIP = "Radial position of the minimap button."

MINIBUTTON_SHOW = "Show Minimap Button"
MINIBUTTON_SHOW_TOOLTIP = "Toggle display of the Minimap Button."

BIGBUTTON_SHOW = "Show Floating Button"
BIGBUTTON_SHOW_TOOLTIP = "Toggle display of the floating button.\n"..GREEN_FONT_COLOR_CODE.."Use Shift-Click to move and Alt-Click to resize."

OVERLAYS_SHOW = "Show Overlays on Mouseover"
OVERLAYS_SHOW_TOOLTIP = "Toggle display of the overlay frames on mouse over."

CENTERICON = "Center Button Icon"
CENTERICON_BUTTON_TOOLTIP = "Click to choose a center button icon for this menu."

EFFECTS_SHOW = "Show Effects"
EFFECTS_SHOW_TOOLTIP = "Toggle display of graphical effects."

CENTER_SHOW = "Show Center Button"
CENTER_SHOW_TOOLTIP = "Toggle display of the center button when using menus."

RING_SHOW = "Show Item Ring"
RING_SHOW_TOOLTIP = "Toggle display of the transparent ring beneath menu items."

HOVERDELAY = "Hover Delay"
HOVERDELAY_TOOLTIP = "Time to wait before opening a Sub Menu."

DEADZONE_SIZE = "Deadzone Radius"
DEADZONE_SLIDER_TOOLTIP = "Distance the mouse cursor must be from the center of the menu to select an item button."

SELECTION_SIZE = "Selection Radius"
SELECTION_SLIDER_TOOLTIP = "Distance the mouse cursor must be from the center of the menu to deselect an item button."

SHOWNAMES = "Always Show Names"
SHOWNAMES_CHECKBOX_TOOLTIP = "Display the names of item buttons"

HOTKEYS = "Hotkey"
HOTKEY_TAB_TOOLTIP = "Opens a menu when pressed while over one of the specified frames."

MOUSE_BUTTONS = "Mouse"
MOUSE_TAB_TOOLTIP = "Opens a menu when when the specified frame is clicked."

ADD_FRAME = "Add"
ADD_BUTTON_TOOLTIP = "Add a new frame for this trigger."

REMOVE_FRAME = "Remove"
REMOVE_BUTTON_TOOLTIP = "Remove the frame from the trigger."

MENUNAME = "Menu Name"
MENU_DROPDOWN_TOOLTIP = "Sets the name of the menu opened when this frame is trigged by a hotkey or mouse click."

PREACTION = "Pre Action"
PREACTION_BUTTON_TOOLTIP = "The action will be executed before the selected menu item.  If no menu item is selected when the hotkey or mouse button is released, no actions will occur."

POSTACTION = "Post Action"
POSTACTION_BUTTON_TOOLTIP = "The action will be executed after the selected menu item.  If no menu item is selected when the hotkey or mouse button is released, no actions will occur."

CREATEMENU = "Create"
CREATE_BUTTON_TOOLTIP = "Create a new menu."

DELETEMENU = "Delete"
DELETE_BUTTON_TOOLTIP = "Delete the selected menu."

BORDERTEXTURE = "Choose Border"
BORDERTEXTURE_TOOLTIP = "Choose a border texture."

ITEMBORDERTEXTURE = "Choose Item Border"
ITEMBORDERTEXTURE_TOOLTIP = "Choose an item button border texture."

CENTERBORDERTEXTURE = "Choose Center Border"
CENTERBORDERTEXTURE_TOOLTIP = "Choose a center button border texture."

FRAMES = "Frames"
FRAME = "Frame"
ITEMS = "Items"
SPROCKETHELP = "Sprocket Help"

SPROCKETBORDER = "Sprocket Gear"
TRACKINGBORDER = "Minimap Tracking"
CUSTOMBORDER = "Custom: "

BAR_TEXTS = {
	[0] = "Use Current",
	[1] = "1 (ActionBar Page 1)",
	[2] = "2 (ActionBar Page 2)",
	[3] = "3 (Right ActionBar 1)",
	[4] = "4 (Right ActionBar 2)",
	[5] = "5 (Bottom Right ActionBar)",
	[6] = "6 (Bottom Left ActionBar)",
	[7] = "slotIDs 73-84",
	[8] = "slotIDs 85-96",
	[9] = "slotIDs 97-108",
	[10] = "slotIDs 109-120",
}
