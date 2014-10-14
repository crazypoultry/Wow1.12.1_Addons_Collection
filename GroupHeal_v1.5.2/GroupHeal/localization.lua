

GROUPHEAL_STRINGS = {};

GROUPHEAL_STRINGS["getfenv"] = getfenv;
GROUPHEAL_STRINGS["setfenv"] = setfenv;
GROUPHEAL_STRINGS["GetLocale"] = GetLocale;
setfenv(1, GROUPHEAL_STRINGS);


-------------------------------------------------------------------------
-- English
-------------------------------------------------------------------------


castingNotification = "Casting %s on %s in %.1f seconds.";
spellCancelled = "***Spell Casting Cancelled***";
BINDING_HEADER_PREFIX = "Group Heal - ";
BINDING_PREFIX_HEAL_PLAYER = "Heal Player";
BINDING_PREFIX_HEAL_PARTY1 = "Heal Party 1";
BINDING_PREFIX_HEAL_PARTY2 = "Heal Party 2";
BINDING_PREFIX_HEAL_PARTY3 = "Heal Party 3";
BINDING_PREFIX_HEAL_PARTY4 = "Heal Party 4";
BINDING_PREFIX_HEAL_TARGET = "Heal Target";
BINDING_PREFIX_SHIELD_PLAYER = "Shield Player";
BINDING_PREFIX_SHIELD_PARTY1 = "Shield Party 1";
BINDING_PREFIX_SHIELD_PARTY2 = "Shield Party 2";
BINDING_PREFIX_SHIELD_PARTY3 = "Shield Party 3";
BINDING_PREFIX_SHIELD_PARTY4 = "Shield Party 4";
BINDING_PREFIX_SHIELD_TARGET = "Shield Target";

CONDITIONAL_SPELL_CANCEL_BINDING = "Conditional Spell Cancellation";

DRUID = "Druid";
HEALING_TOUCH = "Healing Touch";
REGROWTH = "Regrowth";
REJUVENATION = "Rejuvenation";

PRIEST = "Priest";
HEAL = "Heal";
HEAL_LESSER = "Lesser Heal";
HEAL_GREATER = "Greater Heal";
FLASH_HEAL = "Flash Heal";
RENEW = "Renew";
SHIELD = "Power Word: Shield";

SHAMAN = "Shaman";
HEALING_WAVE = "Healing Wave";
LESSER_HEALING_WAVE = "Lesser Healing Wave";

PALADIN = "Paladin";
HOLY_LIGHT = "Holy Light";
FLASH_OF_LIGHT = "Flash of Light";

OVERHEAL_WARNING_TEXT = "*** Overheal Warning ***";

CONFIG_SHOWHIDEBUTTON_TOOLTIP = "Show/Hide the %s button.";
CONFIG_SHOWHIDEBUTTONS_PLAYER_TITLE = "Player Heal Buttons";
CONFIG_SHOWHIDEBUTTONS_PARTY_TITLE = "Party Heal Buttons";
CONFIG_SHOWHIDEBUTTONS_TARGET_TITLE = "Target Heal Buttons";
CONFIG_REPORTING_PARTY_TO_PARTY_TEXT = "Report Party Heals to Party";
CONFIG_REPORTING_PARTY_TO_PARTY_TOOLTIP = "Enables reporting of heals targeting Party members to your Party.";
CONFIG_REPORTING_WHILE_IN_RAID_TEXT = "While in a Raid";
CONFIG_REPORTING_WHILE_IN_RAID_TOOLTIP = "Enables reporting of heals targeting Party members while in a Raid group.";
CONFIG_MANACONSERVE_TOOLTIP = "Adjust this value to change the sensitivity of the Mana Conservation feature for %s.";
CONFIG_MANACONSERVE_TITLE = "Mana Conservation System";
CONFIG_MANACONSERVE_ENABLED_TEXT = CONFIG_MANACONSERVE_TITLE;
CONFIG_DISPLAY_OVERHEAL_WARNING_TEXT = "Display Overheal Warning";
CONFIG_DISPLAY_OVERHEAL_WARNING_TOOLTIP = "Enable this option to display a warning message when your current heal target is going to be overhealed.";
CONFIG_HEALREPORTING_TITLE = "Heal Reporting Options";
CONFIG_MISCOPTIONS_TITLE = "Miscellaneous Settings";
CONFIG_HEALBUTTON_TOOLTIPS_TEXT = "Show Button Tooltips";
CONFIG_HEALBUTTON_TOOLTIPS_TOOLTIP = "Disable this option to stop showing healing button tooltips.";
CONFIG_FRAMETITLE = "GroupHeal Configuration";
CONFIG_TABTITLE_1 = "General";
CONFIG_TABTITLE_2 = "Advanced";

