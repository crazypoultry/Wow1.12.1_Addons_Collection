-- Version : French

if ( GetLocale() == "frFR" ) then

CLICKHEAL_POTION = {

  ActionTypeText = { HEALPOD = 'Quaff Healing Potion',
                     MANAPOD = 'Quaff Mana Potion',
                   };

  -- Healing Potions : Potions de soins
  MinorHealingPotion      = 'Potion de soins mineure';
  LesserHealingPotion     = 'Potion de soins inf\195\169rieure';
  DiscoloredHealingPotion = 'Potion de soins d\195\169color\195\169e';
  HealingPotion           = 'Potion de soins';
  GreaterHealingPotion    = 'Potion de soins sup\195\169rieure';
  CombatHealingPotion     = 'Potion de soins de combat';
  SuperiorHealingPotion   = 'Potion de soins excellente';
  MajorHealingPotion      = 'Potion de soins majeure';

  -- Healthstones (Warlock) : Pierres de soins (Démoniste)
  MinorHealthstone   = 'Pierre de soins mineure';
  LesserHealthstone  = 'Pierre de soins inf\195\169rieure';
  Healthstone        = 'Pierre de soins';
  GreaterHealthstone = 'Pierre de soins sup\195\169rieure';
  MajorHealthstone   = 'Pierre de soins majeure';

  -- Mana Potions : Potions de mana
  MinorManaPotion    = 'Potion de mana mineure';
  LesserManaPotion   = 'Potion de mana inf\195\169rieure';
  ManaPotion         = 'Potion de mana';
  GreaterManaPotion  = 'Potion de mana sup\195\169rieure';
  CombatManaPotion   = 'Potion de mana de combat';
  SuperiorManaPotion = 'Potion de mana excellente';
  MajorManaPotion    = 'Potion de mana majeure';

  -- Mana Gems (Mage) : Gemmes de mana (Mage)
  ManaAgate   = 'Agate de mana';
  ManaJade    = 'Jade de mana';
  ManaCitrine = 'Citrine de mana';
  ManaRuby    = 'Rubis de mana';

  -- Messages
  MsgTooHealthy        = 'Vous \195\170tes trop bien portant pour une potion de soins.';
  MsgNoHealPotionFound = 'Aucune potion de soins, ou pierre de soins, appropri\195\169e trouv\195\169e.';
  MsgTooManaish        = 'Votre mana est trop haute pour une potion de mana.';
  MsgNoManaPotionFound = 'Aucune potion de mana, ou gemme, appropri\195\169e trouv\195\169e.';

};

-- localization fr
end
