--------------------------------------------------------------------------------
-- SmartRestore
-- Item List Database
--------------------------------------------------------------------------------
SmartRestore_Category_Info = 
{
	["ALTERAC_BANDAGES"] = {},
	["ANTIVENOM"] = {},
	["ARATHI_BANDAGES"] = {	},
	["BANDAGES"] = {},
	["FOOD"] = {},
	["FOOD_ARATHI"] = {	},
	["FOOD_BUFF"] = {	},
	["FOOD_BUFF_DYNAMIC"] = {	},
	["FOOD_CONJURED"] = {},
	["FOOD_COOKING"] = {},
	["FOOD_DYNAMIC"] = {},
	["FOOD_PET_BREAD"] = {},
	["FOOD_PET_CHEESE"] = {},
	["FOOD_PET_FISH"] = {},
	["FOOD_PET_FRUIT"] = {},
	["FOOD_PET_FUNGUS"] = {},
	["FOOD_PET_MEAT"] = {},
	["FOOD_WARSONG"] = {},
	["FOOD_WATER"] = {	},
	["FOOD_WATER_BUFF"] = {	},
	["FOOD_WATER_COOKING"] = {	},
	["FOOD_WATER_DYNAMIC"] = {	},
	["HEALTHSTONE"] = {},
	["HEALPOTIONS"] = {	},
	["MANAPOTIONS"] = {	},
	["MANASTONE"] = {},
	["PVP_HEALPOTIONS"] = {	},
	["PVP_MANAPOTIONS"] = {	},
	["REJUVENATION_POTIONS"] = {},
	["WARSONG_BANDAGES"] = {},
	["WATER"] = {},
	["WATER_DYNAMIC"] = {},
	["WATER_BUFF"] = {},
	["WATER_CONJURED"] = {},
	["WATER_SPIRIT"] = {},
	
};

-- BANDAGES

SmartRestore_Category_Info["BANDAGES"] = 
{
		1251,	-- Linen Bandage
		2581,	-- Heavy Linen Bandage
		3530,	-- Wool Bandage
		3531,	-- Heavy Wool Bandage
		6450,	-- Silk Bandage
		6451,	-- Heavy Silk Bandage
		8544,	-- Mageweave Bandage
		8545,	-- Heavy Mageweave Bandage
		14529,	-- Runecloth Bandage
		14530,	-- Heavy Runecloth Bandage
};

SmartRestore_Category_Info["WARSONG_BANDAGES"] = 
{
		19066,	-- Warsong Gulch Runecloth Bandage
		19067,	-- Warsong Gulch Mageweave Bandage
		19068,	-- Warsong Gulch Silk Bandage
};

SmartRestore_Category_Info["ARATHI_BANDAGES"] = 
{
		20065,	-- Arathi Basin Mageweave Bandage
		20066,	-- Arathi Basin Runecloth Bandage
		20067,	-- Arathi Basin Silk Bandage
		20232,	-- Defiler's Mageweave Bandage
		20234,	-- Defiler's Runecloth Bandage
		20235,	-- Defiler's Silk Bandage
		20237,	-- Highlander's Mageweave Bandage
		20243,	-- Highlander's Runecloth Bandage
		20244,	-- Highlander's Silk Bandage
};

SmartRestore_Category_Info["ALTERAC_BANDAGES"] = 
{
		19307,	-- Alterac Heavy Runecloth Bandage
};

-- HEALTH

SmartRestore_Category_Info["HEALPOTIONS"] = 
{
		118,	-- Minor Healing Potion
		858,	-- Lesser Healing Potion
		929,	-- Healing Potion
		1710,	-- Greater Healing Potion
		3928,	-- Superior Healing Potion
		4596,	-- Discolored Healing Potion
		11951, 	-- Whipper Root Tuber 
		13446,	-- Major Healing Potion
};

SmartRestore_Category_Info["PVP_HEALPOTIONS"] = 
{
		17348,	-- Major Healing Draught
		17349,	-- Superior Healing Draught
};

