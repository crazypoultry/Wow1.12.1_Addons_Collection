-- Version : Korean
if (GetLocale() == "koKR") then

CLICKHEAL_POTION = {

  ActionTypeText = { HEALPOD = '치유 물약',
	             MANAPOD = '마나 물약',
		   };

  -- Healing Potions
  MinorHealingPotion      = '최하급 치유 물약';
  LesserHealingPotion     = '하급 치유 물약';
  DiscoloredHealingPotion = '빛바랜 치유 물약';
  HealingPotion           = '치유 물약';
  GreaterHealingPotion    = '상급 치유 물약';
  CombatHealingPotion     = '전투 치유 물약';
  SuperiorHealingPotion   = '최상급 치유 물약';
  MajorHealingPotion      = '일급 치유 물약';

  -- Healthstones (Warlock)
  MinorHealthstone   = '최하급 생명석';
  LesserHealthstone  = '하급 생명석';
  Healthstone        = '중급 생명석';
  GreaterHealthstone = '상급 생명석';
  MajorHealthstone   = '최상급 생명석';

  -- Mana Potions
  MinorManaPotion    = '최하급 마나 물약';
  LesserManaPotion   = '하급 마나 물약';
  ManaPotion         = '마나 물약';
  GreaterManaPotion  = '상급 마나 물약';
  CombatManaPotion   = '전투 마나 물약';
  SuperiorManaPotion = '최상급 마나 물약';
  MajorManaPotion    = '일급 마나 물약';

  -- Mana Gems (Mage)
  ManaAgate   = '마나 마노';
  ManaJade    = '마나 비취';
  ManaCitrine = '마나 황수정';
  ManaRuby    = '마나 루비';

  -- Messages
  MsgTooHealthy        = '이미 생명력이 모두 회복되었습니다..';
  MsgNoHealPotionFound = '생명석이나 치유 물약을 가지고 있지 않습니다.';
  MsgTooManaish        = '이미 마나가 모두 회복되어습니다..';
  MsgNoManaPotionFound = '마나 보석이나 마나 물약을 가지고 있지 않습니다.';

};

end
