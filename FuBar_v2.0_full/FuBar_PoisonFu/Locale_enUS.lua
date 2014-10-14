--[[-------------------------------------------------------------------------
-- PoisonFu - An Item Buff management addon for FuBar
--  by The Lithe Development Team
--  http://www.wowace.com/index.php/Lithe_Development_Team
--
--  Last Modified: $Date: 2006-08-17 22:36:32 -0700 (Thu, 17 Aug 2006) $
--  Revision: $Revision: 8346 $
--  This software is licensed under a zlib/linpng license.
-- 
-- About this file:
--   This is a localization database for FuBar_PoisonFu. To add a new
--   locale, copy this file to a new one named for the locale you want
--   to support (e.g. Locale-deDE.lua) and replace the strings with
--   localized versions.
--
--   The ItemBuffEffects table contains the translated string 
--   of how the buff (spell, poison, stone, etc.) manifests itself in the tooltip of the weapon
--   to which it is applied.
--
--	 NOTE: The ItemBuffEffect table values will be treated as LUA pattern and used to 
--	 compare to the item buffs effect on the weapon in the weapons tooltip, so understand 
--	 what the special characters mean before modifying this file!
--]]-------------------------------------------------------------------------

local PoisonFuLocales = AceLibrary("AceLocale-2.0"):new("FuBar_PoisonFu_Locales")
PoisonFuLocales:RegisterTranslations("enUs", function() return {
	["BUFFEXPIRED_MESSAGE"] = "Weapon buff expired. Please reapply.",
	["MAINHAND_MENU_TEXT"] = "Main-Hand Weapon",
	["MAINHAND_NOT_EQUIPPED"] = "No Main-Hand Weapon Equipped",
	["OFFHAND_MENU_TEXT"] = "Off-Hand Weapon",
	["OFFHAND_NOT_EQUIPPED"] = "No Off-Hand Weapon Equipped",
	["APPLY_TITLE_TEXT"] = "Apply to Weapon",
	["DEFAULT_TITLE_TEXT"] = "Set Default",
} end )

local ItemBuffEffects = AceLibrary("AceLocale-2.0"):new("FuBar_PoisonFu_ItemBuffEffects")
ItemBuffEffects:RegisterTranslations("enUS", function() return {
	-- Poisons
	[3775]="Crippling Poison %(%d+ min%)",
	[3776]="Crippling Poison II %(%d+ min%)",
	[2892]="Deadly Poison %(%d+ min%) %(%d+ Charges%)",
	[2893]="Deadly Poison II %(%d+ min%) %(%d+ Charges%)",
	[8984]="Deadly Poison III %(%d+ min%) %(%d+ Charges%)",
	[8985]="Deadly Poison IV %(%d+ min%) %(%d+ Charges%)",
	[20844]="Deadly Poison V %(%d+ min%) %(%d+ Charges%)",
	[6947]="Instant Poison %(%d+ min%) %(%d+ Charges%)",
	[6949]="Instant Poison II %(%d+ min%) %(%d+ Charges%)",
	[6950]="Instant Poison III %(%d+ min%) %(%d+ Charges%)",
	[8926]="Instant Poison IV %(%d+ min%) %(%d+ Charges%)",
	[8927]="Instant Poison V %(%d+ min%) %(%d+ Charges%)",
	[8928]="Instant Poison VI %(%d+ min%) %(%d+ Charges%)",
	[5237]="Mind Numbing Poison %(%d+ min%) %(%d+ Charges%)",
	[6951]="Mind Numbing Poison II %(%d+ min%) %(%d+ Charges%)",
	[9186]="Mind Numbing Poison III %(%d+ min%) %(%d+ Charges%)",
	[10918]="Wound Poison %(%d+ min%) %(%d+ Charges%)",
	[10920]="Wound Poison II %(%d+ min%) %(%d+ Charges%)",
	[10921]="Wound Poison III %(%d+ min%) %(%d+ Charges%)",
	[10922]="Wound Poison IV %(%d+ min%) %(%d+ Charges%)",

	-- Sharpening Stones
	[2862]="Sharpened %+2 %(%d+ min%)",
	[2863]="Sharpened %+3 %(%d+ min%)",
	[2871]="Sharpened %+4 %(%d+ min%)",
	[7964]="Sharpened %+6 %(%d+ min%)",
	[12404]="Sharpened %+8 %(%d+ min%)",
	[18262]="Critical %+2%% %(%d+ min%)",
	[23122]="%+100 Attack Power vs Undead %(%d+ min%)",

	-- Wizard Oils
	[20746] = "Lesser Wizard Oil %(%d+ min%)",
	[20744] = "Minor Wizard Oil %(%d+ min%)",
	[20750] = "Wizard Oil %(%d+ min%)",
	[20749] = "Brilliant Wizard Oil %(%d+ min%)",
	[23123] = "Blessed Wizard Oil %(%d+ min%)",
} end)