CONFIG_CANCELWARNINGCOLOUR_TEXT = "OverHeal Warning";
CONFIG_CANCELWARNINGCOLOUR_TOOLTIP = "The default colour for the overheal warning message.";
CONFIG_CANCELNOWCOLOUR_TEXT = "OverHeal Imminent";
CONFIG_CANCELNOWCOLOUR_TOOLTIP = "The overheal warning message will change to this colour when the casting time left is less than the set cancel time.";

CONFIG_PARTYCANCELTIME_TEXT = "While in Party";
CONFIG_PARTYCANCELTIME_TOOLTIP = "Controls the minimum cancel time while in a party.";
CONFIG_RAIDCANCELTIME_TEXT = "While in Raid";
CONFIG_RAIDCANCELTIME_TOOLTIP = "Controls the minimum cancel time while in a raid.";

CONFIG_MANACONSERVE_SUBTITLE1 = "Spell Sensitivity";
CONFIG_MANACONSERVE_SUBTITLE2 = "Cancel Times";

CONFIG_HELPTIP_MANACONSERVE_SENSITIVITY_TITLE = CONFIG_MANACONSERVE_SUBTITLE1;
CONFIG_HELPTIP_MANACONSERVE_SENSITIVITY_TEXT = "These settings describe what percentage of the spell's minimum heal amount should not be wasted if the current spell lands on its target.  A value 100 is the most sensitive, while a value of 0 will disable Mana Conservation for that spell.";


CONFIG_HELPTIP_CANCEL_TIMES_TITLE = CONFIG_MANACONSERVE_SUBTITLE2;
CONFIG_HELPTIP_CANCEL_TIMES_TEXT = "These settings adjust minimum time before the end of a spellcast that the Mana Conservation system will allow a spell to be cancelled.  \nTimes are in seconds.";

CONFIG_HELPTIP_MANACONSERVE_TITLE = CONFIG_MANACONSERVE_TITLE;
CONFIG_HELPTIP_MANACONSERVE_TEXT = "These settings adjust the behaviour of GroupHeal's Mana Conservation aids.";

-------------------------------------------------------------------------
-- German
-------------------------------------------------------------------------

if ( GetLocale() == "deDE" ) then

	DRUID = "Druide";
	HEALING_TOUCH = "Heilende Ber\195\188hrung";
	REGROWTH = "Nachwachsen";
	REJUVENATION = "Verj\195\188ngung";

	PRIEST = "Priester";
	HEAL = "Heilen";
	HEAL_LESSER = "Geringes Heilen";
	HEAL_GREATER = "Gro\195\159e Heilung";
	FLASH_HEAL = "Blitzheilung";
	RENEW = "Erneuerung";
	SHIELD = "Machtwort: Schild";

	SHAMAN = "Schamane";
	HEALING_WAVE = "Welle der Heilung";
	LESSER_HEALING_WAVE = "Geringe Welle der Heilung";

	PALADIN = "Paladin";
	HOLY_LIGHT = "Heiliges Licht";
	FLASH_OF_LIGHT = "Lichtblitz";

end

-------------------------------------------------------------------------
-- French
-------------------------------------------------------------------------
if ( GetLocale() == "frFR" ) then

	DRUID = "Druide";
	HEALING_TOUCH = "Toucher gu\195\169risseur";
	REGROWTH = "R\195\169tablissement";
	REJUVENATION = "R\195\169cup\195\169ration";

	PRIEST = "Pr\195\170tre";
	HEAL = "Soins";
	HEAL_LESSER = "Soins mineurs";
	HEAL_GREATER = "Soins sup\195\169rieurs";
	FLASH_HEAL = "Soins rapides";
	RENEW = "R\195\169novation";
	SHIELD = "Mot de pouvoir : Bouclier";

	SHAMAN = "Chaman";
	HEALING_WAVE = "Vague de soins";
	LESSER_HEALING_WAVE = "Vague de soins inf\195\169rieurs";

	PALADIN = "Paladin";
	HOLY_LIGHT = "Lumi\195\168re sacr\195\169e";
	FLASH_OF_LIGHT = "Eclair lumineux", "Eclair lumineux";

end

setfenv(1, getfenv(0));
GROUPHEAL_STRINGS["getfenv"] = nil;
GROUPHEAL_STRINGS["setfenv"] = nil;
GROUPHEAL_STRINGS["GetLocale"] = nil;


-------------------------------------------------------------------------
-- Binding Name Variables
-------------------------------------------------------------------------

BINDING_HEADER_GROUPHEAL_BIGHEAL = GROUPHEAL_STRINGS.BINDING_HEADER_PREFIX;
BINDING_HEADER_GROUPHEAL_FASTHEAL = GROUPHEAL_STRINGS.BINDING_HEADER_PREFIX;
BINDING_HEADER_GROUPHEAL_OVERTIMEHEAL = GROUPHEAL_STRINGS.BINDING_HEADER_PREFIX;
BINDING_HEADER_GROUPHEAL_SHIELD = GROUPHEAL_STRINGS.BINDING_HEADER_PREFIX;
BINDING_HEADER_GROUPHEAL_MANA_CONSERVATION = GROUPHEAL_STRINGS.BINDING_HEADER_PREFIX .. GROUPHEAL_STRINGS.CONFIG_MANACONSERVE_TITLE;
BINDING_NAME_GROUPHEAL_CONDITIONAL_CANCEL = GROUPHEAL_STRINGS.CONDITIONAL_SPELL_CANCEL_BINDING;