SmartRestore_Category_Info["REJUVENATION_POTIONS"] = 
{
		2456,	-- Minor Rejuvenation Potion
		9144,	-- Wildvine Potion
		11952,	-- Night Dragon's Breath
		18253,	-- Major Rejuvenation Potion
};
SmartRestore_Category_Info["HEALTHSTONE"] = 
{
		5509,	-- Healthstone
		5510,	-- Greater Healthstone
		5511,	-- Lesser Healthstone
		5512,	-- Minor Healthstone
		9421,	-- Major Healthstone
		19004,	-- 1pt Talent improved Minor Healthstone
		19005,	-- 2pt Talent improved Minor Healthstone
		19006,	-- Talent improved Lesser Healthstone
		19007,	-- 1pt 2pt Talent improved Lesser Healthstone
		19008,	-- 1pt Talent improved Healthstone
		19009,	-- 2pt Talent improved Healthstone
		19010,	-- 1pt Talent improved Greater Healthstone
		19011,	-- 2pt Talent improved Greater Healthstone
		19012,	-- 1pt Talent improved Major Healthstone
		19013,	-- 2pt Talent improved Major Healthstone
};

-- MANA 

SmartRestore_Category_Info["MANAPOTIONS"] = 
{
		2455,	-- Minor Mana Potion
		3385,	-- Lesser Mana Potion
		3827,	-- Mana Potion
		6149,	-- Greater Mana Potion
		13443,	-- Superior Mana Potion
		13444,	-- Major Mana Potion
		18841, 	-- Combat Mana Potion
};

SmartRestore_Category_Info["PVP_MANAPOTIONS"] = 
{
	 	17351,	-- Major Mana Draught
	 	17352,	-- Superior Mana Draught
};

SmartRestore_Category_Info["MANASTONE"] = 
{
		5513,	-- Mana Jade
		5514,	-- Mana Agate
		8007,	-- Mana Citrine
		8008,	-- Mana Ruby
};

-- WATER

SmartRestore_Category_Info["WATER"] = 
{
		159,	-- Refreshing Spring Water		
		1179,	-- Ice Cold Milk
		1205,	-- Melon Juice
		1645,	-- Moonberry Juice              
		1708,	-- Sweet Nectar
		4791,	-- Enchanted Water
		8766,	-- Morning Glory Dew        	
		9451,	-- Bubbling Water
		10841,	-- Goldthorn Tea                
		23161,	-- Freshly-Squeezed Lemonade	
};

SmartRestore_Category_Info["WATER_DYNAMIC"] = 
{
	19997,	-- Harvest Nectar
};

SmartRestore_Category_Info["WATER_BUFF"] = 
{				
		13813,	-- Blessed Sunfruit Juice		
		19318,	-- Bottled Alterac Spring Water 
};

SmartRestore_Category_Info["WATER_CONJURED"] = 
{
		2136,	-- Conjured Purified Water
		2288,	-- Conjured Fresh Water
		3772,	-- Conjured Spring Water
		5350,	-- Conjured Water
		8077,	-- Conjured Mineral Water
		8078,	-- Conjured Sparkling Water
		8079,	-- Conjured Crystal Water
};

-- COMBO FOOD

SmartRestore_Category_Info["FOOD_WATER"] = 
{
		3448,	-- Senggin Root				
		13724,  -- Enriched Manna Biscuit   
		19301,  -- Alterac Manna Biscuit    
		20031,  -- Essence Mango            
};

SmartRestore_Category_Info["FOOD_WATER_DYNAMIC"] = 
{
		20388, 	-- Lollipop
		20389,	-- Candy Corn
		20390,	-- Candy Bar
};

SmartRestore_Category_Info["FOOD_WATER_BUFF"] = 
{		
		21072,	-- Smoked Sagefish	
		21217,	-- Sagefish Delight	
};

SmartRestore_Category_Info["FOOD_WATER_COOKING"] = 
{
		21071, -- Raw Sagefish
		21153, -- Raw Greater Sagefish
};

-- FOOD

SmartRestore_Category_Info["FOOD_CONJURED"] = 
{
		1113,	-- Conjured Bread			
		1114,	-- Conjured Rye 			
		1487,	-- Conjured Pumpernickel 	
		5349,	-- Conjured Muffin			
		8075,	-- Conjured Sourdough		
		8076,	-- Conjured Sweet Roll		
		22895,	-- Conjured Cinnamon Roll	
};

