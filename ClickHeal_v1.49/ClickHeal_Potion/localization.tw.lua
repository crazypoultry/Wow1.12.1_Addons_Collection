-- Version : Chinese

if ( GetLocale() == "zhTW" ) then

CLICKHEAL_POTION = {

  ActionTypeText = { HEALPOD = '喝血瓶',
                     MANAPOD = '喝藍瓶',
                   };

  -- Healing Potions
  MinorHealingPotion      = '初級治療藥水';
  LesserHealingPotion     = '次級治療藥水';
  DiscoloredHealingPotion = '透明治療藥水';
  HealingPotion           = '治療藥水';
  GreaterHealingPotion    = '強效治療藥水';
  CombatHealingPotion     = '作戰治療藥水';
  SuperiorHealingPotion   = '超強治療藥水';
  MajorHealingPotion      = '極效治療藥水';

  -- Healthstones (Warlock)
  MinorHealthstone   = '初級治療石';
  LesserHealthstone  = '次級治療石';
  Healthstone        = '治療石';
  GreaterHealthstone = '強效治療石';
  MajorHealthstone   = '極效治療石';

  -- Mana Potions
  MinorManaPotion    = '初級法力藥水';
  LesserManaPotion   = '次級法力藥水';
  ManaPotion         = '法力藥水';
  GreaterManaPotion  = '強傚法力藥水';
  CombatManaPotion   = '作戰法力藥水';
  SuperiorManaPotion = '超強法力藥水';
  MajorManaPotion    = '極傚法力藥水';

  -- Mana Gems (Mage)
  ManaAgate   = '魔法瑪瑙';
  ManaJade    = '魔法翡翠';
  ManaCitrine = '魔法黃水晶';
  ManaRuby    = '魔法紅寶石';

  -- Messages
  MsgTooHealthy        = '你不需要喝血';
  MsgNoHealPotionFound = '沒找到血瓶或治療石';
  MsgTooManaish        = '你有足夠的法力';
  MsgNoManaPotionFound = '沒找到藍瓶或魔法石';

};

end