BINDING_NAME_GROUPHEAL_PLAYER_BIGHEAL = GROUPHEAL_STRINGS.BINDING_PREFIX_HEAL_PLAYER;
BINDING_NAME_GROUPHEAL_PARTY1_BIGHEAL = GROUPHEAL_STRINGS.BINDING_PREFIX_HEAL_PARTY1;
BINDING_NAME_GROUPHEAL_PARTY2_BIGHEAL = GROUPHEAL_STRINGS.BINDING_PREFIX_HEAL_PARTY2;
BINDING_NAME_GROUPHEAL_PARTY3_BIGHEAL = GROUPHEAL_STRINGS.BINDING_PREFIX_HEAL_PARTY3;
BINDING_NAME_GROUPHEAL_PARTY4_BIGHEAL = GROUPHEAL_STRINGS.BINDING_PREFIX_HEAL_PARTY4;
BINDING_NAME_GROUPHEAL_TARGET_BIGHEAL = GROUPHEAL_STRINGS.BINDING_PREFIX_HEAL_TARGET;

BINDING_NAME_GROUPHEAL_PLAYER_FASTHEAL = GROUPHEAL_STRINGS.BINDING_PREFIX_HEAL_PLAYER;
BINDING_NAME_GROUPHEAL_PARTY1_FASTHEAL = GROUPHEAL_STRINGS.BINDING_PREFIX_HEAL_PARTY1;
BINDING_NAME_GROUPHEAL_PARTY2_FASTHEAL = GROUPHEAL_STRINGS.BINDING_PREFIX_HEAL_PARTY2;
BINDING_NAME_GROUPHEAL_PARTY3_FASTHEAL = GROUPHEAL_STRINGS.BINDING_PREFIX_HEAL_PARTY3;
BINDING_NAME_GROUPHEAL_PARTY4_FASTHEAL = GROUPHEAL_STRINGS.BINDING_PREFIX_HEAL_PARTY4;
BINDING_NAME_GROUPHEAL_TARGET_FASTHEAL = GROUPHEAL_STRINGS.BINDING_PREFIX_HEAL_TARGET;

BINDING_NAME_GROUPHEAL_PLAYER_OVERTIMEHEAL = GROUPHEAL_STRINGS.BINDING_PREFIX_HEAL_PLAYER;
BINDING_NAME_GROUPHEAL_PARTY1_OVERTIMEHEAL = GROUPHEAL_STRINGS.BINDING_PREFIX_HEAL_PARTY1;
BINDING_NAME_GROUPHEAL_PARTY2_OVERTIMEHEAL = GROUPHEAL_STRINGS.BINDING_PREFIX_HEAL_PARTY2;
BINDING_NAME_GROUPHEAL_PARTY3_OVERTIMEHEAL = GROUPHEAL_STRINGS.BINDING_PREFIX_HEAL_PARTY3;
BINDING_NAME_GROUPHEAL_PARTY4_OVERTIMEHEAL = GROUPHEAL_STRINGS.BINDING_PREFIX_HEAL_PARTY4;
BINDING_NAME_GROUPHEAL_TARGET_OVERTIMEHEAL = GROUPHEAL_STRINGS.BINDING_PREFIX_HEAL_TARGET;

BINDING_NAME_GROUPHEAL_PLAYER_SHIELD = GROUPHEAL_STRINGS.BINDING_PREFIX_SHIELD_PLAYER;
BINDING_NAME_GROUPHEAL_PARTY1_SHIELD = GROUPHEAL_STRINGS.BINDING_PREFIX_SHIELD_PARTY1;
BINDING_NAME_GROUPHEAL_PARTY2_SHIELD = GROUPHEAL_STRINGS.BINDING_PREFIX_SHIELD_PARTY2;
BINDING_NAME_GROUPHEAL_PARTY3_SHIELD = GROUPHEAL_STRINGS.BINDING_PREFIX_SHIELD_PARTY3;
BINDING_NAME_GROUPHEAL_PARTY4_SHIELD = GROUPHEAL_STRINGS.BINDING_PREFIX_SHIELD_PARTY4;
BINDING_NAME_GROUPHEAL_TARGET_SHIELD = GROUPHEAL_STRINGS.BINDING_PREFIX_SHIELD_TARGET;


-------------------------------------------------------------------------
-- 
-------------------------------------------------------------------------

local _G = getfenv(0);

for k, v in GROUPHEAL_STRINGS do
	_G["GROUPHEAL_"..k] = v;
end