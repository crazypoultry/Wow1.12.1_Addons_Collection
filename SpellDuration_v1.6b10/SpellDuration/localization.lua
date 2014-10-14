----------------------------------------------------------------------------------------------------
-- Translated By	: VoidRaider
-- Localization		: English
-- Last Update		: 09/11/2005
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- Slash Handler
----------------------------------------------------------------------------------------------------
SD_VER_MSG	= SDSetColor(SDColors.BlueLight,"Spell Duration Version "..SDGlobal.Version);

SDHelpStartTable = {
	SDSetColor(SDColors.Blue,"Spell Duration Command Line:"),
	"=== === === === === === == =",
};

SDHelpSpellsTable = {
	SDSetColor(SDColors.Yellow,"/sd lock bars").." - Hide and Lock the Spell Bars.",
	SDSetColor(SDColors.Yellow,"/sd unlock bars").." - Show and Unlock the Spell Bars.",
	SDSetColor(SDColors.Yellow,"/sd reset bars").." - Reset only the bars frames.",
	SDSetColor(SDColors.Yellow,"/sd lock buffs").." - Hide and Lock the Spell Buffs.",
	SDSetColor(SDColors.Yellow,"/sd unlock buffs").." - Show and Unlock the Spell Buffs.",
	SDSetColor(SDColors.Yellow,"/sd reset buffs").." - Reset only the buffs frames."
};

SDHelpRacialTable = {
	SDSetColor(SDColors.Yellow,"/sd lock racialbar").." - Hide and Lock the Racial Bar.",
	SDSetColor(SDColors.Yellow,"/sd unlock racialbar").." - Show and Unlock the Racial Bar."
};

SDHelpTrollTable = {
	SDSetColor(SDColors.Yellow,"/sd berserker").." - Enable/Disable the Berserker Info frame.",
};

SDHelpBerserkerInfoTable = {
	SDSetColor(SDColors.Yellow,"/sd lock berserker").." - Hide and Lock the Berserker Info.",
	SDSetColor(SDColors.Yellow,"/sd unlock berserker").." - Show and Unlock the Berserker Info."
};

SDHelpEndTable = {
	"=== === === === === === == =",
	SDSetColor(SDColors.Yellow,"/sd barsonly on").." - Make all the spells displayed in Bars.",
	SDSetColor(SDColors.Yellow,"/sd barsonly off").." - Use the default display configuration for each spell.",
	SDSetColor(SDColors.Yellow,"/sd reset").." - Reset the frames to their default position.",
	SDSetColor(SDColors.Yellow,"/sd ver").." - Show the current version of the addon."
};

SDHelpUnlockTable = {
	"=== === === === === === == =",
	SDSetColor(SDColors.Yellow,"Make sure to lock the frames before use!")
};