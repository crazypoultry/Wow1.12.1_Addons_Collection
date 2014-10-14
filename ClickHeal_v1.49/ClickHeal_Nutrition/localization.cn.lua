-- Version : Chinese

if ( GetLocale() == "zhCN" ) then

CLICKHEAL_NUTRITION = {

  ActionTypeText = { FOOD  = '吃食物',
                     DRINK = '喝水',
                     FEAST = '吃吃喝喝',
                   };

  ItemTypeConsumable = '消耗品';
  PatternConjured    = '魔法制造的物品';

  PatternStuffAmount  = '使用： 在(%d+)秒内恢复总计(%d+)点生命值';
  PatternSpecialFood  = '进食时必须保持坐姿。';			-- you have to negate this! (not ...)

  PatternSoakAmount   = '使用： 在(%d+) 秒内恢复总计(%d+)点法力值';
  PatternSpecialDrink = '喝水时必须保持坐姿。';			-- you have to negate this! (not ...)

};

end
