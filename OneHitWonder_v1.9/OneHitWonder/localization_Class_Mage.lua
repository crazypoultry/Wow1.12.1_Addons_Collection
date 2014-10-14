-- Mage options

ONEHITWONDER_MAGE_SEPARATOR									= "Mage Section";
ONEHITWONDER_MAGE_SEPARATOR_INFO							= "Contains settings for the Mage";

ONEHITWONDER_MAGE_BUFF_NON_CASTERS_INTELLECT				= "Buff non-casters Intelligence";
ONEHITWONDER_MAGE_BUFF_NON_CASTERS_INTELLECT_INFO			= "Buffs non-casters with Arcane Intellect";

ONEHITWONDER_MAGE_ARCANE_INTELLECT_MANA						= "Mana needed for AI";
ONEHITWONDER_MAGE_ARCANE_INTELLECT_MANA_INFO				= "The amount of mana needed to allow casting of Arcane Intellect. Set to 101 to prevent casting.";
ONEHITWONDER_MAGE_ARCANE_INTELLECT_MANA_APPEND				= " %";

ONEHITWONDER_MAGE_ARMOR_CHOICE								= "What Armor spell(s) to use";
ONEHITWONDER_MAGE_ARMOR_CHOICE_INFO							= "Tells OHW what armor spell to use. 0 = no armor. 1 = Frost/Ice. 2 = Mage. 3 = Smart (Mage in groups, Frost/Ice otherwise).";
ONEHITWONDER_MAGE_ARMOR_CHOICE_APPEND						= "";

ONEHITWONDER_MAGE_MAGNITUDE_CHOICE							= "Use Amplify/Dampen Magic";
ONEHITWONDER_MAGE_MAGNITUDE_CHOICE_INFO						= "Tells OHW to buff with amplify/dampen spell. 0 = disable. 1 = Dampen (if no healers). 2 = Amplify (if healers). 3 = Smart (Dampen if no healers, else Amplify). 4 = Always Dampen. 5. Always Amplify.";
ONEHITWONDER_MAGE_MAGNITUDE_CHOICE_APPEND					= "";

ONEHITWONDER_MAGE_REACTIVE_CAST_WARDS						= "Cast Wards reactively";
ONEHITWONDER_MAGE_REACTIVE_CAST_WARDS_INFO					= "Allows OHW to cast Wards when it deems necessary. 0 = none. 1 = Fire. 2 = Frost. 3 = Both.";
ONEHITWONDER_MAGE_REACTIVE_CAST_WARDS_APPEND				= "";

ONEHITWONDER_MAGE_REACTIVE_CAST_MANA_SHIELD					= "Cast Mana Shield reactively";
ONEHITWONDER_MAGE_REACTIVE_CAST_MANA_SHIELD_INFO			= "Allows OHW to cast Mana Shield when it deems necessary.";

ONEHITWONDER_MAGE_USE_COUNTERSPELL							= "Cast Counterspell reactively";
ONEHITWONDER_MAGE_USE_COUNTERSPELL_INFO						= "Allows OHW to cast Counterspell when it deems necessary (currently all spells).";

ONEHITWONDER_MAGE_REACTIVE_MANA_SHIELD_HEALTH				= "How low health should be";
ONEHITWONDER_MAGE_REACTIVE_MANA_SHIELD_HEALTH_INFO			= "The highest percentage of health the Mana Shield should be cast at.";
ONEHITWONDER_MAGE_REACTIVE_MANA_SHIELD_HEALTH_APPEND		= "%";

ONEHITWONDER_MAGE_REACTIVE_MANA_SHIELD_MANA					= "How high mana should be";
ONEHITWONDER_MAGE_REACTIVE_MANA_SHIELD_MANA_INFO			= "The lowest percentage of mana the Mana Shield should be cast at.";
ONEHITWONDER_MAGE_REACTIVE_MANA_SHIELD_MANA_APPEND			= "%";


if ( GetLocale() == "frFR" ) then
elseif ( GetLocale() == "deDE" ) then
end