SmartRestore_Category_Info["FOOD"] = 
{
		117,	-- Tough Jerky				
		414,	-- Dalaran Sharp			
		422,	-- Dwarven Mild				
		733,	-- Westfall Stew			
		787,	-- Slitherskin Mackerel		
		961,	-- Healing Herb
		1326,	-- Sauteed Sunfish 
		1707,	-- Stormwind Brie 			
		2070,	-- Darnassian Bleu			
		2287,	-- Haunch of Meat			
		2679,	-- Charred Wolf Meat		
		2681,	-- Roasted Boar Meat		
		2682,	-- Cooked Crab Claw			
		2684,	-- Coyote Steak				
		2685,	-- Succulent Pork Ribs		
		3770,	-- Mutton Chop				
		3771,	-- Wild Hog Shank 			
		3927,	-- Fine Aged Cheddar		
		4536,	-- Shiny Red Apple			
		4537,	-- Tel'Abim Banana			
		4538,	-- Snapvine Watermelon		
		4539,	-- Goldenbark Apple 		
		4540,	-- Tough Hunk of Bread		
		4541,	-- Freshly Baked Bread		
		4542,	-- Moist Cornbread			
		4544,	-- Mulgore Spice Bread 		
		4592,	-- Longjaw Mud Snapper		
		4593,	-- Bristle Whisker Catfish 	
		4594,	-- Rockscale Cod			
		4599,	-- Cured Ham Steak 			
		4601,	-- Soft Banana Bread		
		4602,	-- Moon Harvest Pumpkin		
		4604,	-- Forest Mushroom Cap		
		4605,	-- Red-speckled Mushroom	
		4606,	-- Spongy Morel				
		4607,	-- Delicious Cave Mold		
		4608,	-- Raw Black Truffle 		
		4656,	-- Small Pumpkin
		5057,	-- Ripe Watermelon
		5095,	-- Rainbow Fin Albacore		
		5473,	-- Scorpid Surprise			
		5478,	-- Dig Rat Stew				
		5525,	-- Boiled Clams				
		5526,	-- Clam Chowder				
		6290,	-- Brilliant Smallfish		
		6316,	-- Loch Frenzy Delight		
		6807,	-- Frog Leg Stew
		6887,	-- Spotted Yellowtail		
		6890,	-- Smoked Bear Meat			
		7097, 	-- Leg Meat
		7228,	-- Tigule and Foror's Strawberry Ice Cream
		8364,	-- Mithril Head Trout 			
		8683,	-- Clara's Fresh Apple
		8932,	-- Alterac Swiss 			
		8948,	-- Dried King Bolete 		
		8950,	-- Homemade Cherry Pie 		
		8952,	-- Roasted Quail 			
		8953,	-- Deep Fried Plantains		
		8957,	-- Spinefin Halibut			
		9681,	-- Grilled King Crawler Legs
		11444,	-- Grim Guzzler Boar
		12238, 	-- Darkshore Grouper
		13546,	-- Bloodbelly Fish		
		13889,	-- Raw Whitescale Salmon			
		13930,	-- Filet of Redgill			
		13933,	-- Lobster Stew				
		13935,	-- Baked Salmon				
		16166,	-- Bean Soup				
		16167,	-- Versicolor Treat			
		16168,	-- Heaven Peach				
		16169,	-- Wild Ricecake			
		16170,	-- Steamed Mandu					
		16171,	-- Shinsollo				
		16766,	-- Undermine Clam Chowder	
		17119, 	-- Deeprun Rat Kabob 
		17344,	-- Candy Cane
		17406,	-- Holiday Cheesewheel
		17407,	-- Graccu's Homemade Meat Pie
		17408,	-- Spicy Beefstick
		18632,	-- Moonbrook Riot Taffy
		18633,	-- Styleen's Sour Suckerpop
		18635,	-- Bellara's Nutterbar
		19223,	-- Darkmoon Dog
		19224, 	-- Red Hot Wings
		19225,	-- Deep Fried Candybar
		19304,	-- Spiced Beef Jerky
		19305, 	-- Pickled Kodo Foot
		19306,	-- Crunchy Frog
		21030, 	-- Darnassus Kimchi Pie
		21031,	-- Cabbage Kimchi
		21033,	-- Radish Kimchi
		21235,	-- Winter Veil Roast
		21537, 	-- Festival Dumplings
		21552,	-- Striped Yellowtail
		22324,	-- Winter Kimchi
		23160,	-- Friendship Bread				
};

