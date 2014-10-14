--
-- AutoBar
-- http://www.curse-gaming.com/en/wow/addons-4430-1-autobar-toadkiller.html
--

local AceLocale = AceLibrary("AceLocale-2.1");

AceLocale:RegisterTranslation("AutoBar", "frFR", function()
    return {
        ["AUTOBAR"] = "AutoBar",
        ["CONFIG_WINDOW"] = "Configuration Window",
        ["SLASHCMD_LONG"] = "/autobar",
        ["SLASHCMD_SHORT"] = "/atb",
        ["BUTTON"] = "Button",
        ["EDITSLOT"] = "Edit Slot",
        ["VIEWSLOT"] = "View Slot",

		--  AutoBarConfig.lua
		["EMPTY"] = "Empty";
		["AUTOBAR_CONFIG_SMARTSELFCAST"] = "Smart Self Cast";
		["AUTOBAR_CONFIG_REMOVECAT"] = "Delete Current Category";
		["AUTOBAR_CONFIG_ROW"] = "Rows";
		["AUTOBAR_CONFIG_COLUMN"] = "Columns";
		["AUTOBAR_CONFIG_GAPPING"] = "Icon Gapping";
		["AUTOBAR_CONFIG_ALPHA"] = "Icon Alpha";
		["AUTOBAR_CONFIG_BUTTONWIDTH"] = "Button Width";
		["AUTOBAR_CONFIG_BUTTONHEIGHT"] = "Button Height";
		["AUTOBAR_CONFIG_DOCKSHIFTX"] = "Shift Dock Left/Right";
		["AUTOBAR_CONFIG_DOCKSHIFTY"] = "Shift Dock Up/Down";
		["AUTOBAR_CONFIG_WIDTHHEIGHTUNLOCKED"] = "Button Height\nand Width Unlocked";
		["AUTOBAR_CONFIG_HIDEKEYBINDING"] = "Hide Keybinding Text";
		["AUTOBAR_CONFIG_HIDECOUNT"] = "Hide Count Text";
		["AUTOBAR_CONFIG_SHOWEMPTY"] = "Show Empty Buttons";
		["AUTOBAR_CONFIG_SHOWCATEGORYICON"] = "Show Category Icons";
		["AUTOBAR_CONFIG_HIDETOOLTIP"] = "Hide Tooltips";
		["AUTOBAR_CONFIG_POPUPDIRECTION"] = "Popup\nButtons\nDirection";
		["AUTOBAR_CONFIG_POPUPDISABLE"] = "Disable Popup";
		["AUTOBAR_CONFIG_POPUPONSHIFT"] = "Popup on Shift Key";
		["AUTOBAR_CONFIG_HIDEDRAGHANDLE"] = "Hide Drag Handle";
		["AUTOBAR_CONFIG_PLAINBUTTONS"] = "Plain Buttons";
		["AUTOBAR_CONFIG_NOPOPUP"] = "No Popup";
		["AUTOBAR_CONFIG_ARRANGEONUSE"] = "Rearrange Order on Use";
		["AUTOBAR_CONFIG_RIGHTCLICKTARGETSPET"] = "Right Click Targets Pet";
		["AUTOBAR_CONFIG_DOCKTONONE"] = "None";
		["AUTOBAR_CONFIG_DOCKTOGBARS"] = "Gbars Second Bar";
		["AUTOBAR_CONFIG_DOCKTOMAIN"] = "Main Menu";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAME"] = "Chat Frame";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"] = "Chat Frame Menu";
		["AUTOBAR_CONFIG_DOCKTOACTIONBAR"] = "Action Bar";
		["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"] = "Menu Buttons";
		["AUTOBAR_CONFIG_ALIGN"] = "Align Buttons";
    }
end);


if (GetLocale() == "frFR") then

---------------------------------------
--  AutoBar_ItemList.lua
---------------------------------------
AUTOBAR_ALTERACVALLEY = "Vall\195\169e d'Alterac";
AUTOBAR_WARSONGGULCH = "Goulet des Warsong";
AUTOBAR_ARATHIBASIN = "Bassin d'Arathi";
AUTOBAR_AHN_QIRAJ = "Ahn'Qiraj";


end