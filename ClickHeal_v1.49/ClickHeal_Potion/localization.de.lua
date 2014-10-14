-- Version : German

if ( GetLocale() == "deDE" ) then

CLICKHEAL_POTION = {

  ActionTypeText = { HEALPOD = 'Quaff Healing Potion',
                     MANAPOD = 'Quaff Mana Potion',
                   };

  -- Healing Potions
  MinorHealingPotion      = 'Schwacher Heiltrank';
  LesserHealingPotion     = 'Geringer Heiltrank';
  DiscoloredHealingPotion = 'Verf\195\164rbter Heiltrank';
  HealingPotion           = 'Heiltrank';
  GreaterHealingPotion    = 'Gro\195\159er Heiltrank';
  CombatHealingPotion     = 'Gefechtsheiltrank';
  SuperiorHealingPotion   = '\195\156berragender Heiltrank';
  MajorHealingPotion      = 'Erheblicher Heiltrank';

  -- Healthstones (Warlock)
  MinorHealthstone   = 'Schwacher Gesundheitsstein';
  LesserHealthstone  = 'Geringer Gesundheitsstein';
  Healthstone        = 'Gesundheitsstein';
  GreaterHealthstone = 'Gro\195\159er Gesundheitsstein';
  MajorHealthstone   = 'Erheblicher Gesundheitsstein';

  -- Mana Potions
  MinorManaPotion    = 'Schwacher Manatrank';
  LesserManaPotion   = 'Geringer Manatrank';
  ManaPotion         = 'Manatrank';
  GreaterManaPotion  = 'Gro\195\159er Manatrank';
  CombatManaPotion   = 'Gefechtsmanatrank';
  SuperiorManaPotion = '\195\156berragender Manatrank';
  MajorManaPotion    = 'Erheblicher Manatrank';

  -- Mana Gems (Mage)
  ManaAgate   = 'Manaachat';
  ManaJade    = 'Manajadestein';
  ManaCitrine = 'Manacitrin';
  ManaRuby    = 'Manarubin';

  -- Messages
  MsgTooHealthy        = 'Deine Gesundheit ist zu hoch f\195\188r einen Heiltrank.';
  MsgNoHealPotionFound = 'Kein passender Heiltrank oder Gesundheitsstein gefunden.';
  MsgTooManaish        = 'Dein Mana ist zu hoch f\195\188r einen Manatrank.';
  MsgNoManaPotionFound = 'Kein passender Manatrank oder Stein gefunden.';

};

-- localization deDE
end