SmartRestore_Category_Info["FOOD_DYNAMIC"] = 
{
		19696,	-- Harvest Bread
		19994,	-- Harvest Fruit
		19995,	-- Harvest Boar
		19996,	-- Harvest Fish	
};

SmartRestore_Category_Info["FOOD_BUFF"] = 
{			
		724,	-- Goretusk Liver Pie	
		1017,	-- Seasoned Wolf Kabob	
		1082,	-- Redridge Goulash		
		2680,	-- Spiced Wolf Meat		
		2683,	-- Crab Cake			
		2687,	-- Dry Pork Ribso		
		2888,	-- Beer Basted Boar Ribs
		3220,	-- Blood Sausage		
		3662,	-- Crocolisk Steako		
		3663,	-- Murloc Fin Soup		
		3664,	-- Crocolisk Gumbo		
		3665,	-- Curiously Tasty Omel	
		3666,	-- Gooey Spider Cake	
		3726,	-- Big Bear Steak		
		3727,	-- Hot Lion Chops		
		3728,	-- Tasty Lion Steak	
		3729,	-- Soothing Turtle Bisque
		4457,	-- Barbecued Buzzard Wing 
		5472,	-- Kaldorei Spider Kabo	
		5474,	-- Roasted Kodo Meat	
		5476,	-- Fillet of Frenzy		
		5477,	-- Strider Stew			
		5479,	-- Crispy Lizard Tail	
		5480,	-- Lean Venison			
		5527,	-- Goblin Deviled Clams	
		6038,	-- Giant Clam Scorcho	
		6888,	-- Herb Baked Egg		
		7806,	-- Lollipop
		7807,	-- Candy Bar
		7808,	-- Chocolate Square		
		11584,	-- Cactus Apple Surprise
		11950,	-- Windblossom Berries	
		12209,	-- Lean Wolf Steak		
		12210,	-- Roast Raptor			
		12212,	-- Jungle Stew			
		12213,	-- Carrion Surprise		
		12214,	-- Mystery Stew			
		12215,	-- Heavy Kodo Stew		
		12216,	-- Spider Chilli Crab	
		12218,	-- Monster Omlette		
		12224,	-- Crispy Bat Wing		
		13810,	-- Blessed Sunfruit 
		13851,	-- Hot Wolf Ribs		
		13927,	-- Cooked Glossy Mightfi
		13928,	-- Grilled Squid	
		13929,	-- Hot Smoked Bass		
		13931,	-- Nightfin Soup	
		13932,	-- Poached Sunscale Salmon	
		13934,	-- Mightfish Steak		
		16971,	-- Clamlette Surprise 	
		17197,	-- Gingerbread Cookie	
		17198,	-- Egg Nog				
		17222,	-- Spider Sausage 		
		18045,	-- Tender Wolf Steak	
		18254,	-- Runn Tum Tuber Surpris
		20074,  -- Heavy Crocolisk Stew
		20452,	-- Smoked Desert Dumpling
		21023,	-- Dirge's Kickin' Chimaerok Chops
		21254, 	-- Winter Veil Cookie 
};


SmartRestore_Category_Info["FOOD_BUFF_DYNAMIC"] = 
{
		20516,	-- Bobbing Apple
};

SmartRestore_Category_Info["FOOD_COOKING"] = 
{
		4603,	--	Raw Spotted Yellowtail		
		6289,	--	Raw Longjaw Mud Snapper		
		6291,	--	Raw Brilliant Smallfish		
		6303,	--	Raw Slitherskin Mackerel		
		6308,	--	Raw Bristle Whisker Catfish		
		6317,	--	Raw Loch Frenzy		
		6361,	--	Raw Rainbow Fin Albacore		
		6362,	--	Raw Rockscale Cod		
		8365,	--	Raw Mithril Head Trout		
		8959,	--	Raw Spinefin Halibut		
		13754,	--	Raw Glossy Mightfish		
		13755,	--	Winter Squid		
		13756,	--	Raw Summer Bass		
		13758,	--	Raw Redgill		
		13759,	--	Raw Nightfin Snapper	
		13760,	--	Raw Sunscale Salmon		
		13888,  --  Darkclaw Lobster
		13893,	--	Large Raw Mightfish		
		18255,	--  Runn Tum Tuber	-- Uncooked
};

-- BG FOOD

