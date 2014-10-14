-- Version : Korean

if (GetLocale() == "koKR") then

	CLICKHEAL_NUTRITION = {

	  ActionTypeText = { FOOD  = '음식',
		             DRINK = '음료',
			     FEAST = '음식&음료',
	                   };

	  ItemTypeConsumable = '소비 용품';
	  PatternConjured    = '창조 아이템';

	  PatternStuffAmount  = '초에 걸쳐 총 (%d+)의 생명력이';
	  PatternSpecialFood  = '음식을 먹으려면 앉아 있어야 합니다%.$';			-- you have to negate this! (not ...)

	  PatternSoakAmount   = '초에 걸쳐 총 (%d+)의 마나가';
	  PatternSpecialDrink = '음료를 마시려면 앉아 있어야 합니다%.$';			-- you have to negate this! (not ...)

	};
end