--
-- EquipCompare localization information
--
-- Contents:
-- * Localized versions of item names that are not available by default from Blizzard
-- * Usage information
-- * UltimateUI labels and information
--
-- Supported languages:
-- English, French, German
--

-- Unlocalized texts (for now)
EQUIPCOMPARE_USAGE_TEXT = "EquipCompare\nHover over items to compare them easily with ones you have equipped.\nUsage:\n";
EQUIPCOMPARE_USAGE_TEXT = EQUIPCOMPARE_USAGE_TEXT.."/equipcompare, /eqc          - toggle EquipCompare on/off\n";
EQUIPCOMPARE_USAGE_TEXT = EQUIPCOMPARE_USAGE_TEXT.."/equipcompare, /eqc [on|off] - turn EquipCompare on/off\n";
EQUIPCOMPARE_USAGE_TEXT = EQUIPCOMPARE_USAGE_TEXT.."/equipcompare, /eqc help     - this text\n";
	
-- UltimateUI configuration texts, unlocalized (for now)
EQUIPCOMPARE_ULTIMATEUI_SECTION = "EquipCompare";
EQUIPCOMPARE_ULTIMATEUI_SECTION_INFO = "Options for Equipment Comparison tooltips.";
EQUIPCOMPARE_ULTIMATEUI_HEADER = "EquipCompare";
EQUIPCOMPARE_ULTIMATEUI_HEADER_INFO = "Options for Equipment Comparison tooltips.";
EQUIPCOMPARE_ULTIMATEUI_ENABLE = "Enable Equipment Comparison tooltips";
EQUIPCOMPARE_ULTIMATEUI_ENABLE_INFO = "By enabling this option you get extra tooltips.";
EQUIPCOMPARE_ULTIMATEUI_SLASH_DESC = "Allows you to turn EquipCompare on and off. Type /equipcompare help for usage."
-- French
if (GetLocale() == "frFR") then
	if (not INVTYPE_WAND) then INVTYPE_WAND = "Baguette" end;
	if (not INVTYPE_GUN) then INVTYPE_GUN = "Arme \195\160 feu" end;
	if (not INVTYPE_GUNPROJECTILE) then INVTYPE_GUNPROJECTILE = "Projectile" end;
	if (not INVTYPE_BOWPROJECTILE) then INVTYPE_BOWPROJECTILE = "Projectile" end;

-- German
elseif (GetLocale() == "deDE") then
	if (not INVTYPE_WAND) then INVTYPE_WAND = "Zauberstab" end;
	if (not INVTYPE_GUN) then INVTYPE_GUN = "Schusswaffe" end;
	if (not INVTYPE_GUNPROJECTILE) then INVTYPE_GUNPROJECTILE = "Projektil Kugel" end;
	if (not INVTYPE_BOWPROJECTILE) then INVTYPE_BOWPROJECTILE = "Projektil Pfeil" end;

-- English or unsupported
else
	if (not INVTYPE_WAND) then INVTYPE_WAND = "Wand" end;
	if (not INVTYPE_GUN) then INVTYPE_GUN = "Gun" end;
	if (not INVTYPE_GUNPROJECTILE) then INVTYPE_GUNPROJECTILE = "Projectile" end;
	if (not INVTYPE_BOWPROJECTILE) then INVTYPE_BOWPROJECTILE = "Projectile" end;

end
