	-- English localized variables (default)
	GATHERER_VERSION_WARNING="New Gatherer Version detected, check zone match.";
	GATHERER_NOTEXT="([-]) no text "

	-- TRADE NAME
	TRADE_HERBALISM="Herbalism"
	OLD_TRADE_HERBALISM="Herbalism"
	TRADE_MINING="Mining"
	TRADE_OPENING="Opening"
	GATHER_HERBALISM="Herb Gathering"

	-- strings for gather line in chat
	HERB_GATHER_STRING="You perform Herb Gathering on"
	ORE_GATHER_STRING="You perform Mining on"
	TREASURE_GATHER_STRING="You perform Opening on"

	FISH_GATHER_STRING = "You perform Fishing"

	-- Length of the string to keep the gather name
	HERB_GATHER_LENGTH=31
	HERB_GATHER_END=-2
	ORE_GATHER_LENGTH=31
	ORE_GATHER_END=-2
	TREASURE_GATHER_LENGTH=31
	TREASURE_GATHER_END=-2

	GATHERER_REQUIRE="Requires"
	GATHERER_NOSKILL="Requires"

	-- ore classes
	ORE_CLASS_VEIN   ="vein"
	ORE_CLASS_DEPOSIT="deposit"

	-- ore types
	ORE_COPPER    = " Mедная жила"
	ORE_TIN       = " Oловянная жила"
	ORE_IRON      = " 3алежи железа"
	ORE_SILVER    = " Cеребряная жила"
	ORE_TRUESILVER= " 3алежи истинного серебра"
	ORE_GOLD      = " 3олотая жила"
	ORE_MITHRIL   = " Мифриловые залежи"
	ORE_THORIUM   = " Tориевая жила"
	ORE_RTHORIUM  = " Богатая ториевая жила"
	ORE_DARKIRON  = " 3алежи черного железа"

	-- herb types 
	HERB_ARTHASTEAR        =" Слезы Артаса"
	HERB_BLACKLOTUS        =" Черный лотос"
	HERB_BLINDWEED         =" Пастушья сумка"
	HERB_BRIARTHORN        =" Остротерн"
	HERB_BRUISEWEED        =" Синячник"
	HERB_DREAMFOIL         =" Снолист"
	HERB_EARTHROOT         =" Земляной корень"
	HERB_FADELEAF          =" Бледнолист"
	HERB_FIREBLOOM         =" Огнецвет"
	HERB_GHOSTMUSHROOM     =" Призрачная поганка"
	HERB_GOLDENSANSAM      =" Золотой сансам"
	HERB_GOLDTHORN         =" Златошип"
	HERB_GRAVEMOSS         =" Могильный мох"
	HERB_GROMSBLOOD        =" Кровь Грома"
	HERB_ICECAP            =" Ледяной зев"
	HERB_KHADGARSWHISKER   =" Кадгаров ус"
	HERB_KINGSBLOOD        =" Королевская кровь"
	HERB_LIFEROOT          =" Корень жизни"
	HERB_MAGEROYAL         =" Магороза"
	HERB_MOUNTAINSILVERSAGE=" Горный серебряный шалфей"
	HERB_PEACEBLOOM        =" Мироцвет"
	HERB_PLAGUEBLOOM       =" Чумоцвет"
	HERB_PURPLELOTUS       =" Лиловый лотос"
	HERB_SILVERLEAF        =" Сребролист"
	HERB_STRANGLEKELP      =" Удавник"
	HERB_SUNGRASS          =" Солнечник"
	HERB_SWIFTTHISTLE      =" Остротерн"
	HERB_WILDSTEELBLOOM    =" Дикий сталецвет"
	HERB_WINTERSBITE       =" Морозник"
	HERB_WILDVINE	       =" Дикая лоза"

	-- treasure types
	TREASURE_BOX        	=" Коробка"
	TREASURE_CHEST      	=" Сундук"
	TREASURE_CLAM       	=" Гигантский моллюск"
	TREASURE_CRATE      	=" Ящик"
	TREASURE_BARREL     	=" Бочонок"
	TREASURE_CASK       	=" Бочка"
	TREASURE_SHELLFISHTRAP	=" Ловушка на моллюска"
	TREASURE_FOOTLOCKER 	= " Сундучки"

	TREASURE_BLOODHERO  	= " Кровь героев"

	TREASURE_UNGOROSOIL 	= " Почва Ун'Горо"
	--TREASURE_UNGOROSOIL_G	= " dirt pile"
	TREASURE_BLOODPETAL 	= " Побег кровоцвета"
	--TREASURE_BLOODPETAL_G 	= " bloodpetal sprout"
	TREASURE_POWERCRYST 	= " Кристалл силы"

	TREASURE_NIGHTDRAGON 	= " Ночной дракон"
	TREASURE_WHIPPERROOT 	= " Гнилой кнутокорень"
	TREASURE_WINDBLOSSOM 	= " Оскверненный ветроцвет"
	TREASURE_SONGFLOWER 	= " Оскверненный песнецвет"

	TREASURE_FISHNODE_TRIGGER1	= " Сундучок"; -- Trunk
