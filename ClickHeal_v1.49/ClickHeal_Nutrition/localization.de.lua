-- Version : German

if ( GetLocale() == "deDE" ) then

CLICKHEAL_NUTRITION = {

  ActionTypeText = { FOOD  = 'Essen',
                     DRINK = 'Trinken',
                     FEAST = 'Essen & Trinken',			-- alternative: "Schmausen", "Festmahl"
                   };

  ItemTypeConsumable = 'Verbrauchbar';
  PatternConjured    = 'Herbeigezauberter Gegenstand';

  PatternStuffAmount  = '^Benutzen: Stellt im Verlauf von %d+ Sek%. (%d+) Punkt%(e%) Gesundheit wieder her.';
  PatternSpecialFood  = 'Ihr m\195\188sst beim Essen sitzen bleiben%.$';			-- you have to negate this! (not ...)

  PatternSoakAmount   = '^Benutzen: Stellt im Verlauf von %d+ Sek%. (%d+) Punkt%(e%) Mana wieder her.';
  PatternSpecialDrink = 'Ihr m\195\188sst beim Trinken sitzen bleiben%.$';			-- you have to negate this! (not ...)

};

-- localziation deDE
end