SmartRestore_Category_Info["FOOD_ARATHI"] = 
{
		20062,	-- Arathi Basin Enriched Ration
		20222, 	-- Defiler's Enriched Ration
		20223, 	-- Defiler's Field Ration
		20224,	-- Defiler's Iron Ration
		20225, 	-- Highlander's Enriched Ration
		20226,	-- Highlander's Field Ration
		20227,	-- Highlander's Iron Ration 
};
	
SmartRestore_Category_Info["FOOD_WARSONG"] = 
{
		19060, 	-- Warsong Gulch Enriched Ration
		19061, 	-- Warsong Gulch Iron Ration
		19062, 	-- Warsong Gulch Field Ration
};

-- MISC

SmartRestore_Category_Info["ANTIVENOM"] = 
{
		6452,	-- Anti-Venom				
		6453,	-- Strong Anti-Venom		
		19440,	-- Powerful Anti-Venom		
};

-- PET FOOD

SmartRestore_Category_Info["FOOD_PET_BREAD"] = {
		5349,	-- Conjured Muffin			
		4540,	-- Tough Hunk of Bread		
		17197,	-- Gingerbread Cookie		
		1113,	-- Conjured Bread			
		2683,	-- Crab Cake				
		4541,	-- Freshly Baked Bread		
		1114,	-- Conjured Rye				
		4542,	-- Moist Cornbread			
		1487,	-- Conjured Pumpernickel	
		4544,	-- Mulgore Spice Bread 		
		16169,	-- Wild Ricecake 			
		8075,	-- Conjured Sourdough		
		4601,	-- Soft Banana Bread		
		8076,	-- Conjured Sweet Roll		
		23160,	-- Friendship Bread			
		8950,	-- Homemade Cherry Pie 		
		22895,	-- Conjured Cinnamon Roll	
};
SmartRestore_Category_Info["FOOD_PET_CHEESE"] = {
		2070,	-- Darnassian Bleu			
		414,	-- Dalaran Sharp			
		422,	-- Dwarven Mild				
		1707,	-- Stormwind Brie 			
		3927,	-- Fine Aged Cheddar		
		8932,	-- Alterac Swiss 			
};
SmartRestore_Category_Info["FOOD_PET_FISH"] = {
		13889,		--	Raw Whitescale Salmon		
		19996,		--	Harvest Fish
		13935,	--	Baked Salmon		
		13933,    --    Lobster Stew
		13888,    --    Darkclaw Lobster
		13935,	--	Baked Salmon		
		13546,	--	Bloodbelly Fish		
		6290,		--	Brilliant Smallfish		
		4593,		--	Bristle Whisker Catfish		
		5503,		--	Clam Meat		
		16971,	--	Clamlette Surprise		
		2682,		--	Cooked Crab Claw		
		13927,	--	Cooked Glossy Mightfish		
		2675,		--	Crawler Claw		
		13930,	--	Filet of Redgill		
		5476,		--	Fillet of Frenzy		
		4655,		--	Giant Clam Meat		
		6038,		--	Giant Clam Scorcho		
		13928,	--	Grilled Squid		
		13929,	--	Hot Smoked Bass		
		13893,	--	Large Raw Mightfish		
		4592,		--	Longjaw Mud Snapper		
		8364,		--	Mithril Head Trout		
		13932,	--	Poached Sunscale Salmon		
		5095,		--	Rainbow Fin Albacore		
		6291,		--	Raw Brilliant Smallfish		
		6308,		--	Raw Bristle Whisker Catfish		
		13754,	--	Raw Glossy Mightfish		
		6317,		--	Raw Loch Frenzy		
		6289,		--	Raw Longjaw Mud Snapper		
		8365,		--	Raw Mithril Head Trout		
		6361,		--	Raw Rainbow Fin Albacore		
		13758,	--	Raw Redgill		
		6362,		--	Raw Rockscale Cod		
		6303,		--	Raw Slitherskin Mackerel		
		8959,		--	Raw Spinefin Halibut		
		4603,		--	Raw Spotted Yellowtail		
		13756,	--	Raw Summer Bass		
		13760,	--	Raw Sunscale Salmon		
		4594,		--	Rockscale Cod		
		787,		--	Slitherskin Mackerel		
		5468,		--	Soft Frenzy Flesh		
		15924,	--	Soft-shelled Clam Meat		
		12216,	--	Spiced Chili Crab		
		8957,		--	Spinefin Halibut		
		6887,		--	Spotted Yellowtail		
		5504,		--	Tangy Clam Meat		
		12206,	--	Tender Crab Meat		
		13755,	--	Winter Squid		
		7974,		--	Zesty Clam Meat		
};
SmartRestore_Category_Info["FOOD_PET_FRUIT"] = {
		19994,		--	Harvest Fruit		
		8953,		--	Deep Fried Plantains		
		4539,		--	Goldenbark Apple		
		16168,	--	Heaven Peach		
		4602,		--	Moon Harvest Pumpkin		
		4536,		--	Shiny Red Apple		
		4538,		--	Snapvine Watermelon		
		4537,		--	Tel'Abim Banana		
		11950,	--	Windblossom Berries					
};