--	TREASURE_FISHNODE_TRIGGER2	= "Bloated"; -- no longer found in wreckage in 1.11
	--TREASURE_FISHNODE_TRIGGER3	= "стая"; -- swarm
	--TREASURE_FISHNODE_TRIGGER4	= "косяк"; -- school
	TREASURE_FISHNODE_TRIGGER5	= " Плавающие обломки";
	TREASURE_FISHNODE_TRIGGER6	= " Нефтяное пятно";
	--TREASURE_FISHNODE_TRIGGER7	= "пятно элементарной воды";

	TREASURE_FISHNODE		= " Стая рыбы"
	TREASURE_FISHWRECK		= " Плавающие обломки";
	TREASURE_FISHELEM		= " Элементиевая вода";

	GATHERER_ReceivesLoot		= "Ваша добыча: (.+)%.";

	TREASURE_REGEX = {
		[1] = " ([^ ]+)$",
		[2] = "^([^ ]+)",
		[3] = "([^ ]+) ([^ ]+) ",
	};

	function Gatherer_FindOreType(input)


	-- ORE_COPPER    ="Медная жила"
	-- ORE_TIN       ="Оловянная жила"
	-- ORE_IRON      ="Залежи железа"
	-- ORE_SILVER    ="Серебряная жила"
	-- -- Покрытая слизью серебряная жила
	-- ORE_TRUESILVER="Руда истинного серебра"
	-- -- Покрытые слизью залежи истинного серебра
	-- ORE_GOLD      ="Золотая жила"
	-- -- Покрытая слизью золотая жила
	-- ORE_MITHRIL   ="Мифриловые залежи"
	-- -- Покрытые слизью мифриловые залежи	
	-- ORE_THORIUM   ="Ториевая жила"
	-- -- Малая ториевая жила
	-- -- Покрытая слизью ториевая жила
	-- -- Богатая ториевая жила
	-- -- Покрытая слизью богатая ториевая жила
	-- ORE_RTHORIUM  ="Богатая ториевая жила"
	-- ORE_DARKIRON  ="Залежи черного железа"
		if ( string.find(input, "едная") and string.find(input, "жила") ) then 
			return ORE_COPPER;
		end;
		
		if ( string.find(input, "ловянная") and string.find(input, "жила") ) then 
			return ORE_TIN;
		end;

		if ( string.find(input, "алежи") and string.find(input, "железа") ) then 
			return ORE_IRON;
		end;
		
		if ( string.find(input, "еребряная") and string.find(input, "жила") ) then 
			return ORE_SILVER;
		end;

		if ( string.find(input, "истинного") and string.find(input, "серебра") ) then -- truesilver
			return ORE_TRUESILVER;
		end;
		
		if ( string.find(input, "олотая") and string.find(input, "жила") ) then  -- gold
			return ORE_GOLD;
		end;
		
		if ( string.find(input, "ифриловые") and string.find(input, "залежи") ) then -- mithril
			return ORE_MITHRIL;
		end;
		
		--
		if ( string.find(input, "Богатая") and string.find(input, "ториевая") ) then -- thorium
			return ORE_RTHORIUM;
		end;

		if string.find(input, "ториевая") then 
			return ORE_THORIUM;
		end;
			
		if ( string.find(input, "черного") and string.find(input, "железа") ) then 	-- dark iron
                        return ORE_DARKIRON;
                	end
	end

	function Gatherer_FindTreasureType(input)
		-- Gatherer_Print(in_input);
		-- Gatherer_Print(TREASURE_CLAM);

		--local iconName, input;

		-- input = string.gsub(in_input, GATHERER_NOTEXT, "")
		if string.find(input, "Гигантский моллюск") then
			return TREASURE_CLAM; 
		end

		if string.find(input, "Добротный сундук") or string.find(input, "Сундук") or string.find(input, "сундук") then
			return TREASURE_CHEST; 
		end

		if string.find(input, "Ящик") or string.find(input, "ящик") then
			return TREASURE_CRATE; 
		end

		if string.find(input, "Кровь героев") then
			return TREASURE_BLOODHERO; 
		end
		
		if string.find(input, "Почва Ун'Горо") or string.find(input, "Куча земли Ун'Горо") then 
			return TREASURE_UNGOROSOIL; 
		end

		if string.find(input, "Побег кровоцвета") then
			return TREASURE_BLOODPETAL; 
		end
		
		if string.find(input, "кристалл силы") or string.find(input, "Кристалл силы") then
			return TREASURE_POWERCRYST; 
		end

		if string.find(input, "Ночной дракон") then
			return TREASURE_NIGHTDRAGON; 
		end

		if string.find(input, "Гнилой кнутокорень") then
			return TREASURE_WHIPPERROOT; 
		end
		
		if string.find(input, "Оскверненный ветроцвет") then
			return TREASURE_WINDBLOSSOM; 
		end
		
		if string.find(input, "Оскверненный песнецвет") then
			return TREASURE_SONGFLOWER; 
		end

		return;
	end

