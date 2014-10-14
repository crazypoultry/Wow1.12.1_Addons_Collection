-- Version : Chinese

if ( GetLocale() == "zhCN" ) then

CLICKHEAL_POTION = {

  ActionTypeText = { HEALPOD = '喝血瓶',
                     MANAPOD = '喝蓝瓶',
                   };

  -- Healing Potions
  MinorHealingPotion      = '初级治疗药水';
  LesserHealingPotion     = '次级治疗药水';
  DiscoloredHealingPotion = '透明治疗药水';
  HealingPotion           = '治疗药水';
  GreaterHealingPotion    = '强效治疗药水';
  CombatHealingPotion     = '作战治疗药水';
  SuperiorHealingPotion   = '超强治疗药水';
  MajorHealingPotion      = '极效治疗药水';

  -- Healthstones (Warlock)
  MinorHealthstone   = '初级治疗石';
  LesserHealthstone  = '次级治疗石';
  Healthstone        = '治疗石';
  GreaterHealthstone = '强效治疗石';
  MajorHealthstone   = '极效治疗石';

  -- Mana Potions
  MinorManaPotion    = '初级法力药水';
  LesserManaPotion   = '次级法力药水';
  ManaPotion         = '法力药水';
  GreaterManaPotion  = '强效法力药水';
  CombatManaPotion   = '作战法力药水';
  SuperiorManaPotion = '超强法力药水';
  MajorManaPotion    = '极效法力药水';

  -- Mana Gems (Mage)
  ManaAgate   = '魔法玛瑙';
  ManaJade    = '魔法翡翠';
  ManaCitrine = '魔法黄水晶';
  ManaRuby    = '魔法红宝石';

  -- Messages
  MsgTooHealthy        = '你不需要喝血';
  MsgNoHealPotionFound = '没找到血瓶或治疗石';
  MsgTooManaish        = '你有足够的法力';
  MsgNoManaPotionFound = '没找到蓝瓶或魔法石';

};

end