SmartRestore_Category_Info["FOOD_PET_FUNGUS"] = {
		3448,	--	Senggin Root		
		4604,	-- Forest Mushroom Cap				
		4605,	-- Red-speckled Mushroom			
		4606,	-- Spongy Morel						
		4607,	-- Delicious Cave Mold				
		4608,	-- Raw Black Truffle 				
		8948,	-- Dried King Bolete 				
};

SmartRestore_Category_Info["FOOD_PET_MEAT"] = {
		21235,		--	Winter Veil Roast
		19995,		--	Harvest Boar			
		4457,		--	Barbecued Buzzard Wing		
		3173,		--	Bear Meat		
		2888,		--	Beer Basted Boar Ribs		
		3730,		--	Big Bear Meat		
		3726,		--	Big Bear Steak		
		3220,		--	Blood Sausage		
		2677,		--	Boar Ribs		
		3404,		--	Buzzard Wing		
		12213,	--	Carrion Surprise		
		2679,		--	Charred Wolf Meat		
		769,		--	Chunk of Boar Meat		
		2673,		--	Coyote Meat		
		2684,		--	Coyote Steak		
		1081,		--	Crisp Spider Meat		
		12224,	--	Crispy Bat Wing		
		5479,		--	Crispy Lizard Tail		
		2924,		--	Crocolisk Meat		
		3662,		--	Crocolisk Steak		
		4599,		--	Cured Ham Steak		
		17119,	--	Deeprun Rat Kabob		
		5478,		--	Dig Rat Stew		
		5051,		--	Dig Rat		
		2687,		--	Dry Pork Ribs		
		9681,		--	Grilled King Crawler Legs		
		2287,		--	Haunch of Meat		
		12204,	--	Heavy Kodo Meat		
		3727,		--	Hot Lion Chops		
		13851,	--	Hot Wolf Ribs		
		12212,	--	Jungle Stew		
		5472,		--	Kaldorei Spider Kabob		
		5467,		--	Kodo Meat		
		5480,		--	Lean Venison		
		1015,		--	Lean Wolf Flank		
		12209,	--	Lean Wolf Steak		
		3731,		--	Lion Meat		
		12223,	--	Meaty Bat Wing		
		3770,		--	Mutton Chop		
		12037,	--	Mystery Meat		
		4739,		--	Plainstrider Meat		
		12184,	--	Raptor Flesh		
		13759,	--	Raw Nightfin Snapper		
		12203,	--	Red Wolf Meat		
		12210,	--	Roast Raptor		
		2681,		--	Roasted Boar Meat		
		5474,		--	Roasted Kodo Meat		
		8952,		--	Roasted Quail		
		1017,		--	Seasoned Wolf Kabob		
		5465,		--	Small Spider Leg		
		6890,		--	Smoked Bear Meat		
		3729,		--	Soothing Turtle Bisque		
		2680,		--	Spiced Wolf Meat		
		17222,	--	Spider Sausage		
		5471,		--	Stag Meat		
		5469,		--	Strider Meat		
		5477,		--	Strider Stew		
		2672,		--	Stringy Wolf Meat		
		2685,		--	Succulent Pork Ribs		
		3728,		--	Tasty Lion Steak		
		3667,		--	Tender Crocolisk Meat		
		12208,	--	Tender Wolf Meat		
		18045,	--	Tender Wolf Steak		
		5470,		--	Thunder Lizard Tail		
		12202,	--	Tiger Meat		
		117,		--	Tough Jerky		
		3712,		--	Turtle Meat		
		12205,	--	White Spider Meat		
		3771,		--	Wild Hog Shank		
		11444,	-- Grim Guzzler Boar		
};