-- ************************************************************************************************
-- Common Values, Functions

TYPE_RARE		= "Редкое";


function Gatherer_ExtractItemFromTooltip()
	local extractedString = GameTooltipTextLeft1:GetText()
	--Gatherer_Print(extractedString);
	if ( extractedString ) then
		return string.lower(GameTooltipTextLeft1:GetText());
	else
		return "";
	end
end


	-- TREASURE_FISHNODE_TRIGGER5	= " Плавающие обломки";
	-- TREASURE_FISHNODE_TRIGGER6	= " Нефтяное пятно";
	-- --TREASURE_FISHNODE_TRIGGER7	= "пятно элементарной воды";

	-- TREASURE_FISHNODE		= " стая"
	-- TREASURE_FISHWRECK		= " косяк";
	-- TREASURE_FISHELEM		= " Элементиевая вода";

function Gatherer_FindFishType(fishTooltip)
	--if (fishTooltip) then Gatherer_Print("DEBUG: fishTooltip="..fishTooltip); end;
	--fishTooltipL = strlower(fishTooltip);
	if (strfind(fishTooltip, "обломки")) or (strfind(fishTooltip, "нефтяное пятно")) then return TREASURE_FISHWRECK; end
	if (strfind(fishTooltip, "рыбы")) or (strfind(fishTooltip, "косяк")) or (strfind(fishTooltip, "Косяк")) then return TREASURE_FISHNODE; 

	else


		-- if (strfind(fishTooltip, TREASURE_FISHNODE_TRIGGER1)) then
		-- return TREASURE_FISHWRECK;
		-- -- Fish School
		-- elseif ( fishTooltip and (strfind(fishTooltip, TREASURE_FISHNODE_TRIGGER4) or 
		-- 			(TREASURE_FISHNODE_TRIGGER3 and strfind(fishTooltip, TREASURE_FISHNODE_TRIGGER3))))
		-- then
		-- 	return TREASURE_FISHNODE;
		-- -- Floating Wreckage and Oil Spill
		-- elseif ( fishTooltip and 
		-- 		 (strfind(fishTooltip, TREASURE_FISHNODE_TRIGGER5) or
		-- 		  strfind(fishTooltip, TREASURE_FISHNODE_TRIGGER6)))
		-- then
		-- 	return TREASURE_FISHWRECK;
		-- -- Elemental Water
		-- elseif ( fishTooltip and strfind(fishTooltip, TREASURE_FISHNODE_TRIGGER7) ) 
		-- then
		-- 	return TREASURE_FISHELEM;
		-- end
		return nil;
	end
