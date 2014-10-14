-- Version : French

if ( GetLocale() == "frFR" ) then

CLICKHEAL_NUTRITION = {

  ActionTypeText = { FOOD  = 'Eat food',
                     DRINK = 'Drink water',
                     FEAST = 'Feast (eat & drink)',
                   };

  ItemTypeConsumable = 'Consommable';
  PatternConjured    = 'Objet invoqu\195\169';

  PatternStuffAmount  = '^Utiliser : Rend (%d+) points de vie en %d+ sec';
  PatternSpecialFood  = 'Vous devez rester assis pendant que vous mangez%.$';	-- you have to negate this! (not ...)

  PatternSoakAmount   = '^Utiliser : Rend (%d+) points de mana en %d+ sec';
  PatternSpecialDrink = 'Vous devez rester assis pendant que vous buvez%.$';	-- you have to negate this! (not ...)

};

-- localization fr
end
