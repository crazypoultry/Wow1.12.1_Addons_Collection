-- Version : English

CLICKHEAL_NUTRITION = {

  ActionTypeText = { FOOD  = 'Eat food',
                     DRINK = 'Drink water',
                     FEAST = 'Feast (eat & drink)',
                   };

  ItemTypeConsumable = 'Consumable';
  PatternConjured    = 'Conjured Item';

  PatternStuffAmount  = '^Use: Restores (%d+) health over %d+ sec';
  PatternSpecialFood  = 'Must remain seated while eating%.$';			-- you have to negate this! (not ...)

  PatternSoakAmount   = '^Use: Restores (%d+) mana over %d+ sec';
  PatternSpecialDrink = 'Must remain seated while drinking%.$';			-- you have to negate this! (not ...)

};