end

function Gatherer_FindHerbType(input)

	input = " "..input

	if  string.find(input, HERB_ARTHASTEAR) then
		return HERB_ARTHASTEAR;
	end
	if  string.find(input, HERB_BLACKLOTUS) then
		return HERB_BLACKLOTUS;
	end
	if  string.find(input, HERB_BLINDWEED) then
		return HERB_BLINDWEED;
	end
	if  string.find(input, HERB_BRIARTHORN) then
		return HERB_BRIARTHORN;
	end
	if  string.find(input, HERB_BRUISEWEED) then
		return HERB_BRUISEWEED;
	end
	if  string.find(input, HERB_DREAMFOIL) then
		return HERB_DREAMFOIL;
	end
	if  string.find(input, HERB_EARTHROOT) then
		return HERB_EARTHROOT;
	end
	if  string.find(input, HERB_FADELEAF) then
		return HERB_FADELEAF;
	end
	if  string.find(input, HERB_FIREBLOOM) then
		return HERB_FIREBLOOM;
	end
	if  string.find(input, HERB_GHOSTMUSHROOM) then
		return HERB_GHOSTMUSHROOM;
	end
	if  string.find(input, HERB_GOLDENSANSAM) then
		return HERB_GOLDENSANSAM;
	end
	if  string.find(input, HERB_GOLDTHORN) then
		return HERB_GOLDTHORN;
	end
	if  string.find(input, HERB_GRAVEMOSS) then
		return HERB_GRAVEMOSS;
	end
	if  string.find(input, HERB_GROMSBLOOD) then
		return HERB_GROMSBLOOD;
	end
	if  string.find(input, HERB_ICECAP) then
		return HERB_ICECAP;
	end
	if  string.find(input, HERB_KHADGARSWHISKER) then
		return HERB_KHADGARSWHISKER;
	end
	if  string.find(input, HERB_KINGSBLOOD) then
		return HERB_KINGSBLOOD;
	end
	if  string.find(input, HERB_LIFEROOT) then
		return HERB_LIFEROOT;
	end
	if  string.find(input, HERB_MAGEROYAL) then
		return HERB_MAGEROYAL;
	end
	if  string.find(input, HERB_MOUNTAINSILVERSAGE) then
		return HERB_MOUNTAINSILVERSAGE;
	end
	if  string.find(input, HERB_PEACEBLOOM) then
		return HERB_PEACEBLOOM;
	end
	if  string.find(input, HERB_PLAGUEBLOOM) then
		return HERB_PLAGUEBLOOM;
	end
	if  string.find(input, HERB_PURPLELOTUS) then
		return HERB_PURPLELOTUS;
	end
	if  string.find(input, HERB_SILVERLEAF) then
		return HERB_SILVERLEAF;
	end
	if  string.find(input, HERB_STRANGLEKELP) then
		return HERB_STRANGLEKELP;
	end
	if  string.find(input, HERB_SUNGRASS) then
		return HERB_SUNGRASS;
	end
	if  string.find(input, HERB_SWIFTTHISTLE) then
		return HERB_SWIFTTHISTLE;
	end
	if  string.find(input, HERB_WILDSTEELBLOOM) then
		return HERB_WILDSTEELBLOOM;
	end
	if  string.find(input, HERB_WINTERSBITE) then
		return HERB_WINTERSBITE;
	end
	if  string.find(input, HERB_WILDVINE) then
		return HERB_WILDVINE;
	else
		return nil;
	end
end
