-- Version : Chinese

if ( GetLocale() == "zhTW" ) then

CLICKHEAL_NUTRITION = {

  ActionTypeText = { FOOD  = '吃食物',
                     DRINK = '喝水',
                     FEAST = '吃吃喝喝',
                   };

  ItemTypeConsumable = '消耗品';
  PatternConjured    = '魔法製造的物品';

  PatternStuffAmount  = '使用： 在(%d+)秒內恢復總計(%d+)點生命值';
  PatternSpecialFood  = '進食時必須保持坐姿。';			-- you have to negate this! (not ...)

  PatternSoakAmount   = '使用： 在(%d+) 秒內恢復總計(%d+)點法力值';
  PatternSpecialDrink = '喝水時必須保持坐姿。';			-- you have to negate this! (not ...)

};

end
